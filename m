Return-Path: <linux-kernel+bounces-863389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4ADBF7C02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A2184F42D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06363570AC;
	Tue, 21 Oct 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbqJ7w2c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6134A768;
	Tue, 21 Oct 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065021; cv=fail; b=n8VtQ/7cFqAP2KGc0G2xG3riHpfFsDJZbkXECToBqFhKyD7Y4HZotESj2rA9HCLblA6ahalOevCj2KE+cOg8V2WCHoorAPP5CiVvt/32lB9k2r3KysBoiyS40prsb2v4oNDTyfLy7d3SD+hfS/kUEemilCBO0ZcANWt34eB31/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065021; c=relaxed/simple;
	bh=T6i4LYzt/ZPFAe58S1nyB8x11Cz7gXsQKjjj97DTLDM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=iXQR1Hl9m/wLtUOuRmXSwyx5MB9/fLVbVIjiLMZpaIGnWqFdxvCq2aWOnQFYxqkbgu/c6NmQLAtujCMn1KK3ncm/496adb/pUd8QQP6LeugwgcoqSagbmNGcgbaroBj5okTjKV10HKw9zigkXJe3ZL8vOWzP9tyqP58tlG0OpKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbqJ7w2c; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761065020; x=1792601020;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=T6i4LYzt/ZPFAe58S1nyB8x11Cz7gXsQKjjj97DTLDM=;
  b=bbqJ7w2cHgpfS1f8kgx5c+/Vk8EG2cBiqsTp+J4gianEMhuOjl3IQIJk
   TqBtefn2X8ZrqWnp5rcs+8JEimWG1JoSdhECZdfrtOFnJh4ED8tPqvrwj
   5JxN5CgFPlFRq9C6griGyeEtsltZoggQjvat9Z7cK9uLJXVShYZ0iaLJm
   26RrgVeJ2fxHnvQ8+K0HMW6airr9tO5auZJartGuf9Dsb/Pq8m24DdOSp
   4jYg/SjSU9UIQYPRhOQwkuYIFJJHl6b1199TPoxAmNRDa+JEJ5rMto7oD
   g1iM6TolF0J8Kfnc0Ar3C4C/eEZietgycY3BQ4InZAC5+ysxLh6vYXF3i
   w==;
X-CSE-ConnectionGUID: VQH5v62XTsyJ9FOrlV770g==
X-CSE-MsgGUID: my4I8wxQSQyX5+x5cXjSJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67062659"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="67062659"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 09:43:39 -0700
X-CSE-ConnectionGUID: xHE13GYmQDOyK1YT/6tzpQ==
X-CSE-MsgGUID: gSdoMy14QFOziJ/9dIIuMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="183201958"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 09:43:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 09:43:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 09:43:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 09:43:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saRXe6dcOir/rKzdvH4n+is4VXNnej7oMYMO/MYXyZqZbedRuNRRd8ZvSrvQX77M9G4uRxcywdnLdEMU3A8MX18xVUR02tMw9emzda3HVUy58HU1jOAhnRqMlCxvkkORxGRSoSxF5hfBSJxeIkyleGDJqE5E/kKR2Czjdw6CqkXuESXdcQ5PtV4v7ieBXm5Jra/qQXVsq1DPsrenTE9Y5XOedzMSMV0ohc9qu5TggoMEimkD1LnRHupTawx5DT+rRwqMtbVk8aXt4fu0JQidubT8QFvWa57FrNMjJVvqM+XcD+K/ZQVEM2UbhndkLeP3unPgRR07E4t4eXop82FHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA6itVCt5OsfWAEugtkOtl0b/FfpuDJHaX2nddgiCeo=;
 b=IuVVvotMhfOSVGBMETsPrQNUH1soDaZeQEMT28sCQUqjQtHH4OX42NxDoFbSCcUYsiHUgIvHMGc0bDmfiLn7ActFdOTDMl9zwzdhU5C4A+wqxF3Zrmxl/hoXuLNkaa4IPvOTholjdHpbbQgV9cQuoT/M5EWbXkkltHX7W1ug47jakw+2klSRFxkA0xmMaPZu8bMs/d+t66saETB5g4ATRrRq/Mrj9oAVokktwUKORrdXNmvGcgi5zlVQM9nD6RgKFq8dm3Nps+uis1Ct7kB53P3rGawCpnIpcCCYp07j6tQLCRYfyhkjV9Ozbi4Vuo8z5t5tnOtIpMIgIfysSJah+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 16:43:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 16:43:30 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 21 Oct 2025 09:43:28 -0700
