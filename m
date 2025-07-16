Return-Path: <linux-kernel+bounces-734129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367AB07D68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A07505D67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393EA29B8D9;
	Wed, 16 Jul 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYLbpH/U"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA31275878
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693066; cv=fail; b=H/zZYVn3M9sHN7YozIiPK2+xCPenEbeXvS6G0ha0Ov0PpCkD069tVHRrBe5Nf7kWy1qbUojqYkpNkKp4IRhQG64y0FUFPK+dyFeFR73uKvmaUqI5I87IXkBCqrBJ65UyIZZPDyWPOHr4zcL2J1AcdA9FwhJHWF1BjZR27WHvb98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693066; c=relaxed/simple;
	bh=oXGs6/ZcPf0Y+HDVX3k15lntVtymch46/U0YE35iWX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HndWiUSOMDvR53cFXu9DsYnORPDuAoErAiMArZLjB6gkFw+3e7lE3cFKKHLTY/4BIxfgUlrxyoVfuwgO9Hy+v3smg5hzyYlwi/vM3SvYIaGw6WhIKaI40QSyZUl5b2Sd0Z7JW2uN9J2dpUM+JHGV6x7lwUBHCPnZqXUN33nudTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lYLbpH/U; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEgeLDSc7YtFkZcHhTrAsOVuv9gQKi+JAacut17TCfYgnGQqU//80LYgx1x/5vyb8Kn91tEDoq8BeDRE1Nja93cQN/rOSGyy9jHQgpNkF9FY1DdOxc/W+TMw4fLymDMUg2/T1VFOhfJzfmvhvvx5hvpviFqhwBfyuNZUN57jYmc02DWX97GYTjr92QwI0vV/ixKFy35h/O2+QV4BH8DNbcOS61m0xS20J3JymHfnbDEjJcNCklfm4neFH3LboPH0HxZ+vrahf79ywfTW7IaAyMfZD8zkU8wbeqQ33wGWEXuv+wYeAbPyH3V4QGIAklOMaUfdQE9pZH4J+QMlBd1Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtSwyEGWAv7asfIyDfjmWXZ/8Mf8bEGxY2XJ5pS97bc=;
 b=uvjt1FAfTrktDkZS0VyKFUCwCYTwjyaljwu/mD0By0srQcPnS0g+gCixgF+xlNHKmsmHqjkGfPF5jaXZVSrUfXo8wPN8YdWKZEVJQYtO90/Xb+8oepHTsei592FzrlceGeUZeCgMhcHPkXKSXfEfOtmUvJjzCeyB75AQIzh9pW0ivt/j80arwAb/XooVSgn+/+NVhm6DIzTxb9pMaCZUTxGeGHQpPvqXlBgmB1OL/djFmYk+aVFJh+NwXKkC2pIgT8f0G+9kFP0JKEM+PihiGgzGUmFhjbTPurzMCSxd+5p6Y6iAUctMXboMb+MjN7DnWdHNX7zwMtObHcHN2+vyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtSwyEGWAv7asfIyDfjmWXZ/8Mf8bEGxY2XJ5pS97bc=;
 b=lYLbpH/UvPSsM67Dak/IiXkgNigIbBKHPH/Lp+GAei/4FZo+hSafBGfe76oI5GqXrn+18cXL+qTgioa1NDowEmrhMlPbo82mja7ukfJjJw30aO+o7HBQSxG6aHtkNxzlD52J9W3kbWhQjI2ScbzLXxmeqC4rWmm60DJ1YS4nN6b+GeetNrLp1wP9q8wW+ttWXmFi7g/SuVKSsIp+qnvzamraUt8vUF9/MqhdeRYdJnY3aGVxnZLx67xwYwiUGgEGDLtA3Lv4jtZ/ciA+FYt6WaJex5j6BrjiAd61fbXmqemp2927OZ9Dmr7VEiIoI0G16JtxSW4IIsZKBjI4RUAmQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 16 Jul
 2025 19:11:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 19:11:01 +0000
