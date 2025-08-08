Return-Path: <linux-kernel+bounces-760667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC8B1EE7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAA3A07F55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F2321FF39;
	Fri,  8 Aug 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j7SewKtk"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256F1361;
	Fri,  8 Aug 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678909; cv=fail; b=td7syHTLG5LkV1qw/3I4bY77C6CMBuekiHgtBbEzcKMQdLfW5bef6ECLOsBypF3Qbd/NykjEB1X13WynbojZrc7YZVnrAU7qhh+jw5tmr1/7tmFPjDwBD/uLrdl4ZuwhKvh6DsxPJlepYzMv01O+JDXYB2bS2vorUN6ADljwfc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678909; c=relaxed/simple;
	bh=Pd2lApR3IgBeRfZIZr0dnt8lRycVMuumLErNOT53r70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iJA0tSc/yGfYCrvyx1ENINnjcOdLd7zB6gk6RPWaYQQ+Irt7NZOiuZpNGGwMYeXR3i3q3N2slKFg48VpShNfnmLkwjnOB257wvW6HC6iFGplVC7ZtHCK8k5vUh7JlRHrrMEK6NX5piT3AKBxlq3ajeJCywYBcHIWhn8EOS+usdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j7SewKtk; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymQrFC9wLiG/5Krf4qazi5jc9TGq5YsNzQ8GO1n7EV/wwko5ecnfoN3WUT4GVlOjBNGTMYu6DHefaPk4UxOEMZQHe5waEOWxtTGg9jst/5mWzp1s4R0elj9CTp/qAMDccFHdXXI/0UcqgPJ1uhvF6HSOmYC1xIUO8H1NSZG+2ixi0rtt8KBBsFGZO3t2ya/45MyQV2JiJpjNjz0UGWAAQgg32JFjqpOjxffXkw8lPPUi9NPS3TQGhBtfMw5OeTr8rCbG8dhylwRZZGhN2j5nLjUC8hLuzaKoSnHyJgTwIDz+MdJ83Sj+NrSG0sZwoVbhkxrn/WdJZp4AgfzqdDUnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsDLPip1GcOmjosLbSD5U3CJG+Ci7HlWWHx9fJZf2T8=;
 b=QTOkQJtkIzbt7l15RLTGsN1TV0TFxvpnlT+pKvvCpvrVuIn7/7FXej1v5WNsTW8uimUA5aB2J/0dC3pydFmArceF2chczmsrDSPkuhH6N6gYoNIM6xQqNAYVaAFn6UMxoK7vJTW2U9h/oWSP3A0mH5H4SHZb+zRi+fky0zzHLccLH1vCgJwDEYvWNMcreQAb41AS9zKs3zCYb+siYcxjJJdfXSOzbFWa+rd95VIyqv0ekNXWBD8eTfzJXzLUTVQI/Fl+lUSm1ZATRl+Yb0tr1Ic7dg3Qi9L5zWP7UUJ3eYwYTy/3803n1Gk0AklqTMlCoE6Qa78AVXKhcvQaheRTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsDLPip1GcOmjosLbSD5U3CJG+Ci7HlWWHx9fJZf2T8=;
 b=j7SewKtkz4zrhuxCyWr/qworcBe+oyeq3ZogLColVaCUXsoIadHzfsqfjr+yZQJ6/H+9E8DMXa2KUk/yPyYg6tc9lPULr00a5sFvyPNqheCwbCdvM5CFtCgpEf7TGrTSmxztIb52DNj7mU1gzYIlZunDGErgfnd9Z2HXT8N8C/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN0PR12MB6128.namprd12.prod.outlook.com
 (2603:10b6:208:3c4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 18:48:25 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 18:48:25 +0000
Message-ID: <965b7252-5b9f-43cd-bb12-c0e0b203fdc3@amd.com>
Date: Fri, 8 Aug 2025 13:48:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 25/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
 <99614342-b6ce-47ec-baf9-f5cdf42f77be@intel.com>
 <40d722fc-e08c-4543-973a-3fb7ee29bf2a@amd.com>
 <1a19e3df-2915-46f9-9677-c369aa31adf7@intel.com>
 <0ce4f15c-40aa-49fe-82f1-3a30d3e56f35@amd.com>
 <c2245bbd-1bf8-4fad-9c1c-9f0848c7da39@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c2245bbd-1bf8-4fad-9c1c-9f0848c7da39@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:806:6e::14) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: a125a627-0725-4280-3a75-08ddd6ac284e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEdlSHpQNFpwMHY4bE5SMTdJNm0vWndHSlpPMUFxaUovYkljR0twRDhtQWsw?=
 =?utf-8?B?SVN4QVY4RnhaM0ZiUXpmWW9vQ0sxbkdKdVluSEY5SzFQNk9xNUZrcGt5ZGIx?=
 =?utf-8?B?RWY0NEM2aWZ0NEFzUFVyYW45L3RaelhsQXZ6T0lSMEsxMS9NbjhVanJyazR3?=
 =?utf-8?B?MzdCOHRVSEFhRkJHNUFScnQ5YjExc1ltSDJGVk51Z3VWeE1JM3pwZmNQaEFO?=
 =?utf-8?B?c3hsc0dCQ3JFcXZ3bU1LVlBLcVBWY01ZT0F3cDZDMzRCRnArT3BzcjQ3Q0NB?=
 =?utf-8?B?Mm8wTEV1akY2cmkvVW9yampwZ2dGVUkwRk1ldlc3b3pRWVE2Z0c1TGxERTQv?=
 =?utf-8?B?U0Mrd1dtdzhRNUp1M0hpVFdpWHRaUXJqYnVpbnNtWEJFSmJoR0VadW43V2lm?=
 =?utf-8?B?TW9jZVJLVG5HTTZYWHNpU1g3WmxKb2lpZ2s3Ti9rWWdNVGlNSFFzYkE2akN4?=
 =?utf-8?B?aUR6OS90L1d2NnhoRitUMUZEREtDQUJLQkloeXQ1WkZVWDZLUWlGa09OUkw3?=
 =?utf-8?B?N241RlgvcUtoOUlyL01vVm44Q2VLUmIram1xa0dod1Z3V3prQzFDOS9IT2RU?=
 =?utf-8?B?TGRyaUN6ZmVWUUF2UDZDbE9DbWFSQkdkV3N3dVRkSjljSXpiVWZXUExid1BV?=
 =?utf-8?B?VzdTWjIvZ3NMMkJZQTZ4Y05qRUVGZHdqMGJDUEJQaW1LcGovQ1RqODVZc0JB?=
 =?utf-8?B?M2I1YndUd0ZWMWNSMy8zVkVJRG5VY3JtcTVsY0JhVU5peDl5NEVIUlByLzFN?=
 =?utf-8?B?eUIybjlsQXhVZlFES2VEeVdhTitPS0NaZGtZK1BxWlRpNWs1RU9uRUZZS1NX?=
 =?utf-8?B?L28rOXl1MEFoeXpZcmNCdFBKMTNrT0ZBcnFwTU1QMzVYZFR0aFNIay9UY0Jx?=
 =?utf-8?B?N1E5S3gyNWthM2R1eUNxbytoNXB2NFd1U0tnTzhCajR3ai8xUWlBbXB4SUZQ?=
 =?utf-8?B?eGJQOVZBU2ZNcFFyUGg4MmpIQ2xKYjM3SWtOWkJhcUgyYWNSd21TTjJtUjNC?=
 =?utf-8?B?ZVRQNDM0NGFWQ1JiWjQvWVMweUc4WG50L1NRL29nSy9wdGxiWjNCOXpxeXV3?=
 =?utf-8?B?Qm9jU1FVaVdXV0gyZGN2ZzdCaENOQmFuM1VobWFpdER5eDhObC9jdGF4WlFx?=
 =?utf-8?B?TDRqWi8yd1hCS1pjM25sVHFoOEFBZzZ4Y1d6dTBGTk1XOURzd2xtb3Nha21F?=
 =?utf-8?B?amErdFBmODJGYzNEQlNrYzNBRzB6Yjl1RWYvWnUwcVBaekNEZnBBQUFuRUVr?=
 =?utf-8?B?eDhwT3hGaDBEUE15c3ZSQStseEd3Wi9XTmIvTVkyUEZ4TjF0Y2xPM0E4bjB6?=
 =?utf-8?B?YmJJM1pXaGM3YWRPZUQ4Ui9sSUxta1RJM0FsTGpVNGt1VEUreEhjWHJOTzA4?=
 =?utf-8?B?S2tjdytlN0kwNGsvb2lYZFhJdC9zdFJzWHhJQ1lrbnF5Z3BaYlBXN1dWa2pp?=
 =?utf-8?B?aFZYSWIxVnFvSTdvYVcvZ3dLbXBXbGEvL1VCNWowcXZtZG56SmNhazRBNXZa?=
 =?utf-8?B?Y3VPaDQxN0VneTJVMlNXdDhGSmxNRUZCaTIyYXNSTzJ0VFBSSVFXVDlRRTZh?=
 =?utf-8?B?MU52eDZYc2Z2dFF6UmtjaVNFNTdZSmx0SUt2cWVjb3FZWVhHWHlSd1JQc2lu?=
 =?utf-8?B?UGpPM0w2RU8rZFRGTDRvOHZZS0ZEdTQwc0VEbGZpb2xpK0NuOHgxbU1FdlFY?=
 =?utf-8?B?YVlDRXl4OEluN3Z1QWNmdldUaEJ2UDZpbEFxdzViUkYyNlZsY05ZMGt0NjRq?=
 =?utf-8?B?NmFPQS9pT1d4bnI0VExsNXV3QWRHWlg0R1dRQ1pxTzcrTGJMckZJZTZwdjc5?=
 =?utf-8?B?M2lnVzdKZjFXb1JWcFlTb0RMdnB0QXpKTHRoVzhvQXgyQlpSREd5R0J4bVpn?=
 =?utf-8?B?ZUZURHQyaktGYThwUUYxekRDdzZPZFhRTGNjT0JrYXlZd3ZkQ0NZOFpoQ2Rw?=
 =?utf-8?Q?E4+kMhHh3sw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk1HNlhwdDFja2JvRk1LNzI2ZVNQSTlyZEtXc1JuRmpBek42TXNEUzhCclo2?=
 =?utf-8?B?MC9VcHd1T1BiT0Q1My9WNGY5WDJsL21EMXZ3amZsNFpLTFkyODZ0M0pUOXZ5?=
 =?utf-8?B?cjUxMXFmd1NPM2hjY3l0MG5MUDBYQitBNTV4YWlQeE43K3QxcG9JcEFCZ3Vy?=
 =?utf-8?B?VHNFV00vK1dCNklTdWYzenVTTmNDMGk2bGZQZUNMV3NmcTN4aG1CRWRtSG96?=
 =?utf-8?B?V21Nd2tUV1dQQ2Z6RGVkSG8zekRBV2JOckRXMEt5NmpLVnRSSHlsa1U2OHdJ?=
 =?utf-8?B?emQxdFNLQXEyeDdiYzZSdWFWM2cxK2FBaUtocjdjUkE0OEtKejJ5elRaVmVE?=
 =?utf-8?B?WXUwT2wya3YvRVVDMkVkSE1xSkk0OU1Rc2hSQjNIbFh4V3UzVkFlUkNMQ1cy?=
 =?utf-8?B?S1dRQm15dDNLbnpnYm1IZTBrVWtNbFA2clRZZEVDZVhMa2dLa3FTTkZSNVIz?=
 =?utf-8?B?aFliSWhRVFpYeklOQW9zK3hPZXZDS2xvbDk2eW1EUko0QVJyclNvTytxTUZJ?=
 =?utf-8?B?RHpGT0NOTUd3N1VmejEyV0t1TklLT25BQnVEMjNJSERVbGs1ZVZrdm53QVNH?=
 =?utf-8?B?eDVlb3VmM3M0NUJVWGdnZ2dSZm1rQ1JRK1VsaENaa2s3MCtwVkpmVTB0T1JT?=
 =?utf-8?B?OVpWbVdNN2dObEhsdkk3cUhFSWZjTGNFZWlrNWJjOHhkMTVxcVNqMWU1VzZ0?=
 =?utf-8?B?ajg1SjVWbjdYRnJsd09FZ0RvL2xndjNKZWpCVzZmS1hvbVJMeE5lQmNXRU15?=
 =?utf-8?B?bG13dEo3WmJvVnVxNVNkbG5zQnF2N0VwQjV0OXZzZXczbkc5dXdjeEVzZC90?=
 =?utf-8?B?TDAyU3dyK2NtNmtxdm5IenVSWlM0UVJTYUVvL0NPU0I5SG1zNUYveHlXNTBI?=
 =?utf-8?B?cm81RG1GWHVVZUp0bFN3UjZsYm5xK0JHU3NVZU14bG9hQ1o5a29XUERYK28z?=
 =?utf-8?B?V0M0WEo4MlpvSGJFTXd5d0huVTk1OHB2OFpDbWlmWldFMTQ3d0Zncm93VThP?=
 =?utf-8?B?V3RUUGtoTnFiUnVHb3RHdTREWnIzK0NCK2FiejFOQ3lBaDZDYUI0K1lCRzM2?=
 =?utf-8?B?YlUrcTduWjMvNGNmbG5BWEJsdTZnMFE2Q1FZaytXVmJwclJmVjVPdVQrajNs?=
 =?utf-8?B?Q292M1F5T1RPWFV1U210MG1Ra0RkczZic1RrTGpFbi9yd0lFMEEyaEkyV1Vp?=
 =?utf-8?B?NXE2QkRwNFA2K1BQcE9ENnRqMDMzb2VCaXkvS3pUbnRmL2tCcFpveEtXd2NL?=
 =?utf-8?B?S1VvZEpESEdnZkphYVRLNGVqNjJHRXkvZXgyRFlaSEY0TGJzdDJSNkdjQjZl?=
 =?utf-8?B?eU9pRXRxWnVXN09EZ1ZNNG15bkhlRHhGazZSclBtT0JSRDlrWHV3NjhLVjlk?=
 =?utf-8?B?bGZ1MU1WdWI5S1QySVBOK1NEQWQ5U25IL2ltYzQ0cGwrNDI4U01UZHpvRzkv?=
 =?utf-8?B?R3FMMmhPSHZrVDB0Vmd6clFtRnhHMXcxRTlhei9MUVlYWDYzZVJQcERqdDg2?=
 =?utf-8?B?QWNxSnUwOVVwU2hlV0kzaGNHV0VyRzNqNlpObTJYTkJPZzJ5ZlpCVWViMGtS?=
 =?utf-8?B?Q3RoTWJCODRlVEhLWklnZzRpWHkxSi9WNis2dFRuK3V3TVhMZDVpTXloUHdw?=
 =?utf-8?B?dVg2VWhiNS9QOTdtSXRBYU5nZmJJM0V0N1VKS0pOdnZMN01jNTFRWlRXZ25X?=
 =?utf-8?B?TTM0OWcydVJaZHVPVUZZaUlLeW5CZVpXalV3R2g4R0gvekdQSWpTK1lrdjBK?=
 =?utf-8?B?TXYrRUV5UlBOVy9oTXVPSDQ3bXYvUzltbXdXVjdCblFlT2FlMVpJQlRkbHVr?=
 =?utf-8?B?Sjdtd3BQaVcweUJMOHhXTjVhSzZDMmxpTjVwZG4yNjJxMEFZZXZ1Y2JrWGlF?=
 =?utf-8?B?YWtvQ092NjQzT2o3UStqUGpjdGFyUGpZV0tIYWJlbnc3R25NZkVpU1Q3VXRL?=
 =?utf-8?B?TmZscGxta21PU1VGSjRzdnZ2bDh2b3JGdU1weEdnSEpHWkFEN05NNGl4U3Ro?=
 =?utf-8?B?QUpzTkhLMTJUSmx6TWNBVzdjU2R0MVVyVlJ0dWkvdDJaWURGcjdBSzFZc2da?=
 =?utf-8?B?a3NaamIya2hrbllqTis0UWpRZnkrSmt0b2JTcDJ2TlZFNEtRY0NTZm9SdVdL?=
 =?utf-8?Q?8EOrrOUUUQylUE/DuFFqwaZXt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a125a627-0725-4280-3a75-08ddd6ac284e
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 18:48:25.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1dV+ETo1xStIY5X5hCYNLe45Y99LgiaRc8buVNSEBvQDlC7GkOHT51NVQvXXl+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128

