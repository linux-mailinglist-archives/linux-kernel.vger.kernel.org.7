Return-Path: <linux-kernel+bounces-788459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DC9B384E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF76F686BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2123570D4;
	Wed, 27 Aug 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g8DwhPbk"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5B1E008B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304733; cv=fail; b=n5Qw9Rn8rdC03sFz/79R38AxE0QKIsk8xlFfKo7fsOz8MNdZNhmNKmhJVxr28sM+gbQFT1eUzjYNVaYfmyhHG3iP+X5+iqaWVPB66y42zyARxXJHk2icwBJCdi38vtIt38bwUoaIpldMVB79XYE6U7QlJ22rwT5IuOhafc/qDTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304733; c=relaxed/simple;
	bh=CoeUQaYDebaRA7CLxeATkYUOrNb5Cmd4QoxrXHuv8ok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKPG0bvyL+9NOzpQzCsnMylkNDMWWtUkIFx7S26zdUbsnbZVZ2UKES+EnUe7D3QHlpfY5w80Hilp8TT/qQapfqHw/yxPZWGIFCAVhzXIp1EcJuCIWExxiCRkfwiyuubpMBwO/pDIrj6xwEo+natK5vLIhy1zKztkEE+JeG2YfWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g8DwhPbk; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBIfzyZjX5PHUT4ibvKHIsvfmUdisvYPIpfFUU34ZBk+YSvvzDZVK9HgMrnvdqIKrFsu5m07DUKVlYBw4Gxztezhp1O8nEca4ampQlhoqxy23RE/9TjDbQbEjCkI/TNZH89EcDQs+WrHxKTjyhNLXqi5HH+YexS/GG3Xdjc4iUdfliyrfIJBEhmsGIDd2spf8V5HEDdCtHROAGinXcIA4assvMivu9nLbbPLySTLBD6fZOTYobrY/j9G5hIyN3s03I9WJLJBWDz/yU8wQaxFYrvTEBgj1qWwCX3t90HxP9P/RGms7sA3JA7NOWjhLjbUyKqDmj2LanjtS5TQ7UO4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoeUQaYDebaRA7CLxeATkYUOrNb5Cmd4QoxrXHuv8ok=;
 b=gPhwAhGGON7DjQJhCFUttZQsr178rEtYNLMIPSXNdQ97p5AthSrfPg60tnxOTK7W9KjAtpXr1ZJHWs7oYdRGEMYDQHuDahapyKIfCErmm1r2iN9owSl6X7ipzPS4eaJfwOE+YHl1Ak023HLpE95qbCyaMISTEzJxJzb6lzLid2+AWkXGFsI20YVBRYRSUlUTyCafSAGFWTepuKHnJ4HhnER+F1dO7LJKxf4CPqknXI5vCt10CnrRirGiMHVAFtmk7UpdgK/kO6tj3G0VWMfN4mwoR9+42fHl5phH5Cg+0zYPtx2nEqBEHJ0NNz49xJ90/amvIDPrfQRlMGIuGgHmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoeUQaYDebaRA7CLxeATkYUOrNb5Cmd4QoxrXHuv8ok=;
 b=g8DwhPbkmfZXh/niS5OK5yuIUXPvFRR1kBuzRoaXhu6ch4TBzpQWYsHJsbi0m5HIHQMlsA+3bTF7YD2tjWawTwi+2oQTahlxFkpfAJdl96VWlGsqaCAkTIrlIFoRv1873G6WEWlGEcGcXZbrQHpNc45Fbp8M4gMTar17NurZBaM=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 14:25:27 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:25:27 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Thread-Topic: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Thread-Index: AQHcEmNJ5LXItfJ3EEGTlLKvZSsitbR2VbgAgAAKGoCAADDXIIAABpWAgAAAcnA=
