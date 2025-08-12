Return-Path: <linux-kernel+bounces-763801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F5B21A75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FFA62408D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D1E2DE6F5;
	Tue, 12 Aug 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejYntM1+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D782D94B0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963991; cv=fail; b=qZzrsenCJAMMYPAfgkY/KzjjPVxWPHbq1C1sTfGorD/HhK0EbuPjCqGdWtfb89nz76IGcmjOaGrGTaSafJcBjZ8X4VVe+7TDNrPOWl6rQxCncDKDaKGRwRw8t2tOkIqCJNaUx1Vm5ZPd+hccBxfbfX22zPRkuJCyNabu9DpfiUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963991; c=relaxed/simple;
	bh=4mgo/M7OOHzjZfh4HmT3cmpuGjSpUO5JaSuOPKIeWBQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aI570uS/ssfmGQZiOGuMGZLH3SpYaq8IQ3bIi8f7+RxhnLgAnzHOmGtuGwn61JNf7VtYQfkIVRsDrNCjBtAVLi2Dd7CXL5x2KNwcgCFOKk7ozO2zo2VS/Q/YW/ZIBs2GHcoPugNtN903OzF9Ig9cj0Izxgx4/6slcccjGwug/IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejYntM1+; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754963988; x=1786499988;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=4mgo/M7OOHzjZfh4HmT3cmpuGjSpUO5JaSuOPKIeWBQ=;
  b=ejYntM1+deInNeXIIjGm8HB52OOVcSlAcc3/kJYwGdhsIeGL5Pd40JxB
   pikFhekFVZgnhgYtdrEbNw5lCt0k24B1aJ+evDNOfJ3RV5EpE0OZ/0R5n
   CZkwP7DknGjcM5AlFLLd769YSxs5P+PdtE+erPCwThz7C/+HVhLJfDiaX
   BWkDLp2Ov3ci+sOYJD/MUXgdKbsy56OZ4lYfRhXDGj5GcAjwb+9DC3BrJ
   lHcM293MBrtqMzb5ekdnfiR83WlqL1X6Pzk4cAOW0ROr7waEEeGhZlQfR
   7DA/857OhjiM+hucB49PZbRpbA76nPnLEhiXpfj9aY1qXVI2Wh5BQGMMj
   A==;
X-CSE-ConnectionGUID: sV5AANKYR5uAEJ81E2yX/w==
X-CSE-MsgGUID: Gu4tIFuxTieYJejYZ0Naiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67829098"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67829098"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 18:59:46 -0700
X-CSE-ConnectionGUID: EmrxmqBRQLG3abWwNjifJw==
X-CSE-MsgGUID: 8Ug2P0viRmeqIqRarBUHpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="203251468"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 18:59:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 18:59:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 18:59:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.89) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 18:59:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUdVflHZxKPRmSQL4bNYcly77K65iq2k8J7pB+R1A7OgdOmmFm68ojSybWcQtXv6ot4cfE/6xMjpPufML+zKdCiKSBNtXbKJ3gTzKj//nbPRvK/t+Ca1xC0YmsYaXVdkNZl0EKNaun9d3ODPSF4js5Vp8SCpuhkPsQAqSOICo7kxWu1L1eUrd459hBLaE63E01lkezXBRiWOK11qFngAMBZVn4N/kjkMD6tOplHcNn8LxMQiBgNcUS/qH5c1j2SbQRWtuCD6fCkI6VatyywoYNCyGs9LX1dF1FTGNjqvnfXOLyi3oqCGsqtyJUJLOIvDvHaOaS1uFUoL0dKimv3fCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or9NLJk/0masxfPTlQTXvkD5CsaBvmqI1ii4XqFZqQg=;
 b=ZZYjbdlhAoW47Wm/s+t9TooXutstm1pMqspep/i8Wo2PlY+KQbKUnFkFb4xKMxXafKc2d2nchwUIQ/zfEPk/NzKH21W0K+wZhanK2FFNedutAdJEHH7mnjD/8CBp9jbz4IF5UQLgwlbNIvM3tnHWf47quW9x1+obla9JV2HUKC2kRUaJQRPn8RoPV+OqsWXRoTpfhG3iZVsPUU7/HSTkLRe0W3q9hS9nT9QXYgk3wYCLs9G+EEWw9uxFg0Yhjj+pxWqBwyK159fmsX2qU6L87AV+l35TnHK/EZoLMEJI/ONLd/t7FbX95prIgjM8zcgm4ZmRG3JFY07o7iAhNwUnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 01:59:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 01:59:42 +0000
Date: Tue, 12 Aug 2025 09:59:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chen Yu <yu.c.chen@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Libo Chen
	<libo.chen@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, "Hillf
 Danton" <hdanton@sina.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan
	<tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown
	<len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [RFC PATCH v4 23/28] sched: Scan a task's preferred node for
 preferred LLC
