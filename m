Return-Path: <linux-kernel+bounces-787334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA1B374CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C103362EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178428C039;
	Tue, 26 Aug 2025 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDyHQKqv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416F1A0BD0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246445; cv=fail; b=knxFsK4x4/LXjUcukSTTNyJd+t93P8vT8JuqzPvbkhS4cl9RVtIXp6tlTR7AO7hcO9jB0Rlr/dc1VCy010Pknm/DPQohBi32H2+HFjPis7nyF75nm23Y216ZVCoeYbqJsi0E/+yKtspUN8eGDyDKw2A5w5ZPDh9vv3VmO4nsAuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246445; c=relaxed/simple;
	bh=bwZo7ibR6QtsiGDwAhVfIcx+TOHxbaObaT4KsmNZqI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fKzXXd9pUGriccAkxot7Jec74j30MOGSYxYzkztNu6sd8csFosmgfecOTBqmt2GgmBySm3zUsuMUPKekXVrxMPMoWz8Xy5Cqg1WzfdEsadzdJ+MYZeXOUuQK85FtC7lfATzVxCAWs/NWTFT2iv0d9CjYy3aFK3jzFz2WA5V3lkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDyHQKqv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756246443; x=1787782443;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bwZo7ibR6QtsiGDwAhVfIcx+TOHxbaObaT4KsmNZqI4=;
  b=oDyHQKqvUwIXUkYLg9J87uaFZ02EpmX52DIrvTLUVc3WnwMZYEfuhJF1
   YWoFXBF3M2YjbItUNUf20TOkszkfeLfu04+qJj46PrYBMShk8SmGFEDxx
   5QIy88hwclsT3979CcEf/6t9PfsEisk4g2r2XPJ3M+IXzHGvGe+lcgw1m
   DXJjvV5rFB3JpWHYJiiqlu4XGARNanABsy5DuyMsBsdULwsI/bRFsjWai
   NU/8KlRNL23Mzq85ThBwNkIpjbL0yzoq75IE9jzF/fJTQxitWLSLghYWA
   hjXuQm/kKqR2pU0DWms+9jTWkzrff/kvRqBf9vGTHM4TB4ubGKpXxSUo7
   Q==;
