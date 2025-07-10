Return-Path: <linux-kernel+bounces-725966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470A4B00610
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6666438AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4C1275B0F;
	Thu, 10 Jul 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib70XqYx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8032749C4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160153; cv=fail; b=qnTENiHzJ6uEB3307wT3NQWkkAasre4/v5zTkMhRwW+cunHQkcDutGwkWypm//UQbqYX0BcNOZTM8dDwnEhCFwK60D9XF2e4x0M95Pyf+Tjw8pSBVNO24BhuAMCsG6lENi0mH5FLf5OUFW7ghEazddQP15dlR8NrJl6IqqXQkOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160153; c=relaxed/simple;
	bh=kbvESHx0fOuFNeCopcJvngpneOU721w9nnq1gpz/7DI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LCRqanpuoquf4Uc/nEhHYMIIqpHD6VtcyGfOcGo5hsheH/rOqcnx5lSWu+reRJDt/IQfXl8E9ahxEC09SATeZj6XkLxwohCYyWho8V0D7Qpv/hHNy9LVsskD7k0PEddXoKhfoCZlrfMyas/wgbrh12tdeY8G7GgjS9CGiBS+Pao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib70XqYx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752160152; x=1783696152;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=kbvESHx0fOuFNeCopcJvngpneOU721w9nnq1gpz/7DI=;
  b=ib70XqYxSSE4sbtRZUmWpuTeEkLch2PWqTdn4M2gc0SvS9QzlKTTcPHJ
   itiDTmUe7IbZ7yLMinBjWEZOOR+muTW2OnrlEH8MBeo/QPVaVwiKQsfUl
   vJm6OwcizkPbjr/S6kAamM6lQGF1HRsJvbGRq1AOLTHIOJeRQ3llVul9i
   Hm9O75YGpQuyGntgCJB8GsOvpo4jbp5sqbiQywn1zgJCWHhGSIi1Hmuso
   Qjk3suZ38IwVeiuzRs26U8rLRpywfMa03eIG306FRbVlHX+LZ1Q42kAqL
   vpWxFrKRoxAKGgWw/NvfFOnBo7Ta8A6G9dkd/upjhzJoo794wlsCR9OcT
   Q==;
