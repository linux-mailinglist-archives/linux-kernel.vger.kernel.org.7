Return-Path: <linux-kernel+bounces-893816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC05C486D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C430D4E8643
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EA22E613B;
	Mon, 10 Nov 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4bn2wis"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6872E62CE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797031; cv=fail; b=FgbxNgfIqao0zoAvghRqyg3hQmZKPgaZo02PgrDee+11MequuZAv+B86+ZcnhBB56gVY44dUDivkMMp7A8D0HACTAeNrRXPzlPTEQwmC5Ng4miOuxjFuDk1qJ1H/d1tnGbPECiIqAIFiQ2kzCIXNFYDWrayWu49P1SMLNBVjD0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797031; c=relaxed/simple;
	bh=r3WsxMvW/4yZOeIxVmP2d3UzeMF5VCVZGwK064IhowI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=maNXzyXeaf6hhyBp/cHhO5TELLI812DPf9V1nO9K08FDsnu/2ESntga56C/CFYUqbkrZ3FXjyz4jBXxVKDJrZSYLhxgJhnfPoMuDnMVqvYrkTcOHVVZcZHmD6IEivrzr4xt2BK3Ukj4vVoY+86/mcfKGg2tBh8pXeK8e6GPZDcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4bn2wis; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762797030; x=1794333030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r3WsxMvW/4yZOeIxVmP2d3UzeMF5VCVZGwK064IhowI=;
  b=f4bn2wisep0ND5k9XIdGqpX6Qb5vhLlIX3oHNJ9mFHBX8pCVLo6Fg2p5
   SUY9tJsDa+d5XhV4uVx7Em12wa5SHhMc/hJZrgVyVUkgqgHlHeJKcjna1
   aJfzoZcLsepHr2qz4GtaZ51tv3sVyy/QUczeawjTJjOkyn4u8X6P2Geao
   hZmJVOpiZoEeKabcVrckkdHQscdkP9M7Lo6SaifLmu7RlNIWO109LYAMs
   XqXfIquKeS8+672Vg7VChAbdBOURlNtBLsOht8EnXYKiFSTHOYpJy7m7d
   FTcqJYmQNokitT15WhBwcomgBmiYDBs31cqDXr73MksPzI9sW9+7yKFBc
   A==;
