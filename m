Return-Path: <linux-kernel+bounces-811201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9DB525CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946F87B42D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE420FA9C;
	Thu, 11 Sep 2025 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Pvy140le"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CA1E1E0B;
	Thu, 11 Sep 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554671; cv=fail; b=h8njxLV1b3uqYqeeQWGeFnrlW3lNox5EZQD0zgIKEevKDEYbfGdb6KsP1TDlN643ubr89Nm/nyaG4JMBZy0KjqIKN12/xzpzpnSLljevuj6wGq3OKXwgQjEXptTMi+9EgaNhnDAYxgAyGaKyesTc1Sj0Fbeam1Ybeec/W8NrmQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554671; c=relaxed/simple;
	bh=R+2Ova91hHiUYK69wEQ7D4hzKaclCL8QZaVH9JNksIo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tBvJ5J0IWLsdJETygrjwUwZFpT+S1QXjlvE4AyIjxJdwEdHkPiiVs8xjsSJVWJcEL+JEFaL1Ad6AhvePXHZpo+4hKy0Cz8ZrmxT3q0sm7rfVfEwiDyrLLKeK5h7vJB4OVFMOUngfZf5HUfAOSWh5LhDrL/GCojaVJzw10HgTMBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Pvy140le; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDu2mqlyOA0vGCpkdOAvjTiRaIMeLmUHUFpAVXOQL5TYTva/qzzsS6Za6L3d36n6VRhCMGInq/btO7tksaZFffkz9kA4GdP79SCXO81ByGNjhQVBG0U9TXgHM5uXPlPe1skh8bv5ZY+0BwJ01dTSUk+2nowHDiNJJNgQK9IFIj1POAy1YDTmJecCCV05QY2GG8vo/1SOV8RNfnco8voOBD29FnGRnItEGrZ2oUVAf3ww5tuNqbl6XLccnVadKdprDgRRrwBvn4eIvAHl16iwbx/fJa5FEwQJ7kCm+NpB4+CPtHYZL2cZm4N243iodzI4OSShOYcVqScxus3uy6IXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX4VGhCVEuuuLe99QlDdpdP72Fdk1cy1jU1svl2rT1Y=;
 b=R/w70MzALn7C7y1EQ85LKL0h5wtpy9AMOeeIJEDSmG1tHpQIJk4lyxO9d83Th8sKhkyZcWnl1KpAWzecOTDmXIRzMsEoUaIDtEWQ38B8sXeEg9gBuZR1hLyQZ6Nn1vCill6d68/HOiUowBmgOFW2DjdLE0iMkSYrTMZAGI8FtkX2/+mVj1+T0x0YVF6WZ6PZKrRXF1ee3Fos2jme5y1iOikTdQ8yswc5sK35xLzcDHNgAdgZ+c2C5GlJbyU4Cs2XT4BwZi9HgNZ/l+JPdIpFcohq1IsgyNyzNHFP9lQSdMB+3YrErdQfJxa5j2qa+KVaTT1IEAfoVUYJIssV+8dRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX4VGhCVEuuuLe99QlDdpdP72Fdk1cy1jU1svl2rT1Y=;
 b=Pvy140leZBECqCiVKPZzZLIMN87KDnSBnc/D7V4EKZ3Sx6raeBCkf45lDZDErDDtTzi9d/7YmG7TvjRHX+wkrJOwtULWKG22G9NCYJqCFeqjLmaaL6stvTheTHRaZGO7xXPPGeA9DylLVR7TzI+NZXiG3Fg5rkzwE9x47xrUmV2CaKw6V/EarDHugJzLGNzO7tlCr+7MVagXvAK4PuNfGpO5KymJqSNIayL8FKHqOtFsury1brHyK2CGWn7GXAzjjIhOio5lnayE1m0Ftuex2JZM6FCFD89PxjybrIolezdaHJ8SQbOaykcTe+LmycKViDWSc/hOEpbrgfNoxfW8Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by SA1PR03MB8083.namprd03.prod.outlook.com (2603:10b6:806:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 01:37:48 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:37:48 +0000
From: yankei.fong@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 1/4] arm64: dts: socfpga: n5x: Add 4-bit SPI bus width
Date: Thu, 11 Sep 2025 09:37:23 +0800
Message-Id: <379e68a1f2ef4f691507e66af21557c9375e897d.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|SA1PR03MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: be2967ee-9472-4eb0-8b89-08ddf0d3d00c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4VlXSbsPgTvLsiQA5M1oAG5upGWY4t9aJSlgXW9nS3sslTnIrsUWZ9uRDnsZ?=
 =?us-ascii?Q?hWpoGJ6j0la74W/jM6ULBEgmdC5ZdGI+mDF4YDLu2hEpb0nxGLxiieBoECGa?=
 =?us-ascii?Q?fhRQR9P6pAlMgB6x3F1pqGTwfW76/cwHXiToAAKH7jWi7V9dG8ILUe6K7yug?=
 =?us-ascii?Q?4GEqFyaksCrfP1E9C+itMlnUdyJo+q+c9j5ON2jTOkRuFyG5HlHZrEXQ9uEi?=
 =?us-ascii?Q?x7LlLlnWu2JzwILVD5hIm3y0YEL5ReCdSiuh2TX+772/yQMZjXJkA7HB+xyK?=
 =?us-ascii?Q?pqR8uNGPY5TXGwzlzR4Tr4rmJPrlqoVcFkVpvIGYxjG7tPyyyKp8x+5iLSKh?=
 =?us-ascii?Q?wP1xuPwpDlqss61pkP27F+Xn5C6gsmMHwM9Tkbla0eKWrfG3/C45d+9ZVle7?=
 =?us-ascii?Q?LA01jn2ff9SMg5DB/qGcDJNChR98/p7dzTXAtQxdlMln93ZocL+uslzYdftu?=
 =?us-ascii?Q?AsU1t10LvaOadKGcEJaHaGdkYebUQnuN27qoes3ZUHZbrUCKnuu8MhywQOnK?=
 =?us-ascii?Q?2tAR8LzQGdGr+vXOE1duGpe0/WyYnjXtmD3bHo3+cVX/HhlhdOaluGSMYJwC?=
 =?us-ascii?Q?rHUF9mbi5AglB4/NfiMb6Bbn8qtGoTF8OsutB47N1/w01X3txN+UimFCDRJo?=
 =?us-ascii?Q?hIxH45F2OVJ2lnzubJQvyl7bAg3YPn6YOc42OosHT35vsisWriAh9M31MRX/?=
 =?us-ascii?Q?D4cLQUJMCRKRorGZTzRvdq9JCrvWNCuQEblcR8MjLMu4QnZNCbKrJozHaH6W?=
 =?us-ascii?Q?OitXfmII6YzIRTyCrtLcswjPQfSNHUYeT2zfeveDPHQdSc30VFm8LtzEV4MI?=
 =?us-ascii?Q?1dLQPytfrQnLCPeAc9Pglv6CSSkkZ308VrbXkAPEVTQTXlkOGpIqL8+gnUag?=
 =?us-ascii?Q?gSm3jmOSk0o7oUv5BVc0ZYPSPW8VhrDhSjRScnqdGKH6ugNhszbZdBsZWEFA?=
 =?us-ascii?Q?vzxiusTDoyE4zNGE7qPb/7E6xw1T/Yf7HXyWpwQWaAkTuX0jiLcNtXEug3fW?=
 =?us-ascii?Q?5BrLMPP2HZ5zH6oz0ArWQjz5GPTXqivhiBNiYOB27qwgFX1D0jh8r1TDEoNS?=
 =?us-ascii?Q?BD9shpNBlW1F/oHc/jOQwwjpLcL8g9FNYuBRH4C2OBU/Od/ivbzyeVi0g1ao?=
 =?us-ascii?Q?8ijOisetUIuAx3U+LN/kGfBLzJ7XG7criwPxD+8NeVlkk2Qn3lKCFap9GpsK?=
 =?us-ascii?Q?XZt9EJdqhe0SFa+82UCOhoTuwWiacaxjeKxjnde3IC5LHIDU0sQfdRNMLD83?=
 =?us-ascii?Q?G8lP1r+NTqQuuaMZOwOKQ4iVHiGR8bmTgnE07jZ1dhezvJgoHgv9UwkFemSp?=
 =?us-ascii?Q?cBByqDbgEdGiRiJz+OSW9Rx0qWuZdP7D+w2nDGbrufTL7KgPNtI49Pb8yrnT?=
 =?us-ascii?Q?V/eNhZUJ7oQI9ZUrUL/DyxGqKQD4E8KerzknAQVc8voUBmk/WStZsUys/BD1?=
 =?us-ascii?Q?joevMRrgMmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ydAaOYWrNNk2eTjMRw2TMOpl2kagfH4jgjCQSmGTUs8eBCz3Mh2OSvIIZIx?=
 =?us-ascii?Q?Nx4fD3kGMGTwij+4d8hIosYDSKRoqaKa4j88H0UWaKcCWizfnrqKEsJRnDLE?=
 =?us-ascii?Q?MbwdPei1fIl90V2OiQF/LivK8l+H0vYerlqjbuCQdevY8uT3p+m2hG+9eG54?=
 =?us-ascii?Q?MzMvmQAbkaUO+Ss6QC5PZntMz2WkLpk8PW74CUrttKNvgmM20iC1JkrlaGIa?=
 =?us-ascii?Q?VOodjDIdolW4dmTZQDMGBp/egBCaGS9wW4u5DzjAasJcek1LPOUvR0RdZHiq?=
 =?us-ascii?Q?osIiWpZGHKb+Mw7mRX/X8YRKOl3UJwqCTM0azviFgLQvVFxehoNsQBHgjZVW?=
 =?us-ascii?Q?X2zzDJ+6pP9t6URGOEl9OX2jtCItFdAOelNFLHpTEzO8+p3ImLgSUzx8wILt?=
 =?us-ascii?Q?R2hKk0Ngy/mMvttWyNXdzMaeUuW/EgPIAXjI4EKbmmrcdYeO/L40ornMWy+a?=
 =?us-ascii?Q?08C/2T+rrAdt2YYPvEE05qyNuWoPeE1KnPsP+ZgOUlzoNfdB7EBcHPwK9KJR?=
 =?us-ascii?Q?3keanz9zm5Y5HyOuekLJzfXe46ZXWLbNLM9rHKaAyUU7289T6atlty/DhUZM?=
 =?us-ascii?Q?Z7RQvm42tHzHrSpx1p4nsr2KFOJxauViIjJhzS0X7rW/y3MkjSfpc9fy+RnL?=
 =?us-ascii?Q?5P7rDpLts07A0CIluzS5G5wZh1/99bRgiHNNRLj5JaRNOY6hsF0LTzL3FcOA?=
 =?us-ascii?Q?37tyu/suZOFcKi5DpDOXla3fK4+6c3AvbN60L0NnpnUOop8YZZN5Uw7we+9u?=
 =?us-ascii?Q?flde2Z97XHD3yKZYv7RXZh6Hc2VgeaX/LNmadb9E9wsxKi/KxN+qnpeSLZWI?=
 =?us-ascii?Q?7Q9Jy46TYHA8Ij0gjkOUmSCCakdoojlOPbkdcQWcj2SxeVVzqdZxY1BJ+qvt?=
 =?us-ascii?Q?cR5yOObWbpS5+z1TSjAmjTr0g8eRfnFYdLB9+ja14HDo96ikSJYVxKTNlxyY?=
 =?us-ascii?Q?wWhkD8D9qBC6F61QfO1h07uPKIWM+3Fgi0gaNbTv5VEB/bAARY6v1hRbRnYD?=
 =?us-ascii?Q?mrd0S2jPcUxZzbqymjVF6VaTcv6w4NV3KCyDqp3nUuSSuWUMLjv0cMQA9oM9?=
 =?us-ascii?Q?fXBYgBca6xGh0hKfc36HLNqDfovnKRHcvOj6I9O2h62mWSTUd08Afmulnog5?=
 =?us-ascii?Q?oYNzTSZd+SbHSQlOueSYt4F39BdmoXxdUjbMtS+Xg7MWYWV83CUEcJyOD0RH?=
 =?us-ascii?Q?0WogmwKzJzzwIzmQrfgYsQtXQQdVnttzjS4hYXgHsM7IpK2H818Up+ez3mzz?=
 =?us-ascii?Q?ZKkl25hb2PniROM9ay0VajOVNyufiLsjfCJ/k+RSefJhIm506V0f+FoBF2Rn?=
 =?us-ascii?Q?FOS04n3nNS2K4dQNNWtfMpL0xoEct92Wko4YbyRQYLjY9XX7yKMyMjxkc+x7?=
 =?us-ascii?Q?+lCSHLV/Zn5boaaXu3WoQctEO5lIiMzaq8mDtcVI6L04wKySNkqHsDd2rzvr?=
 =?us-ascii?Q?r+R7hsECSdH+Tonyg13gT31Bdq4QW1is8R+tumkDBANMEHvIB3hUft0n+45s?=
 =?us-ascii?Q?1U+0KNxYfpbsH3gDSCb7bMB89329lvsmJKnwZUfP0Gp5jNDCiLUTyfkxELv0?=
 =?us-ascii?Q?OM4kEzyJBog6yv4h2038/btSASaTRZWBAm74yav2?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2967ee-9472-4eb0-8b89-08ddf0d3d00c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:37:48.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex6y5iIEv28SyF9XPP5fvrGrWpDYY7ESX4jwlE9WP6BilXBd4MYwkZUDQEEDo99t4390PDVwNTqSnWUZm2QtVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8083

From: "Fong, Yan Kei" <yan.kei.fong@altera.com>

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the n5x 
device tree. This update configures the SPI controller to use a 4-bit bus width
for both transmission and reception, potentially improving SPI throughput and
matching the hardware capabilities more closely.

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index 7952c7f47cc2..0034a4897220 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -93,6 +93,8 @@ flash@0 {
 		cdns,tsd2d-ns = <50>;
 		cdns,tchsh-ns = <4>;
 		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.25.1


