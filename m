Return-Path: <linux-kernel+bounces-858970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A9BEC614
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 483F54E7EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27E726E716;
	Sat, 18 Oct 2025 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8R/x5ww"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9621423C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755825; cv=fail; b=YCQQfJ7KxgYvGYiY7ZiO20Jy+9HwjsJBRjLYhCl0iaHbhzYwdin4drYpQANLpzikDiwbkWMvXeVb1JFvFNaPpP2ldA+J6AhW7RxzbJn6RLlC/pXPNO4x88rCLRRJtg8gO1UszGNT7el7YwKrxEWX51ACtyAuOLP7x78rXn+udHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755825; c=relaxed/simple;
	bh=3vLm+Tr94cQ8DJLghmWhZnDPT4VmSeM5oMfpI/wvzPs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oorAL6vDUr7/gg6bzlLz2m2JdrVic/UVT2W4PB2e9sVwhHKTMFSo9kakE2LGoSi/8EZekTWNxBgiFkNJy9J7IiG6ctSLxLM5z6/5YsOQy+G+8TUN0gqLfCkQhCZz//dtYvuizkaPck04+pLhpoApMbZESzciJaorBd6Lb8QMCWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8R/x5ww; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760755823; x=1792291823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3vLm+Tr94cQ8DJLghmWhZnDPT4VmSeM5oMfpI/wvzPs=;
  b=N8R/x5ww8po3yIu6xFwCcCTgksYswo1fhNfM5cvh+PwPbutA3Wnb5h7N
   lvxCN60vb3gVRWj3paVT2xnhKN4ciBoch5pxK0eJos9TeugtRwFwdidNu
   TEAdMRYmcZpD4G5jNCTo3vtpi+rFb0I3NMbm1b/ZZ0WSC9XIUwngCmDD+
   3rTLur53cYP3j/AUT1SSMHK6a5MaEoTafqVt+aSMQ5CvaanoEU3gyxYka
   WU5/Ruzng/HHdpuxfzADa2/BK+IytZIxSyx8VjFgyT1i9Lt5VvP/lfNgA
   0YykBrIrqUCBZieVT0A3qijd4MiWO0OEAPnt1Rg8a3B5BEZ6dslhvjq7t
   g==;
X-CSE-ConnectionGUID: xHmT/7CRQiG4Wa8Ab0FxUQ==
X-CSE-MsgGUID: eiue9SeFQVWPSpq1Oi1P5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62886742"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62886742"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:50:23 -0700
X-CSE-ConnectionGUID: di2+ehirRJC5M214d14G4A==
X-CSE-MsgGUID: 9lpBTwGeR4214a1fjS9j/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="182820075"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:50:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 15:44:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 15:44:17 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 15:44:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8QcOp1kZIYwG93NGwP19QNX2snRZDiwkbxPYWSHs4gncqMbUrwLE+7t5KsjZ6glYvCVbZs55sEIfCBo3btHcUlgcno4d+zecJVnQzbQPNbLXyy1usF2ul3oaVq/HwlZL97g/7F1RV5wZnfm36N5IDz9eF8NzmpAAE49MbV6Ax4QP0diqLcYFgv0dVGGXAe+pi84RnhSKOsAK8EBGm32PrWaiZcT5HWKq5ZhxO0zS/8lGgrqcFIShJsbBB/avVXWI/pFJ99v6LUDNJPEhpRr2hYd2rek5LnUr3GmdHAiQru5fvyxRCy++cONWPAylsERN6fIMt1f4NGVFKpRJh8NPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhMtbLarULEYgLoeDoVQSsBhjwRv0UCbjYJB1gSVwvU=;
 b=ysb9l3WVwCkgxI7QgfQyz6ACb7vU8HAvaDagf9nLjuA9shwuOeWVgI1iTNuG4jrBNQvB7l6KUtByX9Ke2Z5/CgLPMlevScDRuqEeqBsDxL2wQIs3HdSaQuzwuwcloSGOt0sKXeSnlJG8QYZkEtevHHi/iuxd1YwDvELfFhV2+z5us+wXf5qUwwB42LL0hw4+xe4IDRKF7iDQHjqo+9HOPWLQJmX4sGWiNRbgR9uOXRqLuN3i6IRQjYOp/43LuY0500rh3W016dKqh4cFbGEtmohFRGLPMXlhejZZqscBOxu/MAjjGr8OfmHp5IKKrmUPmNmguqh8sarwyBu3ZxZenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Fri, 17 Oct
 2025 22:44:14 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 22:44:14 +0000
Message-ID: <9f0ff555-860c-4e3a-9865-b921b0f7d187@intel.com>
Date: Fri, 17 Oct 2025 15:44:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123
 do_clear_cpu_cap+0xdc/0x130 on Intel(R) Atom(TM) CPU N450 system
