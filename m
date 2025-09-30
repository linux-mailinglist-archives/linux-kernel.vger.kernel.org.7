Return-Path: <linux-kernel+bounces-837019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF309BAB19E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F4F3C7ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DCC1FC7C5;
	Tue, 30 Sep 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKs/xYep"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE62144C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200870; cv=fail; b=s4mx4U61qAXZQOMNuSVdI+qhoV9xAH7zd3sdmPbNCMNcOnVTl8fJI6miimjeeRqwu737bnYJQ4m2hBb5LpU297kZadFEYcxx1qmg1KOq7Giff+FGv4exEwMfIpMVd77eRa3VpVK20gi2AIyGzBl8GPgt/rrVvn2WtC/TEyn28BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200870; c=relaxed/simple;
	bh=mPqXqd+/QmdljE8NhGeSn0iaMTLbjW0ASdGai/Yr5ek=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqhUTXH/O3X5NiHhvOAX4t+GUYiicegp3USbQ/XvNEu08s7kTpJfmGOhdIUvCQ/rLvSpRfd6tO8wvoIw5Lr+Us/QE+F7WAm2lLy1HtcpWqHtS4UBmJ05h8asq6VrnG2CO4oBSeT37BeWkpBvJTKD3eP//Q1vBslvr8df+KXzzu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKs/xYep; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759200868; x=1790736868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mPqXqd+/QmdljE8NhGeSn0iaMTLbjW0ASdGai/Yr5ek=;
  b=AKs/xYepk3GrOYddOhdNzHhQ4AWByOfPmlou5rUzY5Yp01eFML9r8iis
   iK0TuTgrbTecS62DVfb1CfcGe91SzRMDk3GGmhLqQpwDjMpjNzJWJ3C/F
   ySCkDxaVPzwO3QqjnNo7NZYSKI25Z6aySKkD2JukubHgsHRgbns9buDG7
   N/bRrmahjE3e1+1hiXAw79yEsu4JbMOxIfxlEgzP3heEwRN9me+VlMPWL
   ZfnFkyofLPafq6NYYsRpslt3cvUOCJn9G3MUFnjEFlm/7pWZJptoSIL1v
   dMMvWp/KDZdAE/G9d//w7zriE8j/ke90IzKs2Jp5fX2wNCsRkw8qqxKwf
   g==;
X-CSE-ConnectionGUID: BzkA0DO/TeaKhpX+AXmj5A==
X-CSE-MsgGUID: XqCv/AaERJKnxY/2Qah9sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72553251"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="72553251"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 19:54:27 -0700
X-CSE-ConnectionGUID: 1G0nvfdyQNqf4J8QZXisrA==
X-CSE-MsgGUID: DZYuFcu4S9+uPjKoLUzm1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="178355535"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 19:54:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 19:54:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 19:54:26 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 19:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnHTYLMOkhJEooqiwuEuZYXJU/r30vHlkWogVIz+8xqBmUmeff5FMRSzWSTqynl/qP+WsjU9PyCRsPAc7XmucmstETgI7e8KFL7ejjinukJ7figsQZHtjpC6UrhorU9hNLyp84+pCkLCy1xF7wKgIq1VzIM6ZTlLGeOJJHO4GdyHIPWfTJXXJC7YT2Mjto+8Yc0xRMWQRxM3N9YvRneZoAMY53ll74463II5dKq49Jr/qJyGiZgfnZnpEolD2u0n6DwRcaY5Pyww0SXO8hjTYEjG/fIjt4GPOF4iHMY6FBoObkiO6YAk4uq6htlwv94/dCeCzGg50aD9uLLdFS+lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1HClYOJ7Vr1lVxWiVS8lcar4T0mNv9qAkoIOHnifTI=;
 b=l+xD/P4yESmV55ZklZbUPZKr1Z1NBnEi9+rd2Rm/Q0jj5mJaSa/xvBaRGBZcSK0nRml+PF/ohuLPCxZTzmZJiKM0ZxB8/oZFk7jV/tUYv0jMctsipKa0rsimp5xAk7Wnq4aQHkuwy6wAD8HkXHUASeeJNZvCe/Ig0tn+ry3B6BR3L6fLYhlN27lbuIlbaEXU1/3S+GJ0lUaRYVM2+/GUBpTkBn5F0vGGvEwY3J7I1d/jUO8o3WmHswTIbItEy3MS0c+zSjrsbw9aZrJ/e5lcERIpaiuDZBxoD7yEfITPoGpnbtuqLk5Dw/gk5iv/E5YOYJKROWWvzY14LGKOJo+L8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:54:17 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:54:15 +0000
