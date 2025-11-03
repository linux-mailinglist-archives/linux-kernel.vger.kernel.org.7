Return-Path: <linux-kernel+bounces-883275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7012CC2D1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4AB424C99
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6183A14;
	Mon,  3 Nov 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WTL+dulM"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C221C3C18
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184665; cv=fail; b=c5dksEHTwvEc4Ng8eD/+4iHnzytrjOvNEpMEbhfyhC0fG5XPS42Gi58pH9/0P3qqVYgu8ebIfx6m4HBMXvWtm46SMehNhdRpYPojaFAeZPZ7eGSjIT3/ZI4D5gf+HmnsOBZ1mSl9cnAOAWnJmD3XiQyfazKLRlidqaDANoRxits=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184665; c=relaxed/simple;
	bh=w+GVIXtEwJCBOFSCMdj+5aGgr5KN8jlDsUWP2rH4c6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DtRZ07W+ZK/x0Vt74YEh+u/fDZVPo+nncDOk/d6fwyxoPkBWt2EtvoWvQwPpbE1eykZKQ++Bb2C9o+XMrrKhIT3M7rnJS3eAXvR0seQm+EawIV00grz7GOztAosL9Lx3TYaL26xg9KrKCaj+MI7gdov8PfXLc8pNVoJb1pS4NUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WTL+dulM; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWilEdg1J1o52q3JvhBZ9XX4/QHGdNzFxCat7m7B2yMbOLRdpacS3izVx0sYp7AyahHRK1ycx41ePUcRQkkvdSVUVjQJtnjG475yhPYMWAkpnCfWFMKJyaPgnbzcSqjfhlMKQzSqfaCum3HaC6FkG7rqpBQaL/gxg3tnh+j1cytHGruZQGJTXrt0UJmhHHFBex9ySgLLSlCBBEW37a9Q5SCHJyH16uUqVXaTOIL28eZH8Zy/hjJNQzTjqT6sR70oz31+oS5YvbqfOcrldV87jlf0rKFolv30D1iiudwGJj3TayxMPgMH34E89/A7pVfWr9jPAXtsKbRBZt3pDWJzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0NXi6QNaXTwT0KfyhA1rSFqi9g02hy60g1tIjWTBdE=;
 b=NpHqYIs1JjDYQcqhMur3l9GSg21aFKb6LXFUZS0Vzqfo9txEcJIar/Hatk/A1bN3ItSSe0crBZQzP4tVCu7O8jxVfavvWYIUX/Q54CgvPhN+2j51bVp36mSEncPZ61q/F0kf0Ig9I8Ou/8dQOdysVLh2Pr2DbOUf361L1Rsce5GUi9wGx04hKf/ffvXOn2OK4LV2vELuXoD2OEasWwpqU0/v5prwAI/JT8IThwCKVp2xSQ6hD2TFV/bEDtl4C474Srv1Kr4ROp8RqcjWc70MPBS5J78aiaEMEqeDTkjfreriUWP3znvVUBtp5QzfRWSNkFRDv6wg4u0LsrLCj2sC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0NXi6QNaXTwT0KfyhA1rSFqi9g02hy60g1tIjWTBdE=;
 b=WTL+dulMsozUPo7qdqgF9gTziCL7lD5ohvUG/ctxt+VNP8tzTQlcKbaUMo/QRipb9MIu2HjPl8tqUq9WzXkMSQ3GwADil8p6iK+6RU9u2eZlct0e8CABU3nsXgQDdjYhrJE/z0vjHLsKbB27QhRj4apCaYkqG9zkIQj62OsWFfl6TAqMqSc1ZRpQEaRKQbs+rYWnVEEFGxbTIcVRpuW94hUgefb0BlgCTh5ZXucorvrqjGFPnevxCvLUKRUmRPCDvc4LIF5xYFXsd1kSXCOlMWKMVZ1LkPFxsf7wSa6IyPpTb6KHNt4SFDJGlEakfmnHfGs7E4I9CjD1AJduwuM84g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8399.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:44:21 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:44:21 +0000
