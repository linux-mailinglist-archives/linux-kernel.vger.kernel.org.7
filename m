Return-Path: <linux-kernel+bounces-784030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F7AB335BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33721200E75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155122566E9;
	Mon, 25 Aug 2025 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DG2WzwNR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6F14F70
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756098542; cv=fail; b=hiVhYMia6PH/xNdMBRJhrcArhuEc+a1NtHJFEeCU3jBSPfjzOikuy0GlNhzED0i0xJUSOJGlr6L341WGut8KttrpIXcUyljrCKN36EPToLMxrUs4Mz7aBu29TJa9tYwNpfMfNVWDXhC2OFzJTLMBlRPtcDdXONC0orbCDDnd3Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756098542; c=relaxed/simple;
	bh=P5U4vMQTxUnpBoUB/x77Jb9B2GFfmrehCbba1pkr3VQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NtHctQSex7JzsJkUUVQ3zkBh7gOiF4AeYQ6vYA6IF21rENIzCt23ps2qVkgePW7cIe4lPKFYxvsxlkf3pVPA5xbIwCQIvXMBHh/6CJrage7Fnvu+ozr67EEJtVqrKfaV3X05RGyO1FUMp4whhZWNKV/GUiLVxyDoriqwAKpsZag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DG2WzwNR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756098541; x=1787634541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P5U4vMQTxUnpBoUB/x77Jb9B2GFfmrehCbba1pkr3VQ=;
  b=DG2WzwNRP3+neCnMUkFAOW/U8osrasDN5kmX7ZVBzzPdrZoF73BWfqoX
   46P2CVfqHW0/Ad3TTS6MvBLZGkLelW12gBNHJqhGVcnhAoYJu1rMo7Kav
   51Qf/9x1Jimbs7SJSwEayGPjg6IOanW1C/yDX5rm/11gkBuplcAMBos/4
   b4F6XKRtQveUufW+ZmbbHAczQkx6P4W20nVig2hA7sxzfob/639+vMX3d
   rzbPAJkR0ACUWYJtExRFrRLiS20ashGu74Ik71AmuHFWpyQot1/KLv2z6
   U0CgQX1LswUiPuxr2q4HeaDoBecVd8H2W18gmUMz61kEvUQ2oK8DfAhVw
   w==;
X-CSE-ConnectionGUID: yPVOwdS7T3izFFlrEl3Xxw==
X-CSE-MsgGUID: XoNOX9cMSBSIisW2e3bz1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="68572458"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68572458"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 22:09:00 -0700
X-CSE-ConnectionGUID: WK5hPAWvR22JomeqffSrGA==
X-CSE-MsgGUID: ul5sBFOsSQO24IGDuMo+Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169099939"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 22:09:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 22:08:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 24 Aug 2025 22:08:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 22:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi9+ADVYiL6MRUiS5ApL9A38+046J1CExaJU9dEuW+CVhsHeRF+Z6gu6XGi+B583L6AN6G/n2R75leDtuJQGqud+3dobBpajInfrlvHXsp11dcedeIwla+lCuOlVfa8SXURt+YyJUNLcQKdkobZdzoZfavk5YeCiCyWeYsgl9qfoOuQ+f4XMcb+ULHQX7pgT8YcqaezgWVJoSwWES2VHTWHF/kp4ksQ0W0h07S4Pc1LRLIEKKyzXU8R/lxDS+PGuoU9qdcFpxrxikjd1yPNh5cdrEUrXc+K9lK5GoQt1NdWGMG+6qJucvDlkdvSHc+aZJWCyHzEj6NTbl9KxhhKF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJgDVCyCG2gFPmAb6F//C5SeQhYF7opvTQN3xe5ARVA=;
 b=PfLBTzwtnpuk6MMEorkX3uJ0XNrUBVmdizofDapH7Hq0RFhU7PK843XUjYvvGhOV2uaWIEEpwZ3fAQvOty5bT5gtjFD82KqeLPiN86Zb/y/BU9LxBz1AHYJoRrmUIqspDwsfxqAv9QGkpVbB5l2kqi9P9gPiMLAYMGeuwaYo4i5CH5SC/RuxW+HZKTH3qLs3OFSPUnCWkIfQSbt7SukeCSVHkplwc7kPmh7kwUcL5nuIs4Q0Dg4E6wgfTZiLum5FdSTdCipFau5Sk8ykREmi/puTrX7+/2OCzcSEcE7dYX79DPNzolcq87AA0LkHxRmP49OOk/riFe0KCvAu/JQXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Mon, 25 Aug 2025 05:08:51 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 05:08:51 +0000
