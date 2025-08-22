Return-Path: <linux-kernel+bounces-781586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C0B31462
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A831BC04A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003532ED17D;
	Fri, 22 Aug 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="w1WoFYcp"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D941C2324
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856084; cv=fail; b=eFwCKE1lIFPApVETQElH/Pf66hCROmFUIlS0s/bFB2vkqj0VOVFILUkYPF0yRht5dz5w1DouL3ep/1LuSdWJh0qgS5qRxzwof5dOUn37CRJUJp+cZzsfIb1R5QywyzKNN/9M2mnbqHDq3CGxIDOmFtg4GCUsY/5gBu5CFncMTDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856084; c=relaxed/simple;
	bh=ND+o5LNfm4356ca659uRCOR3xPzHjLeix+BtO6OrASM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cohWtl3wbyNBZG94uwiJChP0yjtXDazIHW+x07ftpjCPdrniTtxvG8hm5dulyESum11qKhW0oI5mdJM+Xx3pUGb/l+mc3MrnbE2DuWdiutd8gmAMixRbgMHfmccObO09YncMgTYCMUk8Tvee7I/kCiGfjcmlfGby2umLB9o8aOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=w1WoFYcp; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbBwL1PH/VIyLn/wcM79i6VQQagyP0qQKy8T7Z5gan5HGq1IeVz+1VTHpG0nDNLu/ECr2zMHgN8gKZP+afqgNjdc+wcq399eyqdy9dNbRseu2oGIlJpCPWhjsj0/jH+7wnCF1f6AAAyE2dB0KTBMVsGMSb/khMIa4J6mXObZKBP57H5iZtnnIHreyDIJsuqs+Q5bazrO3k4Qcfg+y7dMC/YosACbhj904W1JtMHCXHU8Am79/whWUjpu4G35Hum4bWMjHzBxkaOJVmIHMlV2dziOVKrXDqbNfw/0AXXkBvEUlUQb/qgJ01PG6f/O4mAVfbkw4CpVlNsptjR6GmYPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzUpM1BFvJb14u2AR7AxvtUZ5gpZbLsi8SeTXfqZx5Q=;
 b=KLQ0dwT8kCH3gwcoSu65wjdIGCIwd8bD1MULB34d9WKoJev99NkMOln3We6mxWih6Bw/I6K/eWBlhS7DA5yHwAJkyiIfrewmBhL03db/mG7v5Z/amoLX8wYK1lzL2JOgD0Pp/2O5X3NBwPON0tT+Aq4aggcqau+HBumvd/D3mpfpPWN2+6bC0NH4uqqtHz0qgqJj4aRo2Pq4cgct7yckxxNhAg/bg6wm9jHMvaTDSLSUsObGbR3wMfpI1ASj52DDJ6Qp4Wu+gbPMEAg90tzmeIAAQ3+qwHUFzMKuadzOKjE1+3r53sinZhrpLjzqyhVidH42n+G6tBR9/KtthykGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzUpM1BFvJb14u2AR7AxvtUZ5gpZbLsi8SeTXfqZx5Q=;
 b=w1WoFYcp5h1p4NPfcwNdeqlgYFbYymTTo1HFD4BD8Nw5cIYaRiIBztJbEILWoaKcS+MOGEV76asnqrph8yDp5fs5YqulWIlvrZwswj1xmFZA7Oo2hq8iyzMB9gZDXexGtatLOo5cwMBHCufoQtN4PnngwCcqdfbCM0u/EqzN6gpw54q1mbH68+amu9dgap6EjaUe2IyrBhJoh5RSAb2Q9WI7Eg2VAPlajPL3jAJ6MnKRpPXc1HUnzZuC/HuoyDe7WtcIWPNug1FlbXOUnB1349d/fmESSnEX6PY2c3NdAxuIohC6+snpydcR4fY2kqMyRJP7I8ZDee1jyRyO3XgFuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 09:48:00 +0000
