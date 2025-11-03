Return-Path: <linux-kernel+bounces-882240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA51C29F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB91188C873
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB76288502;
	Mon,  3 Nov 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XxmbazE7"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294E264638
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140443; cv=fail; b=RVmLb2uylLch6NMD/RH1L9u382LRmHEXs53uAOwDNVtabwTI2VtY+3zXI4bOb02PhtZJBP+39D+SMxDsNWOgvwl4phTC0hzyC2qGQHhXPsxgU3aHgkTzJsGGN9oioBIA79l4jaqoT5vqgGcgABdIHGHVOyfuk/clPg5I8WbF5mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140443; c=relaxed/simple;
	bh=891140bDcZvBk8TYwEHcZHUNeGjPo4EOX9zyX9XlP7w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Z9KQRfoAfqoneh12Edqhx86bG1QB+qbXNGyKj1PXUvLcgBvWzK9K9g9qgo4IVdTEzOgS7FoauZJfcV6bodlloBB2Vhwyhdhx+yjytt7HjZ8/fPGbl8vOSg1mNqWcb+tS6INPR3mtJXapVYW3VL5K16nfgj44ry/SKkQE3533dCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XxmbazE7; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbIK8FOGqW5y4tPrLBD0+BOlk3B9STjYKTWc73ZmKbr08SXcjlvO/fhFHPItOgjiIxUb+c5OdwLlaBiXNk2DFNTyIR19b+JJ00yvZZBzbkynZ8tegQ26nZBKXeJ2qqLlKPW+1Cs9bHpgZEreZ43qQt59ScUZtATUsiphBDLQ+tEQnDrhPoqA/s6njD/zaTdRwY135Q0wnBQcIBG097DSwXxMhudXxutJIu7Mp4kASaSd3MkTOxWwXti2uq9eXTn0KEGwJo9xsbZLRKYKzVe2G+mSVO6oSDK39mZbYd+4rPV/jvFOKq7Dvm8M6Z3LlRyPCTrQhbT758MxXJVFjhYUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biGaC9VWeSYHqLxeziRgRxOXSLX9SvPPQ49dCe0aDCM=;
 b=q1Q68wIuZF8GmhMWBjCxprHBTh3R2DcJA6nWoO1L+acqgnd3RPzt25nNRjFUvvtGPDZB/Dddd56T6x6NSwKUNt5xGFjP0/GkrncHfIP6oFVhGs8GmUyVz+VsvQl3VOzhLYBxVxIEFRpnf2Y+2XfDESJKMZ4s2DgHIz5LXTrIsdRE1Eza7UUxBCstL/FeTXxSH+ylbSuY/STPuc72vc1lPhyayy0MpA8+RVbZJBod4PWXzvJ+daqv19zFdMbX0lUFnXiHFuPkyP60+/nWSQBe5ugYvkR3yynQD79+ogj/qgXB1nmb53TdcD72M1bs5+cAvIiGnasfavI8owBo2PIN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biGaC9VWeSYHqLxeziRgRxOXSLX9SvPPQ49dCe0aDCM=;
 b=XxmbazE7IH/tfDog2GWqxhQLX5urlb+puDoNaly9r1xIFuYCAKTpGyWKtGKKzaAARtEtFZzvqyjFtNzdgfQ+CNvuBdjxM3zYRc50fwutzpLlGaKzTk2at8gRY9vpAd90CTyarnjL1NDaEp2USaByEKGbjRAPsejzF3damVbWgmWcvD4TO7x+1NgmZ4A4wBm6adKcEnGheB5S0O+2r/mxpJieVzO5J8IivG89fQXMJhjGlcFkQVacYN3YyoldbRzC0WOywYeUEctDkBul8xFbUPPwkCTM/RVXluZBmeB9Z+JKINAuoLxoo8AsM5BJdwd4O9IvSX0ixdNiBk7D5eG+ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 03:27:17 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 03:27:17 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Mon, 03 Nov 2025 11:26:49 +0800
