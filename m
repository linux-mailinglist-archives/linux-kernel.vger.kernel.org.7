Return-Path: <linux-kernel+bounces-747903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E606B13A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0FE3A151C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663824E01D;
	Mon, 28 Jul 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/Vsha+r"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1E748F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703501; cv=none; b=Ad1fT59WSbwib/HskYYuLMP/piJK6gkN1vKMQxuAKldrHnx8vQvgxzH834gpjx3x5hUwkR0Jf3GCI0772QjPRKUq5JLFA6PBMPtUYETq6RHisZ2y4+10ye9cFtLIi+Ol8BStubkYnfImaIpVDPH+aN9R15rclfuXvDHtZjnMKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703501; c=relaxed/simple;
	bh=7UjaG8l04hS9UxuRyugAlMhtY0HkChf57lbz2h3Uwxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJYJoRqrZzjPhzul4jvd7w8IphCAy+2VTdXuS15yRHo1742TZ+G1Mn3DZb7wXU/KpOWYJZNM2h+TuU8pyGes2oP8UCbm9/Usu3sC56KRiJ0rb777PpEymCzYUaIhYrsEym/ZNMbVyaZXJocaqVD0MYja+HVur+rymPtWcvq0WSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/Vsha+r; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso4067109f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753703497; x=1754308297; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l56t6uPmq3cSkV0C7DGr6+BsykVsDYraodDtRGzpDuE=;
        b=N/Vsha+rCx6eK7Z8ipJAXUJyLaosrwcM+veGRBcOWes9l7qRSfHLjH93F7+XCPDbdU
         oEhX7wlqNHb+9rq4waD3FrWeVMf2NpgRWRH5dqFmY/64A9MuvBc51xuHQM+BcWVZXWIa
         8Yi2xSoj84UHYz/tMApvxVcwl18KB418+YgeIXp1mzfXQGl9hubm+hHjFvYzZpeQUw4O
         lIhI9JHi1K39vPhs03ao/wvGyt4KKU8+dINKYyAqxzgq/4Qy84sgYpZPrMCXpG0VPaBR
         v+69iC1xqxnguQ5PTkhkYjVpqbACBT7yAtghjHiA/JLtpXxCUkRWnqDUJ4+fo/tADMlt
         AT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753703497; x=1754308297;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l56t6uPmq3cSkV0C7DGr6+BsykVsDYraodDtRGzpDuE=;
        b=fVHCNRKhLZNK3e/G8mxc0RPw10N6o9vgPl3lka0TOS0uVrKJ2fJDdnjdHzdKYlhEG3
         3pNTlUtGxZuxkVSt+DaJjKFfzfdrIPk0lGrJPXZj6Dk/difkN0HOWW4Q2IHMgxS67pnb
         pZpOQ2mBQxCO1QmxPU0V0qdwcQML4PfEoIfsCMfEH0gD6RpMAx0OkRatg9754gAa2JS3
         JXoHR44DOG1euZY29Tak3jRETAiO409nWxiSx/FJ6WQ0Q7Swqbdvz3mxPCOUJL13Plxh
         tbQ2P/rfXQg04qcI91eB/WYLeRkixWz59zwYayOjGRnE09lYB/Wx3RDzD6OGad3hDyH7
         bOuA==
X-Forwarded-Encrypted: i=1; AJvYcCWB6Ii2K5TD3k5RLXAzRf9byJnYF56PL51pPXh0MaW5TgUJszK7IutrxUR1gqoOhiCspetbuCQ7fU238pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jWonVv+Rl71BfHBVhLNEp3z+tHLbM0HTINd5KTAIzTSaqXar
	Djt3WJ806KCdIL8nBccxC3GFEcj+HzA/aUQHnst4cu4giORzqev1VkVtLVpuguKlZw==
X-Gm-Gg: ASbGncvi1UneKjCpfEanYbSzujKiWj+JgaCkrTcQzHpxcgbR+9t20S60u5hbmyW6nXM
	JaKSe4QXNuXKhPKiFn2Yi46L9HJO/aMYcvvdFHqJCP4/BwNAX4+C7OIcxZMCldeeaESb9PcwGYN
	nljZcuny41f92njh1R84UR3Qta1okSVxHR0ZPFSPV2LeMh68INWfcmWSliJ9aErst3Vei/mfkHF
	eHDiYoz34z8WTVyaTBXy5zCJOIFcBblrJBqodp+s19JVfOK3TAxcREkD4Wd7p+QHn+aNSz9wZ1r
	t+RuoW96308lqvNSKx4FuBFjkev/4SfCqPS19iirUaStT0LGl/fXmodD7f21d8DmoBNzQDLf4sa
	W/J44W8jLurWGkPnVLZXM/7dpo7OIcyLptR77Ehan19be1FfBUABaOMturevd5RxXc4QZgA==
X-Google-Smtp-Source: AGHT+IGGgazuqAKfIj0U8lN/uNJI6ooOhXjLKWL4bt9P8uWewhRK9Fw+CVIEYPj6Bpm5FtOwC7mbaQ==
X-Received: by 2002:a05:6000:2dca:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3b7765e5877mr9262604f8f.5.1753703497322;
        Mon, 28 Jul 2025 04:51:37 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:4524:5552:e4f3:8548])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac78af2sm96075685e9.33.2025.07.28.04.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 04:51:36 -0700 (PDT)
