Return-Path: <linux-kernel+bounces-870847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A63BC0BD50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 215034E28DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF272D47E2;
	Mon, 27 Oct 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsbrN73W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009D198A11
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543495; cv=fail; b=XQD08o5IEfUdbMfjBeUwEzQV6v6VeesNMCHXeISrI0wHU7zvO97CdvCsVFauz0EYcVbDB1UsBp7E7erUniPHhuiKAnC67eUMP1seEDjvSBC9QjV9nqtl6xFy+Fekc0OYRGC3PcYU/mNNjw0Sw4MZmyGs7IMC7/28MOX5rWGkFYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543495; c=relaxed/simple;
	bh=jQtgswtxbpaxZKF1sBej1LAUhCRl7ukGS3Kp9uKemCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CX22ZvKUOsqk0Fn5iKGq84QDI7BgQDQq87Im6qJUbKiJlWNNhuHPgkb4X8ADao/cPwLeM9maPKhqQcqD+kRGhhSAbeMyaUSvXjxN5XkreZhoue1Gr4HshGPSbL+fZGyJ8fa1DR9/H/8sCRgAMFVScSslkPRZDeOdgh84d6TLz0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsbrN73W; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761543493; x=1793079493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jQtgswtxbpaxZKF1sBej1LAUhCRl7ukGS3Kp9uKemCE=;
  b=WsbrN73WJDmh56rdK2ELnvzBH/INiAh4WNd7+nUjoh9WDoinIypWXOGC
   uIeWGT8zjoDXPYo3IpyZ3B+t7T1e52rHpIaPUGKe3/2TdCx6BDWVwKuNS
   Ed8FS+Qb9sjGitXQaeR7auYFdvlJ5lLF8wx9iRFztuLlK1KmjXjAXRSoS
   658wzyJzghZz89u3Aea4XtRHLTKSBg6PODjiBHPIob9BNiues9ztQ5B5G
   8/BLruEFqPzEQ1+QAFHd8cdFbthH7TpjTU9cXLRfis5YTBmrfonfSxBiQ
   u5JnCS0IlbQBsLlCD738LSe8DCB4IiTd87OF6cfCmX8ONVfJ/by+44ZNJ
   A==;