Hi Reinette,

On 8/8/2025 1:23 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/8/25 10:47 AM, Moger, Babu wrote:
>> On 8/8/2025 10:12 AM, Reinette Chatre wrote:
>>> On 8/8/25 6:56 AM, Moger, Babu wrote:
>>>> On 7/30/2025 3:04 PM, Reinette Chatre wrote:
>>>>> On 7/25/25 11:29 AM, Babu Moger wrote:
>>>>>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>>>>>> index 16bcfeeb89e6..fa5f63126682 100644
>>>>>> --- a/fs/resctrl/monitor.c
>>>>>> +++ b/fs/resctrl/monitor.c
>>>>>> @@ -929,6 +929,29 @@ struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
>>>>>>         {"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
>>>>>>     };
>>>>>>     +int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>>>>>> +{
>>>>>> +    struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>>>>> +    bool sep = false;
>>>>>> +    int i;
>>>>>> +
>>>>>> +    mutex_lock(&rdtgroup_mutex);
>>>>>> +
>>>>> There is inconsistency among the files introduced on how
>>>>> "mbm_event mode disabled" case is handled. Some files return failure
>>>>> from their _show()/_write() when "mbm_event mode is disabled", some don't.
>>>>>
>>>>> The "event_filter" file always prints the MBM transactions monitored
>>>>> when assignable counters are supported, whether mbm_event mode is enabled
>>>>> or not. This means that the MBM event's configuration values are printed
>>>>> when "default" mode is enabled.  I have two concerns about this
>>>>> 1) This is potentially very confusing since switching to "default" will
>>>>>       make the BMEC files visible that will enable the user to modify the
>>>>>       event configurations per domain. Having this file print a global event
>>>>>       configuration while there are potentially various different domain-specific
>>>>>       configuration active will be confusing.
>>>> Yes. I agree.
>>> hmmm ... ok, you say that you agree but I cannot tell if you are going to
>>> do anything about it.
>>>
>>> On a system with BMEC enabled the mbm_total_bytes_config and mbm_local_bytes_config
>>> files should be the *only* source of MBM event configuration information, no?
>> That is correct.
>>
>>
>>> It may be ok to have event_filter print configuration when assignable counters are disabled
>>> if BMEC is not supported but that would require that this information will always be
>>> known for a "default" monitoring setup. While this may be true for AMD it is not obvious
>>> to me that this is universally true. Once this file exists in this form resctrl will always
>>> be required to provide data for the event configuration and it is not clear to me that
>>> this can always be guaranteed.
>> Yea. It is not true universally true. I don't know what these values are for Intel and ARM.
>>
>>>>> 2) Can it be guaranteed that the MBM events will monitor the default
>>>>>       assignable counter memory transactions when in "default" mode? It has
>>>>>       never been possible to query which memory transactions are monitored by
>>>>>       the default X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL features
>>>>>       so this seems to use one feature to deduce capabilities or another?
>>>> So, initialize both total and local event configuration to default values when switched to "default mode"?
>>>>
>>>> Something like this?
>>>>
>>>> mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
>>>>
>>>> mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM | READS_TO_LOCAL_S_MEM | NON_TEMP_WRITE_TO_LOCAL_MEM;
>>>>
>>>> We are already doing that right (in patch 32)?
>>> Yes, but it creates this strange dependency where the "default" monitoring mode
>>> (that has been supported long before configurable events and assignable counters came
>>> along) requires support of "assignable counter mode".
>>>
>>> Consider it from another view, if resctrl wants to make event configuration available
>>> for the "default" mode then the "event_filter" file could always be visible when MBM
>>> local/total is supported to give users insight into what is monitored, whether
>>> assignable counters are supported or not. This is not possible on systems that do
>>> not support ABMC though, right?
>> That is correct. With BMEC, each domain can have its own settings.  So, printing the default will not be accurate.
>>
>> What options do we have here.
>>
>> How about adding the check if (resctrl_arch_mbm_cntr_assign_enabled())?  Only print the values when ABMC is supported else print information in "last_cmd_status".
>>
> Did you perhaps intend to write "Only print the values when ABMC is *enabled* else print
> information in "last_cmd_status".? If this is what you actually meant then I agree. I think
> doing so places clear boundary on this feature that gives us more options/flexibility for
> future changes.

Yes. That is what I meant.  We have same check in event_filer_write(). 
Will add the same check in event_filter_show().

Thanks

Babu


