Return-Path: <linux-kernel+bounces-720615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F88AFBE47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F1A1AA21D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97028727A;
	Mon,  7 Jul 2025 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jIE5zzUC"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330224467E;
	Mon,  7 Jul 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927730; cv=fail; b=fcGTTCdroP7UpyLCPyNC6xdYsV8H1qYsruKVwEU39UmnOxE5UmXgajMuDr/vdN55DR9sScIKxiPcHGjbPBqO7So2n5SJ4QO9LvW4JH3bpvIZLXvKVcaUQvegM0e6/PsVEv7IUK/jPS4JqVjvdHdLAKPfP0G/XskgR6l4yI6CDlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927730; c=relaxed/simple;
	bh=wIpy+QVeT/GdsjnSgQVje9+Y0mdM21D8RUXLldiJN9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hPjunTLvnQSuep3X2kit9sxg/Vxru50qUodKRwl7ojF/mqQhGdc/LemAAmpQdp2MrHhDXhdHutoNCDquUoAqUgijYEzzHEXGZ/EJlb/AajPY7doXShiG44gt7Weq4UknsWWcgM1Lt1wabr+AIbMiMAbqzxdPDoj80jsbaJJQy0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jIE5zzUC; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mt5p7fZ+XisX45/U5OLIChNuTzCNoCU6SQfHgeYdNdMZ2IogryHz31h99uB945yRFcFWnrip+H6EHjWnimU1PvMIaJyI62Z8kFdmImw620OZXiMybMn6OQ7DugVVJ03XAu7af1En664UuzMlv8zj7USMZpbr+SrjUHtgtTSeRZsKuOQneaC8jWkMkQKvfXdFel4sgTJn/TILYbDbo14fvB4NtnpC+IsUKnz6QrnB+aLzyB99BLcl3TTT8PtaJ4Q4v0Y4nQGVtPapfRcTKNifFL0N75DmYwjxPin/wdqLCWAHTaYj3PAenCaWRHNpBD5cEtCJGShY9LJkE0anm2i9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5tscxu4/6qvezE/vja/c95iQ13H/sejaywOuhxa1hQ=;
 b=S6JKys489YfODSEkQjVxBkcanLonR+o40hhJ+Ph9Og9pRISTlUIs0avxyCjvpKlPApgJ664dFZtl0cOKcRuXJ7Oe9DqSp2i235liZKeHA8GGprVhhjAFcUt8G4O1GUIbERCs4bC5dGn3VHEZHbwed4Kz7u/zN/pCBnBQZ9sBCv9zgPzTeBGGdNSeQb/e6I9aCNxY4tzRFVVf0oN+Zs8ewVgtfV4aYGq1f64g6BoBCCHJP/2xNvf6NVFcTbyy1AZ31QcXnNXjeCpcbRDP7oojfLl3NnHlZzgWP5mkjmPFInebCZp7lvdqD9WD/SD1jeblFpldS1HASlxRQMtj/1gNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5tscxu4/6qvezE/vja/c95iQ13H/sejaywOuhxa1hQ=;
 b=jIE5zzUCqsBQS0+Mz4fEPv3HFe7cKl0FRhLrN/tBGYfXkpBlE9vXQkgXhGssoV7Kp505iw8yMSekaS1KfoEp5a/uKUWv1Y+O2bNFrC39tBg7ckGndF+8KcT2FDVoqI0lgdZRpH70eTa4e6qHM62g1Bs4j/4LhipGi6KgcVVGO9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 22:35:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 22:35:25 +0000
