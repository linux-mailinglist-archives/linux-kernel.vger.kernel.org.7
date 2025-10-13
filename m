Return-Path: <linux-kernel+bounces-851168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBABD5AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EA254F4E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5C2D3EC0;
	Mon, 13 Oct 2025 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNf4UBU5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78A2D3738
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379417; cv=fail; b=IkTorWKNtKCDdlOk8pFexZa4KPJ0UH1Jsi+QCTUrdLqZDLYXIrByCQ2sKycZy42wiz7Q8YdHxjHbuEzhcrCWJpGvFFnTr3eb7ybMn46yUq8nl3gzxiihtExdCoQ29JskL0pM+hL3ImE7lmFXA6QCTvZferMazpHa4V8PY/vzPoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379417; c=relaxed/simple;
	bh=v5WSEXzrDIovywoOrPHmKlyjqk9az9v0cmKJSdXuzdk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDMexfiihB0oyKhSC23AsKuSD87DZU3j6/q5YMC7mIgC+efIiNzV2M1FS93QpIa8UbHjw+CcJqnvn14/MvoaarEffEgXKv64o213Vrsl8ub4HT42FULfoG5FSUfgmF+zlHIEp+/k5e/lS4WvKkDbtBywbrKQsJNCcMDwZ4rtYDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNf4UBU5; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760379415; x=1791915415;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v5WSEXzrDIovywoOrPHmKlyjqk9az9v0cmKJSdXuzdk=;
  b=NNf4UBU5IVyhHCmD9gzIQwBO4NIxV8Ob1Q76PJciT3YcgP+JBry9SgQm
   jTPDUCQnsPLxqAZM67sOrd0IaPyWZ7CEw4rky7b9X6Y3KjDCoRmzylhCt
   P2TFCn31q3EIfpX6aL4rUyBrFjqS5QcVfEr2bWHr/6/7oSxEzEXvt3eyM
   yOw3H3Cz0zw3SJeHljyNEf8HFMLsHUeHqZoFCEH0gfpUjHatI9oEqbJtm
   uFarhaPvLU6y48n+2x84Yrww5YFEbqSL5jurTX5GpZAGtHrgM9K5//75A
   kOojDgjt3FQgdklmE9HDUgPzaJCpWE4EnVDcHrN3sFzgJPUsDnCRIutOm
   w==;
X-CSE-ConnectionGUID: 1sfmTW2uT1K1UglZkHN+MA==
X-CSE-MsgGUID: Y2qqQM6xQ/SAjzGxjNi+PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73131209"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="73131209"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 11:16:54 -0700
X-CSE-ConnectionGUID: 2+sqKwTeRw2Oe/RC8T5ViA==
X-CSE-MsgGUID: v3dHHqcpSDyA2nuRDygTDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="212288708"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 11:16:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 11:16:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 11:16:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 11:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvJZm/XkuegLYLqL3jLtjgbl2PRh/Iz/LtFffxcx06AzjE/ZaanS1ilqtJFigiSnOk79/lx3yb6aC4/3zgy8Y4+keNbhax01cq02ZcJr+90+WrKPLia3FcsEMp4u3HPHC1tbU+A80uu4qM3MU6/a4Wsrz4v30W/ebOwUk4hSi65mU8nn5uWDU4gXqzIPuwmVh8tP1h26rm4GZ4KPQwgjbX2kpMTpp5TE2wp6KKCOv8KkpfwXmoJ/jjy4XfTcs2TyysslFqhbFJy7/l6UGNv0/s7WJ6N2HptYa6MAV/OwJJbDRi55qe2ljPy0idqEh/5TL7jYLwyztbpDltFWoC8g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knDaa5uDJrs+AYQz4LhM6DiYxTADbBe7e1kCqF5MbYU=;
 b=JAS4/OhzZbuLb0L23+xK8gdYZW6gb5P13N5YW60uroGQWW3f3vHRrqbVmtVNz/1XshCXr97ITPkVWIVX5EKe8jjkiHFFZespXXQkmFPmudp8W7j1Rrur7ip82midXgErm6yf2cKmv8oEFs0RwyngHPOG3wmrYG0EjAFeLeudm2oBJWfpu7VWD1ijEF4rEBXbJgCU/7cpJ7D/T+tWm4RQKlNJHl8aB6/Vmi4sj4OG0jPTqaG0poUtTpSRhxBIBImDb7tgVSZ2aj6rxTmAGLxJdF65mUmQOs/QoLa74c+4ynaRQp9AZ9Ik+JZvHiy5ANCOdTZGflB7DxpR6judnDehGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 18:16:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 18:16:44 +0000
