Return-Path: <linux-kernel+bounces-758386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 598DDB1CE55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485247A2127
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271321D3E9;
	Wed,  6 Aug 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pjUkmMDw"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6E1E25FA;
	Wed,  6 Aug 2025 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515174; cv=fail; b=i4AQWbMLDtLj/tvu/OTHpxFeu518liL1y08LhD6M66qw3YORyseDRv6KnBSoQj+0SmKLjG9TT/iJR0mXbitEe7fZ6XGU94t9wV57JCHHdigHz3zk0+djDF6sX5tpR6UiAiWbAMJPZWXMOL+sRJZDWIOQCsKSFXEQembrGnW5zF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515174; c=relaxed/simple;
	bh=1TNRhPxa3C/ZGz//nB1crKwl22OFDBhgOi0evpz2Jjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mrO30qJRjYVQWiK+99A6pKAJ+mjx/0uFZSNWAJx2DUXoTKVdzNR5jCHBl3eApHdTsjTjp01SFoXBQi5jJL/TrlG/QMr9z6M/6LKMP2KnsBNoCx2O+1SYScb3Y8torNOljX58lPVPsEXgvdkLXUb83qHzeHqXooEVU8VLp72QeLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pjUkmMDw; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jowZL5pqDRjyZZSwAJqmSLBkCH57ltLrraPELiR887J5lFZt+VtcAimEVR0HV2bzVulI42ikNyH/CuHz87fTcUe8qcBpDM+joSguMUOugbF0ZTzrmVpLrzWBtn+UZAaoD8hleBS79PMXRs7+Xy0Zkqdq9nGbRQeT2WAw1RewRa6xglkEQr9hRnDrnLYFM2paCIQyQuKg92crr516x8c8pcPAx89RbZ9Frp2lr27U5IrK8I0/GFBZnWgbMxbXTuRiC+4QCPFLFm8k65liHsvn/G50jNND+qUXK//MDq+jSc08mmHz+iZukA/v+O2afBCHkYk0KLoRMRVNDG6uJdE0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DDVW/6F9mXQNxFDFmtkBolcGNu1DvB22zIqNwIwn70=;
 b=PBPRRx6H4hobDOwHbD8hSL3nlf09BeUFnWV44ljzfk0gERpnC+gg0UIGFtJ2Xj0OIFgfkSqF9rokcVO0Yyj63QTI93rGku9xeCulg9/coDKb49+3du+nYpPhQqPCJMX9H+1DhA4fHIur6SBW4NT+MunXsCcQX7pVFCUw8tHws6TDaJkV0WPXMEPAs0Sz+1Ag1KDBVWcHt7HmOQGukeLeTbafpNPiwlk4WgFjpgfS+Fm+qLVXTtd/iuVJpEcIY3BbNslSw0Bikf0W4tX5cigLFwWSgRqyXr9DSok9rFcjnvn3gizZzFto03JskaLnES0PKj1pvBOmSL016hIekpqEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DDVW/6F9mXQNxFDFmtkBolcGNu1DvB22zIqNwIwn70=;
 b=pjUkmMDwkcvKatGk2wDqkvCGcyWHNBZXoM1rLtXyrM18qlysWdGoGiLuZBN0rSgybnbvSSy092YtT6UtycD/yHtqUBXlmEYYV6AeLIl7veITAZLYVxHcubfXQbYuI+WkHzda6jl+IzN27UXxKT+yN9Cfp1IY1SgMaegwasH2ed4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ2PR12MB8720.namprd12.prod.outlook.com
 (2603:10b6:a03:539::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Wed, 6 Aug
 2025 21:19:29 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Wed, 6 Aug 2025
 21:19:29 +0000
Message-ID: <a549c986-5914-4e00-81d0-994c933550c2@amd.com>
Date: Wed, 6 Aug 2025 16:19:25 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 13/34] fs/resctrl: Introduce interface to display
 number of free MBM counters
