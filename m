Return-Path: <linux-kernel+bounces-869687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2236C08823
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07239351B82
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51659221DAC;
	Sat, 25 Oct 2025 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1UUiD7/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7D1D6DA9
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761356547; cv=fail; b=GrFxJMfVmy2SqYgBIC+fvZd+qqauy6z7xJ2nxftn3zKR4LpEfNeJkG1Y0/uzcTHg4Q3AZ7RSU56OYkxUz2AsIk+z9rKSyd3ArXKO/2JVfhmKnrW+6F+IPXiCXXqe/ArmZQLg/70enwAUjvjDhQfvZLy1sD4w6MLa72IMvAybkQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761356547; c=relaxed/simple;
	bh=ChZ0ItQvn0Tv8jONkm+tz69Mbi4x4RQpyVJmDuzw0r0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=T26HB43ZvypwTKqaDa5BfROj3Ek+UoDEptnnqMtX6ei5SwsdHVZh0cMy0SMAGPfe169TIu6XrAJaWYcEkpn/xOHXd+AlvfwOFx9KFAdK1RsfzAjCI3KC9ZhaOdLHu33OFxt2rRjKx+I5nVSC3wcab5tXh+wEiY9NX6GEzpDcf1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1UUiD7/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761356545; x=1792892545;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ChZ0ItQvn0Tv8jONkm+tz69Mbi4x4RQpyVJmDuzw0r0=;
  b=b1UUiD7/PvN65g30ghNJ0Q4EZRvfE7QdI4tzfeeCkLnfQC3CO5Xm00sA
   1pF+uLlFICbEp4lS2GV55bk1iuz3wCve3e96fJCu6q5se1u5G9pqD4PVJ
   1q/7Yi5HrUb4FyTBrE1JpeOFvSGJFzNuJt/B2RsGX+QuDAvaSn08pN7yB
   Jd60ZB3biBKu33qqsPefSVIsy4aPylvpksSfngYH//Sc5t5/tr5UThSOP
   2Je8eKUC7ab/x1BPSAbFCfAUXoPHqDXWKkBX8iGdGtcPPOpMxSNGtR/Z3
   HZC4BWVyy2aZDS5gfnIdzb5G4Ojb1q52f/9cpXlWpcfEJOACkgvlOKV8v
   Q==;
X-CSE-ConnectionGUID: XINOnDHTTTuOjcef8RcCKQ==
X-CSE-MsgGUID: 7WUaNpQlTN+c46FqKRnTEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89007735"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="89007735"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 18:42:25 -0700
X-CSE-ConnectionGUID: ips22mxfSSe3qG4eiyK0Mg==
X-CSE-MsgGUID: SihG+V14RNC7gpQD8oIdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="184175331"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 18:42:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 18:42:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 18:42:24 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 18:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqq5ve95ewNcjuE5kYkcaIuKJEUhpCBPxZG1kwzzzejAar9nTpKjN/Mu5w2pi6qEMX9PMbCjE88/K3ifjZO7LyhrmN5fOdB2ORSViBdq4fqxk9TWFbaYpX8TCd/npuVTmqjG3M/i+7tFOfO6S0Ehsy2JVCth4Jm7Os4a757axAZAZrgzqLT4/C3gR2gQH2/yL3pLOjbFuVtphu5msB53CqGf+qiorQC9TT43HLcdBheYyNkXAMXD28MhaIJrTc0HaqDz1otibAQVv1BtYnepSCJj2TYJQ4VuyYO6PGxIjOo1hP3HR0pA11AAxCB/xZrlsM3+8uwfvsgYLKNdmUVj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwKxQQsITWPeLHzISm6EA5UT+FrbgJKRGNSDVvSy1gE=;
 b=XsPsATLLiN2vOM3pLSi57UhvFIV2cngVQCXQzfJm2BYqgdxhfDa8FkN1mDwDxx+afpemOaXZxsZ2YV1Jj6799r77M041GqmSFU5y16OVbF7f2wDzHIQ0s16UxCVsTFXq8SdFHBljS5+6/sRMMbrp6MjBmhOgvGPclECXOR0NFzuW5xxHHDfualybFHwKL+GSBc7Abdb1EIO+EccXXkhFLbzbjlTdlw9zTirqkcGSh9CgkENobDz3k8Pa6gFhff2fKpaG2JmvaXPfElWa2FTJarNNn2KDgpfixF08Ld8ZnYkX7fqjvvIVPacu14qp2o97NdW0QFw2wXDQyg9mZbKRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 01:42:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 01:42:16 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 24 Oct 2025 18:42:14 -0700
