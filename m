Return-Path: <linux-kernel+bounces-883661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3CC2E01C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FD784E2544
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5329E0F7;
	Mon,  3 Nov 2025 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vnJTYDJW"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2916238C1B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200651; cv=fail; b=OhXQHT9o1y30jR/0Ea9lkFgay4G5dUAsPI2IFl7KGBTfFsXkqmb5/uoCvhJ4S5gp3ElZRIYjfUQ2DG4gECo1sm2PED/7gOI9YAMol2uvyvnT7Ks6+VL0eupr5EZYAPZVREMuFDdVXXPn6YrKTqNU50lh5iROY8PAE0ccEw+xSV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200651; c=relaxed/simple;
	bh=/k9Kx3kVKw+p5nT0vro/FUIIRo0i4HsesIFm+CdNaJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5Vi1Pg/ES119U2BZMNxdorzKDnvmjBIJ0oztzusOelLQRDiFk5GEA3KNRn7LO6jbO5SeH8XS9u20GXkaVePuKJjHesQqAy+6eLwVor7dMuWj3cJ/8EzQIy8CzygBeAj3eTcaC/fbnH/hOVTutTii6OTujVFV/UyL+O1I2fA6rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vnJTYDJW; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwX7EYgmizrwRNAzxogyTJmHUk6Aa9wXM8liiqOf9N4lYjVGy9wAb9cE7A4tsNcX8Egt1XZIfZ6SXSa6HVtxSnXUypoKs83l90rqQEMfVE0P4O5dttrMSLcRojKlOX7Ykzcr6eDJePn15gMxSe9i8UjhgYsgF4LGGQDFoYVcPu/WefPSmuozx+2fpcwfKoVyZYs0kCKjcy4lZQrJ3EZQ0b133BssxhF15i8oaiaaO6Gc8mOaSAr2DtaeeUW498GAjXTnx77EgK7MMmr5XsaivKIb2cQNKtzSgFWH74iO00toVUHzoeAZN0ydSLuRJLlKD7kN0saVH9toFAsInCG+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k9Kx3kVKw+p5nT0vro/FUIIRo0i4HsesIFm+CdNaJY=;
 b=UC/BpkWycNvoG5JWQ3DyV5PvUWaROrdr/VkkIoQf0E6qgizve0Oj1B5aETivGm0G11Y6mtIMLGqYwRtYi3jkQtaGYSfJjhG06S762trDJ1kBREKa6NDlvNAHaEH9eg+0nPSG8gcjxHfLfOeLIvofb6MUB34WpzANc2GGJbsVk07eohDDZeY+uP5lSpsNVogNvttDtAFM0hgKIKZX0Q6N4abDF/c1xssc0hw++DBoJniMy1qoyM3hLscTK6iMKTJF3fbXBjrng2xUd9xOPSgFDcolycVTLV+S8UAcEB6iiC0lvjgxSoO40Sqgqo6NgnvwACCRwccb4vwcAfmeTgi2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k9Kx3kVKw+p5nT0vro/FUIIRo0i4HsesIFm+CdNaJY=;
 b=vnJTYDJWOwAERqx03AHK52C+QFFvXZrY2KGtmRPEWoNZCrVgUaGr8I1xi16ir7lAA8bEvfBl3UEYFtgnA6u38BpNLs9yb/xrMsIBaG73yji33mM/Tt7SzJSrWdj1eOtiwqhC8hGgQ4fQtKS+TVUussPXpNRF0CKP3GMcuAnIJuc=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 20:10:41 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 20:10:39 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Thread-Topic: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Thread-Index: AQHcTPiGfM307gXAJkODrReO/4wVEbThX7yQ
Date: Mon, 3 Nov 2025 20:10:39 +0000
Message-ID:
 <LV3PR12MB92655CEB1AF94875901E700C94C7A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-6-david.kaplan@amd.com>
 <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
