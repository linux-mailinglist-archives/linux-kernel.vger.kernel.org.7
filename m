Return-Path: <linux-kernel+bounces-782179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24EB31C55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A25A1D41EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B3305E0D;
	Fri, 22 Aug 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NGYbxBfV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B342048
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873435; cv=fail; b=TN3ThMs+Jcn3y3K5Jb4t/3JOc8AP/a7HYlx8n4eoWgwwrN7Vkrnf0YGO1253jbr2i2rXsQg+aYb/D3yvohiBhdOyw+XZGyhyJWGTWQmj3n8FntVAFsnoqXNEGyFDxq6YeNk+ADKnYbvJpaBcXDP1rnL133eX0ngXSRP7xO8Bs0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873435; c=relaxed/simple;
	bh=GxUAv1m/uItmPmFu/aGZCjTjTfK9Uuy5sL2m8sCg/Zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uu8JcwPmlfmHE7273/ej7NcNCQOuKIOhRgdjpEGpY+fUVU6/WN6dEaW6DnEanUOudJoIM9ZhzluQ60dr+gd38p/1W/G0FzmErV14VWxgmVid/gfoTSg/fG1NBoyaWZm5lx6NDiOcAVjrdOm8EoYe16dR7KSGG+80LAFt4Ajzs6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NGYbxBfV; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bStuAlD9iVze5nITqXVAVz3jq+ECdYFTy5B/O09nH2Xvz/Xmap3Z+JTYkropj2yJr+49MsfJhsmvdQMATlt9iypi4ybbIz7aomcYfkPNFJVQ6KcLAN/HXmXCCznfGO9rLyv4cup7KzmcUC+uk8te0x7LsnhEm6CSlr2Is4fJhpfdQDhfanwq+ptxEvgnjSRlYohF2ElSB4YdSHgja0mh0LHAb6zzM8xHXrLfXq4oAnZD3Az4HfU7KaIsww7rNtITOnk/VsNXAHXIUmPsw/bjMHx6Ka5zKwzYLIeqNVTh0UHSGDJtvhyyeGPz85EwUPz9tBWS7K77cnAKniWXsKzJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxUAv1m/uItmPmFu/aGZCjTjTfK9Uuy5sL2m8sCg/Zw=;
 b=R0FmQrVKMMgLojlSpggRii78G7y5RvOdQy4lBHbIiWpDrq/pPISZaqGsj3WVTxNYn9zw2h6WctYijpzqBkJFJ+79lAmgLJqBtY7Pr04x1+G2bJJU0K585l9crqriWm/9TscBPcU07GBG8ciroC9+g19k8wTjh7zFejBozPSkt6lk9tpuWWwOZaHKXg1FgDVL115qhf3MrezaZQ5Rr8JlPIMegVS/f9qxne4Lmnc7REmHd96u+jJMfz46AijzzTgAKO97mp9bKMDwjEB9IgTDCRlEMicgy2OtLJcXufXNpxFilr2P1Kw9v3ujM4A4CJ/7Jcambqyy7cg5JF8GyVsdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxUAv1m/uItmPmFu/aGZCjTjTfK9Uuy5sL2m8sCg/Zw=;
 b=NGYbxBfVx7TI5sNplTFFtpiHfxrthqm/K28hdeusoIR++hqhbf8u9/qJOoMYElVAJiIAg+FI/bMle/oo58S3Z8VoFgxdFlmPxPdYayuj4l40LH/VyWBM68SAnPPaR4lKdqf7dlXonNbxe7ECZI7lBVv+z2yjdMkgjzfqI0/SXFs=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 14:37:09 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:37:09 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] x86/bugs: Use early_param for spectre_v2
Thread-Topic: [PATCH v2 2/5] x86/bugs: Use early_param for spectre_v2
Thread-Index: AQHcE1reQABwsv3XzUmOUufzJ3QV8rRus+wwgAAH5wCAAABRoA==
Date: Fri, 22 Aug 2025 14:37:09 +0000
Message-ID:
 <LV3PR12MB92650F008E4BBB480CF987AD943DA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-3-david.kaplan@amd.com>
 <20250822114918.GQaKhZPrvA7zP33TX4@fat_crate.local>
 <LV3PR12MB9265EFE40F2C8EB7C15BBD06943DA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250822143012.GFaKh-9DsBRQfapi87@fat_crate.local>
