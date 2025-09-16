Return-Path: <linux-kernel+bounces-819674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168EB5A469
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72C9167B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8746289378;
	Tue, 16 Sep 2025 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NESmSEyS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C803294E1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059920; cv=fail; b=ifQb5O8Ii00o6jEKte487Dag/Su+ULKeAm2tMH7h8QMfq+bb+2Wtf5I0UJ0Cuk9SvZdEjnzHZg88P6LOXo+o0x9htf9L7MK37UUeiTfv20saaDvzd07u9RO1bYWZXmdKHc0gV5MfzE0o9Bgeg/tYVMQoYUAySdcHbjEypny1u1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059920; c=relaxed/simple;
	bh=zGzrCHByWLbwrVTehPro8pOtQrXicsx2eUUObYOIMb4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pWgXPfo9GzHMrES3gsPOvkI85LlUqd0PYpJlRfoOczefDKKbhFkgvkLvYkepCZxxa46SeWCOvW+DQKWyhWBjSVK96WT519RcvsMraKkWgcdVH5PlZe9vcjihUCT2zvl1jx+/HChYhdMOox5aDlTPbx+15S860VgdSY0te0CmN4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NESmSEyS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758059919; x=1789595919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zGzrCHByWLbwrVTehPro8pOtQrXicsx2eUUObYOIMb4=;
  b=NESmSEySkLnyUwtuLUxQ8z3eLxTZyHVNTIPNubP6suATmUinuSoSTsKL
   pwOYuql+Rw/79Mgp92YuE4e1HKA5TWJiwmVHl02iYB6Y/QiD6VkKqiL67
   10s/9vd1HjJebjZe5WhP4Novqty4yhMVFJR6LfAjz8swE+sB44iV4vJeb
   KH3MQxV4SIxqC3kTZwxLjY76Rt98AKZmerUhFO0nlhCCbzLjbA4mSboSm
   1Fn315iJPU8XZrxfUfi/ijE4oIGmbhqqgMbyussWXoKHTe4SXp3blfVtz
   WMSLEvA6w0b9FKPzpjVIM9U12QRssPq4a9aqA7IX/t9foWSYnwtgt6JO/
   g==;
X-CSE-ConnectionGUID: 9zdGpi8lSEWsuTY4k6HCUw==
X-CSE-MsgGUID: if/QkTQTQAG3/w6i8n09cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71458402"
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="71458402"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 14:58:39 -0700
X-CSE-ConnectionGUID: PgHb7EXYQPew8ytJWhSzLQ==
X-CSE-MsgGUID: yZXjEWgcRrG5GjNlP/CtJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="179449896"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 14:58:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 14:58:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 14:58:37 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 14:58:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvMR49l2EhxzgQVquxbLpVU+DyLCQkOtGQMI+nWn3lWmyYlpLkUaPF2/6EeSXha/m0HKboSAu4UggHXgwKHEV7Gmw5eNNkfjOaEBPUFeBAk1k0lRqLGJ4xVOVqH0u0g1fcl7Ef+j3j9nadTGQSdQaNwSG9FCZxQRAyAHTO5XYzdr+YPcAbEjdDV0eW62VUO/e5yS/8GSYrgWiGIsiDL6QLBDnUJRSpdZ0QNzMxur4vrI1ojbdbwG/QNK4Wuikh1D/xkLu1ihPy6PyAo4D/K+Q1lyXasm06VH0S9jL7jPY4fs6OhM3b6OgQgVWZ3aM0EwKmFzHU8Ns5OiE62T8yRouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM3khFGazYanLvf413TDMXWn+fHQJSNedYl0VTwpHag=;
 b=DDytvrmbh6PDjFM5qPssw7CcIp7Q6+vO0RW0He3PX+lWWy/pT2bWUnPBo/J46fYHFfO0Rt9/k8VqutyFo2pMwgMf2IEQlp3d4EYftKuTQX/pimzW2cKkFQ4WwGq/the3QA+u1m+3VRJ8KACi00EpivwjJlaqWZ5Woo180Ms4R7EhFfVrq2Vm74qq8mEbXR+Rlwz+WvBRF6zru6ynqqzFeCF3wi+Y/dJJCQbfoh0VJ0TkvyuFCgD5dHijvdGbRWiyt2Zz21kXxxv3YS8Un2Gi1xdZDuxxCUtB4Hl5/19ovY6kZSz4iu2pW7nIQfKRSqvoLLoevMVbYlHec4Q5csnJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 21:58:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 21:58:35 +0000
