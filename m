Return-Path: <linux-kernel+bounces-855414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77481BE1263
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD07C19C7205
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06FF1DED5F;
	Thu, 16 Oct 2025 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Px+C6v7e"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FE20322
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576579; cv=fail; b=TlzuBbP7rKCLAiNc7wVKfpLo5wkdP72W+pk+5xv/6Nhk1PRHp2Gc+WNsdDJRQCfiw5o/mWr0mDbk1Rsp/3UdvDo8VjanJ/VNIHDBrWev1M+NM+tNXEAoeT7d/kP/gp4tOhfzpjsWQ3rx1DvyEkyQ2phZ04phTV9Z0BuVA6ZziDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576579; c=relaxed/simple;
	bh=Sjc3ECflNYOFfRxyk5tytNKwzFcJbNuNk9deL66KfYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cjh9UjNtuIQ3i+Rc4OvNrKzp6HjAhs42lSZfIxxt0pX8ZIVYVcMD3LwFUqwbimHlc0GzkNQetRrbBXYkbgLX0sHsMDp/IOzd5cqJinaSqTe+UNj15QnS5CKYjsPGt9nT3UD7boccL2Ue5hyGWQPkq7nHYcC48VN5/XXMmqPbIFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Px+C6v7e; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yb5HR7nhZD6ziJlj4jssrbCP7E+3mZLL2XnmokMoOH/XA+GtkEaAgnwt2BjEm/nK3z5WVuZGIbOX7M3YuYoi37XPPzlXeJt8YjPKt/KbRhXISYvVjR45lsGvXGWq646f3VIHgse+aHyoEFYm+CD6upa1oJfdMVojxOq14htuALKzao6mTykvpRTkppQ6HUnWCikTEDhxL4k/69vRAh3QATXy37iGFCBA2KU/J2GdgfMeov/934s1vjD08D2pn/prWOKZiIdePh+hH801cV6ZySMgHun47DnMIIBi0aWEwc7vLTDxwdoeHX/zpl4bPv/Mfv9jtWJIUh0LXaDi7S1q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y7HibgEU13y4/QAvkiEOGLUDy9enRfoJcRFa5KL6Zs=;
 b=DCvVER8LICJgp/QHyJe5bWHVrPQkTLMezahwL7SKdpTFYoK5fkhxBz7A/fQ1iClD0vvUs2OAOUDKO98d5U6N3yYZhQth0SpyLvbylxErxJzp1HzgBO97jrHTsz7hqGXXUyL9WE6EjgwU911geL3Kvs+OyE98XaI5fQsag4OsqRCZChwlS4E4sBCilgOZVkG76S84Sm4XkRveyOBEi6c0Y1s+ezyXz7969CEso7bWCTW87U2pnxO8KTdzn+WVvIV30MlX97AsZhbN1R61sXChOs6zCJkUB0wjKmv5n0aSbap+cy+90R+qLadk7lCgoLoNo/2BcWwTY9bAcg7NLF+i/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y7HibgEU13y4/QAvkiEOGLUDy9enRfoJcRFa5KL6Zs=;
 b=Px+C6v7ekiNXllfP5Vvk9lCzEDThJjd/ygtaOd9f6TCTVrGS7g845S/vY7RZs3PEeDV1+acgg86EM65cBYVp9GUtqXt3tLMaDknoAaJ7IX45V4dRjoBzJdG+D9Afli+InvagdMagqL/mBZhfqtuSrPneClcuHUNr4QOE5vfD9xqKBSLg/lv9b8bdl26CVRm3749P5ytiRLYcn0HZVWASp46mQ29nyEjSatU1daor6SqxaJTdeRPt1gB6fw2eAI+dzTpJjcZ5ivj+QqqxjZQED5HuU/U0khamL4sSwJPyF5IP3Z1HR66WL/KA4x4FCsEof8w4DgXpxk86jbHwEQh+qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9715.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 01:02:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 01:02:51 +0000
Date: Thu, 16 Oct 2025 10:14:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] firmware: imx: scu-irq: Free mailbox client on
 failure
