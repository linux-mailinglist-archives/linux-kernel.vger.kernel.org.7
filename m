Return-Path: <linux-kernel+bounces-770011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E756B275EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74A03AA099
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02629A9E4;
	Fri, 15 Aug 2025 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YDuGK7TT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4872989A4;
	Fri, 15 Aug 2025 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224939; cv=fail; b=rnG+fB2sTtsl0ZzFvErgl63aw/BfZoJ7tgFZHLmIS3bB+kWjE1q41KlZKMpr0P5JjWLbyE1InJf5IVqiOYSFh/QG5f+35BVjaJAZpG1/nUNcQYyNusOd4EMiSf4KSCTiZCWVvHPRDqsZ/W+xrhSXv+VlPKxsx3UXtYrx42U0mMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224939; c=relaxed/simple;
	bh=5qQ6sw5D0Daro71aUpra97cXs2eLemqfCOoDmtgiB+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWxTVauO79RhdsO2QhfzDL2wFnKeAjb3Jo6WOjuEJJ4fZo0V70a803vNXw7M/EDw6iBuPEsRJVp/e/ell4MDohwdCCRhiyPxcu8pBma0d9xfIOZ3oNYfi8m4OrCTESAYZjUghOrzXwnC50/k/gCPz1p/dDgg3Kzt9XyB2HyQH4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YDuGK7TT; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/Np7pmztkoNwTc4aBYchGe9jsQp/qU2p1ZE2LcmM4KKKeN8/5GGRIZK4LiFvG0/iUnkot+2P/wiZDc0b1y/CccsRYwWN1G1hvNjkM7U3A8R9qPgSoA5QmQEsh/soES9WMPDGyfyrN/8I2ff0xcoo+W4cwiWREH2W4PJPmPfN1lxiMot40SPZzIxUnlGqoVfgcY2NxZ22oHbXujIH34uuJ6tFOt/WoDprT7ThjIyA4JXzujTCdEOx//YwDYJilFgh48UHrh0AFlJD3sdLjTTB7ZKHFyuJVCU9XUpybje6B+0AO4UnoBcOu/xIosM3XIsJ1jz+ZQSILMSFyW62qH9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z71VgBxlRHU8XBa6upZyB9BkkppEzKj5Qu7NLDNC384=;
 b=UEfYjCPF2ykby+Z0ozhoz3dc/fLUSF1TZRc6IbnpF00yk1ioefI6TCJwJrGVsDxlQsj4pj4jVshPNHv6xowgclqymEUGQpDcc92shr2otDFiumzkUkeWwVR9D8xIikPvzIqEPkUp+Id43Rb2aUx2EO2b6aGS87Dr7dRSa0bg7bD8Puu2R6CBbQCIHVAZ90piIWm8F0eUQb98Wo2fHzxlHH3/BKkXd2ECXEV7967/nSO70ssfiRDpe5yC7zV7KmibE3sTMAQ3bfWTviyR2WRShSBiOcXqDLIyPZ6qWqO78zJr4uWEkDU/xY4BEJf2fw0XbPJEEFLsMs98CtHX6NGhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z71VgBxlRHU8XBa6upZyB9BkkppEzKj5Qu7NLDNC384=;
 b=YDuGK7TTnl0eG9OJebXnO3eLF/Y+iGHzDystiJvDijn9tJ7zQDHGe+pGw4NBx6pO9zPipBSgo5ZKxFByJIrBFC8EcGCiRt9Z2+N4wKGMoeI608OzWNXa/gqP1BNvYqzzhNopbuWbOGf1EqomNQ0i2OPFqY3L3W18iaWRLomTGH8=
Received: from SJ0PR13CA0077.namprd13.prod.outlook.com (2603:10b6:a03:2c4::22)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 02:28:52 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::90) by SJ0PR13CA0077.outlook.office365.com
 (2603:10b6:a03:2c4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:28:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:28:49 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 21/33] x86/resctrl: Refactor resctrl_arch_rmid_read()
