Return-Path: <linux-kernel+bounces-789878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0694B39C07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEBA1899241
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069830F539;
	Thu, 28 Aug 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="SvNNPx4f"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2093.outbound.protection.outlook.com [40.107.22.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AF208994;
	Thu, 28 Aug 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381956; cv=fail; b=swIjXlu3GmuTFtBuxe0tK9/FPrk5Qlb9HCsA9oukF6CWNCh80AdfKXCuaf56a7t91JM/qvi51S8bTkiFaoW+f/60XKIoA/nxsYoXBucX29a1SQx6bCeYS97zEcTYCP3+AfzOtF6t6YkszP9H07l/zxayKvYZDNpILi14AIVdLCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381956; c=relaxed/simple;
	bh=xabr0g7EeQV06pmYGUdjdBcOGPqqgUbOjXxTAnDYIFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SGuTREbDvslS3a2lCO15TZpGdlpZ9rhgqN+R8zqOHqvHsefhlMr3fhsvTL1jtaI4ExsuN+tGMSnEntUrJ/QfaVwExVjFa5QPIana7EW6g2LCZGtknGMcuzm3JQIPKmWfm+1foANyQjO2SjuR+ZyOkj5LWSFeq2B+F52VQyYvn8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=SvNNPx4f; arc=fail smtp.client-ip=40.107.22.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJeocdkLHKVGRtovpXnF2XO+ceOW20yF4gflFrHGQmBZB3DoSAJ5nI5StawCTVk6KSAJz8qH7Qz1kTiEpYvVSO8lt8TTRRyGqV8CpSFCteElw3MD/pBPn5ihty+dEi198elll5UqZKIYrMe4vtkZ/e39Bx1mxKk9iQFFn2De4+bd0p8nfHya6zsw++HW9UtYXi+F6S7WSENInyLZf7VjPrhE1ZwPntiBliuLIoL5zIWoDpbgIH/Z2lYn5FtV9dupXsijl1ByVuHTtTg/A4uvLSEDlWlOzYxM915V36eA4PrMPe0VQimV8Chs4enCT2ZU/BNoj9OLrSfUWHcGUZtwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5Kkfl1tLIVtDqEsyre3ziNzDaf4sM8W7yUS0uIjwZY=;
 b=xjKPZSoxNpONipREUn2DhAZCuADlF0EbuS8+IxtbqWRnEIq0qzzY64whowlHEtk08yklMOYgpXrt3jNS4ejxj+F88F8Wa/YLBzI0Mb+7xJ3s4XsKSoutaQdnJcveE5Q3pMqT2qa5AIsweIXKvPRfXM2jnTSLxCLAhlg+WtocWVLlkWEBab6GmCc3K3GXqAVfkt44zzMg0lGqMOABcHHou+xIK3AZx3iO4fYApd20F6NT36Fvw6e1uOna34ZL9nWkGykn1swQreb+lk/xjfnysfAJgkNYo83/tW3iLLVeSaX2oOCvk/el7llNNtwu7iPACZLpbXICX9IwJMynTrjNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5Kkfl1tLIVtDqEsyre3ziNzDaf4sM8W7yUS0uIjwZY=;
 b=SvNNPx4fWp6x+72QTv96uqr0zIzXGtHEZfNnG8LYQgjzmW2Ef6zhvrKj6Ym8lcW325z+taRpZ9za3jqbr9yrzXxOmmyrhjfb6DGOjAPu881RMRdK8xg6DGksOS/VfcFKjqJWXpz/MDm0T8xVWOfb0ccsvuVc9YbD9gfPO9J3ZpalwhhFqfSPIeXi93572mqZcdz1E5a33jMvglpX73BW9Tpazo16MHLqZbfX0v1VBEU12vi/YbtKU3/fYT1buuCVec67Xddfn6zNRvDKR02JMQBn1X0pKSaJexRrMXBsAfw6knNtor79G62Fq8axH4+MlGyXmB+ILwgwY3vyDiS/bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1682.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 11:52:29 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 11:52:29 +0000
Message-ID: <5a47c816-c39d-4dff-9028-2937ed7f9c9a@phytec.de>
Date: Thu, 28 Aug 2025 14:52:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/33] arm64: dts: ti: k3-am64-ti-ipc-firmware:
 Refactor IPC cfg into new dtsi
