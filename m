Return-Path: <linux-kernel+bounces-736503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D64CB09DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53EE57A3837
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2521D00A;
	Fri, 18 Jul 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0La7FaL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F551CA84
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826873; cv=fail; b=KfdmVs4eWO3lFbgV5/qlYg7U6qQ5/WitGPqsYJASA+TNhli8qevUjbmLcBndH+0O07jreerQgDqvvFh6hViZ4VvYP+NgbLEGBoAFzcTsSRnYVNocgJBpydErdHiBQmu+ykIdlhXysBjkQpiMMQvk4/D5/6XtTh3SVR0+/j91J84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826873; c=relaxed/simple;
	bh=HGU3+BJxMUUb2ZBxXdREjOTKoDnMHeEs9RbPnBorGRw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BiSMwTAl5ySk9d8LSrQ2HrHTM7004aLTCq6vW+Z9BD2pyFYMi31TEc6m8UyxkrOwAWcW/8o8cVGLFEr8qj0TVz2WCpnV1RpiHL5UIIN2UHUvPANohzAIewdlCuEs5BdVJOhTsU/gR1EIlbgU5/FqtQkUXiGk9CbdhmLdfOKveuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0La7FaL; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752826872; x=1784362872;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HGU3+BJxMUUb2ZBxXdREjOTKoDnMHeEs9RbPnBorGRw=;
  b=k0La7FaLsXb+HnKYYWuI/K1318/57wmyVwijZzZr0gCkTCrzsnFnp1AU
   Wmp/+kmTcNzL1numHb5Ib7h2ow54Q5/BUen36utLxwVDYLUO+vKj0KQ2o
   X1WGOACrR/FU/0ZkGJsKs2WbLUsJCsfcVZu468fniNPmGq4qsIgp9XRkI
   L8sbdkSnNqdNWw57AwGNOABxiMCrFfXd8qTQQSxFlquRv66aL9RgUMrU2
   yrfv9W0/y0On96DsfXt88sfesxUNGJNpUdi9SZUC7fSriszczRS5eOIse
   eNYzc8O7wt4EVTws+sA2aGjJCWNw6g4SfghZaoGS3owXOvhENEX6AXSsA
   w==;
X-CSE-ConnectionGUID: v0ucMWTgSTKp7TvbpSGw4w==
X-CSE-MsgGUID: 96PApQq1Qse/LYKR1t/W0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58780134"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="58780134"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 01:21:11 -0700
X-CSE-ConnectionGUID: loq6wrluTmmTnMK+o7oX0Q==
X-CSE-MsgGUID: IOHZ+IazQT2kGEI8CWScAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="158081926"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 01:21:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 01:21:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 01:21:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 01:21:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvBQPt0JEL2sii+wVylCmX3NlM17tFg+YXSernngW38uiXX22sMOnJ6+dQbNZO7VgJVQ2u7bvtGp8osQ1O+p7ukhtNMJzrifFMmpbYZFXkn0AHCsF2/JcdcDaS6KF8yaNsi478W07rU+jk+vDuQB513ebqRVevpMT/P0iSx5q/jwVY8U2ioAKVBYYqxai753UBQz7Gq3WyCaqbkB6AX14qpkkFDU6na/eqVqiU4lRBhldLdiu9wtlQdL0FBKaKoqLRhDPfhozYh/TuRO9/ESZ2EqwJDAu6qdqdb0VwMCI+qiRx6R4fGRpqULGvT84AG59bnfIZn3uOWzVIMvRmKm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkzW3BTHNnmn9CC3rUATPpjjb0J9Tou6OR/IZcY0nxs=;
 b=kVYPoITss4RfC+klwhrjV0cyMpUVv3DhS5QSZ5IfRcFZLVLhcJxPFaGPyZzz79usFqdPTUmmz+6Og6HEOkblwq5mLVXiIf/C0cyyi/1LJFA9LsGewToUsMvZZSx43E30Oz0qG3FWxA2jh5zEZr2Znqm6aHMWTghQfPis64tTXdKWzjQ+0lciEDQ48qLERHwxZKnAOQvmZvC3uDUyM5nuC854WNVJiaZYSBV6N7uQWb+j5gdjK1pYaCiD0wdvIoobI4bng+/vJzc7VQPdRCMT9hvVwpzziz6vUVCkAGSjs79az1mM+7FHjZ0/ZcER/t0YB5kU+R8EKRZVPWEouc3cwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 08:20:41 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 08:20:41 +0000
