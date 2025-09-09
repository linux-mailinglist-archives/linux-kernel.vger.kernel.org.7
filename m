Return-Path: <linux-kernel+bounces-807041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6675DB49F37
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638391BC5DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4018248880;
	Tue,  9 Sep 2025 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpRt1pRh"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42B54723
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384910; cv=none; b=mAurgCiwBe7YST8oeaBOkNXv1wN1H+4WKGUIQ+JXI9AA+b154nzHoViMF1vKK1uSuQt03rCko4wj4Z5ReSVINcV7IcAlrBiUl6+ZRyQmKCAXWfor1Wgh97Q4OqZunxR/sze6XKwUGGqxrgiEg+ZScKZmHa7qxR4KOaIfQRoNQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384910; c=relaxed/simple;
	bh=uz2r3WzwwE4hiWE6DFK5BmR8dp2uJhNxICC1EpSaSO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgvNftDatEZFnsjSLpPmF8J3KmRG7mLg2ohkA1WXIrK3jTkB5btg8SjoRT/VN8mRHhUSK/GWCoGXuKHehIqJguFBaWV0UN1x0KVbF914utLbHvSqHKcacUIRyKbtuXlNqCx5MLSDwj6qHov1k9um9Gnz39+0Vimdenb4iAcW3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpRt1pRh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so2306235f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757384906; x=1757989706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJBOD8IkKU8HrE1Azq7n6vDJNYZogNLJnaPVYbnTp3Y=;
        b=ZpRt1pRh7ZVAGfrWzHoIQW4xgK5BpQoRymJq4xU3LnRQmSyFU7AJcRFrGg7OEdWLMS
         n2Rrn5MjTZ/zgik7v1+hHqf0sESCf80Co184fvt2OA+rCgxE8grC0hwYgz8t5oRXG34Z
         l69pNIghGBZjfNXvGmOQZkT20M3gPX9d7Klp8E/5Jv76hOedQoc6vdks6wlWdQKzB5XZ
         jdoH6hHd1E5N77ubqSTM50BPOBfUhtUawQDNc2iBYv8EfE29LhrBNmKeOMqmYqd47Rl4
         6/2qT0tPVxyeJoL7HEZlte2gZWD3ZVf9ITpqRs7lF8mW0pYbjsyl3qkwJd7C7Fpca9dS
         tvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757384906; x=1757989706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJBOD8IkKU8HrE1Azq7n6vDJNYZogNLJnaPVYbnTp3Y=;
        b=KEfeQfpuBYcva8b9ygUeLe/yOlBwsWtEf12dd80P7UOmbmYI1msFohJ1vWRifr0u3y
         3H8upsmfqnyjY6nGs2r9H4CR0a2XLRd5Gcmbu/6qcFmlR5Q4LfZE65S8bltVP0M06PQB
         QbYKyg4jw2GE35DZ3bUGpNPWe/+ZQBwtKCiCZGwRoRGGKrqquz0mnscUVicbwCLkdg+K
         Gs5lrWUdMYtxFHfdF0t6Nows1MMSW2JlVv+osfeglkvE8ExZM+bEn9/32EtjV/bFR24r
         8oymzD1psdPeeMWgNkFRqS8U1iP0H+wERC05gU4JWfPYDqk0MWFB6k9H7zuLDN23rW0w
         q16A==
X-Forwarded-Encrypted: i=1; AJvYcCX9DwINvAfGUdoVTKp3o1LOgWUrXLRbXvKzkeNmlxDDdNPs2r5XSP+aASOL4agvTcxCNbdBYFTyzx3unIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoKV06nt79WPNm4ThVp6HJjqslvxAgxszLaLNx7wo3rb03jXc
	a+K5jbLBtsbOiVyU0zNQ2zgJrIYRn3mVQ9vFwKdGkxAGreWiTwztKcVEGFvzV0N0xjZB/Er27FB
	ATuGPTfTI9cEdwLaigXXQpuVjQ0jV8k0D4CVeRTQRuQ==
X-Gm-Gg: ASbGncvrAyipFI3LlceyRSZjECQEmNK2JwsMah3cvoEOOtXjquUY2wjsgUQIfiE6TXJ
	zBLnecSVbSrByrOrvCOYJqefAomYYZF/v5Af8FGueV34Zvb6LD87o7rMxCplYTu0y7oV5CNWv61
	tHXV5+Kxf2R89lr8yez500S3XWV1aau9YusXJdqTIZVBLXEQjJVYeTQ4mOvu04vPdWTCaHdC0Ml
	PvKcvESUbYPyagM+A==
X-Google-Smtp-Source: AGHT+IHwYp6SYclYWSmS86XGBCa6NT9PSPqdtZTxIkstcBCzdrCYANuM1MAFZPIHdfMtTnGEKjXegHkRsnzEOQniwLY=
X-Received: by 2002:a05:6000:4022:b0:3db:b975:dba with SMTP id
 ffacd0b85a97d-3e64bfd7047mr7586750f8f.63.1757384906453; Mon, 08 Sep 2025
 19:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908063732.764289-1-wuzhongtian@huaqin.corp-partner.google.com>
 <CAD=FV=U5CYQ8x7jya6y=eqEY4Zi87unrRTKfexEahVeBXMD5yA@mail.gmail.com>
