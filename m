Return-Path: <linux-kernel+bounces-872094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87634C0F3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9FA44F3C58
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDDC311C09;
	Mon, 27 Oct 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k9YtTnlw"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C230E0F4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581935; cv=fail; b=Su9Qd6kzM+7SbT5yT5+NEb/aSE6pxVjNg3dCvG5r+8WljVRWxQP0zfVhvRFSK+eaf0019tNS/pT+Nm5OyaYHr3MXSOARODNfKEiqkK+cYzKFM2Pu/GK/eOqpLFiKh9/1ybeG/YsOHhW54/DXimf7x3/nsQWmzDedNvjtYMrPA68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581935; c=relaxed/simple;
	bh=xkk6zqxIXptba7XeRx8O4EdllDYS9gsoG8SxRUD8fvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=okVqTpSPb18brLxVcDLivUYXvPBF0hE1lUbMPPbesM1bMODN53PHZqjVbpmqyNbvegYEzziYGwWmv9DdaXN6sCk3AEPQHbNmS6disUOuym54HOxQJhbEVSkqtk1zpBufNqCAHpW4jfNzhDXgomr9EQ0GbPXys7xnRKpEaW/5Rhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k9YtTnlw; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bONGFlDqu0toClhGqS6ixPOQalXggIB73BcFeBYowpmvOCKCT1bSotsnDFYFPHREEiEHz7EGrlVYsUp9W1PN/PPE4XVrmX9BtQ5Sxs4eAmsDIm0mVKsAEiGhwlRXC6q7O/HbXHg2KZsQMdP0x/m/0CaV2BQ/JQN9M39CLBQ335MOtY7glYpFDTBVLSfZ+26/vI4TxprILXBoHNeRkfZcRGN44jtwJ6F7o5lAGZByG9KKwiTV2fiR5riGuhSofw7btDop9PZuL0U6q0HY+I3X8LPgaKd+9S6E2Jf0Swc11WQsbOH7tbG6go2/dD2TWyAEVMcmNWv9V5EN/5hjdjN3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD37HVZGRyS6Dce7+dLAadxA0Bhr6o4R5bbBnyQS6mM=;
 b=mH0UpJsHFLEjkftdQ0tDWkA6SqVKxmuBVGqP+Yt3LgG3VTtfiF1a/3qziL9/7shxpcoB2LGtywLOWr7qyGLwbn8xWMqiaHXnaV9SelgdGMcXkRf+MKp8jeZeIpiEoSqd8B30Ie2tqa2vqTYD1T6NjFihJx1BavlZF4Cf4C5CanEQIrNa0e3p+mKLtDnwsa033AvowWhEGCkjQfK//pcyfMYbZTcaKfSOL0oGKjkwfmmYIetpgdzUYyJvbqxioVrqWMOXLAPVivP0YraUi4o9j+KGUwouqyrEPNS/5kmYmxoS19YI0dOQ1zRgV7sG1LhJ1YwNqboLmhoS23nFW5+KAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD37HVZGRyS6Dce7+dLAadxA0Bhr6o4R5bbBnyQS6mM=;
 b=k9YtTnlwuGYjFmNumhVNaM1Nsln74R+kaRp4K8BvVFmAPugK4mz1nr1vQrnGDWMKcYVED0T+wdjvR4lgy+w8VnvbwMMewZbQybxFdHKib4kEsMNWcHwN2AE7mj4LBjH3mtxwYEN9Yf/6ccoP/fbSAyMwI9v/Mus3haUqQ8pqbZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 16:18:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 16:18:46 +0000
Message-ID: <243b5260-3dca-4575-a8dd-d9e774de311a@amd.com>
Date: Mon, 27 Oct 2025 11:18:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: AMD topology broken on various 754/AM2+/AM3/AM3+ systems causes
 NB/EDAC/GART regression since 6.14
To: Yazen Ghannam <yazen.ghannam@amd.com>,
 Michal Pecio <michal.pecio@gmail.com>
Cc: x86@kernel.org, regressions@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Eric DeVolder <eric.devolder@oracle.com>,
 linux-kernel@vger.kernel.org
