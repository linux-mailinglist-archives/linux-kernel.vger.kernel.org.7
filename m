Return-Path: <linux-kernel+bounces-581457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6A7A7600E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 09:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F24E3A9621
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAD01BD9E3;
	Mon, 31 Mar 2025 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3dYFr8O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4B1C1F22;
	Mon, 31 Mar 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406039; cv=fail; b=R2aHOSYpzzt+IgDp5C2WL110LfaijUQZsCrvZX+DtWdQrSL5twchb0BuL/Gbn4wWhVOj5RAEmVU4bj4HbZ4thwfduIyMa+Pvw6CYrcf+996jibO49eVYm0fZv8IvTk+uxfE7+djaCi0L0lbMVckPGzXLIeAsG16mIF743eLbYCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406039; c=relaxed/simple;
	bh=jT5RVgsx6i7o3pHO9rdyIQOs4JaImNbZ7ejwqpvoZRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwsowrwDb5Lzbq74hP9G+knU4JR49ZnbZI5SNsUydoo/xkPv+5To3AcucEt2+xYo8cVJ0SuFDppy2BZae+FLeuzbgGfG0RzqOCeWMqX51HN8b1kmq1wJUmYQa4rxPXSElvwysYFxBsOwAKRT+wcY0FfCZeYWIv3Pc+vWSGroTyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3dYFr8O; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743406038; x=1774942038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jT5RVgsx6i7o3pHO9rdyIQOs4JaImNbZ7ejwqpvoZRA=;
  b=W3dYFr8ON3lyfvXJ5p2r2GND6ByX9z4aco5iwZDJ9mNXLw9by3OuxEQ/
   +qhh2x9wrXXVVlyisGl5/anbmKYESfp6qijJ/nCgTi5e+otNjBW2XXjcT
   dU4gF4VuIWJXfwETJ3yiLkUAMZmCGKKMlnNhIM4djTVDVGcn2B1OCirZ3
   HTbiCNg9LMpu0FU3XsGWG/I+efl4vLFmsohkMVxOHTo1n6SHtOYMGDggT
   Qsn+tyemcql/iWXIfdQ/+8RjnjDQ6wuQctB75yh4HUCq8qd+tWt6QrjU+
   Lbc/9h3YWDdkSRtCvlhNB6ENiwZyuaS1QIhGee+U3Bi6wonuOU6suClqD
   Q==;
X-CSE-ConnectionGUID: F8lA1XimR/Sj7zlZrQ7bMQ==
X-CSE-MsgGUID: vaY10BUFSqiZqCUFlB41fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44573475"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44573475"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 00:27:17 -0700
X-CSE-ConnectionGUID: uk3OiXSNRWazNJg7Uk+nGw==
X-CSE-MsgGUID: Sa5YFn9ORLqoKGp4L0wOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="130723116"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 00:27:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 31 Mar 2025 00:27:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 31 Mar 2025 00:27:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 00:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiV3pjp5GPcGWqgvx5K53Pd2DoF/CXEA0U4QQxzpbMBYFWNlvTxz/i1Ag4iXx1lpJ+l9RSXBH4qdqZq2Bf/NDtiP7DZ/N8/6wOKFxSy7OhI1OTAkpHOoUDcCfxoJI0ZQ1uhz/OlcZSYwCCt6Yj+vwu3nJcPW7dh5a72HwY1yqGDhdxxAS2MdLn5lN3pGk4wweB7BMn4V057xgfoKPZSRFsx5qYKk7+Jy0eHqs3cbdGwQvgBXLHhXvuWcz0wN+tU8ktVi6/kzad/+dbkMLlgubbeU1JQyja0xqIqQxz9o/hCkNUjryiHvTrhuYGzlESjv/KvhGN0Cl4cn3RaDAm3lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT5RVgsx6i7o3pHO9rdyIQOs4JaImNbZ7ejwqpvoZRA=;
 b=UxJeBLmOzUWlNItS2nOazSI+W5RXBEkddHTD2cI5eH8oTNS9xv7DADmsxodjHaPgKma3gwhUtvBRY595BB9WmZuXvMNG0RNhMfCAHFsaNNJtPzNn2SRO9zv8smsLC2RZ1fHPBZ9SSHYl7udD81vcLhgiZeCcw3DWmHhsJ297Ra4tYj7ROZx0kej2ENayhR9AG1E6HmXxRwSKMSuPAa7B8lefVNcmVjlHT0pfhQbCDGh4NfnvwRcfhPX0RyIoziDAN4ltiwfcMgYCzd2GwZN/gYI/S7kVvQ1oj9YbLDzywczuDMFZ3z8ov90gafPiZRg83GViCx+zn11ZUiY4lJshYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 LV1PR11MB8849.namprd11.prod.outlook.com (2603:10b6:408:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 07:26:45 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a%4]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 07:26:45 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Mallick,
 Asit K" <asit.k.mallick@intel.com>, "Scarlata, Vincent R"
	<vincent.r.scarlata@intel.com>, "Cai, Chong" <chongc@google.com>, "Aktas,
 Erdem" <erdemaktas@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"dionnaglaze@google.com" <dionnaglaze@google.com>, "bondarn@google.com"
	<bondarn@google.com>, "Raynor, Scott" <scott.raynor@intel.com>
Subject: RE: [PATCH v2 2/2] x86/sgx: Implement EUPDATESVN and
 opportunistically call it during first EPC page alloc
Thread-Topic: [PATCH v2 2/2] x86/sgx: Implement EUPDATESVN and
 opportunistically call it during first EPC page alloc
