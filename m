Return-Path: <linux-kernel+bounces-815564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B09B56839
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBB4170A82
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB9C2367D6;
	Sun, 14 Sep 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKJweEDP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FF11CBA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851376; cv=none; b=YSi5UBNGXT3W8uMQfaWt9uuBBAm5KICYBccQJIAshPlApB346VogjzEjkqMF13A0DC3ck0GALDuc8wf3u9Aco7g41kAVxVaAVmhgzWuGfLBB7rSjlAdR6sZXN2Ma2AUCY9QEbRGZF07y90BmEZgXavhthkVD/LjMvWBmTbA/mzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851376; c=relaxed/simple;
	bh=0zGf5IMzfNgoF86x6HEB8LsnJvdSA9phhqHaIyPzjdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwZtnACGcgwlXN08GtBB90VxZFNAMuAIVttpRoqgpVSdUrCAaZETpxn6azDeLHQeGwolQrAsUbdwHVSTjZix272GIoiAnxFHzqjSyXCRUsClL6SR3YLbHQz/TuwQ7Nj6M4at+sKezGSUDeTDyVPOYV/gdhXv7g/XK5AkB3iJ4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKJweEDP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757851374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhq4ntYmN439CKdGT+d1l8erZ8eBL5gLNqqonKEQuM4=;
	b=jKJweEDPjPwWuCPwnnxIZSvWViNAqJvuHIzVDRbB64hK2daE9EKR8H+D0BeUjBYNLtDTLY
	C7AvxdC7bRp8cGl7agULngGc4mZ28riV4qQuir4WPcqfkUh+ARHH0NkkL+MFwUeQu5Boha
	4BKqtxIC7vCnPEQ8HgVAJoc+lR+8NG4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-a4a46rF-O7q9RV7OXNwMPw-1; Sun, 14 Sep 2025 08:02:53 -0400
X-MC-Unique: a4a46rF-O7q9RV7OXNwMPw-1
X-Mimecast-MFC-AGG-ID: a4a46rF-O7q9RV7OXNwMPw_1757851372
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-817ecd47971so1006826285a.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851372; x=1758456172;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhq4ntYmN439CKdGT+d1l8erZ8eBL5gLNqqonKEQuM4=;
        b=f+04pfd0emHh4exgR+aPKe1NqQkwXQR94w0xenfrOOzUwdLTzpaVv2ndCxrb4HiA+5
         NOaE5R07lctNUIZjHL0PHHaKzpzv47rapA3QfRu84HMYKYsepcQMMVE5gHdDMlAmb9Ce
         vPYRwnjIKotbGkF7cmV3+P4JV6DXuczBxZRyjDv/cEolc+3C4ugsMm82yTkkDYh9k0BM
         JQfxbf0SjUp+6fBaRfioi6q+1aBqk/VfG5AF3Ci0NJl6zt394bl8kfnDVlToRZpCnYnC
         h73EGeLkV0cR9hpkwP6xPqXMLo2rlFHXVaqqA1o2FmXCRTU/XeGsU6m2tH19IuHc2BM0
         3/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUPk9wqj9ZauDBg+tHuiZNc6iGiC7yBe9XbxTvJoqEfOAUONwMvdLq8Ngi4T+g4H6DMTTVYljoTC9iQDIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwewpSKeAKmm60FHoWVjL6acobaH+0ED0N51owiuOZ/pt32vzr7
	uMj3VwaEdIzBEAcgFIn4/HJYwmZw4VaodAT97pgDnVrAvuReGcQjpQDU9Ih3BUg2aVzAFsI7XEw
	KqDVu8/092LEjefn6ymjWzPXoLnQgjeYLUzbOJRjLJP2dVqUT3G8OyWCyhQHI8u8YuuN5xICC6w
	==
X-Gm-Gg: ASbGnctRTde2pxPNJal2adSsYC+/F5LY9oNqPE3KMFGLh/0dzsDCnRh6Zidn1Zo1xKK
	DUip/yGkD/AvU9EI40bgb1aNGFYvJto2j4hoZ+CMdgZtScmBeRJkzLdEN8z9myGMFW+IdHpmJGs
	hE/qfAagI+NYaDr1DwirxjaiZ3WKxn42B1C65RVpK5Z+J8VVbNsVI7ewFQocF9+qumMiUGxCpSZ
	R1ebN74SZSxhuQWkzE4kVhNQX0hoOma5nxn4DI27p5n2Oplz+O1xZKQlwnAXS7vfOrEtCUhmwjC
	A6y7pQ5mSPslFePfx+rqVd50KeHRXH4Ul3VrvW4Xel8kZaa3nu9mhaTRMDb47ZX16wKU+i9oHgi
	40C7YuAU0Zn/MTRedsrh6hx+qveFn/wg=
X-Received: by 2002:a05:620a:17aa:b0:815:9d71:62be with SMTP id af79cd13be357-823fdeb328fmr1174352485a.32.1757851371746;
        Sun, 14 Sep 2025 05:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHddUjBPw2+Eoh4CJBNqL3DRa4XzeYrF/c1LzR0K0PmQ0AzUaqM1uVjIA9fi3fWlDTgnInMRw==
X-Received: by 2002:a05:620a:17aa:b0:815:9d71:62be with SMTP id af79cd13be357-823fdeb328fmr1174348485a.32.1757851371345;
        Sun, 14 Sep 2025 05:02:51 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b450860asm58199336d6.12.2025.09.14.05.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:02:50 -0700 (PDT)
Date: Sun, 14 Sep 2025 08:02:47 -0400
From: Brian Masney <bmasney@redhat.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: ingenic-sysost: convert from round_rate()
 to determine_rate()
Message-ID: <aMau50G_4loSzSv7@redhat.com>
References: <20250810-clocksource-round-rate-v1-1-486ef53e45eb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-clocksource-round-rate-v1-1-486ef53e45eb@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Daniel and Thomas,

On Sun, Aug 10, 2025 at 06:37:10PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> appended to the "under-the-cut" portion of the patch.
> 
> While changes are being made to 'struct clk_ops', let's also go ahead
> and fix the formatting of set_rate so that everything lines up as
> expected.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

Thanks,

Brian


