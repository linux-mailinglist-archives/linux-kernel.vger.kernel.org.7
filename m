Return-Path: <linux-kernel+bounces-880424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847BAC25B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133F63AF4A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F826ED38;
	Fri, 31 Oct 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ey/tMfj/"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942942F6181;
	Fri, 31 Oct 2025 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922014; cv=fail; b=IQ4ZwK4s8gb8RLfU7wlZFKL41T7RKPMe00DFSpsNsckl8oEVBD8KGtlmOWHkHtyrlYFe/XSwUKy59njuZinQu881LQ4Z431Bic9zQ7cV1WgZuz0uyU6Cc6ASSKvXowIn/awi6rExZz4wAB8hiBq0zRxf8BK5VhDGwyXrFWGP6dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922014; c=relaxed/simple;
	bh=FKWVinr4oWn+ifNv2UH90HOzCR8afTSjB2ObrMhxRCs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HdgiGZnXS/WM7jgek9hq8XASAO3oNr1gqd7xOVrBLoRqGR4olH+pGATiGaZmJKhVVd9x5lShbyuPV7g0SFg3+fN+FlIcNZyBE0sMk7xzlRXXWl7L2wNvjo1U5z6CK5JQMEJYrKaUQLcY5CmGn2Kq4H96ZIh7WYH4fszdPuwtedE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ey/tMfj/; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip3rpc4ZfPXgBTpwneyOUwWDPSJN4Rx6Vbdj6cHtddGS1ZpXHJ6jBygRXtwXL8ekJmvnpGHDdoAK51eK0zamgEuMifuPMuTHQVUcSiyNCxJJ43JbdpXnTNwDLixyHE8LrH5ZqQBqTEV49hN8125TW8CgMeqTC8ZRk/YrbAMWTeNniBzJUW9Ku7vabpqDAHVl5WIfwMLT8ClqJGRm27ZaCm5/qhbEjLQWwfAbRipN+zC+/y7zmXDPPUgn4lkkfsT7yDHPnIKvp2EgvLjM/BgzSWaSTfr+hfbyrCv9c5Udm2cqGTCCk+vHZ/dtM8PNVZB2n0pEKu6KJBdD3uscouK8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmNX32z7MBiwpZFhGRg6/83aor9O7AHknehc31BZ3kA=;
 b=MEFDb4EEj0/AIX2p5vwzF9SbRKiQ0QpVib+/37zBqK6KDNwrwTxhUTmTWp9KUOJQv2cbAzOr0u378UxliJv+t2AbaOiByt9wrOWJ2Lcxc4HpERBqypsAOWFnAFvaDPQuUsCZb85+fTb1UJ65QDjOPsE9JRVrVyWcAnY9U0/oSk2Z29kIIRMQDbiZ8XrWoL9KXhIZdg8cfeD0B0hE/9/iGoKF1zhLs/2aMNPvBao1G9Id5UPjLQ9HiAdlr66s3BJ98kbMBU3baH4vZN+U4V+lDOXFh4ZNlYavYTHdcgB3bxJkwqRBipwPgDTI7ApVWEeDaEk0Gl9oXCitVexAVgEiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmNX32z7MBiwpZFhGRg6/83aor9O7AHknehc31BZ3kA=;
 b=ey/tMfj/9ljr/2FRBmDaWAoBUH2DqEn+IdjUiBzwmcvkH4zswHKDAGNmK9dmMQebJDNVX6TPn+64jvTl7J6T9mWBQnCmNVV+AoyeCpLG5RTDNbADsWMONM4wboz1rtyPA1scdv7ZxojTBisE/CjCvAN0bnZpGpevvjL4uilQjIpI0TP0fzUHNgrVtKrzOW2ZyuAmcG3quVcItdnkLfIsI+hS2tCm4lFzNnGnXQMsIL/HBb3WsJ+f7gW4ZDYejMNMtNHtaK1SaCdW5fzxslfC6Zkx+pZsk70r1LZWuWqDrr8vMuSCEVZuqfoF1bART1/Q0osEEAvkN/ZO+m2Umo9FdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU0PR04MB9634.eurprd04.prod.outlook.com (2603:10a6:10:31c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 14:46:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 14:46:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Peter Rosin <peda@axentia.se>,
	linux-sound@vger.kernel.org (open list:ANALOG DEVICES INC ASOC CODEC DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	asahi@lists.linux.dev (open list:ARM/APPLE MACHINE SOUND DRIVERS),
	patches@opensource.cirrus.com (open list:WOLFSON MICROELECTRONICS DRIVERS)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] ASoC: dt-bindings: consolidate simple audio codec to trivial-codec.yaml
Date: Fri, 31 Oct 2025 10:46:19 -0400
Message-Id: <20251031144622.4033833-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU0PR04MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7b6038-1cdc-409e-7873-08de188c500b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZSs5OGdOVzUxQU5MREZITU5US1ZZTlJ4K0Q1aENWMjdrWFIycEN3Um1jbzZz?=
 =?utf-8?B?WVY4WFZ2TE02TUVweVpKT1dHSk1mVlZNVVBlWHZOZThicDVhdlg2eWJsTVJ5?=
 =?utf-8?B?SU8xWDlSZUg2Ym1sRUphL0NuSmw2NjlRaDZxeEgreUduTmhYMnQrRysxLytY?=
 =?utf-8?B?R0hqNzIrYm52eFIxOUt0NVltZjlFV3NOd3NQRDE0ODB3Y0VMdTV6Q1NsMWJl?=
 =?utf-8?B?ZVZXTmEzS3IvdTRVODkzR244Z0E5djVMUmFaZ2RGTks5RTZYazZGam4zbE4r?=
 =?utf-8?B?Mk5wT2drVWkzNzFXdzFpcUVkUGJOWVlvVFN0NVljRGpQMGF6b051dUdmb1Mr?=
 =?utf-8?B?YVI0UlowRkdlS0tpblI5M0VWZFVwcy9IZm04TkY4YkFFaDVxR1dPSjFIOWV2?=
 =?utf-8?B?YUVSL3h2ZG14Vm42dmo0dmZnV0JobENPNFJveUVxWi9FVnI0b0d4MzdGb3hR?=
 =?utf-8?B?YUVWTld0ZWNTdkIyeDBuY2Irb2dkblErSWJNR21rZksvVlVlOTlLRk9FOTda?=
 =?utf-8?B?eHYycnl3TzJGRk0waDh5K2grL3ZQNWZRQVZVclNwazFuRENuZk5jcWRBWXor?=
 =?utf-8?B?R3JtVEtkeE9OL0o5L3VENFdpV20zSnBEd3RlNlMvOHVRZDh1aWVLTGozeG1U?=
 =?utf-8?B?dlhXbEpLWEwrSDBaVnd6NytSQkpubmJRV1ZZUEtyQWlEMW50L0gxOHlKZ2Jh?=
 =?utf-8?B?UGJiTFRtb3dlUUZFNnA2dUNhZTBuOUthR2swUmFPNTU4TER3L210bVBvVnNy?=
 =?utf-8?B?NHJvQWlmWUtaSDhWVTlvK0UxRm1LZkY0b1VzZkU3WmV1bnpiVTArS3FhcG9Z?=
 =?utf-8?B?cnVvZk1TV2FNUUtUTHZwbk82dHNDbkx1VWlxdzZCZXhlZFRiZFBpZ0pLODRa?=
 =?utf-8?B?cXRZeFJWYWJZOVpKQXEzNjhrNmMvT2tTUGhZZVpkcXNXdW1uQmRLLzErekVE?=
 =?utf-8?B?TGE1NXpPQXNSOXlKL05wRFQ0a01SWmpvb3FjZUtRMnQ4VW4weTJyUjFVMS81?=
 =?utf-8?B?c3BpYWhzaERrUFVRRGZRYnlVSThXdXpUVGJzalRoL1REWmREbUs0RGVlNGlP?=
 =?utf-8?B?VytMay9DODVqWHorVkFBdm5LQ2FVQWNjcnpseXdlekpWcnZCQlFxbm1KaUlZ?=
 =?utf-8?B?UHhLVU45bE1GZ1BGOWtSSnZMWHNFZVAxbDFzR083SmtUSGZ6WExPS0d4eVp2?=
 =?utf-8?B?dHFTMkgwWFZpR1dCMzJTd2gwZmx1SzJVL01BcktuUFVXMFNLY0xTSVpMRFhl?=
 =?utf-8?B?RDIyT0FsNTA4VnJYL2xVb3RXRGxzRDc3RzNUV2YyOXpvUzlSRytnLy90SUNn?=
 =?utf-8?B?bWRXZHZKcEVBemwvamVIdTFCdHJ1bVlDMk9manJyS0N5OW9rakgzbkhkTkFi?=
 =?utf-8?B?emRFamFnQjhIazl3VGVXUis2Nk1TSEhrS3BKZUkvb0ZQTUd5czlZZjZ6L0t0?=
 =?utf-8?B?dVJ4N1pkR0VxTmd5SzB4REdUZ1Y3clpkWktRanY3UkdDNXNWQzFuM2ZSbjFY?=
 =?utf-8?B?OHViNlhuZFpzQktWM3B3YlE1b2h2eGdlN1dmemlTK3gyWVE3Wi93M2UwT2VE?=
 =?utf-8?B?OTJ2STlmZmVIMDc3NjgvbFZsTXhJaEhYaG1Hbnl2QmFnS1ZFWmk2TVRWNVVw?=
 =?utf-8?B?cGp5T3RzQkRraUhyUlhlSTJldDVoemtUbzRnakp0MGhCZ1dXSDlJN0RrRjYr?=
 =?utf-8?B?eWNoT3RiZytHV1grZmQwTDA5TTBTNjF2SFJqVE8vdm1SN2Q1YjVtM2Ixc0Qv?=
 =?utf-8?B?Vmt0d0hOTjBnYVdvUXVLdEZKbUV2NjRXQ3dTcXhpWVVYNUt5S3FSUUpFdTEy?=
 =?utf-8?B?THdvelZ3V1dPMjRJZ3c3RFdUenk1UERMWmxZN2RlSFF3MFBUR01Eay8yekh4?=
 =?utf-8?B?ZFBja1Ara21HWjA3VEVIN01CVGttZWl3c01qdEpZUzRxWVk3Y1d1R1JPWU5B?=
 =?utf-8?B?UFMrR1hxOU1McmFJMktCRUY5MUJGUEJqcWx0aGpDL012emMxcGRjZ2l1UXk3?=
 =?utf-8?Q?9qA8hXgEWGg6Uzqi87akrEbrajzjbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGM2dDB3MUJwRFp0NWQ5MXRWQzJQbVVIMkFRRCs0UmNBenlLRElISHc1S3dr?=
 =?utf-8?B?aTh0VWhuOWNMVVVKbjdZQnErdWZSN0N3U2lDNmV3b2wwU2w2aHRVZWt2Qkdz?=
 =?utf-8?B?Nk1PYjVkdzd1NHdHWXdaN1NhejVJcWJJYzZPbm5oN0l3blhJKzB5cklGcWhh?=
 =?utf-8?B?bjFERWU2WFl6R3lYeXNGK0pERE9EaWVoMzVIWGRWd0VrR0VNUjhMMjVTZk9p?=
 =?utf-8?B?d2drVjV6V2EyWVZxQlJUK29vYWJib0tDazF1YlZHa3EzN3JBYVJRQ1ZsSmZ4?=
 =?utf-8?B?S044ZXBUTHY3QXcyemxqSG9FSU51anhvMTYxZUovL01DNW1DSGJpL3RyR0RS?=
 =?utf-8?B?SktaK1ppZUk3WGxrN3FzV1Y2VkZsaTVPNmdIejdHRnpOR0pZWi9mbVBRMHNa?=
 =?utf-8?B?RTRyRmRzOTFreVROVXNqeUFPTjZTMmhPdHh2OUc1cWRnTEp5WkpnQlo1TXpt?=
 =?utf-8?B?Mm1mUG9GS0tpV3R6dml5V3VzbDJsY0hISEFLMVJVa0RicGthaC9MRVJ6OEE3?=
 =?utf-8?B?RktEOVZ2NDdGU3FiM0JKdHZUdFcxSnptOGFQZ0ZuOHlFZWJOZmhQR0VEang3?=
 =?utf-8?B?cHUzV1UvSVVIMzRpWUJTSW54MU85NGRFbVl3SFQ0aGdSOVNIdW5xVGQ3SHdj?=
 =?utf-8?B?d2dMNmdwNlQ5YzFVTHFlM0szZVo0Rkd6YVBOUFNaZ3NMQlVJaUh0WUJCMldz?=
 =?utf-8?B?dVN5VXhMd0kxcHA3ckFVOWo2eUFFUkRFekNpcG1SOG5OeFM1alhrdDFFbEl6?=
 =?utf-8?B?WC93dnR4cElidWRkMUhRUXB3WXhwUjhVN1NJWHhFVUVQVHZIMUFqeCtkMzZa?=
 =?utf-8?B?czdiTzhscUtob0pMSUkzUW9QVDViTzdEaHFCME5tZWVjQnd2VEZTWDJtZnpp?=
 =?utf-8?B?NWFhRTlMMGJHSzdoMWZ6ZjlFQ3JWNDFtT0cyNGJzazVUQVJwRzZtNktQRnN4?=
 =?utf-8?B?am4vSFJrcnhreDVGc1VRdFg3cWxnYzZQTis1aWQ4WWgwK1MxSDNMOVhmQStF?=
 =?utf-8?B?cmVvRGRmVkdwR3Jham1wYTRTT1ZwMG1jMC9nSThLMWlZTm5JTHdNaDRHYVZS?=
 =?utf-8?B?SWtMVXVSSmpBNWR4SmlDUFg4YndyOFY3K0NtblBHcjl2QUdGOVdKK1lMUTY2?=
 =?utf-8?B?R2xpcTl0dytXWVNMV01WdTB0NEdvZTlvSjh3cXFOUnMzQWgxTmZjQmVzelBo?=
 =?utf-8?B?N1o0Q2VPdXZlUUtSU0EzSkhQbFV3THpxOEZnWlJSMFlqdmVhTnZXTmliamxv?=
 =?utf-8?B?bUU4eDBlSitta2FnZys1UE4vQjJCK2MxT2Zyd2RxQVh5WXV1TUxoN3M2RUsv?=
 =?utf-8?B?eWVvbE1za21ZdUhxQXpiOEQyaWNXbWUvb0g4aVdYSytuWjNPdmdJRHdCclZQ?=
 =?utf-8?B?aEZGRFA0TVhHZnk4aEZZQUJKRHF0WDJCNjE1NHVtTy95SkoxRysyLzNORnJ6?=
 =?utf-8?B?S2dkQkNSSG1BVmIrZ2ZWSmhnZ2Qrb3BBRnpwZ2pwbEk4UkFib3pCSUJ2OHBw?=
 =?utf-8?B?bWpDVURhVkIyVHJ0T0Z1azdyTGVyb2pyRHBVWTV6RDhqSXI2b1dJVnRPM3RF?=
 =?utf-8?B?OEdkUEhZV1FyYVBXUEJmb0JkV0xHc3JaN1RhQk8wb1dibFV1SXpPNU9vZER6?=
 =?utf-8?B?bG9oRlU0Q3FmZ2FTWDFoQVU0cll4dXNiK0c3eW8zTm5TUlRLTFJvMnM4Y0Uv?=
 =?utf-8?B?bVV5MitMUVNYZXhtTUZ5a0UvQW0rRDlRV2txRE5nQkgzaGNlUFRyeXVNa0Z2?=
 =?utf-8?B?WTk4OFZuTWhtdkVpZzlxalFnd3I2SjFwbnBBOU1QV1lYb3FyOS9wY3ZYQm9v?=
 =?utf-8?B?RlQ3RDkyYVI5L0xOSmgwNkNVT1FBTE8zUTVKSXZyK2tIUy9rdTUvNElEVDEr?=
 =?utf-8?B?anVyZDNvWHNlZGpmQXZoYkJud25TNmVtOTNSM0MvUkszS2ZsdDZuZFhDZmo0?=
 =?utf-8?B?V1FRcTZEci9uRDU1aUdyMnFvS21HWC9sQXZYNkRVUHpVU01WUU02UHN4UERG?=
 =?utf-8?B?eTdOSmxsZktDS283Y011QXNDa0dtazhhODlvdldSYTNLWE9LZ01xRmVzZ0lC?=
 =?utf-8?B?ZW9TMllvQzg5MzBHc3Q5UHdRT3dmaVYyZTZHVXMxT1FFOHpwQ3B4SldCd0RL?=
 =?utf-8?Q?IU3A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7b6038-1cdc-409e-7873-08de188c500b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:46:45.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMvRoBoqUrEUo16qdnRbEdYbRan0oYbJpQjL+mvRvx9yYLdbg166psMLgk7lM8GhfBiKuws+oOXSVG+g5mvoFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9634

Consolidate simple audio codec (one compatible string, one reg, one
optional reset-gpios and '#sound-dai-cells' 0) to a trivial-codec.yaml.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- update title to Trivial Audio Codecs
- update maintainer to rob
- add reset-gpios
- add charles keepax reviewed-by tag.
- add below
cirrus,cs4349
cirrus,cs4341a
cirrus,cs4265
"adi,ssm2602", "adi,ssm2603", "adi,ssm2604"
ti,pcm1792a
ti,pcm1789 (Add reset-gpios)
ti,pcm5102a
dlg,da9055-codec (already added v1).
---
 .../bindings/sound/adi,max98363.yaml          | 60 --------------
 .../devicetree/bindings/sound/adi,ssm2602.txt | 19 -----
 .../bindings/sound/adi,ssm3515.yaml           | 49 ------------
 .../devicetree/bindings/sound/cs4265.txt      | 29 -------
 .../devicetree/bindings/sound/cs4341.txt      | 22 ------
 .../devicetree/bindings/sound/cs4349.txt      | 19 -----
 .../devicetree/bindings/sound/da9055.txt      | 22 ------
 .../bindings/sound/nuvoton,nau8540.yaml       | 40 ----------
 .../bindings/sound/nuvoton,nau8810.yaml       | 45 -----------
 .../bindings/sound/nxp,tfa9879.yaml           | 44 -----------
 .../bindings/sound/nxp,uda1342.yaml           | 42 ----------
 .../devicetree/bindings/sound/pcm1789.txt     | 22 ------
 .../devicetree/bindings/sound/pcm179x.txt     | 27 -------
 .../devicetree/bindings/sound/pcm5102a.txt    | 13 ---
 .../bindings/sound/trivial-codec.yaml         | 79 +++++++++++++++++++
 .../devicetree/bindings/sound/wlf,wm8510.yaml | 41 ----------
 .../devicetree/bindings/sound/wlf,wm8523.yaml | 40 ----------
 .../devicetree/bindings/sound/wlf,wm8580.yaml | 42 ----------
 .../devicetree/bindings/sound/wlf,wm8711.yaml | 40 ----------
 .../devicetree/bindings/sound/wlf,wm8728.yaml | 40 ----------
 .../devicetree/bindings/sound/wlf,wm8737.yaml | 40 ----------
 .../devicetree/bindings/sound/wlf,wm8750.yaml | 42 ----------
 .../devicetree/bindings/sound/wlf,wm8753.yaml | 62 ---------------
 .../devicetree/bindings/sound/wlf,wm8776.yaml | 41 ----------
 .../devicetree/bindings/sound/wlf,wm8961.yaml | 43 ----------
 .../devicetree/bindings/sound/wlf,wm8974.yaml | 41 ----------
 .../devicetree/bindings/sound/wm8770.txt      | 16 ----
 27 files changed, 79 insertions(+), 941 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2602.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs4265.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/cs4341.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/cs4349.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/da9055.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nxp,uda1342.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/pcm179x.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/pcm5102a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/trivial-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8961.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8770.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
deleted file mode 100644
index c388cda560113..0000000000000
--- a/Documentation/devicetree/bindings/sound/adi,max98363.yaml
+++ /dev/null
@@ -1,60 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/adi,max98363.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Analog Devices MAX98363 SoundWire Amplifier
-
-maintainers:
-  - Ryan Lee <ryans.lee@analog.com>
-
-description:
-  The MAX98363 is a SoundWire input Class D mono amplifier that
-  supports MIPI SoundWire v1.2-compatible digital interface for
-  audio and control data.
-  SoundWire peripheral device ID of MAX98363 is 0x3*019f836300
-  where * is the peripheral device unique ID decoded from pin.
-  It supports up to 10 peripheral devices(0x0 to 0x9).
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: sdw3019f836300
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-  - "#sound-dai-cells"
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    soundwire@3250000 {
-        #address-cells = <2>;
-        #size-cells = <0>;
-        reg = <0x3250000 0x2000>;
-
-        speaker@0,0 {
-            compatible = "sdw3019f836300";
-            reg = <0 0>;
-            #sound-dai-cells = <0>;
-            sound-name-prefix = "Speaker Left";
-        };
-
-        speaker@0,1 {
-            compatible = "sdw3019f836300";
-            reg = <0 1>;
-            #sound-dai-cells = <0>;
-            sound-name-prefix = "Speaker Right";
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
deleted file mode 100644
index 3b3302fe399b9..0000000000000
--- a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Analog Devices SSM2602, SSM2603 and SSM2604 I2S audio CODEC devices
-
-SSM2602 support both I2C and SPI as the configuration interface,
-the selection is made by the MODE strap-in pin.
-SSM2603 and SSM2604 only support I2C as the configuration interface.
-
-Required properties:
-
-  - compatible : One of "adi,ssm2602", "adi,ssm2603" or "adi,ssm2604"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
- Example:
-
-	ssm2602: ssm2602@1a {
-		compatible = "adi,ssm2602";
-		reg = <0x1a>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
deleted file mode 100644
index 144450df58695..0000000000000
--- a/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
+++ /dev/null
@@ -1,49 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/adi,ssm3515.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Analog Devices SSM3515 Audio Amplifier
-
-maintainers:
-  - Martin Povišer <povik+lin@cutebit.org>
-
-description: |
-  SSM3515 is a mono Class-D audio amplifier with digital input.
-
-  https://www.analog.com/media/en/technical-documentation/data-sheets/SSM3515.pdf
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    enum:
-      - adi,ssm3515
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      codec@14 {
-        compatible = "adi,ssm3515";
-        reg = <0x14>;
-        #sound-dai-cells = <0>;
-        sound-name-prefix = "Left Tweeter";
-      };
-    };
diff --git a/Documentation/devicetree/bindings/sound/cs4265.txt b/Documentation/devicetree/bindings/sound/cs4265.txt
deleted file mode 100644
index 380fff8e4e832..0000000000000
--- a/Documentation/devicetree/bindings/sound/cs4265.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-CS4265 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "cirrus,cs4265"
-
-  - reg : the I2C address of the device for I2C. The I2C address depends on
-          the state of the AD0 pin.  If AD0 is high, the i2c address is 0x4f.
-          If it is low, the i2c address is 0x4e.
-
-Optional properties:
-
-  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
-		 deasserted before communication to the codec starts.
-
-Examples:
-
-codec_ad0_high: cs4265@4f { /* AD0 Pin is high */
-	compatible = "cirrus,cs4265";
-	reg = <0x4f>;
-};
-
-
-codec_ad0_low: cs4265@4e { /* AD0 Pin is low */
-	compatible = "cirrus,cs4265";
-	reg = <0x4e>;
-};
diff --git a/Documentation/devicetree/bindings/sound/cs4341.txt b/Documentation/devicetree/bindings/sound/cs4341.txt
deleted file mode 100644
index c1d5c8ad1a36a..0000000000000
--- a/Documentation/devicetree/bindings/sound/cs4341.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Cirrus Logic CS4341 audio DAC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-  - compatible: "cirrus,cs4341a"
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-For required properties on I2C-bus, please consult
-dtschema schemas/i2c/i2c-controller.yaml
-For required properties on SPI-bus, please consult
-Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-	codec: cs4341@0 {
-		#sound-dai-cells = <0>;
-		compatible = "cirrus,cs4341a";
-		reg = <0>;
-		spi-max-frequency = <6000000>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/cs4349.txt b/Documentation/devicetree/bindings/sound/cs4349.txt
deleted file mode 100644
index 54c117b59dba5..0000000000000
--- a/Documentation/devicetree/bindings/sound/cs4349.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-CS4349 audio CODEC
-
-Required properties:
-
-  - compatible : "cirrus,cs4349"
-
-  - reg : the I2C address of the device for I2C
-
-Optional properties:
-
-  - reset-gpios : a GPIO spec for the reset pin.
-
-Example:
-
-codec: cs4349@48 {
-        compatible = "cirrus,cs4349";
-        reg = <0x48>;
-        reset-gpios = <&gpio 54 0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/da9055.txt b/Documentation/devicetree/bindings/sound/da9055.txt
deleted file mode 100644
index 75c6338b6ae28..0000000000000
--- a/Documentation/devicetree/bindings/sound/da9055.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Dialog DA9055 Audio CODEC
-
-DA9055 provides Audio CODEC support (I2C only).
-
-The Audio CODEC device in DA9055 has its own I2C address which is configurable,
-so the device is instantiated separately from the PMIC (MFD) device.
-
-For details on accompanying PMIC I2C device, see the following:
-Documentation/devicetree/bindings/mfd/da9055.txt
-
-Required properties:
-
-  - compatible: "dlg,da9055-codec"
-  - reg: Specifies the I2C slave address
-
-
-Example:
-
-	codec: da9055-codec@1a {
-		compatible = "dlg,da9055-codec";
-		reg = <0x1a>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
deleted file mode 100644
index 7ccfbb8d8b043..0000000000000
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/nuvoton,nau8540.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Nuvoton Technology Corporation NAU85L40 Audio CODEC
-
-maintainers:
-  - John Hsu <KCHSU0@nuvoton.com>
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: nuvoton,nau8540
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1c {
-            compatible = "nuvoton,nau8540";
-            reg = <0x1c>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml
deleted file mode 100644
index d9696f6c75edd..0000000000000
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml
+++ /dev/null
@@ -1,45 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/nuvoton,nau8810.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: NAU8810/NAU8812/NAU8814 audio CODEC
-
-maintainers:
-  - David Lin <CTLIN0@nuvoton.com>
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    enum:
-      - nuvoton,nau8810
-      - nuvoton,nau8812
-      - nuvoton,nau8814
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            #sound-dai-cells = <0>;
-            compatible = "nuvoton,nau8810";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
deleted file mode 100644
index df26248573ad5..0000000000000
--- a/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/nxp,tfa9879.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: NXP TFA9879 class-D audio amplifier
-
-maintainers:
-  - Peter Rosin <peda@axentia.se>
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: nxp,tfa9879
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-  - '#sound-dai-cells'
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c1 {
-       #address-cells = <1>;
-       #size-cells = <0>;
-       amplifier@6c {
-          compatible = "nxp,tfa9879";
-          reg = <0x6c>;
-          pinctrl-names = "default";
-          pinctrl-0 = <&pinctrl_i2c1>;
-          #sound-dai-cells = <0>;
-       };
-    };
diff --git a/Documentation/devicetree/bindings/sound/nxp,uda1342.yaml b/Documentation/devicetree/bindings/sound/nxp,uda1342.yaml
deleted file mode 100644
index 71c6a5a2f5bc0..0000000000000
--- a/Documentation/devicetree/bindings/sound/nxp,uda1342.yaml
+++ /dev/null
@@ -1,42 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/nxp,uda1342.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: NXP uda1342 audio CODECs
-
-maintainers:
-  - Binbin Zhou <zhoubinbin@loongson.cn>
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: nxp,uda1342
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-  - '#sound-dai-cells'
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      codec@1a {
-        compatible = "nxp,uda1342";
-        reg = <0x1a>;
-        #sound-dai-cells = <0>;
-      };
-    };
diff --git a/Documentation/devicetree/bindings/sound/pcm1789.txt b/Documentation/devicetree/bindings/sound/pcm1789.txt
deleted file mode 100644
index 3c74ed220ac25..0000000000000
--- a/Documentation/devicetree/bindings/sound/pcm1789.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Texas Instruments pcm1789 DT bindings
-
-PCM1789 is a simple audio codec that can be connected via
-I2C or SPI. Currently, only I2C bus is supported.
-
-Required properties:
-
- - compatible: "ti,pcm1789"
-
-Required properties on I2C:
-
- - reg: the I2C address
- - reset-gpios: GPIO to control the RESET pin
-
-Examples:
-
-	audio-codec@4c {
-		compatible = "ti,pcm1789";
-		reg = <0x4c>;
-		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
-		#sound-dai-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/pcm179x.txt b/Documentation/devicetree/bindings/sound/pcm179x.txt
deleted file mode 100644
index 436c2b247693f..0000000000000
--- a/Documentation/devicetree/bindings/sound/pcm179x.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Texas Instruments pcm179x DT bindings
-
-This driver supports both the I2C and SPI bus.
-
-Required properties:
-
- - compatible: "ti,pcm1792a"
-
-For required properties on SPI, please consult
-Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Required properties on I2C:
-
- - reg: the I2C address
-
-
-Examples:
-
-	codec_spi: 1792a@0 {
-		compatible = "ti,pcm1792a";
-		spi-max-frequency = <600000>;
-	};
-
-	codec_i2c: 1792a@4c {
-		compatible = "ti,pcm1792a";
-		reg = <0x4c>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/pcm5102a.txt b/Documentation/devicetree/bindings/sound/pcm5102a.txt
deleted file mode 100644
index c63ab0b6ee196..0000000000000
--- a/Documentation/devicetree/bindings/sound/pcm5102a.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-PCM5102a audio CODECs
-
-These devices does not use I2C or SPI.
-
-Required properties:
-
-  - compatible : set as "ti,pcm5102a"
-
-Examples:
-
-	pcm5102a: pcm5102a {
-		compatible = "ti,pcm5102a";
-	};
diff --git a/Documentation/devicetree/bindings/sound/trivial-codec.yaml b/Documentation/devicetree/bindings/sound/trivial-codec.yaml
new file mode 100644
index 0000000000000..9a35dfb17349a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/trivial-codec.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/trivial-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trivial Audio Codec
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      # Analog Devices SSM2602 I2S audio CODEC devices
+      - adi,ssm2602
+      - adi,ssm2603
+      - adi,ssm2604
+      - adi,ssm3515
+      # Cirrus Logic CS4265 audio DAC
+      - cirrus,cs4265
+      - cirrus,cs4341a
+      - cirrus,cs4349
+      - dlg,da9055-codec
+      # Nuvoton Technology Corporation NAU85L40 Audio CODEC
+      - nuvoton,nau8540
+      - nuvoton,nau8810
+      - nuvoton,nau8812
+      - nuvoton,nau8814
+      # NXP TFA9879 class-D audio amplifier
+      - nxp,tfa9879
+      - nxp,uda1342
+      - sdw3019f836300
+      - ti,pcm1789
+      - ti,pcm1792a
+      - ti,pcm5102a
+      - wlf,wm8510
+      - wlf,wm8523
+      - wlf,wm8580
+      - wlf,wm8581
+      - wlf,wm8711
+      - wlf,wm8728
+      - wlf,wm8737
+      - wlf,wm8750
+      - wlf,wm8753
+      - wlf,wm8770
+      - wlf,wm8776
+      - wlf,wm8961
+      - wlf,wm8974
+      - wlf,wm8987
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1a {
+            compatible = "wlf,wm8523";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
deleted file mode 100644
index 6d12b0ac37e28..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
+++ /dev/null
@@ -1,41 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8510.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8510 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8510
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            compatible = "wlf,wm8510";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
deleted file mode 100644
index decc395bb8739..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8523.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8523 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8523
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8523";
-            reg = <0x1a>;
-        };
-    };        
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
deleted file mode 100644
index 2f27852cdc200..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
+++ /dev/null
@@ -1,42 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8580.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8580 and WM8581 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    enum:
-      - wlf,wm8580
-      - wlf,wm8581
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8580";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
deleted file mode 100644
index ecaac2818b446..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8711.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8711 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8711
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8711";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
deleted file mode 100644
index fc89475a051e8..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8728.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8728 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8728
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8728";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
deleted file mode 100644
index 12d8765726d8f..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8737.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8737 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8737
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8737";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8750.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
deleted file mode 100644
index 96859e38315b1..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
+++ /dev/null
@@ -1,42 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8750.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8750 and WM8987 audio CODECs
-
-description: |
-  These devices support both I2C and SPI (configured with pin strapping
-  on the board).
-
-maintainers:
-  - Mark Brown <broonie@kernel.org>
-
-properties:
-  compatible:
-    enum:
-      - wlf,wm8750
-      - wlf,wm8987
-
-  reg:
-    description:
-      The I2C address of the device for I2C, the chip select number for SPI
-    maxItems: 1
-
-additionalProperties: false
-
-required:
-  - reg
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            compatible = "wlf,wm8750";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
deleted file mode 100644
index 9eebe7d7f0b7d..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
+++ /dev/null
@@ -1,62 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8753.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8753 audio CODEC
-
-description: |
-  Pins on the device (for linking into audio routes):
-      * LOUT1
-      * LOUT2
-      * ROUT1
-      * ROUT2
-      * MONO1
-      * MONO2
-      * OUT3
-      * OUT4
-      * LINE1
-      * LINE2
-      * RXP
-      * RXN
-      * ACIN
-      * ACOP
-      * MIC1N
-      * MIC1
-      * MIC2N
-      * MIC2
-      * Mic Bias
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8753
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8753";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
deleted file mode 100644
index 7bbc96ee81be3..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
+++ /dev/null
@@ -1,41 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8776.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8776 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8776
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            compatible = "wlf,wm8776";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8961.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8961.yaml
deleted file mode 100644
index f580785455693..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8961.yaml
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8961.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Wolfson WM8961 Ultra-Low Power Stereo CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8961
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-  - '#sound-dai-cells'
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          wm8961: codec@4a {
-                  compatible = "wlf,wm8961";
-                  reg = <0x4a>;
-                  #sound-dai-cells = <0>;
-          };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
deleted file mode 100644
index d27300207c67e..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
+++ /dev/null
@@ -1,41 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8974.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8974 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8974
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            compatible = "wlf,wm8974";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wm8770.txt b/Documentation/devicetree/bindings/sound/wm8770.txt
deleted file mode 100644
index cac762a1105de..0000000000000
--- a/Documentation/devicetree/bindings/sound/wm8770.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-WM8770 audio CODEC
-
-This device supports SPI.
-
-Required properties:
-
-  - compatible : "wlf,wm8770"
-
-  - reg : the chip select number.
-
-Example:
-
-wm8770: codec@1 {
-	compatible = "wlf,wm8770";
-	reg = <1>;
-};
-- 
2.34.1


