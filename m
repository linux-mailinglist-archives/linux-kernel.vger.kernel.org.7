Return-Path: <linux-kernel+bounces-725960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5193B00608
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B41B7B0DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ACD274FD1;
	Thu, 10 Jul 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwdMAYmK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F32741D4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160138; cv=fail; b=JU5uxOrgLJo+kjO/XEw6a2fSD739mX/39UBbgzZWTnhq7twWXxHEhF42yx79i4jfzcvNmRXPy9SJ4/rqLnUuynweKrzkJMY5htDmZOjXEKDdcnygzFL86b3r8nTllwM9KlWeL7cnBOds/5fKZrOuIrqvVjOpcIt/eDwBvw8N43g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160138; c=relaxed/simple;
	bh=VtZXA5ahV1WOZQ6IeXjeqpUxJ7aSPmAlXcezJWyBOJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVfi1nqGdO0nOuxSh+2rvm2bMLb0xiLHAwmr51FX0W67foHTZQTAErG+czeE92BBHlkpeU1SlwBcUczgA0nQEEGB0roQLgEDvOJ2mZuXBIdsX91hPtBbQlaaQ1wgq+xO9N5amupiIr0fmfmIlh07h8CrcdZt3NgofE4jEkpeDag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwdMAYmK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752160137; x=1783696137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VtZXA5ahV1WOZQ6IeXjeqpUxJ7aSPmAlXcezJWyBOJw=;
  b=BwdMAYmKj6OOgXX7mkW+Gkem+sMv32NwmiIRnyqSBcOwhr5O8SkNbsaO
   wfJDkOH+79JGIlXi3UmERDIScRlPf4CXbqhseBH+e7BXWtqFXY2kwNnJb
   8mKbehDRFRJ4+QkIMfzSMou4lgla1DYXfWh2FInUaaS7HsJgVtSqGIaUU
   Dohf8smCub6dzeavMjNUcIaztCdQPNURE8wA2/5Og/0eK1ZkAwhPkb9T0
   UPRC9lD+7dC3csoS/d/bZl8IRokyOoP4ZA4sJOD2PLwZSWUL/3TOsZpaQ
   HO9kHeV501YY3IwJaaD16BAEIU5mOMO6UADVCypMO1bhmbo6Fm+2ZwJS8
   w==;
X-CSE-ConnectionGUID: AhuZhKNQSCmhbis/tfQVkQ==
X-CSE-MsgGUID: 7KXxkz3xT4S20tZsQyi3Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54416372"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54416372"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:08:55 -0700
X-CSE-ConnectionGUID: tvT5z+WzSfCn6LHEI1/toA==
X-CSE-MsgGUID: DGdG50IhRVqiGzVtE3FBUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160137635"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:08:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:08:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 08:08:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.80) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnnn1w/q7nWTq0B8IXJgxOJq0rVdS9dbLKy2UnYGIIHZw2zq8RsofvaQHU7Rg0EEh91300Oo0PIR5LKeSKpzIDMd7OjgpKuJuQ7C4DklM3Ex5ybi1mr2QAwMwbHPy1ohNRxf7uM2573JRstOZxSPLRHOlDRAFNXCvDa4b7TZT677e8F4DZO6ZgJsfmGJuls//x7w1am2s1iiQhvUvbERWuFIy/0COXKW2PvSEQBlCkqnkBH8uxDWRI3g81I1E1jQJYb0Fax7344AY6ywMm4v01+YMNUbERe73E+59JsPy5g96AvKK2AcSg3eNlIOkcXcAzaMaLEn1Qyr0p3PuAgFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FaOl35HoGAgCV5HyPUGYH3cV0EJ6FePLdX6BJuU6SE=;
 b=h+mV7lSMEkOrBudM1dckr6nSz+OVdeHVUo/qEfW0maf1+eNKMe7xQNwhbQKpTH6HZBuyeOpCOfMkXSU6QrbmoZYK7U/8ahbFiz1z+6KRFOGhh/B9ibjzEZQPGrXrk/B/2ZzgTTlUZhQSySG05amiv2TAm++aY2THC0DplIm+2HrmPVryf3dCEC6RpjQ+cEEhXxfKPL1ciLMKwqBZevfYKHSUh+xtb8g4Mvs0Zrkudl/5vuk/UBo9eksXdKwulG3/VDtATluGWbWSFbs2D2DkBzZN1kbIEw+edrYVvLZt7M4PjPaCEDclCrbxPgoOmEum7Ns5pDaMfiEJGDnpf6p7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by IA1PR11MB7809.namprd11.prod.outlook.com (2603:10b6:208:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 15:08:49 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:08:49 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <daniele.ceraolospurio@intel.com>,
	<anshuman.gupta@intel.com>, <alexander.usyskin@intel.com>, Badal Nilawar
	<badal.nilawar@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4/9] drm/xe/xe_late_bind_fw: Initialize late binding firmware
