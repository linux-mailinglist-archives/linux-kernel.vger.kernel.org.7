Return-Path: <linux-kernel+bounces-777699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120FB2DCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A834E3C93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ED8308F29;
	Wed, 20 Aug 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CXIJJNr5"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012068.outbound.protection.outlook.com [52.101.126.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E22EE26B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693626; cv=fail; b=VTMmQKCvKnE/yev3sy9M6/0xppE8AKeZxAiHe6lcFHX0mRK9S+6Yx9fwb6VBL+dif8Bk2P2sh1IGPsK56PVRFG2frHuk4gyCQO5bQ51jCiRYAHnaPr77KsslBNG2nf0+/S8gHxwHOhSnnZWbKCymbOs3PJrLO5XWIMrOtUNeuds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693626; c=relaxed/simple;
	bh=k0u4bmw4ZqUX73Ugy+/k2wHs90jrLmPkZjtECI52atA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EJle9izBE58c33aqu4/kMMfcnKjAwyXRSzeVGYDswssCV2LoNpf5nm1xp8QdQqKB8Ti7BMzEraW+tZ9SN+CuZMW7r3NGjwVK2Kr9flljFXYcOB8GFJmp5pR4wMEZe+1pkrum9q1p8aPdbKu0lCsCIWQBbjQeLU25SXiPi5/FIro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CXIJJNr5; arc=fail smtp.client-ip=52.101.126.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlDhvBRL+davCHrEv5SUhvjYp/8wn4kCoHH0k837gDea9enQLOC51oqiRXj6/EMtto//FUopYK4D67v3DldCrmysDK5PWMomf0apEi8RIMYKl9BC4EIkdysNMrJ90Nju+GKmLzVGXoZG2PVGrCr0m8oo8yewkW4RhIDf7rePP8hX/jGeoIipChm104L/TmfDilNU3/L9EHbNlGjhtCjSFGUMkonPFkbuHT9RfC6TGQ3J5KkTO6XSJ9/nhu+M7fgsodqBljzMLgA6cJqLRzmZZGcXho+4dwKodM+udpXaggFlwSBKgkEVgCSGNfZBexxtHnPborV1e/maVlfkaFbm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bcj/EcwI73UthybGcbCcP7r35oZzP2gnrLX+7yhrO24=;
 b=pplKr9ssyZl+4VxPu/HpnSCAAG7LwsCdNPcKnuWyLyBRVA0xB8Ictcft1XJCLtK/I34Qr5ntCuZhFFCaagcM1pSh68DN+OtGpJyaPWXL86+hYLk8VuDZx+41lmrKDz+XAyd9oR6ASkq5FBYgVj9UXhqjx3m+ZbDWEAkb6CpJYHrZxyKBJFLPW5pEyLlNN4ErtGtpf8JmTiArgQL4z1fG6O6Si7O2JQD4Gn5Ba8p3B6njRXqbmQItE9POhmG2PovSHtFeHM3zeCj0cSOFd57Nbmc7kBEAoOwmBlR13kLCzkbz5shew64a5H3+SywMX9lCVeAYKbyRA5KlKGDbRCZMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bcj/EcwI73UthybGcbCcP7r35oZzP2gnrLX+7yhrO24=;
 b=CXIJJNr5M3SNXuTJiA5cO54wPxtroJsSD67fgqsMEULAoGfp/DBcW/r6IMPBQ1Qfntwdm6HZMZ9Y+FzbwFdH134QIIbL5FObdijC3PmTyRr4kFpHVtqlmAC9dI+weOdazD0VP/iEhFcvHku6Xaxd393ksExv15DeeVBip7q+kqRKogmecKfGFwc+72ZOQ0m83/KlKijDnXRQCqHPIaqFgHbBsp+WYf7J7wG0MUdDOea24K4FPs10qe60c7Kvu98YWy6YNy50rRMdXVCTzEZdQodWt350+9lRhTZndF+E7RwN+APe25kPy8hy1xVWlI1GILY/a0lj2ug5OWe16D/IoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB6448.apcprd06.prod.outlook.com (2603:1096:820:f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 12:40:22 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 12:40:22 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Brett Creeley <brett.creeley@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org (open list:FWCTL PDS DRIVER)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] pds_fwctl: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 20:40:11 +0800
