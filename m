Return-Path: <linux-kernel+bounces-732351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F41FB06583
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A95048ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682392980AA;
	Tue, 15 Jul 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvEJCQnX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE5C288C16
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602604; cv=fail; b=E/X9t+VYKJRdyF753+WVH+M9ZxbvukE5nBzvf3pEHeQToGVEByScXOgusSlb8rp21dOWZvib22iT7w64T9il4D9RQkAEPpFVnxq9gdaBcbu4AKw/FgzQK9/jofzP+rxctq2HXZU4vLCaxAwgJ8nwn1enUGDKBinnh+RuxESBHMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602604; c=relaxed/simple;
	bh=8gDhUvQ1EeRnuKRyqvKiiC3thAmFABXhfDMv9sA3Wxk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EH3FCgEFjO5VylDgbryjWfJZX+BYl2rSif6uF+tOKBWxkhf1CTaR6+G8b1fRogoJu5Oe5TtlIM6PUIfkF5UIXZPyVyW4uLuodSJcoSjqIYDUJMbNjetTW0f35F5ptqJGk9D3mLLp4hy/3kFGGPzo4m/iDRQQYtF90iUWp7ke8ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvEJCQnX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752602603; x=1784138603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8gDhUvQ1EeRnuKRyqvKiiC3thAmFABXhfDMv9sA3Wxk=;
  b=VvEJCQnX/MGnREm5jIOBhnRdGQUH3pRk2NeRQcZBLnCOLMA7VSVoTMhy
   Fmx4mRRV0QJp0QOduhhvmyg/cnSGxJrTXno9maI9fEQBm31CY+Pt5xgbb
   rgezBo98OooIEOBnJyDAiEFps8VtXektHbSR7/Bq4brmWNVgIU2KE+Hhu
   SJD9H7jvX3f1quMjvCEgO9s5G3URm+DN9z60vsF5pdzelJVxk68wNuk9X
   kkA+BLz+PeBo/nCuAMBoaY0BND+X3Agy47DHUruBOyJYTKLGbGYBh19Dx
   H1AdrbOA0MDozVp09pllxJe7pZP3Z5k6HgP6qL2gifMjLtGOowrNa7Pw4
   w==;
X-CSE-ConnectionGUID: oKki9ZTKQ06b1WD9QrD4rg==
X-CSE-MsgGUID: Mb5Jy/upTDSpcp4YVOZLrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58489220"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58489220"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 11:03:23 -0700
X-CSE-ConnectionGUID: CNaWk93rT2SUvM3Oz9LR6A==
X-CSE-MsgGUID: lZdcQ0ZnRzWLrtf/V1xeuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157396462"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 11:03:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 11:03:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 11:03:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 11:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEIYJ1w8eNiGe2RPZsH9SKYrJH7p8K9kCXosDOLa2OPPaq1jBir2+AK6iVmfdhMmU89m1ND7fCVWRlupb3QnHppmyJ6z6+H14ucPSVHMGgqUrzYn4ufbhqLDyW1mRBbzOe+UaV4iqHxfDSo+CSVpnvVUasCdf6LlOqMfYXi3N58MRTb/LMG1dCbMspHxeUrtcVgoAJOpB0dRgnVvwy4CLRJwLPgMU8q3Bq3eOdtcfoGOZrZlBF0FuGSRHtcqtAutK18KjxdZ5Nwhz7XYXlwAnV1ZCByVm9Cb0lJ+5L74rQcdDODO1DMe47TvDwtiurHLRB0lmU21jyM4gDwU4WOTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOkxEiQ5e7N5rh000pZ7acBx+PQtGiVH6J8ubbFl2ig=;
 b=uTb331Z9+Vh54am740XZf/2H02Hj+qW3n90wkuKnS1zZeSyjySQLGn9QXAfwoZTwh4f1JQLtVzymcsPOxq8s72gdd4ljrZyW+1ZQTQNWSUQesam9uVzODGySv66x4a49iNEzoSCjsljpqAmF9BwOxK7+RhTcUgagx0YIjAMnNgW6HZNxJfhbggTQ6YDZRoAIWqpKIJImMMfze1xnHCIzswy9SQb1MbEwfPnvAqIEcbono2gF2OjmcDiEJKJajdQ5LRNt4EPhzCKipUmMbPv7LHNnTy3wQz4LrLyLSW3ZKsf600caAfJl8KQ5pczEQaNDRg/SwvQ0mHOCgqy/QyUyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM3PPFE9E88246B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 18:02:52 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 18:02:52 +0000
