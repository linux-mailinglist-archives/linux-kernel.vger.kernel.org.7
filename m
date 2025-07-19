Return-Path: <linux-kernel+bounces-737467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54833B0AD1C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 02:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7495A337D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF07082F;
	Sat, 19 Jul 2025 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxNbuJpF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C878F3A
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886306; cv=fail; b=guR8CfyeT296guYKp+WSDdebW1ssMkUk2AFbS6wFd/JL1XoOfNAqjpsjEkq7Goss8gYtwri7UU4A2psXqIqT/hXVrzC7QPR3lCgvLNCR7lpnSviVlkJ3gntytLSSryCkY309yU4paMpZscEy9X+5o/TQc5nON53JyLBpvQkL4gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886306; c=relaxed/simple;
	bh=Tp4fJWDpMwVwxbCawteAV8WKU9KXnGG2kiIm6SK3NDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fzYs4Xel+f+tQSCblQ53JML46qD/X3dcQzQxFuETbcDfM/3/5wKtE+OOsjfUIwghi5r6ZbbzT6TBVhyJWGaN11WjZ8fTDv605gDoAjUFRBthP+rMYea63evJ6e9v2dur81QoBopn7X0Gj8qLBdulBBxhlpYOp0dY8320Q2yHgp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxNbuJpF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752886304; x=1784422304;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Tp4fJWDpMwVwxbCawteAV8WKU9KXnGG2kiIm6SK3NDQ=;
  b=SxNbuJpFCKE3M/lFUbNXjgZcbF7l7wAnfuXp4aC7yYjRfF/AnTWAl5q8
   SOKY5TIXCo6F3YvNPpl/cYL9IhvlWGt1hrbn/ehKluMQ8UQFOyQ4+PpaE
   lbO19/qJQBg140EuGUqamjPwffVXre99gkkUJ95Alg+XdAOIhhP9hdqDC
   EmQfvYgOuzAs+dAGp/qNfYeRQ6aP50fHJ3GrZkCPq1XRGfTOrSTydB4os
   PTd1+ZcylsZE5YLM4pFvnv71X+1QBJmlKBH1KZcuyd5yzPSEPoZHWKmqn
   m3PYusA4vqO6WjY82LTBCFNetxK8ZBoLzxjLo51/siM4jH8XNz1PAN7YD
   Q==;
X-CSE-ConnectionGUID: 0/U2c+yvTpKwZJVXpdp7hg==
X-CSE-MsgGUID: NQ8y4w8iSkOt4GUJ2d0Duw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="77720864"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="77720864"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 17:51:44 -0700
X-CSE-ConnectionGUID: zE/fdzSHSzCYb0JDhYRZhg==
X-CSE-MsgGUID: rYxBOu5cRxWc9Gwi9n7FFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="158413798"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 17:51:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 17:51:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 17:51:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 17:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8WGpwVMnd7dgueRCh5zwfqS+vLFcYq5xFejOlahDh2F3utDmxluL5g5hT5yRHqgUrjZtd5zedCYUW4jS0TeiYPqEJ9A6VSmA4QPlCfG2pdBBn/j5izhfC4P7lrGbkCK3FBCZkqbEKO1N3HQBSSSlWVFG0Z8X7AaBqiBBXhLMPQwMBTg6BzADOndTIBHPudBLYVVNkSkEMbPJfpz+cRXkLtwqgXQ7/Xz7TE8pG5z1ohxaJREFeBRwz0MOTKxfoqu37lLe39iL2qRkovilbtbVW5NuMtpn4ja4LJr7bBID2bk+cB/ZUUsHL/g8mBlZXJvOkIa/NN/qTMMnaXYsEDDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vznNeyPzT7cXjVWyjGxHco7yHSgSE5KKQiJ1ahusLs=;
 b=cw2fN6aNV3d0HT+vXb7GPqM1spZb/kUggqX9g+wVqMuf9ODXXilFGF54eRoCeJdW/+3EZd3XUWyR1xZhyKhO8lfuw6VpVNIBPqh7MhIIzMub+F8NiFUg5vQg4/LGNDf+OGmT84XNdBxBYz4waVPFSwU7G714cbhSLF4rue3bRef/nSvDG6SmKWjAsk7rQtWD0gn5sUOx5vFQ/rMM6e5u8ZNYXX4/+h+sKNrwrqRy42lyNrvkwWz4uaJb06odbbPgtRN6mmy2IA85Rxcrj+8YBCHd6YblRFVbYNI07NYoNoV+cWuet/iV+5B+EyGrqsQC9w84kgs34+EEH8HhSJOyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS4PPF6EA6DD735.namprd11.prod.outlook.com (2603:10b6:f:fc02::2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Sat, 19 Jul
 2025 00:51:26 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Sat, 19 Jul 2025
 00:51:25 +0000
Date: Fri, 18 Jul 2025 17:53:10 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Karol Herbst <kherbst@redhat.com>, Lyude Paul
	<lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Shuah Khan
	<shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Barry Song
	<baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Alistair Popple
	<apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
Message-ID: <aHrsdvjjliBBdVQm@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
 <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:303:b8::20) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS4PPF6EA6DD735:EE_
