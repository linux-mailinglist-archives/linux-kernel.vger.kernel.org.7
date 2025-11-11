Return-Path: <linux-kernel+bounces-894473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF51C4AFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F31144EBB34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE16F32BF43;
	Tue, 11 Nov 2025 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcNwT12g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124BF3126A1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825250; cv=fail; b=qgCq992EOF+xagra9Zl+FVZuknkeW991y63/Q3FIM0DPK/22xYyhWG7d2IBIcGQSHf/1Z6Ki63GtD2CSVCgQHCE0W+JT+H/u7C7SAbGeJTLkEzbxvhgJz7stpiojXLlJlKnjZKXRi5HE1e8vkQY/2+tFN3QpdSiCPtuJsC47ZW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825250; c=relaxed/simple;
	bh=CvZG9xVgO0hRD1dt8tNeIt+4g7NARMvG7CBbiHvy+ZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p/52EaBiHqqc7tWH4Betvdzdai66q42JKMtP4ZAzJiBerFmWaK9CaOT0AVF9xTbVDXr3M8zye3F0ExF7A8fjZvguebRaK9gDcxxyON5TUNemdOijFwqzaBMXmuHxur/8mNBNKuPizYvA+dqryrQ7TEpBswlmV8COKNHRw7NgvuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcNwT12g; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762825249; x=1794361249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CvZG9xVgO0hRD1dt8tNeIt+4g7NARMvG7CBbiHvy+ZE=;
  b=EcNwT12g4Wm91xWrL+LVjbfosW0309nXlbfPms2u9nT7EC3vTxq7VomX
   c8nXJPxfM+IwOV8i/S7T1N04nlq2kMFBQQ/KbZH2PCkkpx5JZkkfsB9bZ
   L8NIZTGINJlclkAEc+mie+MqjXFlqd0xHchHQ4EnjNPNv0U1XRe9ND9kb
   q5xpuRimRe7f9wkpXbV3OvOLDN5lrzW8eRMcgrVZL8bLk1v7gTnHnhj9Z
   P+QFlqbq0jzpZEhss8L4pmKctpXoS82w3l0OfQ6rVudLQgvVeP4sUYCwz
   yCvMY/IQ4oapFTcPkNhjQHNwdbH59qYTLR2VU/AfV18MOoLSK+iKvV5r5
   g==;
X-CSE-ConnectionGUID: QtDy9LxZT2WiXVLDjqp64A==
X-CSE-MsgGUID: PCmCLlAUR9id4oR7Cyg4MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64090167"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="64090167"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 17:40:48 -0800
X-CSE-ConnectionGUID: Vc945sIPRNWy7ML7h491Jg==
X-CSE-MsgGUID: NxE3Vq+mSaWhzzxqF64KcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189079690"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 17:40:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 17:40:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 17:40:47 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 17:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs/Siepk3H5mhEoYkqWd05gN3ou5+bK2Xqu0eaxKEy16gUVIIm+ytSKdnebxxam19tHQZ/irEIqLMgoMWXr4jrBsmWy4zDzzvC/UI+X924ln9m82ip2l5br8b+UEc6NdLKcDsjrijZviRiaHpBquDj9FDCioHu+r05ve6aik5Cx6enzDv5us1qafeVRuCXpgYT12XY3kHJrOAaogoPY+QSmcSt1LiT5STBQMgZ8fJRRAVAGGClOxRSUahJGjmVRIBO8DQ/u0egeNnm5y9ECgLOywEvOdJAVdprH0Al23Gs8ezIn3xYfrtZ9xMoTbQHOE4GwH3vlnIQHk0tkCCyxeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvZG9xVgO0hRD1dt8tNeIt+4g7NARMvG7CBbiHvy+ZE=;
 b=yIn3Ys95o/l9bxKpgLw6xMA1kuPYXIYKKZ/q4HMAhGzrx8gqF5iwhLWEMv32zmMCl5OvQ7bRqOOiAuM/j5Gx8GrNEJxiJ1p+sK7ox6aSCv3Ng0xccRHsapY5ETHa4Nr+uCnQyp4oJRqTribbedbpR/0RxlUIc2K3YVacZxBVbnALwYIqFmr/gALJa3Q0Vni6X2I1+upmKpYRoNxXhm42Ah5M5VUdHcky4hoDTslr33avixgcEm7j8Ss6tMPdTiNowqaO0iksx5NRb3MtRbMwPVIhQ67+AmvGTwsSlKLWLX9CHGW/wrpMVtuZ9G1YjAuG6EAEEEROocIHPN4vneeh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:40:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 01:40:45 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Aaron Tomlin
	<atomlin@atomlin.com>, Babu Moger <bmoger@amd.com>
