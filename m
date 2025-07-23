Return-Path: <linux-kernel+bounces-742982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73442B0F909
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88329AC3A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F121D3F5;
	Wed, 23 Jul 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mLYVFRyF"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB31FECDD;
	Wed, 23 Jul 2025 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291859; cv=fail; b=rly06lEE/D0TciG01SmoBqeVf7lyUexlPRB2navNXwsxM1/YApDCjvZJKA5dBeFRBEnmmUVpuXCxQQQ7dTLnEHGAB24cBymV1R5B+QXgvQNgYSbQjWRyjiNpvSPjKvnMHf9KDbaHmy8XKox7HGV7AiTPeTR6RKPIs95v50yWpmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291859; c=relaxed/simple;
	bh=Qd2e+Uch6Q4mCavLJKnUVVh5XGVNdXqlWEkclaBC4iI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dMsszJIMepz5eF0AniExsMhI+n8b6U0zYvG1roCtVJ2OKThSQQql+ELMd7OPYVdw+hvMhoRRqX51s/rBkNi7YdtnB+t806rSHlSYzbT/GGGv1d7mMh+c5P4OtKyk3/S+STwIta/iFo8z3UbhnvR7EeYux6y1Iu+rAxjedsJEzmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mLYVFRyF; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuVhUjkWhMKSjNlHIo++0kZy9stAH5oOzwMyuI9KpSpqZv4SMLgEqxEyDYmpZcrP1sipUPs69MDkgcNxHqghC0/K19Eu2FD0yQgl78qpQSiI1asl7jg/3bch2kS+eKI6Jmoiv6xXdcwbQ6BUMWQXIIGNIS4Ooz8G7H4QNq8dAv0oj04IElomBkm/2JYkXWrsd9grlYe0bLKPzqY5cdz8jrqco+EpA1Tg6UFbB2L9h9wlVt/MpOrWn87v7/WHeSgRdJn4yGxo4+c1E3nupggO3JdC8BAWZsj9yNA4h0UtH/ofWV5P6woK2JfiFzt046WM/gUbMevb5Ar83HVStaJnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aShq9DnQ1HbHRXecqgw0MInEl+0hXzT6sYwWkta36XY=;
 b=ifAWtuIX+GB9+J+7DtqFsvZD39/+523KWcNyVuh24Skho1iJgE0/3nda5WSPp4HUbmIxiKGTIguUNoDar2ZkJALzwUIU4P2x7avW1mBN+rWFs1Y3zFcjrFvR7bL0od56KqCv0INh9gzhK2rBnb+HNFwhj4R+5V3zsrNS0TruzG4/82nQs37172tLejAOv7u0slseBmk5moeGeaJKJJh6l3Kl4HGkV9j6NmNKDNl381MWTkcS1vtySqISBvOq95B3l8XTBE9+Ssf1Rx77yfnaAQSm1VPWJZdQGQs5W5toyoYUo/akICu0Y8vwfQuxtwMuyy2au9FoNUCOijiQDU6fFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aShq9DnQ1HbHRXecqgw0MInEl+0hXzT6sYwWkta36XY=;
 b=mLYVFRyF5wZtggOFmDzzKv3KidCEeR9hg96VYSjeZiDde3Jmp/UOL1g/6hwsaQBM8v3XguQrLvfOZSB5UNHDTCfXfKQwQKttjALDUBIALkT+PgEowZGVUpNkTEg5qWoHFMe+9EqTw4FtC44AqpVk9R9yUe1gVrJvtmTlM9zxefA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 23 Jul
 2025 17:30:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 17:30:52 +0000
