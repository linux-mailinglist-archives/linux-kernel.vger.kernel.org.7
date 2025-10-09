Return-Path: <linux-kernel+bounces-847350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E811BCA97E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28CF24FB73C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970C248F75;
	Thu,  9 Oct 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNSpNVf7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2E1BFE00
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035208; cv=fail; b=YhgToXJYEU0CIkyKg7zL0bh9Wxd9p95VSztV7fpuqUTy9UoLFKoKjmAzIWOUYzy8pioT/U9NKavfxiyxm6g/219sMR02ZzmmH8oUyLXI2NXCuheTAukDVZu99pZ2INUqkGkgdCd5SQYYn4GAOh+O1yd5ywSuOXIxKKLkLcyoDDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035208; c=relaxed/simple;
	bh=G3x2ZhSuTN43OO7LvXVegfrepEBtJcu/poo2zrdQqB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NAcNjdvEbLbN0Id3034JkAz/eV22cW4oza5GxjOtnJoUkBvspD+bbzR4pllPxcO6Du3ZYQ3eL+LqSI34+1xdZsHOsTzaIkGQTtWR1nflTSUDkYpk491gE49POF1RaPtsiBQ9BGyq2aNZyT/KHc+ffksVC8oEQPfM1dQ9+LcjsKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNSpNVf7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760035207; x=1791571207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G3x2ZhSuTN43OO7LvXVegfrepEBtJcu/poo2zrdQqB8=;
  b=DNSpNVf7vuK5KBf28LlfA4wB8UtIhFLYMhGXOgLlhdaKFOCMo9GhsSKV
   m7cymkW2nL8leI/mRh7u62IQYKrolWWOWioCRAz98tuCXfguOakdourdi
   YZKqMb63lP6wIG45JswPSknEixdWdzxTD+6dIX1QNcwaYyhA1B5feqt5Y
   fhLlbsLLsBYBcOOqqneurjbsRR+m2WMBzS44sxAlqlL8DdQ1lfMbplw+m
   m90dfkIlv8EgeC6W6xeWMGs1PufN4jzC7UETT93098Duf/fjGsDUNSWG4
   nSea/8ev3DQ6uNs+KfZqnrbNDKibjVGrt2iOv8mz/lOWLld8YLxVWNrNl
   w==;
X-CSE-ConnectionGUID: 7Nt87fDzRR6bV5sMylGq7g==
X-CSE-MsgGUID: AEz9o+JsQ3ey6L0x2T+YfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73686655"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="73686655"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 11:40:04 -0700
X-CSE-ConnectionGUID: 7KWN6epnRyCoXYU1+lUw7g==
X-CSE-MsgGUID: Hdp356XWRyeRfZsVdcQiaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="204488860"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 11:40:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 11:40:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 11:40:03 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 11:40:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRIk4rbXxBPz0Z19lIbP2jpZPCY5amUOVKcAcv5HD7YtklutyNCtJtAbHoXxxbyt3qHfYlGJYIsKg5ROV9a+GxXF5bvrYoOK2JhIDsLhMHJTZ6INuqDLkWftAmdBCWkVBAHvfRqpuLP8JrONCbzSRod1hsQOV097LpdTmyo26INJOaW8UzAPYviGvzuoU2OGTWfvjRGYP8tor/rMMEMyHyoH+2Jm/hH9lx+NzvWjhGkthK0sx0OE7VeCy/J1rq91E5Y28qRmSir6qXXnFT0AOkkIVUBmdJHmzrIKPluztCGkYYGE083jaVtsuZthl7uAFlmASWRaIeUTNrBeOEwgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3x2ZhSuTN43OO7LvXVegfrepEBtJcu/poo2zrdQqB8=;
 b=esozZYJdvqqLfdGYZlSIxCIQ73N3jL6nfI0hNW2vO+34HFwJB9y5RdbE9veyTQWE0e6+kMFUuNULw3Gp+Y3treFCBdv4ms94aicgChsTiujT3eMBOTW0T7KFJPJQWjgZQTuqxnsCnVZ98nfwT4Pp+S5M0Nwldx5bAzbWj9fszHvEpp0vkoKGQxqLiryeycfcTYeH0MZaW86DPsVAgnktqcCib6YezMkdIJsxpDsVtrwOf7KDyP8qYOSWpTHDiFR6fwS3tF/WJCo0RSpRjhn9o6HB7Vx5q0XBZEqgbbAa9dFipW8QCIhSWLO34cCkuUEPyy2HFfemoiUB8yJv+Q7HEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 18:39:58 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 18:39:58 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Babu Moger <bmoger@amd.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
	"Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peternewman@google.com" <peternewman@google.com>, "Eranian, Stephane"
	<eranian@google.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
