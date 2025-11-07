Return-Path: <linux-kernel+bounces-890107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D445DC3F3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC83B32F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703A304BB7;
	Fri,  7 Nov 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OyWOLaok"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA38304BD5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508665; cv=fail; b=hHpbgPbB4VJmCN4Xa6VV3JyRsS9veQLJfeE1p7a6/zzoFTs4zsLxQEUiPCHIne2hmwaNYPoZnn1dsH6nRlfm+jgnuP5LWZt/dLuvT0RYHPiM8htehgArQDzKbl68vVAFps/EFF7c8WA334JZQ2+4aGIivlDrBKHiad55OnNSNZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508665; c=relaxed/simple;
	bh=UuhgXrWNT1daNmS+r+dlaPJjj7SpyjEb3w4K5GOvYSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGimJcZoohMGfPhh9shCqHzBnTnN6UKrzEu6lhl94l2qDKWNRdPSMkYl59o5ZBIVGy0mXrZ5CT4tJhtDUG0LCnfOI2C1nG/LC0UBgXpdrguUBrWQr6tl9E3w8HAb1jB5AsLdALflAmz/B/GAMu5gk7Pq59Mu3xW5hDY4DQI0ClU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OyWOLaok; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pfdgzq1NFaayeHO2kB/SGoNky8m8FUsSHm80onIJUDnVhLQjEgFfU6KxGf17ZcHgTIyyRxl8vUoMuA09savxi6QOEXo/K2+UrlSz2N+IZhD7uH7O+reDy8k6eUxkzqoUar1QOo0mXYGPyG7+iEcUzm61pq0r0deRA+aZdgtbX9kS1LZgpXrI0ORXVWK1XbmGviuck0DcNHxbRckdqkvminxE9S9ipRqwPTk8vZZPFBMNzOlnCrHvGrwxuPk8lBBcUcVsDoJY295iB2ueH7rnPLYuozXKU9HO5eoDc+WZRq5HpVvcz00N99+ywfHg3r2Ktjrlv/z1znNKmlDrCLeXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuOt7SPmKyrZANWUakXDKdLfXKMFRGJo1XVY2d1SGxU=;
 b=G04tDvIUmVQ4Oxw2btjpcq9r5D/4/ofQaGLz/FCMPFl4dBfnk/vHW3rB5RHFJMQU8gXjNCFokwD4xeIVi+D9LzRoadZDnP0A6DQ/5ZfvHRUHzn7z5H9voiF9Atoeu1ZOYcGj2r8SNxQwN8bWnl4wTAlfcNcaa43hgzpA0nVEWDsIQec36JYRmS1sG5+/Co64ZsP15QwpDvm9tDxKp9oyJCupZSj7Oy2etoqMue5xeacMHOkUBMeGDU1HEEuHTsn8kZ9LFSqx4No4+7Y1tYcCIKgwhOzAr50tHJUto6e9jAMRhC1gszkzCF3NGLdQlRaeA3CT548nstWul3Y7AYGZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuOt7SPmKyrZANWUakXDKdLfXKMFRGJo1XVY2d1SGxU=;
 b=OyWOLaokdpNWd0Q9PMhiVkN/hkhomt4j+BVJa3stoLeUC5cWpDD56x0h8Mu9BfkqnYW/BjLTIrCKWNkoIUp8oZ/Tgb7d4VycMFsG+eURA1KljcaUr6ZJQ1slwy5B3geNK+TV7Ul8fNX0hbNAAdFKhO2ST7cLyD3GFDr6lunWoe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:44:20 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 09:44:20 +0000
