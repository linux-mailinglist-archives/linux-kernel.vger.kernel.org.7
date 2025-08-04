Return-Path: <linux-kernel+bounces-755737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E56B1AB14
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4989E7A12C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1218B290DBC;
	Mon,  4 Aug 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqsDlAjB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1E23B0;
	Mon,  4 Aug 2025 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348038; cv=fail; b=J9Wns58KmdzM3D6iDQRUN01hqGDRtCSfVJ+enU0u0qolI7M/BH37AYmdrscFmbxe3x2P93kFg67mGNJWVdjncEN5voDQx15tAMmoTay4PJ6AiMpLwnMc6Aw//6VNhFmXL1kJqahYUUasd/qLCYII/0zwksZoe1ODnookGOQ/udU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348038; c=relaxed/simple;
	bh=VNBZToaCYQ0HNGI/8L3N8UST7BMKFKn+RcxqqMfsBJQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NA1feQULfQElEITr4asdjTTvzUTTKXeBvthTPFdy0SykuCAm80X+12A05i15E6xBFyLw32UvOhXfEm8EXX0Lk6bbDW4usG2a5ydQQ3z9ErT7tsJ+Ajpz4baYAzloSmetehfo8VjPTTPww6Hfm/+rmQCAFAmrtp+VISg883gb3yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqsDlAjB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754348037; x=1785884037;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=VNBZToaCYQ0HNGI/8L3N8UST7BMKFKn+RcxqqMfsBJQ=;
  b=EqsDlAjB4kZuzT7R8T8/DHqPIvA5/315Z9/SA5XxItTI9jdIY6XZDKhS
   AJKtRDVRNl8QVVpZ/+Znfdu23xLQjFcoBK83l8FtQwvb5WMGpp+9Qloxv
   FJlPdA20Ni1+ZG/0gIKYMhhYKKv1wxaffKDsNYQeI3DZbAfBZs4vl+EbC
   yxwSBZXjRpc0Dz7Zl2fGRmYxSJxbZxd4VzJLtXbVZ2BIhN8qv4+TBV+Dt
   QSPD2sqOZOCdWCzTQa3fp7nkzznpaw75AzS+h42+yzrP1kPzr1l51p+t3
   qhng228ugLobEkLtr7pt6tAtg0RomfyaF+y7JCaw9vxxjw+AHU2mQFMte
   Q==;
