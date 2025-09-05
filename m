Return-Path: <linux-kernel+bounces-802662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6EB45549
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96EA16404D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679B2EC543;
	Fri,  5 Sep 2025 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G9fsJCub"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CD2EB5C8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069242; cv=none; b=m4hkb8jijTHip0Y1BUQVHdsYhzIAEy9Bj3L7Ye3/oDtQJq0frqhkAekEuda2BRPUnqV95N9ugKnEmmS91+MpuGQ7DUoFrAy3zUy9DE0/Hcm5Vv0wRqsMETET2eowVYO9W+BxoinaNXs6AxxQOz6oldqLFNismC8g+P6eI5gVvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069242; c=relaxed/simple;
	bh=tlLsNhCUUJlM1+7sYddKTQ/OTH1EIH2W4fJyElLyo1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUlnWEU45h+DPsWS9EYIp4441ZKvBqAbilhZGFYVaTMT06RsY7/bn+q5yD9fxshxagr3hwSbu4MT2vpSdcmhO7oZEb1Zn+pkMWVK5cqhflxaoIDb4tKPFczVPGxbUYSD2sLoNt+vqzJpS9bEzX86ZTuaxAZS8vKpB3+h5n20Bj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G9fsJCub; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso3344682a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757069238; x=1757674038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlLsNhCUUJlM1+7sYddKTQ/OTH1EIH2W4fJyElLyo1Y=;
        b=G9fsJCubKfyCYL8pcjkn+heCX9daS3qgoQ/3DlRTCgZcgM6pKcK0lHWYkToxv0D8Yh
         Dcyq8ehjguZP8vJpO49gCtaTfddKtBKO2TE1+gahO/UOrOk/bG8xUHyyKnL9acI+Q+nL
         Bajhw6gaYpdbXTfXSv+fazkgjsMR+mTrRAkIGd6KHTVsaNOOwMzCBeJj1tquzruTk5Y6
         5ybOQmJGyKDIDW+zNvdi6tG+9tmiRQXVw8GrWSHT0Sc5BZokQZNI0Vzx+j7+X2el5Wbg
         /FQdooB5AVSo0JUlF7xnr9ZfKo2a6IJnRLw7U4Pc1e9Pl6ldHc+9v3SmuGX4ix8kND5Y
         91Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069238; x=1757674038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlLsNhCUUJlM1+7sYddKTQ/OTH1EIH2W4fJyElLyo1Y=;
        b=NrcWwIYDNkVK15k/hE1BPKYJvYW+gsHpytJnBidtUeCbCjLWgl4JdNFewF7yDV+wmR
         hdHqFCAYx7BE/KgC4nGOrJc09UVQDAhMHRB2y0TUYIqQmZYFkkScvRTGYI2dzLZOEDFr
         pX4d2fGhDGLfCJhO7OdVsUjJulT3Br+QJGS81EHuMN3+y+pXLOtUQ7+9j3cV8hB2H0G4
         HMuunrOWIX2+eSwDDte9NI2tuuOUEkHzdkEj6wS7cfRqKNhafsw6UxLANwSUjdJcIupp
         FKiuKutKvrhQmXi45Be4sokUkj9Q0W6hoQtyBuaugreQPwoZcJ5qDicszkvZMQtIXCBm
         ILSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKib34eu5+oKvmfmx7mqcrenSYgLUQs+S9wdhJ7i12w3R9PIAP1u6J7/Tu8Yk8jgQADrKB2CdeNaiy91c=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhkXvv1cBC8a6shsLEAg06G9qCLF4G910KhOqA0+pQf1zGdJo
	ilHxlsZEivolBODOr2Pptq1UPt9frwBV11aUOnQXonQiUYTL95o0+RwFquh6TsPSV7I=
X-Gm-Gg: ASbGncsdwt9hJBGoIJyY4R65iI2nUUG5cwxuLIhcIH5zEka0iJ0uUfPU5rhXUmJYRPn
	gK+uQEdrCdw7WxbGwcgbXEE6QorkiiTSq0jJ2R/Umi5oYvJt28wfIrbbtvew/N/vIaFBVcY5NIX
	ktuyIKjQaOJo5pq5BxSr//JpA7K2gYglCNpA32EAb08Ae93jcf0oBEO1Uibp14+qcz53QuXZ5mo
	HlrjdTSJtxM6MILWpZ8wXZs7BNHqBSNVpdQbSd05SxG2Dru8+SpXtgmt7eLshxmx3geATCNtUTC
	MuZ9zp/epsV9C10t52o00dstMQTB6rLlitYLm95ULZ45+1912o29MnOkNXFjRZp4ZqaDfqgBiwm
	AtFH5YGiSB8Hs0/Cva8LlKp9VSQ==
X-Google-Smtp-Source: AGHT+IFzfMDqoGCwvD4rSPAMagECPz5wF1NSbH+PFl2/nLbtaFAv7ULR6mZc+Cf9CHWgqlbuCx5ldQ==
X-Received: by 2002:a05:6402:50d4:b0:61d:1d36:a7d5 with SMTP id 4fb4d7f45d1cf-61d26fd0b47mr20811925a12.19.1757069237747;
        Fri, 05 Sep 2025 03:47:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4e5229sm16185203a12.39.2025.09.05.03.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:47:17 -0700 (PDT)
Date: Fri, 5 Sep 2025 12:47:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1] printk_ringbuffer: don't needlessly wrap data blocks
 around
Message-ID: <aLq_swzD73vOYm-_@pathway.suse.cz>
References: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
 <84jz2etj3t.fsf@jogness.linutronix.de>
 <aLm_SpmQP3UwzkqQ@pathway>
 <84ikhxfejl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ikhxfejl.fsf@jogness.linutronix.de>

On Fri 2025-09-05 11:19:02, John Ogness wrote:
> FWIW, Aside from inspecting all the related code carefully, I also
> performed various size and boundary tests using small buffers (like 1KB
> and 2KB). I am confortable with these changes.

Great. I wanted to do similar tests ;-)

Daniil, feel free to send new version.

Best Regards,
Petr

