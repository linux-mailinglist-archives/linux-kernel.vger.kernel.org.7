Return-Path: <linux-kernel+bounces-740061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CC8B0CF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2162E3B4113
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ADD1A5BA4;
	Tue, 22 Jul 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzgYWZTm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1B2E370E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148429; cv=fail; b=c0dhBLidqtcbiwmkkEOCNWAxG2PxNf1xYQMH2O+6nII0tcUi49SnnKgrGy2bWDwvyp5IVO/dDZPnz7R8LPPYRyDINbOTqRRpBtRhYJ8fim+/e0ZbxB7xvExd3BzSYCZN/lt494sZVLNRxe5LugD3ALkqiSPvRCnEjLMlamIPdaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148429; c=relaxed/simple;
	bh=OOcKQx85Khah6R16f3iTkwVTnWn3gPxSjGsJAnaAS6M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TmpHpUdLgPs9sj/cMjtrlHtenZ5qR57ruiVWajmzepp4f5wNG/8pU46ojE3QVHxdq8eJOlZNScvYmVgdQR6yD1reKYvDwPSTQbyEUvkylXRFU1xNI05ZUPg2Tf6cO4ZKKxP+GOB74ANgDB3mFgPelRYG4xey4jQwjxVbJLaEito=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzgYWZTm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753148427; x=1784684427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OOcKQx85Khah6R16f3iTkwVTnWn3gPxSjGsJAnaAS6M=;
  b=BzgYWZTmTGb6jelJhSzyTfl88B7Le/biEy5+U0IXb72BwsiNM90Rx64y
   beZmg4a5xqPRwFspd9t00Jc2wqPrJPTOqHQKHacBu+L7M2AU6UgUT/7+R
   eMguCwv+LeUFSc1CnLxN1BZScV8ABKm5UY8Em1CkK/gr2GDWYjkk9QceU
   eCJba8RkX+J4u7hb3ZqKtm2VYsXxR7JngrTrVYerYeyRzSmrO3UZKX3r4
   tDZRZm/fE0z+bFJVFCf/L/juCq/L4gjEexjwSJ4aXWDfuLufW0x90NMEx
   I4D2AInhjTB4ehy38aL0BEINZtUasbA/c9jRRSC13fSgLSOBj/Doeh/fU
   g==;
