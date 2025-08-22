Return-Path: <linux-kernel+bounces-782775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE0B32533
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DE61C83BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CB2296BAF;
	Fri, 22 Aug 2025 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kj55SHQC"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE427602E;
	Fri, 22 Aug 2025 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755903204; cv=fail; b=ZWYjO6ltxbD703MqV8Ng0K7zykMyH5mgQWSM8mPloeVx952pVF+tK8McUqjsGdYqC0ET06a4K/E2QfnfKF2iskGPZHaS/ymZQJ2UeQ7GSfF6hT6p5owXxMF0rA5EVVlfXBZ5hHm65IXqwCpEmwD75DHH67XWMA79aBrZ1BY8FCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755903204; c=relaxed/simple;
	bh=4EVad9Qg9zZQt35sYknBqYaSVnBrJw7cpEpmyEmrJvE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kx8lc5jNl6P5xuEHzAXVaoHqowvu6VpmYjxJYZcXZSqCnhLziVovExRms03ZJcVMBN+kKkO/oUyoGgtMJ+8TI1wNeQFyvlRtSxDDqzmNOa7pAvLNz3HYl4CX9+8eubeLlgiU33jGqqC3eAwg8xRIFHelZXDrawPfLSiYdntmv38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kj55SHQC; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q740aurczNmHUiIGq7jE1OmJUgSD+XDoxSVxUQRIk+rEaGMsuZl8B7FK1pQWhKoBFi0UMY8gXc58ZlGfNY8RHGfmrMDqd5hm4Sv/m9iWeEmGr6MEm9FW7N5+L6V9YdRH+akYZpl00T1Y7RVMC3ka2IrbBj1XYWxKrw7FjfjjmyR5oaq9D1vK+QJc1saWdAUyZ2L8GYwIuuARvl4FSW4b4a+pq2FxYmyh4gdpVKFoQ/ykrKre1EoL808GQNbyq4Nh+t8fmvcJ5bR5qnaItnjGXBAHJ6DFVp1hFFCE36HrspRBSHxZzts3TwtWur04utm6NJyFUcF3UhVw0j05lnLsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m8uTI8ScOvgSsyp8aNgr3dmNRmL9UFEu2UQ+o2V9fw=;
 b=YgtrExeMs8zhiILiw3mVa7cCNosUXdhyitXUtAt11LlgBOdNEh0FpkB84agFqdowVemOYXoMSnf+RR4mOKiRvAUzAFwRpS9VcmbLmdHO3eXiWU2JY6o3RFmHWpzH5gUcQVAEx8o5ugsYfwn//2bIYQwjGfY6cyXGnMf3p8RGz+w9OjDxicD2H4PEJDN15EtQbVZBQY8qIEoFrXe/W73SvC2wgS63nkjGCH+HioBZw19NH4lfnf6/9F3ISrlMI4RLgq+UZwEPrSkt+hagh+5Kd/VCptNGbzaUAftaAfbpWvCU3/pHVY0H1GRu8kWpL5lkTH2/JVmLwRDkIZ7AJOZ8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m8uTI8ScOvgSsyp8aNgr3dmNRmL9UFEu2UQ+o2V9fw=;
 b=Kj55SHQCfii7PCHYaQXpID6hOX/rxVkBEjpGVifyuOefO14WkcWHUJkcNBVGOVQch7CvybDRo/RNUHXA3E+wCFAhrDK5/5ajfPh1N10UE/nmJLZpri+AaxFCgV5+smVZWi42FzoDzZuqZC7BGF02dhFBjZPWtAZ98C/grSSkOkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CYYPR12MB8991.namprd12.prod.outlook.com
 (2603:10b6:930:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 22:53:17 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9031.024; Fri, 22 Aug 2025
 22:53:16 +0000
Message-ID: <d5438a53-c803-4704-84db-1da019f50a3d@amd.com>
Date: Fri, 22 Aug 2025 17:53:10 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v8 06/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, manali.shukla@amd.com, gautham.shenoy@amd.com
References: <cover.1754436586.git.babu.moger@amd.com>
 <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
 <0dbdff85-1d32-4540-984c-e8eb4b940cc6@intel.com>
Content-Language: en-US
In-Reply-To: <0dbdff85-1d32-4540-984c-e8eb4b940cc6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::27) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: b984b710-f216-4a34-791c-08dde1ceae94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWtvN0ViUG4yL3hSQm5RRUpzVG9sMTVBcFJGRlRYdVpuTGlxRXBWQkhNc1Uv?=
 =?utf-8?B?c0J1dUlxd3JlL2pUSTFVbUx6UU5hU0JMaVZ0VUhmeXVuNzZQUnd4czVFWGp6?=
 =?utf-8?B?SUlXaWFabDJhMldGZm9KdTNMNUk5TnFROElmTUlyRnFWOEcveUdRWE1VME1G?=
 =?utf-8?B?MDNDSkRZSHdrOEdtTjBlY01pYVYzWGZiODFVZk1iL25CdGZKeVliWncwWGFn?=
 =?utf-8?B?S21aalhQRmZIbUZtVVBtc2I2ZEJaTHl0aEY5eEpNZkRUUUdNREZmbEFwc29q?=
 =?utf-8?B?cE9mUGJQWEJLbUR3MC9uQnEvUlFRZWFxbUsyVGc1SDhXcEpnZVZ4amNQU3V6?=
 =?utf-8?B?SFY1KzFoUXdac21jZ0o4WUdDOEhQclQ0YWczSDBRUVJ2bkpzUTBycmVpNzZ1?=
 =?utf-8?B?RHhCSC9kdzVIZlZIeTNaaVRxYTE1YzF3U3Fub1lRRmJwUGFNUjlzU29zdDZo?=
 =?utf-8?B?all2RjNHNGJreU1pV1FwWGJOb2ZhS3Z6M1Q1Z0MvT3RHOHRBajk3dFFJUWs2?=
 =?utf-8?B?dktTTCtCN05KK29QZEx5TC9oWkl3YUxIK3NmQ01VWUptNVg0cVJpTXRYUkU1?=
 =?utf-8?B?QWxkTThhS3FMTi9QeVFwSFNqSkdmaGlxRDQrbEttMHJiVWdGQ2lvZnJFM1Vj?=
 =?utf-8?B?VjVHcHJqQVNyVjRQd2NpeUI2UHVCK0ZubzVFSXRjcEhuMWRta0dzdy81bUg5?=
 =?utf-8?B?UkdUeHNCTFduWTU2L01sR0x5Nlp1c0d4MUI4MTZicHUvTnBiUSt2VDN1eVpy?=
 =?utf-8?B?M2F3OTdJczJWL3BSYy85VU1HLzVudTg2alJJV0FEdEJ3TUh2eWhmRFVSL0dt?=
 =?utf-8?B?VHZ1akF3REM5UkZ6dHdkRDJ6T1p2TmdLTWtHNGdVRWVDQTVVZ0poMlkyemk1?=
 =?utf-8?B?TEx0N1pZNkt2cHBjMUprOVAxL3lnMzNtYzkvM1dyQlI4Ty9qbEg2VlB2Yk5n?=
 =?utf-8?B?UXdlL3RYcXM4OC9wWC9xcHpBYkZYQlQwdEdxUXJIZ2ZySmpmRng2TGZvWWpq?=
 =?utf-8?B?V2l0WE9RcDA1dEZudW43VStybHd2T0gveEh3blRvNC9IVEZYbjhleFptdzRF?=
 =?utf-8?B?eDNqWUxsRGM1MHFSTGZTeG52MTFyVEhGTUJYam1HdEFFbkcvQU5FeTB2YzNF?=
 =?utf-8?B?WUtZMjhlL3M2Snk2eDBlSnpQOUZaa2M0UFdIaGZONDh5bGY2emsvWCsvQU45?=
 =?utf-8?B?NGY1RzR3UkpnMEQ3dTZ1MjAzbCtna2ovZHd2Qk9VOUoyWW1vdVlBTXlhUFBj?=
 =?utf-8?B?N01UY1JCelJsRkIwVTBRM2c2dWZUKzFZZW10OWFaemVNcFBKeEgxWXVjWGpo?=
 =?utf-8?B?L3Z3QjNucDdEUTFPT0ZFd0VaUHlEYUMzVUJtMUlGTHhMU01iQW5HWVpCZGpj?=
 =?utf-8?B?bVd4aFRpNzkxVG4vaGhqVS9aMnl3WDlRK25hQzFNKy81ZjkxNm9kQm5BSzlN?=
 =?utf-8?B?NDM5QlNxd1AzakhLTUp3RzdpajR5clBCY0tiTEtwc1BZYk5OWW0vUjN0Z3N2?=
 =?utf-8?B?Ukk0Y0Z5RE5jSSttb1E1Rk1KY1JmNUk0Zkl6R3FUTjhsb3Y4cld0RUhFTVl5?=
 =?utf-8?B?L1JyY3phUXJyWjZXcmN1cExWUlFNcEpxdithbVhSL3BjM1JlQjZ1aVNIUm9w?=
 =?utf-8?B?YUJPaC81VWJjWlpMRCthaERPZ1VCZ1h0T2xwQytkTXdGY3VMRlY1QlRSMGpL?=
 =?utf-8?B?elNKS1diVnhTQm5MSmZuaU9IclR6dFJhbWpYSXRQTVNpYVdYdWJHc3N6MzBI?=
 =?utf-8?B?R0l2SkVOQ3FTbU9UMW1QUFV3WWRkdEZPMVJFdUZnMVZTNVdqbHdaelJ2WE1R?=
 =?utf-8?B?Wm1aTktaeXNqaDF2dUEwVEc2OVp0V0NoaU5kall4TmtzbGdpVGRRRmNHbHhu?=
 =?utf-8?B?K25XZmRjZGxKY2lWZm1jbWFYR1FyZ0ZyL3I0S2hmcmVJYXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmd2SnM3d1c5WkZ1Zm5vaGlvWnl3ZWtrV2oyR1hlWDljNklCUStFek5idWNZ?=
 =?utf-8?B?U1pXcGtuVTY2N1RPTjFHRUlmTFVuc0tKTnRTaC9iQUQzcnJWZkthWU9MMXlr?=
 =?utf-8?B?bUhSYnByUUtNYm1JdnlPWk8zcXJkZk1va3JtTDNGaW44cGpieXl1bWk3NmVn?=
 =?utf-8?B?dUNucU9aR0doeFp6a2c4dVdpekI2WXZsUEl2OXpGQ0dMUmlrcWxhRmZhTjVR?=
 =?utf-8?B?SmxVb2RkTVpLTlA0dE9SSy9hbDUvN2hIVDVaUWpURHQ4ekNQYWlUU3RHNVlN?=
 =?utf-8?B?WUpNd05udExhK2t6NERXT0hiQW9SMmErWkRxbGVKVVptZENxUXNMY0dMaHF2?=
 =?utf-8?B?eHhSM21wcWdPNnhFcTljeHMxQ2VqOE9TTllYdnpac2J2Zk5aUGlBM3pJbHNM?=
 =?utf-8?B?OFVwenE5eTlIY1pmOElDK0lZdDV2L0g0M3paK0tSYndXeTI5MUpmbmJhU3lY?=
 =?utf-8?B?WGk0Mk5oZlJGWUJIRnVXTU43cm9YdW5TMkJCbG9EQk1zSUNQVi9lZW8vNnpp?=
 =?utf-8?B?NnkyY1YydXg0M250Tk44VnJhM0pvS3lHRWFYdTc0YnJkNHE1K3p2bDNhYnBs?=
 =?utf-8?B?QmVtQVdLSTd1SkVITzRBTnNZdXdaZXBPNlo0d0l2Y1grMmVsN2xQY2p4T3V2?=
 =?utf-8?B?WUFvUTAxUVF5eTdaZXUzcmdpN0Z3THI4cWZuemRkRTFWUGFoOEkzZHpWM0hq?=
 =?utf-8?B?cUZmZ1M1RkhkcjU2Uzgvd3FDWGR4RGNwN3p4TUN5OStMV0JSMjAwdjROZVQx?=
 =?utf-8?B?bGxpL2tValNXY0pVMU1EQjExc2FFY1NGT2NDMEZQdGtkK2Y2RWZQTDdDOGJ5?=
 =?utf-8?B?R05lRkx5UVptQkExOWg1S29vcjduUUZ1L2NwRTZtaCtNenV5akFDMFlSVU1J?=
 =?utf-8?B?V0VHK0VwUlkxOTVYMnk1YTZ3a0krQ0xWSkt3ZytmcFNtMXVRN2hqelVNTUJ2?=
 =?utf-8?B?NkU2eW9Lc00zclhDb1YrbXRseEdjWGZZcjZGQnlIRGwvQzFneld5dHZ6Nmp1?=
 =?utf-8?B?bUJ4TFF5ZmpDMEdxVWthVVBYU3lBVnNTcTlJVFNTWERpVC9CUkZ4MlJWTXM2?=
 =?utf-8?B?YUxIU0UxeEppdGt2d3dUZUZVc0tiVzM3YUczVEJadVdFU2pVdzgzTzVTUm9z?=
 =?utf-8?B?QlBtNmhLbVgwa201TDUvZzV6dlJmT29rcmN2SDNlaDhzNlNyd1FJUjZPdWxu?=
 =?utf-8?B?eVA5TDZKdE1LblhPem82b2dLa2lINnBoeDNYZElrTGV6L2NhU3BDMTdHOHRH?=
 =?utf-8?B?N1BIYVpoRXlxNHlUbk9SYWxURGRMQVZsbE9ZSEhGVGN3c09nd3FQajg2S21E?=
 =?utf-8?B?R0REajZkWEZPd2sraWVFbHpWQWd6T3BQajQ1bjVSVnZPMVVVQ3BFK0VIdFY3?=
 =?utf-8?B?NDZLZFdNN2JmTExzQkV2OTYyQWhzSm5aQm4rRlB4dkY3YmwvT1V2V3FURThB?=
 =?utf-8?B?Smp4dVJPWU1KMTZsLzZEbVV4azVVbHgwaE5zU1FEK3hidW5MYU9BS0FrNVQy?=
 =?utf-8?B?SDlPR1F1M3hOblEwWmE4WDVrVUpVcWhzV2tCamJOQXhtdVViL0ErVFpFcS9r?=
 =?utf-8?B?MENJS2hIdTdTeVVOcW05aWlQSVRUUkExcllUMFZMVS91dURTWGlkcmVpc3Bm?=
 =?utf-8?B?end0M1Y1VWtkdTM0RGl3WFJ3MmZtRWhycjdVQlJ3ZmU1WEFmd1JPc1FZOXBC?=
 =?utf-8?B?MGViOFJVWU1xd1VSSzFOUTBwY3huRnMxbWFQQUJMR3d6K0J6Z0RHOE43RTBx?=
 =?utf-8?B?dXFvYXRzbXhwTmpLc09XWUNmYmtCb3MrRklRVUlYYklQVTFETVlqQU1Tdit1?=
 =?utf-8?B?aTdqZEYwNDdENTBwNTE2Sm9DMW9LRnp2VE53OHZlYUhqc3JibGFhVmdlaDJq?=
 =?utf-8?B?MytFUXFHRnIvWTRuYnN4TnhKTm8rQTJGNnNqWDdxQW9hd2JyY0lMV0tVL2xl?=
 =?utf-8?B?bXU0TUtkc1dRRGFWRm9hRTk3cmtvb05CWURhOTZjR0wxd0FKK2NPZWVwS05F?=
 =?utf-8?B?SEJ6TVVUYlhxWHZXU2ZKV29uVjlXVlZvZDdQSVVXQUtXODNtMTNLRlhQN1dm?=
 =?utf-8?B?c1Q2NU5nK3J2b2ZJbmZVTUgyc3QzTGR4L1pzRG9OMGRsVlk3ODRleTNDY1lj?=
 =?utf-8?Q?AmKY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b984b710-f216-4a34-791c-08dde1ceae94
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:53:16.7026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKdIiVhfhkMeGm5xl9jLOandbs0NtC/5uq8OHNB3zOa+aFgW/42tIuA4Nrq2W4yD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991

