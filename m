Return-Path: <linux-kernel+bounces-782661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247EB32359
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E743B563CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB32BEFFF;
	Fri, 22 Aug 2025 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQ+QV6gp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE58230BCE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892925; cv=fail; b=dlAOZeAx35oZS0i8xdD6zpkKeIAQBVlZ4UMPsYSQJBk6xrCszotaoiGJYZsCWC2ubrV0DvtMLo81/7B6DrB7wm68N4x2tq0ObkXG7D91YDdkBzRcm1HZzxFIxpVDNhIlHAPrWKqp6KD9ZwEJkP/F/j6MymsHXoW7LW7ROAcqD1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892925; c=relaxed/simple;
	bh=NwjX/HDUtJMs38JrGjz39cStdWXrffHc+eXfVkVLBH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/G3YdKcqizetW/7E974DtoCjVmdVe5yfEaPx02OUyI1gJm+m0Lp6F2TA8HV5XH0E/y+VesOW7vdO7By9W4l1pRIVV2+13DqPYf/PcDz92DA2mcLS63Gb4H+wMNazy8bq1xPFnfBTw6WsaKo/CfPa47vQnkIChcH4mg+ihmYVo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQ+QV6gp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755892923; x=1787428923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NwjX/HDUtJMs38JrGjz39cStdWXrffHc+eXfVkVLBH4=;
  b=AQ+QV6gpzYg96OhVR+H86BwFx+NTyKVHz/f/JQKON9jBXLND2TngNOR6
   gQJVWXmn+mELOSI+xdJJvx+hdGVD1BllqeW1iaN8GvFut2da2x/E4rCMD
   25KhFVn4BmEAMvBAdDI944r64QNaMq2T2bgSvbbywABYPnNPB2ShKIP+S
   y2F9eD6vq1b0U/ZmDQ/WIWo6rpLVSqyyN3v7d49oH9cYk1LJcOBQKmhKA
   cBZQEjXrB2yNEknxOYtyt5Wj+iluFbGBR+h8aNSOZHCv01riC80aOpMZP
   LyvKU8n/XO1Nekeo5FBVaJN8EZCWOEyFHL1R9TXnhKKs9fvYyu4klQ6Ol
   w==;
X-CSE-ConnectionGUID: 2kbJ64MGSmyIOSDrSOyYEw==
X-CSE-MsgGUID: 6df8BnevQdGWHj/reTErxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68909743"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68909743"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:02:03 -0700
X-CSE-ConnectionGUID: h4YF+/k+SPm9PUbDWQ7c0A==
X-CSE-MsgGUID: eiBjPL+USPKVdgWCJaUYLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168689232"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:02:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 13:02:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 13:02:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 13:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epRWLIuzBf6g3LCVTFQm2o9Q9EGXrJxpIGiajFeW3Ucb3zd1892i6cbEoPf3f8Y7sh07FLsTD0oODNEbH0DxN8CP7dnSx2dx3qcOB8hk9c7EWiMhVpTo0+s3s5GUyY+VB7IN/2aY2oU4IEmHZ51Ts05Qj5PBkfx0TEKr9c+/u9BJA7YpB3sTIzeQOisNoOGt+XO/59qVvZNs9LmpCowjdBx2TGCKBOHkcNcMduN7dX4COZsOnEOV/AHsudsh9uhxbZ7+yRSXx6wg+DbH5j237daMkmOemZ8wq6aKxM5vbU7sdlbgENc+78OFX8vS1LK23WS+aYZDSOGe44JR9kjrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwjX/HDUtJMs38JrGjz39cStdWXrffHc+eXfVkVLBH4=;
 b=KLEqETn+kwITsBWh4d/UZ5ejgferTazYRg1sNRHhBkeLMdhnWF763HNXAt+oSL2e6gfBxwxAmAK1NfFqVGTAD1irBjFiWx/cbqDa2XyORgD2QBHQBRF89qKXOwJ9KergtQA5rNKTk465EmhLmuRJFbz5dkwott25zHRfoHJMpJia8YwognjC2bpTD05rnd91Kz++1d/srWfDUtV6DhPhmiTpyXqExCpqxIyhVK8hUzM0iFTN+OHz++bDRKuMKXnQ0XDt5vpQdDcbrB/0aZGGN3f4cy7QfgjSJ1Pr+5yPZmDlRPSp05aBELx4EnMf+1dX8WtvTjcUXNupsTGt9fRNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 20:01:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 20:01:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "oleg@redhat.com" <oleg@redhat.com>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "broonie@kernel.org"
	<broonie@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER)
 in .regset_get() paths
Thread-Topic: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER)
 in .regset_get() paths
Thread-Index: AQHcE3q31HuRziJTPEK2T8WL/8xAvrRu3dGAgAAvBQCAAAthAA==
Date: Fri, 22 Aug 2025 20:01:57 +0000
Message-ID: <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
References: <20250822153603.GA27103@redhat.com>
	 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
	 <20250822192101.GA31721@redhat.com>
In-Reply-To: <20250822192101.GA31721@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV2PR11MB5997:EE_
x-ms-office365-filtering-correlation-id: 8bb0a062-6253-4214-eed0-08dde1b6bf9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWllOWlqSHVsWGFBa2ttd2FOWVZ0cWQ1b0FmUTVFT2V4UE5rYVdGdWxJOTE2?=
 =?utf-8?B?UjRWWDNMcWE2UmtRVWxXTnRNTnJMMnhYSHN1Mlp3b2s4UGg4Um9pb3VpZklm?=
 =?utf-8?B?YVNYVU1qWVpXTEliL3BXSHkrT1JiYzZGeXVWeFJ4K0tOWGYxSVcwYTd5a0JT?=
 =?utf-8?B?ZEkySEsxUjNuN2ZkYWdSSE5XSWdUSk9IV01zOEtoYk5MWGFZQW1kUXZWemhy?=
 =?utf-8?B?bENMY05Vc1ljMkpCWHR6V0hSR3VJd05iTWMrdlZib3FwcnZkbHQ3ZG12MXNK?=
 =?utf-8?B?dFhEem1wOEZzblhoV3NlUVVGQ3liQlNVS2VyTVFzajZYVDNJZUpGOUpEY0FS?=
 =?utf-8?B?dlJjeG51Tmo5TUV0YjhnZ2YrZSt6Z0pZL0EweGFZbHRESjIrd3ZiL0dmYkg3?=
 =?utf-8?B?RlRKUStFYkFla1I3WWMwUnJoVzFtOEQwaTB1YmE3TkVQLzJCZDVnUnNRenhT?=
 =?utf-8?B?eFlXblY2VUk3Vk4zUWZRc0xPcEo2WTRSWGlJanJyMXAzYXhiMVJDTWxDQzRj?=
 =?utf-8?B?Q1hHM0NQN2xWQTExVVZyUlNtUk9jL1ZjazdJSXdnM3AyNkN0WmpGcmdCbDJy?=
 =?utf-8?B?Z1crQWMwMWVsVVc0NVR5ZWd5ZVUxaHVGaGdUZnBVK2RsTDJrNC8yQ2hadFpW?=
 =?utf-8?B?SlZwc2Y1ZldKQkpRNXY1WXlJNmFWams3d3dUYUVnMllhbzZmTlBwblpQOE42?=
 =?utf-8?B?ZTBLdktrdHZoRDJKSHlaU29Yb1diRU5nakhLY1BRZnJjVC9BbzlmWCs5Wllz?=
 =?utf-8?B?bjBCcjVONHNPZk1CeWgxaUpmd1BJTWhmOUd4d2VIMnRjQ2xvdVJaY0ZOU0cv?=
 =?utf-8?B?KytvcFFlYmJHWXJ2eGZMUmc3dkVoMTNnL29KVXVqNWRzN21zREtGdlVEb2pl?=
 =?utf-8?B?OHdPekdsRllYRlBOZFlVV3RRSTBIT05KYUFqUWcwQ3Y1RlFnTGo3d0NFci8r?=
 =?utf-8?B?UHA3YjQ1Y25xdnh1clhHM01iTGxaKytoalo3WjZHSEM5Y1BQR0dKMzg3L3lQ?=
 =?utf-8?B?WEt5b0ZuRmo0a09xVmhsTldUUlhIZCtuMXhyUDZZei9QL1N5Rkp6aTV2ZVdE?=
 =?utf-8?B?TmxKLy9JYzdSc3lnUDJHRlljc3JBRmJpNTRNNVIzVHVDYkdTR3RUcFNyTFdL?=
 =?utf-8?B?RENLRHFkL3VWQnpqMzE1Q1BuUG5hWm9kajlNYmdqdGR6M2pwOFdXUjJvMndi?=
 =?utf-8?B?RjBtc2tydUhiOWFPY1ZVY0JzRFl0TDdKL2J0N1FlOFlaeDV4RXBrcnZLL1Ru?=
 =?utf-8?B?Znp0UmxTZEFhcWtrZW5PZEF4MlFsMjJQbks2WWg0NWVzR01hS04vazJEaGNK?=
 =?utf-8?B?Tks0b0IxOSs3MmV6WTkyNjJZVEJnZXkvSVR0M05sOWhES2hQSnM1OFcvQk1W?=
 =?utf-8?B?d1psSUdlb2tLOUExQU9JaGV3WGlpNGJkd05Zb043Vnlwd1UwcTBkQkdKVVd6?=
 =?utf-8?B?bW5EMHNpWHFsa0lhNkRGampURFhna3hUTld0T1k2N3EvUnZPTVFGTHZ3dkZn?=
 =?utf-8?B?L05NM1RTVHp0YkNiM0JzQ0ZDSHI1YVl6L1VWRVBPWU1WTnNHRVZLTkt3UWFF?=
 =?utf-8?B?TlpoQ3Z3TFNMTXlSZ3JmRm5rNmVkN1gzbUVDaEV0dmNZUVVmWldkMUFPalla?=
 =?utf-8?B?VFRaL3lneEtYbGFsemZrVThUT0lrRk9ZU1UwR2pOei9tVW1DTmxla1M3WnAz?=
 =?utf-8?B?dFp0QWpjZXdocGcycGs2Q2hQWnBCTVV5M01aMnE2Z3Z3WnJMajkrdFJQOS9p?=
 =?utf-8?B?MTQvOHdsTmpSY0FLeGxmZnlnaWdyVGtwQ0xBZllFZHdSazg1VUMxY3Q5bENT?=
 =?utf-8?B?Zkc1WWxSNDlHaldneHQwMEdvSWhMcVFCVmJVVDZtVXRuak1vSkxBVHVoZzU5?=
 =?utf-8?B?eDRyVDJlSGVSbTNWYkNzeUx6WUpnWlA0KzRhdGtzWStCVlAzRmlZR3hReklq?=
 =?utf-8?B?VDUrTFFoMHowZnI5UnpTa1FBa3hHRU5nSDY0b0x6RTdTMUlmNlRQR0JvZVZO?=
 =?utf-8?Q?NIPfp6AFt0IoikWUDbEJNT91rnPCbo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUtKckJjRXBSdGRVdHlSTzg2RktGa1N5ODgyNGdQMTcwVE9uaGxpNzI2eG1D?=
 =?utf-8?B?VGk1QVZoRVJ5SEpvUFdSVzBLbFpmb0JTYUtQMEJEc2hHamlONSt5aEt5a2tJ?=
 =?utf-8?B?Um1yVUwwcE05M0xxMjd6cFdHUHJtU1l5cFlpMWVvSlZOKyszRnN2c05qL1ZC?=
 =?utf-8?B?WktxOW5BQjc3T2lhMU9vZkpDYmRXSUVveWp1KzZJc0ZSYWU2OGxwcWh1UUpa?=
 =?utf-8?B?bkN3RHBHWnRYZnNFcHZZa3owN3k4TTRpRjB3OXZtZ0FXNjlmM3ZVYlB3cmpC?=
 =?utf-8?B?QmRKcFB3eTl0eU5RYjBRMzFIeUFMTDFGR1VKT1NTbjhyL21SRkh6Sml2Vi9M?=
 =?utf-8?B?KzZJUUsrak93V3I3am5ad0ZlWSt3WE1iZHlZRmdLbXBqeHZicmN2d0Vwdjk3?=
 =?utf-8?B?amVpRndWTnk1NmxMdDIxb1p2QVlVUjBUelBDY20wbm9FTWlGL3RCdW1heTBm?=
 =?utf-8?B?V1phdFBrbDFHdHVDNnFvM0hUaUNBSmpuZVBPVkZNYnd5aE5zVkI1SXBUUnE3?=
 =?utf-8?B?bW9Ta0pLaEUwZmZFaUVJRXhUMzVPaFh0dVJWVjQxTVVHRjFLRDNicWlUWTBJ?=
 =?utf-8?B?eGxNSytweGdyUFJLa2F5YzN1UStaekxTdnFGQWwxRzFWNlN3ckJUUVFBWmRJ?=
 =?utf-8?B?d1F3TnJCWFZZMEplWTNONWlLT2xoZnpHekEzTEIrVnIybmViRFFHdlNZQ1lC?=
 =?utf-8?B?c0MrRGtkNzFwcTRPcCs1TTBIVFZIOW9wNGVycXVFaGxQR3Y2L24xVElnck9p?=
 =?utf-8?B?Q2ltY1VnTjgzY3p0RVdESmh5Y0ZSdEk1dUFVM0p4aHVNMVhvd0YrNldHQm1Z?=
 =?utf-8?B?QXZDdFYrSEorSU82UUFCbEVxTE5nR1JGUGxNWlR1ZXExRG96S01qemdjMUZQ?=
 =?utf-8?B?ZGZzS0c4c3FSL0hFeFFaMjVLb0FCMWlTZi9LOW1OQXJ0dThzS0ZWQ1A1SlRz?=
 =?utf-8?B?VDJNdkxFVXkrMGhib201NkdOWGlQTkZXUHMyMEVvSS9OdHRzWHhvNE1qOG4r?=
 =?utf-8?B?bDZDczNzUy9pcDhIWkowcEp3WEZIWGRrbDlNalljcXJpRGgvZGJDT0Vsci8y?=
 =?utf-8?B?WlVPclV1WkpYSkttWXRmb2lUZXB4UytiWm55WlZzL0I3KzJOQStRUVRIZmZ6?=
 =?utf-8?B?T05yTjVCN2xDUzlPUUkrV0g3QXc4bUVZUGJPZERRY3g5RG95bktYa0haL0U3?=
 =?utf-8?B?ODBsNEhRejJEM0hDT0xiY0RqUzcrTFV2VUEzc0FoY0VFNm1ncy9EU1FFeDd0?=
 =?utf-8?B?OUZzcFF3MTRyd3pJYmVLT042OHlhd1NrUG84eU92akxnNjJMdzdSR09DYW4w?=
 =?utf-8?B?R3Z5RWR1R1ZBVzFJNjBPV2pla21EUzROUzNmcFpYS0NyV0liazdNbTg3WmtL?=
 =?utf-8?B?V25WaWZMREZUekV2cWJBOC9sbmVRU1hGZVhRL1RrSy94eStKcWJiajVqM0cv?=
 =?utf-8?B?UThyQXNHZk5hYWEzQWpCZjF6RXF0dXpmSHVFeHdhTkU2N0FSVVJQc3hFYUJH?=
 =?utf-8?B?TUd2TmVFME9PVnN2UGYwRC9iYW9mMFJSWGFQanpldk9xaGhNYjY5RTE5ZDUz?=
 =?utf-8?B?SzBFNVVmZjJoaFg5NlI2NUJIMHFzRlJqVmZYYW5IcnphMS9nNG9LVHl5dThX?=
 =?utf-8?B?VjJhRjRUNVJvTE1jVXArN3BTeUtsRUdDSUxoMmVCV2NsNFRuQmovTUQ3bUVu?=
 =?utf-8?B?dVJGbXVBWkszK3lDOXFuai96ZmdJMGRoaXdncUZaMCtiV3pTNlhNRlY1YVox?=
 =?utf-8?B?UXpwS2hZQlRua2JTRExPSWErQUtPZFNKT003ZjdBdUg4UnR0RGFyR0NnRGlL?=
 =?utf-8?B?M2hDckhTTUFJREoydUc0TG5LSTdTUmxLZzdKaDZuRFE0K3h5K21mdGZYLysr?=
 =?utf-8?B?OE9jaFZuT3h6d1JJc0NHUGFMeUdGNUNkbklDdE5VQmdrelBVUzI2dGpDODZl?=
 =?utf-8?B?TGRabG9wR0RZcUN1L2tadjdNbEo4aWllV1BuVm1ZS3hVdGsvclRBNGp2QVNa?=
 =?utf-8?B?dVZLNWtTT2pGT0RMcHJSWXRBbHl4VlA2dUtuMStaSk56TlBxZDFoQkhPR3Bh?=
 =?utf-8?B?YzcxeW5MTDNZRDhXWWdNT0NwZGZTaVJ1R3Q3UEVDcXRXS0Z0N05TbE5nN0pn?=
 =?utf-8?B?dUxTVWRZUExiRlN0em0zVG1HTTVHbjlPbk85bjEybjhBK0N3ZlFReDhMU0dn?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15BF71F79280E34ABEE988B6530B3669@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb0a062-6253-4214-eed0-08dde1b6bf9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 20:01:57.1441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV5ZdY7Ksxbpr8uUmhMtSdbKxEgQ4HRTV9Q0YGN+AgXzjHrT1NlURBfAuFAC7qntoD8bJwJ4WM1/l1EiqMImkN+cVKBz0CYzYgUqzjRx0uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA4LTIyIGF0IDIxOjIxICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiA+IFBLUlUgYWZmZWN0cyBrZXJuZWwgYWNjZXNzZXMgdG8gdXNlcnNwYWNlLiBpbyB0aHJlYWRz
