Return-Path: <linux-kernel+bounces-874657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47BC16CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154981C60554
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836C2882BB;
	Tue, 28 Oct 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmh3sr2M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB0248898
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683565; cv=fail; b=buauTIDZtZdVTRR4LrFwYg1RoPZ8HHVd2mdnf/slU07Ye3LXWp9mnDq4UL/uJuKCykGWAAvSQLnd+AuaJG23rZeBERtG4KJGfvzogK3NRRjDnbHiksuzyHjluVOPLHvyOr43WKholOxtH518GFFoOVFY/lv2kUxreRgqdN42RTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683565; c=relaxed/simple;
	bh=UHQoJ62cVdC3Fv9LjzMP49SlXcehfRmfpfrR3296JH4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=DZK/kJnZ+TO8vDH8x0gE9P8cMbw9iVlmwS01UvaAiJgm552qgbOwSSCVbCk5P0i3D/OhheBxpgqFb+60cKyg+3pSGWUh/vGwPPJbqJYYuBP3poH1OZaz5RI5eXRpONixIf05Xe8TVn9PYTd0rhIr5pEb2mZ7Sx0s2phsZNWE0Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmh3sr2M; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683564; x=1793219564;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=UHQoJ62cVdC3Fv9LjzMP49SlXcehfRmfpfrR3296JH4=;
  b=bmh3sr2MMfVhEh6iOw13/PZ7XlE8/2V21I3JpQ6MDVbidAtLdsm47pgo
   xM2wo1msR6ztsnVw6Z39HxWbwu/tg0OnvSIecSjuQ0ecRhbbhOdcgsN1R
   mFAzvO/1JK8Ze8qlpwcC0dhZuJt95F3Mscz86ZBEqgbhMZLn/tqwf+nbX
   f+xwm6QFRGnNR/OYC4Ul0Y32xCpRl6uOZB/rS/laz26RYrucoFtKmgtso
   e0bz50ieXgOI+waoO0IiIVGdpImpBeAGI6RkxnVtvjeXzAkD4ffML3Ind
   29k9bK/EYJILp+q9LKSh7qxTkKc2ZUrh02u+yUMzuZ8ZnjYMt9oYY+4WC
   A==;
X-CSE-ConnectionGUID: v0JvBrJ4Qqe4Dh3lq6ANrA==
X-CSE-MsgGUID: w5hKDTHYTrin4N8LYK6Qew==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86424512"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="86424512"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:32:43 -0700
X-CSE-ConnectionGUID: 4h4Tbsn6Q5Kes5UPwqB3sg==
X-CSE-MsgGUID: 9kpz4ybCSQy/4eTZogbCDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="222674640"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:32:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 13:32:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 13:32:42 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 13:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ/4MP9JTBh6VSLsh+GTrc7ccW0oWRZmIu6CHle4jrTAnieaDj2YATUoR7g64jvp3OuINfhtJCPSVqOKKBlVKU2x9ExRNMRsdOSDmSZ/wB2lT6343n8HOXT5IF++1hQOF0IWdEcbnMSOlRij0bBjdpMQ+CjJjsGR16C5bKNNy8EcqG10Wm9UXJP/o/DRQS+eTmBuB55T0oPC3rLcWlgARUxL/cNM7lfbYQfzpm46D6P5sHMcdBIBHjZ8SjIRRmjSW1uikpWkx2+e3YNfzz+YjQPs/GjIrHR61TyM7Eg+1FNosukuoVF6rT/bAEfhNyTD0qKLusCAXZS4bH3whNUmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHQoJ62cVdC3Fv9LjzMP49SlXcehfRmfpfrR3296JH4=;
 b=dxrFjNRAi7blYmpbmTxazcxsUH7zPJR4+oyJ5I1zdh/7h4LxsNtU5PPL0HMccTyZpIbca6Vzy20pEtX+0Gb1jMSTHfb6EvOhLxa+hy31neKzbq+Rh/Q3vxdZ/Zpct7ArJ3SGTb74Phht074HfgAyEpzcmkjNV06fV0MoyH7j4WtAztYRE8HLGCEvMonvp0jXT6oI6c23rGj0L/zJio+ueys7zLwWOaYlcBSI1T33sDjA7mtco2aJKrsadDHybDqiGG0Bw6HcEqa8cgvXa/dS/fKgnV1ze8zlxIaPPv4WWVqpm0WfV+tz+vI03dMpmx9v8TZ2ohtf2sXq/6pkQNRi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 20:32:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 20:32:39 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 28 Oct 2025 13:32:38 -0700
