Return-Path: <linux-kernel+bounces-884823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A292FC313DA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E053B912C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A73254B6;
	Tue,  4 Nov 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ij/3F4OZ"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0CF21D585;
	Tue,  4 Nov 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263025; cv=fail; b=ZCftqRU5kjTZO7XkRanupoD/Yy3V5KjpgdB+K6iEboQyM1FkV7a9j94vfftpx/eU4yP6v9TvmjtO+eHsAjVdFztfYmYTk313WwJb9oHQo0hsZ6QCSuv9yth4xPdJbBJmdkISnRdokk2L8H9qzQ7kYzxOLxkMBhGNA/hvtnTkvS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263025; c=relaxed/simple;
	bh=iaUrx7ge4fbBpVw11B3WjiFoyZL6jIqPCN2WEyt4X38=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=FmwngYxR/TiXuWREbqO674AflaUChrWZzA8aEjPV0XVoQUMDH2C3MAHxvnRgqM90cHClcbPnNEoXiGcBAhT/SNM7Dwar9NKaVfNnemqShnXmsSWhhZhxJSfhUEqLF5bZzQ2KhmkuyBb0jf/xXraAa6VPn6hcRrM8w5fYw0fKNjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ij/3F4OZ; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsoZn+47aJOdqNDiERdNoasK2hAspwTqkUsDNOATKh/xhhc7khdPziY9YSly0hRH4NaYDV/QmkEme865CuQ+2FJesGSIrBZGqDAr/ZamgIGMSEuKTn7mpYtISe+9mSS/+1rJ8H/XkayB+HcNWDihZhlwAKhKF8xVGEsMdGVck4fSFTHcTgYX7/MIfgOvh0YgXLvWG4vpDm7pIHIxOUcLngWpop8rbudOx9HJmyfsN+H6J268RyNPFvmtqdtrVMEhnAlTuyFK+CJaysP4LBpibaM+bUuGQI6eJzqcJN5uo3IOwlnDnNDuqoyS/v4RU6T5MyPD5GQrxZbUOyWjTXzrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr4R/T1hbadoy0edd3bed8Y+/+67l7gaouGmEOnp/RM=;
 b=R+IhCDVTYlUH/g+vMo4ysh5UJLwqQLylYBxEAh4YyLZWXId9xiL1O7lT3vGMWPs1nCirqF4FrTdti2OMatGyo1VtinQ1XMViQuUmsoof+OG3iVwhnv6VuN76ZPDOxFlkQzA3x+7kORvGQIZFn4trx0+EQpS1EvgyWcszIjY2RA0dZxLKwOcYdby2bgp5GpU6/0TzpZqto/B8Bdz7FrxQxsJ18BmwpkAOKfn/sX650jp3gjza4507eBn/LvUGKlRDVSoWl3LT4LJ00Y/Himw558yK5d+8736xXyUh7aFnEIi6IoaD8naHjv7BvZvtu1fJqyBvGxjFtP2GvEwpocgpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr4R/T1hbadoy0edd3bed8Y+/+67l7gaouGmEOnp/RM=;
 b=ij/3F4OZPE04yyDGjWjsOgVv0tC7hrfFikW2ZcFeGG/s3EmPS3e6QX0seu3i/NQ6GXr1JkEKhndX1qXRszaq8FPRm7W23n//lEL7OxLZlhzvIeBXPRiUUINJVyNXzuGlGt5HHUrDLXnmBcTgLb6+xlcxkRASVuxNideJpOKlToa0NoG9U/gC9e/2nF0Cf6VQGnurzr/rgoo2IcQcauGqu1zckMO1AbRlOSe4cw9RYOaYgOfXODHQIT/YFHJodZ70JAr7tk+zeeQ24SYl+9LFfVEyKkKHRT6JQik7a0Pc0k3yicJZ4wOoGQa9pbxFy3tI6DHyj7Q9rjNpt/pV9RIDWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:30:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:30:18 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 04 Nov 2025 22:30:00 +0900
Subject: [PATCH RFC] rust: add functions and traits for lossless integer
 conversions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-as_casts-v1-1-0a0e95bd2a9f@nvidia.com>
