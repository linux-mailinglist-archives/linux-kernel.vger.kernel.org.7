Return-Path: <linux-kernel+bounces-776499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A85B2CE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E095B7ADA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D21342C9C;
	Tue, 19 Aug 2025 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLcCEx3T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D5266580
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636119; cv=fail; b=ZD0jMADUu9uL/aPyB7VwhvqPmb1tSxeNvlCXmA1PuPlRwPzVubXUWsuoTmVO8iH7rdAAipRN044fuUstMAi0pg6Ug2BnfRppSXZyolJuY8qNFmgVdwGcGj3rS3c9u0/vQLk0o8k3M3WptPk4xYfR1hw53ajyOCSZKnG9/Yi8+8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636119; c=relaxed/simple;
	bh=iczb3sECujPiiFzPiFzKXVy48YmIxLmtwHKHNJ7RFpU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGn9gGOK3PcTmd1JKLnu4q58Ctc9IWrx/ogJu3fWQBqT1fTb0wK3sSAAlD+Ox6lEvPOXd2UaHFlv92q7UUVEfcZ3FY9lB2DAMqP76Ei2BNN48lPm4RbmAxHivv3T+AzTMbWCNA9S6pnmIR2+FLBK4soOAU4v/aF19ly3LAjF8wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLcCEx3T; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755636118; x=1787172118;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iczb3sECujPiiFzPiFzKXVy48YmIxLmtwHKHNJ7RFpU=;
  b=fLcCEx3TaFfSgqrWJemtcsxB06dgUwxpS68gNU+SjiT42Y0NK+yTd/SE
   mTBwMli5ULuHfN9cNPxNX8cYXZMRU/G+mQjR8pzjZB1yRev4b5AuETx79
   cUG5EjtD1x7o925CgzJ6XRfyhUg7w5KoXkSlz29swOWOiyW4NiM0FqAQR
   rkX7ywOC+WUVhn3RPw+QlUaiYZAKTBloIrcNLxzNSnVqOx2GYGwWJPFyH
   RzgGZQjTiRGaudnGfGXLUdDr8hSKZYeAgG/CCmcARLq1qMPuJ4kh+ERDi
   Tfn0PZxHkBzQ1cgnhGI7WvCy+hRfUeO0OFs0BiFBxYrHImMQXSArzBlGq
   Q==;
X-CSE-ConnectionGUID: HQNepxMrScuAiaS5FAs2aw==
X-CSE-MsgGUID: 8PLHEA6XSc6lr60b3Vi3Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69274858"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69274858"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:41:57 -0700
X-CSE-ConnectionGUID: mAb+1H+DSz6tPSm0s1P/Rg==
X-CSE-MsgGUID: 8EEofJ0SRGevXysRn8ZfMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="198804222"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:41:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 13:41:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 13:41:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.74)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 13:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFxMmVVZrh8WalB/8410fvGmrZNYwQRSkhfvHFDmlSOJcpktKGDuFboCI5KZSkdyv3okBdZmE+KBerC/MlEphdvpN43tuP/+sOUGutedHQECZsevcJO60Cf4J0dD4bWej0E/aCZUvd03TPR3XbpYrjNVb1P91vSLPXUC7uEQCxSBzsFbpnOOGwYbaNMoQgHJKFT90Fvmk3yHWvQlXkB+dKeiH6GDC4zpp5POjmwarrH93X5F0kgX8fSrzn4moPsu1tLhGbEoA2g8CISdxVElODaYj3ge2cs4AXyUZxen5722xV2edlNjbEHNVzPt+mB746OSJvIQQXHbQUg/nFYaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TEbIblOwKqLqHH5UoXZerLWqi8C2zK2vZJUPlQWiQo=;
 b=Z3pG9HN6N/Xk4XDRM9YKTroIZpNZPoH0jYGaXfPxjX+daLHH66V8pOFEj5jGtxB95MfjydCHn8ZGJZvxMKVSEcorJ3lpZ84wvBiHGxGvQVcIN5rGVWO/1G/iP1HHwe0ilXEo4GrZa/OowDTarX8CKQv9ZXbTFpQGxin7sVg2LD57OtGPksJfRDgAe2uwBipFRTjy0jzjd8pZfGv58RkuNWRDcOvHgW0hBVAt7VVXTdxjWQa9pl0CrEIG1AyqMTTNpNgb+7Vj0/csBZpFuL0tZV0iP11F3LwGkz7kOowoQ7e5kEdXIoscwHIvoGdbf1TcYmsDiMeIQUCVADZO0nR4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 20:41:52 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 20:41:52 +0000
