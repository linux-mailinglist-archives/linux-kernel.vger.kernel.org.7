Return-Path: <linux-kernel+bounces-619217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14657A9B93B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 22:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201507AEEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6921F3BA3;
	Thu, 24 Apr 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZywuuQsm"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C310F9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526691; cv=fail; b=B12XsxzLlxHSZrJBW97jf71L8VQpsaOYb8K4wQwNr4qioPTFmPypp5hrUjBQwJgBcTXyqyP8q7jXGDg2CwmLO6X1EhfMSzTy89Bbk37JIPgrttWdiOE2AceaGotFyPyuyulVGtXstnHE/xOUQUEKbS9oarg8j3BJTSnexlxTNw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526691; c=relaxed/simple;
	bh=ukN5xtTAWBN7fwTYb56HEFgi+sBoWHB1/kE5v5rsQvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSt4I2LttaP0WekI/wgAJ2a3QAimpztTJdCYWM2/cWJLlxBMJWQLj4CMaRBoUrPfuyTLuehnaGHLwkONT/HiEou0P2Gyhs/y9lWiHOar7EiudO2RU7WaRy3iX9CaNN6255WYTEo1EFy8uNqOh8iqsnwPSDt0sVImzFlINJ2afw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZywuuQsm; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIXynmbRed7W0NEIsTN++dVTlN994+NFZKDTmxy3Dz4bJHR7n+iDIfZ02q2tZSg7ED0bZNfZ5y0ncUgUsJZRKskXBZpUdtmLYUhEEL7YCi3rhssvIJfM6UTMWNjfFFST0/SVsx/rf+KTvhpv+jN8x53Z1Z+KO5dKeEyUGaP+YA27ThsaEOA+leco9KyYxE7EFHQt5j9qix3eAuW4fYNWVPhmZh3wmkhtKK3WVgIdAiXHTJkS7my4qcoinyAgNaJ26BykXilbYZ1PXq0xc9U24xvI0lxtUMucsVAmYVZjMB8QbrDUg5bxkFg6gNWw2dgm7wMHMTyuhEPtH/IbKUvyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukN5xtTAWBN7fwTYb56HEFgi+sBoWHB1/kE5v5rsQvk=;
 b=sRkj7Ojthx5HS9ydDIIO2vpnQ1hO2W8Oc1E0INt/9dj4Izfhz8CYk46zZgn0LpT9akKqeHJuBz+Jsip6gBUiGgf6x9JRhPr7GNPpYWnyX9SloAxDIXiB9mQRxLE/lRrdSn1B32vIIIiGghA6HGRXOktl7afCRTKnTVbXnjluZr+LuYZTCONNkwsdo2RE82ErMNVmVvQ70FyRZA4SooqFwP+OwkjPkqgiDF46DouC7sergAoaqVbIAZdMW2Nu5mSmvNLdvr1jEkf1lcioVdoeG8ZZez3//bBVIp4VXFtNiLiTIYAZFuh6sAUKz6VjnWEpuZ3+GQlvLJfWIXeGtLO8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukN5xtTAWBN7fwTYb56HEFgi+sBoWHB1/kE5v5rsQvk=;
 b=ZywuuQsmu3qWKhj2x9gzGP0RE9rX/SDEkexqxiMDUmE1LUrK2ShZklwuuOlvKXUdS6MNciqcWSKgGpwHm+Y9eVgSx9ZYFyUz9wb0kWk5jKP7d5/Rtn8JJRNT1IDov4unfntua15WnKtzehzNAQ83T2kZoiOIgCByTzPAj9bevBM=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 20:31:25 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 20:31:25 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 03/16] x86/bugs: Restructure MMIO mitigation
Thread-Topic: [PATCH v5 03/16] x86/bugs: Restructure MMIO mitigation
Thread-Index: AQHbtVYZe2tLds1K7EiPZ/ePuOYtaLOzQstg
Date: Thu, 24 Apr 2025 20:31:25 +0000
Message-ID:
 <LV3PR12MB9265795E7CF35195B7FE02A594852@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250418161721.1855190-1-david.kaplan@amd.com>
 <20250418161721.1855190-4-david.kaplan@amd.com>
 <20250424201918.GAaAqcxqFV0raTOOKP@renoirsky.local>