Message-ID: <437d6c22-f232-48a0-94db-a395aabe85d5@intel.com>
Date: Tue, 16 Sep 2025 14:58:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl: Fix counter auto-assignment on mkdir with
 mbm_event enabled
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <9788ef37c17a9559a08019b694d2a47b507aa4ac.1758043391.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9788ef37c17a9559a08019b694d2a47b507aa4ac.1758043391.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f516f2-0a62-4db2-4b94-08ddf56c2ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGpnL1p2ckY1bGFuWHVSOWxOSVZkN3Rzcmd0N3A2Z1NYcXdzL2x4N09MZUM3?=
 =?utf-8?B?eW85OWprMmFxTVNqaVM2M1JEaFoxQ3l4VGtERXZxSGllOW8xK0h6ZmYwdWNq?=
 =?utf-8?B?RWw5VCtUN2tKUzRMMWtLL24zcUt6L2xGblFJem1kUlVLWlp2RGtzR0MvSHo0?=
 =?utf-8?B?RzBNNUJzRXhBZmZsVURqMExGS1dsdEZpZ0NYYThjY2hidVg5anMrTGljYThM?=
 =?utf-8?B?cEt6UmJDKy9BMm1yRVljSStlZW16N3VIcGpFVTN6eVZGYlZEV1h4UWVvL25K?=
 =?utf-8?B?Q3dQODJEYjF0Q0RmS1kzaGM2ZDVLWmZyeUdGWXdCSWI4WGFJbUoybjZsQmxX?=
 =?utf-8?B?MDdQN0VnRUIwZXVXUzhnd2FhY0kwakc2WjR2YUlGQ1RtRGVWaFdsalVhOUh5?=
 =?utf-8?B?bVpBQkZKYlpDU2NPcmNlQlpHUTh6b09XQWlOMkVzbTBQYjhPRy9rQU9OeHVJ?=
 =?utf-8?B?elR5dFdDN1B6VHA0THhJbWtjMUZuR0NTbm84Um1NR2llTmg1SWJmWkNQV2tt?=
 =?utf-8?B?dDVhMFdvOUQ1OE9Bc0J0S1dCblBJeEU5cTh4dVdURURvQ0FKczhQazNEcDVQ?=
 =?utf-8?B?RzdFZ1RxS0lmMlFuS09tTERTOVZlcmxJNnR1V29BQ3pNOEVOYVA1d2VGK0V1?=
 =?utf-8?B?QzFxRkJqR2xIVVFkQjZLelhsQlgrWTA4b2J0WU93QzhiK0tWdTJwblQ4MldN?=
 =?utf-8?B?UlBLYlA3dUt0ZWRHUlliblpVNDNldkxWN1RMY0trcXNGQXVsTDQ3SG9rc3Zz?=
 =?utf-8?B?enVhMHNYZEZWNXZCTC8vSnRJNmV2WU5uMmxNcHdSc2kvb1NiNGdpc1VwRmNk?=
 =?utf-8?B?ZmFtWHBJcmcza2ttQjdlRzlxVUxZRmdyWkZmRDlYbXZKd3NZUjJPL0lKcnBk?=
 =?utf-8?B?cUJ5RXNSenlYZVQyRVZnVEl5cHVycFphYVAwd1JrVlJ3Vk91eXIyKzh1blhl?=
 =?utf-8?B?ZTNHcjU2R3Q0QjZKdlNBM3JuZC9udENwZVRtOUNSMGJvL2g3WXdqYWZ5Y2lY?=
 =?utf-8?B?elF2enRwZFl2Z0xaRjZ2OW40UE05TURCKzU3RWtRZE5vK0ZoK3lmS01KTzBN?=
 =?utf-8?B?S0t1NUFVNFZocUJ0OEhMNllJNXBoTklYbHpNVDM1YUpyMDl5dnN6Mlk5aUV3?=
 =?utf-8?B?WmcrOGNGWW41bWhQbGw4UitscTRBZnVjdFhwWDFLRVdQL2tuNmdKL0NFRFhN?=
 =?utf-8?B?RFByODRwYjRMYWpOeEMwaDhEdzNBbHJndTgrc2ZvVDROMlhqQUc1RjJ0LzJ2?=
 =?utf-8?B?U3N3a01tTTZ1Lzh6RGlma1Q0Qit1NWVGS1Z3Yk82ZXY1anh4NkRmOGZGMXBS?=
 =?utf-8?B?WUtjUnl6TjMwcnV3L2I4alVDRTFiY0syRXdYY2w0eHhkYnRuQkFCSzF1MjJ3?=
 =?utf-8?B?UGJTdXp4cFhHZzRWM3cxZE9pV2s2ZHZWOG1RMktpcnUrUDF6ejZpcmsya2N4?=
 =?utf-8?B?UXhzbDUzUWwxZmg0SWJRaGdTdU5TV256M3lUWjhGNDZZa3dRMlgyc3dXTjN4?=
 =?utf-8?B?NVJWaDEyQWM2VkV1RU9VMWM1YVRUSVYzSC9uTWQxM0tuVFFnWVR3VkRBd3Rw?=
 =?utf-8?B?Zll2S3R4ZGM4MXpmUGIydnM2cElmSVI5YnVxMEhpN3ZwQ29vTnUxNkxWRE9l?=
 =?utf-8?B?eUNrZm53WUxTclBVbFI0aGIrQ1Z4K09jSkJsdm5VY2JSSi8ya0NobXArd2Q5?=
 =?utf-8?B?eElkQVpSaERHZkRXQlFoYXRHSVd5R28rUVl3WGRuS1FjRUdTYjA5VUJFVjMx?=
 =?utf-8?B?K3ljK1VMbmNCSnp0QlJnS1kvKzhBamtmT1dCM3R5R2NFVC9qd2xuWGhCeFRq?=
 =?utf-8?B?azFhWG1IbmpKaCtjd2FxcEhIcnVjUTFzTDVzVldMaDloZ2VQK2FNNGxSbnIz?=
 =?utf-8?B?R01TbUsrNG1hMTNXdjZuTjlNMUV3eEpRc1d2WmxBaTBTcjhJazRCV2gzY04y?=
 =?utf-8?Q?Vvy4zfzai/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzVrcVVqREZJVVNqTDNJYVNTd21yRGJ6SjZlcU9uYzVRR1ZnSVFRM2xCZnZ2?=
 =?utf-8?B?eUdwcHluakgrU29BYU1vNEVMWUFLcXdGNERqemZIeVQ1SGJpbE1ZbzFpRVJG?=
 =?utf-8?B?aVVKWGd6eGRtOVo3WGVlZHIwbklxZGx2Vk9rMU5JN1JPL2RnQkMyNWd1VTZp?=
 =?utf-8?B?VCtrOVBOc050NngzcmpsdXA2UkFiUzVMZHZvdW9PRlA3czZxYXJWekg5dGFa?=
 =?utf-8?B?SU9HdDgxa2JDdTUvQzROajJmMk4yQm9TalV4UnJlOFEyMDdPQnRvcjhEazlV?=
 =?utf-8?B?WStWZUpuTlZDRXpCc2JsTkFENDQxYnlDbFZLdVlUNUxnbGlrdnZHY0ppaDIr?=
 =?utf-8?B?VEtxRXZaYUlBSHFKYXc1a2NoRThDdTRTcU04QWM2czhrQW5WTi9QUlFuS0Nx?=
 =?utf-8?B?dXJHV01VREdtQnB2VkJHZDRqWkRDTjVocUx1VHRjc1RxeDhCRmFyK0pSdWxi?=
 =?utf-8?B?ZzQwOFFlRlpuRzdHSHRmMzdlKy8wbjRGT2ozYUU5bmI3K1drNjkyVTBlWkxP?=
 =?utf-8?B?RlhHRVdia2RNWlF1eWpTNVJDdjdwbTRFZlVXb1lKL1d1WUVzRTc4QW5oT3dX?=
 =?utf-8?B?YmJaWmlFcVNmQWJ5dm80UUE1SWlFUFl2SXhXS3NWY0lKMkJWdms5MStKZUVq?=
 =?utf-8?B?TjBteWNKWmRiWDlnTVpralQvZ0VKSU1ORS9YVFdNLzQ5SFBCNm1ORWhUSCs4?=
 =?utf-8?B?c1l2RnJOb2c2R1VRb3EyL0RxbzZoUjZIOCt1aXdoVm45WTcwcldKOVJCenUx?=
 =?utf-8?B?QlUycjFTQS9VRWFtSXpad1hBcTdEZUpYaWg5eUs3VnpxLzE0WWNrcnRJOWY3?=
 =?utf-8?B?S3hnajUwajZ2SGlBUzdBelhmZWZpK09QWTN6ZklESXRDb2RidFJUOVViU1dl?=
 =?utf-8?B?a0NVVmkrUm1GeFRwZWVWaStZSVlCSmVTWmhSOEowQzRtV1pEL3JibXBOMGNC?=
 =?utf-8?B?VlR4ZzdieDJ0YUsvUTVvdDJadERmOGtueitKbzZyRUs0Q0gyY3V6Q0wydUlz?=
 =?utf-8?B?aDBzVlVOQkxMNTNTWUh5TlBneDM0ODZOZFhBTStmMHlTSEV3eXl2UHEySXVl?=
 =?utf-8?B?bERvTmRMdHRDd1BySmY1Kyt4S1hxY0ZGKzVEdnd1RlZad2ljcVNlbDQ5WFNW?=
 =?utf-8?B?Wmk4OFBqbEVhMzNKWE41akdqUnJoMEd3YW95dkpOaDNBdmhIbllIb1VNZ2o3?=
 =?utf-8?B?bzFzem5VanlsNkVOYUhNbTZLWU83UVpSVWlIeE9zcS9LMUY0eHJkbXdvNjdK?=
 =?utf-8?B?R2hXMXJYazkrN3RZNEVjTVNhWHl4TjYrWjBwZGNvNGZOZkZVQnBwRlNkc3dx?=
 =?utf-8?B?THNhUzVyZWxOcVhiV281ZVVSN0E0UUxrQTBOaGI3VU15RHVmc3hUdElLOTZ3?=
 =?utf-8?B?WUV1enBRYWJHajZZQlh5MG9PeEhkZEFNMWJWSEwxLzZ5ME5pOHhyZTFWYmpU?=
 =?utf-8?B?T2pFNDFaWUk4SkFYSDRMT3VvR2FvNjdzZGI3K0FrMWtiVnZScWFDaDZFVXRj?=
 =?utf-8?B?aGNVSEJoMEdWeHg0ZTk5Tm9CVllRaG9SOW52OUM0Wit2TXM2SnpVS1kwUDNR?=
 =?utf-8?B?T1Ztc215Ri93eEFsanNwbEFqdkRJWGFHdzBQYUhjSVBzL1NTVmU4ZEU3L3Ex?=
 =?utf-8?B?bzJ2QWZDbnFXdmVib3BrZjRWWFJEMEN5MTg2RngrWFlucEpRWGVSNzdEY1VG?=
 =?utf-8?B?YUNLVG9HRGIzSWNJVjRIenRXeUU0eDh0OC8yU3FhVzA2ZjZ6Y2Q2djdiaTBa?=
 =?utf-8?B?N2pIRFNkQU5lWGM4YW14SUVxTlAvUEh6ZnZNS1l1UXEySDIxdzNJemVLbjJv?=
 =?utf-8?B?MU9vclFQNGxXaWlGVFdEWnloc0V1UUtjUmc3UFpjLzhHQzdrVlRmK1U2aHVy?=
 =?utf-8?B?bEI2SlcwNVVaalVCdU5mU3AyRzFRU0VVclVKaFZOSnQ0eFY0VUxyS0hYUm5k?=
 =?utf-8?B?dHlBb0FXN3NjOXB1eXFBQzhKVFByK3JOSG45UmlIWktkWU44NVR5R1plSDgx?=
 =?utf-8?B?clRwNnZZNFdnb3BiRDJud21Lb0FHaSsrV2t6UUlVSDdKYVVjUFd1cXZlN0JU?=
 =?utf-8?B?dGZGa3VQNTIreXRad1R0S3d6RERMcDJZbFJ3UzdpSEgyRkRmcmM1OGNFbFRo?=
 =?utf-8?B?aS9aNGdqNEY5ejR0QzBMR2RFMXIycG9jbERDTG82QWNvSDVEUDFRUlIwUzZ0?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f516f2-0a62-4db2-4b94-08ddf56c2ef2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 21:58:35.0413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f8caKbHU5bMe89p5MDgmPIRlanEmqK42vtjJSGSwE03gtR4b1RKdGuvN6zJOWio7IKHk17qlCCEaLF5JjudbB0F5BcQVuNCcTHGgRXKZ4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