Message-ID: <86fb463f-19bd-4242-8217-4d0f9e852c07@intel.com>
Date: Tue, 30 Sep 2025 10:54:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 08/28] sched: Set up LLC indexing
To: Adam Li <adamli@os.amperecomputing.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Libo Chen
	<libo.chen@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, "Hillf
 Danton" <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Jianyong Wu" <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len
 Brown <len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <959d897daadc28b8115c97df04eec2af0fd79c5d.1754712565.git.tim.c.chen@linux.intel.com>
 <baa45b9a-d8ef-4652-a3c2-83596216fcb6@os.amperecomputing.com>
 <1ec61212-24d5-4147-898a-f93c03c6ac94@intel.com>
 <9c332c5b-83d9-465c-b02f-6648af9a9fae@os.amperecomputing.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <9c332c5b-83d9-465c-b02f-6648af9a9fae@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0049.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::9) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d88a73-6512-443d-ec13-08ddffcca41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEE3WGkwUUNsWUFLbmtDRXBsOGhkRGowMDNzUUhWSkxvSXU3WjI0MWxoWnNv?=
 =?utf-8?B?b1BoREZENnVWVDFPTHFXdWI4UWdnZUNmdnpKb296cVJWWDc4VmNBQ09WdDRo?=
 =?utf-8?B?SjI1NWdwN1dUejBsZkdEQURXeXg5MFFxUXZkZVMvSUErd3JHYjA4Y0dtNUow?=
 =?utf-8?B?aFdIK0d6a0tQZ05qYytnRlpGc1FDYXJONFZRa2lBTEpNTVJKOHhZTjhBTkZs?=
 =?utf-8?B?MTFTRVZnZmo3bDllSUlpc2diNjdRbUhLUjRnN1RXV3ZXZ3c2dCtlY3pwNXl4?=
 =?utf-8?B?dERWdDlGc0k2WUhJcW02cHdOUUlGejBDQTYwV0FUZ1pQQ3VjMlZqcGFxY2pI?=
 =?utf-8?B?MkZWUjlNS00xSU9VZk1rM0RMVzFyeVBQR01GSk9MOXVkNUw4NjVDS081SDZm?=
 =?utf-8?B?Rlo4SjE0N2h5blltT282SUU3MlBtajdqVnNMVmRFQmZXRkNqUnRVMVpzenBD?=
 =?utf-8?B?SVp2UUpISCtpUUlQSXhUTjdTUFBmdjFHSlZzMzFkVEdwVGo3TkRvY2ZaTE5j?=
 =?utf-8?B?SWlJZFp4WkxzRm1UUUdBYzlBMS9YN2ZXcXhHVGhvZjVDZ096bFV3cWxGK2tY?=
 =?utf-8?B?d3J3c3h6U1FuNEgrYVRndmZ1R3BydlVpckdISytrZ293TmhwWEpWYkxHSDR5?=
 =?utf-8?B?ckJCOEVlOVE0UHVPb3J4Nm9EazY0NkdJQmViM1BWdTgvVUlvSGFTUTBpOHlD?=
 =?utf-8?B?M1ZnbnNBbjdGeVlVZzZlS0JSMXVUNjlXbGFQdWsxQzhacjhBRU43SkI3L0VQ?=
 =?utf-8?B?emdRanNEYzZjM0tNK25GVGg1My9xRVdkYkhmcTBNUjBQamNmZm0zTmFjWk45?=
 =?utf-8?B?VzR6aFExRTFRUC9nUURhK0dFMnpyc3VzUDNKaEFMUlNFdTEyQ0hWRTk1S0lX?=
 =?utf-8?B?bVg4SGZOOVRwYTJGeE9CSkgraU5MWVVmRG5NbHZTU0MxN0hTWUc3Yk43NHAw?=
 =?utf-8?B?aTVEUjRES21JMGlqZWJML1haSzJ3QnF3UHlwdmdMazkwRHc2L0lHSSsyR1Z2?=
 =?utf-8?B?ZEdoT3hEL1lDV3c3WlBaS3JCNlVnZXJMUmdaeFpOUXVXbVhYVHdXSmxDelRl?=
 =?utf-8?B?TU0rMWFKUW1BRVliL1plSWozUjkyYU5UQnRrMnhVRVlmdDZmUnFIZ0NqUzky?=
 =?utf-8?B?eTFWMkc2WW9Ld2xhZlI1Q1J5cm4xd3pXd3ZvZWRyM2FMZ1I1L1cyb2VyM3Zt?=
 =?utf-8?B?T1cyY0dXR1dhenQ4SDZUU2EyVDhBOEo5ODdmVmIwWlFqa2ZWTkhiL0NPUzFw?=
 =?utf-8?B?aXNqM00zY1BRZjNKaWlmTWZrK1h5RkszR2tBZnZkSTZuNFhxM0RBWE9PZDR0?=
 =?utf-8?B?ai9KM0FzSkxMMjFXZXhNaEJJNVB4bE1wRWd2NnRhYkh3RTJIZjQwem1WL3Jx?=
 =?utf-8?B?elk0SDBmc0tmcFFkT252ZjlhUDZPVTlOc0NOYm01aUo2TVRKOVhEN2lmSjY2?=
 =?utf-8?B?UXFYanBWZERkUDVxK3pUUDhNN054NVpKbVRGVTBWZnVHWlRHUHdIMWhaRUd3?=
 =?utf-8?B?VHRvenBjK0xOZGVNUWE1Q3FnUGcrdkdpR2s4eU1SL2FHN2Zma29HZUNaU0hM?=
 =?utf-8?B?UzR3WCtTVHNWY0RSa2kxRHFIRWFnbk5YTlpyM1BRYzBtQVJUMEZZTGRmRmVz?=
 =?utf-8?B?VkVnRDYxZE1RRTUwcFNWVENKNjIzS3NKbVZHVEt0Q3ZNZFRjbjk2U0c2R3dn?=
 =?utf-8?B?QktFczVidXdENVZFa0Fsam1SdlhlQ1RQYVBFS2Q5VDZBZXMwRTExQm1wMnd4?=
 =?utf-8?B?a2xzcDl3LzJDWEhRSkFkOFVKbEtqaFoyTGg5MEdyMWc4eVhoWGFxUnowZ2Zo?=
 =?utf-8?B?bFNIVjVGRG9RWURBK2w0TS85YVpYNlIyTnFrOUwzZzlpdXlrYzZrY0YrWmVi?=
 =?utf-8?B?WXUwZ0crcUxqNk5FTElaemJiZ3VjTnR4amM3RDROUUZBYWhabGp5S3Q3NmhJ?=
 =?utf-8?Q?onhI64BvHWzQ5p1lU+A4p85K1otKijcl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFBiaUNvN1dkYnJsYUFTbUJFNFgxbjZHMVg3RC9GWFdQbU5YdG5kTHo2eGJP?=
 =?utf-8?B?b2ZNN0tZaGxmRDhDZjJzVUtBYk1XWnRMK05xNUZPdUFUY1dUaUI1QmdhQjAr?=
 =?utf-8?B?Zk1LQnZaN04zVVpmSGtaRGFRYjcwWEdtTnc1VVpIWkx0b0plSU9NOUEzbVlW?=
 =?utf-8?B?MUVIQ3pwNHNrVGpUTzZUWHV5dkdVV21iTjJDU01YeFhxbnpFNjBvNm9UUnly?=
 =?utf-8?B?dVNHVm00bS9KVWRWSlFVcEdqb0VhVEtQSXk0eWRXY3FBMDNDdHIxTUkwdHZZ?=
 =?utf-8?B?R1puYkdheVBBRnQyNjRwZWkxemw4QWhvZlF4R3ZWQ0FzWkhLcjJScXFpcGdl?=
 =?utf-8?B?ZFRKWW41VXcvMHQ4bEs0MUpWbEhZbFFickYyZXYzeUN2MEF1UDdwN3dZMitT?=
 =?utf-8?B?QzRSODZTUnJFSW9QdC9PWGE1ZE42U2J0eTVVRlJhc1F1WExEMHIzakhnYWJF?=
 =?utf-8?B?VE43RUJCMG1rLy9UbVpkaThzVmd4Ui9JekNSOXJ0R2Urb2dJWG81RmZWY042?=
 =?utf-8?B?Zkp4dngveHlqUENoaGlJZ0ltVkxHQ0RiRWNUSnhOSWF0SGIzWC9WZ2hldzY3?=
 =?utf-8?B?cE0zdDFZT2pkYWdXaXFJYjA2S0Zod2UrU0diQVFPbTA3WFhVTExoaytlb0JK?=
 =?utf-8?B?dml6SFlOWEJTMGJsc3VEUnhmKzdHUGQwTDFzQTZxQm1rVkdIMDZHNm44WHVM?=
 =?utf-8?B?ZGZFeEh1OTNSQ2FkK0lOWmhhcWRJcExxL3pnRm5oaXJYWWNzM1gwbTB6akZk?=
 =?utf-8?B?Z0hOUWxORVVqMmFjNTNJaFF4dVRSZE5UUGNTRWQzcGFEZFJDYnF5OEpxcHVR?=
 =?utf-8?B?RWFiOWtuMUxGK0ptZFluSFJXMlAwQ1phWkFJYllHUlJFdlpkYWU0OFNZU2t6?=
 =?utf-8?B?YnJTWks3SEF0ZDhXQTVFSm4yVnRCSS81TGpxVDlmWHlEQ3VZeExzZHZKWk0v?=
 =?utf-8?B?RDZQaDBjVkE0bmlnS3pVVTBVT0dxdjJUNGU1bC96dXlYN2RrbllQQ0JwWlYz?=
 =?utf-8?B?dmFDQ1c2RWR5VjhnVjROd2E0ZVhST252TjhmRTBjRlhBVy9XSVk1U2ZLcVNN?=
 =?utf-8?B?RzljV3I2eExKQ1QzS09YQWJuK2dJUTQrQ0pwZTJWVFVMcUxuUCs5VDNhcTli?=
 =?utf-8?B?ZFBQaFM2QXN5U0VzRHVJWjJpUlQxaVdTWW0rZTF3U3dvdHRlNGc3T2pTWnhq?=
 =?utf-8?B?UnQyZW1kL0pIc1BkcmZDbmYzdHNqWXJOY3MyaXlpaUZ1UGZWNk1UUm10N0ZD?=
 =?utf-8?B?ZnBCK0FicU5aVnFXWmJrRDMvdTlmcDVOdkIwaGpLTjV2aXNSeCtmdnhoQ3h6?=
 =?utf-8?B?V3ZuZzcwZkNwU1FNek40WkZ4OUN0QTZ4SXdFUGIzSnozOHRhaW9yVlZraitY?=
 =?utf-8?B?em9JeGVoaXBJd3NPNGJaUkhYaWlkUTZia3praWpZNWRaaXFVaVFzeFV5amxq?=
 =?utf-8?B?VlF4MENSVjVhT0ZkcUczczQweWUweXoxZWM4Yzk4R3U5OTd1NkNwdnpUWmF0?=
 =?utf-8?B?Z292L1dtRXRLWnhzMXhjV1Q3UGdvQTk3cEpwWVJ5NU51NTdvYzJQRkFPbXAw?=
 =?utf-8?B?WWRpYkZadnNTZ0x4RG11dmZXVzVFRGxiWDlHQlUvV2lsZGorNUowRkxTbWoz?=
 =?utf-8?B?bkVpc1M3VmFhMG5YZWg5b2l4U3hLelJPck5XMHVKNS9VRHlRcmFqTElBa3U3?=
 =?utf-8?B?OTJzVytRQTMzZUlQMHoydndPa3M2Z2c5NmR2Vk5mRTYrYnRLbUR2TENUS2JD?=
 =?utf-8?B?dTBKUlBTak92WlBBQXJGS2RXTzJHZ211d3BMb2d0K3A4TGRBd2x0NVh0Y09F?=
 =?utf-8?B?YmxlUkxPaFozZW0yK0lhajdkOVRCT0NaU1c0UWtHT0luY3F4UUl4aTZIZ2hB?=
 =?utf-8?B?U0ZMSHRRcXBzeHhFTkxzN3hwZ2NLSG1WaHJ4WDB1YmdFenJGeTBUK0VxSTRR?=
 =?utf-8?B?TDNMLzArUTkyWThJL2gwcUFDQkZVRmZQVXlKVGZFUFVTeGZEbFJUQ0R5RlFZ?=
 =?utf-8?B?ams0Z3RWWG5RK2tCMDRCZlYySmZUN1dPemdSSERiUDNqMjBjRnlTWXByUk9H?=
 =?utf-8?B?MlVnTm10U1FYUzVac05mZWZDb2JJdmxXZXNwMjNGZm5NUzh6TmtCK2M1RUUx?=
 =?utf-8?Q?AU/K7Vldriv6yIkzM/H6eq1m/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d88a73-6512-443d-ec13-08ddffcca41f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:54:15.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc772vm/7YtwnfzB5lJIsgwBMIeLepPcckFznuKRLHKb22jZW02BkW8DAzgSEzeIWwUbN5ZPa1N8woyT6CIuFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com

