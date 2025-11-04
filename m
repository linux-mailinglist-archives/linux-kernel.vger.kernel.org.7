Return-Path: <linux-kernel+bounces-885087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F983C31F50
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BB41893DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A57286890;
	Tue,  4 Nov 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LEvHRU3A"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020079.outbound.protection.outlook.com [52.101.193.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9D264630
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272042; cv=fail; b=ldQUdJCBcMIWLq5s98GHcKDSR4ffYdIk6Uv5WPilhQQPU9maShCQENfPS8Ffd8VNo/syRDCzTU5oEgpfPzdfYnVLkm7IF/IdSyYfosMhSnKjgb4UqXNbo4hGEAyANVfZ6vyLUTgfZA22RlQy5f9rfBeu2SJFW6os+4NwSsxqmk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272042; c=relaxed/simple;
	bh=imz5cTwCd1QDXJ65S7oAxkqt4g+w2nDQ1GVIaiMwvSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SiFV2a/r+ZI+y73WVZhw/yWq99xfFs+w8lOS09+52NUbfPocjIAymoaQpfODwvsjcQSQ93zLLnAS9y8EwtryMwsY0yHo7TrNeGR/vc2iK0TA8EjGpRBL1g1Nj33ErglrwBbLo0kTYwX6Zzk0tH6o6w8P8YCduA0fFlLhiN58454=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LEvHRU3A; arc=fail smtp.client-ip=52.101.193.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTqLJaC1pTOZWvrzSnG3CT8uxPSAMl7GZ5VqVlT3kfHKmFS0ecR0CILRDZVt+qLQiTJjlSWLcvO4aKMIy9YmS+w2ZzHU6R8jy5R6TJdHdoEVtYONnmkxjsgowQhizNTpmMTxIHZcN8nY4vVlGbSTplcXsy44hkffQEKqJFlJIZl1lDsIf7gZ4T02UdUFSdpBwdsOcyDzCwAeVflpZLhQEYSLXjAoMZaOcrnAodc2Upf4vGIiJrLoQ957Y8Lv4c8gPgS28FBWpr81GtbImLx1W0YTTIw33p84myBXPyghKedMnhqAwyshCXrLnpFnf+dkz3OfSHURezzp60PaF0RSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vuR2+oyDx28UDys4tZfHJl7/N4P/mSZutONpJEH+n8=;
 b=NMHgj4Vziz4r16Q687dQnvSlGX5J4LOO5fYh7/3TyJ73Z5GLxkBwp54X7qME9FKtnwzSHyis34vqPDNbhp/leFFM7b8nX07z/XLjlkSn84HW3uXUxwBBFIXIBUfl7wNN3tTg/WHnWHnRgLmggSh+y6m+l/2RIXbwzQ0cWUpnMmBjBGS26QSCduY9pdAesFqWJh5o6DX7zZZhYtMKLijwjgD9e9gZ78tn8uLzhTJOrYRZLpxVfOhXh77qZ0KLLCtJFm1JiaM460a94uv9X8sxBEt/SvwV9/LIxnlzqVpOsQMdjXltTZZashLJ/rU5liylygJv9czgBm80tWKsaYb/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vuR2+oyDx28UDys4tZfHJl7/N4P/mSZutONpJEH+n8=;
 b=LEvHRU3ALEi+ytjtULrO0tn1++woYloMspASKnZbCa3K02jkpmILCZ96B3p2qhtP2kQgxcViOU/4z8Vdcrd3f/gyy799WUDUx2VjacOAKKntzNJU0oOUJGRkgCdC3TG6ZVvNAsFvwrybOm/Co/QEz293UVAqPfRBMnFCPUtWh8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB8204.prod.exchangelabs.com (2603:10b6:806:38c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Tue, 4 Nov 2025 16:00:34 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 16:00:34 +0000
Message-ID: <663493ae-6b73-4c63-b306-66bcca17fab1@os.amperecomputing.com>
Date: Tue, 4 Nov 2025 08:00:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: kprobes: check the return value of
 set_memory_rox()
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251103194505.4077265-1-yang@os.amperecomputing.com>
 <b5b978f3-bb29-4cbc-b006-fb9c4402b067@arm.com>
 <3ad071db-775c-491d-ac31-0f4753eb3bce@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <3ad071db-775c-491d-ac31-0f4753eb3bce@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:930:8a::23) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e91869-9d0d-494d-0c90-08de1bbb49d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MklNZmlwZjFTaEV2WTF1TjJXcmhzWURvOVVGT2dyT3NtSkdTam94UzdDNmpS?=
 =?utf-8?B?Q1NMQW56Z0NYeHd0SElQdlZaOG5pZGo3MGdva1YxVGVUaXRUZ04zanZBTzdz?=
 =?utf-8?B?cHNUeUxvazZSL3BBQ2swN0dDenlQcmdHWEw4RGNhTHF4M3d0Y0U1M256bjN4?=
 =?utf-8?B?TVJZQW1vUUxJSGh0endUMzZlcnAyY0s3SWt0VW80dTRhNUo4TFo3VWR5Sk43?=
 =?utf-8?B?ZHRwc1lVMWtBYlRtdEpxQ1l0YlZZbTd6MTJsdHYrWjJNTUwzZjRKS1JSUXVG?=
 =?utf-8?B?UkZUNWsraTZhemdWSHo4SkVYV2ZaVTNrNEJOSG5wYVpSVkFKWkRGQkFCNTQ0?=
 =?utf-8?B?N0xTdENIb085L2FuNW95Uks2ZmJiSVFKNXJVZXBjejlKdUhSQTd3dTBVWXhr?=
 =?utf-8?B?aC80Y2FKdXkwZEJESnN4bDV5bTlRdTVkVEMyZmEzMXlYaUxHZlpmYjJjVFBO?=
 =?utf-8?B?SWUyQzRydEhlc25UbThCdnNMZTZxUDVsR1N3c3QrS3ZjbHdIWnF4QVNuZVVF?=
 =?utf-8?B?SWlYVkRhUW9TS3JGSjF2MWpyMTZZblYxRkVwQVBzcUpyMy82cFN3SjlZMm5Y?=
 =?utf-8?B?MFk1a0VjVUlGaDltSjNZYVNsNTA3UllTMDV6Y1VBOTRZR29VMVRLeS9yeXRV?=
 =?utf-8?B?azl1MFhwMkxKZ1VWbklkZ3FZaFpGODZPaDl6dmh1aHJiMXBnVXlMMSszR2h0?=
 =?utf-8?B?WURIK2ZlejlqUnVpeEVXWE5nK0ZNZ0R0ZlNNY2gxMGcrMExJeXQ5SVJVejc3?=
 =?utf-8?B?bllTWXZVTUQ3ckZ4NVRTRFMrbFRZRXpveTM0WndLblVLMUhoTy9DMXVpVGpU?=
 =?utf-8?B?WUhCTDFNZVhFcjRYTUFWdXl4RzJNc3QyVWVnanhmNG5JNDBIREw3QkFBVHY5?=
 =?utf-8?B?RnkvTkhuTTRDVjBORWE1NGxYTnNwTit2N1VVK1AyMFFhV2doS0trRlBWMFJu?=
 =?utf-8?B?RGVjMk5uTWR1UTlZNjVnaTNpV0UzVFVPVncwbmhZMkdRMk54OHUvcVRoUzhy?=
 =?utf-8?B?RHpvUnBMSzFGRmRuSWN4WWNTNUt4RlBpR0VZUm9yckU0NjdSMCtoY1Btajdk?=
 =?utf-8?B?UGsvV2x5YVFvTThIM3BTQ0dXV3pyMEhNMEdZamtyR2xtZHRsSGxkZmU1TE5B?=
 =?utf-8?B?TlhIczhXMzFzTEV1WUNNejJjeTVkVUszY2FQZmNrd24vZFo2RTB6a1NBaFhn?=
 =?utf-8?B?NTBNaFFUZmxMdlNsciswTERTb1YwdHFqaFozTVQxT1ZJalN4eEhTRUFCajNE?=
 =?utf-8?B?a1QrRCt2L2U0ODRlVGxUQnM1QXVTZGU2N1ZkRndKRTNiQmdaWlB2LzZQcjBC?=
 =?utf-8?B?Wlp5OGtvelJ1dkVRMWNKVnV5dnBvc2pSaTJwLzMwU1lGb0Vuc0JvN0dHWjV4?=
 =?utf-8?B?a1JqV2prVWJxakdnM2ViZDhPOVVOb2ZUc0IycnVIcmFUMEVqTm1jU0gzcG9W?=
 =?utf-8?B?Z1g0bWdwaXVtN0p6YVM5Z2F2ejVnMUg5WVRsNFlOZ21RS2lWREpSN1gzRzlv?=
 =?utf-8?B?N2xJa1UyNktRenhnU0FTWlN6M0wvWXArZ20rMmhCR0QxWi94WFFEc0pmYUVU?=
 =?utf-8?B?MTlJTUNoM2o1R3ZBb3RPNHUvanhWUmt2dElaN05ZdDAvR01QamczZW9kQmZQ?=
 =?utf-8?B?RDJKYlQvcGh5RW9sQ0FMTVBnSDlILzBZZmgzTnBqQlBlVWVzdnRRWE9Nd3Jk?=
 =?utf-8?B?bGhsWUhvd3E5Mm5VSkJ2V1pyc3hINExzOU1ENEllME05cVBaWHluc05wbUw3?=
 =?utf-8?B?QU5sZ01QNEZOZVU5K1hLczNNMTZILzNPbkU3cTF4dDYrQVZtVTA3elBuaXQ4?=
 =?utf-8?B?YVUzSzBwWEJ5cXFZWEE1TW5wN3JsTXJzVUd5Z2lWRloyRCsrVXVRVk5XNnNm?=
 =?utf-8?B?cHdDaWQyS2VOM1I0WDl2U2VOMktYZEhiaDJKRGlHc1E0akZqSjVxdGhBRlVI?=
 =?utf-8?Q?DRqXWZ8qSYRhcXze9bzmNIBKbTGu3k6I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDVhR2RGMEdkckN6VjVlVWhFVnhIZCs1N2FsUDIwL2haK1hlQWtpWE1SRzZV?=
 =?utf-8?B?Z0hjZndCdlpyRWlWckNmMWFWTGlKcUVpTEVsTkdyR3AzZnVDekNHMnJmbmw5?=
 =?utf-8?B?V2szOWcrL01CeW5LTXY4azhENUU5UW9LdGFvZkpyQUVMTWJobmtoc09TOEkw?=
 =?utf-8?B?Zm1RejYvMmJob0RhMzRnNytSdFBWdDRTWGNKS3FyZENIMFk2Qy9XdURwM3VE?=
 =?utf-8?B?aVo3TnBsc1N2SkRqeld2SVdvTEt1TTlsNi9QYmM0L3pRNE8vblBLNjlLdDI1?=
 =?utf-8?B?VlQzbmFhTXVYU0FKV2tLTDFoUzdSUTRoUGsyVVhLcXhnL1FkaFA2dUpDSmRx?=
 =?utf-8?B?NjBxMFZiUmloaVlPVytFVVZuTlRqdmFTeE40OXN2K2tvc04wSEIvaVJJUDMw?=
 =?utf-8?B?Zi9RMjk0aEs2Y3pKOUFMLytTOGZ0VEo0T1ZXR05NVDVNSkI2bjI3Ukx3dzRw?=
 =?utf-8?B?d0pmUDcwbUw2eVN2cElPYnhnUmNYSXNESHc3UisrTExaNFZUNEF0UG5BMVVX?=
 =?utf-8?B?SmptMEVLeTJ6N25TdENUSmZ3VnlOMjhocUx4K3hGMFJ1ZlZReUNza0ExSXZq?=
 =?utf-8?B?dStReW5PVlViMHRqTDIyVitiYURpdDY2S0w1b3RxN2R4RXZWcVVlZlRlVXdL?=
 =?utf-8?B?VU1DYXVDYjljSVN1WEUzWldSMm9Cd0J3Q1lWZGRtNTlITDhKQk5yR1hTc2RB?=
 =?utf-8?B?Rm40RzV6Tjk4VWd5L01Bdld2bkZEVWJrd1BwYzZ2VUVFWmJ4bU1xM3Q2dGor?=
 =?utf-8?B?cElVY0FPMGk5aHRGSDFqcHJJR2xOeUtUTWNBZ2s5RmxyUVYrTnFxSXpUM2xX?=
 =?utf-8?B?S3dNbXd4ZE4zSFZRSTIwQnFrYjhtMXhwSGhzMitHL3BFTTdTbDFDZnQrbVZ1?=
 =?utf-8?B?SFhRVnhQOVp3ek9US3Jjb1ZuYzFQY0FMUFM3bHpldG1tdmF6NXdsSXV0cnYy?=
 =?utf-8?B?QzVySm8vNk1Rc3VMUVA1djNhbUFucWtHVmxmUURlalhIeGlCWi9WYnhJUXpm?=
 =?utf-8?B?ZEIvMUtGVjFTLzZBb2FsVEVVejgrbW1HUXZoTmZCczIyWU9HTWFEeGROdk9B?=
 =?utf-8?B?S1padVVsTzdPaDhGUkNlb1RVTTR6V3hMTnFNUUV6VURSdVo1R1ZOc29MazJH?=
 =?utf-8?B?UHkvMXZLbXArc2xWR1p6S0tNWlRTRnJiSSs2aitMeG9PMVhkK2hWbEg5d1Bp?=
 =?utf-8?B?aWtCMVRSNXJQa3ZkdU1PTmxDRWNpZFN3dGM0N2dKYWUrREZwcWMzcEc1K1ZL?=
 =?utf-8?B?SEpVb1laYWJTZWtCMU5Mc0xyQnBNOWdRbGtUekFBT2cxVUlFSGdXZ2lYR3lv?=
 =?utf-8?B?UHlVcDhaNis4VXpnbTc3eERlQmovRmZiR1B2T242TVlUQlBKUlB1Zkw1NUhP?=
 =?utf-8?B?SEcxUVhZWG9GWXIrR3M5dVhNYkYrRStCaUk5a2RxR3hnanRqeTY5UFZMVWZQ?=
 =?utf-8?B?T1FXOGNiSEplNHEyQ29LLzhWbEJGK1JnSDNJN2RUN2hSRUdrMkxKa1dkaVBJ?=
 =?utf-8?B?c3pPdVBMT3VHek9TSVF0eWdGY1lEUjBlT2xUWjFvbWM5amtBVERvVDNNOU1Y?=
 =?utf-8?B?YXphWW1MMWpsME5yTitBZ204VGFhQitCVmphTmdjTFZlbU1ablU0aHZNNEdh?=
 =?utf-8?B?bndpc2xTSEMyZnhFQThlb1M3VTVpT2dVajg0c1hIeFNLRzk0T1BwT0QwblVQ?=
 =?utf-8?B?clV1Rjg1VzdWdGUwYUtka2NKVFFMV2VaVmJkQWYvRlBtY3VPSlRuTzdPd3hD?=
 =?utf-8?B?NE1qdFl5SmRoMS96OGJyNXlQTWt3MnUzMncvU0FXVHpUVDNSdzlEVUdGTzNZ?=
 =?utf-8?B?aGJCRGdpczVQTTBmdG1WL0tJeXh5VStjYkpWYUYyQmR3SlZaRC84dWlGSlph?=
 =?utf-8?B?angyL05BVy9JTXordVc2RnZ6cUk5a1Jqbm9HSlZ5R2M3V3NtdG5hMTNCRExF?=
 =?utf-8?B?NjNuQy9nZ2hJZXNKV3lqbG9reFF0YW80NnF0eGRudHplQjZXQ0JpRWhJTUd4?=
 =?utf-8?B?eHFETWJ4eWt4dS9KR2dWVG5WenpTdml6OWpnWWpwWHEzbi9ZL3dRVVpZUFBm?=
 =?utf-8?B?ZndSNUtmc0hCVFVvWWd3TVBaMm9KTDhlRHdvU2k2YjYzYzMyWE5ONnZ1V2pj?=
 =?utf-8?B?YmVSZFUzQWhVTVArZUUyeGgvRnRveEkxNzU5UEtpVzd1U2tMNGI3K3lIQ0x3?=
 =?utf-8?Q?v3qFVrH2LAwm6Edx26ZxlGg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e91869-9d0d-494d-0c90-08de1bbb49d3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:00:34.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIVnntFSBuy6vhvBg+Hdr5WT0F6yQdVKuMSRgJ0yStTGuwMM1zTx/QBddAs2XVvfh333G/VPf968S1kMGu1A8dlTmMjKev82d/WvF+qg+Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8204



