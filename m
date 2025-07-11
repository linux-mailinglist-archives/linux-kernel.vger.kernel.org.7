Return-Path: <linux-kernel+bounces-728069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58160B02356
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAB7A404DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E642F1FED;
	Fri, 11 Jul 2025 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip1/WcJP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42E1FFC55
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257416; cv=fail; b=OlM5UQiRcEJATBOF1/+JXnZHtELr0guQOhpL2lnX+QwPWcs03MtehlXB6VLgeGPi0xfcfxt35qGqfqtPQOF50mjRMjqt2EG//HM0fOqdsYleFwSTwV/qFd2KdlXV0GlUefYUbla0OyTPwGd+LBgLCINqxS0nYywHZLPpw0YZBas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257416; c=relaxed/simple;
	bh=O1Tz2bxHioBFNGQBSRjB9ADBu3CsAg1lBFVgXe5BX7E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=d5MA6KBL4N1D19cTYaa8ewQ53vD4I0TeK4rLGC4+ybY1AFK8TXeQ0dgR0j0pvkZk6FbbRnIlQeAOC2g+dWSjmXhpTcNTTYnwJMCPRImqLJDjZBbJKa0vwByTQA61/erRnnVa73vbKkmtvPW12XzIG628ouPGe+k7Q8L17/Zk3Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip1/WcJP; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752257414; x=1783793414;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=O1Tz2bxHioBFNGQBSRjB9ADBu3CsAg1lBFVgXe5BX7E=;
  b=ip1/WcJPW544SbSIlGl8zB//X1fmx6Thp1psBOxWcbjF+6HWcW1sj3mI
   v6/0GU6XL2jYMEaZXvyhROUbg1CFg+UGtA/NZST0PUaU6MvYrNpqVe64H
   xkgtf1utJzeN03An8oRmhCasZJFGjM0Dfk0zA2kSRiBEYY+4df6TFP3cN
   ohexZ7rioBUI3eIUxBEv9Hqm6vBP7J/2SM2d0/qQ8XVOkQfu9DW58T2Iy
   iN2KOWVEffV5Ln5CfQkgbKZXoFOIadDRfAAixbLPbSQhcDIoW47Qrn4sV
   u0gSRoubcARSdOJoiSTMiAp8yuo5n+inRUf675WmV2iEuQ7JZ2qKxSilD
   A==;
X-CSE-ConnectionGUID: B6AQLBbvQPSZZzERORB/SQ==
X-CSE-MsgGUID: /D3W3hp/QnezpPX5kGSzqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54718182"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54718182"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:10:13 -0700
X-CSE-ConnectionGUID: QV9HZFd/QJa62A3GOyg8cw==
X-CSE-MsgGUID: iwTaWji2RBahYk2iNM9GCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="187423832"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:10:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 11:10:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 11:10:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 11:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3wsH672aaN++zDEH5ZN5Y9et+j0i3zq07yOH7lqT/4nd4UPGz/HuXudiR7x+k2tlgpM7VgpDCB5KPpxzUOTD2QQPpU6/jnBDZdvFcCdI6v/3LakHKJpHPR78P2cSdRWtwZn0sa9CzG0i5wBC7x5JnPzPj7D7Lq1U30+kmo3wMkKO9Ubi4E1GvTF9uJ2/4S2CfR7E/Ct8thS8HraY+fOz/TMOJyRbaA6/n/bMQlTzOT9xAUtKFAu5EZlSXaICApBFkQjlfhVAGZ8abgdTi1KATrMHYbWtCJ0smDJq+afdhSNLUzoew3yRgiLLEatTNRQM78WwVZQLXhgnn/WQCGutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlRf3J5pTSBSSGzVXd79JjXNubCnZWTHIQeiJeq0pbw=;
 b=E9nE4yXnPVG5U/oX9/o+v/aTHXrYvkkfzkHw+yRoFXLG1fDqg3UIuMLyGa7YIFk0xjUhAQ6+d5eJfthyUJ4edqKR+oI1d516bjii5YuhUPPaSlEYUShuBAzOYxX8zdQXBrmVWYCl2FR15rahCBYdpwLyVpF4IWtAZsH6abe2bz9iCfh3go2DkT6lwb/twXeBSCKcwNmGRLz1x/tyk9mBB7jChn1CeITvOWAG/twnce3hRLRzx2YsxvfjQ/WH0eQm9Vp287l+D331vCi9X6i8SXP98n+6hiXho26owwoRFdlgxHGptaLE/izdTfvE/GMkHE886z1wVQjXGrqXvpK2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 11 Jul
 2025 18:10:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 18:10:09 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 11 Jul 2025 11:10:06 -0700
