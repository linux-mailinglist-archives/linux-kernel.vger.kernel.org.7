Return-Path: <linux-kernel+bounces-863744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72EBF8FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D518E353940
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5BA269AEE;
	Tue, 21 Oct 2025 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cR+vpYW5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56875258ED1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084263; cv=fail; b=WzXWVfyiE1UCakG0s+dAcPijpazq0ICrv26iZNbom53Cepq9PII12nfQgUN89qmsrJdRPF9fbzco95c94oLYCd+Kh61gfgKNs52KA5fkarPl+u8U6mT8WmRdkxOegQOBofi9QPEBtHx3CkGPgMS9xoV0frLdt/oLdBxMNLQwtkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084263; c=relaxed/simple;
	bh=QBVUt5fRoVbFx1gMubPDlq7EeYCVDpkj3AYLZIxPWWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cwQibi/4lGRq8xv0myvMRKH0UYCEICf9Ksqzgs9T4+6vADP0mCNDah/8JvMCBlr5v3c3tkLay4TDmH/xA9XTJ045GtfHEgXqha9NDKIRCj/EDrbFo25tA1IYZOASa0nlea78aedcovsNHAg+CkAkoOOFwfq7UMLYAurxfvazn2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cR+vpYW5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761084262; x=1792620262;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QBVUt5fRoVbFx1gMubPDlq7EeYCVDpkj3AYLZIxPWWU=;
  b=cR+vpYW5xLd27aGQxkzx76Wep+r4Cr0l4MJphpaAwH+33/BMh5vr2OMn
   Zv79OOn3tWVz/InUfxJVXqhq1QoYsOP8dCxWWrxbjQnXAbyk5SrOKcaSg
   iJ1LMGxGAjInWuxtr0VY1ZDv5qWyvsbFgeepQs153GXyYgqwDZ0lvkxN7
   xERDggJN4aJdTISTUkds9Bg8v/dLOCZqZTyHhsc7bFqSYVbGhSPqL19Ah
   EO1cz2MBhQo2vOjsrSBawKKMocz7eYg5KDLkj7OjylH8dl+ZjSDj0XZDt
   dGIZmlShJbShXpAUzzGJ9eqUqFtLelgCKgE6my4i8HJlP7/U6ds/e/hlm
   Q==;
X-CSE-ConnectionGUID: csQMHoFATYqxyYL5pWXy6w==
X-CSE-MsgGUID: 5dKKE0tLRsS46Sh+5DzzyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63371294"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="63371294"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 15:04:21 -0700
X-CSE-ConnectionGUID: 9tI2azHHTB6yklTXfUnIFQ==
X-CSE-MsgGUID: 2CmKAPlOTv6Ozlgu0yrU4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="188983223"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 15:04:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 15:04:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 15:04:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 15:04:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEaYWCS7KAkPbYF7LeTlLDB3PNYHcZOXDSF4jKmzPyWeNn3ICF4OAYv+hZIv/sF3W1MTDtdTNW/BUlX6gpqrNN/dv9HVvDkC1DQTa27H+bmcqQAlX6i3/dai2nTkjoJiSofa4vON1BGf6bAczK0TiAmnfNWLFGoehgdIEn9NLRo2WRxZst4nTE4dwMryPEgMKZFgsmaIhtY92MwNWF92csQ0FuYyb8MqO/JmaZARLeTAAAIWHrC1AU5o6bP6SU1KsQd3P9N3ecPHqlqS81rSW/Mq8/NBChhRDHaeNRA9mt1ZAIxx79ajT2rPRUX9y7+qYCPWGBXudv/iGD6Vl5tLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYpCtk7Wn3HexDMaupBOr1kZ61tivK+giDRtgg8n3Hk=;
 b=fsUIQEgD3bXnM71cyw1mPqN/elUTM6/yvYF37vrn2wWYQuhy46aqWvbpDiev+69t1pSNNh/aKTLBRz+QdsZXf5KilZgeC3ydC3F9YzfZ3RBlQQL4XuNiau+MI132M8CIXGTUd3oK+ULHExeSt7ab8u5gMGGLDhB7rudE612VV8HJ/Hp7mBxdMHHvBRRtsoqI/cRWiPcgFqtBp6df5KMqJRLmTfpVHUTDo+9LLC28Yov5wUwdM62dw8CQ5Dprhjqp8MQEfLv3AYnUpzsxsPw5CJy+RbG4UmOASEoDuCSNo1WpAOjgDD3EtEyeCAuCldO7nZTXGB+vrPo+hItJzii6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 22:04:17 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 22:04:17 +0000
