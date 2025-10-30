Return-Path: <linux-kernel+bounces-878589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30EC21117
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A621A66B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7539190664;
	Thu, 30 Oct 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E0N5tLge"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434C368F3B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839369; cv=fail; b=WgnwQRxBMe1yXNOkNxlrqb6Mdf9duNMEaZTrjle5y2t8p9UXBl/ynJqA2zunBB/0DsoiWsQw+/Qhj6c2BxNkRv3HbOU4HOMZveotjNRMMjL3GOEtuTEHCMS4fPCLxywgGHhn10fGRaXBeglkz08j0+uG98KOaiMWRP92BWUbuFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839369; c=relaxed/simple;
	bh=fyuQVVNQXF+7/86LcCe3V5NI5S2lIJrHiBCKhjWfrW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I3LgnLt/RTxSwB1fH3hZ7HJipQts/Xq+WJz22DL3llqghJaNLExXkTCm/3bwl2tH+DRUvV8q0jFIjWk3oR09qi3VQxtszo193XZG+ZfQOyQHJpM0cYQSVF66vvki49He95jGmrSOl4UxJ4+OFyeoWY6n1NAfV5bkfV2cdh0FCwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E0N5tLge; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcNhEM2iprSBuTmBRngNuKnRe/2jYcqT41YcIC2Rqjz37TgsIWGsD2idr8nMohQWehaTgEuw8QEoXFXT+ay4irX7A4uS4bGyCDVqMuCs8vy0WtgOjW5TBPGQ+XUotZD127LSI5VM9z3bRmn991WcZX/fCc4Ia8pWjP0jwZkPsxm2ZPjlEfr6U4+ge7ZKdylZkCHMX5ajw+zHe6W1MMEo+twgL8XNZvDD+f2Ht50ZMHo5BODkqGdIuAGuVEEG5buYbH517EZKevbqFuN1Wn2UFpovXgWDt8C/a5dwdC5p8S0gcrRd1ubU0gfqAwkM8eqHdQpZJDbdkSFhgvW6X29AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyuQVVNQXF+7/86LcCe3V5NI5S2lIJrHiBCKhjWfrW4=;
 b=dCXm64RO36QyEf3w/W8I2D4LQHs1UyyISzzsaGieTrLWaMQH8J7WJBmijQg/2fQzg/i2dBzPEaMInqGgHVvcpcHtQ9bnjdIDZ2fAqUzIIMvO+cBJGl+M1K3fr76uaBHIrMwZwvQT1FgJW4u1JaVFTpZZ7GBojeOU9+K6h5OanZtenjwVndz4Ayh96iwmtQR5Tssd1P1NcGPGtovnIc0Xtz6Wvmq7uq8If5P/H+yeztB4kjYIDp6sNXGvt45yc57aDPu8gMpFaWe/Hv372GZQzJdTQafh+K1mKsZez5C/rOqRM3EadOfxcIOR1W+BFreztV/yOYm/zQOsNDKKlCLjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyuQVVNQXF+7/86LcCe3V5NI5S2lIJrHiBCKhjWfrW4=;
 b=E0N5tLgeGQQva/VZQrXhDqfEAJ6RsceceWO/AMDDHe8NpH85ROX2pr/flNzRVG/7ZsC823+Bm2PaNNu4Ln2cdA2ZUSReTWDw31feUQJz076DNjUG/4FcYXJW9QBRTY7D86hxA9+fEc52djM9/m7wU7QwNHJL0sy7EtOK4X57HXU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 30 Oct
 2025 15:49:22 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:49:22 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, David Laight
	<david.laight.linux@gmail.com>
CC: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: RE: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Topic: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Index:
 AQHcPb/dNJRwYJelJ0iZ+pcOgQN837TDNq5ggBK5IwCAACi5EIAC2zOAgABxyTCAAGG0AIABENNwgAAUL4CAAAGl4A==
Date: Thu, 30 Oct 2025 15:49:22 +0000
Message-ID:
 <LV3PR12MB9265382A2DC4A7840E21943194FBA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-35-david.kaplan@amd.com>
 <d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
 <LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
 <LV3PR12MB9265E559972E1C6693AAE7E794FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <5f1fa90d-5c84-43e6-a99e-ef4a215b5055@suse.com>
 <LV3PR12MB9265295E1470ED9C5BE9EF9094FAA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251029221416.5b33e1fe@pumpkin>
 <LV3PR12MB92650036427F97D5F2413BC694FBA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <2ae957fc-b686-4662-9e10-6dca1f10c749@suse.com>
