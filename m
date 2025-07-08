Return-Path: <linux-kernel+bounces-722461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A755AFDAF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4405654BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB325A2CC;
	Tue,  8 Jul 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T3Z+wb/l"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293525334B;
	Tue,  8 Jul 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013278; cv=fail; b=CMkzMwDSC0CS/ZbAm3bNPaKZj958uUb+dDh8HUUXurZG2T8ItZ6GxFWMcX6l8co2aZzzPc/0QwWw+bqAD5cG3HM87tQ39dyBmnnDSpMQjctVIJBSMSGPzVZFPAi2UlpepHgxq8xfRpl87EExvJc+QcOQvBQz7oOiQs7SOWsx5CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013278; c=relaxed/simple;
	bh=w46IHHwaPrU7LQNQmNOJeAp8lDydCEXDqKQAkcK2mJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfWR0Wsjvu8+XdztgmQLNKkQm7bHC5Ksb59NKJuE7tpK8g7cIb97hLZ0/5LGHBi5K/bGR0CYWxByeihrjP1LlSecSymJ9QFHbRyogjtLrg3E+vqgF+nAMKK2+w0YCeLT/8PzXMlzKoL0w9LgA0TUFXmHVYq/y3zLo5sbJq6z9zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T3Z+wb/l; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8ADrTLCSVlbjntjgnfP2vZptgjRiGww0tJQRZBr2fjZAVlI/f7hGKsyJvTRurs2IXjg9aoYC9QWX/fBFczleDI23JbBS8ktSDAEqAJpx/n1H/TpCo1UhhtbhFCs+oN2HyWZzzuJxjN6JcaDKxxkzv0YQAT3E+wizkCItBOthePA+XQ3xQoye2/rCjOF0GpRg4zI7ISNehvT4nAjxo+WOgkZfHidNr0nh4dhGBYE4BsULY/1/LCvl2KAQJZlCAMP+01cF//VtOB+ROXWG4GnfC3pxVZ4OdJrh0Tl9Qo9wiRKbiXditNovtoGGidylJsb7jHIyjLVnlbCtvgUArbnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPNnMUCm+0r9jQ761X7/hEMweshdQTwK9CZrbK3TaCI=;
 b=iqaabR9kgC9gP1hqCIZBIWO06YIOGq4q8TLTM+YShZNX/VhJX9elPt5HiVqOECHWPNl2gy2jBM6qWTLtoZvAEYrtHmm3JUswHtSfu6nuRJVqlf6n93QTCnCkdUfdIc7RmsUFYu3S+AGv+Z798g4K5IaA8rkhYLXnT+YmNKl72RGoJxpYK7W2BfksYlxDHgZndvrQ7moWPxJGXAApISQYbuVSxRZWnpmN8ip49OTms63Xb4UsmaLT2zrSUZz6dj3OXv8Bd3EoEvUjVvUHvkf3M1gDsnwYm5mRpxDJLVqTYJ1m3BSWCBW4bKq2M9M01uEd5fTGTa9p0QejFXCUXFwwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPNnMUCm+0r9jQ761X7/hEMweshdQTwK9CZrbK3TaCI=;
 b=T3Z+wb/lyDUcE37eJ+MhXX/D05mBAxQ8KNh2BdZJP/u2du+KPAM/t+pp1JPC1SZjE1DmEd5FOeun5cy5bCal6jrUTB2cAEq1o4DIelpV/tuBtmsNQgNmhIYVs7/LsODEpG7PmW5wxGcgfYkfhB+I2FQNo5mgyMGWsylNeDTYSz0=
Received: from SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 8 Jul
 2025 22:21:13 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::e6) by SJ0PR13CA0060.outlook.office365.com
 (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Tue,
 8 Jul 2025 22:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:21:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:21:00 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v15 21/34] x86/resctrl: Refactor resctrl_arch_rmid_read()