Message-ID: <c12b6500-46a7-4e61-91db-da4ce654aae6@intel.com>
Date: Tue, 15 Jul 2025 11:02:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu: Sort the Intel microcode defines by
 Family-model-stepping
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>
References: <20250715020057.47880-1-sohil.mehta@intel.com>
 <325d7781-dede-4b12-b8e7-3332bec4ee20@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <325d7781-dede-4b12-b8e7-3332bec4ee20@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM3PPFE9E88246B:EE_
X-MS-Office365-Filtering-Correlation-Id: 116252e4-a808-474f-645d-08ddc3c9d102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXozQkFacVd6WnplcmR1RXdoeWZMVVcvNlUxd3VHbzhERE1JRVlYVnVyMk9t?=
 =?utf-8?B?cTNXemRKUUtoMHU5NlhDak02OTVibE9DanV1NGRJN2IvYlJlYVBRRlo0SHRC?=
 =?utf-8?B?QXZJYmFuWnlwVFFta2JVamRWWnRjOTJ4NzVRRGR1UGVmM3ZnUkVNTE5wdjht?=
 =?utf-8?B?TXRnVUtNWlpFSnVPRWpXTGgwNmpqRmx0QTB4cXp6ZkRaY0FtVCtXKzl6WUJn?=
 =?utf-8?B?NWYyTzVnSTZjVGo2dng0OXd0VXp6VkxnL0Nndk5LR0Z0NUdUNExEajEwVVVk?=
 =?utf-8?B?Nys1b3I5ak9VaHY3TVdVUG9wL2xnMVI4S2JTVld5U2xhc1VaeHNicUErOEFC?=
 =?utf-8?B?MlRmaEFoNjFVV29GdWJuNHNwY1FMODlpOE5tb1Q0K1JjUHBpb1VxV0IxMkZR?=
 =?utf-8?B?cWozU2hKc2tpbkdpRGJHRmQybVd0emI1MlpkVUoxVkh6bU9pMnZpMzV1V2tL?=
 =?utf-8?B?R1NMa1JrcDJzMmdvTjBQN0VYbGlnRmgrcHlxVTk2bXJoaWVUcDBPdkFFbHJW?=
 =?utf-8?B?YlgvVVhYRS9hanl1YUhVb0ZHamdOTDAweTdpSVhpazUyMVVRNER1TlcwTTFK?=
 =?utf-8?B?Y2M3cStQd2JOYzFsOVBRQXR6UlZBU0d6YzlmT2ZqNTNJUG4yRVFhTldUT1hG?=
 =?utf-8?B?eWJtNm1GbnpZVngzOXlhY2JpYXZFTjF6SHFUVisrQVZNUWw4Y2R1RmxUMWl6?=
 =?utf-8?B?S3FWemRpK0hpdm80TEl3Yi9oM0VyMVhzV25VWlFsTnBmVHNKamRvdlZUNDhh?=
 =?utf-8?B?aUhDQTlRcnJVeGRMUTMzYVFuOFVUTTNOVHpQNHlYVlkvSWd3ZnkyTDJaRmN1?=
 =?utf-8?B?WFFhb0hadnFnbVhQSTJaaldhNW95djB4aFNJQ0dsVjdJOVBmOFRqYUdORm4w?=
 =?utf-8?B?QXVYcENRaENOc0FIb3FtdjVoTFdZTlNJSk9oMlNrTXgvcThqT2JzbEFDd2tJ?=
 =?utf-8?B?bkh0Y0k5VTNMUXZqQVJzZWlZTU45S1c1VURFV1BVeUdRTktiaXBQVzZRSWhu?=
 =?utf-8?B?Y213UzI0cnBjODYvbUdqVHpxdWVTYkZUWXRtMmErMmVjY2MxVkVSRFN4USth?=
 =?utf-8?B?WGw5eGJxOWRRUjhrdmVSbERQbmJ5dFhEMFRrRmsxRlp6V0pFZWU3YWNJU0cv?=
 =?utf-8?B?YTNQR1NaVnMvSmRSeFFiQ01SS1ZjWktGVkFvbnhQRUdQU0RoNVNINlZwMDNW?=
 =?utf-8?B?Y0tLZzh4NlMzMlpOMnZmbWhWNHFjUTR5MDNVNFhSNkFSRS9XRjVlcktTZEdk?=
 =?utf-8?B?UCtrZXhrQlphRVlybTRab1dxdFk2ZlN5MW1ROGgrUzYwTG90K3FvMzNmSDNY?=
 =?utf-8?B?UDJYWWlZL0RrWFZmVHhpT2NUblRNTVdMQmVvaERFSU5kRHhRMElKQkJCYW9m?=
 =?utf-8?B?bkdXVlRSb0Q5OTQxRHdwT0VPbGkxeWJjSjZETDVGK2JzVWVMUjIrQ2wzVWF5?=
 =?utf-8?B?a3hkSkFSM2l3RFBlb1ppRGxxZGxGc3REMkU1QnZaZVJzQ3dCNERrQjRuZ1VI?=
 =?utf-8?B?OFpNSGZkWEsyaEYrSHRKVm5PSTltc09FMDdwNVE5VGFoMnJFa1Q2ME5Ib1pq?=
 =?utf-8?B?V3B1Q3JQbjZRbGdPTnJIU1JGS1p4dDBSMUFKcjlEaE1hWm9pSnB1RjFPbnJ3?=
 =?utf-8?B?OXNEaGs1WFZpTWtHNXUxdTNZZW5IQ1lxOUVKcnk3QkRNRlN4VDlBMEI3Ry9J?=
 =?utf-8?B?VVZGcGpmczFqUW5uVUhlemgzQTJwRDRIb29yK2tWM1JzM0IyMnc3UkcrTmZM?=
 =?utf-8?B?MDhWMUEraWIyNFJNaS9uc2k3MW1wYmhhUlFaNWZZbU9Pd05PTGZUVU1YNjN1?=
 =?utf-8?B?Y0ZBL2tsZHk3cGpES2pNbG5FYWZFSUc4a1ljelpZTFhFdVduR0gwTHFtU0gy?=
 =?utf-8?B?QXpnNXd0VlFGSVpBZXNPYmpJTENiOUxTQ0NPSitPK1p2VktaQy85VVJ1Z0xC?=
 =?utf-8?Q?oMVh0VBd2f8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1htQlBqUkYwcllDVTIrOE1kQzlXRVFCR3IxcVBTcy8xd3BCWGxweUFVS21F?=
 =?utf-8?B?MzdCZ3V2V2dWUGNnOWdCV3VDU293ZElWK3NBT0U3bmtIRG9WQ0RZS2RaYm02?=
 =?utf-8?B?VGFyUS82eTh4OWs1SXU4MW9qdThZV3FFYWJsaFZYWEFiQ0dVdzlPQm5NWDd3?=
 =?utf-8?B?V1h0YzFOb3BhZnN6c3kvU0dqckVYUTc3L0VwL1lRaVhkMWtqYmNFT01zQmpx?=
 =?utf-8?B?TzlPOFNzQVNHTVlxaTNRaHB5dndOTlU5Mm5ETHpyd1AzOWZ5d0NBZC9ZbHMz?=
 =?utf-8?B?bzg0QVByY004RzB5ZnhwSi9HbVNBYkZ3SDYyTm5PZjg2Wmp2S3d5QTFYYldP?=
 =?utf-8?B?L1hONzhDeUI5REJ2TzRVSHZtMXVBdVQwZ3RjT3JmYVBGUWc2Q1JSV0JZV3F6?=
 =?utf-8?B?MmluMDlObk9UOEdCV0oybEJXRVV6ZTgwdVJsRHNZbklhT1VuM3hLd2ZGSE1X?=
 =?utf-8?B?K1owM3pieEJHK2NaVjNPMDFWRW9IaXpKVjZDNmxQRzVtMmtsb1h4Y25vd0VU?=
 =?utf-8?B?VDFDYWtUNGdxQ0tlRnU2cU41WVd3NTY1cTY4WU84SFdYZFVqRS9WYWM0YWdn?=
 =?utf-8?B?WTlLcVpFUFl2UVhKdHorQ2NsTHRESTAvcjJqU0I3UlBueDYxeFlhTUl3enMy?=
 =?utf-8?B?WWZWWmVtczJYMVhVSFY5K2thSXRUUVlGbWdFenFrQjlWbzY4WWMyRStwcU5B?=
 =?utf-8?B?aEhIcjRXVFNiVVZFaWRlazhUWG5DRFlDK1B4N2ozTUdOTUYvNzFOc0Fjc0NR?=
 =?utf-8?B?aVJPdEErVHducTZHKzdHczJCQkIwU1hFK1FtWk9yM0JKUW4wMUt5SDBuQy9T?=
 =?utf-8?B?L01IcjZHNHFaY3h1RnlEc3B1cDdCeUQ2MkczZkZiRjBPWDFrSmRlM3VObm5V?=
 =?utf-8?B?NHRCS1FFNzc1bE8rY3N4YjRLK0orMUFna2p6ajBRSW1YZkw3STBybnZjV1hm?=
 =?utf-8?B?M2lKQ0V3OHc2MnRZeEtjU3Fsb1l4TjA1bWIzV3FJbG9WU21tdzgxZXhXYUhE?=
 =?utf-8?B?SmZ4T0gyY1N4REdVQ1ZySC92VmRRUjJodkVsU3lub05PcmxWV29XZTQzQklB?=
 =?utf-8?B?MmxDdFhpS2pPLzByMk1FSGcwQ2Fpb0VPVDB4dkpsb3FEUC9kaXBQOG41Smly?=
 =?utf-8?B?WE1GcmF1QjRkTFlQMWxJQVBWczFEY3RoaHFkU1ZtK0FMU0g0aUFqT2NicXFa?=
 =?utf-8?B?WkhHTGp1QnZ3bDZMNll1K2hsUzFFNTJEbGZ5TzM5aitJMHVraFJxNFFIZURj?=
 =?utf-8?B?c3dkQnRVRHFaQUhqNTNVZjZ2cFpzTGFKMk1ldHpnRFlYWU9KdVZIYXBTYTRt?=
 =?utf-8?B?L0M4c01pblJiZEYra2xqRzVjSGlJYzRyQi8yc05GWEZ3RXNFb0pIRDQ5OWtW?=
 =?utf-8?B?Z1ROWlB5SFlma1BzM2ovYzA2aHg4OC92MS9ZUmZVZFlYOTJEMys4djhPaWlo?=
 =?utf-8?B?Y2hLenFwNlpYeTU1dU1UNFFzODh4aGtUMmpBR2NUeEkydWFuNGVteU5nY3lZ?=
 =?utf-8?B?c3RTbEZLeEpxR1JkdmtwYUpmaGgxTmdZSmpZQ0l1d1BzMWo5dnlMMGx5V3BM?=
 =?utf-8?B?NVU3aWdMTm9NYnFQbFhnY1AwQjlQZmVEUyttMEtRa1UzN3JTbGFISEo5Z2do?=
 =?utf-8?B?dVZEUW03cnRiVmlMbmhqaGsrVXgvR1BMZ1ovRnlGYXVuUHpEQnlhTTlPWTFk?=
 =?utf-8?B?YjJKeHFKOXY3dGVyVnRwSXVvb3p3cnk2amE4QWluRk9BU3JjVG14OXNKNWRh?=
 =?utf-8?B?STk0OUtlbmc2R0xhaklPSW82RjFydU01TVNXUXE5MVQwbCtuSmJXclZFSDZD?=
 =?utf-8?B?UmhzSnJUOHVZelpoTm80eEVYRzA5cWtzNTR1bFQ5K0tyWlRZWXNkTEZPQ2FO?=
 =?utf-8?B?MTI3N2EyVnlJa0s3cCthRTdGNmdDbXpXeXd4NktSTXZtUlZ1OWdKMDd3cktv?=
 =?utf-8?B?Uy9NMVJ3UFA2UlBlWFc3QmY1YVhKNTVsNlc0L0kza2xiT2tiUjZMaE9yZ3Rz?=
 =?utf-8?B?R0ttOHhLZlhQY3pqWUFSSFg1YjN2S3ZPbi9tYWFOc0ZiOG5yTFpGQmpMc0Mx?=
 =?utf-8?B?RmZvZklEeWdNcXpnY1lSbDlxamxCYXU1d0o5djBmMHg0VUlWM2NNSmtFZGRo?=
 =?utf-8?Q?wd+Vnsq4STmwIWKUTUrxZr6TB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 116252e4-a808-474f-645d-08ddc3c9d102
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:02:52.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWRy9Xns52n1KQxHu9/2/GO4gxrhMCgKvWnm3hHzR8bxNNkFNmClyDS7MhE4fkckJQi4Em8qDbp7G1tWJhUr6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9E88246B
X-OriginatorOrg: intel.com

On 7/14/2025 8:33 PM, Dave Hansen wrote:
> On 7/14/25 19:00, Sohil Mehta wrote:
>> Keeping the Intel microcode defines sorted by Family-model-stepping is
>> crucial to its long-term maintainability. This would prevent unnecessary
>> changes and duplicate entries whenever they are updated.
> 
> I've been procrastinating putting my script that generated that file
> into the tree. But we should probably just have it do the sorting and
> just update the file the next time we update the microcode versions.
> 

The output was a result of exactly that. I am preparing the script to
merge it into the kernel. But when I ran the script, I couldn't
accurately reproduce what is currently there in intel-ucode-defs.h.

I added the sorting to keep it consistent in the future. But, I figured
for a particular microcode release, let's say 29f82f7429c
("microcode-20241029 Release") we should have a unique and matching
intel-ucode-defs.h.

Sure, we could start enforcing this with the next time we update the
header. However, since the file may be shared across stable kernels, it
seemed valuable to change the first version as well.

> But either way, I'm not concerned about maintainability. I just re-run
> the script and regenerate the whole file each time.

Yeah, the sorting is mainly to make it easier to review what is changing
in the file with every update.

Anyway, I'll leave the maintainability aspect of this up to you :)

