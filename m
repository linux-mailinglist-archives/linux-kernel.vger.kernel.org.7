Return-Path: <linux-kernel+bounces-888293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99550C3A6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5DB84FE41E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6C2EC080;
	Thu,  6 Nov 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="er/Yl/UY"
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354782EBDD6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426493; cv=none; b=F2GNPpdsiXNWxrbRqJ5ILN43Dr2JxI49mnCtBCzjuoI5+vOEeGQ8rUlFchwp9iq9j5remDl3NK0VzVtUpqW/wpZK1z/Ym1EoLvArHIEKIfP6g6DVGzA0afzCyVdfWNyR8JIWWjy7vjVjEKyCuYpBS3QX1yTiIabpGDxlinSEjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426493; c=relaxed/simple;
	bh=DynFZPxqfJBP2IZ3HWi01dv0vfrDy6veKMaELHGbcxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4KCc8UsovD0S4voZQ/QmUiAWufz6OWsQQXR+/u5MX96sFT2ljykBaVzu7zHvbOo5hQA1zOUig3yiu+EIm0rNaVFy6PcPek86eLjsgQe6e6+z6w+vPBOlrlK5GYx4gJqigRviDoQ4z7igf+3ilyBR+zp7B6TXzBUsh9Ti8fCDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=er/Yl/UY; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762426491; x=1793962491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DynFZPxqfJBP2IZ3HWi01dv0vfrDy6veKMaELHGbcxo=;
  b=er/Yl/UYH2srcMJG88pdmOmiOK9pIM9heEwoWlfrgGoOZlJmeWQwuKou
   G0B335RvUA9sdU55hKsmN8MNdOe+Pi5w2t+sMPZZv0t/hfriLwcKUV/d8
   BFph8EFvNir1P6hEgn2NV+vney4874mwRKg+AhJgZT2eWpAW8yk1sEK2g
   6ouw81dWJXqQ+W5aBhLiODqoxiixsPk3zmgPaSHb9SES37CrFNQu6pzZ9
   mJj/82OcamwpeFjO4e2pmQVTSdchs1D5WO8nirnf+ZjVMinnJpmKnKLRb
   CBejsO0JNnZD+8QHJAR7GGT31Nb9zkYMCAkpQkPhUPSSZBasqpC1rr0l/
   A==;
X-CSE-ConnectionGUID: bHgmCL0TSBSormwYKdcUdQ==
X-CSE-MsgGUID: Hclk1eRgSWmLfl47kGSP+Q==
X-IronPort-AV: E=Sophos;i="6.19,284,1754956800"; 
   d="scan'208";a="4657986"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:54:33 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:19413]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.203:2525] with esmtp (Farcaster)
 id 3077895c-4cab-4a10-babc-fd4d7185d354; Thu, 6 Nov 2025 10:54:32 +0000 (UTC)
X-Farcaster-Flow-ID: 3077895c-4cab-4a10-babc-fd4d7185d354
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 6 Nov 2025 10:54:28 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.223) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 6 Nov 2025 10:54:17 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <peterz@infradead.org>
CC: <aubrey.li@linux.intel.com>, <jstultz@google.com>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>, <oe-lkp@lists.linux.dev>,
	<oliver.sang@intel.com>, <sieberf@amazon.com>, <x86@kernel.org>,
	<yu.c.chen@intel.com>
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4: BUG:kernel_NULL_pointer_dereference,address
Date: Thu, 6 Nov 2025 12:54:01 +0200
Message-ID: <20251106105401.220218-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105122808.GK988547@noisy.programming.kicks-ass.net>
References: <20251105122808.GK988547@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

> But yeah, if the task holding your resource is doing yield() you're
> 'sad'. Basically a sched-fair yield() means: I've no fucking clue what
> I'm doing and lets hope we can make progress a little later.
>
> And it gets worse in the context of PI/proxy, because in that case your
> fair task can deadlock the system through sheer incompetence.
>
> Anyway, consider the PI case, we bump a fair task to FIFO and then
> yield() would do the FIFO yield -- with all the possible problems.
>
> And we want the same for proxy, if the boosting context is FIFO, we want
> a FIFO yield.

Alright, makes sense. Based on your suggestion I've submitted a patch:
lore.kernel.org/lkml/20251106104022.195157-1-sieberf@amazon.com/T/#u

This is essentially the same as your suggestion + handling of yield to and
scx.

Also confirmed no crashes with this patch + v3 of the vruntime forfeit patch
https://lore.kernel.org/lkml/20250918150528.292620-1-sieberf@amazon.com/

--Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


