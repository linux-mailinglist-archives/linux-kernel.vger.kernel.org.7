Return-Path: <linux-kernel+bounces-775851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6826EB2C5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5592918985CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A172EB85B;
	Tue, 19 Aug 2025 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiKGvReV"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8542EB853
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610319; cv=none; b=ju6iP4xKJinhnRGGNaVDyhArnOqE8AFci/c9XH6pZukRlqVY2rX+odHYJgZBTVnpcTnicZx7KymNXoAuFqB6TllM4SOeZfgvsHFTf90DlfUOxeDVoIuDmgMKzWsJ3gYnvb8z4dLzBopD1phhqJr5CvwqTNk7DLj8ZaLGCYc3b8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610319; c=relaxed/simple;
	bh=YOWuOvXp8Yh+4tpnkb1YtqwLLeaFoLleda5Z+WQNqx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opWaUjmgQeA3EuBCwkgnJEV3u55kkr8QrA9+VufmPhuMUtX4Zm17BqS6FKGrloQQb2q+GF0XO9BZSNCqnRo8O02dBoAFJ157Jo7CsTf1rEt1egvMP9ZAPgN9z052ks14Ip8+RaNUYVUOcIzIhyvudpH1aePUSBHerLlrlvOKXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiKGvReV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso4463758b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755610316; x=1756215116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRmcafjLK/bUe3QVBcZSTxEMW/hT2fpAZCLoRLeyHpQ=;
        b=DiKGvReVj/YURqKMTB1DSMDutJhfJkGKUeVFvN1MkeWLDG1suUZC0Z8WM144IRAuAu
         CQm11fTmgfpXcHxdS1pRTtCD31pA1SqAc4+sHo1EP0664KLF3J/94nsTgt2tDbeZStp/
         PetN1oE6rhXjRtedtSU3lEcjP1nQ8Ozqske8sry7MWe0C8WxNT6ToJs59I99WVwg0yT8
         JY1NDSar3UmjFDEOOAxljeQsYaWOxJMeLX8/1YJEXBWC61V4d+Jxbpp/KQ4xR3azfknY
         h/TSdEG3QCYnYh2LpdW0YVhH/e7n+SBEmmd3MapiKtE3GNrOc0zZ3k24H4iygza/9qGm
         iSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610316; x=1756215116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRmcafjLK/bUe3QVBcZSTxEMW/hT2fpAZCLoRLeyHpQ=;
        b=jDiVE9e7QvL1Y6wc98WckxHuVHr0I9BsC6ehJ2uUX39HPTFMliey2nteHwJcbY/pY/
         +tcPE21l0/VYX0hxQ6cNxkSiZYaVspv0Xf/xurQqWai144T+oN5yQuUUEVEfV71sHUmW
         KLhyfA0Vv8g5ctipCXj2ltH+z+ScQaZFdGgFBRrPqZld6BQGdnIuT+hsbbB33+7cELG2
         8jdn0FXqgPwfGIT+mbE1XfbDTfT7kKHi2rL6Uu4kV/LHamWoZohYbRdjK4XLoPVydHES
         ohfbT+MG+Z2yWE9VMY5DeP4Rg0SdHn1lGYB2wCza9F7HW8cWHsWBeKVWMh0lJYCtw3l2
         GUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo6m3m7yNGiQNBwhdNnl1bgta/iYKs7oC5XnXdYLNg2IyacrrX/QYQiEG/Dy1eEWXxuvpOQO5u7oThotg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7IyLog/VpnXxe+xZBAR/A6CzGEaSKh3Z9dzqKn3f+63vGZtD
	+e6QqnQ4OlcNJ+3PcHnVqScDQhhiuNDwpPNa37iP9A4MKkvgjCP9mYhB
