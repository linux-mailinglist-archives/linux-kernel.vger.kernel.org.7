Return-Path: <linux-kernel+bounces-851027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69373BD55AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76D36540049
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD4827A477;
	Mon, 13 Oct 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ik0c0MdK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA5221F20
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373194; cv=fail; b=kw0t9KdHUeswIWHL55VDyX83hqteDvhv0rCb4hy/vqAe5QEwYQuK8J1d2dGt6WJUVMRgcjWAJ6uibi0VmJozq0k21uml8E/I/xkR56TzObWnD3ZkYGO/+d2x/f6Zec7V2yMX2nh69knqK8AkfuX/iD/SHvsCi3I5OHFPfV2nQ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373194; c=relaxed/simple;
	bh=54YStaYvOAkH4ITtKLQj+PireAo8GHA9tMpdj9IHDMg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GLC/ubtGAEx7L1AWFmR4q1WTLfnhuyGyQQOQPNKxdKgcu0SjPNc5lETH/8+Eycf/c0r/bB0zLjX6Y6SjukTF23d2RYu9O2ftDAFzSTePG3ZOzzf/cYn2aiAXiNpE2wWOZxbASu1LAohDxPa3zM0aipzN8ZcDuMbmW6oeRtwwIVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ik0c0MdK; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760373193; x=1791909193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=54YStaYvOAkH4ITtKLQj+PireAo8GHA9tMpdj9IHDMg=;
  b=Ik0c0MdK+pbAKbD2gtIpAjCQIUkBCXbUKZrvCg4eJbnubEWDDSdl2gtA
   ThBt3Wh7oTUGl6rZ+nEeQZ2+i3UXjkig5HvPoUfWoeOUowqD/7UMSwL8s
   PILaYXAUfOuufWZjkzbXSHksqyPa5s16E0DK33wj/NcaqBKXrhdnoMiVa
   t6e0l4AIg90OM5J7OtIXFwhJ0phjr7X9DU88D4ON/rUOaRvZ+uap6aDhI
   fjF3N67vVtkE6y8IVgZYLGaeKiHcidODolxZnghasnNBijzVI4lPEx37d
   10NZQh+zXU0QyUltEzI85vccyAjO9lxir7T7U7bFMPE2qa60igxaxs0Kq
   g==;
X-CSE-ConnectionGUID: j/uzTuPOSg69w7RejSLD1Q==
X-CSE-MsgGUID: Mbj8bOG6SvigfbFzTECOuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62222571"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="62222571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:33:12 -0700
X-CSE-ConnectionGUID: BLGrZPrRS+S4T7QdZRLFlA==
X-CSE-MsgGUID: GcWLelejQAGNPoA7hr8baA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="182083204"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:33:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 09:33:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 09:33:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 09:33:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlQVYDQtRSEmvxkXowB8cHXkHzFmGY6578UUyqd1INYyoDQ4jLAu+7WnRDQQbYPsHet06mMKNKICHwHMZKc0WDhvys16UZmDE1qKiE2P7CEuLpmZUScCdFviGyw6ANVB8khwrQHpYemW6L+fhQvuYkDbFhWp8hR6k305KOJcZa75BTTLErpU6uO6l48yrc7qq7RtcGmTSiSz016cNxuFmfmVr4Eq/JOiPOZdHGzfnXBYZQlEMpnOy9A66stp6Yn06CUisMk0YGhiiou6+4LWhI8opUvQE9mqpdoe4gbejTAQRdnhULFwnvpHp3rTB8FQ2kgAqDbhGG2LqUS1K9GG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycKd6J+iNZ9xeFfIo/B/zwoHX8TFOSml5NMzv2fr2YE=;
 b=lPI9ae4eJ5iT7pPvPCZGkzYcEfNyy3W5+cvmjkAsL8gw+hi8nUSUQkQVcFppt05Kq10Z5d6Nh1+mPAZqX8q6q7N4eECyog9QPpMuiukTQsIzsbl05JthjikwcybH0V313cbufQp9KmI3PUwhvkf4xFPxj9YtRx4SNnhbNFNr4tLrRFZJATRKwV5+N24ETOMvyVoUDkmTceY2Z2g8O0UYoZyrdtRzFYETsPktMdgUw/Dp5czLndJbvD5Szd2Xjssw82ieZavWJrA4LFMsC9q2OvSgho3DUvLpnte26ehtPR+C1RuItAgWWemX9+w+zGWSckcD7GqbFJRdoIigvbJ6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 16:33:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 16:33:07 +0000
