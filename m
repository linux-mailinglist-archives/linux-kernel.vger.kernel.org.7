Return-Path: <linux-kernel+bounces-791957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F8B3BEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8264586417
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344933218C6;
	Fri, 29 Aug 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VACwNmFs"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEB32144F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479493; cv=fail; b=PWH6f7uWoS2b+L8iLNWOxEdfZLssddYC+tEqNFPP09VOutLHcvx9TtlRE9j4SlitC2sqyoQDNQP3/iwGB5o0i3cPx6ZyX+wiWJDfkXEG4bowPhy3Kpnq/2gbCwlGp/BwjXoR9TtMPqKrTs4OnVvFdtAbuMuCmni2xgnUgqvX9Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479493; c=relaxed/simple;
	bh=fawizk/PNBdFO0nldGoFANKDHFps/pVzouULIxoLDcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6KExY1r9ggab9QfnTr1Chq134zK5mGciITwJHJrIhggGUBjFMKsd02buvs/vwbyUYqSKrxZLDRiQXF2Ee7fJQgDD2lJJMbzhQShBSRlNC0pHbETwqyGwZQFStjE+Hi6iZQ+VOPIFvcGDfLdTLI/uwlN4/IPtLz0UUhRAsjQcVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VACwNmFs; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cppr6+L+AJTMVfyFSn2MrH3iHiD/FN1tdOmCMJhvTI1Q9HSGVXE8gUc41/6NLH66q9EE34RHls8K+s0FLyHceMEckplu+GMKJek3YqdQwmc2s0kSL2V8A99I+8eriXuXQjSS3f4a7rKSTqULba0yxSgWMUleTM7mLN4wIBWX/Qsvy0Jcb/rT13MjD9ImZO4GpbTKSscjrwQBb9DO38GS3w47xMDgk+hCUP9GGREbUkR/LcLUo1gZHLXzHVz0EO6EPHtskOIMqIql46n474HJlP0XZl1D2UmdJDn57IpV5JiixT8Dqx/DrG6duOEnqrQhZWxLa1W7Wtjtuk3x7xXP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=434CP0wjNGdhA3oZNKONTbIloTpsbBgiFXbZWC0EZI4=;
 b=B1cAne1uB/EFDV7H3Y7F2SugF6K8zCBnlYLxacNkDDAxLZUGm4JyI44aG/fm9919x+1F31KRvw7xH/LaftxaCSq/qXocz5b/lpwQEUDPiAyrLd7pYx1xGZVB4QQW3W8iuhzmrCadUm37bItxPr95Nko/1b5ncVzZHmANXv+fKcG7uHziacS6Ht1/WpCljeVUQ/UCNeQTk5i23fOwAAvhe4vcfiP57f5cq7n9tl8ufcS4VzisJjGxWiRfSmO4un59693EN7rwg8nEJwYwXHxXLBai/3UJTrpN6YHLJyc5WDUNZYEzR0tKEIdqW8yG/xEZQF7Z0LNE+4iAKaN9ugrmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=434CP0wjNGdhA3oZNKONTbIloTpsbBgiFXbZWC0EZI4=;
 b=VACwNmFs24FQIOTTF5ZTRI/9BCLI3LyQvEXwzO52BQ9kYjcC+Nx8MCTtgXX8bPSru3Y4XMU7laz9jE/u5g98rtJSNRMqWdb1CtfZTEs4yu2x4GPrcwjt4jXLU2HNNCo1JRZOUJ3c/zz0w5+7nsoYIgYBPrdCYRk1v6LV5im6tmTtTjuxXvgf8CuGSQYV2W60ZHMGes+XKrrKLZcCkN2HYwZI6USOaaiAg/Isf5ZMOdMhcIvlOYMxAGC/XrDf+rCjINH6rlgbHIJbHj/ne6I4Nh6elTB4YUMZIdxBYyfR81r4LmL8SyFT7LGSmyz7Igt7FzL3BuzhN4Shr3aql0uxBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by GV1PR04MB11528.eurprd04.prod.outlook.com (2603:10a6:150:280::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Fri, 29 Aug
 2025 14:58:07 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 14:58:07 +0000
Date: Fri, 29 Aug 2025 10:58:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 1/2] i3c: master: svc: Use manual response for IBI
 events
