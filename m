Return-Path: <linux-kernel+bounces-847489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE2BCAF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 434804EC1AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE671C5D44;
	Thu,  9 Oct 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhaeHpIr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31402155C88
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046327; cv=none; b=XRJCvUWyb2p5r0sqUfCvoqUVB4ukq+Kkc26CJsQ6PEcNKvEVfxdcdPOCwmadVwUD7p3chTLSDZizVtTl9i/omN7v9sTjTaTVRSRrYlGNZVVFB3FO9s1HS5B3uDvMDi5g+HKKKawMnXU4S42O3P4VyyoIs9cQ6zBiute9blAfy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046327; c=relaxed/simple;
	bh=JDf3RvnAJ/dSZU1DuUy77Eh2QFyUGi8T1WgDX4m65cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox6ucs6dUCekpY1qxEudNiSfm32eishjZ1wOtV65uIUrzUVqp4pMHg9Jordr0DFY/Y6Rw6YfULYY2koz3XBwOPK7Ct4WwRyjj600Ue2l4hXgzaWJr5yGba4sH1/bqg4VrqUj4PjMZ8TdciEbJNNknBxDi1kMvYwTlHjfPMYgj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhaeHpIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A29C4CEE7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760046326;
	bh=JDf3RvnAJ/dSZU1DuUy77Eh2QFyUGi8T1WgDX4m65cQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XhaeHpIr2R/7oEIbBUjdOYNm9eTASl973IABzfSiFC557ApGEuxMDkdaG47rJbzYd
	 RPjJVVhKfaTAmMxxSFbEqQc0T3ECfckL+fG6EtbboaQMwJLIcaEIMxkJsFLIv9LekR
	 YLoCD6U2UjY2L3/sgMemkuIeGYOzgH2Te+y2zcGKbbDSM8JOTlPcJS+EbSaBl/2yqj
	 bpt6EYNJhdIZ3zKd5Yim+ODGmy20Lt9RNmnuXb7BsB/EH+uqogH0IsUyXxjMKK/LrX
	 VvjfdMpDeV2CjQ2uEINaftlX6W2oYMt/Gyc3h3KhikIWPitKE+0ISJY97fomRhEJsp
	 fqa5+NLt0I7lA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5906665139cso1828739e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:45:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8P72y1F2W6KPNfRut7c6d7pohFq0MRwfRcv7Z/iwS67icsv5/VCRly9DHJch6AEpaOjJD/V+qwWi1rFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJoYv9W1l5ULz6jT3LJV2cH/FRgO8mmT1wwsFKd+JzDvO0CcU
	xqkYelh1yxuxMi4NC4pwXF0cvYsCn2ms7A5hx1ygO58lhDpSa5N/PsYfkchOIL/ewKn0GWDi8wR
	s+4ImA2VD7sLw15U8zt1E6fTG3rK1kic=
X-Google-Smtp-Source: AGHT+IFdXBbuZW52QrqTdHX+lhqTD+/sq95pRmf1cdQmeXGgR4GX2JwjaAoHyFnSrPPPmQHGx6K4ST8vlbfcsWWxaow=
X-Received: by 2002:a05:6512:3a92:b0:55f:3525:3e52 with SMTP id
 2adb3069b0e04-5906dc0d3f1mr2585893e87.14.1760046325181; Thu, 09 Oct 2025
 14:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-arm64-text-offset-v1-1-bf0e8a27383b@oss.qualcomm.com>
 <aOPLv_-f5sNGtG4e@willie-the-truck> <CAMj1kXHhetfN_bY5AAqqfC4=N9yQCO5R_n7H0BMXZ2VXudv5pQ@mail.gmail.com>
 <obcgfnmgdemf5gtc7gdaj6nzoa2rwxsc6njt4fd2ouwzqj4y7y@ztxwyyoepuud>
In-Reply-To: <obcgfnmgdemf5gtc7gdaj6nzoa2rwxsc6njt4fd2ouwzqj4y7y@ztxwyyoepuud>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Oct 2025 14:45:14 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEphMAoCi5T4w99OgVA2VmF3ZBsZ5-t=Oan8r0S_EaY2w@mail.gmail.com>
X-Gm-Features: AS18NWBbQ-eMZfEdM8Bn394IlzRr-fCZGuh5YoPpU-famY8LTSrZQTWP1N0nZoU
Message-ID: <CAMj1kXEphMAoCi5T4w99OgVA2VmF3ZBsZ5-t=Oan8r0S_EaY2w@mail.gmail.com>
Subject: Re: [PATCH] arm64: head: set TEXT_OFFSET to the historical value
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	David Heidelberg <david@ixit.cz>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 12:51, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Oct 07, 2025 at 01:46:08AM +0200, Ard Biesheuvel wrote:
...
> >
> > Just setting the header field and not updating the base address also
> > means that the boot breaks without CONFIG_RELOCATABLE, and you will
> > get a warning in the kernel log about the load address not being
> > aligned to 2 MiB.
> >
> > So I don't think this is the right solution.
>
> Since most of the people build the kernel with CONFIG_RELOCATABLE, would
> it be better to set it to 0x80000 for relocatable kernels and to 0
> otherwise?
>

When CONFIG_RELOCATABLE is set, any multiple of 64k is acceptable in
practice, but given that this violates the documented boot protocol
for arm64, we only permit this when booting via the EFI stub.

When we set this field to 0x80000, we are basically instructing
bootloaders to violate the boot protocol, which is not ideal, and we
should definitely not issue the pr_warn() we have today in
arch/arm64/kernel/setup.c.

> >
> > If this is really something that needs to be fixed upstream, we should
> > just bring back TEXT_OFFSET in its entirety, but I'm not convinced
> > that this is really justified here. As a workaround, you could just
> > add 2 MiB - 0x80000 bytes of padding at the start of the image, and
> > add your own header (as Will alludes to as well)
>
> Does it mean building a device specific kernel? Or just packing
> everything while building the Android boot image?
>

No idea. What does the Android boot image contain? Is the first thing
that gets loaded the kernel image? In that case, you would wrap the
kernel image before sticking it into the Android boot image, yes.

