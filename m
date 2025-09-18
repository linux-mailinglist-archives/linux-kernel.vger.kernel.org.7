Return-Path: <linux-kernel+bounces-803111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20919B45AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70989562EF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A893705B9;
	Fri,  5 Sep 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZsz4xXk"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB573705B2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083029; cv=fail; b=Qzm/JbDm8PZbFN/kj2Q+lf/70uVZYK+jvd5tSExgWxBmWPxuciahtwUMcKju8cDc0gDWtBrNTV4oxUoq3yth5yuDr1L/lnT8x+JA3qPiqxO1DPoFAjh/kBYB0EPMZ8qqQ7sNefp5yUC/B1aGeHI2NUievyAvuHnTy1NHGCV1WGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083029; c=relaxed/simple;
	bh=Or4xF8L3RhDZl4Kaju59C3sYTnJTec/V6nJXsNglO2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spgCEVj1Tbv0uPtDO/xifh+7wS3db1Q6xsjO7S9+Nuzne+8rhRTI8HPjzEzMfp+jipWyVTbHOotEdlJWfXgm5dX1MOrgu5xFA4gtisyeXK8BYikUtdlDpHLHqh77LN33JWPZ/6R7ierXSuoev9BXyj5DvGFN3jFTa1IIEOLFtfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZsz4xXk; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hupqjeTLv2XzIC5vIaREM22p7UARyDqPRnF2/B076hnThTFegaY/i6+EOTRP6aDvUQBWfsO/0ka410/P2tUL8lZjUSB741vXhvJMKomaIFoNzAsSv/ElPdodjSlgWmkJ8OoCGtNMCs7xMMmYf5knv67jO4O46a8wEMnDy+z3UJsz2PCyvqW4kbdn2YoGTcD0DaV2Za5DqBJBQjTrU11QyMQ8Ych5Z2199zZzDEVFy9O/6m8DtaqGEP75p8AJy3wCZ55nsWvloHb4EGMUC6GbgVriSYDv+c8XGcS3BYwtn9+gJKd8LauELjwCRzxw8MhU18Eq+MGB8J3oN0Kswm5qVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+PafKmOsQ6fd2MLdnkIXx4MDQzDUZZ5XNlvBGVEizA=;
 b=irtKSNoP8uaAvR9DBrnWLNsNqMkDnssw9g51/HpA37FkEnOfmGC9Vs2GCV7TPaB93YZxRm7drvlD7azCziYjEB1PqPUB43m4f2CFhTXrVu01ac/sI3FyDVmmf4yZl2gJrq+7z6I2AP5IxoBL2YE7pqfVRCWPhXs7a4ah10COuT0hvVAh6G3K22ak1wZTS75APhghr3T0+rW0CzpPuKKVsDtn4rcX7hcgnr04qMdEhFG55ql3TyC3nXCcGMp/qvE27eoOzygs1F63P7nXm/tjNkfQM+Leu3juC3ZnqCR2wJZt//u9enJ226NmHI6bJayyghXrISzNq0i2t/OTTGsC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+PafKmOsQ6fd2MLdnkIXx4MDQzDUZZ5XNlvBGVEizA=;
 b=lZsz4xXkDx9kLx7vj2tLL9Oz1UPNH5L5Mz5nqVEVy0CO2DAG638tIbjPCxbzCdAmZ3N9coVCOnedL+grStWz+gHRAbEvhphBfk7DqCOTn5GzzwfD2vvHjT4mFDRaJBaK4FaqgUP3EnLORo/aM1UGnNx85Yh11nFcwvPtpMXQQ1LJfjvvfeEwzfAPhoIlAfGQ/Ypa72KjniaP6Cp92xF50XJb1NEUdolY8DpdKiKmMomBKE8UgsmHVJYL+1y5SbK1kniapJMZOs2zihUH5IVLV2AgpK/RfE8ybzHeFtBsdSDMJNjW1lzS70zVOr7OIWy78ZnA+gM5UVsM5IW7gUQlsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Fri, 5 Sep 2025 14:37:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 14:37:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
