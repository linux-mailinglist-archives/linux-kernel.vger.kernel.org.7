Return-Path: <linux-kernel+bounces-855606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A16BE1C08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F14A94F6001
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D22DFA2A;
	Thu, 16 Oct 2025 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VL+bsXb1"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE52DF128;
	Thu, 16 Oct 2025 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596408; cv=fail; b=MbMw/1zeI8Wg6h2uwPzZj7GrCaQUM4oBK7C4RTP53YnjxP/npw5xfKImtO/FZrMUYbM2QWa91Me7dyvNgQAwFto8X5wtRUEtRfnhKLvyj6ZqPB1/PnU+NbrHlI4AI+3vbr+/OeaJ8JkYyuFbHKmgqKajvTGv7OGrAjmyNH5GUC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596408; c=relaxed/simple;
	bh=DGbuQpzfZDKY7kyqnFqCoq+o4oR7TvO4UdPM1UddodA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lJYqN1jTYSQ24MNj7zn/eWlh8zEtdIIe/eKcTBkdbt75jVA/AVKF9h/8VnUwzFm6YmCik0H0kZ8Y6+o2NFanMbZ8wawKsuzQQgfxsuL6kD2bCPgjCASTaknWKpcs32MJpuSMs5rTAIKD/fyThlFk1BfFrRKZlRU6nuFo1AW9SIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VL+bsXb1; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6p02hgOTklI87EAp/gwJjHI7+xnNjfD5XrThuzWj7XQ2zv74OS/XqJZRoZtP68MYTDPt3TaMcO0p1H4jDcU6Ho6HWNhdUWunatOX/xHt2En7/LpVSqKXIpHWWcJT1BugFwvbukcnqzJ9aI702VYGAaN3r9vAgxsFwIyL11xnVOCpJ6ZDplzkj3Zf9GpvL/Eu5uHBZ0vyiEz5/tX2f54/NfAnHd4AGqPIon1Myt/BPKNG7jgDLKPqkV+HS0IjtW6mgmSZrHcgHWs50Uk2sEYwEzaZOd8MTUoqq5WYxNG05chjAJBZTkh6tSFJyZtbIM2ePxEvsy/ivff6alHc/ZB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTh5wZ55LwLRQ81qq6Rx8uK5Tqd9vh50RBjRgRVy0R8=;
 b=Bophz6aGr7+rZsZdnShpNI30iwHR3nOYY6pL+w58mTQeKkXb3KpFzUHmxsX53/YJ9AFYOr3l0ktPLXwz/4FjR3gHyhxmfNa/cQszWpWManLN1+P0Qfo+0auOOozUs/v2zovvDfHxap3ewVYApGL5RJmMBA7GnpZatXzHSM56VJ4Fq2mFIoExkcp58lyig/UKACzSW/65zQV5eX3NSyW/OqJrZt3clENC+nKrfcIoHFGWhySHX8ljBs4W06h2arqQqcRAk7M2wwupPkSMs6hoyhc0CO/2f8X4od4ITNJHGYZ28+TyVdulCVIGyzadKuC8McOZDT14Z60iDBD1dhKR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTh5wZ55LwLRQ81qq6Rx8uK5Tqd9vh50RBjRgRVy0R8=;
 b=VL+bsXb13Mk0X4Xy+VOGV9Wty5K9HvbmXpdcXCDLupjahVnfjJ2zcyZd7Vfyc5gzJVbDxbxpdeW24N9V8GsycerHWwHcyoOqZBsJTH0s2qG0nCPasrvqRKl89hqriTK1N5ZpE7bfZTQ+TTqQiIQJzCyrufancEZN6UaRiAXlnvT/7KLqGofKYNKZCYhVywwCYx+VxJtDCo/D8QaYzwktibHmRXP0Wr8t3Zb6gH0g0yyOBrfJklKEZPgVdR3xHxJ4sZGoPEpDlBURJQJUmYeyvI66bkF+JxByljZ6dF8U2ceyDqRkrJawCkgzkZRQtWsQQlLWI/QyciCf4TVa6HFjLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 06:33:23 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:33:23 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Thu, 16 Oct 2025 14:32:27 +0800