Date: Mon, 3 Nov 2025 10:44:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: dw: Add apb reset support
Message-ID: <aQjNxCencdfq4bXq@lizhi-Precision-Tower-5810>
References: <20251102100237.9451-1-jszhang@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102100237.9451-1-jszhang@kernel.org>
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8399:EE_
X-MS-Office365-Filtering-Correlation-Id: acc920a0-379b-413f-6d02-08de1aefd6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZhOH5qzdJ1JVtYV4fp+jHnegVFVQUAattKspWPO6Prs+7ANA6NGSOXnTr2HA?=
 =?us-ascii?Q?r++1VOPMI1Ategh588hObKr7FMCKpSrg1fO+ea0jPb1uedm7tup74/fRXQTv?=
 =?us-ascii?Q?Lzu3tN+J+/N1CxSIyZtdjtrwa0rHpXjHW1gRq0SCH/tMpi3pxWtCaIRyJKu1?=
 =?us-ascii?Q?4mIL8Kka2Qhq4LZe+qZav9bBuCtV1bkl+G+njmu4wSh1wyEFIYp1dMP+7OZ4?=
 =?us-ascii?Q?G9fRSccjrpGMgyvu5HEjBMrb1JCAYn25JL1m2DZV3CEaQEKnq2gyuo2QnJR3?=
 =?us-ascii?Q?rBqFoB5I8epMw5TiDE9f5l9VUnUDcBKkHFr4dtBQygFUoixsBfjyEKNhPcm8?=
 =?us-ascii?Q?8t5yVTFv+a7iLjKFZiQnkUI/0l9svluj49j58zHJhFH96y/hv9BXqV3tIimb?=
 =?us-ascii?Q?XNj65QpB3Nno0EnvtIRaU4Pj7MIaL+is6bOfuUkNcxSbuo83tcE3E/eukqEz?=
 =?us-ascii?Q?W1OXqnGrFTEnoq4z1P9FBJxdW1+LaVJeUS/OWetUPhUAkXcwnXZFxACJtOQH?=
 =?us-ascii?Q?P0A4fb7MtGtsSMyWWL5XafbYededRrquPg8qFXPTutov8/XAKjeSJeiryiJv?=
 =?us-ascii?Q?47T3E4fdiZFFVM50EqlKK8cNVhcx5Dx+MOrcHyXx4PSpbYiYPmrhGQYv9pHb?=
 =?us-ascii?Q?zNRkxLTeMzyacfiHnE6OV6FCBmtVonTmsWg/oLs9SIayms+i5mic/BCP3/dQ?=
 =?us-ascii?Q?m1yos8SgICpsz+zfhWISgBOKbFO5+wBeSt6ZdzVGa4ncbF12MtltSmZgztnG?=
 =?us-ascii?Q?GOVbTntyEfCAp0Y2aMIILZA/bYOl3HvN+Y8E9DwWPn2amYCouUA7LeQBsqxu?=
 =?us-ascii?Q?xhB47qcX+s875lMdTLU0SjEdfkcnJ7KDvHAqme9Gi2POM3ZiuP6OXHxjmjZ9?=
 =?us-ascii?Q?3HL0um7XTGFTXSSjXVXvujI2/Xs6AAAZl916lUEViJqCRjJ9xaC1r9IlfDqL?=
 =?us-ascii?Q?sQ9o+WhOyI7ULnEJwLbq9EKLGmi79ghhPws3xUYHLTgDBJUrLaHrXZsftxv0?=
 =?us-ascii?Q?I628n8jX77JV+q2zHrK0mf4ZzaoPRhI2GbyEaOReDXjYGD3zMDHUnesTO9ZI?=
 =?us-ascii?Q?qL+TyNR+h7OlbLJFmo3z1KO1iKf5LhDdBR7akPC++LT8ChZPX9FO95HD33Bw?=
 =?us-ascii?Q?bbqNjcXHxNYmV3UMJvSZkx3UMhl5IgTN9Hoy4IjujtoZP9ptkl+htAB6kds8?=
 =?us-ascii?Q?kDID2MK804780fVooHjNeqw5X8iIHFHaG9WdptJvmqLQ2TQEyDyy2i0/6TsU?=
 =?us-ascii?Q?tjdRooP2mOoLpf58SbYwKJt6AbbJg5YCnT+P8yT+gj+HpPS62bdl+yG4Q0Ms?=
 =?us-ascii?Q?zPJbGNCXCL4vQO1ylxuKriIOkkPLBokGZXiOPQfp05hJD4ogTdX1Aor3XoY/?=
 =?us-ascii?Q?PdKLmh+N+CNjGNU6ApEYMctAg16lXtu+KiX+4vtj86nU9s8sHeQjpJDDifvy?=
 =?us-ascii?Q?MBU8Nhv39RRcyhDb+UBKKi/OHlhm9Cfmp0xD+bSHyIMPAdsmgxLky++XJX7H?=
 =?us-ascii?Q?V3zurGU20gZgQGcCaiNXms7Ur50378Jr5BU0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?68U/LNz8BOR8axDYstDzNt9QKZAZ3SJ+mOW1xvu2UZinpSgZEREKKg9Vf9m6?=
 =?us-ascii?Q?fOh8BVXMHAxf+yung9zXQ//IdKBezeiGxnuS7urpWg0eLyAhh2ekgbJWjaLa?=
 =?us-ascii?Q?Yjn/hcL8DOOd2lpoq186W9qgqZEfCgPsSXH5hBvPU5UrYr/BinL4xNIjdBRF?=
 =?us-ascii?Q?9sjUrSquHOuo59hSDN1r/XJIu8SpabHxPmiX4c/L8zgDQ+O/JrR4SALTRqiY?=
 =?us-ascii?Q?lI67BYX5yoO6ZqVEL8zT4QVJSVKBmCl5/9squRqcrVQpEBn2aY5J7T+CTu8I?=
 =?us-ascii?Q?Qsx0dLLbNYWOMTPEae2m/Pb+jxMMJFsP82NyldO5cToeVfbI34flkei59xQX?=
 =?us-ascii?Q?WlxOuCocoGed5df7z3u18tZ16LEhJVO2rBI7kdI+EPBQ2N8/rxTS8zV8W05i?=
 =?us-ascii?Q?freTTiETm390sQoBZcNEJV3HlqV/yiCTumq4kgYe+mTiTU5fOLQPCNLOPqVS?=
 =?us-ascii?Q?EE66iky549mDqq6T/EyzPX1jrRZDLexpGrc3VkOFVd/5bMuatuUu4FkgpS4g?=
 =?us-ascii?Q?RW6KJNtB7EtKXJQcmjWrbuR//lejCSNy0XM7QZwVeVO6Snv/0U7EprT9qV5g?=
 =?us-ascii?Q?vZIvbAOU6CGK6nbo+PDewHY7WSjshrHk+th32O73Tx+CJZJCKmNbJl1VQygA?=
 =?us-ascii?Q?Q2/EzwWjU6wQxdpbpcrWl4WrlYNtYOXiGHIgfAvMi6yYEodh7B0bBIQDA71q?=
 =?us-ascii?Q?4jfsEMyvdtA5z1CInJoUzYEqXD0M973N1nejH5RPnQkU8B6gBYI2lhtEo4wq?=
 =?us-ascii?Q?7uSz0O3z1s6EfJNqyNEmkLBKI3vLQLSPnXddhiwYkB/mHJy55/p15yfv9CLR?=
 =?us-ascii?Q?qjiEAGPHougl/NNeMk/1y9qyZesNs/7yA2oFUIjnbyV3IR9CgRfG85UhKbX/?=
 =?us-ascii?Q?+t3fCNhsQxM9JC0MJA0tIYpFgtdwWA4ZmIKIp6e7SE/DXIwKYXEGv+kZfbwe?=
 =?us-ascii?Q?zzD+0e+aQqqqA0qxPHVSpS0ASc257c6OIr3u5hNzMpSWUzpW+BrymjCBrq8M?=
 =?us-ascii?Q?4zNvBthfQRjhtCCtUndQ/2yBnQjWb0TOe3srcy/vZbmfS77hnz4iEFTn+xW1?=
 =?us-ascii?Q?uWnXX6XIasZEEvAwHK2iVyhHEiUzvR+M9XhkfpszxMm5uoDvDJ6dvTa2PSJI?=
 =?us-ascii?Q?Fxve1AojDifyueskhrJtmJlMf/AuZDkxXUipqd0WAXVjIik3G9jRnYqNRtHg?=
 =?us-ascii?Q?F8RTLBdAiDpMklnRoGX3VxVf9DoNFqBT5+Go316526RohJQb8K16YPgLMjJK?=
 =?us-ascii?Q?neWtlM2j01S69j9ymMPmOTwLYBJz5ZN17dJ7C5YMll7KjwvC+DjbcYj13uiG?=
 =?us-ascii?Q?lU6T+sNTfX5N9C+Nj6gUTYzRchypWlqMLSdthr/mvTvP9bxWDDVGfLsJSV4q?=
 =?us-ascii?Q?Mz0NgUMv+k/VaDtCliaPe1W0CwMSDBM2YwEesKwllS8wAf/yzS6mvI4NUGY/?=
 =?us-ascii?Q?7QyG7bJqOyBNtqD3P81Zv10joeUj24MeTk8d1hxNAGOiQpefBVxDcYnCzI66?=
 =?us-ascii?Q?QETzWzmO3QH4drE4z2vYwqLvPvS4LDq4Q615+ZIvxLwfkjQhBL4LIr+nYo1T?=
 =?us-ascii?Q?j9RAFvNbVj9NjBpGEiOygYDu1xIcYWDk6ek1SSH6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc920a0-379b-413f-6d02-08de1aefd6ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:44:20.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yFuLwFTIRQjzBOX/BUmn0o8zX9069ycdLY3H+FTNwiFJ/UKM8u2BgcZ3VOLcZL6QeI28Lv/WZjBhxgr2NF1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8399

