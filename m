Return-Path: <linux-kernel+bounces-855951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A314BE2A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29AA950424E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205731CA7D;
	Thu, 16 Oct 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LpB/STzd"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2D31BCA4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608772; cv=fail; b=sAjS7w8FUUfw3dP7RVfRt4LEjTY0yijsUecNC0UrTLdlevRn4dc4IE3cn9nT7jUM07fuV4hmoyCodbuIIL7aykIN6aJ/vjwny+d2ejCo+rY8MxiZNS1384FC4JBz0aChv3+Ur9aNMUEnnRBA7PQbuj73nC3+Guu05p44akxGtnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608772; c=relaxed/simple;
	bh=poKKx+3tfpAmxDORBrHAni+OyKURbo1ArRbVzFegdcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eTSDjAerE8KS6dcx/OOtXJJuOODGaCqZaLH+xe3YtvMZT1WRhgGLwN9HUub/TwmCa/YO1D/gh4/gLVjVj5jkIDN3OQx1q3Toi+b+eK3l+5aXVRSMXpN/UkcVCjY36VAcz+7/zkRbJvvaAjKeL9PDzKOj9kibg/rEoaXEQcS7QwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LpB/STzd; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkmcP7YMTxWo5k4+uKtm5KwmuHV7skILQxBvcpRHIZVNm/E2/W5KozT25iUS3KwDagNHVGf+QgngaijFwAuGagw7LZOZi0JJ1M5Pi2ixiNmy8KsvRdonLrTOaifcUFx/mixpyWcvxEFoswuKdEjJMfpM/HvXGwW6LImCPAMxD1K9krcQAul1ffPfKROzTcG8+RBLid+DH2gVW0jmkRK6kIfYGY/+sl0iF+WtEpC42XiUJhOfcvOAC3pOmQSDr9p6G1dpNOl7OmAGzhDM0jsRXWcyGmuXzL9v/ov6X63KfL2U0Seb1MyWHbleJ73KbgxsqE2c3AZ6Y6Sub5NGa7O6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLV7gdS4iGo8F4+wZE3Qwvzadl+Pi7B1Jhu50b9yPIM=;
 b=pOD0EROzedP1pg/j63Tk1EVOV1+ck2GdQqsvyYIJmtGyUxdeW2rBnRDqcOkqhrKEO5zmStbYNax29hGpyZfU4gPBfxalIDK2JdLewZPnYg24oZNY+kogzUpoRyRf3f7Qm7/pXOfU8XGKTde6u6PvxcHHZ88ezMoQdcjts1IPjsqPq6De+RbNUareF3AgaWeFDIHkt/xmXCwJhcig69BpkZGg/Kvkc8es8M8A1+KEkMyYcWVzUZEaxGQv5xU0muMk9dHquJ1ED853/0GlP86w9xLEw15WQjZfEsLGsoVhTRwMl8+Ny/wjjIzrabu+uHI/WwHRc37/bx/PxPkSceb6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLV7gdS4iGo8F4+wZE3Qwvzadl+Pi7B1Jhu50b9yPIM=;
 b=LpB/STzdGgO79zV0X8piznur2rBLFM4E4ax0n5QGlIn7RBVCtsItsI2WcGfryUbFRU0ez8hJSuLtSs2xWRG5Hm68gECQatRLvk+rYhbnFsnbDO/6Dj6Gtbug3ESHmr2brrdIKpGcKI4scdZQZOElHBWxagCU8yR73UbLODxBOL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 09:59:27 +0000