In-Reply-To: <20250822143012.GFaKh-9DsBRQfapi87@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-22T14:31:19.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|BL3PR12MB6450:EE_
x-ms-office365-filtering-correlation-id: 4aec45ce-9087-4a4b-abaf-08dde189600a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkNlWUZJN3JnRXppUWpaNVV1R1RucHA1QTBra21zdmM5czdVTk5xWjJWNEpm?=
 =?utf-8?B?REE1c3VwZTQ2cWFDcmZpaXd5c3hYUFlrVEdmclM5OE5xeWhmMzMvcmFxZys0?=
 =?utf-8?B?bTUzeWF5ZnZXZlZmRURQc0ozWkxMVVgwdzhlaFpxT1FGcXNjY2xaUi9URTQ1?=
 =?utf-8?B?SXZRRXBhRk54T3lmRGN6QnlMUXNiTWliMTFJbEdKMXV4UVBlamQ0NlowUFpx?=
 =?utf-8?B?UWZscXNoMlAwdDA0cEw1ZjRReCs5c1E0dmxhMWhiVzFPV2hQUk5DVzJlZGFX?=
 =?utf-8?B?N2pCRE1ReHVVRFVWVE9UZmNMd3FnbHpGbmlHUjZLQzdESW8rdnpwN2JMUzZO?=
 =?utf-8?B?bmhMRldHUnN1NTdra25hRm5Jbk05RXg5OStLTkNCd0srVEcvOXI1bU9iMmZN?=
 =?utf-8?B?VzErTzh0Rm02NW41UFR5bXpHZURKejdRbjNrVXdRSjlVVVE5ZC9hMDVkemNy?=
 =?utf-8?B?KzdmT3I1b0xWZEVpSWEzQTZadllXbzlpWDRLK2k0SlFNWURkd2YrWWxsckVT?=
 =?utf-8?B?YUNSSU9CSU50VGl6Zk1CYWcrMi9hc2VlTDdvZXB6TUNWZUNzWmFlWmdaWmJS?=
 =?utf-8?B?VWdxNUFTcTFpbDBPRnhONEhwYVowOGRwRDB5U2hVN1JHMlNJa2hJMDhpUnpu?=
 =?utf-8?B?eW9kajNzN1V5MWtWRGp4bHorR0M1UUt6dTBUUDFFZTlvQklEKzF0R2FyUlph?=
 =?utf-8?B?S0VtbFdSWmI1Y2xhWFgyZHMvZVRFZVYyRHU0K1Ywb0J4RGhIaHpSMm93Y3hh?=
 =?utf-8?B?TFNDdzNOdk1PUXI5dkV1OXAvUG1DVnRyUmxrTm4waXUxVWx2cVErRnM0VjlJ?=
 =?utf-8?B?N215ZFhyR2F3SDRCUUs2dnhQblNMLzdUU1lNV3I1YVlxemVzNU84bWYvWi9Y?=
 =?utf-8?B?NWtRWXpaNE56VUJjS2FrVnFZc2lYN0djT2k0MmhLNUk2aVFzNGs5cURTZDI4?=
 =?utf-8?B?eFd2bXZ6MmJDbnR5TkE2OFl1cklPVGtnQzRCVTk5SWVRdFptNWVBY0s4ck9z?=
 =?utf-8?B?dHdsMjNEejgydHV4NzgxaloyelNiVGpHMy9TbFFWVUJLaWQ5ZVRkVlM1SDZh?=
 =?utf-8?B?L3BEZ3NRUFk0Q3dUa2lkQVppMUdudU5JYlErSHhEZHZISGROeEJSRWxIc2Rh?=
 =?utf-8?B?Q3l1a2NlMXVQb2grUlVyQTJZQ05WWTJKNnFkYUE0b09QVUs2blBrR0t3cDgv?=
 =?utf-8?B?aTRlWlI2NktJNkZabDhnbklKZzl0STI1R2YyZXBTMnN3L2E3T2ljMG9FTHYw?=
 =?utf-8?B?aXBMYzhGQnNxL0l6RFJtWlY1ejBHLzZXMnByRHZreW10UnNnaDlVTG4xOVZF?=
 =?utf-8?B?T3dhV1psbmxxL1lxUXVYa1VrYXc1Y0REa0dkREhNbWd3YW0zejE2elpmNDhB?=
 =?utf-8?B?UWVLUzM5NVBxVEx3Sys0bVEyZWlaSkdDU1RjdWMxZW9BOHpLK0VjS3hJU1Vq?=
 =?utf-8?B?dkxyWUNCcXBHVnJyZHF0cGlUblg1ZEhIcEJZWU9GNGlQckNaNDZqdkdCVDZa?=
 =?utf-8?B?ZGdkQ3dYZkEzcGp4ckpSWkRCVkJMOWZYQkhyQzZtejFhcE1KK0xLUnFMeURX?=
 =?utf-8?B?OFZHQjRFckJTSEswemlRODQ3bXgyNVY2VDgxOFZITFlNSGx6aXRqRit3eHRy?=
 =?utf-8?B?T1k5dzBkRzRHckh3Zzhad3ZNci9SU1htMkcwUGVsRjNLOW5pQTk4aDVGcDIx?=
 =?utf-8?B?ZnhXK2JCM3RtNVpkRUhUa1FEZThHcmgxOWNzU2w5ZnVaR3ZwWG5OWmZvNDRt?=
 =?utf-8?B?UlZOVVJpTkNYV3drQ3VMbHY1NFZPUURGQllzWWQvQ3lzSDY0RnZKVmtCWkUw?=
 =?utf-8?B?NDAyWWdHTWFCNzBiRjJqcFJncEV1ekxEc3BDVW1FWk52WG80Ulp4TlAwZGMy?=
 =?utf-8?B?b0k1WnZkV1kzWisyVkxmbllZRkRDUDBJTGhkeS8vV055akdQREdGN0JHZ2xr?=
 =?utf-8?B?MWtERHUrQm0wQ3VHN3ZmaWRHdklxak5nSnNwRTlIandFU0RwKzhnS1hJTHNs?=
 =?utf-8?B?TlNrb25WZ2dRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDZBalRhU3Mway90ZnEwaFZkUDl0UGpTUzh3ZzdFVGIrZHZNZVZTZW8zQlkz?=
 =?utf-8?B?RnIwVW5NZWdibklDK2VDNkhoY2MxczNxS2V4cDNoYWVsL01qaHYxcWZuUUJr?=
 =?utf-8?B?QWdDS0VqbmJnaDFHMDdUUjJSTkZHbVJFTXhranJnSCtxT09WUTBIL3BhK0hN?=
 =?utf-8?B?dlVWN0V2dFRIRXR6UXFGSm52V3RZdVRXSVhnNHdNOVE0d2dnZTZHeWlrOEg1?=
 =?utf-8?B?U0t1bXNPK014d0I1Vzk2c3ltMUxSUkxscmc4MTFvMTR5Ty9haDZUZ0dGdU5r?=
 =?utf-8?B?MVl4U3g1V25sNVdHU2syYkJmMCtmK1Vad01sWEVmemxZZmxyUENmU0RBeEtw?=
 =?utf-8?B?bkQ2b1MxdnpjSm5NTm9jYWVyc2diZzd6ZVIvendJUnl0VVNOcExqcFZoN01n?=
 =?utf-8?B?aFpwanlEd0F1ZklRQzhFQ092SWVqVGxBWmxGZnBvWFYxekxRMCsySXE2RjVy?=
 =?utf-8?B?LzRHMzgwdmZaSXVnNjNMNDBlYTJmclV6ZytjOUo1NWFBUU1aNVZ2TzFiWXJp?=
 =?utf-8?B?ZGkrS3Z6Nk9DUzkyMCtjRUdLMUYrTTliQUNpS2tsaVdoTTBOOGtidW44UWZz?=
 =?utf-8?B?S1d1cXMrU0ZIZXVuUndIejJUaU9vczNLbVFOOWFyM0tXWmpza0xkNVZhN0JV?=
 =?utf-8?B?R1BnK3N6RFFHdVM2RjNBZlBoQ3ZMSjdWVnhZbVZoYzMreXFxckkyU2l5SEov?=
 =?utf-8?B?R2pxV2xaNGtOcW83MDdzUWdoREpseHgzbllVR0hLRVZQa1RzMk1EWlFvRDc3?=
 =?utf-8?B?a0JWU1ZuUVJubDRqQ0pwdWVWTU81N3U1aE9GMkp5NnBjOGErWnVBZlVoNVNn?=
 =?utf-8?B?TC80Y3Q5ZVAwN3d0UXpHQVpBTFByT1hzem1RRUtMd3JNSkFBRlA0aFQwVVZk?=
 =?utf-8?B?aFg5cUdKSmNRTU1zMkZuN3YvNFpPUktmNkN4dGVHdzl6TTJ3V2h2U2hEeDlL?=
 =?utf-8?B?TjZLUDQxWUxEaUlwdzJGbXh2ZFBoYlQ0UWttdnB6RFVsSVNaZnplMkpVRXlE?=
 =?utf-8?B?eTkzR1FENjdQRU1rVUloNytxMG1ySTliOXY5RzNCQjhneWNjM3c1M2dWWWVo?=
 =?utf-8?B?UjlZL0hvZlFxSHNtcTYzN0s4Q1dlTFBHWFdOWndHRW5YaXZrVlZZZFRic1la?=
 =?utf-8?B?Q3Q2VXJCQUlLelh1cWp1RE1rSCswd2kvMlZ3QzhGZldMZ0RwajNiTkE4YzVY?=
 =?utf-8?B?Qnk4WlVuRHNKTkh3a2R6ZVZleUlldWhnWU1BUWFMdmFkSThuYUZIZ0IvSEhp?=
 =?utf-8?B?NjlROEJkYjdtbk5iZ2dmdFljSnRZWXkxcFZ6cTYvUTlYbGlsUFdNTFFBTnZ3?=
 =?utf-8?B?elVOZE5wU0pMVVV6Ukd2UHpGY1hUQ0ZvL1NKUklnamlzdUVIN2VGaWFEZVJH?=
 =?utf-8?B?M251akVBZkFvdFFoM1ViWnpPRWpWK00zRGhubWJLUHRNcTg2MXdaeU9yMHdF?=
 =?utf-8?B?T1d0QjRVT1hTMmlCWWowdnMxMDd6c3VjcnZ5Qi82eFZrQjBuQzhkNWxQbWJX?=
 =?utf-8?B?dyszMldJdERqNVhHMUsvaDh1Wkh1Q3p4QnNtcmlFUncxRkZIam9oYStOKzFz?=
 =?utf-8?B?cDZ4WTV3dVFIQ2RhTjdiMDNqUWorN1VrQ0xBcVNDOW9kY2hjcVFmTHlyQWxS?=
 =?utf-8?B?ZGlsLytFaGtYR1ZxNlRydUJ6Ym9zdE9XejNwUDJDYURiYlhOMzZIY3EwT1R0?=
 =?utf-8?B?MG5ra0RXdUF4bUduZ1J1RVVhZHprVGtLcjBJTm9FS2ZpbXZMbEVoaytYYW8r?=
 =?utf-8?B?dGZuYnRGaDJ6SmROc2RLRHh1ZlM5S3dYL1dhcDNiQUtCWGR3MzZqWWI3Rkdp?=
 =?utf-8?B?U2hGbG12dm9IbysvQmxBV0F3Uk1VbENpcGthaTQyV2ZIdXErVm5lQnFXRDhx?=
 =?utf-8?B?NFU3ZktJZjRnUzMvVUduaXVGUnZNdVo4ZkhFVCttZzhSOWNKZ2JWUTlKTnFn?=
 =?utf-8?B?dG5FRDI3ckhIei93amoxazdrZG9HbEwxR29FeGo1S1Rza0FQcjJiM1FJZFhK?=
 =?utf-8?B?cFVPK1U3Zk4raXE5aTRuNkdCdm51SjcxR0Y0UVo2dWd3YnZsYWw2TjZtR0Uv?=
 =?utf-8?B?N1M3UWZXRloyaEJjNjA1NTdSOFExY2NmTVEvaUtwcmkxNEhuTTB4eTJMQ2NV?=
 =?utf-8?Q?saRE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aec45ce-9087-4a4b-abaf-08dde189600a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:37:09.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eH4Xk7uZ1qY0HehPVNpQlV+AEEsKruiSwZylF3aN2vkaiowwdyoCVyMWBLf4t/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjIsIDIwMjUgOTozMCBBTQ0K
PiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENjOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47DQo+IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3
YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9s
bmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4
LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRv
ci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgMi81XSB4ODYvYnVnczogVXNlIGVhcmx5X3BhcmFtIGZvciBzcGVjdHJlX3YyDQo+DQo+
IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gRnJpLCBBdWcgMjIsIDIwMjUgYXQg
MDI6MTI6NTVQTSArMDAwMCwgS2FwbGFuLCBEYXZpZCB3cm90ZToNCj4gPiBJdCBjb3VsZCwgYnV0
IEkgZmVsdCB0aGlzIHdhcyBhIHdheSB0byBsb2dpY2FsbHkgc2VwYXJhdGUgdGhlIGNvZGUgdnMg
aGF2aW5nDQo+ID4gb25lIGdpYW50IGZ1bmN0aW9uLiAgQWxsIHRoZSBjb2RlIGluIHNwZWN0cmVf
djJfY2hlY2tfY21kKCkgZG9lcyBvbmUgdGhpbmc6DQo+ID4gdmVyaWZpZXMgaWYgdGhlIGNob3Nl
biBjb21tYW5kIGlzIHBvc3NpYmxlIG9uIHRoaXMgc3lzdGVtLiAgVGhlIHJlc3Qgb2YNCj4gPiBz
cGVjdHJlX3YyX3NlbGVjdF9taXRpZ2F0aW9uKCkgdGhlbiB1c2VzIHRoZSBjbWQgdG8gYWN0dWFs
bHkgcGljaw0KPiA+IGEgbWl0aWdhdGlvbi4NCj4gPg0KPiA+IFNpbmNlIHRoZXNlIHdlcmUgdHdv
IGRpc3RpbmN0IGZsb3dzLCBJIHRob3VnaHQgaGF2aW5nIGEgc2VwYXJhdGUgZnVuY3Rpb24NCj4g
PiBtYWRlIHNlbnNlIHRvIG1ha2UgdGhlIGNvZGUgbW9yZSByZWFkYWJsZS4gIEJ1dCB0aGF0IHdh
cyBqdXN0IG15IG9waW5pb24sDQo+ID4gSSB3b24ndCBvYmplY3QgaWYgeW91IHdhbnQgdG8gaW5s
aW5lIGl0Lg0KPg0KPiBSaWdodCwgc2luY2Ugd2UncmUgbWFraW5nIGFsbCB0aGUgbWl0aWdhdGlv
bnMgaGFuZGxpbmcgdW5pZm9ybSwgSSdkIHByZWZlciB0bw0KPiBoYXZlIHRoZSBzYW1lIGNvZGUg
cGF0dGVybiBoZXJlIHRvby4gVGhlIGZ1bmN0aW9uIGRvZXMgZ2V0IGEgYml0IGJpZyBidXQgaXQg
aXMNCj4gY2xlYXIgdGhhdCBpdCBkb2VzIHR3byB0aGluZ3M6ICgxKSBjaGVja3MgdGhlIGNvbW1h
bmQgYmVmb3JlIGl0ICgyKSBzZWxlY3RzDQo+IHRoZSBtaXRpZ2F0aW9uLiBBbmQgdGhlIG90aGVy
cyBkbyB0aGUgc2FtZSBzby4uLg0KPg0KDQpTb3J0IG9mLiAgU3BlY3RyZV92MiBpcyBhIGJpdCB1
bmlxdWUgaXMgdGhhdCBpdCBpcyBtb3JlIGNvbXBsaWNhdGVkIHRoYW4gYWxtb3N0IGFueSBvdGhl
ciBvbmVzIGluIHRlcm1zIG9mIHRoZSBudW1iZXIgb2Ygb3B0aW9ucyBpdCBoYXMuICBUaGVyZSBh
cmUgMTEgY29tbWFuZCBsaW5lIG9wdGlvbnMgZm9yIHNwZWN0cmVfdjIsIHRoZSBuZXh0IGNsb3Nl
c3Qgb25lIGhhcyA3LiAgU3BlY3RyZV92MiAoYW5kIHNwZWN0cmVfdjJfdXNlcikgYXJlIHRoZSBv
bmx5IHJlbWFpbmluZyBtaXRpZ2F0aW9ucyB3aGVyZSBhICdjbWQnIGlzIGluaXRpYWxseSBjaG9z
ZW4gaW5zdGVhZCBvZiBhIG1pdGlnYXRpb24gYmVjYXVzZSBvZiBhbGwgdGhpcyBjb21wbGV4aXR5
IGFuZCBjaGVja3MgdGhhdCBoYXZlIHRvIG9jY3VyLg0KDQotLURhdmlkIEthcGxhbg0K

