Return-Path: <linux-kernel+bounces-765043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1965B22A45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AEF87AB767
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124AC2E7BD9;
	Tue, 12 Aug 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phr9gxYo"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6328A3F8;
	Tue, 12 Aug 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008676; cv=fail; b=EzeDvC7Sb0m/o3OWY7ZFI3W5VIJN+EWaHd+QpNKUHq9mqNgelYl3uCqSAsB/D1jMnbOzRr6Fbtf/QxrweyQ7AxuE4uU93YpZ1PYusUGfor0NRQfoklBfSHY2e7Tfqe7NtmDGZeWRPkfCMOKawp+5R87nimH/RjRGSB5UQ5LRDYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008676; c=relaxed/simple;
	bh=X5fAAFyHxZ/acS5JdWv/sY7tTMonatxoA6A9jejNXeo=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=bV6YzoxAXULVAtnOGlypH/6kLyQPf64pFJo3GOdTMddjYwNk1ZuhVUUp9e3FycsbmSuUAQxvLEUcKFGKIqtLzTTBDtA+Qckp1Q2826IjWNdoRBVRifEdtkJvPYXvs/+mL+TSaG17csirBDS7B6MZ8qodnPk2YHYhyC1KyBS67lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phr9gxYo; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPNZ4I9N0v1/8Peb2mo37582WXwe6HZujr8lnGLNQtxa6AvPDKYPWBdlLpBcvJOBN+i76o130L1iSpdFw1gqmN0UjkBBB+6HD09XLJCzpqJfmYuLDA/QpurXSsYS/t3qZPgqozf1+Z1lJcoMS54FKQ4UuzBqSQGgCufcqJJvGgy2CADsYGCeD/A87uIiOuCHCNFWaiVzUo6AuhbLevqgO9JFX7qI8HgM9g8rC6MG+07iAgYcepVJTe/k7OYq3eWhfdo5vEn/CxftL3qAyeePT0km15BepXcKco+SauYCZuLDDKOREAC4fOO04LLUUf0ZObkuCBtNriITdzIJUcjbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ45ojKCoORyBU33B1fGaTJC+Jwiu2Vonly2EOiLr7Q=;
 b=Hwf/i2EwM1oEV0aoUlIaoDZOYDr8+W19DHkIR9M4bHVPtZTjR+bQJrdzgX5G7zNcIkQnlZzAOsojLO574JSPjAdMX2i3r85y1DtRqzcj1o0qLl317cAvlu8HoSDf+woGmwC2o0QlSMQHcA8LVgAk+muOBfwlT1YJgPvdESvJU6zfnY1U76RWKC6Hjly8Y+J5wXub3eDvV2Y9yyYaIn/4sJnsv78AKhXWu4pylCd7P8FXy/JXC+bKa9X4wDLEmVbV58xrAhezK1D3wLB7onHhB4isfCtSJZhznm7/Bsb6nPonKLDfec2rtjt1lZst+P4RaqdnzaIaRK7MZ0mlcAKycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ45ojKCoORyBU33B1fGaTJC+Jwiu2Vonly2EOiLr7Q=;
 b=phr9gxYosDEjkQ2v8hybBmcymVtp7cJWxKVySY+5D7voz7ZPXxnozA/pQweUOhGuIXuQGd4yXX/SwmMjKsiEazoIE6Oj9xOZGW6hnPgm47uQ3IZL7rUs9fsumsQ7LMoctnTUzqYTo3JOj0RolwBlLIsXvwq71Qk4VNiF0EgFYVgBqHT6/VHm3WQPc2aj9wRtmdFFToUIEVWWGRRsl6Fv0Q7E1lg6dsZJk/YZmpF4XpoAg1Ux79gCOZOTg2hEJ0Mx5F8am6eDh6nxSBT76ahD//XkYEybliOBvs4d4biQouceQzTzouQQQyoPKKptX7SjQ+35j6TynbjBG1CqfnmQ0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 14:24:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 14:24:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 23:24:25 +0900
