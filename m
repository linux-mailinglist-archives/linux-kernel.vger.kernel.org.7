Return-Path: <linux-kernel+bounces-896955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA13C519D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6CE189C34A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776530276D;
	Wed, 12 Nov 2025 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ipmA/7JP"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1B30214E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942693; cv=fail; b=l26Eyt5wF0QuBx4aQWuTtuL/0CchwNIbFCnZ3AFAIDutqobyBtDsUZljn+mPhwet/svt8mx5XRrALxeSuzEaCPlRbIC13I+6yL+ntZDDbJ0+zW60lxaQ0rSsSroZj/TFpj8mG85D+pcNZSBWRRaCy7XcWIce1GWqJZGtMvcOIxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942693; c=relaxed/simple;
	bh=mELK2kh269pxhYN9hXQfhyQUwClRESaqndIbcCrbMm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PCPXHeEvXa9cf44yJWA/NQb+DRfMnp2rIqRhwxGzzo747thDRDzzo4FrAMZc+tfXkTn+4baQ1mMP77PxDaRSAg+lT2EBahFiPSpLGNwStP88SJN9wFdHuvCpLg+tsebL6ggMHFP3QHoy//tcIJ2MmZW4QDjl9UoazxFHCNxeux4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ipmA/7JP; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqA4lVORv2z9PzkheBwohxmTdMrkQhyvWJF0VQKeKcg2+SYERAZIbIyqpOWpZBG3QqntFFeiLaqJDMdoIekaeOiwgwXWXZhCXaus2DMWrWDk/GS6VIC+vzrnBOUdPSAT8RLswC9o14WA5uuNPIXEZUBt9yXP8Q9RELV4NjZzySWz9dl3IVxmKYRpAJkTxT6++XOXjJg6djpqbooSSaJ+bqkXwZuwh6Zo5hlD4sNP1cJB8iFoJzHvBYLO3np9PgBDLjYPETEVi+W2SktcBlYz9CbNdbfukywc2YIwRI2oOiw8itIYlOqZlUTFG5GCEgg8qIFKtvxNh1C7+L+79CdGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVGRH1krmgPlFjoelyPZhpuUpFJ36VKuoVLKhgNhUdo=;
 b=eHqH1p+lGE4Ryep2+ldAqQFJIeCrGcgTEOFR4ud11s3Y/Qmy5IzBoCe7oEC/jmjOYeavCLZLTsH96ustEVnt0LYIfWDb57T3rOiteI8Aob4qWOalQN3eHIcXDMAg4DQ9PgYVeFsN7OOLhsoWXvxNQeNkiW+Cxbq08WO8fwCQheIB6gzRfV2i9LbzvVr2PMzHeHdATC0zS+AEFfFZ/i3BmXrVqlimbH38Ukgtp0n9ToXJsWYSu/cNhuLddCltwlwOWfQVhJvVe8zuHuggAZmOek/Cd30SPKOXH3aX/fv1mjMI0Zk6IACKtROg2qLO1wo2iqcqEMJFSBwXRgkuJYNB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVGRH1krmgPlFjoelyPZhpuUpFJ36VKuoVLKhgNhUdo=;
 b=ipmA/7JPpouwkdSVREUGbUbhzezKe6EtrbYZW0tTDS9untg1mZz182RfULXO4KTaiTDW/jb+bmx2m0FNGp2cAUthfkOOl25+/w7AuItPO7n0awUhxvEq3BKRndemMgKQbUwyRkSct8fPYMGUTRJ+yfRGa9qHGBA1wu7uLy2S4EPJxLhJCewrvNu3bCbsBVFa7Zoe0ioxgY9eqpflG2IvTcbBl8C7updwma6EkFc4fuYhAzDKMLjQVFqtTA2K7k4E36SIXfYRcB1UGxx8F7HsprRmCS7irABAnnTT3gfa0HSWtqS5qakKqRJmj8rMtKAwb6J1tawGC//s/ZvhkSy5vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 10:18:01 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 10:18:01 +0000
