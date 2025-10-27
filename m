Return-Path: <linux-kernel+bounces-872366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F03DFC1052D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0534FFA55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A9E202963;
	Mon, 27 Oct 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOkNAP41"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B42D6614
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591231; cv=fail; b=AMh0nXib5hf/pFRophfJIcE8zS25xMB20uFx0esMzaw7IjNxv1/tecDdHpI1SnR7ZWkdMjkfsm+BmGNdkCVsAoQCP6O4G2QQVwyBaC/qngfO1wM079B7xZ8jXGDnYwWGyTY2y7rzguRYT+KqJeua3Ea1WfFvPdrlSBO4dvHSZl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591231; c=relaxed/simple;
	bh=Xm/uUT6CyvR4EzB3GZj6Ph2UEgXu1PVtxSAV3m2ZbKg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=LJV9rllu9POnFmtrcDailtE56+Vou4rd7j6+13u/k4Al5xwp67WxqRBbwpHBf47WPRucE/aPqIcgagCX04Bi1AvTVgo9hv6ZlwKPTCRgmBJSQsyA4ctmLYDQNFZ+xYee7SqE5EEPYjku9QjnYN69xU5trY3po969pQP5h6/ABHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOkNAP41; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761591230; x=1793127230;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Xm/uUT6CyvR4EzB3GZj6Ph2UEgXu1PVtxSAV3m2ZbKg=;
  b=GOkNAP41JcWFJbBTp+FzOr5RBigNxU1UTIoyWbZIZTJfcOlYI+X7Iagl
   NT6CIMXAskgFGe5tLbRTyKS0iCh+vyOcql0PE/0N/T572kHMbdNpkIb+Q
   NbMy0RxwR05Zs7kfXxC733XIcGZOZxe1HixGSN2u/jw2AGxpjI2yT2tRA
   PgFWW7sqpnb4GSzw0R8pjWbxKZOY1P7GYE5XX9OhY0BZz3O7wR9ZHa9Wr
   Ia1ENgf5Mosd+HemCYG7z7UBZU8B8DXeT3UdAqDIxmX7FwGsK519OAXIs
   lOdYh8v4S0Go/5h80Ut+EoyErbalgPyA2Pm+ZDombX8O5tG8W8BuF/3gf
   g==;
X-CSE-ConnectionGUID: I5JzkCE5QIKfOjVL4UM60A==
X-CSE-MsgGUID: 2m86vGzESFWTmHd3ixrvbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63607720"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63607720"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 11:53:50 -0700
X-CSE-ConnectionGUID: mtOFPT7UT5qlVlwbi4n2KQ==
X-CSE-MsgGUID: WKGWhEtsTgigCVIqLYgO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="189159419"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 11:53:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 11:53:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 11:53:49 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 11:53:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUPPcdygInzWHeeLkmlTGOcKJKdyUFeiG3TLnwFvKbiYw2eii24tgs1gyxjD7miMtQV+AJycz0ND6Ju/bHyndtZYYGKnKCQpBcI0T3x09Fuo7REicz3lT/z8Ee87H7eRKHTAu8IYTnCp0XAF+itYinBG9EZjsQL1SCKQ2DvU9W3xHl+mMiykuKKSx507sk3ILK0hkbO9OD6g5DPd/dxt2+dbHVupIBi6oWnc5prbWSFMhWffwS8cWOP1YP6YxuTuyvN2BC38x/UMhLUj5A0Fdnhsrr5AGBlHJgsZ29OGeZbc/AqabAhIvVZx6qTG6Nl9QY21IduBsgcciRs7bKCrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5E/hOv88t5DfWDIM/awdOCbIqP/aWmT/V5+QGYFub4=;
 b=uzb9LF6pAsqXeRsXmNtfqIGvfdzK3dM+U6m6M536f4TKvx+T59bgRztszQRHALddvK7pN2Enj8DlrQcoJ3aQL8cUJ8cocHx6GoLK37+Ojs4jQmwIqWRHTtpP0SVS4z/pGZNnmzl8bKfxbiJkYSo8ErnEmE1mqakpS49IpOpRzXIgSGNbzt8uJRAV2qISbYPjmzPe3mnKHMVmN4Au3MM5PQ6vLv6C6E2oW5Q3/lpzOuK/600IUKbPBCj10Y4kT2Z3q306YPJd2B8EXoJ2wmahrSfubCCFIZPb8dbTRgnUEUAkF89ZPVbgmO4WDP/PlaG4O0x5Y0SLgjzUuUIIda/AeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 18:53:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:53:43 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 27 Oct 2025 11:53:41 -0700