In-Reply-To: <2ae957fc-b686-4662-9e10-6dca1f10c749@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-30T15:48:51.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH7PR12MB6787:EE_
x-ms-office365-filtering-correlation-id: ca233628-b950-4ed6-43f8-08de17cbe540
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWhhWHVaeGVBV0lDUENQTTROcmN6ODBOSmIwY0VoeUk4K2NTbEZSRjBxUk5I?=
 =?utf-8?B?TUMyT1NONUhCL3RNRGRxYjhGbFQ3YkRSL1RSaFRnYjQwc01hWldlMXZLTGRK?=
 =?utf-8?B?RkVqbDVWblErZWMwLzBhbXZpbGFUeEdUamZhZGFkeFlwWXg1cExVNHI2OUlh?=
 =?utf-8?B?R1BHNUlTMGxJOXQrUEJtNmlDcnE2MzgxVGFuUkpCSlp3VlBuUm5yZ01FZWh3?=
 =?utf-8?B?a2Fjd0V0K05FdmFMSk9jOE4vcjFnUVpmdyt6Tk9wV2xLc0xGZzkrZ1VyNDVq?=
 =?utf-8?B?UU1GTTYvbTRVd0M5TDdCUHBwRGNXeU94K2xselVTNTZ3TFl4dUhNdVpGKzZn?=
 =?utf-8?B?aHpMYVBtTWgySGN4UVpMcE1zMnlOTXByMWIxeGthekphTHA4R2kwZUI5VW1x?=
 =?utf-8?B?eFpDcWc5aitKdmczbEZSa1ZKR3d0K2syQjQvMHAvV09pakZlMUhZUXJQYjhh?=
 =?utf-8?B?N3NlbWxqSFBrdXhpMDNoYnU5Q0lBd2VsK2tmZ204NUVQUndsK2tHZGdkand3?=
 =?utf-8?B?UEMzWEZRcHhUZXlXWVY0UzlrRExGYTUrTVlwdjZicmtYNkRnTjd1NU5wb1Nv?=
 =?utf-8?B?N2NOWlNVQzhKZDhYT2tBTC9kOHFHeG5TTmRlRklDd1ZpeVJFckYyYU5jTWx4?=
 =?utf-8?B?MFpXU0w5dHFpUFRjV1J4Vk5CVmZpS1I2OVlpSEZDZ3U0V0lmdkttUEIrR1Bl?=
 =?utf-8?B?WkUzUkFZT05lcHY3QXlKcVN6UGZVYUkrSEZqd1ZhajZ6UFlYMGJxaXBaOGY4?=
 =?utf-8?B?Z2NZVzRTY1k3a20zTDZuNzRKNXM2VTdzcTlBRnFoMlVLT0NuMzZncTF6UGg3?=
 =?utf-8?B?bUVFNHZvSWFvdVRHR0IwblM5L0NKeHNtcVgzZVNFK3ZiY2RoWW4xT0l4T2lw?=
 =?utf-8?B?MVZ2Vi9iYXA1STNaNTR5OXVncENGRlh5d1pFV3dNZ3l1aWFjbGdQQmRMSStZ?=
 =?utf-8?B?RmJvUVoveS9lOE13WWg4ZmZpRk9sZmd3WkdmdkxMZHZZODZpdmVVck5KV0lm?=
 =?utf-8?B?UWhmbnNSejFKdWYvZ0Ewb2N0SGZ4Q21LZ3RveW8xV3RlM3dHUjQ5NzZjRUxQ?=
 =?utf-8?B?cW9XcENzMmh4T3dneVJ5VlFXT1lrSC9seHBRSkpUUkRHdUk1NDhMM2FGM00x?=
 =?utf-8?B?VmVzZlI1OGhUb2tEblNDbUxTaWtmRVpsMkxDb3Y2MHVEbm5qL2VqcFhodTJj?=
 =?utf-8?B?TFgzMmJ6L2hOSmlPejZtTDQySXZNY3RNTkozSEp0aFBjVTB3S1E0a2pOWmJu?=
 =?utf-8?B?U0pLbjlMaUQzaURKL3QzUUVwMlVCV1BRT0FxT1lEQnFzTDZHeU5OOWlWaVVI?=
 =?utf-8?B?empyQ3Q0anZOT3drcDNQcXFwYVk0Q2NUVFY5RlVNWW1SQzc3VnFBTHdNdnE5?=
 =?utf-8?B?TFRGYUxVRDJhanRlcnoxeTBsb2pwcG5NZ3UwQTcwZVRVZjdDOEY5TXNRUmRJ?=
 =?utf-8?B?dCtUU1BVMzdWSEZXK2ltZzBpMEYxalI4ZGFaT3owRGRkZ2FVL1dOS2hlZm1G?=
 =?utf-8?B?eTJDSWhIZjliTytRL2lSQlJSSTNxTzRJcENhendOallLRUdrTWdJZVUxRGJp?=
 =?utf-8?B?THYyaVhndm1oeGcvMVZCUFBlOW5aTlV0MEhhRHdoQ1hXQUlhTG1lMzVIL1J1?=
 =?utf-8?B?WGtUTFJQS0g5Wkh1RU50ZWZqbEREYUdJMTJyNkErdUU4VThndnZ5cVFFZEw5?=
 =?utf-8?B?cVhEblQ1TzlZajcyWG91ZVBweXkzVTZ0ZUFqRGhXUTdEbmZZLzI3bEtPQ01I?=
 =?utf-8?B?d2Q3NDBVc1l1czBNTlIwWXdaZWVOcVJJNkc3MitJRFpDUVhZaFNmbWJGSEpz?=
 =?utf-8?B?Rk5vN0RmbHJNa2FOUXA0MDBRVXkwdzJCSDFsaXJCN3JLcGpORDY0WE5pSXhN?=
 =?utf-8?B?TTV0OG16cDBYMWJyUkpOWUU5b1VTOUJHVUczMDhtU1BoaGxuYkhrRzFSRUdt?=
 =?utf-8?B?ZG9Ca09ESko4djBoaGh3czU5bUltTmpEdG9wYmV0M3R4TWVvRDlxcVZST2JB?=
 =?utf-8?B?ZUVVdVlveENtb3N1ZFErUytlREI1QlV0VTNjWmtNTmt6R1NXZWtwK3gvWlUx?=
 =?utf-8?Q?/oeyIy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bERNaGZQVW55SGlGcm10eWdGNjdMVzZuWHhqdDJucFUra3VjUXllM2djUUtY?=
 =?utf-8?B?ektlQTcvNDdMN2FGSTBTN2hzZnpsbFAxYTdaQnFYWS9PdW5yR1RZUTZ4NUgw?=
 =?utf-8?B?Y0tLNmtVYTNCQUY3V2tuKzkyTE9aV2ZSZ2NmSEdnSVFkcTBuWkdWTTh3RTZx?=
 =?utf-8?B?b0tVdU92Qys5TDdETzdkajZuaFM0WndDMVJKUXp0NTJlZ0dOelVCVmw1dm5D?=
 =?utf-8?B?azVXRjVUMjVsbGZURVYxSDNKY0x5bVN4ZnJzcmJlNDhTYzRBNWY2cDFwZE5l?=
 =?utf-8?B?bEJ0ZW1yaEVOKzFqYTUrSkpCVWcyOGNSWnNIdm9WWkFxVHF6NjBiRU5TVWJz?=
 =?utf-8?B?eEk2NnNBMy9uaHE0eHRLcFc2b2RwV2ZiTnBDQWdNVGlmMHNkdXRmRmkwVHpB?=
 =?utf-8?B?SFQyc1g3Z2tvZTNaTTR5UUZOYWdYTmJUSzJpTVlNQmQwN3U1UmJhRjRZaFZn?=
 =?utf-8?B?MmZrN3gyUThJaFdubUphY3RUbVEvTExDTjJEU3k1U0ROYzZSUG1USzZNd3ha?=
 =?utf-8?B?WVNIZkxzWUZ5b1JnMGNndjBHQVRLREhFVEgyQ0hYbUwzYjlsUlpUR2lNRkxk?=
 =?utf-8?B?dWh4OFdXSUJnRG9Cb2pDOEZCSVpVRjVqZzY5aVF4VkYzcVVFanpKSWlBaTVq?=
 =?utf-8?B?djVVOFVFWW5XUURhMlZtay8xWXA0Q3dxQzI5YVRpZTdwNkdkN0diQzBKMGdC?=
 =?utf-8?B?MGw5Rmsvb1dGUkdiWVBWM1djRzJ2eFliNktmQTBpSWhYMVUzYmNyRzlLdk1r?=
 =?utf-8?B?c05CYjNWWXJaaW5saDExZGRVS3FDVFVMUnRGV29JL20zS1B4NVJvbFVDVW5i?=
 =?utf-8?B?ajE0MEtjS1RiMjZTTTJTdE9LY1QrZS9NZ3hPeHVhSTV6R0dHd05GZDNOSEFx?=
 =?utf-8?B?Y3VOVCtDcUpFdDk0M0tDRTk4Szh3dUdVVGJoUHRJQzlQbExVYVVIaDc3YVkv?=
 =?utf-8?B?YVpURGFKZDFuaU9nb2VTUXFBc0VEU1Z4K2dLeG9iSzJwNDErL1pLa0V1QmEy?=
 =?utf-8?B?eVZKbDdBdkpIbE4rb1VJRjhaU1ByNEFKZmtic2NVeS9YU201ODlQekhQdVg0?=
 =?utf-8?B?N3NPd1NvZ2hLSXYvNFN1VXg2WFFsai9ZdjNiYkE5TExnWmR6L1lMLzZpMUxm?=
 =?utf-8?B?cmFNalpSZ0lEZFp5WjRPSHEwNG5NTm5seitYMHI2RS9HRU0rMStkWkZsd1g4?=
 =?utf-8?B?bm1qUmYrYmFPMHdJZlluL2RxNzlXajZxdU9PM2lFS21kc0pLcHgzSExYRVZk?=
 =?utf-8?B?S1RuazNDek1VRnVDZ01MdmZMdCtLVVpma3k1SDdZS0dVWmxvYWVkM0hXSTZn?=
 =?utf-8?B?dk94QktBZmtLRElSRWlvWVRJaVpBWXNOd3JETURmY0VuTXMxWGk1TG0rMzRX?=
 =?utf-8?B?MHBaNnBLU1dENnhKOERJMCs4OFQ3UllnS25neGtUTzBIbnEwNWJJVURKWndh?=
 =?utf-8?B?dGhhaFNLS0Rubk9iSlFoa3E4dHo5ZGF0bi9PS2daRkZieEhQRGc0bitFN1Fv?=
 =?utf-8?B?MnRFKzhZb0RhbFpzOXRlRk56TGxmcTZSMEhMVlNxbUZSL0xyVmtSMkR5WG5i?=
 =?utf-8?B?bnNkTEJqYWo1ajN6c2RsS1hnS0oydmJYUUpFOWJ6TFBjOE5pcHV6ZGYzYVph?=
 =?utf-8?B?Qkl2alhBUEFDOFRaazFVclVmRjdjdGU3WncvVDlHVGl0NkFHSjcyQWdXRVBT?=
 =?utf-8?B?YVpwOVZ2Q2RUNnFjRkRiU3VMdno0NmZYLzl5YU1SYnJ4bDR6U3U2WE9ENUt1?=
 =?utf-8?B?RHNoMW0vL3c3VXZBVjVTZ0RWOEpLWkpjN1NiUGUvQ0RMbE8xcDRQU0w0dGdy?=
 =?utf-8?B?d29Ub1RaMlRZQVlhQjUwd2RScDlvbGRFUHRubzNucWFrRnJ4UFpDVkJmMzFI?=
 =?utf-8?B?eGJFNThUSFBhTnZNR2lYcFc3VkNmcnZYUTRkQ21XeTVoeWVRam9HTFI0NGpM?=
 =?utf-8?B?RFhEM0dYUkhHTmFVYmVHdnkwQk80bXhoMXQwM01ML245aGIzYU5uTzdkWm1T?=
 =?utf-8?B?YmcvME8vUzVxTVVuOWdocXNFWnZLYU1kUWxUK250eU90a2ZXZDMvRGRMbXBZ?=
 =?utf-8?B?TE04N1dWanNXTkxDM1RDUUVJeG54clJFaFFNeFhoNEhaNEZTMHAvSVBOOUlI?=
 =?utf-8?Q?Gd7I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca233628-b950-4ed6-43f8-08de17cbe540
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 15:49:22.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bc5ucXDp1B/VRNWuTPRjzvGAQvPIiFm4twsnc49ASA/BUBa7wzLkjSKd2x9gS8jm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAzMCwgMjAy
NSAxMDo0MyBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBE
YXZpZCBMYWlnaHQNCj4gPGRhdmlkLmxhaWdodC5saW51eEBnbWFpbC5jb20+DQo+IENjOiBKdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+OyBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRy
b25peC5kZT47DQo+IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgUGV0ZXIgWmlqbHN0
cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaA0KPiBQb2ltYm9ldWYgPGpwb2ltYm9lQGtl
cm5lbC5vcmc+OyBQYXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwu
Y29tPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2
ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZp
bg0KPiA8aHBhQHp5dG9yLmNvbT47IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+OyBC
b3JpcyBPc3Ryb3Zza3kNCj4gPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPjsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgVmxhc3RpbWlsIEJhYmthDQo+IDx2YmFia2FAc3VzZS5jej4N
Cj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMzQvNTZdIHg4Ni9hbHRlcm5hdGl2ZTogU2F2ZSBv
bGQgYnl0ZXMgZm9yIGFsdGVybmF0aXZlcw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3Jp
Z2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdo
ZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+
DQo+DQo+IE9uIDEwLzMwLzI1IDE2OjM5LCBLYXBsYW4sIERhdmlkIHdyb3RlOg0KPiA8c25pcD4N
Cj4NCj4gPj4NCj4gPg0KPiA+IFllcywgdGhlcmUgaXMgYW4gOEIgcG9pbnRlciB0byBlYWNoIGFs
bG9jYXRpb24gKGFsdGhvdWdoIEkgZGlkbid0IGluY2x1ZGUgdGhhdCBpbiB0aGUNCj4gbnVtYmVy
IGFib3ZlKS4NCj4gPg0KPiA+IFRoZXJlJ3MgYSBudW1iZXIgb2Ygd2F5cyB0byBvcHRpbWl6ZSB0
aGlzLCBkb2luZyBhIHNpbmdsZSAnYmlnIGJ1ZmZlcicgd2l0aCBwZXJoYXBzDQo+IGEgMzItYml0
IGluZGV4IHNlZW1zIHJhdGhlciBzdHJhaWdodGZvcndhcmQuICBBbmQgbWF5YmUgdGhlcmUgYXJl
IHRoZW4gZnVydGhlciB3YXlzDQo+IHRvIHNxdWVlemUgdGhpcy4gIEJ1dCBJIHRoaW5rIHdlJ3Jl
IHJlYWxseSB0YWxraW5nIGFib3V0IGEgc21hbGwgYW1vdW50IG9mIG1lbW9yeSwNCj4gZXNwZWNp
YWxseSBjb21wYXJlZCB0byB0aGUgb3RoZXIgb3ZlcmhlYWQgbm90ZWQgYWJvdmUuDQo+ID4NCj4N
Cj4NCj4gSSBzcG9rZSB3aXRoIFZsYXN0aW1pbCB3aG8ncyBhIGxvdCBtb3JlIGZhbWlsaWFyIHdp
dGggTU0gYW5kIGhlIHNhaWQNCj4gdGhhdCBhbGxvY2F0aW9ucyBtYWRlIGVhcmx5IGluIHRoZSBi
b290IGFyZSBsaWtlbHkgdG8gZmFsbCB3aXRoaW4gdGhlDQo+IHNhbWUgMm1iIGJsb2NrIHNvIGFj
dHVhbGx5IHdoYXQgd2UgYXJlIGRpc2N1c3NpbmcgaGVyZSBtaWdodCB2ZXJ5IHdlbGwNCj4gZmFs
bCB3aXRoaW4gICJwcmVtYXR1cmUgb3B0aW1pc2F0aW9uIiBsYW5kLg0KPg0KDQpBaCwgdGhhdCdz
IGdvb2QgdG8ga25vdy4gIEknbGwgbGVhdmUgaXQgYXMtaXMgZm9yIG5vdy4NCg0KVGhhbmtzIQ0K
LS1EYXZpZCBLYXBsYW4NCg==

