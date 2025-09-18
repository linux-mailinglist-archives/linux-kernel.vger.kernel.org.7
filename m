Return-Path: <linux-kernel+bounces-778171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07CBB2E22F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95249174962
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46164327794;
	Wed, 20 Aug 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fv/NXtjd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6EF326D72;
	Wed, 20 Aug 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706710; cv=fail; b=Y6CwNwV+cQnHwMLhGZZxX4VUM9pZURBCuAEyNgUAYUJzgaiNUSG0wx73Bufq1iJpwtc6D0YKaqjIRX/1pq4zbk+avw4MjVsRselPMXXzt9c0T1yvxNgKswBoBw28I544FmL83EvIvKSGRedl19cMPYm/iiQuQmnNAI+nCy66PQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706710; c=relaxed/simple;
	bh=54MiAa2Ugm8Fk0oHwAkyS2LeoIivs3eQmFcKyrSUKEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BYHpTYBvQtbqk8Pq34binNy8VK+jwxNlECxDtJ74HKmlBjttMxctEOvspuHvxcnRg/Kb+/+sBvUcMcV+TL24ojjp1NJ4Vr2mzr2uBFBHOMXafW7L7OLmN0sqPHeh308LSulX4R8+iXAwGoihFb+yg5b+nx1todLh0Q1o4zDglgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fv/NXtjd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755706709; x=1787242709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=54MiAa2Ugm8Fk0oHwAkyS2LeoIivs3eQmFcKyrSUKEE=;
  b=fv/NXtjdxON1zt7501qq2Q7HC7ehHsgc2mYeHFXG+d8zodxptoaRVOth
   kW4caEd9RxrG0qa7BhLTa5mlHuGCIi59ycxmlL3EQRvKu2wRhQRZldEfX
   vqsBvpcgnLmPyAjro9zDS46flDrtIj+ocsgfBJfeQH15W/4J+1hNqdE3V
   CDUfTekWkmx15M2yxeosT7+d43EaD5gnt3Jgm9UhM1I4cI6avA2defIv8
   96/qn6ImB2JckbYqA9w6wQR7sdzTsEHiCdsCf8CywbB+kNgXhujOcPLwh
   R+YRTo3EQYIwfE5d23PwI60fVJH+dkl1SGfp//ceD65dJLDR84Mz433dN
   w==;
