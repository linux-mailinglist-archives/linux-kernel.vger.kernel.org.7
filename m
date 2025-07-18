Return-Path: <linux-kernel+bounces-736226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2D3B09A41
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883DC1C432D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1491C8632;
	Fri, 18 Jul 2025 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkDCXr6F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868EB2D613;
	Fri, 18 Jul 2025 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810467; cv=fail; b=bcs8sAaqPI4zMwF1Kxd4Yj6vgjerXcrnPMQp4B+2n44KRpA0hNvG54jan9gfXIhPvjCNs63cK2ZUoKA7hyZog9bmmpecTTgXq440H0tbaLRWz/pKvpqCZX0JqPSveXt9saP+ItLBVm0kBaVoYukhBannE6eyBQrzgOQ3fve6lfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810467; c=relaxed/simple;
	bh=/RJ0YJKcNEKwcqJAK0i5WztJFNTV+9+XRnhqvONCTaA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qCsO5+gpMJfogfhpADF2DKIGj1yw/7Ydgu4H4Xe2sPz251NByeYQD2klYfKJr//er5zHZvnk3PF1LEBkpGzBx1zSxiC7Yl/PQ+Kae0KdO9hwxl34EE3IDhEHvYEKiiJOm1sAPeFBrPr4J6HOOP6Xr4y+uhdgyCTnGliys3qEgVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkDCXr6F; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810465; x=1784346465;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/RJ0YJKcNEKwcqJAK0i5WztJFNTV+9+XRnhqvONCTaA=;
  b=UkDCXr6FMQ88BEO0k/RGBQMXcEPs8pgKjC+VfW8aJh0RaekDmSC+HQwM
   5YHgXUKPvraM29jHKQPrGkNVuyO2fDMH9ciHTfBv4o20s5SH0+EsHXwVK
   fyVVdskLxdjpQNQobgASMN8sMwkkrQVaeba9W8vPlWcYXEnzN9jabYGCH
   w8Hu0sQZSiRcCCNbShcP4ovszDr2RXGhp6+iHXhbz/HN4FwSsS19hieVK
   +73KYM9h02r8gzLeRflZw/dTFwiomAuTm83fmMjmiqFco45/TWYcO4DH4
   l+xDZy/opJT5YY2qDmpLEasLcj8unazOAw3fxgX9NLwr30gd0HLrHMyFK
   w==;
X-CSE-ConnectionGUID: oud1djtXSmS04q6gBwU6Dg==
X-CSE-MsgGUID: yZeY0uSwQZ+WjQmcAE+J+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58912174"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="58912174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:47:44 -0700
X-CSE-ConnectionGUID: Jh12vjPHRFWnS3PXspOcCg==
X-CSE-MsgGUID: tcD7B6ASTtG38bXSPfNzIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="158436021"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:47:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:47:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:47:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.88)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 20:47:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORmmXCGKC/5oh7Oi5n4efiYd4pSI9eGjtm9hfa3gI7DS7GiFenuw1buxJOizirhczAXEy/AN0STSVqnKielB14zBHPK+p43gOjNt/lOaHGnlIodV37Ko52DN0+asbVnhLWdWnSbksdoU5dy9m6yNTivn2PO310cF8+8/IIQw1z52fYMjKhE6oO1xAKyQiaMlwUsNHrOO+/Th0D4BCLBozswU7cYthegqvIJK/34RSIUW/B0f0X9tyCDY0kwtjlV1Jk9SpVZzgweLWbzsFyW0et33jKcnJdGfv26MScoIYDziLuKcosCnRYXa5IYQimKR3p5b7tK/PODzWz7jfLhHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckhwMfh5Q3LQxQ7u7YIX71g4Ov5PHX3nDPEspuI8Zmo=;
 b=V1CcQUvd/fi/h8w2iPQ1QoSlAgZtT/JHDMKm6gYaVoHCBH+JUqensuqNrGcXAxIHb7v2Z+DynwlWuCgL5Qgu3cf4+4WCBEuqTdqnpeI8h818SwUglR4Ji+CBxZivLexWdLerJT9IZKRVhNMh25UYPyGpqli78KhcIz61Aqc00aGgcXflY0lUS5boGzWY4rfwcaCphVSq4a8qVOw0Y4g6pMnbv4tpYfk0o3MBqFZxPaiGfg6V4No31lDpWOTTC+B1u6h2PKnTRr6q0jqApYYfmLRRXNLkPC+JuaFQn41k3yQvXy3SkYl5aFDXwVM0HSWhfbog6aoAGum7+hI9ySmWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:47:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:47:39 +0000
