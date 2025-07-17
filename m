Return-Path: <linux-kernel+bounces-735661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ADBB0923E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D869C5A1397
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1B2FCE30;
	Thu, 17 Jul 2025 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gd3+WcQn"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF22F6FAD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771114; cv=none; b=ZlY+lxlMyRP3SKQ9jLgpQjugX23TliJq/N5nNIX+ynQU2NV5WInydx/87PehBfWMacTPhb/BplOENpd4jI9+8vlBw5Mhfs9YILGARp3o/fNCfxtPoD5rA/5TTckdoVFqo8qCXHgU8PFYlxtsaQPqc+rtEJkyDSsCUDTlP+yMHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771114; c=relaxed/simple;
	bh=pdyBXBMiMUEiDiEad+NOBRBs5c1GLfXqAPLM6bZSSlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6Y3fF9HubnAYK9MqiHomy3SmWjKq//TC+lrULhhrDppolaXL1Ql1xVROzb0khJBA2TexQ96xxKEZvIZGJDYp1vCenoIZ7NcgxmpTvPRaoQ68WacFwT5kl2GSOyCg97Uduhw5FUTrVIdxKsUkY0FsgBLamdJMQveQ4+NOBJ1ChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gd3+WcQn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3134c67a173so1174816a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752771112; x=1753375912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6G290XDUkNk/Jux66myc1/yoqaFjAzP1D+BTC8pjZM=;
        b=gd3+WcQnnTJuqIV6y7yUs9b5LIc5tLzhjmomCSG3DzONbsaxAJpawjRcxRF68EzrNk
         64oH8pQZWptHuWDgnDaq+oGiRL3DER7uj++ZlV89snYSAsm1p4R0fSKR5/LInA2073Nf
         KesIQ+zzbZLMjoQTxOnX5psWgtK523j+4jWIPiICR+VoUFEkCWXK2oWJxbK8hvQLGjFB
         UM1bgDykd9lNuf+HNmbj3eir9zO0mKMnMjIkGwlSXhEbfy+vbahl5tkX7HmYlbdVmgqe
         r5X5r3wKO7b1/beVWikcvFvLhaOggpeu+B29Bak5fYDq0XYLwOGPEzBxQbwGq7r+P3Wc
         R7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771112; x=1753375912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6G290XDUkNk/Jux66myc1/yoqaFjAzP1D+BTC8pjZM=;
        b=W+N6HshTTYdw2lTjsHpx4PCVSNsqBlIKjztwDPnFy+93oMUG+2SznhdcYEGvFkPXII
         yyO37TStdCJYB041DCNbvQ6NZdtL68fMA1dA14uKDlNx9iTAywcnhqtbXNvhwlREpLe1
         DXoxU2dsGNR8L7FnBechB4zq0mKxEOSfUY6+KCyRgyc6CE7Xo9C7t4lZbFhfB5yAhacT
         oHVmCBJ1pgnr7JZYEqLUJwb+rPOKb31w2mGT91z6LBCCsOTgETh9qaqUkD/itxTC2kF8
         AuxiiF6MGF3MxRVEUn9uvolKiJcj/DnkFQxNsYC/GmrOW43gwAllsUKs3RGLW9OOsOES
         Qh4A==
X-Forwarded-Encrypted: i=1; AJvYcCUNercwNXPz6meC0GhHmwkGp0ny9rraTo5d7MhyVjxULBx67L/w0cxXMyjFtVkUzU9PnucGBd9ceOMRWfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybKEEnTR8rf5h9gilhFrtccQyFYmWLPA/n5/lzN1WMrCV1/ff7
	niquDA9IsyMzwaFmegYAxTSqKbqoxgYn7/fEc/seN6vdX8mSH9KuE4K1d2XsAiSO5Zd7DfDJha8
	Dp6bnxC/MIliuNsHJdFdlxnI4go/5I9USzhtFDw7U
X-Gm-Gg: ASbGncudJwKJd+uh//cHlIiqewJsvuKCN+/tdrdcUNuFnG6drW5vdLmqcs01J4zihuV
	/kzASN63ffkSH/1IGLGFF9q8TTYfjzWzChqVFrHlM4mcH4CCTGhCN26NwrC1fWVoo8HgFBP3Bqy
	4DDHiJu9AwNhWICCvbUDapJYyi3kKnbEOCHjaQfVbDhqjB4GoNMYTkZc5yAbT7q6g05QkYv6Fzg
	/6iY3ipJ2/ehXDPzBN+Jw1iNSlrWJAyqrX8/A==