To: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
 <9e805169d3fbc889a89b283d074a5dff23cb0e94.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9e805169d3fbc889a89b283d074a5dff23cb0e94.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 327f1221-b594-4927-1e3d-08ddd52eedc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXpFaVc0VWhERVNJN2dwUkxSQ2pYczlIM0tkRlU2VlhXMjhOUTBOd2twaHl6?=
 =?utf-8?B?R0tWNENNbVg3ZlpYVHl0RWlTa2M3Z1M0NXdOTEtaNW8rT0l5eHRHVGtDWXh6?=
 =?utf-8?B?QkZkUHQzVWJNQS9ITjVMNi9BWURhbVZEQUUzY0FFcHNrbm5LWnJIM0M5bUl5?=
 =?utf-8?B?YUVwamlsdkJjcktDNyt2REVMditFdlFld0MyT0RIUExVUFV5VjVHWkRPdDdF?=
 =?utf-8?B?K1JBZmhEZDhZTnFBSElpRlgzai9NNW5EYmZSMEN2eUtXNk13ZFBkTlJveE1z?=
 =?utf-8?B?cDdpdTM4S2hYc051ZDRUYjA5eFF6VUxKWjdCa1ZTK216Tkt3ZmRqbjk0akJW?=
 =?utf-8?B?RXY4cnQ2cm5YUThEZjV6ellzVTRjRVlTQWdHTy8yYVl1UlVVaExUSEhzVEdp?=
 =?utf-8?B?WncxWXlLajNvMlNBY2s3QW9YYjBCODA5ODFQNTRuZXRTYkFZdWtYRjFNaHI1?=
 =?utf-8?B?UExtSDJwRlozUXFBSGU4eU1LeHczYVFBWXVFdlRxYVM3cjI1Z0FqYVZyUERI?=
 =?utf-8?B?VGh6Z0RKVlBvVjhiZ3JrSCtRdU54NURxcUFkOVdLc21SeVNYdXZUc29aRDFO?=
 =?utf-8?B?VzJvM3lsVXpRai9JOVl0bzRLNjRMK2syRS83cjBJRzdvY0FtaHVXS1U1aGFN?=
 =?utf-8?B?ckM4MzEzS0V0disxUStIWjJrTjFyVkdlZ3JzYm5BTzVGZU0zNXk2S3c3M3JN?=
 =?utf-8?B?RUo4ZXUrQnZkOE5XY3phcVhnclV4ZzNMODFlVHFVeUZUMm1JeC9pSVNDVU1M?=
 =?utf-8?B?cHAyWWdIOUR2elpKZHVkV3dvSld2dy9CclFpY241S1g5WDRmbThpWmF1aU1j?=
 =?utf-8?B?K2daSVFKVmJFNnhrbmRGVHU5NWxtUGhDMmYrZUhoOVdRTTU2eWhjdGo5K2po?=
 =?utf-8?B?c1BPS3N1NWJ6Y3BzdEhaQnJPdllBQWxURzd5SyszT1ZQZC9INE5kTzhPTUxm?=
 =?utf-8?B?YlJPYkhCWjgzZzB4aVlKcUdrY3c2Uk51U094TzZqenhlWm9iVmZTM202RmxC?=
 =?utf-8?B?U0ZOaFBvWlJoazVzUUtQNHNMcm9oc2tOTkNEaStCYldXa25LU21Ebk1LQXk4?=
 =?utf-8?B?Z2dNMjNhZ3dERHZpVzBNREcxL1pyYUh0NUk2RnRxaWVVemdQUHhsbkpmNXhp?=
 =?utf-8?B?L3BkK3E1SmlyZDlGaGFoemRsVEVyS0xMVFM3eVVpYy80VWRXdGxkOXE3MHNw?=
 =?utf-8?B?TmdlNkpaNWk5YWlLcllUL3BBelREK1lCangyTENmMUlNd3JxMHJGQ1pnTEs0?=
 =?utf-8?B?U2RBcnphYkRBNkpLTVdOTE1YN3gwNHF2NFVPOCtzZWtzUnVtVGtaZml5WC92?=
 =?utf-8?B?aDR5T1Z6a3pHQ1ZBUzJyc0pXcGJjUEViYXAxSVVDeHdKNjhjQlRzM1JrYzJQ?=
 =?utf-8?B?UEtUTTN2cWN2L2FDSWQ4cTgyMGZ2QjdyYTRacXdqNW5uWHpkRlZWczRTOWlG?=
 =?utf-8?B?MXBQWmVPSzQ3ckRFdDhPMjRhc2hwUjZjVDBRU0tKbXd0cFFXelhLUi9ibHNZ?=
 =?utf-8?B?SlcraVBUaVkzcmVBWkFlRUFRaVJ2U0dxMXN1WjRKOFZZM00xNGJBam5yUUN1?=
 =?utf-8?B?WWFaQXhnSkUrVEw0a09XNWI5RU1MazJVcVNYVmJ4NXBsSlk1NllTZGE0VW9l?=
 =?utf-8?B?ait1cVJQKzNmejJtRjdpUEQ2aWs1Y2orMWorVzIxaWdmbjR5U1FDOVRhZDQz?=
 =?utf-8?B?d0U1c2RwdnB4TXVjVTJCTk1ORXZQNXBIT015Y3JzQmhiV1RaQkJJZmpvSHlh?=
 =?utf-8?B?Q3JqRjEyQkdtVDhKdUs4WGlWakxkRVFBWTN2UUJvMXhLaEMwTXhWSjZBZHNh?=
 =?utf-8?B?dlhTdkxlc1pKRE9qWVpLTVB1MndwVHVNN2FHdW5RbHUwMTNsOUFXNlFlaExy?=
 =?utf-8?B?VmFMSGZyN0Z1UCtUTWRPVkttU2VSckZDeVJUSVRmK3R3b3Rnb1YyaHJJMkor?=
 =?utf-8?Q?NLuY8rQ++h4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkduS2FBY29rcnZQMjBJT0hRM0NRb3lGVWw3YTRZUy9rTVhIVE5HVTdJSjRi?=
 =?utf-8?B?a014RWdLVHBRb0lXeUtuWDc1by9Kd0tjQTlPMk9aQTV4UVg1LzdxTWQ4b2dh?=
 =?utf-8?B?U3RoMEQvT0xwc2Jxa040T1lLRDA3T1U2VkY1cGRTYzljU01USWFndSt6MnJN?=
 =?utf-8?B?b0x3eG1PSGhyajFiZFpzdUpYcG9WZkhJWmd2Wi8xZUxnWGJLQmtPSG52WDFI?=
 =?utf-8?B?eXRtOUdwWVp5clVmTUlteFFCa1JNUXpOck1mdmlCR05QNCtxalFlWXhUdnk0?=
 =?utf-8?B?WTVkcTdTSlBvczF4TlhObU1mbTZjYjZUc3VlcWo3MGhqRDl4L3dHRk93R3Ux?=
 =?utf-8?B?THY2WUF3YTloS2V4a0RhK2M5N3M0c1h1TTFsTUQ0VGMxUlVmamxTRUlFOCta?=
 =?utf-8?B?Rjc0azRlaks3ZzhSQU45R01Bb0gzM3V5MzhRalBHbk1kOWhSV2o3QURXck85?=
 =?utf-8?B?MkRrRzB1TVU2VFEvU1QxN01CU29RWTdSNk5UOGJYL1IvSS9oZTdkaHAxem5n?=
 =?utf-8?B?bUJYZkhhajNMS2NpYnRPcGFsRGNJNzV0MVpkM092am1PMFFiTS9rdHYzb0p0?=
 =?utf-8?B?eFg2eHFlRTgxRlBJMTlQVFozM0JrOENYckJ0ZkhhQVR3VVdWUG53N05oV3Zw?=
 =?utf-8?B?TWRtWk5Ra3M2cW1kZHcxRXZxZ2x1dlIveWZPMjk1bU14SG5JUC9iNWZoQWZJ?=
 =?utf-8?B?VmJpdkJwelowb2M3WVI0Ri83S1N2aGhNMXFLTFcvOXI2THBvRjRPRjl3bVNV?=
 =?utf-8?B?aWlDdmNYWDFHVEtjVThFK0tYbURLWXVZN1JZdEdRQS9mNUp3VnArcVBEV0o1?=
 =?utf-8?B?NHp5S3BWbzFNSjFMVEkxMDJtK0RqMnJYOHBaUjRLSjZXT2I2dWVRQ3AvOXor?=
 =?utf-8?B?ZTRoeWxNS09GTDZkVWpzY2krYWtzdTJLNnY0RUJZeC85MS96MGFrZCtQd2ht?=
 =?utf-8?B?VmJpUjJwdnJ5WEs5dEY3MHQ0T2JKU1l0dnV6ekxudmZVMm1aZUZBd05ZRUww?=
 =?utf-8?B?YVo5cGs4VmlKbkh3SFNiRXdYbTBaVnRWVDR4ZjREMGQ2V2hma2RybWdQVm5I?=
 =?utf-8?B?MnRpYmdKR0ZOZDkwcHYyVHViU0JqaGtwSnV2NGtiMURzSWU1anM2c0lQVFQ3?=
 =?utf-8?B?UG94L29ONVNGSGl3dGV4b1R3YlVDR01ROWpETkhkY08zQzNxOE9nYnd5SHlh?=
 =?utf-8?B?ZEI0ZGZBdnBHbitwWnRFcEVBMnB4VkhHME94ODJuL2JEQTZmaDc1WFpDVzJZ?=
 =?utf-8?B?Y2x2aEtxRFd6VDl2UjdvUzJCU0h6eG5CM1RWOHloejZLTU50WURxdmJJZnNW?=
 =?utf-8?B?VzJWNkxHN1dhMy8vbnM5V3NJZXdiTEcrY0lMMzRmeUluVEtBZVpiV0lUaFVE?=
 =?utf-8?B?RGs2bklsT2xUWHpOZCt5ekJtSktJMTErMzdnbndXNGFVVGpYbWtFRFpVVEtI?=
 =?utf-8?B?YkpaZFhpVW9waC90SFp6cDFRVUZUZjBPTVlZNWFHOTVMbkZ5ek1CNldlNWFm?=
 =?utf-8?B?WVRzNEtWcGgzTjF4Mk1wYlFacmNGSWpJa2VOdDhrbEwwQVdObU5PWjYvZDlU?=
 =?utf-8?B?aTNMem9vOVFYdGRVbVVnemVKWTA0NHZhQnd4OWxvTTJHcnNucUhrRlFNRWpU?=
 =?utf-8?B?TCtwSVhEQS9wN0JYckF0NzA2MUVRQVNNNlRQSzdKUXVvaFNiUnMyc3FrNjUx?=
 =?utf-8?B?MHRwY3ZVQ1BGVTBsWkRxamRSQWVMRk1YN0NJNm1JOVhhcmtaYzVtaFgwLzVL?=
 =?utf-8?B?WXJVY2ZqK2ZDRWdPRitRTXc0aS81UmcyV0JxS2ZQbzBIRExnczMra3lvN3h5?=
 =?utf-8?B?MzhxNnVvYzFqSFh3TE52ei9DVDdWMU9ZcGJxeFYwYzZCSk1QanBHcnd0WWNp?=
 =?utf-8?B?N0IyMWpCNEZVT2l0NEVGR011ODJNclViQ01XMUtGM0RQRW9wQ0ZmT2t2Sm9I?=
 =?utf-8?B?UkJzRFNoeE5uRnorSWp2ZmkwanVURkE2NG9sQWFjMXdncXpodmFZNS9vSXAy?=
 =?utf-8?B?b2FvS2xoSEhuOXR6dlNVVFJKY2FlVXNkdGl0VkVBQzBNaDVvMXJZTFBvUUhk?=
 =?utf-8?B?dGRSc2c4bTlrb1RDZi9hdFpVTFZwVG1ibTM0Q1FLTFlrS0FYT0ZMZGJFQjRO?=
 =?utf-8?Q?w+so=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327f1221-b594-4927-1e3d-08ddd52eedc2
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:19:29.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WssNKR8FA5BMv4CRn5hv0ZDpvqbp2DeSTb1AtMKUpP+SwDrGQDk13oAD9xeuuUak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720

