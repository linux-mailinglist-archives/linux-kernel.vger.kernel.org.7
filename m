Return-Path: <linux-kernel+bounces-765469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA930B237E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C31B66D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419072949E0;
	Tue, 12 Aug 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VsZD18ix"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180213594E;
	Tue, 12 Aug 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026202; cv=fail; b=IPH2jYWmm0GlFRx9muwMRtyw1KDoV6GRjGX/zWJ4ObpOyu/a+S3eVrkC9iQ6QcwriZFNTlYvrZBibD8SsBMx3vXSxq5fXCk0uWgm6kwqO3nCQuUC+1YOETQ3OZ2eY8KBI0yW4fTQ1sYnrqzShZi4EsPlexWUq8gvv9FgMQQvylY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026202; c=relaxed/simple;
	bh=O74UpP51eiE0E28xGSye7FT7SBd0OqsCpKTfbYODcdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mvMzOC0eiYTp2l7SX8B1Xt9NsOzkcmUHvNq2T9DFbMbdxHWGfb3kTY/dgTHRsy0S1h/akroYBKTa/VMMDxJP3oVMMCSKrkC/5ds4GGU+WCJUIQYtLF3+uI0cI+CYAD/kALXRvF8SAruMeQvKw0Zgt5B01E6vBrM8YyE3IQDe6j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VsZD18ix; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOKfAf+ejqMWf5ZapzNUxBISSOa1WKym8pN9jeE1sxsuRzFjlAwnWiprcfLNfyjzBwkvkxowQkdV8JG7zU2wOOklEDbFUcFV0kfcsXG1ifTrEMbKvsr0pZIppHgatwL8zQ9VoDP08WiylBfBB+dTkxVzcswGOn+cPktDMMlRKQUuzRroMhJ8SS+lUaoTjEMkeO8656pDxXzr7zcH7/SXvW2AVAIn9PG9AopRDAqawXeqsp+ePyWOPsv9fkuzFOxXftumgFt92yyod77epNl6KNkmKmszl2OYpkjvL2CTkHemmiPw17aeS53ZDw/iWPp7Wv05vv74wOYxhgF+841M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw2JoYZFRt/+LiHiNrOc8UKNUUbcYGWnWCyCWXxtOfk=;
 b=QIkWD+mn3QnNZBp2ZCznSvgeBWTC8AfthkmUHiLE0u3ycbT8tiU748Z53quJU+bbQ2s1eYWDvTNufw1c42v6brqo9fjVTDfnTSHI+Z4Rxeyq+YOiTEbJ506EW6lT2njTtwgWXXX1HsHQlPpEu/bPlrToAbYMZtOuvSnFLnGgG8GDcX1CFQkg7yrNXlllu5ghgZGWTyvINY8XzQ+VUrihCPraM3WndxIKkGDKVE7r/HiyXkulG+y2p63/KCCg5U26f43xuRL4dlKN8IJmAZ/Y1iQBbqdO8m6zX1sLzhJ3oX/aFKwjakUH1zBlCK/upqvZRxi53qRbzbIwDOg3nwAfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw2JoYZFRt/+LiHiNrOc8UKNUUbcYGWnWCyCWXxtOfk=;
 b=VsZD18ixqlf4MnVCgwsLNVTvHxfBKPwcNS28p/P5O78mdA1eUujqS7pr5zs+FWe5X7+H6CThgHLZh5ROkTqb191ck7581n3lIe6l6H7bVFy+NPsWpee4GRmlFFr1h60WnH3VHGR9fYUf9qGIxx4JTtComFEuZNHwbDrjz0zgOHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN2PR12MB4407.namprd12.prod.outlook.com
 (2603:10b6:208:260::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 12 Aug
 2025 19:16:38 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Tue, 12 Aug 2025
 19:16:38 +0000
Message-ID: <c5d37c3d-f6d8-41e3-bc32-699c53de8152@amd.com>
Date: Tue, 12 Aug 2025 14:16:34 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 31/34] fs/resctrl: Disable BMEC event configuration
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <a5509fabd688c9bd1ee14571c9e00793f34afabd.1753467772.git.babu.moger@amd.com>
 <46e6c50e-ab7d-49c0-b06f-aec51558af70@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <46e6c50e-ab7d-49c0-b06f-aec51558af70@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS2PEPF00004561.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::505) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ca47e7-7eca-4e67-ca1a-08ddd9d4c2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0R2cXE2WVVCV2xVSElGOCtUV0o1L203UDQzRDRDZmtZWVV6NmFIVkt4L1dV?=
 =?utf-8?B?NlczTmRaQkNRYXhNMGVZUUZyWG50bDA2MFFRNjhYY1pmN2xtR05VNng1QXNC?=
 =?utf-8?B?VElzMU9nQnAxdnYzT0pDTFF1T3doMGFvVkY0MlRVSkJZTXN1eElhTzU3TWZD?=
 =?utf-8?B?NmlSY0c0Vzc2eWdBOHF4SnBQa1NMVTBIY05Ia1o5TTl5NHFkYVpRbDZHdXdw?=
 =?utf-8?B?THFMdVZwQy9Hc0o4Q1ZYZGRWQkIzR3BBMmY4QTFXSUJsV2pCYndKRHdqd2Mx?=
 =?utf-8?B?UjZERERpMWpUT281ZTBIN0hVZ1UwQk9pWGd4bUgxOEJRNEJjZUJqcjAwaldj?=
 =?utf-8?B?ZGp5OUY5ZFczdTFyQ3ZrdFJ1aS8zSHBjbTU5c1c3RDcvWUJ3alVBc3RYM254?=
 =?utf-8?B?ZEVvV2tYSEFpTjYrb0FnL1AwbEdMTXpVRDFCQ05BVVYzVExNdjhkUVh6Nzh4?=
 =?utf-8?B?L2R0VE85QjlZVXJQdFZBNWhBTVkzQ1Q1YVh6Wm5wZjQwNmoyWTVpZktNTWhq?=
 =?utf-8?B?QjVJMjZBQ1RoQlJqMTA5V1JLOS9YMzBNeVVSenRoZk1HaXk0RThrck5GT1A3?=
 =?utf-8?B?K1ZTbmIrczJRL1ZMcHdWZlJ2NXU3VXBBUGMwOHptdUhXeStnVGFnWk5iUUJt?=
 =?utf-8?B?UGFQTHZHQUpJckZ4bmJsOWxqeHd2NmJDeHI3bHFrMTkzOUpXMFFyYmY3b1pY?=
 =?utf-8?B?S3pPWnZrR3RxM2Y0Wk5mZDRGTGVzdGx1THYvMWtMWnpuSjlPeFgydHlPZnNM?=
 =?utf-8?B?WFdtZldzTFJFcFVOeDI0Zmo0Q2sxNVdqVG5HSDZMaDFtbktLVkpoeUlIZElN?=
 =?utf-8?B?ZkdYdS9PMGo1TmRuVk92bWZ1ZnpKTnloMm5BNXRYb1oyakRpa01sVEZvRk9B?=
 =?utf-8?B?OEhNOGpZOHFVaHZZVXRlUVlmMXpCV201dEN4WFU5MExzMjRzUE12azdNU09I?=
 =?utf-8?B?eDNXQlFxaHQwNWdHWkcrbWw4aEFtUTlJZHpFcGFuTnN1VHVCSExHd0Y2SGZs?=
 =?utf-8?B?RysvcHAzYk9IOXF1S21jN1V1b0kwL21SUDZrNVkxMEdTUDhKMkRVYlVnSjV2?=
 =?utf-8?B?WUtJZHBWS2x0cCtsc0c4ZDNKQmtzL25mYzhBSDhhNkdnTTFrZ1ZFVjZudmow?=
 =?utf-8?B?cU9sVU5PUUJXNDhYWmNmMm82Ny9Ld2t2MHc5dnYxT25VVnJXWWhmak1NU0tE?=
 =?utf-8?B?R256Z3BSSUlOeUxlbmhwbDQrOE1uTE8yd3AyWER4dFpuQTlpcTlTc3hkTC9t?=
 =?utf-8?B?Q1dESGxBa3dSMzNlUlF0Zjl0NHJTQmJkQnplUzNkR0lvOFQyT3VpVXFUMjU2?=
 =?utf-8?B?SW92QUVROTYycUJiYi85SXBieHdxbHQrWGFnTHhGUWFyZHdkK3BBWUJYL2pX?=
 =?utf-8?B?UDYrdzFXUGVXSGdMKzdGS1pUa2w2ajV5NGRlZEx6cUpKNzA4L3BFSFdHNGJa?=
 =?utf-8?B?eDRJS0VoTjhQcEd1MkFERllzSW5kQ2dmcHZBSmUrUm5zNFdPeDRtR2JvTHh3?=
 =?utf-8?B?UXl5VXlkQTdFTUt4ck9mM3k3MnhGZkdiYVhxSmFJUDdVbnUzbW1RZktKMFFB?=
 =?utf-8?B?RmI2R0dZY2hiUlZnK0ZxWjZQV2NVMUR0bkZxZFhuWE9SVG1xQmxjaWNPVHVX?=
 =?utf-8?B?Qy9qU1k4alVrcG5aTTVEU3ZXSTI3Q1ZyNWpaZ1MrTVVKTU1QNzduK0RRRGMw?=
 =?utf-8?B?TFo0ek5NVDBiK3RPeGhaSThWR1FpeDBpeFBXdEZoK1hCVURoL1FqRVBBQXlR?=
 =?utf-8?B?UUpUUGdIQWRWQklrTkNtcVFNT0MyVEFKUG1qU3RZTVpnMlROQ3g3M1paS3JY?=
 =?utf-8?B?S2JYMmNDNm5IR29uNVI4QzRpS3FPTEpMcFBlSHF0bjc0V0pQSEdyclU5N1Z2?=
 =?utf-8?B?a3F6N0luOWE4WERIY2NUQkhqaERFL2NjMnNLRWpVbGhkVWpBUlB4UDlJSlRW?=
 =?utf-8?Q?v618Lh5ls9E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHdvelB3ajB4bkl5VW9IUHROSEN5dytVblRucFRoNGNReEJpSDBSS3BTdXQ5?=
 =?utf-8?B?K3lJWU52RHVTeGdqellhekVoc0hpUFlCQXhwbktZendkbnAyZitVWWJFVUo1?=
 =?utf-8?B?bCszR1JaZFUzeGFHaTRIVEJUZVAwc0hFOXdRcE9ROHZIeG1wUmVmUjVzZ1la?=
 =?utf-8?B?N3lKencxenRYNXRqY3M5akQwZThKdDhNdjBVMHVzandIUG5nVURWRnA5YTJG?=
 =?utf-8?B?NlM4N1c3eGREaFdzcVVtdTFWZE90R2xvbnFQYnRZSk9WVDlqbklUd0wySW1N?=
 =?utf-8?B?RWVqbjBsQjFBTHd3a2xVVXYxS0dpb3Q3UCtHSVBVY1pPQ0xFOGlpZlJSOSt0?=
 =?utf-8?B?Q0tQbVpQTUFWb09DeDh0dFQzYjFFR29KdHAvUVlWYXozSnNUdk9FYjZaWEsv?=
 =?utf-8?B?SlJTcHBocHpycTJXdVdnT29Ba3QwSnQrdHRsd2ZXWVhuSEVDMWVLa1dYNVRs?=
 =?utf-8?B?WHk3UFJUSDRwYkZjTHNVdkIvN1EyK3J3c2FUWXdFWkQvQWhvV3puRld1NFkz?=
 =?utf-8?B?elRnbVJyeEoreFJ0TWdIemQySHlERFFHTUxrZkNpaVQxUHgxN2QzQ2I4Z2NC?=
 =?utf-8?B?emx1ME5zcFUrSzVQMEZTN1M5SjBUNVo4ZUpKcndpYVFnWWREdVUyWFF1eUIr?=
 =?utf-8?B?Y2Njc0g1OGdubXh4ZU85bUFvS2dFcDMvR0NiOHgvWHBHNmVxM09NS1lGRXFQ?=
 =?utf-8?B?U3lRTmFoZ2JqajZGeGt2RDVuVXM0Zm9aTDAvUi9CaVAzTmlYZnpJakIyZzRq?=
 =?utf-8?B?ZG5SYUNXT1dzQzZWMHlNcVQySWlPdUFrNTNRUVFxUVpzT0xpM3l1UHlCVi90?=
 =?utf-8?B?RVJvUHZXc0VBVlJjNmRDWDF2eGdBZm1vQlU3WWlHYzU4SmJiNW4rZFFmYkN0?=
 =?utf-8?B?QW9EektscmFOYTE1bGRPcWR1RHBXNnY5Z3ZpYTUzMkpqVWZObjJCNFpJRnVv?=
 =?utf-8?B?elhaYXFNajNqVjV1Y2Zzdm5JQnBIZ29PNm95ZDV6YS9lVjE3cmhDdmFBQzJX?=
 =?utf-8?B?bjhJcXVSY3h6LzJrRHpOUmIyVk5GaW9NaDBNc0FVS282akhwbUs1NUYyTmJS?=
 =?utf-8?B?MDhabXE4c1hQMWVLM2h0OEI5dG9ENXZtdzVQUWhPQTU4MDFSU0FpeExmTGZN?=
 =?utf-8?B?WlpFYnBxMU1TWCtqUXhHb3BzT1pkTVFGeFNhclBxa2o4ck56R2x2d3EwUkJh?=
 =?utf-8?B?RlVCdk5qQkJkMUVIajloV3RaSDNpTlRhUkc5UGx2STRVQlcxcGxUeEFhUWdQ?=
 =?utf-8?B?bDZnUzlWcHhpdDZRSGpsdSsrWU9XMDJYaVh5dkNZZkl6UTVPMjd2b0JTMzlu?=
 =?utf-8?B?anR1aXpkWUkxSGVUaW4wekg5WlVDMU4xM1ZKRnM4cVdGSWMrVXlKSUpGQTFH?=
 =?utf-8?B?QXV5Ty9XSGVFNDdVMXlKc2IycDdNYWVPN0VYQlZ5YUVxaUFpYVpmbFFRZTRK?=
 =?utf-8?B?b3pYRm5LQXVrMTVCRkxWeUlnNm1FOFVQSTJ5SkZGdGxTdGViR0QvSFc5VnJP?=
 =?utf-8?B?dkFGLzQwY2hCODlQd0YyQ21haG9RQlBNZ0RoUFpPbHhBbzJtUDAxTE1WUkpQ?=
 =?utf-8?B?QTFKSWxTaFY2cGdtWDI2bEVhTGU4STFjVHFhdjZDaHNnT1pYNTdwVHJTZktS?=
 =?utf-8?B?Vm45QXJiL1NnM0JWN3lNT1ZsbTlkQjlmZFJFY3llZ0VtVXpTL2pKRjV0Mytt?=
 =?utf-8?B?cWgzdW05dGQrdXVkN0VRMVlDSUZJZGgxS2czdVZKZHd1ZE5nWlJWb1lhMVJ4?=
 =?utf-8?B?a1ppQk9EZ2U1ZkFvUStuNjQrUWwrSzRIS3BZMlo0WnJROWFCNDBXUkU1WmRv?=
 =?utf-8?B?VURpYk1uMnhMc1ZjMHlXZGNVUlB2bCsvRlA1K01wT2VYbmQwMkl6ZmFaVElD?=
 =?utf-8?B?MUkvSS9hRHFyVktuN3EwZWMvNjl0SlNuOVFRLzlkb1MrWFdyemU2NnF4Mlh2?=
 =?utf-8?B?eEFkOXdISlBMSHNsQTNDV1J6Q2dadDZJbFJIejYzVFhnRk5NZ1pUUnF1d2xL?=
 =?utf-8?B?UVg2NDFhQjFGbW52Z1BPK25pSW44ZGNTQnd1Yy9UZUxCQTRLWHNPdXVtQWpo?=
 =?utf-8?B?MFIrbDJhKytiR2VtSzExZDNhZ0ZwL2dIaHdkcFlrckRiSW9FcmxpREd6NzFk?=
 =?utf-8?Q?2YKc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ca47e7-7eca-4e67-ca1a-08ddd9d4c2cd
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:16:38.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCGVu3IaRiRme8XrZdyTQBvPa5yq3WDU/x3LvDYkDGzVScAQpi8tj7MandMZBCv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

Hi Reinette,

On 7/30/25 15:11, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> @@ -1799,6 +1800,41 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>  	return ret ?: nbytes;
>>  }
>>  
>> +/*
>> + * resctrl_bmec_files_show() — Controls the visibility of BMEC-related resctrl
>> + * files. When @show is true, the files are displayed; when false, the files
>> + * are hidden.
>> + * Don't treat kernfs_find_and_get failure as an error, since this function may
>> + * be called regardless of whether BMEC is supported or the event is enabled.
>> + */
>> +static void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
>> +				    bool show)
>> +{
>> +	struct kernfs_node *kn_config;
>> +	char name[32];
>> +
>> +	if (!l3_mon_kn) {
>> +		sprintf(name, "%s_MON", r->name);
>> +		l3_mon_kn = kernfs_find_and_get(kn_info, name);
>> +		if (!l3_mon_kn)
>> +			return;
>> +	}
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
> 
> Looks like this will drop an extra reference if l3_mon_kn was provided as parameter.
> 

Yes. Fixed it now.
Thanks
Babu Moger


