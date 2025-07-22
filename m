Return-Path: <linux-kernel+bounces-740036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9FB0CEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2D3ABACA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E3142E7C;
	Tue, 22 Jul 2025 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tLiA/xQM"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4035955
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145521; cv=fail; b=Tftl9nJ2F3BwSshlEg27lCJG6WfqgMJj5gbAFDzNWVfaJJNnPfrX4w7LJNqccE+XsLXIWLHLi2CQx/kiSbC/trVnvnU/ss1RrS5X1dHQJlRTq8cUxdKV4nLb8xd2tanhCuVQw3XIMdEPzJ4viCARb/LH4p3929DrgfAE+YcaweI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145521; c=relaxed/simple;
	bh=3y934XzV0N1KPkpKbBHEiMhpmt0z8JzIGwVYz55lu5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rcK/zYa11oOWPxUCIjQjepx62ygpjIRw7gkzGj9q42V39V9x3uGzA9y0czFdppGuufT5aHG56MddoWyJnM/NpAuo/B/9UFrQ4LjSxqz9F1pi+GPJTR3eLtJiYFQfVF9/NNbmIoJCtV5vrmB0ScM5j79yEP6XfB+zUnzA9RyS3ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tLiA/xQM; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy/4xq4JWTNJN/O/mUEEpg4RDANKo+SbJmf/9jbfczGQxcDHlCiWCR3G5Vmj1AOjWulco0nmyGRbvLoJpmp5fSXGeLmmyPfYILH38+Amx25CUWbW0uf1N3gm4z25XvpM/nsCrl6PBT3+OVrEvEqDrvnY01YsR/qbyFvKRF9zQFzTFZKhh9eIoobaEm93YVIavLU7DTpF4gIp2MGIwlZB4ktwOB7iVOpumb4r3gM9DSG4PbwmeumWVfZUfBIyqd0V7pbhTTqZC4WjioYNn8qulk+PH4Pp0NAAygNCoP2F0czLHoHz04ZRN1m9Ded6kKB6pqzMA+yuXOuvHT+LpFiKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE6p9YdCFjr3Egkt28X6XAccdYMeUnpRxYC0i4n2j4A=;
 b=ET+zddY/0Gkn6vmuc0ifX9YEbYRDeq24uu7cMXNkV0wyfK3n8dQ+Sd2WVkxbGAfTSXTh4I87WG8W1KSbMqkkrM7yJU9wSSWvTj4BUbY57b2rSMTsozhiolBZrnnmhKvZspT1ILmbJFQWJ47qoArR3eY+aYs7tNb501FGjmDfkoFINrvQVFVAwZ/ozq/Y2sj17uzlry/VIfc0uyckAkx8mZfqFlIppimdURQ7x2plsma8Nilrduwx5I0tLrmUhl5bVpWUe3xUbv9JVJnqCiVZj9BVRgyQw5l7V1ARMUQ2LQRLYxftOC8pu772W8LsGSjZnkm04o6g1DzdGpWjKh6yHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE6p9YdCFjr3Egkt28X6XAccdYMeUnpRxYC0i4n2j4A=;
 b=tLiA/xQMlbXvqzXasuclQOmyaenPNSxcojD7pxoOI4xgfduMcqiZCEDbScl0q3mUhSHiKaLvz9Nrc/nI1I9YA14chu3qsNiKYwE3M+jGt4uxo5+K0zlXmee6naeGv3eL1YR1+OHWgEIQ0PMSoWZAP9z5Wh03Reqp3B/O/7ZqZiKRp3X4Oh3UU1WDJBfIW4fbJNZ08AHKWzTYaFFXR6mP7CgnCNaBSo6Kte8Nd/RdmCv0pq4U9Wu1phDVwT9TWbMGv7ajx1N4mRapYKB4k3TXpb/XvgV2B5WdY/6jB85GXEqphHKUEUvGsy/WOjja08WFzsx/VyhurZhpxPrHJIAAcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 00:51:53 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 00:51:53 +0000