Message-ID: <efa37c4d-8c9f-4094-a713-4fd4452ae917@nvidia.com>
Date: Wed, 12 Nov 2025 21:17:54 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory.c: introduce split_unmapped_folio_to_order
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20251112044634.963360-1-balbirs@nvidia.com>
 <048134fd-6a3d-4a6c-a2eb-9a9911c3b35f@kernel.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <048134fd-6a3d-4a6c-a2eb-9a9911c3b35f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 578ab947-2729-46d5-8833-08de21d4c2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDFTUmlkSDlDMUtVQkNHV3lGNENXZlJTdnNMMnRxVk9zbjB0SzZPalFTU0g5?=
 =?utf-8?B?d3dSWFd5eUFJSjNyZlFyVDVReUkvWW5ienhqbU1NWVpmR1FHU01JUjZnY0Vo?=
 =?utf-8?B?S0VVaER4NU1SMFIxUHI3ckh4VldvNFJuQ1RBb1c2d0t0WEVNWmxjWk96OFhm?=
 =?utf-8?B?Y0VFLzl2c3F2UG5yK2xGYTM2OGJtcmVUY2RnU3RuWVhNZzcxQkkxQkkyelhm?=
 =?utf-8?B?dmJDNkhTL251cXFlT2xKT1NzWkIxRCtzRE5RU3RyNm9nUHdKWTdLLzhkbmhJ?=
 =?utf-8?B?dGpGdXp5a0ZPQ2ZreUhScXJ6blZQN0lzUy9yY3llbi9WRFZKN0dQVU5XRGV1?=
 =?utf-8?B?Q3FkUXJROG5SN1E0bnNEMk8rZTVac3BGZXV0YVZzSXdLS1lVMXpKd0NGQjRQ?=
 =?utf-8?B?U0piYmdMWUpxZVpGT1BoWXZGeGtLN0VhcjYvY1F3QUEraUc5cVlnRy8rSjNW?=
 =?utf-8?B?dU50NXl1MG5EcTd6RjdBSmMxOHpSaC9wRTFtOVV6M25sTDhKSEYrdGRtRE9N?=
 =?utf-8?B?dXFWeWEyVVRVa1ZaV3UzRHRoM2lYUHpncE5yUzJDNkM5MjlyS2pjTlVGaHFX?=
 =?utf-8?B?QWVBeU4wYW1CcGpNMlROT3RsK3lob2hDRmZITktQQWM5bEVqdHhIV3BqdmRG?=
 =?utf-8?B?bFAvTVNmQkJOUEt6cmdsZ0JtWFB5empPRlVOMERlOGhzTVNId0RnQmFzQUtY?=
 =?utf-8?B?M3JtU0dtdytMMHRVdlRuZVozb1ZaYXF6dmhxdU93SXZtTkVySnFHdDBRanky?=
 =?utf-8?B?QkpBOEVPaVd3WjFhSXVsRjBLTFc4U3RBd0VhZWdFUzdLdlJLclJJWGhBNWlE?=
 =?utf-8?B?bTVqaGRJNnNLcXBCY2JZOWpMRU1vbmRqY3NqM2hTclZaNmZIK0MrSzFUUkRq?=
 =?utf-8?B?OTdXajdLRGVLT2FjVlNyR1BHUUZCRE1mM1Z0WHVLZW9ONnpSY2srckRFSjJL?=
 =?utf-8?B?V2VrdlJmK0xya3ZTbHlqR1hYbm51NDc2UHdKa0o1UG1GUDFFZkhSWGZvU2pR?=
 =?utf-8?B?QVVOeldsY01GQnU0QVdyYnU5TkZjTGgxYjdFcG9sbEVCdjNhYXQyYjdJK3Nl?=
 =?utf-8?B?L2RGQ1kyVUF1dE1xVHhkbGFzeEgyY2FvMEt6MElTNHNYS0xWWEFqM3ZyYThN?=
 =?utf-8?B?NG00b0wyTVkxN2RwamZjOXUvQjQ5MDNQODNaekxaNFBMRHUxWXUxVDRoVi9q?=
 =?utf-8?B?UVd2SHgzZWVTL0JNTUxVZFJzdjJHWjV2c29SZE8rd0VkTEtJNlNsSktDT3Rs?=
 =?utf-8?B?UDByRStNOUlZTGh1QnhUcVBVRzJvRjN5cW9qa2diQXk0WVpMYUFLYTFWSGZu?=
 =?utf-8?B?dGM5eU4rZG9YYThsd0ZVQTRyREU4MUNrSlNDZHhOYlczZ2FGT3NSVFpXZ0hw?=
 =?utf-8?B?SUs1WjNpSGNIVHMzWEUxTHA4eUxKYk5LREVGU3E3NnJ5UjlnVGhnQmdMUm1L?=
 =?utf-8?B?NXBzVm05ZHM0dTkyc1Y1OVFJTkVOVENxUnVKR3BxdGxFRThnSENrZXpVNnBP?=
 =?utf-8?B?NnNPa0xBK093QTVDU2VrSk5XSk9vNGwrZkJuVEhLZTJTdzVvL05KTTQxMldh?=
 =?utf-8?B?ckpVeXQwUXE0U0hMS1UrNEUybUdGcGRtNThtY0ZvMjVFM0JqbGp2U1JaN1NB?=
 =?utf-8?B?cTZ5MXd0dEN6eWdZRmxrMW4zL1ZPYWI3UklaNk1aZFAyUXE2VlFIQi83Zi9D?=
 =?utf-8?B?bEdweGs3L3pEOEVKUyt0VXg4ZHNPdGZkR0VYUnlPeXpjMHFNbTg0VGozRkNl?=
 =?utf-8?B?MXFmMUw3K2tvUmJVbE1INWRXd2xYb1lsbmF5MUJPb05GZUJHS3l1L2hlSVJj?=
 =?utf-8?B?Z0xXZ0UzK1pMM0hWWTJHU01SR0lvUCt1ZzdCZjlTb3pZVUFlRFdkckVheW9y?=
 =?utf-8?B?dUs1RXJWTE1IRGNOV3plUEYyZnRvOGlGWTRFRUJUblFrMnNIRmI0L1N3NnNn?=
 =?utf-8?Q?qT4C8YYfu6nkJ27CSYBTP8pcTlB5YURS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHlvdkRZNzdzU09Hb2VtdUZjcVFZZEsvY2tsR0tIb3Z0WjB1MFU1dlJ6SDV2?=
 =?utf-8?B?bEozeE1GYzU5ajF1MEdYZVl3U3BMVTJPaUE1bHlXYmxORlhzbXhxMDgzVFc0?=
 =?utf-8?B?M25KSnRLQlFRcWMvUXpZSG9SdVlSWTV2dXRvS09LYVlCemNBbUFhaGh0anNl?=
 =?utf-8?B?dmNsejk3MFBUVnluQzREdytPajdqSU1iQmR2bTZEeSt6aWVsbGN1MnFtdG0w?=
 =?utf-8?B?T0hocmZZd1ZIZmhyRkxNWVkzNTlJVHBJR25GeVd5SjRSS3A3TWFYSE9GTHlT?=
 =?utf-8?B?dndLUmdnT1draCtjS0d6R3l5RUYrcE1ZM09weUlLeml6TlhnSzZjcnlDMlZ4?=
 =?utf-8?B?YW05dVR0Y1pGUXp1SFNmZTdlSU43R1AwaGpFVkoveVMxOHdDN1I1Ty9Tczk5?=
 =?utf-8?B?Q0JMd3M1OVpISTdEMGZndFhsaFJCWWYrVk1rNVNsWngvYURYSW1pRENiUGFn?=
 =?utf-8?B?QkxiajFFL2U1OUttajROUTMra3NMazRnWkk4MW0xNDJpMEYwZlliZ1BBT3lZ?=
 =?utf-8?B?OTZzQmJzdXhtd0tKUTZPbitkd3UweGh6TWl5MUJHUFR4NDVMU3V3cXNnd2Vq?=
 =?utf-8?B?Z0kvTE5UTmRaVDhpMHZUemNjelVRZTZoL256clJHdjk0UUVkdjFtWU9mVnRN?=
 =?utf-8?B?MzF1cDZsbmJrckEvUGtHbS9KZFREdVE5bi9XS1J5aC9rZ2dGWTVjWXY2WlZQ?=
 =?utf-8?B?YjYzd2E4eENtRkJBTEZoZlhlQW5QdGo1ZHV1ajJWTHlMNUx3UE9BQndKY3Q5?=
 =?utf-8?B?aDVjKzVFeHBRS1hhcWNQVGxwVUxXT1RNMkFOZE45Uk9XZDRYcThxcGtTdXhw?=
 =?utf-8?B?cEI0Y2lmcFJlQ3EvUkhObW5TY3A3cXErTWFJMUhOOVN1NHdxclowU1dCZWlw?=
 =?utf-8?B?MFJ5ZXJnc3NlWUZHNjkvdFp2RVJIbEJEZ0wydzZ2blduK1d5S2FqOXV4OW5B?=
 =?utf-8?B?Vmhqd1ZSVEtFdUJjZzhmY3FGSVFyZXYvRlNLTTBYd2ptRnIwSHBOekhKUmJB?=
 =?utf-8?B?ME1LM2RhODdSbjNjajVHTG5vK0lUWXRvUTFWdTFwbnVoQlpvWUMrWWVycFU2?=
 =?utf-8?B?OGUyS1d4SHpmclBrUjlQbDVYeXlxSTN5Y1puWVpFU1RUSmt1YXVGcmNMVnlu?=
 =?utf-8?B?WnM2bE1nOVNhcmNCN3FpVzR5NXRMcm9CM3g0ZHRweDNKaUgwdlIzZzNtUExB?=
 =?utf-8?B?VUs4U0wyeEtpMDBaMnNxVUFlZlhzZXN1L0ZtQTRXTW1TK016b0tzL2kwc3Fn?=
 =?utf-8?B?aElXNmNDU2dSZ2Y5L1o4OUNrTVk5T2oyMWhacnV1anpQbTF1enBTZ0R1b2FU?=
 =?utf-8?B?YWdpem1MSVg0MHVJbDZxeFNXQ0JpV1hjTXBXQTRnRmRqMElFNnJQK3U2ZFgr?=
 =?utf-8?B?dDZWVjFhTjRvTmdzZ0twOUp2dEpzYUlJTjE4SGNhbWxwZDJoYnJZYWtlYUtx?=
 =?utf-8?B?M2xma1dZd1hsVzV2NjZHaVh2WGlaakZFL0taTFJpcTZ2SVZRUUl5V3V6VUFw?=
 =?utf-8?B?ZWx0ZHNNaHZ0UXpyQzc5RVJWcTAxVmIwUmI3bS81N2lLNHFaRkZPd3lnK3M0?=
 =?utf-8?B?WDY3NUZnenNLdmNEYWI3U3dLdjdHbGJaUmx1aDRvaGRHRG5oc2lNUXFaOXdH?=
 =?utf-8?B?UzZPeEZDVzdjVGtsdEdBNmNBWmRDZUpoT0dSOFI3RVdndG5SZGswTkhNaDNn?=
 =?utf-8?B?NDhaTmhmSFFhMmkvc3RCRXJuTllOZ09sZS9YOXVMQ2QrOWJxTlp6M1ZkZzFK?=
 =?utf-8?B?VU5FTXN3TklMWXZSWitzUFcvQkN6b2xudE9vbkRnKzRyUWg3bmNib2hYb2Zz?=
 =?utf-8?B?NjRFRmNXSlpzVjhvakR4NDd4eUtjaFlsSnRGRTlQY01ldVFDc1RuMTNtRUFs?=
 =?utf-8?B?b1lQUTFxaStZc0lRUWFIRWY2K0JxYWZ1ZEtDT3VmZ3NFS3diZGtMY3B6UjBo?=
 =?utf-8?B?aVlidEJTaE5TWFppY2gza2VMc21WaGhkdTIvOU9hamxZM2NhZ0RUOXlJakdr?=
 =?utf-8?B?Ui9LYXZZZllJamRnV2tXNXlHMnpSaEpIMlNadnVkU0VadkdzOEZlRTlUb3Ay?=
 =?utf-8?B?dCtrd295ZDN1ZVk1NTYwNFNNdyt2QzByWHFFRUQzUlB6NnI2bllTbjg4OWxK?=
 =?utf-8?B?R1hxcU9obmtDRGNWbXJ5OVlDUFJiMDFyaWtIS203aVF4cGtJMkhZL2pQY1dm?=
 =?utf-8?Q?XeVzjLuptdUkLIzlZGFHPEowD2/RnM/hQQemGzgmsAAF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578ab947-2729-46d5-8833-08de21d4c2a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:18:01.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpO++8vKwQsfafuW+46H7gH15FRk1kdLbQZmwo8iYAArWDpIE3ZbtQJCOFdO7TQsfFlwW7bcY6IZMo4JWXCjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

