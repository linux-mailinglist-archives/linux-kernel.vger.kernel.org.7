Return-Path: <linux-kernel+bounces-736363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6999B09BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E257A5A34CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84520B7FE;
	Fri, 18 Jul 2025 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fe/eOj5V"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD43D517
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822293; cv=fail; b=MFtIuNCuNT8bqpUP8pgctDXqreIK6qJTO0B4VF00mvkrvyOIQjsA33PRpfpTPhCOYEiAiLU5ArMnb3KFKLFffD3+RSv66PB3jQpnZigDDK4kzKLlM2/ivIHIAFxMvkhicj3v0o3XPM965jC2Co7T+29EjCZvrJG2wZBNP5qfGCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822293; c=relaxed/simple;
	bh=Uio0P3boEZPNGIs1eFJbqgxQMTAok7mqnwqxJZh03qw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PtT4amZnwERn3g4RW6SxdGJCozt+vQ5t63/Sv7/PwUL+zdfpkC1UmAY4VC7utZOKioIdpKjTfpATSQKBa3d+lZCVEV++8NdqmzSuQ8uab53AH53n42E8+z5N6pxL+ALXZEfBzalMOsphS443B8XxZdULBSLzqDN4gi7o2F0Jbd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fe/eOj5V; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWW4XydAHobnew1dTe8xep8jdTrWHZv9cWXVFYN4JayKV4WCmzTD6kc7z6V1XLHMo4cXiotjYsjGTAoSwsQokJYUnEjAK1rPQk7fMwyDtjTTYX4KHyD+l0c70Eqle9VbR8M5VPKbzzwID62E1gigzpeMv9+y/2tQ9U9GVjSQ7RqKC+PQlvxItX3P2f8hRt+wvk/WRIAESoZMMNFJfEXiXNS5jspLnpd8FAvqx+z8YTg7SA0yvlKSwrFQN3MMqz94nNzpGx2jvEmvaY6yj4+yVWOw7MatELcwyPN7t6x5AJo5BwFiKLZAoxxl6EkFkSTqXiGMVzxaUv9ZYB0pBWzdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl/vUfZGRFqRp/CzxthJMgZRD4mokJI24vZAoouqAhw=;
 b=xWdS0jNqV1D2f62Zrpakkt/7tgTF1YQtiiazKNGlNZEpQfnW+rRbPcj7ifVBBlgU6rk3sBMqEILryVs49VBzdYYZ8qkJyWuBCMUQdb5snezSAUKieH5AO7MNBAEstZILvIfIPCXg6rMULu6YW64+3MkbLPo8CrS/DCYqE6vwWtQA8bGNhTLTMguTeobKJyIv6Lrd9acB0mHqkZZpz4vD6XWobijUlrekvEjFHBxphc3lmPiw+tqyVGCWUmyBa8XuaaUER1obvrXypVQ+ZE+k1hLl99rcZo+8fseOXYG2cO6pDWvSq2ZdqPD6e0wdPVwedUOFDAE9Zhn8k0Tc2M4c8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl/vUfZGRFqRp/CzxthJMgZRD4mokJI24vZAoouqAhw=;
 b=Fe/eOj5VFSpWDBUsenStYs7dYF6n/41UWJH6BElnBd6oHvyaThqK2oA7IqzLuNfBJqbGVDlj7WnJyuLK/6lo4GQmjRl5zYcXzJKIW1HEZg4ylh+/ZxETo+d/Kne4/vRPfSxK239XwvrHw5Lu8J2+hVNuFVLelM5ajYgCX2pgoCzC8hciInXKPFQsQiY2WHGj4AO3w4R1cz2yaWqQCN7buOxLHWeKcoM0Ame2+6f2m9kPh0X7KtPXZWwEoxyiRhd86DdQE4+asY+FA+u/OFHkBsKNmTYROr+N8r4bJZyFVdCbwxZw4HNQ7cIBFljVS8CkDjkoqQ2/5JT3gmR9DnpXeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 07:04:46 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 07:04:46 +0000
