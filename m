Return-Path: <linux-kernel+bounces-868293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C96C04CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B83984E9CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762912F0C63;
	Fri, 24 Oct 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHiP9Vwl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F82ED844
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291811; cv=fail; b=hyWBcIM77An7ja3OZGjnV9IrIXMrNCZf6YmCdBTsqhRIYP85mzRi/K9YVoWExQ+g+c0lL6uvsyJ6GeOfbdcPkDeYvH6nr/fh6Sa6CoxHY8VR4wV5TurDu/rvs8mHOxdFKQpx1VBUus/nPmQpVAbIaQiJiWW6tzJqY5fXKvUnCT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291811; c=relaxed/simple;
	bh=8k+3g0MP+sleLtGWaUQfXqaijP+nal+QEJUGTm/JE5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJxKU1tl9PymngA2SX78c7iidZCvVr0h4XrE/d+SpU1rvt7DRVZOA7lBwA5VUnp8TRwVg4Fx4iHst2vzslVbzWFBMQiA7V67dsh5lWmDfM/9KmDbV8hxMYoQmHiIIbUauXBpbi477ymAyuIOdaGMkaAYNuIZIOrsQE3N3GyrZ4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHiP9Vwl; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761291810; x=1792827810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8k+3g0MP+sleLtGWaUQfXqaijP+nal+QEJUGTm/JE5U=;
  b=FHiP9VwlM35Gysv7kfobHfFQgzX9fxBsD+8HzDt5UZuqduQEkauzyiHJ
   P3OSll9aBqmIRnZ2cu1I3OyqVABVRxl1/0FqO352a3kswHgtbZ22YbKoJ
   dJgmwPukHxgYFs8NyZha2FESuSe8tHzLe/wlVhARvVvGIiKGCb4U/vIr0
   8ruUS3frrzbq2e/0tDpdhbVmAccFQ94F9RxWiU7ef7I2YY/U9E1uAjuz5
   CicZ+YGzJmKhHM0SVeg9e5xlBwaa8AyBvm105dGleOiIrW95ozGNa65o2
   dvc8qD6Jg9KjiPOYg1sLa2wrAsxM4v65kZnj6WW8UVOd5L55JNnMc1xZa
   A==;
