Return-Path: <linux-kernel+bounces-884413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 29819C30154
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2F9034DF35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8276316191;
	Tue,  4 Nov 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gF5KqHEp"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C80314D38;
	Tue,  4 Nov 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246424; cv=fail; b=mLxm6+0mAgQcvg2jYVTIslIa8y2ZzLdUTpzfF/KrtE3oL4qs7HyOhCvepBsdsBGFqovnAQV8kDm6GgAtv0ZtKEjrJmqYfhKEDDIuBlTEvBulIf4gy/cqUnUMk5bDEnLNB/GBPacA1fJS/L7KgN2QLUzAecPG9SEWKH0bpV+V39w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246424; c=relaxed/simple;
	bh=3+O6e6gwm+3XTABjPxko6cxMLBy4DkCun0lxoyYm3CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KP1L5kybxostKluUC1WDZ9eSNcN4WTdU3SePukZT2o8rbe3ixC53Y8hpha6qI8At+88Pn5ToGFR2p9TtnpHqZtpGqHrn4jfaLVmonputGYFCgFNEdDVpMB1+WUkhKhk8CdVPj4t3EWYicutYLoXToGrI1fS1ECUKEjYThy65UaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gF5KqHEp; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwCW9r6rM9q6zxxXdDAXcE4i31p9e92TFyhpZaUaJpW4/ngjLw13Lm7yJFtDCMq8WNBhpmSGO/Fb7EiVqTTu5UZajp5SWLSwZxiYjMSre/8YZeUlKdhbhj5Nt2jEFt4g8NV1P5RJuljnL9WMO74wVa8xwtXFn3fr1s/FdmBPH8Ld1qvHFD9VFqBjLzxP0n6pFZeZsS+3NOThqC0010xjcHesrBk52q4fasaiBX3r4PapAofWzxmQkX811n5I/cxoJgd+wyEbDszhd2vDE3eYqxVbsh1gCPQ6BB6gg96ArtimqsYVQSWMjQHCERmqB3kaPw2dPbdddbCdjnGhF4vCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDEPsTE3605QCFDAOEacNy3Y9RR17+EKMiIMrwIc4Rc=;
 b=nU31/D/Y69X1ysWSN2D83Ntg+WVhLObgkbQMrH2LjujvYxTv6PIwXRYiH7+DV2zOESGTtisGm9sqXmC9itwUumHyJC6eoqXGcrxADWqPZYdQJ8cfP2MjGbHoyvjmP+3uMTr3mZu7FUukt+WG3/q88eYnatRk0g+HA/kAHipK0JmjhqMW9+xy4g6laj/rfdJ4hR6xrNc9UIGl3fbHy7x5U3dxDr742hDPRw8cewTOX6k4dacHFw7cz6pa1269uUBft0eOIvU2/DoWHIrPAJNNenLe4WXv6LHh9khOUVkMhG2qrreAge+uwoBysGhwwhZnd+qazqXOaMiDRBdn2JEClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDEPsTE3605QCFDAOEacNy3Y9RR17+EKMiIMrwIc4Rc=;
 b=gF5KqHEpT3qJKH+KE8bDTfgadDPhXwidyMFrNs6RYGKSc4lWeSUdJpb52mG/whlxvfsmxr43VX5SBJsJUzIfzsVyAtnVx7Xk9nT24FHsr8KR2NisWS3fWGr3MTNzLKbaGkZuoaL/ogRXOVE4BPfb79jAdq7DZljjLn+YvRvicmuG54oFwgOWRCKzDhQpeFjc9tCOV/AJy7VLiEI1CZZB5i+ZcQd45ASAuMYyLNIfYOiM//rxDoNKG0zWYGpL79bITkLaA1BIH/7d5deQmoBQdDp/jMuCyow0oM7Kvki66SZLmcs+uPDWpDZUsTxrFJtikG8HosRBUAfNX7NUD1szYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5164.namprd03.prod.outlook.com (2603:10b6:5:247::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 08:53:41 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 08:53:41 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 3/4] i3c: dw: Add support for Device NACK Retry count
