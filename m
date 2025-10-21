Return-Path: <linux-kernel+bounces-863040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C090BF6D85
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3195840607E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1C338580;
	Tue, 21 Oct 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Byy4lXmI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC52F5492
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054171; cv=fail; b=Zy53ESCwjThGATveEDnrR95Cilt2pNVamq2C+Suurn9/4gJaKimnRrOMJ+lDxGpgzljfeEj+t2F26lpN9QGXIRDAI+3egoBEkD2bcU2MhWboFkmMujd4hAAwKejiuTJihislYZ8eoCVSL0QtMkn34ODDpiv3pPrzNGzhjYAifZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054171; c=relaxed/simple;
	bh=2tcl2YBWFwNzMT12CNnnwmjoLssTf5G+dGFEXnmZjpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mGS5wyarGVdxaynT/wKAmjLCald1+I4WkK/jyHTN+SxZI/FsiB5EUgSbhl8/8ki8GcvGHzCDAshSP7/G53CdJxO8N0RIllYe9rUGBj+LRZBxeRk5XUNYGs2oc7Amk7zRaBEKD3/bHK6htOWILRTQYV1yrcFhZpPF8OqrzvZH1do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Byy4lXmI; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761054170; x=1792590170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2tcl2YBWFwNzMT12CNnnwmjoLssTf5G+dGFEXnmZjpY=;
  b=Byy4lXmIxsxUkTK3C3+LriDCSPWr9E++5AwXi4Ka3vUDtxAvWQdkmU/N
   02Q7mIcyOKQj3Q4x2kuXDXA70XOkANnOoUNgK856PFJu9d48bsJI6IDAE
   T3lzPOw/oro16uf+97z8JRqai8J0Ke2ipLyVxedTKC96j8Z4ZO0XVCLd9
   edY1g3okV6/Z2mZf48ejh29MbHP4Esl6SCBdAB+0Q74letdTlMjJAeP+t
   eQp4vL3JdyFkHvbyBvr4FgJv9HiNHGh7fDzD2aYqB49AdUUSIVSfEOWxN
   y+ixXlFExZpQ3WjSMe5samapmVnxur+dw0VMTRqS59prI6S+rpudSfSI2
   A==;
X-CSE-ConnectionGUID: MIylD3a0TF2cj7b7tWMbPg==
X-CSE-MsgGUID: 856HdQwuQ+mfREaxYZChGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63083312"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63083312"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 06:42:49 -0700
X-CSE-ConnectionGUID: gDgBfVpuQquECuzBlIfn3w==
X-CSE-MsgGUID: 2tQpJzFeR4aWzkSLf96U7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="187999274"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 06:42:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 06:42:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 06:42:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 06:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8y26QUKYuMRrDrh6QG1CIYEbBmFA3N2ZAEYSVAWPkr/sSQ1v//335x4792cvhRIqwCtpJV6WfbeEmA3xTNgftPdRh2jfbULYjqA5FOVKcriOlqQ4uHbjx/IUtlcqtQo0Ww7dqrDI2e4zb88kb5Orntb8Z8KwbuxIIgUfFA4cZaI1t7VFZihD2l4zzPQMspc/8nZHoih3bFex3JPH9/dlnfeYRy9S+OVRBbcMT0naMUgr3Tu6lttZDnfT5q1XshRGj536EcdY21UWH2Ch9hXg/G8B/w2NXNlia2pyiWhDBFgTbbrirlp+MZNxoYijE6u02eLdmBN1dl91yWQNw5uJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tcl2YBWFwNzMT12CNnnwmjoLssTf5G+dGFEXnmZjpY=;
 b=Bt7OCoG5q2Mjq9LgaLL1L+Twx7AHFg53WSQzo7tPVqMl5nYkTybBZU76LkiGm6S/cKi0xDwYo8dbQCJdVE91xgOyv2pBwkLdasuDLbbVFnqz0pD66PPF15K4KpR2XKexvxhNtYX0xeesy6AQS2Lx7V2GSExC3wj6BvuU+rw07MGXSVD9kwe7zkyPy7BGnJ7mmR/vaawHv9RpvP0Qvuc+35/2rnwUxsFj5w0dModHX2YDkDnTZ59b0fwXLP2FOCO8FloMAqnIIIzSPXguYewYOJ8v1ZuiXMqSMy/uUQ9hl1aC03Lki1UYC8sWQgLOASOuSvXoQz9Pk2hEaU5XP7aJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 13:42:44 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 13:42:44 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "sagis@google.com"
	<sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov"
	<kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Topic: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Index: AQHcMn7PzLsl5dUPTEikD7KJ8NM7q7TB2pCAgAEhGdCAAGjNAIABBY7wgAC6+wCAARGC0IAA6VWAgAWa/pA=