Message-ID: <202508120315.19f6266a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178bf43d7cbc9b2c9aea408dd56b87391067df37.1754712565.git.tim.c.chen@linux.intel.com>
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV2PR11MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: fb02b23a-172b-4ec7-a969-08ddd943e6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PUBxJP0XJ/vHR6b9xTz4+lFdc5f7xAQan1XRGvRkM51lFOCbLKpsrALF+n2V?=
 =?us-ascii?Q?zB/BBJwqR9PSrXQGSKL8f4mT4rZW83TT+yixZfrVsSsb2TK9QrdsHfu9LVwS?=
 =?us-ascii?Q?Qn8867NbGAqFoYs0bt7b/parGdIvAbzuredCqzs4F7ylcJFswvyfCQqhs5VX?=
 =?us-ascii?Q?c4CCrUpY/29Oi00ia6qjth8qQessq5mUEfAnW4pCZB7+uhM4U5SNrFLf/bg4?=
 =?us-ascii?Q?I5RP/kRa7OaTNAog9HCGHdrzDNyonvfkpbvGLuYgiHgCFLVTFDdPVPW8AW8/?=
 =?us-ascii?Q?YosaXq7R+pKJGomMNqL5jryFXociXmcteyQgmgu3DHDJIBloqXmAAWMqbjFN?=
 =?us-ascii?Q?bVS/ws/VBDO73IKb3/RZcePfjNVaYExGMYCPvnkZv/LgpkOLkPf2iUiYtlWM?=
 =?us-ascii?Q?Hm4HMYgS1Yo921uhyHo6AAOmeeRHWW/8VXd0sm6GQV3zn3VffA3hYEB3mZiW?=
 =?us-ascii?Q?SZ7c/ZOIDqU4nuiF5wxzFUmuAVfTi4Iy93I5xSBUkHPwsLOlhVLCo7FGJKYq?=
 =?us-ascii?Q?6uCXKnFe5BK6DFmCCLKTPLGGHE9AWTZOZx90fwpr64h+LLDltp3EB0d19hbG?=
 =?us-ascii?Q?rRID6ku3X+rb3kV15mG984XL+9DGDjoIxH7t0yeFD6m3bzs2XAgiIcPIBXzu?=
 =?us-ascii?Q?LolBuEm19pkd/lPhy0XQEfKcVvCQSH2jPGHI7wqE+SQQHudodQ09gQG/uN2k?=
 =?us-ascii?Q?52Tj+xS+xyMxAwgNxgJS3Usfq800/V7BXxtvSAKeIjbSyOhKTj/NkRIDnjJl?=
 =?us-ascii?Q?1e5BGijbDfJ5CNQ+A06Wblpw2TSBfy8hAcvHOLLjMkplpdkTEiSHQ3M1fFvW?=
 =?us-ascii?Q?B62MSisJk4XH0bK6tOpNFwa0ieqREA/f4+QVrQNS1Ec/UFmyd1/7aY1ovYQU?=
 =?us-ascii?Q?A39EjE4bMYy1u1fFVyPMGxqXnMpALxlWQyNzuAQzw72sOxSsXeT811BSebRH?=
 =?us-ascii?Q?TwWHV0I7gskiJ56yEIG5T6nlMp4+vLGH1t62+q1rK9NQigYaKsEnaekUe2PF?=
 =?us-ascii?Q?45Sxfmt6BnZL/hjYCgP6YB8wCVscV2tJfY9pf4d6spq2WocSPC5PtnBn7cU5?=
 =?us-ascii?Q?HK8q63r0ISYiTAF8QTzgxSqPPAwqqE0gdOS7XBYsQ0svaxrJdMTnDjPAP8xC?=
 =?us-ascii?Q?tKrUjvWhH5hSX3ACtUUzkH4w4DRAmXQIC54qBnExNVviwbr5hquYmvZO1R9v?=
 =?us-ascii?Q?F3kMq5la0xGLQBeiYVZrVPgjV/nhg4SXlp54SRwCIrUF7haFsI384l4AbZrC?=
 =?us-ascii?Q?8d8W/7C3nbLcctKi5pSMjVlOW34ZQAC1r+sCPklxHYjJgzrt++cpMFlBmz9B?=
 =?us-ascii?Q?Kun6hQ+IvZtJxnfBk3vMCVnx9OAX8sdMryMLepkZ8cZe9rb31CptcNA3gBQK?=
 =?us-ascii?Q?yMGaD6IV2ePIucZS3hkOn+nK948w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wOmIyc30Pz6ISOjc/89Y+Cu1Ze0m9wiJ83uKu8848ICC0NyMVmv7LkoYz2rn?=
 =?us-ascii?Q?h158t5zcGGF8vevZZpNKQ6XRNjUAxXiZbmdKUB/lkFcRFRz5J0eLi2dCNr3A?=
 =?us-ascii?Q?qmwYjWI030BEruz3YhSOAH5vYERbT92Cx62Kuz26br0/oTRc8rZaT75IQDFz?=
 =?us-ascii?Q?AN3Q6vy1VkNKUdzbocQmdxXBDGr9ueHMvizG1EM1rUAlZ/juVsWTOVjgBHPY?=
 =?us-ascii?Q?mGKzXRPGVwRHaJwElk7JdGtG7+TSm5Fdw6B7WcMSQkdOle5mvzyx2q6cc7lK?=
 =?us-ascii?Q?3Vf+WXZ2HMgcTJCu137lPfDI6wcz9eTq8ldHk8yRu/NJlA8Jq0b1BODjog7F?=
 =?us-ascii?Q?cfl8N+NYBPbMfFH2cyKg0w9UZODrafAdlugolnNM3dd0UX9rMDIYaduiVTd6?=
 =?us-ascii?Q?0k0lw7CxQWOazDp3NR4jdlgJEYp475NO570yRP7YR8y7dgy2kl+BfqA30PDU?=
 =?us-ascii?Q?JaUU+nF0BLEy8iuNcykr/HPKrBRezeiNuqAqivLZ1hgjsHjB6zD6y8hKa8g9?=
 =?us-ascii?Q?8cew4ah5HyTfISemTd/uI2jyU3GiIBPeT5wiFeZUojZQQoc3wK55bSIMl7TA?=
 =?us-ascii?Q?AOOyoDtiXeJzHGkObSTQRJ4Qf+q4y2OwszYaw0QPtzXM/esio2MHLAxziYp2?=
 =?us-ascii?Q?dQ8SqVUixqQUFmhlvWVT21RJDPk4Oz9nMQmmx8n1pqIxvUM+PzHFUDX738TV?=
 =?us-ascii?Q?64D6uW51aFe67HuK9wZTdrPgkJvwG2oadD4ZGqxjrWF/YS9tn+060vTi3Nuu?=
 =?us-ascii?Q?BYanZ3LhAhkACTQ3MgP0rA6kZcCpDr8UVJ2gD+UsSr/HHHjamkzt5rmMI2CX?=
 =?us-ascii?Q?w6SSPP0+nYBNiqf3a2zpDB3yrVTEDB2vUN9QaRIUmssc/pwg0T0grC1FsFfN?=
 =?us-ascii?Q?QqXBuYHq1I9DnK40oV9ZqVNo4PA28ZIbyTK+D0s1b6yEHJMc6qqe2b1YZ9uA?=
 =?us-ascii?Q?3jRTusZMBiDqa9ceV4n2cnF3r1zIHT/4Ic3Ucd30ku8DBzknIf1b9u6R/8N1?=
 =?us-ascii?Q?uohk9KDdAiLFBkv6Z0j3EmqgzrWJeC6WyP69O5ZD6ZBp4L33EtabUSfPb0nm?=
 =?us-ascii?Q?Kx3PtR3u7KlouVQNwXSJOehCJ5R2uwrKsGhdeDQLH5aMsTkMvSEJ8t30ovE5?=
 =?us-ascii?Q?+3H0M+HdAYppyP3AHOB6MdfnUYXVneY6T9/cBRvALm85ckfzhFHa/Gc9BRpW?=
 =?us-ascii?Q?D/ct+BpK9GqF7gjr/TU5k/U+s62I5SC3g0qHWLkh9fFxquzLfDsP5S+CD2DW?=
 =?us-ascii?Q?ApJp5/5G507y4azskCBlN7kuV/SC+z+6KWFxWQ5QMwa6WUy3BZ+ByoxKNRWi?=
 =?us-ascii?Q?Bn546qJSa9eNKYTt3R8SPJqxwP8fUqLK3oRNZbqWHzvuAP/ZPLdCqQy9FAmy?=
 =?us-ascii?Q?/dIqfXIWu6aV3N5tTzqwNne5goj4+2N0nDqTPWE81x0+ihfdu4pPcK/BSiX7?=
 =?us-ascii?Q?xA1cLNFD8vA2wGQ989kTY3S2UmlX28f3e3N9mIA3QY5ZlG/cR3nAO3RXKfUw?=
 =?us-ascii?Q?L3PFvtTGufsz0AKKIQVpqgW+z6ZRdB4dlIlNE09E2gs3SFH44OGAvgjgpiK2?=
 =?us-ascii?Q?qCiNNoPkMqCpKjhI1RI9c7AlcHqQs4QUfko4hj81KT2GyxiT9jM4DgzhMSYs?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb02b23a-172b-4ec7-a969-08ddd943e6fd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 01:59:42.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jqkBpKHwNGexrome/tP1E4yTrafeR1R7/rJzQtehIRf7JjbBOKf+bfzvVmR1BQr/bv0ZSCsBTFA4tXpWzFOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: ff797757d658ecda432e4c33c0cfc2b704af2b06 ("[RFC PATCH v4 23/28] sched: Scan a task's preferred node for preferred LLC")
url: https://github.com/intel-lab-lkp/linux/commits/Chen-Yu/sched-Cache-aware-load-balancing/20250809-131716
base: v6.16
patch link: https://lore.kernel.org/all/178bf43d7cbc9b2c9aea408dd56b87391067df37.1754712565.git.tim.c.chen@linux.intel.com/
patch subject: [RFC PATCH v4 23/28] sched: Scan a task's preferred node for preferred LLC

