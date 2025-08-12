Return-Path: <linux-kernel+bounces-764459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EFB22341
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F8216792E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3BF1A9F84;
	Tue, 12 Aug 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ATL+GcYL"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012026.outbound.protection.outlook.com [52.101.126.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F32E54AA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991089; cv=fail; b=DAXYq9rfK+q8oSLYpYdLaq4tk9vYZY6as98PdoY4Iuhmi5QrEkA31xDuhVZhG2pCKNa3xRns3cd3VS9bSAC/eXHElWt5+hlqdcDuHXSFfDUQ8ikpql3jUT8YjEHhWXvY8fEeIGJ23P1FBOX7F1IXOzrEmJBxJSrC/ba8kr4jHpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991089; c=relaxed/simple;
	bh=2o4TGrIL4ORm8TMHzrtZlanWnDVDmEqzlAjbZ3mdPrw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EfmGImLM1/bQmcodhUfmvJon9ZCcS505I3/0oT1pmw+bHDN5/EJeJqRTnOCKwYtuR9JGC/MIEbhF7OO6xibmUdcAJzeyH3rCl0JMsfdECRP6BXZXgBwlJtJbCLcDjjUPXU1djM8yRzzN4vnCZqvsDO9OloehPdL1du0xoP8K904=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ATL+GcYL; arc=fail smtp.client-ip=52.101.126.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1kRAXBKdfK2FhYKfPOVzfurKzETaIxAKiKtqAy4/VTPzBN3XlzVYqDk4tEGpZsnwhlGkc0GtKoTvffznPUD+rt7TLY+Xe4KrPCGGbMEZ+z/rQ5sVGt6MbcZ1xDrgAgglyFbmF7+qC/b83PXIhktts4knAqHdhW1SKEcpKDJzyNHge9pKJzsUabfsKhh7lerZjta3vXD6wAr5X8CeD+LYbVzS7iwnzs1Sc2KCxhsb/OQU3SaGdlHsjz3tY2Wm99cr3jty7HzStfW7KzFK1tjJ7Op3p3N9dGLpkKJrVrE0yeIZGb1rfs/bAEzhtthsULeq76H8HjPDSrQUjFzHLKmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPK1lLXbgsyomvJhiFRoI3+Bl9YTOOVy1CoLvT3UrPQ=;
 b=pHruWC59+YNHhGfApT9oIY1yPLY7HpN51QwusZjkXI8a9225ljMwJ4Fgks6mIY81OvUmGmSeOFpCuHV1DqFMu+uTizroabm53mFpLt+UCOPYedt+A7n46wcBJTOki3EcKerdKiZZ1J81Hn9UAIhZx0I1HRF6wxGeqGxb68EADI3e7+mVtcKh3ytlfRvYMjskKO84HGkgs1Q/31Pi09W1HfbjcKm9TRERzfKspKfbyY4ePJX70kgPDgL2r4eizJGtEvg6kYCW4KC/TeZCR1isEqiZLD/skBpne9UdqQNJhAmHeud1yNz9GErS5rwe6ypwAInrzEg6N0tU8m68lXvUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPK1lLXbgsyomvJhiFRoI3+Bl9YTOOVy1CoLvT3UrPQ=;
 b=ATL+GcYL2uZ1gum4GD8MoGFUR9K8I9NNMadFxL7XVsAF7uMX6Q8LJNFZrOlrHBJk+PzI/2dZlh9VcRlqc3wywy1AyR0eBr9sYCpDaKpOLXRH1+jJKBzlfHnNS9QjQVEyd2iHFvS4zHgXmJkINMR6ToTRpcPZxTjKhEXJXNRzNkwUi5z1Epkw8sC/7S3U+wFYmYEiYNZ0QSuN5cqgQYoNxfMLPH98mrsBsjWWnCCEEKa1WIeFR0IlBt569BhyrdKZX5xLvd0JnAsUX349E0kbU+3dlf0CBiC5JERtde1RWVqYUdRZAZU6xuSVKgbqcWQc5n9GDGbZrgTWiNuJnI5+Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6790.apcprd06.prod.outlook.com (2603:1096:820:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 09:31:24 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 09:31:23 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] mfd: kempld: use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 12 Aug 2025 17:31:04 +0800
