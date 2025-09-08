Return-Path: <linux-kernel+bounces-806291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC3B494B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6420F7B9A57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF97207A0B;
	Mon,  8 Sep 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FIAOC1p6"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EFB30E0C8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347279; cv=none; b=At3EhUcIe4kLGbNP9puqhrs44vugCKfKpXvi9gF36BCsjZWrWDtmJUvuRRj6nfbaPAtxAxE0/Wk4l7+s5uAdyWIp2zAlIsaDeNyoOYHFgXlq7VfCnwaJEZwmIQGayn215Uluezjz8i6bYxWeekKjNZnerAkV9vgW3E7vQKmfRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347279; c=relaxed/simple;
	bh=jDUxlawUWWTLT7jf/vVSc5CbZnqr0MS9oQbC++BQF8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJ/rQo7IoC501M4ivZIuXulp9Zh1+70YtqD1M+uOrDuSQiX+VcETLVaGY09nO3CRnqhab7lH72XG0E9L1gaRJhqmma0JrSnWTAkXg1akZ16bQZ7frORb5a4qv2Byr6FSbi2AUT499L5gbBp07MoSWogkGYl3hmfjm+c04u0Vqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FIAOC1p6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77256e75eacso4090565b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757347275; x=1757952075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDUqzdcg17KtqKCQYpEmkhfy4yLIsN7gEnd2+8GZlgk=;
        b=FIAOC1p65Z6zjbodDLNgZ4waxG+9D92APUejF9jHH/Sz4pBma2FxMZX05UAGx6eMdg
         BtDrUzJz7MyHyQn6gsEVKYn/29wTti9IooMn+39GHIwmr0Jk8jVxXnL6rC2vyRRxYU05
         8UTA421R+KapEvCgv5V0t5v1yrNR+3Zya/2eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757347275; x=1757952075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDUqzdcg17KtqKCQYpEmkhfy4yLIsN7gEnd2+8GZlgk=;
        b=Qk6Cdr1g/ur79X7iAWGQtrE4A8orMUCKRvMVVN0od++hebRZusTe6OI+GBm+JDEtcx
         /FNhucIEkQ0drTEn/FGhO7Hbh2r2tylB+Ar7zZAJcXtCivhyRHq1gmWWXWjr2MlcfnHp
         GtNJkSsJAUsuItTej5AnrLgBOtOyMOPMNJb3BQfGahjBs6zCj84tLp3ajPxW4Y2T1vOV
         qQPciWA9YOoadrerjC9qPQKbwfdVKhOFdv4zv5WnajkRecOx++xiiZnH553j9GqmO693
         23JRFkdo9WqaD8vmPEagQpqRkbWT+OZ1IG2uolO4tk06GWykWSKNX1xWaO5iUkVcZIQc
         /ueg==
X-Forwarded-Encrypted: i=1; AJvYcCV7QECIgau3a7A/iBWVO4mdE3O9975QC9AtZkdUVEl8JaKSsF6TD5+X/rkNlut7YRnSmBtHw4iEyAT/Nyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3k4KykmuNRzMDtwyJIIgBsKD+gYMrvk2Rmdw6qNIrdG6nzA/
	RRDLqPd9YCDla7i1CIHKSvlDw7TezBy2z6PPjDs43tAMSXIUg7CN7W+HfS0BmVL3epA1Ltr02fj
	TBGA=
X-Gm-Gg: ASbGnct549Mx1QJbIUaY5GaCSwNWghge0LKkz+5YSh7OMQe9/g2NMc9Jlv8qEI9FmXw
	y+uqhjDmVHxJfiaMfrjOP/mY7U3cWHngm1CoTRrLtr98yFdCq/sffn+g62+sdV6NaGwUn8nMcKg
	dXYclpy0LwUdBpaNXXhuT3Jw1NzBvohDWP7R3BR/SISc6q97XS6NRhEYPWaSQMdNZDI97CyRvy3
	oRM5hB6Zf1zwOne/icp5HwPFcLA8ZTeWxjWXJ5PxFFcbdoRZr2tyL4eoDmya2/hjXf0ZDZMbr6L
	cg6cIOnKPyM05LMSF8HeZgbgsaahghXVaPuAUbFuQRJDz5F9hodRbaXfoJltSNHJbb8qIk9a+sj
	97gJMQPeIO62+fuGIoViAZAHbEaNK7+2c3Sag2qF40bWlqzc96Z2F4V7uhUqOVg0ahrsBrrGkHX
	2DwZwomgu9MV8=
X-Google-Smtp-Source: AGHT+IEzks5Dc2v9JxWI4QQBo0MGfHNxjPP94XDoslqqlWkvmeTU7FA0HxDZTdp+X1qm+CDdOMwZ2Q==
X-Received: by 2002:a05:6a21:999a:b0:244:21:b477 with SMTP id adf61e73a8af0-2533e853411mr11349482637.16.1757347273681;
        Mon, 08 Sep 2025 09:01:13 -0700 (PDT)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77231f40553sm28749873b3a.43.2025.09.08.09.01.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:01:11 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445805aa2eso44959035ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:01:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWy0rRqnjo9sHHQaD6wJKJYxmahTdz87K/Hlr3ILor752+vRmKuY3SDTeApUgsvnt3mebioHWkEounsGgg=@vger.kernel.org