Received: from BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e]) by BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e%2]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 09:48:00 +0000
Message-ID: <0bee0edb-5a3b-4648-8ca5-ad334220f092@altera.com>
Date: Fri, 22 Aug 2025 15:17:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] firmware: stratix10-svc: Add mutex lock and unlock in
 stratix10 memory allocation/free
To: Greg KH <gregkh@linuxfoundation.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250722163045.168186-1-dinguyen@kernel.org>
 <2025081920-greyhound-discuss-79b2@gregkh>
Content-Language: en-US
From: Mahesh Rao <mahesh.rao@altera.com>
In-Reply-To: <2025081920-greyhound-discuss-79b2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::16) To BN9PR03MB6201.namprd03.prod.outlook.com
 (2603:10b6:408:11e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6201:EE_|SJ0PR03MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: f86c57fc-a29d-4bc9-8b01-08dde160faee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWZRTmlaTFl6OXRPMEZVUXdDL0ZPNTkxbTRlZUxuVW9mcjRGd1Vpc2JWcGdr?=
 =?utf-8?B?WEJSdTdFTDYwY3d3TWVTUXJ1VVZUMkRVUWtQaTFwbHUzVjg4OGF5aW1zRC9y?=
 =?utf-8?B?OFdhWldIcWRmZnBuejM1Ylc3VjRNNWpURy9JTEZjWmplZllvQSsycW92UlJl?=
 =?utf-8?B?bHZCc0doSi9iZ3I5WjlxRkNEK0ZNM25jSkVHekQ1RnFzS0NyMzN2aEJsbG1t?=
 =?utf-8?B?Tm5DNmtrRnJwTWpqTHgwZzFrVmd0L1FCM3NzZU9LaytwODd1dk5hc2k3WHdF?=
 =?utf-8?B?N3NHM2VtWmVLYzFZWHZDMFNZV1MvckY5bmpDMWFsT2p5ci9RMWxwNDdianlv?=
 =?utf-8?B?SnlHVnFmbUprMWVTaitOTkEyejQ0cGk0N3pSQlVIQWZVWTZjUlhSdkF3cmVW?=
 =?utf-8?B?REpUUDJNUEVydVpxcUU4Wm5lcTRVcXhaYzVZQjNhb0Z0czlYRDlVeVR0eFhk?=
 =?utf-8?B?dTcwbllTdFhqWGpLeE1YV3lGaWxkenlGeGZSU3lvemJtK05KY1ZMd01xK3RC?=
 =?utf-8?B?RUNOMmJEMDFIajFnemxRVjN4K2tLbVhTNThqOEx6bU9GRGdzVW5PdFFBVFUw?=
 =?utf-8?B?bzdNVm9Sblpua0s2NmlHcExyRkxvUmNWMTVwVENNTGxQdzVjTzJXd244QkFY?=
 =?utf-8?B?dFNmd3g3cml2cGJyU3NGOTRPaXpEdm1SanZJTFBSRHU1WXl0T0pTTEVVcEMv?=
 =?utf-8?B?UExpaDllMzlvd1dRSCswODM2SmtEa01nT2NjYk9OWXdGMFFwS2dzRGppUzQx?=
 =?utf-8?B?RUpVdjJoNGJ0Y040TTJSSm9GNUhPa3FDQTVGcTZDYStEYmlkSTZvMEJWWWNy?=
 =?utf-8?B?UWw5VzdtUjM3eEhtOGllS2tZS05Md083M2twRWVJTll2SS9TdTVxTUFpakEx?=
 =?utf-8?B?TUE1alE5aisyMXRJek9iY25LckxuampxSEtCZzFsOVhKc05SRUNPbnFRcXNJ?=
 =?utf-8?B?SUVYTkUrUzVWRms3U21EZ1FsTkVZdmNEWWd3Z1ozcmNxWk5rcXdISlVsekNh?=
 =?utf-8?B?M2pUcmZoamJWNERJSXRLdDZKOUVXek1IOUpqN3RudDk0am0xZEU0ZGF6a1ht?=
 =?utf-8?B?dkxBWTM3bTNDTTU1OTFTNjN4R2F5YU1DU0FpYWduK3JSWm9ETFRlUC9CMWti?=
 =?utf-8?B?bElBamFIbWVCV09xN045R082YmZ2SWdJd3R6Z1VLdCttbWtkM0tmVFBIRjMx?=
 =?utf-8?B?blhLWnZiNDFqTThiaS9rNkJrL3NKaWRKSWFNUWdCVDFDUGJPSm1EVnhWbGxT?=
 =?utf-8?B?aVp2U3FaOHhyd0ducklVR2p5ajdJQTJ0VUVDRkVwVFJVdEFQUmRrdFNnM0tm?=
 =?utf-8?B?VEtTN3ZESFBhTEdQT0dDdXl0K2p4YlJ3cnVGQXZyOFgxREFPSUpVZUpuNWg0?=
 =?utf-8?B?TlFpSllxVUxwNkR5ZDdnUFBOc3UwNXdwWGkrQlpxRU1Rb1NvV01KdWhIVkhn?=
 =?utf-8?B?K3RITkJPYUZiQjZHZk81V2tyWWVTVks3aENPb05OcCszNkM4cHllUHZyeGpn?=
 =?utf-8?B?MkVoRlhOUTRNM21CWll0THdJdHlwV3FDdnBiNkZXTlB0SGJPMzgrQUFzVG1K?=
 =?utf-8?B?SGpNM3hiZlRiMWRXR0E5R2FCQVFwOWpOcHBMZ2hSTlNrWWRpM3J4UnFFRzZE?=
 =?utf-8?B?OWVHRW9qUDBvdDBSeEtOMkVmS2tqbE5scHNZNHpoa09yWlgxL2J3SnowR1U1?=
 =?utf-8?B?SnhUWDRNR3duSmxMZSttb3ppMnFZMkV4RFdSMGhwSUxGU3dYWTc3Y091ekZq?=
 =?utf-8?B?V2luTnRFMytxYXZRMFVDZUNBVE9BTTRJeUxmb24wWDlteEhSSjNnM1k2QTBq?=
 =?utf-8?B?M1dLVXRZbDcxd2pPeEZsazRPUm4wVHM4Tm5uWXAwWFhIeFNtcGZhSDl2WFRW?=
 =?utf-8?B?ZmhZalVsamMyUE5TZm05enNGZmlLTXZFcWRLK1Vqa2xDQWRIa2EweXplRWtj?=
 =?utf-8?Q?CGRtaceOvjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6201.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXlzRFBMaFRkQkZiUnZvTVQwT2ViNlRWeEE0VGozMmlYQlJ4cTBvMndMZk1n?=
 =?utf-8?B?M1ZWZ2pCRFFCZ3M4SGxvSkxHUkU3N0laY1ZGMnovcmIxazluWktqMWhBQ0Nw?=
 =?utf-8?B?QVRxejV1MTZkOWJvaS9sV3cyY0JyM0o2dWw0YVVadWo5YXhCMWpsSWhSa1Ru?=
 =?utf-8?B?VVBYSFNQMkRXcW93ZWlkSm9BajhnUTZkNytMK3lONU5Va3pFc0E3TFJ4ZU1P?=
 =?utf-8?B?czZsSFJDaXBFQzU2Nk9IQXhIT2lmQktFV1dxZUNjeTBDZ3NUcUZWM3lkbHB5?=
 =?utf-8?B?SmRsRGdLdmNFQkwvWVZVaGhMODZyUmNnNnNwNjdmYmhwL25WZ2dMcTlnS2l6?=
 =?utf-8?B?WFprU1dtZkxxQzYvamFVby9zcmZjSCtxNC9LUUFCNWIyQmFuOHBkKzNjY09R?=
 =?utf-8?B?VzRVYjV2VkluYnNvdmpRM2pINDFnbUNPWkUvTVFUVjdHeEphSE9MdWZsU3Vw?=
 =?utf-8?B?eTczcnQ0NTZsVFgreEtGcVliZHBRc3hvMXZGT1hzSW5aT2VYTU5XRGpLazNp?=
 =?utf-8?B?SDBvOG44QXUrdW9uWUJER3ltT0NIbnNkUW9BQlgzTS9YUStoY2Z0cDJqMkM3?=
 =?utf-8?B?bXg4WStoR0Ivb01oSkoxMEt1aXYyaS80YVFldFROcWxHWnQzMnI3NW1iU0xn?=
 =?utf-8?B?ZDQxV2R2MTVVV085bDlRT2h6b2U2RHVTZ2JZRzJTbUhTTGdnNkNBSUtvM2pW?=
 =?utf-8?B?YzlJMnFJSmJWSVpKb2YzWEM3cldwdmk5eEV6T0ZZWUVrRUo4Wk5vQkNyYStF?=
 =?utf-8?B?SnlzY3FyaUdCWHh6QkxST3NmZFl6ZHlqdWh3NEFBbUdDa2xtQ05wTlIxaGY0?=
 =?utf-8?B?cWc1dStxbUlYRnFRcUhiTE5nbUc0VTZwd05heUIwTks3NUJHbU9zeE1PUHpu?=
 =?utf-8?B?djZlVEpFSDZxV2YrMnE3WUJsazdzRFF6N1ZMOExxQ1FjTXZ5UlNNdHVhaE1a?=
 =?utf-8?B?OVZUU1h4SDRsdUQyWXhza2tSYnNIMWdZZG1XemMxczVNS3B0NTZKTXVWV3Fv?=
 =?utf-8?B?NjRqaFN3VHpFOEZnVHJKVkdxUXl5NWY1K0hEL29LZFlKMm8rVEozT0tObVVs?=
 =?utf-8?B?OVZsYjNNTUJrNEpGQStkTmVuNFJwanJsdDMvaEdJaEdaUXhpc0huRWVmVnEz?=
 =?utf-8?B?NDRyQzBOL2NTME9ESDkxdGRmMnk5U2pkWnNidWNETmtweGpOT0Zhd3MvdHpt?=
 =?utf-8?B?aTJkNGNINEEySUdNdEdJZDlwYzlBNG5HWHpYQXVyQkpvSzBNa1dZRWdVMjVi?=
 =?utf-8?B?VUQrdVQ0SG1UcUZLc0U5My9RaytKTmczSHRaVlAyM1pIY01mZkJJMFZndHhy?=
 =?utf-8?B?d09DQkVWYUlZaGsrZ2JROERubm0waElpOVFSNEhuREpXUE9HQ3hLTUlzeFlw?=
 =?utf-8?B?K2JwOFRHVGRreVJQM09BNVM5SGkzVitxZXVmRjZlbDVvTkpua1M0VmsxOEVR?=
 =?utf-8?B?OUtLazJaa25rTlMrQk1Vc0RSaUxJU1Bsem9tYmIrR3JzSUxObk1OcFFZc09T?=
 =?utf-8?B?c3NQaDFWekVRUlZLRVREU09WeG44blA1S3dLRXkxSzQyODgyL05tU0NDU2d5?=
 =?utf-8?B?SEZZQ1JWWEtLODgxVUJaRHFmOTF6WkVZQzkyaEwrQ2s0QTM2SHlHQmFJVEhK?=
 =?utf-8?B?elFOa25vekJUcDRxR1FybzNRODFSNVdhT0pYUGRNbnlGTlJ6V2pXc3VYTmhq?=
 =?utf-8?B?eUpYVzJxZjNyMFIvemlLc0ptMGxpaGd4QitSbS9VZkJCMDQrblRUUzZ5dHp4?=
 =?utf-8?B?MVRTeGEvandydWJCd1NsNVR5dUFWUDdqTXpQb1NpOWFxSGtSWjVHMk1xTERH?=
 =?utf-8?B?cVFrVHVvWVlLazFobDBXN3I0TE02WWNUdjJQSmNLSEtiUjRYblFzNVdneXc0?=
 =?utf-8?B?d2dsRjBXcW5MQlRWb25JRXd2SXBUUVdFK0RFSmc3a29rZ1lCRDA2RGRFSXlT?=
 =?utf-8?B?RXp3RjAzRnZQNWM0aVFzaWVTR1hNalozRlZCK3VSQ0R2M1R6Wm4rZExsV0x2?=
 =?utf-8?B?NHFrYkVOT1V4elk3ekZ0eVhmODR3NGNkNnFPK1BFZ2ZCWlFSZnN6OVZPZ01r?=
 =?utf-8?B?dnM2b0NDKzE3UW5XcGs2NThRbmgxSzROSEp3d1ZwTkVLN240OHkvYWVLR1V2?=
 =?utf-8?Q?/ub+jAsz1yEV2Gn05q7zZnr3c?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86c57fc-a29d-4bc9-8b01-08dde160faee
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6201.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:48:00.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJjPFWCBSkTkmNjCOsWbEYgWXTOZR3/IL8pl14+OjLYcSP4uaC7NJ9Fga3mBwQGFUCSIa3ZB7JL3lHQwNDZq3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5613

Hi Greg,
	thanks for reviewing the code.

On 19-08-2025 04:36 pm, Greg KH wrote:
> On Tue, Jul 22, 2025 at 11:30:41AM -0500, Dinh Nguyen wrote:
>> From: Mahesh Rao <mahesh.rao@altera.com>
>>
>> This commit adds a mutex lock to protect the
>> stratix10_svc_allocate_memory and
>> stratix10_svc_free_memory functions to ensure
>> thread safety when allocating and freeing memory.
>> This prevents potential race conditions and ensures
>> synchronization.
> 
> You have 72 columns to write a changelog in, please use it :)
> 
> And is this fixing a bug?  If so, shouldn't this be tagged for stable
> and add a Fixes: tag?
> 
> If this isn't a bug, then why is it needed?  How can these race?