Message-ID: <c03c0137-931f-4dc9-b2c6-d01d4eb60010@intel.com>
Date: Mon, 25 Aug 2025 13:08:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched: Fix sched domain build error for GNR-X, CWF-X
 in SNC-3 mode
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Zhao Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Chen Yu <yu.chen.surf@foxmail.com>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
 <86ddfe75510497829a84e696b29bfdd7a4940009.1755893468.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <86ddfe75510497829a84e696b29bfdd7a4940009.1755893468.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0138.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: c861b4ab-70fc-4216-2f05-08dde3957b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEM5VWc5TTZqV3N5dEtCbit1R25ISitucnY5UHRpMjRteXlkbExxeTI0QWoz?=
 =?utf-8?B?VlNIV0FZUENlclFlR3BiWjl0U2ZaZ0pVeTBXZ0V3dzhFdG1hT0RXd2plakFK?=
 =?utf-8?B?RUVPSlJ0ZXZnL2RYKzlHaUpaN3hIYzExa3RCQ2Y0WDRqeUt4YitjS2FoYTc0?=
 =?utf-8?B?VFF6MnJqWk0vZHVYdDVZbng2cExXM2QxRU9kekVWd3pNZ1FlcGVhMHl4aDNH?=
 =?utf-8?B?NDJnVndSdU5FZm1GSTBDSzJoL09JZzJUMVpENDBSbjZxWFJERWFHZzVxQzhk?=
 =?utf-8?B?RXptMXZNMkYrQUU0Y1VBZ1NsVkp5bFR2VUpJOW55ODhWUUdjQzdPRFMvZEMy?=
 =?utf-8?B?VkU0WmhHYXBpUlFKZ2JmUVkwb2JzYVAxdG4wdWtDK1dQYmJhOUVnaHo1NC8r?=
 =?utf-8?B?UVlObGZCNjZESHpNYnMzc2N1L0Q1bTBBWDlKY0s0UGpUeWovMm9EdDFBYWVR?=
 =?utf-8?B?QzlWbVV4SkptdlR6a0RIZW5VNkRER2t0NzJKakxZSVJKakhjRDY1bWRYcWxG?=
 =?utf-8?B?UXNaeERJcEFtajBsZ3pUQ0xDTzZXREdObEdGMmFPRjVYeDAxYmhOM1NiNmE2?=
 =?utf-8?B?VU82bVJSdFpHMk9JL09OUC9BQVJmN0V2RkFjSTZaM3EvM2k5MURWU0RVRnZQ?=
 =?utf-8?B?VlgxZTQ4TERvTzJ2VWZlNjdnVnhGRHJMeVhiVTdKdThCNC9zY0NPVHEvY3NJ?=
 =?utf-8?B?SEU1cUFHcnMvdUF4NzRpOEpYVDFWdk9kbjcrZ2pzaTZtNm03M3RpN2N1WWMz?=
 =?utf-8?B?TURxNURXUitadkNwdklPYzJNdEZWdkJJZVlYMzh1T1dabkh2T2J2T1kyTTVM?=
 =?utf-8?B?THhMWTJTQWg0cW9YN2ZMZ1l2d1dqamExZnJnMU5LbS90Vlhld2VvelRNazM5?=
 =?utf-8?B?MDVvRGUvT0RlSTB2MldvVEdzYVVSeFRYQk85R2hwTVNUVExKazYwTnhGR2or?=
 =?utf-8?B?cFdXN1lYOG0zVFZxanR3VDJXWldPOVdSZVB0WHM2dG9PUjFNZHR2b3I3QXFZ?=
 =?utf-8?B?R25KUWUxa29kUS9WTWZwcXFXbkdScFhDNXpMR25VNlhtRkR0eWJaS3ZnMS9x?=
 =?utf-8?B?NnlUU3dlUUMwRTBXNHNGRlg4bGQ1KzNKNVdaRitSUkMwdG9iQzNSSWROYzJ5?=
 =?utf-8?B?NXlVWC9hWk90TEcxQTlGczhSQW14emFtTGx3bzBGM3VtQ2x3VmFGakR1ZnpH?=
 =?utf-8?B?TnMwdzZReWRITGQyMERDSHhQSzFCTUwxZnVHRVRlQloyKzAwVlFHN2ltWVkz?=
 =?utf-8?B?QVpQcDZFWHdVK2ZNWWRSRzRJQkR0VFZhSUlwZnFDL05pR3FwVTJ0YzNxM1cy?=
 =?utf-8?B?Z0pZc3Y3enhtMW5MNXRpM2gvQXA0Sm0wRVlTcTI5ZWFySEpFTU1nSFBFUFNj?=
 =?utf-8?B?S3lDNG1QNkVFWDhja2pVNTJDeGhCdjE0RjdpREpmK1dueVZpeUJlREx0UmxI?=
 =?utf-8?B?UmpBbW5sblF6NWtleEJ2NEJwcms1ZWhORDdSUmNqbE9pc3dVREU2emJhS2pl?=
 =?utf-8?B?VkVVZnN6ZTRITTZadWUreG9UUVE0OFYyN3BhTFBvZFNKMEROMHhpdFZYbHJ1?=
 =?utf-8?B?amJuYkkxbGdYaXlDczZic2RHbFBoaW02U0JQb0QxY2xZRDFxdXEvTEVqbkNB?=
 =?utf-8?B?RkJuOEk0MWk2UTcrWDhQc1ByMW9oYS9LZVRjclR0ZHIxdEJTWVFkTXpud2pW?=
 =?utf-8?B?OGlvREFZZExWYUdIMjFFQlZsTHdJTDVsaVNBaDZFTjFBUWNaVW43QWtMMURV?=
 =?utf-8?B?MWRwRWlzV1BPaVNya0cvUmxYVWF0YUl6S2lURm90bHphYWtEempBL1lLL0Vi?=
 =?utf-8?B?UWp3dXJMNjdibWRCZnZuYmFoeHBreWFhM0xaVUJnVG1ER25pSGFuZkRUbDE3?=
 =?utf-8?B?ZVlEYWVLNDdLNm5oSVlyMTY5RVA0Q1RzSTA1SExwQXpaUEk0VktWUy95NVlM?=
 =?utf-8?Q?i1fCdamATGA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NC9BRlFEaUNuSmRrQjdCNnNaamwrcWRpQXYxMVo3VHJEY0hneEVaQ2FmWU0v?=
 =?utf-8?B?OVdEMTA3SE1qN0JLUlhOQ2I0cXVkcXVqN0pVYngzODVvOGdWeHhEcmQycXlk?=
 =?utf-8?B?cnNDQVg2MGZKdDA4TjVpeDA0M2l1eEprREg1dW1TZkhlbll5QytlcjVndE5D?=
 =?utf-8?B?R2VLTm52MC8vbTNTTjBNa2ZsVGZVZSt6TU1HM2VhYzhKZCswQWlFcWxIc2lt?=
 =?utf-8?B?R0lWem1XdXowc09xa0R4QzJiclpRVDRkZnlnMWJQNzhFbU42b0w2UlN6RWhY?=
 =?utf-8?B?MmxOZHZzMEV2UU9XSVNBR2k2Mit6cUJodkFWK0l3TWhEOWJETU9TS2ZoalVy?=
 =?utf-8?B?MjFOUDhQekZLVFN5RzBSRVlqRUZRUy9NZlo2TTJwR3M1bzh3TXF4UFZGYmZq?=
 =?utf-8?B?d2ZrakVQMWgzU0prSkJ1Y053U0d3VHFKYlI3S1cvb3dOL1JkVW1wNWVBc3Q3?=
 =?utf-8?B?M3RhNVJvdDQwNkVSV2V3amhaQXE4M0ppUzVITGlaSU0vanB0ekZJekdTRFpr?=
 =?utf-8?B?WE9Ec0phdWhFWlNKUWZQZE5JRG9UdzB5SjU1MjVjMGZjRndnV0F3YTNaYTR2?=
 =?utf-8?B?YjZwUWxjcmhJWmpEL3dEUTdSbW45QWsyTVFUazVYY05hV2xXdy9KUXpiUmFM?=
 =?utf-8?B?QU92dkFVYS91YlBUbWlhd1dBQm91NDBpYmJpdHFoQ0hXb0sva28wM21HcnVP?=
 =?utf-8?B?d0xDTlJpUE0rVys5N1VBbkZKS09SN0psYTZFRnIzNEFrbml3S241ZjdTcHZj?=
 =?utf-8?B?eDdEdlFKSHN3SHNTQ05pTlZWSGlNTjZmYmNjUzVtOUhLNzNWMndiUUdGNWhY?=
 =?utf-8?B?RUN5LzJNK2Z4T0dZOFdLYzYrZDI1b2VvVVNabzNkRmhSL1N2RlgvOWxHcGxp?=
 =?utf-8?B?dHVzbVdsMGJUZ2NYUy8rZEpVYXZVcWdKSE1XRUFYL2huam9DWjhIaHRJNm41?=
 =?utf-8?B?NGVOanZxT1k2M0VNQmE5cmlRZFIwY1FXOGMyeHJYYkFZTGlvV1BCWC9COHY3?=
 =?utf-8?B?RVJBc3VDMWJSbmFSOWE0cDAwVXF3N09NVzFQM0ltTDlrT3Z6RkxOck52ZWhH?=
 =?utf-8?B?aDNjLytEUUFTeEJBTzhvd1RTdlhTbDdaMUoycEEvSmR5bjZNVTIrSmRndGtS?=
 =?utf-8?B?eVZXUUZZRlVZS3I2RTRrSVdVQmNuRWRqR295U2ZBU0xiSWJ1S0JxbFY2d05M?=
 =?utf-8?B?bGc0MXhnVVJqb3VUZ1FFR0hDNnRFOEwzRmQxaktudTVVWllJQ1lVeEQ0TjQy?=
 =?utf-8?B?Mk00TjhscllKbjJFRVo2cWRHZDd0THhrcmRocUU0MEdZTVJsOWlzWVlMYnBI?=
 =?utf-8?B?dDJkMXYwWkpDbExVMFlLZ3o5b1ZWRVFVa1BZT2JTelI0YUFWdG5sTWNVejlW?=
 =?utf-8?B?d05PanlKRFJRL2dzaDhYYlhtZnA1ZklrTHVnbHpMMWU4L1VCVDI1TWtCNU5T?=
 =?utf-8?B?dE5ISkZqREgrWCtjdlhnRHJLNjBiUDV2QXF2ZUZZcS9nVnhxV2ZxckMyTTMw?=
 =?utf-8?B?ZEZsR0xPeWlBaUlGZWlFanlRcmtrbFBOQStUQ3JzL1dpTFVocWd4U2Z1dmlr?=
 =?utf-8?B?LzI5OEVSTUhianN5MmlEdW9mano4Z1lZZlBXdEJpNTNRdEZjeERyQkxKZkRq?=
 =?utf-8?B?SzF3SmhmNkJMRi8vTWdZejZUenBzaWdsUFU3QnYyYklaNjgrelg4dUFJakhQ?=
 =?utf-8?B?czlqb3lEWXQrN3B2cUhmaXBHVnhFSDRJREpaRm1mYWpjQS9NaldrckIxSSs0?=
 =?utf-8?B?SXBTenJXVUYvM2s5cHFpelNsNzlDdXViSXFMemw2Yy80NU5SclM1UWE5eWMr?=
 =?utf-8?B?cEp0NjEvV2Z0MWtoMTNpQU03U3hTYm04ZGhuVkZyaEMvZnBpNGdFb2xnb3BJ?=
 =?utf-8?B?aEJza2t4RjN6LzJxMVZIajFqRVFvSnA5VTJBMWc5STl0aUsrUVNiNzdheG1p?=
 =?utf-8?B?NkNhT0UwemVnSnUzMEN0MmErWkdOYWh4aG1iUzNVYWh3L0ErZUNaK212Ymky?=
 =?utf-8?B?alA1TllrNVpYNFh5VGtyN1dQcWJ3UG1NektKdGtSMFRHMmZqVGhOb0ZHTWJU?=
 =?utf-8?B?TzBBdDA4aTl3QkpXRGdOakw2UjZpMHFLcVdpS2p4TGIyem56TGo3ZFpicWpB?=
 =?utf-8?Q?N7hzkVGI+sXT7m7hI5Uih3jcB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c861b4ab-70fc-4216-2f05-08dde3957b12
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 05:08:51.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Umwn/lwYGnjpx/ifEZi+XrlJ1kcaTJOkTAsfjsguZMdqR9KZDIqNInrDxBjFm3vcvc2jqXlKovG7++HaA6h+pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-OriginatorOrg: intel.com

