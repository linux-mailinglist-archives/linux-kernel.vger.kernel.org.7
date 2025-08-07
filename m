Return-Path: <linux-kernel+bounces-759074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D889BB1D81A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945143B4A59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0653F25393E;
	Thu,  7 Aug 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H+Q9CD4y"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012035.outbound.protection.outlook.com [40.107.75.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704C25393C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570406; cv=fail; b=mks107CPP3FJwkAgKW9YlnhISfgw+D9LaboIUiRDyUbAD7V/LkW5Adb25LwXB/zIdQAywRfFJ0ZihS2kp1K9EbZyudtYkbiShDl0waBhwB3P4218Xc4VD5OaZPCnfEJGpKu2MQzXESDUypyG/fmKN2TjjOvNDUJFaPz7IqJ+WFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570406; c=relaxed/simple;
	bh=rPy1uI3Y9CYPUtyuTnZGZHgWh0YPQKfUPej4i/CGihE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lqNe4b2A2jAmSIqkRM4RuHlP7QUS5GlZSNM2P9oHeo4C+qpyekCLEgbRKbCrg7oOrOCTUjmNmVKB2H6vvelQm3fNzLH8lRh58Vv+zV5i4T2Kw0sLVl81jXZtCY/OxbOBrfC8so7ytzsRWKNTyUiLPZLn0jbhyG5mPXqWX8NfPAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H+Q9CD4y; arc=fail smtp.client-ip=40.107.75.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8iA+zpRtcwmfKUKmk0H+IU0Uwv1hOyzRinjxuXdxeLG9YBcQElSa4wZgGulspvPC4o6fdQQOMbgxBCrQ6kaZjwyul7gnt61yLl4BrIsu/QDy1yqGftHwUKmNQtQrrGJ1+TjQDKtkt78LLVLQycmg9ssFSEPnXLJ6FTUJoRxLgcFI6X+CCbYf611HCHu+DJ94VrQPMJ+T8Zd/+zITP9w1QI7xn7OT03XQB9RzDb8OrKs26X51jlnTqBPMS/ErhMwUCvu6UxgLV3n5Tpfmla4lFAFSoc5tsWe6ftiOJdwmSbzMASqcKu0+QFL1wmT76oFtiPRFg9NLDAk84XusYfxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPXowJWP0oo46m+HENSJWsEQQQ9iE8QfgZWjNgVEHqc=;
 b=zTR/4mq0oHn0VOgZy3pXAeDdLJ9QpMYlVgaM1N4XwUVWv3sERE/gc5VWQN1N6oyAz9C52vsKv93p+DKSKfQoYzEZGTsYGnqV1QnWqhTgdkboiJ0Wn1sTbFJD+e2rRHxRXpHNVwbivh98Vps6lDx+hajoK5pHWK//byaASXXn5jET0ZQZh5IDReu0AgjqyQDSe9HRn6iilq7jtJaj4w8a4iwRvWyTaboVw9rB+OLXWdpoWD+908+ubpvXeY/tArRmaUroBZxzMllueGyA6qvklwEz41AoDKuwC720zKPq4F4v2MVD2SvDw9168f33b3lLBPZhK6d0jrCMb0xLrLRi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPXowJWP0oo46m+HENSJWsEQQQ9iE8QfgZWjNgVEHqc=;
 b=H+Q9CD4y+XMCS4KrgcC0ypKQ5ukKEqx3P3J1S6zEpidS7mmNVmWOX6A1HEkBfdQQvjJrVAljMFIF5kms/vfdJ8TgYXc3zWURkzykGApt2dow+xFuyl4MKxCyZbM38xaMqt3IrWr/pmsEpqWiSUqyqmFCAT5/3/DIWpJdmkNwErBFoO+2NeBzgfy5ApLaJKNhh5YHqMpxLi+edkGSHB7EJN61TQJ7dYNJwAbXNWp+Iw97W6PKgOwSNe9+K2wcMQQeLTLXmq87chPFL5Cy4V3XUt9Q0lSK4OKuzLjNxVnwHdWKw9wLuJ9V01C804JEp+XIkyi9Z7QI8e2dQ2eQULIJVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB5574.apcprd06.prod.outlook.com (2603:1096:101:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 12:40:02 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 12:40:01 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] regulator: Remove unnecessary memset
