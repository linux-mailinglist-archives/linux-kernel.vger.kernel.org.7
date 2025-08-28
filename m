Return-Path: <linux-kernel+bounces-789950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868BB39D45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21958161FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C530F54E;
	Thu, 28 Aug 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YXEIIlRP"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013005.outbound.protection.outlook.com [40.107.44.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D001DDF7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384074; cv=fail; b=PySvSpGbTbWFA37i4FFDMrD1Ib1HlXCR057kWmv6pYNegKoAvzzFecCVh7QaGZjD1BPWc8NfS9SRkMwFmWJaxCkwV0w8FIHvt0Wa5hlC/knX7CDsOPpZoMAkiK41nah1V9nvy1KUcwrruUL7HInM698oERMbfYqKZugMbQ9/rLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384074; c=relaxed/simple;
	bh=L51dQnzWAxvwW3Omjy4WYBlCkzqAYL3ni6WM6+IHrXE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I9Jvrjbv7GYu3KgMxl1khKR1eUHWTz4FheOcj8k1jYUEWbTmrq9kyshNwEWu4SERpzK+vjAiFfHMBO8KwzukDWUa4dkY85FkraycJkjcuZrvKSa56fwK235WTOmRioE8uTqPiE9RuYBrHEh2Lbt99s1I7loqyUvkuJxE88raYMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YXEIIlRP; arc=fail smtp.client-ip=40.107.44.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFqMVFmeBgL/6s9NHadxc3akZeGjmdJy9O+RdGI+P6OKnAwPHIYAHdqpDADmoEoss2enL08XBQLXxku8FWEX442IL1P6wG/p4vS8Jk7c5yOj6ojlRb9wDLqrLJOa2IxalVg6y7p4AFgxn53WnJQO4CjTEL1mClZppqc2E/oeNHnvdg4/x+536OEq/6ahh6Umgz1pHlSKWKVuCbLtzSOI+a/O0aEcjMlxizI3yciCjBLeWKFTh8fe0MP7mrSuuj16NAWlGicSs8cjvyIyQNAiDpPUdqo35CzRXAs5Fv4m43u/lCVuCmkDGpJDQEdCVHC7SY9W3XHPkpl7cJlOncfjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnmz0qxaDbbIs+sfZv22aUO5Yydvmd9XO+pB5ETBH/k=;
 b=EpFWHhJfQl2fJmQSp4pYoUT3jPSKo7i22Y5uW5oFrqUQoV+vdRJ0/81Lj0MV30mc0beSXKkC9ZkMnZkwJ1x8VoKk0O0qgexNkPUjsJcZtgmMCI1clDNtcG05IAlRWymx4Kjpi1JTxu3BygGDp/39YXCB/4UslEzMHRIELV/dye262quQAFOJGdwqo28rTRHZqSAPp7vlHHux0kCEpvTT5QwyXf+B9xEkefTJn+56FHf63fVisfqI3dvVAg6aXG5t+nynqJ3yt0lbPaChAMmx3rRDSnmnLGssjROsez8qd/2A7jEp03CzYz9I+/XkGZfOa7h7z99TBJN43KUj7q4GPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xnmz0qxaDbbIs+sfZv22aUO5Yydvmd9XO+pB5ETBH/k=;
 b=YXEIIlRPIBsH05XkhIkkRmft8fBZdE0RQ6WtJnmSZyzZWsImMqRHddE3hqLhBETtid1PzjdxPjrgT0+2TRFTqP3SfIjpefGEmb2PFVxZvlj6ceOg52U1OdR5FfImKO8+kTtkRyS2BGZOhoGHbDITgf9VozBkFNMZvVQqjCwn24HpNiIkYVFs9mlmR+V+UJFGlp7kOQYszLJbExMBqN2AesfwoFOCZ5NGvK+/UjztR2w/cmGxyEx4Qw4kGcu25zkj6bkj8IYhy++PhQpPF0FeTjnDD1wnCj7GAwYFt5peYNHxp3sAI85xdTNRiF1fkfgOULOMzbAbSgWPIa37LZ3FYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7287.apcprd06.prod.outlook.com (2603:1096:820:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 12:27:49 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 12:27:49 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] regulator: core: Remove redundant ternary operators