in testcase: boot

config: x86_64-randconfig-103-20250810
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------+------------+------------+
|                                                      | 552a2db758 | ff797757d6 |
+------------------------------------------------------+------------+------------+
| BUG:using_smp_processor_id()in_preemptible           | 0          | 11         |
+------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508120315.19f6266a-lkp@intel.com


[   19.177186][   T64] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/64
[ 19.179622][ T64] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.181347][   T64] CPU: 0 UID: 0 PID: 64 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.181372][   T64] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.181385][   T64] Call Trace:
[   19.181391][   T64]  <TASK>
[ 19.181401][ T64] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.181440][ T64] dump_stack (lib/dump_stack.c:130) 
[ 19.181465][ T64] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.181494][ T64] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.181514][ T64] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.181531][ T64] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.181569][ T64] ? lock_is_held (include/linux/lockdep.h:249) 
[ 19.181594][ T64] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.181626][ T64] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.181642][ T64] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.181663][ T64] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.181697][ T64] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.181724][ T64] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.181747][ T64] ? preempt_latency_start (include/linux/ftrace.h:1091 kernel/sched/core.c:5866) 
[ 19.181782][ T64] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.181817][ T64] irqentry_exit_to_user_mode (kernel/entry/common.c:124 include/linux/entry-common.h:330 kernel/entry/common.c:184) 
[ 19.181843][ T64] irqentry_exit (kernel/entry/common.c:287) 
[ 19.181862][ T64] exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 19.181898][ T64] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[   19.181916][   T64] RIP: 0023:0xf7ee9067
[ 19.181933][ T64] Code: fe ff ff 8b 00 85 c0 0f 84 96 00 00 00 8b 8d 60 fe ff ff 8b 51 30 85 d2 74 03 01 42 04 8b 8d 60 fe ff ff 8b 51 2c 85 d2 74 03 <01> 42 04 8b bd 60 fe ff ff 8b 57 34 85 d2 74 03 01 42 04 8b 8d 60
All code
========
   0:	fe                   	(bad)
   1:	ff                   	(bad)
   2:	ff 8b 00 85 c0 0f    	decl   0xfc08500(%rbx)
   8:	84 96 00 00 00 8b    	test   %dl,-0x75000000(%rsi)
   e:	8d 60 fe             	lea    -0x2(%rax),%esp
  11:	ff                   	(bad)
  12:	ff 8b 51 30 85 d2    	decl   -0x2d7acfaf(%rbx)
  18:	74 03                	je     0x1d
  1a:	01 42 04             	add    %eax,0x4(%rdx)
  1d:	8b 8d 60 fe ff ff    	mov    -0x1a0(%rbp),%ecx
  23:	8b 51 2c             	mov    0x2c(%rcx),%edx
  26:	85 d2                	test   %edx,%edx
  28:	74 03                	je     0x2d
  2a:*	01 42 04             	add    %eax,0x4(%rdx)		<-- trapping instruction
  2d:	8b bd 60 fe ff ff    	mov    -0x1a0(%rbp),%edi
  33:	8b 57 34             	mov    0x34(%rdi),%edx
  36:	85 d2                	test   %edx,%edx
  38:	74 03                	je     0x3d
  3a:	01 42 04             	add    %eax,0x4(%rdx)
  3d:	8b                   	.byte 0x8b
  3e:	8d                   	.byte 0x8d
  3f:	60                   	(bad)

Code starting with the faulting instruction
===========================================
   0:	01 42 04             	add    %eax,0x4(%rdx)
   3:	8b bd 60 fe ff ff    	mov    -0x1a0(%rbp),%edi
   9:	8b 57 34             	mov    0x34(%rdi),%edx
   c:	85 d2                	test   %edx,%edx
   e:	74 03                	je     0x13
  10:	01 42 04             	add    %eax,0x4(%rdx)
  13:	8b                   	.byte 0x8b
  14:	8d                   	.byte 0x8d
  15:	60                   	(bad)
[   19.181949][   T64] RSP: 002b:00000000fffd59c0 EFLAGS: 00010206
[   19.181966][   T64] RAX: 00000000565ad000 RBX: 0000000000000001 RCX: 00000000f7f11980
[   19.181978][   T64] RDX: 00000000565dbd44 RSI: 00000000effffef5 RDI: 000000006fffffff
[   19.181990][   T64] RBP: 00000000fffd5bb8 R08: 0000000000000000 R09: 0000000000000000
[   19.182001][   T64] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.182013][   T64] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.182063][   T64]  </TASK>
[   19.230078][   T64] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/64
[ 19.230948][ T64] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.231549][   T64] CPU: 0 UID: 0 PID: 64 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.231557][   T64] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.231561][   T64] Call Trace:
[   19.231564][   T64]  <TASK>
[ 19.231567][ T64] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.231580][ T64] dump_stack (lib/dump_stack.c:130) 
[ 19.231588][ T64] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.231598][ T64] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.231604][ T64] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.231615][ T64] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.231627][ T64] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.231637][ T64] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.231643][ T64] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.231649][ T64] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.231659][ T64] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.231668][ T64] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.231680][ T64] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.231691][ T64] irqentry_exit_to_user_mode (kernel/entry/common.c:124 include/linux/entry-common.h:330 kernel/entry/common.c:184) 
[ 19.231699][ T64] irqentry_exit (kernel/entry/common.c:287) 
[ 19.231705][ T64] exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 19.231717][ T64] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[   19.231723][   T64] RIP: 0023:0xf7f03797
[ 19.231729][ T64] Code: 24 0c e3 2c 89 d7 83 e2 03 74 11 7a 04 aa 49 74 1f aa 49 74 1b 83 f2 01 75 02 aa 49 89 ca c1 e9 02 83 e2 03 69 c0 01 01 01 01 <f3> ab 89 d1 f3 aa 8b 44 24 08 5f c3 66 90 66 90 66 90 66 90 66 90
All code
========
   0:	24 0c                	and    $0xc,%al
   2:	e3 2c                	jrcxz  0x30
   4:	89 d7                	mov    %edx,%edi
   6:	83 e2 03             	and    $0x3,%edx
   9:	74 11                	je     0x1c
   b:	7a 04                	jp     0x11
   d:	aa                   	stos   %al,%es:(%rdi)
   e:	49 74 1f             	rex.WB je 0x30
  11:	aa                   	stos   %al,%es:(%rdi)
  12:	49 74 1b             	rex.WB je 0x30
  15:	83 f2 01             	xor    $0x1,%edx
  18:	75 02                	jne    0x1c
  1a:	aa                   	stos   %al,%es:(%rdi)
  1b:	49 89 ca             	mov    %rcx,%r10
  1e:	c1 e9 02             	shr    $0x2,%ecx
  21:	83 e2 03             	and    $0x3,%edx
  24:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
  2a:*	f3 ab                	rep stos %eax,%es:(%rdi)		<-- trapping instruction
  2c:	89 d1                	mov    %edx,%ecx
  2e:	f3 aa                	rep stos %al,%es:(%rdi)
  30:	8b 44 24 08          	mov    0x8(%rsp),%eax
  34:	5f                   	pop    %rdi
  35:	c3                   	ret
  36:	66 90                	xchg   %ax,%ax
  38:	66 90                	xchg   %ax,%ax
  3a:	66 90                	xchg   %ax,%ax
  3c:	66 90                	xchg   %ax,%ax
  3e:	66 90                	xchg   %ax,%ax