Date: Thu, 14 Aug 2025 21:25:25 -0500
Message-ID: <c6520698ddc6b5252946bfdd8a9e127c624022d1.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe31454-cb41-4f9d-ceb9-08dddba379a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dji1zQ4VzrkW3ubwYU1X6NQYgTvph9/y3R1pXEuerFo3G+NYrfJe+/3tF7He?=
 =?us-ascii?Q?4mNKBnHkCwWmwoWQunReazsnLvQuw+yM1mgSueRpo4qT5gom5/HQFaXgeE8a?=
 =?us-ascii?Q?9LkWwPN4xpFGr9R3Kel8miqv8qXlFPve7g8YDIs2HRapKsQuUJn4bPsNa5qM?=
 =?us-ascii?Q?etoH5vjylseSGXeSyFNpDag9MaFDdpDIkv1IaxHGL8ZStt48UqIF9Znn6NdA?=
 =?us-ascii?Q?fvKCvrhGmL6CX4N9gszXW3xiaXXI2ZqCvNroRJolHC2jMms7Ayza4jse7ctI?=
 =?us-ascii?Q?D1rCM9esbQ4ZvwGACT7Qlk22EOfhPp4uVptrzP/r/Fk/NFt4UTtD3dAoo08D?=
 =?us-ascii?Q?OjjCZkQYUz+FbIrpoQRJrubf4SqGU/q9i3YE146ThLCzg+3A4qsZZx/WwSg7?=
 =?us-ascii?Q?uF/MwIpScrKQZAdOyIWh3fMOGgGIfzibnMbP5XB7RNkgFk9K9VpA08qKL+wD?=
 =?us-ascii?Q?jd85vpMw0gW5HPuxae7EuKRc3DBGKr8CxPp2sDkxnw76WvAS/FztaAyvuPTz?=
 =?us-ascii?Q?tPRyu0WQFUYuMwIQvSMhn3seZWNA/j3FxOX4GWdd9J2q7MuNnjdV12Kpgu+A?=
 =?us-ascii?Q?PtUN0K77fo0An3R12u4mVaGqgZg/JrCfpXPL7Thr39OD52zyrHiU+3OHggYR?=
 =?us-ascii?Q?Ki/6WmYWjTJnlCqyFijgdWtRqiWecym5CBe5PjSZsow3Q4QHETWO8z36PbNo?=
 =?us-ascii?Q?VxnyJEzDOIOGUlVhjqrWkvFJe1qhtTUOgFUeYgw6Qy8I5gzgUV3gdn1dCEj9?=
 =?us-ascii?Q?Q/BuVL4Rjlmu2ervGjA6Vjx6mFqBw+TyIJzFWUQsB/TMNTnuVrE0RLFcn/1Y?=
 =?us-ascii?Q?UMPmSrYXte+mLxH7XiU6DL7gMVk70KAXO+q18EPbJlQcT7ZgpWhjY6hb1C5T?=
 =?us-ascii?Q?b8Nwd+GTly1vkUz1AbLuegi2A8K57HnqZgSQHbn+u7kO+/IqTTq/JIxRAVC2?=
 =?us-ascii?Q?hMmKq5nUo5YJi5p+poY7buyV6x+lzTBzv4MX0BF7jstGk0uv4/SqJpT2Fkpv?=
 =?us-ascii?Q?sxJUqbFzJGEJ7ZfGgAqSohA6Tr8oUJCo8tP4+CgZV/l/TubTPR+/SMAByA/E?=
 =?us-ascii?Q?flEEdaJQtrQpw5+mef7aYYBUY9AmxFbWy9rIuuMZ2WSAwx36lK5tb7RN6JSa?=
 =?us-ascii?Q?uCi/ZE+Aal0mDrj+q3X/8B1Xt/ILqB7oQBnTazOBwro1/3cTMsNehvs98mai?=
 =?us-ascii?Q?6CZzAgjQnUQfr7EePZjiYnz9DIyQn5RN6jSADBRZ/y4QDrOarHdEsX0IkxIg?=
 =?us-ascii?Q?15YrFupUid97DeV9C270ZOvonMQinyYSIWgezIpnQHpuSVI225BCrBi9U7ob?=
 =?us-ascii?Q?Q/C5ijHoWwmn3nVowEQsMBKcxLIKk3JrUPrsozc77B9dEy6yZYhYe1P/MN/T?=
 =?us-ascii?Q?jWL4HJXGlx6tDVuY6z0eiEFyFYxNOtn+uWDaXvmdtLJ0PSFCufgZ1hFwk4mD?=
 =?us-ascii?Q?WajnxOSv7DxVfRwOiaQJ2QANU8Avpd13M1iANFjAvQQq/sL9Gif77W/D4JT6?=
 =?us-ascii?Q?S/cKfRGJ74TdxbmLn+m1DVNdH32P+97y/SrsG/XEF0Pdf2OLNAPHfHuPMQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:28:52.2317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe31454-cb41-4f9d-ceb9-08dddba379a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

resctrl_arch_rmid_read() adjusts the value obtained from MSR_IA32_QM_CTR to
account for the overflow for MBM events and apply counter scaling for all
the events. This logic is common to both reading an RMID and reading a
hardware counter directly.

Refactor the hardware value adjustment logic into get_corrected_val() to
prepare for support of reading a hardware counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: Added Reviewed-by tag.

v16: Rephrased the changelog.
     Fixed allignment.
     Renamed mbm_corrected_val() -> get_corrected_val().

v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
     with mbm_event mode.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 38 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ed295a6c5e66..1f77fd58e707 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -217,24 +217,13 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
-			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val, void *ignored)
+static u64 get_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
-	u32 prmid;
-	int ret;
-
-	resctrl_arch_rmid_read_context_check();
-
-	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
-	ret = __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
+	u64 chunks;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
@@ -246,7 +235,26 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 		chunks = msr_val;
 	}
 
-	*val = chunks * hw_res->mon_scale;
+	return chunks * hw_res->mon_scale;
+}
+
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
+			   u64 *val, void *ignored)
+{
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
+	u64 msr_val;
+	u32 prmid;
+	int ret;
+
+	resctrl_arch_rmid_read_context_check();
+
+	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
+	ret = __rmid_read_phys(prmid, eventid, &msr_val);
+	if (ret)
+		return ret;
+
+	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
 
 	return 0;
 }
-- 
2.34.1


