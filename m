Return-Path: <linux-kernel+bounces-870080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DDECFC09DDF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B68B23477CF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B6302772;
	Sat, 25 Oct 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C2o2VS8c"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712B19882B;
	Sat, 25 Oct 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761413269; cv=fail; b=TjtugrJ43x8YzqAIJH8FvrxoqCeO8RJiKxWrvfmnX1bJs0zJCvicZ+w9W1kqAJgZtK/umaVtTe/9r/LuUfDR/7fXG32yamPYbntta6hxrw6mBDMTKsIUem895tPsdwIsGJ4gYSMJL5tHh4uCQwjHsAo5IDyGyaQN78Q1ap1NEmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761413269; c=relaxed/simple;
	bh=cw8JFQLYUS91KHHevzjsN7f6+67PtcchzgJjBWS7NBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=beC6HaTSrzbldpgntuUcwq9442feuOUxasMz5lNZPd1ZcjUZx9iTKx69U363iTRhFr7S+8rvkVmIvzhfuQXyIr/iFmdyZvr8AXihfM13D0k3jBKykEMkK9IyA6FD70paiJ/gik3/uaaKTMug4KscQFaZsAx38yCe4Q7ff8g/ofs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C2o2VS8c; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jkh0aRprNzDdPSDs/QZKy+YwZPm+kQ/4tzwh+0Rzo11DbUfJHyDuDpipa7OR24nnyeCZIS0KJaFX1xqwjMuHnD9tTvEcRC7OQEi2AQT3Yg8paqL1xbcmRaHOc7/VnmXyCpQoUjw1+zaK3lr07uIAHFzVKFBY8Hcb+wnj8RqaL7XoxR2gz4CKGdTJ+KAZkRytlgUkFGENgcu+djhr4ICt4Mv56HQAulPIBuCzkc0v01vAUZD3VKOZgQSkRbENDy5+i7AmjiGpx1vdLwnjKKCjU2iQUID2IOla1/qSorqxWSJjKFEmdpgCT9NvFeShNaU43KcFRM+OSw1xO3zdmK4FrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H3BgFBpA5GqaIpYM5dwlg+vxxzj58Ec9lGlDVPu4ho=;
 b=QhVmZF6MdCqF9OoUapX/VqX4PaKLZPtva+43f0PMyC7UoilPQJzlxmLRHH1kxfVdvctlRCTuEI6CTIdGAuKtDwdlVK7RlJhGORJR2+x85BQCVsl0h8HW6X5P5dTzYG2cpve4XWYmedzwy0mvfsiTgH3IbT52bHGiRY2r2B6pVepfOtENLHliQkGGqLdI21jYehfxiYhXDzDll0zjeApjxcmW218It9UvKbjLqW7WfOgVbDFy9JK+CeXgIhIQGHsxseXBa9oRVCoATG8rlfnzgghUipW+l8Ctq6GVn9CNWL+6gCvBvB/gdLTD+uyaACxbumuMtoFkEzy5WO4o3+4ACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H3BgFBpA5GqaIpYM5dwlg+vxxzj58Ec9lGlDVPu4ho=;
 b=C2o2VS8cFWU/9MO2snsPZi7/lZsesMwh8wVW6tcp9+BYUr1ri46b8E9yG881Seg9Dxmp06LKwBG0I3Ezpx0frPJiYdzdgkGPU0Vm0jDVGe+s1Rtflen1v1nhc/KptVXBlj0ga4acbzTCxysXLdMPocv/mUts01Jws7nGFcv0R4T0yRsY0ZYhCo/mZRHDOHoJegzjiTe+MrPfV6dBdfDrMr41NEmAcHhEvyvJyqM+eyLt04O/cz9IV8zUjy5v/SI5OENyg/+5+g6MxBTSx/cAIKSLk5Q22lRn2m8A6WjaEqufzRuThxmfWQOpQSPmagagVaqV6dK/ZH6hZ1eWhsKATw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sat, 25 Oct
 2025 17:27:42 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9253.013; Sat, 25 Oct 2025
 17:27:42 +0000
