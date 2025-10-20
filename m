Return-Path: <linux-kernel+bounces-861709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C3BF36DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139D6189406F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B534337BB8;
	Mon, 20 Oct 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oQBqZ9Lj"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB84336EF5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991788; cv=fail; b=ijpTlyKUSFUo4VHWRZwZfXQmPn34yTi3kA4zlLaRy5OBDuI/MtHhrNWRhAhsmBFHrEZ5C3PK3C34QNpS0igqBV8BqsrLgxClFwvaeMdWJgy+Q/nI9qTMQHScsAONgASwzJzKp2wtQosaPbdNtK456xIcDeYYj8I0mAeyZ5ELv60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991788; c=relaxed/simple;
	bh=dNVoQ6D8zdc2T0iGLUScpqmRJ6gpcA7kmyoH1fGo+p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FdBKriZlDDRTl0dSdOh9inmK4b86OVmBVaoE2f9iGcApABwqg0aw71D4XwgrAuWGTJslkYpHf49VymGpL5Y28ZEui5etf6S0tm/dvulHD79oINhxdCvmL4KYXbtGdrNYcGH3kuSO0JA7brbPtMm9KtGo6ztXYvjFSD//2l8bna4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oQBqZ9Lj; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFOgeF7Gvx1664Q5bNi+0bIlCCjLqDy+z23wdPdto4GvT0HG/KWCxY5YhzWGRJe56c7aGrjMGEW9kK8PDKLDxlBww9IYeYApnK1hZUjltpZRGM21/gu5tFTjbL3FKS/T9W8q+uveDqHlUGsAYyfEFXXA8PQv8quB5c6i+7n8jMEU5D3F5UJmf8Y9gPOMN+UZsYMQe648R4hREM6acQ6rqP5xW80LJ3dlFZ77YtXiRZnJNKQUFVGvp9ZfTwYyzQr9F92UCbdyVfSrtMv1NtkBkTwMwgvOoHeDqNyHeB38gBe9d22ixfqFZWL88uZ0jbH0NsKmKq5GbHPVXKuvTeranw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEz2zKn1ysygIQpXZBMMc9NM7d8rUtZKAdd1knScAgI=;
 b=EwLnzgGOmU9ssu5jMCTPWXAW0Wanh727g0cB+wkV0DIiXUsBgHePQs+ylfGyXXdobJ+C91pe8IZMl6/pji0d1t3xZUIXv8ktQF+jmWQ7K4c9NwPfpZjjnRrC9M37JiPYr8nqD0smm+F+Rb8qDjYfGD4dPVM06ohJBchm6BGZhfQxuqwW4cOQ1jAtF8IsjqEWZWj6bg7qxnuvUR1ajKXXq3xiwd4/vHpD7bgLvjX6qjtrz8eZFd0yo2j3NTMeBVe6NfhQHi/TcP/HfykLw1mleAyaSNjrRzENyfDyqhqy6KMf4pGMIj54ovNIhGSHnqcvJSz7TM8S4OT+H5Hc0G6MSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEz2zKn1ysygIQpXZBMMc9NM7d8rUtZKAdd1knScAgI=;
 b=oQBqZ9LjpLe1f+XH+8ynUn1ERT4F/N3wlJqbxkm/YBNY+1R7F32SlYWUyft/VMe8Ix5fn91sVUMDJb2nJ2vAr81vngbZS99vw0KFqcpoH0Egc5I+engLjV0YQH/EdoPkUr7XrbA9BkfcehuI7VticPfTIl1Z+Y1+9nUqHlXjy4xyF02R2oAeBSPZU1Mj++/xl1xttmQrkK1WimZn4LvNehCwJvO1WdFLwTfXQOu/A7ZC90BGQpU2IwtujpeDKwIlFzLpq1jS3ZTLeoSO59qRcWfRUkzPGGT986v6m+tC0AwPikM5qraqJSMm0j8yijpnXVxC0sYaqgy5g16B/BWSuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VE1PR04MB7391.eurprd04.prod.outlook.com (2603:10a6:800:1b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 20 Oct
 2025 20:23:02 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 20:23:02 +0000
Date: Mon, 20 Oct 2025 16:22:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 1/1] i3c: master: svc: Prevent incomplete IBI
 transaction
