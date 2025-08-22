Return-Path: <linux-kernel+bounces-781351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992C1B31164
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A1F5C75DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E632EACE0;
	Fri, 22 Aug 2025 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y4PMjzvb"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013020.outbound.protection.outlook.com [40.107.44.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1D263F22;
	Fri, 22 Aug 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850462; cv=fail; b=JaPnjT0LBvH3KdqVjTg0yhrAd0R8eVEJDTYXuxMaODUS6So5AEhB/j18PxP2nUovHOxAIQwu8wPznwNjHdbVFuDFGQy2MbxI2+ukGVI811BdSu78USNwfb9o3F19VJlbP7jPwJRTdrLZnAYu5y8QGelzW0XrAzkYK/gYri7U2/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850462; c=relaxed/simple;
	bh=TW1A64gTgvlPQ6DrbbO0vagOmDd7tVu9T2knfPIPhbI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oAQNFDrOkPv+bPRMShFH4xcUEiLJ3lClU7uoseS+eNds3HoVPtojctwoOOJgCP0ElJXvqrWm3Epai7Bl1QLAba+clg/2JTTt9KCLfkxpylNEu7aDIICuLXy+LOMxRGYOXVaIABUs8JmgG3naC2vl0v8itxE9KfKDy02fnX9WD0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y4PMjzvb; arc=fail smtp.client-ip=40.107.44.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3lY36i9nLwZSNkmuUINFYnwlnMIw/hv2B93r/QM/ppHTvrPF9SevsRhdCaeOGLdduRjaaZmcY2XnvpmUK/d783xP7dJqpLeGHsM0NoZxycLo+zzNevXfq6vvY+Hrfnap6ptulI6Ie/cPaH8Kv11KE247+JcpRMu+zbTCIzXWCOb2Hat5mo5qe7eKXjltnP+xMt7Nh32hxQgq1XFeFqWZQ21CA5FrNdkQaGT/f4LU5jJGq/TpZEoXTI2ubiX6Q/5zHHFVz8FKPvl7qPxFUvCIDoXi98k7/WfpW6Ibf/EmwGkefSNbLTMz/koPAdcnn5QOVF1fAMHxpRQVuvbm/RorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lumVAGcG9sW+mwCgoVcZgP7l7okDruijeI2TfOE6tg=;
 b=gzFupd2LqHZ3UAm7ku4cR/JRozRX0XCz2frqApYm4Qliu+yn6f0xzr1U49Bla88W4PxXirUwOtbT1qLSGlghGajtocPkPA+51hFnkNBZ0JT0Jfv2wTHqyR62DZovuOwQIEq/G+cfkZO2+2zfZqG1+ITlqEyv4Q1gdL/8OVIuQqKFDvWVahOl3FALz9cgUzAZnXixGGC57dovkMnphEcLlcbGkRTXfefKWyodpNbmhcm0fA6mWPEYk8/if8qwKSzBgmA1YJRwBQUesi4g9eRO0r0Y+G1LSy+rxt7pqzjyYR8rLNvY4KzFcxijf4QTKB2UrPPJPLuFa2cBlnIoiAya+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lumVAGcG9sW+mwCgoVcZgP7l7okDruijeI2TfOE6tg=;
 b=Y4PMjzvbJZBn/TNQeBJ+TQykDB4cb3j142BL07qoIsrlaHg4TLEIVUC4BD5Pu/5JpT3p2DwaJz7ifIXwxp5tzT7C/kNzz2mqzXHRYGAhMT0Q1DsAldyNvvnN7b+4JWp0s4XqgRdOB4Z3KKUpALFpKcGOamBNOzj+e18jjJypuwsY8JlWoHgTeNFOMYhFu9dCM5zxUo/F6n2Z9MmzVA0UDxn6uWaZYHyI3lHDnyDdgQtREpzmiTE7hvnA+GzxdZcExPKXdlkVGAcZoD82zMf1qSx3EISHp42C2suTwvEpbQpnqCQWsxQWrpf6fW6iwzi10eHjdttvhd9tncqNSUNSDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYUPR06MB6175.apcprd06.prod.outlook.com (2603:1096:400:35f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 08:14:13 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 08:14:13 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] usb: phy: twl6030: Fix incorrect type for ret