In-Reply-To: <CAD=FV=U5CYQ8x7jya6y=eqEY4Zi87unrRTKfexEahVeBXMD5yA@mail.gmail.com>
From: zhongtian wu <wuzhongtian@huaqin.corp-partner.google.com>
Date: Tue, 9 Sep 2025 10:28:15 +0800
X-Gm-Features: AS18NWCuU7K2tEuEd2T-9GEjCvDBJJZJYM3vHjpBXuI_N6ttFf3FBPcENRzWUMY
Message-ID: <CAJUL2LNw6y2-za2ghLO3LYynbTf0KuR4_owJqSb8Ec8FJ61WzQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel-edp: Add 4 more panels needed by mt8189 Chromebooks
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

I'm very sorry for my incorrect operation and thank you for your
support and corrections.

On Tue, Sep 9, 2025 at 12:01=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Sun, Sep 7, 2025 at 11:37=E2=80=AFPM Zhongtian Wu
> <wuzhongtian@huaqin.corp-partner.google.com> wrote:
> >
> > Add a few generic edp panels used by mt8189 chromebooks. For
> > BOE-NV140WUM-N44 , the enable timing required 80ms. For
> > CSW-MNE007QB3-1, the hpd_absent timing rquired 80ms, the enable timing
> > required 50ms, the disable timing required 50ms. For CSW-MNE007QS3-6,
> > the enable timing required 50ms. For CMN-N140JCA-ELK, the enable timing
> > required 80ms and disable timing required 50ms.
> >
> > BOE NV140WUM-N44 V8.2
> > edid-decode (hex):
> >
> > 00 ff ff ff ff ff ff 00 09 e5 6a 0a 00 00 00 00
> > 2e 20 01 04 a5 1e 13 78 03 fb f5 96 5d 5a 91 29
> > 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 61 40 80 04 71 b0 3c 40 30 20
> > 36 00 2d bc 10 00 00 1a 81 33 80 04 71 b0 3c 40
> > 30 20 36 00 2d bc 10 00 00 1a 00 00 00 fd 00 28
> > 3c 4c 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe
> > 00 4e 56 31 34 30 57 55 4d 2d 4e 34 34 0a 01 7c
> >
> > 02 03 0d 00 68 1a 00 00 01 01 28 3c 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06
> >
> > CSW MNE007QB3-1:
> > edid-decode (hex):
> >
> > 00 ff ff ff ff ff ff 00 0e 77 6e 14 00 00 00 00
> > 00 23 01 04 a5 1e 13 78 07 ee 95 a3 54 4c 99 26
> > 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
> > 36 00 2d bc 10 00 00 18 2b 30 80 a0 70 b0 23 40
> > 30 20 36 00 2d bc 10 00 00 18 00 00 00 fd 00 28
> > 3c 4a 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fc
> > 00 4d 4e 45 30 30 37 51 42 33 2d 31 0a 20 01 69
> >
> > 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> > 00 3d 8a 54 cd a4 99 66 62 0f 02 45 54 40 5e 40
> > 5e 00 44 12 78 2e 00 06 00 44 40 5e 40 5e 81 00
> > 20 74 1a 00 00 03 01 28 3c 00 00 00 00 00 00 3c
> > 00 00 00 00 8d 00 e3 05 04 00 e6 06 01 00 60 60
> > ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 68 90
> >
> > CSW MNE007QS3-6:
> > edid-decode (hex):
> >
> > 00 ff ff ff ff ff ff 00 0e 77 3f 14 00 00 00 00
> > 00 22 01 04 a5 1e 13 78 03 2c c5 94 5c 59 95 29
> > 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 ea 3d 80 c8 70 b0 2e 40 30 20
> > 36 00 2e bd 10 00 00 1a 88 31 80 c8 70 b0 2e 40
> > 30 20 36 00 2e bd 10 00 00 1a 00 00 00 fd 00 28
> > 3c 4b 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fc
> > 00 4d 4e 45 30 30 37 51 53 33 2d 36 0a 20 01 80
> >
> > 70 20 79 02 00 81 00 14 74 1a 00 00 03 01 28 3c
> > 00 00 00 00 00 00 3c 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9e 90
> >
> > CMN N140JCA-ELK:
> > edid-decode (hex):
> >
> > 00 ff ff ff ff ff ff 00 0d ae 41 14 00 00 00 00
> > 25 21 01 04 a5 1e 13 78 03 28 65 97 59 54 8e 27
> > 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
> > a6 00 2d bc 10 00 00 18 35 30 80 a0 70 b0 24 40
> > 30 20 a6 00 2d bc 10 00 00 18 00 00 00 fd 00 28
> > 3c 4b 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe
> > 00 4e 31 34 30 4a 43 41 2d 45 4c 4b 0a 20 01 14
> >
> > 02 03 0d 00 68 1a 00 00 01 01 28 3c 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com=
>
>
> Note that I hadn't actually provided my Reviewed-by tag on your
> previous version, so you shouldn't have included it here. Even if I
> responded to the patch, the Reviewed-by tag means that I've happy with
> it and I did not provide that on your previous version.
>
> ...in this particular case it turns out that I _am_ happy with the
> current version, but you should have still let me say that and not
> added the tag yourself...
>
> ...hmmm, and then I tried to apply your patch and it didn't apply
> cleanly. :( Please post your patches for edp-panel against
> drm-misc-next. This makes it so I don't need to manually fix things
> up... I've fixed it up myself this time, but next time I'll ask you to
> send a new version.
>
> In any case, I've gone ahead and pushed it to drm-misc-next:
>
>
> [1/1] drm/panel-edp: Add 4 more panels needed by mt8189 Chromebooks
>       commit: 490b30fbaca2abbd6afa8bdc7e2df329b5d82412