X-Google-Smtp-Source: AGHT+IFyz6yR0nS3sH8qQsAvcaEM466C4kperDwmL6IahuwqW8e2AlpYA/IyM/pS/RGSHIr0qg9qPSoxRAQDsUfO20g=
X-Received: by 2002:a17:90b:1848:b0:31c:bfac:9e25 with SMTP id
 98e67ed59e1d1-31cbfac9ebdmr1141164a91.14.1752771112395; Thu, 17 Jul 2025
 09:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507135431.53907-1-jose.exposito89@gmail.com> <57e425ff-2731-47d7-b5ce-c34f5baf71b4@bootlin.com>
In-Reply-To: <57e425ff-2731-47d7-b5ce-c34f5baf71b4@bootlin.com>
From: Mark Yacoub <markyacoub@google.com>
Date: Thu, 17 Jul 2025 12:51:39 -0400
X-Gm-Features: Ac12FXw9Naiqo1SXwbcsWzZsrtdE-lVZ-TVzRwHv65lGAu-rCKSRjEti2UrIOI8
Message-ID: <CAC0gqY6_6F+PFkgHm2-iMbCSxKc++DipObVK709eJrJcV7SQNQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] drm/vkms: Add configfs support
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	tzimmermann@suse.de, mripard@kernel.org, simona@ffwll.ch, 
	sebastian.wick@redhat.com, victoria@system76.com, xaver.hugl@kde.org, 
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, 
	maarten.lankhorst@linux.intel.com, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged into Android tree:
https://android-review.git.corp.google.com/c/kernel/common-modules/virtual-=
device/+/3661920
I'm able to use configfs as expected.

Tested-by: Mark Yacoub <markyacoub@google.com>


