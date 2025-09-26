Return-Path: <linux-kernel+bounces-834290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D97DBA4592
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9F41649BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C1218592;
	Fri, 26 Sep 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EwFLojjn"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8F204096;
	Fri, 26 Sep 2025 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899174; cv=fail; b=WOx0fLKkFj2y1AEHRGjOc/GHSuIgAKXG2vzsapBoERBwI20rM8+01qbaP5i3gZF440AHkV33AR67ffJVx0AcGFz1/bvd/RAjZ57KbMThkrWBSsm9FAmULm6OW7qaE26Y4TyhE79C4QAnP1ufhJT1NzG491S0OsIvEmiR6EtlEBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899174; c=relaxed/simple;
	bh=x1GmYZUdne0TqWPp0wcKzh76PE3NKqDWjtRpO8H3z7Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EmLYgZY3s3uxbizdNZ4eq9GwAyC7g+IMoSujGnwEkvjMHAf44m1l/cPvPtV2NW3cEqU50lXWEkvriJgH1YoQO1rI9PNXHa3qp9VsB6Gmzn23Pe4UtDKN+8gxYxu5uUE2TELKxjDS8Dny7PM48+1k2+Znpgzo0BG2LepTGf4VY/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EwFLojjn; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgf5dI8kcBQUSKuy1oCYO6+bJ4yY8QAGGxCfh0CBCyTE1Z4l/qsYLMC/p8ZPpArQVTcrEtEL+I6jLWECdyWZje3GbdUtSg1DZ3EZevyQibJElZVakVG5wgLg5wPrgh8O0LkR6mRusxcXFH98N+b1KjVb0QMTU9Dogn5p++LALchXbgbq8T29zUq4Wrz+x4Mbi5s60udvSOWRgsFnHz7X3D6S3+JvT+nJSwcNuwwXml2exIcfSoWNdPMwts0Hfj/9tqBIyWb8YN0dsA5h7UWbm50MVPU8o2qSir1Ptz65I0/vBspDNC8vxIKm6yUr1NtIKDbvFehASVqh+HWjgJPjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY4joYq+KwC7xlg0vG1rXeQ+ueSsvAN6ojmXTP9p93I=;
 b=XDEvUjVU/VMwQzhkIHqcboPk+GhJXO21OVt8Ag0fSpI/Lcg15a7gm9FucKaGYNW9cMg6pfbDLMZ6yCj0XVDDSxTPHgoCcpGHg2ljs+cA1srWWmBomQ15eC6qOsOCMMYsTy3jQEjd0GXd7fidpnzf0RY/lpGJvFvQXGphaF/nPYfpJj5HFC7H3f32o6M9vnDDfPtAzrS8+HtzB0xvFk3w0VPHlvE7Yk/xyw8dEcwkqAIb9Cl1EADO7/LN1FZBrmLtIbJyvku3g1l7R5Ku+BHbgtV10ejuj/LOU5WTl3sJP5bCtH8oDT9dF+9aK+DkDWHgub8Af52Mvm+V+rwHuE9VTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY4joYq+KwC7xlg0vG1rXeQ+ueSsvAN6ojmXTP9p93I=;
 b=EwFLojjncVr5LF4FGNFLhlo9VowzlFlhg9d1FrdJQGJllHmOckO99dCJ3rYU5PRm50gfTgVuSTqQrb0xERNOS2FwoLVBlMZ46V8EtNy1JWrklfm86xzp8+Biy06AItUg1p8RA71prq3uP4MMyaybjw46H17121L/7VCs80cSjGZJWBTi0UUhhnYWS+NVVErMQbrAjYlNIChweHAzSqAnhx8ze3XgcGmO5paSpez0KuUhSiQz6EqYpe7I3xN+I+uvCfe4QbrK28+fUOkCG/gPCXB+/8d5dmJhjqgp+zpa8uF/cD11bmewUslXlMFc1laBpieg8nEL9814nlEs/KG28w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:06:10 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:06:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 26 Sep 2025 11:05:49 -0400
