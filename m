Return-Path: <linux-kernel+bounces-877489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B3AC1E356
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B603B4E6CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2762BEC3D;
	Thu, 30 Oct 2025 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Afj13JRM"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804F2E1EEE;
	Thu, 30 Oct 2025 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795031; cv=fail; b=S5CtfU0Ioj6JHUiVTk8SWN1bqTWG8CTuyEr7SEFMOpvTXbdmL8dmStTkxr2NEuLYFiHOHOWXlW0Udizm515QDjEJn1HRPv6UU1AlyKHMluCbJColO4NmHqOs1YEfdc0mm8ODC3Av8edCbXJz8bjfE9jIo8QRJTtx7Un5ldN/Eek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795031; c=relaxed/simple;
	bh=ZTsug4EnovghqFO0mEAjANbcJbasu41FQ//ezdlGQdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgHdjr8QXKZq8tDSdsZqd3cnPAP6F9dnLKysLeYOB7BBi29/+RcxdFyRwJ6NZkg/YCz1JHDblZzwtfbqodDA0qPY1FwcYBPh6I6DaefubU7PlIiEwJ9X/IcolGuWrsZY2lkDD7Y4BqfrD/KI2cJRrBQZ/jqCQFf1GgydWf1TAn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Afj13JRM; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7533mksJk+MRyjlRzvT/8h+sYluxHT8MjrOaIqQPcrhTb0EihrKDQqPisYYOUNU+Sjg38VYi5SLNXZBEgcZlnDDgREONOTjfFgc/6b8JXiicI+O/zH2WRRIGIZyGjtgFiYPxsTNatn0dXRduCQvkHrWwXDzYTMYYB0esPuZfx0C0fVTzokW8wt/xmU/VcwaY06FmDiuutSS2LEAOLPRijHWVCGiTHMbQKVIZOs6aoWVO2MbODJdqYjPG4tPFDOdAiWIuGUK0dDLblYVnyvtRvLIgABAxncls6EDU/Z1sHzd5B2VVaDFTxvXCIwBowqfuDKP3OcS17fNxZd90Vi+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC2ioIj055dNRzF/+/jEMkgKYlj+XNOwqZCjkTgbQbk=;
 b=gfOBI+d+6eTUV7crwXNtRb9LwQg/MgL3qw15fJzEcZuQqmlD1nE1zwKhtbUHaIdQ+iubRsvYa8c8ezvqSFuw/L/Spxz0KCd1Urluu2FB0QE82qU1Ltl0jkUDX+Yo10NvIWBMUZL1tYFf6aMMgZQ5Dn35A4fvk78TM0hleWmiI3hmOSu1fbG7ig7oDYk8G1SE6tRlvbAg1aDuQG57QaXZVyyn15UBly0OyUP1mcnbrXf8vOPU6p9XDb21HcLwawPqqqDdQlqeJyjA3M1yLyWEPoHNK1kmrVKVuSSD/sSQpEPUIXkgTAkn3sQ24nHxgx1gLgJ8mw2sIZRckI9rs8rQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC2ioIj055dNRzF/+/jEMkgKYlj+XNOwqZCjkTgbQbk=;
 b=Afj13JRMGAO31W3KA72iwNNEGmVnNEmzO10oDHTIl1tPmE2COwAURVfdKmtATUqLpDPtvpKO5n6PGRCsgMTSiiKE6lxCg7cMsZ24bKQD7Ob8/gTxFgLowqXO1qNoqS0EbmqRrQzoJaQG7Nrt3QRSxw+KxXodZCbSKwjnZTHBfpTWDeRwVrMighdIQjYcdeT0vAi+OvTKN/kRINErBmWnZp9GH8Y0okq4UUc711yfPehMgzTov/DRPEzzU2sdAfvWcslts23U2/adiM7ykZWk6Y+ZKQt2TyJNxQWnsx1oYTsKddhdAwxOmc53Cu9u2BqWNA0VV76BBZAfApQ0qOnETw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DS0PR03MB7655.namprd03.prod.outlook.com (2603:10b6:8:1f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 03:30:28 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 03:30:28 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value for Agilex5
Date: Thu, 30 Oct 2025 11:30:09 +0800
Message-ID: <08cacb9328c338edb6a6f291c56c6d2c32a9e0cb.1761648711.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1761648711.git.khairul.anuar.romli@altera.com>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|DS0PR03MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e05a562-37a6-473a-f74b-08de1764ab5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfuyP9TyGJQNveWl0WkL1YF+hROIukrUViBu0PWLIw9yuE7SMAqzrNakfXG6?=
 =?us-ascii?Q?DxQcZyydw3c0pr/KkVicZ6qaRVn01R70oX1SxTyOnvqSdseypPFUjWCCnBnf?=
 =?us-ascii?Q?OxB6yxgRPnmZxDuKAWRjCoT9Hggavyp/op132cv5airFAqHO3ckYltXUmIYN?=
 =?us-ascii?Q?sP1mZBhlyTQKMckXzIOCwy3W7xFZJKo1Aeo2an7qvGHvfzojH+8quZBWJ2mj?=
 =?us-ascii?Q?HLwFbG6NhKkSDxJaFhgpXcAm/66/Eo+KhbsPsG8JRdPuU9Z1sfhqFbYK4A0U?=
 =?us-ascii?Q?p2BhlAvVDrt6gvAuRnplt2LkfrnuOhaNJN2BHnZZb3ng+JwaUdMPjRSl/Sbn?=
 =?us-ascii?Q?xpyjTYmamfvs7Dex0DCnyFAGFn5RvbNP94IicJAcsHAwdOEd3FefJS3JC2yu?=
 =?us-ascii?Q?ek57g7ajaQjUsmFj5YPaXRQEaSjZ1LUmOhWXHrn5gYF8LVKYPkdlG4aV8S9/?=
 =?us-ascii?Q?9VTXe+cofXDx3A6wgm3ERlz0rPBj21a9PU9UI3bGZDrVHpXBK9AE2V1FM+NL?=
 =?us-ascii?Q?ZG/e7Sk4VKfhgpgdfL62Dq4nPoE0945UxgjNVSH5Ted8XgN6V1E+qRxXwAc1?=
 =?us-ascii?Q?yxTjvIfBL492sWyPOkvVcYqJho0XTumNzNCmpXe2P1dmDWG3GWX7Y+71arMm?=
 =?us-ascii?Q?Kbl1TZlxlg1LLHUuiJ0EyOM3KLwIaktt478DzT5fEoVntiSsJFq1DCBdCGpP?=
 =?us-ascii?Q?tvKe7UY9wO5NC6THxdwE+PkomsJl78yv3X3x1lIdmICmhUOYrYiGxnO/HLhX?=
 =?us-ascii?Q?HFHI9Go1sbSEJ7Jj5rlC1Trh4NLr8GK1UDQNTBSU9T61fM+Edy90i4Vi4I8R?=
 =?us-ascii?Q?bXINPoQ7CMRgy17ivTUDSdA49KGU8Y/P9vwkIA6VVfIs8LVybu7oq7yOnYGa?=
 =?us-ascii?Q?Mln2Mpl+msa1LHxPL1HEp++TNSX3uql/9EeisOQbRy8GqM3SFrVx7zfsk1Hu?=
 =?us-ascii?Q?Z/lsbVBaFYIgarQ7ES13hPQl2Cz3OQs7brejL+Wh2ZSMlpgLrtWj8qTLBge+?=
 =?us-ascii?Q?+Z9Yo0jzCZVLw0J5CRPyFZz6wqTkKN0Mef4xcxd0qgbPamCu3TzZGY6XA8xI?=
 =?us-ascii?Q?mGF64ux3WQeuYnvoi4oV1AykZSFN+Avaf1C4V+6TKvQqB5H/7CRUVHk/0bkV?=
 =?us-ascii?Q?Rz3MXZN7tN67GLXHwnHUViB38IkM5XACXbQCxi0NCZLQBDCcNP+5iRztHdj6?=
 =?us-ascii?Q?evwMXOntOyv602cQPIN+FDSLo+2/ybforxgEbozzZ3jwgIP4TxNZ6ruBqSVM?=
 =?us-ascii?Q?FVDvi3xjo+cojoZP2WcXXfhX/6D2gxIvk66WiIqDR2tziubflMYzGJs1lHiR?=
 =?us-ascii?Q?tPY217m2HZ5evPGaToJTtOzYz8tOU1WqWczRrxwc/Q/IHGE62EhwANb5e8GN?=
 =?us-ascii?Q?pX0INyGHvaULXGNJjbQlfehRySWp9GWPCxuDtf5hEagaKZBOl+swABlH9kba?=
 =?us-ascii?Q?pLo41Xi3YVal/ZYZNHSSm4CUK9e5/kia?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEJhKgdYCEJ9ewqlhTOBm9Wj6HOftCPU09FAheWesuHaRD230jIistAaDPWW?=
 =?us-ascii?Q?3AEIy2OOKPlLlRFlOFaRm1ePh7Gnj53xzRLYV7jq/5I7sk8+87OdRhl083Q4?=
 =?us-ascii?Q?+IpDOsfKfoA6zin0l866uq8F1At/IaRCdolbIBNQXfPVXqHs+K3Uhg2AWdtI?=
 =?us-ascii?Q?rgB9ekvEhLyJsgqS9zBrfCJufLb45lyiK8PpLNLeKt1W2ZXi/yVJ6FXRlYOS?=
 =?us-ascii?Q?xsE3nuajdFS+MIVHkhQmgCm8L5ZRF3jt3adCYiDTYGidGYd84RqrsV1aAgmO?=
 =?us-ascii?Q?grcqVYG/xa8gEh7SeIPdPJQ9q/Nc4Qh6TBKClsGvcHloAAYaLmURMIWzas8S?=
 =?us-ascii?Q?vT0VKa6t6K/3jv04LniuTYy4sEJVXcLa5mc2xBhovug61s/pbqh1as+KhEKv?=
 =?us-ascii?Q?IjVx+GFNrL2O1XDLBWMCWf1KvE4y5HvFlycB1ql9QqzU2rzihmgBvQe8sDSX?=
 =?us-ascii?Q?WahKdpQQhvPTUg61XZJ31r/cBDVLkjz0mCdyN2qG6i7w9z6iSbaDmh+yTmuv?=
 =?us-ascii?Q?wQgKNvrzBx2ETXqyNBJjdiY85NTfK5zz6Lbv7KgGXon7pj9A0ohxEfNRfj8Q?=
 =?us-ascii?Q?dC3bqjfK+lvXipAjc2hR0LJkhSzh/bB2eMH+QQ6KwNBiFLp2H2aNxTNKKTyy?=
 =?us-ascii?Q?ghlvLwi1+L6wYlV4nfjUt/1HzZT3rgS6yCtaHcvj7swMIkD0gtGPvL6oFuwh?=
 =?us-ascii?Q?YkZ+IL2D14cf2UQ44fh86nEQJFo19PVW7PJ6ntUfWiYXOQ00YUpXju/yz1+P?=
 =?us-ascii?Q?nGoYDDTrLOCHX0ESIVVx7M8VoXTgP4lNPx6ZIBg76tZngvxM5Tk+WlrV77Qi?=
 =?us-ascii?Q?7ZnmKX7PN6iFLSkjIy8YM3WI+amlDLficfiSRqeXE4hr0jfGj2C5uY41wrNr?=
 =?us-ascii?Q?20XvB3gQHKGSTWYCR89R5GdMWBIN57L0RJ/WTTWxd8orf300/gy/vPojQ6qB?=
 =?us-ascii?Q?H250GKXb2ZA77zyRy+8HRmBpetyd49JgPh2QONZtOUpIQKEX35K2CNDZspVB?=
 =?us-ascii?Q?ovph6HOi/JFEo9olCVmjhe8g6WuYG9xyxnJH0ayB+r1Yd5dSsWzy0iL5KQnX?=
 =?us-ascii?Q?Uv/0T9bxZVySljws37wcSJEjBGwLw3iM6NCtIX9Tos0P2ghSw0SFe1UrAVnd?=
 =?us-ascii?Q?ThDBquL6SblKZgwjlY/bDKFjF6rCBG44BJ9O59KXVoT8hIPBOuPRD9ZTty9C?=
 =?us-ascii?Q?oaKLRoHdMZOG5acZevaQLvAsXGTL8x6JdueSL+w6BS9Pmg8gtncSo7BJaWbZ?=
 =?us-ascii?Q?ia2dbEbaBDI3bEovIx/mgEJ/n9T8jbCraZmLvH2/3T+Sn3D+Zqe8AwzN1hfd?=
 =?us-ascii?Q?aY7oRjoltuFhDWSz9ccDFmLFgJEJAIZgfUmxFhAh8nSWV1/zue+EZCg12NKD?=
 =?us-ascii?Q?wA7Ihm4uAoAcPFlV9JmD4gllpxII6VPLUCoyZwwz1tPaN61aOruX0h4Jj4U2?=
 =?us-ascii?Q?GBW3ciaS7frWqNEocKcqTEvWIaiywLQmdEOf0KRoJXpVdhBfMM0P4mTJCMjQ?=
 =?us-ascii?Q?/vmTduUmKx8BENL/qHyoiIyHm0EE3dUexoBLHmcyTkwa8pHTqMqSg2KQLi65?=
 =?us-ascii?Q?bD9QasIVVyqmZmwwq6EmUnW84aCaUbnY6/HQtm9XahaQ5HzbwzAXyApkI5Cf?=
 =?us-ascii?Q?+LgZgEY/zOBUiB8zKr62gqk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e05a562-37a6-473a-f74b-08de1764ab5f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 03:30:28.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72LGh0ECSpoyIqwi8M2CwS6PEXuOEXh+UnB54xJnll/T6epCw7gvDg57hpwK0zZQxtw9afqK5uWAD4oelCZZ9CPUoBPRflywQ8VJadypTbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7655

Add the compatible property value so we can reuse Intel Stratix10
Service Layer driver on Intel Agilex5 SoC platform.

This addition is an initial Agilex5 service layer driver enablement that
will involve adding IOMMU changes in the future.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Add driver compatible for Agilex5-svc
---
 drivers/firmware/stratix10-svc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..afc6c8b43e98 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1117,6 +1117,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 static const struct of_device_id stratix10_svc_drv_match[] = {
 	{.compatible = "intel,stratix10-svc"},
 	{.compatible = "intel,agilex-svc"},
+	{.compatible = "intel,agilex5-svc"},
 	{},
 };
 
-- 
2.43.7


