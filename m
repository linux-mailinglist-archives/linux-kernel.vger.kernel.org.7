Return-Path: <linux-kernel+bounces-810490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FCDB51B44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 160FE4E24F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888962571B8;
	Wed, 10 Sep 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TvNUSsU8"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F00255F53;
	Wed, 10 Sep 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517451; cv=fail; b=XiF+1pl5cfe40nxw/sQYxrHuCVT8QnjLOKBo55ccjra7vQH4bU19YfQwpZDa6B3umXflTvckSbwSeCvMoHHCnUKBM9N74BzYKFLI7KDTgxSE7YngNDOZIdXXBXW2e3XGxmDX6Ms755GcLwEAiKFzdN49GwiutTIKfC2I7vyAZHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517451; c=relaxed/simple;
	bh=zPEEoYoUAZkC5csII9gNtvdpcZcaXUk1Fs2M8xyG5VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z1jceslkSjdEkV8cKMcdb5jDrBBM0+aiuhoDLT2Rk/05vlb3OBMVF2fQFseeeKtOvTutZCfrZeZbzV/2Aa+Ycyqej0EW7P5FSynWW/1Dd6tLXs1GMqUFvPwI6QiXZZ1lExjCFidAD0CZfcoBGLfg9Ao++FbJBVYyAGwqe8YYOiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TvNUSsU8; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McPXGeBazfYMOViSwwEFc6brjp2/KkRjLJ8pqXerNJiQ6tKQRK9brGIpipLQ3LoLwT5j06EuV6JRLO9gOBu7nQRljV7i1yxQW9BNscE9v3h7XpIPvUBAOfczLZEAf/mtnRtkSN0UNKt/l+kxvBa3TNWsLE3Xnat985ndHoxtFT7sbRK6ZYBDWQ6/ZHKxeeZW33NQJpCcK2F+YuRR+qjwJEH0Wb7+fsj7it8oLToza/Vg85BJzQ6+vu0fKFZ8h7hnaJhoBgT3q/qjG3AfkStOEw2dnGGK8TqGcaT4jAc6+Clim+IfMQKBLEOhgBG9NFkWT25o+tfyjFTtAufHqiKx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vga2ATxmTWJ62QWz4hTpMPr59RWYSl+4XuvDRcV+0Hs=;
 b=K7Wlt5ZVNz5aP7uxcU1xHutdw2G8DYBERFfK5VU3vhZp0dd804OlWBwdVjjocKH6MoU0os9U5AmvE2uk4v2o6BMnzJWzCIpfXUk/YmoikC88xqKdbqljnZ+UKcIbGd9t8ayMhTyBfIiUMA1XX7NMPccMXMH46cg2cxTVJr73+WM6Z/kAOEGU23YYYBLkf9O1N7lGyXplGzHoSJ14pJ/oiUXdYIoFvhndsTfhm9OIVTDfQH/mT9Wvfi9z7PPjxmGDxaS0Nt4hweqHmpRjgPkkf2So8PBq3eYwoo42Wn7dRqqVwl4lZHYL5y2quzRUSqFaML7TRDdyCTXYPf70q21aWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vga2ATxmTWJ62QWz4hTpMPr59RWYSl+4XuvDRcV+0Hs=;
 b=TvNUSsU8pU6W6CdxCRB923UyikMw7DjheB6i7etLNRzyq8aLQ0lbv3XWNDqWDSSqJRHrfcryQItdlRKS4CRUjlHbUqod8hsOQHw6j+F4UqEZIP2oD+Sjn/EjD7n4yWz4pbEve9EhTvR+JHW1HE3XlekvFgpR9ZfPiXG1SpNdx3WjMdZiTzO7fvx+HVXmqY4VjkzLiVfuM1v1ME2x61FYyIMnWmCdiLsF5CfWhP4icOgXjm1tQFcWmEbuiSsLa+3VGDRfUxAY6CJKEOc/RoAVDhIeThDvSc6O+zx809x9IMsKbjjMVoSCC4PXVsonLrRAC1Ag0udJ0o7VQsAWyrXu6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Wed, 10 Sep
 2025 15:17:25 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 15:17:25 +0000