Message-ID: <f8f434d0-1c44-4d76-9121-7c0acc7aa10a@amd.com>
Date: Mon, 7 Jul 2025 17:35:18 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v14 30/32] fs/resctrl: Hide the BMEC related files when
 mbm_event mode is enabled
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 rostedt@goodmis.org, paulmck@kernel.org, thuth@redhat.com, ardb@kernel.org,
 gregkh@linuxfoundation.org, seanjc@google.com, thomas.lendacky@amd.com,
 pawan.kumar.gupta@linux.intel.com, manali.shukla@amd.com,
 perry.yuan@amd.com, kai.huang@intel.com, peterz@infradead.org,
 xiaoyao.li@intel.com, kan.liang@linux.intel.com, mario.limonciello@amd.com,
 xin3.li@intel.com, gautham.shenoy@amd.com, xin@zytor.com,
 chang.seok.bae@intel.com, fenghuay@nvidia.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, eranian@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1749848714.git.babu.moger@amd.com>
 <4769751d1de7c4f66b1c7f3c5ea7eeeb49951363.1749848715.git.babu.moger@amd.com>
 <3c753f3c-e91b-4cfe-983d-efe8ff07b750@intel.com>
 <f85e467a-1d17-4f34-98e3-512679baad47@amd.com>
 <ff314427-1c03-4e26-be19-c5f5090f3d8a@intel.com>
 <471975cf-1094-42dd-a965-f536cf399d0a@amd.com>
 <d5c4d3e8-6d5f-4892-83b5-867ec8bfc97a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d5c4d3e8-6d5f-4892-83b5-867ec8bfc97a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: b045148f-46be-4c74-f1e8-08ddbda690f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3ZrV3V1VEIxd3hFNGo0cmI5aE5MVy96ODYrenpPNFluaWc2YkV0NnlFNHZz?=
 =?utf-8?B?M09wMlplRE1MSWQwYUFJSVdENUt3MVZlR3VYTHVDQUcvV0JHTGQ4eWdlNzdT?=
 =?utf-8?B?c3REUlpzbVhraENNMHluUml0RzBuUm9hZG5YM0N6b3FNVm9EQ3pRQzZZTGdJ?=
 =?utf-8?B?bnI5bG9hR2VUOXo2S3pydFl0WHF3Mmh6Z3JEanhQMTZIdnBVOHZvSGF2S3Fh?=
 =?utf-8?B?dWJHdm9oSG1UdFVLb3ZDVnlBTEw2R250UTc1T0dKRmpkRmlpdjcySXVIUFdy?=
 =?utf-8?B?V0lJVEUxTER2QkpvSnRqK0x1SHVabm5GK3JnMXR6TkdpUDRpN29KRm1CdHdH?=
 =?utf-8?B?bU9Fb1M0ek5GVXhlTWdKQ25KQklaeVVadk9vNXlBemYyejlPN2xuUkxpZXZV?=
 =?utf-8?B?aDl0RzNpcHFrVW52QmRuSFBXRlpidmtzL2RKVVVJNE00TGhDejRWZUtHZFYy?=
 =?utf-8?B?Y2tPVEx0VytrN0hCWlhQR3YwaVJzelFLU0xHeVFrNUtCSEcybFBzbGdpTVZq?=
 =?utf-8?B?Mmc5K1NpSmxyOUNpdWxVaUVjUEFsRnpjYk5DTzRTbHU1U3Nvd2I4RGtIRmhG?=
 =?utf-8?B?Q0hZaTlvbEJUc2tUL0taWG54M1NEaVBMbjIzZEEvM1NVZnFDTHF3S2NwWVRM?=
 =?utf-8?B?WjkxQmVhYVh6VkppelNiK00vU0VCN2dENHBBbHZEdm9TbUJzTW5uWUpUb3o4?=
 =?utf-8?B?clIvQlJjbDBJMEprVXBhc0FGOVg5V2JvOGt4Nm84T2RPbXg1SVEweU5aTHlV?=
 =?utf-8?B?NE9wTHpwYkozWDJaQkJRWVNpR0JvY2I4K0F5dGFPblpqaDU1Zk1acG05c2FH?=
 =?utf-8?B?NzVYSHB2OTZjekY2c2N2WGEzYlZRMlJKTzh2OWhZK1g5cU5lQjRZeElXWEJZ?=
 =?utf-8?B?cDU1VW1odWF5a1lma1pPS1Q0a1h1SjBYVzdRdHdVWHJlSFdkZ2p5Y0FOMzZW?=
 =?utf-8?B?N0VReVBQYzhyNnRkbUJyRDBRdE1ZWTJ1YjQ4dm1IWUhsT3o3Y3czQWpQTTZG?=
 =?utf-8?B?REIzUHd2RVlMQ2xMTnk1Mk1nN2ttRHA4ZzA2WmR3RTlPR1RFYWdVZ0dIQTI3?=
 =?utf-8?B?a0FiSzdSTFFQdUlycE43M3NqRGRFL200RUJBaFJDNVVoZkVwVGY4RURVcXdG?=
 =?utf-8?B?ZTBXRDJJL0hsS3VsaytTTXZpbmtsbmdCTVdtUGJvazBYc0FDWHlsSnA2Y0pR?=
 =?utf-8?B?Q2trR2ovcThtWDJhRnE2eVZTTFZTWEM2T3FyY2FjWWFrdkNzbFhYSjNZTFRM?=
 =?utf-8?B?UnJWVWlhbXFLaFo3RFFFYzNoc2c4THR3aDRhNi9qWjJUK1lFZS9zbG16ZGJn?=
 =?utf-8?B?bHBIYWpLd3A5cjN1bE5zclBXd0Y5enFRQUc0cmdzdkZ6SHBTOVI3OVloLzBK?=
 =?utf-8?B?Rk4zeDBiQVhzQUcwMU5KMnNSalFUNzl0NUt1ZWg5WVRpZkk1TzV1UjVXYkkv?=
 =?utf-8?B?dVlmS0FnVE0wVld5K1NlVGsyeU5JL1AvQU4yTFR0b3dwREJPWWJhOGVFV09k?=
 =?utf-8?B?bFJwVTRFSUVnVEVOcmdkeWNjY1U3VXM4eFRtMFJERnR2MXRNUXJ1UXZmWkhE?=
 =?utf-8?B?TlgrajVuSjdoR0dLRmg3cm9nOUpqL1NGN0tXT2JCcGdvalp3eWRDLzhPNE9s?=
 =?utf-8?B?bVZYR1VNeFlIU0kvMCtZWVVsNkdzeGgxM0JjTlp5Q2FjYkw2M1pEdXpiRHhJ?=
 =?utf-8?B?OGVFVERDa3EvSzZBa2pFVDNIbHRIVXhYZnBWYmlLS2NncnlLZ3dSZlVReVdM?=
 =?utf-8?B?cDg5NHFJWVJla0tQYjhtMVFnbHRLVndabmt4SFBBUzZpOUhWOWRmQmY4VnNS?=
 =?utf-8?B?eTdRcSt0aWtiUzFWazlJMDdhanRRWGlPV3R1bk4ydUlYMGxwNDRWZktHQWJP?=
 =?utf-8?B?dTJ3L1pyd1JRNFoyQUU2aldESnNyMS9UZHIxQjlVcW5LNGRhTk1pTHNMTFY2?=
 =?utf-8?Q?g3kEqJp7YAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUlxeXY5a3lLM0VXUEVLMnNVakNaRWF0Q1FhSVphbzFLSnVnc1ZvOG5GRnFC?=
 =?utf-8?B?MjVBTlQ4VFk4MUlMRHVmTEViaThrUktBMEdJalo4RWJ2V3E2a1JUNEN4RVBP?=
 =?utf-8?B?ZDhEOGFuZFNjS0RwVE9YcUs2Uzl5eVppTFJ3VGllTGxTUkdSQkl2NDIyM3RI?=
 =?utf-8?B?YmN3ZTg5T1R0dHV1OEYzc204ZnlIQ2M2ZGpTcitvcUI0K0lPVVJId2paRnB3?=
 =?utf-8?B?a2h6MFJISWlpR2VxNkNUb2lxQVArazBLVU5BOThEMkEvWmZ1Y3I4K2cvQlQ2?=
 =?utf-8?B?dXpxdFN6MmtBdVZVR3VxMXMraDlwWXBCTUdkeTBBc05PT0dnc0hLaUltYzYv?=
 =?utf-8?B?Sy8rdGdoQmdsQzRXSTVSaGRUbFQrWXBzNE1iN2NtakZMUXgyS1ZXeEplZ2tC?=
 =?utf-8?B?VUdzRVFNREtiV2R0a2hKSFhxY3krNFNCWUNvUUMyNHRMOWlJOUJoc2QxejhF?=
 =?utf-8?B?eTNlOFlWUFg5VGJSSkIwcitWUGhod0h2NmZFblRGVWlzampTZlQ2NGgzRXRm?=
 =?utf-8?B?alY2cHdVR05FRW4zVno0NzJGRDYvb1pybjVybExHa0VEK3hHUUQ0cEdtdFdv?=
 =?utf-8?B?STljdlA0VlR5Yk1lNEtlOGtYeC8rU09CYXZQUEJoOGtDT2Z5eDA5bm14UW1v?=
 =?utf-8?B?QTBuWUtWQkk5ZjBBcXBNbFRTZWZKVkVWbVo5YnhCcTJLT2FZaVpGRGVSTm9u?=
 =?utf-8?B?dFJQTEt2R3JkamwrRkJtZHRSa2hqTzFuZHJJYSs4dE5PVHBESmxyUkFaUjVl?=
 =?utf-8?B?OS8xZEMvT290ZXEwMVB5M2JYdE00YmJkMDhsQkI0eXRpK3gwUS9WbEZFMk4z?=
 =?utf-8?B?Zmx6SndqaDREN0I5RGdCaHhSNllFSkRuMlUrNFlERXhnWGVVNUtib2I5bW9q?=
 =?utf-8?B?MEFWaWcySXo4VE1jRG1xRWljTHh1SzMrQjBvQU8wN251a2JCZkErNG40QXEv?=
 =?utf-8?B?WGcxZzNyb3NhSmd6TXpaNjA0em9BalJyeVpTRGVNT0Q4d2JmTlU4enMxZ2dx?=
 =?utf-8?B?cTJlWmR6MUk5TTZvenZWZDlMZXhkWThOQUdoOUdpRGlUdnhmMG4wUEF5RDNn?=
 =?utf-8?B?WTF4OHlwQ0cvdS9JdExHOVlBdHdtTUFVSmx0M1VQTTZQb1B6NStuVzZRWk5E?=
 =?utf-8?B?aFY0ZmJYekszT0p4Yk1wc3d3QjdaZlBxcEdXTmFINEVCbElKNUNPSm5naUVn?=
 =?utf-8?B?V05raEc5R1NON0k2RGpqQmlQVkFJdjFyRUQwcHdNY29iOUd2TGdKMUlkRFhk?=
 =?utf-8?B?NVBjWmYwWEN1a01yQzFTYXNtUGlNZkgxZXhIZ2xJREJaOFNpTGIvSGJMTm1i?=
 =?utf-8?B?MEc1akpnbjUzRmF3UFkzb21xbmowQWJ6enl5N0gwTlQ5aURTV2NrMEdrZkJa?=
 =?utf-8?B?VzlsaGxjZUx1MVp2eTVNN2ltS3ZVRE9Fazc0R2hkMnBNY2hqL2x6aUg0VmNN?=
 =?utf-8?B?WEFLZ1I2ZlZTaGo5aGo1VVcvRUErVVAwWlU4TmIzaFJqdHQvQXRVcCtBdkYy?=
 =?utf-8?B?L1ZtV3I5c3dnTkh4bFlITXNNS1YrRUkzWDlheXd2eHk3aHdyMk9Rc1ZTdUUx?=
 =?utf-8?B?N1ZCNkdDL2hrSU54elZDcUg5U3o4WkRDd1FDWXpyTkZESnVEWEZmN3kxR2hm?=
 =?utf-8?B?UURsSWpMUFRvSERzNDdaNitpSnhXNHNtd1BLNWVhR294VGtmaE5sZEhkbDFx?=
 =?utf-8?B?TVFSeko5b2I0R1B0bklCK1NEd050NXNRYU5RMTgvR2dVUnlQTkh4L0cxeHk0?=
 =?utf-8?B?TERvV2c5eVpkZ3ZQajI2bmtqMG4ybjVrcDRpV0tvVEVlQW1qT0RzMzRmQmx3?=
 =?utf-8?B?OVl1Q1FBaVJnUDg1SHFRVVU1UUo4Sld0VmxOSFRWc1lxT0JQZGwrQWtibXZn?=
 =?utf-8?B?cTIyenJzMThsa3VZYkp0Unczd2pncWdsRkdrMUJHSGRoaWpyZDIxQzNVMVp1?=
 =?utf-8?B?Um1rVjltTmJmM2pSU0Y5cVdMbDF2UTVnV2ZhcWpvdFhTZ3ZEaytLWHQxQlJo?=
 =?utf-8?B?cHFBMlZ2QU1PbzJ6b1BmWEZCOFRYTE5hRUp1L01SRFJyak0vSXVaZWRZa21s?=
 =?utf-8?B?bG85OWZhTEZYYWd0TlNtaXJxZEIwQ2szVHY0L3p0NmNGVVBrMGJtUzNURm8y?=
 =?utf-8?Q?3fHs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b045148f-46be-4c74-f1e8-08ddbda690f1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 22:35:25.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uk8aTtXfDgYkDBYieQ4+LsNMYiMO4Wmtdw+xlVDPznDfQkPawJD7VF8yUkrwj1Cq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815

