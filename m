Return-Path: <linux-kernel+bounces-801777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3750FB449B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12D53B7921
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B902EBB84;
	Thu,  4 Sep 2025 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A17uXoxJ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C0199E94;
	Thu,  4 Sep 2025 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025323; cv=fail; b=gGofOclCxTDdX3afNNP9H5z9x+Sa1TuAqKK2uuCuDCe4Lu8WAp7d+3FtxNQBypMTCDSyp38Dxh/5TUjXKj3YDNfWNUI2NV1PdUU4iVcmKK1LQv2IYNCSbvZAqkh/9DCKVbBpj8OdXf1lyXNVoagb+WULoOV05D5Ni+3Tw0JnP70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025323; c=relaxed/simple;
	bh=dUf8hx07oegf0+R/z95/QSNxvtqqPcJApXhAXPyKRl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aYqL2HAetN38ZL1WKoedKjArEkHAtLpcqPKe/0XKMWHlsPdkrGXt+3pxM21fj1uvJfTf+4gMFRF4eFfkXf8cxGNxqsezAuZ3UdRQOz+vaQdGOTnPV9gCDF8FyJlbJEQ6psVjgTstUSk9YpeZ0AbN8O0p/v6joJDdVJbmL6pZ55s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A17uXoxJ; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJf4NSNzcGGvw+fqNLomQ8DwFFK2ZFm5fWwyTz5mdlLUm4eVNssH+u5BGWbweGNAvXnoVdrZqLXrMq7ZKdZGlFF2YFj+PN6ivsMFxtC+erxuexiv46mjqbPr1zEuVhVYtiFa/4Y2clZAcZzVxVmLmKwnMfYiGB6eIsmrB2mprwMWBjFALTFOhEKPh+2ffvTBFOVwMXZS8FYLlGXi5JdBiEMUneWSCuqX+6YLbor0sC+GMA/RmeoP0g3LJEZFVRyRL//5Ks95SGSnNADooShCtVVU5ncyde8qI5k3gfAUB4Je4h4ZCtxEDcDDz4EG9x9mmbYnFnmZK4APOld2RepuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZFNAlsk9zii1koVPsGDMHMT1gPWa2JQzDLfTeUbwOk=;
 b=E5rGiV89VcjrC5tMStGkS+/wHfVgYDoAQJwzGKkxNGGziMnClwD1nqkMnbi+M8nya/4+A9pT2dKmKIds4BdhL+1IXDiw20D6Oei5HGOg7pYYQlbJcuP69pdDEPWqumn7NDHi2obNhQR8syoGmFSA9GvWhoH8EvBLbBIB66ii7UgOEtc0Y9IqnRSmIY3qHxmgl9NpdutuluBv3qRkELytwrww05mc4Rq5k1qnjFeRH2fB0wzFGOYh140NLJUC0786hHA/nqJR5VnWTEELyGC6A9vPL1Nizuhe4XoQ5+Gr/SqcFOyQwGeg0cXltZvk0GswT2XeHrdS/fhG+8YWieuUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZFNAlsk9zii1koVPsGDMHMT1gPWa2JQzDLfTeUbwOk=;
 b=A17uXoxJIYZsK7Ptb/pEkJMJNSlswAZnrHqqwear9R+bfRXBp+Yo8OYxte269J5lBVOOKdlNOeTDMhcwAjjHGW9gqHTrwlOKfNHWSfEfRvb0hkXeCaQH2+sD7XZYMj33+9p3cQm9m/kujq62GqvSql8DZ1zikfMQ7t3ZNPeM6/GPWTx3/6De6ZWMKiu+gMIyao6CHHtl+aB0St6UB8F2NA1c6a7J3o3AqylrcWEXKT7eGT/xzaTm9BlnRcDlSPDs06i8AMnfVHUVzIr+XUtmWYIypOxYz4YYEUJpgNN8Ag5N8M5bkLMovc0QGpP1q78DaLKhI7WIhtUd87ZJ56dxNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 22:35:18 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 22:35:17 +0000
Message-ID: <457567cc-4863-42a4-8b91-27de17b51887@nvidia.com>
Date: Thu, 4 Sep 2025 15:35:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b board
To: Andrew Jeffery <andrew@codeconstruct.com.au>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: joel@jms.id.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20250815224344.908130-1-donalds@nvidia.com>
 <20250815224344.908130-3-donalds@nvidia.com>
 <c9348ebb7f0cd24c950ba07abf4641a1d5382160.camel@codeconstruct.com.au>
