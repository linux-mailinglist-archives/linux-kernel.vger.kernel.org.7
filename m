Return-Path: <linux-kernel+bounces-735847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16DB09468
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0790DA64D25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5AA30204B;
	Thu, 17 Jul 2025 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmignJ8t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C7B2153CE;
	Thu, 17 Jul 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778048; cv=fail; b=pRpBxRI3xILPUZlPbUU3dVv5DtxFLHP0vF44JLPLse7kb3Xn5TfhUlGmzfVY+sNZsKz6SDIqeqRpgr5BZOmnZpC1B7CeKMkPzpEIlZJE1CkgAs/g9g2PmV4ufcvJNwFwbx9jehU648bO2EsnxclrPRN9e2eSg0AHvAGXjJVccec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778048; c=relaxed/simple;
	bh=2HaIfyH8xjUnHCjJdozYgS1PfekkE56nGg8IGwzHuhA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZoVGBZvdtanWTi4JBhAY2xRmuWyeQc/LESOIyQCDgpTgtcO6kqXoZF1ZE2c9bGDiwjtZc8Sl+2Ta/ytP1npugvhkQElt7A+JIP2c0PQ+FhAKb0rvqQ3tCE4VY+ISkaqz6SPubu+UknAML8NB/1+zXs1mEuF01r9w8HlaczpNFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmignJ8t; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752778047; x=1784314047;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2HaIfyH8xjUnHCjJdozYgS1PfekkE56nGg8IGwzHuhA=;
  b=YmignJ8tV7OrnvbttCRzPWvH3DB5aOhaI0vET6/iJr0lwCRlcEwNqKvV
   +elgtlmNPghEr6vzNbMLeVjr74d3ox2PKXmr6o295TMsQddypCTLTCiDb
   5cFoYbxJu89HOcdFZJNqjBW6n+SDGjNoxNyitQjJSvX5lQ+waNmiGByt2
   M/0X4aLsaT5nQlDEkD8NYcNPTu9CHsPH6aDNmxpe9QGBXTiI/aqyHXNlm
   nbP7NlZc4XxpX1dIViapJw8AbqHAVTm6Zhf4/m1T6HTkioNqXoUQSpfYv
   Gb7RfeBrI1T02xwlsiibl/4H9S8gT2jU4gZIvUNwhcFQmYAxC3gotrCK2
   A==;
X-CSE-ConnectionGUID: W6yvWAOaQSCrHP9X3PnbHA==
X-CSE-MsgGUID: JSgIAe5WQ2eEoGxA6YTeCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55192243"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55192243"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:26 -0700
X-CSE-ConnectionGUID: GbTjhx3uRtyzLkxHokp9vQ==
X-CSE-MsgGUID: 77Xt4r5yRmGX7pR4ROn5gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158440802"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:47:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.58)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UagU4DjDqoOL+buglC6Q/eAbsQGquPRmeZw8GekKcUFSTEOJJ4AiQTJPFxAV+FjIIULHxDTIv8Llg4QnbR0anzAJ+z6npr+kdDbusXSmvWVen38G5qOqTap9t72q3IQPVT5ywH1CpzM/cBLGgHIB1jKfZ3kDzyJv5/7IUPqyxdIuG8hdOAPHb9YBtt30MeUCFEckltoudyeP361FPlHUpr6hEIT3StDv5vC2LizWbRgOGv7kXZSgVjEdayZI0P6u1Twl/N33SLrr3QVNJ77Ef8V2qj5HF2B1g9hO7vKfqUYxHGVhFgr8SiAeEWKXHuuT7/r6eVWpHon4kkU6fMdxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4iwaPFogs02xfn8nE8PYcB8ic7c6SvTcFD6KpM3f9M=;
 b=Q6WUYdIaOzjU2TtDbGp+JRp2CjTpmj56fy1TeoUCcUH+My8oK4WfixqHIaD9L30AOyYKbtsK1oHO+2uzO5FiiWd/pqonP9CZW/UobnjcS+fdSi9J90gQt0e4re5Pt9ArlJFtDH51MT/qvsnwTHLOV1ffyG4i2E422OjelbNeu/6Ca6MUHu83gLxJQPjVkQ5Z4EqT9ywsGvbDjz6A1V4VBwkqWMvgxCSS1m81WhJqf33jj/Z0VU0v0B3LJCMRdvXFHbZj4M9dXnvxhNPX8RDUHOn0nMY5N7v4xJOcjl+rI/sS9cU0/tMnwkbukRrIxDvYEF1AIhMyefufukCHqU3n0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:47:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:47:08 +0000
