Return-Path: <linux-kernel+bounces-856524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACAEBE462D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 602224F213A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D734F483;
	Thu, 16 Oct 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVmtgv9Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6734DCD2;
	Thu, 16 Oct 2025 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630304; cv=fail; b=AY7jM3TWfV8es3v/jM6p2y6UnOkvmWDcqo4jk4GViH1727+rkf9pQgYgC5cE8i1DzbVnywP+idxhPCvRLCZhsJ5ZZDavtf/7LK10brmxEmZf9xpLflawd2g7Znxt90uvtL9CVfctq+GmUVmohEh2nU+yoktQkAeiwsJYa7i5Nw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630304; c=relaxed/simple;
	bh=a6cLyQb807BOJJR59OAIlTARMRQTexBH6f1L1IP17/c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N27JkJkkhfalSX07IHHZOOeAoBdhqbE3RdSC0U6sO1sexkW3fy6S6yQN/z4o1a9BcAxpwmiW7f+ULR8CYm0eBwexylKx+AIJl1lLqEu+CwYDGtBVoEPyDu01aNavt6bDO4dP2lQoilJ1KaHk8Rana8hcBssbuOByjYG3MiEmJ9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVmtgv9Z; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760630303; x=1792166303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a6cLyQb807BOJJR59OAIlTARMRQTexBH6f1L1IP17/c=;
  b=XVmtgv9Z7/smqvtpAbsbEZy/3TZ7oRb2e8i8lRhDZMdV9jxBJezr1pZx
   xnqebk8XXRY2MYpZWcMlu3203C5Xzt2QCWMtitbVYqR3uDQGjSoFgjQfT
   6LToSQMAtm0HEYzksorL9gCqnspOVS3qqByti3CBiW5+tVw8lyxOLGGkJ
   wwY2cyoR2e8Kq00XrXvEXMBImb4axtsV8pp9a744biCXbgrsvXkL09zcg
   geOF9euivFdus4Hr91flMZklYmnnvYDNtsl304MNBJtbAsCwZMmXINabp
   +eHR32MhA+xZFnzD2QGEaG28FUJrHhk0/8kdnW4AyTfLWBNzXrWlBHCO9
   Q==;
X-CSE-ConnectionGUID: Zm0N44YnS8+yoE9AMmBgLw==
X-CSE-MsgGUID: rKymwobPR5isn8s8zXR9lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66662356"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66662356"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:58:09 -0700
X-CSE-ConnectionGUID: 3r48oQu0SOi0EKQ1n0mL8Q==
X-CSE-MsgGUID: fYbeQfEtRoGJBbbdxDaFng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182281094"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:58:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 08:58:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 08:58:07 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 08:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JibWNDQn/2/oASwvzqIy8TC4iypl01OR8dtO8YIJzRvdy+FTmCueAhNepMcpmttJ3qetBFIxTTqzs5i5ykA2Eiml30V5oCveLEz/Swq4Ftv7fWnxeJhp861FRcUL8ZPIVRb4arjhAg1BKwsCi9YbhbJjx8hTNe7tNfydf/TlXemO5jJoVIviSSirCcelG6/IiJyg/p3Pa7I4kMLQFLVXUTgdyHWfezsSbDvXR94Frs/SMspqHxannZkUFut1ulQqphyILOY5uYv1IeOQqFtwsqW96nbN1Wjl76bdDuuWCj+AdUhVBKVx0l8YyzY0RKd1MF3SdQC12G5ZL3/o8NgLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZWX2MU/LesibZTlnqfdrgL83MBjTwmbtVHzbtoRomA=;
 b=wpeFV+gDPXZel0pCO675nwRixD62j/FGabxixT9hHfqNGaIxYyb0P3PtNdcrljXKF4ibL0J5sil3HcNiJZlRsqw8+i2V6jwV/FDdE8Kj6lIZPfnytIUeLYHmxq7CNvmXLzVYEcE9YGWoyCn60B05EWsVs/LFZ7kzXaQaltfNQnWKMZbAn5Z5Yu8lMrp1rp6yeAtvmsczTVhEu0ip4u7j/TX2wSY/VEkzC3qqvDyaMaioI40iLjJVzjKA0ua+ZZ74jK81cpOk/Jrc4Wk//JCKvO6C2Ge2Zu1gEyi6O4eJ42Yoze2MPkFNMMWDtAWPAhNQo28YASGnfOApQSBA4DJHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH3PPF066A3CD44.namprd11.prod.outlook.com (2603:10b6:518:1::d07) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:58:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 15:58:02 +0000