Date: Tue,  4 Nov 2025 16:51:10 +0800
Message-ID: <0098b646e37db167958505afc4ba040ceb511f66.1762245890.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762245890.git.adrianhoyin.ng@altera.com>
References: <cover.1762245890.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:d10:24::8) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea4437b-3773-43df-007c-08de1b7fa728
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gNTMn1128Qpi9wx7Je6uxFDEYNJMAUFwHElwhb7dd7DI9b4jizQgK0tNonDB?=
 =?us-ascii?Q?o11/0NcFx5TU5uoG2vvjn5tB+4MZ6zla6uQzpUY+FeY7PelgLIQdjRHGmdJR?=
 =?us-ascii?Q?Xo+AbzV5wRR84HgCk+pO65oDx3q9pc7bZLDNW+93Syp0xT5vFuiOP61vxXQI?=
 =?us-ascii?Q?gN1H9B8xk/ZsVWMZEC8lEA7C3UTofxsWYk75e7vrreUhRXTykvMI7puTYdG1?=
 =?us-ascii?Q?XoHMAR9LCRcGXsRemaWxBw+9eFqUiTpMzEfcdoOXEddWXqdMkdyiaTBjB++B?=
 =?us-ascii?Q?EZ3nz5mgb2vt7UemXVRB0YcXtU9pyVIn6cC9xMH2Gm5yBAjuRAA9MAUzv+Ik?=
 =?us-ascii?Q?4PzFXEeFc5bvDBIxXE4OiLed09ZzMU3aKdeTOyDNS+s5BfRmnS6WfAuIwKA3?=
 =?us-ascii?Q?I+58ZGFfZJ9QH75b4K10rU6EnShFoLPcNOP2t4msB3lMjyXNY6f2iKCVcc8J?=
 =?us-ascii?Q?y0wJcibzt5SV/YozppDGOG612VN02XvC7DDGjotVLP2ANvKe7bT+FSX9C0oA?=
 =?us-ascii?Q?LoqLNRoO31c9V6naoZRB13C0CEmqEXqe6mj/ZEmDL87AUkCsXv+/OVw9uxc9?=
 =?us-ascii?Q?Bm4o7ycpwKioIwZbQFgwK3yFlZHwBddUlTM3j7eYoJyD0ELQWM1/KO0FB+LM?=
 =?us-ascii?Q?DZ3SjDVgEkWWACUag+xiuTFpOzSPDhCJbu7PVWxTZN8I5X0imeH6LyyZAn6s?=
 =?us-ascii?Q?YPdf6Y+E9yq/Lny74vDIxl5whTCHPPYWgfWQu/Tv+/0LqdqDct1PROn+ykP7?=
 =?us-ascii?Q?4Ix+vUv6awPSq39wmBjwQ12Yhdv1fZrtIcvyZUAiyyFjPGHreZMPzxlqVtdv?=
 =?us-ascii?Q?ZTC+GSQ3ugp5oTtSTXzrOuF5dRr2BEEbXWbDdKa5zkZgsFMdrPMPPPaqpPti?=
 =?us-ascii?Q?rAaX+JX3uaGWTW/fCGC/kza5u/lKSL2c99v/YFVSVFMVsFH3fBJygjciQDzi?=
 =?us-ascii?Q?zA7dyRzecF7OXdQy+6ZECbnhtma4YUwx3+yz2BwrIlWcSiAqgPqCAUqljY3m?=
 =?us-ascii?Q?iQGbNKlf3iP7DlKZ+rboZY851fOkGP8w/aOfB++kuKy/QrtZ/VuL6LHMEWj0?=
 =?us-ascii?Q?+rb62dZzIjRz8chA3kpGp41sUaGv3IV+EJvNwjpMUT0bP3D5NsIrJe0wDIGE?=
 =?us-ascii?Q?+bmxQg0GzAlhjMD3Ik/kRc0KN5cmYOlxdhLfeDY6gB97/qI7Ox4ydM1Poi6d?=
 =?us-ascii?Q?TwfKYNqBiNuhPbQWb0CIklPVeM2KpAf2fxsPy4aKHKGfwj4Kbx9C2/j2q8Zt?=
 =?us-ascii?Q?51NfVOxluXDJOqezeHxWc8YS/4AN0pZlD3JNaYJFUI8vkFBZPmkbyI+US9xC?=
 =?us-ascii?Q?hmc8gJuE7VDiG4Hve6OAhFNXHNfZDz/DSkwb4AsK7n/R6NwSGBe/yNouuVdt?=
 =?us-ascii?Q?07p08BsPOpMZG3UFnKB7vVb7E+dLNvUaaHT6WOqYZODHmB3yTbWlaCTBU+rI?=
 =?us-ascii?Q?tMzH6092wesFf+XwNP+/onpAVUDWARgqKGXjYt3XK2faLqgcqx4pqjUv1Q+M?=
 =?us-ascii?Q?ikWXTC1k9/aQ3bI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?14GCZrjQNmK66kkhsyllcD6L3mWH+cdUyDwxtrWA68QjMK8CjCq+89y5IyBQ?=
 =?us-ascii?Q?Gg0jqSj2lWWK/qn6SLki4x33TsALSv2aJdhb9qjOXWjFdLYebEULU5E5qU1T?=
 =?us-ascii?Q?BkEQgYQJ4WYyX1m2FV47Af/pFBvBI0RhMaE1l5vy719ZJ5UwLJuEGB1aABRJ?=
 =?us-ascii?Q?ok5T0JTC/3MCpBF0jfz5gEPMpsiADxlel77v/WJcCjWzAIiAlEEiWXM39pdv?=
 =?us-ascii?Q?a5EB3erfjAsmiosHMCLypBy1gVmwUyUlRvfTVu6VemtV17fAmZB/JrSNJHf6?=
 =?us-ascii?Q?apzrjdDhAiGDgunnH3c/GOr7BDIpFaNiK6qWq6DfMlDMdRn0sWogugLqNxwo?=
 =?us-ascii?Q?ekDIxHs0a7Le+Lnv6WpONTyngiPPSxSJI4/SHqaVjajr1ySGxnrs7BN9fmDQ?=
 =?us-ascii?Q?fGlD8NLXErchewxImkHNlA8GBn5dhfxqpiG2XbDiD5pvBEmScBjJF6Q3FKzo?=
 =?us-ascii?Q?85HkhyQdviUiUPdGmjQ45RRIDueNhZg3Eqimb/KaCtxqXs5k85g6j5iKJxql?=
 =?us-ascii?Q?uXGD3QHBZkUzFPWwPGAEFQNJo06P3MfM1bhFI3sB5risMaSeLkghYIMg9Ytu?=
 =?us-ascii?Q?nYBGHrm9cWnM7uWKqhHAAHRPftrIgX+n035c/Ne7s8HzGv6xPVTAL7ylBmH/?=
 =?us-ascii?Q?fcA7mghsrv+N5PCxE3PAs1lFCNdSqBTVAVF82oWBIIX0IvHXFzxM0M18sH8e?=
 =?us-ascii?Q?L8gRKv9SCGwLgl8biwOt22Wj4LaT53Fvp2FW2PcQ9Jf64Ooqn2cmWXQs9cOF?=
 =?us-ascii?Q?P3QNHxPnaRiiV6lXcyA/1f800Hr63Xbps0DabhDQE0+BF/CIrHO1sjx8zUJ0?=
 =?us-ascii?Q?/OaycX0Kf9qeqWdxQK9j4LGjjFzjXE9J8DuWdOp+hrVMDKjd6SDKc/8ZqJWW?=
 =?us-ascii?Q?VzzOb7xU4EJlFnIA3fOwwkW5FVbYJUg5Nohqt0JAQJdVT/q9SqHnuMqCEAvT?=
 =?us-ascii?Q?3FEz4ttOJtsaLVVtQ/DMLxLPyDCQbOe+dOrkGuJiV/rVVErlWHvvQUMKRwbA?=
 =?us-ascii?Q?Eoyi50HQ9exTMFbJCVPTbnL/F+mhzpyuC/T1jaVqwkLbGvsdNS6lISP0tHtu?=
 =?us-ascii?Q?+ymbpnndHxZ31B6DcHc8YuwI64q0EeQ1YGsdP/V7V7a+brYXdvhnmd7Yc6qA?=
 =?us-ascii?Q?al/hIClXLV5+6ZJHS6R/CtU23VPVKxoKOAnBL9cxAnepjoMQweg7k3AivCVl?=
 =?us-ascii?Q?xaQ9lvFHUYJlAIiXg/nQGtavkR2oNkCoMwv8H5wCQRJEk5/1fYOB2AuFjUtK?=
 =?us-ascii?Q?XVYrD4RO3b+Y/HVM8PYJ4hCG6WaXGzxoa2eZViQy5oH0sNys5JRGNtNU7+A+?=
 =?us-ascii?Q?ED5vtjH/BYqJOKjL2RzyakmHVD6OWkCT7BifzvEUMlAbLJTeNgCWDB2TMcyH?=
 =?us-ascii?Q?zjAtPndF/wlB0dFnPs8V3EEPlIL833n4AOMGcQXplyN5M6FhoHNzAcuj+dRL?=
 =?us-ascii?Q?l1uAKpN+Br9yywLzIORv23mRvc9qAj+DsXJzy6J12oKXgYewTktPZxWVRFlx?=
 =?us-ascii?Q?zZk80DyCV57T3NIyZO0rQYUxJ6LeDF5KXnQBjJy0o+naJL7O9xawM2JVavQ2?=
 =?us-ascii?Q?qrb3YsLTxvUy4gcCUxjcwh1deqSm+8M9dWMj6KE7q2qzH3jgWOTK9/BEvtuJ?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea4437b-3773-43df-007c-08de1b7fa728
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:53:41.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwfQZUxC0GjFqKE1XPxKjpv7jl3v5xcnDyqk42DUn/7838poEs4d02aXp/xcgiPO23wAAvKBcnW0S5NM+o+lbnHuVp8DTPj4cwpdKU8j29Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5164

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Some I3C slave devices may temporarily NACK transactions while they are
busy or not ready to respond. To improve bus reliability, the DesignWare
I3C controller provides a mechanism to automatically retry a transaction
when a device issues a NACK.

