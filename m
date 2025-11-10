Return-Path: <linux-kernel+bounces-893822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A4C48711
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E073B7E13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F92E6CD5;
	Mon, 10 Nov 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvrIVtsu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC132D8393;
	Mon, 10 Nov 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797394; cv=fail; b=GBIEfoMZFd9ot50AZ3M6A9k3juorPZjsp1J8/W3LGvDkwEibNrPFvWnc83i8Opq0VDpPUX3tK3mGQ/JDzXFnw/COS3JuYMco9NrKGzbn5PzgxkZe5i9j+6xbT1OK32bVcospTJNt+ewrm/PwoeK8S9cvIWabvffWL/oTTxB6dCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797394; c=relaxed/simple;
	bh=bsb6FgEY2wp2mq25+wKB3uoQyCeZFYYGOQf63uoxhnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4Uni+9PVFGDaaV1jqaIwYeQaxpA6cqgAWqa94hPgoexMuPMc9wp1I6QBfPHP+Snu/JFqiIKWqzuwL2a6YZNIRVRDd26JepoxGlgn87gLc2Oruovl+RogLDjZX+iWtzSiwnrDffKQOTMMUqd5fplnC7pD2zSQ3UEv6qmN1RjRrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvrIVtsu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762797394; x=1794333394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bsb6FgEY2wp2mq25+wKB3uoQyCeZFYYGOQf63uoxhnw=;
  b=ZvrIVtsuudc1Z3kFFOwDELmyG/3ugxeCIcbisVpF4xy1adoWDDTVz3kf
   OOr6jDlTMymd1rMcJlDNatpkE9w/CTmPLTzHJaYF+hR1kWdMMXq8BOcOD
   PtKzUoRo23JlfoA8SzvJrd18CmYJFnC3p2YoCfKxhbjz9RmZASMDMYDHm
   kRlV+Rt5aBvtONmbTL3D/xZhs29757iJnkaMQdqWE4XEodPFVCV7+PUh9
   UmXPVgfsfwE1YbbyZlXAkc6tLQGsK+6Tb+AsEo2i8F5GZD/IDWo8c5pwQ
   nW7ue530fYOrw3EYpfde3vHYqaLJmhnrcC0Qju/BdebsMZFLk1WQjO5bP
   w==;
X-CSE-ConnectionGUID: VtoBhm/eTee3yeoNQXGhQw==
X-CSE-MsgGUID: DZiK7yPoTYGaPpPPNP5zSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64781489"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64781489"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:56:33 -0800
X-CSE-ConnectionGUID: 8BXa5mQaQ++kiyMOn+Y7qQ==
X-CSE-MsgGUID: Xcau19b3T168y6Dp0evBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="212120454"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:56:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 09:56:31 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 09:56:31 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 09:56:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdwCTtVYwFES0bJAt/QrPJh7R5RL1D4Jh2GyjiI2A4YMC4AhB7NcjkIrNeOdmj+2wid8jDqXXYqJ3n8I+siJJ3jkCAvqIg7hjZWTFL7BVbpKr0feMA69B70MsAAc2oSrK2543oGg/JWIK+iMHAEXR2Su1NWbd+eA/iA5EZwOazyW3iu7spIau50pc6P/TdHpVG4x3N/ZbUfAkT9CQsxPeDybpKJ+HZ/GF0blSsdzmRABEKke1sCcXv1BaOBiSTeq3Kk4zDk2uOM/bqyMQT+YVwJjnK6nzdzkB/VjBxDUa6+s2KX34+nhz7/+VwW7YIvbq3oe8MQrV2Ktv9+IxlzayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsb6FgEY2wp2mq25+wKB3uoQyCeZFYYGOQf63uoxhnw=;
 b=awZGI7Mi/MDtpZM4moyG82RqnkHmFigOjxhjeeb0o8Ysxo2k9K7wT+Cp07hY8Z05vHJc9r3FDUuL8IKRI8WpDtOK4KkvqwEhFxLcVoJ32D8a7yOqTy1sVqmldah1RNKBgxBCc682uvq3qVJ/S4/0b4LsjevvaTJdrNL2Ii0yV900U2ATkR9Q8TKI0eiuswx8IxbhvvL+mLAfUdxr+cdB1ZynndLTaWIpt0MzAXV5s+MtxDeBIU55PMXi6GYuBDKXk/vFELnszdlrR6x20ikciv6MZ/aTxTmjkYCC/q8BNSMmpY6bp+pjVkE4CcSfZtEqJF+qms1JEBaoff7y3VlNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:56:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:56:29 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>
