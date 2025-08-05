Return-Path: <linux-kernel+bounces-756196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA1B1B11B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC9B189793E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B2425F7B5;
	Tue,  5 Aug 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Zc6hsyDe"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC3946C;
	Tue,  5 Aug 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386419; cv=fail; b=gD/oY12pRfRzQfxvwlWY8CXYD25e/r8SDcdzrqoSc7nokUsiNoDqFxEMY6qov4rSO3Gm1ypCUAc8FpRMySu7VxXf/kTQvMot14DOWnxcicMmSD3cn88bp2D0TKuXlxn5oPyBUOL3riWMFd09TaI4z/ek3jh7BiYlV63Bk1J3G/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386419; c=relaxed/simple;
	bh=Aje0UQPmcpVckCzvzKkHURs2LDeSXvoqZNqr8OJc47Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OOtRsDQPhzNcohDeUOJfFPhNJeflzhZWjudNXExtV5qlS9vmtOkk0Fz4z/tkD2qn4ZDBK0F5k8blGUYannCE398yh126ocXNYsSRQwdnN2c4iyn9JJkqX9bJT71cAPxgoabdfNmlkBIPOTfMhWOfUdoLZz+bWnNcMzMa+82DLtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Zc6hsyDe; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+aP+Lufb8WFEB735Rb9SCMYBBz63PS1nB9vqwF2G2YRpU1hyhFx9DOQcB9uHVDkAyra547kuc0DIME2+mt0BeW6Btw/OCf5M/DNXm7SxSoyiLeocRMgLMTROMz0TuKQ4JjOdAEwmAUsJfBf8BpbRgs1/WhKhW4MAVPHQ7tgHjyKutkSvJpdKC/FBqb2lmu3Mn6krcBEKx5DaigdsGr62NAm3vuowzryE+EHlF1SnvD5xbA1Bj5GvEDBFEz4JW5u2MgCgRgNFDZhW5lCIQsgFpTIEXZyHMW0Hb7QSlq9mUyS6NZphLhaWOJwrFYYmDV2YbVFZmxigu25Cub+X1uNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf1/qe+yXmRFLABlb2bAp3X4Zm+J9HZPm6K3rTEy0AA=;
 b=GEhXQAYhzX/otkkh4ARzspSFNMrAENv/6SnhETCWScxvKkyQD7Bsj44F30p8gIgSz+JV/cTojmfFdpr8KZoGvFZiOxSGCP3lLs2oBJuH6o2K3lfcyFC8S0d6I0fRXT28v4URLU3XifROEmwmvoTAywnL6ImUUyJhYQG7ZaNvRr2ezNBcVLhRXtDpURTQWebVbRUgfhi6t6RTmjw+1IrCT1wSq92KElfBF9VluZBKvOda0FM0h8mDxrNjaFgIhWaVpiUXo4fVhnpQDZjhMgnUMOriGNt+7HqMzBqnu1/qDo/wGPmJHn8q0/B3QO0ZMYLq8IFvJ9iZLh+TepHUdkoCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf1/qe+yXmRFLABlb2bAp3X4Zm+J9HZPm6K3rTEy0AA=;
 b=Zc6hsyDe/RVB4abJHiqFhjbJONfraw6KOu4oZUK4Gn5HgWIqCTq/S1zbqdC//awA/pc2oinRH7jsYcFUcEx2zgaUzK8uVPyOtzohcMIJ/QGwSiFAvkf5LhSEMek9uoSL+oxwrC6AWYRc1qfKxReaBvzEv88V4TEATXpnQS7K/J4=
