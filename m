Return-Path: <linux-kernel+bounces-856462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD32BE4372
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 683A54E46B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B84346A00;
	Thu, 16 Oct 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eW9WF9ZL"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AB32D452
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628417; cv=fail; b=GvQ+868bSu+AuBaf9icsiVlDCCVTHQPLJEaXJSSLvchMpiUNfNh4a8M9xnJa9WWJ0Ukzazs/gjnmKr8jr2HMt2KNQoHTeLZOOJf4uHemxwEw2dCuLPkFzDT38ZVIuZmEcqfEKF37Zg/KPvjxke5jG+O3uYRyMZAT3xd7o0d4UbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628417; c=relaxed/simple;
	bh=D800hqwrCUSu8W56yXSg9eyjBDmsNFKQmQBo8b96yJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGMSsCR8exFxIkLeIGsHBKRsS1Y+zhZziRCCFYHx6QmWxC6pAsKeO8RmVr52rqu7empGFKozkPWRgpWEq706O3sWS6c3WFxYIuD1bDNmBJGna3niSzmWRg+dc9tJjPtcJdKmTb7155rDJl4FOTd1mIdIKjkqWbOXuv6kNaSKI10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eW9WF9ZL; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9hkz/KHxOUVht4tTDXg4cCRAOpRbg7Nq7i4tu9nHHwoaYRusGUj8cKsBB2PXYZ2kg2w+bZgxwH6HF7rdXEqWEIHa61YwuKb4MRw3U5s+fYLxiGaQagmPUn/8k2p2q5zjXOD3bF1shpdM+7zK7ljZ3DuF7ALOQNTr/dxs2vVpI2gZUTfqouVfWX2L4lgeFlSD2SOwgRPp/piOyGLyOA41cTZHOfO+X2jMPNIh5WcLttZZ/XsTVkh48DFCH6zpdYqxMituoz+N8UzskVxVHAIsq726RgsXhn/RoSdByDuQ1oRjn5KmiX7mkdXy0pB2/cFKrg8KJevtn4f4ZPhH+6BLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D800hqwrCUSu8W56yXSg9eyjBDmsNFKQmQBo8b96yJU=;
 b=r/ToQd5CcHhjATM42bbtf8m3cn3oOgoE2PzUD8Wnf/FasrBgBk2pBloqB94FH1XUR04uydEMdEjICZudB9zfLO0lsyvuOykdKhG6v6xpy5o0QSi3vEpqHiR8vBLxLKSkd2sH6/0Dfe9rnUg4osl7p2uHgVL3TL7nFYuT0kaLT43xsW8TLHbWrlb4SpGUmhcMwU1iDz3YdWoNNn1FFIA4Zs84kEdMF1k+WBGC6j6pWQLMh360ZeO4lfDAJ9CSfCZexkC9vIF1PEHjcFXw6Ktp3GPk9pCoksaNhan13za4mnfYFrRKsb1XxsR5mZm5Kg5/hpdjqhc6EvWzawTRBfNWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D800hqwrCUSu8W56yXSg9eyjBDmsNFKQmQBo8b96yJU=;
 b=eW9WF9ZLVG7lmuOZ7Ht1URKgCilduF+zbqw6v8/tN5N785889YQcGeKUTEwUoz3Va/XZvrXfa/7rCZg1OR5pBYNVW4AZbHOim4DhmLUtnMJfUCH1pM020x74nrdq2teJNYKi9+xQCcUXX1xc2zQueTr7FXI7ozJqVB0Q6kD+dTI=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 15:26:51 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 15:26:51 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Brendan Jackman <jackmanb@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
Thread-Topic: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
Thread-Index: AQHcPpv1amtigeO6Tki9uQ+/RJo2ULTEybtQgAATQACAAAPaUA==
Date: Thu, 16 Oct 2025 15:26:51 +0000
Message-ID:
 <DS0PR12MB92733379567E36D5F84E83FD94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-8-david.kaplan@amd.com>
 <DDJRFMTS5HX9.3MT8W88VM4U2I@google.com>
 <DS0PR12MB92739B4BF6D4F35250F1B44994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <DDJU1MUCPR2J.14W8SU21KQK4F@google.com>