X-MS-Office365-Filtering-Correlation-Id: 4494d18f-7299-4894-d9f4-08ddc65e637a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WklPemYyV29iSTRySnhnZXVsS2RNU2cwWXo1ZXR0Y29PVnpObDFvcVZaZVpU?=
 =?utf-8?B?a09mQkIxSkJuckJTczdMV2wyL0dHQi9HWDVIbDViVXRmbTJBRkFpMFp1akNJ?=
 =?utf-8?B?WEFMKzI5dDJaNlVXbFZqdVV0NHZtSlRIeTdMQ2RGVWZaa283eTN3eStWZHdr?=
 =?utf-8?B?bEhOTVlac2k5SFBMeGJxN3I2VkJuNythZmNQcnBMNzdqUkNOQW9BcE9lM3hP?=
 =?utf-8?B?VEVGM3lsSytKanpOWnNZeEVWUjkyL1pHUVMzY3JDQklvdlBZTHRUejVPR3BT?=
 =?utf-8?B?UnR0S1YwNEZ3VEVySTQzVVRrL0VjcHgzeHl4N3lKZTFEU08wc1FYWm8xS1Na?=
 =?utf-8?B?OVVTQml4ZHZvNHZBaHJJaWQ2WUZ5WW5LSHZVbU1DT3YwMHh2Zzl5T0MrQ0M5?=
 =?utf-8?B?ZG1GbktXa3FVUWJ3Q3NXV3FzUWJFTE9kTlFEWnlUbDQweU1mUVJWckw4UW1H?=
 =?utf-8?B?bUprNWZ6Z2hacXZMMzcyeHNtOWd6S1NWTVQvWHdGZ1d3UGFOYXI1QkxFVnVh?=
 =?utf-8?B?KzJYZ05hdlhWc3RQRCt2SkZOSTl4bHpHdFZHbzlhWkMzNG83aXdRRzBabFhS?=
 =?utf-8?B?Y2RVc09tbVcxbWV6Y0pjdTU3dERmcWwrcStPd0ZpcUREMzY3c3h6U1RzUm1O?=
 =?utf-8?B?Z3ZOZkhwYkVpNFhtMkF4Rm1ES1huQm9iU0ZJUVhaTmRHY0NVWXpmcHkyU2x4?=
 =?utf-8?B?ZVhPSFp0MnJYdVVHZ0NobTh1K3c0TDhIamRTckFwYmtJSVU2a2VyUW5SL3d0?=
 =?utf-8?B?NnJMdkdwdjdZb2lHcmhQMUV2K09pazZ0RGV6ZEFKWVdtQjFHZW50dStPVWhj?=
 =?utf-8?B?Zk1iTTdoVjJ3WW5za3QxNEEvTzVCN0dEQk9MZEt6WWtkYm5wMDRiNnNVS1ZI?=
 =?utf-8?B?VFArMHViQkUzWi9HQjBEK2dMcEVJcGJnTTJoelpOMnUxRHdUR0pBMldUZ2Y5?=
 =?utf-8?B?OUk4NEoyMWc5d2IwZkdrYlpPbFM0R0JhaHA0YkdNTEt4UDhTVllKcnc1c0J4?=
 =?utf-8?B?ZnR0UFdVRnEwQi9zZXVUbmMvSXBCTGtROEVUY1Q2cGd5SWF0N3ZRNTZtZGFO?=
 =?utf-8?B?NURzcVZNbkZ3VGZLTGhnd3h4VWs2K2VFcERrYmRhMURENnAwMm5wcUZzZjZH?=
 =?utf-8?B?NDlPa0F5bjE0OE45cTc5TU9CTVd6MzhmWE1zZEVxaHZEQjBSa1JxTEpXaXNK?=
 =?utf-8?B?cVkyVnF4R2VjTFdQTklmMk12dkJmK0VDcXVNQXRlejBwbWVlKzRDUVhJaG9P?=
 =?utf-8?B?WjZkbnhlMTVnWUNBSTN3UTFpeFZac2k4U3ZCV0Y4Z2lPdE82V3BBMG40dXA2?=
 =?utf-8?B?L0lMQjkySWdvUnpWZVR0cjZYRS9wMUI4ZlZRSEtuVVJmcFVZU0lmS2JRajBR?=
 =?utf-8?B?ZUJ4UnlEZ2JLT1JRVmc0QkVCMnNpdnRISlNpNllDeHpHRFU2Z2RPdEkyNk5U?=
 =?utf-8?B?ZnhvOGtLa1Bxc3dFN0swOHZXRDhBZGxFdGNQVHVvR0ZmelZ1Rk1xUDgxeXI4?=
 =?utf-8?B?RW5qVndYL2M0Q05zYVJFVmZqYno3b3Q3Rmd5MmlXaUJxd3RpRzVHWCt5cnNI?=
 =?utf-8?B?SnRtQkUrUyswNzhEUk9wTVM5Y2grVk1RdFFXc1QweldENkhGMUxhVjJGcVYz?=
 =?utf-8?B?ckVMcXN4S1lWeENucUR5VEdMcXdMVWp1OUpXMFk5bGl4dExwYnhiajh4K0Fu?=
 =?utf-8?B?MTlKZE1IdnhIK1duQmsrYUdiSlNLSjFmRVVHRmlaRUlrbVJ1ck9WdFZheXpQ?=
 =?utf-8?B?QXBOdEswOG1XbHFZRHdZVm5QRDZoWFNDSHR5dG00c0ptdmlIdUFtcHVKZHRD?=
 =?utf-8?B?Ykpack5RbUJyOWlxVzlPWHVrUW81WWo0UkxtWTQxUFV3d2hZc3dLMEZTMUlw?=
 =?utf-8?B?NE5DQllNSFRoOFdic1lHMEl5YXBmZnF0Nk5GRHVMSHViVHBOZzN4ZW9FR3VQ?=
 =?utf-8?Q?sihKDOL8cNk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blBDdzVFTGZTbTBNeEhNT2oyTTN0bDZYMlMvNXNjR25XZjZHa3pwNDNWcGFK?=
 =?utf-8?B?VG9CdGovRE4wUW1wclowN0pvT2FVTThhYXR3dmxlSDdwdEFWUEhMdW5TYjJz?=
 =?utf-8?B?V3dBS05YS0RyQXc3dDBSZk96OTBRQjY2YnN1VWNaOHVDTHZ2bmY4cTJFVFpD?=
 =?utf-8?B?WW9KM1lSUWpzeW16emZ0dXdpdjJHWWNiQ2VlRWQzOFZrcm85V1duVEQyRVYw?=
 =?utf-8?B?UFdEWXpUWjRxdnNNeHU1ZDNobC90U0JOaWEzWHNKN0lTWWlFcUV2K3ZMSnBW?=
 =?utf-8?B?b3BDTHFmU2wzbk5PRTl2ZURPQmwxWFNISU5uckpFODB6UEplcWxMUkNQUmE5?=
 =?utf-8?B?UnYzcUd4THRFYkNhdVhVQWFValRvbmZUTEVJWFRHbkF6bCtDVUsrZEI3QVRZ?=
 =?utf-8?B?Zk9jWUJtdE1ieHRpSEtMM0p2WEVXeWFiS3dXY3cwTHFrcjJNWDBraWlob2N3?=
 =?utf-8?B?eGFtdVJGQUVWb0pMVzVGWnllWEFpMVpTaGZESlJxZWgxS1JjUUVSZjdpbVM0?=
 =?utf-8?B?QmY0ekV4M05reWNNSU1veC90ZjNjUXJCdzJOSjFKNlVzNjF6dVNEOFZpYTRG?=
 =?utf-8?B?QXBWWWQ1SkIrd3hYQXVZOEFRNDV2QUI5MzNZT1ZWZEp4UkRPYURpbkprWlFV?=
 =?utf-8?B?dlY5UUVtQllLUitmR3d1bXRhWHRHSi9YbDJnbHJDR25tZnRkc29lOHJGTCt6?=
 =?utf-8?B?MDFibTNQcHJIY29pWThPUkdEK2wxNEZTV3lzM2c1bzZ0bWw2V01BVjVEeUc4?=
 =?utf-8?B?MFZ1Sm12dTNNMzhLVmdpWEo3ZkJueEV2ZitsY1dqaU1wZGo4ZTRMRXBNUk5X?=
 =?utf-8?B?NGJVYlBjc1B5UytuUWlkWlFPdzM2MDlBdk1kTzRJVmdJbHltUkVoc0FGMmF2?=
 =?utf-8?B?WEtONXl1MVRKWmZ6bDEyUkRxOGM1Si9jenZ5RFlyblBCRms2VmphNFEyTmY5?=
 =?utf-8?B?aHZVazZGZmhXMVpqQldwdWJCNFRJQU5aenEwU01lNEY5cXlZL3VPVlc3aHhs?=
 =?utf-8?B?dDg3WFo2dzU4MFZVWUY3Ylg0Q2x2MzVPNVdkNUlmcDB4c09XTVhsUHVyaFNN?=
 =?utf-8?B?RXhmaURzM085VjVidzUvMG5XK2Z2SlpvNzlSd05HZUlpbjljZkZCWDFxd2xx?=
 =?utf-8?B?TTNiSWJIcVR0UUlIc0pqdmlaM0dpWnc3REc5SjFRS20xSTBPemJEU0JaUXlR?=
 =?utf-8?B?Y0RUalpKWmE5STVySWNPL3JHZWlQdzlUK3QwUUVOcGNLeGlUNHQ2UDlTV0lN?=
 =?utf-8?B?Z1hGTWgxaWdocEZYdi92cytMaE1sYXpZa2FQWEU2bHFzREgzbDg1TDE2ZTNF?=
 =?utf-8?B?RWNuYUl2NXpQR2Jqem8xYmRSbWhJSDVsRnZmb3NTOUlNd0Q0cFhacE9oT292?=
 =?utf-8?B?cGxYcVZPM3RzSE1yY1JiQ0pTcysxcEd3ZjU0QXpxUnZoU3AxN1J5U3BNdmZm?=
 =?utf-8?B?cU04aW10UDB1NEhVaVJCcWtHd2dxVkJQcDMweGU1bktkY1RsMnF6cnYrQTZG?=
 =?utf-8?B?NnNnRnB3TTJ0OWZFcUFyOHJyRGtUaWdXY3BNYStDSjlhZ2RuS2U1RHNhS091?=
 =?utf-8?B?UmhHVkxqNXZMWVNhUnFYK2xHemNQUzAzUFlqYW9Lbm1wZWVSL3hVWURzdGJj?=
 =?utf-8?B?S3ZuRk9HeXVJQitScEsrTk0zUDhya0pzN0IyRlRZazNsQnIyc2syOXdFQjU2?=
 =?utf-8?B?eVN4a0FKS2IvQ3RPZWlBRThrZSt1d0xTSkVkeFM4MkpYNmw1ZUEzN3pOODE0?=
 =?utf-8?B?YkJUMWo5eExuc2VpN21vRS9xdlBqTUhMVFdmcjN5QTZHVnZZcUkwdFlaRFQ0?=
 =?utf-8?B?N1RXbE5oZ2dIazV0N0ZrQXp0S0FCSnBwRURyWUhCZUNKTEVxRDdmQklZK0pl?=
 =?utf-8?B?MWVnYUluRHNPSk1mTnJ6NDYyVG5US1BQclN5RWhIcnlSYnh1VGE0ay81U3Ez?=
 =?utf-8?B?S09WQ2pKdmc5eG5ROW1pYUEvYXdicVh0RUkxeXNZZE8wcFRpektDdWp1dkhi?=
 =?utf-8?B?TzJ2SlBDMm9jMkdEOEVxQS9jUWYvRDUzZytDUzJ6VDJVY2ZXNm1sc01QNWNn?=
 =?utf-8?B?ekJMS0hBOWhYYWtLM05NR09JWktWRzQwT09UVlNVM2NJeUprR2pheE56bWIv?=
 =?utf-8?B?cDZFTDJiWGptVStXeFpsam5nWk5pTnlKb1h2cUt3UnRiTFJMdFRDREVEYTlK?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4494d18f-7299-4894-d9f4-08ddc65e637a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:51:25.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1M/Hihzw71HppWtOQ9vAnvUdoBDkPLpNqdpHroj7UogcKwtxjn+oXTwGdff6yCuzSYSwsIr3MkMHusJe3gcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6EA6DD735
