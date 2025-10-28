Return-Path: <linux-kernel+bounces-874645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BAFC16C74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95E1F4EF9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F2F2D0634;
	Tue, 28 Oct 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kogqHTwY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B7221F20
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683398; cv=fail; b=R60WkplzOpQLYLysxcDgEOrN9Y6JUK8w0OUfK2Jefq4J6FHv3m9C8zw1f0YtKU/b6zaAdhcxUfC/aUy+SLQP7EAyf+hjpoE2CUVQMFgVw9SBaV5r07WfqSAhW37a//cnuOhSoM7IfUgUKcP7ooUG4r1dusQGnnUXo3MyU+2v1OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683398; c=relaxed/simple;
	bh=mLlkC1qJNk6pUTQ3Pp5cIRWoVWduA1uWRUyX5g2wLS8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=R3y/ANzUP3HNcfk7CH8VW+t9Haj+TP34yKKPkKM0QajuYUQfAy9svs0zkdozOT5FJzk2a4fq//maUarrXeABxeTLEYitFir9n9CzOfJ2OD1Wog1f+ojekPemtYi32/4mDSo/X+RVgiuA4vwwH0zM5Nrad6aqj7cFwWMFjKQmfD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kogqHTwY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683397; x=1793219397;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=mLlkC1qJNk6pUTQ3Pp5cIRWoVWduA1uWRUyX5g2wLS8=;
  b=kogqHTwYIJ3c5bxwIDdMdkuXaEaM5tkMMumi8sqtZ0xjSIY7mLQ6jPL7
   eHPv8K2/tCrsjoi02xS43z4YK2wcgbmXXRuB8OoBtNIlfP+CTNUQKhrvJ
   ZQMfPgIDgKxG2uTda7pnQd3tTrYqrJ1BJqv6AOAwXp8m98kOp+wcy1r/S
   XU09aRQef/BGgsfPwGKb8T1J3cxvUUk76GxYaLSb8stY0FSReWt4t0J0a
   HxjTbnH/KfuY6ID+E8yoGtou6IrPEWOQMnE9JOax2BgGZiQaLTpmRfIni
   B0wTk7bnLgRfi1r5t87Uw/I/fpVosHZYlgrWQCZNI4226btzkZj0ZCypE
   g==;
