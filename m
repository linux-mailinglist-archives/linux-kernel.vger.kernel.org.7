Return-Path: <linux-kernel+bounces-737495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24503B0AD6C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 04:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F139D189F980
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35F1C6FFD;
	Sat, 19 Jul 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5nTAMsK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A114AD2D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752890960; cv=fail; b=AbmeJyPjhH+4DQ3PaJwLVyVgY2HQKea7MRGFyzstP4HmRG0c/sTbzk2DMK45MxAiD4RCsGntpHJLUBdRJ0H77jp2Es4XyEVyXpMA2EA/Iuz77AIKxSZkAYu1+SnvFegrzMbovAmhWuXd0zCcIXj8O2I933qwGOkEND05B6G2fZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752890960; c=relaxed/simple;
	bh=DxdF9+6vEiXrcVzvhZfjnPSgN9u67kbH52Fy/FpHOxY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUVgyZRmijVBsGK1VWWKi9L3BZKepdO8JsfB3oFlfUbJHetXvpLTE6slpxRzVrUNiROHnfhIY6dKGBaWrJd2IfJW91r0AqABeBUfk2hGWffOb4iRVW6fcDVrOXSSWT04clGyri71B97VWBRc1nxeJxFyJgsgdGRz7URNvkqYCWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5nTAMsK; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752890958; x=1784426958;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DxdF9+6vEiXrcVzvhZfjnPSgN9u67kbH52Fy/FpHOxY=;
  b=K5nTAMsKA8OOYSrVb9pRMh1hHVyMQX0fwrU9T32JEZnZq7gd/aXgnI2X
   V6qid1qRMJDSlFaCbHU2yHuOIFyzIM08Sw0Rfi8olH1WcNnWfzdsYuqe6
   JEYt5+eN3na/XvSILVSTTk5T9cWWrjzQ7bmcVQD4bPT51lDjQFGmTrhjM
   V7PM+UIoAznkCAkDvZVjoNvJi56vPFboK8/VziJZJJ1c73pYAuDgfWITl
   I9ftO1dxe6cXTg9JC9MJqI5fk4xzldMg8niFI9n2lN8npBQP54JWNtoMf
   O6bsxQyi+iiJl6raWlUviodmtoQQWiQ5mziBxeRkUqcudPbZkOZr+OvS+
   w==;
X-CSE-ConnectionGUID: TRgJtHZDSxGyYo+n6JpGUw==
X-CSE-MsgGUID: wA7fWDlMQkKEpp0/Ji6h9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="58851019"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="58851019"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 19:09:15 -0700
X-CSE-ConnectionGUID: KR7+0SMXSGeXq5Z0WX7C9Q==
X-CSE-MsgGUID: NuKDOo4ISiaExVK9RSfmQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="158483759"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 19:09:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 19:09:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 19:09:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 19:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZrrSuXPhgwRGMb/PTi0vSY/QM10lzs8gAjSyqQuTVU4OCCznPrpNqH+69N3vfcEBxPA6no1zhsk748ugINt+yDCnk+NF2X1nkUnXAPxhTkFGrBw7v6IP7OZ78AAZzF4nx53rtMcZqCkghVgyiz/cy+yGvyOJt3gIoXB7J1QoWHFjyJwMMxfPXFsZSNyRGlP3FIBdT0VzY4AYIumf8zaQPxxM+7/9rQRH5GpKWB0rzS3WJLC7tvBYOdsw2bqv+586TV5+Bz6D5qZoUZYUMrXi+px+KW9emgvdrz77ouiEb/BdfwEj8mnOM7wTw2cwJAQJWNV+jkl1EQq+TIrwVRWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9QdOzaU4rGvzZQgCVv7FFAiAxVlvFdCdTYopQ99otk=;
 b=d3VyCxIT/glA8wjICwG2azKKW8TUImXpxOW2HHO7JL6wYA2p27KyMXPdMtwhuL3pFNFD++CNAdJu6j7RJ1QyJ1fgnnConcTGUBNK2ATirCxS3liL2pOmjWkPldNMeiEmRT91SY3BeCYLjpnot+Nv+UYE5+E5BEI26AqoVSaiiikkVqY1xLfx6UjKJB9HaYrGjSISg03ku1ir17Lyr/Jo/tEbgj9hpd4Bk1JogdQd1Gohal9mqXLN+hMcVNVG8kT9pkXyu9MgNoRnWewwUoR/ciA8iFMBnFoCXSXubhzUgXGWjfxHswXT3SdGcjKL29cm1SfcsumPRck/UQNsy5L5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 19 Jul
 2025 02:09:11 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Sat, 19 Jul 2025
 02:09:11 +0000
