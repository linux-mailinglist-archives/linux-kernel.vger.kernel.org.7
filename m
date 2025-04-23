Return-Path: <linux-kernel+bounces-615662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54C0A98067
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 09:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EB55A0F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D99268C48;
	Wed, 23 Apr 2025 07:16:58 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4C1804A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392617; cv=none; b=QG7ZxMV57v4K7kwGQty1a8v6N/g1IoR8mqlE0zxZfUxH3IMHn3BhRyJ2lGlmUVdFXkydLmxx7G6yQNV02WXoJRxCjA1tpBrMznoig/qnK8RyMgGwXqJKUM+Ujyesdn2tB4wB+pfNQX2sksMKEMhJocLX9h4KFgwzkgDlmiyNllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392617; c=relaxed/simple;
	bh=dOTk381xxeeGEiNp4a7ojZS+Q2dsZUygSzD6jGXWVJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IXASYix56ilI38LfgBZ5K5RAFI4PeSHpKfduOSZKtBBSvCVXAlhhp2nBEmcJ3U8R7VccrOt1Oc5DREYDzqtuyz8ykWtgrtJEYr0Avf0I0LQHFwknh+U0uEHmB9kRBIfeQBNr0O8aBYUJsZsSsBVQ8vXLjf9DbjLqNldbNeFM8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1745391828-1eb14e386f171a0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id dnPtHpcVGdSziH5l (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 23 Apr 2025 15:03:48 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 23 Apr
 2025 15:03:47 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Wed, 23 Apr 2025 15:03:47 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from silvia-OptiPlex-3010.Zhaoxin.com (10.29.8.50) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 14:35:10 +0800
From: SilviaZhao-oc <silviazhao-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kan.liang@linux.intel.com>
CC: <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
	<silviazhao@zhaoxin.com>, <cooperyan@zhaoxin.com>, SilviaZhao
	<silviazhao-oc@zhaoxin.com>
Subject: [PATCH RESEND 0/3] Add PMC support for Zhaoxin Yongfeng architecture 
Date: Wed, 23 Apr 2025 14:35:06 +0800
X-ASG-Orig-Subj: [PATCH RESEND 0/3] Add PMC support for Zhaoxin Yongfeng architecture 
Message-ID: <20250423063509.20996-1-silviazhao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Moderation-Data: 4/23/2025 3:03:46 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1745391828
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 798
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.140368
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: SilviaZhao <silviazhao-oc@zhaoxin.com>

Add PMC support for Zhaoxin Yongfeng architecture.
Dave Hansen suggested to use macros instead of open-coded model numbers.
So create arch/x86/include/asm/zhaoxin-family.h to introduce macros for
Zhaoxin family numbers.
https://lore.kernel.org/lkml/6f78ecfb-99c8-eee3-cad0-69bbd88a107c@intel.com

SilviaZhao (3):
  x86/cpu/zhaoxin: Introduce macros for Zhaoxin family numbers
  perf/x86/zhaoxin: Replace open-coded model number with macros
  perf/x86/zhaoxin: Add Yongfeng support

 arch/x86/events/zhaoxin/core.c        | 55 ++++++++++++++++++---------
 arch/x86/include/asm/zhaoxin-family.h | 19 +++++++++
 2 files changed, 57 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/zhaoxin-family.h

--=20
2.34.1


