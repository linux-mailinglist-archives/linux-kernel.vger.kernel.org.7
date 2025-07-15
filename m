Return-Path: <linux-kernel+bounces-731989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B808B060E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F9E1C4565A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73D34CF5;
	Tue, 15 Jul 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cxxoWd+w"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219186337
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588044; cv=fail; b=ZDVPfeKGMlJs9yGpGjlqsqtev05mB3F6aEEUfjRHUHMHWSq2TWoYcYSgDl4WTZ2eUik/MndqRcstWAzrbbbgrOHYs8s6lizWoBiiIYOKctqDkMQfVx8VIH/aNZenP9APrwubitGV9ePpWLsnb8oO68wDwdzZ/4hp6QofkdhzYvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588044; c=relaxed/simple;
	bh=YBtL4DwjwmAk9zm2WqsYU13QahGNNSlJO8rSx6mMrQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mOZmhpKF2MTNt1CjObmAt9Bzh50NBSffvhuNSrLM5dH0JkU8L9XStdIF+dwBrS56mbcT3rk0WgB/eFo+8JGmjG4HOHoTgs3IdB8nUjhdRsvx5g9Q1MIg7AmM2c/plSfdo/YoIju54WHNq587cZ4+wJbOACZfPhSQyRPuVz3M3WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cxxoWd+w; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYDYzIwHPwVRqYZhKOu06YmaOYjSE4GGNBGl8cxir9Ify4n3vQmRGfIA6QsM79DWr/54Ni1nIiYjQwprFceLhtHc0VNKEe1nruyllKmRjsFYKqV9EDO6N/eV08mAhMvWoT5OznhSUkH57wc8aQiw4Ep9D3sh97V1EyYpvoU64YsE/quQ0PYFCLlhpTtDhzUBstQwujUoMTRw9JQWP37F143B1A8gJyFF2aHqGgyfibaZJCzfSD/vTgOyfrKv7LB+pR8qNzeRRMj1YNviGqVEskiYbaGYljM06wiJNY5RWO2UUEoxW37fRUWyTIO5upg9cs5ULFI8xn2BMKyWXmETHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UENvpeoM4YSfLfQEmsPQ8ZWibAi1Ci21rB3OLEEM4c=;
 b=otoiUe5J8a9cOkgg/XnND5A/slx+FE0bHzyRIOPaOcEw2XyzgqjxJYeocTi/7pT3JdTaRIjI5buGRojEqxaiupsic1wChBPVCjCEusXyL6Ygz0XkoQaq36hmudk+whUQ+PeBfUgWbkj5k4GNkVF7cm+WXcsrXE9fqn+KfxzuoGGabdQHAxYHN/XVcw+vyte6E8YrxMWlGMry5pT9kXqzobJ9MRDYxURMifKVsaf27AtiMe4qS0vs9b2CRBd8QTwU54hZFOdqqGxhHKNU7UcpfVkSaXsaKHP6LAbL1WxjVU+FtuGw8Q1VOKEWGpKW+LnvN5MyuMXFVPTeH+83XtpjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UENvpeoM4YSfLfQEmsPQ8ZWibAi1Ci21rB3OLEEM4c=;
 b=cxxoWd+whVau7aZVTH/HeoiQ/jjsft6FUFW+YM0os6EdRY8clgqNzvupAUGRDMls5yQXZ8WAVNUvgd1SNH0O/1Tv/yRXyvYcb1hxveCFbzJj3fSe1hefGAMNXH3yU3fWuE7GvbOmn11UO5DzULSBSKehsgrc8WXzHRlB8ZiadAxvHGeFyLL1UStxl6rBpC3waCluezIC4+EkvwCSdh3yEezFu12fcM8Kp+02mcI0YLKUh7TNqQjuSyNb1imRgvLzp/W8NPDgvZ/hXirwLm7rR6rcnO4+i2Pqt9Yn9iT7Sr6t8jTjwun+IsK4atz9mHLWo1M01/i1L/zTCWaQjrcOrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 14:00:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:00:39 +0000
