Return-Path: <linux-kernel+bounces-797601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C810AB4125E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B561B2830D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A586B1DE3DC;
	Wed,  3 Sep 2025 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWPoTdVP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33208139D;
	Wed,  3 Sep 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866771; cv=fail; b=Hh1YV0y/qmFYnts4ORe1E1KOslaK+4cKZk+dadcqpIhURkhe27LjY6QAR37Dol11N8YqcOV6nPzD1cYSVegzP51plf+vn9JlCAs8hhtQUugzX+h5A12OOTnBrGxHXa4dsDDpKkPiibZLIT5bf98QkuPCC84wwhL/Q9HqKJFPB6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866771; c=relaxed/simple;
	bh=9MjQJepQ006E0ijNwya2M/8n0AbufA2eGESfayRxUR8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BrhXhqCbUTUw2l15cSjbJ1lGQgwC5wPnWx7qw8YfvGwZbvtu6ROVZEBrWO5sTVoyTNR8d23f/PJLrQRPuVKXNyqIHz/qSr2WQ9y1tIpv4r7oqE26oxky+XcEGRK1jc4PQP8lY40d486oxbc6pxckBWhyG++bPcRDQPxaBkZFx6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWPoTdVP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866770; x=1788402770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9MjQJepQ006E0ijNwya2M/8n0AbufA2eGESfayRxUR8=;
  b=aWPoTdVPbw9BtmW0gKKOT//Joq+ZPR7sdz2WGYFvlrVzXZlCZ3cDP3hL
   JvFRrm6kuPYkXRQT2bVj4EY3PbZoahaGcLKmhVXR5dBwcJLCZ/k9mXbr9
   QCl4FqLWkHcIboVRYn+kBGevfp0qRdkYzahgTOU5+izS1WYtD2kfLmsWF
   UuQIvlGdbaPOgbaxFHI+isbdy7lw/p9KO899scMsJ0iUW0XJNbJjFRPm3
   JsUmvV+coN4ouN9OuPMYhUPzAIsVYQ8n5Q3GeFwjjFrnqXYbzx+XjMizB
   33X7fgMkyXbSgFQMeFm52gqkTJbebcUF0O3iqmSEr7yiy9In7yEt+hTnL
   Q==;
X-CSE-ConnectionGUID: 0wJ4Qig+Q3yPhD2sf7JUaw==
X-CSE-MsgGUID: TacrfVawRp6hjWKgUsPQqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58384367"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58384367"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:32:49 -0700
X-CSE-ConnectionGUID: 9B1DDtO9RFaRCT0LK35j6g==
X-CSE-MsgGUID: jazAckacT0qhQPXo8nj+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="176744050"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:32:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:32:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:32:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpG6kuvYhxxYnlzPlG7uGDA9gz1DRnCsGc83gLVyzx3LHE4xp+NEpfHtzwxY7I8p+/tJvyB72UJQsmiXa+FwdwPBuApkA6/FB28CVcfDnNts42F0TCoI5DrXDycL1Xhz8bdTaNYhBEEimrHW4xGZuj493t4Rb56cBESGMhaEIKPqjLX1Aa2H2PIj2OShoW0pTjX1JAb+pmhmYudAL+Wo23KHLorlg3bWXYf2bw5JCTd+xaMpG/cYVLyjcn7h1mpCcNUKXHm2Qztdei8eV8JsRVYF1v0WE3h5bEQKFoNQPRLIbNfreC0PGnTFH5s2CLu7gUk6WEZ5oJlGTvD/AK1z1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQgh/nv4piPylKu0uiBIIf/Z+1OL0vkVOCvsBSiQcFw=;
 b=j9jc6IH6H/unSlg4dVs+ZiY9bctXpCMn5U5+h0cOpCl9beJagaRgqnb0NbYD2JY3aQ0bNTLvu8c4wqQ4zFVuEc356Ftc0YXUwXPX02h3GSk3J0sVbBO+dAsCkXIDFqyz4VQ7mfwtkB5D2UkQmgz5cLd9mHXJywBsjGzsMOg0VhIpD2OrR6NggMQx11X5gxwxmVhMdR+8XKdlEZv2cdPTmDUcFLe5PTuJlmXz8IYKusgcfikDnxCQxutHltnGbohP9yKaoOB2h/ww3Uuit7GmE/pfK1pdfwSWLnjQzthxs1A8lkYNrIZq/dPzjr/iJB33h4mRXf8tL8MM4YabR3OBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:32:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:32:44 +0000
