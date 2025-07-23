Return-Path: <linux-kernel+bounces-742857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A7B0F76D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB2F7A6E06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDEE1C1AAA;
	Wed, 23 Jul 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3iLc46z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881717C91
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285732; cv=fail; b=VXbIXms7mxmyZOO0JbmtdccKe7Gmkn22+Q9LhAwnE29tkXMJyXQccDYKtkjDotYF262CFsqkv+wPuCm/KuCBw8WQLSf9w67msgxK3yNgrxyMo7lyMlW13yIvt8YtvO9M/rbVGtBAO4ETzr31AFmnXTGfD0DyPkHMu486gd6LkAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285732; c=relaxed/simple;
	bh=8iSgOVsypqhaEvrJH9BCsRTJhIo9MjEViQexM/2wnac=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qR1mZ5/pjoPtoDk/dM/YbcM7/IbkBFXpBGYDCRJAZd0cIh9RKU//R1dmiA9NYx9v4GqqC1VisTTo244FQ+QKLKLv8AMuyAk1c7NWfp+9syTpI1uUmL6B7YIyCes4WWuyXoOiVLPqCmOZHqFEiHVaVFd2+KQntqaV/hIn2McxnPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3iLc46z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753285730; x=1784821730;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8iSgOVsypqhaEvrJH9BCsRTJhIo9MjEViQexM/2wnac=;
  b=L3iLc46zKc/hduavJh3EyHu4jEIfqf1HxbxMmO3JXO465G2mqQeZdp+n
   rXquckO/B8UtrKVTSKmGRpCzMTnl/zZobVpf78yJgVUZHwiOR+OA8YsjY
   nwfNGbYHOjVwayK9uxX05eEfq3XPGkLImsP0dUQC5Jyz4VsWadF4j7zKN
   hJ3eOV3sNNNMd2kzcO9nlySBk7ywbk+gm4McDSAyeKnXELhXBx9WHvxXc
   NLRJ1YKkgMzRcC5OQyE7CgUqLPXLxk6gNfaiNyRfD4m1z8WvY5w37FxSg
   FmgMgByquIwC1DwJXkVI651P3plDHbWv35K4ddhU6K9YThPL6vI7/K3S7
   g==;
