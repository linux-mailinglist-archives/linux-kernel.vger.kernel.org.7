Return-Path: <linux-kernel+bounces-851701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EE3BD717A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD9118A6AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686626E70B;
	Tue, 14 Oct 2025 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="CKUNDiNe"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023105.outbound.protection.outlook.com [40.107.201.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B601DF256
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409163; cv=fail; b=pCrHKTfjMxfJtaAPWhQ6kHgaaMV4eb7q0hzVh2U3WvmLl0cdUyoQSWl7cbByVMmjKoEuVc8nyBQ6VvXwW+e0GAo0y22Iq/teWdFiqftP49Bx4zSVlF1OOkPjebvjrwalrOUT0OxWoIEzv6XRqMsqtwMebT916fWyGCoHPYCn7xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409163; c=relaxed/simple;
	bh=3jXKsnAFymNfGy9DHO3SgORVsl+v+4300njxJQSb4gg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GQ9ZCRk2bbxn+8pYHxryES23DCE8/kTmGaa6piL27VZZStm6n96B2N5Ewj+hUu2qZwiqyqsfa4IIfK9LIpdmONPQPXtGETtlapaIgwjycsdHeLuAO0/NTaRwaM23cwEs7dALWI8dv8pK1oPTzeWHX+SVNW/07Eu+71UhTdqj8Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=CKUNDiNe; arc=fail smtp.client-ip=40.107.201.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoJlPMJZ/BhljEs8Aq6t7wa1AbaSURKrhhcIAFxCWvCQSbBixpmT+3wT1C4GLIWKUuEfHXowJ/6Acp5sfgMUmgfOhUEJ9ykVO8mvscTDHNZ0p/dloYquSe0XYnZ604rBMaxy8QpNdljm4M58HknilADAS25DNc5s7GpNelnsmRI2cXpQyr/IsOBX+Nu7xbdi9GJ7QXC0dTdYzoqa1P7baMlZXwh0VBrGxEztOcaCL05mw87HevJh2O8ztpIpCoRKHNE3h5BVesuvf6w0M9SkwO8zp0B+wdHtr/lNfBkFdcPQGh8KMOyLfKQfxxW9yiUFga7veexmhOy+GNAxvl6VjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoP0hjCP0BXRxcakIqO2PxjAL5KyyHdu+ONe2C6Zsy8=;
 b=yaBHNsP2tOnx2+uSZy6dNJsmD0G1NLXH+HBG0MbV43GYNS4DFvePPNwb3qeIWvYoP8glnGN2Fzq6U31aZsBPsZIIdbfgMPQgBh5yTqMz9BJbzwj3l57u/UIZrUdfgeRGfoq/ams3d0x3+OEGS3db9BFbUJFsQXG6xJBPcmLDTKeNYPW0onV7v3XlHpkYbopOfmBP20rU38+jqHSlW9RBYYJR1+lZvdJjYRl8sjCY//Up/0tsAHHcBKUhnurTBMfuvPqxX9RwpdSFb3WCCtlGDYWady6ojjrWbt/bjX9KcHYgAOKWCOfsZDrx2D29tg7mAcCOfYiYxIrnEUmGuWBwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoP0hjCP0BXRxcakIqO2PxjAL5KyyHdu+ONe2C6Zsy8=;
 b=CKUNDiNeA5fH4s1YaXGC+nSzSjVrBTv5uVsxttUuBO8z4eltM14XfG7uC1F20O3wEjSQgCBRA8+E3jgrcfK2u9kbyGpXfoaFl9k3UZV1Gn6YLj0KorvYsIGKcEeBR8dK/sAT9ObavS2K2LFL822yToCBCqC/HLy/SsA6z0vohKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 IA4PR01MB9402.prod.exchangelabs.com (2603:10b6:208:55b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.11; Tue, 14 Oct 2025 02:32:38 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 02:32:37 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: patches@amperecomputing.com,
	cl@linux.com,
	Shubhang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski@linaro.org,
	geert+renesas@glider.be,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] arm64: defconfig: Remove the redundent SCHED_MC/SCHED_SMT
Date: Tue, 14 Oct 2025 10:31:58 +0800
Message-Id: <20251014023158.500932-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:820:d::17) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|IA4PR01MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 478644a9-fb71-40da-aabc-08de0ac9f068
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oIBrlpxQ36CA7fkF4BTSd5bVlELVDC6T1C42yYVhu+e0zEmGb+o5wtZGv4VP?=
 =?us-ascii?Q?TQvbW5CwXPUJSfpFWMr+R+/966vBMQI6H0imIzQZurMk1gpeVYyzZ4Bor+GQ?=
 =?us-ascii?Q?oUJ1FJQwEBKYCkYYoCDmpXRhUYIUPSCHFkZwhWt/1iQHoBYM1v0S0wUhc5QW?=
 =?us-ascii?Q?rbXdCEAuI7SRCWJlXAYmWsIN+K5kBT80lPdb/cCYzmn19mspJtyxMqGA5A1R?=
 =?us-ascii?Q?1YeLs8KRxNWOKeN5h92vTriHovgkhRWMdsB0yJrrLs+PzDKjNHJQpEWyMZtc?=
 =?us-ascii?Q?5OVX8AOSMSg7w1uliLlj1qBMC4K+8coMvcSsN4opNogcwBL2csziOmQAY90+?=
 =?us-ascii?Q?fdHyTOxsHPOyerElOJvQBa2KPqgIDFn2rHMQLYAjDqjYx8jAxKNBdhS7EvkB?=
 =?us-ascii?Q?w9LAAvUrm6Oco3W4df04pAM1j6PDtx3f3E8fjTfSzZf7ep2ImFHV6R2idnGZ?=
 =?us-ascii?Q?/m754fm9v2esWPvFptPvHLbxi7BdapxB+c1ghWpGCdeuUwaa0P3Ka5AWNGqC?=
 =?us-ascii?Q?OX4O3ynT0ujo63lFXkLIbyp98rFeUYIRITKx5BuPVxEbpcDbI1dlkDjnEyRK?=
 =?us-ascii?Q?WAuNH+r6WjS7T511gwKFkH7lEeLq0LvWJ3/gDWkOeeMl52AZJk1LeV3kutBS?=
 =?us-ascii?Q?riKyfrd3uzFaFj7WTdCzuu7vQYcLz/ouoXhgbTReQJKS6OuyQtgwfHfiJgs9?=
 =?us-ascii?Q?/bcXOvMJtkZtKZoyCLiqbXb94PmyrEkZAKIovhUI7pi/ZKssdcpAqhejxpw0?=
 =?us-ascii?Q?o7qT/mFxKsfA9vkPIAQThGnbIsj3CV88qnwlPtTQKV6ACA4713kp118SeelX?=
 =?us-ascii?Q?gmZRjkya4XGfrKFqZFUhqnDv7Ia4ul9QdGUt/PgAerORMu7s+052GO6OhgyT?=
 =?us-ascii?Q?67xSsdYEsFF+I8fWSlMQ6bXcFDzBOiK8kcgyliOD1vFCtOgKP8VGgQeXL8By?=
 =?us-ascii?Q?4Uo+SY+dSSgeAH7m6WaYVkAHN5HFA3a8iIxzUaSGkPRO9UEZIntaEm4w9/P1?=
 =?us-ascii?Q?AVtkvMH5D+LVoLf25mknzp0UvtswGuGO9o5hVOqf426jTX8F385evjcRIJY4?=
 =?us-ascii?Q?lh11KA9JyOrIOJSBJ0mWXgTA/Hde5XGOBDuGpydNDYLRSn5628TDudfoEuUM?=
 =?us-ascii?Q?McskQO275R7XnfsAvqBetVWvY9XZZIWc2Ud/U7duzgbMiq6uSRYreTxhfp3w?=
 =?us-ascii?Q?GzMzlTpeiDjEvWwcREkqfJDIPq9BHfpyXSNt7U45+DUboeXpwitzLairHV2A?=
 =?us-ascii?Q?OSBaqzC88mFeJN707W4oQa5kndMq9tBZzecIBLBlZ66/XJncbS/tVropf7sr?=
 =?us-ascii?Q?LwQELyrP+GIm9OVbL2zft+rMBAPgtLSWqPFzGEphvXGgNInmAa00JK8+PGcf?=
 =?us-ascii?Q?5wqrEocZbxxwjn4KRWlVo9x9qu5VTTjM35JgDvyuZKuP4LwfiJJCyaWVpzW1?=
 =?us-ascii?Q?0UxWqZCas7rgo2b6hUT4ofRVkUdM80X2hc8k4YohUd88A4OU7HL6Hymsl1bT?=
 =?us-ascii?Q?q2OPbP6C0PIvkIDGOkCqVBQdB4LIYsePrBke?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EwVfRtejwdKYKSSyEHyerfLKA3pesWFCt2HB+0FHQU8l5+4A+tmXvGibgmiF?=
 =?us-ascii?Q?RWlINFss6genP+LY7TmWfGMs6ygytla34Ii+esWnvU6w8azFViEVcaEb5A1U?=
 =?us-ascii?Q?frxRZ6Ag51lSWDzeHXu030MoHF0920OOMZXW5TYoLRlUCjHon0BaL7k4fbGe?=
 =?us-ascii?Q?d0wzDj51q9HP/2hp47ASjRoJRZ4ZmuS1PLszfLwHes50jsXQxnIk5JuQiZ8J?=
 =?us-ascii?Q?H5wbmO4/k2zIeuIGtAS825Lo5a6rhsdTXKH/MrIJt5jj7vITGzzLk0jzUq7X?=
 =?us-ascii?Q?YeiSXwFrSF/M+hIgYrwUsphJiiIIGrFJTp/UBqj9FSXEcPUon7Y3+aMqGV3Q?=
 =?us-ascii?Q?ff257at6z6F2sjQso5Lh3ztq+StsseOMQsjUc7UZzqIhgxxnjGTNqjOX38QW?=
 =?us-ascii?Q?1vkjcTmZOnA/MjJEst52MPY1hTYWINoXomPQ2I1P395sAju9eqstY+YWza8o?=
 =?us-ascii?Q?cwXCigE5HbSnaLJzqmnoZBaT5+5yeY4SIXbLe4BIhyFBJR1QdKW6ZrGF2g09?=
 =?us-ascii?Q?i3amtVZOFdjbmWke08mA2xwpgQ6U9JSLQP7vO1/R6btMA42qXpxzJ41tVi4p?=
 =?us-ascii?Q?AwQNIIZYgqe8sEy5RvTyBxQPs//jrb9GFcpP7kFJJig67r6/wM/Z5uy/l7j5?=
 =?us-ascii?Q?4r7uoXs9OK6uxcMPJXkc5vsinousuDW6hbU666FChHep4OUHMvWf63QPbaau?=
 =?us-ascii?Q?WGy3YZfbYMiJz6A4TkuxxCYf/qlzbX4KWppxC9kbYTHj02dcN5Fi42G9GSy/?=
 =?us-ascii?Q?5ljVMd3bl6woLRtjXSvPvS6Y96OSPlPA+voCTxhGkwd0GWI5c1XTURV6e+B1?=
 =?us-ascii?Q?v/oyEc8WiC8QCAwhb45f0U+RLrSiTqQTWlSzJaF5TYPqpqN7rSVofbq1T1rI?=
 =?us-ascii?Q?4DHadcb9hyrICvt/WEW0FHf2N+owMtnDcOuz8ru+zX3ahNKf/qcB6rRqb5tP?=
 =?us-ascii?Q?ZYv9FK1JzkGze+1hIcWhnX76Oktj12UNM7l17bf11YsX4fDMXQGW2aSOwQ7W?=
 =?us-ascii?Q?K9DZiI2FD1JbaPZY0ZzhmiNnvY175HXBZrT1zb1VVZXbNjOm1gFy0n1MTLjn?=
 =?us-ascii?Q?N/JxGs9rxEJJdQw0pvG1MGIXGKsRSE5gpPvULnKGg7UO+xb5POXC5SvHadIe?=
 =?us-ascii?Q?1g+LP5LJGiUdeGg/Fvj/20PahFDzZE0Lj0POt1FXIyOTQ0flvKQ61YL+YqmV?=
 =?us-ascii?Q?IS/hl7SDGMDaJjo0IdEn/rpNQ+0Ihx1PxOI6nTVy5LRErVtU60noDEtK2FSY?=
 =?us-ascii?Q?/hqzOwDadvf8yUKSpr0XZbFLWUPOr9MCIYuOxCN0KmDjdb1HWwrxIp4m5cKm?=
 =?us-ascii?Q?PKjdZK3A+hDD72jSgFtWE2YlKBSsliBxHdIAFvzzG1SNmgvkefMh8Rn2lsGD?=
 =?us-ascii?Q?dUgOWK/yYRCgrRRKFsBS7lN7uSQbWsE/4SD36a3AMN4J3X1sNYHiY5OF+Mvd?=
 =?us-ascii?Q?8J+neiJPb6JSt+mHfL/8xdEcqJV8Cu+9bJFS+Mc5fOpb4Tet2bqojMULRwWH?=
 =?us-ascii?Q?IURo6nJpjcc7EUEJjXr7/0QdvEIkiJVXWsp0z8+duSEFRk6AK+/ae64eWlsd?=
 =?us-ascii?Q?hYo+XLnTronEB7rb4BdbYWoFillyRg1NpRgpAS0sjC9B64GtvuaR8EIwwp7x?=
 =?us-ascii?Q?FnZtI44p02/3EIQDLsZ7OOg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478644a9-fb71-40da-aabc-08de0ac9f068
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 02:32:37.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbYCB6uEGn45g9R00nKn0aH8cw9KcsNJTgGQe3aDjgAsmf0qRyzpB119rjP/9zqWvpzvmPTYr6ZfNJJlmd797MBVHDKFfSgTVJ3NkaqS3EzbXLhn8o7Bh+eB7dzL/M2x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR01MB9402

The patch "7bd291abe2d sched: Unify the SCHED_{SMT,CLUSTER,MC} Kconfig"
has enabled the SCHED_MC/SCHED_SMT by default for arm64.

So remove the redundent code in defconfig.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/configs/defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..f089ec615b90 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,8 +82,6 @@ CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VISCONTI=y
 CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZYNQMP=y
-CONFIG_SCHED_MC=y
-CONFIG_SCHED_SMT=y
 CONFIG_NUMA=y
 CONFIG_XEN=y
 CONFIG_COMPAT=y
-- 
2.40.1