Code starting with the faulting instruction
===========================================
   0:	f3 ab                	rep stos %eax,%es:(%rdi)
   2:	89 d1                	mov    %edx,%ecx
   4:	f3 aa                	rep stos %al,%es:(%rdi)
   6:	8b 44 24 08          	mov    0x8(%rsp),%eax
   a:	5f                   	pop    %rdi
   b:	c3                   	ret
   c:	66 90                	xchg   %ax,%ax
   e:	66 90                	xchg   %ax,%ax
  10:	66 90                	xchg   %ax,%ax
  12:	66 90                	xchg   %ax,%ax
  14:	66 90                	xchg   %ax,%ax
[   19.231735][   T64] RSP: 002b:00000000fffd4f58 EFLAGS: 00010206
[   19.231741][   T64] RAX: 0000000000000000 RBX: 00000000f7f11000 RCX: 0000000000000001
[   19.231745][   T64] RDX: 0000000000000000 RSI: 00000000f7edf148 RDI: 00000000f7edf144
[   19.231749][   T64] RBP: 00000000fffd5138 R08: 0000000000000000 R09: 0000000000000000
[   19.231753][   T64] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.231756][   T64] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.231771][   T64]  </TASK>
[   19.251371][   T64] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/64
[ 19.252249][ T64] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.252877][   T64] CPU: 0 UID: 0 PID: 64 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.252886][   T64] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.252890][   T64] Call Trace:
[   19.252892][   T64]  <TASK>
[ 19.252895][ T64] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.252907][ T64] dump_stack (lib/dump_stack.c:130) 
[ 19.252916][ T64] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.252925][ T64] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.252931][ T64] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.252941][ T64] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.252953][ T64] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.252963][ T64] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.252969][ T64] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.252976][ T64] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.252985][ T64] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.252994][ T64] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.253006][ T64] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.253018][ T64] exit_to_user_mode_loop (kernel/entry/common.c:124) 
[ 19.253025][ T64] do_int80_emulation (include/linux/entry-common.h:332 include/linux/entry-common.h:414 include/linux/entry-common.h:449 arch/x86/entry/syscall_32.c:175) 
[ 19.253035][ T64] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.253044][ T64] ? preempt_latency_start (include/linux/ftrace.h:1091 kernel/sched/core.c:5866) 
[ 19.253055][ T64] ? __up_write (arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem.c:1375) 
[ 19.253061][ T64] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.253070][ T64] ? validate_chain (kernel/locking/lockdep.c:3826 kernel/locking/lockdep.c:3879) 
[ 19.253081][ T64] ? __lock_acquire (kernel/locking/lockdep.c:5240) 
[ 19.253093][ T64] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.253106][ T64] ? validate_chain (kernel/locking/lockdep.c:3826 kernel/locking/lockdep.c:3879) 
[ 19.253117][ T64] ? __lock_acquire (kernel/locking/lockdep.c:5240) 
[ 19.253128][ T64] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.253138][ T64] ? vtime_user_exit (kernel/sched/cputime.c:737) 
[ 19.253149][ T64] ? vtime_user_exit (kernel/sched/cputime.c:737) 
[ 19.253159][ T64] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.253170][ T64] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.253177][ T64] ? rcu_is_watching (include/linux/context_tracking.h:128 kernel/rcu/tree.c:745) 
[ 19.253185][ T64] ? trace_irq_disable (include/trace/events/preemptirq.h:36 (discriminator 21)) 
[ 19.253195][ T64] ? trace_hardirqs_off_finish (kernel/trace/trace_preemptirq.c:98) 
[ 19.253203][ T64] ? do_int80_emulation (arch/x86/include/asm/jump_label.h:36 arch/x86/entry/syscall_32.c:148) 
[ 19.253212][ T64] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[   19.253218][   T64] RIP: 0023:0xf7f02cb0
[ 19.253223][ T64] Code: 4c 24 34 89 44 24 0c 8b 44 24 44 8b 54 24 38 8b 74 24 3c 8b 7c 24 40 a9 ff 0f 00 00 75 1c c1 e8 0c 89 c5 b8 c0 00 00 00 cd 80 <3d> 00 f0 ff ff 77 21 83 c4 1c 5b 5e 5f 5d c3 90 83 c4 1c b8 ea ff
All code
========
   0:	4c 24 34             	rex.WR and $0x34,%al
   3:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   7:	8b 44 24 44          	mov    0x44(%rsp),%eax
   b:	8b 54 24 38          	mov    0x38(%rsp),%edx
   f:	8b 74 24 3c          	mov    0x3c(%rsp),%esi
  13:	8b 7c 24 40          	mov    0x40(%rsp),%edi
  17:	a9 ff 0f 00 00       	test   $0xfff,%eax
  1c:	75 1c                	jne    0x3a
  1e:	c1 e8 0c             	shr    $0xc,%eax
  21:	89 c5                	mov    %eax,%ebp
  23:	b8 c0 00 00 00       	mov    $0xc0,%eax
  28:	cd 80                	int    $0x80
  2a:*	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax		<-- trapping instruction
  2f:	77 21                	ja     0x52
  31:	83 c4 1c             	add    $0x1c,%esp
  34:	5b                   	pop    %rbx
  35:	5e                   	pop    %rsi
  36:	5f                   	pop    %rdi
  37:	5d                   	pop    %rbp
  38:	c3                   	ret
  39:	90                   	nop
  3a:	83 c4 1c             	add    $0x1c,%esp
  3d:	b8                   	.byte 0xb8
  3e:	ea                   	(bad)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   5:	77 21                	ja     0x28
   7:	83 c4 1c             	add    $0x1c,%esp
   a:	5b                   	pop    %rbx
   b:	5e                   	pop    %rsi
   c:	5f                   	pop    %rdi
   d:	5d                   	pop    %rbp
   e:	c3                   	ret
   f:	90                   	nop
  10:	83 c4 1c             	add    $0x1c,%esp
  13:	b8                   	.byte 0xb8
  14:	ea                   	(bad)
  15:	ff                   	.byte 0xff
