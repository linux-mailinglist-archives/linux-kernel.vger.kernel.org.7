Return-Path: <linux-kernel+bounces-750449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E6B15B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C666167330
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF657291C3E;
	Wed, 30 Jul 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZcqfFWd"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0644D279792
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867341; cv=fail; b=ixQFgHYk1qGycRmf+GnKHtDT16nR8icYKGCL939mNLAJGQ3oDDPEPew0GQk+0nVDqUBSaLXeN/Ppu/k3AjjRWGfgCALAMd79IgdqVB/qZ+QrYTritA45Og/XhLTyHSgkSmz0JKm5dyfKD8lSc4HK+x5x+iskqVEEF/SHU5B73Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867341; c=relaxed/simple;
	bh=yTESU+qJH7zF4FjOrtBmbtfQ9Kdo5twtFnDiGXDkFDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXZ2NdtPy7R+ijOCMwnnzuQGdqGmcGqo9XgD3TRqP2mU/WIcoZH0IwNmnZfdsDjJjvRM4t0v1kcKmqaiZQPC1M/82bJx/pTmNY56h3v+He6s1UJl7cWj+HG6iMQvkgKF3oceLxZKKVp1DxHYmHOPUp4gq2uaOu660VL/JA6fn24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bZcqfFWd; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9cOQlxxH30gfAX1pDluMAepc7hLVhC0LYG/74SQU4nHdBh4conjQD+Qw8K+NOurCQx4yYjUQ9mwkl+r+kRsfX3M0niqYdd7HSqFHG9qIyALWWRPnrCs2U5kFU/zGCrJQgJKCjn/sihor12CrSpmWcKGza6VN3t7Sko0T/opNtCANuvaHBHz9vesc7DR3FhHPbtXwXkdIXASWF+cHkKqWWfefs99fyIsT7pZuteEeF6CzYGXZM+RLmp8pYuSR6M21ALI5PP4tZDSdL0eT78qZnHk0x8Rf2fnY5HfeRg+sx31Bq8VsrUCuCwTCH4EV1UW9Mbs96L3PG+FRr7+/YfiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At6kCi8w1+gMPg7WE2xMIU3nxYV2u3aVR0lIrQYPkEQ=;
 b=ouHUTXXrdgrjwlR43G9XfbtGnNVYFzkaIimYmasY4hVIJfZatGXp+ATL5+iEeUq9dZIv9L3IagM/cfVA2a/J6SHPL7DWgFV4x59UEh7g6dVW+jekAn43vEr3rsVDtIRaOLOz9aRzODYhaCO2FQRO9PeaP+Jm2qk1Ax+T7jXC3jUtPcA1GsVW8J4iQfznTW5N2IRt57UTaN1RUCFWU2cBzB72gc6CKXpYAdcbL6oGrle7QrEIAFDBd7VK+0JPSnPDL2NVCWaSUzwmQE9WhYsQSNTwUA84P1ZLR+GqGpQM0B/nFN6AnVcQremZyfmRlayl/w1zPYIIFXF4sI6hfSmemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At6kCi8w1+gMPg7WE2xMIU3nxYV2u3aVR0lIrQYPkEQ=;
 b=bZcqfFWdTH9wa1PqmUGloJRxJmPnMmhSVp5jm1j7I4Z9U9dttbRX7wU69Os8a4L0g+1wncmNsUHXmPqJeoWkJsow8aERd3GsD6KXzev7hvLU4ptL7HlpvnzYq3UR79XY6oyo7XJmMxeZndK1C4cyiLNwFqMauCc5MBEZM434UC2LXPGEFLUt8Wj2wi+HdW5Cefqlk1dUK8kv0YKO3MeEuI4JU+ttObDbkNwSwYMPRqaYwGi+84B3wTimWI2n4DfEDt5+NX5VWrkA8vOltR5FpDcBDO0uj7CjhwyIrRcVa2AvfzwJKj+dtGduW+O4lDJqdSCRkm073Ae89e2ruJskEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:22:17 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 09:22:17 +0000
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
Subject: [v2 08/11] lib/test_hmm: add test case for split pages
Date: Wed, 30 Jul 2025 19:21:36 +1000
Message-ID: <20250730092139.3890844-9-balbirs@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730092139.3890844-1-balbirs@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:806:22::30) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f55f313-b041-4a42-12f8-08ddcf4a93bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUtubzhoUlU1Wktmc2ltSURBb0RnblFYVXNxOE5zby8waVlyV01UaUhLaENH?=
 =?utf-8?B?Z1pleGNIVWppNGswWjYzZHQwL1FpWTQvT2ttcmJjdUpsejNyUEhjUWFPLzRx?=
 =?utf-8?B?MDlpR1FBZTh1UnBtcXd5b0c1RTVoNExlcVl6c1dSTHl6UzA0OTRnbFpJWkZr?=
 =?utf-8?B?a0h4SkpvQ09USjFMVEs1SkFRSFBLNlNjalozSGFTUzdFZzZLSEFsZnU0a0ZR?=
 =?utf-8?B?T3pIWGd3RzRYb0prY2d3aUtWbkFzYmRoTTdhRnYyaDdnT3VSNzE0OEpNdmFP?=
 =?utf-8?B?N1dTdFFyNnBIRWJGT1pPamJCK3hxQS9vN21RT3FhelpLNkZrc1JDUFBlWFVy?=
 =?utf-8?B?UGFUbisvb2FUdHRTNEtRWER5OHNUQXA1d0dCZ2dWMDV3dXBYM2NlcUN2dUdi?=
 =?utf-8?B?Nng1Rlo3RlJycFlzNy83RWlxYmZMNStJakRRekZyaU1lTVNwVllGdGI4ZEE2?=
 =?utf-8?B?Q2V2K2hvYWV4RndnVkRUVno4SzYzUW1rVzRIRGo3bWk4SXhxS1o1S2M0M0s3?=
 =?utf-8?B?cEl2QlV0ZjNXckh0NG9YN3JWeUdyZVRtVENCalN5MnhFbUJLNjg3T2VHeTVa?=
 =?utf-8?B?RTU4d3g3QytvZTFSeXNaZHF6clJsTEJQVXE0OHpTdVJaQ3dsOEhvMVE3cW9P?=
 =?utf-8?B?SXR2eVB3R2dZbzJKNm51Y3lwYmFrN0liS0VMb0F1MlVGZVRaS2x0eE9OK2NZ?=
 =?utf-8?B?aVo0UE1LeEdEODlSa3ZxNmYwZFZURDlaM2xINjQyd0hldFNuMXQwUEtjSklo?=
 =?utf-8?B?NFZqajBOT28zWjJCOXpUdHB3V2dXTjdSY01YMUtZUHFDNXlnWXFMZjl5QmZ6?=
 =?utf-8?B?a2FDaFg4YTJFaVVpNXhOZXg4d3EvTE5pdmY3dUJVWTV4U3dkWFhhQzBsWDF0?=
 =?utf-8?B?WlphZDVCZlgyNmx5OGpEMW1JaUlIczY3aDFLcUxVNVVHMUlGdkhpenEyZkFp?=
 =?utf-8?B?dVRTT004VmVjZlh0TXlGZHNXUEtNak1udWhoYTUwWmhqRDRpRDAzWWQ5YjNk?=
 =?utf-8?B?RytvWjNrYmtpbmNxN2VBT0hnTGlhUXQ1WFZGQlordXpZMDNNQkxDeXFnL2ww?=
 =?utf-8?B?M0RSVks3bW5KMytVQVFPZnM4QXZYZVpBbkwrcnZ6eWJXR3FVRkxBZklnNmVW?=
 =?utf-8?B?ZjdFV1JJRDdEVk54dEtuczNLaFYweVEwZENtOWd2d0hFRW1BbmtCYkRlYmVN?=
 =?utf-8?B?L0gwUEN3SlVybUh0Rjk4NjR3KzRrNW5HWlVvOG9PQ2NVSmpNNVM0WWJRaXNI?=
 =?utf-8?B?aWxlZ1o5b0hTU2dSNjhDeitaZlhnUDU0WWJETHVhTjJHcDVOYTVsUVlJNXBq?=
 =?utf-8?B?U1FBdUJ5ZDE5U0w1VEo4dTNlWUx6QmI2NTBJYUdpUTRaS1cyUVd5YjZVY0VJ?=
 =?utf-8?B?WXNKMTFRdERpSFFhL1Mvd1hhSzVscmhtOEhXM0lZbjIwVDZNRGx1dll6RE85?=
 =?utf-8?B?WXdEaVFWaXcxQVprV2xQWGtoYmIzRW9CRDZkS1FBRURXSWpOYitGQTBaNm9F?=
 =?utf-8?B?VE85WnRXaDllOVZGUlZ2ZUZtbjVVM2o5TThySEJUQVRGdGh0aDNWN3Y1c3ZZ?=
 =?utf-8?B?citaVUdiT1VaeWxSYW1sbnUzTDZ0TmxrMDFOdDREaDlqNDJTWWV6aHV0VmY5?=
 =?utf-8?B?clFxRi9PMU1pbWFxbkx5WVdETWtEc2pzMFpuNXNHU3VrNGJ0WEppZkpEVFFn?=
 =?utf-8?B?Qnk3MTB6eGtkVXVEc3c5Y1pWV29YWWIrVkhRU0RSQktMazExSThkUlhQdHB0?=
 =?utf-8?B?c2xCa2xkTGNuNEJFR2VWL1hQa3NncGZKOUxIM1lSa0dmdVpYZXhIS1d3VHFP?=
 =?utf-8?B?MG4yUi9EYkNNZHBweGU3a2k4VWdDaGppd3pTSzR2RmxLZml1UnVaM3Erd3Fa?=
 =?utf-8?B?MWV5T0QxTjhPMlZGa1puQjVjRlBRN1BLTWtDdTg1djhkdkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWtLbjVNbEVmSllFSzlQelh3SHhRZGF6bW5yNElSVXZUR3ZyVzM0QWJnc1Ew?=
 =?utf-8?B?RDZPaEJBRTU1Q25iKzc5dXdEM3JZTFowdm9LeURnVUtvTzZ0VW9hc2VTVEhR?=
 =?utf-8?B?ZkE3L21NMFBsUGt0VHNDaFRWWXBlMXZNQUo1Nlo4TWZzN0g3M2hlSEtBRWMv?=
 =?utf-8?B?YUlLS2tGeWxCb1RxWGx6ckMwMkRpcWVZZXBMaTlQMUFmdkxyUzJKWkZEVDhI?=
 =?utf-8?B?R1RubktkdUIvRWY5TzFlNkRpdGNtTzRhUm5FMWp0L1JnVGRCN2VVbW1ORXls?=
 =?utf-8?B?WklXM0ZJWUJ2Q2pwVXlUWTM1TW1ObHBwRE80OHFsZHE0VktrNmw5aStUdlZw?=
 =?utf-8?B?T3FYVUFiVUZJQ21Dd1kyNVNaWlZGUmtzbkp6TUs2SHFTb0hKdllyRlZCK2pY?=
 =?utf-8?B?c2dJZFN6YlQzeFVFMVYraDFpam5uYlFTQng1Zk5WdnRPcGhWMjRlMzlESHl2?=
 =?utf-8?B?Q0RYL2lCU0xUMVlVVnBDd3ZybVV3NVVHcCtmVHp4R0xQWjJ4dFp2OUpod0Rx?=
 =?utf-8?B?ZExEaWhTVDl5cVdETG1mcHpaN2JmZ0NudUFSSGRpR2FLTzU1VTNBcXV0TGFi?=
 =?utf-8?B?YVN1bkI5MmZZRTdLS0tZUW5nckIrbzdTSStpVEVaWUN0dWZKeXdQYWc2Zyt6?=
 =?utf-8?B?bEZQOWlQRmIxc1JvY3VIajFhR21UcWJDdEFNOU5oZERtMHJKMkNhOTlpelJ3?=
 =?utf-8?B?Q2RJVkUxRG5kTndGUlV4TCtUeDRrc3hPYlRyaWRLRmdWQmJCelVpd1Q5YmZO?=
 =?utf-8?B?Y3ZvYnhNMnhhRWhicnllNG5kNTgrQnV4MXRkOTdhaUduUSswc2FONXk5bE93?=
 =?utf-8?B?TTRzV001TDAwbjdRazN0dkU1RjBmYnp0eWNyY1JNbDFDcXBxbCtCeHhwTmdw?=
 =?utf-8?B?VzF1SUtPelZyQ3I1UXRwZVFEUGNhdERSblVpd1lNZElKcHVjMjQ0SUFEdnVu?=
 =?utf-8?B?LzkzSlRWVlZOSkxVZWhZakplMnVXQm10dFoya3JQVXVMUHRqWWlVaEJEd21r?=
 =?utf-8?B?SDFuTDZTQUU3ektxbENLTnlsZFFzQld2QjYvc1ZSODBXMi9vc3U4S0dQSVVG?=
 =?utf-8?B?aUplaGNabTRuTkM4K1o2RGZ6aEJtemlyV012eFBlUmx6WC9oVThocnFxZmlP?=
 =?utf-8?B?ckhoSC90RjZVK293MHFyajlMSDU4eEgybWNEUFZvaTBSQ0dDZDVxZFI5SjBp?=
 =?utf-8?B?WVhGcnNhL2VrTytBQWVsNU1WdXorZlA1RXNzdWp6elF2OWxELytEaUx4ZVlu?=
 =?utf-8?B?UlVMUzVGbUdNWUoxQnoyZzFDUzVOQnJWKy9BMmNnWFVUVmpqRld5VWlveHk3?=
 =?utf-8?B?TElnZmtIdDl0MFVhWWNyQ3pxVlRwUzU3YzJ6aVMwSUQ1cFRDZkxmNU5pSUV2?=
 =?utf-8?B?aUM3M1pILzc1NWZWeFJ4WEx6YmJKK1QxYzlkaWFBcGFJYmFxczBCNTJ1ODJQ?=
 =?utf-8?B?R0Z3WlhCb3FpQkg4V1BhUTM1bzZOWTd0cGRWL1cvZHIrUXNCaGxqRFdTZlBO?=
 =?utf-8?B?ZjBUQ1FsUTBKYnpEU1pIbzhLWnpWeTVDdEc0Tzk5STNzcU52SWltYXk4SHEw?=
 =?utf-8?B?Ym0wVEEzK0EwQWpwUmVTL0Y3MEtZN2FEeDZVUnY4Q1QrR0tzOGVEa1pVWVM0?=
 =?utf-8?B?UGNBblZhNlBpNlZxTHVrTGdXa3p6NUNXVUwyUnNTOStXeU1ZeEdnSVJJbmhr?=
 =?utf-8?B?WEh4MDVPaGM5WjQrdnNHQUIxQmViSFBSQktiNldDU0ZmSFJXMno4N2JKelZq?=
 =?utf-8?B?Sm9iMmRjdlpDUHJLd08xOVo1ZUp4c0tuNnZ5c3c3Y2VzcWoyMFN1TWRNTzBt?=
 =?utf-8?B?RGdsMkJQWUhlMVZhRFYxSXN1VHRHNWhTUnpVeEM1TWV6SlZ4b1JtRExqcHYw?=
 =?utf-8?B?ajBjVVdnV1pETWdnUlg5NEZCcklTZTAzaGJhU1dHc2pDSE4xYVpCMzhCdnNL?=
 =?utf-8?B?clVXTzJhNnlTeko4b3pYRGVReFZLWkJtN1ZWaElGd3FmQm9JdHdCa29ORDFt?=
 =?utf-8?B?V0Mzd1pYWTNvUzZ0SlVvSDBUbUtBRlRiUGUxS1dabC95OTFZbTdCOUtOOERU?=
 =?utf-8?B?QWZtc3NwcHpubitsWDFRazFNU25uOGNzWkFwTjZKNU5DSmxTRnovV0h2TmxV?=
 =?utf-8?Q?p+ZOTd/px2ToLpu3m758JGZxF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f55f313-b041-4a42-12f8-08ddcf4a93bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:22:17.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xpDdsdc49woAe83ZnfsEbQFXH7YcHpqL0qeCgHXSKB9eiBfVkxowJkPbuLfN2sypszP7++VmJxbq3kogCnQxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

