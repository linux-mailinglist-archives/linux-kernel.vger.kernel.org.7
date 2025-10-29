Return-Path: <linux-kernel+bounces-875501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE1C19380
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FFB5619FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C04231B111;
	Wed, 29 Oct 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="V3dIF3Bn"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463E2F60AD;
	Wed, 29 Oct 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726661; cv=fail; b=aWwuLATcyqop5+fgezog54NEo4VUIxwYjm2v0xBC7zFRdp3hpJ0hcNIyztEJM1e+MiKCdsyEAU/AivA/aWEYoQx+WUFLCTvqpvQYiamuF+zBgIRTNKtMBii6SR8gRAa/dzYyA5/RWtYl5SCQZF0Fi+vwr+zVL62dzdGl6yKhI64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726661; c=relaxed/simple;
	bh=YaMuM170HekXqRhmeztGoOJw9DJXWlftKbShxWgsjLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IvyjAhRXxdivR6bi5SVpE1hZ2gnyuWjLHGV8272iEHS/MwLkttaSPeSaByTU9Rj3aIWchgs1qX81M0FA7vInOlfjAzQygB9ZFFfgkRmlGz13IT2eLFNmFH4fCmqT7/TVfZRUhypb4+LP/PWnIoe9XwNppYfnsmqkYE3n7G0v7ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=V3dIF3Bn; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T6A8G42048840;
	Wed, 29 Oct 2025 08:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=YaMuM170HekXqRhmeztGoOJw9DJXWlftKbShxWgsjLc=; b=
	V3dIF3BnNjGlP/xVY2yiS8SfCULw1Nl7GrY2PWVN7ZcuXDt/Tjo5FNW1vRyextug
	Yu/vBj49uV3oDvck6MtP5PK2bZ3G0ZPUBDuiDHoLJw7RkaAr1wYJjZJePAR8Jlqn
	rDr3LpPrwpZsjI5w8HPRdzlHpaobmcx7ICe0W+5gjzQXF9WDb1+89dOaMesfoa1C
	Fe19TkYCi4HQ1GwYvDXxeWz1tFqo0jDp31WOb5zmWlLaXX+4GNjyIA5VRF2i3HeH
	KyUvEaEJzjA8Y8QMneWF1Q586ftHipKpak/fycJ1jRiglcYvSBDj6y7R4QRl1Ya5
	H5VOskylSKMCd8MLj3M9Mg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a348bgjgv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 08:30:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOSTR8Zp55tOkQ79HrQyxDg6cV/OAVlwZNd4LyUtJo0NObEyIWu9KUaVcP+8XspVdiofaS62MATHMjQ/065L9n4wlVfSx1viXMujG4E5FGYYoslbOIrA+3wv209AocZt7hLqll4c5LndW7kKJbGAH4dpRCuZRRqRTy9rZubmcj7BjB3+9XTOw6IHRF+T5+yxLHXKL2cuUrdjpo/QTZ/ZRsq6qVyrLd9Gba5fZD+l/YoF25FSU16IbEjaz4ctgpUqmjIKeb2s/Hryf8PkXG8Et6xxg1WBF7ywQbpVRvoSRONd6xt6H5+NiL5EE5d9aXtWtA8zLdyV9kpr/04PacZieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaMuM170HekXqRhmeztGoOJw9DJXWlftKbShxWgsjLc=;
 b=ENmWMkZ1rwvrg/+aMWBPHkAyH5ukL6LgkYbc6gW2yYVFDh76CDTFIG8aGxE7u13UN4cOOBGTbyaQiPPXb2HMEW+ujvSt5iqrjnsDrOYVzCjgt6Tt7WjhF1St0ix91SXFQjm0oZ/tymZvdxCfrYfnh1/FBXY5AtzhENBz0Zy1r48NwEPcNylF4uEqPk9QckNf9I0mWTKKM9TsUE+lF50yG0ASloha9Dsvn2LkTXasd+Cw04B6ZeF5QuPmY1cNZZUy8w7UYPWDTP8z03j/HvBcXWI+ykKtkit3wq04nd2Pg0fJv1AwJHPMrr2CxLT4Y3grcyHy71/VoexTIkwWMb+ceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::81d) by DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:30:45 +0000