Date: Fri, 05 Sep 2025 10:37:00 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <7B0B1E09-5083-449F-851D-FD63D32D2B3D@nvidia.com>
In-Reply-To: <20250905141137.3529867-1-david@redhat.com>
References: <20250905141137.3529867-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c57d8a-9179-4cbd-ba5d-08ddec89addf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3NoWkVaUFBVVTk4WFZ1VG1PZlQ4ZjA2Z1ZxRXplMm5ENXl1VXFsWnF2NDRr?=
 =?utf-8?B?alQ1VWZ6aHg1c0RScmNwcjVVNW02VDdvcDRMUkd6QmI2d0JaZVpLRC9Lbk1j?=
 =?utf-8?B?UWFERDVGc3NBd2JpQkxOUGhSUk9PODhCRmtoTTlRR3lJV3BNZ1QzUE5HbU9C?=
 =?utf-8?B?UjdUeEJ5eFU0YW1EdnR6ay9EaDlsdzVMcXB1Q2RQejkrVHBkN3hvRS8rVHV2?=
 =?utf-8?B?YTdrTGpZTjBiZGdWN3cramN5VFlsMlE0QjVQU0JhZTE4ODdXZ05Qakx6NFdp?=
 =?utf-8?B?eW8zRVRQVTRTRVlRWnpRQ3YxMmJ0TkdTSDBMbkhzNnZPelRjWXBqWktxdkQ4?=
 =?utf-8?B?amswVm5KOS9yYjBmQ3NjNnJackJQcFcybm5XRk5QQVdDVXNXQkxaWk5UaTNV?=
 =?utf-8?B?bG4rWmNwREo1TEMvY2tzT3ZGZXJEQmd3eEdmTkJvSDJRMFhlZCt4ZGQxS2do?=
 =?utf-8?B?K1Z5V1E2MmNtQjQvSFpoRXk3Z1VZb1c0V1hac1UyU3UxaURXb3JSdVR2bkJB?=
 =?utf-8?B?cXFhQ1dGS0UyWU9VWDZLcVBKRmFmbkNUaEp4TEpIdEpmbStpRmhLdWVrbXNy?=
 =?utf-8?B?RVJNaTRvN28rSGVvYWg0b3pPcXBVck8rVlhmV0M2a0JmRDd5ZFp4MkFlM2c5?=
 =?utf-8?B?Sll2eTFpTC9OVlRLTCtVMXRnYW95L2dqc2t1TGVwditac2ZFMXBwT3ZhdG0y?=
 =?utf-8?B?QkdPU3RMaDE2MERMaXp1OGQ1S2grM2NTVHlTWXAzenY2UzQrVzJVQWpUSzRy?=
 =?utf-8?B?b1BWdjJ6NDdIZXZWOEN2VUFXcStIOEllTDVPZ3RLM3owazQ3RFNNNm5FcThJ?=
 =?utf-8?B?bjdpMGtBYmdNU2kwTEFxS1RsdHk2b21DZVVkOXRVeFpRcmJsS252R2JKbHkx?=
 =?utf-8?B?N2JEMG85Q1lKZzdXcFFNL3ZZV2tYbFNQcllqS1RLT2Y2L3A4eVpHbEU1QWZY?=
 =?utf-8?B?Ti9CNXZHUjVudkJrRkFmT2FZbi8xZktmSzBpS0RKZkRQa05rb1lGb1IzSU5K?=
 =?utf-8?B?OWJwWUxFZmtnbGl5NTlIb1JDQWNNN1Qydk9DdXoxemRJMDRrTENtWkN6cVhj?=
 =?utf-8?B?d0hIaVFzZDgydUVNdmY2QXFYdGExZ0FHK2xkcEUvNUFGV1JENjRwSHZFT1Rj?=
 =?utf-8?B?NWt6WmVwUkxsL0lORGF3eFAyV3ladHBoK3BsamkzNHJ1Yzdobk16czJpaTB2?=
 =?utf-8?B?YTViekxXVXRyVlMxU3MxMDNsTGhNd1dCVG0vRVdTb0xvYjBMNXRHQmpnU2lI?=
 =?utf-8?B?NXh6czNCYlFrU3BkZk03NW9qT3V5eUhkemdiSGVOd0ZaU2QzUTRmUVUxeW9Z?=
 =?utf-8?B?M1BSSUlVdTJ4dDI3TTByUXJDMFBPck45QTdISW9PZ3lvZ0EvUmdXK3B1aXNw?=
 =?utf-8?B?bFlGTFZMRFlHM0xqaUNHaU43eHVJMXBPeU00Z0hWcEg2UTI5bjVsZVVuOWxh?=
 =?utf-8?B?NFo1YUlnSk1sYjFoamJBT3Q0ajlTNmVWOTR6RkQ2T1JlZG50ZEcvdVJoYVNO?=
 =?utf-8?B?eUc1WWpBVys5aVRUVGd6blVaYVBoczlBc3R0R0VzTWtQVFJYVXlaUnNKQVl5?=
 =?utf-8?B?VC9uNjJmUTRQckEyTlFtZXBDK0NZa25tdmJ1YUJOTTZ3ZThjVG9WS3ZJS0dD?=
 =?utf-8?B?cGNKa0RiUjlqQTBVeVA0QjR1L0piT2x1TmFsYk1WcnRObW5pZlZqdmt3RFNz?=
 =?utf-8?B?MHJxS2k4WmxTZXF5cVVKNHE0YlBnZllHVnpqWEJ6STZ1N3dMY0daVVFEZHY1?=
 =?utf-8?B?U1dSNHlMaUt5bUJwbWJFUmJmMkhzQUR4NEhIb2lEOVhwbzdlRDQ3OVlnWEJ6?=
 =?utf-8?B?YU43SVAxVlZMQkRHNGlBbDFGSlJha3N6SnlCZURXNER1U1hjUkxRdFRkcUY3?=
 =?utf-8?B?Y0hCOUhFOG1rYTdHWXgxd3R1TzJ5dHk1ZmhuODZJMWt2aStXb2pPazZDUG1k?=
 =?utf-8?Q?REtEVU0RKwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1FBZFlCN2tFdE0yT01XMXROTm9ycm1YZHFzRnBtNzlXNENFMkdDRUIvS2N4?=
 =?utf-8?B?blJjVlV4bk9NRlF6ZW11V2xOT1JHOVRGTUFRK2FGVVFmYTkvbHNmTHFvU1gr?=
 =?utf-8?B?U0VEUlJocElvc2drODB3ejVSUmpmSmNHMmpwRGxHR2pJUmI4SmRvUTRxVlAv?=
 =?utf-8?B?VVloRVMwQ3A4dmFIejNOcGpkdklIZSsvSHNQcHE1MFBVVkxjTEI4eTAyWlFC?=
 =?utf-8?B?V1lERGJIL1hSUCtDaFd5ZU9XY1QwZS8xNGpvSzhIbGMzdys5dHNqRjRWQUVO?=
 =?utf-8?B?cUJVaHVPcWJUS3R0R09CNTRQNXdwSlhvdkZXM3l3MGFOcUVEcGVXajJJT0N0?=
 =?utf-8?B?RXJtQkZJRXpaQ3l0blcrdkVUaUhJb09BdTI5SmJaZXA4c3V2ODJFcE8yUUg1?=
 =?utf-8?B?NHMxU1RnSVZMTkszbnFjTzRkNlZaMXA1ajhiN1NvbDh5SmtaSmlZTXdPMDhS?=
 =?utf-8?B?b2ZaazhKQmlnT01mMFNzL200MC81LytHVVF4SXVzUisrT0MzazZnd2FjUS9T?=
 =?utf-8?B?VWtJb3RyZm1EQWY1K0taNVQvNUhuOUtMRGJYY2Q2TTJGQUtzZitkRmJDSitR?=
 =?utf-8?B?dXVCVHlCTHNjQzdRaDRsUVBpWVZRbk9UVklJd1VkbklzVk5vYWd4bmFxdnBz?=
 =?utf-8?B?d2NzSUYrbUlCZTVjTXRjQTNPS01JWDgySGVUK0ZpN1V6cDBHUEwwbXh3WWls?=
 =?utf-8?B?Q1ZFSVVaL05kZ3dBa21rR2hZV1g4VE8zTjlaaXZrdFB6YUkweXl6NyttTms3?=
 =?utf-8?B?Q1JtVjVVYVNZeE5QMnJuMHhzTUFmVWIzOXJPY0pRS1ZIS0MrcDdKQXpWUXVm?=
 =?utf-8?B?NXBsMXpleXVZV1BLeWRiR3RZT1B1N1Z0dm5lQ0EyQnYzN1dtSkNRYjVYd25S?=
 =?utf-8?B?b3ZIZjVrbGhoZTEyeWkxd0ZHMzlIOEFrQ2FBM2dXWGJKVVE5R1VoOElMSTlW?=
 =?utf-8?B?TU5vdUNyWkFOR0pibU85RW51TVFDSUM4WXB4N2NqUGowV0dOdnlTUEVTWGJi?=
 =?utf-8?B?NU9JVDBMNkJpVEliZHcxTW51dWJMN2R5TklLZmtBbVovNW5DR09CZDFJQ1BX?=
 =?utf-8?B?T21vNm05dmhncml3K0VqQVcxZmFqNkc1SVRSMk5ZU3IxSzNPb0JtZ0VGbXEx?=
 =?utf-8?B?dkIyOXRINHc5bTczMnpXMHFvZk13cXBnZFVzVGFKaUV6cGIrTXYwblI4Ykpz?=
 =?utf-8?B?M3A0Q3YrNHg4b1E4dlJCTzZSYzl0TXhaNWNsRlpJdVdaYlZUZVJ4dzRSVGlI?=
 =?utf-8?B?d1k5UzcycVhNVFQ3VWcxUVF2WC8yQWU0QStMdlJnM1FXUnMwRHBSYXRVRWdu?=
 =?utf-8?B?Zk9manZvcUw4NXBsRXhLaW03R0g3QXEya09lenY3Z20rM2dnbDRhVUI1MHUv?=
 =?utf-8?B?MlVuT1FISkdDUWF1TDlodWFrTC96dnBwdllkNGFNNmt0aitrR2FhdFZCUk95?=
 =?utf-8?B?a0FGMlA0dk9ZcGdXNkZZQTRHdDZSS1JaQTBWRWFUeVFLaWtodWtndXp5ajg0?=
 =?utf-8?B?Mjk1Y1dyc2lKSTZzZHJIR1UrK3Z0cnFGbXN2bjZXbENJWlBHV0Q4WlJNYU1y?=
 =?utf-8?B?L1VsNGpzbDBMMmFGbVlEWEtscHEvNUs2Um1UbEFDaGdMTjV6bHUrUlhnc0hV?=
 =?utf-8?B?R1hhQ0tmVGdBWndvM1hUNmh3WC83K3JOWUhKTjJuR04yYzBCejFNZUttWktw?=
 =?utf-8?B?ei80ZmZTa1JlY1RrRkNVUzY0QWJnWkQ2ZURPUHVEKzlTWTV4Z3J3WTViVUVM?=
 =?utf-8?B?bzlZdDgzOW9zUzdPTWZpZ2JqeWtJRDhURFFxY3hMZEJ5N2VUbnJxRTY1WVpK?=
 =?utf-8?B?MnZuQXY0UHUvQnYwNkdqSEYwbWloV2NLQ2dxRk9jbUd5VFhxNzJMOGxRbWZl?=
 =?utf-8?B?U1ZkUkxjYmNMalJpL2x6Wi96akVPVS8xbHBkdUY1eDhqVkJ6d0FWa1dKb3VJ?=
 =?utf-8?B?Zm5qTjJmRW1HNHN1WTY5eC9mODBMY1NHcE9MUG1QMENNMDBic2ZFVWdSRThQ?=
 =?utf-8?B?VXRBaHdzVUYvL3BVc1ZKRGtNQnl0b3c3OWU4djdtTUpSQXRTZGlqK1NqNWM4?=
 =?utf-8?B?L2t1eHgrVldjVUN3K3pZRHNNdUVKRG8vQXZtck42bU1mWU8xK0tjclV2cjRh?=
 =?utf-8?Q?Uyy1XCJXayVmCiknzoN/RmdIj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c57d8a-9179-4cbd-ba5d-08ddec89addf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:37:02.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rARM6ejjjSpz/thU95CgJ7KcbuVgRChMKNjEqWdI+MA2U0hBN/7oJwFWTNhHCsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625