In-Reply-To: <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-03T20:02:53.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|LV2PR12MB5847:EE_
x-ms-office365-filtering-correlation-id: 50e3f76c-9d48-4765-60f0-08de1b150f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1VTVGdrQVdCZDdYZUZQSDhTV1A2MEFjdTdJcHIrNWZFSjNWeGNzQ3ZySDNS?=
 =?utf-8?B?ei9CZnh1SUZ5d25YTVB2Q3ovNFpXa3hrRk9YYUlPeGRlQTgycGpFOFNLTU5t?=
 =?utf-8?B?eUxGajhwRUNlcnpDQ0lzaUo0Q0lxWjhiaDZzVEtiaitLZm5YYTdHLzFQM2p1?=
 =?utf-8?B?WU02dnJ1Nzd1ZkZyRFlXNnZNMDlqd2xyWHNBdnJ1WkdWL0l5dDJqalkrakF4?=
 =?utf-8?B?dFhNeWtrNjRGVUtUWmYwa1A0bXhDbGsvcVJQZkp1ZGtHQ3NrNTYydnJlVHM2?=
 =?utf-8?B?T2lJUHBxM0RjQXRPK2ovNG1PYXMvSjlhR0xkYXowd0RhSmJlVGJGL3YrQnIw?=
 =?utf-8?B?cmdnanVvVWRaOFpzMU84LzUxL201ZHhOUG1zUzZLSGpacVNHaFRMYk9mOUd0?=
 =?utf-8?B?aStNMkRLRDQ2SzZ4a20wY1dTU3ovVlpaakJPdUpkaEtnWjRGbFBsbUg1akNE?=
 =?utf-8?B?UUliaWRYWUJBUVRRc3pMamZDOUhUMkpWaDQ1aDJCUnNCK1NDazlST2RBc3Zr?=
 =?utf-8?B?Z2pFOUVXNzM5b2RQUlU4YSs0QU9RUXRhbUQ2N0tTNk8zUnlaQU00aHpWUDd4?=
 =?utf-8?B?eThLcWlDYzA0L1FiVWtWWTFoS1dLeXljSEhuK0NLMEplVjJOckhaV3VQS243?=
 =?utf-8?B?bHdOa2RDNzhxbHJFcktiemFIWXRKNjcxL2c4YnFBbGlFdFdjWi9sMStzYi8v?=
 =?utf-8?B?Tk9EdWtrdmNMYVpmTmV0OURUWm1waTl1TWR0bUJTK1daN01uZ3VrNzUxU0Vr?=
 =?utf-8?B?R3kzeDFPamswbEh4dDRPSldpQ3NRS1YrT0o5MVhLSTlNYXhCV1BERnRjZmYz?=
 =?utf-8?B?Uk44cjZRUERqZWdaU1NsVEdONVEyL3RpdCt0YVZxOS9CRUUwdUJLUFJGYkZm?=
 =?utf-8?B?SVBqYStVL2JxZ3Y2WFVTbnNkSC93d2ZsZlNXMWlDdFUraVpPanEzc0FIc3Na?=
 =?utf-8?B?YzFxVXgyeHA2L3ZuQWdRbVNiS1hYMzRnVitUc2dQNHBFdjBqWTRGeGMyclFE?=
 =?utf-8?B?ZVhid2V2N2hqMklNQXNNVXNYQ3RrSDhqNitLMXh4YlJsSWxTd3Z0NnU0ZWpu?=
 =?utf-8?B?aUgxRmJIYW52TGlyRzVyM201SG44YTJUdUt2OVVmRWZvS01lanVZazVmaUll?=
 =?utf-8?B?VytmYmNjSzd3VCtHNnBEdHJiTDhBVmR4V1pTWFd2OEl0Nnc3UzdweGRQNjZy?=
 =?utf-8?B?U2ZGQXJDTE1MOUJCMWM4V0p0bHdoNmxvZjBFclVWTUs1NjM3WU9BTjc3OWUw?=
 =?utf-8?B?VU1pOW0zQVlzUlJRMEZMUnBSMTVEc3BrT2R0SzdrdnFmMlQ0MWMwYnh4WVdw?=
 =?utf-8?B?WXF3dWxXSzhKTUp2R0M2MWNQR1VKVXFYcFY4VUhUQ0NzRXlTRS9QRTN5YVJ3?=
 =?utf-8?B?K0dOcVZMMXJ2TDEyUzcwbXNoSmROaEFWRGt0bXptQzFvUlNxdjJvem5EUFA5?=
 =?utf-8?B?dUJBa0piNzZmVlVOc3BBZ0ZFYTFrN01SWEJMeDIvUCt4QmNTOWZKNjE2dDVq?=
 =?utf-8?B?YzJMZE9lcG9XZGMxZGRHL3VPdWNvby9XY0pQcGpiNUdoOXcvbGpSNFdGTWk3?=
 =?utf-8?B?dHhWZ1pBcFRFQmZ3bVp3cVNLeFhVYkp6UFd0ZEhWdjh0SjFBQllER09NdkdL?=
 =?utf-8?B?Z3Y3RzFpdWUvK2R5dEZ3eXFmOUtyMnhpVkp5SStPMFQxVXBPMTFtT0xCczF4?=
 =?utf-8?B?WkpQN0E2NTVDM0hiTzdUZGhVM1gwSTdNZHZ4VFdva3FodVJFYWliMWVtZTBz?=
 =?utf-8?B?SU5rS1JVdkJuVDdQNG4yZWU4MENDaVdzb2xuV240T1JQR2tKVUxib3hrRmFR?=
 =?utf-8?B?bko5OXNnVGd3YWxkL1JLZjE2TnpOM0gwakk2bWoyeng4Tkhna0dmWWhVeWYy?=
 =?utf-8?B?ZFREcFNaaUsrU1JEM3lyUkJnOW9nTVZWK2pIYlUrbVRJM0RyczFpVCs2WFF1?=
 =?utf-8?B?MDJuR0JpUldIUFlRUlRQdXJxNmltVGpYb0xuVG5QSjZhZ1ZRbzJScm1CYm1L?=
 =?utf-8?B?REowcTY4ZHdJa28zb2VZY1l5My9Ib0pZWFVoQ2tpNDJQU3VZamlJaVdjaDZE?=
 =?utf-8?Q?67nCen?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTMvSG9MVG56VTRQTE90L01wMEhocTY2cU1LbUtBWVBNR0F5ZVd1T1Zjc3Rl?=
 =?utf-8?B?QldHUlRwajZXNjVxQjkrSXV0dmtMcTVKeklWMGp4ODBieG1sQTgvYndIQ05t?=
 =?utf-8?B?cXVvc1hIbTFJTDBMS2lFSjdJNERGdytpaEN6aGRzUGRoanZEV0FpYjNLeS8v?=
 =?utf-8?B?akg0QnNxUGU2M1FRdEhDVW5YeGM1UWY4NUZwbm4wbm9PR3JlSGVsMktySUk1?=
 =?utf-8?B?Sm9IbERZcDNFUVBScjdocHNOa2NkV0FtQzRiT1JsbFd4OFMyeEgyYkhWMHRy?=
 =?utf-8?B?VVlVSUdFbHV2bDN2b05xLzkrSFRmV0oyYTA3RTBUS0FuRWxMcXUyeUVXQWg2?=
 =?utf-8?B?R3JJbm1xaTRpWFh4NWkyaFlNYUpGTFY5YVZWSkoxQWMwSG9lQUpuY1cwd1Zt?=
 =?utf-8?B?eWRtaG1YbUpaL3pUSFRpaUIzak9IcG4rc3hRVnFZT3QwQ2svQlZycVhvakdp?=
 =?utf-8?B?MHJDVG5IRWNZVFNxOXo5QkZBL2FnUHlCUTZ2bGVuOXh6SlFxNTluS01UWXhW?=
 =?utf-8?B?R1R6M3ZnNGEvN3FoVUJSYUlnN3hqZVY5UWphZ1BQY29XUlFEdk9iMjFvNGRQ?=
 =?utf-8?B?MVFTNHQ4QVBiam5PUEg2UHlKazk2ZzM5OUhUQnFBdmdiMWhGcFlDV1ZRaGZF?=
 =?utf-8?B?N01kZ3JRSFU4dEdYS0JPTUlRcS9CSGx1eXJuaDVyLzk4M2lxMjc0S0pvUHd4?=
 =?utf-8?B?ZXRwdGs2QWdDRThleFBLY1hzNE5uSDRJa0dCa2dNRld4aFd1SUtxMWo3b1Rh?=
 =?utf-8?B?L2dsV05JMThGVEJCNXRTZlJxUFFRdWtBQUFJK0xlemh0d3ZqeVVvRDRZRFpl?=
 =?utf-8?B?Wnd0NnQ4Yi80eHNiT1FwVy9oc05uTm9wY1ZxcXJaUnNrM1U0cGNRNE5iTjd6?=
 =?utf-8?B?eU16MENkUVBKbk4zWVBSazVOMEhUb0tGSzh3c0NuYjFxLzlkSXRaZWI3MXBs?=
 =?utf-8?B?Mkk2Z0x6cXBvdXhMWGliWUNRZFFlM205L1BQWXhxSEYvbGNvVUVBYktjMHV5?=
 =?utf-8?B?eDFpdFZXRlhNalNQZ2lVT3lyS1A0a3NNWkJTYU0rUk1nUzdmdnFwWTlheXdJ?=
 =?utf-8?B?elozWGtNVERpT0Rxc0F5YVQ2L3FaRmpsM0J4S0dOSGVGSUpObktJVlNXNFpj?=
 =?utf-8?B?Sld5OVlmRHA1TmVzVHVTQktNRERvZUt0ZFdkSDVaMUNCb0t1OVRvU3o2bWMx?=
 =?utf-8?B?RGluMTVPK2dBTktJZDJhVkQ5V0c5NVl2Z01Va2VROE1raThYWTVKUEs2d0tG?=
 =?utf-8?B?QjcrZExMb1RCenIvOVZvN3NaS3VvUEtFYnlyVG0vcE9wMUxnYXdLN0pVMDRY?=
 =?utf-8?B?R25mL2Z2ZnZkblJ2QVVKaDVSN0xyVHRQOFF5QWZ1aUJFRytob0FFZ3hFV0pT?=
 =?utf-8?B?YXY4RElFMW5YZTROSVFBL2MyR3hYRnJpTjltMnkvNm1lYzdLVDloUTh3emxT?=
 =?utf-8?B?KzJjRzlGZFlUcTJMbjJvQ1l3bFBBMmYzOHhrYzY3Wlc4MVNPTWRUNUZNVmE3?=
 =?utf-8?B?NzE2WmhadDZuQW42Q0M4MUJXUlcxWm0yN1ZKSk1yZ0x5bEFmR1ZaNDVRVENB?=
 =?utf-8?B?NFVqZHQ4d3lxbTVUWGZSckVtWWUvOUZSczljMjhZU0pHZ052dXV3VlNUWUxD?=
 =?utf-8?B?REhrNnl4WVdlWm5BN2djQ2lRU1JnNHM3ZlRhMWJhd2huSzFpNnJvZ3dlUDM2?=
 =?utf-8?B?dWdEVUx3ZWRvV1pLM3BRa3hWVS8rOW5vU3F3My9LY0xtL3RlSzhyTTZwMlY3?=
 =?utf-8?B?ZjQzMVFpa1pxUWlMZXdGVUJnVUkybmFyUGluZEU0dDVleVZCTXFCVGRVdEZn?=
 =?utf-8?B?UnBJb29zMGV3bWFpS1g4Z1U0bjBHdTczQndhNTJhQlVrSnAxaHRmblBMeC85?=
 =?utf-8?B?VU1zWEFGV01tWkkwWlhTQ1QybzJHMW1qMzZTVDZXQTRmSmxxaEJRajZzdFVZ?=
 =?utf-8?B?YzJibW9YVm0rdXdZNVlsWUtINEpKa3p3aVZNL3dGUEk3RFF5REowRjdzdHhV?=
 =?utf-8?B?SS9VUXhKaXBLK3ZaSmdHZkw0bFZVdEJXU0s3TUFmc1R1OFpaVXRLMENLQzV6?=
 =?utf-8?B?dEZWMGhUejhuWHBJeWxkMEhhWERnbE02NXB0WGtBRkI3YnpKQWh2cjVOK2hC?=
 =?utf-8?Q?luAM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e3f76c-9d48-4765-60f0-08de1b150f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 20:10:39.8239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnNsMxm2WV7AxbzHunkNmchJmavakHRqb5S/G3n58hyd8NpyprpPuY1sWrBYn/0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAzLCAyMDI1IDE6MzIgUE0N
