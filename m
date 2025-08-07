Return-Path: <linux-kernel+bounces-759330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB69B1DC2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D17016FA86
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21A2727E3;
	Thu,  7 Aug 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNeHtEIY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497A1E832E;
	Thu,  7 Aug 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586146; cv=fail; b=dYP6uVzqzhtNzzwLOlylLrNqMUcKsy7mefI2DljQIK5rDTUnCW4JKVsopHNB7XJalMXzsqoFfstFg/sTJeCNFuauK1b5jtiihuUxs12CewptwI1EPddJWH8K1CWZ7OQKtFWhL5miM7ZmXy4WnxOgdAVArGOunuYEtDokhRTkY7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586146; c=relaxed/simple;
	bh=kITjiBUAEhv0zJ1rNeRE3bPkbHyxZCpj2rwjm8RirdA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VeYj3EUR6rwzZ3TK1Snxna5wvnTMT9Os4WeDdYL+OcH0++JyoszUxNfoYw1P/rva8uyMhF/55RhrJCRMLOwWed8+r9cWs7Q8Q+ItIeWxzIfotiZCdX+3UbyWOmkzzz3Mlso01vC91Mqb4sNytaJZmutgwtveLqTOTFY62OTy420=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNeHtEIY; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754586145; x=1786122145;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kITjiBUAEhv0zJ1rNeRE3bPkbHyxZCpj2rwjm8RirdA=;
  b=kNeHtEIYnU59eDuwBT3li6isAuZs9l6ChXxGBbmzaJdXd21AF3Pjabb2
   d7hk/pDWQ8TZZb4hwZIIYHErJcMVsMfdGkQTzVLKm6gscsLDK+9JHYO7o
   jnnK+BtiSKpR0/FUhgwVESPxFwCY20HNqWL0iQXa+x5MIF5htaVchHeTJ
   nr3iWuZycBJV6qaazCrXC2hDFK7L8CPHPAU+mm6LGAfzfAAo9kIZHMJsP
   gW1IJ4CPI98IxWw30Wb2cBP1VRyMVqIEl2d3jRtD4rYrChZCmZjNL+58Y
   0oQZCxA0yIIaNrXZYplbO5RDGm6CQxutozWaE+z0w23jukmuiC/GSWKn+
   A==;
X-CSE-ConnectionGUID: AN/dnqZaQVWLwsloliFhiQ==
X-CSE-MsgGUID: 3QAgcQGtTSqkOSlV/eIjUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68010085"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="68010085"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:02:17 -0700
X-CSE-ConnectionGUID: tNaHxNnvR1mn45hwSUeXyg==
X-CSE-MsgGUID: sFtfw1OGQrOwOz5sq8WfBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="202276873"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:02:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 10:02:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 10:02:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.84) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 10:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnUAGEe4bNrAvmkIhcWVUvg6cO4YTr1P19SAN57czIq/T7EHO2F9D243qgS7PW/KugLaRsQBfJ4kjoh0hm2JOJz+7hGbrLGnn3ykWXOCjlQBps/T3AzNKx7ExPzN9k238sEbFP3GMSrPQLNrdlMdphDNxOxWviJmUmXrq//DJ1XX1N8we4ALEjoGNxhntwqEq4ABoVFJgo1Lr+46acA0nsYrdi5lbhdkBQl3bDj+BvEjKj+UA1paCAIOLH98Mzp+3+XvA61Y+Zy3NQ4uuw5JacFt8sPL8witv186bPgNQd3F0kFQ7LG0ft128as3EUqRrIZoXqUPR+/dzMo4YWm6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCG61bt33+UquPm1BCTfzvCuMvcgGdRrMezdHoM4vVE=;
 b=OcF60zHHYx+MI0PPcloVdhtML2DYiW0DWSLS4s7ssXG2ZkcFuhY5F3Ny8zW5RpLj5zC2ewDt7v7r/l58dxPW+gp2n+Z3N5dcppCK3r3P/qcchtkKokYPByPc7qj89fwKJ8QJyrYdBtWfJyipjO9EHTQSSMiIVHXTgh9/5eCCT48+7u5fvw1psScfYmIGxQ4mOWQBZrVKwoae1OlH3AGYjgICBPnw1J/k+qFtaQhnKIYTrswiRbcvAMNC5BuQZzflrss205Cs890SG5oZybhoyFFH6FTgOQMMV+dv1hgjZ8ERxWhdCOk7s6o08dZgTiSIRjiTEfg4Ch7icJhzju3lLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 17:02:14 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 17:02:13 +0000
Date: Thu, 7 Aug 2025 10:02:10 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Lucas De Marchi <lucas.demarchi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Fix a NULL vs IS_ERR() in
 xe_vm_add_compute_exec_queue()
