Return-Path: <linux-kernel+bounces-754258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEBDB19188
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 04:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE7A1896C26
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 02:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B912EBE7;
	Sun,  3 Aug 2025 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="eIRkOliu"
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA87367
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754188506; cv=none; b=iS0CwzUgUFX42Ts2vmpljffT+oCNmOsvVmeCJzwbTFfp0rCj8JbVdAlE42K/Rt9edahRLKvPRiNQ61zakbR9bwRnXvTJQoy5JYq4MQ1crPXxvjf7XP+4EdROOCG9ry3mEPa6RYhZiXx99wlhNIgEoC76fxi/qAXDrw2aKNYai6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754188506; c=relaxed/simple;
	bh=bucMXqGTWGn6HWoDQRk7RTuGuIbW16u/IyIBB3Eig0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=parfO0uSchKGo9kkl5eXm3iD9vMd/51REIUmC2NNlRh3yuGidmDWMUgcoiOXjei8eptwkPcG0oQtTye2W6HhJ2dTVOKmZ0tniKSpsRNxXJ4fi8+uOJM44G2I8G9V7UhPqDchJT9/Vy4AROkM7lxvtN+4lrhJ3eIvUfgvnCrRrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=eIRkOliu; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754188500;
	bh=0ReNAkTdVr3qWAnTeUHl9END9TVxrH6VL+/8G7q4PVs=;
	h=From:Subject:Date:Message-ID;
	b=eIRkOliuQhXxKmbvBlR6Lt2fa3Fs301W9ZxEqfcvwyzcZlX7GgYh5SHAEnk1CI+6s
	 s6nPqHLmeSjMY4FEaGKzeP6ekCr8OWJphqm74h4eNwkJXEDXKCni6j90RGrAh6yL5E
	 FRpL8sii7/+i3F3P97W1vnvTxE/dWxT7Da5x8z84=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 688ECAC8000048BD; Sun, 3 Aug 2025 10:34:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7595586816214
X-SMAIL-UIID: 2418495DB88740AB98C80E1ACE91695E-20250803-103450-1
From: Hillf Danton <hdanton@sina.com>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
Date: Sun,  3 Aug 2025 10:34:38 +0800
Message-ID: <20250803023439.3760-1-hdanton@sina.com>
In-Reply-To: <20250802142647.139186-3-ysk@kzalloc.com>
References: <20250802142647.139186-3-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  2 Aug 2025 14:26:49 +0000 Yunseong Kim wrote:
> @@ -862,7 +879,7 @@ void kcov_remote_start(u64 handle)
>  	if (!in_task() && !in_softirq_really())
>  		return;
>  
> -	local_lock_irqsave(&kcov_percpu_data.lock, flags);
> +	local_irq_save(flags);
>  
>  	/*
>  	 * Check that kcov_remote_start() is not called twice in background
> @@ -870,7 +887,7 @@ void kcov_remote_start(u64 handle)
>  	 */
>  	mode = READ_ONCE(t->kcov_mode);
>  	if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
> -		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
> +		local_irq_restore(flags);
>  		return;
>  	}
>  	/*
> @@ -879,15 +896,15 @@ void kcov_remote_start(u64 handle)
>  	 * happened while collecting coverage from a background thread.
>  	 */
>  	if (WARN_ON(in_serving_softirq() && t->kcov_softirq)) {
> -		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
> +		local_irq_restore(flags);
>  		return;
>  	}
>  
> -	spin_lock(&kcov_remote_lock);
> +	raw_spin_lock(&kcov_remote_lock);
>  	remote = kcov_remote_find(handle);
>  	if (!remote) {
> -		spin_unlock(&kcov_remote_lock);
> -		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
> +		raw_spin_unlock(&kcov_remote_lock);
> +		local_irq_restore(flags);
>  		return;
>  	}
>  	kcov_debug("handle = %llx, context: %s\n", handle,
> @@ -908,17 +925,17 @@ void kcov_remote_start(u64 handle)
>  		size = CONFIG_KCOV_IRQ_AREA_SIZE;
>  		area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
>  	}
> -	spin_unlock(&kcov_remote_lock);
> +	raw_spin_unlock(&kcov_remote_lock);
>  
>  	/* Can only happen when in_task(). */
>  	if (!area) {
> -		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
> +		local_irq_restore(flags);
>  		area = vmalloc(size * sizeof(unsigned long));

Given irq disabled for the duration of the coverage collection section [1],
vmalloc does not work here [2].

>  		if (!area) {
>  			kcov_put(kcov);
>  			return;
>  		}
> -		local_lock_irqsave(&kcov_percpu_data.lock, flags);
> +		local_irq_save(flags);
>  	}

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kcov.h#n73
[2] Subject: [RFC 0/7] vmallloc and non-blocking GFPs
https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/