[   19.253229][   T64] RSP: 002b:00000000fffd4f00 EFLAGS: 00000202 ORIG_RAX: 00000000000000c0
[   19.253236][   T64] RAX: 00000000f7db9000 RBX: 00000000f7db9000 RCX: 00000000000da000
[   19.253240][   T64] RDX: 0000000000000001 RSI: 0000000000000812 RDI: 0000000000000000
[   19.253244][   T64] RBP: 00000000000001ce R08: 0000000000000000 R09: 0000000000000000
[   19.253248][   T64] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.253251][   T64] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.253266][   T64]  </TASK>
[   19.256786][   T64] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/64
[ 19.304780][ T64] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.305760][   T64] CPU: 1 UID: 0 PID: 64 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.305774][   T64] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.305782][   T64] Call Trace:
[   19.305787][   T64]  <TASK>
[ 19.305795][ T64] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.305817][ T64] dump_stack (lib/dump_stack.c:130) 
[ 19.305832][ T64] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.305849][ T64] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.305862][ T64] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.305881][ T64] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.305903][ T64] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.305921][ T64] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.305931][ T64] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.305944][ T64] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.305962][ T64] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.305980][ T64] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.306002][ T64] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.306023][ T64] irqentry_exit_to_user_mode (kernel/entry/common.c:124 include/linux/entry-common.h:330 kernel/entry/common.c:184) 
[ 19.306039][ T64] irqentry_exit (kernel/entry/common.c:287) 
[ 19.306050][ T64] exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 19.306072][ T64] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[   19.306083][   T64] RIP: 0023:0xf7db80cb
[ 19.306094][ T64] Code: 01 00 00 00 83 c4 08 5b c3 66 90 66 90 66 90 55 53 56 57 31 d2 9c 58 89 c1 35 00 00 20 00 50 9d 9c 58 31 c1 31 c0 8b 74 24 14 <89> 46 08 0f ba e1 15 0f 83 6b 01 00 00 0f a2 89 c7 31 c0 81 fb 47
All code
========
   0:	01 00                	add    %eax,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	83 c4 08             	add    $0x8,%esp
   7:	5b                   	pop    %rbx
   8:	c3                   	ret
   9:	66 90                	xchg   %ax,%ax
   b:	66 90                	xchg   %ax,%ax
   d:	66 90                	xchg   %ax,%ax
   f:	55                   	push   %rbp
  10:	53                   	push   %rbx
  11:	56                   	push   %rsi
  12:	57                   	push   %rdi
  13:	31 d2                	xor    %edx,%edx
  15:	9c                   	pushf
  16:	58                   	pop    %rax
  17:	89 c1                	mov    %eax,%ecx
  19:	35 00 00 20 00       	xor    $0x200000,%eax
  1e:	50                   	push   %rax
  1f:	9d                   	popf
  20:	9c                   	pushf
  21:	58                   	pop    %rax
  22:	31 c1                	xor    %eax,%ecx
  24:	31 c0                	xor    %eax,%eax
  26:	8b 74 24 14          	mov    0x14(%rsp),%esi
  2a:*	89 46 08             	mov    %eax,0x8(%rsi)		<-- trapping instruction
  2d:	0f ba e1 15          	bt     $0x15,%ecx
  31:	0f 83 6b 01 00 00    	jae    0x1a2
  37:	0f a2                	cpuid
  39:	89 c7                	mov    %eax,%edi
  3b:	31 c0                	xor    %eax,%eax
  3d:	81                   	.byte 0x81
  3e:	fb                   	sti
  3f:	47                   	rex.RXB

Code starting with the faulting instruction
===========================================
   0:	89 46 08             	mov    %eax,0x8(%rsi)
   3:	0f ba e1 15          	bt     $0x15,%ecx
   7:	0f 83 6b 01 00 00    	jae    0x178
   d:	0f a2                	cpuid
   f:	89 c7                	mov    %eax,%edi
  11:	31 c0                	xor    %eax,%eax
  13:	81                   	.byte 0x81
  14:	fb                   	sti
  15:	47                   	rex.RXB
[   19.306104][   T64] RSP: 002b:00000000fffd5bd8 EFLAGS: 00210246
[   19.306115][   T64] RAX: 0000000000000000 RBX: 00000000f7eac684 RCX: 0000000000200000
[   19.306123][   T64] RDX: 0000000000000000 RSI: 00000000f7eb3ad0 RDI: 00000000f7eb3ad0
[   19.306131][   T64] RBP: 00000000f7eac684 R08: 0000000000000000 R09: 0000000000000000
[   19.306138][   T64] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.306145][   T64] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.306175][   T64]  </TASK>
[   19.328981][   T64] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/64
[ 19.329865][ T64] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.330477][   T64] CPU: 1 UID: 0 PID: 64 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.330486][   T64] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.330490][   T64] Call Trace:
[   19.330492][   T64]  <TASK>
[ 19.330495][ T64] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.330508][ T64] dump_stack (lib/dump_stack.c:130) 
[ 19.330516][ T64] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.330525][ T64] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.330531][ T64] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.330541][ T64] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.330553][ T64] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.330564][ T64] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.330569][ T64] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.330576][ T64] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.330586][ T64] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.330595][ T64] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.330606][ T64] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.330618][ T64] irqentry_exit_to_user_mode (kernel/entry/common.c:124 include/linux/entry-common.h:330 kernel/entry/common.c:184) 
[ 19.330626][ T64] irqentry_exit (kernel/entry/common.c:287) 
[ 19.330632][ T64] exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 19.330644][ T64] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[   19.330650][   T64] RIP: 0023:0xf7a9f4c0
[ 19.330656][ T64] Code: 57 8d 1c 06 e8 21 0d 00 00 83 c4 0c c6 04 03 00 50 57 53 89 eb e8 70 15 00 00 83 c4 1c 89 f0 5b 5e 5f 5d c3 66 90 66 90 66 90 <57> 8b 4c 24 08 66 0f 6e 4c 24 0c 66 0f ef d2 89 cf 66 0f 60 c9 66
All code
========
   0:	57                   	push   %rdi
   1:	8d 1c 06             	lea    (%rsi,%rax,1),%ebx
   4:	e8 21 0d 00 00       	call   0xd2a
   9:	83 c4 0c             	add    $0xc,%esp
   c:	c6 04 03 00          	movb   $0x0,(%rbx,%rax,1)
  10:	50                   	push   %rax
  11:	57                   	push   %rdi
  12:	53                   	push   %rbx
  13:	89 eb                	mov    %ebp,%ebx
  15:	e8 70 15 00 00       	call   0x158a
  1a:	83 c4 1c             	add    $0x1c,%esp
  1d:	89 f0                	mov    %esi,%eax
  1f:	5b                   	pop    %rbx
  20:	5e                   	pop    %rsi
  21:	5f                   	pop    %rdi
  22:	5d                   	pop    %rbp
  23:	c3                   	ret
  24:	66 90                	xchg   %ax,%ax
  26:	66 90                	xchg   %ax,%ax
  28:	66 90                	xchg   %ax,%ax
  2a:*	57                   	push   %rdi		<-- trapping instruction
  2b:	8b 4c 24 08          	mov    0x8(%rsp),%ecx
  2f:	66 0f 6e 4c 24 0c    	movd   0xc(%rsp),%xmm1
  35:	66 0f ef d2          	pxor   %xmm2,%xmm2
  39:	89 cf                	mov    %ecx,%edi
  3b:	66 0f 60 c9          	punpcklbw %xmm1,%xmm1
  3f:	66                   	data16

Code starting with the faulting instruction
===========================================
   0:	57                   	push   %rdi
   1:	8b 4c 24 08          	mov    0x8(%rsp),%ecx
   5:	66 0f 6e 4c 24 0c    	movd   0xc(%rsp),%xmm1
   b:	66 0f ef d2          	pxor   %xmm2,%xmm2
   f:	89 cf                	mov    %ecx,%edi
  11:	66 0f 60 c9          	punpcklbw %xmm1,%xmm1
  15:	66                   	data16