On 5 Sep 2025, at 10:11, David Hildenbrand wrote:

> We added an early exit in thp_underused(), probably to avoid scanning
> pages when there is no chance for success.
>
> However, assume we have max_ptes_none = 511 (default).
>
> Nothing should stop us from freeing all pages part of a THP that
> is completely zero (512) and khugepaged will for sure not try to
> instantiate a THP in that case (512 shared zeropages).
>
> This can just trivially happen if someone writes a single 0 byte into a
> PMD area, or of course, when data ends up being zero later.
>
> So let's remove that early exit.
>
> Do we want to CC stable? Hm, not sure. Probably not urgent.
>
> Note that, as default, the THP shrinker is active
> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
> THPs are added to the deferred split lists. However, with the
> max_ptes_none default we would never scan them. We would not do that. If
> that's not desirable, we should just disable the shrinker as default,
> also not adding all THPs to the deferred split lists.
>
> Easy to reproduce:
>
> 1) Allocate some THPs filled with 0s
>
> <prog.c>
>  #include <string.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
>
>  const size_t size = 1024*1024*1024;
>
>  int main(void)
>  {
>          size_t offs;
>          char *area;
>
>          area = mmap(0, size, PROT_READ | PROT_WRITE,
>                      MAP_ANON | MAP_PRIVATE, -1, 0);
>          if (area == MAP_FAILED) {
>                  printf("mmap failed\n");
>                  exit(-1);
>          }
>          madvise(area, size, MADV_HUGEPAGE);
>
>          for (offs = 0; offs < size; offs += getpagesize())
>                  area[offs] = 0;
>          pause();
>  }
> <\prog.c>
>
> 2) Trigger the shrinker
>
> E.g., memory pressure through memhog
>
> 3) Observe that THPs are not getting reclaimed
>
> $ cat /proc/`pgrep prog`/smaps_rollup
>
> Would list ~1GiB of AnonHugePages. With this fix, they would get
> reclaimed as expected.
>
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 3 ---
>  1 file changed, 3 deletions(-)
>
LGTM. Acked-by: Zi Yan <ziy@nvidia.com>

I also notice that thp_underused() checks num_zero_pages directly
against khugepaged_max_ptes_none. This means mTHPs will never be regarded
as underused. A similar issue you are discussing in Nico’s khugepaged
mTHP support. Maybe checks against these khugepaged_max* variables
should be calculated based on nr_pages of a large folio, like
making these variables a ratio in other discussion.

Best Regards,
Yan, Zi

