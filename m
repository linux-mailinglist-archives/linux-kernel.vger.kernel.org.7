Return-Path: <linux-kernel+bounces-893796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CAC48627
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C76188B1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A52DCBE6;
	Mon, 10 Nov 2025 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKQrz37d"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999E2DC337
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796321; cv=none; b=rt3iKm9bOCXUSTx0xFpF8IWMHSxh+7fa+twEFM/pKzH0Or6ONGiCLBnb1EP8xNM+qJL+xRXAd6kEij21XbwRFqQB9ka1UHiCnGJ2n0RRPyh3psegrh+CiqMETaYpEDU1PNeI653W6xFos69k9PUpCRUPzbiQVYVSX2uBjU6W6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796321; c=relaxed/simple;
	bh=M1o1kOh6VqP4CN6/zqp8bynioGZKC94OCphZddFeq6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tF02GHVpx0zHqV0kN2k2imCRWkGJ15Dh2i1GQaJUDue23Xu/ASsrY4w2evXPRvZQ22OD4/QeQBpKqXIEJXs5Eb7Z4Q1fy8/PNmrZvax3vCGyhrk1W1Ea0TQD03XWqFrYGYDUXA/RJFI60mDQhj/UB3/XAEzPdJNX5tgwwrn1Evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKQrz37d; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda6c385c0so20086751cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762796317; x=1763401117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YSOpGWJwXMs0s/g4qCwlIsfD5sl3RCmHWkcwp+GKrsA=;
        b=QKQrz37djniZBKn9uHMmxnFLXbTU+N404fTvpLi2IVx4Fp5KARKFMni4pECj0Y7Oqy
         TJTFGqPshOG30+TByOWsumL4SG/47k51TSX4bSXChr4DNUjwSqLZRBCLGecp4+DOElfE
         4kkIl82doNAwf1TSq0w4+9Kr9i0yXHIYPX62O9at/fp+qUA5cT8OlLyQJrzWuVU3g+M1
         1YPbBVYy3+kxCB/SijXCX7Os0jrxm5u4I4CSNakSuTBGSjjHbLrCRiMpoOiw4IZgHDrE
         lPWPu3jEj5Gd1GfXaGkNWzPhS6nk49Zz7Yup1MSumjddXPOWMIeWKndH50GGN8Y+kl1w
         9vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796317; x=1763401117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSOpGWJwXMs0s/g4qCwlIsfD5sl3RCmHWkcwp+GKrsA=;
        b=Up4EKMAcqLSgiUsAbsuFpAaIGnxW5Vxi+1Y2+QLGxXi4/J+OqTW1NY1iAOgqzJu5e0
         GoZNYxC9un6ugeSq8CKWkBgnvpn0Jpawseop16p5GzSZMBb4QP7oEG8bUhF62ojso2Dn
         a9d8tfdHiMgwmgYZH6gMFXD68tUIfds/EBkX8q+05uE0aW78dCWRWYaQ8YLD/hxsJpRM
         7rsINpceIZxF7bgzxCJWreOVK24iF/WoH9UF558ptaIe/WNH4VCtQkXpYJDw6VBPO6pK
         K7ys8ZrjM+QLF7VpF3krf7s8ZYj5rG1lkjYOqOkHRSYlGHzBTVzwSMZXYckSzIZrG0yZ
         JlNA==
X-Forwarded-Encrypted: i=1; AJvYcCX0XN7sgb2cL6KaAwWr92WgtlKExIYkx4O7Kq0RXdZzgZOBB92N4To9+5amVR+bkZcfuyNc4Rpbo/RE3+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJBjODuYhRUF31Q3d1NcmMyy9U4HaQgqY5WhzjxnVJWz/osYVk
	xFmIFLH6vN+w+8QFWh4gYuRR0bq/YESiuNhUEqjeYRfWYnGHqFbkD+jesLGGrTWBRNXQmObZc6s
	YU8mRM/eKED7xcBmh9B3HfE8lk5BZInKqMey5bEHk
X-Gm-Gg: ASbGncsK251Q2f8SmIi29t+0Ucavs13p/gZzlMP/oo99YfVcyjG16fECK50Cw5qu4z4
	gzGEY82rlk511sBTQ3FGgxqJOp1tMt25gIQJHftZ8ce7LS6OLaGMr4eqb9i08BNfATEk/6NJXS8
	VsnNyXSa5Pcap/ZrelcFASImPxlXSiRkKONQVpWnzLod5ERQQC1u7ft0V0lqe47ZDnMGI/1BE+W
	yHw05HbLUka0nq+GPzgxsFltURDJ6GV7DzD9cPrOc9VZwHq65qoJpGHS+ymTRdBHw2tP3nyai6I
	eO213qpVT6EOL3L04yvoD2fCBw==
X-Google-Smtp-Source: AGHT+IFr1gTkxV/2KbejHCAfn9cmRrtPm5R67TTLAIre2TRAH5dAXb9YnE16dsLdFYHK6GdY4jiLnljrS99RBkOdtpA=
X-Received: by 2002:ac8:5856:0:b0:4e8:baad:9875 with SMTP id
 d75a77b69052e-4eda4e70d87mr109099991cf.4.1762796316364; Mon, 10 Nov 2025
 09:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <8319582016f3e433bf7cd1c88ce7858c4a3c60fa.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <8319582016f3e433bf7cd1c88ce7858c4a3c60fa.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 10 Nov 2025 18:37:59 +0100
X-Gm-Features: AWmQ_bnlgBiH0JekOxzwX-3tPMF5D_wHyW4PzCjMfs9TphH4P9izG_-i06SXddA
Message-ID: <CAG_fn=VUx7GkcjuYO3oRH7ptgKVtzQNChW1xKL+1SPfJ=XvWwQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/18] kasan: sw_tags: Support tag widths less than 8 bits
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +++ b/include/linux/kasan-tags.h
> @@ -2,13 +2,16 @@
>  #ifndef _LINUX_KASAN_TAGS_H
>  #define _LINUX_KASAN_TAGS_H
>
> +#include <asm/kasan.h>

In Patch 07, this is changed to `#include <asm/kasan-tags.h>` what is
the point of doing that?
Wouldn't it be better to move the addition of kasan-tags.h for
different arches to this patch from Patch 07?

