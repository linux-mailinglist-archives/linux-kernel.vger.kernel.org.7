Return-Path: <linux-kernel+bounces-836072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A9BA8A92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949A33A26AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2121E1DE5;
	Mon, 29 Sep 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xJXHuAof"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D43288510
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138509; cv=fail; b=Tf52VF8k3H91tPXwggqXaxTt0DAn1Fe8jRgd1eBQbB+XrzEh6Z/BY8j8lzKRqAmRVsWMDBcKRSGyvFnuca3MbKtYKdLhLerij64UZOKgi6V2aG0XnuZvtC8Dbpat0sM5BPknZVOKzWDyx1xky1/ylKF35AcFidLh+XCTEdFqph0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138509; c=relaxed/simple;
	bh=mlbnu9JyoNUB/9FqxY14R24DN1FC+w9nGlFigW44GT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cmWWJI/i/N4oNFvqn8bBi78JzmKekSSiMx+Qq/EuCX7Rg270crpSTy4So4mV0vgzuc3orn+A3VxkaquISPVFzkvj4SrwaHoDOyUnpxLGs6R1rZ+Ve41BZzLs29Z3Gw4Xp8cxjUV3UhoF45T+VnXbfNz+uKIMlTAH5ih+WDFC3q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xJXHuAof; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dagk7sIPkvfjTfkljheF9BULcm2II3KfJsZAtM+umfNwktT0Gu74hj5U8Llbd/J+56YSUJRCaO+m86yFXSlA1ZeXfJtMjTwnpyvL7AxMKzGVzvdbJfEeneSoa03wl3fVLY4+iCRjblfKXmzgZ3kACmFLzvj6AT+z5GyTJgSuWlbuDCZGyHvS+GZs59aw168rvblLxMNBgJ3v9wCwl7E7j/tTSadYIBVERdfnQLyKwOpWndaeBe5wFHdMCCVa0rEHYX3kZT9FJU5vf/lrX9pNOvhcREtZ6akDvFJ9lQMTONy9seCczSGXZPSE+2wl7YKeoZIgHSMUmsiZjn+epiqGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlbnu9JyoNUB/9FqxY14R24DN1FC+w9nGlFigW44GT4=;
 b=GzDbaW0AoqvW/oK5qIG3vV9Arhl4CYRqBsAw7+A52ih9qf0bE0cfQ7l3A4M4bgJDuX4sVHh4bK8wQuc2AlXRCy1j/1ZMr7/Lu5wUwFpn54SM/DokUaGwwDpTUueHDfWG08TLOSUKyRwYjhXLpS05DcOzU3JXzFygJOXZqK3Ewxmrz7UEgIki2OcFnEvzUp95SIn7wJOfb76ORn4/DhLwNg6A6+xAugYCQ8meFpgNj+ALRj8RjWBGRccH0IXvBcK8ytNbiCCttq92dpmtptoNncAckiAUFCG47vJFvbXHieTBqoUtjV4/Fj+cYG1C3ohYwoc17cK/nhqgzp96srhUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlbnu9JyoNUB/9FqxY14R24DN1FC+w9nGlFigW44GT4=;
 b=xJXHuAofjUpUQ2FawUjL/eMln9c1kp2NWdguzCUSrBy57sIHQTMq2vhM7lBCHq00cxyJzIh92gMtFUFvAnpSduUObkiimwZ6IN/Vx3mnOFyv71j5n6mp1wUXFg3JUGxP+yScgcFyJmQfa3RDsNqzjPCOMNjRbP3X5j53FHWJgHzS4YuRGXAazreM6JC6GIxk/adPzE13ymtM2S1xQ574lGdc59CkZcYPtRdfeFyNPhKPPuOtf70j7Ir8tY3VmJRKz2AY3Bkh5oWwL8EHdp10reP+UVpgni34OZcHbmdRCab14vuZ3+gfyqDwr0qIpA6CVu8Ddd9JCOWkdDo94h2uqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 09:35:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 09:35:03 +0000
Date: Mon, 29 Sep 2025 18:46:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Harini T <harini.t@amd.com>
Cc: jassisinghbrar@gmail.com, michal.simek@amd.com, peng.fan@nxp.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com
Subject: Re: [PATCH V2 2/4] mailbox: zynqmp-ipi: Remove dev.parent check in
 zynqmp_ipi_free_mboxes