Received: from IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823]) by IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 09:59:27 +0000
Message-ID: <693936c8-f554-4c1a-a140-1971c3152713@amd.com>
Date: Thu, 16 Oct 2025 15:29:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 7/9] dcbm: add dma core batch migrator for batch page
 offloading
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 willy@infradead.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, vkoul@kernel.org,
 lucas.demarchi@intel.com, rdunlap@infradead.org, jgg@ziepe.ca,
 kuba@kernel.org, justonli@chromium.org, ivecera@redhat.com,
 dave.jiang@intel.com, dan.j.williams@intel.com, rientjes@google.com,
 Raghavendra.KodsaraThimmappa@amd.com, bharata@amd.com,
 alirad.malek@zptcorp.com, yiannis@zptcorp.com, weixugc@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250923174752.35701-1-shivankg@amd.com>
 <20250923174752.35701-8-shivankg@amd.com>
 <20251002123831.000000f9@huawei.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20251002123831.000000f9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0059.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::10) To IA0PR12MB8301.namprd12.prod.outlook.com
 (2603:10b6:208:40b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8301:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c6cbb9-5ee3-477c-8c07-08de0c9ab162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU9ldW5wZVcxemJ0SW1GTHk4Ymg4dzB0ZzRhV0VkWVJzdWY5VCtyQ25nN2RN?=
 =?utf-8?B?V3BRTlVEeDNIY2Q2Qk1GL0E2SmpPaHl0WUFqZ3FVOXd3YWhzTytFUGQ5c2hh?=
 =?utf-8?B?YkJWSTdYaVRTYUlWZk1yQU0zMG1SUU9nZXdXd0o1cTYyQU9jb2paOE0wSUJL?=
 =?utf-8?B?WUppMFJDWUo2Nk50NVQ0dTQzZitiL1FudlV2Y1dPRnJPUUMxVDA3dnduN09D?=
 =?utf-8?B?NFpYaHZZN0ptZFBiZ0RvazFyOVNYRzFLS2VlamtMYVoyZHFzT2ZUK0pXdHVF?=
 =?utf-8?B?RFF2UFVYaXk0THp5QTRWbm9yTk1DTytISTFLUzNpaFRVUC9NdXRKdzBsdFNR?=
 =?utf-8?B?dlZRQ2NEM3RnZ0VMTFk0dDBPd2RjR3FZb0hMRjlDQmw2Q1l0RGNYc1Z6d0hh?=
 =?utf-8?B?YUI0RmpjOWJpN3Y3cW1aQnhNSzc5WGJYckhzaWFOQ0pVd3Y1NnRyb21HT0Zm?=
 =?utf-8?B?dUJsL1FzUjdTNmZ1ZE8yMTR2ZVBqTW1ielk2R0pRelNHRmhyZkZGbW1sa29r?=
 =?utf-8?B?VzcxU3ZjYmFpc2VBSTVnblpTWm5jVnRxSmhxaWx0SzhSNGlnbW16bVZCT0dj?=
 =?utf-8?B?U3NIVnJyT0ZRMUJzdEtmT2YrQnA5VUd1M0FwYkt0cFU5L1h6VlVoT2RGaFV2?=
 =?utf-8?B?MEZYZXFQTUZKNmhBd0RoUmJYQXF0a25HS0JQT09ZbEI3SEhOZXJkYmZoRkZq?=
 =?utf-8?B?K0tUR3RDRGptM3RrUFYzMW80MjF1MytBdUp0eFlXT3pIOEk5eTgrd1JuUXU4?=
 =?utf-8?B?dk51aHZXcTdRZVVacnExTlR1N09MVGhwdjE4ZlVUeVdCZjVjdlZmNDZZMHRD?=
 =?utf-8?B?K1ptR3ErbUhkMDlEYXhobm9Sd0VFWStaZXkrOVYrRTlOaExYL2JZb25qcXRo?=
 =?utf-8?B?NS8wVFNkNlNvbmVSMW9tQ1dwRDJxc3RieGxxWUJkR2wwTm4vNUJSZTg0aXZ0?=
 =?utf-8?B?bmtlR1ZJYkp1SU12V2lNMWtZcDhlOUVGZFhiNlR0c290UUIyY0t5UFZqZHM3?=
 =?utf-8?B?UTUwcU13VGE5Vm1WdW5aQmh6M080bGFTZkxQVS9COWdGZXY1RVM3M2FHbHBo?=
 =?utf-8?B?emJXUnB5UWZIcHpvcWVNQzdYbS9CTHJWWjNRWkpYeXl4L0c4aStwaWpNN3dN?=
 =?utf-8?B?YVRlMmljc1FHV3dYNHozbXJxRWNIVFY0Z2NSV0xHd3BtSnB6WHVmWFpLMEZp?=
 =?utf-8?B?L1k4K1l5NGNHOHhybDBobHF3VDEzUm5Gb1BLQm9ZU1dhanplNWwzZjE0MVpP?=
 =?utf-8?B?aWRMVks3bEVRWUVST3BaanZjZ1U5eWRIeHdVeFJscXRUK0dmWXpaYXBmU1Mx?=
 =?utf-8?B?QksyNkorVWlqNFdsdW5OZ3kwc2FPM2s0MTdUVEFTbXFkeDRxeWIwd2pLL1Np?=
 =?utf-8?B?UmJsa1ltNk5UcGJkc2ZoWDFRMWpXTUhxcWRWR0haQjhwaVB2Z1NXM29xZ0w1?=
 =?utf-8?B?azlEK0ZjUFR3eVFQMERpcVQ0Z3FEMURiNGEzVzVOVi9ndy9BNjR0S091ZS9C?=
 =?utf-8?B?THhETWlsSS8xK3VFSVhybzhXOW1JSDhBMCtObnI2SDVxVEhTRDRHU2M0UzAz?=
 =?utf-8?B?NGNrN0dmT3BKNlQzTEovQ2tQdFVZSVhwUmhaaldIRFViaGFLeGQ0OFRvd1Er?=
 =?utf-8?B?eUlvMkF5M0lzNUJBRXhrTzcvQk5kWGp0THdJS1RwRFh3RE9rVllyQkc5THhi?=
 =?utf-8?B?NFdFOFpFL3FvQlBacWg1V2ZLSFl3UWsxeWp2eGl0ams1U1JOdHZYajU0aTd6?=
 =?utf-8?B?TmFUOW9QcGF3cXhQMHYvd3BkS0VsMisvUjV0T3UyanRzdENwbVAzbENNRjR0?=
 =?utf-8?B?T2FiT3YrdHMvK282S1V5bS9FcGJTZGZBd2c4TWFEYnE1MXg0ZE5LdmhLYnU4?=
 =?utf-8?B?aThpSytVTnRTNDB1V2hBWXVabGo5WElxN2orWVB5NTZKNy9PeTBLSkZEMmE4?=
 =?utf-8?B?aHJjMWJWOFVLU1JSR3J5V0EzRjU5dTU4NVpnRTVoVHF2NGh3Z1A0WFNMMTNh?=
 =?utf-8?B?d1h5OFFOdFhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzdIQTBpd1psMlVhOGpVZnk3cTkwTE9tRGhaSk54Um1HU0xFK0pUTzVodDhh?=
 =?utf-8?B?SGN2RnVudHlVR0FaOTBCbTRmZXZuai9WdTdCeG9mbFlDUytydzJRQUdhejVx?=
 =?utf-8?B?QytFVGloeHJzRkNZMGk2UzJKeGVjUFV3QXlRN29HQ0JGRXBBa3F2WEoxTUpr?=
 =?utf-8?B?YVgxaVRJcm82Y2tQVC93NEJkVWlya3RodE8vRm5xUzdTM2p1RWgvSDdlVWQ4?=
 =?utf-8?B?S0lPNldvS1g3VWlNRnFlRzBjTWZBVjREVW9WM1A4S1RFbzJqOFU3N0lPL1pY?=
 =?utf-8?B?WFhXQlYxVXIzc1dzQjYzT2NVU1QzazZyMEJFeEw1c2NCa2NjZFhRdjZIS3hk?=
 =?utf-8?B?czAra0sxblVrMXIrZWd3cGd2bHR4Qmw4dDhCRHR5VkRmU1E1ak9xN3JQeUNj?=
 =?utf-8?B?dFZLRG9TT3dkMzFLK1Z4dHZOMTlsRW5adGZNNGxaWXZHZUh6KzhXaXNLMzJv?=
 =?utf-8?B?cDhnRk8xMjA3Sy9raGlzK1NnbzRYeHNjUmZQU3paWEFGZyswSXVKN3diYi9S?=
 =?utf-8?B?aXcxVklVc0xBSCtZc21Tbk5xODAzWmg4RjFGV2RqdkZSSE9vR0tDYmpCTHNI?=
 =?utf-8?B?bGFVRVI1azVZY1hqM1ZnQVdyeHdGL2YrcytrUy85Z3ZVYnVGRmpQMnpZeVRG?=
 =?utf-8?B?VUFVS3UxaXByUEs2ZklEKzdIMjlMNkRRaHlzeUphbDZ1emhBK1d5MFBvZCtq?=
 =?utf-8?B?SFBhTFZSNE93UVhxRUl3dml3cnQxODNoak1iTVZxaUZoT0l1V1lrMGJvdlFO?=
 =?utf-8?B?eGY5UHlhNmpkNW9ublhFaXB0TGM4cVRoU0lpdXQ0V3FuRDljaWhMSGg1WUc0?=
 =?utf-8?B?T2JpcU43cC9GcWFDemZIWmROcmtCSmovVlFmSnE5REJFL1FnKzQ1RkNIN2kz?=
 =?utf-8?B?M3VQT05SaG9GNWxOTjU3YmlUOEx4TkVqVC8wTWdqbHoyUGs0RkI2enpDVGRB?=
 =?utf-8?B?bEtVL21NdXRiVnFrbXVhVWZWalNqRS9jSXNTamhhUFl0bitDYmVweHE4K3JS?=
 =?utf-8?B?YURGQlZxZ0dLTVE2WXNlNHJ3eUxIYUhNSFVsaG5pQnBrQmdNaVIrVlZZemRI?=
 =?utf-8?B?N1poOTNRRjV5WUtPaEpEUXhyMTNSVG94bk5zOGNjVWRORnd2b0hNOUp0VWR2?=
 =?utf-8?B?Y3dUNThCeW1qTittQU00a09BR2pWWHNZeis1a3AraGNsMCtITWdRLzlvQzd3?=
 =?utf-8?B?cHpzd3ZYYXZpZUFhbWtnT2tXOWRrbmYvcEFKUzNKeW9uQlFEYm04REdCY01N?=
 =?utf-8?B?SEI5cWJDd3Vjc1lxK3RhcDAxK3hJM0NralRhUG1DM1RBRzg3RDlqb0FnUUpq?=
 =?utf-8?B?UnFwYW9tZCtHNktiMzYyWlk4Zkt5UjR2QWhlekJsYmEyUEFHSFFYUnQzT0JC?=
 =?utf-8?B?a1JQVDVtQUIzRFZWQkxVbGl6ZDRjeUpmeVVobTJUd3h2ZXljSWZXQm15VUVT?=
 =?utf-8?B?cHdOMDRXSjdiR3JyUlBKSnlZa1FJcGpsMXRGWjY1UjZHR3ZJU3FvZUs2dStX?=
 =?utf-8?B?L1A0eWVkRU5xV25LS0Y2M0libTQ2M09kam43a2N6QkUwWEdZanM0ejVQdURK?=
 =?utf-8?B?V1loZ29hRVNGRW0za0REZ3JZZlFKSWFDNTJTMzlIUmNwK1NNVElYT0t4VXRE?=
 =?utf-8?B?alpKVFRPbzNrUFFEZm1ialhDSE1qbnJ0NC80Zitjd29kaVkwNHcwMGFUWjJW?=
 =?utf-8?B?ZUVWSUk5QjhoTkVtaE5CVlIwcjNHdW92TUJWN1JpamFFMDNIVlNrb1E1TUtJ?=
 =?utf-8?B?eUxmOGRzd0VUTFgrY3FSUFkzSE5TZXZJZmpxMTJPTjdlZjdlMURoMlIvUDZi?=
 =?utf-8?B?ak4rNXBHdmlKS3lrbThhUjV4TUh6TnNXY1grNTJtblJTUHJrdlRJUWpJRzhS?=
 =?utf-8?B?a2laRXFCZlJRSGF6V2xOcUxoMlhIMGJ3V24rc0RSL3RPQW44b2thb2c1OURU?=
 =?utf-8?B?Y0tFKzRERGxNaVZob28zL0pMVUJ0STl3U2JxWkFjRlUwb0xJY1I1ZmlXWS9z?=
 =?utf-8?B?dUpaU3RZeFBxeUlKSEpzeWVIK1lSZFY5REg5RGdqVmc4MXpQSFRaZFRDT2ZO?=
 =?utf-8?B?S2x5VWxSeDNwcS9CS3BTWTNCYTA3MUVGMmRKN2k2MW5wc05Pc25EYkNzcVhD?=
 =?utf-8?Q?khoHZ2hf12ppu36jx6hHPtEuc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c6cbb9-5ee3-477c-8c07-08de0c9ab162
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:59:27.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDFMTjq5vMjIWmQeG1WaiM4YkmYsgeyr4gYwE6lWmsco6VXqtqS+cEwtxbpz2x1nT1dvof8OT7Wgn6OhqahoCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552



On 10/2/2025 5:08 PM, Jonathan Cameron wrote:
> On Tue, 23 Sep 2025 17:47:42 +0000
> Shivank Garg <shivankg@amd.com> wrote:
> 
>> The dcbm (DMA core batch migrator) provides a generic interface using
>> DMAEngine for end-to-end testing of the batch page migration offload
>> feature.
>>
>> Enable DCBM offload:
>> echo 1 > /sys/kernel/dcbm/offloading
>> echo NR_DMA_CHAN_TO_USE > /sys/kernel/dcbm/nr_dma_chan
>>
>> Disable DCBM offload:
>> echo 0 > /sys/kernel/dcbm/offloading
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
> Hi Shivank,
> 
> Some minor comments inline.
> 
> J

Hi Jonathan,

Thank you very much for your detailed feedback and review comments.
I have incorporated your suggestions and updated commits are available
on my development branch:
https://github.com/shivankgarg98/linux/tree/shivank/V4_migrate_pages_optimization

I will hold off on posting the RFC V4 series to the mailing list until I have
new findings or other substantial changes to report.

Thanks again,
Shivank