[   19.330662][   T64] RSP: 002b:00000000fffd38cc EFLAGS: 00210246
[   19.330667][   T64] RAX: 0000000000000000 RBX: 00000000565dbdd4 RCX: 00000000fffd49a8
[   19.330671][   T64] RDX: 0000000000000000 RSI: 00000000fffd394c RDI: 000000005799e1f0
[   19.330675][   T64] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   19.330679][   T64] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.330682][   T64] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.330697][   T64]  </TASK>
[   19.332542][   T64] modprobe (64) used greatest stack depth: 25120 bytes left
[   19.344814][   T65] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/65
[ 19.360113][ T65] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.361051][   T65] CPU: 0 UID: 0 PID: 65 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.361065][   T65] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.361071][   T65] Call Trace:
[   19.361074][   T65]  <TASK>
[ 19.361079][ T65] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.361099][ T65] dump_stack (lib/dump_stack.c:130) 
[ 19.361111][ T65] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.361125][ T65] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.361136][ T65] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.361144][ T65] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.361162][ T65] ? lock_is_held (include/linux/lockdep.h:249) 
[ 19.361175][ T65] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.361191][ T65] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.361199][ T65] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.361210][ T65] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.361225][ T65] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.361238][ T65] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.361256][ T65] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.361273][ T65] irqentry_exit_to_user_mode (kernel/entry/common.c:124 include/linux/entry-common.h:330 kernel/entry/common.c:184) 
[ 19.361286][ T65] irqentry_exit (kernel/entry/common.c:287) 
[ 19.361295][ T65] exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 19.361313][ T65] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[   19.361322][   T65] RIP: 0023:0xf7f7b148
[ 19.361330][ T65] Code: bb 41 ff ff 6f 29 d3 89 04 99 e9 f1 fe ff ff 8b b5 74 ff ff ff 85 f6 74 60 8b 47 30 85 c0 74 03 01 70 04 8b 47 2c 85 c0 74 03 <01> 70 04 8b 47 34 85 c0 74 03 01 70 04 8b 47 38 85 c0 74 03 01 70
All code
========
   0:	bb 41 ff ff 6f       	mov    $0x6fffff41,%ebx
   5:	29 d3                	sub    %edx,%ebx
   7:	89 04 99             	mov    %eax,(%rcx,%rbx,4)
   a:	e9 f1 fe ff ff       	jmp    0xffffffffffffff00
   f:	8b b5 74 ff ff ff    	mov    -0x8c(%rbp),%esi
  15:	85 f6                	test   %esi,%esi
  17:	74 60                	je     0x79
  19:	8b 47 30             	mov    0x30(%rdi),%eax
  1c:	85 c0                	test   %eax,%eax
  1e:	74 03                	je     0x23
  20:	01 70 04             	add    %esi,0x4(%rax)
  23:	8b 47 2c             	mov    0x2c(%rdi),%eax
  26:	85 c0                	test   %eax,%eax
  28:	74 03                	je     0x2d
  2a:*	01 70 04             	add    %esi,0x4(%rax)		<-- trapping instruction
  2d:	8b 47 34             	mov    0x34(%rdi),%eax
  30:	85 c0                	test   %eax,%eax
  32:	74 03                	je     0x37
  34:	01 70 04             	add    %esi,0x4(%rax)
  37:	8b 47 38             	mov    0x38(%rdi),%eax
  3a:	85 c0                	test   %eax,%eax
  3c:	74 03                	je     0x41
  3e:	01                   	.byte 0x1
  3f:	70                   	.byte 0x70

Code starting with the faulting instruction
===========================================
   0:	01 70 04             	add    %esi,0x4(%rax)
   3:	8b 47 34             	mov    0x34(%rdi),%eax
   6:	85 c0                	test   %eax,%eax
   8:	74 03                	je     0xd
   a:	01 70 04             	add    %esi,0x4(%rax)
   d:	8b 47 38             	mov    0x38(%rdi),%eax
  10:	85 c0                	test   %eax,%eax
  12:	74 03                	je     0x17
  14:	01                   	.byte 0x1
  15:	70                   	.byte 0x70
[   19.361339][   T65] RSP: 002b:00000000ffdeddc0 EFLAGS: 00010286
[   19.361348][   T65] RAX: 00000000f7f395e4 RBX: 0000000000000028 RCX: 00000000f7f6d310
[   19.361355][   T65] RDX: 0000000000000000 RSI: 00000000f7c78000 RDI: 00000000f7f6d2f0
[   19.361361][   T65] RBP: 00000000ffdedea8 R08: 0000000000000000 R09: 0000000000000000
[   19.361367][   T65] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.361372][   T65] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.361395][   T65]  </TASK>
[   19.405251][   T65] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/65
[ 19.406850][ T65] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.407947][   T65] CPU: 0 UID: 0 PID: 65 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.407964][   T65] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.407972][   T65] Call Trace:
[   19.407977][   T65]  <TASK>
[ 19.407984][ T65] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.408010][ T65] dump_stack (lib/dump_stack.c:130) 
[ 19.408027][ T65] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.408048][ T65] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.408062][ T65] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.408083][ T65] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.408108][ T65] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.408130][ T65] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.408141][ T65] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.408155][ T65] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.408182][ T65] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.408198][ T65] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.408211][ T65] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.408225][ T65] irqentry_exit_to_user_mode (kernel/entry/common.c:124 include/linux/entry-common.h:330 kernel/entry/common.c:184) 
[ 19.408235][ T65] irqentry_exit (kernel/entry/common.c:287) 
[ 19.408242][ T65] exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 19.408256][ T65] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[   19.408264][   T65] RIP: 0023:0xf7b9cca0
[ 19.408271][ T65] Code: 04 00 00 00 c7 44 24 2c 03 00 00 00 e9 3a fe ff ff e8 a4 1e 00 00 66 90 66 90 c3 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 <e8> 14 01 03 00 05 5b 73 0d 00 53 8b 88 f4 fe ff ff 8d 90 e0 38 f6
All code
========
   0:	04 00                	add    $0x0,%al
   2:	00 00                	add    %al,(%rax)
   4:	c7 44 24 2c 03 00 00 	movl   $0x3,0x2c(%rsp)
   b:	00 
   c:	e9 3a fe ff ff       	jmp    0xfffffffffffffe4b
  11:	e8 a4 1e 00 00       	call   0x1eba
  16:	66 90                	xchg   %ax,%ax
  18:	66 90                	xchg   %ax,%ax
  1a:	c3                   	ret
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	66 90                	xchg   %ax,%ax
  21:	66 90                	xchg   %ax,%ax
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	66 90                	xchg   %ax,%ax
  29:	90                   	nop
  2a:*	e8 14 01 03 00       	call   0x30143		<-- trapping instruction
  2f:	05 5b 73 0d 00       	add    $0xd735b,%eax
  34:	53                   	push   %rbx
  35:	8b 88 f4 fe ff ff    	mov    -0x10c(%rax),%ecx
  3b:	8d                   	.byte 0x8d
  3c:	90                   	nop
  3d:	e0 38                	loopne 0x77
  3f:	f6                   	.byte 0xf6

Code starting with the faulting instruction
===========================================
   0:	e8 14 01 03 00       	call   0x30119
   5:	05 5b 73 0d 00       	add    $0xd735b,%eax
   a:	53                   	push   %rbx
   b:	8b 88 f4 fe ff ff    	mov    -0x10c(%rax),%ecx
  11:	8d                   	.byte 0x8d
  12:	90                   	nop
  13:	e0 38                	loopne 0x4d
  15:	f6                   	.byte 0xf6
