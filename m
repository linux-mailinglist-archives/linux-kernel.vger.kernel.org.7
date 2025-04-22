Return-Path: <linux-kernel+bounces-613555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A480EA95E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7CD1894143
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426921A438;
	Tue, 22 Apr 2025 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rsOqakbj"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E2135A63
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303615; cv=fail; b=Bg33N7hjHqhxtwv4jjv9UmrVI25fJMl5XpCifycc/Xva9GHgzrkKk7PyeLu8JwFxDJ1dKE9gojzruXesOMPLgoipn+2a4veMhj1jz1lmdZLgN+86bvVQ/e+plWakJ8h2xAKyIJ/P70LaL6ZwZ05phzGvx373dcE6NxCMckujJhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303615; c=relaxed/simple;
	bh=tcGcRyph0WD04ux4HFIKl+kstfyLL87kjgydNus3O+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smVmLjUP9HuJYcKn16G3PJSD7T1DHjR/QVR025NQkv2me7Ur0vSG4fY10Vct/AsaZn8Gkf1duP/sI0x9FlLCzLy32jPACFs9CnTxvO3in3dtvT3hqOoSGMLb3mpFOSsl0vjNrDuLkTlKJ5ymA9Ft9q1VUDAWpMrujqIzsIxZjVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rsOqakbj; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmghNl23Mwq3IHjRwblI60RhzfFnw1GMjBeJHoADfE6UmdFTOqNPv0kOrw9rUF9tBCY+s8as2Yj8gRdqtXC4eIByzpZ/wRwnaAAcNUiSDfpcX/ZCdTKWA5mTVYqDXRkdrsn0pMFYQzLzIz0QVi0x5xYha6Ctk80/Ng7V1g5AYCLDty0s7kq2hCfSphez5TzjzKeAlkAb0pCwkDF5tZV2Ook9k+8iyUmBPf7UpQDOYZD/IE/QlEarFGLocKbelOTJnzFavYbQE5y3tUzUsjCusYjF0pPlFxk8Krjej/yrRqb+b2cqkd8nZmNPgbcameu69TkykoW/xx/sDxg6HJK8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcGcRyph0WD04ux4HFIKl+kstfyLL87kjgydNus3O+Q=;
 b=jDWQhXzpnste3uFp00tvVZI9IVWQrOmA2lSSUdgKK/C0R3jyowBPXO8tu6yNqr/qlqgk5nxvCoRFibTaTl4Yt9fg4aUa0qd/WDmN7+JdS9l7t3A5VN2+nOWXbWpSOlwlr2TrYes69BV3uFClMoWk5wNgg0wjneAz3lRQFkkIt3J3qm/fcInwYAmSslUm7YvJ3tuoHnu8EF3jo0wRZUtOjka80Vdi1CiuS2fU4e3/uKqW1TMpYtU1CxKZb8S4fF5qrHMAdzz0YRhnGJEfe9B4knA6sGyknq/6az5iEL5sM26RwRaJX1aJThd8YoFkuNYqM1MJHPlEDA6I15jfmu45og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcGcRyph0WD04ux4HFIKl+kstfyLL87kjgydNus3O+Q=;
 b=rsOqakbjZ7s59WUygt6UUl449rIGC8nKuGZnDvc7YO8/spgNkZc/lPGTLotoVQ4VJYaFgw7MtatqXwaNVIBIBDBgaIR7T0OtOb7QFc/3dMz4nHSeVBs1Hj8ej/N4UnsIP/J34ad7Te5pMGV3pX5Mj2X9zTTGLkFYqAsQblN/HKgiqd6/87RlHjOG5wNxxckq8dNNx48zlqp2cPPsMTOxpNevZ/KT24/6G+LYLcHISw2paYWK2lysxsrQEAslYXf6ynZpacgTvsXHZmLS7by3dXG6HKT34bLnJyxCyH25H4epdQNEviLcKP1wVXZ/B9LeE0frA6F8gOxb7fNdgXJe8w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 06:33:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 06:33:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "kbusch@kernel.org"
	<kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"upstream+nvme@sigma-star.at" <upstream+nvme@sigma-star.at>
