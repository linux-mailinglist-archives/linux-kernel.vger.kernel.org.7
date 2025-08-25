Return-Path: <linux-kernel+bounces-785147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B570FB3469E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E2A1B21F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76F2FFDD2;
	Mon, 25 Aug 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYCF1JOz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAB1E32DB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137750; cv=fail; b=L9eR1/KVrRCZszXVUWOpHRCpUMIo9whsFMF4S8jMQVBSeuBYYSFZV693bI47uAoBtjEc7QZdSjMNiXQjdYXZ3jUYDvlEzCV7/xvB/FX3FSJqseSmfl+MC6QKIEWENohKq9+YSGIZwLEgXIgr4GEcBIr9J6By27M9pSQjBE3a2ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137750; c=relaxed/simple;
	bh=eHazAIlfVvIJPi/TtAdOAJzyU9m0i+rZm9cdLrE5hKM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eb0PKfr9jjy7BIbgyD1CQCeTqFZSFkR28vF49AXPvL0WEijxP6CTein3ULlci1pGUH8Ged+sgESSbs6yOf6ACO8LW4nTHujGOaztdOG4io0LzBfIDLVLLQ516zmAKMLlEXaff14xbTrbPWSWF6lCPKn8LLtAzaaQcK+U6RNmC2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYCF1JOz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756137749; x=1787673749;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eHazAIlfVvIJPi/TtAdOAJzyU9m0i+rZm9cdLrE5hKM=;
  b=iYCF1JOzspDvj6psXorBjLMVRFya93gyPSke8ZfSuo1u/MRbXcob+PIr
   wcZk3Cb3HUOpyQNKLwQCiXzt7eCsCwmoxmGDT3216rxvXDwAXX8ueR/Gg
   z5+GO7pFHHAS2TZdgbBC5dg1txn+ulVx5bBaH5g3njLWPbuyVblx7fkFr
   nbgIUJs4bQBmsevzsK+tDOBUB260Irj/HyY2S9SN81w3z7Il8LAWadccI
   Wry/hXsPGelsHhEmTFpbjKJXanDp8BmxU/WwgNKXlrdsrA+hQnzmjTru8
   4V7qVXnCosjWJH+x4ZOuO/X87iTQeUvUU/nULJcmGf/VxL9Oj6hR7o5AR
   Q==;
X-CSE-ConnectionGUID: 0tfzXtTNR4+rm6Ae7xZSxQ==
X-CSE-MsgGUID: kSrjXLg5SLWsUBS5ptmZRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58423598"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="58423598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 09:02:16 -0700
X-CSE-ConnectionGUID: /EIuo72TR5251JbzdUN5VA==
X-CSE-MsgGUID: ctTpNY8oRGCCNmcrWmD/8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="169722534"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 09:02:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 09:02:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 09:02:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.52)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 09:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1QN9Xj7Ph3xpt6haXudjhWxxSR5lSoLo3r+5ArWvtDcmLOjboUtvsn9wVg0XKiYOcj4SDx5JqacOMXqGTDju+uqxOVUW8WRjbrFEAAybAEZc5gUJdf93t9mgRDLs4bnPrf6QuoSXzwL9RzxyC+3hvnxggQefUSlDkcaGYoc1fprTCsy5COhWJ0xHZQ33frYNh2g3aAg+2qqYbPHA8jFkbYtPtEdlLhx9It3cdO7GAe/uharTq36EADO+YYGLWECc37wV+t5n0NKbpxrHhKocvE1AYabkYhbwtuNfJiDUxXWGaEQeRkFvmNQ9yWLHVpP746aCdJC4+/apTVGGxtrzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abu03g1PM6Bj3daKuKpmgacgbEvQxyszZIS//6lkHgY=;
 b=pK1Z0lzZKBB2KE0O+atESYEoL7Fj3o5oFE2v6zgxR8Bn8lCb5nWa6ymBMaahT7UxZfiJpNBvyWd/OSpdYMsFvU+Pceo1bKT4ULP1D9TSfqos2QRqfClIgLDTZK9HEbcNpg+Ji9YPx4OFeYxVhz1k9h8WPVyiF/FgbPUQ3+31/ENJwxxK9fqwOKJnmKfwH2FdFe8p+9GGkPXWx8VpbvETH5GCztVj8tlttcixhalJgc1nMC00WJ3py5M7dWwwWbTOwSaGDk+eBLgOGh8GSY85eK7zWdNEcQ/w1YKqkAjCzpeep1hi5HE9M3r4dPhXGcjJ4ieLVIYK/ai6yOsJ7y4evw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 16:01:53 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 16:01:53 +0000
