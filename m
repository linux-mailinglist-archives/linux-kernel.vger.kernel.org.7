Return-Path: <linux-kernel+bounces-817365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF55B5812D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CA77AE058
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C612264DB;
	Mon, 15 Sep 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KjVq174l"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46A1FC0ED
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951279; cv=none; b=cyVGiga2PZz3/Yun84QE4ti0QTVdoMO4j600N4JpQeIiiMJi0J2ySLoPaGo1Ma+hlRwxYInqaYgm+K4tpeFqW9ZiWPCsXXmuqFKIwZShJo/a/p24mD/yXtSrHoKUdnNAYih++m+yjrUmSZta6g5YM8f6U2qGido2fvfwsKK1fVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951279; c=relaxed/simple;
	bh=2FgZf+GYVPbUDHE9BFwH1ejC8shiR73nOyJCnPx8AuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QchjVhlkm4BUrMUyrJNZv8C6FHsEsGQNaW87/A+uL4BGxh60koyMbfUhn1GPbjMUrkoHPjwMiq7JqiTTID0Bf7CDKZti1p+uJU5s9f+FjyN9jOSeFHc5v7jm4sxchd5axwrPapeXAfpBunUdcwFf79Nw7WP0ZD1+XuWQoMHXcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KjVq174l; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-765936cbdfeso40687386d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757951276; x=1758556076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF9n47OKYupJ+YpHurEgKB2LmOn4YAEsHDSQn4dI9Aw=;
        b=KjVq174ljwRmsAi7qKBFRDK+OHoFxIccpHbYx03I31aN2EsjyjBBTyOU9i3/Ymsaj1
         nAFCygwQKRkZaJByczucDuMZebKhh3+tW9m5iJHOVU6sTy5JS+i8cGbDII3k37zDlR1w
         93cnebB8d8MKobhjDBrY8ySqyVWpSyUMWWHVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757951276; x=1758556076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sF9n47OKYupJ+YpHurEgKB2LmOn4YAEsHDSQn4dI9Aw=;
        b=m2nW6ViUiwHM+vaNCVCX1UpzzcpeakRlMeuVZ8pJNUNY3WzkfbvAXOyZqMxL5hrvuY
         QDWYR6hYmUK+4m/q9MXdyZgNZ0iUBdJwzpiStME9cuzPGgyxJjSBYrsW6ePaKZfT2QvL
         HJ0rF18j/lunuh+Y+WAg3XVeqC5kXnY5c2KfSqhRq1YyEI9kKAUVBfUTobjylEX5Vq3x
         p2xX72r7NYuC7wzIahjrE3+hbwuL/mUr+Ji70P1tTJ90myh22IU6vQdKs5tzKoCwDePm
         2EqsOEmWVZRca06880DJK55zwbA+lTYrJwGB2w5EDU2jFtuOoQ98H947D5D4b8zIisEU
         adyA==
X-Forwarded-Encrypted: i=1; AJvYcCVf7y/MjCYDb8YOvQ/GqjUMVKqhZYAWBZnGT0MrQkB5JEW1et+yKmTMIJ780rkjxzFaoD1hn/qSrDpo4iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFaHDhvirt6kEo6xtcDgDapUVFNP6U7gE1JxcPIbDMalYeUVC
	li2tB4daJyrGrMFD5GsZK/Cx0VuMTI3u32RJ7ngytNQjWNEvVO9NS27UG0lrBCW+AhXguivhNUf
	hTaA=
X-Gm-Gg: ASbGncvlfnW+tAJOPW7mFZizppdM+nXKkvkmh9EW7eqORpyQHD2YRihGeClhDlVeM6+
	5M12UJuk90NoAlbW/ZcaKZ7j6LJc5ptHqLo6WkUTNyv3FwTgzdPg5UHUl3MYPlAW9/OpQq1jWH3
	Eo2T5KCtjYHD5WcYwT6wXMagW5SX4898F45fdxPIjIF0He8XaTSQQRs21eqjTXI4por429iYESz
	TnS4V2JBWLj3L5p+o7cMDGJu4lQp06rawOiRdX6p3carFG3TFqq6tcQalyvDhXmDot8tcZvP0Cn
	tlBf8wtSDuRtZCh/ZrTXnSgcBSWbya9Pf7s0Bhc9SJ3B6HOQ3gqw/VMYa2nA06mDgXQhm4c0EsU
	AjeUe7aPyJwf4Np481CU2T2KO4lrqlkHKvYpUUImpapw0s93ZNO4NsRhikxHg3g==
X-Google-Smtp-Source: AGHT+IGSxbu1toZ8p2DmIdcBCpmshyRujfnymbIltPQYCzhPj3v13PQl5m0fG/VMYJpPMwInd1drQg==
X-Received: by 2002:a05:6214:6111:b0:76d:6a5b:383b with SMTP id 6a1803df08f44-76d6a5b38b3mr115823216d6.63.1757951275995;
        Mon, 15 Sep 2025 08:47:55 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b3f498f8sm80454416d6.8.2025.09.15.08.47.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 08:47:55 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-765936cbdfeso40686886d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:47:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyYBVX9mgK1qrAvzqsjBKbkJcomXZ7MT6jNxkXyR9vFQrLcqJxZiN7tYZX3NfTjoOXt4i1TeXbr0igj1Y=@vger.kernel.org
X-Received: by 2002:a17:902:e80c:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-2640ee2d03bmr82023175ad.19.1757950933588; Mon, 15 Sep 2025
 08:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck> <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Sep 2025 08:42:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
X-Gm-Features: Ac12FXzAoIBOvB7DdouVYRPtMAe3U5Dl3CUX53Fx6WzMzB918sSg5cv2FslrCvs
Message-ID: <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, kees@kernel.org, 
	masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	wangjinchao600@gmail.com, yury.norov@gmail.com, thorsten.blum@linux.dev, 
	x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 3:35=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Sep 15, 2025 at 11:26:09AM +0100, Will Deacon wrote:
>
> >   | If all CPUs are hard locked up at the same time the buddy system
> >   | can't detect it.
> >
> > Ok, so why is that limitation acceptable? It looks to me like you're
> > removing useful functionality.
>
> Yeah, this. I've run into this case waaay too many times to think it
> reasonable to remove the perf/NMI based lockup detector.

I am a bit curious how this comes to be in cases where you've seen it.
What causes all CPUs to be stuck looping all with interrupts disabled
(but still able to execute NMIs)? Certainly one can come up with a
synthetic way to make that happen, but I would imagine it to be
exceedingly rare in real life. Maybe all CPUs are deadlocked waiting
on spinlocks or something? There shouldn't be a lot of other reasons
that all CPUs should be stuck indefinitely with interrupts disabled...
If that's what's happening, (just spitballing) I wonder if hooking
into the slowpath of spinlocks to look for lockups would help? Maybe
every 10000 failures to acquire the spinlock we check for a lockup?
Obviously you could still come up with synthetic ways to make a
non-caught watchdog, but hopefully in those types of cases we can at
least reset the device with a hardware watchdog?

Overall the issue is that it's really awkward to have both types of
lockup detectors, especially since you've got to pick at compile time.
The perf lockup detector has a pile of things that make it pretty
awkward and it seems like people have been toward the buddy detector
because of this...

-Doug