Date: Fri, 22 Aug 2025 16:14:03 +0800
Message-Id: <20250822081403.12932-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0107.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::23) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYUPR06MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca2220e-e78a-4b1d-666a-08dde153e12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7VWNumj9ghY5/DEnAPZe0pf0L/N5oX8xIF17JtZsqPMc1js5sAo2ZqA/royn?=
 =?us-ascii?Q?/RCsATNl2N8OpmfHsbEaDGbRc8228zpB5vSV/LsbyK/koOTSwXFrQVXq3Xii?=
 =?us-ascii?Q?qfDJUQm2m4XtHMlskUs7eGcF4ngvSvoIisqCGXz+SnDr40wpYvSC1MPjyB1n?=
 =?us-ascii?Q?OjSGiCx93GVdnFnyvb+a+wVWgrVNulY9JHpEZ3dU0i5c8uMMdiHghZvhucZc?=
 =?us-ascii?Q?auBQgQYE+6WqKMP78H9Y8WJrSXE9Yyrj/dolDy2yGrFRN+aZEeoVh1BZPNlm?=
 =?us-ascii?Q?uEhM3j2fojcfZQ/DFYGzmNvsHq7aXrxSJ212OA9m7o+raJHUoPODjlR9iaX4?=
 =?us-ascii?Q?Qki1ZJmLYNxQ20TVP4cP3hRXzKjK5t315TQ5UPYAAnVRqg143vfeZWwJgqOv?=
 =?us-ascii?Q?LFYRDJdXKuwRQbf/qSolAtfHrKxKy5ol93bQRcYgLZfmoINGGQOSQfIHOXXf?=
 =?us-ascii?Q?9oD+bD+17PuK1oP2DIF7FmKnU3Nbtt8YV8J02G0pTZhr1svAF8O9Hi8p+vb8?=
 =?us-ascii?Q?9lGDznmbTJDQUtDWsJgLTcYbXbW0ayiZj/RYkdnD2Wyhsn9mkGLaZOU3pso+?=
 =?us-ascii?Q?R8SzJZw8rbrmdIMo2V/M2LLvP+I6BG5Lj1o1aq68Rpm6g8TB0BwpLQznnfdo?=
 =?us-ascii?Q?bKDHVpn0iihCdhLeZDDquJDiLTPQ9R+4GkXaOc26QMT0dgiB8OX2x6rkWRUt?=
 =?us-ascii?Q?wN+NgEB27+eqVKFrpdN9uJjTKlKByvKLUrcWpidvbujauDmi9Zj12uqxcJHn?=
 =?us-ascii?Q?sHINSWzllF/9SuIQb7DO9Sbdw4KSbflsNW+NIuVEv0PEuqgI87fOjMTEY4Aq?=
 =?us-ascii?Q?K8nc8AMYaPLBc/jjDmAHTl6OBl2F2GiYFnuYn1ej70lR0QAiXd3/eeUAs8QH?=
 =?us-ascii?Q?tKMeJ76vitkyOcTXigaKSRjAmpcTtuhcH/eQGQqD+0iAG0N9abM4ygEgGfyb?=
 =?us-ascii?Q?2bOUj2ko48NYcDnJzrbdcWbpShWq3wKbDok1e4P4T5jvuri6exibqozkpeqs?=
 =?us-ascii?Q?ojYPxbj4I9TxmKU50MR+gxlBR+v9AGZ1kbKyB00uPNINvyYhrwdiR2Rr2cp3?=
 =?us-ascii?Q?RTML3T+DdD+QnI83RZPY/Ok30p+E8AtOli/imPNWSP+VeqQ/IvnXFP0/Efq3?=
 =?us-ascii?Q?vueubZ8BrlO0onLboG1bl6NyPFETKjLoVa9hPioDypoqifmij5FervEupYmh?=
 =?us-ascii?Q?kflHPR6y12yErnybJB9qZQc38Ar4Hl0kwMOuwnWvHWGsui454+Tq1rEQjQFf?=
 =?us-ascii?Q?wx/Z8ln1a0/ue0ve6iYDbg7Kw2nVELqrYIdD+ryvAnVDyPGc/jD45ROyl84T?=
 =?us-ascii?Q?+rjVLmfIMP+EIkau3570YAaddzu4NdXADdu9LhwLclyx2LEhR2qdKRb2Dnl7?=
 =?us-ascii?Q?6A5lG+dzQASzremf9xlthQVRWh9lKfebgGGlobqyS+XM63Oj8pEfqVudX3+T?=
 =?us-ascii?Q?Es/9gpvtz+qRk5Hr46jGl7cMJrjF1VhDPT/JvYqEwTvhEDYfnur+MQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzFjRmYNBSKZHOuKJ9P/ByAaqL8ibw47heeKDPWNPEw5XPnPdiKViVw4HT92?=
 =?us-ascii?Q?4NDgrI7mcLx++yuZ/kacEKyMMYo0aQQACyiTKNZAkHsWA2XjZ2pjx12bqHnv?=
 =?us-ascii?Q?Sv3j8U0LsXmCbhAEe+hUt1HYrpAhN2uJNupgQEah+1hWQfkGhB+gF5TSIz1N?=
 =?us-ascii?Q?oynWmRA/GoK0N40auBEAr3otOdlHBxM1n9qJ03brBrqTJfUaTJGflYR6Iq0a?=
 =?us-ascii?Q?EuKOoNi1dt5XBH7WKeEZ5DfKTbJyvp/5WPeEG479ylkOaEPTRdWXlvTMYWxN?=
 =?us-ascii?Q?mIKZx0zmxd0ps47LW9p8DbH2WPBpASgL6N7vR69/1j74sw6wW3OIV0VmJey4?=
 =?us-ascii?Q?DHk0ow1FEAbydF9YEOKErIDODuI0SaI27MyvZ+ZN65gs3/THSULJWW24OXan?=
 =?us-ascii?Q?fGF09v3y46KdYnCgVssCFhEDqArwoirIcNXb7Xhr487Xpa3J+NlajfKc0Rss?=
 =?us-ascii?Q?9UO+G8hdL1lz+kgR2w9afWAbWImvmD2N9Rf/NdmK5S7SEs+IfKj0kLN9SL8H?=
 =?us-ascii?Q?Bn7js095N+wIaFLHnDRVuJivRj1Hgyr0XWZ1cNuu7R1EVaeniZVXfIxELfzA?=
 =?us-ascii?Q?OcncGdnOgge4iqkJbvY+h8WumJxSE3I83PjPEhq190vS7LYQVFcfdIQb9QCZ?=
 =?us-ascii?Q?5PvglM4SPiPzYGSwpq8Z9lFAeiJEHLeOWUif2Ysbu6VnWdqmtMjdVN6Olww8?=
 =?us-ascii?Q?1iqoErbsHbci+IFbK513FELgayZvc9gHAWi2sqrTuP4c/Dsyrnpwbb0oFUCK?=
 =?us-ascii?Q?rG+0K9uLEtoGq62UXvRQdZkrwt43dJQduN9uyyQPPJNf6cSvtysl99ksfXOn?=
 =?us-ascii?Q?vFIr5/o9GY6qOaR4RghrDlmGUelO782k2g22TGXr8TDSkHs2qFEE80l/lrew?=
 =?us-ascii?Q?Lwj+k+hovl/AyF8miJe1pVbuCjU0q0DzVjJUbJTn6AOF8Cwy0vSCYFvjSNuk?=
 =?us-ascii?Q?4y1IwBMW6HJUPvBm4JrH5csLhPM/vDy+1sNfD/d4eFzwQ4HEh5b31nV/DUQ/?=
 =?us-ascii?Q?kDf7hM4Ciehx1jU6OW1ppz9e4KQGXZOP1ZiWMWe/CqyPajAAr0FxZD6nrHOE?=
 =?us-ascii?Q?Q7nciATT/kkoehqzV/O55kob/1nIkvcD2orsVyIdB1F6rV1v45j2917A8kAG?=
 =?us-ascii?Q?n45vAfqnbZDfdbZimIL/Uj5IMdFkWdIGDCl3LkIWUICR6A1FicghHHH8IDKx?=
 =?us-ascii?Q?8vKlU39RiJdJ7RCTUwQPA1vTX9GUbji5dTXC70eod0bnSej1KtSl71kJ8Jpv?=
 =?us-ascii?Q?EF4MRvB+sD8lqkY1BkeoN+HiCaoVrFcCXh+dQxhA1TxGuujCnLF5V0WjLzwa?=
 =?us-ascii?Q?DjXJrncnSRMdoz/BGkTEq59ikvOdAvVroxhrHkSJL148xTJnD+0XAqcPKyIJ?=
 =?us-ascii?Q?5ExwKRoCXTJBIjIdUW0pKAgvua3ltHnxHugXfOyv6ucqJVtxfIqF7Cei2RmR?=
 =?us-ascii?Q?4KmbZJR6vqFKXr3j/p5HI80og3wnzjDfi45bHFzK8ZUcHidi+bm297MT9L+y?=
 =?us-ascii?Q?ZtYHy//dcIFzJuMSgM62qjvy0LzRKrRTditckd/8s62IFfjBvYVEZ+ZJESVN?=
 =?us-ascii?Q?Pi0Hzw+epF1c3jZbbZJoKF8kWcVApiq+z0Gfft8x?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca2220e-e78a-4b1d-666a-08dde153e12c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:14:13.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5Kf/SeuFFgbJtfR1UUdqWd+FQMbNfE55LcBd0DBjC8QKkKKUfQaBr+UWC4D75jLYKbvOatDQaY9W26olyh32Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6175

In the twl6030_usb_probe(), the variable ret is declared as
a u32 type. However, since ret may receive -ENODEV when accepting
the return value of omap_usb2_set_comparator().Therefore, its type
should be changed to int.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/usb/phy/phy-twl6030-usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 49d79c1257f3..8c09db750bfd 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -328,9 +328,8 @@ static int twl6030_set_vbus(struct phy_companion *comparator, bool enabled)
 
 static int twl6030_usb_probe(struct platform_device *pdev)
 {
-	u32 ret;
 	struct twl6030_usb	*twl;
-	int			status, err;
+	int			status, err, ret;
 	struct device_node	*np = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
 
-- 
2.34.1