X-CSE-ConnectionGUID: TnOMkwduSgaDLRrQaNmnyw==
X-CSE-MsgGUID: 7W7CGhfJQp23Jn4VVoD1kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66726025"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="66726025"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:40:26 -0700
X-CSE-ConnectionGUID: f0Re7W7fRD6yQeSY7RI69g==
X-CSE-MsgGUID: m84lsIdeRI2hiCSDMNm1Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="158777392"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:40:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 18:40:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 18:40:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 18:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfS0K6gVJ3KKBMLQZKa3HurdV9nFw/RulxuFTDuJlTNIUX4SSYCdWuisjtwsMZZlBuRxrqMGUmCLTQJ4h/+O8Nhz8kXiI15KhhcwmRPqSON9sQvSBdk6cMLcxP4ln/wq3s730ODPxaoqKwBkMfV5i5wjMFOn/i430xj+yYAOVL0iP1e0uPBhSl11tX6M8vufmIPw0eIXqv8BCsv8okzZVK665at6KCJcgV3edBFzXgl88v9EOr+WLU12ZTi4Pc0VIeXHvsfN5Le3auX2Vih7JJb5XylX/o1TBKA84fVR5Db9f8lNyKkB3Dw3UoasFGt/vnxmGea2Mc+L7ifUDu4M/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwPR+3MEB3QqUdt4dsuMB0adLcWZQZboKoLwTfpGkKY=;
 b=HQmyA57D4iGzZHNJo8KKgeluXvxNNAy+t1eNlcO3HTM5bNZril1B9LYXqhiIWohItEnJHZyTaXKx87MXiu+4Wbwyluo1Ac15rzIfO2jVy3GKOoFpOGPpXsFFlMy3vtCrGUqNIPOXDY4R0NprTuMuqxNIoV5ZZjH3fOYg8GdzLVdVAiSuuj5nog8aq6CtVvUWR7jXXXXrDOQ7TjGeyYzTjgY0x5EeZTAVmbOZzW5OaIlmYWA78+yooovv/6AWJJrTFwkunLtW1hSvXMsqgQgDCQ+Uo0oipJJTL5q1sYBLKssTTqUZLs7aKD2lcmwmNV+BMAZe1QhKrTespsnwKvfneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB5870.namprd11.prod.outlook.com (2603:10b6:303:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 01:40:05 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 01:40:05 +0000
Message-ID: <a27fbd35-aab5-4c48-9820-76832f706257@intel.com>
Date: Mon, 21 Jul 2025 18:40:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Oleg Nesterov <oleg@redhat.com>, "Chang S .
 Bae" <chang.seok.bae@intel.com>, Brian Gerst <brgerst@gmail.com>, "Eric
 Biggers" <ebiggers@google.com>, Kees Cook <kees@kernel.org>, Chao Gao
	<chao.gao@intel.com>, Fushuai Wang <wangfushuai@baidu.com>,
	<linux-kernel@vger.kernel.org>
References: <20250721215302.3562784-1-sohil.mehta@intel.com>
 <20250721215302.3562784-2-sohil.mehta@intel.com>
 <c1f9b3e1-b447-4c9e-956b-34b174203374@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <c1f9b3e1-b447-4c9e-956b-34b174203374@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdd63ee-2e2e-4aaa-e744-08ddc8c0af02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUw1cHpQZld5VTdjR1ZPdnhpNGpBUVZKMGN5dHBWeFdJampwVE1nZ3MzOWk1?=
 =?utf-8?B?czF4QmxVVFMyVUhUcHlBcDdFL1RtdXhrTExFMU94RWlhOUgxS0RHNTNiOERx?=
 =?utf-8?B?VE5lMWRwR1QxTklaRDU0a3d1bHVJZ0svMk1aV05Ocmx3dTRGNHVKaGYrT2Zo?=
 =?utf-8?B?UDlUWGlKTWR1WXZyOThrWjVaci95VmFxVlBUSTMwZ3NCdTVhS3FmckVPSlF6?=
 =?utf-8?B?K2NkSjlodkxLbCtYVHdCaWlFNEh6QWowWFZQTmRjOFpXRFBEcFhGQlBiRFdm?=
 =?utf-8?B?eVhkb3h3eE5GVktYaDgxOFlCeXhXQkt0UUtvRjlyazN2NkwxakxLRlZYYjBL?=
 =?utf-8?B?VHFWaHd1c2N5clZNYmwyVzNuNkloNlB6ODVFdEk1bG0vVUErdlpkTUxRR1Va?=
 =?utf-8?B?WCtXZWIxdzlIOUY4bWhKY3drYnRNSG5LbFFUeitycEcrQXBqUERQS0xFZEw0?=
 =?utf-8?B?NWxRSFIzczNEYktrWnJqK2RNYjR2dU9Kb0I2b3RKVzBuUUNWQnB5T2pYaDJS?=
 =?utf-8?B?eGJjeFY3RGl0bytOU0ppdGVUT3BlWXhrVTVPTk5VeEdEUUZYZFJ0T3o1OFNz?=
 =?utf-8?B?ak5jZG9sM1VvdUV5QWdhQXAwZVd4WE9nOFBVWUNrUmU3ZkgvdStud3dsQ2Zk?=
 =?utf-8?B?dTFNSVRLMWJZWkZKOFBma0tyNWhKWHJ5Z2VsdHkvRzRveW9vdDRRWm1wbWsx?=
 =?utf-8?B?Z1dGVzlXRWp3VzU2ZU55WElWTEpwMUxKT0FyOXFVcCsxVlRJZ3RRc01OM2ZB?=
 =?utf-8?B?ZTBkNGNuSEtzRCtzSnhvV2NTSFRsN2IwcUQ2VzAvaUhDNWJoaXgvTjVmYklh?=
 =?utf-8?B?djkreXhXMlhwZ2l5QVNZMUs0RTd6d3FaT1lsWVl1OVRTaHdtTlBJVk8za2Jn?=
 =?utf-8?B?NzRNNjdtWTJhV2hwS01lQ2tGT3FRYzVpYzkydVFxTm9OUGdyaGpQQWZXMjFn?=
 =?utf-8?B?V1gvT0ZsQXM0YTJYS1lQbEk2NllKUVMvbmovTjdaNVRtYlorNGJhb04vbFpK?=
 =?utf-8?B?eHpNVit1WjBQL0pZdWlYQXJhZXhJTXRjcEw1MUJGb01hTytCdXpsY0p6eVhl?=
 =?utf-8?B?SzRHWnc1RWFucDdxT05JNTFiS3hGQkdjTWV4QVBzNGhjQXpnUkdCYlhscXJy?=
 =?utf-8?B?QUZMSzFlL3lnNldhWno1SUpndStwYVE3Zzd4WUFpeHlBNHdSRERlU002OTIz?=
 =?utf-8?B?ekZWUkFPMW9YYjRuUWJqbDFMdEVITEJ4WGV2dERpSnBES2NiYVZ1QTk0TGJR?=
 =?utf-8?B?dGh1UW45d2didnZKVXpVNjJUK2ZmdzliVDk5c1ZDS2NoVnRXdE5jTjVqYnJx?=
 =?utf-8?B?czZCV0RrNGgxT1ZyTmVycXpWaVFxZ3JMMlBGOXZuZ2dzOXBVS0wzTmFNeGd0?=
 =?utf-8?B?TTlVemMzbmFLb1MwZGlwYk9jS3VpSStiMncrV1dsSUE3ZFhXWWV2OEZuNGl1?=
 =?utf-8?B?SnhkcnozOVhjV1dSdFRva01TYXh3K3Y5clcvVlNnR0J1aUovcHhYdURPa2NQ?=
 =?utf-8?B?ZjV5V0RzNlVDTFVEcU5FbjFzNjZBTmhyYk5DT3JNY04xWG9HRlA5MDJvaVFJ?=
 =?utf-8?B?TGQ5UkpuU0tHL29lSk1JeVZvWmw1RGlwZVByQVBWaTNUVm9qZmV3SzNLSTlj?=
 =?utf-8?B?Q3lpVnFkOXdpSzgyeVRGTk1zVWFOdDB3U1ZZWUtEWkozSnlHeXJ5a3R1NXJ5?=
 =?utf-8?B?am5UZGdwNXVHUVJoQlBaMEh4aDlHbXRSemJnOFk0c0k3OE1tRDJWZnRIaWJB?=
 =?utf-8?B?MkFlOGZPOG9BTnVQWUxKelZwN0xQTUg0cVQ2ZmRKWGpxbmFUMzBkb3RGVWds?=
 =?utf-8?B?VnJjNjNnRHdZeHJrNkZKSjh0YUtwbk5McHpSVnEvekEzZ3RJYVBUQmU2RUxD?=
 =?utf-8?B?MmtmcDQrc3g0RGJKK3VrNDRUYnZCM3NLOWo2alFnTEhhMzRndFlEOXNQZDhs?=
 =?utf-8?Q?OYjngftPceA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFI1NVVGTmQ3Qi9QeXRCLzJCY3BuTTlSMXRvNkJ2Nkw3SXMxSG5MTHpZV0JE?=
 =?utf-8?B?QTVnV3hpVHVUKzhHMzQ1TnhrK1BZSmhFQmdWVlhPSm9jVmJ4M3pQYWRaeEMx?=
 =?utf-8?B?bGNSeEg5M0ZFM2NYaCtkcTAyUHpRV2tiZFU0WWQwTmpyaHdMVU1QN1hxSXJW?=
 =?utf-8?B?V3hkMWhYSUVnU3Q3a3BMRS9qQ3F2eE9SVVNkd21iNVh4ZDZPOTVnL0FHY0FB?=
 =?utf-8?B?TmV4S2ZwSFZlcVNvSitrelVDMHJXVXEzaUhIRmNaWUVudlkwSVcxSm94c25o?=
 =?utf-8?B?VW9TZFVENDQvYVdvOWMyQlFxcS9hbzZDQ2ZYQ0kxYXZ6UENNWGg2OHNHRDc3?=
 =?utf-8?B?YzBZWk9aTjdpSExzWkRWYXpKWXhvK3NPY0M4QUhCb1M3VUtrdW8yaERrbHU2?=
 =?utf-8?B?QjBHa1pSYWtCeUFkWUxLZnJYQ2dBVDFtaVNjTFdnTE1qOThOZFRHQVRoS1FE?=
 =?utf-8?B?Z29mVkExRlM0ZG82amhxSFdVaEVmOXg1WDlCcDRpLzQrY1RLT0Z4M1BIdmFB?=
 =?utf-8?B?cWdUblJDTU9IL2tXanVqMjI0eWJnY1FjSW5hVkd1c1JQMVBnOFZOLytqb21U?=
 =?utf-8?B?Tll3SWZNWHVNeXFSaXg4YmdqRlVaMVM1QlhGQWlpcnhVK3JSMSsvZHBjbGVo?=
 =?utf-8?B?Zk5UZXQxTURVc0lkRk1Pa0pQUllXemtORlFaWHM0TWJzMmhhYjZUNHBuMDhT?=
 =?utf-8?B?dURySENIWWp5eUltaTJqOE1QNEdKcHN4dk8rSjJzcDJhWjVncFFpOW9aUFRJ?=
 =?utf-8?B?dnBnSld4bHlvc2c2VEE5Qk1EaFFxZ0lMYnJXTjlyeWh0dUcwRjcyNmFwc2ds?=
 =?utf-8?B?M0JnUWVBNXVvRDN6MjV6cUc1aXdDTGdvQjVWZnQ2eVhLclBVRERFME5kOVhs?=
 =?utf-8?B?VUZnSm5DZ29IcGczOWNVV3E2czIxeVQrTEU0L2dhQlkvMkMrNTU2aUdNZEVP?=
 =?utf-8?B?ZTRYVjNXb3luckxmQWREVTBKeXdJT3VWa0xpK1lZMmtFeGNUY1RwRUFBUm5r?=
 =?utf-8?B?MEZkNDlXSnQ2a1U2bmg1bWROTjkvejF4bXl1azRyeDBDa3B5dGhiQjhEZk9G?=
 =?utf-8?B?UGtyWFg1dDJsSVpQV2pHYmVCQjRYMCs5SXpoU3dPZjk5WlZrRHZOMnBRNEJ0?=
 =?utf-8?B?ZUJYWEhqczNSeFRiV3pXZG9FZHpxbnVZVEJvSzY4VDlTTlpnMlEzY2ZKc0pD?=
 =?utf-8?B?d0ZTeGVPaEduNExrUTZ2eFk0MWNJc281c3NtaVpzd3BreHpMYlYzblVDaU1V?=
 =?utf-8?B?TkR2T1lzOE5hNjl1WEphaTFralRvcU9iUDl3Z0Q4ekRNS1VTQ2NGRDY2b1NE?=
 =?utf-8?B?WVZTSU5oL0t0Y29zclBydzZCQWhDSk80SnJKeHZTWVRRNUd4U29UQytmNlFa?=
 =?utf-8?B?UDRrdXlFR2ttejRYTjZmNGNBUERUVHpzNzloTUZjdndZOXc4cUUwWkJ0amI5?=
 =?utf-8?B?VjBMZm5vTmVyQmJmRkZyWVVvc3lZRVE5TVZ4OWJHaDk5c2xHQXBOOUdDWWk1?=
 =?utf-8?B?blcrTVhZemxnUG9Bei9lU2tpb3NTL0VGbndMbmg2RDA2RTZrWXZucTlEOEZ1?=
 =?utf-8?B?MUtSNjNqRVpmMjNXMTNRQ3BpNUlES2RGNE1tZ1BOaVV6UWo4aDEyVFhCOHkw?=
 =?utf-8?B?ZklLY2YrdVJSd3VvclVVSzZzeWlMQmdyZU03TFl6c2s0YzdjMXlwVmRlMjla?=
 =?utf-8?B?d0pvcnorVTFxTGpGYVhjZDZtc3NzU2dMa0lCOE8vWWdDeGttYXpPSjF4d3FF?=
 =?utf-8?B?ek4xNXF0RWZNMkpXbWN5R1ZCVXNaaGpLQXlSRTR0V3RYRkNxd2I5cExnSTcw?=
 =?utf-8?B?cnhPL0swMkpxSitKTWNxY1A1NUV2eUYzWFQwWFh5WFp5U3M1MWhsZEp1am9w?=
 =?utf-8?B?VTEyaUhTZURPM1d4c05weE9GUElnVnVDb2dMckpQSXljdDZqNTM1WG1MZ081?=
 =?utf-8?B?MGp5cERQSkxKOWxuUGpvV3RVNGxKbzh5TDFic3Fjc1A0Z0ZpcE5VY3FidGp4?=
 =?utf-8?B?ZzRnSENqdzRwczFpOFNHdEpRVjdUUitaQVJvWWNzb2trY1dtaVJYY3NMYUlL?=
 =?utf-8?B?Q21Pend0K1ZQbHB3RTZ1OWdzRTBHb2JyMmo4OXFqSEh4OFBCTzh2NWN3cVlL?=
 =?utf-8?Q?Hmr37/3SiYUpr6WAwH1E4VV5s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdd63ee-2e2e-4aaa-e744-08ddc8c0af02
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 01:40:05.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NnB4JVuObY60N+JA699KSWZalr8iV6APqNB2WCKXAI3nWi/9TpHS7AgQBmmYb3lo65plgHaiPHxuhsfIc/Tfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5870
X-OriginatorOrg: intel.com

On 7/21/2025 3:34 PM, Dave Hansen wrote:
> On 7/21/25 14:53, Sohil Mehta wrote:
>> Also, update the warning to include PF_USER_WORKER, as these tasks are
>> treated the same as kernel threads in the FPU context.
> 
> How so?

There are quite a few checks that special case PF_KTHREAD along with
PF_USER_WORKER. For example, FPSTATE allocation and freeing as well as
some context switch paths. Did I misinterpret something?

I believe it originates here:
https://lore.kernel.org/all/560c844c-f128-555b-40c6-31baff27537f@kernel.dk/

switch_fpu():
	if (!test_tsk_thread_flag(old, TIF_NEED_FPU_LOAD) &&
	    cpu_feature_enabled(X86_FEATURE_FPU) &&
	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
		struct fpu *old_fpu = x86_task_fpu(old);


arch_release_task_struct():
	if (fpu_state_size_dynamic() && !(tsk->flags & (PF_KTHREAD |
PF_USER_WORKER)))
		fpstate_free(x86_task_fpu(tsk));


fpregs_restore_userregs():
if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
	return;

kernel_fpu_begin_mask():
	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
		set_thread_flag(TIF_NEED_FPU_LOAD);
		save_fpregs_to_fpstate(x86_task_fpu(current));
	}