X-CSE-ConnectionGUID: dKzm1SwPStC+b83yVcr0jQ==
X-CSE-MsgGUID: yFqC4rR1T/GNxSB9caUNKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63945196"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="63945196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:29:57 -0700
X-CSE-ConnectionGUID: ghE1Eb54Q6i7TeyttjLM8A==
X-CSE-MsgGUID: gqb/ERvpQCy0JxBnnfqPjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="189507201"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:29:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 13:29:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 13:29:56 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 13:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD5dkbA8/sHwHWP2p7biiGvZSXAkTzzkTd8xBw+mdIv9ZfvkERT1G67A1LZ4Jz8IYY/+/Xffsh0jrQM2VDhbKrdFG1OcooXOL0bDVYDJyiPVxsot6te4/lWwne6dTHLG4dpsWXreajvf6sCaMEbNh/IWB2cosjwwBZPHb73meKGmmXTMrPBeOGTLdfiXvdpMOY1DTgeVdzorsIuWVF4hC+OElMSBz6KDfg3BUdgSIDdgj6OMskyRMe6WRGM6ch/mbNqwnDf22xDyeVYFbcWTv0Cweh/WJFk0g4KCW8nuXvG1t9Tj2QsxPDVXt2rI3rTrP0PEFpYmEkbcyG3GkcMBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLlkC1qJNk6pUTQ3Pp5cIRWoVWduA1uWRUyX5g2wLS8=;
 b=G83DPQe/QTC8F1PRwN1HiDDUVNrXTNue8Z3V5usdWNBDjqOz5Zns/H91mxD28t4DnLw1Ki0zf0XMUj5mgVV4dodrDAqcSBEn3MS1cnU7HXuS1G6eWmzjOucvxH4uQVLSgz5UDuz6bpp22n62MNRJLMJJYi7axdkItuNwwfHSR30VIpgaWBHSFUMtaEXfGUCKobYT26aYzk5DwOz/98bzftKA4FqdeIzIN+KE67fR7GDJsgdsGazqf7wnQzxxc+UiYvH5suM9mBytJMwUsCnrCYcG9YlBr22ubfm8PA8keESzPYGihALPhIAHzfnWTyiCjOGo2gS4Dx2jB0eDpgnrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 20:29:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 20:29:52 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 28 Oct 2025 13:29:51 -0700
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
Message-ID: <690127bfb4b40_10e9100fe@dwillia2-mobl4.notmuch>
In-Reply-To: <CAGtprH-rv9T1ano+ti=3eU4FO2APCOcR06buPALggAwUnka3Dg@mail.gmail.com>
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
 <68ffbfb53f8b5_10e210078@dwillia2-mobl4.notmuch>
 <CAGtprH-rv9T1ano+ti=3eU4FO2APCOcR06buPALggAwUnka3Dg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: e6210fa8-a63e-4975-ceeb-08de1660bfa2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFdaYmdHQmNxY1ErOEdDbTUzRVNXZTIyZzZLaUE5QmVCMkxPNWZVYURyNHRG?=
 =?utf-8?B?VldvVjZYSmdqVkx6blFxdjVpMnQyV2lMWDU1cjRwNDBHSk9FWXF5Z25FVnd0?=
 =?utf-8?B?VVZ6K241cEdlVEw4VmtZRHhUd01DenhuNDNIK3FiTTFNR0EvMmVzdEZuZHNO?=
 =?utf-8?B?WGdybHhnbk5YUFB3QkZjQ2VBWGxEam9DbVdBd3N0TE5LdnlXcjNxS2ZvTWlO?=
 =?utf-8?B?Um1ZMXllem56UGFGSmRPdDczQzZobmEwbVI5WDBaY1ltNkFQZ3Z4U0hrVkpE?=
 =?utf-8?B?U1VhTW9Fd00wVzkzVVdoMENyNmx2WE40aGptRWFPZGh4Y3U2dVdtVTN2VEsx?=
 =?utf-8?B?eDh0bTFXYWFDWUZ3Tmc4NnhWWjMvNU9sbnBrRVA4WlpWR2wrMlB1UC93ZGtz?=
 =?utf-8?B?K2xLeW9mM0FvNEVyMjdIajR0d2lROE5nbzBCQk1pUFd5VmJuVHF1eTRWRjlz?=
 =?utf-8?B?U0NCNEwvUjVZNk5qMTV3UzRNRlducWNBWUVIYlQzYkNMa2htU2ZUT1pBVkZF?=
 =?utf-8?B?ckt4UC8rTFBLMXBTUTdTcUdHK202RWJqS0NHZ2I5dGZvYTBOUk5TMWRVYi9Q?=
 =?utf-8?B?enM0THdXWk5YK2ozci8zdXorK2xRL0hqRHN3TFQ3R2Z4cmkvNGoyNk5FK2JH?=
 =?utf-8?B?Qk9FTkwzNDZWR3RIbWIxZzEzUkk1MnIwQVJOQjd0NlBrdzJHSjJMaDdRSmxl?=
 =?utf-8?B?Z0VXU05jMElkTmNRNHVjdGp2K1lBKzVrbmJ3UVRsVHBMZnpMY2RCRnJZdmc2?=
 =?utf-8?B?NXliTHc0bUkzKy8wWDltNm82Wm1ITnUvc2FURmExSmEwZGxFZDZLZ0IrNU93?=
 =?utf-8?B?VXBUclhQN0w4YjBmVzdCWUpPbmh6d3llWGhScmQ1djV0c0l0VlFOQWZTM1lN?=
 =?utf-8?B?L3hyS1B0Mi9YUXJXeTkvc3lCS2NtaUhlNkhNTDdVTTcyNUNoemxMQWQwMDhU?=
 =?utf-8?B?T3ZOUFZnUkl4V012cnFPZklMc25jUUVSemUzZlFVZDV4MEJYZjdSSnpVcTVK?=
 =?utf-8?B?TW1uUXIrQ3M3V0V6Smp0UzFGZ2ZEUGl2bStiRFc4Q3I2L2pZWHQ5NE0zNFYv?=
 =?utf-8?B?UXZCeUxrMG5oLzAxTGtMRnVtNEJlUTlQWVJmQzMrZ0dGUlB6eGxyNjMrL1Ew?=
 =?utf-8?B?SjJvdUlpQWRSRnRmSHZhV01FOFhWOXlMUkNpRjBuYTJ1M2hsVnBXdnFFT1Uy?=
 =?utf-8?B?QWhGeDZWcjN5ak5ZdXhaazdsdVp0bURUbTYzRDdqcXAxN2RJeGFCNE5rcGNI?=
 =?utf-8?B?c2VRcDAvdytMcmFNeExOYnh6QWpXMFhFUVBXUXZDbUp4aDhEYXFVZlV5QlVT?=
 =?utf-8?B?N3RHWTFHNjl4a2lKekY5QTVrZzE5bEVWY1hRTjZmMlhnZVpvejhEVUVMbzl4?=
 =?utf-8?B?UWFVMUJVRkcxKytFYUEybjRzYzVWV0o0RDBvaFhSTTF6NStHT01zZjFTRjRD?=
 =?utf-8?B?M2VQUWdYNnlKc1cwdlkyNzM3bXRZWDVCbDd1WVdUVXMybXloY2VORDB2empk?=
 =?utf-8?B?VFRUWTllbUIzbWJ2TTZLdGh2MmNmQkVlMnI0N1JXZTZobXpzVFV3N3ZyL2p3?=
 =?utf-8?B?N3ZzZTRqaFVhNVVwQTBSODB3bzlDSnFjbEo2Rll4ay92ZFVVZ0FFOWc5WWUv?=
 =?utf-8?B?UUt2eW1DQmJ4MExnQ1JLMElrYnJManlKNUFsdWRFdGU0MWRtTTRBMnZyZkdP?=
 =?utf-8?B?QmZhRHFDVnlzR2Q1REszU2Y3VnFub1IvNnNXU1V6UWZkWUVWdFYzZThFeUxI?=
 =?utf-8?B?M3ArNzc2Ny9zV09TWmErbnl6SzNWYXVwT2hSQXpzSFJVajdVMnZneDlFdDVJ?=
 =?utf-8?B?OXlaMFMrNjc1UFp0UllkRmlQWHptOXEvbVZocUVyOURURngwT2hLaDdZdTQx?=
 =?utf-8?B?cmdqd0NzUjVlbTlXWlNINmk0MXYxMTNTNnM2Sm10dWw0b0VMUmhWeHRZRjQr?=
 =?utf-8?Q?KxZHYlw873toNa4+Gtoi9xzzwutkpNCh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnB4aFJyYUFIdGZ3QmwyaGZOZzg3VTllZ2h4SCtwc0ZKaVA4S3gwb0dLL3RG?=
 =?utf-8?B?bGNvZ3FSTWR6MjVyWERHcTBjQURkUGJkVHkyeXBjM1prTkdmU3NiSGVhb28y?=
 =?utf-8?B?NFRldzgrTHdGTEFCb2NWeGRnSWsrRHNCR2xUNnJ0cXJkTVpwYWJBYWZ4dmpR?=
 =?utf-8?B?N2ZkclIycUNoV09lVHBjb041MEVlWkMwZ2FRRnVmRHBORjRGSjk0NHJXRTZL?=
 =?utf-8?B?OUp5Q1pqcXg1L0NxWkFodU1kZ0l5aDUwS1hDS2dPOTlsTWFXL1RuK2k1ZEtr?=
 =?utf-8?B?WjF4L1dCQVZrbmliWVFzYUNUL3pWNzg5MlFCV29nMEhQZy9LWkNRN3NmQWtT?=
 =?utf-8?B?ZWdwU3RKL1Arb0JjOFRDaG1BeE9Fakd0NERrdVZZSTV6YmxIMzdlUE1ITFk0?=
 =?utf-8?B?ZnVvSUdCdUdIWGNJK2hsN01tVjV5Y0htWTFxN0p1UHBtWVRlVlM0V2Zqd2xs?=
 =?utf-8?B?YzIveWJaNnVTTE9tTDhnTlFmQ1NYN0R5KzJ0MmJreGtJMmc3eDZpK05DNlR2?=
 =?utf-8?B?aWlLSUF1R1E3LzdQTWd6Z1RPekxXdUkwQkJ4TzNLSm96U3Nyc1hDdWVtM1Fy?=
 =?utf-8?B?TjVTS0pMVlJqZDYxMVVEU0Z2NFU4ZVQwcWVwK2VOY2g3bjVqRVRvczBaTVk4?=
 =?utf-8?B?OUJpcXMvMTAwTDU2Zk1yZElFMTJtby9KcTFxaXJjQjM4TEFGR0MzeFhvOHNn?=
 =?utf-8?B?VEU4NEpHU0Y5ZEhGR1Z6Vk5pbmttcTJ0S3pDcUZqZjBHdTZLTEVZMHIzWW10?=
 =?utf-8?B?Y0lFNmtRVjNiZzI0NlRMSDBLaXExMmRhRzhpREVodUlrZDRBU1dCQ29kWExR?=
 =?utf-8?B?UG5YOWs1MkZaZjM5QlFOMGdVZXpVY1Y5TUFmczYzSVlDSG9Od0NIKzVrWjc3?=
 =?utf-8?B?ZjBEUnVGa3RHQ2lmbVB3T29mSUJka1gydGl6QTVJaWVXTHAwM1VhWldvYklJ?=
 =?utf-8?B?bnYwbGlJRW5kbDhIY3Y1UENndkt5ellNY0tRU2Q3cjM4VjJ3WXlPaHBCVmRU?=
 =?utf-8?B?QVo2ZVdHR3JhVnFRM1BLaytYcW1DcitFZFdQcUsrQURsTkJlS0t3dmN2VGk2?=
 =?utf-8?B?R2dFYWtlZ2ZXVVdHbVUyL0syVzVKSFFjVjB1UFVTczF1TkFpUDArd2lFL3dl?=
 =?utf-8?B?TFhkd2NUbGpQbUd2S09CckV3cnU5QVdTcDh6cU5SK1BoQ3BlaTdhcXVMOWJT?=
 =?utf-8?B?byt1enFmS2VKMENXYktCaEFmUEY4SUNtOE10MmhwUHc5ZU9GT1VxUFUxMGFD?=
 =?utf-8?B?Z1I5S0hzMXFmOVBwNFZpVE50ZytiYTdrK3hWVXR4Wlh2amZIbEJkRThmNXd6?=
 =?utf-8?B?b2NkdEp0WkdsdlNibE45clM4cU81cnFsLzFCelZZckJtYXZvVDltc1d3ejN5?=
 =?utf-8?B?RWZqWTNYMENCcnM2MnRJL1dwUnBObEhMZXFwUUdEOUNxQ1MzWmNMaHRyQWhH?=
 =?utf-8?B?K2tJSnFxcWllbjdXemIyRURXRE5VaWNWek1NdFYvakVKWTN3RlluOGVHREVs?=
 =?utf-8?B?V09oY0FPaXNZSURGL040bXNGblVYMXVNK2xrMllmS2I0eFk4T21ha05FOHJT?=
 =?utf-8?B?aXVSMmhNNzZSU2dzc2MxNnhtQUFHblFRWURiWUErUlM1ZTZBTzhpeXNTUGpF?=
 =?utf-8?B?cytPeHREVnVmVDNKeFl5WjNZa2J2RG54MEFCQ090cmtMRkwyanUyRE0yVWla?=
 =?utf-8?B?NmI1WHdTRW1YcWFqNnV4cUNZZTQ4M2hINnBtZHZoQnRqREh4NU13RXF1cXhK?=
 =?utf-8?B?cGhObGtNZ1NmQVkzTEc1b0FWWDF2VGlXMmc3MVdoaThHKzVFSlBaVDVCREVP?=
 =?utf-8?B?YVR5UXhMWVFvVDlsd2VrOUp1YVZFamVnNmhiSSsyYXl5NG9GUW41djZ1diti?=
 =?utf-8?B?RzNWZUVSQ2p3U2t2UGZ2QXBDYnhZU3pyK0ZTbmtWMnJRc0llay9sNmlHbjRH?=
 =?utf-8?B?ZnlwQ1pybUFuNTFVbktkN0hUOWR2eEEwRjZTNnZFWnA4bEVPMW1DMG4vdDJV?=
 =?utf-8?B?QzRYblVCY0JnWDFrcy8rVjNzSitxNk5yRmw4UVJlWWpnWUU1L2dBaFpsZENU?=
 =?utf-8?B?dnFwYkxqTnMrZ1hyQXdJMEZOYklDQmZ6Wi82eDBTSUNTNUJvTGx0b0xBYXR5?=
 =?utf-8?B?aDd3L1BWNVhhQ2hBQWh4ajEyR1M1Tkx3ZWNhSGVDZmFuUXFHNU9BWGFkUnE5?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6210fa8-a63e-4975-ceeb-08de1660bfa2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:29:52.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxCeTFfAH/TlQN5MEN3T5inlxWDBMj8S49oPvXJhsf/O8cFENjm6K1F5e6WcOy1uPN21ueyI1cEEFlrWfub2jDvR+alMiB4nW71ymnWsWbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