X-CSE-ConnectionGUID: Ew23ae6YQpiiZNDWL4WoSQ==
X-CSE-MsgGUID: R9X4VE8iSyq1Ztlq7BBF8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73759826"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="73759826"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 00:43:29 -0700
X-CSE-ConnectionGUID: tnuKV4OURm+ujLNOnwZt8Q==
X-CSE-MsgGUID: ecytdJmtRC6+SqckM9P1TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="183543382"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 00:43:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 00:43:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 00:43:27 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 00:43:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2PdfVPZLvrFGvv0LmIMwHqqQ5TpgMA/btFRgM3yZrkmKQc4GYm0QYoDAyZHTc7NaJLGoqBS5fIp6V1iSpHr3YxFNcgyaPErWqLss041k4gsPbBrIk8/7FBdXw+TdKAiHtyf/b0LhxWyy01C9szzHa1a4hXtYqxE2nP2/JlFXzi9LvaDCpL/0evfv8rW9qpaHgl9qbP3W+I13/HehVvmHxi5olJ8EE+u6olKaCS+l82JqVq5tVSwSCSRCkUH8lRmgGaeRahv47IuFb9LTH8dZALWXo7YdevWDaPwzs6k71/hOL8Ut2HVLZzN37RGPw8ZpHI0hARucbHjQzXE9YDMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzzP+UEUcwXqOX09O1aq4bMEdle/O1XJ4uwRGIwG4Jk=;
 b=ZwhHkRcBVA19lRmV+axRIUSczLEJbYhiMNM4O6JdV3uEquQckSGgWd5KwU4On2xLsG2SVTujfLfEOnmMEZz9y6H0JTQ7ZhMJxP2G+V0hB5y3YWvfy3XdfNtFQV7pJnnyc0YPv5DKd7y+7LKgZrZFwEcN54scBrdrNMk8LmXqBg4FcIRxIEJ4jQJge8tMABmxCs7Xjqd5Of7vuTYVs4UbmlWlDorWJh1D0TTzZe354+gVhcQhlB616WsCtN4S717mqrL5Vp/i0qZ5rINFQOt1NUUXh5UR0+pkIRDmvIA4gM000tu0SqjLBbpo/t+kKuJQ8iq8hvj4AVdIxDNOfoooZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA0PR11MB7158.namprd11.prod.outlook.com (2603:10b6:806:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:43:23 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:43:22 +0000
Date: Fri, 24 Oct 2025 15:43:11 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Vishal Annapurve <vannapurve@google.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Message-ID: <aPsuD2fbYwCccgNi@intel.com>
References: <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
 <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com>
 <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
 <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com>
X-ClientProxiedBy: PS2PR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:300:5b::25) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA0PR11MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc7756b-35bd-4a2c-c7be-08de12d101f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x9jwP5GkJR2jjl0cs0VYjwccGFnGLFlpEDfYIuToqDpRfMt2P51ZvdAhT7B1?=
 =?us-ascii?Q?VoJzeHyM3pbYg3CipnxEf6k7QSuAwgv0ohwuT7TIiI23Gc1kXugX9OcO4CT/?=
 =?us-ascii?Q?lRPpJvFohoVzkf9ynnQs9H6OuGXI8iLvFihb0XSQ4QQj9iuW6jbEra7mOafl?=
 =?us-ascii?Q?1c+IaPR8Otm11988KrvJKDermFRz8snXuL0fW+7bUVM11fZK3aRQhabqkTXY?=
 =?us-ascii?Q?zBpaWiDQrj1CNQs0SncQNxD7C9vQZPffu1DlnGiAE5NZ2kxL/Pw+hsv7WGZ6?=
 =?us-ascii?Q?pUcjdcrgUT1ktwxCtJXd1SMtopsXAf+ptuqfuKPEfoy0ck39tSLtGqlPoO5S?=
 =?us-ascii?Q?wPRxmeyRlODIi+7SXiK+9Ah+XL7LJwH2oy+HZmtMBGFr7pqX/C3XWocDaEPg?=
 =?us-ascii?Q?EyDEp4n05MoSG4YtAYTD1nHP3nF/2JEnmuhSLPm6JqYbvJNirHMlT95tM2Vg?=
 =?us-ascii?Q?nbus3j9DADHkgmhLJLZZl+tjWpz7IQuxldsJYsajE3qrD1LrWx0mLY7pjuII?=
 =?us-ascii?Q?iZeHk481j+e+BTSw09latkgr5WKKgiR+L6tzOhNzXQ4zxVurlOhmegzii7Dv?=
 =?us-ascii?Q?L6wBiHxp1g5Uo6D0ZTMy0pDRkMw0uDf26VzfX4Www8JueDtv3MGC94CmLecY?=
 =?us-ascii?Q?FdEwQHLx4kmiNezxClwOmBXLNRZ1/+CHODP+XP6qwVW63JOSIaeDfZQnh3u6?=
 =?us-ascii?Q?zSYdEPGITIDhMxBDqIEJWuS0iTtsVQL0TTMCUvSVwIDc4UYpjSElnoeaShPC?=
 =?us-ascii?Q?ffpFKA6yOQPiQd+088h+cbr4Egn4Ehrr/Pyu+AX7dSJR1jd0dqvGnuxzHDqJ?=
 =?us-ascii?Q?Qwa2lDLWHQuTl1KOTRIrRk7NcyaboGa4hur+ZxLnC3pfPmyEDUQBhvxvKnVN?=
 =?us-ascii?Q?0w23GxIlYQsGCjXLGc5P/yJAzGPNBa76dde0OkkjhESWoJGqxlYRqJDHyrI1?=
 =?us-ascii?Q?8jfOBllzzraGNIBT2ZgOf5HdgEhJkEsPae0qZcjYsI9rxqlNItSsBi0A367Z?=
 =?us-ascii?Q?nUb2Nq5xQpFS5NBy9p00vxdsqLpLWhOfteCM7FcGL3NeCkSPGqfj6X2DdWmZ?=
 =?us-ascii?Q?TTVlHftklVX9vMv7kIdSZbQnl/afta3jao2DMyG++rMU205arQxDOZvk3+0I?=
 =?us-ascii?Q?cjrya0jbFeI6hgTiBTg1rJ3jPRR4bjEx0RUeAUGdEVqbeqZOIj2ipgGptesu?=
 =?us-ascii?Q?T4+kqHwc8kEcqi4tBTo/zLLCusDFl9cQ5mfpLLLBZP5XElj+whHhfZILTGeD?=
 =?us-ascii?Q?2ZSNnCh1UfAI5OgnfmXfT8/nHCUHA6Tt1XIZBKBc7yh+s56NKaFz3Z9X46fF?=
 =?us-ascii?Q?gxL5sJBM2avIPdY9CQ2SL1VUrII71hl8W33WT+ZkUK8DYkp3TywfADGnOOlK?=
 =?us-ascii?Q?N5J3SHmf8zvxpxDFrLJll1QNkzoKMe+stRGy0SpPZX/V3nvt94PQuQ67SIpl?=
 =?us-ascii?Q?xVEilYl4amL6Q++YtWBpSeR+zXf7mUja8x/0FJYRGKkEipyrvvpiVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iC02tCJfEjNXEu7A8AV5kdkPXop2pWyzTdwzD86RmjoQegEgErI3Q4hpvSxR?=
 =?us-ascii?Q?pvMFRxCcpppmN1HfxZkCpC02qE3s1sT8ie2t/Cw/8wqE6YCwLq/hhE78ZZJs?=
 =?us-ascii?Q?jVM4N/loMIBO4VzrGtaJ2hSxG8Qk1VD2cjmwLvocqAs4kypdje9tSQZPGORs?=
 =?us-ascii?Q?HVR/ypDk+oQK7cYHsp+imPnLEXc5dxT9G4M/q42A8EeIxbm9E3TaNRUy6sr1?=
 =?us-ascii?Q?qPiEqfn2gZxSpS+ZSX9XA2t3/xqKs0HUR8RoIP9E0npqn/Ke573eiU/X3+bf?=
 =?us-ascii?Q?Fi/m967Lxjme1R5aft+5oZdVW81yNu7Ryah55wl+dwah0icupQHV8EdydXCq?=
 =?us-ascii?Q?V9BAAPwwYg76UPOOi7R8KhhNr14+hdR+bt05zlPQC/6MNwqiHPfGwQorpCmm?=
 =?us-ascii?Q?0NvzLOzKfbzRzijeJrsBJ16GSO6AIq68HRdv5us925mNb7TnWTqnwd5K9D4u?=
 =?us-ascii?Q?WSqr3eIJOIDaxsgcJoeDX9ml6kEqcSaHyyQRKBmvAB0HwInTcxxk/OBBJ9V0?=
 =?us-ascii?Q?7eUeb7p14FOh0trDvFNRZcR5Fqzsf5LJvCBJl7wzF2GJ2gWKn0oe6TXrd1DQ?=
 =?us-ascii?Q?MSdgC2IfvLC9TbYhFyxXYdBBrc/o4vKLZTidCYRbSZH4OrTU7vG6StBuuXKO?=
 =?us-ascii?Q?ScOYckwf6RH2FJ2lqqUc6qTs/gPx1xNW/WVYtvJTy1L370+7Gh9PQjQO5bnt?=
 =?us-ascii?Q?RvOuF25aMwXFo5kWPUhfTzxjTC1KaJRhmekasoSbypswE3YWF0Wt6Ue9pyUQ?=
 =?us-ascii?Q?7/MTM0fhJ/GwkJCjJrn/30U9VJ0hilqbW+AKc/ljHodhArJhyTiZnBnu3GXM?=
 =?us-ascii?Q?4zTD45loXZ0jkbOmsTVuMfmfd/ZQ04Cbx9f0ABIsgD5q4bZ9YFSEvtowlQWY?=
 =?us-ascii?Q?/VE6PLzC0tJLFQXHsflWelbqFconRka8z9siCMdYs/uCmiUWb4oV0zqG9P5w?=
 =?us-ascii?Q?SC+X4eY/aX8F0OSDDXyJSJaloed0mJKJGutPN2luE0HBsU3WrKUVchouGHop?=
 =?us-ascii?Q?1rAbo2vPmwznT08TIKsdwfm8eyJnDIDz2AxVsfJu7kVb3/PB8Y+yMRlD0ecG?=
 =?us-ascii?Q?ffPYHb8uOht+YFj9DqOp0RJ0Q6Pv6LsUKcAElOJrPvVylbBm5WrZwQtfILV1?=
 =?us-ascii?Q?iw7P3IZvz8M8PEEAuF0g8o7utASbdnyP5QJSXoTMTVc3dlLEHzfntd2CoBqk?=
 =?us-ascii?Q?nnNKcyqsIpYgfgAIKI+ZoH1qDCYgednFblSFoFppAMqZYCPCA4mIIo+cNQp0?=
 =?us-ascii?Q?/qkfrFUhVyRBBuwmn0is+yvjC7TVWQ3nL17FlMj3NNH4iiduRsS7+MZPzhyk?=
 =?us-ascii?Q?Y3agKFWOfnrQibQN6x8PwVBbeuQ8EunqlMZz/m1fst/5k5qc+cl9D0d7ud3m?=
 =?us-ascii?Q?JbTPPL+Ftt+6P0k9LJLXBlToddRO0g0j5ozGREYTQ/B5xzYWyXb6degYGTv0?=
 =?us-ascii?Q?jjY8uD9y/MTOHRPcel1D5/YlyjO9jIjJ6RnD7+se/qYHnQsMoDvyThkl4ulW?=
 =?us-ascii?Q?R2/ueuj2Ajfcc/+XuXcRJ3joyUfWZGQz9iFHCUelvjHFSCq8jW92qHsYaSDd?=
 =?us-ascii?Q?rFcfNJLBS/kHvSleaSoCMNP1fGkp/ZXo/gUry5sU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc7756b-35bd-4a2c-c7be-08de12d101f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:43:22.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsoeVkxKorc/G7we4caLhLa0qGvEKDZkNPk8RAue5H03fVoje4CRWjWk2DvLv04hYmeYsZDW7FASA0GrV3CcaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7158
