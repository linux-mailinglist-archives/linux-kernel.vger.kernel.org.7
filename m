Return-Path: <linux-kernel+bounces-721267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A585AFC6E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD114A5D20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871821DDA18;
	Tue,  8 Jul 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mjxExRYM"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B08488
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966270; cv=fail; b=g9mhl3cTWPVR3gFOCcOXvDE4GY/unHYVPxORco4nH6RNGz41PhHUJldL09OtPwOCbWCXgD1M1WUvRXqEf/XBFmKSFoK2l3v1pCYRb/Wnt3tn3vnzbbzbemS0WThtmoJ1V2EaUXv2TeyGaWOIaxJYQdBOebZpQcwqYOtF3VAteBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966270; c=relaxed/simple;
	bh=1By/cfWR171/29FVYSB9Cw0CFBiEYpckQI6/XO+3trQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mI+XDQoRoIgCPsNz88RzDcRX0bO62+uJBccwhb+OQtcUjKLWoegWzwPbei7YZ6taBEuIdrTC/LZo/M/aK6LBwE/NYlS1RpcgLvV2drLzkrNqqc8wCd86ua3teVJ95NBqPpUCRa/NUXkrFcWV5HWL6Ud+dzG+DH+Sj4X+8EPAqdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mjxExRYM; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzOXMKcCuo9CqbvqV4ewkpNfh8fNYT68IBElCsMQLJ/STGXJOdnrBgbOpHLBa433+2aLPSF1d3CDdoHNsk2U1FAgjK9xO2qiUAnRdpca4pq4EgqnRv3EJ3DTAm4Qjp7Cx0OZ0O02wx6Dei56PhHKxqMNqDwBGg1duzaLN0FkuA2/CxEsnSTT3ZCSVHyoW0DhfN13x6z0e0molnmYqjO7bqFVRaCSZ+crrwfTDnMCIEfP8bMSJUtPYz/6YzJdNHew5rxPUDY1BvNAF2NcX+YnBaR1GDgrlQ4R32DFG4hdTlcoEr0L9fxiTd5Prs8wHXtlHn2qVPbv97g/HreMUoLJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU0Q0GZvN511vYCfnjrr7BA6dkumlz+X3Y9ZhI1IGWA=;
 b=KgLYBe2+pxSbLsDU1zRcseS9+LQS09qyhYDMmrSp4XZnzA5aRHesDfjXssTFnV9wpvz/DachKHXBnOkMvSdz7fIGwZawkzRhsiNh3DKA1bwJcfP3ynr/0Bo/23RlI5mUADCdvCTXMJLv8cq9rci8epdr0HP1+NSsrAiDgcJzHDMwLGYRizqVB4syqlf8UV5qwYyb/Lnh6kt63kQKAzBLvym8OyKX28syYZku+WFx88FuquGZRc8FftaGPrZlPCt9yNJ8eY+8oIyafVpuDF/+dO1DseanOXvKQfLUdFGZghZ5K+ea8sMNdf/DAvhi5y+Ml0NObEvs+QHdCtedO8c4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU0Q0GZvN511vYCfnjrr7BA6dkumlz+X3Y9ZhI1IGWA=;
 b=mjxExRYMbqu5xocw/fUH9V3zWXfRwT9YGd1/GuARLrhBw6UDoHvd8I6My1f8mmZeBkKxDPRbFtrzx6hXy7Wrj1reUHzATtEs1dPaK86B9Aai+bZPXKP5luGmPzemfqjjcQyyPGYw7Dnnup0+dEOjro3sDagra9bnoFBbGM8TbJ5tmjlW/ukpgDxMt4r1/ZskkC+LaTWtFccrprr7o9MmH6BZb/DBEmP8CcBu8zWPZM4R37+56OSLwjLdudzKfmA8JsK5X+1z8szdtfrGtTIJnFHnO1yWbfAVYkU3oVNVAilXiidnyfGY4q0z2L8LV8cg6FasGF12JAipvpx00+V25g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by GV1PR04MB10968.eurprd04.prod.outlook.com (2603:10a6:150:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 09:17:42 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 09:17:42 +0000
From: ziniu.wang_1@nxp.com
To: pratyush@kernel.org,
	tudor.ambarus@linaro.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	han.xu@nxp.com
Subject: [PATCH v3 1/2] mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
Date: Tue,  8 Jul 2025 17:16:45 +0800
Message-ID: <20250708091646.292-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.41.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|GV1PR04MB10968:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbab588-4318-4617-8373-08ddbe004a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NqRoOPttuELRyJCMqA1UBhIFNKNCDidlr1zWsvko1n1f9o/VtbLU696QSVkC?=
 =?us-ascii?Q?rwtMVq9hO4ZVemouvd33IjpRnkBge2DyS4grsrxWuvsKfqYldEh0aeYSEUte?=
 =?us-ascii?Q?49yB/gfCezs1hHykAphbGb44RlvINsbg7JB9jNr5LIcc6Oj/TWjld6jGL90j?=
 =?us-ascii?Q?car8KWXrGQYb2K54sueC5bmcWE1Br3sj2j9ipvT2v0tUqFJshJxh8UxeXCGD?=
 =?us-ascii?Q?1PhQclCGvAXv0M00BnIHlxdCf7uJQbf6hVIFCQxHnswOzw1Uz2t+ctv4iXLL?=
 =?us-ascii?Q?S95VnUPj+G9V1fsoYHFyAZ6j+utml04S+FKG8jqS88yK4cZ3H3Bqr4arJEC9?=
 =?us-ascii?Q?XExvxaTAqBHfSzfR+dEO3ySdP8Iqf4hBs2yLmiycjXwbiDOEMi4ek2gFxIl0?=
 =?us-ascii?Q?pUaiPwux1EFdYWPP1ut1qhmKktDnUKEPCjPFqd2ttiQd2DPy3F5EupKf6zga?=
 =?us-ascii?Q?vwxLZV5ZKYdiF/jlKYmwuZ15r/0PJoO3wLv0YkrKvtjLaSHUB9FBdjNAlF81?=
 =?us-ascii?Q?b8xjcb7/jynfoUuINKSSCJQpCksQykE6Atuv9bYwhq8zKVIkF+aFwcaWexha?=
 =?us-ascii?Q?NgsT5G0tkoFqCOY1qBfpfHdDOcrFiogxExynXyRoReWM4u+bMiwOsBK798i6?=
 =?us-ascii?Q?fHV/nfmj+X2oz4WqcevlCpuTWsNJgFsHA895Xz8CwOqeQT4z8gfjtPFD6WRi?=
 =?us-ascii?Q?ljiufn2YQqsnIOVNZut4jXYdCNv+LC2FFlC6SHExUpgva/Z7qN06jABKBBhR?=
 =?us-ascii?Q?IfW2BtiISJfddRkGPPi5MBPSdqhl6dZ3PRL+tj0Nf0ScD25XArd7zWB6JXWT?=
 =?us-ascii?Q?doR21ZpdnqrnkMtRs+QNEuIMysTEeIg4veL8298CvZ70D9gFpCV93rR0AAez?=
 =?us-ascii?Q?i/jnJu+U/2zPfS7EuPOpQpZF2drgqG8lSj1gyj10z3qhSY9tIwGqYp8g8Hbm?=
 =?us-ascii?Q?+ESD1jthepmsy78OsUH09XZRgi3bV3sU0BykcofG3OPjvlAD5qnroMqgvgYX?=
 =?us-ascii?Q?SwEyIkSBV7PkOcqdGObn5zczRt+Xr6Mk2mNp2n3LrdVXREB2xJ73qX5CUIOe?=
 =?us-ascii?Q?9Gq01YggFcnUvmRuuh5h0ClQSa2axvvx0UVdv2+NI451SQcBtb3F8tVXR9TT?=
 =?us-ascii?Q?L0E7rS1WhOK+SrfIJi/5RuxbIab+TXgr5JhdW4rdxwq+WxBMJkJOEMGSN10d?=
 =?us-ascii?Q?AnJ/Xf6yovidce41Ui2UZGkZApArLbIT0efqkK/lR2GSqhvBk1nIjO4RnMMw?=
 =?us-ascii?Q?ar5CwdrCgfUjQGQW/6zUTmeB0tuRDze+oo9dnf93Aqc1iKcQ+7yOJRNzYghh?=
 =?us-ascii?Q?6vL+tjF07avokl03n8VxoQcplao71GlKcY+Er8dCRK8NSKHJe9q6aIotdBxF?=
 =?us-ascii?Q?/SrxIwrqwLzOi/DM5xkvJMNmMibSi9hiCIziIQ2xX+e0QUxWnasQTMfEXYgW?=
 =?us-ascii?Q?xBUkhN7qpIdN4MB1thh1lCixUFBc+mtGaHBoA2/9n4O84dx7+sN6xQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LM5LMouvGjLxdHs3V90lKSAdiD61l4EsIXTW/kFks3ykEjn0Vh855Rms/99O?=
 =?us-ascii?Q?4sqhrmiSA70YQvAq7yezUEZzAYCF6rRZ1H9S5aLdrt98Xm8MAH6oqmMZeyGd?=
 =?us-ascii?Q?Q3cHHzaoXSQcnE6iAgreSfSSVmVlKmlzG1ki7co2+oIRrXJRp9N56SvcUSCb?=
 =?us-ascii?Q?lfC0GfPeNCxCQMutLS8tKWT5zbC9pYNivH1/kMUtEu6WIXYSf14xc4itLTVC?=
 =?us-ascii?Q?95+mqnVXIeR6IhHV4nqt9eT6R+ztZL0WKN5phFDICl+4fpWOXeUBLz/E06ty?=
 =?us-ascii?Q?wqPrdc5mcvRsSeS7U4WRdCflVtlpyI/7Ev2JiNOdVjmFwHNsX0AUZC0L1A1j?=
 =?us-ascii?Q?SRalqjEzq3MUUbPWaAOhXf7e6YEPv5A1DDu+rc+BivqOKwjadQjLAzFW8FyM?=
 =?us-ascii?Q?fDsbxqSiiwLeJyz8fwRbE3BAP9WvQBMEAUnuQeeJoOec/lVJ3rAiZlVadude?=
 =?us-ascii?Q?otbQlgtUwdr0eJyuy6/keH3OdpFXHgccp/LTGksmJwEwfs424+NmNXhWeS4x?=
 =?us-ascii?Q?4KBgDsroEA4NUcqwRaRtDd30NZ1+A7L0FLiwlUlvF1aRwYjD02iX5I8m3j1V?=
 =?us-ascii?Q?nE9w5IwqsWXBG7nbtgitfjKX8U5p4cjm75Df7NO4iy5vE3cPYZFcRj4Y7dhv?=
 =?us-ascii?Q?Q2obK3xma5HgzLGhskHXgHUy0JiLp3ah7+zI/MXU7CdCoKGrEvwXSPs+ctGU?=
 =?us-ascii?Q?qiGNdGg0BkuiZxRM+EBiiJh6aV3eNv1fQZcsnvVjGEis6tobAU3ceZMsZFgM?=
 =?us-ascii?Q?DOEtM4OFy/u3zi5mrkIZklYUkMX1UEPx50R3AGcwt+WnaaYy3HzLxT68NzwE?=
 =?us-ascii?Q?+cgOaCnluknrFok3DAHADSPIwURMWZwrCMekPzHeLTC2HJkyMCJulv8HqYjR?=
 =?us-ascii?Q?C5D9n0qhERgZQbslXyBIK8cUY6XQqbuljpj+DBgqHl7zRSOF7oFF6mhsJAo2?=
 =?us-ascii?Q?3d1eCt3u6hgEnySXxiI1RS2jdRBOYcCqRuZnxh72hGCnJfNH3pQAvtrTnH8C?=
 =?us-ascii?Q?FiStoEoodpsd2/mtxq4Z96oNqUSuDTNy7wM8QCpYu119l5hLF5bEGd6b3ir6?=
 =?us-ascii?Q?IbTJjplKKSRkMzuk1ZarzgCtlsm2JmzBmeTW8NjcLhT1f5fKydldE46P4xN5?=
 =?us-ascii?Q?jzaKn6QkMj1Im3gwATaje24yVqyPbnnd+Kl4QX22coY6dD3AXzd8ZuvaRURz?=
 =?us-ascii?Q?jsUUJD9tijW620bfyMdFbku/UzBSGrFNI0v+2cyCaUiKK3b+r5YH3obWMxBZ?=
 =?us-ascii?Q?j2Pn1OSAEkaJoZsJ3GnB88g7ckkBN3stwrFSBQY6X5S8BFSGZGRDfqwLdKU1?=
 =?us-ascii?Q?AOJ5efbvYiH/b9QNkDUwd9xpi+zaCvGbvEHA6+O1Fp7yXkszl82Kx06ymzPC?=
 =?us-ascii?Q?r7+ZWoxvBKAV8zRghImeO7HqUDxSDGW0T5lc6JTAtSfN3YJtb+oaUZ3hxwq5?=
 =?us-ascii?Q?3wxi7uXdFtBbXQeELClAKe+L8Tqb4Yxi3uKmrc25a9YedyuNZ5PORO0I+NVx?=
 =?us-ascii?Q?8ccCE7iG8uNVV+vFp2yrUX4a0UZIjf+49+bfX3LWGItbQvGpm8fFxO8B9xNU?=
 =?us-ascii?Q?J3+QiuK5xAJW+iKVm1q2j5rEWiGBdSIisvk9VfwC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbab588-4318-4617-8373-08ddbe004a3c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:17:42.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgVWBEZcg1KXwgkEyka6IpNYieKsw6RT3cPja/IWjA0hzZ0K8HXYHuPJ9IkkaBplMyq3WtMwYdZHmvZMH96M2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10968

From: Pratyush Yadav <p.yadav@ti.com>

On Octal DTR capable flashes like Micron Xcella reads cannot start or
end at an odd address in Octal DTR mode. Extra bytes need to be read at
the start or end to make sure both the start address and length remain
even.

To avoid allocating too much extra memory, thereby putting unnecessary
memory pressure on the system, the temporary buffer containing the extra
padding bytes is capped at PAGE_SIZE bytes. The rest of the 2-byte
aligned part should be read directly in the main buffer.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
Changes in v3:
- remove last if (ret < 0) check, as ret always >= 0
- remove Micron manufacturers info in comments
---
 drivers/mtd/spi-nor/core.c | 76 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ac4b960101cc..1b594f720b6c 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2014,6 +2014,76 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 	return info;
 }
 