Date: Fri, 18 Jul 2025 19:10:55 -0700
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
Message-ID: <aHr+r0XalwUkOaMQ@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-5-balbirs@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703233511.2028395-5-balbirs@nvidia.com>
X-ClientProxiedBy: MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::27) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|MN0PR11MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: e965e23b-1955-41b8-4c64-08ddc6694056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YFLZVPf4wlyEjZsK2WV4mFEW4FFn9WsJXwfWUJXEif59uqXaWLkKyGbYmN?=
 =?iso-8859-1?Q?WCTRRU0v+pK4WFhzuXdYN65RlPKPi0v72fZVrIWofPVM3LEN44CL1zLp3a?=
 =?iso-8859-1?Q?s0nn+ls7JHetqgMWTlPw6yUEx4DgfRSmG4ebFJ2evFNjq0g9iqshTXUyMd?=
 =?iso-8859-1?Q?VX6lFr0WRULEhu2GTox72yhIExrBvcfLNrRXgRynDcIO2J1mWVwHaFkRdJ?=
 =?iso-8859-1?Q?jUSC/oKmc90msQq01l/a7bKnQwk/DDq1F0j5KJ10ZHGQztOxqVmOWIaGDc?=
 =?iso-8859-1?Q?QfExlN/96P3ai+gVXa0q6SDCj+qm4zL25bSuz6AbgP2oyeQmDHcPlOoFxu?=
 =?iso-8859-1?Q?CeShJwvwLr7LpvxWgP5D1DAoyUQTof/y4WV1iQ88eSqH7beNDdUNy4YKsa?=
 =?iso-8859-1?Q?D0ZBk6RALFUiwCQJdHbAZRBtj1gPLlsL5vc4Fi5Smmg1qSt5IZLgS3Hm03?=
 =?iso-8859-1?Q?NVgtUT8C7AcJRD1bxjTsydNCUYfhBgKFd0by06y1yHqO8LCPDE6d46rv4e?=
 =?iso-8859-1?Q?4VbH/nBUzFAYxZA45ZsRcTDHusZ0c1JVoStcC5Qokn4hAmKrVAlu+iAxb3?=
 =?iso-8859-1?Q?O9f98KoguEUnk69LZdZQnDP/Dtqi9QLYoSS7SUDXcyfyR7QZ0vgYFMG+BK?=
 =?iso-8859-1?Q?yNsVQx/3qntyUYkYmJ03Y5eHxV6OCt3np0JhB45BCuLpLszXCvqEYDEJ+h?=
 =?iso-8859-1?Q?OEPxv6SrgI5cQ4o43NkIksfLCdlDBFpxLeClJPNLb8kNbSLi1/YcOJM/sT?=
 =?iso-8859-1?Q?hCB6HXNi8XOoENnx7fc3TUZ9ZD9S9e/PR2KTzHvQYyZwjZshkVDIwZ67CB?=
 =?iso-8859-1?Q?0yi5ycsDUuKiBvVQA5HeWcgyRmqjcVh1cuZW8hJAEiSz021k/yTYtqVl8H?=
 =?iso-8859-1?Q?AcrGRdp+OY36+ehjDLMkRSU9Ue9hZeUb4CisCU7gjMi8dFjju6NF73CsqN?=
 =?iso-8859-1?Q?ewxrEOSmCtR+e/R6ZGKQ7wJxs2K53MqfoQ3vFwcE0btXRq3ojdh0Nf5Png?=
 =?iso-8859-1?Q?7brKMf0pPB0UfbcbYfnzgFi38vmY88HtJceQaA3yuWL1sSs3FKbu0pDpTu?=
 =?iso-8859-1?Q?RlI8vdzoJMoJEzIL+QLDV8ZOo0WlYyGMXq0qYB6QECA/6d+YhEbxPO6kBK?=
 =?iso-8859-1?Q?otO7Eyru3/YF84qa+pOSZyR0i8SHTB2q0+KFlnJUB8bmmqLJkQB4GKztJ2?=
 =?iso-8859-1?Q?bCcChIKk3sN9USTy3pqI/BaocOVz/0xT9SE0/bWtO2IcSTY+zML3k1RiqO?=
 =?iso-8859-1?Q?VOSQTWO9CBGrw/n4qLJtP31f926H0WDfCF/oNdXbUxASaSzjZOVaQWikvB?=
 =?iso-8859-1?Q?Ot1oRx2IMvx19Bov1RSkYpqfoHaVQyBPP+T7mahP/nAFLmW20jjucEm8GL?=
 =?iso-8859-1?Q?e9pgtXdZqwYgpH6KONmvV/0YlWG6i/LS3kadqismPj4ngnJz/Tq36Sqjyz?=
 =?iso-8859-1?Q?Hlm1qEyr7b/RFfBUJbElp0Y0/i+rtoeVETKZ8eg2T0OON8S68dYzh6T3xS?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ncd4RGiam4AT05+DYz8h+xp1CNTpvsS9XSyZJdH/4Dl1q1am6qo7pGWqys?=
 =?iso-8859-1?Q?/KZFf3rVqZDZsO2Fl25+jbu3NjnBrZpjgHxyp/nyx1Ur+FiclxtHxJF6oD?=
 =?iso-8859-1?Q?N3OEnM8dN3p6zS55dOsYTKTv6J94Sf9U1fhOcXOLRuacBAnL/DbCmssJQT?=
 =?iso-8859-1?Q?vJOVRO2OAyS11gamBN0Uw8LZuxqC5qtNrU/kSzoTtD1JCe7jVTNWg+N1vQ?=
 =?iso-8859-1?Q?AFWA5g2JMjtaSM5HIsnR534OYruSbAGznflhI3XeNY5Fha+tOj2rLVvAJz?=
 =?iso-8859-1?Q?fw6Si4i9RLpIuQus4Rc7LeS0zQnhUY9RHQ/JturzEA3uG39JtnAEZDb45y?=
 =?iso-8859-1?Q?NIHmjH3INsauwFTp/536RSauX/YiOM/dL7tpSa2T4fo71SA6Sa1kDZQyUt?=
 =?iso-8859-1?Q?wDYCW3NzLxs4MhA3rp4o7coCJxbD/YaeILu4AnCHWdOlVXQCr78xrPM3gV?=
 =?iso-8859-1?Q?+WHjeAAvCC3zJUMiskuCbiPYbJeb+OIOPrGbuz+OsMt62luaQJCNpObGAO?=
 =?iso-8859-1?Q?iu9RrnTBI399hvyRpCCT/3Dr77NAUVcSaDHhAWgS34yDAoxXARocMzjcYl?=
 =?iso-8859-1?Q?SV7eSz+dX3mL4x0jCzySTkCVydzjXKpxEHlcP8OqGiOTrQX0lRZUyn2ukL?=
 =?iso-8859-1?Q?bxV7Vgupdlj8R+5bEF+NUzdkZqUw9pg6lIkaMUH04IXNWS3MH99BN+MtSH?=
 =?iso-8859-1?Q?S9qQVK+myDCGd3Kldk7arsjfGr+sRp/xdhg88i3aQe5RfbrTh/1tLZqq6Y?=
 =?iso-8859-1?Q?43IpFe9HeWwZZSN7XFMvo386dIZtgybt9f1w4yKoBSEwSSxYTQ0KRdeTg0?=
 =?iso-8859-1?Q?kaulYsnD5rBIDlQAi8ONQY8ksOT2BsFM7VgwytC5o4bP7XuI8N5w3K1XYP?=
 =?iso-8859-1?Q?bf+NZKf4gmSYK3y9TqS77kRB5vLVsed3DtAJIrCcj54RwQqw+RkLpLhEgn?=
 =?iso-8859-1?Q?BDswLLyMsqortZa79pyK9eR52/TIyuJfZ9k34yhpkeHCuPyMZR/SX6xwH3?=
 =?iso-8859-1?Q?gQWadQIG5tKhqyxPGRLsQu76kKCmumVTFyV6kttdF1GtONjnaMhB070ByU?=
 =?iso-8859-1?Q?lzzCpXfxFlIjS7shSpqGVuWGIa9Ra5aaJbjytpHVr6tVYrTiPtCSHUUjA5?=
 =?iso-8859-1?Q?6cgGAtpdslcRMM8bP7E9qEJLL/+Q1eKHDbF59qDIf4ucDeDqJmOp+HxPif?=
 =?iso-8859-1?Q?9KTUeemhSRdY2vvvgbn80xQyHatJFtB3b7tqbJx7rwoM1nkukKZTuvHW0T?=
 =?iso-8859-1?Q?genb7GXGfsT2kLjfkAewm4+EMhHdNoHudSdsHc7dn11oWa6hXxxeYfQE3g?=
 =?iso-8859-1?Q?gETDiOZxStK5cQQSG1PDOoFqej3KjnOWLFu4EHAbrsoOY8NbWqlusiqUU6?=
 =?iso-8859-1?Q?Pa4tN+JoI1Hf98d0110xG/1UNQkPA2B9odLjm1DmCvJ/ECtMEk80M7IghU?=
 =?iso-8859-1?Q?Rs6RWUCZvgYjbQXHxgSajJFpcandd44nZLI7I5ApOwpCRzYZj5YNxy15jk?=
 =?iso-8859-1?Q?6+SoQ22pMVpzEppRndwbLeQ1KuYlTARVHwzjvBR1FcMxinIZSh+YG6k24q?=
 =?iso-8859-1?Q?eW/0MYbn+u0vbQjFTO/uclSFBkFclDva9OG1L3cPvphFfHQ5g1Oo/8QNUt?=
 =?iso-8859-1?Q?Sr6pZAfPKUXHCCjS5Bz3CmoM85DS67D9JpQ6VfZ7PtmvPKVyi10gyFmw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e965e23b-1955-41b8-4c64-08ddc6694056
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 02:09:11.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Nm8o/wuqTPwFrhVGV3b0dXQ3u7gEF7dDXrck5mel9Au3AOU3JY7ZajVPrxIcNmd/4KiAlZk49V6M0IhdEmMTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
X-OriginatorOrg: intel.com

