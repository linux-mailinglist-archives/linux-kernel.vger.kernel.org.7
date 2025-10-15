Return-Path: <linux-kernel+bounces-853945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F02BDD18F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBFD1884908
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B073164A5;
	Wed, 15 Oct 2025 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c226YD0p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0E3161B7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513022; cv=fail; b=aFYSUpefmUs/7Fd+7lI6x2tDqur7ofuHwZAre1ZgYQbKqdEui7SqMS+TybZsFx596zJePkSiIw/rOPGAn88oN06GgtSIR4L05CskkcQpx6cMYXUmiPSAkDihULkTfscsIx/xryWVGkoVh78Mzer/UJhX8NxTFXIIu7G/r2knebQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513022; c=relaxed/simple;
	bh=RPTTaooODIQ1Eid6umJ4JpuZlYEObFd96dE1yxbJo+0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aJ9yx2AuOcqhKhR0v8gcyV+uUjr5YSTTxx/htmtTnBmzT5Y589NgNzKYXk8zuLz+hQdvXWfXpAJWiBDRSNgIw8MBrzWwZR/lOksMwb6kvznkvDi9OmSjmnleKSK8yxj1pXq0xGYN/usbTSIokQYktBOoDXOZxr4HVq/+6c4XS1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c226YD0p; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760513020; x=1792049020;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=RPTTaooODIQ1Eid6umJ4JpuZlYEObFd96dE1yxbJo+0=;
  b=c226YD0pVc4YUaxrXDlv/TKEQjaA5SnY98ExnsIcCWzrvQC9ww1wy1xA
   SBNv9aZqu36nd5xAxveKkdU++OueLGqoHfNOwTSEWGTlKoSdD7SuRedEi
   qx9z4n08OMSNfRDrmaPv+Xg8seA14cDU9eIir+HKMp384PQLhAKrQMPCD
   xNXXyK0fL0RX+mluuX9EAcsKaHSi7/uo9eIecXcBFe7QFAEkVeC2QQEvR
   Lg8daMsLC4PNB9IlncPsEg6DrIcFsQuAXNVnYDWpdj2Mnu2zugKL2YKHM
   r5Ut6Vhf7Y12VCyED4//rQzohNHLOt4N1wnFqjZAMrHjycmAeZd+iKtQz
   Q==;