To: Steven Rostedt <rostedt@goodmis.org>, Greg KH <gregkh@linuxfoundation.org>
CC: Christoph Hellwig <hch@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Jiri
 Olsa" <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
	<indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
	<beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Andrew Morton
	<akpm@linux-foundation.org>, <tech-board-discuss@lists.linuxfoundation.org>
Message-ID: <6871537ec0461_1d3d100c6@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250711100239.55434108@gandalf.local.home>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <2025071124-cola-slouching-9dd2@gregkh>
 <20250711100239.55434108@gandalf.local.home>
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: cf769d8c-d3e5-43da-7be3-08ddc0a62bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmRnQVV6L0E1MWszaFJLbDVCbStGd09NMkVsQzB0QWtkUzZiSE8xbzBxU25y?=
 =?utf-8?B?WkkxWHB1Q0tiMDhXekppZUVqU2JIbmx6bHI2ZnJRYlJraFIxVnFHVUJHZzk0?=
 =?utf-8?B?dGxXSW1jY2VhbmU1T3NTdUExUXR6bW8xUUc1bHdkd3VOblFibU9rdHMvRkhF?=
 =?utf-8?B?TGpBSEVKT01ZTzVwcWtOWnBUZk82OXZJYm4zY0wrWGptTVZCUDFBeXBMZmRY?=
 =?utf-8?B?OC9DYjJJbFVPaDd4ckdxWXJ4VXppdVMrSTVWekJmK0VLZ1l3ci9GVkhzNTMw?=
 =?utf-8?B?SG9JMzdIWEl3R1N4cllnNW9VczdWMmxRaW1lUkdkZW1JQmRRaWRoNXJaYUdj?=
 =?utf-8?B?SWdlQmtLa2d2QnBzaXQ0Z08wc3VwcnI2TG5laTQ4Yy9UeGhyZnJqcXJiRXhD?=
 =?utf-8?B?L3dGL0pyVlloWExQb3RsSUkvekdyQkN3RS82cVpkTzNkdW9leW5NR2phYTcz?=
 =?utf-8?B?Qk5nb1RSNFBVTmVwc0hmMk83K2llVFhjbThoTGJsWVpJRCtYdnRVRnRCd2FI?=
 =?utf-8?B?Q1M0MFVkVGlrUS96WEZDbWJKV1lFREtXdkxVRjd6L0lwd2VpdXJCSkdGUXQx?=
 =?utf-8?B?d1NlaHhpb25ERG1TSXVGVHFLeDJGWkorclJRYWwxVUQ2dzI5OG1zUXZqeTFF?=
 =?utf-8?B?WG9VS2VLU2tvRmVwcnZFQlRPQ1RBTnBzbk94SEIyQnNia2dOdDF4dDc1bTFD?=
 =?utf-8?B?Zmd2TkU2Yms1MElHK0xxSS9CVUkxdEo2eFl3VVdPcVVVTTRLelhmMEltRFFp?=
 =?utf-8?B?TnlzbUNXdVR4WXZPVkVyNDdxK0lHRGpPOEFFcTdkS1JGR1M3dGw1UWcwUU1r?=
 =?utf-8?B?K3NtNTRSUXdZNExIVUdOeGc2K3l1RW9ZVlVnVEprUkRva0RhdnU0VGo1WjdF?=
 =?utf-8?B?T2p5NjNzelhBTFlkRm0zUHUvRTVGL2E3VElJUS90OUVCQ2gyNytxODh6Q3Fm?=
 =?utf-8?B?aEhDWEFqNndtQXdhZVZhT3cwM1FzK1VoWFJrWk9Qdk9QenFSRUJveTZDZHdh?=
 =?utf-8?B?aWNEa1RjdS9IbERYak1TMlZaV3RiZnJvdk9jODBCay9VR3VJdkRFa2MyUzgy?=
 =?utf-8?B?SzB0b2hYNzF2bkgyb0F0eHJVS21neXNaUExCLzdrKzlRdTJwa3FKL3ZHYXp0?=
 =?utf-8?B?b0hhMWhWOU1JdE94emR4dzZaTzAvVUFaTTkxMzRxTm9ndWpodFc2VjViTjBU?=
 =?utf-8?B?ay93bXJJdjlOaXM5OE8wMTN6cWw2d1NKV2RxQXZtQlBxN0plakpkU2FOUWZR?=
 =?utf-8?B?bkxINm1wTHNFQWMyVHNSN1NEYjdMSG9SejJ1K2RQTUZmNTRNV1NiTjhwWGZ1?=
 =?utf-8?B?WFhkMHBCNldIOFQ5RzB5UktYMGZ4R0JkNS9LV3lUZjk5VzJ4QzhXUUU3UnZL?=
 =?utf-8?B?NHFDa1JUZkpaTE1La2hqNkFWblFoUDJwYmcrWVZCVWdpcy9xQkJMZTI4N3ph?=
 =?utf-8?B?YmtZMjUzNGg2VFdXdjZZb2p0Z0FVY1Z1ZC9ad041YTBYSUpXNUtSeHVpWC9J?=
 =?utf-8?B?YW4wQXR2alJSRGJvQ0lLVVhGN0NQQjFVS0trcGhGNkkzUkNQb3B6Ykd4eG1B?=
 =?utf-8?B?K3FJeVpjL2w5YzN1V3pKREJIbjlUdVZQajZaM0gydEh2MEhTa2MxYjV6TzRz?=
 =?utf-8?B?L3lubCtNcGFwK2JTZVZPbmJiWFJrTDFuZE95RFdYQXlIbWY4TTFrTS9nbVRP?=
 =?utf-8?B?Z1kzMHV1UGV1Wk85NHlWV092bHdZTG1uWXcvWVgyOEp1ck5CaTQ2R2VXdjNy?=
 =?utf-8?B?SUZvWEVsMDUwUi9uSFIyMHBrckk5TXVFQmJWeFZIczUra0hjVGh4U0ZRd0cw?=
 =?utf-8?B?Uk5pUXVDb09rSnp1TWl1K2tCSWM0c2FMRnJqdkdMcDN3azREMVYxVHJYbWY0?=
 =?utf-8?B?MWt4OEpQY1FXajB0ei9HRC9yalo1djJWcmRuVVVkWklzd3A2VkZzaEtQRWh3?=
 =?utf-8?Q?rVA2AjQiYEQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHV4enBxenhVY1o1bWF5SW53T1hMMlJ4N09mZ0dOTmthTEkzTHIzUklIQzYy?=
 =?utf-8?B?L3FjaFA0UFplOWh4UFpvRjQzdDdXVmR3OXh5aGt1cFFtUmR1bkJHMzBIbzhQ?=
 =?utf-8?B?azNFNkFoa0hvSXBzQ0ZjWnh2citVTjRFZUdlZkJJa2JjdXV6ancwamJkVVVr?=
 =?utf-8?B?bHJHNG8vWnN0ZnN1c1RXRXRsVGQramFCK3k4SGo1U2VxYnZra3hsTkxva2Nw?=
 =?utf-8?B?MHFCVnRRUmVKLzI3NERvelFBUHZmMFgwTEI3ZEdDMVNUb1VrSjdFSUNreGZO?=
 =?utf-8?B?Uy9wdk5HVUxpUStyK3FoRHNYbDIrVWdxc1BzcEVXSWN6SmhuZGpvcS96Wldj?=
 =?utf-8?B?cVNHdG1SVHliMVBsZ2RydWYrcUlzQ2ZMd0sxZlMrYThLWjFhZnVFVTQ0TU5C?=
 =?utf-8?B?TlN5Um1meGtwNWs1UjY2U292cnVnTWNzRkE4b2RDNG42OXhKU0RxazFrKzhn?=
 =?utf-8?B?NENzV0JGRjZYK1BLZ1pjdlNpUndLeFFseERYWWJzWkNrcnpXSVQwcGYyRzVy?=
 =?utf-8?B?Q20wREZvS0RnTzRQaU54WnBqUHF1Vmtnbm9ZdE9pT2I3WldibUdqY2QrNEIy?=
 =?utf-8?B?bDhXSnNqQTV5TUVDOVVlRnArZFFyck5udGlDMzFaVTI3R3dpN3VCZ3RxWkVC?=
 =?utf-8?B?UllaamNCemVWSXZBYlM0dThQMXlTeWhocXYyN3lrYmNuVGRwV29qY2pRanJm?=
 =?utf-8?B?bkdOZGlXNDh6Ull1SVVFWjZBRDMrRVpIYVVwNkV3QmtlRlBYNWtiUzBtOHhR?=
 =?utf-8?B?cS8rWDVrQmRzT3ltMUZvLzV5L0c0UXRhekNtTjFHeFc3d1prVW8xNkxQQytN?=
 =?utf-8?B?d2pPcDZmdVd4a295NnpxMEVKTTBpeWFkbHBIdVBXME1JSDNaQTIyYVFaKzlv?=
 =?utf-8?B?VDRyWmhtVWJoQk9xNTUva1gxSTBFUXl0aE4vcmJCVVN1Yi84V2dpYVRLS3Ny?=
 =?utf-8?B?cDFsSUY1VkdISmJRaVdPZVd3M0ZpSlZCTDJ3STRVSHR2RDBEdU0rRXV3Rjh2?=
 =?utf-8?B?YlBpdm5mckhlRkQ0ZFRqR1E3eTRNRVJTMXloS1IrSlZFcTJhb0NCZWptSldN?=
 =?utf-8?B?Z0NxbENCUTNwa3BzczdJTHZCUHYvK3JETWk4UmgvRzg5NjZNV1I3eGNmNy91?=
 =?utf-8?B?ck15TTAwWUxua2VEZzh3L2RlZWNVR3p1Zzlwc0FxaTdKb09Fc01Vdm1zaEtW?=
 =?utf-8?B?MjZ0cFVPTjhQb0VkY1FDUThoMU9meWU0b2ZvVFRHdHdtaE1hbXA2SFh2TS95?=
 =?utf-8?B?YmN4Z0V6QjlCNnJqWnQwKzgwUWtqU2dWaHV3UkZwUUJZY0RaSWhVdUtERnph?=
 =?utf-8?B?ckFhSDk2VS9QNVkwT3VyeUZjdDh3TnFiNFdMT01BNDdGNHBkRHBYYnVCRkIr?=
 =?utf-8?B?MzVjYnVBZzRIeWprZjk0WmtKS0M4WmRDUmJxMFZaRkN3cldzdXRlS1QyaldM?=
 =?utf-8?B?bWg0bFUwd2E2Y1dBNTI4bGZRNnpyaCtmVXV5MG05aVFXM0duOXBjOGNqcHRP?=
 =?utf-8?B?RGRaQ3RSTnF5MDY1OVhaNmxiZVhuQ2F2NFdtZHY5aTdrd2psK2JXK3hCdXIr?=
 =?utf-8?B?clNUQm1NVnBIcDdyRVFaQ3dqeTVMalpRSEo0bWdGbkVUQWR6Q3h6aGFvRk13?=
 =?utf-8?B?amI0V254MWYyaWNYL3hHeXNEMWRBNHhhWTR5d3Evek1zUHB4NTJ5NTlKOStN?=
 =?utf-8?B?czhmSHhxRk8wWVEwRnViOUVjejNKV090c1BJdXA3ZkdpaHR2ejdIaXA4RXZV?=
 =?utf-8?B?Y21BMm14S3VOdVhFSkVweFdjdDhaQmwxVWhZN3ovUWZsTDZkQjJpMVVIbDZ5?=
 =?utf-8?B?T0lLMXZhVVJBaHRSSWV4RnI2MjVSOFZielFudnIxbFIrMjkxNU9uT2hQdmxo?=
 =?utf-8?B?OFZxdVJVUEFrN2l6S3NsR2xaV2trNWJkSWI2ZitVTkNTOW9zcTA5MTVSbjNp?=
 =?utf-8?B?cndtYkRLRFFkODU0Sjdaam5KMlArekgvSE1mMFRJNm8wMVdVVlE5Zm50WHNz?=
 =?utf-8?B?NDA3OEFxMFZEK3RZR1FYN0ZtelVvNHdqdU5Fc1ozRzM3NGZCbmtqZjErMDl2?=
 =?utf-8?B?aWV4OFZHczFOOTJPVllUUDJVb2FVbml6ZjB0L3JtM0FaZE41NjJLRmhCWkl2?=
 =?utf-8?B?TnVYNHpLdVhJcHNIR01LaGk0NEE1ODA5Z3lkS1c1MVNOMTkrcXVXSFZrenBS?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf769d8c-d3e5-43da-7be3-08ddc0a62bc2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:10:08.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPw+XDyVDlOKyWQ1aK+guXkfl4T6v4r/wr1lO7zCWdDczB6KWGBPh5JGCI+wfBP6ECkhrjpfXFSIk2qp6L4n9Cj+UqOkizAHYgPKKwLxhms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