Message-ID: <f45d9b7c-90cc-439e-b51f-5e7aa3d8ceea@intel.com>
Date: Thu, 17 Jul 2025 20:47:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 17/34] fs/resctrl: Add the functionality to assign MBM
 events
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <70ef9637d73825ee5e7409ab04df1039dec0873c.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <70ef9637d73825ee5e7409ab04df1039dec0873c.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 6529fa57-9fa1-4366-7ce6-08ddc5add7d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmIxdHAxb0pJUTJudVZDa0prQzhyR3RGWCtEZlZQL0VqSkp1cDRtdzFwV2Ix?=
 =?utf-8?B?UGFXSENkRHdrY0tIcUNnTENSS24rdjllKzMzNEtlaHZneGN2VzExZHVKMVQ5?=
 =?utf-8?B?M1lWWEJlUW13dE05N005VzdjUENGN3FteHlXVWdlUU1xTkx4M3dVSE9pNXJZ?=
 =?utf-8?B?YkRseVhybmIzVDdENXUxNDl6Z3dZa3VtV1ZqOVlPcmw5dEJRbHB3LzJEUEZ6?=
 =?utf-8?B?ck5EdER4aTBCVExnMVU1Q0t0Y1hqNml1ZXFDazlkelhMN2drMXhsNlpuWUND?=
 =?utf-8?B?MVc0T2xJaEVQOE1nVmVZVW1QU1Y5ZmRuWW9WRGlyVXhEOExiQlNoNjh4TTAy?=
 =?utf-8?B?MEJHVC9XdVJaQis5OEhxczFOKy84Qk83LzRTVGJFWDE5ZjNXUTBrRld0RXBs?=
 =?utf-8?B?Sno5aWNVYWkrZFN1WlFFTWZ3eEdOYW5EVVE2V3ZXdElMUTBiaG1JZDlkS1FF?=
 =?utf-8?B?YnUzUkRLeXVVV3VNL2tuL3RRcS9MczNVcC9XRkZicDR1YzAweUlaOEdZdjZr?=
 =?utf-8?B?TnB4cHF1Q0VROGZqYTVJZTVWNWN2Z1VzaUFNN2NaYXZ6Z1NJMmRoNUJ0WS9h?=
 =?utf-8?B?L2lzQ0hPaFhtdEdvaENmN2NPZWdlOUNqQWFSSmFTa1Q3TGVMV2s1Y2J3b2VI?=
 =?utf-8?B?WVg0cHlTN3NpczdhUXZsVXRjekxMWVhIVGI3c3AvcDJtWGI1b1JLM1VnaU0v?=
 =?utf-8?B?U1hOVmxNb2Zaa092U2VMaUVieEc5SFhXN2hmR1ZUZDFubzV4b1h5cFkrWWZq?=
 =?utf-8?B?MXU2Qkl3RTBETFBOcDRmRFl1MnBwL2lyRkszZ0FlQ0MrUG01YzVlY0RpaFpa?=
 =?utf-8?B?MGszS0J6ZjhnRFNMcGRlVnlmTUZMcUZWODlYK3ZtU2xkMHFpQVY5L1ZQVi9t?=
 =?utf-8?B?TTRFa1RjckE2VE9kVGY2K3ZoK2owUHR2SjdRaVNPMWJMeFpXMmdES3Zqd0RL?=
 =?utf-8?B?YmpReVVJT05vSFowL1ZzUk1oeGQ0UnQ3a0NTTWdPek02Z2NLU1NqM2FJRnh2?=
 =?utf-8?B?TVo4RWtsMHJTSEowTDZVMjhTZkZnSld0NFYrY1Y2ZG1Jcll0Mm5vandmMEtD?=
 =?utf-8?B?OXdZYVgwNzhMbWdtdDJnZGIreXYvUzlmbTJ4eVVPVFdBOXpXaC9OOWtMNE5n?=
 =?utf-8?B?dVdUWllTdEpvSlVCZ1hoK0p2ZnQ1SW9vM1VBaHluRjh6cDBrb3NEN3AvOTFw?=
 =?utf-8?B?VUNwZGM5VXIzYjBxQytsejIwOGdBTUxMNWVwUEZYSHBrektVMDB4aVBDZm5r?=
 =?utf-8?B?KzhrNkhYYmpBR2RzcFM1akQrYmdBUzU3Qlp6MG5GMDZIWUxKdkdlalFqdy9G?=
 =?utf-8?B?RHNGRXdiNlE2cVAxbVVnS2hsZ3V6cUl0Sk1yN1VPdnBLTjlUWmRyZEdQc3BZ?=
 =?utf-8?B?aklyR2ozWHo0SWxvTG5UVnQyQS81MUhCajBhekdMRk9jUys3alF1dTRHR1N0?=
 =?utf-8?B?L3F5bWE0UnB1dE9CeDFzMUdLR2FtUnJtb0VTcnFobk5mRzlZQ2tLa0lvZG42?=
 =?utf-8?B?eGpHYUpJZmdxTi9FRjh4OVN6L3ZUMDBlOU1mTncvT3FqUWNMSEVtL1l3T3RW?=
 =?utf-8?B?eTloTGNsY1BRbGtXN1B6NHZRRnI0VWlITXNhYnZKdGQ0YStoT2FRRXVOZGMx?=
 =?utf-8?B?L0VVdmVyTTNkekVTYUcrZW9MaTNZZkhiMFVOTUpoZTY3MDJnanJqSDRNSnJ6?=
 =?utf-8?B?RUhidnI1RG81SWgxYm43NTZwSGl4UmgwWWhJOTZROFNtTFZJMnZwYzR6dVpB?=
 =?utf-8?B?YlFDdE9GcjAxR0EwKzQvbGZjNWFCK0pvclExODRlZWIzWGEzVjZuODZVNkE1?=
 =?utf-8?B?cjNGU2NnaENmWnJ2ajNFQjhvd3o4ZGpjWkFFcnkxRlpwR2VhSCt3TlVXTDZT?=
 =?utf-8?B?Y3F5SitXMmdock00R0xJdFZoZFViSUlrcVhUN3NCU0hTUFpzU0t0WFhEOXM1?=
 =?utf-8?Q?QEvJ6BJ53Hg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtWZG56WmNnNE8yTG55ZHpQeTdMby9aQVJ4cm5BV3pXOGwybEJlQnl1QlZn?=
 =?utf-8?B?NlFwaHBFdXV3WXVNQ1pKbFZmQ3VQM1dHQkJQcmczNlhITjB1dWRBMU9GeGpJ?=
 =?utf-8?B?eVBua3ZIR1AwSjZ0OVhpb21NSGJDdkFYaUxWbStOWHZ1OXJtRWd4ZDR1SVMx?=
 =?utf-8?B?eUxQbnVrS3RzVTJxL2RSTHhKeHJuQzRwWGpQamhjZWNkYVgvb2JIWUpWWUIv?=
 =?utf-8?B?dFdGN2hZMHJTK05nd0M1ZFpBTVhOZjRtV3JybXlNVy8wK2Y3T0RLNDdzT3E3?=
 =?utf-8?B?cnprQzdpdUpWbzhPSmxQRnowY0lGekV1UTZIa2xtR2NZMko4Wm43aDlrSlJ5?=
 =?utf-8?B?WkhJNCtVc3FOOGxpMFlmdmYrOUZ1djk2bWVUNzNpTS9ZaXBPRVlQUTJkOEhm?=
 =?utf-8?B?OGdtSzZTdDRFdlNRNHZKR2tndE8zMFhobGV1cmJ3SWpUNDFncHRCc2dsTGRF?=
 =?utf-8?B?cklhWDVvcnFDbTh0VDUzN0dac085NGxuTzBZdy9SeTMyZWdYMlcrQ0hOSFBM?=
 =?utf-8?B?VmtBd1pTckZCWFZ5ZDhvMG9DM3lXME5yQTlXY3R3QzkyOE83eWwvRTcvdjlH?=
 =?utf-8?B?d3NaK3dxa0ZzWGp5SzFKQ2lIYmtncXFWT1NzNUZZd2w4UW1pRUlwdURib3J1?=
 =?utf-8?B?UklybFV4cGN6RSt6NUx2eHprM0VBUGxGaDJRay80TG5EWlltUFNDWC9mZW5J?=
 =?utf-8?B?OGxObzdOUmxacXNNVFRkTjJHOHhhMmZLdTZISVlaLzlodGJUQnNBMDhSTVly?=
 =?utf-8?B?bDdqdjJaeFlSa2JQNnJOUzhZY2hOUW5ndEg2R2paNlE3dHcxUlB4L2U4SjRE?=
 =?utf-8?B?MG9OUUVoUXFkVHN6RnhkOEJFNTNrMnJqVGUyZ2FLR3NnUHBiaFo5ZlBrRjF6?=
 =?utf-8?B?R3NSWEJiVUg0TkkwOFU3ZkFKN3NoZ1dlU1dCdExCUFBVK2IzYy9pelpCNjdh?=
 =?utf-8?B?clA5YnBNendOd0VUY1NSeHl1eElIVlpHL3dRRDFYN25qN3RrWmlielNvdStF?=
 =?utf-8?B?eVF3eUZweWloK0dYRCtNMWtQekdjRXRId3VVelRMM0hDUlRJYUMxQWgrZTBU?=
 =?utf-8?B?T3p3K09PTlJLU2c1TUJ1cmd0TlcyZUgzRzZMdXN6enNGeEM0dFBnaitqZUNw?=
 =?utf-8?B?QUY1SENra2RhMDF2Y3R2R0thYi9pcXZyRUNYMFRCUTJSYXUyQ29vOTZlQ0lQ?=
 =?utf-8?B?dGROOHIwK1dETE9XeURnZ3ZlYWRtSml3OXJFZVhtZXNqdGViMHY5dHJYRVZ5?=
 =?utf-8?B?WFhIVlFxRVpBQy9JTDRqanNqVDhmMnQwL3Y4VEl1cVV6OG5PVWxHWVk2SFhx?=
 =?utf-8?B?b1NFRTBPU0l3RkhibGVDTUlMTU5ONWtISmlnUTBoNWVLZVdNaGorL0JQUzN5?=
 =?utf-8?B?djR4MlRoTGQ5TzJKckNYeFVvS3l0NGpvQWZhRGU1N3p1Y1RIU0NkaEFXc0Qr?=
 =?utf-8?B?RWdQMjg4eUhCVFFnY2s1MnAzTHpNUWpaNFBvTWp0bGFic1JBckJsL3E1RFdK?=
 =?utf-8?B?NU1hbXRWclpyS0ZJRCtnZnl4YzJrVitJdHlZM0J5SzJUa2ZZRUMwaFJUN3lR?=
 =?utf-8?B?OGFwaDluV2FkVXlvZkl4VDNoZ0dZQzlmRlBmOHFzRnF3bXVORnZrRWxqaHBz?=
 =?utf-8?B?Tzc5NHUzMWdGQWNmUTVnaGJYZ3VYclFpRDMrMUF4aDliMlFYbFgzSTlGK1hU?=
 =?utf-8?B?YUFlWURRRjY0ZjhPaWV3SkgwS0ZLU2RyejFCUWNER0VzR3JuaGRMSlVaMzhP?=
 =?utf-8?B?OEFDa281cWhYZ2F1bmI3aVJEVmpHb25kR0FGc0FYeGNOK0Q5ajE2RUQ5L1Fz?=
 =?utf-8?B?bjE1UFFLNDkwUkdXbEt2MlFKZ2NlVlhrRWZIYlR1d0Izakl5L2paYWpyRExJ?=
 =?utf-8?B?dWdCVXEyU2F3bzd4bWo1SkVrZXFCVjA4NE1vOFY5VXZ4dk81cUZkb1h6Q1RX?=
 =?utf-8?B?VVh0SFRRL0VtZ2lJeEIwWTJrUFhybzNicFArbEJtNC85WnRBVEpWUlJ5M3RV?=
 =?utf-8?B?WFZPOW9rcVdZdHBWSEFWUDZ4ZzlOY0FtUzhmQmVDL20vLzcwTjJSVkFXa2pZ?=
 =?utf-8?B?TDZnVTF2N3FISTFxc1ZRb3ZpWjRMeHFIU1FFUTdvQk5lL1RMVXN1Z3hlRUZC?=
 =?utf-8?B?Q1N0K3gxK1AxNHR6RlNWYmh4RzVKemhRWnczbTNnbUltVkMrcFF4MG1UaHJn?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6529fa57-9fa1-4366-7ce6-08ddc5add7d1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:47:39.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8qdyj2mWMuabBGbiEesq/mB9vK3o+BwOVtI0NT6vdAyr8/jpAx8ZOazlKUTsC2pKDKD6kpQQuWPahTsCenbftWNwRR5GCUITK4hggDlfgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