Message-ID: <aJTcEsre+eBb6Tyn@lstrano-desk.jf.intel.com>
References: <aJTMBdX97cof_009@stanley.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJTMBdX97cof_009@stanley.mountain>
X-ClientProxiedBy: MW4PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:303:86::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SN7PR11MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d40ee2f-aec2-4cfd-0283-08ddd5d427ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ng2iLW+2FVKRsGqXHlpqEilBX46NqmFguJK58qKxbp6j0sdRm1YmXIoqlfCj?=
 =?us-ascii?Q?pmNVUNaLadqwn1ZQWYC1zi4mUUusXHwu6yXVwxZma2r6EpB1/BQSoKwkdaou?=
 =?us-ascii?Q?H9ugWXF25nGarhIS2+dDj4YjnI8Pb0r75JUd1vuUeyqoGhjX1rX3Z93Dnjjt?=
 =?us-ascii?Q?X3PEZUtwFJJA+nj9nnvVLCzCDqWTfGso2TZqd4swJAsxN81tElqkUEZANsml?=
 =?us-ascii?Q?07P0wHttA0BZd/VSq0j0oa1SHDupCjYP1DU8lX8LcegEsreKeL09FnEZRsSr?=
 =?us-ascii?Q?MdMjT8k4Bcqfl+r47btmqPkRkOhsvbS2wL3h+3AYBBu+cRviSbez4002AUD1?=
 =?us-ascii?Q?Q8gWl/oVZxw/FerAmBEr7qUqfKq0bAdsNJTUubtMXgOwSvqCiGNv4C0kHbuW?=
 =?us-ascii?Q?3gjJBb96Kio7BoF8KwUnRuzW9aSlkBpRnxOUGAmBOjnPvbpNXLzWiydH160W?=
 =?us-ascii?Q?knBj6XEUSnIbusaDp9nSGzIJyzPLvGoRXPp/SgM88++VL8Fi2PkUOG8q3M1d?=
 =?us-ascii?Q?NyyHx9lbZ9isTz5y4+lKrtMlStPvn3yd68+ULl07WulNgfekGjPUyZsyF6+A?=
 =?us-ascii?Q?AB5A4GXwnr0Oz1sk2h4Hjro7ccvrRorzxffFvQHx19WKXQ4JTyJeaYaUEwmA?=
 =?us-ascii?Q?ibT8j1xFTykaFl9oCbbxiHzkmOZX65VA4fzu+H9UDDzht++E10HLXs2KktPQ?=
 =?us-ascii?Q?mcEV0CNNrvf3otkJ8pIeJKRj5LYR68L4KEfFSR945laubtfvSfJucSxZriLo?=
 =?us-ascii?Q?cm4eTbPgolIFbAs3Sx2vdAgJgAY9U1Kqdplw0eIIDdv1hD8QX5KAC+4HQHvM?=
 =?us-ascii?Q?OsfUiJLEI35uw1mVa1cZfIDppwByZ28xLRkcg6SV5Ox96MSgCX8ofLsAhkqb?=
 =?us-ascii?Q?gjY08+kJTUKcHG7LIhTJaq8fv4vQSEmVwb0I7KAdwfezxVyEtNvgiOrgegnn?=
 =?us-ascii?Q?qDOUToSUvOz85QMcmOum0rUAqo2+qWeyvkRTMpMS/JxRrXPp+C6CoRh2TKTq?=
 =?us-ascii?Q?LMnTwe7P/B46f7gKC/AolwDM1Je7qFyEQRESYEHkbZMBJNqjdmB03WUj2mSc?=
 =?us-ascii?Q?mYLYUten+d6iQDxWlK9ey9AKcEMr4oQudcWKrVTEu+X4yxBKy2B4AqNdpPa6?=
 =?us-ascii?Q?L+PA11mH601sfCbPxkGNH2tOpFFJCZC/8Mo3sYYYn0YfVGjn4ybVgEEyu4Py?=
 =?us-ascii?Q?rGyg9oqB7ycuztr7ud+WlHYVFdndn19mjLhXGY4PlBl1Wte38JqoM2xTtVXM?=
 =?us-ascii?Q?TOPnzQtji3AfDGv7zPMrQU+MXwoLSnihq5ZEVyZU52YgNFu3HTU2L3bUCHnP?=
 =?us-ascii?Q?+nNhjoIgoDdt50YiqosVH+/pbLwuK4Du5ycP/PaECRNlNUXiQGhmkiWTzIaS?=
 =?us-ascii?Q?2FNE9/pV0kM2gc6F7wbhPiidujJErN12Le0nzgGjwUIziVN41+KItla+wzZ+?=
 =?us-ascii?Q?xXnKFYZrApI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPXIORK4DPZ7XmmKjqN5jkgpr/xsr6GSEdqgLJh2m2fKX5iW3b+4l4V5XEVD?=
 =?us-ascii?Q?C7Y1tNlIWkmCRJOYE+P3lQl6xF8NKvp1a0V+k9jGt09w4koxDhf/4tWW64bf?=
 =?us-ascii?Q?DEfdCtoGWNwYqQat6tEXvV/qAO+kWfPvUkyTAv+ONDANmk60XqRLeiOI5NYC?=
 =?us-ascii?Q?hLbXc5MVxzLA3gpz+0WFWjV3Dc+lN++es+6mzqgv8qQu+BBLVlwqd8EuIKlg?=
 =?us-ascii?Q?xhw5pi94ztBX3ZVNjqGaNDm/SQWiCJD2JQDeONVzgqgWQPlRbWAuwf9JVJQo?=
 =?us-ascii?Q?/ZLqeY3QA5MXr6NWKOSNqHSpZ53UAFHtKXZ+mve7TkKzUrB3cvcHJB3ufhqB?=
 =?us-ascii?Q?1gBmoA2pczM6e+LVe+XB1qK6g5i7RA/ye8t4BBTgPhd9vTV+7VwO6T2id6mK?=
 =?us-ascii?Q?YEzaeLKbDnlfLv2nB3GtiaIuBv/rwl2WTZ5u0ODxeipryDdxB1RP3eZS1Ng4?=
 =?us-ascii?Q?ZDsWFiFf806+uTTwhOx+l5liArK6Uzyt76xLhFRFKKpPHqJc7i5sY61b81wj?=
 =?us-ascii?Q?f8+5O/LStSyAhnIcJjX/agQaV/7+akhUuk2HkazZE2Q0dx8ehFp/cA662o5A?=
 =?us-ascii?Q?pQ3xrHE951chQhpVQH4nU0p9eRBJUFzq68NT2MKhT3TA+cEVAJ+zCYg0uB/m?=
 =?us-ascii?Q?Tbp7P5qmkIsTYqe9N6D6Nsu+92W5DtTo0lA6HCOyUOQhP4zCMdnhBKmTJEax?=
 =?us-ascii?Q?Lz1IKJb1iSGmcWhcA04CpB1mng3txMdPXSHx0NHamRVsH9m4kUx33Vytf4SH?=
 =?us-ascii?Q?9uMYR6Z937Pwp2GzWHYo2UBMTVDoItkEikNC5PzAY3sWQ4e1rXnMQ+AHg909?=
 =?us-ascii?Q?jeNhOcPzMSAoFWHm2w0Jq24NMAQS8dtGged6MWDFDwMA+6+7o47874KqtBLh?=
 =?us-ascii?Q?3o+0I878jivxonQ2g9HtWzu6pa4IjmoIKg3AAlsukhtKKUW3OtMkYirxxn4d?=
 =?us-ascii?Q?cyu7YfzSYB8w4+zS7UcNX9asEPVePGJjKON6OuaPkDxDPG97yHwxaPPOEgQv?=
 =?us-ascii?Q?HWgtheiCFRQ7w6t60pUsqVl7u3PpfJufQEAQie+xSJYP9jHsKgxvIAeC1S7H?=
 =?us-ascii?Q?ZAQW9eg87yIc/iF0h+Sy75IW3D/+0OFKIyctUWXFzszA5xv6qoew1Hxle2zv?=
 =?us-ascii?Q?dWp4IszQEPw+OqwsOeTAeOKwRCQzUzDW27zWzIuI78eecy89TrRvEzMmxBRr?=
 =?us-ascii?Q?Vx7eG3IpG69qNKQz9PKo8MzAsL+BQs2njypiq14kSJ8QXPmKOXs/QTyoyDSs?=
 =?us-ascii?Q?64/bUEy9q43L0w/Ss6nohqOsj+8MtSJfAY3HamLbwC7U3nTBk5eaQY9zxoLi?=
 =?us-ascii?Q?B7e7XbyIElYCkqJGqhfiCuXSOaYtMNoZM/xRVyra1ZdI1Gi5JPANzyN5uOJr?=
 =?us-ascii?Q?ysznN9S/rT/N7pLgXkUD2oXC4ilYhIB3pTDTtQK8g/AZ75AWo4YOD5QN+Q1c?=
 =?us-ascii?Q?eCXd0vrB18AEha8CK6Ppt6GitvWZgI/3LcQVSxoLzontw/k7LOzhvu4V/9+T?=
 =?us-ascii?Q?V99qvVHnzhVcmAW5fv2T78xTcn4Rp9wqg4ZsQmKsiuFM8nqeFPLdhvoyh30j?=
 =?us-ascii?Q?zg+fepUhcygp+CKPyL/fwMcVHi2CQGlsFPgsO+mPeyCEBWGV9U2Vrx8T0vt2?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d40ee2f-aec2-4cfd-0283-08ddd5d427ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 17:02:13.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnrdPZam3Zey8J9/nxe1T4U1tzrUF2G+6OWHx7ohI1Iv/SObQwZ4f02E8iCjg62HbOnFvhUmqGdQDWc99FfJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com

On Thu, Aug 07, 2025 at 06:53:41PM +0300, Dan Carpenter wrote:
> The xe_preempt_fence_create() function returns error pointers.  It
> never returns NULL.  Update the error checking to match.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 432ea325677d..5c58c6d99dce 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -240,8 +240,8 @@ int xe_vm_add_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q)
>  
>  	pfence = xe_preempt_fence_create(q, q->lr.context,
>  					 ++q->lr.seqno);
> -	if (!pfence) {
> -		err = -ENOMEM;
> +	if (IS_ERR(pfence)) {
> +		err = PTR_ERR(pfence);
>  		goto out_fini;
>  	}
>  
> -- 
> 2.47.2
> 