Date: Thu, 10 Jul 2025 11:08:35 -0400
Message-ID: <20250710150831.3018674-15-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710150831.3018674-11-rodrigo.vivi@intel.com>
References: <20250710150831.3018674-11-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|IA1PR11MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b38399f-9a27-41a1-339e-08ddbfc3aca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FwRU80GSIAWf81hmrEWXlHzLf3W6FM4jzg3EqcsjY+twBp/JfYHZVv/kBBi+?=
 =?us-ascii?Q?Hm2Y1GSnstYNsPeRNKq1vkWhVzDNo7aFnHTuhndYvm51VQxZbnmQpr9d2xfd?=
 =?us-ascii?Q?dUrelDbVDEFc4yERbo2G4X8hzcLcGsc63PBVXYgGNEnAHLcgY9PMfGp/mi3V?=
 =?us-ascii?Q?ielq7YiWk6xU4OlqBB+jDgRmal9JdjiOgI2N3KMynZJuPN9agmQZiX/rjq7O?=
 =?us-ascii?Q?aDFYNSTqzUl7SZhf/eM7oPqWVPmVyvx3Ipy+bwjeNLph4SY3t70LbxHaoGVT?=
 =?us-ascii?Q?4mG1tBObnKkyC7hnISjYXGmY6skqEdY4uzcnKd8M8EIefH3nZKpvmve1Ybrf?=
 =?us-ascii?Q?ay0DrSoHs4OoA158KEN3vcbx4e81V2dnjnYKEV4x/CWn2+lR51IGTw522jtm?=
 =?us-ascii?Q?MJKS1qTT2y1YL0dch/np44Fgmsn+ELxnH49ImDv3ihA4LEFTUrw72ZIRB/Fs?=
 =?us-ascii?Q?6ORYrnSV/nU/WULP9wSSWex2kCvrWz40xg+sY3oxlzwyDv6AWyFxG1vi3JD2?=
 =?us-ascii?Q?Y9KEtW803qaVak9bPP8QgIdVj7iDS64+ltfbIKCbfUM5Too5stlejQn8l/FW?=
 =?us-ascii?Q?rfBMcWJ451gQcHH3uzL5oOo549PAr22tcZYIcWTeQrtoJK1bOUuJKvSZlzkS?=
 =?us-ascii?Q?54/PGUbCj4B8KXyN1eJ69yj711AdE50DN4Ph+dPbdWM2zw8lYf5hAAEN6zZb?=
 =?us-ascii?Q?F2Rnr0hUHgFy+XDT6Sv67u9+DMu2tsaR+ie+6ec2xPLKPmu9YFa8tmi8PBE6?=
 =?us-ascii?Q?9Az3adZ8VGEcgtOiLj1j9CFwk/W3CJDGjkAvzCxyUAmILN4Pa0W+DGmEccNM?=
 =?us-ascii?Q?8f7nb9m//NAmCAr+sYK6IiSsPTwGcPO/Zdi3z5Onl0JhmzOpfNJlO46NsdXs?=
 =?us-ascii?Q?6Z0GrQ5gWujW1jdEM0BdnI8Td/dqRGc4qGSXYNYNCFlR/IPMU2Bb31wgjKtp?=
 =?us-ascii?Q?GS18NoyVaezPURcHotc1OMUA8UVj6NcUfnzBa3PDImvG6AVvGfkvJjoAflWZ?=
 =?us-ascii?Q?PD3At/76HKoPB9efgTDPi2bMQME/yMRMMqrtHbeC1bKRLEFoIJHpnxBzFzHd?=
 =?us-ascii?Q?2ffgXI72yMpQRa6B+1PGph/3tiEaoaJ3oL6cGKVe/izz3TeZoZ491t6XpsN7?=
 =?us-ascii?Q?B82iDopCQY9++89rzDXgWyKxHgyiq79TVaWfUGmxCjO39p/i7trWRfMsLvVO?=
 =?us-ascii?Q?jamkHjwytk8Ag8HMCrRg1Xpq9sN/4QejcSzlR66joL/bbPNGpweKTA6A/TUy?=
 =?us-ascii?Q?Mh45jbXjq9G6JGHg3MWB0ZIpyJeuE2Gjv3UTaVxrcG2c3BuunCZ9WJjYhPCv?=
 =?us-ascii?Q?srhQtmp+qIm8eUvWvxApdov1OYCUWKAyTRk9BEUBexWRlYmP/K8VSn1SBLHk?=
 =?us-ascii?Q?TJu+7m7fNGn7HWlrLewkGGdqlFsF5lLK/6sXsMyHApbMN1zvnbhIrPgCIFj8?=
 =?us-ascii?Q?C7QwhkrjVt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?96vMbT6dpbHQecARqtDgyoWajwkNUaWVFwaKBVqXmt5vy8OT/a6dyRJ/9U6G?=
 =?us-ascii?Q?n0l4jFVcwdqTT1ylOltWpv9JkdN3PCuVyGVv/XoWulvxPbWtp8Z2TBi1wBdY?=
 =?us-ascii?Q?8GPe+octZsl8psIIuVGcOtgnmn86RLk7KrHSarjiRKsRLwJWWb3C0qQV9yBb?=
 =?us-ascii?Q?+ewBSx67Pzorx68XD4NdIVLZhnLA57wlPPW4uc/sRUCPEy9rPcFNVtoYZGZi?=
 =?us-ascii?Q?/9UE6mKCo0Sxmk1zvhUR9xFnQCP/QmWv11LcX57GLgNm06lBIC924ejPSi+n?=
 =?us-ascii?Q?O7t7I5fMQ0YTRt/QUi5RTdv1aKpd9ldipMpKSwc6Q/ofDpiUm/i13zZg0fY2?=
 =?us-ascii?Q?U0vRadxOisWQb09Hl4U9zgiGx4AJvwIoU5irfs7CP10AMBm92Owr5w1nQ7Z5?=
 =?us-ascii?Q?SCvL8vY7C5kO/FAJj31Vb0ynudlxsNSypeRt/t4dRDo0AK8Ca4JszNxXO5Uk?=
 =?us-ascii?Q?MAKtbr23FI/Ji29hrLU9GAD7nyBjzHJ/nsmPBCe9I9+kREkI3xiswOFmPV73?=
 =?us-ascii?Q?xqG5TJcf42Pg058+eqmK/vzddadxXXQPaKEDbI+3U8JSaPVNZ5jDnfIfCUS3?=
 =?us-ascii?Q?8r7oQAQmPTMxoGsu8TEW2zpxGI6HJCGQTbjPXNLl5OA0mTCyklZGKpZJabEC?=
 =?us-ascii?Q?V5m+bKADbaj25OxUgq5r7RxAiVBIJRfIni6oVFYBfz0ofCB7ysRivNLcqFtA?=
 =?us-ascii?Q?ChhVt1wzY95kTmywqIQFkdLazF9YeUCJClPB0uYie9QZcBFUwvZczMujOQ2N?=
 =?us-ascii?Q?MT9A9C8d2haMFlS68AStcp/X1ChudQALRo+6mem5cePjQ34qwjUHS5BWtMqN?=
 =?us-ascii?Q?N0BCp8TXFzRnknv/C/CwdqWmPb9JEGD8KZmq0t9qi/fUZMLjtUC94GxI4vNv?=
 =?us-ascii?Q?jZYzW56qW9c/cxCijXiLV7o8tFLvilqf9Qit09jfwGOvQRQYnkkfv+I7cRus?=
 =?us-ascii?Q?5SKBN9KXlXhFnj7L/b+NPwtZWWBDCTXWqcbSVDaqFjozxTalu6LPdmtHsPky?=
 =?us-ascii?Q?XnY0uz8LwvJoUfCgsUw8KrNbcIczuuQZUZ+7dPqNJOEisd2K5xwe24WIIj9t?=
 =?us-ascii?Q?hmqKSHGTlGOkvEnoNXel8XDpMfxhkY71u+CHNUUupAipYh17kHt4quK44xen?=
 =?us-ascii?Q?8md5YyIDHJ6/JE5wgssjPBwapa5ZsZpa5TTxIxDiYxtHGn4IsfVhDNXFZ9Hs?=
 =?us-ascii?Q?Ow9ri7br9qqJY+WUnW9ZGfnyDe6D7NZZM/cw+zI1nnduqL2QCigXrZjTKYad?=
 =?us-ascii?Q?L7mZfWOFaO+d0dcx1uJGjE6+TJXg73BiCOPZMIqHAllR5uGWG242RvOH1NS0?=
 =?us-ascii?Q?e//dpZinOx8twCbF8amfdauqCQRAkMk/583xvq23JhFDOmfNup3NsjZu97ke?=
 =?us-ascii?Q?/scvy3bnia/BU6XkY5fdOL3xACBwoaitYrH9T0oK53hKBgeoSis4aY1VoGBh?=
 =?us-ascii?Q?SNKlr5LJQAYWlg8mghSu0m0s3ure7RogEoCSjJCWEQt+j/xeAtOP6vNjA8F4?=
 =?us-ascii?Q?pzq1fO74t6gB6OGK39xh+3W/xHrrcSAoQZnzJmwweXw4N6kUrsN1RpyoXkvx?=
 =?us-ascii?Q?fG2hs/IFGKS5NeMe8dQIqs0DGW+Wi3twya6qZLtmxNHYbZ1rJU7KzHV3tZvX?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b38399f-9a27-41a1-339e-08ddbfc3aca4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:08:49.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIplF9T9zwh8dUn+lqUfClIldXfHCiVW/8wZjYsHFVy90NVJOrOED0wcEfMPJq3GZgOGtY7+fIe91NLDy/9AKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7809