CC: "Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "babu.moger@amd.com" <babu.moger@amd.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Thread-Topic: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Thread-Index: AQHcT4VCMZzJIaIcpEO5HF/nc2I90rTnxWyAgAAGSYCAAAv9gIAAFBMAgAQ1DACAAIf5AIAAAPNggAAEdgCAAAihsA==
Date: Tue, 11 Nov 2025 01:40:45 +0000
Message-ID: <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
 <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
In-Reply-To: <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7204:EE_
x-ms-office365-filtering-correlation-id: 7b3919f4-5df4-40ba-53b4-08de20c35562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?alZNdFBBb2dyNldiWDRrTVJ3WW5maGFheEZXNXZ4Z3BqMko2cHJ3QisyMk04?=
 =?utf-8?B?bStDSGM3Um9sTUtYUUlHdnpkUzRMaEFlU09ZejMrc0dseWhuRk5XT1lITFlp?=
 =?utf-8?B?UmR2VzhOYlVNelRVWDhMRUVGL1c2bEE1OW9aVkdDQWlESy9yRmxnb1FHMCt6?=
 =?utf-8?B?a1FkNTZNOTVjWW83VXllOEZhTy9QN1pCU1VKOTdLNUdqOVM2UDlOOVZ0MHVE?=
 =?utf-8?B?bkZJT1pFbmFEL0hXMCtpRmxoVGpnWUYydE02VGpuVytGdkt2blE0YXpiWnZN?=
 =?utf-8?B?K1p6KzlIeDM1cTlqVEV2TjdrQU50dVJJZ0ZraVhlNHhVTEZRQjVMKzBZcTZZ?=
 =?utf-8?B?M05OSlJkWFArTytROWd0aEg0WVVXQ205VFpKelYzYkdwWkIzVXdyaUtydElK?=
 =?utf-8?B?VFZrVTZITTlkSkFwV283Z1RSQXBQaHZaaXA3NGVCQysyRm5uYVlET2l5MWhS?=
 =?utf-8?B?UVZKMGVnWXNJcUMwb1VidVpyYzFWNFZXYjloM3ZPSnNWVnVXeFNMM1ZLU3lT?=
 =?utf-8?B?dkgxZER2aWFEaXRmbW9tb05FL1hOdUhOUHV6OTJvVGhtNDJPNnZCQ29IYVR1?=
 =?utf-8?B?c3ZvckYzNWxNS0NxRWRoaklXYnllZytENjRkaVlHOVVoZGlQYm01R0d2REpa?=
 =?utf-8?B?TVBTVEZzSVkzc25kOVJuRXZnTDh2N2Jnd3YwZ2o0QnZaeXdwNG9OWjNUQUJ0?=
 =?utf-8?B?cmVxNDhZS2I2enJOeENwT1hOa1pXdFBVOWRoZkxPWjI4TEovSEwyOW5DaytB?=
 =?utf-8?B?ek9pMGF3NEhvL0lUSFRTVXpPTDVrREhYQ0xOeXYySmM5RTYvdWI0M0N1OVh0?=
 =?utf-8?B?WFZnMGo5a3ducXdzN0x4Q3Rnb0hvWnl0dG5IU1VHM09QR2dIUDgva2pDZGRx?=
 =?utf-8?B?ZnJ1eVlIanRQNG93a05LYmhSaHZHVXVHbmZnbjlQeDBhemJmdTJjVW5jaHVU?=
 =?utf-8?B?QVQrdkFMTUtvbDA3cDJ2YTlhWmhWNnFUMmJvMFErNkFMSEFQUHFRTldBV1p4?=
 =?utf-8?B?VHBjWG56OWw5TVBqb2o3RUZnMXFhai9XV25rMjdmRTZMNTBWY2hFVGVsamJ4?=
 =?utf-8?B?ZkMwY3JsV2IvQ1VlS2MxTElKK243M3pBeWhZVXJ0VTNlbURjZEV2S09MMVhR?=
 =?utf-8?B?ODltNEpLeW80VXNLWEFVOHcrU2EzMjJQWG10azlTemgwTDIyZ09JdFhQelFT?=
 =?utf-8?B?Ylg3OGtOL2J3RG4wbzRjekE1eG1xMGJ1d2pXTTlwcDRxNmdZdEEzT0h0SVJ3?=
 =?utf-8?B?VEhoeE9WTnViOFREeHZsb2FOTGlZcGFaNlZ4VWhuc0pGSG03QVZOYW1SSkVz?=
 =?utf-8?B?SHVIeklxd0xYejNyblhXTFp0Nm42VUl5Sm9uRDhOOHEwQ0Z2djgvTnpNa0ZT?=
 =?utf-8?B?dHVDREVsZnpHd0EyZzl3UEwyL2ZQelVYWmNJaGFEeXpGTGE5Q1E2VkoveFdJ?=
 =?utf-8?B?U3hWZnRnQnhaSkJGT0hUZk9tdnI4ck1neHFoYVdyTFhmQUgvS3ZneVdFQ0p3?=
 =?utf-8?B?cnFDOFlxZEZDQU8rRTl4TGU3d2RjaHlxMDR1dUhtd2ZOSkVWQVRUQzkrWjB2?=
 =?utf-8?B?QTJXRzl0ZDBiaG5rQjBjRmxtTnhOWU1GSDVhZVRGUmM0KytmcGhLM0VTN2VV?=
 =?utf-8?B?MGIrY0FCTGZsbEp6a0NaU091TkxybEtpVlc0YUlFL0t3UlJGRjhSV1VrYTRV?=
 =?utf-8?B?ako4dFFLc3Izd01ueFdJWTBBMkRKV2dHWnZlYnNTWlpyMngyUE11WXFCaHlB?=
 =?utf-8?B?U2FoaU83ZjVtaGUzMms4bUNqdXBDQ1VtKzRSNStGSkpyNmg5OW5hVFJBd3pm?=
 =?utf-8?B?enMzTFdvV3ptbkRVNnE2MTZxSjExQThvMFIveFV6cHRQYVNNUWFFWVQyR2Zv?=
 =?utf-8?B?K2VNd0pRbnVoSWhndU9iaUMwUHpTclV2M1pTQzhUblBQRGRuM3FTbDZjTkFu?=
 =?utf-8?B?U1U5K2ZHakxtem10QlB4UzJHY3ZGZmVUSnJtT1h4WU5yMjZ1QmFURFBBMGZ5?=
 =?utf-8?B?MlIzbWJQaGZJV09ub0REaGZld2svS2JpOFJ5S0FnV09OeEFXcFlRMmMwSEhJ?=
 =?utf-8?Q?dLeW1X?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUMxKzJIVHNVYzNtQW9uM2VFc1lLcU1jTm55cnRneDdJVmpTMFRYMS9ZTXc0?=
 =?utf-8?B?RkhncTNwYmdIYkRxK0ZzeVdZdE5zUVNxNGJpNXlnOGxzSnhGR2pCSjJPeDJl?=
 =?utf-8?B?M0YwNDhkWW03dElXMnVuNlJUb1VYQTRaRjBla0NaMVlsU1FhQm1XSU0xai9o?=
 =?utf-8?B?RkZJRy81QlRlellkS210Uk5hWUUzM0RKbjhRT3dubzlGalJzaDVUb0g0Y3dW?=
 =?utf-8?B?M1FWc0VWR3dhUVBQcDRvSlF3bXhZZ1VpbVFsbVNyeEFaVjNPSUJvQWF3S3R5?=
 =?utf-8?B?U2lnaUFoYVNtNFZBSDBWbUdpOTJGZTdWNVhKcFJURytBWkF1ejFOc2RMdFUv?=
 =?utf-8?B?OHl1eEsralMyWnZ4MEI3NVlza3JMbktKZFFVZWFia2RkMW9ORXBzcUN0TExO?=
 =?utf-8?B?Y3pwVE9Xdy9jN3AzU3llempKU2xLR3FyRTJIbEF0TndieG5acGJ5dTl4dkNS?=
 =?utf-8?B?TWxYdzc4Z1lRSitmcXZraE85QTI5Sm9oREtTVVVIRGtTU0kzN2dGdXJjaTRo?=
 =?utf-8?B?NnZaMlM3ck9PLzlmYTVlWnF4eTR1dXRyc3J2WmlVbWdsNDlYZVQ4elpUU1F3?=
 =?utf-8?B?amNnSzhmcC9NZGpncksyUi9MUkJvYVVSTFMrMm45WkZKcGFtT0w4YVFFQ0tK?=
 =?utf-8?B?R2dUaGN3ZUVocThycHBYT0piclc5dEovVG96ZmRYaCttaElQSkpJUXVKREpw?=
 =?utf-8?B?UTZmMXhrNUdSVlQ1L2VxUk9EWXdyM1AxNmM0Y2p5SU50enI5V0dwY29rNXJr?=
 =?utf-8?B?WmFFK2NVc0ZYemlIZ0cxelJOdmVTL2M1TmROVG1JOGQ1YTBlTkE5ODdqRXVq?=
 =?utf-8?B?bHg0WGZwbHdwWGhLVDdlWEdvSWlQcEN1ZGptYnpTQzNrdzVpSXlyRVdxbW1Q?=
 =?utf-8?B?NVBESHd0MzMxR0pXdEM5THR6K3RUNERDcXdyL1g3dXl6cEVRdmc5Nk5tYUNk?=
 =?utf-8?B?Yk1LSlR5UE9Wa25KNEV1UmNRenh3V3o2b0FlYVp3L2d6UGdxR3F5eXd6UktC?=
 =?utf-8?B?RDZkdGJvRzhYemVTSW02QkJkOThwN1U2ZTB4MlQ0a0R4UHc0VEFkWElWOXZS?=
 =?utf-8?B?TUFjQnZjSTRFL0lHek4xd0MwNzdRbmE2K1RzQy9yWHh6QzdYNGlzajZkYUcv?=
 =?utf-8?B?OGtqOVkrVXFZQnBGRkxqZFBTTzQ4Z2pFVVZseUFqUXozRlNwaXZYT2lGZ0t5?=
 =?utf-8?B?aDczanpEVERvRjh0YVdiWE9MaFBJeGRMUFJ1S0tKTHZzcEYvZlc1dUFvd1Ay?=
 =?utf-8?B?MDgxRG5GRGNXdXhFWTczYTRnbDU3M1dZTGc0SUE2eXc4OERVWmg1dFJhM1NR?=
 =?utf-8?B?UFc3N2g0dXUrMHF5UnF3dTB3RnB1NW1iQmhtUjVDd3R6alFHUHl6Z2tVRXE0?=
 =?utf-8?B?QktFRFNrOFpCNzFHUHZyNDkwTVdTWkl6OEd0WlprdW9FWnZmVWZiMmlGa1dy?=
 =?utf-8?B?VTYwWVRLUlF5ZzBCamZZaVV3S1ZiK2JpU3Q3aDN0TmlQR0R1VDdQLzdhQUg4?=
 =?utf-8?B?ZUw1R2w2ZGpEeVJ2V013eEFyNU9iaEpZU1pHLzJvbmpBQi82TGQ4ZnNURUt4?=
 =?utf-8?B?SmZRcTRNSUN4VzRVelRnODNVMWcvTDM1bGRkRWxUb2NlUzNYZmV1VW5mL2U2?=
 =?utf-8?B?UTVsRnJUaUpQNnFsVnVGcDJuMGpJQTdtdmh2ZUF6N1p4UFNpQlpOcng4M0VK?=
 =?utf-8?B?a0hjRmh0NUdxRTM1S1YyNGkrUkNaTm9nRFNnY0RGVWF2Sm1PQzM1MEdZb2NT?=
 =?utf-8?B?TzBLK0U4M28xK09PbnM0Ty9JZmpudW9RNDlWK1lYRHhHbHBjeXpUS2RRdlFX?=
 =?utf-8?B?Rk1oWHVsNGFLSkJJUVlEUzcrSVAvWERZbzNCdmNkU3cvYzgzb2tVNHhRTmFD?=
 =?utf-8?B?d0UzWjlRSmFoUlp3NzBNVVJkeXR1c01VRmhtUTMxQ0dwMWNsVFlFaWJFTkph?=
 =?utf-8?B?RC9zZkNTZlNjeWEweDFvcUN5b2tESC9NVUNsODJEN043YWtnRHArbmN2S0xs?=
 =?utf-8?B?bWZtaWlXMnpYNXp6M3kyamh1QWJoTnhRRlExYkFuTm5TWjRuSEh3bU5LQW9u?=
 =?utf-8?B?SkFGZGZrSnlRYzRFemxMN0FJNHB5VzdYZFR5eU8xWkFLZnNrSkIvbVJHb1VE?=
 =?utf-8?Q?BJGFcs2/bKjLepbR0pgB24VrC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3919f4-5df4-40ba-53b4-08de20c35562
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:40:45.5986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s59mGAJqsBpDU4PtpnGMfI/RfRcuxsJ7YHt7AqD+oC2svCIgMzRRVIQ/XHE56uUpNIdxKl41M9D1BIiiQLnbZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com

