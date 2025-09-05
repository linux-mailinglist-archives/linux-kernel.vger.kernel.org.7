Return-Path: <linux-kernel+bounces-801849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1FB44AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820E7A033BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1676DF71;
	Fri,  5 Sep 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J48flhn5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756310E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030731; cv=fail; b=Tz5HmBLQUEhIBwm022hRU/sTg1NvJyCi1WAwECEI3BmltzZ1qvEKlK46gh9ONcmP3cQ1pYulNAOEuh10LY6FMidBRFzh6xBHqc+IFV4bu7BqfqFd0oclr9+jcQgCzmFtyG8ot1pQZxXtiLoATiHWNSgQ/K1kS4eEwWTMoKv8cTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030731; c=relaxed/simple;
	bh=gFdCMxZPFYYXl4QTfMUPOutBlC6HpiOv49aubcjZIEU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qXNuERu5cN2XsoF94qSmhREEG92ARf4RaPuBJtC9RQp87IBXeF44pseC9ZW6rD4MIPryN2KEriv0uSAuuif2Ev1gh6upnxOWe1DBNMaLFyLaT5GoTIWXZkYXYkqQjEEul0lToOtEYD2P2mcsuX/36oyevz8TVvSOFafdv1WLRNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J48flhn5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757030729; x=1788566729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gFdCMxZPFYYXl4QTfMUPOutBlC6HpiOv49aubcjZIEU=;
  b=J48flhn5cP6jJbznTqrnxIYZNIDMvasU/HekKRkhM78wCX4GRJm7pIqI
   3dt1XvY8runxiyfs9IYt4SNTRlimWlJnY9VtHZ2zB5AQJccieim5mineZ
   zb9Kwvfj0JVLZ5yocYO9BULm8ifB6bApBpaISb28B4dVBxBdOGjbNrJpx
   oJNsJ1fXHjXSTc1htndaPXDgSLRuIzxgoNsfMj7ACFHazmaDC9ofhipsU
   RM5gV6WYe1BVyH1R1euc/YoP12DcbCtyQhxjeTqbV9qQ+rtKsm9b070Qf
   uHzZWogwse4WNTm2BOecJIH9+0cAIs4GBjHn9FtqO4YWR32mEqqGZQTql
   A==;
