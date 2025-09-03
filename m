Return-Path: <linux-kernel+bounces-799419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A17B42B61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C48204033
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927F2E8B84;
	Wed,  3 Sep 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzOZc1Ac"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF062E7BC9;
	Wed,  3 Sep 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932781; cv=fail; b=UFD48ETEicBz34U44huJMlyX5ANqGzNlH9Sx8S7FOfhaKoMVnWlI1yROWuwvH6soyfif2FP0qkI4Jn/E3AXlLVb/dIXdaMvd1NIOhe22CCnB3DJLg+S8wxxwt0Bcv9u2VSM9mJwh5wWGsh8dI4dpF1SPr7ne86J8NbwTp3ABL8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932781; c=relaxed/simple;
	bh=5SPDIzko5XJ4Sh0zgPs9g0y8rdAInPdz7idOi+a8x/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V1XZzkNAtxjdpSLwT0cloehJ7F1Hz8Cqhia0qNES8XRhcawY8/DMSuX7M8xUvkWedrg++/oEbwOWeQ8Iplu9iWWKae1ij9BhRagQ7vvFl7GicBpy5OV7TSTNs/Is0f/ArWgLCLEQLH7yMz8bQd6W7GZJuzpYHr/KlZRFEef6QGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzOZc1Ac; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756932780; x=1788468780;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5SPDIzko5XJ4Sh0zgPs9g0y8rdAInPdz7idOi+a8x/g=;
  b=NzOZc1AcT/9TSNEW9CgiVadUClBtwAlXMp3DeaDeYi3vK8/NaleX5j0X
   rOTrFFwpIwH9oZJgvOiUqPW+1yXhMoxdtjJRcXA+WE1/bqMy3TDWD73dY
   yKQdzTxicgyhFS/MlurBaPev+UM/aykH1yPm22qwONfix+yZ6Cy/VbZVy
   3vPzjH8LpHx9FwA9X1xnuXFro04V5an3xiQPMfjzgBxn+4e/GIpNh3IMZ
   xzK0rvq4i+SGonHlOBwauQkIJxcMEN87uSKv+/RBZh6+ve2vnFBJW4hFE
   q5O3LIt5qO9YDk9EOdWtMDuirDvAFGTheM1MG4LTpqmA1Xjpv4cm4VuFK
   A==;
