Return-Path: <linux-kernel+bounces-813729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C6B54A01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608A41CC5338
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73F92EA73B;
	Fri, 12 Sep 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WFbAXVdM"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D8A41
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673513; cv=none; b=GlQdjWXrL9kbN5cK//tp7Xx4PGgsO9//VVG1D0QmvAlf3+GsPBLUE1DUEv12liQY1YShNE5qcL7O+sB9V6Rh0f2FTW3ZRLX5e2TRNRbETxeHzkSSdQdfNs97zNT/QOyK7hnTIyL1rp3Id682KZNHnuCsTQShYxovNfRIlRR3UJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673513; c=relaxed/simple;
	bh=Yh8UAaqs0SPZbZG7o6VniuvtP1pwWyO6NzjY6HrbkXo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9AdfjrXKUzzr4C/7nSjW6rGRFKooKS4ynZKz6xdah8zoDBGn0U5JP4+80rjhzIlQ6IOROH088GcHaOguC6ZI+T0hTdRX/FhdFJ1Satg5kKcGgc4AvHLB5lgMn5Ew0MkPk73LD8EWP0W9OgdXnIUp77NjU96gsevtA00uE4om/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WFbAXVdM; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757673205; bh=HTMnwa7ykDcG+fi/e9T73bByyMMcNmGvRNC/RD8hK3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WFbAXVdM8Kh1U872yf5jPx5984W/EP1GAOw3FYkkLBgVbn0vEtm+lMv5hsjL5mSi3
	 yWztE1ggFrCBrx6vSNq7FuqmVmhb4oRo87IExbTK7npJaKL/ZNbkSQDWNIzJiRLEHl
	 UQtBJ0UydonzodvCz62sQc/1ADkYFchjEoah2GRU=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 857988E2; Fri, 12 Sep 2025 18:33:23 +0800
X-QQ-mid: xmsmtpt1757673203t8jqxwrom
Message-ID: <tencent_8FAF92EC7B7BF79E6DA0101B3A52D6004E06@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5evanQrBXN4IzMELlpNiQQ0jTfqRlQJJ+UicI2P4JY/OeXhNxpw
	 089tWcIrUVsImO2+IUZGaooNiX1hBAa9L8b4LMwtAdwuBn3d08tcmVVMLch+J9OrNBCeuP+H0bg1
	 3aj8PrSbBtkACigiko58WLgrVmD1LiMT+loysBHiIM2c5su5G+aOKad6tW2I35ptUmHJ0CzOsr0M
	 1F8mLJ24GpKnG7jAfUTFI/0XSQtxsM00Fq9aDed/djHeeLMnelRepJDVq/aOUjoI0j7o71rpYyZe
	 wF74aZBmR3aX2ELxtw2Hk2e58k9lQKaLbSEuO+LbVeZbye97IWoHUtqYJQOiNlB8TrEQvfTdOkjI
	 EpcUDoAANb0nMNNVeAgINZpAomRfwf6OprXmaBCpngTf6SxSchQTy1b4pAki7VV3lPUzMtr3VciP
	 jpZRCc15Id6nFr/K/tRc25M9kWwOoQVuszMnSaqbkGblD/R6ubF29jdP5JCrTDm0fo+kBTx7oTj+
	 lxsSRQ4s8OOjX0kw/lXPdnm0ci7bgvJX557Cytf4HnbeZPDyH+Ddvm3D5glzHTQFj+fwvyHyBYgL
	 TmM+TfpukcanoU7CedyPkyhmJ7PCmI61iA74EsqU/FJV2y7NQFoPpSocaTHdTYbl6DuQDrKQ3zyV
	 V6gPwx8vI6jRZPTKmrnOefwj79iHXxuj2lsBrZSCmi00AbOAPZTZiDgLm56DJOUeveH91biODKsm
	 hTa0q+JGR894dE4LNGfzsBbiOZfWnkf+Jz9d5+HoJZCt+18yiTIxGacEDw+Eb0ms74kQzgv9lTG1
	 Y0kM2kny+yW7CYY2QdQNL0Kb4lFIhJnw92iQnWLuswuocd1+gdiwQhlxwFe33H40sYdPfM9OhXon
	 4sf4vzmrrAxYBLN3YrIbd0N1FOv0Zw1DikCpFchz/PSR54gIUKl3ZNn+Kn+KgEi07/ZBkDCa+7D1
	 diKUyfMmrT0XrLPgmfdvfDSl7iBonFHF+xP1UBc7zN3cRqYs/59dBeXAeIezdZSFPKIpaWQH0qsu
	 aJ0yEjYHm7LDW1u1l9qwEoG9wHFlPRxu4A91nRUJRlM8cbwGC+K8jMTsM+d8ibT1F7yuozI/KK/e
	 XHvcZk2xccRXnYq48=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Haofeng Li <920484857@qq.com>
To: tglx@linutronix.de
Cc: 13266079573@163.com,
	920484857@qq.com,
	jstultz@google.com,
	lihaofeng@kylinos.cn,
	linux-kernel@vger.kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH WITHDRAWN] timekeeping: Move debug sleep time accounting outside spinlock
Date: Fri, 12 Sep 2025 18:33:23 +0800
X-OQ-MSGID: <20250912103323.1985583-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <871pofx302.ffs@tglx>
References: <871pofx302.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


>How so exactly?

>I don't see how that would deadlock, but I might miss something. So
>please explain it properly instead of handwaving about it.

>Thanks,

>        tglx


Thank you for your detailed feedback and for pointing out the issues with my previous analysis. I sincerely apologize for the oversight and any confusion it may have caused. You were absolutely right to question the reasoning, and upon re-examining the code with a fresher perspective, I realize my initial explanation was incomplete and incorrect.

Regarding your specific questions:

Removal of touch_softlockup_watchdog():
I now understand that this change was unrelated to the problem at hand. The removal was mistakenly included in the context of addressing the potential deadlock issue, which was not justified. This line should not have been touched.

Potential Deadlock in tk_debug_account_sleep_time():
Your skepticism about the deadlock risk was entirely valid. After further analysis, I confirmed that the function tk_debug_account_sleep_time()—specifically, the pm_deferred_pr_dbg() macro and its underlying printk_deferred() implementation—does not acquire any locks that could cause a deadlock, even when called within a spinlock-protected context. The deferred printk mechanism is designed to be safe in such scenarios, as it avoids locking and instead uses per-CPU buffers to handle logging.

The confusion arose because I was referencing an older version of the codebase that lacked the commit 099f1c84c005 ("printk: introduce per-cpu safe_print seq buffer"). This commit introduced critical improvements to the deferred printk functionality, ensuring it remains lock-free and safe for use in contexts like this. In the older codebase, a similar scenario could indeed lead to deadlocks, but in the current code, the implementation is robust and free of such risks.

Again, I apologize for the oversight and the time spent addressing this. I greatly appreciate your patience and thorough review, which helped me correct my misunderstanding. 

Thank you for your guidance and for holding the code to a high standard.

Best regards,

	lihaofeng