X-Received: by 2002:a17:902:ec8e:b0:24c:cca1:7cfc with SMTP id
 d9443c01a7336-251761680f7mr126471995ad.59.1757347269705; Mon, 08 Sep 2025
 09:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908063732.764289-1-wuzhongtian@huaqin.corp-partner.google.com>
In-Reply-To: <20250908063732.764289-1-wuzhongtian@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Sep 2025 09:00:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U5CYQ8x7jya6y=eqEY4Zi87unrRTKfexEahVeBXMD5yA@mail.gmail.com>
X-Gm-Features: Ac12FXxPVHg-eiaA8fURwy48KzU3M4U1RJrwAg8wF2uEv9ufhRs9yYWmoT3IaoQ
Message-ID: <CAD=FV=U5CYQ8x7jya6y=eqEY4Zi87unrRTKfexEahVeBXMD5yA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel-edp: Add 4 more panels needed by mt8189 Chromebooks
To: Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 7, 2025 at 11:37=E2=80=AFPM Zhongtian Wu
<wuzhongtian@huaqin.corp-partner.google.com> wrote:
>
> Add a few generic edp panels used by mt8189 chromebooks. For
> BOE-NV140WUM-N44 , the enable timing required 80ms. For
> CSW-MNE007QB3-1, the hpd_absent timing rquired 80ms, the enable timing
> required 50ms, the disable timing required 50ms. For CSW-MNE007QS3-6,
> the enable timing required 50ms. For CMN-N140JCA-ELK, the enable timing
> required 80ms and disable timing required 50ms.
>
> BOE NV140WUM-N44 V8.2
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 09 e5 6a 0a 00 00 00 00
> 2e 20 01 04 a5 1e 13 78 03 fb f5 96 5d 5a 91 29
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 61 40 80 04 71 b0 3c 40 30 20
> 36 00 2d bc 10 00 00 1a 81 33 80 04 71 b0 3c 40
> 30 20 36 00 2d bc 10 00 00 1a 00 00 00 fd 00 28
> 3c 4c 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 56 31 34 30 57 55 4d 2d 4e 34 34 0a 01 7c
>
> 02 03 0d 00 68 1a 00 00 01 01 28 3c 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06
>
> CSW MNE007QB3-1:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 0e 77 6e 14 00 00 00 00
> 00 23 01 04 a5 1e 13 78 07 ee 95 a3 54 4c 99 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
> 36 00 2d bc 10 00 00 18 2b 30 80 a0 70 b0 23 40
> 30 20 36 00 2d bc 10 00 00 18 00 00 00 fd 00 28
> 3c 4a 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4d 4e 45 30 30 37 51 42 33 2d 31 0a 20 01 69
>
> 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> 00 3d 8a 54 cd a4 99 66 62 0f 02 45 54 40 5e 40
> 5e 00 44 12 78 2e 00 06 00 44 40 5e 40 5e 81 00
> 20 74 1a 00 00 03 01 28 3c 00 00 00 00 00 00 3c
> 00 00 00 00 8d 00 e3 05 04 00 e6 06 01 00 60 60
> ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 68 90
>
> CSW MNE007QS3-6:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 0e 77 3f 14 00 00 00 00
> 00 22 01 04 a5 1e 13 78 03 2c c5 94 5c 59 95 29
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ea 3d 80 c8 70 b0 2e 40 30 20
> 36 00 2e bd 10 00 00 1a 88 31 80 c8 70 b0 2e 40
> 30 20 36 00 2e bd 10 00 00 1a 00 00 00 fd 00 28
> 3c 4b 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4d 4e 45 30 30 37 51 53 33 2d 36 0a 20 01 80
>
> 70 20 79 02 00 81 00 14 74 1a 00 00 03 01 28 3c
> 00 00 00 00 00 00 3c 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9e 90
>
> CMN N140JCA-ELK:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 0d ae 41 14 00 00 00 00
> 25 21 01 04 a5 1e 13 78 03 28 65 97 59 54 8e 27
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
> a6 00 2d bc 10 00 00 18 35 30 80 a0 70 b0 24 40
> 30 20 a6 00 2d bc 10 00 00 18 00 00 00 fd 00 28
> 3c 4b 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 31 34 30 4a 43 41 2d 45 4c 4b 0a 20 01 14
>
> 02 03 0d 00 68 1a 00 00 01 01 28 3c 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com>

Note that I hadn't actually provided my Reviewed-by tag on your
previous version, so you shouldn't have included it here. Even if I
responded to the patch, the Reviewed-by tag means that I've happy with
it and I did not provide that on your previous version.

...in this particular case it turns out that I _am_ happy with the
current version, but you should have still let me say that and not
added the tag yourself...

...hmmm, and then I tried to apply your patch and it didn't apply
cleanly. :( Please post your patches for edp-panel against
drm-misc-next. This makes it so I don't need to manually fix things
up... I've fixed it up myself this time, but next time I'll ask you to
send a new version.

In any case, I've gone ahead and pushed it to drm-misc-next:


[1/1] drm/panel-edp: Add 4 more panels needed by mt8189 Chromebooks
      commit: 490b30fbaca2abbd6afa8bdc7e2df329b5d82412

