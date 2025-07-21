Return-Path: <linux-kernel+bounces-739838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF3B0CBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A75D3A38F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365A227E8F;
	Mon, 21 Jul 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ekIH/yJb"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC323A98E;
	Mon, 21 Jul 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129290; cv=fail; b=bJSvR6T0xYzvQkVL/d0kFLRimnnYgjbZB7r0UqG5UWbsJWhXvosYoLTYvwO4O+YFhH83W8rEcFHTEMHHfnSvtGZGy4R7l6Z32KqKBCgjxbAFv7k8rKIxjwGy8GDEc5BlDA047+rud6P86VHMGtk4NOSgx+Uy4xO3D1AOpP3MZ94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129290; c=relaxed/simple;
	bh=r9jv6tqkFyaf+5xoBrRjDnHb6wAd3wdv2PA5Dx2qMhA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDzGiX07w/lFRo58m5OWZ+G+9mRxt4wYDWXNPsVV1Q9Vyp5nydMoGqK1zZJpMj/fvMDdBZzVxRZKblhKnAHgBQLmECYs7AL4Sp7falIRWso30N301IW/C0S0pthvmj0E7OOHyX55k0YKEw2M0ngSQkYCMJXNgzp2JYlLkZHGaW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ekIH/yJb; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4qx//NcuYNCMyt0ZoM5vGgmcF2qGmIVL0on++/qJ9y3+ky1GNQPrEMqm8R3BalDxLN8H3at87GBIT1fqTor9rwTnn8mlgbnSKod4R18PYIJOiTIyPXR2mA8zCF8blimBODhQVF7Yd5tqLFCpqW7uYz+rflVRthbB1prPV1oe249Td2rd9QljUdbYfmYL330CWZfITSKhqxISEdImUqp8ChscKXtJcjf+FU0UGQI/1jYG9dOwmYh/yh7b9uvqSyIV9dcIZaupJKqs5iabkzbIstZfbDzpFRZkLTusbJQ4ZPPXacAJYN+QIXzYWPj1D2q0x0oVWgci2qhvGbFjdj3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex5DuMnCK+DtwSdBosfRPolGoJr8EBX4raYS1kG83N4=;
 b=KVWuXI95LO/pJE8b3f8pDePe9xn04LyNGOI3z78KO/xPnUjlVIWLozb4gTqHp6I5oWIqPzjfRDmw6lkFP9VVzSnt5Mhxm/YVECAzPEGMg25WSug4ARJZwfBRbNtFKwj4I1mDygFJ4HCxzu2WHjNkwEWnGhptxPBu8Sa0zIDOgBDxKZ9AoQykuZuorDBnGzMy7QZfjkja70kfsTyxYoYi9WNtCPxD8oNGQvXeN14ba1roOEYYI2PnCsI9/0QEOqcypMJ+jlerakKhCHJukkG7E9/NjTUPbWm57aibXw2pZZ1cyLEiZ9Gnzd4fTfb/nYvofpdLq0GekDlvi98i8Z+BRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex5DuMnCK+DtwSdBosfRPolGoJr8EBX4raYS1kG83N4=;
 b=ekIH/yJba5Ces3oFvnzjKw2pU1yR6wkosZxezfarEdLcuHVa7DsV3x1W1hxiQX5zGEXYXYOtVHfXpjIyjlIiVbA3pwfHpbdy67KE98AQ8mqAVM+iUQdW7EEMK4oq8CPp6JGK0LwdPdmJzV79oIjYhNCwhjNOh9hYDI7qdJoPHtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:21:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 20:21:25 +0000