On 11/12/25 21:00, David Hildenbrand (Red Hat) wrote:
> On 12.11.25 05:46, Balbir Singh wrote:
>> Unmapped was added as a parameter to __folio_split() and related
>> call sites to support splitting of folios already in the midst
>> of a migration. This special case arose for device private folio
>> migration since during migration there could be a disconnect between
>> source and destination on the folio size.
>>
>> Introduce split_unmapped_folio_to_order() to handle this special case.
>> This in turn removes the special casing introduced by the unmapped
>> parameter in __folio_split().
> 
> As raised recently, I would hope that we can find a way to make all these splitting functions look more similar in the long term, ideally starting with "folio_split" / "folio_try_split".
> 
> What about
> 
>     folio_split_unmapped()
> 
> Do we really have to spell out the "to order" part in the function name?
> 
> And if it's more a mostly-internal helper, maybe
> 
>     __folio_split_unmapped()
> 
> subject: "mm/huge_memory: introduce ..."
> 

I can rename it, but currently it confirms to the split_folio with order in the name
The order is there in the name because in the future with mTHP we will want to
support splitting to various orders.


>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>> Cc: Rakie Kim <rakie.kim@sk.com>
>> Cc: Byungchul Park <byungchul@sk.com>
>> Cc: Gregory Price <gourry@gourry.net>
>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Mika Penttilä <mpenttil@redhat.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Francois Dugast <francois.dugast@intel.com>
>>
>> Suggested-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>> ---
>>   include/linux/huge_mm.h |   5 +-
>>   mm/huge_memory.c        | 135 ++++++++++++++++++++++++++++++++++------
>>   mm/migrate_device.c     |   3 +-
>>   3 files changed, 120 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index e2e91aa1a042..9155e683c08a 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -371,7 +371,8 @@ enum split_type {
>>     bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>>   int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>> -        unsigned int new_order, bool unmapped);
>> +        unsigned int new_order);
>> +int split_unmapped_folio_to_order(struct folio *folio, unsigned int new_order);
>>   int min_order_for_split(struct folio *folio);
>>   int split_folio_to_list(struct folio *folio, struct list_head *list);
>>   bool folio_split_supported(struct folio *folio, unsigned int new_order,
>> @@ -382,7 +383,7 @@ int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
>>   static inline int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>           unsigned int new_order)
>>   {
>> -    return __split_huge_page_to_list_to_order(page, list, new_order, false);
>> +    return __split_huge_page_to_list_to_order(page, list, new_order);
>>   }
>>   static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
>>   {
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0184cd915f44..942bd8410c54 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3747,7 +3747,6 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>>    * @lock_at: a page within @folio to be left locked to caller
>>    * @list: after-split folios will be put on it if non NULL
>>    * @split_type: perform uniform split or not (non-uniform split)
>> - * @unmapped: The pages are already unmapped, they are migration entries.
>>    *
>>    * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
>>    * It is in charge of checking whether the split is supported or not and
>> @@ -3763,7 +3762,7 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>>    */
>>   static int __folio_split(struct folio *folio, unsigned int new_order,
>>           struct page *split_at, struct page *lock_at,
>> -        struct list_head *list, enum split_type split_type, bool unmapped)
>> +        struct list_head *list, enum split_type split_type)
> 
> Yeah, nice to see that go.
> 
>>   {
>>       struct deferred_split *ds_queue;
>>       XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>> @@ -3809,14 +3808,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>            * is taken to serialise against parallel split or collapse
>>            * operations.
>>            */
>> -        if (!unmapped) {
>> -            anon_vma = folio_get_anon_vma(folio);
>> -            if (!anon_vma) {
>> -                ret = -EBUSY;
>> -                goto out;
>> -            }
>> -            anon_vma_lock_write(anon_vma);
>> +        anon_vma = folio_get_anon_vma(folio);
>> +        if (!anon_vma) {
>> +            ret = -EBUSY;
>> +            goto out;
>>           }
>> +        anon_vma_lock_write(anon_vma);
>>           mapping = NULL;
>>       } else {
>>           unsigned int min_order;
>> @@ -3882,8 +3879,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>           goto out_unlock;
>>       }
>>   -    if (!unmapped)
>> -        unmap_folio(folio);
>> +    unmap_folio(folio);
>>   
> 
> Hm, I would have hoped that we could factor out the core logic and reuse it for the new helper, instead of duplicating code.
> 
> Did you look into that?
> 
> 

I did, I ended up with larger spaghetti, I was hoping to look it as a follow up
after the series with the mTHP changes and support (that is to be designed and
prototyped).

Balbir