Thread-Index: AQHbn+FDiJjsRSw2cUyPYDKGfVHjnbOI1BeAgAAEgICABAKjsA==
Date: Mon, 31 Mar 2025 07:26:45 +0000
Message-ID: <DM8PR11MB5750C88DFC518EB77B0D613FE7AD2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20250328125859.73803-1-elena.reshetova@intel.com>
 <20250328125859.73803-3-elena.reshetova@intel.com>
 <Z-bhczXA6aHdCYHq@kernel.org> <Z-blOQ94ymUsDwPn@kernel.org>
In-Reply-To: <Z-blOQ94ymUsDwPn@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|LV1PR11MB8849:EE_
x-ms-office365-filtering-correlation-id: dc27c91b-de79-47a8-4122-08dd7025641e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VzQwZ1ZNandJMFlaZzlmclZJQnZxOGRBZ3dySy82cDBWOTJMdUhYVWNBOHlu?=
 =?utf-8?B?UTNzRFladjZLdVUrbmV6QzdpOGN2VDN6MDg5QlROWUlFNVc0ejM5MjZDaTM2?=
 =?utf-8?B?bVp3ZStBemtxZ1VCN3lwSkdQcHBTWlFRbGU3ZTNudTB0OFIrcXA1QStyN3BI?=
 =?utf-8?B?VVUvM0tsVE9Ra01BalBheXoxL1Z3SWV3OFRwZVdhajJEZGdKRU9aSHg5ZTI3?=
 =?utf-8?B?TUJqc2piRkRxRktaZWoxc1U2MlhSbnJ5UjRaK0VkWkcrVjE0UGZZYmx4OEFR?=
 =?utf-8?B?allVSGVGRTdRTXduU0RPdE5ucS85T2I1Z2RiS0pjb3V5aUN4akF6cE5KcC9i?=
 =?utf-8?B?VFVYaGNiRllGRWFIYWlFbzk2MEhoakExWmRWTGNERkphVWloY1YrRS9FN0pJ?=
 =?utf-8?B?WWs3eWthdnFIRjJlTWtVU1g5MmtHcW1laU5UUy9Fd0RqaWtKSmg3bzJ5OWVY?=
 =?utf-8?B?aWJ1a3lENGpQR2hEMFIreUtSYi9LU1doOWJNRTl6VTc4MmVZdmYvV1dUdHNK?=
 =?utf-8?B?MXkzU3NRWDU1a29SWWllZTZSOC9zZHV6WWpjSmRGcFdmd1ZqczQ1eXQxQmxU?=
 =?utf-8?B?VVB2NC9wOWx0c2hDZUc3S1NmQ2NrUk9mMzM4UkdIWU15VkQxNHNTdmV3WWhj?=
 =?utf-8?B?Z052QVlBY2srcGswOTdWN2tMSjBlMENWaFRld1M3R2kzd3lzV3JxUDhMdHBl?=
 =?utf-8?B?NzZjNDVCWFNDalJGUzEzT1pvYytIdjgxWXNFZ2F4bG11Vy9XZzJvTm9IblA4?=
 =?utf-8?B?MTAyQTdlRnBRaU1CZzd6T1ZYM0pKSjNhcWhDaVI1Q3NBZk9LNzlWQ1hHdUVU?=
 =?utf-8?B?eDUvN3ZDWDBIdVVXaVhqQkplMHV0VzFHUFJ4Ri9mUmI1cEJZRnY0L1QvUVpk?=
 =?utf-8?B?ZVJLMy9keFpkNWkwckpjbllnVitFc0d5dFFicFhFMXR4OG5HTDUzQnlCNUcz?=
 =?utf-8?B?TFlqWStzMks4ajF4Z2xuU01GZW85V2dkRXg1SFlYY2pyNHZtek9FOFk0V0h1?=
 =?utf-8?B?akdTYWhUSk8wbnB2YmVyelFscmhaT1BXMVl4cklXZE41eGoyeEFGcFdDUEFa?=
 =?utf-8?B?WnZaTlVVd3ByQlhxcFJiclhJcG1LWmZpYi9NeFFWMEM4U3FjY0pDTHpzWnJF?=
 =?utf-8?B?QWhhS3VkSUJzWENPemFSeURzR0E2d2xLbGZNbkhnVlJHdFN5NDRJNy9pOXpx?=
 =?utf-8?B?YUxFUGFzMWNkRHRKSnJTeERpODBDc1ZrNnRmVnZtLzN1UzJhZU5tVTAvSm1l?=
 =?utf-8?B?cWsvbzBiNGtVbWRHVVA2WCttTjUxK2xKeGJQWDFWOUo4OG9PQmhuRnhTOEM5?=
 =?utf-8?B?RXFPaFBjZFp4VWd6cHVRbXlHd2tnS1ZUTXUrdzlQZU0zc1JDZENCSzJlUDBR?=
 =?utf-8?B?VGZUcFFhUXUwYVRaY3ZCV0NieWg4ZjFkMGtZMUNmeW12T1lXdUtCYWQySXBl?=
 =?utf-8?B?V0RYemt3b3cvWGVpSjV4ckdqR3MrTmMxOHFlNG12a1JhWXdSZzZFTEdhWFNq?=
 =?utf-8?B?WTJ4REZjN1ZhQzIrYmw0ZmthNDAxYkN5allvSmJtYUhQekJBa3BzZEJCak8r?=
 =?utf-8?B?WTgzWDR1cnphRmlpMHZnSng0TFpaR3hPVUpZcFJDbU9kNUZFM25jYlViSzM1?=
 =?utf-8?B?OFU2dnBWbkNLYjlNNjhzT0tTOGliNG5IajVFMmhDejBVeXUxQU05TzI2MHpW?=
 =?utf-8?B?Sjhham1ZWjRMUWZPYXp3Zll5U1FQMHZnckp4OFhMU1FLbEVWd05TaU91RWdR?=
 =?utf-8?B?UmlIbjhBdlRhUzkwT3JmWE9LdEZyZHJ2NE1IcWoreE1wSlhPYTlBQlZKdFFs?=
 =?utf-8?B?MUZ0MWpXVy9PRjFDZDgzOFNwUytQblRpV2tZMmxTaG0rb1Z3elE3MDA3bXpO?=
 =?utf-8?B?elRCVlBZdmhycUkvc3NKeVNCdU9ZUXA2NGNIVnc4T1plWXZmclU3UktiVmNv?=
 =?utf-8?B?TnFUUEw2aTVBMEVtMXdiaEVQZG5EYnk1d2tZUWxaZTgrMHRHeE9rWG56VzRv?=
 =?utf-8?Q?ihgha1WArk6l2jAJCgzCB2L07hoe8U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGpYYmtBd1ZWS05MZlAyQlp1K25TLzhNQXhqNUdJbEw4SWRZeWhIejY0NFNN?=
 =?utf-8?B?TXRXYnRuY1NSOGdQaldVYTFldTRoR21LT3Q0dkxMM0F4RDNlRitYQTYraUQ5?=
 =?utf-8?B?VzRodEJrbUZjQ1luUFVkTDNCWU9SWGlXbUxhcXBxbUo2MUZEWUlaSGltNE12?=
 =?utf-8?B?QWJqMmx1ZEltVTBWYVptZEF1RXd6ZFpTelF5cWRSTlp5M09BSFVyT2U2ZGZw?=
 =?utf-8?B?S2dDWGtQZlA1dlZMaG53cUR6T3AvTmVhVmdlWDR5Nlo1WWlwNGVEMjM1NkxZ?=
 =?utf-8?B?Q2JEeHU1U0hZbUNQRWpOK2ZNV3RtUDFieHhWVGJHaytBK3lLZWtoemdyWjA4?=
 =?utf-8?B?NWhZTmhpQjZFcklCaDZGL3M1cFJ6SVA2RkJPYitpQUdtd0t5ZjRUYUZuR0pJ?=
 =?utf-8?B?ZVZRRnJZcGcxTFN3UzBXQmJBVnlJeCtrb1pqcnM3am9rcENqUStDS25JRHJ4?=
 =?utf-8?B?UklFVi9sK2thbDZCWE5MUXFsY2ZGcVMrWjEzTmJQSW5VanpWM2MwbjY3VGlu?=
 =?utf-8?B?aVBaamp3SWtJV0J6dHNIMWRuVTFadm9LaHZuNE8vSldSQ0JlWGxQVzUxUVJW?=
 =?utf-8?B?SjBQdFdJdnF6RzVUT0xLWWttRldtUEZNOGFVZUxzZVFZK2dsaTBkam5WcGll?=
 =?utf-8?B?WVNXaXl0U2ZlK09NS1ZXRWc3WmxVMnU0VXF1TmFLK25DU2lLT2VxTHNwazlQ?=
 =?utf-8?B?R0xnb2NSM1g3VGNqS2liUThINDRtOHJuMjI4UDBWZzJ0WFJzTUt5MTQvVGxz?=
 =?utf-8?B?Z3lvdkI5cmlOZ3VlcmxDQXkxV0IwT2FrOTBDUkwrSzRKSkhkVHdpNjhRazVC?=
 =?utf-8?B?eHFncGQ2Mm5tUkRkWUdaWHpoN0JBNkV6ODFxN25sVE5WdVRpbUpscjZuaDFW?=
 =?utf-8?B?bEFTeDd5cTdJUGNvT2p1d0FDekZIZCtlZDBwL1p2T1E4ZlorUGExVis2M2Ji?=
 =?utf-8?B?ZkZoZTcxeSs3MEJIL21SYmpqM3ZvVEtKVXNiWjU5VHpTanp5Qk5HUnRlUlpw?=
 =?utf-8?B?L0dGdS9aL1l2RTNncURkS0thZDBqQ1orN29YSmJqNko4TGt3elNCemo1R09I?=
 =?utf-8?B?QzN6L1Q3L3NjSGZVRVFEZmN0bTdDUXZzYVZNVmhwNUxqTDZJb1NOK0VvV2RQ?=
 =?utf-8?B?elVxVDM5VFNmeWZpQjJVSVZaZFhSWFU3YzJzWXhzNE1NZHA4RjhEMkZUaERD?=
 =?utf-8?B?Z3VRbm1kZ2RzbDB4ckZaZ1ErZHVmbzVKVzZiTEt3cWlPNXkrVytDMTd3WUlO?=
 =?utf-8?B?eDFXUmlYS0x2Q3VPSkd4RzFTMTJ6MXFaS2hyM0hiN0t2Q2Jvd2x4TjBKblBq?=
 =?utf-8?B?MTZmOER0d1BJaS94bXk0TzdpNGZYQXVKS3RXRzBCLzQwdExqbUFER3k4elFv?=
 =?utf-8?B?eUd4Q0xhQVduWlF5QTl0dFpQZHhVUmhCdThPdWdsZ3B6UWowYmJLT1NLQmRR?=
 =?utf-8?B?T0xZQWZzT21DUHpwMytQeER0TUlKZHNNYy8xbUkzOThJa1dKNVNxV0h3TFVM?=
 =?utf-8?B?bk1oL2VnNHh1bkNVLzJTN0JhUy9rREVhSkR3eEE0U294QkRxZTExL3p6cGZt?=
 =?utf-8?B?a2Q5WHQvbWJxdnJ1YURHbVlIdHBrNHExUVZ1R2o3cHgxcHcwajFjRTdZWDZt?=
 =?utf-8?B?dm1GOEhrcVFWcjBKK2JaQThLVHBBQ1JRVmdmeS81ZXJJYnVUL1N1R0VTOVNm?=
 =?utf-8?B?WkFVMFJqZHhSQWQ1VDFHOTFtM1hlQThLOWZhUjJwQUpUWFhVeTNLUzBoeklI?=
 =?utf-8?B?SURZaVpFOW5DODJaS3kvNkdvc0hnR201RlRSdkJyK2VjYkFpRlZ3S1Q2MEZm?=
 =?utf-8?B?MnZsZVFlY2VZQnZIbE5jSjVURkxtNzRGcG9nRFdrTEdIN2N0TVJFa0g4Rm44?=
 =?utf-8?B?bVdSYld6WnZBZTBNTnl0c2xZTGFDemxMVWZCeXJwMnMwTGVMS1lpU2hIRk00?=
 =?utf-8?B?ZzdaaW5vQzdMWmdGeWZPQ0xpRS9vM2I4YnB0VEFGTVc4WDViUUx5ak9nV1Vj?=
 =?utf-8?B?OWFZVGQzNDdSdlFtRGFrYnNHeUVQTGdVU1FUZE44cHZ3ZE1oVnhsVU50UTMz?=
 =?utf-8?B?TVFjR01kck44MHN0eTZ5N0lRVFQ4NElVNS9qem1Ub0l6cXR1Q25qQ2FhYjFW?=
 =?utf-8?Q?8gEzxfVgVePrecQxuSka5rJNm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc27c91b-de79-47a8-4122-08dd7025641e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 07:26:45.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNpF26Ij4SCyeVEuSEjjnzcrRNkT2CxtNyT8b2XV8UhOphQr7QPEAztnVc0AzxdvuK3lQ7ijrZ6vJH1kObhx1Cw++0wK7PDrvD6W5/64RGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8849
