Return-Path: <linux-kernel+bounces-750452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B9BB15B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E3418A848A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008FD293C4F;
	Wed, 30 Jul 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="APiVJV1/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5002273817
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867352; cv=fail; b=nBhPkIQw9+PA55NPpfZdlL0fBGKQukWyop0klEN7woz4BeeHImJPTSKUVsMLFyZA+eTqH6kD7hEHnPGIGEeaTkJePhE2prGI4yxrUJfh9jug0hjwjber1T6qb3jENrxPBn+d1Pha/fVm0SNXvK3Qk5T0DLmKTfEoswQf+Qqq1Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867352; c=relaxed/simple;
	bh=wj+c+egCYGYsT3HQQqXyL1/55Winph0nXpVgElB66PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ce0Gcw8OWwhpHgK8ciU+Tu04bXQT8xSAabJRSKQxyR3jY+fTjdPw1Xr/M9ew3EQg9dRhNpr0w36rWN43Ty8w/s0ORgHQCLV1b9qKdjVgx9FM476QKdLCjlRsOoDyoSW+5qFNWUO9zCE30wgvmmTH5DOdyWF0FCIoJ5tPSAdf7z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=APiVJV1/; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7x4HXOv8/rwlXvlY5DHHbW5/I2nzti2ohxrKT9E6wHXVYI5gNXz4PDIlsaCt87AENH0g28mObtXfdvtIHWRGCn6WpJttkEZ8Ch/Z62PxEzeznTIQyvt78ogZZiy3SfIYZhNJcYuUqcwQa8RRXCbrDE+XvPNIV5/aiJ1Ob4/BcJlEHGJPtBmhlm7yVg0uZvCLoUcPEEJQSHU7OKSN+RsFFBqOJ/T2oHADWX19kHw7G8NE1MraAPC02ISHgfTlOgn+6z+oaXBMarqNKP3AQA+HovM4PFrBjy64PTGgWPR2i7nsuDDmoGQt3yaB75AT76h3Z1+5dY/dSALVAZp/h+Ghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vasyXUx116EVoEwcaphE2DecglR30rqrYHmK7QUdBA=;
 b=qAeGYT6PO3h6tHRc91QcZLmiBFJorsDi6TZWUQnIRNn06IGDl5pH2ZGR8iTCDzF6w/NlfNhRkn77WV4ZtOEkN2o+tblpqGSneYyM5PyWJdn2lllPHOgfyB3GP7mRfr+4crblOcUGsD0y5bu7Zzb9sWCxuOHjekZm8Z7uWjWxjtq5gTLY9zzcCvmrW5C0WIeJtetdCk2c9cIt4P794JW4ru9/YRP7lWknHf9VFTJW9KFyn+KXyfivuoeWgLPDi2avLZZ5jo9tq4ibVqF/jT+nou2O/KAVUcZfUJyweSFO14uyWqgYTbDVv3LSN387tODoCA/w+fiIbjeP9++MlJ8KWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vasyXUx116EVoEwcaphE2DecglR30rqrYHmK7QUdBA=;
 b=APiVJV1/BNs08jK2aVB/FDtuPAkvCqYBvP7izjptr82kTt65PjhqtBCNlSoDGC1U9EpE+LbINDsk9cFSiVjloc1pn+x0XcKJzQLLgqd+GX+jcjneJ2Q2K08CRSXS0NuhvbG/6S64InqjIWPKTR9syXAxXDDLW1e4wCi9E7+lPPhYJ2OZjBkCTWQqZi11ypdHYIFt8AVw6x12heecOIZjWdjy5Gb3ps/oC68ZLSgmN83dPlIW53J3Wk3wowA2X2b5G43nrJUDV/OAPThdzzIVCZifDTCBtkuJZQLnL8HzurQFVtoygfiNNNHlQSXZkDX7KCJa2lJIp/hot7Mnlsl9dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:22:28 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 09:22:28 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: [v2 11/11] selftests/mm/hmm-tests: new throughput tests including THP
