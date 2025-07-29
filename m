Return-Path: <linux-kernel+bounces-749468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77783B14EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0603BAD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6418DF89;
	Tue, 29 Jul 2025 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wg1+696d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="APVjrKPs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B44C98
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797060; cv=fail; b=CDAmb9UmGwMLXHRGu7h2OY6wPI2jg4Jpj+xkNlQo/Wthgpbq93crGjGVMRUD59hQaJxxTIQf740QMXEbl9oxWr1XfwBp9KwkDhe6MG80xJ/TF9EWNAvH7gwmTFHvUffbCsu329Zx54rHlQcO/7Uh8JF23psevDy6aifKMomp7Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797060; c=relaxed/simple;
	bh=bS+U1pm6BpzNrRfoUtU7l23ox79pHUTzSfh25lc40PU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jef3qq24zI8p1ri/Lbv1MGXMq/lIikh839GShZM9u8R/iE5CQijVL/wxd3ZajVKQIQWLAHdN7jygSUgwMfGzEWpKWEyroCqQ06gVEYFhDkMUZtbGSzJxaKYJu7yUkfEmZvx5g5zPC0f/L7WNoLSkgyELWDnM9TpH7O9TWWMK/sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wg1+696d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=APVjrKPs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDg71s023053;
	Tue, 29 Jul 2025 13:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bzepM6U93F/kPBGX7pOr/cQE1ZhHT1iae39sFh/9PvQ=; b=
	Wg1+696dUiLEu61amWtfbNx65WJ7+ivpI3mjHROQxuORNQNcNRNcMRqFTzHovf6f
	G9Sd3zP1/mqFGYuf4HibvxLK4l6JCxgO8jGVKZrZbCIss7KgCdiapXaeFnv1XIGL
	dNxLSvTlcE7viI54SeKsMqmDghlCBKDVNGIUo6ivGGiKyx2wKeQLCBpFByaJyIAH
	sZ5PYvTYCvLE1PsbpJnEZqROqwc7VTLhyHBndQf5bNRMH4F/uf/Lq3328AUbQXjZ
	vGb/xgVJDUt5c5VfqIFiW0pxVaDAkcKJ05aR5n30xipEsaIV8T0xKlTaUGt2fLlI
	TPOoRyS6jJedozXr95dImA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4e7tv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:50:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TCGYGi003128;
	Tue, 29 Jul 2025 13:50:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9y0uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PehNdMRYZWpMktD/Be7RRUZm9wW73kRdQ7xz6CrYrJNxnSOAvG/iqP6gN3jPX2AtngX1z0GYYgrOyTioaVrV6fBKn/PWXWQjSMkilWUJnlDP92Z6mOGgwMm4JFyMpkWTuGFPXWnC+SyjpN80v0o/fKsf0NJ2JibIlmKRom1iAPxwCFQpOFQo+C24Z2Kjz9kaW0k2EoavtiZTR0yk2prrMulyB+G27gvyZ5nVNTb7QHO/yzG4XzfXLMhYlRCDcBL+b0/DHOyuT4ihajkOGDX2R1CCJdA1M2568Y6OeagOjvcvwZUohtTXfSGWM71kz8ffDRTEuAw4IJnqCt87oGeRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzepM6U93F/kPBGX7pOr/cQE1ZhHT1iae39sFh/9PvQ=;
 b=chBmqDZP8sunvKXCsqARVuuApdZpo47viQ+tPp6qtzlsyLkrTK/mG9D/vtc+BxVu8CY2Dmftv2vw1nJSwNBxPyLObP9r8ZmmxL3SK33nz3QRr033P8RrHhKq8ylgI741zq/sr+NmPTelmXL33SS43Zw0eZy6U0XzM81ULdqjiR5yeXV8oXu3G1aX3Nmtqrrt3IK3Kad3qv7xQ61rFoDeia9YajA8ix8ucnAwWQHTg2zH2jtlR8p02Emd9LsgzXvkNTwJaaUs+FXfeeIulUU0asZuucONt9aVI23nuDqXqoD02MKExua33GH2y1stzv9T6rplm/scytiRTC243HzODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzepM6U93F/kPBGX7pOr/cQE1ZhHT1iae39sFh/9PvQ=;
 b=APVjrKPsmO+TmTt5+Ov9JLX5TKlyAJqBT3UNbwl/Sh+sHrEq88G+bExlD/xjNFzVgA7ewaBIQrnDIM/sWdneT93UXZ4mT4PDbHhsUTYE/KjMjf9vGWQLwQm0JowIcjm6S1kklxU9rNkb7qemosIpI2VefYSixTK9h5/BruFMxx0=
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d) by PH7PR10MB6132.namprd10.prod.outlook.com
 (2603:10b6:510:1f4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 13:50:20 +0000
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::731a:2be4:175e:5d0b]) by DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::731a:2be4:175e:5d0b%2]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 13:50:20 +0000
Message-ID: <901162ef-e607-4db3-976b-33b81e322c6b@oracle.com>
Date: Tue, 29 Jul 2025 08:50:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix metapage reference count leak in dbAllocCtl
To: Zheng Yu <zheng.yu@northwestern.edu>
Cc: "eadavis@qq.com" <eadavis@qq.com>,
        "rand.sec96@gmail.com" <rand.sec96@gmail.com>,
        "aha310510@gmail.com" <aha310510@gmail.com>,
        "niharchaithanya@gmail.com" <niharchaithanya@gmail.com>,
        "kovalev@altlinux.org" <kovalev@altlinux.org>,
        "jfs-discussion@lists.sourceforge.net"
 <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BL0PR05MB467408AB092885950559B422FF25A@BL0PR05MB4674.namprd05.prod.outlook.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <BL0PR05MB467408AB092885950559B422FF25A@BL0PR05MB4674.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::20) To DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF35CFB4DBF:EE_|PH7PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d0f9ab-9846-4f2c-5759-08ddcea6db50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXY0b3dVMFpCYU54Vk9tR3BUczBhZkY3SXBxWGFHQ0Y0dXJoVFd0VEw5Um1w?=
 =?utf-8?B?UVIrTFpHbTJhbGFialRRR0ZJR1l6dkcycGMwaWc4a0pDT0R6dkNEcjNUV0pG?=
 =?utf-8?B?WjBOb0Z0RGNIZW1KMFZJd0hqTzA1NDd0eENVY2tLSU9xTUlLYW5iV3dMWlBF?=
 =?utf-8?B?SDh4WVY1NWZWWXh2SzVGcGZ6cnRMR3J2eGdGb2lYb0s0MVlvTzRjZTlOWlVt?=
 =?utf-8?B?YmRwcjJRRnU1VFJWaWRoa2FZcDBoMnB2ejNEZ1BVK3o2NFNnWFNtTTVGajdN?=
 =?utf-8?B?VnRBZDRZZmFsdXNmYjJQNU9XZWF5VGpZb3JHNzV5ZjZBSW1VVGFSVnhmQlRK?=
 =?utf-8?B?RGY5NzJXdmtMOThGUlFIWVJkTjVrV2txY2RVUlkrQVl2TEllSGJFZkhlSU9h?=
 =?utf-8?B?c0VHMmNnWGlmLzRUQXRJNFRsR2RvTzViZ3RXb2pVVytNUHlFendnTlI2Nk9N?=
 =?utf-8?B?bXY1THFFV3hvS1N5ek1qUXhQcU9nRVR3SEFrcU5GdlVYTWZibWd3Nis5M05j?=
 =?utf-8?B?MDViZDk0NWpHT29nTFY4YWRPdjRkWkJtNFk3MWJNeWV5TVhYQmEydllsQVdx?=
 =?utf-8?B?QlVWdEV3YUR6dGwvQUlmNGpTM0JGM3RnQnB2WDFLUUJXUWNvV3BOVXJRdFVE?=
 =?utf-8?B?ZUdsdUZzU1A0MlhNdWFKYVh6QVA0d2N4VWVxbVVoaWJRajZtYjZhWHdEeDRo?=
 =?utf-8?B?VStoUURNSWR4cXdNWXR4UzRZbXNFVzAvZERZOW9tN3p5dHVKbFZuK0JVQ2kv?=
 =?utf-8?B?SXVudmFidkJQUHlveFBDMzhldTlLUTNjd1Eybkg3bFVBRTQyNEhia2Z6a1ho?=
 =?utf-8?B?blpoWVZ3SmVqTXpzKzN4dGFNZ0F6akJvN1h2TDBhajhoQjVjMFg1OU5QWW0r?=
 =?utf-8?B?YjhhQUUxTEFabnhGT3oxeG9yM0xsWlpQRTJwUWdEMXMxdXpHdC95WGZhcTNt?=
 =?utf-8?B?ekpMZldjRzJIVzFtbjdKYnVxTkF0YzFwbEtvQ2NUaXpDNEpsdTgybDd2eVpq?=
 =?utf-8?B?SDYrUktQVHdpRG1yTjdqM0ZwOXRhemt1ZjJFMm52QzZaaGcyUjd0MSt5eHN1?=
 =?utf-8?B?MWsvRm9jVFl4RTdncG12RlAzcFlyS2FVdXowcWsyam5hTEVxS2FUbm82TTZR?=
 =?utf-8?B?Ym1zQ0NYRlFydkZuS0tZTU83U3RQSllCRzE5cnB6VXc3N0hYdDQwaXhpWkox?=
 =?utf-8?B?TEYwNzNsU2dlanorUzNBdTVJQzhKV2R0N2t4b29Yb3lXU3d2TzVuWnhSai9a?=
 =?utf-8?B?MzlndEJqL3d5UU84ZGxuZWo4Kys3SUw2RGIyb2YwSE9obURiVXgzdFdTMEUv?=
 =?utf-8?B?V1kvcTR2bmdxYUhWVGI5aHpPS1RKS2NpcDd1S08zeDZobFltR1lUU1dPc0sw?=
 =?utf-8?B?bkRibG9VbGVTUWxnenpVWFVsczhJbEEvTUMyQnM5RlRicjJYWlk2TzU4RnFK?=
 =?utf-8?B?ZWpBdEJZTm9qWHRhaEFXek5FSlZEdHRGSGFjNFlHd05wWUN6R1RiMlRRMm5H?=
 =?utf-8?B?aCtWUVppbkJuRzMzUzYwQlVGamZCc3Q3OUNjbDZoT0NVUm5rV2pqTlFaQjE3?=
 =?utf-8?B?MWt5a0ZjWWVkVTBWUzdUc1V0MmZNU2Y5ZjR3QVpCYVdJVkhnOHpXT2RFQ0Jk?=
 =?utf-8?B?Tm56R1NvTEtpTmFOZXdGVk1sWSs5NDBIWG9qdWRxejFBeFYwSnp6YkV6eGFZ?=
 =?utf-8?B?K3drZUo2TkRLZXJML3l0ZTdQWmJZN0pCeVQwdG91TnJvYmZSY0p5T0FVbTlB?=
 =?utf-8?B?WmZHOGJiSGhIL2xQM0orb1B3L3ZSRUFaV0U3c0RSblJWbzVCUjVuOStTaXFk?=
 =?utf-8?B?enBnMDFpQVF2OUdBOFNUSlFnU0dvVjI3aUhpK2laQzduNHpYNXlGeTFmUTJN?=
 =?utf-8?B?V3JWWkx2dFpXL0oycTRPbVNTRXA1MTJwT3dPTTBZVU50MjdkTndLckpEK0Jw?=
 =?utf-8?Q?8CbktZtrUGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF35CFB4DBF.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnFVZk42Um4yTzlSV0dneldHaVVJTXRvZk1LRmZ6bmRGUDZiR0M2c3pYazA5?=
 =?utf-8?B?YWVNcW5ZaVdLb20rblpJVU04TkpQNTZZUHg3RVhybDF6a3RXTUxZRHUxUHlX?=
 =?utf-8?B?anlFOGM3UWZFVW50TzRVODd4TEdqZnlyanpmbURXR0JnamNFSVRFdGJyaDVa?=
 =?utf-8?B?d24rSE5weEczb3ZNKzhkOTIyRXUvNndqa2wvL0VZa0JaVGpIZGhoK1FYYTYz?=
 =?utf-8?B?bEVYdUdVVzNhQnpFcmVqTHRBUVlMVUNkbUVCbEx5UnVzaFNJbmpUWjJDTThF?=
 =?utf-8?B?NzFFakxSNnRKRm5FN2cyMWt2dnRaeHR4MDVTZWZtU1BkN2lDYTBVTU9FU2xO?=
 =?utf-8?B?c2JNalpuTVVtRU9BY1lEVUJzdW12QmR0Zis1MUF0YmhmTnhhUXVwazh0Yklo?=
 =?utf-8?B?QVNZSFEvaWVaSnpwdHlrZ2NkUW5nQTU4elRmUnpOeGl2a3psaXRjWnAxZFU1?=
 =?utf-8?B?SmRtOXdFeElrdXhoaWJpdTBxRHpwU1dDcVh1NDdjbllOUmZmc3ZCTmpJOEpj?=
 =?utf-8?B?eWx4MU5TWXBrakR5cE8zTDZ4MGwzMVBOdlhOM09pajlRR3FaOUV6ZVlheVB1?=
 =?utf-8?B?cmE4TFlQcnk4TUZXZ1lrTnQybzl1cm1rdkJBUlA1bG05Zmp6Y1p1NUlCV3hZ?=
 =?utf-8?B?QjdOb2cxTWVKeWlSd2RUeG02RlhCV3p2YzNyelQ3a0h2TVlhSkxIeTY0bFpY?=
 =?utf-8?B?RUxtQjlzelJoK1lsWmJ0QlRCNkp5YlVoQUI2R1VWM3FrSFpmcDdOck9qNGFH?=
 =?utf-8?B?SU5BRm9hVG5UZm03NWgrWkZBWTdSWXg3eEh4eVNFQ2Z1YzZva0wvaWRDbW9r?=
 =?utf-8?B?Rk5aOUZqUS95ZlFYY3FySDhmMjQ2VmZHK1VyNDkxNk9NanhlOHI3QkhRck9W?=
 =?utf-8?B?ekJ6Y3hwSm5yT1RQK3ZRZmRNOVk3SVJZU01BMUhjdGNHUWJCbnpaRlY1NGRL?=
 =?utf-8?B?VFhQTGlFNXQyRit5b0ttODBNc0FZWmJvWFJyM3RVVEdKVlFQR0htV3RsVHFz?=
 =?utf-8?B?ZG9wbzArZVNPWTB5aHY0c1lhTFRuK1pzcHRKaStWV0tkcW5VL3EzZERvMVlN?=
 =?utf-8?B?Y3lvYUs2VjJHc2dWU1FhNnVUTURJRHFQNTEzUE5HNzBweGp3SEtySjJTNUJ3?=
 =?utf-8?B?cUs5cGZvRDYrdERDTVU4S1Z3bk9mSHVzcFhOWjNqVEppN3pwdHJBRExLZ29v?=
 =?utf-8?B?UW1QUUpUSllDeFpzU0RBMmlUZnl5VmtjR1VuOU11VHNzR1AxUTNvTWJwRkl3?=
 =?utf-8?B?eDhqNmx1RUF3R3U3a2NSVWFGamdXWGExM09DWDdFcnlrVENpalg0enVDWXRW?=
 =?utf-8?B?ZjJyTlpJb0pJK3J6RkdabFBOdk9Gdmc5R2FmMlZUeUpUc0RibkxXbEc4eFkr?=
 =?utf-8?B?anBzM2pidlEzNlFlZE5WQ3dCMTM0N254SjlGODRhV0l3MC9CNzU3dzdydjdM?=
 =?utf-8?B?VnZ2Z0w1bUlFaDVMVHpxQW1ndTEwMWNBeDFQeUxNT0dmUUhSVnl6TzQ0RjAr?=
 =?utf-8?B?TjRNVExyRlNNYzhlamhHU3JIQ3JZNlFiSTRIdnJRRitFRDYvZVpBT2hYRE9B?=
 =?utf-8?B?YmJOeS9HenpBWG9jaWUxTUlSNEh0MnAvOGxUak50VDhydzVvdW9yUmhjeXBu?=
 =?utf-8?B?aU1Zdmt4OHJPaWtUMlN1WGdtbnhvMVh4Y0NCZXNLcGpSSUdQVkxvN2FkTUV3?=
 =?utf-8?B?c2xwUlAxUjdDOEhOOTR1Zk02ZXQvWGZPNUxoOTlFMDhuc1JOZmV6SDZqU3Qw?=
 =?utf-8?B?aUk5RENiZkZrSDZHQWR4SlFRa1BmV2hWclczVnFzb2d4K2hGUFljK01qN1BX?=
 =?utf-8?B?TGZ1bWhjVlYxTmxWczJkZzl1VkNQcHp3dXhFQnllci9nSmJKZ21yUTNCMDNo?=
 =?utf-8?B?Tk0wZE5laEpwVUJLQUxTQUZzQ2daMENLZGg1LytEenVEZTUxNnJnOCt5OEti?=
 =?utf-8?B?WWVWOENqRnhxVG45YUFjVnNITUVxbEpiSEFTaXYvVXlzMUNlNCtlb1hDZkdz?=
 =?utf-8?B?R00ra0owUTlXdGc3TDdiaFNMVzA0a29ZeEdkT0QxaXg3L2ZSeWRZS0JJaG5y?=
 =?utf-8?B?OTRWSHh0Sndrc21sVDJQYVZUZlpSbGJhNlVYR3E1aDVYTVI5ZWVsT3Nscm9D?=
 =?utf-8?B?alAxekJCNHVoQ0tOZ1pWZGYzNThaeHZocm05YjZjZWlwLzVNZjIvWitQOHRO?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RZmbYPS3zkSnfph3x6WPb7/AlOaa/0Ey/khxpB7U0RCsbPep+uQTUa26iKr17HQd4rReLDyTH0sCgCgAj607GcIqsoOObZHQALh+evCntLnovf7dKq+M7yWPYpqqocN6NfsgZkjIVMJPAvPje+/6cHMyAQGne8qZSDWftLl924LYkxjRJVG/fhvCowgltFh3QBx/97F/8KdbSLkTf3kjP7MdITfi4bviTrA5ldffHb3kxwVh87YRMt8E0M8ueWSSJb47Ahhy69Os2JCrRM77vluEZzTPKbJtm5GIOc4V9KS6TB5rMsqCEyuMRTJ9gBQq7vIzNoPCtZIqikOSocodSFz/nKWYPqRqXvTdscGfhuefNiY2YUXaQdJG16e+AQYGQZjvRGqN8DHGoapDGKPQ2USwGngp/rxbgK62roP6+1VL3tjwxWhDAvTmKJOSqp4T9zSsiGLNNTw9QxyKqwv9N3vGYJHPiCgaYZfOicG+BGDPEqrY5gbO4ihNsWfBSlfYJBcKl02Ge9Euri6Glv1K+BzE4jt5k5xadhjoCBWQeN17/HWCgvI7l3HpIa/Ysuf8LBGVAuq1209yf+TXMMkktullQSpBBNjBgnS9/V9KAME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d0f9ab-9846-4f2c-5759-08ddcea6db50
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF35CFB4DBF.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:50:20.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YielqbSBxWk9g+iN3t6dPeli6RhV32vhF+5MUBqwY9QmS7MPMbZ+ltXtzKp5W3InHUwjgM/dT9uOcpT1LiO9pwIYRem3bh68Om6AZ9dXffA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290107
X-Proofpoint-ORIG-GUID: PJ820Gr3Z3RonUOlzaTjRZGOB_vzg2hh
X-Proofpoint-GUID: PJ820Gr3Z3RonUOlzaTjRZGOB_vzg2hh
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=6888d19f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=lurtKhfgiBJYb_ramywA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNyBTYWx0ZWRfX/Q0GHkKMVBra
 TabQDBU1LX8vRXsVMKTYV8WdDprqAKK86gNyrlWq1GzItL78XV2p3yOmJRCyq11oyyILg9uIPah
 BVfpUYuhgA4XfcODM9BcNJdREJnscRdheNWRpXFR275lTSQJh3SSFm97okpqYDLRguHkLtOZkGE
 xWdKY8Zj5z7rqXvepoEorpR9qhWzIOxBnxQdt5uQMqagoz6Cbvm9ALmcahUB12yK/8JuEoGGRWd
 CcFFPBYKPqNvZAc25TWYVMspw9B08nir6pMEBjfSxPhYgc9CC4iK9diRKAvobfJGfDg74+OximN
 amVV+UGIaC3ojQJEcBJoT7LQ79IAe9dt3duBwEFxw7QQwtIp3wj7v/iVPZHBw5Udu0qIt12w1s5
 exoOU+1xEwcf34kFQ4Ygj6rJOnay3CMUMZJXFkTvsLRGg0AfgFY9XZiCHsqvQX27GwQmj1EB