Message-ID: <ab3fb97e-a08e-4c3b-b7c7-6fce155b2b2d@intel.com>
Date: Tue, 2 Sep 2025 19:32:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 17/33] fs/resctrl: Add the functionality to assign MBM
 events
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <3ca72cb03376d3433167f0a35d49f2e894c41db0.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3ca72cb03376d3433167f0a35d49f2e894c41db0.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:303:83::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 8115d952-e7eb-4eae-0808-08ddea9229a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3VUd0VlLzdia1pKYTRuYzlpQ3pzMzZUaThkTjJKM1ZycmdqeUYvTjI2ZURD?=
 =?utf-8?B?aDN4SGV2eSs5MlpPMVZKRjJ5RXFkYjJ2SU5WUTRnRndycC9VanVicUtTS0Jm?=
 =?utf-8?B?YXdwZU0yU2RQeWxoZDNnWmVLSnNneFZaaitSaG81blFlUExoZTNrSG5oSzhO?=
 =?utf-8?B?YnVLRDBrcEl4YStDYm5VR2hFMU1MaGd4enZUelBvSlZHOW9kN1BPdEVJQXg4?=
 =?utf-8?B?ZnRzVGtLdXVvanJJYlpKcmZmR3JOSG9EdGxsL0QxRmF2WDdtNU5qTTRMTHQv?=
 =?utf-8?B?NFNGZnNKUHY1SGZreUQ2dXhLR01HTzZQblBjRnJNWXNLOTk2R0loaVpxdVMz?=
 =?utf-8?B?MWxndzJiVTE0V2xYdDRnSGdQZUdRaGt6bTAzV1lVYk9Zc2VFdVcwNUU4Z21K?=
 =?utf-8?B?Ym1BNXlNZjBkZE8vMXlJcUo4amUwRjhOMEJISGovbGZNbC9LRWphQm95aDRK?=
 =?utf-8?B?L2xzSmpPNVpLaXVyQm1KbmU5ZmZTQ1MwQ3JPQmJzSDAyMUNTVnliVUpOZUNX?=
 =?utf-8?B?cEZBMTBHUFF1ekFQalhjdVI0V0grNDVhR0FXUGI0Ykd2MXM2dGlHb1FzTHc3?=
 =?utf-8?B?SEN5TkErZEZXdHA0bk5nZUQwbFR2MGRWVGRNQVpsaFhvUU5UaXEzbTY3L1pW?=
 =?utf-8?B?Qjg4Ri9NUXpOM0NVMDJxbDEvSlFQZmhzczZJRU9RYmJGTHJ1OUV0YTZpSGtG?=
 =?utf-8?B?c1VMUG9RZitNY3RFSnpvRHFUbzdjSTZVcHBLMVdnQzgzb3FyYmtVS1oyb2Yr?=
 =?utf-8?B?Y1dqTHFMSENFYjgrTnRCMlpyVExwYy9oS0p5d0o0RS8yRHhkc21FODJLS1NP?=
 =?utf-8?B?elhWRys4bExJRW1HNFgwMnBXTHVmQkV0OGZ5S3F6NTJ0ZHFhTWdKcmQvTlNz?=
 =?utf-8?B?Vm9IbmxwSGFaTWZRZWVzV3RBY21oSXBPUkRlUUZZSVIwT0hmTC9EQy9UNzlK?=
 =?utf-8?B?ZW9NVmFzaWo1alVZRHpMNCttSEUyQjc1YVFHcnF5TndMSGR6RVEvM1dnajdO?=
 =?utf-8?B?QUJrdVluVS9hVEhUWUZtNE9vbmJRQUJhSVFKUFBHSDczRHVBME1LMzJnb3Zs?=
 =?utf-8?B?Vy9MV3JIYm9aSXZnam1CUHN4cnE0ZE5UTjJ3SWtuaEYrbzlRTGpqODRSVGJn?=
 =?utf-8?B?eHVUU2tiUmV0bXdSYi9WYTdNbXQxUDJFQzUzUGx4a2ExL1BtcjlnbEdaRk5L?=
 =?utf-8?B?ZDdhV2k0Wm55U3pDa2Fsb250M2JGMG5KUmhDeS9MazBtMGRmK3AwRE53eWUv?=
 =?utf-8?B?cElrZm5vRktieGtyMFpSWW94Z0FvNFV4Y0FpZnhiM0M2VzI1Wmd3dlgxN2h1?=
 =?utf-8?B?YUw2eGZrQjJyY0ZSZkM3bldVaHJweVI3QWNnbmFMYkVHR00yWmUzM0ZSNjdq?=
 =?utf-8?B?d1ViTnMya21kKzdWZjBLWDF5d0tSSVp0WVFuZTgvdERxWkk4S1JocVZCV3NB?=
 =?utf-8?B?NDNKYVZ6SmNPZ3FyNFdGd3JldXF4Y0haalMxVmM0ZWptcXR0V2NIYk9rVFUz?=
 =?utf-8?B?USs2bHR1WEdxYjRDRTdxT3lzZGFwT2doQmE2OXdxaytabGlMZ01wQkIwaUx3?=
 =?utf-8?B?MXk5dzZWRGg1Qkx4MjBqbGQ4djYydFFONG1rMzhkdkhSQXJ2UTF4MDhpUEJs?=
 =?utf-8?B?M0RuRC9EeXlNRXgvYXJFTzVYRktlVC9xWlB3WXMxRHhqcU5qUnNEcUw5a1Vn?=
 =?utf-8?B?Z0RWeHFwdHRJRXlPOVZDNnhuRE9obDErQzVvSGQwVUIyTHRHR1hxTmRFSTA1?=
 =?utf-8?B?T3p2bFhxRGc3R2RmLzhvbGx5ZTZtcTd6UFNCOFR5bkVKVW1oWHlaUE40WXd6?=
 =?utf-8?B?UkswQjBFVzIxcXozdTVyMmVEMW9UVVQ3bURzWTFKVkk2ODBGVHRROGI5Slkx?=
 =?utf-8?B?N2MwWUJYdEJRQVlQd01vRkNwRWdWYlZsbUU3aHpGcjRGWXpwYXFRMWhCaGM2?=
 =?utf-8?Q?22QCJqpHDsM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdEZEg4dXRwMC9vN0V3NkdWZmZFL0NLT29LWFNTZDRLK0FJQkx3OUU3RXRG?=
 =?utf-8?B?SlliZ0hwZU02aHhhWmYvZFhPSWdVT2tscEtzenNveVlwUFZDS2VwblJRVW03?=
 =?utf-8?B?THQ5OTlPYmdMajhZWjlyZjNhVkRXMlU4R2x1WU9wRjFObWFDOVdXRXA3cnBu?=
 =?utf-8?B?WlBmVi8zYUxVbVBic1NUZHV1ZkVNZk1ndUZicXUxM25vNjNLVDRwTHZGRDFm?=
 =?utf-8?B?blYwMlIrT0srL2IxSzZHeGV1SWhsMDNKeFFKOFVPZnJBWlh5akVESWMzUDdo?=
 =?utf-8?B?dDVaWnQxM3h1eUR0T0x4NWJQZ1h4US9Ra1Foc2ZoZnA4UHg3cTU5ZFFJd2lj?=
 =?utf-8?B?MkM5QnNPQWtNUkx1OUVvRnV1aUZFdS9JUzN2Tm9ON241aGMzOG40c2xXR2xZ?=
 =?utf-8?B?YUs0SHREVGFaTGs5dngzYTFqQ3BmUXNaQWVlNnhQMmc0NG9PZjRyT0s4T2Ir?=
 =?utf-8?B?MXNqVDI5endNZWpNS3N5MUd2cUFLL2ZDUTVlN2RZWEFCTWxUejVTaEYvbWV0?=
 =?utf-8?B?ZmZTRWpPSm0vNEVCYkMrbkd0VXFISFAwbGZjT2VDR01HY2RqZmNTOEdMVU9T?=
 =?utf-8?B?MHJoU1kyTjY5WWxNQ2FleldSakFGeEhDMXRFRVFOQ09MSzRJZkZBOVp4KzlG?=
 =?utf-8?B?RWdTeEpxTm9pVjJjaWdCcGJNQnJOMkRYMEFsVDkxc3E1YVFsdWVnU3JTUlBV?=
 =?utf-8?B?Qk9sOHlkSy8zM0doWGU2SkxkUk1YU0xaUkVvK0tlYTFmNHRTWDlxOFRPR2hz?=
 =?utf-8?B?R2ZTZWdsMWlpYkN0ay8zODNaRG4yUTZkSzhvN1greHNQbTUycnFaWmpMRmhO?=
 =?utf-8?B?QW1keEhibWZOa2FsVGdTYVA4TFFjNzBuYWlrTHRhc1gwNWl1aWRyNjl4SVQ4?=
 =?utf-8?B?MDg5bTRuYmxQWjBqTG8xYzluRFpHbU04Q3hwcS9zb3Z3MHVQNEFxWTlXcVc5?=
 =?utf-8?B?eXVqbmNya040OTZPQkRnOENoVFU3N0hJUy9raTE0a0hnSE94Q3BEc0NjcVMx?=
 =?utf-8?B?UytvdlkrMi9jaC82R2phcWNxOThRUXlUQWxmYlVTRi92TFk3K2JLNFRoMmdo?=
 =?utf-8?B?M2hvVis0dXJSUjFUbGpZM1ZXdlRXbDJGSnYyZm1xZGhmSkErMjBsN29HRlN2?=
 =?utf-8?B?aWJIVm41RmVicXVQOSt3SmRhNmNEdlBtZHA5Z1NzQTJwQnRBaklTR2FGVEc4?=
 =?utf-8?B?bUN1M2V5NjR0cG43UjRlWEJveWNZeTlncFZhTWsyc2RJTkhSSGI2TEZ6eTFT?=
 =?utf-8?B?K3NhYVhQQnI2ak5kaVVlRmhrb2NPTm96MlpKTXd2Y0p4SXcrT1MzVUk0WENR?=
 =?utf-8?B?VkhxUUxPZmFvUXYrVlZXaDZpZ2dmL0ZqdlZKSmdmNDJkNTZCZ0s1eks4VDk5?=
 =?utf-8?B?SzF3T0FPSmpOeEl1cEloU1FuNUlXZi82MnAxY1VzOTNVYmZWamdiSWkvVytI?=
 =?utf-8?B?ME96WEhpNDhUSFZ5U0lXSnA2MUFFZnlIQ2hLODRJV3ZaN2daRTE1U3BqNlNS?=
 =?utf-8?B?Sk1GYi93WVd4cWlzTm9qdmNrUDY3c01MYVlFYUI1VkxDd3J2dnZlRnJjSTlJ?=
 =?utf-8?B?SXprcHJpcm4wV2c0Zjl4N2NjeER4bm5hakJMRDBnY2E1VjFxbEpLd295c3p5?=
 =?utf-8?B?OE9CK0NhVlQrV2ZTUmdkN3IxbUZOOUt6Y3RDK3FuODU2T0doZitvWVFiaTkw?=
 =?utf-8?B?bHZTd0N5b2xmNTNiNDlsQStRTFRVc01uMXlQTUJ0S1ZNWkdSQ0dGcWxtQXlm?=
 =?utf-8?B?YlRIYmkweURSMkxnZXFuTjUzb2tIRHNWL2VuTURxbk1yb2NsOVMvNWFERGx6?=
 =?utf-8?B?YmRBalpoSWpZaFptSTJ6SnE5ZzZ0ckF5UmdaS3hSUjN3VWtPaW5qZnF2ZXox?=
 =?utf-8?B?Ylk0QTR3cjFsUjBWWUdOdmdNSXB4Vnp6VTJoVFJaWkI3cmJOZ01NVFVUZUoy?=
 =?utf-8?B?ZnlJSzJ2SjNzM0FYQWdmMlE3ZDBoNUdCU1Z5MEdxYWNMdG91L3E1SVBlbXZF?=
 =?utf-8?B?Lzl3U2crVERtdVhLMW1Fa1psVjF5Yi9IY0pwU1owOGhVVkw4bUxjclpaM0tV?=
 =?utf-8?B?Z0xyT1ZGL2k2Wi9TUVhhcWluejA4Uzl1NzYwV2g3V3F1b2g2aXk3cDJuZThO?=
 =?utf-8?B?b2txOGdjZk9Bek9CN1hpelBudGN0L0RSM2IvTXVScHEvUXZ0dXRCUkJ3QmJI?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8115d952-e7eb-4eae-0808-08ddea9229a0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:32:44.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPukagqelXM9R8OGDKOgwLG6ZrAj8jWG9J+X3Xe2i03scYJyuGuIr8KnPUK3Ldl0DNvzBg30Hs5hNh8qjmVrrsuqnD7xUEw5hxl9uWdXsO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
> number of counters that can be assigned to RMID, event pairs and monitor
> bandwidth usage as long as it is assigned.
> 
> Add the functionality to allocate and assign a counter to an RMID, event
> pair in the domain. Also, add the helper rdtgroup_assign_cntrs() to assign
> counters in the group.
> 
> Log the error message "Failed to allocate counter for <event> in domain
> <id>" in /sys/fs/resctrl/info/last_cmd_status if all the counters are in
> use. Exit on the first failure when assigning counters across all the
> domains.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