Date: Tue, 21 Oct 2025 15:04:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <jiangshanlai@gmail.com>,
	<simona.vetter@ffwll.ch>, <christian.koenig@amd.com>, <pstanner@redhat.com>,
	<dakr@kernel.org>
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aPgDXsQY5qAfU0Tv@lstrano-desk.jf.intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
 <aPgBjmIm6n9H-R_u@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPgBjmIm6n9H-R_u@slm.duckdns.org>
X-ClientProxiedBy: MW4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:303:16d::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CO1PR11MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb128bb-6ba5-4384-623b-08de10edc752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzhhS05HRmpNaktMWE5Ycy9uUGFoeG5mK3ZXVkJxQjV0UzJIK1NReTZGaXBq?=
 =?utf-8?B?emRSOUwrSHhGajhsZE9LOGVyWUdVbXBxUG5PUlNHV2o5SzZGQ1FZUlFzcklB?=
 =?utf-8?B?b2lDbHpjMHNhWE05RkpJWXpISEVZdEszMFBFR1owdDZIUGtSQ3hxczNxV01l?=
 =?utf-8?B?d3JmNnEyK1k5dzFIQVpsUitITEpwSitDZU56RkxxRk5iVFBDMEJqYSt3c0tB?=
 =?utf-8?B?bmY1MG0zdlBGUjY3NUJZVDY5OFBvWEtVVkZLQ3FQYlBOTTcwaytlbTdOcnlW?=
 =?utf-8?B?TGF0U0JUdmx3L0IxMjFBc00rV2Q5TzZwTEYvQUcrQytJNmV5SFNSNTMxN1Fr?=
 =?utf-8?B?Y09KazJiQ1BaSEJhVWlmb0l3Q01LS2duME1mV3R3U2NQU3l5UWhpZDhQdlhW?=
 =?utf-8?B?N3VuY3NwNUtXQ1FBVjNNN2twOTZuWW5aRTUzOVVGOXNnWmNzRnl3NHNrSHRD?=
 =?utf-8?B?Nmd5TUw2aTJsM1psbmU0MVFPSURQOVFyam5ha0g4YzYrQlFHOEhscWlRQnZj?=
 =?utf-8?B?cHVUSjFqS0pPR0NUenkwcG1DaE9Nb21YaU81YWtEZzgxQk9xZnhKMFhsN0ta?=
 =?utf-8?B?dVB0d0xHWGNDbUtrdTB3R29XVDllcU1DRExHTDU1RzVSaERpa0ZaUWc5bGtB?=
 =?utf-8?B?TUNRVmNLSloza0JQQ1pqVUgrNlVTa20yOWt5UG1YajJ1ZHJQamRUR3k1QXds?=
 =?utf-8?B?MVRraDRub05zdzRqVWdnRVgwdWVrYVdNV3FiR0Jlb3lQNUYxU0dhaGpmR1Qz?=
 =?utf-8?B?aFlwaHQyLzR6VHpXSEp0TVpzRjVpRy8yMnBqUDJLS21LVGNUcGlRYTZ5dk5B?=
 =?utf-8?B?aVJGMkVKYmlyQXNaN0dFYVozV3V1Y0oyMEQwWDR1M1NxK2NiMHY0eUVzdlZ1?=
 =?utf-8?B?MzRvdCs4QzY2QjBZOU5NNHNPa3d2N29hTnZPVjNzOWVMWUQya0lDbWlmVGZC?=
 =?utf-8?B?MU9NY01Ocm9aeFdWQ0NqOTdXVFF2OFR2dTRkeFBmQk5PVnc3Y05aenZVTi9m?=
 =?utf-8?B?aDZkTTZvV0xGN0Q5ZHVoaXlibWdVVkpmUXNFTFl1RHRqZ1hJS2hQY2xaTkxF?=
 =?utf-8?B?L1psQ1ArcTQ2V1pjNSt5enpjanhoUFhyTnVTSllyS082Rk1CcHlDZWdId2hZ?=
 =?utf-8?B?c2p3Rll0eEV0L1VpTGpsWGNWV1FWc2d4bVcrZ2NZRmZudkZ6Nmx0dU12Q1Nx?=
 =?utf-8?B?QUhoay9jd1VRN3pKdlBWV3Z5Um9MTTdyRVFtRVU5eElWbmNhSlMra0E2eFUv?=
 =?utf-8?B?RG4xT3FpZklRK3lEUDJXcFUxazdBTEtTc1JGVHNxYitwelZndXo0YzBLU3h1?=
 =?utf-8?B?T0E0bzBYMHE2MUkvZVUxMCtucVBPUlpENzBGVXhXa3Z2cmtiays1SVpQR0E3?=
 =?utf-8?B?cjdtOXR2NDU1L2lVa0VqdlBpOTBZZUZwL0w3WVJobFkwdXYweHVQMXBidWVs?=
 =?utf-8?B?Q3VPeFBDeCs1dldCYStpV2VsYlFkK2djNWNBYlZYR0VLRm1WNEVMK2FVdWZm?=
 =?utf-8?B?a09mY2paTXRpUEhOYmpXcEJXL3RCRTdyQTQrNlJlUGltbzVwYXdERnJUZ1A3?=
 =?utf-8?B?YlJHS0cybisyZ0Z2eFN5QzVGMGVhM2VkMldGVnVYdldCdFJwMnZRQlNUa25Z?=
 =?utf-8?B?VG4zU2tGQjgyRGdrWW1EV3NmRWl4dWw0eFVsai9XMkJGT3lqSkM1YjVic04x?=
 =?utf-8?B?bCtUK2VIQzAvbHVnV0RTQWV6bm9CSDhOaFJZVjZybGxqdFp6YzdNSzIzZUtP?=
 =?utf-8?B?RUlmMEpMQUtYbk92bHNmaTMzQzNncE1LbitKS3JieHNWL3U3YzYxYmFlZTM4?=
 =?utf-8?B?Vm8veldQRzU4Vk1WUWtqVDdsWHh6a1BPWElkSUFlZWxkcFl5M2VVOWd5aWt6?=
 =?utf-8?B?cUVGQkxwcmtmZmtZbVJDK2ZEVDB3d0s1MkxxRm5Lc1JzM2c1UUMyRC9sVGlF?=
 =?utf-8?Q?sS1GYfYoqYqYbOn7ky/LUEphrhVSTUQk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFRtaFJUSFpPWGJDUHEzNnViQ08zTVowL2ZMdjQ5QUN2WUpzaU55MStwZzlt?=
 =?utf-8?B?dzFRWEYrYTA1bTNmaTJRK2FyRmlwZllwYUM5LzliOTg4dFQxZXF3WVhuOVFp?=
 =?utf-8?B?cUdWOEdCL1B6STZBcklnS3JoSXV2QzlVTTdBVkdQYVkyODhheGI2R25BRUp6?=
 =?utf-8?B?WXI2VEw5elkxdmVIMkg0K1JtRGUvMkszWWVMcExoOW9CdjZZcTA1alFSYjQx?=
 =?utf-8?B?UkMvNTlPMDJoamh5MVMwc1lJQ3hzUmF5L0EwUXBGQkkyQnUxUEdQZkNSU21F?=
 =?utf-8?B?K3N6THhleXp1L3RSdEtIbDZDZ3hHMDh4U05yT3dJd1BmUE1KWjVJSFFqSUNh?=
 =?utf-8?B?ckpYTjFGVEE2M1gxcU5HMU8yRElSMEFhMTdRblFhY0JwL0xvRFdqVUpTMlFV?=
 =?utf-8?B?enMxOHdVZmlicEpJSUNHc21Ra081ZFFKZDhkTlRoSVVvcjNqcEtxSnUyUWk0?=
 =?utf-8?B?SmQvVEQrbG5NdDlXTm5vclJ6T3cyWkp1cVFuSC95dk9vdklZRytBMFJoeGJo?=
 =?utf-8?B?ZnFFTWNOZ1VXUmRRVml5VGUzWXVYby9uZ3MxZ3Rhem5pZ1NzZEpMMWxEZklK?=
 =?utf-8?B?M2NYYU5aeVhQR3VKcEZFSlNTaEttc3ArRjZNOElvd3JlbmVmZlZwT0tVeDlv?=
 =?utf-8?B?QnpkT0lBSVdoRWhTNnl1c3M1dDVvNVgwK2ZUZ0dSTmg4NmxXVHJaYmpmWVA1?=
 =?utf-8?B?bXQ0YXNldU1tcXNoZEFxS2NKUGVhZ29FOVlJc1l1L0tadGZXTndRdFp3dmx4?=
 =?utf-8?B?VDVoZTNldkNZUDZ3a1JINklCdXlPVkVkTWdCWmRYTFNtVndmd0NVVnVuVk5y?=
 =?utf-8?B?OGZ1ZEoySG0vazIwVnVudk9ObmhQeTBYZFhsMXFoMU9ubDV6c2lJRi92T3BT?=
 =?utf-8?B?ZE5mUHVob0d3QWZEMUgwWnFnMk5pL3lqYTNzc0gzVVQvWnZnSHJIVW9JR1Z4?=
 =?utf-8?B?U2IrZWlzbGFPNlFjdXNleVlRMXZnWmhQUFRzOGdPYlRKV0J3WGJUWkk0VDJo?=
 =?utf-8?B?d2NsSUJnanhzRUljNkFrMG5LaldYUXZhTlo0UFdNMWVDZndBelFyTENaRW85?=
 =?utf-8?B?Q1FmOXFmZXgxRkRuZERWSWZpdlBOa1hsTE5CWVAzS09aY0xWd0F5bUVSczk4?=
 =?utf-8?B?Znk3cy84TmQ5S2ViUjRsQ0JFV3E5RTNuMDBWRjJOZEVpeVRVWDcyUURLc0JM?=
 =?utf-8?B?bmkxVFgwN21mZ0JQMW1tMWZndjJoZW45b2Z4OEdwT0ozSnRVLzJuM2ZtaFdT?=
 =?utf-8?B?ZGNGUlU4a21JU1NCdnNzUHViWCtkOUdWRHpJSUE1RXoyYjN3bVQ2WnBOdXph?=
 =?utf-8?B?am1ZUHM2SFRaRWVzRFF1SEpLTkZscS9CNUlTQTlneWRzQ0NrU3R6SEswaVFz?=
 =?utf-8?B?RGltSllwNldxbi9Cb21lYlRkUEV6M0xaUnIwSFVCa1RaS0Zpcmo2Y3c5RlZ1?=
 =?utf-8?B?TmdIS2lGeGFTemI4Um5EeDU0blBzSlJxays0ZW9mcnFnak9HU29RVmRlR1ht?=
 =?utf-8?B?aGEyZlV6RXFWblljRTYwWGlGTlNPRmp2SEFxV3dSTldrVm92TkFRemQ4cldU?=
 =?utf-8?B?Y1hnQVd5M0lkaVFNZjJIVnBqMk5uZFNHejVuRVpxSHV6a2kyY3BPQk5wdFpM?=
 =?utf-8?B?aUYrNGpHbTZONm45ZlpNTUZ4VnB6cFNaOGt6SUdUMkYyME9rcDN5b3daOWdp?=
 =?utf-8?B?NTA3NllBSFRJVHl4b2ptT2VYZm1tQ01aWUV6a2VQMS8rWndEd1ZUclUxKzIx?=
 =?utf-8?B?QVZNV0VGcVpDN2R3QTZuaFgyOTE2aThkMm9zOGlrbjhRS0MwSzRYREZ5STha?=
 =?utf-8?B?R3hCaDhid1ZOZ2dlN3FhZW1JcENIZjNHeDhjV3dVWUNVSkdJSjNzOUN0TjBo?=
 =?utf-8?B?R2R0cks5bEl6SStTYy9EVWVWTXNhVXBxTWE0RlRjQStmdk45YTkvbDFLMTdR?=
 =?utf-8?B?bUQ5a0ZCcytScGsvdUtyOVM3Qm5YQkpCQ1g1VkRqR3ZKZWVwMjlGbTM1cnla?=
 =?utf-8?B?a1JpK1RsWTJJaE1MSlZvSnB0N2FWVEVQQ0lSdlRlL3JUdVI5T21GWW50WHF1?=
 =?utf-8?B?bUlxY0JySkZkaEF5T2VsTFJmZE9kUjdLNzgwTmdlbUliUXI4VVdReHFsejJl?=
 =?utf-8?B?NWtMaGl6NC90NmFDeFNkT1N3ZTl0NDgrNkYzQzFjV1RXYlZFQ1AydE9nM1ZM?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb128bb-6ba5-4384-623b-08de10edc752
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 22:04:17.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaUJg/kcAOfyh871nkJ9FbN+QKtHKRoiQHaCcT9C6PPMlTzFQkD+n3pUUPOhdnaqUMiiLCJeq8pjom+fVt70jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com