Message-ID: <9f4ec189-798f-4c80-ad8f-3fa5b918f67d@nvidia.com>
Date: Tue, 22 Jul 2025 10:51:46 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
 <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
 <aHnUMTly7pOywJKg@lstrano-desk.jf.intel.com>
 <0340e202-8ec8-4226-b136-e924eca00309@nvidia.com>
 <aH7WUugkBh/OO2ty@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aH7WUugkBh/OO2ty@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f783cd2-38e7-43ef-4338-08ddc8b9f36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWIwL3BmS0g5aFV4dVBZeFNScW5VS0tNUUVyOHVYeC9kY2F3ZEZaT2FzaE1K?=
 =?utf-8?B?OUtTWUVuS0xzU2tHa3dlL2NvdnQ1V2ptM3plVWFtUnJ5N3ZvcjRiV3Z2Q2N2?=
 =?utf-8?B?Mzl2ZXh0aVNXdWlrc1o1QjFJeG1FblZlVjNBcUZqcU1IMHdVUEV3ZlRsNlNu?=
 =?utf-8?B?aHA1Y3NEbTM0ZlcwK2pCOFIxb05qWGQrOUhmNUVMK0VjRG1wLzU3NkRwZnFC?=
 =?utf-8?B?bm0zWE5NcUtOZXNaOWI0eHJERHo3VFF2Tnh2WVVkVllzcnhiK3dpN1A5UEsy?=
 =?utf-8?B?MFYybFdBZm94NmRZUWJnc3FqWFhqaGxvNmNqSXI1VG1tYWx2alZhaEVUVnkz?=
 =?utf-8?B?NXE1SEFwaDZtRm93bDJ4QUJqRXRPcmx6L25KeTRwSUhremJZUThXbkI3TnVX?=
 =?utf-8?B?ckorRm5ybHRNUlFKSExHM2xhVk9ZaEs4K05vSlJ6c09XY1JGRWEwRXNNVGdl?=
 =?utf-8?B?dWFlSVFKWHM0QWd6bVFwOVRtQUtpSUZnaXFRZzJic1dMQjZVZDdLMExBbGVx?=
 =?utf-8?B?UFIxQmdZRko5YVpGVUJadFJFNlM0V2dFalZ5dm85ZW5GZ3QxWkNlY3ZaR29P?=
 =?utf-8?B?YVdZMTFHZDRTeDNFYS95VWxhcGVRbW5oU0Z2YWg4SGpzaEY2THI0OEx0djYy?=
 =?utf-8?B?VHNaOTBUQTVFMFpYMU12WnpZbTB4UUhoSGZwRU4xSHEvZVJ0WU0rYUwvd0I1?=
 =?utf-8?B?ZCtPT1FVdDVLS0VVK1NSVU1KaWt0YWtreW8xb3hnVjdJaEtRYUtHWUI1NHl2?=
 =?utf-8?B?VitMd1VlaHB3c21rRDArNkducjd5M25OQzJYZ2p0bDFveU1obWxRbHdkcUc2?=
 =?utf-8?B?bG5jRXRIYW4vSGczVFlTd25SQi9GSUhYSjM3WVRBaXBhWms5NXpmbGM5L2pQ?=
 =?utf-8?B?bHJOQm5abVpaeUVHUWNxY25hNjA1d0svUHBVUVJLNVpsKzhiSi9kcXZXcXZO?=
 =?utf-8?B?bElSWjZ0WkErWkpWalZPMUVnaXBtc05zazdESStmNW1kc3d0T1JxWFJGY1JQ?=
 =?utf-8?B?di9jRCtFOHpvM1FzbnZ3eXoyblFENkg5dFcvVE4wYWxid1d4SXQ1WDdCT3lw?=
 =?utf-8?B?QitEN2NBb0xqcXhkQzRLOTFZWjMzWWUwNFFXeUNuRWNwNURuWk5uVWVJUVRR?=
 =?utf-8?B?cWNPYnZMM2R1WnBXazFQelZaZmtrbGxydEVEK3ViY1JIWVRZdisxWWNVb1h4?=
 =?utf-8?B?VU5lK3E0dkg0dUFIREtZSEI2UWxnRncvUXNQZm1LU216cHlQdVRMbndDNmVu?=
 =?utf-8?B?TFd2UFRtN1JEMnVNNXpiZ0JYUzE3U3orQTVEQVF0WEs0TEJKRTVmYkh2bW9v?=
 =?utf-8?B?OVhOV1NUWUpscVBaRlh4QkZMSS9UL0RLL3QvL0gybjV5cE5CTkNvdjhIbXVJ?=
 =?utf-8?B?TWhIRTBXRk9nM0RhTVpPNFA2d1RtalJCZUZNTVB5bS9vcEc4MC9XTTI2T0pv?=
 =?utf-8?B?dTFsUnNFbzgycmIyc1Exa2tmUlRhcnVYTjJMTlNBWFcxRDB0YzBGRzBVTk9I?=
 =?utf-8?B?S0JVL0ZUYlNWQktTM3FMUGliMENlWUF0bGI4bmlJRCtteE83R2RadFFOWmlB?=
 =?utf-8?B?azBDaW1CMkJVTHNTcnc2dkRFRGZsOFFnSG01dG5MSXJkUmhoMWp4RmR1ajNL?=
 =?utf-8?B?cHVkVVpuRytaSGJDN3N4VnNwdnR6NWQrbGZMYVRMU3Z0cDk2U0xQMXV0RXZi?=
 =?utf-8?B?TGpnelBReTZ0TkVCc0VqOFNBV1pQZExoTnhLOXlNN3Q4UEVNRmxtbS92RDh5?=
 =?utf-8?B?amlHWnQyMEZZM2NsTDc0eHVBc1FYRkd0dkFjeXBORE9nM2NneDlWYWg3SUox?=
 =?utf-8?B?UnhCc0JzRDFMSmdadHZVaEQvQ0YrdHk5eUZPTkFrRkNYQ1dYTHptS0htcWZP?=
 =?utf-8?B?OHdCejZMVzgyUUxQejV4RE5GTkswU3lWa3FIK1BIcU9tUzQzUWROc3M1c2N4?=
 =?utf-8?Q?n7QcySIxiBY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEd5dEFMSjVVd211dHVoQllBYzZRclRsRkhkUDZVdG4xVWQ0akxHcnVJLzhC?=
 =?utf-8?B?bG13bFZpWHpxTHpvZzUwTFFwdGM0SWN5VFU4QWY1bFlFV2p6MzRkYTRoV08r?=
 =?utf-8?B?YUgyOHFOSFFwZWRmMHluN2k1a0RjMkZ2NXlTcEd0SHMvaktLWkNnaUVSTk1j?=
 =?utf-8?B?bTJSWUU5cW9FUkFZM2hWRlNJdFo3RE4vWjhjS0tHbTRiTVFEcitkVnNQdjFS?=
 =?utf-8?B?cnI3TmNwV0VGL1FmVHNYKzZSalFGdWlJcmgwUTFMcEZUYWFuN01RUnIvVjRB?=
 =?utf-8?B?Q3dQZzFVZE1tSWM0SUpLWUlOMVM3VElyY2FBd01pRlZOZWtVM1ZDUGJBVmZ4?=
 =?utf-8?B?Rnk1MlZqV1dRY1dZQVE2ZW4xTXYzbG1qZExPc0xIWGN6WFFuMnNzdTcxYjZh?=
 =?utf-8?B?c2loTG41S29wN3pTZmdMTjZJMklRNFg5bFVFQkVQelYzR2VOcnJqVzNkU2tH?=
 =?utf-8?B?enh3NjNUT01Lc0tNMy9xd0Rib29ldy92bEozOHFnYnZCK29hRWlNelpmUVhp?=
 =?utf-8?B?ZTAwMnFBRFFTeDJFK1I2R3cvbk91VnVLOUtpaDUwdllkcHRUSG5qVlZzc3or?=
 =?utf-8?B?RmpWN2VKNVFFQlN0Tm42S1hMMkhNc0poWjhCZlF1NzY0c2h4SFYvMGE3NGNZ?=
 =?utf-8?B?MGdweEhvRDFnMHBaRGFudW9KcEJJQkE1akFodmZrMi9kdHhyRFd2SmgrSFBu?=
 =?utf-8?B?VXAzMC9ISlY1Z1J5THk5L2Q1MjBWWURqOThGNmczZS9PYTlkL2ZUa0dYMU1D?=
 =?utf-8?B?YWFuRk5JTURybGk0U1VyQ3E2RjNGakZ0UUpJaFI4RjA3RTRtUkxON0lSNEI4?=
 =?utf-8?B?TGszMjlLcGsxVkxaNkQ2WlZOL1hYSVo4ZlhMREdRbm5HM1JXTnJOTlZocUZC?=
 =?utf-8?B?SHEwakdadjYvZnZ1Q2FqL0VBdDcrYy9ZdndqZVEvanE1d2RYM29aWit4Qzlo?=
 =?utf-8?B?UEJobXJXMGgxVHlXSEpFR2dGRkxWeWhUV3VIZWxsTkFrMysvbmpuNUFMNDZz?=
 =?utf-8?B?Sm1ULytVbTlpU1VOQXpBVk9HcUluSCt4b2VjcitCNkpCTk9vOTRVdUg5aFZz?=
 =?utf-8?B?UE5lWUc3ZnViTk1TUEtiVTFUTGhFdUdNdUNjVldmRHBWWFF6cnZRYzhwMjhh?=
 =?utf-8?B?aXdvb2dadkQ1MjVZWktYSUEzRlFweHE1WUVVdW9sbDgxb2E0NDR2VCtpVVQr?=
 =?utf-8?B?eG8ySUI3Z2RhWlR3emUyalIvZTdIbW9WeHNrU1p2WmtOU3dpdWw5N1dQRXE2?=
 =?utf-8?B?SmV5QXFvWWJjVmgxTFF6NTdycDZja2h4MmQ5OTNub3B5VHNybWJ5SDNnMEw2?=
 =?utf-8?B?S3RiMGgzZHpQekhRZ2dOWFBxMHlEcWR1TTRHM01KNzVTZXQ0SmN5dlBBYTJK?=
 =?utf-8?B?Q2V6OHV3SHAzSDFxcm43RVhVOE13Q1EzL2hpRG5VMzFYVzZSd1pxVUEvVm9B?=
 =?utf-8?B?eittbkhINEQ0SDJMUkFjOENrNnV1OGtqSU5iWVpGbGlFcmMxLzNFdDhLdE5p?=
 =?utf-8?B?N2hwZnpwQUVFOVdYa291d3E0QWJsN3hsZ0UrZTd1aHFOQ0ZNOEhIZkZ0S29o?=
 =?utf-8?B?UVVCUU9CVmhGeGsvcXdrT0ZodXJSK3p3RkYrWndHMmU5bjJlcDNtRnRaMFVW?=
 =?utf-8?B?RnIxaEltL2plVCthRVgxZlRmNjFmdmJldTNjMS9lTHRoVWlSWU1yd3NJY3lE?=
 =?utf-8?B?S2d2aHJZR2JJeTh6Vk55UDJtNVhIbVBIN0lISDBqdVFVT3lhMG1WelpqU3Z2?=
 =?utf-8?B?ZlBNZzZWamdnVURWQzRsb002cnJHYjRMSkU0R05ZazJCWWRmb2tUS2hWbEVZ?=
 =?utf-8?B?QVRhb0ptazFCQ3RCcHArODB1dk95ZE9jamFDL1FEdVB0c1gyeEtPTU8xcEhn?=
 =?utf-8?B?aW94dHB4aGU0ZlVIOE5NbmU1VDZlWkovS2FtaEJIMzN4cmZRa1hvMVdaMDBM?=
 =?utf-8?B?K3owVDdYSDcxd2VmVFhuSWRaQlpWK1l2M0NwQ2ZQSW9aWEQ0cFdGVnQyb2M4?=
 =?utf-8?B?Ri90VUJub2dOUFVvNEpTMG8zb2prNVl0ZVJLSDVwVUZrLzgvZnprdjlISEFK?=
 =?utf-8?B?T0Y2bmVRamFZQkZFMVJ3OFhxWmY4MWpBMkhCV2MvTUJLdEVmYXJwN1NaYnNh?=
 =?utf-8?B?eGw0U0ZvWVUrZDdLdXJWbzREOWxFUDNIWDkxR3k1YzVMTjNjbytkK1RveFFE?=
 =?utf-8?Q?lmoGeNMZPmUwkPyb9BILXY1RfuIl0NrPIkDbzsNAcdDX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f783cd2-38e7-43ef-4338-08ddc8b9f36f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 00:51:53.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ch/dABwUxrCC7QKpNGjByNttDUvXKfz1RclTEZoxECI6qxxDFZBizdX90k41gvaWB23U0qLKVVJvFyIoG/dkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541