Message-ID: <aLG/+BxMXznwmlyb@lizhi-Precision-Tower-5810>
References: <20250829012309.3562585-1-yschu@nuvoton.com>
 <20250829012309.3562585-2-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829012309.3562585-2-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|GV1PR04MB11528:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cd32de-7900-4f87-83ef-08dde70c769a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?11Xo9Y2peAHjdmEmfeAkRiNf6lGf7jWUZo8Ma0tChbwwERWfu8ylMSYMsbU0?=
 =?us-ascii?Q?X6dgISlcd5crH6u8PDvKyU/9woZlm5V8QUzQPWXe2Nmd6F3rcVu+8CG3mW1k?=
 =?us-ascii?Q?xsBxnaYSgRCHB3Or/edyIKEzv72tyOE31bIi/6VuHRgyz/oTk0tvEGXeBs8r?=
 =?us-ascii?Q?axjfoIk9vu9J5ObQkmxJBmBNpLOYEibeEDONxh6NywtRHE4nnR7N9CGuzz21?=
 =?us-ascii?Q?fi/DvPRe34k7XBd2uyQkx/o/bWT0gm88JWbK5OAStHzOiA7WMwMUJw2+uuye?=
 =?us-ascii?Q?y43t660zeONE4ppCPpxnO1zOwqWJ9ilssc0C8Q/vqcHfn2V9sHbCT5puIC5C?=
 =?us-ascii?Q?43pMv7sjKp0HpmdcjfUC7GVprZMOGDc3b7hGQn7a5wjDuBLpy9FiaVeNAADD?=
 =?us-ascii?Q?xWIdYva0W8+rkCa6C17/lbKnbvoRnDZa33f7Ef7vOPvV119qItWpsXva01hJ?=
 =?us-ascii?Q?gQcef+GG7hiijC0JreF/4KnNK5YpbcAK+9bQokH7LQmlhoLcZlnOh8pG+3i/?=
 =?us-ascii?Q?QZjyF7WGtx3GDcT0xiD+rRIgPrsJndxaPuXQYiU0kw91BWrj1nwrlfdmjpng?=
 =?us-ascii?Q?7kIx2WPcKIChG5zoAbY4WoZamZQ46hBXuhOtNHmChLw0qHRRb5S7NsYdNIOZ?=
 =?us-ascii?Q?kS6x/jwp64Gzvokdudtj3r4RoThOIJNxm1GbA3LeR0fdqxlvi8PAwdL61KrV?=
 =?us-ascii?Q?M9z4ydRkStFWGpbURk2nZzL8ZW/DzWfvspHKzXktd6s2HbxHuOcJMRH51qsI?=
 =?us-ascii?Q?KKBYHuUY/pEnv6VtuXEyBZTPdAsMQr0CyNT6YI7WZ4hDOyoveV9JkeGicQUM?=
 =?us-ascii?Q?wf0pmZDxe9T0NMCsCobUt4LPDX14W9H7RHvLZj6n7luq7Z/qxGAESER0S8+K?=
 =?us-ascii?Q?gNsyfgj18Wf3VDWo5xT1wD5LiTVPJ0Mk1Q01zLK3V6JQyfSn82mOs1qYb9e7?=
 =?us-ascii?Q?XwpemmXpJpwVTuz/wDw1cUeVdLsT0XQGrRVJf4bD0Qp8x2yFSvr+oqhcD3AB?=
 =?us-ascii?Q?hM04vjvnDnPA2fGyuaS5Ka2l1UqoErSB2qM37ChhvW7OMs3nvfnkckAo06VE?=
 =?us-ascii?Q?rFNVrRCNT6dROu/00BA0Pg28QaVou+zlpZ9scRS2j32iq7Tp7BpA90KeIoVe?=
 =?us-ascii?Q?RFVres+YuFMD/CeZkf87dyzBkldT/y53XFPXLe0iUWJ5Af6vKLZrfwOaqqL1?=
 =?us-ascii?Q?mTasfu86KFityPnR9gGwTRHcvqMIDJNYJGaJRZFVEMeEgNQrbvK35Pg7thn1?=
 =?us-ascii?Q?o1aa7ZN7mtuYw59No9ImaJjMRcZXJg2gs5UFvshJQ9QxRzQwKbngEx5jATtE?=
 =?us-ascii?Q?OaB1NzyxqyB/MfTNELXHamvyK8T4h78uNlP1wge7VmAousoFkl5B+vIiDdMx?=
 =?us-ascii?Q?3zvGDjZcvYEh+P0qz41Am4prBxdvFmkV+VSJ07I8T/gUnR7ffnoyH3+qyzVl?=
 =?us-ascii?Q?ETho6gH7sbkOSe1DWKsku7D7T/pmm23xLMuh4bNOqhLmKL+R0qfGOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJH8eGfeazKje1lZnuAmgxNVrzMy9vy1mdcPbXrkAUDnvbTajoI7lWQItBSe?=
 =?us-ascii?Q?0nLJi2SAE998UZ3ktW//+y4ZakfGKPe43mRCMfjlGqEPWwbQALHo9yO7PQjM?=
 =?us-ascii?Q?iLXI/UbNPiF8MSPqJ7tB8n98ADNTJfKX5lCcnWlFYN36BVE0J3wbw1an5qO4?=
 =?us-ascii?Q?e6+8X7ItD3+4G9txfVErsv10kjLrjVTcSVP8KmOiG4ow/mv6M8FVBFCECKx8?=
 =?us-ascii?Q?1f7yjM0QehuQEdvSY5vbpJuGmvez+cCNzObR5RQBQlzUGYRGyjKPsmi2+mTj?=
 =?us-ascii?Q?sPAPh8T3FKvstXmbQFpywc3d6e/Bnx3rw49sQpB4+xYohSD6Pp7WCMd297wh?=
 =?us-ascii?Q?yUk7WjJBYK22SwjzWMAn4DvSiyHrGPpeYnOlH4pFjdp19JsJn8x2tmtRN4c1?=
 =?us-ascii?Q?BL8j4dgRBO9WMah7gqc1MpiQh8Jhyk9FQoObGSWg6E9y2odDoqTCOTj3zFIx?=
 =?us-ascii?Q?ShIHOb0QlIy0Y9feKd2S+RFv5jA7hb8J1Yre1Ry9Z1WGS0CRDZ0o7eclWGwq?=
 =?us-ascii?Q?h4rTQSoWCyEgFEwxlaqGZOyPtZUcC4deoc8h5NTD/odMgtivkoNo+UXJ97Xd?=
 =?us-ascii?Q?zlGfpwfdueK08qOZlrCFkuFiNr6rI4rC77siW3nq/chPX2CUe0uSwGqHAHx5?=
 =?us-ascii?Q?sj4OG0LGJrJXQv9ZtDArTHwU6rVK/aROf5yhWINkDBCNI7RukeBjKZrHZ7Va?=
 =?us-ascii?Q?NuNhCnadYeRCaIK3W/fCjGKArVXQ5Vw4jqJxQ7SDElEH0vL4zA+XV/WHulkO?=
 =?us-ascii?Q?k2fyAy8QeQWs67n3WcIMtZxxecwx7j78pF1ZiZCiVc/ThUJeRx5hEPB/C2fa?=
 =?us-ascii?Q?ffi35tkwFIH4MT70qNrgf5zaRuRVY1a7D8gYe+nGMglxDpftk3JMdkVs/uVZ?=
 =?us-ascii?Q?GlcJU1NPyhm4gyCHTxkHJL3ScVVTzKQZim6Mwrk3QdV3OR7LgbiTtHpw8P3L?=
 =?us-ascii?Q?fJcWHu7hKoTttYeWkZgkvUV5O16Af4WM9C7dYw6te074JjGJm1IiZbxRP9DC?=
 =?us-ascii?Q?Xuy+tMFtjkx1ttKb3TWH6fpO3K9W8vIz+ojh2wgro6EQzTOI6icwzaFvkljd?=
 =?us-ascii?Q?hFRFvwSWTPlc6e2P/x0Xj2CkgwL1SEZmzNUuJF9R9rUzw145c/H5RBw2QRhN?=
 =?us-ascii?Q?qVwBpH8XpDr+sjdzYRYwVSqi0CMurVzgidgA1BHUhWL5kwdgBhtWNn+WWzmE?=
 =?us-ascii?Q?4jYnnM1eOb21bQfnpvM/mwg+t7nFIEdx+Pth8+tkqt0/KZiqSHQSaAf76UmT?=
 =?us-ascii?Q?xgjszUxxouiYccoOctki527RDN5NYYoi1fprGlZ81XcSENV1l+F8tQWB3e6C?=
 =?us-ascii?Q?29MrDIjcQSNcA4ZpJ4hHdHljCQSI3fHxfuLbfZlQmVg5tP47KbIKYeMj8jq/?=
 =?us-ascii?Q?xcqHzQyzEJ2Y4LCAAOCTbBxrm/YUVIpcBy/Y+TlSjWNuybfVgVDHWQnFAfVr?=
 =?us-ascii?Q?Ftv8ISbe4ObghnL7jcgtiC/IaEclHGQ6QeKo/OPuj0WdM+CG9JaDvxuFGCre?=
 =?us-ascii?Q?WZh8q3gjH15m3+NNHBi1miVuCAFbYn878NGkZSW+hF1Z8RQ5mNFOVcaPkBXD?=
 =?us-ascii?Q?gEfjEpv4zEFt85AjAEiLqKrjDXoeBL1a23yJgdKI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cd32de-7900-4f87-83ef-08dde70c769a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:58:07.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsD+KEI1kC73ip3gzp+puBOg6GCIA10B5p3RdOfWTN1OJpOTt8oAtTLwlzVI4BdSf6YQitIp2EVZPN3mDUjKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11528

