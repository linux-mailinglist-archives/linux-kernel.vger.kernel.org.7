Return-Path: <linux-kernel+bounces-885913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B948C343BF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55691897836
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB082D372E;
	Wed,  5 Nov 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kloU0qfy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B012D2483
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328007; cv=none; b=H6tQ2lFDLf69tWGbm4WhOuf/rtr0CyXF8Q+tJlpEWe7djHvrmuphPLO27B/FQFjFLz0xAQiFswbRnPGErRHf9X7W2WAanhpFZVVdLk4zpr35LrnzmvDlVCPZInQOBYJV1w+JqL9Vu/09eFGRankTuKlRjkeDN30sAzsHkZUQK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328007; c=relaxed/simple;
	bh=DDaCbS5eQ5rAhivigtNpf/DuFwnezvzyln+B6kkKZXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hmu9b7nnhwGOyU2UFHh8xR+NBXPS/tTRxLts9uHlMjbq++cD8DRS2Dzq6YJcfsULuPfM7CwArZ/ZefWGHX+KxNc4Rpsfpmbi4V4ErNW8lvuMcXRJG7Qb8EUppKSFjSQB6ZCw6ddbDzDuQjaSxYTNBlSiIJPf4DhSA1YayJxQn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kloU0qfy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2956d816c10so40957425ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762328005; x=1762932805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mgd1RgFz8T9cqpU6ApJmDoOMdsD64BrgKz2Bds3lYc=;
        b=kloU0qfyt7942w9mk5lKk/4+qcxs6yi8+hwh6VRieq5xQX9QV9T83hlUs+JEOzDRup
         YN+/yCp+0NlpXk9C8kndSIaYSy0HMIHtcUy5Ao2lU7Pri2GcbY1r/dHijUzKg+uDzOHA
         ObHCZSmEZQuvoUgAaIt9P7R3mkPGpLzvCgJ2IlXC+Qi+k84Gg+TSGsIJ/Y493vOKJr5y
         /7NB45RnhdL7HB+kPDpWiHGB+3H+yuS8gWJzvHRi69hehlCn2I6D+WZcoq9GMUGo0j0T
         if8akd3knelatLDFjaTNffmoxnF9UhJ52/w/mN+YAXc4Fr1jP4zuHjJtuRvE9R+o72gC
         nGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328005; x=1762932805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mgd1RgFz8T9cqpU6ApJmDoOMdsD64BrgKz2Bds3lYc=;
        b=q1JtE74lRHKipwvLbyhdqzQvp79p6Cfw5zQBaXkF1I0HMhpiJdSBHt9R/KjhC4V6c8
         8TSqLIreW4S/2dPdL/gm98JVT3mYswzHps4s1I98ICoY6klghKyyEBpXJ0gUbtUrDuTp
         hmBiJo2O0ZIKLxcbWbHSDwkyYYo4W8xnJv7qZIrJnpdPnnDG3bfSvxX5u8NVVbOW0U9j
         sAE3PWdhZfU9ZVcyZsEKSKGlCzOure7f1vUnIXTG9LGJABk2e9Ov+FXX/6FkS2ZiErOc
         723o8rhp6SF3nlY0FZoJjXsd9FpybZWxaCUUieueIdeb2EWFQKfJP2pWj1MksebRa1Pz
         uAJw==
X-Forwarded-Encrypted: i=1; AJvYcCWvAsyC+erlMfRrU/t3wR6RPw10LvFXuPlzOw3bMt3VI4UAFQ+64JjIz3HeXwm37IlE4b1JRfMlPjNYMgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpsBRh7hFH0Y2yofEIsW3ND5dKxP2GtimDi/1vmR/RJkw6e+Y
	F5PX+YE3rp2Nt0hI/g8BVsFdn5uMMNkz2vBe01mTTtU5HonzA+fyKsvB
X-Gm-Gg: ASbGncsPbsRkwkO/zxker96vHRRc1ZE+etExIWbWYwHyoo1i4tmRP+HxpcXnYV4UaAg
	Kb8aps5vVoGBXTEnauZ4kvzvne2txI0J9ZZCj7LkcO7n/zjtFwmKnBGvZlzPlfx0dy4uOt/9idu
	0Jsmcp+WEIdpF+csgj/3G9txwTZ8DfsVdgzNao2nql968v0TTPCvseu+E3nDODw7DOVXxZhp0oi
	yREgQH2NB74TeGr4xiiuhwQ2QGHxu1qpvwjhlbaRbiPCLkD3u1/peu4djGhmMrDmvgjdnsqWDQT
	3Ox+u1GmQ8cgQDpXzCVnIo5yCzUwv1jeSgkescF8svX7gVn+UvRZozBbCSyrYDiF6iqvp1b97gB
	6KH0q/rAdxmr8jx9TkLoPhX3gL/7DSfYfMqAX6z0N0A1gRRzO2Qajo6u8yYfqaEyvrnKhcduVMw
	tm2+prmzHYp9vgCgLCXvQK7gfuDD56Yl+a5q3+2vt0OmOLcA==
X-Google-Smtp-Source: AGHT+IFubJwKuqWd8pVU5sU0Dqp6g9b5LXMrACB9qO8Ucy5yzYtRavb/690KX+eucTG0f1YcnGaOIA==
X-Received: by 2002:a17:903:2381:b0:295:8c51:6505 with SMTP id d9443c01a7336-2962ad95597mr33842095ad.33.1762328005013;
        Tue, 04 Nov 2025 23:33:25 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998991sm50485145ad.32.2025.11.04.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:33:24 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: will@kernel.org,
	bigeasy@linutronix.de
Cc: ardb@kernel.org,
	catalin.marinas@arm.com,
	clrkwllms@kernel.org,
	leitao@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	mark.rutland@arm.com,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com
Subject: Re: [PATCH] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq stack
Date: Wed,  5 Nov 2025 16:33:20 +0900
Message-Id: <20251105073320.208335-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aQoGdVYOddu9bxLg@willie-the-truck>
References: <aQoGdVYOddu9bxLg@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

On Tue, 4 Nov 2025 13:58:13 +0000, Will Deacon wrote:
>On Mon, Oct 13, 2025 at 01:35:08AM +0000, Ryo Takakura wrote:
>> For those architectures with HAVE_SOFTIRQ_ON_OWN_STACK use
>> their dedicated softirq stack when !PREEMPT_RT. This condition
>> is ensured by SOFTIRQ_ON_OWN_STACK.
>> 
>> Let arm64 use SOFTIRQ_ON_OWN_STACK as well to select its
>> usage of the stack.
>> 
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> ---
>>  arch/arm64/kernel/irq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>> index c0065a1d77cf..15dedb385b9e 100644
>> --- a/arch/arm64/kernel/irq.c
>> +++ b/arch/arm64/kernel/irq.c
>> @@ -62,7 +62,7 @@ static void __init init_irq_stacks(void)
>>  	}
>>  }
>>  
>> -#ifndef CONFIG_PREEMPT_RT
>> +#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
>>  static void ____do_softirq(struct pt_regs *regs)
>>  {
>>  	__do_softirq();
>
>Acked-by: Will Deacon <will@kernel.org>

Thanks Sebastian and Will for checking!
I'll shortly send v2 with the tags.

Sincerely,
Ryo Takakura

>Will

