Return-Path: <linux-kernel+bounces-737316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE9FB0AAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C09D5853F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52C20101D;
	Fri, 18 Jul 2025 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQMfJH79"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55718E20
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866744; cv=fail; b=gipGvA9qktkvHe+Vv5ZlczOp+zEkzFgoA+q2BoshcuEC/9EYoMqyfUQKfWT/laJHojq7gV5vzxt9nlgTlVnwba2GgegCyQ1TxHFTbrHrHkmT3azrrY2+lVYwCctm4xbcExfDXbfqNgKOd1ZW6dJh/mcub7EhoymLPNsx0s3eN6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866744; c=relaxed/simple;
	bh=jCTODVAq/XUypfMH1vPLSxgBreR3taZ4MbbqVIUdDo8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQ/tHJUhoQ6tUPDHkyF9nXs/YnwJ3whO6+RU+UMDLtmcQk3t1iZCT7IjzYBn73zOpmBofPYcWNKCzzTWDd5StyQpsJPYq1v1QljphwR72HPQG9Ii9nXKBg7tpMTWjZ05KI9DF/8fTmg+e459kBQTkxahpLqU3r6vrExcWJceBo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQMfJH79; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752866742; x=1784402742;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jCTODVAq/XUypfMH1vPLSxgBreR3taZ4MbbqVIUdDo8=;
  b=dQMfJH79a0i+UkrI39xYqJ1EyZTHkXVREHsizk5h6PwtswUI5BwXhHO8
   p7GTJGQaktb+BfEVz5AM3nvmtwcdGL9YwmRR8OG7XzkorZw5F8FNsLA0x
   qyJAdRH8liqcCaacMJ60Jmu2QP0tnYIlJPABCaB3rDkbI62LsCkVrbOEE
   04i5bcv9E0gL1seiQeEhsnPtHDs1EaVuuaa+xg8f8UHkXPTx3N+SQEXMO
   sqvKIPAR4eO5OLNfKTQvY+85Iwshvitdng/+yXWAgaAoiQ+JQCSsh1HV1
   xGaQ0xGrAKnMLkJ5lkR0SnqhO4EN/G+mtstbzTNQ+lStrgYEl3QQ7NINl
   Q==;
X-CSE-ConnectionGUID: 1pc8Qi5fQF2SZoUmcXN33g==
X-CSE-MsgGUID: lScX5/HuQ2yTXHDBG1vuGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="58980333"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="58980333"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 12:25:41 -0700
X-CSE-ConnectionGUID: pMP1AOPgQLmcHyFfwn1kQA==
X-CSE-MsgGUID: zhtxL2HCSzGs6ocZHgJY9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="189115300"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 12:25:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 12:25:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 12:25:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 12:25:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsDkc4kqrPY11URg4kmrdDoPJZuKPHdsxHSzCyHi8kKurQ0e2hSikKu9c1rslMJwHdf567PZHnldI+z/dn/KjhoTrlYAOTfOm08tKaKetktwjkixhllPgApgcSwAZnqvxaihKuSRGx90sxn/6PZ2fn8pY6B4V8elMb9Ak9JBkEbR/2rTeEUxuO0UC/EAR6JGEBJsfbjml1tvGdr5BbXkCCzTnpuC5c44YZnNmjGAoadDHky07/lnd6aECxQbi5o52Vu5ZtDGkPKwmm5sHa9U64rMzb0V/HNAWnCNT3IuGr28k6lXYA45PKR2eaNNs5sx/yW1wQYVq7yHLZbISqLM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dadb3C65XwbJiImsKGypI+AkytUhqhyFuL6Bp9A22Xs=;
 b=WrrMCuEVIlr3iPAUykKV/g13HWNDCxhoju+a/Cv3zKdBIZLUnyl/1ntMGaTyEXgXIL2Jl+MQ5vnD9OTOGFdo6hFX3ESCV8BwgPd7kRtL+1lcgzD0daLCbIoA7DEe8xv6JVWPTJDRo3qHdFU+HW/WBHpqLCBtr+k6vOVkMr3PFOjuk9x+EtjsQX67pLFmCKfHoHIzXH6r8I0KAC9ipKCP3t1aKBs1jU7t63HsnEqSkIL32+DypS3nZ7xbnPJfqw0b2tu8FL7tdz8pWQt26AXfX/7l1nzEIERqGU1/uzDkF0ieBYHU1a8bjKxilDInMaAm3xmWrk3GzWnvIhLYJRiLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 19:25:10 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 19:25:10 +0000