Message-ID: <20251016021459.GA3592@nxa18884-linux.ap.freescale.net>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-2-ba00220613ca@nxp.com>
 <aO5yPLL9HKdM6yuB@lizhi-Precision-Tower-5810>
 <20251015135503.GA31091@nxa18884-linux.ap.freescale.net>
 <aO+wg4I1IFxQQ7rf@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO+wg4I1IFxQQ7rf@lizhi-Precision-Tower-5810>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5406b308-e277-4e06-8a24-08de0c4fba16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h8S9cnBXlaPQHhx+xka/xuYUXhkHC7dppj5INVfRuctf1LJLQFKrbh0KjkyM?=
 =?us-ascii?Q?Dh4/zsu4aCpiSCqHPdc4ZAG9y4CcSOJRPKpTy8/LToxijT5ua/eqsdfNeEOk?=
 =?us-ascii?Q?EMVzDm4hhXb6APXQNcvDclus+P3gu53poB1mY2PZjnfmDLeZWutWxrC0I3Sc?=
 =?us-ascii?Q?c5SywIC2XhUJ/muXx5ttmhGHJ4hprxxrqahvwfHoHm8WZ0PxW0bX+wOUU/DZ?=
 =?us-ascii?Q?DS0CwdHDbpdDusuxonH4AV9TqENtCIBXAbI1EBAmzfuNxJbHUwHZAuww37rb?=
 =?us-ascii?Q?MKXYffq20pdy3SFRpIh1GN5hzPlIDipMVfwssAnwW/GQMdEMC4KSxcHBfLrH?=
 =?us-ascii?Q?Ka7arPoc5dMFpY7URCRCpCXROH++FcBQFyL9EG+osKFtTrCfc7/qCkMSgd9o?=
 =?us-ascii?Q?SLPSX/0n4MUrIrI85nAMH9grIYb4gA1Bb4FTXXUrQb9SbHDmEEQ66045is53?=
 =?us-ascii?Q?jHS+mQ8YB+TcWSK7AhDZp0jkcxK+fzt03OwUpR6eh30ljwSCA+P6AoATUmmo?=
 =?us-ascii?Q?gMrvAAzlRnJlLx0GjP/olbUp9+sS3tlzGy09kUwhBg7t7mDznPPiD3QHSCnY?=
 =?us-ascii?Q?SQog7UBKtnpCgIT1FLpEo4Moy8AHI4yU8HZAMkkM3mrW3hyZF2BDYKhC8DEY?=
 =?us-ascii?Q?NhskBoyximdROgodyJ+sRcId6Fx1qS2w+Jo2DLVaOSFZnWekiIoI5nG/sDe/?=
 =?us-ascii?Q?5tC/8JyRP7DCRGQsSEemGV0oEeqcHgfiHdoja0sgfQLtZ24MniU86v1lFWWP?=
 =?us-ascii?Q?Vlwel7Hj9dwe109Q0N9cS/oAVYoQxTNkzBm0F+WjsZbIQwd3FVA/KvC+9rrW?=
 =?us-ascii?Q?Y8GLLgsHelpj0IsLp07ilNgJI5rwRYcDudia0mXm5DpQiqgK6n94bGCwapYo?=
 =?us-ascii?Q?l/r3Ls1NgUAKSUWPARkBM21jrVIR8t/isN6rg6Kq0IjELDVYiyohujVcDBk/?=
 =?us-ascii?Q?oB5mzgn6exm52MgIVQf3EYeL5WXuHz26sH4oWN7dH5lr8rIaAksrYqANNZes?=
 =?us-ascii?Q?JJh7O4rX7HAKzebJHx7vHeWNsBjl1owPgOojleZzzcxyJrY4KY8705u3+N6U?=
 =?us-ascii?Q?Ss1P1H/VTGzUnNpWNK2/NCm0ZX6fFe0zmJZ/8qNfGZTf+5ObQKEsyti1jWvx?=
 =?us-ascii?Q?wmhWIzWnqcsV4hlWGnCRND1iqZxyLzpR9NMqlT0vgYvJFOiLluU8VoisHly4?=
 =?us-ascii?Q?WyR8QS3E/nos6C+FS3sL9/+SGmw03M7AlHvEKGZ70hpXKoAbyHkBVLbiP4z5?=
 =?us-ascii?Q?I6Yd4eQPodAypp6SqcaUXH2gVaNWokTAhQjQv7scgiMlrX1WegKWUIqso0xa?=
 =?us-ascii?Q?0aeAnpbus+/2vFi365DIHWwDI08a2NGo2GOO8E+I0JnHhCzOEVeBfmwdBgRO?=
 =?us-ascii?Q?LUaxTSIj7gZMOI0JDszIeV7YNwsYPgl/3oonBrOS4PhraR7f6gWVg6tk6LLn?=
 =?us-ascii?Q?qWgVR3oECfrZ81ptlRhZnOrPV5pV33O9Ouam3lMWb+zDfH7WPPOB+NVjbJjr?=
 =?us-ascii?Q?GSubuQSNmBXeR+b6HWKg+/uc5OAIPfTpJPLN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1TCc3aQyulwqpxreEq2NOzdfCJ5SySAiEdsOPJuHabJekmAphK7z0o6yIEJ4?=
 =?us-ascii?Q?6rdABn5P2q4Qij8i6UMXqOFt6vw565VCiGeYR7HRHkpwiCZVB4sWkqp6UKOv?=
 =?us-ascii?Q?AzUBn7/Zb7NcZylNqjZkTA08KDbsJTY/p7u4w8HgeiOyo6gTacZA/KYzEQa6?=
 =?us-ascii?Q?tq4dstDqowtoPYQ7tzHhe6E2O0lUsVU7pdHXAGPvk2yo4pBYbbpsrtNi4lFi?=
 =?us-ascii?Q?a/bgcNibN/xpwX3lI3Pg/TMHWYdawbGO3SJ39i8gljpqa0xiBf4Du55JEODz?=
 =?us-ascii?Q?3SKiWc59iv23u2z7J557vNh2AJocwbKjkxfwqWC3/MTBzY9ysGB7TjjK9FKe?=
 =?us-ascii?Q?Xdi1YJcIpcxGMMm2KiBkeyv+U1qhKiqBwna+ZWek3foJxKPexmylL73Glxek?=
 =?us-ascii?Q?rCgRY0efefHPo/zZ4AiV3xKNnkS7yZTs7WcJOr/p2Eq8nwGmbMktILj5zLEZ?=
 =?us-ascii?Q?GTiTRKX0O/Oba8Xn3VEN9OxHfdYgjonCiKSbbkC/bIbuZpT0QKMAzE76MgDT?=
 =?us-ascii?Q?9oH+fLyElPLlGrNh9+7JO2pPSPkDi8SM56hLQPQJ7gkAhfkVAB2UWYiXcoa6?=
 =?us-ascii?Q?LsxWlVq0g9vJNPdsqV8Gme6WKmCtH8rQMlBZtfxcDsLqlmDA1N9rW96mEbD1?=
 =?us-ascii?Q?hgOnU2z3l6PIsvFETD5K76knMf+oW0Sh/yrr2TGR6L7Z2kEzo44FLwCo4iWY?=
 =?us-ascii?Q?CcVymvv2m73O6k4ix4yVMXGP0C9tHNSzbHOVKrElxmI241wfmLfWX0l+ru3e?=
 =?us-ascii?Q?3nDMsxl6gkZGNLJ0MbhHSZ7C6qUGGdiDqQ+sQOVgUhy+v2Ug5MUTwKseK0Av?=
 =?us-ascii?Q?DRqPw+GM/MNdFMKbsdeDGk0BV6pJiw+q0CoeEm6LaDIr35lrUKpsXHcvnRCK?=
 =?us-ascii?Q?YQEN1hMaT5ToZPis4ZkWLR3s7ybxxsPQePsOhfM470N1LYHHXwOnyIAQLER4?=
 =?us-ascii?Q?EyuolJ5BDa+tifOlUu2g0zJ7NKpWmKNpu5fe67xAkOQwkKBr54FlFxSFlvPb?=
 =?us-ascii?Q?goMOAuBxFbXe7GUy8EWW9fBe29OmuTstD4wXieow/Bm3vVdpHwLTD8hcIufp?=
 =?us-ascii?Q?X9sGGLbV9NGtLH1escmXHu5TjzXshuNV7UhKCwEEu+1OS2W95AFLEWwVpNc/?=
 =?us-ascii?Q?Khem4+0yBmzT5M05RfeHakNs8USCa/ml4ITyWHYyPZk0EoYPQEw74sV1GHbP?=
 =?us-ascii?Q?Tdxl0x8KyXf8hvaMNSkWjJzenb6PeAUz/m3qNQmxiYvk71FnQH+aBRQRVgcM?=
 =?us-ascii?Q?WMa2EzR7849wVPtM+6QsbpClXFdfiqtzxN+Q/OnEplLyhquTTlhIJtHe7Bue?=
 =?us-ascii?Q?EvIkbe+C2ttkfJNGfm3w4Kfy76lTzRg624xlQvIpombP0Fwh1ru+nhproJ0w?=
 =?us-ascii?Q?bWW5AMG6GOAflJV0i5IZ+NkA2UYPTpSOUbmxH20Fsce8q9LuTnMxApUnn0ka?=
 =?us-ascii?Q?sL8IA7DJDDiXgznIK1l0JfAGdO184Pi8ii9cZ8fM+07YQA18ulSbreRy3szU?=
 =?us-ascii?Q?Z4ImXOlG1+kcqIl8o0eA3w9xzR5KSJ8VmHx/M+9SHFTjNs4qLBd2Gq++VaET?=
 =?us-ascii?Q?YjaGxOEEk1n+aSU7SG7uxGmovEC88N3gM9kygXA5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5406b308-e277-4e06-8a24-08de0c4fba16
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 01:02:51.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC+9VCrkavzPW73TxQQ/U4IAbbaWYgR85De3KFZDcmgrrNyF8JPeAaeyLECYLOqdsoEunSAX06S0PXJKitcfFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9715