References: <20251024204658.3da9bf3f.michal.pecio@gmail.com>
 <20251024213204.GA311478@yaz-khff2.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251024213204.GA311478@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d811c5-117e-4dc5-2fec-08de1574810e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjJJR25jYVZ6ODdocldZcWkycjJRYVBJYk5HNENEMTdwSGUwWTFNOFRQRURQ?=
 =?utf-8?B?a0VDRkRsUUswMC9zUktodWI0SERJTkgydjZLWmZIcmt1VlBaWmw0YVkrdWhO?=
 =?utf-8?B?WjJpSllLNjRzRnBCTHRGb3cycW9Rb05kK2NUYWlWN3pUWmNIQVpydnNQTGVT?=
 =?utf-8?B?K1ZOblFkRTg2TmNQTEhKNFpGOTlMRnMyTTg5VGhCYzlCYWJiMG9MQUR4RU9j?=
 =?utf-8?B?YVg5cVNiNWVkRXZvQVB2VlpFb1dIUkh3ZGJaa2NrSUVxTXlGaXRUUGNLeE9S?=
 =?utf-8?B?OENhZjdPMFNQdnNCc0NYWmh0SEY1QlBaUkhaZ0o2T2FERGpoWW5Ja0kvZjBl?=
 =?utf-8?B?R1VmeCt1TURjeTNwcG1sclkyUzNHcTBtbjhzaVkzMTkxUzM5OWZlai9yUFNx?=
 =?utf-8?B?STRqNDJyanRVMzZmWnFSUjZrMGs3bTREMWhNdjVNcVR1d2hTMFIwbzJUYWtD?=
 =?utf-8?B?WWpEcnJ0WUhWN3BHVjRUekQzMnB2S1czNS9JemZDREFFVSsvbHhqMi9hbjQ4?=
 =?utf-8?B?am01SzAzelR1ajFMNUl1VHBQMC92N0x3U1E4TGVQZEdYUXVlWTBEQ3FIa1cw?=
 =?utf-8?B?dDMwRmtTSnFrTlNGSHlZQ2NJUDBCOVZGRnp3TVlGaitOS2piK3N5MkdxakFk?=
 =?utf-8?B?MERxY1BjYkVMeWIrZDlla3ozYjRTV1Z3Z3dMcmxiR014RmkweXNnY1dGdjNv?=
 =?utf-8?B?dVZmcnA5ZVRRSzdzMkVncG1aSjFROFVoYnNkcFgvOEdwSG9NRXZTWmpacURZ?=
 =?utf-8?B?WFg0NFl5NVhRZFd3MjFhSGoxcVpTVzhYbFBXeXJSRWV2dFluSEY1V0xSUVlY?=
 =?utf-8?B?dll0SDQwVnZXQWpzYWVvS3EzcklWYUdGam9rMy9TTWNyVU5zemlMYmtkMkQw?=
 =?utf-8?B?SDVCbHRoNUtkM1Z3cjlweVY3dFQ5cjFlOE5aTklCdUV3QnAwMklsSE1NZnRw?=
 =?utf-8?B?VXFUNU1vRUdncGhsSzVsNjM2VC90Mnc3bnpZd2FPYVZ0UnRMdG1kK3RuM2Rs?=
 =?utf-8?B?MWNsUnZRVWFjbHhFM2VHa1ZCYVZaaXQ0TDJ0MFc3RTVTUWk2YVpWNjkzVWQ2?=
 =?utf-8?B?VkpYNzNyc1lBd05NUDJrTngzWFVSOUsweEtzL0UxZXNhWDFrRUM1TmdCWHVN?=
 =?utf-8?B?MS9hb3dRYUdSWlM4MlR5UlZhQkhRMGFjMFNxMEQ0dENTeWt6R1p2Q3hFcVZL?=
 =?utf-8?B?OXFFeWVlVCtQMGxVWWY1MWdieCtnS2xnL093cDJZV0I3bi9yMk5oUy84K1N0?=
 =?utf-8?B?QkRpR2RlQm1KRHlzemFWb1FpZGh0bG4zcUliTm51YkVkeDl1cWZrMktHMGgv?=
 =?utf-8?B?UHJValdvd2JwUGJnb2NZWitoQ3VtSjNrdVdmcm9nQkpvT3J0ZjVKYUVldTBY?=
 =?utf-8?B?KzJvOFlibVJreEhyZWN0emRvdHJrSGpiYnpzN0EyNEd6N3J0VmlnT3pZL2FX?=
 =?utf-8?B?aEdZT015cXpRaFdyZGFaeW5zL0RIR1YraHJoOUR1TXVnZXdmOEhJSHlvZ0V4?=
 =?utf-8?B?UitoNWRuWjUyYmY5R1hZVHZjRzJuOEtmc2QrQ203VEF6UzRHL0lCdDVubi9w?=
 =?utf-8?B?RUR4OWdKaTh4NDRXeFBGSVQrM2tQaDFqK3ZOcGcrMkdwL1ZxUUJyWmo3cndx?=
 =?utf-8?B?QXFaa0JySllJQkROZzBsdUJXdzFqd2RlbWozTk55MFZYN0J6czdBZEJVUXBE?=
 =?utf-8?B?enRjVTBTL2o1V1p0SXErWlJieExwWGRMVDE3YS90VHVSc2FvbmpPQzNXUmpE?=
 =?utf-8?B?MnpKN0M1elRlNmY3cUhNZ2kzZWszcVVVN3ZpSDZVQnFTeWJvTGU1Q3V1bkNW?=
 =?utf-8?B?N2ZWZUVLVzcxT0FydUtMWml1b0JmcHZiL2h6RVkxUDNscFBQdTFvOWZFZkxj?=
 =?utf-8?B?Q1J1N29BK0lvOTdDK2pHajNKeGw5Ty9UbDNiMVhzU0x1eVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGlDUTJsdjdIa0tzSWt4Ly9xVUdVK2lsMmVsdXZpbzNtRCtFWHNVVUViUnRo?=
 =?utf-8?B?cU9qKysyb1FJMGFKdmVHZU5YYUZsalhJTTJkWUtNNjhhYUo3bGtwd1UzQTlz?=
 =?utf-8?B?K1JzRXNxTFZkSTZBOFBCWHVSbitkaVdJNUJRVkZiZ0xtOEtndHZ6SGVZN0sx?=
 =?utf-8?B?MmxOS3RQL2FFZFdFVTI0WUw5RkpQZXpLVjcvZnZkLzZTR25Ca3FkR1ZRcVpv?=
 =?utf-8?B?OW14a3lGYUNkTnRjcC8ySFY5VHdSVHZOMWdNT1lVeDFub1R0eEV6cDRIOHJu?=
 =?utf-8?B?dFAvRDNpOXdJSDR4cFByQ3RPQkJ1ZXRqVGYxdVM2TXBmYytodlo1dm8vTGJL?=
 =?utf-8?B?YzVrTW5ZUEV1MzAzSUEwVEJXempvdVppWmMzcFdDUC9zdis2aWVRVThUcTk0?=
 =?utf-8?B?R0N0dFF4OHFCdDQrY0ppSjFFZEpRNWFFU1NOck9ITENRcFVpY3JvSU5rQ2I1?=
 =?utf-8?B?Q2FTekY5cllmTkpOMy9ybEpoOWgxeDY5dUpPeDZuSHJDSXZDWGFmOFhGS0tC?=
 =?utf-8?B?MEtHTFhIY014Yk5LL1RoQUplbThZZjNsR0FvZXNtdThySm5NbU0zVG9IM2JJ?=
 =?utf-8?B?bkdoWDdtL291ekNNcmZNbTBBa3hxbTNYdk42U3hEeERYcUV1QzRWY1dEQnZz?=
 =?utf-8?B?bWdrdHZVV29NL3JDR3IxWFU2T0o2S0FyQkFieXl0UFpKNkdqeTdKcGxPVmhl?=
 =?utf-8?B?YVdqeXViN3djbkVRTzdZc3hKNjRablgwcDIwM2g0YlBCNCtoODRuWmxBK2dt?=
 =?utf-8?B?STMyWGRYR2VZQmxVQktNQXcrZDZYNUVVQldvQW42WXQ5Vis0Y0tpYVZXMXJs?=
 =?utf-8?B?VmZQTEptQ05Oa1gvSzdxeUxLNEI0YmR1U1RWT1kxRENiUnoxTitzNUdpU2xI?=
 =?utf-8?B?Yk0vakxDS1VuQm8rZUFETlFGNXNXZ0JpWmJ6VVZyVUVoVHFGZlNacWVxUVhC?=
 =?utf-8?B?M053K09SQTlnR2k0M25PalRWR0RIajVya24xTjBLWW96NVhvMkpKZmMwRnNv?=
 =?utf-8?B?RjVETy9QVS8zSTlJTVFOSE02c24zQU51My9Ca0xxSzJ5YVpZYWxvSEhVNUFr?=
 =?utf-8?B?TlNtWTNUVjJUQjN2QzVteWJ0UkVMZHJZUzJ3T2pVbkt6WWoyU0x1T1dwV1ZC?=
 =?utf-8?B?QWpyWkxrZU4ybG55V1hSZnRGclNJWk5OQ1M2NEIxS3FUSmlwRGZXajdKb2g1?=
 =?utf-8?B?UWhBTld0SUpGTkc4ZUhiLzJJRjFIU2N5dXdZVUt3Yjh3ZDNtMjNYL1Q4alRR?=
 =?utf-8?B?SFZ2MjhzNlVZUkg0VTFqZE01ZVFXelJhNmFwTWtIa09pb215VWFwa3Q3NE1G?=
 =?utf-8?B?MHFMWXR4TXBoQ0JENE9qOVZjbEYwdHZubmVLNUFKN2s1TnJnWkd3Z2RITzND?=
 =?utf-8?B?UkdBWnRYc1dzUWdaSHhLUi9UMjRRMHlRWXJUc2Z1WUk4eDRJV1ZkOFFmWmVw?=
 =?utf-8?B?L0ZUNWdnNXpXZzNyVlpHYXlQWGNxMTNENGlmTnBVbzdkVnF6VlJXczk3VG1u?=
 =?utf-8?B?QXlkNHk5Z1BDTVU4RXlYZk1MWjRzZ0RNSWVPd01hcGdTRE56b1R5RmtBd0pL?=
 =?utf-8?B?ZGNvcXk0bEI4U2xxQzVObm9JTHp5SU1vcUNheHRSbCs3Z1VURm1XWkVJemZi?=
 =?utf-8?B?cEI0V29LeFZpVUY4KzduUEd6ZUhHeG00S21hSVZsbWFaTWNmL3ZnMHZyZmc0?=
 =?utf-8?B?WmQ1YXhuVnJJS1dWMUJibXFRZXo4UVZYRGRCK2sycUgrVGJQOGd2UlZDcE1a?=
 =?utf-8?B?NkFTTlJYU3BmNFFmVktXRWRyelQya0xxd2VVQkNSWEZ6QVpLelFnZFB1LzZh?=
 =?utf-8?B?SGxsU2pGQ3R3T2FwL1paRTk4K1huT3lGWTd1dHU1Q3g2NFZxRWpkUzZTR2RW?=
 =?utf-8?B?ZXhlUWh6T0hYUThtc0lmM1ZKUG9CVGVrMXhKMjcxajh3YThGWnJSMXZGMlZi?=
 =?utf-8?B?cHlmRXhrcTZXN1p3czFsOUEzVnVENHhwdWxDSHhBekFVL0lDUTVWY2hnWUVH?=
 =?utf-8?B?WUpOOWluSUY4UTg4b2ROM1Rvb0RJdkFzZ1lNbElYNXFmbzE2ODMvclRITEg2?=
 =?utf-8?B?aW1Cb0FOVktYbWtpTXU2R0Y2MzFVZVFteDZPTVdCTTNqdFhDeS8xZDVqTXQv?=
 =?utf-8?Q?Qg/8dX/ccFrgVoFSE4Dri5wqA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d811c5-117e-4dc5-2fec-08de1574810e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:18:46.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtYeKj8Ha8C4VqpnXsnTbXmZDmDkOqtGjP2XFTML/yRAgErssJqtUwR9s7SMqfS7jQyiNlqR5aI1IUIBKiAcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307