X-CSE-ConnectionGUID: T699THJBRiq5tmdzkSRq7A==
X-CSE-MsgGUID: h+PQSUITRq6GnxLolYp1zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69210750"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69210750"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 15:14:03 -0700
X-CSE-ConnectionGUID: Xzg7hdq+Sn2f7Urw8ov0uA==
X-CSE-MsgGUID: 6M+ioTuzSGaayCnhiZ5kGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168976807"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 15:14:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 15:14:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 15:14:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 15:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYtI0EMDukWe17dJ8tR/pDjhniopWsRhc7oSgJwZwDtiynpcx7JejF3iIbE0XwAfS3Xt/pIlD+fC+Oua4UpKp9z47IYgM8rTPfYwttz/E39zYi2HBnw5lxWI/CFX4xxi5IGzwz1oPfcICA0UExGPzzbZnbBy2BlfVPhHXrirFLdIrMPdhhiPwcH5L13fWJw1piJGrPWv4sQ8hcL3bTZq7Bbvgn5MGou8Aprzu7BlaXss4AN8k+JsGxp1DN9a1Lnt6KmsL0Ovb3deeaGZxqF6vXqBI3dWb5/jmNxrk7KClkDfc/QA4uFZWv/gkB46zHaJCZT+WGYK5gkm2reTBQDDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0QrWN8HVADY1sa4l+XYR/BUwBNYPPWIbPjR26RHbwY=;
 b=C9aw5R7pkohmxHRRTJZSOqcfR0AehwINZGlqUzFJm6n2Q/5BGcbQfkqz6/PIDEJRmmh+FdFJqKmlR721UQkVDwEacpsM5+m1O3mQ3u67uOFw2uzgOeYmUiC+72moSE+NHELwtSbrLXnqUaOZE92GXh8q4ha3D3V4z6PsuulhGWkPqLCkqFFc5wYPlDWb7OPdwWEDS/JkHRU69fWNWmGq7fmMAhO9TQLiFt9VLYHTUm8vI68QhKOS2TQ8t/xuKI26CGvB9RFqN6EeFYMGEVZgU37ptpCl4lzH/GeKjhwVU5pc7ObyvHImVeFYj0Tm8sxY3zzRhLmhakSTStV+9TyJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH3PPF37F43E35D.namprd11.prod.outlook.com (2603:10b6:518:1::d16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 22:13:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9052.013; Tue, 26 Aug 2025
 22:13:58 +0000
Date: Tue, 26 Aug 2025 15:13:57 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<chao.gao@intel.com>, <abusse@amazon.de>
Subject: Re: [PATCH v5 0/7] x86: Support for Intel Microcode Staging Feature
Message-ID: <aK4xpRtQUU47tidf@agluck-desk3>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250823155214.17465-1-chang.seok.bae@intel.com>
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|PH3PPF37F43E35D:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8b8c45-e9ed-4f3b-a01d-08dde4eddae5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGpTWG1Zb0R0YU1OZ3YrcDBHRGNKNXNuL3M0SE9ma0hrbDhLZWNJYUtCNXdx?=
 =?utf-8?B?QVZvOGdZR2gxQkQ2VXhrdm5YV05tZzViVThDTnJueGx5TFE3Vkd6MHdTdzlt?=
 =?utf-8?B?Y1ZsNktWUzBkSVlZU3pWYXdVSysvVUM3UDR3ZlFHWDBmbDcyalBGaDN1TjJ2?=
 =?utf-8?B?cU05U2VTMUZ1ZzJSaDIzaHdSQW54TCtkK2tTeC9QQmdBL3VEVTBLQno5Z2N2?=
 =?utf-8?B?K2IxN2xrU0dEcElMdDBCaDhJVkhjMm1Wd3NnWVoxc2JkWUZ0SlJkZTlZSkVz?=
 =?utf-8?B?T1VaZzVqZWdFUjJvRmY4TjdjR0xxaHFqc0Z4cGNrU1dHa3RCdnV2aFdhSmsw?=
 =?utf-8?B?blNwOHNZY3VheVYwd3dJOGxaTldHdXBFSnR5bFlSWk5Cem1WL2FOcTdRV0V2?=
 =?utf-8?B?ekZIL2Uvc1dzWndJYmNHNEd4NFNuK2d6WVFoL2FheTlNdVJLbkR6UlFEUy9B?=
 =?utf-8?B?SWl4Y0pwdEZrUlh1UkJhMXlqZkl3U0RIYWhwUjRaNDB4TUJVWU1DNEJDejA5?=
 =?utf-8?B?ZGx1dTd5M0hxa0lYNnByYWdpdUNQdU9GUy9GeFpSc3RZa2p6ekF5blBYRzdo?=
 =?utf-8?B?VlNZb3Q3MFVpdGVKWWpjL3k1dlNYbWtpSW53V3NZMGY2SDVEbWZRWlZQNlA5?=
 =?utf-8?B?UFNoem1XdFVub0NpNk9QRURQbGpnVmt3VjJqS2NYaUpOQXFOS0JyZG9IeXpC?=
 =?utf-8?B?blc2MGd3ckg5TnBrMmpNRFVzZjFMa2h1SW92em9tTFhDZTFobjV1c3ZlNjBt?=
 =?utf-8?B?NFdSNFI5T2JNUFJEM0x5OWFuVGRZMmNWQmRzcDZGbGxVU3Z6cjh2K1I3R3Fr?=
 =?utf-8?B?eEliNFpuTzVzbVJiWi96UlhIaVhUMGZKeUZHWUptTE5mSlpOQy9GQ1Bla0x1?=
 =?utf-8?B?VDVxSUcwVmtNTTRXOUM5YlNoOW8zNWQ4U094M3FDbTFTMVAwdVoraWplQnR5?=
 =?utf-8?B?M1luSklMQW5OOTh5eTkrQlJxZHpCMWxYMGdUclY3cGtjQVBCdGowMytRY2pW?=
 =?utf-8?B?ank5bUhqQmJ1NGpnYlh2RnB0RGtyRnF6eWpwZUhXQmhrMDhOU2ZuRnNmZFp2?=
 =?utf-8?B?cEkzZmU0TUl5bE5Ocit3MUwrUjFwNVBLeFFhdFFjRHZPNmtLN2NTaUVTVmUr?=
 =?utf-8?B?cVo1alNLSEIzdy9ielFBdzhrQXRsUU9FckUzcjFLTE1CZmIzV09KWG83dEZr?=
 =?utf-8?B?SFJTcWVQeDNjYU16MzZkN3NORmxLS2FPYTBpWUFKdXZDRWJJSVp1RVlDQzRX?=
 =?utf-8?B?SDRYL3RZVDZPVzVpMnI1ckR3NFJEUVBsdjFOdEg4SU9YL0xvcjFTZmw5SUM4?=
 =?utf-8?B?RHM3ZmhnNnRSa2doZ3pxVXBrejhOUHQrVnhDanlzYzI1dDNXcndhK05FYVpr?=
 =?utf-8?B?Z0tTTHNZNFo2L0k0eFV5dEIyTUFlOTVzSDlqVUhWNXVIVjJWa1V3MDM1S0k4?=
 =?utf-8?B?WnRTR2RvbmtoZGp4eWdMeGZZOTBPOU1hRzRqcmtZeWFBbngwaGdON1FXVWh5?=
 =?utf-8?B?MTZwQTZXRy9HOUpYQmtHKzloV3QyQ2pTNWZuSjdOSGpBaVZjTlp6dGZKTGJN?=
 =?utf-8?B?TzdhbFk1ZWF3TGN1UDlrMHdOZTR4MDZNRmpuU3VxaFIycnkrNnB4cUMxVmhj?=
 =?utf-8?B?UWxYajIrNDZCUWgvbGYyVERIdXJMK2xKVlJLK29sQ1RwRjJSOWx5c3BXRnp5?=
 =?utf-8?B?U2phVnBNcVJydzkvR3Nkd0JxN3dHS2VwcXFqdU1PMjhaY1M4QVJGYWMzUlVY?=
 =?utf-8?B?ek5PTlJ1bm9rQm1rREM2c21SQkl5alNIMkNqenJSQmx2d1YzQ0I3bXkrSFFM?=
 =?utf-8?B?L3NZbVkrNWJYbHk5aEJSeXVza2ducmtKQXlyZ1VFNlBNaDNxZ2NJVHdLOEQw?=
 =?utf-8?B?MEhzUWZTQi9XVGdZRTN5TmZ4UktUbkI3UWUwUzlLWWNPVTcvZklNM00rODZR?=
 =?utf-8?Q?QLQpRz0IxiU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MytkNjB4N3lNUFNRVHZzN2RxVGtja2Q3TlJxMmFTaWplY0owRm56RmJzVkpU?=
 =?utf-8?B?Z0hpeWRLV0YxY082V1loUVFKeVpNSnJWZ1dud25pZHlFcmNCRVBvcmlySVJx?=
 =?utf-8?B?S0pFQmNXaDkyYVVyMnV0OUZySEloN2Y4RnBPV2hva05QZTRvNU40STJpSnZt?=
 =?utf-8?B?bytsLzJHdVMrQXpVNW5oMzhQK2NGejBmL3l6Um5kamVva1Z4YVZaWXI0Y2Fn?=
 =?utf-8?B?TEduK3E1QUtWenBiZlhSeW41bXR4TEdKRW5va0tuNzBiTFVrZG0wM3dNcE1h?=
 =?utf-8?B?RW5wKzRLMHIwZ3pXTE5DS2ZudmtkZFJ5V0lzbUVMdFZkLzUyQWIzdVNUT290?=
 =?utf-8?B?NTltS0pnYmdvaU5sWHNqdVVaaEVhZ0FxV2p0YVF1Yy9HNTFUdnVYTHpoTXJi?=
 =?utf-8?B?c0xBUEZvWERCRGZ0RkNYc2cwd1YzeWprbVUzYXAzKzZhK2xSTjhyTG5PMFpZ?=
 =?utf-8?B?UUpkT0Jsd0pIK0hyMnpTZTF0WGFRNUxHVm8vVTFvR01KZC9sUGxpV0lXeGJT?=
 =?utf-8?B?S1JuVXliV0RVWDAzZ3pYZzlLMlZnRkgvYTRjWnpiV1UydFRsM2F0QWEyOXVx?=
 =?utf-8?B?eVY5RndkTWoxSzZRSlZUMFc3UlBHUWxVTDVtbmM0ajFoSTBZSEFNeldFNDBD?=
 =?utf-8?B?Y2Uyc0pwOVF1d3Y5R1liRzhaUGR0U3NQRnNXSkdhTTErQUNKN003Uno3eHJ6?=
 =?utf-8?B?TlZCSkhMWTNlNmlxSUZ3aUJOam94TjJLcit1OUFIV0V6Z1JEWGZDeDhnWXJn?=
 =?utf-8?B?aEY1SVR1emxpUWZoa0YxZkVaWEt1aWpSem9uVVAySUZ0cm1BRm8wUU1IOXVx?=
 =?utf-8?B?S0piYVpBRkFmMm43dmZYN2VOcWRFa0swMGkzZlEzbGNmcm8yZEtweW5TTVhR?=
 =?utf-8?B?WXZNcExaWUxJQmU3S1FlOUo2Z1FCZzBzeDZZRkx5ME51bitlU1h5UEVWemxU?=
 =?utf-8?B?QW1rUWVQcTRxdmExZlRxQnBuRkJQVGQxU3dYeXloanFkWS9rWjNZZVhRbVY1?=
 =?utf-8?B?UW5udlhJMHBGWlJnNVZKWGZCS2g5ak1xUU5rS1hiSnFkRnVRK2htMWcvOEF1?=
 =?utf-8?B?WjcxaU9QWFpYTmVvY0syZG9iRkhFLy94ckdIL1pyc2JhMzBnc3p1eE1uR0JR?=
 =?utf-8?B?ZTY4dXRwVVR6TEQ1cVVxZGN1SVpiMkJjb3o1MWhneEVTQm5mRysxVkpBbkJa?=
 =?utf-8?B?Nmc1S1Z1YnkwQ29OSWFhMEx1SWNUMXF4QW9VdFJiZEIzOHNpQXBnaDBzS1VQ?=
 =?utf-8?B?bkN3cWE3bXhOd3U4OW13NWZ2SkJBaUQxR29EblFIZ3dMYXFKODU5ZENTWm9n?=
 =?utf-8?B?MjVLZzJjUmErVW1WVjRZSUlKelZXUG40T09CWGQ4M3FxUjltbWkzVVFKRWl2?=
 =?utf-8?B?NitZVkh5T1V3UVFwMTU1YW1EcEtDMEE4SUtvL3IwcHRPNUpNalVXbklhYVFs?=
 =?utf-8?B?NFUzMDNGL2dkRmFNRUM3ZWU3L3hrMGx5WFJ6d3FqYW9lcUV1R0pqako2Sk5K?=
 =?utf-8?B?RGdhajZlM1liMXlmUU80MUV0SWNFSTBtQ0tjK0J5M0FoK04ya3psR1FxZUhC?=
 =?utf-8?B?VEhVUGtiaE5BQzBVQk5rL2ZMdTNHY0FhSzVpZG0vRkZDUkhRVVNPQWNIWDFF?=
 =?utf-8?B?MmFhb1BjRVBSU0dJS1N6UC8zTlAyR3lDTlM1TXdOUjhxdHEvUW01dDl1aVAx?=
 =?utf-8?B?Wk9HalFLa2J3ODNFQ0JDWnNOV2pCekVuVWpYVHNUbGVlOTdLOFdkWDNzV1pj?=
 =?utf-8?B?T3VLWnNQMUIvekpJMHgzOVZOY1ppbGFKRFpsWTI1VmFEa0tiYW9ud2pRK0Jh?=
 =?utf-8?B?dWUzKzNscEZJQ1BCZ3hHaExlL0ptc1VTT094MkNDU01yYU5Zb3hjN0Z0NlUz?=
 =?utf-8?B?NU1lV2VwTnFBUjZobHVhTDIvMm84SHFJSUFXbW1jTGxCZmlrMXNPY1dnZ09R?=
 =?utf-8?B?WUczTjVORzBTb2V5RGtMY2VPaG44S1p2UG9PdjQ4ZTMrQUgvbHBxcVNhNnhF?=
 =?utf-8?B?RUErc2hMUDdVbEl1ckhzaW4yTUQrRUJLdHllUlVpUnBUd1RaQUEzcEEva3k0?=
 =?utf-8?B?ZlFLZ2tZK2lNbUR4Q2dhc0x0Sm42SlhSOENpSnVmZ0VXWE9Sai81RVIwU2xN?=
 =?utf-8?Q?cEV95fQRzbwNhei4dih4tfKwH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8b8c45-e9ed-4f3b-a01d-08dde4eddae5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 22:13:58.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89Ow4tgKLsIRIUtUK6Je5/SCYJ4QgWL0wbdGwtF+8yeC8uxMeIw0N2K1f5IhHF0ZYA6C4JmTf7w05to0Z01vRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37F43E35D
X-OriginatorOrg: intel.com

On Sat, Aug 23, 2025 at 08:52:03AM -0700, Chang S. Bae wrote:
> Hi all,
> 
> This is another iteration -- changes since v4 [*]:
> 
>   * Reworked the preparatory change before referencing
>     cpu_primary_thread_mask, based on Dave’s feedback. This is now patch1.
> 
>   * Incorporated further feedback from Dave on the staging code, mainly
>     to improve clarity, reduce ambiguity, and fix minor issues. Each
>     patch includes some details.
> 
>   * Collected Chao’s review tag (thanks!) for the first and last patches.
> 
> As usual, the series is also available here:
>   git://github.com/intel-staging/microcode.git staging_v5
> 
> [*] https://lore.kernel.org/lkml/20250813172649.15474-1-chang.seok.bae@intel.com/
> 
> Thanks,
> Chang

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