Hi Babu,

On 9/16/25 10:25 AM, Babu Moger wrote:
> Found that the automatic counter assignment is not working as expected when
> "mbm_event" is enabled. Counters are being assigned regardless of whether
> mbm_assign_on_mkdir is enabled or not.
> 
> The logic was mistakenly placed in rdtgroup_unassign_cntrs() instead of
> rdtgroup_assign_cntrs().
> 
> Fix it by moving the code snippet to rdtgroup_assign_cntrs().
> 

With the goal to address Boris's concerns about changelogs I think the changelog
can be made more specific by replacing the vague "the logic" and "the code snippet"
terms. Below is an example changelog that addresses this but I am afraid that it may
now be considered too much text :(. As I am still learning how to get this right I
surely will not hold up the patch because of this, tag is below.

	rdt_resource::resctrl_mon::mbm_assign_on_mkdir determines if a counter will
	automatically be assigned to an RMID, MBM event pair when its associated
	monitor group is created via mkdir.

	Testing shows that counters are always automatically assigned to new monitor
	groups,	whether	mbm_assign_on_mkdir is set or not.

	To support automatic counter assignment the check for mbm_assign_on_mkdir
	should be in rdtgroup_assign_cntrs() that assigns counters during monitor group
	creation. Instead, the check for mbm_assign_on_mkdir is in rdtgroup_unassign_cntrs()
	that is called on monitor group deletion from where counters should always be
	unassigned, whether mbm_assign_on_mkdir is set or not.

	Fix automatic counter assignment by moving the mbm_assign_on_mkdir check from
	rdtgroup_unassign_cntrs() to rdtgroup_assign_cntrs().

> Fixes: ef712fe97ec57 ("fs/resctrl: Auto assign counters on mkdir and clean up on group removal")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Thank you very much for catching and fixing this issue.

It is not clear to me if the changelog will be acceptable and I provided alternative
text just in case. The fix looks good to me, for that:

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