Date: Tue, 8 Jul 2025 17:17:30 -0500
Message-ID: <7cab88ccc3e0e173271c9b12fce22785bbde9239.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a4a70c-a907-49a4-0c4b-08ddbe6dbfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VHhUsp43sdhu6X05RBFSJ0pdBov5r3r2ooHNtIABWuv2nPPyNH0NKDqeV/mm?=
 =?us-ascii?Q?QUZF2Si/3DCJ4TdmBkF0IjdsdTG2hwRQYrQeVAeMFbbVw6mWj1pxnOjD7M7+?=
 =?us-ascii?Q?Mbyw6T3YaHQQPRKnyNOUg8/U75adw5l9yW/nUiI2JOpWZifj1jMSWJufoJo2?=
 =?us-ascii?Q?77cKySjgnHaplSptzRX0USXZgHvM9ru7RyKWJpBQaJ9e2ayZG/ByWwxsKVXu?=
 =?us-ascii?Q?7OPvyMltKBYdEYqaDAPxItFyfy+voMXg8y9WAFraNGzXqxcMpkdBufmNhPp/?=
 =?us-ascii?Q?E8aT9eKJ4yv9WyGZ+YfbJUYR4MTbPzCDwOdUsezkdb/VMIGRcpqOg+K6956R?=
 =?us-ascii?Q?T8NfKXByQL7yNDTyl3qrs2YOWmQ6vWZwdFQZacFHPuLXAsDwzUKL15uF8fae?=
 =?us-ascii?Q?gH8RES1fN00R0ibfut/u8CTCpHKewZUxt1iSp7znDtdS6dojyesSzEjzCR/d?=
 =?us-ascii?Q?olh2wSz9sGl9j8c/MX5b4rOdU0qbA1diILOB+lKArNjmYG2TLeOVEYHxkZxX?=
 =?us-ascii?Q?uD/pjSx20zfYi02ezQKKIW3BGti6f02FtpWYyVLbTAixc6UbDMt4qrCs8rf5?=
 =?us-ascii?Q?oMuYBVOYF2/amlAxddOIXkb6PkjSP6LqEeFTvDjoIJeFltz3BNA1H4bAeMtX?=
 =?us-ascii?Q?YD4d7kuPdzbdigBmUaNBGONEu4uwDVTkYuHdvONWfXviizJqvrfZyF0feOn7?=
 =?us-ascii?Q?aHDPr6ds8RPPMY3ta67CTbGogqYJjzH9voER0wBb9t2f4h/v4Dx+ypxyPcCm?=
 =?us-ascii?Q?4IdTUlChu4391GFEriYnav1wDlitVHPc/rzeTkHxIcPP21fNmsRmoRJAQCjo?=
 =?us-ascii?Q?tBVHJaBNOJ61Zg2u+zWIUxupU558arp0sgNMN88KX8SAsZmECVErweGHZcTq?=
 =?us-ascii?Q?V6BG4/PgTIIIwfdF+MH/E6cokOGdGR3fmCgUTmi4N7ars5iQebRpdf7SP4zd?=
 =?us-ascii?Q?0a+m4cYvfjlPQpok5MGUY6YkqfL5Wj4tzBCN629EIam13hXCopHYJQULTtml?=
 =?us-ascii?Q?JSNNXjlBvVRhJmjfgbnjtnftnU4CI9TpuE5m1j16OMTS/CEPZVzU4WuxX/bm?=
 =?us-ascii?Q?pCOMfjZM4GnFadjW/HafiSjdo2p7IC4gApLgYwJcRdi5abXVdFPr3TQn5UCP?=
 =?us-ascii?Q?Enr1m2zt8vK4rnxbS155V8JO/n31XP32qkvK6Szb+mcxbFOxz+l17iImlP+q?=
 =?us-ascii?Q?oshWr+YJBQVyvhgRbTwxki+dXboG8s3Tev0scSzZc3IHPYEH/REDF9etwtOy?=
 =?us-ascii?Q?H8nizBLU5GGOrmpPw0Xm7/lg1iiaZGO5+De0a5OCGDzrZ7A+/oRqHNULVJti?=
 =?us-ascii?Q?nh5ZmGzDS/oAwANZiLn7RVCJfJNrrmRDNGMXmcdlTouY2RMGQ1TGfh59MLjz?=
 =?us-ascii?Q?ILnM4SdSbkAlrI48dHCrHS96E90h+IbwEiiVHbTdYAu0XiAECBESY1XJyZjb?=
 =?us-ascii?Q?IfQUKdqkAbjKMujyopRN6cKLm0xXOLY4df7lS+spwkzx64zlUdz5XWyJq3mm?=
 =?us-ascii?Q?b/vv9i6YRNesGgzhGzi4WTJ0Lvvkq2BiFA/qYiB5XVoU3YfiGElrwb/fUQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:21:13.5375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a4a70c-a907-49a4-0c4b-08ddbe6dbfe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236

resctrl_arch_rmid_read() modifies the value obtained from MSR_IA32_QM_CTR
to account for overflow. This adjustment is common to both
resctrl_arch_rmid_read() and resctrl_arch_cntr_read().

To prepare for the implementation of resctrl_arch_cntr_read(), refactor
this logic into a new function called mbm_corrected_val().

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
     with mbm_event mode.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 38 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 017f3b8e28f9..a230d98e9d73 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -217,15 +217,33 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
+static u64 mbm_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct arch_mbm_state *am;
+	u64 chunks;
+
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am) {
+		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
+				hw_res->mbm_width);
+		chunks = get_corrected_mbm_count(rmid, am->chunks);
+		am->prev_msr = msr_val;
+	} else {
+		chunks = msr_val;
+	}
+
+	return chunks * hw_res->mon_scale;
+}
+
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
-	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	int cpu = cpumask_any(&d->hdr.cpu_mask);
-	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
+	u64 msr_val;
 	u32 prmid;
 	int ret;
 
@@ -236,17 +254,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 	if (ret)
 		return ret;
 
-	am = get_arch_mbm_state(hw_dom, rmid, eventid);
-	if (am) {
-		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
-						 hw_res->mbm_width);
-		chunks = get_corrected_mbm_count(rmid, am->chunks);
-		am->prev_msr = msr_val;
-	} else {
-		chunks = msr_val;
-	}
-
-	*val = chunks * hw_res->mon_scale;
+	*val = mbm_corrected_val(r, d, rmid, eventid, msr_val);
 
 	return 0;
 }
-- 
2.34.1