Subject: Re: [PATCH] nvmet: Fix out-of-bounds access in nvmet_enable_port
Thread-Topic: [PATCH] nvmet: Fix out-of-bounds access in nvmet_enable_port
Thread-Index: AQHbsDhUz2zYrsrYn0CXQ9zRRn5j4LOvQHsA
Date: Tue, 22 Apr 2025 06:33:30 +0000
Message-ID: <3e38cbd2-c785-4720-8f90-71849f548f4c@nvidia.com>
References: <20250418080250.2736590-1-richard@nod.at>
In-Reply-To: <20250418080250.2736590-1-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6473:EE_
x-ms-office365-filtering-correlation-id: 2dd63ee1-591f-474e-5515-08dd8167990c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFJkUnROYnQwTnpGSytUakZ4UE5hOFNKSGU3dVlZbVlvTkFOTGI2aHM2VjZI?=
 =?utf-8?B?cXRya3JyOTNwMmdiWWtCQVpQNDJlNzlvZDV0azY3K2pJNWRNYTdiNDVhVlNz?=
 =?utf-8?B?TjE5a1k3RWpqcHVQd1lUbDRRdUFKRTBFL0xpOEtjSEdyOW92dUhGR3QreElr?=
 =?utf-8?B?bThtV1BKVGsxWFMyQ0hmeFlkQng1QUMyQTFDMytjNVJKQmROeXFmNnpuVHli?=
 =?utf-8?B?d2g0VmxNb3lOMDZoYk9Ob2kwNDZnaFk1YmJnRXJuMG5IdW9iSktibFNvRHN2?=
 =?utf-8?B?V0F4dmZWbTR2WjRScE80RmU4ckcwU1NISFdnRW1GWEM3Y3AvSkQ3NUJ1bmtr?=
 =?utf-8?B?S3NvQlNuVTFEak50SElGZ0dqR3hHTnFocHVpaGU1SWIydTlJV1ZwVkpWZXNp?=
 =?utf-8?B?TkgrMStlYXFLSmRDUm9oL1EwZWV4ak1hVko0ajdmWkxUTHAySnoxa3d0Ymdi?=
 =?utf-8?B?M3lLbFc5NTJvVVNCZnBPVmtOWDhIck5Ob2NnL2UxQjBIU2hnVjJKZVpUelJu?=
 =?utf-8?B?OFhvdlNpRWE4bGsxM1p4TFdvbWFUQ242RzZCWmxsb2R0QWdqR1NqSGZOQ24v?=
 =?utf-8?B?SmtZc2htZ2ZRV1o3Y2RVeUpMVVplaWw0LzVjczB3R084WlJzdDNuckVPWjhH?=
 =?utf-8?B?dHhYdU0rY21TRU5DTUtFanBGd3RnakNFQkhyQ1Irc0JwUThmMDdpRE5aRllh?=
 =?utf-8?B?d0JNR1FwTTVCamY4MnRlOUxHTVl1TngyakZhTUhZUHJaemNzNlRIaGI5TXY1?=
 =?utf-8?B?d1FEK3dVOTdhRnJZOWEyZUt1aGZGcWZMZTVqRVpFUW1NanQ3RWVEOXl3RUZ6?=
 =?utf-8?B?SUNGcVRITnFwUEtVeDZobElMUVdweXFNSHZrZGs3dlFTQkpzNWx4cWZmWjY5?=
 =?utf-8?B?R1ZBVjVRN1BBNDQ2WTZnV3MrTE5Tb2RqRWJ3ZG5DMEVCNm4rSmtUSmVJNmlX?=
 =?utf-8?B?THU2WXM5RDN5N1h1dlc4MFA3Z3V4ekNxaHAyRmRuNlBoQjlEODFYdmJxNitt?=
 =?utf-8?B?NFZ3Q3JUTFZTSUZ2MDJNNFpOdkRPd1RYMjdjTnJzdmNzc3p5eUJIZ2M4VGdk?=
 =?utf-8?B?VldtUEhhR0RZNDlzTit6cy9wbWxNNUF3TmZIWC9FSlU2UnpoYkhaNTNKdkNm?=
 =?utf-8?B?ZnhXZ0lWcFBRcmVCRHVFYVoxbGlqa0l5R2lVT3BRV280M091SWlkMkR5Rkov?=
 =?utf-8?B?QUNjc2RIa3FFemZ3MFFlTVlHbWU4dFlZenE5Vm9NMnMxdEJKRWc5MHlnU1dl?=
 =?utf-8?B?RXJNSWYwcGNPMlRydzNrVmFmM2gxd1h6ZTZaZGVCamUyUVpueEs2U2RSMmtU?=
 =?utf-8?B?dkhRYTZzalhMbjBjaG4wVEs2elh1elYyMkdXeGVoaWZCWmV6WmpxWWxMZmdx?=
 =?utf-8?B?eTNKVEg0ajkrUUdSRDdFRnVLT1FraThsUlZVWWFnV2F4R0FETDdjRWIvNU9h?=
 =?utf-8?B?cFh3dnJtSEt4MEtjcFByVjI3N0xBaHNvdGNPQ0VqQVZlUHZVV0YrNWgxNEhs?=
 =?utf-8?B?SE90UEduT0RCdUtXSGxPR2duclBVbnlDQlZWa21UT0tENjJ2K3k4NWVRdFlp?=
 =?utf-8?B?cjNaTFV3QmhqSzZYNFdJclhIaDZlc2RNOWMvdS9weVRjWm1abjM2d1FPSlY1?=
 =?utf-8?B?Q2Z2cEFrM2RRMGg5cCtwV3F2b05rZXJGVEh6ZzA3YWY1alNHck4yWVQzZWRD?=
 =?utf-8?B?ekxnT2dyOFNyVlFUcnBsVFRTb2svQlY3bWZ3SEQwK0Z5c0JaNUM4aDNncXlk?=
 =?utf-8?B?QmVKTzNDZDRiUkhVRWcyOUZBNlAyQWJnWXpHcFhvVHp2b3ZZaFFDMmgyV21C?=
 =?utf-8?B?UnVVNnBSb3pMbkdBNFVHWWx6NzBQdDRBUkphejNadG1kUXhLTmFSUDJMZVRl?=
 =?utf-8?B?UW5ocEpobndaSmlBTmwwa2NyWUNGQUdaMTVFdXlkcUpQUkFQNU8wWm8xeEJU?=
 =?utf-8?B?bnFuZUduc3ZqcTdRcWZaOWtsNWs2c01mU2c5a3BNcCtHN3RlNlFBYkQ5WE5P?=
 =?utf-8?Q?XybY9Vc1F6stAFi3BThpfIj/egYbXE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2RtVE51clZhUlMyZEt4QWxMSVhTVzF2OGRrOUZORC9qK3Q0WVlzMmtjVndD?=
 =?utf-8?B?MEZBTWllMzZmcWNtSDI0ODZ3ZzNVTlBUZkhtclFVNk1mdExlK1ptRHBtTWsz?=
 =?utf-8?B?WDZzYmlueGx2SnRVS0NPVjQ2bHFMaVBTOXVNR1NiTmNwSXpVaEhkTDF2RW55?=
 =?utf-8?B?Zll1Z0pmanBsdmxRU1p0SXp0OHdQWW5YR21WSkUycDVlUWFlaTJJNGo4Y2E1?=
 =?utf-8?B?LzBWMHpHRGVHZFN0b1NlQmJWSEEwRFUwbk9Da04yWi9JQmV4OVQvclRsQmc1?=
 =?utf-8?B?bXc3eU9xQ24xbm1Lc3ZWQStJNjQxMS93QjRMREhJL2dNdnc4Y3d3TmFNR09o?=
 =?utf-8?B?NlEva0VlSWpGREdlS1lVYXlVUThOMXB2R1dacGdHTFRtd0JrNEtaZmRlVy9Y?=
 =?utf-8?B?bmdscEc3UGdyc3FJdUtGWlduMTBsZGNMbDRaUFVKdUR5clNzd0xVejFWUUNE?=
 =?utf-8?B?K0Q0OGgzVlVIUDZxWk1Ea0dlNjJkcUhEL3dmL1RDUTVZQmY1UW1UdVZxU1ZE?=
 =?utf-8?B?THpta2hNbEI5VFdOalNxTGl1SWVZeTZoY1AxM2NXLzRyTjJQd1o1QjB2NXV2?=
 =?utf-8?B?anhRRTYrWHZOdUFNWGRIZWM4aEdyTWdzMWxhWGpSd2dpK2F4bEhtUE8yUWxQ?=
 =?utf-8?B?ZVNTY0VtRUF3b1JpREZBaW0zTkNBaGt2SWprT1JxQmNPWFVxWXcyN2hzS01x?=
 =?utf-8?B?RFRLbnhNdmF4UmRqYjlPOXBHcWdaNnkraGpkN0U2QnVPVlZ6aEhqb2g1eWVQ?=
 =?utf-8?B?cHhYbVJvY28rU1pDK3FMc3kvdzJxRlVUQ3Nkb0Z4MFB1bXJOcmJtYWVTNmxS?=
 =?utf-8?B?ZVB1ajk2K3d1djhxclJUTVk5NXlQMkk3MSs5VmtMWUNkY1lNbkZSQkJFaUZ2?=
 =?utf-8?B?M2M1UXVGa0FnMTYzSDlvVE5YVzNMZkRybWx1OUY0NXpEd3NOc20yVFZOK3NY?=
 =?utf-8?B?NEhOTkVudFpQNTl2N2lnYStxOGIwZTRRM2JVaHpsZ2FwditjenpneE5LRE1i?=
 =?utf-8?B?eEFCVkR6Vi9IaURVcVlRSkJzd2VFVjFlSmlKRjArTWNKeDlnbUdrQ0lvM3I2?=
 =?utf-8?B?TU9VMHIxcEs1bEZpK0toTm1PaHlNd1FITDFwREZINTFGMXo1V2U0dGZYRndp?=
 =?utf-8?B?SktWVnBQcy85TGtyUWg4QUtMaEJmRnIzekxRdFNydzJ3Qk5IRHA0N3ZocEhr?=
 =?utf-8?B?OWt3TE1Ld1BCMFY4TCtzam5WdC90UE5Kb011ampWOE40QzJ2cVgwZEI5a3VB?=
 =?utf-8?B?VXN5ZmZDSDZrMHNKZlZjWXQ2L2V2aGZNZ1pBVC9Td3pPcitKZm1QVTAxS0VK?=
 =?utf-8?B?MlVXR1JGbFNNaDZGN1E3Qm91S0gzQStZVEozTVF0MzRmRXVpNVdZV2pEK09Z?=
 =?utf-8?B?eWt3NkNhN0VhTVRQVGx1TjZXcktqOHpOYzdJZldOUWdSSi9QK2JXSmRMd3pN?=
 =?utf-8?B?eGYrUzNpUU5CMWxIOXJWc2xEVWgyNDQ4WlhRMFdhR1h1bW9nYkQ5VXI1VHRB?=
 =?utf-8?B?SmVXOVhaNWZPK0x4R2EwYWExL3NiNkpUWmM4cFcvWkdZc0N4dUZKV3pZSmhI?=
 =?utf-8?B?SWFQQ0xZS2tTRmtRak5mQ2ZRTkpUZk83ejFFOENTWUhPUXpQVkE4Z1c4b2Na?=
 =?utf-8?B?UnJUb1FFUkdxanpLSGpLVGZpYkwvTzRkejUzYnNnUDZ5RU1CMEV1WjRpZlFH?=
 =?utf-8?B?ZXgxc3JXeGxQT0VUZUl0RFpnWnRZR0Z6bVY0amFFNFRvQ3gweXdVZHdiaG5B?=
 =?utf-8?B?TjVBZ1JCNG00K1VtR0QvbUZXMDFaNVVnZUQ1WXRkRlJ6WUxKZG51NEZCdGxS?=
 =?utf-8?B?d3R1K0dtZDFncWJiSzlwRjNrb3hpdGVxZU1SMVMrdzlNUVgwd1ZRLzQ0YnZL?=
 =?utf-8?B?aklqMzZkWUhwekZJNzFrTFQwL2s0SWkzN2cvZWx6aklkNE9BVVNEd1ZnaEdX?=
 =?utf-8?B?UUd4REZZbm41V0tnMmNsd0swZ2pkSkRSMElkZkw0Qk1zbmFFYW4zV2tmak5m?=
 =?utf-8?B?R2UrbmJOUzMzWmM5UndldGRIdFpzTHNteDVYbW1hcmF3ZGpjWGVrNUU2aE1t?=
 =?utf-8?B?OG1sRlI2M2JVTVR0dndLbys3ZTJvZmlJNUpaV1JvUERKRlRHNTdHNXB3YlFV?=
 =?utf-8?B?bzFGam5mSEFpQjlaTXhlSklkNUVxS3FKanZxdHhEV1gxSVNHcUpwbUVPMTBr?=
 =?utf-8?Q?isgGagQ65odq4yQeDikg1PBAXQGS8RsO3wTENF8U9tKU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ACCEE799CE25F42A2B65334FACBC9D5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd63ee1-591f-474e-5515-08dd8167990c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:33:30.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nyg6w65Hhb6+3V/Nl5xEEIQsebstsvk+2jlqRJSmj60246fZLQNfEZBAERk5lsD9FiRp5Hw3yVYS50sQCTmbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473