Received: from CWLP123CA0023.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::35)
 by PAVPR02MB10415.eurprd02.prod.outlook.com (2603:10a6:102:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 09:33:34 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:401:56:cafe::46) by CWLP123CA0023.outlook.office365.com
 (2603:10a6:401:56::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 09:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:33:34 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 5 Aug
 2025 11:33:32 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <kernel@axis.com>, <sound-open-firmware@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: SOF: imx: Remove error print for
 devm_add_action_or_reset()
User-Agent: a.out
Date: Tue, 5 Aug 2025 11:33:32 +0200
Message-ID: <pndpldam7tf.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|PAVPR02MB10415:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9691d6-4ba5-43dd-70e7-08ddd40325d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P0Pla1iGFpCli9t67s45odKlVOEuzNmdgNNhqsPCdlCRS534wD+F9QR2oIL1?=
 =?us-ascii?Q?aJZVO1m9MeZr2QenCSYCWnL1xQiGeuQtp30WtlX7R7v9qGdzfqkcPzvdqLtu?=
 =?us-ascii?Q?qzZgxZNk52ge+j45xubrQYjKj82Qy5HrNuCpeW3ndJADaWEzvCDzFswtpn/j?=
 =?us-ascii?Q?SJPuoMUN28mlI4xzdSEu9WN+EAvTN73IQ+MvA1WHz0Es4Uudrsj5ycq37yjF?=
 =?us-ascii?Q?WMTgstQWQDei0h/ZbZbd5sBRjoGsYxa0Csl1dMrHSfh2/nNCz2tp32s5CXTU?=
 =?us-ascii?Q?++tzzNXFqd9Zd6F/GIpvl3KmnIioO2aiWQWc2HnkT3DTrGBucbdaWaTJvPHF?=
 =?us-ascii?Q?u57FNJVZDBchwBe4/cZcXoxq8FvNQTLJbqJntyMuIUBINt8LIpJXW6U0+Pe+?=
 =?us-ascii?Q?oT7+7dj7Ne9SY3A4XW7FBocVV4snWwtng1TPw/d5fB2QlfWu9F/AWAv//7Fm?=
 =?us-ascii?Q?nNXvMccOGoamJE+3DTcwNjKsPdWHoe28PlNQW+9VOBXDw3IsRzZ1adtt+LxT?=
 =?us-ascii?Q?ncALfOTcxboQK2kLLoMYXZMsLCvfkl0fYQlHlnWRet8GLfYeA34B5Ik0phsO?=
 =?us-ascii?Q?UNEZ9wC9bBol1xaJzgAUoiMuKNxvKmdr6lUB8Cc9OE78nLKOLGeC0O9d1cP6?=
 =?us-ascii?Q?GpnzH2gtEOobqbajMNNK8djoJ494zh6JmNyCnwKgRcLswgbQo2cJA+zkFVWx?=
 =?us-ascii?Q?pSJUHQVGOJD7SWrXwdCJHRdHrREC92AgnBcrhidglJXR4sideaPiTMKI/bs9?=
 =?us-ascii?Q?RECvVka0v0Ibqz2FcAgGbwHaJd6nlHUo+tKqbeSKGRlxa5b1Y52dzJTMursx?=
 =?us-ascii?Q?tfyHrEuO3PuLUvTJa/sE5pbixZ/aBKtD2Z00JanT1ZWiK10jHZzcU7Kz3GGZ?=
 =?us-ascii?Q?VPB8mZuOTikZ3EfyOYebEkCv+UjFImYdwgYvoePOvTV0FtvEPp6k4bH7nXII?=
 =?us-ascii?Q?5bxEmJM4iBUEgKx2z+olECbKxFPQLccbQGDhE8PwnmtRb9xEIwVutyKPR1Qg?=
 =?us-ascii?Q?T9jawaGH5XeR4LNr9JZkp7OgqfQVEs+MZTdJQ9SnzOoqAD8OD/xOp+qxZ269?=
 =?us-ascii?Q?yJmZ7B7u7TPGGwYY0EvmJ4wz3V25QLEtzmIdtIHEGM/LQPJCur7XXP1tm1aj?=
 =?us-ascii?Q?ew7RFp0U+aNxBlWw0ovC3HV/0IVXF1KCoNwujQOKzEOc88j2ASIIzuA525xm?=
 =?us-ascii?Q?P4eDiTPlQ1yFPDMfq5Edf24lBNn4hx7TAO47SI9JT1G0w7B4x4YEoeSJ3EQW?=
 =?us-ascii?Q?IFdrhQI9T1rVGOFC6cyBthpP2yICpbYdiPxjrKKe93H83b6NKKO/Mv0vQFYd?=
 =?us-ascii?Q?Cmh+cE9jqRKWQw5921+/i42YnKr1ZifNJSAdP14ZqX6sBbMQh4Z2xOsSxP1Z?=
 =?us-ascii?Q?XqptI4o4QXe5WaC3qd9Rh3MeWqixriVP4l82ksYivDAJmqGqeBWCokNlLXmO?=
 =?us-ascii?Q?0+OXiRVtClE3DkSrlQjzGUnbFqXekbTSjfUy12TS8YQ0Krbw+ywUEJAbQKUH?=
 =?us-ascii?Q?rIwjBc9rOBIzemT6vgLTC/6+DvIrByC9m29kot1a3MIXgM0SxdE17Yi6ag?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:33:34.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9691d6-4ba5-43dd-70e7-08ddd40325d4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB10415

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

 sound/soc/sof/imx/imx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index f00b381cec3b..1757539a6a28 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -382,7 +382,7 @@ static int imx_probe(struct snd_sof_dev *sdev)
 				       imx_unregister_action,
 				       sdev);
 	if (ret)
-		return dev_err_probe(sdev->dev, ret, "failed to add devm action\n");
+		return ret;
 
 	common->ipc_handle = dev_get_drvdata(&common->ipc_dev->dev);
 	if (!common->ipc_handle)

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.39.5