X-OriginatorOrg: intel.com

Vishal Annapurve wrote:
> On Mon, Oct 27, 2025 at 11:53=E2=80=AFAM <dan.j.williams@intel.com> wrote=
:
> >
> > Vishal Annapurve wrote:
> > [..]
> > > > A theoretical TDX Module change could ensure that atomicity.
> > >
> > > IIUC TDX module already supports avoiding this clobber based on the
> > > TDH.SYS.SHUTDOWN documentation from section 5.4.73 of TDX ABI Spec
> > > [1].
> > >
> > > Host kernel needs to set bit 16 of rcx when invoking TDH.SYS.SHUTDOWN
> > > is available.
> > >
> > > "If supported by the TDX Module, the host VMM can set the
> > > AVOID_COMPAT_SENSITIVE flag to request the TDX Module to fail
> > > TDH.SYS.UPDATE if any of the TDs are currently in a state that is
> > > impacted by the update-sensitive cases."
> >
> > That is not a fix. That just shifts the complexity from build to update=
.
> > It still leaves update in a state where it is not guaranteed to make
>=20
> IMO, there are two problems here:
> 1) Giving a consistent ABI that leaves the responsibility of ensuring
> forward progress by sequencing TD update with TD build steps with
> userspace.
> 2) Ensuring that userspace can't screw up the in-progress TD VM
> metadata if userspace doesn't adhere to the sequence above.
>=20
> Problem 2 should be solved in the TDX module as it is the state owner
> and should be given a chance to ensure that nothing else can affect
> it's state. Kernel is just opting-in to toggle the already provided
> TDX module ABI. I don't think this is adding complexity to the kernel.

That gives update a transient error to handle=

