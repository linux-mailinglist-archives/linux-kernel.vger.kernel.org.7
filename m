Return-Path: <linux-kernel+bounces-787677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140EB37980
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C957687082
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918A30F93A;
	Wed, 27 Aug 2025 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SPCNXpuz"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150730BBBD;
	Wed, 27 Aug 2025 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270795; cv=fail; b=ME50BhtLxhSB3tBkxGzuHykB9y/TBBjWuAArsOV0/PjRAfV09d6DL+pSuChGmC9PoPBq9nJNUtWW0en0o3HxQxm1X6QqDbXZ0/0iK9CcIssor4PmHgJUABtmpfWlsZA+oomvCfNKby+FckwpOf0OC/qYun0EofDO1k1d8tGwWXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270795; c=relaxed/simple;
	bh=ZF//cCX8zn7RB+aCo7I7S2KdetcFP2xXtxrSni4wK/8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NNKGD1UIEwmDcQpr6apey/MgXdQTNeBcbIRDMfs6Sj9qUtIVplAtU+RlcWjVwe7bsDbJFsJMt0n82i1wyVioGc3tSU0wADOCnWGUjU3omWVG+W5+XnC8LSSg9LjnFbHKmFXOxW8QowYBJoqDFEQC+6nbiDbbyrfrwtTjF6da5JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SPCNXpuz; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpAQMB65a8jZD1ct6oL7VUTqWiTcs3z1j4eQZCrUW0Tv9WZhd6Egbc4/zjN4xwXzub0jDQUlIE/VMZ1rncXPjvgIDcRQEme6KG9WtZk5LPkLTuhFk8dq/zi3tEAZ0SulALX61uHX86bgvxsWInlgQDxwRl4Mg2KWTrpExnBXGgtaaM9g3vkauIuJnC4uV2Yr5RhVh4OZdgQ4fNqgsa92qcp3kfFCokOR4iXAiKWC0p1o/KRDZ2iDv5100lh2F3wSbKktMrQPy8mRM17orcnDctqX3hBRagWHQBnd2lahb2LYburn2d9GcJ9I2x7KZNJSYX60awOjdC9sfSjOtfUE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=our7iGGYBYibRpjLl+qWIzKF8PAnWNCf7ydgoHgSeIg=;
 b=GyxRx32A5NKhU/K7kGf2I7BhiQMPZzCBL0ELCEI1EHCYKPtvc+urdEqZx+/lflDsI5qiLmGapGkmiw8oOuLWfkx3M23AF2L/QWbaWMkQpHZI8pggBjr6tu7UHzAR82xt74JaYV6PSn43MBaSbDm9wmfJl3Utk29eJY3a+EysS/KiUc7FV/slrZM5xhRsw/LSQdruycWnJ2c66/BooP1q923G9++R3STUzAkGIqsfi5zwoVqqo9apYMVCC8fj7ozyFU1XTYqucdTeXQd+DgD6pYS7YTXd1U0xYWuSHc71OpChdMXXuNCJYHyPwVNDnzNidO5a7jSzo6gZE6jLYckHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=our7iGGYBYibRpjLl+qWIzKF8PAnWNCf7ydgoHgSeIg=;
 b=SPCNXpuzwnv+OpnzshkQ9xCTnzQ2HtyHAl3GWlzuCzoCjXb/oWVvfUkhmbNn9vQy8jFz/dno/8503hebrtbgFMf+oMsZsaThXtTnxkOvFSZF4uohigBQ3/RzQIbkAd6BITp9UMKNV+JZ1GPuQOeOD7+HHJnzL3qwnQrAIHUkc4g1gI5AQeFzL5Y5OvTWBJvGlh7KYw0AGrrbxtvIDsZWBeyRdFE0eRrHG3sKv88gVipCyfm/od1CD0BKAx+dCVsPUOoXmnAsbyfliEN5z54QWhLdfyWWaDcLs3izJx+ciaNGOMKFeISvpNHoenohZy0OhoPi+BH6ILSbNXBEkgIQ2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Wed, 27 Aug
 2025 04:59:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 04:59:50 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 27 Aug 2025 12:59:17 +0800
