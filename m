Return-Path: <linux-kernel+bounces-741495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F73B0E4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82337B2EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C42280CF6;
	Tue, 22 Jul 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hNYdZ1iY"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFE27CB04;
	Tue, 22 Jul 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215740; cv=fail; b=XAZkdP2v9JWM7Pnz5FzdxmOp1e6sZ8A8L0+DX9xag1YJ2Yn+Tg2zsaqU0ujOH0QZtldxBn1gKVRpEggDDckZeN46pkEZWZONzQ5V3H5Ia/ac+ew0iwDu0ouj0mPHymzYdgCLjTpE9H5HFFMXFEmS6E79J7eSWiNTp9O435fqpJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215740; c=relaxed/simple;
	bh=wHS3UnWB/mKcNc6c6M5Y/84rBMHnZn1HMYys5vt3mV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cPWc4GgN/LGNQkxakaysmleQSE+cD/YAM30QGfijls7UTJuqmb81FROWpJbAMDNQuW6XH7bH4lmmNChOZP3YQ8I0dqRLcdY5+vz0fW+rYr7/5w3p6nz7CnEc/YRTyB7CSiE4+VlNdJvgc6TiF+gUQWNcQgpHyY4xJ4CHPrVv/ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hNYdZ1iY; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScJ77cxZV3vhcbBXsfakSiXgYhZ7+Ar7SGzHVX0rKjWpB5QkaCTU7L4JncxYIsJUM0PtYxnoHfPQoKrDXbN1FdnWOyoGawoMkK1ybZ2DqGiA0iIqz+yArGL6wOEMLGzcc2zMZluSN2J65RH8nEbdJBq8oGR/9lgC6V8tBsdHg/xudWKqnh2S01YK2KbQaLMghu4yXMB5k7pwPRjXjsIiwA1/9mYYqf4Z0yHYTb+Q3Oc9sDIec4RAKgG/hglNfXJymrcx28zy3l7urkNq0J8EuOyJ5QVGMda3CYLt5A1vLgM7Qequh0iL/Kh1q6Zn1N9nM5XYOjWjwTFCQR6SKampjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/VUUC5yZc6ek6rVyEVec+72MqAxjCNB+hBZDfQ5n6s=;
 b=P1zlrnh/z4e+hlJENGvcY21VS3xJdEhVKNixvA2KKkbwIMIyIFJVjCsg/pbi53ExwdI31mFJjQc8ANYEbH2q1cz3sm2ZWZcZGRRP5MSU+jXq7Vajmbkb5UEe9soCjExzXsYpw+xumDO46p/xE2zh1jha9Kb/QKTP2xo3m1HPVDZm0Y9ZU+yufbviY1R9p1xBAicBG5hotH4xqSkvY0wFHUkT3daUTW4KYx76lYAo+L8Qn5jWIeQ3Icsa0XwBjT4tzHnK0BgvOEkEKQx7dTmxtrQ7PDCU+/Bl9U298gKae9rBpy+RdfWchZXRuSrcYQacttX7flLqTbyOyBENsuIL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/VUUC5yZc6ek6rVyEVec+72MqAxjCNB+hBZDfQ5n6s=;
 b=hNYdZ1iYulCjYbtMAlkoxH7yhvLff54lwAN7BlowKA7Fz8qP5gByDCXejwhPwcFJguBPCgh9fNeUsJAjFwA+pVnTi2erZ3HOEADPJaMED8GszTwrrjEqeYBTnpLDzwbJmI/o567Uv/5fpIg8I+ns6tHvhJUFCHMQFy9JA1fVwCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 20:22:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 20:22:15 +0000