Hi Reinette,


On 7/3/25 11:21, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/2/25 12:04 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 7/2/25 12:21, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 7/2/25 9:42 AM, Moger, Babu wrote:
>>>> On 6/25/25 18:39, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 6/13/25 2:05 PM, Babu Moger wrote:
>>>>>> BMEC (Bandwidth Monitoring Event Configuration) and mbm_event mode do not
>>>>>> work simultaneously.
>>>>>
>>>>> Could you please elaborate why they do not work simultaneously?
>>>>
>>>> Changed the changelog.
>>>>
>>>> When mbm_event counter assignment mode is enabled, events are configured
>>>> through the "event_filter" files under
>>>> /sys/fs/resctrl/info/L3_MON/event_configs/.
>>>>
>>>> The default monitoring mode and with BMEC (Bandwidth Monitoring Event
>>>> Configuration) support, events are configured using the files
>>>> mbm_total_bytes_config or mbm_local_bytes_config in
>>>> /sys/fs/resctrl/info/L3_MON/.
>>>
>>> A reasonable question here may be why not just keep using the existing
>>> (BMEC supporting) event configuration files for event configuration? Why
>>> are new event configuration files needed?
>>
>> New interface that enables users to read and write memory transaction
>> events using human-readable strings, simplifying configuration and
>> improving usability.
> 
> I find the "simplifying configuration and improving usability" a bit vague
> for a changelog. The cover letter already claims that ABMC and BMEC are
> incompatible and links to some email discussions. I think it will be helpful
> to summarize here why ABMC and BMEC are considered incompatible and then use
> that as motivation to hide BMEC. The motivation in this changelog is to
> "avoid confusion" but the motivation is stronger than that.
> 

Changed the changelog. How does this look?

"The default monitoring mode and with BMEC (Bandwidth Monitoring Event
Configuration) support, events are configured using the files
mbm_total_bytes_config or mbm_local_bytes_config in
/sys/fs/resctrl/info/L3_MON/.

When the mbm_event counter assignment mode is enabled, event configuration
is handled via the event_filter files under
/sys/fs/resctrl/info/L3_MON/event_configs/. This mode allows users to read
and write memory transaction events using human-readable strings, making
the interface easier to use and more intuitive. Going forward, this
mechanism can support assigning multiple counters to RMID, event pairs and
may be extended to allow flexible, user-defined event names.

Given these changes, hide the BMEC-related files when the mbm_event
counter assignment mode is enabled. Also, update the mon_features display
accordingly."

-- 
Thanks
Babu Moger