> number of counters that can be assigned to RMID, event pairs and monitor
> bandwidth usage as long as it is assigned.
> 
> Add the functionality to allocate and assign a counter to an RMID, event
> pair in the domain.
> 
> If all the counters are in use, kernel will log the error message "Unable
> to allocate counter in domain" in /sys/fs/resctrl/info/last_cmd_status
> when a new assignment is requested. Exit on the first failure when
> assigning counters across all the domains.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  fs/resctrl/internal.h |   3 +
>  fs/resctrl/monitor.c  | 131 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index ea5c9fa932aa..8879e127a8b8 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -387,6 +387,9 @@ bool closid_allocated(unsigned int closid);
>  
>  int resctrl_find_cleanest_closid(void);
>  
> +int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
> +			       struct mon_evt *mevt);
> +
>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>  
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 11327bd8cf72..bb074773420d 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -952,3 +952,134 @@ void resctrl_mon_resource_exit(void)
>  
>  	dom_data_exit(r);
>  }
> +
> +/*
> + * resctrl_config_cntr() - Configure the counter ID for the event, RMID pair in
> + * the domain.
> + *
> + * Assign the counter if @assign is true else unassign the counter. Reset the
> + * associated non-architectural state.

Is this API only for assignment? It seems so. Looks like resctrl_config_cntr() is used
for assign/unassign while rdtgroup_update_cntr_event()/resctrl_update_cntr_allrdtgrp() is
for re-configure.

I think this will be easier to understand if the function names and comments match this
usage. To help make clear when a counter is assigned/unassigned or when an assigned
counter is re-configured.

resctrl_config_cntr() can be renamed to rdtgroup_assign_cntr() with its description
matching what it does: (a) it does not reconfigure a counter but assign/unassign it,
and (b) it operates on the rdtgroup.
It is only the underlying arch API that uses "configure" for assign, unassign, as
well as configure.


> + */
> +static void resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +				enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +				u32 cntr_id, bool assign)
> +{
> +	struct mbm_state *m;
> +
> +	resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
> +
> +	m = get_mbm_state(d, closid, rmid, evtid);
> +	if (m)
> +		memset(m, 0, sizeof(*m));
> +}
> +
> +/*
> + * mbm_cntr_get() - Return the counter ID for the matching @evtid and @rdtgrp.
> + *
> + * Return:
> + * Valid counter ID on success, or -ENOENT on failure.
> + */
> +static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
> +{
> +	int cntr_id;
> +
> +	if (!r->mon.mbm_cntr_assignable)
> +		return -ENOENT;
> +
> +	if (!resctrl_is_mbm_event(evtid))
> +		return -ENOENT;
> +
> +	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
> +		if (d->cntr_cfg[cntr_id].rdtgrp == rdtgrp &&
> +		    d->cntr_cfg[cntr_id].evtid == evtid)
> +			return cntr_id;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/*
> + * mbm_cntr_alloc() - Initialize and return a new counter ID in the domain @d.
> + * Caller must ensure that the specified event is not assigned already.
> + *
> + * Return:
> + * Valid counter ID on success, or -ENOSPC on failure.
> + */
> +static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			  struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
> +{
> +	int cntr_id;
> +
> +	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
> +		if (!d->cntr_cfg[cntr_id].rdtgrp) {
> +			d->cntr_cfg[cntr_id].rdtgrp = rdtgrp;
> +			d->cntr_cfg[cntr_id].evtid = evtid;
> +			return cntr_id;
> +		}
> +	}
> +
> +	return -ENOSPC;
> +}
> +
> +/*
> + * rdtgroup_alloc_config_cntr() - Allocate a counter ID and configure it for the
> + * event pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
> + *
> + * Return:
> + * 0 on success, < 0 on failure.
> + */
> +static int rdtgroup_alloc_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +				      struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)

