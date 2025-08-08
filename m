Return-Path: <linux-kernel+bounces-759644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ABDB1E09F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284E37A8922
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E0417A303;
	Fri,  8 Aug 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KLWTAOq1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C21F7FD;
	Fri,  8 Aug 2025 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619876; cv=fail; b=FOGr0Yhy1IsI8zjIV86huXsdX0nCaqQs0/8M98EvH1zuFMhDmwOtLdUv4zb7A78T7J2FnJcBDRX1ogmiswdKZ/ovX1secFBbofPhDvmk0vAW7Y6DtiJhzf5KhKyVep8YfjjnZ8FVLFSteIMwiF1w3LR3/EQfc2fNrpTS0kUPpxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619876; c=relaxed/simple;
	bh=7DFCdgb4o5AQsRhtjUs11N8cXmdkXG0yE1AzMvDOhu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1Kw0v5um4bLveWeSHaDuJ4uuv2la1QvvW8AV8m9utl80l26/xzJkKdQAPzCmQC+NqJ/hVV74icPob+2eVIR0SHvlliVD3yddnKdmFLZLjUpG976WUiHKb30GeNXbRGOCtGnVkmcaSx+oVvUi5/rXYJf6lK/1xF7Lt0OsYSiEA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KLWTAOq1; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twOq9YuyrGCs1zRQigN/Mjc55//xlTp6mpzCeBwQ0h1QeudYs6pR7hqWANv37Ki6HNlhxYuHNDfyZv+Q+AUXTqAk7fnYN4A5SBVRy7Ozq+yw12AeCBj2W+tySW93UpvasiDHL1Z7NB9/VS0lKl63IdJErhSRL+NMTGMU5bgbnnqxPvw+PNj/3wZLGYXZ7v2A2XeRAbEi9Alzqmcdxho2C+jVvOKBqo0JWnKbe446n70gXDNt14kwE5+OH6WxkJlFQjnebI/yXP9XN3/xjTaGu7LReghTXOXuEnBKBNRV9OQspzCTlm4Abbzlh5D7suEJXHRmi56C/vnT4jBJAIx4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwX05P+tMJotZ2BEGMIwHJ3MfaTm0u+WYiGCKZraERQ=;
 b=vllfGQlhcOYwMkvXThp70Fb7GUmnWdq74uIVa3QrnVSlGaZp8GCE/fvS44jProLqdxof3Cs+jvI3gcticx7tegQ0Ow1hOz9MxegV2WyQl6KX7HtluTFTpMg1d5NNpTxUoYpPB09QTqiNrr+4y0Jma4gYBJ+ltimoyIL3c1h7aHTtgRsu4Xaf6z8jWVRZOjQ5ARWrK4RjwMHUxCMAnLeF44J4rbdxP7POFBi9E0xF2wr9hD+uK7eSlOWMH47w4j0KOY3yAFru594Xiyk7AV+U1r8lzaif83lTY+uxOJkI+pxStrmboo5Z69T8B6+Jy+ZhObP9D34hTChPpQnOerxgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwX05P+tMJotZ2BEGMIwHJ3MfaTm0u+WYiGCKZraERQ=;
 b=KLWTAOq1O2pJK4lIhOKRYe7LjGGnaOqIdeTq8tIZnBjd5EIj0+7SZ11m0mYGjPG1nADiJ8ruYVsTaJ6mUdOFJjSHwcwQZURUGWPKUhbsrjIodfG5JdOMuTDE5zKeDiPnhDHlxfRwm9cMicrKk0TViMr4N2D00WYdQdUUA8cSUeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 02:24:31 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 02:24:31 +0000