Date: Fri, 18 Jul 2025 01:22:24 -0700
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
Subject: Re: [v1 resend 04/12] mm/migrate_device: THP migration of zone
 device pages
Message-ID: <aHoEQAlGgRAb+cb8@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-5-balbirs@nvidia.com>
 <aHnw0kEpIDYfFX3E@lstrano-desk.jf.intel.com>
 <83354b1f-8170-4f73-933f-5127f1d12dc6@nvidia.com>
 <aHn2AE+l5oVTQLox@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHn2AE+l5oVTQLox@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: a068d8e9-6c61-4321-1e4b-08ddc5d3fbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnJjVFpXdjdqNktXV3Nad3A5QVN5akpzQnhvQUFkR1B4RTBIalZqT0RzY2Vh?=
 =?utf-8?B?anBJYU9Od0dxM05xblZyaTFJZ2FXYzNiK2NIMzlIWWNJbjdhdVVUcEVUdTRT?=
 =?utf-8?B?NnlVQnIrdFNTaXdkM0NuaGFBa1IxZUtGU0I5OFAxZEdrTzNTMWttdFhkTGVy?=
 =?utf-8?B?OXFGdlkxS2s1c1Q3SDdZVnByWndhS2tPMWdZRHB2ckFiVktEUDhZTXJ1ZmFY?=
 =?utf-8?B?Zm5GeVdMQzliOE1kMGQwR1FQMXUwNjBIaVJnVUkweFJPcklacXc0T05SV1oz?=
 =?utf-8?B?NU5OZXE0bXRHRHlTUldLTitRNytaWUNkYWhBZGgxTFQzc2pCQklETy8rc3lo?=
 =?utf-8?B?TzVScHl4dVJHR1dBaXcwenErUC9KVm1VNk1zcXo4Vm9DdzN1Uko0Q1EyVXcr?=
 =?utf-8?B?VDBnUGEvWlBiSXVBSHJwcnVQUERSR1NNcGpUTXJXZW5OY3AyYVdyYUlJcXNr?=
 =?utf-8?B?TG5hNjgzUmZoTkdsbWlyTWN6allqeHZRZkRMd1FveEEzNUFKRmFpeTE0bWhh?=
 =?utf-8?B?YjZlNFpKVWVEa3ptM05sb25BMmhEd1FwSWgxZlNkVU5UMVFFUDgyU0cvcjBZ?=
 =?utf-8?B?S1lSMGJNMWpNQm1GRHdqcEhvWEZxcndvUlZmRkNGOHFGdnU5dkRuWEUzWmpQ?=
 =?utf-8?B?VTBXd0puWkxsajFKVTFuc2xpTUFmdUxEQ21CUENua0dxNEhpZE1EWlJDREtX?=
 =?utf-8?B?ZkVGWTRNUCtKSmtCY0JGQWVJSXhTUEhaN1ZzQzdZaHV6anllUHpYMHlSQ3Ny?=
 =?utf-8?B?K1JSc3V5cmVYSHdZWGxYbDJheEVKbGpCTnJUdXZ6Mi9SanA1UFN1RGFyYTE1?=
 =?utf-8?B?THBpMEVlaEhxbElzUmJ3TzUzQlJaUytRVGQvQ0w1MU10ajJvSGM4RUIzY3hw?=
 =?utf-8?B?Nk1hd0xyNFdDNHNtZmRUVlR4ZFpGQXo2Q1o4MU9PVy9tb3MyM0pUK2kwUk1H?=
 =?utf-8?B?N0ZCMGk2OEVVTHVLcEhZOElDSjNadXQ5SWZyQUVGMzl6VzJvazRJUzZiWGI2?=
 =?utf-8?B?Nm1DRkVIdGZnMXVwaVJjaUpjODE0NjJkcjd0eG5oUUF4ajY5aUdpelBuSDdP?=
 =?utf-8?B?MGZhM05GRUh2ME92RFN0SkdmMEZWK2hsenhFSFViYmZnWTI4M0k4amNZcUpO?=
 =?utf-8?B?VmtJcmttWTJsWmFVMEI3TGhUc2tIbXoxTTRBT291c1ZGRktJeEZQeENYaWxp?=
 =?utf-8?B?dm1FeUZKWm1OdlV3eU5TbXJSR0dWcU91Q0FRTGJudjZLQzhKRjVOMXd5TXRr?=
 =?utf-8?B?QUJBMytsSjBpbFVjMlNSaXBabWZOcnQxOHJ6N3pBSnRybUpNRWMvUXh2dnRX?=
 =?utf-8?B?M0Q4dFRFQjltZ3hGVFJDSS9ndDdHY29EK01lS0RodmxFeFFIZFJxREVCNWFP?=
 =?utf-8?B?TzZoTlNXem1oQUQ3NlJEYnFYb0VGbWZkbkZmazdicVRYdHFaREJzYVhTR3hp?=
 =?utf-8?B?OGkwdDFYUzZNeGlHamdxYm9ESFZKb1FqTDc5akJNMG1qMWxsWTFXeHZQZDZh?=
 =?utf-8?B?Y01Hc0FDSlpLblB5emxFRUZZNFBMeHRnNTV3S1NUNkZBQnFkbWhXNFd6c2Ny?=
 =?utf-8?B?TnQvbFVUNy82ODJjUkFZVkEwNGtiWTFUcldiTkFFQkVmUzBMQy9TeGRtWGV1?=
 =?utf-8?B?L1h5ekZaVEpMQzFPN1h0eGJCdXhHVmhIeTY5TU1qTEFRRFkyVGRYTzNpQlg1?=
 =?utf-8?B?bHRBU0YwNWFUeitOSkRlb1V1K2dwb21lRXU1VVhsZC9JOGpxVHJFSE5UUzlO?=
 =?utf-8?B?Ym4zZnJ2enp6SXhXVGlnSU55Y2UwREJ5dkxNc0hvV3Y5Q2pUa1VzM1ZnZnJx?=
 =?utf-8?B?MjBac0RyUXdBZ2ZnN1RyUEVaKzBZM0JGT1c2MjlVL1JuUTlMMjBWdGlVOTdS?=
 =?utf-8?B?a0U0cmZUUWYrb1dFU3NXcDJhNXJLS1lRTFcyelhuSlpMSUV4djRKR3AreCs4?=
 =?utf-8?Q?QWKAZAP/aqs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWd4K0NrZU5yWlRvNkRZRnpJZ00ya3dIUlVlcnlVOWtWRHNnMDQ4V0xTMGhU?=
 =?utf-8?B?V09CSHRmcHBYZ1J2UnBqS3Z1NG9JMTcxZWluMGxwV0ZESUVGeGdaWERqaDBh?=
 =?utf-8?B?Mi9jSlArbllRcGVZOFFYUXJ1dWZnS2w2OHhFSmdkTU04VVZUQUNqTmI2T2hN?=
 =?utf-8?B?WDJPRGJJQ1dlbkdpWnpQT2FJbWRMcFVJQ2EwYitpYkZ4eUxEMGFVeEFnTVRs?=
 =?utf-8?B?aVMvL2xsMlZvN05RU2g4T2Q4dk52V2xJTDNTZkVQOWRURVBSUmJuOWNORVM1?=
 =?utf-8?B?SXRlZGI0QnhOYU9qOHprQ3BrODExMW5RTnJIS1d3RjdmTTFxUlEvZUdGeG5K?=
 =?utf-8?B?eWNwdUpvSGxKNDNhWHlqZkk1TGRaOHhSb3loNUpic0tBY0lkQjVlQThKelNo?=
 =?utf-8?B?eWs5M05xTlVQeEkzYnVaNkJhQjU5YTVDV1AxYVJnWGhlbHVvdDVlOURPZkUv?=
 =?utf-8?B?VnB3VmpwYk5PS2hzVUpZdWtNcm9tNlVBaytwNTJPSWJ4QS9zQVg0RFM2WjE2?=
 =?utf-8?B?aCsrZi9SV29SK3ZCSXBNWGx6bEh4Tm93Q2R2bi85VXd4TkNpditUeXFXMFRW?=
 =?utf-8?B?c1pOYmJNMDZZelU4ajJIOUJVeS9XL3ZmOEZtSW9CTkNiS3F3OXBsTnBOenJ1?=
 =?utf-8?B?ZFZXVTlwRmM3d3Mrb1JWaDJIMUpVek9iVkp1NHU4WkpJZEVLNW83c2NteE5x?=
 =?utf-8?B?cmQ4MGVUVjVWalE0TjNlMXZtUzF2YXpScE9Ma05Ib1V3Wm1jSlRGWDJwWHBo?=
 =?utf-8?B?T0tTY0dMeTVGL25CblNHSlI4WHR3aUFqL3N4RU94aSs5Vzd0QVkvTHNNWW54?=
 =?utf-8?B?VWF6Nno3U01DeXJkT1duRlZja2ZPSWRpSitqZHkxcGdzMGdseFg5STd5bXhG?=
 =?utf-8?B?VUNLQXNndnlwMERJc3lucXNLbFl3Q3duZm9NREw5c1ZDaHdOS2NCMGZjUHUx?=
 =?utf-8?B?MWtEQlVLZm8xR0U1dXNUeEttRHNqSHlWbml5UGFKVjM1WVVXakNJSy83Um5Y?=
 =?utf-8?B?V0NSczc4VVVzOEJCQThSd0psNldBZ21IcVRlZWxlU1FGR0NPZzduNDkzUHU2?=
 =?utf-8?B?L0wvUStaZWVJbm9lcElFNzZKbS81dmwydk9weUdKQ2JNWU9ZUUk5My85ekRu?=
 =?utf-8?B?QW9UUWtkd3RWMFpLQ3cxaFI4enBGaDlUdnVQMUhLdGNrakszZGJPdWxYUVZX?=
 =?utf-8?B?NUpvd2NOVzFYZmdoMTR6TUFwelNFWnNHZEdJU0hMWGZCYVd3RVJRT3llQ3NZ?=
 =?utf-8?B?UXRyZWVlWVdUNEwvSnNCTjQzNXNJY0I2bFRhQnk0K2ZmZkQ3T0tiYmtkTzRj?=
 =?utf-8?B?dWU1T3Y4L3JVcjIwSGVjdkJST0UwWTgxKzVGY2tmNXFFNWpvUWxacGFjMmxG?=
 =?utf-8?B?MXZxNU4vZWw1U2lzcDNJVXhmb1ZoVlJXM0pXSTBSZEQzb2x5TGFna0UxeUJn?=
 =?utf-8?B?NTRyMFFLZ1BNS3BzbEgwaTFGb05UUU9KaFkvL1pPWXYyQ2xUa2ZZeml0ai9H?=
 =?utf-8?B?MHY5cFRtT0F4TEhtVkxzZkUvWjNLWTE4cDFkTll6Q1RRZnVaMVpvY1UwTXVB?=
 =?utf-8?B?SE4zaWZlanV2TzZrNkJPWW9VTjVieTYwSFFadk1HM2gzSXpHVTR1eWdyNStY?=
 =?utf-8?B?Zlc4OGhvRTNzcmtEck40UXRJYkZabUgxMm1WKy9VK3Baa2RnRU9VUGRXdHdM?=
 =?utf-8?B?WXZOUEFMN1c0cmphcXM2RWUzL1hYVi9PbkZ2MS93NDl4OGJEdmNzVjJmVWxr?=
 =?utf-8?B?ZERYYXU2Wm1FNkh6THl1Z0tLRm1lM2NWSTVpNFV1dnZtQTJWRlhjTm5xdlF5?=
 =?utf-8?B?UFR2akc2Y0xpeHVrQk9KNnp5U0pST2N5QWwvZ1NaNnQ5RWtaY2p3SktCczFs?=
 =?utf-8?B?UE53S2p1bG5mT1k1dXJiUlliYjczQzJnN1krQkoyQ3RKcm9sbXd3TG16YnV3?=
 =?utf-8?B?S0tCNkFvcVphYjlmS3dGNnJmR1RJdno4RWVCQUJJUC93eWpqME1IOEprSnJn?=
 =?utf-8?B?b3JrODVkMFBvZXdTVS9hMldwY2hzK2U0RDJ1M2h5bFg4UUpqd04vNFpUYmxP?=
 =?utf-8?B?aDZYWUk3L2YzclhQbGpLWjFaekpZd1JIMzZaNDBVUmJqTlVFNTJiaGppeFdO?=
 =?utf-8?B?dVhZT3ZIV3FYM0QzZlNSMmMyT25MU1VHOGdURnlnMFNlS0JsSElDUXN6UlFh?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a068d8e9-6c61-4321-1e4b-08ddc5d3fbc9
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:20:41.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVtDv8CtxJD246gA1MPv8Y0eAR4Mr8RS6id6s23gjPdYvC32EflzaIz+XDHBstixdwia4Br2+kW5ryecm9RYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com

