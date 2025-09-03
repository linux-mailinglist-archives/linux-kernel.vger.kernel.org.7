Return-Path: <linux-kernel+bounces-797623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D65B412AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A72188EB2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89B2820DB;
	Wed,  3 Sep 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8vbIoLR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844C25A2BB;
	Wed,  3 Sep 2025 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868391; cv=fail; b=nzPvz1FRvFzK6Redtpf+yZjJwrWhYehrsTGTZvz8Tiv9J6pGWqrUfyLMm+zOv9fmAAMSUkWc0a2SYkM8RSIBzA44vndYa5qUoA64Ojk2oRtnku1waiUMxp03nH4N2ApGJ3nswuFeylGsEKMexzgVJ4+It6rVISjKooWQSj9xnfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868391; c=relaxed/simple;
	bh=kL4KghgUjmyDwHBEL7E2KdMh3U/oqIKfnomS9B/q+kM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UyIML8eqqqFANtptsEPEAFWMZdBBOAMIgsZJio+dsKqvrYlMpJVtMu32PUalb2a50RBBYfL/cWyDJFnqNyC9IQ9kuaZx9UycWipYaC1ZejyXgvXmJnpYiJdm7neGcZVj8BH3H2RrXznNZkJp1FjDKepMZzx4yOuQLLXt5sWSCpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8vbIoLR; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756868390; x=1788404390;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kL4KghgUjmyDwHBEL7E2KdMh3U/oqIKfnomS9B/q+kM=;
  b=A8vbIoLR5qAkKs18PJ4cT+NPfitejf3/uFKI9Im8BVTksFIJE22nwCku
   nOdqJihVc7jAAsY9GgKqYHV9fQh4ZiNMhlC3Oy69kaCObN391BrXAbVBa
   ZPllzCDdzH6vvVAApR0/utO/MPTJHNjDksx2VSvKntFpElWvDMtqOiwfi
   eqIkj9yfNgd6wYgUQJwmbN/Dm967m4xT7H7m7t7p69I4S7l0UbdOu8MvR
   CmB5b/q9ONjMnyBenypFVvdEAfYkB17lrxPaBp1jVaP02dVc+bEa1Tafl
   AUHCi7hDxYrBzAFhRldnrJbpnIQ9G1koRmo9xTMUJBbvVj4r+UCpr75AO
   w==;
X-CSE-ConnectionGUID: BB7/BVFKS6q6hFBp4iLGcQ==
X-CSE-MsgGUID: 0iLZuVC5SHyHPTm8cOjj1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76770644"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="76770644"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:59:49 -0700
X-CSE-ConnectionGUID: kOHQnywtRXqVxpVtYUwe/Q==
X-CSE-MsgGUID: 9oKc8lA8ToG5wwjfZ9s0Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="195099954"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:59:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:59:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:59:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.75) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:59:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdRxNh7VPnxHDR/LZ5irqg9JlwENQ/X2mSeDvbDwUKnWI+JzKx1k9TuRjdsTcateLEYDVVqOQzhRReYJaYlwie6MnizZzmyFNAVbUbI4CHbmZwFYjCmPB0HxvyWInOmCudpSWwp7eq01tBPjjQ8g/23p3xmtvbAWcXfzm+unKqH3Sz5WlN2zrFgQHs25hCMv+bAXJNi7dJVtJenKA6JxkJQtGS78jmpplZD/M+XIemFU15F/GP5MOmY+nJxBduZfSZh5/m8rnPhjF8hSZXoHt412KjHVbYf3KOAzvFGJvwglGK2xK2Z3xsFBD5bUjLr3UyPlsQeWnS5zi1qC9Kwx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJBeoun556+2p3vfmG1X5VTFIhsLKgZqGs8rFHWx8+k=;
 b=aSg2h52wD0XuNr5OTzBBPolSPy9OyT4+CO4mxCAiv5hZZsohlRG0/t7Q4Ih08XfJjeIpjX/wLcdi6hCr9E+rh5MJ8D+mAry4z/FDH0UEVDuryOeghfOWlajFNHLYdNjEZuKa8jsTiyZQIS6OnnW7SbCwFJ3FPkgPbJJ6Y6tqR22dLnTP/SSK3NGmoIVZT31ExlbId+f/hjxbR7bruB82+Rx67lHxixGeUtVNob+KdeFEgVx0CmojFpWucjTKxReEzkYGTItphhBqlkzyB1Mf3afq8zR5iwMjgZfffTudWMDimKrcFu1sZbmHuG7UDPF4c+12LZzC4nAewj9piw4iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 02:59:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:59:44 +0000
