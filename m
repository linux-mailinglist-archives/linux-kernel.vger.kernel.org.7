Return-Path: <linux-kernel+bounces-782045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66DCB31A44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C8E16E3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F283043A6;
	Fri, 22 Aug 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gk9aNMdI"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C421303C91;
	Fri, 22 Aug 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870608; cv=fail; b=rZ9YgnBOVeEQuohww8eCYgp90imyyw33Enzdb9am8iFvgL36x8N5z2V0w0+Tt5Efxf4wJiqcWtMZpZWi7l4nUGodpUCfNJid8i+ja3sDvIyjc9v4rNx1y/ZatlPucJnhlzG2pRmH/OQKmIYymY4PXiLEAANM3NLU1cdLRNm1yb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870608; c=relaxed/simple;
	bh=5/FQRtGwUA6D0O7glFMiTbJrENbZy34hOL29vBNXNFg=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=VGUP5y0w7hQjQd7xHSnXsyBlAwMCjUcsFHCWQ93yGo47GLV6L6rPo5ALz7ySomFzOK2346fVeIFd4Xzg0iAMxDoCQy6lj3N962h/lbjFMIoMveQKub+/IzWOliVisvkC0ihDjWPgKmXWHwkPf3B0QCLNuMGT+7Ctbu9kgWMMA8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gk9aNMdI; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff392zxeYjK6BYIQRemFCSVJPWn6KhfA8c2i8rZLT7elujUsXQdqFI4hvc1vxWVE8KJXUINnMz+82yM82052+JPnqnhF19brHTR1jCqc3X4cIDbX6X7XVh0oN/mKGsitMQFdsfoLPLkRIrc1hwzuxi3asRI04hvQoq0KZ1urZDolv+wkJPpxs6e4CmcK5yYekFyzySTovDMs0A+Y4Csy2+doixyLVNigPhvIQ9JwjShvAJR0dHIsfGg6FM+T64Kuv09+zUgMspQ78hvrz1u0bfZOYFCfvlamJms3nr4/K2qCkEyDXtqavprxaEfeMJtfqa2UsJTlJ29FEtaaqfBdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdQCVxU2i7sH66CI2ACnh0DdaQTWeyVNGvE2TyOP378=;
 b=as0he2IaDhw/So2ZBctQ05MfJtdh4CyE+1qi0cCMFZW1xjuXj5LawuQg5JL6a2PHzdOQeXz+YNFsuhuWSath3DGg6hXmkbq3rPGZuYNPi+IYuxGcJy//cCQhggzjueVlCvBe2MVokyySzBhoit9pE7inRysvfiiKDQZS5i6QssWNJX+UxK6IADwI4gmmU/UZdkfFS5FK4+rtQ91mCNG7AGB75kBsrUCSkH3XDmenkyWK9svjpt1DLkcWuyUpWAB3cHBDFmuee4nLnynQkWdgJZ2u+KQ6dPC3u9jWRYZvzEb9FYxjc381z7qMSiP0JjbImcPPVKPsDLWT4hiSECABsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdQCVxU2i7sH66CI2ACnh0DdaQTWeyVNGvE2TyOP378=;
 b=gk9aNMdIWWbrZ/Iw4y3spZkS/9Vdv8pr/Mu6l9mmNWqTi42SWJdmau2QQ5DJ9Hrav0d35CFEE1jCMrr6yKxSkFRdHy4GqKE7aRXp8u5ZlBst/m1KAVUL1HutdFFwaw/sE/W5xKqd4KUBLlT7j9OCTc4Y/vH5ACtEN4rgwKWRE1t9+tvvAdnFkrQOhxSHL7jDq0ATvcecGA+mDgKR2W7JXA1wPwUZ1EoyO5M6Q6z3L89BEOR7H4idG/ZNxMs0evRUg+W7itePUV1Kq3ZBTdsy4mQPxtcmHsRPlXNr16v0FI5lEN4z1p574qrIAlA+oOq/do6wG3t8GUivU9nYZNuz0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.18; Fri, 22 Aug 2025 13:50:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 13:50:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 22:49:57 +0900
Message-Id: <DC906GRT9ESF.2ZV7RUZR0XZEK@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Christian" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com>
 <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
 <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com>
 <CABm2a9cyvsXd1OS+tvDoDDEfMgBOJeetBVQU0x3m5E1vV1CApw@mail.gmail.com>
 <DC828042PKDV.16NDVKIGBNTJH@nvidia.com>
 <CANiq72kDUK0nScg+nK-M2U=MmxTmhayyRUv7n4E3UMQHr8RLQg@mail.gmail.com>
 <DC8MK2TAQ5D7.GHE5F2OREOD7@nvidia.com>
 <CANiq72mWYBAQYj_kWc+6XxrPVzguOd1vUB9f5JXzYdNx9EoXyw@mail.gmail.com>