To: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250823160901.2177841-1-b-padhi@ti.com>
 <20250823160901.2177841-33-b-padhi@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250823160901.2177841-33-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0234.eurprd07.prod.outlook.com
 (2603:10a6:802:58::37) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1682:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbb626e-2ccc-4be0-058c-08dde6295d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWUyNGxwaHRGUDBMVU1SdTErbTJ4Z1IxVGVSVnlZd2J0VVVDK045eDVKa1NC?=
 =?utf-8?B?N2RKazhWYStNU293WTZ5cCtOS1pnWkxhSWY5elY0SDAzZVpScGtnUTVNandF?=
 =?utf-8?B?d3UybWJtcDNtMHV4WUJ1ZDFJK0pVUXR5enVGNDhpTEFWSW16QTVaaHhja0RG?=
 =?utf-8?B?L0wzMGpHcThBb1Q4a2o0VS9YeXpKRkFrOC9RZVdlSGxBdThlR1RUSEJPS3B3?=
 =?utf-8?B?aFNld3ZWbGNBMVFmcWk4a2lxTWpGcnNyNWErbnZCbTRjMU9CSHFaRzBFRklt?=
 =?utf-8?B?enZRSytDN3N0Vys5aTdHTEV5TjZ6Q2xvVGtwN2FPakpmT0ZNaExIVkxKNnM0?=
 =?utf-8?B?VTVVTDMvY0ZuWnFRVEh2QkJ4dDlUS1dPZWYxSG5CZjVoUWE5ZENmTFI3NUs4?=
 =?utf-8?B?dTJvZ2VCMFVWSE04MWpIZ2EwRHlNWVlwcUhya1BKMDYrTjg2elEyRE5qOGxu?=
 =?utf-8?B?OHVOS25xRVB0WWtaMTRWNldJS2FOZjlhYVNWNVdDMlIxMGZvTVRpOVlVam5I?=
 =?utf-8?B?dUJud2pIaHd5cjBvTzZINDJpeDZmaWI1RE9VRHJsOVNTSlNENkhWYTgxTy9C?=
 =?utf-8?B?dy8ycFVadHlHZGl3WUx4OWVYNk9OZlNIYnZJTERPRUhwK2QrcHdSRzYvSENU?=
 =?utf-8?B?M2NWL05VMFZ0bjBTZ01OVG04WHlkWTAxcVRyNjNtZGRPdHQ2Snd5bm9qcllS?=
 =?utf-8?B?VHlLSVBuSFZ4Mnl2TzdYc3NQd0h6QzJidTVqOWg1QTVKdUR4dTQ0QTR3bkla?=
 =?utf-8?B?M25NdEgwSFJkS1BwVks1OE4rdW1qNU52cy9KZzQ4czBCTUc3akU1c0pBTE5v?=
 =?utf-8?B?M3VBTFVza1BlNkxNcW95bnU5TytOZjErcVluS1lPVnlEU2wzQUFvVG5DTTdl?=
 =?utf-8?B?VDY4b0l0S2hkRG0wVUxENGRYVjFFNDhoVVRGYTF6bmJVU25QQW90Skg3WXJ4?=
 =?utf-8?B?bXJIOFBreUJvVWxzdEpPSHFvMisyMkp4L1YrbVRBQXpkclNtdmdOWEw3LzFH?=
 =?utf-8?B?R2s2VDlrWUphbzZvSUgzWG9uVjVuT21qV0FDODYrdFVxTEx5Q1NMVXYreklC?=
 =?utf-8?B?eXlTaU85emUwMk9Ib0pVVGlJVXhwT1VnSENsdDVrSW5ram9zVmc4T2U2cXNZ?=
 =?utf-8?B?MXdPdlhZOWdIcktwbW1kdE9ER3Q5MTJ6V3hMZmJoQ213aTRkYldFNXdQOU1t?=
 =?utf-8?B?c3hpVTVOaDZ0ZFBMY3JaWFZ3TXBFcGNWdUJMRjlPMjR0cm9QZ3ZGWHB3ZzUx?=
 =?utf-8?B?UXk5aG9Ddk4zQ3F2QjRzOGFCVzhsYUtqeExBMWt5U2xEWUtacy9VNXR5Qkpy?=
 =?utf-8?B?SzhDSU50dGF4Z1lHOFF3NFloOHRlNGsxTFIwTUVLbWVVOXZROFZ3aDNRd0kz?=
 =?utf-8?B?cmNoNW1oNExwVEhFaUtoemJjeDFTZGNWY3l4MVcydmtVbmVBV2lteTdQaTdK?=
 =?utf-8?B?VEhKZzdqYUYrR0VJVEsydVRWNW1CMmVkN0xiTFIyMDlMWWpvNHlnanpFbFor?=
 =?utf-8?B?cDdZbHRCcHkrSk1wY281bFYxQWV0Qksyc3dqTXNhdTU4WU9uRGFrc0ZqUGkr?=
 =?utf-8?B?WG4zUXZHdTk0YXNyNlU3OXY2WGZnZldRbCtrVVFzanlWNjh1bGJHM1FvVDB4?=
 =?utf-8?B?N3R6U2ZuMndtYnJWakEvUnJBVXFKbFNlc2UwNUxudEtheHRBSitnZzZYbXFB?=
 =?utf-8?B?OUF0bmFjdS8yNXBDWFZXVzFJUzFkVFdUakMxVjNpWmhQaHE1MnRrdFk5TGpQ?=
 =?utf-8?B?eENqRkN3Q0xwVVVxdjJzUmMrL0lzVWxydmttR01peUcxSHM2dEhxNHVpc0hn?=
 =?utf-8?B?Sk80V2VqSEJqTFJPOVl5cWZBdHBINkkzMU1DZFlhbkdFQnRNczVkcldGdFpz?=
 =?utf-8?B?MEYrVTB6RkRKa0prRks1ME8wd1REVnlrOU0vM0t5ZWdncnlmYVozRFdDWURM?=
 =?utf-8?Q?fIkp7DmuqC0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGR4dVVnWDNYZVBiSmxRUFhab21NdC90UUdTbUVaaXROUjBNZ0QyY1lnZDZh?=
 =?utf-8?B?cktuQzZuTXdyMmdqSVV4TjBNcXRBV3NTQ2llR1RsMVdUZGwzM09qTWU5Y2hH?=
 =?utf-8?B?eUJPczFlYVUzamRic2xPd25Lb205TzlUUmdZbXEyY2RFSHYyY3krQXpSOE9W?=
 =?utf-8?B?eEFvUTY3T2RYb2hESmlQU21QbTJyZDd2dXoweTljK1JsVldjS1ZPd2F3RmZi?=
 =?utf-8?B?SUZPdVdmRTY2S0VQcjdnRUNsc0RnNkJHSDBzdjBrYnFvQklQQnZXRkdEZS8w?=
 =?utf-8?B?NE85YTBTOVUvYStpQU5VUWVETy9TY0VWOUhSOStNK3FmcVlYNkRVblBQOGxs?=
 =?utf-8?B?RVEwSzF2ME4vamZ0amxSWXdrTk9pSy9ZY1Jzb2lLbGVudStaaHlzWTBybkRm?=
 =?utf-8?B?UitTVEhEYkZTQ3lkTkFGb2RnU2tIT2srQjBwMFJ6N1V2ancremZiZkh1U1BO?=
 =?utf-8?B?NFNJQmR5RTd3QzhOeSszSHdIc09yK21pdzRmUkUyY0FKQzF2SHNua1NhYy9s?=
 =?utf-8?B?andmNnFzU3F5akhOUUlhcEMvTkZucjg5MEZHNHQ2L1JWS0x2K3B1TzlGTTJQ?=
 =?utf-8?B?UjNDUXdjRmNBVXN1b2IyN2xESXdKbTNDNTVqeHFjanZHbmh5Yk1sczVjU0xR?=
 =?utf-8?B?djNYeUdwWWg2NzhYTFlDVXJUTTBSN3NBdXpwQjFNS3BCWHd1V09FYkthais5?=
 =?utf-8?B?VWNXdzdUR2UvTldCYnYvaXc0czcrMUFxY2JSekVTc3l3Wkx0YkJadFJkK1lN?=
 =?utf-8?B?OExQdnVyOHQ5VU1UU1M1SkI4WVRndDJWNHc3VEJjNzErdXNPZGZpaVZKOTNH?=
 =?utf-8?B?dHJWdWRFNVRFY25za0p0dnBRMDV6aFlDMFdvS2lJVWFSTm5sc2d5SmFsNlF6?=
 =?utf-8?B?NWUyamVhaUZsSnM4QytBdUY2TWszTkdpSENKaCt0NHJ1Y1FVKzFPYVZ5cEJp?=
 =?utf-8?B?dS9FWm5Kb0FxQk1GY1lRK1Y2eDFSVE9nUUlSd2R6WndpNHFpeFdDYzAzaE15?=
 =?utf-8?B?bTd2cmxOOG91Uy9jU2V2NTlHa0xKeVROUVk0NnphTXI3ZWtleFlZWFc4VlVJ?=
 =?utf-8?B?VVk0QkNFY2dBWXZQUFg4dENZSllWZldQcDlBanpON1o5RUpYTWpKZkFSY25l?=
 =?utf-8?B?ZVdHekpEbnVydERGaTAxWnNMWWJNRGJhdUxQNVg1eHVHTEwxeGk2S004clk3?=
 =?utf-8?B?d1pHblpHMUROWk1XcFFZVm9aSVdqUjhiVjdnRGFFLzBQcndOYURIWjczMEtl?=
 =?utf-8?B?UEE3NzdLaG5XQytEQVhqa3FpelJYWFpZMzFad0hXTld5cVU4RkQ1WWJKOVdS?=
 =?utf-8?B?aEt4SFVSTTdFUXZNdVFWQW5wREFNdXR3T21ZNUpsd3NJeTh4UFhLR3VyTWVR?=
 =?utf-8?B?UzJOWGo0SW1IZlB0emxPUjdiYTdJLyttZWpUaUxwYkJCZnV3clNxVU5MeTY4?=
 =?utf-8?B?WHg4enVQWFRVWmRnWWJNLzliUk9mNnlRTUpvU2U2RldsYllBaWNiWHljM0c1?=
 =?utf-8?B?bEhnMVBPZ0FQaGhUdFVFNmQ3WHV5YmovV0lUWlB5ajc3UmlQNWFJR0xaTzVy?=
 =?utf-8?B?UUxBeGRqcTUzQnRXV244Sm5TNUhEQk5aSE9PNVo0ZzRudmtFRC9Oc1h2Z3pK?=
 =?utf-8?B?UVVvQzdjaUIvYkIwS04yNlozMHdacXlvMGFaOWdzT0xyU3g1ZEc4YjYrS0VI?=
 =?utf-8?B?cy9Ha243YXd4U3F2RWIwZUlONi9lVTlnTXFucnc1RnV4VlV3TmkrVnVWUE5s?=
 =?utf-8?B?dVFqaVhraHE2ZFFDdEp3MGFHWUQ1dkk5WnozbWlTb3loTGZtemJvVVI4eUQv?=
 =?utf-8?B?NDQ5aXZNanVIQUt2cHpNMytST3JpRmNYczV3ZHAyem1kQS9hZFQ1N2VaZWVn?=
 =?utf-8?B?Y2dQdHo3NHVvczV1dTZ6Z0ZKMVJBeERRMmVMVENUWWpYdlN5UHBUaS9Xblkv?=
 =?utf-8?B?SHJsRGFud1RaSnNMNTBCay9xdzFVQmN0VlliRUh5T3FCMkpxNGltTDlMSFB5?=
 =?utf-8?B?TFA1SWJRUHBrdzJaRGNHMy9RTmR1UEJkVFlHWG1rV3BjYnlkSUtVaUdjdkhy?=
 =?utf-8?B?ZnFhdElWQmlHVlBhTUJiNkxmRUJRbmlyRWhyWG5kRjhGZWlwV0wxUXRvN1dZ?=
 =?utf-8?Q?9BHhAItKJgiBslx9mouUOoKeJ?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbb626e-2ccc-4be0-058c-08dde6295d90
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:52:29.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRVO7xJQJ+ePskSw/t+qms+lHiBP4vmv3BiSWOPkFCZAulHQV+6YMdgLMUBjGL9zzvA7gCD6PxWFmHkiFRq6IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1682



