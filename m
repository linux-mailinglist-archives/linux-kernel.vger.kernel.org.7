Return-Path: <linux-kernel+bounces-855415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D0BE126F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFE0483155
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85E1FBEB0;
	Thu, 16 Oct 2025 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U8Ao2cxE"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFA20322;
	Thu, 16 Oct 2025 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576895; cv=fail; b=AgY601KmB0GurWdo1CRNzx3mYFpJ4YQrKg7fjuDSGUlz4LkAJIMnvAXOY2AN0k23HjWCQ7WB3ff6Mc+/rPXKLiihMB4It/HX3IvhXSUO8vKNqbTJd1GRtlhhSP1HUU9byUUNIYaPu9oc0G10esK8I5VQcHsk6SjmFnIZyzL40SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576895; c=relaxed/simple;
	bh=RFWNanejLf/PQmE9YZOE9nR0fcXKWdVITnOCGry3I3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YIhXwvZodg2nfWSL7J/VgF1Shl9nUvQav0PA5QuJUrORO1MEGpwUhmm8sdiEuqL2AlExyH/MFtgbxQVOUTXOCfQdNe5G5sYps4v+ZXe6EaIM0ht33mmR2pyd8zg921EpvqC88y0Ccbu4gGSjiWrnjBfS3ehx6xBKpIrw/P8mvVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U8Ao2cxE; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmvqXM9VnAu2SV6JAHB2EkBfjgm4+nkoxE8AXnQ+Xt1TP/GWa5RAEz+kGwIHV3Vy4BL5vK+M/9jlItiuR/yTam/g36HhlfCmgUekTlwUnLvIJyvO5N1gZsWmqJ9mupeedy5cl1zldmAGkVS8e+9TkfMN99dV9Ad2S0f4tbzkCjbiP+OUp0ls6faNzQFAv/LtwvEP1xeL2K+orgRiUbj+gM5hj96edpMqJy9en+dKvjnZTIfRIxm1V19eYURwkVhTGv0kxER5zkUKwTQE9KiAEx0ciaoa1cZLLQUC2wLvWZk3kHT1hnud3uXnyubDeVt3flCBbJ1Wo6GD6xPLt45v7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqoE63KIYeBu+gfBqDGaRh0NS4TOeyDJ7WB8oeFvrcY=;
 b=RycfwwhNvIqOnAxP2WYSvoDqmHzVPNSA951maTsfjb9r5VrXBHngN8ESj5wv5+NbITqWncM3U3Nmj+Z5wJ3Fhhpmnj2aJhNy84ZlRMmQvO5dBxZ/AnxaUYVwMdHlUEsq0xP8HTDqVCwpOzdob0Re7YwTIziwERRCXbXApqK/Rs4n+026J7VyCyXYhvFoh1bcOD1OibLcNpjuOSoQLwJoJiqYh7tgj30LQCPt9fyItuSvs8syqz41M5ZfYg6SMcNZYMgFyqJ8Z/EOKTSYFmFTwDcj8VPlhMUYQzVuF61IgUds9I/cWDTbdUO11dFersbH93hG3k1OFz6/dDzgIKppXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqoE63KIYeBu+gfBqDGaRh0NS4TOeyDJ7WB8oeFvrcY=;
 b=U8Ao2cxE6LRXYeCUxrASGuh2H85gZl89eLLJ1TFIpDgGAh3tzlSByJg2R3IPNYW/J2MkdCdlOh49n21X+d8W52b3STr8YOcpZVurRzqxvN2gqttqDW9N6QhmBmSwAR5RJ5dlFTG2yCSFXjZ23t8iZTVsra4JwZgU+XpH7sJ4IDu8Fm1uOq/ZPPsdnVPkJ52mb0HM7o2t7Z/SEeTg9io62p+RuvEFwX0ZzCB/exRvtHVHAFnJ2r9WQZpuJ89kZ6IjFwHEsJRsMpEpxph+nIh1yEOnLQI7ZnuH809qYgFrYjoXiPqkVtSGzpkLlWrtf7GXD24bmlVQ7I3O+8xDm+huNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9715.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 01:08:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 01:08:10 +0000