T24gNC8xOC8yNSAwMTowMiwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOg0KPiBXaGVuIHRyeWlu
ZyB0byBlbmFibGUgYSBwb3J0IHRoYXQgaGFzIG5vIHRyYW5zcG9ydCBjb25maWd1cmVkIHlldCwN
Cj4gbnZtZXRfZW5hYmxlX3BvcnQoKSB1c2VzIE5WTUZfVFJUWVBFX01BWCAoMjU1KSB0byBxdWVy
eSB0aGUgdHJhbnNwb3J0cw0KPiBhcnJheSwgY2F1c2luZyBhbiBvdXQtb2YtYm91bmRzIGFjY2Vz
czoNCj4NCj4gWyAgMTA2LjA1ODY5NF0gQlVHOiBLQVNBTjogZ2xvYmFsLW91dC1vZi1ib3VuZHMg
aW4gbnZtZXRfZW5hYmxlX3BvcnQrMHg0Mi8weDFkYQ0KPiBbICAxMDYuMDU4NzE5XSBSZWFkIG9m
IHNpemUgOCBhdCBhZGRyIGZmZmZmZmZmODlkYWZhNTggYnkgdGFzayBsbi82MzINCj4gWy4uLl0N
Cj4gWyAgMTA2LjA3NjAyNl0gbnZtZXQ6IHRyYW5zcG9ydCB0eXBlIDI1NSBub3Qgc3VwcG9ydGVk
DQo+DQo+IFNpbmNlIGNvbW1pdCAyMDBhZGFjNzU4ODgsIE5WTUZfVFJUWVBFX01BWCBpcyB0aGUg
ZGVmYXVsdCBzdGF0ZSBhcyBjb25maWd1cmVkIGJ5DQo+IG52bWV0X3BvcnRzX21ha2UoKS4NCj4g
QXZvaWQgdGhpcyBieSBjaGVja2luZyBmb3IgTlZNRl9UUlRZUEVfTUFYIGJlZm9yZSBwcm9jZWVk
aW5nLg0KPg0KPiBGaXhlczogMjAwYWRhYzc1ODg4ICgibnZtZTogQWRkIFBDSSB0cmFuc3BvcnQg
dHlwZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgV2VpbmJlcmdlcjxyaWNoYXJkQG5vZC5h
dD4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

