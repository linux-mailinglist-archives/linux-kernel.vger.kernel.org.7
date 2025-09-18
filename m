Return-Path: <linux-kernel+bounces-782341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36EBB31F48
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E4E662C70
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950ED313546;
	Fri, 22 Aug 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RgLICZUc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RgLICZUc"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF822FDE6;
	Fri, 22 Aug 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876877; cv=fail; b=X4syGzvEG9IVBcF1h+k/rWi0fI+ShL+wLZPvgu+pQdMCNAVCHpHIISHSWixNO/0ich4YDZNh3RkG87TmNaaKJ4FpgrPAyDJOlQfSY+RM27L1skaLSmJ6Ey1r4jYXtiGF6kaC50sCnE4LkSjLl8hWt2zRsnjU/jqQaXS+kCQ7w4s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876877; c=relaxed/simple;
	bh=8U1l7VWADtCcSGiB8tEPW9lfi65vJVr9r3oI1svUA8c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YHPsqdFwS9O1JEng1aDZGUYS3M4owFPAD3bxOF66qwvnUqlTE8ydWZ0vBq/Iofisj2MfoXFyRkRkpYR9iZGRBYhhB7+DUmnEeBg23cOJPy+gPCREqNcI83qQakL6Zmww0NNzNETjbb3NoZXe7zcMnuuqp+F7I3PgexCMYpP9sww=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RgLICZUc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RgLICZUc; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YJsVD2CxP0XlcahLgRv245nzbSjCzhHtYPY9GaPgMRxtqRGB2DEZ2mb1dD/WxO6IVRSovp3DqTy1fpE1/UCViJqCdmnS13Tc8D0qY0W5fXNzb7QXL5mf3Gq0651E08RHrrNWUeGE+ZaOvaLNveFT7lO3hoy7NMLWl0gYP/umFbgvdpv1wzeUgNB5A+pZm2vUohgMuGFKhVZyBGsZSI8VE+TSFhrNgpf58i08PUFUFDpA8BlnpyjIUwVqNVHAid7jkWMVYIsBkVlLmkWmArwxrCsj5NtNpW6xy7i/78bqFX4/2Bdmk82K/pPGoGQQbuknrqC92zONq0tgdFeR6KpRaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPkUnHujXwOJI6cURRZ/LbUUGF/pYxvKL8eTY+Pd5Ho=;
 b=EBhwvJOmv2kqq+LqOVTbzMZea1MHE/dG3qcBWtUxgVmKzcQr415hTWPUHGxZmIrZheQzUkHsg96iqi9t2KO01B17eHLVXgAh9XXmasbViRqhUooAp6IlCmmRU8Dk7nS2TdxkZpFh7uNrAZsG4ZvsNSUprXpoJyxQ5JDzig1BMWFrYmGG/Bw19OZGzvtEYLWGuj1TXmmGji3X2bY3beGRV7giToj4osXrBaRFMmrHzWdCGprTpRYCrCZeL7BPZdFm3sU8shMOxGDXhDuWZ8yLoiyza1VdLhlfylvZYjQop7XeEEbQlQfvbVW1pMbHqB+WC0MjQvb2yT7S03LTiOMBlw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPkUnHujXwOJI6cURRZ/LbUUGF/pYxvKL8eTY+Pd5Ho=;
 b=RgLICZUcxNNy3LxTlTq0qfRrtdfY24B7ssYD90zuHooyJ/OXKryBpVJ5aDW8CtI3zua5IemOKAmo+zeGLTyOaZIjfuEXFL9YI8A060XTTRY6WgdZQc70r5aWKbtXRofLUinPAN4WqUWPjJ9v4oB3cp80jC6PP/vAa343l6fEJkY=