Date: Tue, 15 Jul 2025 10:00:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/80] i3c: master: svc: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aHZfAyDyeK6c0U26@lizhi-Precision-Tower-5810>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075416.3218647-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704075416.3218647-1-sakari.ailus@linux.intel.com>
X-ClientProxiedBy: AM0PR08CA0007.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 284d80cf-644f-4950-d5b8-08ddc3a7faa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BRXR2GG5xBAZcJ5FSZCz0H0BhzHUYnx5s9BGV3LWEtv8GIm9CV7f/q7e5R0W?=
 =?us-ascii?Q?6WuDQoAQxnOES/iL4QFwDNKOFLcP3PjofpJ7AQL84p6IId3H/bSktUX6ptRF?=
 =?us-ascii?Q?xAt+3omc2QAlfggpUb1sTL6vzp5+xlDzhUY54mcHT3XWlfZzKQI7r7dUYT8K?=
 =?us-ascii?Q?vGxwQsxErX5yAEZK6qJbmlKvSCFB3ORE+cqO5S4dWGqzXffg0jK0mtmM573Q?=
 =?us-ascii?Q?l5xxut6E2kDosWinhxlrhcSWxQ3L9LFSX4n+ic5pmc6rvhFbZXokueYIVF+i?=
 =?us-ascii?Q?7tkNHG/iFU1ONOHtEwTHS1FGSFUvVaxeuWmk5dEXVCrBaU5fNcdt+QMrd8Iz?=
 =?us-ascii?Q?eBDRBeNA9LemEUMIq7sWD5mmihuRUsA2qPc6alYAAY8vqW+hbOmPNZUb3OW8?=
 =?us-ascii?Q?I3useWWKvAqITYi1iPQ2tf+qKRkPw+CgUyHccXKH/CTqZ9Icw6gk2j56rYfD?=
 =?us-ascii?Q?rt8RGY/G625DeUK1fObBeuYhOGDhIzHu8nKyvRZ7sdo9F93sfORpUeQ6rn2J?=
 =?us-ascii?Q?Xh5Rt2dzEtFuqQiaw0DZCqOvMZn68gh2CukIwjnCOfWTXaSIq9+sGTtgFafB?=
 =?us-ascii?Q?I2G0Sg9hZHSe0UKfiPpJQYlFPOn37Y5eeSuZ8vTcZztLnATnHquDqxukjXaF?=
 =?us-ascii?Q?l9pVHHwAZ16e4+fk17BHvhsKigJYGJlqT+Yaz8/f0vVWXEbU6kPpry9zQkTQ?=
 =?us-ascii?Q?01ju4HvtTjpDRRdLTZ/LHfnX91V4IoqiP+iSO7pesDNROr72GwYEljn56qgB?=
 =?us-ascii?Q?s86ZMzt7J4egJv0scesVz3mf2J7+L99uolW4pMydJDepIAgy0VDm9RVg0sCO?=
 =?us-ascii?Q?OnSBvav0CkT9OaiSWEAnTjRxG6Srbto1/9b6m/FpaJuhG8URUNS/D3MEfRMd?=
 =?us-ascii?Q?j7dbLf/1Qb3J9SUFLVZqbKU62ZzUeRdUda8VdKqG+pWfD3+klaB6S75kjqJT?=
 =?us-ascii?Q?8nK1xoXELdcPwHUBmDTiVSo4BhZR5jhIqKO03kFp+TLZP7/HWzZU7EATDKhw?=
 =?us-ascii?Q?4Tp+noKVmkgea9oo1xpp7wzA+gHWJsw3I/4RG4S7zQGCY+XYRaQDZtZ9YlxB?=
 =?us-ascii?Q?HZl2Oo4IgNG9NM1Jq+BImQi9SaiGaLZhVIyPXd2qmKiBC5gkgKA3vsSEQ4RO?=
 =?us-ascii?Q?jMTbd1DWjsGNJ63/1WrvFgQ4jZ3HdSA/KhIYD1t7nlOs6tx/OVkecGDPvH+S?=
 =?us-ascii?Q?07iNjtpEcfzCsn2Tzt685s/LBMVi0eP9sOQv5enlIOXy2DaZvwdfEPHJVS4D?=
 =?us-ascii?Q?h91kEnn99OLHe8JAMVOtG+hjRlONZSFstRsk6GPiIcqOB4UUA4GcHLRtwvrU?=
 =?us-ascii?Q?50+iCGA+YahYCFeYUtgo5uiOJhOPwj9RzkdMS27wDfw21qd7hEHO4kDH4w0h?=
 =?us-ascii?Q?h4QL93qmQK+95GoBn1i2y5NK0F5NPwhLcwYipleIRnwIMn1mk8UUv4NiPz03?=
 =?us-ascii?Q?MBcoWTe6WKWe5IkbAVE9knFCNy8orkEuigqIpNaCRKedg7LtAXMwxkwni9aZ?=
 =?us-ascii?Q?6GHKnK7f2KdqE+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/m22+p0OQAbOZFo9INDXkPC4baEUEsmM6vH5qnLMq+e0W97KakGqk/nIdQU?=
 =?us-ascii?Q?/xYuqet+b9Z6K87AksmIz9ST+2wwQ1dooF4GG8nwju8W2Ik2dT1fwGQ6ynPZ?=
 =?us-ascii?Q?XxK99u+A/JOavhSxMMd084yuN/A4snYR5lH8XVeo+kgncab82QglclM4jEbm?=
 =?us-ascii?Q?isMrItEOiVyJQd4uEqrkEB4kgTh/Xq85piekXkBEsAYnbjI2gyYaX4mxbfJ5?=
 =?us-ascii?Q?dvImNG13h/tlV+HUvEbOQMQOYk9ndozjDTXDSOhXevasoRx7+OE2JWNSt9xg?=
 =?us-ascii?Q?+uf/xqySaw/laSFxkGxeawy49auAOPX76lGg0WlOXRRGwurJFRDnQ0N9q643?=
 =?us-ascii?Q?6AnIKvjZt4m+nu8LM/iPxcisk7tzHpOpzKiPCg5+IHCzHTrOuM0izBkDb3aO?=
 =?us-ascii?Q?Y+2QjcGK8mhbJnnn3lxnx7nmg9yhaIPVAH8TsRuUqTYbX5XTh/ZMTUH3jADh?=
 =?us-ascii?Q?9W2zNnTqJTe/Za+6niXanJHEScjUga9Lj4N73atkw/+eEGi1/jx5T0ELE9ub?=
 =?us-ascii?Q?1IJkhg0nauOTL04gR2beR+1vZlUkuinJWR77WOOrcxLPYI0jnf5IA71WfhkJ?=
 =?us-ascii?Q?zl0SzlLFhcnb6GdGOdb+KMSjnIMYHm6/lOz57k9626SFb+dEo4vgFgWJ1S0x?=
 =?us-ascii?Q?htSPlc9UjjNpZxoh97Cro/mnttAzCniGPnsNhzmZNXYuBxvjcYpJGRgcoNEi?=
 =?us-ascii?Q?ARjnm77bVqBh62Pj4lcTsBTXNB62RK4qOe6yuldSjL+onBFdm8iSpP8zk6Ex?=
 =?us-ascii?Q?rWuCJnAz/Vtq6soLgRxfjHEWK3g54JsY0zgsio6A/bquN6hO/iYbtI5H5EyT?=
 =?us-ascii?Q?5jq3Kc4gfswgcYFQdNI+jEPUqx54Y0sbzfLJbWwulwnwGLv/b8TTbRB2F+aJ?=
 =?us-ascii?Q?KFRyG0kueA0JWmAR7rYQxDoTnnmOVGF9Ohzi5SNlXN39sPZ7My6RgWSogsZC?=
 =?us-ascii?Q?KjmYuQDyu3tqpqXV3kYC+FKVbX+0737IYTN+FoAnISYylXkf48JIhzydx07h?=
 =?us-ascii?Q?h8UdKToT6/6fkYisrSfClCem3NzS3aLNsmEXwTV/O9vubU0gFVJMOEPSIcaI?=
 =?us-ascii?Q?anQatgqtLNMJuYdYETygh7WnQHx4z2BMWH4Ne0JZvghwyMoXUGZLtpROqpi6?=
 =?us-ascii?Q?obqIcpR/DNonN2UFrq7nast+ZFdM9LTvxCD/kLBeMQ8CVsnGu0ttn3itKuZK?=
 =?us-ascii?Q?KJxryNr0Z2GM4bv7tbcG6G6xfRuIwQ5MhrzpOO1fg8/MmxMwo2kT9v4adAHA?=
 =?us-ascii?Q?gSPkEgn8SXmE3yX58VOdKi5SPttdDGvPxn7m9fDFwweT+eEH3W2Vz+RjubBR?=
 =?us-ascii?Q?b7PNYp7FhBWxzOBBjdh8zKXc0EysVh2vPbjRLthAFInsRyRkSrIrnf66zUKh?=
 =?us-ascii?Q?zsFUggUeH3XAkqYzle0LwaIgnloDQMy9Je0HqAPuyKFstjA5FIbpTvbJmyMy?=
 =?us-ascii?Q?FJTj2wVXMaEvTpp7C1hIqS8z5dCL/8rlE/onKAQoiCf4wIHOQH+XNcqb5icI?=
 =?us-ascii?Q?cFB22CkkwZtLy8/jGcoMJyMQFiWubEOHUxUBd3QwxNmrIVJt9kDoTdzne4m7?=
 =?us-ascii?Q?z+fwrLs6bXdcM6Kmrr0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284d80cf-644f-4950-d5b8-08ddc3a7faa8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:00:39.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4J4skh2z1hFXDlyeyuVA0snxlObUHqBYAuQlIwf4Y4kpwi0NphJ5HM5f0vD2ezCtPoV8k+uSyH880n8a707CnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8590