Subject: [PATCH v3 5/6] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-sm-misc-api-v1-v3-5-82c982c1815a@nxp.com>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
In-Reply-To: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756270768; l=5007;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZF//cCX8zn7RB+aCo7I7S2KdetcFP2xXtxrSni4wK/8=;
 b=7qjDwYTjbwVjrutOQcKhXlWiJRZIGDebVvSyEZa/jHA9kSLFgD+giJJuhs2bD/al/61mekcih
 OD84AvpMbkvCPv/xBH6kVLXJx9wc5UFc/2QGWIpKormP7iaVFf8xuMK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e58f62-53b7-43db-de0f-08dde5268d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0JVS1RVQkdPakp6eDBROUZ6OWJCQzk2RXNBREZ4OVdOQ0tKaDhJczk0dTFM?=
 =?utf-8?B?dyttM0RlOHl0RWM1QzJtUU9GVnczL1lVWTU0SHJVN1poRWQySnZ6L1M0dTJa?=
 =?utf-8?B?bE5wQXkxU3lWbmdacVpqMDh3K3l4OHJBUHhsa1pPK3J1S3dUcS9sbXVqUkx5?=
 =?utf-8?B?WEpMWE0vNCtxQm1kSkExcWVGZXhjMmpzVVY4NlZxQlFDMzAzUEp5Ynl2NmJG?=
 =?utf-8?B?WS9IbDl6MkY3ME5RSVlkcUxRNWdrb1VuL2ZmTlFqN2k2T1FXeW9jeXVheXln?=
 =?utf-8?B?bTFkUmJheVgyeGovWWRpL2t5NlNCdjliRnFaQ2JtNzdpSW1obmY5b3ZrZW1S?=
 =?utf-8?B?UGt5UXFnSExqWndRQUY5SWdZMmc3NkV6KzFCMm1ROHpZOEJlN2hmamxEOW4r?=
 =?utf-8?B?WWsxSWprZ2lLdW1mREZ0V2Vqd0JFTFhTbUphNzhJVWpGek1lZFl2b1Fvc1Ez?=
 =?utf-8?B?aEF1NDV6NzBYZU8xdVBZRVBxVnFUZjgzYU1pKzJaemFZY0ViTUVPN0NPV0lR?=
 =?utf-8?B?cmRjdDlEakpOZjVJWStxS3JaQmNaME9mcGV6Tkp2NExLY0ZaTWR6UTZMcXht?=
 =?utf-8?B?ZXpmVnRJY0l1UUFlL0Y1dHJKNXg5UTU5SVdXamc2VVRDV05EMFJ4bU0xWUxj?=
 =?utf-8?B?d3luRmNBcFJqVGtGL2pzQWY2aTdEMDFyZ1YzSE9ZWG5mb2l1Y2RWMjBzUFFX?=
 =?utf-8?B?cHlkL1BIb3JzQWxKVlBsKzhuSDFRalN4T2JLTHFQRnVSRjV0Mjd1aUVRMUdn?=
 =?utf-8?B?SkgrSTBxbVB3M3o1OS9tbnkzWFVDRUNBRy9MQTdZUkV1SHlRNlRpMHA3bm84?=
 =?utf-8?B?OEtkd2tlQTkweForUm9Od0szeWsrUEVLL0Z4RitJc1U3N0dDSUZWSHZ0ZVM1?=
 =?utf-8?B?dC9hanZPUjc3Yy9zem56S3VtTXhoc3o4bGpHbVkwb0U2NGJKZndFRmVqK3ov?=
 =?utf-8?B?STZxM0hYMVZmZjRhRFd0aXZpY2ZFMEFJYnFEbVduOTFFSjZIN1g4alhrTzRz?=
 =?utf-8?B?NkNLR1ZuU3FFVEIyR2ZHR0tmNXVRMG1VdkM4bFpQdkxPWDJvbVdHT2Iycldu?=
 =?utf-8?B?Zm1UT1FkNk1mY2VMZmxTOGdXbGVKbHY5QkFZR3diWkhoYXdib1hyWG9QZVhs?=
 =?utf-8?B?UmNZazdiSGIzYVhOWm1kdzlFeHo3OU16dnNCS3RLZXVDdjVpNHNHUUVFUWR1?=
 =?utf-8?B?VitRaStmU2ZVcGVhMlJ6NU9sM0pVVWVITGNrNk5oT0J0RU41b2VnVXhrN1Q2?=
 =?utf-8?B?VFZ2bXJZaklKWWczZ1U4ZjRidm9lNG42UGtGbTB6ampCQ2FGNTNxOTg4c21z?=
 =?utf-8?B?ZmVFbWxvek4yWm9obmlQRlJHY2JUY29FZlJuMU52QitkclZDOVV5cnR2V1dw?=
 =?utf-8?B?RThqSFI5MFdWSm1DYWc5eE5JOC92bmtHOTV2MXp0OEZjajA2OFhSTUVvUnpR?=
 =?utf-8?B?alp6UkU3ZFA0ZFFqby9UeUx4WkFBVVRkeHMvU1BVQXVtcStBZ3N2d1cwSERu?=
 =?utf-8?B?SkJadUE5WG8xaXM2TnNKMy81bEYxUzZnMmxlbERxL3RTUFNlVFpzMGlLNzhV?=
 =?utf-8?B?MEpzVjhCaktIb3FsdVhNeXAyRjBSdzdBZStZSWlNNEE4SVMzY2JxVjVaWmlR?=
 =?utf-8?B?a0oxOEpJZUxRWGZGMkRmWFJCcERya0tUT0w5bWdBb2hiZTZkbTRIdjFFSExR?=
 =?utf-8?B?N3AvdW9LWFN1M1gvNlpXeWt1dkYzSnFjNGlzMVlveWRIZ09DNFlRcmtsMUh3?=
 =?utf-8?B?TW5IZGQvTVAvV2hkSGpHenhSbHBBOGRKQyswYUxrWmVCTHFrTUk1NzhmRnhB?=
 =?utf-8?B?c0daWHhqelorZUR4V3gzcjVUb0dXS2E0clQzVmc2R2hCWU1CRDR0RmZQNFhV?=
 =?utf-8?B?eDNEV2VWUUh0SlJlV2RtLzN3WGNpTEhrSTlBM0F6MDlrZFhGamtmcndWRkpZ?=
 =?utf-8?B?U1ZGd1V3NzAwMXlUcVpqcTZqeFV3ZHdmWDltY05Ed1BubkFvdVBhU0QyOE4x?=
 =?utf-8?B?OTNkalFzTHFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVJjK0NmRXBYdExxQWt6SmdZQ2FSZldYR0ZnckYvZFAvTGpRT3JNNWdQdUV3?=
 =?utf-8?B?a2tDVFU0NklMTXU1VXJkV0RJSTg5c0hJVndXUnpLbGt6TTZoNm10TFNYaS9p?=
 =?utf-8?B?WVdad3FTM2ZpeGFQNFJlaS9hbUU2K3NyNkNrZUFVaWdtU0YxblpjYS83YVR4?=
 =?utf-8?B?bEFHb2VORGlWUGVUaUR3RHhYaEZIMElLWW5NbS9oUzNLdHRKcUNqUXhsUFVQ?=
 =?utf-8?B?bndNanJ1WlJLcG1tVHhiNGZDSGtGQkY4NG8ySVF2Z1FYQ3FxcDVMT1lRQWlV?=
 =?utf-8?B?aXRObWVKcXBZMisyeDRZTzZ6Yk9UWmtqMWU4c25IenZwZmVueDlTUHhNZTBq?=
 =?utf-8?B?dUlHZnhJSzZnam1sQnBNb0hPZEpDRWsxWGNTeDloQTdTb01ETUtMYWVnZ2w2?=
 =?utf-8?B?V0VuRWpLVTNZcHFHMlpCSGJKZFAwQi9XNFZ1ZkZtb3djckwrWDc0MmNCcmVS?=
 =?utf-8?B?Nk16NmE0Qk1ndnZ2MmJNdVFBVDlsTGFIU2Z1RExqa2oyMGJxa1RKTUQwcDd2?=
 =?utf-8?B?OUJiVWt3MlY0NWM4RkJmTEpKcVROZmpBMEpWeDI5S25wVVBBTGFmTFM3R3Na?=
 =?utf-8?B?Zm5CVG9kTDFPeFBEN3UrVkd4d3BsM0RTYkFXYncwcUoyRGdER3loVFlrcVdv?=
 =?utf-8?B?QTcrbGRPci83TTY0VTdYVmt5ZXcrcU5LbEVTNG1iK1lnUkNXZ2N3Q0NFRXlQ?=
 =?utf-8?B?Z2UwbWhZamhTYnZURU54Y3RVdnNVL1V0Zm1GemZnWkJUSjZUVllQalcxRUpq?=
 =?utf-8?B?V25mb2doVkFsVDU5WFdoZzJnUDZFc3pwTzZHK0tVYTdjL2JyYnJYcWVIRzVH?=
 =?utf-8?B?YW93WlZ6T3lxT3R1OWo0WWU2YzNzMjVDNFFIQXJranlxWWJaOElNZ3EwdzN4?=
 =?utf-8?B?TVhSWk50bDdRWVJxTVJnbHRVRmRiZnY1Ym55bTRncVRrS3AzVzN3UVNpK01K?=
 =?utf-8?B?TElhTnFGVXpGZkJRMy9YSjdSVStnUy95MEswZWVwdmVFQWRPSWxrY1JVbXN6?=
 =?utf-8?B?Q0QveTZMMUIzbzlBSkQwSkxLVk0xQ2MyVDkrTzY0Y1dVSk16UHVhR2xuNVRt?=
 =?utf-8?B?RzhPN2VoeVIzQmh6cWtYVFRIZTc3dElzVDU4U2NJNkxBWHZSNE9NeS92Z256?=
 =?utf-8?B?bFE5dDNxWHlSM0JscFIrTXhuODZuVTkxMFFiYkdHYkw0R3ZaYXhrdVdqVzQ4?=
 =?utf-8?B?WGJOWkZuSG5KRE1oRFBvcTIvS2V3NndJdWRYNkh3MXpEQno1cFpkZHdVYVZR?=
 =?utf-8?B?UGVNdHlRV3U4cTgxRDBjVmFvTWxVbVFWU2VncDYvRVpPVWYwWTVYbmhTZGFu?=
 =?utf-8?B?MzlqTFM5UjdVaXJubWF6czh5enR1WHFzSWV1MVFHdk9sOGwwUE1EU0FxYmJt?=
 =?utf-8?B?NFA0blo4TDQrOGpqSG5neHNRcy8xS1dRL0ZGeXdWYURaMmR4em9QeHNuUzJa?=
 =?utf-8?B?OHJycnRTYWkwRFBWNHVqSFVOdUNCUU41T1N6ZnI0R2p1VGFKdzhYZU1Lc0hT?=
 =?utf-8?B?U3VvZ29IcDJZNUFzSTlhUTAxaGdJWUNOQ3QxOG5SM0JoZTdzVFkxWHpSUXVK?=
 =?utf-8?B?OTZYWjc1UG80MnFRSk9GdExIVlQ1aEVKMG5JZzAzTklNUTg2QjZTQi8xTW5K?=
 =?utf-8?B?WGpzRjEyOHAxZnNsUXh0YnQwZlVUdG9KOTlRWGNBOWtlWkdQNDRteTlUVVhz?=
 =?utf-8?B?eW9oVC9FNzhTWTZsN1lubHgvcEl1UFdEVzl2dHNpZHBHczZENTk4WXNWempQ?=
 =?utf-8?B?QUxYQmlWNFFGbHN2SmdyeWhpMlpCNUlhditrRngwblZPWWU1TlBOVEJ1cVl0?=
 =?utf-8?B?QUdwSTA3azFucnRHOEdlTlgvcmdjYzR5NnVSQ1ZDQ2R1QTl4RUk1bXlONGM3?=
 =?utf-8?B?RzI3cElvQXVBcXlqU1RZaWRESERBOW02R1VreTNUOHZHY29vTENWeFUvV1hJ?=
 =?utf-8?B?RjVZbDBPOFN6NTdQeVpSVHNaZGhpRWdsdVEyclVPZFZjeXowbGt6eWtJck9R?=
 =?utf-8?B?eGM0ZjlUcCtKSUxDLzdFaUs3TCsyR1BicmZSdFk3Ly85MDN1RTgxSmNBUjJE?=
 =?utf-8?B?NXVlcUUzS3FWbllFWGRSdjlGakMxTXg5MWEvR1RHMkRTcmNxQ3Uzem8vcXU3?=
 =?utf-8?Q?L96WN3tewWQxPBGK2tbzwsjIm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e58f62-53b7-43db-de0f-08dde5268d65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:59:50.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN7mLx9Bnb4UlLP77lEpYTEnXirZX+rL/R8XszL8v85tKxuTYgYXpQbpPzR/0ebZ0SBiyv9mR2kBfD9Y3oxb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355