Date: Thu,  7 Aug 2025 20:39:49 +0800
Message-Id: <20250807123949.495193-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:403:a::30) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a5c9a6-905b-47f6-d98d-08ddd5af86fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kve1/tomGK5GZkUnqMY3JNCKYI/sI8XvEjOzcA7rkdQXz3wCgrDjzsY15lNJ?=
 =?us-ascii?Q?yxbqH5ZwbwxLwHxu7f7a8c5ceBrQ0ml5U4lMq4Mb0oaq3fI6BzzLMDZ4ejpt?=
 =?us-ascii?Q?r66I4I9+7yLuot/QFECW8k7VWAGVQ4fBhzMlNY5GLBn7qiz4+NE6NMN7UF3z?=
 =?us-ascii?Q?6RireGLHnZ1vWLQlx0zcndhLF0sgyqZDcIP72iY5LDPI4lImxqtMxM7nl60c?=
 =?us-ascii?Q?whrexUmdDJ317Db7NF1cl4kUXQtiIsR5zvqwx2PqJaodX89OchytsohuZdH7?=
 =?us-ascii?Q?SGFKxslfEf0JO+3rYGRiB3EoSX5y2mROK8TuXwexuN7xtHZ4urFVRwUiUNr1?=
 =?us-ascii?Q?cWaei7jdx3NS0FppTKHkjXnQ2zreLkMdlscMSkZO0vTn4qhtyo7jBAHOF8Ud?=
 =?us-ascii?Q?f1v+S8Cc4hUY8OGR3oHDUjmP5aUTsMVxFQHUwiifxObuXarqQbwqA0YIvMNx?=
 =?us-ascii?Q?UX/rDWp/xfM4m4DC4Ci9PTP/IHhKSa+0rv+jNorKkR2ACFpPjUXShzgO0SUP?=
 =?us-ascii?Q?J3VOeO7tjOpHqxZ9mrt3tItig/rogEp+819FjW6u3jtTVO+8qgYKuFXpkTR3?=
 =?us-ascii?Q?zYDfwupIRSwHONFkR6XaLhpOOQfdbSd3z9QeEpmTu/ymHTedy+cX8xbJlcSq?=
 =?us-ascii?Q?MYtuEQNYjObUU43qWyExYPntbskP/XrCVS5yULEnydaiCopFcRMEYWXbMVGJ?=
 =?us-ascii?Q?o3QGNgKzBGHe2rjpia4RUeZD84wm02VNZkMLXPkkLWvFXqem4LEdNnq4qVtP?=
 =?us-ascii?Q?dVCwPDJCgc+6akhwKi7VnDrtAMNHfQOUWpMaqGsO6maLRlP1HGa7MVNsA5d0?=
 =?us-ascii?Q?QocfyaM6JEzWCuJxIC6rgSwvoxSK+KM5H0ExDi5rxxpuqFYNrASCJnG4N0L3?=
 =?us-ascii?Q?QynZ8684kzI26lo/2e/9prAkOypJqNyu6pQVUnzhedZsTB8ahwZQAOpL7nVj?=
 =?us-ascii?Q?/RPYfO1E0qrZPXHfMDRSS6Z11kWF/eSnwvsA8RQYHqvdfWGv3jR0NXv7WgLo?=
 =?us-ascii?Q?T5dxnIUjAkH+b3Qu86naJr1qMGiGPX+MNZgLxl81qmHwyY93COClOoOYx5Nw?=
 =?us-ascii?Q?ZPJkAVOulGAW8D9dJZ4dy/gQ3T6j3MX1bLqCnyWUDyVgEGQfPfXc5SpVn7ev?=
 =?us-ascii?Q?MMjUNTd7ipfVuw4BTGCFM9JnHXjR6OKEjl7KTsmxA/xSZNCu/JfhQoYucLsR?=
 =?us-ascii?Q?0Pzv0KydEGdYfOsVPJztMGdvYySYPZq1tmquxJOXAuS1SC650FImFotU+iAo?=
 =?us-ascii?Q?Wj3ou8Bb+3iHF9BTw5w80NhP5gxuErE04lARdzzp46LSPcaiy1DLm8Wv3pWO?=
 =?us-ascii?Q?ZAQRRtWgMYYPbAM2Oy4ZoBYcXKjsxJnhXWEm5eviGq0olsGC/ycGSb0mDs31?=
 =?us-ascii?Q?GCnrfLSTsfGq5i7LfY08AHs90C6R7bzjTiiMptEVkpYecDkMJMKudZUH8uqr?=
 =?us-ascii?Q?2tDTLcj80kskS6PCMCFaPcTc/MQwV91EBWQYQeRrIyKFD1m5Xd4DYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LJL0PJ03q0UqjFetqlX6uh3KLEg+c0MuXiYTYsFKxBX7ACWxmbWzhSVA4143?=
 =?us-ascii?Q?y49WgynTLDWfb6YsVaMbD5hR1imd6P3wn+4ZEMyplcOjQR1AJY/hLQbJsSfh?=
 =?us-ascii?Q?MhrM9YZrqKNxKYKYV0rHReQOQtX4xPDZwEmOPbYCLh5mrnDc9GwYqkQTCaWT?=
 =?us-ascii?Q?CsGTq++4KFQAfiO4M3oCXq08/Qfo+RKfi2lnsQsU9Feu6PORrBVHD141/E9f?=
 =?us-ascii?Q?bLKbBxziQWLg7zWSTN4G7iumk/PZJa1HnrKjNXtjIMwxq+5ZJT5lkSNIXflx?=
 =?us-ascii?Q?5SXmqTd4nBXhfDYy5VfpNw8bu62lYEwsORlaCMLjanEHdBMX9drSdoHVVxd3?=
 =?us-ascii?Q?soi3e1Uu9UitRGfOfe/ErAJz4mgo47p8e2nltVgstdEUUSVA6K4zu6LLoHb8?=
 =?us-ascii?Q?WTbwxvpVs2Af6PEfrsmq2rqWM9m+v4DQoCe967+gMTkhARxC8cyb+MB3IF3f?=
 =?us-ascii?Q?nJIzUufi1z0Tzxps/98JP0p7L/Ce+sC1PSepUCjsRZOu5zz62PcA4PjDWG1u?=
 =?us-ascii?Q?4Gu6X47tn/GZuRmVhZpieT3r7quJXzFl7tvUklVaj7EoVKF8j30c9QBIuS8W?=
 =?us-ascii?Q?/Y7pGMcv4QB3y8Mu15L/SYLb79nTieuNyHBO/UZ+r1UZvO/Cf7Z/vuPThJe5?=
 =?us-ascii?Q?Ez0NjhBbxZ6p+PL3ko9+Cyw9QEt3rFt5CsUjZmenwXaZK4FSFN5fwPrUd/7R?=
 =?us-ascii?Q?uORq0v7dK4TCwdoyDtU/T4F4dfMiwV/q4zM3X8VZzTAxJYZFWiLXvwjXtVYj?=
 =?us-ascii?Q?DwdBXmUavnQykD6oeXtRh++j9qlabDzYwkNca3oFj4axZvbLuoWAhKLctIdO?=
 =?us-ascii?Q?REDRgDhNlzC83OIkXYVztAExNpkCJWGemYNmjgYt/CMd1vezw/P/YXmzt9uI?=
 =?us-ascii?Q?78HANpVGrLqU6eMhx+l+LwyejYMC7Va0HxTARS0jOKKwulre6QnKvHWyAhRG?=
 =?us-ascii?Q?QB7OXfq0rMfG4oo2TnIsnZ9P3jUwGYscTlcf3o5sretGRI6tHl4wNlvFaYP3?=
 =?us-ascii?Q?Hwdr88zJDSKEn1iCE2EOC6pUOBx6H6APKrh31UKBnNFpfaX8MshDFxHPgDRH?=
 =?us-ascii?Q?DOcBit8uNfRttgw3nq1k/KiszYS/6cs0HAdL1tjDxP94rGeKLlLBI59y1dq8?=
 =?us-ascii?Q?FmiH6cPUmxQ+7qz29jg4qVYx+5mdAFN+9TIiKTkr0iWaj45Oos/vK+veUug9?=
 =?us-ascii?Q?055jDjwz0o+xz6GzfdBFUVPm1tWqFlY9HeQF7H0OYL7wjHbH3+1EVHrbivFe?=
 =?us-ascii?Q?O7EirYjpEQWMFMSmPP8CPN1ZMOQl2dU7miGfnhWlU+WJf0Fh3m7I+lyEYovi?=
 =?us-ascii?Q?BwiMMpSaguaR1pBXmtSoBQfchzyyGNCW92+AzDdjk53KF8FiH3zkOf/zRieW?=
 =?us-ascii?Q?wkqG49RDHYBisHPouOPrE9D2OYVs4qzktjSAILUslRVoFxNrV0+AeXcgy9gs?=
 =?us-ascii?Q?1m12dl+VC2QODT6TLhSxlGmz09qNkErYtCQX9rrwusE3SEMUNIJE0jrdokHo?=
 =?us-ascii?Q?Px24ddvYZRD2sIx/u00Zz2YBObk/LBij5N/qxQzyhh5Gbv8VG5fIbBbKDRUM?=
 =?us-ascii?Q?hpD6HD7kETTmfTQTB6zp+PZevvDxNKeuG4LzmMhl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a5c9a6-905b-47f6-d98d-08ddd5af86fb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 12:40:01.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/ljpwCNM+Uun7UcO2n9IPCW/L2sNiAUCi+DVnrBPS6XhOsUvcf3fn4G50KigCFhbb7LwaOIAskG1PquFfmliA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5574

devm_kzalloc() has already been initialized to full 0 space, there is no
need to use memset() to initialize again.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/regulator/tps6524x-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index 3fee7e38c68b..6beb51293e8e 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -598,7 +598,6 @@ static int pmic_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, hw);
 
-	memset(hw, 0, sizeof(struct tps6524x));
 	hw->dev = dev;
 	hw->spi = spi;
 	mutex_init(&hw->lock);
-- 
2.34.1