Message-ID: <74f1b542-d489-4ff9-802c-5d6d5b8d50b4@amd.com>
Date: Tue, 22 Jul 2025 15:22:10 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 26/34] fs/resctrl: Add event configuration directory
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
References: <cover.1752013061.git.babu.moger@amd.com>
 <0fda2f958001dec07827f803f0e31158a2b77a8f.1752013061.git.babu.moger@amd.com>
 <2028b020-bb31-421c-b7d8-acb9ac7e9f77@intel.com>
 <0fa9a12b-e900-4ceb-b59c-e653ec3db0ca@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0fa9a12b-e900-4ceb-b59c-e653ec3db0ca@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: dd91f4a9-6353-46b1-dd65-08ddc95d72af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UitIaSt6aHpaUXpJQ09iS3NNWGN6cmRjTG9YaE9oVFdiakI3UGRzNGJIY3NH?=
 =?utf-8?B?ZzBtK2VPS0tGdkM1SVljYVZtbzhNYW5USkhuSUZJem43SEttSWgyNUhRV3Fx?=
 =?utf-8?B?dFE0a1BFUnJ6NDhIS29CSjVwaU52MG1qNTFCQ1c3WU92alI1aGFybjBINlBk?=
 =?utf-8?B?UldvRmsvaCtBM2tkQVhTTDUyengzQUZUWWxxV1lYamt4VUd3anpJN1ZwK1J0?=
 =?utf-8?B?aFVQcVhtci9vV3h3SEduV1ZFUVdLSnJjejNBUnlxY3huQk42UGE5dTJaR2oz?=
 =?utf-8?B?elAxVjJyRkNZMkx2UWpyelFwS2Y4S3FXc25TMVc1R0dQV2ZXUHoyTlkvT2pC?=
 =?utf-8?B?WkhTcHBrNlpockFJZFh4UEpGbGJobDNOR1B5YkpIblBrUDlPazRqMnExYjN6?=
 =?utf-8?B?QjFFdmpLcjc0d1lyNkIrNlRjN2oxYmJGSFR5YkVVc094K0hiV3ZEdDB6cGh2?=
 =?utf-8?B?TW1CdHdjMHZxRDIzTEtIT2ZRL0RjNFpwaXh3NERtRHFJMlJWdmdmQmhneU9T?=
 =?utf-8?B?UkhRT3JUYUprV2ZvZmkvNjI2Z0R5Tld2Tk9jQy9DTGVLbW9WQWdLcENva0ZB?=
 =?utf-8?B?d2ZVMWZuYzkrWmdIVGlLRmVKS0hVc2txVXJ1MGxZWkRiR1p1Yzlmb1pWNFh4?=
 =?utf-8?B?NzQxTHZZSE9wejUyMmV0MDJDTmY1N3dTTFlHYkFqeXZTcVF0Q2I5VmRFYUds?=
 =?utf-8?B?WTl0MEJxeVlvbVlRZjRWVEE1VFlkTFZOQmJxTXlGSnRkWFdxV2VsSXk4NWVQ?=
 =?utf-8?B?QytleHhIbnJ1VU1oMVY4WnBJMnZYUy82YjRJVmJJOFFkVnZMN2NkbENpZmV3?=
 =?utf-8?B?R2RZVVVkWGR6aDFJakpnTTFwREJNQzM1R3JDMExvZEFIMENlYzFQNlRoMWM3?=
 =?utf-8?B?UXRqQ05oYm1XRzAwTld3dE5mQW1JenNwUkdidzFFWWgwRTJjWnhwQ1FpWjhz?=
 =?utf-8?B?S2cra0xBRHVMcTlocjFuQUthQ2kxQ1NxUWluRGM5N0JOMS9MRGtWK2h0Nzls?=
 =?utf-8?B?bk5ZY1g0cTlkdXYvUUR4SVUwcWNKSlFQK1ZrdklNTmp6eC9hU3Z3K09hYnFp?=
 =?utf-8?B?R0FIRmVwMmRmYkR3YUl1VWtIL0RhMURGZ3FoZkUzZU9kZDJrWjVRdDIzUlIv?=
 =?utf-8?B?bm5Tc1NPSEE4dEtxNHErS3JWSy9COXJHdFFVazFzQmduanRraEwvQktRdnlF?=
 =?utf-8?B?VVZzWDc5b2sxcnVRNWJBbXJCUXl4aXdLT3YwRFJrcURsa0hYMmpRS1k2VWxY?=
 =?utf-8?B?bHMrZEQwdlJQSXJOM3drTVBXclQwK2JrMFpCcHBLdzRPM3RVR2RIMHhrK3Fk?=
 =?utf-8?B?TzRESzAvK09QL0owcnhJUDRKeUhWY3BrVVJCZWlyWDR3SVlJK2p4UVlkeFNW?=
 =?utf-8?B?bG5BUFYyOGJjMlB6U0M5d1c3SVV4aEppUXZCYTdvMndoSStqelpkL0VVMkRu?=
 =?utf-8?B?NjRLRjlOQnBwUGhjdnRFSmZYT0FsYi91c3VuTTg4cUViT1lRZ1VEQkFWdFlR?=
 =?utf-8?B?OTZYMVRkOEhxUEhiVSszVHhDS0ZjaWtBdi8zRU4weHQzTHF4UTdzU3R1U1Vu?=
 =?utf-8?B?ditjOWYrTjBER1ZkVFRDMmdOSnNNQzRXWWgzOWgxNXU2U0EvNTJ2Wld0VThO?=
 =?utf-8?B?VkgrQWI5MUNkY1g2eEUxcTQ1K0ZZT3VRNVF4NVdCZ1BnQlV6bDJZWDZKdExY?=
 =?utf-8?B?TjdxdzZxd3NTc2Z0TWNHNVV0OXZUYUhXQ3cvWDc1Z1VrZVc2Z0NTV3crMmxC?=
 =?utf-8?B?NFBPM2RWeFZYMmcvNWVscGV1Ykt4Qkk4cUxVcDlwNnd2cVpmRkdac2c5VVNS?=
 =?utf-8?B?bDhpYjNPOFpBcUpIZGVpZGpJenlzQTZKTGVOeG5mY2ZOUlhoL0hMaVBEZ1BN?=
 =?utf-8?B?UlNnS2dvRndtekY2Q3l5ZS8vNVUvUmRIWGpjRzdxb05mQ3Ixa2g4WExwQWVl?=
 =?utf-8?Q?qIZCexgGesc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUFwV3ZPQ1ZGOWFJTThwQzJvb3lMamRLU2xSbEFjSFBaTVBMb3dxNTI3aHZI?=
 =?utf-8?B?QUVRS0NQTTFGOGtSWThNTldjVGdqYWt6QlB3MXR3a0ViNkdWK2h4N0NzQUlk?=
 =?utf-8?B?QkZLakprQkZlWVVqZGtqWkN5dkFHSDR3blZOellsR3Mwa3hnaTlrcmRJUzYr?=
 =?utf-8?B?ZTNXK21yVmVra3A3N1RkOHZiYUxJK2VndFc1M1U4MUNxV1RjOEJmZzJqd3dk?=
 =?utf-8?B?Z3g3SzFMSTFpMUVUQXp5bGgzRlVuNjlYcFVzeVVTN0E0MVVjZE9uSDdWZ3Rj?=
 =?utf-8?B?TVQ4a1JKRDhuSmxIN2M0Zm1PWjNGelFLUmNVR1l1Q1Z4eHh5YTNOTlNXUUUw?=
 =?utf-8?B?VDBPZ0ozcXkvYzRveDlGOXZ2TU5Ha2dtd1M2SEFudWtEdEVZR0NXbk1sd21T?=
 =?utf-8?B?U0J3QVBMWUhVOWtyUThrcHVJaWlpS0ZMWmd6T0drUk1XUTlsbDZaZk8ydVFD?=
 =?utf-8?B?aGxVditUKzdjMnpaYUlRNDNHcmlqQy81MEpOY0xmUnJnNXhBRmRBSzNsR1BY?=
 =?utf-8?B?SzM5bGliN1docTNSU0pOMlpSUmpiU0MvVElQU0k4SUF4aXN2S0ZKUjVwRllE?=
 =?utf-8?B?eFRBZy9EY2hHRHNNMjVoTUwvbW4zckNZRk5yeTd2S0QzdW9ZWjFwUjJZRnVI?=
 =?utf-8?B?Vk5ISjA0bitaSnVPYzZwbXg3TC9IZm9EYWtuaWxoL0hwcEZHTHE5RlRMSklZ?=
 =?utf-8?B?YTBha1RYUkhHWkV0Q1BrREdRUDBncE5pWmF0dlh0WXNUcExyUFJsY01TRnBw?=
 =?utf-8?B?VWEySnFpNGxmNVV3dFJBSVBsSmY2Ulg4WTNOZVNSdWExdGk0VWpyZmVZUjVm?=
 =?utf-8?B?ZFhBWFgraHRSTTZZRHNpOElTVzh1UTlzZWVBeTIwTFdxTzR2ZlV1Nm5IK3ps?=
 =?utf-8?B?aEt5cmlZclEyTkh4QUIrQnBwOEZwV2E5UCtYMnZiRGdFTVlsQ1EzRDlCZGtz?=
 =?utf-8?B?d3pQcHhyWmxsQ3lTYW0zYk92clVjZEMrQWZyUnRJeVMyVXJPcXJQYWpwaDFa?=
 =?utf-8?B?S2xtK1ErNVNBamhsRVNqc0kxVm1SMGN6RU1aMzY0YUNnSWZ6RWRvVWJXd1Nt?=
 =?utf-8?B?akcxWUZyL1B6OElRTk5yTEZWYk5vS204cHhFbTdRazVvTkRNZWlYZUN0UWZy?=
 =?utf-8?B?eEdWbWJjMEdhejI4eHpBYkwwMGR3cUVTckRDdmc2dDVBd3lsUDJ2T3ZvZVpm?=
 =?utf-8?B?cWFPUnRUb0ZYMEJ0dFJ5dW9qajBwcEs2YkI2bDFaSEV5cjVhVmdKQ0E1T1Vo?=
 =?utf-8?B?bXphV1JobDZNN1dubjYxdmQrNjg1UVFQeVg0am1XRm1xaXBBTXo1ZEI2WVFp?=
 =?utf-8?B?NnZMQWtsWXEwT3VadVBJNG5MQWh4Q1JDWGk3UitoYmg0bzlNbXJ2cGFBdXk4?=
 =?utf-8?B?aHBhQXpEakdqdXlYTE9sS2pxeEhiRDVEa3RFam1DSWdDOWZiRU5aR1V5M05U?=
 =?utf-8?B?RlpQVzlQdUFWSnJxZE1vQzF0UWE5K0F6WTFsUHNlYWtPNkJoUDM0WGFIWWZw?=
 =?utf-8?B?UGNnbVpyR0tHeloyZ2VUSks3b1BZbXNvVmZBZGpwSkFUbUJ4VW1zakExMldi?=
 =?utf-8?B?VkN3bEZYYkQ0WHNhZHJsTHhBWDc5U011VVo0aTRrN3VJYWdBY2NRSGJZUVNB?=
 =?utf-8?B?eWJKZjlIcmFkOTIwNFBveEJ5MkVWN0o4N3dOWTEvdkkvN0oxVHdsT3prQUMy?=
 =?utf-8?B?VGhrZGNOUlgzbnk0RmlsQklKNlViUUlLc29HMmZ6OUY2RUd1RlB0cFNidW1h?=
 =?utf-8?B?QnZkVnRweDBSNGFXaDVudGVaQW5GZ2Y4c0wyeVJSaTBQK2xIZVd6Q2FGSnFP?=
 =?utf-8?B?RjBSdHIrUUV5VUJNOW9qWWEyQ3Irb2UvWE5HRHpMUFAvNkJQNTIxYXh2R2pv?=
 =?utf-8?B?SzQ3Zm1iaVNXb05KTnZrMDIvV01jd1BrakdEcWtUckFYTFJyNllWbDZIMlBj?=
 =?utf-8?B?VTN3elFrNk45VWx2UTdrYnBndzdPV0dUV05POFhRbmRSQStVV1F4TDJpaWp1?=
 =?utf-8?B?L2w3aDBqZEpKR0N2R0h4MFFKYktyUythcFlWTHVnK3BjMzczOE83ZldMQlVa?=
 =?utf-8?B?b2NsYmZJS3lsMzZKTmlIQ2hzVlhoQzZJZ2pEaDhKM2pwRi9zcVl0ajgyOHIr?=
 =?utf-8?Q?L/GA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd91f4a9-6353-46b1-dd65-08ddc95d72af
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 20:22:15.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDLVhlllKW7u0WYrQTKqRjUEpATPdNKsvNr0nYyyRV2J3oix3RmEHy52/4kR3ttb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089