Message-ID: <49dba7ff-8be6-40cf-9aa7-b0a5cb2f77c3@intel.com>
Date: Tue, 14 Oct 2025 00:32:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: Peter Zijlstra <peterz@infradead.org>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: Ingo Molnar <mingo@kernel.org>, Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>, <linux-kernel@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:820::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f4434e-a6b4-4ff1-8498-08de0a7630aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDZkeUFTTUU0VHY4MnNWYkFybzVSc2tlOE45dzhjamVidndEM3BRUHJOc0tK?=
 =?utf-8?B?Y241alQ5K25Lb0dYYTJNbWdib3ZBenpxTzJkcDNBYm01UFhBWEI1Rzh3Q3Rt?=
 =?utf-8?B?S2cvTXR0Q0xJZmxxNjlwNEFNRURWN2NPMjVYVEgwUG5CTk0xZUZXblcybVFr?=
 =?utf-8?B?MGFydlk0QVNCZTVrMUNNUmlsRGdVa2pENWlHY3R6REFsckhlMXJDMlBJNHcz?=
 =?utf-8?B?Yk1lWE5wakg3ZU9MdlcxMG9DRTVrbXQwR3ZFOUhVZW5hbTYwMm5hbDBqemxv?=
 =?utf-8?B?VHVpQXN2SVNVbFhKV0dLb3BJc2VSNUtacUJZa3poUGFTNE5HRHlhWmtONDRV?=
 =?utf-8?B?UmI2alB6NVNyY0FzWm5JMEo0dFByeG9LK20yTDlPTW5JbUNWb28xenJyUkVU?=
 =?utf-8?B?S0lqWFUzSFMzRGNORWFpZm5QZzdRWEZHM1c4bG5zTEpOQ3lWTHQ2cll6UUlK?=
 =?utf-8?B?SmpYUjJvempnOTFMUWRRK05OcHNxWVZpdGg5TkwzWEhZb3ZHbk5yUEIzVXJr?=
 =?utf-8?B?NGVJaVJZMDJ2RHl1M3Uydm1sd0hOYVU1RlRqc2o3STRPSGpYWUVtL1dqU2dF?=
 =?utf-8?B?VHRtYXR4Z1lQdDJYZ3JVVkhqWk53Mlg1RHJ0WU5PZGE0V0dlVXkyc0lmU1Ey?=
 =?utf-8?B?VE03azB6Q0pFZXpTRDZFQTlTV1doTXp0OG14em1QRndGNkRxK290a3ZxL2tF?=
 =?utf-8?B?KzlSOFI5bTEyc0lpV2x2ZHpHc3lCQnhYdGhmd1hSM3g2L1hOTmkvaEs0ajJZ?=
 =?utf-8?B?bnAxTUM0ZnRPc21lUFUvSXpkaFJubFdvTW1pTGdqQU5NMTU5S3RRVFc1U1pt?=
 =?utf-8?B?MzdYdHFjQ0JKeWprc2x2U2pyeVRKemwxSXg5S3pLTkNWSlFtTmpqQmo1czVI?=
 =?utf-8?B?YVBUNlYxSXBoZWplaDBnelhEQmZlOFFFT2M3UDZ1bWdHV3krZ1RtdHVFVStn?=
 =?utf-8?B?dDYwSllUV3BVWG9TeEtHMGVlU3pzcWc1dk1KTk9VcmdnN3Qvd2Y0cS9CWmUw?=
 =?utf-8?B?TnFCLzlZdy9haXlZMnB1dGJPT1lsa1ZXRDFFcmM4UTlSL3AxRnhCemRsZkF0?=
 =?utf-8?B?Tno4Y2RYNXY3OGs0NXNOeWJqdXRMRXRmT21ucEE0QW85TjlnZ0J5UmVydDQ1?=
 =?utf-8?B?cUpMWWNoQ21YVVE5S1E1OUp2bXFOSE1nSEFXdWVFQkdOWi9COEtiTkx1Vlgz?=
 =?utf-8?B?bXR0elJJQnpoWU9KQ2V0ckF0Z0w3TGVIMVhZZlNnNlVLcThhQ3Bjd2R2Y2gz?=
 =?utf-8?B?TlRGYndVWVNPdG41TU9HUEFmYWQ3TnF2T0Z3alRFUytleHpiYS91VnI4cERL?=
 =?utf-8?B?VmV6Zkg5TjFhSDJ3eHI4cXpQV1FJU1psWnVmZ1BodEZnWkF0M2ZGZTMyeWxz?=
 =?utf-8?B?STB5NkdBMTl3T3RJOXBzc0NxZW12UTJ5OXhsTExYYXVWNERzWlgrQkhldjFi?=
 =?utf-8?B?WGxDcEZybHVjcVM2WlFTd2oxYXowOTY5Y3VXT0lkV1Y3SSs3dzUwQ0VqcTZ3?=
 =?utf-8?B?b1BnMGxKK01UZTN1NjE0bjcwMDFIcjFrNXI2dnZwZXZzMFVzNlJ6Z3IrZGkw?=
 =?utf-8?B?U0hoSFM4UktwYy82UWdsN2tEcWNFN1E3L3FQcFE0c0Voc2FuSW9UWmVQQWlQ?=
 =?utf-8?B?amdlRDM3aWlWWVdHOTJYLzdRNU1EWW40bGVra3VzNzNmOVFUblNqVWk1K2l6?=
 =?utf-8?B?U2dtNWg5TXFrblZyU3BWOGtCbjFKeUZQYzJpZHJrRFZiWWQ1ZmdLdEI5bTgy?=
 =?utf-8?B?UG1XaW5ZNGxsSEhOaTdNQktyaDJNMnZyWVVrcDc3VFFXQjdtcGkySEwyamxj?=
 =?utf-8?B?T2ZZQm9YL2dRY2ZlRkRyZEJkbjBxZXBSemZhaVR0Mkc4Q01FLzVvNm1RLzhQ?=
 =?utf-8?B?N1MvTEVydmJKSXBjMmpQY2pUOThVRnRjVG5XZnFpcFZudVoydVZ4T0xsUVlz?=
 =?utf-8?Q?I16aguSbCnl/b48SC6NuF36SUfvpJ+fm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhkUVJkejJuMlR1dDVKSkhQSDNocnRaVGFuQitjQUpxUVNlanVzTUxiNkdl?=
 =?utf-8?B?MXVTZmI1Q2hFWXlPQzlyZzRRcDBrSFBqelZVMzRWUElYN2NkY3BaWkVlWEUw?=
 =?utf-8?B?WUV4TmZKcksveFFqQ3BOSXFRQW1uR3RpMFJHQ21mRTQ0VVVpRTB3V0dwb3Fk?=
 =?utf-8?B?dzd3bTBjWXF4NEJ2d05VUWQ2dk1vN0ZnUFRsazBZdkEvaTV4bVViOUl4ekRL?=
 =?utf-8?B?aTJFOGZwV3c2SVdBWHVUbXpXZlROU0pOZG50V3JnYVNYM0lzMk9EN25veENC?=
 =?utf-8?B?UFh6b01LMUxITGZieGF2TGdsbmdpa2p3aVN1QktPZ2lJekxYREFBcjZqTmJz?=
 =?utf-8?B?MVFSYmtxeXFuelc0MFlIUHVScS9kUkNIclpPK2hQRW5oTysrK2NtZW1yN2d6?=
 =?utf-8?B?MGl6VzNSaGRlWXFGUzYzeDR2bUhOUXA5cndkL3ZyVlU4M1N6QXR0TGhCL3ZE?=
 =?utf-8?B?WlpEWW8raGY0Ris0eEpTNXZKbE9yT1hQc3lSMjV4OEZ6ZUtXdFRmUEZOZ01U?=
 =?utf-8?B?Y3BuSHRJcXFvbWxkQ2VjWDllaDRPc0x2TEd1VTJERVdncVlEVFoydlpYaXpS?=
 =?utf-8?B?QTlnK3ROM2MxSUdWWmlBMVpPMUxBaThDSmZSNWtNRlJObTU0ckpNckxtV2pV?=
 =?utf-8?B?b0xKTWhEZ0NIRGtibEJOdU44bVpTbWd2NnNDdUsrb2hjVTltazdZTDZnbWxn?=
 =?utf-8?B?QnlPd2JzdEhnbWZ2VlNsN0gxK0dmdEhoa01YU1d6a2d3cHJvN3FXTjczWHNI?=
 =?utf-8?B?djR6WnpWZ1EzRVp0MG9ueW9lSlJTK0p4Q0t6b2JaSGM3TXhydHFQTEdocTN1?=
 =?utf-8?B?Tyt2TWdmb3NxYlJpejhYTWNMWVY5MEFiajlsbzhkakI5WnJyWC9lakZVeFBK?=
 =?utf-8?B?QlFuS21lS3h3U0NEdkYybXliNUVLY2QzOVMxelFPL2FObCtMZFRSSFgyUVlH?=
 =?utf-8?B?OWVaZmppY1JvMmVXSVFBU2Q0VVUyZkVuR1l5SkdNWVgyWU9JaGFvcVM5Q3Ew?=
 =?utf-8?B?bzBNTkhPUzJ3NWFQbDh4S3dWRXBsbE9ZUThNVVpQYUxsY0NWOWVsbFdTQWR1?=
 =?utf-8?B?KzE2NUg3bmF5TGpud28vMUxrbEk4YmVnbFo3eTMwUUlmOFMyeFFVMDdxeklM?=
 =?utf-8?B?dkdTM2JEYldVbFUraVorc0dRWE1wemd1TDdqeENGWlRmeExIUWw4TnVaS2Q3?=
 =?utf-8?B?RlMrampJdHhlY3dWQWdJTWdwNlVTZDB1UEtkVHZvLyt5WjVjbTN6aXo1OW5G?=
 =?utf-8?B?RzBObzNjUmNkVHhhTk5ZUkdHaGsvaHc1OVJCN2xXMjdHRHRJb0lXR2hOQkM5?=
 =?utf-8?B?WkQ4M3FWR2trZTlnQXZJUDRxcDdlL093cHBSNGdsckpNbC85TXBocFdHRm03?=
 =?utf-8?B?ZFZCWGR5SFJvY2E3RHg4T0tGQWt1Y3dHU1JHbzJDTmswTGc5Nzk4a2QxTTJq?=
 =?utf-8?B?Y211K2tZRFM1TkNFQWpCTHpGcFVMMHJEMXZETEJNVlkrWG1xaXRIcW10K0xx?=
 =?utf-8?B?ZmdLSTFzM2EvbzdQUVQ3ZlNsNVBrUm1VNHFvZGpHLzFVL1FxaVRZNU1TNjFI?=
 =?utf-8?B?QXZJSXhWczB2ZEowRUx0c0I4S3lPSGNHOHdJTzc1ZHJRUkxqdDM4T3IvTTVJ?=
 =?utf-8?B?L1lMNFU1Vkpydm03dFdRcm5KV28za29VaTNnUDZBMjlhK3Z1T0ZsNms1VG11?=
 =?utf-8?B?MWQvelRWc1FYSFpEM2NTR2o4NlBwMlZWMWk1OERvc1czQkcyWm8vUU93dVZh?=
 =?utf-8?B?cWZ6SG5WendKcnlNemhUdnZ4WGRJN1d6Vmxkc2tJYm94YlFscGVkYTQ0TG9o?=
 =?utf-8?B?SE9BUTF5anRrUkIwUnkxaWZQMWJyaXVxdCtRV0tyTEh1dlAvOVp0THIvN0Er?=
 =?utf-8?B?Y05zcmJIZDl4aGQvVE96aGp1bFVlYnVtVHhnc0FxSVFPekJad2d6TndveXNj?=
 =?utf-8?B?ajNCaTJrS1hydnFQZ3FCOXNZVHhoU3JJZjNHMlNlcmhaVjVycXFBc25TRWl4?=
 =?utf-8?B?bEUxdUJESTZGaVVLTFc0V1NjcE52cXVCRFdTV0RDTGk2YlNnWXBGUWNmbTZs?=
 =?utf-8?B?NWJaajYreFA0bVZtbUFMaGM5Yys0elZsQ3FJTVFKeEgwYWlDSlh3R3VWS1Uv?=
 =?utf-8?Q?DHl/g5ibdmIBepsAMDKJCkhZD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f4434e-a6b4-4ff1-8498-08de0a7630aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:33:07.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h57htevdwAg0QbwnQGPWf3egF3H8XPJqWtUJt1NxuHNerhBxCmBVwYh62S12DwivS7uMlaYn/LGhe3jWTrpEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com

