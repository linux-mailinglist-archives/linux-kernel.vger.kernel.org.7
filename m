Return-Path: <linux-kernel+bounces-785780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A0B350F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E36F1B24ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324BF223301;
	Tue, 26 Aug 2025 01:20:53 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673CA92E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756171252; cv=none; b=tCtvdP1wU1Sv+coUxgghlo4esDrr/F2vsDHQD65Cyo3MtUwffPWGu8k9Ef2SlZbSgZaRrtzZpl2Tkq5Two6j19oy9oQO4I/tOL57p7oqDUHWZAnUYhM0F209sCL8zokp2pR8rrxBRRsPttMhKU1sn6iojIZJbX+vf0rs44teCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756171252; c=relaxed/simple;
	bh=XLDZo0YnAvGZ5JVCsolWG3yUDxi4WYY0Y4HFYS86R8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QE1ZTeNQ4THS40f44UFwlOu5SBHstbKqEnaXc2f+1bupI/Gap0iZ1tsmDICBHtLuJ+l/gtZgG8+X461OgHFeZ2QjB63bjuzHDKb0Q5LuBmg3DUEN9E8O6Hl89eBiw3cFqQqo/gvup49cCBAoIEQO3toAJw/j3ut/JUjfyVRPbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1756171237-086e23295629b040001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id nfxCVIGiG387UIAx (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 26 Aug 2025 09:20:37 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 26 Aug
 2025 09:20:37 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f]) by
 ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f%7]) with mapi id
 15.01.2507.044; Tue, 26 Aug 2025 09:20:37 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from tony.zhaoxin.com (10.32.64.5) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 25 Aug
 2025 19:22:11 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<peterz@infradead.org>, <rui.zhang@intel.com>, <TonyWWang-oc@zhaoxin.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<LyleLi@zhaoxin.com>
Subject: [PATCH] x86/cpu: detect extended topology for Zhaoxin CPUs
Date: Mon, 25 Aug 2025 19:22:01 +0800
X-ASG-Orig-Subj: [PATCH] x86/cpu: detect extended topology for Zhaoxin CPUs
Message-ID: <20250825112201.39487-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 8/26/2025 9:20:35 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1756171237
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1231
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.146250
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Zhaoxin CPUs support extended topology enumeration CPUID leaf
0xb/0x1f. Zhaoxin's new product, the KH-50000, features a single
socket with 96 cores and support 2/4 sockets interconnects.
Additionally, the Zhaoxin KH-50000 requires the use of extended
CPUID leaf 0xb/0x1f to retrieve cputopo information.

Right now the kernel uses the legacy CPUID leaf 0x1/0x4 for
topology detection for Zhaoxin CPUs. So add extended topology
detection support for Zhaoxin CPUs.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/topology_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/to=
pology_common.c
index b5a5e1411469..913dbf43389a 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -159,7 +159,8 @@ static void parse_topology(struct topo_scan *tscan, boo=
l early)
 		break;
 	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_ZHAOXIN:
-		parse_legacy(tscan);
+		if (!cpu_parse_topology_ext(tscan))
+			parse_legacy(tscan);
 		break;
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
--=20
2.25.1


