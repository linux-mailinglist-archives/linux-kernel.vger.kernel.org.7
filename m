Return-Path: <linux-kernel+bounces-886566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC7C35F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43EA44E673D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA14328B7C;
	Wed,  5 Nov 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uNmYMvZ4"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C81309DA5;
	Wed,  5 Nov 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351413; cv=fail; b=nNR9QpZsgPeVH65Ek1/IFn3z7BRMFGkAV+goKvZiGLXo9cSKnVO1KHIsMaZQNOumOIzbhrS8W1Y9sQ4hJa4e4ZJjGELmmC5+DuvkVXdu7UUugNe7Kv+JSn4c8ES/1nwoBeBRK5WnZd30u+2lEsnyi8L2GipswqgAuFdQg50dNiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351413; c=relaxed/simple;
	bh=Bg2sNTOXmQ7d6DYSJYMba6F4fnB8Y0sSzuL/8Ye5nvc=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=BqgJOI4ubFdcP61veiEWQv9t4TNX9PNvi8LiAVWmDwBsLmG9WrfYyrivtg398ncat3RJlI9JxMzqp5vG1bkCpNkr0RG+3gE5QxY+UpW2zLPYpBFr1JhQ0zIgRY5bpMNNDrJHMkYq8jley4thtChONjxgrgEQJyUK8xP1c4fqcRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uNmYMvZ4; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlX5yeftgaSc4/dzj7s7LetNcCelpM7aEhF4OuYkD7B1gnwqUqkmNiywqmAGIWeNzOQJycjKntkrpjrwBqa13cqVYGnwqtxeS1mleiUe8Yg3Jx1f5CGTQoaX50/JyAdLi5HfTHYEN79criv+H6E5/2H94F1uq85RNlJG4Uc8oqgQEn3uCa7Va7YJezp18CNPUEzTE90xmUwEOALSnlxX8hJJ5tl1zfdMlORMXVwjTdqGQ8DdFZwMnKJcrZRSynavY2N+UhfTcld1gcN7qDI/OuaAiP1/7pWmln6Wo0C37eM5/gGTNtQyhgITKH/Ig3m2GzJN86oe1K8fDaNG+JemsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhC3FH3IdxlSE6OCzJUnO4HDxJv9S4PRRfKsuMiYeRw=;
 b=YG6xDozIup3cHOCCgPa0IEc0N8bwPWwHCQgcuJ0bP9KQ9traj9wGvtCwbA0f5YLjFR17Sa8I5Vbvfhbj2qE875GqpZ9vm8D5mClsiIoO8oFTVuD/RT9KBTQsR1tQn6qvnmgl76SO3khLnzcBucWO3e5z1ee4XQ3EQ4G0U7xMeINx6SEpB+1TRv9AiVH8iuMw36oBEc28upFTbl41Y0XS1mU7PK2Rpo1NPm30n3G1ra5npjL+yRZk9qOWRoW/GikYZrQu24QW9PuaWJ0PtFYneG+BVzr8C/r5pzvoa6jqBUYDtnCyrSXwmIMehwGmHRSgVRC2sH75sY4CoggovBGP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhC3FH3IdxlSE6OCzJUnO4HDxJv9S4PRRfKsuMiYeRw=;
 b=uNmYMvZ4zDJZRtug1nLedhtUmCOva4u8rNxjKYwOZXgDQhRS+eYsA38HoyOL0iIwo3YfD0tguacfyyl0K2q/Hqo9Bzccpssnv0b3o32N1L3ahiC+VESzkjhjI2/n83EPiLHvNXH1ItGACnawRIYJU8HkshNdaw523Lo2S3TnNAGzLOWXQ+ctmpnmY6YcEoSKW2EntJOWiXQFQk5hsOTRHzXpP4YAt6FWlcWFL9biB/MO0qtzxGytX135J3mE6+AsRU81KNTJD4tcMgqdJNqVQlRyMkyTp9sF2utyeXwki7JlwprFPsEtM42Ls2ycPP/neF7z7S7oZHEIz9iUTF1vIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 14:03:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 14:03:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 23:03:24 +0900
