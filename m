Return-Path: <linux-kernel+bounces-751302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A6AB16772
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B467188C7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1AC218EA7;
	Wed, 30 Jul 2025 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkoSilI9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8E21128D;
	Wed, 30 Jul 2025 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906286; cv=fail; b=o9GjuDM7pctq2f6XqhuyrZmd7zM8UG2uVgTeKor+RTLgVcKyt7lqfH9K/ilS0qQUO5pSQ+iiUkC9gUT/3+9oVqMoRQ5Ms0BS+gMvDk7b4GNKBR2W/7l+Ydsm9NiEgk1CMDc6d+26LdubjLH09PqxuFzSINR0eZdOhGd6Si50VMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906286; c=relaxed/simple;
	bh=avbeon3sTSiuSi1CBKPUKgDXXpBkmTPcJ/dys4Y93SY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BojMNG5T3q+cvsrQX7xZPjKneoJ+vHAr0NubpJ2VUs4MurzWkF2IKmuaqIZQBdMwtZFggqRpSZahtRK3MO/JEbzMBgkLgjafGcn2L+vfLL0obtiaT8AKjOP+qyJqDRVeSvEfOo4YCFEeChLPB7LhOvsb00crDibt6aF/aitFFBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkoSilI9; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753906285; x=1785442285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=avbeon3sTSiuSi1CBKPUKgDXXpBkmTPcJ/dys4Y93SY=;
  b=JkoSilI9DFlEdBE54VdfJt/BnWKnIfNQIcFWbJeZ4UJwrhuLz9HCdN59
   x5mKjbA2JPF2q3G56cxM6suUzyjvDKH66zOvpaKExCeMsY8RGxKtAkRbM
   594o9WqKLIXbBxcEBkh3LS6d5I5JMVp7h/UZLQxdF2HiXicAKU+7UO885
   NmDfRvtDsmvzYKi0QFmbN4J2SRo7QUpnJdyQq0OOXeyCQ1hBILKFNBTUP
   NF2XVQXd8b98y6lm3L5c/4x+Y4C/xhzqcsksjsCQxbBVJ5Skw4WFTGXdJ
   50N3T1Zt8JLtmYvvAsM1lZQ8I/DYjIefrpP1gHgnby0+ywihAebuhR5sd
   w==;
X-CSE-ConnectionGUID: Maljim+fS/GQK8T6TlkuHg==
X-CSE-MsgGUID: D62ZnfrmRI6/BTijPnGteg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56185945"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56185945"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:11:20 -0700
X-CSE-ConnectionGUID: j0FzhOUTTeCaQam0HoRzzA==
X-CSE-MsgGUID: Xqgpz23qTbmY5ckc91nd5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="200243861"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:11:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:11:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:11:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:11:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhhFsvnppQhEjsKbpovmmuimZcEOIbW128QMsQEXqZeklCXJgJx9JRrNZTSXPxCo7gEh9PSs0Qjw0cLHUsnamowogBFWS6C2ZxQd47sbOeHr54vw1BQk85oOKkWo14nJ1vSfFcLev6M0y1yi92OhjfLZtkpxe3L/VmTzvcm8wchSTEZnQbe3sjLhep/RUsG17Ff2WltKDxjAMmzRAda2dvZ1SYtDp6OqggDMkEvObPl2WoQnWzlv7B/jzsuv+Y1qBWsfYcjjvst0bJEgwQ8bAPcT1ez1T3ZT9b8Tj3az42/5nGt32LPBGbBAHz1wbTWwSKOybe4THjSlcQZBDTb/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7mMqYgn95QmcXRqwtXiRyxkcqJflJrjXDrdIkqj7+Q=;
 b=spA7etpEzrVtZwF9KZX1dzMKWAAT1iN7KGCE//mZBHDg427ltuFu1x2CzeQcId2TgNLEIjD5yC+in6Q3hfonvgjy5GzHmkX7dPksAqai94oE/thkbsEU2gTYoMHVelEEeGBxPN69zsdOW64Jlc/GKtthP8knER8ZgGxhihXWhj2ZStaLl0lIvjTRu+ICSC74YbFImE633PQJfTyyUpHmdfRiFdiWM6XlctTWC7GmydNdzHTMr5uZkzPZTEAD/Oyrba2O/qHO782a3oxLbIsX3ZCVa4Jq7rFE4AdOfnuoTAXXfPfqPsrjB7MbfZ315ixwE2C7e/+MeHxdgVTnvwv7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 20:11:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:11:06 +0000
