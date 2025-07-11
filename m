Return-Path: <linux-kernel+bounces-727000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA2CB013CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C26765B07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B401E5B64;
	Fri, 11 Jul 2025 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QipzuUiJ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B91D7E41;
	Fri, 11 Jul 2025 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215867; cv=none; b=E4NfvRPww5nXvUluGo9i1r5LP6T+DrJ3n96B4BJwVB8gqHnFGuk0dMfCC0+fhHVQdwKSq+StXnTNA6gnfBJm7KJ0RT90EKu6vBakx5ZbNy0pL5h9MBzKoVvDVOlwvncNxGIudMJXsRLlDTxeg02xWtT2o6qhdtTGVr8n7V0apMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215867; c=relaxed/simple;
	bh=+92Z+FUUoypQuqY5xz/8dtqwZymTQ0o9rqfuQb7P+GQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VHWGXzN6m6KIoTSrrObjNh50VFR2hdNaw+LKeP7xySZOiG4gp+NLQxQUik4FmzaoKileek8Amdk4RoxDg9oGCmjeUHFqmiiMhI3xCRTLmikWS0aA4npYcl9v8LHnw0Kb+dVHRIZNvyVABz2WzCBmkNZi/iODcJDiG15exKkOC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QipzuUiJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1091426b3a.0;
        Thu, 10 Jul 2025 23:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752215865; x=1752820665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWVBYX+9nANi9PWFhLvg2cm2pn50jQ0pbBq///a1828=;
        b=QipzuUiJaH0mgBsQ3jiVCveSeR6nV5pMBrhNm4ygbb3u/95JFfcqybTvwkMU2HXYy2
         I83zcExHDfc9tZbD9nbJ4Nfngs9yTN4D28NRZCcaesfqxJDzh5Ym66MQarg1dDM+bXrt
         /X78g2f57H+JhHHg4l7nqIxl0INnPVcUwXivHGJxGORcO/x53akA91LVQO0Vkt+piMNz
         mnCznxMz9i7Vxm0tvlk+aHvMpPm+Gvp8ZIMVHqCAwsl06ml5trMgClCxg/xYFddyQAn7
         uAo+vup5fBqArTKtNmyEuR7rLr5r+6d/lm+QWxYiFAMU/iLVeUShrq2haTvJq6BZBVmY
         M4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752215865; x=1752820665;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MWVBYX+9nANi9PWFhLvg2cm2pn50jQ0pbBq///a1828=;
        b=NGD1coBRx0Xk+SDGgmqBT86FN18u5d46DbPHCCHexjZGbLYcvJNfXfW59h343SwmUO
         GWnErrqEaSBUSr0M+laEBJVJSN5puADDsMWL2IvjwsRcYBaS5GUdViaPytAKz9MtRaeP
         bB16SI0O7FvgVk0jV6kVNKA3U//57TPESlfyMultQu31gHQkjTqbidlqpEB0vdW5u1Cp
         JeCXDYpD2hZz49kFfYMsc27gBz0BdlVdWNgMQ15lfPHsQtQi9JQfDW8NPaAN3iIriM2h
         O6PQzTqmAhqhyl/pMbXbmSUbwYX7GcwED0NEcWBmAcAju1PaLBiXS8MeGk8Z6DW3ARnO
         reeg==
X-Forwarded-Encrypted: i=1; AJvYcCUm2U4vHcbHK3axKb4Kj3u1sRA0dJ6AZxDg8Qg+nogouWteqylcDefAOMeqr6Na6PnbZl3/wCLWJKsnwbw=@vger.kernel.org, AJvYcCVj/TUMoiO7cnxS5ucNdgNYOBrf/QIuIpm83sCwc8ogZN5TSWRQMFJtOZEFbKwHb5+n1QhVEyK3wmZqELOdzag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2ygkYX1Cj7UHbdpd+hn4MifSXY/38S1ybdQHxrZoJXBpb4Bf
	jQe3dB3gFxUtpZq6gqOrrgXAM/F2ot0Og4s0jZWT4XKI7Uvp8523G8fp
X-Gm-Gg: ASbGncvclsbKN2GG+vSUbTkEpdAg6LRMbjs4ifiLkve4WVMTAUY69zoG9cJd+gYVie7
	XAPrNFOFn7kXqv+qC1VRiVrt+i0luxkJ3mmWX6opUtTbFCfujEaz0VDs5AsNZFZiPG1oQrQt84e
	NdGW5RfsRAG+EwY0A+QQA7eGBa02J/SrpxH6YcuBqjiiOPxLV+orCVss7tNfOrRqmxZ3LSU36I1
	SG5moaJo0DlTpZwCm46NwXaIl7Mxk2CPwU4EFHRLI6yKFcUxIJdUXi59eQgzV+Qy1QQNDCRuQRN
	Ai7tHF/6ZelA/SNafeAUHC3acySFbubs79mT6K9+YxkjWqhQ/cnEYq3RQjfH8rnHPGZKStAepKC
	yV/s3gj2jdz1n0R8jYOI1lZIermk69S5Sz9+HR7tdEvqNFvK6l+0xa5iSeOVI1dnZK+tYxnER3s
	QQ
X-Google-Smtp-Source: AGHT+IEl4Ywkt/9PNpGKhiAIs79JkWdF66D+n8fpCi/tOVoJS4t3LUjPub04mIJIqxrggB2UQ5NtZQ==
X-Received: by 2002:a05:6a20:43a2:b0:220:2d0f:f8e1 with SMTP id adf61e73a8af0-23134c5569fmr3447826637.3.1752215865507;
        Thu, 10 Jul 2025 23:37:45 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bc84asm4114972a12.44.2025.07.10.23.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 23:37:45 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:37:29 +0900 (JST)
Message-Id: <20250711.153729.1327324726276230605.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: lyude@redhat.com, rust-for-linux@vger.kernel.org,
 fujita.tomonori@gmail.com, boqun.feng@gmail.com, frederic@kernel.org,
 tglx@linutronix.de, anna-maria@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: time: Pass correct timer mode ID to
 hrtimer_start_range_ns
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87jz4fi72a.fsf@kernel.org>
References: <U1GgPfpPwSjzh5jPpFlN22bT2BSjlaH8vLHYY6hAt_vJ5w4irwIYRPV46r73Cs5Dx73Ikz5ku7_qPWrl8Tntfw==@protonmail.internalid>
	<20250710225129.670051-1-lyude@redhat.com>
	<87jz4fi72a.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 08:18:37 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> "Lyude Paul" <lyude@redhat.com> writes:
> 
>> While rebasing rvkms I noticed that timers I was setting seemed to have
>> pretty random timer values that amounted slightly over 2x the time value I
>> set each time. After a lot of debugging, I finally managed to figure out
>> why: it seems that since we moved to Instant and Delta, we mistakenly
>> began passing the clocksource ID to hrtimer_start_range_ns, when we should
>> be passing the timer mode instead. Presumably, this works fine for simple
>> relative timers - but immediately breaks on other types of timers.
>>
>> So, fix this by passing the ID for the timer mode instead.
>>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> Fixes: fcc1dd8c8656 ("rust: time: Make HasHrTimer generic over HrTimerMode")
> 
> Wow, thanks! Miguel, can you take this through rust-fixes?

I think that this patch fixes the commit in timekeeping-next.

`fcc1dd8c8656` doesn't match to the commit in the current
timekeeping-next (this patch might have been made against the tree
before it was rebased).