X-CSE-ConnectionGUID: oeaPofwCTb+23Dsm6/EWfA==
X-CSE-MsgGUID: 9+AePOXnR3qhuI1rtjxNzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59455395"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="59455395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:05:29 -0700
X-CSE-ConnectionGUID: b19GLLkqToqbe9jsmWf6LA==
X-CSE-MsgGUID: o85NV5N9RPOf2kYI509xoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="171970588"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:05:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:05:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 17:05:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dr7tK8vXHU62qjvfMdokB3svt+78RuCnJSxrUyLMXTGMjQ3yyCW117R2Kt9LYs+ZLVMDqFROgc/9+0PvQeEEjwb/dXhdUBkvgUT9QsFzol67qhN0Dhv25mirEfGaQ/x7E2zMMNrXG8kKf1L1aUePL4XHwX6sHn30+TKuwqsVB5cnByBHtVTqiZv0WCS1xcpWJU7VFVvln+MrWhJpe0+yqOB3xbVomwPAvpCuocrcuQbFmHX0PQJSsnG2MNsyA1h9wo9gm+lRIzjnKAyu1JWHQ0Lav6vzVLzbQNFhO4OjiQH1Jfvqc1Zc2iRltuFIVGF363veTD2TUaEKkWnwxepswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66DU92PaoGdil6pHMSaQl9Ns3eTZrryXrSTj6o+WSDo=;
 b=bUSliKQIfd+QepOnG/xBu4md52lHxM7zUWacQ9itOUF3u+cSIJofhDrBdN+y3xWO/M8ggbtD/NGHCW1ZxDmRkjNz2x85UWm6957dEKD+cgrZ5AOvtEq/TSLZR9RG/veO7dzyt7tMUiWZE7mc6I0+ZgB21e8CSq+ObXkZJoUAJwoW/vRn8UQZOiAyNxdF6c6NE4eAm85+t1VfHvva8VXTBaJpTicMWB5wTD+YRd9aYgmpVma5syedwtDGXp/ax2qhAtDvKYrChLKQ5fw/q4wwQ0hEx4QYAtz8zDx8RCcarTDcnVIIIlzipV7O+CUusf0nv0iAzP2FMk9Xt4AjGESeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW4PR11MB7030.namprd11.prod.outlook.com (2603:10b6:303:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 00:05:24 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 00:05:24 +0000
Message-ID: <d8879aa6-929f-468e-bf0c-aad59bce2af1@intel.com>
Date: Thu, 4 Sep 2025 17:05:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] x86/microcode/intel: Define staging state struct
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <chao.gao@intel.com>,
	<abusse@amazon.de>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-5-chang.seok.bae@intel.com>
 <20250904134802.GLaLmYksBaQgtonEp3@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250904134802.GLaLmYksBaQgtonEp3@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW4PR11MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 64094125-567a-40a3-db37-08ddec0fe972
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXZCL2xpaTA3bGZvQ0hyamE2NzcvemJuT2R5QU5ZcE5hR0NWWkx3Q0JtRThH?=
 =?utf-8?B?a3RFeEU0aGpTVzVmTGRYMHI2SnJNL0w2dzRVT0JPTXZPZ0YvVXNuZHlrZjhE?=
 =?utf-8?B?WVZKVDFPN3pRSWFFVURsUTl3WEdnTXY5enlQRUFJRUVFUDVjQ1ZPOFczelRu?=
 =?utf-8?B?dC9wekxiUmdtM0lZYWNhYUUwbGRpZjd4SHpCcHJsNFFVZTZ5YzJiWDRzM1Nv?=
 =?utf-8?B?VzRGMW5WV250YlFMVS9XS2pmcHRZZzhDaEFIMmJQNnJCY0JkbS8vL29WbTgz?=
 =?utf-8?B?UVUvMldmcHBWOC9HMXdFTThuTWhBTHY1SnpPL21hR2NYWSt0bHVJUU5GblEv?=
 =?utf-8?B?U1VpZUdhNUd5RC94dlM1akIyMzFoZndYQ2VYSDF1UUJDcjVKQmROMFB5SXM0?=
 =?utf-8?B?Zk9NQ2NtaDZsa2xHT2tmOXAxRWhXQmwybmxvbjQ0UWIzcHdKNmFnYlBnczA0?=
 =?utf-8?B?aE9GT3NYT1QrRlFObVpVcXZtVFNYUkp5eFZrK0pQeW56cDlJcC9LcGFYdi93?=
 =?utf-8?B?Rjhnb1ZJT2lMc1I2WTVKalFEemFyOXJYUXNSTlNEOHpLWE42M0Z1SVVPeC9N?=
 =?utf-8?B?WVNDaExuVmc3QTJvemwrUVMxay9aT3F0S3NVck96aVkxSXdPVXVPb1VuazBU?=
 =?utf-8?B?My8rQ1kybWJ2eUhBcnNzTDFZMUJjNENCTElvOTBxRHQrb2hYelRVRHRkSFpv?=
 =?utf-8?B?RVZjMlFVRTBQRWVRVDhrRXhKdy9qR2lMNzNLbHhZYUFMSTloeGx3UHNjaVpH?=
 =?utf-8?B?ank2bGc4YkREeHYvQkFjUWN1U3BzVFBmSDV2NjlhYlV4dklFY2c2QkpVMmR5?=
 =?utf-8?B?WkdwemRsd21HOHltZE1weUZlb0lWYmR2RDRINkRMdEdQR21wYm5seG1KMVBX?=
 =?utf-8?B?d3dkK0xYbG15VXRicWY5UC8ray9Pa0ltYUlWdnVxTHdNSFdvazgzYXlTbVgz?=
 =?utf-8?B?MktiN1IwckI3TWx4eXlValhKQXMrWUIwVlFPa1lqYUNRSjVuVTZDN3NMK21I?=
 =?utf-8?B?T0w3Zko0TWorMGVESDdTZkxhakZLd2YyMkpSRmZoMGcyMytrLzVEOGxqU0w5?=
 =?utf-8?B?WUN0MGgxQS81K1lkaklhZTMyVFNUYjR2czQyZjZoSG4ydHIyVm83RVc4VmMr?=
 =?utf-8?B?ZEErQW1vTVpaN2g5ZlVlMnczS2JrWEI4cXd5ck5ZOWorM2dpVHFoQ3lrK2hQ?=
 =?utf-8?B?ZXBNMy9vVE9WM1RScXJRbHVWVEtFVkNPVVVzTlBmN3dOUlA3SXgwaEZtUEhZ?=
 =?utf-8?B?WXkwNTV6Sk1OWHhjeUJCUXkvMVh6Rlp0Wm9qQkJObTd2dFcwaHJNRWh2dGps?=
 =?utf-8?B?ODgybnRNZ0RDb0hJNXUwdFQ3NWhYZ3JkT1ZPbXVpU0gyN3psQW5IYVQwRzly?=
 =?utf-8?B?cXdGUEt3blZIVWJJRVI1TUx1THVObk1Pck5vN0N1d0Vva2hmSHh1b3ByZENF?=
 =?utf-8?B?U0FvOGo0N3dTZWhaUXdVVzZJWlRVZHk2bmdPcEpGZmlyRXViNVFqZmZyT2tR?=
 =?utf-8?B?dkhKY0NWYmQ1WlowenNDOG9XditSdXNtTzJoR0hMdnFrbzlybnhnWXZEc2hD?=
 =?utf-8?B?WU9qUXRNZ05yaXUzRVZpVjdSekIrTVg1UWd6MndxVXZ3Nkt1SVRPUTJsa2Fw?=
 =?utf-8?B?K0s3Yit0NlFtNkhpVGZFNTFwNURwVnR4ZUgyVG1qT3lzN2xGbkJzeGgyRTJT?=
 =?utf-8?B?Tis1dDZkZUwySTAwOWdFY3h4dEVNNVBuditmQ2F3UkMzLzNFR1BRbjVDWGNs?=
 =?utf-8?B?ZlRnOE5TQ05jZU1Td1ZaQTF3YkE0RXRIekRkeEMxTVNCUEp2cXdvUTFFVmpu?=
 =?utf-8?B?am00Z3I1TXJoMi9CRzJCOFB3TjgxQ1IvZktJd2VZdGVDYVpwMzVXa09ENHNH?=
 =?utf-8?B?NnJyYzkxeUJDSGdlVnorNkpmeUdDUDNWVUFOOUExSTZuelE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZ3TElVVGFoSEcxNXRaRndScUN0YU5lR05mbkVxUEVQa0xaVWpvQ3MyMU9Y?=
 =?utf-8?B?SzlSWWtpdHB0bXlFMytVMFZHVTcvK3BpMC9NNEZjNUFlTmZmZGZwM2RJSmxl?=
 =?utf-8?B?MjdDNGRoZzBKb2g3emdqdStCQmFsUC9Relo1eGVlY1Z0TG1uNXR6dU5oclNP?=
 =?utf-8?B?eElZWVUvVXI5VDdLQ25QSnN5ako0NVUzNkNiT3FHSThacmFLbjIvdTBvcitP?=
 =?utf-8?B?MEs0c1pHWUhWTnNra3UycUp1QUNGbVlhWDdhT1FKZmpCNXYzVzVwYmE3czQr?=
 =?utf-8?B?WTlVY3ZON0VoNHl4d3Y2UjZxWjBFQ3pRejMxTGYwUWM2SksrME5DUnczbHBX?=
 =?utf-8?B?bFJmZFloblpGWVVpYUZQM3pyRVM0WmFQZmpkbGlOUlRXMFkxYUtnWUdSRkww?=
 =?utf-8?B?eFNHY2dRYVdlb0lKMFl1eGdsNmRlOTdRTFlPYkM2TWVnTThVMEExMTBTa0JB?=
 =?utf-8?B?MjJoVzU0NCtJcXVpb3NXQnJLTWEwTlFyVTIvNjhGa2JTeWJ5R3hLQ1d2TWs2?=
 =?utf-8?B?R3A2ZHVveG5ENTN0Y0pEVE56ZEdWanQvVnNQV0tBL1AvUkFINjVhZThJb3lN?=
 =?utf-8?B?YXF4c0I3QlR3OTRPdnU3U2VGWEZ0S0NsSFF1YnhuYlVwRFBjbFdWNnhGWk1S?=
 =?utf-8?B?MjhLNEFkeXh6NEUxSG42TnduT2oybDNySUNLZ0JmZHh0ZGFLVlZhcGNrcFFv?=
 =?utf-8?B?M3RiNk54bkkwNWpKUm9pNmJES1BLNCs4V2E4dHltTDJEZ2FsWmg1WjF0VDN0?=
 =?utf-8?B?c2J4cFJXTGJNdDJtblVjSTBhcHFwWmtJVHZHZlVycWlFeTRXY0I2bGJFcTcz?=
 =?utf-8?B?UytEdkhRSWljYnBwQUZQdnQ0eFJ5dHNCckE4azljYjZlTlNORFQ1MmRGZjlv?=
 =?utf-8?B?aVRVWVJ1emFEUHF2SXFjOU5SMGViM0xTeisyNURaSm9nTXBleVdkVkNXdjBH?=
 =?utf-8?B?Y0NqY01JRGFqQmpUTElBa0ZUMHh2RVNpS08xWkpqSGMrdXRxWlRLSmNzSnli?=
 =?utf-8?B?bGUxRkt4T1F0REg3ZmM3VHJiZk85Ui9velh2anI3Qnk2eVpWNW9XM082bTh4?=
 =?utf-8?B?d01FTkw3bTRlWlJQc2Q5b2grWElRYVJXUWZYZmtKcG1WZ1pOK1paWmwxT25y?=
 =?utf-8?B?d0VJSjZIZng4VXFvdkZicks0WVZXQ0hITi9nZG1kTEdqRlIvbnl5bmVRT2Za?=
 =?utf-8?B?b2x3ck9vOUVacGdieldPTzh0ZjlGT1prSkY2ZzN6N0ErdGFldEo2b0RBbURh?=
 =?utf-8?B?RHBMeFl5NHVYMU85VU05N0I2bUlRb2xJSnFWR2J2cE1yNFFWNUdtQnd6Q2cy?=
 =?utf-8?B?Tkl3Y05aeDFrT3RIZkJ4Q200V0RKZmRBYUhzcHUzKzd1eHJOWlhraTVLYzFG?=
 =?utf-8?B?bU11QllkQ0tOZVp4OGZveWJxRWlnUURlSHhJKzdwODJSdTdqeDg4cjFkTW9Q?=
 =?utf-8?B?QTZBUTlPYmdiaUVZRW5ZNWpiemVyR2FlZnp0eGtCd1ZCWmRFdjdITkNaSFFu?=
 =?utf-8?B?WWxHV20zZDJEdy9UVjlNS2xNNm5OSmJMU05oTFdOVGJsTlEvWitsWXk5Z2dz?=
 =?utf-8?B?eHkvQkJyT1pPSnlQdTUzbVJyM3FaWUhGWjVYWU1KYjRobyswemdOOUFrYTVW?=
 =?utf-8?B?aTBEeDZucUNxTFRtREZlK2ZEdEUyYnhxUVU1T0g3ZGZYNGNVOG1KYmxraDRL?=
 =?utf-8?B?NTE0SytXM1l6Qmc4QlRDa2dmQWVqNHo5bXM0eFFHczllNk1RVk5xczNuMEd4?=
 =?utf-8?B?OFMwVTJlRCtDcVE2MnduakNZMnYzOVBwNzJJY1dJM0d3dnRLQldFekVPZUQ4?=
 =?utf-8?B?MW5WblFmM3NkeFhuOVBKV0ZnOXpMeFVRMytjcG9LYWlqUWViOG1nSGdER29j?=
 =?utf-8?B?blpiemdlZUZvNnFSNHBJUjl1TVBqRFhqMFNWMkY0dklQcXJwb09LcVR3RDh0?=
 =?utf-8?B?dmVtWnR3WGdjWEh2M2xzN0JLUmFabUdlV3pZcWJEZ1VvbzFLd1dTOUdtUzhy?=
 =?utf-8?B?aUtwVUhyR2p5REpJcG5tc0tNTTFIV09wL3ZUd1V6Yms3b0pLMXBQSU9INE9z?=
 =?utf-8?B?UGdpd1VzRWM1V3IrbTlwOXdNR3ZjVkJuSEFMNGxZaERzbHpWSVdEUmpWZ08y?=
 =?utf-8?B?OEhWZjJ1NjV2bzYwK3JHblFCMWdVS3YweWVNL3owS1RuUXNVUWlkMGZTc3V3?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64094125-567a-40a3-db37-08ddec0fe972
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 00:05:24.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuX453X7wpt8WhM/CC1K5zXulqRw32Gmj75ZuDq05wkSG2Htqao3PpVxgAD3iNhtNDjnpioFY2sIm0yij5u2rc8adWj74+0XdZ0s6D+vMt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
X-OriginatorOrg: intel.com

On 9/4/2025 6:48 AM, Borislav Petkov wrote:
> On Sat, Aug 23, 2025 at 08:52:07AM -0700, Chang S. Bae wrote:
>> To facilitate a structured staging handler, a set of functions will be
>> introduced.
> 
> No need for that sentence.

Fixed. Thanks