On Fri, Jul 18, 2025 at 12:21:36AM -0700, Matthew Brost wrote:
> On Fri, Jul 18, 2025 at 05:04:39PM +1000, Balbir Singh wrote:
> > On 7/18/25 16:59, Matthew Brost wrote:
> > > On Fri, Jul 04, 2025 at 09:35:03AM +1000, Balbir Singh wrote:
> > >> +	if (thp_migration_supported() &&
> > >> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> > >> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> > >> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> > >> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
> > >> +						MIGRATE_PFN_COMPOUND;
> > >> +		migrate->dst[migrate->npages] = 0;
> > >> +		migrate->npages++;
> > >> +		migrate->cpages++;
> > > 
> > > It's a bit unclear what cpages and npages actually represent when
> > > collecting a THP. In my opinion, they should reflect the total number of
> > > minimum sized pages collected—i.e., we should increment by the shifted
> > > order (512) here. I'm fairly certain the logic in migrate_device.c would
> > > break if a 4MB range was requested and a THP was found first, followed by a
> > > non-THP.
> > > 
> > 
> > cpages and npages represent entries in the array and when or'ed with MIGRATE_PFN_COMPOUND
> > represent the right number of entries populated. If you have a test that shows
> > the breakage, I'd be keen to see it. We do populate other entries in 4k size(s) when
> > collecting to allow for a split of the folio.
> > 
> 
> I don’t have a test case, but let me quickly point out a logic bug.
> 
> Look at migrate_device_unmap. The variable i is incremented by
> folio_nr_pages, which seems correct. However, in the earlier code, we
> populate migrate->src using migrate->npages as the index, then increment
> it by 1. So, if two THPs are found back to back, they’ll occupy entries
> 0 and 1, while migrate_device_unmap will access entries 0 and 512.
> 
> Given that we have no idea what mix of THP vs non-THP we’ll encounter,
> the only sane approach is to populate the input array at minimum
> page-entry alignment. Similarly, npages and cpages should reflect the
> number of minimum-sized pages found, with the caller (and
> migrate_device) understanding that src and dst will be sparsely
> populated based on each entry’s folio order.
> 

I looked into this further and found another case where the logic breaks.

In __migrate_device_pages, the call to migrate_vma_split_pages assumes
that based on folio's order it can populate subsequent entries upon
split. This requires the source array to reflect the folio order upon
finding it.

Here’s a summary of how I believe the migrate_vma_setup interface should
behave, assuming 4K pages and 2M THPs:

Example A: 4MB requested, 2 THPs found and unmapped
src[0]:     folio, order 9, migrate flag set
src[1–511]: not present
src[512]:   folio, order 9, migrate flag set
src[513–1023]: not present
npages = 1024, cpages = 1024

Example B: 4MB requested, 2 THPs found, first THP unmap fails
src[0]:     folio, order 9, migrate flag clear
src[1–511]: not present
src[512]:   folio, order 9, migrate flag set
src[513–1023]: not present
npages = 1024, cpages = 512

Example C: 4MB requested, 512 small pages + 1 THP found, some small pages fail to unmap
src[0–7]:   folio, order 0, migrate flag clear  
src[8–511]: folio, order 0, migrate flag set  
src[512]:   folio, order 9, migrate flag set  
src[513–1023]: not present  
npages = 1024, cpages = 1016  

As I suggested in my previous reply to patch #2, this should be
documented—preferably in kernel-doc—so the final behavior is clear to
both migrate_device.c (and the structs in migrate.h) and the layers
above. I can help take a pass at writing kernel-doc for both, as its
behavior is fairly before you changes.

Matt

> Matt
> 
> > Thanks for the review,
> > Balbir Singh

