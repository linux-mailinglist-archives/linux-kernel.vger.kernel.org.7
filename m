Return-Path: <linux-kernel+bounces-844741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9DBC2A33
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5D23C7AC2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FC23BD1F;
	Tue,  7 Oct 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfbPfLHi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32823C513
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868635; cv=fail; b=rNZbfq49aPM3uSA2G2zTANXRsO1cAS6zd4UmbBRCej/I02h6FFkxt3BX+OzsSziaVzyyJM398g9SYhH93h3ONombjwNq3dqtCOcGkAxmcd9EDeGt7gveLIS9T7EIf8FaDz5JdHRTJPN2DNEghtEpDuP9Ssj1u2iUCMsBiU0koKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868635; c=relaxed/simple;
	bh=LNQRmx1PIEIeYv6+4fcJjFSbzxHBFrHlx/HDcCQdrLw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I/EwGl80BOr0hAossCNxNzo4vTcrYmDniRjycub/oI0Rk1GXngCBJswJESo62crD+bvIqp3tfyW2050a3DrBzBw6aS2uPHonOgi1vS+t0qw1cz2opiwKe25GCcyChreShCmRpDmORQnAibYHlrO+Q2UobcTItyGrsKUDfnspitg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfbPfLHi; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759868633; x=1791404633;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LNQRmx1PIEIeYv6+4fcJjFSbzxHBFrHlx/HDcCQdrLw=;
  b=bfbPfLHiO5QZ1zc2798MP3Cj+M9mTc6snKZ+aIc2Q/Qrv/wPYi83/vq0
   GhiIazpESkngZc+9AA9K+9Bl3XexLoMAJHR+XmuC4fTgMPoLWiceD39Lu
   G90ychW0sDvuT+6pOSCpWJLCuPZ7xIG19upU2BPWdFqgVpCKzJXXAEnPB
   1YUGK4ZHACkulSu3gKXn1e4DkrYw1E143xwjie1nircmvM7bteqKRk+rI
   CWfFnNTUzzGinyRGTbqoKgTE23YzuiNQTSnXnLKx4gq5RgOksxAq0+KYO
   sT90wDM32ytz6GqTgYvO3FXr0d/ZOrhCaFi0ja9XJwRT+n3nY2fBR40vv
   Q==;