Message-ID: <36d5cca8-f97c-4984-84b9-6730958ce5ec@amd.com>
Date: Wed, 23 Jul 2025 12:30:48 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 32/34] fs/resctrl: Disable BMEC event configuration
 when mbm_event mode is enabled
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
 <6aee8abeef1bdc5b88f8c3142a702a9d683f5f66.1752013061.git.babu.moger@amd.com>
 <e10bfec5-dfbf-4008-aedb-c47f6596e712@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e10bfec5-dfbf-4008-aedb-c47f6596e712@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:806:6e::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 864d7a97-1436-4385-2ded-08ddca0eac62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmxxY0tYemhDNE5jYmtvU0pJVnFHYjFUa3pjejV1YVUzcG5DM2tNc29zdXVD?=
 =?utf-8?B?ZWNLWERmQTBuemFuK3hiZzJvbHRucm5BbnhOSDM3aWtWM2hXMjVnSDgyNW9x?=
 =?utf-8?B?TFBpbFR2S2E5V1BLY2RobEFhZXhHWDMvZU5IQVNQeW16cUcvM3FzMEpCd0ln?=
 =?utf-8?B?M2I5UGtNZ250Q3I3dG0vWG1CVXRCUW54Z2UydC9lNzZDcFo1bUM2bkdVY1NN?=
 =?utf-8?B?c3pobkQxVDEvcVhPYjc3UURycVB1ZnJqVGN1cHR4N2crWmx0cEZHQzNrREt5?=
 =?utf-8?B?dUFOT0s1SzR3SVVJcXMyYURtWTNOakpoVTFxQTFOWThtMjN1cVVCNVlRNTNq?=
 =?utf-8?B?cXprZUFUcWYzZVA5ek1FZFA0V3B6OTYwcEJHN3B0Q1VTZ0ZwZ2E0TXFwdVdR?=
 =?utf-8?B?M1laVjNGczAzUVlzSG1iTEdITlZsV1hvb2xHZWFCQWt5bVdtN08rdW9qN0J2?=
 =?utf-8?B?K1JveE16ZzFUV2h6V2NOWm80MzQyUzhFZzArSDRkNXBIWExSVi9Ldm5SSlZq?=
 =?utf-8?B?WHJIU1o1c2xmYnJ3c1hZR2FEMG83ZlBTU3VNSHZhd2NhRVBQb29uQlViUy8y?=
 =?utf-8?B?T1BSS0FJd2srVzFJVGlOcTFLNUlCRHRHV3BwTm9CRXo5SGdkOWZnc2tsS21G?=
 =?utf-8?B?NmhlVlpFL3N3bkhVQXpoNG9GcTVFTVU2d1hYdVIrYW1iSTdWWkRWQ0tscjdP?=
 =?utf-8?B?WUQzWXNyQXI0WGxXV1ZHZDUyYUZWL1g4NFNoR2RnQjcycDFKVEZFM1NCdFNH?=
 =?utf-8?B?aGR5NnRxMHg0dEZONUkvM1o4dUJoRk8yL05tb04yZys1ci9jY2N4Ymw1N3Rn?=
 =?utf-8?B?cVZscERZM1d0UW5lK2VlSldxSnN2bElnWlBLZHFIRVU4L1RMd0FnQzI3dWc0?=
 =?utf-8?B?d2N1OEViRTcrd1NrcHdSQ3B5K1V6azRhc3pWTzNEWjdQSnZaTHdhYVZ5MkxD?=
 =?utf-8?B?NThVWFBWSWxoeXlCUjM0cDZpNWVvd0VYanVHcnhkZDFvTlRyRDdETm5wamk0?=
 =?utf-8?B?dng2YVNjd3FCbU5jSkowVHVENWQ0TmhDMHVLNWxSU0xSVEdTais4UWQ2dU1a?=
 =?utf-8?B?cHRlRzV1VHZ2MVRGTWQ2L1NLK0RmYzNQQWNYN3l6aDdLSU1uVGlaL21yWEtS?=
 =?utf-8?B?UmllWStyRVJZME5UWFFVZzVZc05Gd0hDaVpHU0hDcXFlMEpBYXRFZlRsVi9x?=
 =?utf-8?B?b1R6eG9TdUUzNXpQRHEzN0hSSC9pc3Nmbjg3MUwrRUVtL3A2SllzK3Nmay9Q?=
 =?utf-8?B?VndrQ2MraHVFeHFqa2NuNFFEcCsvakNndWVTNUlvTUExakFXZzV3UWRoUDlI?=
 =?utf-8?B?TjFrZUh4MlVnMEhLb1pZanJjYWlhWHczcVFxcVlkbi9zTWN4c2pHSTd0MVdj?=
 =?utf-8?B?UjVHdGlJNWdmRXhKaFdRT3BYQW1FN3BSUGFiOW96UUhYNzluUjdiNWpIVVIv?=
 =?utf-8?B?b3Iwc0ZXRDFHazZISTVDMXJ1TU0zZW8yMEQ5SE45K3cwcDFVMXpyLzlZcmpG?=
 =?utf-8?B?Y0MvU1JSS3ZHcDdMTVRFa0xnZ01NMXkybFh1cUZCOWx0SVR2bnBrR2twcldZ?=
 =?utf-8?B?ZmRLejRNRHF4N1lSL29kSEgwdThudnhKaFl4Y0lVSE42U3B2ZUt6MlF0elZR?=
 =?utf-8?B?c1pHRVdibUxRVmtxeTdDTUQwWVRzTjNEOFlodDlkTG41eXE1STB5cGJxWkxF?=
 =?utf-8?B?Ny9rTktaNmlncDVaV09waHV4REYrYnZ4dHJxVno3UEdBdFhjWjlzS2hzdVpH?=
 =?utf-8?B?Z0VSMDBWcUNYODJSb0FVMm5YMzdyc1NhSkNWY2VyVDhma085Q2dvaWUxdyt1?=
 =?utf-8?B?TStIbVFkV1U3a1BBWVgwVWlwVXZIbGZGVUxiNUZSU1dBWGgzR2FvZU1qRGpn?=
 =?utf-8?B?dmJTSHI4ZWZzcFo3cDdUdXNlNUdCd2V3NjhpZG9GYzV6UzlwWTBsTkJhM2xF?=
 =?utf-8?Q?rnS0SLNakEE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpwb3pFc2RvY2UwOGo4UGlnMm9VRllsMkJGeGE5cEUrRG5ScCs0ZS9xekVy?=
 =?utf-8?B?WDZTYi9PZ3c5SG5QR1ZJSXFHY21Eci9vdlFFMkFYdzE5WTMwblpjUkpnblYr?=
 =?utf-8?B?eGM2aFVFWmE0bXZjL3FTOUJGM1dTdndjUW1RVmp3eWM4ekk0NGd5aURPSVFB?=
 =?utf-8?B?empSZzhjRkp5QW9SVENPUE1zUVByMUtIM3ljdEx5Qm90SW1kd1kxVDlVTFU1?=
 =?utf-8?B?Z1ZHUE1iUy9pcEZsR0tjRjg0Q0RCbERzd2hxUzZ1eEFBNHFoZzJHNE1rcjI2?=
 =?utf-8?B?QWNMSHlwK04rSmQ2MVRsTmRod09KQVlwMjlDQkd2WGhXOVVKTUEwYXdNaEhy?=
 =?utf-8?B?VHl3NFBzUGo0UEpQenRIQ0R4K1hVbmFSeFlHeVo5cWJyMUV3bkhmL1BYeGdY?=
 =?utf-8?B?bDRpU0ljeUwrc0s3aCsvK1A5WnRuT0d1OHBnd25Zamo3NEJKWjNyTUNHcXF5?=
 =?utf-8?B?UDRXbXNDU2JldXA0bzcrV2pIZnhhcFVsOFl2aGpUTURneW4rQVRDQlVBOGtE?=
 =?utf-8?B?MVRWWWtlSHZwbnY3czZ4U0c1TE96UE9OYko2N3ovTGdxTDdYMCtlYnJJRldl?=
 =?utf-8?B?TmFCK3pjdFd3WTI4M0FJRXpVOS9rVTFqeDJUNXhRaWNNb0duZE1VVU9wU2dv?=
 =?utf-8?B?L1p1cGw2WW5PN0VuZCtSY0VzbU1xLzRSb2thaFRKQVoxV1g3MW1rcEFWZ2JE?=
 =?utf-8?B?a1lVc1QxWjBDYzBtZHNUVzlpMjFrZWp1bTdzR2Z4eFZlaU5QNHdQTU0xMGEr?=
 =?utf-8?B?TktxUER5cTFpUlpmcjFHNUNoV3lPNjVYa1R3L2o2TGljeXRMQ1RzdHpsWVVS?=
 =?utf-8?B?elJpa1hhQzZwVzd0NHJ2VXdpeCthbzBGaWRjOEpUQnpTNkFJbThuWWhkWDgv?=
 =?utf-8?B?ZFNPZ1Z0OC9jSjIwRmhuOXBMOTRVQ3NZWDFOeEdsTlRxcEtlSFVIbWJiYnFq?=
 =?utf-8?B?WXRubU9jSVJUcmZNZ0pTMGluVjAxR3RtOVpCREsrN2lDQ1hnY3VXUXcwemti?=
 =?utf-8?B?UFNPNXlXd0NLcHlPc01jaW9jTG9zMHdxeGdtQmNSWkJ3ZVlIUzljWWx5Qkhn?=
 =?utf-8?B?Q2Ruc1hkK01FVlM4UHBkL3JHcFNORVd3TW9ZT3JpYUpOeENaaU5ZcXhCZ0tQ?=
 =?utf-8?B?VkJaUzNrYXUyeCtHQkJtQlM5Z0ZUeXJGbkhPYVRmc2p0RnF4ZGcrVDNPTGJa?=
 =?utf-8?B?S1NzdnZSSm1RTnFaemRIb0pHdFVHYnZJZkIzTG1PMWNjWmoyTjBxQjU5bW5N?=
 =?utf-8?B?ZDFjdVdFbG9zdjQvQlNObTQyWmk1ekVQTHA4TGk3aEFIZDJDd0Z3aWE5aU83?=
 =?utf-8?B?VzlBMzl4TkdtZ1NhMUtjdlFrQVoyNGlVeXZlWWloNG1uR0NPOVdXZHpYZWN6?=
 =?utf-8?B?cDdQMktXT1ZLM0dWUmc4VUFFS1Y5UXpCRzNNWDVERXUxaGE2Q1ZqSERxUXM5?=
 =?utf-8?B?QnpaRkFVaDZ5UTVDZFd6b2NKckR5aVlGQzNDN3l2QkxOeStKU2JMRmNnOURy?=
 =?utf-8?B?dXg3ektlNW5LUnVGSUprZm94b3hWT01IdDhHM29peTkvQTE5Q2lQangzeS9G?=
 =?utf-8?B?Umkrb1AzVTlFTWhCaE1QMXNOVUsvT1dKTldzQmY2QkwzT28zVnFqM3FWMlVM?=
 =?utf-8?B?ZzNsVHBZMWsycGpmL2dlUVAvcGF6VElKYVRGQzZXZGU0MEVYSTFiUkZoNklL?=
 =?utf-8?B?ZXR2bEwxOUJGc1dsTkhqZkdIQ1FsS1J0NnVwWkFQbFdZS2lld01SVGQ4M0xN?=
 =?utf-8?B?LzVUeiszc1VWOCsxY1dQeXN0M2dqUWd4ekNrRW9Qa2NXbFpkMDRYSHV0STQ1?=
 =?utf-8?B?cHczVjFpMTMrR2ZUS3A4ckhVZXFtanZURXZaMGpqanFrb3R6bElpcE8zb216?=
 =?utf-8?B?aUs2Y2JxNnVFWVBQeGphSGthY09PZmYxK09RcFZBYzFoQkE1aU9EcGRncVl6?=
 =?utf-8?B?M1o5NXkybkdOUUJRdVBpaWhPOFhPREVXYWEyZXo0UjZyek9tVXQyNzB0ZEZ1?=
 =?utf-8?B?UXJOSDN0YlRBVHJmVmhiU2tLZGJLcDNOaFE5QngxZExFMkd0UXpiS05WU3Fv?=
 =?utf-8?B?SnVLNGlGNGpTalVTbFM2VkRKd3BERVlEWmJyT1dKM3YxUkJHcnhtMEc3WW5W?=
 =?utf-8?Q?EHE9uTqfIj6yabYP/+MIlyNYy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864d7a97-1436-4385-2ded-08ddca0eac62
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:30:52.8704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKwRIh+xmPzLZHK36xN5oYpgmeeIbZQjRvIpmLpSouF2hvNV9x0ykcgrQpK74c19
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