Subject: RE: [PATCH v2] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
Thread-Topic: [PATCH v2] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
Thread-Index: AQHcOItq+o3tsyWFXkSU8sBx11ePxLS5D+mAgAEQQACAAAW7sA==
Date: Thu, 9 Oct 2025 18:39:58 +0000
Message-ID: <SJ1PR11MB6083BBB7FE524ADBE01C5DB6FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <2ead4ece804b0f61aab01f47385d9a125714991e.1759952394.git.babu.moger@amd.com>
 <78dcda7c-b3f2-4149-b6f8-3da695d83bdb@intel.com>
 <091e40de-716c-47e5-85eb-ee09a7d6ae50@amd.com>
In-Reply-To: <091e40de-716c-47e5-85eb-ee09a7d6ae50@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8255:EE_
x-ms-office365-filtering-correlation-id: 0aae9037-5254-46ef-dab4-08de07633fc7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?amlXd0JscHo1TFNCYVhPTkx3TGM2VFZFQk5KN0pvSUV1bzdSVk9aMFF1eDY1?=
 =?utf-8?B?SU01RnRoakgrTGdySmdCb09PMWREMUx6Zi9SWHhuU2l2US9ITUJjcHhOWTRJ?=
 =?utf-8?B?bnFXOW1yMnFhYkE0ZGpWWERPT2lOVnJ4S2IxTE13S1JybHY2L2lIeVRUN0lZ?=
 =?utf-8?B?bjFaK3RjQlFGaWhnOWNmMTN5N3N1SWZ2S3FvVTZIbFZ1LzMvbzJmS1JFRWZT?=
 =?utf-8?B?Z1NwNlRaZWV4RUtKNENBWFFzUUZndnI4VVl0YjVzSnBJQ1g5ZHptcWdrcGU0?=
 =?utf-8?B?cjY2M0lHSzJuakd2dkI2V0cybzMzWktVVElwSUY0VVIrN05ZcmJycnRYeml0?=
 =?utf-8?B?TXdCanV2ZW9STDFyNU43MTJmQUFXS1loZ2FqUlhmbTB5Y2NkUlFYUk1GOElr?=
 =?utf-8?B?b3F2bGt3SVpLN2dDYStmcVczYzZSTmo2dFpFeHYwMmJNQmI1QndTR1puTUR2?=
 =?utf-8?B?UnN1OUoxLzcvaTI2N2JJd1RKdFZRbFdkNDI0cmV2OU5DUkF2WnBkUmV5WEJk?=
 =?utf-8?B?RUliUVBpcGpUWEhVZWpKVFBWaHFIemhKR2dJb1JaOWhHWHNwd3lobVRFcktv?=
 =?utf-8?B?S3hzSlZGcEgzT3ZNc3JKcTZNZGF0R1h0RkxQZWd2K0ZIZjZxNVRPOXcycENL?=
 =?utf-8?B?eTljZWtidXhXMzhjMUd5ZDYrODMvVGNLTjFYYjlNRHl5ZDlxVk8wa1R1Qllm?=
 =?utf-8?B?Y2ViM1hQOUZUcmJuZTNBNkQrMFFOTE9kZDcySytxMmpjRzZiVGRDWFI3QkFk?=
 =?utf-8?B?bXlrc1VJdFg2MjMzZlFLVnZUQzltZ1RtK0M2SEpxYTd0bUxxZTBlR3RRczZj?=
 =?utf-8?B?bVoyUStJdTl4YjljaU5VZ2M1b3lqaTJuUitGZkJtd3BuYnVzS3BNUFY1Qit5?=
 =?utf-8?B?QzVHMXE3anhwTjMxQ3RkUXFhaU1vajFJbm9qY2w0aTluWTZLL3dra29BT2Jl?=
 =?utf-8?B?TzJ2RVczZjV5MEh4ZUlHYytMZkhzak5iYlZXL3dEdkttRmUvb2V1cnF4bjZm?=
 =?utf-8?B?TVhXT2dUYWJ3UjloWncxVHNHS3Nud29WS2ZXZHpmb0tYd3J6VWdOK3lSNDFB?=
 =?utf-8?B?aytiUnM0M2hVTzR6V2JCUHVxdlVEZUVtSm90RXQ5L3htOFo2dmJ4ZFJMWU1t?=
 =?utf-8?B?c2pKUHVwVkpmQis0WXdmNmwwNlJIVE1uTld4dFF6UWdodERta3lYSm9tR2lr?=
 =?utf-8?B?QjJVL2RtanRlNnhVQzB4ZGpKRkllWVhoczhicE56eDJyTUw1endVUVF3WTBn?=
 =?utf-8?B?Q2R2b0Y5M1RhcWRMT0xueUQ1dDFib3pBa3U4aDhuVmJjZjJVU1NYZ3pOOURs?=
 =?utf-8?B?aFVDUDBjTWZLT1B2OFhack1hamJjOE43emU0R2E4SVZUNHJTOGFqQldzRDl5?=
 =?utf-8?B?VnBKTS9NeUJXZzRTLzRJMkpJWE5FVk5uWTBZTUFrSXZlTk4vVjF1RmdKL3lL?=
 =?utf-8?B?Q2ZFK3VVbERmWmJWci85MlBDVVlkUTFWbG5iN2FiRWc2YXprR0RkR0JkZG1G?=
 =?utf-8?B?S2lVNU92UXlmRnhnOCszUzRXaFcyaDY2VzhES2xnYm1FdTRHUkNFYmUybkFu?=
 =?utf-8?B?ZE1rdVhVa2YxbVExY0RRY0NCclVocUhRK1ZUcGZjTUpKQ3pPaVVNVXZiVTNE?=
 =?utf-8?B?ZHNkQzJJZ3dUWU5JQmp6SWZLZHVyQlJEa3J2Zi9wTUZlTUNsNmdZdjFIWkJ1?=
 =?utf-8?B?NmV0M1A4S0ozQzR4R2ZPM1BzUHhQSTZOWHVJbHQ1Rk95MzZ4czFsYVFQVjZr?=
 =?utf-8?B?TVNJR2RwMEZZMUpGZ3lUanR1c3preXpZemh6K092MFBXMXM2ZHFlRFIwcC9v?=
 =?utf-8?B?WEJ1SjR1VHVlZXhvbWN0Z3FvK1ZCNUw5aE05dlhLOUhDVCtLM1p1THZ4dHBy?=
 =?utf-8?B?eExzZFo4VXVLNitqSkw2Z05NaDh5R2h6NFg3M21xWGhSVEw1Q1loNEJZNTll?=
 =?utf-8?B?aXRqa2lLYkVZL3J3b1pqOTdsa1pESHEySEtCbG0wZExCaXkvRkhFSGFXeElH?=
 =?utf-8?B?ZHZDdXI0alFXWmZiVDdTMXkxRUNJWjlRZ240eGc4TGxYNHpxajRGblN5WWZW?=
 =?utf-8?B?L29pbW1rakRqL2kvd0RGbGtWVEcwQ3Z0N1I0dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K29ta25SNjZ4UnVmVHBpRXI1UnNOY0wwekZVaVA4T3dNNXhqZTNLZkhLbDBR?=
 =?utf-8?B?dG52d0ZHTEt2d1M4cUhQU09WUXU3UFA3cGVEdnlWdDVEVDg2M09ScEdhRGo2?=
 =?utf-8?B?Vk5zSXNvNDVhWEhIM01odjlxRHhnRytLMlhKL1diR2tYMWxPcE1hSzdvU3dl?=
 =?utf-8?B?ZDJrOTZyaiswaEFwRHlnYWQwVmpGSGRPSFZtQ1JwNDRPZ0pLL05JZURaYmlK?=
 =?utf-8?B?a0VTN0wycDJkenBwVVhzTzFUMU1tV2FMYU5oUWlrRGxnZGluMzE4WnJWTGc5?=
 =?utf-8?B?cWprOTB2SUZiM0txTUFaakptTHY3SEVVVG8xUFg3TEJocXBmUlhiVnpXZEtk?=
 =?utf-8?B?VmFjNWxidXRmTm1vYmNhL2pBR3FHbWZ3Z2EyNnlBSzN3N1BXdTZSeUIrKzB1?=
 =?utf-8?B?VWdGcC9zV1pYa1RUcU9SZE50d0tmZWg2QUZFMElFSVpVUjZ4QzdoLzJZOWsy?=
 =?utf-8?B?UmpacWpMVDkxb29NMm8vSG93OUM2MzRNdFJDYlRUWXlvQWJ1NHgwS1dqemtL?=
 =?utf-8?B?VFdmbUdzN2hwUTB5UVh4MjlwRmtIeWFCZkhYV2cvNk96TUNuR0lBMDFjVmlR?=
 =?utf-8?B?V29ETFhXMEE2akc2QzN2UHZaM1ovRnNOaFFBRExWc08walhmNUtYb0lzRWN5?=
 =?utf-8?B?OVNvRWlOSitkdVlWc3FoU20xT284M1ZOczVBdzRKZWJmbktMNVJqQ1ZRQnBS?=
 =?utf-8?B?eWpTYVltc05WVjNwbDlrU2FNRDNnc1ZvUHlYUVpmL3Jsa0JEcFdXaDhPN1NC?=
 =?utf-8?B?MU9jamRBNUpvTzZ5dUFINmlLbHUwUFpmOWJkR0oybG1jOFRGNm80eThXeVhl?=
 =?utf-8?B?eDhHbmp6Tkl2NVh6K1QwYVpNZ0ZyRnYyS3ZJbEp6N3pSeWdBWU04czNTekJk?=
 =?utf-8?B?c203N09ldTlTZkNEVkdMKzdva3FnU3MydEVvNzhyb0pMSGNtbERldTY2MFJP?=
 =?utf-8?B?WWNmWkVhOEVGL1V6WmgrUGJ4dzdSOWJGOVczdWxWOUQrN2ZTU0tkZ1VZa1lr?=
 =?utf-8?B?UmFjOWhNYXNFR0k2YkxaMlhaZFBsYm9Ya0xQK2ZBZDB0QVhaclBiUzNMdEJr?=
 =?utf-8?B?cTladG56dG5tdkRkZ0o3Vm13TEt1aHYyUkk0ZGc1aVZjWlBmdTFjV2V0Z3pU?=
 =?utf-8?B?THBkQU00Z3Iwd2FVTEtBY2xlMG8wTHdyWThHSFlPUTB0R3JpdFdqVXFhR2VI?=
 =?utf-8?B?Slp3ZWxjbHB5NDE1ZnZSQjJmUllWc1d0T1V6ZHBzajlJVXhMVUw1WTM2UCts?=
 =?utf-8?B?YWkwcVY5L2tPd1Q0cDFyZ241Ukl1MTRBSTB0cXZTZFZFa29zZzBEVFVLU1ZH?=
 =?utf-8?B?Y3NVU1dDREg4WnRmTmt2RGZvV0JVT2VyWWNrQ3dQcFQyMitFc25UbDZ1UVYx?=
 =?utf-8?B?Ykt3R3ErM1dqSWZKK1ZJQWg2WkozVVhuU2wyb0NXSUF6amJVeVZwSGdleDdL?=
 =?utf-8?B?ZjgwQnp0TUlHd0hkb09ENmIwdE03dnZFclVoRW5JRGZNbHo1VitHUDZYSkdp?=
 =?utf-8?B?UE5CeVdCYUdXby9wd0hMcWM4bWd6SUh3OVZiYjBIM2xYdUp3SWs0Q2hjY1Ey?=
 =?utf-8?B?Z0p0aFpTM0ZOclIyZ05WWk13Tzh1anB4cDh5UjE4ZnJzUWlwY0hNSEE2TWVv?=
 =?utf-8?B?TXVjeGNqNFBTMWJhRUxDUWlYR21vdkdUQVFhRklNeWR3VUtab3BqUSs1Ukx3?=
 =?utf-8?B?ZXdUSkExSGNQREVVQzBXQkhQa0pyYURxR1A5SEtlanU0dnN2dUF1U1BMZlBv?=
 =?utf-8?B?NDlvUjFHVjkxdU9WYndLOXJEYm45UU5HdERJUXhQLzB4UmNXdjRCa3BCdlhS?=
 =?utf-8?B?L1hSOFRPRCt4R3hwY29qZEE5QmhVNnVYa1cvN0tseVd2Z01pVnN5QnBzNGtM?=
 =?utf-8?B?SnFId2tDcWphT3dLb2hQU0ZhbHlVWUk2R2k0MkJpano4a2xKWmJrS2lIblI5?=
 =?utf-8?B?VDBydjlYK1NHTjZlRDlwQVdaaEVwckg0R3J0eXNJTmpEQlRaYjlSM1hCR3pF?=
 =?utf-8?B?SVFvZGFZWGpDdnNzTTJCdGwrN1pzeU9HRStlOVpLbzh5Y1piTWRTYWxHc0gx?=
 =?utf-8?B?TVhDUzVPWWZNa2c3OEdFUUh0RkMwdjdGS1E3dzRZYS9GUWFvMGZNL0lTUDU2?=
 =?utf-8?Q?AIEbjFwNFj1RdeCROHthyuUT8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aae9037-5254-46ef-dab4-08de07633fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 18:39:58.6382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fhYDYU6TFpcbrmciaQVhzUhPgjkkAjG2nAxd5VOfNsHEn7taxehw14BfUBfzcEYcakC9LUr4zQ8X7ucu6Nb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

