Return-Path: <linux-kernel+bounces-896749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D347C511EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E1518972B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6DD2F25FB;
	Wed, 12 Nov 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oeEHGkTz"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A535CBB3;
	Wed, 12 Nov 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936267; cv=fail; b=Ue2Eh/l9y8VrnA2RFpvpHNVvKppNRl1AG0SCjENTcSBDLsLExSlJTGY/tkSSqbPjrC8GfQ/squvZDARpQnWXUE3kXV2FLxRLqBQ9BpV1hqBFjs3f7uJgUc5ohhar22HruObaMT/hZFQmLnaEuSkGC1Fu/6ztC2foUo8pHadlAzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936267; c=relaxed/simple;
	bh=68FxSSMF36gqwG2iIUMfVvcnWtjX1Dmj7OBqO+Nn9uk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GQNYMR/CEMItfYiWfLDFRyT857AeM6L86ofi1XG5k0zpC0Zpreu8KO+OM+uRLiJJ/R5mRXjn34lFXfdPq8jf2S5IuzLouH/tSSUD1KzwHWOwJnzZ3CvgUOu4fTj6EztLIXYP7oXzojiyxXBS27FljP6dbi5gAUjzjavEBU4Fca0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oeEHGkTz; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEbQi6YcZjwXiT/cf5q4UC39g0bjwGcvZ21wlhx889A49vWi5oFNpqRqHzbpAgswygsfFsdo3BRZyp4vWuadCgQ8ae+/ivuWdWH0jE6lSe9wcSNT0ePw74wMmFYE+Um10w2YXUMp4neFkqwVTfK9aPe4sA5N+gaBPJZdEqrCus+LI6DtL+cE28Af67Wzhp+YBaK3KifdqyYsBpcj212m+N5C4Lyt9fQwMhV2XVSyaZWlZEfOcmsoeZ78WyqcVhNrzLMcbLYbkZVWywNynkHOX+5pRsggS2WjNMvszJz/d5A0/Ldpjsh7DkYDJCKoAiltuHPmmHE/ZoVkgIqgZ9tomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey6LDiXkumCT+pUbQCWZsNxNHeWFqIF+kAZraexImRs=;
 b=audjFuuiwdWk2q0gB5gTh/MOKNsKsylbea7Eqz0KCcEInNwwxQtMOrk6/6ECt2VGh+dpMcYST9JaRRQnDNi8x9zS/UqdMCXAa5NAigQUvzhr2de57iQ8BdXoRuq1DNwCqh10XLfpitthEwEF3HIzpEvwLv6gWUX0lpVjjzrJgPLgfhXXB9mEUr/zYPS8HKqaC6duRvQD7zm2CW3lvuIiKYCosapBm338NJJlLbYpCIwOWatBigvhYzT6bkX3FvgwnlKzXOcpzKFhu12PlvcU3ikICn6A9vcPc5uVeclCwulHLXlaeKzx4RFzO4Vw7rkQ9zrQepNqihN8gtECupSMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey6LDiXkumCT+pUbQCWZsNxNHeWFqIF+kAZraexImRs=;
 b=oeEHGkTzW+QgDPOYWOYxCVtmrvE5W+BB/di2Md7VUZQWjD582qaBTQtT4s5sykPrl1W5DL5hbM9MCwBKjBqyfD27T9ibnCtja/IkmjtThjRMvSCr6CJkMueIQ9kk1LDRuK+kfrJe5JI3M0+91VyhDsm8usYRhocPJjrrVtnbCM0=
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by CO1PR10MB4513.namprd10.prod.outlook.com (2603:10b6:303:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 08:31:02 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::21) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 08:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 08:31:02 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:31:01 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:31:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 02:31:00 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC8UxtU2389830;
	Wed, 12 Nov 2025 02:31:00 -0600
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH v2 0/2] dt-bindings: arm: keystone: ti,sci: add entries for
 boot mboxes