On Fri, Jul 04, 2025 at 10:54:16AM +0300, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
>
> In brief, this patch depends on PM runtime patches adding marking the last
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>                 pm-runtime-6.17-rc1
>
>  drivers/i3c/master/svc-i3c-master.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 7e1a7cb94b43..4f68005c47d9 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -664,7 +664,6 @@ static int svc_i3c_master_set_speed(struct i3c_master_controller *m,
>  	}
>
>  rpm_out:
> -	pm_runtime_mark_last_busy(master->dev);
>  	pm_runtime_put_autosuspend(master->dev);
>
>  	return ret;
> @@ -779,7 +778,6 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  		goto rpm_out;
>
>  rpm_out:
> -	pm_runtime_mark_last_busy(master->dev);
>  	pm_runtime_put_autosuspend(master->dev);
>
>  	return ret;
> @@ -801,7 +799,6 @@ static void svc_i3c_master_bus_cleanup(struct i3c_master_controller *m)
>  	/* Disable master */
>  	writel(0, master->regs + SVC_I3C_MCONFIG);
>
> -	pm_runtime_mark_last_busy(master->dev);
>  	pm_runtime_put_autosuspend(master->dev);
>  }
>
> @@ -1207,7 +1204,6 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
>  		dev_err(master->dev, "Cannot handle such a list of devices");
>
>  rpm_out:
> -	pm_runtime_mark_last_busy(master->dev);
>  	pm_runtime_put_autosuspend(master->dev);
>
>  	return ret;
> @@ -1511,7 +1507,6 @@ static void svc_i3c_master_enqueue_xfer(struct svc_i3c_master *master,
>  	}
>  	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
>
> -	pm_runtime_mark_last_busy(master->dev);
>  	pm_runtime_put_autosuspend(master->dev);
>  }
>
> @@ -1801,7 +1796,6 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
>
>  	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
>
> -	pm_runtime_mark_last_busy(master->dev);
>  	pm_runtime_put_autosuspend(master->dev);
>
>  	return ret;
> @@ -1834,7 +1828,6 @@ static int svc_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
>  	if (!master->enabled_events)
>  		svc_i3c_master_disable_interrupts(master);
>
> -	pm_runtime_mark_last_busy(master->dev);
>  	pm_runtime_put_autosuspend(master->dev);
>
>  	return 0;
> @@ -1954,7 +1947,6 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto rpm_disable;
>
> -	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>
>  	return 0;
> --
> 2.39.5
>