Message-ID: <1f0c8d56-a601-4f52-9d10-76c90f1cc521@intel.com>
Date: Tue, 19 Aug 2025 13:41:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scripts/x86: Add a script to update minimum Intel
 ucode revisions
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Alex Murray <alex.murray@canonical.com>, Andrew
 Cooper <andrew.cooper3@citrix.com>, <linux-kernel@vger.kernel.org>
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
 <20250818190137.3525414-3-sohil.mehta@intel.com>
 <fb121cc4-8d4e-4daa-af9b-daf531c12db2@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <fb121cc4-8d4e-4daa-af9b-daf531c12db2@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::22) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SN7PR11MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: afb5d986-d979-45ee-c944-08dddf60d3cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW91SnExa0IwWmxlWHU5ajNuVkVFWnJNQzVaR1prcFc2N081RXFSZXkvY2J3?=
 =?utf-8?B?dmlGTjZVVFhwcExzS09WM0V1Z1lvditZb2hUNzMySmVoNzlMMk94QXJ2ZjVN?=
 =?utf-8?B?RzlrYWFESmZEc29vSng3Z280ODdEcS9kVUM0VlpqaFcvUzNpc2M3MG5tVkpE?=
 =?utf-8?B?T0VMUm5hektGdC82VndYcXNTOURacXBUM3Z1UEpZQlM3UXNEbVV4OFJlRWJX?=
 =?utf-8?B?eGozbmNDWG5oT25rdDA4WS9LcnJCNFFvM21YVUhYQ3lDV3dBai9jbXpKaDM0?=
 =?utf-8?B?RUwzSExCT2pGRWgrQWZNYitLRUFOQXo0STVQbktBK0xEZGRZeHdkeEhMVHI2?=
 =?utf-8?B?SWNkaERZazZ5SmlWczRLdXFHcnZaem1ncWVIYkEwN0FMU3dFdmpKREN4VjM2?=
 =?utf-8?B?UW5hcnpvSzRxWWgzYm1xMnkySXN2c0VYOEhSS0ZTZFNHdVF2VWVxdEpMaW8y?=
 =?utf-8?B?aS9IdFlhT2tkNjVBREZzd2NGc2ROeU84b3ZjaXBNTmhIZ0s2d3cyRXNwajRF?=
 =?utf-8?B?dytIOG03MTFHRmNnMG1zK3B3TzdHamxPd1luNFZ5V2xwdEtqb2VIZ3oxUEVP?=
 =?utf-8?B?ZHY5dlVuWU9kY3BncVhsMktLaXUxY1lQWW5xWXNCL2hWS25Idkx1SGNxTk8y?=
 =?utf-8?B?d2YyL1dRNHhBNkRsbm9aZWRuVnlTaUZBNW0xcDJIZlZnSk0vVmlaQkR1eE83?=
 =?utf-8?B?STJVNVFxQ0tJVWttanh5dDZxajI5Rko4blZXekhTU3hzZFY3bEVmTzVEV2xX?=
 =?utf-8?B?NEtHRXdaWXBpOE1LN2NRS3dIY0E1TGV2ZGltTHpQdmVZdTlKQnp4Mzg4UVRE?=
 =?utf-8?B?eERBb2hyWmJhZFU2WVk0MHc3Tm9tdHEwcEJHbmtIeXlEcHpDZlMySkJnM01h?=
 =?utf-8?B?WUFlZ3RrQ21Ta2JCWlpCdnNJbEE4ZnZid01wWjZHUjFmdmlWVU9naXpBM1VC?=
 =?utf-8?B?eVd1TDU4L21yL2lBWVBYMnBiVEorMUlBSmU0dXk4WCt6eGlJd3cxUTdXUTYr?=
 =?utf-8?B?YVI0dlZJcjNyZHRabE51R0tmekthVVZMbmUwWXA5WHdXaU4zd3l5WGZTQmpZ?=
 =?utf-8?B?d3FKQVFpQXN5dm1KSDF3VTNUbHV5SUZYY2FuZ3FsbTBFWCtGU2V3bHpDem96?=
 =?utf-8?B?NnJTUWhSU3hpL3dtcVgzaGhCL0JXUC9aOE1IRUNZY3J2RHRqRlZwNDQzTHhq?=
 =?utf-8?B?eDlKcDZTandJRWl4TXdMYmswWEY1NHlqT3dDUUJzb1hRZDJhY2g5UVR5VUtN?=
 =?utf-8?B?OXk1SjJSdHZ1bnVzNWpyUG5ab3NTYVZvY3dwVGdndi9iYi82Nzh5SlVZMzdG?=
 =?utf-8?B?QXdqenZOWEw5ZGMwS2R2c2hScXlDRGtHNnRKREFVbkNUeUxsNW1yMG0wMTM5?=
 =?utf-8?B?d3Q1RGJxdGQ1emx0bSs0eUxFMTZCQjliUGFJMmkwdTJoNmdtRmVqNHNIbjdN?=
 =?utf-8?B?KzZUTC9YVjR1SFYwdXY0RVRRQW4wMWM4MWpObS92Zk1xRWgxZktlSW5KdEsw?=
 =?utf-8?B?ZC84NVRCVU5PZEN0eVlkRHE0WmEyQ2Y0V1BwZi8rTW1qc1h1dTNOa2VZaUkw?=
 =?utf-8?B?TCtrMXB0bGIzUThxRmxISlJ6REZHN0JNNndDSnZKTTY3RWkzbW9RRlVuMi9v?=
 =?utf-8?B?QW84SHNuS2RDWDVKM2w2WlNYcElRaG1pR1c0QzkvQmU2V3dsM0dkakIwVU1j?=
 =?utf-8?B?aStZSFVqb1Y5bUVUT1p0WGdSYURkVnNna3Vtb3Y4V3h4emVjdGdzQ0o5d0Zm?=
 =?utf-8?B?OGxScnRtQkFmK01yMkRHd2wzU0lnTS9lVU1FV213U1NzbTNJSE9lakE0dUsy?=
 =?utf-8?B?Z3pFeVU3dFU3bTByRUYyb2w2TFZIL1llU3l5NjcvOTVUbTBBc1o4Q05wajRC?=
 =?utf-8?B?WXFwWmVzUnBhOEZuSEpJdklKSURicU5DZVJpZDk5NXRuVHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW05Mko2cTlrRjdKam5EVk40dFh2WkEza2M0bUh4TzZlQ3lGNFJ6Rm1TM2dV?=
 =?utf-8?B?eTcxMXBuY3I3QUhiM1A4VmhESWlrQVM4MnlsTXhJakxucWUwVWpTLzNZZlhK?=
 =?utf-8?B?UGxpTFVlM3UvaUtRVnBYUS9PcTBvN255UGk1OFFVdlZHdEFBbGw2NTJmQi9h?=
 =?utf-8?B?RENPbzB0K2pSaERjZCt5YWdBSGRnT2pRYVoyamEzYWdYYjIxQVhjQ3I2SDR5?=
 =?utf-8?B?U3poMTMxTmw2dDlwZGpPbUZaOWNwd1REekM3Zi9yZjRwcWszTG1Xb0tMOVdH?=
 =?utf-8?B?bGJWQ0c2d2IyalMyM0ZWdVZxU1RocVpla3loYUlvVGVBaXM5aGE3ZTFYZmhn?=
 =?utf-8?B?K24zaCsxWFJnTzY2MmM5TE9ZRXRTdEJmVkgxc29UMXJONm1MSXhlaUE3UkF4?=
 =?utf-8?B?RHc0elRQSVJ4ZGhuOC9OOU5sMm56S2tDN1VxYmVBREpZb1dMOXFKaUJsckg5?=
 =?utf-8?B?RmthcG80ZVlFaktzaHhMZ2c4NXZDYnl2WXJkV21tV1UwNGRvdFIybEVkOTFX?=
 =?utf-8?B?YU9qcXBKNkdwK2dsKzdkWWN2ZjRXMzlUdFJjdVpoOVR1TEtybnZwOHdrY1c1?=
 =?utf-8?B?SDZTcG95MG4vSWZZWS85VFNRdCtXb0hZbitpU1pwbUlKbzR4aFNBcXd2WkhZ?=
 =?utf-8?B?OFV4NWNRS3VXU2ROc05uZHhXSHZ6bmlmUmJ5cjdQNkpBZDhkRVY3WTh4dnJz?=
 =?utf-8?B?SG5WVWxvczVVN3d3TUtlN05wTVJHd1dZNWQzR1djdnpwOUw4bTZ3UmFrRFBH?=
 =?utf-8?B?Ny9FaXJXVzVzSUMzaTdGR0VuMEwvblJEMDhuSTU2Q3l2ZVdiR3BTL2xuQ1Nj?=
 =?utf-8?B?Y3llWjVFeE51RGh4TlhRZGUwaytQN1VpQnVLWmpHTHZkUDFuZmlrTnhwc2h6?=
 =?utf-8?B?MFdsY0VhMm83TUxobU01SnZuUEVLRkJ4cmpHdUhGdzhnOExJUzRPOUpzNFd5?=
 =?utf-8?B?dGFUTkplK3pReE1qWWxPN2xVTFp0MDJ4VndSQWgwbXdDN0pTZXltRlQzRnJn?=
 =?utf-8?B?Z1VSaEw1YmJhdTZBK3hCdmlEUFI2N2p1V28yR1psTHE5dWM5bXpha0tEWlBr?=
 =?utf-8?B?Z2ltRlhXdWpQaEJmYngvekdneEIzcUwxUi9ER2k1TWRsQ0RhSHNobSttejJm?=
 =?utf-8?B?NFdxNW9lYTlsOVZRVlZVWjd0bVQ3ZEI5SFZ5WmRjTEN0Q1lYejhPZnhZY3c2?=
 =?utf-8?B?cG9ib1ZoN05NWU50aVBaUDJhSUFDVlR3dmZ3UUp6NVg0ZVQ3QVdvUklVM3Fv?=
 =?utf-8?B?dDNUUWRzQk5UdElRY3BBOUl5Yml0SG5INkhpWTdHaU5ucHRoa0E5a0tvOFE3?=
 =?utf-8?B?bGZwOHFrYy9USUlBNWcvMmlUM0p1SVYwVStZalpadXAzNU9reWRpTFJWelor?=
 =?utf-8?B?R2pwY0VzOVVucXFmSFdqM1dxZ2sxenhlL1NaaGdpdXJ6dGFLSzc3c2pDWnJr?=
 =?utf-8?B?eWFDYk54Sy9IUjBBeFV3cENNT01XZTE4NUNFd1VsaklmL3ZIdER5UkExL0tF?=
 =?utf-8?B?YXZPLzcwOVRPbStZUlpTWWlUQnQyeFdwZ2RnZzZpaEZzZWlORkVWbkRId2E3?=
 =?utf-8?B?TzJtdmJnelBhN0FBNU1KZFJTWUIvZDhEWUhIV0hGSjJpWW9TVlNnU1RJSEt2?=
 =?utf-8?B?Z0cvRjdQWlREcnNqbFhmQnBWbWd2ZmpRcjdFQVdqbzNDZmpDbWVGTnFqVlp2?=
 =?utf-8?B?WWdDdDBwR3BSVlFkcUJBMnNrbnNRRENoN080eFlmZlpoVnk0SnlnMWlXRWty?=
 =?utf-8?B?OGtZem9SdWpRaHo1eW5wQVJ1cEpWTVNYa01CTXFwTE1OTHpaa3ZOZ0hGMTlM?=
 =?utf-8?B?WUNYQVNzU0FwY0JiNCtiQ2gzeTZIZldZL2FEa2h0WllpY0NGTk9EMGRIazY2?=
 =?utf-8?B?eG9KMDVyaE1NSnQxYm9UWVhKQ3AxbXhEWUoySlpMWDFUT29NUzVIVnJvc2ZS?=
 =?utf-8?B?S2J3VXA0K0xIMGUzbzJxQmVTL1NzeGJIby9OUDdHa2RWMFBpOXJUMDZsUlpX?=
 =?utf-8?B?Tkp1VnRIaE5wVUIxZFhraElyb2hiT0I2YklpOHkwaEtlTTVoa25BeGQwQzJp?=
 =?utf-8?B?bWhTa0VTQzdMYXJmYXRsTmh2UjZlVml5MlF5ODArYXRIZ0VweEx0UzNVNDNY?=
 =?utf-8?Q?BmTanWNfMJqE5J7dt4VzYtAWe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afb5d986-d979-45ee-c944-08dddf60d3cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:41:52.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoi2yDqLvbxIwO2p94y1sdgXmyLm9zS0MgOViJR2/yjXcTkrsA7IESazxlOxTwSMX1J4JFeB9iLbZre1bDml5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com

On 8/19/2025 10:14 AM, Dave Hansen wrote:

> But with your version, I can't do that. I have to create the header
> file, then point the script to it. I also have to consume microcode
> files from a single directory.
> 

Consuming microcode from multiple directories is easy to fix, just need
to add "nargs='+'" in the argument parser. Will change in the next
revision.


> So, it's less flexible and harder to use with those command-line
> arguments. It's obviously not the end of the world, but why add code to
> the script for this? Why is it needed?

Though the script is less flexible, my goal was to make it easier to
use. When used within the kernel tree, it automatically selects and
updates the header file, since that is always the same.

The usage was supposed to be simple and hard to mess up:

	update.py -u /path/to/microcode/files

The header argument is only needed if someone uses the script outside
the tree, which I assumed to be rare. But I understand this limits other
usages.

To make it flexible again, I can get rid of the parameters and make it
print to standard output. Users would then redirect it as needed.

	update.py /path/to/files1 /path/to/files2 > /path/to/ucode-def.h