Message-ID: <aPaaH1ADwU25Q4TD@lizhi-Precision-Tower-5810>
References: <20251020094020.632545-1-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020094020.632545-1-yschu@nuvoton.com>
X-ClientProxiedBy: PH7P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::35) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VE1PR04MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: 959bfea6-fc98-45cc-9b3b-08de10167806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2II2vAFWzb+83SfoBpcbBCbeaY5McnaQnA4cRDqwncYth+yjn90oowIGdBjW?=
 =?us-ascii?Q?aJpaS5LnECE0kwiSPlsvHvpcrI19T6qrVBTobyhIVEH8sAPYsYiUixix41v0?=
 =?us-ascii?Q?mN7qSspR4Gzfs6fpvNl4JUavX8PkKcXp2UtaKcOIfNO2UidtgCMyX7V1zsfn?=
 =?us-ascii?Q?Wg+eWNlNVup5B/oy8prTjDJrTzNyiu57uZNP/fczRgXW/K+1bJreAzyE134T?=
 =?us-ascii?Q?VopTPAumi1b+BDdOzwIMVNLNzgL5vqxZSNAG4eiDF0tzE5Lrb+VAXSO1CSsa?=
 =?us-ascii?Q?IhbGA0iTmNNEmbf4eiHmCqVS2aPuDkphZnv6nl1rY67bFUh4Dbh2uumn5GUX?=
 =?us-ascii?Q?jxotf+dtZfZTLPhVTRLkSgkUv2sPPeYERuLvEk8rOQZRq8sh24i/LKKMUmqM?=
 =?us-ascii?Q?sMX/aPI+g2rCj4eMq18ujY9w0hGLaEOBbYlf3+idaLaqTyuIeA+ZKj4US7dE?=
 =?us-ascii?Q?x3h/NtRDUfWCz2ex8uWTeIEVZqFmOy9lDQjsnXeOnrR7TmfFumhyj4jIl5ca?=
 =?us-ascii?Q?jQ098uY/JEmpV7K9jGc1uLl6bPcQPMjpjlMv8+Xy2Ee4IXlQXnAUGQuiWUK5?=
 =?us-ascii?Q?KCm8qVK2nRYeQFiY0M/b7IedewZkiqnJ3iyN0wjj3UxzrLRk2HsdMGqmMDE8?=
 =?us-ascii?Q?D4Fo7IJI+D0r5aXaXnS3GgoDqub4QSuU0H2hjkUfPO9vMDX7p7HEZ2spy6MN?=
 =?us-ascii?Q?pK0Yd+fai+yb6pANh2gXngmdDyeYXCRXN4IUw3VtTxiJO9kNB32LjITfBB+u?=
 =?us-ascii?Q?T6IUIX6HZ/svR0JTC3YdDueSc0awEVVXOZ3CWMxHX8xkvws795l5djfxfeVG?=
 =?us-ascii?Q?xgFdrM8T1EHJwPlJ6eHXlplEPRpcTmZQC2g+ZyzleB/Rd8afGAcIi26zwVbD?=
 =?us-ascii?Q?1XHrGYjbYQ/5IgrVMMIQ1v6h6+nuJfAucL7JcUIo4kfNb3erFF6NeeUwDX/u?=
 =?us-ascii?Q?CeutqcXfAV+Lf/6FkGHUT3NYBALbnNTVacNVPBof7HUPnDJ1p2IytCZDiTR0?=
 =?us-ascii?Q?yNiF30ysHVbBBBbpn2KiKKrbNwPMI4Gs0zK6t2QyVN8j5Yh8FBeo7Q77uy9a?=
 =?us-ascii?Q?pWKK2xKiE0KB2AKPIPgtyuGG6+hljV6Bc1f+2xepk9o7rZK0EOHcd2J08CiP?=
 =?us-ascii?Q?bZaR25U457P5+Q8a3v/w5S3DTN4Z8BEJNUB2ZfzbTPXmKvxCy5Dipbf8AgXo?=
 =?us-ascii?Q?99HAMHECOKZUUJZnkrw/e97UI8aUMkXbVTHAUBOGVTI0OP6s0gsRT33x/ggS?=
 =?us-ascii?Q?6xMFEKIsbdGo63C1qUEdjAHTPtj/AMLxsiGX2hzi14gZuQAHAZ/N/p13yE33?=
 =?us-ascii?Q?ZTfRhf26hSIBNzizVBZsWjlFvS0ee6ppNgr3yIWnYH34jZHnz1EJs7YQDNjO?=
 =?us-ascii?Q?UJWZdL6uNU32EC6p3+m9PlomZY/jLx52l5VNaEDusIPvfW4voYc4l9NYn/y6?=
 =?us-ascii?Q?fQ3ItXnN0+rJIChNZZuUyM8FhC53/j+CR60bA+dEGNKhDU8vG2Y9dhIwLsuD?=
 =?us-ascii?Q?7jLjAGUskdrAphj2gpyHolUI41e2YaIOBoPU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETt9gCkMDDcSx6TbA/vpODQN+/qmodawM+/aKJBrPWt/4lFmDzi8LEbQK7v+?=
 =?us-ascii?Q?LeEoWLaKbZKE+AfEIFZgc7qjs/nMRGsW+GE9+CQrOZqrfJqdoeeylmt/IRaH?=
 =?us-ascii?Q?0GlOvMSfTi9qZVJHiujebmE79CYbEaW8nOPFU/FIzHtc2dywa1/I460EaUqt?=
 =?us-ascii?Q?7OWYfKJ3izKxxr5X39bzKAEiWTg+7sY+lsuCILRiIpdJK5MNlw4p7P6U8iBx?=
 =?us-ascii?Q?xypLsEdE/rqM58h/OS8wlwkxlzxZSy6G+i2y5tA3ALAE54JHU42aCa8KWeaO?=
 =?us-ascii?Q?EhZW6E/OUlnLd4Z+fb63yf/Epb7iWZDPxwt0wwe4oFRR47DYozO1SqzBV/RQ?=
 =?us-ascii?Q?hkjbtHBepCsDj5A4tG/Szg6h2PzBgKQfuY4NmcWT4OhTM3byJiMUJTd89xZq?=
 =?us-ascii?Q?juOIMh9edkF8/XFrbSDjmezAdSI3OwLcX5Qf0KYgVV7PQfdXiL8BHf9R4zrQ?=
 =?us-ascii?Q?Yg19hQV+yrSQxAi2EqlUBLjBPGFOSvgfEwvpYYjwOsEdgEEEFzHox/z80JdW?=
 =?us-ascii?Q?/DIxzRJk0opYHrysCckz1I+ISqz8Mkr7HkxsiV6Hr6Wlq1PaYIsJF4w2O1SU?=
 =?us-ascii?Q?0vhMmKuuQ830/Ofy8cJFHt15a9P42f9bRM7yXYZ9kbsSV4W7PpcvNIFr0msu?=
 =?us-ascii?Q?0Q/A9jFyRTwMl3Kn+Ihxd++ACgIk73TTkfLeD7R5o8QnZmf1Kb2Tcq0wUnZ1?=
 =?us-ascii?Q?7rCBCMwi4HuexBC2ikuI+KTYjEwhtj9HANlYfyS89d79tfptH5o8mHb9wj/w?=
 =?us-ascii?Q?WqPWiW8htnq9A2PbdZgk+XaSmYQeJrkqTkLSeGkEmtI3ggCBBLf+u97IfpRe?=
 =?us-ascii?Q?5nNXBmhbp1Uy9FPVQ0iKR8gnL0c2UM9NupxpMlCzlxdK/0qj1OAshJGFEMcm?=
 =?us-ascii?Q?1/BGIuphyU2UXfQAlP9SuDOBi/DJWtKcEqPRwXogYKdTC7BBdSsx4E/01XYr?=
 =?us-ascii?Q?TIfxhO5yu3ljB0TlV9YK2STetE+LU7mHRyq8X4G0mQl9da1T3uoMInHzLU3n?=
 =?us-ascii?Q?GS3CKRuRUQOmPTr2KPB53Wbu9q3lFlJAsz7dz5p/ry50lyVHQTjtkkZz77EP?=
 =?us-ascii?Q?u8loKb0T/eNUQsYp8EWSlpadnUM9Wn2jsftiXrmrgRDCTCeMmpvZysGNEePt?=
 =?us-ascii?Q?YzziOBbAsJQtITVe3wH1I6mdqVMO/JwCKmwtKqIS6KMKDgX37f9oXbA7KwBt?=
 =?us-ascii?Q?1hLZAU4nj/y3ChUyl/d9o4yYUdFGKFGxLAUISA4jlA/eUOH3O0D+ykcA8yZO?=
 =?us-ascii?Q?4ss09xstbQpHBgsVJcm/QeuFQL1mfQJQpQqRPKKy3PhrEUcY3ebkrNLx55tT?=
 =?us-ascii?Q?UqUGFZ9AxPwNOUIKbgzkDVixoLDkdmrZZr5s/MficDJeBxu7zMNmzQsxeMpe?=
 =?us-ascii?Q?r//X0+oArPqHo3GwcQsklnLlWEaxymH1RJt92yVAQCx6vaKhXsHYp7fIypB4?=
 =?us-ascii?Q?MJMulA7O7DQi6BWb4HT62XS1Jkz9F80MEwtUhiuH5+y1K1NGLiwycIlIstIa?=
 =?us-ascii?Q?RbcsHtmRD7jdlpfQZBMGHZuHhxB3pfpRezPqTJ9H8kohs0XH4u1RX6fhEAMM?=
 =?us-ascii?Q?x45eg7EJ2PJb2Zr0QBguUBnTe95wwx0bXI/ESw2T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959bfea6-fc98-45cc-9b3b-08de10167806
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 20:23:02.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWNBLFeSOgCM0Pp/DAtJ2IufM0ZkRQqtSZrj+xup0T2tZ8GpheyUZ5r8FlX6OA4RHG/MJZ/T6SR/pTyCkuogRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7391