Message-Id: <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Christian S. Lima" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
In-Reply-To: <20250811213851.65644-1-christiansantoslima21@gmail.com>
X-ClientProxiedBy: TYAPR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:404:14::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fea700-abe2-4b51-fc1d-08ddd9abf253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|13003099007|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmswZEx0Y09wbXFwOFF0RnFuVlNWRTYvK0ZDVkZHdnJiaDVyK0VBL2FaeTMr?=
 =?utf-8?B?V0ROUGlOYkZtQmhZK0k2bTVDTUlvTzhxRHNtOU1RVmY1eXRNUm1Qb2xBWnZG?=
 =?utf-8?B?YStaaExaQkFyMURmU3BaN1JTUUMwWGxXbHNJeENuaHFtS25EUHhMVHpHcmc4?=
 =?utf-8?B?cVBiT3dVU1RrKzVKakdLRTNlVHN5ZnRqZUtIWnZJOHd2Z1lTMHp6ZDFoeDY5?=
 =?utf-8?B?NWd3alJjVjdmdTcyQzJCeW1FbVVhOEdsM21RRFhmK3lLY0tRU2lmcEhPVVBB?=
 =?utf-8?B?bk1EQkRFcERTVGhuS0o1ZS82SHdORFp5NHo0cEpZY1JGakh1ZlR5ZWJ5OEdh?=
 =?utf-8?B?MldLdjN1Q1l2M0ZPZks5T2gvOUFWR1dSeGl4NlN3Q3c2ZHNtWEwzVHpYaExE?=
 =?utf-8?B?ZkFKYXV1MDZNM2hkdEYvK1Y2REJPTG5xVHgvNElJWU5UaUR5cm9uNVFpdnRh?=
 =?utf-8?B?MmtsNEVIeHpZZVRMbnV0ZjczcHVtOHpReE9GaW5nWVRxcVRocmZRaEc1UE41?=
 =?utf-8?B?dEpPdnRZcjZFaVlFdzRmemRHT3RaTGZnbUw0TngvR3dicVptbGF5WjFRdnpT?=
 =?utf-8?B?eW1idFI1VnM4TGRSYTZGeXAxd1VGb0FrNzNYMHk2ZXQvV2tKRlNwQ1BtSThB?=
 =?utf-8?B?cnVWcW1yL3pRdmx4WDJEWE1vVXdDa1ErZEU1TitYbmMxLzlIZW00M2dWZ1Fl?=
 =?utf-8?B?eWNOcURnc0E3K1d5US92Q2pxV2ltamwrcmVSMGhzWVRCNzJYWldQVTRRVWsy?=
 =?utf-8?B?amlYZmdnc2dCNUFyNStzbTRGcHlKU2JuNFQ3SW5KckJ2MW9yK01HK3QyVGtz?=
 =?utf-8?B?OVNOdks0bU51TjFCY2F6aEQ1bDJKUVRxVXBTMkx4bzIvTG9vazRzWnNHdnZN?=
 =?utf-8?B?SitoZkZpZENuZnJaRURLSWVuNjBFTGlYRSswSTkxKzlTNWxyQ0VadXZTVnNt?=
 =?utf-8?B?L1FhT1E2cW1vSk9nbFBmMmRYYmVTYm1EbVVOTERWbGVGM0JHMFBqUHNkRVU0?=
 =?utf-8?B?QmFkK2ZwSksvaUpGbnpGbHVZU29FYXNLT1NldjB6eWlvSnBmRi9TU0JKOGJh?=
 =?utf-8?B?a09FeHRuQ1A2a3NJNjN1TWFPRDNSN29kNW5pQ0RCNTA0d2UzSGoySWVLY3BK?=
 =?utf-8?B?YzMwR2dRZG05MjBxRlAyTjMwL2N4N0FoMmlqblpuUzVvdVc0SUF0alhNVWIz?=
 =?utf-8?B?dzVKdnFDZE1iVVRiV3h3OWNPYmpQd0F1VTBHRGRiNzMwQVpRcnVBdkhJa1Zy?=
 =?utf-8?B?RTQ1b2RrYk5SOTJQSTRwZFBTcEMvSmlhWlVYOHZ5akFaK0lZNS9QeGkzK0Zh?=
 =?utf-8?B?OEJpYnFYSjFGOHVjUk5ZN2FnMDlKdjZsTlJYd2xaSnprQktkamt1S0o3bzZ2?=
 =?utf-8?B?SjFzd28vQ1diN2tCYWN6ZGRXcHQvaG1CRG10amdxKzg5SWJIMzJndlZaVlRG?=
 =?utf-8?B?VkRZc3l5bEFCUFhQRkE4bmdZQnQ4SXZQa3NQWXM0cGxrUjZwVTRNdnJTdGg2?=
 =?utf-8?B?SVhJSzA1d2ZKU3ZPVHBLdWxSa1FRQVl5Qm9qc2pIbmErNzZoSXVLOEJXc243?=
 =?utf-8?B?Sm5KRHhyeVJVbnpOMlpiYjd1bTFsOUpUV0F3WjBSWmNkZm5rY1k4THdrQ0hT?=
 =?utf-8?B?WkdxVzRLY3FBaXZ5THczcTVPZmRxM0dTdzdlRi9ha1A3NitUL3hqV2ViV2U0?=
 =?utf-8?B?ZU03cGg2ZUtiZ0Y3eEpyMXdoZlVQcUtQQUtlbFNTbHlBNmdLdGQ2c1JtUGZI?=
 =?utf-8?B?elVCRnpVK3ZSSm9GNTcwQmtlNFpTWlBxK2pLczFnaTZxeEg2a3ZTejMyVk9W?=
 =?utf-8?B?M2pNOS9TeDlFZ085Um1VdWZ4S1J2ZUpELzFXWEJiZ1ZGZWZrWGd0dStocDZl?=
 =?utf-8?B?eDRBMEp1UWMxWVdCeTZJZW5VeDUzTUxXVHJ3ano0Q0t4dWZ2OXB0Q0hyeG1w?=
 =?utf-8?B?b0UrV2VjTDluNmtkYUFSS2FtL1NZWVNyZmR6eEdaN0FSVzlvWk5tUlY0SjEy?=
 =?utf-8?Q?nqRTDImQMvWLqPmpUqjYoUTs6x7zjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(13003099007)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEJsUExUeEFMdDJqM3hqLy92VW40RGJyaHhpQjV1bEdEbTR2L2tzOXF2Zzdk?=
 =?utf-8?B?Zis1RWRKVWRTNWRyMjZsQ0RZL1JoQ053NnlqZVh3ekVDcTVGNm5CWFlrT3Vu?=
 =?utf-8?B?T0Q5Kys4b2FUa2drd0xSSHIyTWlKM2xKdm95aG1JNGJPMCszUkZJeEx6OW9n?=
 =?utf-8?B?Z25kbDZwbDBqbUdZRlYvRlpmU2ZITEdDcXJiRjZPL1FJVjRJc3FwUUlYWGZx?=
 =?utf-8?B?bkY3TVNZY29NZWxtelpocDI1eHNIMnJ2eWYvd05oTE4rdU15TWJjTjZESCtq?=
 =?utf-8?B?K1VnWmpTVjBXUnBuZExoNkpYRzBTNjZpU1FLQzdERTdMYThoNEZMV29MV01O?=
 =?utf-8?B?dTFtN29qek9OeFVwUit3dlFVY0F5UXcyRFpRQVE5MVlpRXFhUjc3dWpYMlVs?=
 =?utf-8?B?dEtUbHBZTlhxTWp0V0JKNks4NzFkNEF5cVAra3NvZWtYS29YMWxlc1k1dHFm?=
 =?utf-8?B?NGYrTktmUmJTblhOK20wLzZXcFI3Ry9uc2tUWmhjM0tFS3FOT1k1MU93eUEr?=
 =?utf-8?B?R2Zsa3JBaU9WNkllVEJOd3ZISFNXSUZsWTdHekhoVHFWWWZDZENpaUdtNEUw?=
 =?utf-8?B?eWorSUppRzZtblVyVU1YV2NYV09oblRDWUNwL1JxSU1WZGxKdnMrWE84aEJv?=
 =?utf-8?B?dk9qdE9RVldOeHdpR1k5QXR5L1hoaEpjQ3ljSjk3R3NnVHNtdVpWYTIrb014?=
 =?utf-8?B?QjU3emFqQXVxWG4yb1FGdFc4T2tqOFpOUGVRSWJoZklxcFpnR3UvVGFmTGpX?=
 =?utf-8?B?aGtOSEhteFd5QXVKQ1NQL0R5QjBiSVJLSmhBc1VBaHk1bVdHQ3RVRjdNa0Zi?=
 =?utf-8?B?allwdmY1dkVva1ZZVDdHMlVqZDVlK2lvR1N1MldRdEFwb3pHUHpvaFZjdVlD?=
 =?utf-8?B?cFhhVzFCYzdTSEVvejRNQW1Cek1QcTJkOG1obTZLL1VKWjZTK0hxQXBOQkFx?=
 =?utf-8?B?dlhROVRvNTM0Z2lMaC9mb1hrWlV5cGNzZHNITi9ZZ2wyZ1A0SkRCakdKNlo1?=
 =?utf-8?B?akdQMklWb3BZZW9PQ0FXL1MvV3cvQ2ppd2xleUU2NCt2TTNEZ05MRWgxUksy?=
 =?utf-8?B?cjNGQkthczlRc0JiV2dRczcvbWxVWjBZK3NQME0rUGVQdUNmOGdLSmJrd0VP?=
 =?utf-8?B?Y094dzRvNHZGZHdnSGgxWXUzQURTdnRQdW1ZSVk5Vzd3WDVjV2loRGhCNmV5?=
 =?utf-8?B?Zm5ZNnk3cGZPdXA0OGQwYVdXSFhiT1BzazUyTmF4U0xpcjN4OWFsZjIxU2Fm?=
 =?utf-8?B?QXdqVThUelo5SGtwb1pMRFp3Tk0reEVGVkt6V2orL1lDN1laWWp5ZEozTXBa?=
 =?utf-8?B?TDF5Vy9wL3BtcStOU1VINFBKQlVFcHhnYlpPdHZVNGRmTEJFODA4eERHeTcy?=
 =?utf-8?B?U2ZMSWJIcno4ZmlwK21ac2RreHNTdTZMQml6N1lpN0trNlBoNittaVVYdGt0?=
 =?utf-8?B?TFRNVG5UNVVhc0gyNU41TWpUcldrRDU0cS9VUDhGaEljdzRoSlZyRkZmTXNZ?=
 =?utf-8?B?bmxVeWZZeis2bHRnL0V4WUlhQndta2VMRjhqSUl4cWRteTNqQjdKNEY3eDdT?=
 =?utf-8?B?b1BmOHlFU25pakZuV2FocUZaZ2lWTTcrcXl1dzA4SVdDcU1DMVBlTW1pQmY0?=
 =?utf-8?B?Z0tKWDgyOS9YMjJEYVE1dks1UCtDbVlYa1VTWVFsaURnY0M3RDlzVWdQNjdh?=
 =?utf-8?B?anlRWDZXVE9ER0ZQY05RaUFtQXo3b3MwczdEM0Ixa0xiWHY5di8xYndoZ2tr?=
 =?utf-8?B?QllKbzJCclJNTTBROEpydWdPV0txVzU2Z0xaOStJOUE5QWRMMWVlMktDQlY3?=
 =?utf-8?B?anNXQmN0WlZ6YmZjNDFuR3RGLzFwSzVCVkRQbCs0NWY1anlPK3JCR3BLek1R?=
 =?utf-8?B?dEsvVGVnNURrMHVXRWYveFpBV2RjQUdFRVVwb1VkSzh2Qy9veElQL2VPQ1dU?=
 =?utf-8?B?YTdTVExyVEg5RThaQmJoeHJ0ZlJsK25RU0ZQQi82Qm9xTklSenhneVlRb3Vk?=
 =?utf-8?B?cVZYTmhRZTdNbFdFMXRVMHF4SHZKbnJEaGpzY3B3bTdmbmd2NEhONnp4T3hL?=
 =?utf-8?B?TVFlQlhTVnhKSittTm9rMUJjRHlKSDlnSmpQMEJ1bVFlZE44bVViay9iVGFW?=
 =?utf-8?B?K1NHOWQvWG4zZ1lCNVZXS0VUa2hlMVI0RG1PYWZZcTV5YzB4aC90T0RjK1dh?=
 =?utf-8?Q?0Q2lZp78q/Kek/4XnNuims725Sbb7Jq0GGlMa02i04fE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fea700-abe2-4b51-fc1d-08ddd9abf253
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:24:28.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXJp7MisMJ1BX9F5yEOs5mhSukRp0cEkLfrIs2VMubL9+drx7FGFiyEm/O4px0gF+5zsAfpAKh8tNP0c56YCQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906