To: Vishal Annapurve <vannapurve@google.com>, Dave Hansen
	<dave.hansen@intel.com>
CC: <dan.j.williams@intel.com>, Chao Gao <chao.gao@intel.com>, "Reshetova,
 Elena" <elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
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
Message-ID: <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch>
In-Reply-To: <CAGtprH8AbW4P2t-wHVcTdfLwf3SJK5mxP1CbsMHTgMYEpLiWjQ@mail.gmail.com>
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
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adfe880-80a3-45f6-359a-08de1367ba1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXF1M01TZjdzVUtMQnlLa0dOYXR1NVMyNUQxY2wycGJXZ2h4OGxHNE55SHVa?=
 =?utf-8?B?QXJWcjBGMXNsNFNTRU9MZW5sWkdmR0R4WTU4OXJDUEE2dlpQNHF3UFZSanpv?=
 =?utf-8?B?UlpjcmE3WHI5bytvd2tLMHpkcnFYeUVlWmZlYVFXSDRuV2YwMDArMkVpK1hK?=
 =?utf-8?B?UWgwd2xodHMrZEpwSGhxMG40VlVxOGlxRGtEMG9nNTI5QlBNS1dtNVpiWTZG?=
 =?utf-8?B?VnVqQm44ZWxUTitSc3U2MnpmRFMrYm4wUjZWeVlBQ0Z3bjFYVkNwc1Q5UXpI?=
 =?utf-8?B?cnVUTjBZa1pTaGxCZjJYS0V1cDBPKzFZZ3NORU0yKzdDOHVUb1k3ZERRemlj?=
 =?utf-8?B?QVhOUHgwOFpoNmo0Y3NyNENzcExZcnU2VWNhUjU5a3JzY3JJRFJxQ0tMWm9t?=
 =?utf-8?B?bnE3cVQya0ZEWkhLV2ZWSlRSaDFGMHRudi92bXE0WjA1RGkrV1lYbG5mVUxs?=
 =?utf-8?B?ZzFDa3BieHdtRkd6eFd2VXU5UUFSMCtNaTNGQS9aSXlBWXJ4VFJxTGwxNVZO?=
 =?utf-8?B?TGN6dkE1VnI2QkVFYTRScUZqK1FGL3I2a2JvYkhGSkVPbmVteFVJdWtHZW03?=
 =?utf-8?B?TURHcTVZamhCU1JaeEpodks3SjFpK0RCaWlObDQwQlRWb0lSNVBzdnV3UGlQ?=
 =?utf-8?B?S0ZQbmdTSlU3OXlackVBc3RGRndHQlZZaDJnQk0zaU04cmtkbG9tbGI2VGlZ?=
 =?utf-8?B?c28zdDllZnExRXBRZEFvVEQ0bzJqRXBEZkdzQ1kyeHFMSzc1czBMY2RWdlJJ?=
 =?utf-8?B?Vjc4SEdrQStRTjRnNWg5Z2VUUGgxOFFwbkhUTWdWMHVkUjlEb2hsbzRsMzVy?=
 =?utf-8?B?T1NMWVgyVXNLQitqbGltNHVqY0VLbE9ESjQxMldjMHBISjZTdFZHUStFQkh2?=
 =?utf-8?B?cllzSElMSEc0TmJkd0lDeWFaZFUrdU5yZnV4NjZxc3hGMzdIOXdZaHdZMjcv?=
 =?utf-8?B?NEhyODlqaGU5cTNwczJEd2ZwZUJJOGZnME1Pa3JTMDlhNXpCYkthdG5HbjM3?=
 =?utf-8?B?enRmM3hzUEt6YjBQajE2M0pKNTYwaTlpQ2t4dnY1clk5WERCSFBXSTRGTzlR?=
 =?utf-8?B?b0g3T1RtbWlkRHJsRllVdFU1RTJqYTR1TVJWcHFwZldRYUlkTzFsR0hOZGcy?=
 =?utf-8?B?Y0FNQlpsendrT3JONlZ4WTZXa1ErODNFTnpQVjNVanV3d0UwTWJmOFBTazl0?=
 =?utf-8?B?N2ZWOHVRTTd2SkpNR1I5VVhtT0d6SlNRS0NVUW44enpLQlZycnM1ckZaSm5J?=
 =?utf-8?B?QXYrWmZPTWVNT20yMCtPODZ0MVFnbWpPZ1ZTS2dTRHplUGQ3OUlNbjZWS0FK?=
 =?utf-8?B?dW9tenpLOXFoeUVEYUIyQ1hGdGRZQjErVkNMN1IvU21WaDVzVERqeDQ1WVVG?=
 =?utf-8?B?RkJkN0Y2T3grT2xZTWtYclNCUEUrditPa3o2OE9GY21QZGNIRlBlUjE4c0Q0?=
 =?utf-8?B?SGNXQkFRK2tKbFNJampiRFM2dVhCc3ZZVlRPUHVITktKYjc0dy9LbE5weGkr?=
 =?utf-8?B?ZnhsTTJwd3F5aVVyLzVCcjBndFpOWGRvdGcwb2VSTHgyWWZnU21WZkVXL2o1?=
 =?utf-8?B?b1ErOWo5QlZtdTBNSm5KUkhiMWU0aituWkV5TklQK1UwdGQ1eHplYzY4anFM?=
 =?utf-8?B?SCt2NWlERjZ1bXZJV0ZxN0ZkYnkrY0R1ODBYZ2Q4YlFNVURSbFg1Y2Y3NjQ4?=
 =?utf-8?B?UHQ0VnltbGxPVFhISDhqTDB0SWkzdmZ2R0t3WlJkOVdtdEFDVElpekZZM3Vy?=
 =?utf-8?B?Smt1eTBYb0lQVVBKRVVzUjVjQ2ZKYlZyNFphK0NUUEdINXlFTlFtTCsyMzZ3?=
 =?utf-8?B?WFdTWjFtUGY2dXYvUWNzUHI0UncvaWlsRVRjVk52b3p6ZTV6NENKQkdKNUZF?=
 =?utf-8?B?T1U3cWI3NnVQNmtHQndBUmthb3JoeTE5UHZCWHE0ZEYwZWRaVjZZdWZ1ZkRD?=
 =?utf-8?Q?aRqtddBIRwtaWu+PrhXrFG0jYMWS3F3m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTY4QlNlelNGOVBQSEYvbVozMUVKdE0ybkV5cjFsV0tjQm9ZYkdRS1NtTzc0?=
 =?utf-8?B?bzFLTGcxNEQxTXlMeUdGenBzV2JSQng2bHZjN0lYWGZHVjdXV1FuNXZ1SVVW?=
 =?utf-8?B?RThXQTJyT1pGMk9hbHFvZTh6eGU1YVMrNU5yblQwU3hNakxiR3V4d2xKM0Jk?=
 =?utf-8?B?eE9qUCsyTFNIaFJ0S09wdkxCZ3ZLcjg0cGl3dm4yOWxaL3ZnOXkrR2pZRGx6?=
 =?utf-8?B?OTQyYlJwYnUzVFB6WUliaFVzM2I0NEdIT2VrNTRMaTVta08wZ1NzMDd0WFYr?=
 =?utf-8?B?NGkrMDdTSE95TUU0dmhzMys0NmNaeFVzNlZJNGRLZmc4ZXUzMzMwSmZSTkpq?=
 =?utf-8?B?OUU1TzMyYjFMdUV0czUwOWdwTkE1c0hFLzZaNlFIZU1HMnY1TmZmOFVQN0Na?=
 =?utf-8?B?ODFzUThORUtkZ1BxRlFqTjVwZkdCRUo1K1FmN2NCTGx5VlFNQmxWTlVIb3lw?=
 =?utf-8?B?TzFRRWlGUGxQQzYzZHRWL3orVDFHOUJSTXpEVXNSR3hVQWNrSGVneUIxSHZU?=
 =?utf-8?B?czhHaFRKTXJldEp5VGZveEFENVFzN2VVQWV5RG95cFJNUEFtdzkxdnE3S1Zk?=
 =?utf-8?B?bWZlTnJFbnJXOXBKSHBBN2hWUXBYQncxWmV6dzBSOTFyUDNURDBBQk1SWXAy?=
 =?utf-8?B?MmNYNzdTOWdOajhFRHNpS0NMUllORVpaUVNOZmQrK1J1MW5iWWVmN2tIcFNw?=
 =?utf-8?B?bXBReFc3QWhqTDViQzZlUlBOR3lVOFpwOGFDbVNiMFlxM3pkZVg2TDMxNVFs?=
 =?utf-8?B?a3AvVFlFMHV0cWFjRE9hdDVMUFR2Vlp3Vk1VSlhrdGVvWHZWSUZaRjBwa1lv?=
 =?utf-8?B?NS9HbStqaGhETDJuTDVUcm1PZVYrYk1hWUh6YXZJREwvVm9MT0RyOFlwZ1VD?=
 =?utf-8?B?alI4N0sxb0RoN2pxWEMyQ0hESkZNUFQ2eXNkajRMekE1YnRVdmhScHlBOThN?=
 =?utf-8?B?NTdTZ3lUaWdqaG5xODZlbnc0cVU5MUp3QjRsc0RzcE1HWTFyZmFETG1EcXEw?=
 =?utf-8?B?TDFhVkJjSTZKRCt5S0FTcDliK0cwWnJMRTNyV1d0MnplaVBna2ZVY04xb3By?=
 =?utf-8?B?NHN5SVY2QmxCMGtUUnczWU9Od1ZKRG1ZL2RuOGphZVFiZHl1aUNYd0RCTzVB?=
 =?utf-8?B?UzFlOXhjN3oyb0RBNmgvL0dUK21abXU4eEFCTE9ockdFbmE4c21Wd0U0c2JU?=
 =?utf-8?B?b1kwbGxCVUFzdVUzdEdrVURtU2FoVXM4cUJnc1pzTWowRmJUZnU4YUN0ckZo?=
 =?utf-8?B?ZUV0TWhVbmFFQW1yZkxXT1BUTjZmZXk1Q29oK3FjR050Umoxb016OU9hNmdK?=
 =?utf-8?B?S1lva21MTTlMalQ5aU1QVXp0Yk84TW11MXlqeHhLckJQNTlFT3BIWk43ZEFi?=
 =?utf-8?B?TEZZVE14eWt4SVBYUzFia083RHhhNVduYXhwV09OZHlaZUFWOUdFdFZ6bjVv?=
 =?utf-8?B?Sm83VnA3Y1RySnBiTHdvRWwvTlM5ZkpZVUJYSWRNT2RiYjJ2ZU9GaW10ZmNx?=
 =?utf-8?B?RWQrR1VjOFJZTldCenY0OG45Tm9XNUVyaTVEY0lyMUZIajB0NkpyUzdGam9n?=
 =?utf-8?B?SWtrc2VGaEl4ekFpbFJXKzZqTWw2R2drb21jVCtBTWwwaTRjRThTSjhCTmZK?=
 =?utf-8?B?cDJlVnNGUzVFellMQ1dSZS8vL2ZVZmhXcDB4aUdHRTU3M0FTanJsU3BsSXA1?=
 =?utf-8?B?ZUxwSEl6QnBDcDluQkt1dThtY1gxOGhsVFYwbk9KVndxME9pT0I5UmdhOXhs?=
 =?utf-8?B?a1N2RWxZays1bVFpVmpBYzJaTXVReHBDaTU2akhqR1FMdnJ6Z3plV0lXYk4r?=
 =?utf-8?B?MkZsVTNCVjcwQm5VLzg1c25EaU94NHcwVnFtY3lXU3NIS3pHblBFWXNxdGQ3?=
 =?utf-8?B?bWYwN0NQa0FENFBvVWpMa0h3Wnp6ekVhWW1pRUZ1cnpZU3BBUXdKdU41bjFr?=
 =?utf-8?B?c0c1M0NUa1Y3bGtlUnAxS0VMdi9TWTEweDVnZzMvV0JNaXBVWCttNkh2UmlR?=
 =?utf-8?B?UVNvVjA3bHp1Sm9IVkVGMmlPMHlZeXcvc2JkVXN2ZGdRWUVNcTJyRDg5S1RM?=
 =?utf-8?B?OHhoV1FlSWFIVW9mclBKcjNyV0p2SDZIWGc5SW5namhRRXNSUWRKbnJhc01V?=
 =?utf-8?B?RndxbEVKM1gvNzQwVlBndFVWMlM1Z0g4UUgzU0FldTF4VS9ESmxaYU56VHdF?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adfe880-80a3-45f6-359a-08de1367ba1e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 01:42:15.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOkpxZTMMYPoZLoarGupq2+QYsrrxAy6jsR1fyEjx5E/5CDmzxc5XoamboSLFI5Sz8OpMV2pyNgSxLVBrPNMzN/nWXziwd7J0AQyrzFsv5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