On Mon, Oct 20, 2025 at 05:40:20PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> If no free IBI slot is available, svc_i3c_master_handle_ibi returns
> immediately. This causes the STOP condition to be missed because the
> EmitStop request is sent when the transfer is not complete. To resolve
> this, svc_i3c_master_handle_ibi must wait for the transfer to complete
> before returning.
>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 9641e66a4e5f..9cf9fb586e92 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -406,21 +406,27 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
>  	int ret, val;
>  	u8 *buf;
>
> -	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> -	if (!slot)
> -		return -ENOSPC;
> -
> -	slot->len = 0;
> -	buf = slot->data;
> -
> +	/*
> +	 * Wait for transfer to complete before returning. Otherwise, the EmitStop
> +	 * request might be sent when the transfer is not complete.
> +	 */
>  	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
> -						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
> +					 SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);

This is code style change. Don't touch this line at fixes patch.

Frank

>  	if (ret) {
>  		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
> -		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
>  		return ret;
>  	}
>
> +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> +	if (!slot) {
> +		dev_dbg(master->dev, "No free ibi slot, drop the data\n");
> +		writel(SVC_I3C_MDATACTRL_FLUSHRB, master->regs + SVC_I3C_MDATACTRL);
> +		return -ENOSPC;
> +	}
> +
> +	slot->len = 0;
> +	buf = slot->data;
> +
>  	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
>  	       slot->len < SVC_I3C_FIFO_SIZE) {
>  		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
> --
> 2.34.1
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