To: Vishal Annapurve <vannapurve@google.com>, <dan.j.williams@intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, Chao Gao <chao.gao@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Message-ID: <68ffbfb53f8b5_10e210078@dwillia2-mobl4.notmuch>
In-Reply-To: <CAGtprH8g5212M26HPneyaHPq8VKS=x4TU4Q4vbDZqt_gYLO=TA@mail.gmail.com>
References: <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
 <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com>
 <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
 <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com>
 <aPsuD2fbYwCccgNi@intel.com>
 <ca688bca-df3f-4d82-97e7-20fc26f7d69e@intel.com>
 <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
 <2e49e80f-fab0-4248-8dae-76543e3c6ae3@intel.com>
 <68fbebc54e776_10e9100fd@dwillia2-mobl4.notmuch>
 <10786082-94e0-454e-a581-7778b3a22e26@intel.com>
 <CAGtprH8AbW4P2t-wHVcTdfLwf3SJK5mxP1CbsMHTgMYEpLiWjQ@mail.gmail.com>
 <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch>
 <CAGtprH8-UGFkh4NmuY1ETPYmg7Uk+bm24Er2PPxf8tUOSR_byQ@mail.gmail.com>
 <68fe92d8eef5f_10e210057@dwillia2-mobl4.notmuch>
 <CAGtprH8g5212M26HPneyaHPq8VKS=x4TU4Q4vbDZqt_gYLO=TA@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cad8b7-f02e-4986-2fd3-08de158a2678
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGNZTVRiMWJaU1JqTmJmWDhHajREd05oVUQyZnd0ZlRxZEVYb0VlWVVYMEpt?=
 =?utf-8?B?YWN1SGkzUElMcXQwMElRVEdNK01YeVc5MXJueGlFTnJuREJEVys5c21UUTRk?=
 =?utf-8?B?aWZGV0lNYkNUWnQ3bjBOQ0F5UDZNTTRaTW5XNkFjR2xrck04aG0zSVk3ZG8z?=
 =?utf-8?B?T01HMy9URitwMHRhRGNqOEFBWUVqejdacjFYaGlMcUlKRDNEQkM3V1V6dWVm?=
 =?utf-8?B?ejMwRlVIS0FKMXFMOHkzTDdpS25NUjJEQVNGSTJwaXpncHpVUk9FT2RaVHln?=
 =?utf-8?B?aHVxd1pTOFR3dEUxUWQ2Y3NEU28rMitmamdOWlc4Qllmaml5YTVUZWF4OTNT?=
 =?utf-8?B?QzBORjNtY2trYzlyc21FdUZ6SXRmOFpFUUNnbUNnR2ZmZFM5d0JFVjFMZnJE?=
 =?utf-8?B?a1RXclczVlZHcVg2Z0htVVVtMlBJbUVuSW9aMVB4MTlCSkJwQmtXcy9rdURJ?=
 =?utf-8?B?MFh3MnZKSlVSeWhYcmRtazVGSGdnOEdqU0JYSVVOWGZ1UU5lZ2JBQlJhckND?=
 =?utf-8?B?aTd3TVhld2RZcUR2bERSOXhPM2R5ajRiSWEzZE0vekZhNFJiUmQ5ZzE3NndY?=
 =?utf-8?B?SmsxOXZkdmt5MUN6YTJPN0JEVUl4ZUlEei9aV1NFY3JNVzV4dDY2czBlRmtD?=
 =?utf-8?B?VGxySW5udUhIOHJIMDlOS0tNSzBXaXRVS3J3eW5NSXJlTHBnVDFpYUNiM3hh?=
 =?utf-8?B?cEZnbXFwOXBCem4zc2svemVOSk1HM3ZJT3BDQ1FKeGVUU1NXR1NNdktwVk5o?=
 =?utf-8?B?ZS9uR0swb0d0azdwMmorTi9Jc3BCNTR5SjlRMVdwZ2w4TXBHS2hYYkV3NmJ6?=
 =?utf-8?B?WSsxQzFHRXJsYVVkamxCdG5KajZUaXdtZ2tiN0R2bU9WVURmbDZqYlM3RG9q?=
 =?utf-8?B?VEErMXNoZ1cyTHh6TVh1ZXdiOVpoMjNYM25JZzJkSzRzeFk4KzJMYTgxZ0tS?=
 =?utf-8?B?SU4rY0loTUU2M1BXanBHdTcyb0tsZ1psQnkvcHFveURzZ3pkVHBXS0dxRmJW?=
 =?utf-8?B?Mmd1emlDRVFMeFhSR2l5SVdvMDBSM3lSQXVCQ3FwdFJ2VmxlUVhxQ05jZEs3?=
 =?utf-8?B?TlROU0V6WlU0VThjc3RqMTNWb3BqZTlBNFdpTDdnY3VkdkV5VzVQakxLbmE3?=
 =?utf-8?B?RkU2cVNHV3JYcHR1ZktqRGFySjh2eUhnOFJKN1IxM0plUWtkcnFrMXU4TFpl?=
 =?utf-8?B?c3QwUWpxaGVuZVRNMUY0T3JtSnBkSjY2dUpBTTZLZWw4bHhxc1hzZkZDb3I3?=
 =?utf-8?B?QjJ2WDRlcWtxYjN3YWprT254czZLaFliVi9jSFVWdkdXRkR4VEh3cTF5TlRG?=
 =?utf-8?B?K0ZYWWVPTS9tVlA4Smt6MnJnR3hXVkN5TjkzYTY3bXJkL0w2QzJlaWpTWFRN?=
 =?utf-8?B?bHQrWitMVTFtM1FYRkVnWUc0RGNyL2xpcERhODRVa3JPODg4bng0anZ3aVll?=
 =?utf-8?B?RFZKS3pobHZJZDBlS3k5d3ZwYlNuaFkxYU90ZFRyTU9nSnF2a2lFR25CbkMy?=
 =?utf-8?B?SjVscEllMHgwM1FGd1JxUE9WemlqZm5udXY1ZWYxY1lnRWRaa3ptNDFWR1Ey?=
 =?utf-8?B?YUdlV2dxNVArdGozYXhYc3JEVyt3MlgvM3BQYVFpRmtRVEVRY2JTeEFaT2t3?=
 =?utf-8?B?SE5JbDI0bWJwMFhrekt0bUJRSUsrcVRiY3VtVHNQakhqMWloVVFGcnNKM2J4?=
 =?utf-8?B?QnBIbklIQlB5a090bDZkRW9CVWZKenlKR0FLTFdIMlpSTnJFaTdYZ0djTXBj?=
 =?utf-8?B?UkxrL3hUZ2FYR2FSU08zOU1scHpsQnMvY0c1RmMvTXNjU1Vod1pRSlg5Vm5K?=
 =?utf-8?B?UEgrcUdEbkhCZkN3ZDNkZHNLRXlNSTFNdFJsbWNRYkF5N0dTcWFIUXE1Y0E4?=
 =?utf-8?B?a0twbityS3FWMlZ3TUx1OWVpMy9RdWQ1eURpay9DaTU2Q2JIYUpGNEZLN3VP?=
 =?utf-8?Q?cgKNOF2FlR2D4v4rza77d9tiRmwS/Vx7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZWaUhVb2ZSYXpTUS8vTlBxWHVzbTN1V2pkTXRwUnowb3FhbXBZaFVEamVE?=
 =?utf-8?B?LzRBWDVSN1F5dFhCRnhDQnhUVEtNUy80N0VPWnhZYmdlaTNwNkJDSGowZTZH?=
 =?utf-8?B?cFFaS25NM000Nll3SWdFRVZRZE1xcS9ycms2d01KbXUvdytsckFuc2xTbENh?=
 =?utf-8?B?V2xqNC9weVQwTTRoZDhHZ21PenhNOTIycnFpR3dER1R4N211UitnL243WThz?=
 =?utf-8?B?YytMdjBENWNWVExRN1FxSHBZcUJoZGMzRk1XYXc0dXdpMVVkVVlpNUp4TVZu?=
 =?utf-8?B?VmdFZXQ5aXVYRTNQa2F0ZTNXcjRsTUJCVlM0clFGbGVwZXF5ZXptQmFVVURL?=
 =?utf-8?B?MStLd3NDNjhUQnNTSnUrVDdBN1o5dldHejRlek5Wb1BIa2Y1QmdhK0tiZnRh?=
 =?utf-8?B?SmtaT1hnWENsamdIWk9lM1FsUVZmeXU5dVc2ckk0WGEzakFsWHo3SWZLbmlL?=
 =?utf-8?B?MFF4TWFhRWl2L0NvZ3h0YXFnTGpRdHZQQ2NMVDBaU1Q5UWt1SEZRdGxDS0w5?=
 =?utf-8?B?UlNIVmhLdVhaTm50K01xRlVwS0JybVFybTNFbEtoYXVNaHVibWpMcGlFdmtC?=
 =?utf-8?B?RCt0dTRuNWdFWHB6NHI0MkV2aEhPd2Q3bStWMkUrd1pmQWVydlI4WWRmR2Vk?=
 =?utf-8?B?ZVdNNXpwd1U0NlgraWlFNVpBR3k2T3B5Q0x3SmtRcHg2eTdaV2NMM2pGbGp1?=
 =?utf-8?B?Y1dFbysrZktNT1Z6TUI5M2FtYlJ1cWJhQTdTSzJNejZDcVpOTXhwQW15Z2lw?=
 =?utf-8?B?a1U3YlRjRUNsejZGbXBaV09QeXNIR0NUQXJqV0kyUURoOERkVWY4eXFsSW5v?=
 =?utf-8?B?MEVBZStKS29XVGpScWRCZnNtK1FaV2tZYlU5NDNwaTJGbUxpNHQrSUwwMDVs?=
 =?utf-8?B?QnkrYTFtYnJNMldpMHhPNVNFdW1aYnVMV05RNjN1dEV4QmZRdG9PSGRLQkpm?=
 =?utf-8?B?TXhNK3RVbzQzYXpVeThXMHZOZDZoelM1Qm1BR0UzcmZlNCtkT1VzRGg1R2hj?=
 =?utf-8?B?RnJQUnhCOFMzUzN6SW9qb3Nxdm5zbWlnT3k2aW1IZFlyd1RVVGdjTmxlZFEx?=
 =?utf-8?B?MjVtOUJSV04xME0wKzZTOFo1SlFxWk5xRVloTWVaNUpSZlUvbFpHUTNiN2Va?=
 =?utf-8?B?N0ZPZFA4RVdhS3NQdUtDY1BDQXBpc1QzZUdiS3ZCT3pKMmVvc3B0Ykk5TGpK?=
 =?utf-8?B?N2VRcGp3NTBwOFpBZVNwcmpMWkg2bU15OWdmbmdWNFBQUHV6bitFRk1pRlV5?=
 =?utf-8?B?S082MER2aU1zSGFWVHFZL0c2TlRMYVJFaXAwcUZNajduZUlZeWRDaTBhbzVo?=
 =?utf-8?B?U0lNa3E2bXp6Y0ptcTBEYVlqRmEvTFVhbVVvUFEyVDd4SStUNFJGcGtiZUJS?=
 =?utf-8?B?c1plNHIrWHFXdUl5eHRhSmpnclN4VitqVjdHR3grZ0ZOclBRMkxaSkhIcXlj?=
 =?utf-8?B?dzBiQUpXWTFHc1dKaGEvU2tnSWUyQ3llUC9JVUYrbVVMdElCSGlzTUdFY0Fw?=
 =?utf-8?B?VUNQYXZ0QllMeVlKL0V5TkU2U3JUbFVZcGlQYmpKQnladnhtdEttbkVJc0tp?=
 =?utf-8?B?Sk5xRTc2S3ROVkRuZHpSRDVWTXVIOWZwOC9xT1dYS2RmRXowcExhTklWM2VU?=
 =?utf-8?B?bmpPM2V3Z2d2TG9hbkJ1ZG9aOFFDU2FYbnY1dlEyblVDRkltdGZmUU1hNUxD?=
 =?utf-8?B?dWhRNVE2dGFSZUppS1BhVVhVaVJ1YVUzaVhkSld1ZDRDOVRvM1NuVGtLc3lZ?=
 =?utf-8?B?UUtuanpJMThHelNubHp0ZlNCM0IwMEUzaGVBOVdpV2dYTGJoVnQrVlZxbW1u?=
 =?utf-8?B?SzdaT3VkM1FZWTMzZ2pjdUxjYVA3djRnTWJ3ZGtMNUF6ODJsTzgxdlpzMk9R?=
 =?utf-8?B?VWhYa3cwWGY5Q09HWldNWC84eXVqejFrMEhXUCsvTk1zYXR1UExaMkR2ODFN?=
 =?utf-8?B?R2N6NjRBM3lYcGZlYVJXSVJneHd3c2RKMUZMSXdNelFha2VsS0RVbHBPdFZv?=
 =?utf-8?B?SmRNQnk0VnpmZllXV0p1Tjc5MnFDQ3ZrbTNsYWp2RER2SW5rRHB4NmZmaGJH?=
 =?utf-8?B?K1BwN1JFeWFlenJVVnBSVzBCL1Z6RGR1R09aMWRkUDhvbnB4a3M1RU5rMzRB?=
 =?utf-8?B?TmxhUHFjMmZpNS8xbkRTUE1Xa0x2dk1qa01DK0NRZGNqTWFrdms0M0kzaUlM?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cad8b7-f02e-4986-2fd3-08de158a2678
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:53:43.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz43u0m9NFwYuHEC0wmtboDTRuoGU1Kx1yUWE8o3cR3sSSmD4ofJVbCy5YqLqgMssPlPWAJ27S8L5U+c1w2YIyV+eBCy0K1MKoquqWFXDxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com

Vishal Annapurve wrote:
[..]
> > A theoretical TDX Module change could ensure that atomicity.
> 
> IIUC TDX module already supports avoiding this clobber based on the
> TDH.SYS.SHUTDOWN documentation from section 5.4.73 of TDX ABI Spec
> [1].
> 
> Host kernel needs to set bit 16 of rcx when invoking TDH.SYS.SHUTDOWN
> is available.
> 
> "If supported by the TDX Module, the host VMM can set the
> AVOID_COMPAT_SENSITIVE flag to request the TDX Module to fail
> TDH.SYS.UPDATE if any of the TDs are currently in a state that is
> impacted by the update-sensitive cases."

That is not a fix. That just shifts the complexity from build to update.
It still leaves update in a state where it is not guaranteed to make
forward progress. The way to ensure forward progress is the same as
ensuring build consistency, i.e. sequence build with respect to update.
The kernel sheds complexity by ether making userspace solve that
problem, or motivating a real fix in the TDX Module that obviates the
AVOID_COMPAT_SENSITIVE case.