On 7/22/25 10:07, Matthew Brost wrote:
> On Tue, Jul 22, 2025 at 09:48:18AM +1000, Balbir Singh wrote:
>> On 7/18/25 14:57, Matthew Brost wrote:
>>> On Fri, Jul 18, 2025 at 01:57:13PM +1000, Balbir Singh wrote:
>>>> On 7/18/25 09:40, Matthew Brost wrote:
>>>>> On Fri, Jul 04, 2025 at 09:34:59AM +1000, Balbir Singh wrote:
>>>> ...
>>>>>>
>>>>>> The nouveau dmem code has been enhanced to use the new THP migration
>>>>>> capability.
>>>>>>
>>>>>> Feedback from the RFC [2]:
>>>>>>
>>>>>
>>>>> Thanks for the patches, results look very promising. I wanted to give
>>>>> some quick feedback:
>>>>>
>>>>
>>>> Are you seeing improvements with the patchset?
>>>>
>>>
>>> We're nowhere near stable yet, but basic testing shows that CPU time
>>> from the start of migrate_vma_* to the end drops from ~300µs to ~6µs on
>>> a 2MB GPU fault. A lot of this improvement is dma-mapping at 2M
>>> grainularity for the CPU<->GPU copy rather than mapping 512 4k pages
>>> too.
>>>
>>>>> - You appear to have missed updating hmm_range_fault, specifically
>>>>> hmm_vma_handle_pmd, to check for device-private entries and populate the
>>>>> HMM PFNs accordingly. My colleague François has a fix for this if you're
>>>>> interested.
>>>>>
>>>>
>>>> Sure, please feel free to post them. 
>>>>
>>>>> - I believe copy_huge_pmd also needs to be updated to avoid installing a
>>>>> migration entry if the swap entry is device-private. I don't have an
>>>>> exact fix yet due to my limited experience with core MM. The test case
>>>>> that triggers this is fairly simple: fault in a 2MB device page on the
>>>>> GPU, then fork a process that reads the page — the kernel crashes in
>>>>> this scenario.
>>>>>
>>>>
>>>> I'd be happy to look at any traces you have or post any fixes you have
>>>>
>>>
>>> I've got it so the kernel doesn't explode but still get warnings like:
>>>
>>> [ 3564.850036] mm/pgtable-generic.c:54: bad pmd ffff8881290408e0(efffff80042bfe00)
>>> [ 3565.298186] BUG: Bad rss-counter state mm:ffff88810a100c40 type:MM_ANONPAGES val:114688
>>> [ 3565.306108] BUG: non-zero pgtables_bytes on freeing mm: 917504
>>>
>>> I'm basically just skip is_swap_pmd clause if the entry is device
>>> private, and let the rest of the function execute. This avoids
>>> installing a migration entry—which isn't required and cause the
>>> crash—and allows the rmap code to run, which flips the pages to not
>>> anonymous exclusive (effectively making them copy-on-write (?), though
>>> that doesn't fully apply to device pages). It's not 100% correct yet,
>>> but it's a step in the right direction.
>>>
>>
>>
>> Thanks, could you post the stack trace as well. This is usually a symptom of 
>> not freeing up the page table cleanly.
>>
> 
> Did you see my reply here [1]? I've got this working cleanly.
> 
> I actually have all my tests passing with a few additional core MM
> changes. I'll reply shortly to a few other patches with those details
> and will also send over a complete set of the core MM changes we've made
> to get things stable.
> 
> Matt
> 
> [1] https://lore.kernel.org/linux-mm/aHrsdvjjliBBdVQm@lstrano-desk.jf.intel.com/

Sorry I missed it. Checking now!

I'd be happy to hear any numbers you have. In my throughput tests that rely on
page copying (lib/test_hmm.c), I am seeing a 500% improvement in performance and
a 80% improvement in latency

Thanks,
Balbir


