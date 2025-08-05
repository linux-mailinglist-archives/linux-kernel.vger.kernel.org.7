Return-Path: <linux-kernel+bounces-755900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2DB1AD16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C553B9BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F667212B0C;
	Tue,  5 Aug 2025 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MWDJ5vma"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448C15E8B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754367773; cv=fail; b=JNoQE0zxNrmFPj+kXQyY4UlmtwMjmxsfcY2Ur+MNL1aRrzUqcFkYyxUgkTSldlAiVRfdDqx2yb8tQ8FNylq+vRqqxn/fsU6ax3ootXA/TWQigEF0vIkmqHMCOqi/rjhKqretLdAhdJoz/K7nG/12CtEMytWyH+mUjrsQw0AbVXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754367773; c=relaxed/simple;
	bh=/tcUqSRBj324wB2cQe8LiuRYwgXO6I8dbtiTW+WL3a4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MNfb0M1f8zV8JlE5GOWYlLrSBOxvwbgo9T8mPFRTuYnWSGlwif94+DmZYE7qeUHyvMcgyDnGencQ4ZQViMP77H92UG4qwhgCzzJHyabhu66rGTRQo1r26lNuDvEIF8QZgPoRkFVsNHnnTlXlLTjMIgIS2v47DF+yblgDv02fUxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MWDJ5vma; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjD00zhRQZWsh+kF7+7JIQNeVJBeL3BT34MbJQ8906ZQHDbDrG7KA8ESP02zmaSc4Ryyb2J+NSBhGKAR4pL+zbnF8rQtIX6qd1JkwzuklpXJwNnHw70Q4OqEIwmtU+4z2rxI1T5bNsgZ+q6+Sz4g6b2T2MNNDbd8lwSSqNgQSv6nvNgz3/Xib0Rb/Fr6HvnU8uB3rscbuarnQbvnj3BGZv+k3jNc6uvUVknmnOSJDitnb4aHA+ywQRF7k1c1p8akSZvusv2gIsGcocYGTsTiUfSPWyh4JdoR3DZ8wLq6WAttaPbSl3encDVg76NOXR+3SnbsGLzlHF1cAOhSq/rvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0RYhOidno+U5THQXjL+f3ctjwMhQFlziRMjpdjV0m8=;
 b=zNRxa5CAIn4j1gEIyTPcYPay2gTU0yHeVrDCDGujJcsf7lgBprpklK88dujsVOM9gRJg6F4KXpSXDKDV+H3o+8a864LYYpPbXvsXNY4UrZfme3hQsPvab73NAxGFRr+ci9FpPvKiOsRtGv4ipaVJ/A0oTPUAJ8kYceOwtFmJFEKm81cgl/A8H5CH16JDu+CVOpaLukI0i09acetTaQi8cs+BJ2cXhwxDxTXSOmAty5+HOTjX3pobHsVlVZXOKVdDaZr423NrTogO30sZFLmTa9s2w+WsDdqN1RNHLrCOfBKfzTZ9RNfgzao+Db0Ugx90U/dKOUc0DOYf1pAwiVRV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0RYhOidno+U5THQXjL+f3ctjwMhQFlziRMjpdjV0m8=;
 b=MWDJ5vmakmgfgnPsVseclkcd70dAhIeHjIzFUrN/FKL+le4jkLT/b1OEBvAjQRiSoVM5lMjDYbzmjTAD1SeFj4VpceM6ii+55wVnQIR3kAYkcZXk88onc+s1wsriT2un6lA/862mLZ3LPfwGZcSt7zLwt88kk37xLmlzIKTFYfmlm6aCBjvDajgjvfK4H24wkYiO3v8//zoKGX/mMZBZRmm37RYDsSwgXeI+w3gEUkHoNm1ECVYQ3SkUqLkDPu/f5tTZJef6N31LKUDr/J1NqRyHrKEgXZK0X52LnNp/I2kOQR1ojC3YugLfK2/fjAgOku3rAm0frbm4XwQzA8L2OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CH8PR12MB9791.namprd12.prod.outlook.com (2603:10b6:610:254::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 04:22:47 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 04:22:47 +0000