X-OriginatorOrg: intel.com

PiANCj4gT24gRnJpLCBNYXIgMjgsIDIwMjUgYXQgMDc6NTA6NDNQTSArMDIwMCwgSmFya2tvIFNh
a2tpbmVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgTWFyIDI4LCAyMDI1IGF0IDAyOjU3OjQxUE0gKzAy
MDAsIEVsZW5hIFJlc2hldG92YSB3cm90ZToNCj4gPiA+IFNHWCBhcmNoaXRlY3R1cmUgaW50cm9k
dWNlZCBhIG5ldyBpbnN0cnVjdGlvbiBjYWxsZWQgRVVQREFURVNWTg0KPiA+ID4gdG8gSWNlIExh
a2UuIEl0IGFsbG93cyB1cGRhdGluZyBzZWN1cml0eSBTVk4gdmVyc2lvbiwgZ2l2ZW4gdGhhdCBF
UEMNCj4gPiA+IGlzIGNvbXBsZXRlbHkgZW1wdHkuIFRoZSBsYXR0ZXIgaXMgcmVxdWlyZWQgZm9y
IHNlY3VyaXR5IHJlYXNvbnMNCj4gPiA+IGluIG9yZGVyIHRvIHJlYXNvbiB0aGF0IGVuY2xhdmUg
c2VjdXJpdHkgcG9zdHVyZSBpcyBhcyBzZWN1cmUgYXMgdGhlDQo+ID4gPiBzZWN1cml0eSBTVk4g
dmVyc2lvbiBvZiB0aGUgVENCIHRoYXQgY3JlYXRlZCBpdC4NCj4gPiA+DQo+ID4gPiBBZGRpdGlv
bmFsbHkgaXQgaXMgaW1wb3J0YW50IHRvIGVuc3VyZSB0aGF0IHdoaWxlIEVOQ0xTW0VVUERBVEVT
Vk5dDQo+ID4gPiBydW5zLCBubyBjb25jdXJyZW50IHBhZ2UgY3JlYXRpb24gaGFwcGVucyBpbiBF
UEMsIGJlY2F1c2UgaXQgbWlnaHQNCj4gPiA+IHJlc3VsdCBpbiAjR1AgZGVsaXZlcmVkIHRvIHRo
ZSBjcmVhdG9yLiBMZWdhY3kgU1cgbWlnaHQgbm90IGJlIHByZXBhcmVkDQo+ID4gPiB0byBoYW5k
bGUgc3VjaCB1bmV4cGVjdGVkICNHUHMgYW5kIHRoZXJlZm9yZSB0aGlzIHBhdGNoIGludHJvZHVj
ZXMNCj4gPiA+IGEgbG9ja2luZyBtZWNoYW5pc20gdG8gZW5zdXJlIG5vIGNvbmN1cnJlbnQgRVBD
IGFsbG9jYXRpb25zIGNhbiBoYXBwZW4uDQo+ID4gPg0KPiA+ID4gSXQgaXMgYWxzbyBlbnN1cmVk
IHRoYXQgRU5DTFNbRVVQREFURVNWTl0gaXMgbm90IGNhbGxlZCB3aGVuIHJ1bm5pbmcNCj4gPiA+
IGluIGEgVk0gc2luY2UgaXQgZG9lcyBub3QgaGF2ZSBhIG1lYW5pbmcgaW4gdGhpcyBjb250ZXh0
IChtaWNyb2NvZGUNCj4gPiA+IHVwZGF0ZXMgYXBwbGljYXRpb24gaXMgbGltaXRlZCB0byB0aGUg
aG9zdCBPUykgYW5kIHdpbGwgY3JlYXRlDQo+ID4gPiB1bm5lY2Vzc2FyeSBsb2FkLg0KPiA+ID4N
Cj4gPiA+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gcHJldmlvdXMgc3VibWlzaW9uIGJ5IENhdGh5
IFpoYW5nDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA1MjAxMDM5MDQu
MTIxNi0xLQ0KPiBjYXRoeS56aGFuZ0BpbnRlbC5jb20vDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogRWxlbmEgUmVzaGV0b3ZhIDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vc2d4LmggICAgICB8IDQxICsrKysrKysr
KysrKystLS0tLS0tLQ0KPiA+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2xzLmggfCAg
NiArKysrDQo+ID4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jICB8IDYzDQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gIGFyY2gveDg2L2tlcm5lbC9j
cHUvc2d4L3NneC5oICAgfCAgMSArDQo+ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA5NSBpbnNlcnRp
b25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vc2d4LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZ3guaA0KPiA+ID4g
aW5kZXggNmEwMDY5NzYxNTA4Li41Y2FmNWMzMWViYzYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9zZ3guaA0KPiA+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
c2d4LmgNCj4gPiA+IEBAIC0yNiwyMyArMjYsMjYgQEANCj4gPiA+ICAjZGVmaW5lIFNHWF9DUFVJ
RF9FUENfU0VDVElPTgkweDENCj4gPiA+ICAvKiBUaGUgYml0bWFzayBmb3IgdGhlIEVQQyBzZWN0
aW9uIHR5cGUuICovDQo+ID4gPiAgI2RlZmluZSBTR1hfQ1BVSURfRVBDX01BU0sJR0VOTUFTSygz
LCAwKQ0KPiA+ID4gKy8qIEVVUERBVEVTVk4gcHJlc2VuY2UgaW5kaWNhdGlvbiAqLw0KPiA+ID4g
KyNkZWZpbmUgU0dYX0NQVUlEX0VVUERBVEVTVk4JQklUKDEwKQ0KPiA+ID4NCj4gPiA+ICBlbnVt
IHNneF9lbmNsc19mdW5jdGlvbiB7DQo+ID4gPiAtCUVDUkVBVEUJPSAweDAwLA0KPiA+ID4gLQlF
QURECT0gMHgwMSwNCj4gPiA+IC0JRUlOSVQJPSAweDAyLA0KPiA+ID4gLQlFUkVNT1ZFCT0gMHgw
MywNCj4gPiA+IC0JRURHQlJECT0gMHgwNCwNCj4gPiA+IC0JRURHQldSCT0gMHgwNSwNCj4gPiA+
IC0JRUVYVEVORAk9IDB4MDYsDQo+ID4gPiAtCUVMRFUJPSAweDA4LA0KPiA+ID4gLQlFQkxPQ0sJ
PSAweDA5LA0KPiA+ID4gLQlFUEEJPSAweDBBLA0KPiA+ID4gLQlFV0IJPSAweDBCLA0KPiA+ID4g
LQlFVFJBQ0sJPSAweDBDLA0KPiA+ID4gLQlFQVVHCT0gMHgwRCwNCj4gPiA+IC0JRU1PRFBSCT0g
MHgwRSwNCj4gPiA+IC0JRU1PRFQJPSAweDBGLA0KPiA+ID4gKwlFQ1JFQVRFCQk9IDB4MDAsDQo+
ID4gPiArCUVBREQJCT0gMHgwMSwNCj4gPiA+ICsJRUlOSVQJCT0gMHgwMiwNCj4gPiA+ICsJRVJF
TU9WRQkJPSAweDAzLA0KPiA+ID4gKwlFREdCUkQJCT0gMHgwNCwNCj4gPiA+ICsJRURHQldSCQk9
IDB4MDUsDQo+ID4gPiArCUVFWFRFTkQJCT0gMHgwNiwNCj4gPiA+ICsJRUxEVQkJPSAweDA4LA0K
PiA+ID4gKwlFQkxPQ0sJCT0gMHgwOSwNCj4gPiA+ICsJRVBBCQk9IDB4MEEsDQo+ID4gPiArCUVX
QgkJPSAweDBCLA0KPiA+ID4gKwlFVFJBQ0sJCT0gMHgwQywNCj4gPiA+ICsJRUFVRwkJPSAweDBE
LA0KPiA+ID4gKwlFTU9EUFIJCT0gMHgwRSwNCj4gPiA+ICsJRU1PRFQJCT0gMHgwRiwNCj4gPiA+
ICsJRVVQREFURVNWTgk9IDB4MTgsDQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiAgLyoqDQo+ID4g
PiBAQCAtNzMsNiArNzYsMTEgQEAgZW51bSBzZ3hfZW5jbHNfZnVuY3Rpb24gew0KPiA+ID4gICAq
CQkJCXB1YmxpYyBrZXkgZG9lcyBub3QgbWF0Y2gNCj4gSUEzMl9TR1hMRVBVQktFWUhBU0guDQo+
ID4gPiAgICogJVNHWF9QQUdFX05PVF9NT0RJRklBQkxFOglUaGUgRVBDIHBhZ2UgY2Fubm90IGJl
IG1vZGlmaWVkDQo+IGJlY2F1c2UgaXQNCj4gPiA+ICAgKgkJCQlpcyBpbiB0aGUgUEVORElORyBv
ciBNT0RJRklFRCBzdGF0ZS4NCj4gPiA+ICsgKiAlU0dYX0lOU1VGRklDSUVOVF9FTlRST1BZOglJ
bnN1ZmZpY2llbnQgZW50cm9weSBpbiBSTkcuDQo+ID4gPiArICogJVNHWF9FUENfTk9UX1JFQURZ
OgkJRVBDIGlzIG5vdCByZWFkeSBmb3IgU1ZOIHVwZGF0ZS4NCj4gPiA+ICsgKiAlU0dYX05PX1VQ
REFURToJCUVVUERBVEVTVk4gd2FzIHN1Y2Nlc3NmdWwsIGJ1dA0KPiBDUFVTVk4gd2FzIG5vdA0K
PiA+ID4gKyAqCQkJCXVwZGF0ZWQgYmVjYXVzZSBjdXJyZW50IFNWTiB3YXMgbm90IG5ld2VyDQo+
IHRoYW4NCj4gPiA+ICsgKgkJCQlDUFVTVk4uDQo+ID4gPiAgICogJVNHWF9VTk1BU0tFRF9FVkVO
VDoJCUFuIHVubWFza2VkIGV2ZW50LCBlLmcuDQo+IElOVFIsIHdhcyByZWNlaXZlZA0KPiA+ID4g
ICAqLw0KPiA+ID4gIGVudW0gc2d4X3JldHVybl9jb2RlIHsNCj4gPiA+IEBAIC04MSw2ICs4OSw5
IEBAIGVudW0gc2d4X3JldHVybl9jb2RlIHsNCj4gPiA+ICAJU0dYX0NISUxEX1BSRVNFTlQJCT0g
MTMsDQo+ID4gPiAgCVNHWF9JTlZBTElEX0VJTklUVE9LRU4JCT0gMTYsDQo+ID4gPiAgCVNHWF9Q
QUdFX05PVF9NT0RJRklBQkxFCQk9IDIwLA0KPiA+ID4gKwlTR1hfSU5TVUZGSUNJRU5UX0VOVFJP
UFkJPSAyOSwNCj4gPiA+ICsJU0dYX0VQQ19OT1RfUkVBRFkJCT0gMzAsDQo+ID4gPiArCVNHWF9O
T19VUERBVEUJCQk9IDMxLA0KPiA+ID4gIAlTR1hfVU5NQVNLRURfRVZFTlQJCT0gMTI4LA0KPiA+
ID4gIH07DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4
L2VuY2xzLmgNCj4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lbmNscy5oDQo+ID4gPiBpbmRl
eCA5OTAwNGIwMmUyZWQuLjNkODNjNzZkYzkxZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvc2d4L2VuY2xzLmgNCj4gPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUv
c2d4L2VuY2xzLmgNCj4gPiA+IEBAIC0yMzMsNCArMjMzLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50
IF9fZWF1ZyhzdHJ1Y3Qgc2d4X3BhZ2VpbmZvDQo+ICpwZ2luZm8sIHZvaWQgKmFkZHIpDQo+ID4g
PiAgCXJldHVybiBfX2VuY2xzXzIoRUFVRywgcGdpbmZvLCBhZGRyKTsNCj4gPiA+ICB9DQo+ID4g
Pg0KPiA+ID4gKy8qIFVwZGF0ZSBDUFVTVk4gYXQgcnVudGltZS4gKi8NCj4gPiA+ICtzdGF0aWMg
aW5saW5lIGludCBfX2V1cGRhdGVzdm4odm9pZCkNCj4gPiA+ICt7DQo+ID4gPiArCXJldHVybiBf
X2VuY2xzX3JldF8xKEVVUERBVEVTVk4sICIiKTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAg
I2VuZGlmIC8qIF9YODZfRU5DTFNfSCAqLw0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvc2d4L21haW4uYw0KPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0K
PiA+ID4gaW5kZXggYjYxZDNiYWQwNDQ2Li4yNDU2MzExMDgxMWQgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMNCj4gPiA+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9jcHUvc2d4L21haW4uYw0KPiA+ID4gQEAgLTMyLDYgKzMyLDExIEBAIHN0YXRpYyBERUZJ
TkVfWEFSUkFZKHNneF9lcGNfYWRkcmVzc19zcGFjZSk7DQo+ID4gPiAgc3RhdGljIExJU1RfSEVB
RChzZ3hfYWN0aXZlX3BhZ2VfbGlzdCk7DQo+ID4gPiAgc3RhdGljIERFRklORV9TUElOTE9DSyhz
Z3hfcmVjbGFpbWVyX2xvY2spOw0KPiA+ID4NCj4gPiA+ICsvKiBUaGlzIGxvY2sgaXMgaGVsZCB0
byBwcmV2ZW50IG5ldyBFUEMgcGFnZXMgZnJvbSBiZWluZyBjcmVhdGVkDQo+ID4gPiArICogZHVy
aW5nIHRoZSBleGVjdXRpb24gb2YgRU5DTFNbRVVQREFURVNWTl0uDQo+ID4gPiArICovDQo+ID4g
PiArc3RhdGljIERFRklORV9TUElOTE9DSyhzZ3hfZXBjX2V1cGRhdGVzdm5fbG9jayk7DQo+ID4g
PiArDQo+ID4gPiAgc3RhdGljIGF0b21pY19sb25nX3Qgc2d4X25yX3VzZWRfcGFnZXMgPSBBVE9N
SUNfTE9OR19JTklUKDApOw0KPiA+ID4gIHN0YXRpYyB1bnNpZ25lZCBsb25nIHNneF9ucl90b3Rh
bF9wYWdlczsNCj4gPiA+DQo+ID4gPiBAQCAtNDU3LDcgKzQ2MiwxNyBAQCBzdGF0aWMgc3RydWN0
IHNneF9lcGNfcGFnZQ0KPiAqX19zZ3hfYWxsb2NfZXBjX3BhZ2VfZnJvbV9ub2RlKGludCBuaWQp
DQo+ID4gPiAgCXBhZ2UtPmZsYWdzID0gMDsNCj4gPiA+DQo+ID4gPiAgCXNwaW5fdW5sb2NrKCZu
b2RlLT5sb2NrKTsNCj4gPiA+IC0JYXRvbWljX2xvbmdfaW5jKCZzZ3hfbnJfdXNlZF9wYWdlcyk7
DQo+ID4gPiArDQo+ID4gPiArCWlmICghYXRvbWljX2xvbmdfaW5jX25vdF96ZXJvKCZzZ3hfbnJf
dXNlZF9wYWdlcykpIHsNCj4gPiA+ICsJCXNwaW5fbG9jaygmc2d4X2VwY19ldXBkYXRlc3ZuX2xv
Y2spOw0KPiA+ID4gKwkJLyogT25seSBjYWxsIHNneF91cGRhdGVzdm4oKSBvbmNlIHRoZSBmaXJz
dCBlbmNsYXZlJ3MNCj4gPiA+ICsJCSAqIHBhZ2UgaXMgYWxsb2NhdGVkIGZyb20gRVBDDQo+ID4g
PiArCQkgKi8NCj4gPiA+ICsJCWlmIChhdG9taWNfbG9uZ19yZWFkKCZzZ3hfbnJfdXNlZF9wYWdl
cykgPT0gMCkNCj4gPiA+ICsJCQlzZ3hfdXBkYXRlc3ZuKCk7DQo+ID4gPiArCQlhdG9taWNfbG9u
Z19pbmMoJnNneF9ucl91c2VkX3BhZ2VzKTsNCj4gPiA+ICsJCXNwaW5fdW5sb2NrKCZzZ3hfZXBj
X2V1cGRhdGVzdm5fbG9jayk7DQo+ID4gPiArCX0NCj4gPiA+DQo+ID4gPiAgCXJldHVybiBwYWdl
Ow0KPiA+ID4gIH0NCj4gPiA+IEBAIC05NzAsMyArOTg1LDQ5IEBAIHN0YXRpYyBpbnQgX19pbml0
IHNneF9pbml0KHZvaWQpDQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICBkZXZpY2VfaW5pdGNhbGwo
c2d4X2luaXQpOw0KPiA+ID4gKw0KPiA+ID4gKy8qKg0KPiA+ID4gKyAqIHNneF91cGRhdGVzdm4o
KSAtIElzc3VlIEVOQ0xTW0VVUERBVEVTVk5dDQo+ID4gPiArICogSWYgRVBDIGlzIHJlYWR5LCB0
aGlzIGluc3RydWN0aW9uIHdpbGwgdXBkYXRlIENQVVNWTiB0byB0aGUgY3VycmVudGx5DQo+ID4g
PiArICogbG9hZGVkIG1pY3JvY29kZSB1cGRhdGUgU1ZOIGFuZCBnZW5lcmF0ZSBuZXcgY3J5cHRv
Z3JhcGhpYyBhc3NldHMuDQo+ID4gPiArICovDQo+ID4gPiArdm9pZCBzZ3hfdXBkYXRlc3ZuKHZv
aWQpDQo+ID4gPiArew0KPiA+ID4gKwlpbnQgcmV0cnkgPSAxMDsNCj4gPiA+ICsJaW50IHJldDsN
Cj4gPiA+ICsNCj4gPiA+ICsJbG9ja2RlcF9hc3NlcnRfaGVsZCgmc2d4X2VwY19ldXBkYXRlc3Zu
X2xvY2spOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoIShjcHVpZF9lYXgoU0dYX0NQVUlEKSAmIFNH
WF9DUFVJRF9FVVBEQVRFU1ZOKSkNCj4gPiA+ICsJCXJldHVybjsNCj4gPiA+ICsNCj4gPiA+ICsJ
LyogRG8gbm90IGV4ZWN1dGUgRU5DTFNbRVVQREFURVNWTl0gaWYgcnVubmluZyBpbiBhIFZNIHNp
bmNlDQo+ID4gPiArCSAqIG1pY3JvY29kZSB1cGRhdGVzIGFyZSBvbmx5IG1lYW5pbmdmdWwgdG8g
YmUgYXBwbGllZCBvbiB0aGUgaG9zdC4NCj4gPiA+ICsJICovDQo+ID4gPiArCWlmIChib290X2Nw
dV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikpDQo+ID4gPiArCQlyZXR1cm47DQo+ID4gPiAr
DQo+ID4gPiArCWRvIHsNCj4gPiA+ICsJCXJldCA9IF9fZXVwZGF0ZXN2bigpOw0KPiA+ID4gKwkJ
aWYgKHJldCAhPSBTR1hfSU5TVUZGSUNJRU5UX0VOVFJPUFkpDQo+ID4gPiArCQkJYnJlYWs7DQo+
ID4gPiArDQo+ID4gPiArCX0gd2hpbGUgKC0tcmV0cnkpOw0KPiA+ID4gKw0KPiA+ID4gKwlzd2l0
Y2ggKHJldCkgew0KPiA+ID4gKwljYXNlIDA6DQo+ID4gPiArCQlwcl9pbmZvKCJFVVBEQVRFU1ZO
OiBzdWNjZXNzXG4iKTsNCj4gPiA+ICsJCWJyZWFrOw0KPiA+ID4gKwljYXNlIFNHWF9FUENfTk9U
X1JFQURZOg0KPiA+ID4gKwljYXNlIFNHWF9JTlNVRkZJQ0lFTlRfRU5UUk9QWToNCj4gPiA+ICsJ
Y2FzZSBTR1hfRVBDX1BBR0VfQ09ORkxJQ1Q6DQo+ID4gPiArCQlwcl9lcnIoIkVVUERBVEVTVk46
IGVycm9yICVkXG4iLCByZXQpOw0KPiA+ID4gKwkJYnJlYWs7DQo+ID4gPiArCWNhc2UgU0dYX05P
X1VQREFURToNCj4gPiA+ICsJCWJyZWFrOw0KPiA+ID4gKwlkZWZhdWx0Og0KPiA+ID4gKwkJcHJf
ZXJyKCJFVVBEQVRFU1ZOOiB1bmtub3duIGVycm9yICVkXG4iLCByZXQpOw0KPiA+ID4gKwkJYnJl
YWs7DQo+ID4gPiArCX0NCj4gPg0KPiA+IE92ZXJhbGwsIEkgdGhpbmsgeW91J3JlIHJpZ2h0IGlu
IHRoYXQgImludmVyc2lvbiIgZG9lcyBtYWtlIHNlbnNlLA0KPiA+IG5vdyB0aGF0IG90aGVyIHN0
dWZmIGlzIGJldHRlciBhbGlnbmVkLg0KPiA+DQo+ID4gQXQgbGVhc3Qgd2hlbiB0aGVyZSBpcyBz
cHVyaW91cyBlcnJvciwgSSB0aGluayBpb2N0bCdzIHNob3VsZCBzdG9wDQo+ID4gcmVzcG9uZGlu
ZyBhbmQgZHJpdmVyIHNob3VsZCBub3QgZG8gYW55dGhpbmcgdXNlZnVsIGFueW1vcmUuIEkuZS4s
DQo+ID4gaXQgc2hvdWxkIGdvIG91dC1vZi1zZXJ2aWNlLg0KPiA+DQo+ID4gSSBkb24ndCB0aGlu
ayB0aGUgZHJpdmVyIHNob3VsZCB0ZWFyLWRvd24sIGp1c3Qgc3RvcCBzZXJ2aWNpbmcNCj4gPiBW
TSdzIGFuZCByZXNwb25kaW5nIGlvY3RsJ3MuDQo+ID4NCj4gPiBQb3NzaWJseSB0aGlzaCBzaG91
bGQgYmUgYWxzbyByaWdodCBhY3Rpb24gZm9yIG90aGVyIGVycm9ycyB0aGFuDQo+ID4gImluc3Vm
ZmljaWVudCBlbnRyb3B5IiBidXQgSSdtIG9wZW4gZm9yIGNvbW1lbnRzIGZvciB0aGlzLg0KPiAN
Cj4gT3IgYWN0dWFsbHkgYWN0dWFsbHkgSSB0YWtlIG9uZSBzdGVwIGJhY2sgd2l0aCBteSBzdWdn
ZXN0aW9ucw0KPiBiZWNhdXNlIHRoaXMgcmVhbGx5IHNob3VsZCBiZSBhIHF1ZXN0aW9uIGZvciB3
aGljaCBJIGRvbid0IGhhdmUNCj4gdGhlIGRlZmluaXRpdmUgYW5zd2VyLg0KPiANCj4gVGhlIGN1
cnJlbnQgY29kZSB3b3JrcyBsaWtlIHRoaXM6IGlmIGFueXRoaW5nIHRoYXQgd2UgZG9uJ3QNCj4g
bGlrZSBoYXBwZW5zLCB3ZSByZS1pdGVyYXRlLg0KPiANCj4gU2hvdWxkIHNvbWUgb2YgdGhlICJl
eGNlcHRpb25hbCBjb25kaXRpb25zIiBoYXZlIGEgZGlmZmVyZW50DQo+IHJlY292ZXJ5IG9yIG5v
dD8NCg0KTm9uZSBvZiB0aGVzZSBleGNlcHRpb25hbCBjb25kaXRpb25zIGFyZSBmYXRhbCBvciBw
cmVzZW50IGFuDQppbW1lZGlhdGUgZGFuZ2VyIHRvIHRoZSBzeXN0ZW0gc2VjdXJpdHkuIFNvLCBh
bGxvd2luZyB0aGUgcmUtdHJpZXMNCnNlZW1zIGxvZ2ljYWwgaW4gdGhpcyBjYXNlLiBJbiBjYXNl
IHJlLXRyaWVzIGFsc28gZmFpbCwgdGhlIHN5c3RlbQ0KYWRtaW4gd2lsbCBoYXZlIGFuIG9wdGlv
biBvZiBncmFjZWZ1bGx5IHNodXR0aW5nIGRvd24gYWxsIGVuY2xhdmVzDQphbmQgZG9pbmcgZWl0
aGVyIGEgZnVsbCByZWJvb3QgKGlmIFNWTiBpcyB0aGUgb25seSBjb25jZXJuKSBvciBvdGhlcg0K
bmVjZXNzYXJ5IGFjdGlvbnMgbGlrZSB0YWtpbmcgdGhlIHBoeXNpY2FsIG5vZGUgb3V0IG9mIHVz
ZSwgZXRjLiANCg0KRG9lcyB0aGlzIHNvdW5kIHJlYXNvbmFibGU/IA0KDQpCZXN0IFJlZ2FyZHMs
DQpFbGVuYS4NCg0KDQo=