In-Reply-To: <20250424201918.GAaAqcxqFV0raTOOKP@renoirsky.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e429bf9f-84ff-4b60-b81d-93005a2ce3db;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-24T20:23:26Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CH2PR12MB4040:EE_
x-ms-office365-filtering-correlation-id: 00a04023-a79d-4aae-062e-08dd836efbda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T29Yd0JHUmRFWi9GQ01uVTRJYnNPU2VLWGpTSE5jR3VkTUc3Q0hrUWNPK3Nt?=
 =?utf-8?B?bXhjcE9tUjhncXgyaVM4RG1yU0VVWHJrdVQ5UENYR0J2VHJJVXREL2EzN0hX?=
 =?utf-8?B?T2pyMk41M2VWbUwwbGVWUy9uZUpjdXhmZUR6NXEySllPVUU1ZHNnK3dJOUl6?=
 =?utf-8?B?SzZxMFFXNmFJbU9MQklmd054VnNkZEhJU29MWGpRN0lENU1SQkZSZ09ZVjVC?=
 =?utf-8?B?THh3ZTlRaW16bXcyOGpNenZRY3lWWjJyY2pJeGFkb0JnWGpxMGZ1TjNDUXVs?=
 =?utf-8?B?YmZBWlRSbUI0b0FHMWwvejlLS3AwT2tRclRrZ1ROUzFjU3gzVS9sNnpidTQ1?=
 =?utf-8?B?dHVjbXVnOXFsakN6QXV1WnBsdko4eXJ3ZnQrVlI0QnVWbHRPcWxVTHBnWlZx?=
 =?utf-8?B?aWZNOEZCR1FhMVZENUlHZ2ZNbGZoTjd1c09lVHhYS3lCY1lWaU9HWTRDYXRN?=
 =?utf-8?B?RUZjNFZ2WUJJeUFQb0tlUng3VCtEcTJxL1I2em9jR1FaM0s3b0dOWUxpWTZT?=
 =?utf-8?B?cy9vUW9HVGYybllEQ21jRTRtTld4a3BoMENYd2wxdjJDakM2SEM2RkZOc0Vu?=
 =?utf-8?B?VG1SVUZTQVMrZE5NMU5LcXFCNDlqM2dtUExmMUZSQVlrSys2OFU4UXQ4MXQx?=
 =?utf-8?B?Rm5USGkwYzdMaDNhYmlRNDQxS0E3OFhqTkFyNlluLzFDLzRhR3VQWDZ5d2h1?=
 =?utf-8?B?cWhzK0JUNC80emV5SzJlcjg2eWlvYVhFNWUraCsvV1JnYzlXQ1NwTWpBWm1X?=
 =?utf-8?B?RHZhSzFGRy9XSSsrS0ZNa21VQmRwSjI2OE9JT2xtS1hFem1qelpoVSs5WEVW?=
 =?utf-8?B?YVFucGJMTTAwUTIzVVU3dDJNcHVuZ3BKdXdHandEZ2Frbk5GTEkzTnZGWkFB?=
 =?utf-8?B?YkZYWTduRnduMkJmdDV5OVFlWWl6S2VFZXMrb1BHZVIrL3NEYWlYTzVwdkh1?=
 =?utf-8?B?emlTVkRORTltQWxwTGovMS9wVFl6VUFiVnRjUDFCdUxnU3NtKy9XcHdLS095?=
 =?utf-8?B?eGF3R1o0YlI5U2MzUDFHZURQNXJUSnkxdW5Kc1BWRExCb0hvZHRDcEs2REw1?=
 =?utf-8?B?VHNnRDlJVXBObThXYnkwa25pSjhHS09lMVR2Y2hkbm5EeGxBMDBwaWtzNXhQ?=
 =?utf-8?B?Q3pkYnRPdWZjMjBPL0I2RmpSYk1DWlBTZHY0OGU1amp2QXBpMUduNlBua000?=
 =?utf-8?B?cEh1cnM0K1JDcjBoOVRCdFduR2tZQVhQV2RWMlRRMmRqMlFuWHh0WlA1SGx3?=
 =?utf-8?B?T1dOMkZOY3VqWHV3NGQ1dkNhdVJoNmhGaGdCTUNBTUxPTmpPK3dScmVSQTV4?=
 =?utf-8?B?UmRFQ29CWnZQUnBwUDUzbUM4bUpwRDFlNHhuN2tkSFdveStWNjZSaUxmQVcy?=
 =?utf-8?B?NVpTSmFZRjU3RHZHUnZPaGlrZWRzbk9kTzZyR1V4NnBXdElCL2dYNlhyQ3dK?=
 =?utf-8?B?bEJPY1JKT0lGZjBvVWt0ODhOOFBHMWlOQVRhVnFZM1dFaGd5Q2JCMFE0Q1lk?=
 =?utf-8?B?TUtHM0NIOEduTHFpSzd2SU9XVnkzNTcyYURJcHFtNG9GdEd2dnVERVRGWDBo?=
 =?utf-8?B?Sll4c0JOa1V4Nk9OR2tLSEtxL2pyNlhTUGphcUYxd3NJUWVYc041dHgrbUZC?=
 =?utf-8?B?Mzlhay9pRllVeWJPdllvd0xkKzhvenZ4OGNzSHpwT284NGtOcDRtblUzdWpL?=
 =?utf-8?B?NjJPYm5wbnR4Mkd0Nkdpc1U2NlZReUJxVnR4aVJIMFdCZ3ltbUFXdnk1c0VI?=
 =?utf-8?B?ckhUYml3azBKSUNuTUJjdWZLQTBXaVNSR2NBbi9MWHdKWnByaUxyL3RuT3Vs?=
 =?utf-8?B?UEVBR0lsbVFQSE1qU3FNeiswSjNwcU9SZUpPL0k5alNTZTg5Y0lYY3ZXM3Ew?=
 =?utf-8?B?T01Pa1dtancxNkpVVGVoRHI0SjI4ZkNSaU91bUdXWk1GMWY3ZW1icUdjT1hP?=
 =?utf-8?B?dkE5NElyUDFiTGEydElFZXpIZFpRUlc2QjZsY0doZlRWRmFvNy82RmlkcThR?=
 =?utf-8?Q?UQsNxelLlo0tfVUxQQVieQQWvWK/iU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzJ3VUFWVkVFNFhwaDhQU0c3M3VFQ09LMGpTZE5PYmJIMFI3bjNmZ2VmcDVz?=
 =?utf-8?B?bkViUHZVRWxCWjVyMHJVcnN3ZTFyRjEycFEwM2JyMC9jbVdzS1NrTjNscm1i?=
 =?utf-8?B?VkFZUlh6TVZpTWszckI1cDhxVzdpOTBiUEdxTGdodW52N2N5MGcvU1lHazRT?=
 =?utf-8?B?WEEyWFVnYTZFcVhHUGVnL0JrdmRYWnZJQnovL2NnbGRBRWI3b0VHc3JDditJ?=
 =?utf-8?B?QlBFYnZ1ditnUE9KemREd0w3UExxZ3pjODlBYjRWblJ6Y05OMFdwQUwxM1g4?=
 =?utf-8?B?VmNhdFJtRDUwT0I5SDZWbzhrY3JxelliV1FvSndCK2ZJRytPY09JbmpwaFRU?=
 =?utf-8?B?bTQrTHhIRjFZVnorL3FnNU5aU2EzTC9maDU1bDBhVVUya1Nqa215eVRPOFR1?=
 =?utf-8?B?QUNFV0VIMGZNUG5sL1dGcHR2NXdjYjVtbXFrRGlISkViRVZGTUhab0gyM00r?=
 =?utf-8?B?MC8rOTZER1o3cGUzaVpmVjMySjd6akNvQ3F4b2ZKcXBiTTRFK1NOQmJSVFll?=
 =?utf-8?B?MFdJaEFaU05EK1M5dkJCU1ZDdWs3dFowS0tCNTkvdC8walBYb09nRzZzTVNt?=
 =?utf-8?B?QjZES0MyckZOZ0x1OEtLTjhXRFJlMCtjaDVjUjl5ZHd1TnVZYVhUaGNCWFBN?=
 =?utf-8?B?Zkx5KzUyemxsU0pyZG5YNTBRR0dVVW8wUjRiRk1qcnoxeXFoeUhaNExSUU92?=
 =?utf-8?B?cGVpNHprLzRBTzFRamlmb3YySjNqckRhNVJudjg3aytmZldpazRncGlLM0Uv?=
 =?utf-8?B?dEdSQnJhcXIzOGV6YVBYMmg1M0gwTEVNUXpPV1FHMm41U1c5MXJQNXpQNTJM?=
 =?utf-8?B?S2l1eEtKcnFUbUVWdHNuamxtcHU0OU8wUDRrRHdPZ1B4NXpQSEovNEpYa1h6?=
 =?utf-8?B?Wm83OEdFeVdEckZmdkUwMktPcXpEQ240b0FvaVZlcGxxQWpRU3psWFNQR09E?=
 =?utf-8?B?VTZDK2k0aS9Kb05hTDB2YUU2eXc5V1V1eEQybkVtZ3BlWWdxZ1dRUU1KdnU0?=
 =?utf-8?B?RnFQa2ZBTUNoNnZESzlnZDZRSDZsNWF2MzNpZmMxc0xYNU1XMWJrK1h0Mm56?=
 =?utf-8?B?VHFxTW8wYjdXQlIxWmpqYkw5R21ZOUxpcDV6ekszUys1WGROaXlGZDRoeU95?=
 =?utf-8?B?R29EU25Uak9NZ1N2OVgydGlUWkNNV29GRFN3ZEhYdHVISDNwWnpmWGJDQ0wv?=
 =?utf-8?B?ejJ6SjlTYkdob3VPVUR6Qnp0ZUpjZTU1Nm9vWnpKNXVRZjN6aEticnZqZVh3?=
 =?utf-8?B?VXhudnZYUE8xMC9neFFjTThVbHlLamJXKzc2VXk3ZmdxRURIVWVTamFsQk9l?=
 =?utf-8?B?UTh2eld2cXI4YWxSVjk1U1lPdWNNbVFWZ2FLeEY0NG12NlZiamNsbmdBYXRt?=
 =?utf-8?B?MG5mczZhS3JYdlBPZGNsU3JEZ3o0cEdlK3M3L3F2V01NTzB2eDdka3U5dUgr?=
 =?utf-8?B?UlcyTlhhcjFwYVJETDVjaWt0REwyVzdLSmp1TmwzVE1ETEluOGVjVWtRajJJ?=
 =?utf-8?B?MUppYzU1bTRYNWNCTnl6S3BVTjZ0Y1pWUUFwM1NXeU9IZlFDalM0NDZWaVpu?=
 =?utf-8?B?UmxTOWsxRHI2TzVTY0dlamdUc0w3ZGpidVljTldkRDBaTHNUUnNKLytkMUpC?=
 =?utf-8?B?TWtxa21Fbmtpa3h4L2pRZTBZYVVXT2gwb1ZMb1F3N0lKWkx3Um5vbXp4S0R4?=
 =?utf-8?B?a3JQZlorcUtHU0FzT2R0dnNwL0FPNSsyS1FjQkg0akNkVXVBeEZxSUpXY2Zz?=
 =?utf-8?B?L1c0RENTR3FvV0d0VkxlNFpKSjF0K01UQ1o1Q2RpR20yQ1E3bGw3K3hUVEdC?=
 =?utf-8?B?d3JjSzJOOTRZcXlWNjZmWTFtMVIvd251K0tFK3haL1RXam5LSkgrZGNGTjN3?=
 =?utf-8?B?MWxtY3JwQ0F1c1F3NGM4SVdwWjBNU1E5aGlYeFRUYTdGdGh5RkN4SlUvSlph?=
 =?utf-8?B?RDJocDZBNXpqUjFsdGc3VjhtaFZqK29LUHN0Q0s5ZWluU2t6MDJGUmdVNStN?=
 =?utf-8?B?UnRWLzZXWFdBNDcyVmdFVStnRmMxd3RSemxtY3FnaFpKUjNMRjhnZ3pwME1W?=
 =?utf-8?B?REpGVjlSUTA4bDZ0bFdUeXRyUDJQT1ZqY1JhOTdvTHg2Zk1uWE5FNW01REUy?=
 =?utf-8?Q?y/Eg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a04023-a79d-4aae-062e-08dd836efbda
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 20:31:25.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rD3nFADUvdwfocm/kRupjyci2oE9PLjNnJFPj3I4piNeftWSVfdUAi7nF9cmMt+p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDI0LCAyMDI1IDQ6MTkgUE0N
Cj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+Ow0KPiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz47IFBh
d2FuIEd1cHRhDQo+IDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBJbmdvIE1v
bG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUNCj4gSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51
eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFAenl0
b3IuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDAzLzE2XSB4ODYvYnVnczogUmVzdHJ1Y3R1cmUgTU1JTyBtaXRpZ2F0aW9uDQo+DQo+
IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gRnJpLCBBcHIgMTgsIDIwMjUgYXQg
MTE6MTc6MDhBTSAtMDUwMCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+ICtzdGF0aWMgdm9pZCBf
X2luaXQgbW1pb19hcHBseV9taXRpZ2F0aW9uKHZvaWQpIHsNCj4gPiArICAgICBpZiAobW1pb19t
aXRpZ2F0aW9uID09IE1NSU9fTUlUSUdBVElPTl9PRkYpDQo+ID4gKyAgICAgICAgICAgICByZXR1
cm47DQo+ID4NCj4gPiAgICAgICAvKg0KPiA+IC0gICAgICAqIFg4Nl9GRUFUVVJFX0NMRUFSX0NQ
VV9CVUYgY291bGQgYmUgZW5hYmxlZCBieSBvdGhlciBWRVJXIGJhc2VkDQo+ID4gLSAgICAgICog
bWl0aWdhdGlvbnMsIGRpc2FibGUgS1ZNLW9ubHkgbWl0aWdhdGlvbiBpbiB0aGF0IGNhc2UuDQo+
ID4gKyAgICAgICogT25seSBlbmFibGUgdGhlIFZNTSBtaXRpZ2F0aW9uIGlmIHRoZSBDUFUgYnVm
ZmVyIGNsZWFyIG1pdGlnYXRpb24gaXMNCj4gPiArICAgICAgKiBub3QgYmVpbmcgdXNlZC4NCj4g
PiAgICAgICAgKi8NCj4gPiAtICAgICBpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0NMRUFS
X0NQVV9CVUYpKQ0KPiA+ICsgICAgIGlmICh2ZXJ3X21pdGlnYXRpb25fc2VsZWN0ZWQpIHsNCj4g
PiArICAgICAgICAgICAgIHNldHVwX2ZvcmNlX2NwdV9jYXAoWDg2X0ZFQVRVUkVfQ0xFQVJfQ1BV
X0JVRik7DQo+ID4gICAgICAgICAgICAgICBzdGF0aWNfYnJhbmNoX2Rpc2FibGUoJmNwdV9idWZf
dm1fY2xlYXIpOw0KPiA+IC0gICAgIGVsc2UNCj4gPiArICAgICB9IGVsc2Ugew0KPiA+ICAgICAg
ICAgICAgICAgc3RhdGljX2JyYW5jaF9lbmFibGUoJmNwdV9idWZfdm1fY2xlYXIpOw0KPiA+ICsg
ICAgIH0NCj4NCj4gU29ycnksIGJ1dCBJJ20gc3RpbGwgbm90IGhhcHB5IGFib3V0IHRoaXMuDQo+
DQo+IEFmdGVyIHRoaXMgcGF0Y2gsIHdlIGhhdmU6DQo+DQo+ICAgICAgICAgLyoNCj4gICAgICAg
ICAgKiBFbmFibGUgQ1BVIGJ1ZmZlciBjbGVhciBtaXRpZ2F0aW9uIGZvciBob3N0IGFuZCBWTU0s
IGlmIGFsc28gYWZmZWN0ZWQNCj4gICAgICAgICAgKiBieSBNRFMgb3IgVEFBLg0KPiAgICAgICAg
ICAqLw0KPiAgICAgICAgIGlmIChib290X2NwdV9oYXNfYnVnKFg4Nl9CVUdfTURTKSB8fCB0YWFf
dnVsbmVyYWJsZSgpKQ0KPiAgICAgICAgICAgICAgICAgdmVyd19taXRpZ2F0aW9uX3NlbGVjdGVk
ID0gdHJ1ZTsNCj4NCj4gaW4gdGhlIHNlbGVjdCBmdW5jdGlvbi4NCj4NCj4gVGhlIGNvbW1lbnQg
aXMgd3JvbmcuIFRoZSBjb2RlIGRvZXM6IGVuYWJsZSB0aGUgVkVSVyBtaXRpZ2F0aW9uIGZvciBN
TUlPIGlmDQo+IGFmZmVjdGVkIGJ5IE1EUyBvciBUQUEuIHZlcndfbWl0aWdhdGlvbl9zZWxlY3Rl
ZCBkb2Vzbid0IGhhdmUgYW55IGJlYXJpbmcgb24NCj4gd2hldGhlciB0aGlzIHNob3VsZCBiZSBh
IGhvc3Qgb3IgVk1NIG1pdGlnYXRpb24gLSBhcyBpdHMgbmFtZSBzYXlzLCBhIFZFUlcNCj4gbWl0
aWdhdGlvbiBoYXMgYmVlbiBzZWxlY3RlZC4NCg0KdmVyd19taXRpZ2F0aW9uX3NlbGVjdGVkIGlt
cGxpZXMgdGhhdCBYODZfRkVBVFVSRV9DTEVBUl9DUFVfQlVGIHdpbGwgYmUgZW5hYmxlZCwgd2hp
Y2ggZG9lcyBhIFZFUlcgb24ga2VybmVsL3ZtbSBleGl0cy4NCg0KU28gSSdtIG5vdCBzdXJlIHRo
ZSBjb21tZW50IGlzIHJlYWxseSB3cm9uZywgYnV0IGl0IGNhbiBiZSByZXBocmFzZWQuDQoNCj4N
Cj4gVGhlbiBpbiB0aGUgYXBwbHkgZnVuY3Rpb246DQo+DQo+ICAgICAgICAgLyoNCj4gICAgICAg
ICAgKiBPbmx5IGVuYWJsZSB0aGUgVk1NIG1pdGlnYXRpb24gaWYgdGhlIENQVSBidWZmZXIgY2xl
YXIgbWl0aWdhdGlvbiBpcw0KPiAgICAgICAgICAqIG5vdCBiZWluZyB1c2VkLg0KPiAgICAgICAg
ICAqLw0KPiAgICAgICAgIGlmICh2ZXJ3X21pdGlnYXRpb25fc2VsZWN0ZWQpIHsNCj4gICAgICAg
ICAgICAgICAgIHNldHVwX2ZvcmNlX2NwdV9jYXAoWDg2X0ZFQVRVUkVfQ0xFQVJfQ1BVX0JVRik7
DQo+ICAgICAgICAgICAgICAgICBzdGF0aWNfYnJhbmNoX2Rpc2FibGUoJmNwdV9idWZfdm1fY2xl
YXIpOw0KPiAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICBzdGF0aWNfYnJhbmNo
X2VuYWJsZSgmY3B1X2J1Zl92bV9jbGVhcik7DQo+ICAgICAgICAgfQ0KPg0KPiBDb21tZW50IGlz
IGFnYWluIHdyb25nLiB2ZXJ3X21pdGlnYXRpb25fc2VsZWN0ZWQgZG9lc24ndCBtZWFuIHRoZSBD
UFUgYnVmZmVyDQo+IGNsZWFyIG1pdGlnYXRpb24gaXMgbm90IGJlaW5nIHVzZWQuDQoNCkJ1dCBp
dCBraW5kIG9mIGRvZXMuICAhdmVyd19taXRpZ2F0aW9uX3NlbGVjdGVkIG1lYW5zIHRoYXQgdGhl
IFg4Nl9GRUFUVVJFIGJpdCB0aGVyZSBpc24ndCBzZXQuICBTbyB0aGUgVk1NLWJhc2VkIG1pdGln
YXRpb24gKHRoZSBzdGF0aWMgYnJhbmNoKSBpcyBvbmx5IHVzZWQgaWYgdGhlIGJyb2FkZXIgWDg2
X0ZFQVRVUkVfQ0xFQVJfQ1BVX0JVRiBpcyBub3QgYmVpbmcgdXNlZC4NCg0KPg0KPiBZZXMgeWVz
LCBpdCBib2lscyBkb3duIHRvIHRoZSBzYW1lIHRoaW5nIGluIHRoZSBlbmQgYnV0IHJlYWRpbmcg
aXQgY29uZnVzaW5nIGFzIGhlbGwuDQo+IHZlcndfbWl0aWdhdGlvbl9zZWxlY3RlZCBtZWFucyB3
aGF0IGl0cyBuYW1lIGlzOiBhIFZFUlcgbWl0aWdhdGlvbiBoYXMgYmVlbg0KPiBzZWxlY3RlZCBh
bmQgbm90aGluZyBlbHNlLg0KPg0KPiBSZW5hbWluZyB0aGUgdmFyIGlzIHByb2JhYmx5IHVubmVj
ZXNzYXJ5IGNodXJuIGJ1dCB5b3UgY2FuIGZpeCB0aGUgY29tbWVudHMgYW5kDQo+IHN0aWxsIHJl
bmFtZSB0aGUga2V5Og0KPg0KPiAtLS0NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9j
cHUvYnVncy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMgaW5kZXgNCj4gYzk3ZGVkNGQ1
NWU1Li40YTViZDYyMTQ1MDggMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVn
cy5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQo+IEBAIC0xNTcsOCArMTU3
LDggQEANCj4gREVGSU5FX1NUQVRJQ19LRVlfRkFMU0Uoc3dpdGNoX21tX2NvbmRfbDFkX2ZsdXNo
KTsNCj4gICAqIFg4Nl9GRUFUVVJFX0NMRUFSX0NQVV9CVUYsIGFuZCBzaG91bGQgb25seSBiZSBl
bmFibGVkIHdoZW4gS1ZNLW9ubHkNCj4gICAqIG1pdGlnYXRpb24gaXMgcmVxdWlyZWQuDQo+ICAg
Ki8NCj4gLURFRklORV9TVEFUSUNfS0VZX0ZBTFNFKGNwdV9idWZfdm1fY2xlYXIpOw0KPiAtRVhQ
T1JUX1NZTUJPTF9HUEwoY3B1X2J1Zl92bV9jbGVhcik7DQo+ICtERUZJTkVfU1RBVElDX0tFWV9G
QUxTRShjbGVhcl9jcHVfYnVmX3ZtKTsNCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGNsZWFyX2NwdV9i
dWZfdm0pOw0KPg0KPiAgdm9pZCBfX2luaXQgY3B1X3NlbGVjdF9taXRpZ2F0aW9ucyh2b2lkKSAg
eyBAQCAtNTI4LDEwICs1MjgsNyBAQCBzdGF0aWMgdm9pZA0KPiBfX2luaXQgbW1pb19zZWxlY3Rf
bWl0aWdhdGlvbih2b2lkKQ0KPiAgICAgICAgIGlmIChtbWlvX21pdGlnYXRpb24gPT0gTU1JT19N
SVRJR0FUSU9OX09GRikNCj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4NCj4gLSAgICAgICAv
Kg0KPiAtICAgICAgICAqIEVuYWJsZSBDUFUgYnVmZmVyIGNsZWFyIG1pdGlnYXRpb24gZm9yIGhv
c3QgYW5kIFZNTSwgaWYgYWxzbyBhZmZlY3RlZA0KPiAtICAgICAgICAqIGJ5IE1EUyBvciBUQUEu
DQo+IC0gICAgICAgICovDQo+ICsgICAgICAgLyogRW5hYmxlIGZ1bGwgVkVSVyBtaXRpZ2F0aW9u
IGlmIGFsc28gYWZmZWN0ZWQgYnkgTURTIG9yIFRBQS4NCj4gKyAqLw0KPiAgICAgICAgIGlmIChi
b290X2NwdV9oYXNfYnVnKFg4Nl9CVUdfTURTKSB8fCB0YWFfdnVsbmVyYWJsZSgpKQ0KPiAgICAg
ICAgICAgICAgICAgdmVyd19taXRpZ2F0aW9uX3NlbGVjdGVkID0gdHJ1ZTsgIH0gQEAgLTU2OCwx
NCArNTY1LDE0IEBAIHN0YXRpYyB2b2lkDQo+IF9faW5pdCBtbWlvX2FwcGx5X21pdGlnYXRpb24o
dm9pZCkNCj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4NCj4gICAgICAgICAvKg0KPiAtICAg
ICAgICAqIE9ubHkgZW5hYmxlIHRoZSBWTU0gbWl0aWdhdGlvbiBpZiB0aGUgQ1BVIGJ1ZmZlciBj
bGVhciBtaXRpZ2F0aW9uIGlzDQo+IC0gICAgICAgICogbm90IGJlaW5nIHVzZWQuDQo+ICsgICAg
ICAgICogRnVsbCBWRVJXIG1pdGlnYXRpb24gc2VsZWN0aW9uIGVuYWJsZXMgaG9zdCBhbmQgVk1F
TlRFUiBidWZmZXIgY2xlYXJpbmcsDQo+ICsgICAgICAgICogb3RoZXJ3aXNlIGJ1ZmZlciBjbGVh
cmluZyBvbmx5IG9uIFZNRU5URVIuDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgaWYgKHZlcndf
bWl0aWdhdGlvbl9zZWxlY3RlZCkgew0KPiAgICAgICAgICAgICAgICAgc2V0dXBfZm9yY2VfY3B1
X2NhcChYODZfRkVBVFVSRV9DTEVBUl9DUFVfQlVGKTsNCj4gLSAgICAgICAgICAgICAgIHN0YXRp
Y19icmFuY2hfZGlzYWJsZSgmY3B1X2J1Zl92bV9jbGVhcik7DQo+ICsgICAgICAgICAgICAgICBz
dGF0aWNfYnJhbmNoX2Rpc2FibGUoJmNsZWFyX2NwdV9idWZfdm0pOw0KPiAgICAgICAgIH0gZWxz
ZSB7DQo+IC0gICAgICAgICAgICAgICBzdGF0aWNfYnJhbmNoX2VuYWJsZSgmY3B1X2J1Zl92bV9j
bGVhcik7DQo+ICsgICAgICAgICAgICAgICBzdGF0aWNfYnJhbmNoX2VuYWJsZSgmY2xlYXJfY3B1
X2J1Zl92bSk7DQo+ICAgICAgICAgfQ0KPg0KPiAgICAgICAgIC8qDQo+IEBAIC02ODEsNyArNjc4
LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG1kX2NsZWFyX3VwZGF0ZV9taXRpZ2F0aW9uKHZvaWQp
DQo+ICAgICAgICAgICAgICAgICB0YWFfc2VsZWN0X21pdGlnYXRpb24oKTsNCj4gICAgICAgICB9
DQo+ICAgICAgICAgLyoNCj4gLSAgICAgICAgKiBNTUlPX01JVElHQVRJT05fT0ZGIGlzIG5vdCBj
aGVja2VkIGhlcmUgc28gdGhhdCBjcHVfYnVmX3ZtX2NsZWFyDQo+ICsgICAgICAgICogTU1JT19N
SVRJR0FUSU9OX09GRiBpcyBub3QgY2hlY2tlZCBoZXJlIHNvIHRoYXQNCj4gKyBjbGVhcl9jcHVf
YnVmX3ZtDQo+ICAgICAgICAgICogZ2V0cyB1cGRhdGVkIGNvcnJlY3RseSBhcyBwZXIgWDg2X0ZF
QVRVUkVfQ0xFQVJfQ1BVX0JVRiBzdGF0ZS4NCj4gICAgICAgICAgKi8NCj4gICAgICAgICBpZiAo
Ym9vdF9jcHVfaGFzX2J1ZyhYODZfQlVHX01NSU9fU1RBTEVfREFUQSkpIHsNCj4gLS0tDQo+DQoN
CkknbSBvayB3aXRoIHRoaXMgcGF0Y2gsIGFzIGxvbmcgYXMgJ2Z1bGwgVkVSVyBtaXRpZ2F0aW9u
JyBpcyBjb25zaWRlcmVkIGEgY2xlYXIgZW5vdWdoIHRlcm0uICBJIHRoaW5rIHRoZSB1cGRhdGVk
IGNvbW1lbnQgaW4gdGhlIGFwcGx5IGZ1bmN0aW9uIGRvZXMgZXhwbGFpbiB3aGF0IHRoYXQgbWVh
bnMsIHNvIGlmIHRoYXQncyBnb29kIGVub3VnaCBJJ20gb2suDQoNCi0tRGF2aWQgS2FwbGFuDQo=