X-CSE-ConnectionGUID: wYeRVZh4SmmX++xtXAhrqw==
X-CSE-MsgGUID: Hd6diTcQSIG/kc2lrN/48g==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70634883"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="70634883"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:52:59 -0700
X-CSE-ConnectionGUID: 64hcxXRzSSSpmQ8+1u7KkQ==
X-CSE-MsgGUID: 2R8Jk2ztSqCGDYRdlfckhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="172140790"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:52:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 13:52:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 13:52:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 13:52:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBQd9hPRDVH4h3GIu9WAzXajXM8Q414Yyn2LwgqrDpQ7ntSFJsGqtPw+GGK8g4tKJbMxlwbNa+8OsTfgVoRFuGzyBqQwzUy2xXUJHpzXmrUaABg4lDCGs2ZnJgIO7ccYzEAZet3iu31oQHPnsWmW4H2EHbyT2MyyCPB8ECz4GW+cKImbJQC14pyYfZT7RZHSMqTgau/OcY4VYCyqSFNaI/y/8V0c3n8hI2yotUHkwYZjoMPhQUkqiocXLinku76GZ8ui7/eJOPgYHD77jsYDoM57l4fmubH+praz+lYo5x479oRotiU++ejVmqo480rA87o8hLmPsyYuBGPp5tSwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNqKDSd7L8QJY0Lxonq05Gw2RRZM5K/LJSM2hmbA14s=;
 b=A6PeeHL2q+Cm0Q3v7xVz0irkYiQtPGgJWMQK/uN7ArB1SVGnO65y+P59fx5hhozT0luvw6juqzfWF/yi+9xTVnC42yz9h+Qpt/1UTCeABw/fmqjPerCDOElaQC3I1ea+txu5qxFdq/Gdr5madaTjCz4nH8DNQ9Jtw/jJ3t1aWXLTPevUC3iPlteHzm6nD4gEwlsuxf9nYZ/K5c5M0RhCuwH8ppnoGjZ3GZchys88sLNGTZ56mgiOvgnJPf3rqFmOomq1YRuTF+JYFw+8V09663bgjv3H2Z2U2LQ0K+0kNx5CydUAub8CV9lODNw54vhAA0YaQQuC29osRMV35zmDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA3PR11MB9016.namprd11.prod.outlook.com (2603:10b6:208:582::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 20:52:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 20:52:54 +0000
Message-ID: <8524e71b-2261-42e7-a4a7-648f9e7d7240@intel.com>
Date: Wed, 3 Sep 2025 13:52:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 25/33] fs/resctrl: Provide interface to update the
 event configurations
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <4d497589d3bb5389565676512c2116e5cfa6df7c.1755224735.git.babu.moger@amd.com>
 <c5f97d82-bb87-47e8-bbf0-e9dfca332313@intel.com>
 <dfc629d3-08d8-4443-9a8d-61e4612dfbd6@amd.com>
 <c6c1df22-e3df-4acd-a93a-f2972cac9793@intel.com>
 <ec5e1f6d-f662-4932-81a4-dc917c6afac9@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ec5e1f6d-f662-4932-81a4-dc917c6afac9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA3PR11MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 11816089-ea6d-40f0-8b24-08ddeb2bdab1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzB3cCtLOTVkdytMVUxQYm5zVWtKV1ZZTGxENzhxUklKaXJXQkZpbUV5Uk5M?=
 =?utf-8?B?TFFuK0tQVGNtZ2xpQ3lJb1JGcWRDa045TDhFd1lXWksvZmNCenE1ckdmVGpi?=
 =?utf-8?B?M21RVnpqcVhpWjVMY2hYOVFrazZkYWhGdnlBQ0Q3MW5wM2dsUEdkdUxMQm0y?=
 =?utf-8?B?MVBLbWdsaGdrS2tiNDdCT0ltdzNJS3NVUjA0VXdPMlp3dEZocTFCR0grZ290?=
 =?utf-8?B?YlNBdFg4L3dyOE40czlnZE1pUFhNOC9NSFpXTFdZZnVaZTlPVkdkd0FKd09o?=
 =?utf-8?B?UkYzS29JNy94cGNKSFhhb0FiSFVIZmo2bTE5TWJybm1na2FjaWNNemZrRjNQ?=
 =?utf-8?B?bXV0V2swbXQ4akxlTGNidWh0UjJrZjlTcGxSd3h2TDJROEltZzNXU0I0dVdr?=
 =?utf-8?B?OGJPdzZRb25IajkvMVVFMzU1K1RVUXVrT1N3Q3RsZFRucjZPT2VicnB4SXIz?=
 =?utf-8?B?WGFPTVNNNTZINHAxSHlsbXc0OFhqQWoyRzR5NFJQVEdXcDJqcUZvekR1dEp2?=
 =?utf-8?B?d0dxL2hUblJLRXg1TGpYcWlBOU9mK2V4VEN1MFdCMGlJR2xmZm4xUkt3YUJ5?=
 =?utf-8?B?Z1NxM2pSNGdnSkFzZkhmWjhCNURaYnBRMi9rdmhJaElLVjd2YUhRM3gzSzlt?=
 =?utf-8?B?NFZlSW0wNnVYdTlhQ0hLSStLOTRDdFhtZFhGdmVCc1Z1YWhSN3p4emdGZlRp?=
 =?utf-8?B?NGlYYXRXeW1YZnJaU082cFNGTmorT3NHVlBoKzJxaFJHeFRoZy9jRWZrb2tG?=
 =?utf-8?B?N1FyNkdQSkpEWmtxMjBsRzkyWUlYMDcyaWNhRHdvOFZraE8wbFRmdWc0azQ4?=
 =?utf-8?B?SVNXcVRqR0k4VHNQdWEwTHhNTWRUa2U4OElSWXJpSDMyWnNKQW9kMW9LRlFE?=
 =?utf-8?B?czlqb3B5WDF3N2VsQnFMNVRjaFFaSldUbUY1dVNNbVA4TS9hQjN6bUVHZTJZ?=
 =?utf-8?B?aWhYWWJqZU5GME5IVVVEWkQyOG9TWHpvZ0ViUU1ZMDVBZno2dm5VZkNIc3FX?=
 =?utf-8?B?RUE5bFAxQUJHNWE5UXBybmNrNUh3SlZndlNYWHRqU2luWXM4SDFVcVJBMFEv?=
 =?utf-8?B?b2FjWU1TNXdnTzVpS2c5Nzd6Sm9TRWMrMjg3OWZnUmJObW1WUzB1WmtPN1l4?=
 =?utf-8?B?V2hkSDNYVVpQdlg5OVVFcHV4UUNrVHVobjZwZkpoNENGQk5JUGFDWU9tWis0?=
 =?utf-8?B?dzZlcEtMU0dDZTNaOGRudm8zdkM4VDhhY0ZlSUNVSUgwL1JWYXFhNkZjNmcz?=
 =?utf-8?B?emJET08xd3VBL3J4cjZ4bFJ6OVJ5d0t4bG1OMGoxcmxsN09YZDZrend2MzJk?=
 =?utf-8?B?dTEvbkY4cWluNEpiMUZCVE5tb1F0SjM2aWRFM09EdzkwL3FlRkJLZWh3OVBv?=
 =?utf-8?B?YTFhL0VjV0tPUVhGek9kWlZOU1MrTlUyNHRnN3o2WlN5OFlpNkRJSWJMS3VK?=
 =?utf-8?B?T285ZHZLNkp4WW1vNE82WjhhcnJnaVJNcjNLelBoM2FkVWpOMVhlSWMvMHRu?=
 =?utf-8?B?ZTUyak5pbVJvZVpQV013dUZRcUkwMHkvT054SktJZTRoMERWb0VuZEJJd3lG?=
 =?utf-8?B?eUJsMk9NbW9IYkZjemhtTUo3MXlzdThvR0I2cXJXWW5INllsWEdUaXVad1Zy?=
 =?utf-8?B?NkRFOUtkdXpsTjM4NHhGbEZpb1Bockl2WW5xcFY0NCtIREhCSXhQN2JLUk92?=
 =?utf-8?B?SEV6QjZpZWk0TVFjT3JRMjRwemRYa3ZRSVA2U1JRRnlHdTl1U25wMmxJVGpJ?=
 =?utf-8?B?TXNFTVh1dEpwMWx4VzJJaHRSVjg2VjAySVA0eFpESGUrV3NkUDZBcVFicGdZ?=
 =?utf-8?B?cDZOVkRGb1FzenJrODhnNFl6anMzODdBbmQ3WStvMk1OeXk4a2dhQ3VDTnpB?=
 =?utf-8?B?bTVwVUNMQkdNOGp1YUp5STJqdng0MzRySE5CNUVQamhwbUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1lXRENxdnlrcmdiZ0U4L05SUFVsdXo1TVZSNVBIZCtac2lXOC9BSWlmM3Nr?=
 =?utf-8?B?Zm9rZ2NsY2I1T1NxcHJBUllEaG5KbGlrVTB5Zll3elhFbUp5NE5vemNGV3ls?=
 =?utf-8?B?S1ZjMy82aCt6V08wdUVWZ3g5S3lRems0S3VwQS9vbjd2TWFrVlhOSjQzWmp3?=
 =?utf-8?B?Tk5BdUJ1OEpVcGhCbGJzK2pxSHA1U2NFbi90YjdDWG5vZmhUY1VhQ05IdkV1?=
 =?utf-8?B?YktwTWdlT3pRZUpBNWgvS0NiUXI4OHI0N1ZyQ09ld3hSSlhtYTFydUdSbXZj?=
 =?utf-8?B?NGtsWVFEVHFpN3hyYzdpazN1RVJ5MW1FUTEzT3ZJZERCaFZRY3p1NlNwazdI?=
 =?utf-8?B?T3oxdGdVaGkrSlpueGtacmFqU0lzMTNFSjkyd1I5bWF1ZjNmLzNnb20vZXBU?=
 =?utf-8?B?Z0hWWFQ3NGV1dmJFakUvSTFsV1Jxb3ZwOGsrZnc4Q2JGMlFhS3dTSmpYVEU2?=
 =?utf-8?B?djkycC81ME9mQWo3YW94UXlsYmZQSmtNNnc2MVlKNlM0ZUtQeVBVNDRZWERF?=
 =?utf-8?B?alBqMno0VzVNV25neXJ1RHVwWXBRNVNMUzZ3a1IweHVBWWJlL0gwaEo2UWM2?=
 =?utf-8?B?ZDlzd3BpL1JqMk05TWRlL2V4Y2FXVTJSWDVOWDEvbmxMYWpGQXBab0ovc3V0?=
 =?utf-8?B?WWtYbE9keXNzMFpXZHk4VmIzU1hmdkxsNWtjVDFaT0NpMVdyMXhNL2JIQzRJ?=
 =?utf-8?B?TTVJRjNYZ0FEL2Y5dENwaDNhcXBtelB3M1NaZkFFTGUrb2FJY2RGUGNBWlRC?=
 =?utf-8?B?VnViRHI0QU5hRlNIZjRXaW9DNW1UQ3NKdldQM1o0YjQwbWtaR1FMTWpHRDlI?=
 =?utf-8?B?N1V1R2doMlQrbGhGbm5zRHVlWFV6VGxYZ1gyZEh3eW1jT2NwVjZxVHdXNSs3?=
 =?utf-8?B?WmVRSG9SanE0dEZLTTlvOTJIMzdtS2ZGZDhjN0YwV2x2RTJsQldpVzZHOFl6?=
 =?utf-8?B?a2hXZVhyWm41WXB1ZnNWdGJXNFdNY1JiYnFadUpUUWpteUVuS1kyNURnY0VX?=
 =?utf-8?B?VXl1Y0VTcFZSd05vb0JHZHIwck9EWFhMbXVlb005cFRsSXhlYURnR3FyWG8x?=
 =?utf-8?B?TzRPT29TSkVXcEhnS0FGUWxweTV4SDdIWER4ZTBlTzBMRU5QSXU1M3hPMjl0?=
 =?utf-8?B?RjJKOXNUNkIrdkIzbEZPaVJwdStDT3RheGdRWTlkNnVkc2N1VkdjU05ad2dR?=
 =?utf-8?B?UkVpZE5XREFWQnRLUVl1RGxiSVZ1ZGtsTHlaVk5MVy9KYkJUWWx0QnJxL0tU?=
 =?utf-8?B?MmdRaFkrZm9vazE4cWRYQUlndmRxWUdzV2ZFb1k4SmYra3cwMkcyK1M2byt0?=
 =?utf-8?B?ek90amJnSUhFb2F0RGNWQ3VXbFgrb2pJN3hjUnJDQU05by8xejlEamFURGhn?=
 =?utf-8?B?QWZELzViMEN5eDdaNzNsVTJWWVNaK09jS2FldzdtZWJsTVYxWXlMRnNiSlRH?=
 =?utf-8?B?VlVNVDNRMWtLUk9kSFJVYllsTkk5MFpzdHd5SjU2L3l4bzYxWm1vbEZIUXYv?=
 =?utf-8?B?bjRDcEZ6YWlxdXRKdVpmdFVqQkVjZWVHZjhLZ1U1a05TWDhYTnBYYXc5OWxD?=
 =?utf-8?B?MDBKckdHZTB5eHZIMTQ0WXo5OHVnWEZIUUJVNWlDcktTZmtWTGJTV0ppQTI4?=
 =?utf-8?B?VVQvYlNFbkF5ZzhKVkp3NS9ZVUxmc0NwK2YrV0VqV1dUTUg0R2dPakdmMHBR?=
 =?utf-8?B?NW5COElOa0dFTmt2R0loRU5kZ09HcWxqNUhieDYrSENDdjJ2V3oxMXU4VmM5?=
 =?utf-8?B?WDVlRjNXTWt3bmU2Z29UdkpTV1lrNkxuczlPdUwyZm5NTERKcklEUXlyQy9D?=
 =?utf-8?B?N2Nhc0VRVlFwVUFIV3VHdllURUpSNnZEMEUxOWZvK1N1U08yU09hcFNobFZX?=
 =?utf-8?B?TlFpSDV6c3FDSThCSHd1TTVRaVRLaklqSU5aWGh6WW4zTStFVGpBeVI4RnM1?=
 =?utf-8?B?TVdsNnFIa2ZjWkZ0cGVpdFpFQVB5b2VXZVhlQVB3K3VDWHp3cFVHMy9xdGQw?=
 =?utf-8?B?bWRhS2hEUW5JeTM2eC95WlBWTnhBbVZUczA1Y2htOHBGcCtpcENWNlFCQXZ4?=
 =?utf-8?B?bFdhRlFqeUxDS0cwQ3JOYU5yekF1bVZ4NU9UQTJFem1nczl0MFEvYTZGSGps?=
 =?utf-8?B?WjVCcFUwdWxxZlhhWkNKdWJOb0o0U2hDRnNObnhkVGltTzlsT0xLcVZoNis5?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11816089-ea6d-40f0-8b24-08ddeb2bdab1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:52:54.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y970nMOuD9nWFbdPJDuIeFRS2TpRzNWbgmuo4n4VQeTDGQMTJFTkgwpzXh0X82wn+g34iSl7wTU0mueE6OADAaw7cQ6T1CTtLucyNkmq0rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9016