Message-ID: <2056950f-02a8-41cc-9dd0-c16b81afd8e3@intel.com>
Date: Mon, 13 Oct 2025 11:16:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
To: "Luck, Tony" <tony.luck@intel.com>, "Moger, Babu" <bmoger@amd.com>, "Babu
 Moger" <babu.moger@amd.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peternewman@google.com" <peternewman@google.com>, "Eranian, Stephane"
	<eranian@google.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
References: <0475e18db309c3c912514a6c4e7f7626297faa2b.1760116015.git.babu.moger@amd.com>
 <9771a165-e7dc-4e34-960c-37b17bd996b6@intel.com>
 <3ad9c3ff-12be-47b8-8bcc-fdf4f1e8fbb7@amd.com>
 <SJ1PR11MB608387EF18E2BEAE9F719899FCEAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB608387EF18E2BEAE9F719899FCEAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0337.namprd04.prod.outlook.com
 (2603:10b6:303:8a::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 5719aa12-dd87-4c1a-5509-08de0a84aa22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEZEL2lCN1pFMGRNMFpXcEppWVFUaG9XVlhNWkhrcThvWkp6dXh5ekNGOUhl?=
 =?utf-8?B?NDVtek05RnEvc293aDBMQ295TFBYckUrOUJ3VVlVYitweGpaOSsyVnNjenYz?=
 =?utf-8?B?ZUp3b2Z2UDZscFNzZENPditQeUE3aXcrV2tvSEltQTJMNm1NTk1GK292RDdn?=
 =?utf-8?B?b00zem9VTWJaOFZVOTJxb0tMU29TMW5kZWVTTlJua3RMcFFyTFY1R0xHTjlN?=
 =?utf-8?B?SXFPRFlSZlptd1pYT1hVOXNnbHRpbi9HRDhTMnpjaU9IMmh2cUhNZjlpN3V5?=
 =?utf-8?B?bXFERjhFeVFJZUJHcUNxbFI1M2xiWWlSMDFRRkwyYmZ6aDZmSFJxeU40U29P?=
 =?utf-8?B?SUZIUDdoS2g5KzN2cFhjWkZUVXprNXM5bkdhVThaMm1CdXpsS0NudFpBV1JW?=
 =?utf-8?B?Sktpejg5cU1NUnJCUW5wdi9CNkh6eW5BbXhVcjFaN1RPSStyMVFkRC9IMUFB?=
 =?utf-8?B?a2U2K0YxNURGMmlpQW1QUVN6VjdtaEk3OUl6QURFUTd6T0c0UnZmQzVKRXJm?=
 =?utf-8?B?TDlGKzM5enZSeGk5ZDJRSE55U1NxL0NEb3h5cjRER2pVY1dpWHFXZWpvZEpk?=
 =?utf-8?B?VDlZY2lGWnVpanNITytYVWEwL2RRZVl5UkxMMXNqbUE5OFUyaUlRRSs5d2pG?=
 =?utf-8?B?eU5SdkxPZjJmZWsrcUtGcitiaWZpS0tjK2JlRmxBQjhxOXo4aGxTVlRXa1VU?=
 =?utf-8?B?Y2RaZHcrMU1YSmp5VXQxajhWSkVkYXIxZGdNRnBXMm0rOU9VOUZkVVVzcHJX?=
 =?utf-8?B?blVubm5XNnUvblhveEsxd2Mvc1hsVFFoNVlEaEJZaHIxWXdJMHZwL0tjVHVB?=
 =?utf-8?B?TmFVbG1MeW1BcndDaGpudGlUOXBhMUFyRVhhVWlkc1N3RTdIVFBtbTVJdmVF?=
 =?utf-8?B?dFZualAzR2lxK1dDNUtRdk92cUhhT1o5OEtianJqYWJUaTBmYUFxM1dKbklO?=
 =?utf-8?B?bkxGS3ppOGErbjdxSlBIV2M4WW1KZHcrb25mQ2Eyb3pzTkNPQjJHOEVEWjNy?=
 =?utf-8?B?RnpCZWlXbHRBdTlZTVVMbXNpOHBGR1AyVmhscDcyQ0haVUVrRGtjY3VsaHF0?=
 =?utf-8?B?bFA5Y3V0L0JwNHRoRUtvbGpwOCtoMUkwbVNIOG5sK1cwQmhiOVBXc3RaWkZu?=
 =?utf-8?B?YUNidU5hNjlFSzh6d2lFeHFQWGx6bkdNZU1HUHpmRDBicHY2TjZ6alJmWTJO?=
 =?utf-8?B?YWUzcjYwdnQ0NmVGVjJVWU83ZXdOMWlyUGpQMHhmMy9zOXJ3MWN3L09SU3pZ?=
 =?utf-8?B?UGVMcTZCQ0Y2MXo1eThaS0xvM0JYZnhQN2hDS3dibURFVnRadDFCMy9KdTJT?=
 =?utf-8?B?UUVwZWpXVUFVaWt4ZkNMU0ViMGRaaHhhZ09FV3lKMzdDendWT2ZKR3F5c0t0?=
 =?utf-8?B?U3pIbkhUTnpVcXhHQnJ3R3Eyd2RaeHhmdTRJeXpzcyt6SU5sSW42Vk1JVlZm?=
 =?utf-8?B?RkNpM2I0UXFaNXp5d0pMNWlHcTNIQUY3S3pyc1pob1J2VDVKOVZCRVo4ZmFp?=
 =?utf-8?B?czJSM1MxNmhyM3oyYUZsZkU5T3dOQWFOazNQSVJxZWV6dFFKV0Jna0lSdUNj?=
 =?utf-8?B?d0FGSm44Mk0zZXpibVp1M1hlMVdCN21zeU1SYlROYU9PaHV1STBOaytkMXdV?=
 =?utf-8?B?c0dmZys5YkFSNFVOR3lpR1VGTDZaTG43UmpGSEg1UEVoSFllcjJWMDB1anpj?=
 =?utf-8?B?NCttTFVUN0RRTnhqNVB4VzkxUlFxRFJ6OGdkMzFURkxiT1NGZVorS0YraFBN?=
 =?utf-8?B?cVI4dGVOWThjZThpQUVaV2NLT1pRajBSMzR2a1c3MXJoRzJCaDM1b0xsa1Fy?=
 =?utf-8?B?TzN3Sk1ieXV1Qmk1Q3NpSTB2cGNoSVhJMDlLekYvMnh6Q2FaOHRibkVZamZT?=
 =?utf-8?B?aGpoQks1OUE1N3VzL3dxSEl1eGFlUVZEWDZBQzVGb0VESEY5eVUveUVJYlZk?=
 =?utf-8?B?dC8rSHFtQ2ZmNFVkcmdCLzdjRjRDTlFoSUFCVFVSRHR5Zi9UWXBsYVN4VG1I?=
 =?utf-8?Q?Fuwib9ffzRki93fx40BcAMvCLMFn9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wi9QSXVGenJJUVk1RWhuS1FnQ0Q2RThJOCtYUnczVG1EY2lLNEVVQXlOL2Y1?=
 =?utf-8?B?RVVSL0ExVjJpK3VjU084RUxpSGF2SUJ2VjJscDRyNjBoUnVjOHBZQVlTb01n?=
 =?utf-8?B?NnAxbjlvalpZaWpVeHJSNEFMVTBOTFBDY0dsZFE0Z0pOOUh2L3dndURXNGpS?=
 =?utf-8?B?OXFLdVRGQzJPZTgra1VIRngwTnFHMlh4aEtBN0Q1VEtRUjdRV0xCSHFVeWZC?=
 =?utf-8?B?dm10eW9TNzVrSXo2bjhtc2RGcWs2RFExeCtHVGZPWHRpZ1hvaVlCdEhnOU1I?=
 =?utf-8?B?UDJ3WXF5ZFRUenpJSWJOeW5hWEcrcit4RklBNUpBb2t5c01XZFRKZFBWMW5x?=
 =?utf-8?B?MU1TSU5FTGF2dWJVRjVRMjI0UEZCOWR2OEU1N2N2SjlLR21zRU1XdVZYRXdt?=
 =?utf-8?B?KzRzTEJTWlJUbUM4MUhtd1lqZW83Z25zNHpzVWRyMXdDY05GNU1JYjYvbjJP?=
 =?utf-8?B?dE5xaHltajBzeDhrQ1Mrb0VaQkR1SU1vK3QveHRBdXhLV3hUcnlxWCtaWHFW?=
 =?utf-8?B?bUpXUGl0VlJDK1ZEL2tRc1puYmVUdlVGaGd4R05haUo1Y050ZWNha1lUTmR3?=
 =?utf-8?B?NnRhTVA1OFNPVElvM1Jhb1pkL2JYU2lkS0xWbnBTdVVQWGV2M1V3ZlRkbDE3?=
 =?utf-8?B?WjcvRGltRzRDS2NsYXd3NXpnanFiVGxvSEdYaFZnTTVJUEtvdUxiYkQxdG52?=
 =?utf-8?B?RWpwQ29sUytubnNXVjRxQWNxdlZLQ2E1TDNwTHpnVXpqNElVMFlCd3NCd1Na?=
 =?utf-8?B?SnJDUGxlWGpYb1p6Nkd0YTRDeDN1WDRyeWdid0JKUEJCY2xPUmRVWnFKaEJ5?=
 =?utf-8?B?emtHUTVjWXBueW5sNEc3QVcrRDhOU2poOWIvTk5TeVRLeVg1aFc1SU1ET05h?=
 =?utf-8?B?QmhrTno1WWFkRERwQklVT0x2UlpzRG8ybkhwZk1XN0pBWU9ta0ROYTA0WVBk?=
 =?utf-8?B?d3hpNkNBdXNHZ3oyQTJiazJwQVp6bjEzdytjRS9oTHJyaStEb1lBTWhUK0pO?=
 =?utf-8?B?WVNFRjVGMk5Uckd4VFhXNmpmRkJxK2gxS0QyUm1IZVZsTWZwZVhiMGVDZG5a?=
 =?utf-8?B?ZjcyR3lUM0pINm9ud3lmWTZ5SG4vQkkvaytLaHJCc0VFbEYwYjJSQWQzdTVJ?=
 =?utf-8?B?ZVNNRzJleUl4TTc4NUdvaGd2b0RxTFZsdFNHUysrTDRORUdhelpzbW1vc2dB?=
 =?utf-8?B?WUx4UnFuUFBhMUlmOU56WEJrZ3RqV2ZWWXJnejViUEp0aTFYeDRtMFB2Lytp?=
 =?utf-8?B?MkUwdmp2dWwvZFk3cGwrWXBrV2RON1dneWVhSnUzT1Y4SG1zWWF3YTBIMWRW?=
 =?utf-8?B?ZWRNNnU0cHAzY3Z6SmZBSjhyWktDbmo2dGk5RDNXQ2VLWFk5bWNneGNONlFM?=
 =?utf-8?B?UnhQQmUrT2xBSnFXcy9oRGgzeldnQUxoSzVpenNObXA0U0dSUEhUR1ZHaE9R?=
 =?utf-8?B?aG5MaEZOeGJ6cVIzZkhsNXRqT05kUG9Db0lTMi8wQmlTOEFPM004TXhYa1BP?=
 =?utf-8?B?anpvUElFWkNoaDhRd0pYclF1bTg3dWt4cXF4VzZ3bFBQbkttUUdCUEsrZExI?=
 =?utf-8?B?OU1nbmFpTnNabUx3OXNnVzAxRE1Cd3lHMDVhK1lmZ0ZLdUhKK01jbUNIejlo?=
 =?utf-8?B?VitpSERSaTlUcUJYUmVJKytKd1ZLYkxRRFg3aGVnTEFPRGRhV3FVUTJabm41?=
 =?utf-8?B?UWRZT3ZqZzFiZzloZVoydDNLN3I0a2ROcXNDak5XamVHVzlnTmRYQ3lOb1pW?=
 =?utf-8?B?ZnhjTHRhOHBaVldHeHVhR2tvY0czTFI5MGNpb1RCaE0wWHYyN3BiL2FtTDJs?=
 =?utf-8?B?cE9WMW8vRU1CdktnVUp4bWdDZ1JocVJ5TDZVUE1uSW9KNFUyU2NJemg3UXlp?=
 =?utf-8?B?Qzl6Z0o3c3NwL29rWGQweHdnSnN0UnVaZ0YvanpxenQvbXZQUVFOTUFxODZq?=
 =?utf-8?B?ZlZINHp5a2UzcTdjc2E0S2FRNitHa2NraTQwNnFlNXZUVTJxSEwxZ1luTWQx?=
 =?utf-8?B?WUpyQ3lDNWVGSm5wSzN2MzlSeFZPZ2F1NDV0b3lrbGZraGk0VEhxM1dxMGUw?=
 =?utf-8?B?SFFTTUJEREZ4QjdGbHBPck52VitCWUVwL1ZFQzBpYzhUVW14eElEL3lqRTRO?=
 =?utf-8?B?dWYxZXVvdnNXRC91RE1Vd3E2clNnc0xDejVvY3BQRG9BN3o5MGNKa3NUMTls?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5719aa12-dd87-4c1a-5509-08de0a84aa22
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 18:16:44.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+uTDFtoKkLQrBn1fsokHTnk370PaKHrYICwwaTf8SUqCoYlFkdRMDGEpMpxwO7OMDnw5o4J6wBgXWGf+rS/tTnzJbp/HeIZJQ5YY+mv4e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com

Hi Tony,

On 10/13/25 8:35 AM, Luck, Tony wrote:
>>> The behavior of the counter is different on Intel where there are enough
>>> counters backing the RMID and the "Unavailable" bit is not set when counter
>>> starts counting but instead the counter returns "0". For example, when
> 
> Note that the h/w counter doesn't really return "0" (except for the first time
> after CPU reset).

