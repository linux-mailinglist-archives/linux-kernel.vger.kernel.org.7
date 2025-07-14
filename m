Return-Path: <linux-kernel+bounces-729497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7403B03788
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D36189AE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE922F152;
	Mon, 14 Jul 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzhoOmbU"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D5226CF1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476783; cv=none; b=cj76n7alcsx7neIcxHzXR94udxBT4D09+wjuYuRyI6OPoe5KopNz6qpmyl+gKyKHW1fwW3XsIcw6fNe/u4NdVOkAlor7Agz1t5Xn40+An1p0KQp1z3KJijA6pHPnWy9zu7omuSMPrT1RyV+YRzFRNV+FpmvAo1XjdRYpggQj56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476783; c=relaxed/simple;
	bh=OzccZpasGG2c7DBzKu7if3kYPy4nJFmm0jbD0Q7yZzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRwL7ziuq4PCa8NDCjQ/t166lXoAybuYqsEo1By7WSncperZhDFWMtqyRXiSu1WhPsOSGyA9oFvyt+Fj/0iIyumn3TKHmX+ky6fNBN9+NUTtfKDX5vfDRV6wGl54CDyeLmy5DcYLFQeMuJxItg6ObI+D3Rhn+PHDMxYnXlFfNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzhoOmbU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a510432236so2899824f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752476780; x=1753081580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbwGy+7N2iezorbGT54iwugd4pW3kzbl1P6qDvgzttI=;
        b=EzhoOmbUvt9YX7EROlHLsEppTdB4gB4AWU9LyvjNLqelx8lBYQ8jWYAGQKneIeZJhO
         8wyLB0pBwUCORuVi/PYiP2gKq/TQTsc2efnhM0JPL1rX9V3YQYuMIk6pLIxloAGM2HsZ
         F/k+ltgFiIV+c0wTbSke3JvA6VpzCnb7rKP5HeGUPtzYp5LXGVpp9oxIy6DFI/TD/ZYH
         pLQWohzr2009dcMc1yK1/PUSXcZBKa0mJ5TVjE6IBR25Z111pWoTmwbbTxgm8It/y2/v
         VP19mRTlGIR448YhsVe5OtN1AD70hpEjPH/WfKperzXpnJOtX3NLZpO0js31kJW/W/j9
         c8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752476780; x=1753081580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbwGy+7N2iezorbGT54iwugd4pW3kzbl1P6qDvgzttI=;
        b=dJJucgvTwYpzUNxx78wEv3f205CK305uTMWZ3wJ9Gkoq2+S1XaV03iNX50GNfbsK1g
         F5S6vghLQ9NjIc8H9XERwc2PAczGTVNpyztZW914eOhXy0R/c+bdN4XHKjkj3pKnuEX8
         VWs5rud9FAE5aISQ/1jJ1YPabnCgKXy7PL0m8t4xF2xEt6PjFFpk0OK1q2L60+C8LeL5
         IwD1rWoazstLVZD55nb+Dzgy3xNCy1au7jIGCBeaOtzaxSAfIQ0MiCoCfzNFGqMJzEAO
         fZogxnatPRWXtMvwdGoCd1A/KG2K/MvGYWqc7GGSieju8KbOSHwjH7TenDTbm+gq9v+T
         8Snw==
X-Forwarded-Encrypted: i=1; AJvYcCWvXDYfREY2BiD76fNc7EGJhDYVKjPw1hp7Uu2ipJB8cqkccuy0tt+OpohrbezAwas6DAk3N0knGzN/+Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5gXJhlluYBjxkGYvgKBIWjoc+AXVEYXuvFTl8xmBJn49jFHoH
	IRMgojbnvvCS/d4BBg6W78hXaO0KZc9n2f3kfjESBHn3jeCfmhYtYB9V
X-Gm-Gg: ASbGncvESWES3Zx2oZuLYDYhUejGoLmIBnFW7MKGcNiF560vQBwBWarOTRgTiuTI9j5
	KROUxeUJkbzUWWqKudc6gh6tJhtlGLEC6MVpaxFW8u+gJSBYV6WA6CK40/c8TKtJJI0PLD3emN4
	ksYfvOHfq4Ma4qjJY4MWKb5Q4xouxd0U0kXY1ltellVvt+OD0i8Tm/0R9xggf5JxCBZKpvY5Jov
	gd1SlZrzSRibNyKPZTZ906qjfvayG/FZ1capLben9IwYCAZDedCjMh1vuh29ZAW4rtNq7gJF2Ki
	PL9S4VSaU5D64XuTqCCUNPjZcVPoS4x+1gArezNMP7dNeXtwnDPtc+X4cyAcPCWMUCzzrPvOtJb
	dXIUC1BN7aN5mB8r2TWS6Xud0znnTOHwtrYOzejYs10C6bOfRiXiV9/tDjWxp7RqHdBbh4WU=
X-Google-Smtp-Source: AGHT+IGtEK8NH/1+g87Cg1i/il3ltg/9D0sy+nxWfl6kkzeUnzh0mkmqkPhzCBWOKCraKhD0HFqMzw==
X-Received: by 2002:a05:6000:4b19:b0:3a3:5ae4:6e81 with SMTP id ffacd0b85a97d-3b5f2dac5cdmr8491540f8f.8.1752476779824;
        Mon, 14 Jul 2025 00:06:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f16a6016sm9675663f8f.69.2025.07.14.00.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 00:06:19 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:06:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 u.kleine-koenig@baylibre.com, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 rostedt@goodmis.org, lirongqing@baidu.com
Subject: Re: [PATCH v3 next 09/10] lib: mul_u64_u64_div_u64() Optimise the
 divide code
Message-ID: <20250714080618.17f689be@pumpkin>
In-Reply-To: <n544n0n5-7r7p-n3o6-67s7-q03r026qo1r4@syhkavp.arg>
References: <20250614095346.69130-1-david.laight.linux@gmail.com>
	<20250614095346.69130-10-david.laight.linux@gmail.com>
	<20250709152420.4c95c22d@pumpkin>
	<20250711221715.37b0384b@pumpkin>
	<n544n0n5-7r7p-n3o6-67s7-q03r026qo1r4@syhkavp.arg>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 17:40:57 -0400 (EDT)
Nicolas Pitre <nico@fluxnic.net> wrote:

...
> Kudos to you.
> 
> I don't think it is necessary to go deeper than this without going crazy.

I'm crazy already :-)

	David