In the current implementation, all operations were performed serially, 
eliminating the need for protection mechanisms. However, with this patch 
set, we are introducing parallel access and communication with the SDM 
across multiple client drivers. This change may lead to race conditions 
involving the svc_data_mem list.

> 
>>
>> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>   drivers/firmware/stratix10-svc.c | 31 ++++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
>> index e3f990d888d7..73c77b8e9f2b 100644
>> --- a/drivers/firmware/stratix10-svc.c
>> +++ b/drivers/firmware/stratix10-svc.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (C) 2017-2018, Intel Corporation
>> + * Copyright (C) 2025, Altera Corporation
>>    */
>>   
>>   #include <linux/completion.h>
>> @@ -171,6 +172,10 @@ struct stratix10_svc_chan {
>>   
>>   static LIST_HEAD(svc_ctrl);
>>   static LIST_HEAD(svc_data_mem);
>> +/* svc_mem_lock protects access to the svc_data_mem list for
>> + * concurrent multi-client operations
>> + */
> 
> Odd coding style, this isn't the network subsystem :(

Ok sure, will change

> 
> And what about a lock for svc_ctrl?

There is only one instance of svc_ctrl and there is no parallel access 
to it.so a lock is not required as of now.


> 
>> +static DEFINE_MUTEX(svc_mem_lock);
>>   
>>   /**
>>    * svc_pa_to_va() - translate physical address to virtual address
>> @@ -182,14 +187,18 @@ static LIST_HEAD(svc_data_mem);
>>   static void *svc_pa_to_va(unsigned long addr)
>>   {
>>   	struct stratix10_svc_data_mem *pmem;
>> +	void *ret = NULL;
>>   
>>   	pr_debug("claim back P-addr=0x%016x\n", (unsigned int)addr);
>> +	mutex_lock(&svc_mem_lock);
> 
> Why not just use the guard() functionality instead?  Makes for much
> simpler code and a smaller patch.  Please do so for all of these.

sure we will add this.
> 
> thanks,
> 
> greg k-h