Received: from SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 ([fe80::5cd3:aaa1:1564:3e48]) by SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 ([fe80::5cd3:aaa1:1564:3e48%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:30:44 +0000
Message-ID: <e0649530-f727-4ad5-9293-2dc40079c0c8@windriver.com>
Date: Wed, 29 Oct 2025 16:30:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] clk: fix slab-use-after-free when
 clk_core_populate_parent_map failed
To: sboyd@kernel.org
Cc: mturquette@baylibre.com, dianders@chromium.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
References: <20251002061215.1055185-1-yun.zhou@windriver.com>
 <9c8a8df4-f69c-4407-911f-0402bd06f4c5@windriver.com>
 <aPFIohBAaSnv8YUB@redhat.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <aPFIohBAaSnv8YUB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::81d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF2F7FC4EE6:EE_|DS0PR11MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc4b7d8-6420-45a3-8ce9-08de16c573e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDNiYnp6QmM2OFBWWkl5ZkcwdGo3R0NkRlE2T1FtYlVVdmpLNU12SFk1czh5?=
 =?utf-8?B?WmJhdzhLL1Z3Q001K3RDdmpFRHRxbkNmUmEybnpPcXVreW9rdUlocWdpNWE5?=
 =?utf-8?B?aGxBcGY2T0pPR3BmRnh2amFERFduei9xQVlIcnhqeU45QkhObks0bnpldHE0?=
 =?utf-8?B?MVRDSW84dXdwUzVnOXA2OFpJZFlQL1pDZWlGUVBVT2pScEIxWERPN2VadHNR?=
 =?utf-8?B?dVB4VmlXam1xRDdGRDh3Sys4bGtEa2FQeERkQzVLc05FZzI3eDFqbDg2L0ha?=
 =?utf-8?B?R3BmNE9acmtRRGRIa25PUmNrL0NVV0lWUmtZTTZMcXY2QmFCVk4zbEpzTkhn?=
 =?utf-8?B?Qm9uRURnM1AyUXlzV01kZkdObEtrRGRLekM4cmRoeXkzTnlMNlBKUWc5cjky?=
 =?utf-8?B?TkhXUnZHRVpVZGs5S1A1bHpBQ1I4emt0dmtNeVFEdk5yb1BmZE9oWEZ1V2kv?=
 =?utf-8?B?dnpma3ZNUHlWeXFqMDNrQ1drNWJqVzg2SE00RmJva2pTUDAwaXpBWmZOQ0RF?=
 =?utf-8?B?dUx2SVc5Y0tFeDBVTmhCaCtjN0NzZkR1UXJmTmlNM04rN1Q5ZCtiN2NhdmRC?=
 =?utf-8?B?QzVmK3pwYWdjeUVJWDViWm9lVzZoaDduTTNGdkRyVEE5c1cvQ21kSXlUalBm?=
 =?utf-8?B?RER5cUQ0WkVCZFhwSFhwWU1ZZVJlNkx5MUFxakc4eHJFWFhqWmhsZHdRdDZr?=
 =?utf-8?B?aTUyV2dpc291Y1kxM1haakVxSUxtMWcwM0tFdjIyWUxmVVJEWG1hT2tSMUUv?=
 =?utf-8?B?VnpldGU4V2M0aHliV04xRnZ0RG9vT0JnSlE3Q1EwU1IyMmZjTDVieVoxamt4?=
 =?utf-8?B?M2F4QWJCN3Zwb3Z4OXByd2NpUDN0QUZlU3lzbVdXc0pXWHdHZlNEUGJwMUt3?=
 =?utf-8?B?VUNWejRwU0lhcXRjR0VubXhWRWRYZ0xJQzRMc1VOT09WT1JJczZXTWl5Q0JW?=
 =?utf-8?B?aGxOQmswTXBkcUcyQWpJU2J5cnJFNmh0a3ZSOHpUWDZBQS95eGhJSE13UVRY?=
 =?utf-8?B?YTJFWHlYbmYyZ2ducjlWSGpVWGFEOVZaVFUxclZqZmRkRUd0MVZHNmdkWG5y?=
 =?utf-8?B?Z1NHV3c2Y0Q5M05iY1lPY2d3QmF1aEV6OHBKaW9FUXhHQVlYbDVkdWU3NEFC?=
 =?utf-8?B?cCtJWjF6M1VqRTdPdEVBQzZ3ZllHS2NaRE4zVldicWFvdTl6SjR3bnNIcHNV?=
 =?utf-8?B?dFEvTmg4QmN2RWp4L3UvSmZkWGZkRzBJWFBZY1BBNjFRTVpsbXZ3QkpHVnlE?=
 =?utf-8?B?a240WCtnZXhKY0gwdmJ2WE9ROThMQUsyanhyQTcxTHJjQURVZlRBYnRocVBr?=
 =?utf-8?B?UnVONUhPUFV2ZTlvTXJ1ZUtadHJYaVFSeEp5Wkc4aTlTNG5Oa2pCZXh4Wjcy?=
 =?utf-8?B?MEpsd3Y2K3dPQ0FZNi81eGhxSm45VVE2aFdHdEdCVEhtTHBHcFhPNEZKWFN2?=
 =?utf-8?B?bmQ5OHNScXR4cVd0S0xpanNlczFIRDJ4OEFVemRoYXlwb2RiNXo4TEtYUGhH?=
 =?utf-8?B?dS80MmZ0eVg1bENxaUZHdy9LeUNRbmQxMGplMVVUUFRmTXdQOVJyd3hDeFBV?=
 =?utf-8?B?Z3Y3RjJ1eHlWbzhkcThBeWdoU0xob1FldmJuUGZWVXdzYmRuZHB2b2hENjBl?=
 =?utf-8?B?dmkvL3g5R0xiaC80VnVDaTNyb3lJNUZaVmFNdXZnbUE0Z2t1TDkvbjlCT01y?=
 =?utf-8?B?SVVxcnV5R2tRNXpObVUwWnpybU1lckJyRTBkd3ZYeVpYUk0reks4UVFvckc1?=
 =?utf-8?B?R0kyM3d5VnpPTThabThQNkh3endya2RnQ2VaMTlsdmVCTmxNaHlGTE4zWHkr?=
 =?utf-8?B?ak43aGJVSUVvZHc3SUM5ckZjR2NEMlNGbFY1N1ZPRi94RmZ3WmQ5bWlrbnhh?=
 =?utf-8?B?c2VTYXZtdW11ZU4zMVJZdElWWkZCU0h4Vm9qekV4cTJ6OHI1NjhnK1hIaTFO?=
 =?utf-8?Q?hVqQyGaow4Vc0GE1MiBrP2uwqL9jB5WH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVJYSWpoaDlJNldQSmUxdjF2VzVydjVWd3AxR2xJTU5yN0N6WXFKYlNIZk1L?=
 =?utf-8?B?V1l6Mi9IK3FSRmNmS2pvcnZpTVdhc1FiWkw0bGo1MnkrMFcya0JxOEk3a2tV?=
 =?utf-8?B?VmRRWERpZFBnZXR0bWlnRGwwNW1oQ2NUTVlpWFhrVW5ndjBvZGQ4M2Rsbk1t?=
 =?utf-8?B?YzM0SUdDS2hnNG5BTEZlekF4UmZGTVFsRzY5bVFZQ0JBN25IRjVsQ1M0YTZF?=
 =?utf-8?B?b0ZWYm81UmJXQkZMTjJlbzcwMlZlcUs3S2doS2NoekVHdFZlUVk1ZDVlYzU0?=
 =?utf-8?B?Tlc2MXExaTlhSzZQT3VqUjl4QWI5YWVDVlZxcVgvUXJGaS9xVURlZ1hlOE9m?=
 =?utf-8?B?aFNta3ltZmt5am1ZN1FSNEZsNWVLekc5VVdLZFpXWFBTTi9QZ0NRb012QzNT?=
 =?utf-8?B?STRDV3I3ZmVoZkRyRi9CdUJEcTBzTmV5ZFdRNitYNzdoaDhsUnV3NEFXQ1Qv?=
 =?utf-8?B?R2tpVDFmdGRycVZ2b3VqbUF6TXg1amxUNU5VQkZOdjFJVDlzdlFyV0hzUG9q?=
 =?utf-8?B?a2htaUZKb3E3MVJackE3T1A0bFRSdkRlZnQrK3FpYnlKVXNRV2h0bVUzMWUw?=
 =?utf-8?B?SmNnMlVvb3lLNTRYVkp3WUxCY2N2Z0dWOUVQc0hpRU1hRGRJdzdpRnJwbGdn?=
 =?utf-8?B?OFpMWlJPTzl4cTlqMzIxZE95ZVdvQ3NjNGppRUZSbUxmVGxHelJJU1ZSNGM1?=
 =?utf-8?B?UWNKZGo2dTRON2JSWjl6Ui9COC95ZUxFUGk5OWZwd0tmNDBmTFlLS3g0OWJn?=
 =?utf-8?B?RWRnUGxiZElkUGhoWjFteXBVVU9wRUtTVXBuY052VnArd2dXTGZvZFdFLzB5?=
 =?utf-8?B?M1IwVEI5bUpERWdoVE9KN2ZYc0N1ZUFpTG0vMklXdWJIUENMTEtycTlLalJP?=
 =?utf-8?B?b2hMd1BOeG1wVjJlK2N2UmE2aUFGY29tc2NZYUhmUm1ONjVsbVNJN0oyQWg5?=
 =?utf-8?B?NW5EeHU5R3ovVUs5SVRyKzM5OHJRSXE0cHNaLytCdVNWRlkyVzZZRFdoZHlz?=
 =?utf-8?B?b05UUmRWZ0pLUDloZDlvTW1hZ21ScEJVcjREcEZiOG8zMHJtNlVSNGhpMTdQ?=
 =?utf-8?B?d0Zzem9lRW9EUkV5czV0STYwRzVBOHcvSzRXaXJoYXlVZ2pTTWhSQ2Z3dEsz?=
 =?utf-8?B?TXdCaFovbTNJUndsY2RUWDlCV3ZUU3UxZ2F3bk9CNURGOTF3MHhUd2VOdmRY?=
 =?utf-8?B?NnB1aUVKYnFqZlRnaDRYM2VFazFQL01IaXV1dngwNFIrbkduSDBwaEhCTTA2?=
 =?utf-8?B?QUN5Vi8wU09EYit5L3lJQmdDTTduTUNNSGFqY2FodGhUaUZTQk41Z0psUFhr?=
 =?utf-8?B?UWQzdHk2ZXVJLy9keHZSaklJVEU4NE9QajVaRmEyeWZBSVd6NGFBeEVGTFQ4?=
 =?utf-8?B?L0NBUnpraFdMd0JzZVl6K043MG9ESUw5YVI1RFJWMWFQZnBFVWV5NGRZLzZz?=
 =?utf-8?B?M0ZTcDZQak1ZMHE0Sk9EMWRKSDlvTTBwTGl2RmVYem9ZT0x4OFpPTXR2RzVY?=
 =?utf-8?B?N0N2anFPUXN3ajlhNHNPV25EZzVOTFdJa0o1Q3lqMlc0L2x1dExnWmxpQWFk?=
 =?utf-8?B?MFBXUEdHd2VPNmNMNW1kSkh6bXc2ZWo2WTE3S3MzVklSRjdvZXRENjZVYmpj?=
 =?utf-8?B?VytwQjNtYzBsV0dVV2dobGh4QmR5bVdzR09pamxDR09sMjBGOHh3akJmdmZR?=
 =?utf-8?B?WDNLU0pGWkJNbjRrR3VTTkNhNVpqeTkzcVhtbTNYMjBLZ2dkcnhRbEkxekF5?=
 =?utf-8?B?N0NLM1BOTnl5YWI2b1FhUWRWV3RlSEY2bnlEZmhTNk82Z0dHOGloUXdoRkY0?=
 =?utf-8?B?VHp4N1RMdzZuSEJMWTFWUE1lYlJZMHZTT3FONGkyWExxcTVmU2o1V2VzMFNk?=
 =?utf-8?B?TGFIRlE2dDMvRU9oemFYcytycWpZRGNCc2gyRUcxbTN2RG1jaE5YZ2tJakNz?=
 =?utf-8?B?NEkvamZrQ05sT1MwMGthdU8rd0Z6Vkk4L0IzcmE3ejltVFV2dGkyNEF3WU1U?=
 =?utf-8?B?eDZPa21jOGFQVnYvc3MzQ1U5ME10cDNLMURsNURIcTE4QWp0bzUwQ1lyM0hV?=
 =?utf-8?B?TEFsZktFSXpJOStMaHk1N1QxWlk5blpISVMxTzgyOHVodi9yMTV1WkNRZWFi?=
 =?utf-8?Q?mmAFBRZL9qffCJonxFE0ZfJDC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc4b7d8-6420-45a3-8ce9-08de16c573e0
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:30:44.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prZZCRBsdjRa1P5RPGxB7IlVEf+H8aJAzgQ1bNVk8HJ32as9KvLylZanFiEPnkd1NNEYJjCKUGLXIJxysTxQHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
X-Proofpoint-ORIG-GUID: 4Bb2YFBJADQd_s82VhsOvJ8x3T4M3isW
X-Proofpoint-GUID: 4Bb2YFBJADQd_s82VhsOvJ8x3T4M3isW
X-Authority-Analysis: v=2.4 cv=UrRu9uwB c=1 sm=1 tr=0 ts=6901d0b7 cx=c_pps
 a=hu21wMtJ64LbrMgTAnPF/g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0WS4Z8Q0DA7OdGU3vBcA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2MiBTYWx0ZWRfX0fNL8gDmSiuM
 rDZhXKallQinlQXB9jW9jm04V+H1VlJT+4x3Zwjgie6HhEaiB/jobx3BoxpdAjSRW3TEsPaui/q
 kN2pdiOkvV08IrEJkLXZqizryZt0QeMKg0XwX1y1jJ17I8NIxUUFBoaK+nPgGXDNQNX5eNoppr8
 /vsX6wmC0ymGDehtIuzHfsextWmU0sE4730qcGgzKU27bqj0F9slldCKcj2C3nIZ2bqPhxa7V/y
 VhZUudBbDs7znegReqXZED2UNuYTAMPtMP3ROeJrn9o9mC5VRTJC9JDcMar+rMyjo43neLeS74f
 4f9Vl+qHYbl+J5J1V4gprXrgYvpjG+d4+vCniyLn6O/+wBKi5oNm972QoRfAUaZg9d/QMB3Ab2x
 LzR3fRXMJJH6BeS4+5bgOTt97Ba9mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290062

Hi Stephen,

Could you please take a moment to help me review the patch?

Thanks,
Yun

On 10/17/25 03:33, Brian Masney wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Yun,
>
> On Thu, Oct 16, 2025 at 09:25:20AM +0800, Zhou, Yun wrote:
>> Hi Brian,
>>
>> Can you help me check if there are any issues with this new patch?
> The new patch looks good to me. Ultimately though it's up to Stephen.
>
> Brian
>


