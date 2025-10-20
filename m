Return-Path: <linux-kernel+bounces-861433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFABF2BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF74B462104
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D42328B4A;
	Mon, 20 Oct 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMJZoPZm"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7223FC54
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981586; cv=none; b=XKvwXQcDk+aoiu7W/T9u0gtvOuwvyKs03hrLO6NfP1pWAbWbArewbOZVCKH9qqe+tWji8WMjipXFRvF5ClLtlQ8c6BSMbqrWxktPuug3wfewibZ1Y2bnnYj/ZLfhSKUUbcHWnmD39NHthxycaaaHzyxOZmEgPinSPuJRMAqqb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981586; c=relaxed/simple;
	bh=EoWP5ph+4UazHGdtfPd/6gdaq9UjzLY3oVxb2MBfAJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNsbLKZxxpWxO3mhtjO00xxKFLcIrASHhTCsWGbK47XI+7VrR8sqhuLayBihV5XyN7M5073TuHb2wIFt0ioASVYoJkucgdZgwCZbwN8nB3cHfYLQdN27ZZLxsIwJzbFw/bcSKDh1ONw6kL3NjRTbAuQ/6GvdFTgKzqgXYLQGAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMJZoPZm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-339a0b9ed6cso990192a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760981584; x=1761586384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI2PtJUq4Sc30HWOhQj8ldzwhG1vYDstA/zAjK88nRU=;
        b=MMJZoPZmdrl7l9jJSQVrLbGHwTRI8hN97O/dwvZdN2VM8/+NBtEFyt21EqBlXacN0a
         62c0EFFqjZvBUSaHNyJ5DxqAwzgtYMSTqXdEvZhxKGp8tBr7XUyN37WwJeo3PkYX4AY5
         XGMaDxvX6nr/I5CsQZ/zYTIPjC0WI6lU7zol5OSnnONM6hBw8MZF9asCM69Gd3lWSey1
         L4I/eIVBJZacJfTrUD/2Q6+HjHg82UNUIBB0tvpZlJBwgFT1Zcd6RTYbPpK93G2Jzk+C
         slk68dDSgXZnj2tL5JkCiJRgAL+7hJBZg7SKpu2XiSJQSGnZ4tXRds+rKJHVdq9sEcaU
         sTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760981584; x=1761586384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VI2PtJUq4Sc30HWOhQj8ldzwhG1vYDstA/zAjK88nRU=;
        b=iJC3hs6i1Sx2RWdJrYiEGLKtzOFxT+O76cDatCol+qNCiHh0nC2a58KX9zIejdOMbT
         7cR+FALUCzGCHJCriTgClmKUYI1t+XaP14y6Lx7Tpy0QBPV7cE+SMwmMIl6DwlrwJRnk
         inm8hN09e1lgRZjNSNdPaKWDIrYTjvTv6MepKBCqWPnOLOA9QWBLPTsk/bjAzoNXRwnI
         2DD7yUb5B6bW1LtgjZzSQ1we/+SSZTLwGCmDlkyTpDzwgscBAeClfePRznyTnpvMDZXg
         UloRfuorXzp4X/bl2gFw9VFoQlcPXoZaWVwRT+SDoUliUHE4XIohsZCBsbe7X7QuFKM3
         U/ow==
X-Forwarded-Encrypted: i=1; AJvYcCUL+RtWuH+cQ2BNJbm1fVbRjtYv1xpAl/4bYDNfO8rqH4v/2pVwatnXdUnx5/kaqH1Xrc07QeQkxa0ItnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8+SSEXUEOH42UwHA0FLeBy0tsumvkoDBTXtkzbmqeOjEWFLr
	mUcSRE5TPsEDpReTwdY4g9XmnA/K4vT+NJBdPg3nechO4gIH1Uj37nmVhX4XbKDJm74bJeErhpC
	YdXwWJ4mc1KVrO5W6lmadziRDULkmDOc=
X-Gm-Gg: ASbGnctIjd35bi6AT2hgmgDyY7a7tcltim/8ajaoP8R105Ca9g6J4iJwusxUox8c1HT
	VhzbWPg7UTLFXgKVXcADLeV9Wn3qJpWRwxs4pWeGihwMRgowAchu7Dk/S/aNF9AM2e7znMfxKdl
	1c/atp1fBwLZlBddLcNXk9yN53sSD+9yGdsqz86ev1XvJkW0luxW+6n3hJW2kEgHYWP1J/oXMcf
	EScy75nUYKeypoUi784z/vAwL974thtcW1BFlSa/OEusHg7NJ08+JyA3j0Xm0ENdLewYMo=
X-Google-Smtp-Source: AGHT+IFU+KqAEkbMCW8Xf53JYAtbqincSoO/rgEjO02snl6niQ+EZQMNsesNeWJPPWOHadiHVfJVBWRPjcMTziYcl0I=
X-Received: by 2002:a17:903:8c8:b0:277:c230:bfca with SMTP id
 d9443c01a7336-292d3e57324mr1368175ad.4.1760981584179; Mon, 20 Oct 2025
 10:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018054451.259432-1-daniel@0x0f.com>
In-Reply-To: <20251018054451.259432-1-daniel@0x0f.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 13:32:51 -0400
X-Gm-Features: AS18NWD66tyW2gm21ozKGA5vxvXrn7M693EyUTlpuxSeBNhOvz2jwM0dQyB4ats
Message-ID: <CADnq5_MBLAOsam77vZME=rjOoDMXL_+J+grxXVGz2ekxO=512w@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/radeon: fix up some badness when probe fails
To: Daniel Palmer <daniel@0x0f.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, wuhoipok@gmail.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Sat, Oct 18, 2025 at 1:51=E2=80=AFAM Daniel Palmer <daniel@0x0f.com> wro=
te:
>
> I have been trying to get a Radeon 9250 running on an Amiga 4000[0].
>
> On that setup it fails to find the BIOS and the probe fails which is
> expected but then a bunch of WARN_ON()s etc are triggered.
>
> I though maybe this is "m68k problems" so I bought an old x86 board and
> there if I have a different primary VGA card the BIOS part of the
> probe fails in the same way and the same scary messages[1] are showing
> up in the console.
>
> It seems like the probe failure path wasn't tested when some previous
> cleaning up happened.
>
> I'll fix the issues with not finding the BIOS if the card wasn't
> initialised in the normal x86 way later.
>
> 0 - https://lore.kernel.org/lkml/20251007092313.755856-1-daniel@thingy.jp=
/
> 1 - https://gist.github.com/fifteenhex/b971bd62c49383a0558395c62c05ce3b
>
> Daniel Palmer (3):
>   drm/radeon: Clean up pdev->dev instances in probe
>   drm/radeon: Do not kfree() devres managed rdev
>   drm/radeon: Remove calls to drm_put_dev()
>
>  drivers/gpu/drm/radeon/radeon_drv.c | 34 ++++++++---------------------
>  drivers/gpu/drm/radeon/radeon_kms.c |  1 -
>  2 files changed, 9 insertions(+), 26 deletions(-)
>
> --
> 2.51.0
>