Subject: [PATCH v4 09/14] drm/imx: dc-ed: Support getting source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx8-dc-prefetch-v4-9-dfda347cb3c5@nxp.com>
References: <20251016-imx8-dc-prefetch-v4-0-dfda347cb3c5@nxp.com>
In-Reply-To: <20251016-imx8-dc-prefetch-v4-0-dfda347cb3c5@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: 252e76f3-9769-4e56-7a1a-08de0c7de7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDNsblArRWJmNTlBVlBCL1hGQVIwUEl1UmgrMEIwZkpqcTNVNEFiTnNaSU5Y?=
 =?utf-8?B?bi9JeEI5dWFLMDA0bTNCMG83V1hCSEJncmMrWnlqQ3NOOHRidnZjcWlQZEJQ?=
 =?utf-8?B?QlN0ME5XQlFaUldPc2FkTVJIeFkyN3dzQWthVnFQNW5EWmRZMFI4Yk5XNGtx?=
 =?utf-8?B?YUhaenpsTXc3Vks0WW92aEdlbjlEWWMvcnp2UGpFd09lVVRuRmRzSlFVam5l?=
 =?utf-8?B?a3g2bElVS0ZkSkk1dEtpTE1rd1NVT3RteTUxeXVzdHc3TjViK0dvR3RJKzQ4?=
 =?utf-8?B?Z2F2amJJdStxRzMzV2lHYndYd0N3MHJ6TWRUdnNRK0g4NHFtNWhPNk9wTmdl?=
 =?utf-8?B?U3k0dTVJR2JvYm05aEtlUW5XWGRkQVFzdnJNSEloeWFxU0pnR2pzbjY5ckZ3?=
 =?utf-8?B?T1lkL2c4TStLclRWY1dKbmtIdHBRWWU0L2ZKSm84ZjBLTUxHLytDY09pcTh4?=
 =?utf-8?B?RlcxMmk0eHdCaTIxVWVoM2pKTmJYbzdXMmNyVk9vZFpOYWNOVGEwTmg0ck12?=
 =?utf-8?B?UzdNNnpvckhjVzNEcGNCUEpJVUJhSFhmZ1Biays3RWxtWnNqRVJJM1F2K0p0?=
 =?utf-8?B?VkpLWFpvVjZEMXU2OWM5L3QvOFExNFB0WWYxRytwdW8vblRYZit3V0QzMmRv?=
 =?utf-8?B?Y3dyWG1GRnFtSUtocEtpVTJCd0tsWWZDY2dTbkdIWmx5bC9nUy9ZMkIxcnBn?=
 =?utf-8?B?OENUU09McXlYTFFwRjJwTVJVaDdlTmljMGtyU1BLWi9xN2oyN1ZJYXR0L3A2?=
 =?utf-8?B?eDNZb2l0L3pVNnE2cExjMEFIcklWZ25sWEpzUXAxbGJJajRtanlXSjlOOUsw?=
 =?utf-8?B?aVVZMldKUEtYTEJoNHRjNjVDQXNGazFwSDRtTyszRFp2NUJYc0ZGRmY4bHJZ?=
 =?utf-8?B?ZkUwaE16eExlcU11QWxwZnlXV0Z2Yng1aGNOTWdKdVo2VDBRYzdKejljOWNL?=
 =?utf-8?B?ZGlQc0c4ZHFUdHplRjl1WEpsdDlBTXZtSTA5QTgySjZzUFZJMFp3S3ZiZ1BW?=
 =?utf-8?B?bGdBREh2b1VRWFMxRy9WenMvWXVmeDh4NCtUWko0YkdkMUVwY0kxVWZaYUpP?=
 =?utf-8?B?eWxiOW8vZ29IdmQxY0RYTE5SM1BJaXBmNE9SWW1lbkp6UG03dGx3VFU2ejI2?=
 =?utf-8?B?Q3N2SFpKd2VKbjgwNmpRL3BsZVhweFlJa3JUU0NxNStTWFE0VTBBY2ZlRU9z?=
 =?utf-8?B?YUpsYVh2UE1sVnBGcEhsbk9ZbkVRN0FIaEUzWDVUY0lFcGo1WFhoYVN3Sy9L?=
 =?utf-8?B?SGZBVlNZRitYWjI4U1gwVzRtUlhOSDV1MHljTUJaRzlIdjI3aC9sRERwb3VL?=
 =?utf-8?B?YjBRNUorNC9STHZNcUZQMjZFVWF5aU1SdGlXcjVhRUVDczg2dDdPZXoyZkRR?=
 =?utf-8?B?WUdjajM3MkZlTStXWmZoRWpjTHBrZmRVWjU2VTdPYndwS2tITmV1bUxzRFRH?=
 =?utf-8?B?VXUvWTQ5a3dBVE5jcDg4aFR4M0RSRHN3cG9EWHhsYkVGUWlkUDJUcXp1VExw?=
 =?utf-8?B?Vm8xbkVoVzV3S0lEcGlwZW40bmtnS0lkS3dTL3N2MU5JaGtST0RuWWI5YzRD?=
 =?utf-8?B?NjdMelYyM1N6RXZqeEZLWGpJNXpuakk3YTBIa1N5Q0dnQVRZbGh4Yzljb2pi?=
 =?utf-8?B?b2lEOU8rbW1ucWxJcVhNL1c4TEhjRlF5RURYL0phbWJ1Y29wUDFZd3pSVGxJ?=
 =?utf-8?B?U04yZ2dGdVlnWVJTYjRRNm9DcUxuMmVGREhiM0RUWmZvUi9uUFlyTGJLN0xo?=
 =?utf-8?B?aVlGbW51aE9lRTBVMldYby8rNldYOUZKU2Y2ZGl5am5nNUcwVllLdTR6dGRo?=
 =?utf-8?B?QitaeFJLZ2xERVN6NDhKRVR3bXkvbW53Z1BXRzkrcFBJTGxQa2htMlN5YjBp?=
 =?utf-8?B?WVNZeWpsdmFDM3p5R1lmM2VOVXZYOVYrVGpqM1ZjdTNubitqYjJqT1FDa2Fa?=
 =?utf-8?B?S1o1bDl4M3ZXalFpN0F2ZHhTNXlQOGZVZ09XVHgrQWRTeGtqOFBvcWMzNUpY?=
 =?utf-8?B?cUt5TG5LSmZoNFozbE80SDArZ0YxaDk2OTBnc0V3VHNkSEpqWXlEUk10dDdJ?=
 =?utf-8?B?ZFVTTmxTMUhsVmdzdzYrdHVoYzJrOUlqRW1SQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDUvaDZXS3phcUR6Qy9WTFVrU0NGUzVTREtNM29xN2lrbTNkWVlha3VabUYr?=
 =?utf-8?B?ak1kamJZOUVlNGhra2JuQVIzWU9PWEpzSk5mdGZCc1l1Z3YwamhMaEU5czJt?=
 =?utf-8?B?YVFMUHFXWUFCY09mNUVYUEd3MVVMazdVVWdnQnJxcll6Y0pGcXF3R1NmSWJ1?=
 =?utf-8?B?TEl6NHVneWVNMEh5ZEliSGZtbnpKVkIyWW4raVpGYkpRSHpWcTdZQW9wdktl?=
 =?utf-8?B?RHNyUjRabEovN2lyNURvTFZWaUFUaVd3OTVLS0ZLTm1RdkMzQ0M2MlJ0SjNx?=
 =?utf-8?B?ZVh0dlNXZWpxTGoxN3VocjdpQTVOZDVWSWJRWitXcnhvSlFnQkxUa09oWDRm?=
 =?utf-8?B?dktUS05DcTNqclBVQ3hiUkhINFJLSXhNRENPYVJwQUprd3hnRGFPc0tPQU9O?=
 =?utf-8?B?dUFtSXVYdWl4aHBIV29aM0wyaEhnc3J3c1hEbGREY1ZWcENGenV1QUpzbTNM?=
 =?utf-8?B?NXhCSk5HbllYWGVzakRBMkYwNlRFdDh3QWcxQStpN1hXWXZzN1o3OWJDQjJ3?=
 =?utf-8?B?dzZ4dmFyalJ6T084MlZncnFzY2pWYjFoLzNlbFlWT3VGUGg3ZDNZRXc5T2t3?=
 =?utf-8?B?ZngvbjE1SnlYczBCTDNRNWw0UEZEdU1uZWxVSkNpM2lxWWZuTHFiVFZOQWwv?=
 =?utf-8?B?MFlpN3NkMWJwNTEzSTcraTdjS3kyWkpkcktKeGI3NTRLcW5UUVJpeFQ4UGw5?=
 =?utf-8?B?N1JZb1VvVjZIY2htOHFHUE5FN2hmdXhrN2tjemkraStLL00wVm5jYjVYa0Y2?=
 =?utf-8?B?MWJpNkVNMXdibmpaWWs5MEtqdFhLQzFyOGhWSFBCWmtsY3hIWUhTbHQ1U2JK?=
 =?utf-8?B?RjgvWGd2eDVmajJsek9iUHR1cFdoSEVLaEhqOGhmMUpFdE1hODlFbTFzN0Ex?=
 =?utf-8?B?SjBRR3RNK3VpeW9YT0xRWWJYVnVCOU9MdjVxc1hrQ0QxZTlxRjc5K1ZLd1lq?=
 =?utf-8?B?UU4wKzdzTEdWd1FGZWJuczJxTG1ncFBJQldmc2lacmIyY2h4aFcrU0s3Q2RJ?=
 =?utf-8?B?bnp2Mm00eXJGQ2xPc0dBVjlCekhxY3EyNTErcVhqTWdJVi95RlpmemJpbWox?=
 =?utf-8?B?YmpTV0gyc3FYeEM4TEhkZUZuVnJDSWVkeVhmb1Z6NFk2WDhSUWZhTUtXMFZ0?=
 =?utf-8?B?dm1MOXo3L0E3Nm1rMTBBOWJodGZQK3dUSWNGcFdCckIxejA2SEhwWXdZTGRQ?=
 =?utf-8?B?TWNSejVOR08vaU91SGJYWUVTVXpXeXhDbXZwdnJHU1RlVHllTmZZUDhIYkVG?=
 =?utf-8?B?VjNwMGl6ZFNnNW5LNUNLT21jNmVnOGdCSitiOFNUU2VqOHNQbWNnYUNFbkdy?=
 =?utf-8?B?UTVRbHJrWXA3QWlIV2xycU9rTlM0eXFwc2E0ZDZNRTNpcWpwWUlOUVBzQkxS?=
 =?utf-8?B?Ym4yTW9YUG0xbEdqTUhIV3lCdWlqMTFFc1o4TW9qM1Yvck9RSmVDQkp6Rmwx?=
 =?utf-8?B?Wk5zZHlURVhsVzlpdFM3S1JEUEtDcC9ndjllcFRwNkZ6TnZWSDRnTG9rbXd5?=
 =?utf-8?B?bWQ4ZklqdzZGYUllLzZsR3AvZlJRSGFXT3pLVUdqWnNDdzBUU1BLZ2RJdm1Y?=
 =?utf-8?B?eWxxOXkveEVwN0dEejJPVytSSjZydzB2VFozejNvSDBRa0N4YVFsUklRTmk3?=
 =?utf-8?B?SDNWcHJXUElsMWJkYjFOdThHUDRHb01FamJPZXowbUZHYk5sK1hNeUlRN0Ji?=
 =?utf-8?B?SGE3aTZKSHRCVmNUQXdxM2pzUWYzOFd3K3REaDcveCtyMXA3WnNraEdnWmVn?=
 =?utf-8?B?WVNyYUo5VUZiMGJYSHpPK0JTdUY1STRPRFFueVovUGxRK2YxakFTc3Ezd1Mx?=
 =?utf-8?B?M3U0K3k3UFMzKzF4aXFhT3dKM2VCdzRBT3plYit2UzJIRkV4TzhMM0s1dGc1?=
 =?utf-8?B?T2lQa2V1dDBibDVsVTlwNmF6OE4yVlBIMHhibDY4S0pUV3RGVGtCb0pJRDNZ?=
 =?utf-8?B?dStMU1FmcmRDd3Fkc3hjN3l4RC9CUktOb1FNYUY1RDNobFlDaHAzMjFvZW05?=
 =?utf-8?B?U1A5ZzJHOEl5SlIwQzFHOHdDaGZXMHZDdmc3K1ZZTmxPSGVFQVQ4UnJlU3kw?=
 =?utf-8?B?Q2ExQVluemdsT2xaT1ZFTVAxYVZuMncwbE5PakNkVGdmSHJpdkpHbWxyTHNV?=
 =?utf-8?Q?5/PkvjgMVTwKZa2jt48V2mYUf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252e76f3-9769-4e56-7a1a-08de0c7de7a0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 06:33:23.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQZ6o2zet5bE9y9li18SJ6ap0J3nZOSjcLsRRk9NNwu5xdsw5/gfPL/jmfq+2gSFanImgQq67zfCkvcyBT2KBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