Hi Reinette,

On 7/18/25 17:20, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/17/25 8:54 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/8/25 3:17 PM, Babu Moger wrote:
>>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>>> index 15d10c346307..bb28ef7e4600 100644
>>> --- a/fs/resctrl/rdtgroup.c
>>> +++ b/fs/resctrl/rdtgroup.c
>>> @@ -86,6 +86,8 @@ enum resctrl_event_id mba_mbps_default_event;
>>>  
>>>  static bool resctrl_debug;
>>>  
>>> +extern struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS];
>>> +
>>
>> Please move this extern to fs/resctrl/internal.h.
>>
>>>  void rdt_last_cmd_clear(void)
>>>  {
>>>  	lockdep_assert_held(&rdtgroup_mutex);
>>> @@ -1895,6 +1897,25 @@ static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
>>>  	return ret;
>>>  }
>>>  
>>> +static int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>>> +{
>>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>> +	bool sep = false;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
>>> +		if (mevt->evt_cfg & mbm_transactions[i].val) {
>>
>> mevt->evt_cfg could possibly be changed concurrently. This should
>> be protected with the rdtgroup_mutex.
>>
>>> +			if (sep)
>>> +				seq_putc(seq, ',');
>>> +			seq_printf(seq, "%s", mbm_transactions[i].name);
>>> +			sep = true;
>>> +		}
>>> +	}
>>> +	seq_putc(seq, '\n');
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  /* rdtgroup information files for one cache resource. */
>>>  static struct rftype res_common_files[] = {
>>>  	{
>>> @@ -2019,6 +2040,12 @@ static struct rftype res_common_files[] = {
>>>  		.seq_show	= mbm_local_bytes_config_show,
>>>  		.write		= mbm_local_bytes_config_write,
>>>  	},
>>> +	{
>>> +		.name		= "event_filter",
>>> +		.mode		= 0444,
>>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>>> +		.seq_show	= event_filter_show,
>>> +	},
>>>  	{
>>>  		.name		= "mbm_assign_mode",
>>>  		.mode		= 0444,
> 
> I am looking at the SDCIAE series now and it really looks like rdtgroup.c is
> becoming very large with code from various areas mixed in. In this series I
> requested several functions to be moved to monitor.c but generally did not
> highlight the main handlers added by this work. For example event_filter_show()
> added by this patch. For this work, could you please take a look if the
> handlers can also be moved to monitor.c? I think this will make things cleaner
> since the same helpers and data structures no longer need to be shared by multiple
> resctrl files. For example here, mbm_transactions[] can remain private
> to monitor.c where it is most relevant. In retrospect I think this is what
> we should have done for the BMEC work also.
> 

Sure. Will move event_filter_show() and event_filter_show().  Let me look
what other files to move.

-- 
Thanks
Babu Moger