Message-ID: <20250929104659.GB15568@nxa18884-linux.ap.freescale.net>
References: <20250929073723.139130-1-harini.t@amd.com>
 <20250929073723.139130-3-harini.t@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929073723.139130-3-harini.t@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe5c8ff-46b5-47df-7d93-08ddff3b7784
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8BWqxUF/sfX8WhdBkEocx3JL6OP9xNGxkBTPVekMK6BV0Dt0nqSsWJGQ76X8?=
 =?us-ascii?Q?p7zkjsVjDTbP2jNtEXbAu+MQOjfJPTB2tTRJUf7kTYKKmrccl/OcEpA4Ch8G?=
 =?us-ascii?Q?TnWHUc3asdCThJdKt2eDpBx7GwuOYQRkX4eEpgRoPPMbW9/J1Mv69H2yconS?=
 =?us-ascii?Q?wuAUdi5g19bt79kcJ+5gVVOfD66X2LUYipPlCH6SCjA/H3D3gaz+2H1mbwRj?=
 =?us-ascii?Q?B4sN23M9dMxmgJL46SnE+3cKuH6ADNqjkuQGbVujfX+aIxmHRSyinf6IME+L?=
 =?us-ascii?Q?knqMrYtdF8qRdIWMlhq9ALgoWJg68pHzvpTpSmCWXZ/Dpy3VbnPMzTlJcfvT?=
 =?us-ascii?Q?WZJ+2JomhnhE5YInjWoKvf7lGTFz+FuaTZSUsqDBuTYWupktwUaBrI00nGta?=
 =?us-ascii?Q?KKNQ0ICjiNbsUiRVa4XcBhZ+65WCgb1RZ/+RZI1q421sUgVu2fRyWQKdvy7V?=
 =?us-ascii?Q?EVjnnup4+INByoqftABkNsIhIPlcBNOtRaoeN+ZxbGD8SLszXYngvp9/zzHD?=
 =?us-ascii?Q?c077MuWrzsj5cymFxqPYgn7pblmqVbjz5p3vXYqo5zsP30EoSBm2Kojf3tQm?=
 =?us-ascii?Q?ggQg9URroRR/P+UkVGM10jL53Ztz5fIGJu3bCdaWsFOpla1fd0dc/IIhuSj8?=
 =?us-ascii?Q?VlvB22O3CK+hmmjO8SON+ZV0oobfBlPCnEUo5U79UIlicrn/n5JyMTQhHltT?=
 =?us-ascii?Q?YUBRX9W+mzdFmqwDh7kwCtGdEwRT9PTvubKT+NcZyD1k1NsCkWSne3uT1i7x?=
 =?us-ascii?Q?cqiBpcznBOsHtB3pDQEQDdhlhmpr8+VHMIHIa60D92v2ejjGz+HIAUDbeVmn?=
 =?us-ascii?Q?jiIO37SAZoGJia4x0YBPEQCCAuBJ95nSpvocb0S2dtwOoXdkd7rZGTS8GAzM?=
 =?us-ascii?Q?0r0q4avJyXhO5xJOnjlAmOITl3Xd2It8UwkmAgLVWezQL+uLMMSxaVKpbfSG?=
 =?us-ascii?Q?U9tIqT6N1L+72gfQMsM3BViqM0bzySydXIYFaNiORAbhY7Mx7F5osB3mgKY1?=
 =?us-ascii?Q?xUo7YsI8EFxo2qnL6yQcH9d8tESSZM+aT4rjSyWf3/YcpqWhxphe2Hkjdx88?=
 =?us-ascii?Q?OSuIb03+R3KgQuZs7g8Uqo37dYKEmW5Ebs2ywPSEKqVgeuUrQYVXOa1RiZzJ?=
 =?us-ascii?Q?mpC5mGSOYUnvSkBULK4DA4Tt7F9hO8i6XebH+qbym3cPpTfMnNdcAUqIurNm?=
 =?us-ascii?Q?fY+bH/f7WuMMrCUF0bwTsigS8HfZiC5YGT9GoI+CaxcmBM20lHjFuIXNsWWY?=
 =?us-ascii?Q?PZW3ApKYdl8yBoM5P8KEP4ATYKQP5sWbA567+LYiVthxJ5MQJL2PaX9MkcFC?=
 =?us-ascii?Q?X+T2kaRfzE4JQs7gbdQzn2RWx5IGeXNtTYv8H29XHQ1BHArhpMV/kjkBj5Nl?=
 =?us-ascii?Q?UzvCItEyJ/6s30y3QQET6Z9G/6G+/m23pHq4EIQO0KWhFzWp99RB18I1KXLc?=
 =?us-ascii?Q?M7jxz8uMpY9c4EXCdZ4GRtSJ7qFOV5DWPm0rnI5nCjCp7BILjVo7jmcSpMQ9?=
 =?us-ascii?Q?lqGtvz/y0Wd+1W9xT2SgMS603dkrBCUIr06z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBFtOKhsWvwFq7HkRop6LnAkPv7CxPPkxfo1DRqOAoMtXNQrmVcpV/5l7N7k?=
 =?us-ascii?Q?ArrZSCcYN1bnu+meKzM1gMR6AZGnV+VzPKZjlQcoPTfWLYDB+3Sock0y8ET/?=
 =?us-ascii?Q?RnRp1W7aGB7RQZwO4de0Wc62vddISFWuPjRsdui8S1m9pvxSZObrtca1oWUL?=
 =?us-ascii?Q?PePxAA8aOmGpdwGqKMwYQMfx58hzbjMfEnTCCxl72WHGWdSyI2LT4n5H2JZu?=
 =?us-ascii?Q?0kpEuC9VbcrHH9B5rAtHGkeTfdslmBVZwsuzeIswkqPC5/mYUGd2qhhW+SsP?=
 =?us-ascii?Q?DOnx9G85zon8+l58eA+FHkfD7rAs8/SYq/ifCcaFdseb69qBTRYMgoYlzmBl?=
 =?us-ascii?Q?/YY2TY0ET/frDWYj9Iz58D/SEt8agmQj0eruNxmrbeIGLd9umfXYIAZITMHp?=
 =?us-ascii?Q?hxDzHzGg785IJ0UUaERD+8u1yuzUm5UJdwKr4vnt+CEOlD5MSX/zgJUV9C/P?=
 =?us-ascii?Q?rtvPQfYGQh4s5Y87k+KYPW3NWZ3tQyg1UDVqzgG0+0cBH2iKNswu/k+0rXFG?=
 =?us-ascii?Q?lku97Fa60aKNflCEzrEN57W6/FdI5NuwO2UVk7QMpFx0r3lQW1JNutwl6l54?=
 =?us-ascii?Q?dreGyGe2vFr1fYt9LIY4Abfvyquc2bZOrFM3hhPDkpFP7gDBHIp0rPPOO0Ai?=
 =?us-ascii?Q?sl6I7cqc/TmFQvU+eX+xw5uQA565qhKb4NITFUZ+MQWMiexIipv2TTyBdq5j?=
 =?us-ascii?Q?deiHQuJzq1naW3gg9ZezOqaOw54QAFmGtE2NyHegx3sNwg8nj05+z+4CiLTP?=
 =?us-ascii?Q?3Rab0ZnDB/j3BpZAqdfEwDKQfDDlfjTDpM3QEEgrunsi6VmUOb/PbzDfgbaw?=
 =?us-ascii?Q?LKrjxhk28MmHbIEuJfimamIi4KGUN4ux16Rx/VbOcs3gxBLDMle2360txOm6?=
 =?us-ascii?Q?F8wcj0waHT950zjqXQkWqd4kszpcHpty3KQd7vhzNFlXpWUenUnYOuH7eo07?=
 =?us-ascii?Q?fRR8UB1lu+jj7Axnold8PyJsTyk5yEn/EyoX4YJi9gDrMlddTHryJAHAPUJL?=
 =?us-ascii?Q?eqTKPwsbwzHTQRIZtA9QpHWkF6S46C28b//bX/hCzPWcjiTWvfYzCfgp7jJT?=
 =?us-ascii?Q?4k5CUewTEq6w8W0zPGOluVP7zdtx7XWaCMhAkYRd0oGAf6vuJyoPiNevucqL?=
 =?us-ascii?Q?ISnD99JUAu3gVLOMR+BiCOo2Gpu1qIzTtLQ4jiFLCuP3Y4AbQI6eVp66/wqY?=
 =?us-ascii?Q?l94wDgtrGGeFQPgE0ZYVD9GKJLRh+fxRvZK/RhRVwW+Wv0kFap69rK42OXCu?=
 =?us-ascii?Q?xa81SMQZxeNNSA/QdT68eseAWww3l3VU7n6l52biCZRhxaRRYAJup3nitFUC?=
 =?us-ascii?Q?L003yY/1PYflU5+PyeZxr0XFtziBjOusX6Lo2PCkJkL6eCXs4w0NGShWJH1g?=
 =?us-ascii?Q?Fc2lV03MH2h2vOkMOhnmIzyaeyfsLAEH2TWtZJZ+iQ5UEGAVEgyJMfLWc2TB?=
 =?us-ascii?Q?Tm7GzlkUG7fcUBIvAXxopbHY8/y23iBGX3MrZ0UN9vIJsWthY+YyKgGnLFkR?=
 =?us-ascii?Q?99DTYx2+kceY3fRXWIiYTgpZI7cNzory9GlbQcTronpxPTR8ANVBC9wgnbZH?=
 =?us-ascii?Q?R/HXcxFPLCMngpJ905RtmnJHWTRRpKdi4DG0/UT5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe5c8ff-46b5-47df-7d93-08ddff3b7784
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:35:03.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5LfpsPsWd7uDxVNZTD7Qqdv/o3hc4eRyrSSTsagQa8dQIGc5VihZcyVZQZCJKJxOD6x1YxlkqeLt8aZof+kvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8251

On Mon, Sep 29, 2025 at 01:07:21PM +0530, Harini T wrote:
>The ipi_mbox->dev.parent check is unreliable proxy for registration
>status as it fails to protect against probe failures that occur after
>the parent is assigned but before device_register() completes.
>
>device_is_registered() is the canonical and robust method to verify the
>registration status.
>
>Remove ipi_mbox->dev.parent check in zynqmp_ipi_free_mboxes().
>
>Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>Signed-off-by: Harini T <harini.t@amd.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