To: Dave Hansen <dave.hansen@intel.com>,
	=?UTF-8?Q?Lauren=C8=9Biu_P=C4=83ncescu?= <lpancescu@gmail.com>
CC: Salvatore Bonaccorso <carnil@debian.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
	Andi Kleen <ak@linux.intel.com>, Eric Biggers <ebiggers@google.com>,
	<linux-kernel@vger.kernel.org>, <1117002@bugs.debian.org>
References: <aPJNPPFKsPKJWlLn@eldamar.lan>
 <a7fa4a93-2d80-4c1d-af91-9dad9626ed9f@intel.com>
 <CAE9TcM+AeG8F0PubxAcmSWd=unBiLwZK1xAvCGjXk0Y-+YBaJg@mail.gmail.com>
 <45a02791-dcb9-4d70-ad77-4fdcbf556c15@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <45a02791-dcb9-4d70-ad77-4fdcbf556c15@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d61fb5-e8ee-4505-68d6-08de0dceb261
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTNHOWwvNmhPb0M4Z1JIcVRyZ3F0clJtY0VYajZOUWd6bVpLY3BoYW0ySEVx?=
 =?utf-8?B?UENTYzlpTWtZZStLUTJEaTZETlA4bWZQcUhaMjVaNUFVdTJRMFBwVXZQVmNS?=
 =?utf-8?B?cDkzbURBdFBnNUpzTWMzRXoyRDNEZjJBSlQ4eGlIRXAveXNsNU5hTnBOa1dB?=
 =?utf-8?B?Q0RmdzB4UXIwc2ZnWlJISkQxOHQrRzdXZjM1dis4MzN1OGJhajVpUXo0Qml5?=
 =?utf-8?B?bmYva2pmSUJoanNEb1JpbE0rT0tDV1BseUp4NERsM3AwYTBRWUh4T0pRM1dV?=
 =?utf-8?B?OU82ZmIrWVJCWWdwTXRFMTZCcjJ1dm5icFB4WVNaZTVrdU0rSVg4OUpkcFJX?=
 =?utf-8?B?eC9UMk1RaXFHK2RWOWlpeFJ4bDRCeS9pZW1YWTFWMTl0Y1U4Z3NLWFlvZWc4?=
 =?utf-8?B?UU5xMkJGTDhwcG9ZSTVOUE5JTkNldXR2citxZ2xxUTlWVzRqRm9oSmFNbEVn?=
 =?utf-8?B?cm0vNzBsazZyZ2dTVUhRVUhRMi82L0ZLbE5PR3RJbVU2czNRSlBuNGNZQVdl?=
 =?utf-8?B?UjR5VTJiKy9SYVZ0UkVYYmtrZlI2amVZK3drQTZpeFlHRFl6MmtFVTc1UjJS?=
 =?utf-8?B?QWtXejhld0ZVUUN1aDhNSisxcjVGNDZrYnI4MlhicUVQcWtmclZXc3JjMUo4?=
 =?utf-8?B?Q2UrVnVIQjNqU1prOTRSbGhxeUFMbVVMR2FmMmErSjJSbitnbW83aXdBdEll?=
 =?utf-8?B?Tk5MSDRIUjVFb2k5ZlRBbW9waVNEL05Mck50UDg3dGdVUVJteUV4aFQ5QlEr?=
 =?utf-8?B?ZnFkMncrZkJELzFzbXFxWUF5N3BWWDVacW9qL1E3VFpwVDZqTWJKU01rbVZw?=
 =?utf-8?B?czVCTVhLMzd4Qkx6OG5pa2lPMmoxQlliU2tncEg4QnhOMmZ6eEdnVXJjd0xn?=
 =?utf-8?B?dnkrZHdXSDBlMWc4T2JKWU56Vlp1YjNoaU1rSDJ1cnFnbDVTeFM3VWNZTGxK?=
 =?utf-8?B?c2o1VWQ3RjRwRWlEZENVaWczNy9zMWJIOVlsbVRmb3RpZEc4VUxGWE91UFlw?=
 =?utf-8?B?OTVyRjhLTm00TS9OZTUxUlEveXV1RitDOWQ4eUh4bk05U2RFVkZ3Q3EzQ0RH?=
 =?utf-8?B?OUlkc3p1N2Y4WUQwUDJJNXZuOE9ZQVptVi9SVUNMMFZTUGdEK3hmQUJIeWNz?=
 =?utf-8?B?aVhINm4rOHRnNGxaODdsTkxMN1cxRVNYQ1d3YWFDZ0xZV0Ezd1BOTWRQRjc5?=
 =?utf-8?B?Rmp5U0EwUnlRWWpLUldxVXlyWTlIbUZtNnpRSGJxY2ZrY1lHeG1LN2tPTmU4?=
 =?utf-8?B?SE95czdVeXRHY0ZXRG0wZ2N5OG5JcWhVbWxNeUFBayt1R1NZanpHR2hFSTd6?=
 =?utf-8?B?SU4vN0VhOS9BbWU3V2tXWWZRdFY5anJVYjFFQ0Y4cXFVaXNpVjhObHRkS0Mx?=
 =?utf-8?B?T3NOZ2dHZklEUTBtNXhEVGJqVGtaZUxqOG9aeVJoUGw4QXNnSTVlNEM3UGRV?=
 =?utf-8?B?Q0h5SklocTRoQUwvN3o1emJKSGRkYzlUMXQ4WUNjdlZKSStSamZKWjR6SHYz?=
 =?utf-8?B?WVdERWwvdEVnQnloRHBnU2ZwY2JaOWErQVNPYUpKcWpxalUwUGxLVjFTeHli?=
 =?utf-8?B?blV3VG9ZWEc3ZFlCeFYxUDZQTG5EdUdCdVZtZmJhalpuV0NPK3VMc1Q1djhK?=
 =?utf-8?B?YS9aQWdwNmtHWEVyN1FxMzNUWFZIcFBncGVaeDc4Y3ZUWGlVZjJYVXdLdlZ0?=
 =?utf-8?B?LzcvUzJPVkJXOTZ4cHJ0RXhqbU1SUUNRZ0xCY0pDOGxuQnVDYkpXRGJBdVlo?=
 =?utf-8?B?VnhpUVUvalVvQlM5NEFGeHNiNTlFSjZkaW02cUJkM3NGb3R6eGt4Z1hUWGtX?=
 =?utf-8?B?T3hYMHJaTzFQQ3dvcTRZc0Y5Wi90UzRSWVgvYmEzWHRIUnkzSHkyblhoQ1My?=
 =?utf-8?B?R3dTeXltaFgvSzVST0NvbGNMbTJVWVBpRnMrRm9pSzhyd0ZrMTNJMGQ5MjVE?=
 =?utf-8?Q?Wns0Dsvo2WJC27mUMIOUP74Pno7+2bev?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekl1SnNxeGVGRTkxTzJlVTFicUplUmFmbThhVUd2TFpZaFhPRkdrcnd4V1N0?=
 =?utf-8?B?Z25semZCWkttallmMVUwaFZvL2tOOW00enBhc3Zvd2FMYzlwdHI5L1FPTldM?=
 =?utf-8?B?VWFRcVJvZmZVMjYrZW1rUlI5a3ZWcC8wVVptcjV3REVXVVNTZG1yaWVyWW9B?=
 =?utf-8?B?aldGcHdYRDU5djR5SVljN2dsSStLcHg3am5MNlVYSFhSa2toUzJQa3RRV1NR?=
 =?utf-8?B?Y0dJTFRNNjJka21CWXA4SmJib2dPOWhYeUR6b2FuYjc2cExFam5XdEFlTVpU?=
 =?utf-8?B?UVFOcUFkZ1lqUUV6dEhnVjZ3WTcySXBOUEh3UWZtTmpzQWdQaHdMbjNmb3F4?=
 =?utf-8?B?eXdvcngvRUpVUGxQZXVhSkFZa2hLOC9BVEJOaHRCb21HekZiT3QxcEZUT0h4?=
 =?utf-8?B?U3hIRVdQSlI3VWV4alN2bXNXUmpIZ2ovdmRzRU04SnpNem8rNkhDejdwWC8r?=
 =?utf-8?B?RXljOGc3ZVl6VGxreWEyc0FOd0tSVXh6cVVUaTZxYUlqWjkrKzVWcGZuSlBx?=
 =?utf-8?B?SmQ0VFdQUC9OLzRqTTIwdUhMdHVPb3pwNDUzTzNiMURyeC9nV3hodE5sVmEr?=
 =?utf-8?B?OWtQSHVmQk1ZWUVONWVENTVWb0hINit4T2oyY0NUODZCcm84TEdMb05sK0hT?=
 =?utf-8?B?RDdBM0orY2dzRVRpK21Vd1ZodWFHeUdwTTJjWVVJQXhFamllN0I1OFZzNm9x?=
 =?utf-8?B?dWVCZ09DVDN4Q0hjRFZGU1hMWHcrMHBqLzN5aVNKeHZLTmlDd2dneWdjdTJN?=
 =?utf-8?B?SjZ6M0NWRTEwbUpzWWVMcUtmYWd4cG01RWNFNUhINStvRitRYldKbFJ4cll4?=
 =?utf-8?B?Q09sNUpQZ1NrS0JndUtEbmttRWtOTmIxK25BUUVRY0RNVDQ1TXEzL1FHc2ZY?=
 =?utf-8?B?T0ZGWG5tUUlzTkZVaU90SnVLTUU5U3EyZFVFMy8zOElZK2E4ZlpCaFAzU2hh?=
 =?utf-8?B?Qm04ZmhwNkxxcjVaK2RBTVZVYjJPbXJjZ1FnR2x3Wkl0WEdjbktia1JWQm9N?=
 =?utf-8?B?OVZ3REtDcEdQeXVqekJkU2w2RWxaNEg5MlZpTk5kVVBpSWNHM0U1T1R5bThT?=
 =?utf-8?B?WjRmY2FEYnFRdEpoWCtiYzZVYm92Unc2VExnaGQyS2pkT2ovRUYwajJieUJY?=
 =?utf-8?B?aDBwTDliOHh0RHdtemRKY2lnSC95WVhmNEVEK3F1eWdUcTc1YkRPOGg3blZx?=
 =?utf-8?B?d0g1aDdlMVlERnlETWM0dUNJNk9mUDNjMUpsR2UweDhLZ0ZzdlNLVCsyOUNL?=
 =?utf-8?B?R2o3Ri8yWFplODNWVmdkSlJOY0lOL2FVb0FLQjBjZ2VGNE1aZVdBaEpURGR0?=
 =?utf-8?B?dW1KNk10anlRK1pQQzg1VUFmNWdoT2Q2bUZWVVNQNmpWZXFSbWVRSnBCWVJ3?=
 =?utf-8?B?TzhoWlZBVWs1VkkyUm04aWlNUmEybnRZUTk4TFRETFB3T0VDbVpqdlc0MVVQ?=
 =?utf-8?B?VkZURDJ1K3IwbWZod3FDOHhnRWJXamdlWHFIcDhsV2MzeHhCVFQreTVGVkJw?=
 =?utf-8?B?RlVvbjZ1am1MWEE0RDVRY1JjV3FzZUkwZXhtYk5iZGgvaVlsSDdhMm5tVkRW?=
 =?utf-8?B?UjJZMDNQdUtpQ3ZKcWVOVTF5OU5FbStIYjZXWWwybVBMUnhNMHN1REZYYzJD?=
 =?utf-8?B?dklJOFNFRUI1TzJYclhIK0FmOXpnWG9HL29UQmVkV0xkUC94YzU4RENUNGY4?=
 =?utf-8?B?dEdLbElCemQ3YWdtVEZ5R3JaS2diazJjWTlzTU13cFRWbUJmb1FpUmlwU00y?=
 =?utf-8?B?UHJxN2tZQVp6L3pwVkdvK3J3NEZEdnBKN2pudkNYTzRvcTRMVUFDR2RLZUds?=
 =?utf-8?B?d0ZzMnZyQjZuc3F3UUE1K0VzbGttNVl0dDRXKzZYbGNrazZ0S0JNaVlteG5M?=
 =?utf-8?B?ZEVhWnFwSTNjQXFWaG5qS29pVHVKbWpRTFdNUnNHRWJoUVF6b2RjL3V2aDYy?=
 =?utf-8?B?bUpHcEUreVBwNFl3b2MrdjZUOXdWVTZKL3JDRUxnQmNuOER5T0JYalJ2WFFH?=
 =?utf-8?B?bWk2eGcyb0Rad0NJcEJaN2hNKzhNQ0djVGpOWWFLM1ZuM2pZTGRncFlPZ0JZ?=
 =?utf-8?B?R09TSjNiN3lFZjVmL2t4UFgxb3JMNjZ0KzA0YVJZNkFIbUw5ZUlpazhhV1FT?=
 =?utf-8?Q?cRR3qpBgEF5O+V9wahz3R3V7d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d61fb5-e8ee-4505-68d6-08de0dceb261
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 22:44:14.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQNtaOZ1C1LrrUNp+breY9nYBj3oO3y+kF8Hp/rE8XAlgp14VE5ctbjElBKuWczfb84c85ekJc+VDlezA7dk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com

On 10/17/2025 3:01 PM, Dave Hansen wrote:
> I'm not quite sure why newer kernels are complaining. The
> "alternatives_patched" check has been around since ~6.10. If someone has
> some spare time on their hands, they could bisect it. But I'm not sure
> it will change anything.
> 

I would bet on commit 15b7ddcf66fb ("x86/cpu/intel: Fix fast string
initialization for extended Families"). It started honoring the
preference set in MSR_IA32_MISC_ENABLE which seems to have unmasked this
issue.

The commit has the following snippet:

"X86_FEATURE_REP_GOOD is cleared in early_init_intel() if
MISC_ENABLE.FAST_STRING is 0. But it gets set later on unconditionally
for all Family 6 processors in init_intel(). This not only overrides the
BIOS preference but also contradicts the earlier check.

Fix this by combining the related checks and always relying on the BIOS
provided preference for fast string operations."