Add a new flag HMM_DMIRROR_FLAG_FAIL_ALLOC to emulate
failure of allocating a large page. This tests the code paths
involving split migration.

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
 lib/test_hmm.c      | 61 ++++++++++++++++++++++++++++++---------------
 lib/test_hmm_uapi.h |  3 +++
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index a8d0d24b4b7a..341ae2af44ec 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -92,6 +92,7 @@ struct dmirror {
 	struct xarray			pt;
 	struct mmu_interval_notifier	notifier;
 	struct mutex			mutex;
+	__u64			flags;
 };
 
 /*
@@ -699,7 +700,12 @@ static void dmirror_migrate_alloc_and_copy(struct migrate_vma *args,
 		     page_to_pfn(spage)))
 			goto next;
 
-		dpage = dmirror_devmem_alloc_page(dmirror, is_large);
+		if (dmirror->flags & HMM_DMIRROR_FLAG_FAIL_ALLOC) {
+			dmirror->flags &= ~HMM_DMIRROR_FLAG_FAIL_ALLOC;
+			dpage = NULL;
+		} else
+			dpage = dmirror_devmem_alloc_page(dmirror, is_large);
+
 		if (!dpage) {
 			struct folio *folio;
 			unsigned long i;
@@ -959,44 +965,55 @@ static vm_fault_t dmirror_devmem_fault_alloc_and_copy(struct migrate_vma *args,
 
 		spage = BACKING_PAGE(spage);
 		order = folio_order(page_folio(spage));
-
 		if (order)
+			*dst = MIGRATE_PFN_COMPOUND;
+		if (*src & MIGRATE_PFN_WRITE)
+			*dst |= MIGRATE_PFN_WRITE;
+
+		if (dmirror->flags & HMM_DMIRROR_FLAG_FAIL_ALLOC) {
+			dmirror->flags &= ~HMM_DMIRROR_FLAG_FAIL_ALLOC;
+			*dst &= ~MIGRATE_PFN_COMPOUND;
+			dpage = NULL;
+		} else if (order) {
 			dpage = folio_page(vma_alloc_folio(GFP_HIGHUSER_MOVABLE,
 						order, args->vma, addr), 0);
-		else
-			dpage = alloc_page_vma(GFP_HIGHUSER_MOVABLE, args->vma, addr);
-
-		/* Try with smaller pages if large allocation fails */
-		if (!dpage && order) {
+		} else {
 			dpage = alloc_page_vma(GFP_HIGHUSER_MOVABLE, args->vma, addr);
-			if (!dpage)
-				return VM_FAULT_OOM;
-			order = 0;
 		}
 