Hi Reinette,

On 8/7/2025 8:49 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/5/25 4:30 PM, Babu Moger wrote:
>> "io_alloc" feature in resctrl enables direct insertion of data from I/O
>> devices into the cache.
>>
>> On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
>> exclusively for I/O allocation traffic and is no longer available for
>> general CPU cache allocation. Users are encouraged to enable it only when
>> running workloads that can benefit from this functionality.
>>
>> Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
>> "io_alloc is supported by maximum supported CLOSID" part of the initial
>> resctrl fs support for io_alloc. Take care not to expose this use of CLOSID
>> for io_alloc to user space so that this is not required from other
>> architectures that may support io_alloc differently in the future.
>>
>> Introduce user interface to enable/disable io_alloc feature.
> Please include high level overview of what this patch does to enable
> and disable io_alloc. Doing so will help connect why the changelog contains
> information about CLOSID management.


Sure.

>
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index d495a5d5c9d5..bf982eab7b18 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -685,3 +685,140 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, voi
>>   
>>   	return 0;
>>   }
>> +
>> +/*
>> + * resctrl_io_alloc_closid_supported() - io_alloc feature utilizes the
>> + * highest CLOSID value to direct I/O traffic. Ensure that io_alloc_closid
>> + * is in the supported range.
>> + */
>> +static bool resctrl_io_alloc_closid_supported(u32 io_alloc_closid)
>> +{
>> +	return io_alloc_closid < closids_supported();
>> +}
>> +
>> +static struct resctrl_schema *resctrl_get_schema(enum resctrl_conf_type type)
>> +{
>> +	struct resctrl_schema *schema;
>> +
>> +	list_for_each_entry(schema, &resctrl_schema_all, list) {
>> +		if (schema->conf_type == type)
>> +			return schema;
> This does not look right. More than one resource can have the same configuration type, no?
> Think about L2 and L3 having CDP enabled ...
> Looks like this is missing a resource type as parameter and a check for the resource ...
> but is this function even necessary (more below)?

May not be required.  Comments below.

>
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
>> + * and unused) cache portions.
>> + */
>> +static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
>> +{
>> +	struct rdt_resource *r = s->res;
> Needs reverse fir.


Sure.

>
>> +	enum resctrl_conf_type peer_type;
>> +	struct resctrl_schema *peer_s;
>> +	int ret;
>> +
>> +	rdt_staged_configs_clear();
>> +
>> +	ret = rdtgroup_init_cat(s, closid);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	/* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */
>> +	if (resctrl_arch_get_cdp_enabled(r->rid)) {
>> +		peer_type = resctrl_peer_type(s->conf_type);
>> +		peer_s = resctrl_get_schema(peer_type);
>> +		if (peer_s) {
>> +			ret = rdtgroup_init_cat(peer_s, closid);
> This is unexpected. In v7 I suggested that when parsing the CBM of one of the CDP
> resources it is not necessary to do so again for the peer. The CBM can be
> parsed *once* and the configuration just copied over. See:
> https://lore.kernel.org/lkml/82045638-2b26-4682-9374-1c3e400a580a@intel.com/

Let met try to understand.

So, rdtgroup_init_cat() sets up the staged _config for the specific CDP 
type for all the domains.

We need to apply those staged_configs to its peer type on all the domains.

Something like this?

/* Initialize staged_config of the peer type when CDP is enabled */
         if (resctrl_arch_get_cdp_enabled(r->rid)) {
                 list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
                         cfg = &d->staged_config[s->conf_type];
                         cfg_peer = &d->staged_config[peer_type];
                         cfg_peer->new_ctrl = cfg->new_ctrl;
                         cfg_peer->have_new_ctrl = cfg->have_new_ctrl;
                 }
         }


>
> Generally when feedback is provided it is good to check all places in series where
> it is relevant. oh ... but looking ahead you ignored the feedback in the patch
> it was given also :(


My bad.

I will address that.

Thanks

Babu


