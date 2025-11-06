Return-Path: <linux-kernel+bounces-887527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A6C38723
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E0A1A23A65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945EE18EB0;
	Thu,  6 Nov 2025 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2yuCWaL"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C76FBF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388072; cv=none; b=FrLNt/gkPH7HkTeACQXkL4rXpVqyEHo4etRGLOQiBrQ7mMJERcXb4XK48YHtmU/wlTNTVCNFnrLI8nXTzIxuJWdallNz+VIrAVCz7p7hmHpDimd0kDC27oenxY3GWxAwsdmhFgVBPhKMy0b3KhLfgNOWfyRAV08wEyKTq/NtGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388072; c=relaxed/simple;
	bh=DRK2N3r5v5psexKnqVX1ubSmtmNxRf2HQUDtM5cF6rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkpuHma5BW32ru0bWMaOm/0BodnKypRtO981V2Ko+DGeswo73wW/eFwgvBDJfD+YfNaxOtWjUzDUy5TaIpuFIw59DIogZCNkK2pXkG4iL//Kw2VQZhXnhMMEg+h+PaiZ/sDFqeXphucfqM42/FacLu0cFkNrr3EHcMln9Bn12Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2yuCWaL; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-294fe7c2e69so4147625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762388070; x=1762992870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1lmaO09oZEmTOr5ZOwlTY8KRXuoWLlblnQmg9l/mdo=;
        b=A2yuCWaLGT+mJ11SPGs1Eg7aR2TUxELwwt2PvnUSKbRIe3U37FE4dEwnEIc0cHWcVx
         z2u3CptmGHKW/gmAnYzEREBnEeVZd+twSu54I24KbV7+HndlTxOl3bOmLJOBIFdR4OBQ
         FkXr0w9svIdd/E6xp3phAx5PaUchLilYyp4Iez2mLs9LUdIG7op8UWprEdwDCWfG92a2
         J1TDlmPII/BDdvzVYtNW7c8VwkCB6/Ft0vWwo4PMeFiZSVr9yHQh+Plzk8oab3a7J5xt
         N275LHhC9S7jlVhsXbHCb8A32rLxb1Sa479hjMwVkBiBkVrK9JwgB30/rMppjAz3daue
         skCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388070; x=1762992870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1lmaO09oZEmTOr5ZOwlTY8KRXuoWLlblnQmg9l/mdo=;
        b=oIFIDBTswD47gjnceT95YdOz+wM1NkoRD0DForrI1GrZtsaiES/YnQAJYhIEbvjh5I
         AbIqgpTNFXZfwNJObYMtNEYGSfUctNMX/5e6biVuMTDOsdHYUAN6OyBKf3CxKj61OsFw
         mciFXQ2AWUju6bcVOVSFQPDOOabGkX17SjFWjLIk+3b6iqyYQDK5Ent/i066u21AHpqf
         P6PcPwH3PZe9/G171dkrKIfy9u70MPy/rylul9j1k/AjDvBULba09/jjwTK5SCDMBkKz
         L6XrtmBfDvXrw5aIbkUaVSls3C1ZMxpvjQVr4wHGj3X7eDTzrqSgFupd3mURwJeWoQQy
         1WVA==
X-Forwarded-Encrypted: i=1; AJvYcCVYsXOT87KKPSMtrQ6TTp1stWCRhICJGBoeuUyFoEqc+kAWP7TTbJ1VWQ5glqqaEyO8sJ87Rs88nWi0Dhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+r6zygDf9sbzK+HHJf6JymSTuayLamkPaV58QdDIjSa1ee55i
	8HU4sVsZAZniAJuNJn98WzbkuzfOR+fCyrQUzn9cHUD/Ho+XaT/ZyJdSU5SfCamLTQ==
X-Gm-Gg: ASbGnctQqEJ9+hF66VNLNr6JT72yAmv1nj5Ofu7dfJ6UhD65HgAt7rO+oOa8CUVMEiL
	Qfv5yQNSNzOBIvnvN4/efgSX1vkyrTparchsTuK9s3sjM0e2WVSFoLECfigAd+R4Ft7s7PS4QAb
	4IN9xOum4I7g32U7znzw2X4uI6xPptC2T4LC52dRFbuaziIIKm5pS7lfZ7qQlnvFyvIUt1SmOhJ
	Kb64yualHmpncM4S68tVYFvly6F9emKwYeeTz0VCrT6IhaUM0Ph+BcI9NxELOHxbHViSac3fwtd
	XbIWTpVsTRjeoxeo5pReHIXud86xzjNudR9UTgFTRGOCIhq8VyfD/AnbcZPCROiLsEMDTBzOPFE
	McL2Yz5J+T9oj/7GxPus/bz14nddqBMRf7pySeBjWlWmnZBjtpYox1i58pM0asqJGelcrYXXmg5
	LmnPRGkmkRpyqffM47WV7WmO4yuov75YLQGiWhEyBTeGavrIB7rGQB
X-Google-Smtp-Source: AGHT+IEMBf1dyDG7MeT/9tZx6yKxyh7B8WhX3lv3XCw4idBVSajUZtQi9QVePs38w4HQOSSQTKRJsA==
X-Received: by 2002:a17:902:e84e:b0:295:e9af:8e4f with SMTP id d9443c01a7336-2962ae97813mr77569345ad.52.1762388069620;
        Wed, 05 Nov 2025 16:14:29 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cce763sm7101515ad.103.2025.11.05.16.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:14:28 -0800 (PST)
Date: Thu, 6 Nov 2025 00:14:24 +0000
From: David Matlack <dmatlack@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] vfio: selftests: Add support for passing vf_token in
 device init
Message-ID: <aQvoYE7LPQp1uNEA@google.com>
References: <20251104003536.3601931-1-rananta@google.com>
 <20251104003536.3601931-2-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104003536.3601931-2-rananta@google.com>

On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:

> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index 5d11c3a89a28e..2dc85c41ffb4b 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -18,7 +18,9 @@ $(shell mkdir -p $(LIBVFIO_O_DIRS))
>  
>  CFLAGS += -I$(VFIO_DIR)/lib/include
>  
> +LDLIBS += -luuid

I wonder if we really need this dependency. VFIO and IOMMUFD just expect
a 16 byte character array. That is easy enough to represent. The other
part we use is uuid_parse(), but I don't know if selftests need to do
that validation. We can let VFIO and IOMMUFD validate the UUID as they
see fit and return an error if they aren't happy with it. i.e. We do not
need to duplicate validation in the test.