On Tue Aug 12, 2025 at 6:38 AM JST, Christian S. Lima wrote:
> The two methods added take a slice of bytes and return those bytes in a
> specific type. These methods are useful when we need to transform the
> stream of bytes into specific type.
>
> The `Frombytessized` trait was added to make it easier to implement other

typo: FromBytesSized.

> user defined types within the codebase. With the current implementation,
> there's no way to interact without implementing `from_bytes` and
> `from_mut_bytes` for every new type, and this would end up generating a l=
ot
> of duplicate code. By using FromBytesSized as a proxy trait, we can avoid
> this without generating a direct dependency. If necessary, the user can
> simply implement `FromBytes` if needed. For more context, please check th=
e
> [1] and [2].
>
> [1] https://lore.kernel.org/rust-for-linux/DANSZ6Q476EC.3GY00K717QVUL@nvi=
dia.com/
> [2] https://lore.kernel.org/rust-for-linux/DAOESYD6F287.3U3M64X0S1WN5@nvi=
dia.com/
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Christian S. Lima <christiansantoslima21@gmail.com>

I mentioned it on v8 [1] and v7 [2], but the tests that break due to
this change need to be updated by this patch as well. This includes:

* The doctests in `rust/kernel/dma.rs`,
* The `samples/rust/rust_dma.rs` sample,
* The example for `FromBytes` introduced by this patch which uses `?` witho=
ut
defining a function.