Message-ID: <bff871c2-8951-4b29-b420-280c4cde9f97@amd.com>
Date: Fri, 7 Nov 2025 15:14:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
To: Yang Shi <shy828301@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 zokeefe@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
 <CAHbLzkqvXsFfziYU6A_LXfF2UQHkmNHqyT05P+dTav3mi4b0hA@mail.gmail.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <CAHbLzkqvXsFfziYU6A_LXfF2UQHkmNHqyT05P+dTav3mi4b0hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::19) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ed6d42-7671-4b3b-afba-08de1de239a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0pycTZhckpiWDhsMDVlaVRVU2o2anRMV1UvNEwzTHZ0Ty9wUzcyVmpqQ01O?=
 =?utf-8?B?WFNkUGNKQXpUbjgyMXptZkpLbjZaeXNCRDhwcWFiQURXdGN5c2wyVTVCV2Q2?=
 =?utf-8?B?Rm1CWFhyeFhPcXpxcFJYbGlGTGVodTJwQWxpT1RQa3htM3ZVbkN3cVdnK2NI?=
 =?utf-8?B?b3ByTUNZdHNmd1JGdElSWUxxaXNxU1grbnBKWVl5VFZIN015a0VDdDI0dWtW?=
 =?utf-8?B?V0J3MWQ1OWliVWgxSThBbmtJYnVacU5ybmZEYk53c1BkMTUraG8ydEk1UlZ6?=
 =?utf-8?B?THAxalRRRUVNNFJoNjA1amdDdjltRnJXMTdkb0lPVGZUdGJENWc3MDlFVENU?=
 =?utf-8?B?c1dEdTZIS3FrVXQrc0tvNldwUlphK0NPdmNHODdZckplOWZBMGtFQlpsSmV4?=
 =?utf-8?B?bnBncjYycVVUd2lYektNTm1TN2N2NzRyU2V4T2RrUTExMFY4ak5vQlJtT0ll?=
 =?utf-8?B?cGwyUjJSOXl5aDY4QUpHdnpWUE9TMWRyb0dUUk5HcElMKzRxbmYzeDY2U21S?=
 =?utf-8?B?NHkxMGlCV3dhbUY4VjFmZEpZdmEyd1JVK3BEN1E2K1Y2ckk1Vm1mcWE0ZkZw?=
 =?utf-8?B?Rnppb1VtY3E3elVBTTJUcXo5U1A4Zi9kZzNKSU1IKzJncVlFeXQxcDhsUkFN?=
 =?utf-8?B?WDF5NjJqYWYzQ3cvOWhWZzR2RDl6N1hsYVgrczFYaUNWbkNuNC9UMHQrRmwz?=
 =?utf-8?B?eGxqZU54b2V0ZE1udDEzRDd6Lzl0d1VrL1czSUQ0UzZ6UHNqVzJCZnZONVFo?=
 =?utf-8?B?aWRwVlExZHA4NVcreWFiVXQ5RHN2NEM3RWZDK0k3S2Z6OURzazlkV1diZUcv?=
 =?utf-8?B?bDZPZ09XNVJGVWI4MEE5Y0ZXRGR3L1lFc1dFZnNBTVc1YTllbFg3OVE1UWJl?=
 =?utf-8?B?YVdvK3NkeTliV3djZ2NKS2FVakd1dDFBQlh0N05IQkRGUnhYc3ZjQWQyQXRH?=
 =?utf-8?B?TG9JdDVUNlVRY0FmcDNLY3IrcFNyMU92WVlQRUJpaUY0dEVaSzh1ZVVpblBo?=
 =?utf-8?B?VXlhTXBKSXdlVjBKLzBUQTRwZnBuVlFjeUFzaFF5cytoUTd0aFdLUDQvZUZJ?=
 =?utf-8?B?STRGQjBBSFhBQngwOElHYkhubU5VQ1c3d3Q4bm1oVUF6NitPTTZLSHdtc243?=
 =?utf-8?B?cFhkWEdjTEVFbWZlYVVkeGRZeWRSL21KSllHbGk5NDV3T3BSYW9CRG9uODN5?=
 =?utf-8?B?cHBvZUhlU0FCVmZFWWRwNjA0Z2U4cmlKaU1INkQ2VjlOQW9MOFYyNjVFVUlQ?=
 =?utf-8?B?V2JKTTZsWVloL29YMkd4ZEpCNVNFYW56bjUzd1NXTXNtcWpycTNXWHl3WFFx?=
 =?utf-8?B?NUYxcjV3d0ZUQzVnd1MydUEza0crRmZ1MlNLblZhL05McFg5Q3o1WVZJVkl2?=
 =?utf-8?B?a3ZZeE4rRjhwcjRmVTJuZjVEQUNjWk1CcHBlNktZODVsSHAwNW9RUFFpL3pG?=
 =?utf-8?B?ZEJjblJETi8xKzdNY3p1K1RiSG5UY2RQcytqdGNQeEtNTzBLWms5emdQRGhD?=
 =?utf-8?B?MVp1Q1JQbkJRdktaRzErczRYU21BdlRxR2x4U3RWSWpybk9mY2trL21rdXg2?=
 =?utf-8?B?UmlkVk9ncWxHWjNmKzJnNDFJUTArSnZRMXlob3F6Mi9LUUFEQytWOE9qSWpl?=
 =?utf-8?B?ZXY2QnVjSWhnZjlwWkJtMXpQeVp6UVpGR01TMXN2aVFPT2pzR3NrOVAzN09W?=
 =?utf-8?B?Q1pZL0U2Rjg5UTF4bGp2RmdqQ1cyU2hCRDlrTXR3aWN4YzE0UTEzNUJuaTVa?=
 =?utf-8?B?YUduZzNVUzdJZitMNy93QUNrNHFGWkRTYThsNWtBVkp6dCs5TFVjVDdVVXBo?=
 =?utf-8?B?MHhlZi9adkl5Sm5yYWdWblFxOFdjSGhuM3FSRU5Nc2ZYbjNqV01HRnFHKy9F?=
 =?utf-8?B?VEl5R2F2cEVGM0hIZFRrQlc2Zk40Mjd2UkxyT0FWSko0cWx4ODVYWXlYMkNr?=
 =?utf-8?Q?5Ox4Qf3f+e8l8ZUenIDClo7vbvxrKhqA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFHWjJSb05hMmtFNXIxdTBVanV2RGtTeFNJZ2h4SVgzYnY1djhEdWhWTVdu?=
 =?utf-8?B?WWZaQkY0Qm1URzZENEVXT0FwenFaUi9yNzN2a2VLaG9JYndZR2QwUldYc0hI?=
 =?utf-8?B?dXc3UXZBOW15Zy9yWFZFeWxNQ0NYSXFxVTIwQys1TkZFWTV5cW51YUgwVUFl?=
 =?utf-8?B?L2p5bUltSlBnL3dUWlVYYWJhSHRnd1ZUd0RjNUsxcCt0WVZoRFQ1NzlBYmVD?=
 =?utf-8?B?c043OFVLZlBGNkhqWUFhQVZqTHQ0a05XbEpQQUN6bzhaN3RhV2YzTXVaTEl4?=
 =?utf-8?B?UXp2QThKQXkrV2xUM1dac3VmamUxWEE5M0FMV0FiU2VnTzFNVlBYQnpJVU9v?=
 =?utf-8?B?N1JJUE14YU9BckF2dTgycURWRGgvdU5BbnVrZlovNGVFN2RHb2tTNXZGVUVT?=
 =?utf-8?B?d1Yyd3paS0dlSCtGaUp4blFYUWltcC92OUlCSkhMNlZ2NnQ1dFI3dDVkclZD?=
 =?utf-8?B?ci9DOGNJdVhnNmpmYzdHaUs0VVVMVlRyZjg4endkQVJucTJFQzVkV1RUUnp4?=
 =?utf-8?B?U3BEejBEZlVtT3RDMUFxYStrWkhpeWJFWnJOaEJOTTU1UTBNdUY0ckxwUjI1?=
 =?utf-8?B?Mk8vTXZaZU9IK2pGQmoxdDFPalNDdWNseFVoSkRZNDJMT0NGNkdQTTA1dENq?=
 =?utf-8?B?K25TUnVoVndMWFZjTWlqNEp0ZHRMcmFmZk1EbzNvQllNMjdwR0xSeCswTDd4?=
 =?utf-8?B?WE1DQjRXYXllWWo4RWtQbTlxR1V3YXlsNFU5YTlXYXk5ZExxYzFnOWpvVUhL?=
 =?utf-8?B?RWlCL1ZLVUUya1NnWnhweEszRVJMTlVEVEFodHJpbjYwM0NlUlNERFNmMTN6?=
 =?utf-8?B?eHVhSVRObHU0S2c0MnFaaFpJdHk1RFNCdzlaWnhKWWowQ2tqQXZoeURuNUxX?=
 =?utf-8?B?dUJkTUNUb1FobXc2WURId3h2STNuVmpGQ0JlKysweVJ4cG1sWHBJdFo5MDBm?=
 =?utf-8?B?MVpyaG5abGRibzdrODR2cmJKR1h1OWxmTm40Sng2VmdaT2xBWUtnY201Zm14?=
 =?utf-8?B?ZUxkQW16ZS9kbFl5UEJ1VTBKRkpocituNzE4bWYxZ3FGcHVrRmhkL1RRMEQv?=
 =?utf-8?B?YXUvVm1TbThQRUl3ZGloWmRlRUp5ZGNnUGFncEVCYk44blFvMU40SnlZWDRP?=
 =?utf-8?B?UEhDTnhBYWJzWWxnVDhvSmIyNHd4Y3VnZlFJQWpRMzM3WkwrdmlwaUhXNUMw?=
 =?utf-8?B?dStCUk1lcDZ6TTFkSWVpUFdoNVdUZ2wvKzFzWXBxU1dUZkoyQXBvdmpsTTNG?=
 =?utf-8?B?UGVjeWlXRnkzY1RIeXFWaGlteDFHMUpqYytRcW1VZ3UweWdrSGtXeVRoRUI4?=
 =?utf-8?B?bFFNRWZxNGM2THVVQTJqSVI4R01NNVd1R1pmTHdWNllRY0ZmaDhIQ3FTcUFP?=
 =?utf-8?B?QUIvUy9EN1hLblVVbmwwWVQ3WnY3am41anhOeDVmTFlPcEsrN0NxSmw5QVRB?=
 =?utf-8?B?eDhlSTlIeld1UHFXOCs1UndnNXdkRjQyYVpyL1djeHo3bERTQVRVcSsrUGRk?=
 =?utf-8?B?WGFkYmc4OVZWb0QzdzR3bXBNR0wzVkRyd1d1WE0xWFFObUxvZHVsaWFaM0Nv?=
 =?utf-8?B?eTdYOEhjNHVyZXNXN1Y2WlZlaThoc1dFUjFRZVpadVkxdUxBMGswRlNNaGth?=
 =?utf-8?B?eG9wV2FyRGx4ZzN3K1IxUFlGVlpqY1lzTC9WVkJFSHVjR1d3Ym9VaG5wVTlk?=
 =?utf-8?B?eTR0UTk3Nk91cGlMd055RmRCMjd0aDUwVTFnSk53WU9CZ1c1UWNPNWZsb1lx?=
 =?utf-8?B?TUFKREhWRW05L2dMenFzZU10QWZuMEs5bUEvZEc4TmxVbkxpbjJydi9YYmRP?=
 =?utf-8?B?cWZhQU82dE9aQWdCMU1aaDkxNmlFb25rbE1NUGN6TEQ5NzFCN2tZUGpEK282?=
 =?utf-8?B?NXUyZ0FBb3JxN1hSS3BicmdRRkVkeUg2dlo3UGdmY05MYmlkd1RxMTZxSXhQ?=
 =?utf-8?B?UFNmRGN6aEJtSTloR1lmdGFSV05iZ1IrRDI5eUhVSUJiK1BqWWMrdU94Tjdy?=
 =?utf-8?B?dGxBTjFoSGJOOTZMcWxlclVRUWh6aDFwMnNva3h3QUVETGdmUEUwd3doREdu?=
 =?utf-8?B?SU1iZ3dDZ1VSc2dkeVNwR2ZGOTlSMEhjUGlGUHd2WE42a3NNU1J1NVRERG9x?=
 =?utf-8?Q?1nYKiko2hlI0cjRNUH06HxBjx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ed6d42-7671-4b3b-afba-08de1de239a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:44:20.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEg/66XaMxpXOhoindh4m8rOuhq/o4ZrOE52WLrx5h5SR4MwX+OExNRdiwt7PCrVcsilEUyjydDBPKj6X5kurA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359