Message-Id: <DE0TFMFV6D6W.CS9KM6FNM4K5@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <yury.norov@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury> <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>
 <aQkEVqbhoVMUc-Km@yury> <DDZKZFCK27HZ.DY3QVXKFU3BI@nvidia.com>
 <aQpUSw49QptgxjFz@yury>
In-Reply-To: <aQpUSw49QptgxjFz@yury>
X-ClientProxiedBy: TY4P286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: e05cfbcf-c3ec-4143-debf-08de1c74180b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REFvNy9kUkhxajdMVFNXV0xpR21rWUhyVE5MemI3anM0TkdLM3VBVkoxLy9a?=
 =?utf-8?B?cTJLem5FKzhWL095MVg0NlYwejBTa0JmeUtDT1FTOUxUbk02OHExcHRCMkFn?=
 =?utf-8?B?MHhNemx6cFV2emV5VU16aUNscEhwdmdDSk55ZVdXMDZHSFFxYThqNlhMTHZX?=
 =?utf-8?B?d3grQ0dvZ2l2TEIrT3lKdStwN1VUcWVYak5lL1gzSTB4UUdxenFxWnB5Ui8x?=
 =?utf-8?B?dTlhOW9kU0VpTFhvWkNTLzd4YW1UdFRzakhIall3MEkzUm1jMUgxNXhWMHox?=
 =?utf-8?B?YzNkSjJuU2RCWS9VSldrL0tIdG91R1pMSW5lS0ROaGMvS29ZeGk5SWp6dFMr?=
 =?utf-8?B?VXNmRTFIaGJCeWc4ZWszQ1hCUFFaTEhSbllYKzFzSlAzM25vY24weVRQdDRJ?=
 =?utf-8?B?RmNlRkdXZUJiTWU1eVhlTFpQMU1RMFZNYlBqZ1ptemN1eENEeHRDV0tSQXQ1?=
 =?utf-8?B?NDBlUlpoSHJBcWpXVmJOU1E2UWZoeDhrbkl5MHZMWlp5R01Da0lKT25tRnZB?=
 =?utf-8?B?UkVwNFpLaXlvSFdtOXozeDNoYmg0VnpnWFRuTFVlcFhCdW5RakRGanRDWVdq?=
 =?utf-8?B?U1hNLytkbXd4SmVhVENmWmd2Zmgvbkt5VDJOcytweUd5dEd3dXUxNG5jN3E3?=
 =?utf-8?B?N0N6U28zV0VaOHdmNmN1K3FiR3JOenhtOUpWaU9aZlpMeTBqanpsaTBIajZv?=
 =?utf-8?B?MG5nYUN4YVNNYmNkclMwMlo3eENhL1JqZVlXNjRoZXFPbmRwOTJPL3JkZWY5?=
 =?utf-8?B?MjJwa3Z2Mkk0a1ZzM1JUVStpbGNQUGZXV1lieG9CZjNSdUcrTEhHUlZxN1Rl?=
 =?utf-8?B?NUltdkJZVXZTQlVPUEJwZTUvS29tRHJkRXEyWmsrazI2WkpNNm9YaGp4RDJn?=
 =?utf-8?B?UjAzc3JKSnZ5OTU3UkR3a0NtVFkrSFBvMkRjSTdHK3hDc2xKSWREb2diY2NS?=
 =?utf-8?B?L002K3JoS1RNZnhScmdBN1RFaXh1cEhURm9pUXB3UlJibXpZczZ1QXU4UlIy?=
 =?utf-8?B?WmwrRTQvWHZrTTU4bERRN0JFdWluWHgrMy9QRUZ5cHdFdjZ2bWc1QnpyU0xZ?=
 =?utf-8?B?Z2Z4bFNaZzRVYzhHWlZML3NrNnV0VWw1RHRUbzhxeUQybk93eFg3NTJYRXpQ?=
 =?utf-8?B?S2xBNHJreVN2Rm14bnlqNUJjeHdYMEpjMDhjb2RUank1UjdwenJybUpYMDl4?=
 =?utf-8?B?Y3Y0YnlWSFNJZUN1OUdEaWxkbGtEK0w3cHUza0NmdTVJc2p6Q0JnT09kVmxI?=
 =?utf-8?B?VTJZSE5HeHZHTmpZVEVpSzRwdVBja1lFY1V0Q215NG4wNWJkYytEZ3NVNEVD?=
 =?utf-8?B?RXhIU2dNRnlISkJjVWJ0Zmh4ZExYeDhzN0hhbnBFNjdrNWI1UzZMZ0F2YnZl?=
 =?utf-8?B?ekRUREJVcHZ5c0YyNnVWSk0yRUh4NEgvUVZIeDRtSkl5MHRQaUp4Q25EaXpi?=
 =?utf-8?B?ZlkzWHYzUXMzUWtSKy9MRzlTcG1sSm4vWjJlbHpYQnZCenB1bVBXVFZGeDl0?=
 =?utf-8?B?OEpWb1loS2paTloxNlJKbi9HWFRYSVoyQ2F2UnVYd2ZrVGNqaGxSNWRBL0tV?=
 =?utf-8?B?TVJhUkE3dFU1STl1OUVoUmlzb3d0K2FRWEFiRnQ2NXYrbXJwdk41dkhrcnpu?=
 =?utf-8?B?NHdYNlNMWkFKV0RPWWtaNWhobHI3RklVUmQ3RGFqYUFpSndQVSt2Qm1uMTVF?=
 =?utf-8?B?RkpQYkpBbVlsS3piQ3c3clZQanJuN0t4K3hvY0RWZGNmbFZKM0tyUDE3emxH?=
 =?utf-8?B?MFp3R1FZa0EzUlJSUGIyWUtjdmppYlJqVGJ0VlhzaGNLdk43MlkwTG5NM21G?=
 =?utf-8?B?bzdsMkovL2JQaUxzcTVuMXhjR1pHaCtuaEt4UVg2bXE3U1ZTWkhCaXlyQ0FE?=
 =?utf-8?B?S0swZWpSTVNTWkNnQTA2UDBBVlVMZy9UQ1B6eXMxZGQ4aGcyajVubHBUK3dj?=
 =?utf-8?Q?461zo2D80IAcaHKWzbbHtBBNaBrN8g+n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG5PL0doYUlDTVpic3lRcFczNEE0aXZMTThDR3JmemhVU0Q5c3RvS29mZkRX?=
 =?utf-8?B?NDRHeDRpT1BOTXRDaFBCNTNIa3lES3E2Wm1Xdlh6aDkzOFVtQS9vcU1oR01s?=
 =?utf-8?B?UlpLYklEZVkwK1FwN0tsU3JYRFRMY0pZZlJQMDdRZjBMSmZONkt3TGpjT0NJ?=
 =?utf-8?B?bmk2Y0JUSVdOTE9TWDN0T2NwNVNSSmRzcmpMa3NBVVRuWFFrd1E3aVIwS0x4?=
 =?utf-8?B?MVk2Y3h2R1lBL2ExcCtDenArWjJXRnpLZmtRdlpCeGdVNjhic1dMNzc0OTBk?=
 =?utf-8?B?T3ROUWZKUWJpSUdmeTJPTndnNXFJY2xmSXF1cCtvOWIrODhCZWtXdGQ5bkx1?=
 =?utf-8?B?djBFVjBEckVTbVJXZnNydUtLYWdoVko2ZGM1SUcrdUx1aVh0VG1HQ0ZYRDVI?=
 =?utf-8?B?VStjMlkwa21PUElpejNBNmRDMFRaVVQ3QVpWdUJnUmVYbXg0eXNrSUsyb1lp?=
 =?utf-8?B?ODZUV0ZTTXZqbW04WXNPYlB4dDdQbEt3ZVhsUVVIRXI5QzVLT21memJRdVpq?=
 =?utf-8?B?V3R3RUN6MEZDd0p2RUhkdmJKcXF3WGJ3Uzhod2Y2WEl0akYvTFRaSHl4Rk9M?=
 =?utf-8?B?SXFSNnFvQ0lDRzE5Y2hEN01ZYnNlMldKVWRzYWVNelo5a1llby9NcC9zV1BU?=
 =?utf-8?B?MStoVnNJV3RXbld2elAzNmtSMGVobHdFSzdsemd1RUM3MEk5OWdXdlhiTFBF?=
 =?utf-8?B?M0ZSdkRqZ3p6OC9RL3owVGR6ek9JU01yd3VVeU9qZG1yYXBjM21KUkZ4c0lm?=
 =?utf-8?B?b2g0U3pCUXJRUG5mZjh6SEsrYzV3enBoK0l1Nk9ucDhSWk9yS3NlTmFOZjhi?=
 =?utf-8?B?QzFoV2taOHBhMjc1ZlptN1VZcWNWRjcyb1Arc3hlL25PR1RRUHFaMWhFbzdB?=
 =?utf-8?B?YTJqU2VsRHVhbzVaN2EzYkFRMC9yaVA1QmFSL1hpcHcrRGhZRmtFVFhObEdK?=
 =?utf-8?B?Rk9kOGFJSDJCVVpIMWR3VVdiWG1PTHhkSk9ZRFFaaFBpeVhmeFl1cFVLYTAz?=
 =?utf-8?B?OWlHNHZpOXN6YlVHTVV2N2FHUmdxcm00dnptRjJCSUJCbC9vcUxGQkR5bHJT?=
 =?utf-8?B?azVETHAyVWxSRnpPYUt1RXMzL1VDRUNlaHNGNjlOZlZDTFZWckduaHNlTUVM?=
 =?utf-8?B?RVpmcm1vdHE5eHVrbCtqc2xPNEVRTWZCQ0VDMjNBTWFuOWxSQUFYaE9ZVFUy?=
 =?utf-8?B?N2h4d0NiTGdhc2pZSk9nOHJEV3FTanpmN0VRcFlBa1hZa29ZQVJ1bThLeFFU?=
 =?utf-8?B?cEZMTnpETjhRVHE2eXlrUWd2WDJxQ0Y5cy94SjZONk51cGsxdURIUVNHQ3I0?=
 =?utf-8?B?OTJ4QktadmtIQnhPeU5kb1VqdHEraVJBU1pIWWJRMlZkelA0NDZxeW1PK2hv?=
 =?utf-8?B?RnBxaGVja0VHYnJySWtBbXpuRmRxZnByNnBqWmhOT0ZKT25tNkhUM0JIQUdZ?=
 =?utf-8?B?cStNaXZsbUI4dlZsVkJNNk51ZllVSXBxZ3hkV2MyOGFaVnhvVUFlTWVRRTc5?=
 =?utf-8?B?OS9ISjRYZ3VVN2VCbGNicmQ0MW1ZcWI5UXEraFBPVjFTcmwxNGxPNmpoRUNn?=
 =?utf-8?B?V1pxdkI4SVhzYmVNc3BKNjR1QTF1d1M4aHhGdjhVSGRrWDYwSCtuVDlQbmZW?=
 =?utf-8?B?UEsxZG5aLzQ2UlBZbXBuVDB6TWtBZXR2M3h2NVdTQ0xSZnhsSmRDZS9IcXJR?=
 =?utf-8?B?M29KdFN4SFNYQVNVU0F2QmJ5ZXpDUVpNR2RnTFdRTEdEa21zZzcrb2RPNGJX?=
 =?utf-8?B?aVJkWTNNTmd3cW01S0JMZmtmeWZnM2ZIeS9MRDhSTkRxOGdxUWl2VEpYNlIz?=
 =?utf-8?B?VUpGLzZWM0xNZDl4RFBVZHBtd2dVK1FadlgvVDBvOHg5QTBQdllpdTBrcklN?=
 =?utf-8?B?K242b3FoQXBBLytXZ0J5UjVsbnZjdWpaUE5uQ0cvNnBIdjk2UFBVTDNZeGFB?=
 =?utf-8?B?QUsrblpCeTJPdHFSVzBjRlp0OVp3cTIrL2l1d2haSkZNWXRvMkFMZmxFSE9m?=
 =?utf-8?B?ZFNISzJVeW12QjVFUXhjYjRJWFVOd2xrVjUrK016Um1uZ3A5WkpidnQ4R3N4?=
 =?utf-8?B?U3JzbFZDM3dlcXdGWmduZGQwYncwa2RnM2dzUWlxaDR6RndhODYvSkU4cjhO?=
 =?utf-8?B?Ti9zWDQ3NEk0SXhGbnJZSXF5cGZpR0dWbFgwZ0tuNjh5ZERsZDBzOUh0TmpM?=
 =?utf-8?Q?415FiE6xLd5I4DzLp45L+gYxe4cDgkI/4JEd4iwbgQsF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05cfbcf-c3ec-4143-debf-08de1c74180b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:03:28.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV0r8n1vmL6jDv2OYMkBq4akTkz6K6xvPeWu93nUJIbQu3+FlSK15PQbv13g0vhV9ipA3jVmoOWlb2fkgv+sUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858