In-Reply-To: <CANiq72mWYBAQYj_kWc+6XxrPVzguOd1vUB9f5JXzYdNx9EoXyw@mail.gmail.com>
X-ClientProxiedBy: OSTP286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 91888381-1f33-4c05-e760-08dde182ca28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TllPelZJSWpuSUhEcWU5bFQwS1pqd1hXRXp1Qzh5WTl0NzQrUDg2VDVHWU02?=
 =?utf-8?B?L2p3ODRjVS9BamIzYzBiYzM3VjFxcGp5bDQ0TEVWMkI3MXZ1TElySDFBZ1Fh?=
 =?utf-8?B?L1FyZExrc0gzbmxYT1RVM1NhSnVvbTY5SFlqUUZxZ2NXYkNrWXM1N2I0L1JB?=
 =?utf-8?B?bDZDcmZtbHI5U2FIM3dVWHp2akRMc0JNaXlhblZ5bTJqT1hxNi9wSE9mcTVB?=
 =?utf-8?B?WDIyL2VzK2ZJWmdzQ29nbWNxbThvdmZ5QUhvdldRL0JQcXlsc0MrQ2twZ1Ux?=
 =?utf-8?B?N1NYYjVpdUdISjZiTEVtY1ZmN0huRXFiZ1pTZjUxODVGWWVFTjN2MDBkeHU1?=
 =?utf-8?B?dG53YmxOT0doMUFrUmdRWGEzOXBXOW9nUVVlZnRDaG5FdXgrT0lUWVg3ZEZW?=
 =?utf-8?B?b1dRTGU4Y2NqM1NlelFJaEw4VHpXNERJaitBTHBZaWFkOGZSVVpTVnVFTnUr?=
 =?utf-8?B?N0E1Z1RZZU9PemZmY1ByaE4zMkdaQnNoenFWL1hIM1JnanVpZjZpL3hSOFJT?=
 =?utf-8?B?aTlOUlU4M0xmR2JVZS9RRHdta0RZbU5hanV0NHRabURYMFZxZHg4U3dOWHJp?=
 =?utf-8?B?QmtwczF3T09abWVrUjdOankrZWpUNEZkZkFUZ0p6RjhFL24yV1ErcGk1R29P?=
 =?utf-8?B?bU02Y3ZoTzVvcjJycmloOU9CWVRiT3doTlhnRE5LWWpnZFNJYVdOZUpQWm5B?=
 =?utf-8?B?L3RkbnF1V2ZHbjlSeElTbktETTFvQjE0d292dlhMVjJWZUpONHM4eStaZ3Qv?=
 =?utf-8?B?V01uV3dtak9OU0xiMHZkVzgwbTBxdnlaMGtMdVplM3Ryd0RweHgwbndvSDZF?=
 =?utf-8?B?RzhtVmJidnJRaFJQNzF6cmVMRHNJY3Z6S0pLSkF1ZzBBMWJxWDFoc29CeVJq?=
 =?utf-8?B?U3RWUjNHdWRnRjRYazgyV0dJUzhZSEtIVHRhY3UzVzEveXhjMFdaVFNtbWtC?=
 =?utf-8?B?VER3cTF4UDV0TGphaEhhNFdzeUdiUW41ekxMRTk3V1pEWm5BUlFKSE1hOVdi?=
 =?utf-8?B?d0paWkZ0M1lMMUlFd21NbHlyMi8vWDQvbFpNQm5sSnF6MjVhNmU2QXJ5dWky?=
 =?utf-8?B?SEJxdjlHc21PeHdhVytZeEZndU5LZHFicEVlLytvSHMxcXhuSmNlMmY5cU9s?=
 =?utf-8?B?ejJOK2Jtdlk5Q2RlM3FoMDBlQmFTYTZ5ME12VDhCeXZsZWowTFRWajE0NWRq?=
 =?utf-8?B?RzR3S2UyOVBmUkw2d1V6bDkzb1FETG5ucHdiZTlkV08xVDFhMHVnZlZFbTNO?=
 =?utf-8?B?RVRsL3pQL0tMaGhkNHhHU0RlYnRCOWRkQjByZmwyY014a1YrOWtLMkxheEtj?=
 =?utf-8?B?bDlkMkpCWjlMZzNENzltUGJBVzBUU1ZQeDZ1L3ZXbWtOemppM0l3d3NKZWlI?=
 =?utf-8?B?UXU2MHBlTU11VVVabnlSamtuVlV1TzU5dWtVckc1YmUrNmVTN2tRYVVvTm14?=
 =?utf-8?B?N3Bxd2VkRkVIdHRJa0QycEQxYjhsb1M5eVA0Q2pLL0RKRGhuM0V4Q1JKS0R1?=
 =?utf-8?B?QzBxem1zSHhUMk52ZnRDem5lZXVEVFdJbnJSRGUzR1VkMjQ4SGsvTUkyU2RJ?=
 =?utf-8?B?RlVhR3NPVjYydjNjYTQ2empyRmtTejFtdS9tYnFIT29MbHRYaFV2RjM1a3RT?=
 =?utf-8?B?NGVKanJTT0h3MUdzdDJlcEJNekROVWI3c0JrZnQwR2xLKyt5dkpCZmUzUnNX?=
 =?utf-8?B?MGNkVWRlZzk1amtYc1ZrY0pKRzZVSDBhUUJubTUzWitlMVRjOXh0MEFCSUVj?=
 =?utf-8?B?T0R2ek9aY1VJb3h3NEFrdkIvK3hsSVVtYWxybXJreGpoR3M3TDRoOHpXaWpE?=
 =?utf-8?B?c3d3L21CTGw1K1VELzZZNnhFMUdwZ2Izb3BPRzA5NldnOFl0WUZBMzk3RkV3?=
 =?utf-8?B?N0FqVVFpUEtSSngrSVVUK045cXhmRUI5eFh6VlBZMnNCL2ZXTWpwVUZzTEw3?=
 =?utf-8?Q?ULXfC+suoY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWdOQXd1SU5MNUZTYmtZSGowMHQ0dXBRQVNHVXFTZW9DRmdUdGkxOHhYb3JX?=
 =?utf-8?B?R3BGWjQwZVA4N3pwdm1vdHlON0JySS85L1lKNFVQeGRPakw4VVFzNjdLLzZS?=
 =?utf-8?B?M0lpV3UvWXRpajYxVUZkUFV0ajhHSFl4VDdTbWoxSEk4eFUrZno0ZGRIN1Ji?=
 =?utf-8?B?cnFzZ1Z4OTBseFBsUHM0M1pXV2lUa3paZGFsNEVEZVN3VHF1OEVLdmpZYlE1?=
 =?utf-8?B?L3ZYbW5oK05UWHp2NGdmclZKS3NYSE9uQ2M1QW9rWnU1T09wdkp1RVdpR2Ux?=
 =?utf-8?B?M2dMQmdsYU1GMkQyRktUZlFEaDdyNklaT20wLzhUUGdDbzVTRy9WQ2NKZU5v?=
 =?utf-8?B?K0Q2dnpXTUxaVUsxaXNKU3hoeEY3NGJ2S0lOblJzbUFDL0xFQmxVYmFOVW5k?=
 =?utf-8?B?TThlTGhUR0NZZ0Q5eFVrWlAyMEVobUJ5VEljYzhxNytJL0JXbzNqQVBXazFR?=
 =?utf-8?B?anFuYVVXeVFvcm85dWlXNTYrYU9tVGZlZ3l1eThOc1Avejk0a0ZrSDcxNzhV?=
 =?utf-8?B?VG50dnVNUmZGbHZqditMUkVCbjdYWDhLamRWOGJCYWZqS3RWK0d6ZUZjckli?=
 =?utf-8?B?R09sZ2NwcTBhYnhKRy85WXNkQjFNRmRBZGdqWFlqVnZHUEtXVnloR01kcUZj?=
 =?utf-8?B?cUw0YVNEZ0JrSzVDb05xbEt5bXNBb09PRkxQbVZMQmxBczVCYS9xR0lyVjkx?=
 =?utf-8?B?WFJ0YTFxdEVjTXdPQzJ4NkpZa0YzdERMc1lhU0Fab0Y3ZkFQMDVjblZPVGpM?=
 =?utf-8?B?czA5bHhkbC8zZWx1TVhzdlJpdElqQ2Z6ZnRLWDJ5UG9La2VtUHRockM5U3hr?=
 =?utf-8?B?OW92ZTk1bnF4V2JNV1lMOHdUMldvd1lqOU03NCtteXNodTdoaGZmWmwzSncr?=
 =?utf-8?B?c3IwbnAySjB2YnpQTDRIRGw5VGdrcUoxbW94eTJnWFFuL3FnaFJoT2w1amV0?=
 =?utf-8?B?N3FTWnpES3FzR2pZb1RxUHNRSHBLMktiK25tUUJxVnVoNkg3eWE0YjlKaGNK?=
 =?utf-8?B?T1YvNFFmR1lod2svQ0pLTHFPZnhwaWhMNmZTNm9Dc1hEZ1ZQbCt0Y1RGVXFP?=
 =?utf-8?B?bVFhVEdzYldZNWxiSkM1VktrTXFvNCsrMDdId0VQTDYxdUE5NjJmdG1NZ25p?=
 =?utf-8?B?bnJIMVZFeENHT2hjc09zZkJqY3NEVDVGTDNWZWJqVDZQZlg3WTNoWS9mN3lp?=
 =?utf-8?B?T0pDZ2xTZmw2VlZaL25zdkhjakNiNzk5VmluSGVUd1BWcHJYdUtjN2V6UERi?=
 =?utf-8?B?SjMzVDBsblhpOXRRV3ZXOUxGTjdDUUQyNWtHQjdBTWMwTkl4aVFCOG9zbm5K?=
 =?utf-8?B?UzJFbjNiM212WWVNdTltVWtoK0dSR2RLNEZXb3gxZ0xJUEZjVVZaWWI1TEJQ?=
 =?utf-8?B?NkNQWFNYVGZGdlJRaWVBWWNWTFI4aDdTOTlWR2Ezd1Q1UVBWZ2hLL1JyVkRi?=
 =?utf-8?B?YjA4ZS9WR1ZMaG13a3B4Q0dvOVAwV3VoMXR6WFNBbktoMnRibW5sVHQ1RzM1?=
 =?utf-8?B?VWNlSFprNUhZdDBKdGQ1VUx3a0Y5ZWVqRlJicUUyMWxzWG93YmpMSEIvSWRK?=
 =?utf-8?B?MzhMZnNIelRHU3plM2lWWHRnN2ljTm4vRndvZ2NFbHdtNzFWcUY4aGM2ekhD?=
 =?utf-8?B?VDJYeUhMbHQxTjc1UWpuM0EyQ0drb1R6RmdaaW11ZmJXN1NqNG9ramtRVFRV?=
 =?utf-8?B?TDBMaDUxVVdhR25SamttQnhMelpCWTNITElXN0Z5REFPNWhEVFNZMHNjdUlB?=
 =?utf-8?B?Qis2WnVOeFQ5UTM4ckkrOGNSYlZHQWNHeDRKWGpjd1BvRS9nTFFhOXJmeVhr?=
 =?utf-8?B?WUE0U1IxODIvK0I4bS9TdGlIdk1SYmR3R1QyK0s2RHdaM2paMEdHOGsyOUFp?=
 =?utf-8?B?enVTQmFFK1JJeDk4SEt0OHQ3b3NOV0Y3YUhKdWxKdCtRbUI3aHE3MVA3bWMr?=
 =?utf-8?B?TUMvU0VjNFF5RHQ2VTJmaUNENG00bElNUFY1eVg5V1RGc2Q0UndmMzRjMUVJ?=
 =?utf-8?B?UVl4WkplTlpkYTlSR21DRDBUMzdYN2NqWlJZcTJDa3Q4WmVzZ1hNYjhZMU0w?=
 =?utf-8?B?WC9DUkw0ZVUrbFNoS0ZrRDZPeUM2SHNXdlhSZUloSittZVJlTCsxUnJ1VVdF?=
 =?utf-8?B?ektsZVBDRkcyMnVCbWgxUGNQZ2ZybGlZQUpFWENIZGF2U3B2YkdMOUxuS1NO?=
 =?utf-8?Q?MMbAwlqD1beKMbMDlrGXb4eq9CksZT8DUPgyPpG17XJk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91888381-1f33-4c05-e760-08dde182ca28
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 13:50:01.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVkSmRf3376BKUZMeMNtBBIGyks/Dx6h24NCcYU/ksUOD3m3TW1vkDS/ScaeSi1fBswtPzkTzanLRrI4NI1Yaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