Date: Mon, 28 Jul 2025 13:51:30 +0200
From: Marco Elver <elver@google.com>
To: Jogi Dishank <jogidishank503@gmail.com>
Cc: dvyukov@google.com, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, rathod.darshan.0896@gmail.com
Subject: Re: [PATCH] kcsan: clean up redundant empty macro arguments in
 atomic ops.
Message-ID: <aIdkQixt-tfT7IPw@elver.google.com>
References: <20250728104327.48469-1-jogidishank503@gmail.com>
 <CANpmjNN-xAqYrPUoC5Vka=uohtJzhOfJsD9hhqhPJzQGt=CHGQ@mail.gmail.com>
 <CADorM--0n1zeT8jxT3LtjmqrP5Cp1g-hFS=oz_12SptjZwRWtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADorM--0n1zeT8jxT3LtjmqrP5Cp1g-hFS=oz_12SptjZwRWtw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Mon, Jul 28, 2025 at 05:11PM +0530, Jogi Dishank wrote:
> Yes, I build the kernel with the change.
> And it's build without any error.

You have to set CONFIG_KCSAN=y

kernel/kcsan/core.c:1270:1: error: too few arguments provided to function-like macro invocation
 1270 | DEFINE_TSAN_ATOMIC_OPS(8);
      | ^
kernel/kcsan/core.c:1261:40: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
      |                                               ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1270:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1270 | DEFINE_TSAN_ATOMIC_OPS(8);
      | ^
kernel/kcsan/core.c:1261:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
      |         ^
kernel/kcsan/core.c:1270:1: error: too few arguments provided to function-like macro invocation
kernel/kcsan/core.c:1262:40: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
      |                                               ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1270:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1270 | DEFINE_TSAN_ATOMIC_OPS(8);
      | ^
kernel/kcsan/core.c:1262:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
      |         ^
kernel/kcsan/core.c:1270:1: error: too few arguments provided to function-like macro invocation
kernel/kcsan/core.c:1263:39: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
      |                                              ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1270:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1270 | DEFINE_TSAN_ATOMIC_OPS(8);
      | ^
kernel/kcsan/core.c:1263:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
      |         ^
kernel/kcsan/core.c:1271:1: error: too few arguments provided to function-like macro invocation
 1271 | DEFINE_TSAN_ATOMIC_OPS(16);
      | ^
kernel/kcsan/core.c:1261:40: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
      |                                               ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1271:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1271 | DEFINE_TSAN_ATOMIC_OPS(16);
      | ^
kernel/kcsan/core.c:1261:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
      |         ^
kernel/kcsan/core.c:1271:1: error: too few arguments provided to function-like macro invocation
kernel/kcsan/core.c:1262:40: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
      |                                               ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1271:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1271 | DEFINE_TSAN_ATOMIC_OPS(16);
      | ^
kernel/kcsan/core.c:1262:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
      |         ^
kernel/kcsan/core.c:1271:1: error: too few arguments provided to function-like macro invocation
kernel/kcsan/core.c:1263:39: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
      |                                              ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1271:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1271 | DEFINE_TSAN_ATOMIC_OPS(16);
      | ^
kernel/kcsan/core.c:1263:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
      |         ^
  CC      lib/crypto/mpi/mpi-cmp.o
kernel/kcsan/core.c:1272:1: error: too few arguments provided to function-like macro invocation
 1272 | DEFINE_TSAN_ATOMIC_OPS(32);
      | ^
kernel/kcsan/core.c:1261:40: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
      |                                               ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1272:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1272 | DEFINE_TSAN_ATOMIC_OPS(32);
      | ^
kernel/kcsan/core.c:1261:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
      |         ^
kernel/kcsan/core.c:1272:1: error: too few arguments provided to function-like macro invocation
kernel/kcsan/core.c:1262:40: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
      |                                               ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1272:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1272 | DEFINE_TSAN_ATOMIC_OPS(32);
      | ^
kernel/kcsan/core.c:1262:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
      |         ^
kernel/kcsan/core.c:1272:1: error: too few arguments provided to function-like macro invocation
kernel/kcsan/core.c:1263:39: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
      |                                              ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
kernel/kcsan/core.c:1272:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 1272 | DEFINE_TSAN_ATOMIC_OPS(32);
      | ^
kernel/kcsan/core.c:1263:2: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
      |         ^
kernel/kcsan/core.c:1274:1: error: too few arguments provided to function-like macro invocation
 1274 | DEFINE_TSAN_ATOMIC_OPS(64);
      | ^
kernel/kcsan/core.c:1261:40: note: expanded from macro 'DEFINE_TSAN_ATOMIC_OPS'
 1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
      |                                               ^
kernel/kcsan/core.c:1193:9: note: macro 'DEFINE_TSAN_ATOMIC_RMW' defined here
 1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
      |         ^
fatal error: too many errors emitted, stopping now [-ferror-limit=]

