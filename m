Return-Path: <linux-kernel+bounces-789956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC497B39D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6581713FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB64330F7E6;
	Thu, 28 Aug 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lQmNnXKa"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D501DDF7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384138; cv=fail; b=TNL6m7J/YAQESWZZBmIaUImOBcbbvxM6NQGupll8L6JlnLxIOUVmZq7b2IKt0lPYLVounFIoKKe8BU+y69WWNcYUxTZVfQwlwpOgBNM1PUkWRK3ptXbAENnheB1mSOB9wo6PZytYBCyHalVFGEMDj4yASfDdTVHI1QX4laGvsA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384138; c=relaxed/simple;
	bh=Raf2TGu71x5KGOn5oXOA49039a8RvYVz9K9mERyNASY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AZE8kcXbT0dq6cB+P3A2RXFJjUNSvFrRA0ym7qdpaeK+waWwbZT35dO5tphvu74F+kZKIJGu7ZHmY4b9cUxIvmxGBGKRhNQlKmRtPiwnTSAb382kauhOXWeXsUBS6iuxRr8SxpjgqexH/jUG7ywZJw2HQBqZdwv8VtWozcyczEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lQmNnXKa; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrKYCM9lPwgcqqVelB6P3y328I/uqza8DKhQKVF4E229AF9Nygss7Ao3vP4t2lvvYGoMXLkn5EbMVZydvaL4oe/1Vvc4KMJlIA26wQcNOCRVWat9It9xLKyJzoaCBjYMLXdYfXT3I86JIjd+GlmxxSlZIvNXhm813cLY+9MW3D1vgZbXH5OW3JqKm27Y28o4puHqKyPaz80BVIpPAFN/GyO6o8AbWzeFrSpSGvsEYptk76ERP0UW2lz1IeTsJ4PpQM3GiJy9hIsABZJ7rjpiRE5h/tWKiYuu7gsivxmBKo2ulkhQaXVKVhsvep0ycSrElv8JjWWeGiieo/FSY8+KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQQizsHu4vzwD5mjj6MFsDRzhfAmQ/OXB74EbtiCAfk=;
 b=IWmukHPzDr5NRC8/PGakeT8496p6gkpZj/iwXUf9vtn3cDla0R7z5UdvHnMfy9kmVHiLsujSEBHSKjIk4Zi6AjPWwkH8/P6XA1sFIqWsqpE3xFoU0KH+ERDUDjhsoXR/4h6JrEzCYvmZjpdLTuM0id//LLRNRwQi/Thf687hWKy2saCC6lwGY8N9ZE5Fn+5MG2TkEyFjegnDh3Jpbss/iWQ4MnOhsWJVdU44v0WZDXKgvHQ4p0PvAJM7vpZeeXyIegXq90BsG1YaPdjVpb//1pN5Ai9dZcM9Si/37gl/Qvfu29n3NDYwzFrcg0F6CY8/lSpTwGKqW3ANhNAffMlUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQQizsHu4vzwD5mjj6MFsDRzhfAmQ/OXB74EbtiCAfk=;
 b=lQmNnXKaD3FY9IrIcECt9eqsBO9tG43Lg8dEToUYHRbT8mKE25rnuBeteNSDOa4qEuPGT95KmOuC9ADCQi8r62wVZFGK+YuS3Wk5OX8Y4aJZ1CiFrOkPLOPsTmmeuf+mbLX2oVg+HKa9FTsAL/LaRD+6iQO7RPx/qRjoDNRBW8sKkuST4OVZjM7Dc82VUBpJLPCy8t8hsk4gc98Si66KEq8fXGtrhtdU65YYiUhi8+cyy1Fyt1qdJ6kzDXQDTRFi+ro3cGXkXDwPLE68lxkQKgAKoI53MygpUEw6YVLKP19DfPcguBmqAKlte0jhOLBE0KHzKfdFV7ASGTdPRgvB3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7287.apcprd06.prod.outlook.com (2603:1096:820:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 12:28:54 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 12:28:54 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] reset: canaan: Remove redundant ternary operators
