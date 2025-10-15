Return-Path: <linux-kernel+bounces-854871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8CBDFA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A11C1A21BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9133769E;
	Wed, 15 Oct 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f04m9JTd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB3337698
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545545; cv=fail; b=lG2SxKqV1LNif+kd4paM6zMbKH7ib6Py7DhF8krqb5awjiSU7F1Q01oO0OG1l9ASIk58aBxnShOyaA/Z8NPFXviHJBSkTeXG4T+JPTjHiuW90/p43MPen8UJuu5UiR9I8G8zrDsOmykbS1m5aJYL1ZbZD2IygE2hVTEexmL3MQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545545; c=relaxed/simple;
	bh=2H2e6HiZijATbQ4uUcWiiuHg5P3/d4EjTPTQPH3D444=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UuUrdx9pcJT9W1eKz3xb6rUid+YPXp9F6skftpKdU37mMZsfl9jY/zXzjrzLrNUq+Px75wTjM51DCu/rfeK9HCGmUkuZw4CwA8BEQUT+LIP8uJiECxuW2d8JtZpH4nsRmxx+/c6sxvgDPro3YTZ+mKBJbG1Uu8a/g0MkPL0XuYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f04m9JTd; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760545544; x=1792081544;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2H2e6HiZijATbQ4uUcWiiuHg5P3/d4EjTPTQPH3D444=;
  b=f04m9JTd2rlV3hgz5Qhhl3TDfFA79b/Nwxidtru6FCdGNYLLTjmW0acb
   fDdI62aFDD+FPBGYOf0U6/rvZjqzn4Xnve6QEfVCXg5We0LYUNYaGHgQq
   VbF9f3rdUPwazgBf10XnWNkV001r/HiK5ZMWPNAngqQJHrAfFEprgpvR8
   pIi03hO1+lNNePFUPcyxZ+ATBVVCaL9rYha8Xu30QWpykms+jPZUMfrpz
   ny5MgyuGJyn/4ok5XSwIOrly5bQ2HzTw1nUmFXR+HrLHTvoe1FCd7jLSf
   /DOmUsSiH/z3U16OfcY9AByFMU1EWZOsuTuIrdlFkWdg6SHWsTz8i9oKC
   g==;
X-CSE-ConnectionGUID: OS55fjE4RWuvYBra6pW7KA==
X-CSE-MsgGUID: h720h9gKRsCafHSrYyiM5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73327188"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="73327188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:25:44 -0700
X-CSE-ConnectionGUID: k+7L/3DZSXOuruLH3ugf2A==
X-CSE-MsgGUID: rhb+oms1TFaDcR/v1DtfPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="186232723"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:25:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:25:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 09:25:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.50)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehQzomCyw63erwRZg9ASk2jqSbqiF4/M9eU/TtPfse3xFcmfoRKC+6dH7iu/60VDBw7s6bx9RZwevzl4k1VfhJgUT3grcGxx6vP4YRpr8rzZhRlXh3+y4v6MuPlRwSc9cV1AHV9pdgfIEg2cGp4CwccqE3AUORUHiR2L2RhDmYjN0Ldx6VWRXeOeB1oNPAiw3YX/kZx/pS4B4fBx9KBzFqPKw+rzjEPkPghj9rHgcM3R+z/ARF3vUcvg3dcJPTR+v5W3sjdW9cheNS4mjbuzaWNGLHTv/1MRkSZhmlHyB1rE0A/ELVGsiPGICKTymYMcTcdxmB5nV8Z7ONpm6lDQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B72crIfhtZ4t3Q5NxwY/2gVr5CUB1OQMI/JVrtiUOMQ=;
 b=XFCa9ZTCPa/mR6mXTbbMf+bM6nRa7TI0DLf7dKybn8ZzPZU4y9+8KktkKg5CoK/oPU80hfSCeiKTqmobx70dW8bl4hK6fuhC/cPb2Y9FGM4e4KDioDuG+42hYG0Dqy9MgQZZ2WLTYxwWQtxOUAC6W39EjUbx7rMVObrjHYlO+/qMRXk5PplYxNvMcvY60ddc4Wo2EA8SfC0sSr5X2UYimd8TB2goUaGPqJJe6E9qofGD1DLDWOnSnS+nw6Y6ztek9IP0u6wfhXfTKQN/6KzpmCCKh6VQfGcwHHoiWk/1xdXsjJJjXPzEr8Vir63p1aSEnNQN3c6FSoGsqiyiGTomXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ5PPF0DADD6EFE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:25:41 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:25:41 +0000