Message-ID: <c7cfadb6-4751-4ea7-b602-896334014411@intel.com>
Date: Tue, 2 Sep 2025 19:59:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 28/33] fs/resctrl: Introduce mbm_L3_assignments to
 list assignments in a group
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
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
 <ceb6a32f3d539fb52f5271242a4fa68b1a173279.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ceb6a32f3d539fb52f5271242a4fa68b1a173279.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: fdad21ad-323f-4772-9f68-08ddea95ef75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGhXVUUxSENWcDhnb3hmWmx3OU1qVEIzWFpTNWNMbDBPdnROdldjK2pObTkr?=
 =?utf-8?B?emtNSzFxVXBKQ0ZsdmJpbjFxVURhOUMyVUFNcmw4VWpKY2pqOGF6Vmp0UGxF?=
 =?utf-8?B?MUo2T1JhT1NCdytSbzVUa0RzRmVNTi81SGNCRVY0QWxYUDVKc0lsNUpjb0RQ?=
 =?utf-8?B?MnIvL0R2d0hsa0hxYTU5NXIzdWtmSVRQQ25wWmxYcGtXc1pRa2tORFlTZGNY?=
 =?utf-8?B?azhsVnBwN1BRTEcrZjdabFhZNUZid0ZsQ0R4VUVpVmI2UWRuR0ZtZEpWcHRD?=
 =?utf-8?B?TXVadmVMdlFNamRGcVVmOTlXYW1Ddm1zZVE1QTAxbUFzNlZXc0k5MXVqYkhM?=
 =?utf-8?B?OWJGcURvbEJ0TjMxTy9Qa3NIUkRoNi9DQnY4dHgxRHIwa3RhWmViUnVyYlJt?=
 =?utf-8?B?K1hqZ0QreG82UlhVZHpncGF6d0hwSStjZkZ3RXBtVnBQcFNWM2JYYTgzSUVY?=
 =?utf-8?B?QjVBd0lmeXBQajRIbkdTeGFLOWtXbjJSd3JKcHVrQnRPWFZ6WFRsRHN0TUdC?=
 =?utf-8?B?TW9UOEtiOEhWemZsak8rUVNCdXhnUnFveldEUzBCS3hUemRaK1lDQzVPb2dD?=
 =?utf-8?B?d1Yvdmx1a0kvajNNWlkrUHE2N0ZJZEJUMWtvUldVM01wMndVd3JxVU85TzJL?=
 =?utf-8?B?WlY2N09jTGhVN0VFOVhOdyt0WGc4aHhCck5UZmpGalIyZzFpYW80MzlBOCth?=
 =?utf-8?B?Ri9jV1dwVTc4SUZxcUl5Y2RCOGt1YlZiblAwYW1zNFIvMUdGSGJZNEZJYWlt?=
 =?utf-8?B?V0l2SGpoQnQ0TkF1UXZkRTJJRlZLK0srZHVWL2FDcHorb3dUMHJvUDRtQmt0?=
 =?utf-8?B?cVk1VGtJZHBjbFI5NW9KSTVxcWdJait1S05pVTJwTlkvTVRQb085NVE1OW9M?=
 =?utf-8?B?cUxxbmxhWDNEaU1qdUtkMnFXYlNMNGtnOTlxVTdnRVo3VklPMzhlS01oNWQr?=
 =?utf-8?B?WmUwam1yTWF0OXJYT20vUnoxVDBlQmk2LytvbUdHUnZneHlQdTg0MEJtb0VF?=
 =?utf-8?B?MlZBOFZVeWZ0MEZtYWJnWkFvOVZYR2JVSlByTWRMaUs1YnVFUlFOcUxncm5T?=
 =?utf-8?B?VVVWTGprUFFiZ04waDFqRXJzY3B6ZEF2WWEvT0RmTzNHNFJ1NzVjUmszVW9U?=
 =?utf-8?B?dXh3S3NkUlVtU0RRM1kza3NZdjZtSVV4aVpiYUZwbTM5NnJibnBiSGxZNGJI?=
 =?utf-8?B?SWdmTnErZEd1U1liM3NNMU84MDg4QVJQbm5MSU8xUEM2TG10WXk1WkNTU0pL?=
 =?utf-8?B?NU9NNCtON1QxVTgwUWtXaERoajd5czM0K1NkVHhEQ1JKZTFXRHNLNmFQM2N0?=
 =?utf-8?B?QXo3eGRCS3dpVnhRODJqT1ZQUDY1dGR6SmozZVE3T25id2VOVjhEeWE4cVB5?=
 =?utf-8?B?WWc2OVhrWkNoc2xvQVZYeFRLVDJzTitBSmljOFJPVVpkSW1tVnl5QjlKWVZR?=
 =?utf-8?B?aWowVGJ3UGV3cTB4RlJPN0oxYkh6Q0FzTWFLOEhxdEh0aDFWaG9oYVpMdW1S?=
 =?utf-8?B?LzVTazhtcytmVXNQbUE1UFpIMkMvaU5mZStnZHVSa0gyb042UGdYY0xaRU15?=
 =?utf-8?B?QzVrODE3OW16ZXZ4ZnFmUW1xd3hpZWtKVnd5YitSL2R2SVV1L2Q3UkZvbWpm?=
 =?utf-8?B?czJRNEZ2Q3dRaytaUWMySC9nK1JOVlpHWjk4Sk5NM003ZTJicnRGZDlaSWkz?=
 =?utf-8?B?K2pjQUxIcGZ5NDQ4MnRjejAyckJQOER2aEkyU0tMYWZtMWxTTWhPT3hsek1O?=
 =?utf-8?B?RFMwcTNMa0hvdllTckxWWS9KNVRnV3pPaVlWdVhMYmtlUGoxcllHcmJDQmYv?=
 =?utf-8?B?VWI0T1M0dnVFWkdRSGdVZUVLOHdXdlE3SkQ5YlUvZjBFU1QzcnRHQ3RDeSt5?=
 =?utf-8?B?SkJYNFFpWno2OXBJWml3bythc0RUM0RrNWtOMVU3WWZPY2dNdVM3d2xQR3E4?=
 =?utf-8?Q?ZTU9KamanAc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXNVbS9SZmFvaFFjbyszVTBmTkhMemxkSWlzQW5JU3p5NWZVRHBHbkZqeVVv?=
 =?utf-8?B?cEdyK2hJYldsTmZPeWorRFVia2I1VDRhQ3VJM0hNdkNPSXhsQ0Z5OVNLMWFq?=
 =?utf-8?B?VkgvTVJ3OU51allIbmZjZEF6bng2dWZsTWcxOTZ2cWJCZnY2ZTkvMDlsUW1p?=
 =?utf-8?B?alN1RWh1aVJQaGRBbDk4ZFllS1duNndSeEc4RGQwbUIzL05wekdJNnhiekVj?=
 =?utf-8?B?c3FWTzVWb2ZpRkxuemZXNGU4aDBDd1dRTFVOWUNzdW16Nkh6WE5TeWZ1Tm1h?=
 =?utf-8?B?RnF2Y0N1S3ZWakd1Y2xpdnp0MC9pV0xPRkw3UVhFSlVNOE9LeXM5NVd3Vi9n?=
 =?utf-8?B?SmdLanV0WjEzcGFic1VDU212SzduN1loUmpKaHJHU0RJSDlVVlpMbFdIeWF6?=
 =?utf-8?B?RWdubWx3Si9JQmRwSDN6bUlFMmxEbmRMQm9QdTZtMnBIb1lsK1R2TXJQNjdK?=
 =?utf-8?B?MVpWM0lYUUc0OWNrcEoxM1hQSld1dCtuTVdKOVVIUU9zS1VyUUV6NWRtYzFQ?=
 =?utf-8?B?eHFvdHNxT1RPNWlLZkc3UnlxR3lwMjQ1TTd3eEx4T0FZcXpqSW5rVyt5TVQ3?=
 =?utf-8?B?UWdKRUFxcDlmYjNqWCtGVUFYZjJyeEtYOHNXVXE2Y01uNjlsWDNEeSthazd0?=
 =?utf-8?B?WVJWSjlCSGhQVWUxRmNvSFI3K3orQ3dnb0xIWVhvc0pBN3dudFhNZUMvWkhp?=
 =?utf-8?B?eHRDZXljdjVLbktabFc5c21CTEZDZU1sYmlRcGQ1UGV3QWJkZjgzKzh1UERq?=
 =?utf-8?B?djA3ZXZKdkpqOE50TlN5MDFOenBDVzMvVEFYMjk0aDhnZlFhSk5udk0zQ3ly?=
 =?utf-8?B?bnJONFhFYzkyc3AwNCtFbkoxbkk1eTJsYW1pUVcwQkFCdHlWbEFPZmJjYmFI?=
 =?utf-8?B?VnNHSWN6YmdPaytxZVJrb21sd3pMZm80NzZyT1VDRXBQYVhQTW9rMmhiUXRR?=
 =?utf-8?B?WVRDM2pIVlkrUkdTaHhwZU9hYXNlNUJDbDhTWEJmMVlGNURMNkVNb3E3L2RR?=
 =?utf-8?B?Mm93SVh5RVphUlZxbVdVbXNBVmhQT0ZMNzhGMDUvUUVZY2plMTMvbGlpR2pa?=
 =?utf-8?B?ZXJrTUVPemJveExsM013ODhycEtFQUc5a2FxQXFONkZ5VVZUbXRkV3pPVDVR?=
 =?utf-8?B?N3M3RGJITXZqLzFTNXhNTENabWxOYTRxQ250ZnlHVW1UQVZVV1VNa29KZXo3?=
 =?utf-8?B?Rm9HbHdZWUI5VU5pdTNaRHJyN01OYUN0cjIwdVp6aHZzSk5VbTBtT2k3MlRr?=
 =?utf-8?B?Y09sUnI3OUk2SkpHZmkzRTRoRExHZzdKQXBsenZOOWx5cEFvcnMzaThMVldr?=
 =?utf-8?B?RENkY2RjWGNZSTIrRWhHTys5RkVnSEFxT04xd3NCSjhFVkVVMENMdkQwUVdW?=
 =?utf-8?B?Y3FJMmxVTXM4U0lvOGxkdU1mS2ZNbnFMcnUraWo0dlEvN1R5akdhNDM3bjZY?=
 =?utf-8?B?b0hTamltVzZQd0NQS2JVSnBTa1Rxa0F3TERnWVhLSm5XS05LYlJSc2I1UktT?=
 =?utf-8?B?eUloVllLY0VBOXordXBjUmoxU1NYRVVWVDN4dWFEYzNiUnlzeVNLdjJkemNo?=
 =?utf-8?B?UlpDRFNwaUpMSEZwMnkrY0d0OWNqOGF6Z2tCMEQrRWxoR1pVd3lIUjVhMm9q?=
 =?utf-8?B?V0Fra0VOZlRzeU02WTBWSEo4Q0d2dnRPUHg1NWpLd1pRakZETkZERlZQVmNL?=
 =?utf-8?B?SE9NQkxRMWU0Q1ZKRk80Q2ZrdnlSSlZ6Ymx4MTFETlZJdXZNcVNhT0pqenYx?=
 =?utf-8?B?UEZuN3oxdUVkWU1jbUVzemRlcExVa1hrVnFIZTNtY01uM2srcW8wL3kxTnNR?=
 =?utf-8?B?MDRsem4xM29BZ0RUeFpEMHRQUWdDQVFMeUtzWWhvUUc2RmphbVpIMFYxaSt0?=
 =?utf-8?B?MDcyalJ6TUU4M0Q0cmdjd2RmVzZKTWJ0Z3l2UnB3cml2RUp1aklxbzNCWU1B?=
 =?utf-8?B?NUZGWmZqblhvMTdPeFhGbW1YTHN4THJUZGVtcGY3WnJraWY4NEtLZ245akhE?=
 =?utf-8?B?bjdWTTJrNklTMnp4S0swNEtyeEdIdjlab2w1c2oyV2N4ZlMyZ0NuekU3UDZN?=
 =?utf-8?B?L2RUaGkySlRuS2s4OFpLS09CQnJnSUovK2FSbmlIR0hLV1pzeWdpam5KVlhE?=
 =?utf-8?B?TVpLSW90RkVFTUlXb2NNRld6YTErT0dXczdNWStQdG1vcWRqRGJ2U01mck4v?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdad21ad-323f-4772-9f68-08ddea95ef75
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:59:44.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xkdVPMqmthIr/DxYY5D9IxXwUsN/ToWAMg3knAyJiOFkWpJQQArxBy0IeBhmnjyOoXlpgglv4GudYwStSeqNDVTyqy+S0nd/NHZPN5CwUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7410
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 1de815b3a07b..af0c38206bab 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -519,6 +519,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>  	/sys/fs/resctrl/info/L3_MON/mon_features changes the input
>  	event.
>  
> +"mbm_L3_assignments":

Looking at the final documentation this addition is made in unexpected section titled:
"When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:"

How about placing this description in a new section titled "When monitoring is enabled all
MON groups may also contain:" (note the word *may*) under the "mon_hw_id" description to complement
the earlier "When monitoring is enabled all MON groups will also contain:" (note the
word *will*). Open to other ideas of course.

Actual change looks good to me, just the doc placement is unexpected.

Reinette