Message-ID: <1425d368-0731-4a87-ac1c-06b6d7548b54@intel.com>
Date: Thu, 17 Jul 2025 11:47:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/34] fs/resctrl: Introduce interface to display
 number of free MBM counters
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <56a73d1ecc3f6e2e7e0c8d096a0df5657f823022.1752013061.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <56a73d1ecc3f6e2e7e0c8d096a0df5657f823022.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec9554e-4d03-445f-c19f-08ddc5625558
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVlpYmQ1MjhEdElsUjZMcVNGQ09ycyt6bVRrazZjc0YrT2N0QzlSaFpQRXZ5?=
 =?utf-8?B?bDQ3QVBMdlNxMmV1WmIveURVd1c4bGliWEhwM0RQRFhrb3ZNMkZZWHVuM3E5?=
 =?utf-8?B?azAzTU5NSHNCRHlqdHl4a0dJVFlBeXZzTWJFM2YyaGVHK25nejdIQzBVeTdJ?=
 =?utf-8?B?MjdVc25FNUI0WmJwQmFBNExRbTNIMFVVZ05IbmJ6VDBHbDJMTFR4Q0dWcnBK?=
 =?utf-8?B?NDVLT05lVDd5cE1FT2wxU0phNkZIYldMaE1YRFVWZTk2T2ZBbjZxMUN5ZDJX?=
 =?utf-8?B?YUdyZFdHSFpNeXBXVzlvQnlCclZGay93aytLUUNrZjJLU2FXd1FjQnVwRXNN?=
 =?utf-8?B?RnN3cWJxYkUvaWpDVTZqdGtpRWJKUE5QdVppOEtwdUtXNWMrenhHeVJnNTBR?=
 =?utf-8?B?M1lGZXBndnlDVE1iYWZFUVM1amJWaXhTaVdFdktSWUw4emd4K0RHNGgzN002?=
 =?utf-8?B?SENwS0tOemk0akI0b2hLM2g5TjJOSG53djMxaFp3VTZXQU93YzBQcnpPNTRQ?=
 =?utf-8?B?L0premlUemZBcjdkVitYQUU1cjdGWXpjUjBwTmRTeStub0pXYm9Ya0hWd28x?=
 =?utf-8?B?enRiRGZ5eFRZd0FwVUZ5MCs3WGpJVVpCWUVHd3ZTN2VRMEZMSHFMSVlNSElG?=
 =?utf-8?B?RHFKeFJxMFhNRkgxYXNISHp3RnQxbCtGWHVDZlFZQ20wUXZscE4zZDJqKzdP?=
 =?utf-8?B?Y2g3ZlFsbGNNSEozS0c5MUw5MVgxUDRNdHdtZXZjbG5hdGZtVjg5QVdmL2ti?=
 =?utf-8?B?aFpiMXd3M3FMcUVpakgwdVl4TjgwNytlTGNXc2V3Q252ckoyZVhSU3Yyb01z?=
 =?utf-8?B?djRZRzQ4VVpiU25Da0pvTXFOejgrcmtNNjFWalpyS1V5ZlcxSURaVklhMkF5?=
 =?utf-8?B?citIWE9RMkpqR2pHN2hqRGZpbzdscmV1bWRsK1pjcDdlaWZBUUZySzRhQUd0?=
 =?utf-8?B?WWVTQkpKcUdsR0dKQVRHeEJTajFaQ0dPcWhzcGFmeVIxR2MyMFpqU3M5aHlG?=
 =?utf-8?B?SGY3S05VdmNJK3E4cFR0SUdqUktER2VZaGIvSUx1UmtySnlZNVM0bENEcEw0?=
 =?utf-8?B?VGR0SVljbWoxU0xYUUFiQXBqeXY4dEVPRzhNNHJ4NDFwUGxPYmVuS2x4a1Rj?=
 =?utf-8?B?R1luYkxpeTNNSFpYRjFPb1BibytDWC9JKzh0T2gra1VFWWhyeUVrTldvMHk4?=
 =?utf-8?B?NVlsLzhDR3pXd01WNG1CeXIwSjlUbnc3YU1mc0ZEZEVMMFVYNUFVSmxPdjlj?=
 =?utf-8?B?UWpMUE5EeElXaGovSVJkcExyWDVuQXJhd09JYlQyL1hLRTFlTXF1WlBjNkdQ?=
 =?utf-8?B?bTBwU29lYUZsMG5TaWN6Y3FXYUdhN1ExcDRqN1VRQXVOa2RBUVRJNU4rcE5j?=
 =?utf-8?B?R3c3Q1Y2ZXFGYTRrWVFPYmZNaFRJd3JVMTRpS1dhb3VGeFBXaTFQK29UWXJs?=
 =?utf-8?B?TE1GekNYeGpsZVZWbHB5Qkc3aTZmdmtsSU15NWI5QkNlRSsveTg4SU5wbUw4?=
 =?utf-8?B?TnRJK1ZiN3V6SXFlMTVETXdCQ0RkanllVUkxK0ZOMUlONTdsSklOZ084eEl2?=
 =?utf-8?B?UVJqaEx6Szc5SnZENmRwLzVvN2IydkxKaStVb0pBZkZiUVhLVVlZVUhLcGUx?=
 =?utf-8?B?dWRVcVU1Wmc0aVNqbjRnTTlBeFcwVno3bndQSTBFSW10enprejhBWVZpdjUw?=
 =?utf-8?B?eDJKak1qNUhFeWZGVTJUU3NGRkRQN3RBeHpvN2tid0lRZ09nU2tmbFFxdmtD?=
 =?utf-8?B?eTlzaWlKOXRFWjJEVWJmMHRwa3BYMmdBdWxKOTFNOGVTd2o3MGNtQzNHYXl0?=
 =?utf-8?B?Ly85TXBnVjBZRUJTWXRUcHFzTDFaUmVRakFkd3FZTlNXc1Q0YldxTHFVVTJO?=
 =?utf-8?B?ZEdESkFpcUVORWU1OGF0UUtQTzhjcGhyM1Yrd0EvYUJORGNJaEhkQk1nYXRB?=
 =?utf-8?Q?EiYoQ38CFCE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9WTWh3eWZUOG14Mnc4Q3NMTENzLzJFbXdlU2hGZ1ArS0xlMVFMclprWmVQ?=
 =?utf-8?B?R05GWEpMdy9xd1FDTEpvbFF4V05ldHBIbUtEOWlVRWdsSHNaeUNJanlRby9L?=
 =?utf-8?B?V0VRL1ZieGQ4ak9XemUwdFpWZlYva2dBMitudWplRy9KMFRFRnU0L3M3NlZ3?=
 =?utf-8?B?bjZJVzcwR1ZybEMvTFJNWEsvQXQ1bmg4UU16UjVmZTM5VHRpSkxCb0Iza096?=
 =?utf-8?B?bmE3cnF4QXRnbzhiMDlHU2dOQ0JDa0ZIL1lpeG1mK2Q5dVVKZ3kxWDdBb1Zr?=
 =?utf-8?B?a014TDI5ODgwbkFXMDA3NnpmckZWa1U2WnNtdmhBdm85RFJRYm9KNlAvc3Jy?=
 =?utf-8?B?TGFHS1dTK00vdzhGZnk3aUxlVUs5elpHZkdya01YaXhQQ0NyRGtUTjdCWEFC?=
 =?utf-8?B?VytUMkE5S2xLeENTSGh5bGJDcGdZRnpHN2hERFB1SWNZUldTeDU0S0dDQkRD?=
 =?utf-8?B?blU2a2JKeENZdUNEeU5pSHNXZXB3Y0JZNW5wSGxGWHNOR01KS0o1TmtQb2No?=
 =?utf-8?B?by9oRkhHcnczd1FOblVEc0FhVmQvWkhiMEpzeGdpaFhXbU83MGdsRzZORk5q?=
 =?utf-8?B?SWxsQkc1Y0JWL1FzZDROU3VNWmR0VnJFMWZ2UmVlT3RUZmtxZHJpZTBoRjdY?=
 =?utf-8?B?Ym9xUms1aTNCbDRrVnNVaFVwZ2x2ekxRRUhYYk9IVEZ6dTRYQnRsbE1nZUZy?=
 =?utf-8?B?TFFMcW1Bd09vc2I3a0lXWUZiK0J1ZEdsSGpNU0psTWN3SVQyRXFEaERlYWlm?=
 =?utf-8?B?WURST3NPNXowOFZsaTJWRlhOTzJjSUgxUTNDOVY3T2pnMWtHc09FNmxuaC95?=
 =?utf-8?B?NmhDa2w5SytUSmYyNHMwNW8rWGpNOTUvQ0ZJZitIekhHRmFGMy9GN3N5dEpx?=
 =?utf-8?B?a0poVFpTQlhWNjBLM0ZvM3Y3ZkU2WUZPb2hERDM4YW5tYmNya2JBd0JpemJW?=
 =?utf-8?B?WXExVTlvVVhDMlFKVDkzckZJQUYzd3U3TzNKWE5pSVV1ODV5TG9sRTRiWjhE?=
 =?utf-8?B?Q0IxWWUxZXd2Y3g2RURYcVZSMFIyalJlN3U2b2NpU0k2K0N4RUZxMGo2Rlgv?=
 =?utf-8?B?bExaSnhGMndTM0dBMkpBc0pFbjZrZWhUVTF6UEpWb3VpdytnT3lEQVpaWUF5?=
 =?utf-8?B?S1ZyNElpV0NEUW9ZbGFJSWJ0M2Y2SUlWMWlYeDRiTUYvN010QXJnQXJZUmUx?=
 =?utf-8?B?NCtIV1RoMUtZWGhEblEySnBJQWVrTE5Hc1V0OWdPN1hlZlZTVVFFVVB6cFFI?=
 =?utf-8?B?ckdkd0xXcU40WGhaOElYZmI5TW94a2RQVldGZ3FtUTRPRTRIT1B1QkdFQ2Y5?=
 =?utf-8?B?VndsNnoydVYwVHVRNVkvQVJrMVlIMi9scm5XcUoydWZVeklLdk0yN3NKS2dZ?=
 =?utf-8?B?aXRONHVoM3B1dGErTjVaYllrVGZIMzNidXFnUGlEQ2NNOW5rOGEvL3hOUVda?=
 =?utf-8?B?Q09YQ2NZUmVjTXdqZHR0d3h5d09DNHdUQ3Uyc3BRU2Jkckd0cFBwWVQ0RE1S?=
 =?utf-8?B?WmFsTFJDVkN1bENORnVFcHZIZGlTVUQvMkZlUldqeHpldUVnbjNOZkk2R2tp?=
 =?utf-8?B?OGJDT3NINWVDaGdnZVdmMHpvR3lnSXM1ZHZveERKeUJaTDFoaW00OGZiQXJ3?=
 =?utf-8?B?NFhFMGNWbk40SXVvd1VHeUVPWVhQTTQ3UVBYdUphNXpDenZCMGVwaEU1ZS8w?=
 =?utf-8?B?aEFMbWx0SXp3Rks4dkhvU09LK0h1a05tZzdSbnhuZkxzckJURHJuc2wremFv?=
 =?utf-8?B?YVQ4MlF3Ui81SE5adzg5R3BNZ0dvWjRFcVlOWXVQcDgxK1FVQmlQM3Q0T0Z4?=
 =?utf-8?B?NkJIRmRLODhxVk01eEhoWW93MjZFNTVYeHYwdHNPcEJ3bjVNRlJid0JiKzFv?=
 =?utf-8?B?Y2JOMlhWNFJ3ektPYjFhN25rYkpBUmkwREh2aFlMUldGc1MrN1NXVjErWUdP?=
 =?utf-8?B?NGs3SkQxVjdWOXN4TTRvL1hRVUhodzlQMlpMbzY5cjhNM2hqTGdjNThIb3Fk?=
 =?utf-8?B?VU5OblU0VllEZFdPQnlUYVJKWFJvcDhFUDNka1ZvWDF0Wk4yZmE0MXNSd2x0?=
 =?utf-8?B?NEY4YzgrOWJlWE5TdmVvdjdRL1gzZ2dmR0s3bkVKbU1wM3dVcDhZSUlCY0lq?=
 =?utf-8?B?bGdhOVBoZWxSY1daeGJOVGlndEVoSm9hR3VQVlZvSEFwYjk4ekcyRE1sdW9p?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec9554e-4d03-445f-c19f-08ddc5625558
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:47:08.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoP8eTmgjFmqeN2+ida9IzHIL3K+VLqlEmoRKaWse9StRrisUzG+Gkr93MCTuN6v2OF+FnhLZD5Oh+9GunPou2Hp5UWaPOMKGBEoJLB+qjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> Introduce the "available_mbm_cntrs" resctrl file to display the number of
> counters available for assignment in each domain when "mbm_event" mode is
> enabled.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