[   19.408277][   T65] RSP: 002b:00000000ffdee69c EFLAGS: 00010202
[   19.408285][   T65] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00000000f7f6d5d0
[   19.408289][   T65] RDX: 0000000000000015 RSI: 00000000f7c81904 RDI: 00000000f7b9cca0
[   19.408294][   T65] RBP: 00000000ffdee738 R08: 0000000000000000 R09: 0000000000000000
[   19.408299][   T65] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.408303][   T65] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.408320][   T65]  </TASK>
[   19.430721][   T65] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/65
[ 19.431596][ T65] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.432219][   T65] CPU: 0 UID: 0 PID: 65 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.432227][   T65] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.432232][   T65] Call Trace:
[   19.432234][   T65]  <TASK>
[ 19.432237][ T65] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.432250][ T65] dump_stack (lib/dump_stack.c:130) 
[ 19.432258][ T65] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.432267][ T65] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.432274][ T65] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.432283][ T65] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.432295][ T65] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.432306][ T65] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.432311][ T65] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.432318][ T65] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.432327][ T65] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.432336][ T65] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.432348][ T65] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.432359][ T65] exit_to_user_mode_loop (kernel/entry/common.c:124) 
[ 19.432367][ T65] do_int80_emulation (include/linux/entry-common.h:332 include/linux/entry-common.h:414 include/linux/entry-common.h:449 arch/x86/entry/syscall_32.c:175) 
[ 19.432375][ T65] ? rcu_read_unlock (include/linux/rcupdate.h:874 (discriminator 9)) 
[ 19.432381][ T65] ? do_read_fault (mm/memory.c:5600) 
[ 19.432394][ T65] ? do_pte_missing (mm/memory.c:4252) 
[ 19.432401][ T65] ? handle_pte_fault (mm/memory.c:6069) 
[ 19.432412][ T65] ? handle_pte_fault (mm/memory.c:6026) 
[ 19.432421][ T65] ? __pfx_handle_pte_fault (mm/memory.c:6026) 
[ 19.432430][ T65] ? validate_chain (kernel/locking/lockdep.c:3826 kernel/locking/lockdep.c:3879) 
[ 19.432439][ T65] ? validate_chain (kernel/locking/lockdep.c:3826 kernel/locking/lockdep.c:3879) 
[ 19.432449][ T65] ? __lock_acquire (kernel/locking/lockdep.c:5240) 
[ 19.432461][ T65] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.432471][ T65] ? vtime_user_exit (kernel/sched/cputime.c:737) 
[ 19.432482][ T65] ? vtime_user_exit (kernel/sched/cputime.c:737) 
[ 19.432492][ T65] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.432504][ T65] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.432510][ T65] ? rcu_is_watching (include/linux/context_tracking.h:128 kernel/rcu/tree.c:745) 
[ 19.432519][ T65] ? trace_irq_disable (include/trace/events/preemptirq.h:36 (discriminator 21)) 
[ 19.432529][ T65] ? trace_hardirqs_off_finish (kernel/trace/trace_preemptirq.c:98) 
[ 19.432537][ T65] ? do_int80_emulation (arch/x86/include/asm/jump_label.h:36 arch/x86/entry/syscall_32.c:148) 
[ 19.432546][ T65] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[   19.432552][   T65] RIP: 0023:0xf7f8fd24
[ 19.432558][ T65] Code: b8 5b 00 00 00 cd 80 89 d3 3d 01 f0 ff ff 0f 83 b2 ef ff ff c3 90 53 8b 54 24 10 8b 4c 24 0c 8b 5c 24 08 b8 7d 00 00 00 cd 80 <5b> 3d 01 f0 ff ff 0f 83 90 ef ff ff c3 66 90 66 90 66 90 66 90 66
All code
========
   0:	b8 5b 00 00 00       	mov    $0x5b,%eax
   5:	cd 80                	int    $0x80
   7:	89 d3                	mov    %edx,%ebx
   9:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
   e:	0f 83 b2 ef ff ff    	jae    0xffffffffffffefc6
  14:	c3                   	ret
  15:	90                   	nop
  16:	53                   	push   %rbx
  17:	8b 54 24 10          	mov    0x10(%rsp),%edx
  1b:	8b 4c 24 0c          	mov    0xc(%rsp),%ecx
  1f:	8b 5c 24 08          	mov    0x8(%rsp),%ebx
  23:	b8 7d 00 00 00       	mov    $0x7d,%eax
  28:	cd 80                	int    $0x80
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
  30:	0f 83 90 ef ff ff    	jae    0xffffffffffffefc6
  36:	c3                   	ret
  37:	66 90                	xchg   %ax,%ax
  39:	66 90                	xchg   %ax,%ax
  3b:	66 90                	xchg   %ax,%ax
  3d:	66 90                	xchg   %ax,%ax
  3f:	66                   	data16

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
   6:	0f 83 90 ef ff ff    	jae    0xffffffffffffef9c
   c:	c3                   	ret
   d:	66 90                	xchg   %ax,%ax
   f:	66 90                	xchg   %ax,%ax
  11:	66 90                	xchg   %ax,%ax
  13:	66 90                	xchg   %ax,%ax
  15:	66                   	data16
[   19.432564][   T65] RSP: 002b:00000000ffdee668 EFLAGS: 00000206 ORIG_RAX: 000000000000007d
[   19.432571][   T65] RAX: 0000000000000000 RBX: 00000000f7f21000 RCX: 000000000001b000
[   19.432575][   T65] RDX: 0000000000000001 RSI: 00000000f7f9e000 RDI: 00000000f7f6d2f0
[   19.432579][   T65] RBP: 00000000ffdee738 R08: 0000000000000000 R09: 0000000000000000
[   19.432583][   T65] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.432586][   T65] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.432601][   T65]  </TASK>
[   19.477057][   T66] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/66
[ 19.481747][ T66] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.484904][   T66] CPU: 1 UID: 0 PID: 66 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.484945][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.484963][   T66] Call Trace:
[   19.484975][   T66]  <TASK>
[ 19.484991][ T66] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.485052][ T66] dump_stack (lib/dump_stack.c:130) 
[ 19.485092][ T66] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.485139][ T66] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.485176][ T66] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.485202][ T66] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.485264][ T66] ? lock_is_held (include/linux/lockdep.h:249) 
[ 19.485307][ T66] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.485357][ T66] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.485384][ T66] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.485418][ T66] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.485468][ T66] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.485513][ T66] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.485550][ T66] ? preempt_latency_start (include/linux/ftrace.h:1091 kernel/sched/core.c:5866) 
[ 19.485607][ T66] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.485660][ T66] exit_to_user_mode_loop (kernel/entry/common.c:124) 
[ 19.485700][ T66] do_int80_emulation (include/linux/entry-common.h:332 include/linux/entry-common.h:414 include/linux/entry-common.h:449 arch/x86/entry/syscall_32.c:175) 
[ 19.485758][ T66] ? __lock_acquire (kernel/locking/lockdep.c:5240) 
[ 19.485821][ T66] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.485871][ T66] ? vtime_user_exit (kernel/sched/cputime.c:737) 
[ 19.485924][ T66] ? vtime_user_exit (kernel/sched/cputime.c:737) 
[ 19.485976][ T66] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.486035][ T66] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.486070][ T66] ? rcu_is_watching (include/linux/context_tracking.h:128 kernel/rcu/tree.c:745) 
[ 19.486111][ T66] ? trace_irq_disable (include/trace/events/preemptirq.h:36 (discriminator 21)) 
[ 19.486159][ T66] ? trace_hardirqs_off_finish (kernel/trace/trace_preemptirq.c:98) 
[ 19.486198][ T66] ? do_int80_emulation (arch/x86/include/asm/jump_label.h:36 arch/x86/entry/syscall_32.c:148) 
[ 19.486244][ T66] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[   19.486274][   T66] RIP: 0023:0xf7f82cb0
[ 19.486300][ T66] Code: 4c 24 34 89 44 24 0c 8b 44 24 44 8b 54 24 38 8b 74 24 3c 8b 7c 24 40 a9 ff 0f 00 00 75 1c c1 e8 0c 89 c5 b8 c0 00 00 00 cd 80 <3d> 00 f0 ff ff 77 21 83 c4 1c 5b 5e 5f 5d c3 90 83 c4 1c b8 ea ff
All code
========
   0:	4c 24 34             	rex.WR and $0x34,%al
   3:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   7:	8b 44 24 44          	mov    0x44(%rsp),%eax
   b:	8b 54 24 38          	mov    0x38(%rsp),%edx
   f:	8b 74 24 3c          	mov    0x3c(%rsp),%esi
  13:	8b 7c 24 40          	mov    0x40(%rsp),%edi
  17:	a9 ff 0f 00 00       	test   $0xfff,%eax
  1c:	75 1c                	jne    0x3a
  1e:	c1 e8 0c             	shr    $0xc,%eax
  21:	89 c5                	mov    %eax,%ebp
  23:	b8 c0 00 00 00       	mov    $0xc0,%eax
  28:	cd 80                	int    $0x80
  2a:*	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax		<-- trapping instruction
  2f:	77 21                	ja     0x52
  31:	83 c4 1c             	add    $0x1c,%esp
  34:	5b                   	pop    %rbx
  35:	5e                   	pop    %rsi
  36:	5f                   	pop    %rdi
  37:	5d                   	pop    %rbp
  38:	c3                   	ret
  39:	90                   	nop
  3a:	83 c4 1c             	add    $0x1c,%esp
  3d:	b8                   	.byte 0xb8
  3e:	ea                   	(bad)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   5:	77 21                	ja     0x28
   7:	83 c4 1c             	add    $0x1c,%esp
   a:	5b                   	pop    %rbx
   b:	5e                   	pop    %rsi
   c:	5f                   	pop    %rdi
   d:	5d                   	pop    %rbp
   e:	c3                   	ret
   f:	90                   	nop
  10:	83 c4 1c             	add    $0x1c,%esp
  13:	b8                   	.byte 0xb8
  14:	ea                   	(bad)
  15:	ff                   	.byte 0xff