X-CSE-ConnectionGUID: 9DKLx7u2T5S5jRBXzxDNow==
X-CSE-MsgGUID: kz2RzJpTS9OHLDM3hWdI0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="60458831"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="60458831"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 15:53:56 -0700
X-CSE-ConnectionGUID: yPavL2VfQl69LX96jZ7iqQ==
X-CSE-MsgGUID: HU+Zl4IoQZGcemiATUAvxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="164207536"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 15:53:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 15:53:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 15:53:54 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 15:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfmdasWGlMTaiIaWAi2A1kqEKT21CPvfJD+ApUogAhWHM/gA4U1lP9IszUbiCjcl+cAdu2/ES6u4YTbKxBlSK36cf8ucOvp5fkbWIMTix396eo3LB0koKNxDJMBnWfLx6Ei3LThVyuQ2g9TkpvWd3ztOpWHg2NfSpC6kywkhInWqLKJdZ8GO7SBtMIxDpjivhvEzDXmd0+n6DykWLbCSdOWLTudN/2kSEYfzTPfRMa4TOQ+G/F4HWxZAxzMqBL0FioRod1J+qr0+D2K6qJo8LnMGgpu3u0fH0lF+5xU83HyeHqbRNcdCWOxp/l44dTIpxZSOQjOCNa99puXP0Ly1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rhtii/TbRLt2ANZmgVOlHMRC+4dckV7L/Pj3PJj4Ryc=;
 b=qYnsxTMeKAHZvMCjgo8uUcZ9hgTN495+MJN2gTKV7ccrFUfV103fMGQWDc6B9i8xuiTDZW01QnCyvhptnEFyKFM2f94y0B0KQHASJ/GVw/onfSHZ471542y6TsQV3DPixBPq/lDS/v4x2iK4eE26E3uKw65Z7JVtlP2ZFMEBlWBdp3vLBdxZw3swDEgMc+PK7INp0uxDLlg9zGNLLNshUmSxddU86Zi1ZVB6v+bw71z9ZMj8Y00xYBu0TnGlC4KL4tld8ZBvpZrsd2RyZsowQ1Tigs+ZNkm6Cl5RvB4eK9pXFAk/fATggWXU67TNoBIaW1hpBkX2eR7xD+F5FwqtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6813.namprd11.prod.outlook.com (2603:10b6:a03:47f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:53:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:53:52 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 4 Aug 2025 15:53:50 -0700
To: Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <kosina@gmail.com>
CC: Sasha Levin <sashal@kernel.org>, Michal Hocko <mhocko@suse.com>, "David
 Hildenbrand" <david@redhat.com>, Greg KH <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <workflows@vger.kernel.org>,
	<josh@joshtriplett.org>, <kees@kernel.org>, <konstantin@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
Message-ID: <689139fe23f49_55f0910076@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250804181447.0c518b14@gandalf.local.home>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
 <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
 <2025072832-enrich-pampers-54b9@gregkh>
 <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>
 <aId1oZn_KFaa0R_Q@lappy>
 <aJB8CdXqCEuitnQj@tiehlicka>
 <aJC0ssMzX0KWnTkG@lappy>
 <alpine.LRH.2.00.2508050000580.22517@gjva.wvxbf.pm>
 <20250804181447.0c518b14@gandalf.local.home>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0423a6-2fec-4a49-3500-08ddd3a9c869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUJ2L2EyWUtkb1hIMlZQcEMyS1Q4YUtSckg3NURDQ3d3SXRXZDhINTAvWU4z?=
 =?utf-8?B?YU5mblcvR3V2MThtcWtzRk5JNU9QRjNvbU0reEhsZnhkejNCZmhKQVBLanZv?=
 =?utf-8?B?Y1Z4ZXRyQTQwVlh1Y0pLM3ZKQ3QyRTc4M1g1NVRqRVdBU09rZDJRTU5YZUNE?=
 =?utf-8?B?MVBwbWJZa1pDbXdMNDJOVWdKK1FQVHE3VlNJZlh3ejNGeXc2d0gxVUpLODQ3?=
 =?utf-8?B?SUtac0V1TFJuM0QrcDg1TzM4aFlQSXdadHFsOFMreE5sR0tWeHB5b0VyaFNE?=
 =?utf-8?B?UUErUkZSRmxleEc1TElkSStNc3RmNXlIeitoQS9wNlQ0ZDVwdVBhS0VCUng1?=
 =?utf-8?B?NTd1c3UyT2FpZjNMUVF6RjN2UnZkZy9mY0ttUXV5b2gyQlNjeDdDU1pqSURL?=
 =?utf-8?B?a01HMDBYZ1U2TUpwRjM5Yjl6ZU1LNlRWM3g1U1pIMC8wUjJSU1JWdnRBR3o1?=
 =?utf-8?B?d0kyY3VvWm9XazlPNC9lRHQzNTUwL0U1clUwc0gxOTJCTXIwam5SVjkyYnhQ?=
 =?utf-8?B?bU9NdkNERVVBbmxWSUJRMEZZUWJVRDVSbXhhc1Q4Q0RNTnFSaXg4alNKLzZh?=
 =?utf-8?B?bFVaZ0w3V0x2TTdQcDBvM0JCcWhkdldzV1hONGEydGF6enUwNEk3d2k5SDRx?=
 =?utf-8?B?L1FvWFhDMmpreVV0YzJxK2dLZHJmVWY5RkI2dThMVUV3S08xQTBiVWxSWWhz?=
 =?utf-8?B?UWMweHNGWGRZYXRTallrcEFrZGpSMG4vVmlIQzZoSzY2UjFpVzkvK0NxSzVN?=
 =?utf-8?B?WUs2L2ZZNVdMZkNOTEQ4cG93WkxOa2Izbk9Rb1ozNFNMcWtSTWhYdDVDNW5X?=
 =?utf-8?B?SEtxZEpqMzJ1bCtPS05VWlQ1UnV2U25XQ2gwMmtZS05KWmtPY2VWOGxEaklR?=
 =?utf-8?B?V0k4djVLYlN6MDJ2cTdDQjExNE5yMjZkb0Vya1dsS1ErcXdocm9LSnMxVWZ4?=
 =?utf-8?B?VDFPOXBKNFBKbzJnck4zUnpuY05xL081dXprSjA5T3VrQ0ZnT00xMWRQamI4?=
 =?utf-8?B?bkc3bVNQdXMxbWpqT2pSYWN5U2Rpb2FaalU1dkxLdUg1c0E4dS9yeEY3ZlFN?=
 =?utf-8?B?Uk1VYm1rZy94NU0rMXRPbUgxdXB2ZENEbEJ3QmRGK1J2YkkxaGRFVWtLSktl?=
 =?utf-8?B?MEYvaXgvSDhXUUFhWXZEQzJaTkpjZ3hwNWJPSW5Rby9pSEJVKy83TE1lbmwx?=
 =?utf-8?B?QjM1ajJvK0c2MTV5RWcweDBVeG1rbGJuaUFsbk43M0hRdThPOE1SOG9DMU00?=
 =?utf-8?B?QVF3YzBMendaVG9acVp4OHlCVXBUYnlOR21tZXVvT3NObHJTMTUrUjlNZXZm?=
 =?utf-8?B?WGlRSDhqWFowVFZPc29XemRTdnNGZFdGNm1Ld2RNRU9zNDAra0YrRnNSamlY?=
 =?utf-8?B?UzRRdW9LR1pWU3lvK0wxelJHSDRHcDI0a3JyakRjRVo3c045R3RhYjZWVWFr?=
 =?utf-8?B?TjRMQVNmU2ZsVkNUb3VuV1F6ZE5sNG0yY3AzcWdUdE96b1Z2VDJXNkF1aDZn?=
 =?utf-8?B?Y2s1TnJ3VkpoU3JNRnU4MGFzSzBJMlVFanJYcjFmVFJRajFxd3N5RXBVUENz?=
 =?utf-8?B?QmlPZzlHYjdMOFRySHdUV0o1VE1XVk1KNWlQMThrN0s2Rm5iWmkvRjdEN1hx?=
 =?utf-8?B?d2hNa2VoM1dsejJ5RGpyL1lXbm1oWU9JaUhvSUpZa2NvN01aYjRsbXp2SW15?=
 =?utf-8?B?dDhPSENUYXcvYWJyQjVBcUZTdUYvOGpiSUZhTDFpRDU5UnRoSXF2VjV4QUYz?=
 =?utf-8?B?blYwc3NFZ3NVNU1VamFERVZMV1gxa002RUlyZW55Sm9ZQW4vL2p2alhicXpH?=
 =?utf-8?B?UHAreW11N1ZwZlBBMXFkcW1JYUd3am5COGRnTWJRSE80bUt4amJWTkhBcmRH?=
 =?utf-8?B?bTdQM2xOcXlZejJCNGRiQm9LUDlPaUNCUHFRL3pRTkYxN1dYRWxVaGlmekdv?=
 =?utf-8?Q?1PtFQf+gUWE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVDTVN3aGtqR2RzU3I5clp5SDJuUGxIalJCajhWMmhRSDQzZlV6Q3FhZzNL?=
 =?utf-8?B?cHhjTzVSbXduTUx5WmtUYlMyTjB3dy9uVWJqWk1zb0ZMaE0xZW1vWDc4aW9a?=
 =?utf-8?B?WnpRWWM1S1h6VmNvR2JNZVRqZjBaREZvTmxZRmMrOFI5U2poMG41Z2NNSkVN?=
 =?utf-8?B?RC9DREFNdTMrRWYwM0g4OEVIOWV0SmJDdTdzZzkwUk9oQWlxL1hkK0RhMmJs?=
 =?utf-8?B?RkhKcjRGa1NVSHdadmQ1NUk2UyttZWZLU1Z5bUZWOUkvUGlyMWxQQW5uSnFV?=
 =?utf-8?B?YWkwcitiMVRxOVRBd3JLRDFIcHlTa0c0VTVINTdOYkwzZGZ0VCtsSnkxQ1NC?=
 =?utf-8?B?bXZuMWsvaXNRN04vS0JONW1QZzB5YnJaeTl4U1NHQXB0bjNtdTBkY3doMk5P?=
 =?utf-8?B?aytsVE1Ga2tPcFBGOWxJRTducEpyTmxGLytmL1NHUDRFUDJhVEpxOTBydjFN?=
 =?utf-8?B?TTlPclBhUzREdmladFBmdDlvNkxGQ003aGRLWU9qbVJHN25FdEx0d0NJc1NV?=
 =?utf-8?B?M29aeEREVTNGREQ0MTM2RzNiczliMFcxUDR0b1RCd2lvaTJjMFlySGpoZGZW?=
 =?utf-8?B?N243WUs2eXgxQmdieEVrQ2JXYlJPL2MxRHU4TEo5OXp2d2VSRXd0clRKQ3Bo?=
 =?utf-8?B?NHVhOFBqMkM0RExTd0pQUFc5RDUwNnpuUTNiR21uNnRaRi9uUit3Wlg5alRo?=
 =?utf-8?B?M0wzbC9MOWdwdWY2eHJSdm9naFh4eXMyZHZmMmozZTVvZ0M0ZFdjNHVnTmtw?=
 =?utf-8?B?QUtsOVNzZW1VQWh6cnV5RWl2ZHhySTdIdEtwMHBYc1BOOEtYTFNZdkZXUXda?=
 =?utf-8?B?cGNrTmJvRjFwOFdLaCtVNWgvY25hdGRaMzcxUkVla0hCN2hBd016NHdQT0RI?=
 =?utf-8?B?YzdnUFZiU1RZSGQwazE2OVdzdUtXckNtTkRaT3dJWUhLVklNWEtVeDhVSmtW?=
 =?utf-8?B?V2VZbzdva2d2ZkdLWWxjZWFGcG00cTMwaVR1Q0llRVJVNzd2RkNMZ1BIUnRD?=
 =?utf-8?B?RGoxZG5wQUpXREN4VWRKWU4ySjFqcXNWTUJDWWdMUW9kRHZ3VXVaZENaTTJM?=
 =?utf-8?B?dUExd0VKTVdzdllENmVSZi9WWFBRQ2JzSTcwM3dPYXVpejRUWDBkcTB2cHk2?=
 =?utf-8?B?Q1pzeTFOVWl3d2lraGJybUJpRTcrWHg5Z3pvQXNjK255QWNtSm1teldTcE14?=
 =?utf-8?B?Q3JGUkZoVTh3QzIvVDJrdXhJSEh6SmdXQmxwWmE3bzY4SkRNTHA5OG0yTkM1?=
 =?utf-8?B?dXYrZFgyUFBYTDEwWDA4b01sclpZSW1XSWI0TnlBYm0zUDFrT0Z5L0FvQ2Nw?=
 =?utf-8?B?VmE4STRLS001dFNudWs5WnhiYkYrMU96STVPU0w0SXRmQzh3YmFoMUVXUVJ6?=
 =?utf-8?B?anh5SmpOck0zY0l2THdTQVNKeFJMUHJpeEVFaHFTdU5uYldNdkZNTlY5T0ZH?=
 =?utf-8?B?ZFZyL1pzbXBhUHpWZ0ZEbHZQTk1ZRDFpTHpVaG1TYTY4NElNQ0t6TnFCc3lW?=
 =?utf-8?B?SUpsckw0K1psTW1hM21lUHdrTUpZRExYbjYycC9OZ1RWcVZhdXg3Y1Q2aEJj?=
 =?utf-8?B?RzZUNTVLS0k2LzZVOHg1aHI3QlRQSzNZd1E5allUaU9jTzFmRUR3MXRVeW93?=
 =?utf-8?B?aXA2cVBPaXY2QWxZUmx4RDY4QW1TTUl6ZXp2eGVrRVpIUERTMGVXOFRwNG1k?=
 =?utf-8?B?dE1Qc01xckdaNWJFUUxOOGQ5a1FBZmlHL0JUQS9Nc1VOd0V1MmQxSGFxVGJS?=
 =?utf-8?B?OEVQell1WTlTd0RvQjl1bjQ4bTJ5L2tUNkdtWGxZZWpLYUdYTXdmbHZXdm1l?=
 =?utf-8?B?QXhRdTFnVXl0ZXVaWUsvdnJrQkdrWDZ2RVphYWlmSXg0R3pCSWMvZlA5Tmtx?=
 =?utf-8?B?SmhHamU2T3ZyZEgvdHpiNEdyUWFWYnN1TXVLNlJEQUN0eHp3VjVGUjdMRHFD?=
 =?utf-8?B?Zk4wQzFRbkZaaUZCWU9mSnlab083TENXcHVaaHJqc2xrY1VRYW1vODRJVzQ5?=
 =?utf-8?B?NmN0aWwrRm9vSkduSE5LWUhiaUVablo1K0lRSW5rSVRGNXd4YnZvWGRkT0Zk?=
 =?utf-8?B?K0pPMHFBbEg3OTN0UHlpNmx0eE04all3dmFhRmRPdjVPWlZDMHphSVhvRVdS?=
 =?utf-8?B?MmV2bTRDOE5lTUtOa25aaERDbmtsWXRpdlMxSi9oTGVGY0xpVHdybnYxUEs1?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0423a6-2fec-4a49-3500-08ddd3a9c869
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:53:52.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pE1+EIBxTU/KHUtGKZcqIra6wOHfll2vHETC0r+LuU84tM6EdFiUrCDb89WzavtWunwYVah9WunVCYJS/iGSKqWj2itvsqENfL+xoVVSERE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6813
X-OriginatorOrg: intel.com

Steven Rostedt wrote:
> On Tue, 5 Aug 2025 00:03:29 +0200 (CEST)
> Jiri Kosina <kosina@gmail.com> wrote:
> 
> > Al made a very important point somewhere earlier in this thread.
> > 
> > The most important (from the code quality POV) thing is -- is there a 
> > person that understands the patch enough to be able to answer questions 
> > (coming from some other human -- most likely reviewer/maintainer)?
> > 
> > That's not something that'd be reflected in DCO, but it's very important 
> > fact for the maintainer's decision process.
> 
> Perhaps this is what needs to be explicitly stated in the SubmittingPatches
> document.
> 
> I know we can't change the DCO, but could we add something about our policy
> is that if you submit code, you certify that you understand said code, even
> if (especially) it was produced by AI?

It is already the case that human developed code is not always
understood by the submitter (i.e. bugs, or see occasions of "no
functional changes intended" commits referenced by "Fixes:"). It is also
already the case that the speed at which code is applied has a component
of maintainer's trust in the submitter to stick around and address
issues or work with the community.

AI allows production of plausible code in higher volumes, but it does
not fundamentally change the existing dynamic of development velocity vs
trust.

So an expectation that is worth clarifying is that mere appearance of
technical correctness is not sufficient to move a proposal forward. The
details of what constitutes sufficient trust are subsystem, maintainer,
or even per-function specific. This is a nuanced expectation that human
submitters struggle, let alone AI.

"Be prepared to declare a confidence interval in every detail of a patch
series, especially any AI generated pieces."