Date: Wed, 10 Sep 2025 11:17:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Message-ID: <aMGWeswjrsJDiBKJ@lizhi-Precision-Tower-5810>
References: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
 <20250910-sm-syslog-v1-1-5b36f8f21da6@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-sm-syslog-v1-1-5b36f8f21da6@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: ec323b73-ff69-42a4-1544-08ddf07d25ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kFIGVsAFQPvyIjKgZMEgEVylpgnH8P1L/Uk88gQ2P8zndpcDWhssai01YxZV?=
 =?us-ascii?Q?w/84FVor14BSh4cJ/sTVnYUX+iMyVwU+fb3NM5PbuFu0MMXka3yvKt1wgGxo?=
 =?us-ascii?Q?xzxJXpq4vOFxL49mAjcOksZqUzm+B+IHoP+MFDl9txpoWYF+6ioQkX12pdZ+?=
 =?us-ascii?Q?ou2YpLMErC1onIeOLD8i0nbSW2+4LzWEoeT/hOclCaDwEI6dwpGG6iMNeVxc?=
 =?us-ascii?Q?iLiYlB3u4scwQCkaD9EjSAYh+xHgCK0c1ZY6bBGOZFV3iHHlNgt2dNa0uYKt?=
 =?us-ascii?Q?QH2F0M3Y5m111IrepNf/visx2ktCW6li8jdQsKhExpYSKPMiiOgmDpnygbx1?=
 =?us-ascii?Q?ktJkjGtk7tSZWO77JsUZW99Ow/3lHRsvqVS5OqwKFVFtmELtoqDVDbAvTu7o?=
 =?us-ascii?Q?YcYHvjruw6K8sxi8KjbzK5loPDPiIbTZlfMoeTNpzIlZUXL09x/1W3U9aa2V?=
 =?us-ascii?Q?NgXzbJWBrJ+vV3jagxCw3xAa++s3bbc60wAE/yPtz9Km8woDGNaYjgCbWosE?=
 =?us-ascii?Q?88bk75x0kMqdNVk/xVif8UoyYCsOM8UOnH7dFBmvJdniHe8J14AmfNXEBtJt?=
 =?us-ascii?Q?G96efxKHYAMUb74iGyZuaqGY/7S3NFfdd6p8zTLHqipc3hl18IU3LuFDpa82?=
 =?us-ascii?Q?jWrsZ4apAmVF7RiHQRy1UnqTBUQBuzgh6S2patMxpEuD4Nj5Ecmm1dkqSQFK?=
 =?us-ascii?Q?TVegrEMKfNIgyHvqYhSIUr7/hiTBK470yzUlnvgtCnZyOSgfCYREQo1HAnfh?=
 =?us-ascii?Q?pr+JXhum7sOc0hRv5BzM+uw0PDsrXVZek10q4FXImWT7DrrnJyHTNjRgnmhy?=
 =?us-ascii?Q?kS/YcDFkih+z2wV/S27uAybQDS6/J0Wj8wvIao/MY7xTTMh3FmWMq12EELr5?=
 =?us-ascii?Q?SkM9/AYhmgkSqkM2tIB3VX+WZX2k2fuX9kZQLvz5JM1bLTITrIWSLW9K0clk?=
 =?us-ascii?Q?O+eqFvaWVHqhQCDg5We8Dh06MExOPe00ycCh/Y7mGkIIQeeYW1h61snVTS9k?=
 =?us-ascii?Q?dBnyDbz3JYkkejfPGIqOCW43DY6MUddWvq/yajL2yKvOeL1RRYD7eeIUgCQx?=
 =?us-ascii?Q?OXaSh5W/Go2qR9mhZ8ZPdaLTv3Of0cy3hdQxIOMtLYTuvT8vNKKQw2ZzjcYo?=
 =?us-ascii?Q?IkUKKwIL4gRYN43CUtoXuDMpNlg5XULbo9J0vqpBmsomNPjoNMqsY0MF5S6O?=
 =?us-ascii?Q?B2Vj5YMMHNku+4AkQkYET7iSQAq/zp0RzEzWRJU46L549gV/SFXVVwkMskly?=
 =?us-ascii?Q?4BEBBHjfKbVgBllgBZbEn+wC/gFpfkayGqX48YH5x2YihYj19QpODDj+dzXg?=
 =?us-ascii?Q?bzB5JdzmWVnqLFNOWHJRogg4/6mn19yiCqNYiRyxwBi3piJY88vmUIf05AAK?=
 =?us-ascii?Q?ngPcShefMagFbPXpV/TrKCZ32RTmzo4vfNb/M6tDODOLjJS5pPxth4q913Jl?=
 =?us-ascii?Q?EJuRGAFQQYe5d5+a/QHZwfkdZIRAeG0g/9gKy2EIrv3eugGmB36Rs1SBGsBj?=
 =?us-ascii?Q?0lhPga/yuTTdZzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tmj+6e/cp/PwAwiOgRm+yQjAM7KVf1FX0e4p8MP1XfV02MlhN4Bfb9V6kE5E?=
 =?us-ascii?Q?+ZSOkiS9taa80srCD3G/WMtE5BzaALPlWEUyMGrHAENnMEUAj6f80TdXm3PM?=
 =?us-ascii?Q?Th6DAe5qq4Wg/V/UuEZcSzvXZ3dL42YOiGTCs/5bW84ZkGn9MDkB245Bsy69?=
 =?us-ascii?Q?lZkt+nx9xcS831dCrmO8rIICJbdh3nAfTV0wKw3rIL50ZJtM5nS5L8vgunCK?=
 =?us-ascii?Q?EnikcvZY0iiCpyD+0J0ksiv49US/8tfliQd8XOilrTyF7/7DOX47ZzFB/FeZ?=
 =?us-ascii?Q?lr7Q1tG+hkb2wIwKD1n5s2dAxikkps/dACAlXR4eLy2BqEyL7lRdXzdemV1y?=
 =?us-ascii?Q?/c/jDaCTwTPtb76864hKPObiYaNJKDe+rfAx3P0/PIEqWvHK+fj6PCYnK46L?=
 =?us-ascii?Q?4DhqEBpvQRSPG1q1KjELaJT6l3Z9dEgevH4JRGtLYNiIma2nDK95yIPHMuAz?=
 =?us-ascii?Q?4w6BrqdvhHViqpsRY/0DVRSIuqRaneHEEgUS0qs4N4lmI7VSqVt76qPRuodf?=
 =?us-ascii?Q?ENLA0r6PiBoGaM+YaIaAOUsMJaPbcBuUGr0z/beMFYbYFYXCsm1IOIGKpVpf?=
 =?us-ascii?Q?lqlvg+9HU7h1uYwcn2EUtd8i8Gwn/dEOyzR/hQG4loYs24jEZMSF6klopRN1?=
 =?us-ascii?Q?xpaXziHsEjD5SmNl4wZGQuVF16/auhsw2l8qAWfgIQLlJrFQ8QhL4iiNVa+F?=
 =?us-ascii?Q?txhJzMud3Im7tHRVsYYnTUesWBWDa/aSyMjJZdUbZ2GKbX2iqoenxZJm4pg6?=
 =?us-ascii?Q?fPS9KF7DqFjgWZyqWH6prFeuHOtFgu0I1SUfhuPLrvQK1M54165Gr645Ts5B?=
 =?us-ascii?Q?ufJ2U15+iV1/PRj3azHDvyVaYLmpEVmowzYi6Jd0XTuaYQ/GJ3v0cRzCsXwx?=
 =?us-ascii?Q?UyudEVmnuFl9fr2iDrilJJTl4Vk0WlcgnRFjGH3HeLtI/unEunitN5m/gNSx?=
 =?us-ascii?Q?YZCI3iMLMGt1rp/cYNDlDVHyZv3FdQOtHJh6DKNPHNxTWOH36BYSpE3hAUO7?=
 =?us-ascii?Q?3fjJB7auS8xl4AC/wkBuEfgGXtladVlNaYpxai7kyDaF16YDEzXeuEMbd/nD?=
 =?us-ascii?Q?eZzp2z20bYFKLU9QBWydR34zWfz29ztB6VN7z7HHOagyhaUQB06IO7TqIvpG?=
 =?us-ascii?Q?Ww7sncPTEoFU0FPwpbT1Cgh1t8mBkYl9H1KzDrkjcYBeZzjThenyDtpFak3C?=
 =?us-ascii?Q?MCBNqwT+3sRTQAPKBW/GB8sJj1wGAssBezVkefnCsNM2+xw2hEsr7YziEz7Q?=
 =?us-ascii?Q?J0+vTjSjBgJCrKBidmra7eRvl9r2yK7lt6ugXBMOzJktGA1qU0vtb2MT5AYq?=
 =?us-ascii?Q?cNnhsTve05c2FHb30hUbKqp/SebMb1zTQGYBPjU0q4/DdlC7bi9eJGayWich?=
 =?us-ascii?Q?vh4lPhks2EpcDAHj/v9LFV/QV4kjkNd7F2t3JEDZ7owi5B+D80pPr2vv4ByK?=
 =?us-ascii?Q?kbnJdLRCmhS34CiUrqCSJPgVljmEKRMQo2Db7vJ/8RbcItTuKowPNQnCML5/?=
 =?us-ascii?Q?nVL/fGYWCcJGZQUbZ8FsGjRtUMFfDrgy6q5PuJFx3RafU5V1tXjewLyaYQIx?=
 =?us-ascii?Q?bvWmILhkdxvqx6qc+SM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec323b73-ff69-42a4-1544-08ddf07d25ae
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:17:25.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N36koFSPdgYnbigfurcsfO4gvfLW4i0GMAn8yw9yPlgSEgBm2rqExipgQ8wKckeuDxf6PA5fcynW+enuLiPeUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8198

