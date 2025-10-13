Return-Path: <linux-kernel+bounces-850759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB70BD3A41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9762189F1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A138E30F95A;
	Mon, 13 Oct 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RHHBw3rR"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72875309EFB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366189; cv=fail; b=YbqWy/0IVVmlMBDpYarnIKBrq/S0qzWol0cSqsKhpu0nRmDqtlHeMwpyjOT2i1SFNfZ5GzwM1JgkoUn1aJ5I9pdXfQl2kwV2ttx13Fr6DG+1knH2Hf8aS35O/1FGtACYHfjrpgIOqvJxK7oWKvoYQ8hoFt43fJ5kl2NNesFIH4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366189; c=relaxed/simple;
	bh=TEH1i6cPVF03Zi0dHqEq7/oiGJ4iembBJTfRrHoKajk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVI08IOCKbLMwZuizzSUQ39fvbMw1w48eFjp+RXhFaaip/UARTgFbzlusSucIfbZAbKrie9tUXAMMt+hffthJKHJj3cPLAaMQ3AZ+u3+uAnWHwYdml00MxtARkUiPxXclusakfRM4Dalg1n5npLllVy4fGudFAzOyAk82l4E0C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RHHBw3rR; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI5i3HMTfgDCGXXldFjNGDCwmrJMQRS2MmxQnj7wBL6WU6z+4iEHpoz1wtC8PHiBtFDYXNCmO12rYCtfQC+QyzdVPFAau7i6YMgp2Wr/cwdbIUknUDhuE0XUrSbi1sBLHDtntgJXCJhttPFXP32hay7LkVEXfPrVbsoGOLj/XsrLxQ5tWJXT5016dp513B5biAc/PktjtNiFHnNJya1o9YZoUQvVjO1ax30gbmvd597sWd9DkiMASvFLQVp1cylngFNBM0JORgJA7xAZPAaj0iIZETazXrUYFv/U7EKlRTg4yHu61DR9I01jXygGndX4k7tSi+Db14+6TuCqMo3t1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJNepUgWWTzX60xRF+GIMxuLG7tMe5tqtfgRz0WLz6k=;
 b=TFptmnVpDyB2v3EY8WYGgywny+o+J/9gL1gQftlrMosNcypRzLTbTh8T6htn3vFL9uhTDGEGy+QTGU94Gk0NFv0RURA9Mb13fl9Pgs2Lg0adBysVC2C41oP6bHilJTzvMKfmQMEHGaBBFIOZ4npmzN1x0KDahA2yN9vTDbfUE/LDszIEu9ncTw1YD/HLKy/lOVrcb4Equm3YkO6MCJKuFH2sE0hNS5KYzga0F9CmznOK+Ys3xVSD8mOC6Y4lShpljlnrdJRIi+l7g/FyGK2zYFBBs0JIR23/ILcYZWd2pVaZ68qA57c8g9495lCS+w14XpnlnVF2rh6NXlwT2fsOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJNepUgWWTzX60xRF+GIMxuLG7tMe5tqtfgRz0WLz6k=;
 b=RHHBw3rRISotzUTxcZNXkEvK44/h2kn2PakIQ6JPs7kQkVtnjrcwJHNmNlJW3Dfm6g+lK+ph3Z4Q73mZcDHveIFI22iZ6+faPrs7q3KQi11vZbp6dl2sabGEoPLSnZCRcZ12tLEB13nx66QYaAG/asgeeIni2shRTJpnEWomnZA=
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:21 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::e1) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:21 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:54 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 49/56] x86/fpu: Qualify warning in os_xsave
Date: Mon, 13 Oct 2025 09:34:37 -0500
Message-ID: <20251013143444.3999-50-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: e6aa223a-065d-4391-930f-08de0a65e0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t5XZ06WAqKoJQrN91jmrjvE/Jg/QKmPm1JUjyynzCuMfVYbbeJpINe4Lp0Pv?=
 =?us-ascii?Q?K13WGkjEDxlit7WKgdceSGxr2z1dwoOVo75KRjG56Rjn+Py8B5lbaXDWOpHy?=
 =?us-ascii?Q?twUr9wdo616k9JNdhAFEkl/5Ox4LD7E2DhfGsc2Nwt9Uz6WkvWUgMrMqNyoZ?=
 =?us-ascii?Q?8CuMrFcR6+gahfLYYNngfjsDhx40b5pax2Afmb6/OBVfI7yaVqlC0BKn8X8Z?=
 =?us-ascii?Q?BNsPTZ39Ta8dG5jiQ1eVQ4oOQ9YEaO+PkVaoKSkfm0yyYPxmqnKp09CqZZd7?=
 =?us-ascii?Q?nQyh7kpxuA0PZ53uANYw0ndPYgkLqcC1tKm8P4bIzboNP5ZN9FcyRmngGs8g?=
 =?us-ascii?Q?3ZYK8wWMOh1EIVXtN5ykVYXz/O5RzhSMkyRaUUCgOzMPEE4SGtOX23/2mBJM?=
 =?us-ascii?Q?RGtnENF2Ylc7YPotZAEYpCeyz/2aozWo3wBJjSdEQD6mP6hlp5Qidd0PqUn2?=
 =?us-ascii?Q?rfUNk76AS9m8f8gQoly2f3fa6CCKRDzlNWh9xl1EWazAdpOuy6NEqLaFbPbg?=
 =?us-ascii?Q?L235CdBqepZPg4fzw0jLOokTCdmuQwPIsVYUU6xOzBhvoUQm6jeF9w77XmqX?=
 =?us-ascii?Q?Ky0ZgPexWLGV4+g0oi7uEyZj+CZ92FyBjNVqkaqXXSIor3cMgdqwyWOuoAeo?=
 =?us-ascii?Q?5PhsrdwC2xuSbQ0QrhOqdzHDwIF6dnD7ID2XeF3IYS1+5oiWbpKnMrUY5IwV?=
 =?us-ascii?Q?mM7kvSrkWwh/n8GTdTJnwP3/3/U6B3xPjYyzBsDvcRWTXNJdeBdkF+icjW8w?=
 =?us-ascii?Q?1C9wMYe+m/b+77TTHG6v1JYH4c4X97EM5GVxHRERtgjbYpEn+P6PTHEeRMBZ?=
 =?us-ascii?Q?UHAdtKaZNN2/MAYaVteZ9oBttpwMcXsdlWjml5Hgi1HatDcpdmEbbaJJ9F48?=
 =?us-ascii?Q?0/+8TP/x+J4AvQkNGFTj2ZYrZyXR8HG1ZojKE0dx8uvXG0gx9+HRxJgpw3hp?=
 =?us-ascii?Q?G7xg2IMOBfv0I5Kt5VOUVN2hU7fG7hGoWLLtk5v0+kM3W3UcrLUUofucK2xd?=
 =?us-ascii?Q?24llqb+QT5df55JYcWF0nzsgiKC0KVUP8pZ4zoubJCM3bEf2V4ww24ESxPd1?=
 =?us-ascii?Q?YxmSPW40UpG05HGR20mdst9/4kwXDrkzBIQ8IeIQBlqaHfHGbyvwL2t9kpbR?=
 =?us-ascii?Q?Dnk005dN0DtWlNAba8xBLq/mSGTQYCKgD7nUzwJY64oe4XLIuTtk2jNcPF6U?=
 =?us-ascii?Q?KVMf28dxrS2Lx5BUA6Jtmag3peNdbIqVINn0FKuoYMJd9GxqP3WWM/+QwMxt?=
 =?us-ascii?Q?4bAL1LYX7/gV2tQO7/raxxb8xFRYi7lUAa1U0o7Eq9o+Je/H453CC34hAzgU?=
 =?us-ascii?Q?FWsGI/QdrxiQAZ4exBFrV784XcbNnHV0mQCnu4MLHNo3I7CBM1fjh377G76a?=
 =?us-ascii?Q?fK24UG76j45luMVH703ZZogkvuTmSuSKCzaXLw6vL0AM4d/a0bGKMBTXykTc?=
 =?us-ascii?Q?+/P+4GyuJEPbzv7RF0UZK+ofUcjCPObJbtR2f8neejoq35+7lserLEi4Znpz?=
 =?us-ascii?Q?UtBoayFriqRTIX0V37gobHzy/pzGBxymAUWUBFXIaHJEhuGzutCAnTWOWTcr?=
 =?us-ascii?Q?JDlxM5u+Q+66l/hv3O4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:21.2835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aa223a-065d-4391-930f-08de0a65e0e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616

The warning about using FPU before alternatives are patched is only
relevant during boot.  Ignore the warning unless the system is booting.
This suppresses the erroneous warning that can occur during alternative
re-patching at runtime.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/fpu/xstate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 52ce19289989..924552a20db1 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -220,7 +220,7 @@ static inline void os_xsave(struct fpstate *fpstate)
 	u32 hmask = mask >> 32;
 	int err;
 
-	WARN_ON_FPU(!alternatives_patched);
+	WARN_ON_FPU(!alternatives_patched && system_state == SYSTEM_BOOTING);
 	xfd_validate_state(fpstate, mask, false);
 
 	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
-- 
2.34.1