X-CSE-ConnectionGUID: fpVyOiUSToepIld7fvIB5w==
X-CSE-MsgGUID: DlUt3ZWbR36wf+g2/2fd2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72673123"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72673123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:23:52 -0700
X-CSE-ConnectionGUID: YbuaCljXSLqlIpFvYMOwgQ==
X-CSE-MsgGUID: hS/QuKrxTYWnSBg/b77sKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="210904633"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:23:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:23:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 13:23:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:23:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaz+29+UlqlG+ii97OLb6vqU/H572KzX/KFoEDllEiTRbPZGoflCL6h5ZyjwN/fmzcAvv4Rc5hAER0bkksbKyjA6VYWRQRHJK64K8rbouzW00wh9VeS4POQUz9c/gLTxJTwtjuLNJGnI0n1kDYoDW3wVWah2k/MtlvR8nGFLsQrx4cIWZds+yjl9qjta0HGuHcPQ0lOTh8QcNFE46sggIiPXJJG/2vIEny6lbKHt/kamZrM76X72+UsdQBEWXiI9n1h0t1+7Uvh4Qt9ycshVkApdHw1MF4i2sNVZYKzauNOL64ZrvgF1TY4WMJGzajADAQMOs+4d1HjytVTbJsjObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJchXcH3wNKOL9itcQ5cxXAe+ImZr2F4oiWQ5VvUSxk=;
 b=Np157NlxuYEg0ehA51LXHLNrT/ambT0oicSZoNVXEM5Tnwyd5XQu4Y/gqHBj71Q66pIxX43ovD0jrhdFVDd702Ig5bBEb2VKnMBi/DeQ+t2KQknA7fGK3BW6cZeM08y2lpMyKw2y3sbItRAxlZ6wAsuCeyqiA7y00a2TPg063TpQ9rc8jX+YviC5Ll96g34CZGQJ4IfEh4OL+5F2xScYPFAEd+zEg0r8ucbfEnl/+htG++wlWRWWF7O0lYU3V6Evxhl/WIAHFE/JpgLPdYp1GXmp+9vyLMRN52chaiaWRA6jf8tGSb7xJBbZimq9OZXF8X1khqmZ9ciPZZLwgubqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6125.namprd11.prod.outlook.com (2603:10b6:8:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:23:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:23:38 +0000
Message-ID: <fe06aa33-3351-45d4-a687-ff88a689be6e@intel.com>
Date: Tue, 7 Oct 2025 13:23:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: b5952fe2-633f-4459-06eb-08de05df6669
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk1RWWRrWHpGbElYV3R0T1ZuaVljOWt0bHp6Zk1FT1ordDA3OHN0eEVpZllq?=
 =?utf-8?B?aVVUY1NYaWJTU1JYYUJMcVFuYjRCdHZvVWk1YTNMczMwZnV4N1dpajFlKzdK?=
 =?utf-8?B?Y3FNalI4amsxcDluZEp6Z0g1OTIyam9GNlNBc0VPQk44WGR1U3k0YVk2VVRT?=
 =?utf-8?B?ak5BczB3bUlCZno5d3NGeGh3UXNnTW9aSU5sQjc2aml0S1grcHZ3NXhNOGRL?=
 =?utf-8?B?STdtcHdROHcwRWREL0U2QVZER1Z3aEVNTlNLMlRLeGNvNGFmUUw5WWtWZm0z?=
 =?utf-8?B?TVNaYW03dFBUaU0rcTBZNUNHdzEvMlRDTk1WeEpEb2FxcGdQdkU0QXZ6dERN?=
 =?utf-8?B?OU9QNkVzWG5JU3BCcWRxdzhPZXBxcjRGUU0wWEJ2QzFkblBsaHFhK0lvZFJB?=
 =?utf-8?B?MFhpUC8rMXk0eWQyN0gzM1p3ejNicXVOSHMwakhpamtjUGp2dm0rQTJDZ0hP?=
 =?utf-8?B?Mm11RWwrOVZrRGlEODBLREdiZUl3ejFNWXMxMElqSGVJdnZ6S3hNaXIzQm1y?=
 =?utf-8?B?MXNNNmoxeXMrNldtSlpxMUJBUWZqYlNtSDBPVW1lTS9ZZE11QnNGVnNWRGtu?=
 =?utf-8?B?a09ySFowT0tIZ2hETEhGSldwTHA2c3M3MUgyZDFya2kvZ1pSempsWDRFV0Q5?=
 =?utf-8?B?WFE0QUNKcVdaWkh1cDNMSGh1TFBjZkV1ODhYcnJSMnNEa3ROc0RBZU81REpu?=
 =?utf-8?B?Q3ZRN2dTSENXSjY3bnNLNEpUdGVmZTkwd1YzYlo3eGY0RllyZTNHSWFUWXB0?=
 =?utf-8?B?dWMrWE1Oc2RBRWJwdnFkak8xUnh6Z2ZZUHFRUS80N3VlRktRaFlhOFZKZ0hW?=
 =?utf-8?B?Yk5URjltUTdNMmphOGdHYTQ1RDFrMS85RDhHQmFjdFVzWElQVUJZS3FXUHE2?=
 =?utf-8?B?QzhSU05SKzF2cFAraEIzNUZpZ213aEtCanNrWDRQeFhHVWdXWVhSQ2Y0Nmtq?=
 =?utf-8?B?My9kL1NYTUlPSzVGOFhDUEhnMHB1alZQRXRhL2g0VE9mWE1naC9tVXFMcFA2?=
 =?utf-8?B?b2p3MzdmMHRUU2hYNmRwT3dUYlNBSkkxem9YL3dESDRPR29iYkRYdE8wRVgz?=
 =?utf-8?B?UU9ic3JlKzNBdmNVTzczamVnRVBxK0Y2eG8xYW5LN0xqV01BTFZ4SnZMYlVw?=
 =?utf-8?B?S240NFlVcTd1Mlh2d0QxeUQrekliTmlWem5tY1lsSnNlN3haV2tCYlFrOGVC?=
 =?utf-8?B?Nnd3NHp4R0dCc3N3VzRqN2NDUDV4RGJFQjdsSEE4NHA2eTdidjMyWHNzVTd2?=
 =?utf-8?B?N1VHWUs1ZFNLeHhkbU9jazkxNHVBblBBR1o2QXh3dFlmYThJTGVkOTlVWUV5?=
 =?utf-8?B?MmlMMlRQaStyVXRhMVZ1UWhsaENUbkVFWi9JTzFoaTArV2VEcmFSWTRPVFU0?=
 =?utf-8?B?REl2VGZneFNFbUtsejZEYm1WS0hDTGVsZVJrTTZ4S2JFdnQrVnlFUExIMzI2?=
 =?utf-8?B?RU0rRHNDSFg5VUFnZGNvTXUzOURiMTJRVEo2aGJwK0ZPTzNTNnJYRzE3aXdv?=
 =?utf-8?B?ekh6bU1sRlRkUndIOElmWXNWYXVXb09WY3FxYXFxeHd2bFE4a1IyNm94Vk1Q?=
 =?utf-8?B?c1pVNW5LSE9XRUdDN29HeHRXTG1PRzUycElSaVFZYWdTYUp3cXFYckNQV2ZH?=
 =?utf-8?B?VWNQTGZBRGJkUDljS0sxdzNKWFE4K1hKUmtObzNwUUFzVFJXRDk3eUdZK2R6?=
 =?utf-8?B?V0U4RmlPd0ZQVFBUVnNCazVXeGhjUmt6UjU2WWZkcm9BYXVQc05pcnZDbjVi?=
 =?utf-8?B?MjVNa1NzTy9YTFAvTEVnNjNkNnhjS0o5SE14SlpJaVBwYXBzN2ZpMU83ajJj?=
 =?utf-8?B?NzBreTVxZU5OVFZsQjNtbVQ0NUhNc2RJRkEyaU9VbG16T1BkaFIrcnpqNkd3?=
 =?utf-8?B?bGkreDkyamZtQWJlclZHQk9HYlVUOFFhaGs3TGFTSlAwSVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWJ3OGtlUzBPL2psQnh4dXhaN1l5cnpWY0RXMm0ydVJIWS94RHd5ZUlSTjEx?=
 =?utf-8?B?ek1zSnd0TEp2aVhMUlc4UEpMUWh0c3JKeEVMVFVXcUJGOW1wS2pSc0NoT2Qy?=
 =?utf-8?B?bUE5Ym5ZRFI1NllYSkR2c0pxcWRwQjVldTlrVmR0L1J4bXdYRVRFQlhDeU1t?=
 =?utf-8?B?M0xvcHVFN1Z0ZnB6YWE3cGt0MnQ2ckpzU2Rkb0s5aGhDTlhhakVuaUNxWlFL?=
 =?utf-8?B?YWdmbmJsM2ZkRjNDZ25jbzRRb292M3ZaU1BBSlVuQlZRSEQrSGRQWDVtNTJ4?=
 =?utf-8?B?OHByZy9wd3dPL3lBQ2g4RGhRK1JlTVkxemk4QmpUODMrY2RiYUdMUDJFaUgx?=
 =?utf-8?B?L0xrZFdJY252R05adW1IOVZ4Z3VSSnh1ZTdKTzU3MWRXdzY1aFQzaEwrRkRr?=
 =?utf-8?B?dWloQ055dWJrbnZzeHlKYU5FTVFaLzhhaFMvWHpUejlLTGl1UHowcFpWUytj?=
 =?utf-8?B?SW1WNzMrTjREY1pOTzZSMWdreW9QMmpVUXZ4VkxpTVZwUzcxRnNwY3RudDJS?=
 =?utf-8?B?OUwrM0hKWUVGU3FrcnkxdWwyTHBxbEphSW9NN1UydDloWVVUcERVY1ZVajRm?=
 =?utf-8?B?WFA0a2NNd0xNb1BSaVg2YkRJYWRoVmMyVmV6VFR1Zm1vd0w5TFJ4U241SXBX?=
 =?utf-8?B?NE1LQUdub1hsVVdpZjEzaU9RQUx2ZVpNVHdvdW4rTGZ0dWNHTzNxY3Y1Skgx?=
 =?utf-8?B?Tk5Oc0ZWcnBtT2JzMnU0QTdhNUc3UXE3Z1dIVFg5V2NmSi9ZUVlGOEVTNUpj?=
 =?utf-8?B?WWNFbTJFdTE5OFAyQUw0c0VTNThZRWRJR0pJZ281a2dwRGthUlFFdGtrL0cw?=
 =?utf-8?B?aEhkb2VBRVA3Y3JTQm84UTVQSForY09XNm5tTVErZm1aYXFRdlFOeXFUYnlY?=
 =?utf-8?B?M0d4ZGxsVGFtU0w1d1lKRlQwdGdYbDY4bDg1aFVCTE1LVGxCK0FRbGNTSEdR?=
 =?utf-8?B?czVsR2FRb1JZVGZMOTJsT0pDbTVRSVlTbDdldmZrbDNPdGFPdDNheFZaVkhv?=
 =?utf-8?B?TkgwUFpYRDNudFBIMkdMdzVmU3REQiszMWRwRktzTlEzYlRGczc3aFUvTkY3?=
 =?utf-8?B?UUlzV3dSVm5ENlpvcXNhTmQvK0VPOUtZNjBRYmh4ZkdlelJENEhXSkRBRVFp?=
 =?utf-8?B?M3pOVzVUK0M2UjNVUmJBa1ZPWFpWa0FEY0VmZDhnNi9xUHlwdEVHOXZKQ051?=
 =?utf-8?B?ZlNJeHpuUjJ6a3FlZitZeHlKdnVJc2l0QmtyZjNkL0tIK1B1WkpuODllSDZl?=
 =?utf-8?B?QUZCUDFMVFpHRTBVNTdtQ1dJU1IwS1h6MmJ6MWVueS85cWY4R2J4RHRnQ21o?=
 =?utf-8?B?a3ViYi8vamNEY0VLSFp4RmRNOUZkMHpFQzZqN05ZZTFHbnNQV0xObTNHN3M1?=
 =?utf-8?B?MDcyOXM3cnBabkZhaE03eVpJMUV0VFZycFFaUzlVS3l1b1JMRUlLZFBCTmUr?=
 =?utf-8?B?NWxYSHkwWU5ZVUlWS2tJdm15ZUVndDRkU0JhcWVuampEQ1BtRU41UTB1REd2?=
 =?utf-8?B?OE1TQnk1d2NnODNYdEx1UklvRm40R1NpTjhoREk3dXFWTXhPTExhelNzS3Js?=
 =?utf-8?B?bklPTmRWNVdZaDJkQXpOZ2ZNdkk4T0NZUHRRbm8xOGptUXErRURYUTIzQllL?=
 =?utf-8?B?NHBuaGJvdWtsRk5RZWFNY2JpSDJhUlQxWkpwR09Va3BuQ1lSb3NiZEp4OFdo?=
 =?utf-8?B?ZHg1QjBQSFVrcm5hN0RWQXFJTWU3R0xUeGRMMWkwbGFUTU9nMUo1UHBPOU02?=
 =?utf-8?B?NFVTLzlOekliajNXcGxDS09kc01JMnZ3eVl5ei9OcEdsTTEwUjRXL1R2d1hG?=
 =?utf-8?B?OG9tZGg5MXZWcHBpRDNyaHhTTk9STjdmU1BJeUE4THpPMVJtTFYzeStlS3hp?=
 =?utf-8?B?TFlGWFUvcDVIUlB3aUh6YW56R2tjaG9nWGR0SVc1Qzh2RS8yN0FGT2pPdDdY?=
 =?utf-8?B?MWYvQXRqa29YaEJDRTA2ZStnMGNBczJiOUFMVlExSS9KN3drZ0Jjb2pyVlMv?=
 =?utf-8?B?K1ZxOFpRSDFmd1JkUWFXYzUzNDhHUHJDSVZZQTNxVzhVdjhpVVZyNG5zc0FY?=
 =?utf-8?B?N1Y1RjRqQlU2dE9zY1BkYWU5Y2wyQWtMUUNKVDNuUmlPNkZOR0xyZFN6SHhC?=
 =?utf-8?B?bUc5RjlSSHQ3N3Nuamx2ckM4RHBGQ3U0aEJUK3lUYnFUWGYvRVRCd1JmdDhH?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5952fe2-633f-4459-06eb-08de05df6669
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:23:38.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLt+uz+biN9brjYtBZl6JClGG/q7N6XpYbl0JfyFvIZwI+pRRHXRgM+XioIAWJW985+ns1Z2+F8tvBumv/l/6ym9o6bTfV27Uy2zHqEFFgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6125
X-OriginatorOrg: intel.com

Hi Babu,

Thank you for catching and preparing a fix for this issue.

On 10/6/25 4:13 PM, Babu Moger wrote:
> The issue was observed during testing on systems with multiple resctrl
> domains, where tasks were dynamically moved between domains.

(please let changelog stand on its own and not be a continuation of subject line)

> 
> Users can create as many monitoring groups as the number of RMIDs supported
> by the hardware. However, on AMD systems, only a limited number of RMIDs
> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
> this limit are placed in an "Unavailable" state.
> 
> When an RMID transitions from "Unavailable" back to active, the hardware
> sets the IA32_QM_CTR.Unavailable (bit 62) on the first read from

(can drop "the" from "sets the IA32_QM_CTR.Unavailable (bit 62)")

(IA32_QM_CTR -> MSR_IA32_QM_CTR) (learning from touchup made during merge of ABMC work)

> MSR_IA32_QM_CTR. This indicates that the RMID was not previously tracked.

This seems like a contradiction to me. Some times, like above, it reads
that Unavailable bit is set on *first* read after counter returns to
"active" but this text (and the spec) also mentions the "Unavailable state" where
where the Unavailable bit is set on *every* read while RMID is in Unavailable
state.

For example, from the spec:
	Potential causes of the U bit being set include (but are not limited to):
	- RMID is not currently tracked by the hardware

> Once the hardware begins tracking the RMID, subsequent reads from that RMID
> will have the Unavailable bit cleared, as long as it remains tracked.

Can we thus expect that Unavailable bit is *always* set when RMID is not tracked? 

> 
> Problem scenario:
> 1. The resctrl filesystem is mounted, and a task is assigned to a
>    monitoring group.
> 
>    $mount -t resctrl resctr /sys/fs/resctrl

(resctr -> resctrl)

>    $mkdir /sys/fs/resctr/mon_groups/test1

(resctr -> resctrl)

>    $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/l3_mon_*/mbm_total_bytes

(l3_mon* -> mon_L3*)

>    21323            <- Total bytes on domain 0
>    "Unavailable"    <- Total bytes on domain 1
> 
>    Task is running on domain 0. Counter on domain 1 is "Unavailable".

This implies that the Unavailable bit is set while RMID is "in Unavailable state/
not tracked" which seems to support that this bit is always set while RMID is not
tracked, not just on first read after counter returns active.

> 
> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>    counter starts incrementing on domain 1.
> 
>    $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes

(l3_mon* -> mon_L3*)

>    7345357          <- Total bytes on domain 0
>    4545             <- Total bytes on domain 1
> 
> 
> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>    state because the task is no longer executing in that domain.
> 
>    $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes

(l3_mon* -> mon_L3*)

>    "Unavailable"    <- Total bytes on domain 0
>    434341           <- Total bytes on domain 1
> 
> 4.  Since the task continues to migrate between domains, it may eventually
>     return to domain 0.
> 
>     $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes

(l3_mon* -> mon_L3*)

>     17592178699059  <- Overflow on domain 0
>     3232332         <- Total bytes on domain 1
> 
>     Because the RMID transitions from the “Unavailable” state to the

This paragraph contains a few non-ascii characters ... like the quotes
around Unavailable above (and below) and a few other characters (’ and —)
below. 

(This happened in ABMC work also but slipped through with Boris needing
to fix. Now I include a check for it so that it can be addressed sooner.
Please check your tools to prevent these from slipping in.)

>     active state, the first read sets IA32_QM_CTR.Unavailable (bit 62).

(IA32_QM_CTR -> MSR_IA32_QM_CTR)

I expected the Unavailable bit to be set the entire time the RMID was
not tracked, not just this "first read"?

>     The following read starts counting from zero, which can be lower than
>     the previously saved MSR value (7345357). Consequently, the kernel’s
>     overflow logic is triggered—it compares the previous value (7345357)
>     with the new, smaller value and mistakenly interprets this as a counter
>     overflow, adding a large delta. In reality, this is a false positive:
>     the counter didn’t overflow but was simply reset when the RMID
>     transitioned from “Unavailable” back to active.
> 
> Fix the issue by resetting the prev_msr value to zero when hardware

"the prev_msr value" -> "arch_mbm_state::prev_msr"
Although, this can be seen from the code. It may be more useful to describe
the fix as "Reset the stored value of MSR_IA32_QM_CTR used to handle
counter overflow every time the RMID is unavailable ..."

> returns IA32_QM_CTR.Unavailable (bit 62) when the RMID becomes active from

(IA32_QM_CTR -> MSR_IA32_QM_CTR)

> "Unavailable".

Related to earlier comments I do not think "when the RMID becomes active from
Unavailable" is accurate. It seems more accurate to say that the value is
set to zero every time the RMID is unavailable/not tracked in preparation for
the RMID to be reset to zero when it starts to be tracked again.

> 
> Here is the text from APM [1].
> 
> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
> first QM_CTR read when it begins tracking an RMID that it was not
> previously tracking. The U bit will be zero for all subsequent reads from
> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
> read with the U bit set when that RMID is in use by a processor can be
> considered 0 when calculating the difference with a subsequent read."

Indeed ... and APM also says that Unavailable bit is set on *every* read while
RMID is not tracked? :/

> 
> The details are documented in APM [1] available from [2].

Seems unnecessary (copied from ABMC?)? Earlier quote can just be prefixed with:

	Here is the text from APM [1] available from [2].

> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
> Bandwidth (MBM).

(another learning from ABMC work, this can be more readable with indentation)

	[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
	    Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
	    Bandwidth (MBM).

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> ---
> 
> Tested this on multiple AMD systems, but not on Intel systems.
> Need help with that. If everything goes well, this patch needs to
> go to all the stable kernels.

Needs a "Fixes" and "Cc: stable@vger.kernel.org"? 
This patch will only apply to upstream though so would need backporting
support. Will you be able to support this?

> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c8945610d455..a685370dd160 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -242,7 +242,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>  			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
>  			   u64 *val, void *ignored)
>  {
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>  	int cpu = cpumask_any(&d->hdr.cpu_mask);
> +	struct arch_mbm_state *am;
>  	u64 msr_val;
>  	u32 prmid;
>  	int ret;
> @@ -251,12 +253,21 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>  
>  	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
>  	ret = __rmid_read_phys(prmid, eventid, &msr_val);
> -	if (ret)
> -		return ret;
>  
> -	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
> +	switch (ret) {
> +	case 0:
> +		*val = get_corrected_val(r, d, rmid, eventid, msr_val);
> +		break;
> +	case -EINVAL:
> +		am = get_arch_mbm_state(hw_dom, rmid, eventid);
> +		if (am)
> +			am->prev_msr = 0;
> +		break;
> +	default:
> +		break;
> +	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int __cntr_id_read(u32 cntr_id, u64 *val)

The fix looks good to me. 

Reinette

