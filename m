Return-Path: <linux-kernel+bounces-735946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB0B095AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7F585F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB765224B05;
	Thu, 17 Jul 2025 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWWUaH1M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070241E0E14
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784006; cv=fail; b=j1I7HJ2watj2twgsT/k7KwD53JcDUfKu7U7tWDBueEWbMugLGuXkKR/LM23FVdkr6fF/uyoa16Jg3cRX60Raxlr0NOlR3VONIaEPamUtYEFiHXyzmwj+tgNhuc0/m4sEInoAATdjIihbItUyb6Ejzi1c6gwM9CnUyqUCZDaUYEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784006; c=relaxed/simple;
	bh=T17qk/B9i1qPF5V06d5wibqbkSASGEYSP0iqo/Gjbm8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wp67r04pUIHwYNXeOCUNgQraK3GulriNquJ6xudQr+cPfPp5Ru2SBsxiEN0hD4MXdFcSj8udangONBakBr1hzub6DEGNvHBbUX277h5c+sQsdiFoMp7gq8p/mq/H8vGtc+0HHUCNBKItgcnZ+TIVOMU71pOB5uP+ee15//Lt3WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWWUaH1M; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752784005; x=1784320005;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T17qk/B9i1qPF5V06d5wibqbkSASGEYSP0iqo/Gjbm8=;
  b=AWWUaH1MyAJo1Y70m33pbsSoTHXb98vTM0ysioxVGBOe5t39Vu9yhBVc
   +zmNpDhyAQnyGWY27jTANC4/UIZMYYnBiAh7otf9ELPFd4LN9bMF3NJbH
   HcHreNm9rbJOoKp+uCzfiBHxsMZ5NXtDPxpRs4pe9U3ncXB/bS6UFWn0A
   0fPjSDpBN7l5jlU9SFeQlcMF55hy5r6AJ8WIRTFFMN9yCqfXlXDdJqe78
   mLeuuCudfAqXK/DYr1Pb2goc8nLDJCtnUKY/YKCWP9LzPUeh8wKWXj0HA
   OtArRBRni5V+T+NyJCCoIaV7kF+jiNuXKmWbAWfmtPLiHIvcfdtSVLfTM
   A==;
X-CSE-ConnectionGUID: k12xh8bdRD6qOpdoO+ZqhA==
X-CSE-MsgGUID: XlvcGpyOTeGSDW+GdOsWRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55228064"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55228064"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 13:26:45 -0700
X-CSE-ConnectionGUID: wVjgKr4NSzaT7mVOEtcERw==
X-CSE-MsgGUID: 1bf/Uf0VT8yx/PdDmUsMMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="195021685"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 13:26:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 13:26:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 13:26:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 13:26:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exBiBizRgW/RgR0kledw4n3zvEIDzfP6RSBIm78Oy/RM0lH4JYBG6Zfruubk2OhEk3tCwh4+Tuc029rDM9uvvZYrCpFx3PYhSS4qItdVqQPFdeXQS4roJvl/9brDxwz2auvZCJ36t03BL6IrXY8nMIjYS57XNttVi3Fg2kEdrJr4c+SqwPlsQL+OpCRVv2REeDGBEWvlZi9NsKavWzogmv0XAw9y2ERW64kniXKsl3sGr50dJW2Vb/yrzQ07WqLbcMaz6NqXH5YleRGJ2v0F5YOX0HMAIdN7IqDQoBnMFGIzw+64GbpNi8jZ/NRrJgkxk33AmUSfjsxTfA0w0/hImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+l87NOscLZfilsH24QiF2oq/C0+wQEKiv1gWID5cHY=;
 b=T2k6KS9Yks+/XoVC/liZ1nDo8oDGuOi6Hw+qngnqayY/juAS5vx+1aeNoApM0CLJ6Lr83w6NTjFC9Dt0DGxJ5U4Z602bNtHwfmM2tHYP5QrdSgQ2icmKXOa/hZdy5FeQ5cg0FWvZtdvkpO6Idd9MkfoGIWX3565/o31nB435UpOsrC7h9fbIxhwoS/sCc1N0PphHaYxB0FUPjKMwKb98TOL2TawRgEhTDsOAjHddDF8bQLqfIwMJKlbjnLsuaPeIA9ABt5e3rf8S7XOinQZuDo1SDexf0vEZXEzjfumsHYz3YEFb7bQU/mPoKMJcEP9hG2HXbKnYNsuZqZ3R7fy4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Thu, 17 Jul
 2025 20:25:59 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%7]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 20:25:59 +0000