Please make sure to compile with `CONFIG_RUST_KERNEL_DOCTESTS` and
`CONFIG_SAMPLE_RUST_DMA` to see the failures.

Also, now that we are on 6.17-rc1, the types in `nova-core` that implement
`FromBytes` will also fail to build unless they are switched to
`FromBytesSized`. Which I guess speaks in favor of taking this into the Nov=
a
tree if there are not other planned user for this cycle?

[1]
https://lore.kernel.org/rust-for-linux/DB5KEWX9EJ2Q.3CX5EGS66OVHH@nvidia.co=
m/
[2]
https://lore.kernel.org/rust-for-linux/DANSZ6Q476EC.3GY00K717QVUL@nvidia.co=
m/

In case this helps, here is the diff I needed to apply to get the tests
to build:

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 1801836f31455..3797c70c13040 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -597,7 +597,7 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for Coh=
erentAllocation<T> {}
 /// struct MyStruct { field: u32, }
 ///
 /// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// unsafe impl kernel::transmute::FromBytesSized for MyStruct{};
 /// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
 /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
 ///
@@ -641,7 +641,7 @@ macro_rules! dma_read {
 /// struct MyStruct { member: u32, }
 ///
 /// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// unsafe impl kernel::transmute::FromBytesSized for MyStruct{};
 /// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
 /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
 ///
diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index ba21fe49e4f07..e7bd698ec99cd 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -16,6 +16,7 @@
 /// ```
 /// use kernel::transmute::FromBytes;
 ///
+/// # fn test() -> Option<()> {
 /// let foo =3D [1, 2, 3, 4];
 ///
 /// let result =3D u32::from_bytes(&foo)?;
@@ -25,6 +26,7 @@
 ///
 /// #[cfg(target_endian =3D "big")]
 /// assert_eq!(*result, 0x1020304);
+/// # Some(()) }
 /// ```
 ///
 /// # Safety
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9fb3ae1dd8587..36ad877d4804d 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -65,7 +65,7 @@ fn new(h: u32, b: u32) -> Self {
 // SAFETY: All bit patterns are acceptable values for `MyStruct`.
 unsafe impl kernel::transmute::AsBytes for MyStruct {}
 // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-unsafe impl kernel::transmute::FromBytes for MyStruct {}
+unsafe impl kernel::transmute::FromBytesSized for MyStruct {}

 kernel::pci_device_table!(
     PCI_TABLE,

-- end of diff --

Otherwise the patch in itself looks good to me. It is used in nova-core (an=
d a
critical dependency for this cycle :)), so although I cannot give my
Reviewed-by until the tests are fixed, it is at least

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

