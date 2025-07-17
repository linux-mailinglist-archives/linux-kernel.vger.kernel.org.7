Return-Path: <linux-kernel+bounces-735901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11FB09503
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E675A20C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4562F6FBA;
	Thu, 17 Jul 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpxlqrYN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89191CA4B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780784; cv=fail; b=nlG1DZhdRhCPgAhM3mDP4ZZRSnpJUErr3FM9wkwbR61S9DBbl0hTkKB28NvSx/8GvGXxFlO3G1HP4sNkealyGTF6jfSJ1OnRZuxSQ3/1lqtOYOtYTAhKR3jD7pXPlfvTCskydVQbPs/cjrY3w2oNeqjokkzxTMrZ2z7v5Zm4nS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780784; c=relaxed/simple;
	bh=GHUvJ8coOUbel54Ngt13JitN1u2bxdoe3S1t9QdyRms=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QOO0wTk30cbOp+bkXvXFDuHwTfhLt/YjD0blslLylbAhvK3SNgW2XmU7H79lVVyMKGZ7fs+WNIzpdapiiDaYs/851eLq6Z/XDzJCXBxdK52mNAReA2PSTo/NRfu+3bfw7iZhn4fQmt9+ATJ7JspZOgi5a7tqzaaW//U2bFHAigY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpxlqrYN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752780782; x=1784316782;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GHUvJ8coOUbel54Ngt13JitN1u2bxdoe3S1t9QdyRms=;
  b=dpxlqrYNvCuP77ZwVbub4MMgxKxNZ0HeqikU50rw2vZnd3O2ISPynZjz
   cI0JoAe15+GAXn430rTHRTiGSD1HVLeFBZn+LNxBxK99Cy+uK6KVj3dqL
   RETBIuWt2dD9FomuofS7BBlwaEVx4VbLY6gAwVNEDiDeWtO12qt6haUeo
   7AUh7lYR2cTvHHqdukupfoxFJfe5rOhCmSbi0je3RZocfTWdM4Aq6n6a7
   ESknaS9+mlkQ+V2YVVVgL0dWxZ4sIxmcs4BeO3LUYs/c5BadCndnx3leO
   iaWGArVMEsOrZGeCTkVANkD/aUspfgG4mvocE0djVdRJJV6yILeqmq4j/
   Q==;
X-CSE-ConnectionGUID: rf8gJU3OQVG8tq+O/KHaMw==
X-CSE-MsgGUID: 1nezdUClThS2L4CoM2m9Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65642312"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="65642312"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 12:33:01 -0700
X-CSE-ConnectionGUID: yaojbGFvQUC6Qwv+n15Xnw==
X-CSE-MsgGUID: pLzvtuo9TD2f5IyAl9LwqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="188831098"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 12:33:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 12:33:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 12:33:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 12:33:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG8squYMz+HPwH1KUz98n83Al4eBYMeVXbH9RiuCdB/vQGfZUUgBnMGvLijX/UDGzSes3GONnxEjUYgb6TIu5fQp3YKD2h9ivNaC9ylEZkgkLoH+u+dl2gaZ2eqIVIYLyBdc2s9m2p16HlKg2GhzF0l3x/P+EpmbDqVp8DvZdh96JEBLvLIPXc/iWvL8mGBluZwqUgNWO+KpubsSisHVyo1jLn4IT1GlpTp+4RWCNVtv9rIaclyP3ypmKK5zA802pUFDkJtKZO2bpw/fl0083zpYc8RmMdZT6Tn6csqixXlMoJQ9OPknrzPrhsdtad6slM4Tt8u4xoerjqxlMuliTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRl0KQs5sDGxqSK3CLQdk83WuRmIr1luCJiee77TfZM=;
 b=kjQxgYxiEk5WPoGh2gnlOv7K3uC3CGWuS2EV0zTyGLj8Xy/m4wEnhCZ/2F/JQfvtSje+kBnMnD7qc7gX3zK5LgKKRX6wjf2JJ29ytobrLk7TzSdmBAt+nrwE9XPpPdqBfkyutNq9XvA5Cy2+mZFHyKYAtm4u2FeCFfzSYJzaZUyfy8afjtQweSvCH2A+9fnNF4ToKSDSofL3ZyUCw/33z4p9QLsDYCoiC7Grzn4bs+zDfeb9rREQNO22XMRWGwkdz54roMlD7JGM14FlO2oTFm3/BxJWrMagm5VKmXRpsjAflT8CKERSTyAFfsAXvR8tg0yFfSDq0bhNFl5X6BWMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 19:32:41 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Thu, 17 Jul 2025
 19:32:41 +0000
