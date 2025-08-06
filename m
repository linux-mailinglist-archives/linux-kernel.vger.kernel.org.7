Return-Path: <linux-kernel+bounces-757705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFBAB1C5C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD7518968FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65428B51F;
	Wed,  6 Aug 2025 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bIaMLesk"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336728B511
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482796; cv=fail; b=Ckr2rVRAvcQXuQznH1nwQNdRqV69iV48yHDDx5HzhnTwcw+x52ClxMpoyuCdndgm3VvqJ0CTqezSq2XDJladMJohQOJD47NkWMONtRIq5ZhA6IV9D2mX3n02Mx1e+SC/G/j0PhWOMBNa3HgaCCS2S5hFANmEj6hhHApIuPv4zWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482796; c=relaxed/simple;
	bh=v0TWwH37CiqCV9L1ASQGoEgfrZJvsc6QD3hyAC7Wdm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZL0f2vPW6DN/HwQvhkRQvWgBSkYSDuk3c0sjKdDFWgi0Fhdo28bfseKmZh9K1s4GCy4DYecQoCcXNsbZpV253vn3t/G76Mdhnz/UIGcO+ZT3YY2B/FxRNXoDuJoLSoJ4SoolaxrqQkWIBtz1GWjtIQopCgTSRb5yh+2ORA/h/Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bIaMLesk; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR7qrTh2ga0gsk4t7tlEfW3sXvYp2dj6Q1FJ+xsn5mEM5S2QuWsY/3TIu/S359gM31tdc5xX7xJs85O71jz3icZlflr6lYpUIs++W98ePltwDuHVlEvI6LASbcuzQiP07PjRg9upGtChWdRM4HKsnB+1xltXnZd+Qcp9OAXk+3jWTqNjNpCrr53+T9QPQhe6rOcW3ndkHnO6/rg1F6BcOntlHBywrVSY0P5CRE1nTmmh8AXukMbExAsWrhJWGyeBLS2nnQVi5CzK0F0G4cuR41Tj5gXtgOAKCpQ6JiL3EhzfN2zmuWqnQ8R8zVRH36wSLMZ3QBLy8a6FS+ID516aAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDvWGrB5p8JJ/jCCqRanmyr2m0uaa4oGkLRv2tv3yTc=;
 b=dbxS0Xbv83QzxHIxvZnKKFZuuuGdPDnSxVPxMFjz9ZxVzG2T7b4BTeKZstVuWI2YTKDzjrzAezcmtPKHh5if8meQfJnRO76n5/MjyfwOf1C+WiW3aR12kbNiac8AtbRoNFYBsh1s2PfFoms57IQnwSIMrU5yT18KDWbF6K5hOFWUGDOdHJ1fNIEzdKNqfWjg13X7DiSqkQiO7gJExqAqLdt/gnDQUQDzBislxnb6Ajx/lGQTDMSSIb9JeLUqagTa3aM4Ug5iXoTRq/+AY7u246Qi1i8Sj6qaWatz9H24DD3UhFpzR7xklNLk0qaUENfHFzjfxoY7BNFzqf6me9pmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDvWGrB5p8JJ/jCCqRanmyr2m0uaa4oGkLRv2tv3yTc=;
 b=bIaMLeskGPBfsQ3PzJdfsj5+1aLrqaEHfNi9cUBj7de5eput9uRJCF08iEx1absxzIGfyCTxG/4UB27+H4zgV4HX+tb+/gWiyCcrHtTXpVPtCKOFP0TqlsG+6qdL4fHQlycZdkw1SkQhPtl7DL9Nb340dG+hFbTJqehvrUtAHZ5QyyWc9+YsZcJavm2TlgSLHBAlBpPq8CKu7WLWbiB9w+OL+7miPgVLijyq1qcHLHKia0x1ZWAILm/Pp7LCYxl8k9qJDJrjpirQ01hTT/8F+VAH5PLqRbJr7qgh/a8U3pAEYXBIIPuC9SFKuiXQ6gJAGIydvJT6FCbkoDFYVuYc/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 12:19:51 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 12:19:51 +0000
Message-ID: <0e9db982-3dd6-49ef-95a4-2862be5aeefd@nvidia.com>
Date: Wed, 6 Aug 2025 22:19:44 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 01/11] mm/zone_device: support large zone device private
 folios
