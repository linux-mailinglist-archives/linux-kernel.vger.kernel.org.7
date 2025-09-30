Return-Path: <linux-kernel+bounces-837108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A21BAB64D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDED18913F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048F2580E4;
	Tue, 30 Sep 2025 04:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBG8YR0w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4535949;
	Tue, 30 Sep 2025 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207431; cv=fail; b=Q/gxswMFeruD1fnMa+B1JxpfHksji31YNwHd8KjKHRlsfNVx7aeivzkBfjWNFv2Yf2qG7oQIB2YtL3FeHbfqWqPWLIQ7qaaV9zOiOPXsRCyF0D8gcvD3sNh4D2mwObK9TjMJ2G7pXhFMOnivfr7ljmbCtfuuE8g+mOkL7hxCQyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207431; c=relaxed/simple;
	bh=aC58c2IstUnyQfIxQucYXBvN4rpZB+lraKaCduiL6kM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hX3krDyKOECA7p1lYKMr8fYAQquJ6LyKiL5cJtuurGJBF9PS7mmH6TU7BlfoY6dbofnxCFtR65RWyd/SzgS02RneTDyrcEjD88T2zE8scF7DHR8f22PxaeWKUx0UqGWrv25INjFAoDSG1LBVB6OlSgoJwIRUFVRmMrBnDnJ7Xo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBG8YR0w; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759207430; x=1790743430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aC58c2IstUnyQfIxQucYXBvN4rpZB+lraKaCduiL6kM=;
  b=gBG8YR0w8j04KMdzjgQ9LwyKjqYt8wmNsRuizqIKtkrrF0v3LxXcNLxT
   M/2UyAku+YayukbckyNK2A8CVKX3BQRbDFjk+agIzEme2gbqec2y6LRr4
   K0SJZY3Bf7T4zbIi8QjZSo4MuuGS2wHlETFPr5aMWmLAyLiNq2k9Qq0rF
   Z0W0jJMEwrtoe+sjIO/PcOW4FTYnHLw+v93iSxZ9y9WXTgLX4jZ0NvRBg
   cabRoslxb/RedVF5Fw56FIDAIVnAYQ8pkwdB6dfmxf3wTo5yNkrhK6A02
   YYgBHLCsCMn/Gs7U0vV23iEA3aO7syS7qKmEenI+L/Xgna85CQkQQvODp
   A==;
X-CSE-ConnectionGUID: 9UJ9PBf7TUWcfsJmU+eihA==
X-CSE-MsgGUID: zGih0jvwQZqVdWbhWfEDqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60492388"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="60492388"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 21:43:49 -0700
X-CSE-ConnectionGUID: 8pNs3PimRQGw7FWeJ6+Y1w==
X-CSE-MsgGUID: lCxx6cnARYSI7Hl94whSuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="182699533"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 21:43:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 21:43:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 21:43:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 21:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzwTUXWj3iDWAE5YDx7B421yvf/U5tvPrUtvro+bQiPwcyZ7ffq//Diato9fsDAAjvkRT1lo+EqUHsbdbw6qjCF/YKk2jGb/RlAPobc7Pg6lUjWD+hVLlcBo60JKWeiHD0NNh901qXZTKspZFc32MN7MiQEE2AYHOJfTcRCOa/MabpgVPWiIP4Z3vw4iwx1P5/DpHUZ9ekdd8LbkwDP95suQTLqvE+YT9edj9kzEOX5Y9FHe8Q7/UlG4xfEZHeU0fD9E9hGw1DjgVFy0uByB6WRIE5AP3Lhqd3b8O7h1f1a77P3LNtWKjpWnKpCMGHXH7KXmRVr9Vv2mw/HyZuHFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gkYlibzCWwsNkxR1cXyx3PdOQz9SGrolw3fQK8kJGk=;
 b=jirbXKgbg2A2faUVPceuG04Lx3VSxnWsKLpnsXDqkkt3FKly2bS3vyZMGkzCYO8Ci7QMSsVuqKQq0ypoE1NYG6Q1HJCokokELTZR3B+YSQN3Yd2Sv/zimq4SQlgVMy4V2LjOZiG3sS653m8rt2p9jThH+y1Ag0X9Gutmzd8qvOdcegQVh5vIGBSa/W2nyGbAQ2cuPtjnY+uor4CFQI2ISNxYner3KvP5IfFUn2qoApUx6uDCD/zKgp1XMQb0A1sOdelHMxeUsBraBnrVpu+AoaT49SUoBt5FiXfr81OZRc1Y9vgef1FSaMrXOLZlRMQ7V6l/Zu2ufT6Mc2jXEC5OPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Tue, 30 Sep 2025 04:43:45 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:43:45 +0000