Date: Thu, 17 Jul 2025 12:34:24 -0700
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
Subject: Re: [v1 resend 05/12] mm/memory/fault: add support for zone device
 THP fault handling
Message-ID: <aHlQQDN8YcoPHqm4@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-6-balbirs@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703233511.2028395-6-balbirs@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|IA0PR11MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ab45aa-3086-435c-70bd-08ddc568b1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4xTDXTI8G5E2k3HPwezamfidycE7XMR3/AuF/iLk78BG029ipGrOAdn+C4?=
 =?iso-8859-1?Q?MD9tpsxcnKavqPJD+54pHOpyTHDoAxq42yMOhaUACjh/xKpBEid9RN4eOa?=
 =?iso-8859-1?Q?WkSqXiYwdnKy42zNQ+6HISjO33aYInkNNs3eJHvN8mEaeFcennVt/ArXZI?=
 =?iso-8859-1?Q?VPgJ+dGcFQUxv1J1oB+Avu2B6ucdfX6XUclQHpVoIREw9OseoL5X4m59f4?=
 =?iso-8859-1?Q?B35qGcTurkZG2OJ8pG02ABfjDotQFL2a0lIezGWd/xw83p1uGNb6FI/fSJ?=
 =?iso-8859-1?Q?YmvdPNagxRhTrFvZQeZd4SLVPSkxxpldTRJ8CzwHacoLRJHDTBDcLZI1XV?=
 =?iso-8859-1?Q?Il567ANRXv5zaEx2z5q8I0qSlas7xCN99gKW+9sBg56byp7icIH35TBw0Q?=
 =?iso-8859-1?Q?F1EG9VMn2JGYZm55O4zKS2G2ai59L6Dr+fhm2ENq6BR3M9cV3abg7+G1Mg?=
 =?iso-8859-1?Q?b7jFdhYkE5Xkvj/c+iDR77E246xeOLy44gX+YO5Grh/OpGq7zS5YzCan25?=
 =?iso-8859-1?Q?pFXpS1R4VSg3Ps36tZDHQuI7of0h5o1apxQ9NRUqBjqWKhN4TQNwqd5c73?=
 =?iso-8859-1?Q?UNEvNHTt3RkkQVAscA7OwPvyWD3aRhLd8oAUzlPfnIDCJ1EvCZDNB+cFln?=
 =?iso-8859-1?Q?0QwnBdx0aZqYtYqr+Y6MNl0NP6/71H/BKjLwv31idJgBsXJyk13qRr0AwL?=
 =?iso-8859-1?Q?PUY5gXIX5UVYPPTffsHshgnQTyZ17tPk0bLOqiMV63VQGQq+6QqqePWHGk?=
 =?iso-8859-1?Q?/f0fvcqKhvSKKQ9hkNcOHO8FxEBgu6b2gB2ngDwhAQBZoJgYW6qr2EYMWL?=
 =?iso-8859-1?Q?RSTIcvAv4rbqY33eaOU3HA1IHm2qAo3lpmQX5NfrpP32n1zT6Nbdi4NGA0?=
 =?iso-8859-1?Q?iACYrAiGmbxhEI2nAakAPTFk7MBLaDFpmOYolsms7/OBFQfbHLZtoETddA?=
 =?iso-8859-1?Q?LUWt1tQLhbi2+xinFkAvyBWb9x0Hg8Vc7/crCnGoMNfsOSZoFq0Ivm8o86?=
 =?iso-8859-1?Q?VL2FUKda69ZtzPzV36sPuG17qAAJPcc4SozXK4nWOEWLHr4bk8UGQFsWnY?=
 =?iso-8859-1?Q?YpQZFHFLk3LQggadx7NdVaw0o3u3pw2tVmtyxGtC5RbLx63q4RIzA0K7mL?=
 =?iso-8859-1?Q?fg/z3SnTi0jAbIEY/HdEoRWTjrtK+K2mYxLpu58A6kq4bMgWzPSYq8YTPt?=
 =?iso-8859-1?Q?hgSq9fIwXCPSL4Vy95iDZ7A+f0Xt8iAB5vzdqq2VUG5qBvjIEhbsN5ZcVp?=
 =?iso-8859-1?Q?n+CSqg+BiSKqa5u3BqfuFupsp5y/3k6YrDHOAQ4RQ0GvhkSmmX45QsORLi?=
 =?iso-8859-1?Q?4aQJd6281O8hueQbcRfkwdn2EdDCiomP+D5YQlJ9H6tmX+/7rqGUfStULK?=
 =?iso-8859-1?Q?YQhBl5Y00aLRml1N6CDttHPV+9ykO9l200pSo50onsd/svOTFBgvXzt4xq?=
 =?iso-8859-1?Q?WnqB2mEkWzKiUAoEtIS6OjTWn63mFZrjYsPWdaY4bwd1+ZHkYkkPXQT5sQ?=
 =?iso-8859-1?Q?M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6cUC2rDJwEBvOunt51j9Q6t59pgN8GNyBgrOS/6BC1kg0sCyxMcEzKpKlm?=
 =?iso-8859-1?Q?Y2OrWEJFoZ00POIG/8PfeXS802Tu+rGCzWm/YxmuSiqrEnAceVUEtAO5h+?=
 =?iso-8859-1?Q?H0sIAM7le8x1Cb/JBbQtMI+0FZ8Qb+RTio7s7lpWqI0Kxs2oP95MN1qUNy?=
 =?iso-8859-1?Q?sRJlfECZ0gb1JdC5CdcHqD6tnwe83zkf9Wp/EYivANVlgfSU4LLxlEweCo?=
 =?iso-8859-1?Q?XilgkYC93pZ5kuhOncq1Z/DAFhxX58cHi06Ademg8O4vgFrZdKut05RDuC?=
 =?iso-8859-1?Q?EYp3fky6Qa8UVNl4j8EA6s09EIhgx9ni42TipdT0Vx4HkSVaZ8MxpZe7o4?=
 =?iso-8859-1?Q?9AGU/gqQvt6h0uGfLWmgrrgnQcvvf0T7I1tN8wR+zMDqKvV4WEGZFVh5iB?=
 =?iso-8859-1?Q?VLlEwA1U1F6NzTB17p6/4P1k2s/5B9PTHxtv9yIqLT/dCCF17ie7PcX4Oo?=
 =?iso-8859-1?Q?z5KKyvD8CF7PpxpoYTn9iCodZQksiCjjWAF+VrLR0BzOruFE1hpDm3Adgd?=
 =?iso-8859-1?Q?xEAPJnZWEqi76p9gR1s+XkvjpAHkRj3xGFzrXCVqVmcEDijANluragzIh9?=
 =?iso-8859-1?Q?G7pRn1Mf4WSXVpSQIxSAt4+fjzA3JIbDaTC4z8DX4/wKc54VxdMQ8er3+2?=
 =?iso-8859-1?Q?houJIcKMbBJQba9lgvYwyfx0vt3UnXF4qU3e99h0wLepV8UrG0SaWM+dh3?=
 =?iso-8859-1?Q?3vTFnWXZD8nqwA0LTOg+DZ8wYDk+4I8oQdIAdLW6avLCnhT87bUQ77Nss1?=
 =?iso-8859-1?Q?sBcap7yENfkYCCokDknWDqWCNe1sVG6wMOtB54Mihb4pTvdQGAW6b6YZlj?=
 =?iso-8859-1?Q?N2V+jpLxZbacHw/8i5r0lyMr7JhT001VFbaX+VeMV5/ABQoKtgKoLlbqQf?=
 =?iso-8859-1?Q?SriS5yqtotrOBg6o9WXROGhE9zhmKIdUGmOkQuyI6vyBXq6cYBlbHv8SZo?=
 =?iso-8859-1?Q?Y0w+wYq9s7jWgYIOF4LYXMV9khotDmDj45Xb53dP6phCrZVFWtPfcUPyCi?=
 =?iso-8859-1?Q?uXBtGo8Nd+RS8PwOuYZmrAqA0CX46i5LnMXBgnLrAEkQNs+bh+EYPeX+7P?=
 =?iso-8859-1?Q?bVFjr4XY2HOlS/5e09dz/K4zeZMLswe5YPGKjGFRJDvqFtvDKYmUHhPTFo?=
 =?iso-8859-1?Q?1oo4685oYH0eqLeLMCaaMordg2lmKvIY56eR6UGPWJ02t7Ddtzov0RGC+C?=
 =?iso-8859-1?Q?o1QJtFxJj8PEjW4O/iDe6QnYiO5qtgYMITRd7gpVFwA76lSprao8dVCp+i?=
 =?iso-8859-1?Q?j+SuYmrPVY6MVu+VlOVKHVaK3wXDz2ZFBORFNlAVr0qB8xMQdvptlv3DnU?=
 =?iso-8859-1?Q?L3FfMX6r2Q6qNXo4Fsvj5zLixaVJPJzg7qUUM8oHu41ZeYN+4NowZz1sUS?=
 =?iso-8859-1?Q?cMaq18mX9ZdkBNHGNzAG4o3C7pOcXcckTPl1/Ljx7532toejfxs9OVwyK8?=
 =?iso-8859-1?Q?0k/2kBTOwz5ASNpetkEq+tGpl8OwMN9KisniGOp+yZVvk64Pp78P3fCa1U?=
 =?iso-8859-1?Q?VUhJ9DuS4u7SHcEM0s5Skc/pObPKyfyDPBd6Dmx9UBsJF7/SltIhrxn2VT?=
 =?iso-8859-1?Q?vhnUw61Xwe2jg9SplFainZ9UQAcsWR6Pq39UcU6Lj1PcSRvesjobRO6sGB?=
 =?iso-8859-1?Q?p5XPwgyVmAdFAffmGzdegXZTf75fThTnNAkGYwfOlN/WgV70x36AEyzw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ab45aa-3086-435c-70bd-08ddc568b1af
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:32:40.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zPppagIrRlGEx/Encxz5Wco9v2S3DXAynwUf73c8mid040Bk63C+ezU+EA8eUuIsWIvtPYDLHFM3D//0ySiuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
X-OriginatorOrg: intel.com