Message-ID: <46e6c50e-ab7d-49c0-b06f-aec51558af70@intel.com>
Date: Wed, 30 Jul 2025 13:11:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 31/34] fs/resctrl: Disable BMEC event configuration
 when mbm_event mode is enabled
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <a5509fabd688c9bd1ee14571c9e00793f34afabd.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a5509fabd688c9bd1ee14571c9e00793f34afabd.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 4596f3f1-cea3-4d26-1c66-08ddcfa5379b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjVwNTJKVklDQTE3WnZFa3NVK1FKZ29DNm5CYVova2dESitrbzJuaW8vU1JX?=
 =?utf-8?B?SzAzbCt6NTU3VHplNTVIeEduL2xZWDlPVzFqOCtqTEZucFFiZ0Y1SkxxU05j?=
 =?utf-8?B?Q3FleWgxTjJ0YkhzU3lRSFg3TkthQ3IzUXQzemw4c2EzbCt0bDZCdmo5Y2Na?=
 =?utf-8?B?ekFaaWZJL1NqbE9FdDhWeFFZZjRuSnJTNzE0SDdhZXc1VUc5L21lS0x6cHFo?=
 =?utf-8?B?VjJRbWpKeGJscEk2a3R5b0kxaXBGc1pvbXJmbDF5ZXJxL2dpYkd0OCsyYVJ0?=
 =?utf-8?B?M3ZRUDVUMzcwMmppcENGblI5T1dDZlNWdVl2QWhkaklBa1lUL2lSVVNReVNP?=
 =?utf-8?B?VEdBNlZFWmZTSlV2YUNhbWk1dHVLcy9TNlpFSUc4NXdxVWhxRHlzSTIxVGpF?=
 =?utf-8?B?QTliNmlMRmVBclA2bE8wQ2hpU1dQZnNEc1dnZHRPOGh6UGJRZDVFVTVIVWYw?=
 =?utf-8?B?enJGdkIwV2pjMFNyaGVaVnpHc1VVQkFxTStmYjRGK0UxR1djQWNVWXR0TFQy?=
 =?utf-8?B?akdWQ1FsR2VWaS9VMksveTFMaXBSK1ovRU9vcExMWENtYURqSi8yRnRLZG5w?=
 =?utf-8?B?cU44R3ZaNkdFeXAzL2w3SjVPVE42NGE4ZFFqa1R5Mko4c1QzOUdDaTJVeGpL?=
 =?utf-8?B?OE5IbUdmUldhVlcrbHBEZEdZUlhrUzRkdnNQN2MyNWVGaXMrcTVBWWJEZWpZ?=
 =?utf-8?B?YUcyZVBvd05wbUFsS1RvbWlyOTcyRW0rbnpHOXZheHVGRytnQ2lyOGR1bGJK?=
 =?utf-8?B?cFpjbTJWcktTRWs3V2tqTGpsTHVqdFVpbmdiV2p1OGlOWTJJZmJJN2tBdmRX?=
 =?utf-8?B?V0h3ZVM4N0Z0ZDRqL1UrUDh3THd6eU1nS2VLSWhWQnZUWWRvZHJyQjNVSFJF?=
 =?utf-8?B?VUlZUkdHOXVJNTdwWEpuRjg1ZE1SK0krOWdDWXRYVFZZQ1VzRVJtbU04WEIr?=
 =?utf-8?B?dG1tenNpQUZrc24zY2JlYitNU2RCOXR6ZEovNWtxbHdGdWRXa0szOWJWVnhr?=
 =?utf-8?B?YXJwWFlMcy9uTUw5NWxIaHlvVW9XbzdsU3MwVUdrdWQrcGFwMXZvWFYxQTd0?=
 =?utf-8?B?d3YwMzdUR0FlaFV1dkprb0krdlpLS2QwNG9rcnBBdkJudlIvbXpGbWloK0hS?=
 =?utf-8?B?UU4wbUYyMFV5OGl1NTR3Q3htSWZPdTZXTGt1SWQ4T2g4WjlBYktLN2RkdktG?=
 =?utf-8?B?ekhKRnIvNzNRd0gxbjVna2NkNXNLRDZXSGNlSkYrQjhRNzVNL3R1ZUF3RkVi?=
 =?utf-8?B?d2VZN1UyZG83WmdoM2QzK2crdzA2K1UraEdPVVkwZDIzQUgyUFdTTG9TaEg4?=
 =?utf-8?B?R2p6SEdoU0ZzVG9qbHdlMHNMSTdvc3FFZU13ZDBFMWQvcHZLaTZxMW5rZnlH?=
 =?utf-8?B?c2tqNDVUN2ZsRHpnVlhERURhcHcyWmZLb01ETGtWaXhUT2R1ZEs3RFQxMFRq?=
 =?utf-8?B?Z0pvcEpMaGMwRllrNFgyb0FBNUVpRVdMQTh4MTg3MjV2T1E3UWljaUJlZUN0?=
 =?utf-8?B?NERwOTRyb3kwdXFSRmxOVXZ2TENNeGVITmZuZElpRHRJTFU1cFBQdHhZQWk1?=
 =?utf-8?B?VG41QkdHQWs2eFo1N2t2RzRCbzNUd0xjLzByTmNHVU9pZ3dZVE5nZTF3WDZy?=
 =?utf-8?B?b3dNczY1Z0ZBeGpLRHpoK2Q1N2JZZWVEdktjSHlWMURxcGQ3TVBNTjlLazln?=
 =?utf-8?B?ZW9QZVVucjZQdmtVd01sS3JRNjh0RjVJT1lVblhBZlNMeWo4alZqVUVPdEZs?=
 =?utf-8?B?bmh2bFFqZFp2MDY2eDZ1cFIwSklQcEVBL0RMbERpNG9TWnFqVFFkdE16WmJ3?=
 =?utf-8?B?aWlHVE1mL0RzdXk5NTB3bDR1L2JUNjFhR2dRZWdmeU9hbXJYSjl2a2JqVyt6?=
 =?utf-8?B?TGZ5OHRnR0MxbTdLOG5DMjlkejQ1NUFRTGJIY0gvbDYyazBNODNQK2o4TTMv?=
 =?utf-8?Q?bp5tTy1Z2ew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJtVmFsa2doWjFra1Q5amNScWJ1eml5bDZ6T2g0MFF2QXo5UlNmOXJwL0wz?=
 =?utf-8?B?cERJSVh0V0FpWlVGd0o3U2FXL0E5T2JIV1lDSFBSa0xZcjF3R3o1dUpFK0Rp?=
 =?utf-8?B?ZGtZSDdKTDVuYU8xMkplZEVIY2RYR1RUT3FLcENZY1VmcWd6OWZCcERudU1U?=
 =?utf-8?B?L1lWVEtTc2g4ZEdpbjFkY3FZa2JUcDBicTBWZTRCRHJsUHhMZVU4VEwzSGd3?=
 =?utf-8?B?ZnI4VEI1QVAzdUVrTjRhdW1yaGhucGJvTDRVTXY0Y1ZwVGZBMmh5ZnIrL3hB?=
 =?utf-8?B?VXAzOGF6ZEUzRk1rQkp2WXM4L0FaQ0g5NlY0REJCNDF5V1puMWdiNCtvRjRY?=
 =?utf-8?B?TjJEdUp3Q2JXZGVSdmpPMnlkK1NCVUJYV3RvZ0x0NTVlak9Fa3hxMnYrNEZa?=
 =?utf-8?B?QTNOaXhrd2h5NkV0RWw5SWJoVVlLVXBXbkV3MEZsWi9rTkNTdmlMczNkTzBT?=
 =?utf-8?B?UWVsMmMzWlcwY1FxN2ZGZ0U1TFlEOWZzMURXMnJSdXc5bWJ3b3FzSDdzbjJq?=
 =?utf-8?B?Ni9ubUFtQzNtdFlvdkdRYlFwcm5KUEdWS2MxaXZSOXB5T2N1eEIxQXpJSFV3?=
 =?utf-8?B?OEVUTEVCSS9ySEo5czQwcEU3QkpxdXJZYm1WUlF1WjQ2UCtPU2NiUkpoMmt2?=
 =?utf-8?B?ZGZSeWtOOVhHSDhGZ2tEZXpGckRUQit5Uk0xSzN1UG03MVdCT3ZhbitrYlpT?=
 =?utf-8?B?YkwrRlZhY2V3eUpaQ3RSUHZPeHVTSU5IeHpyWjBVblVDQmw1YkRSOEZsakt5?=
 =?utf-8?B?UGVqZnVhN3I5MGNDb1ZYcmdlQ3ZaN3h4WUhFeVdEYXFmWGY2WHRSTmRyY3U3?=
 =?utf-8?B?Sm5YdU83UHVvenNDYi9kQll0TFcyNGk5cEYzZENMNmNDQnl2dWQySGFwUUkv?=
 =?utf-8?B?bklYY3N2NEZobEN4d2xmaWwvWGJYd2VvQVZWUlRCWW1aOU9uQmxjZXpLbW5i?=
 =?utf-8?B?b0VzMHJWM1pXV3pqK1lwWndlQzJuQzhTS0p6THI4V3lxeE1yZytSUWxWME02?=
 =?utf-8?B?SDh6Q3JQVWtPalpnUUxjeFpReisyR1JnTjNhRTRlOWdiWGVBNjdYL3NZa01i?=
 =?utf-8?B?M1RkSndpZG9wMmI3aStNTkFNOENtL0JIRXVJb1JLRmhqdjdncDJ2Z0ZKdEll?=
 =?utf-8?B?aHB4QmVobjhBdkpQV0hnbzRBTWtVT3NmbE9Qc0x4cXJGb05vWHBxSjI1N0Vq?=
 =?utf-8?B?Myt1Zmc2UVlwS3J5T0gzMFJWK0NpMmJ5KytmWS9PQXdWUEZWT2d5QnAxd2ZB?=
 =?utf-8?B?RkJDTGt0WTdFc3I0SDU0Mlc3U0NaMU5jMi9YMk5xdlNLV3FGbmZ6VU9aTGk4?=
 =?utf-8?B?ZmkwaVRwd0l2K3VQK25menRHZFd0NFdaUk5BNmJzV29HZlcya00yUGdMRlJn?=
 =?utf-8?B?YmoyL3FYR1hRejhKbWZTM3kwdzhoRUFUcnMvN1FWY2FKbzZmclFIQXRiMlFr?=
 =?utf-8?B?UXgrUlZEaGJLcXdGVDRiSW9EOVR4aCtxWWs1UlN2eFNxMzh4TCt1ZDZVb3I0?=
 =?utf-8?B?Q1NvVUI4dmFqMmVwTmVuL2JuTWdSR2FEK1RtUlY0cHJLbmpIRnlXRmpzSHRl?=
 =?utf-8?B?SmJ1aktPTmZodWRvUzRUR1BzUHdDRHIxWld1SUtaRjNZcmZHTXBHdXk0aG51?=
 =?utf-8?B?ek51RWxqeDE1dXQyYXRodDBwdmVZZTM1K3o3L2lHMUZlSDZaVWQ1TTBwZlN6?=
 =?utf-8?B?d2kzODFsL1d4QlZPamhIdzJiOVJYajNBdDRBOEdpNjllTnA5UkZtbVQzc2Ft?=
 =?utf-8?B?N3JPMnh4elFneG9SUmphWG4vREYxcWowRXNEZmRCN3krc0lJNjZQanM5TTNE?=
 =?utf-8?B?QW54VTZJRFJnSG54N1U4amMrUWVHWUZuOXNpS09NR3JJM21HNnY1Qld2TmtD?=
 =?utf-8?B?Q2dmVFlUeUROWUZVSDFQaDYzRFJDQTkvc2ZDVEpkY1RTY045VTNUeFNzMXp4?=
 =?utf-8?B?aGJiNWxjVGdlOVhLTDVQa3g5YmpCaTNpT0JzZHJxUTl4VUYrSXZPZUdWamVj?=
 =?utf-8?B?L2dRTi9BSWVOZUgybHJYN3pzQ2RPV0d3eVBSZVdlTUcrV21PRzZkWnpiRG5y?=
 =?utf-8?B?aGNHYXd2VUh6MW9tZkNtR3R5eXkyU2dMNXU1TXhYTGJVayt0VEFkRy8wYlhL?=
 =?utf-8?B?QkxPb1FMSy83QlgrdC9Gb3h2ZXdUMzhpWHdkOUMyOGRCQU1LWEVtMEtjWE4v?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4596f3f1-cea3-4d26-1c66-08ddcfa5379b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:11:06.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBQuzZPAuG5wXeQcEHDXhdXrq2+3dWAWDE72UE83FvbPTL+RrcL2GRI7TsAdQgHlZVuq809P+jo+Xsx0SPmMgamIK1qWNJ0f0VhONEMeBgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> @@ -1799,6 +1800,41 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>  	return ret ?: nbytes;