On Fri, Jul 04, 2025 at 09:35:03AM +1000, Balbir Singh wrote:
> migrate_device code paths go through the collect, setup
> and finalize phases of migration. Support for MIGRATE_PFN_COMPOUND
> was added earlier in the series to mark THP pages as
> MIGRATE_PFN_COMPOUND.
> 
> The entries in src and dst arrays passed to these functions still
> remain at a PAGE_SIZE granularity. When a compound page is passed,
> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
> representation allows for the compound page to be split into smaller
> page sizes.
> 
> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
> and migrate_vma_insert_huge_pmd_page() have been added.
> 
> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
> some reason this fails, there is fallback support to split the folio
> and migrate it.
> 
> migrate_vma_insert_huge_pmd_page() closely follows the logic of
> migrate_vma_insert_page()
> 
> Support for splitting pages as needed for migration will follow in
> later patches in this series.
> 
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  mm/migrate_device.c | 437 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 376 insertions(+), 61 deletions(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index e05e14d6eacd..41d0bd787969 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swapops.h>
> +#include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
>  
> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	if (!vma_is_anonymous(walk->vma))
>  		return migrate_vma_collect_skip(start, end, walk);
>  
> +	if (thp_migration_supported() &&
> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
> +						MIGRATE_PFN_COMPOUND;
> +		migrate->dst[migrate->npages] = 0;
> +		migrate->npages++;
> +		migrate->cpages++;
> +
> +		/*
> +		 * Collect the remaining entries as holes, in case we
> +		 * need to split later
> +		 */
> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +	}
> +
>  	for (addr = start; addr < end; addr += PAGE_SIZE) {
>  		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>  		migrate->dst[migrate->npages] = 0;
> @@ -54,57 +72,148 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	return 0;
>  }
>  
> -static int migrate_vma_collect_pmd(pmd_t *pmdp,
> -				   unsigned long start,
> -				   unsigned long end,
> -				   struct mm_walk *walk)
> +/**
> + * migrate_vma_collect_huge_pmd - collect THP pages without splitting the
> + * folio for device private pages.
> + * @pmdp: pointer to pmd entry
> + * @start: start address of the range for migration
> + * @end: end address of the range for migration
> + * @walk: mm_walk callback structure
> + *
> + * Collect the huge pmd entry at @pmdp for migration and set the
> + * MIGRATE_PFN_COMPOUND flag in the migrate src entry to indicate that
> + * migration will occur at HPAGE_PMD granularity
> + */
> +static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
> +					unsigned long end, struct mm_walk *walk,
> +					struct folio *fault_folio)
>  {
> +	struct mm_struct *mm = walk->mm;
> +	struct folio *folio;
>  	struct migrate_vma *migrate = walk->private;
> -	struct folio *fault_folio = migrate->fault_page ?
> -		page_folio(migrate->fault_page) : NULL;
> -	struct vm_area_struct *vma = walk->vma;
> -	struct mm_struct *mm = vma->vm_mm;
> -	unsigned long addr = start, unmapped = 0;
>  	spinlock_t *ptl;
> -	pte_t *ptep;
> +	swp_entry_t entry;
> +	int ret;
> +	unsigned long write = 0;
>  
> -again:
> -	if (pmd_none(*pmdp))
> +	ptl = pmd_lock(mm, pmdp);
> +	if (pmd_none(*pmdp)) {
> +		spin_unlock(ptl);
>  		return migrate_vma_collect_hole(start, end, -1, walk);
> +	}
>  
>  	if (pmd_trans_huge(*pmdp)) {
> -		struct folio *folio;
> -
> -		ptl = pmd_lock(mm, pmdp);
> -		if (unlikely(!pmd_trans_huge(*pmdp))) {
> +		if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>  			spin_unlock(ptl);
> -			goto again;
> +			return migrate_vma_collect_skip(start, end, walk);
>  		}
>  
>  		folio = pmd_folio(*pmdp);
>  		if (is_huge_zero_folio(folio)) {
>  			spin_unlock(ptl);
> -			split_huge_pmd(vma, pmdp, addr);
> -		} else {
> -			int ret;
> +			return migrate_vma_collect_hole(start, end, -1, walk);
> +		}
> +		if (pmd_write(*pmdp))
> +			write = MIGRATE_PFN_WRITE;
> +	} else if (!pmd_present(*pmdp)) {
> +		entry = pmd_to_swp_entry(*pmdp);
> +		folio = pfn_swap_entry_folio(entry);
> +
> +		if (!is_device_private_entry(entry) ||
> +			!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
> +			(folio->pgmap->owner != migrate->pgmap_owner)) {
> +			spin_unlock(ptl);
> +			return migrate_vma_collect_skip(start, end, walk);
> +		}
>  
> -			folio_get(folio);
> +		if (is_migration_entry(entry)) {
> +			migration_entry_wait_on_locked(entry, ptl);
>  			spin_unlock(ptl);
> -			/* FIXME: we don't expect THP for fault_folio */
> -			if (WARN_ON_ONCE(fault_folio == folio))
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> -			if (unlikely(!folio_trylock(folio)))
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> -			ret = split_folio(folio);
> -			if (fault_folio != folio)
> -				folio_unlock(folio);
> -			folio_put(folio);
> -			if (ret)
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> +			return -EAGAIN;
>  		}
> +
> +		if (is_writable_device_private_entry(entry))
> +			write = MIGRATE_PFN_WRITE;
> +	} else {
> +		spin_unlock(ptl);
> +		return -EAGAIN;
> +	}
> +
> +	folio_get(folio);
> +	if (folio != fault_folio && unlikely(!folio_trylock(folio))) {
> +		spin_unlock(ptl);
> +		folio_put(folio);
> +		return migrate_vma_collect_skip(start, end, walk);
> +	}
> +
> +	if (thp_migration_supported() &&
> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +
> +		struct page_vma_mapped_walk pvmw = {
> +			.ptl = ptl,
> +			.address = start,
> +			.pmd = pmdp,
> +			.vma = walk->vma,
> +		};
> +
> +		unsigned long pfn = page_to_pfn(folio_page(folio, 0));
> +
> +		migrate->src[migrate->npages] = migrate_pfn(pfn) | write
> +						| MIGRATE_PFN_MIGRATE
> +						| MIGRATE_PFN_COMPOUND;
> +		migrate->dst[migrate->npages++] = 0;
> +		migrate->cpages++;
> +		ret = set_pmd_migration_entry(&pvmw, folio_page(folio, 0));
> +		if (ret) {
> +			migrate->npages--;
> +			migrate->cpages--;
> +			migrate->src[migrate->npages] = 0;
> +			migrate->dst[migrate->npages] = 0;
> +			goto fallback;
> +		}
> +		migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +fallback:
> +	spin_unlock(ptl);
> +	ret = split_folio(folio);
> +	if (fault_folio != folio)
> +		folio_unlock(folio);
> +	folio_put(folio);
> +	if (ret)
> +		return migrate_vma_collect_skip(start, end, walk);
> +	if (pmd_none(pmdp_get_lockless(pmdp)))
> +		return migrate_vma_collect_hole(start, end, -1, walk);
> +
> +	return -ENOENT;
> +}
> +
> +static int migrate_vma_collect_pmd(pmd_t *pmdp,
> +				   unsigned long start,
> +				   unsigned long end,
> +				   struct mm_walk *walk)
> +{
> +	struct migrate_vma *migrate = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long addr = start, unmapped = 0;
> +	spinlock_t *ptl;
> +	struct folio *fault_folio = migrate->fault_page ?
> +		page_folio(migrate->fault_page) : NULL;
> +	pte_t *ptep;
> +
> +again:
> +	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
> +		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
> +
> +		if (ret == -EAGAIN)
> +			goto again;
> +		if (ret == 0)
> +			return 0;
>  	}
>  
>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> @@ -175,8 +284,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>  		}
>  
> -		/* FIXME support THP */
> -		if (!page || !page->mapping || PageTransCompound(page)) {
> +		if (!page || !page->mapping) {
>  			mpfn = 0;
>  			goto next;
>  		}
> @@ -347,14 +455,6 @@ static bool migrate_vma_check_page(struct page *page, struct page *fault_page)
>  	 */
>  	int extra = 1 + (page == fault_page);
>  
> -	/*
> -	 * FIXME support THP (transparent huge page), it is bit more complex to
> -	 * check them than regular pages, because they can be mapped with a pmd
> -	 * or with a pte (split pte mapping).
> -	 */
> -	if (folio_test_large(folio))
> -		return false;
> -
>  	/* Page from ZONE_DEVICE have one extra reference */
>  	if (folio_is_zone_device(folio))
>  		extra++;
> @@ -385,17 +485,24 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>  
>  	lru_add_drain();
>  
> -	for (i = 0; i < npages; i++) {
> +	for (i = 0; i < npages; ) {
>  		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>  		struct folio *folio;
> +		unsigned int nr = 1;
>  
>  		if (!page) {
>  			if (src_pfns[i] & MIGRATE_PFN_MIGRATE)
>  				unmapped++;
> -			continue;
> +			goto next;
>  		}
>  
>  		folio =	page_folio(page);
> +		nr = folio_nr_pages(folio);
> +
> +		if (nr > 1)
> +			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
> +
> +
>  		/* ZONE_DEVICE folios are not on LRU */
>  		if (!folio_is_zone_device(folio)) {
>  			if (!folio_test_lru(folio) && allow_drain) {
> @@ -407,7 +514,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>  			if (!folio_isolate_lru(folio)) {
>  				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>  				restore++;
> -				continue;
> +				goto next;
>  			}
>  
>  			/* Drop the reference we took in collect */
> @@ -426,10 +533,12 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>  
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>  			restore++;
> -			continue;
> +			goto next;
>  		}
>  
>  		unmapped++;
> +next:
> +		i += nr;
>  	}
>  
>  	for (i = 0; i < npages && restore; i++) {
> @@ -575,6 +684,146 @@ int migrate_vma_setup(struct migrate_vma *args)
>  }
>  EXPORT_SYMBOL(migrate_vma_setup);
>  
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +/**
> + * migrate_vma_insert_huge_pmd_page: Insert a huge folio into @migrate->vma->vm_mm
> + * at @addr. folio is already allocated as a part of the migration process with
> + * large page.
> + *
> + * @folio needs to be initialized and setup after it's allocated. The code bits
> + * here follow closely the code in __do_huge_pmd_anonymous_page(). This API does
> + * not support THP zero pages.
> + *
> + * @migrate: migrate_vma arguments
> + * @addr: address where the folio will be inserted
> + * @folio: folio to be inserted at @addr
> + * @src: src pfn which is being migrated
> + * @pmdp: pointer to the pmd
> + */
> +static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
> +					 unsigned long addr,
> +					 struct page *page,
> +					 unsigned long *src,
> +					 pmd_t *pmdp)
> +{
> +	struct vm_area_struct *vma = migrate->vma;
> +	gfp_t gfp = vma_thp_gfp_mask(vma);
> +	struct folio *folio = page_folio(page);
> +	int ret;
> +	spinlock_t *ptl;
> +	pgtable_t pgtable;
> +	pmd_t entry;
> +	bool flush = false;
> +	unsigned long i;
> +
> +	VM_WARN_ON_FOLIO(!folio, folio);
> +	VM_WARN_ON_ONCE(!pmd_none(*pmdp) && !is_huge_zero_pmd(*pmdp));
> +
> +	if (!thp_vma_suitable_order(vma, addr, HPAGE_PMD_ORDER))
> +		return -EINVAL;
> +
> +	ret = anon_vma_prepare(vma);
> +	if (ret)
> +		return ret;
> +
> +	folio_set_order(folio, HPAGE_PMD_ORDER);
> +	folio_set_large_rmappable(folio);
> +
> +	if (mem_cgroup_charge(folio, migrate->vma->vm_mm, gfp)) {
> +		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +		ret = -ENOMEM;
> +		goto abort;
> +	}
> +
> +	__folio_mark_uptodate(folio);
> +
> +	pgtable = pte_alloc_one(vma->vm_mm);
> +	if (unlikely(!pgtable))
> +		goto abort;
> +
> +	if (folio_is_device_private(folio)) {
> +		swp_entry_t swp_entry;
> +
> +		if (vma->vm_flags & VM_WRITE)
> +			swp_entry = make_writable_device_private_entry(
> +						page_to_pfn(page));
> +		else
> +			swp_entry = make_readable_device_private_entry(
> +						page_to_pfn(page));
> +		entry = swp_entry_to_pmd(swp_entry);
> +	} else {
> +		if (folio_is_zone_device(folio) &&
> +		    !folio_is_device_coherent(folio)) {
> +			goto abort;
> +		}
> +		entry = folio_mk_pmd(folio, vma->vm_page_prot);
> +		if (vma->vm_flags & VM_WRITE)
> +			entry = pmd_mkwrite(pmd_mkdirty(entry), vma);
> +	}
> +
> +	ptl = pmd_lock(vma->vm_mm, pmdp);
> +	ret = check_stable_address_space(vma->vm_mm);
> +	if (ret)
> +		goto abort;
> +
> +	/*
> +	 * Check for userfaultfd but do not deliver the fault. Instead,
> +	 * just back off.
> +	 */
> +	if (userfaultfd_missing(vma))
> +		goto unlock_abort;
> +
> +	if (!pmd_none(*pmdp)) {
> +		if (!is_huge_zero_pmd(*pmdp))
> +			goto unlock_abort;
> +		flush = true;
> +	} else if (!pmd_none(*pmdp))
> +		goto unlock_abort;
> +
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
> +	if (!folio_is_zone_device(folio))
> +		folio_add_lru_vma(folio, vma);
> +	folio_get(folio);
> +
> +	if (flush) {
> +		pte_free(vma->vm_mm, pgtable);
> +		flush_cache_page(vma, addr, addr + HPAGE_PMD_SIZE);
> +		pmdp_invalidate(vma, addr, pmdp);
> +	} else {
> +		pgtable_trans_huge_deposit(vma->vm_mm, pmdp, pgtable);
> +		mm_inc_nr_ptes(vma->vm_mm);
> +	}
> +	set_pmd_at(vma->vm_mm, addr, pmdp, entry);
> +	update_mmu_cache_pmd(vma, addr, pmdp);
> +
> +	spin_unlock(ptl);
> +
> +	count_vm_event(THP_FAULT_ALLOC);
> +	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
> +	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> +
> +	return 0;
> +
> +unlock_abort:
> +	spin_unlock(ptl);
> +abort:
> +	for (i = 0; i < HPAGE_PMD_NR; i++)
> +		src[i] &= ~MIGRATE_PFN_MIGRATE;
> +	return 0;
> +}
> +#else /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
> +static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
> +					 unsigned long addr,
> +					 struct page *page,
> +					 unsigned long *src,
> +					 pmd_t *pmdp)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * This code closely matches the code in:
>   *   __handle_mm_fault()
> @@ -585,9 +834,10 @@ EXPORT_SYMBOL(migrate_vma_setup);
>   */
>  static void migrate_vma_insert_page(struct migrate_vma *migrate,
>  				    unsigned long addr,
> -				    struct page *page,
> +				    unsigned long *dst,
>  				    unsigned long *src)
>  {
> +	struct page *page = migrate_pfn_to_page(*dst);
>  	struct folio *folio = page_folio(page);
>  	struct vm_area_struct *vma = migrate->vma;
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -615,8 +865,25 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>  	pmdp = pmd_alloc(mm, pudp, addr);
>  	if (!pmdp)
>  		goto abort;
> -	if (pmd_trans_huge(*pmdp))
> -		goto abort;
> +
> +	if (thp_migration_supported() && (*dst & MIGRATE_PFN_COMPOUND)) {
> +		int ret = migrate_vma_insert_huge_pmd_page(migrate, addr, page,
> +								src, pmdp);
> +		if (ret)
> +			goto abort;
> +		return;
> +	}
> +
> +	if (!pmd_none(*pmdp)) {
> +		if (pmd_trans_huge(*pmdp)) {
> +			if (!is_huge_zero_pmd(*pmdp))
> +				goto abort;
> +			folio_get(pmd_folio(*pmdp));
> +			split_huge_pmd(vma, pmdp, addr);
> +		} else if (pmd_leaf(*pmdp))
> +			goto abort;
> +	}
> +
>  	if (pte_alloc(mm, pmdp))
>  		goto abort;
>  	if (unlikely(anon_vma_prepare(vma)))
> @@ -707,23 +974,24 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  	unsigned long i;
>  	bool notified = false;
>  
> -	for (i = 0; i < npages; i++) {
> +	for (i = 0; i < npages; ) {
>  		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
>  		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>  		struct address_space *mapping;
>  		struct folio *newfolio, *folio;
>  		int r, extra_cnt = 0;
> +		unsigned long nr = 1;
>  
>  		if (!newpage) {
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> -			continue;
> +			goto next;
>  		}
>  
>  		if (!page) {
>  			unsigned long addr;
>  
>  			if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE))
> -				continue;
> +				goto next;
>  
>  			/*
>  			 * The only time there is no vma is when called from
> @@ -741,15 +1009,47 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  					migrate->pgmap_owner);
>  				mmu_notifier_invalidate_range_start(&range);
>  			}
> -			migrate_vma_insert_page(migrate, addr, newpage,
> +
> +			if ((src_pfns[i] & MIGRATE_PFN_COMPOUND) &&
> +				(!(dst_pfns[i] & MIGRATE_PFN_COMPOUND))) {
> +				nr = HPAGE_PMD_NR;
> +				src_pfns[i] &= ~MIGRATE_PFN_COMPOUND;
> +				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +				goto next;
> +			}
> +
> +			migrate_vma_insert_page(migrate, addr, &dst_pfns[i],
>  						&src_pfns[i]);
> -			continue;
> +			goto next;
>  		}
>  
>  		newfolio = page_folio(newpage);
>  		folio = page_folio(page);
>  		mapping = folio_mapping(folio);
>  
> +		/*
> +		 * If THP migration is enabled, check if both src and dst
> +		 * can migrate large pages
> +		 */
> +		if (thp_migration_supported()) {
> +			if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +				(src_pfns[i] & MIGRATE_PFN_COMPOUND) &&
> +				!(dst_pfns[i] & MIGRATE_PFN_COMPOUND)) {
> +
> +				if (!migrate) {
> +					src_pfns[i] &= ~(MIGRATE_PFN_MIGRATE |
> +							 MIGRATE_PFN_COMPOUND);
> +					goto next;
> +				}
> +				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +			} else if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +				(dst_pfns[i] & MIGRATE_PFN_COMPOUND) &&
> +				!(src_pfns[i] & MIGRATE_PFN_COMPOUND)) {
> +				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +			}
> +		}
> +
> +
>  		if (folio_is_device_private(newfolio) ||
>  		    folio_is_device_coherent(newfolio)) {
>  			if (mapping) {
> @@ -762,7 +1062,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  				if (!folio_test_anon(folio) ||
>  				    !folio_free_swap(folio)) {
>  					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> -					continue;
> +					goto next;
>  				}
>  			}
>  		} else if (folio_is_zone_device(newfolio)) {
> @@ -770,7 +1070,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  			 * Other types of ZONE_DEVICE page are not supported.
>  			 */
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> -			continue;
> +			goto next;
>  		}
>  
>  		BUG_ON(folio_test_writeback(folio));
> @@ -782,6 +1082,8 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>  		else
>  			folio_migrate_flags(newfolio, folio);
> +next:
> +		i += nr;
>  	}
>  
>  	if (notified)
> @@ -943,10 +1245,23 @@ static unsigned long migrate_device_pfn_lock(unsigned long pfn)
>  int migrate_device_range(unsigned long *src_pfns, unsigned long start,
>  			unsigned long npages)