On Wed, Sep 10, 2025 at 10:28:17PM +0800, Peng Fan wrote:
> MISC protocol supports getting system log regarding system sleep latency,
> wakeup interrupt and etc. Add the API for user to retrieve the information
> from SM.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 83 ++++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h                  |  2 +
>  2 files changed, 85 insertions(+)
>
...
> +
> +static int scmi_imx_misc_syslog_get(const struct scmi_protocol_handle *ph, u16 *size,
> +				    void *array)
> +{
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_misc_syslog_prepare_message,
> +		.update_state = iter_misc_syslog_update_state,
> +		.process_response = iter_misc_syslog_process_response,
> +	};

Does it need const?  looks like also need static.

Frank
> +	struct scmi_imx_misc_syslog_ipriv ipriv = {
> +		.array = array,
> +		.size = size,
> +	};
> +	void *iter;
> +
> +	if (!array || !size || !*size)
> +		return -EINVAL;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, *size, SCMI_IMX_MISC_SYSLOG_GET,
> +					    sizeof(struct scmi_imx_misc_syslog_in),
> +					    &ipriv);
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	/* If firmware return NOT SUPPORTED, propagate value to caller */
> +	return ph->hops->iter_response_run(iter);
> +}
> +
>  static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
>  	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
>  	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
>  	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
> +	.misc_syslog = scmi_imx_misc_syslog_get,
>  };
>
>  static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
> diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
> index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..2407d7693b6ba1303e07629e45e2a7eaaa906fd3 100644
> --- a/include/linux/scmi_imx_protocol.h
> +++ b/include/linux/scmi_imx_protocol.h
> @@ -59,6 +59,8 @@ struct scmi_imx_misc_proto_ops {
>  			     u32 *num, u32 *val);
>  	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
>  				    u32 ctrl_id, u32 evt_id, u32 flags);
> +	int (*misc_syslog)(const struct scmi_protocol_handle *ph, u16 *size,
> +			   void *array);
>  };
>
>  /* See LMM_ATTRIBUTES in imx95.rst */
>
> --
> 2.37.1
>