Date: Mon, 25 Aug 2025 11:01:50 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Carlos Llamas <cmllamas@google.com>
CC: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Matt Atwood <matthew.s.atwood@intel.com>,
	<kernel-team@android.com>, <linux-kernel@vger.kernel.org>, Tiffany Yang
	<ynaffit@google.com>, "open list:INTEL DRM XE DRIVER (Lunar Lake and newer)"
	<intel-xe@lists.freedesktop.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/xe: switch to local xbasename() helper
Message-ID: <mohlhuvljdnvmlyi7gcnufw5nvkplhylilllxon2xmxdiw3oyq@h4vm3kpxg4r6>
References: <w4j3kzezrd4xqc4q4vkpbbxqvqxitam5htkex6rj6dguj5kbw5@27gqnp6veuu4>
 <20250825155743.1132433-1-cmllamas@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825155743.1132433-1-cmllamas@google.com>
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 833bbe12-2947-4669-185e-08dde3f0b576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEFFV1hFaklVTy90TnV6QW5RM2ZGdGxMSndwOGxjVktqQTZiTkRremFiWjFV?=
 =?utf-8?B?aGJrbkNEajFQa0ZMVWZWeWhnZm5BYnNFNUJmRGVmaTJ3WHVROU84TXplR3Fy?=
 =?utf-8?B?Y01ENDd3UndoYkxHazlXWEUySVB0Qkc5TUh2N09LcS9xQzlZY3pWdC85eFBZ?=
 =?utf-8?B?Wmx0QnRMS1E2NEFlRmkwTXVHVDFIaWowZndOSGVQUXJrd25OYkNiY3g5Qzdt?=
 =?utf-8?B?ZlFsdzdielVhYVk0U1BreEYvb1JlTHJIQzhzbmx4QlJSZWg1eEhNcUdCSTQ1?=
 =?utf-8?B?czBoYWtLc3JFRkEyM0ZWdTlGV2JlTjg1cXNzekY5VC9yd0pXQnFkZ21FbFp4?=
 =?utf-8?B?UWZ4NkdJMm9LOXdqSkpmOVRRWm9hWHBUeGFhaWl0bkcwL2Y3b0pjMzZ6MjhR?=
 =?utf-8?B?OGhYRVJZMWdDSnFnZFpMMHo1M1BYaThaaXNja2tKcTJtZCtCN1dFaHFVdTZG?=
 =?utf-8?B?aFFxOEVISkplY1R5akEvQWFmUFQwQUJWaVBHZFpScFF0UDU4eHd2QytMeE9W?=
 =?utf-8?B?NzhiTnBQOE5JUWtlUjVSd0I1T0JVaktHSkhZSXVEbTBYWW92UGJ6aHJkekF4?=
 =?utf-8?B?aVh0MzIzWmRra1I1a0Z3S0tFRUx3My8rK29PVk1wZXpZME9ITTF1ZnNzZU5R?=
 =?utf-8?B?NHkxVmZyM2N6QXRMQzZKUGZjeGtqY3dVRnpVQTBNTUhZb3UxSm5uWjVEZEov?=
 =?utf-8?B?NnE2QTNWT2tBT011ckRqNmhVeGVIMU1ZU3p0ZFZWOVRnTlhqUU81QU5CekpI?=
 =?utf-8?B?VTlzTGlkSTRKTXlwaXhRN2RhbkhMVXNSQU1jbDErU0dENkxKZXhUSGtCRWY4?=
 =?utf-8?B?VkVjMVI2SGZxODZJVVBMbHI1eHZQbXlZRjZ0M1A3VnhyR21iSFJrcnh6V3JM?=
 =?utf-8?B?Sjc1UVZrVUFnVUpud1NnYmJlSmJYWkNMVWtiQncwUGRqTTgrTXN4NERsVVhB?=
 =?utf-8?B?TllYUElxWWIzUXkzNUo1ZGRrT2RwbDBQc01BV242NmU0WG9TVXc3b0pWTVRO?=
 =?utf-8?B?V1UvN0ljbVZLYm5SMmZUTE1tTkxJRTIrV3loOW1aa05neDVPNktLdmt5MWVn?=
 =?utf-8?B?UWt1alRyZGErbzRScHFpbGFETStrbHRWVTZzQVhrTnp0bExkWXowUVFRK3hD?=
 =?utf-8?B?eFJ5OVVhako2dnNWby82YW9EQzQ2MGJiWFhCOGtURkdySTY5ZjVPQmxjblNJ?=
 =?utf-8?B?NTR1MEdoSWFSa1FTQVF3d09TaDVKRlFZRnQwMUxXMWFzRVNHVGk3UmtiYnpN?=
 =?utf-8?B?WFk0SDNSYnh5SkxmRWlzSTg4NEMyczNzWEFEc1JjSXZHOG82aDhKZ0lkdC9t?=
 =?utf-8?B?WWdiY1dsS3BROCt0SjBBMmZlS2ZHWjNVUmlJL25va1c0bTBpV0thWUM5MGRj?=
 =?utf-8?B?TlB5dHBTaEM1dEEyRkpzNWRSRFdqaS9maVk1OEh5Nm15UWQwS3FEOHNsUnRO?=
 =?utf-8?B?Y3RtaW1leFFvNWJCRkoyRVdFN2xTK0szOUtUWURrKys4R2RKc2VPenhpRHBo?=
 =?utf-8?B?cTdGSC9lZmNwYkdpQUtaMUQ4RWphSkhaUWI2ZjFsSmdyZEpYOHJ0azRwMVQ2?=
 =?utf-8?B?WGhmL2xGcTNpK3pYcHRjTDg2T2FMS1BoS1pwWmJnTS82bDlwYkpNcFRWclVK?=
 =?utf-8?B?ZmFHZGVnek0rdVlEUWo5UytNY2FXUGF6WTBYSVJmd0NNMHhjOWh5QjJ1akhH?=
 =?utf-8?B?aE5zSjhuNm5yVlN5aGxHR3VSaGFKTnFrcVNBVzIvUStvZDBZVkJMUEdaQS9K?=
 =?utf-8?B?bjY0djM4bmlJQXh4SU9scVNrRk1VclFXSFE1K21sRTdiODM4NDRxUEVwa3M2?=
 =?utf-8?B?STl4WFkyS29RZjVsYlY1ZXlOTE84M3dlU29YaTF4YUsxaVRUaVZBS0hVYk8r?=
 =?utf-8?B?SDhjSGlTU0FmZXgxTWJjQVZwVFpvUC9iNUZvVDlIRGFjS3ZicDU5S0NlWE9H?=
 =?utf-8?Q?VQYG9hKGpLM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckd3TmtLOUZrT25hVTRwR0QwL2pJYmRTYVc4VjhGWTUwWFA0QzIyN3grUHI0?=
 =?utf-8?B?SVJzMDN0eDFINmJua2xiNjNobGZYZHdzNExOR2E2cUpIYUt0SDhDOEpmZjhJ?=
 =?utf-8?B?VFltRUJ5RnpFT1RER3NHWWFSSmR1UE1LVzVCcDhyMnRhaTBGV25xNHluaDl2?=
 =?utf-8?B?TDlWN1huSkJjUFNvSW5uNWhNQmF4QlB6QWREem1ETzg1ZjVLQzNCMXdmUVV2?=
 =?utf-8?B?clh2d3Q5T2hDNnhiY3ZOUjFTRGhSajZPTFgrOGJicmZoV0pKQjF5Znd6Q0FN?=
 =?utf-8?B?bTVLRnVkNEMzTVphWU5UeVM2VUZsRVJrWjVBVVJZemRPUmdIY2NWdmZYbGVX?=
 =?utf-8?B?aXFNMEcxa1RNSFBEc0RGdmZ4NWZvNHBYRFlIV3FXcGkwNEE1SGVmNVZTRUpX?=
 =?utf-8?B?MjlEU3lITGl5QXNBWmFVSnp0QlpjclNBT1N2NFhJVXhEd2pJOGdLOEdmOWJH?=
 =?utf-8?B?WFNTMXF1WjFVOGxFUDBsTTYwM2lDNWpGbFluNlExVGMyeDYzM2ppUEkrOUE3?=
 =?utf-8?B?RVFzWmRVWTNHK3lMS2hGa0xJajRITXp4N012eXZDNXZaL1o0OUFMYWJiTU9X?=
 =?utf-8?B?R3hhdlBZK0o1VU5sYUhPRGdKMTlvSEFNZVVGam96NTAwZU10VGdzcGxPR0pq?=
 =?utf-8?B?Skw4ZGx5K2VNOTlWMmdSYmJpa2cwSVZqbUNhdWVNN1lMbWhBeFdZclZvam1Q?=
 =?utf-8?B?RDRRQkR6SnFUNktnQkplcE9vZjlKVTRwbkd2WXdZRXdqVVNGK2llZXJ2UWQ1?=
 =?utf-8?B?ZW8vakZodFE4RVAwZEVoR2huaUVrNFl2QkZTQXhVczJsbzV2enNCQWdYUUhw?=
 =?utf-8?B?bm1RTEJZQkZLR0kwOFdFNnJidWpSeTlDdHVTZ0lxYmlCU3VmZGYxZE5JdHJa?=
 =?utf-8?B?Z3YxL1FsSGx4TDI2R0tXcEUwakhTSGU1T054b0JyVVRDenozSTR1K25TajJu?=
 =?utf-8?B?U0NrdmdvOG8rWXQveUxoa3Z4ZmtMTE1qVGxQM0dQUkFCNmRROFM3Yk16Nlgv?=
 =?utf-8?B?NGhEVFRpVG1hdzVJNEJzSjlrWGtNRG56Y29TakdnMUZGdVlQeGRIdHQwY0FI?=
 =?utf-8?B?clVsWjZKK2ZjQW92RC8rT0JVa2xSZVJTTENWTXRmWjNRTUd1MHpkYnlRWE9y?=
 =?utf-8?B?c2x2Z3liMWlPZ3JiNUk5REVRT21NRVh1VkVOU0FlUGErWEl2azRXSFNEWll4?=
 =?utf-8?B?QWoyUW1SZDd6VVQvQi9vMUxJQk5IR1VPeWQ2NlhaS0RUditmVVYxLzNOaExL?=
 =?utf-8?B?NnJ0Yk5yQUt3Q2ZteERvOUFkbDVEU1VoMm12YnJmVGVUL1h5SUY0SHZkcmFi?=
 =?utf-8?B?dENyeU9hV29JQ2JWSHp2QWJTY1dDQ1dtL1M2MG9JRHdFNGVJWmw0Z1RIcG84?=
 =?utf-8?B?V1F2dmhtZHUrakdEZ2V6Z0p2MFo4YkFzSkJPZnNXbGlMS2RjYVpFdkZLbkNm?=
 =?utf-8?B?TGsydzc0ZUwvRlEzOWJ6RWRCWEozaTFsd2JCOVFFa0Nwa1FtZ2VKMDFkMTdn?=
 =?utf-8?B?SUZ3MUpsZ2g1K0E3clVBRk5Yd01KOXk0OVF6eEtHdGFCUVFsQ1RNWTdXNUJR?=
 =?utf-8?B?SzVkd1k1SENKeXNuMGtNd0NVNCs5dDJFZU5Odmx3VjBna0N1YWd0TlhnMVRY?=
 =?utf-8?B?TktZbmpBRWhTdHIreTcxSkpSbm56ZVhpM0NndUo3TytkUW00Y1JBL3dqUzFF?=
 =?utf-8?B?aEI1RUh1SUx2T0Y2Z1ZQTTdrL1ZCamhqbUZyNzVVR1VGb3Qva0p6SlR5MFVM?=
 =?utf-8?B?QUFoN0NSRVpiemhwZ3NPYXVPcUVHY3JkQSs2bXUwaGJ4eFFXZzduUkE0VU1o?=
 =?utf-8?B?TXN1STJHZU05YWNaMkhBSERldXFDeDY2QTBIR1d0M1c2aFFYQkIyZWg5UUhq?=
 =?utf-8?B?cnQvQytHWjVTbUJtbGlNc0g5akhXTHROSnNZVWUwc0tmRkdieFRvV0ZGNmNn?=
 =?utf-8?B?STNwc2ZQMk03S2MxU0lBazFhcUF1TUVLRGhlS3RQeHZhejhxNkdmb05NU0V6?=
 =?utf-8?B?bnZXaERyU01PQkpnMEJDMU5NbHRpMzBlR3FXMG15STdRalFaTTBsYmxCWStG?=
 =?utf-8?B?OGJ6czlDMTRZK2x3S0VXTkxZR2p0d2Ewd1JrZXpGZHRZeEJvTTZJZTZpcXlv?=
 =?utf-8?B?NlpvKzdtVXF1Y3B6cEdNRm9SK2ppUi8xVjljc25MWG1EYzZubzJIMXhOZzNV?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 833bbe12-2947-4669-185e-08dde3f0b576
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 16:01:53.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQhvfg7kqLLTcQPaw++mV8ug283exWMu6Ph8cO6ocN37XTvHZeitkDlM5JjSGQVljdU7HvOHFqY4hDmqw1RwBfnZvIT4EmAvMlQOch92FFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com