X-B4-Tracking: v=1; b=H4sIANf/CWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMT3cTi+OTE4pJiXbNECwsLo8RkA0NLIyWg8oKi1LTMCrBR0bG1tQB
 7a1LYWgAAAA==
X-Change-ID: 20251104-as_casts-6a8882ac0192
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYWPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: be8389f2-2e63-4fe3-a193-08de1ba64ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cy85eTc2QWE3cWhZMExwVlZJZ3ZEUEZCN0RsMFV4NVc3enI1SU82UkxFZmZH?=
 =?utf-8?B?MlZPRlpVSFkxMUw2ZzMyT1ZyRGZsSzRadmdVMFdqN2I2YXFTREUwY1dnaXVJ?=
 =?utf-8?B?cXhUeWowb29nVkdxUUZBa1o3OUdmN3RVdDFaQkRqdUxjSEJlNzZFN2pkNWJF?=
 =?utf-8?B?dkhpdUREK0xCa25FZ3JmMUlxeFFjdVVjekJwRUZUNGQzcWhDVkJmTklhQmFz?=
 =?utf-8?B?aC9Ea3VRRzN6QUpyMXhka0pWQ0hBcUNKQlowdWdha2lpZHVxMi83aDJ2R3RV?=
 =?utf-8?B?UWd0bU9PU1RuRGJaaEx1N3J0MERpeW54ZUJrRUZ4RFhtcDRaYWxESE5BVUtI?=
 =?utf-8?B?UTM1VjdzTW85STh5NkhWbWtKV2ZrbGVBU2k2UmlFS1ZnOTBTdkdnRWhuUEZJ?=
 =?utf-8?B?VkxMV2N3cDI5M3B4akZCU2x5SVhJUGFHZHh4RW1HUDBlM2hBVGV2RjJwZEM2?=
 =?utf-8?B?ZWE3aWoyeHNaUmkzYThYL0ZIbzdrdzA0cHpNTEJIbmcxZFpKdzcxNVpuTHI1?=
 =?utf-8?B?eTV0ZTQ1NHA1cDJkQTdpOGJ5L2dYNHhhSlkrYXc0UkRhb0xhREpuZGk4bXdX?=
 =?utf-8?B?cW9OaGJwMzh2K3RGaEkrSEo0Y1FMbkw1dW9xTGVmek9tM3NQRHp5NzZVR2Fm?=
 =?utf-8?B?WFBwR0FhUVJJZFNzVlAxdEtqY1R4djVZQVlnWmlqdGZkK1hKMjlnTVdhVWRv?=
 =?utf-8?B?SzNlbWkvcU9NZ0lCTitRRDlSTUNWZmtXditTd0FBZ1EzdEVzWmphR1RQeG5X?=
 =?utf-8?B?dk0yb3hVS2pKemMzOERrZGJUQ29WNWF5VWVObGFodk1VRHJRTExyMVh3WVRN?=
 =?utf-8?B?ZzFjZmMySHRjTDVwbzdZQ2IzTlNlR09Vd3MwUWFDemZhWUpaN3U5aGgrU0VP?=
 =?utf-8?B?ajc4d1oyRTk5RkF3MUYrQVZZcFROa2JaYUZFY2UwVTRYYUxhWHV3azdoZW9R?=
 =?utf-8?B?NEtqTytQK1BMQ1p4ZDdCWlFZYm1Gb05KWWs5dktYeEpramlacWtIREl1Y2pO?=
 =?utf-8?B?THhKWW0wVXhvQVdiMU5QRSt1cG9SWm4xV3E2YnhMeGIwbjZBV2RiOStCREl0?=
 =?utf-8?B?OXU4ZUZrblh6VjVQT1VGaHE3VFdiV1pOTDFycTI0SXhwcE9jejgrcDhJUWsv?=
 =?utf-8?B?cFJabWtONnkrRUdpd3gxWHlUeVRabjZGOHBBaitRdStPTjh4VmNnQTZERDV5?=
 =?utf-8?B?NWJZaU50bUZIcVViQS82cU10M0syYjJNZWpzY0RRZ05JdS9YMU45YSthNGZ3?=
 =?utf-8?B?NHRYRVVWaDYzdEw0NkF1UVFpZVdaSUhWTXRWMzlILzNabTFabVVrUmk4amx1?=
 =?utf-8?B?MU1NQ3NMVUNuNjBKQkxPaDBoclF5UUxaT3Y3bXZNZE1mS1dkN2lnbHcxTUps?=
 =?utf-8?B?K0tRTlZaTU9xT1ZsdXZSNXBRUUFDQmltaGtOSzAwT1RObjQwdHFTVmM5TzlU?=
 =?utf-8?B?Q2w0dnA0RlpyY2pWeTlHOW5McHptYVppNnlFOHhUdk1yNEdIeGl3RWErb0Jq?=
 =?utf-8?B?bHpVUWROMU44U1M4LzgvNjVIUjUrQXMxYktVeFBzMDhvM1pYanVFRDRRSSt4?=
 =?utf-8?B?TjF0U0lZQ21qNUN6em9HSUowOVZ0TmJYbG83YkNHVHhzeXpGWkxvUU1EM2Jw?=
 =?utf-8?B?RWJWelJia2VLN21qYXk5TDBFd3hIU0IxNlZ2V1JQOHZHM2Ryelhzb2JSdVZJ?=
 =?utf-8?B?QldMaWZMNnhXKzd3NStxMGIvUTIwV2UyUEJKZ1BJM0JsM1dUZnN5TzNtUEFp?=
 =?utf-8?B?b3Q0c2E1dTVlU2FZdzc0bmlBVmdEQnRTS0JQRXZLRi9EeFJDeFlFdGFWS3V3?=
 =?utf-8?B?eTdVaEZGT0tROWVmbjF6bkJGK2xqSmVuemRsZVUxZ2ZNanF1MXhJWGdXK2Q2?=
 =?utf-8?B?WDdkU1RtbzNwM1FXZ0Z1c0w4NTQxTS9wdzhubERCZmFCNGx3ZFZFNkNoVDh2?=
 =?utf-8?B?c21MbWxqZEdxcHEyU0NPdVlXY21ZOU03SmZYVTBPdjYrMDhpNG9YMmRpb3Y5?=
 =?utf-8?B?RFVseVF1NVdNeGdpZWVmQzlNS3cwRDIxck1rOWJhdzV2bFJIS2psZUl4S0cx?=
 =?utf-8?Q?HIXE3E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXV2WnVYTGcyZzlQZ0p4N1AzMmV3bXV1NTI3bEQ0SUU1eEdqc3FkcDJ3WldE?=
 =?utf-8?B?bmdZcU9hdFpnUStyTmVIa0wvMi8yWGZGTkxrdXpVMTExazhBbElVbU9BRXJj?=
 =?utf-8?B?MEVJUE1WSEF5YXdtbnJ6OURxZlB1eVdPeThzUjBseVAvSzhDb3J3a0hmQ1BO?=
 =?utf-8?B?aVBZTmFyTTVOUzZha21hNTNCc2JxZnFGaTNEMDNMTkljbFRySUJBVk5SVU01?=
 =?utf-8?B?MUZPaTJtQU9lL3krRlh1VDhPQTRVS3ViUUwwNEJwWnVhM3cvbEtBdG42WEJx?=
 =?utf-8?B?N0lRbXNuWGZSSjJ4MHVPOGVKSUdlaFpjeEdIQ1lEK3NLM2pGOEdtZGIzdVlW?=
 =?utf-8?B?MzBOOWRsQ01ZUUJNWC8zeEg1TjdXOXJHbkkvSHhZb0RFSndMKzlWUnlOMzJq?=
 =?utf-8?B?ajFJYUd5QXA5YkxIdTUrZTIrK3JvalZ6dUs5ZUZlN21JbTF6VVpycy9OVkI3?=
 =?utf-8?B?eG4yd1B2aGhlOFFMOFA0a1cvTGNDenBHM2dsa0toaWRvS0MxeitCUE9Sbmov?=
 =?utf-8?B?RnJIbnNQaGpJZFY5Ylh4NlU5ZEtjWDR3ZXFMQndTOVg1RGUvUDE2QUhUQUV1?=
 =?utf-8?B?SW1yanZPNVNUb1Y1UEorbHp2Z3N0UjNaa25iT1ZaYkxCZW9PeHhWQ05NeURx?=
 =?utf-8?B?U2tTZ1ZpWWRCVnIxekFXd01QbTRmUVlHeEVxbWdtVUFaem52TWJvU0Vvdlp2?=
 =?utf-8?B?Smk0VWU2VmVFbU0xN0lnSDQxRlU2Rks0K1ZYK3dJa3kvQVlOQzJma2hQVmk3?=
 =?utf-8?B?OERlMjRsQk9PV2FKYlluamNqeFFaZXBzTDNkNlo5Yy9YNEVQV3VTem5PdXpr?=
 =?utf-8?B?ZFNZUTZ2UjNYQXRpZUZGOGd6K1NLKzE2Z1lNc25LSDM4T2dCcWo0Sk5yNm9H?=
 =?utf-8?B?a1RkYXk5cm5GZmR4SmU4SzU2WDFLOUp5bFhTcVpudlNuRGZnejRyd0VQUmRI?=
 =?utf-8?B?cWdrNDQxdmd3UVJxajNkRkNwbTA4eEVhQm9HTjgxRHNVSzBiaUhOUWVicjY1?=
 =?utf-8?B?cGR0aERKMmdQSkNWY0RGUFJwSlpJV2hiTGVxTW9hRm91dkgrWjRpcjdldWh5?=
 =?utf-8?B?eUFXSnNsUW1kY05VVnBFVFRFVWZlUmVpWFVLS3hSd2tsWWw1T3dGVVp4bndC?=
 =?utf-8?B?ZU0razdRd0R5WFJTYjZOekYwYVd4cWdqNGhrTTdDeXRUTmNWSkZ3blhBY08z?=
 =?utf-8?B?Rnd2TUJYN3NydHV2dmtkV3l0SFIxbVA2QWlZQ0FxNEphSGszSTk1TFhKS0pj?=
 =?utf-8?B?eklYR1cxdWxLcURndmJlRDdJQTdOWlFkQnRPcXJPMzFLVzBWaUZIbXpyUGhC?=
 =?utf-8?B?RGNqc1JwTmpvVU9YS0Z1NnppaVRGKzlhWTlGRnNEc3pwK0dRTFR1RjF1dFB3?=
 =?utf-8?B?dkdxSzZXZDl2TU9GRUt5RHVMU2hZdzk2bkRxNjNveTZma2xnZHJtamd6OVQ5?=
 =?utf-8?B?MU56anlWbGU5UkNpc05CV0RrY0N3N050Nm4wT1RtYUJjUW5Ya2ZkakI5MnJW?=
 =?utf-8?B?dXREcjk1bVJuTlhGa3IxOUVGZG1LN25xMi85emx2b0U0TWRSSjBaVlJZaGE0?=
 =?utf-8?B?Yi9yZFlYemtCcDRwbjNsV005dDc0b25IZURGN1o2UjduWkFya2JqUmlWU1U5?=
 =?utf-8?B?cXVPU3B6WnRQUjhiZXdmT003cFdKYjNlRDBDTTdoaTQ3OXBGSmp0L3RxUlpp?=
 =?utf-8?B?YWVvK2dKU1EyY3UvK011RGFmeFNVS3hwcnBVaCtUcGcrQnhhWG9hVzIvZ0p1?=
 =?utf-8?B?RHloL2llckY3eU9jNUxIclp4cDdTblhKYURrV0pFak1PTE9WZTd5TFlhdU1z?=
 =?utf-8?B?dUNPdEFKL0RyUWJZR09td2JQVks0VXc4MjNmU1BhbVZrd01MSXlFQ2Y3RHBh?=
 =?utf-8?B?OXVKYnppT09rWm05bEpHN2JGa3d0WW5OTHE0dTN1SXdQYXc2S0p4MG1hWmNT?=
 =?utf-8?B?Q3Fyd21wSnNJU2JBNkVnWUtRVlVNeVUvWnFiVnE1RlluUVhpSnhEVjJibWFp?=
 =?utf-8?B?QTUxdEUrSFJDNjZldUF3TUl3N3VjMm9GZzc3bFRuQ05LOExzVURscFl6cFIx?=
 =?utf-8?B?TWpXYlIvK3J0SU9tTHVIc3M3dHVBakF1OU81TXlUaS9UVUR6OVVwcXh4eVNu?=
 =?utf-8?B?Rm5YOE9nQmxxUjJDZkpGbWlQMDhoQkJRRkdkSVgxT2ovSnAzSktTOGdzSDVX?=
 =?utf-8?Q?TKNdL8/hW5rxJs0y901RyLZL4Y/3B0Uw4cDn8q/ggrIZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8389f2-2e63-4fe3-a193-08de1ba64ba7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:30:18.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAoOmVFjOv++qmEqFn+Ik2p3I0Hsd55NkldtKkIMXtsrZw+UijcaylWMpnW1U+RsAjitgRRStKLTfDUKfiLKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036