X-OriginatorOrg: intel.com

Vishal Annapurve wrote:
> On Fri, Oct 24, 2025 at 2:19=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> >
> > On 10/24/25 14:12, dan.j.williams@intel.com wrote:
> > >> The SGX solution, btw, was to at least ensure forward progress (CPUS=
VN
> > >> update) when the last enclave goes away. So new enclaves aren't
> > >> *prevented* from starting but the window when the first one starts
> > >> (enclave count going from 0->1) is leveraged to do the update.
> > > The status quo does ensure forward progress. The TD does get built an=
d
> > > the update does complete, just the small matter of TD attestation
> > > failures, right?
>=20
> I would think that it's not a "small" problem if confidential
> workloads on the hosts are not able to pass attestation.

"Small" as in "not the kernel's problem". Userspace asked for the
update, update is documented to clobber build sometimes, userspace ran
an update anyway. Userspace asked for the clobber.

It would be lovely if this clobbering does not happen at all and the
update mechanism did not come with this misfeature. Otherwise, the kernel
has no interface to solve that problem. The best it can do is document
that this new update facility has this side effect.

Userspace always has the choice to not update, coordinate update with
build, or do nothing and let tenants try to launch again.  Userspace
could even retry the build and hide the tenant failure if it knew about
the clobber, but be clear that the problem is the clobber not the kernel
doing what userspace asked.

The clobber, as I understand, is also limited to cases where the update
includes crypto library changes. I am not sure how often that happens in
practice. Suffice to say, the fact that the clobber is conditioned on
the contents of the update also puts it further away from being a kernel
problem. The clobber does not corrupt kernel state.

> > Oh, yeah, for sure.
> >
> > If we do _nothing_ in the kernel (no build vs. module update
> > synchronization), then the downside is being exposed to attestation
> > failures if userspace either also does nothing or has bugs.
> >
> > That's actually, by far, my preferred solution to this whole mess:
> > Userspace plays stupid games, userspace wins stupid prizes.
> >
>=20
> IIUC, enforcing "Avoid updates during update sensitive times" is not
> that complex and will ensure to avoid any issues with user space
> logic.

Userspace logic avoids issues by honoring the documentation that these
ABIs sequences need synchronization. Otherwise, kernel blocking update
during build just trades one error for another.

Treat this like any other userspace solution for requiring "atomic"
semantics when the kernel mechanisms are not themselves designed to be
atomic, wrap it in userspace synchronization.=

