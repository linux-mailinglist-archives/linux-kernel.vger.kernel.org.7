Return-Path: <linux-kernel+bounces-886755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA3C3678F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85EF6504FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9231DDBB;
	Wed,  5 Nov 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="N7zI6v9i"
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45718313E2F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356920; cv=none; b=AiabKTRnGRJ+EdAdmmXR6P6+MZcNkx4LYw53KLyOaZrg/CC9mhbPirI2BKUYWpRZntJ5Um+tE9PVLuV0bcSM2sAabryePCCTCCHzPPBhGRQLGB9baXJ7Wo5aPsA7tuNvAauIntMOJKq67RX31ZBObXhbKhaDhGafjBwwm5YvnHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356920; c=relaxed/simple;
	bh=gY7n199etOHJ/OagGCxib7w94cbLdvhCZdbUdbxE+dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSgLb876SGc3BcVXVAiaNO3/4y3RYe/+UNt1viiO8couYYcciTE6aS5jAP0gsoZIDRovArj7KrioAvwaeS1wF2beXiJWtSQGFRXDGg3L4ovjgvIsfdbyrF0DWRPfCP6LAer3OAdGRv2dyLQQR6y5faKoE/U+xO8FCH4r7OSy6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=N7zI6v9i; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762356918; x=1793892918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gY7n199etOHJ/OagGCxib7w94cbLdvhCZdbUdbxE+dw=;
  b=N7zI6v9ij+V0CfEyaoj01+sAFhz3EQAukP1EH/TcnFbL7mRcMYuwLNDT
   otli4842GU5W2AuBy4W3bypZ00utvVSQvSd8d8QgRUmSJrlfmjg/aS0Pd
   Nw1s4qQpxwwqNB9PNwRb7pHHwEi5iR6CRPFZofol6aBb4Rbr4R6RwZbqH
   NCkhEwMMySRnyW98bKkwH1Rxt+wXqC33UcG7YnmTDC98O+AB26+aydx5m
   kxcX88pCAyfcsLNE0Oa8wu8447iILA96A9LUcM0P/WQjnCz1ciGmnTV0E
   SVhup767HtZJM/aN0W2q9PTBMtfsgZLQJ+tvoZ9T9ccewDtos5ET3Q7dt
   g==;
X-CSE-ConnectionGUID: iRGkhXGKRn6QHYBkgUvCxw==
X-CSE-MsgGUID: CRiqYTxxRzymQ5Hb10gNdA==
X-IronPort-AV: E=Sophos;i="6.19,282,1754956800"; 
   d="scan'208";a="4727003"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:35:00 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:9792]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.45.127:2525] with esmtp (Farcaster)
 id 4eab9f8a-1a6d-4964-918d-5e0a7635a456; Wed, 5 Nov 2025 15:35:00 +0000 (UTC)
X-Farcaster-Flow-ID: 4eab9f8a-1a6d-4964-918d-5e0a7635a456
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 5 Nov 2025 15:34:59 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.220) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 5 Nov 2025 15:34:52 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: Re: [PATCH 4/4] sched/fair: Add more core cookie check in wake up
Date: Wed, 5 Nov 2025 17:34:21 +0200
Message-ID: <20251105153423.479687-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dc37d8bd-66c4-439e-afb3-e01670f3e08c@amd.com>
References: <cover.1758543008.git.sieberf@amazon.com> <a68bf0acdad9995fab15105cb26bd25f7d0edc8b.1758543008.git.sieberf@amazon.com> <a1ff6b87-48a9-436a-9b62-8664d5207884@amd.com> <20250923093001.1218488-1-sieberf@amazon.com> <dc37d8bd-66c4-439e-afb3-e01670f3e08c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Prateek,

For now, I've extracted the core cookie match as standalone commit:
https://lore.kernel.org/lkml/20251105152538.470586-1-sieberf@amazon.com/

--Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


