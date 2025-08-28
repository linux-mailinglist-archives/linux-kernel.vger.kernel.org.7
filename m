Return-Path: <linux-kernel+bounces-790819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FFEB3AD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCAD9870DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBB126E6F2;
	Thu, 28 Aug 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eO3qzwe9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913024467A;
	Thu, 28 Aug 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420403; cv=fail; b=ABdj1oQH6+6sICZ9+c7YnqG5d4RNQZoOYQ4StNQL94nWmzRBWyBgDNGPaTOK97afw2/VLoWyH3CGrdoNhErvf4WDuxKyFd55ubffc5GCsYokirBpEgFWU2JBqRKLq7GTp0jOpuw+JfzThQn5NOVzZDbjY7EiXze+JNR++l7fZHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420403; c=relaxed/simple;
	bh=0LOzYBnHpeSwLLCHEUpvd2mWvkUCJ/OKhIG5G5VnK14=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JZLt7UiFHbQIRimWCGrwx22PXYUjkh3FccHbijYu83x5lM1pZOC0t4o9x6L/8a3fJ0oUo6gWjbrIAgWPiltM72hRIi9UG/wj4AJzmRZ7WA9aZdQIjrI7E+riDljxsjV61+l91G95AfBj+L4/JLYQpSXaqCS3gN8zaMOQ+iVR9P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eO3qzwe9; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756420401; x=1787956401;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0LOzYBnHpeSwLLCHEUpvd2mWvkUCJ/OKhIG5G5VnK14=;
  b=eO3qzwe9KbnZSeu3gmHz7suhqsfD0S7k+N1Ed5bs9pjby74FtiPtq7AU
   Rv8dnQhaRBZI3O0a2ajED8aY9wvwDqeIl1fXDu7Gmq0KAR/fMh5awW6aF
   rHxGhoSmm7evEeAPw3UqXKrSAbZ+XE4Km0SO+E6chvXG+J3ma8KpNl0Jk
   HoSnMw0iazUMj8fPIj98shbnXDRLsgsiZ6vTE9W30yhPfXnLL/coH4Lyk
   D7T0MAqw9jIuaftNAWtZyTRDiGCQywAfQ+Dbno6NcpEkLy0bRLNDG0Urs
   EvoryDyQzNOKzuiJj98p2lZLdRU4sVAJppHI2seyr0fSOE0SskkkfAeZa
   g==;