Content-Language: en-US
From: Donald Shannon <donalds@nvidia.com>
In-Reply-To: <c9348ebb7f0cd24c950ba07abf4641a1d5382160.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To PH7PR12MB7282.namprd12.prod.outlook.com
 (2603:10b6:510:209::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7282:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e67b6c-095d-480d-4381-08ddec0352aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3VPeGZ4V1VybFVvOFpxOWQrNDQ5RW1BbktoRjd5aFZZbS8wS3I4NUNlZDE4?=
 =?utf-8?B?NHczVzUvSTNHSWMxaktxeFBlZm0wVUZRZ2FkL1UreUgvNHJLSHdDOUlPNXk0?=
 =?utf-8?B?eDNzUkEwNkVsdWRENEcyMGQzMm1hWG53V2lOb0duSUhFMVBNNmpuOWZpZy8z?=
 =?utf-8?B?dWc1ZFF5MEhCL2xLb3ZXVTI2K2h5QzVFQ29vU040VmhVTzltakdYazNKVTJV?=
 =?utf-8?B?RjlHYTJNd1dwaU8vdmRVRjltcDNKUEtsUVlaaGQ4dmZFcGdGWkpucitPNTZZ?=
 =?utf-8?B?QW03VGlZVng4dFpqMURCYjNDT2ovRSswWTM3eVhwSEZFYnZnTERjQ1lJZmZF?=
 =?utf-8?B?RC82U2NqRmNFV2oyeEk5MDZMVk1yU3ArREs1MGtENVRxdXRjYjVJNUVJODFD?=
 =?utf-8?B?Q2wzc0Y4ODFka2FjMzVBbEovSzJuVU5mWk9qbG5vam51SEVkSjdaOUVGUnVk?=
 =?utf-8?B?NnRybVc1Q2l2NUlNRWEvMVdCVGpYMklvKzJSRXRyVDBkV2w1V1hNWXNmZXlq?=
 =?utf-8?B?NmZtTnl5dGFwOWRhUExBbTlYeG9Kc1NicUZDakl5VXYyQUI4eGhTTTdrK1JF?=
 =?utf-8?B?YURZb0FOZ3lvSS85OHZrWmhoZWljV0l0RTNhdkhadWRmaW1WUnladGlSMlhJ?=
 =?utf-8?B?OWl5NWVucE44NjBhanpQVk0wOUxHd0x5bGFjWHJkSUViVUR2WUZyblVPUldi?=
 =?utf-8?B?YnR0cnFrZWs1RUE1RjVvRm1la3BMSWRMWlJsSjVoTTl1Z1Z0RlVVbS9qb0Zs?=
 =?utf-8?B?NHZPNkVqcjVzbnFVdnNIZ0V1UHJMT1BNZUNLbUc5MksweUJWc20vUmlqNFV2?=
 =?utf-8?B?UzJsUHZpTDkxVWFRMjY0VzhOZEJoU3RSUmpBeTVhYld3U2dZWWUwU2kvRnB1?=
 =?utf-8?B?RUxNZ2VVcTVublBuMENOYUh4bWpNWmJDaWVubkFSQ1RUQS9mY243VGxkY2hL?=
 =?utf-8?B?eDN1Y1dWRDJ1S0FvS1VJMHdaUm93T0dlMGtmVnNXdmhIdnRMQ0tYU1RoOE1i?=
 =?utf-8?B?RWFSVGRGaHdjZTJMbE9ncjBZcnVMNHZPMCtpQURYaWIwSm9UdEVSN1NvUSsy?=
 =?utf-8?B?S3ZycUlRWFEwMExscHhIcGIreTdqVjFKWFJ6TUxFNDVwdzdKSVY3ejVNSnF3?=
 =?utf-8?B?ekdXT1NLbWV4Mkx5MCtBK1VIUFMxWmZtdkFVVE5RTVBsWEtHVEFlbWhvS2VF?=
 =?utf-8?B?dHJRaWxhNGNySkZHWDR5UGNzUm41K2pPaGZBVzVqcmtjdXVuMzI4MHd6Szh5?=
 =?utf-8?B?dW5GaGZINEVucVlLTE90NllkVW5UU2F4S0d0S2VZN0oxaFJqRjBjV1l2SDA0?=
 =?utf-8?B?VXN0RzUxLzVGYUxyYk0xRG10THR1elRRMEI1VWhKdGR1R0VBcU9xSllxUFA2?=
 =?utf-8?B?dVBDNVY2cmN2aXZIVXcxRm5RcUxpR3BidWV3blJNdnlyM0NzSGt6azIyM29p?=
 =?utf-8?B?S1NqblFFUDQ1UW1rM2xEOG5IN0g4UktuaWRoSDdIV2JkV2J2R0hNZHBwRFpN?=
 =?utf-8?B?WG5EWTB2MFZmU1ZXTzZmbVREcGVGcGpuamp4UVlINFVNWE5NemJGdVdxKzFZ?=
 =?utf-8?B?d29rZzRuUitMWGtlS3V2L2pZUm1TUXpLTXdhTmM2TFhlbFdiako0R3p6SGZB?=
 =?utf-8?B?Y21VUHpJdVNNa25GN3MxdUtQcmtTbkhXQjZ1aFZLZUJqRUtOazBOR1d5NVRU?=
 =?utf-8?B?SW9keGN6UmJQZ0ptM2N5TStMZjlmMEJsYndpN2R1enRZUGtIaEd3Y3d4R1hN?=
 =?utf-8?B?clpEbnlSK2hHRE5hTkVUdldOQkpGZk53UlJ4Y0xBUzlTenpzY050Um51Y1I2?=
 =?utf-8?B?SThPTTdPVUtCQkxtZnpodEFLa0h5R2RTN0lLNTVFaVBScUFKVU9GaTdXdUR3?=
 =?utf-8?B?QXhRKytvaml1M1dPdlI3ejFWa3k0cEYrTjhaMnp0MXdSMTNXRitIbGw1b0U4?=
 =?utf-8?Q?mQsvcIgjoOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MktPZmh3UitGMmRwM1BVai91Q2RVSlNYSWwwbUVvZ3pqQU9OMUxpd1JKZFpI?=
 =?utf-8?B?RW9GN3JabHZ4aVpGVzRhdEYwbFQ4N1IxMFlHKzlZVGhPa0tVS3MyaldaTTZy?=
 =?utf-8?B?OTYwdjBueWlzd1Z5aFg4ZCtvRVRSc3lCaGx6ck4xTEdPZ2RaNnJUQmZtMS9Y?=
 =?utf-8?B?clZDVmZmRjZUakRubHVsTkVNdytZSVN1VXNPMTJ3ZGpGbHlCTm5IUDcvQ2Rh?=
 =?utf-8?B?cUFLNTR3QjNYNE5iSjF5MHdZUkY5MWRaSlM1VGVYUVZTVzJjQzhpUnVjd1JH?=
 =?utf-8?B?RUw4eEJOUVFPS2NGLzFqSW1lQTF3TFpVbzNZMmhRc2hLTTdHa1VwU0hNYkFC?=
 =?utf-8?B?Z1hUQ2JJYS84NTJjN0tzVWRiZExtUDQ0dndOUDRoY1ZDTTlCZktlS3A4cmxy?=
 =?utf-8?B?Rkptc2RHNDZIcGw0RU9IN0JZV3Bid1hoUHBsY1NMSnp4ZU80ZktoSDF2WFZx?=
 =?utf-8?B?MTF0NnJKVW5JMEdsa3ljbzVuM081UmQwZkJnb3FOZUxvaE1ObGxRdXVKQmVX?=
 =?utf-8?B?SldyU2hXaHRZdTJkVlQvK29OcnJTUllSRzVPNE5aZ0d6amdUUjNNQjVrSUR3?=
 =?utf-8?B?ajVnbTRycjcrczFZS0h1QlJJczhEUllEWnhGUnB6SytJMG5uWk1KV1A2SlE1?=
 =?utf-8?B?aGg4N1R0ODhWQ2pUUWJkTnZJUXA5LzVMZlBjY1NPdCtYMzd1WCtFR2tSVnVB?=
 =?utf-8?B?bStjYlJqeFBEV25lRVhrblE2bWVQcU5MY3lNTlhSaXVRdEdBaUk0OGJIZlpR?=
 =?utf-8?B?R1hrM0RuUUQyaE1XdUhnVXE3M3J3akxEc3B4ZHl3V1RZSUd6ZkoxeXFKQ241?=
 =?utf-8?B?Q2s2SEJuOU5RL0xkRTZWbGRNcEhYckJHa1MxOC9LVUZET3NQejhIYU82TDlv?=
 =?utf-8?B?U2Y5bjBtaWNwa0drMVVFa2ZhaHdqR1ZkN2dWRVI1UStYYS9KWFEwOWZMUVdY?=
 =?utf-8?B?OVA4ZkUyTXdnSTJYUVV4MWZQbE02TWNqdGJPUHAvWnVFaVRsOW5VbkgwMjFs?=
 =?utf-8?B?TjljNGY1YzhJWjJ1UjZCcWtNcnc2U0JDYmsvR2VRWnhQZ1AzcW1xL0dmM2Nq?=
 =?utf-8?B?SllmRmQxWlFlMGtiV29Eb0VuMGdGbDk2NDFEZXBBU1F4eUEzRityNUpHa0E0?=
 =?utf-8?B?bEVsN2ZZTE1CZUM3VzFLbGp6MmpPclpTQkxPVmo4WXlpVUNLQWt1ZW9sZTlv?=
 =?utf-8?B?WnlLbHRZR1ZwcC9ZZmt4SDRINEdiR25VTEVzckRKZk55eGtzMDQ5YUYyYzY1?=
 =?utf-8?B?UkxjV01DRGgrUHZORXZIdWtXbmgwTXNJc1pEcVJzeGhaYVA2a2NBSU5SNXVV?=
 =?utf-8?B?K2RCeHVBMkI1Y2JNNVRYUzBNeWJ1UndyclZHUEp1enBpVkdoZFFVcloveUN0?=
 =?utf-8?B?ZlJFQUhPdjZoeGtXeURIS1c0dEU1L2J2T1c2bkI2NWsxZEtBTUVwZDhraXpT?=
 =?utf-8?B?eFJjd2xrYyswazhwd01XY1JnZkJiUGM4cG5Od05YUHBYNXZqWDlIRm52MG56?=
 =?utf-8?B?U3dFYzd2MTZmbTUwcGhvVlZXdysra3pTQm40bkl1K1BNMjlLdnRQYUtRQW1k?=
 =?utf-8?B?WG9oeVVadkplemZyWXc2c0hRYTBQd3lTdTBrRHZyNGppek94WVNabzd1OUhS?=
 =?utf-8?B?ZlA5bDM2Y3liZmM1a2dSelZSRzVwRlV6bmp6VUNQV3g5L3N0Q2c2NlA0RTg5?=
 =?utf-8?B?QkNyNEZsUS9JSzhKZStORUZhMXg3WENMMmRUNk9wbGxJY2RZd1l0aE9JQzFv?=
 =?utf-8?B?OGFDelh4VjdDenlLTng4RG1OM21oalpCUE85L2srZXNSYXVYUmU3NHlOTHlw?=
 =?utf-8?B?S0pLUkE4WmYwY2E3RFNCU1pFeGtYS3NycG9Zb3V1Y3F3RlcyeXJkKzhXblBJ?=
 =?utf-8?B?ajJBbDA0R2pGMnkwRHVQTVFTUXdjdmVYK2Rra1FiQk9yN3o4R3B6S0gwQUVZ?=
 =?utf-8?B?Rk9NMU5iK1p2VXBSTjl5YTZYd1laT3pXYTZVMVZza0Z4Vk9YQS9WTTFFYyt4?=
 =?utf-8?B?UEo4R0JjMXRYVzNaMnFJcUdPaGZROHMvbFNMVFpMNytTdkpOZHFxNDlTbmtT?=
 =?utf-8?B?THN1NUg3N1RFYjV5aGM5N2Z4aFdQWHZaWEZabjhRTCtNeTRxS0RsOUxRcVVt?=
 =?utf-8?Q?jLgCDlmMAPrpFDUaX8SBFPgiB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e67b6c-095d-480d-4381-08ddec0352aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 22:35:17.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klc1ojWHAfPXQhXi7x0XukEurzzLdi/MB+jaJGQPr9OxZtjVyTFkGwryU2zZPFSQFXvyEmVY1I2px5RVv0NOWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669

On 9/2/25 22:46, Andrew Jeffery wrote:

> External email: Use caution opening links or attachments
>
>
> Hi Donald,
>
> Sorry for the delay.
>
> On Fri, 2025-08-15 at 15:43 -0700, Donald Shannon wrote:
>> This is an Aspeed AST2600 based unit testing platform for GB200.
>> UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
>> differences, additional gpio expanders, and voltage regulator gating
>> some devices.
>>
>> Reference to Ast2600 SOC [1].
>> Reference to Blackwell GB200NVL Platform [2].
>>
>> Link: https://www.aspeedtech.com/server_ast2600/ [1]
>> Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
>> Signed-off-by: Donald Shannon <donalds@nvidia.com>
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |    1 +
>>   .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1030 +++++++++++++++++
>>   2 files changed, 1031 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts
>>
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>> index aba7451ab749..37edc4625a9f 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>>
> *snip*
>
>> +&gpio0 {
>> +       gpio-line-names =
>> +               /*A0-A7*/ "", "", "", "", "", "", "", "",
>> +               /*B0-B7*/ "", "", "", "", "", "", "", "",
>> +               /*C0-C7*/ "SGPIO_I2C_MUX_SEL-O", "", "", "", "", "", "", "",
>> +               /*D0-D7*/ "", "", "", "UART1_MUX_SEL-O", "", "FPGA_PEX_RST_L-O", "", "",
>> +               /*E0-E7*/ "RTL8221_PHY_RST_L-O", "RTL8211_PHY_INT_L-I", "", "UART3_MUX_SEL-O",
>> +                                       "", "", "", "SGPIO_BMC_EN-O",
>> +               /*F0-F7*/ "", "", "", "", "", "", "", "",
>> +               /*G0-G7*/ "", "", "", "", "", "", "", "",
>> +               /*H0-H7*/ "", "", "", "", "", "", "", "",
>> +               /*I0-I7*/ "", "", "", "", "", "QSPI2_RST_L-O", "GLOBAL_WP_BMC-O", "BMC_DDR4_TEN-O",
>> +               /*J0-J7*/ "", "", "", "", "", "", "", "",
>> +               /*K0-K7*/ "", "", "", "", "", "", "", "",
>> +               /*L0-L7*/ "", "", "", "", "", "", "", "",
>> +               /*M0-M7*/ "PCIE_EP_RST_EN-O", "BMC_FRU_WP-O", "FPGA_RST_L-O", "STBY_POWER_EN-O",
>> +                                       "STBY_POWER_PG-I", "PCIE_EP_RST_L-O", "", "",
>> +               /*N0-N7*/ "", "", "", "", "", "", "", "",
>> +               /*O0-O7*/ "", "", "", "", "", "", "", "",
>> +               /*P0-P7*/ "", "", "", "", "", "", "", "",
>> +               /*Q0-Q7*/ "", "", "", "", "", "", "", "",
>> +               /*R0-R7*/ "", "", "", "", "", "", "", "",
>> +               /*S0-S7*/ "", "", "", "", "", "", "", "",
>> +               /*T0-T7*/ "", "", "", "", "", "", "", "",
>> +               /*U0-U7*/ "", "", "", "", "", "", "", "",
>> +               /*V0-V7*/ "AP_EROT_REQ-O", "EROT_AP_GNT-I", "", "","PCB_TEMP_ALERT-I", "","", "",
>> +               /*W0-W7*/ "", "", "", "", "", "", "", "",
>> +               /*X0-X7*/ "", "", "TPM_MUX_SEL-O", "", "", "", "", "",
>> +               /*Y0-Y7*/ "", "", "", "EMMC_RST-O", "","", "", "",
>> +               /*Z0-Z7*/ "BMC_READY-O","", "", "", "", "", "", "";
>> +};
>> +
>> +&gpio1 {
>> +       /* 36 1.8V GPIOs */
>> +       gpio-line-names =
>> +               /*A0-A7*/ "", "", "", "", "", "", "", "",
>> +               /*B0-B7*/ "", "", "", "", "", "", "IO_EXPANDER_INT_L-I","",
>> +               /*C0-C7*/ "", "", "", "", "", "", "", "",
>> +               /*D0-D7*/ "", "", "", "", "", "", "SPI_HOST_TPM_RST_L-O", "SPI_BMC_FPGA_INT_L-I",
>> +               /*E0-E7*/ "", "", "", "", "", "", "", "";
>> +};
>> +
>> +&sgpiom0 {
> So the style guide asks the referenced nodes to be ordered either
> alphabetically, or in DTSI order[1] (which should be unit-address
> order).
>
> [1]: https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes
>
> What we have to the quoted section above isn't in alphabetical order.
> To this point it was DTSI order, but that breaks here too.
>
> My preference is that nodes in the DTS referencing the DTSI are
> alphabetical (as we can't see the unit address for ordering). Can you
> please fix it?
>
> You mention in your cover letter that ordering was addressed in v3 -
> did we lose that along the way?
>
> *snip*
>
>> +
>> +&uart_routing { };
> Drop this?
>
> Cheers,
>
> Andrew

Hi Andrew,

Thank you. I will switch to alphabetical order and remove uart_routing.

Thanks,

Don