X-Gm-Gg: ASbGncvcllFutksEA0TCGBmvlyTLYCt+5UbC3Hdxc19EW566mY4woa28BztBz/lN4SO
	PoYBVA+aWZlvFyvYhgiaR7A+7ODmZ7ZeQgIZ4ShNKeWuQF2K28w4gxOHxnf5d7eg1k4UhprOlag
	JZjJXKLFZfJN1HBS02p8lHCVr5xP3JUKJWZHfI+8eaaZVYgaOeWHrtRmtE3mrLtrHRDOSHPmglr
	xAjE8yH8puX0P0jq1+M9gqItR3Yi4X25vFwAOJOJXtAj3Iz1wpBOWm/hYz/3uvUWprzNP8Sssm6
	f7wjLungolI20jIpXmOr02lHSVcthEOrTc4YZM2PJD37Je0XHJ5M7kJpaJUH94+bDkrcCDzZUja
	6ehoe/U59CpvijD2zevJpAnXVPRVh0GcF2JcvtsABSxZO37Maab8YspybsjdF9Z3cwbc=
X-Google-Smtp-Source: AGHT+IGHwMFf1Q2ZU3OCGcqXj35XfKNBWk9FMiaKSJAbgclkE6zyl5GtbMaE1KB/or/Tiwr5taj28A==
X-Received: by 2002:a05:6a21:3298:b0:243:78a:8299 with SMTP id adf61e73a8af0-2430d49d8d5mr3621641637.50.1755610315907;
        Tue, 19 Aug 2025 06:31:55 -0700 (PDT)
Received: from fedora.. (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cdfsm2517490b3a.63.2025.08.19.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:31:55 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: cuiguoqi@kylinos.cn
Cc: akpm@linux-foundation.org,
	bigeasy@linutronix.de,
	catalin.marinas@arm.com,
	clrkwllms@kernel.org,
	farbere@amazon.com,
	feng.tang@linux.alibaba.com,
	guoqi0226@163.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	namcao@linutronix.de,
	pmladek@suse.com,
	rostedt@goodmis.org,
	sravankumarlpu@gmail.com,
	takakura@valinux.co.jp,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] printk: Fix panic log flush to serial console during kdump in PREEMPT_RT kernels
Date: Tue, 19 Aug 2025 13:31:49 +0000
Message-ID: <20250819133149.7452-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250807112247.170127-1-cuiguoqi@kylinos.cn>
References: <20250807112247.170127-1-cuiguoqi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi cuiguoqi!

I'm not an expert on the subject, but hope this helps.

On Thu,  7 Aug 2025 19:22:47 +0800, cuiguoqi wrote:
>When a system running a real-time (PREEMPT_RT) kernel panics and triggers kdump,
>the critical log messages (e.g., panic reason, stack traces) may fail to appear
>on the serial console.
>
>When kdump cannot be used properly, serial console logs are crucial,
>whether for diagnosing kdump issues or troubleshooting the underlying problem.

The console not being flushed in the case of kexec should be expected
as described [0]. Its about prioritizing kexec over serial output.

>This issue arises due to synchronization or deferred flushing of the printk buffer
>in real-time contexts, where preemptible console locks or delayed workqueues prevent
>timely log output before kexec transitions to the crash kernel.
>
> /**
>  * kexec_image_info - For debugging output.
>@@ -176,6 +177,9 @@ void machine_kexec(struct kimage *kimage)
> 
> 	pr_info("Bye!\n");
> 
>+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_kexec_crash)
>+		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>+

Calling console_flush_on_panic() while trying to kexec will
reduce its chance of success.

>diff --git a/kernel/panic.c b/kernel/panic.c
>index 72fcbb5..e0ad0df 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -437,6 +437,8 @@ void vpanic(const char *fmt, va_list args)
> 	 */
> 	kgdb_panic(buf);
> 
>+	printk_legacy_allow_panic_sync();
>+
> 	/*
> 	 * If we have crashed and we have a crash kernel loaded let it handle
> 	 * everything else.
>@@ -450,8 +452,6 @@ void vpanic(const char *fmt, va_list args)
> 
> 	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> 
>-	printk_legacy_allow_panic_sync();
>-

The ordering here should be kept where we don't want CPUs other than
the one panicked flushing legacy consoles.

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/847cagmjsx.fsf@jogness.linutronix.de/