Message-ID: <1493d341-16a5-47e9-a834-cd8133b91fed@intel.com>
Date: Thu, 16 Oct 2025 08:57:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com> <aO+7MeSMV29VdbQs@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aO+7MeSMV29VdbQs@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH3PPF066A3CD44:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2219f4-dfcc-4319-5d40-08de0cccc94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cThPRkJrem9CUkI5OG1NM1ZuUk5ZbFduQUJZVkdLTGpRVWRsS2I3M0xnRTBu?=
 =?utf-8?B?akoxQTdkcjBQV3JSL2h6dm5vekMwUFBQQkdmaEwrMXBZQzV0THgxTWJsUS85?=
 =?utf-8?B?WDg4dzF5czRCVzFkY01zQWU2aWRvMGlwYzhjalFhVUt2K0Q0bk5YdWh1T210?=
 =?utf-8?B?aGRSeC9YTDFlWEZuZHRYb0hPY0lBbnE2dzV0K25hQjdJZlFIOGhJb1U1MVRw?=
 =?utf-8?B?dFBRZW5hZXV6bnRvMlpIMWwzNkZJKzhIQzBGNWl3TExwcVZJWFBvckxsc3J6?=
 =?utf-8?B?d3IyUHJ6TU5DZmxacjlvbXRnOURTd3M1bTZYR1NYTGF6MHBoQnErRkdLYTFa?=
 =?utf-8?B?em1va1BBU2R2MitvR29QZ3FUODFLbUtOYW9uc2VqQ2hpRFVoT2tLNTNZRy9m?=
 =?utf-8?B?OEVIY0cyKzFmMEtRaVJTTGNNVkIwTk9vc25OUWJ0SDlBdm9xdmlZa3RRYWhr?=
 =?utf-8?B?UHRmTDJ2ZnRWdnpHem9NQ0kxMzZKWmhRZjBCb1ZiazFIUThFRUs3MklvLzht?=
 =?utf-8?B?RnQ1RXdGOUVkUWpXeGhwRFdwYWZObTVya3FBalM1ci9FYmhWV0huRW9HaDFK?=
 =?utf-8?B?bVc1c2tVL210c3BmUG1mK1A2QnV6TVE5aURmeW5xUHJZWDNic2ZyamRTN1Zk?=
 =?utf-8?B?MTBybkVzdUlzam9rcFdickJxenVHazg2eDhoL0RJbkVTNXRTajJ2bjU1Sk5q?=
 =?utf-8?B?YzNVVngwdEpnWGRTL2pWWm5zZnhVZVFxUU54T2tpY0lTeGMwcmJ6UXc3cXd0?=
 =?utf-8?B?WGU0UXAxTnhrUHZYVklST0FHTjhmTjRINVhrbGVBVlVydXZQZ1Z0bzV4SWtO?=
 =?utf-8?B?RXhwWUc5QVAxOEtNZ1lwOUZKRVlyaEZqODVSN2s5ZlRzc1NVN2NOakpwaTY0?=
 =?utf-8?B?QVpxWm1IN3hTdTBhVmttd0xOU1Y5VTNRc3ExVmZCc0RhNnZIdnE5R1FHWVI2?=
 =?utf-8?B?MDhRVjkxbHZ5a2liT0pmWW1CZVo1WkNxWkY1YnczdmVwVmNmbEhpMHdISDVo?=
 =?utf-8?B?bmUrQ1V1dFpodklWb3RKaEEvQjJkSXl2YjlGTGQxNmRzMDNzanFMZGZrNGM5?=
 =?utf-8?B?S0I1ZVVGb3k5dnM5SGFaYjB6Mmp0dTJBM3FkZ2o2MzM0RS9VNkFkaDliYy83?=
 =?utf-8?B?NE5RTjUrdVVQY2VxTDhacDJlU2lSbXgwMU9TVHgxMmxCSVI2WGJsRHRmRHNU?=
 =?utf-8?B?aWJKanlZRE53TnVPNXVhMmk4MU1GUUJpZmRDbzFzLzZkejJyK0hsT3lOZkNy?=
 =?utf-8?B?WktCSHdlU2JETEZ1WEQreXViSEJBa0tpbytFZ3E3SEtibGR2TzA0R3hFbFBq?=
 =?utf-8?B?eUMwTzVHU1BrMVNITjdHNWF6U0g0aWxVOW1MVzI2WTJ1M2RxTkdmTXg3NGJ3?=
 =?utf-8?B?bUJLRERoMEFTT0hEblF0SWpvaFhPTklkdjlFb2JJVGVOTDk4MEx1MDVLa1Br?=
 =?utf-8?B?QlhGMHF6Nkt6NGIvRTVHQlZSZDhJaUF3eEllY1dwUjd0c3pja05IbDZSUjJB?=
 =?utf-8?B?WE5FdDZWeWhxRmR2VG1pdzQ2cnAzdE1uQ0tPM05rMmxyaFVFaUg4cnpDQVY2?=
 =?utf-8?B?RW9jLzhTRlI4Ym1adHd2MjVza2NDTmxWanFZYkZWRVRTN3JjYXVEVFlBRWVJ?=
 =?utf-8?B?OWxYYTUvQ05TYTQ0TGg3S3RyTWs0YmxER2ZXWlJLdjVyRk9QdnRESUdTaFM5?=
 =?utf-8?B?VjM3QjBlWHhuL00vdERzRW4yYm85d0RyYXFJV3BZTHJ2WWt0eXdzRXYxMVF4?=
 =?utf-8?B?NzdQeWYxNUlCSVdlVFFKV1M1Yk9HVitiQnErME9nMGNVMmVqYnVtcjhWQ0Vy?=
 =?utf-8?B?Ym43cGNFMjlpRXRQQnVnMWNVdWszbkFrdXdmUE1rUUNZUzZIUVd2QVJEYnVq?=
 =?utf-8?B?R3hPdjd1VE13OHdBRXQwWTZHSzk0RktmRkdGTEVBTzh6QVl0RHhMS2FMOU5T?=
 =?utf-8?Q?s9lWKtCFBy/fs+gSBJnRBvxC+owwXyCp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alFpSWhIdUw2ZlZFSEJGMVhUVlJkQzBmWnUzY0wzRWluNnQzQUJnYUlGZW83?=
 =?utf-8?B?d3h1eEdWQzJ4d2I2dWF1M3pkNUdkOU9vV0FwN0VQQ1JOeHYwdEZUNmp6OUFy?=
 =?utf-8?B?bmhDellaUXlUeTBzeE9NVjJqcHp0bTVFTjVyUC9yODQ2MjU1K3lrSGs2OGNX?=
 =?utf-8?B?ejdWVURSc2NXRzJEUHhBYkFPN3o1MU9XM2xzK0pTd3VPb1FaTkozc1RRMzJC?=
 =?utf-8?B?c1N5NzgyMTRuN3hMSUliWDVjUU0rN3ZTQ25STHdLNUhEYmFSOEhrVFBnZUhB?=
 =?utf-8?B?NWppdy9rbmdId2ZjcEkvazQybUQ3V3NQQ2ZONUxDTlN4RE1pa3dDVXBXMnI1?=
 =?utf-8?B?cTh5SHRSRWtZb0NxdCszMmNtc0hTaEdjWSt3SEFqSFlWS05KZUF5UmdhMVVt?=
 =?utf-8?B?dmh5dng0RDZoZWo3WUh2bzFKK3JzRFFTSkVQMjlqT3Y1MU5hWi9qSnZqRGE0?=
 =?utf-8?B?RGVuZGJLLzBrRUZhN1hObFhncThXYi9tYVFtL001YlZkbHJKSVpCVG1QS29v?=
 =?utf-8?B?T3FXQ0tOQU1WMndKVWlEYkJsMjV2dW9VRXJHWmU4R3J1RVpxakQrM1FweWRn?=
 =?utf-8?B?U0lKbW0wOGhiZnFkVHFsaXUrdmY4cVdXN2p3MWRlZHVWTTVhMjA1cEk1K01t?=
 =?utf-8?B?YzdyNGMyc3VuZzZaV051Mmw1TG9IUEtwNTVPNjdrMWVJdUlkR3B4YlpYbmt1?=
 =?utf-8?B?VGRrRUU0T1R1VHIvR08rNDZQcDF1cG9OMVNEY3RaVjNkNkdzb01Pa01QTHZx?=
 =?utf-8?B?ZDQ0WEJBVlhLekJvSTlOcDluMEdpOXJmOHFlTFhVZkJLR2pseGx6WjdzT2k1?=
 =?utf-8?B?dkw0dVozQzRLejZxREJzMllKS3JqVTY2WVY0VXJManc5ZTlwRU1lTHRLUEpR?=
 =?utf-8?B?Zklhb0RkTTZhMi9aZXBmYkxDSkpNK1lNU252NzRUT2VWcGk5YjB5VWQzelow?=
 =?utf-8?B?Zk05K0dUUEV0VitveDJ6ZVRjbUpnNExPNUJYeDVGcWNKMUs1VTVWUFpQNVB0?=
 =?utf-8?B?MTVGUVNoaFpzQkFHZk16YlhXY01UOWZORGRtbE9Ma2JNM3ZCeTUvelhMZlRK?=
 =?utf-8?B?OFQ2MDRydm1RNURraEVqUzlOYytpakVzejMyVk5KaWl0RElGbU5VUVVWWG42?=
 =?utf-8?B?VkZVc283MjZwbFZZYkpJZFFIM1JQQ2c4NzluNUt5aVpqd2g5U0ZWMmRUbEtN?=
 =?utf-8?B?bXVYWTAySFJlb0lkUkFDV0RZbXZ2aDNwVlBhR1hGdmt3ejVscUNoSGhQUW5J?=
 =?utf-8?B?MHN3OEpUcWRzdFpjbGFON1Nvc3VsSnRTMzRRVHgxR3FIdkpZS1BkL3VaMG5Z?=
 =?utf-8?B?NFV6a0M0Q0JKTURGMmRWL3ZuRTI0UUF3Yi9NTjl0aGppajkxdzF4THU3b0lJ?=
 =?utf-8?B?YWV3UCswU1BtRE9KbnRYcFZ5UWV5YXJHb00rdnJ3NXo2QTBqbXlpaUdNT00r?=
 =?utf-8?B?KzMrc0dOc09CcE92bTl5cHoyN3pMRFJLZU5yU0JNTndURnp6MUUrMGhCc0Z3?=
 =?utf-8?B?VURkR3Nnd29nUmo1RVkrcUF1dis2R1FlZEdDUG9XKzZVaHlRbmtHSXJzZzlY?=
 =?utf-8?B?SHhrdWhvR3JtZndaRlRFQ0Mvd05Pekt1SDBMZGZLTVE0VStOM05xYXlXUE5H?=
 =?utf-8?B?QkRqMzJNRklLMk9VdXdQUGJPM2NMNjNJRFZrbXdUYzhUQ0h6WmFtbll4d3VC?=
 =?utf-8?B?Z09tbkZvcFp4NGxtSDFrREY1SzM0VW14VVNPTitHeGRESDBQOVFocm9meXBv?=
 =?utf-8?B?Y29hQnBLMVJWOWdoMGdhMTBWeWxxRml3aFdyV1ZMbmpiR0Z0cE43eFFLOWsz?=
 =?utf-8?B?dU4vTC9jMVcrczE5VUZQYndNdnFweW94anZoN3BiVHo5dm5nOXljNGhzeHEv?=
 =?utf-8?B?NTR4cmI3Uzh0RHhCTzZNNTlTZXYrb21QNmE1L3hDTGVVTmFlTlNrQ3h3cklB?=
 =?utf-8?B?cUNJNEQzM3lNaEFrV21SOHNLVjlwVDdVVXc2cXowT2xsMDZweGpqQXZLcVpH?=
 =?utf-8?B?a0pqMDNhTGNpZllTNTZQaUljbW9GUzJHWmhDSWdlUDZ6ME1vTnJaclNlamhY?=
 =?utf-8?B?Ly9XK0EyY1pqckZNS0R2N2xOclU3S0t1ZjVhdHg3akxEcjIwMW1lWXdBOW9D?=
 =?utf-8?B?VWZjT1EySTY0WW45S3I0TXdsV0t5MjliVHRxK0h5R1M3MGtzSm5lcTUwMEww?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2219f4-dfcc-4319-5d40-08de0cccc94b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:58:02.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9+iAlVYXpcJbFzCuUzeaqCeK8AM+gW+Rff/o8cUGkGwZT6ntcWoMBafQB+upATaLYk8bzF38U0SWsBgM5FnIyYOSy4F9So2bJ3WCbnrqFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF066A3CD44