Message-Id: <20250812093104.103193-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::26) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR06MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: bce1a037-a6e7-451a-b07b-08ddd9830084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7yq5RlIIqMnKhWyvOdqVt+dU8ZMt4o6dePOCuuOAja2EtPCUwS12B/Uwmm5j?=
 =?us-ascii?Q?MgkSqyBQT3okgkhOUEkwJX1GZCMrR7QYjB3EUyQfU+k02q7kvCj/tjfTPUFG?=
 =?us-ascii?Q?1Csfgnfs2c9UUPTbru0RaiF/ocMH2k8xM19W3t6tUVUniJ6g+HXCxhaSpHkh?=
 =?us-ascii?Q?fIGfadSy+OHLWEbn2dquEA1i8dANsrzW/yjI67y4fZCvOY47M+lBJ4L0DKdM?=
 =?us-ascii?Q?NLqcIeUFLPHKwzlN8ejtz6GH/bwNmQEdv5r48KNuZbo/JA3u9gO8OC0jy/nR?=
 =?us-ascii?Q?nM95L1vVZOAOvsy1KQnE7ulmZtj6zY4tUCYdx5iko7nrNqtkPVN/C5s99l00?=
 =?us-ascii?Q?Gfhyx4AzCbQ6bwn0lB1Gdp64kooaiYTHcssej4FSlY5NVwSPuor1FBd7j8uj?=
 =?us-ascii?Q?8W0CV1/eFgUPuV4zt+5fFgHTkBzZgWMXlj+VK+fBdYNr20iKp0SqT4l4UPfO?=
 =?us-ascii?Q?R30evllO8EKrgTEPNMw2VbHkcmpRIi8E7JdD9/MUEYho7lo2X8FmAKQTZbNL?=
 =?us-ascii?Q?3a8zDctYgxyqQkK6NLWK/+/c04d+/1YcGPgABV3iWHtlLUYaSCRI+01RD8+o?=
 =?us-ascii?Q?uWVOftpeciOkV+HwEPQXdgnLoQjBbpLYxqAKoEbH+ziFnGofVFfHAil+oODP?=
 =?us-ascii?Q?Rf/4HucEANxAxBIuKazE5Sw2tJ4NDOYmtvU27q8RmbA2AIT9NNfa9pf+owh3?=
 =?us-ascii?Q?SABfrwFjvLgzDr4EHbMIonmNpCYU0i97100sxzDznrP3rMRJBF4Q0dbz3yAx?=
 =?us-ascii?Q?9V219rlEccfK9P51KNrcNTUwzDEw7aQ1pJtNX2SfQKRuHQ1Z5qU5/HQUAJZC?=
 =?us-ascii?Q?xg1Mvza8hdnbQiPyt8aV4T00crxUmqs/eTfKeHTN0KtndZlySOjPd7wB9mSD?=
 =?us-ascii?Q?vjap81ajDSji4fHMU6tuJn4WgIa1ftSKPygWqMIAZ4ZiXKW+pjZmJ/sJGBya?=
 =?us-ascii?Q?5vyyzwKZQb30TKBxBPjoVTWRNpNjT37oX4AtolRdUdFgKrLS2XcIJk0pR9ZW?=
 =?us-ascii?Q?2j8hb3kF/Iz6MYJLcs7WpMXWtqBf0Rn36k48yicMrazhWgfHJ7Fi6d4TeuiX?=
 =?us-ascii?Q?CJZ0bBzbn3NS8U28M+RGOstvnqVvVwjsd4lEfUaEjo+dhrAyNZY1crrFolEp?=
 =?us-ascii?Q?fwu6TBVwfcn93mdn+3TmVKMpmIlBvABtrhA4oSuIYW/vQ48yioRk6iqjYdpi?=
 =?us-ascii?Q?H90zHhEo6d0+tm3S5wSZKIEd9SLj+9jXkLs2s1qOF5+9AZ8hMXBxixU/lUbm?=
 =?us-ascii?Q?JY1rDkiw0kjVAgzGo1N487qzxx2fNVIFV1Y+X/XPUj4knPsny+lJQ/fc82Nf?=
 =?us-ascii?Q?yXPcT2YSALee8VnnuaOjItS+pHTPf9/lGmuwdXJxGhrV4i+0Ch9FrIG1b/zi?=
 =?us-ascii?Q?4Qt2q3mP08PH+qf1kPcITtqE7mQyKFeDz4/tZf2584Y0iqAqxXfjxwq33Vz1?=
 =?us-ascii?Q?+3tgyb995vo9yATmoHwNBdTkJYUki9Tyz0buuULBMeDinNKGinhiyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hR8cr2JFelH6dLW8wSxaOUXo0Hxigve4Ao3aR5SRoyxS6cHgVkbOMOrUfdq+?=
 =?us-ascii?Q?muuz3ey0IU8OsLs+UIh+PGDPCXDmsrtqRtN6xadd9COtb3oqyfDML+Yp7BZs?=
 =?us-ascii?Q?yHtPTUh0o2zX3GOcRWF0SnYo444lt1qBp1ZtQ/F8DK7Fza87C0RXIbX2Uoud?=
 =?us-ascii?Q?UfiP4Aq7IrYeiLoOBBYC0xoA4bxKZRsrEp1X1SXQLXAmOZLDG+oPgeYsa7BV?=
 =?us-ascii?Q?LN/QrgLp5G76ec2dYraX8Hgw4O70JVnneE2AhMHLnKN3jPGopYocnKKC7hDa?=
 =?us-ascii?Q?dPXvuULPKaBB9PZwWo8w9YBSGSu/4kCuABcu5StyPpWp+ILvswNeVz/+NBNT?=
 =?us-ascii?Q?m8mR0Fb8edWNq/UMnoD5S833hgSYtLYVHfiu01wBaNm+M5UGkAva926+tVFI?=
 =?us-ascii?Q?kFSKOGAJhUggEaR5oyQNwmJAeJCfV1TUVkhj/mfoEIP+666D6YpEwUufl0cv?=
 =?us-ascii?Q?i1B+aYzl3mAAa6NZN6fW2YbSTYo0rXoY34xkk4xYCFs5tyh5st9SjX9mo1k3?=
 =?us-ascii?Q?gKk8KnO3Y3Bwi9dp5NHFPGnNgvwlr+qxkjmo99hVCXdz0kR2nDgj/viPcyTk?=
 =?us-ascii?Q?fvQ5XbBmM60ErCYcsx06HazwM7OVVGB50vPIY2+bm0GpZWz8wiicBtCU5KFU?=
 =?us-ascii?Q?EihnNBhfFyYxlvjccNPWPmlpkPfxvXsImhDoYsn1Tr6XQe3GekKYK4A1JEBH?=
 =?us-ascii?Q?voPWzFu3gZKpN9jipBimfB64jtC82loUxOTiv45LZdf8KPYKgYPR75GPWsOE?=
 =?us-ascii?Q?PZg3OnZpXxYHe0uNw+xfL7MLIXx3VePswU91UK1ICllw4EV+jaJFAt5XC5sQ?=
 =?us-ascii?Q?sktWFhUZhXF1bByy/hD2Ses/lD6jzeb9rLuDqKoYX2FKmfAvfb96FxRb3DV4?=
 =?us-ascii?Q?2VW60uL0w1tqT8uHFRjO2axzs5/lZewmgCgT8Owxtbe3R5h5X9ee/ezdWeNz?=
 =?us-ascii?Q?H0Lq7wvoJQKfQ8ci5QxAtjeZNztwYWd42BP8fRAHefnB24R0lSE5rUJte7Tw?=
 =?us-ascii?Q?0SG1mSv8SdhQrStxX7Y2LD5R6XpElvsmY81CtR/lS/8XgujIqqm6ZRap8QH6?=
 =?us-ascii?Q?m6DFlKr8JbAPNUlBVgnDdUlqoDig2lcM1ofCvsvnsrpz1wMtqrx1WH0m5cWI?=
 =?us-ascii?Q?25ROjJnR9q0fyBQ4O7iTUTZ1Yo4DeZw4i3o0WutgApRPw14Ro5lCGpYkpIc7?=
 =?us-ascii?Q?OGFwjwDz5tcG6My1CKlJdE7RcsCh+85+J1VGnhaWpwhrh1mTjZJuAjRLw1jV?=
 =?us-ascii?Q?yJDXk9C2Jc862YzU3ZbEJ9CO4b6zb0jdcUHYBLdDhgpH3EcL9cii/adMJpQJ?=
 =?us-ascii?Q?njUhznplAokPy4ee2L6FYCjAefmboj8cSdZvaWqmt7TRc9J8QoGlTuX8cz4d?=
 =?us-ascii?Q?HlLvaJg+CzFwKA9Lcm7j1rJB4xLFlOpavsmUupHP/ZMFjnuNXVwywqISY5m5?=
 =?us-ascii?Q?TutBEc48NCb+uxsSiGLNUyLyhlk17tIpb3t2gyaqOX+BtQFtN7gIsK5TT7R1?=
 =?us-ascii?Q?LL1LiFdTi/dk202v1BpnQ6ALL+EF3Vprq1VSwgV/2xpgmCu5PDqoF6u6NIMS?=
 =?us-ascii?Q?05KTVQRkjkYzsEVsXd90CJh+CV5wXvpUBLX0We3x?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce1a037-a6e7-451a-b07b-08ddd9830084
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:31:23.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57d6AbxcU1ljEvZZrngo9CgPkaE4Qu4Siv8d8mQguMtsWMT/5iBJ2qleCBc+aOROXbQwPTSAkXRfWjGBoOsLog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6790

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/mfd/kempld-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index c5bfb6440a93..19c672820c8f 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -141,10 +141,8 @@ static int kempld_create_platform_device(const struct kempld_platform_data *pdat
 	};
 
 	kempld_pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(kempld_pdev))
-		return PTR_ERR(kempld_pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(kempld_pdev);
 }
 
 /**
-- 
2.34.1