X-OriginatorOrg: intel.com

On Fri, Jul 18, 2025 at 01:57:13PM +1000, Balbir Singh wrote:
> On 7/18/25 09:40, Matthew Brost wrote:
> > On Fri, Jul 04, 2025 at 09:34:59AM +1000, Balbir Singh wrote:
> ...
> >>
> >> The nouveau dmem code has been enhanced to use the new THP migration
> >> capability.
> >>
> >> Feedback from the RFC [2]:
> >>
> > 
> > Thanks for the patches, results look very promising. I wanted to give
> > some quick feedback:
> > 
> 
> Are you seeing improvements with the patchset?
> 
> > - You appear to have missed updating hmm_range_fault, specifically
> > hmm_vma_handle_pmd, to check for device-private entries and populate the
> > HMM PFNs accordingly. My colleague François has a fix for this if you're
> > interested.
> > 
> 
> Sure, please feel free to post them. 
> 
> > - I believe copy_huge_pmd also needs to be updated to avoid installing a
> > migration entry if the swap entry is device-private. I don't have an
> > exact fix yet due to my limited experience with core MM. The test case
> > that triggers this is fairly simple: fault in a 2MB device page on the
> > GPU, then fork a process that reads the page — the kernel crashes in
> > this scenario.
> > 
> 
> I'd be happy to look at any traces you have or post any fixes you have
> 