Date: Wed, 27 Aug 2025 14:25:26 +0000
Message-ID:
 <LV3PR12MB9265934929BC29E635C39EDD9438A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
 <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
 <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
 <20250827110403.GFaK7mIxwsQ9IF7ML8@fat_crate.local>
 <LV3PR12MB92655023C50A92BE30D7A8049438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827142225.GIaK8UoYo-rnR9T2OD@fat_crate.local>
In-Reply-To: <20250827142225.GIaK8UoYo-rnR9T2OD@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-27T14:24:00.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CY3PR12MB9578:EE_
x-ms-office365-filtering-correlation-id: 9539049e-043f-43fc-8431-08dde5759167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHhFZWlQV0MyTVgzcnFWa3RRckptR0RRSk5IUTBBa0hiRk1aYlJ1RHlCZFdE?=
 =?utf-8?B?YU1JbnpRSU9Ydkw5MGE0TTRuTFZRQjlZNlZvNURHRit1a3VhbnNhalhXOFdD?=
 =?utf-8?B?MzdMUGt6cVBDUTVtelVOUDdlWkNzTDN0c2RoWFh6UGRsUXJVME9wNFhpNDEz?=
 =?utf-8?B?N0pOTG15VWlCbVozR3Uxd2JwTXluVkp1K3RzZWNQbUpnSWM4M1owUnBjMjNC?=
 =?utf-8?B?WnF1REpuODlPQmF0emcxTmlmNENUTE9lVHE3MllnWkhFVjBKZWpzVTZNVkdi?=
 =?utf-8?B?RzFsNG9PSFpNN1JicjBFNlZGZ1FJT3FyaVVRQllydjllY2FhWjNuZWNmS3Mz?=
 =?utf-8?B?bDVoR1Zab0czcUJzcHpYZEFOeTNQejlWbE92eFhBaGdReEVhT25BMVdFblhL?=
 =?utf-8?B?eDZqS2xaUnByTkRydm1WeFRtbEUwMnJnMWE5VWJTZXdpRC95QmdlSktMMkhj?=
 =?utf-8?B?U3dhc0p0Y3RmK0RTMEQrZFhqbHoyUzYyMU0rWXllak9GS2xPR0FyTDlPYnl6?=
 =?utf-8?B?OVFqNmRpMCtHd0dVeVMzbzBFYzFQeFFoNmhVSXoxTUpKVFdIcEZ4bzlVdUhu?=
 =?utf-8?B?eFBYa1EwRU5sS01wY0tVU05CWWhBNU5NUEdiTVRKRGZUYVNva080SmxlalpQ?=
 =?utf-8?B?Z2YxVmc3K0lEelpDRHhCdGFlYTFLTnFETUVRRTNLOWZJSVl1eThyaXk3QU5D?=
 =?utf-8?B?aEdDb1JUVTlBemV3eENQWGtrVTkvL2hGNFpkK1VYeVI5a3lpWldGZTVrQ0gz?=
 =?utf-8?B?YnJodnNpWStIWXpQZ0VJVTJrY21pTjVBeExpNHhFekM1UHhxUnltQjlTZmhG?=
 =?utf-8?B?azlCdjJuR1JRVHgyN2dZOWtvamlkTEN5ZGNXTE5nQVNGK2dZdzhDdU0rV3hp?=
 =?utf-8?B?dC9rMW0zRVVvYzVhdUM1eWQraXdiZExTdndmMEpYanNCZnhWKzRoa0Z5eFBM?=
 =?utf-8?B?MzB4VGcvQ0ZlY25ScW5kK0VjRXJIYTEwb21HQ2F6OCtzMldDQjYzSGJkTHRS?=
 =?utf-8?B?d2xScWZYYzhBUjZSaEpQbEIvaXRXaXVwbmdhQ3JSVVhxeHBnTTZyNjBRMHF5?=
 =?utf-8?B?WWY1MmE4dXZ0TlRkdG5BMmFkSDJjdG9JZTJMMlZSZENxajY1Z1RydzkwSG5t?=
 =?utf-8?B?M2RJdGVuLzdFcmVSYXNBVGhZQ3EyeDFhdXBGOWdLeXM5YlNBWldRb1MrSzlD?=
 =?utf-8?B?WjVJTmMySWlvT0F3c2RsVlhMTk16MVVMb2tLU3RqcHVsdkRXY2pLcFdHZENJ?=
 =?utf-8?B?NXNJWUo1UVkwRE13TkFTSXEvOU9mMnJGZ2lHOG16VllZK2RIc3FaaTZLRGsr?=
 =?utf-8?B?dThCbmdEdGpvazFTYXF0TjRXTGF1aUtmSnYrSytjMHZqZUtVU3NOcjVwUy9Q?=
 =?utf-8?B?dHFLQnZCdDJkUGJhMDR3Qm5GV1JMSW9OWW9yaGlFQ00vdGNZSjVWUkhHbGQ5?=
 =?utf-8?B?Z0h0OGxUSFM0cDFiVlJMSWxWNXNETVVNVGZkREhHZ1k1b1l3VnNFSkpEUFJO?=
 =?utf-8?B?bUR0RlJZbk9zZ2RnYmxYcWc2ZjFtVnRFWWpOZ1g4RmRudXlMZ3BpM29nSnpM?=
 =?utf-8?B?dkpQeUdRTUt1ekY5YlNnYnJ3M3pWMmZWQXpoZVVMMzN4MGg0bmhPQWFrYW1O?=
 =?utf-8?B?WjNiVHhhQS9laCtkOHJjb3gva3pTNFRvVGRuN2pxYWRjV0Uvbmd3dll4UjBN?=
 =?utf-8?B?M1MvQ2FtRlU1cFBPRWNLc1ZMVDRwUS9adFZrMXBxWm9lU0NYSjRFeFQzNnhy?=
 =?utf-8?B?WmUrUHdpQUlwOWJPUGtPTy9yUDl4YkFRY2hnTHpTME4xbUg1d0NJWkVPYzll?=
 =?utf-8?B?Vjg3UUdnSm5Lb3FoUFpzbWlYb2J4bHNtWWdubjMzZjVCUkhVVS9ORmJRUHZn?=
 =?utf-8?B?ZlcveVNzUEU5VTF1K0FCSHZ6ZGVoaGIwSzAyVTViNTJIaWwybk1Xdy9STFhu?=
 =?utf-8?B?VlhXQmtSd2Vpek96eCtCYkFEbEgrcjMza2ZxYlFwUHpNU3hnZGZ1d2l3ZFlr?=
 =?utf-8?B?SzBacHZzbFlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXlsenNlMmJEWDRjOVo1a1dQRG1Sb2JXcTNHamFZbzE2ZVE3dEVSUzZmZFE5?=
 =?utf-8?B?YXRocURYTWdyb0VQZWJBS3IwbXNSM0E0VjdDdm5pTEVrNXBab1NYUGd4Vlly?=
 =?utf-8?B?b0x3dFYxSTZ0MnJNeDNLOWVCTnlwMUMzWWdhN01pNXYvaUx1NEYyQWVZQ1V5?=
 =?utf-8?B?SzNuOHNSc3A1bzhPUEJ6VHZpaHFRQ2tsU3JuUElGK3BOcTZ1clQxNFo3K25X?=
 =?utf-8?B?MWw5U2s0TUp3aUlHR25FVEhpNkc2L3ZhajZFOFEveUJsSlljTUo1VGx5VHBV?=
 =?utf-8?B?V2lja2hzV1R6c1RjMXVubG5tNEEyMEVvU0piVG9iNFJSeTFsODdnb2hlamxI?=
 =?utf-8?B?dTVTU1NEVnJueTdWMUxhZEg5dW84THdZSTRoTUlkN1BLYzNhQUkrdEc0cVdk?=
 =?utf-8?B?cE5BTXRLdVdDMkpEaHJqRDdDZnRwblF2SU1XL1FCa0QreS9JaHdSZFRvMGZp?=
 =?utf-8?B?eGVPMUxtVVNmWkdiWS9rK3BQZzZLQzZacWR2V1Fab3AxUkJSVy9tYVBUNDkz?=
 =?utf-8?B?cHQwbE40U3ZQTHp5SW9teHVLZ1p2REQrUWcrL3NUenBPZk5JL2VyeFRJWW11?=
 =?utf-8?B?NnBOZTh0RU95NUVIUGhFTWVxcEN0RUZ5ZDlGU2g3eVQ1WkdYaXV4YUN3UWZ1?=
 =?utf-8?B?cTNER2NHRnNHSlUzTnpHWkd0bHFIRTJEQTNJb3cxdEdqWFgyVkdndTVsb3JH?=
 =?utf-8?B?QUZOalZPY1h1dURzeDE1SXl3VlpDQ3MwNE1ieEZ4eFJXai9ZMjFmZ1VPcFlB?=
 =?utf-8?B?ZithbEM0cVlJS2RwTTBrZDFMWTlsT25qRnlBbm5NVm1kS3MxQk5BR3NUWUpy?=
 =?utf-8?B?cTc3SVFDSGVlM1VpMG8vZWRkZjluK3liaUYzeFVWbml3eFM5QWFNZUxTaVMy?=
 =?utf-8?B?VUc1eFhvaWpzQVlLNXV2cWEwTyt6WE5VTXcwTlJkNGZScDZmU2Nuc2pkeGFG?=
 =?utf-8?B?aWdRR1FuVHhDLzc3dzlxeEpuU3pZeFllNUVQMzVMWWVuZWpCZER3QlArWG83?=
 =?utf-8?B?akJYYkV5SForbFNFb2g0TlJkWFZNWVNLS1lHVmRJVmhGSXBIZ1ZOZ21xMCtt?=
 =?utf-8?B?UXdNWHpCNCswempBRThoaU42aTNoaXU2am52dVNPc2hDNjBqVndMRlBYOENi?=
 =?utf-8?B?Z2tKams2RVFGZm9Qb0tIVTFYTDlJekxkRERDQndNcFdnOXlsMTI2MEdsODBs?=
 =?utf-8?B?WjBFY0dsUkN1ODdLWGJXT002ekJ6VWw3V0ttMkpTUythb3gvSk8yMFgyTmo3?=
 =?utf-8?B?V3VSdjQxQiswWTJGdWhsVHZzN0Y3WE1lZ25Hbmt4azNLbnFQTnVqRmJuL0xj?=
 =?utf-8?B?d0FBb2Z2TDIrRDQ0WE9BL3E2cERlcFNhR0lFQ2VLbVFsUlNNK214RlYranFx?=
 =?utf-8?B?b3kwcVB0enlBRDYyS3ZJbm84STlLL0MrT0NuUVFwNWVXUllocXNjS3FlZ0t4?=
 =?utf-8?B?dXdlblFjYlhITjV6L1FubGU1bEUyTFFxVWsyb0ZDcjgrUUtRU2NvcGl6UzI1?=
 =?utf-8?B?RXl6eEVTMlhycXVKZThNK1Zhd0pJdVFpb1NsY2Y1bWRuWDVQVVZRMW9uOUFx?=
 =?utf-8?B?QzF1cGZsMTdlaFQ3Q0dYZ1crWDZ0S0FrdkVxeHBibGd6WTQrRzVSbFJ2Rlc3?=
 =?utf-8?B?VXF5VlNreWVsUjRFS0phMTkwU0pIUmoza2QzS1BqTzA4Nkltd0JRSWd4YTkr?=
 =?utf-8?B?anUxZDgzMms3blEzd3lZVVB6TzRGa3FNekpTVERQbU9aRW92UVM4MTVEdjJJ?=
 =?utf-8?B?am14T210bndVb3dSSGlZVTRVTUpMQkxTNmM5T1NYYkJvbmxUZFd6S2c5bGVR?=
 =?utf-8?B?WTRLcDRUYWlTekJoNDlWRVVyVzBlc3oyNng0T0szVDVyMTd5bVMrTXpQc0pN?=
 =?utf-8?B?aUgzSXI4NEJrQmZMRktWc3Y4ODhLbXM0dnF1cGsrSDJ1UzBNbXp3cWorQXVH?=
 =?utf-8?B?Mlg1ZmxUdGVvc2E2QXlERERuMHkxcEpQNWtDTmRtc0JKV3VHa2RSNFdydDJZ?=
 =?utf-8?B?SGsycFNYcDA5Q2REQnhpQldOYjZVZGh3UHBzbEkxTHV4R1RRdHBIR2pTc3gx?=
 =?utf-8?B?NUdNT3NMb1F6cnRZUDFWYTNXMnRBMm16ME1DekkwZDZzMFEzSGUvOVhTTUVa?=
 =?utf-8?Q?96qA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9539049e-043f-43fc-8431-08dde5759167
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 14:25:26.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEJtUsxuV8tK7T2YM0LGJk3nd4RBPhTvIXQvVHswh8Zstwicpj4dT9tKD4IZvjSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjcsIDIwMjUgOToyMiBB
TQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENjOiBQYXdh
biBHdXB0YSA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgVGhvbWFzIEdsZWl4
bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+OyBKb3NoIFBvaW1ib2V1Zg0KPiA8anBvaW1ib2VAa2VybmVsLm9yZz47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZSBIYW5zZW4NCj4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgNC81XSB4ODYvYnVnczogQWRkIGF0dGFjayB2ZWN0b3IgY29udHJvbHMgZm9yIFNT
Qg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFs
IFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywg
Y2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFdlZCwgQXVnIDI3LCAy
MDI1IGF0IDAyOjA1OjE0UE0gKzAwMDAsIEthcGxhbiwgRGF2aWQgd3JvdGU6DQo+ID4gSWYgeW91
IHJlYWxseSB3YW50IHRvIG5vdCBwaWNrIHVwIHBhdGNoICMzIHlldCwgdGhlbiB5b3UgY291bGQg
bW92ZSB0aGUNCj4gPiBzaG91bGRfbWl0aWdhdGVfdnVsbigpIGNoZWNrIGludG8gdGhlIHN3aXRj
aCBzdGF0ZW1lbnQgZm9yDQo+ID4gU1BFQ19TVE9SRV9CWVBBU1NfQ01EX0FVVE8gb25seS4gIE9y
IGp1c3QgcGljayB1cCB0aGUgY2xlYW4tdXAgcGF0Y2gNCj4gd2hpY2gNCj4gPiBhbHNvIHJlZHVj
ZXMgdGhlIG92ZXJhbGwgY29kZSBzaXplLg0KPg0KPiBJIG5lZWQgYSBtaW5pbWFsIGZpeCB3aGlj
aCBnb2VzIGludG8gNi4xNyBub3cgYmVjYXVzZSB3ZSBmb3Jnb3QgU1NCLiBUaGlzDQo+IHBhdGNo
IHdhcyBteSBhdHRlbXB0IGF0IGRvaW5nIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+DQo+IENsZWFu
dXBzIGNhbiB0aGVuIGdvIG9udG9wLg0KPg0KDQpPay4gIFRoZW4gSSB3b3VsZCBnbyB3aXRoIHRo
ZSBzdWdnZXN0aW9uIGluIG15IHJlcGx5Li4ubW92ZSB0aGUgc2hvdWxkX21pdGlnYXRlX3Z1bG4o
KSBsb2dpYyBpbnRvIHRoZSBTUEVDX1NUT1JFX0JZUEFTU19DTURfQVVUTyBicmFuY2ggb2YgdGhl
IHN3aXRjaC4gIEkgdGhpbmsgdGhhdCBzaG91bGQgd29yayBhcyBleHBlY3RlZC4NCg0KUmVzdCBv
ZiB0aGUgcGF0Y2ggd2FzIGZpbmUgSSB0aGluay4NCg0KLS1EYXZpZCBLYXBsYW4NCg==

