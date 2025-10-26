Return-Path: <linux-kernel+bounces-870541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFACC0B172
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293C81895DAC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768F12F693B;
	Sun, 26 Oct 2025 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b="nlPpoCfm"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF4749C
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761508559; cv=none; b=j8utnaOPK+e2f+KYINBoHJhhNikoKBH1/lKKuAd9hW7uFhwdD+BxKX4pXC6HlbYO4F1+4jsLjTkSOq4WUyGz3VvXBFBtlpftzJzAMFrjsV3DlipWa8UvDygiduAsSyCysMwYIVYLm1MgGDMEOYfxPnyjAQIO9dddL59Xm+351hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761508559; c=relaxed/simple;
	bh=VWlnT0XnAKDifRF6Men5IauzNKyMY9+iRc9PVlnps00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBXkE3ljtCfXm6qceSEvv/cx2MLa7qqQKleoJJk6z+3O+q/p+WcL0HGfJF1+tDQ/en9HP6IkoJgVvjNAoyF9PB+08Xw3gNJrLqX7Rg8ITRVe+s+bcSMqKbl0I89qVKIVImPEmxNtD2HNMdw5/Y7OY5W1vcSJnwS8A0pRXKRxvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io; spf=pass smtp.mailfrom=kael-k.io; dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b=nlPpoCfm; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kael-k.io
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cvnSN1gcYz9t0t;
	Sun, 26 Oct 2025 20:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kael-k.io; s=MBO0001;
	t=1761508548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sF5qFNtldL4hxU1Eob88O4wvYXONE5jYGbUo2vOTtAA=;
	b=nlPpoCfmolNoB1lnQvMklf3nrPPOoUciUxYN+IF7KuprwYR+pUdvUyml2xcznQ6jB7/xcX
	2SuyGV1L7zT+thsQDYGvTb0Ydkn5r3BWeECEaMPnWiPFf3SNVzZwm4f3jNqoTO4B72W+JR
	M1f6mz8HQGEd7HMvnD6jEV77wLUAtTq/I7OS/h18K8SFfwfP3LW5gSYz3ZU9+JRkOOgTh6
	IOuJ+2URPSQvJDd9Uhmszk66roHPf38F3RFtJBlMCU4b46X70V7mFo5PJXHcHq0vkirwWW
	pIGR3dZfR3tG6O6lLrcTgGhxfPpiCzakivXQgCbHyhRV9l6OZje3XOqEHQB6tg==
From: Kael D'Alcamo <dev@kael-k.io>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] x86/mtrr: Fix kernel-doc warnings in amd.c and centaur.c
Date: Sun, 26 Oct 2025 20:54:41 +0100
Message-ID: <20251026195511.79300-1-dev@kael-k.io>
In-Reply-To: <20251021103739.GBaPdic1JTakX2bA9i@fat_crate.local>
References: <20251021103739.GBaPdic1JTakX2bA9i@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Boris,

Thank you for your feedback

>> Signed-off-by: Kael D'Alcamo <dev@kael-k.io>
>> ---
>>  arch/x86/kernel/cpu/mtrr/centaur.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
>> index 6f6c3ae92943..f4c72402c284 100644
>> --- a/arch/x86/kernel/cpu/mtrr/centaur.c
>> +++ b/arch/x86/kernel/cpu/mtrr/centaur.c
>> @@ -20,6 +20,7 @@ static u8 centaur_mcr_type;	/* 0 for winchip, 1 for winchip2 */
>>   *
>>   * @base: The starting (base) address of the region.
>>   * @size: The size (in bytes) of the region.
>> + * @replace_reg: mtrr index to be replaced; set to invalid value if none.
>
>I'm afraid I can't follow here what invalid value you mean...

In order to solve the warning issue while keeping the documentation
homogeneus, I used the same description from the get_free_region in
generic.c.
I believe that the original doc author referred to the fact that you can either
choose to reuse a specific MTRR (by passing its index in replace_reg) 
or ask the function to find a free one
by passing an "invalid value" (for instance -1).

Changelog v1 -> v2:
* merge changes into a single patch
* add commit message

Have a nice day,
Kael.

Kael D'Alcamo (1):
  x86/mtrr: Fix kernel-doc warnings in amd.c and centaur.c

 arch/x86/kernel/cpu/mtrr/amd.c     | 8 ++++----
 arch/x86/kernel/cpu/mtrr/centaur.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.51.1