Subject: [PATCH v3 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-ls_dma_coherence-v3-2-602b1c0ce6b4@nxp.com>
References: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
In-Reply-To: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758899159; l=3083;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=x1GmYZUdne0TqWPp0wcKzh76PE3NKqDWjtRpO8H3z7Y=;
 b=HauiRVziALMJcla8kgDcreK6vGPr5ZpHHmOTBOl4YVK/5FWPh5rRMCiUDIg0L5Dofi36KDUir
 1I4Oenc9HbXDhD0J7wHObUiMv1K9QTOlk+CSm4LdEJaoLugdqyhZLuc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 8438fdcb-8c61-432f-c30f-08ddfd0e39be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU5HbDZ1RGVvQUk1Vkh2SFc1eVVha3BGMEFVS0hCUWRDdlcyY0wwaTVHQUNw?=
 =?utf-8?B?TDY1VXozanpoY3Y4KzRRSjIrM0hNQ0NhYkFwRWN1YjBqbS9Wam9Gc2hJMjBL?=
 =?utf-8?B?YjkrajdwVllIVGkxOVJ6Tjl6RmF5RkdBcXJza3MrcTk2bWVFUGxNb1pjeVZ3?=
 =?utf-8?B?K0xaWG1LY0F4Ni95V3BmMG8zWUw3cmZYVXJLT2NEdlhEN0lnS01FU3d4M0E4?=
 =?utf-8?B?cU9ZekZVUzBqdURpU3k0ek1YVGFmUWVLd21lZlFTSnAzdlF0UmdmbHFpMmxm?=
 =?utf-8?B?dXg4emVLMzFuRUVaVk1UZzIwR1FZZEMwd1FZOWhacUJpazlmbkRSTmVLYjFG?=
 =?utf-8?B?ajFsSlJXa2JGeVRseWFxTHYveDFDV1ZidHZtOUl4bE9ZS1lnME54ek9aWnd0?=
 =?utf-8?B?dnZOV1orbVAzQzZ5UkpIUzRWdnJVVUREMFRrT20rWk9OK25ZMW9nQUVmVUpK?=
 =?utf-8?B?dkQrenRFZDNIN0UwTWdPV041WnBnYUw4U1AzUHdsWTE5SHNVd1VIUE1pcVFW?=
 =?utf-8?B?MUdaaThNOStrblVQQk9wUC9SM29CQWlLdlgyTG1xTGwvYStuUHVtTnJyU1Vk?=
 =?utf-8?B?Nmo1ckdSS2E1TXc3Z1dNR0ozcGtTWmdiY0JnVFE2WUlwR013ZlFmbFY5VnhW?=
 =?utf-8?B?aWQwRjA5a3o0WnNrSTFwSmh5aGo5M2cvWjd1RTAwT1ZEYkZTVVRFNm5vMmpF?=
 =?utf-8?B?SDYvSGtOWFN4RkxaZEhWU3FiSFMramNPbGZiYXk5MFUwTU9qRW9QeUM3L05r?=
 =?utf-8?B?eDF2UWxkMkdBNGhuYlNrY2dXVnY1MnRHY1NtQ0Z4RCtJQURoQlBQcjZhaXhW?=
 =?utf-8?B?R3FxeXZ2clhDdmdEeXFDUWsyVERkanM2WmlCVW1IZzQyZHJtdGU3cFVucjlP?=
 =?utf-8?B?MGZYc0JIeE9BbGhEUzZWWjBjck5ZUGNXd1lVbEVXbDJQTmYrUkU2ZmgreVBH?=
 =?utf-8?B?MGJFSXBrMW5Qbk5LS1dqeVp4VCtKTVVZRWx3aWdoN1BVcFo3QTlGODhSSEUz?=
 =?utf-8?B?K2xDcWo2K1dNZCszWC9sR21SUFAvM3lqVE02dzFSY0psb2dMVyt3bUJpem5z?=
 =?utf-8?B?aWVJQjU3RVVCcDNtNGpNL3gzYlhxRUNYSVdwZmI4ZzduMHVuMXo0UVArSkFz?=
 =?utf-8?B?S005Nm1INlpFdVB5RERQSzZuTzZtRkdVbHYvNlllUEs3V1QvVDJjd1VwUnBG?=
 =?utf-8?B?UnZmdHJFU1hrOWVvclNEaXk5NEVRWkJhVGlmeUJhY3pVd0FjWFhrRjVUY3J5?=
 =?utf-8?B?TERkRGE1bVd0Q2lVcGVka0VxSEprMHF1V3VVUzdNOTRrWERzTnh4dGlSUmJj?=
 =?utf-8?B?NFpwMjByWXVHV1dXaENrMHRDNGZIRWh4SUxsWmJSeE9EZTlwQVYyazZDVzd6?=
 =?utf-8?B?YVZlWkFGd012Q1ZPYW1Mam5IbG00aWhhNElHdjlmZG02TzJHWTJKRU9jUkdR?=
 =?utf-8?B?KzB2VllSSTh2Wm9jYjMvNWk2L2hncWhmdlpoeTVncmNsMmtZVzZSdVZXL3lp?=
 =?utf-8?B?NjcxbVMzZCtMUG8vd1JWaUJMVkhqYVlsRE1CZlE2MmduNHRRWTlZSUxVRFoy?=
 =?utf-8?B?Mnl1S2hMWHdXaFQ1OGlRbmFlNlV4MDZzLzNvWVN5c0hwSitabTQxNE56WFdG?=
 =?utf-8?B?eFVEeG5KRWJFUWUwUUVFWFZzVVB1ZHNnNmU4Vk9lS2lnaTRRVE81UmFnRDlt?=
 =?utf-8?B?OVRJSitCZXFUaVNvVXlVcUU0T3A5cVBnVVJ2c3VDQzhSM1NBTVNGUUJEMEFW?=
 =?utf-8?B?M1BNcVpBeG1XS1UyYjhtZTlEQXhUdkMraTc1ekxWRHQ1eTRvWmxoR1NOR2lw?=
 =?utf-8?B?UENOVCtEYk5vcVZwRnVtU2w2aGtOV05lb1pvQ29vZlFCdlhtQlI4elNvOVNN?=
 =?utf-8?B?MFRRMXMzSldNOENZWDRHZ0RBS0tRaDhkajM5ZTdQTHkyNW03YUVhaWJyejRV?=
 =?utf-8?B?ek9JbGNiTlFhSjBUdVU5WHF0Z1I1OTA2MGE1K1M5eVc2K095NjNONk9mbDlC?=
 =?utf-8?B?cXp5MlVacXNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTNNZVMzWFN1SVdGQXVGOHRTdS9tdWFUZjJhT3J3NnFJM2NmYktUaFVZcjRz?=
 =?utf-8?B?YzZQaGNLT1NJTkppMHBwa1htZm95ZDBCV25ZZlVhVWhNZG5yVUhaaCtIMnp0?=
 =?utf-8?B?S1JBMzRZZFpEYXVMZnNydDVCVlphRmZRTmUvM3ltNXZYQm9KaEc4Vkl2M2cy?=
 =?utf-8?B?YzFSQTBhNC9nVEdqS0cyRkplN3Y3ZHhveVVHcVY0c2t3ZGYwQ3BlR2Y3RExT?=
 =?utf-8?B?bkZtdk5QTHhIS1hvMFRzdG5RTFdaeHZDQVdaUElSQUVtTk1jWDJpUGdhV20z?=
 =?utf-8?B?dTBZRFNrSjkzbGt4dE1KOGFhMkpqVk1GbHRwUUEzWkZ5d0VnQ09PY05MQXVl?=
 =?utf-8?B?SXhMaFJFU3NKeGE4RjErRStYeXA0MkxBclB4bCtsb1BXZS9ZRUhFbXNaSm4x?=
 =?utf-8?B?NEF1ek1RR01Ba0YyWURKQXNxUU1IK2RKZGhCcFlxeGRZVENla3RKZ0NQbTda?=
 =?utf-8?B?MStuQ3pQMzJrZzJZZ1ZnMlJncnlwRC9hN0RUSk95TzdPd24xRkJySFpwZXUx?=
 =?utf-8?B?WC9YdVBjVGdrTzNhaGFYTjY0Mk5SeUFBeHR3Uy9hN3oxUVFtb1Q2N1NyTit1?=
 =?utf-8?B?eVZJeFQ5cU5pR1N3VzRkMkVNWXR5UEVuZ0J3dDRWeWRJZ0g0Z3JLOERyNmJq?=
 =?utf-8?B?QW9YUTM4OTE2QW12eTFlZlB6NS81eTRhVGdDUG9qekVUSVZIcWtwRWpJRVdo?=
 =?utf-8?B?L3paSThac0dMOGtLdEFEYm0yT3hCbkdhb3pMTXd2ck9aUldQbldIdzJWamUz?=
 =?utf-8?B?c0NmclUrcUpYMnBYREFuUTVPM1FiYUVTd2RaV2s4SmdlRzB3NWplRC9EbEN2?=
 =?utf-8?B?REtOQmgwTjNHMkdQbllHRTREWkxuVlpsNVlzeUpxZGMrNW5vNWhLQ05pOU1N?=
 =?utf-8?B?NkZkaEk0OUJwc2xkOFA1OW1mTW1QRHQ1NkdPWDIyckRLMXNTR254NEErWS8v?=
 =?utf-8?B?RVBycWErZFA3aHBqYVhReldHaU52cmVocmVhZEpKRk92bGVsZlE1SXg3eWt1?=
 =?utf-8?B?TTFLcDJuV3ZWdFZvWFFaaEZPbFJkV3pKWElXOCtlVVY5TldCckY5RkZSZFAr?=
 =?utf-8?B?eUdUN3Bnby8xWlNSd2drTGRtWkFlQTVIdkV2dk04bFFsUWNwMktZNUlCYTRE?=
 =?utf-8?B?TWpKYjZyNU9IVXBtNEZ3bmpMZks0ZWU0VjB2V3E5UXVGVmc4eVhScTJkeHBK?=
 =?utf-8?B?R1h1SUl1UzcxS1E2ejBsREJqV0ZVby8zek1Wa0xGRGVKUGFzOWxCZ0NZV0JC?=
 =?utf-8?B?bjJTMEQ4eUxIbnlUTXppckNtQ01RcUlMbSs5TTFOTUJMK2NMd1AyeXZLaklR?=
 =?utf-8?B?UTJvb0JFRmtHVGRjS1drUC9EUDdOVXlwSHdKWHMrUzQ2YTVSNXdNOVV3ajI3?=
 =?utf-8?B?T0pNK1Y5eVJ4WVJVanpxKzJ4R0txUXY5VVEvTlFuTlR2Z21uL2pQNzFTOFo0?=
 =?utf-8?B?MFpTMU91UGE4R2NvMmxqRVRndGU0MWFTV3dFMnZzUnZEeU5NY1lMV2E5WE9L?=
 =?utf-8?B?eFdzSTlFWWJlU25vNHZkYnVISUtRMkYra0FWeElLUEJzdEdEN2lIMUNmVnBF?=
 =?utf-8?B?SHJHNDJTN1pJT1h1ajV2VnBxOVlRRk9NQzllV0NTS3dmRHpOQW9DY1ZSTmFq?=
 =?utf-8?B?ZTlickFrb3NHYTlBRnBURFArUVg1UDFheWVPcU1Nb2Q0Q2NETnl2LzNtemVG?=
 =?utf-8?B?eEp2amM3NUduYzBWWHJUMXc0MGlPMWtFOFpvV2hLemZsb1VWWGVwM2NOVGow?=
 =?utf-8?B?RDB1dlRtUHdNZjdzK0NDMXdYd1pVbUo0WXd4dlRoa0NKeGdxeG43ODJXQlNL?=
 =?utf-8?B?M2twUDh3b3BXVzJlM1FaMGdhS2RlL1d2SXJqdEZYSjh5L2s3bU14bUhRUkFl?=
 =?utf-8?B?QkZnck5sNVREUGw2T3VjazR4SXp2a1MydS9aZ0ZFc0ZvOUtqeXBRR3lDOUxP?=
 =?utf-8?B?VTZNRXpGVnR0UGhUaTFKWWFuRmhlWHROMGpLWUF0MUlXVDdrZmdjWCtFRld4?=
 =?utf-8?B?MXdmNmV4aHZ2WWo5bExnZ21GR1YybTVIaG9sdXJJVSs2Nm5YQ0NsSDVROTNm?=
 =?utf-8?B?dVFiT2dLWUFsOCtzTXplbTdTM1NxSGhTeC9iNUVZaDdQa2VXRWIzaE1TYnVX?=
 =?utf-8?Q?1ll3E2tJ9Mg3IaKdEF9eNRwKC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8438fdcb-8c61-432f-c30f-08ddfd0e39be
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:06:09.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbh/h/WRllPEXo5E3Vs9cmPyLXMKoER3MOlWpbyFV1NssTd6uitWEGp2spPqxbkVD0B/RLB4LQDd8sZOSIK6fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8960

Add layerscape dwc3 support by using flatten dwc3 core library. Layerscape
dwc3 need set software managed property snps,gsbuscfg0-reqinfo as 0x2222
when dma-coherence set.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- rename gsbuscfg0 to gsbuscfg0_reqinfo
- add default_dwc3 driver data.
- use_reqinfo to indicate gsbuscfg0_reqinfo is validate because 0 is
validate value for reqinfo.
---
 drivers/usb/dwc3/dwc3-generic-plat.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index d96b20570002dc619ea813f4d6a8013636a0f346..ad7358f6e68ae4f434bf78bb958a73589c9a224e 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -8,10 +8,17 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include "glue.h"
 
+struct dwc3_generic_drvdata {
+	u16	gsbuscfg0_reqinfo;
+	/* true: use gsbuscfg0_reqinfo, false: use default value */
+	bool	use_reqinfo : 1;
+};
+
 struct dwc3_generic {
 	struct device		*dev;
 	struct dwc3		dwc;
@@ -29,6 +36,7 @@ static void dwc3_generic_reset_control_assert(void *data)
 
 static int dwc3_generic_probe(struct platform_device *pdev)
 {
+	const struct dwc3_generic_drvdata *drvdata;
 	struct dwc3_probe_data probe_data = {};
 	struct device *dev = &pdev->dev;
 	struct dwc3_generic *dwc3g;
@@ -41,6 +49,8 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 
 	dwc3g->dev = dev;
 
+	drvdata = of_device_get_match_data(dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "missing memory resource\n");
@@ -70,6 +80,18 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get clocks\n");
 
+	if (of_dma_is_coherent(pdev->dev.of_node) && drvdata->use_reqinfo) {
+		struct property_entry props[2] = {};
+
+		props[0] = PROPERTY_ENTRY_U16("snps,gsbuscfg0-reqinfo",
+					      drvdata->gsbuscfg0_reqinfo);
+
+		ret = device_create_managed_software_node(dev, props, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "fail create software managed property node\n");
+	}
+
 	dwc3g->num_clocks = ret;
 	dwc3g->dwc.dev = dev;
 	probe_data.dwc = &dwc3g->dwc;
@@ -145,8 +167,17 @@ static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
 		       dwc3_generic_runtime_idle)
 };
 
+static const struct dwc3_generic_drvdata default_dwc3 = {
+};
+
+static const struct dwc3_generic_drvdata fsl_ls1028_dwc3 = {
+	.gsbuscfg0_reqinfo = 0x2222,
+	.use_reqinfo = true,
+};
+
 static const struct of_device_id dwc3_generic_of_match[] = {
-	{ .compatible = "spacemit,k1-dwc3", },
+	{ .compatible = "spacemit,k1-dwc3", &default_dwc3},
+	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);

-- 
2.34.1