On 11/4/25 5:44 AM, Ryan Roberts wrote:
> On 04/11/2025 13:14, Ryan Roberts wrote:
>> On 03/11/2025 19:45, Yang Shi wrote:
>>> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
>>> rodata=full"), __change_memory_common has more chance to fail due to
>>> memory allocation fialure when splitting page table. So check the return
>>> value of set_memory_rox(), then bail out if it fails otherwise we may have
>>> RW memory mapping for kprobes insn page.
>>>
>>> Fixes: 195a1b7d8388 ("arm64: kprobes: call set_memory_rox() for kprobe page")
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> This patch looks correct so:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thank you.

>>
>> but, I think I see an separate issue below...
>>
>>> ---
>>> I actually epxected 195a1b7d8388 ("arm64: kprobes: call set_memory_rox()
>>> for kprobe page") can be merged in 6.17-rcX, so I just restored it to
>>> before commit 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in
>>> alloc_insn_page"), however it turned out to be merged in 6.18-rc1 and it
>>> is after commit a166563e7ec3 ("arm64: mm: support large block mapping when
>>> rodata=full"). So I made the fix tag point to it.
>>> And I don't think we need to backport this patch to pre-6.18.
>>>
>>>   arch/arm64/kernel/probes/kprobes.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>>> index 8ab6104a4883..43a0361a8bf0 100644
>>> --- a/arch/arm64/kernel/probes/kprobes.c
>>> +++ b/arch/arm64/kernel/probes/kprobes.c
>>> @@ -49,7 +49,10 @@ void *alloc_insn_page(void)
>>>   	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>>>   	if (!addr)
>>>   		return NULL;
>>> -	set_memory_rox((unsigned long)addr, 1);
>>> +	if (set_memory_rox((unsigned long)addr, 1)) {
>> How does x get cleared when freeing this memory? arm64's set_memory_x() sets
>> PTE_MAYBE_GP and clears PTE_PXN. The only function that will revert that is
>> set_memory_nx(). But that only gets called from module_enable_data_nx() (which I
>> don't think is applicable here) and execmem_force_rw() - but only if
>> CONFIG_ARCH_HAS_EXECMEM_ROX is enabled, which I don't think it is for arm64?
>>
>> So I think once we flip a page executable, it will be executable forever?
>>
>> Do we need to modify set_direct_map_default_noflush() to make the memory nx?
>> Then vm_reset_perms() will fix it up at vfree time?
>
> Dev just pointed this out to me. Panic over!

Aha, yes, it doesn't clear PXN at all.

Thanks,
Yang

>
> static int change_memory_common(unsigned long addr, int numpages,
> 				pgprot_t set_mask, pgprot_t clear_mask)
> {
> 	...
>
> 	/*
> 	 * If we are manipulating read-only permissions, apply the same
> 	 * change to the linear mapping of the pages that back this VM area.
> 	 */
> 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
> 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
> 		for (i = 0; i < area->nr_pages; i++) {
> 			__change_memory_common(...);
> 		}
> 	}
>
> 	...
> }
>
>
>> Thanks,
>> Ryan
>>
>>> +		execmem_free(addr);
>>> +		return NULL;
>>> +	}
>>>   	return addr;
>>>   }
>>>   