On 11/7/2025 2:02 AM, Yang Shi wrote:
> On Thu, Nov 6, 2025 at 7:16 AM Garg, Shivank <shivankg@amd.com> wrote:
>>
>> Hi All,
>>
>> I've been investigating an issue with madvise(MADV_COLLAPSE) for TEXT pages
>> when CONFIG_READ_ONLY_THP_FOR_FS=y is enabled, and would like to discuss the
>> current behavior and improvements.
>>
>> Problem:
>> When attempting to collapse read-only file-backed TEXT sections into THPs
>> using madvise(MADV_COLLAPSE), the operation fails with EINVAL if the pages
>> are marked dirty.
>> madvise(aligned_start, aligned_size, MADV_COLLAPSE) -> returns -1 and errno = -22
>>
>> Subsequent calls to madvise(MADV_COLLAPSE) succeed because the first madvise
>> attempt triggers filemap_flush() which initiates async writeback of the dirty folios.
>>
>> Root Cause:
>> The failure occurs in mm/khugepaged.c:collapse_file():
>> } else if (folio_test_dirty(folio)) {
>>     /*
>>      * khugepaged only works on read-only fd,
>>      * so this page is dirty because it hasn't
>>      * been flushed since first write. There
>>      * won't be new dirty pages.
>>      *
>>      * Trigger async flush here and hope the
>>      * writeback is done when khugepaged
>>      * revisits this page.
>>      */
>>     xas_unlock_irq(&xas);
>>     filemap_flush(mapping);
>>     result = SCAN_FAIL;
>>     goto xa_unlocked;
>> }
>>
>> Why the text pages are dirty?
> 
> I'm not sure how you did the test, but if you ran the program right
> after it was built, it may be possible the background writeback has
> not kicked in yet, then MAD_COLLAPSE saw some dirty folios. This is
> how your reproducer works at least. This is why filemap_flush() was
> added in the first place. Please see commit
> 75f360696ce9d8ec8b253452b23b3e24c0689b4b.