Date: Tue, 21 Oct 2025 13:42:44 +0000
Message-ID: <IA1PR11MB9495DB84D36A4CE19894DD31E7F2A@IA1PR11MB9495.namprd11.prod.outlook.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
 <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
In-Reply-To: <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|DS0PR11MB7287:EE_
x-ms-office365-filtering-correlation-id: 1fa6a30a-c9b4-4e1c-5845-08de10a7b6c8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q0V1UFVrRUZvbHdkNnlZbWVXVC9IQXBlRGtOVjdiRjdycU9JS2RBUnovWm9y?=
 =?utf-8?B?REh2cXhFNERueXloWnQ5UlJQNitWMFZ4Y3lXYWxyVTVacm9lcU9EV3hneG1q?=
 =?utf-8?B?ZVJwU21saStTSjRubDBLTGRVUjhqWWlDSHE2VDd5aEpocFRuTFk2ak9CWWh2?=
 =?utf-8?B?Mk52azdOVGE1RVNCWXpRK1dzK2J6Z1pWQVhBQVo2RndOeTdja0hRQnlPWnBh?=
 =?utf-8?B?QVVMZklmWlNCcElyS2ZyalVRWVBRN3NUMjVTSXNxbUJ2QVlhNklZTFVFNDhY?=
 =?utf-8?B?WHE2bWF1ckxSb1UrdkhZS1kxTlZMT3JTeFRQQ0R3OHkxWEFES2RMTThYZjMy?=
 =?utf-8?B?THF0M3U2bzFjMjBIY1hpVm5xSmRCbzExb3JGQzBnMG9ScUNJc3dXdTlNRElE?=
 =?utf-8?B?RUllaWlCT2l4KzBlSnV2Y2c2M0J1SmQ3b2I5bnVnZWxsRU01QTRvVkRacU9v?=
 =?utf-8?B?R0xXMzhsMDhueFFWNEMzS0JvUno2OUNjWDg1Y0NuaDFKZVJ4Smt3WTZxVEpB?=
 =?utf-8?B?c1J6eERxN1VMbHo0V0hkVklpd1pJQ1M4S1JXQkRFRFY4Qm1zQWUzRlFXbGRI?=
 =?utf-8?B?WlJJc1JFLysrNitKVHByTDM1RGFya01oVkNOTWJvVlBjelJRcTNOZEYreEow?=
 =?utf-8?B?R2Z4ZFRqUVlCVlJLZHRmUERzLzRsdHVFc3hVaGZxT2xjRGRKMTFEVW5ZMUFq?=
 =?utf-8?B?eU1PczN4MU00ek5ZaE0ycVYyU0JMV21XSDZPV1l0NThIWjdHV0kxWGlkTzg5?=
 =?utf-8?B?V0ErdXRqUWdIOHRSVXZmZUozQ1FMTkQycDJ3UUN6cGZmQ21Cek9ieWljek1z?=
 =?utf-8?B?dkRQZ1ZhVXNsN3FQMDBMYStoNHVKSVdSTGtiYldNSXpMSmppaW5scDE2SENj?=
 =?utf-8?B?V3ZBNndSb09VZytjcDFVSS9IM0lHSHU3bkwwczZRcmJ5N0pWUHppUm1FSE1C?=
 =?utf-8?B?YTV4SmhnTGU5ajFQNDN3Vk1BNTFYNEVMSmFIZ1loMnI0Ri9lbkNETENTS2JT?=
 =?utf-8?B?aU5QNHhqRC9MeVh5K0hyNDhsYWtpRXgxekpPd2FSbXZUOTlBdTBzWUNVME1S?=
 =?utf-8?B?TUFsWGpoZmFoNWxOeXZaUVRIWmNFM3lwa1hrWjBVYS8vU1AwVFM1VXB2Ky9n?=
 =?utf-8?B?bENPSzhFdWxBZ005ejUzRG9FdnNPWUZaTmdidkd0T09FZ0hBWEptZjh1YWli?=
 =?utf-8?B?ZjhaejhqU3QvQU9waFlWbWRaRVBNbHZIZmdWQnpYOXpsREFKamZSL25UeGJu?=
 =?utf-8?B?MzZudVd5enVtNjcrY2VHUmY4L3Z5OFFKclpQTi9BZWNJUmovTkNJcWFuV2dC?=
 =?utf-8?B?TlBrSTlocjNmZFdMbDhuWWd2VkcrVlFIV1pPR0pjbjMzR1VsWk5TNTB3L3VZ?=
 =?utf-8?B?L1JKTHhjZVUyZEZ1WHBubUdvMUJMa0o2R2FTRWZlK1dCNXY1VVhFLzVHUDNW?=
 =?utf-8?B?TDNhdU1MWnJtYU9LcjA3WFk0OG5hVFRmTXI1Q1FDM0VZQmtiRVJDZ2JHNUpE?=
 =?utf-8?B?UUNCc09aeklXUklsaXhrVlR4czZsQi8wWWdRRGxHVmN6SzdIdnhHa3c3d0lu?=
 =?utf-8?B?U2pKYWQ0dzFzb2lnNyt2ZjB1T28za0p4eUNvZVpLbFVIWUNqZGwxT1ZSMVFr?=
 =?utf-8?B?allaOElpNHByLzNiZWYvQ29raGZRU2VsQzFaUzl1UWZwaE12R3FiNUd6QzlK?=
 =?utf-8?B?UjlkUVk0YlBtdmptM1YvdlhSR2Zub0xsa0NoOUx5R2hqOFpPSHVLYlZVTUtp?=
 =?utf-8?B?YWdrZGhxaFdhWTNEYWZyM25wNE54NVozSmlNRWFOYi9nWmFmcUs1c3huWnFj?=
 =?utf-8?B?eFVtaHd0YXVOYjdXM0U5U3MrUU4wTlFsa24vaFdEdGNqUDJudkFiTlhYcG9Q?=
 =?utf-8?B?ZThHN1hlMHA3UkluRGhKOWpRS015YUNaZUJBUmtwYkhZR0d0S1VyNjhkenBw?=
 =?utf-8?B?R05jWmh4aHVpTGE4SXpaMFhxclNaU2JYdTY3M3hZK1EvK29hcWRVQi9TY1Vm?=
 =?utf-8?B?Q0lrdWxPMm9aQS8zdm1ydWhVbkVlVEhManB0QW4vQ09FSDFKYjRzU1R0ZU1Y?=
 =?utf-8?Q?Fs40H8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2JybHNYMERRYmJyKzdLd1YybjdzdFZkL0xPTlViRVppSCtmWHZ4UmRsSnFM?=
 =?utf-8?B?ZDJLUTFoRVJ4Z083cWs2ZnN2RE5ISGhycFRaNm0xWHNzR0UrQ21FSXlub2Ft?=
 =?utf-8?B?YXYxVlhMT1dRRHFSdEhOSFI3R29EQzJqUGNKRE1LZjVtRm1Lbm4zSTdlUGw3?=
 =?utf-8?B?UkZmMXRZL0Q4R0swWTltbkdxck5mZ2IyNW0waVJ6M2tUeklnci9FcEhOUjFh?=
 =?utf-8?B?RWFjUmNhc29UQ1pZa1VuQzlKaVF0U3BWc0NXbFZ1YzJIdGp5OXRMR09zdWla?=
 =?utf-8?B?dVBCOE12MW96cnAzNzdNZ0xzR2xNblFjaHRmemxXT3ZxN1VmMFNIYjlWblBK?=
 =?utf-8?B?M2F0UE1oSCs1YVgxNXRLZGJWK3E3Q3Jyd01UMHZEWEE1ZW1kUGpzQ3FQR2F6?=
 =?utf-8?B?cGFxeGFSNVRNWHFsUXQzVlVRVGRXUWIyVHNOOEpiNzdmekFNMDhVOFFFcGlC?=
 =?utf-8?B?eUZJT1RnNFlabmRoSFp3UjhGUWhoRWJjSjk3M2FEdVk3cG1tUEl0TjZYNDJB?=
 =?utf-8?B?dHJZLzdZaElxM0RaSGxZRFhTbDZmbEx0RGlYbHVIQy9CMlVaVnpXU25aUGY2?=
 =?utf-8?B?QXBDQlFEMzNIdmx4Y3FvWXhnbFduNElTUzdWSXp2cGh1MHE0Yy84QnFybFYx?=
 =?utf-8?B?Y3FxdFhDd1VUSGhBaVlwcFdzK3lyekhGc1VxUE5KR3ZuRmduWFRJNTdZQ0Vo?=
 =?utf-8?B?RENHNktiNHdvVnNuZi9oZ1VHdkVscnZTZGV2YitZTUR1SWZnNjB3dFJJbTlJ?=
 =?utf-8?B?MFBXbCtXYmR0ZFBORWZmV0JNR2laN2VaYkNPRlEzMmc5UU9DVzJEdS9BZnZI?=
 =?utf-8?B?T2VGQkFteTF2OGs2S1dzR1F3bWY5Umk3VnYyN1A3VC8zdUdVTDhyd0xlcFVI?=
 =?utf-8?B?aVdQV2xTSG1yaEw1aDdscWFZeTVXdHJ5bDJLMFZIblFFMmpCakx6N0U5S1Rs?=
 =?utf-8?B?NnZaY1V6Nk1WSmE4eGUzeGRVaTRWYkdmcG5OeGRyRENZbnp0TmwwdEdHK0NM?=
 =?utf-8?B?N0RkandXN21wM3hpc0tXdzBWZ2lNMHFVeU8vbzVMSFdWYnpHWjZlcFZOSTNm?=
 =?utf-8?B?bjA3dFM1YmNBV2dBbjJ1VkFGbCtaclJnclJUMUFTT1ZEdnlQR1RmYnI2akpj?=
 =?utf-8?B?VWNEdnpmRGdwKzhlbTJNSm9xQnUxYWNxMy9QVDk5cEpjQnNlQlZxdkc4dXMy?=
 =?utf-8?B?SXp0YytWK0piczY5QVVTaGVXcFQ1aTNPZkFWdHJPa2VJenZ2RkJxa2x1VlhT?=
 =?utf-8?B?dFVocDN3S3hRcGtkOEpFdGhmdFRjcFNUQVhHQ1NtS3lJdEVmckJCNVFuUFo0?=
 =?utf-8?B?dkxIazNsRTlRcGlxdmxDWGdoSE9menJwa2UwbGlNV01YSTg0a00vUXdaS1cy?=
 =?utf-8?B?U0cwcityQW9kSGlDdktwU0dzZmFXdnBsZXlZMUUwcTRSUUxDSko4ZXRzSHF0?=
 =?utf-8?B?YWNGd1pJT1NMOUVPMU1lR3laZWJYUUJZbFV0TUdUNjQ0MlBsUUxabWRiaFgv?=
 =?utf-8?B?KzBFTG44WmpuRGhjOW54OExVSllxOHhZZWsrT3RsUWNEVzhsWGdpQ3lVcDdZ?=
 =?utf-8?B?d253NlRMSnJZSXRSTS9DdTZpSnByZlpkS3c4eHFDN2U5YnZkZEYwb2dGUmtw?=
 =?utf-8?B?RDM4bFZoWUZ4a2NGRkZtZURzME5oTEdpUkhXa2lIR0FEQ0tCOHIvbURDS3pG?=
 =?utf-8?B?TlhTa1VyWjNyVjVTZXdjZ2x1V3NXWXNRUUN5Znh0WWcySVBPL2xPeGQzbGRC?=
 =?utf-8?B?N0wzbVlMUytqKzl5eE9PWjJxaHhyYkV5RzR1V3pZRmxRODNQS2NvaFRGSlVq?=
 =?utf-8?B?SEVyUUQ2M2xxTURveS9mN1h1Szd2cHV5a2R2RnNLMzlwVExzRXZQL1VCRlA2?=
 =?utf-8?B?Z0JENjBrWERXWmhUVi9NbDlFYU1wK2g5OWtOTFNOeW9JTUdHOFRTRGQ3VXdU?=
 =?utf-8?B?M2FZbS9JWkh5S0V5aEd6K1ZlWWtQVkNiYnltUnM3ZTBHRUNlaythMmN3TnJ3?=
 =?utf-8?B?WEhtVWFmM1FHRnZBM1dCcXhiUEtIL0tsc0NHbkNncHhmazJaYTdwZ0p2QXBL?=
 =?utf-8?B?dDk0alZmRVN3cUhqV1NXVllGSHI4VUtUcXh3UUJhU3ZkV3dhMi83MERJblF4?=
 =?utf-8?B?ZXFnV3lNa092eFJHblFtVkFiM3VTRjFIS0FGcVR5T3Q2ampnQVcxQXQ5dHJ0?=
 =?utf-8?Q?OA5aDRD99cDRQwe+EqSt4QuU5g4vokZxGmI3Vn/WNORF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa6a30a-c9b4-4e1c-5845-08de10a7b6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 13:42:44.5147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iM6BZ7HJiGlL4/WXn/rQuTMsjSbuZ5ifIfpsTvdvGpRz024KnwPT7XJrwMGa5qNmJeJ5dzmgTaO34oIBkR66mDM7h7nFr4DBKbREy6zhm24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlzaGFsIEFubmFwdXJ2
ZSA8dmFubmFwdXJ2ZUBnb29nbGUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxOCwg
MjAyNSAzOjAyIEFNDQo+IFRvOiBSZXNoZXRvdmEsIEVsZW5hIDxlbGVuYS5yZXNoZXRvdmFAaW50
ZWwuY29tPg0KPiBDYzogSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBHYW8s
IENoYW8NCj4gPGNoYW8uZ2FvQGludGVsLmNvbT47IGxpbnV4LWNvY29AbGlzdHMubGludXguZGV2
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7IENoYXRy
ZSwgUmVpbmV0dGUNCj4gPHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+OyBXZWlueSwgSXJhIDxp
cmEud2VpbnlAaW50ZWwuY29tPjsgSHVhbmcsIEthaQ0KPiA8a2FpLmh1YW5nQGludGVsLmNvbT47
IFdpbGxpYW1zLCBEYW4gSiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsNCj4geWlsdW4ueHVA
bGludXguaW50ZWwuY29tOyBzYWdpc0Bnb29nbGUuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7DQo+
IG5pay5ib3Jpc292QHN1c2UuY29tOyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IERh
dmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+OyBILiBQZXRlciBBbnZp
biA8aHBhQHp5dG9yLmNvbT47IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgS2ly
aWxsIEEuIFNodXRlbW92IDxrYXNAa2VybmVsLm9yZz47IFBhb2xvIEJvbnppbmkNCj4gPHBib256
aW5pQHJlZGhhdC5jb20+OyBFZGdlY29tYmUsIFJpY2sgUCA8cmljay5wLmVkZ2Vjb21iZUBpbnRl
bC5jb20+Ow0KPiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAwMC8yMV0gUnVudGltZSBURFggTW9kdWxlIHVwZGF0ZSBzdXBwb3J0
DQo+IA0KPiBPbiBGcmksIE9jdCAxNywgMjAyNSBhdCAzOjA44oCvQU0gUmVzaGV0b3ZhLCBFbGVu
YQ0KPiA8ZWxlbmEucmVzaGV0b3ZhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4g
PiA+IC4uLg0KPiA+ID4gPiA+ID4gQnV0IHRoZSBzaXR1YXRpb24gY2FuIGJlIGF2b2lkZWQgZnVs
bHksIGlmIFREIHByZXNlcnZpbmcgdXBkYXRlIGlzIG5vdA0KPiA+ID4gPiA+IGNvbmR1Y3RlZA0K
PiA+ID4gPiA+ID4gZHVyaW5nIHRoZSBURCBidWlsZCB0aW1lLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gU3VyZSwgYW5kIHRoZSBURFggbW9kdWxlIGl0c2VsZiBjb3VsZCBndWFyYW50ZWUgdGhpcyBh
cyB3ZWxsIGFzIG11Y2ggYXMNCj4gPiA+ID4gPiB0aGUga2VybmVsIGNvdWxkLiBJdCBjb3VsZCBk
ZWNsaW5lIHRvIGFsbG93IG1vZHVsZSB1cGRhdGVzIGR1cmluZyBURA0KPiA+ID4gPiA+IGJ1aWxk
cywgb3IgZXJyb3Igb3V0IHRoZSBURCBidWlsZCBpZiBpdCBjb2xsaWRlcyB3aXRoIGFuIHVwZGF0
ZS4NCj4gPiA+ID4NCj4gPiA+ID4gVERYIG1vZHVsZSBoYXMgYSBmdW5jdGlvbmFsaXR5IHRvIGRl
Y2xpbmUgZ29pbmcgaW50byBTSFVURE9XTiBzdGF0ZQ0KPiA+ID4gPiAocHJlLXJlcXVpc2l0ZSBm
b3IgVEQgcHJlc2VydmluZyB1cGRhdGUpIGlmIFREIGJ1aWxkIG9yIGFueSBwcm9ibGVtYXRpYw0K
PiA+ID4gPiBvcGVyYXRpb24gaXMgaW4gcHJvZ3Jlc3MuIEl0IHJlcXVpcmVzIFZNTSB0byBvcHQt
aW4gaW50byB0aGlzIGZlYXR1cmUuDQo+ID4gPg0KPiA+ID4gSXMgdGhpcyBvcHQtaW4gZW5hYmxl
ZCBhcyBwYXJ0IG9mIHRoaXMgc2VyaWVzPyBJZiBub3QsIHdoYXQgaXMgdGhlDQo+ID4gPiBtZWNo
YW5pc20gdG8gZW5hYmxlIHRoaXMgb3B0LWluPw0KPiA+DQo+ID4gRm9yIHRoZSBpbmZvcm1hdGlv
biBhYm91dCBob3cgaXQgd29ya3Mgb24gVERYIG1vZHVsZSBzaWRlLA0KPiA+IHBsZWFzZSBjb25z
dWx0IHRoZSBsYXRlc3QgQUJJIHNwZWMsIGRlZmluaXRpb24gb2YgVERILlNZUy5TSFVURE9XTiBs
ZWFmLA0KPiA+IHBhZ2UgMzIxOg0KPiA+IGh0dHBzOi8vY2RyZHYyLmludGVsLmNvbS92MS9kbC9n
ZXRDb250ZW50LzczMzU3OQ0KPiA+DQo+IA0KPiBUaGFua3MgRWxlbmEuIFNob3VsZCB0aGUgcGF0
Y2ggWzFdIGZyb20gdGhpcyBzZXJpZXMgYmUgbW9kaWZpZWQgdG8NCj4gaGFuZGxlIHRoZSBURFgg
bW9kdWxlIHNodXRkb3duIGFzIHBlcjoNCj4gIklmIHN1cHBvcnRlZCBieSB0aGUgVERYIE1vZHVs
ZSwgdGhlIGhvc3QgVk1NIGNhbiBzZXQgdGhlDQo+IEFWT0lEX0NPTVBBVF9TRU5TSVRJVkUgZmxh
ZyB0byByZXF1ZXN0IHRoZSBURFggTW9kdWxlIHRvIGZhaWwNCj4gVERILlNZUy5VUERBVEUgaWYg
YW55IG9mIHRoZSBURHMgYXJlIGN1cnJlbnRseSBpbiBhIHN0YXRlIHRoYXQgaXMNCj4gaW1wYWN0
ZWQgYnkgdGhlIHVwZGF0ZS1zZW5zaXRpdmUgY2FzZXMiDQo+IA0KPiBUaGUgZG9jdW1lbnRhdGlv
biBiZWxvdyBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gbWU6DQo+ICJUaGUgY29tcGF0aWJpbGl0eSBj
aGVja3MgZG9uZSBieSBUREguU1lTLlVQREFURSBkbyBub3QgaW5jbHVkZSB0aGUNCj4gZm9sbG93
aW5nIGNhc2VzOg0KPiAqIElmIGFueSBURCB3YXMgaW5pdGlhbGl6ZWQgYnkgYW4gb2xkZXIgVERY
IE1vZHVsZSB0aGF0IGRpZCBlbnVtZXJhdGUNCj4gVERYX0ZFQVRVUkVTMC5VUERBVEVfQ09NUEFU
SUJMSVRZIGFzIDEsIFRESC5TWVMuU0hVVERPV04gZG9lcyBub3QNCj4gY2hlY2sgZm9yIGEgVEQg
YnVpbGQgaW4gcHJvZ3Jlc3MgY29uZGl0aW9uIGZvciB0aGF0IFRELg0KPiAqIElmIGFueSBURCBt
aWdyYXRpb24gc2Vzc2lvbiBpcyBpbiBwcm9ncmVzcywgaXQgd2FzIGluaXRpYWxpemVkIGJ5IGFu
DQo+IG9sZGVyIFREWCBNb2R1bGUgdGhhdCBkaWQgZW51bWVyYXRlIFREWF9GRUFUVVJFUzAuVVBE
QVRFX0NPTVBBVElCTElUWQ0KPiBhcyAxIg0KPiANCj4gV2FzIGl0IHN1cHBvc2VkIHRvIHNheSBi
ZWxvdz8NCj4gIklmIGFueSBURCB3YXMgaW5pdGlhbGl6ZWQgYnkgYW4gb2xkZXIgVERYIE1vZHVs
ZSB0aGF0IGRpZCBlbnVtZXJhdGUNCj4gVERYX0ZFQVRVUkVTMC5VUERBVEVfQ09NUEFUSUJMSVRZ
IGFzIDAsIFRESC5TWVMuU0hVVERPV04gZG9lcyBub3QNCg0KWWVzLCB0aGUgc3BlYyBlcnJvciwg
dGhhbmsgeW91IGZvciBjYXRjaGluZyB0aGlzLiBXaWxsIGJlIGZpeGVkLiANClRoZSBjb3JyZWN0
IHRleHQgc2hvdWxkIHNheToNCg0KIiBJZiBhbnkgVEQgd2FzIGluaXRpYWxpemVkIGJ5IGFuIG9s
ZGVyIFREWCBNb2R1bGUgdGhhdCBkaWQgKm5vdCogZW51bWVyYXRlDQpURFhfRkVBVFVSRVMwLlVQ
REFURV9DT01QQVRJQkxJVFkgYXMgMSwgVERILlNZUy5TSFVURE9XTiBkb2VzDQpub3QgY2hlY2sg
Zm9yIGEgVEQgYnVpbGQgaW4gcHJvZ3Jlc3MgY29uZGl0aW9uIGZvciB0aGF0IFRELg0KSWYgYW55
IFREIG1pZ3JhdGlvbiBzZXNzaW9uIGlzIGluIHByb2dyZXNzLCBhbmQgaXQgd2FzIGluaXRpYWxp
emVkIGJ5IGFuIG9sZGVyDQpURFggTW9kdWxlIHRoYXQgZGlkICpub3QqIGVudW1lcmF0ZSBURFhf
RkVBVFVSRVMwLlVQREFURV9DT01QQVRJQkxJVFkgYXMgMSwNClRESC5TWVMuU0hVVERPV04gZG9l
cyBub3QgY2hlY2sgZm9yIGFuIGludGVycnVwdGVkIFREIG1pZ3JhdGlvbiBmdW5jdGlvbg0KY29u
ZGl0aW9uIGZvciB0aGF0IFRELiINCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=

