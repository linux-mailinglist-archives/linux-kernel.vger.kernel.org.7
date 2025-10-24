Return-Path: <linux-kernel+bounces-869621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF8C0856B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B64E62A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7992B30E848;
	Fri, 24 Oct 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bz/zlChw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745222A817;
	Fri, 24 Oct 2025 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349409; cv=fail; b=J7Ou//16KMB9WLpFzgLzSjKf96cCPvmytj6WuuRZyGd4HULavxnnP0MFxKbLgKRmcL3g7Fc0bXS7MUX81J+0+my1PH9yCLU2pprAf/S2eqIFvONVCgeSUYbE7MG5BdEId0sw4pjB6djVAkbAG/C1zH4eZvlk5bMGAYK/TVCIcPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349409; c=relaxed/simple;
	bh=g4K1RkTCgPSRv8Vk+ahdnei8WqQfBOg8z4+O+MbKBG4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iKmVtcMvP4bpPFa84gSCBTC8zZdUrB8fWZ3+fjnqvtMLZQtBRb997E4Ty9+ijp9WHfv7tdj7fy63AzmNVE7ITuYr10M+hVStax2sXUzGJuotWPeVuX85RFO8I8BFrEtbZevWSZfpUael+EFP4sSZ+jSmOZJOPaFYSRgMKmv96C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bz/zlChw; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761349408; x=1792885408;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g4K1RkTCgPSRv8Vk+ahdnei8WqQfBOg8z4+O+MbKBG4=;
  b=bz/zlChwM5GtqPQ4XQ6YnURObLi+k+5G876Bd5fS2+ozBgSYZkAd+xId
   c/tQEQBVv8Im7QjyXW/DO1BNu9HlQzsoFdMhLV2hSTOjVPhQBGA3P4l7x
   GiPsdENOZ7clqAAVehNHxFkml0Sn1QxDtnbLMgLJeXLqbHpNzeo/PQZRy
   z2UejAywDlAbw69SGkVzarlNk2BTD+raTUsH1yV+AcMTUhv40p9L1MyE1
   SLs3DJ0bIlOxlydy69i0p0WsJCAT4LlNj6MlvC9Fz/k/Tw6fCXSbobCi0
   x+MCGeqbzL20z+1g9J2/4n4kEVw0Uh8GDIjYT6x+rsme3YGqGLhCgqcMI
   Q==;