On 10/13/2025 10:26 PM, Peter Zijlstra wrote:
> On Thu, Oct 02, 2025 at 04:00:12PM -0700, Tim Chen wrote:
> 
>> During load balancing, balancing at the LLC level and above must be
>> serialized.
> 
> I would argue the wording here, there is no *must*, they *are*. Per the
> current rules SD_NUMA and up get SD_SERIALIZE.
> 
> This is a *very* old thing, done by Christoph Lameter back when he was
> at SGI. I'm not sure this default is still valid or not. Someone would
> have to investigate. An alternative would be moving it into
> node_reclaim_distance or somesuch.
> 

Do you mean the following:

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 444bdfdab731..436c899d8da2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1697,11 +1697,16 @@ sd_init(struct sched_domain_topology_level *tl,
                 sd->cache_nice_tries = 2;

                 sd->flags &= ~SD_PREFER_SIBLING;
-               sd->flags |= SD_SERIALIZE;
                 if (sched_domains_numa_distance[tl->numa_level] > 
node_reclaim_distance) {
                         sd->flags &= ~(SD_BALANCE_EXEC |
                                        SD_BALANCE_FORK |
                                        SD_WAKE_AFFINE);
+                       /*
+                        * Nodes that are far away need to be serialized to
+                        * reduce the overhead of long-distance task 
migration
+                        * caused by load balancing.
+                        */
+                       sd->flags |= SD_SERIALIZE;
                 }

We can launch some tests to see if removing SD_SERIALIZE would
bring any impact.

>> On a 2-socket Granite Rapids system with sub-NUMA clustering enabled
>> and running OLTP workloads, 7.6% of CPU cycles were spent on cmpxchg
>> operations for `sched_balance_running`. In most cases, the attempt
>> aborts immediately after acquisition because the load balance time is
>> not yet due.
> 
> So I'm not sure I understand the situation, @continue_balancing should
> limit this concurrency to however many groups are on this domain -- your
> granite thing with SNC on would have something like 6 groups?
> 

My understanding is that, continue_balancing is set to false after
atomic_cmpxhg(sched_balance_running), so if sched_balance_domains()
is invoked by many CPUs in parallel, the atomic operation still compete?

thanks,
Chenyu