Message-ID: <11530e8c-2e91-4071-8fd2-7657e2f836af@intel.com>
Date: Fri, 18 Jul 2025 12:25:00 -0700
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
 <7fcede81-902c-4eaf-82be-cfaf3154bce9@intel.com>
 <a6d7becc-9971-4e35-982a-3e35af4c4666@citrix.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <a6d7becc-9971-4e35-982a-3e35af4c4666@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0351.namprd04.prod.outlook.com
 (2603:10b6:303:8a::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB4982:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d7195e-1cb0-461c-de5b-08ddc630cfa0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z09aaUlqSVJwQnMwUm1rZUNzOFJzQU01dUZCdjVHbGc0Q2R4b0tXYzdyU2Nx?=
 =?utf-8?B?d0V2N2c0L0g3UGlRa3ZoNVF2Z0pOTWFqNFZleWd1TVhZV2Vwa2JLcXNXeHZV?=
 =?utf-8?B?bVB5VmRUdWhsYzZYMzdQMUcxdGlvbTVsN09ZRVo2WGtENnB1RGdUbzV4b1pt?=
 =?utf-8?B?SUZRV0VRbzY3SzNTRmN3L0E4a2o1TjRxVmhCYUt3WXNmd0h1dkpyL2VXNWFa?=
 =?utf-8?B?OVhHTjJXNitmaDdWdUhIS2Yyc29KZUFBaUJMVjJHWjNuZ3lVeVZpQVB3Y3d0?=
 =?utf-8?B?c0J6U1MrNThYWCtSTVNjT1pWNFBEc3FGK1liRHpGM3dFaStock9yVGNXMFhU?=
 =?utf-8?B?ZFNzVVFnVkZyYllXV1RQa1lzQ3prRzhwWGRrRmwwMUsyRUJIVGFJZVUzKzgw?=
 =?utf-8?B?b0taT1lXdW1oTUl4Nld0ZTd0enFWOFl4UVZWRVAzcktVZUdCQzF5b1FkVmJs?=
 =?utf-8?B?Z3B2WE5idGtFMWw0c2lpUkRCUzdTd3UxV2NIdGhDMUEydHhLbWMwdHNXM09T?=
 =?utf-8?B?NUhDa0plTWprdUhOZ1Q1bEpTWGdqY2FPdjQvSzlvTG1aVmxUZ1d5NEFzdVF3?=
 =?utf-8?B?UUJ2YWNtUm50aitQNUR2M056S09sVWQrVTh2b1BQMDNsZ1ErS2pYQ1p5eG5t?=
 =?utf-8?B?K1dQV0hQVkZZS09rMzI3T25NNGovMVlzWk4wbUhsYlNDcXF5YjlIYzAvbkpZ?=
 =?utf-8?B?amdLY01PK094ODFqKzJMaDhpc3ZJYlYwUnNRMzZnS0hmd2hRVXZQMXNOTFRW?=
 =?utf-8?B?bU1lU3plS21HTVpSdDBrMlFiNjdUa00zcXp4UitHa1FVNDM1RUJSb1pOTmtV?=
 =?utf-8?B?ZjZXbWFWZDNyMWxUbmdBTGR1TEZpVjI4RUpqR0dwTlFHM2dwRUFibmh5M1VY?=
 =?utf-8?B?QVQzYkI0V25GV05mWnVxcTVmR3pqK0hOK2liWFlZMjlqSVYwRy9VVkVEVmYr?=
 =?utf-8?B?UmtaZEdxWnNpUnd5aitwN2FqSUNveVZoc0JXMXpGby9yZUlyZHRHSC9Edm1O?=
 =?utf-8?B?MDdHT1F4WTFyM3dad0t0TXNSYmdaREFJMTVKNmhxQXhpMzJRN0ZCRTA5NGZp?=
 =?utf-8?B?TWRzZ21Md0N2cjE4aFlrYnVXRnpmZ1l4Q2luVm56ajdkZG85Y28zMkhqRGpJ?=
 =?utf-8?B?a2RvZGhCK0VYMnM1cGZWdDQwZkZsOWdzaG11Tmx3SnQ2dTJUdkNRV2JuVlh4?=
 =?utf-8?B?STlZRFEvZFpFRURSYWJ4VGxUQXhEMlVEemVSRXArZzFjeXpjQnhmaHVNMnQ5?=
 =?utf-8?B?Nk1YbXh1NTZVaG1ydzlmZ3VCWUN0azAyTVBTTTExRVZscDRWVnIyMFRZK1Bk?=
 =?utf-8?B?cmh1YmIzV1JEaHpOYjZ3dlFGeC9hcitDNmxZNGNVck5SK3VpYTNqQW0xMnNl?=
 =?utf-8?B?NlJSTHlCeE5URkJhREE2TGp5UW1lbk16bXZMZFpsMUJRQnUwOS9KR2hwdzNN?=
 =?utf-8?B?QlhwZlVtS0dzQ1BJc1UrbDQ5MW1ieDZsdE9VT0s1RHJjVlBITE1XSHdyT3Ji?=
 =?utf-8?B?UEQrNmZNYk83ZWNQZTRFdkdaSHlERy9Uc2hBem5ZU05IVUMwdmlPWjg5Vmdl?=
 =?utf-8?B?M2Y1MkxWeEhPTUFEWWVVV2dFTThhOVZXQ0F2MmtjTGZFSHBMd0ZsenJCZ0lN?=
 =?utf-8?B?RS9MY2tZMGlYSHJsb2QrZ1ErYVdwaHUxRWtobVc4WldvaFFhWjZ3STJYSmM5?=
 =?utf-8?B?ZzFCSytPZDhDYlA0VzdpWXlESkNZbHBKZnZZemw5dDgvUGFWREN0d05tdTlr?=
 =?utf-8?B?Q2VyQXMvWTJRdElORlpBeUt4cGtCa2p3L0QyNFQzS1B4dzVKK0RSMXFodGhC?=
 =?utf-8?B?cXFIeFlLRlpkaVh3TGJPVWNHazFXY0VKWVQ0MXNhbFF6bFBUczZmSkVLd25x?=
 =?utf-8?B?c0s4OGtRK2ZiNlpPNXFBenpKbCtNRkRxRTRieW1jZkt3eGxKQ3VMVHB3Qlhr?=
 =?utf-8?Q?MurNnjem1YY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zzl6Q0FadWN1Y3J2VmtTckI4R256U0RuaUkxT0VIWTRxKysrQ0lrczhJeXBt?=
 =?utf-8?B?cnJzY2NqeUhvaWpFRXBKMWJhaTlsUUwzQWc2M1RYUEVWSTM4WlRQSFRTTUsr?=
 =?utf-8?B?bUpyRjJobGtCcjdMdTgxSHdKVFNTMEJKSjNCeEV1dlIxdXlIU0pjZFRSZXZK?=
 =?utf-8?B?VExXUU9Oc1lTSmdtdDl4ODZ2R2RTdElWU3VmQnNncEhqVU94UGdPSUJNN2dJ?=
 =?utf-8?B?d0xaSnZqWk1nVkpQTlNwcTVYeFE2NmNXVER4Q25XaERLaWxmZW5OSlprUXlV?=
 =?utf-8?B?WUZxOHdqLzNPOVZYbTVYNEVEV3hkVXNBeXo1Rm00aWZLdFkwNVpLRGpxb1lO?=
 =?utf-8?B?NGtPekxFM0YrU0E0bU5mbHdVU21rWGs2ZWtXSExCYlFkdGNKaThxQmRaRS8w?=
 =?utf-8?B?RmgrZWxkaXJRS0xwRklLR2JQZjZBYXNTaVQwK2cvaXQ5NzVNSW4rWUpQenRz?=
 =?utf-8?B?QUN1QXQ0ZU1iWjk1R2cybC93RzZiMzh3bDFBdElYUGVOdVpBZzdJRHo2SVVS?=
 =?utf-8?B?b1M5RDhlcDJwTFoyRUtvaUNxbmNZajY0WnpBa1N4ZzhGTi9tS2YrTm91eFdi?=
 =?utf-8?B?ZFM2c2JZM1lYaVNGZFFxVVJTeHJCMDhFaG5HSWVXcDdRM2hEdUZXeWZpQ2o1?=
 =?utf-8?B?MzNpUWRhdVFoYzNLTTNtcHJuUDNCVTM2cEIwTDVVRENmT3MzeGsxeWhialk3?=
 =?utf-8?B?RXFGQjREd0Z5ejJlWkZ0QS9NWFh4SEFNVkl0YWEzU3pDM1hUd3I1UDVZcEJU?=
 =?utf-8?B?ZGFzb2hBZGtzREVjUnVGZ0ZyU0NOc2xsTnR1eWhoZXhBa2g2R2lwNzBjbjhF?=
 =?utf-8?B?RlRxcmFRTTMzeUNTdHdRTEpYSlV4aVg4OC92VkxTMEtxcVJNSzlnRzFjdTNQ?=
 =?utf-8?B?SXFXMGg2a2c3d09UajhjVEVJbzlOQnBTdUxYT24xaCsvRlVGdFp6bjd2bXlk?=
 =?utf-8?B?YWJUc2k0VDh6c2UrOWJvRXhHSU53MGpsQjRLUGttaGJ4SitCa1JKWjNLZTBl?=
 =?utf-8?B?TUVlUlVUc1ZjRk5vNEJvYlUvS2JXSks3anRROXhVanlZUUlwaStRUWYrUVRs?=
 =?utf-8?B?aE1hcERVUkUrOEUyQ1ZURTh6UHU2dUlHNGd3U3RZOVJQeWNjNjlYeU1pVkNQ?=
 =?utf-8?B?VFg5WmNJblBRaUxuUmw1ME1qQXcwY0loT3dwWXUvS3hacVYrcHRmZUVvdFRu?=
 =?utf-8?B?QWxUM0syVHhYRGxGaUR4dXhNdE9Cc2RtUENRSG9GcDR5R21sOGdxWDlFeTRi?=
 =?utf-8?B?UlI2RlFoTmFUR1hQZFZCV002QVpDMXBmUklEZzRBRWdhUDZHNlY4R1RUMXBB?=
 =?utf-8?B?T2xHZzJLQ1ZQUExWMXRRb242c0dpWUZYWTBMTjNBeUphZC9tb1RVTzJIUHox?=
 =?utf-8?B?c2dxVUUza2RmVEhKVlRlVHdobU14SThOeDRDNFV5Y1ZvdVRBbVplTkZJRHI2?=
 =?utf-8?B?aUVheUZUY252b0hsNDZTSEtUTXRoWVcweDBmVm1xcWtlc1V1a3QySkNMb2Jk?=
 =?utf-8?B?eWVQbFFEcmJ2MTJzU2lCMFZxK0pvYXJnVnV6U3F6elpHQXBsVVA3eVd6WTE5?=
 =?utf-8?B?MDhKM1ZmWTJHc0V3cE1MWVZETTlQbVVmbWlObWZJN08wdlRKa1EvQmFtQUdy?=
 =?utf-8?B?bkI1WnB5Rm1FYks0bG9EM240SzFIOGJFZ1hnMUdGWW1hanErdTN3ODgvdGVn?=
 =?utf-8?B?RW8yZjZDQmF4aUZEc2F3M1hEY0JrOXRjUUNYcGRUdTZhcGZORFYvUFNsbDJO?=
 =?utf-8?B?SG1zWVlML1puSDFHbUhUT1UzUXVDS29mREZqRmhBU2M1L0xMeVlPVG9HcDFo?=
 =?utf-8?B?cjMxNlBaZTl1bnRocnhiaFdYQ2ZQcU9QcnhXZFA4RzZxUzNCOFluK1JGWGlk?=
 =?utf-8?B?eG01ZW5KNVlPYXYzYUk5Si9rZDBxcWFvUjVjS0wvdHlGdkQ5KzdJMVNuWDhI?=
 =?utf-8?B?Z1RINTFxZXphMUtqRm85RGZmTHVCSVBNVHJ1cEF2dTBFdTRqOGNwT1Z6Yzht?=
 =?utf-8?B?eWxQb1ltNG1LWmF3VExsUk9QeGNFV1pqZllsY0J1bXV5QTZGUnZzZmd3dDBT?=
 =?utf-8?B?em0zUDlPMzdpMXlqNlFPOXFZc1MrM2tXeFdMM0xEOW1VZWM5R1I2K2ZlM2RD?=
 =?utf-8?Q?bJrmD+kegKTWHm1WzunMYo8EQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d7195e-1cb0-461c-de5b-08ddc630cfa0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 19:25:10.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6JA2gijsRfs/CoZnj1TyxqQYxC8tnYCh7lEJAjbDw3KtoNrESs+R7UmVzeFUMS9IrY8UKKoPQHUQrNc+iLpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com

On 7/18/2025 3:43 AM, Andrew Cooper wrote:
> On 17/07/2025 9:25 pm, Sohil Mehta wrote:
>> On 7/16/2025 9:08 AM, Andrew Cooper wrote:
>>> A microcode revision of 0 is guaranteed to exit apic_validate_deadline_timer()
>>> early, but a better way is with no row at all.
>>>
>> Yeah, not having an entry is much better. "exit" can be a bit ambiguous.
>> Should we be slightly more precise?
> 
> It's "exit $foo early", although this is slightly hidden by the linebreak.
> 

Sorry, I was being too finicky.

I meant that a microcode revision of 0 would cause
apic_validate_deadline_timer() to exit with the return value of true.

	if (boot_cpu_data.microcode >= rev)
		return true;

Not having a row as well would return true because of:

	m = x86_match_cpu(deadline_match);
	if (!m)
		return true;

I wanted to highlight that apic_validate_deadline_timer() would return
*true* in both cases, rather than just "exit" early.

What you have right now is okay as well :)

> Alternatively, it could be phrased as "exit early from $foo" if you
> think that's clearer?
> 
>>
>> A microcode revision of 0 is guaranteed to return true for
>> apic_validate_deadline_timer(), but a better way is with no row at all.
>>

Sohil