Cj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYQ0KPiA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+OyBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz47IFBh
d2FuDQo+IEd1cHRhIDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBJbmdvIE1v
bG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51
eC5pbnRlbC5jb20+Ow0KPiB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluIDxocGFAenl0
b3IuY29tPjsgQWxleGFuZGVyIEdyYWYNCj4gPGdyYWZAYW1hem9uLmNvbT47IEJvcmlzIE9zdHJv
dnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwNS81Nl0geDg2L2J1Z3M6IFJl
c2V0IHNwZWN0cmVfdjIgbWl0aWdhdGlvbnMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9y
aWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3
aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0K
Pg0KPg0KPiBPbiBNb24sIE9jdCAxMywgMjAyNSBhdCAwOTozMzo1M0FNIC0wNTAwLCBEYXZpZCBL
YXBsYW4gd3JvdGU6DQo+ID4gQWRkIGZ1bmN0aW9uIHRvIHJlc2V0IHNwZWN0cmVfdjIgbWl0aWdh
dGlvbnMgYmFjayB0byB0aGVpciBib290LXRpbWUNCj4gPiBkZWZhdWx0cy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIEthcGxhbiA8ZGF2aWQua2FwbGFuQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIHwgMTkgKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9i
dWdzLmMNCj4gPiBpbmRleCA5ZDVjNmEzZTUwZTEuLjA0MzA2MzViYjE3ZCAxMDA2NDQNCj4gPiAt
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvYnVncy5jDQo+ID4gQEAgLTI0NzcsNiArMjQ3NywyNCBAQCBzdGF0aWMgdm9pZCBfX2lu
aXQNCj4gc3BlY3RyZV92Ml9hcHBseV9taXRpZ2F0aW9uKHZvaWQpDQo+ID4gICAgICAgfQ0KPiA+
ICB9DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19EWU5BTUlDX01JVElHQVRJT05TDQo+ID4gK3N0
YXRpYyB2b2lkIHNwZWN0cmVfdjJfcmVzZXRfbWl0aWdhdGlvbih2b2lkKQ0KPg0KPiBZZWFoLCB0
aGUgcmVzZXQgc2hvdWxkIGRlZmluaXRlbHkgYmUgYSBzaW5nbGUgZnVuY3Rpb24gLSB0aGlzIGlm
ZGVmZmVyeSBhcm91bmQNCj4gZXZlcnkgc2luZ2xlIG9uZSBpcyBnb2luZyB0byBiZWNvbWUgeXVj
a3kuDQo+DQoNCkRvIHlvdSByZWFsbHkgd2FudCBpdCBhbGwgaW4gb25lIGJpZyBmdW5jdGlvbj8g
IE9yIGp1c3QgdG8gcmVsb2NhdGUgYWxsIHRoZSAqX3Jlc2V0X21pdGlnYXRpb24oKSBmdW5jdGlv
bnMgdG8gYSBzaW5nbGUgcGxhY2Ugc28gdGhleSBjYW4gYWxsIGdvIHVuZGVyIG9uZSBpZmRlZj8N
Cg0KSSBjYW4gZG8gaXQgaW4gb25lIGJpZyBmdW5jdGlvbiwgYnV0IGl0J2QgcHJvYmFibHkgbG9v
ayBzb21ldGhpbmcgbGlrZToNCg0KLyogUmVzZXQgc3BlY3RyZV92MSAqLw0Kc2V0dXBfY2xlYXJf
Y3B1X2NhcChYODZfRkVBVFVSRV9GRU5DRV9TV0FQR1NfVVNFUik7DQpzZXR1cF9jbGVhcl9jcHVf
Y2FwKFg4Nl9GRUFUVVJFX0ZFTkNFX1NXQVBHU19LRVJORUwpOw0Kc3BlY3RyZV92MV9taXRpZ2F0
aW9uID0gU1BFQ1RSRV9WMV9NSVRJR0FUSU9OX0FVVE87DQovKiBSZXNldCBtZHMgKi8NCnNldHVw
X2NsZWFyX2NwdV9jYXAoWDg2X0ZFQVRVUkVfQ0xFQVJfQ1BVX0JVRik7DQpzdGF0aWNfYnJhbmNo
X2Rpc2FibGUoJmNwdV9idWZfaWRsZV9jbGVhcik7DQptZHNfbWl0aWdhdGlvbiA9IElTX0VOQUJM
RUQoQ09ORklHX01JVElHQVRJT05fTURTKSA/DQogICAgICAgICAgICAgICAgTURTX01JVElHQVRJ
T05fQVVUTyA6IE1EU19NSVRJR0FUSU9OX09GRjsNCi8qIFJlc2V0IHNwZWN0cmVfdjIgKi8NCkV0
Yy4NCg0KLS1EYXZpZCBLYXBsYW4NCg==