On Fri, Aug 29, 2025 at 09:23:08AM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> Driver wants to nack the IBI request when the target is not in the
> known address list. In below code, svc_i3c_master_nack_ibi() will
> cause undefined behavior when using AUTOIBI with auto response rule,
> because hw always auto ack the IBI request.
>
>     switch (ibitype) {
>     case SVC_I3C_MSTATUS_IBITYPE_IBI:
>             dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
>             if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI))
>                     svc_i3c_master_nack_ibi(master);
>             ...
>             break;
>
> AutoIBI has another issue that the controller doesn't quit AutoIBI state
> after IBIWON polling timeout when there is a SDA glitch(high->low->high).
> 1. SDA high->low: raising an interrupt to execute IBI ISR
> 2. SDA low->high
> 3. Driver writes an AutoIBI request
> 4. AutoIBI process does not start because SDA is not low
> 5. IBIWON polling times out
> 6. Controller reamins in AutoIBI state and doesn't accept EmitStop request
>
> Emitting broadcast address with IBIRESP_MANUAL avoids both issues.
>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes since v1:
>  * Specify full fileds in the MCTRL register
>  * Add Fixes tag
> ---
>  drivers/i3c/master/svc-i3c-master.c | 30 ++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 701ae165b25b..8e7b4ab919e3 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -517,9 +517,24 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
>  	 */
>  	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
>
> -	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
> -	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
> -	       SVC_I3C_MCTRL_IBIRESP_AUTO,
> +	/*
> +	 * Write REQUEST_START_ADDR request to emit broadcast address for arbitration,
> +	 * instend of using AUTO_IBI.
> +	 *
> +	 * Using AutoIBI request may cause controller to remain in AutoIBI state when
> +	 * there is a glitch on SDA line (high->low->high).
> +	 * 1. SDA high->low, raising an interrupt to execute IBI isr.
> +	 * 2. SDA low->high.
> +	 * 3. IBI isr writes an AutoIBI request.
> +	 * 4. The controller will not start AutoIBI process because SDA is not low.
> +	 * 5. IBIWON polling times out.
> +	 * 6. Controller reamins in AutoIBI state and doesn't accept EmitStop request.
> +	 */
> +	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
> +	       SVC_I3C_MCTRL_TYPE_I3C |
> +	       SVC_I3C_MCTRL_IBIRESP_MANUAL |
> +	       SVC_I3C_MCTRL_DIR(SVC_I3C_MCTRL_DIR_WRITE) |
> +	       SVC_I3C_MCTRL_ADDR(I3C_BROADCAST_ADDR),
>  	       master->regs + SVC_I3C_MCTRL);
>
>  	/* Wait for IBIWON, should take approximately 100us */
> @@ -539,10 +554,15 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
>  	switch (ibitype) {
>  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
>  		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
> -		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI))
> +		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)) {
>  			svc_i3c_master_nack_ibi(master);
> -		else
> +		} else {
> +			if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD)
> +				svc_i3c_master_ack_ibi(master, true);
> +			else
> +				svc_i3c_master_ack_ibi(master, false);
>  			svc_i3c_master_handle_ibi(master, dev);
> +		}
>  		break;
>  	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
>  		if (is_events_enabled(master, SVC_I3C_EVENT_HOTJOIN))
> --
> 2.34.1
>