X-OriginatorOrg: intel.com

Hi Babu,

On 9/3/25 11:32 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/3/25 12:55, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/3/25 10:38 AM, Moger, Babu wrote:
>>> On 9/2/25 21:41, Reinette Chatre wrote:
>>>> On 8/14/25 7:25 PM, Babu Moger wrote:
>>
>>>>> +
>>>>> +ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>>>>> +			   loff_t off)
>>>>> +{
>>>>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>>>> +	struct rdt_resource *r;
>>>>> +	u32 evt_cfg = 0;
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	/* Valid input requires a trailing newline */
>>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	buf[nbytes - 1] = '\0';
>>>>> +
>>>>> +	cpus_read_lock();
>>>>> +	mutex_lock(&rdtgroup_mutex);
>>>>> +
>>>>> +	rdt_last_cmd_clear();
>>>>> +
>>>>> +	r = resctrl_arch_get_resource(mevt->rid);
>>>>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>>>>> +		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
>>>>> +		ret = -EINVAL;
>>>>> +		goto out_unlock;
>>>>> +	}
>>>>> +
>>>>> +	ret = resctrl_parse_mem_transactions(buf, &evt_cfg);
>>>>> +	if (!ret && mevt->evt_cfg != evt_cfg) {
>>>>
>>>> ... is evt_cfg of 0 (a) a valid value (that will not cause hardware to fault) and
>>>> (b) a reasonable value to allow? 
>>>>
>>>
>>> The value evt_cfg = 0 is valid and permitted for both ABMC and BMEC. I
>>> have confirmed here through verification and testing. In that case, the
>>> event counter will not be monitoring anything.
>>
>> Thank you for checking.
>>
>> I do not know what a use case for this would be but I also do not see why kernel
>> should prevent user space from doing this. Looks like event_filter_show() will then
>> just print a '\n' that is expected. Are counters expected to always return 0 in this
>> case or will they return an error? I am not clear on what qualifies as "invalid counter
>> configuration" for ABMC that results in RMID_VAL_ERROR.
> 
> The event counters return 0 in this case. I would not think this as an
> invalid event configuration.
> 
> One option is to add a text in last_cmd_status from event_filter_show().
> 
> rdt_last_cmd_printf("Event %s is not configured to monitor any memory
> transactions\n", mevt->name);


event_filter_show() does not return an error in this case so a user may not
check last_cmd_status since the doc specifies that "If the command was successful,
it will read as "ok"." Since the write() succeeded we should not fail the associated
show() to prompt the user to check last_cmd_status though.

Even so, an additional message does not seem necessary to me because as I understand
event_filter_show() returns an empty (just a '\n') file that I think
already reflects that no memory transactions are configured. It remains an awkward
use case to me but from what you stated this is valid for the hardware, it is what the
user requested, and the user can use interface to confirm the state. It does not seem
like changes are needed for this scenario.

Reinette