X-CSE-ConnectionGUID: C4WYoZpURWmuZlYIfDLQOw==
X-CSE-MsgGUID: ZvTl3dFqS/q34XB0upzi8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57895551"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57895551"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 09:18:27 -0700
X-CSE-ConnectionGUID: ZUFmn6vWThSZQ493+QlMhA==
X-CSE-MsgGUID: BMINejUuQJ6KRK7SrjQq4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173422303"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 09:18:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 09:18:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 09:18:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 09:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6befs9zPetmsw8vQ/wq0Y9LO97hU4VaJU8/Kfb49r/JyOqi3J/sdKl7CI+LQj8QsMXFDn92btFkA8EkcxhntABlVwjF0G7dsPHyplfniJpgqBQDhdIYHYlyj1/Sds54uTvyriNE04E6YeQbKYwhyl+1PqHbdftDXqJoR5RRTDQHecJLxpHMC0M8XumnlzPGxxzZctFHhWHBDMygzFYVPvLsbEXx9DuyptS80V5lXQdaiCYjfTxnmZwAlq1jhOXkF9gtu7RsH+oZ1hA3+P2JrPPw9roes6I4KVK0MnobzcHNjNV123DR+AUNKWoW54vJUNgvgGJ45sC5pvtwmLjdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54MiAa2Ugm8Fk0oHwAkyS2LeoIivs3eQmFcKyrSUKEE=;
 b=ZjmtqEHKvp3gA9Kef61bLkw9S/nWgRKJkWp2bxRuyF9/qbn7gtJ90jXKW/61BtALrEZMcZH78ivtub1bsajGI91xe579Pn9iYmk+dHYgc4pHF3UlRw9o/Giv9Ef/xG4zss/yK5ucz99rOuPoxraEITJwaHovyfDdaHrtojOaMfFv8tI1M3/qGHVHKJ1nClVjWnxAiTHFKtr1yBtNuSHaIiDwTAQ+MSJXePVxC4aWSJLOpG0RjCxxc53Jqp1OVDKiPcxUeNd+rZAEgavXqdQk6tSxlsvtiVeCjzNe9DGp5vdmtYUOfgRkQkekgAe7Gxttrt2Bed/NviuHQdFF4aKR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6910.namprd11.prod.outlook.com (2603:10b6:303:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:18:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:18:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC: "maz@kernel.org" <maz@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>, "mbland@motorola.com"
	<mbland@motorola.com>, "david@redhat.com" <david@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "joey.gouly@arm.com"
	<joey.gouly@arm.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "pierre.langlois@arm.com"
	<pierre.langlois@arm.com>, "jeffxu@chromium.org" <jeffxu@chromium.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "kees@kernel.org"
	<kees@kernel.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "jannh@google.com"
	<jannh@google.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
	"qperret@google.com" <qperret@google.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
Thread-Topic: [RFC PATCH v5 00/18] pkeys-based page table hardening
Thread-Index: AQHcDcJlv4XRCffEXEeGrdGfSH4E3LRrub6AgAACGACAAAS4AA==
Date: Wed, 20 Aug 2025 16:18:19 +0000
Message-ID: <3c18d1f1e94d3491410168e37cdf67e9e471649e.camel@intel.com>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
	 <4a828975-d412-4a4b-975e-4702572315da@arm.com>
	 <5b5455eb-e649-4b20-8aad-6d7f5576a84a@arm.com>
In-Reply-To: <5b5455eb-e649-4b20-8aad-6d7f5576a84a@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6910:EE_
x-ms-office365-filtering-correlation-id: 04045c70-4497-4967-f209-08dde0052d46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?STVQZWFqd0RxeXRzM0s4SEx1RDYwcTF5NWVrZm85MlhmQ0J2RHAvdVJIa0dt?=
 =?utf-8?B?NE9SSS9CY2lDWVpaT25wd00vZmJ3OTkzaUFXWFd1RjJ2RW5taXk1VHhLeW1G?=
 =?utf-8?B?US90bXZiZVEwZmI2bzZkNDdWbUtjSDRsSmlIbVJlNEdiTXloSTF4K2ZuZlJY?=
 =?utf-8?B?STJXYjh3dGdQYi9BVHZlUmlINldudkJReENrazQwaU00YkFXU1RJekQxRjZn?=
 =?utf-8?B?SVlMN1M0N0diejN5MUd0eWhmV1d1ZzVpdFdIRWYwdFNyZWdWbSsxOUZ3T1U2?=
 =?utf-8?B?cnBma0k3cFlwUkFwZmxHYWo0MHRzOThsWXNjSmI3Q0gxVVZ0blhkYWpmZGU2?=
 =?utf-8?B?Uk8zcEh2QnRIaUpldXlqSHoyVWp5MkhQd2NMRWQzd2k1M1V0dGNxaG05WlNs?=
 =?utf-8?B?cTVJb0xqYVV4UXluS3RpV2x1MzdIbkM4Qk1QRlFGRjZaeHc0SXFJck5KRjla?=
 =?utf-8?B?WG1UQlUwbXlNbGJWS0xlWjk0T3VOSmRnYmhZMTdhVUNZNWFoVkE1dUdnVktJ?=
 =?utf-8?B?UTA2YldYbEpkMlRyVDVGbUVFVzFsOVkwTnRBbWJ4c0RiVlhSekY1WmhKOS9y?=
 =?utf-8?B?S0hnU2JhcE5pZk1yZUZrSGJNREltOWp2Rlk2WFhiQ1NYQlFYTVJVT1o4UTUz?=
 =?utf-8?B?ZElJMWg5bWk4R21EZXRPTFJZdE1TUUZmYjBwcU5ycmUzdkhtVmFvSUo4KzFv?=
 =?utf-8?B?WGJ3M3dYdHFLSG0vMjRXem9vT2xWMDRLOE1lTXJpdTNmZ0pBZVVNRU5QWWkx?=
 =?utf-8?B?OVlUTjhXc3ZrZlRhRWN4OFlGZGhVQ25LSHFhd0ZWZkY0Z2hpSHJTdlZNaEF2?=
 =?utf-8?B?KzR4WS9iWjFDVnMyWWE4MWordlh2WC9PYk55MTh0YVkraithd1k1NndzbEZR?=
 =?utf-8?B?dlFRU0ZRT1VGazFSSDJUMGlRbGZEbWplWUFYMlJuVjh3WXc2YjdCb2JyUEsw?=
 =?utf-8?B?akFtTVpnMWVtVUFRWW1pWHJOYnN0NE4yQ3piT0pKZnIrQ25zeG80aUg3YzlJ?=
 =?utf-8?B?SWtMdER5bnNoOHpYa2xWamtkNjdlaXdwM3h1bEoxeHdGRVBjMklZazhxTVE0?=
 =?utf-8?B?UnJmRE9veDFWYnVQaVhkV09rcTdOTkp2MGhhajhheUh0QWtUZVhQVXZ3TUVv?=
 =?utf-8?B?dkpXWTBza3dpaThsejRha0UvcmlVVGdUN1R5Rnc0OXhYK0NNc29WdndsVjI5?=
 =?utf-8?B?bXlnS2hoRTM0NkdRUnlZa2lSSmYrMHFVYmZ3OW9wci9LTm53WG1hOEhFYXdY?=
 =?utf-8?B?OUxqZkJHZUlkMnhVYmNtWlFSZkpYQ2ppWEtiZ29mQnZ5a2lCR0RhQ1EraHFv?=
 =?utf-8?B?WHJSNGZUQ1ZmNEpZK1ZWajhrZmRid2pDVHdjQ0ZVb0kyb0E4dDhORERVb1Y2?=
 =?utf-8?B?aDNxb2wvR3hGbHF2TGJ3ZHBDdVBpMUNOMmwyS2x1aWdNbk12ajJ1WVVwYy96?=
 =?utf-8?B?K1NTcW8yMGQvMHBxcmNQTnNRT2Z4SUlOK3ZhM3ZVQXNFRnJZNGNNOWxscWtS?=
 =?utf-8?B?ZkppTnpzWGU2bi9IVkNQRlFMNUNOaWhsZGdMQzFaREZIN0ZMeHIzS2tLY3Z3?=
 =?utf-8?B?QStBTFNXUndaV0Z6MTRpKzNlTHhIT0EvTmN3SjM4SWVuNldoRW15aTFMbFRG?=
 =?utf-8?B?VlJudWNsd1ZNa0dpUmpCMU4rbDkzc3plM0ZmcDNxaWNtQS9GcU5xVEZVdEN1?=
 =?utf-8?B?cGtjM0ZQZkJDWlNPSWY2R1VRZGdYYUh5UGliNStKTCtKRTl6YlF3MmZFZU9q?=
 =?utf-8?B?eVBEbVV2ZXZqRW4yMWVORU9hQVNXcHF2ZkxEU0hSOXJrY1Z0Z29Tb05DYWlS?=
 =?utf-8?B?UUdrVGlLVnByMVRSSVA0aFBRdUZoS3Qzc2dBR2JpQTUwdDd5cEhZcC9zZ2JK?=
 =?utf-8?B?WnRqVXBneVhUTG44MTNwZC9RcWUwN0xPNTZzSzBQNnNlbXpIdzN5UDJiZjZL?=
 =?utf-8?B?MDR5N0dCUlJRbmRncHRQVm1TQ0NXZ0YyaTNtSUFER3JvdnFaZ0ZiRjdhWWFr?=
 =?utf-8?B?TDNOdDhWa0lRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmNTREFvQWtHOFZ5WXNZWTlBMlB4UmJIR2dScEdHRk4yUVZ0cjdGMkFPVk5a?=
 =?utf-8?B?SExqbkZ0M1ZBdjhJQ01ZdHRReVVKb0tUY0pNeFVUTlIxdDNNdWRFR1Jxc2xx?=
 =?utf-8?B?aEFmNnpkYVJLR2dHUTZLSG51WVpTWG5oRzdqZ2JLeGxRU2IvcDRuOUJxdVZ4?=
 =?utf-8?B?dmMwTzc0V1E5NFVwY2twUEg1Q1QxTXRwdGNXdkNlQmhsSWVTUFBacDVieG9v?=
 =?utf-8?B?MUovL1YwbEtFNGhPeEV4dG5tS1c1UC9sbDd4YjU3UUVHbGYwYWxXN3NZYmpP?=
 =?utf-8?B?bmp2a1NvVjE4cHFOQzk4WVdpc3U2dWFUaDc1Z1pBTlRicWYxelhIVUh0c2ty?=
 =?utf-8?B?bXBPeFdCNENqaHU1Q0RseWNoV3Qva1lhNjBQdEtOY25lamZrQytYSVRvMFFx?=
 =?utf-8?B?YnZWaEg5U2JpQ1FUNUh2TGpFeDRnczlveWN5NU5NR0pPSGxLSm5BYnpjUzB5?=
 =?utf-8?B?bmJEeG1GaVg1cFU4SVdjeitvYXJVUFloZUZJREJ4emZxaDRER0duUzhCMFVF?=
 =?utf-8?B?aWpEZ3Z3M2VtNGxVcHVHcFdjSFVvY0lRSmlOd1Rkc3hkekc1MEEzVUd1anJI?=
 =?utf-8?B?ZmpqV1Y2amUrc1FBRlVWRmJxcmhoQlcxZ2NQSCtjYTIrNDlkTHpWRENCVWdS?=
 =?utf-8?B?L0ltZ1c2N056NmFEV2RoTzRja1cyQnRoMkIwRkhMc0g4R3FDMGU1UjJNWTJT?=
 =?utf-8?B?dTNHeEpoOGF3RE5pRHgrNE83dmdzUlpHMlNPV2o1TkhhTW1tQUNoL25IcGhV?=
 =?utf-8?B?bUpFV0JUdFRIaDdsa2pWOHdRWmZPRHUxQ2xDZ3hNaWRCWmdjdVA0SjQzWldR?=
 =?utf-8?B?dkdnMlFxb1gvaWRVcDM3VG96YUVCanc0Y2ZZZUFnRjhWc3ZPeUFLTnpuLzdh?=
 =?utf-8?B?VkcrSFRzbkdPUFpJL3Z3bzFoaUFFQnpuam5QODk3eXlnRHRyQjJPcjdlbm1h?=
 =?utf-8?B?UWFJRXRyWnA5RUhRazZJWS9Mb3lPN21JRk1pWm1zRmNmbDRGK052T1ppaTI3?=
 =?utf-8?B?VElRQzdpYnVMMkxFQlZaVmMxdmVXREt5YzhKNkVyczRSTDFhdE1nZGV2U0RB?=
 =?utf-8?B?Z290d1JjVGh3dllWYzlYQzRYMmlROEIzV2EvT2l0VGl3SXBaaTg0QnNvdVVm?=
 =?utf-8?B?QndzSERYWFovcTE2WXRtMmY3MGswRm1oSlpqVzBMMW16OWd6NHErUWJqN1VU?=
 =?utf-8?B?am92NDNRem1QSlFza2E4UGY0aCtVclM1dUYzQ0x1a3NKaHdveHNpZHR3RG1Z?=
 =?utf-8?B?MVFqUURRK2VBeTFQYVNvdjEvK0FSclcrK3o3RDdDYVBvdC9IYlRIcjVFcnl6?=
 =?utf-8?B?c0ZmLys1Q0JDVzJ3MkM3SU1oY3VvaTdjRmVsZzRrWmdIOGdQS0ljUTFONE1Q?=
 =?utf-8?B?ekVmbXJ2TExMSzJ6K1lNaFFKNERCRzM0UExIbUxISWNpMU4zcG90Q1lMdnZk?=
 =?utf-8?B?aVQrbk1aYzE1V2FlQkFYMkZQbmtRRTdveWY1aGdWNlg0Nkx0RnBkbEk1U05I?=
 =?utf-8?B?b2RJTzkzMDNzS25VbHZkMlkyWXNpRUVDMFF0VHg3cHc1VWJ2L05zSUlRam12?=
 =?utf-8?B?SGNVYTVaSlRLZldlV3VjVnYrNERBNVFOZ2V1c3NjY3RIajh3WGFKT2FKN0NK?=
 =?utf-8?B?SDZjdGNBUTBrODRHVTJFT2krK2Q2Kys5NEsxcU5jK3hsQit3emp0Wk9OWnhU?=
 =?utf-8?B?UzdwOHlSUTJMRDdKb3ZzSmJQbGREd1lybUpmQjhEMUh5MkRKckdsVTlQck81?=
 =?utf-8?B?UDVVWWhTaVZ6QnFhbUpaRTcyN3pkNGpXWWIxemVqRFZWQlI0Y25wMVJxRWlP?=
 =?utf-8?B?NVVSTVNuUGJ3L2dGYWN1TjZwTkVyN3ZPWHUyd0hnN01TSnZqVU5OZE92SWlj?=
 =?utf-8?B?Z3JQWGdqZi8rZURvb1BMQmhQRXFwOUpqcmFrVWllaStHMytZVEZqMDNZYVNN?=
 =?utf-8?B?YVdpTjRnNzNubGtNVjkybGNHSnpIalE2RHArSlQyT3ZaOG9LelBZUGNqTjVo?=
 =?utf-8?B?YnYyaW9rS0hYcmdFeWJLVnRPRXFYTS9WSzdseHFYazZyOHU0aWRjblZjWm9E?=
 =?utf-8?B?WTBXS043TGJnQmxRWlRQbGVwSlprMXNzZXhJTFFEazdxc1ZoRSthOGtlOEM3?=
 =?utf-8?B?eXNJK2tBWlFTdFZHRmsrRElZcDlWRUU2ODZQemdHTU5VcXFsT3lLd2NCYlJ5?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BB6EE39A51F9640B85DBED65A555BBE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04045c70-4497-4967-f209-08dde0052d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 16:18:19.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLaIAy4lpTEEioc+LjMi3xYMqTkSy5pauPIZE6LO6ahWuOJ/TGbe01jUf7LO0+LO46gcGKIDr+52H2op8nweBkI8WTFVvlFPnXDZISpao5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6910
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA4LTIwIGF0IDE4OjAxICswMjAwLCBLZXZpbiBCcm9kc2t5IHdyb3RlOgo+
IEFwb2xvZ2llcywgVGh1bmRlcmJpcmQgaGVscGZ1bGx5IGRlY2lkZWQgdG8gd3JhcCBhcm91bmQg
dGhhdCB0YWJsZS4uLgo+IEhlcmUncyB0aGUgdW5tYW5nbGVkIHRhYmxlOgo+IAo+ICstLS0tLS0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSsKPiA+IEJlbmNobWFya8KgIMKgIMKgIMKgIMKgfCBS
ZXN1bHQgQ2xhc3PCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgV2l0aG91dCBiYXRj
aGluZyB8IFdpdGggYmF0Y2hpbmcgfAo+ICs9PT09PT09PT09PT09PT09PT09Kz09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0rPT09PT09PT09PT09PT09PT09Kz09PT09PT09PT09PT09
PSsKPiA+IG1tdGVzdHMva2VybmJlbmNoIHwgcmVhbCB0aW1lwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIMKgIMKgIMKgIMKgIMKgIDAuMzIlIHzCoCDCoCDCoCDCoCDCoDAu
MzUlIHwKPiA+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCBzeXN0ZW0gdGltZcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoCDCoCDCoCAoUikgNC4xOCUgfMKgIMKg
IMKgKFIpIDMuMTglIHwKPiA+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCB1c2VyIHRp
bWXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAgwqAgwqAgwqAgwqAg
MC4wOCUgfMKgIMKgIMKgIMKgIMKgMC4yMCUgfAo+ICstLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tLSsKPiA+IG1pY3JvbW0vZm9ya8KgIMKgIMKgIHwgZm9yazogaDowwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgIMKgIChSKSAyMjEuMzklIHzCoCDCoCDCoChS
KSAzLjM1JSB8Cj4gPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgZm9yazogaDoxwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgIMKgIChSKSAyODIuODklIHzC
oCDCoCDCoChSKSA2Ljk5JSB8Cj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKwo+
ID4gbWljcm9tbS9tdW5tYXDCoCDCoCB8IG11bm1hcDogaDowwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfMKgIMKgIMKgIMKgKFIpIDE3LjM3JSB8wqAgwqAgwqAgwqAgLTAuMjglIHwK
PiA+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCBtdW5tYXA6IGg6McKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoCDCoCAoUikgMTcyLjYxJSB8wqAgwqAgwqAoUikg
OC4wOCUgfAo+ICstLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSsKPiA+IG1pY3JvbW0v
dm1hbGxvY8KgIMKgfCBmaXhfc2l6ZV9hbGxvY190ZXN0OiBwOjEsIGg6MMKgIMKgIHzCoCDCoCDC
oCDCoChSKSAxNS41NCUgfMKgIMKgIChSKSAxMi41NyUgfAoKQm90aCB0aGlzIGFuZCB0aGUgcHJl
dmlvdXMgb25lIGhhdmUgdGhlIDk1JSBjb25maWRlbmNlIGludGVydmFsLiBTbyBpdCBzYXcgYSAx
NiUKc3BlZWQgdXAgd2l0aCBkaXJlY3QgbWFwIG1vZGlmaWNhdGlvbi4gUG9zc2libGU/Cgo+ID4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGZpeF9zaXplX2FsbG9jX3Rlc3Q6IHA6NCwg
aDowwqAgwqAgfMKgIMKgIMKgIMKgKFIpIDM5LjE4JSB8wqAgwqAgwqAoUikgOS4xMyUgfAo+ID4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGZpeF9zaXplX2FsbG9jX3Rlc3Q6IHA6MTYs
IGg6MMKgIMKgfMKgIMKgIMKgIMKgKFIpIDY1LjgxJSB8wqAgwqAgwqAgwqAgwqAyLjk3JSB8Cj4g
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgZml4X3NpemVfYWxsb2NfdGVzdDogcDo2
NCwgaDowwqAgwqB8wqAgwqAgwqAgwqAoUikgODMuMzklIHzCoCDCoCDCoCDCoCAtMC40OSUgfAo+
ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGZpeF9zaXplX2FsbG9jX3Rlc3Q6IHA6
MjU2LCBoOjDCoCB8wqAgwqAgwqAgwqAoUikgODcuODUlIHzCoCDCoCAoSSkgLTIuMDQlIHwKPiA+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCBmaXhfc2l6ZV9hbGxvY190ZXN0OiBwOjE2
LCBoOjHCoCDCoHzCoCDCoCDCoCDCoChSKSA1MS4yMSUgfMKgIMKgIMKgIMKgIMKgMy43NyUgfAo+
ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGZpeF9zaXplX2FsbG9jX3Rlc3Q6IHA6
NjQsIGg6McKgIMKgfMKgIMKgIMKgIMKgKFIpIDYwLjAyJSB8wqAgwqAgwqAgwqAgwqAwLjk5JSB8
Cj4gPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgZml4X3NpemVfYWxsb2NfdGVzdDog
cDoyNTYsIGg6McKgIHzCoCDCoCDCoCDCoChSKSA2My44MiUgfMKgIMKgIMKgIMKgIMKgMS4xNiUg
fAo+ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IHJhbmRvbV9zaXplX2FsbG9jX3Rl
c3Q6IHA6MSwgaDowIHzCoCDCoCDCoCDCoChSKSA3Ny43OSUgfMKgIMKgIMKgIMKgIC0wLjUxJSB8
Cj4gPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgdm1fbWFwX3JhbV90ZXN0OiBwOjEs
IGg6MMKgIMKgIMKgIMKgIHzCoCDCoCDCoCDCoChSKSAzMC42NyUgfMKgIMKgIChSKSAyNy4wOSUg
fAo+ICstLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSsKCkhtbSwgc3RpbGwgc3VycHJp
c2luZ2x5IGxvdyB0byBtZSwgYnV0IG9rLiBJdCB3b3VsZCBiZSBnb29kIGhhdmUgeDg2IGFuZCBh
cm0Kd29yayB0aGUgc2FtZSwgYnV0IEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSBsaW5lIG9mIHNpZ2h0
IHRvIHg4NiBjdXJyZW50bHkuIEFuZCBJCmFjdHVhbGx5IG5ldmVyIGRpZCByZWFsIGJlbmNobWFy
a3MuCg==