On 8/23/2025 4:14 AM, Tim Chen wrote:
> It is possible for Granite Rapids X (GNR) and Clearwater Forest X
> (CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
> is enabled, each die will become a separate NUMA node in the package
> with different distances between dies within the same package.
> 
> For example, on GNR-X, we see the following numa distances for a 2 socket
> system with 3 dies per socket:
> 
>          package 1       package2
>              ----------------
>              |               |
>          ---------       ---------
>          |   0   |       |   3   |
>          ---------       ---------
>              |               |
>          ---------       ---------
>          |   1   |       |   4   |
>          ---------       ---------
>              |               |
>          ---------       ---------
>          |   2   |       |   5   |
>          ---------       ---------
>              |               |
>              ----------------
> 
> node distances:
> node     0    1    2    3    4    5
>     0:   10   15   17   21   28   26
>     1:   15   10   15   23   26   23
>     2:   17   15   10   26   23   21
>     3:   21   28   26   10   15   17
>     4:   23   26   23   15   10   15
>     5:   26   23   21   17   15   10
> 
> The node distances above led to 2 problems:
> 
> 1. Asymmetric routes taken between nodes in different packages led to
> asymmetric scheduler domain perspective depending on which node you
> are on.  Current scheduler code failed to build domains properly with
> asymmetric distances.
> 
> 2. Multiple remote distances to respective tiles on remote package create
> too many levels of domain hierarchies grouping different nodes between
> remote packages.
> 
> For example, the above GNR-X topology lead to NUMA domains below:
> 
> Sched domains from the perspective of a CPU in node 0, where the number
> in bracket represent node number.
> 
> NUMA-level 1	[0,1] [2]
> NUMA-level 2	[0,1,2] [3]
> NUMA-level 3	[0,1,2,3] [5]
> NUMA-level 4	[0,1,2,3,5] [4]
> 
> Sched domains from the perspective of a CPU in node 4
> NUMA-level 1	[4] [3,5]
> NUMA-level 2	[3,4,5] [0,2]
> NUMA-level 3	[0,2,3,4,5] [1]
> 
> Scheduler group peers for load balancing from the perspective of CPU 0
> and 4 are different.  Improper task could be chosen for load balancing
> between groups such as [0,2,3,4,5] [1].  Ideally you should choose nodes
> in 0 or 2 that are in same package as node 1 first.  But instead tasks
> in the remote package node 3, 4, 5 could be chosen with an equal chance
> and could lead to excessive remote package migrations and imbalance of
> load between packages.  We should not group partial remote nodes and
> local nodes together.
> 
> Simplify the remote distances for CWF-X and GNR-X for the purpose of
> sched domains building, which maintains symmetry and leads to a more
> reasonable load balance hierarchy.
> 
> The sched domains from the perspective of a CPU in node 0 NUMA-level 1
> is now
> NUMA-level 1	[0,1] [2]
> NUMA-level 2	[0,1,2] [3,4,5]
> 
> The sched domains from the perspective of a CPU in node 4 NUMA-level 1
> is now
> NUMA-level 1	[4] [3,5]
> NUMA-level 2	[3,4,5] [0,1,2]
> 
> We have the same balancing perspective from node 0 or node 4.  Loads are
> now balanced equally between packages.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   arch/x86/kernel/smpboot.c      | 28 ++++++++++++++++++++++++++++
>   include/linux/sched/topology.h |  1 +
>   kernel/sched/topology.c        | 25 +++++++++++++++++++------
>   3 files changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 33e166f6ab12..c425e84c88b5 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -515,6 +515,34 @@ static void __init build_sched_topology(void)
>   	set_sched_topology(topology);
>   }
>   
> +int sched_node_distance(int from, int to)
> +{
> +	int d = node_distance(from, to);
> +
> +	if (!x86_has_numa_in_package)
> +		return d;
> +
> +	switch (boot_cpu_data.x86_vfm) {
> +	case INTEL_GRANITERAPIDS_X:
> +	case INTEL_ATOM_DARKMONT_X:
> +		if (d < REMOTE_DISTANCE)
> +			return d;
> +
> +		/*
> +		 * Trim finer distance tuning for nodes in remote package
> +		 * for the purpose of building sched domains.
> +		 * Put NUMA nodes in each remote package in a single sched group.
> +		 * Simplify NUMA domains and avoid extra NUMA levels including different
> +		 * NUMA nodes in remote packages.
> +		 *
> +		 * GNR-x and CWF-X has GLUELESS-MESH topology with SNC
> +		 * turned on.
> +		 */
> +		d = (d / 10) * 10;

Does the '10' here mean that, the distance of the hierarchy socket
is 10 from SLIT table? For example, from a socket0 point of view,
the distance of socket1 to socket0 is within [20, 29), the distance
of socket2 to socket0 is [30,39), and so on. If this is the case,
maybe add a comment above for future reference.

> +	}
> +	return d;
> +}
> +
>   void set_cpu_sibling_map(int cpu)
>   {
>   	bool has_smt = __max_threads_per_core > 1;
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 5263746b63e8..3b62226394af 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -59,6 +59,7 @@ static inline int cpu_numa_flags(void)
>   #endif
>   
>   extern int arch_asym_cpu_priority(int cpu);
> +extern int sched_node_distance(int from, int to);
>   
>   struct sched_domain_attr {
>   	int relax_domain_level;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9a7ac67e3d63..3f485da994a7 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1804,7 +1804,7 @@ bool find_numa_distance(int distance)
>   	bool found = false;
>   	int i, *distances;
>   
> -	if (distance == node_distance(0, 0))
> +	if (distance == sched_node_distance(0, 0))
>   		return true;
>

If I understand correct, this patch is trying to fix the sched
domain issue during load balancing, and NUMA balance logic
should not be changed because NUMA balancing is not based on
sched domain?

That is to say, since the find_numa_distance() is only used by
NUMA balance, should we keep find_numa_distance() to still use
node_distance()?

>   	rcu_read_lock();
> @@ -1887,6 +1887,15 @@ static void init_numa_topology_type(int offline_node)
>   
>   #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
>   
> +/*
> + * Architecture could simplify NUMA distance, to avoid
> + * creating too many NUMA levels when SNC is turned on.
> + */
> +int __weak sched_node_distance(int from, int to)
> +{
> +	return node_distance(from, to);
> +}
> +
>   void sched_init_numa(int offline_node)
>   {
>   	struct sched_domain_topology_level *tl;
> @@ -1894,6 +1903,7 @@ void sched_init_numa(int offline_node)
>   	int nr_levels = 0;
>   	int i, j;
>   	int *distances;
> +	int max_dist = 0;
>   	struct cpumask ***masks;
>   
>   	/*
> @@ -1907,7 +1917,10 @@ void sched_init_numa(int offline_node)
>   	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
>   	for_each_cpu_node_but(i, offline_node) {
>   		for_each_cpu_node_but(j, offline_node) {
> -			int distance = node_distance(i, j);
> +			int distance = sched_node_distance(i, j);
> +
> +			if (node_distance(i,j) > max_dist)
> +				max_dist = node_distance(i,j);
>   
>   			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
>   				sched_numa_warn("Invalid distance value range");
> @@ -1979,10 +1992,10 @@ void sched_init_numa(int offline_node)
>   			masks[i][j] = mask;
>   
>   			for_each_cpu_node_but(k, offline_node) {
> -				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
> +				if (sched_debug() && (sched_node_distance(j, k) != sched_node_distance(k, j)))
>   					sched_numa_warn("Node-distance not symmetric");
>   
> -				if (node_distance(j, k) > sched_domains_numa_distance[i])
> +				if (sched_node_distance(j, k) > sched_domains_numa_distance[i])
>   					continue;
>   
>   				cpumask_or(mask, mask, cpumask_of_node(k));
> @@ -2022,7 +2035,7 @@ void sched_init_numa(int offline_node)
>   	sched_domain_topology = tl;
>   
>   	sched_domains_numa_levels = nr_levels;
> -	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
> +	WRITE_ONCE(sched_max_numa_distance, max_dist);

Above change is to use the original node_distance() rather than
sched_node_distance() for sched_max_numa_distance, and
sched_max_numa_distance is only used by NUMA balance to figure out
the NUMA topology type as well as scaling the NUMA fault statistics
for remote Nodes.

So I think we might want to keep it align by using node_distance()
in find_numa_distance().

thanks,
Chenyu
>   
>   	init_numa_topology_type(offline_node);
>   }
> @@ -2092,7 +2105,7 @@ void sched_domains_numa_masks_set(unsigned int cpu)
>   				continue;
>   
>   			/* Set ourselves in the remote node's masks */
> -			if (node_distance(j, node) <= sched_domains_numa_distance[i])
> +			if (sched_node_distance(j, node) <= sched_domains_numa_distance[i])
>   				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
>   		}
>   	}