X-OriginatorOrg: intel.com

From: Badal Nilawar <badal.nilawar@intel.com>

Search for late binding firmware binaries and populate the meta data of
firmware structures.

v2 (Daniele):
 - drm_err if firmware size is more than max pay load size
 - s/request_firmware/firmware_request_nowarn/ as firmware will
   not be available for all possible cards
v3 (Daniele):
 - init firmware from within xe_late_bind_init, propagate error
 - switch late_bind_fw to array to handle multiple firmware types
v4 (Daniele):
 - Alloc payload dynamically, fix nits
v6 (Daniele)
 - %s/MAX_PAYLOAD_SIZE/XE_LB_MAX_PAYLOAD_SIZE/

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_late_bind_fw.c       | 100 ++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h |  30 +++++++
 2 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
index 152f3e58de94..008be9b12fd9 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -5,6 +5,7 @@
 
 #include <linux/component.h>
 #include <linux/delay.h>
+#include <linux/firmware.h>
 
 #include <drm/drm_managed.h>
 #include <drm/intel/i915_component.h>
@@ -13,6 +14,16 @@
 
 #include "xe_device.h"
 #include "xe_late_bind_fw.h"
+#include "xe_pcode.h"
+#include "xe_pcode_api.h"
+
+static const u32 fw_id_to_type[] = {
+		[XE_LB_FW_FAN_CONTROL] = INTEL_LB_TYPE_FAN_CONTROL,
+	};
+
+static const char * const fw_id_to_name[] = {
+		[XE_LB_FW_FAN_CONTROL] = "fan_control",
+	};
 
 static struct xe_device *
 late_bind_to_xe(struct xe_late_bind *late_bind)