Message-ID: <3cb65c95-7394-4888-9d32-f697ce0efe31@amd.com>
Date: Thu, 7 Aug 2025 21:24:26 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 24/34] fs/resctrl: Add definitions for MBM event
 configuration
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
 <b32329e151c841f2b93987edf72ef39d2cde9191.1753467772.git.babu.moger@amd.com>
 <368b7310-6ee4-4fa7-ad8b-428d05136328@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <368b7310-6ee4-4fa7-ad8b-428d05136328@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: f0784b9c-487e-449b-0890-08ddd622b518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlpzSnpFRFZiZmJFdm8yaUo5NDQxTGZpRUd3SktNdElHYVdHQzBZQ0ZHZWFZ?=
 =?utf-8?B?SG94YlZLWkJ4RnpNWllnVmdvS1dCck4welFCL0hrS2VBR3BiVC9DTEpZUUdy?=
 =?utf-8?B?eVVTUXJxd0xrYStxekV1QjhtMnQ2YmVIRDA1YTBxUC9pTTJYWGlCcDV1ckFo?=
 =?utf-8?B?RkxkZ3UxS01mZlhXcFc2elBlVVBmb3lySlkwNE11K3NvN05TMG1JMTNpdUxV?=
 =?utf-8?B?Mml6OUtPSUtQby94MVJ4SUxabW1USERscFUvdHphSDA3YnJHaThCM0dycHlR?=
 =?utf-8?B?TjVhVHQyYlM3amFaSFZtMlV1dkE2b1Eyc2czd2I1eHBIQWFpd2h5Qk16V1hY?=
 =?utf-8?B?dFY2Ti9BQkk3eUJMRWkvN3lxbklLczRydlcybnN0VkR6SG8vdE12ZHltRW1Z?=
 =?utf-8?B?QTY3bkpMbDlOOUgrTE8zNlZGbjdDQVYyTm1lemRZeG1pSEZyNEJ4SWlXZTNS?=
 =?utf-8?B?QUk3bVJmcCtiZU1NUEF5aTBGdDd1VEVWSlNYczNBejU4VkxYZ2NyYUFNMVBh?=
 =?utf-8?B?VzVURkxscTlraHg3alQ1NWF4SUhOTGNRNFRDOG80NzVVNzhTZzhobWFtdjV4?=
 =?utf-8?B?TzJVeUVubzA4UERKeVF4WFp3alBDZkFWTlg4NEVodGNTeWxZb3o2MlppUHpI?=
 =?utf-8?B?R0NMdWoxa09CS3h1NkRETi9wcEYzRXkwQVlzNk5jeEcvZWJxekVadmNIZUZG?=
 =?utf-8?B?am5OMkIxMWN5bHZUMFFQaTlrbUJMQ0s5UU1MTmlFUzNOS05DZmlrVUsyZFRw?=
 =?utf-8?B?dWJpcVluR1VTcDFLR3lRdWVuVStmWU1GYTdUMUp1RzlsbWZNZVU5WS8wNmZB?=
 =?utf-8?B?L0xqbGtTeksvbHZVUUNET211Y2x1QldJWlFWQndWOGRDSjZQYzR1akpDTEQy?=
 =?utf-8?B?VWtPU3hkZmdhMkpqOS9lQ2ZZbG5pYXRqRDJoM0NiTk41VEQ4Qm9pY3JMb281?=
 =?utf-8?B?cE0vekdNVmNWaHVDNkxmZkl4V0NZeklxdkFxS09ZcSszUUsyN29iZ1NHdVhz?=
 =?utf-8?B?MXNMUE5VbGNGL0lpK1pDSGFNaXkzZTBBMldLeXZtb051ZThsZ0t5VCtqbm9Z?=
 =?utf-8?B?a3Y2dWxZWlFIdko2Y0xac01lQkJ6cWpkTHlnQzV2RTg2Unc1dVpYSEl2NFcy?=
 =?utf-8?B?LzlRaWJPYnRwekQ3T0QzeC9YMjh3c3hLUytEMEJOUmYrUU42R3oyemxZQzJu?=
 =?utf-8?B?QS9sZVUzelFJQk9CbDIvTU0vdkRzZmlOcHZZclllNmVYWXpFQ281L3RjSkhT?=
 =?utf-8?B?ZWJUY1ZkTFpUcG1KNlZaeHBTRlJ3dnlLS3ZWZCttenltWkllSU5PRWFRWkhi?=
 =?utf-8?B?NVZOMENSSk5kVFFYMU10SXRqdWVXNGtPSE4rSnhldksyMFQ5bDhQcFF0dFNl?=
 =?utf-8?B?NUVGMTBoc1VuWHNjVlF6UDM1eXN3Y04yam94a0k0YmtyOXltU25UM3lTTmRa?=
 =?utf-8?B?REJNbncxQUJ6ZWF6UVIyeUczc2gwcTBMeGZtUXI1Szk5UTBXZTZCWDJaeThZ?=
 =?utf-8?B?dys2a3FtTDF1eGxBVTF2VlZNbUM5dWlJN1phK2RyMVgxN3NDTGl6dW1CZ0tO?=
 =?utf-8?B?dXRXNkc1dnpyOEhJME9CMm9qZUxZM1BMMlJTL1lDQzNmU3dzL2FYODBTL3hL?=
 =?utf-8?B?cVl6bHJnRUJnV0VhdW5QNjdYUlZ2Q3AvOGU3eklMc2pDQ1JLQTMzblVSWElM?=
 =?utf-8?B?cFpPTzVVblhISWtQNk16SDRsS2ttQk1yM2NyOUlDRFFhOE1xWWpLaXY2ZllC?=
 =?utf-8?B?cjFXbGpUZVVDM3JPdjV6d2g3R2N0bjZmRHhBaUhvZjY0TVVwUEkvQUUwRTFq?=
 =?utf-8?B?U3NvTFNrUUZGN1JKUzY5RUZCd1RzQW1NcERQOXV3Q214ek5PWG5OZzA1dm1W?=
 =?utf-8?B?TWhTNlIrSEZvQ2U5S0JSZVpNeGhlRnZ6YllIODdPZld3R3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBVR0hXcVZRQm80RUNhUWZKSnY2amRnengreklPL3hsckwrcG5wemRoZzRL?=
 =?utf-8?B?L0czaVdqQUFaeGt2YmxDYkI5Skp3Z2lFM3RRT0l5OGg4V1ZJSG5oOHZlOW1D?=
 =?utf-8?B?SWQ5MjJpZ2YwckhCWXB6RnhRcDhFTkxwY1ZkR1ZFNi9Sa0gyZEZBRmd4YlRx?=
 =?utf-8?B?UWxVTVVyYlVpbzdGNFpsZjBVN01hY2x5UGV4MFJlL1VVQmJqRi9Zc0E4SWRE?=
 =?utf-8?B?UGF1bW5mTlZpNFpobjlwaUdZOTZiWTFkK3Z5ajZMZGJ6KytPa3hwNkE1d2tj?=
 =?utf-8?B?SWZDdWVKK0l4MlBabDA2eVFpUzJSUWFYUXRIdkRjcm8zQnZOWHJtdHI2VmdR?=
 =?utf-8?B?ZG5jNGdGM1JlbXRzb3lsd3pHZ0drUzlrcXVhUzdyb09mTkFqUm1nMkFLczAw?=
 =?utf-8?B?RTNBOFdvdGE1dzJ2TWwzdFpZbUt3M3ovNjhKUko1QzIzRkFqUTdTN1hNWXI4?=
 =?utf-8?B?QjVNWG1rNkJEN1F1SEsxelUrbHlWaU1NVUdIeXJpMm5MSElCbXpDN0lGL3Rm?=
 =?utf-8?B?dDloY3o2TS9QQlBDMml6d012V2Y1STgrZGZzbW5ZZ1NLR3ZTelFadWVXWXJx?=
 =?utf-8?B?UnRHNk84elE4QWVrRE5LNnZlRG4wZ3R0YmxkZVNtQlBvNXcvT0tDTTg3aWsx?=
 =?utf-8?B?blVnYU1MSU9xNXJkS3VMWjNRRzhpdmdZbDhHWlRXb1FMaDJUaE1WTi9GQ1o1?=
 =?utf-8?B?blBiZEQvNnEvT1hMTVNHTjNDNjMxMHJ1T2U1QWRLeDVrWXdvRGxUT0g1Qi8r?=
 =?utf-8?B?UVRCK3RyK0NPczZvSTVpb0Q0VlpEbGpEVUFzaE5aeDdsR1owK3M4T0U5RCt2?=
 =?utf-8?B?UEcvdEFaN1Z3cTVTZ2dGMjl5N08zc3ZuZndBdlNxZ1MxejNUT1J4dCtPWk5M?=
 =?utf-8?B?aDZ5MzBtS29CWlB3bCtnS3llL2ZaNWZ4aVFFTjcwazNPdXJaQUtSNTUzYTlt?=
 =?utf-8?B?M2cwZXY5L2plOEtkLzdTQXlOTUxaQkFyY2dSejR4clM0M3htKzkwRksxckRX?=
 =?utf-8?B?YzZQbEI0bG5hTU90Wk1sNG9aY1k4QlNVSFA2dE1UTEMySlZhcklIL2RRYytm?=
 =?utf-8?B?NzBiTThsTkczR0xSVHZTd0YwcXoyTFoxZkJ5aUxzdDlZVWhZa2lJVmt5azBT?=
 =?utf-8?B?Vll1VGpyZmtmRUhMRWZJRWdFb2pkVDQ4QzhvcXdlQlg2NzNPTTZMMWJNb2ZZ?=
 =?utf-8?B?dk1hSHZVMm5hSHhVaTJLZHVlbEdOZS83aVE1bzAzaFQ1RUJOUWkzMkkxdUVo?=
 =?utf-8?B?WVpWcFk5N1R0aDA4RHYrQXZ6OVEyQUMzamUwV1Z3eVAzOS9DSmhkRUFtdmwv?=
 =?utf-8?B?U0tZODg2SG1zVDYxL0c1TUlCVUR6Tk12L0F5SS9SeWxqV1VzWUhDMEtZR00z?=
 =?utf-8?B?NGJlak94d0RuR1NKbUthelpHV00vK3JnbEF2dVJGdUF3SkFRQUZZaHg1a214?=
 =?utf-8?B?VEF4SGd6M1plTm9ST3lERmtBSHkrM29NM3BYNitUY2lVdGlmVE5JY2ovWkp3?=
 =?utf-8?B?aW8zRXRUYi9VZTJVd1JQZGZrNG52bXpUeTgxKzlIbDZhSXE3TWVCVG5CN2d5?=
 =?utf-8?B?ZngyTXZLVXZIdW5Vc1VlNElURmdQNzF4aWdYTHdpczlpZ01LV25qK1F2SldQ?=
 =?utf-8?B?czIrbDRWdy90MkpDakllVUF5VjJaR0crRXVBN0liZGsxdW9zR0tSV3Fzc016?=
 =?utf-8?B?RkhLMkRycGZrS3hFMUVDTVcxZWlDMG8rY2VCSlgyYi9MYXpwMVVySXJvMGxR?=
 =?utf-8?B?WnRWRUwzbkc5djZmS2hUTEgwU3MvWm1UbWZhMTdSNG8yY0ZLZ0dlS2NJUkhi?=
 =?utf-8?B?eE1iYmw3Zms3VDRxOXBjTHNDWng3L05idmszbGpuQ0sxU3d6dWZSODZsN2Nz?=
 =?utf-8?B?TWlHOUJ1ZGgxRk4wbHFXeFlTa3pXUko0aWoxT0MyUmg2UVhrWVdaazVtV0pY?=
 =?utf-8?B?U1JmMnFsbnh1bUhHV3BzUFhvZnV3Q1VuWWFaeVJzNGNCalJqNjhPWFFuTVVS?=
 =?utf-8?B?QnNzM1hkR01QT29jMm9WZkhSYTRDdi9SRTUvUFVMR1hEdWpxRVFXVFdDSkdn?=
 =?utf-8?B?WG01dGg3cmVwZ1FzZ0ZIV3EyT0tDbHlYR0ZiNWw5M2IvUFhzNzhNMU0wazNq?=
 =?utf-8?Q?5M04=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0784b9c-487e-449b-0890-08ddd622b518
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 02:24:31.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugCiS3G2Ndp/wXcnAOldmGnqdjC5NHG5JZS0kqTZHZakZmN3CTEUmbnELQDJwpEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951