On Wed, Oct 15, 2025 at 10:32:35AM -0400, Frank Li wrote:
>On Wed, Oct 15, 2025 at 09:55:03PM +0800, Peng Fan wrote:
>> On Tue, Oct 14, 2025 at 11:54:36AM -0400, Frank Li wrote:
>> >On Tue, Oct 14, 2025 at 12:54:39PM +0800, Peng Fan wrote:
>> >> With mailbox channel freed, it is pointless to keep mailbox client.
>> >> So free the mailbox client in err path.
>> >>
>> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> >> ---
>> >>  drivers/firmware/imx/imx-scu-irq.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
>> >> index f2b902e95b738fae90af9cbe54da4f488219906f..1fbe4c3de5c1592bfcf2334a83776c25d5ca7a3f 100644
>> >> --- a/drivers/firmware/imx/imx-scu-irq.c
>> >> +++ b/drivers/firmware/imx/imx-scu-irq.c
>> >> @@ -255,6 +255,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>> >>
>> >>  free_ch:
>> >>  	mbox_free_channel(ch);
>> >> +	devm_kfree(dev, cl);
>> >
>> >
>> >you use devm_kmalloc(), when return failure, framework will auto free cl.
>> >
>> >Avoid mixing manual free and management free code.
>> >
>> >So I think this patch is not neccesary.
>>
>> Actually in imx-scu.c, there is only a warning message if this API call returns
>> error. So need to free here.
>
>what's warning?

When imx_scu_enable_general_irq_channel() fails, there is only a warning
printed out as below, the probe continues.

        ret = imx_scu_enable_general_irq_channel(dev);
        if (ret)
                dev_warn(dev,
                        "failed to enable general irq channel: %d\n", ret);

        dev_info(dev, "NXP i.MX SCU Initialized\n");

        return devm_of_platform_populate(dev);

Thanks,
Peng

>
>Frank
>>
>> Thanks
>> Peng
>>
>> >
>> >Frank
>> >>
>> >>  	return ret;
>> >>  }
>> >>
>> >> --
>> >> 2.37.1
>> >>