Message-ID: <1e307223-897c-4db0-9564-95d76bc3d260@nvidia.com>
Date: Tue, 5 Aug 2025 14:22:40 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 01/11] mm/zone_device: support large zone device private
 folios
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Ralph Campbell <rcampbell@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-2-balbirs@nvidia.com>
 <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CH8PR12MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f2e198-3e8b-4d6e-7ab3-08ddd3d7bb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0ZCeVpYTWpPS3dFYVZsVTcya3JPWGoxaTRjMHdQNXFkMFQ4NnJrY1phN0dR?=
 =?utf-8?B?K0pMeWl5RUFhU29EaExLOEJZTEhROEVwUmxjTTNudElKaUN5MnN5cncrc3By?=
 =?utf-8?B?R1B2Um9PNEdEOURCQW9SN0xCck1UWk5HNUtVbnJoUm1OaTZkN3Ric3o0TW0w?=
 =?utf-8?B?aWtZb2FsN2FObS9xd2x6ZkVhMXo5NEp1ZjhGdlgvdEFaR1RKaFgrQXdiRjlG?=
 =?utf-8?B?YlZEWjREcWpMQkVOREVKUlhuWjk5TzVOc1dtR2VseDRnelYrTkJnZ01GUjF2?=
 =?utf-8?B?UTNKOXE0RStmdlkrSjN1S1dKbmk0TzVzT2VaeUIrWGtVQVJQMGovWUZCeFcx?=
 =?utf-8?B?SVhWWjBwVWVTck5MbUF5cTNBRjE3NHBySGJaZXFicHlpYSsyMzJKLzBGWUNr?=
 =?utf-8?B?M2xZMnR4MnNDZHJJb1Z3aThRTmg2QjRyQ25lYytMTVpoV0w1L29oOE5yZldp?=
 =?utf-8?B?MDdiZlNwanlMZ2FLdVFQSGkzUDRFN2pYQVdJTGZCdndlOXptZTB3OVk1RU8r?=
 =?utf-8?B?cHpmcXdHT3Ara1NDbWpLcjVCKzlHWVRUVlYySEFuVlNCRlZrUWQ1dlZQd25s?=
 =?utf-8?B?a0RCcVRpY1N0K0pKSlA4bEJzZTBwazJITWlXZHV3UEQzb2RyU1Z0L3U1empS?=
 =?utf-8?B?V2dSbDY1TWQrM1YxM2UvV01QbGxwWUNkQy9qd2h1MjU2VkV0VE9sRFZmbGVQ?=
 =?utf-8?B?Smk2N21jblFzQnZzcVJMR2s3S0w5NStSNG8xSk4yd2NTZHNFQVkwWG14ZzFh?=
 =?utf-8?B?WlVDZ2FjeVljZVhkMW5pOWFoR0prak1lc2x5K3p0M1orRzUvTG0yVGVUVVhv?=
 =?utf-8?B?c2tOalFJVW1nZE1NVVJmR1dndlc3MEx0eGFUYXdqTjJGa2RDV3BGeGJFWXZy?=
 =?utf-8?B?Tjh2S0dLM0tadkZQRHBRKzVqVjF0OUdzS0xzb1VPTUhuNWJWR3ZCKzI3Y1B0?=
 =?utf-8?B?MnZNanRhdFRBN3BKNnFlcUlqYTJUQ2N5TXBkUU1HbkI2dTVDMWtGcEl2N0Nx?=
 =?utf-8?B?c3JJNjR1aGx3WXU5VGs2WGZsM2FNWUcxb2xGK0lhdit1b1Z1bjdPQlNreEFV?=
 =?utf-8?B?bDRFajZBUEs2ZGIxdmk3cmZuRlZmbm5pdEZMTnRtOXQwTWdFYWhiZU8xWFpa?=
 =?utf-8?B?cFhKaEU1WHl3ZVZ1aDhiTXJYbWNhQ0I3czBxMVRpMjQ2Z0oxdU1LRldrdk9C?=
 =?utf-8?B?MUN5SGhVOXRBMlBGWlNScGwyY0N5K0JNWURNZWl1cG1Db01OWWxNaURhdGtr?=
 =?utf-8?B?TU5rZDlWbE9sT3FKdGcwK1NaRTkrZEFUcU1LZ1ZuYU04ei9YQTh0dklRZjQ3?=
 =?utf-8?B?UjFia3puZVZjV2tWRFNJYnNNY0lmZ24zM0tVT1VFbUU5ZGRrSDA1ME45SzZ5?=
 =?utf-8?B?WTN6SHhaSkt6RktxSE5wOEpJNkFaeEY2cFovYVNoL2NSNWw3RlhiVjZmZ0VV?=
 =?utf-8?B?b2ZEdUhHRGxZL3hrMHdwaEMwTC8zRDBsVWMrSzlCWkZQRUJqUzYrRU9sWG90?=
 =?utf-8?B?b1pVelIxUkVTWTc0Q1F2SExyaEd3TU5NMVBSajEvbEw5Vno3YVdCd25rUkVn?=
 =?utf-8?B?UFVQZ3pQYzhzakx0eEs3WnNqaDI2bGNnekNNSFhzcUJtSUI2ODVwTWs4M0JN?=
 =?utf-8?B?V012MHFWY1V6Sk4vckFhY21BbU5zaEJQeTFlTWFNVE92QVBzZEh6bHBEUlVH?=
 =?utf-8?B?L2NRZ09abGlIaWYyYkRBUkY4dlpUMHoyNC90aWZQWVRDekViUkJHOHZleGto?=
 =?utf-8?B?VStNNkhqamM4TFZwbnd5UGVmbDhFUFlKU241YURMaFRQZVlNMWNWbFJRMEdu?=
 =?utf-8?B?RXFXSW5wTWZQV3k3SnNJU0J2TU1yS1BWN25Sb1ROdmN1K01ndXZVN25sR3FS?=
 =?utf-8?B?eS8vaUhPOVVETURDOGlRYmRsU3JxODBSNUZzdDE1elk1WUNuTHFBczRjUDFm?=
 =?utf-8?Q?zChYtLZUWck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHhBNDM1c2JsRFM3RjNMckxscTVHQ1RWaVJGdWRSNlg0Q1JidUNkaDRYcDhD?=
 =?utf-8?B?cm03REhPS212RHJzc2czVjhtM2hFY2wyZVFEdEYxbEdaNWpUeXhiYkliMXZz?=
 =?utf-8?B?UTdsUkU4WHdabmlBdnNobVgwUDdrSTZrKzl5WEU3R0ZsUGRCRHVzZDhOM0hU?=
 =?utf-8?B?RDg2ZDc0WXgwbkwyQ0tlWFVUTkY1NS9CeDJjRklIV29OWVNUTUJERjV6d3Yw?=
 =?utf-8?B?d3lPb0srUXpKZmxjd0p2S1VQT0tLZjNUcjFtUlZhd1lQQm9PUDFMZTZRd3Fx?=
 =?utf-8?B?WUNTMHN2UDAxRmpYc01JNUxkOGhDT3VuU2hNdzc0TXpXMVJweWpyU25kWEJG?=
 =?utf-8?B?aUx5VkhER3RxUWVBUnJhckxsVGRBNWNWVVVjU3FaNENtZTc1VEhRMnpVdzZH?=
 =?utf-8?B?akJrOEM3dWFWSjVSeGpmK2xCS0R4YXhXZXN3WlZxdlNLWWRvekVMSU14d215?=
 =?utf-8?B?YldLLzlWRnhseWNMM0ZYbVZDYkdZcDZoTGZYVmg0c1JNZE42dUFFS0g1ZW5p?=
 =?utf-8?B?ZnhuZ0ZlY2Y3TmJ1aG92K2JJU0tLaTZQeDRGdEpqU3M3YzRvQmV1K3hqYTcx?=
 =?utf-8?B?eHVXeUhrbWdnK1Bqc2JMc081VlNSZ0tQdXVUNjJBNkIvZ042czJ1VlJQWjFx?=
 =?utf-8?B?bTRpbXV0cUNSN3VwWFZqTUFzYXJWNXNXRGNuZExTTWcvZ0VKcTlNV2NGN3Fr?=
 =?utf-8?B?Q2YzYzhGVHZaVVhGNHZHdk1KRlBaUHM1QXo3VC90NWozaVh1WThLNW4vT2Jx?=
 =?utf-8?B?cHp4UDNjVmtQSGhFS2psQ3lXSU0zeWowWVR5M1FhZm4vVTNXb3NrMlRZU0Nk?=
 =?utf-8?B?MENDbmd0OUJPM1d3YzhwZ0tsRExSQVZ6WFJleWpnYXkzcGd2KzJaR2ZKcHdm?=
 =?utf-8?B?RHZYWEM5SDYyWmZXbEo4NGx6cnViMDhDL2tSazJxUE9iUEdCNjRxZXlOa0hw?=
 =?utf-8?B?YmY1ODJnR2hKdWpGQWJYYzlNcm42UmtkTWl2Nlp2VWN2QXV5aWRMeXFRZHY5?=
 =?utf-8?B?ckI1emhudUlSOFFsaGRtU1ZzUWg3NmlzODhSbTZhMjM3cXNSQ1pqWmJOMnZY?=
 =?utf-8?B?clcvTVROT2dKSzhDaGlXVWl0RlY3N2NkUDNBUkFHOWNLT2JYRno2bWQ4dUhD?=
 =?utf-8?B?Q1lMSGFiSWNyVnk0UXBzMUVQMTd0Y0MrRi9PMVJUMWVlQVZxWUVDcWpJdzRJ?=
 =?utf-8?B?cnZ1OTR3VlpGeWVVSk9BZENzRFRna1Z4VDZGbmxIeStQS3lCdG5JSEwybHly?=
 =?utf-8?B?VGNOcUY2L2k3YkJYN2RsVms3QmlmNjhQcjlHRkE0UHFKUFV4bnU1TW1EM200?=
 =?utf-8?B?eTE1WDAzc3QyQWMrYlhWL3V6NGFDK2FGREdrMElXMnJGUTdPWFlCdUgzV1Na?=
 =?utf-8?B?b2haNXNrbk12QVlobDVweUc3L1hRVDhGNG5zdkhmZVFaK2s0YnJ3dGduUjlx?=
 =?utf-8?B?QUNTZStYa0IrcXV5bVM5R1ZPMmJoRjZyOVlLODhwczVnMm1aeHB0R3d1Vmtp?=
 =?utf-8?B?dHYyWjloRWdTd3h3ZTNJN2tjV21HelFEaWlPWU5nZU1GcUJPQ3VMQ2RGUHlh?=
 =?utf-8?B?akJlSk90MkRwN01qbUVXTUlGdjU0clZSM05ucXo3MThSTmI0OHlaeWRYNmhT?=
 =?utf-8?B?b1RRWVlrRFB1MS9WTnoycXNaRFVxZVRLTGhGRHFTcStSNzNtSjlSUVdwSTFl?=
 =?utf-8?B?dUE4bzhoMHoreXk1UXVoVHkyQmU2Tm5LT2ZhMmVFWlVtQ0d2VFdwOElGdEZ0?=
 =?utf-8?B?cGluQjh5VEdEL0Nldk90WXZvWlZGMDNhcDgySXN5M2lVQ3NYYVFGc2V6WjJw?=
 =?utf-8?B?Vzk2MXVFdGt0WGpPbnhBQStJcXJ1dml1ZWU0MHhVUlpFVUFEdy9VVCtOdGNv?=
 =?utf-8?B?Uk1HaUVHbms5U2R4Z2JZc1BNZkx5RHNxMjBjaUR6bW5VcnJWV210MzdxaDhV?=
 =?utf-8?B?alVzRVYzbm1pelZVcnBFNDgvS1RjVUtXaUp6NVdpaC9qQTNyeStCY2kyd0tY?=
 =?utf-8?B?bGh2cGphb0x5ckhXYXFNMStIblZmOCs1WE5xRngzbmpYc2lhRzJLeVE4REdJ?=
 =?utf-8?B?YW50aG01aDNRQ1hnZDBUMlBxam9xY3Z2UFNzeDYvQ0RaTU9sS2l5R3hKaVZs?=
 =?utf-8?Q?P/8fLpVLap70kQn9aHK0ypjO0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f2e198-3e8b-4d6e-7ab3-08ddd3d7bb34
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 04:22:47.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvTdv2vyy3SiPPTHJzDTRWGwumR4+04AWDilPOp4xWNBSvdFlfXLap+Gb3K7LsYwvt5mEHi1wjumcURi/0La2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9791

On 7/30/25 19:50, David Hildenbrand wrote:

> I think I asked that already but maybe missed the reply: Should these folios ever be added to the deferred split queue and is there any value in splitting them under memory pressure in the shrinker?
> 
> My gut feeling is "No", because the buddy cannot make use of these folios, but maybe there is an interesting case where we want that behavior?
> 

I realized I did not answer this

deferred_split() is the default action when partial unmaps take place. Anything that does
folio_rmap_remove_ptes can cause the folio to be deferred split if it gets partially
unmapped.

We can optimize for this later if needed

Balbir Singh