X-CSE-ConnectionGUID: F66QFvGzSfOLnxjZhiB2zg==
X-CSE-MsgGUID: PQU2C2dIQtCRg2mqZnEZxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43194198"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="43194198"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:48:49 -0700
X-CSE-ConnectionGUID: KZdZhVucQvSEPChhXpOGfw==
X-CSE-MsgGUID: ++iMKp59TPuB3Q23lp/o+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="158849349"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:48:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:48:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 08:48:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzxDc/NUXLsmCahSVm0LW8396WfOruu1H9Q1EhngrL/mWZLLyR81ilx8P/S6yslyTn/VQ3S3xDQgDdnPxKdN1dgg61F/fOz6pW9UhCyvc7urXq2MNz2Hxz3Je728YzYYbwGzjh8h8RJ59/NzRvNzVJBxZH/FQWu/gO3qiZ0xsKkf5foTuMd0BmQh6NNwn0kDHEGP9oXAEC+P0R2azxUVvU6feA/mj96XageriJQuxSGrZih1yY5Ze0IeI9u3KpjaKeAfL/LkEcYEiaYfXuAJ0IAAzFG9T0vP1IUgAC2iiuV9VDriEWoKdn+Q4FRM/SG57bJZWOYre6QWlSb/kFu+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9VPlQvME3pndr1VD1vDGYqWslk6XTljQBlwsiKw5nM=;
 b=PNVcgRkAvEW2fmqmJeq4SgMLlbZvsb8jYcy4j0JFN71uSpekEXAw+m/4EC9P7tH2Xt5eUnBQOvE0fk5Dura9mQgHOoeWvD2RGp+rfkQ0CoMRVWWa6LH1dVuRfJkAhkHujOwaLtPSuMHX7L4jkST21BvC9JbdeJceE8QypY0o4UoTJm7gqV7KITAdm2X1RL/WJVPWnNh0vBM6q4wsVjxzr2BWZug4UY4K1KK1szxPsdqEjHaHtDJrxIO3VIOKCROQP2cB1qqv37SW/izDu/5zbmPvgqJgS5JP8+qVKRhPFIW/tD7TaO/XIgBnlfinnP+soKWGliP6+YpgNzBXGbZeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA3PR11MB8895.namprd11.prod.outlook.com (2603:10b6:208:579::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 15:48:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 15:48:40 +0000
Message-ID: <e4910487-4780-4825-8017-432960c10549@intel.com>
Date: Wed, 23 Jul 2025 08:48:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctl: use for_each_bit_from() in __check_limbo()
To: Yury Norov <yury.norov@gmail.com>, Tony Luck <tony.luck@intel.com>, "Dave
 Martin" <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <20250719213424.403632-1-yury.norov@gmail.com>
 <aHwQxsmBj1lZBwEF@yury>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aHwQxsmBj1lZBwEF@yury>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:303:b5::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA3PR11MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d8c2c2-9c67-4733-3f6b-08ddca006510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXZhT0g0Um1wU1Rsd3RETFdLakJQR1dCeW80bGtCUG11WHp1TzRxNHF3dmZa?=
 =?utf-8?B?bFFlU3lSS25Kb1FjcWZXRUNPZThnQjNlMVBURDJ6dDNVQmtIVUlNZUxGTUQx?=
 =?utf-8?B?UjRPSFBQSzVGQ2liVzlUR3ZLVEZkM09OT3Z2TmlHNFRsOXF0TGVMcnpKakVi?=
 =?utf-8?B?czB6L2JBQTFNK0RkS21KOUxIcWFRZHFWVDMyOUgxWGhYajgzM3M2TE5HcFg1?=
 =?utf-8?B?eWJSd2VXV2lLV045SEREUytRYkdRc0UxRlVRSUhpWFFYT3hmMTBZaVRISVZV?=
 =?utf-8?B?bS9iYm1JMG9JMzF6U2FuR3AzTXpzaFNrUGk5c0FMdk1ZbTR2N21HRzA1a0t4?=
 =?utf-8?B?LzZJaVM5aWx1VkdvOXMrTENwNkpYa09oVnVyL05mWDhQM2pLZjlHOE50dUVt?=
 =?utf-8?B?TWg1RERSWmJKU3ZFS3UwQzljMDhkVmg4bDRrZmtvaVRZVFdaVnVxeW9sUkN1?=
 =?utf-8?B?NWY1UGNXUXZ2YjJYa21ZV0hBdmFER0l0RG9kZTZ0YzYxR2J5ZTFNUkpKVzB0?=
 =?utf-8?B?UXVDREd2YSt4RVNhS3ZXQ20zeGdLRm41Vm04TnErVkxjUG0vcDlyTUxtei9k?=
 =?utf-8?B?Nk53cmcrMWVrUWNOMitNRDJtL3RtSzlta3RDTDRML21EWURCZG5rOEZ3T1Bi?=
 =?utf-8?B?UHpKTmdjTWNid2U3RUIrS0VuMlcvSXkvZWxOblBzcFp6bVhrblFML2gxRUNN?=
 =?utf-8?B?S3VkR0R1NHRidzdOU1k4WFFjbHd0S29qMkdYbnAycERxQnNSR1JickU2Q0t3?=
 =?utf-8?B?Sm83czhOcjUxK2E2NkZGSEd4Zmt1blB2SlUxVnFGRGNibXZVY2ltalYxeHF0?=
 =?utf-8?B?TUlrNmptTXBUNzlyM3lUVElLNEc2djB3NGxmWGd4OTdhUVZZSlltbUxLQ2NM?=
 =?utf-8?B?bDVsQVNxR1NTQjU5WFZHQUdIYUUyWm85c21OMlNYOGtGUkNlenVvdDdKc1o1?=
 =?utf-8?B?ZHUyL0lvYklMUEdFVVBDOTZZbk1BVWpwa3FXOTNBem8wMXQrK0dLSGdGajFS?=
 =?utf-8?B?WC9wMGlidE8zV2cwckNnY05BbXhML2Q5TWNaYlhlVG5Ba0ZOeVd2UE5FOU4w?=
 =?utf-8?B?OGcwNzZFSWNRRFJ2amxpVHlSdGUyRVprdlpyM3J2ZkVOT3N0WEZ5SGJ6dkU1?=
 =?utf-8?B?bk1rbDYvY0c4MUZJTythcG9XSlJIZm0yQ0tYTmlLTCt0dVBjK21zNC81R3NE?=
 =?utf-8?B?blNNeU4rYUNvUU5pcnFPalhYQXozOGYrclUyS1ZQb0ZYMVBlYlcyNG5PVDhX?=
 =?utf-8?B?VWpoa0hXK2hGdTRDZlBYS0Y1a1RkSDVFRXZWbDJhS0ZrOG1lSmh4N1hZa2h0?=
 =?utf-8?B?MlgyRkl1VTJnNTZhT2N4TUFiVzdoOWIyR1U4ZmVOaGJXRWNxYWVmOWhET1R2?=
 =?utf-8?B?QXloV1plV25wRnNGa0dFOG1YZ3p2dEk4a2w5T3ZjMklvbmxuVHdjb2dqVU53?=
 =?utf-8?B?UlRvaS91SVhXQXVESmwwSVowUmRUNStLZXJjb1cxNDNvS2hqSEkzL1Jxeldh?=
 =?utf-8?B?S21la0U1M2VUMC8zZkl1REswNzV0WkJlR1MxMkhFUWQxNSt3dlBOQVQyMnpN?=
 =?utf-8?B?eXI5MVZXRXZvZ1UvWWpGZXpFQWY5RVhLMlRpRlYzeHY4ZkIwd0FEQ3pTRE91?=
 =?utf-8?B?NWJ1aWhLVlFJaGczNzREMTUrejJyaGhZM2lKcUhIMVNYbEJSWjROc2c2ZWhx?=
 =?utf-8?B?SldDOFY5WmFGRStGbFFFMnRoWnlwa3RQRWsrd0pmTWd5UHpVUWg4UXEzdCtE?=
 =?utf-8?B?cUpKVDVYRDFzcVJMdE00dkZiNVU4Q2puK0x4RFVmVk1KaHJOZDlvbWl5ejR4?=
 =?utf-8?B?ckFtS3NCSGMwNVRkNjZPekdJVmw5bFpEakJhL1AxbmZNbHVzSWgyeHZiOWtU?=
 =?utf-8?B?WGtHV1IrOHNCR2kvTm1aVlRxVTg4L1VxNFFjK1JmRmFIVU43YnEydFlNUjNC?=
 =?utf-8?Q?RYyyjDABqGA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHBzMTYzQkZwNkVDek9kZis0MTdzeEJvSEFMNVZmRHh0d3U1MHZ4OURDYzRB?=
 =?utf-8?B?NnFMTnYxK3Rqbm8xMG1TVkJIZHFDL1RHbWYwR2tnWGFhNWFTM3R3UEh1Ukwx?=
 =?utf-8?B?UmFUbU4yTXBHT3llRTIyV2J3Vy9VNGFhV3hvMUJKbnJrMUlaTExaZndSZUt3?=
 =?utf-8?B?ZjF5ODRRQmRXZVlmT1Q1ZHJ1Y0R0T2t2OGFLWXphNEt0ZFZkY21ScXVBY0NO?=
 =?utf-8?B?U0ZYOU83Z2hTYnh1Mk93RTlXaGQyVS96anZqNVQ0aVBnZjRpdnNRTTh0M2sz?=
 =?utf-8?B?MlFiZVM0dmRuNXpDaDdKWmtRYXpVUVFNS0F3cWp2SkxVSXpRMDlZd0M1a01o?=
 =?utf-8?B?SE9CZ2hoL3V0Y2hKOUhiMU9sSmgwTTBKNy9RTjd5d0FMSlZUSXlDcXM2ZzdJ?=
 =?utf-8?B?ZHpYWnliaVRaS20rQTZkZWVpeUwzQkx0UVVqVHNDRGdXR3pnL1d0SE1OZzgx?=
 =?utf-8?B?L3BML1NCdFBqUlRqUzhVdTN3RzU5MGMvVVFwVlVNUUNvcjFKZW1DS1lTM3JQ?=
 =?utf-8?B?ZkxqQVhVNXF2N3ZHQmdiZDlOQ2g5cllvRTZBL0w2clFNSG1Eb1NMeVhiT2ZZ?=
 =?utf-8?B?czRIQVhEQVZsTmdWT3EybTJKaFZBWkdQNmVVaWVnWXBWYlo4ZUJPMnUwVURm?=
 =?utf-8?B?S1pqazJuTVp5cVNFU1VxT3p3RzUxY2pVQkNXcHFXUWl1c0JSb29uNWlVYXY2?=
 =?utf-8?B?d2tOT3hhZUY3SHloVW1iVkdvZUxCUjdhNGoxSU4xTXB4U2JzakwybVBaMTZp?=
 =?utf-8?B?UjZiWTJ6dUJhVWJjUjhDbzJISzdXQ1pWdDJ4T2FsUFhtOG5qUWlRTC9kNW9a?=
 =?utf-8?B?dkNKMDdNZVBDQ3NIdjIrcitFZ2xuaHFkcGkrY01YTXFSbHJyMXJnOHJsa3Bk?=
 =?utf-8?B?SzFCcnBtUmZQMUNYNS8wWmxPci8vc2MrSFZOSFBnVXgwekJLMTU3aE9EL0Na?=
 =?utf-8?B?SUdpaTduNHFLVWhkMHppQkxZaWhRUDhVUjNrQnZOSWFzUEhaRXQvSjFQMHFM?=
 =?utf-8?B?emlmdkRYZ05aM2VEZXFvbUc5eU5hUWxBUVZSTHdtWG42akppcHNTTWpaaDVX?=
 =?utf-8?B?NVdYdjZpOUtPUlo1TnF6d0xNeEFHcW53UjhLa2lOUnJzK3FraEhpMG5jRUM3?=
 =?utf-8?B?d3ovbXowUUs2UjlPdGVGYmNvSzZZZG9sZk80ODRwbWFRZTN3ZFZaOUV0TDlZ?=
 =?utf-8?B?a0YxVGI2TENhNDVMQUJyZGM5K2YwRkg2M2xwTG9SLzByZ0htOVZ2ZHdhbjE3?=
 =?utf-8?B?TkV4VTVWdnNQOXhUTlU4U1p3ZkJrRmQwdkVwWUd6TTljb0U0THlXd0wvK3pK?=
 =?utf-8?B?eTFWbnVmSnlFNGEwbXM0THNKME9ZekF1VFlUeGp1M2xyWkhWMlZGSnVxV3BU?=
 =?utf-8?B?WmNNTjI0L0VTUkE0TWc4bk95UEtDN1RrbENFbGhud1VjLytkakJBNG1uMW5K?=
 =?utf-8?B?Ly8ybmNyYVNLVFhNVnFtb3dJWXlTMU1XK0hObjVlMlJzWS8xR2EzamRCUXVx?=
 =?utf-8?B?dVZYUzVWTGxXQm13bjc2MHRxWFJENDVyZGtvTkJtOWFMNTVGY0xyMVplNElM?=
 =?utf-8?B?eXY0bVljR29hL05UOWwvWDdzbDVPQUFsSys2d3kyemV1ZlF4VVNycEhEVi9S?=
 =?utf-8?B?OTNFbmtua3ltbytrV0FXYjdHSmNWTDBGejk5dUowVCtEaE90a2N1UUxabUpv?=
 =?utf-8?B?cmFxVnFDRGMzVUJHSHdCaUVkcklEcmY4bzE0dUlYTkdaRERwZVRuZ2gzMlNQ?=
 =?utf-8?B?THZWQUwybVpCTFJQdEFtR1czcWRYaTRZZE5WRHpnc29UNy9uZkFwVTRtTlQy?=
 =?utf-8?B?RlgzOHRta2MwTlhEUDAxN2VhT1dyYlpvaW9Ob2R2b0plSzNGeEpER25QN2lF?=
 =?utf-8?B?WElSTndsTG1zeThqVzZ2dXlIUDFaSk5vbFI3dWxtZitnUWVJbkNLeFFMWG5O?=
 =?utf-8?B?SGhlRG1UdUtPZU43cmdVc0JTc0wyOGM1OUFzTEhETU9SSHpxdHBzMk03K2Z3?=
 =?utf-8?B?amhDTjFVU0cvYk13YmhGcGVhbmI1eUFYTEszazlsaDdQVXE5eGVyaW9aK0or?=
 =?utf-8?B?dW44THplbzNlOTJaWHErMXhzRGpMZVJnZ3ZCWk4rWVlxeiswU29GTC9EdWVt?=
 =?utf-8?B?dzd6QVNWTjZ2WitNOVpTUFdEZUdoSHlXUWc5dTE3RmtSUGgwNHN0SnR4RGtP?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d8c2c2-9c67-4733-3f6b-08ddca006510
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:48:40.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkM2+2I72mJFU8CA3hLvTjKvohdZLjLRbJAoXkUPgt9cvyn5whwyUA0HWMRjW04exuY/iqlH8azP4JTkL4acDP3h22r9XWiuHtDMWE7Yuf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8895
X-OriginatorOrg: intel.com

Hi Yury,

Thank you very much. This change looks good to me. I do have a couple
of comments related to customs [1] to help this patch travel smoothly via the
tip tree.

For the subject, consider (typo in prefix and description starts
with upper case):
	fs/resctrl: Use for_each_bit_from() in __check_limbo()

On 7/19/25 2:40 PM, Yury Norov wrote:
> On Sat, Jul 19, 2025 at 05:34:23PM -0400, Yury Norov wrote:
>> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>
>> The function opencodes for_each_set_bit_from(). Switch to the dedicated

"The function" -> "__check_limbo()"

Move "Switch to ..." to a new paragraph (doing so separates
problem and solution descriptions).

>> macro, and drop some housekeeping code.

It is not obvious to me what "housekeeping code" is referred to here. I think 
"and drop some housekeeping code" can be removed? If I am missing something,
please add a bit of detail about what "housekeeping code" refers to?

>>
>> While there, switch to non-atomic __clear_bit(), because atomicity is
>> not possible in this context, and that may confuse readers.
> 
> s/possible/guaranteed
> 
> Because find_next_bit() and therefore for_each() iterator are not
> atomic, we can't make sure that concurrent threads won't pick the
> same idx, therefore atomic clear_bit() may confuse readers.
> 
> But atomicity is possible if we use external lock, or
> test_and_clear_bit(), if needed.

I find this update very useful and easier to understand than the
original changelog. Please do merge it with original changelog.
To support the final sentence above you can add that the rmid_busy_llc
bitmap is always traversed with the rdtgroup_mutex held.

>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>> ---
>>  fs/resctrl/monitor.c | 11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index f5637855c3ac..3e1c14214ea8 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -135,7 +135,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
>>  	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>>  	struct rmid_entry *entry;
>> -	u32 idx, cur_idx = 1;
>> +	u32 idx = 1;
>>  	void *arch_mon_ctx;
>>  	bool rmid_dirty;
>>  	u64 val = 0;

Please maintain the reverse fir ordering by moving the now shorter line
containing idx towards the end of the variable declarations.

>> @@ -153,11 +153,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
>>  	 * is less than the threshold decrement the busy counter of the
>>  	 * RMID and move it to the free list when the counter reaches 0.
>>  	 */
>> -	for (;;) {
>> -		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
>> -		if (idx >= idx_limit)
>> -			break;
>> -
>> +	for_each_set_bit_from(idx, d->rmid_busy_llc, idx_limit) {
>>  		entry = __rmid_entry(idx);
>>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>>  					   QOS_L3_OCCUP_EVENT_ID, &val,
>> @@ -178,11 +174,10 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
>>  		}
>>  
>>  		if (force_free || !rmid_dirty) {
>> -			clear_bit(idx, d->rmid_busy_llc);
>> +			__clear_bit(idx, d->rmid_busy_llc);
>>  			if (!--entry->busy)
>>  				limbo_release_entry(entry);
>>  		}
>> -		cur_idx = idx + 1;
>>  	}
>>  
>>  	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);

This looks good to me. Thank you very much.

When you resubmit, could you please also cc x86@kernel.org?

Reinette

[1] Documentation/process/maintainer-tip.rst