In-Reply-To: <DDJU1MUCPR2J.14W8SU21KQK4F@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T15:10:37.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|SA3PR12MB8761:EE_
x-ms-office365-filtering-correlation-id: fd0a964a-5bb0-4661-c667-08de0cc86e27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkI4dWNhTUt5dnVDT2FPUG1BU0gzMDk2NHVxOHNZazNuTk1MRWk4bFpyaE5T?=
 =?utf-8?B?ei9nemdHdHkwNCtuYTg0REducnBIWGFQRzIvLzRNbnR5dVhxcmJjckxveVMv?=
 =?utf-8?B?K1czMVBaSFRaYmRjZ2w3eDl0MEhVTVphdTBpdHpjNXRNR2VYSWZ0bmdFUjJ2?=
 =?utf-8?B?MHJteWVXSjFwNTBhSVdrMVhDakwvcHMwbWZySEk0MkhESTFzUElMYjJSUmZk?=
 =?utf-8?B?eUlOcDNRTGFpMmhoOVpGcWRBVG0yNVVBcldzWE04QnNCSXZCRm5kVUJiMjFX?=
 =?utf-8?B?RE9PUUZKaDhSQXc1NTl0WEtCVjZ1Y29XYWxVT1o4d1B6WlhEbWNKbUZlc2l2?=
 =?utf-8?B?Qi82cG40cWVXV2FTQjNQNFJFYlBBVjdXMllWV3U3Y3lPalYwZHFKTGgxWlhD?=
 =?utf-8?B?dTI2bk5vL2ZoNXFBSFpVOHFxU0V4Ry93Q2NGOE85Mk5nSWQzYkVSYUF5VHA1?=
 =?utf-8?B?ak5HRGdXR0VOMkk2L25oRkM2SmxhT2preTBLNSt5Q0lRZlZkVEZtRWIvbmg0?=
 =?utf-8?B?bE0wK2NpTU40Smhoa3k3ekxScTM2TWJFSDFlS0JmV2JXWDV6Zkx5cldUdXk5?=
 =?utf-8?B?M3VoU2wybHVObGhXQVhlZ1A3TzRCUFYvWDk1Z2ZzTmM1WktIbjFrZ2dRODBR?=
 =?utf-8?B?bjdvOWI2Lzl3SGVJYlNxdFMzbmxaWU1uZ0phN1ZHUm9aakhlbEZZeC94UUx4?=
 =?utf-8?B?VjUxSHpHT29xd05qRUxVYmhYL0xHdVM3c3BUUnRLQjFwaVFjM3JMYkRCeENz?=
 =?utf-8?B?OTNNZVJXMnZLWGRuaHE2YkhTdmc0aVFRUDVSRmVPdzVGT1hHanBUZkg2akZK?=
 =?utf-8?B?cGp5Zytnb21ydENJVlQvY1cyZEhZUVZSTUFidFh6K05XaXY2Mjd4dmozdjV5?=
 =?utf-8?B?ZnBIQUJlS0pUdUZPN1I4ZGg1UWwrU3l2dVZEZHUrVlErdERwZmdoT0xXK3Qv?=
 =?utf-8?B?L0tMdEM3NVRaaE9yK2xqc2EwSDJGeWdUWVRxUmxwNzlIYXYwSXh0L3U0QTlx?=
 =?utf-8?B?TWxQUE9PbUxTaGZtQVNSVi9hVHdiSEY0UGs1SWZQNTl3WWlEQjFiYXJ2NkV0?=
 =?utf-8?B?SU1RaTlLdFhNYU1BNVlzcnl0WTdQOU5SZzBzakxva1Vtb1prcnBwVGhyeTQz?=
 =?utf-8?B?bzBmUzJmSmZNdG85SC9oRjg2RlorbUtpekYvTFYxb3dRY2lrTDZ6Y3lxRUQw?=
 =?utf-8?B?eGU4c011MWJmYkVMVVVnK3BTSDc5bXdNNThhTmxCVGxLOXVqSWdRcGJYVHpi?=
 =?utf-8?B?emhwQmNjZ3lPT3JzOExjRTZkK21PclljeXN6VWdXRy85d2ZKcHdiQ3hiN1Nq?=
 =?utf-8?B?YXhydE9nUm1OdDNZdWpEVk5nMjBvelpCSld1UHFHMFhmbzMrbzNLN1UxVTVi?=
 =?utf-8?B?cWZGUUE4YW5lWXZ4cS92QndBdVhwWjMrQlRDcmhXR3EvQzRva2Q5WXRzbGlL?=
 =?utf-8?B?SG1YNEZCRmZqSXkwVkNZMmNQT2xlaHpUcVh1bTRNdEhsTXJ2KzFmeWtSS2lC?=
 =?utf-8?B?S3poMEwxSXQ1b1gvRnpkbFNoKzliYTRMN0syc2s1eFROVitOakNKS1AzeXgr?=
 =?utf-8?B?UHJmbTBPalNpK1Q4T3EzR1VnV0xYNWI5dE5WWEpndkMvL0txcExFYklvK1JW?=
 =?utf-8?B?R1cvNm0yWm5lL0ozaWkxdEtocHVydGJhRXdTUXpRejJBN05CQllVVHhkNzJj?=
 =?utf-8?B?WnRKdnNQMnd5REFyVHBXT2ljcUxnODlpZzg4WWNpdGVwalZ3Q0gzRWNSbkVz?=
 =?utf-8?B?TXpMZTBDNGhUNHk2OXo5ZFprVVdUOGpNM3pWd1IxWjZvVVhqN2JLNDdGeUFX?=
 =?utf-8?B?UXBkNzREdEt2eDNQWXlnZk5aaHk4MHNzNmhCOGhTMjV4OUlYVllmWjFJdVVz?=
 =?utf-8?B?MlVCYmphcG9xVW5sdXZ6U29BZ1NpWE5YN1Z0SVgwNElRWUVYU2laWkNldGpy?=
 =?utf-8?B?UUNNTW0xcHhNZXZlU05sNUthL1hVdnA1QTI3Tkd0dmZ5ZmRGY292elo3Vkhj?=
 =?utf-8?Q?lF2UkwML37TkFnXn3Nrpb6nhEVDy3g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUgzWkRYU1ZSYUJES1YvR0FYZVdLZVliNTVaOHlPUk5MbkEwVml0UHNDMzVK?=
 =?utf-8?B?aVJTcVlOZEczWkpFck9xak1ERVJWbTBrSWY5WWMwUVRwVGVIZGdJMXRWQUJo?=
 =?utf-8?B?S0xMSkJWUWlrZG9ybkxrQTZ3SnhCNG1aY0NmeFFmRjJpZndod1lMMlo0R3BF?=
 =?utf-8?B?L01mNjBjWUNJcE9QK2ZObmx1R0Y5TUdoZFRnT09qaXpmaXROUUd0SzVZY2M2?=
 =?utf-8?B?U2s4VTdiWW5RMHJTckV2SFIwTXNuc2p3a3krOTY0bWZpZUVrZ2RzR044ZGtJ?=
 =?utf-8?B?dnlCME5nVDJJcjg5SEdXUXk2V3dwMmFJTUsyN3J3azFtS2VYMzAxWHhTbDRa?=
 =?utf-8?B?aWJYNnI5czJRbXR3cVhYWCtINEZFUmRzYkNoTWIvam16Z1F2dlUxY3BMU0Uw?=
 =?utf-8?B?TXhVUUVVMEVMdE8vMjMrTXZZOGYwQm9JSm5vWDNKaDBSbVc0OEhpOGdnOENt?=
 =?utf-8?B?eG9rME81bEhqQ3REVFFSVE9MUFVOb0R4M3V5U0NMSFlGeXZ5ejNRMzBaVGZx?=
 =?utf-8?B?WSt5MitLS2REbWhOZ1ZxcHlmMndYaDFaQ0NucEFLK2w2eFJmTnZjN2VkOVdx?=
 =?utf-8?B?eTZMZE51RmFWY2MyNElhQU4vbVpqcDFQcUFNZHFQdkt3ektNdHU3aXdPeEYz?=
 =?utf-8?B?R0RwZHo1THl0d3dITlJpbG8xWnF6NUNPaCtKU1JsZHlwTVhzQjFJUm1hR3NP?=
 =?utf-8?B?enI3YU5YN1gwbG9UaW9LVmJoYUZRZW9xNm9xTkNHV3ZIbWV6aXExZ0F3TStC?=
 =?utf-8?B?aXBzOFNCdnVyaGNjNFVxMGJ4dXNqRUpLMmNhUWtJWnFIT01ka1l3Y0taSUJr?=
 =?utf-8?B?YVZid3NlUHFPb1RiMWxlejQ1R09lSFlXazlXT0ZVaHhZTWxOYlByNGRyMklw?=
 =?utf-8?B?VE1pZUxwOUE5NHpBMkNJRUVjazRqWVFaeGdSMis2aUZReWdYWWNnUlZmNFdy?=
 =?utf-8?B?cGtCUU5YMXNRdGxNaTMvWC9GUnRrdjBaUVBJTndmQWZ6b09NK003R1IwU2VS?=
 =?utf-8?B?TVlCNjVVSGpqV1pUdWdDZzh1aTBmZjJLdGFobnRIY0F5MFVVZ2ZPeGpWOFJ5?=
 =?utf-8?B?bVlZdXg3dHZCWkZtUlRwMnl6R3FnNXkyVHNXOWk5L1p6bTdQRVZqVlpYVzdR?=
 =?utf-8?B?YXZzaFdmdlhhNnVsTWpEK1BYZW51SWU3akhkb1c5cnBKT1h2UjVqN1F5NEd0?=
 =?utf-8?B?MHFYbUxnTUhaUGpuUTVUOTdVRGpRRnNlSS9XRjZpbEZpOEJEcitRQzJiYlZZ?=
 =?utf-8?B?UTdZeG5kSjE1VkRGbHhUaVV5NVo1NWZ6SGw0WWI4dGtGWWJVb051L1FjM1FU?=
 =?utf-8?B?SVJCb25TM3Erei9ES2hVMEhzbnZhaURWU3ZhU0phL0RqUDZqdldZeHJxc05V?=
 =?utf-8?B?S1RNQkYyTUwreXRzekY3RFZ5aExFM1FJQ3BmQ3VkY080TGIwd3YyNGJyMklw?=
 =?utf-8?B?ZVJkblV2QWpWZXNMclRRRTdpcFBEKy9uVWJiY0hUUXRsMlhHNU84eTVncEE0?=
 =?utf-8?B?K1drUjdJWFpjNGRtSDVaOUt3OUpwSlFsaFkrOHo1YmYwT2FSZWp1dFBDaHZh?=
 =?utf-8?B?S3BXaEs3cGtEdG5UK0dBTTdUVmVjR1RWak13T1VNbElySlhXRzdnaEE5TGhI?=
 =?utf-8?B?a0ttendzamtXWHQ5V2dZMmExenY3cWE1Tkg0UExocldpVW1jU3Z1Ti9HS1Bv?=
 =?utf-8?B?VHZtREJDYS8vMmVvYTlDc2dUeUI2VmZRY1VreHlucUNvd1hJcnFCaUtteXZT?=
 =?utf-8?B?WHBNK0hCNlNTODZqQWh4a0Y1aFpqV2V5TVZMZU9aek1mVWJtSldCTHlSdkZW?=
 =?utf-8?B?NW5Ienp0dldBd0pkQ1g5OWxSZENxMzRiUzFpRXRjcUN5Y280NWM4NWFFWks5?=
 =?utf-8?B?cy9SZDBDNW90SDBzUjZ5KzFSRVl4WE01K3Q5UHh0VjA3YU1TblhsckxVcVUv?=
 =?utf-8?B?cFNVeS9jZGJ0TENwaXllWEZvc1FkZk53VkdSTmNJMmowNEdwa2lEV3IrU2NQ?=
 =?utf-8?B?WmM2RDFRRFFJLzNjWWZUeElCQVlMdG85c0p0R09FVmpLcW9pSGdxNDc0VHVT?=
 =?utf-8?B?VGVPY0pCdjRDVjhCdVF0NFFhTzVNeUhZNUdoQXYxMjQ5TDZzNVZ3WjBvUG9l?=
 =?utf-8?Q?y3JY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0a964a-5bb0-4661-c667-08de0cc86e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 15:26:51.4199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LTpsiVEjKQHl66GZeWNEzkQei5AA1k+/LpmRPdy6eyCWGAYTGnqxUCzj983nKvC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEphY2ttYW4g