+/*
+ * On Octal DTR capable flashes, reads cannot start or end at an odd
+ * address in Octal DTR mode. Extra bytes need to be read at the start
+ * or end to make sure both the start address and length remain even.
+ */
+static int spi_nor_octal_dtr_read(struct spi_nor *nor, loff_t from, size_t len,
+				  u_char *buf)
+{
+	u_char *tmp_buf;
+	size_t tmp_len;
+	loff_t start, end;
+	int ret, bytes_read;
+
+	if (IS_ALIGNED(from, 2) && IS_ALIGNED(len, 2))
+		return spi_nor_read_data(nor, from, len, buf);
+	else if (IS_ALIGNED(from, 2) && len > PAGE_SIZE)
+		return spi_nor_read_data(nor, from, round_down(len, PAGE_SIZE),
+					 buf);
+
+	tmp_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!tmp_buf)
+		return -ENOMEM;
+
+	start = round_down(from, 2);
+	end = round_up(from + len, 2);
+
+	/*
+	 * Avoid allocating too much memory. The requested read length might be
+	 * quite large. Allocating a buffer just as large (slightly bigger, in
+	 * fact) would put unnecessary memory pressure on the system.
+	 *
+	 * For example if the read is from 3 to 1M, then this will read from 2
+	 * to 4098. The reads from 4098 to 1M will then not need a temporary
+	 * buffer so they can proceed as normal.
+	 */
+	tmp_len = min_t(size_t, end - start, PAGE_SIZE);
+
+	ret = spi_nor_read_data(nor, start, tmp_len, tmp_buf);
+	if (ret == 0) {
+		ret = -EIO;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * More bytes are read than actually requested, but that number can't be
+	 * reported to the calling function or it will confuse its calculations.
+	 * Calculate how many of the _requested_ bytes were read.
+	 */
+	bytes_read = ret;
+
+	if (from != start)
+		ret -= from - start;
+
+	/*
+	 * Only account for extra bytes at the end if they were actually read.
+	 * For example, if the total length was truncated because of temporary
+	 * buffer size limit then the adjustment for the extra bytes at the end
+	 * is not needed.
+	 */
+	if (start + bytes_read == end)
+		ret -= end - (from + len);
+
+	memcpy(buf, tmp_buf + (from - start), ret);
+out:
+	kfree(tmp_buf);
+	return ret;
+}
+
 static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
@@ -2031,7 +2101,11 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	while (len) {
 		loff_t addr = from;
 
-		ret = spi_nor_read_data(nor, addr, len, buf);
+		if (nor->read_proto == SNOR_PROTO_8_8_8_DTR)
+			ret = spi_nor_octal_dtr_read(nor, addr, len, buf);
+		else
+			ret = spi_nor_read_data(nor, addr, len, buf);
+
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
-- 
2.34.1