X-CSE-ConnectionGUID: Zg29Xec6T6y7Xnpnv5G9lw==
X-CSE-MsgGUID: qItt1NXxQ9WK50RSsvSWrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58806770"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58806770"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:33:21 -0700
X-CSE-ConnectionGUID: FXYGWzr8S3+P0oKs+f5nUQ==
X-CSE-MsgGUID: sWJRy+fBSfSMy3L1/eykJA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:33:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:33:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 15:33:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.84)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUhG7JE8FL5OEoMVzsKeHmfQO6WpGO5XKrS7K/oh0oOeYMy7Kaw4H1BoKK7U6PUaiR1VoYQ6mgmk8jw6VqcqiOIrvhUQ3wbcq/tjRtyhu06ix7A/4CDkI+irUm7jFbk8sGSiNvzc81YdSYW6VJWL/HqtX8wUO/IZ01LxVnK4KIgFzSOQVnwlnL5i9QlvWUZYUMWBXMV0c80VCduQ+oHUAw9RQ4qc3mddA7REw7kU8yaXZhqyr4DTijM8la8Fr0WRwBi0v2R1j1ZWHjr3iYOt5D8gabhkJcIOHdUN+o3EDlVHk1wdEa+8cq/8gOOSL4yd4Z09OPz1UQ60bO1uuENQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFY+W8ZNrX6+n7X/E2FcDdKb+qRdTrpHunuwHyeoFyg=;
 b=Lkn9sFJZ+wMnP0E2crzuobLHkoZ20pMNZyXzIBwagINQezheVl9wSXVNGR30RNCBqdhAHcv20bzgu7SHsL/f1e9aGQ4dL7ZdINiMOY5ltv/UbFUzj2DweJRIEfIxx996ATOUElzgKpAu+te+elmuYP5LciB2a/5hkY+wnecjRDWy0plfo9bPCkHKY8D5g5w6IOh7LSRpq1OZYK+EIhY40f9Gffu9Idy5M4nB2IMb89keoA4MlqPZgNNWksGzrdIK3OkyXhx7/lmnB2Q2yZ7tMFURFo+z06m3BCtC90fQU5b0L76xpcFfzhWyjHWyd3awp37AARefMFXTANuxusG9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA2PR11MB5065.namprd11.prod.outlook.com (2603:10b6:806:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 22:33:12 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 22:33:12 +0000
Message-ID: <51537b9e-46a8-4dd1-93fb-bb14ea15e6a2@intel.com>
Date: Thu, 28 Aug 2025 15:33:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (coretemp) Replace x86_model checks with VFM
 ones
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Guenter Roeck <linux@roeck-us.net>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <linux-hwmon@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250828201729.1145420-1-sohil.mehta@intel.com>
 <9f1fbf32-fd37-420c-82bc-a43e6d5ef57a@roeck-us.net>
 <c53dedd1-5c58-4325-8da8-552f109b67c5@intel.com>
 <fa0f4052-22cd-47cc-95ea-ffe1c3a5a52a@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <fa0f4052-22cd-47cc-95ea-ffe1c3a5a52a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA2PR11MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b85632-4c79-4c37-a009-08dde682df57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjAyTm9vMFh4VGtpQ1dXd0RHRmoxN0FkdHNJMHdqZkxJTnJ0blNvQnpCTmQ0?=
 =?utf-8?B?WERpNHVrZThyNFNoT3lsb0dJQjVxNldQRW1TaXBMWE0xT3NWSnFyMnJ5aXBu?=
 =?utf-8?B?Zmg4Ty9RTTBrcks1TjFWNFQxUWtVdmREci9zbm9LSVNNRjBtK1NVdDdkM2Js?=
 =?utf-8?B?c21kVkZJbEZiOUFHdjh2cE1ua0VoeEJDdG1NT3lRQnVIMEtPVnFUZjBYNm54?=
 =?utf-8?B?T0JycCtOSlJQam9GaXBiRVBrSlhUMWlRdnVKZzNOWU1qZjZicEdOMzVUQlJW?=
 =?utf-8?B?RlFWY2pHai9pSkJTUDc4TzBqbFhIYkhsMEkwLzRJYjBvSjlDckpuNGFaSTNT?=
 =?utf-8?B?WVVhV1BDQ2tpbExMbmRmTlNKbnlUM3dDNGV0Y1QwZ0xTRTZ3c2FSTWdGRzdp?=
 =?utf-8?B?QWNHeVVxQ1BucVpQNmZaZ1dqUUJ0a0dGekFKR3Q4SDRsL1ZHUTBwU1NRQnFY?=
 =?utf-8?B?RXN3SmtOckRMR0hIazhaclJiLzhBSUEvOXlia01QaXlEMjEycTkyL2Q1U1NN?=
 =?utf-8?B?TCt1aisrNlRzWUVpYUlHOS9ZUGxnbzMvdk8xWmp0TTJUNUFSSHZXQXF2R2ZG?=
 =?utf-8?B?WkY5Y3ZGSVJCNVhMUEM5TlVaWnZIL1ZmZzdqN1ExVm10d2FpMGdUbjNCT21I?=
 =?utf-8?B?RHQwVG9TTkh1ZUlJSDVGL3NFU0dOYkl5VzNBZndYckFpdndoOGs3cEJEd3g2?=
 =?utf-8?B?WlNRd0J6azlWc1ozUjJsSW5yL1h0cHk4cHdEUDhYdXUwalM5SWk4dDdQanBO?=
 =?utf-8?B?eXZXN1RYR3ZXUXliOCtwMGREcTdtNFZNd2JSZ3UyM3Y5NzNCWE53WksrbjV3?=
 =?utf-8?B?Z2JGUVo0RGpQeld2bUFnb210b2wzTFNBUWhjS3Q2SXBYbTY1bXZJQ2tnN1Zx?=
 =?utf-8?B?U3ZKdWRVN0lZNDJYUkFOSndTVkdPVVhHQ2NMTGFKTU9wQnc1L2xRSHY4NnVo?=
 =?utf-8?B?MGtqV3NUMXJwNDRBdXJkRTF3OGtRZ3hheTFIUnRtRjkzZTFsU0RwMVR5VUZ1?=
 =?utf-8?B?UmYwRjRScGRyamVuUzBMbm5zci9IbTl1aEhWK1hweXYrWXVMK2xUSVFaNlJF?=
 =?utf-8?B?WlgvYk9PL0JPNTFyNE1vYXNlS3E1cUlLSkJJUC94K1BXcE1jaEhSWGZPV3FZ?=
 =?utf-8?B?Zjk2aXVxelVaclRJVnFMZFVSeFJYdEZxSzZOVHh5K2RZNXNDMkptN0Q1eVpz?=
 =?utf-8?B?SDZ3WlVCdmNDN3k3Nzh0K082Vi9PWlZ1V1dIdmNHUDJmcFdPYTFxN28zU2Qz?=
 =?utf-8?B?NnRNR1ZxQnB5dDR1eVNrb3N1TGRTUzMwaHBsQU05OWdORXJ0VHpvOTdtUFVL?=
 =?utf-8?B?K3ZLMGdHL1k2TFAxQkFIV3U1UENGWG1TTy9XNHBISi9MVnN1U2hyZFJHeDRO?=
 =?utf-8?B?S3NMYUFLWFZESGNPSitONDFidGtLZFBTMGZXTXIwaGNDM1lMbjJWaWtZbEZv?=
 =?utf-8?B?a2QyUVNvR09yMTdkS1JhdEtGTk11NWpnUkxjazVFTlJrYXM1UFBXRzdxUXNU?=
 =?utf-8?B?Y0hyMGtMempwTjBOWjhibi82d1VyRFk2enM4OVRBUTdJWXhCQVdGN2d3amZB?=
 =?utf-8?B?L2pLbWZUSytlZXBVekZRelR0Vk5KSHdwNnVtRUR1bmhTTTBkdWFPdW1ZUjMz?=
 =?utf-8?B?T0FuREtWa2Z4Z0IrOHlqSFBLZEJGT0ZpTHgvQjRKZldkQWFtckpLcmsxcGts?=
 =?utf-8?B?M05LdEdkQ1Fua21lTnRvanFjeW5CS3Byck12VjFLOWRoT2lCQzBtcFJyOXEw?=
 =?utf-8?B?RUcrQm45ZVBZMjdwRUtSell2RHRtUU54WkFaNnNZbzJwaVAvRERFc2pveW5L?=
 =?utf-8?B?clZYTnloS1BzQm5UT0l4TklYTWFXcTVTNFZhaFFDWXlWQ2RiaG9QbnJmQUky?=
 =?utf-8?B?WUQxWlZvM3lPY0FZRWNlR3dwZWJWM3VQKzNnUW1LK1hhR0RsRE9nUUlzWWtq?=
 =?utf-8?Q?uHn4wIN3JUY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE0rWVhzZXVwOEhHUFNiOE12VzNEQjZDUEdQVStEbkJhRVR2QVdBdUtlUndk?=
 =?utf-8?B?YmVTbmNaSWlpM0ErMGFoME14UUtRNjJNVW5GMGN6OXNWRVViRnlKV2EwUU1R?=
 =?utf-8?B?b29SNjlKRWpnMURzakI1UThzVm9EeENzWE0vcENHUUpzZnRmVFl2bTFWajBq?=
 =?utf-8?B?MEtTRVBIRHluNGw2K0FHb3VlUm1GcWVvWjBrNXVrNFU1aUt2YXFZRWg5RFEw?=
 =?utf-8?B?QzZkQ2p3bWFjSHNJMXhObGpuZ3FCWGJsWm5jYVhjRlNKRzR6Y0xFVVN6enMr?=
 =?utf-8?B?N1B2dzZZOXJtV2ZGNllMVE9hV0ErK0xRMThJWkdWdm5DK3BKN2ZYK3RHU3Bu?=
 =?utf-8?B?NG40MEVmYURZWVVJL2pDb2g1cndFajlwYnNWb3BWeXNJSU0yZ1dOKzNpTzdT?=
 =?utf-8?B?T0lTTG9uVnFPZUgzQTdBckhSNG5kY2ZOcDNZbmNJTW5MSFBtZERQcnk1YzVs?=
 =?utf-8?B?Yk11cHp0Y1BCYWNHK2JuY0s5ZFlHK2JWMmpNYUxuZWJmVTFtUUJTYkVCTzBI?=
 =?utf-8?B?YlpXbk5Qcnp5Z1lhZlp5SWR3QmZ3MENBY0hEbXNLM0VaOWFaUkFRc202QnJy?=
 =?utf-8?B?RjNneldYUXduTmVJSko4WUdYQmlQZ2NJYVAwdE5RTEp5UjFvMTQ2dWo3SnVB?=
 =?utf-8?B?YUNiME5lT1RkQWRkM0tHbWx3d1poQ1VXamlXdjFYMTd1cnVGZkVkS2RUNTda?=
 =?utf-8?B?cE9SL0VZZlM3eklsWGRweVd4bkZHb1A5R3hOQW14eEU5VEhZN0NqdUxMckJQ?=
 =?utf-8?B?OUl2aURnU0FQRGs5UEJzOW5yWm1xclRNZFFTQ1pxVnRRVVhWOGFIbnNKVm1p?=
 =?utf-8?B?cjg2Ly9PcDduRkF6bmtYQm9tbjdaU210S3RtSTJIdWk4NlROL216OXMyR2lq?=
 =?utf-8?B?bXEzTitNTzN3aG1iblcrd1FGSkZRU0U3Uy9zQ3UvRnVDQkJzVC9CYnVYY1Iy?=
 =?utf-8?B?WjhERmR4RjkxVVFYZG50WU9oTHBHUUorTHVhTlNYWlJMVFd1QU96bzVkaUVZ?=
 =?utf-8?B?NlB2YVhkN0N0NmRnZVVlYU53c3F4UmJYL0N4SjFlS2ZzTHQrbXhydnI4L3Rl?=
 =?utf-8?B?ZkpOa0d1UjhhL0Q1WWxOVUlFNG1nNFllcDZpeGh6L3dka2hBbzdNK1B5Ty9H?=
 =?utf-8?B?aTlKN2ltN0o5aGNPMHczcTVkZVBvcTM4cFhla294SzkwZEw5Z2JSUXgrci9F?=
 =?utf-8?B?U3daa1c5NmhvNGw0NldHVTFpSUxoSjVOblIwbVlaOC91ZlVmdDdGMk4xWDdY?=
 =?utf-8?B?VXFKT2w0QS9peks3VHJPU0Y3cituTFpIQVlwK0JvMW54MjNKZWMwVkVJSGk3?=
 =?utf-8?B?d2JuaHVyUTZZZ3ZZVDl1djZIa3c2ZFZ5ZzlJUERlbXlaSnZsV1NZKzVpcmdH?=
 =?utf-8?B?U0tzRXRLVmY4WkpNSVBGZk9GSU5nYXc0WXg3bDRjc1dpbGhEK2t4ZzZXbmlq?=
 =?utf-8?B?VkQ0T1M3YUpCWk9KY0dUaFlrMUZ3WEdVYVVMcXJ2d0Fnb2g3Ym5BbjRVSU9K?=
 =?utf-8?B?QVcvNy9yb1ZuNklPS0hhVDJKYVJXdXE5WFRMSnN2SlExZzh2Tm0zVGFsYXg1?=
 =?utf-8?B?SjZzZTNuSmlCeUJqWVBZZk5SczJRMis3ZkxKYUJSRkREemo4V25oU2FwSlM4?=
 =?utf-8?B?eWtpcjFEUXM3R0g4RjZxTlVoc2FJNldPdDJQSkdHbytaQlNDNVRPS29jNEM4?=
 =?utf-8?B?OXV1WGp1MUUvSmpqYkdrZmFlYmF6VkJqYTFXMzh4WGdsVXV1MlNTSGxWWnVD?=
 =?utf-8?B?L2hpRElTOGVaclRYaVRKWDJIODlTY2xieTAwZEp1dWVYbkZtMlRRYTU5M1Ju?=
 =?utf-8?B?NjkyMTJHdXRTaGp1aGdpNnMvTnpvVlk3eHRPejFDd1Q0L2xvNHJsaGpJYjQx?=
 =?utf-8?B?UW1LMFpqeGNoUkllbkxsaG52cnJ0ckhrNU41SHVZenhENjFmSW5qZllMM0h4?=
 =?utf-8?B?Njg0MG55OE1uYldCY2xPV3F1ZzhrSExnRmU0a01WL2lhZ3N2M2EwNldYcEpr?=
 =?utf-8?B?Z29HZWdHSTU2eStUUWhSRUVnaXAvbUZTYi93eit5MTZlS21vN25tNGhTNThK?=
 =?utf-8?B?SXpHK2lRUFhMVEJwY3dyQzBQc0w4U3JYaDlZYW83SkJJRkhJUWpGODA0blo5?=
 =?utf-8?Q?GRcp/82xy5qjjpCJTrZpyYake?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b85632-4c79-4c37-a009-08dde682df57
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 22:33:12.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlZ+kH0otw46/nygO8dNFcqdYdVp2E1Zg7Elan3nd3Sihw3TgxquTmYzKRn+sIwWeQ3px0lVH1EC0hj7bMOuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5065
X-OriginatorOrg: intel.com

On 8/28/2025 2:51 PM, Dave Hansen wrote:
> Let's just wait until Guenter sends it upstream. Once it hits Linus's
> tree, you can ask for it to be in stable if we decide it's a good idea.
> 

Sure, sounds good.

> I asked if it was necessary because I'm not positive it's a good idea.
> 

The model numbers in play are around 14, 15, 23. In some cases, the
model number is used to determine if a sysfs attribute should be
created. So, for lower model numbers, the TTARGET attr probably won't be
created.

	if (c->x86_model > 0xe && c->x86_model != 0x1c)
		if (get_ttarget(tdata, &pdev->dev) >= 0)
			tdata->attr_size++;

	/* Create sysfs interfaces */
	err = create_core_attrs(tdata, pdata->hwmon_dev);

In some other cases, the temperature adjustment would vary slightly.
But, nothing scary for now.

> So, let's actually look at what it would mean in practice to have it hit
> stable@ or not. Just spent 10 minutes looking at it.

Yeah, I am fine with deciding based on the severity of the practical impact.