MISC protocol supports getting system log regarding system sleep latency
,wakeup interrupt and etc. Add the API for user to retrieve the
information from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 82 ++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  | 19 +++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index f934b4fbc6ec9f1e6b24d1c6c8cd07b45ce548e3..2d3423d83aed857329a9a367d0ec0681a1d77d0b 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CFG_INFO = 0xC,
+	SCMI_IMX_MISC_SYSLOG = 0xD,
 	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 };
@@ -89,6 +90,19 @@ struct scmi_imx_misc_cfg_info_out {
 	u8 cfgname[MISC_MAX_CFGNAME];
 };
 
+struct scmi_imx_misc_syslog_in {
+	__le32 flags;
+	__le32 index;
+};
+
+#define REMAINING(x)	le32_get_bits((x), GENMASK(31, 20))
+#define RETURNED(x)	le32_get_bits((x), GENMASK(11, 0))
+
+struct scmi_imx_misc_syslog_out {
+	__le32 numlogflags;
+	__le32 syslog[];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -371,10 +385,78 @@ static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
 	return ret;
 }
 
+struct scmi_imx_misc_syslog_ipriv {
+	u32 *array;
+	u16 *size;
+};
+
+static void iter_misc_syslog_prepare_message(void *message, u32 desc_index,
+					     const void *priv)
+{
+	struct scmi_imx_misc_syslog_in *msg = message;
+
+	msg->flags = cpu_to_le32(0);
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_misc_syslog_update_state(struct scmi_iterator_state *st,
+					 const void *response, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	st->num_returned = RETURNED(r->numlogflags);
+	st->num_remaining = REMAINING(r->numlogflags);
+	*(p->size) = st->num_returned + st->num_remaining;
+
+	return 0;
+}
+
+static int
+iter_misc_syslog_process_response(const struct scmi_protocol_handle *ph,
+				  const void *response,
+				  struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->syslog[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_imx_misc_syslog(const struct scmi_protocol_handle *ph, u16 *size,
+				void *array)
+{
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_misc_syslog_prepare_message,
+		.update_state = iter_misc_syslog_update_state,
+		.process_response = iter_misc_syslog_process_response,
+	};
+	struct scmi_imx_misc_syslog_ipriv ipriv = {
+		.array = array,
+		.size = size,
+	};
+	void *iter;
+
+	if (!array || !size || !*size)
+		return -EINVAL;
+
+	iter = ph->hops->iter_response_init(ph, &ops, *size, SCMI_IMX_MISC_SYSLOG,
+					    sizeof(struct scmi_imx_misc_syslog_in),
+					    &ipriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
 	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
+	.misc_syslog = scmi_imx_misc_syslog,
 };
 
 static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..6e18920aac56de67d388e985e3305745d3798c3e 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -52,6 +52,23 @@ struct scmi_imx_misc_ctrl_notify_report {
 	unsigned int		flags;
 };
 
+struct scmi_imx_misc_sys_sleep_rec {
+	u32 sleepentryusec;
+	u32 sleepexitusec;
+	u32 sleepcnt;
+	u32 wakesource;
+	u32 mixpwrstat;
+	u32 mempwrstat;
+	u32 pllpwrstat;
+	u32 syssleepmode;
+	u32 syssleepflags;
+};
+
+struct scmi_imx_misc_syslog {
+	struct scmi_imx_misc_sys_sleep_rec syssleeprecord;
+	uint32_t deverrlog;
+};
+
 struct scmi_imx_misc_proto_ops {
 	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id,
 			     u32 num, u32 *val);
@@ -59,6 +76,8 @@ struct scmi_imx_misc_proto_ops {
 			     u32 *num, u32 *val);
 	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
 				    u32 ctrl_id, u32 evt_id, u32 flags);
+	int (*misc_syslog)(const struct scmi_protocol_handle *ph, u16 *size,
+			   void *array);
 };
 
 /* See LMM_ATTRIBUTES in imx95.rst */

-- 
2.37.1