Date: Thu, 28 Aug 2025 20:28:43 +0800
Message-Id: <20250828122843.48722-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0ef3f9-50e4-4bfc-5adc-08dde62e73d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KOppY3/lFivD0btCOTW0CePOxh9z9qK95eFvc46fMBFU5hyoo1W0JQ+o6M47?=
 =?us-ascii?Q?U7UxU6c+FyaPBGXhFqIHrvyUKnLGdv+mrhPcWEGvNCM8JfuptgmjYm808diq?=
 =?us-ascii?Q?hoWfZVAwuGnnUGrh6KFc+Um6PCNUuiXQfHK1SONxk8jtxUfegt+eI8yQpuIq?=
 =?us-ascii?Q?vuMQWloW55pA4JGY5Y4xRXeHC0Mz0txrxzPGP168wle2MKYftJDpkSoJAzfW?=
 =?us-ascii?Q?KkYP/AO68dw76TnN3P2smGnDGShCVRhzzzu5L68zNjvvswK5wlUzT/Z4bkAW?=
 =?us-ascii?Q?0+G8gy4qrp5Cf6ODQuE2yFY0Av63gKg+eVva2bjFpsQ0WZ+VO/yhImuphxvQ?=
 =?us-ascii?Q?UUqxQnQt+tTzuU8u2o7MihduLdt1XNwQLax7bVlAQHGAZgoMpH0h9Z9btHdW?=
 =?us-ascii?Q?ntMCePqBbSNvs4vkzu/xUYDQfCfSRyKCZJNToHHZvfnzIlHLbWNIMrorSkds?=
 =?us-ascii?Q?lV0BMjcvdCCDL/j3HSu0ik72/agweReV6HDic+trysz66qAZYEeFHbBLCICR?=
 =?us-ascii?Q?nCs4A078IaiIdu45QJ7u1c3204hPXYqQsybaOnjJ420d+oORtwSDO25REGHf?=
 =?us-ascii?Q?yYFDHRBrMdOPKsZoNC9CineryCcMNMHLiHBUzZ/Oj0xrfX4Bu1TYFxXiERjO?=
 =?us-ascii?Q?WjQlxBQ7heUYaX9UxqWpCaLtoRkFEhxXZh+I7pA9Dge4HW9vR2ybbUr/7XD1?=
 =?us-ascii?Q?zVlcNERnfXwDoJqDBzKCY62BVbX9B/TMEQJ04MoCumkyNaTVbJGb+qFgOtBo?=
 =?us-ascii?Q?oVqPKK5QNXMU8RifMeIqhyblYPyLSnpJlMghZfIswUYnHnJGa4Lh8nV+B0bw?=
 =?us-ascii?Q?zzBF8sKFPMHf9jPg4JlDYM9GgfquRREcDq/KWvd///qgVu2MUia2IVxBqs/X?=
 =?us-ascii?Q?CQLIdmKF7Cf5By/usoQ0/7EEhI4+F6FmRKVwPLEna4c+umDL6ABQrtY7sJ+n?=
 =?us-ascii?Q?xmuYG6Hq05rmKl1QCwBQLNkiW403t7b+b/0SeE1dvarlEFduvqC3NiKHPgOe?=
 =?us-ascii?Q?tLviu60NrOqikNeRaHFcRhY3KfYOhxFyVF2Zm+ONYPncJ5NR6pQ1J0hGfwkH?=
 =?us-ascii?Q?DTAX+yiNl2CP5Z0glV4lbxFAvKSPvZszxhBXp//4EH56pkKh0xHIAP3d1liE?=
 =?us-ascii?Q?tZ5yhGlj10cUBjLErjolmny1hz0VIJb7B7q2WMgwwxmWz56TjX6D60xcIkHd?=
 =?us-ascii?Q?CUVx3bLafmad+I1r8DIWAygqaW8DkUstmHY+MWy5POsh7PcJzaT2rFDedUxu?=
 =?us-ascii?Q?wQwgm+OWvCdUFVVVsYP9THneMGJxCfEZI2JFrHQjPjBXsd6Bji6OZL4u87R9?=
 =?us-ascii?Q?dO/d1Bb88E0j++MLjjM3JKayEc8nHmiYZGNdxTEWyAfKSMCLJRFpS09wX5U5?=
 =?us-ascii?Q?9HsHRT8BuVv/6HISZtyImwL0DNFEnVcDsubiWIX0hPcvYR/xyAssEdtoZHPi?=
 =?us-ascii?Q?sgzbhQ9LSDPQUwkxEp16adO3xDU0pxYvtO8gpD8/BfCM4csM9QDxGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBZbEJJnROuRDKHN8zX3i2uglYoFfdBtYbTrJKYPVyMAZ5cTBXwXv/3iECZc?=
 =?us-ascii?Q?yPsxT0953dAPGqYLO98mtAXdLYlf3wZyW4nGKm2BINFgA0FxOtHd+HBWOuzg?=
 =?us-ascii?Q?ovTv7u7TM4ILjl4IYQ9BFykMv6dND3t609riheBV7ILIFMGnCVxe18WVkVRp?=
 =?us-ascii?Q?eb3Uei1db+4x2Kb6qZhrzqUXJ4FH3bY/67C9un0k3zvxNEgVVcGkEy9TPo1t?=
 =?us-ascii?Q?1BIRB63GUazMe+DQsoeR9au52678am7uN00zTK2NnxkuYLz7MewBCs21/jbf?=
 =?us-ascii?Q?LB60WyM2zcmld9jtBj3XjGOMqYB6TyKvqzByalWVAZywRSfCa2Q5kvKzsn35?=
 =?us-ascii?Q?R48lMXK9zgZcQCxTgdwKOkeJqrVJc6VIjwlCu+XJskRPCxyfHHUR4YZjmMD4?=
 =?us-ascii?Q?d59KU2Ko9tXPOBVcpDWzIecJh+ME7cy07+F3nN8S85SYFjo4vOQNStEtEEQ4?=
 =?us-ascii?Q?BquN6zBbewDLRZ6UD2vuDggqKWYnItQQCwDlNM4UKRxs3OzGEh3Y7qLGPEvr?=
 =?us-ascii?Q?uF6f65pJ0Vicnob7ACl+jSfq4ZO970X9AY4pCm3qU5eUMDOH00liMOHdjgqe?=
 =?us-ascii?Q?ASjPNpO4zEqIM9J1sNscJRNTVN0CEnPMZ5xEJG78kUZ29gONZjhpoaLRwDbn?=
 =?us-ascii?Q?o3HW96ftMprSbd4WDADG5LAUaLOCz9Ag6ct+D7uzjd5IzkdPFO3NLX5xA6fo?=
 =?us-ascii?Q?qON27pPyKpT/c9t5ixEmkYpyzwWqQhw6cpJ6yWlhdbR/xBLB7aOkSdZlrmjd?=
 =?us-ascii?Q?11HuuMBKQeedj2inWKBNkHXzHGe5qkrezbd+VMlmTj5rojneE8Ns9R+9PVIZ?=
 =?us-ascii?Q?dfRZ2TqnINPyW3XAJc1fSGtziP+XgoJkZJAeNbFsQPNsYmYdUbXIlvd9Sm4M?=
 =?us-ascii?Q?pWuNXYupajmmhKgeXNmVFre8pU9xjaUutOogU1NLeDkVCkd69AtcQPn/pSyw?=
 =?us-ascii?Q?IyFznxqrO/CXRXroNFssaxGGunaXvMS7phx2E9+H78jLEL/brDq83GJrWHhR?=
 =?us-ascii?Q?Z6zUlqNgWS9jDrWcKGGCCCMzc55YBRrBv8t846xW87/jFOeKdcAFtRxnE3GQ?=
 =?us-ascii?Q?esbVF8LmNoXwGCvDSPaJ9cgrEQQA55torkGexDP/R+7Vl7oGMQ/+vrHs8yPg?=
 =?us-ascii?Q?FBqooP4Skoa66b86IAFdZWlyp3paXmLDLkWCKyipqCJlqpqbhUEi1FKO+9sf?=
 =?us-ascii?Q?A/4qHvG6Br2E5chM745LNuVAZdVHdzoImZn84xS6Axgob2LkfGqTtkMUvPgt?=
 =?us-ascii?Q?Tzcyi+QylWGhuPrE/rZyzNIdc4TaY2BGP40pjE3WtV0ytdRBlwNmYQxV6dU9?=
 =?us-ascii?Q?T7PJ8/W+9qhXfY9B8I4y4gLIsZ9czlYh25VjZ4XWvIewi1pkkMZd/xyOyhfA?=
 =?us-ascii?Q?jD3lVM/t0jcsHW50sw7v6cnBwPFHKEDK0h28Vb+/udwwC7xstiN8efjgDuMZ?=
 =?us-ascii?Q?XkL68knhKk32iOiu3W9o6DZ1nfOlIBaBG1DUpdDp2FVy8NHAMtSDb36RlOvV?=
 =?us-ascii?Q?72WBqMrosE+9AfQm13NS14V0t5JrzBFDhQvZf+DTWW4WBFPAwCDjuZepw9HL?=
 =?us-ascii?Q?1iquEi8ZsMghsFFUXTAKWtN/rJ0OXcJnycnTOCRf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0ef3f9-50e4-4bfc-5adc-08dde62e73d2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:28:54.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOoAS93WGvaOTNCKOuFUoF1aZU81iQ4QDNKJ4zRDYyMCE+PXuasWndRe6x96xUWWxmoFYMvZyElq2G6O6/PCLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/reset/reset-k230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-k230.c b/drivers/reset/reset-k230.c
index c81045bb4a14..2eb16aac60c0 100644
--- a/drivers/reset/reset-k230.c
+++ b/drivers/reset/reset-k230.c
@@ -218,7 +218,7 @@ static int k230_rst_assert(struct reset_controller_dev *rcdev, unsigned long id)
 		break;
 	case RST_TYPE_SW_DONE:
 		k230_rst_update(rstc, id, true, false,
-				id == RST_SPI2AXI ? false : true);
+				id != RST_SPI2AXI);
 		break;
 	case RST_TYPE_CPU0:
 	case RST_TYPE_FLUSH:
@@ -249,7 +249,7 @@ static int k230_rst_deassert(struct reset_controller_dev *rcdev,
 		break;
 	case RST_TYPE_SW_DONE:
 		k230_rst_update(rstc, id, false, false,
-				id == RST_SPI2AXI ? false : true);
+				id != RST_SPI2AXI);
 		break;
 	case RST_TYPE_CPU0:
 	case RST_TYPE_FLUSH:
-- 
2.34.1