Message-Id: <20250820124011.474224-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 25755bb1-7a51-491a-f51b-08dddfe6ba40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o5KNVFNU7y/HZkbLpoTB6dE9HWqSL4tu/hCH76DGOHd3iudphMLWFBiSOPXt?=
 =?us-ascii?Q?O+G02RP1nmH3OewiCQKJR4vOaOWXVIMfN2n9P+C3XAXkFBmjb4yoMWd84Vfo?=
 =?us-ascii?Q?EDlhBycptRZQfOvfKl5xUTVaO1igRyr7tcF21V4DTTh1eW7n/WFtYl+4Z1tr?=
 =?us-ascii?Q?8MX0EIU5ebQ1XiGzxDpeLHTjLzGytv8j6UTvvUfpaXgX+5RA6K0sHRY1e5OX?=
 =?us-ascii?Q?yfULpoP8s7ovnAcDgeYUkFfCJZnSoYKX6VKoiC9AE3yINb512tumWOiFwgW7?=
 =?us-ascii?Q?lOwfz7dqkBOABKi98v7C6yGrtuyst10O3/pU9yLGKZHADhoGH5254X1IBfis?=
 =?us-ascii?Q?Z5z73BrRHAA+MzQlpqDLW1G4sZhejBkW8Wdm5L7aGVBRIPN5TxAPONEtcMMA?=
 =?us-ascii?Q?TnahvJ1TUcSoB00YaRZbpWibC7LE1XOcbN1y4zADXrzWcbSDt0Gjg5bhMAoo?=
 =?us-ascii?Q?RAWK6+Inyayd5atOoGbq7YrEK5b7vnbA1DaIB5VrRoXof5EIrla0O5lJK3+a?=
 =?us-ascii?Q?MlEl+P6QwEBvAjKDHz/o74+YRs/8nd2MBWITrkj3E/GgRYZgjzKKDDIbJIN1?=
 =?us-ascii?Q?HlJhj8gk26wTlF5rqVXov4j8aGwixDGD0KQTFzCCwpTk6izGikwcT+qmCa3J?=
 =?us-ascii?Q?sTDqzMkX7VTRuoKyx1TwcKBy/1qLdArJs/SOgOlOLKvb/pO446CALnssXTyG?=
 =?us-ascii?Q?vrWA4ipExUrwOcR6NQjhAz0L/oxPYULpcoHRhdfjogycnCVXksJuFUeKt9of?=
 =?us-ascii?Q?tGBpma8tqA7ufl1BLv/w+9KCRPTxmLw0TZBjpFBhwyOv30JkG1lh2Fpg2gPI?=
 =?us-ascii?Q?1COvnaoNYQroT2WAkp/rXK9RokA+VPkFMw0ktGdQYnwKtDmaBs9I1sE6HpaP?=
 =?us-ascii?Q?WZpmR7aSl0mr8x7V+vhHBcphvbluB7b/KP5POqkDWjvFXSh2XycQSu6qgnCL?=
 =?us-ascii?Q?HjRJbCqDRP2jMvOHFZF+E7Qasq9aXfRUjB23bOkawOKg64uGeMu7NpfeZ6HM?=
 =?us-ascii?Q?JhCl2Bm7itSBP6d5B/oRE70qP5GyQC8+RZaCo+qvIfnlI+E0CptfIHc1UdK/?=
 =?us-ascii?Q?zzmN5eceG5pbq2PevmlJkuMaJL6C8hpYJTdqmQ1UYT7oeBLff2Q3aT7qBCsf?=
 =?us-ascii?Q?vj+/1da2oKs8/rnaqBjFop0E2iiltKsoWJjCDZ3akuQfpPQUUAtQNoDzLQY1?=
 =?us-ascii?Q?tWR5jtsGX7BqVvuwzAbAHLInLPZfZDpOCZHnKOhdNvTJquHmkU5p3e9tzxsF?=
 =?us-ascii?Q?OyoFsPDQqmlaFiD4Pg9KMGu93okSF4GkacpI6Rzd+oVb7ekLm4b/INKop7Wm?=
 =?us-ascii?Q?E1VH5DYc+DjRFCf8ZVzSCcrJf46a6zLb2IlGYQyNUjgxtCvpZJCjDu+5Kh2d?=
 =?us-ascii?Q?7r4cbmDXobV6LBwnC8ReARnovJPuTnTN0diyDQ2kAW5rd0NaE7ZJTTB/z/xw?=
 =?us-ascii?Q?jDX2TxKywU1xvJ0uy5+LbHIbmOgCNpaBo9xcwM8kYt5IqP7SFmugGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rlqCgf6wVws5FaJgfJhdY1zBH4cCXiYqkpuWltR/r6AEx8vs33GCXUbXU8Rv?=
 =?us-ascii?Q?PboXvH7SKaoet84Tq/ri0VY4qro2uGvGzJM2arbeRzmCRoWfl18Y3R+RaJGI?=
 =?us-ascii?Q?HuNoKrFdWAU0Sprmp7xXjRjmFEmjpmGZ4rpJgYLhhTuTvPK2+kR6XvjIs7Tg?=
 =?us-ascii?Q?t84ABXRhU6rwzuoHoMGj5wWYLuRMCzlV0DPLXNN1f/DX175Hwl5veIptMXdc?=
 =?us-ascii?Q?C2pyGQy5tdOWT7DlayzXCbg7/pxbZJ8tdr5suEh09RSPz8pXxywyZHVrNUOb?=
 =?us-ascii?Q?6ZFE2fcWN4WwpCS3rPfF14/VnHJeNgHUH7e8HoQU4bAGN5m0/gdu4jwokwNc?=
 =?us-ascii?Q?ML6PgTxRLG027KODbj9MQ8gXxrJ5QJacet5HRNLAmL2/grSdhuEDj4OgisJj?=
 =?us-ascii?Q?f2sjt054dqiOER0GMW1FMll2a4RQX+t067NaQTVSk3T3n2zDeD6YEYvBxBrK?=
 =?us-ascii?Q?YViXGakiF17PM9CXEvfQFXLAOiwGQIvbol9vWx/uk10uQB1xvtDOx/4EYt+7?=
 =?us-ascii?Q?0HfnVcV2DxAMF1MTIkzZp+/cOKff9ojTsWOSXFjrCTEAPhC/jPRXmhvXgjSy?=
 =?us-ascii?Q?PgEhTY3yscadVe2I9ZWcGK/h2oaCcgpfkktIVbp7Y+I8EWpFqqOwjXlsEhEe?=
 =?us-ascii?Q?WmecWbq84ntoAWkVKCVmfOmGEquv9XOjeUV4IQ3MyDcTVz5YWHQipKnFVmDe?=
 =?us-ascii?Q?zA/X8UG8ROjqAsQEZgEpi4lCt1OmLasP1xSgpdlhAqfhNyhRpiEwsAUh7SYM?=
 =?us-ascii?Q?k48//MAp/kN4c8bvX8IEGKlZuy8fC12cD/4j4PEE8zx6MczGCRmjLTZ3XaYJ?=
 =?us-ascii?Q?VD5uFbGvw54wnAPFehyu1T3BtihWsUOxn//TQoxyuQJeMjbSppQGMj0gh97y?=
 =?us-ascii?Q?oXvMn91i2+SatNPtW0QJPUTejOONXYAvh4hr8FvcPPDsW4HLOiYlRdqAvXlF?=
 =?us-ascii?Q?qUNcj0SvTXX+4OES6cZnIQMspTWvzwNCOOZEXYzIcpz4TwiJx+P3ayMHwbHe?=
 =?us-ascii?Q?nS4sZsTcQpVkYdGsEdGJ9Qe+FyCMnFPjSQTHtcZRQb+7l3IOo+Wy0Q0P/9PQ?=
 =?us-ascii?Q?gY4jwmdewwuKNk9e7LS3VsHGJ+cTIlD+a1gZQ8I0q/EXsYflkm6IHNwVj99L?=
 =?us-ascii?Q?6lSlQawp02yLv9AwZoeo6/SRH/SoQkJj7ADBq8XzCdfFK/eKPqMrlR0YMYAc?=
 =?us-ascii?Q?epcxVRqna3EFhnf2FfOZ+qlXqRvyXuB39VePf6q+TR5OxvcpCeuEGrg9eFn+?=
 =?us-ascii?Q?NX6gyD37DLgimLS5Z4MHlTHvNPTrWrnm6BGA6dl7Njfmt3MyoHZ8+SVKReCF?=
 =?us-ascii?Q?EB6QXfiRqUSTd50gPacnYn9sv/7AfDTMS/6ain8jncL2RxLpLnpGG1MOgGiJ?=
 =?us-ascii?Q?7G4EVscP8YvGdajIyFDt8Ec8LfKNFrycD/kWUNMoHmMtzbByZA30zpyn38jz?=
 =?us-ascii?Q?3AF0hdXpSJKAlb5i1SX7iZ7cQnYAc3w1fPqCZzJDxUG1nhV/HoJNWuYfsT/Q?=
 =?us-ascii?Q?KIsOn3NI0GwWZYgluNxFB6r7P1zeG0fqL2TX3uWUQubgqOfPnZs36sItvBIU?=
 =?us-ascii?Q?f5BrFWQ+RgVgLAq/F8SQzeffCJfqhDDVoH7dxtkj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25755bb1-7a51-491a-f51b-08dddfe6ba40
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:40:21.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHg6HX07pg58CaLuzGqogmY7fBBhd9WpoH7RIOkTCVzfM6JQfPrm1KkkvGaXr/sww0wI2p4XoLdFE/Kp5T9Iyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6448

Logging messages that show some type of "out of memory" error are generally
unnecessary as there is a generic message and a stack dump done by the
memory subsystem. These messages generally increase kernel size without
much added value[1].

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value
instead.

[1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/fwctl/pds/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index 9b9d1f6b5556..8dd659aee256 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -481,7 +481,7 @@ static int pdsfc_probe(struct auxiliary_device *adev,
 	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
 				   struct pdsfc_dev, fwctl);
 	if (!pdsfc)
-		return dev_err_probe(dev, -ENOMEM, "Failed to allocate fwctl device struct\n");
+		return -ENOMEM;
 	pdsfc->padev = padev;
 
 	err = pdsfc_identify(pdsfc);
-- 
2.34.1