Message-ID: <9549e225-08d3-453f-8338-78f7f426d4f3@amd.com>
Date: Mon, 21 Jul 2025 15:21:20 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 18/34] fs/resctrl: Add the functionality to unassign
 MBM events
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <ef1e3ce931bbbf5ebbf4d3e745c0e260117375e5.1752013061.git.babu.moger@amd.com>
 <0689794b-994e-4644-a47f-595a3297a057@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0689794b-994e-4644-a47f-595a3297a057@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:806:d0::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 14eb3629-332b-4e1c-12be-08ddc8942a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzRvK3c0Q1MzNnhyemJrWG5PcnY2aGdzQ3RURkxMS0RSQkZaZml2MGxVQkR0?=
 =?utf-8?B?WXlmbG1BWFVKMzhuSm4raWxneVA2eUZ5Wmh3OS9NVTgrMTJHaEtJaDYwenVn?=
 =?utf-8?B?eDJsTndOSHVVVTdTTE5ydm03ZTFzaWNGVHcxaVhKZ0llWGd3RDMwSnQydHBy?=
 =?utf-8?B?dzFTSnkyQUprb0hMcWtnS0xBdkMrcjBXV05aK0xMMCt5VmJ4MXlNWUt0MCtN?=
 =?utf-8?B?VWRmOS9DQkJhSmFmRnloS09qelZiMDd4MW5peitUQXhzVW1Ya3dYcjYvYnJF?=
 =?utf-8?B?b1lQUnRIOWhxUVlzZ0d6RUszaERNdlp6cCtaaGJBS3lyTzNiOUllV0xlM1Yz?=
 =?utf-8?B?aW1uVzZrVGJHZDRXUnlHMTFaY010ZER2YjFKeG44T2VHREZUSnRBb1RwUWZT?=
 =?utf-8?B?NjRMZkZpSmRYWjhZUi9WUGNzcFMzWEhoK0xVTDRPcGdpdzFVbTJSWjZXVWkr?=
 =?utf-8?B?NUVwZEhvRHlGZEUzUUoza1RFM2tFR3Y1VGJ5ZVBqWDUxL0Y2RnpPeDljQWFz?=
 =?utf-8?B?NG1ISERldkxpbmFjdDZsNmt1Qnp4MXZpbkFoMis3K1hyUmhLbGpmQ1FsMkJZ?=
 =?utf-8?B?blZBdCtnWC9SYVllajdBUHZyYW9RVVZjNFBoMFN5alRJcU9WamJCbTBIVC9a?=
 =?utf-8?B?a0MwNmhzcGZ6bGhoa1RvRFNoRWd3Vm1KUGMvemczNGlYd0FGTFV6TnFWdTNN?=
 =?utf-8?B?cW1Jc3EwaVMvblljeXFYZ1hzb3hFa0Q0dEZRMnh3K3UwenRadmcvWHNHMXg3?=
 =?utf-8?B?RmxXdzRtMTFBUEpjb2xyTWV0R01nbm5GaUVrbGtEQ1Job3BsRytkY3VhOTRs?=
 =?utf-8?B?cXNvcW8xV2RPMTdoaG5jVXh5UkNvc1lVUHdyTnM0UmxRU1JCZkpKUHBWVUlK?=
 =?utf-8?B?Mm0wQkZtcFlQU0c3MElRMUZYQ2haZkZVRXp0VllKM3VBQTgwMnBGdFQ5T1Vh?=
 =?utf-8?B?Zk5KczA2aHcwSjhDMDJSSGpkZXkzNU15TzVDVFFuZXRPb2RpT2FOWkI0M0Jv?=
 =?utf-8?B?aUdqRUdzMVJ2eFdBc0l4S3JpNXUrZ0xiU1BXS3krYWtRNzd1a0FpaUtNRlVM?=
 =?utf-8?B?RmZHMTZReDA2dUZaSmdmMWVUVUhPK2FCRlhhVktIYTBqS2owSHVCTFNIdms0?=
 =?utf-8?B?Y29paUw2RVBFSlpsS2E1REdaM0x6VmdJWjA0VWFBRVdiT0x2QWcvdmtZMjN2?=
 =?utf-8?B?aTFVN2hCSU14Z2lXQXR1ay90QjBGRGljdmNlV2N1R21wSHo4YjZzRFIxcHd3?=
 =?utf-8?B?ZERtRlFCVSt1VkplL3ZSN3RIL1JiZndCTlRlOFdUOENCRW52NDRjYTl0YURu?=
 =?utf-8?B?eFdpRVJwVDVZZVUrRzMvc29BTHg2L1lrc1FCRnlKZE54RXdWcDBOR0paeHpR?=
 =?utf-8?B?K3NsK3FFVHJBZ1JOaEU3SUZWeCtwS2ZHY3hhTDJtaDBqRXhVd25MK3Bqa2oz?=
 =?utf-8?B?aDQ1RjkrT2ZtRVl1U3lTN0VCUFVySkEzSkd4RFZHNmREaGVFY2oxM2ZFM0kz?=
 =?utf-8?B?WmZOSVorSHlnRGlOM3lpWTZCVUc5bWRMWGcwUS8yWFpMYnVCdnoyQnF3S0Q0?=
 =?utf-8?B?d2NLWHNqWFkvNzk0MER6WkU3YnRldHVxekExMENvSTltUDdBVUhXaHI3N0kx?=
 =?utf-8?B?V0UwSlVFQnNVVkJYdEYvYVErRkpUS3NNRzRLaytZeEI3ZHFsRWpESG51MzBp?=
 =?utf-8?B?djRHQmthWWlJUmtJbXgvK0F5aFFicjJMaVM1L1lNTERsTllKekRPaDMzTnY5?=
 =?utf-8?B?OFp6TVJkbnBYeEYwM3FSbjFndytYbUZCVFcrSmVPakZ1K1Q2Q0xCV0lHK0xp?=
 =?utf-8?B?bWhJdzNkekc5VFA2RHlSZ3djV0dFTFR5MEhnME5TSGs1V0V4bEZYRXdnM0Zm?=
 =?utf-8?B?OEZZZDBmV05VeFBkWWpscWcrMVFnd3lTOTdXMlNMS2ZaQVZUZ1BJakFBQmt5?=
 =?utf-8?Q?jS5Hn4Hri3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGFEZUgyREVUVEkrbGVwTUdUTU9DOTh1Z2E0VnlmT3JzV0RzT3prMmlyWHlK?=
 =?utf-8?B?R3NyMlFIVkh6SDl1bHNabFQwK2FBUm8veFlzdGtCUUF5WFN0SUZMT0VvSitJ?=
 =?utf-8?B?N0JxY2RGTDlkS2cyQXFIOW5RakRMUm01V01XdS80WDZIbnI5NlhyWlhYU3FZ?=
 =?utf-8?B?UTBQcnFTalppcllZNENSSG5RR2tSeFpRbnhyWjRCUE50SFEzODZaR2poUGNx?=
 =?utf-8?B?L3BYeEFOUGFEaXJta2RyZ0FrbzVMalp2b3Fjb0FUQjJaWFpwM0p4NmpGWWp6?=
 =?utf-8?B?eHFJS3lQb2xCY0JZYUFVWVlzL3ExMENQYklPak9US2lrYUprL0hmV25vU2ZL?=
 =?utf-8?B?T2loWnhVVU1ZbXlGRU16MWtGZjZNOG8wbXluNXJvNkxEUWRYY1Y4T2lKa1ZE?=
 =?utf-8?B?dDZlQWw3NGdJRm9TZytRbUF3NnFHMWcxWEVrcTVIcDhNeWExSkRCUXNqY21D?=
 =?utf-8?B?ZU4vWU1KV0RsVzBBamhyZE1sSU1EeTBZR3NXbzJldDJSaVVuWDJsVEdaekR0?=
 =?utf-8?B?Y0VsTkhSQi9zbGlNZTdvTE10emtuL29lTUk0UDNLVmlLd0NxeGp3VVZydDFK?=
 =?utf-8?B?eVlYZHNKWkpRL1ZtSlg5dkRBQTZ5ODFVLy9ZS2lad1BNM3N3dzBKUFluMFM4?=
 =?utf-8?B?MnBKYzJ6QjE4SGl3d29GRzZOdzZqak12SUNXaWRXcnljekprN1RodWc5cHUw?=
 =?utf-8?B?WnMzZDNRZGR5c1Jwajd2eWhkL0pzakhCVUp4U2sxc3ExeGRiL1J1NnVVUmlZ?=
 =?utf-8?B?eEJmK2s2ZzNkMDNMVExTVS90Yi9Jd3RzVWFYK00xOUxlYlJJNHRVV3FDeFhi?=
 =?utf-8?B?RVphcjZKOWxUZlBaTHlmL2RYeUF1cWdnTldzZ0xnUEd1SVR3ZWRDbTZ2NDRo?=
 =?utf-8?B?alR3ZUN5ZTBXQUpJWFlBZVJkNCtubmYrTXhEY240dDY4Wmo1WnFWRTV2bzB0?=
 =?utf-8?B?NkhBTjlWL1VjTTRoTzd0TzVTYldSb2ZXZ1BtSUtsMDNrdGN2cjhBQS9hSUtm?=
 =?utf-8?B?K3E4UlVtanBuYjhxRUZ6YWFXYW9ldzVINlJPMmcwYU95dFJDbXBGUnpFb2gy?=
 =?utf-8?B?bnQxeFpDZ3FaYi80SE5Uc2Q2dm5jZG1ubXIwdzZvZHVwMTl0dGVPUnJlTWlm?=
 =?utf-8?B?UTRobUdRazIyejFSaE13YVNOMkk1a01ra0g0M1dQSHkxcU12WXVDV1pTblh6?=
 =?utf-8?B?Y05OK0JZR1pFbTdUcVo3cHJ1Nlh5RDJyN2g4SEVkMWdBaGxObTdOQkYvWUVs?=
 =?utf-8?B?MkhYUDRzSkhLMWR3NjZpTEhoanEraHRENGREaTdlbU9vNWZLbWpIaTJudThQ?=
 =?utf-8?B?SU12RG1pRUZUU1NPZytFYXVraVNWd0tXUlBqYWlRQ0lMQVJEYTRCdUJJNkRP?=
 =?utf-8?B?YmhFU1NiTWs1V3ZqVDl4OGRHdUwvdGRtMnJtS29XbDlTNHVheTRQSy9oSUVT?=
 =?utf-8?B?bFJlL25CTnk3ZG9HbHo2alZVd3JpR0NwcTBTT3Z5MUhRZG5mOHRDN29EWXIx?=
 =?utf-8?B?UTdjbTBOWkJYdGl5WjNaenEyQmVIc25CUWRCY2pVMHcvN2FpWC9maXJZeGMy?=
 =?utf-8?B?ZFczaDB0TDhBZGRPRGxFVFlrd0F1anY0VC9PbWFZWjVpWGIvWURxaGNOdXJs?=
 =?utf-8?B?aVVGQ05jdFBrM1FvTzlrS0ZrYWVseHFqb0kwNFpQbFNjV3BzR1pvUDVSOUdO?=
 =?utf-8?B?SWZHN1ZzTEdQdWdETXY3Ukl3L0swSitsNnE0U2pTSGV3ejBUZXJ2OGRnYjdK?=
 =?utf-8?B?WWdlQk82MzVrWWFQdEU4MCtEeWlaMng4SWs1bnZjMzdYQ0tQVEFqRm9mTVV5?=
 =?utf-8?B?dkxycmU0K3lmOVNnb0M4ODJqc3dERVpTNlMwMWJQNFIwQktmN0FLa1JKQVBr?=
 =?utf-8?B?S3dEZXJuM05QOENtbTMvTzFRRDBidWdkUWsyVEZhZ1Z5L2EzS0V1cjJObFpC?=
 =?utf-8?B?QlRBTEtGdFJZYUxmbkE2SGd5SE11dHdELzFuRWUzRm15aHgxU0lJNzJDbzJ5?=
 =?utf-8?B?Z1ZGVmV2Wkg5c2JuS2xWekw0dkVQM0ZzcTlYZXFvSEFHL0I4S2E4MnJDZ2M5?=
 =?utf-8?B?aVlBMnZNb0prSGh5ZGExMUkvY1lTTElvZSt3Ly9Kd1A5U1FtdDhueDNBb2xE?=
 =?utf-8?Q?G6jk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eb3629-332b-4e1c-12be-08ddc8942a83
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:21:25.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv1V3m/pn/fnLjXv6b2ftpL575QRExDL58/T/hWa/3Zo3JDco7K0Eg9KvBObsLkS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217