X-OriginatorOrg: intel.com

Hi Dave,

On 10/15/25 8:18 AM, Dave Martin wrote:
> Hi Reinette,
> 
> Just following up on the skipped L2_NONCONT_CAT test -- see below.

Thank you very much.

> 
> [...]
> 
> On Mon, Sep 22, 2025 at 03:39:47PM +0100, Dave Martin wrote:
> 
> [...]
> 
>> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
> 
> [...]
> 
>>> On 9/2/25 9:24 AM, Dave Martin wrote:
> 
> [...]
> 
>>>> Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
>>>> the other tests except for the NONCONT_CAT tests, which do not seem to
>>>> be supported in my configuration -- and have nothing to do with the
>>>> code touched by this patch).
>>>
>>> Is the NONCONT_CAT test failing (i.e printing "not ok")?
>>>
>>> The NONCONT_CAT tests may print error messages as debug information as part of
>>> running, but these errors are expected as part of the test. The test should accurately
>>> state whether it passed or failed though. For example, below attempts to write
>>> a non-contiguous CBM to a system that does not support non-contiguous masks.
>>> This fails as expected, error messages printed as debugging and thus the test passes
>>> with an "ok".
>>>
>>> # Write schema "L3:0=ff0ff" to resctrl FS # write() failed : Invalid argument                                      
>>> # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected                             
>>> ok 5 L3_NONCONT_CAT: test                             
>>
>> I don't think that this was anything to do with my changes, but I don't
>> still seem to have the test output.  (Since this test has to do with
>> bitmap schemata (?), it seemed unlikely to be affected by changes to
>> bw_validate().)
>>
>> I'll need to re-test with and without this patch to check whether it
>> makes any difference.
> 
> I finally got around to testing this on top of -rc1.
> 
> Disregarding trivial differences, the patched version (+++) doesn't
> seem to introduce any regressions over the vanilla version (---)
> (below).  (The CMT test actually failed with an out-of-tolerance result
> on the vanilla kernel only.  Possibly there was some adverse system
> load interfering.)