Correct. 
In this example both the hardware counter and the event returned zero. The
main point was that it does not return "Unavailable".

The goal with the example related to this issue was to demonstrate no impact on Intel
when resetting arch_mbm_state::prev_msr on receipt of "Unavailable". Do you see things
differently?

> 
>>> running equivalent of "step 1" on an Intel system it looks like:
>>>
>>>     # cd /sys/fs/resctrl
>>>     # mkdir mon_groups/test1
> 
> While making the directory mon_add_all_files() does this:
> 
>                 if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
>                         mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
> 
> Which in __mon_event_count() does:
> 
>         if (rr->first) {
>                 if (rr->is_mbm_cntr)
>                         resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
>                 else
>                         resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>                 m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
>                 if (m)
>                         memset(m, 0, sizeof(struct mbm_state));
>                 return 0;
>         }
> 
> If you dig into resctrl_arch_reset_rmid() you will see that it reads the h/w counter and
> then that becomes the start point for subsequent values reported when a user reads
> from the resctrl event file.

I believe resctrl_arch_reset_rmid() already addresses the issue since resctrl_arch_reset_rmid()
always resets the architectural state before attempting to read the RMID. If __rmid_read_phys()
encounters "Unavailable"/-EINVAL then it is fine since arch_mbm_state::prev_msr will already be
zero and thus ready for a subsequent resctrl_arch_rmid_read(), whether hardware counter is ready
or not.

Reinette