Message-ID: <83354b1f-8170-4f73-933f-5127f1d12dc6@nvidia.com>
Date: Fri, 18 Jul 2025 17:04:39 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 04/12] mm/migrate_device: THP migration of zone device
 pages
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-5-balbirs@nvidia.com>
 <aHnw0kEpIDYfFX3E@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aHnw0kEpIDYfFX3E@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::28) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8f53f3-cdec-442a-cad9-08ddc5c960e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0dNMU9yaWF4MGJNbG5tVEtZeGVFRUJXeDdLY2lMZ0d4dkJFMmNReS9EZFEz?=
 =?utf-8?B?SEJ2cGY0cXJKNzRrbkZCOFB5THBCSlIydG9yVHhZRUxtbFgwNjhzS1pjOWZS?=
 =?utf-8?B?VmUrelJ1N3B3R3lIVjA5bmtRc0IrVWJzSGxIRU9vcGVHeHExYXZRbEZ4aHpq?=
 =?utf-8?B?Q2FHS0F5aHQwOFlSb3QrQ0gwRkZuUkR0TzE5bVRWWGNCN2pqVXd3SkZHMnJm?=
 =?utf-8?B?RklEaE9kWnB5Ym4yMms3akFtdlNId2UxZHR0SVF3REROdjVZQ05OMUh4cHU2?=
 =?utf-8?B?UzRtbndncHVRK0JudS85YllnWW9kMFFJNVdaOFUzbXd0VkJPampiVEFXckYy?=
 =?utf-8?B?aDFFb2hxYkhlQ2I2Zkl0ejlIeWpMSFhnemR0bkJYRjI0T2p0bVZSR1I2amM1?=
 =?utf-8?B?SDFqQWJIb0RKdHZJSGxDanBjWitzMlJjd1RpTG9UWWZuelFINWp1a2tibHVl?=
 =?utf-8?B?Nk5maWI0cnU4aTFDRDhneWJEa3gvUjZ0UzhZK1lTUU5EWFhFT0hPNDkvZ203?=
 =?utf-8?B?bWlRMHVDUlcyTXZTcG1NbWZIMDBYSW5RZFZWejlza1hvZW9ydkVRcUhFb0h5?=
 =?utf-8?B?Lzl1UUFheXo3ZDlONlF4cnBLOUQvNlBrV2hqb3JMLy8wWFhYK3gxcDVhYkVk?=
 =?utf-8?B?SzNvQ1Q5ay9QMStha0NkRUVBVmVWdXlmdGJhdDZ1SkZPMXdTOURzUEtvUldy?=
 =?utf-8?B?bzZRZHF0czhzNW5wYXBNY3JJTDZvQkV2MVFKZTBsNnBJOXRoWjQxUVZ4dGtD?=
 =?utf-8?B?ZEVXK3FNYXo1cTM0aWJHUktmYmcva0RiOWlsbElkcERFNjFrUjBlVWt1aDB4?=
 =?utf-8?B?SnpXM2pMd01OdDNaVG8zeVBHeDBkTlhLWmo0YU9wSzhHejc4S2ZnYTRPSkx3?=
 =?utf-8?B?c2JENWxTczl6SzNRNjRaZ3VYdFI3UjZNUENCTS9iS2U4WGNlVGpKUE5OL1Fw?=
 =?utf-8?B?enZDcDNNNFVlamhmaHJpeHkxdVp2TXEzQXdrRjVaSXJyOG1SaHhLaHRJNDgx?=
 =?utf-8?B?WmNzbmlDMERtYVJDOVkrQytTcVNGUGhoU3FuWm9iOVNyS2RSbE9ZbERBeVBv?=
 =?utf-8?B?OEhQbzBsblFXV1ZlUnJmRkpRSkpYWlVpL0FoajROTzFveis5MWVWeHhOZGhu?=
 =?utf-8?B?eDI1OHZtWmU1OVRVb09xK2JFMGlnTDdKVWJ6YXJnVHF2WGRVSFVKQmZwZ2Ft?=
 =?utf-8?B?c2lRZkxyQkJHaFM5WXlaRE5BNlUyTDBjNmFUQzFlNm9PWmQ4QU9GMEJDc0tB?=
 =?utf-8?B?ZmY1K2lwQTZXeUEzZ1VXQlZkY2d3S0pUbG4ybGxxWi9QcGdneDZSaC9VcDU5?=
 =?utf-8?B?Zlh0a0o2NkZsalBwT241VWdDM05YM05DdDJSdDc1Mlh0RENscWhrNkF0Snh3?=
 =?utf-8?B?S1UvNHM0UEx2L3ZKY0xiZTZPNStPakwzczJXUnlzU0tUZ2ErNTgxYXc4alQ3?=
 =?utf-8?B?cGZwWHR4MlpkSXJLSTMvUG8rZE45d1dPQ2tBTzJjdjZVb25ubGJJbUJNMVJk?=
 =?utf-8?B?ZUtJMmFSRGh2RzdIVTFuVWNKZ2FjZW5Sb1ZPQ0h4aXMrSU9ESHdib1RsbUNH?=
 =?utf-8?B?VnJHdFBORkhsUXVrcWx4UWtXL2sreDlySUthdDV6a2lRaEFwTUw4Q3pKNHlo?=
 =?utf-8?B?bHRKR0t0UjBuMExqKzdtODJNZWxiTmVNTjN4MENSRUNkSUpreE4zVUZtOUx0?=
 =?utf-8?B?VkVHbzVtMFZ6S0JIOTdhbHg4ZXd0Q2c0Umhzd01lNFZOejdZbmZqL2NlaW8v?=
 =?utf-8?B?R3ZKYnBvMmFoSmRKZFRTNlZNUlZhYjByZEszZm4rdGFWMGJORzdCcFlRM2R0?=
 =?utf-8?B?S1dKZU5WTDZrdmVmQ2JrNy9MZFRmWFV1aHkxTzlCQzczeGxJREZJdGpXU3ps?=
 =?utf-8?B?RmQwYWZMZlB3WTV2WkNObkJCcFhJMFNzSFpWWHBVMFMrVVpHem5idWdEU1dj?=
 =?utf-8?Q?Q7DdRenLJDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZlUjJLbXl0c0JXSUN0WmpBT1hFZDlCTlhDYVVJZVJsWW04WHNvd3l0L01M?=
 =?utf-8?B?b21SY3VER1NkbDdENUhLNHQ1VXZocXFsdTdDandlWERmY1pHYXJuVVRuSHMx?=
 =?utf-8?B?cVl0TXJZTDBUSnNEWXR1bXVDbnRFRHl4Q3B0ZEVUUG1WNEZoSmxJQi9jdHRI?=
 =?utf-8?B?clhhT0o3bThLZDBHNmhnR2xHTTNJQjN5K3hJYXRyTXNvSGo0b2tCSVBrVmlk?=
 =?utf-8?B?bDdTb2RXMWh6dW1EMzhyMDlydnMxeXptTlF3R3l1eHNNbmZxQVFmTXFxZkNk?=
 =?utf-8?B?S042UUR3SVlacWVPZmlsc2EvVTNQTTdZc0FiRjhncE5pQkpYRmwycUFUejZu?=
 =?utf-8?B?UFBodlI0dDIxT1ArWkh1WFlONGZRdWlkb2tJYVpHdGZDS1FCS1hwMk9RQTY0?=
 =?utf-8?B?VDhqZnk3aWd5VXJRSjdZUXUreG9NQlV5S2N6dm5PRmVEUTk0Q3ZBUGRtL1BY?=
 =?utf-8?B?VEsyd0M2ZXRHTkFvQW01TE5QUTlhd2hrRWdXQjlaemR1eDJqOS9nMGQ2Njdq?=
 =?utf-8?B?a0MwaEpXMUU2S3hFamVXK3FIYVdEbk1ZRWFLNDVSbjVXbG9iNWhIbmdBdGl3?=
 =?utf-8?B?dkZRL1AzUktFOFNKM3dnV3dBSWlYNExQYk1SN2FPRWlKdytNZTNVSDFML3Fh?=
 =?utf-8?B?R1MrSXh2clBORWJ3REFFVmdwNk1ldnl2RFR1eE96cnNsbHNjd3BGeElKVEh6?=
 =?utf-8?B?SUQ4MVlObGJxTG5TdWhObHJpbitNQWVCRDFkemhhUXNFMm5NbTVudFJFUjIx?=
 =?utf-8?B?U0l2eGdMUWNwdzJuaGJLWTU3RkF4a0pLZVVOWDkycEhzQWJFMTdZTEJSNU10?=
 =?utf-8?B?bE5yUXdQbC8wU29ldkxSbTlKR0ljTm9IWmtvM1hVTXFOeFB6YU9ta2lha3BB?=
 =?utf-8?B?WC9EaE1Vemx0QlRVd29vOEw3MWkyRE1HK29hRVF1L3Bob1k5QUo3NngrVjM3?=
 =?utf-8?B?dThWK081cFVnMVRUcEJHdFdQQmNCOVRsaFkrWDNVMU9wbDl3Z3BKT1dubUcv?=
 =?utf-8?B?dlRjL1lQUG9IdnU2Vi8wUmlTZzRGWWZsZFowT0pjc3RyNHpDRWpnR1EzdlFo?=
 =?utf-8?B?dTBmV2RkQW5xRTFhbWFmbEZDTEdaZXdjcFNycGE2clQ0THpsWmFnZkZ0cWF6?=
 =?utf-8?B?REo3UUVEcmdEUVkveE1vb0JQUVd0bTBndmgweVpRUzlaZ2E4SERHNFVLU0ls?=
 =?utf-8?B?Y29VU3VJMXJzaGR4bUQzNDg1dHhQcnFGMlVwb2paN3A0Rm9iV0NxbTdyK250?=
 =?utf-8?B?bTVTYXdDT1pBTmYxdjR5RGorTDZiVjJlcmw4ZGp3SVUxUjJVbDAwR0FLd0Q2?=
 =?utf-8?B?RktDQXUrM0NtazJ5NFRvUE01RlowZndPcjhmWDViZWtKV015aE9uVGI5bjdr?=
 =?utf-8?B?QkIyeG0zdEgvWlk2N016MnNLb3hjQjFsakZlR2pJQmNuVHRaTnNzSkt1SDJ3?=
 =?utf-8?B?bjAzdWJoaEVYaVpsa295MVdFazFZMlV4aE9xbzZlcVpUN3ZqMnFIbkNVbjBM?=
 =?utf-8?B?RDZFSDFwZk9VWlgwMFNtTGo2Q2hJUjl6TFVRamY4UjNJZ1RGdHI3cVdOaERq?=
 =?utf-8?B?MlNrdHM1VUYvN1ZEeVBmb3VrUUppL3NQQzB2ZFVqemlWMVlRakxBbXFYTDds?=
 =?utf-8?B?Mk9TazhkdlRnSStMc0ZEMCtiZmZobjN1dXNFVmdYNEJjckNjQS92QXk4bHN2?=
 =?utf-8?B?ZUtJUUtsWjB2eVYweFZod3BPQVVWei9odlY3d0lCdm03NFk1V3B6d1JJeHF0?=
 =?utf-8?B?UVYyRTBUZER1ZHBOVXVRa2Y5WWhHR1hGaE9pWHd4QkJXUXZ4b2NhazVKSFFM?=
 =?utf-8?B?TGlZZ3Y1Uk5MdWFNVWV6YXlsQzlSZXlYTjJVVUcvdmNFeUE0blJhNzlEbFNH?=
 =?utf-8?B?UjUrVXk3dm9uNnNlSXhXcTYvdmVHSlplSlljQWdXZENJVncyNytqODZpWEJu?=
 =?utf-8?B?Y3lyUVBoekNMVFlNb29KalBCdjVYUnJ2VGN6RUxLMXJFMUdvU1pCNFhMLzMx?=
 =?utf-8?B?L1IrcGg4eGFKeU1iSDJBTjVsTDJtYVdDL2MzcGtGeDBtdVo0OHRoRllLVnFT?=
 =?utf-8?B?OU1jaTRiL1c0TUxBRXZzT1J1SmlRQndrMnIyelJLbW83VFVUa0xtb2Rsb3pB?=
 =?utf-8?B?TVpDSlc3ckhKNXl3ai9vUy9OZ052WkY2Sy8reWsyZjZJTnVuTjltelo5aXFx?=
 =?utf-8?Q?QeTcudrfoA5O+LSi2fhx3Bz2fJAOLhhb/DEafROxbcvL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8f53f3-cdec-442a-cad9-08ddc5c960e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 07:04:46.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAKTbgTuPVfjJEglar6ZNaIS1M1as/F7qnPJu8ZoCbwEea6yFkKsLNgieLBo06MMseJvAWaU+9qm847VqTWUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

On 7/18/25 16:59, Matthew Brost wrote:
> On Fri, Jul 04, 2025 at 09:35:03AM +1000, Balbir Singh wrote:
>> +	if (thp_migration_supported() &&
>> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
>> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
>> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
>> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
>> +						MIGRATE_PFN_COMPOUND;
>> +		migrate->dst[migrate->npages] = 0;
>> +		migrate->npages++;
>> +		migrate->cpages++;
> 
> It's a bit unclear what cpages and npages actually represent when
> collecting a THP. In my opinion, they should reflect the total number of
> minimum sized pages collected—i.e., we should increment by the shifted
> order (512) here. I'm fairly certain the logic in migrate_device.c would
> break if a 4MB range was requested and a THP was found first, followed by a
> non-THP.
> 

cpages and npages represent entries in the array and when or'ed with MIGRATE_PFN_COMPOUND
represent the right number of entries populated. If you have a test that shows
the breakage, I'd be keen to see it. We do populate other entries in 4k size(s) when
collecting to allow for a split of the folio.

Thanks for the review,
Balbir Singh