My first thought is that this is another unfortunate consequence of the resctrl
performance-as-functional tests.
The percentage difference you encountered is quite large and that
prompted me to take a closer look and it does look to me as though the CMT
can be improved. (Whether we should spend more effort on these performance tests
instead of creating new deterministic functional tests is another topic.) 

> 
> 
> Looking at the code, it seems that L2_NONCONT_CAT is not gated by any
> config or mount option.  I think this is just a feature that my
> hardware doesn't support (?)

Yes, this is how I also interpret the test output.

Focusing on the CMT test ...

>  # Starting CMT test ...
>  # Mounting resctrl to "/sys/fs/resctrl"
>  # Cache size :23068672
>  # Writing benchmark parameters to resctrl FS
> -# Benchmark PID: 5135
> +# Benchmark PID: 4970
>  # Checking for pass/fail
> -# Fail: Check cache miss rate within 15%
> -# Percent diff=24
> +# Pass: Check cache miss rate within 15%
> +# Percent diff=4
>  # Number of bits: 5
> -# Average LLC val: 7942963
> +# Average LLC val: 10918297
>  # Cache span (bytes): 10485760
> -not ok 3 CMT: test
> +ok 3 CMT: test

A 24% difference followed by a 4% difference is a big swing. On a high level
the CMT test creates a new resource group with only the test assigned to it. The test
initializes and accesses a buffer a couple of time while measuring cache occupancy.
"success" is when the cache occupancy is within 15% of the buffer size.