Date: Wed, 16 Jul 2025 15:10:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] MAINTAINERS: Add entry for i.MX94 DCIF driver
Message-ID: <aHf5QhwhPul05Zvu@lizhi-Precision-Tower-5810>
References: <20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com>
 <20250716081519.3400158-11-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716081519.3400158-11-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: AM9P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: a654f82b-3b27-4781-a21f-08ddc49c8120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dRwVU+yoP4eYeUP0kDBtcDu8tY0XxJL8JDIAFFvOOgSFjce1KJay4hCuuVje?=
 =?us-ascii?Q?Vl6UCS8pqZObtF0opB/ZkTzWyyc8wIRN2pRJPhsYrl+QiMdWXgIzbuSTjGLi?=
 =?us-ascii?Q?7iNimBgJGdIz8rFriQ4oE5gn+8AnHVeCFgOuOx/Jp2vqmQUsnmwY34+5XAgh?=
 =?us-ascii?Q?NUeMQ0bbSrG+SKoJ6EXK+FikyflR+Qz41WibY1rk6uGNYgkiF7yOAKBODCQA?=
 =?us-ascii?Q?h6KBOAeVVGoAxomdKI81TKNmhr5OpxE0htzkWcwdy4+4TLpYNJ82sa51/zN6?=
 =?us-ascii?Q?xFsPJKigsy+iIHKLSzUNjRuEf0yzNbOr0UmkA8kqsnhAME4NOoXpF6GXJps1?=
 =?us-ascii?Q?TNNd22qupcwG9v9nsrOle55tUyqGDHlfUMBIxTNecm0DDymLJmZNSV52tQY3?=
 =?us-ascii?Q?4RvTGs2dwKhFKmpCg1NaL9ZAWsVCVcZKCSjz20p4MZ3YuLjD908NY5awKCST?=
 =?us-ascii?Q?rdR0v2mCXB33UTiDEoFmhGm0w35FTCIiE3JGUEZfqr3Dwa+Ks7y+87w1GRhm?=
 =?us-ascii?Q?CCT3dMKo8RDX7YuT6hlQZSmrly6wq5TpdkhRWwVm3bxiy8jE9sTeW45nwfTi?=
 =?us-ascii?Q?8KV4QDJ3UyWoyOGpB2jsoV0kwuYO90ivVz3me4RW9c2Ba7p1IJKmg3ZpllN/?=
 =?us-ascii?Q?kL6+/5bvd2DW37y0/TmSHtQYrFVQMbfNhG0F9mDVvdLsHjWnx4b6uK5krud6?=
 =?us-ascii?Q?YOUerkGPPupPFv7V7DzSPN9ecu4LlQhOyBP1MsE79ZfNRy+hUcEwAuUg+feD?=
 =?us-ascii?Q?FU5+xrw7PW/t0iYxvsk4W/T3Q2cRSmRL2U3FhFSKBatGesm4DAG11PYhc7eA?=
 =?us-ascii?Q?TO4KUMEvcG/5bt6rlqZu7M1xVWnY3iTbsYyJBdV+L2b4SIhDfr2oNERqqpLE?=
 =?us-ascii?Q?WumAh1PDwpLGKJs74UmgwWsCxBqQQMzq6vpmT0Mi1p4C2HUECWdAV5guE/dv?=
 =?us-ascii?Q?9iSkMJPH/P1M48Lwo9pz/pXlsmwiF8o9f5JAv6NeagmB203s7XfQveyFVrsW?=
 =?us-ascii?Q?Iy2Ge9ZPnuEwzTqlBRbXwtWsHPLPSVSz+GEdJfNChDx34fBJVZq51vpCchGY?=
 =?us-ascii?Q?PXFXNw46Ek+Bg4c4jlD673JKb8ZjDorZWQ62slg4/RBxyjUJ8zheJyNGQyce?=
 =?us-ascii?Q?nyzsrFoAnY6L+v17JMHWvGpLSvs27qXq4w7paAr2nFxApEas1saVQZ+0j4ap?=
 =?us-ascii?Q?njCCxm/ZsEcYYTtM/NX+jGst7TdSUppHLyYhZbR/kjWGENoPA5Y1z5WTS1XB?=
 =?us-ascii?Q?Kw5QHEvHvl1wQieNVa2dOBkvdnKrvFhNSY9DGl9P0lCfzUC/AFtGK+BI8HHY?=
 =?us-ascii?Q?w67ZxTClWUYrCtkR3pfVjaPuUQjuGM/f0AJF+8OUe8774gGvr1rBy23pgf/R?=
 =?us-ascii?Q?zkLxbKwWmVvVNpAijgwe4I19/qKtq5TSo5pgPAU6qKfD/ZpqmKnVAfdBOHL5?=
 =?us-ascii?Q?Uu35LMGcKHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QPI3ZlU6exxkhPAsawB0f+P3yYRe/BwZUn/Ss5Uksr5imUd/miNN0UjoFi8p?=
 =?us-ascii?Q?+kCR7aWO0ICgH8+liinCT8BrdvP+ceyCro58hV7vnLdQIgvEoyd+gxzLnvhB?=
 =?us-ascii?Q?M07cIjoMQywxoCDHVWgfsbpnOWCPlWGb8QfWxZw1aSUcaU+2mUS6Kp0dGCoN?=
 =?us-ascii?Q?hzWAbx1XFkXGyGNdOVPLLvqxx8FnGR2MNpDP/jbgartbEqsvmbpDqc98p+QE?=
 =?us-ascii?Q?1ovWUT8bwwXAf2MrbIOx/CYuUb+eC4UzavD6MzBA/JUwtf2ADxX/H0ssy3yZ?=
 =?us-ascii?Q?8GqziL58I+6oTgd+Q4b7sFJq9A8QzFo+s3fK2Jy9fgTFx+CQZqADrPzv/nKa?=
 =?us-ascii?Q?Z3mfA9WEMJ/G44VrzpBDiVf5nUHW532zzFzfRboByD7RZEXyS8g6ROGf35Pq?=
 =?us-ascii?Q?Vi557HKWZJYgFHnma4Y7s1WlC+6LlKZtCtZwLaU/jLEnvuyta9DmR4kovCpC?=
 =?us-ascii?Q?0B/WiQW4VI5XOA/njxGf5JgtwiRYr/4Ru3qDMDyUZ/oAPZSNXYxFXWAczHiE?=
 =?us-ascii?Q?nCcd/9D+a4UU7Ddy2RVdt6g+9/okWABTFb+AuZtHFQcivH6vxNskgwhb/Ldn?=
 =?us-ascii?Q?Z9kCZlqkp0UoxhZZSYzqLGT9xZ51cws4hG0YpdT8DQTLAEBV5uzRwHE/B+/X?=
 =?us-ascii?Q?9RRFhXtOQnJ02fXE7aag2UnCvRY1CSDraQlBuDeXnO5ISg58/KZk9LIVqpQM?=
 =?us-ascii?Q?oEw1jEiRFxALb2Yy3oRXHegXi/fc+lfrCw9EPwKt82RUHK8bnoNOi9w/cw6a?=
 =?us-ascii?Q?tQsEMtXny9t0dQNeUS8PD503WwOE7PflgOLWMTYwCqMn0Y1Xa803Y8ruXqmH?=
 =?us-ascii?Q?5UGVsxHITfBGM+m4CxBU+jVMSWrDy0DtcKsEilGrVtjFGX0FzEA0QFZf/AKP?=
 =?us-ascii?Q?R0PMXqo8b3ul2/mqe/3OFIkFEZWVNsGmTe81oikZCgEVyk3H0jfnJJd1d2LR?=
 =?us-ascii?Q?ViFOtAUu3kOn6+6xrQYZwV7Tsf2gFezFaKWqXHYvOxF7Ujgni/SNYZlTxsOn?=
 =?us-ascii?Q?t//2XxcTf5GzPwhsmgtMCUUtG0Yppvar0erMR7kRqt7fTkyXCpyJuJI8Us84?=
 =?us-ascii?Q?E6UV4DAV/8uLxxgV/K4X9FC1YFoDCJQTgu4TDyE35Yd/OBXUxl6eTey1fvFp?=
 =?us-ascii?Q?pszJjDfTwIzrxDZqw3FmgfLo+LvdbVnhj+4RPPHzUEc9wCfh7ZVgRVZ+o/fP?=
 =?us-ascii?Q?VhsVGuTIXMQqM5Gxx/cjWPDz/s4tm9B2mO8of14OJrDqWN0jDST3XKNW42ks?=
 =?us-ascii?Q?rz+ByjnDqHZNHglS7BZisIi+VTCsJcW4LWhLeA2B+XglxjRWjNeKUGqtmJs5?=
 =?us-ascii?Q?yVdivhBDC/LJ2z6LXmfhHDZaIgcUeZlqF+IH1f6hpxCHnnoEunWFI0P5ZpLi?=
 =?us-ascii?Q?FTsJyDW0gCWyBAV+yxMzZZrFw4dM0rGOBMT3kwnbMS40cre0KLWJu3dOzg4R?=
 =?us-ascii?Q?Y7aLjTzCsSsQ85+r3dYk1SnTynDJP0hTwwB8AaSTSImM9aBWRn52y9NbgY9H?=
 =?us-ascii?Q?SzBdILdh0DMxR2w6oKtjU4TBBw2/Dt9Jx0eVhlBw5OonRBXhCrk0F4QN7aRc?=
 =?us-ascii?Q?XCH0L1AIb454tKKLuTL2HNNt0bIvW3tO0TvqnaZX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a654f82b-3b27-4781-a21f-08ddc49c8120
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:11:01.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lcUvZ06T4hpofn7CpWBjaBIQVMVcoVOZiCcNdIarSQ71Ygkyh1bDy64pYQ5VGRMlNeW+affvkNUdBcoXjkgMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

On Wed, Jul 16, 2025 at 11:15:14AM +0300, Laurentiu Palcu wrote:
> The driver is part of DRM subsystem and is located in
> drivers/gpu/drm/imx/dcif.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3b849ed34fde..89ce22c6a8862 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18130,6 +18130,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>  F:	drivers/media/platform/nxp/imx-jpeg
>
> +NXP i.MX 94 DCIF DRIVER
> +M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> +L:	dri-devel@lists.freedesktop.org
> +L:	imx@lists.linux.dev
> +S:	Maintained
> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:	Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> +F:	drivers/gpu/drm/imx/dcif/
> +
>  NXP i.MX CLOCK DRIVERS
>  M:	Abel Vesa <abelvesa@kernel.org>
>  R:	Peng Fan <peng.fan@nxp.com>
> --
> 2.34.1
>