The core library's `From` implementations do not cover conversions
that are not portable or future-proof. For instance, even though it is
safe today, `From<usize>` is not implemented for `u64` because of the
possibility to support larger-than-64bit architectures in the future.

However, the kernel supports a narrower set of architectures, with a
considerable amount of code that is architecture-specific. This makes it
helpful and desirable to provide more infallible conversions, lest we
need to rely on the `as` keyword and carry the risk of silently losing
data.

Thus, introduce a new module `num::casts` that provides safe const
functions performing more conversions allowed by the build target, as
well as `FromSafeCast` and `IntoSafeCast` traits that are just
extensions of `From` and `Into` to conversions that are known to be
lossless.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/DDK4KADWJHMG.1FUPL3SDR26XF@kernel.org/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
This got already reviewed in the context of Nova [1][2][3] and I am
thinking of merging it soon there, but since it was suggested that this
would also be useful in the kernel crate, I am sending this RFC for more
visibility.

It might be a bit tight to get this in shape for 6.19 (thus the first
merge into Nova as we have a lot of incoming code that benefits from
this), but maybe we can consider the following cycle.

[1] https://lore.kernel.org/rust-for-linux/20251026-nova-as-v1-5-60c78726462d@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/20251027-nova-as-v2-5-a26bd1d067a4@nvidia.com/
[3] https://lore.kernel.org/rust-for-linux/20251029-nova-as-v3-4-6a30c7333ad9@nvidia.com/
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/num.rs       |   6 ++
 rust/kernel/num/casts.rs | 245 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..235d0d8b1eff 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -109,6 +109,7 @@
 pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod num;
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
new file mode 100644
index 000000000000..3de1decb7779
--- /dev/null
+++ b/rust/kernel/num.rs
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Numerical features for the kernel.
+
+pub mod casts;
+pub use casts::*;
diff --git a/rust/kernel/num/casts.rs b/rust/kernel/num/casts.rs
new file mode 100644
index 000000000000..c729778f64d4
--- /dev/null
+++ b/rust/kernel/num/casts.rs
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Helpers for performing lossless integer casts.
+//!
+//! The `as` keyword can be used to perform casts between integer types, but it unfortunately makes
+//! no distinction between casts that are lossless, and casts from a larger type into a smaller one
+//! that might silently strip data away. Thus, its use in the kernel is discouraged in favor of
+//! [`From`] implementations.
+//!
+//! Concurrently, there are casts that are lossless depending on the build architecture (such as
+//! casting [`usize`] to [`u64`] on 32 or 64 bit archs), but not supported by [`From`]
+//! implementations in the standard library because they are not portable. It does however make
+//! sense for the kernel to support these, if only for code that is architecture-specific.
+//!
+//! This module provides ways to perform such conversions safely:
+//!
+//! - A series a const functions (e.g. [`usize_as_u64`] supporting safe conversions in const
+//!   context. Conversions supported by [`From`] implementations in the standard library are also
+//!   covered as the [`From`] trait cannot be used in const context.
+//! - Two extension traits, [`FromSafeCast`] and [`IntoSafeCast`], providing conversion methods
+//!   similar to [`From`] and [`Into`] for conversions that are safe to perform on the current
+//!   architecture, but not supported by the standard library.
+//! - Another series of const functions (e.g. [`u64_into_u8`]) supporting the conversion of a const
+//!   value from a larger type into a smaller one. This is useful if a constant is available in a
+//!   larger type, but needs to be used as a smaller one that can accommodate its value.
+//!
+//! # Examples
+//!
+//! ```
+//! use kernel::num::{self, FromSafeCast, IntoSafeCast};
+//!
+//! // Conversion from const context.
+//! const USIZED_CONST: usize = num::u8_as_usize(255u8);
+//!
+//! // Non-const conversions.``
+//! let a = u64::from_safe_cast(4096usize);
+//! let b: u64 = 4096usize.into_safe_cast();
+//! ```
+
+use kernel::macros::paste;
+use kernel::prelude::*;
+
+mod as_casts {}
+
+/// Implements safe `as` conversion functions from a given type into a series of target types.
+///
+/// These functions can be used in place of `as`, with the guarantee that they will be lossless.
+macro_rules! impl_safe_as {
+    ($from:ty as { $($into:ty),* }) => {
+        $(
+        paste! {
+            #[doc = ::core::concat!(
+                "Losslessly converts a [`",
+                ::core::stringify!($from),
+                "`] into a [`",
+                ::core::stringify!($into),
+                "`].")]
+            ///
+            /// This conversion is allowed as it is always lossless. Prefer this over the `as`
+            /// keyword to ensure no lossy casts are performed.
+            ///
+            /// This is for use from a `const` context. For non `const` use, prefer the
+            /// [`FromSafeCast`] and [`IntoSafeCast`] traits.
+            ///
+            /// # Examples
+            ///
+            /// ```
+            /// use kernel::num;
+            ///
+            #[doc = ::core::concat!(
+                "assert_eq!(num::",
+                ::core::stringify!($from),
+                "_as_",
+                ::core::stringify!($into),
+                "(1",
+                ::core::stringify!($from),
+                "), 1",
+                ::core::stringify!($into),
+                ");")]
+            /// ```
+            #[allow(unused)]
+            #[inline(always)]
+            pub const fn [<$from _as_ $into>](value: $from) -> $into {
+                kernel::static_assert!(size_of::<$into>() >= size_of::<$from>());
+
+                value as $into
+            }
+        }
+        )*
+    };
+}
+
+impl_safe_as!(u8 as { u16, u32, u64, usize });
+impl_safe_as!(u16 as { u32, u64, usize });
+impl_safe_as!(u32 as { u64, usize } );
+// `u64` and `usize` have the same size on 64-bit platforms.
+#[cfg(CONFIG_64BIT)]
+impl_safe_as!(u64 as { usize } );
+
+// A `usize` fits into a `u64` on 32 and 64-bit platforms.
+#[cfg(any(CONFIG_32BIT, CONFIG_64BIT))]
+impl_safe_as!(usize as { u64 });
+
+// A `usize` fits into a `u32` on 32-bit platforms.
+#[cfg(CONFIG_32BIT)]
+impl_safe_as!(usize as { u32 });
+
+/// Extension trait providing guaranteed lossless cast to `Self` from `T`.
+///
+/// The standard library's `From` implementations do not cover conversions that are not portable or
+/// future-proof. For instance, even though it is safe today, `From<usize>` is not implemented for
+/// [`u64`] because of the possibility to support larger-than-64bit architectures in the future.
+///
+/// The workaround is to either deal with the error handling of [`TryFrom`] for an operation that
+/// technically cannot fail, or to use the `as` keyword, which can silently strip data if the
+/// destination type is smaller than the source.
+///
+/// Both options are hardly acceptable for the kernel. It is also a much more architecture
+/// dependent environment, supporting only 32 and 64 bit architectures, with some modules
+/// explicitly depending on a specific bus width that could greatly benefit from infallible
+/// conversion operations.
+///
+/// Thus this extension trait that provides, for the architecture the kernel is built for, safe
+/// conversion between types for which such cast is lossless.
+///
+/// In other words, this trait is implemented if, for the current build target and with `t: T`, the
+/// `t as Self` operation is completely lossless.
+///
+/// Prefer this over the `as` keyword to ensure no lossy casts are performed.
+///
+/// If you need to perform a conversion in `const` context, use [`u64_as_usize`], [`u32_as_usize`],
+/// [`usize_as_u64`], etc.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::FromSafeCast;
+///
+/// assert_eq!(usize::from_safe_cast(0xf00u32), 0xf00usize);
+/// ```
+pub trait FromSafeCast<T> {
+    /// Create a `Self` from `value`. This operation is guaranteed to be lossless.
+    fn from_safe_cast(value: T) -> Self;
+}
+
+impl FromSafeCast<usize> for u64 {
+    fn from_safe_cast(value: usize) -> Self {
+        usize_as_u64(value)
+    }
+}
+
+#[cfg(CONFIG_32BIT)]
+impl FromSafeCast<usize> for u32 {
+    fn from_safe_cast(value: usize) -> Self {
+        usize_as_u32(value)
+    }
+}
+
+impl FromSafeCast<u32> for usize {
+    fn from_safe_cast(value: u32) -> Self {
+        u32_as_usize(value)
+    }
+}
+
+#[cfg(CONFIG_64BIT)]
+impl FromSafeCast<u64> for usize {
+    fn from_safe_cast(value: u64) -> Self {
+        u64_as_usize(value)
+    }
+}
+
+/// Counterpart to the [`FromSafeCast`] trait, i.e. this trait is to [`FromSafeCast`] what [`Into`]
+/// is to [`From`].
+///
+/// See the documentation of [`FromSafeCast`] for the motivation.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::IntoSafeCast;
+///
+/// assert_eq!(0xf00usize, 0xf00u32.into_safe_cast());
+/// ```
+pub trait IntoSafeCast<T> {
+    /// Convert `self` into a `T`. This operation is guaranteed to be lossless.
+    fn into_safe_cast(self) -> T;
+}
+
+/// Reverse operation for types implementing [`FromSafeCast`].
+impl<S, T> IntoSafeCast<T> for S
+where
+    T: FromSafeCast<S>,
+{
+    fn into_safe_cast(self) -> T {
+        T::from_safe_cast(self)
+    }
+}
+
+/// Implements lossless conversion of a constant from a larger type into a smaller one.
+macro_rules! impl_const_into {
+    ($from:ty => { $($into:ty),* }) => {
+        $(
+        paste! {
+            #[doc = ::core::concat!(
+                "Performs a build-time safe conversion of a [`",
+                ::core::stringify!($from),
+                "`] constant value into a [`",
+                ::core::stringify!($into),
+                "`].")]
+            ///
+            /// This checks at compile-time that the conversion is lossless, and triggers a build
+            /// error if it isn't.
+            ///
+            /// # Examples
+            ///
+            /// ```
+            /// use kernel::num;
+            ///
+            /// // Succeeds because the value of the source fits into the destination's type.
+            #[doc = ::core::concat!(
+                "assert_eq!(num::",
+                ::core::stringify!($from),
+                "_into_",
+                ::core::stringify!($into),
+                "::<1",
+                ::core::stringify!($from),
+                ">(), 1",
+                ::core::stringify!($into),
+                ");")]
+            /// ```
+            #[allow(unused)]
+            pub const fn [<$from _into_ $into>]<const N: $from>() -> $into {
+                build_assert!(N <= $into::MAX as $from);
+
+                N as $into
+            }
+        }
+        )*
+    };
+}
+
+impl_const_into!(usize => { u8, u16, u32 });
+impl_const_into!(u64 => { u8, u16, u32 });
+impl_const_into!(u32 => { u8, u16 });
+impl_const_into!(u16 => { u8 });

---
base-commit: 6553a8f168fb7941ae73d39eccac64f3a2b9b399
change-id: 20251104-as_casts-6a8882ac0192

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