Date: Thu, 28 Aug 2025 20:27:37 +0800
Message-Id: <20250828122737.43488-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4a3b5b-04f7-4e91-afc9-08dde62e4ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bFW/B8tLsmbtdGnE8MLaTVsMA3kFmYyWFdjy4DlO2cSYBM00WHeyMRMNKKRF?=
 =?us-ascii?Q?SqSQuUUkO30cuoy0g1JEhBZlgyTPFGCUBinJdBeBYfRUn5N8xYltq+cFwNou?=
 =?us-ascii?Q?D0ewq+dtH6FWUcp/zOwXCMyrtEvScThaTJnQ7O0m3BnvFyaUyRFUkXjkwYiM?=
 =?us-ascii?Q?x9Gbl/JTxvzee+mU/WgWsrxlaU5tC9eM1KgpUjITbNHrreI4I0zquZ2RygPw?=
 =?us-ascii?Q?zgZTuZe/4abzcHI2UkifEGYjyq20IJP3BfQZTY7Q5JqXrsGkRpFWT1EvRSXu?=
 =?us-ascii?Q?edUzKk4mpMjuY66TYl0G6cW5loYzz6vwUPFK6qX44R5NMYHmgTvwnEe0kZl4?=
 =?us-ascii?Q?PifChXcprH8/embLtggz/8G/ce88I8SNxOsvjtu1x3dlIUSdGjdK0bFXSaD6?=
 =?us-ascii?Q?MgHWYHkIYYdmm+yebN0yXSECCs/yJ4mj7tCQpuBiGXpFd0XcC4wbjsT9evav?=
 =?us-ascii?Q?b07eBhS3g5XIMKSPYARmNnN5uOkDAHI5seOH9vtPt/ucQj5/slWAW6aXoMoE?=
 =?us-ascii?Q?JjuJAZEqEa8WhoKPmgEd6YdrZhU9XzuNVk4JeEwEoCGmOB+SXZY4Fjhl1pLP?=
 =?us-ascii?Q?YgBRInCKuUleJA5DrQPBMnj/acyxf6tnjOvRIroIsFvIpfPrZLcaOnBrWXFS?=
 =?us-ascii?Q?VKhpVVya2KUYy0b0j4gBa05OmtHG0u+rMPesIwqlGdphRX8XZJKQxbOpOGNU?=
 =?us-ascii?Q?lAyQvRrbJKWoRAlg3DZaFFM7WOobCCLYgW6Fsn3bMK6PPs6pmgXYhhskQaCm?=
 =?us-ascii?Q?7v7pMXGcBPe4qRn+3cYwDO/Kij9Sj1YwyWJlRmpYfqhmF6tZmt+ykUPTEpkI?=
 =?us-ascii?Q?DfPfFiiczPFXoCbr4hq+qMddO/gzf7OkLola6A7Ca8dMQ5wc12myV2B8jP99?=
 =?us-ascii?Q?QzR/xell+NY5CzaPI5jCwD8cGA6Nl3VHf8MfcFQYlU7l3p/jYZc9KxgNqVB/?=
 =?us-ascii?Q?cJKHkr2CPx/eBrN5UpznxhrzMjmUkZBvXkdERqiFqqQGz5CchU46xJR4lxzO?=
 =?us-ascii?Q?9RY9GzZNOU0ckkIacSMT/jjWVfprp9AaR7ssa0FMQJy9fhOm4qcOrtKnfoj3?=
 =?us-ascii?Q?wUxQan+8wyX8ygWwiEWYu7rCzWq6nVw8+18/WdTvn2gh2Bd5QRqj5Aw+KcDf?=
 =?us-ascii?Q?4Q77pILwDjjjFCcTJUMqIVRbTApPbxO9Szp2BW+mmL/Q1fxHxZe3qKZ9Qlg7?=
 =?us-ascii?Q?zkAALACMcNv2xa+xMSfLJ+l75MX5kTjJiXd91QdtGJAgYAC9A5Lby+6vsJ9X?=
 =?us-ascii?Q?mv16viGqBvdG4EorL2k15SlXZNPyG+eM/5JZu/rCMNPIs6kS9Xcf5DsPJkwe?=
 =?us-ascii?Q?FSpC5CzX345/Y0fed918g91Lvp7n5LyyUIKy7c2skfs1xkotmmakCTgePwL8?=
 =?us-ascii?Q?AMFhhBu3pxtr9ZA3mHxxHItKC7LMi0N0uR6w6O9Ueo8U4RCNrqWhgVmS7FSA?=
 =?us-ascii?Q?RAgpnd6j0LbAgLYsLVYrkBPBuf1V+hDNkNg39+unwSLS7GAUAxqugw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eFmJda5oYipjvxsl4l88tNwlAswgcNuqqaQChRBIR1Y3sGv+Q0hWBhtzmr2H?=
 =?us-ascii?Q?TPXfJBKgmjUBn3ObBcpUXkqbSfpI0blc/E6YL0Y1K6rbCNHRt/5Z5TwQdnvY?=
 =?us-ascii?Q?9IaNtJZC5N/0IOEBWk879x81FSuv5O0+Y3JIMuSJTDB9wb5PiBVdmQyMzi3n?=
 =?us-ascii?Q?nMcNwLhunkZiZv8r9oXPogGtl9SjufgBiiJn19mz3IJndc3tLr+FFsia29dL?=
 =?us-ascii?Q?Iy0ZnenIJslG/AS3axkFEPfDBb6dkONN0zrDTv/+BEJPBSnctBrP4ucEinQ2?=
 =?us-ascii?Q?n4VVfZ2utV5Uf9k9KP5kUqTzuoFvobW+RzLAOuFgFpc/lg1GqgFAXuuPbI/k?=
 =?us-ascii?Q?4U46GWuehhlHjun6lQ/WKAyh6wWtN+C6pweo77HxAsoI3N6/y76XekqpR0uR?=
 =?us-ascii?Q?Kul3NLb9h0fb7YXK0de1UgdSQd42ELq8I6Mn33c8fQ4UMElVg7gwtj6KdNXt?=
 =?us-ascii?Q?gGl5Z9YlmpIrXvPCR9nhTnUku7p742pZzIyPuMQPN/qMIeVBT0fZ8n0+jRdd?=
 =?us-ascii?Q?LDl3Eepj8i28qbAMXCjiBz2fJKAwQX0gbJKyFt4v4P/g1LjWs1E/UBQMHzUZ?=
 =?us-ascii?Q?DeP0cLJmkuhqtvIWXXzCGww88xPRsXNM06fgeTHB4TpmFPBu7Ssl2ADzMHyn?=
 =?us-ascii?Q?CVfwquChjwLh6IDQ0aK7CSi7bfbqZlVUKwp/4b/0ow2y1DUKPI42yVXJzRnC?=
 =?us-ascii?Q?hcbPZNqbYLxYnDTymwyVAqOc8r6paDdL+/1g7wPHBN2j6LnVrSnfR0Qj/zER?=
 =?us-ascii?Q?ivOiaJe3AhO0pXiEPCJJPFZ3p5vGEvukT74KPKtEonwZWC7Hy0a4xGqBrAGg?=
 =?us-ascii?Q?HBSsQSBSZZwVz7nxNQ1n08C2X26oZRc5Ee+9YK2Xqdgb0UGU7SvKezcYGNcq?=
 =?us-ascii?Q?FzLDW2XJ5rSXBcD9ACO46Tr6k0oo0Qe3W3eGPPrOPbtYxEXUw2e6sbDeY8Dd?=
 =?us-ascii?Q?s6XWAqGmblEGpNG6QWbNXJdIj1wE+KqP2CZI4ScMS9PNcxZYZKI4pCZ+/wko?=
 =?us-ascii?Q?tBrzOwgeKygQjEf2KPWGwj8N5WiT+dSjuhYP7w7e3zq7cS2wGR9NFBsEBQZe?=
 =?us-ascii?Q?aHa5ab9YtxMFP5ZPuRLeXaS3bSkmczHzg5FtuKc/NcxqMcMFy9VHHQFhuTOd?=
 =?us-ascii?Q?IWqRHl2VA6DcH/NXeVf0jS/TsAt4ah6pdCcfOvVuvhUy5tX8VRFhovi6Y1Dp?=
 =?us-ascii?Q?/gpvzknc1QiHFh6WMiKrlVb9Q3vjzSBHJINELim2zI6KaUatIw0GZqcSTWIA?=
 =?us-ascii?Q?l+pUvsOSay/Elr3wivGKM6DumFivANlAUb2TGA32LewpzghkQvSDdkARhEBs?=
 =?us-ascii?Q?iPYePoLZy5+6msxxgcHVs/07OrcL1BTZSyhtMOPHqft9CntxVk7o/o+y8qze?=
 =?us-ascii?Q?KjNCQ0kOsGvDjH0QcMBLi5qmTa6AyAthSDM+0t1l6dBcTo/dVTJUeWtgX67u?=
 =?us-ascii?Q?U8Fgcv1RLrlaQKVGB+6HM8dBblGlZg6p7mWmK2j5zrr9aLMD6HE4FmwYI5HB?=
 =?us-ascii?Q?Zka6gtC0V3C7rG3CBgJ5PeKnThC/mtLLwRlv4/4a3pdICH0ZgceQz9M1x1OR?=
 =?us-ascii?Q?eGVjK7ZwUzaPXpNBiRPH/Xo3OK2u3+B5m0F416oC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4a3b5b-04f7-4e91-afc9-08dde62e4ce1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:27:49.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: At4dqLhjSyIxDMYUpb+oG5TJIh/o6mxraNVwqJb21MyzaOZt+5hHfsIdX4sdrjMOoDD+CRBcar0v+Gi/sqh8nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 554d83c4af0c..dd7b10e768c0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1586,8 +1586,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 	}
 
 	if (rdev->constraints->active_discharge && ops->set_active_discharge) {
-		bool ad_state = (rdev->constraints->active_discharge ==
-			      REGULATOR_ACTIVE_DISCHARGE_ENABLE) ? true : false;
+		bool ad_state = rdev->constraints->active_discharge ==
+			      REGULATOR_ACTIVE_DISCHARGE_ENABLE;
 
 		ret = ops->set_active_discharge(rdev, ad_state);
 		if (ret < 0) {
-- 
2.34.1