Message-ID: <39adabe3-d19b-4348-b977-919d1b00ed56@nvidia.com>
Date: Sat, 25 Oct 2025 10:27:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu: nova: remove Spec and Revision types
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20251025001459.491983-1-jhubbard@nvidia.com>
 <20251025001459.491983-2-jhubbard@nvidia.com>
 <DDRBED7J0QGR.2LOZZJOYYONIS@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DDRBED7J0QGR.2LOZZJOYYONIS@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::29) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5ef4ec-e09f-4683-653e-08de13ebcdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE9IZGNKTVNsOTJzUXRyb081eUZDTWl4VWhXczhtNkw1TG11Y04wMWdWWXdH?=
 =?utf-8?B?dGVGZkozdVJyMVhnSFlFSCtqODlUeU8xeFVZMUJhY0hPaldlMEY5UkNtRjhU?=
 =?utf-8?B?RW50amZtQzg3aHF1dkdZNzFzMjcxS2hNalNXMGNFaHhaVUlycHdHYTB6SmxY?=
 =?utf-8?B?ZTJqSDNGRnFTY0NWMjlYNjhnMUNlMERTN01vWDA2K0c0UlRMQmhOMlBTRGQy?=
 =?utf-8?B?SVdkbTFaQVV6WHlQN1ZkZlJxYTdncE8zQk04NjYrcGJhdVpKKzl2ZmV1Kzd6?=
 =?utf-8?B?ZWtYN2daTTJzalZHZThPT0lsNE51d1VRRllwVy9mRVlzN0JJamtsVEw2YVcz?=
 =?utf-8?B?RTA0WXQyWGhuQW1Bbit1Ujk5bEY5VlU1NmVROUlXTUNlS21HbVNiNjg5SThq?=
 =?utf-8?B?RnNCck4vMWYydU9oSXFhU3k0cjUyRFNWRGp1SGtOQUZPTGlJNmQrSVgwVVhP?=
 =?utf-8?B?VDNjTmc2cktKWGZuaW5kQWMxYTlLb09jREI3c0FUVU1vUUsrQXUxak5tandG?=
 =?utf-8?B?MytzUzhWL3MrQTA3aVQ4K3FVZ0N4cnl0T0kyd0I4cFhkbWJGVC82a05xN2Nw?=
 =?utf-8?B?eXFKTXdpZnpEci9Td2wrRUF1SEsvOHJBTlkxZHFFZjQxeWdZMVYxSzlSa2wv?=
 =?utf-8?B?OXZ2VWNOYjZUU3Z4RTRJdnI1aUlwWklRNFg5ckk5SVp3T2JIdjlzam5aMUNL?=
 =?utf-8?B?QklWK05ycFJFNXFLbWhwbmtnRTJ4MTk2NDk1QTlkTG54QkZnQTNMOTNEYW84?=
 =?utf-8?B?TlFLTWI2S2cwNTg2Y0NOeUdmV1JpVWhXbTI4TncwZXArRGxpRTZPdmVkcEph?=
 =?utf-8?B?NGZGM3FBd2x1bG5JdE16R2lnWHNZRWh6S2tXYmZpcTdVelBlRDZOeEpkNUlV?=
 =?utf-8?B?SVJvZVpETjhsbjYvazc1a2s5dUd6dCtQQTMwNXVDRCtMRjNML25wdWxyWjRB?=
 =?utf-8?B?VjlWQU95SVJwSC93dmd6a3VudG1UYWJZR1g5aFRlc0QwRnVTcERpbEtEQXp5?=
 =?utf-8?B?WU9GUUMvRnRic2pnT1h4a1I1Kzc4OU43Y2dtWFVmMmVtRDhhOE5sL2s1T3A5?=
 =?utf-8?B?VjFFTDNkcGtrMDRzSXVqZS9JTUp0aklJNit3eVBWNW5qQWtnL3ByTU9PamVP?=
 =?utf-8?B?V0RIb0dOUUZZdEdBaGZ1ZzJVTXcrSmdRei93SVZ6S2l5ODJMNmsrMEpCQ1F5?=
 =?utf-8?B?UHkyLzdWc1huZkQxRHpIdlluN3VjUi9vU0RhY2tMNVBOT2pCbHUraTNnWkJB?=
 =?utf-8?B?elUyV242Qnl6R3lxYTRVbGJ4Q3Z4SCtlVmRDbE1CZHA5WEhlWkdmdDVTd2JH?=
 =?utf-8?B?NEswdkorMHd0eGYvNnhPNzlLR05ZZkJRODBoZzBnSDRJbVZaWFdSRGdsVE84?=
 =?utf-8?B?UWZaL3g5dzBTekI3TURKVHdzRjBTRzVrY1cya3dBdE9obzg2bXJaVUtjVTJv?=
 =?utf-8?B?K0dsNDhDb1ZkeUt4UHJGbThQcGpuRUhNalhLcUQwb3hmczc0aXRiSzB4R2hW?=
 =?utf-8?B?azcwd0phdEg1dFFkU2hCNDlKQjZQZTNCVkZhVCtOdExyTkczd2oyTmM5MnFJ?=
 =?utf-8?B?ME9SR0hYNlFNQjRxdlUxYlViVlg0VlNDalFocm9xdVVldlhWcFR1akZhdXBG?=
 =?utf-8?B?dU5CRGMxT1JWOEp1QitxS0NhVGFOUDN4cktPSVp5VUZjcTlxdnRsNkVBM1Zq?=
 =?utf-8?B?bmhkb3dZT2hLZ3hKOFhrc2ZMdHpvVnA3b0N6WE16Y3poSGlJUWs5S2t4Qktt?=
 =?utf-8?B?Wm43d3p4cVJUYit6NlFNRklLUlJjaVlYMkdQakZtbG4wRVozVjRPR1d0Zm5I?=
 =?utf-8?B?ZXdvMm5SUGhLOTF5blVEd0k0Z0pGVkVsVmUvZWpSeFB4V29ZdHB5bngxSnhq?=
 =?utf-8?B?T1JVQzUzSGdpZ3ZjWVJ4Vkxic3RpMUFuczk4QjhmcS8wTHVUbGowQ3ZOM1hF?=
 =?utf-8?Q?iYOno6sQ9rhNiBatCunoV0G15ZMLaE1Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjBVYnpha2dOR3lhU3VjbmM0VEkycjRQMFBDeGJXeXU2eEhReEtrYlZzQThD?=
 =?utf-8?B?Q08zS0RjK1ZTcXRxdlF1S1d3V1huajE5dCtldGdPeEFEMjByTHZuWUwzc2Fw?=
 =?utf-8?B?SStrY25QWUNsaG5ic2FOTFFUTE1KdVVzMWcvczNhWGdmSFIvRlVZU25PaWxx?=
 =?utf-8?B?eGFtZHB5a2FHdmNQMG9jN2p1L2VSMTh6NnlYSk82K2UzMGZSUEg3SFVXQy9T?=
 =?utf-8?B?L0J0UVVYMHJTczYzRmgyNEZFMWh6NWE5aWFNOE5kZmxBaUZXaTJ1cUVtTTcx?=
 =?utf-8?B?R2U4aEord3JxemRITlM2U1paZ1l0eXdaQW9TWEg0aEMvY1diejl1cHNPdWFa?=
 =?utf-8?B?VXZ2MkRsZlhweGZyS2kvWEluUUlrdVMrZHZFU01oanBqdmNEVXFZcm9ROFk1?=
 =?utf-8?B?azFuaTNKcURvYlJWMlJ3NjhzR2dubGFhMEwwdFBHVUF4QURMRzR2YlVpaVBI?=
 =?utf-8?B?a3FPclRZZ2RaWkUzbWxNVVRYTStvN2QxUlR4T3NKQlNrOXBxaG5MSmgrRGEy?=
 =?utf-8?B?eTZlTXZUOHA1NmkvOXQ3ZGJtMXJ3Q21HbE1vejJNK05yUmU4M01sMkM2TU0z?=
 =?utf-8?B?V3JKa1RNQVBsYWZNejEvWHFwUENvRUVJNjNyQUl6SnRINTQ2MUFBV3FQRkJS?=
 =?utf-8?B?bkk4bmdtcW9teDNLZWhTOUpjeE8yQ2VETSt4RXpwY3dnc053Rjg5YVBoLzlp?=
 =?utf-8?B?WWdkRENOaldYMFJYN09McDEvZVUyc0hRb0trbWFzWUgyaTdua1lzMFRVTEdV?=
 =?utf-8?B?Q3c1cWFhMFVkQU80UmlHMVR5bUxSTk1acWZtRHhyOVdZdW9icGEzaC9sTnRB?=
 =?utf-8?B?M0pjd1dNeWtSbzJYU1BMa2pscGxMbkJleWxXd3lzZ0VOVkFadE5vL1YzTURm?=
 =?utf-8?B?bVVhM3poVWZrVXB4OUMza3ZjWWJjcVA5SVhwUjBjZisyS2dwT291eTl6OUZ3?=
 =?utf-8?B?M282MFNITmo4WkdWcmxkb3BmUWV1b2pRUUxyUTNMNFZ6Y0J5Rm9XSGV3cFVC?=
 =?utf-8?B?dkRTMHZGWkZMTlZuY0JFMDlLYlE1dTBITEpSUFBxTllxcnQ3enUvajNoaVVa?=
 =?utf-8?B?QWlJK0RleW1rcWpxQnRPNUpGVGhEbnBsUmUzbjViS1lPcDQxSGpVOXNPZFJy?=
 =?utf-8?B?ZnRUZWFOWEQyZWZidit5b0pscW4ycUorN1o2d0kvSjdKeVFONEpMRGNGSGFI?=
 =?utf-8?B?T1EwakpzU3ZHM2pSWEo0MlZvWlIwOCtWZERicnVTQXNMNjVwYzlFblY2L0JE?=
 =?utf-8?B?ZHhmUisvQWZDSlkxZENhNjVVbXhpTnR1bDZmMW8wUHNkQUdMam1rMUtsUWpE?=
 =?utf-8?B?WkNzOEpFejlwT1JiTzN4cndrSW9RRnNWSTJyalVGMGJkRWNVc0k0UlRZOGdr?=
 =?utf-8?B?Q1o1QjhvRnlHM0lrcVlZQUpUV0lucEpxNXhWUGxXV1lONnY0YmJDajRseWg2?=
 =?utf-8?B?M1d6dEswZDQ0VEJuOWZTRUtWZ2d4OUt2bU9lOUdmazBLNWxLVjdNOTNxOU5Y?=
 =?utf-8?B?eW5XY2FORGRXUXVZWEtib3JuWWpJeVNzazNtUFpCdVUvM241Nm5STm05ZFFw?=
 =?utf-8?B?UzNrUTBlemVjdHpieU9qd05vR09FaGx5bnQ1U3lJYzdmWW5sZnhkQ01zcGlp?=
 =?utf-8?B?bHFsbHlESTNhS0JFdGJjZnJWS2pxWlJ5MVdOZDI1WndPMFl1Ni9SUitkaEZ1?=
 =?utf-8?B?SVZpNG9mRndOTjBCNXdhbzBFeUxSQm9iNWF1ZlBCWWNOa1plbHkreWZjeEdY?=
 =?utf-8?B?dmM4Y1JFdW1LZXRWemloYVRNUkFsT001bmdzTFpGc2VUK0N0V08rOTR5ejNj?=
 =?utf-8?B?ZU5WRG9hbWZ4R3BoUGp1SzBwMWE5LzFJdWJuSUh0MEgxVDdON2w2Q2ozdVJ4?=
 =?utf-8?B?aENTOCsrUzd3aXRhWFRVNnNsQkUzbWlDcU5vNFhIbzBDV1lOcnhka1pwdEQr?=
 =?utf-8?B?Q2NmZFVROFVDSks4dDAwd2NkNFpINXc0M0J4blkzeFpiTDdzejNyOFkvTFho?=
 =?utf-8?B?VHptNThZTDNBQUFSZ0FXNnJFZ29sdm4wSVJsNk5oa1hmOU5UbFlxRkJZMGxi?=
 =?utf-8?B?NkgxYlRxVnprdEd2anorUWhqUEhSUitYUHZCZnZWU0xzQmxjZ3FucTIrWTJt?=
 =?utf-8?B?eHZwbHFMcTBKNyt6bnJVOFZwOTRTSGVBMFdXTXRBalpSSlYxL1p3VHk1azZu?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5ef4ec-e09f-4683-653e-08de13ebcdd2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 17:27:42.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dkqyS1tkdCGeQxSq9arVoQ5QR5asJ60MiLvcsPclvdWGCbbsZv3b9nYXmfPnezNqf50Tlge7ma1tluierEfog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948

On 10/25/25 3:01 AM, Danilo Krummrich wrote:
> On Sat Oct 25, 2025 at 2:14 AM CEST, John Hubbard wrote:
...
> Now you have to open code reading the register, get the Chipset instance and
> manually format the revision, which was previously done through a Display impl
> of Revision. And the subsequent patch introduces even more open coded logic in
> the constructor of struct Gpu.
> 
> Instead of removing Spec, we should improve it by giving it its own Display
> impl, such that this code can become:
> 

Sure, I'll do it that way.

thanks,
-- 
John Hubbard


