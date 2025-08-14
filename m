Return-Path: <linux-kernel+bounces-769618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2EB27100
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4BA5E6619
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADF8279DB4;
	Thu, 14 Aug 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQs+se7i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9219279907
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207806; cv=fail; b=BKk+DFBRioUiiDTq9MVqOjQ2D1artoUqNc6F7X6NRiy0u1LTX4i21q9hcBh++YQqkRlkjBZ9EP7lbetx2vb3kIJwbzIQtT7aE9xX4r4XnHwPZ6pCfd2tZQfRbzWco7M2S+5a3RMh4JOK/E37la7b39WZgThGmucdPI5XYQwTCHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207806; c=relaxed/simple;
	bh=X7sq8q4/b9oSpDhhTdxhecWpA4xWIaaVpqDcIzcbB5A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XnWuSbgJlTnKM4OPyvWU0n4RVr3m8ivtRHA5yKylV6yRcWDji9vKP+k0RDdzsH2lT7DJNBQHRWq3udiFqAAgh6JvSm/Ag/yzl83rsvFi6M9saFE3tfjV73zlH4hHXkctVtD8bTdGec01kDxqWn6DXgiBoObP6TUpleVkfPfncxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQs+se7i; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755207805; x=1786743805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X7sq8q4/b9oSpDhhTdxhecWpA4xWIaaVpqDcIzcbB5A=;
  b=SQs+se7iPuc4anHmqG/YGc9Mzm6VvjTmpKCjMd4JoTTRbuz1XSb81fg1
   NgZMc541z5kauL3K0m9IBdTFUhdXAYV9hxbLlg94Ji8sI4qdc4ljLQeCW
   +ZQb3OI3n3OFNQ7vcx5GNZhp5PGEEyCEhmkQPueyiEU6+8LBEYxhEu6/n
   qq8G93btjAxcPSz2wnS5V+ZX7cAw9Jnz9eRloyBgAIZb548XLNo3m/bZ6
   bxZI99Yd41SP0T5p6AyvpOiH+n5uLQbIh/SRsPG7BvrWwRu2AtwH2WqPY
   oxnPukZWDOKCNAFNMyA5/XgudbJH+WDpPjKEySZgZtsjnSd4zkTl0aU8N
   Q==;
X-CSE-ConnectionGUID: Dw83H4sRSVS5cl0qYvHrYw==
X-CSE-MsgGUID: iqSed8cqQPiolYaMl9tNzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68990582"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68990582"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 14:43:24 -0700
X-CSE-ConnectionGUID: PxzfK3L3Q+u2TpAzXUaCjA==
X-CSE-MsgGUID: YcD700+XTdCQ2nWV61U63g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="172195754"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 14:43:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 14:43:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 14:43:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.86) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 14:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLX6d7Q2IaWY/AehgTFQeIWvWMLEYpo/05vkByElcz+ipy34DRR36lhkuFVoXYHptKZvwJv7S3D5e7QPTUTDzJTry0tvZucDa6HKoUwUT428yB4/BXQAdn0gwREuWggymkGqUjX6yF610pgxVOObkdwFh7uPGcSIOp0UKpYG1hxkmjb5PCM0y8cVXRv5NtLOFeQb7oJ428aej0DOXLxkaMt92laR3wYFmnUtMA+UQZCF3pdaBJfuxE3M/nNvRBwpEgeK8WpE7RfCa6qyXu399sBEFe8tvz5DRiyrlE3deOQfBwyStpjbozFnmCuHEPpc0HZAIqvMQauSWO2NfanjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj9VTrGDReTVFBwzHE2qbwL8eulKJ7PdLy+rsnZlpxE=;
 b=X6I/OXmMHkVKTmiJ23zZoZ0JBmmEEW3Gj5Dwj6WmGpU5Xq9BLx8DIG3cK0EteLmqM2CsiOTJfhXvXzGnowl6gUuyygVYRPfEf3QFONNJ6XfcVvojYFdp6fhnB/bWBrMXegTmJPaqzXdCQ/7MCP2AYo3EeFOByUTpRWDVqmGPt0So2tILkCI2f1L9sm/8kV6fOriTH7VydA9+Ykr6ss774xZqgIrca6gV+TZdK8gC94bSDN+K/stwzR1b+NsdJhtG7VQhpAlURDzs1nGSylBwrB9Wm96itiDrCO9Ia5S08PRAcuu0UOfbAkAspnd7YtK6P+cVhBwRYp0cG5Yp1nZKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Thu, 14 Aug 2025 21:43:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 21:43:21 +0000