To: Ally Heev <allyheev@gmail.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
CC: <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ally Heev <allyheev@gmail.com>
Message-ID: <68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch>
In-Reply-To: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 64716925-9b80-49a0-f6ed-08de10c0f78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnZraUFKM3pCNXQ4TU9PajdMNTJIOGtTak5uOVlkSzYwZXFBUnRaZE14cFZQ?=
 =?utf-8?B?K3FwY0c3bDdCTWppV0xXRVc5QXpNWXBhY252dTRKQ3ZOanZPbjdzd2dzVjFS?=
 =?utf-8?B?bmlxblkxTzBYbGtFZGFCaG1oUjd5ZFFJeWhyMGd0WnJxN29rVGRuYUJZZUFl?=
 =?utf-8?B?dksrUE9lNlFlR2ZmY2dFeUZ0R3FEZGp3dDJaZWJRR3p1bWVITjYrZGJsa0RP?=
 =?utf-8?B?QkM5dTRlNlRMaWVLc3oxcFVrNkNSaXB4dGcxTVJMVnNRSDNIRGkrYnRFRnZ4?=
 =?utf-8?B?Sk9uZ3RRMk0zUWUrd2Z2SkhnVVVib0kyTTViS1FPM1A0VTJ5RkJiRS9aUEMx?=
 =?utf-8?B?b0svMytENlRaL0FHdC84dHV1c0ZHaEdYT3E2bDVjL1ZWbDRjdUJWYnhiMnl6?=
 =?utf-8?B?dnQ0cUFWQjBVT05FQkJURVREbXloQ1RSSExIYjE2M1BkL25hK1lFdVlGbk5S?=
 =?utf-8?B?VWVoWVZVVlpKcm5TTWo2MFBMM1Q2aXA1TXZmb2dIQ0FpTVpmMkRodnVXbkty?=
 =?utf-8?B?emFsY09GZ1FHNEh0WjI0ditKZlZhcmV1VGtTa3BMdEU4Vmg4TkZEOUFHcTk5?=
 =?utf-8?B?WFFOVHRVODY2eW9wSDYrbHFRc1cxZnp2Qi9uTU5QYVQxYVQ3UGNBSjU3eWkx?=
 =?utf-8?B?VEJZcGVPR3RscDFhWWQ3QVVvYjhUdGNrSlJ6V1Z6eTA3VkwrVVo0bFhoeWhO?=
 =?utf-8?B?Yi9LWVljOUpwRnZpbVNIck9Uait5SjVpZ012WCtGU1ZOWXltaE5xT0NHMGZI?=
 =?utf-8?B?MFJtakZSOWEyVTNXdDc2MFBTR2VKMU1WaUxQMVRRQms0ZUNtRFhBUklKbS9s?=
 =?utf-8?B?ZU1oRTEvVWllQWlwenlGV3J0bEpHdnV4c3NKY3lPYjVJemhWbVFIWWJ0bTFB?=
 =?utf-8?B?T25CZHR2Z3ZVREFZS1Q2TW82emJabDVoUG1SdWpDYWZuWUxqY0ZsNHZaRkQv?=
 =?utf-8?B?cmRqUnpybHFndHJ5Z281UmxrSnR3YWxsYUNGOTErajRlNkttdG90RTJ6MGFh?=
 =?utf-8?B?eFVOeWhYV0xzeGdFZW96TEY4RG5pMTBLQmxpbFFnTURpVEtTNVJGV0Zxd2Zy?=
 =?utf-8?B?Z1BabFBJVEN3WHFHZER3cCtvdDJ5b2MvV2ZhNEZiZWMwYUFaZnpnUXFSRjU5?=
 =?utf-8?B?MkQra0wwQzNuODNkM25CUjRZSStzN2lmZ3VwVzJLeU1VTFk2QkQwTTBsYUIw?=
 =?utf-8?B?NkpENU5HYjNCNlFLNlRkVXgrcjcyYVBLUkxEZWJoVWs3OEFXRVJSS0g3Qjlx?=
 =?utf-8?B?Tk5zemR2R0tiWjNXZWRCd1pqaFpLd09UeGZOWS9TQjA3K1QxOGtuNkdlc0E0?=
 =?utf-8?B?UzdnOTdPRmZiTDA1dlE5bDhhZWRGKzhzYVZVZmxpejJUMGhmNlVlT3NrVkRp?=
 =?utf-8?B?Rk9FeWMzazdmYU1OMCtyVG5lcWwzcDVhVU95Ykdpb0t0dFBiQkVGelFrZlV3?=
 =?utf-8?B?QmZZMWhrQXM5eGd3WjlVTndxNThOeG94RDgvK0dLRnJtWDVhb3hacXdFUThV?=
 =?utf-8?B?VUN1ejBEN21NSU1uODBZRkNRSmR3YVFkYktRSjFjSzZRVDJSK1pyWGNQanR5?=
 =?utf-8?B?OXdVb1FMWGl2ZENoa1htUm5uVUlzMDUvY3JmNTduYkdpYmdOVFVpTkY3RFFi?=
 =?utf-8?B?Nno0U2hsbGp1RlJ2R0tCSkR6cEZjK25ORVZlYTRGRm5HMGtIa3htZnBjMkZP?=
 =?utf-8?B?S1RzUFkwK1FaYm9oNFVEYllBVG13MGVURE82ZkNRVDF1elk0TjNsQzZ4TEhS?=
 =?utf-8?B?anJQM0oxeTVadi8zdERPMEp6clNyMWFjbGllY3kwMzNDcDFnRjhjakhXUHZS?=
 =?utf-8?B?NVhYdVcyTDBQb3RLMVJUVjJIcjlNa2VIMW9zOHc0TTJ2OGN5Mk9sbjFvVGNq?=
 =?utf-8?B?aWN2RmxUUEVEaVdJYS9xbWR5cGtQN2lzVkhGNHQ5WmZpKzNDMkl3cjY3OGYz?=
 =?utf-8?Q?dOgJGC7lMMYFxByz5OxLz6OTrRBv4FvU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUw4TjBXQlVCRDZqWjFkNW01amVuaVZWY0lHejZFVG95RmVEVkJyTlc5eXZw?=
 =?utf-8?B?VmJlTEUxU3RsUU1rM0VJdmdiT0NWNWJzdHZ5M3JiUnp5VzBxYk03L1FsclRX?=
 =?utf-8?B?aXpKRW1TRGRleS9rTUdQbEJpREJvRlNLajVqKzFCbVFkRndSSU1CSThhTnNn?=
 =?utf-8?B?R3diTjZKMjFrMFRjM0MwUU0zbk1uRnNDeFRmOEh4dDNSTHl5TDFXMWZBL0No?=
 =?utf-8?B?dnBjRk51V2xNT2VJMzNXSFc1eTQ4NG1JVGF6bjVtcnk2QlVDc05oSXd1WlF5?=
 =?utf-8?B?RVY3VXhJNTVzdC9iOWd3OUxJRFM4MzhuQ0x3Mk5HUzhjZ0I5c3lPRnJMYnAz?=
 =?utf-8?B?elloZGp6T2EvaEwxNUcwUmVmZGorSG5tbncvYkZlTkJUaHIwK1dIaWVLR2lY?=
 =?utf-8?B?cGd4cEdhZVFlUWJzM2lENGw1dGZYRTZJa0VNbnBPdHFPWE1tdkZ1S3MyUVRk?=
 =?utf-8?B?SHpnTUU5MGlLOTRodW1qMytQUjBWckxSZUZJK29qUy82MVlGREtSajdXR3hy?=
 =?utf-8?B?YTJwdDRwQ2YzK1JMVHR4d1lGcXYyUkJNK1FnQUFKZ2VKdmRxeHBWVHdKZ1c2?=
 =?utf-8?B?djVldm16SGt2cE9IaEhuS1R0bG9ZRHI5SHhtWDFFaktDbGY3b2xqdzZaeVN3?=
 =?utf-8?B?NCswYkJzOEFMeGxndWVQa2pYQkVQMlJqVUFiOWgzWHhYd1VGRytEUWdTOGZ2?=
 =?utf-8?B?UXl5dnNBaTIyTGcyOFViblVhWktBMjJ1WGVicnJzWDNkNXZJSzJXWjNVTVZw?=
 =?utf-8?B?ZVZGKzZBZjVZVzZOT1orczg1ZFpTMVZHZ2FtRUk2VmkrU0pBcDdwRHllOUNa?=
 =?utf-8?B?RGJOQlhEaXZlNHgzU1hlNlRNUmlWeTF1SlpYeStJdGtzRWtmcGp3TFNKeXpr?=
 =?utf-8?B?bGpublowZUp4WmV2MENMUk03OE5Vem42bG9PV2hCYmxmemRVblFPRjdYUnBo?=
 =?utf-8?B?V00yWUExTmM1RmdZZUhUazlOaEk4WmdMdGs0dFhuS0xOVFlJL3BRbHpWdmor?=
 =?utf-8?B?WU0wdXczcUxOaW1rNHA5S2poUU9JOUNvNzFxQlV3cjBpUFBnQlltY09rQmpw?=
 =?utf-8?B?Q2NYNUVRK096RzhEQkhxQkYvaDd3S2lnWWFuTW5xRmhiUUZhZlMwczFHR0FR?=
 =?utf-8?B?T21xUDlDa2RTUnp1b1gyRUs0ditsNkViTkpNZ1JsYjNrUkJFbDlHTHN1WFR2?=
 =?utf-8?B?MnRjRjU1T2NaU2FJckZJWFNHNnRodHQzTFQ2Qmp3c0YwOVpQZnNDN3lIT1FB?=
 =?utf-8?B?T1JIcitMTEcxQW9lOHNlclhvT29XeG4ybEVTR3UxUGZrdEdoMkVNNmllUDRo?=
 =?utf-8?B?WWpobEFxZ0dlVDFaOXZ5WWhGYjk2U2locHkyZi8rNVljcGhsWTk5L0ZDWFdH?=
 =?utf-8?B?VnJmekxXWEZRQVNUTGZrYXQ3ZEpMbXNLVmNrTlN2NlRKazU0NFE2YUhTajQ3?=
 =?utf-8?B?VWV0RDF5NjdHV2dyMmdqWU92UUpFazNDd0xxeFUrUzB5bUF2bTlLendTUnlY?=
 =?utf-8?B?MUk3bDUxY2FsZ1VaRlNMN204VmZaZlRWblUvb0E2RlU0VkVqemlNYjV0VGpD?=
 =?utf-8?B?U2NsWkFYVnhQd0ZJUEdOVnFxNForNE0xR3QxdVVzRk5YOEFYZkk0Y3ZyZm5x?=
 =?utf-8?B?ZG9GbFdTeE0vWEV6VTVROEt4NjM0RGI3TWZRUmlxTVFzQlp5VVhUelFOZ0FI?=
 =?utf-8?B?Z1IrRzRvNVpCKytiMXBMTTI0SzRxQTRlSVY2bGdqREFrTEJrN2FZM2VSZGlv?=
 =?utf-8?B?VzdCMU45a0RaOC9aM1YxcnFwTG5GYUFoZDUxNnVOS3hCZzZrb0VrN0U0M0xW?=
 =?utf-8?B?MnUvTnIwZkM5ZWw2SmxLaU9jaXY5OVg1VWFieVFseHpVOWpkaVhQVEZTTGJL?=
 =?utf-8?B?SlBGeDc4YTRKdkZmUEtqUzZySTlQYS93bjlOMWdwZHlBRWdWNTZJbEtZT1Bt?=
 =?utf-8?B?QzIrc0xtYWtkTTFHOHBDWWgwMHhRUk5tOFdreitQSi9lamwydms3RStkKzZN?=
 =?utf-8?B?VzlWQTcyQnNGQ3pnMHBzYlVJbU5jcm93WEUrQVkzNHRKQ1lYK3J1elMwOWlq?=
 =?utf-8?B?YkVhZkpJTjBiVTZSMWkydzFTNWtWa1dsV1VGR1BaQ2RxWnFnQStXNWxjZWxu?=
 =?utf-8?B?dFdGc2VVZ1VmQ21hQ1lRb2wrR3BabGd5U1djVUcyZCttWUUzV3p0ODZjRnR2?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64716925-9b80-49a0-f6ed-08de10c0f78d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 16:43:30.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8+SeTx9/T2T2imdl2hWLSLmfmA+4oK2Fm3ylDmmaffGWg0o8ZmUy2wW69g9W+QUP+x1ICi1GDMCWMyG0bc4wzlLUp7bZIUgs8eeofeGeRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8033