Message-ID: <541fb538-0c22-4ad2-9c6e-83ada7f2240b@intel.com>
Date: Tue, 30 Sep 2025 12:43:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>, "Luck, Tony" <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, Reinette Chatre
	<reinette.chatre@intel.com>, James Morse <james.morse@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
 <aNqUACFbXHjURWir@e133380.arm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <aNqUACFbXHjURWir@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0066.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS7PR11MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dec5e42-4925-4312-805d-08ddffdbf08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCs0UHNlNlRsTHRFU2dvMEgxK25yNVpwVnU2MVQ1QjdqWHBSemhXanRnc3cv?=
 =?utf-8?B?Q29ZMy9VME9vc0N0b3NFUEdiZlM1aGZBK01oVGpJc3JiVnZEbkV1RGlQYktK?=
 =?utf-8?B?d2N3bjlSZXpQaFBSZ0JNRkRySTNFWUhwSjRhbTZUQ0FzQlliQTk1NjJCN2N1?=
 =?utf-8?B?aWRsZFEvQXFVb2FhanJKNDFzeTFLd2xWMzhCR29VUVVFOTE0U2xRckNNWDli?=
 =?utf-8?B?RVp4UGhyL1kzWTlGc2s4WnVHZmxSRXR5TjBjaWg0d09leGY2MmJVaVlYT0pV?=
 =?utf-8?B?emR1cFA0bDJCOStLanZXRXh2R3FMOHhGU1JnNzEvUVBJODE5UlZxNnhPdmgy?=
 =?utf-8?B?Z05yVzFCeVZOSmxMQk1IZkNjUUtMMkhVeUNQUnhqKzYwYkUxb0ZSYllEZFFB?=
 =?utf-8?B?L3QvNHJpZllyZ2tZd1dIUUtYNEc1STI3elN5WkkxMTUzd1l5T3NhUXdtbWlE?=
 =?utf-8?B?QXhiM1pGTDdvazhvc1ZCdEZSWHZmMDdRRUtKNktZdDkwTnA4V1N4TGdtRTRk?=
 =?utf-8?B?WFB1TlpjZkFLc0hsZEt5V296TmlWdzU3M0xWREhmWTJtTm9rcFJHaGtGenVp?=
 =?utf-8?B?VWV0STdSNHFDbVJQWEhuY0lzQmNNSGo3STN4L3hKcm03NGtTTGEybWFzb3FS?=
 =?utf-8?B?UVE1dExrWElKU2ZYV3BrMS9oQ2dRbk02SExSYXF4Y1FLMTFPOU5URlRNVDFk?=
 =?utf-8?B?WDFFYjNYU0VtN0JTRVN0eE5UU0Y0Y0t5TTE0V1prUnlsYjBUZGt0MkcrbmJw?=
 =?utf-8?B?cDNFa2QyRlN2YnZCQzVlSmhvNEc2WVdpUHNqMlJZeDB4MXZ5V0NPVDhiZUhp?=
 =?utf-8?B?MytLZHYxalhLQ3BPck1XcmxKR0hROWdURnZhVFdKZFJOVHJlQXBnYUhCaUVv?=
 =?utf-8?B?bm5QbW5iY2U0bFBJVStqM1dZeWJ3eG1MNjZrVFE4SmpoS1Zmb2FXUXJwVGls?=
 =?utf-8?B?ZjMvUDFVeGVyRm1ucXo1R01nRHJpUS9UWk9GbG40ZTJQQ2hCdTNCaVlKazAz?=
 =?utf-8?B?VVg4M3o1VFdrRDBKQ0MzRGRlazcwKzFSNUJBQ2RsZXRZdkRmdUR4aTN3OW9B?=
 =?utf-8?B?ZEVlUGkwU01JL3lDek5vL3Q5UFVmaDdCeGkyclBtakQvRDZFU2pKMEo5UXJu?=
 =?utf-8?B?a0RQcnFMUlNRUUNEREEzOHFFOWZVMHlDREdYL1p1MDBNa2ZFaThjOEVmeEpM?=
 =?utf-8?B?QTZnZFl6QjJoV1ZUMUltOTN6cHFIbVhCMUtUV2VQVVZ5Tit5NUlZYjZ6UEp3?=
 =?utf-8?B?ZjgyVW1LYUxIdklERXhoQVIzNXlGN3VrWTY3ZHZ3aTFBL0VxUFlySWhwSnVh?=
 =?utf-8?B?OE9TeXcwckN5d1BHcGoreGQwWVNSSFl0RmJ0bmpCZ2h1QU1VM0FMWFFDdDNZ?=
 =?utf-8?B?M2d4UDdQS2Nja0IxMUp5dTdQVjJlTTdieFV4RDZCUFl2L0o2eGVxdEs4QjlK?=
 =?utf-8?B?VVcrNTVSbDd0ZFE5N1R2MW0zYXNRanFIQmN2ayt1aFJTZzRBb043NUpINHdv?=
 =?utf-8?B?cHhleS9nSTdKWUZaVVNHM2NVWEpZRVd2Y1pBdzJvNDFkWng4Q1lqbFR3bFRh?=
 =?utf-8?B?WTNxWTNPYXIyUm9oTWVLQ2VTZ3V5Q3NQdEp3ZWd5elRmaEc5SUZXTnZUM3I3?=
 =?utf-8?B?QkhEQ3lobmFrSWxScFQ0M0NwSFdxMk5BSVFsZWtnaUhtNzlGNCtodHdPaWoz?=
 =?utf-8?B?c0IrWlhGeStDazlLVGdDMkxYNFVvUTJvNWtqNm03d3pYT3VIMnFEQnVoSmxP?=
 =?utf-8?B?NkQ3UzhhTTdHZWZ3bHVLWGN2Z1BFVHZpV0FSdnEvWW5jTmQ0NmZYc21zb1Fx?=
 =?utf-8?B?bXk4bFJNVlgwNnJ5ODh4a3YwTTVCRGlwSHpham9IK1oxRE1ERXpVdXJmNVAv?=
 =?utf-8?B?TVgzUzZxTTlleGVhNVR1U3BjQTBsWCtTeVVWQ1BxOVVDRkpWNlNtSlAzR0U5?=
 =?utf-8?B?WC9WYWNFTzJDQlR5VTlqSy90Zy9aMHd5N2Z1S2pSK1plcDBHbDlGSVJNV1Zt?=
 =?utf-8?B?ZzMrakxGYnd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2hTUU0wTE1NdHkxSmJ5eVZ4RW12QmZ5NDFyLzhqU0JIYzFHUVNsclA0d1pU?=
 =?utf-8?B?YnpJajhsYlJJSHFKVjdBWW96TE1OYUhwZzE4b2pJaktQck9RMlNlemdkWmhW?=
 =?utf-8?B?RkptWWUrZ0hXSGpZcW8vdEEyUUZqQThySFJqc2xZOFBBN1ljeGdGQXdYQ2J2?=
 =?utf-8?B?aktwZ3BSNEZ3ZWNFOHE3eGlnVWY3ZHd5aDJUZHdyOG52VmFiSVMrZW9qcSs3?=
 =?utf-8?B?S3IxSm5kUGxJa1lkRTgwb050dUhEOVRBbndHNmRDaVFCUk1ZMUkvci9BUUR2?=
 =?utf-8?B?NklOSUFpbG4zb2V3bjVYQ1g3Ukg1QjdLNUZmZVlNVjZsREFwSlRERmRPK3da?=
 =?utf-8?B?bEg0d0VjanRwVG5Wc1hHWmgxV1JyVWNmcG9nU1E4cmI4aVB1YnpIVlNkUWdj?=
 =?utf-8?B?OVVsMWh4NFBhTjlUQXpHQWtZeFRMWTh0SnhMU1hsSDIzam80eE1vQTRBeUpp?=
 =?utf-8?B?RlVyUXVXa0cwRm1ZUG9EMC9OM1Uwa2ltcUN0cUpLTXJrWnRIM3VKWG95dzVX?=
 =?utf-8?B?R0hvWGNqVSt3aHI5VFpCOTNnNXBZWC9UNjlJU3F2bk9zTGtpTmRxc251bDBS?=
 =?utf-8?B?SVZwak9kWlN4LytQZTA2M2RHc2kwMkJwczAyR0xlZFk5eXJ0dzYyaFROTGlt?=
 =?utf-8?B?bFlCMHJJSFdWR3dPZU9zSUo4WVZlOTF5eTJIbjR3V1Y3S1FWOGx4Y2ZSMG9O?=
 =?utf-8?B?NUdkOVJ6Zlh2a05aVVVieTRVS003QWtHMWZWNjRSQy92OGxnN0wzRVhZZGtz?=
 =?utf-8?B?TGtvY1UxOE9VWnhvb2h5R1JKM0w5UU54cTcwaUJjbHZFR1VxMmw1LythRmND?=
 =?utf-8?B?VFZNOVZBMzBCM2wrRXhnVmlpRjlvYm1DTzMxWGZiZjEwekNYd25UTVZGN3J5?=
 =?utf-8?B?V2FmT0ZxWjVpZG9QVmhCS1VuYTl6cWd6NC9oTjh4eE41T1lWb0NxR3o4SmVk?=
 =?utf-8?B?cUJITmMwVlhpZ0FkSDczMnBiYlNFcWExNHRPZXBuNncrazB2R2g4TDBnMTY2?=
 =?utf-8?B?bElmOCtWa1dQNWZEUExmUkhVMEJlbmNFZ0h6amVwMlVlalBsZlpRTUEveG5H?=
 =?utf-8?B?amtEUDJkVW1HdWhVd2twZTZ4aHp1STlZUGpHd3luSkF3dFpUMjlCODdDVWtS?=
 =?utf-8?B?TFM1RFdlNmhPOVJUUE1HQ3FPWks0amN2K1NyTzhVVG0xMjBwekFnS1A2MkN6?=
 =?utf-8?B?Y3N1TkQyU010U0Mvd2cxVm5hcjFSeFhTNmxuWEp3bStWUUdsZ0VpUUEwL2lm?=
 =?utf-8?B?V3JWeDJ4bVdJQTZpVEtiLy9oV1NybnZHTXZJcCszdmtieFBUb2MzeFFzaUVN?=
 =?utf-8?B?ZFVPcmhTRFFCa1R5NEpUQW4ya0hDSDVDT0M1NmlwK0FKY0J3K3hGeFpMMlBm?=
 =?utf-8?B?UzBxV1FpRWFGWmlZc0t6QWxBcllSVU93Ry96OGN1eWRuVVU4aG10bEtqaWVX?=
 =?utf-8?B?SE1rM0VKU2llS2ZRempZZ0l5bGdsWlBiY1JLczZQUHFlTmswRytjMTRwVUd4?=
 =?utf-8?B?YXZXQzJPR1lsbi81QWNzMWxrb1VMbW56cmIyY1dHWFVpcDVQa3RFWXY4Tks4?=
 =?utf-8?B?SDJiL2tVWTBMZS9ZdnpGaXRDcFVENldnVzU4R1lNZFMvekdhdG1yREt0cnMx?=
 =?utf-8?B?NnZ1REhCUUhDN2h0RW1kTTJvZ08vN2NHQXB4OFlKQkwvbkZGTTQ4Rjljb0JE?=
 =?utf-8?B?aUZNUTdMSHpDTHBxbmZTejRNV2ZEcVowcmpBY2dnVzNzTDNva3RUa2JTNmtw?=
 =?utf-8?B?elJWQURIcml5LzhLTUtnUXRTWVJEMWdmOVIzZSs2bmZINklaRGowbzhmajlj?=
 =?utf-8?B?TGMyOWx3aFZQQ0hGck9ZdGJRVkdIQjhLS2JyelpWaCtvaHpVbFhwTDZkVHJI?=
 =?utf-8?B?Y004dDI4L3VMb3k4T1k0L2w5NHdrYlBRYmZjcHZEaC95WWI5bFFXS2lYYk5v?=
 =?utf-8?B?dmIzUUU5OUZYQ25UaEdEM2MyNzVCeXY2RXlXMDRDRldobjh0S3k3djlEV0Nx?=
 =?utf-8?B?U0tRQTJ5WFNRc2VTZTlWa1NLbEVneFNuVjBraSt4WnEyeVRRMEJBRHJHd1Rk?=
 =?utf-8?B?aFRWT3JTR3FlZ1hUWG5sekxzamVKZGUxeTliVVFkcExKOTFoeHl1azRGa08z?=
 =?utf-8?Q?XX8Tht1dModteksRJyAuJKq7d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dec5e42-4925-4312-805d-08ddffdbf08e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:43:45.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFHP4t5iO0Z8mSaQxLXIt5MNelo3IjyU9PPrsN9FbQNnG0/l/TxxR7H8EK6tcz84DU+j3ygXmCiJ9/nC1cT+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248