Message-ID: <15b871f2-49b8-4b62-926d-31f93ad49f51@intel.com>
Date: Thu, 16 Oct 2025 00:25:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
To: Peter Zijlstra <peterz@infradead.org>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen
	<cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015110450.GO3289052@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251015110450.GO3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ5PPF0DADD6EFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df6f98f-004b-45a8-2b4f-08de0c077b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlN5cW5kMWRtNE82VGRPU1B6cHJUUndaenI2NmtsMnZCUnpvUHpkSmtnc3NH?=
 =?utf-8?B?cXVZVEkyRmtzSTNYaE5ZNU0velE0eEJNYkJjZnBoTkoyME4rR1c3S0N1a0Ni?=
 =?utf-8?B?aldUeGUwVjQyT2luV1NFV0dLMXVVYjFmN3loV1VjQkVoQzlkMVNQaEVvMzYr?=
 =?utf-8?B?Tnd1YjdrcUhWL0lMS1B4Y2EwUDlyTFJLa2xiVjBPTnJMZTZRUTFjMytRTWpD?=
 =?utf-8?B?dnYyNGI1ajJ0YUtBcVMxSzhQV1hvSmRjaTVxS2lxamlocXkyOU5zSkhhWmZP?=
 =?utf-8?B?ZmJlNFNPaXUyNFBGWGlZZVVzVG1HNzVtdE9wbW4rU282WkpTTlphNE15eHR6?=
 =?utf-8?B?Wk5aeGNRZHhSUFhWQ0M0MUZFaUdvT0dIMXYwdGZHMHJNWjRQNEhKOThianpF?=
 =?utf-8?B?VFFoSUhObG5WM2ZOTDRCOFlDNTNsc3ZURlhPdDExWWNnRE9RdVpacEc3Vzgy?=
 =?utf-8?B?Zlh4ZHVHclpCcWVRcnlqY0pFR0RrU2Fybm9SNkduUG5ISWx2TmFySzRpZWFl?=
 =?utf-8?B?WGJwVVYyZHRHUGFTaE1vT2JhVCtPNGhSNG9LdlhQRlppZHJ2NGFkbEFmYllu?=
 =?utf-8?B?VlY2b3pZdTYxQnlicVRVc1dEK1ZtamJMbWN4U0Z6cU8rSW4wMmY4aVNaZCtJ?=
 =?utf-8?B?Umoxb2k1S01YWTFhV1doZHlQV1VHVVBrRW9NMWNHenFZaU9JdjU5NFY0K0pD?=
 =?utf-8?B?d2ZjbTR5U3czdHZCcjBmemNmTVBLRnZldjIrSVZ0bGhsYXM3dTdWZXkydDhT?=
 =?utf-8?B?emdxeWtHR3V6c01aQnpvNHJvNU4zUFlwSUZvZVp3K3Z0UjkyZFo1Um53Rnpv?=
 =?utf-8?B?bzQzVUE5V3FTTGpHd1FUdkNxS211aVVlNW04blYzdWJxMzlzQVI4UFFyNUZE?=
 =?utf-8?B?cFNGMHdhUW5QZUw5c1lpU2xFd3BSSTRUTTVGdmlvK0Z1cEFSd2IxYVhYTVNR?=
 =?utf-8?B?OXpKbkkycmJ4QThGclpVUUIrTHVWM2t0S1JFSll4d1ovMHoxWm1nb2xHeU5K?=
 =?utf-8?B?aVBhQ2phU0VTRmhUODVGcVFndTZOYnQzQ0RPMVk1cHNTOW1JUUFKMmNWOWoz?=
 =?utf-8?B?MGN3UjMyS1RaRjI5VlNxRDE3VSt6ZEJQWTNOVEFkVW9VUUREMDRRc3dlVTdN?=
 =?utf-8?B?a1o2NGxVSVh5Sm5OL3F0eFdXcmRZdURnTW1QVmxSY0hIUHNHSndhZ0dqWDRK?=
 =?utf-8?B?M2ZLRHVxMWRIanFVVDZPWjFYc09wZFJFSzExNWV5SzV6OFV1eE1YWVorNmhP?=
 =?utf-8?B?dERHRHJIbGdEM2ZvR0dPZW1KNnpIMlFmVjhhQXJ3d1RYL3ZsMTlERGJGcjNG?=
 =?utf-8?B?N20ydWl2bVRmQ09BQWlWSVpBbDRSZTNHdktxdTkrZGptOUR3U0o1MWJtd08x?=
 =?utf-8?B?T1pGUUtYOVRKdDZ2NFNVZ0VTTUh4cjF2Ui92R2VkK2JMa3A1MW1KSSszbCt1?=
 =?utf-8?B?TVFIdWR5WDByZGNlMTI1cGtYd3pOditHZSt0elVwNnQvSWQwamFHZjJHUTRD?=
 =?utf-8?B?K0ZGSnpuSHdvVGJxNmREenBieFNmbnJEVFIvaUdaZGdwTjJoSldjL0hLQlFU?=
 =?utf-8?B?T2NiVExRalIvRGhodVpBTXVKV2Y5ZEhSeFQ4anc0ajY1dVpTaXVBdE5BcDVP?=
 =?utf-8?B?bXUwQWkyL0ZvbmhCUkowNmZIOUIxSEFJUXhTMFkrWUtmYytRYTcrVDlMenJl?=
 =?utf-8?B?OFJEWVdtNldjR3VYUEFWQmtWQ1RBcTJacFhidGdKSVRuRlo2UjRrZnRNWDBx?=
 =?utf-8?B?cVFnT0I4dmEwTVltaDI3VXhuMGE0aU5GWURXYk0rQUtJcjhiV2Z2RE4xUjRX?=
 =?utf-8?B?T1JUOXlKdEhIZGlkWEI1NmVaOWtjeFVSdy9zRWMzOGtzSmY5dE9jNGs4K09l?=
 =?utf-8?B?SWFXdkRGZ2xHRVA5ZzA2MXR6NG45b2dCYXpXOUFDTE8xMk9OQnhrdDBaNkFH?=
 =?utf-8?Q?qky71WPsCIevEgt023qv04zHZzTjCowx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdyUXFaQThZTm00RFh2UXNreDg1VG5qMUhRN3NhRnlIazRIeVIwc20rdDFx?=
 =?utf-8?B?ZHZJSWswdlhUKzNCNlFXcHUzRXU1UkNVckFSeDNseURKblg3M3VjM0NidWl4?=
 =?utf-8?B?ejk5M1BXK1RLK1lGYzdtbmlmcnJab2xjb2dOT2hsVDZrcUR1QUxQU3Z0S2V0?=
 =?utf-8?B?WE1oREpHRWFwRW5GdjBRdk8xYWpZSEZTSXdaMmN5Vm52T2pkWXl6VCt0Z2V3?=
 =?utf-8?B?dXVtbDU3TDRpU2haZWlZbktqRnZRNlJaUmNRQVZkMnEvSEVsd2Q2bGkrT0FM?=
 =?utf-8?B?NDFsRnVZcFQwbXpWbjVqNlAvNi8xRFg0L1pKOWF2aHlVVzdtelpXMXYxVUNh?=
 =?utf-8?B?L1VjU0RjZDJycEpZUDJxR3R5bGkrSnN2clJBTS83cWdxa1FzOEtUN2liM2l2?=
 =?utf-8?B?VEgvOW96MGdHQ3ZxK2h0cG1CNTlmOTU1MXVCTWtlYXBPSXBKc2Z5cHM5OFhU?=
 =?utf-8?B?enlaUmtmc0kxZ2RMeERjNWpmbFZBQ1lvQnhQd0lYUWxiSmFYYkJDL0Ftc3dK?=
 =?utf-8?B?REdiOVYweWlTbFljNDlnWXFiRnhwdE1jZUl0c2JTYTl6VkpuSWFMaG9aU2lQ?=
 =?utf-8?B?ZDhkaHA0bEJ4YjlBWmdmY2JpTFYrUktZSGQ0TktKelFRWXZ0S0tySlZHTkNP?=
 =?utf-8?B?OE1wZHZQQ3pDeFdrL0JpZlZiaEhtUUFHdHNpOTNOK3FPMzNKSkRqNHdUU0J3?=
 =?utf-8?B?NEQxM2dPRlEwMmgxcUVScGI4OUNxZnozK3FKbFNCMG1hVXV2R3I0YzJ1NVJX?=
 =?utf-8?B?Y1c0MmVYMWk5cm1hVkt1TDdCaGFDRUJaWGRDbHBGdE53Z1ljUGtnSS96M0E0?=
 =?utf-8?B?dWk4c0dFS3BINkRQdm9neCtQT3NQNmhERFhmenp5V2RIb2h3Y216QU1Yclp1?=
 =?utf-8?B?NFBRcjNaTVUvNVJoZVlEZlJOYURSMDAvWDNKOUJuQnQ0UW1XbU5lUlE2cjg1?=
 =?utf-8?B?Skg1aDh5VHZmc2d2SE1VQkJoM2FXTU1GaFRLWTVWYnl0WXAyaWRydHd6aHR2?=
 =?utf-8?B?ZkNhR0tEQ2lJaDlTeXZnYmRTcVpTRDQwSzh3L2h6TnQxTVBSV21laVNCOFdJ?=
 =?utf-8?B?dkhsWFM2bUIvbXYrSzUrRE50NzBZdUZJRVF3OVA1cUNsRzYrNnB5WUhwT1Fh?=
 =?utf-8?B?aGZvZnkwRHhyVUVYU0UrN3BPcktrZUtCMHQzb3pqZG5WN2FnenhPUFd0Ukpp?=
 =?utf-8?B?dkYwTkVxZ0pPclhXb0VPU1NFZDVwdVNDdVBvVjY5clNqWTRRRjJRMXhHZFBC?=
 =?utf-8?B?Yi9vTWlPRmVEK1A0R3FqaFJ1V3ErQjY3OENVM0g2YXdSYjdaYjVCUiswN09K?=
 =?utf-8?B?Y1FBRUU2K3lwdjFnN0JjUnlrSnJlNlNqVXUydG1WKzJrWFRDM2UzTThpd0Zk?=
 =?utf-8?B?RTEyZjJkcXJZQ2J1ZUROYkQzUWxzNWlFbHNSOCs4T3BvSlp2N2VneWNwcFln?=
 =?utf-8?B?K29PcExabTFZN2FGSFhHNVJGcXM2WHZzMUZ5bTBQTTRjRkNIM2NWZHp5SHhr?=
 =?utf-8?B?S1BLMC92OVQwMHhrOVdidFZ6WlF3RjVsNEZyOFdZdnJIL0d4VVEvc0VSbDlT?=
 =?utf-8?B?VDVHdXZQSG1pbUxFNGhDNWtvbzhKNFE1UUVVTDdnb1ltZTBqc01LTEM0d0tk?=
 =?utf-8?B?amJiUE16allzcDdwTmZRbm5zOEprR2ZMdHlzWUFuRWt6Qkh2SWltTnZjeHpa?=
 =?utf-8?B?cFNFMjlHTzQrR0xqVXpwb0pZYzB4YkF0RVNFOWpWTVVVbFJYd3gwK3h6c2lM?=
 =?utf-8?B?QWUzbzEzTVlhb1J0T3V6NHlLWEJWOUFlNU9iOGZRUkNVUHBNVjQvdUhhcXg4?=
 =?utf-8?B?Q0N6cSs3ZjhmMnJsRkcxOVIzRi9PSFhSSnV2R2RnV1grR2x6OHNBblk0czhU?=
 =?utf-8?B?N3ZKQk4rdlN2U0R6QXQrc3BvWU1JeW5NWlBTU0N2VnBKOXU2OVh4anVaNUtB?=
 =?utf-8?B?L2VzZGswbjRLS09veXYvWDZHQXZwdVQvRTc1TVlKNkEzcTN4bXBDRktmcFBL?=
 =?utf-8?B?MjZHZldON1daMDdKQWlOSzJOZG1WUGsyUnFnVHFYR01ySVovK0VveElxNHV2?=
 =?utf-8?B?eW8yUDdVV1l2ZitBS0RjWjhvN1RJRkhpN2FRbTQwNFk1L3RXbitMQ3lxN2Ft?=
 =?utf-8?Q?2Jdny9YDsRjjLQuHAPc7SHptP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df6f98f-004b-45a8-2b4f-08de0c077b67
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:25:41.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVSA4jze4BUHeaQpRrV3dEdidJGuzexqbHjut7keRHx8jfWTK3P0WzW7mnxo1KDcGq4d3rZzQ+Y8NRwouQxjOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0DADD6EFE
X-OriginatorOrg: intel.com