On 7/28/25 8:22PM, Zheng Yu wrote:
> In dbAllocCtl(), read_metapage() increases the reference count of the
> metapage. However, when dp->tree.budmin < 0, the function returns -EIO
> without calling release_metapage() to decrease the reference count,
> leading to a memory leak.
> 
> Add release_metapage(mp) before the error return to properly manage
> the metapage reference count and prevent the leak.

Thanks for catching this.

> 
> Fixes: 51a203470f502a64a3da8dcea51c4748e8267a6c ("jfs: fix shift-out-of-bounds in dbSplit")

The correct commit is a5f5e4698f8abbb25fe4959814093fb5bfa1aa9d. I'm 
guessing the above is from one of the stable branches

Also, I'm fixing up the whitespace. You have spaces instead of tabs.

Applying and testing this.

Thanks!

Shaggy
> 
> Signed-off-by: Zheng Yu <zheng.yu@northwestern.edu>
> ---
>   fs/jfs/jfs_dmap.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 35e063c9f3a4..5a877261c3fe 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -1809,8 +1809,10 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
>                           return -EIO;
>                   dp = (struct dmap *) mp->data;
>   
> -               if (dp->tree.budmin < 0)
> +               if (dp->tree.budmin < 0) {
> +                       release_metapage(mp);
>                           return -EIO;
> +               }
>   
>                   /* try to allocate the blocks.
>                    */
> --
> 2.43.0