Received: from DB7PR05CA0049.eurprd05.prod.outlook.com (2603:10a6:10:2e::26)
 by PA4PR08MB6239.eurprd08.prod.outlook.com (2603:10a6:102:ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 15:34:28 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::d1) by DB7PR05CA0049.outlook.office365.com
 (2603:10a6:10:2e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 15:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Fri, 22 Aug 2025 15:34:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIidfAhCYGrmqjkjKYj+pBJbp3Y0O6JybfrNlzKqfBSJrZ2u0lCm+4hf14tjYlhrWlFSClyQxT5A2LNDbiXRzANl0g95rx3UESpknd4VcQuTT+jQjOzy4Pz4PmyfTLWntQgWVbC+0qg4L49LqVwTyxPfFV6iGCGUZAAJQmWWgK5rKwXHeD9hiM+HXkI7LpwG1pFfDkZEyc9lkrzEjJsOHXE9+e4bFICuvvwIyf2Zd7DPtjCrLsNMrZmEV/1bxtRIne1/oBWH6Q0RpfYbEUNSc73a0judJlR2QWniWgaFnsuUlnNO8/V6MCOR+D/geCX4ReDKPkaYGvyDViraHVlk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPkUnHujXwOJI6cURRZ/LbUUGF/pYxvKL8eTY+Pd5Ho=;
 b=aEZQiz9NQRcmfDYcYe788mjWUpn+S6AEh25TtrgZtM2Jc6P5jpp83C6X7ex1ZivG0rHL6/ooS/f8Rcnxo/VuWNUUcEAU+osZgiFi/kdSxqElAlONvtWO/j+ltqDenAW5EL1HTKNIi/Sw46vBSLeiAVnKTK0/xI9QxWG+Sll1tcdzHLHmKr109zcJanDdIpkKLKbitUuq4AWqpnZdY5CfJut4beGLwMg6LCSvm97CPfx95QC3to2KVODHq+PvrKHr2iw96KqgNSsoZ8j/MRvidTDBi8h2EyNqmS+HmC+hFDxN+RzxQDEz/SKJnRgYrS2az4zjLPspUI+TAOkrwYMxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPkUnHujXwOJI6cURRZ/LbUUGF/pYxvKL8eTY+Pd5Ho=;
 b=RgLICZUcxNNy3LxTlTq0qfRrtdfY24B7ssYD90zuHooyJ/OXKryBpVJ5aDW8CtI3zua5IemOKAmo+zeGLTyOaZIjfuEXFL9YI8A060XTTRY6WgdZQc70r5aWKbtXRofLUinPAN4WqUWPjJ9v4oB3cp80jC6PP/vAa343l6fEJkY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PAWPR08MB10167.eurprd08.prod.outlook.com (2603:10a6:102:364::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 22 Aug
 2025 15:33:54 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 15:33:53 +0000
Message-ID: <f36ea21e-285e-458d-b3a1-e729825b6d89@arm.com>
Date: Fri, 22 Aug 2025 21:03:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <38b37195-28c8-4471-bd06-951083118efd@arm.com>
 <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
 <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local>
 <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
 <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
 <95012dfc-d82d-4ae2-b4cd-1e8dcf15e44b@redhat.com>
 <bdbb5168-7657-4f11-a42d-b75cce7e0bca@lucifer.local>
 <e34e1ffe-c377-4c9a-b28b-ca873f3620ac@redhat.com>
 <a1942809-ad8b-4a8d-85c0-74ffa2fbb53d@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <a1942809-ad8b-4a8d-85c0-74ffa2fbb53d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PAWPR08MB10167:EE_|DB5PEPF00014B9F:EE_|PA4PR08MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: d136ca62-044b-4c9d-3992-08dde1916124
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bjBZa1d3ZHN2Z21Ncm50b0JucmxmWHV4UnphTWoyRjNia3ZnUUtwcjJYWE5l?=
 =?utf-8?B?RW1TbjBzOXN1em9lZzNHeEJNYXV5QzdPS2gzZllCMGY3ZzBFeXFpdG0xMDBL?=
 =?utf-8?B?RjhHN2dweFpsNzROMEVsUkgwTThVZXovazZpZ1lwdmw1WHpzVkJwTjArMklp?=
 =?utf-8?B?eGVjMmJOYTVRSjFpRmgwRWI0bk9oaHJmRlVsaENOSEVYM1RUZnNucHQwUWp5?=
 =?utf-8?B?SEcyTEFPOXZQNDRhSTVtZGxnd2tPUnJlL2hNMnhyaGtud1RVVDRhVm9iRmhG?=
 =?utf-8?B?Zm1kcjFLdlh6WlJsUEJ6Q3BCdGV6R08yempaYTFWM0RFY1p3aTVTUVlzMzlZ?=
 =?utf-8?B?aHc0enBjb3FDMzdDUlFjYVRNSlVsODJwOVZjSmNSdkpFOFN4eEZZSndBYVMw?=
 =?utf-8?B?aU5jcjZPeDY1YUR1YzVhekxPdjBDUXBqK1lxNnRUcWpCZVRTbEl6UW1EK1JW?=
 =?utf-8?B?ODZGRlkwT1NyS1N4WmluakhQZzFxRmh6T3c4dDZsb3lMOEcyRGhxWldRUFRV?=
 =?utf-8?B?WEVSSXBlZnd6ckgvOFhzNW04VzZLdTEwdG5KV25zRWJoMEw0cGJJdEJPbHZF?=
 =?utf-8?B?RVh6V05YWjVhTzRiaTdPK2l3aEFGYWc4VytKN2VSTUFvQkFXdGk2cnVVOVlL?=
 =?utf-8?B?NDlVcmI0d29Jd1JoUEtQaGJsekJlU2RmVXVFVm40UURZemhnTHFPdmVtQ015?=
 =?utf-8?B?NnRvVE1ielBoTk1LMll1Zk9kcTFtcDFjbGp1YXByQkNKSkcwZ3MwUWl4Qjgr?=
 =?utf-8?B?d1BlWmxRakJVSlFzMXdkckZGeTNiVTluTU5HU0NRVDBobEw1T0pxYktUU292?=
 =?utf-8?B?L3RTamFGeGliS3QwdnBweVZ0dFBTbkVucGc5RGIvZmRNd1NYKzNnaXhUeXRi?=
 =?utf-8?B?TEt1ejJlQlM2YjNneUJKTnhkOXdLYnFoOVBBRytGaFQ3NFo5dkwzbGxkVXIy?=
 =?utf-8?B?N3ZxNVNOUzlYY3RqdnJKRGYwMy9RMksyMWgweTJKWHBQeU4rSEVzMGY5ZkVY?=
 =?utf-8?B?K2dOeDZyNGhmajhUUHd1cHMyZTNpbzJjcWFiWFZ3VzB0M1NjekNwMXlseHh4?=
 =?utf-8?B?VjE3U1d1cDlsb3dsOUJVN1VtQ0lLQVRDTmxZM3ZlWUJtRWdUWlF5ZSt3STBC?=
 =?utf-8?B?WW4yTjNabWtRMk1LWGgrMDQ2ajlyWnFQZmpHMGgwc0xqb3N2WmRjUkVibUs0?=
 =?utf-8?B?VlBRVUFUc3dqSTd2UmtxS1BvOHF2QW81bWZYaTc3TTViV2RKWWtubjBHYU96?=
 =?utf-8?B?YVo0TUhYc1BEMFZGNm5WUFFsSkNLQ3gzUHlMSEl4Nk5WUWd3VFJxaXZWL0Jk?=
 =?utf-8?B?cGZINk9OemFOeEpJWkkySkFRTVNETFR0Qko1eExsTGQ5THF2bzVtYUtHdGpM?=
 =?utf-8?B?cDI4TlhYVWhXU05iK0NOYUlMLzJTQXZaRW0wWExzWHNubkFadWhJb0xhR29n?=
 =?utf-8?B?ZmxiR1A2YzRTYUdaTkhyRFc0M3hDNkhSWTd1K2hHZWM4dURRQ1d3SERmL2Vx?=
 =?utf-8?B?QzVka0d6Q2xMNWo2cU9paGhLYzdNeEsrRHZqaTExRzJEbzArUVdlT1h6RFZr?=
 =?utf-8?B?ZklKSVc3MU1nRHNpb2VCZWdlbGkwT0FEbXY4VU5QOFpjeGY1b0FyRVRLWEtF?=
 =?utf-8?B?NFJIbitSYVkyZDdEVzdzMnhWTnFWamN1bGFLbldhRndnQVFTUUpmdXRPUTBR?=
 =?utf-8?B?RjFDaHlITEpQbEpKVVU3Z3hCa0UrVy8wNHJxSFE0OEdhekNTT2M0dmsyeDhM?=
 =?utf-8?B?YTY2WkNZYXk0SS92TlhIVDloRHhDWVNEd1FoeDE2RG5oT2VDSVl0T1JobGZG?=
 =?utf-8?B?Y1FaeDJEUnQyVGoyK3RBR0oxWXROVDlqM3IyQ20vd1h5L1h1aTgrSnhDb3hl?=
 =?utf-8?B?L3FBaVZKTFhTckJwRkkrRjJ5ZjRyelpTT3BHcVFlU2JQZFpaVWNsZXVPZERV?=
 =?utf-8?Q?a3hvOj0XWwA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10167
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5fdee78e-f444-4fca-cd71-08dde1914cc6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|376014|7416014|1800799024|35042699022|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGd0UTY2NVpoT1RPTHBQSTBQMGVUMk01SjlmU0dDUkxHcHdsWUszbVVpY0ZV?=
 =?utf-8?B?ZlY3TkpRbk1rbE9lWW5pQiswMHF2NFJWN2VrM04vMVZ1aHZjUnhRMm1RUTBr?=
 =?utf-8?B?N05TZTJvNXNVOGlUaStrZnZqaGV0U0N6YTYrMnlUcWZPMk5jd01nSDJBK2Zl?=
 =?utf-8?B?SXJwY3hocXR3Uld3TUxnS1pWZGRPdHk1Q00xOFZaWDJuSi9WYXJrM2g3bVVm?=
 =?utf-8?B?ZWdOWWVqdGU5UVBNYnAyYVhRSHBMVmNETTluMEZJWWxwbWJaRXZGSi82Vk1h?=
 =?utf-8?B?UEVDS1B2TE8zNXhxdlN0bGtSSmJvczBTdGNPd0M4SUtiOHV6dlA3M3BEejlV?=
 =?utf-8?B?d3hvRmpUeEc5bE43YXN2d0tianRhM240Lzg2ZFJWbGRBcWh6UmVkU3BXQ3FX?=
 =?utf-8?B?eWpEcGZkbWhLVWlXYStpYlVtTEk0ZWkralpYNndrbUozaUFuWkJscEJLV09N?=
 =?utf-8?B?MytuNVRCaWhpUkdUMUpDcnFvNnRteU0yT2JCV204cnlWMDcyUHFVd0hiV3Yz?=
 =?utf-8?B?MmxGL1E0d1BPMXowcytRcWZPYTZDZ3h1eEZwMis4aERzTVRxdW91bWVvNHJl?=
 =?utf-8?B?dDhRakplR3pNU3psU0xsOVVXbC9wdEc0Y0YvTEpPcEhBeWp1dzlsZ2ZsdmhX?=
 =?utf-8?B?QnpwMTR4SnRQT3hJeXFNbGl3cUpqbkJudDhEeUNFanMxWDRPdldRUE0vZmxn?=
 =?utf-8?B?c0Y1U3ZpcmVTUldxZTNDWU9WaW1zaXFNOWFDbUFxMWl3TVZUYk1HNU0zdVI3?=
 =?utf-8?B?VzVGN3RSQnUyMkpjdW1rZHcvVGtvRE42WHlTNS9FVnozUUpGakFXMkFIMkc5?=
 =?utf-8?B?eHhRZS9wOWhFTVdqbDJRa2NhSi9kREJ6ZUlmTGt5d2FhVHhJdlBxU1prN081?=
 =?utf-8?B?VnZTdGpwSnZmU3BYd2FjeEI2OFhRSEM2S2c2UTVEUVJiK2ovZG5KVE50clN6?=
 =?utf-8?B?ZEIzT1VIOVpLcHJiTG5URkhUL3VXdnUwcXdBVzEyMitTb3NhQkF1M3JnWEVV?=
 =?utf-8?B?MUE5MmNsaU5nMGcyeHZocSs3cStJaUYxbmI4RUdmQ24yaW1MUzhWbHBRWHN4?=
 =?utf-8?B?dXNnK01qU0d2L3pvaEdYMTdXUkhZellJMU5VNHhPL21qa1ZHdERDdkFjeTFY?=
 =?utf-8?B?a1VYOGtMUHV2bW5MZWFMYUxPWGp1dzkxSXVTT3g3OG5tT3BpZXAyTHIzYjVQ?=
 =?utf-8?B?WkZRcEJMSHN1emVQZjJJMlBiek4wcmV3cW1QcjRKMmQ4UnBqMzQxbml0WVNt?=
 =?utf-8?B?UUdGcllWQk9iWmxQV1NKYndZaEl4eUpXaXNTZ0EvZm1JMjYyTUpUdHM5OWJh?=
 =?utf-8?B?SVNoUHJCS0FPbmQzVzRjUnZxc2YvVlIzSCtST0g3SFYyVUkrWElkMzc5bjI1?=
 =?utf-8?B?NEl1eFB0K2VUb2pndXIydk9CYndjMVBEYXBadzlIcEdWT1lMUkVsVDhZZEFn?=
 =?utf-8?B?WlROaEgyTW9GYmZIVUk2TzZIK2VhMHVwaFRoNkk5ajlIb1N3TFYyR2dUK1g1?=
 =?utf-8?B?N0FCNnBBa091d3BEYUs5NWUwdWtadkdQOWlMdnpXNUtXZ0lzR0xkY01MVHph?=
 =?utf-8?B?aUFnZ1JsZkVRaktQRDg0d2RmSGpHd0MreEVBTXBjb1FBODJVMG9pTEYwd2pU?=
 =?utf-8?B?MU9vTWFBQTlxRzdwMVVJWG5DZk1NVTdtUitiZCtSQjhPY2tjVTlGb2ZYVEth?=
 =?utf-8?B?ZFYxNU5nTEsxN09ITDFuTFhhZEF3ZTZPSGEydnVVUEZEN2FGYUtCRC82ZXZp?=
 =?utf-8?B?WEFqeEdHdW9sRkVaSDdqY0NSRlBuN1prSXNNV2t1WVBBekF4TS9ReEFYTFpi?=
 =?utf-8?B?L21FQnQ1VW10UVNGY0dMQitseWg0TXNTMkJ3VmxWWXI2ZFptL0RpR1JZdGRF?=
 =?utf-8?B?d2YxMEppaDkxVG1Xd2lHekc5YWtYbHNNZzUrZitJeVlISEJaRlorcGNsOHFG?=
 =?utf-8?B?bmRkaGFOcVlOMjhwMEhyRmxlbUpKTUhFRDdEb2dzcUUrbEl5SUtHbnFjdVIr?=
 =?utf-8?B?VVhzS0ozdW5hRnZTNGVxaU9hd1kwUGRPamlSU0Q4a25nMmYxWkg4ajFTejFL?=
 =?utf-8?B?T0JqOGYxQUNxYlc0Qkg0R1M3WnNpeHkrRGN2QT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(376014)(7416014)(1800799024)(35042699022)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:34:27.1936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d136ca62-044b-4c9d-3992-08dde1916124
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6239


On 22/08/25 8:19 pm, Lorenzo Stoakes wrote:
> On Fri, Aug 22, 2025 at 04:10:35PM +0200, David Hildenbrand wrote:
>>>> Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1), but not sure
>>>> if we have to add that for now.
>>> Yeah not so sure about this, this is a 'just have to know' too, and yes you
>>> might add it to the docs, but people are going to be mightily confused, esp if
>>> it's a calculated value.
>>>
>>> I don't see any other way around having a separate tunable if we don't just have
>>> something VERY simple like on/off.
>> Yeah, not advocating that we add support for other values than 0/511,
>> really.
> Yeah I'm fine with 0/511.
>
>>> Also the mentioned issue sounds like something that needs to be fixed elsewhere
>>> honestly in the algorithm used to figure out mTHP ranges (I may be wrong - and
>>> happy to stand corrected if this is somehow inherent, but reallly feels that
>>> way).
>> I think the creep is unavoidable for certain values.
>>
>> If you have the first two pages of a PMD area populated, and you allow for
>> at least half of the #PTEs to be non/zero, you'd collapse first a
>> order-2 folio, then and order-3 ... until you reached PMD order.
> Feels like we should be looking at this in reverse? What's the largest, then
> next largest, then etc.?
>
> Surely this is the sensible way of doing it?

What David means to say is, for example, suppose all orders are enabled,
and we fail to collapse for order-9, then order-8, then order-7, and so on,
*only* because the distribution of ptes did not obey the scaled max_ptes_none.
Let order-4 collapse succeed.

Next time, khugepaged comes and tries for order-9, fails, then order-8, fails and
so on. Then it checks for order-5, and it comes under the scaled max_ptes_none constraint
only because the previous cycle's order-4 collapse changed the ptes' distribution.
  

>
>> So for now we really should just support 0 / 511 to say "don't collapse if
>> there are holes" vs. "always collapse if there is at least one pte used".
> Yes.
>
>>>> Because, as raised in the past, I'm afraid nobody on this earth has a clue how
>>>> to set this parameter to values different to 0 (don't waste memory with khugepaged)
>>>> and 511 (page fault behavior).
>>> Yup
>>>
>>>>
>>>> If any other value is set, essentially
>>>> 	pr_warn("Unsupported 'max_ptes_none' value for mTHP collapse");
>>>>
>>>> for now and just disable it.
>>> Hmm but under what circumstances? I would just say unsupported value not mention
>>> mTHP or people who don't use mTHP might find that confusing.
>> Well, we can check whether any mTHP size is enabled while the value is set
>> to something unexpected. We can then even print the problematic sizes if we
>> have to.
> Ack
>
>> We could also just just say that if the value is set to something else than
>> 511 (which is the default), it will be treated as being "0" when collapsing
>> mthp, instead of doing any scaling.
> Or we could make it an error to set anything but 0, 511, but on the other hand
> that's likely to break userspace so yeah probably not.
>
> Maybe have a warning saying 'this is no longer supported and will be ignored'
> then set the value to 0 for anything but 511 or 0.
>
> Then can remove the warning later.
>
> By having 0/511 we can really simplify the 'scaling' logic too which would be
> fantastic! :)

FWIW here was my implementation of this thing, for ease of everyone:
https://lore.kernel.org/all/20250211111326.14295-17-dev.jain@arm.com/

>
> Cheers, Lorenzo

