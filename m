Return-Path: <linux-kernel+bounces-855462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B326BE1549
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1D47351BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782F1DF970;
	Thu, 16 Oct 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+uJGdm0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13920C00A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584300; cv=fail; b=I5Vs5BSuWzGLr+Vo0jmfQaJCSGcTTv6OzmM+uj4puT/zuPFEqBbb9wBko7MjwTwY1h7Tr3V/RGi2azoUsy0RI6DfhD9996H7U+e7RM6JAYoooPpmNDg4r09okpjJBam2385GHRytfXH1o+n6nOuXFU2cIOdYvPGp6yw0iNqRzTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584300; c=relaxed/simple;
	bh=CpS+XBtecws5qsIfbTUjUqKK/LxWG4/S/Pl0WUW35F8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WrR2wwKWSN1zi1wmLlezykBmg7wKHJUXtzTkcUN++l/JS7U2gkzWSTbFGYe09hJconKz0DRlmRTNT9nMEaA9H1MAmvu4rsHw+MC4Y3uIEk/RYvEu3peWTVWASXWZtV5xZlyU3UeFAgVXVO7AOST62MHRzSrN1MU1YnQhLwCHUhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+uJGdm0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760584298; x=1792120298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CpS+XBtecws5qsIfbTUjUqKK/LxWG4/S/Pl0WUW35F8=;
  b=B+uJGdm0mXe0NdFW0BxAMavBBrmwf4RbGJwALN/UJ/gE9fSXCT+Hlf/T
   29dOOygTa8M2MnQrc6lDlZtZgd05jtuWzIvRjK2H4AegRGMQZ1STaMM2O
   cdyEbTTySAkAzA/QyzhRksFlS90a5MeD3qfg61rGuKeX0AoY4g4LgwcvG
   P8xR7xlLRK+HbT7mMAcHiotfl/9BMhz8NIXCnFZagmosSVjZQZALCJDIw
   N10UbipM6jOQI5JcbMe2+CUP7Vzsf+J3BwqmsA4o24LCMMVnO3Vq8PDSf
   X7CYwQ7NIQLXfNDfuW/y8nctxFEPRZmuxlfedgwTRLU/j5Gt5gYiWPSrR
   A==;
X-CSE-ConnectionGUID: m70za1w0SUCvYq2uZZV27g==
X-CSE-MsgGUID: 2yezyGPaTwGihnYBBcbwVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73370616"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="73370616"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 20:11:37 -0700
X-CSE-ConnectionGUID: +mocBTBaRN6h66pmniWz4g==
X-CSE-MsgGUID: YgJ96+R4R8+LSOqajQIN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182740970"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 20:11:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 20:11:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 20:11:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.67)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 20:11:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oE5F9eN+RfhXkmQGkq4Lnwls9nX589JpD2csIlr0NWJ4rSB+3l4kftbdjZ41AQ1iJsuNKt9hDpWenqM34z1dmyGJ36pUmwYhrGEaqApQn0OGwff/Lj1gJcEYtTRTEkIPvGxqEANnGBSZUOevK4mM5cx0Ya9Rp8wEqhQ5E0jlJ58tDYecO84+wRLlWJqNpV1P1feNbUgVAWsbGv+lnF9qAICbpErlWDEDmDvazHaYIJZxKTG2kNcgaBjgFDpLCEgRAsqdPAmz2rf3rnr3eO/ebiR7OZBTqdZrIU/a57EadbGzYmfYewgvotDaC1fLapSS5qIR7fKb8xYyY2A0+jEA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT1g6oRbrMJQQKBIFYTPBjaFhqB8x731IdiheRbvXTU=;
 b=gOAXZ2fYexGYXxPQOtgBgJDUfAdDSLiBBoNRMLTO3Q11dnotwnGb6/VBTzTCY6ZjlVfAAL6YbCfGz+fN272XWb9EjpH6osLTH/YnyyA0pwhsMhePyAIT/FawTRs9ihjemEeCASn15fO6nxIUCN4q1Evj5CGPAEQJqYzUgV2RQp88UYY3RdLfuz3KKIy7iVir5cI1viQS1p0hNhqt+2+ETr1RfXHUFIVuUr0QGAKwX7C9mChuW7tJAKKXeZa1HXwaSwjIQyvO370EX7XNMfp5RQd22TZquGiS+8matW/D5QABT1DSTk/bhCF0tLF/pvhj0pC/twib/x3ZYxMIvppJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 03:11:28 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 03:11:28 +0000