Hi Reinette,

On 7/25/25 13:29, Babu Moger wrote:
> Introduce the "available_mbm_cntrs" resctrl file to display the number of
> counters available for assignment in each domain when "mbm_event" mode is
> enabled.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> v16: Added Reviewed-by tag.
> 
> v15: Minor changelog text update.
>      Minor resctrl.rst text update and corrected the error text in
>      resctrl_available_mbm_cntrs_show().
>      Changed the goto label to out_unlock for consistency.
> 
> v14: Minor changelog update.
>      Changed subject line to fs/resctrl.
> 
> v13: Resolved conflicts caused by the recent FS/ARCH code restructure.
>      The files monitor.c and rdtgroup.c file has now been split between
>      the FS and ARCH directories.
> 
> v12: Minor change to change log.
>      Updated the documentation text with an example.
>      Replaced seq_puts(s, ";") with seq_putc(s, ';');
>      Added missing rdt_last_cmd_clear() in resctrl_available_mbm_cntrs_show().
> 
> v11: Rename rdtgroup_available_mbm_cntrs_show() to resctrl_available_mbm_cntrs_show().
>      Few minor text changes.
> 
> v10: Patch changed to handle the counters at domain level.
>      https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
>      So, display logic also changed now.
> 
> v9: New patch
> ---
>  Documentation/filesystems/resctrl.rst | 11 ++++++
>  fs/resctrl/monitor.c                  |  2 ++
>  fs/resctrl/rdtgroup.c                 | 48 +++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 4eb27530be6f..446736dbd97f 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -299,6 +299,17 @@ with the following files:
>  	  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>  	  0=32;1=32
>  
> +"available_mbm_cntrs":
> +	The number of counters available for assignment in each domain when mbm_event
> +	mode is enabled on the system.
> +
> +	For example, on a system with 30 available [hardware] assignable counters
> +	in each of its L3 domains:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
> +	  0=30;1=30
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 4539b08db7b9..a0b0ea45c7b4 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -931,6 +931,8 @@ int resctrl_mon_resource_init(void)
>  			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
>  		resctrl_file_fflags_init("num_mbm_cntrs",
>  					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
> +		resctrl_file_fflags_init("available_mbm_cntrs",
> +					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>  	}
>  
>  	return 0;
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index a09566720d4f..15d10c346307 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1853,6 +1853,48 @@ static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
> +					    struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
> +	struct rdt_mon_domain *dom;
> +	bool sep = false;
> +	u32 cntrs, i;
> +	int ret = 0;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +		if (sep)
> +			seq_putc(s, ';');
> +
> +		cntrs = 0;
> +		for (i = 0; i < r->mon.num_mbm_cntrs; i++) {
> +			if (!dom->cntr_cfg[i].rdtgrp)
> +				cntrs++;
> +		}
> +
> +		seq_printf(s, "%d=%u", dom->hdr.id, cntrs);
> +		sep = true;
> +	}
> +	seq_putc(s, '\n');
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret;
> +}
> +

This also can be moved to monitor.c.  What do you think?


>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1876,6 +1918,12 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdt_mon_features_show,
>  		.fflags		= RFTYPE_MON_INFO,
>  	},
> +	{
> +		.name		= "available_mbm_cntrs",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= resctrl_available_mbm_cntrs_show,
> +	},
>  	{
>  		.name		= "num_rmids",
>  		.mode		= 0444,

-- 
Thanks
Babu Moger