Hi Reinette,

On 7/30/25 15:03, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> The "mbm_event" counter assignment mode allows the user to assign a
>> hardware counter to an RMID, event pair and monitor the bandwidth as long
>> as it is assigned. The user can specify the memory transaction(s) for the
>> counter to track.
>>
>> Add the definitions for supported memory transactions (e.g., read, write,
>> etc.) the counter can be configured with.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  fs/resctrl/internal.h         | 11 +++++++++++
>>  fs/resctrl/monitor.c          | 11 +++++++++++
>>  include/linux/resctrl_types.h |  3 +++
>>  3 files changed, 25 insertions(+)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index eeee83a5067a..693268bcbad2 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
> 
> Looks like only monitoring code in monitor.c needs to know about
> struct mbm_transaction so this can stay within monitor.c ?

Sure.

> 
>> @@ -216,6 +216,17 @@ struct rdtgroup {
>>  	struct pseudo_lock_region	*plr;
>>  };
>>  
>> +/**
>> + * struct mbm_transaction - Memory transaction an MBM event can be configured with.
>> + * @name:	Name of memory transaction (read, write ...).
>> + * @val:	The bit (eg. READS_TO_LOCAL_MEM or READS_TO_REMOTE_MEM) used to
>> + *		represent the memory transaction within an event's configuration.
>> + */
>> +struct mbm_transaction {
>> +	char	name[32];
>> +	u32	val;
>> +};
>> +
>>  /* rdtgroup.flags */
>>  #define	RDT_DELETED		1
>>  
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger


