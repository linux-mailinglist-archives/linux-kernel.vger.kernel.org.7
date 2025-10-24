Return-Path: <linux-kernel+bounces-868152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E041CC047CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA433B3AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1426CE04;
	Fri, 24 Oct 2025 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTxOJGkH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC926656F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286928; cv=fail; b=CQOQjeA1+N+RZ7T5Cv28SJbIhT8XRy5IsD0HHrLidly3H67M+MQ/UHBmFv3aMFAjyC0BZUNqqIuB5qeYq1jnaLcYp4SuPyMwr5VhiV0W1g203zgvsn9ohbO9Ljk3KaQTt1SYhk+Ltobi9XiFEstzU77smqX0Pi1kOtFVkn2lzXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286928; c=relaxed/simple;
	bh=GNfjAtR/L0wvQDcIGTNtQefwRd1Fw99/HT91ODnv4Xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWcSrYHY2zdb6MCF6daAdb26ee3AJLP82BN9sYvWBtVG2BtFT0YBeTsYw3uRsrzRF3iloea6rFgSAoLjLWalbgBPpXGT8JE5N82ulW5qdibZCzSnvEzSZXvMqc67ABTrzzMk95/VINctYQmKERFqPNtaVw1EiSs0rUUEf5sbnYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTxOJGkH; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761286927; x=1792822927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GNfjAtR/L0wvQDcIGTNtQefwRd1Fw99/HT91ODnv4Xg=;
  b=MTxOJGkHNt1QUyUpDg1farR3jA3L75c9bcLdgyVxcoxgKICw5trshXTH
   Q5Tcc2RrBZ0cuCy9eMF1nOGqsxctNTwC7Sjr6sgOrrLJedCnEyFiPG1IH
   hbyiUJrfu38pj4E1DUGJ8FqAuesobivw7TD2uDORei1nPpJoJXXAhenNy
   sIoVGOneh5no5B973gLRZTCLsbaPt1duUZL/khpmO18i516BS5nKpg2VI
   Do0zUjwkQszLaYjIylpydYnAhVAGEo3ISXGBvw8rGR4F/9lEaV4LrDTSt
   WfmIcgOign5MtUCwr5kGeovqHaklxf6Trof+Iff+1M41jdwarulzYu79/
   A==;
X-CSE-ConnectionGUID: TheNeUQaSGyfLBCPgUJETg==
X-CSE-MsgGUID: N58fbkXxRTm916cW9QZJCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81092302"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="81092302"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:22:04 -0700
X-CSE-ConnectionGUID: u8gGthHLSKyxnQ8DFrAVdA==
X-CSE-MsgGUID: ncYOuf8ORX23FVyh7OXYMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="184273975"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:22:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:22:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 23:22:04 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry+Ep99sI01uCNHQ7sbl5fhtzdKY6dfatMLmqO4s69J5dmKpThri7EP2HdWLhWqh53RrQQpqex/wSu/tYug4Y7WQoorBh5axVHV8/VmtLkmc8AcPjL8eMf+2dfBhpbWI/SIId07+YCRJ1LJJBDMuaPiXomBPpHZ/lyprXXQg0caBocMre9dMZIEXdsNOZ02Z2yhqBeFSvZOUVomOorCfiCd+sASjvr3xUoTcNqyIpdOgBvJ0lXuNDzn90YSPWjAlvSDSgy+HPKdNQTUUkRIAt/v1J5GPOyOSbh4iifHiqNkP3scfLin5FD+NhxdBfmyvQt1mwmO03IMigKYkuexivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNfjAtR/L0wvQDcIGTNtQefwRd1Fw99/HT91ODnv4Xg=;
 b=qEl2w1XOVmZPBZKcrLi+thz3JOuYKs5zyYIAOlt7m6AApWdYq5gLHP/nmDByt/QeaN+LREByY5q6BrgmUDLN58eIW3uLJ4YGlXFe8u811jeI0YtgyM5dk1OWpVNjsz3ABkZnPRF2qVKpcE8QBwpDdWRaQ8I6b9LvY8T2GjU8j8F2AD4XMTfO5GgrSXnKPHnasejaGLVdizg+val9qcGDyccPbqZVe295ks7nMPahHRcKF4UMU7Ppq21HFV59BAe6T/I8X3KA1l2Mw2cYFgIFKpe0Hf0qDY9Tx0VsuaXrJ3a8MnO/nxYxEcNn2yWIxfVS4M8Ryvo3m2+MWBVTw6OoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:22:02 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:22:01 +0000
From: "Li, Fei1" <fei1.li@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "acrn-dev@lists.projectacrn.org" <acrn-dev@lists.projectacrn.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Thread-Topic: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Thread-Index: AQHcRKChkqxb1RMa2UOKI3cGmiOHe7TQyh6QgAAFKwCAAACWUA==
Date: Fri, 24 Oct 2025 06:22:01 +0000
Message-ID: <SJ1PR11MB61536DC1E7A32387FCA400E5BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
References: <20251024044226.480531-1-rdunlap@infradead.org>
 <SJ1PR11MB615389E066F50BBB68686A26BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <213c918b-b4aa-4174-af89-a4d17e8c30dc@infradead.org>
In-Reply-To: <213c918b-b4aa-4174-af89-a4d17e8c30dc@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6153:EE_|BL1PR11MB6027:EE_
x-ms-office365-filtering-correlation-id: 180e50e1-377e-470b-7bca-08de12c5a502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TWFYV2NDWGRETTV5THF1RVB3TjlXU2I5dnFiUzFxa2JlRzlvQnNaWkxydlhr?=
 =?utf-8?B?NENPSUdOelBOc3J1Tm5HbVdLZTN6SWVxY05zN2o4L3F3THg3eVg1YzIyZk1z?=
 =?utf-8?B?RG1GTDk3TzcvT0pTWDQ0UXBpY2wzQnlJdVdkaXJvNmVNRWs2L3YwKzBxMSs3?=
 =?utf-8?B?M21hbGVaU2xWWHRZT2VpdExMbkhkWE9MeDZNTFliejNtN1FaM2NDcmlVQWla?=
 =?utf-8?B?RnlmSTBqYndRK2EramNHZzlrWXY1cUtMS3lERkhQWXZFRmhSei85UjE3UW9G?=
 =?utf-8?B?WFUrMkN3RXIvek1BUENEcVQ3Q1hZWDZJUXR1SEg4Ny9NNjRFemxLcFF6QWVW?=
 =?utf-8?B?VzNOUzBCMCtUUmxwNXpuQlU4VzhCaUtpVHVNME0vV2ZzaDlHSXJwYjF5S0w3?=
 =?utf-8?B?bGFpakJyaXpkbVZZejM1citzaFg3K2JFNy90WEVTQzdRWE9QYVQ0aWNxMnVO?=
 =?utf-8?B?SGRMNWJHd0VCZ1lQWHRXNkZ4UDBhQSs0QnN6ZlNWMDg3Yi9ncjJidUV1dDZE?=
 =?utf-8?B?M0l0eUFJK0tJb0tpL3BHRmdwNUozTms0QXFtd2xzYy9mOUVRdHFQL25xY2h0?=
 =?utf-8?B?UlRMZzQwUGVHelh1NUZVU0NwNHQyZ3FldUhsSEQxQ081QjR1d1NkV3NkTHRM?=
 =?utf-8?B?NURycmMrRTViWHNJb3VuU3NvU2V0dkFESHJaLzBXUjcvNGZQZk9kRjMxcFB4?=
 =?utf-8?B?b0llWngySzF2eGlLUFc5SmUySXR2cnpSOFIzWC9FWm9ucmlKV1ZqYWROa1dI?=
 =?utf-8?B?aTdRNDRmTWtHV0R2OG5kcDcyUHJsTDVad3RDdjY0UmRQY1FSNE1ZS0NEaUww?=
 =?utf-8?B?dEdVTkFzTWVsTFdFNVVCU0RVeHI3bldjNGpVT2lEV0pkMG5ua2NGTDN6SnIv?=
 =?utf-8?B?T3ZsbklST0oxeFExaDR1NE5EczJ2TmkrZnp1ZU00K1M4L2J6VWdHR0sxYVVm?=
 =?utf-8?B?TFg4UnhrSWVQZzNZVk51N3hTaDJkbGxDTmQxQWtEcGoySy9LSGdnVUxPSmFE?=
 =?utf-8?B?RmRXbUg2VUJOWFd1eVpxYmJGQVZPa3NwQmtIUmd1d1FSV2FjeTFEaEt6WUVl?=
 =?utf-8?B?QjVvc1lPYWRCR3luZk13QTEvRXF4OTQvNmpZVml6NUsrNzEyV21Va3hmam4v?=
 =?utf-8?B?K2UvVlhhWHpSVTUvVmMxaksyMlJ0NkpTalRrbjNuVm9VZ1JrYWN6Zk5oNzQ3?=
 =?utf-8?B?WlR1YjR3MGJHaGNIcThNa3hIV2pIZkwwTjNxMFpOLzRYTWlZV2pTL3podUVl?=
 =?utf-8?B?K1dHNndVWkR4VDFtNTMrcDJmV1dqZ1FxcFpNelVxU3FlSG16NStvMlJEdHBR?=
 =?utf-8?B?b3gxZUpNYUVYbDJ5WmNCSjBycnZMK241TFBsem5mMXJmN0NtMUVrZmtZYTky?=
 =?utf-8?B?Z093TXVNakRCbmFKUHdVdWVmR09zRGdRZWlyZjM2dHd3elpva09zUFBxRzF4?=
 =?utf-8?B?L0FyZjFvblR3RUJXMzMxWHM4dXpzc0lRRDVyb3lreGZWZU5zOVdrUndVblll?=
 =?utf-8?B?bTJpMllRcjVIRkxOZW5uVVVnNnRUbTQxYU9FM0oxRTNNeXdheVQwNUREREhp?=
 =?utf-8?B?NHFXejZaOHZxTEF1c2Q0NnRDYjY1SkkvSU5lUExkdmhzVlhkM2NVRzZscTBN?=
 =?utf-8?B?SjBibFNIajgvTUxqTXhiQUk1bEZSaTZwU1VHTG0yQmdBeStoczE5Um5YaEkw?=
 =?utf-8?B?bUJUbjJiSkx2Nmc1MnQrdFZ4NEpqKzd2VnRMN05UbUZXdVVMZVhkU0U0RHNq?=
 =?utf-8?B?VWgzUWZZRTQzMHp0NC9zOHRVNVZIaG5CUU1WRVJVMXpXTGcwYnNHaEF5cWRR?=
 =?utf-8?B?bnRWU1IwM3ZHQU40R3QvMTNENm9WMmoyVUhML3FsUUtBVngreE5yaXpGUE9H?=
 =?utf-8?B?WHNHVUo3YktDNHlnRzdxUmc1WGVuNEhXRXpuWmlKZVJKSGxZRGhya0xiaTds?=
 =?utf-8?B?QzVWQWViOThZdlpBc3FRZDdKb1RCN3QzZGlkS1ZrNmJuUzk1S21wVm1qUVBt?=
 =?utf-8?B?OHZwVGxjOW5RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFJtYmYrUi9pR1VCbVJoaXdycmhGUXVlZzhBazREamRRWGJrZUdXT0FOQ0dw?=
 =?utf-8?B?ZjE4Ulo4YXdsRSsrVTlPR0NWc1NNNkVOS0t3TWpud0x6dms5NU5rR0VVeGlS?=
 =?utf-8?B?cGZpMzQ3Q1RWOUszY0xLYW1WY2ZuTHpmdHEzV0Q5ejBqT2xJTkEySnFPaHJT?=
 =?utf-8?B?RXoxOEpJZVlJcWowQ2t1RHg5S3p3Ymx5Njh3TGFrR3F6VXF2S3ZBa3R1emov?=
 =?utf-8?B?SmZjTDRENVkxeDI2eEI0cVlDeCtXNE1odHBQSmxDNGFMd0g1K21QRVhKand3?=
 =?utf-8?B?S09KWmNrUnVFMGcrVjFkbFlTQTg1QldTSjRiVlV6OGRZcE5wWVJMZXVTZnFU?=
 =?utf-8?B?RkRPdXBGMHZxOXc2UW5yZWZnZEJaR1BMcEV6WTlqa096RDhZTkhkS3BQc2pL?=
 =?utf-8?B?MHBCbUhDZFRGZ0ZQYktiN0lwU29RWGFuNFk1YUVaMUsrL0dWczJ3eThldmNW?=
 =?utf-8?B?TmdOSlNjUk5OTjBidDk2b1dYdWVsZUEwOXJrMmt3blM3Ym9jVjNUYnhxL3RE?=
 =?utf-8?B?VFFUd2RMSXgrdkE0U2d6TGtTUTZBWXZzenFHbWxGcnQwU01DZGZ6ZklMdmdO?=
 =?utf-8?B?NlNTc1BjNjRqUTM4RjVKVU5QellvOGdZemlvd25oYzVIZkthSUo3Mk85MTVB?=
 =?utf-8?B?RE1NbWI4Lzl1Z3JTY3hGYWxFM2xCUHhUb2lGakl5QUZQOTdSOTlqbTBFU3RW?=
 =?utf-8?B?VUpkb2FNSXgvVkx2VDBzOWtPMjNicnNadW03NnN4NmxWWGlyOXIxbEduRWZP?=
 =?utf-8?B?dlcrNnJ4ZEUxSVJoandxeG5hZndQOS96N3J6bkNGeGxrRU9McVYzckgwdndp?=
 =?utf-8?B?UHRCNGgrNmZpWEoxZFBvSnF1RlZ4RlVyVnkwYTh1Tlk1V1E1QVpmV3F3YXFz?=
 =?utf-8?B?K2NkSVNZVlc3TW1INWdnUjBaVVF5cUUya0kvRUxvTnZEOWVvbnNqSkxkNnQx?=
 =?utf-8?B?QUZ0MVdvL1ZjcHgxSmxyQ2lRdVlKRWRvaXlhd3BrRlEwbkZ3UkZkSUtoVDlH?=
 =?utf-8?B?WXhWRTI3ekpVK1lDM0tsSVR0SVFSRWM3VTVKMVpGb2Y1Vlg5VnNiWGtKa0Iv?=
 =?utf-8?B?UDFzK2JjZGJEcnorKytsbU4veEJCYWIra0ZJTFRyN2Q1RnJ3WmpDeHhJeGs2?=
 =?utf-8?B?NmxQV0tpaFlsRXUzS0RiUDJ2YTZhQy8rdHZqWW5kZ3N1dTZ2T3dnNFY4SUVo?=
 =?utf-8?B?Wkc1Q0xJTG1PTnVPcE1MdUZ5dlM3V25wV3J4c281RGhyMDZVUTJSMnhGbjBp?=
 =?utf-8?B?UEg1TWVtRDY3K0tTVlE2NEhEdGNDc3F4MzJ4eWNqUDAwN3kvc2F0OWRmejcy?=
 =?utf-8?B?K08vQ0tBWW5zbmNjbURZbTc1TkR4UWhVNEtzM3BTQlAweVBYbTVUZlFEUWN5?=
 =?utf-8?B?UHNQNTBFM1NTUFR6ZDJoeU1QRU82d2Q5WEk2Qk50NDFLVVJhL053aEYvV1NV?=
 =?utf-8?B?R0RwV041b1Y3R1VuZGRkRyttejlqaTJrMGEyQWhaRHhpQU9IdlhTMHlWSk05?=
 =?utf-8?B?Ny96TTV3cUY2WHVyRUVDSlc3UVdjQjNoWTVhc1JUQzVUOW5YTU5icW5wRjRj?=
 =?utf-8?B?MjVkUktGVTB5c2s1RDNoV0dFQ0lBQk5YRlBtVHRLcTFsNlBDaXVRSW00YjJa?=
 =?utf-8?B?R1R0VVAzczlMOGxkMEJyL2V1M2tvOHdrTWljUjMraXlMZW5nM09XTlROQ21y?=
 =?utf-8?B?NmlZOU1ha21VdS9IM3pkRnlPazdvajQrYm55TW93WUVSYTh1aDkrUkttRjNI?=
 =?utf-8?B?YVpuZlI2RFdxNWptVmx5VjlHN0hsUUdxeDgydHBtVENnNDVCL2pQNDRSTUhE?=
 =?utf-8?B?a0RySXpWUDhQQVU2VUNlVGZ1WGljWGZET0FpTzZZd24zdnhQNnJIQzNNbTFu?=
 =?utf-8?B?eFRTUlp4YVlReUwxb3JodHZwL1FDQnNwc1BTamxMR2pHZE41Z0orbkd6NmhQ?=
 =?utf-8?B?bHNFRzhyWkcxbE5JMVNFMVBIQnErM3dyUFhaTVF5clVqcWZXSEpXVW5KWk1s?=
 =?utf-8?B?TFlWODY2MzhheWdzeHhqd1VTamlyWSttYkRXREtDWTdSK1VjR2hKM1BVeW01?=
 =?utf-8?B?VWNUQkNRL1pJQVQzRDlka1RYOE5XQi9mY2NQWktGUTZpWjUzQWRSQ0JXYlcz?=
 =?utf-8?Q?BwAk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180e50e1-377e-470b-7bca-08de12c5a502
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 06:22:01.9403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXFnnr5OUmNCpxR1C33t1a50ktSSBu6QijgjdeH+PXy7RWC3YsxhThxgN/OCcCuFjiPzix61rCBarIo0oHDo/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com

PiANCj4gSGksDQo+IA0KPiBPbiAxMC8yMy8yNSAxMTowMCBQTSwgTGksIEZlaTEgd3JvdGU6DQo+
ID4+IEZyb206IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+PiBTZW50
OiBGcmlkYXksIE9jdG9iZXIgMjQsIDIwMjUgMTI6NDIgUE0NCj4gPj4gVG86IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRl
YWQub3JnPjsgTGksIEZlaTENCj4gPj4gPGZlaTEubGlAaW50ZWwuY29tPjsgYWNybi1kZXZAbGlz
dHMucHJvamVjdGFjcm4ub3JnOyBHcmVnDQo+ID4+IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0hdIHZpcnQ6IGFjcm46IGZpeCBr
ZXJuZWwtZG9jIGluIDx1YXBpL2xpbnV4L2Fjcm4uaD4NCj4gPj4NCj4gPj4gRml4IHRoZSBrZXJu
ZWwtZG9jIGNvbW1lbnRzIGZvciBzdHJ1Y3QgYWNybl9tbWlvZGV2IHNvIHRoYXQgYWxsDQo+ID4+
IHN0cnVjdCBtZW1iZXJzIGFyZSByZW5kZXJlZCBjb3JyZWN0bHkuDQo+ID4+IENvcnJlY3QgaW9f
YmFzZSB0byBpb19hZGRyIGluIHN0cnVjdCBhY3JuX3ZkZXYuDQo+ID4+DQo+ID4+IGFjcm4uaDo0
NDE6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdyZXMnDQo+
ID4+ICBub3QgZGVzY3JpYmVkIGluICdhY3JuX21taW9kZXYnDQo+ID4+IGFjcm4uaDo0Nzk6IHdh
cm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdpb19hZGRyJw0KPiA+
PiAgbm90IGRlc2NyaWJlZCBpbiAnYWNybl92ZGV2Jw0KPiA+PiBhY3JuLmg6NDc5OiB3YXJuaW5n
OiBFeGNlc3Mgc3RydWN0IG1lbWJlciAnaW9fYmFzZScgZGVzY3JpcHRpb24gIGluDQo+ID4+ICdh
Y3JuX3ZkZXYnDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxh
cEBpbmZyYWRlYWQub3JnPg0KPiA+PiAtLS0NCj4gPj4gQ2M6IEZlaSBMaSA8ZmVpMS5saUBpbnRl
bC5jb20+DQo+ID4+IENjOiBhY3JuLWRldkBsaXN0cy5wcm9qZWN0YWNybi5vcmcNCj4gPj4gQ2M6
IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4+IC0t
LQ0KPiA+PiAgaW5jbHVkZS91YXBpL2xpbnV4L2Fjcm4uaCB8ICAgMTEgKysrKysrLS0tLS0NCj4g
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4+
DQo+ID4+IC0tLSBsaW51eC1uZXh0LTIwMjUxMDIyLm9yaWcvaW5jbHVkZS91YXBpL2xpbnV4L2Fj
cm4uaA0KPiA+PiArKysgbGludXgtbmV4dC0yMDI1MTAyMi9pbmNsdWRlL3VhcGkvbGludXgvYWNy
bi5oDQo+ID4+IEBAIC00MjAsMTIgKzQyMCwxMyBAQCBzdHJ1Y3QgYWNybl9wY2lkZXYgew0KPiA+
PiAgLyoqDQo+ID4+ICAgKiBzdHJ1Y3QgYWNybl9tbWlvZGV2IC0gSW5mbyBmb3IgYXNzaWduaW5n
IG9yIGRlLWFzc2lnbmluZyBhIE1NSU8gZGV2aWNlDQo+ID4+ICAgKiBAbmFtZToJCQlOYW1lIG9m
IHRoZSBNTUlPIGRldmljZS4NCj4gPj4gLSAqIEByZXNbXS51c2VyX3ZtX3BhOgkJUGh5c2ljYWwg
YWRkcmVzcyBvZiBVc2VyIFZNIG9mIHRoZQ0KPiBNTUlPDQo+ID4+IHJlZ2lvbg0KPiA+PiArICog
QHJlczoJCQlNTUlPIHJlc291cmNlIGRlc2NyaXB0b3IgaW5mby4NCj4gPg0KPiA+IEhpIFJhbmR5
DQo+ID4NCj4gPiBUaGFua3MgZm9yIGNvb2tpbmcgdGhpcyBwYXRjaCB0byBoZWxwIGZpeCB0aGVz
ZSB3YXJuaW5nLg0KPiA+IENvdWxkIHlvdSBqdXN0IGFkZCB0aGUgY29tbWVudCBmb3IgYHJlc2Ag
YW5kIGtlZXAgdGhlIG90aGVyIGNvbW1lbnRzIGZvcg0KPiB0aGUgZmllbGRzIG9mIGAgc3RydWN0
IGFjcm5fbW1pb2RldiBgID8NCj4gPg0KPiANCj4gRG8geW91IG1lYW4gbGVhdmUgdGhlIFtdIHNx
dWFyZSBicmFja2V0cyBpbiB0aGUgZmllbGQgbmFtZT8NCnllcw0KPiBJZiB0aGF0J3Mgd2hhdCB5
b3UgbWVhbiwgdGhhdCdzIG5vdCB2YWxpZCBrZXJuZWwtZG9jIG5vdGF0aW9uLg0KV291bGQgeW91
IHBsZWFzZSBwb3N0IHRoZSBxdW90ZSBob3cga2VybmVsLWRvYyBwcmVmZXIgdG8gYWRkIHRoaXMg
Y29tbWVudHMgPyBJIGRpZG4ndCBzZWUNCmFuIGV4YW1wbGUgaW4gdGhlIGtlcm5lbC1kb2MucnN0
DQoNClRoYW5rcy4NCg0KPiANCj4gPg0KPiA+PiArICogQHJlcy51c2VyX3ZtX3BhOgkJUGh5c2lj
YWwgYWRkcmVzcyBvZiBVc2VyIFZNIG9mIHRoZQ0KPiBNTUlPDQo+ID4+IHJlZ2lvbg0KPiA+PiAg
ICoJCQkJZm9yIHRoZSBNTUlPIGRldmljZS4NCj4gPj4gLSAqIEByZXNbXS5zZXJ2aWNlX3ZtX3Bh
OglQaHlzaWNhbCBhZGRyZXNzIG9mIFNlcnZpY2UgVk0gb2YgdGhlIE1NSU8NCj4gPj4gKyAqIEBy
ZXMuc2VydmljZV92bV9wYToJCVBoeXNpY2FsIGFkZHJlc3Mgb2YgU2VydmljZSBWTSBvZiB0aGUN
Cj4gPj4gTU1JTw0KPiA+PiAgICoJCQkJcmVnaW9uIGZvciB0aGUgTU1JTyBkZXZpY2UuDQo+ID4+
IC0gKiBAcmVzW10uc2l6ZToJCQlTaXplIG9mIHRoZSBNTUlPIHJlZ2lvbiBmb3IgdGhlDQo+IE1N
SU8NCj4gPj4gZGV2aWNlLg0KPiA+PiAtICogQHJlc1tdLm1lbV90eXBlOgkJTWVtb3J5IHR5cGUg
b2YgdGhlIE1NSU8gcmVnaW9uIGZvcg0KPiB0aGUNCj4gPj4gTU1JTw0KPiA+PiArICogQHJlcy5z
aXplOgkJCVNpemUgb2YgdGhlIE1NSU8gcmVnaW9uIGZvciB0aGUNCj4gTU1JTw0KPiA+PiBkZXZp
Y2UuDQo+ID4+ICsgKiBAcmVzLm1lbV90eXBlOgkJTWVtb3J5IHR5cGUgb2YgdGhlIE1NSU8gcmVn
aW9uIGZvcg0KPiB0aGUNCj4gPj4gTU1JTw0KPiA+PiAgICoJCQkJZGV2aWNlLg0KPiA+PiAgICoN
Cj4gPj4gICAqIFRoaXMgc3RydWN0dXJlIHdpbGwgYmUgcGFzc2VkIHRvIGh5cGVydmlzb3IgZGly
ZWN0bHkuDQo+ID4+IEBAIC00NDksNyArNDUwLDcgQEAgc3RydWN0IGFjcm5fbW1pb2RldiB7DQo+
ID4+ICAgKiBAaWQuZmllbGRzLmxlZ2FjeV9pZDoJSUQgb2YgdGhlIHZpcnR1YWwgZGV2aWNlIGlm
IG5vdCBhIFBDSSBkZXZpY2UNCj4gPj4gICAqIEBzbG90OgkJCVZpcnR1YWwgQnVzL0RldmljZS9G
dW5jdGlvbiBvZiB0aGUgdmlydHVhbA0KPiA+PiAgICoJCQkJZGV2aWNlDQo+ID4+IC0gKiBAaW9f
YmFzZToJCQlJTyByZXNvdXJjZSBiYXNlIGFkZHJlc3Mgb2YgdGhlDQo+IHZpcnR1YWwgZGV2aWNl
DQo+ID4+ICsgKiBAaW9fYWRkcjoJCQlJTyByZXNvdXJjZSBiYXNlIGFkZHJlc3Mgb2YgdGhlDQo+
IHZpcnR1YWwgZGV2aWNlDQo+ID4+ICAgKiBAaW9fc2l6ZToJCQlJTyByZXNvdXJjZSBzaXplIG9m
IHRoZSB2aXJ0dWFsIGRldmljZQ0KPiA+PiAgICogQGFyZ3M6CQkJQXJndW1lbnRzIGZvciB0aGUg
dmlydHVhbCBkZXZpY2UgY3JlYXRpb24NCj4gPj4gICAqDQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg0K