Date: Thu, 16 Oct 2025 10:20:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v19 0/7] firmware: imx: driver for NXP secure-enclave
Message-ID: <20251016022021.GA4629@nxa18884-linux.ap.freescale.net>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 37450d80-fb89-4084-6ed4-08de0c50795d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDwSt2xfDoLB7izH7LitUrkiEQsgvs/Ipj+0OSog0QHV1Im+aVUExUv7UlIJ?=
 =?us-ascii?Q?u1KdY/DgBnKOJHINtpk9yybLu4cntjJDvGzZKj8inX+qXPBfwdlvEVptnXdO?=
 =?us-ascii?Q?JD0dLb8yZR6Pqnj8pCrkJYvohpK/ZpfThKffaQAZ/azbzKdecme18NYeL2tN?=
 =?us-ascii?Q?5SAH3g8FDAblepNWxt2PnXoxJe3IJ+LCOtvDmm6BewgCY935cv01OcqqfC5f?=
 =?us-ascii?Q?8TcWfPZFZQSAjEi2kNLQRDA6xl9jyXiBrIqT0fyqjnX1hCnJltr7EQ2b4hPi?=
 =?us-ascii?Q?IEugLqkJO7RD0XSLQIONE6sPslDgIE4QRl692O+yNwHQdX1p2Ed7BMnCPY23?=
 =?us-ascii?Q?se8b6d5shFVXtn1kgbF3ZbaDp8LUu3A6R05PwFql/3L7ii6gBijjIk5jxjMY?=
 =?us-ascii?Q?MPvexXM8+cdyoQ4C8GuCLlAhqI587MrcgnwkWK3zCUVKU13x1JhRTsZ8NolD?=
 =?us-ascii?Q?g0l6npWiB7h2OhhDg1R+mchV4PQLIfGWXJwOBg6u6BkLqjBLXJS6PpsTaYQ1?=
 =?us-ascii?Q?Cuxm6niGqreT3NUd5R2sFC82w9CGQuDKerRTfZn7miEnBft/OO1nLWyvpSwq?=
 =?us-ascii?Q?RefLOd48mvXTmnANlY4oqevTmOuf/FdjaIslEjk0v5Oe74YmlZc7w+fhczQN?=
 =?us-ascii?Q?DagwlpkZV04Gl2lp9XMSgR86djQZ+ee91Hxg0E5PPCJbunqt0k+VOWBw3egM?=
 =?us-ascii?Q?RozqZOs7ct9SlcfRtrWh5GB9Ah/TfzkD+wEBppQwn5xksiam9uLS3DVcxVoJ?=
 =?us-ascii?Q?rDUvTxtO4JDQwU/N3MA0Q+T7G9kTL9nXxdgYiWyzvC36RSkXZrHbJDGpiwH9?=
 =?us-ascii?Q?rKGbqDPIDdLmWCpP4zJSKEsDSmzQvFU1qDIi0CAwwo232P9aHLCFFuvjZM6u?=
 =?us-ascii?Q?GtiJPUSg63q4pR5+wsH49HHe1ajBqAZeyDDdA/iCFVqytibra6uDdt7EEmzA?=
 =?us-ascii?Q?Ib8Xl7j+9II18/+1OLsGRWhNLtnliVO3UAP8qrY+62NMf8bjOXcZyv7dNS6Q?=
 =?us-ascii?Q?NNWB7EpPb/B6qM21Ku9WvQse0F3N1nMKmyKB/6WkcC6Mx7swzNtmUUpykili?=
 =?us-ascii?Q?S29KbhZyClBDc2di/H7aeSOBqAaQBCqTsOzAYZSbAUVsI9YL+qGRk2Av0mgs?=
 =?us-ascii?Q?J4lEVvRvZXcKzfyN8JawQ+TnN81NQOshbHMUZCpuKE7rZDuzk074oamgKFkD?=
 =?us-ascii?Q?DGWvKg2Pr6wBJ7f7yi4L1pP/0fYBQyy66xqxm52aTyMQFn/ROyfpmgT6hRfG?=
 =?us-ascii?Q?6sEKXWCiU1i5SnwYHYf1kEC2aQKgPPY3eF3pzyhqhE5IDdbrl1w3rDP+0ZZP?=
 =?us-ascii?Q?YSU3/FcISKgqDMA8bbrYN6/gcTKxzrnmOU7owjc2ojVjQLc8R+VZPqD9coip?=
 =?us-ascii?Q?GjGZcJmn9te6Yue5HR3+FXIC5Qn79bSGfsxfH4K46nf7RSa4pjOWXDRFfqQa?=
 =?us-ascii?Q?GXo37clJUHDE/bMfewz8laPNhoWPDhW3ZM2K+l/94Aw7r0Mw7AH8cxZOaz5a?=
 =?us-ascii?Q?96fp+zNs+CULaD/CtYnHvWyMSGatBKpzdSmO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uMbg2VBJr5hTHcaCGvGoZoYcQycYUyd8qgHtBx2KXCAZdK8v4okfHAaqmpss?=
 =?us-ascii?Q?YgYA6jk4cdN3hm5hC/VPv6bv1XlNOmpXIYSZ62wBquP50mB4eJ/q2ovfCUsM?=
 =?us-ascii?Q?/SIBDVUJXk5MCqEIrQWVUOPMzIZ31mJTF+8FIJHIhnKskOXYpTq0fxe9u9zk?=
 =?us-ascii?Q?KyxjyyZ82fthCwEdXGAFf+XFZWEseJulNxuax8OiP0yIS4Cn1rjygK8983Om?=
 =?us-ascii?Q?7hVLM+KEolLw9R6FdmAXLWUe0ettZvyGzceaXSmRo88shSfZlI8qgS4KYfnj?=
 =?us-ascii?Q?elVnv8riIS77JyVqu2MxwRKN9kJYOv/TzJWPRoEOLgKNxt0OYapJPAUKr8gp?=
 =?us-ascii?Q?Li06cq5Oqh7tD6nJNXS//NQOmhkpYLXWbVvFTeCclBJ3XV1rAtI+mku1wrnp?=
 =?us-ascii?Q?l6m2g0muolL2/vUHWO2vAfpiUvhvMAkfv6FRSlhi2vd0ziMssCw1k1Ny7Wgi?=
 =?us-ascii?Q?KitMduE6R2nbK+mK6teH+giSZiO/acemO9EEpL68dl+IbkU1YdVzAqpA14OO?=
 =?us-ascii?Q?HU9yB6AocCC8YGSY0Az/UBukAMmrUnqAqlKsghCjc6kgVvE1CLGoYYG1FTZR?=
 =?us-ascii?Q?8EPQ8EtNSgce3MtVqps0usADkil+j/aoe/SW/2OzkzZB6ZmIsaJ+7m8rhulS?=
 =?us-ascii?Q?HezLqZmTK3pXiwBc8Nj6RpQXMmsj65BDBhtmY6GdcQ16eIncxxaZcLFU7gQy?=
 =?us-ascii?Q?wSKErNqZbQznv/XQ4v3AIDU4BebwobhFt4XidaHWgfKtlv0hQibkcXZovkFw?=
 =?us-ascii?Q?Xksr54Bd7fAEMvHrv0hnFIZ4iSTe1C5aMLkCVnDG0Mt0prsoxq4mUdMXHqHv?=
 =?us-ascii?Q?CM4WO4Jn13Up2NvaXCUrdZDzYpZeTw32IhMshzWhsbFUjdtQU3I5BGJVZJ3N?=
 =?us-ascii?Q?2aLW6Tgm5SYeaw1lmqvhfAZ02Nj3mBgYVb+jQA/s7fLbGgpItutEkpd5bpZR?=
 =?us-ascii?Q?Bt3Ek5Y4p5Fhq0n5XaDxPoy9CQ5IywEP2cQAgXQ/YZgYBfl0RWWj0IqK3Gxa?=
 =?us-ascii?Q?EXDPFkgEMWuTYNd4/CY+8Vyk7bh45p5X3DOSlZNm96uw+hMegNRTkq2IwIk+?=
 =?us-ascii?Q?g2AB/bYDtG30NOJ2qfZySXrluVgkvv6cb6Zntc+rHvH6Xabzj0+mJ92QgT25?=
 =?us-ascii?Q?VJpHWamBxmY2qSSN91jIAhbC3zAEhQaT0M2DGP6Cmm9ga19XLcsne7kHodC2?=
 =?us-ascii?Q?Wr9k4tCpUM5FKHUA1TkSSKNA6YiM9Iw+jY+Qa377F1CqXFGWKW1Kh3N+dLTy?=
 =?us-ascii?Q?K1hR5snc+BbdlTkdidlSY7heLWRbc5WT6+upg6GpG1lmRoC10krdMYUW7tVY?=
 =?us-ascii?Q?p1jMg0eCj9FO90SHPozZn3TJU6rhloTjOxvj3NkVKDr/TfVscgeeVk1f51Pi?=
 =?us-ascii?Q?vVbHRkyPQg5AupiHYKY+FVs2EuZTrLngZGCmPaGaTGCpfRwoYkIsGxjHpByf?=
 =?us-ascii?Q?jcpSlhFIt5LTM5NPlDrMvKJZizRr54nIlUtSsJ65Cq5n8acPn8jGDPVmS5qk?=
 =?us-ascii?Q?VGJegYCQW6cjXomt7US3nE6NDJ48pQjw6tNJ1Nf6mjtHw25ZJXPnd0jwPOTy?=
 =?us-ascii?Q?nZX0qb0B6t/lqkHhYZ+P7uAQUvWOR1kO2Ba0QywJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37450d80-fb89-4084-6ed4-08de0c50795d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 01:08:10.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJM0wBrvfUCngEhcPs/xTIDQK4wt7mx9eIHbquWQB+s0RqYq5ArnRZf4PMwZrMHTa/7j6w58Y5acSb9eOojTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9715

On Sat, Sep 27, 2025 at 02:39:30AM +0530, Pankaj Gupta wrote:
>
>---
>Pankaj Gupta (7):
>      Documentation/firmware: add imx/se to other_interfaces
>      dt-bindings: arm: fsl: add imx-se-fw binding doc
>      firmware: imx: add driver for NXP EdgeLock Enclave
>      firmware: imx: device context dedicated to priv
>      firmware: drivers: imx: adds miscdev
>      arm64: dts: imx8ulp: add secure enclave node
>      arm64: dts: imx8ulp-evk: add reserved memory property
>

Tested-by: Peng Fan <peng.fan@nxp.com>