Add support for configuring the Device NACK Retry count in the Synopsys
DesignWare I3C master driver. The retry count is obtained from the
'snps,dev-nack-retry-cnt' device tree property and written into the
Device Address Table (DAT) entry for each I3C device.

If the property is not defined, the driver defaults to zero retries.
This behavior is consistent across both Device Tree and ACPI-based
systems, where the value is only applied if the corresponding property
is explicitly provided.

The value is clamped to a maximum of 3 (hardware-defined limit), and a
warning is issued if a higher value is specified.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 34 ++++++++++++++++++++++++++++++
 drivers/i3c/master/dw-i3c-master.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9ceedf09c3b6..12ee4c4afedf 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -204,8 +204,10 @@
 #define EXTENDED_CAPABILITY		0xe8
 #define SLAVE_CONFIG			0xec
 
+#define DW_I3C_DEV_NACK_RETRY_CNT_MAX	0x3
 #define DEV_ADDR_TABLE_IBI_MDB		BIT(12)
 #define DEV_ADDR_TABLE_SIR_REJECT	BIT(13)
+#define DEV_ADDR_TABLE_DEV_NACK_RETRY_CNT(x)	(((x) << 29) & GENMASK(30, 29))
 #define DEV_ADDR_TABLE_LEGACY_I2C_DEV	BIT(31)
 #define DEV_ADDR_TABLE_DYNAMIC_ADDR(x)	(((x) << 16) & GENMASK(23, 16))
 #define DEV_ADDR_TABLE_STATIC_ADDR(x)	((x) & GENMASK(6, 0))