Date: Wed, 30 Jul 2025 19:21:39 +1000
Message-ID: <20250730092139.3890844-12-balbirs@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730092139.3890844-1-balbirs@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ddfa92-0988-4e40-c3d9-08ddcf4a99d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHdTL1lDS0V5NW5yZ0x5QXJwOXp3WGVSbElieWtQQUwza3hrdnkzTXB1UGhL?=
 =?utf-8?B?V1NiYTB5Z29yUnB5UDhxS09xeFV0ZElEUm55NElOVUozRGRaS1NuK2ZoWGZV?=
 =?utf-8?B?VjVHQ1BucG5XTDZoZXRnM2lRS0I5bVZNalBHNTVtcHl0SFIxcVRSRjNwUTM0?=
 =?utf-8?B?d0lNQ1lFaXdER3N2aTlXUXJ2QURUditCSkNuTjIvZjMyVENzbzc2RGE4ZDVO?=
 =?utf-8?B?ZnRxRWdrVlE2Z0hNV3ZOVTJOeFJuaVh5TGY5dm9UVU5zcXgwczUza1pua2N0?=
 =?utf-8?B?bzhnN2ExZjVpeUk0RXdZcktiZFFObitWR0oyb2lYb0F1RUIvVDRwK1BhcUdx?=
 =?utf-8?B?b1U4RnpYaitZTitPZTlUVGx3STROUkdFekxGY2R0RXI5aG5MWXZhOWozakgv?=
 =?utf-8?B?akViTEZhNHVnRTA4d2NvenlxUWJwSHZyK2ExM0w3MkVmOUxhSDQ2SDRmOW9U?=
 =?utf-8?B?QXpKbmtYdVN0NzFybFM3dUtxRGdYcjdueWFzQWNURGNEQTNoYm40MXRwQStH?=
 =?utf-8?B?cDUwRUNQa0ZTR1podzllZ1Q0bGh1WG1oTExBd2tDMTB6VEJTOWNMVzVPTjQ3?=
 =?utf-8?B?a1p3UnlLcERveHRlamlqenlBVm1iYWRjbEdYQnRWOGx2M3ByRGxjazdTSHhr?=
 =?utf-8?B?eEJBWDdpTEVjUTIzZWJXaTV0YmQ5UlNuTHpKcHZXWm5IcGlPWm9zSXhJRE1u?=
 =?utf-8?B?bXZkSWhFYXEwYmRiUm5LdG14SWx6Y05GTFdWQjNNR1lEVFVRYnRtckxEb2sw?=
 =?utf-8?B?RGgwM0lsSjNGeDVCZ29lYmdxTnRMY2RGK0pJb2k0bnNGbWxJekNNN3JTRVc0?=
 =?utf-8?B?U3VXU3N2NjdoeXhiKy84QXUrNnAxSjdDZUM0UTY2S2J4Zk9hcE9FQkh5dEow?=
 =?utf-8?B?WkcxeFpjbGFPWU9BRXZtVTZjRnh5SDdzQmZuNk1CUVVVR0xUcWdaTzBDazk5?=
 =?utf-8?B?OXRCQUxQdHpzVTZDVVhSQXpzQ083MlV6b0NNR1ZyV1B0dG00SVFOdjdnU1F4?=
 =?utf-8?B?QWd6UHUxZUNjTzI1S3B3OWdKZkpJTEZZLzBjMmw3SUs5Tk5adFYvMys3TU10?=
 =?utf-8?B?RDdES1hSL0hUNTlKaktxMVVGY1lWVWd0TDNWSk92d0ZQRk5abnAzUWpGbEt4?=
 =?utf-8?B?aFJRSHRldTFOM1A5NUNDM0ZHaXBqaGdTVlREMHZ5eVRvb0hkUGVMSnJmM255?=
 =?utf-8?B?MHdHMk9WaEY5TytOVnZuYW9NeElIS1M1NndoWEd5Nzd6NjVqSnZ1THoybnNx?=
 =?utf-8?B?NGtRN0dOd09pVVl0UlE1Q1I2eGFXelI0NFd4SExaQTkrSGJ6S0VIeWptVXdr?=
 =?utf-8?B?REZ6dnpNSGU1c0lqSUZWWUVDV21mL0hFbjJVY2lsb2djdjU5bVRNaldmb3Jn?=
 =?utf-8?B?bkZvMjQ3QUNZRnRCcVpESW1mWmJTbmhKcUtsSlFtVlZhWDl1UDJ5eDgrNmdO?=
 =?utf-8?B?RFJsT0wwczNiV1M0QUE1ZERnOVVCNGFRalNQb3V1ZnRHcWdRY05IbUV3cjh5?=
 =?utf-8?B?WnNac25YZGQ2eWEzcUNNalYvZjlIWktqSi9VYU9Oa1pyNkJsUTVmUmYxd1V2?=
 =?utf-8?B?dldnMzNHRzdSblhvOHc0VlF4THIyNkdUdi9WenhlNUZkaHJEL3dHbGpNdnBE?=
 =?utf-8?B?L09EWjlnQldsdjFkMjlvVmlQamZXT0xSRGQ1R3BUNmtnbHRHY3NnMFZ2WlMx?=
 =?utf-8?B?UmhCYkZzZ0VNUzFKYkpXbDk1SThMajJkSmVZUFBENTdoT0M3NXNHL3hXUFBt?=
 =?utf-8?B?L1FkQ3Q1TSt6alg1NDJ1K25MbGsyZ0hVcUlxS2pyWUFJOEYzZWlYUDJLd21M?=
 =?utf-8?B?QkhJR0FoQjU5VnZ2ZXZTd0FwNGlQeHJXNm9zMHhEc3FubkJKYTU0UmFROHZV?=
 =?utf-8?B?c1k0aDRPQUYrcnM1aGFJdk5kUVRqOEY2OEFsZm43bW82VFVMQ3MyVElJV2dT?=
 =?utf-8?Q?qIMe9PAJITk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjRuNHNjRkFNNmZoc1ZibU81ODRHWEtrdzZPeWx2OGNibWI1dzQ1VS9NcnZ4?=
 =?utf-8?B?aStOMjFscGZiNW0zTGFqbFRXaGJoVG9Zbit0b2R3M2pONFhzU29zUGFIai80?=
 =?utf-8?B?TEt5QU1qaGcvK3Q1YUtrTTRCR2lmaGNIOFNuQVBpaWEwU25Pc1JJNzkwYVZr?=
 =?utf-8?B?eDR1OEYzZGh3Z1BTcURVaDZvaVRpL0owTCtMT1crNVpTaHYzMTl4ZUpkTVhi?=
 =?utf-8?B?S01UeCtHYm9namFvMnZqeVpKcnBBQURXait6MDZQdGt0REVvY0NVdWo5WWVO?=
 =?utf-8?B?dWhZNWloSDdvem15TGZzMS9pV0lLak8zUkdseCtDUXZwUHVZbW9sRXBiYXFK?=
 =?utf-8?B?WDdteVIrUjNMWnpqZGg4OXJYVi90OHJWMm51M3pCcTd5ejEzdXRRekwrclZ6?=
 =?utf-8?B?MFA1dVJISElxOE8vaXZlb1lMZERmQ0tGaFE1MktlRWdNV0VYZjBuOVVWZG1h?=
 =?utf-8?B?VXI3Y2diaWdxRkJaWXR6emhqN0VqenpkUXB3QnRFamF4NG8rV3RES0lDVWtq?=
 =?utf-8?B?R2lFdjZodHI1TFBmbnJjdWFKMCtpcDJGSFM0bzhVZzhVWVJMeUE1Y1ZyZzZn?=
 =?utf-8?B?UXFZVHpIRDFvcUtIcTVDN1F0a0tINXVpMUoraFdKVk1JRXliTGRldnpEM1pN?=
 =?utf-8?B?bHdYd1dqNkdIUE9OazJkMFEyaGt2RzV4Y0U4aEkzSVVvZ2E3MkdDZ29SWWRt?=
 =?utf-8?B?L2dXQnVFNEljSTdXanRFRGVUaUQzVHgvcER0bWZtOTQ3WjIrbFYyTklNYlpF?=
 =?utf-8?B?dDJBYjZxNE5zamtUdDJmM09ZcVpyZTNMZ1BIV05QVENYWGVWQzIwUVEzYVRy?=
 =?utf-8?B?bTZ1bXllSFBJbm1zaERxNjEwQUlZU2hsMG1oTXFIQXVqeENCalRNTnFpWkdh?=
 =?utf-8?B?Y3poSGNEMmRqSUxXcWt1L3pzVi9oRzZDSHJIR2l0R2ZpSEpNVSthcFlZNndv?=
 =?utf-8?B?c1ZUS2RHK3BHeDdRQlFCRTk0SDdYQ0szYU4xZ0F3Q2FCbzdoRzJ5Yzd0SXNX?=
 =?utf-8?B?NGVKWk1ZL2pubVRlWXVsRlhTTyt4VHlTNk9pZm1lWlRlMlJCaWw0YjVhcDE2?=
 =?utf-8?B?cDhZUnN3RDNySDFoNzIrQjBneEtuSHo3RnF1VzdCZndFd2hTbmN4Y1Jvc1VL?=
 =?utf-8?B?aG5CMGNBRld5SnVmMU00S1JlZWZLczc5QlVkSmFZSkl6ZVluUmVGd21wcSsr?=
 =?utf-8?B?RVQrQ2ZwcUU2MUI2Z2dMZTUrcGRWWnQvRjFObkR0VGxaOWFUK1g5d0NydzdL?=
 =?utf-8?B?eTlvU0VBbzVLR0RrajlTUmtvcGJTTDd3QzlZWmFNZ2dwTndmWmtFaExoNXcv?=
 =?utf-8?B?MnJVV05lUnVIa0MweDlVaTFTUFQvZVJPN3FPQk0vbzFXaStZSHlUS2dNakpv?=
 =?utf-8?B?ek5qZGJXQk81enpucThSaHY4WXcxZE5tTm1OeWN4b0s3TzJnV1dhbWs1U1V5?=
 =?utf-8?B?Z3JEVjFORUZYbGhHc2xxRVMzSTgxVDArT0ZTMDZ6OGlIelJ5bU9iQWdhWHNX?=
 =?utf-8?B?M2JiUVkxRmNZdFVlRmZVcjJqZjhsS282ZUFVV2l3ZGViTnJ5endrOHA5bG5q?=
 =?utf-8?B?b1VtekxQbVhkSkZZSlVMZ01Db2o4aGgxM0pRbFVHdy85ZmdndE1GSEJsMjYz?=
 =?utf-8?B?ektFT3FuOGNaclo4Y1hxUDJobGV2OHNkR0ZTYlI1N0haQ0tWNjBYR2lHVVRj?=
 =?utf-8?B?cnVvOXFiRUswNWY3SXBHdmN1Y3BtOEVCNVpNeWRhZUxrY3hkZ1owcVhJZmpW?=
 =?utf-8?B?S3Vqa1B6bE94VktaSThubEp2bWpMUlpEbEJ3dTN4NUVPbm5VU3l4aUFldERm?=
 =?utf-8?B?RnIyVkZNelVkTTZLZHA5cFRMZUwzTWt3d2dqU3JHc3hOdXN3TmN4eWVLb1hC?=
 =?utf-8?B?L0FpTlRXMXUzQ3BzeVB6cTlEL0JNRm53WndWcHMydjdvckZ5Sy95bUdCWjcz?=
 =?utf-8?B?WExVSGRXUW9TUU1UWDdpemlOaUlJUHd1TWVPNitURnJGcm1kUnBkQml3blFF?=
 =?utf-8?B?NHNQckRpRVNGTjBGOVRkMWpRUDZScmxyYU9oNWdMcEhKT1RDbStRa2xTUjE3?=
 =?utf-8?B?Vm5XV3cxNWl3ckRGUXhsajg2NFZhWmJmMWc3WkpyVzZoNzZGWWZTMUVqUlVh?=
 =?utf-8?Q?rrwnsdiI/ebmpYoxK/V1k8/ZN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ddfa92-0988-4e40-c3d9-08ddcf4a99d6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:22:27.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4i6YDJke0b4lS8eTmuXIO4Cy9XzyDv4NK4yZnDO7MlxtjIlNj69lfd6qRTZvG54xTXwLBm7Z7E/370JtlOxYSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