On Thu, Jul 17, 2025 at 12:37=E2=80=AFPM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> +CC: Mark (Google), Sebastian (Mutter), Xaver (KWin), Victoria (Cosmic)
>
> Hi everyone,
>
> Last week, I presented this work at the Display Next Hackfest, and the
> feedback from compositors was very positive. At least KWin, Mutter, and
> Cosmic are interested in integrating it into their tests, so it would be
> great if someone could review it.
>
> Sebastian quickly tested this work (using [2] for full features) with
> their existing VKMS tests [1], and it worked. From what I understand,
> the tests are quite basic =E2=80=94just sanity checks=E2=80=94 but we wer=
e able to
> reproduce the default vkms device using ConfigFS.
>
> If another compositor wants to test the ConfigFS interface (I will try
> to keep [2] updated), that would be amazing. Feel free to send feedback!
>
> A small note: This series has a minor conflict since the conversion to
> the faux device, but it can be applied using `b4 am -3 ... && git am -3
> ...`.
> @jos=C3=A9, if you send a new iteration, can you add markyacoub@google.co=
m in
> copy, and maybe Sebastian, Xaver, Victoria if they want to follow the
> upstreaming?
>
> Thank you,
> Louis Chauvet
>
> [1]:https://gitlab.gnome.org/swick/mutter/-/commit/88a7354942d9728dae06fb=
83cc4f2d2c7b08b694
> [2]:https://github.com/Fomys/linux/tree/configfs-everything
>
>
>
> Le 07/05/2025 =C3=A0 15:54, Jos=C3=A9 Exp=C3=B3sito a =C3=A9crit :
> > Hi everyone,
> >
> > This series allow to configure one or more VKMS instances without havin=
g
> > to reload the driver using configfs.
> >
> > The series is structured in 3 blocks:
> >
> >    - Patches 1..11: Basic device configuration. For simplicity, I kept =
the
> >      available options as minimal as possible.
> >
> >    - Patches 12 and 13: New option to skip the default device creation =
and to-do
> >      cleanup.
> >
> >    - Patches 14, 15 and 16: Allow to hot-plug and unplug connectors. Th=
is is not
> >      part of the minimal set of options, but I included in this series =
so it can
> >      be used as a template/example of how new configurations can be add=
ed.
> >
> > The process of configuring a VKMS device is documented in "vkms.rst".
> >
> > Finally, the code is thoroughly tested by a collection of IGT tests [1]=
.
> >
> > Best wishes,
> > Jos=C3=A9 Exp=C3=B3sito
> >
> > [1] https://lists.freedesktop.org/archives/igt-dev/2025-February/086071=
.html
> >
> > Changes in v5:
> >
> >    - Added Reviewed-by tags, thanks Louis!
> >    - Rebased on top of drm-misc-next
> >    - Link to v4: https://lore.kernel.org/dri-devel/20250407081425.6420-=
1-jose.exposito89@gmail.com/
> >
> > Changes in v4:
> >
> >    - Since Louis and I worked on this together, set him as the author o=
f some of
> >      the patches and me as co-developed-by to reflect this joint effort=
.
> >    - Rebased on top of drm-misc-next
> >    - Link to v3: https://lore.kernel.org/all/20250307163353.5896-1-jose=
.exposito89@gmail.com/
> >
> > Changes in v3:
> >
> >    - Applied review comments by Louis Chauvet: (thanks!!)
> >      - Use scoped_guard() instead of guard(mutex)(...)
> >      - Fix a use-after-free error in the connector hot-plug code
> >    - Rebased on top of drm-misc-next
> >    - Link to v2: https://lore.kernel.org/all/20250225175936.7223-1-jose=
.exposito89@gmail.com/
> >
> > Changes in v2:
> >
> >    - Applied review comments by Louis Chauvet:
> >      - Use guard(mutex)(...) instead of lock/unlock
> >      - Return -EBUSY when trying to modify a enabled device
> >      - Move the connector hot-plug related patches to the end
> >    - Rebased on top of drm-misc-next
> >    - Link to v1: https://lore.kernel.org/dri-devel/20250218170808.9507-=
1-jose.exposito89@gmail.com/T/
> >
> > Jos=C3=A9 Exp=C3=B3sito (6):
> >    drm/vkms: Expose device creation and destruction
> >    drm/vkms: Allow to configure the default device creation
> >    drm/vkms: Remove completed task from the TODO list
> >    drm/vkms: Allow to configure connector status
> >    drm/vkms: Allow to update the connector status
> >    drm/vkms: Allow to configure connector status via configfs
> >
> > Louis Chauvet (10):
> >    drm/vkms: Add and remove VKMS instances via configfs
> >    drm/vkms: Allow to configure multiple planes via configfs
> >    drm/vkms: Allow to configure the plane type via configfs
> >    drm/vkms: Allow to configure multiple CRTCs via configfs
> >    drm/vkms: Allow to configure CRTC writeback support via configfs
> >    drm/vkms: Allow to attach planes and CRTCs via configfs
> >    drm/vkms: Allow to configure multiple encoders via configfs
> >    drm/vkms: Allow to attach encoders and CRTCs via configfs
> >    drm/vkms: Allow to configure multiple connectors via configfs
> >    drm/vkms: Allow to attach connectors and encoders via configfs
> >
> >   Documentation/gpu/vkms.rst                    | 100 ++-
> >   drivers/gpu/drm/vkms/Kconfig                  |   1 +
> >   drivers/gpu/drm/vkms/Makefile                 |   3 +-
> >   drivers/gpu/drm/vkms/tests/vkms_config_test.c |  24 +
> >   drivers/gpu/drm/vkms/vkms_config.c            |   8 +-
> >   drivers/gpu/drm/vkms/vkms_config.h            |  26 +
> >   drivers/gpu/drm/vkms/vkms_configfs.c          | 833 +++++++++++++++++=
+
> >   drivers/gpu/drm/vkms/vkms_configfs.h          |   8 +
> >   drivers/gpu/drm/vkms/vkms_connector.c         |  35 +
> >   drivers/gpu/drm/vkms/vkms_connector.h         |   9 +
> >   drivers/gpu/drm/vkms/vkms_drv.c               |  18 +-
> >   drivers/gpu/drm/vkms/vkms_drv.h               |  20 +
> >   12 files changed, 1072 insertions(+), 13 deletions(-)
> >   create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
> >   create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.h
> >
> >
> > base-commit: a6c0a91ccb257eaec2aee080df06863ce7601315
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