Message-ID: <7fcede81-902c-4eaf-82be-cfaf3154bce9@intel.com>
Date: Thu, 17 Jul 2025 13:25:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: x86/apic: Drop useless CXL/CPX row from the TSC deadline errata
 table
Content-Language: en-US
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, Yuntao Wang <yuntao.wang@linux.dev>, Zhang Rui
	<rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20250716160824.2167709-1-andrew.cooper3@citrix.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250716160824.2167709-1-andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|IA0PR11MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 079d914c-7c64-40a2-65f1-08ddc5702438
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWJocHM1UHRMYm91eUJiTXcvNGw4ZUpZYlhZMnBuNWlYNEwvUjRLaHROMFFW?=
 =?utf-8?B?TXJQM09QVW9ZUkJiejBOUXU4ZmUrZkFFNkZjWFJQbnlJNEp3a2h4QVBjdDM4?=
 =?utf-8?B?SmhXSGZ3c2Vad0ZqeXZuY05NRGhhNUJRc29TUnp2TUhsNUc5VXpURFhpREds?=
 =?utf-8?B?TlBhc3E5amI0RWl3dlFxZlp5by92a2Q3VGc3K0JhWnhQU3o3bUlUMmdCWDlU?=
 =?utf-8?B?cndEekprSVh5ZHRXTkZIRG5hVVB4YkZEc01LbHpqNmRuZHV4dVhCaXArdy94?=
 =?utf-8?B?aDZNRCs5UWFza1Yyc1diV2hZNy9JSnZ2RSsvaWY0NXREdmxBeEZDeko1aDQy?=
 =?utf-8?B?QzJqb1pybFM1OE1PcXd4WlNUR0RHaXNad2Jwd2dTTjJ2d2plZ3RMb3BCUUx0?=
 =?utf-8?B?QzI2Sk5qN1VUbWdhbk5ON0lEc2ZDY3FGZGh5YXFnemJiKzY4V1ZvU2xsdVdm?=
 =?utf-8?B?aWJ3SlNsMmFyRjR2M3hxbU1VVk1iTlRZMVkwMUpmdmlwRjNFUFlkSXlLQjhp?=
 =?utf-8?B?WThYVWt6WCsya0F6ekQwWTErdHZkdkp4aUR3UzNXNjdTMTFOWjJCU3kzRUJP?=
 =?utf-8?B?RVZsK3FXcFVtSlRHN2F1b05jeWUwZ3Z5Q2pxOEVQd1IvbGZhNWZlbXBMR3ps?=
 =?utf-8?B?UUZ1N0xhK1NTRHVpbWZ0Q0FCOG1kQWpCaUdpSUlneFpyRmVtanZ3MWVSdjla?=
 =?utf-8?B?eW0wS1o5dzJET3ZaRkw4T0U3R3BteEtwL0ZQazk2MlljTDRPSURzMTZVaTRa?=
 =?utf-8?B?NzU3T1BwUDhLcndDREhleGVUeGlZNnNJR1RBK1hsTkhQc3VRaWZyK1Brdnln?=
 =?utf-8?B?T3RLa1ROTWJVa1dzaDV4MzlURlowYkRDMmtwdElFVHlVMTgyN1FMamE0a3lG?=
 =?utf-8?B?L3R4dFhwUnFPUmtXODMyd05SdTdrcjFPYzM4UGxxem1SZFcxZTNwdFlLQWov?=
 =?utf-8?B?dXZyenNlS2RIaENnNGtvb3ZKdk5lR2VVL1l4a3dsRE9Ba2I0MkMxaWNTRWVl?=
 =?utf-8?B?dThRVVZRaVZsbXB3OExoU0loNzVRTkd4NnFXNWVvYVJSNlNza1RGcmRuOWcr?=
 =?utf-8?B?VUhzbFkxWXFvNXBpZER0SkpjQmM2OXVISFhLci9yQTRlNkk5dk1zZ3RTVzQ3?=
 =?utf-8?B?OGVOU3NUUnQvWUxoQWRCcFV6OEhGczl1Z1dpVU1ETHRLM3cxRVVYMFlXOHdU?=
 =?utf-8?B?NU8zb3A4TE5TcXZLdzNVbkxqdEV2bW9ueEFFby9kU1dIOGExc01rSy8rS215?=
 =?utf-8?B?RWVHNkljZFlGZFZyRmZiaTBRN1g3SVRFdmsrRTZRL1Vzb005czlYdDFaaGVy?=
 =?utf-8?B?bm04cVNiaVVsYzRhZG5VVm4wbGpQTkwxenhPRC9EUjRVVE90K1YycDA4Z3B4?=
 =?utf-8?B?TVFScngrUHJrUnd5OElORkQxayswRU45L084b0NHRkhmZUhqaWhrUmZpOXpD?=
 =?utf-8?B?WHBlVHBrZktvMkhPTE9TWG13bll4Smx2dHNBVUdZdFl4cVgvcXphT0hxU1Za?=
 =?utf-8?B?dEVSVXg1R0VBK1pHaHZWU1RQQWNUQ09hWU1BNElqTTBQNkdQMktBNmdleXRs?=
 =?utf-8?B?N3RReThEcUxCalNFbXBzckpMYmt5ZjBrODlJQ1gydUlQeHpiZVJ0bUxHZTlz?=
 =?utf-8?B?VXUrSDlKeG1VbHcxL0IvSlMrL2FkbEtTUlFTK1lOTldvakJsdWNFUlV5SHMx?=
 =?utf-8?B?ZzNNb0ZpOEYwMTZGS0VZeGd0NUZEeVlZbm9WNklKODhWTXI3aGlqVWFVL0hL?=
 =?utf-8?B?L0JuaXFSS25TaDgrbDh4WkttT3ZhSWtMV2x2cEN3VGJwYlZjUk5sZVZWbGQ1?=
 =?utf-8?B?SkVBck5lVWZSZnJkSFlydkRMV01wanZ5cjV2eUJEMkw1dWNURW8zMGltWE1T?=
 =?utf-8?B?WGw3NDBmNVhSRkdVWDdWRlU1anhUcDJWTE9iNC9GeE9NQ2YvazlXVFVBNUU4?=
 =?utf-8?Q?95yvGx48QxQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE43UXVBbm84VC9hdXI2aVpQUlRFTVE4UlZHVnBtWVVXZ3VYUy8vYmQ2U0RI?=
 =?utf-8?B?aGJCMWIwRzBvSjZrU0pXb2NERVZpcmhmYlVCdXpYcjhZNkJIaTNlRmdEUmVI?=
 =?utf-8?B?cDIzSVNmOVAvSGh6cVF5LzZCKzgxSTRCc2hicU9hbnI4RlRTUXpzc0xtNC83?=
 =?utf-8?B?SU1TY3VhRTgwMzlra0NIZHREdndPQWZUZGRELytQRVBQY204ZFZ5YmFjbTlB?=
 =?utf-8?B?T1ZCSGx1cmpUbmo4Z0pHQTkyMElLWCsvaWJkNGx4bTJzaFFsbTU1OFBiSXhU?=
 =?utf-8?B?ZVZUMEpxWGFGNlJoZHhYN1NaNXAvSitvYkNkQlh0ejNKVUNyNnMrbnJEQXhC?=
 =?utf-8?B?UURsN0t2T1dXQzRlVjJhSTJLejNjYW9aYTgrUCtSR0FIWk93U2pDVmhwL0JC?=
 =?utf-8?B?UWw1SXplN2c4R0RJN1JyNTRTUEFsUnpyODZXSDYwbGY4dElWTEJPMnB0YjRC?=
 =?utf-8?B?bUh6T3diOHJGVHJYbGh6UFl4VFo1Yk5aS0x0dlRMM21GeEdXbFE1WGVlNXFC?=
 =?utf-8?B?YzVRSnc4M2hOMkdVSzRFeVB5RGFST1ZnZkJKdmZGZjdVdmVpcG9rNWduZ1Na?=
 =?utf-8?B?Z1FzNWxwc3Z6TWZFRE80MUhaZ1Nnd3h3YVZIeGZPUzJlQVF0bU9YV0FCWkV1?=
 =?utf-8?B?aVEyRlhCc29Nd3d0U2hKZituVmhzUEh0bGNRNW51dE5uK1F4TWhYQUx6UVo4?=
 =?utf-8?B?Y2svNURZTmE4R2ZLUXplODR1RExxNkh4RlZLaWJBRk45dzI4WWY5aUVpUHZH?=
 =?utf-8?B?bVJXbGhWZ0FRMzdZblI2UUlsU1pjMkY2Wnc5b1orWG1YK1dIS1IxZllKUHhW?=
 =?utf-8?B?K1lKcnVGa2ozQTVLS3BrWjM5YmhEaEh6a1RnNVdPQ3RRRytIOWVEUVhET01F?=
 =?utf-8?B?VlF2bTd6VERjTGVjY1lobllaMStkaVN4THl4K1BNOUhoekJWRUhVMW5xbjEy?=
 =?utf-8?B?Y0hOVEJ0MEc2M2NRcWlsTnRDbTNrTXh3NGg0ZHFOcWFtdWtFNzdJVFFRdE5W?=
 =?utf-8?B?YWxRMzkraHJWb0QrQWJGaER2RkV2OUZtMGJBU2dTeTVhOVQwRHlOSU1Yai9X?=
 =?utf-8?B?U1phekFEeVNrdytQdjhkNm55N282MHA4bjJaYXZWVllETmhIc2w5VHYzVjd1?=
 =?utf-8?B?R0lYR0tXSC9ld2ZUV0VVaW1yVWtOSkJxcktEZEc1UCtGbi9LRkNRSUlGeFhF?=
 =?utf-8?B?YjN1Mm05c3puVE5VQmtqNGZoR2NyV3VnQ29WV2xVZzlGL2pNdUt6RVNYU0M0?=
 =?utf-8?B?Q3R1QUNyUWQ4ZFJIR2Z2Q0R5YzJlU010RHRIMXN6bS9WT1dWcEdnRTJCUlRv?=
 =?utf-8?B?alVBRThObmpBTEV4K0hRaWN5ZWNOVmtrOEw3b2p4dFA4c3cwV0Q3dlFwNkhk?=
 =?utf-8?B?UU8yUkF4TU54MjZIVmxGbCs1N2VRYzRHQlg2c1o4Z1poYXJtN25iaU04T3A4?=
 =?utf-8?B?a3hFVElkU09IcGxGQStBK0JZT2tuUVV0cUcvT1VCczN0U0JkbHhOemhKZFM1?=
 =?utf-8?B?dnE1VjhYYzQvY3ZyMGZqd253UnhqVHpxem8zdjJjUElvUmhsYWxzbmtSYUdw?=
 =?utf-8?B?SEdCc0JRVXM3S2MrQ0xaVUJsRnp0V056cllUOFpid01QLzZ4aWlHb2NxOUFn?=
 =?utf-8?B?YmtQVDh6OEFoaGYwbEM4NEM3bWJJQVUyNDUvWkRrcUYra3ZzZ1hMaUM2S2pj?=
 =?utf-8?B?UXF1aVliNjlJdHpiQ0JtaXFXaTFzOVN4TTlOUXp6MnhKcU13cDdXYWR1UGky?=
 =?utf-8?B?ZnpNZWtPcnIwTmJzTllMemdVQnJXN1JlcVRmQkUwTmtyNWwyYmw2OU9POW9E?=
 =?utf-8?B?SU42ZTRzVGx3eWlVRmtObWE5MklCN2grdHhWS0Njd2hwMGcxSzFJdEZBOGxM?=
 =?utf-8?B?Z3pvU1I2K0dQbW5vQkhaOHN0Q3VlWlNZdkZaSFcwOTZIZGdVUFp4MCtvbXFj?=
 =?utf-8?B?QUJjdzl4Q2FOVDBib090YnJqdjJIby9wU0tSeFN0VDExZEVUb3VKQmV6bGI3?=
 =?utf-8?B?VlVGUDRKMEtFMit5ZG1NdVp6dmkrVmNSZkpNNWJtZitCbEVldjRlOGxYUS94?=
 =?utf-8?B?eWhZOUl1TC9yRUlCN2NDMXJqbVdrRjZYU25uODNwZVlGYWJXL0FDaDlSeUI4?=
 =?utf-8?Q?7+Hy6Vzl2d4oOiyfyNuwdd2xp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 079d914c-7c64-40a2-65f1-08ddc5702438
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 20:25:59.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sqe9HKHCbJLuu37WmA32Hzf9nJeeE2KlzgbIGZwulloPtI2g3tK7+/xSkwwtSU4kPCCZnUmD7jdhCKwrPgFaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-OriginatorOrg: intel.com

On 7/16/2025 9:08 AM, Andrew Cooper wrote:
> A microcode revision of 0 is guaranteed to exit apic_validate_deadline_timer()
> early, but a better way is with no row at all.
> 

Yeah, not having an entry is much better. "exit" can be a bit ambiguous.
Should we be slightly more precise?

A microcode revision of 0 is guaranteed to return true for
apic_validate_deadline_timer(), but a better way is with no row at all.

> No functional change.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: x86@kernel.org
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Sohil Mehta <sohil.mehta@intel.com>
> CC: Yuntao Wang <yuntao.wang@linux.dev>
> CC: Zhang Rui <rui.zhang@intel.com>
> CC: linux-kernel@vger.kernel.org
> 
> Strictly speaking, this is:
> 
>   Fixes: 66abf2388331 ("x86/apic: Convert the TSC deadline timer matching to steppings macro")
> 
> but I really don't think it's interesting to backport.
> 