CC: Christian Brauner <brauner@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	"ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, Steven Rostedt
	<rostedt@goodmis.org>, "Williams, Dan J" <dan.j.williams@intel.com>, Theodore
 Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>, "Jonathan Corbet"
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Shuah Khan
	<shuah@kernel.org>
Subject: RE: [PATCH] [v2] Documentation: Provide guidelines for tool-generated
 content
Thread-Topic: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Thread-Index: AQHcUhW8eCcx7eGkpEu2OqRw7hpCqLTrnE0AgACNcoCAAAVGAIAAAlNA
Date: Mon, 10 Nov 2025 17:56:29 +0000
Message-ID: <SJ1PR11MB6083291B22FFEC4F38999D31FCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
 <20251110-weiht-etablieren-39e7b63ef76d@brauner>
 <20251110172507.GA21641@pendragon.ideasonboard.com>
 <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
In-Reply-To: <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5179:EE_
x-ms-office365-filtering-correlation-id: e598e538-4501-4bfd-e425-08de20827a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WWF5MXZ4bEx6elhKUkx3VkRVRFJxbko0RHgxNkhWVkdDV3NMU0NBOGt0S01a?=
 =?utf-8?B?NHlZNkRZUEtjVFlpQkZaQmg5K0didU02RU5vZ1l4YzRIaEt2TW5oSmdSVmV3?=
 =?utf-8?B?SXg4MmpnL0N1WDRXZ09uUVh4by9laEEwYkFJU3VHRzRZbkdmbXd2UU52d003?=
 =?utf-8?B?VW41NlhJZzl0TndxckZSdWZtcTJhNUMreWFsVFN1Tm5IYkRvSG9EOGVVcjFV?=
 =?utf-8?B?NjV3dU9rcGlYT2RDR0l6bXVkUkdhUGFjKzY0TGhLblRaSzdvMFB6UU4yZ2hv?=
 =?utf-8?B?N2RsK3FkUDlIM2JiMHRTcjNPNVlrL28veUh5Wkd4SXM0cWpTaXlCaHFYMW9P?=
 =?utf-8?B?Und0b2NFYWJxWUlLNElyMllVSnR4N3B3WmVzd2RtVkJXV0Q5ZmpvZnYyWVhG?=
 =?utf-8?B?b3RlNWpuTGt4aytEK2VwbmoxNWpyek1JaXhneVR5VlRkTFFPOENodXRKSzhW?=
 =?utf-8?B?bk14NUFYVXJHTi9jTVNnR3hDTmpqZm1ZUVMvWlBVa2k5L0NDSzBWdEo5STNt?=
 =?utf-8?B?Q2pORVBuTk02QkxPVWJ2eXNTbzZCWkdZdE9VTXJmL1BqQTdMa0l2Tzk2Qmdl?=
 =?utf-8?B?SkxhbURxVmg3dzI2N2RaTGFIVXEwZU01M0JvYmErME43VjQrNDJCYy8rOG1r?=
 =?utf-8?B?UVVaN0xYZ2FtMXpIMUpJVFU5a3NXdWpQQldpT1NrekR2ZGhSUjZidmRIQUJk?=
 =?utf-8?B?Z0JERGU4WkYyUnR3eEFhbGlDVS80RlcvZXBsWG44Mjl6WWNvb2dvaEZpTGlN?=
 =?utf-8?B?QzAwMUd5WTdnNEFrOXdVVmozZG5NcnNMbGZGdVV3UGFFRnFvVjgzUkV2UU04?=
 =?utf-8?B?Z3pNV09UODFyOEY5UERNWTNYZDdxMzAzcG95MWdXZW5ob01kNXdyOU5kbnhR?=
 =?utf-8?B?VUNXcWM5VnNRbGcvdllyTXczNE92Q1luOEJpTW56NDJmRWc2K2wzMmlPc01N?=
 =?utf-8?B?M0dOZ3g3R0lsMGR5WnJxaFJsYUxHU3RtVjlkbGFPblZlQkc4UDVKMXNzTkFo?=
 =?utf-8?B?SjFvU3NCVVE2MTJwbXhhaFhKWVFnMTVwV2JhZlJPUnlObXRGTldmbFVpMWI2?=
 =?utf-8?B?WFN4clhMbzJxNStpT09SOVhSUGVEcTVTR0Y1bENhMFlCQkh0dTk0TDBjU0wy?=
 =?utf-8?B?OVVDbkYwa2xMbnJoeFIybVp2MTlIK1ZJZ0JHRVRnS2Z2VHRwaHUvZUFWZndq?=
 =?utf-8?B?V1Ezb2Nna2Q4TkVsbStmVXlSVm43Nm5xcDFqWHJhZ3o5aWplMmJKZThod0gv?=
 =?utf-8?B?anBNQ3dKb294eDFkRVo0MGhtMHRyNGNxS3FsNFc4R1NzNEE5UWFjb3pVdCt0?=
 =?utf-8?B?ZFpZMEUxSDQvdXluZmJzVHBSSXpwMUNKc2xCYjQ1c2V6QXdwaTU5amlLUWEz?=
 =?utf-8?B?b3RFb2QyWStiOGZzL1ZlRXl0b1Z1bWhmNCs0SjB6SHNRZVN4ZlcxVmo0elZP?=
 =?utf-8?B?WHcyTXoyZVJuNEJSY20wQzNzMUdJYWNnKzd6bkdydzlsTkJvdm1XRG04S2N1?=
 =?utf-8?B?NFpHSjlQNFFxN3dRZHVxeDlJZm5UZW1hZDYxUmVQekl2K1Z1L09Qd2FCWUFp?=
 =?utf-8?B?WVUvN3luL0JVKzNPZVhkNkRTZkh6SFhLenY2emVzcHNxeFFLTTIwTlpnQmVE?=
 =?utf-8?B?amoyZWhsNEtjNSt1Q095amtxczZXWGUwdmw4L0sxV1hqb0lFOWxRMW0wOE4y?=
 =?utf-8?B?WnNIcG94Zm5raUp3WHZiMjVCZWdWS1dHY1U1Zis3U3drblVWQWtDakx3VVQ0?=
 =?utf-8?B?VFluRFlEZWgwNXVTMkVaWGd5T3hWQ2pTNndwelJOd01NeWdNYTBYUmtWaWg3?=
 =?utf-8?B?L1U2UzZXTkhWTXk3NWRVZjVxbkliS2ZUVlhFUlk0akV0WXB6Rk9mWTNPajdk?=
 =?utf-8?B?Z0hsZFFtcUVEV2wyVHFTOGpQRFpEa0tDdDRZS3RFZE96c2xQeDhyNGpOZUwv?=
 =?utf-8?B?dWQ2dXMzaEw3VEZrL2RWdnNlUnpXZWh2Rk53Uy9xbUZTTFd1N0lpRysyOGI3?=
 =?utf-8?B?WmF2dTFMQ3R0VHFHZENKYWV2TmxLK3RWamxRWU8zc1kxSGxybHpWVE1uRElH?=
 =?utf-8?Q?Ozklbc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnlZM0tWandSc0lwc0Nzek50NmlzRXg2YXJDNUJhVXpLMGFmWDNsdHg3dWZW?=
 =?utf-8?B?a2wvZFM5c2k2enQ1anZOVW9vd09VYUUxQmVxQ0tWSVNiUXI1ZlQxUERKNDFa?=
 =?utf-8?B?ckJ4MlphMVJNTWI4S2FySTBiN29hZXh2QW1qc25saVMvZHArZVRLazM0dXNn?=
 =?utf-8?B?RzY5VloySjBXWEo4OTh6a21kSTY4OVNPcVQzSkZiTkd6MHgvNlM0Y3pXcTNy?=
 =?utf-8?B?YWdjYlpFMHNldFAxYldqaXZ6TjZRMm9ZS3Y4aFhiendWVVIzeDFqdEZSYXlF?=
 =?utf-8?B?Sm1FS0hzUEl2UTFQS1RSOGgvWmhaaDczekdkeGZ1dEtQbHVyTndoNi9WV1E3?=
 =?utf-8?B?bzRYMzhmSVBza1hiRlBicnZ1SlVwM3hYZ01ua3RwMGliSDRMWVBDN1crM3lP?=
 =?utf-8?B?SE52N25nREhyT2wwMERpYVNrcHFKMGRyaWw1MTlTcUF1UGFRMDJ4UDRlcXNq?=
 =?utf-8?B?ZnJ1ZHRScWE4WmtRczBVRkdrY21OOUtIaDF6c1VPcys0ZnNyL3dVWHVrcUJF?=
 =?utf-8?B?cDJiZktUQnpNb3NwT2ZETmZFaGtkb2xPY3RKUTZUa1c2d3I1UlhRck42MURZ?=
 =?utf-8?B?OE03aks1SCtpa3VGVzB2Tkhvajh2eUdJTkQrcm1VTW9IQjdYTmNpbXpjenhH?=
 =?utf-8?B?TU42OWZOV250bmN6bjFiZE1JdER4QjE2L2VUeUFBdDNQelZFWkVQYzBHWWpC?=
 =?utf-8?B?SUpLR3ZqR1FHWHdKcFdCdGVVZ1RFZ1ltdXJYaldTU3E3eHpFUGcrT0xWZXFs?=
 =?utf-8?B?VG1peWlLT3dSd3hxMnlrMDB4Y09pdnFvSXFMaDFTQnIwTVZmbVk0Z2FMN25Q?=
 =?utf-8?B?b00xUUt2R2dTajVyQnc0TUZIMUJEcEpXTWRXVW1VVTRuNkVaZHJDVSsvUGs5?=
 =?utf-8?B?bFBzbVNtUHl6VW5yNitxbmthZTZxbUNJa3FFYXRCWW95MnVqdlhqbnlDbURU?=
 =?utf-8?B?YkdJbjVjdUplVWUrVjYvYnVFYXB6V2JpcnR6OTZaeHRINTh3K0tXaUFJUW5B?=
 =?utf-8?B?SjhNZDhhRFNON0JqNVA2QWcyN1hEY3FEeVJCSFZRV1NpLzZkUDBHNGlNeExU?=
 =?utf-8?B?UmpYUTdnUHdBSVBxdUNSck8yd2FJYXVmcGpwanUrVkNwVzZLbVpmdWhzY0tB?=
 =?utf-8?B?SUFTSnpmdjFZeTBLaFV6OXpsV3U4LzY3ZWoyQnVucmlOR3hIa2phbEdneTA2?=
 =?utf-8?B?c2FmMHRJTUJGN0lXU01rMEM5em85Z0h1Ti9PYUtsSlk4MWlGdm44SW8rcWNN?=
 =?utf-8?B?UE1oZVVJa3dycEVLamxPY1l0RlVsT0crTDRpS2ZZbVhoS2xGbktWRWFWbEpW?=
 =?utf-8?B?cWFFVUNqQlh3UFY3ZUIvTUJMOTdBMzlrWEc1THRYbzRGcHFkNGlSNlNvWHFj?=
 =?utf-8?B?aVM4aEJRbFVMYUZZWFJYSWJWMlNGVWU3TXRzUk4zaUxGYnpmblN1M0hhdWk2?=
 =?utf-8?B?Z2lPRyt6OVh5SGVITTkvQ0RJMFZLK0M3UnBuNUVmbDBjN09EUXhXa1JjeDFW?=
 =?utf-8?B?STZJcmhTVWhWcG1iRHFNNkJGUENQRHFDeEFXcDRSdC9haXV4dDl6UHMyV2RQ?=
 =?utf-8?B?R250UGR6K0x4cXliZ1YwRTF2SitPWE5kQ3kwTFVEeVRwR2M4Zzl0enBCcklh?=
 =?utf-8?B?M0U4WkY4c0w0SUdmWTlCUlRZRWlkdE9mNW12dzNQSys2OGNrODRIMW9tZ2Js?=
 =?utf-8?B?eERVeldUdG8zc09PKzFjTC9DbVc5VjlPTWRGUnNvdXVBUjFrQURUTVowcU5q?=
 =?utf-8?B?b3pSWFBISS92TC9ORnFzKzRZb3NzYTVGbmY5MFVrelRqUlVzSnJ5cHQ0ZkNZ?=
 =?utf-8?B?UmNMc2tkWDl4SFg5NVBKRHBmS2UvZnY3UkdSMHd6T0tWMmIvbWxhODhoZE42?=
 =?utf-8?B?SnFydi9hN0piSGtFK2QvbnRMY29XZXQyOWQ5VHBDTHNwKzZGUVNMSExYbE9y?=
 =?utf-8?B?T2pYaU5QK2F2YzJXaFdva1R0SVR0cnFBRnByekFRaWh0ZUYxNElXRkxNQWxY?=
 =?utf-8?B?ZWlWeEtXNStRUFcvK0RHQjdyTzBGTVNOUmg5OXdJTmoxNWtWamp4ZHNLZDlr?=
 =?utf-8?B?bzRVNGgxcHVobjA4emJQeVpBK3RmamQzcEtOd3dCWGJJSXFKWkRxRUtpY3hu?=
 =?utf-8?Q?/Bcz+54tDwgIyEF+kG2YYB+Oj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e598e538-4501-4bfd-e425-08de20827a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 17:56:29.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKerUCfjlD5+9IJh2CljYDlbx10Iqa+Xn+c+4JNmW18xhTQXoqI1PjUCd8hg5rk7JjDESsKodVFG0bIspj8bjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com