Add a helper to get ExtDst source selection.  This is needed by
disabling CRTC at boot in an upcoming commit which tries to get
the source selection.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-pe.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index d42f33d6f3fcc3758ddd103be5251cf6ea9b7e68..c8cd15f9e32de4d86c2acb8764146af1c3663c1d 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -150,6 +150,32 @@ void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src)
 	}
 }
 
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src)
+{
+	u32 val;
+
+	regmap_read(ed->reg_pec, PIXENGCFG_DYNAMIC, &val);
+
+	switch (val) {
+	case LINK_ID_NONE:
+	case LINK_ID_CONSTFRAME0:
+	case LINK_ID_CONSTFRAME4:
+	case LINK_ID_CONSTFRAME1:
+	case LINK_ID_CONSTFRAME5:
+	case LINK_ID_FETCHWARP2:
+	case LINK_ID_FETCHLAYER0:
+	case LINK_ID_LAYERBLEND0:
+	case LINK_ID_LAYERBLEND1:
+	case LINK_ID_LAYERBLEND2:
+	case LINK_ID_LAYERBLEND3:
+		*src = val;
+		dev_dbg(ed->dev, "get source selection: 0x%02x\n", val);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 void dc_ed_pec_sync_trigger(struct dc_ed *ed)
 {
 	regmap_write(ed->reg_pec, PIXENGCFG_TRIGGER, SYNC_TRIGGER);
diff --git a/drivers/gpu/drm/imx/dc/dc-pe.h b/drivers/gpu/drm/imx/dc/dc-pe.h
index f5e01a6eb9e918516adfc89949665fdd2ff1e40e..0b81dc6b251c452e7ca72f1cd12af065bafaa198 100644
--- a/drivers/gpu/drm/imx/dc/dc-pe.h
+++ b/drivers/gpu/drm/imx/dc/dc-pe.h
@@ -85,6 +85,7 @@ void dc_cf_init(struct dc_cf *cf);
 
 /* External Destination Unit */
 void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src);
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src);
 void dc_ed_pec_sync_trigger(struct dc_ed *ed);
 void dc_ed_init(struct dc_ed *ed);
 

-- 
2.34.1