Hi Reinette,

On 7/17/25 22:48, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
>> counters that can be assigned to RMID, event pairs and monitor bandwidth
>> usage as long as it is assigned. If all the counters are in use, the
>> kernel logs the error message "Unable to allocate counter in domain" in
>> /sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.
>>
>> To make space for a new assignment, users must unassign an already
>> assigned counter and retry the assignment again.
>>
>> Add the functionality to unassign and free the counters in the domain.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index bb074773420d..6c0410cf0195 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1022,6 +1022,14 @@ static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  	return -ENOSPC;
>>  }
>>  
>> +/*
>> + * mbm_cntr_free() - Clear the counter ID configuration details in the domain @d.
>> + */
>> +static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
>> +{
>> +	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
>> +}
>> +
>>  /*
>>   * rdtgroup_alloc_config_cntr() - Allocate a counter ID and configure it for the
>>   * event pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
>> @@ -1083,3 +1091,42 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
>>  
>>  	return ret;
>>  }
>> +
>> +/*
>> + * rdtgroup_free_config_cntr() - Unassign and reset the counter ID configuration
> 
> rdtgroup_free_config_cntr() -> rdtgroup_free_unassign_cntr() ?

Sure.

> 
>> + * for the event pointed to by @mevt within the domain @d and resctrl group @rdtgrp.
> 
> @mevt -> @evtid
> 

Sure.

>> + */
>> +static void rdtgroup_free_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +				      struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>> +{
>> +	int cntr_id;
>> +
>> +	cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
>> +
>> +	/* If there is no cntr_id assigned, nothing to do */
>> +	if (cntr_id < 0)
>> +		return;
>> +
>> +	resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid, rdtgrp->closid,
>> +			    cntr_id, false);
>> +
>> +	mbm_cntr_free(d, cntr_id);
>> +}
>> +
>> +/*
>> + * rdtgroup_unassign_cntr_event() - Unassign a hardware counter associated with
>> + * the event structure @mevt from the domain @d and the group @rdtgrp. Unassign
>> + * the counters from all the domains if @d is NULL else unassign from @d.
>> + */
>> +void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>> +				  struct mon_evt *mevt)
>> +{
>> +	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
>> +
>> +	if (!d) {
>> +		list_for_each_entry(d, &r->mon_domains, hdr.list)
>> +			rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
>> +	} else {
>> +		rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
>> +	}
>> +}
> 
> Reinette
> 

-- 
Thanks
Babu Moger