To: Matthew Brost <matthew.brost@intel.com>,
 David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Ralph Campbell <rcampbell@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Francois Dugast <francois.dugast@intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-2-balbirs@nvidia.com>
 <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
 <1e307223-897c-4db0-9564-95d76bc3d260@nvidia.com>
 <98a30c7f-8be1-4b08-955c-724667971288@redhat.com>
 <9c0ad782-e1c3-4c7d-bb20-730d2f915dd5@nvidia.com>
 <da283a44-e668-4e88-985c-3e2805b556bc@redhat.com>
 <aJJ0hTS52PVAq1sp@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aJJ0hTS52PVAq1sp@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8216355e-61ef-427e-1a29-08ddd4e38b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjR4YVY2L2diWTRRcm9IalF4V29qaTFpZXgwSEp2WFZYcjJoR0IxYVNYS1pC?=
 =?utf-8?B?VTdjYTlIS0M2bFVSamRxYzNiMzBYclprRnFrYzhERWp1WnJxR21hak1RaDA3?=
 =?utf-8?B?bnI4dFM3ZGd3SEtnUUszWUZHQlJkeU1yOHRxNW1LZktuRWRtRWovOTN5M0sz?=
 =?utf-8?B?bi85V3N1WTlRM1VoVVArRW15NjFWbDI1eUNyOXh4a3BLWGZnY1IvbHhVM21s?=
 =?utf-8?B?ZStSODlYZTl3WHZCV1lFbDFmVjFoQnQ5OXBxYzlpVHNUQ1FUQ2w4dGJhWlh1?=
 =?utf-8?B?aTQ0NjV1cUpJamtQQ21aL1ZFRzJtdU1td0tVUXpHTXEwajM2R01HNHpmYXNq?=
 =?utf-8?B?elU3YWlSRUZ6ZVRzWDlqdU1JQVUwdWpnN080Zy9CZk9mbUZiUjBYcXRkemVT?=
 =?utf-8?B?N3BMZE5udHJHVnUrNzRGM1I1ZStsRVBSWmJiUXp1a0ZiTjJpVUV1NlRRZ3B6?=
 =?utf-8?B?Q0ZsUHZxdEdUVVZXYStTM2ZKSndEWCtFNUZiMTFORTgydWozZ1pIRUd4VDZJ?=
 =?utf-8?B?dUhpRmYvYjJQcnpUcVh1WEw3UUZlNlczbUY4NXI0WjNuUEJHeUhZQzNLbEc3?=
 =?utf-8?B?ZjYrZXBEVXdxblpxdG0zZURLUnZOeElrUFhka2RhbDNoZlZ4NmVPRXA5ZWtO?=
 =?utf-8?B?YTRVakQzb3UyOG5JTDl6VVZ0aUFFVkV0Y0lCRFozVzZTY3JibW1ZSmp2cURB?=
 =?utf-8?B?QlNqZWR5MnRCdkQ4eDBCcU92T3dZVXRFUjhSOTJMZU5aclhieU5iNGpBTmU4?=
 =?utf-8?B?cDFLQldDb2NqUnRuNDl1Qk91STdBNjZabmRhRnFkR1lWdmRCVHNBV01TZEpw?=
 =?utf-8?B?N1JxcnhNWWVvTnVhUGljQW5CNUpOSVJ3Nk9TdlFJN2FzWEJFK2NycU0yT3lC?=
 =?utf-8?B?dzNYam5sMjY5NlRERWowVFUvRVV4eUFQdHBHT0lYMzgvcVNrT3M3cGdLT2RX?=
 =?utf-8?B?c3FXd1Q3eG0rbUhXb0p6L1FCeTZxNXFtMyswL1ZRUFg0ZEFKb0wwcHpadUcw?=
 =?utf-8?B?QTJVT21pZUZtWDBlUVV1RjV5QmRVc3FMRGNFS3d3K2VsdnNIQWJxNTFsMUVY?=
 =?utf-8?B?azZYQU9DeGdPMUVvcDcxUGNKSngxMjRUM2lKcGVlMlVMSG52UXBRZWxNUm1r?=
 =?utf-8?B?Q1BsMzlCUWxmZEZhOWhDZjJyNytlUEhCR0lCeGxRVVJ5cXl3Rm03bTdZUTg4?=
 =?utf-8?B?blRkOElHajVUYThZY1libTMrTlQ5TzZCUUxRUTdiMWVyeDMydlVIV2FjV2NH?=
 =?utf-8?B?VWluVllpVmtNWHJtVG5mYitxbCt4YTg2R0VwRytiWW8vQXBRSEhnNWxqREl3?=
 =?utf-8?B?MDR4Y3NKazBiNmxoWW10NkZnczJZakh4RHJQa0FHOHgzcml1TlBFZDRaRnc1?=
 =?utf-8?B?QU1GUHlCUXhIbTBSK2Izc01PTzZxTktQTXVjRkNBTkZ5bVlpYUtqS2NudTBE?=
 =?utf-8?B?UjQwZnJEVm5ZUHc5R0lUeENzclhwUlhuZ2FFZDFLZXorK0xVa3hXY0JUa0NG?=
 =?utf-8?B?cXFCNVU4R1BLNWtQeFY2cnRUVjlRdTNwQytTYm9yMElqc20yTDZjVGExbjVI?=
 =?utf-8?B?YUZBd0RycVRtc1l2Z2R2M21hVFdtT3dIL1JlU0RlWDUxTTZvL2pLeDdhY21Q?=
 =?utf-8?B?ZUN5V1R3SmcxTU9QeDBDVTF3UTFDVU55cElyMXhhbVhWOU5UWnFSejdJTmE0?=
 =?utf-8?B?SVI5QThTQW41ejF0WEtqUnJxR2h6OEFlaU8yY1UxTWVySzEvQ1c5d3JEaWVR?=
 =?utf-8?B?dnJsTGR0LzBKQW9ERXZRaThiVWRnRFhvYS9aeTBVU1VEMmxML2lVaFNtWkMz?=
 =?utf-8?B?NHFVVWtCM3NrOUVDQ1d2bC9Od2Y5bGE5SHlselk0TFdzMllSYlNiOUhwZmhq?=
 =?utf-8?B?K1FkQmJ3TENwRE43R3E5YWhrOGtqenluT3lCczh0NU1qM1IwK3k5UG1Bc1ZU?=
 =?utf-8?Q?+isYSXp8w2c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm1jbUNjbnFiZlBNcE5wZ2NVV3VxSE1Yd3IvZ002L3FXWkFYcUxhaGYxRG5T?=
 =?utf-8?B?VitUc0hKSno3dno5OWh1eE0zS2I5aWhpaDYrN1QxL3AvTWU1ajdFODVCaS91?=
 =?utf-8?B?WFNrbXo0M2dMQmNwdDNseGhMZUIrNzlEbitvanhLTE5xakdaSmhxa3E4aU5F?=
 =?utf-8?B?UERZeVZWTFl6dTMvdEhKSmtlKzZ0dVVoYjNEb3QvNXE4TDNkOUNwR0N3QWo5?=
 =?utf-8?B?MFFtU2hIdTVVWVUrZktYY1BjQmdlMENRVGk3Tm5GajFqcmR1aThiZWRJZDB2?=
 =?utf-8?B?M0hMb0gxYUx3TUR3YTVBUXpySXVwbklyaS9wbk4wN0xKZWNuZjkyaHQySWMv?=
 =?utf-8?B?YlhlSC9qcWZzTGdqY2lXZkNJaUpiSDBQekRMS3BYODg3akxHMGhwUDUrQTdx?=
 =?utf-8?B?WVJJZVVkLzQvaE95dEwzL29vUHlWSGFFaUcyNGh4SkFsbUNSVVZxSnF3RjlJ?=
 =?utf-8?B?N3BXekVKbnpJNDhFUG9GK0plWFNUcTFtNTFMQVFUMnJidUNnZkxBTThtdnhn?=
 =?utf-8?B?TEE0UTVQUGdEckVnWVRGNTl2UnhqcThRN0xiNXh5MGdLemp2RS9IckNrV2Zw?=
 =?utf-8?B?R1RpK0NEc2ZOOUZIN2Jmd0hzM2cyaXZoS0tiQUdiM0h3eWJIUTBpQTY0cDRw?=
 =?utf-8?B?MHI0Rm9CSE9aUU0rYnovenJXQ25PRXZlc1RYNVlObWQ2TXd1UXdIVkVYdVpZ?=
 =?utf-8?B?bWdaSnJVdS9PM0RrbXI5ODUwbWdHQ3F2TmVMMDgvS21kL1pBaVNmZ2xEZWZ4?=
 =?utf-8?B?MU1MbytNZ0ZTVVdQN3hIbFgwM1Roc3lOUCtnZjBiRTRBbHg0NXY1eHVWemJP?=
 =?utf-8?B?ZGNIcnhlZ0dLRGRPRVoyV3dnbndPaUcyRDNPVDlGdXk5MlZCNHBRUTdaS2hK?=
 =?utf-8?B?TEdObEIwMjJEQ1NLMDE1a3RQcWZEWnZxN01sRm1MdDJKM0txL1NaaUE3eXhX?=
 =?utf-8?B?YnpNSG5ycllKUFJEcVk3aW9IWWNheEs0QW80WjMvWEplTmxhc1EwVmVadmNU?=
 =?utf-8?B?a1lTN3F3M0FwODRaS2FwZ0djSlVKR3VOeVRic1VXaXMyTlVtdkprM3FjQUVy?=
 =?utf-8?B?OVJ5MzlVL0w0bnRZUGVORDdQSHVVdVh2cFBlS05SUkZFaDZnMEtEVkJYcFdR?=
 =?utf-8?B?UjR3LytjbXl3anFTYzgwekFVbUsxQnNRMkZKQytUN0hhdFowN0svRXlFVFpO?=
 =?utf-8?B?R3BZQk05RitrSW8yK2F4NmxPYlJCV24vbnVmNXBvSWFSekovM0tEYWVGT3I1?=
 =?utf-8?B?aDY5VG53TlA1SEZwMGxQbEhiUFlSZDRITjZzdWprem4rT2V4ajNrblltemhP?=
 =?utf-8?B?MGpjUnRHdmJOWGxYL3pacXR3UzhrOSs2eFBGa2VGK0tEeVJ6b3dPRVhSUktS?=
 =?utf-8?B?VGdxSUw1bSszWXpiemNzL0FnTE43SmJZRGZOcXlPc1pVWUFXV2I4ekdRRXpH?=
 =?utf-8?B?dDBaRUI1SW5Qc1dONWpPUVdWRllOdmRJdkNLQWRtdFVRbWc0LzJtUm5MbGhW?=
 =?utf-8?B?a0ZiUjl2S0owbHdldXBqT1lhMWo4eWtLVkJKUXl3K1ZFNWQ3Y0crNzhnV29Z?=
 =?utf-8?B?Z0FpWUlkNVg1WDdLb2U3cm1uYTJWK2ExQS9JUXRXdXBKMmhVb1RBMHhrNzlm?=
 =?utf-8?B?T2NpQUpveld5NU5rN2VkMEROZ1M1NHdYMVc2a1JsczlGWkhvR28vbkxHYVhl?=
 =?utf-8?B?YW1UZ1NWdnViVUh0cUZIZC9uUGhveEpyNDdIdzB2TEs5bXYwcWNhWjZhR0Nk?=
 =?utf-8?B?M0VCS3hPeFNFRmRzMVk5RFlNVXhkYTVtcDNoSkpya1dGWjVXcFlMay9XeEdm?=
 =?utf-8?B?Z3F0V0RPN0QrUExJQlI3aStzNHZGa1dlbUkyZzZTUGFIWGRqelJkVVpqMDht?=
 =?utf-8?B?ZExuM1NRVFRjOWZYcFJ2S3pycDI5ZFNDVFdYWXp0aGtLLzhRWXROS2hpWFBa?=
 =?utf-8?B?ZUV3V1NmNnRFUVpQUVZlMGNMSnRpN2IyekxtMWhDQ095a2luWVJMYWRZSldu?=
 =?utf-8?B?RmdDUE5NYkx4VXJMdEhpT21MY2NDbzc5elIvd2dUU1lnUmxXWDNhbFJUL3BO?=
 =?utf-8?B?QUVWeTBDdUpqWXRlSWhhbjBiTERZSE5JSlEwRG5YQmF0VHdrRE96Uzc5Q0hK?=
 =?utf-8?Q?dwAgbBhgWHWoGHqIqqx0E4+Tx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8216355e-61ef-427e-1a29-08ddd4e38b21
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:19:51.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDFppJj/Csh1ZlfjhMSXUWyuE6y5acqbfv+Uv1wYIL5Epm61wCE+TxvAFXk05/cIAZ4j4LCPG3DJxTUeAHs5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784