On 8/23/25 7:09 PM, Beleswar Padhi wrote:
> The TI K3 AM64 SoCs have multiple programmable remote processors like
> R5F, M4F etc. The TI SDKs for AM64 SoCs offer sample firmwares which
> could be run on these cores to demonstrate an "echo" IPC test. Those
> firmware require certain memory carveouts to be reserved from system
> memory, timers to be reserved, and certain mailbox configurations for
> interrupt based messaging. These configurations could be different for a
> different firmware.
> 
> While DT is not meant for system configurations, at least refactor these
> configurations from board level DTS into a dtsi for now. This dtsi for
> TI IPC firmware is board-independent and can be applied to all boards
> from the same SoC Family. This gets rid of code duplication and allows
> more freedom for users developing custom firmware (or no firmware) to
> utilize system resources better; easily by swapping out this dtsi. To
> maintain backward compatibility, the dtsi is included in all boards.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am64x
Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am64x

> ---
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 30/33] to [PATCH v2 32/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-31-b-padhi@ti.com/
> 
>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 160 +----------------
>   .../boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi  | 162 ++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 156 +----------------
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 156 +----------------
>   arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi   | 156 +----------------
>   .../arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 156 +----------------
>   6 files changed, 172 insertions(+), 774 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 1efd547b2ba6..af0fed6124e2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -52,60 +52,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
>   			reg = <0x00 0xa0100000 0x00 0xf00000>;
>   			no-map;
>   		};
> -
> -		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_memory_region: m4f-memory@a4100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		rtos_ipc_memory_region: ipc-memories@a5000000 {
> -			reg = <0x00 0xa5000000 0x00 0x00800000>;
> -			alignment = <0x1000>;
> -			no-map;
> -		};
>   	};
>   
>   	leds {
> @@ -238,67 +184,6 @@ &cpsw_port1 {
>   	status = "okay";
>   };
>   
> -&mailbox0_cluster2 {
> -	status = "okay";
> -
> -	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster4 {
> -	status = "okay";
> -
> -	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster6 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -};
> -
> -/* main_timer8 is used by r5f0-0 */
> -&main_timer8 {
> -	status = "reserved";
> -};
> -
> -/* main_timer9 is used by r5f0-1 */
> -&main_timer9 {
> -	status = "reserved";
> -};
> -
> -/* main_timer10 is used by r5f1-0 */
> -&main_timer10 {
> -	status = "reserved";
> -};
> -
> -/* main_timer11 is used by r5f1-1 */
> -&main_timer11 {
> -	status = "reserved";
> -};
> -
> -&main_r5fss0 {
> -	status = "okay";
> -};
> -
>   &main_i2c0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_i2c0_pins_default>;
> @@ -373,49 +258,6 @@ &main_pktdma {
>   	bootph-all;
>   };
>   
> -&main_r5fss0 {
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> -	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> -			<&main_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core1 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> -	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> -			<&main_r5fss0_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1 {
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core0 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> -	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> -			<&main_r5fss1_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core1 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> -	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> -			<&main_r5fss1_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
>   &ospi0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&ospi0_pins_default>;
> @@ -451,3 +293,5 @@ adc {
>   		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>   	};
>   };
> +
> +#include "k3-am64-ti-ipc-firmware.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
> new file mode 100644
> index 000000000000..847495f76831
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * Device Tree Source for enabling IPC using TI SDK firmware on AM64 SoCs
> + *
> + * Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&reserved_memory {
> +	main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0xa1000000 0x00 0x100000>;
> +		no-map;
> +	};
> +
> +	main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0xa1100000 0x00 0xf00000>;
> +		no-map;
> +	};
> +
> +	main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0xa2000000 0x00 0x100000>;
> +		no-map;
> +	};
> +
> +	main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0xa2100000 0x00 0xf00000>;
> +		no-map;
> +	};
> +
> +	main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0xa3000000 0x00 0x100000>;
> +		no-map;
> +	};
> +
> +	main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0xa3100000 0x00 0xf00000>;
> +		no-map;
> +	};
> +
> +	mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0xa4000000 0x00 0x100000>;
> +		no-map;
> +	};
> +
> +	mcu_m4fss_memory_region: m4f-memory@a4100000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0xa4100000 0x00 0xf00000>;
> +		no-map;
> +	};
> +
> +	rtos_ipc_memory_region: ipc-memories@a5000000 {
> +		reg = <0x00 0xa5000000 0x00 0x00800000>;
> +		alignment = <0x1000>;
> +		no-map;
> +	};
> +};
> +
> +&mailbox0_cluster2 {
> +	status = "okay";
> +
> +	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +
> +	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> +		ti,mbox-rx = <2 0 2>;
> +		ti,mbox-tx = <3 0 2>;
> +	};
> +};
> +
> +&mailbox0_cluster4 {
> +	status = "okay";
> +
> +	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +
> +	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> +		ti,mbox-rx = <2 0 2>;
> +		ti,mbox-tx = <3 0 2>;
> +	};
> +};
> +
> +&mailbox0_cluster6 {
> +	status = "okay";
> +
> +	mbox_m4_0: mbox-m4-0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +};
> +
> +/* main_timer8 is used by r5f0-0 */
> +&main_timer8 {
> +	status = "reserved";
> +};
> +
> +/* main_timer9 is used by r5f0-1 */
> +&main_timer9 {
> +	status = "reserved";
> +};
> +
> +/* main_timer10 is used by r5f1-0 */
> +&main_timer10 {
> +	status = "reserved";
> +};
> +
> +/* main_timer11 is used by r5f1-1 */
> +&main_timer11 {
> +	status = "reserved";
> +};
> +
> +&main_r5fss0 {
> +	status = "okay";
> +};
> +
> +&main_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> +	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> +			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
> +};
> +
> +&main_r5fss0_core1 {
> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> +	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> +			<&main_r5fss0_core1_memory_region>;
> +	status = "okay";
> +};
> +
> +&main_r5fss1 {
> +	status = "okay";
> +};
> +
> +&main_r5fss1_core0 {
> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> +	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> +			<&main_r5fss1_core0_memory_region>;
> +	status = "okay";
> +};
> +
> +&main_r5fss1_core1 {
> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> +	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> +			<&main_r5fss1_core1_memory_region>;
> +	status = "okay";
> +};
> +
> +&mcu_m4fss {
> +	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
> +	memory-region = <&mcu_m4fss_dma_memory_region>,
> +			<&mcu_m4fss_memory_region>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 7640c5efe9b8..05b7cdd25a8c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -64,60 +64,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
>   			reg = <0x00 0xa0100000 0x00 0xf00000>;
>   			no-map;
>   		};
> -
> -		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_memory_region: m4f-memory@a4100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		rtos_ipc_memory_region: ipc-memories@a5000000 {
> -			reg = <0x00 0xa5000000 0x00 0x00800000>;
> -			alignment = <0x1000>;
> -			no-map;
> -		};
>   	};
>   
>   	evm_12v0: regulator-0 {
> @@ -727,106 +673,6 @@ partition@3fc0000 {
>   	};
>   };
>   
> -&mailbox0_cluster2 {
> -	status = "okay";
> -
> -	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster4 {
> -	status = "okay";
> -
> -	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster6 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -};
> -
> -&main_r5fss0 {
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> -	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> -			<&main_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core1 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> -	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> -			<&main_r5fss0_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1 {
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core0 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> -	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> -			<&main_r5fss1_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core1 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> -	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> -			<&main_r5fss1_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
> -/* main_timer8 is used by r5f0-0 */
> -&main_timer8 {
> -	status = "reserved";
> -};
> -
> -/* main_timer9 is used by r5f0-1 */
> -&main_timer9 {
> -	status = "reserved";
> -};
> -
> -/* main_timer10 is used by r5f1-0 */
> -&main_timer10 {
> -	status = "reserved";
> -};
> -
> -/* main_timer11 is used by r5f1-1 */
> -&main_timer11 {
> -	status = "reserved";
> -};
> -
>   &serdes_ln_ctrl {
>   	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
>   };
> @@ -890,3 +736,5 @@ &icssg1_iep0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&icssg1_iep0_pins_default>;
>   };
> +
> +#include "k3-am64-ti-ipc-firmware.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index fb8bd66f2f94..cc1569a6519b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -62,60 +62,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
>   			reg = <0x00 0xa0100000 0x00 0xf00000>;
>   			no-map;
>   		};
> -
> -		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_memory_region: m4f-memory@a4100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		rtos_ipc_memory_region: ipc-memories@a5000000 {
> -			reg = <0x00 0xa5000000 0x00 0x00800000>;
> -			alignment = <0x1000>;
> -			no-map;
> -		};
>   	};
>   
>   	vusb_main: regulator-0 {
> @@ -642,106 +588,6 @@ partition@3fc0000 {
>   	};
>   };
>   
> -&mailbox0_cluster2 {
> -	status = "okay";
> -
> -	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster4 {
> -	status = "okay";
> -
> -	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster6 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -};
> -
> -&main_r5fss0 {
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> -	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> -			<&main_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core1 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> -	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> -			<&main_r5fss0_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1 {
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core0 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> -	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> -			<&main_r5fss1_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core1 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> -	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> -			<&main_r5fss1_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
> -/* main_timer8 is used by r5f0-0 */
> -&main_timer8 {
> -	status = "reserved";
> -};
> -
> -/* main_timer9 is used by r5f0-1 */
> -&main_timer9 {
> -	status = "reserved";
> -};
> -
> -/* main_timer10 is used by r5f1-0 */
> -&main_timer10 {
> -	status = "reserved";
> -};
> -
> -/* main_timer11 is used by r5f1-1 */
> -&main_timer11 {
> -	status = "reserved";
> -};
> -
>   &ecap0 {
>   	status = "okay";
>   	/* PWM is available on Pin 1 of header J3 */
> @@ -755,3 +601,5 @@ &eqep0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_eqep0_pins_default>;
>   };
> +
> +#include "k3-am64-ti-ipc-firmware.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> index 8cb61f831734..ce23362b88c3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> @@ -126,60 +126,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
>   			reg = <0x00 0xa0100000 0x00 0xf00000>;
>   			no-map;
>   		};
> -
> -		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_memory_region: m4f-memory@a4100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		rtos_ipc_memory_region: ipc-memories@a5000000 {
> -			reg = <0x00 0xa5000000 0x00 0x00800000>;
> -			alignment = <0x1000>;
> -			no-map;
> -		};
>   	};
>   
>   	vdd_mmc0: regulator-vdd-mmc0 {
> @@ -281,63 +227,6 @@ ethernet_phy2: ethernet-phy@f {
>   	};
>   };
>   
> -&mailbox0_cluster2 {
> -	status = "okay";
> -
> -	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster4 {
> -	status = "okay";
> -
> -	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster6 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -};
> -
> -/* main_timer8 is used by r5f0-0 */
> -&main_timer8 {
> -	status = "reserved";
> -};
> -
> -/* main_timer9 is used by r5f0-1 */
> -&main_timer9 {
> -	status = "reserved";
> -};
> -
> -/* main_timer10 is used by r5f1-0 */
> -&main_timer10 {
> -	status = "reserved";
> -};
> -
> -/* main_timer11 is used by r5f1-1 */
> -&main_timer11 {
> -	status = "reserved";
> -};
> -
>   &main_i2c0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_i2c0_default_pins>;
> @@ -535,49 +424,6 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* USB0_DRVVBUS.USB0_DRVVBUS */
>   	};
>   };
>   
> -&main_r5fss0 {
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> -	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> -			<&main_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core1 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> -	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> -			<&main_r5fss0_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1 {
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core0 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> -	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> -			<&main_r5fss1_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core1 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> -	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> -			<&main_r5fss1_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
>   /* SoC default UART console */
>   &main_uart0 {
>   	pinctrl-names = "default";
> @@ -656,3 +502,5 @@ &usbss0 {
>   	ti,vbus-divider;
>   	ti,usb2-only;
>   };
> +
> +#include "k3-am64-ti-ipc-firmware.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
> index 860b79aa5ef5..e752fc8b0a88 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
> @@ -42,60 +42,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
>   			reg = <0x00 0xa0100000 0x00 0xf00000>;
>   			no-map;
>   		};
> -
> -		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa1100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa2100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa3100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4000000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_memory_region: m4f-memory@a4100000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0xa4100000 0x00 0xf00000>;
> -			no-map;
> -		};
> -
> -		rtos_ipc_memory_region: ipc-memories@a5000000 {
> -			reg = <0x00 0xa5000000 0x00 0x00800000>;
> -			alignment = <0x1000>;
> -			no-map;
> -		};
>   	};
>   
>   	reg_1v8: regulator-1v8 {
> @@ -142,106 +88,6 @@ eeprom1: eeprom@54 {
>   	};
>   };
>   
> -&mailbox0_cluster2 {
> -	status = "okay";
> -
> -	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster4 {
> -	status = "okay";
> -
> -	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -
> -	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> -		ti,mbox-rx = <2 0 2>;
> -		ti,mbox-tx = <3 0 2>;
> -	};
> -};
> -
> -&mailbox0_cluster6 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 2>;
> -		ti,mbox-tx = <1 0 2>;
> -	};
> -};
> -
> -/* main_timer8 is used by r5f0-0 */
> -&main_timer8 {
> -	status = "reserved";
> -};
> -
> -/* main_timer9 is used by r5f0-1 */
> -&main_timer9 {
> -	status = "reserved";
> -};
> -
> -/* main_timer10 is used by r5f1-0 */
> -&main_timer10 {
> -	status = "reserved";
> -};
> -
> -/* main_timer11 is used by r5f1-1 */
> -&main_timer11 {
> -	status = "reserved";
> -};
> -
> -&main_r5fss0 {
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> -	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> -			<&main_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss0_core1 {
> -	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> -	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> -			<&main_r5fss0_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1 {
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core0 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> -	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> -			<&main_r5fss1_core0_memory_region>;
> -	status = "okay";
> -};
> -
> -&main_r5fss1_core1 {
> -	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> -	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> -			<&main_r5fss1_core1_memory_region>;
> -	status = "okay";
> -};
> -
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
>   &ospi0 {
>   	status = "okay";
>   	pinctrl-names = "default";
> @@ -315,3 +161,5 @@ AM64X_IOPAD(0x0008, PIN_INPUT, 0)
>   		>;
>   	};
>   };
> +
> +#include "k3-am64-ti-ipc-firmware.dtsi"


