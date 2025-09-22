Return-Path: <linux-kernel+bounces-827204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A3B91263
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9529E189D880
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CEC307AEC;
	Mon, 22 Sep 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DxpWBtra"
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7E1FDA82
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544812; cv=none; b=Oq0UbhEBthxSnCwFAzg9YqLRQAcyAVlq1hGUAv4nVTQm7CO2tCkS1BuMM22Em9unIyAwQcV+2w38Dm1KKjiQF2nsbWu4LY9Tgv1LasLYAmWujOUXvb45qoqZxLyWQSFBvwXR50FyUlq2DzKR+c9pWDajR1xz2eAhnFPDSvof9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544812; c=relaxed/simple;
	bh=nhEwrRFXGLwGgLfeYLcFzpLwUsM4ZuRkkf0SA6e8zN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uiEDbsWtHXQgqyR61I0N5UloHTdnwJw0xjMDlHUhG8hQNpuGQSK0LweKaMbWdlR4oCIxidolHCFekhnr5ruTo1K4nxSDahpd5ywcjNm30rl5nM8Co61igdICq4q9yO7IkLlNOr5qLIzCwLEtiRT85YHqZIIoo85hkFGxsPP4994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DxpWBtra; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758544810; x=1790080810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=btxZE92atXUsTNqOgDRqwynLwkNYK2ArG6yO/lFWpXg=;
  b=DxpWBtraFwpOkHGmdUJ7LL6JiLiPXXeDP04TFkWQE1sYmtOnmdAbMlDd
   d7gJM1RRM4moI1b0woN4Gau8jIUtrD5Q+WZueYOsbYWpHeqgeL5HRGuGt
   xMge4WIMRpXzhfcy6GJqMc0TE5Nzy7OtKWVJUyurtYLeu5J44IrbK6PQ9
   iOadeKONDNVPse4Hdg+BLdsPlTNPTOCeupr7wPPiYdfvNGAdodvWpD6AR
   29C8r8eh1AIh5aaRXGklEFm8Gzc3lwWxuhA5DmNO4+Tw2yh2J7zwqKTJY
   7ZdzVBEAqaXtOA8IkCpeN63lV3anM0USXSg+1V5lRbMQAPMp/uDbLllQQ
   g==;
X-CSE-ConnectionGUID: HtisJo0TQW2X/5e6UdlDXw==
X-CSE-MsgGUID: zKVUMNQgT7embtuxW2yzng==
X-IronPort-AV: E=Sophos;i="6.18,285,1751241600"; 
   d="scan'208";a="2482302"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 12:40:00 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:12495]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.230:2525] with esmtp (Farcaster)
 id f2b7bf16-89f4-4539-bd78-4ec8c79bab62; Mon, 22 Sep 2025 12:40:00 +0000 (UTC)
X-Farcaster-Flow-ID: f2b7bf16-89f4-4539-bd78-4ec8c79bab62
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:39:59 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.222) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:39:52 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <mingo@redhat.com>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>, <graf@amazon.de>
Subject: [PATCH 0/4] sched/fair: Core sched wake up path improvements
Date: Mon, 22 Sep 2025 14:39:21 +0200
Message-ID: <cover.1758543008.git.sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series addresses several issues and improvements in the core
scheduling within the fair scheduler's wake-up paths. The overall result
is better task placement reducing force idle.

The main issues addressed are as follows:

Slow path:
1. Fix incorrect cookie matching logic that wrongly discards idle cores
2. Better fallback logic when no cookie matching target is found

Fast path:
3. Add cookie checks in wake affine idle to prevent force idle
4. Enhance task selection in select idle sibling to consider cookies

Fernand Sieber (4):
  sched/fair: Fix cookie check on __select_idle_cpu()
  sched/fair: Still look for the idlest cpu with no matching cookie
  sched/fair: Add cookie checks on wake idle path
  sched/fair: Add more core cookie check in wake up fast path

 kernel/sched/fair.c  | 49 ++++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h | 41 ++++++++++++++++++++----------------
 2 files changed, 59 insertions(+), 31 deletions(-)

--
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