[   19.486327][   T66] RSP: 002b:00000000ff907830 EFLAGS: 00000246 ORIG_RAX: 00000000000000c0
[   19.486359][   T66] RAX: 00000000f7f34000 RBX: 0000000000000000 RCX: 000000000002b148
[   19.486380][   T66] RDX: 0000000000000001 RSI: 0000000000000802 RDI: 0000000000000000
[   19.486399][   T66] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   19.486418][   T66] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.486437][   T66] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.486519][   T66]  </TASK>
[   19.544246][   T66] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/66
[ 19.545273][ T66] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   19.545971][   T66] CPU: 1 UID: 0 PID: 66 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
[   19.545981][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.545985][   T66] Call Trace:
[   19.545988][   T66]  <TASK>
[ 19.545992][ T66] dump_stack_lvl (lib/dump_stack.c:123) 
[ 19.546007][ T66] dump_stack (lib/dump_stack.c:130) 
[ 19.546016][ T66] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 19.546027][ T66] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.546035][ T66] task_cache_work (kernel/sched/fair.c:1422) 
[ 19.546046][ T66] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 19.546060][ T66] ? _raw_spin_unlock_irq (arch/x86/include/asm/paravirt.h:671 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 19.546072][ T66] ? __pfx_task_cache_work (kernel/sched/fair.c:1416) 
[ 19.546078][ T66] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 19.546086][ T66] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 19.546098][ T66] task_work_run (kernel/task_work.c:228 (discriminator 1)) 
[ 19.546108][ T66] ? __pfx_task_work_run (kernel/task_work.c:195) 
[ 19.546122][ T66] resume_user_mode_work (arch/x86/include/asm/current.h:25 include/linux/resume_user_mode.h:53) 
[ 19.546135][ T66] exit_to_user_mode_loop (kernel/entry/common.c:124) 
[ 19.546144][ T66] do_int80_emulation (include/linux/entry-common.h:332 include/linux/entry-common.h:414 include/linux/entry-common.h:449 arch/x86/entry/syscall_32.c:175) 
[ 19.546155][ T66] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 19.546163][ T66] ? rcu_is_watching (include/linux/context_tracking.h:128 kernel/rcu/tree.c:745) 
[ 19.546173][ T66] ? trace_irq_disable (include/trace/events/preemptirq.h:36 (discriminator 21)) 
[ 19.546184][ T66] ? trace_hardirqs_off_finish (kernel/trace/trace_preemptirq.c:98) 
[ 19.546193][ T66] ? do_int80_emulation (arch/x86/include/asm/jump_label.h:36 arch/x86/entry/syscall_32.c:148) 
[ 19.546203][ T66] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[   19.546211][   T66] RIP: 0023:0xf7f82cb0
[ 19.546218][ T66] Code: 4c 24 34 89 44 24 0c 8b 44 24 44 8b 54 24 38 8b 74 24 3c 8b 7c 24 40 a9 ff 0f 00 00 75 1c c1 e8 0c 89 c5 b8 c0 00 00 00 cd 80 <3d> 00 f0 ff ff 77 21 83 c4 1c 5b 5e 5f 5d c3 90 83 c4 1c b8 ea ff
All code
========
   0:	4c 24 34             	rex.WR and $0x34,%al
   3:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   7:	8b 44 24 44          	mov    0x44(%rsp),%eax
   b:	8b 54 24 38          	mov    0x38(%rsp),%edx
   f:	8b 74 24 3c          	mov    0x3c(%rsp),%esi
  13:	8b 7c 24 40          	mov    0x40(%rsp),%edi
  17:	a9 ff 0f 00 00       	test   $0xfff,%eax
  1c:	75 1c                	jne    0x3a
  1e:	c1 e8 0c             	shr    $0xc,%eax
  21:	89 c5                	mov    %eax,%ebp
  23:	b8 c0 00 00 00       	mov    $0xc0,%eax
  28:	cd 80                	int    $0x80
  2a:*	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax		<-- trapping instruction
  2f:	77 21                	ja     0x52
  31:	83 c4 1c             	add    $0x1c,%esp
  34:	5b                   	pop    %rbx
  35:	5e                   	pop    %rsi
  36:	5f                   	pop    %rdi
  37:	5d                   	pop    %rbp
  38:	c3                   	ret
  39:	90                   	nop
  3a:	83 c4 1c             	add    $0x1c,%esp
  3d:	b8                   	.byte 0xb8
  3e:	ea                   	(bad)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   5:	77 21                	ja     0x28
   7:	83 c4 1c             	add    $0x1c,%esp
   a:	5b                   	pop    %rbx
   b:	5e                   	pop    %rsi
   c:	5f                   	pop    %rdi
   d:	5d                   	pop    %rbp
   e:	c3                   	ret
   f:	90                   	nop
  10:	83 c4 1c             	add    $0x1c,%esp
  13:	b8                   	.byte 0xb8
  14:	ea                   	(bad)
  15:	ff                   	.byte 0xff
[   19.546225][   T66] RSP: 002b:00000000ff907810 EFLAGS: 00000246 ORIG_RAX: 00000000000000c0
[   19.546233][   T66] RAX: 00000000f7c6b000 RBX: 0000000000000000 RCX: 00000000002c8ae0
[   19.546238][   T66] RDX: 0000000000000001 RSI: 0000000000000802 RDI: 0000000000000000
[   19.546243][   T66] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   19.546247][   T66] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.546252][   T66] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.546269][   T66]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250812/202508120315.19f6266a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