On 10/15/2025 7:04 PM, Peter Zijlstra wrote:
> On Sat, Oct 11, 2025 at 11:24:41AM -0700, Tim Chen wrote:
>> From: Chen Yu <yu.c.chen@intel.com>
>>
>> Enable cache-aware load balancing only if at least 1 NUMA node has
>> more than one LLC.
>>
>> Suggested-by: Libo Chen <libo.chen@oracle.com>
>> Suggested-by: Adam Li <adamli@os.amperecomputing.com>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>   kernel/sched/fair.c     | 15 ++++++++++++---
>>   kernel/sched/sched.h    |  1 +
>>   kernel/sched/topology.c | 14 ++++++++++++--
>>   3 files changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index cd080468ddc9..3d643449c48c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1208,6 +1208,14 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
>>   __read_mostly unsigned int llc_overload_pct       = 50;
>>   __read_mostly unsigned int llc_imb_pct            = 20;
>>   
>> +DEFINE_STATIC_KEY_FALSE(sched_cache_allowed);
>> +
>> +static inline bool sched_cache_enabled(void)
>> +{
>> +	return sched_feat(SCHED_CACHE) &&
>> +		static_branch_likely(&sched_cache_allowed);
>> +}
> 
> Urgh; do we really need _2_ static keys stacked for this? I'm thinking
> one should be well enough.

SCHED_CACHE allows user space to turn on/off the feature at runtime,
while sched_cache_allow is a hardware capability. This capability is
  disabled if there are no multiple LLCs within one node. I’m not sure
if using one key could support the above two scenarios.

thanks,
Chenyu