On Wed Nov 5, 2025 at 4:30 AM JST, Yury Norov wrote:
> On Tue, Nov 04, 2025 at 12:13:26PM +0900, Alexandre Courbot wrote:
>> On Tue Nov 4, 2025 at 4:36 AM JST, Yury Norov wrote:
>> > On Mon, Nov 03, 2025 at 10:42:13PM +0900, Alexandre Courbot wrote:
>> >> Hi Yury,
>
> ...
>
>>     let a =3D BitInt::<u8, 3>::new::<3>();
>>     let b =3D BitInt::<u16, 10>::new::<123>() + a.cast::<u16>();
>>=20
>>     let c =3D a.cast::<u32>() + u32::from(b);
>>=20
>> Note that `b` and `c` are regular `u16` and `u32`. Arithmetic operations
>> cannot guarantee that the BitInt invariant will be maintained, so the
>> result needs to be converted back if that's what one wants.
>
> What C does and what I proposed is to make BitInt a 1st class type,
> just like basic integers. What you implement is really a bounded int.
>
> Both have advantages. C-style BitInt() is a true type with all type
> guarantees. And I like it more because it is a natural extension of
> the existing integer scheme.

Yeah, it's definitely different from what we are doing here. IIUC C's
_BitInt is implemented at the compiler level, here we are just a regular
Rust project, not touching the compiler at all.