PiBIZXJlIGlzIHdoYXQgSSBkbyB0byBjaGVjayBmb3Igbm9uLWFzY2lpIGNoYXJhY3RlcnM6DQo+
ICQgYjQgYW0gPG1lc3NhZ2UgSUQ+DQo+ICQgZ3JlcCAtUCAnW15cdFxuXHgyMC1ceDdFXScgPGRv
d25sb2FkZWQgcGF0Y2g+DQo+DQo+IENvdWxkIHlvdSBwbGVhc2UgdHJ5IGl0IG91dCBvbiB0aGlz
IHBhdGNoIGFuZCBmaXggdGhlIG1hdGNoZXM/DQoNCkRvZXMgdGhlIG5vbi1hc2NpaSBydWxlIGlu
Y2x1ZGUgdGhlIGNvdmVyIGxldHRlcj8gT3IganVzdCB0aGUgcGF0Y2hlcw0KdGhhdCB3aWxsIGJl
IGFwcGxpZWQgYW5kIGluY2x1ZGVkIGludG8gdGhlIExpbnV4IEdJVCByZXBvc2l0b3J5Pw0KDQpN
eSBBRVQgcGF0Y2hlcyBhcmUgImNsZWFuIiwgYnV0IHRoZSBjb3ZlciBsZXR0ZXIgaGFzIHNvbWUg
b3V0cHV0DQpmcm9tIHRoZSB0cmVlKDEpIGNvbW1hbmQuIFNvIHRoZSBncmVwIGtpY2tzIG91dCB0
aGlzOg0KDQrilJzilIDilIAgbW9uX1BFUkZfUEtHXzAwDQrilILCoMKgIOKUnOKUgOKUgCBhY3Rp
dml0eQ0K4pSCwqDCoCDilJTilIDilIAgY29yZV9lbmVyZ3kNCuKUlOKUgOKUgCBtb25fUEVSRl9Q
S0dfMDENCiAgICDilJzilIDilIAgYWN0aXZpdHkNCiAgICDilJTilIDilIAgY29yZV9lbmVyZ3kN
Cg0KLVRvbnkNCg==