X-OriginatorOrg: intel.com

>One thing I don't think I've heard anyone be worried about is how timely
>the update process is. So how about this: Updates wait for any existing
>builds to complete. But, new builds wait for updates. That can be done
>with a single rwsem:
>
>struct rw_semaphore update_rwsem;
>
>tdx_td_init()
>{
>	...
>+	down_read_interruptible(&update_rwsem);
>	kvm_tdx->state = TD_STATE_INITIALIZED;
>
>tdx_td_finalize()
>{
>	...
>+	up_read(&update_rwsem);
>	kvm_tdx->state = TD_STATE_RUNNABLE;
>
>A module update does:
>
>	down_write_interruptible(&update_rwsem);
>	do_actual_update();
>	up_write(&update_rwsem);
>
>There would be no corruption issues, no erroring out of the build
>process, and no punting to userspace to ensure forward progress.
>
>The big downside is that both the build process and update process can
>appear to hang for a long time. It'll also be a bit annoying to ensure
>that there are up_read(&update_rwsem)'s if the kvm_tdx object gets torn
>down during a build.
>
>But the massive upside is that there's no new ABI and all the
>consistency and forward progress guarantees are in the kernel. If we
>want new ABIs around it that give O_NONBLOCK semantics to build or
>update, that can be added on after the fact.
>
>Plus, if userspace *WANTS* to coordinate the whole shebang, they're free
>to. They'd never see long hangs because they would be coordinating.
>
>Thoughts?

Hi Dave,

Thanks for this summary and suggestion.

Beyond "the kvm_tdx object gets torn down during a build," I see two potential
issues:

1. TD Build and TDX migration aren't purely kernel processes -- they span multiple
   KVM ioctls. Holding a read-write lock throughout the entire process would
   require exiting to userspace while the lock is held. I think this is
   irregular, but I'm not sure if it's acceptable for read-write semaphores.

2. The kernel may need to hold this read-write lock for operations not yet
   defined in the future. The TDX Module Base spec [*] notes on page 55:

   : Future TDX Module versions may have different or additional update-sensitive
   : cases. By design, such cases apply to a small portion of the overall TD
   : lifecycle.

[*]: https://cdrdv2.intel.com/v1/dl/getContent/733575

Given these concerns, I'm not sure whether implementing a read-write lock in
the kernel is the right approach.

Since Google prefers to "avoid updates during update-sensitive times," we can
implement that approach for now. If other Linux users find this insufficient
and prefer failing TD build/migration operations with strong justification, we
can enable that functionality in the future.

What do you think?