On 9/29/2025 6:43 PM, Adam Li wrote:
> On 9/26/2025 9:51 PM, Chen, Yu C wrote:
>> Hi Adam,
>>
>> On 9/26/2025 2:14 PM, Adam Li wrote:

[snip]
>>>    #ifdef CONFIG_SCHED_CACHE
>>> -       if (llc_has_parent_sd && multi_llcs_node && !sched_asym_cpucap_active())
>>> +       if (has_llc && llc_has_parent_sd && multi_llcs_node &&
>>
>> multi_llcs_node will be false if there is no SD_SHARE_LLC domain on the
>> platform, so I suppose we don’t have to introduce has_llc?
>> multi_llcs is set to true iff there are more than 1 SD_SHARE_LLC domains under its
>> SD_SHARE_LLC parent domain.
>>
> 
> If there is *no* SD_SHARE_LLC domain, my test shows 'multi_llcs_node' is still 1 (true).
> 
> Looks it is because the default value of 'multi_llcs_node' is 1.
> 
> build_sched_domains():
> 	unsigned int multi_llcs_node = 1;
> 
> And this condition is always false since we have no SD_SHARE_LLC domain,
> therefore 'multi_llcs_node' will not be changed:
> 
>                          if (!(sd->flags & SD_SHARE_LLC) && child &&
>                              (child->flags & SD_SHARE_LLC))
> 

I see. I was looking at the v5 internal version where
multi_llcs was initialized to 0. Let me double check
and refine the logic. Thanks!

Chenyu


> Thanks,
> -adam