X-CSE-ConnectionGUID: OlCKPiKyQBejVmwgi+n2sQ==
X-CSE-MsgGUID: Bt8M7vyMRrysAhgzVvJkkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="87483180"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="87483180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:50:30 -0800
X-CSE-ConnectionGUID: 5Xk3hv2ZS/um0NIl87I0UQ==
X-CSE-MsgGUID: KKBeRbysRDCuWYSlEwDUbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="192990782"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:50:29 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 09:50:28 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 09:50:28 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 09:50:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubxVwipyZ/MnKACGIfLj9ynXaVSiGYqfTjZZYWQg7Q+HBz23wbs9kutRFgtpOTiZM4Jy9AY5gB7Z7t0kAtvsy2UlwNR1J5eLbdBbRrt7duWCgFyQP5zVrQF1OfbCPYbD4Ku7IPFdoubkkJ9RPt+9B86+eJ3uDpONMzQ5Gm/zMFDS3lnYWSIVQo5cXdAYQ7iOzmy+B7DjoqpXbbNN81rC7/Mpm8NMWVoloP+GoUuun8ps/xB3dJV/sPCIVvBmGGjKC6vDO6vJhwq85ABUfJqLOg5TmZPAvluklWqDnAwKJKQbHXj4tnCeH+3az4Z/ipYoZyLhzSYoycZ7KvBpaZPX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3WsxMvW/4yZOeIxVmP2d3UzeMF5VCVZGwK064IhowI=;
 b=cOMfNeQFASwBe6VnvLNOaLQmmUk2Uy++Est4pn9/PqzTMVZ2+wKPkqzVocHJKsB+ZUJ1kCDGf6y3GtURxms4Jtq3ZpccaH2JNpu0S2kPEvK51LkHS8DbQiXgd2sMGYicfvLLkenMpuRVrz2WGzW/DNDCr8vezZNUMjX3dFUMQqx/yJJsFQKLCrow+7uU8FnSrVGL+jPbPZfOaCnYG70n+ozJL5RW+eSakeNNvq1Ft024FWx3P5OJOEgGo8b6bsLqPlxJatk/y0AF1Sj0JNxf1zy4Y0VcJepcKiVf361Qt1jxx4hQqzaODqwdyETJjCi4dcTphIuL3zPSlMjZbjsnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6946.namprd11.prod.outlook.com (2603:10b6:806:2a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Mon, 10 Nov
 2025 17:50:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:50:24 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Babu Moger <bmoger@amd.com>, Aaron Tomlin <atomlin@atomlin.com>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>, "Dave.Martin@arm.com"
	<Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"babu.moger@amd.com" <babu.moger@amd.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Thread-Topic: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Thread-Index: AQHcT4VCMZzJIaIcpEO5HF/nc2I90rTnxWyAgAAGSYCAAAv9gIAAFBMAgAQ1DACAABM98A==
Date: Mon, 10 Nov 2025 17:50:24 +0000
Message-ID: <SJ1PR11MB6083701B503CE361E3D7A656FCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
In-Reply-To: <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6946:EE_
x-ms-office365-filtering-correlation-id: fe38448f-8c09-4eca-0649-08de2081a056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|13003099007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dTd6TFZrZlE5bDNFTFN4S08wdGh2dUQrZHhNMmlOZWdKdnNDWVVDSTN5Z3Bw?=
 =?utf-8?B?S0h3c1pCWTFCdzUzV3NLeHRtblNsV281cnIrWG9uMmZkMVN5YVl4NmU0Zm4z?=
 =?utf-8?B?aVZ1SFR2bXk4d2ozalcxV0tMYWtnNTMxc0JyS2I1RHZ2WUliR2xaaDFBSG1K?=
 =?utf-8?B?dXpuazkzVnNPUjJkLzU3eU5sZy9Bck82K3dVR1VhRy82ZmdPZDFRZjc3SnlE?=
 =?utf-8?B?WnlKWldFVGYzMmNUbDY3R3RFSFpmNmZNZUxsTENPWjl5Ny9WUk43aVppWENh?=
 =?utf-8?B?T2liN3NMajQ4eUNUakRZWjBpalNBeSt6bk9SQlJKQ1pNM1dhTVRPUjcxS0w3?=
 =?utf-8?B?OWo3Nm1WNmJKMmNtYVQ5eUNrdVpOM3VBKy8rK2RnMUR5UUdkYmJiTVBGdWl2?=
 =?utf-8?B?SVFjNVh2K2lCUVN4ME9ub01FUEYzcHZBOU9iUnh6S2d1eVRzSWlxVDVPajY2?=
 =?utf-8?B?Y3lLVHd5Q1NhNDZtcEhGa0pkdy9xNlE0eFdxMzhNdGNqc0F4NGYyaE4wTEIr?=
 =?utf-8?B?MittZms1alZXSmNaaE1Gd0docmtQWlZZMy9VVUtHb0NZNmhUOENHTzQvaVhJ?=
 =?utf-8?B?a0loQVBoN2xHMmRzWktjemYrdmVnblBhRFlJS01CSEd4N3lZOElSU1lOWDhG?=
 =?utf-8?B?R1FiQzdEeXNtSDhydGFwbEkwT0l3b0RoVWZYMDIyUjlUeGtIcW90SUJqOVU2?=
 =?utf-8?B?WVNidnJOQmVYNFdtQ1pDa3ZjMnhETUxhTTZ3STN3TWxvb1NXVzZxbnJybGlX?=
 =?utf-8?B?bktKQmRlb1BsVFpON3lkV0l2MTVRRVdQUG94bFBEM0FaUFRvRllFVXZXT3hw?=
 =?utf-8?B?THBYcDB2REI0VmozMmNHTG12ZFQ4Q3NKVTRKVDRobFMzRElCa2hFL1czbVNT?=
 =?utf-8?B?SzFVYzUxN2JLWnpCNFJGdTY3SnczQUtFYXc2YlkrWUQxVE1FRFBYbWZwTERL?=
 =?utf-8?B?bzU1akV5d1Z6OVovUVR5SC95cDBSV2NqSnQzTXFPVEI1VzcyN2dtRlV6b0Qz?=
 =?utf-8?B?YmVMZVgyREFvL0dKZDRLd0RweFhWRXZpZVFKNk9pUW1WUXpudDhiQk15clI3?=
 =?utf-8?B?RVdmZ21FT2swTlpFYTJLL0l1MElYaXBHTm91MFhpN3pGQ0dKVkZsWGhoV2tx?=
 =?utf-8?B?NzJLU013VVg2K213cGxEODhkdDlndUZKSGg4NnZrRlNIdmVoeStWTVBlYWZ0?=
 =?utf-8?B?VTBoUTduWFFuVlR6Wldzcys0eVYrd1JNeCs5NXdmOUx5NWh4d3ZDTHVKelRG?=
 =?utf-8?B?REkveUkyZWRyQUVqZUlwWW0vSU1LM1lUaVpjdEJhVGgvQXB6TzRXQnBlTlpv?=
 =?utf-8?B?a2lSR0d0WXNmendLeUdoWEFuZWlFYkN0RkVhRHVIV293cGdkNFlMMEc5SWZw?=
 =?utf-8?B?OEtYUEZZK0dSL0NHTEpFbTh2NE92aGd6NHhKQUZpV3BacjJuZHRBZmZDRnho?=
 =?utf-8?B?WkVBK0lYTHVGTCtZTS9ST05nYzZzcGlhYm0xQ1A1OUZzZk9JVGFKWjdWNEdE?=
 =?utf-8?B?cHlkcDRUTFVxQnpWMVJKZ05seml5bEdOdE04ck1pL3VhWWpPdUk1eThWMVdX?=
 =?utf-8?B?bG00MXY4eC9GT0tQc1h3Mks2NjErSWxJZlZ2em1uMkdBU3NJREsxV2VSa3Vy?=
 =?utf-8?B?STdVTENPYUkwUjZnWUVZQ0dmclB2bHlpOTlzNG9GKzZSNitVcmZMa1pZZVBN?=
 =?utf-8?B?M2txc2t5YmVvTktuV1pST0k5NTZTV2lxbmp0MThXN3lyZXB5a0NjQm5GUFp2?=
 =?utf-8?B?a0NNSk5yeDl4ejdNWjUrbDlqZmtxL2hJS1kwdXgxblZaNnFnZmpWclFURUdM?=
 =?utf-8?B?NHg2L3d4WGpmTVpqNXhqUmtpNWVHdTBWUTlkQ2d0VUdJdVdLcUFCOE13OE92?=
 =?utf-8?B?MElwQVVnN0hrNDlTM1RYZ2xPNWlkTmFyZE56dlkrMzd6RFVvR3FrQUhvTDNE?=
 =?utf-8?B?L2NCOWZpUXZjNTNCRWJHYVIwck4zQW5YNi9YeC9Nd3NkQnlZZ0t0aFpQaCtN?=
 =?utf-8?B?a2czZ1NrL1lGVTZ0eTkyU0VrcU1uem9TSmJ1OUg4NVMybTFpVkdBb3EraVVY?=
 =?utf-8?Q?FNBAaT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVVjWjZnZ3B1cGpOQ0ZqV3BybXMrREdBTTNzUFRsdkNaRWFrZFFnM2FWTUhz?=
 =?utf-8?B?cHdWOXlDSEtyUTIxYjZWL0Q1NmlEcm4zY2l2WTBxRHA3NHYySkIxMUhhQm1h?=
 =?utf-8?B?NkZXT2loV3VFNkM1eG5zc3J4NmlnY3A3cXVvYnlkT2kzTTRxUThyWEZaWXl3?=
 =?utf-8?B?UE5QeE8zMTZkTm5QbGVidmh2OHRaV0t2UzVCQXcwekhZeGJpVEZxV2I5VGdC?=
 =?utf-8?B?Vk9rU0NvRUtXenFOUlcyaUhTVFl5akN4YnliSXVrZFZhemVMUkI2YlllUkZ0?=
 =?utf-8?B?ekhyMUtBczQzMzVhU0E1ZXdabklNOGRuV29FK0xYUVJ4aVBVc1lFYTFKcWN4?=
 =?utf-8?B?NjRybG9kWFV2ZG1HSGl0Ri9OQzFScEVMblNzTjcyK21VZTJaNmZsTjljRUl5?=
 =?utf-8?B?M0Zkc3djNHg5eTIwNG9YUFgvbXl3RHRTYkdxRTY2a3JYS0tJSEJUaFlYY1hK?=
 =?utf-8?B?NDg1OGo2QldoVVhtUEhYU2Q4SExCc0NwMzNhQUtKREdRRWtPeDFjdWRRcUZG?=
 =?utf-8?B?bkhwNWJVRTZWNXIyOVpBdFcrSFpQRzFGVGRLTi90ckNsUEI1QnlmUGkxNGxa?=
 =?utf-8?B?QmltRU9TMkkzZTlLMzZDRmE1aVU1REozaTFkYVY5Q2t5aCthdnR5OHIxbzg3?=
 =?utf-8?B?T2RQSG9kZGkyZHJJOFplSWVyQ1lJVHdSOEk1eExMSGVKdzVlakswTUdLdVB4?=
 =?utf-8?B?T1hWdmFWNDNqYmlpVWk0R1ZPb0Vmd0xIbVlBaDFUM2ZPd1UySHUrLzNuNFhL?=
 =?utf-8?B?bjUxcDNQODFhOExqeVBPbkNVT2JvbUtXTzVWdzJ0NVV3M2lOS3M5MHB2WEFk?=
 =?utf-8?B?T0pyK2JXYVEwVW41UW9wZk5NVzRtNjZqRzNoN0JhUk12UG1tek9BZ1lLd3BY?=
 =?utf-8?B?OFNjOGdwVU9EbFA5eFB1WHlkZkZ5bStJMUN5Y3pJRGo1SW1XT0pEK2JMZ2E1?=
 =?utf-8?B?dHNPWTRGSGQzRE9LZ1FVZVpRYmlkNUx4Lzhzdm92OFJyNFlBRlhEeXU0bEpr?=
 =?utf-8?B?eEJOSldkS1IwK0xrRklscFZuYmNpcEZrNHJJYmVkNzRzKzcyTjlXYXVCNjRr?=
 =?utf-8?B?K0xmMHZPd1pKbmVPUVBEZFNWRnArWTArR2NsenU3QkdNZWNEbSsrRzA3eS9N?=
 =?utf-8?B?L1FFVU1qdlYvdWh5K3dRc2JNUzdWYW51QzZ6VFJkS3V3RUN0QXgyVzU4YkU3?=
 =?utf-8?B?WTZkNzc3WXlVekdCbHArZ3I0VDBGWE5rTHZvdzBpTHNTLzhaQkdpSXF3L0hK?=
 =?utf-8?B?aElMLy9oSDErYzJGbkpzdE12YW9vb0VmOVhUSXUvQWF5NHJ2NWtwbE1yc0l3?=
 =?utf-8?B?bHQ0WUZBb0tVaUNmMXJYUjJ6UGhVWTZXd2NQSkpYT2g2SUxUNEJtKzdiaWtD?=
 =?utf-8?B?eWpkTGhlZHVrZ2FyTzN2L0U0ZGw3T1I0Y1NwcmJkM3hXM1dUeUl5TGtRZWRX?=
 =?utf-8?B?TVBOempkWEd0UDR3cWJQTk9mWGorNXJ6S1VpNENleXdqaktjbk9TRHF5ODNa?=
 =?utf-8?B?UTIvMlNTRFZPU3lMUXU1L2pGRllQUW5FZFJEQTVoQUViRnpKTTRLU0IyMSt1?=
 =?utf-8?B?bnZ4cVdFc1psM0I3UlIyOTZnWXBWZVFFaitSdjlQSEdJNThzVGtVb1YvbGJn?=
 =?utf-8?B?Mk0yTittRm1ja0xJbDBHa1N6a1A4VUc3LzJkbkhBVlJueFA3aHF1dmNKNHFw?=
 =?utf-8?B?U0I5WmFXNzM2L0kwZERzSExFSVBHOGVQa0VUOWNVYklTTmo2dDZoM29pVDdY?=
 =?utf-8?B?OTJZSkJTdzhuQ09ISVhpSlFHNG85N3VVeWNnTjhIMEFhOUZKSFlOemNSNkE5?=
 =?utf-8?B?YWIwRnJDcTVBQjhjM1cvMFlDOWs0eS8xcFVaWmt5MUJIN1N3d01zMys3T2R4?=
 =?utf-8?B?bDZCbVlYajhtOVFuTTk3YituWnllaDlJd2sxZXZVaEJ2QlV6RU9HdndhR2M3?=
 =?utf-8?B?V2hFR3JqbTlzeFl0MDFITjd6OXVJTnRpRCtnd05OeGhWNWZPL3BRcUgrUUJH?=
 =?utf-8?B?Y3g3K2ZGL3NSRTNJQnc1VVBTa3VkL0JUVUtvR1dXcENvaXlpVGJiRUdjaGFS?=
 =?utf-8?B?L1pTVXNET3YzU05NTkJXdkZ4c1J1TXRsWm5YNzJhUS9rTHF5VVNJU0VSM3h2?=
 =?utf-8?Q?zi3C+OXFZ5SizTrcFuUH8Na0F?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe38448f-8c09-4eca-0649-08de2081a056
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 17:50:24.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/w9Nn4ZRfe/uc/mZDNMfdYDF/dxhHI2KRQcLEgfQVANMhiUpAsxoKiKL+wHp1VgCU/SP3uc9PTKQ4RSTYfdWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6946
X-OriginatorOrg: intel.com

PiBEb2VzIHRoZSBmb2xsb3dpbmcgb3B0aW9uIHdvcmsgZm9yIHlvdT8NCj4NCj4gIyBlY2hvICIq
PTAiID4gL3N5cy9mcy9yZXNjdHJsL2luZm8vTDMvaW9fYWxsb2NfY2JtDQo+DQo+DQo+IEhlcmUs
fCp8IHJlcHJlc2VudHMgYWxsIGRvbWFpbnMuDQo+DQo+DQo+IFRoaXMgZnVuY3Rpb25hbGl0eSB3
YXMgaW50cm9kdWNlZCB3aGVuIGFkZGluZyBzdXBwb3J0IGZvciB0aGUqIm1ibV9ldmVudCIgYXNz
aWduIG1vZGUqIChzZWUgWzFdKS4NCj4gWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9i
ODk0YWQ4NTNlNjc1N2Q0MGRhMTQ2OWJmOWZjYTRjNjQ2ODRkZjY1LjE3NTcxMDgwNDQuZ2l0LmJh
YnUubW9nZXJAYW1kLmNvbS8gPGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYjg5NGFkODUz
ZTY3NTdkNDBkYTE0NjliZjlmY2E0YzY0Njg0ZGY2NS4xNzU3MTA4MDQ0LmdpdC5iYWJ1Lm1vZ2Vy
QGFtZC5jb20vPiA8aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9iODk0YWQ4NTNlNjc1N2Q0
MGRhMTQ2OWJmOWZjYTRjNjQ2ODRkZjY1LjE3NTcxMDgwNDQuZ2l0LmJhYnUubW9nZXJAYW1kLmNv
bS8+DQo+IEFsc28sIHRoaXMgbmVlZHMgdG8gYmUgZG9uZSBmb3IgYWxsIHRoZSBzZXR0aW5ncyBs
aWtlIEwzLCBNQkEgYWxzbyBTTUJBLg0KPg0KPiAjIGVjaG8gIkwzOio9ZiIgPiAvc3lzL2ZzL3Jl
c2N0cmwvc2NoZW1hdGENCj4NCj4gIyBlY2hvICJNQjoqPTEyOCIgPiAvc3lzL2ZzL3Jlc2N0cmwv
c2NoZW1hdGENCj4NCj4gSeKAmWQgbGlrZSB0byBoZWFyIGZyb20gUmVpbmV0dGUgYW5kIFRvbnkg
aWYgdGhpcyBzZWVtcyBsaWtlIGFuIGFjY2VwdGFibGUNCj4gYXBwcm9hY2guDQo+DQo+IFRoYW5r
cw0KDQpCYWJ1LA0KDQpJdCBkb2VzIGxvb2sgbGlrZSBhIGxvZ2ljYWwgZXh0ZW5zaW9uIG9mIHRo
ZSBtYm1fZXZlbnQgYXNzaWdubWVudCBzeW50YXguDQoNCkJ1dCBtaWdodCBiZSBhd2t3YXJkIHRv
IHVzZSBpZiB0aGUgc3lzdGVtIGhhcyBhc3ltbWV0cmljIGRvbWFpbnMuIFdlIGRvbid0DQpjdXJy
ZW50bHkuIEJ1dCBpZiB3ZSB3YW50ZWQgdG8gc3VwcG9ydCBMMiBjYWNoZSBhbGxvY2F0aW9uIG9u
IGh5YnJpZCBwbGF0Zm9ybXMNCndpdGggYSBtaXggb2YgUC1jb3JlIGFuZCBFLWNvcmUsIHRob3Nl
IGhhdmUgaGlzdG9yaWNhbGx5IHN1cHBvcnRlZCBkaWZmZXJlbnQNCmJpdCBtYXNrcyBiZWNhdXNl
IHRoZSBMMiBjYWNoZXMgbWF5IGFsbG93IDEyIGJpdHMgZm9yIG9uZSBjb3JlIHR5cGUgYW5kDQox
NiBmb3IgYW5vdGhlci4gT24gc3VjaCBhIHBsYXRmb3JtOg0KDQojIGVjaG8gIkwyOio9ZmZmIiA+
IHNjaGVtYXRhDQoNCndvdWxkIHdvcmssLiBCdXQNCg0KIyBlY2hvICJMMjoqPWZmZmYiID4gc2No
ZW1hdGENCg0Kd291bGQgdHJ5IHRvIHNldCB1bmltcGxlbWVudGVkIGJpdHMgb24gc29tZSBjb3Jl
cyBhbmQgd291bGQgZmFpbC4NCg0KLVRvbnkNCg==