+		if (!dpage && !order)
+			return VM_FAULT_OOM;
+
 		pr_debug("migrating from sys to dev pfn src: 0x%lx pfn dst: 0x%lx\n",
 				page_to_pfn(spage), page_to_pfn(dpage));
-		lock_page(dpage);
-		xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
-		copy_highpage(dpage, spage);
-		*dst = migrate_pfn(page_to_pfn(dpage));
-		if (*src & MIGRATE_PFN_WRITE)
-			*dst |= MIGRATE_PFN_WRITE;
-		if (order)
-			*dst |= MIGRATE_PFN_COMPOUND;
+
+		if (dpage) {
+			lock_page(dpage);
+			*dst |= migrate_pfn(page_to_pfn(dpage));
+		}
 
 		for (i = 0; i < (1 << order); i++) {
 			struct page *src_page;
 			struct page *dst_page;
 
+			/* Try with smaller pages if large allocation fails */
+			if (!dpage && order) {
+				dpage = alloc_page_vma(GFP_HIGHUSER_MOVABLE, args->vma, addr);
+				lock_page(dpage);
+				dst[i] = migrate_pfn(page_to_pfn(dpage));
+				dst_page = pfn_to_page(page_to_pfn(dpage));
+				dpage = NULL; /* For the next iteration */
+			} else {
+				dst_page = pfn_to_page(page_to_pfn(dpage) + i);
+			}
+
 			src_page = pfn_to_page(page_to_pfn(spage) + i);
-			dst_page = pfn_to_page(page_to_pfn(dpage) + i);
 
 			xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
+			addr += PAGE_SIZE;
 			copy_highpage(dst_page, src_page);
 		}
 next:
-		addr += PAGE_SIZE << order;
 		src += 1 << order;
 		dst += 1 << order;
 	}
@@ -1514,6 +1531,10 @@ static long dmirror_fops_unlocked_ioctl(struct file *filp,
 		dmirror_device_remove_chunks(dmirror->mdevice);
 		ret = 0;
 		break;
+	case HMM_DMIRROR_FLAGS:
+		dmirror->flags = cmd.npages;
+		ret = 0;
+		break;
 
 	default:
 		return -EINVAL;
diff --git a/lib/test_hmm_uapi.h b/lib/test_hmm_uapi.h
index 8c818a2cf4f6..f94c6d457338 100644
--- a/lib/test_hmm_uapi.h
+++ b/lib/test_hmm_uapi.h
@@ -37,6 +37,9 @@ struct hmm_dmirror_cmd {
 #define HMM_DMIRROR_EXCLUSIVE		_IOWR('H', 0x05, struct hmm_dmirror_cmd)
 #define HMM_DMIRROR_CHECK_EXCLUSIVE	_IOWR('H', 0x06, struct hmm_dmirror_cmd)
 #define HMM_DMIRROR_RELEASE		_IOWR('H', 0x07, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_FLAGS		_IOWR('H', 0x08, struct hmm_dmirror_cmd)
+
+#define HMM_DMIRROR_FLAG_FAIL_ALLOC	(1ULL << 0)
 
 /*
  * Values returned in hmm_dmirror_cmd.ptr for HMM_DMIRROR_SNAPSHOT.
-- 
2.50.1