I think migrate_device_pfns should be updated too in similar way.

Here is what I came up with. Again feel free to include or modify these
changes as you see fit. 

  * Similar to migrate_device_range() but supports non-contiguous pre-popluated
- * array of device pages to migrate.
+ * array of device pages to migrate. If a higher-order folio is found, the mpfn
+ * is OR'ed with MIGRATE_PFN_COMPOUND, and the subsequent mpfns within the range
+ * of the order are cleared.
  */
 int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
 {
-       unsigned long i;
+       unsigned long i, j;
+
+       for (i = 0; i < npages; i++) {
+               struct page *page = pfn_to_page(src_pfns[i]);
+               struct folio *folio = page_folio(page);
+               unsigned int nr = 1;

-       for (i = 0; i < npages; i++)
                src_pfns[i] = migrate_device_pfn_lock(src_pfns[i]);
+               nr = folio_nr_pages(folio);
+               if (nr > 1) {
+                       src_pfns[i] |= MIGRATE_PFN_COMPOUND;
+                       for (j = 1; j < nr; j++)
+                               src_pfns[i+j] = 0;
+                       i += j - 1;
+               }
+       }

Matt

>  {
> -	unsigned long i, pfn;
> +	unsigned long i, j, pfn;
> +
> +	for (pfn = start, i = 0; i < npages; pfn++, i++) {
> +		struct page *page = pfn_to_page(pfn);
> +		struct folio *folio = page_folio(page);
> +		unsigned int nr = 1;
>  
> -	for (pfn = start, i = 0; i < npages; pfn++, i++)
>  		src_pfns[i] = migrate_device_pfn_lock(pfn);
> +		nr = folio_nr_pages(folio);
> +		if (nr > 1) {
> +			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
> +			for (j = 1; j < nr; j++)
> +				src_pfns[i+j] = 0;
> +			i += j - 1;
> +			pfn += j - 1;
> +		}
> +	}
>  
>  	migrate_device_unmap(src_pfns, npages, NULL);
>  
> -- 
> 2.49.0
> 