X-CSE-ConnectionGUID: SVj/yjT/SBmBVnwstW0scw==
X-CSE-MsgGUID: /8YX2UwSTLC2mBvm9AM09g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51108846"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="51108846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:43:27 -0700
X-CSE-ConnectionGUID: AiNOygw2SeO/Own6/icC9A==
X-CSE-MsgGUID: Vs72aY8QRmGnMxfkxiE/Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="215456645"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:43:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:43:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 16:43:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AP7a6qOO27WSXo0+R+liwlhE1jI4bgcXeJHtcVm6J3Wcb0CRVDBCxzFxiJFdanYaSU8/QXeACgF99nG6QlM7MrQRjOrzp93PZhQw1SPQ79BYDtakZgWwm+dWKSPYXrIg/AQngumbtOW9T2E2hf1EjgPn3pr9BXTSfrfTzQ6SD4jNBr2yh9IroEAJc24WIh5RwP22B9FFnm0NVR08J1VI69m7ecaAR/X+w5+9QLZMX3IcsDZJek50miGTeunrc1xRUHzyoUHaG8mVLYR0pT+Jw7zvtXByyphiffsMctabvfe5enqMjPTQH+tTvRzhdNnV0hWjP3QD1+F18hE5JcXI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x3CKJUP57cAiDQszkQXMaJ7sRr/We8Eq7ANlHTcpes=;
 b=hoEvBkVpE6gUU7b7VtGLrhwZJdmMUBOWvqmsjQaNO90LqUJwDnv1epaE79hi3wAftyfGrIpuMRl4pRSHjlFRdGXXGNg4wo/G0jHhGmpIDVbMXuvyyg4rAF9k3Vt78pXgKtxFMUP17XbucqrwFWSorrdRpQJwTyn2FZmZ5Zjy8Jvlhx7iRDc+ZC+440JBiEJZ1W5x5fGH9Fpt9Y7KEY1nZlZm7fbcGOii8oeR6+gky+d1HvCTMKj98JevWX0qEMhcCE+j1YWbpWhyza3AfUIwoN+RT3ff1gUMGMBD0d1qGCCZQEWoST4ANYS6f/pXLEsqQ2fs1hI1TSP/8yKl/0PFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8554.namprd11.prod.outlook.com (2603:10b6:408:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 23:43:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 24 Oct 2025
 23:43:23 +0000
Message-ID: <b28ed9df-03cf-412e-b300-2b8499c30fc8@intel.com>
Date: Fri, 24 Oct 2025 16:43:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
References: <cover.1761090859.git.babu.moger@amd.com>
 <dd444497162c38f81858ba3b3f95c29058d38232.1761090860.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <dd444497162c38f81858ba3b3f95c29058d38232.1761090860.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 6547d5fc-ab42-41b6-10de-08de13571ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG1EaEh1Nlo0Z1Y1MzQ0L2lrUjlPZENkOWlLc3FLQ3hzeWJTQnBoR1E5MStp?=
 =?utf-8?B?MTUvUXZIUWhqRlVyWkdzL3BCRjBSaTB5S1RBL1AyUzg0VWFIWnBUT3RHbER1?=
 =?utf-8?B?d2dQUWNzYnpsMFptRXdzQkh4TzFjbE1vQ2kxYjZzRVhVa0NmZFoyaUVhUWVz?=
 =?utf-8?B?SWJyRWptYUlEcnFqRU13bXRzQU5CeUx3VzdxWGhYc0JMcXVIa3NYb1B2aitM?=
 =?utf-8?B?REpHVGhBc0ppdU15Q3IvZFRqUVZtQzNhelNIcnltUDJIUDdzbE1nbjRDTUFt?=
 =?utf-8?B?a2gzZERzN3ZndldxZlZiQllQT1diZk5xc3ZwMFF4WHkvd2pWMEp6cE80SFZk?=
 =?utf-8?B?dlRsRmI2UU9aajFnSU5iZW5iWGlXbTVndVZtd2lGK0Q2MG9CNkIwekJoYlZ2?=
 =?utf-8?B?d1ZpQm5sZEg3S0xVZFZaUDNzdHY5MzZwcktkSFljZ2FmVEkwZE1zWXh0VEZr?=
 =?utf-8?B?dFM5bVFvRGp3Q28raWNqcWxYRnZtSHd6dUFjU1o0dHpOd0RwRjV3V0FMcGJ0?=
 =?utf-8?B?aFA2OG5VS29YaDh1cjJMMXhTZjF4d2RzNVBoNDFyK0p5NTY3VkJYakxKb0tx?=
 =?utf-8?B?L01DYWI0bW4reFpkNTlCamZVWlczMEZMZlRwZUZweTUvYnlJb1hVTEdYd0RJ?=
 =?utf-8?B?SGlWQk1WUGF3aGtQV1dUTUJkT0xSdUFmZTZOV29kOEEzWDhqazJZTWFxaS8z?=
 =?utf-8?B?Z3JST3BvYk5nMytsNVMxTXVyUU5sT2dENVliS3crN3hTQTIwMEdvU2tYQzdX?=
 =?utf-8?B?VVpmT2REUjZidlg1UU9VNm5mbEdqL3dmTkoyNnZRQTMvQ1lOMEVTNEc0MGND?=
 =?utf-8?B?N3hHNmc3QmxjaDZDYzhoMlVpWDMrdXY5b2hQQ0RpcVZPUldkSlZzSXRTVjY4?=
 =?utf-8?B?RHk4U2xtYXRVYUp0Y2d4UkVwTGEwM01ldDNaRmVDNnR5YzNZbU94Y29LU0xq?=
 =?utf-8?B?YlJST21tdW1STXQ2ZnBjTUJhRXE2RGl5SFVONEZlamVBK0J0V2RUajZSUVJy?=
 =?utf-8?B?ak1KNTdpUWtVT0l5ZnU4NFoxVG5paUdJRXpWL3gyQ1NaakpwZFkyK09EL3VY?=
 =?utf-8?B?c2tTMytZc0FrUWhYV1FlMkN0dUJVNTBaKzYwTm9CMWE2TjJROVpQdGFJUUFh?=
 =?utf-8?B?ZDAwRUxGZFdITDdDcFRxa3NUY2s0RWovZVdlaFF3YjBhV3FrazhEeGRPQWYz?=
 =?utf-8?B?ZEptdEh5czRRSHRENC9CckJwMUxGV1lnVGpPTUY4WmFzdFMxNytJM2ZCSTh4?=
 =?utf-8?B?VExLbkNhZTlsdDN3alpLTlB3ZXNFMEtOaWhHbjViZkJRWG5uTWI3R1h6S2k2?=
 =?utf-8?B?dTNPd2NTaXZCeko0TEF1MW9sSlN3OEFIMTBSRVlsSkFHY0lTOWU5QUNENHRG?=
 =?utf-8?B?T2lYMVU0OUN1TUFtTENodEkvQ3N5V3FlSG1vOFdHWFV4aFVpaC9SaUlrdXZm?=
 =?utf-8?B?Qlh5a3lvV2xhZkxhenZPVngzNGVBaG1iMDRsUStlL01VdTV2ZXFFQy9zKzFI?=
 =?utf-8?B?Y25IY05jSU9ENWhFS2R6SWpCQnVRK1BMdkljMHVjN1FLRWlPTkpDQzZUdTNJ?=
 =?utf-8?B?YWlMNzMrNW1CMjB2YXRSWmhmczBHMzdlbkhteGxWRThhM1VQOHJKTW90MFhE?=
 =?utf-8?B?OVlhUytqZytxYTdZWmFuaksycVZkY0xiYTBtb2NxQ0szUFZCckZkMTRhWG45?=
 =?utf-8?B?bzhKai9GcS9idFk5UGVVL3Z0dlNxbnMzaEg1dmNPMUYvUXQ0TkpvRzQxTExQ?=
 =?utf-8?B?K1M3cm1yQ1ZaTVZMUFVIVXBrUlFLcTU2TURNVEM4Y25BSU5VaDVFSk5iRzVy?=
 =?utf-8?B?NXRwZXVrcFRHUHhiREJweVorVitJNFBic2dhNnRhTldBd2llVUFLbjdlYzNq?=
 =?utf-8?B?RWtBTzg1Y3NFSG5JdDltTGxUaDU5Qk45NFNKRGx6bEZTQXdBdDhGdDJvZjZq?=
 =?utf-8?Q?qji4SjOzgDS+gst5l73QNobAJOegDpGj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE5oa21CY0V4ZStucTYxelhlMjRJcnlBejJiODZKdisvdWZkSUNVbGdSTUVC?=
 =?utf-8?B?b0V5NEFXaGNhMGRZZ2thZmtJZ2JoMUZoazVSRkM4a2RpS3BzaHU1VlA0T1Zx?=
 =?utf-8?B?ejhIMUFWdHVUd2ZPdkIvYVNraFZrdGxrMTlBRmM3bitJV0V4UVQxRysrSTF1?=
 =?utf-8?B?TTE1ZkJjVHRNMWN5aXhNRUloL2ZrN2Fvd3c0YnRick9yOWFiQnVRcDRXazFu?=
 =?utf-8?B?dGx1dDh0MTNIbDRRNGtjeXpSZWZObTZsUjhyazFiN1R2eWlXU2RLa2NzT2ZC?=
 =?utf-8?B?OWh2a0p6WTA0NXRLOTM1a1ZVcEUwV095bDBFaVd3ZXpwaHF3dEdBdWxyMTh1?=
 =?utf-8?B?VDFpYnRiYm8xRXhiN21pRW5JeVZDMjJPZitUUEJmNVFQYlVzYjEvQjV5R3B4?=
 =?utf-8?B?N084bW1sVzdUakJMM3ZJaTNVc3ZzSFhNeDQzbkFlQ0d0N2FtYTl0TnJNWE5h?=
 =?utf-8?B?WXhzbjlaV3N2QnBlbVFKQW9BdHhnTXJqcXZheFRxM2c2NzBMRmQ2MzJuUS95?=
 =?utf-8?B?NWRxVUdLTGEyZEUyOVczb29CSXF5dE93MmV5ZXRmQlpOR3dHOUpQSE5xVnh1?=
 =?utf-8?B?M3JyS1NyZVBmNTg1aEJUc2tycTZadGh3TjJRbUFLZk1zQVdFbUpPcWRESGRM?=
 =?utf-8?B?eU5JcE1zR21WVDZCWFlOSHA2S3k2b055N3RrSXI1ZXZHMHRSbThia2lKcEhG?=
 =?utf-8?B?NWROeTJMMFJpK3Z5T2p6T05pU1JHNUcvQTdqOXZBcTR6N293U2ZnVC9ZOXow?=
 =?utf-8?B?d0Zhc1JTdXl3dWFQZVdjbzRxc0pDSys1Y2R3SVNlRUp0cElNQUo3TkpGMDY1?=
 =?utf-8?B?V3VGbk1YdTdnT1RzM1RPaFJyVHU3NzlJeTNmUC9kdDF1UHcxQWdIdjZ4aFB1?=
 =?utf-8?B?MWlVR1JJRE1ieElZZUZvOWVqTHZ3TFRWU1dBL1d2aENtOHA4TTZZYitacDRV?=
 =?utf-8?B?Wk13bVRDRUNvRmtzd1g2Q0JwSzhRODR1N09zRitBVzJEOThLekpJU3Q4S1hS?=
 =?utf-8?B?NGt3TDFsUUJjT1RBM3lmdHFaMHVPQkFvYW44Y1FVOVJxbjUvME1JcEVqa2M3?=
 =?utf-8?B?T2FRN2Rac2FkQXBlc2htTjhVU1F5QmNKYWJmRjZwTWtvWEpvdC9RWitPemRI?=
 =?utf-8?B?NGdJdVovSzFwK05GWDBmRTF5NEJpdXEwUnBsU1hnMk9XZFJRZ3J5cFQ4MHha?=
 =?utf-8?B?a2FkSmFCU1AzVkJ2MmJQS2RQaWdkTlBhekdrTHVIYTNBWWdLakd2YVg2Yk1P?=
 =?utf-8?B?N2FPVXFLZGo0VFhYY0pPTFBadTVEVVRwb2lmSjcxZmpvcHBQaEJGY2lFc04r?=
 =?utf-8?B?dVJmVHhQd2VENzNRYWpQQ0Fubyt4UUpkUktMQzlIb0huWDVaYmZNcEprS2FN?=
 =?utf-8?B?L3ZCNU5nV1h0bTArejR6SWVpaVFTVG9LVmNVQitNeFlIV05yU2pjS0kvOTll?=
 =?utf-8?B?cU9XYVRCOWJmWTFXOS9LKzduZE52TGJORGJ2eThFbDVOUW0rOEtwbGtOTmNw?=
 =?utf-8?B?NnkzQjQ3Nm9kTXJ6b29BdUczYjd4Z3d0b1BnUzF0SFRRbGMrQ21LVUNZN1Vn?=
 =?utf-8?B?a0d0VXRBSGN1d3hoNWxqTXAwcWxiSjNreXh1K0FUc0hsTTJicGtnWTNkSHBJ?=
 =?utf-8?B?V1BCN1MrcTVxV1drNlBiOFRRZTFla2tKUHM1SDRWNXE2MXFpdkpRUmNvb0xx?=
 =?utf-8?B?WWc4clkzQlRPVk1sS29YY2hFMVorUWpyWWFPOEMvTy93NVJJNXlKanI2OXRB?=
 =?utf-8?B?Yk1GNXZucnp2VUZFYzdLNTlyOWpQbzNkNXIvbFdKN2srbDNIQVI2UE1iZXM0?=
 =?utf-8?B?OXM2d3ZDUEZ5WGdEYzVoSVR4cTN4TGRkdEVraWZOMDdZbHU3ZWFsVGhBbTRJ?=
 =?utf-8?B?ZSt0UFltcWVDcWU1UEpjMUlualEwc2xaVU1XaW5xL24yZ1hpNFNWYkR6Ukkv?=
 =?utf-8?B?Vy94RFdtUWg1NW02TEtmVzRMdVdBODcyWjlHcEVHS3BCRkdVbDBlb1lER2ZW?=
 =?utf-8?B?OGhGU0c3bUN5Z3dKOXdjTi9BYlRaemdKWS9zclRVRFE5M29nWDlRZGhUdmg4?=
 =?utf-8?B?VjBuTU5aTnY3L3drMVdqMzBoMENNUTU2YXBGQ3Q0VS9kSzFsbytqYXlmR1A5?=
 =?utf-8?B?aktRc29zcGFZNEVnRWV6ZUl2WVhyUFRrWkdpRVFPYmF4Mi9VQ3ozdjc1OEJK?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6547d5fc-ab42-41b6-10de-08de13571ed8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 23:43:23.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4fsMTnwc2uiyz+qtLYa5u+3pIz/o5UcGsDiWqXLj0gPwO+vRQNfNuGDDsm5Cyx7UjREVnvdSZvvIkWddEmO9XVBTeJg8mC5ZIFoZvrVg7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8554
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/25 4:54 PM, Babu Moger wrote:

...

> When resctrl is mounted with "-o cdp" to enable code/data prioritization,
> there are two L3 resources that can support I/O allocation: L3CODE and
> L3DATA.  From resctrl fs perspective the two resources share a CLOSID and
> the architecture's available CLOSID are halved to support this.  The
> architecture's underlying CLOSID used by SDCIAE when CDP is enabled is the
> CLOSID associated with the CDP_CODE resource, but from resctrl's perspective
> there is only one CLOSID for both CDP_CODE and CDP_DATA. CDP_DATA is thus
> not usable for general (CPU) cache allocation nor I/O allocation. Keep the
> CDP_CODE and CDP_DATA I/O alloc status in sync to avoid any confusion to
> user space. That is, enabling io_alloc on CDP_CODE does so on CDP_DATA and
> vice-versa, and keep the I/O allocation CBMs of CDP_CODE and CDP_3DATA in
> sync.

CDP_3DATA -> CDP_DATA


...

> +ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
> +			       size_t nbytes, loff_t off)
> +{
> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> +	struct rdt_resource *r = s->res;
> +	char const *grp_name;
> +	u32 io_alloc_closid;
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!r->cache.io_alloc_capable) {
> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	/* If the feature is already up to date, no action is needed. */
> +	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
> +		goto out_unlock;
> +
> +	io_alloc_closid = resctrl_io_alloc_closid(r);
> +	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
> +		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %u is not available\n",
> +				    io_alloc_closid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	if (enable) {
> +		if (!closid_alloc_fixed(io_alloc_closid)) {
> +			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
> +			WARN_ON_ONCE(!grp_name);
> +			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %u for io_alloc is used by %s group\n",
> +					    io_alloc_closid, grp_name ? grp_name : "another");
> +			ret = -ENOSPC;
> +			goto out_unlock;
> +		}
> +
> +		ret = resctrl_io_alloc_init_cbm(s, io_alloc_closid);
> +		if (ret) {
> +			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
> +			closid_free(io_alloc_closid);
> +			goto out_unlock;
> +		}
> +	} else {
> +		closid_free(io_alloc_closid);
> +	}
> +
> +	ret = resctrl_arch_io_alloc_enable(r, enable);

I missed this earlier ... if enable == true then a CLOSID would have been allocated
at this point but resctrl_arch_io_alloc_enable() is not expected to change the arch's
state when it fails. io_alloc arch state would thus remain "disabled" while the io_alloc
CLOSID is allocated. io_alloc CLOSID should free'd on failure of
resctrl_arch_io_alloc_enable() to address this scenario.

> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index a18ed8889396..26ab8f9b30d8 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -390,6 +390,8 @@ void rdt_staged_configs_clear(void);
>  
>  bool closid_allocated(unsigned int closid);
>  
> +bool closid_alloc_fixed(u32 closid);
> +
>  int resctrl_find_cleanest_closid(void);
>  
>  void *rdt_kn_parent_priv(struct kernfs_node *kn);
> @@ -428,6 +430,15 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf, size_t
>  				 loff_t off);
>  int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
>  
> +int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid);
> +
> +enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type);
> +
> +ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
> +			       size_t nbytes, loff_t off);
> +
> +const char *rdtgroup_name_by_closid(int closid);

Could this please keep the closid type consistent as u32?

Reinette