Message-ID: <b5975dbd-763b-4312-9167-feb2013d2968@intel.com>
Date: Thu, 16 Oct 2025 11:11:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware load
 balancing
To: Tim Chen <tim.c.chen@linux.intel.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Hillf
 Danton" <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Jianyong Wu" <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len
 Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, <haoxing990@gmail.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
 <22750d4a-fdd6-48ad-a2ca-aa0c12af329c@linux.ibm.com>
 <5f140e59-23f9-46dd-bf5e-7bef0d897cd0@intel.com>
 <da4d350862807bcf18626009b6fae248475acb1e.camel@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <da4d350862807bcf18626009b6fae248475acb1e.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 317bcfc9-4d32-4bed-af03-08de0c61b2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWRYRlFuaHpsbWpLSWEyMjgwWjZYODc0Rm4xZFR4K0pBL2drWkR4S2ZDSVdL?=
 =?utf-8?B?ZHVMM3ZYb0hJeEQvMmxCVmFvQlc0TDRtM0RnOFRpbmFzU1cyWURrekpXZ2wy?=
 =?utf-8?B?RHBoOVlzRno5bVhGc1pPVTdZMkhlakZERDZEUlVhdTJuY1diWlZwRnA5citk?=
 =?utf-8?B?dGhlRTVHK3F3ZVk2TmI5UWFrVEU0cHpWZnhqbkZuK2sxTS8zL2czcjIvNmto?=
 =?utf-8?B?cUR4dTdoTEFKTTVZOFhlditNMysvUnhDTEwxZ0RhQjVnUThDNmdBd09OUHBm?=
 =?utf-8?B?Vy9XSFlROU9tN2VzTjhlanVrRVh6aU9hYXVpbWx4cERWYmJpVjRpKzlPemlo?=
 =?utf-8?B?UGpjbzJCN29XOVk1UTVRSXRuZG9TT3B3U2s3b0pJOWdjYWRuN21xbGNrQ2RT?=
 =?utf-8?B?WDBleGNNbFRoMzBIZk1EYWs1b2QzL29DUnJYU3lUNTk3OUhQNVNoc1FqNTFF?=
 =?utf-8?B?MFlnZnpVRkpaYUNLL3RWYnJiR1M3c2JVOHF3SGM2K0thL2xrNWdwcHRubzIx?=
 =?utf-8?B?Rzc5VS9OL1lsM0ZpNlZUYjRIRXcrQVZBcXRMQ094QW85TVJmV295aVJzMmxi?=
 =?utf-8?B?UkJEdXJGcGdlNmxFdkdrUGx4cmlCOHhlSzBGWGJMdC94NDV0R0Q1TjlGQlJn?=
 =?utf-8?B?WmxyMExsZGFBbi9jUzF5aWpLSTVMbmtZMEMrbGVLeEI2SEw1T2pOTGN2R0RL?=
 =?utf-8?B?UDJTWHpBUCtQbCtWYXZsYUU2T0dFWmtURkp4Z3BVeFcrbERUR24wdDBlOGMz?=
 =?utf-8?B?WjNwTHRHMk1jMVRJaU1JV0dod2d3bWhSeHhaRW10Ry9MYUMxdWxORlZXVjVN?=
 =?utf-8?B?Rk5LMFROTGNJRlk4UVRzU2dOMmdxOUwwMU5ZaHE3NUU3MTZ4VkZtUkc2YU82?=
 =?utf-8?B?ckhiNSt3Z25BSVQyendqNGdTcTZRVytoNWtCZG13NDAyY0crTXN2UUJDY1cx?=
 =?utf-8?B?S3VDNHgxNVd5cjZTOFVDWjYrZFVKSXpucDZsNTNDbHdlT2NEL1c3WmJJYTFT?=
 =?utf-8?B?SWdMR3N3K2hnTjcwT2R1ajVoNHNtWEVDOHE5Ymg0SDBDU2ljZXF1SEdmZVd4?=
 =?utf-8?B?RzlGTVNyWEU3N01INVFxeE1Tczd6VG4vTEUyUHN3SjhBQ0QvUWlRempMUDdE?=
 =?utf-8?B?Q0VWSFlnY3U3eGxBdmxzQWlFcmJNVE1hVW0xc2ZUY0hYcUVuaG13L052S05X?=
 =?utf-8?B?QUN2SkxjYklUZDJlTGt6RDZZb0c1QWttTnZyL2VKN05vRHVPSUR1RnNZb0Rz?=
 =?utf-8?B?d1c1RENoYmZkdEk1TVcvdjVZU29qNnhHemI1dHMzVkdSKzc4RFVGZnhaZ3Br?=
 =?utf-8?B?NjEvN0xBQnZpdDdrL0ZkcXRvRzNkMU9JbUJRZ3RVZUVKLzhGRENyZFcra250?=
 =?utf-8?B?cThUZFAwdys1SXUzdFgwUTVYeXFhS3FveFpLeE5CcG5Qa0JuVzFqb1pud2ta?=
 =?utf-8?B?cHk2TjltaEZMNkhxQlFMRmZDYm5VQjFnZlB6MUdjRzVCdWdGZDBtZ2Z6S29V?=
 =?utf-8?B?WFdZcmNETm1Qb1ovekdDSzdlMHRRK0U2UTUyS0huUmR2Y3p6MUllSytFRnBk?=
 =?utf-8?B?M2JKTUZDV1NBUzlTZURrNml4amNvMzBQRUZOeVdRZXY1Z1FJcllUbGlSM3ZD?=
 =?utf-8?B?dmVkMWRsUWVCbGgxS1UwbVpCVEQwd1VQc3lscE1ualhXYXh2UWRsSUJ0bldW?=
 =?utf-8?B?dFpQeFgxblZKNjA3UzRRRjJIK2t6a2VLQWJ1cHBYbTdJYjhIOTcrcExNRjRa?=
 =?utf-8?B?enhnY0MycGd4WlF2Yyt3cjdrYjIvdmxoY3BZK0R6UGVQZCtWS2dmcFdUSTYx?=
 =?utf-8?B?ZUlnTkhPUk9nTTJBZkZtTSsxbFRsNXVDN2IwaFBMdzlvaDQ3ek9EV2dzZGFX?=
 =?utf-8?B?OUtzeDF5WWptYkNNdUYrQWtnbnArOFRaai9hc2RUMUJldkNIV01VMXk3TWM5?=
 =?utf-8?Q?VxUKUmzA32mf1l1woBP9McLJy8NPaGWq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1QOUpvVExaUzFEbkcwUWRVeGY1cGNHam9JQU5VeVI5MW16S1BTZnh6MG1F?=
 =?utf-8?B?K3hjbUhpbzIrSUwzWHViOWlZbXI5Vmt6NUpJNUE4YmlzNlkzM3VMcFl1VU94?=
 =?utf-8?B?OVJ4ajYxKzcwVVdEOFFBaVZucmV3MjBuYys3WHRaaW9lOW53UXVVU1EwaDht?=
 =?utf-8?B?VVZjWUJEZnhETHJNTGJTK3RFd2tGOTRINFpUWG1xcWdXRHpTTk5FR2dzV3dl?=
 =?utf-8?B?UDNjSTE2WlpPVWlwVVdjUDVIa3hIWGJHd3hYTmpIUDZXMzEyUmZjaUtOcXRt?=
 =?utf-8?B?WXhoT0pPK3MrTzJpZFZkYVExamNWMlI0Z0taM3NVbnhId3RuSDNZQWJLTUFj?=
 =?utf-8?B?OXh2dEN5bW9KM3VxMWZqTVBNUlF3N3Z5M0xlV3BxWEVXSFNvTGYyRDZLbXJZ?=
 =?utf-8?B?eWw0LzIvQlU2b0xXaER5VFJrSFRRQXBmOTN6MFNmRVc1cC9BWkF5Y0NjUTdQ?=
 =?utf-8?B?MVo5di9kenhEdWRiMHZvM3AwQlVsaDF0SXpZVEJqOFNJWFUvMjgvWjU1c00z?=
 =?utf-8?B?UFJQeEJzc2JhandiendzU1dUZ01BdlJlMGFtNkhibXJFYVB0UU92UGdyZVNv?=
 =?utf-8?B?Q0tOUjVlUmRlT3FTSHkzQVFpTm45cVpYQnZPenltc0NETG1waUhCR1gxUytm?=
 =?utf-8?B?MFB6Mlo0QlR5WHN2MDdHSk4yV2xZb2JtREwwdEtQTE9mZyszV0kvaERzM3ZD?=
 =?utf-8?B?a3k0ZnF6SmVGMXJMWWZIZ04vNmVXeEZRU0NPeG9rWElrV2k0Y2tXVW8wVjVU?=
 =?utf-8?B?VVYrMnZEUE14M2Y2bDcweG9tVmpuZ0ZFejUzc1FRNnY2QjlRbGZMY1VCcVhO?=
 =?utf-8?B?aU9OYldWYzEyQmVabDlmYnFHcWhycGF2UGt3OVF4Y1BKK09CK3phWWptYlJ3?=
 =?utf-8?B?WU9OV2h5dEYrT21xUmtmanEyZWI3Wmk4My9mY3pweVBMSEo2QXQ0NS8xYWQ5?=
 =?utf-8?B?b2NtZkprVGk1cm05Nnd3cFZSVFBKdUdqSXR1QlF5ZnNjYnhkak9OVmVpUytl?=
 =?utf-8?B?U1VzbEtCQXU0RzZHb0ZxdzR0a1VLeUloYUU0YzIwZncyWGJqMGl2UW1CTG9h?=
 =?utf-8?B?R1R0Q2E0OHVFSDA2Qi80RStFeFJFeG5kWGUzOTNUbXZMUHlNY01NRnBUWDN3?=
 =?utf-8?B?NW1QTFV2NSs2M1N0Y3h6czBsUE5QVzA3QURXelJvMEk0TWhBNFg0aDFRbXBs?=
 =?utf-8?B?amdpc2REVmo5NEkycGNIYkFWYTlNNG0zclVOSjZDbkd2V0F5Z0VldkFxSTg4?=
 =?utf-8?B?dTZEMXhzWTlrVWxKb3lnMjRyUU9CcXdPN3RiZjR6cGw0Njcxb01TWWVhSkRy?=
 =?utf-8?B?eHovdTk4YTdLb2ZsRmdOTGFKbUp2eGpXWGR3UUlGN0IrclUzZnhiTnZLb0M2?=
 =?utf-8?B?Rm91RXdjUXVYdWVkcExWUVQvN0xjSVJIajdRV0pndVNVQmxTWlp0ejVaazY0?=
 =?utf-8?B?VzJVMUliSkorSFkycmF2Y0lZZWR0Qks3U2xsZGJ4VkV6RUpHVlhxbG5SRTJa?=
 =?utf-8?B?NFMwQ1FpYzEvajZWZVFHRC84ZXlraVFlTk5hYzBzaGVVckM1MS9kWVJtUHh2?=
 =?utf-8?B?ZzVRWWZicFJ1eVN6WExIenJxczRuLzY0bU05V2d3bVI3YzlTSXI0ZjBQb2Ni?=
 =?utf-8?B?aFNCRDBpRVJIcThJMGZlZ2RjOUZ3d2FQdHlSVUM3aDhua2Qwdlh4d0U4bjd2?=
 =?utf-8?B?R1A2YVB6ZEw2UmhaM24vWHd6bXU3cGkzQVhqT1ZqWWJqcFpkQ2pyN1ZXa1p2?=
 =?utf-8?B?TTc4UHVFNnkySUo3aER1VTJXK0VuUXdmZW41MEl0eVlzQnpMeDFkb3k1aW9R?=
 =?utf-8?B?cWZpclA2ZnU3aVBlQnBCVFo5NWdiajRneG9tWjg5b2Y2NDRBaGFET0FwN01y?=
 =?utf-8?B?ZXRXUmpVb1ZSaWxWSTVGcmlyY1hIdi9YRlpBbDVqcStNSWdjWHZhV1QxbU80?=
 =?utf-8?B?RWNyaWs4QlVRTHIrL2pRNUNRaE05c0VydmtnM0l5d3pFU1hKMDFRQkxUQWFv?=
 =?utf-8?B?Y0RYWTJxMEQxbDdPYUhWdmEvTXcxeXEydGhDNFQzRGJTZnVXVDBVcE5JMU5s?=
 =?utf-8?B?MXVaSXF6VXR2ZFVrdzJUZUNRSytyZWJqcDdFeGpoWUd2VHRDNDZ1a2lYc04y?=
 =?utf-8?Q?iAwMXeVNGBLlcP5B+l+BWvoSa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 317bcfc9-4d32-4bed-af03-08de0c61b2d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 03:11:28.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6nALkTGZX6nmeCrnWgcA7rmCpSAkYUQYEUMTHYEyUtV0rMo0OJmQaoG/JYY0QoPOx0o0mEWLRXu2wqEVMqGYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5958
