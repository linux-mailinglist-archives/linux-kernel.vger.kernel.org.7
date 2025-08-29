Return-Path: <linux-kernel+bounces-790979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7CAB3B09D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF097B8DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390271FCF41;
	Fri, 29 Aug 2025 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WYhRpc5V"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116611E1C1A;
	Fri, 29 Aug 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432271; cv=fail; b=DVTJPBBboRoiHPWZ3Rz6vZvKnLXs9cdwhFjgMxv+7WyLJQkbR4VlB+V5ttb0ImQO7cgZZXM1y7hMl9fjESdOMhRvgGk418+OnorqNSfKY95DNZeT1+otj8qBmR/8W0i74j538NScAG0SoZAPykoT2rLqACMJMUfTd9Q+v6lZGB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432271; c=relaxed/simple;
	bh=BNUr2Xfv1LtZ0ntuEHKD8SzxzWegkabFsiII0s8CObY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VmtejN+ywng5SfqKgU0eXB8qPF/x2bugv+NMHoOXwBgyUXLPOa0ZabCtNclyEaMfXJUY0wsNL371wZL/2x6sw6BDhmWvL9aMQzZOyaRgUmFVYcaL/gaKRW+kU5henXUwXWX0DrnZB1bdXEQ0+IsJbHYdTfH3WMGc/1Yl6dn3C6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WYhRpc5V; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5rgvGb1X0LEIwf7wrTobEtiKoUmR/riEaj810NyHS8rl/Xz++laztkQ1ze2/aQUCYZwyX2/Yw9GkUoiJCOdUuC7jQrKcsnz2vTCX5WtX47KDhw89suolJUz7fBbxCdFM42bj4NpVq6x2++EGTVNLPpctJdd0JkrtezskJPF6MrKAoZUD0YlD3RaJBh/79WloFJANl7UbSdrdT+gmO/MwigtucWFCZCl0zyI4bD0i3wPdqsSahVfRaBfXsns3CpwgsQLtv33rriF9OVqYfw/KdOM5gg/CjzFMjIJKJe8TmQjpwXXcpH9y8P+m2AELaRRDjE6/dchd6bqm0u4eVupBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNUr2Xfv1LtZ0ntuEHKD8SzxzWegkabFsiII0s8CObY=;
 b=Sc4qd/kVt6GQI9xTg1TaKwhxJQcObUY03G+OjRF9pvaCWSZfwMga8Rb/IcYTyle6BXXIXJ7KOLVEhrj1kha7YzwFAPICqlZiNyjvX1oqRw4+GAiz56+iUby0RvJdAdNS2gqmTMx+DdF6qTCzzrE1lHBSrDfgEib59HcMdvixvmT5mQwCj3hsQMxYL/4E55eWBU4fiPAZ72fC6Ha6FGFlhl1qXH7oQMVrvoihaUipdxfvPUmWMqAHjzTAfEM2fv4nY9AIIT74pYQtYmCsFskWKrmaOK8ZYZvk92EhJ6FuwFjGrd/viDxH2Iv14nxgoB9oUap1LfwKRSOzxttIWwHdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNUr2Xfv1LtZ0ntuEHKD8SzxzWegkabFsiII0s8CObY=;
 b=WYhRpc5VpJFplqYgMxF+3Rb6kUM2PYF6Y/mEvHCOBPjS5VITD0CpomZI253UFACe2NH0w8sivVD38iwpSSYOlXe1C1lK0+bEsUYSOCy5bFPELnIOJFQlnAdkbzxDhm48AIgELLDPSFRPO975z1TxANy/4o23XDdTnRUisSg5ivFPtES3ddEBZpH13A6DCba3zbOGGa5LpMX6mydil2atOAl7clpYHQXDseCl8tn+a4XxUlrX+tgMtl0S+nanY6Ls2P+jTHpffvHTONrO5diarEYP9OmpEOFLqqgAYIIilUFczAV8LvVmtFDd2RytvOdZp4C9EW29TzVzaF6inse5IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 29 Aug
 2025 01:51:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 01:51:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Aug 2025 10:50:59 +0900
Message-Id: <DCEJ9SV4LBJL.11EUZVXX6EB9H@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, "Christian S. Lima"
 <christiansantoslima21@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250824213134.27079-1-christiansantoslima21@gmail.com>
 <CANiq72kGh2PS-c1n2Q1g0t24J-b3ctB0kN3GK8RDXhtQMGAtTA@mail.gmail.com>
 <DCDUIFACG791.3SCF7302W8JZ8@nvidia.com>