On Tue, Oct 21, 2025 at 11:56:30AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Oct 21, 2025 at 02:39:50PM -0700, Matthew Brost wrote:
> > Drivers often use workqueues that are in the reclaim path (e.g., DRM
> > scheduler workqueues). It is useful to teach lockdep that memory cannot
> > be allocated on these workqueues. Add an interface to taint workqueue
> > lockdep with reclaim.
> 
> Given that it's about reclaim, "memory cannot be allocated" may be a bit
> misleading. Can you make the description more accurate? Also, it'd be great
> if you can include an example lockdep splat for reference.
> 
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  include/linux/workqueue.h | 19 +++++++++++++++++++
> >  kernel/workqueue.c        |  9 +++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> > index dabc351cc127..954c7eb7e225 100644
> > --- a/include/linux/workqueue.h
> > +++ b/include/linux/workqueue.h
> > @@ -553,6 +553,25 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
> >  						1, lockdep_map, ##args))
> >  #endif
> >  
> > +
> > +#ifdef CONFIG_LOCKDEP
> > +/**
> > + * taint_reclaim_workqueue - taint workqueue lockdep map with reclaim
> > + * @wq: workqueue to taint with reclaim
> > + * gfp: gfp taint
>       ^@
> 
> > + *
> > + * Drivers often use workqueues that are in the reclaim path (e.g., DRM
> > + * scheduler workqueues). It is useful to teach lockdep that memory cannot be
> > + * allocated on these workqueues.
> > + */
> > +extern void taint_reclaim_workqueue(struct workqueue_struct *wq, gfp_t gfp);
> > +#else
> > +static inline void taint_reclaim_workqueue(struct workqueue_struct *wq,
> > +					   gfp_t gfp)
> 
> Would a more direct name work better, maybe something like
> workqueue_warn_on_reclaim()?
> 

Can rename, but perhaps not needed depending on what we land on below.

> Hmm... would it make sense to tie this to WQ_MEM_RECLAIM - ie. enable it
> implicitly on workqueues w/ the flag set?
> 

I had considered this, and for a while I thought WQ_MEM_RECLAIM already
did what I'm suggesting—especially since I’ve spotted bugs in drivers
where I would have expected lockdep to catch them.

In my opinion, this approach is better, but it has a broader kernel-wide
scope and could potentially break some things. My subsequent patches
will likely break one or two DRM drivers, so it might not be a concern
to fix everything that breaks across the kernel. It's up to you which
route we want to take here.

Matt 

> Thanks.
> 
> -- 
> tejun