On Fri Aug 22, 2025 at 5:07 PM JST, Miguel Ojeda wrote:
> On Fri, Aug 22, 2025 at 5:10=E2=80=AFAM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> The methods making use of this feature are definitely usable by other
>> crates, and can also be inlined by the compiler. Would that be a
>> problem?
>
> No, that is fine.

Strangely though, even after enabling the feature, I am still occasionally =
getting this warning:

  CLIPPY L rust/kernel.o
warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` but this=
 item is stable since `1.79.0`
  --> rust/kernel/transmute.rs:39:45
   |
39 |         if bytes.len() =3D=3D size && slice_ptr.is_aligned() {
   |                                             ^^^^^^^^^^^^
   |
   =3D help: for further information visit https://rust-lang.github.io/rust=
-clippy/master/index.html#incompatible_msrv
   =3D note: `-W clippy::incompatible-msrv` implied by `-W clippy::all`
   =3D help: to override `-W clippy::all` add `#[allow(clippy::incompatible=
_msrv)]`

warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` but this=
 item is stable since `1.79.0`
  --> rust/kernel/transmute.rs:57:45
   |
57 |         if bytes.len() =3D=3D size && slice_ptr.is_aligned() {
   |                                             ^^^^^^^^^^^^
   |
   =3D help: for further information visit https://rust-lang.github.io/rust=
-clippy/master/index.html#incompatible_msrv

warning: 2 warnings emitted


