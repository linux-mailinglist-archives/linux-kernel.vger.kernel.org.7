Return-Path: <linux-kernel+bounces-833128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90FDBA148B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF01B6C0DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA031E895;
	Thu, 25 Sep 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oQ91uZYG"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2531E0F0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830391; cv=none; b=DHAse4B+Ogbkkf2L09yJceMfxuEuVA6+D6mH2rHbguL2fDWVXXUHrLmsIKblcZBsTKbBd42d+qQ4fVd20YA00lMHXK4ic6aZAME0KAdmOwHDa0oALqkApsJyC5+BkNkZIsE7GZ3TnfIlb7QvdGRK35TYHoEJE0Ij8nJb91QWGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830391; c=relaxed/simple;
	bh=iVx06PTeCxzGYx2jF50RHht/e08nwcSbQkNnRSnRuvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ1QHdmnwAmLeCkORfF0HxjuZuaXN0FYtzmTKr/iEgOnd/j48pLpUD5ht/S95eJqOppq0cxfpzfHYvtS5uNoTW6fOyVZziLDYo9y6aL9vHYkRtRIuShKAs0QM7Z3yupCmvsZTQR852LXGvy/CtNWFRunCWHHKpa3TSqALKFPNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oQ91uZYG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b551b040930so939104a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758830389; x=1759435189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAdEQBdz9dDV+qB/r+6Q6b9tiykVbAuQh1lcreO6d6U=;
        b=oQ91uZYGzKT4wsjTBrpBn7m28uoPGv4kTw9cxeaPsx4S4LpGIlrBJB49r7KiyUUJ/d
         roEBIlEbm4GROYo8lLS7PSAs5OKzS3rk9xLFZjzx7ryBkYmgMG5V3Y6DBomRWFS9O6iJ
         0J0+OEss55eDvIzt1Cxu5/zAB2skNwQpg9C0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830389; x=1759435189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAdEQBdz9dDV+qB/r+6Q6b9tiykVbAuQh1lcreO6d6U=;
        b=AHOST15gPzxMukBBEEJq2dxyAvNigwev6mflqI9r4fdfRMTvDgCYSICsP2VR+ey1oA
         fXYnhi5fYkzS2m7cTcOOCS9S0rVTmwVEv0KXcnbzL0p4Z3vehIliE5hplcbQwPrwrrHC
         MmX7opPZOGsx+wOIpsq0IRc7TYE0KiVBivfnOfA+lgpOPzH+n0c9/cm0+bAVLMu0SHZr
         dUJ7/R73wsaH74WPxuw37WeVEY9hD5T0QvWbOED6hYmQ+03djbvRslXfXW/PRGFknhiu
         bIVCMcsWOjOqdidYeNc4UbTVNuKpXr6K/GwRmsXEzF9/iXhSiGkFCRlzYvIzbFNRhWTz
         jhmg==
X-Forwarded-Encrypted: i=1; AJvYcCVrfb3od1Rf+M2ofbjT3rY9rVuhHEkyEE67x4oevfqsIoLwPpaMjSV0rGrzANES/XKNffiEAl0a+4xzkdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJcfop3cONUG6967KKNgIx8bjzvuQSv31uvvFEgXhtFAGCSZ5
	ORrsM+M5CSAf9Xz3b90x4sI+FBRbE5YgnF+9t6yAQzjlxy6R2yQoe03e5hPXiSJJFD/uypWzOJI
	75/4=
X-Gm-Gg: ASbGncuzuxGF+jx/KAWcv6n8M97iVggkVz28tlcUWzpSK1wtJgZefFqZsJWvbe2dpMy
	PEPSckKqAAZc0Likeo2/UIKz31/rPepYC1y9vjtO8bazbHmAD43c0elPbrPV2V1JJ6p8eyyD3CQ
	+KUfbXWg8QCHRrdwCoBecPbEgQfSxFI6K7kWlE0vkXy9FInPAOz+KkXlSi1e4UrIJLfk84dWPRu
	d/nup1hC5GGFm2cfYLqctYz7iaafX9ythtgjgnULGYgQsKYjeb1arD2p3/b7btsO0lVSSqjQO4/
	n7Tk8VJzMjDrXY62ZBBG9TId9qzGR2gH1HiOckxVp0LqXnCeU4wmmDpFfoCKSXhUOdriTS7rCpO
	aASWBukAb1di9WfpHnKGoAfzK53c7fCxAuoiL213lMHmisZ3pKApbJ4lKcKLMk0lo5Q==
X-Google-Smtp-Source: AGHT+IHmnH7Y7rbIBh59WmR0QMg6klOmfv55DhWx8heFlknbZAhmJgoRLiyqExeFdz+mRSBNrrNweQ==
X-Received: by 2002:a17:903:32c3:b0:267:e3af:ae67 with SMTP id d9443c01a7336-27ed49d2f64mr49236625ad.14.1758830388924;
        Thu, 25 Sep 2025 12:59:48 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688238esm32999935ad.94.2025.09.25.12.59.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:59:48 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b555ed30c1cso1049508a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:59:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6JhT+1tsC4f4IdMbVPp5EDztx93vrDPmqJmid4wZh5FWt4VlwOzkhuZ8vYAEp4UgORBOGvM51EAUMZPQ=@vger.kernel.org
X-Received: by 2002:a17:902:ec8b:b0:26a:f6e6:ef4f with SMTP id
 d9443c01a7336-27ed4a78d67mr40499335ad.60.1758830387808; Thu, 25 Sep 2025
 12:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com> <20250925084806.89715-3-cuiyunhui@bytedance.com>
In-Reply-To: <20250925084806.89715-3-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Sep 2025 12:59:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VpCZzw24VH4DAvt5UhZHJD1TMO-t5HB8Kfw3pw+jO7sA@mail.gmail.com>
X-Gm-Features: AS18NWCOLLpqvX90nBBWu9Muo_va5K9CeZWn93TLpPGzigEq33VTJanz9wj8IRk
Message-ID: <CAD=FV=VpCZzw24VH4DAvt5UhZHJD1TMO-t5HB8Kfw3pw+jO7sA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/Kconfig           |  3 +++
>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index badbb2b366946..bb4e8c5a18717 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -186,6 +186,9 @@ config RISCV
>         select HAVE_PAGE_SIZE_4KB
>         select HAVE_PCI
>         select HAVE_PERF_EVENTS
> +       select PERF_EVENTS

I don't think you want to select this, do you? Just depend on it?

Other than that, this looks good to me.


-Doug

