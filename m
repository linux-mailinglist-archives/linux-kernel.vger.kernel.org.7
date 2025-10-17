Return-Path: <linux-kernel+bounces-857801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF99BE7F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86DCF564309
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF9230C62A;
	Fri, 17 Oct 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKQlln59"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1EC192D68
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695735; cv=fail; b=BnD7SEyH61QxOb+4mGlalUvCwk/Eq8MCwOyQGQXozw/x6Iy4C5YfacSvfRyOsTZ2WIpQD955N69oLLF2nJi91xlowGNF2UXFpbtFNGzJ3Y2reNwEwfkzx9lZw1aLUnZV+moeha8stvEMIk38bumF6GoE4bcCuvSJzkVE3BWTcY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695735; c=relaxed/simple;
	bh=0dO3xSxGQzNzQoHJ8IFLwf89PvGVVfWFuNEmUlE3YOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lq8XogeI/q9jM6dQxKnXlrFprI7TR4F5KIFfyNXygmbXVHAVZ5z11Rfr8ZgMPi+CAjPXmw/t4T3ms8SMyJ2SRwONBVhAlncyy6Zlt5wE0goZRjjOoXPW21SwzXPqdIZBxslv2BOYldh5gAApvKkH6wHet7VCOLXYGc3U20OwyzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKQlln59; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760695732; x=1792231732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0dO3xSxGQzNzQoHJ8IFLwf89PvGVVfWFuNEmUlE3YOY=;
  b=mKQlln59qZJe5k0NhvrxxqXL68VcgaiUODLiJdNp2BqcPDIy8EaecQs2
   V828Vd5/Ynf7ojDz+nJTbSPjfFokdS+TveTdI2AnyKy5UoEKYmNtZLx7D
   rOcLFTeKLRbmgGAyDNC8nr8hJ7RZyw7EMh0vdTFoqLByTgzq5OaKqfp1B
   vgSk1cnhGEEBmgJBAQ91nIMRW1Zu/hfHEFbYpEBBqESLIfo554KGAezNq
   f/A0TkgQFaIp1MLgoTjpooLQVLt1Fpdd1X5rlMWRGBLEdxrVBOzMg95at
   9+ZW9YfFdxYHCxz5qYAZSzCTq99/ous3DxB40hfdV26M9H+QnDkqD96LR
   Q==;
X-CSE-ConnectionGUID: 4KjKs2w6SF+ung1MZywJ+g==
X-CSE-MsgGUID: XhHMIBXeSLOfKtcHR/JNVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="63051008"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63051008"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 03:08:51 -0700
X-CSE-ConnectionGUID: YWcJewHET7etg8aW/hsB3g==
X-CSE-MsgGUID: tBEK8BVgTWy0x9kpRfIgkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182383941"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 03:08:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 03:08:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 03:08:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 03:08:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8YXX5ihAbKKnssPt85SyV9V0t55lRAjPk1SimoWtooaXUmhb/yP9hhU0o0+XWw7jWJE8TKTjADAKjzEyCVfF5W1AzkqZXvYxQkXR8HSGCB0W9RrNO0kUiU4rqS/5gLlC1su2SX62IrCh4dpnvayCjuJ2DvXfguJ5r57pOgli66Y/jnTDLgeyyQEJB8LbOrkYXauv4SD94v/Z2+eKm6DqI73NYStscDfk0vrKC2RsEr9Ysvzf7hfal990kObsyGzpHdcVuGIuCwaPu2bMPFfSLcs92bZHmB4U2qj80PEiBgJD4bh7JxASuA1kOdCsh72BENq2OpoKpVREFGEx1YK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dO3xSxGQzNzQoHJ8IFLwf89PvGVVfWFuNEmUlE3YOY=;
 b=sMiKEJPbAQM4V4K0HV66QE/B+XEXt/Ca63bTKQYp5pp9OclKZmcbj5FHaB9CgQqd9uRPLwtWjWpfjikCg319Ybfd23m3M8ThNyC4tw/aS2yzYrDuXeqXQDImFqxmWGZkDCeZlLWBnyTEfFUsiGIHijcjTpGEIkVuBQ+WVdz6MzcFy9iX9lp4fPgsNWhR6gfv61Ou5463LpL+2eDudD1Hso2mNkwyt/MloDQuCASl3K5WdFbuOxKscQu1Z+vwE9kfCsMZ7fP8UjGtC+Ztuco/DMxSLw1QmmHJQ8YdhHazBXRgPPi90G8MpmTnXgjHdlahSDkaE07quv+F5nrppIhvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by DM3PPFF0E3B6AEF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 10:08:47 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 10:08:47 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "sagis@google.com"
	<sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov"
	<kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Topic: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Index: AQHcMn7PzLsl5dUPTEikD7KJ8NM7q7TB2pCAgAEhGdCAAGjNAIABBY7wgAC6+wCAARGC0A==
