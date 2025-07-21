Return-Path: <linux-kernel+bounces-739222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F740B0C386
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68444188FEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706BD2D3A8A;
	Mon, 21 Jul 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRiVkRG6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB82BD5BC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098163; cv=fail; b=VyKqaQl+00wCu0uY3X0k+W02dsoX9iE1JOWyNCSjMwyixNhmRrFY0/4jXQX7vS/sB2+eqZtQdaRotyco4rEMp553P4V4prMDeS6sRZYD+yQsvnduEoBbq8BA5X4/k6yvoIncUVJU+IZ3xFrV+eq5yr8HS06Ur8kyxpyg4U1Jzak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098163; c=relaxed/simple;
	bh=XgQxo0C1SIfX7WpV/pYmPiD9ZRPpO3SioytBMZywRDc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PTQpKVwVriZ3omRVD4pgK7BnvJ8ZM0afihFaY6pUMadu+LppqsxJyAFq/jEPsQQW51Z5FEF7EZ78uZly9eRyN9PGdPAPNo2lC/BJZwnPZw547srl/GLc0a3nmhCkUreqzvmS4C0BhjH/jeTxXcOftTdc+M5/XsVKS5wtidMjq/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRiVkRG6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753098162; x=1784634162;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XgQxo0C1SIfX7WpV/pYmPiD9ZRPpO3SioytBMZywRDc=;
  b=VRiVkRG6zrk8DMvQgL5FAStdecp605rfQyGzrMBBxQ8gc0UauBJIfW8f
   zWghMy/tfuKxd93pMvmnGYAe1MFy8VtEm8eQfZ3M9IybE1lXDran2GOPR
   M/t+JfR8eA04fp8qSICu1AwN8j6a6OwDJEvwbxoWBHDHO6DCEqu1e3IBQ
   oiPp0ARsuaz996BthC/nitgsbWyxN38AzrDpHlgTGnmz88Vor28gtkuUR
   LVjjI9RYXhYTZwav1a00rFKly1fYgdk9nLZC4JG+jtGTJbhhHKyhaaw/q
   V3zsz0dljbOzX7yCHPk7/5IUpQG3PSJflTGrTjmX46x8YMmaegyA2IINo
   w==;
X-CSE-ConnectionGUID: zpTMA8DmQn+2I2wS3e3ViA==
X-CSE-MsgGUID: sKlgN68LTk2L02efSX90lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="66000233"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="66000233"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:42:41 -0700
X-CSE-ConnectionGUID: W30WRjEsRBOBR+E9WQfTUA==
X-CSE-MsgGUID: 3BBQ3fOuTymhCo/06qyfEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="159159065"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:42:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 04:42:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 04:42:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 04:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6H9LoPiJkeum7q9AjbHGwCNy+oEI77TV63MJWuxdQ7/3aE8Adg69O6InRLLJQS5vkyOtFw0QKu53b5Krd504SEra53n1FErlidIewk619Alx5CNyx0bsMiqwFvT9jHcq7pf4AHTgvH51rH45IlpsiEzKvC+hJTRw/F9eQAq5DYOtofFf6j6KqHzekUnywwA5xktpcSUTIyeYqXDBQdyoIRCxGuYREG1I96iOOVA9oO7dp+C76/uGzC0+dOgx1j0uScaBvjZva41ueKqVGbqTqpYa99L/3pNBcvg85f6PeJ8T/svjOlYXi/xkapXFR2SgFSZMD1YzuRTtknCyAAoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMK7c/7qCh4sA0pBf2lPJEXloLMW0blmQF/tgOdh0oM=;
 b=yJt7bnzl3NrB2LI5H/QrCSYcIWKtDoND+q4BuQ4yOmSJRPd7DvSKoCOhCqnpjbSqmM5/SBnYHIntRHU2yuMuTrewtk68Trh3UVjmz9TxrPRljUijl3x2CgIdanIurUoNQ2mTtvwx9W6ipi89Ynov/Erc50XUJ+j3+87LU2Otl70hYncxggGL0l9vzGTfcEYLy1alEQxcMagMzotVluAmS8dLZ1JaAsiaUWa/qgYhV01u78fRlc6RJpfktZysXxogRbB+ajquV5YnoPYbTl2YoFQSsaUhx2R2FcUECQWtkPYA+77adsN3lMD0SVcUwMP9Zgf/Ka4EzBD/5yjJp1dIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by CO1PR11MB5027.namprd11.prod.outlook.com (2603:10b6:303:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 11:42:32 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::5461:fa8c:58b8:e10d]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::5461:fa8c:58b8:e10d%3]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 11:42:32 +0000