On Fri, Jul 04, 2025 at 09:35:04AM +1000, Balbir Singh wrote:
> When the CPU touches a zone device THP entry, the data needs to
> be migrated back to the CPU, call migrate_to_ram() on these pages
> via do_huge_pmd_device_private() fault handling helper.
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
>  include/linux/huge_mm.h |  7 +++++++
>  mm/huge_memory.c        | 40 ++++++++++++++++++++++++++++++++++++++++
>  mm/memory.c             |  6 ++++--
>  3 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4d5bb67dc4ec..65a1bdf29bb9 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -474,6 +474,8 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
>  
>  vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
>  
> +vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf);
> +
>  extern struct folio *huge_zero_folio;
>  extern unsigned long huge_zero_pfn;
>  
> @@ -627,6 +629,11 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +static inline vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
> +{
> +	return 0;
> +}
> +
>  static inline bool is_huge_zero_folio(const struct folio *folio)
>  {
>  	return false;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e6e390d0308f..f29add796931 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1267,6 +1267,46 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  
>  }
>  
> +vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> +	vm_fault_t ret = 0;
> +	spinlock_t *ptl;
> +	swp_entry_t swp_entry;
> +	struct page *page;
> +
> +	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> +		return VM_FAULT_FALLBACK;
> +
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +		vma_end_read(vma);
> +		return VM_FAULT_RETRY;
> +	}
> +
> +	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> +	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd))) {
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +	swp_entry = pmd_to_swp_entry(vmf->orig_pmd);
> +	page = pfn_swap_entry_to_page(swp_entry);

Would it make more sense here to use folio lock, unlock, put, get
functions?

Matt

> +	vmf->page = page;
> +	vmf->pte = NULL;
> +	if (trylock_page(vmf->page)) {
> +		get_page(page);
> +		spin_unlock(ptl);
> +		ret = page_pgmap(page)->ops->migrate_to_ram(vmf);
> +		unlock_page(vmf->page);
> +		put_page(page);
> +	} else {
> +		spin_unlock(ptl);
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * always: directly stall for all thp allocations
>   * defer: wake kswapd and fail if not immediately available
> diff --git a/mm/memory.c b/mm/memory.c
> index 0f9b32a20e5b..c26c421b8325 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6165,8 +6165,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
>  
>  		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> -			VM_BUG_ON(thp_migration_supported() &&
> -					  !is_pmd_migration_entry(vmf.orig_pmd));
> +			if (is_device_private_entry(
> +					pmd_to_swp_entry(vmf.orig_pmd)))
> +				return do_huge_pmd_device_private(&vmf);
> +
>  			if (is_pmd_migration_entry(vmf.orig_pmd))
>  				pmd_migration_entry_wait(mm, vmf.pmd);
>  			return 0;
> -- 
> 2.49.0
> 