@@ -20,6 +31,89 @@ late_bind_to_xe(struct xe_late_bind *late_bind)
 	return container_of(late_bind, struct xe_device, late_bind);
 }
 
+static int xe_late_bind_fw_num_fans(struct xe_late_bind *late_bind)
+{
+	struct xe_device *xe = late_bind_to_xe(late_bind);
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+	u32 uval;
+
+	if (!xe_pcode_read(root_tile,
+			   PCODE_MBOX(FAN_SPEED_CONTROL, FSC_READ_NUM_FANS, 0), &uval, NULL))
+		return uval;
+	else
+		return 0;
+}
+
+static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_id)
+{
+	struct xe_device *xe = late_bind_to_xe(late_bind);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct xe_late_bind_fw *lb_fw;
+	const struct firmware *fw;
+	u32 num_fans;
+	int ret;
+
+	if (fw_id >= XE_LB_FW_MAX_ID)
+		return -EINVAL;
+
+	lb_fw = &late_bind->late_bind_fw[fw_id];
+
+	lb_fw->id = fw_id;
+	lb_fw->type = fw_id_to_type[lb_fw->id];
+	lb_fw->flags &= ~INTEL_LB_FLAGS_IS_PERSISTENT;
+
+	if (lb_fw->type == INTEL_LB_TYPE_FAN_CONTROL) {
+		num_fans = xe_late_bind_fw_num_fans(late_bind);
+		drm_dbg(&xe->drm, "Number of Fans: %d\n", num_fans);
+		if (!num_fans)
+			return 0;
+	}
+
+	snprintf(lb_fw->blob_path, sizeof(lb_fw->blob_path), "xe/%s_8086_%04x_%04x_%04x.bin",
+		 fw_id_to_name[lb_fw->id], pdev->device,
+		 pdev->subsystem_vendor, pdev->subsystem_device);
+
+	drm_dbg(&xe->drm, "Request late binding firmware %s\n", lb_fw->blob_path);
+	ret = firmware_request_nowarn(&fw, lb_fw->blob_path, xe->drm.dev);
+	if (ret) {
+		drm_dbg(&xe->drm, "%s late binding fw not available for current device",
+			fw_id_to_name[lb_fw->id]);
+		return 0;
+	}
+
+	if (fw->size > XE_LB_MAX_PAYLOAD_SIZE) {
+		drm_err(&xe->drm, "Firmware %s size %zu is larger than max pay load size %u\n",
+			lb_fw->blob_path, fw->size, XE_LB_MAX_PAYLOAD_SIZE);
+		release_firmware(fw);
+		return -ENODATA;
+	}
+
+	lb_fw->payload_size = fw->size;
+	lb_fw->payload = drmm_kzalloc(&xe->drm, lb_fw->payload_size, GFP_KERNEL);
+	if (!lb_fw->payload) {
+		release_firmware(fw);
+		return -ENOMEM;
+	}
+
+	memcpy((void *)lb_fw->payload, fw->data, lb_fw->payload_size);
+	release_firmware(fw);
+
+	return 0;
+}
+
+static int xe_late_bind_fw_init(struct xe_late_bind *late_bind)
+{
+	int ret;
+	int fw_id;
+
+	for (fw_id = 0; fw_id < XE_LB_FW_MAX_ID; fw_id++) {
+		ret = __xe_late_bind_fw_init(late_bind, fw_id);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int xe_late_bind_component_bind(struct device *xe_kdev,
 				       struct device *mei_kdev, void *data)
 {
@@ -80,5 +174,9 @@ int xe_late_bind_init(struct xe_late_bind *late_bind)
 		return err;
 	}
 
-	return devm_add_action_or_reset(xe->drm.dev, xe_late_bind_remove, late_bind);
+	err = devm_add_action_or_reset(xe->drm.dev, xe_late_bind_remove, late_bind);
+	if (err)
+		return err;
+
+	return xe_late_bind_fw_init(late_bind);
 }
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
index f79e5aefed94..c4a8042f2600 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
@@ -10,6 +10,34 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+#define XE_LB_MAX_PAYLOAD_SIZE SZ_4K
+
+/**
+ * xe_late_bind_fw_id - enum to determine late binding fw index
+ */
+enum xe_late_bind_fw_id {
+	XE_LB_FW_FAN_CONTROL = 0,
+	XE_LB_FW_MAX_ID
+};
+
+/**
+ * struct xe_late_bind_fw
+ */
+struct xe_late_bind_fw {
+	/** @id: firmware index */
+	u32 id;
+	/** @blob_path: firmware binary path */
+	char blob_path[PATH_MAX];
+	/** @type: firmware type */
+	u32  type;
+	/** @flags: firmware flags */
+	u32  flags;
+	/** @payload: to store the late binding blob */
+	const u8  *payload;
+	/** @payload_size: late binding blob payload_size */
+	size_t payload_size;
+};
+
 /**
  * struct xe_late_bind_component - Late Binding services component
  * @mei_dev: device that provide Late Binding service.
@@ -28,6 +56,8 @@ struct xe_late_bind_component {
 struct xe_late_bind {
 	/** @component: struct for communication with mei component */
 	struct xe_late_bind_component component;
+	/** @late_bind_fw: late binding firmware array */
+	struct xe_late_bind_fw late_bind_fw[XE_LB_FW_MAX_ID];
 };
 
 #endif
-- 
2.49.0