How about rdtgroup_alloc_config_cntr() -> rdtgroup_alloc_assign_cntr()?

> +{
> +	int cntr_id;
> +
> +	/* No action required if the counter is assigned already. */
> +	cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
> +	if (cntr_id >= 0)
> +		return 0;
> +
> +	cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
> +	if (cntr_id <  0) {
> +		rdt_last_cmd_printf("Unable to allocate counter in domain %d\n",
> +				    d->hdr.id);
> +		return cntr_id;
> +	}
> +
> +	resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid, rdtgrp->closid,
> +			    cntr_id, true);
> +
> +	return 0;
> +}
> +
> +/*
> + * rdtgroup_assign_cntr_event() - Assign a hardware counter for the event in
> + * @mevt to the resctrl group @rdtgrp. Assign counters to all domains if @d is
> + * NULL; otherwise, assign the counter to the specified domain @d.
> + *
> + * If all counters in a domain are already in use, resctrl_alloc_config_cntr()

resctrl_alloc_config_cntr() needs update to match function name

> + * will fail. The assignment process will abort at the first failure encountered
> + * during domain traversal, which may result in the event being only partially
> + * assigned.
> + *
> + * Return:
> + * 0 on success, < 0 on failure.
> + */
> +int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
> +			       struct mon_evt *mevt)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
> +	int ret = 0;
> +
> +	if (!d) {
> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +			ret = rdtgroup_alloc_config_cntr(r, d, rdtgrp, mevt->evtid);
> +			if (ret)
> +				return ret;
> +		}
> +	} else {
> +		ret = rdtgroup_alloc_config_cntr(r, d, rdtgrp, mevt->evtid);
> +	}
> +
> +	return ret;
> +}

Reinette