On 10/24/25 4:32 PM, Yazen Ghannam wrote:
> On Fri, Oct 24, 2025 at 08:46:58PM +0200, Michal Pecio wrote:
>> Hi,
>>
>> This report is related to discussion here:
>> https://lore.kernel.org/all/20251022011610.60d0ba6e.michal.pecio@gmail.com/
>>
>> Commit bc7b2e629e0c ("x86/amd_nb: Use topology info to get AMD node
>> count") bails out if it can't find the NB of each node reportedy by
>> topology. Then NB features like EDAC or GART IOMMU aren't available.
>>
>> Which was maybe not a bad idea, nobody expects those things to work
>> on selected nodes only. (I think?) But it relies on the optimistic
>> assumption that topology knows the true number of nodes.
>>
>> Today I tested 5 older AMD64 systems with socket 754/AM2+/AM3/AM3+
>> on MSI/ASUS motherboards. *All* of them report more than one node if
>> the CPU has fewer cores than supported by the BIOS.
>>
>> (I also have one AM4 system which is OK, but can't speak for others).
>>
>> This is due to peculiarity of their MADT tables - they report as many
>> LAPICs as the BIOS can support and excess LAPICs are simply disabled.
>> FWIW, it's also a pattern that disabled APIC IDs have 0x80 bit set.
>>
>> The kernel counts this as "hotpluggable CPUs", since supposedly it's
>> indistinguishable from actual multi-socket systems before ACPI 6.3,
>> where the "online capable" flag was added to disambiguate hotplug and
>> nonexistent but theoretically supported CPUs.
>>
>> Or at least that's what commit fed8d8773b8e ("x86/acpi/boot: Correct
>> acpi_is_processor_usable() check") seems to imply.
>>
>> On pre-ACPI 6.3 systems those disabled LAPICs inflate topology size
>> and result in breakage on recent kernels. A few examples below give
>> an idea what those MADTs look like and how the kernel reads them.
>>
>> Regards,
>> Michal
>>
>>
>> Athlon 3000+ on S754:
>>
>> [02Fh 0047 001h]               Local Apic ID : 00
>> [030h 0048 004h]       Flags (decoded below) : 00000001	# enabled
>> --
>> [037h 0055 001h]               Local Apic ID : 81
>> [038h 0056 004h]       Flags (decoded below) : 00000000
>>
>> [    0.027690] CPU topo: Max. logical packages:   2
>> [    0.027691] CPU topo: Max. logical dies:       2
>> [    0.027692] CPU topo: Max. dies per package:   1
>> [    0.027703] CPU topo: Max. threads per core:   1
>> [    0.027704] CPU topo: Num. cores per package:     1
>> [    0.027705] CPU topo: Num. threads per package:   1
>> [    0.027706] CPU topo: Allowing 1 present CPUs plus 1 hotplug CPUs
>>
>> Athlon II X2 250 on AM3+:
>>
>> [02Fh 0047 001h]               Local Apic ID : 00
>> [030h 0048 004h]       Flags (decoded below) : 00000001 # enabled
>> --
>> [037h 0055 001h]               Local Apic ID : 01
>> [038h 0056 004h]       Flags (decoded below) : 00000001 # enabled
>> --
>> [03Fh 0063 001h]               Local Apic ID : 82
>> [040h 0064 004h]       Flags (decoded below) : 00000000
>> --
>> [047h 0071 001h]               Local Apic ID : 83
>> [048h 0072 004h]       Flags (decoded below) : 00000000
>> --
>> [04Fh 0079 001h]               Local Apic ID : 84
>> [050h 0080 004h]       Flags (decoded below) : 00000000
>> --
>> [057h 0087 001h]               Local Apic ID : 85
>> [058h 0088 004h]       Flags (decoded below) : 00000000
>> --
>> [05Fh 0095 001h]               Local Apic ID : 86
>> [060h 0096 004h]       Flags (decoded below) : 00000000
>> --
>> [067h 0103 001h]               Local Apic ID : 87
>> [068h 0104 004h]       Flags (decoded below) : 00000000
>>
>> [    0.147372] CPU topo: Max. logical packages:   3 # not sure why not 4
>> [    0.147372] CPU topo: Max. logical dies:       3
>> [    0.147373] CPU topo: Max. dies per package:   1
>> [    0.147379] CPU topo: Max. threads per core:   1
>> [    0.147379] CPU topo: Num. cores per package:     2
>> [    0.147380] CPU topo: Num. threads per package:   2
>> [    0.147381] CPU topo: Allowing 2 present CPUs plus 6 hotplug CPUs
>>
>> Phenom II X4 965 on AM3:
>>
>> [02Fh 0047   1]                Local Apic ID : 00
>> [030h 0048   4]        Flags (decoded below) : 00000001 # enabled
>> --
>> [037h 0055   1]                Local Apic ID : 01
>> [038h 0056   4]        Flags (decoded below) : 00000001 # enabled
>> --
>> [03Fh 0063   1]                Local Apic ID : 02
>> [040h 0064   4]        Flags (decoded below) : 00000001 # enabled
>> --
>> [047h 0071   1]                Local Apic ID : 03
>> [048h 0072   4]        Flags (decoded below) : 00000001 # enabled
>> --
>> [04Fh 0079   1]                Local Apic ID : 84
>> [050h 0080   4]        Flags (decoded below) : 00000000
>> --
>> [057h 0087   1]                Local Apic ID : 85
>> [058h 0088   4]        Flags (decoded below) : 00000000
>>
>> [    0.072112] CPU topo: Max. logical packages:   2
>> [    0.072112] CPU topo: Max. logical dies:       2
>> [    0.072113] CPU topo: Max. dies per package:   1
>> [    0.072118] CPU topo: Max. threads per core:   1
>> [    0.072118] CPU topo: Num. cores per package:     4
>> [    0.072119] CPU topo: Num. threads per package:   4
>> [    0.072120] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs
> 
> So far, I think the way to go is add explicit quirk for known issues.
> 
> Please see the patch below.
> 
> Thanks,
> Yazen
> 
> 
>  From eeb0745e973055d8840b536cfa842d6f2bf4ac52 Mon Sep 17 00:00:00 2001
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Fri, 24 Oct 2025 21:19:26 +0000
> Subject: [PATCH] x86/topology: Add helper to ignore bogus MADT entries
> 
> Some older Intel and AMD systems include bogus ACPI MADT entries. These
> entries show as "disabled". And it's not clear if they are physically
> present but offline, i.e halted. Or if they are not physically present
> at all.
> 
> Ideally, if they are not physically present, then they should not be
> listed in MADT. There doesn't seem to be any explicit x86 topology info
> that can be used to verify if the entries are bogus or not.
> 
> Add a  helper function to collect vendor-specific checks to ignore bogus
> APIC IDs. Start with known quirks for an Intel SNB model and older AMD
> K10 models.
> 
> Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>   arch/x86/kernel/cpu/topology.c | 52 ++++++++++++++++++++++++++--------
>   1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 6073a16628f9..704788b92395 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -219,6 +219,45 @@ static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_leve
>   	return cnt;
>   }
>   
> +/*
> + * Some older BIOSes include extra entries in MADT.
> + * Do some vendor-specific checks to ignore them.
> + */
> +static bool ignore_extra_apic_entry(u32 apic_id)
> +{
> +	u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +
> +	/* Allow "physically not possible" cases if in a guest. */
> +	if (!hypervisor_is_type(X86_HYPER_NATIVE))
> +	       return false;
> +
> +	/* This model only supports 8 threads in a package. */
> +	if (c->x86_vendor == X86_VENDOR_INTEL &&
> +	    c->x86 == 0x6 && c->x86_model == 0x2d) {
> +		if (topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map) >= 8)
> +			goto reject;
> +	}
> +
> +	/*
> +	 * Various older models have extra entries. A common trait is that the
> +	 * package ID derived from the APIC ID would be more than was ever supported.
> +	 */
> +	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 < 0x17) {

Maybe look for lack of X86_FEATURE_ZEN instead?

> +		pkgid >>= x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN - 1];
> +
> +		if (pkgid >= 8)
> +			goto reject;
> +	}
> +
> +	return false;
> +
> +reject:
> +	pr_info_once("Ignoring hot-pluggable APIC ID %x.\n", apic_id);
> +	topo_info.nr_rejected_cpus++;
> +	return true;
> +}
> +
>   static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
>   {
>   	int cpu, dom;
> @@ -240,19 +279,8 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
>   		cpuid_to_apicid[cpu] = apic_id;
>   		topo_set_cpuids(cpu, apic_id, acpi_id);
>   	} else {
> -		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
> -
> -		/*
> -		 * Check for present APICs in the same package when running
> -		 * on bare metal. Allow the bogosity in a guest.
> -		 */
> -		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
> -		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
> -			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
> -				     apic_id);
> -			topo_info.nr_rejected_cpus++;
> +		if (ignore_extra_apic_entry(apic_id))
>   			return;
> -		}
>   
>   		topo_info.nr_disabled_cpus++;
>   	}


