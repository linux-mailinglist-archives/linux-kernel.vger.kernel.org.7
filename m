Return-Path: <linux-kernel+bounces-838625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C218BAFC61
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB707163026
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB22DAFBF;
	Wed,  1 Oct 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="iJLHFNhD"
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826B2D97AF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309464; cv=none; b=ahvJoee3KmdLYZAWyJP7PbCJAGeRlkmECMV0tWF1cskIF30nTsprJC7zkknySH/ikKyVljrBb8JzcNsTQApyioXKyCR1EsOH4oG2d4gNA6LItSawOQxH5xVtu0s0U0nDAVtbXzkiWtFcPA7gU/eHu/k1oYImsE70y0SD20YaqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309464; c=relaxed/simple;
	bh=xpJP/VKXGMi27NpBmxz1Nm/9zX+CkUqS3AmErvfD38I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qI7OmkRFbrWaD/qOT/pgb7YAQ+0435BfLXM6raHbCfiRou4PXUKVCslxVcPlO2bSemj6vJkVHdUb7trLxGdCMCG+LSZ/BK+u8cLWOmz3QAn0ABlmo819ju5qCkQ8Gq5EUmtpN/vKWR3lYEIyP1F29hkBtmc3AwL+CswSL1whk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=iJLHFNhD; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759309463; x=1790845463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QqoQLhr9jNRrUPLIQa00/14EdjpK1aaOEozoKOWSRQI=;
  b=iJLHFNhDnLQuH1l+iya6e/0k6K0D5UGfxGBlRdsCcOLLY2JW33HD9Y4K
   CyKpbbcyaOZJ7NG41ednYVEKo3fvANWAFbFHPGsKaRWYDff2dUGXOY6Zd
   RGf6IQys6rs8XDXEpNq9hHHvRu8CpR4La56zg+qFqIq4vvr3t+nhcq5/V
   evVCNT8pyOUxaF8Bevh0V58DTouoprANSZi/jPnO+VBsQF36zzI0LmPK3
   OvFn0mdZNPelaElgT4Xa+pxG1mHV7FxJp4669y4ewJzJrPNquBRdXeLjQ
   WkJ6961wzKR8YnfMRYR75++YUH2jGRegqYvt30vM4Km3gXGg10LADJ2Yf
   Q==;
X-CSE-ConnectionGUID: sQ89hXaHSTWejetMyBy6tw==
X-CSE-MsgGUID: B0di+aZYRuaz6VBPjSRaFw==
X-IronPort-AV: E=Sophos;i="6.18,306,1751241600"; 
   d="scan'208";a="4058002"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 09:04:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:41709]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.86:2525] with esmtp (Farcaster)
 id fde31b50-4b6d-49ae-a02b-d77c58a4ea9c; Wed, 1 Oct 2025 09:04:20 +0000 (UTC)
X-Farcaster-Flow-ID: fde31b50-4b6d-49ae-a02b-d77c58a4ea9c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 1 Oct 2025 09:04:20 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 1 Oct 2025
 09:04:18 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <linux-mm@kvack.org>
CC: <acsjakub@amazon.de>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>, <peterx@redhat.com>,
	<axelrasmussen@google.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] mm, ksm: fix flag-dropping behavior
Date: Wed, 1 Oct 2025 09:03:51 +0000
Message-ID: <20251001090353.57523-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This series fixes a bug in ksm_madvise described in [1/2].
As asked by David in the reply to v2, I separated the change into two
commits:
- first contains minimal fix for the bug to make it
  individually-backportable
- second makes the VM_* flag definitions consistent

v1: https://lore.kernel.org/all/20250930063921.62354-1-acsjakub@amazon.de/
v2: https://lore.kernel.org/all/20250930130023.60106-1-acsjakub@amazon.de/

Jakub Acs (2):
  mm/ksm: fix flag-dropping behavior in ksm_madvise
  mm: redefine VM_* flag constants with BIT()

 include/linux/mm.h | 68 +++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


