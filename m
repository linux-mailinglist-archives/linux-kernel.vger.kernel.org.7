Return-Path: <linux-kernel+bounces-891016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0F4C419DD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AB11897235
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B0334C09;
	Fri,  7 Nov 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ANxGoV1m"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D031A7FA;
	Fri,  7 Nov 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548305; cv=fail; b=Zd+fA15yKqe6TzQLSAuLZBE0ls7H1ch3aQmmPf/a4gpZ0CvaRrIqASVNNLpegvU7EmVw0ojI84Zb0SNKFK8SQZCKCOlbS6ArEb0CffCQ5WyBnDW0WwCSHIBcp1GaXMICyat5TbpuQvAyVwQdU6Qk0qJBICjurfil/yv4qh6ozl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548305; c=relaxed/simple;
	bh=R7ovjweknMT1smYhNfW+CkGH+ciRJsLBhqOQFmBU/7A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c5drmqTEJliv4HtuR1qeatB5ult+jZCXfrRTwiyKGDUt6dRAGWAZi3nA2muI5LRMvY2LIRL1gQOS9FubsknCs5caxk7SpP1p4GlccvKtw8BBiW1iDSctQxmhW2+O+wZMQpjlmt6rMaDkUUFtGDhWDXSWazQunVBu17VFn/zIx3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ANxGoV1m; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYOxeXaT5DAUQ6YO9jSSObgZMsNldnzqlfx5RuPo2XTcX1jmHVpeOYtNVyk6jmBmBhHNkSQbcRt6FdtXg+dh3r94ANzkcsgvwWCJOCOkGZJcY4SNv4uV0EzjprtrSvk96X89zoXlrgaN18sPICugLwwDTaDTPIVDxWpiB2W+lCy3poNxf9FeXN+7AIjV6NZgbOJmQumvj3JPgEhZ/wstazKNYwALyRF/DLTJtsPU/F3a9X9x1odQxR34O/6hbFx4hA9G4jtp2JRxXB2TQe86WVujrhAwL9/6JvZLSgYZ3Xm5JxZuLRud36wkIPMLaTw2GA7gN7OPUtWvNW8V9YW8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3YW1+agbB9Z7ADXl0RJ9xibS1sjbATtsscLVMQ5EmU=;
 b=ONx68/kAhhV2OJEGIlV0WiFc5JIX9v/8DPnJ0DE2+OD2WRcx/g/mqJ9PUKNnKUefxGS7hZKoEQ/VKYJ4Y75/S3qMiW/xlhsmlMjFoLWUOuMLHn2ud+1C4TGUkGxOFgRkGoleOckSLqEeOVSA7gyRrPsjh8Vlv/2nyz6pNU8q/d9JXgrCmd3E2EyorxTvTppie11lRExy908TC/lQc10K1GfXAe7yELB1s59jEe1QZriVUCIVvFN46mk+xeMpRRcL9LEJnXvsKz+7nKwqsYxpgVfLAPzyh+gZ2RporxouRRmcwZE4ped/bAS3rZxOongU3T2rhUkDGk/wk5v9jCzRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3YW1+agbB9Z7ADXl0RJ9xibS1sjbATtsscLVMQ5EmU=;
 b=ANxGoV1mosJo9LR2/6oXSMCGxRM6drNac2yO0fGHLxFozk0HHpe12cHzJBhnO3S0baW1IoWajhx42S9ooOlX3K6DnPqVbVoOi3hlHgyuQDJoR9fPcPKHuxHaRsTF7u0bLODwBd+gdgMWFD/tk8xJW7LKWeibOJMnUCkFMQfY0eHoEOZfXPd1/M7XqIaQ0YiEfWk4JUXNjvO4uL+HAtS+caN8OZDGgtXHAlVaOdxil4kE/4VYUvER/FAz02bl96kq87MmJVU28s9Bd5m13yRs7fa0d92rLJxSWp6dZkj1fgNj7TwcnC+Fcp61vqnSOx97STlUmyNyMbysPZlwWjLRIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB12021.eurprd04.prod.outlook.com (2603:10a6:150:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:45:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:45:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Nov 2025 15:44:34 -0500
Subject: [PATCH 3/6] media: staging: media: imx6-mipi-csi2: use
 devm_clk_bulk_get_all() to fetch clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-stage-csi2-cleanup-v1-3-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
In-Reply-To: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762548279; l=3997;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=R7ovjweknMT1smYhNfW+CkGH+ciRJsLBhqOQFmBU/7A=;
 b=dlhqvFkSFRyho+L3huwEMNvdPuL7wWdlrpWjRFQUuPmhxWCcctAG61wv6Sr4IrnW7UY2h7vjX
 uhHMnKLwvnlAW+IHA7Lg9wIsbvFILRdYkQ7KtlZ43n6N/4TvjKIai6p
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB12021:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a1e571-bbe2-44a4-e19c-08de1e3e84e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0pod3hsSGdnQjJqOGdTbHNhMGk0ZUFmclpXUC9GSHpZWkZqQmtDRzNpa1JC?=
 =?utf-8?B?NGI1RzdrL2NoR0ZuU3R0UHFRSE9IZU9xaHBidkhOTWVQbjg5aEV4SUZaSmh3?=
 =?utf-8?B?dlUxR0dRcWVKcGo4b0hSbnpTSjBCWitRWWJ3cTgrWWIxRnVoeDNwcGQxbGp4?=
 =?utf-8?B?RWRhNHdyQ0VqOE9ON25vU2NZT0g4Uk1HNXRSNzc0VmpOV24vbWZGSU0vTlpv?=
 =?utf-8?B?Z2VBTm5rTEZRSHBjNjh3WVI4YjJacjZ5WUprZE9GZnhvamFBZys2VHlYNTBZ?=
 =?utf-8?B?N1RGYnFuZGJ3aEozcW5zcHlVeVErcXIwbUNCSmhWY3kvTytxaVEwWk05d1hT?=
 =?utf-8?B?ZVNQU2JNb2VvVGNMQy96T2NyZ25XODNnVVZQbXhTQjNXK2p4K21OWmlQTXZ5?=
 =?utf-8?B?U2pCVWJ0Qm04Z2JkM1F0dmFKRnB3OTg1VFduV3NuaDZjTHJtbDdlT0p2VXV1?=
 =?utf-8?B?UUFvZU1LZncxTGo3Lyt6emxaandEM0JXMndYVVYvcTB5RDdoUW9kWWt3YVJs?=
 =?utf-8?B?UU5jL0ZGNzV5Y29TR2ZmVGozZXlSNVZDZkZRT2h1Q2tYcHNDbHM0UEpFMXpk?=
 =?utf-8?B?TmlLc2NrVWxuYktEYWVHTlQzajc0N29mS0lYSjJiSkdJTFhJT1RrQURxemdr?=
 =?utf-8?B?R0xXYWFIc29peTBIWGJZWHJ6UFlWaytjajJtcHdKeTNmc0JXRlRMc3V2Risy?=
 =?utf-8?B?U1AybGMzb3ZnaC9EVTV5ejZqaXdaaThiOEN4L2xLdldUVlM0d3Bodm00V01Z?=
 =?utf-8?B?dDdlNi9XMlUvd25weTQ2R01zeWxjaExmK0FmUEg0dGVQMzYrV0FsWnRtLzVQ?=
 =?utf-8?B?SHd1MFMvV3dwLzQ4UDlTSmN1VnhWOENKeCtoL3Z0RlhpeTd4TFVqNmQ5VHlw?=
 =?utf-8?B?RkloOWlmdlYxTis5eFdWN2taWUR0WWJUUktTYkdya2JtUytrYnBBNTduaGpo?=
 =?utf-8?B?NkpaL0xOSWV6K3F1NlR5c2NWRkQ3aFRRTnZBZUFMZ20yMDZNTTdzaU9pd1I2?=
 =?utf-8?B?cTBBR3I3bTBVM1BTTUtvVkZreHZvM25LWldpMEh6b2I1aUwydGh5aEJiVkJm?=
 =?utf-8?B?anJxb1FlTkd2SGlnU2c4bW01OHJjM3hHdTZZaklrVjlhdGFaaTNabEUrdjBE?=
 =?utf-8?B?Zlc3bUZpeEExcHVHYjkvOCs5T1BtakRMOHNwLzQzblQ0VElkUG1GYlgxc2Nr?=
 =?utf-8?B?RDJqaHRVZHQ1OWEwTjNyU0F2QU52K0NTbWpwMXJ4N3dEcit6SUI5NTBkTXNU?=
 =?utf-8?B?U2MwQnh1YUkweDVhZjhQWGVkWG5qZnhacWQ3dGZ2YjRjSDBwWWdCMjFKV0o0?=
 =?utf-8?B?dytTUTR2RnNMdWIwS0MyOXU2RHFxcEtmS1dnSG5xbGp5ZTRXak5wRkUvaG9w?=
 =?utf-8?B?Uy9nb3ZmcjJlVVFYelRMUDBGbkpJMkJZY0hab2NGelltbHk4UWhXTzFNYmpT?=
 =?utf-8?B?SXcyNE50c1RpVGhOZWJwSUZHVHUzLzRrcUpxdzZ0VXd0OFJQZzU3MEhDaGtJ?=
 =?utf-8?B?VytaaWJMRStYWnE5VDVFQ2RKcHZkcFViWEJuWGl1TWxHRWh2OU1pbFJkTGtm?=
 =?utf-8?B?T2VmS05qdEt3T2YyK0p2VHNGWEhTdk4zbGM0ejdia21FS0h0YVE2TGgwaTM5?=
 =?utf-8?B?UDBGRVhkUHpZY2Rmd1poV3o4TGlWQ09IdDFsL2dsL2JCY0ZtNzhpc1dWOVBR?=
 =?utf-8?B?ZncxeStyUXRhZVUwSlNFT2JDa2I3QU82NWlxeXdYMFdYVkIvTTB6amhpd3Q3?=
 =?utf-8?B?bkRsTC85Wm1mYXM5aXVEWlBVODJWUXNMQWZWYnY5MHdId25sczNVTkNCR1Rs?=
 =?utf-8?B?VUVDd3VoUjl3b2dLdEgyQXZTTU5kSVpLSHhzKzNELzVNa3U1OXRlL3R6Tk96?=
 =?utf-8?B?TXpsRjh5VFhWdHZ0SGFrR2xpNzJhems2OGlKb3UvWi8rNGdqNmpweU1KdS9E?=
 =?utf-8?B?NUVKeURXTVVuOXlnZ29PQkZKcFN5ai9wN0FTYUpkSFkrRFluUjRCL2JiUVdF?=
 =?utf-8?B?bVpYc2JCd2ptY2RRN3UyQU1rRXJ5ZGE5SUdBMXk5Sms2cnd6NkcwSWd6ZWlR?=
 =?utf-8?Q?UpXErC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1lnR0NFRjdFWXgvQ295aVFQaXkrKytYNlJwZ2FDMnFyNG5oci9ncmdNdXRF?=
 =?utf-8?B?MzRSZVcwWlhOd1pJQi8reFZIeTUwL01iaDQzWHAwbmpGbXBMajNKY09XTlNq?=
 =?utf-8?B?b1k0dnorS20reE42dTBBeHZnMUEwSlVzZUg3dVRMVWpzc1ovSE1MSWYvYXRN?=
 =?utf-8?B?RVdKSGFaSExMdC8zNVFlMFB3ZEhEMlJTZnRSS0FsMTI5YlJiVVlzMnhndU02?=
 =?utf-8?B?VnVzTzRRMWExbElHNGNFbG4zeDFHb0F4K3ZadVdycm05K2N1ajh4cHVxcm85?=
 =?utf-8?B?dmRVMTRBYk80ai9ncVdwRUpqeXEyaTViTjNJcW9YamhEaFVXQzlOcXJGc0s0?=
 =?utf-8?B?amJMaS9uTVdscjBYQTFpUzRnN2h2Y1FJWU1WTGxvQzZIY2Q0Mm1zbnVnZXBT?=
 =?utf-8?B?QmpnNkNtaVFPS3dkNmFVMy9kRVpKUlo0RUcxbTRTOUtqTEoxSFMzU2ExeDBH?=
 =?utf-8?B?NmVpcXFseDhaVFFzS29nMTVnWjQ5Wk1JLzNzUkNseVdYdWNWN1NjU3lTdW1M?=
 =?utf-8?B?bU5UYmNJSlJrRk4xRVdjMnkwWHlnU2U1Sjhmdy92YU9BUGpNckpKdnFsbW9l?=
 =?utf-8?B?VFZScFJTc29zN0VOdGV3RVJUUURENnlQVExjR01qWk54TlNFQmlKWnRhV1pu?=
 =?utf-8?B?WS9zc1R6b2VIcGQrQWtsclBTSTRRb1V4dGx4UU1UM1Z2V2ZFY2RRMzk3blZN?=
 =?utf-8?B?aGZhL1FBd1htYUpyV0NORzhJS2QvOHRPaXFSV3NwNlRtYmJ2YWl0NXdPSmJH?=
 =?utf-8?B?MlJab1doT2U0NmZZc2RzV2RSa3NjUitUUklyTS83Rng0b3paVEdoYU5YRUFs?=
 =?utf-8?B?Z3RtSjMwNEZGSTl2d0RodW5VL2Zld2xWSHhtYk1EWWl2b0lyUy9QMnZIbVBt?=
 =?utf-8?B?TUQyZDhzNmRmODFPZTNhT1VOSXdDN2hQNTNNZVJ1dldWOU1TdlJ2OVV4V0Va?=
 =?utf-8?B?SFJFYkhaVnErc0NjdWlEaUhGakYrZ2ZrWW5ydkMrNHpCczNRVlk3VWlQTFlx?=
 =?utf-8?B?eHZ4aUU1ZisxaDJ2OVk0R2JHc05laVNuSHJycXlEN0NPaTJxaG5MNVFjQUtx?=
 =?utf-8?B?M1pPQytlR050TytmVFc1VlJuVFQ4emJvaUdzRlRKUDEvZkdHYUxGYjNPNVlx?=
 =?utf-8?B?eDV4MDRqanJCRVNIWlVCTmZOKzBRbHNtNHNmM25xQ05laGZFTWdqSDRFdlNS?=
 =?utf-8?B?bEk1d1l6bVNTZ3piV1JQMUkwbTlLWjRENnVXKzZKYnFDYXh3V3ZnNFh4bCtZ?=
 =?utf-8?B?RitNbzc0SDBKU3QwNTJxZCtZc1lybklEOXlGUUNjcG9tMWYvc3pjMnZiMlEx?=
 =?utf-8?B?VktSSlJZWDBYWGF4MkJYZjgxWnJOeVhkcktmTHhaeEh5MEs0djhjNTFxNlAr?=
 =?utf-8?B?Yk1HT0pYVDFQNm1hb2RUY0h3blA5UU9mMWg3UEdwa1NGWE5ZSGNDZ0hPeFlH?=
 =?utf-8?B?SUxycnZKVGRjV2NRN1hJK0prNjg4TnZ5dHBYR1NYS2JJWVdyZ2gvaUhRL3JK?=
 =?utf-8?B?N0FUZjhqSFllVUF1YUhvV3pab1VmOE5FelRCWWw2d1EwaFpJSExIUTlITEkw?=
 =?utf-8?B?Mi96SThLNHJyQVpmZ0lBUUV4NkNJMkhFWFVXOEVNUzRhaUZ2cWJCR0xJNTVK?=
 =?utf-8?B?bFhmbjBGZW5xMTdvenROL1M5Q0xUWlgrTUMvbjhJTGdwaTVlL3g1ZVVza3JC?=
 =?utf-8?B?QlhZYjFGaG1ndkxkZWxRTUl2S1BWV3F2UVIrUjBVaVBqT2NPbzJQSmlpZ1hI?=
 =?utf-8?B?NHlTTDUvQUdSME5lMkt3a1dhOVdFcUxTaDY0c3NwOGd2U0pRc2haa05hNEpD?=
 =?utf-8?B?d3JLYkNBbG9iNE00R0Z1cUQrMjJIWkdxeGlRVzJUTHFvcDRycDE3dExycUNV?=
 =?utf-8?B?dTV6eDFreTZxWlFWQ3JvVkZBZlV6RlZHMU0xdlZPUXp0K1R5L001UzVkMzNP?=
 =?utf-8?B?aUNPZE9kRys4VDhweEhGS2UrRzJyckwrYUNMdjZYRWNFdmQ5YWR6TXhFUjRr?=
 =?utf-8?B?MHoxTk9nS2hrWFY0V2ZTdXkrcy9UUUhidVh2L0pQYmpzcmhLNWVkZmx0cDBP?=
 =?utf-8?B?OXBjc0w5ZysvZmFDUmQxd200ek5KTTVMWDlpZEpvQXE0OVhRNWQyeVVHMUVz?=
 =?utf-8?Q?v6IU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a1e571-bbe2-44a4-e19c-08de1e3e84e2
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:45:00.5667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYoF0gLUu26BEk6bYELGA/HnxshWgeRZAJXNtHELWyGY72OO8IeNwUQvCeEQOJshdOBYpMNOGMTqQjrRZ5nksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12021

Use devm_clk_bulk_get_all_enabled() helper to simplify clock handling.

Defer all clock prepare and enable to csi2_start(), which previous only
enable pix clock here.

Do that safely because there are not register access before csi2_start().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 52 ++++++------------------------
 1 file changed, 9 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index eba9a650030f5e380aa900b94728ad375171c6a5..32ddcef7ec8535a44e121754bb621c0d2e226369 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -39,11 +39,11 @@ struct csi2_dev {
 	struct v4l2_subdev		sd;
 	struct v4l2_async_notifier	notifier;
 	struct media_pad		pad[CSI2_NUM_PADS];
-	struct clk			*dphy_clk;
-	struct clk			*pllref_clk;
-	struct clk			*pix_clk; /* what is this? */
 	void __iomem			*base;
 
+	struct clk_bulk_data		*clks;
+	int				num_clks;
+
 	struct v4l2_subdev		*remote;
 	unsigned int			remote_pad;
 	unsigned short			data_lanes;
@@ -343,7 +343,7 @@ static int csi2_start(struct csi2_dev *csi2)
 	unsigned int lanes;
 	int ret;
 
-	ret = clk_prepare_enable(csi2->pix_clk);
+	ret = clk_bulk_prepare_enable(csi2->num_clks, csi2->clks);
 	if (ret)
 		return ret;
 
@@ -390,7 +390,7 @@ static int csi2_start(struct csi2_dev *csi2)
 err_assert_reset:
 	csi2_enable(csi2, false);
 err_disable_clk:
-	clk_disable_unprepare(csi2->pix_clk);
+	clk_bulk_disable_unprepare(csi2->num_clks, csi2->clks);
 	return ret;
 }
 
@@ -401,7 +401,7 @@ static void csi2_stop(struct csi2_dev *csi2)
 	v4l2_subdev_call(csi2->src_sd, video, post_streamoff);
 
 	csi2_enable(csi2, false);
-	clk_disable_unprepare(csi2->pix_clk);
+	clk_bulk_disable_unprepare(csi2->num_clks, csi2->clks);
 }
 
 /*
@@ -761,24 +761,6 @@ static int csi2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	csi2->pllref_clk = devm_clk_get(&pdev->dev, "ref");
-	if (IS_ERR(csi2->pllref_clk)) {
-		v4l2_err(&csi2->sd, "failed to get pll reference clock\n");
-		return PTR_ERR(csi2->pllref_clk);
-	}
-
-	csi2->dphy_clk = devm_clk_get(&pdev->dev, "dphy");
-	if (IS_ERR(csi2->dphy_clk)) {
-		v4l2_err(&csi2->sd, "failed to get dphy clock\n");
-		return PTR_ERR(csi2->dphy_clk);
-	}
-
-	csi2->pix_clk = devm_clk_get(&pdev->dev, "pix");
-	if (IS_ERR(csi2->pix_clk)) {
-		v4l2_err(&csi2->sd, "failed to get pixel clock\n");
-		return PTR_ERR(csi2->pix_clk);
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		v4l2_err(&csi2->sd, "failed to get platform resources\n");
@@ -791,19 +773,9 @@ static int csi2_probe(struct platform_device *pdev)
 
 	mutex_init(&csi2->lock);
 
-	ret = clk_prepare_enable(csi2->pllref_clk);
-	if (ret) {
-		v4l2_err(&csi2->sd, "failed to enable pllref_clk\n");
-		goto rmmutex;
-	}
-
-	ret = clk_prepare_enable(csi2->dphy_clk);
-	if (ret) {
-		v4l2_err(&csi2->sd, "failed to enable dphy_clk\n");
-		goto pllref_off;
-	}
-
-	platform_set_drvdata(pdev, &csi2->sd);
+	csi2->num_clks = devm_clk_bulk_get_all(&pdev->dev, &csi2->clks);
+	if (csi2->num_clks < 0)
+		return dev_err_probe(&pdev->dev, csi2->num_clks, "Failed to get clocks\n");
 
 	ret = csi2_async_register(csi2);
 	if (ret)
@@ -812,10 +784,6 @@ static int csi2_probe(struct platform_device *pdev)
 	return 0;
 
 clean_notifier:
-	clk_disable_unprepare(csi2->dphy_clk);
-pllref_off:
-	clk_disable_unprepare(csi2->pllref_clk);
-rmmutex:
 	mutex_destroy(&csi2->lock);
 	return ret;
 }
@@ -826,8 +794,6 @@ static void csi2_remove(struct platform_device *pdev)
 	struct csi2_dev *csi2 = sd_to_dev(sd);
 
 	v4l2_async_unregister_subdev(sd);
-	clk_disable_unprepare(csi2->dphy_clk);
-	clk_disable_unprepare(csi2->pllref_clk);
 	mutex_destroy(&csi2->lock);
 	media_entity_cleanup(&sd->entity);
 }

-- 
2.34.1


