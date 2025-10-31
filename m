Return-Path: <linux-kernel+bounces-879518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BD6C234BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2384E314C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E28C2D640F;
	Fri, 31 Oct 2025 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pPbFn3Bd"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F562D0C61
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889154; cv=none; b=Nv+7sjCyfGcMZdLaVbJQ7eYazcrKtpdcNQUK8F5tqdOZg4K0dxHQjAi0ttzxfOyy5ezM80cjDIieVWZrp3CbvF7u6fU3FxVihCPPLSjVCnc8JTQutUcWj0MC5jZ2NFd/CXEp1sYHDh1a3Y7NnPhD+vfqlgP2zgWdmn0euxLMW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889154; c=relaxed/simple;
	bh=9bszQUrQ9DRwwrCpz1oQKtQYGkJSUadOEvnFwHsK7Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvMJ/HcLzDpAe3Z1XHcIMpOA/PmgPJaQn+FHEZTaz0gaD1dSfAkc35Ilsiv4nTHMaTcLGAM3mScqDgvS2PuBNM+uuL0Yho94VNYjAOzwa16IV/kPvJy8BNvOGvFk3dhAOCCt+yggjZ4jV2Ui/Ayk/bquYrrKy/AEO4mouLjO4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pPbFn3Bd; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761889137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRakSqR8o29qH+ZfZvl0HYHw+awOUQTApGgdAWATiro=;
	b=pPbFn3BdpaTQtjweMtUM5gJa75aqjfasGp97rfDJwqM9JS7Rp1vya6M0q65RLUlBLLqm4V
	SdqVuMmFa+Drb5O3EalRHXYLfpfQ2raYhoPHO4ISNRuj0fF5D+oEPZ8N+ECHBkxDQzftE3
	XflZQC7LmckfIQz4ymrTz+GP0O1c5PQ=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: bp@alien8.de
Cc: dave.hansen@linux.intel.com,
	davydov-max@yandex-team.ru,
	gpiccoli@igalia.com,
	hpa@zytor.com,
	jani.nikula@intel.com,
	joel.granados@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	wangfushuai@baidu.com,
	x86@kernel.org,
	xin@zytor.com
Subject: Re: [PATCH RESEND] x86/split_lock: Make split lock mitigation sleep duration configurable
Date: Fri, 31 Oct 2025 13:38:32 +0800
Message-Id: <20251031053832.99453-1-fushuai.wang@linux.dev>
In-Reply-To: <20251030191057.GDaQO4QYoZytxdQW_c@fat_crate.local>
References: <20251030191057.GDaQO4QYoZytxdQW_c@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>> Commit 727209376f49 ("x86/split_lock: Add sysctl to control the misery
>> mode") introduce a sysctl 'sysctl_sld_mitigate' to control the misery
>> mode for split lock detection (0 to disable, 1 to enable). However,
>> when enabled, the sleep duration for split lockers was fixed at 10 ms.
>> 
>> This patch extands 'sysctl_sld_mitigate' to allow configuring the sleep
>> duration in milliseconds. Now, when 'sysctl_sld_mitigate' is set to
>> N (N > 0), split lockers will sleep for N milliseconds.
>
> I'm reading this and the only question that pops up in my mind is "why".
> 
> Why does the upstream kernel need this?
-------
Resend. It was not delivered successfully again. :(
-------

Hi Boris,

I think there are two main reasons for making the split lock mitigation
sleep duration configurable:

1.Workload Flexibility: Different workloads have varying sensitivity to
  latency. Some environments may want a longer penalty to strongly discourage
  split locks, while others may prefer a shorter delay to minimize impact on
  overall system responsiveness.For example, in cloud environments, we are
  often more sensitive to split locks because it is important to prevent a
  single virtual machine from impacting the performance of the entire physical
  host, so a stricter (longer) penalty may be preferred. In other scenarios,
  such a strict penalty may not be necessary, and a shorter delay might be
  sufficient to balance performance and stability. Making the sleep duration
  configurable allows administrators to adjust the mitigation strategy based
  on the specific requirements and tolerance levels of different environments.

2.Testing and Tuning: Allowing the sleep duration to be configured makes
  it easier for system administrators and developers to test the effects of
  different mitigation levels and to tune the system according to their
  specific requirements.

Regards,
Wang.