X-OriginatorOrg: intel.com

On 10/16/2025 3:32 AM, Tim Chen wrote:
> On Wed, 2025-10-15 at 12:54 +0800, Chen, Yu C wrote:
>> On 10/15/2025 3:12 AM, Madadi Vineeth Reddy wrote:
>>> On 11/10/25 23:54, Tim Chen wrote:
>>>> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

[snip]

>>>
>>> How does it handle when cache locality and memory locality conflict?
>>> Shouldn't numa preferred node get preference? Also scanning multiple
>>> nodes add overhead, so can restricting it to numa preferred node be
>>> better and scan others only when there is no numa preferred node?
>>>
>>
>> Basically, yes, you're right. Ideally, we should prioritize the NUMA
>> preferred node as the top priority. There's one case I find hard to
>> handle: the NUMA preferred node is per task rather than per process.
>> It's possible that different threads of the same process have different
>> preferred nodes; as a result, the process-wide preferred LLC could bounce
>> between different nodes, which might cause costly task migrations across
>> nodes. As a workaround, we tried to keep the scan CPU mask covering the
>> process's current preferred LLC to ensure the old preferred LLC is included
>> in the candidates. After all, we have a 2X threshold for switching the
>> preferred LLC.
> 
> If tasks in a process had different preferred nodes, they would
> belong to different numa_groups, and majority of their data would
> be from different NUMA nodes.
> 
> To resolve such conflict, we'll need to change the aggregation of tasks by
> process, to aggregation of tasks by numa_group when NUMA balancing is
> enabled.  This probably makes more sense as tasks in a numa_group
> have more shared data and would benefit from co-locating in the
> same cache.
> 

Yes, this could be an enhancement if the NUMA balance is enabled.

thanks,
Chenyu