To: <dan.j.williams@intel.com>, Vishal Annapurve <vannapurve@google.com>,
	<dan.j.williams@intel.com>
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
Message-ID: <690128666dc69_10e9100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <690127bfb4b40_10e9100fe@dwillia2-mobl4.notmuch>
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
 <690127bfb4b40_10e9100fe@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 145b9e36-c671-4b6f-6eb0-08de1661230e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVJnRU02bFNFYzhvcjlyc2tyaDdHbjc5a0REanZVaUsydU5DZkJ6dFdJY2pM?=
 =?utf-8?B?YTB4UUFlZlRSR1dCTUhMQ1hVdzlaaS9DbkVHME5BdHBYL2xJUW15c1NuRUMr?=
 =?utf-8?B?ZjZYSDA5YlRKNUZLa0NjSUNMSzFQV3NtMnYzZEEzRGFlOTlRdHJEK2pHTVl4?=
 =?utf-8?B?N2NIV01abzJnNGJQZWVmdkprMGxncVpFNzZCaHJKNXdZQ0NTVFU0U3RwNVdr?=
 =?utf-8?B?alVGUXFqSU5EOGR2Y0Jnc25Nenc3eEtleGxlM1FzMzlrSTgrK1dCbk1Nbmo1?=
 =?utf-8?B?WVJkMGRYbWU0RjhRUlVTanVZNkJ1cjA4SlF5SHhHS3hQNlFXUy9pb2F4ZFJ4?=
 =?utf-8?B?bDRMZW5vWmxMaFFsM3NWcUZRMjBNRjYwV0dvQXA2dDBiRGtMSFlaZzNMV29M?=
 =?utf-8?B?YTNjek00V2VCSW5GRVQ2Ti9zZ3kxZjE5OE5yRGFsQ1FPaGtFd3FBQ0N2cjVo?=
 =?utf-8?B?WUY1RmFsOHZ0K0MyWXlRWEh6LzlHWU0rc3B0bFNmeVJYQSttTGg2UXVOekxQ?=
 =?utf-8?B?akROOVJtM0lsRGFhdE5wR09zdWwyMUxITld4cUdqMWVlcG9YT3lFTmJTOTAx?=
 =?utf-8?B?dG1PVHV3WWU0TVpqamIxc2h4ZmxPVlBrdlpUNC9pR2JBNEdWV2RJWldLUDdJ?=
 =?utf-8?B?REZPWjh5bkdOaWNtdWFwdnVOZEVFLzk4NDVqdlZWcUs0bENYSGVKZ3BYeHEr?=
 =?utf-8?B?QW5hbUtpdENUVk4rTDhxc2RVMTJrY3NCSkpGcE15MGdzdEc2NkY3YkFLMUdi?=
 =?utf-8?B?S2NRaVQ4eHJHYWs1SDlkRFFKTUw4L094RGk0ZjM3M1dEREZxY0hRclBleXZ1?=
 =?utf-8?B?UjA5QXZzejI2M09pemt1RTRJY2NlVkJyU0RVemFlZ3FWQ1FBZTdOdldIcE1T?=
 =?utf-8?B?WDZ6OHpUM0RINFdqQ1pMRGhnb0hzdUw2dkR0ckV0dWQyUmZZaEY2Ump6RWVi?=
 =?utf-8?B?eWdkM3FoU0Z6cTdUUGRNQUY2YmlFQ24yVk9HUmFEZDVZakh0MGY1WlI5aEFq?=
 =?utf-8?B?RUJ1czVnTzR2UGgxa1d1RFFFdmRhMlhVcnkxSWY0QkUzTE5HaEMvbjVVWnlW?=
 =?utf-8?B?SEdZYVhrV1NhdUhTeFhQL3lrYW0wZ0JjRGVtamRKYVh2WFBhd1NyMUlxMFRY?=
 =?utf-8?B?Y0pWZG9TeGhxcXA2UHh0OUJTUktwb0VQQU1sUGpoYWhyUEgzWGk3KzZGZmI1?=
 =?utf-8?B?MWp2MjhENmt1Z2tkem1SMU43enV4THhRcWp1V1pLcll0cVVTZ3JKMENFSmV2?=
 =?utf-8?B?NUdaU2w5VDNRdU5ZekxSU2s3UHFYR0R1b3U0V2NqOGp4ejU2dkJhNUhDWjky?=
 =?utf-8?B?UkxSZTYzMm1tR0ZaN25RQmE5eEJEYnVyUWF2ZlRVUVJ6am5WUXZBTzhrKzlZ?=
 =?utf-8?B?N24xUHVNSUNBRmFPSHEwZytYUGZlMHVKR29iOFc5SmF6cDFUVkJzTzIzUVBx?=
 =?utf-8?B?NnhQc0huTW1ydWY0bTl0U0RKT2pxZTNBSE9QaDFpWTdQeThsNjJKTVl0dGpZ?=
 =?utf-8?B?bkFybWMxTy9FY1liVmZQTk9qVWIxWFBvN2tKR2czci9pSFNLcnJ0dWY1NS9O?=
 =?utf-8?B?aGNmcWpzMFNQNWJaQ3V2ekdRemlBUldIUytkOW16SXl3emxmQStZTFlveEhZ?=
 =?utf-8?B?alQrdjdqTWVpNVgxZDRDcVUvemxnQWpUcGN5QmdFTzNLY2c1WWJCTXdBaFA3?=
 =?utf-8?B?Y3l0SHd2UzJhemFaYVgrWU5IYmNSK2wxQWd6WTZpc1RHdXVQbTljV0I0Tkx5?=
 =?utf-8?B?TjRLTE12RDZxQ0pVbjNUTGQ0REpQUlNIQnJoYTB3VVZjMmhGQWE1RFNSNXhq?=
 =?utf-8?B?UUE0MVVrRzQ1VTZjeHROSWxhRk05azYyY2llc0RydzZvUnYrQzdzU1JSdHdF?=
 =?utf-8?B?dEJxdDlldjcwWmlFa25BL2VMaFkyTlBUSlprUFNTb0g2WEFUaS9OK2x2SlNs?=
 =?utf-8?Q?0C21UO1Oc8MPyAvl8VdB6zA4geGNtqzw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3YrT2ZCTjkvVHpDUy9CU3ZOM0RTK3QrR21xOG1ZOU5ZS2RacWV4ZHRLbFl0?=
 =?utf-8?B?V3ZraFNkSlc5MUNYcW9NWEI1dmdLM0Ywb25KOTYvODBiZ3BnK0tITTRPQkVO?=
 =?utf-8?B?V0NjcGZGNG0xME9iVFgvZmVTWnphSUd5L2NhbWc5ZEJvZnAzN1ZLaFF3TXJu?=
 =?utf-8?B?QjdqbWh6M280djUxMnpBS3F1RERvUm5zVnJsenNBWlp3eFM5N0RkbUlwWlF1?=
 =?utf-8?B?NXphRkhOQktRdDFMdWpZd0d6ZWNNTWNHMFg2RDdjMUFNWWtLZUZtRkhOdVZK?=
 =?utf-8?B?SU1hbFhjWFdBakVwQkJ4WERydmpwZFJ3UEpaSXBEMW00akFzb0g4cHRXeDVT?=
 =?utf-8?B?dzduTi9jb1ZvSHJZK3ZIbHc1WHhCZ3NjZENId293T3dQdjdUTHdVL244dFM5?=
 =?utf-8?B?TEdaZUdGbjU5azVZWDJFQUV6MXBjRm1Vd2JZY0FuK1JPeFkwNXJveTY4OElv?=
 =?utf-8?B?VHlFcHBxeWFYcTJBazdUeXhXNDVCb3o1cUNWSmJSZDZITUJSVUY5RmpPU0ZH?=
 =?utf-8?B?dE56VEhFenN0Nm54c3pPU0MveFVWZjRVRHJKRmhuUVVkVHFNSUVycU1CWjRh?=
 =?utf-8?B?TEdYUkljM04xZU1MWXlJRlQxa3kxWGdQZ2grQjZUaVh2WTk3S1BNODgrd2hk?=
 =?utf-8?B?UzFzRW04Q3QycjhIOVNCUDFFZUVXMGU4Z21USFkvVXBwTDUwZEFQYlR6N01m?=
 =?utf-8?B?b3BMUk9HQWJYUnVSanBub0dEbFhqNm9pR2lpTEtmRGN1aUxXTkVoSFhXMU1Z?=
 =?utf-8?B?WGRMRENWUzkrMERpWDU1bXJmNll5dzlmblRZUk1mb3pNWWgwVGFSRytXanhQ?=
 =?utf-8?B?aFg4UExEYWxYbUFKYzMvU0NDdHduOWpuZkp6SU5pdVJtT3JKYVMraFpjdU9i?=
 =?utf-8?B?Z2Z6M0d4a0xMRFNJQlJqejJYN2tydnlwVTVxVE9ONFJvU2dyWUdid0tKNGg2?=
 =?utf-8?B?clpDVnpGRVdQUkVibmtlMVVmVWY1SU9VWWVxMng1bTUxamtJcjcrbFdValNi?=
 =?utf-8?B?eVQ3K0RxYUhpUUR2WW9Jb2lEdEhWS2gwMGRLZWJaVFFJUHhqVmZ4VGhKOWJ6?=
 =?utf-8?B?SmtCYm5WbkFZKzE3ckFPSG9JWmtRYVMycHZualRNMHVaUTBiYVBrWWEzZThr?=
 =?utf-8?B?Yzk1WHJxV0NjYThVODZEMjhqRjNKWXc1aUJqa3ZzRGhYR2NOK3BzU2tzNTIr?=
 =?utf-8?B?WWtnWmk2QzM0eTlBSjk0elFMSWYxdzNaaGNjQXRIdUtFVTRSZjdTajhadVh1?=
 =?utf-8?B?T2s1NHFuejdGbFI1NFN1VmVRamxzMHArZFEwSkNqelFXS2tseGNqb0tEOCs5?=
 =?utf-8?B?OWFSangvd1ZCcHJkQ0hKWmViY2F3bWVnNlhpS0lQTkxiSFRHZVRrSnVkN3hj?=
 =?utf-8?B?ME5tdkUyUWRiUWR0NlgxVGZvNzBxS3FZMmpWcGJFVTlrYUYySUtxYmJKMGRt?=
 =?utf-8?B?TzlrY0hBNi8rak1Cb205VE5TSXBjclVGaXR6a1NqbkNoN0RMNnBkTWN2Nm13?=
 =?utf-8?B?WE80aGY4REhHT2dZaUE5aS8wTUttV1dXSlkycFJickpqUFRoU2lwaU1ESWxC?=
 =?utf-8?B?N2ZkWVJySHZ1VU1jS1RlLzM2dTlLMk9UZ1Qya3BRNUltUVVHSWFNazQ5Q1Rx?=
 =?utf-8?B?bVEwSVJlSi9uTGp5a08xQjBwZEpxd3BodGtGVG9pdXh5Z0dHRmF1ZVN2SjAz?=
 =?utf-8?B?K1lHU0pRWlpJYkdaZ1g1SWp1VUUrbzk1Yk1ZdUM3ZkJRY2dHeDUzKytKbWxK?=
 =?utf-8?B?SC9sdXU5Y3MyemtYRDlnYTFJZ3JMRmFQb3g5VXFHbVEwMVJxN2lkVWNtMVdz?=
 =?utf-8?B?cFN6ejhxb2tiR0NrRW1iMm9CMlNDWXd1TUxYenpoM1B2aGtDM3lPaUpBajcw?=
 =?utf-8?B?VFZkNm8yd09OYVpUaE52NG96R1pZdmdab3VFckxvajBhT3VXcU12R1hvMEVo?=
 =?utf-8?B?bStxU0dySFNxOTJMZFh0UXZGclVCeFBhZWxuUytYdndKeUpQeWRRZXl0SC8v?=
 =?utf-8?B?a3hXMU5OSFFSblZWNlZaUndkcmRabHQzMkdVOHA4OUNoMlUrYTcwMThQWFYy?=
 =?utf-8?B?Z3R0dHVJaHFic21ucmV3NkpYZUFobDE5TlB4UEhQS3dnZmhucU52QXpoUVho?=
 =?utf-8?B?cnhWNklZWGx1dlFobFhnS0ZxbDk4VUlyRDNia2NJOHRUMWRJaHBDcU1HUVJD?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 145b9e36-c671-4b6f-6eb0-08de1661230e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:32:39.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmIrc1pK17l/aFUIDHFTKWIMtsaHzV76rxeHiP2k49kBTh7cQ6vmqgqqM1ARIddN581yZ1kRM7XFvPLjPzJeyLEFsXqlU/8Bi1qLwAor9WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> That gives update a transient error to handle

Apologies, this was a draft sent in error.