IGFuZCB2aG9zdCBhY2Nlc3MNCj4gPiB1c2Vyc3BhY2UuIFNvIHdoeSBkb24ndCB3ZSB3YW50IFBL
UlUgc3RhdGUgdG8gYmUgaW5oZXJpdGVkIGZvciB1c2VyIHdvcmtlcnM/DQo+IA0KPiBTb3JyeSBJ
IGRvbid0IGZvbGxvdy4uLiBBZ2FpbiwgdGhpcyBpcyBub3QgbXkgYXJlYSwgSSBhbSBzdXJlIEkn
dmUgbWlzc2VkDQo+IHNvbWV0aGluZy4NCj4gQnV0IGNvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiBo
b3cgY2FuIHRoaXMgc2VyaWVzIGFmZmVjdCB0aGUgUEtSVSBsb2dpYz8NCj4gDQo+ID4gSSBndWVz
cyBpdCBpcyBub3QgdG9kYXkNCg0KSSdtIHNvcnJ5LCB0aGlzIGlzIGluY29ycmVjdC4gUEtSVSBp
cyBub3Qga2VwdCBpbiB0aGUgRlBVIHN0cnVjdHMgYW55bW9yZS4gU28gaXQNCnNob3VsZCBiZSBp
bmhlcml0ZWQgb3ZlciBjbG9uZSBJIGd1ZXNzLiBCdXQgZGVzcGl0ZSBub3QgYmVpbmcgaW4gdGhl
IGFjdHVhbCBGUFUNCmJ1ZmZlciwgZm9yIGNvbXBhdGliaWxpdHkgaXQncyBsZWZ0IGluIHRoZSB1
YWJpIHhzdGF0ZSBjb3B5IHN0dWZmIHRoYXQgdGhlDQpyZWdzZXRzIHVzZS4NCg0KPiA+ICwgYnV0
IHRvIG1lLCBjb25jZXB0dWFsbHkgd2UgbWF5YmUgZG9uJ3Qgd2FudCBhIHNwZWNpYWwgY2FzZSBm
b3IgdGhlbT8gU28NCj4gPiByYXRoZXIgdGhhbiBhZGQgbW9yZSBzcGVjaWFsIGhhbmRsaW5nLCBj
b3VsZCB3ZSBhY3R1YWxseSBqdXN0IHJlbW92ZSBzcGVjaWFsDQo+ID4gaGFuZGxpbmcgdG8gbWFr
ZSBpdCBjb25zaXN0ZW50Pw0KPiANCj4gQ291bGQgeW91IHNwZWxsIHBsZWFzZT8NCg0KUEtSVSBp
cyBmb3IgInByb3RlY3Rpb24ga2V5cyIuIFRoZXNlIGFyZSBtZW1vcnkgcGVybWlzc2lvbnMgdGhh
dCBjYW4gYmUgYXBwbGllZA0KcGVyLXRocmVhZC4gU28geW91IGNhbiBtYWtlIGEgdmlydHVhbCBh
ZGRyZXNzIHRvZ2dsZWFibGUgZm9yIHJlYWQgb3Igd3JpdGUNCndpdGhvdXQgYWZmZWN0aW5nIHRo
ZSBvdGhlciB0aHJlYWRzLiBUaGUga2VybmVsIGlzIHN1cHBvc2VkIHRvIGhhdmUgdGhlc2UNCnBl
cm1pc3Npb25zIGVuZm9yY2VkIGp1c3QgbGlrZSB0aGUgbm9ybWFsIG9uZXMgKHJlYWQtb25seSwg
ZXRjKS4gU28gaXQncyBhbg0KZXhhbXBsZSBvZiB1c2VyIEZQVSBzdGF0ZSB0aGF0IGFwcGxpZWQg
dG8gdGhlIGtlcm5lbC4gRXhjZXB0IHRoYXQsIGFzIGFib3ZlLCBpdA0KaGFkIHRvIGJlIG1vdmVk
IG91dCBvZiB0aGUgYWN0dWFsIEZQVSBzdGF0ZSBiZWNhdXNlIGl0IHdhcyBzcGVjaWFsIGluIHRo
YXQgd2F5Lg0KDQpCdXQgSSB0aGluayB5b3UgY291bGQgYXJndWUgdGhhdCBpdCBzaG91bGQgYmUg
cGFydCBvZiBwdHJhY2UgcmVnc2V0cy4gQSBkZWJ1Z2dlcg0KbWF5IHdhbnQgdG8gaW5zcGVjdCB3
aGF0IFBLUlUgZW5mb3JjZW1lbnQgd2FzIGhhcHBlbmluZyBmb3IgdGhlIGlvIHRocmVhZC4NCg0K
PiANCj4gPiBCdXQgYWdhaW4sIHdoYXQgZXhhY3RseSBpcyB0aGUgcHJvYmxlbSBoZXJlPyBJcyB0
aGVyZSBhIGNyYXNoIG9yIHNvbWV0aGluZw0KPiA+IGZvcg0KPiA+IHVzZXIgd29ya2Vycz8NCj4g
DQo+IFdlbGwuIEkgYWxyZWFkeSB0cmllZCB0byB0byBleHBsYWluIHRoaXMgaW4gdGhlIHByZXZp
b3VzIGRpc2N1c3Npb25zLg0KPiBBcHBlcmVudGx5IEkgd2Fzbid0IGNsZWFyLCBteSBmYXVsdC4g
U28gSSBndWVzcyB0aGlzIG5lZWRzIHlldCBhbm90aGVyIGVtYWlsDQo+IHdoaWNoIEknbGwgd3Jp
dGUgdG9tb3Jyb3csIGJlY2F1YXNlIEkgYW0gYWxyZWFkeSBzbGVlcGluZyB0b2RheS4NCg0KSSBi
ZWxpZXZlIHlvdSBzYWlkIHNvbWV0aGluZyBsaWtlICJzb3JyeSBteSBmYXVsdCBhbmQgSSdsbCBl
eHBsYWluIGluIGFub3RoZXINCm1haWwiWzBdLiBEaWQgSSBtaXNzIGl0Pw0KDQpbMF0NCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNTA4MTUxOTEzMDYuR0sxMTU0OUByZWRoYXQuY29t
Lw0K