>  }
>  
> +/*
> + * resctrl_bmec_files_show() — Controls the visibility of BMEC-related resctrl
> + * files. When @show is true, the files are displayed; when false, the files
> + * are hidden.
> + * Don't treat kernfs_find_and_get failure as an error, since this function may
> + * be called regardless of whether BMEC is supported or the event is enabled.
> + */
> +static void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
> +				    bool show)
> +{
> +	struct kernfs_node *kn_config;
> +	char name[32];
> +
> +	if (!l3_mon_kn) {
> +		sprintf(name, "%s_MON", r->name);
> +		l3_mon_kn = kernfs_find_and_get(kn_info, name);
> +		if (!l3_mon_kn)
> +			return;
> +	}
> +
> +	kn_config = kernfs_find_and_get(l3_mon_kn, "mbm_total_bytes_config");
> +	if (kn_config) {
> +		kernfs_show(kn_config, show);
> +		kernfs_put(kn_config);
> +	}
> +
> +	kn_config = kernfs_find_and_get(l3_mon_kn, "mbm_local_bytes_config");
> +	if (kn_config) {
> +		kernfs_show(kn_config, show);
> +		kernfs_put(kn_config);
> +	}
> +
> +	kernfs_put(l3_mon_kn);

Looks like this will drop an extra reference if l3_mon_kn was provided as parameter.

Reinette