X-OriginatorOrg: intel.com

On 9/29/2025 10:13 PM, Dave Martin wrote:
> Hi there,
> 
> On Mon, Sep 29, 2025 at 05:19:32PM +0800, Chen, Yu C wrote:
>> On 9/26/2025 6:58 AM, Luck, Tony wrote:
> 
> [...]
> 
>>> Applying this to Intel upcoming region aware memory bandwidth
>>> that supports 255 steps and h/w min/max limits.
>>> We would have info files with "min = 1, max = 255" and a schemata
>>> file that looks like this to legacy apps:
>>>
>>> MB: 0=50;1=75
>>> #MB_HW: 0=128;1=191
>>> #MB_MIN: 0=128;1=191
>>> #MB_MAX: 0=128;1=191
>>>
>>> But a newer app that is aware of the extensions can write:
>>>
>>> # cat > schemata << 'EOF'
>>> MB_HW: 0=10
>>> MB_MIN: 0=10
>>> MB_MAX: 0=64
>>> EOF
>>>
>>> which then reads back as:
>>> MB: 0=4;1=75
>>> #MB_HW: 0=10;1=191
>>> #MB_MIN: 0=10;1=191
>>> #MB_MAX: 0=64;1=191
>>>
>>> with the legacy line updated with the rounded value of the MB_HW
>>> supplied by the user. 10/255 = 3.921% ... so call it "4".
>>>
>>
>> This seems to be applicable as it introduces the new interface
>> while preserving forward compatibility.
>>
>> One minor question is that, according to "Figure 6-5. MBA Optimal
>> Bandwidth Register" in the latest RDT specification, the maximum
>> value ranges from 1 to 511.
>> Additionally, this bandwidth field is located at bits 48 to 56 in
>> the MBA Optimal Bandwidth Register, and the range for
>> this segment could be 1 to 8191. Just wonder if it would be
>> possible that the current maximum value of 512 may be extended
>> in the future? Perhaps we could explore a method to query the maximum upper
>> limit from the ACPI table or register, or use CPUID to distinguish between
>> platforms rather than hardcoding it. Reinette also mentioned this in another
>> thread.
>>
>> Thanks,
>> Chenyu
>>
>>
>> [1] https://www.intel.com/content/www/us/en/content-details/851356/intel-resource-director-technology-intel-rdt-architecture-specification.html
> 
> I can't comment on the direction of travel in the RDT architecture.
> 
> I guess it would be up to the arch code whether to trust ACPI if it
> says that the maximum value of this field is > 511.  (> 65535 would be
> impossible though, since the fields would start to overlap each
> other...)
> 
> Would anything break in the interface proposed here, if the maximum
> value is larger than 511?  (I'm hoping not.  For MPAM, the bandwidth
> controls can have up to 16 bits and the size can be probed though MMIO
> registers.
> 

I overlooked this bit width. It should not exceed 511 according to the
RDT spec. Previously, I was just wondering how to calculate the legacy
MB percentage in Tony's example. If we want to keep consistency - if
the user provides a value of 10, what is the denominator: Is it 255,
511, or something queried from ACPI.

MB: 0=4;1=75           <--- 10/255
#MB_HW: 0=10;1=191
#MB_MIN: 0=10;1=191
#MB_MAX: 0=64;1=191

or

MB: 0=1;1=75          <--- 10/511
#MB_HW: 0=10;1=191
#MB_MIN: 0=10;1=191
#MB_MAX: 0=64;1=191

thanks,
Chenyu

> I don't think we've seen MPAM hardware that comes close to 16 bits for
> now, though.
> 
> Cheers
> ---Dave