Hi Reinette,

On 7/17/25 23:02, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>>  
>> +/*
>> + * resctrl_bmec_files_show() — Controls the visibility of BMEC-related resctrl
>> + * files. When @show is true, the files are displayed; when false, the files
>> + * are hidden.
>> + */
>> +static void resctrl_bmec_files_show(struct rdt_resource *r, bool show)
> 
> The "void" return is unexpected since many of the calls can fail. It looks to me
> that this is indeed intentional since there is no BMEC feature checking, but instead
> the existence of the resctrl files are implicitly used as feature check. Doing so enables
> this code to be called on any system whether BMEC is supported or not and thus a failure
> should not be considered an actual failure. If this is the case, then it is subtle so please
> add this information to the function's comments. If this is not the case, could you
> please explain the void return?

Yes. Returned void because in some cases one of the config files may not
be available. Added a comment now.

"Don't treat kernfs_find_and_get failure as an error, since this function
may be called regardless of whether BMEC is supported or the event is
enabled."


> 
>> +{
>> +	struct kernfs_node *kn_config, *l3_mon_kn;
>> +	char name[32];
>> +
>> +	sprintf(name, "%s_MON", r->name);
>> +	l3_mon_kn = kernfs_find_and_get(kn_info, name);
>> +	if (!l3_mon_kn)
>> +		return;
>> +
>> +	kn_config = kernfs_find_and_get(l3_mon_kn, "mbm_total_bytes_config");
>> +	if (kn_config) {
>> +		kernfs_show(kn_config, show);
>> +		kernfs_put(kn_config);
>> +	}
>> +
>> +	kn_config = kernfs_find_and_get(l3_mon_kn, "mbm_local_bytes_config");
>> +	if (kn_config) {
>> +		kernfs_show(kn_config, show);
>> +		kernfs_put(kn_config);
>> +	}
>> +
>> +	kernfs_put(l3_mon_kn);
>> +}
>> +
>>  static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
>>  					struct seq_file *s, void *v)
>>  {
>> @@ -2659,6 +2690,12 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>>  			ret = resctrl_mkdir_event_configs(r, kn_subdir);
>>  			if (ret)
>>  				return ret;
>> +			/*
>> +			 * Hide BMEC related files if mbm_event mode
>> +			 * is enabled.
>> +			 */
>> +			if (resctrl_arch_mbm_cntr_assign_enabled(r))
>> +				resctrl_bmec_files_show(r, false);
> 
> Looks like the kernfs_find_and_get(kn_info, name) in resctrl_bmec_files_show()
> can be avoided by providing the kn as parameter. I think you may be doing it like
> this because of how resctrl_bmec_files_show() is used in resctrl_mbm_assign_mode_write()
> in the next patch. I think the kn can still be provided as parameter but 
> resctrl_mbm_assign_mode_write() will set it to NULL and only then does 
> resctrl_bmec_files_show() need to figure it out itself.

Sure. Passed kernfs_node now. If the node is NULL then use
kernfs_find_and_get() to get the pointer to the node.

> 
>>  		}
>>  	}
>>  
> 
> Reinette
> 

-- 
Thanks
Babu Moger

