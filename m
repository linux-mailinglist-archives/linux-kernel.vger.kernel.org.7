Return-Path: <linux-kernel+bounces-747671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097BB136B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF901785A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26911D130E;
	Mon, 28 Jul 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PgkDGhPo"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012071.outbound.protection.outlook.com [52.101.126.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B570248F57
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691325; cv=fail; b=leBfmF/NLO+nez1Ujp2chN7A6dNbyvvMYM3aAXkskWETwYKsK25c5FgvF7zTuRhy9hosXZeGoUZshnaEGxOWu9RoJTQOtDnSsoY45r3Lg8Wl2IecldHqCdFEstPAqsBFpIthGP0puM6lM9fJ/yFm9hxsqYDaFlIHsB3Xk3zByV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691325; c=relaxed/simple;
	bh=n7JZHI67wojcSCfF6eM4kq/FBpJTwZrqxd38tDG33UE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dpwGok4Ikfc1wNFJPz5yLtddoVB9Sb5ikhor8724uFZpqT7pBSN8WVlcZS9Fg3vUtQcVq9zrvdi6s2qNex8i2RKsxqHRH6NkIQjqKvGAmEGWXvkiJ+PLvWwl8givDPbzpYN8xUDsRuqWDeLxYAGBcsHL38xUgRjMNJsJGkONVeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PgkDGhPo; arc=fail smtp.client-ip=52.101.126.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5jiTWD+RlySnq8XMfDki5hVofJsiELjqK1BZo7seCxh8vF1lmJGiyBFLb9yalcjfjiZWVaBVYpA6ewHAPTtPGDyDbl58J5UQjehXNpdMCrA9mjAPjskHahX++4vgcQMJYjSb/+pjHm89TePz3E3G02KpZ3qTp2mDGsh8BCeiYioN539sFLKSzdXmJuzUPpTN4FYJtlCrje+Jfc8X/q6mCqDxijiiDg67Oug90P3d3GHpTMBn/6y/rjwCnph+Y6Jq873IvwdbyrXMxv4luwmI/C25E5PbCqufwsRCZEkX1QRCK3Cv19+m+GtlpmHP6kJwrazq1GfJC0HZbPkl6XOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjJjGLktQyvzExc/AO4EH/ZAg+bmjYbzRA/GmIhDKlY=;
 b=ZqSEFYk4hgzQZYpIGi3lQZcylet1/PnvPeXr/60a6sLLsnf+P9i/3kqrfMJw1nbMrFUSQXUv1VjCy5UmitYq9/7WGVMzYL2ruXd34Td4MkQTIqLN5wnWo2N7EqsNEcMxAF/5hC/GsLnouHKOtT7fjGfQldiRhH6LptsLvGhhCSzd60J2+694IiY3rNfff4jUgTFQu8cH+fLTZwyUZ4b9XiQt+NwMADV9RC8l3uxangWi2Udxwg4phxkO3zEqDpnKITlCPBK6SDlKaRGq+s61DtcbyNrIbWlOhwL3tnKkT5JTZz0JdihlsB5SN8ew+JiQ32akLCKcawv9ZAC/JVXjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjJjGLktQyvzExc/AO4EH/ZAg+bmjYbzRA/GmIhDKlY=;
 b=PgkDGhPowbw18e6dwJ0cuCT+uCTEc1vmVXf4xkOpsef01Yoi7YB8Kvvxv3PAGa1yMdlM3rStFonVv3bohZj8XMjJqSFoG6zq5GxyInRfSqvOQMb4sgdMxx27CnzlLXLW+oAL2/cpe5OxNYuyyPLOjwGNxzYbqhwA1ue0ASQZk4DGY8C0dcv7uIkCOOT0IuG/KtPk/QmYLaZGPXj9hyVepuIgsJP0+43wCVXKg7z++wg8rT8Y4iuAqK5a5qVHUq0I7Rp0wEC6Pu1l/69PmHLblFjIcM0SoMt+suuGK8Nu3wvvd3GRoHNq0/brmeXzq2GRk8nxA62cpLb3niI2xRDonw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by TYUPR06MB6151.apcprd06.prod.outlook.com (2603:1096:400:350::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 08:28:35 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 08:28:35 +0000
Message-ID: <b1cf56a6-d23d-40ca-acaa-07944140b1b5@vivo.com>
Date: Mon, 28 Jul 2025 16:28:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O read
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: axboe@kernel.dk, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
 <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
 <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
From: hanqi <hanqi@vivo.com>
In-Reply-To: <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|TYUPR06MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: ef665e53-d9e0-4ef2-cb29-08ddcdb0be4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmY4a0lpb2tJQ3VsdlpzWGp0LzJzb09UbVE0bWM5cFJyUEpURDE4WXNqQlRi?=
 =?utf-8?B?RTAzNU05MjIxZm0rZU9WNTROSkFoOUhLQ3dvcEFYcjdWQ0RFeFBEQnVFc3dv?=
 =?utf-8?B?QzRhMlNIbE4xcjVPVG56aGhpRENSZnVKemt1N0crVDVza3dRRUQ4Y0N6RlhH?=
 =?utf-8?B?Q3VXWS9Ea3gvdFJKL0M0akdZRzV2Um1ES3B5Y3phMlBvbkVNZldWY2hGNERL?=
 =?utf-8?B?dDFrbkNEdHBwUnVqcURRdkgrVGI5S216N3gzTWZKem1NeVNEZnJhOEFEZ01u?=
 =?utf-8?B?bkdnQVlvaVV0SkdrNVJMVG90MnNyczJSRkNKQzBVMEMrQ1liblJOR04wSHdh?=
 =?utf-8?B?TmJFU2lHK1NITk9FU2VWQjVnN3ZSQS9jYS9HL25ZVW1sT2lSd004VHVKSEg1?=
 =?utf-8?B?ZElTUHM3MldCcFV0WnhweXRWM3lOUWh2ZnozQmNqWktIT3QvaFFvb3MyMlpu?=
 =?utf-8?B?eGtNNFRrdXlybnF3b1h0Mm1tVnFRendvL2ltSGtCUStQVkJML0hTb0pmSzBu?=
 =?utf-8?B?Q2R6a1VLd0FHS0VEWDluY0FCRWJQTTNDNFpyOHhvZk5nZWlNd1NKS1pLL0ZX?=
 =?utf-8?B?OGVwVFpqRUdIaGJNVWs1U3pSM3VOaHNqUjAvanUyRzJSYXRZQTl1M05hSG1C?=
 =?utf-8?B?a2pvaHRsVGFjam1UeXVVbzkxQXdyazU4V09ESjNWT1F4eUttS3dudCszZlVu?=
 =?utf-8?B?cGNiVW5ybTlTT05FVFZhZ1NhYkRYajlvY1ladXp3V2oxNlFXSXdCOTgvaTdJ?=
 =?utf-8?B?K0hScGdBYW1xVE9ieFY3VXFHaXQzbXZHOXJ0cVB0WmpnakpTVSt4dC9RZ2hv?=
 =?utf-8?B?ZTRMWlhZTHFhRFJzTHVKWWx6WVhuQ0VBR01HU21BZ29TRnZvdlhraHZoc3dN?=
 =?utf-8?B?Z1VCUWRRbHAwdGlMS3B4UFlFYk83Wmw0aEJ3S0pJUDJOS2x6SHN4aENoY1pB?=
 =?utf-8?B?SHIyNEp0VHRVenROQWlYbkI1ZkJGMEltUmpidEtPOW1jQTJsd0gwNTZtUExQ?=
 =?utf-8?B?blFBWExKVFliMFI2U2d0Z3RyM0NaRCtncEFyMmoxRDJiUFhmalZ6RGQyK1VH?=
 =?utf-8?B?Z0ZlYXNuVDlJcUEwRUpac3N3SVNBcEx4UjJSTzVqZHBacjdiOFpHK0t6Ti9l?=
 =?utf-8?B?bzFjbUFLL3BpUmRLTEl0ZGsrR0FKMzlyc3BYdTljSHJFWjM3S2M4cURmVHg2?=
 =?utf-8?B?NS96bEZxUU96NURic283NU5nZ0gvUXdlUTJVUjVkd1RDZGNvNVlRMGNRQ0Y2?=
 =?utf-8?B?WDVFK1p5RGdHNE5Ub015WGVTUlkwc2hxZitHLy9VRzI0cHNhNTU5dFlJR3g0?=
 =?utf-8?B?bkJVTlB4Y0xOMEhYa21YSGJtaEVZVTA4RjFWRTNKayt1Z3JSYVJjcHFlTmxl?=
 =?utf-8?B?cUR0QXdxZEE0UzNCQ2plc242MDFPL3RNMHBrRG9hNzUrMG9kdDBNdGQ4TEVL?=
 =?utf-8?B?MkEvWDkwYlhaUmUxSm5BU0p4cHlkWlJJS2NuRWJwWU8rcm5vR0ZoVUFDV2VB?=
 =?utf-8?B?UFZaeis1a0xpYVFTOVZPcDF0YVZOOGhhODAyb0hEVHR0c3BLVng0Um1FZkl5?=
 =?utf-8?B?QnVCZ0hjOXdBVXVWRDBZVWxaYnBrTjFJb3hzdTUzM2JDblZRRDhSREFtVDFV?=
 =?utf-8?B?UmdQc3pKcHAxbnFvNWcxc2gyaFdDYlpPVnVGazdSRUpIeGFOS1VRVFR6TER4?=
 =?utf-8?B?R21mdjJTY3BmSWpoemNMSk9QQTBaMkhZRDA3N0xpZVQwQm5NM1RqTllyS1lk?=
 =?utf-8?B?TzNhRTc4c3BtNlljRFd5N3pWNjFMUURzZ1pOTmJIU291VEV0MkZ5di9rSGV1?=
 =?utf-8?Q?Ro9iLdbw2W9TwFxQwfEXC0aSw6mOK8bn1NsJA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alZJc1phZWl2UjZMdHBqaHVzTkNhVGhpR3Vpc2UvNWFiY1E2dGU4ZEtXZFd5?=
 =?utf-8?B?RE8zellKOVIxWkFWeWhxbk4xUVBBSERleFh0OGgxU2tORlNHRTgya1JMbmky?=
 =?utf-8?B?Zm50Mk9sZHBkWUZCSHY3aExkQ2kzOXhmNm9CN1V2anF1MXBySW5Yb3RYNERo?=
 =?utf-8?B?aWpWM0xDQjRLVUFEY0ZxTkY0aStKSE1LUlU2aCtPSWFoajQ1UytrdE54R1VI?=
 =?utf-8?B?QThXdUtIMXA4QUJJVnlDVFU4VGZQc0hLSWxwT0xuUEtjNWxYcHM0bGVvVTZX?=
 =?utf-8?B?L2RFUzY1TVMzNU11K3had0Z0UlRuL1pDRlgvV0QrbTkwL0I2TThmV1Y0MHVK?=
 =?utf-8?B?czVtV0MvOTVKNGdZeGVscWhzWFNoNWg2ZDNnSHRzMW1mcERPLzJoVVVsMTZz?=
 =?utf-8?B?Uk1md0RCVnJzVUVLcHBKKzF3Q1B1OEdBQzlKMTQ2TFpMV3ZIYmtWUmxtMFd5?=
 =?utf-8?B?MEpXNEl6M3Z1eVB3V0J2UERHUGdxSUdmUFd1OElRTUZIdmNPZmR4RGprQ09i?=
 =?utf-8?B?aXhNZ3BRdzY3Uyt6UlRBU1ZRZXFhYW1WVzZCSnFCQU5Oc05ZVXZlQm5USE14?=
 =?utf-8?B?TVJoNzZDRFFPVTQ0d2NoTkFVeU5FcXQxcUtnaENBQ3pKMDhocExhYUtHd2lE?=
 =?utf-8?B?K0NSMjJ6T1RvNElEZzBYQzZLbjJidnFMNTR5V3lMNjNtMHlKbGR3OE9UWFF6?=
 =?utf-8?B?b1NDOHo3SFZQWlhYSjF2cEcvZXlJbDJmQytsc0NpM1h0eXF2WVJMMitjNitw?=
 =?utf-8?B?MEJKbVRDYkl2NVZTc0t1bHI5Z3RpK0dhQXUvdWl3MUZrWkpSNWZ0Z1hLVVpV?=
 =?utf-8?B?NHNjb2ptWjFRZGJkblozdnFhWGVyWVgrYnA2eVc4a3dIaGljOVd2UTlZWmFy?=
 =?utf-8?B?RWNnQXJ6K3Zwa1JlMzFCNHFlNmlkNFR2bW1VZGNoTWh3azFuOE1majVKb0pu?=
 =?utf-8?B?c28yTlltaFh5RURNN0ZDSlhuRUh6YVcwc1hVV2ZDM3hXalQ1MlhPeEZzWnhj?=
 =?utf-8?B?UUlrcEIyOEJxYWp0MldBbjlUQkZmamk2Qi84eVhPTnJZcVZzc1haeFlibEEr?=
 =?utf-8?B?VjRsT2JPK0R5OEY0Q0NUdUtyek1zUFBnTlhmdkRUMG5ITHo5bXFjTUR1dk1p?=
 =?utf-8?B?RHlsWUtrejNabkE0WlhMYXNRc3NTYzkvdlZGRFF1emlybWNhM09KQTJtSlNk?=
 =?utf-8?B?blc3NTZ5MUpGaGljVHRiUjBMcDN6a003bTRuamR3MzZ6NnlYTjFNdEIvTzJV?=
 =?utf-8?B?TWMyNlVBajNRMG5hTWFHTUdFYk45TzRaMXRuNzYwMytyaG0zWGo2V28zK1Rt?=
 =?utf-8?B?cUJxWDZzaWVrcVhoK0RBREtrKzl1dDEraVhaVkxYTURRL0RwMFlhMjhBcy9D?=
 =?utf-8?B?eDh0RThkUlZWeTZxc3I5YS9OOTE0SjZ3QjlXNWR2ZmlrZTQ2cStVUExqSDJa?=
 =?utf-8?B?bU9GMXcya2dUZEJXMTRTUjJSMGRXOVEzMmdSVWU0MDVmbWprUFg4L1hSUDZG?=
 =?utf-8?B?YVhuaXpwSGJQMUpGVXhmdnlrZG51TFNxQjBiVmYxaEhXQkxDWEp2ZjNTZjJ5?=
 =?utf-8?B?YTJUYVFNekc0OW1JeURTVzFuK2N6aXBpSEdnTjArVE96ZHBIRUtDQzZNdHgy?=
 =?utf-8?B?dWdwNGNRN1E5V0s3VTNsVkxmUlI3MzNweW1PYm12OG9xbDB2YXJ0a25oQTEv?=
 =?utf-8?B?MWtUZGs0SnV2dE9UOUxSbWl1SndmcEZUZklUbTNCd3U2UlgxY1pEZFFsUCtG?=
 =?utf-8?B?bExHZVowcWpYaUpIQ3lYQnE4ZDZSSm80bnUxOTFCOHkzZk5RQ0FvazlGZnRG?=
 =?utf-8?B?R0ZVcG9BM3Q0aitjd2tncVRzVXRYTzQyMGFMNExualRTaGs0Y25RZjB3YzRX?=
 =?utf-8?B?TmFCZFNLam1uMVZmYkxDNWFKRUpTdkl3RGoxdGdlMGxsenNyVjdCNFFUck1u?=
 =?utf-8?B?RzVFc002dXJoQnRaUWVIQWFPWE1iaGs0TFVJT21WVHBDVUlwcytRbFVMZkh5?=
 =?utf-8?B?V1B5VWZqSEJ0dklWN2UvQTVVQ0I3WTdyUTNkZVViWEMzZmRnbEJocVQvU1Bx?=
 =?utf-8?B?WTVEOWl1bHgxNERxMHJkZTdLaVBSTkc5NmR0QkszSnVZcjFDNCtSYWFhSkdt?=
 =?utf-8?Q?LmlbWH7ZHi2clcBip+uPhDNFD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef665e53-d9e0-4ef2-cb29-08ddcdb0be4f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:28:35.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKdc/fN8UbLpARM82PnzLrT0SplAeFJzgY82a49U1Pb96jp4oSH2gahK42ToWs5OwP6/+zGmjdmBQmKWOh14DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6151

在 2025/7/28 16:07, Chao Yu 写道:
> On 7/28/25 16:03, hanqi wrote:
>> 在 2025/7/28 15:38, Chao Yu 写道:
>>
>>> On 7/25/25 15:53, Qi Han wrote:
>>>> Jens has already completed the development of uncached buffered I/O
>>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>>> as Jen mentioned in below path, right?
>>>
>>> soft-irq
>>> - folio_end_writeback()
>>>    - filemap_end_dropbehind_write()
>>>     - filemap_end_dropbehind()
>>>      - folio_unmap_invalidate()
>>>       - lock i_lock
>>>
>>> Thanks,
>> That's how I understand it.
> So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
> you can walk around for write path in this patch.
>
> Thanks,

I think the read and write paths can be submitted separately.
Currently, uncached buffered I/O write requires setting the
FGP_DONTCACHE flag when the filesystem allocates a folio. In
f2fs, this is done in the following path:

- write_begin
  - f2fs_write_begin
   - __filemap_get_folio
   
As I understand it, if we don't set the FGP_DONTCACHE flag here, this
issue shouldn't occur.

Thanks

>>>> I have been testing a use case locally, which aligns with Jens' test
>>>> case [2]. In the read scenario, using uncached buffer I/O results in
>>>> more stable read performance and a lower load on the background memory
>>>> reclaim thread (kswapd). So let's enable uncached buffer I/O reads on
>>>> F2FS.
>>>>
>>>> Read test data without using uncached buffer I/O:
>>>> reading bs 32768, uncached 0
>>>>      1s: 1856MB/sec, MB=1856
>>>>      2s: 1907MB/sec, MB=3763
>>>>      3s: 1830MB/sec, MB=5594
>>>>      4s: 1745MB/sec, MB=7333
>>>>      5s: 1829MB/sec, MB=9162
>>>>      6s: 1903MB/sec, MB=11075
>>>>      7s: 1878MB/sec, MB=12942
>>>>      8s: 1763MB/sec, MB=14718
>>>>      9s: 1845MB/sec, MB=16549
>>>>     10s: 1915MB/sec, MB=18481
>>>>     11s: 1831MB/sec, MB=20295
>>>>     12s: 1750MB/sec, MB=22066
>>>>     13s: 1787MB/sec, MB=23832
>>>>     14s: 1913MB/sec, MB=25769
>>>>     15s: 1898MB/sec, MB=27668
>>>>     16s: 1795MB/sec, MB=29436
>>>>     17s: 1812MB/sec, MB=31248
>>>>     18s: 1890MB/sec, MB=33139
>>>>     19s: 1880MB/sec, MB=35020
>>>>     20s: 1754MB/sec, MB=36810
>>>>
>>>> 08:36:26      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
>>>> 08:36:27        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>>>> 08:36:28        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>>>> 08:36:29        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>>>> 08:36:30        0        93    0.00   56.00    0.00    0.00   56.00     7  kswapd0
>>>> 08:36:31        0        93    0.00   73.00    0.00    0.00   73.00     7  kswapd0
>>>> 08:36:32        0        93    0.00   83.00    0.00    0.00   83.00     7  kswapd0
>>>> 08:36:33        0        93    0.00   75.00    0.00    0.00   75.00     7  kswapd0
>>>> 08:36:34        0        93    0.00   81.00    0.00    0.00   81.00     7  kswapd0
>>>> 08:36:35        0        93    0.00   54.00    0.00    1.00   54.00     2  kswapd0
>>>> 08:36:36        0        93    0.00   61.00    0.00    0.00   61.00     0  kswapd0
>>>> 08:36:37        0        93    0.00   68.00    0.00    0.00   68.00     7  kswapd0
>>>> 08:36:38        0        93    0.00   53.00    0.00    0.00   53.00     2  kswapd0
>>>> 08:36:39        0        93    0.00   82.00    0.00    0.00   82.00     7  kswapd0
>>>> 08:36:40        0        93    0.00   77.00    0.00    0.00   77.00     1  kswapd0
>>>> 08:36:41        0        93    0.00   74.00    0.00    1.00   74.00     7  kswapd0
>>>> 08:36:42        0        93    0.00   71.00    0.00    0.00   71.00     7  kswapd0
>>>> 08:36:43        0        93    0.00   78.00    0.00    0.00   78.00     7  kswapd0
>>>> 08:36:44        0        93    0.00   85.00    0.00    0.00   85.00     7  kswapd0
>>>> 08:36:45        0        93    0.00   83.00    0.00    0.00   83.00     7  kswapd0
>>>> 08:36:46        0        93    0.00   70.00    0.00    0.00   70.00     7  kswapd0
>>>> 08:36:47        0        93    0.00   78.00    0.00    1.00   78.00     2  kswapd0
>>>> 08:36:48        0        93    0.00   81.00    0.00    0.00   81.00     3  kswapd0
>>>> 08:36:49        0        93    0.00   54.00    0.00    0.00   54.00     7  kswapd0
>>>> 08:36:50        0        93    0.00   76.00    0.00    0.00   76.00     1  kswapd0
>>>> 08:36:51        0        93    0.00   75.00    0.00    0.00   75.00     0  kswapd0
>>>> 08:36:52        0        93    0.00   73.00    0.00    0.00   73.00     7  kswapd0
>>>> 08:36:53        0        93    0.00   61.00    0.00    1.00   61.00     7  kswapd0
>>>> 08:36:54        0        93    0.00   80.00    0.00    0.00   80.00     7  kswapd0
>>>> 08:36:55        0        93    0.00   64.00    0.00    0.00   64.00     7  kswapd0
>>>> 08:36:56        0        93    0.00   56.00    0.00    0.00   56.00     7  kswapd0
>>>> 08:36:57        0        93    0.00   26.00    0.00    0.00   26.00     2  kswapd0
>>>> 08:36:58        0        93    0.00   24.00    0.00    1.00   24.00     3  kswapd0
>>>> 08:36:59        0        93    0.00   22.00    0.00    1.00   22.00     3  kswapd0
>>>> 08:37:00        0        93    0.00   15.84    0.00    0.00   15.84     3  kswapd0
>>>> 08:37:01        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>> 08:37:02        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>>
>>>> Read test data after using uncached buffer I/O:
>>>> reading bs 32768, uncached 1
>>>>      1s: 1863MB/sec, MB=1863
>>>>      2s: 1903MB/sec, MB=3766
>>>>      3s: 1860MB/sec, MB=5627
>>>>      4s: 1864MB/sec, MB=7491
>>>>      5s: 1860MB/sec, MB=9352
>>>>      6s: 1854MB/sec, MB=11206
>>>>      7s: 1874MB/sec, MB=13081
>>>>      8s: 1874MB/sec, MB=14943
>>>>      9s: 1840MB/sec, MB=16798
>>>>     10s: 1849MB/sec, MB=18647
>>>>     11s: 1863MB/sec, MB=20511
>>>>     12s: 1798MB/sec, MB=22310
>>>>     13s: 1897MB/sec, MB=24207
>>>>     14s: 1817MB/sec, MB=26025
>>>>     15s: 1893MB/sec, MB=27918
>>>>     16s: 1917MB/sec, MB=29836
>>>>     17s: 1863MB/sec, MB=31699
>>>>     18s: 1904MB/sec, MB=33604
>>>>     19s: 1894MB/sec, MB=35499
>>>>     20s: 1907MB/sec, MB=37407
>>>>
>>>> 08:38:00      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
>>>> 08:38:01        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>>> 08:38:02        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>>> 08:38:03        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>>> 08:38:04        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>>> 08:38:05        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>>> 08:38:06        0        93    0.00    1.00    0.00    1.00    1.00     0  kswapd0
>>>> 08:38:07        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:08        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:09        0        93    0.00    1.00    0.00    0.00    1.00     1  kswapd0
>>>> 08:38:10        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>>> 08:38:11        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>>> 08:38:12        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>>> 08:38:13        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>>> 08:38:14        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>>>> 08:38:15        0        93    0.00    3.00    0.00    0.00    3.00     0  kswapd0
>>>> 08:38:16        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:17        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:18        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:19        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:20        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:21        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:22        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>>>> 08:38:23        0        93    0.00    3.00    0.00    0.00    3.00     4  kswapd0
>>>> 08:38:24        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>>> 08:38:25        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>>>> 08:38:26        0        93    0.00    4.00    0.00    0.00    4.00     3  kswapd0
>>>> 08:38:27        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>> 08:38:28        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>> 08:38:29        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>> 08:38:30        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>> 08:38:31        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>> 08:38:32        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>> 08:38:33        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/20241220154831.1086649-10-axboe@kernel.dk/T/#m58520a94b46f543d82db3711453dfc7bb594b2b0
>>>>
>>>> [2]
>>>> https://pastebin.com/u8eCBzB5
>>>>
>>>> Signed-off-by: Qi Han <hanqi@vivo.com>
>>>> ---
>>>>    fs/f2fs/file.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index 696131e655ed..d8da1fc2febf 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -5425,5 +5425,5 @@ const struct file_operations f2fs_file_operations = {
>>>>        .splice_read    = f2fs_file_splice_read,
>>>>        .splice_write    = iter_file_splice_write,
>>>>        .fadvise    = f2fs_file_fadvise,
>>>> -    .fop_flags    = FOP_BUFFER_RASYNC,
>>>> +    .fop_flags    = FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>>>>    };