Message-ID: <c3a1f8e4-d226-4ab5-91c9-d018d43c77e9@intel.com>
Date: Thu, 14 Aug 2025 14:43:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 21/32] x86,fs/resctrl: Add architectural event pointer
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghuay@nvidia.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Peter Newman
	<peternewman@google.com>, James Morse <james.morse@arm.com>, Babu Moger
	<babu.moger@amd.com>, Drew Fustini <dfustini@baylibre.com>, Dave Martin
	<Dave.Martin@arm.com>, Chen Yu <yu.c.chen@intel.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<patches@lists.linux.dev>
References: <20250811181709.6241-1-tony.luck@intel.com>
 <20250811181709.6241-22-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250811181709.6241-22-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 0705e445-1795-4b51-36c8-08dddb7b96b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTlXdXJlaXpjci9FY2NDWmdBTjh5Yk4yRk52VVkzMGJ5M1VkTXlLK0RTNWoy?=
 =?utf-8?B?NE9RVGNJU3lSL1hDb2FIMDhnSm9ub1ZKUElOR3RGUG5YTnYwb0NLaVdLK3RU?=
 =?utf-8?B?S0dqSHZmazV2ZER2d1pOeldScy8yWW5VcTRnemdiYldPM0wxN3I5UWJ2NkFL?=
 =?utf-8?B?TlBKMEZHdzc0QndJb2RzTHVtampBSHNCSkgzVWhtS3pHRllwcXB6Z2NmQVYz?=
 =?utf-8?B?VXZGZVU5cGpVVXRQUjdKZ0o3TjR3SUhKYzJnYVhPSGpZMTlPZ2VHWjJKZmR1?=
 =?utf-8?B?alMxdXhnTDdqcEVkbmV4V2J0WFczdzAzeTJSNzIva21DT3R3NlpYZTV2OUZu?=
 =?utf-8?B?MEcvaGRHUzA2UkhuanlsbExPUk5KbjNuSjhWTXBTODlkTC9sVW1Gbm95UTBH?=
 =?utf-8?B?eEFvU3VPZU1KNEtyZEV1TU5RR3BBazM2SFRad2J6VGp3bVJBbmZjSWErUmsz?=
 =?utf-8?B?WDc0VHpHcTAxNEhtdGlzeTlBOWc5Ly90NmIxNjhpQXUrNVBaU2p3MnhCZUw4?=
 =?utf-8?B?VmMvK3pPRVZmRlpwSlpYcEU3RzM4VENvY28rc1NsRDFtTktxelpJMnJUTzJV?=
 =?utf-8?B?VXJVYzg1bkkybGFuOE9McG9teHJXZS9ZaUpBSUZzaHQwcFVtc3QyNlBPR0J5?=
 =?utf-8?B?ci9jUDYvUzhqeHFZaUVhTEZqVmpkUCt6ZXhGcU1iZjVKM0x4NGRQazI3TU1u?=
 =?utf-8?B?ZmdYRXp5cjJQQmUxeldXdUl2Vm1zT3kyLzhuVUVTTW5FMmQyZTlNVmtTUHJW?=
 =?utf-8?B?QmRFL1B1YUhwOU5GMWYzU3crRzN2cmVOR01nQW5OSGthOEg3bFdtc1RUY2hS?=
 =?utf-8?B?WmpjSzlvbDZ5SmloOTF2NFFlcjQvTWQxbkk0UGUyTVVtRjBMVmtsalVzb1dV?=
 =?utf-8?B?NmYvMmRJTnByTVlJbmVId08vUm5sTmU1UFhGNFVOQVJac3lSam81NWVSdHZp?=
 =?utf-8?B?Ny9XSDEwenpYdUd4VExVOUprYyt6NFV1c2RKVWdpR09qdEQrSXl6SHdKaS9l?=
 =?utf-8?B?VjA3VXFhS1p3MzlDNU1EczBpRm9IMWM3dXhxQ3QyR1VweG5DY3NpUytQWGNv?=
 =?utf-8?B?RmRTbnlVK2xkQWJSbzlYL2dPZG5rRUp6cThqS3ZOeVA1MW54eW9NQVVTbFBI?=
 =?utf-8?B?bENCR1FLRFZaQllUVWdsRk1GeUZUMitEQ3BqL01nZmJ6alYxMHFZM1JLQlNh?=
 =?utf-8?B?L201QXBjRGZPRDk3aHQ1bG5qT3VuS1RCN1BIZ0dCUGNFZjd0dHdVdXZBV2RX?=
 =?utf-8?B?MTV4c2tnclZ3V0JrMk41cmM0U1NWOXNmL013SG5NYVgwb0c1QnRFZTQvbUJC?=
 =?utf-8?B?ZXFjRWxVVkFWczF3bFJEMGwrajZMRGhHUXAwR0huRkY5cS9id2pqMTJwRzBy?=
 =?utf-8?B?elBvUDlTNTV3RHdTY2dUTVhCM012cW1ydWQ0YnZTUS81UVB2ME9Hei9XS1lh?=
 =?utf-8?B?YTlaQ0QzM1BwQXJtT0N3VFVHNEV4cjlTOWhWSDViQzJDd0RIeWxUUU5vSm9H?=
 =?utf-8?B?VWhNOW1IVVdHMlJwd3ZTOGhQS2x5ZktpRWJvcE5RNUtOMnVpcXFKN3RFM0pv?=
 =?utf-8?B?R3dzcXFrelNiY25RWDhsY210M0pkeWVTOXFYdG5WY2dXZzVYOXBETDdzTkl0?=
 =?utf-8?B?WnhIWmJKaWpPRVNVbDA3Z2JBbWR3NUU3WnRGRGEzOEZ6OW92Z1JSMTVOaTdH?=
 =?utf-8?B?U2VLNEV0b1FhUjBSdW5DNlRFUWJlRldQL1BmMWVwUHhncWFTK3ByblgvUHgr?=
 =?utf-8?B?djV5ZlBqZmw1MTdka3pmV2M1aHFCOEd5bm9VbDd1bVBSUm9Db25qWXM4djZx?=
 =?utf-8?B?dStTenlVN0oreUc2VUJpOHo4N3NLY2h3L0RYSzFybmVlTjB6YlVXekZBVXJT?=
 =?utf-8?B?VUZuU2xOSXhUU2d1Wno2c3E5TWxkTGtqMDBRd2xzdElMbmd3S1lPSnJRTis1?=
 =?utf-8?Q?MvfYkJe2htc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlzcjFYb0hpYTh3RXAxL2pTbHFLaDNRNjBXc2RyYTNGWGlhTDA2ZFV3ZGJt?=
 =?utf-8?B?VDVmakQwQ0NuUFI0eWd4UzlrSkRnNTNqYUJtL2JjZUZQTGJCQlU2R0FydFdB?=
 =?utf-8?B?OFczeEhwa2RraTFTSkVDK204aVNuenVuOHVvR0FVRE40VE9UalVoMWx2aXho?=
 =?utf-8?B?VmJPMEJ5ZjVsQTdZUjNGQ3hKdGh0ekp5VVJucm1FN1ZqZWlycTI4THlrWFlm?=
 =?utf-8?B?YlpOZW5ZaHdNQlp5M2owcEJnUWpXSzZxMkNxUm1Bb0l3dXRuK05IM1YrMThi?=
 =?utf-8?B?VkpVSU9sWDkwblR2Q0pvU1NNMGlGOUhRdEp6Q0tkK0g4UUFMMDFhTUlJNmxl?=
 =?utf-8?B?blFPZTFRNnJDQk5kNVp4KzV4TFlYTkNtSXgxV3R3cEh0Rzhnb2IrN3hENS9o?=
 =?utf-8?B?ZTE5Y0RjekNxbFNkS0c3anRDREFLVmVpU1JoOXc3OVFCSkVPdGhnTk1jbzl6?=
 =?utf-8?B?bTlGNml3NmRkQkt2MDY0blRPcjRDcXBJSHlBSm92dThsZHZ6Z1d6cnBOSGdR?=
 =?utf-8?B?aXN4b1k2WklPa3Vka0IwVm10UEdRZlZTR3NwOFFXMlNORlB5MDdRZWREZ0RB?=
 =?utf-8?B?SndsNUkxR0l4eVVyaG9YZXFKbUtmSmJlanFHeHZ3RFlTSW9YQlN2UGJ6K3VI?=
 =?utf-8?B?UWN0akQvV1UwOE93RXBHdVdmUU1qR044eVJJK0Y0cG1VVFZVWmsyVFhtdkVL?=
 =?utf-8?B?ZERnWjFlMFZQQk84U3RGRHIyYUJnNHZvS3NUMk1mWEFDMEZ0YzFCRXAwLzMr?=
 =?utf-8?B?ZFNTWDc2VHlCeVJwbmtIaHFCYjh1SzV5MVRWcmVCeGhCQXBXT0JSajl4aGg2?=
 =?utf-8?B?dU9oR0xLaE00MFIwS050dXFuV0xGTGN2UERWcHlXeUhjK3I0czhMNFBYTVp2?=
 =?utf-8?B?cmxXVUYwR2RhTUJHaytSN0xoNWVtekU3bkJ3c3g1M1FxSkh4UFJKOWIrKzNq?=
 =?utf-8?B?VkpKcjhtcjRKNlhVUDg2c2M1WTNldTdCT2Y2Nk82NCtNUU1kRUkxLzJGNnRm?=
 =?utf-8?B?VEMwYURQTU12bmxBRnBLZ2VxRXVtU2xHeTBQSExSMHF4TVRLRUpqYU9USWly?=
 =?utf-8?B?WVJUWVRCTC9MZkluT1ZuVjV4RFBBeTVoVzJJUlFFbU5US3hBcnUydSsxZmxI?=
 =?utf-8?B?QXBsN3R0clQrNHpYSUZMLy8wQzF4MGt5MW5LWTNkT3U3dWFxME1aLy9ISHhT?=
 =?utf-8?B?TDgrQmMySHZNQko2dFNsWXIwWkVtSjdpT0FxaFdTT3hJc3FObWRMSDVmRDJx?=
 =?utf-8?B?ajFKbTNoRUVQNy9lV2FvVkZLTmZGWFRTWnA5clNLZGdZMWxMMTZjdDlsc2Ez?=
 =?utf-8?B?WXUxMkZTNFNaWmFKZGdUTW16RC9UbThEVERNdVJHZ0pORjQydGo3QVJHWlZx?=
 =?utf-8?B?ZExSM05QTVNMY1JhNTl4aU5HaUFmZUdTWU5mUm9HUk5GVG83Z1NOankweTBE?=
 =?utf-8?B?QWg1NXFNWU9NT0lqZFVYMFJXR2JXcnJhU003QVloazZ1QWtvVmJqRkFqd2J3?=
 =?utf-8?B?UzBvWm1JQkZWZWRVSFlsVnZGWjJRSURndVdGNmI2Q0tmWW1KUzluVkpOZjM2?=
 =?utf-8?B?YVIyeDFjbW5HN1NJd1BaRk9DNGU1azdGbCtmN3lqczMwakp1TW8yLytFNWRo?=
 =?utf-8?B?a1gvN1FIU3pFbzlvOUs3dGhYUzgraUZrWVhNam9lbldvZVhxb0dUQkppZ3JQ?=
 =?utf-8?B?b0V5VTN5ZWJRT1BvYWpka2RwMlQwRUJ5UDBETEJackJubGU4NW1nM1Y4Zlpl?=
 =?utf-8?B?VG9YUmtEZFZXbjZVOGppaG90WTR2TnVodC9kZTRka21WRGxKOXR6L1lQTVJO?=
 =?utf-8?B?V1hlSDByVE5oSXFqaUc1OGJWd0FlOVNFSnplT2poWTRQdmJLRzhZYjZGUDB6?=
 =?utf-8?B?Ti8ra1pnVjVOYk85akNXZ0Z6alF0V01XRGxKZVJiZ1k0YW9SRFZtTnUvZkNM?=
 =?utf-8?B?bVJvNkFqc0NzZnpjYXNtWndlcU03VTRkelUxbllaZ0N5UkFkMzB1Sk0rZEJv?=
 =?utf-8?B?ZHBTODd0VWI2Rml6SGI0bjFONGQ2MWdVOVVaM2xhK1BHbTQ2aVhRZDVaeERO?=
 =?utf-8?B?RjZIdUkycjVZb2xRd2FEZDk0NkRvYjhUWmFPZXFwbzhVV2pGMjBRZDVORlNU?=
 =?utf-8?B?MWxOTVRrQ2VCZFJLY1VoVWxmcUE3MnFwQXgvcHkyWnRlZVMxbUkzNEhDSEVh?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0705e445-1795-4b51-36c8-08dddb7b96b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 21:43:21.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Z8GP5IV7UvgkWNn8sCGY+pJ/+NvNL2k6qWbEIfootlEDi0S55UCEA+JRRW5BITZI4CSVWJHrZQrjO4nkhymauzr9KDX8UshZUohVJ519C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
X-OriginatorOrg: intel.com

Hi Tony,

On 8/11/25 11:16 AM, Tony Luck wrote:
> The resctrl file system layer passes the domain, RMID, and event id to
> resctrl_arch_rmid_read() to fetch an event counter.
> 
> For some resources this is not enough information to efficiently access
> the counter. Fetching a telemetry event counter requires additional

The vague first sentence can now be dropped.

> information that is private to the architecture, for example, the offset
> into MMIO space from where counter should be read.
> 
> Add mon_evt::arch_priv void pointer. Architecture code can initialize
> this when marking each event enabled.
> 
> File system code passes this pointer to resctrl_arch_rmid_read().
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
Reinette