PiBJIHRoaW5rIHdlIHNob3VsZCB0cmVhdCBhbnkgQUkgZ2VuZXJhdGVkIHBhdGNoZXMgc2ltaWxh
cmx5OiBwZW9wbGUNCj4gc2hvdWxkIG1lbnRpb24gdGhlIHRvb2wgaXQgd2FzIGRvbmUgd2l0aCwg
YW5kIHRoZSBzY3JpcHQgKG9rLCB0aGUNCj4gInNjcmlwdHMiIGFyZSBjYWxsZWQgInByb21wdHMi
LCBiZWNhdXNlIEFJIGlzIHNvICJzcGVjaWFsIikgdXNlZC4NCg0KQUkgaXMgYWxzbyBzcGVjaWFs
IGluIHRoYXQgaXQgaXMgZWZmZWN0aXZlbHkgbm9uLWRldGVybWluaXN0aWMuIFlvdSBwcm9iYWJs
eSB3b24ndCBnZXQNCnRoZSBzYW1lIG91dHB1dCBmcm9tIHRoZSBzYW1lIHByb21wdC4NCg0KTWF5
YmUgc3RpbGwgaGVscGZ1bCB0byBpbmNsdWRlIHRoZSBwcm9tcHQsIGJ1dCBpdCBoYXMgbGVzcyB1
dGlsaXR5IHRoYXQgYQ0Kc2VkIG9yIGNvY2NpbmVsbGUgc2NyaXB0Lg0KDQotVG9ueQ0K

