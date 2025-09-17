Return-Path: <linux-kernel+bounces-820972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22337B7FE32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644B8580AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02942DC35A;
	Wed, 17 Sep 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fWVXhKSj"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7A28B51E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118063; cv=fail; b=df2HMAoT8Mk4fHCYQIOfDBwIi0LNaif1Khexyyoh8nhoVTPOBK9QKwh8fuLd904pRNpSY17VSi1Kv3a63Spi2nbSxiFpmQ7vGGN1ydOXTI8UVATKtVP9ziRdgc7XWbQdCwB0zm6FieikvcYh+wR0gPHKeHffGDy3PiC//+Ok1AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118063; c=relaxed/simple;
	bh=x/AVriynXZDmsxABAb1PLThcn9f0JsC7G4xD0chOZ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gLQMcDGyZARHO0xILk2UnIXDPAxOPwuy8PF0Geh59STuZIYOR9oS4NcNJyKkyZ1SWeCv0gVnihHPpTwTH/yFKMxSfNp5UaEUG4bv067OBQOopo6o8lHdRIuOZ38suTZ97VS62ED11hyXj4XOpHXFYnvSU9VJtRQ4eiVe0MvBk5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fWVXhKSj; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj0dnr9QdM49CDAyS9ARItjkOp4+lunlkQhkQ9LBRqAW8brZtNtZnStN9QUPIo2/wQYlco41IVjaXAVpnqIj34Vm88ckrKWBaaNjTF7CR+tjKeB1rduZXtoC5W6eiYucTvL6OBGYY1BKce7GkOhfVcShhALChDKAtFCapMbUDQrbdlK1i3mIg7Hr1mCTkhfLBERSckFbicDznYDafU4NsmJB9XHEVvdMRl71hVOB22OZZ7s9Lt/w7g117R3ZBG6ndjDxZpGvqQSu2Wr/u9VuRQouFNtJigVe+haedvM2OBblBblBMc1K8eWztrT2bHUdUdJnDgwgBKw2oDcnMtqQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVzTBm/tI9gVEFvDmpDxe/dtE35WzaS9lWXlcTQESCU=;
 b=k2rAJwiMrdLS2tbzZ4UWUmO081NDCD+cQKvXDzyD5m53zwlpwEu5chrfgC7Ji+xTInu802N1xVUTBmg2M9H5H+CB7MOBGUUYbO1V9RyZuWj9Q5G2oQVjCIP/KZdkyErXJcEDnO4o3Nc2aSS6yPYclHw5KJCWjNJyTEZXv/3ujpdftY7HebMPcGUO4RlJrrE2S6uzzyIvAdPHKOROvrdKFkN3Jt2hWrs8vmh/88rc0op5xZkLKQpmDM0dV933XySaLRJzg712RSMAvgu58S5dRJpvtPEFkjSwj4zRFcJPNY3myMVY0eKJyID/5CaZX03DBcJTmHjSyJVLQEVUA+T+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVzTBm/tI9gVEFvDmpDxe/dtE35WzaS9lWXlcTQESCU=;
 b=fWVXhKSjma8DIDu8AgpUH1OLtV8M30YNv0p9Ve09r0g/QxR8e3BhOPkmSibfL6umb1Jxl8+KRYOLf1ViIcDM9KlNLTiMmBCxV6ZkcrXfvVKZ9zaMx5yOlpG9Ebw6rKqf5QPj+RzjM71HBnazTY/8CwFBpPqVI5iADe1MEalJ4z0cHhQqJ+zvth4qNvh7Xbx8P/YZ5IvGf92pf5uKP1KXd6TH81+X9QCwQ6sFswu2mYjqwcfgZ7uy8JEe6RRrUOgmz/j4CRjK89lrZDTHw+U80cE8pIk4pBqw5EhNVvwn1kBDV2kDv504GJCnpFdBKSMe0cTtYpYkwuenRVS5jYorUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10656.eurprd04.prod.outlook.com (2603:10a6:150:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 14:07:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:07:37 +0000
Date: Wed, 17 Sep 2025 23:19:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Harini T <harini.t@amd.com>
Cc: jassisinghbrar@gmail.com, michal.simek@amd.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com
Subject: Re: [PATCH 1/3] mailbox: zynqmp-ipi: Remove redundant
 mbox_controller_unregister() call
Message-ID: <20250917151915.GC28673@nxa18884-linux.ap.freescale.net>
References: <20250822045732.1068103-1-harini.t@amd.com>
 <20250822045732.1068103-2-harini.t@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822045732.1068103-2-harini.t@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10656:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b45885-861f-45d3-220e-08ddf5f38e65
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NkPV8ZZkuEKg4DzQN3yDW3fxFH45x2XIC/pw2HUk+kUR6/gcOhcW9/i8nRW+?=
 =?us-ascii?Q?Jt0i8QZW8I4EqpS56H7TOkNfYCPddVRNkuMQRimxAdu/C4CrNqmgvhSPWzJ9?=
 =?us-ascii?Q?mrsnEmoEQ5O0AEdT8eTBhsVmWMfMoH5RvZ7J6gAqQCwk8iUHIjvM9zfyCgZX?=
 =?us-ascii?Q?mS1TwvVbu+6bmv+vawzlZPF7WRg70B7XUgvB0dE4Dn6HO2TdGmFSQKKmrcmz?=
 =?us-ascii?Q?3MZGyP9zN25urpAOfvLTrYV0ikR3jsO8SZxwGKM4/QCHXe4QoRvpOToic9ye?=
 =?us-ascii?Q?FBK7QKcbY2ik6/d9IVGj55DBIv6OEztQVwv7f8i2jUlUo2AprLfCfrBq6exQ?=
 =?us-ascii?Q?6swX94W3UZgwznYrCptfGjXZhxwDNR+g2OiSMYUohUP6D6lpNT07zs+aS61u?=
 =?us-ascii?Q?mdauU16Ty2sxwLgVhzrcuniJ1ilS06S8vT16AFbrQasq6Vv+E/NMLOIykyP+?=
 =?us-ascii?Q?kqXLBMzAXjXIY+vmoz5RcKJRRhFIj9XcZOcqNq5XGK0ptBJvyZXii699XIfl?=
 =?us-ascii?Q?r79KBuoriEqqQURnbX2LXuSzw9MCKq+2aC5G8v6vb3CZktFy/fj6bC2i+Lge?=
 =?us-ascii?Q?JnrgWZU89q1q3HLBY+QQkE4XX1tkQhPlbepMUXHkLpzEeOpznOOdGXhkdHX/?=
 =?us-ascii?Q?KMB5EX61HZ30xNfSyhyNDDkUrzswLrYCGn/Wsm3AF/NA8I4tBKhBkCO1FkfW?=
 =?us-ascii?Q?MdLgfS+2MxHa0GH6RQLtB+FhBePzu/VYTm6teeITkOOXKq1ckNHqjwDSzU+h?=
 =?us-ascii?Q?gP0FlJvSKi1sXRueCOKKkx6w4Mm+AuDcStYojPJhiMovPgj7qabhqX8N8pky?=
 =?us-ascii?Q?5Rg3rcBt9rkaiaQgnp4SK0qs/+/QQUikTBS4smj+blRsjqTFxodImaoHb9Ro?=
 =?us-ascii?Q?u0ueeH4nRb5Tik59e+BYK1EFPoW3h5xkTLzY9TtmAjckyTec2CtW38m9SLvR?=
 =?us-ascii?Q?2ZA2EckgtyyqYz7SZt+/dSP5xO+ZagUivrzzIlr5ofOUIjcz47AhUmQDsDfQ?=
 =?us-ascii?Q?R7ZGGaNprANYO7HyeOVubws1nAAhxAI0zNE97t7JktokX0GTANuXu3iFQeLD?=
 =?us-ascii?Q?1DeuAhKYkv7/M9RgXuYNei7aSyoZMSKa/0F9aZ/4NTuWLNFXOBgWXLOM8E7e?=
 =?us-ascii?Q?T0H6Z2gtPdJSZqKCliFTdaXGb8s0Co3lI4GBPRCXwtCBnWXPc5Usmao2riKe?=
 =?us-ascii?Q?9vBdTifS7kWVB9dWM1dmrgw0Ijln6CC779kR1fhtCkuJSxqUf8QwCUQyRrNn?=
 =?us-ascii?Q?Bt/NM4qh/23cjxykWKItpO5yyMTYNcM7aNb2vgxywzS6kjw5+wKkZ+YVu3WI?=
 =?us-ascii?Q?zlH5RZS7YHs5pIaL9unAHCyKidrf1aKcnL+ox/2GOBjyfv8z39FVrNs+czeR?=
 =?us-ascii?Q?QtPagM6LcPRV+gJbQup64+f7Sycj9p/0jtGGkeHmUiTdRNyUN1H1/sDznhyR?=
 =?us-ascii?Q?Qs+CK3pUrWE594+LUSqgNevN5wSUlp2/Dps3EHAH52o75mV/09Jn2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G49Zj6ZXHxCpa0NDjWa/sGMelwMNmFZ0911R825tXWw3d4t+hoHQ+5a5ZKeH?=
 =?us-ascii?Q?Af4v3zjJT0q6fMc5dE0Zj4BNzfSk+5UtkJNQ+FjtHeZTZttIqFoQ8ECDUGBK?=
 =?us-ascii?Q?Me0EnVtaL2bIyDKZqn8h6AGG4aGQrTJ3lCSLfHKBAcVcgUE3n2uYunGbbVrG?=
 =?us-ascii?Q?AFveXUgf4m0enEvblpbKwgVkQ8V9OEJYBF1SKVlDocHNVsQ0pk1UKMHHNHoC?=
 =?us-ascii?Q?3EuUHTHTNmFzWo2RoMEEW+YWZ6jF2K2803mLgHSm7T70QbWVE09V2/bYcYFw?=
 =?us-ascii?Q?XPNCU8sgZfYI4z7JsH+p1Mrlo3MaJ0eLUGPIHClFuE02jeahP14T2nhnKFdA?=
 =?us-ascii?Q?wndJz9NSP4Xi2rU8vYgzoCu7HWnMC/6DBr6Uc8mpVpFs9mwfdeVmmD5Z8H9V?=
 =?us-ascii?Q?Y1D5p/ssBNyZohrHKrVeqEQ7Vsc/ZbB/hgEL8cuV3jR7nfJ4/aJqxOKje6N2?=
 =?us-ascii?Q?lYg3iPzsoHKB8Wcz7IornjKRgizX2WAI4pJULbt7x697/mwCa51ViCuk+U8t?=
 =?us-ascii?Q?651jM899q2WORggxGLlpbpwxsngndtl/GEC62bOX4++BDujjESa8OU2evVXZ?=
 =?us-ascii?Q?C6O2GoI5C3d8Tt/QcMbSU1FIFrydlkxoKhA2WpO5HyXRObpn5c/ySRuvOLmO?=
 =?us-ascii?Q?CYGzGmKkI1+WplvqMAntzqJvZHRCTEpEms0+WOJ/kWkQldh2vaBX65nLnoQt?=
 =?us-ascii?Q?Yhntnrfg6Ci2OSryzznqhg5ZtBKEuR8kLAgEblwOitncSqoPpGNCEfbHarNJ?=
 =?us-ascii?Q?1sTMRglOWSTevPenjUoPQHW45Uj48MkYWNVC/jD51lDp/mHMaqBB+cY9NwJN?=
 =?us-ascii?Q?fhtlNgvhXEeDcxOaldIscdsus0QbRnbsFWQmAPY5L//X5v5iQrPUYAXNz2Bg?=
 =?us-ascii?Q?pScLzHh/xCBvsJ6HbkHw9pE4r1Dxt66exB7MRMN6c2lUe1pzx5mUuGL6tM/E?=
 =?us-ascii?Q?IPJhZYCrLLts9X0tBLbHNjBxVV3ZKueinetJgDuNAGmtIkfHz9r0FpTn543/?=
 =?us-ascii?Q?BS+od9fcIz5EhO4AVM2RTowsO5kC4aMT9KeP6FRL5z+O/j+F+/Us7TsOtivb?=
 =?us-ascii?Q?6j+s6PMBrFqV7PdSNO4RMe6LaxF/rXBLdjgfHzUadcDCiQDwxBr6xKlJdWhU?=
 =?us-ascii?Q?8DsOQ8y9ALfYmuPwPg+6T7rucx0rU/8/8LxLNzDRvdXdjJkYPiW3v/CF0hj4?=
 =?us-ascii?Q?Kl2QtbsbachrM74OagB0ETsUDS0oRBnoQE0AVT4v41+7kRb7n31FRAzVrFDE?=
 =?us-ascii?Q?XhPTsYskOpG7TM99P5H2q71j/37qbESzcA1v9CiW5hFxVkdEU/BroLgKsYiC?=
 =?us-ascii?Q?fEXg+DHr/Bj5c2SfZsEdVrGj5TzBLP4T860pFRVbPM2BC/3qGwx0RBHtt5ZU?=
 =?us-ascii?Q?5mOMJ9e+KqrZF/6BpQs+97jGNwllgUm39XeNotNheP87bc9lNNih2D7bvOoL?=
 =?us-ascii?Q?Vd09TbUZrFb5h6bizKqwmeLPMGzKp9Spanj/7bNhQAp0PLCknwVaXgE2ZX4g?=
 =?us-ascii?Q?XhhyErQ7CdmDob37wGSWU/IZIFLypnZMziu6y78gJX4sTBta67wwc1E6dy17?=
 =?us-ascii?Q?W2qAKvfCod03vABKH/BBndJ75qdVuLknbGJh7Fea?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b45885-861f-45d3-220e-08ddf5f38e65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:07:37.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjMKT9X+SBJLAILWfbmwq5a63lOzi/6J6sAfmiVS8b6P7ZXOC/Ywi/r61aAse5bfy8X/OvgS+V33kazWQ23PZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10656

On Fri, Aug 22, 2025 at 10:27:30AM +0530, Harini T wrote:
>Remove redundant mbox_controller_unregister() call as
>device_unregister() handles controller cleanup.
>

Should Fixes tag be added here?

Not sure whether device_unregister to trigger devres managed
mbox_controller_unregister would have any issue.

>Signed-off-by: Harini T <harini.t@amd.com>
>---
> drivers/mailbox/zynqmp-ipi-mailbox.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>index 0c143beaafda..bdcc6937ee30 100644
>--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>@@ -893,11 +893,8 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
> 	i = pdata->num_mboxes;
> 	for (; i >= 0; i--) {
> 		ipi_mbox = &pdata->ipi_mboxes[i];
>-		if (ipi_mbox->dev.parent) {
>-			mbox_controller_unregister(&ipi_mbox->mbox);
>-			if (device_is_registered(&ipi_mbox->dev))
>-				device_unregister(&ipi_mbox->dev);
>-		}
>+		if (device_is_registered(&ipi_mbox->dev))
>+			device_unregister(&ipi_mbox->dev);

The commit does not explain removing the check of ipi_mbox->dev.parent.
But I think this change is valid.

Regards
Peng

> 	}
> }
> 
>-- 
>2.43.0
>