Add new benchmark style support to test transfer bandwidth for
zone device memory operations.

Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
 tools/testing/selftests/mm/hmm-tests.c | 197 ++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index da3322a1282c..1325de70f44f 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -25,6 +25,7 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
+#include <sys/time.h>
 
 
 /*
@@ -207,8 +208,10 @@ static void hmm_buffer_free(struct hmm_buffer *buffer)
 	if (buffer == NULL)
 		return;
 
-	if (buffer->ptr)
+	if (buffer->ptr) {
 		munmap(buffer->ptr, buffer->size);
+		buffer->ptr = NULL;
+	}
 	free(buffer->mirror);
 	free(buffer);
 }
@@ -2466,4 +2469,196 @@ TEST_F(hmm, migrate_anon_huge_zero_err)
 	buffer->ptr = old_ptr;
 	hmm_buffer_free(buffer);
 }
+
+struct benchmark_results {
+	double sys_to_dev_time;
+	double dev_to_sys_time;
+	double throughput_s2d;
+	double throughput_d2s;
+};
+
+static double get_time_ms(void)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	return (tv.tv_sec * 1000.0) + (tv.tv_usec / 1000.0);
+}
+
+static inline struct hmm_buffer *hmm_buffer_alloc(unsigned long size)
+{
+	struct hmm_buffer *buffer;
+
+	buffer = malloc(sizeof(*buffer));
+
+	buffer->fd = -1;
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	memset(buffer->mirror, 0xFF, size);
+	return buffer;
+}
+
+static void print_benchmark_results(const char *test_name, size_t buffer_size,
+				     struct benchmark_results *thp,
+				     struct benchmark_results *regular)
+{
+	double s2d_improvement = ((regular->sys_to_dev_time - thp->sys_to_dev_time) /
+				 regular->sys_to_dev_time) * 100.0;
+	double d2s_improvement = ((regular->dev_to_sys_time - thp->dev_to_sys_time) /
+				 regular->dev_to_sys_time) * 100.0;
+	double throughput_s2d_improvement = ((thp->throughput_s2d - regular->throughput_s2d) /
+					    regular->throughput_s2d) * 100.0;
+	double throughput_d2s_improvement = ((thp->throughput_d2s - regular->throughput_d2s) /
+					    regular->throughput_d2s) * 100.0;
+
+	printf("\n=== %s (%.1f MB) ===\n", test_name, buffer_size / (1024.0 * 1024.0));
+	printf("                     | With THP        | Without THP     | Improvement\n");
+	printf("---------------------------------------------------------------------\n");
+	printf("Sys->Dev Migration   | %.3f ms        | %.3f ms        | %.1f%%\n",
+	       thp->sys_to_dev_time, regular->sys_to_dev_time, s2d_improvement);
+	printf("Dev->Sys Migration   | %.3f ms        | %.3f ms        | %.1f%%\n",
+	       thp->dev_to_sys_time, regular->dev_to_sys_time, d2s_improvement);
+	printf("S->D Throughput      | %.2f GB/s      | %.2f GB/s      | %.1f%%\n",
+	       thp->throughput_s2d, regular->throughput_s2d, throughput_s2d_improvement);
+	printf("D->S Throughput      | %.2f GB/s      | %.2f GB/s      | %.1f%%\n",
+	       thp->throughput_d2s, regular->throughput_d2s, throughput_d2s_improvement);
+}
+
+/*
+ * Run a single migration benchmark
+ * fd: file descriptor for hmm device
+ * use_thp: whether to use THP
+ * buffer_size: size of buffer to allocate
+ * iterations: number of iterations
+ * results: where to store results
+ */
+static inline int run_migration_benchmark(int fd, int use_thp, size_t buffer_size,
+					   int iterations, struct benchmark_results *results)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages = buffer_size / sysconf(_SC_PAGESIZE);
+	double start, end;
+	double s2d_total = 0, d2s_total = 0;
+	int ret, i;
+	int *ptr;
+
+	buffer = hmm_buffer_alloc(buffer_size);
+
+	/* Map memory */
+	buffer->ptr = mmap(NULL, buffer_size, PROT_READ | PROT_WRITE,
+			  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (!buffer->ptr)
+		return -1;
+
+	/* Apply THP hint if requested */
+	if (use_thp)
+		ret = madvise(buffer->ptr, buffer_size, MADV_HUGEPAGE);
+	else
+		ret = madvise(buffer->ptr, buffer_size, MADV_NOHUGEPAGE);
+
+	if (ret)
+		return ret;
+
+	/* Initialize memory to make sure pages are allocated */
+	ptr = (int *)buffer->ptr;
+	for (i = 0; i < buffer_size / sizeof(int); i++)
+		ptr[i] = i & 0xFF;
+
+	/* Warmup iteration */
+	ret = hmm_migrate_sys_to_dev(fd, buffer, npages);
+	if (ret)
+		return ret;
+
+	ret = hmm_migrate_dev_to_sys(fd, buffer, npages);
+	if (ret)
+		return ret;
+
+	/* Benchmark iterations */
+	for (i = 0; i < iterations; i++) {
+		/* System to device migration */
+		start = get_time_ms();
+
+		ret = hmm_migrate_sys_to_dev(fd, buffer, npages);
+		if (ret)
+			return ret;
+
+		end = get_time_ms();
+		s2d_total += (end - start);
+
+		/* Device to system migration */
+		start = get_time_ms();
+
+		ret = hmm_migrate_dev_to_sys(fd, buffer, npages);
+		if (ret)
+			return ret;
+
+		end = get_time_ms();
+		d2s_total += (end - start);
+	}
+
+	/* Calculate average times and throughput */
+	results->sys_to_dev_time = s2d_total / iterations;
+	results->dev_to_sys_time = d2s_total / iterations;
+	results->throughput_s2d = (buffer_size / (1024.0 * 1024.0 * 1024.0)) /
+				 (results->sys_to_dev_time / 1000.0);
+	results->throughput_d2s = (buffer_size / (1024.0 * 1024.0 * 1024.0)) /
+				 (results->dev_to_sys_time / 1000.0);
+
+	/* Cleanup */
+	hmm_buffer_free(buffer);
+	return 0;
+}
+
+/*
+ * Benchmark THP migration with different buffer sizes
+ */
+TEST_F_TIMEOUT(hmm, benchmark_thp_migration, 120)
+{
+	struct benchmark_results thp_results, regular_results;
+	size_t thp_size = 2 * 1024 * 1024; /* 2MB - typical THP size */
+	int iterations = 5;
+
+	printf("\nHMM THP Migration Benchmark\n");
+	printf("---------------------------\n");
+	printf("System page size: %ld bytes\n", sysconf(_SC_PAGESIZE));
+
+	/* Test different buffer sizes */
+	size_t test_sizes[] = {
+		thp_size / 4,      /* 512KB - smaller than THP */
+		thp_size / 2,      /* 1MB - half THP */
+		thp_size,          /* 2MB - single THP */
+		thp_size * 2,      /* 4MB - two THPs */
+		thp_size * 4,      /* 8MB - four THPs */
+		thp_size * 8,       /* 16MB - eight THPs */
+		thp_size * 128,       /* 256MB - one twenty eight THPs */
+	};
+
+	static const char *const test_names[] = {
+		"Small Buffer (512KB)",
+		"Half THP Size (1MB)",
+		"Single THP Size (2MB)",
+		"Two THP Size (4MB)",
+		"Four THP Size (8MB)",
+		"Eight THP Size (16MB)",
+		"One twenty eight THP Size (256MB)"
+	};
+
+	int num_tests = ARRAY_SIZE(test_sizes);
+
+	/* Run all tests */
+	for (int i = 0; i < num_tests; i++) {
+		/* Test with THP */
+		ASSERT_EQ(run_migration_benchmark(self->fd, 1, test_sizes[i],
+					iterations, &thp_results), 0);
+
+		/* Test without THP */
+		ASSERT_EQ(run_migration_benchmark(self->fd, 0, test_sizes[i],
+					iterations, &regular_results), 0);
+
+		/* Print results */
+		print_benchmark_results(test_names[i], test_sizes[i],
+					&thp_results, &regular_results);
+	}
+}
 TEST_HARNESS_MAIN
-- 
2.50.1