I noticed a couple of places where the test is susceptible to interference and
system architecture.
1) The cache allocation of test's resource group overlaps with the rest of the
   system. On a busy system it is thus likely that the test's cache entries may be
   evicted.
2) The test does not account for cache architecture where, for example, there may be
   an L2 cache that can accommodate a large part of the buffer and thus not be
   reflected in the LLC occupancy count.

I started experimenting to see what it will take to reduce interference and ended up
with a change like below that isolates the cache portions between the test and the
rest of the system and if L2 cache allocation is possible, reduces the amount of L2
cache the test can allocate into as much as possible. This opened up another tangent
where the size of cache portion is the same as the buffer while it is not realistic
to expect a user space buffer to fill into the cache so nicely. 

Even with these changes I was not able to get the percentages to drop significantly
on my system but it may help to reduce the swings in numbers observed.

But, I do not see how work like this helps to improve resctrl health (compared to,
for example, just increasing the "success" percentage).

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index d09e693dc739..494e98aa8b69 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -19,12 +19,22 @@
 #define CON_MON_LCC_OCCUP_PATH		\
 	"%s/%s/mon_data/mon_L3_%02d/llc_occupancy"
 
-static int cmt_init(const struct resctrl_val_param *param, int domain_id)
+static int cmt_init(const struct resctrl_test *test,
+		    const struct user_params *uparams,
+		    const struct resctrl_val_param *param, int domain_id)
 {
+	char schemata[64];
+	int ret;
+
 	sprintf(llc_occup_path, CON_MON_LCC_OCCUP_PATH, RESCTRL_PATH,
 		param->ctrlgrp, domain_id);
 
-	return 0;
+	snprintf(schemata, sizeof(schemata), "%lx", param->mask);
+	ret = write_schemata(param->ctrlgrp, schemata, uparams->cpu, test->resource);
+	if (!ret && !strcmp(test->resource, "L3") && resctrl_resource_exists("L2"))
+		ret = write_schemata(param->ctrlgrp, "0x1", uparams->cpu, "L2");
+
+	return ret;
 }
 
 static int cmt_setup(const struct resctrl_test *test,
@@ -119,6 +129,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 	unsigned long cache_total_size = 0;
 	int n = uparams->bits ? : 5;
 	unsigned long long_mask;
+	char schemata[64];
 	int count_of_bits;
 	size_t span;
 	int ret;
@@ -162,6 +173,11 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		param.fill_buf = &fill_buf;
 	}
 