Date: Mon, 21 Jul 2025 13:42:01 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: Matthew Brost <matthew.brost@intel.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Karol Herbst
	<kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
	<dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, "Barry
 Song" <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Alistair Popple
	<apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
Message-ID: <aH4nibzGVLiPE5-4@fdugast-desk>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
 <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
Organization: Intel Corporation
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|CO1PR11MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 545121fe-70c4-4e77-22f5-08ddc84badd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eURoSnZKOXA2d1hjbTJEUjNjQ1QvdTU5UnBydFlGS1RpSS9hdzhQaSs1YlhH?=
 =?utf-8?B?U3NrckNwVytOUGpIalhhRmc0eDEyS3NSa0JmS1dHRmkrRnpCL2ZRRC9YUFM1?=
 =?utf-8?B?V2VBVDVsVk1mRlV0ZjAzam5XcDJGT1RPUzFsd0tjcFNndDY5YjgveEVJaGps?=
 =?utf-8?B?NkcyNUE5Nm91cm0vNTFqc1U2dERkUHVWYVVxSjhpaFRtZ0dIMGVxRXFVeFAr?=
 =?utf-8?B?RG80R050VlpVbXZ6Qyt3a3haU1NoQkw1SEZaQ2RHRysvOE8rVkxDNmc5dlg5?=
 =?utf-8?B?Kzhrd2lUN3JjMXlaTDQ5U25BLzl1OEdGT2xJZGR4VjhxMkFPekhTdGduNFF1?=
 =?utf-8?B?VS9TQTYreUZ0eFE1cUlmc0s1akNCOUM4cmpiaFd3aW1FRWZnSWlmZnlRMzdY?=
 =?utf-8?B?SDhRdXAyajRIalRNakNsOHVRQitxeS8yaTVuaHhWdzdneldqRWdwMFptVDh3?=
 =?utf-8?B?bVc1VnZUUFFET05ZYVFhN3JSNG5ESnRaMWgyNHVWVlZMdnVWVDYzSTZSSzhB?=
 =?utf-8?B?cHg4Y0ZiUVZ6WmFPZHk3R1RvK3BDNUF1c2FEZU1rN1FPbHMxWnVEbTBWN0tT?=
 =?utf-8?B?YWszdGZKbUNiTE1GazQ4WHFNSjJxWmFxd0RDL2RYUWtWL0piQ0dTczdiK3dL?=
 =?utf-8?B?QXQvYWc4TGd3VFpkYmtFUkFleUdkc1lUQWJTaWNQaWgwOFpvYkp5ZG4rMTRy?=
 =?utf-8?B?UlAxQWVmeWhHRVY1R3pYQkN5NWxHYlQ1bzlNZjlRelZocVl1OFVpUDRlYkla?=
 =?utf-8?B?R2dQTVdhdDBSTTE2bVBiVXVKbWtNYktCU2RmV0U0aGtvYkhpUHhjV0Y3dGwy?=
 =?utf-8?B?Z1NhZ1hralZ0aElSZWZnRjhvWW9DY3hYa3JpOTFQTzNKaXhNbDJNSkdIOHRM?=
 =?utf-8?B?QjJiTWdING1vemJmQXhvS2VSMS80UjBPMWtKY2Z1ZmtuVmExcGRCcWNsREtG?=
 =?utf-8?B?V2oyTFFsdzdMUmlNc1g1Sm5jNWJYOVYrM0lwdHJJWnQwdDJYUWdTUHp4S2hJ?=
 =?utf-8?B?NXBWTTBScVJrdnkxRERCZjE4Z2wxMDRVaks1RVZPYWcxTEhZZXBZR0V1VTl0?=
 =?utf-8?B?eUxQTlowY1dROGZxaW1rOTFkQUwxaHdPWkg4aFVTNmpPK2lWUHJoWFFkOHQy?=
 =?utf-8?B?QnVJWTBMRWFWcmdXNWdRZ0VsV3RkZnVvRElETS9yQzRnSm5ZdURTT2JnYWFs?=
 =?utf-8?B?emV1R1NDSXZ6dG8wK2Uxbm0yTWdacmhZb0NRRk1SR1hEWklubkFsWXd3MFRH?=
 =?utf-8?B?WUJYb1puZFBPaEJUdVQwZ3dGQ3g1ZUtPVWJRYnUrNHR6cG1SeGxNS3RFcXUw?=
 =?utf-8?B?L2Q4RUE3WnczYmNvRy95aHJ6M3J2Q1ZOQ21KRTNxc3lyUjVFRi93aDc3cEpV?=
 =?utf-8?B?QXhCL3pOcUJiQVh0alZ3b3ViM2U2OWNXd3VFWVR6L3hpREFwMTFpUGM1VEd5?=
 =?utf-8?B?TXJBbXJRTmhqQklleXV0TlJMU0hvYWR3T1RrSDlrMzRPamRnZXFPYmkya3Vr?=
 =?utf-8?B?U3gwbUw1VFgrQUhUNEU0aTJpZ0oxYnlNK3oyazJtTUtWdG1HTm9mOUhwTDJ1?=
 =?utf-8?B?TFBkd0FjUEFGaHFmRCtXalhHK3lYQnVFUlpRUEFkNUoyMXVUakx2Q1RVRWgy?=
 =?utf-8?B?dGthSk9mRUlEUE9nOVVwVlNacC9sVE1hVjVDQy9MODNBZkRiMXl2ZjY2dU1L?=
 =?utf-8?B?MUgvdlNGb1FnNWFyaWNSbWovSkVIUWxNNUhWUWtDbTdYa0ViUHNuMXFkL25u?=
 =?utf-8?B?cGpEL3ZrR3habHBFRGVnQ01uVHFRRko2aTQ3eUJieHR6cDlPc3J2RXUwZDRa?=
 =?utf-8?B?QzFnSU52OVAvK3ZmK0ppM0ZxaWZyMWpGRnNUdVB0OXdVT24vOGhLZGNTYXEw?=
 =?utf-8?B?dzhGajBnckh4UlNmcUNpWENUTkVlN2FNNzlPQmttZ0xjbXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7828.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZmMUpCWnRYeFFvK3duM2I3VGZGaEQrWk5qejYvV3ZYcFF2MVRvR0luWS9s?=
 =?utf-8?B?bnhWUjE4bHlHVGlYS3kxVEFnUzI1UHhtSGpuKzBLajRnVFErZUpJcEFVVHl0?=
 =?utf-8?B?R3Vlbm5naG1uSi9Bbi9iVmxhWkFrdWFTZTlQd3VtREM3cDBKQ1FFMXRwRlIy?=
 =?utf-8?B?dlowR29DV1dCS0ROOTFpdjNmcnhMM0U5b1BnUVltV3JKbEhEVWVINW9PZEY2?=
 =?utf-8?B?dWFMb1JjTXIxZjlxVUYzQWV2TnN4eWxiZjJSaFBQVU5TVlNDRmY2YlJURFhj?=
 =?utf-8?B?dGlDeVNqN1ZLZ1pPcGZMaUtPcWZVbUZZQUxxcmpiR2dQVFNGb1BNcUg2WTRK?=
 =?utf-8?B?cXM2emJCRjlkMnlHdC9pZXNKcUxzSkJ5NExKRGNCSWUwZExJTjljWmpIaXV6?=
 =?utf-8?B?dGpqRTRoeHhjdVN6eFUyQ0FrVHN5UkU2VEtncUJtOXFDYndiR2E5QnRDY3dO?=
 =?utf-8?B?RUlLN0EycCtEb3l1UzlnNzg4QWI4OFpCeUx0dUJwbzRuaXpEQzczWHlBL1JV?=
 =?utf-8?B?YTR0UkNiSWVSVDRYa2h3UEhmTEx5WStWWHFnWUF0QkI1bGN2V1pEY3ovcEx2?=
 =?utf-8?B?cnZrZGIvbWg1cklMbDdxVGVuUms4NEJUL0NnS1pXb1hNajFyWUNEYnVaQUp2?=
 =?utf-8?B?WDF1S29nMGNZTXlsb2x6U0Fob0RzbTd1NUFZM2Z5a0libURGRkY5a1lXM2VY?=
 =?utf-8?B?eFRSbjQ5WUJiRWNmUTZtRWIzV1VUWEpmYnpwTCtDUTdMdHhUUW5vbHN1U1Fr?=
 =?utf-8?B?Zmg4U3dKSy92ckNoeHVPdUZIN3MwQU4ySjV4bW80cUNXZm95S0IyUWQrSmFy?=
 =?utf-8?B?VWFUU0E0VmtrNW1aTU1mZEJJUjRVcWJ4alZxZ200MENZblE4aUJtVkwyQWZ2?=
 =?utf-8?B?dTVseFJ6eGQ0WURZZDdXbEgyaTNma053TVVZb3ZqYU4xRnpRSUxHdXlHTmUx?=
 =?utf-8?B?SzRMNUZXYmZkU3kvNjNyUGFRUEd2ZlVZdlpYbFdqRnduM1Zlcnp1WXVRdko2?=
 =?utf-8?B?ZGtzTHFQTkIvN1VLOS9jVlpWUVJWN3BOVy8zTWpITFRCOG9nQXhzU0dPUnN0?=
 =?utf-8?B?c3M4NzFkbm1wdyt3STBobnkyT0xsWkY0R3hFQ1JjaXpCeUZUM1RFaVRXOWwz?=
 =?utf-8?B?ck03eHpUU1lZK1VMbkF4Z2dJYmt1VG55cThOOFVyQklDNEUwcy8wbzAvZVlJ?=
 =?utf-8?B?MjJ4YTRhdUZzbmhLK1lnRFhaNW0wSkJCS1BCQVV3Q3E1SFdhL21PR0tNL2VZ?=
 =?utf-8?B?ZFAySytjY1JXUEJCTW9DSG1ISHZjQzVvM2ZQSkVRUlhJbUVvNmRNMjRickVL?=
 =?utf-8?B?eUsyc21yVmc1bTBBbGo4VzNQNWhVVnJIVzVDVU1uNDZtWnBRSjZXVnZJbTFo?=
 =?utf-8?B?akVWV3d2aGdnOWxnbkNDVzBvTEdBN0Z1bVg2ZmNsREh6SHVGeFZDZmNjZ0NU?=
 =?utf-8?B?Z0g5blpxODQ0VU1XWFJ1Z2FtT3VaL3JNeSthdjJmQkRKRC9MNW5RTm1rK2pk?=
 =?utf-8?B?SUsyUGhQNjE5UmNtQkNKb1Rtd1RmYUYzT2pQNWpueFBOVTFKYStpdHhGeVZV?=
 =?utf-8?B?NThVMTVHc3FqK0p1RFJQOTVwbEc2cHJOVXpWZEN5Wjd0Rlh2ZlAxbGFUQ0Zi?=
 =?utf-8?B?QUVLQVhlM3VsMFVENlNFRjBHaGlaZXA5ZUgwSmI4Z0srRk9zZWtvNmRweTdx?=
 =?utf-8?B?RUZFZnhvRDkvSUZPV1d3Wld6dVBzTDluYXVpMDZzWXUxSm1Nb1plZ2JrMHdk?=
 =?utf-8?B?a2hhZ2pmdzNjY0dkQWN1cURLTlJ1VytNbzRuVDhLMHNNQU9ZUm9wTDRsd0lH?=
 =?utf-8?B?UHYvVm1MTm9ob2hKNDVmWVpaWTFKUTRIMXorbWRkS01mTlMvTURNQ3QxZDA5?=
 =?utf-8?B?M2RZYytHakVOVmZBL1BYbkdndlhJcmJJVEI3alUydFVqVUxHMnVDYTNLazQ4?=
 =?utf-8?B?SUhtZmF4dlJNUGNmdUVLbFEzVkUxM011NVdSbGdyb3dTbU9Jcm1DUmJ1WCtF?=
 =?utf-8?B?WWdCWXNLcm9IQSttSzZvZS9TdkdzdUZCdzlUSmdVajY2a1lGckNpckp4MFFY?=
 =?utf-8?B?NWpERmludXByU1RORG1BWjh4YzZSWVJ3NmlRU3VXa1F5RjFFcmhhaU0xcllh?=
 =?utf-8?B?WGIyUjFyZmsvOEJ4K2NrUEZ0YU5JQWNGdzc0RmlFQ28wZzZ3Q0IvUjc3djBV?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 545121fe-70c4-4e77-22f5-08ddc84badd3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:42:32.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRDq8V8i1IyjcdAoakWDmk0xOaTilI9bwkhTXAzKzGgr6MPA8CPbfuF/+4B8vAsIdMWEP2q/e6PinpVleoWRc5KG8KLEqgi6sqcxfcfKwXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5027