Subject: [PATCH 3/3] regulator: pf9453: remove unused I2C_LT register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-next-pf9453-v1-3-a025d536eee1@nxp.com>
References: <20251103-b4-next-pf9453-v1-0-a025d536eee1@nxp.com>
In-Reply-To: <20251103-b4-next-pf9453-v1-0-a025d536eee1@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dff510-3219-4745-c775-08de1a88e3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHZTU2QxSm4wdkFacTEyak9DT2tFTXEyZWhpbVF5Y0gxZDgxTkJGaWJPb1NJ?=
 =?utf-8?B?aktvTjFRWjJjTWdaaGptblNFa0l0OEtyT2hwdzFsZVMzOTJLZmJOTTI3dnBU?=
 =?utf-8?B?WXI5WnlQdy9VYUhHOEhibEVDMlNkV2lGTUNLcWtrOExxWHg1LzhPejR2VjJi?=
 =?utf-8?B?VkRTQnVCSUsvRWI4bWhjODlrMHB3NituczZ4LzBaZ2hoRTRrVmFNVXd2V3ZV?=
 =?utf-8?B?ayt4WFpVNDIzblNPL2ZPekhMR09ObHpTek1xazRjUEVpdTc3R1EyK0tvemxi?=
 =?utf-8?B?THFkbkVENUJ2SzRrT2diRVNIQ1ljSTFtVDNXekRUcjdXOFNleUVrNk44Zzgx?=
 =?utf-8?B?dUJOeGw3TTJJTDZ3SGY3Nzg0cVJNMjZiOTJKL2FrcW5McTEzYjBwWkY1Mjhk?=
 =?utf-8?B?N3l0Sk9jQlliZW8zcHdUVjFzbVBXZjFUNlVWMkhNTGw1LzhoaG1jcFhmN2JC?=
 =?utf-8?B?cVB6QWw4T09mWldSbUNxdFBFU3hJc3NpdU5BdDU2akhNc2JQWTdDdWFDaHNQ?=
 =?utf-8?B?bzkrQWpNVW1Kbzh6S0NOQ1poZE16SW1TQVFUQ1BpVEFOVDhpWUVudjI4Vndt?=
 =?utf-8?B?U3I0VTdGODlIdVcyVWw3WTl3T21EMWI1djV0eDhvV2srUUxIcDhwb29VWHQ2?=
 =?utf-8?B?Umd5eTl5TThEdHVNc2Z5bUtjNVpidEJVWHlxNTdZOU5hWCtvS2ZQaDJmTWhE?=
 =?utf-8?B?aWhxOG5jVnZjekNueDNqOTl3WllkY1RZTUJOZGh0TlVUTEVEa0hKY0NxNGR3?=
 =?utf-8?B?OVZNL3NUUVBwTVhQR2hENVl3MjlnUE5rZHVNekh0VDZHOHpONzJObmRUcE1G?=
 =?utf-8?B?Mit4Z1k0Y21kbU9RSC9VT0E0STlyUHp0cjNhbzQ5aXhMNXp0WmkwMnhmbStL?=
 =?utf-8?B?U1BrTFN1RENiVnpkNUZtQ0lEM0hXdnJVNFZHV09LZU9WMFRhcXR6Qi9FNzNu?=
 =?utf-8?B?SE1tcnFpVjJ3WHVlZmZBK2tBR3FseElBVTZqd0lpY3BHR0h2SUx1MC94YXU3?=
 =?utf-8?B?M2lYQU1QdHFpVzNqVFNuV0ViS2xQSGxIaTRiVm5zd0NhNm52MndoeTVnQkIy?=
 =?utf-8?B?SWVKS2dtQlR1YTFzQ25CY1ZqbXdhT25wVXZISEh6bnVVUGNJZURZaHFIbGwz?=
 =?utf-8?B?WnE5c3lQYzRIclQ4d1F5VlNtQmpjSFROZllpdURWNzNMUWhYRnFhRjc2cG1X?=
 =?utf-8?B?WDRFbG05K3AwWlBZNjlMNnJVdmZwb0M0OHZkZ0RJdVloMkJ3ajkzM05NdWgw?=
 =?utf-8?B?VC9HUnViQ3hxR29icEZUZ1l1R1h3ZG02SUlBUUR5UUt4NDRqSHhJQjRibUJD?=
 =?utf-8?B?NlNBQXRadDJuaDR3YkJkSXVsSXlqWE9yT2RyZ1E1YXFoMGkvdm45djlXaDhr?=
 =?utf-8?B?Y2NodDlIQUUwUUhMSVh4SFhNSFBNaFNUR3hhUGYrWk83bzlqaVN5VmFJc1pL?=
 =?utf-8?B?SzVOSU5NZXUySHd1a21IUzc1cDdiektXUTVLMG9Gem1ZOVUvL3lRRm5lT0pD?=
 =?utf-8?B?SlY1Z21nYWRMRHhBZWFKcUpOQjRmaVMrcXY0UThBQmxUbDZ1UFBWRnh4UTMx?=
 =?utf-8?B?cmFQU05qOUozazhnREVLWldHVTRiSXNNSGxCa0J6aUVqZ2g5UVpaNmNNd1N0?=
 =?utf-8?B?Sjc4dm1Fa2FNWkd2UEtoYkNWM3J2VVJ4aUxYb0JnTHpBL0NwcFJKUHFhck96?=
 =?utf-8?B?L2xzWkNtR3dlTTMvbkt6dmJXeUI4ay9zZSsrYnBzcEE3bnhtWGpIcjJvbndO?=
 =?utf-8?B?WDZFZENiaXFUbU5KVTY2OWFGL2lxYWRaOEJqSjBVaUw5RGtOS0NlQk1TZXJi?=
 =?utf-8?B?ZFQvUzNOemVwZjVCRGd4NlpScDZLOTFKdTJ6bGZsZEpEdExjYkRNTFhMd3RU?=
 =?utf-8?B?NTMzdWZCMjZERXRnVEljV2xzQTJMYUtSK2RUL2dwejhMVHVQbXFBaWMvVERj?=
 =?utf-8?B?dU9mSmd4OG5QbnJvNWwramE2Z2ZZT1dOaGJsYTFjUGFIR0g4RCtsZzV0UnBJ?=
 =?utf-8?B?MXJlTms3dGJZUEI5SlpXSDNTbUZGM1hlS3Fid2VJeXZ4WHIxUThjT0hHZm9N?=
 =?utf-8?Q?0biGg8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW5iYTZnUG11dHNJblhqQVZnMEUxVkVsNTg1ZDFaRTRVemdTVEFiRVVOT3U0?=
 =?utf-8?B?NWZaZ1NoNy9lQ3VuTk80alljTlZla2o2U1V2cEdtUnBCNmFjZWxxMHBPbWJR?=
 =?utf-8?B?N09PdTFLcGJkdHNyMUNGMlBTK3dmY25RdzdpZXpVeXJ2S0dDY3dMSmRSUE9W?=
 =?utf-8?B?Tzk4bytQc2p4S0s5aDBMbE53cXk5ZmJvdHhXRmhOMWxjMEt0SkE1ZWFGVVFa?=
 =?utf-8?B?TTVkdHhoRDZnVDU2aEVMQXdkUmhjL3UyMXRUMlBVSGttMjgwemlQRVQzS2VK?=
 =?utf-8?B?SFQzbjNoeTRGcUJ2ay9Zd1RGdFltd3dVeG9YaVlLd0xTdGJSYUxjdEVsL2pP?=
 =?utf-8?B?dGF5dEtPS29vNXkrWVRWdHJoU2ZVdXZOQVRkOXpoY3ErZGRqMnl4OEIvL3cx?=
 =?utf-8?B?Sm9iWFFLSDJJR05vUG1NcWdHMCtpZFN6S05hcFNhQlp1QWQ1Y3hlTHVMMDRs?=
 =?utf-8?B?bFYyaHNGQmFKQTdBTkdVbFBvQlVtTmtnRnJWNld5REwzamxMVW9uWUxiWUVF?=
 =?utf-8?B?WVJscWdhTFBxaW9VWVZ3NzlEZ0tObnA4QVZMWGZjUTdMa2M5dWJNcC8wb1Qx?=
 =?utf-8?B?aWFNWXRsV1phamRvMUk3SktkcHlwUWdkeDNENU41Z3lkdEZvdEFPOWR1OVpn?=
 =?utf-8?B?b1hoWlRCc0h5dVkva1RpSm1HYWI3dmh2cVNKZG05WHZWc0NzY2xtQVJiSGlw?=
 =?utf-8?B?LzBXb3ZvSmpYSWtRNzZZNDBtbXpMOHJzRTErWXA4SERzdVJoVTdLcXRDNmFq?=
 =?utf-8?B?K2FjelA5UUpRQVJ3M3pWNGpZNmtuUmU4bmR2L2ZRWGR0M2VnZ1RzOGkybmNE?=
 =?utf-8?B?V09ya0FhZlFDNDBVeHdBZWFZb0FtSVpzeDA5R29paG5taENKM1puc3VCbE02?=
 =?utf-8?B?Rkdzc3llaHdLaUVjVWNRSlgyUi9iTXFPcmxlTkJQcFBjdEpXNW8vRWFkMitH?=
 =?utf-8?B?YlRKTFhFQUZjRGQ1TURNdzIvUXVuNi9jb3NhekZtaGF3QlMybjZOcUlmVXZX?=
 =?utf-8?B?NEFHcWg0aFJzN0R4NVNMMGRjNzJ4NmtDR2ttS1d6SnpnYXJJUDV1QjAwQjBs?=
 =?utf-8?B?ejA5RVk1ZFg0WHZpQ1p3V2lxZitFVCtCdEtSWC8yUTY4NmNSZGNWZHhoL083?=
 =?utf-8?B?MlVNaHFHT2NsdmhrUHVyRmVjcWN1ME00QUQvWkt0QUZQcDBqYWxjTXBCL3Qr?=
 =?utf-8?B?TGVrbEhVNVY2c1VPaWNueDN6UkI0OC9FazlhNXZZQm1yM1dRbUFWSWFROStV?=
 =?utf-8?B?TFdyNTdjSVRxR1RYdG1taTYvUDRNQnhjSTBvR2NMbGNsKzhrbmxYRk1HS0tD?=
 =?utf-8?B?cnVYZWZ2TlM2NE9KaUNZYzh1TDAzMEVDdmlPYVhsSWdJaURnTk1nSnlDMkow?=
 =?utf-8?B?bjE1RnF2TUp4WkY5cC9KMDNOMXRaR3RtNlQyTHNjM2V5bUdleFpocGNYQXpz?=
 =?utf-8?B?TlFmYjhNM3M5SytVTEZvSUlpQU9uQVhtUXlGZmljU2g5SU9hbGYxTW9DNUJG?=
 =?utf-8?B?OEJsQ0VDbUYwcXA2c05Qem9Bc0crSnJEWVc1QWFMU2srRVdQNCs4dE96UUpK?=
 =?utf-8?B?TExsc3czcnkrY0J6Vkx1bEJHNzZieWhVaGc3R3puc05nMGVKSWNnV2hZdEls?=
 =?utf-8?B?emN5QmRkaVhXakNkS3A0c3pVMnlVZmZJdHA5YVEvNXVwK3U2dlVkcFhyZXl1?=
 =?utf-8?B?WW5Ua0JxN3hkVHpabFhZMVVpcjlJU2pNMmxmMkc1UkhhMWZ6a1JWOFNVdU5I?=
 =?utf-8?B?eElGby94ZldzVW9jcjIrbXN6V0VvcjlFRSswVzBmZHRYQ2VDaW1qWDB4bFRJ?=
 =?utf-8?B?K1prMHJFcmd3c3lPYXp0Z0pOcU5QUmx2eTFIOEk4NUhSTVpTRWZPN0pnOHlY?=
 =?utf-8?B?WHdKMldUTmtzbE9jcWNCOEFNRmQvZWp6RVNoZWdWaHMrUE8yRmZXdkRiL3Bt?=
 =?utf-8?B?MCtJZk9CYllQL1BOV3dJb1I2MVF3OGszOUdjUjlqSDdkYUpuLzdzNyt3Q0hQ?=
 =?utf-8?B?ME1Cc1JraUNDVDZpd0ZjVGNTbm1CcklZR3VqckgzSVE1Z3c5Uis3L2pDOFJV?=
 =?utf-8?B?SjVjajdTTktSL0VJVk05RDlyeW5rcmRPTjNZdzBjVFF1Uk5pZUdmMTRuR2wv?=
 =?utf-8?Q?hqDNYdqP7NVB+PAzx7BpoPKxk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dff510-3219-4745-c775-08de1a88e3c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 03:27:17.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r+qbSFp/srM642Za0YmHUaGU1hQMDhLKAYb4g722IOWGFvcmIvQL0Mr+AhZ0WcF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744

Remove unused I2C_LT registers, which not defined in PF9453 datasheet.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/regulator/pf9453-regulator.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
index fded3e65b856f51be97d9d4b307a2291d247a21a..4cd7a9068836f61d6308e6bd733bdff95dd158a3 100644
--- a/drivers/regulator/pf9453-regulator.c
+++ b/drivers/regulator/pf9453-regulator.c
@@ -187,13 +187,6 @@ enum {
 #define WDOG_B_CFG_WARM			0x40
 #define WDOG_B_CFG_COLD			0x80
 
-/* PF9453_REG_CONFIG2 bits */
-#define I2C_LT_MASK			GENMASK(1, 0)
-#define I2C_LT_FORCE_DISABLE		0x00
-#define I2C_LT_ON_STANDBY_RUN		0x01
-#define I2C_LT_ON_RUN			0x02
-#define I2C_LT_FORCE_ENABLE		0x03
-
 static const struct regmap_range pf9453_status_range = {
 	.range_min = PF9453_REG_INT1,
 	.range_max = PF9453_REG_PWRON_STAT,

-- 
2.37.1