X-CSE-ConnectionGUID: GGrajbEhTm+0cO8yos6tfw==
X-CSE-MsgGUID: Iyx/LpxZR2OMoEL8qABLGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62824426"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="62824426"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 22:38:12 -0700
X-CSE-ConnectionGUID: DeSYO1MwTgi9nIrm3ykp8g==
X-CSE-MsgGUID: 95uO0zTbQRKR9PMB0s3iTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="190087282"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 22:38:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 22:38:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 26 Oct 2025 22:38:11 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 22:38:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4xJ6MeeciTZabTicQOeqGg2QCma5GOhFDnMfout7CdKuXzwtSga9+Pn1XbXuIQMIRbIO6q36ugCwqSMspQSuH4/vj0y3dhB5WN7QKcEOhZ0fLMVHsCwly3PIElDNbDF6MAHMNqLSeKD0sY5vGdD0iz3YAh/FfgufAGO9BSRoe9+yH1LPVY6ex7t1cAZGipPSobWY0ZuMHHiuS4ir2kLGlop4AlRb1uqTiBQ/e+jc6+Gkn5xkRxQHvAINeMtnz7txBafr6Dg5C1of7tLF2hxVnE+pov5qsp4CwchsU8Hgc2uJnzinPrfM911WDbJJPsjP/Y0ApndeY3QMDlJk1H/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQtgswtxbpaxZKF1sBej1LAUhCRl7ukGS3Kp9uKemCE=;
 b=eSGx077LpUk4T/29OmbdzUV3qXIwh+/wkPDw68iqYdo7tZri4EvWUGRxrAYF43MtPfBTuehLQhucy/fMMz6SOoEGTTVUOiWvOi779/BsPKqxqrz1rdQ1i3dtkMlTgl2mhQouuztLVBb4C21Jt9pLKpLiYbPcAbHUUXTOR4p1R6svkL1kXGF9mMQF7SCb0E8LFaSbAXe7dxzG8wxQ39SIh8NODIcVfSM4yT1uV75TLNXAKpkActjSinIRcSXCJa7NpVVDZWBlR6BnJD3u1PQ6IJ9hqqeBMq0o6cI7bk5JulX/OwBWf82PLyDOe/1mN5TvcurrnoDbB7HF/dBMJVG1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB6003.namprd11.prod.outlook.com (2603:10b6:208:387::6)
 by MW6PR11MB8367.namprd11.prod.outlook.com (2603:10b6:303:249::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Mon, 27 Oct
 2025 05:38:09 +0000
Received: from BL1PR11MB6003.namprd11.prod.outlook.com
 ([fe80::4584:bb9d:44c:1bff]) by BL1PR11MB6003.namprd11.prod.outlook.com
 ([fe80::4584:bb9d:44c:1bff%4]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 05:38:08 +0000
From: "Deng, Pan" <pan.deng@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org"
	<mingo@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "bsegall@google.com"
	<bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "Li, Tianyou"
	<tianyou.li@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v3] sched/rt: Optimize cpupri_vec layout to mitigate cache
 line contention
Thread-Topic: [PATCH v3] sched/rt: Optimize cpupri_vec layout to mitigate
 cache line contention
Thread-Index: AQHcHUWN1tIoSTEz7EGlYjw8BFtU17TVy9EA
Date: Mon, 27 Oct 2025 05:38:08 +0000
Message-ID: <BL1PR11MB6003FCF9DB3F0BFD72B0F70E96FCA@BL1PR11MB6003.namprd11.prod.outlook.com>
References: <20250904024630.458897-1-pan.deng@intel.com>
In-Reply-To: <20250904024630.458897-1-pan.deng@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB6003:EE_|MW6PR11MB8367:EE_
x-ms-office365-filtering-correlation-id: 6dba76d6-fe7e-439f-6dfc-08de151b02ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?b1E5K3hkUzZLTlNrenhraG0zL2dOS2RUQitia0ZSM255K0xIUVF6SkpxVlVU?=
 =?utf-8?B?a0p0c0pKRkpLdGg0OW05aHhEdStlM0N6Zjh6ZXJQNllxVGJacktvNHBMZXo1?=
 =?utf-8?B?ZzlPeEZpUVQ2b2JEWW5JZ1JoRnRob0xlT2tWZWxhVGhPWjVLbjZ1elZLSHBr?=
 =?utf-8?B?bGpEVVZCeGNweU9IMjR6bWpXTWI5dnVRU2Fka1BuL2liWUtYSkx1REdRNysx?=
 =?utf-8?B?elM1c3VlVVpIVVQ3NnJiMFdlTjlMbExmYXhtTmtwaGgzQ05ucHc2Mi9JcFZJ?=
 =?utf-8?B?T0VaeDVEbEUrajJYTnhmZ20wUDZUSjBsSElVSjBRNEdQcmduZ08zdVVXditO?=
 =?utf-8?B?cHMrOTZrTHdJY0t1RldsNDNjWVExbTNrQVZ4UHV6b2NqNFo3aHFCS0hYS09R?=
 =?utf-8?B?Ym9PczFsdFZRa1RmNzVLSGZFcW95RWE2a0p3dGdUNUFBY2d3emFNZ21uUW1n?=
 =?utf-8?B?bFR2MkhmanFCaUtiQnNHdFZ3ejJlUFltTXFkRkRKRTBrNWVaS2lyeExhdEpJ?=
 =?utf-8?B?L0FabDdxVUdvOG1jYUc1d2xCUmtBUkNncVA3YW5idUlwMVZoRTMzemU4K2Vk?=
 =?utf-8?B?NTM5RFkxK3BFdW4yczlwLzJNazRCcTNDdjdwVHFzTXJkcTlNaFRNdW0xc0E0?=
 =?utf-8?B?aGhQUUEyL3RFdVd4NURrYTVnTkJaYWtUcnE0WlJ1a1BYeUIwSFRnMW1kNzhl?=
 =?utf-8?B?WU9Udm94eWRIYzFzUHFidU9DZXU1Wk1tQU45WkRONHlsSWRUa1hGaFovdWRD?=
 =?utf-8?B?RHBrMW02Q1JJVlhPYTU3SUpiY2k2K3BkUHVpc1RRWkhUUTBHclNlZVN2dGo2?=
 =?utf-8?B?SmJwZEhDcHJHWDBNVzBYRXdpd0tmQ2oySGxLMGt0Yk1JSVR1RkM5U21KVXhW?=
 =?utf-8?B?M2M4VWVtbG93Y1Q3NEZSWVR3REp1SVExN2lFZXJ2ZlNqSUpjbEpOVkh4cWdB?=
 =?utf-8?B?T0dsUWNHZWpTNEMybExjcTBGTW5hZFdLMXM0azYzRnB1OG1GSkEzWXJta082?=
 =?utf-8?B?L050cU1yUXRlWU13UytGcVFvUnkrUnpUV29RMENSbmZxZGE2emltUk92NjBB?=
 =?utf-8?B?d2doZzhya3JnMkxjRVFMQ1hxK3kyeDFYMXN2ZDZiRFg1azJ4MEN6RnlpdUlO?=
 =?utf-8?B?aUQvZjBRTGgzK05mMTNXQWxuS0JFMUErZy9rYTIwS1ptcy9yeDIzc2J5TVB1?=
 =?utf-8?B?aFdJeVNvVWJ2QzZMdTY2RW1EYU5yQzhFMmtSRFJ5eWgxS2ZFVGRFbks0NFhB?=
 =?utf-8?B?L3kremNtU0hRekxpQTJSaFpsUkNzZXRHZDRTN1p2OERiK3gxd29ybVVMVVNw?=
 =?utf-8?B?NVFlZVRRbC9oUE1GcVhVcjFGQVZaU2JjNVJNZG9YS2RFM0FrV3gvRnhXMy9G?=
 =?utf-8?B?M1NGbWt3bEdydDVibFNLZURkbHlTeG53TXZyUGtoZ1N4ZnJGZVBtK3ZnRDFG?=
 =?utf-8?B?S2ZUL0hmV0FISHl2WUNSMXBhSTNRdUJuVnBVbzhKNmt2UEQxUS8xSSs1OFBa?=
 =?utf-8?B?QURPaHlTS081Y0JobHU3SmhCcE4raDIvSnFHMzFpY2JBV2NIdS9vaTJWSFJD?=
 =?utf-8?B?K1c3bnVUSkdmcDlBTDM0YkFrNnBMMXpmOGRYWjUxUVI0UmhqK2VLdGFsV0xy?=
 =?utf-8?B?SXhBbHRiWEV4TXZrS1N5RkVmY2pobC9EL1h1NjI0TWR6Skw3cHhvbDJKYi9y?=
 =?utf-8?B?ampDY2Y3a1lVZmlxQjZLY2RDWVdIdWIxZE0xbG0vcFdObW9id2tuY1BITFBF?=
 =?utf-8?B?SXpqSXVYeVhQRThqekw0L2V2OVBIakhrZXlxZ2g2TjJOeHlMeGx0SnJZYWZq?=
 =?utf-8?B?U2ZoUmtEcWp2NDdxUG1adUUzcHora2JuUHNxbWluNVZOYUxlaFVncHgxemFC?=
 =?utf-8?B?K0NWWVlxWkp3NTlGRFc0eE50UEZ0V0YrT1FFRDJCYmMyRnNiRTZwMG5IS2x3?=
 =?utf-8?B?UFFNTVcwbW1pVGZrMVJBMG91N090VFNaMlBFNE5ZRzl4bmd2Q0F3ekUwMzdF?=
 =?utf-8?B?cExWbVhoL1NQN2lKYitvNlJQV1FjSURyNkhYVGxZaUhsZUlFNE03RFdOL3ZP?=
 =?utf-8?Q?JpPFT0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB6003.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk8wNmFPWUZ2TUJaeXNmWVl1V2M1c1JVdnpRajdJRTJrd3E4SWVuYk90VXdW?=
 =?utf-8?B?bmo4Um5SK0tJWi9MdEwrUlBKaUhEMDdVNzhYQTJ4WTExYTJsUGxvQ0MxU2dJ?=
 =?utf-8?B?VGhkKzZnQ3IxQjRjRjNjNnZHZzdpZnJGSTdGcUdXUC9zaFR6ZHZaV0hDYTdI?=
 =?utf-8?B?NVBZSGRGU0Mwcllxc2JlL2JtaEFzUzdVc0RreFN4U21tQ1Fmckg5S0Vpb3V6?=
 =?utf-8?B?bEJCazdiKzlseFZMOHJvaytzWVM3WGZGNTRtbE96NGVFQzZseFZja2VremVh?=
 =?utf-8?B?Y2JNUDdiV3U0RVNVcW9MRk5Ic3l2TVFBbzBNNFJONHVkVGUxakJsVytBdWRl?=
 =?utf-8?B?djdvSy84cnIya3dPUjZjcHFwajRUUFYvM0dmZE1hWEVZdS9TUitMMFBUcy80?=
 =?utf-8?B?OHBidTRqc0w3eTdEWFJBbkZLeW9zVm4vMTgwWW9sMTFEY0VzNFRNYmNzZXBL?=
 =?utf-8?B?b1JWUFdOUWc5M1VmeTdlTUxGWE1oclM2SVhtaERqQ2QwQnVTQVhVNEhXVWlL?=
 =?utf-8?B?THJub1E5T1VBcXVLc1Z0WHVVcXJicUlyOU81YzV1U2NCU3pmS3hQYUtVQ28x?=
 =?utf-8?B?dG51RlYwVE4wMWtBc284eXVCTDhQOW50NVBDTGJiVmoybFBTWTZWMHh4NEI1?=
 =?utf-8?B?SjFEQlp1MTkrV2lqTUJIdHlJTGNTQ2VVcHpzdTZqS0Q4dHIrb1pRdUZlR2Zi?=
 =?utf-8?B?NHJ0R2VOWi9lUzNUL3hTVENvek1Ickd4ZlBMcmttZ2JHYUt2dmtvYS9rS2g0?=
 =?utf-8?B?OUt5RXBaT3MySC9mL0xrOXFQNnBXVm1pMS9ncFFzNUZtRjR6VlVHdjRLOWVV?=
 =?utf-8?B?d1hyS0hCbjBSMS9qS3prNTFrTXJWTmp3RkNISGVtZUU3STVRRnkxTVdhdHl0?=
 =?utf-8?B?azEzVW82eEplVlptZmY3T2dIVllmZXFhSTk4TVl2MjdrOTZWMlVkQk9EOVU1?=
 =?utf-8?B?eDJxODdPZzlDTkNTckU2UUFJMGE4WDdpbXJuRnJOTnVhWXAzZXovVlNDU29Y?=
 =?utf-8?B?SU0rODdEemFQak5qOTVnTEUzaTlRNzhTcExZUGFWalg5NkJhYXFiM2NMdVBZ?=
 =?utf-8?B?bFVTdzgzNTIrZjdnbm8wYm51RHhCK2djWHNBYVo0NEJ3ZHVTVGRFcTVpek9T?=
 =?utf-8?B?VUY3Q0krVjR6bWVLaWFKc0lpOXVYK0MxalZ1bHJabWg5TnhWNG51Z2svOEht?=
 =?utf-8?B?dUdIK3ZuVFBjZGRXc1hIc29jdDA3U3ZXalNLVkxSTWVRNXVCdXBvbWhEOEla?=
 =?utf-8?B?S0VQbXhTNXlyNHJPeXdoTisxQmh1d3pLZkw5emNOa3pVS1JobnRQTWZsZ2M2?=
 =?utf-8?B?eE1ERWo1OUZmRjZkdUpubWxoUjd1OUFXT3BWVDFZSE5MT1RUNXQ5OVZ6b0Zh?=
 =?utf-8?B?Wis2VHNka0hsUWt0SWRnSFpMQ3BlUGR5TXd1REJKMTNENkxaSWVoZWlVUE9o?=
 =?utf-8?B?OXpKYkE1aVRFZEh2NitpV3Y0RUM4K1h1WVd2UUtRQWw4c2loWVB3VmJJS3JF?=
 =?utf-8?B?cm1HUWVCT0cyM2FWaEs3emhLdXRFd2xjYlJhK1dHUVdnQjd5N2VVeCt5bnBh?=
 =?utf-8?B?RDhIZlFJYjJOYWhYT0d2NnIrNGMzTFd3T3Ira0NVSkN5QjRCYURPN3JDcHBX?=
 =?utf-8?B?V2d3dXcxalRyNG1ocHhaTTl1dTlMWm1XKzRWOVNCNEJtbHBnZUREQjNiRXpS?=
 =?utf-8?B?S0RTMWJiMWZPNk40bGFxRFlGeGwweCtOdUM1QWwvMGRUZlJmL3gvQnk0NzVs?=
 =?utf-8?B?Mit1REhhaHdadFpHNm1XbmZpVC9nQ09xK3hDcE41UnZTRkgvWWlURkYvYUNZ?=
 =?utf-8?B?VHBjREp6aUxTdXhndmZPYmtnbFYvMHUxcThlU1lLS0p2WjNwL3hzdlVvdlZM?=
 =?utf-8?B?SHpVU2J0YXA4aWszV3JJMlBscExOZnMrb0ZyamJTMDVLVkJBYzNzR2FlSWQr?=
 =?utf-8?B?YWEzOVlqVHErdmhoQUxLRnlDUTBSL1Evb2xSZ0xCZEZIODRkdnJoSE1RYWJV?=
 =?utf-8?B?U1NkRXNlbjV6TFE2cWdsV0lmMU1kT3NXMHBLZ01tWjdBT0xaTEY1dWJmRTlk?=
 =?utf-8?B?dkpaT0kvYWxDMUU4aGY1SUgvY0cxV3NrOXoxbjdYWkw0SDBiQmFuUGJ1TnZ5?=
 =?utf-8?Q?GLkGKbr0Poxl6bUoXTe1iPuFa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB6003.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dba76d6-fe7e-439f-6dfc-08de151b02ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 05:38:08.5751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R/640W+Wnn7Kt7IMRKzIHst4kiqKBApzK/SKnY1dEFwhyPl/4hVKgEbpkki9jKG7JK2wWKizG8vgMIODTdIBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8367
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEZW5nLCBQYW4gPHBhbi5kZW5n
QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciA0LCAyMDI1IDEwOjQ2IEFN
DQo+IFRvOiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgbWluZ29Aa2VybmVsLm9yZzsganVyaS5sZWxs
aUByZWRoYXQuY29tOw0KPiB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZzsgcm9zdGVkdEBnb29k
bWlzLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGlldG1hci5lZ2dl
bWFubkBhcm0uY29tOw0KPiBic2VnYWxsQGdvb2dsZS5jb207IG1nb3JtYW5Ac3VzZS5kZTsgdnNj
aG5laWRAcmVkaGF0LmNvbTsgTGksIFRpYW55b3UNCj4gPHRpYW55b3UubGlAaW50ZWwuY29tPjsg
Q2hlbiwgWXUgQyA8eXUuYy5jaGVuQGludGVsLmNvbT47DQo+IHRpbS5jLmNoZW5AbGludXguaW50
ZWwuY29tOyBEZW5nLCBQYW4gPHBhbi5kZW5nQGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IHYzXSBzY2hlZC9ydDogT3B0aW1pemUgY3B1cHJpX3ZlYyBsYXlvdXQgdG8gbWl0aWdhdGUgY2Fj
aGUgbGluZQ0KPiBjb250ZW50aW9uDQo+IA0KPiBXaGVuIHJ1bm5pbmcgYSBtdWx0aS1pbnN0YW5j
ZSBGRm1wZWcgd29ya2xvYWQgb24gYW4gSENDIHN5c3RlbSwgc2lnbmlmaWNhbnQNCj4gY2FjaGUg
bGluZSBjb250ZW50aW9uIGlzIG9ic2VydmVkIGFyb3VuZCBgY3B1cHJpX3ZlYy0+Y291bnRgIGFu
ZCBgbWFza2AgaW4NCj4gc3RydWN0IHJvb3RfZG9tYWluLg0KPiANCj4gVGhlIFNVVCBpcyBhIDIt
c29ja2V0IG1hY2hpbmUgd2l0aCAyNDAgcGh5c2ljYWwgY29yZXMgYW5kIDQ4MCBsb2dpY2FsDQo+
IENQVXMuIDYwIEZGbXBlZyBpbnN0YW5jZXMgYXJlIGxhdW5jaGVkLCBlYWNoIHBpbm5lZCB0byA0
IHBoeXNpY2FsIGNvcmVzDQo+ICg4IGxvZ2ljYWwgQ1BVcykgZm9yIHRyYW5zY29kaW5nIHRhc2tz
LiBTdWItdGhyZWFkcyB1c2UgUlQgcHJpb3JpdHkgOTkNCj4gd2l0aCBGSUZPIHNjaGVkdWxpbmcu
IEZQUyBpcyB1c2VkIGFzIHNjb3JlLg0KPiANCj4gcGVyZiBjMmMgdG9vbCByZXZlYWxzOg0KPiBy
b290X2RvbWFpbiBjYWNoZSBsaW5lIDM6DQo+IC0gYGNwdXByaS0+cHJpX3RvX2NwdVswXS5jb3Vu
dGAgKG9mZnNldCAweDM4KSBpcyBoZWF2aWx5IGxvYWRlZC9zdG9yZWQNCj4gICAgYW5kIGNvbnRl
bmRzIHdpdGggb3RoZXIgZmllbGRzLCBzaW5jZSBjb3VudHNbMF0gaXMgbW9yZSBmcmVxdWVudGx5
DQo+ICAgIHVwZGF0ZWQgdGhhbiBvdGhlcnMgYWxvbmcgd2l0aCBhIHJ0IHRhc2sgZW5xdWV1ZXMg
YW4gZW1wdHkgcnVucSBvcg0KPiAgICBkZXF1ZXVlcyBmcm9tIGEgbm9uLW92ZXJsb2FkZWQgcnVu
cS4NCj4gLSBjeWNsZXMgcGVyIGxvYWQ6IH4xMEsgdG8gNTlLDQo+IA0KPiBjcHVwcmkncyBsYXN0
IGNhY2hlIGxpbmU6DQo+IC0gYGNwdXByaV92ZWMtPmNvdW50YCBhbmQgYG1hc2tgIGNvbnRlbmRz
LiBUaGUgdHJhbnNjb2RpbmcgdGhyZWFkcyB1c2UNCj4gICBydCBwcmkgOTksIHNvIHRoYXQgdGhl
IGNvbnRlbnRpb24gb2NjdXJzIGluIHRoZSBlbmQuDQo+IC0gY3ljbGVzIHBlciBsb2FkOiB+MS41
SyB0byAxMC41Sw0KPiANCj4gVGhpcyBjaGFuZ2UgbWl0aWdhdGVzIGBjcHVwcmlfdmVjLT5jb3Vu
dGAsIGBtYXNrYCByZWxhdGVkIGNvbnRlbnRpb25zIGJ5DQo+IHNlcGFyYXRpbmcgZWFjaCBjb3Vu
dCBhbmQgbWFzayBpbnRvIGRpZmZlcmVudCBjYWNoZSBsaW5lcy4NCj4gDQo+IEFzIGEgcmVzdWx0
Og0KPiAtIEZQUyBpbXByb3ZlcyBieSB+MTElDQo+IC0gS2VybmVsIGN5Y2xlcyUgZHJvcHMgZnJv
bSB+MjAlIHRvIH4xMSUNCj4gLSBgY291bnRgIGFuZCBgbWFza2AgcmVsYXRlZCBjYWNoZSBsaW5l
IGNvbnRlbnRpb24gaXMgbWl0aWdhdGVkLCBwZXJmIGMyYw0KPiAgIHNob3dzIHJvb3RfZG9tYWlu
IGNhY2hlIGxpbmUgMyBgY3ljbGVzIHBlciBsb2FkYCBkcm9wcyBmcm9tIH4xMEstNTlLDQo+ICAg
dG8gfjAuNUstOEssIGNwdXByaSdzIGxhc3QgY2FjaGUgbGluZSBubyBsb25nZXIgYXBwZWFycyBp
biB0aGUgcmVwb3J0Lg0KPiAtIHN0cmVzcy1uZyBjeWNsaWMgYmVuY2htYXJrIGlzIGltcHJvdmVk
IH4zMS40JSwgY29tbWFuZDoNCj4gICBzdHJlc3Mtbmcvc3RyZXNzLW5nIC0tY3ljbGljICQobnBy
b2MpIC0tY3ljbGljLXBvbGljeSBmaWZvICAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgLS10
aW1lb3V0IDMwIC0tbWluaW1pemUgLS1tZXRyaWNzDQo+IC0gcnQtdGVzdHMvcGlfc3RyZXNzIGlz
IGltcHJvdmVkIH43Ni41JSwgY29tbWFuZDoNCj4gICBydC10ZXN0cy9waV9zdHJlc3MgLUQgMzAg
LWcgJCgoJChucHJvYykgLyAyKSkNCj4gLSBzY2hlZF9ub3JtYWwgdGVzdHMgaGFja2JlbmNoIGFu
ZCBzY2hiZW5jaCBhcmUgdW5hZmZlY3RlZC4NCj4gDQo+IEFwcGVuZGl4Og0KPiAxLiBDdXJyZW50
IGxheW91dCBvZiBjb250ZW5kZWQgZGF0YSBzdHJ1Y3R1cmU6DQo+IHN0cnVjdCByb290X2RvbWFp
biB7DQo+ICAgICAuLi4NCj4gICAgIHN0cnVjdCBpcnFfd29yayAgICAgICAgICAgIHJ0b19wdXNo
X3dvcms7ICAgICAgICAvKiAgIDEyMCAgICAzMiAqLw0KPiAgICAgLyogLS0tIGNhY2hlbGluZSAy
IGJvdW5kYXJ5ICgxMjggYnl0ZXMpIHdhcyAyNCBieXRlcyBhZ28gLS0tICovDQo+ICAgICByYXdf
c3BpbmxvY2tfdCAgICAgICAgICAgICBydG9fbG9jazsgICAgICAgICAgICAgLyogICAxNTIgICAg
IDQgKi8NCj4gICAgIGludCAgICAgICAgICAgICAgICAgICAgICAgIHJ0b19sb29wOyAgICAgICAg
ICAgICAvKiAgIDE1NiAgICAgNCAqLw0KPiAgICAgaW50ICAgICAgICAgICAgICAgICAgICAgICAg
cnRvX2NwdTsgICAgICAgICAgICAgIC8qICAgMTYwICAgICA0ICovDQo+ICAgICBhdG9taWNfdCAg
ICAgICAgICAgICAgICAgICBydG9fbG9vcF9uZXh0OyAgICAgICAgLyogICAxNjQgICAgIDQgKi8N
Cj4gICAgIGF0b21pY190ICAgICAgICAgICAgICAgICAgIHJ0b19sb29wX3N0YXJ0OyAgICAgICAv
KiAgIDE2OCAgICAgNCAqLw0KPiAgICAgLyogWFhYIDQgYnl0ZXMgaG9sZSwgdHJ5IHRvIHBhY2sg
Ki8NCj4gICAgIGNwdW1hc2tfdmFyX3QgICAgICAgICAgICAgIHJ0b19tYXNrOyAgICAgICAgICAg
ICAvKiAgIDE3NiAgICAgOCAqLw0KPiAgICAgLyogLS0tIGNhY2hlbGluZSAzIGJvdW5kYXJ5ICgx
OTIgYnl0ZXMpIHdhcyA4IGJ5dGVzIGhlbmNlIC0tLSAqLw0KPiAgICAgc3RydWN0IGNwdXByaSAg
ICAgICAgICAgICAgY3B1cHJpOyAgICAgICAgICAgICAgIC8qICAgMTg0ICAxNjI0ICovDQo+ICAg
ICAvKiAtLS0gY2FjaGVsaW5lIDI4IGJvdW5kYXJ5ICgxNzkyIGJ5dGVzKSB3YXMgMTYgYnl0ZXMg
YWdvIC0tLSAqLw0KPiAgICAgc3RydWN0IHBlcmZfZG9tYWluICogICAgICAgcGQ7ICAgICAgICAg
ICAgICAgICAgIC8qICAxODA4ICAgICA4ICovDQo+ICAgICAvKiBzaXplOiAxODE2LCBjYWNoZWxp
bmVzOiAyOSwgbWVtYmVyczogMjEgKi8NCj4gICAgIC8qIHN1bSBtZW1iZXJzOiAxODAyLCBob2xl
czogMywgc3VtIGhvbGVzOiAxNCAqLw0KPiAgICAgLyogZm9yY2VkIGFsaWdubWVudHM6IDEgKi8N
Cj4gICAgIC8qIGxhc3QgY2FjaGVsaW5lOiAyNCBieXRlcyAqLw0KPiB9IF9fYXR0cmlidXRlX18o
KF9fYWxpZ25lZF9fKDgpKSk7DQo+IA0KPiAyLiBQZXJmIGMyYyByZXBvcnQgb2Ygcm9vdF9kb21h
aW4gY2FjaGUgbGluZSAzOg0KPiAtLS0tLS0tICAtLS0tLS0tICAtLS0tLS0gIC0tLS0tLSAgLS0t
LS0tICAtLS0tLS0gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgUm10ICAgICAgTGNsICAg
ICBTdG9yZSAgIERhdGEgICAgTG9hZCAgICBUb3RhbCAgICBTeW1ib2wNCj4gSGl0bSUgICAgSGl0
bSUgICBMMSBIaXQlICBvZmZzZXQgIGN5Y2xlcyAgcmVjb3Jkcw0KPiAtLS0tLS0tICAtLS0tLS0t
ICAtLS0tLS0gIC0tLS0tLSAgLS0tLS0tICAtLS0tLS0gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgMzUzICAgICAgIDQ0ICAgICAgIDYyICAgIDB4ZmYxNGQ0MmM0MDBlMzg4MA0KPiAtLS0t
LS0tICAtLS0tLS0tICAtLS0tLS0gIC0tLS0tLSAgLS0tLS0tICAtLS0tLS0gIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgMC4wMCUgICAgMi4yNyUgICAgMC4wMCUgIDB4MCAgICAgMjE2ODMg
ICA2ICAgICBfX2ZsdXNoX3NtcF9jYWxsX2Z1bmN0aW9uXw0KPiAgMC4wMCUgICAgMi4yNyUgICAg
MC4wMCUgIDB4MCAgICAgMjIyOTQgICA1ICAgICBfX2ZsdXNoX3NtcF9jYWxsX2Z1bmN0aW9uXw0K
PiAgMC4yOCUgICAgMC4wMCUgICAgMC4wMCUgIDB4MCAgICAgMCAgICAgICAyICAgICBpcnFfd29y
a19xdWV1ZV9vbg0KPiAgMC4yOCUgICAgMC4wMCUgICAgMC4wMCUgIDB4MCAgICAgMjc4MjQgICA0
ICAgICBpcnFfd29ya19zaW5nbGUNCj4gIDAuMDAlICAgIDAuMDAlICAgIDEuNjElICAweDAgICAg
IDI4MTUxICAgNiAgICAgaXJxX3dvcmtfcXVldWVfb24NCj4gIDAuNTclICAgIDAuMDAlICAgIDAu
MDAlICAweDE4ICAgIDIxODIyICAgOCAgICAgbmF0aXZlX3F1ZXVlZF9zcGluX2xvY2tfc2wNCj4g
IDAuMjglICAgIDIuMjclICAgIDAuMDAlICAweDE4ICAgIDE2MTAxICAgMTAgICAgbmF0aXZlX3F1
ZXVlZF9zcGluX2xvY2tfc2wNCj4gIDAuNTclICAgIDAuMDAlICAgIDAuMDAlICAweDE4ICAgIDMz
MTk5ICAgNSAgICAgbmF0aXZlX3F1ZXVlZF9zcGluX2xvY2tfc2wNCj4gIDAuMDAlICAgIDAuMDAl
ICAgIDEuNjElICAweDE4ICAgIDEwOTA4ICAgMzIgICAgX3Jhd19zcGluX2xvY2sNCj4gIDAuMDAl
ICAgIDAuMDAlICAgIDEuNjElICAweDE4ICAgIDU5NzcwICAgMiAgICAgX3Jhd19zcGluX2xvY2sN
Cj4gIDAuMDAlICAgIDAuMDAlICAgIDEuNjElICAweDE4ICAgIDAgICAgICAgMSAgICAgX3Jhd19z
cGluX3VubG9jaw0KPiAgMS40MiUgICAgMC4wMCUgICAgMC4wMCUgIDB4MjAgICAgMTI5MTggICAy
MCAgICBwdWxsX3J0X3Rhc2sNCj4gIDAuODUlICAgIDAuMDAlICAgMjUuODElICAweDI0ICAgIDMx
MTIzICAgMTk5ICAgcHVsbF9ydF90YXNrDQo+ICAwLjg1JSAgICAwLjAwJSAgICAzLjIzJSAgMHgy
NCAgICAzODIxOCAgIDI0ICAgIHB1bGxfcnRfdGFzaw0KPiAgMC41NyUgICAgNC41NSUgICAxOS4z
NSUgIDB4MjggICAgMzA1NTggICAyMDcgICBwdWxsX3J0X3Rhc2sNCj4gIDAuMjglICAgIDAuMDAl
ICAgIDAuMDAlICAweDI4ICAgIDU1NTA0ICAgMTAgICAgcHVsbF9ydF90YXNrDQo+IDE4LjcwJSAg
IDE4LjE4JSAgICAwLjAwJSAgMHgzMCAgICAyNjQzOCAgIDI5MSAgIGRlcXVldWVfcHVzaGFibGVf
dGFzaw0KPiAxNy4yOCUgICAyMi43MyUgICAgMC4wMCUgIDB4MzAgICAgMjkzNDcgICAyODEgICBl
bnF1ZXVlX3B1c2hhYmxlX3Rhc2sNCj4gIDEuNzAlICAgIDIuMjclICAgIDAuMDAlICAweDMwICAg
IDEyODE5ICAgMzEgICAgZW5xdWV1ZV9wdXNoYWJsZV90YXNrDQo+ICAwLjI4JSAgICAwLjAwJSAg
ICAwLjAwJSAgMHgzMCAgICAxNzcyNiAgIDE4ICAgIGRlcXVldWVfcHVzaGFibGVfdGFzaw0KPiAz
NC41NiUgICAyOS41NSUgICAgMC4wMCUgIDB4MzggICAgMjU1MDkgICA1MjcgICBjcHVwcmlfZmlu
ZF9maXRuZXNzDQo+IDEzLjg4JSAgIDExLjM2JSAgIDI0LjE5JSAgMHgzOCAgICAzMDY1NCAgIDM0
MiAgIGNwdXByaV9zZXQNCj4gIDMuMTIlICAgIDIuMjclICAgIDAuMDAlICAweDM4ICAgIDE4MDkz
ICAgMzkgICAgY3B1cHJpX3NldA0KPiAgMS43MCUgICAgMC4wMCUgICAgMC4wMCUgIDB4MzggICAg
Mzc2NjEgICA1MiAgICBjcHVwcmlfZmluZF9maXRuZXNzDQo+ICAxLjQyJSAgICAyLjI3JSAgIDE5
LjM1JSAgMHgzOCAgICAzMTExMCAgIDIxMSAgIGNwdXByaV9zZXQNCj4gIDEuNDIlICAgIDAuMDAl
ICAgIDEuNjElICAweDM4ICAgIDQ1MDM1ICAgMzEgICAgY3B1cHJpX3NldA0KPiANCj4gMy4gUGVy
ZiBjMmMgcmVwb3J0IG9mIGNwdXByaSdzIGxhc3QgY2FjaGUgbGluZQ0KPiAtLS0tLS0tICAtLS0t
LS0tICAtLS0tLS0gIC0tLS0tLSAgLS0tLS0tICAtLS0tLS0gIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgUm10ICAgICAgTGNsICAgICBTdG9yZSAgIERhdGEgICAgTG9hZCAgICBUb3RhbCAg
ICBTeW1ib2wNCj4gSGl0bSUgICAgSGl0bSUgICBMMSBIaXQlICBvZmZzZXQgIGN5Y2xlcyAgcmVj
b3Jkcw0KPiAtLS0tLS0tICAtLS0tLS0tICAtLS0tLS0gIC0tLS0tLSAgLS0tLS0tICAtLS0tLS0g
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMTQ5ICAgICAgIDQzICAgICAgIDQxICAgIDB4
ZmYxNGQ0MmM0MDBlM2VjMA0KPiAtLS0tLS0tICAtLS0tLS0tICAtLS0tLS0gIC0tLS0tLSAgLS0t
LS0tICAtLS0tLS0gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgOC43MiUgICAxMS42MyUg
ICAgMC4wMCUgIDB4OCAgICAgMjAwMSAgICAxNjUgICBjcHVwcmlfZmluZF9maXRuZXNzDQo+ICAx
LjM0JSAgICAyLjMzJSAgICAwLjAwJSAgMHgxOCAgICAxNDU2ICAgIDE1MSAgIGNwdXByaV9maW5k
X2ZpdG5lc3MNCj4gIDguNzIlICAgIDkuMzAlICAgNTguNTQlICAweDI4ICAgIDE3NDQgICAgMjYz
ICAgY3B1cHJpX3NldA0KPiAgMi4wMSUgICAgNC42NSUgICA0MS40NiUgIDB4MjggICAgMTk1OCAg
ICAzMDEgICBjcHVwcmlfc2V0DQo+ICAxLjM0JSAgICAwLjAwJSAgICAwLjAwJSAgMHgyOCAgICAx
MDU4MCAgIDYgICAgIGNwdXByaV9zZXQNCj4gNjkuODAlICAgNjcuNDQlICAgIDAuMDAlICAweDMw
ICAgIDE3NTQgICAgMzQ3ICAgY3B1cHJpX3NldA0KPiAgOC4wNSUgICAgNC42NSUgICAgMC4wMCUg
IDB4MzAgICAgMjE0NCAgICAyNTYgICBjcHVwcmlfc2V0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQ
YW4gRGVuZyA8cGFuLmRlbmdAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaWFueW91IExp
IDx0aWFueW91LmxpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBZdSA8eXUuYy5j
aGVuQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4
LmludGVsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjHvvJoNCj4gLSBVc2UgX19fX2Nh
Y2hlbGluZV9hbGlnbmVkX2luX3NtcCBpbnN0ZWFkIG9mIF9fX19jYWNoZWxpbmVfYWxpZ25lZCB0
bw0KPiAgIGF2b2lkIHdhc3RpbmcgbWVtb3J5IG9uIFVQIHN5c3RlbXMuDQo+IA0KPiAga2VybmVs
L3NjaGVkL2NwdXByaS5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2NwdXByaS5o
IGIva2VybmVsL3NjaGVkL2NwdXByaS5oDQo+IGluZGV4IDZmNTYyMDg4YzA1Ni4uZjZiYjc0NTE3
ZmQ2IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvc2NoZWQvY3B1cHJpLmgNCj4gKysrIGIva2VybmVs
L3NjaGVkL2NwdXByaS5oDQo+IEBAIC0xMiw3ICsxMiw3IEBADQo+IA0KPiAgc3RydWN0IGNwdXBy
aV92ZWMgew0KPiAgCWF0b21pY190CQljb3VudDsNCj4gLQljcHVtYXNrX3Zhcl90CQltYXNrOw0K
PiArCWNwdW1hc2tfdmFyX3QJCW1hc2sgX19fX2NhY2hlbGluZV9hbGlnbmVkX2luX3NtcDsNCj4g
IH07DQo+IA0KPiAgc3RydWN0IGNwdXByaSB7DQo+IC0tDQo+IDIuNDMuNQ0KDQpAcGV0ZXJ6LCBA
bWluZ28sIEByb3N0ZWR0LA0KDQpjb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rIGF0IHRoaXMg
cGF0Y2g/IEFueSBjb21tZW50IGlzIHZlcnkgYXBwcmVjaWF0ZWQuDQoNClRoYW5rcw0KUGFuDQoN
Cg==