X-OriginatorOrg: intel.com

Ally Heev wrote:
> uninitialized pointers with __free attribute can cause undefined
> behaviour as the memory allocated to the pointer is freed
> automatically when the pointer goes out of scope.
> add check in checkpatch to detect such issues
> 
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
> Test:
> ran checkpatch.pl before and after the change on 
> crypto/asymmetric_keys/x509_public_key.c, which has
> both initialized and uninitialized pointers
> ---
>  Documentation/dev-tools/checkpatch.rst | 5 +++++
>  scripts/checkpatch.pl                  | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index d5c47e560324fb2399a5b1bc99c891ed1de10535..1a304bf38bcd27e50bbb7cd4383b07ac54d20b0a 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -1009,6 +1009,11 @@ Functions and Variables
>  
>        return bar;
>  
> +  **UNINITIALIZED_PTR_WITH_FREE**
> +    Pointers with __free attribute should be initialized. Not doing so
> +    may lead to undefined behavior as the memory allocated (garbage,
> +    in case not initialized) to the pointer is freed automatically
> +    when the pointer goes out of scope.
>  
>  Permissions
>  -----------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..33cb09843431bebef72a4f5daab3a5d321bcb911 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7721,6 +7721,12 @@ sub process {
>  				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
>  			}
>  		}
> +
> +# check for uninitialized pointers with __free attribute
> +		if ($line =~ /\s*$Type\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*;/) {
> +			WARN("UNINITIALIZED_PTR_WITH_FREE",
> +			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);

Looks good to me, but I why WARN and not ERROR? Is there ever a valid
reason to ignore this warning?

I would go futher and suggest that the pattern of:

	type foo __free(free_foo) = NULL;

...be made into a warning because that easily leads to situations where
declaration order is out of sync with allocation order. I.e. can be made
technically correct, but at a level of cleverness that undermines the
benefit.

With or without the conversion to ERROR() for the above,

Acked-by: Dan Williams <dan.j.williams@intel.com>