Program can either be freshly compiled or previously compiled.
The error occurs specifically on a fresh mount after copying the binary.
The key factor is the fresh mount and copy operation.


> 
>> It initially seemed unusual for a read-only text section to be marked as dirty, but
>> this was actually confirmed by /proc/pid/smaps.
>>
>> 55bc90200000-55bc91200000 r-xp 00400000 07:00 133                        /mnt/xfs-mnt/large_binary_thp
>> Size:              16384 kB
>> KernelPageSize:        4 kB
>> MMUPageSize:           4 kB
>> Rss:                 256 kB
>> Pss:                 256 kB
>> Pss_Dirty:           256 kB
>> Shared_Clean:          0 kB
>> Shared_Dirty:          0 kB
>> Private_Clean:         0 kB
>> Private_Dirty:       256 kB
>>
>> /proc/pid/smaps (before calling MADV_COLLAPSE) showing Private_Dirty pages in r-xp mappings.
> 
> smaps shows private dirty if either the PTE is dirty or the folio is
> dirty. For this case, I don't expect the PTE is dirty.
> 
>> This may be due to dynamic linker and relocations that occurred during program loading.
>>
>> Reproduction using XFS/EXT4:
>>
>> 1. Compile a test binary with madvise(MADV_COLLAPSE), ensuring the load TEXT segment is
>>    2MB-aligned and sized to a multiple of 2MB.
>>   Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
>> LOAD           0x400000 0x0000000000400000 0x0000000000400000 0x1000000 0x1000000 R E 0x200000
>>
>> 2. Create and mount the XFS/EXT4 fs:
>>    dd if=/dev/zero of=/tmp/xfs-test.img bs=1M count=1024
>>    losetup -f --show /tmp/xfs-test.img  # output: /dev/loop0
>>    mkfs.xfs -f /dev/loop0
>>    mkdir -p /mnt/xfs-mnt
>>    mount /dev/loop0 /mnt/xfs-mnt
>> 3. Copy the binaries to /mnt/xfs-mnt and execute.
>> 4. Returns -EINVAL on first run, then run successfully on subsequent run. (100% reproducible)
>> 5. To reproduce again; reboot/kexec and repeat from step 2.
>>
>> Workaround:
>> 1. Manually flush dirty pages before calling madvise(MADV_COLLAPSE):
>>         int fd = open("/proc/self/exe", O_RDONLY);
>>         if (fd >= 0) {
>>                 fsync(fd);
>>                 close(fd);
>>         }
>>         // Now madvise(MADV_COLLAPSE) succeeds
>> 2. Alternatively, retrying madvise_collapse on EINVAL failure also work.
>>
>> Problems with Current Behavior:
>> 1. Confusing Error Code: The syscall returns EINVAL which typically indicates invalid arguments
>>    rather than a transient condition that could succeed on retry.
> 
> Yeah, I agree the return value is confusing. -EAGAIN may be better as
> suggested by others.
> 
>>
>> 2. Non-Transparent Handling: Users are unaware they need to flush dirty pages manually. Current
>>    madvise_collapse assumes the caller is khugepaged (as per code snippet comment) which will revisit
>>    the page. However, when called via madvise(MADV_COLLAPSE), the userspace program typically don't
>>    retry, making the async flush ineffective. Should we differentiate between madvise and khugepaged
>>    behavior for MADV_COLLAPSE?
> 
> Maybe MADV_COLLAPSE can have some retry logic?
> 
> Thanks,
> Yang
> 
>>
>> Would appreciate thoughts on the best approach to address this issue.
>>
>> Thanks,
>> Shivank
>>