X-OriginatorOrg: intel.com

On Fri, Jul 18, 2025 at 01:57:13PM +1000, Balbir Singh wrote:
> On 7/18/25 09:40, Matthew Brost wrote:
> > On Fri, Jul 04, 2025 at 09:34:59AM +1000, Balbir Singh wrote:
> ...
> >>
> >> The nouveau dmem code has been enhanced to use the new THP migration
> >> capability.
> >>
> >> Feedback from the RFC [2]:
> >>
> > 
> > Thanks for the patches, results look very promising. I wanted to give
> > some quick feedback:
> > 
> 
> Are you seeing improvements with the patchset?
> 
> > - You appear to have missed updating hmm_range_fault, specifically
> > hmm_vma_handle_pmd, to check for device-private entries and populate the
> > HMM PFNs accordingly. My colleague François has a fix for this if you're
> > interested.
> > 
> 
> Sure, please feel free to post them. 

Hi Balbir,

It seems we are missing this special handling in in hmm_vma_walk_pmd():

diff --git a/mm/hmm.c b/mm/hmm.c
index f2415b4b2cdd..449025f72b2f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -355,6 +355,27 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
        }
 
        if (!pmd_present(pmd)) {
+               swp_entry_t entry = pmd_to_swp_entry(pmd);
+
+               /*
+                * Don't fault in device private pages owned by the caller,
+                * just report the PFNs.
+                */
+               if (is_device_private_entry(entry) &&
+                   pfn_swap_entry_folio(entry)->pgmap->owner ==
+                   range->dev_private_owner) {
+                       unsigned long cpu_flags = pmd_to_hmm_pfn_flags(range, pmd);
+                       unsigned long pfn = swp_offset_pfn(entry);
+                       unsigned long i;
+
+                       for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+                               hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
+                               hmm_pfns[i] |= pfn | cpu_flags;
+                       }
+
+                       return 0;
+               }
+
                if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
                        return -EFAULT;
                return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);

Francois

> 
> > - I believe copy_huge_pmd also needs to be updated to avoid installing a
> > migration entry if the swap entry is device-private. I don't have an
> > exact fix yet due to my limited experience with core MM. The test case
> > that triggers this is fairly simple: fault in a 2MB device page on the
> > GPU, then fork a process that reads the page — the kernel crashes in
> > this scenario.
> > 
> 
> I'd be happy to look at any traces you have or post any fixes you have
> 
> Thanks for the feedback
> Balbir Singh
> 