On 8/6/25 07:15, Matthew Brost wrote:
> On Tue, Aug 05, 2025 at 02:58:42PM +0200, David Hildenbrand wrote:
>> On 05.08.25 13:01, Balbir Singh wrote:
>>> On 8/5/25 20:57, David Hildenbrand wrote:
>>>> On 05.08.25 06:22, Balbir Singh wrote:
>>>>> On 7/30/25 19:50, David Hildenbrand wrote:
>>>>>
>>>>>> I think I asked that already but maybe missed the reply: Should these folios ever be added to the deferred split queue and is there any value in splitting them under memory pressure in the shrinker?
>>>>>>
>>>>>> My gut feeling is "No", because the buddy cannot make use of these folios, but maybe there is an interesting case where we want that behavior?
>>>>>>
>>>>>
>>>>> I realized I did not answer this
>>>>>
>>>>> deferred_split() is the default action when partial unmaps take place. Anything that does
>>>>> folio_rmap_remove_ptes can cause the folio to be deferred split if it gets partially
>>>>> unmapped.
>>>>
>>>> Right, but it's easy to exclude zone-device folios here. So the real question is: do you want to deal with deferred splits or not?
>>>>
>>>> If not, then just disable it right from the start.
>>>>
>>>
>>> I agree, I was trying to avoid special casing device private folios unless needed to the extent possible
>>
>> By introducing a completely separate split logic :P
>>
>> Jokes aside, we have plenty of zone_device special-casing already, no harm
>> in adding one more folio_is_zone_device() there.
>>
>> Deferred splitting is all weird already that you can call yourself fortunate
>> if you don't have to mess with that for zone-device folios.
>>
>> Again, unless there is a benefit in having it.
> 
> +1 on no deferred split for device folios.
> 
>

I'll add it to v3 to check that we do not do deferred splits on zone device folios

Balbir