Ok, I think I have some code that works after slowly reverse-engineering
the core MM code - my test case passes without any warnings / kernel
crashes.

I've included it below. Feel free to include it in your next revision,
modify it as you see fit, or do whatever you like with it.

diff --git  a/mm/huge_memory.c b/mm/huge_memory.c
index 2b2563f35544..1cd6d9a10657 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1773,17 +1773,46 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
                swp_entry_t entry = pmd_to_swp_entry(pmd);

                VM_BUG_ON(!is_pmd_migration_entry(pmd) &&
-                               !is_device_private_entry(entry));
-               if (!is_readable_migration_entry(entry)) {
-                       entry = make_readable_migration_entry(
-                                                       swp_offset(entry));
+                         !is_device_private_entry(entry));
+
+               if (!is_device_private_entry(entry) &&
+                   !is_readable_migration_entry(entry)) {
+                       entry = make_readable_migration_entry(swp_offset(entry));
                        pmd = swp_entry_to_pmd(entry);
                        if (pmd_swp_soft_dirty(*src_pmd))
                                pmd = pmd_swp_mksoft_dirty(pmd);
                        if (pmd_swp_uffd_wp(*src_pmd))
                                pmd = pmd_swp_mkuffd_wp(pmd);
                        set_pmd_at(src_mm, addr, src_pmd, pmd);
+               } else if (is_device_private_entry(entry)) {
+                       if (is_writable_device_private_entry(entry)) {
+                               entry = make_readable_device_private_entry(swp_offset(entry));
+
+                               pmd = swp_entry_to_pmd(entry);
+                               if (pmd_swp_soft_dirty(*src_pmd))
+                                       pmd = pmd_swp_mksoft_dirty(pmd);
+                               if (pmd_swp_uffd_wp(*src_pmd))
+                                       pmd = pmd_swp_mkuffd_wp(pmd);
+                               set_pmd_at(src_mm, addr, src_pmd, pmd);
+                       }
+
+                       src_page = pfn_swap_entry_to_page(entry);
+                       VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
+                       src_folio = page_folio(src_page);
+
+                       folio_get(src_folio);
+                       if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page,
+                                                                dst_vma, src_vma))) {
+                               /* Page maybe pinned: split and retry the fault on PTEs. */
+                               folio_put(src_folio);
+                               pte_free(dst_mm, pgtable);
+                               spin_unlock(src_ptl);
+                               spin_unlock(dst_ptl);
+                               __split_huge_pmd(src_vma, src_pmd, addr, false);
+                               return -EAGAIN;
+                       }
                }
+
                add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
                mm_inc_nr_ptes(dst_mm);
                pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);

Matt

> Thanks for the feedback
> Balbir Singh