On Mon, Aug 25, 2025 at 03:57:42PM +0000, Carlos Llamas wrote:
>Commit b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
>introduced a call to basename(). The GNU version of this function is not
>portable and fails to build with alternative libc implementations like
>musl or bionic. This causes the following build error:
>
>  drivers/gpu/drm/xe/xe_gen_wa_oob.c:130:12: error: assignment to ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>    130 |         fn = basename(fn);
>        |            ^
>
>While a POSIX version of basename() could be used, it would require a
>separate header plus the behavior differs from GNU version in that it
>might modify its argument. Not great.
>
>Instead, implement a local xbasename() helper based on strrchr() that
>provides the same functionality and avoids portability issues.
>
>Fixes: b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
>Suggested-by: Lucas De Marchi <lucas.demarchi@intel.com>
>Reviewed-by: Tiffany Yang <ynaffit@google.com>
>Signed-off-by: Carlos Llamas <cmllamas@google.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

I'll push to drm-xe-next later today. Thanks.

Lucas De Marchi

>---
>v3:
> - Switch __basename() -> xbasename() per Lucas.
>
>v2:
>https://lore.kernel.org/all/20250821220054.3700783-1-cmllamas@google.com/
> - Wrap changes in a helper function per Lucas' feedback.
> - Fix typo in commit log: s/avoid/avoids/ per Tiffany.
> - Update commit log.
> - Collect tags.
>
>v1:
>https://lore.kernel.org/all/20250820201612.2549797-1-cmllamas@google.com/
> drivers/gpu/drm/xe/xe_gen_wa_oob.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_gen_wa_oob.c b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
>index 6581cb0f0e59..247e41c1c48d 100644
>--- a/drivers/gpu/drm/xe/xe_gen_wa_oob.c
>+++ b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
>@@ -123,11 +123,19 @@ static int parse(FILE *input, FILE *csource, FILE *cheader, char *prefix)
> 	return 0;
> }
>
>+/* Avoid GNU vs POSIX basename() discrepancy, just use our own */
>+static const char *xbasename(const char *s)
>+{
>+	const char *p = strrchr(s, '/');
>+
>+	return p ? p + 1 : s;
>+}
>+
> static int fn_to_prefix(const char *fn, char *prefix, size_t size)
> {
> 	size_t len;
>
>-	fn = basename(fn);
>+	fn = xbasename(fn);
> 	len = strlen(fn);
>
> 	if (len > size - 1)
>-- 
>2.51.0.rc2.233.g662b1ed5c5-goog
>