>
> Your bounded ints are actually classical integers with some limitations.

That's a very accurate way to put it. It is not an unusual thing to do
though, there are several types in the standard library (e.g. `NonZero`)
that do exactly that. Putting limitations also means we get more
guarantees, which can remove unnecessary error handling and help the
compiler produce more optimized code.

> It's not a primitive type in sense of C - it's an object. It also works
> fine. You can easily extend it to arbitrary min and max limits; you can
> expand it to floating types, and do whatever you can do with the objects.
>        =20
>         BitInt(i32, -128, 255)
>         BitFloat(f32, -1, 1)
>
> That's why you think that -1i32 fits into BitInt(i32, 4), and even
> into BitInt(i8, 4), while I don't.
>
> I don't know which would work better for bitfields. Most likely both
> would work reasonably well. And if bitfield will carefully hide
> internals, I hope most users will not care much.
>
> You switched name to BitInt, but still think about it as an object,
> and that brought all the confusion in my mind. Maybe switch back to
> BoundedInt then to avoid this confusion? If you find it lengthy,
> probably LimInt or simply Lint will be better for you.

It looks like we are going to settle with just `Bounded`, to follow the
naming pattern of similar types in the Rust standard library.

>
> Looking at how good rust macros work to implement bitfields, I thought
> that they will be able to mimic native types just as well. But now it
> seems like an arbitrary-length integer types requires support on
> language side. Just like in C.

If only to be able to express arbitrary-length immediate values, yes -
although I suspect macros could also help here.

But I believe the more fundamental question is: do we need
arbitrary-length (as in, larger than primitive types) integers in the
kernel, when Rust supports up to 128-bit primitives?

>
> With that in mind, I think that bounded integers are a bit out of
> scope of basic bit operations, and probably I'm not a right person
> to maintain them neither in Rust, nor in C.
>
> Please keep me in CC for next versions.

Will do.

Also jumping on Danilo's suggestion I will probably propose to add a
MAINTAINERS entry for this in the next revision (up to the Rust core
team to take it or not :)). Let me know if you want to be a reviewer,
that would be a good way to keep up with what happens here.