@@ -989,6 +991,7 @@ static int dw_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	int pos;
+	u32 reg;
 
 	pos = dw_i3c_master_get_free_pos(master);
 
@@ -1009,6 +1012,15 @@ static int dw_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 	       master->regs +
 	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
 
+	if (master->dev_nack_retry_cnt) {
+		reg = readl(master->regs +
+			DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+		reg |= DEV_ADDR_TABLE_DEV_NACK_RETRY_CNT(master->dev_nack_retry_cnt) |
+				DEV_ADDR_TABLE_SIR_REJECT;
+		writel(reg, master->regs +
+			DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+	}
+
 	master->devs[data->index].addr = dev->info.dyn_addr;
 
 	return 0;
@@ -1020,6 +1032,7 @@ static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	struct dw_i3c_i2c_dev_data *data;
 	int pos;
+	u32 reg;
 
 	pos = dw_i3c_master_get_free_pos(master);
 	if (pos < 0)
@@ -1038,6 +1051,15 @@ static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
 	       master->regs +
 	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
 
+	if (master->dev_nack_retry_cnt) {
+		reg = readl(master->regs +
+			DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+		reg |= DEV_ADDR_TABLE_DEV_NACK_RETRY_CNT(master->dev_nack_retry_cnt) |
+				DEV_ADDR_TABLE_SIR_REJECT;
+		writel(reg, master->regs +
+			DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+	}
+
 	return 0;
 }
 
@@ -1592,6 +1614,18 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
 
+	ret = device_property_read_u32(&pdev->dev, "snps,dev-nack-retry-cnt",
+				       &master->dev_nack_retry_cnt);
+	if (ret) {
+		master->dev_nack_retry_cnt = 0;
+	} else if (master->dev_nack_retry_cnt > DW_I3C_DEV_NACK_RETRY_CNT_MAX) {
+		dev_warn(&pdev->dev,
+			 "dev_nack_retry_cnt (%u) exceeds max (%u), clamping to %u\n",
+			 master->dev_nack_retry_cnt, DW_I3C_DEV_NACK_RETRY_CNT_MAX,
+			 DW_I3C_DEV_NACK_RETRY_CNT_MAX);
+		master->dev_nack_retry_cnt = DW_I3C_DEV_NACK_RETRY_CNT_MAX;
+	}
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index c5cb695c16ab..45fc1774724a 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -51,6 +51,7 @@ struct dw_i3c_master {
 	u32 i2c_fm_timing;
 	u32 i2c_fmp_timing;
 	u32 quirks;
+	u32 dev_nack_retry_cnt;
 	/*
 	 * Per-device hardware data, used to manage the device address table
 	 * (DAT)
-- 
2.49.GIT