On Sun, Nov 02, 2025 at 06:02:37PM +0800, Jisheng Zhang wrote:
> Add support of apb reset which is to reset the APB interface.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 9 +++++++++
>  drivers/i3c/master/dw-i3c-master.h | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 9ceedf09c3b6..ca2863d2b2b7 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1558,7 +1558,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  	if (IS_ERR(master->core_rst))
>  		return PTR_ERR(master->core_rst);
>
> +	master->apb_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
> +								    "apb_rst");

Does binding already add "app_rst"?  The name "app" should be enough.

Frank

> +	if (IS_ERR(master->apb_rst))
> +		return PTR_ERR(master->apb_rst);
> +
>  	reset_control_deassert(master->core_rst);
> +	reset_control_deassert(master->apb_rst);
>
>  	spin_lock_init(&master->xferqueue.lock);
>  	INIT_LIST_HEAD(&master->xferqueue.list);
> @@ -1607,6 +1613,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>
>  err_assert_rst:
>  	reset_control_assert(master->core_rst);
> +	reset_control_assert(master->apb_rst);
>
>  	return ret;
>  }
> @@ -1711,6 +1718,7 @@ static int __maybe_unused dw_i3c_master_runtime_suspend(struct device *dev)
>  	dw_i3c_master_disable(master);
>
>  	reset_control_assert(master->core_rst);
> +	reset_control_assert(master->apb_rst);
>  	dw_i3c_master_disable_clks(master);
>  	pinctrl_pm_select_sleep_state(dev);
>  	return 0;
> @@ -1723,6 +1731,7 @@ static int __maybe_unused dw_i3c_master_runtime_resume(struct device *dev)
>  	pinctrl_pm_select_default_state(dev);
>  	dw_i3c_master_enable_clks(master);
>  	reset_control_deassert(master->core_rst);
> +	reset_control_deassert(master->apb_rst);
>
>  	dw_i3c_master_set_intr_regs(master);
>  	dw_i3c_master_restore_timing_regs(master);
> diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
> index c5cb695c16ab..a4ba60043288 100644
> --- a/drivers/i3c/master/dw-i3c-master.h
> +++ b/drivers/i3c/master/dw-i3c-master.h
> @@ -37,6 +37,7 @@ struct dw_i3c_master {
>  	struct dw_i3c_master_caps caps;
>  	void __iomem *regs;
>  	struct reset_control *core_rst;
> +	struct reset_control *apb_rst;
>  	struct clk *core_clk;
>  	struct clk *pclk;
>  	char version[5];
> --
> 2.51.0
>