X-OriginatorOrg: intel.com

Steven Rostedt wrote:
> On Fri, 11 Jul 2025 13:38:07 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > Yes, lttng is a "good citizen" of the kernel community, and yes, it's
> > not merged into the tree, but that's not our issue, and living outside
> > of the tree has it's penalities, both economic and technical.  This is
> > one of those penalities, sorry.
> 
> BTW, when it comes to tracers, being out of tree is actually a huge
> advantage. Tracers, unlike drivers, are only monitoring the kernel. Which
> means it doesn't really rely on the workings of the kernel, so it really
> doesn't get much help from changes made by other kernel developers. Like
> the BPF folks have said keeping BPF programs up to date, isn't that much of
> a burden.
> 
> The huge advantage that LTTng has over perf and ftrace for being out of
> tree is that it controls the ABI between the LTTng kernel side and the user
> space side. LTTng can experiment with new interfaces, and if something
> breaks, it can simply change it and deliver a new tool that includes the
> new module with the update.

It is odd to read this claimed benefit when viewing it from the wider
Linux kernel project. Upstream maintenance of ABI contracts is the
fundamental struggle of subsystems. The request, "can we get the kernel
out of the way and maintain our own ABI to our users?" is a consistent
refrain, and it consistently receives a qualified "no" for regression,
security, and other interface evolution concerns.