X-CSE-ConnectionGUID: 3dpE7SQgT6ODbwR+5BShzA==
X-CSE-MsgGUID: yVSOHnddQ5WPcYohwJ9SPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62576461"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62576461"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:23:39 -0700
X-CSE-ConnectionGUID: TkMy/zLXReSrTkn3koXDng==
X-CSE-MsgGUID: AlXIS7MFQe+e8GXNotbuUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="219238629"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:23:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 00:23:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 00:23:39 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 00:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBji83N6Rb4oJBcrpgObVsCE8k5XYhu+sYz4SB0ONxpmHEeD4UEHI7EKCNWueEv4wR+pIORI0L3fscHVCHk3vSK8mJxGAiWErtR62RH4Qbn63khKGBMecodRvB/ngt0boMnfLEX43ODKx7FGCdRO49SS58X739FbB6lH+BrEUc5Cl2BR0lczMSCwknL2dLXISOZh0Ck6pFKQ43FtNOJ5utecRfQSNAZW94/h1YkCJPr+G0pmCb62Ii9cYJKVJ4V5ezexN2XBGoB71lLh0p63pw2yG8embYU4QTw1d37axOOHnk1ogEviW05/GkipHe2IQ+Ca8xrx1hPhC78ZlGcKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Voh5+IP7/JQcrc8HNJitTU4gT3CJqayRXhfC/JQc1U=;
 b=eUJS3cyeuV7jcmEMIXpzVuQSmPpvouWVDQdGweipwQRgZxpZmu/5uLPIPcO1ZiRv01DUDWjeC/88dIQ8waGpbFG+vsrjhTy0jp/yco5noaz5pDeHw1PbmcUbMC0a28Z9swO4pUUM6AFz7ca8FIxf7HF6NdrYamkkU2UrpRxEIQpWY+d6ML3I4eIT7otiplHdm1YRBIUIRlXwynI/J/T4Gmn6UEzwlATSPxPseO4CNfAZ8P4isLSI82cnzPN3UF2wkoahXhrrgDWUSJRyVtLCw504jn0KpXUCiRlpuht0IgoRxSug7yfpGSnkP16DE8UxTCReHlvC0drkR7uuN1GCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7928.namprd11.prod.outlook.com (2603:10b6:8:fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Wed, 15 Oct 2025 07:23:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 07:23:37 +0000
Date: Wed, 15 Oct 2025 15:23:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Chen Yu <yu.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen
	<cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Libo Chen <libo.chen@oracle.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring
 destination LLC during balancing
Message-ID: <202510151514.652b80d2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
X-ClientProxiedBy: KU2P306CA0055.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 49507cf7-556a-43a7-3b04-08de0bbbc178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6skRra4/0tvDnk1bDCnv04J+YXt8XIZdqsQLIc9EydWv4Iur8PtR0puIpfkX?=
 =?us-ascii?Q?DRjaO6eIccajqkZ39YVQQRavwG9OE5TWRJw+4gx84mwOwfdYGapECoXlHxnf?=
 =?us-ascii?Q?6Q8zWtB3Is8BQvkcMKK9PNX8HIV9nEKaVBsvnnN9EwYUT9EVV7y8sddRhSIj?=
 =?us-ascii?Q?6G+2EUn662GPWm63pvYqnr9YcLVSAk7dTR1XwdX58H5lkvUFnxaon51mhXlE?=
 =?us-ascii?Q?zPcVbU1qESkTm7NQnH7Szy1fA3gSrX+Hpx23H0dbpS+oiMoiSsuOJqJH2U2C?=
 =?us-ascii?Q?jKdHP8XsMKUr27V95UkbMyOTCo+kB6ygCM7OGkQMG5Wd/ajpHT5s+Vxj2bew?=
 =?us-ascii?Q?lEpdifa9TnjM4OTIdIjGWRB00a6kBN6fQw6idJSD98GvFg3hjxqYYq8lltZF?=
 =?us-ascii?Q?1+QsVL5/gkwX5gTAS6Hld/cmgMrJATvGkgp0wJjtd0bu0Pb279R54J6p2H2E?=
 =?us-ascii?Q?f6Wyi6E4TUN6wvDkvuHPoGD2RmxCPRsD4ey1QxXGJQFgLutGMjePpuOlquYE?=
 =?us-ascii?Q?UGQ0m4pEgtm9nF/Q2ZZU/gMfgks9POxiJGDH32dw965GzP7zZqYh3jYIkSOQ?=
 =?us-ascii?Q?W5PCAI3lr4vml7f3vgUCmfqfyJXtp8JAWGoa40id4+e/5Ka8y5Or8ZBNA7bP?=
 =?us-ascii?Q?uZXR0enanUmCfwKFls6K6qkNCRtzL1fLNEvDiZaDikSQyv5/GHdRMVxPorue?=
 =?us-ascii?Q?UI8OX1bm6gMvFY/QCEPgeRZtDaEbVM/+Uzi4RuCJrrcWoE8MQHiSENQT+LA3?=
 =?us-ascii?Q?j/+crpJybezow7Iu9STgFkNnuRRkCC0DaOPZ7R3iy7vgnno/wJz8A57TKfWf?=
 =?us-ascii?Q?W0dL3gtlrYhTXenkZpuXW3SPTsOed3a3UO/2EmLYCTbH6vMfTfdrN7av62TG?=
 =?us-ascii?Q?uIu3IyeyLIaqNxaoY+8TJ5apNZ2TAFWXFmevrcCI/d1CsB5xcsYIvHm8JrMJ?=
 =?us-ascii?Q?zd3pMRH2hi3ym2zcAxW8JEuCVo5IfOxKvZPU63D8Q40BY5cDNgKgPp/amn5d?=
 =?us-ascii?Q?GT4tpkXVkWXSdjZa9F6XqzYb+YlHa4Y7gvAeMb7hK9DlkX0RtGZC+VTX3g+W?=
 =?us-ascii?Q?hE2sdNB/rScg7ILQZOQXrTDpLn7TKSEBNTPkV6dj6IkR+OPF0k5gjYZA7Urs?=
 =?us-ascii?Q?zhxncLWkU/30d8egrUCwiGYDZzjzyFb4C5E5EZx2RbY/oBUmzcJ/jcOHxgSU?=
 =?us-ascii?Q?8eyt9fRPLqd+FYRQuR1leRP5LH/F1t5yQ1VrfpHNap+uTO/rgdXuFuYg0iAT?=
 =?us-ascii?Q?bFWMKEdKrJv09s0M+i8UJK7bpV2rtvxq2d2+yiQ8Xq3Ovmon5N7ivEBhbW5x?=
 =?us-ascii?Q?G9go0SJWLf8RMA5DuHWbFAFDu+iubbc5Yyk/e7l6n1Rm7qOS0RBOoeopSG8/?=
 =?us-ascii?Q?1V7qoaQWt31pQQlvSZPhTK5E/3IWNx8YFC9GT2RlkIbgLaqEcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpGJzrFfwpGMhXxEAovQTZnfmFIs/nZRcpJmLyUU+Qbcur+9toW+dIJkSQmC?=
 =?us-ascii?Q?5t13+6F5W4v0MfdM3EecnQxe2TcNw0ZcIR0rAJqPSWj3pOBTEdPhUCnUoSW+?=
 =?us-ascii?Q?jgufxZg5aoIkISnwChGMCRj3BuQV8yXvB/lOSpYwgXn8ZrXFl+zXRf8Y+hAf?=
 =?us-ascii?Q?HkJYA7lokj20suisRKcKNFvsCCbyZ43E4KsE9Gqu4iskkRSOlDkdUmVvQW0A?=
 =?us-ascii?Q?lqP2bsSW/h1vaDjHzdlOyLm+NzDzPVWD3spQL9r+03whXAr+B1Y/b+sYYSdM?=
 =?us-ascii?Q?5mkcV4MpB8Q65lAS5kCEUEtgqEwLxeReQ0CYxLlprpoEkeUb+kPJO//g2Gzr?=
 =?us-ascii?Q?Ps8YnN2et8bea5uAkrGlFC8fsoZCO2L+r4KmNGinDUCyEwPmWOPOWjuyOAVa?=
 =?us-ascii?Q?vYqfpTTo3Vv+DtUFWKJpP5DusyPxuFZgjiahg7fHz0OBWZFK/QFQpP+2TmFn?=
 =?us-ascii?Q?aHhJC7tbdZiebg94EAsqG5EEGKbS1OtFe1edLRvcHcBaY+bYsT+3nN7i+qVP?=
 =?us-ascii?Q?ELQYF8oEufv0fJ0NDm0nNJVLVtQ+yk+3EI5pXhj70wjlDYdvhlLelAIvy3AM?=
 =?us-ascii?Q?mhQ7NnaGQO5Opa0ZfbMf/hBlFZdlyF5T/AD4w9mdUaVWxhSox6ScMXBkVhpG?=
 =?us-ascii?Q?tme42tnBp7VzsCIkNKu68V8NivEBsg/3YuVhrq+6M9Qul7TfDjxpDwfVnHdo?=
 =?us-ascii?Q?JRyNtWmR2mAjouDv405m0XkjahrfV8t4lWXPQI9nTLKdIdW2CikM6WKLztKs?=
 =?us-ascii?Q?kZi/NL1Yl0A/b4hEOwufXMK0eqVzt+67CI0y6OD6582/UuFk/xz1OMm3cLbk?=
 =?us-ascii?Q?jAMkIohaG0ctR4d1uNYmC4aUZKd5ZKVZID03QxtCHPTLleazUkUcPl/QbOIj?=
 =?us-ascii?Q?pU9QElFpYzFT0w5E+aeXAZBCvP1/jWMhpPLiCaUo/CBPaU97Y0Tqg3fIlJUQ?=
 =?us-ascii?Q?3BBejF8BKKFFATWO/fxvgbJtlwu3LZ0DpaEuzPYg5QLzbyAft7LV/Fy7/sAw?=
 =?us-ascii?Q?Kk0BsWdtXg5wDhDxTrpSo3iGYxAZNfqMAWRrUWKAyScjouovVw27arVo8Q14?=
 =?us-ascii?Q?mvDB+VZdYZKaECwooJ1BukjYf8onRufLCtYqdXfuo1CzQ0UczGZ+NIMbvrLS?=
 =?us-ascii?Q?HijkQAyCTM810tbuN52bpC20f7FwKwNbv/i1JBre1HS4HlHAo0hxAeHTCwFM?=
 =?us-ascii?Q?sGqy1RhoMI/8dSzd4k2dd16pki9V+mRQhp0jRwV0E0mjA6u7f3Oog5hPWk+I?=
 =?us-ascii?Q?ODEAX//u2x7vMlD4T1xJ3TB/8pv1N7E2vKoComB51TddTl1Q3Klv8XyFOZfR?=
 =?us-ascii?Q?CJhCMX4FedHZsWieCXeI0qS6WJYUO7TYzakb8emb9hF5gPmzU7cx6pA9yLNO?=
 =?us-ascii?Q?Hq3wSClKvvHTLo1q8S5yu+te3ZGCn1vIYVeb0m/Jl/K7u2pkHOoXOPaYgjSG?=
 =?us-ascii?Q?/7IhQdKnJ9etKLGL3FuJum11brrGmB/tNPusQngP13CtDHaGxdoE5/uCyQU3?=
 =?us-ascii?Q?Lo7J4VAqjp35/Jum2wNh9x/2fAHsiEtgppQezBwWcRTrbOx8hRWzN9xNR7kz?=
 =?us-ascii?Q?KljHepDKI1ItKE4EdeDtkh1XLUEOswiI40Br2CPWqs0QW9J6gS7GSdiKCHId?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49507cf7-556a-43a7-3b04-08de0bbbc178
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 07:23:37.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmRmtKW6EwOsM8enz3RLNBC9Zf3MIT8k95CojiKqgAwsYDcso2NwOWuKzAUdlh0HXzD+mU3lf9s6VlCkebxXaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7928
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_kernel/sched/fair.c" on:

commit: a9872e774986636a909d5cc6f6bde8b44add9f33 ("[PATCH 10/19] sched/fair: Prioritize tasks preferring destination LLC during balancing")
url: https://github.com/intel-lab-lkp/linux/commits/Tim-Chen/sched-fair-Add-infrastructure-for-cache-aware-load-balancing/20251012-022248
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 45b7f780739a3145aeef24d2dfa02517a6c82ed6
patch link: https://lore.kernel.org/all/ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com/
patch subject: [PATCH 10/19] sched/fair: Prioritize tasks preferring destination LLC during balancing

in testcase: boot

config: i386-randconfig-003-20251012
compiler: clang-20
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510151514.652b80d2-lkp@intel.com


[    0.527179][    T2] ------------[ cut here ]------------
[    0.527563][    T2] UBSAN: array-index-out-of-bounds in kernel/sched/fair.c:10965:6
[    0.527563][    T2] index -1 is out of range for type 'unsigned int[8]'
[    0.527563][    T2] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted 6.17.0-rc4-00027-ga9872e774986 #1 PREEMPTLAZY
[    0.527563][    T2] Call Trace:
[    0.527563][    T2]  ? __dump_stack (lib/dump_stack.c:95)
[    0.527563][    T2]  ? dump_stack_lvl (lib/dump_stack.c:123)
[    0.527563][    T2]  ? ubsan_epilogue.llvm.14679606394994327670 (lib/dump_stack.c:129 lib/ubsan.c:233)
[    0.527563][    T2]  ? __ubsan_handle_out_of_bounds (lib/ubsan.c:?)
[    0.527563][    T2]  ? sched_balance_rq (kernel/sched/fair.c:?)
[    0.527563][    T2]  ? sched_balance_newidle (kernel/sched/fair.c:13514)
[    0.527563][    T2]  ? pick_next_task_fair (kernel/sched/fair.c:9328)
[    0.527563][    T2]  ? dequeue_task (kernel/sched/core.c:2136)
[    0.527563][    T2]  ? __pick_next_task (kernel/sched/core.c:5983)
[    0.527563][    T2]  ? __schedule (kernel/sched/core.c:?)
[    0.527563][    T2]  ? schedule (kernel/sched/core.c:7025 kernel/sched/core.c:7039)
[    0.527563][    T2]  ? kthreadd (kernel/kthread.c:835)
[    0.527563][    T2]  ? kthread_stop_put (kernel/kthread.c:818)
[    0.527563][    T2]  ? ret_from_fork (arch/x86/kernel/process.c:154)
[    0.527563][    T2]  ? kthread_stop_put (kernel/kthread.c:818)
[    0.527563][    T2]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[    0.527563][    T2]  ? kthread_stop_put (kernel/kthread.c:818)
[    0.527563][    T2]  ? ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[    0.527563][    T2]  ? entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    0.527563][    T2] ---[ end trace ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251015/202510151514.652b80d2-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