Date: Fri, 17 Oct 2025 10:08:46 +0000
Message-ID: <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
 <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
In-Reply-To: <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|DM3PPFF0E3B6AEF:EE_
x-ms-office365-filtering-correlation-id: eb36261f-4d20-4ef8-1f97-08de0d65295f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UXA5MjBxVUVkV2hYa2ZIR1VWZ1ZVT3pydEd0TVdQVzlzcDV0aExYdUMxNk9P?=
 =?utf-8?B?SHB6QUFSN0E4NTRRbGZSbmJPdE9iZ3hUbllrZFFCR3F6ak5QRldUd1pOMUdN?=
 =?utf-8?B?TkpqekpmSWlZdWExS0JvUmRrTmxZVGdnc0J6bjVGamtaa0tyYkd3c1llOTJh?=
 =?utf-8?B?V09KaloyQjhHM0dwdkwxdmZraE9GRDU3Z1YwZVhCaWxBQUlBMU1IaWYranVZ?=
 =?utf-8?B?aG9XVmVjNjVZd3YzUCs3d0FHUStRYTF6dDVXVnJMUjR0eUp0aXIzQ3dBQ24r?=
 =?utf-8?B?T3RmcDI4eGh4SkJnQk9jUUQ0WGhaNTk2UXdUdDNXMjVwRzdCVjhLNzM5Vy9k?=
 =?utf-8?B?bUZUYWp4cWVQWS9IeWl2SVprdWZ5bElFWGZEbjlQVzg4VHdqdnQ0RnQ0TkRt?=
 =?utf-8?B?VTN5aWY0bUxuS2l3ZVZPT0djT0IzWStKb1VvRU9OMjU3aFpzYXdQaEFleWgy?=
 =?utf-8?B?bEM4ZndsQ2QwQ1ZZVEtTM0kyeGZaWEFEOWtQMFh6K3JzcVhWbGZyZnArN014?=
 =?utf-8?B?MlJjYzVwcHlvY0dDVmZ6OWQvNFdMdU04UVhjQ3JuU09rSXJoaXpzM3F2MERS?=
 =?utf-8?B?SXJYcEg5Nnlpc1VVM0Q4d0pmS1RveVBrNmVNcUp2WGUrckV1Y3I0bXhmVG5o?=
 =?utf-8?B?MTdOdncxdmt6b3NtcUU2VzBnQUVybXpRL3RITHQ5SDZVeUVib2xqOVQvU2Y5?=
 =?utf-8?B?d2pTVHh3Rm4wU3d4SEYwcDZZaTJyWXpWV0FRK1lxZWthYUFWM0lUK1MvMWhk?=
 =?utf-8?B?MGJ5eWs2ZVVIWG54UmpNbFBzWXZUTWJPMHJjeTRPMlRkdUVSV2k5bDl6a3ky?=
 =?utf-8?B?cmdkN0JrS3I5VUh3V01kYldwYktnSlBpSWF6aUttVmgxUEdYcEk0ODZQWDNv?=
 =?utf-8?B?TERlOHRtQ21QSzcrbFptSmRzL0hsS0k0NGcrMHYyOGtHeldhWTFsZGg1Rzkz?=
 =?utf-8?B?V1FNNVIxNTlaNE5VWmk5N0o0K1VHZnZTZ0crOGdVMTFWMzBwRE5ldFdwcmVU?=
 =?utf-8?B?eGorUTN4SUE0eFdGZUpFd2tnVnZrWXRGS1loZnRXVVBUdEV5T2JqWWJhNllX?=
 =?utf-8?B?d1JjS1lQNkJhQk1KZ2ZNSlBreGRvTUFRRlZTd01yWXdTekNYQ3FCRVRtM093?=
 =?utf-8?B?aURUR1JOdERlWHU3NGdINjhsTXFCQ1hST3NUSndJOE42R0F4THJhN3U5ZUZY?=
 =?utf-8?B?TWxvcDlOQXBlT2ZGemZzYTZCNlNIWFlaWldHbDhJblkvSmxOMUhqNXlKTXd2?=
 =?utf-8?B?R1UrakVDK3FtT3pTRXl6anlXR04rdXFwSkgzSEdoRE10L1N0NTR3TDNJZVE3?=
 =?utf-8?B?a0RaWGt1b2hTVjJ2Yno5K1RZZzI1OHVhemEvUVVxMnM1aEZoKzVhcEs0ejVx?=
 =?utf-8?B?bXFsdWZaeVRrWmZZR0w0RXlvOExCdzBPdmhxQ3R5TWdEZDV4YUpydEdZUGxG?=
 =?utf-8?B?SUc1RjNaMXJaQmZtTTVSd0o3RStsQ0VmVW8vK3ltSmYrblZtNDhNUnVJOS9h?=
 =?utf-8?B?T2xuUGZmRmdPNXVIZlZLdk5oenVSTjZ0cWdRZ2ZvRExvVDhMcTgrVGJnaGsy?=
 =?utf-8?B?VllLc21TQzBkU0VKaS8xNkd2dUpkMzVoQ0h6d0NBWW92VFdmbGlGMjFQOTMx?=
 =?utf-8?B?NlYzUTJpOG1KLzVhb1puSWR5ZVhVUS9YN0JwYlF3bkF3akk1WEcrSmh5TGtL?=
 =?utf-8?B?UUduc0Z6ZGpkNVVuY2t5ejBaL25VNUQyVmkwbFJBTktpU2FvQ25wM1VkcU9Y?=
 =?utf-8?B?SGV5U3l5NzlwcktZWDhhV0haelliTDRTb1VETkozN0pLM3NZVGN5YmE5VW9x?=
 =?utf-8?B?Z1hnYTNiRC8wUU5lc3IxejM0OUJsTHdkZTI5L05Lbkhxd3V2WFJXSVZNUnJ5?=
 =?utf-8?B?T2hCUkJyVzBxN3F1WGczaUdTVkM2QkxIWWtzRlVOMTJNbUE2QlJBWWE5akhD?=
 =?utf-8?B?b0tMYmN2U1AyVXB4dUNVbzBMTmVwQ1FiUGpsV0FmYmVUejJ6aFpONFA1ZTMv?=
 =?utf-8?B?WDBOcUZsSkZnY2lFRC9Lb1Z3bTdaK3RrRDJ1dGFhNDJFQXJEZFhFeEg5Y0FE?=
 =?utf-8?Q?8m5Nsc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHBGcHg4UlNiM3JscWpEV1J3RjdXYmJrd0pzcGdRcXZ6NUpOM3AxM2NMYmJH?=
 =?utf-8?B?OFIyVmtDdC8zckwvSmhtaTJZcXlUeXI2UVV6NTVxNkV1bzd6RFk3QlJKQ0N4?=
 =?utf-8?B?NTlkMkJUelJ6K2k2dTRvK1ZBc3Q2aW1lbWN0ajlMWkV3eWZNMDFWdTJjU21q?=
 =?utf-8?B?aXJyalRJckl5bU4wRVRheEVVcHZzc2dWSDJZb3ovbWE3KzdINlF6cFVEalpK?=
 =?utf-8?B?ek9SRzRmNmFRWENMM1MyaFBVWnBIZ1JmbHFjNUF1bjh1WnUzZ1B1VmhaY2Fa?=
 =?utf-8?B?S2pLWDFGRXowQmxSdHRvMklyMXVMeHpxZ2g0NDYxWHlWZGZWcjVTUDM1YUdQ?=
 =?utf-8?B?R2REeDc5cjZuekhQSjgzVUhDcUE3N2czK0dncU94M29XbzdCTXl6bFBxc1B1?=
 =?utf-8?B?VVJtT2xQYVNJbmNNVFZSZWhXaHlOLzVGVUNzM1h3VjZPWWxXWlZYTnk3ZWdK?=
 =?utf-8?B?akFiOGFxUEM3VjVUWlltWi8rSzRRSG9UekJ5MUp2OGdLcFlWN1F3NytabUxz?=
 =?utf-8?B?Q0IwMTNEMjJQb3AvVURzSkJhNUVybjA4Tkx6L2N3OUdxV2hyVFhNU2ZzZUNE?=
 =?utf-8?B?UXFQdk1DdThnZE1ncy8xVmdiWmFLS0xIOERSNjJLYlZrTFUyeWI0YmMwUHRC?=
 =?utf-8?B?Sm9JbGpFWktGaDNmcjdqT3krU1FWcTlFemxrWXhiMWluNEVEQ1ppUG9qUzBT?=
 =?utf-8?B?c3J3OWhjZEtLTVJhR0g4Y0xsbUQ5M0R5Y0ZheGJMcG93WWtMKzhzSTJFbW5E?=
 =?utf-8?B?NS9zTUxubU8xWTU2dEVXWnF0YnJ4Y0hzM2dTTUJNeDJseVdwVFFWODNnRUZT?=
 =?utf-8?B?MGVDWks5enkySUgxbFJKd3pmMFpLNjJud21FSnBLUHZIZGs2Sm9pbnRLbDYw?=
 =?utf-8?B?QUxnVlpQSDlmdWYrTndEc3VGK1g1VHRLeE9nVlFYQ0drNW1NMHlzOVE2M2Nu?=
 =?utf-8?B?alJ5OVJBK0VpSjlzbmxnTElOTFhHNk5TMTd6MGVwZTAzWmZGNjhLV1FOelZX?=
 =?utf-8?B?UDZGeXkwenNYSFJWUlQ2RlZnNmp5YXBMVW02VWJQY2VJT0R4LzV0SUIrWE44?=
 =?utf-8?B?VU1BMWJ0QW9ITWtPcm5RZmtKWXdFK1daMUVuK3FoTlZGa0NQZzRja2wwZ2dQ?=
 =?utf-8?B?T3JwancvTUoyMWFrTDRzZ3lZUkFhd21Fc0x6Z3NaOTZiQ3piQURtVFVmVVNq?=
 =?utf-8?B?UlYwTHVpWjEvd2xjN0FHcE10Z2JnRWZjWGErZDBFOXZ0Qytjdjc4ZlVwV3FD?=
 =?utf-8?B?ODg3VW9CRXU5YUpmUEVjNlFiQjJ5V3Zna1JuSFRmTkdmZ0Q1N0ZlZmJBSDBR?=
 =?utf-8?B?ZzdIUWV6YkltSzNsRmtZWU1yUEdDNHFaRnZTRzNNNXNtbzdGUWtDUkdDamRV?=
 =?utf-8?B?a3gvdmVxYzcvRzlmT1NJN2l6cnVCT2NzR0x5VjQvcW9iTGxINERDU0Irc245?=
 =?utf-8?B?MjBtSGhhdnRXeVJNOGlhOXcvMDNiSWF1Ti9ieE5nbDB6TmJLd2EvVFNjODR4?=
 =?utf-8?B?ekZWTHdsU3YrVkpNS0ZxV0tpSkxGMitscC9nYnNtckhOSFBtMVNMZEo5cVBv?=
 =?utf-8?B?d2N0dFpPQWhYME4yTEFMQmtBOFBONW9YaHZzdFRFUHFoZytjMkZVOEFSZmFv?=
 =?utf-8?B?Q1loK1JkS0RoK0w3b1lUcms4WUk4Zm55akw1S3FicEZQK0h5bUllMjZnd2M3?=
 =?utf-8?B?V3hnT21Ia1c4L0xyNXZpeW5CUEJFcDRGK0JKK2lXallTa1RpVHh4ME5jU3N3?=
 =?utf-8?B?dVlQM1ovTVl4ZllCZEM2anVXQ1pNRHlUaVNpd0RQdEllNGdrZTJSQ2hzeGxP?=
 =?utf-8?B?dVhITi9uaWdXR2N0UDNpcHp3UFZWTjl1NlI1Q3pNZlRBdG1aL1BlbHZnbGN4?=
 =?utf-8?B?aytNSlBIQTZLeXhCV0hES2ZNdlIwUkdqR1RnclVwbDV3TmpFcFJManV1UlIv?=
 =?utf-8?B?ZUdNU2tNcHhPTExueGtxbW9ra3lIT2YvaVdQYW4wdVlHeHRCdVhUNGNONGhV?=
 =?utf-8?B?d1EyRzB4ZFA2QTl1eVJBTWhFNk5ZclhYeU5VMEtYNzZpNkNZUWdSYllKZWNo?=
 =?utf-8?B?cFNTdnFDbTJqQWswRjhGMzd2WlRHUHYzZVVWTFR2TXNlbzJTY0JYaHVGbTVJ?=
 =?utf-8?B?WUVzOFZkTllIeUs1U3h0QXdteDg0clVibmlQNWJhbHMyUngyQ3VRWVJwUS9V?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb36261f-4d20-4ef8-1f97-08de0d65295f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 10:08:46.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6T2SzPI4BjFvS4iW1mHmTy2eKYsj1QYXV8EgcdgOGDbHbWjDBhDGo3VbS+6fS8kb7ACxaVNXNiSmYIBR1PVNdh2plPoYSAUbNMC09wcn2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF0E3B6AEF
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlzaGFsIEFubmFwdXJ2
ZSA8dmFubmFwdXJ2ZUBnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxNiwg
MjAyNSA4OjQ4IFBNDQo+IFRvOiBSZXNoZXRvdmEsIEVsZW5hIDxlbGVuYS5yZXNoZXRvdmFAaW50
ZWwuY29tPg0KPiBDYzogSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBHYW8s
IENoYW8NCj4gPGNoYW8uZ2FvQGludGVsLmNvbT47IGxpbnV4LWNvY29AbGlzdHMubGludXguZGV2
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7IENoYXRy
ZSwgUmVpbmV0dGUNCj4gPHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+OyBXZWlueSwgSXJhIDxp
cmEud2VpbnlAaW50ZWwuY29tPjsgSHVhbmcsIEthaQ0KPiA8a2FpLmh1YW5nQGludGVsLmNvbT47
IFdpbGxpYW1zLCBEYW4gSiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsNCj4geWlsdW4ueHVA
bGludXguaW50ZWwuY29tOyBzYWdpc0Bnb29nbGUuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7DQo+
IG5pay5ib3Jpc292QHN1c2UuY29tOyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IERh
dmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+OyBILiBQZXRlciBBbnZp
biA8aHBhQHp5dG9yLmNvbT47IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgS2ly
aWxsIEEuIFNodXRlbW92IDxrYXNAa2VybmVsLm9yZz47IFBhb2xvIEJvbnppbmkNCj4gPHBib256
aW5pQHJlZGhhdC5jb20+OyBFZGdlY29tYmUsIFJpY2sgUCA8cmljay5wLmVkZ2Vjb21iZUBpbnRl
bC5jb20+Ow0KPiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAwMC8yMV0gUnVudGltZSBURFggTW9kdWxlIHVwZGF0ZSBzdXBwb3J0
DQo+IA0KPiBPbiBXZWQsIE9jdCAxNSwgMjAyNSBhdCAxMTo0NuKAr1BNIFJlc2hldG92YSwgRWxl
bmENCj4gPGVsZW5hLnJlc2hldG92YUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAuLi4N
Cj4gPiA+ID4gQnV0IHRoZSBzaXR1YXRpb24gY2FuIGJlIGF2b2lkZWQgZnVsbHksIGlmIFREIHBy
ZXNlcnZpbmcgdXBkYXRlIGlzIG5vdA0KPiA+ID4gY29uZHVjdGVkDQo+ID4gPiA+IGR1cmluZyB0
aGUgVEQgYnVpbGQgdGltZS4NCj4gPiA+DQo+ID4gPiBTdXJlLCBhbmQgdGhlIFREWCBtb2R1bGUg
aXRzZWxmIGNvdWxkIGd1YXJhbnRlZSB0aGlzIGFzIHdlbGwgYXMgbXVjaCBhcw0KPiA+ID4gdGhl
IGtlcm5lbCBjb3VsZC4gSXQgY291bGQgZGVjbGluZSB0byBhbGxvdyBtb2R1bGUgdXBkYXRlcyBk
dXJpbmcgVEQNCj4gPiA+IGJ1aWxkcywgb3IgZXJyb3Igb3V0IHRoZSBURCBidWlsZCBpZiBpdCBj
b2xsaWRlcyB3aXRoIGFuIHVwZGF0ZS4NCj4gPg0KPiA+IFREWCBtb2R1bGUgaGFzIGEgZnVuY3Rp
b25hbGl0eSB0byBkZWNsaW5lIGdvaW5nIGludG8gU0hVVERPV04gc3RhdGUNCj4gPiAocHJlLXJl
cXVpc2l0ZSBmb3IgVEQgcHJlc2VydmluZyB1cGRhdGUpIGlmIFREIGJ1aWxkIG9yIGFueSBwcm9i
bGVtYXRpYw0KPiA+IG9wZXJhdGlvbiBpcyBpbiBwcm9ncmVzcy4gSXQgcmVxdWlyZXMgVk1NIHRv
IG9wdC1pbiBpbnRvIHRoaXMgZmVhdHVyZS4NCj4gDQo+IElzIHRoaXMgb3B0LWluIGVuYWJsZWQg
YXMgcGFydCBvZiB0aGlzIHNlcmllcz8gSWYgbm90LCB3aGF0IGlzIHRoZQ0KPiBtZWNoYW5pc20g
dG8gZW5hYmxlIHRoaXMgb3B0LWluPw0KDQpGb3IgdGhlIGluZm9ybWF0aW9uIGFib3V0IGhvdyBp
dCB3b3JrcyBvbiBURFggbW9kdWxlIHNpZGUsIA0KcGxlYXNlIGNvbnN1bHQgdGhlIGxhdGVzdCBB
Qkkgc3BlYywgZGVmaW5pdGlvbiBvZiBUREguU1lTLlNIVVRET1dOIGxlYWYsDQpwYWdlIDMyMToN
Cmh0dHBzOi8vY2RyZHYyLmludGVsLmNvbS92MS9kbC9nZXRDb250ZW50LzczMzU3OQ0KDQo=