Date: Wed, 12 Nov 2025 14:00:52 +0530
Message-ID: <20251112-k3_syscon_add_boot_mailboxes-v2-0-aebc1e47b391@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALxFFGkC/33Nyw6CMBCF4VchXVvDjJbbyvcwpCm0yERhTEsIh
 PDuVuLa5X8W39lEcJ5cEFWyCe9mCsRjDDwlou3N+HCSbGyBKSqAVMnnRYc1tDxqY61umCc9GHo
 1vLggi6vCxtqyKDMUkXh719Fy8Pc6dk9hYr8ebzN81x8M8B+eQYJUWBrMO4Q0z24TnVseRL3v+
 wcAhS+pxQAAAA==
X-Change-ID: 20251105-k3_syscon_add_boot_mailboxes-8452bdd98962
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	"Anshul Dalal" <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762936259; l=1180;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=68FxSSMF36gqwG2iIUMfVvcnWtjX1Dmj7OBqO+Nn9uk=;
 b=tTdyiO5tHARSufrm0GtB4VZFEWlFNtEk6Po4AkvfVx+zlhxwJiMrFoACSWbCbprZxBsEiOO4Q
 8GLWYVblVO9ANUHCFtIaD9+XnLi4AJm0ndQkCz9fKLfjFNSLyN5Fk/U
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CO1PR10MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 942c2fbe-7c6d-44de-5ce7-08de21c5d066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEhtU3J1SUZWQ3J6U05jVnROd3MrQ1k4NHAvVmhCUjFnVkZrdjVoRHVrUDl6?=
 =?utf-8?B?UkxmRVNoRkNBTzh6S2phaWRVUEw0WlYvUzVsTzJDMjZuRVRmUTJhaWlHNlQw?=
 =?utf-8?B?T3hlMlg5R3Q1dE5HbnM1a3BIRXJyMG5yNFRPc1JZYjByMHI5bHM1MzBvMnp3?=
 =?utf-8?B?UVhSNXpJdGNhRGR2eEJOMzRGSjdoUkIwZW5HZFRtdmR3K1pqU3hvSk80aXpQ?=
 =?utf-8?B?dlFHeG1WaWExdFVsSG5Uck9DSkVualpROUMwdi9hZERWV2NTam1wZHFDN082?=
 =?utf-8?B?Y0lCR0IxYlZzdWEzRFY5b2d1TUtackVORTd2WGxVeE5Bayt6N3hNUDFMK2NQ?=
 =?utf-8?B?TG5CNytyOGNPZTMydktVRkUycHZ2eWRuVEdyRFFhRDVXQzRGV1dscEVwUHdz?=
 =?utf-8?B?eFBrQmF3c0k2S0lPbkxUT1JsOVFYQkdYN0pTUis0bXV5V2QzdVExSGdJYTRs?=
 =?utf-8?B?aHZnZ1YyYlMyL0JCTUpTbXE1RnY2MkVJVmVaYlgxZkZxOUNBakZhS1BrN0ZT?=
 =?utf-8?B?cnBXbzZWN3ByUGppdGV4L2UvYmJ5K1ZkTmMrVUovY0U5THFWellydUdza2Fq?=
 =?utf-8?B?SkorZmxKM21MZkc1RW45MTVWMksxbkEvanNuUUt3UzRyME1CWWdpSEhmakth?=
 =?utf-8?B?NW40YkN3Mm1OQVNkemRadHliM3poRXVGM0E0dFdadWQ3Z2YwU0RCQzd2YU4r?=
 =?utf-8?B?QkcrRWRqbXZUS0o1YzQwVnl0Z0ZRT2dwcDMvTUVxelJleXEwdi9pZ1YxMmY0?=
 =?utf-8?B?ekIvb2o3TXBzUXZSMGs2ZHpLYUVHSlllQms3eXlNQ2xEb2NNUjJCWEhwTzZF?=
 =?utf-8?B?TFdNV2UwTk9rR1lWalBjS095VlczbURjdXBRRFIyV0pkTDJhemlHTWpBYkE0?=
 =?utf-8?B?MUhLL2p6aEtEeXpiU3hJeGovR2RJbThKRVg1UXVGSzFRKytVbFVOWG9QbGkv?=
 =?utf-8?B?SDdIY1I4dk9RYlpLSC80Tmc5YWVYQVJHcHFxeVpueXlDMTJmeStOUlU0RkZL?=
 =?utf-8?B?aDlacEVYT2tjMGZmcC9ROVhLOWFrZG15VmNIRnFMN0p3ak85cS9OMVJyS3d6?=
 =?utf-8?B?cE5Bb3YycjF6TG5HUTdDK1RrUnFwYy9HcVVzZ050Und6K1VvTjU1K2t5d1Ux?=
 =?utf-8?B?NVVDVW1icXZEbmR1KzhscDhaRTFmd1I2RWFqRW1IaWR5NlFLSFRtT1VrMVZx?=
 =?utf-8?B?UjJMUzBnall0OStJQlcrYTZPYW12aHZiYUUyQVJSOU1kS21xSzl2L1BEckJI?=
 =?utf-8?B?dExDTGJzWFNpVmxpc0pPQXI1Ujl6cWgzeVVXYnpSa0MrM2MyZWdJMGo0UmF4?=
 =?utf-8?B?RUJQTUVYQWkxMmp5TW1lS0hLb1ROdFVQczg3dVZmcVhUajJQeG5SUDlNSXUy?=
 =?utf-8?B?MVYzelYwYUdYa0tDWHFsOThzWmVCMi9vMGt5OGdOQUZoVGh4Nm1RQ05EUWMx?=
 =?utf-8?B?R2Nwa3BpQ0ZpUy9MclJwUE9ERXhqNUNpRTIxdUV0a00ySDZ0SG5ydCtLRDQ3?=
 =?utf-8?B?K3o3STBmRGJ1Smc5cVlRQWU5NzBkYlg1Z1VRL3FOdkZuWTBUUWRXd2M3dTZu?=
 =?utf-8?B?aGJJZWRVa1NvSmRQd0pzdVRGM2FialR2VlZtWXcxUnhTemw3ZlpJWGE4eDVB?=
 =?utf-8?B?MUh4WTJTVUVoWTRYenJOdDBBSVpGTERRM0ZyT291Y0d3N3pIdDV1NytRVTV5?=
 =?utf-8?B?ZkpTK3FnUkhlamY3OUJZMTZ5YzVyMzloT3dXaXJHNHJDMk04TC9PYkJ3eTNR?=
 =?utf-8?B?TGZOV0Rqa3FqeGN2YVd5S040M2J0bW0vMnU4aW1TMUd4amhkU2FsUERpcldr?=
 =?utf-8?B?aUlSSnRnUkkrb3JjUXZBSnlNYnk5ZzRVUGlMdXJFb3NSeXNPYTRacGxBbDc5?=
 =?utf-8?B?cUxKaUdMSVVRRWNsOWV0d1Z0SFEwdERHcDY2RWEvTEg0b003dThjMy8vVlBH?=
 =?utf-8?B?SDBhQ2Rrb1pPc1NqZDNxREdhRjJRdVNsZE1RZWN0a1lOeXhUQXV4UFIyWHdu?=
 =?utf-8?B?Mzg0VVc1SHI1YVIxTkNhOHZzbkxtaHFqbml2TUw1R2ZVc3ZGRmlJcHpsT1ln?=
 =?utf-8?B?WTVnaTJ6ZWkyanZzZHB4NlJYc0ltbzl5UWFraVFWQTZpQmlxbUx6TkQ0dEwz?=
 =?utf-8?Q?ReY0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:31:02.0710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942c2fbe-7c6d-44de-5ce7-08de21c5d066
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513

K3 devices use the system controller HW block to run the TIFS firmware,
currently we document the RX and TX channels only however before the
firmware is loaded, a different set of  mailboxes are required to load
firmware to the HW block.

This patch set documents the missing mailboxes in the binding.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v2:
- Remove maxItems entry
- Remove RFC tag from patch (added by mistake in v1)
- Document the new mailboxes in mboxes instead of mbox-names
- Provide example with all the mailboxes set
- Update commit title to have "ti,sci"
- Split into two patches
- Link to v1: https://lore.kernel.org/r/20251111-k3_syscon_add_boot_mailboxes-v1-1-529a27f21076@ti.com

---
Anshul Dalal (2):
      dt-bindings: arm: keystone: add missing items to mboxes
      dt-bindings: arm: keystone: add boot_* mboxes to ti,sci

 .../devicetree/bindings/arm/keystone/ti,sci.yaml   | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
---
base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
change-id: 20251105-k3_syscon_add_boot_mailboxes-8452bdd98962

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>