In-Reply-To: <DCDUIFACG791.3SCF7302W8JZ8@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0171.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7bd2fa-d45b-4a09-1891-08dde69e82f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djVLQURYYzhnTTFlRHQvU1hCSUJmNXhGaWh5MWZDenBCdE13M2ZZMkFDdG8w?=
 =?utf-8?B?WTJ6K0d4OXBadEdWQmE0Zy9yNlo0NkhkM0l2RnV4enhsaUpTazhUNnZ3aGZt?=
 =?utf-8?B?Y0RSaGIyV1VXSFFkdldOSHZrcjZrVlZnMDU2WXZ0WnlqQzhzbVBXK2JTNklS?=
 =?utf-8?B?RXNib1JMY28xTTZBRnZ4RXBKdEdjNURSeWpNNS9jdGp1V1RJYVNCcndrdFdZ?=
 =?utf-8?B?WTFJV0ptYzM1RWpLYW1oZGhGYzVyc1dHS0c4cHBwTjRaeHlRcG9mUG5PdzJp?=
 =?utf-8?B?YzdKcGhHR0dEcWZXcHc4RHA1ekpQTlQxSkl1NFhNZ25lN1g3VThxelJkWnpP?=
 =?utf-8?B?cWdEU3dDRDFvTUVPRjNLeSsvQUgvMCs2eGFYdmlHTGtqUXdHM1dFR3gxNWhC?=
 =?utf-8?B?V3d3QTlRWUU1YmlabmdFMlJWeDc1ZEJBRnJCUUtaTDI1Yjk5SGxONk52dGRC?=
 =?utf-8?B?c1lCVXk0eU50WmRoaHV5eHVCRGwzRml2R0o3WWo3MVBtQkd5TUN2MFk1UlRw?=
 =?utf-8?B?NmMvdytjV0ozUU9tOWtaSG1VWTNkVDROQWtWQnBKd3RyUlZGM3ZTcDNWNTJL?=
 =?utf-8?B?eDdpSUZ4Z05yalA0a2lRcEVlRmJwMGNqVjlPN2lMbGJrajZXSkxYLytIU09T?=
 =?utf-8?B?Mk5tbzIyL1BnSmhOd3pyTTgrSVZxVUp1dnUvQkYwM3lha2FTTE5rb3hoVXlZ?=
 =?utf-8?B?dFlPekZhTEZBVFRNcVBYT1lQdXFmakpMME1IWXZOZjJFdjArSSszT0k0NzNZ?=
 =?utf-8?B?b1Fyc21JSXR3N2daMUNBOU81TytEUm54NkxvR1c4RVArNHFWeFk1eUtDZVBm?=
 =?utf-8?B?NGNzSStjbnFZeGxjUm1wV0pka2JnU2I3UmYyTW5yejhMb2lYOWs5WGVtNVEr?=
 =?utf-8?B?UlRHYnlBaG4yai93eStESmFBL01qcWVWT2djQVVvdlEwNkhXcFlZK3h3S0U5?=
 =?utf-8?B?YzRZZFdxOTlyUHBMRy80NFJjcm8wRGxDM0xmR0pOZkpGM1l1Vi8rd09HZWxV?=
 =?utf-8?B?SDNYMUdDbXhHSE51YVBkc0J3OTgwRU9ZVGZNUCszMmlTMXVLY2pwaitRTklJ?=
 =?utf-8?B?UkQyTHN6eXV3K3BJaG9FN2lpekswdFh4RVA0K0FDYTN4TlRSSWN6M2Y3MHl5?=
 =?utf-8?B?SmFTRk1kN1oxYjVYSkRBZzQzbkxYdWhQL29LOFZCMlFTenJxUHZkUmR5ZVpJ?=
 =?utf-8?B?K3VIcGVJVWNIZ3J6dkpDejZKaGIycFVSV2NzSW5MZ3dTNW8wcXJlVVU4dUpn?=
 =?utf-8?B?ZDdaU0htaVozR25abm41Q2Yzei94NnQvbjZKZjdPSEdXcUc2RitJSzdzRCtX?=
 =?utf-8?B?eFhqdTUzZzJzazlYN2Rnb3dPVlluWEpxNUlwM3NPNzVBaUFkSzJEeVJ5OFV0?=
 =?utf-8?B?T1JuMEIxSFNKYXR1MlVOWXVwWHRQdVpWUVg4bjlDKzg0d01uOXhuV3loMklY?=
 =?utf-8?B?TUdtbms3Q2J5RUJ6aHNaME1DQ1FxQXhVKzkvUldIeUJDSjcyUVM5bmc0Z3hs?=
 =?utf-8?B?MWs4cWtMdlZvL016SDlKYitCQzV1TEpwdlpaZzZjSDRJUHVUallieEh2NjN6?=
 =?utf-8?B?T0VVK1NiMXJxUFZNeUlRVHhVc2JlVVlBc2VocFhPTVRVa2VYK0NuRkNKTjJw?=
 =?utf-8?B?VjBtNElDZHc0VHdleGlBdVV5VUhTODVEZVpHbUVZQ0dnS3NPYkViUHlRUEhl?=
 =?utf-8?B?YUhPUHFYUzhaS0h3dUtueHJsbVBUU3JyakR0UVZRS29MVUtYUm52b2x6a2xP?=
 =?utf-8?B?SzlvakNiKzZveEpHY2o0YXBPdjNYN214SGVLUXdpU0Q0dDJadWh1akhLaG04?=
 =?utf-8?B?bEZ1OUJvaGhQSTRBTG45RFUvOHY5cVB3UHJHU3J4ZnpNTkVpN1MrRjJobFJ5?=
 =?utf-8?B?V2Yyenk0dERRVjJjVVo3NmdqVFhJSUNOM21VNkh3S1lYVFk5SmRtQ1pMZEhM?=
 =?utf-8?Q?V/6r7W4B4kI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVZUWp6MFliUFJJeWtrbGZzNGdIbERCbnNoZmZZY2FaVU40eFBLazhJa3c1?=
 =?utf-8?B?TVBNa0lXR3lUMEpiT1FNMENtb0JIQ1ljTjNIbDdwM2FKY0lIUGQ0U2JXRzM2?=
 =?utf-8?B?OER1TU9tbW8xUnJLTXNyUkhrTFVSNjRUa3poWE1hYmZlWm1CbWp0NTFDU2Q5?=
 =?utf-8?B?RHhEVzRpQW5GZzc0SXYwbGpKa1hUeGw4dVkvNmxNMm9tTE9ORCtieC9rcHlw?=
 =?utf-8?B?N3ZTVjVNb2NlQmI5MlNUYTUzQnp6cm1lV0N1MWFhSy9BMEFoNlA2cVc0cHd4?=
 =?utf-8?B?VlM5NnI4eDdOYnU5RFlqUThDZ3pDRkl3ZTVvZFlzbzRzQ2JZNldibld3WnNN?=
 =?utf-8?B?Q3ZXZzZ4YTV4TngxUWgxUElQU0l4OWVoTnJrd2JodUtCWFdHVnA1VGdXaUNL?=
 =?utf-8?B?RUx1aXhJbVhyRkJiSTh6Q01leWpkUUpKcTZrUVRUOUY1VkVqSVBvU1kzQ1Nq?=
 =?utf-8?B?OXl0ZVF4SGZ1elA3cTlYbmNQV1gvajNYcTZRTmdUWUpqK3NoaWM1Z3VjNnND?=
 =?utf-8?B?RWpBNVpNVXUwcFNEbGw4dmtHWm1Dbi9ZSGVpUXdiMEpNMkpoRnU2QjVGeXRh?=
 =?utf-8?B?ZHU3Rzc0NVpOM1JQZ01pVkNCazlzQUxRYVY0WmJCZ0V5Z3l4UU1aSG9veGVZ?=
 =?utf-8?B?Qnp4MFRnQ1NLMTd1NFJKTUFyTTZydFJaNk44OEMyRWsvczZibmlHWG44Y2pE?=
 =?utf-8?B?WHhhT084aG1qUUN2dE1iNlJHVExXMzZqQmwzWTEvNkdVdUV1YjJVMWtBYjlG?=
 =?utf-8?B?NEd5TjZ3aGRVcFRZdlNBMnk2NzUwaDFhSmludkVYaXc5eTJEY0Jxa3pRTmx0?=
 =?utf-8?B?eTlLQkgrVThJbzhlWnZVQzd4NXlyeGpKeEo1TGEwSVFVVkhWTTlkandUNmJI?=
 =?utf-8?B?bDFjb3NVaWg3M3NwS0dFMXo5aXVmdW1FOStBYmlEdmNYNlZIMWVpRThPWmtY?=
 =?utf-8?B?bFZORllFbkdiWk5CMkJUVWJDR1VsTXhoVURNcFl0MnRmWm9WNG1XSS9GdVpj?=
 =?utf-8?B?d2NTMU1iMmRVUDF3bVBUMHJ2V1oxL0tjSnRKeFVZTTdGVVMwUWVOZ2tMVWMv?=
 =?utf-8?B?SEhNUEFraFFCYVg1Mjk2ZDdkU0FpY21zdzJkZ256bVk0ckNRY2ZpQUNZVWRs?=
 =?utf-8?B?dGZTSWlQVlJydjdObFJtTWxreWkyOWMxU3dYR1p4YnlaZjhlMVNKOTNNZ3JI?=
 =?utf-8?B?YlhuMysybHJndUFZRE9jLzRoN3daV0xuOTRIcHRwYitKQ0NVbmZkc25MN2Nt?=
 =?utf-8?B?Z2FrOFYySVM5dFhJUjdHVElBMVIrVjVUOFZOZGU0OFUzT09WMmJjTGNoUzRS?=
 =?utf-8?B?b2ZybUdWWWRZWlIzRzhNMTQxeGZzU1ZFY2lhd1dwOFRFTHdjNno2NUxZOFVN?=
 =?utf-8?B?NkJwRS9FT0dGdjVvZFlyTE1qUTNieTVTaU9abzMzYTZmR3ZNUzIyZDRjRElk?=
 =?utf-8?B?T1dyeEZKK3VqdEtjdElnZWxxY0NRT25GbzUyd0Fxb0J0bCt0cGNPcFZXNllL?=
 =?utf-8?B?V21vT0pLUkhCbVBVUW8xa1VCdCtkRnowTm9tSVlsVW1qdWU5eS9MamN1ZWM1?=
 =?utf-8?B?Zi8rN1c3Vkg0dnhwNmRPc05DdzdCL0htamVSV0tmSUpxVUpCMzA0S2U0VG1a?=
 =?utf-8?B?eHFpUmt6MjNyOGxmeGlpdWRsTmR3L0RMMjBudnV6TGlwVVZ1Ymk2NDVUcDlL?=
 =?utf-8?B?blBOTEFuQkNtSUlwN1RHVThQeS9nTkV0ZjdFMFM0RmRWRDJ6NythbVlYemtL?=
 =?utf-8?B?RExCQWlEWTQxYnFQcGJTUTYrWGdsV2lobFVwOEREeW4zbHN6SlQwc2pGU0Fu?=
 =?utf-8?B?UTc5ZEp3TEc1bXNZdUQ4TE5TbEh3RmJYS050YW1mRk1KcGV2dC9tbGJNbFJO?=
 =?utf-8?B?Uzd3dWU2ekN2Z01TeUpnbktqTWNpMTZoUVcxemp5bE5jK1FPZS81LzRVREdV?=
 =?utf-8?B?MTJ5SmYvMjdTTDF4MXVNR3dNblRtKzhnL3E1MVFIbmlSNkVpeFZQYUY5OElZ?=
 =?utf-8?B?Qkxmd29FcWFaS1J4Vnh4dFNGUjFmK29tOFJ6Mk1YYTFObzlYb0RvalZRV2ht?=
 =?utf-8?B?dnd4bzZTeVZTUnVNN2h2WkFkMjNwQ09UWk0rSlZISXJlM25JMDdDRE10QzFn?=
 =?utf-8?B?VWxuMFVBTjN5cit1MlBKc3JSTHRxbnRvKzVKODFBM0dnTzMxMENBeCtwdlZt?=
 =?utf-8?Q?cAaq6OshqWdE3HSHmrSQN/bIOhcFb7itWZhQAuPC5FJQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7bd2fa-d45b-4a09-1891-08dde69e82f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 01:51:03.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W453Iz61ryToUoyI3YQWJsOvUHwi9QY4hJQOrybruZQbystofXqjWxUJoPxC8elb91iMZ5zLXeGWkqfrqC23QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104

On Thu Aug 28, 2025 at 3:26 PM JST, Alexandre Courbot wrote:
> Unless someone says something by then, I plan on pushing this to nova-nex=
t
> tomorrow.

Pushed into nova-next! Thanks everyone.