X-CSE-ConnectionGUID: 8OFtSVZ8RKacPV/V3H/Xsg==
X-CSE-MsgGUID: k7X5U5+JSZ+HRMVEJBxe5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54416405"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54416405"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:09:11 -0700
X-CSE-ConnectionGUID: zUfaBk+DScan7yszMPIqQA==
X-CSE-MsgGUID: vn2DW4imTva+18MIiMafVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160137815"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:09:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:09:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 08:09:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxkVN0oz+w7yAyaSsKb09+MxQ2hLNISfiKkr96fxfoM/qqHUpze78t/3STyZvgG5giPLGC1WPYQCk9UaBlXfQ/RYmm/5Q7l9QAct8eOj+F8GTiUwjDSiYYZZ4QIT1AaMUV9htCGUhoeTQw95SERykUpFG6eYb/Ol+b+26zOUFQrwCLxjY67eVebLl0eOV27A5JDFBR94aqxmapvhXnC+6x0s22CbpvTj6BVi/dS+3HvVfpCycRzQ370hIgdDz1hleGfKUp1aFxTdOzDKLZcqRVdn1OQVaiU72LFUGzJeHx/sr1s71gdiz8HBKvV2q9ZXfT83EWDnUNYOtsg8oZOUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJpJdL+xkNSq7BLpjvgM2wmxWAf8K57Ktevfy72sieg=;
 b=CDedcAAD4UNnhZsMoQy6zG76cdj6ZX6M1Qg9kJvVCPRk6kF8UMvZj7k2sfsIvkPzaOcGKpUGnSFOAuK98/xIgRejTTPAxXZqvCC6c060/g4bIOZ2yEWIkCu9x8WqFskeZVHZHIgIuojLIkyPF/kIzCPiQC0nfqF4AwPMjlk0WCgCrYlNf7lfx8GTXK2BvG4Js2YeL4NH3T1XQe2FSb5S012TvhrXb8WbDv5pMW6804539Z/eb+Of1rW6YbhOzDglLqaA+TE4NZ1qQvbajXIpoQLOV0cHaR8AxOBPCFu4YUa34Fe30sSf+n9tr3qHl0SsXRXRwl0U6dip25oOEGD+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by IA1PR11MB8861.namprd11.prod.outlook.com (2603:10b6:208:59a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 15:08:38 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:08:38 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <daniele.ceraolospurio@intel.com>,
	<anshuman.gupta@intel.com>, <alexander.usyskin@intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>
Subject: [PATCH 0/9] Introducing firmware late binding
Date: Thu, 10 Jul 2025 11:08:31 -0400
Message-ID: <20250710150831.3018674-11-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|IA1PR11MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cda64f9-d1d5-4057-190c-08ddbfc3a5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NRJCrrFgGKvpGLsxeuB3w5khCAZ3ZS/+hoGxyE0dbb3mIpjLrjaN+4Tl1PT8?=
 =?us-ascii?Q?pN/M8QPi9S3+6uyMeDK9FPfsTYtpilsLcF4g3cz1/rV/Bv9L1Pgyh8uaDiaJ?=
 =?us-ascii?Q?fnu77L11q0uYRC+5CHSKmr5u5JEsuTDOXoBXcZxKk67t+PHlJF41pfch9wCB?=
 =?us-ascii?Q?EmV7OgLvyG5FzXAO625HW4VMJ0wTfCRrzLbuyJ79eotuEU95xSxTJ53xMBC/?=
 =?us-ascii?Q?oC4TLW9eMSoBJi1OZG9vnqVXYNk3Cg9kV2Wj2pfocFD8T+WPkBev9F/zx7HB?=
 =?us-ascii?Q?zgkDgoDhxmKUyQWufJFwZt/XuJK8QTlT29DrEmx1DcbtJVjm6++sdOVKHY5a?=
 =?us-ascii?Q?1j1yq9c6XKuGZcwJneq0TvzCUT2XnvH8k59sTDJUkmpCw0o3A5vsfx853wQS?=
 =?us-ascii?Q?tNyFjRcwINfKs/C8gyjFnlCd5IWzfW6ZnOOTHMLMwzC2x33UYNYKsRZlIsA8?=
 =?us-ascii?Q?2PGPapA0pVW8Obt0NiAd2o9YAbDySMd3YTuuoSXJMdeaoJTEX043Jhfx1Agq?=
 =?us-ascii?Q?m/I2LgAscv9qpIqJ+/rLDJ/llcF7UAPKVssYbLTvOUpirFiuuS0yhHUwwil/?=
 =?us-ascii?Q?eE1boWfKStUx+RR9msBT3SqFFJlyhv0bfKegJ3jJnkjpY+A/guUjrJLFObL3?=
 =?us-ascii?Q?zy5gUmECFZYGmf3IFMZ2DOA8OqkyGkemXMCiC0QPiOJ6QWM5L7lOtkuc4Myb?=
 =?us-ascii?Q?o/fkycn9wYMymNmKAKLeDPV12kkmyG++VFOwMs0O3eIRyw5t6Bqii3WrVcm4?=
 =?us-ascii?Q?cqq9Jo4o1OtMEmJ2tGhU4/ZRoNFzJfQflubRqM/r8uDK/ev8vBRwio/se26H?=
 =?us-ascii?Q?61/Op/KS34PlpTdrxr3pbrYEzepbyE4VHOGGYeuJ3xlX1Un+uFSBlhQiFjNu?=
 =?us-ascii?Q?sFjeqrQhfgK6MLNAEFEUjbZrwki0qluVckTfPGFWgXEdz37dURgG7ONrRhrn?=
 =?us-ascii?Q?mdCYl9y1fZ+cmsel9zZxo0BcLuzkz++/oV6FC5f/jjcizoT5qBivCKAS0qhK?=
 =?us-ascii?Q?VIY8kZweTvOZqrf1yKFZuY7BJEmhkDFC2mcVXMkTI2B6bTbIuWn1/5Cenb2p?=
 =?us-ascii?Q?rUUUUblFPvYvwA57w2Ue2MAf5udBaxpFSYOyJxqu9iJ6xIasj/bWX2tfMdqA?=
 =?us-ascii?Q?B2LdJbKupNRhOqOcNiL2LBTJaxUToyeCZmGHepKKL+wq3YIfPDNSsZXp1y/M?=
 =?us-ascii?Q?v4I7szfuIwzmbytt0kGyS5wm0T564kc1F9iUOrOS1F2xPiSFGoRAvLWdyzyk?=
 =?us-ascii?Q?Tucx6HjQLe+g42XaK6iAAylTorN6CIIevW1h5xxY5J7Eab7Aadifo5ybhNIl?=
 =?us-ascii?Q?KG9Tf33p0xP7aZlQENhwf9a8Gpf6fOhC3iYyR6h4PGJIykA3S86UcnsDPcq6?=
 =?us-ascii?Q?HcVigg7QwQU5NJG33q9nHtRcsUR429OmwvQAwQZXVPDlhcY/4pFZX/QjEh4X?=
 =?us-ascii?Q?0RTK6sv+XXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gnbDmVSaA60SUZuWwzDjkzy3pvrNUaFAJNsUeA6LzKB5YIoCkXlfmsC/wnd7?=
 =?us-ascii?Q?7QFYLanoTLOmS+hgvl0rh6R+TBNRbDMzG8HpuArGQb7m0n+35SXTS6osRx5Y?=
 =?us-ascii?Q?AjyDsfZXFm+Qap9vW4+ijEE0VpW+FhJZBQz7ldXkjNo5VOLGI5cLFSKnDwuP?=
 =?us-ascii?Q?MaDZC00O6MnOsds+a4xFd6Zxu7dCCOIc52kMzoJkK4nFuBMwMkx8Q1XMcHKW?=
 =?us-ascii?Q?XQMZrkLpB880JxQfguhvmjJINylugSP1zwp88eW5si6MO3mx9tdaGycaoROe?=
 =?us-ascii?Q?vk0y3DYf+J8OTNWyrw0Ruet+Y5URbDgcUKPsXz0blq2sWtykd8Pb9N8RSgLK?=
 =?us-ascii?Q?veaXpar7zEBz15gI7ELCRrIZBZhNSA+798fAN+02ww4uw07qULQVz7JfPlKs?=
 =?us-ascii?Q?C0dkOPti+oVoO71fgjwHmQ80h88P93stWhks3wnYpVsl0aVN2sSR9MsxCZwc?=
 =?us-ascii?Q?9ktrJExYtvQ2uprjsou1G52CZd7DnyNPTLtKDWZcEY35Kul1XV9odBlQIrFZ?=
 =?us-ascii?Q?motrbuwLQZu3XuU4EPwRitjtTB0FwFCD7IvnurJ9MYYlFNDuW+6deG9Oinnu?=
 =?us-ascii?Q?rMQqvsyd5I0LKPjH/eKma/LGeYeao2H+OGEHmrYjk+a7hkC+g/vV9WE1lasl?=
 =?us-ascii?Q?E4W2RYc5vJV1MgWxmdV2/grhso9IhVHgctyLFb1KNWu+JthCtkpbCc4/RXWu?=
 =?us-ascii?Q?kpG1bPRTXTMqhUWgM3oza8y1i8zfHPS1lITXBSckH0gD1sUg1xt+2A5cNOVm?=
 =?us-ascii?Q?0qL3TKL68RFcsWBbEWvUxfYE6RmjiEK0/QWeiNreG11jUWZECSelSUxkuWRJ?=
 =?us-ascii?Q?W82X3vKwlKmnkHG25vsR6mJEDo1rY0RCXFtMZUTEC7aMnUFXw4BYSaddfwIP?=
 =?us-ascii?Q?U6xuzn4zj18z4UDR27Rd5uqOhBb/IbkyrXSzAWVjlYqr4ZG1aJVPwUiUxtcO?=
 =?us-ascii?Q?TCMygguJ/XmJQ70jiPCwFMi7pJTr63INRmHNo9Ofo099wvf52h1KROL6n3GU?=
 =?us-ascii?Q?idErRkWyjKvuLABW4iuGGSxM3wfnDgXbG6WTPhggFgsFqT0bb7d5tNqWQpQm?=
 =?us-ascii?Q?wRocDXiYAGeMs3MQX0HEJLi3r2DPRlk9I+wTSbd1OSd8kFs9U+mvC6EIMgUB?=
 =?us-ascii?Q?1XZDRnzXbFZu7zV/lKFljakc44SuhTNUX4ewf6NKpvIsZ/OR6rDFVVgk4X2K?=
 =?us-ascii?Q?Vn5JQbLjY6eTKF4SQT1MpZIPT+tvuGbAtbxrhusacil4PDgjD1ak2xGNYttb?=
 =?us-ascii?Q?DmfRZab+st545tFoqFL+W43s/kqM0BXldxEEQP9dO3UzZxm1OD/bmskhgnSb?=
 =?us-ascii?Q?6iPd9nTBo++vIfKz0pqHmIj9jIYoZziVquILnvFyzotrJILdgILYc7eLnqZY?=
 =?us-ascii?Q?zEh5PC8VMImeZtmwuiAMq8/nFUgo05eBMUw2sZI46+OQXuuV5eeItsCBiCFl?=
 =?us-ascii?Q?yLQuoiVsRhMqHjJ7dVD/BlVlps7Tdnib/2cU9R8uwbqgES0j2Btr2Cl6dD3O?=
 =?us-ascii?Q?iMR5kNsvg1Kj7uu8ii9uYShBt1Uo0Fwk0jKw1Fdg0ji7l7kdCMnnWsTjCblw?=
 =?us-ascii?Q?4rMiSLhuY3AqQU/vheGB8WyPi2ylJHleGd3aJf0kmWsXs1u1JtSJe665jEGC?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cda64f9-d1d5-4057-190c-08ddbfc3a5c3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:08:37.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8PfQ2KVPHop8lkJG7LzWplsqyX8GfTp0v4UGSZf4KRBF7Q2/d36mGtzYkjUwps1u7Y/GvjQrjfV+lUo0vdiXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8861
X-OriginatorOrg: intel.com

Introducing firmware late binding feature to enable firmware loading
for the devices, such as the fan controller and voltage regulator,
during the driver probe.
Typically, firmware for these devices are part of IFWI flash image but
can be replaced at probe after OEM tuning.

This version (v8?): I'm covering for Badal's vacation since I'd like
to take this as soon as possible to drm-xe-next.
The changes in this version are mostly to address the valid Greg's
concerns on the mei patches. In summary:
- Proper commit messages
- 'Late Binding' documentation and explanation
- Proper code documentation, fixing word and style
- Bring consistency to the prefixes and naming

Previous revision history from Badal:
https://lore.kernel.org/intel-xe/20250707191237.1782824-1-badal.nilawar@intel.com

Thanks,
Rodrigo.

Alexander Usyskin (2):
  mei: bus: add mei_cldev_mtu interface
  mei: late_bind: add late binding component driver

Badal Nilawar (7):
  drm/xe/xe_late_bind_fw: Introducing xe_late_bind_fw
  drm/xe/xe_late_bind_fw: Initialize late binding firmware
  drm/xe/xe_late_bind_fw: Load late binding firmware
  drm/xe/xe_late_bind_fw: Reload late binding fw in rpm resume
  drm/xe/xe_late_bind_fw: Reload late binding fw during system resume
  drm/xe/xe_late_bind_fw: Introduce debug fs node to disable late
    binding
  drm/xe/xe_late_bind_fw: Extract and print version info

 drivers/gpu/drm/xe/Makefile                |   1 +
 drivers/gpu/drm/xe/xe_debugfs.c            |  41 ++
 drivers/gpu/drm/xe/xe_device.c             |   5 +
 drivers/gpu/drm/xe/xe_device_types.h       |   6 +
 drivers/gpu/drm/xe/xe_late_bind_fw.c       | 464 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_late_bind_fw.h       |  17 +
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h |  75 ++++
 drivers/gpu/drm/xe/xe_pci.c                |   2 +
 drivers/gpu/drm/xe/xe_pci_types.h          |   1 +
 drivers/gpu/drm/xe/xe_pm.c                 |   8 +
 drivers/gpu/drm/xe/xe_uc_fw_abi.h          |  66 +++
 drivers/misc/mei/Kconfig                   |  13 +
 drivers/misc/mei/Makefile                  |   1 +
 drivers/misc/mei/bus.c                     |  13 +
 drivers/misc/mei/mei_lb.c                  | 315 ++++++++++++++
 include/drm/intel/i915_component.h         |   1 +
 include/drm/intel/intel_lb_mei_interface.h |  70 ++++
 include/linux/mei_cl_bus.h                 |   1 +
 18 files changed, 1100 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw.c
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw.h
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw_types.h
 create mode 100644 drivers/misc/mei/mei_lb.c
 create mode 100644 include/drm/intel/intel_lb_mei_interface.h

-- 
2.49.0