+	snprintf(schemata, sizeof(schemata), "%lx", ~param.mask & long_mask);
+	ret = write_schemata("", schemata, uparams->cpu, test->resource);
+	if (ret)
+		return ret;
+
 	remove(RESULT_FILE_NAME);
 
 	ret = resctrl_val(test, uparams, &param);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index c7e9adc0368f..cd4c715b7ffd 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -17,7 +17,9 @@
 #define ALLOCATION_MIN		10
 #define ALLOCATION_STEP		10
 
-static int mba_init(const struct resctrl_val_param *param, int domain_id)
+static int mba_init(const struct resctrl_test *test,
+		    const struct user_params *uparams,
+		    const struct resctrl_val_param *param, int domain_id)
 {
 	int ret;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 84d8bc250539..58201f844740 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -83,7 +83,9 @@ static int check_results(size_t span)
 	return ret;
 }
 
-static int mbm_init(const struct resctrl_val_param *param, int domain_id)
+static int mbm_init(const struct resctrl_test *test,
+		    const struct user_params *uparams,
+		    const struct resctrl_val_param *param, int domain_id)
 {
 	int ret;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index cd3adfc14969..9853bd746392 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -133,7 +133,9 @@ struct resctrl_val_param {
 	char			filename[64];
 	unsigned long		mask;
 	int			num_of_runs;
-	int			(*init)(const struct resctrl_val_param *param,
+	int			(*init)(const struct resctrl_test *test,
+					const struct user_params *uparams,
+					const struct resctrl_val_param *param,
 					int domain_id);
 	int			(*setup)(const struct resctrl_test *test,
 					 const struct user_params *uparams,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 7c08e936572d..a5a8badb83d4 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -569,7 +569,7 @@ int resctrl_val(const struct resctrl_test *test,
 		goto reset_affinity;
 
 	if (param->init) {
-		ret = param->init(param, domain_id);
+		ret = param->init(test, uparams, param, domain_id);
 		if (ret)
 			goto reset_affinity;
 	}