PiBTZWVtcyBsaWtlIHVzZXIgc3BhY2UgaGFzIG5lZWRlZCBpbmZvcm1hdGlvbiB0byBwZXJmb3Jt
IGEgc2FuZSByZXNldD8NCg0KTGlrZSB0aGlzOg0KDQoxKSAJUmVhZCBpbmZvIGZpbGVzIHRvIGZp
Z3VyZSBvdXQgd2hhdCBtaW5pbXVtIG1hc2sgaXMgbmVlZGVkIGZvciB0aGlzIHN5c3RlbQ0KMikJ
VXNlIEJhYnUncyBzdWdnZXN0ZWQgc3ludGF4IG9mDQoJCSMgZWNobyAiTDM6Kj17bWluX21hc2tf
ZnJvbV9zdGVwXzF9IiA+IHNjaGVtYXRhDQoNClJhdGhlciB0aGFuIEFhcm9uJ3MNCg0KCSMgZWNo
byAiTDM6Kj0wIiA+IHNjaGVtYXRhDQoNCkknbSBPSyB3aXRoIHRoaXMgZm9yIEwzLCBidXQgc3Rp
bGwgc2VlIGl0IGJlaW5nIGxlc3MgdXNlZnVsIGZvciBMMiB3aXRoIGFzeW1tZXRyaWMgZG9tYWlu
cy4NCg0KSXQgY2FuIG1lZXQgdGhlICJzZXQgYSBtaW5pbXVtIHZhbHVlIGFjcm9zcyBhbGwgZG9t
YWlucyIgbmVlZC4NCg0KQnV0IGNhbiBmYWlsIHNldHRpbmcgYSB2YWx1ZSB0aGF0IGlzbid0IHN1
cHBvcnRlZCBieSBzb21lIG9mIHRoZSBkb21haW5zLg0KDQotVG9ueQ0K