PGphY2ttYW5iQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1
IDk6NTcgQU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgQnJl
bmRhbiBKYWNrbWFuDQo+IDxqYWNrbWFuYkBnb29nbGUuY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0
Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YNCj4gPGJwQGFsaWVuOC5kZT47IFBl
dGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpvc2ggUG9pbWJvZXVmDQo+IDxq
cG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3YW4gR3VwdGEgPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4
LmludGVsLmNvbT47DQo+IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZSBIYW5z
ZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47DQo+IHg4NkBrZXJuZWwub3JnOyBIIC4g
UGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+DQo+IENjOiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBh
bWF6b24uY29tPjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNv
bT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFU
Q0ggMDcvNTZdIHg4Ni9idWdzOiBSZXNldCBzcGVjdHJlX3YyX3VzZXIgbWl0aWdhdGlvbnMNCj4N
Cj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBUaHUgT2N0IDE2LCAyMDI1IGF0
IDI6MDYgUE0gVVRDLCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBCcmVuZGFuIEphY2ttYW4gPGphY2ttYW5i
QGdvb2dsZS5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1IDc6NTQg
QU0NCj4gPj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgVGhvbWFz
IEdsZWl4bmVyDQo+ID4+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT47IFBldGVyIFppamxzdHJhDQo+ID4+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3YW4NCj4gR3VwdGENCj4g
Pj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9sbmFyIDxtaW5n
b0ByZWRoYXQuY29tPjsNCj4gRGF2ZQ0KPiA+PiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4Lmlu
dGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPj4gPGhwYUB6eXRv
ci5jb20+DQo+ID4+IENjOiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMg
T3N0cm92c2t5DQo+ID4+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDcvNTZdIHg4
Ni9idWdzOiBSZXNldCBzcGVjdHJlX3YyX3VzZXIgbWl0aWdhdGlvbnMNCj4gPj4NCj4gPj4gQ2F1
dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVz
ZSBwcm9wZXIgY2F1dGlvbg0KPiA+PiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5n
IGxpbmtzLCBvciByZXNwb25kaW5nLg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiBNb24gT2N0IDEzLCAy
MDI1IGF0IDI6MzMgUE0gVVRDLCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4+ID4gQWRkIGZ1bmN0
aW9uIHRvIHJlc2V0IHNwZWN0cmVfdjJfdXNlciBtaXRpZ2F0aW9ucyBiYWNrIHRvIHRoZWlyIGJv
b3QtdGltZQ0KPiA+PiA+IGRlZmF1bHRzLg0KPiA+PiA+DQo+ID4+ID4gU2lnbmVkLW9mZi1ieTog
RGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBsYW5AYW1kLmNvbT4NCj4gPj4gPiAtLS0NCj4gPj4gPiAg
YXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMgfCAxMyArKysrKysrKysrKysrDQo+ID4+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4+ID4NCj4gPj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3Mu
Yw0KPiA+PiA+IGluZGV4IDFmNTZjY2I1ZjY0MS4uNGNhNDZmNThlMzg0IDEwMDY0NA0KPiA+PiA+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQo+ID4+ID4gKysrIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9idWdzLmMNCj4gPj4gPiBAQCAtMjA1Niw2ICsyMDU2LDE4IEBAIHN0YXRpYyB2
b2lkIF9faW5pdA0KPiA+PiBzcGVjdHJlX3YyX3VzZXJfYXBwbHlfbWl0aWdhdGlvbih2b2lkKQ0K
PiA+PiA+ICAgICAgIH0NCj4gPj4gPiAgfQ0KPiA+PiA+DQo+ID4+ID4gKyNpZmRlZiBDT05GSUdf
RFlOQU1JQ19NSVRJR0FUSU9OUw0KPiA+PiA+ICtzdGF0aWMgdm9pZCBzcGVjdHJlX3YyX3VzZXJf
cmVzZXRfbWl0aWdhdGlvbih2b2lkKQ0KPiA+PiA+ICt7DQo+ID4+ID4gKyAgICAgc3RhdGljX2Jy
YW5jaF9kaXNhYmxlKCZzd2l0Y2hfdmNwdV9pYnBiKTsNCj4gPj4gPiArICAgICBzdGF0aWNfYnJh
bmNoX2Rpc2FibGUoJnN3aXRjaF9tbV9hbHdheXNfaWJwYik7DQo+ID4+ID4gKyAgICAgc3RhdGlj
X2JyYW5jaF9kaXNhYmxlKCZzd2l0Y2hfbW1fY29uZF9pYnBiKTsNCj4gPj4gPiArICAgICBzcGVj
dHJlX3YyX3VzZXJfc3RpYnAgPSBTUEVDVFJFX1YyX1VTRVJfTk9ORTsNCj4gPj4gPiArICAgICBz
cGVjdHJlX3YyX3VzZXJfaWJwYiA9IFNQRUNUUkVfVjJfVVNFUl9OT05FOw0KPiA+PiA+ICsgICAg
IHNwZWN0cmVfdjJfdXNlcl9jbWQgPSBTUEVDVFJFX1YyX1VTRVJfQ01EX0FVVE87DQo+ID4+ID4g
K30NCj4gPj4gPiArI2VuZGlmDQo+ID4+ID4gKw0KPiA+PiA+ICBzdGF0aWMgY29uc3QgY2hhciAq
IGNvbnN0IHNwZWN0cmVfdjJfc3RyaW5nc1tdID0gew0KPiA+PiA+ICAgICAgIFtTUEVDVFJFX1Yy
X05PTkVdICAgICAgICAgICAgICAgICAgICAgICA9ICJWdWxuZXJhYmxlIiwNCj4gPj4gPiAgICAg
ICBbU1BFQ1RSRV9WMl9SRVRQT0xJTkVdICAgICAgICAgICAgICAgICAgPSAiTWl0aWdhdGlvbjog
UmV0cG9saW5lcyIsDQo+ID4+ID4gQEAgLTM4NDQsNSArMzg1Niw2IEBAIHZvaWQgYXJjaF9jcHVf
cmVzZXRfbWl0aWdhdGlvbnModm9pZCkNCj4gPj4gPiAgICAgICBzcGVjdHJlX3YxX3Jlc2V0X21p
dGlnYXRpb24oKTsNCj4gPj4gPiAgICAgICBzcGVjdHJlX3YyX3Jlc2V0X21pdGlnYXRpb24oKTsN
Cj4gPj4gPiAgICAgICByZXRibGVlZF9yZXNldF9taXRpZ2F0aW9uKCk7DQo+ID4+ID4gKyAgICAg
c3BlY3RyZV92Ml91c2VyX3Jlc2V0X21pdGlnYXRpb24oKTsNCj4gPj4gPiAgfQ0KPiA+PiA+ICAj
ZW5kaWYNCj4gPj4NCj4gPj4gSSB0aGluayB0aGlzIG1pZ2h0IGJlIGZhaWxpbmcgdG8gYWNjb3Vu
dCBmb3IgdGFzayBzdGF0ZT8gRS5nLiBpZiBhDQo+ID4+IHVzZXIgYm9vdHMgd2l0aCBzcGVjdHJl
X3YyPW9mZiB0aGVuIHdlIGlnbm9yZSB0aGUgUFJfU1BFQ19ESVNBQkxFIGNhbGxzDQo+ID4+IHRo
YXQgd291bGQgZW5hYmxlIElCUEItb24tY29udGV4dC1zd2l0Y2ggZm9yIHRoYXQgdGFzay4gVGhl
biBpZiB0aGV5DQo+ID4+IGVuYWJsZSBpdCB2aWEgdGhpcyBkeW5hbWljIGludGVyZmFjZSB0aGV5
IHByb2JhYmx5IGV4cGVjdCB0aGVpcg0KPiA+PiBQUl9TUEVDX0RJU0FCTEUgdG8gdGFrZSBlZmZl
Y3QgcmV0cm9hY3RpdmVseS4gSSBkb24ndCB0aGluayBpdCB3aWxsIHdpdGgNCj4gPj4gdGhlIGN1
cnJlbnQgY29kZSwgZG8gSSBoYXZlIHRoYXQgcmlnaHQ/DQo+ID4NCj4gPiBJZiBJJ20gcmVhZGlu
ZyB0aGUgbG9naWMgY29ycmVjdCwgaWYgYSBwcm9jZXNzIHRyaWVzIHRvIGRvIFBSX1NQRUNfRElT
QUJMRSBzYXkNCj4gZm9yIGluZGlyZWN0cyBidXQgc3BlY3RyZV92Ml91c2VyPW9mZiB0aGVuIHRo
ZXknbGwgZ2V0IC1FUEVSTSwgc28gd2UgZG9uJ3QgaWdub3JlIGl0Lg0KPiA+DQo+ID4gQnV0IHRo
ZXJlIGNvdWxkIGJlIGEgY2FzZSB3aGVyZSBzcGVjdHJlX3YyPW9uIChha2EgZm9yY2UpLCB3aGVu
DQo+IFBSX1NQRUNfRElTQUJMRSBkb2VzIGdldCBpZ25vcmVkLiAgQW5kIHRoZW4gaWYgc3BlY3Ry
ZV92MiBpcyBjaGFuZ2VkIHRvDQo+IHNvbWV0aGluZyBlbHNlIGxpa2UgcHJjdGwgdGhlbiB0aGUg
cmVsZXZhbnQgdGFzayBmbGFncyB3ZXJlbid0IHNldC4NCj4NCj4gRXIgeWVhaCBnb29kIHBvaW50
LCBteSBleGFtcGxlIHdhcyB3cm9uZyBidXQgdGhlIGlzc3VlIGV4aXN0cyB0byBzb21lDQo+IGV4
dGVudC4NCj4NCj4gPiBOb3Qgc3VyZSB0aGUgYmVzdCB3YXkgdG8gaGFuZGxlIHRoaXMuLi5ldmVu
IGlmIHdlIHdlcmUgdG8gYWx3YXlzIHNldCB0aGUgdGFzayBmbGFncw0KPiBpbiB0aGlzIGNhc2Us
IHRoZXJlIGNvdWxkIGJlIG90aGVyIGNhc2VzIHdoZXJlIHRoZSBwcm9jZXNzIG1pZ2h0IHRoaW5r
IGl0IGNvdWxkIHNldA0KPiB0aGlzIGZsYWcgYW5kIHRoZW4gZ2V0IHN1cnByaXNlZCB3aXRoIGFu
IC1FUEVSTS4gIE9wZW4gdG8gaWRlYXMgaGVyZS4NCj4NCj4gSG0sIGlzbid0IHRoZSBpc3N1ZSBv
ZiBzdXJwcmlzZS1FUEVSTSBvcnRob2dvbmFsIHRvIHRoZSB0YXNrIHN0YXRlDQo+IGlzc3VlPyBJ
IHN1c3BlY3QgSSdtIGRvaW5nIGEgYml0IG9mIG1vdGl2YXRlZCByZWFzb25pbmcgaGVyZSwgYnV0
IGl0DQo+IGZlZWxzIHRvIG1lIGxpa2UgYSB1c2Vyc3BhY2UgYnVnIGZvciBzb21lb25lIHRvIGlu
ZmVyIHN0YXRpY2FsbHkgd2hldGhlcg0KPiB0aGV5IHNob3VsZCBleHBlY3QgLUVQRVJNIGhlcmUu
IExpa2UsIHRoZSBkb2NzIGRvbid0IHNheSB0aGF0IG11Y2gsIGJ1dA0KPiB0aGV5IGRvIHNheSBz
b21ldGhpbmcgYWJvdXQgd2hhdCB0aGUgcHJjdGxzIGRvLCBhbmQgdGhhdCBkb2Vzbid0IGluY2x1
ZGUNCj4gYW55dGhpbmcgYWJvdXQgdGhlIF9yZWFzb25fIHlvdSBnb3QgLUVQRVJNLg0KPg0KPiAo
QlRXLCBpdCdzIG5vdCByZWxldmFudCBoZXJlIGJ1dCBJIGFjdHVhbGx5IHRoaW5rIC1FUEVSTSBp
cyBhIGJ1ZyBbMF0pDQo+DQo+IFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvRERKVTA0
MTVKRUJRLkgyU0Q5NDJOTURXWEBnb29nbGUuY29tLw0KDQpXZWxsLCBpZiB5b3UgZG8gUFJfR0VU
X1NQRUNVTEFUSU9OX0NUUkwsIGFuZCBpdCBzYXlzIFBSX1NQRUNfUFJDVEw9MSB0aGF0IG1lYW5z
IHlvdSBjYW4gY29udHJvbCBpdCBwZXItdGFzay4gIEJ1dCB0aGVuIGlmIHlvdSBsYXRlciBnZXQg
YW4gZXJyb3IgbWVzc2FnZSB3aGVuIHlvdSB0cnkgdG8gc2V0IGl0LCB0aGF0IHdvdWxkIHNlZW0g
d2VpcmQuDQoNCkkgZG9uJ3Qga25vdyBpZiBhbnlvbmUgaXMgYWN0dWFsbHkgdXNpbmcgdGhlc2Ug
Y29udHJvbHMgdG9kYXkgYnV0IEkgYW0gbmVydm91cyBhYm91dCBjYXVzaW5nIGNvbmZ1c2lvbiAo
ZXZlbiBpZiB0aGUgQVBJIGlzIHJhdGhlciB1bmNsZWFyKS4NCg0KT25lIHBvdGVudGlhbCBvcHRp
b24gaGVyZSBjb3VsZCBiZSB0byBhbHdheXMgcmV0dXJuIFBSX1NQRUNfRU5BQkxFIGlmIGR5bmFt
aWMgbWl0aWdhdGlvbnMgYXJlIGVuYWJsZWQgKHRlbGxpbmcgdXNlcnNwYWNlIHRoZXkgY2Fubm90
IGNvbnRyb2wgdGhlIG1pdGlnYXRpb24gYW5kIHRoZXkgc2hvdWxkIGFzc3VtZSB0aGUgc3BlY3Vs
YXRpb24gaXMgZW5hYmxlZCkuICBPciBtYXliZSBjcmVhdGUgbmV3IG9wdGlvbnMgdGhhdCBhbGxv
dyBhIHByb2Nlc3MgdG8gc2F5ICd0cnkgdG8gZ2l2ZSBtZSB0aGlzIHNwZWN1bGF0aW9uIGNvbnRy
b2wnIGJ1dCB3aXRob3V0IGFueSBwcm9taXNlIHRoYXQgdGhleSdsbCBhY3R1YWxseSBnZXQgaXQu
DQoNCkFzc3VtaW5nIHRoYXQgZHluYW1pYyBtaXRpZ2F0aW9ucyBnZXQgbG9ja2VkIGRvd24gbGF0
ZSBpbiBib290IGFzIHBhcnQgb2Yga2VybmVsIGxvY2tkb3duLCB0aGVyZSBtYXkgb25seSBiZSBh
IHJlbGF0aXZlbHkgc21hbGwgcGVyaW9kIG9mIHRpbWUgd2hlcmUgdGhlcmUgaXMgYSByaXNrIG9m
IHRoaW5ncyBjaGFuZ2luZyB1bmRlcm5lYXRoIGEgdGFzayBzbyBtYXliZSB0ZWxsaW5nIHVzZXJz
cGFjZSB0aGV5IGNhbid0IGNvbnRyb2wgdGhlc2UgdW50aWwgdGhpbmdzIGFyZSBsb2NrZWQgaXMg
b2s/DQoNCi0tRGF2aWQgS2FwbGFuDQo=

