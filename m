Return-Path: <linux-kernel+bounces-855498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F01BE1747
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66F114E428F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61269216E1B;
	Thu, 16 Oct 2025 04:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT2dDwtx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEFF8488
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590643; cv=fail; b=jgw4zCPhzgdvFjn3GYj9CeiprObcWMgUDEWPbh57lQ4/dhiqyu7pwHw7o58B6U7lBHMQb+6dbDBzsCsIihalfkjUu19WGSZlD8zpH+mDgWerzE+6ADWKfcljrZXewohsnqoQLjbrKKIRsRMMMBotD4lMF/Jv9vUFTjzwbFzT484=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590643; c=relaxed/simple;
	bh=Ei8ALA46cXKU+pU49YEafK1ACG3SCN94QJJsevOdIm4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GeCez75AvOKvG0JVjQg/+Q9WXJtnFphT5Tb+0gbo39XRbbk9jrSdshR2IB2gkDzrfWwvajZJ6TQDTWKuqszSPreTRUJ2MFMDgZXmmiuq7Zw568jKO7g9w4l7xn9gSX3zPDErfURex/YbZ8z8qhlxRk+Ed+vFdaOB74LX+pPGfbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fT2dDwtx; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760590641; x=1792126641;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ei8ALA46cXKU+pU49YEafK1ACG3SCN94QJJsevOdIm4=;
  b=fT2dDwtxFaB/28J9lkrGdybpmmOwNnfJonYlNAXCf1Zx+zc5QO9jK9NK
   jS41h68rOfu7ZtoHI9humFXMdZvNuMuAIRgKJ7ksMKol00jCbwaAEfztG
   1eZ2gQSzZ1+ImH986h4x4oAQdT0JC0JGUTEC0DVyT/aPNgRh+p5P0NLsU
   zP8N+cesDyOK1WhunZ4i5Hg+AZANr+lufE48+2WPo4GWNmp+J/c11hz3I
   Ohlatsjz/60DYfU3N8h4RpiolFJyrVaBalRwaHTHf30o7yqPFxg8p8K1l
   KhJZX77IXRRYQQzu2zG9mzKphtLgz9563hCp9F8vkOoxQJw/Vo3sLpfPR
   Q==;
X-CSE-ConnectionGUID: jjs1zC2RRY+Y/0hwyJktgw==
X-CSE-MsgGUID: s8/94aOOS4eO6JrcuD/o0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62923412"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62923412"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 21:57:21 -0700
X-CSE-ConnectionGUID: QhEtm3XjS02iKD3JBidvBw==
X-CSE-MsgGUID: YRYGBBz8TeCw/1LGNLFGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="206057146"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 21:57:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 21:57:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 21:57:19 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 21:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlNOB46T6sT19VXXToCiBlXWCoVZsPLmb9N/cOrlhDLTFmwQ042beYnSlrckY7ArV+g4onOQYhXCx5zsbxKMSH7Uv0vCxl/hILXzZCBwE9o3SQLxUeexOe8fsXtpaTeJaECfh/LVFgirVoSbUGkl/6o98ddym1UmQm7WUjsHB+GaC01NOiq2d+7i1sDpMZGpwBhUyVlv7Um7oy7Bn3b6TfSgnXoGGy+rVaFPJhDDvpbnZfc7akdjvaR+R37FwvKdj/5w/TIPhWUe9qQQSs+PVpOVP0gO3SzHpReGMwDwL2q0DMiuXISHzG4E4ioshXVwN29mPJEpCMH3o9cxja+olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw4Q4evqccdo89K8Hn2Tie4rGNplyOvS1LxSCwdYo4Y=;
 b=lIzH+SWZtyuyIL4NFuxruDsodyzbGBDFFti6D47rWBqrzGJHPg43NC5ZJ6iKzbfai0ljpHdiCeucWzm/k1Yn2kCuDnSeOzMJZLc2XTSpprIQeqg0R2g7pNYfDCVz2Yop0o9iED+PZa9Qji/NeJiEkerh1FbFiILk5UFUB2vZt8U6xgdyhm6/V5GUcOycwxzpZYRV73h+62GwKsr7dkAuo/qrHFijBzjFsn5i0Z/rp95rOY9xyrL61hWysWOtW5enHgaHelWsv0KQpK2me9G5uxqlx4rfbLtBUtevMwAU9+XWzIuGOptqrTLkeP9o6RcZeiqduCt0rpeDHVsl3n4V+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Thu, 16 Oct 2025 04:57:17 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 04:57:17 +0000
Message-ID: <7cacde40-153b-4814-8460-0805f1eb7bdb@intel.com>
Date: Thu, 16 Oct 2025 12:57:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] Cache Aware Scheduling
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Hillf Danton
	<hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan
	<tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown
	<len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, <haoxing990@gmail.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <a54c33fd-504d-4eb4-9b0e-ad4a3e2156ad@linux.ibm.com>
 <5b82842ff20995cd50b422dad844664089dcd0c7.camel@linux.intel.com>
 <a08e9fe6-c3be-4818-bff0-7ed350b3438a@intel.com>
 <218a4324-c28c-4068-8526-3f27a55a2e70@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <218a4324-c28c-4068-8526-3f27a55a2e70@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0056.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a9e82b-4b45-4fbc-244c-08de0c707b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVdBNm1aL0hoQTVPemVGZkkycmxoVGgxK1VKYXJqQ1lFU3htaXcwejVMZzZB?=
 =?utf-8?B?MmpxS0tWSkhWeG9zY3FpelFBK0RRckUzOVFxaUQ3SzBNSEtReWxldTVLS2g3?=
 =?utf-8?B?WWZzREtsdmRBbSs4L294aTd5aFFSSTRkVS9hSnA4TWdsbUNJZGlZR3RzSEhR?=
 =?utf-8?B?UXpoRGNDajMyd2hIUkZWZG9OeXRWRk5PNkMrbjJFZkVzaytKSFRmOTdoSmlV?=
 =?utf-8?B?U1JzNUZ2bW1PTGhzRTJIYzBMbFBoSTFyaXZkNzNOVE1BSmViaURaWDdjN3dw?=
 =?utf-8?B?RUsxeXV3WUEvWm1hRnJDUkkrR0w2S2dkQnhGekswdkgxL09ZYXRRclZRUWNl?=
 =?utf-8?B?dmZsZkpnc3pTbGcray9oc0hBQXAzSTdMVUhxZnQySFUzcldhT2UwRk5tb2ZD?=
 =?utf-8?B?WGFRWDFFTE16ajNrNUFUM2dzUUx2REttNDVrTlBKUG1zc0YxdG5Ta0k5VVdJ?=
 =?utf-8?B?R2lFL2JHSytuNTB1andIZHF0UmtrRVAzM2pkZ092VUhOZTRYQjl2RVVBcnkr?=
 =?utf-8?B?ZC85UFN3WCsySzRsK0ZEZUJZNnFqS3ZHTE1HTHY5elpqS1U3RlQzTStyU2VE?=
 =?utf-8?B?djM3MXYzWDVuelQ2MjBFWjQ4VHZ4Z25SNlgzQjRGbnpnOHRWeGp2SjNyMEhx?=
 =?utf-8?B?aXZUSTdiTmFQWTlWeFA2bHlKUVprR0ZCQnV1cjBrd202R3RBbVBaaG9CRHdw?=
 =?utf-8?B?a1BnZmRJVzg3SG1jbXlWdkVNVElwaXI4QlNFVVRNMjVMMDNidXQwclRJSXc1?=
 =?utf-8?B?VHd0LzFHZ2lpRGJyYTY3TDdhT0FHMmloWUFmbmNrTlBielNCcS9ZY0FqclA0?=
 =?utf-8?B?WXNDU0VlVkp0UkE0Y0NVQjltQ0NFRFdBQ3ZKUDloajgyZ1J4MWlRZVpnWmJP?=
 =?utf-8?B?WUFzcVZFQzIwelJZVjBEREVHcFNLdkVlc3dSOVJHUmorS3FaczJIaFIxQjYx?=
 =?utf-8?B?SERmLzJhNjVOTUVWcWxJZlVCalA4SWp3UU5XUnhBR3Z2S1NDNDBIYm1lSk9H?=
 =?utf-8?B?Z2RZVTVFZzcyTXRON003L3pzSjB3MVJZTEpONm1tZWZjMnBKT0FwRGtkR1JX?=
 =?utf-8?B?VE5MK2lJWS9QRGdNVk82dFN2anNDdHNpYm1teWJHaGVrbEl2VVFRTDhjRjBM?=
 =?utf-8?B?WFJ4VG5XTDcwdWhHdVloYUI2N2g3cU1lMVlrMFRxL1ZxWVhvVUd0dm84bFlq?=
 =?utf-8?B?SEF3WEJVSXpHazFld1VwK2p1Ym94cXFmUEhLdXNqVW5xbWV0RUd2dnNMa1RF?=
 =?utf-8?B?TjE2SitrelQzV3paV3AwZUlJdlptL3hUS09mclFwUHJ4U1hHV2MvNTNyc2ph?=
 =?utf-8?B?UTdhOWtRR3czMTBBSVMyNE9iTHo4VjUyNGdjZFZGRHd6OUJUWTVBUFpHS2JV?=
 =?utf-8?B?Z2tWTnFEdU1pNG9CY0dFRTVFeVlPaTNwS2hTU1dtdnJhemxiaEFabWErdHJ3?=
 =?utf-8?B?QXZzeVN5cmlSWXVNVnRISHhzMlpUVFd0NUpnNGFOYmgzYzFuZDI3bWpramdN?=
 =?utf-8?B?Nld1ai92WjRXVmJTUWdHUHVYR1VxQnJGTmlXN09XRWFLVVAvbVVialR4WEk3?=
 =?utf-8?B?TUlDTXM4cWtROUJSRGEraHhkRkhVUXFWcVZzaytxWThscFFydmZNYUZ1NjU3?=
 =?utf-8?B?WnR5WFVXWjN5WnJQVG85azBhTFhlSCt2ZnltQnpqbm5oNFRNYnBLam5kREN5?=
 =?utf-8?B?ekRuZU9XQTRMSFhrTm41QVczWmw3NXBSVlRmQTB3OUE1Y2hpWUxiZ3dCVE9U?=
 =?utf-8?B?VXQ5dXRVN1ZvaVJaRCtGMEEvT0g0UkFsTmd5bmxRUitncmdqWVJrQWxlbStP?=
 =?utf-8?B?ajNuMDBmdmlTT3Zkd3BUdTljZXZKQnNWNm42MG84Z0s5Y2x2bS82SDZ2YmZB?=
 =?utf-8?B?K3dVeU11bnhUaVVsWERxajZzcS9OUmNCZW5jNjl2cjY4a2FMcHlady94eHRq?=
 =?utf-8?Q?jX+kbMgvEo0r8CIJVWpqX4siCChZAnM3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRKV0NOb29GZDVvQUxHSFRiMlNGcGxiYkZMY0ltVWFydisxTkZRNlpINEpP?=
 =?utf-8?B?dWhCQU00SUhRYVJ4UWhiU29DYUVqNU1GbXBsUGg0VVVxTjZRaXFWaG96M3hJ?=
 =?utf-8?B?OHJEMnlKSGZNWkZYREFoamRnVE40amtEZzBaMTV1VFJYRFdLRUVVY1pVSTg4?=
 =?utf-8?B?K042QU5PVUJPTGVONmVxNXNXM1BzdmptVUVTK0NjMFlPUDhhTGtGSkxMVmt5?=
 =?utf-8?B?NU9IOFZFVEZEeVhGUm5EZkRzdGFCZ0ZtVVp1elJHdkFaNytRK2ZGUVRtWG0v?=
 =?utf-8?B?QXovVEtuMFVvVHMzOUp0Z3RocXQ0Z3lUMWlsaHlrZVgzKzJtR0pIL1dlNXRD?=
 =?utf-8?B?R3dISUc3RFNLbjYveXUyUlRkM0xOczljVDdDWHNXKzBlVVA4RUpCRVhKemJl?=
 =?utf-8?B?M1BPR0ZKSFhpMFF1VDE0VzZCMTd4S2UzdVdGdnpqa2hiZGl0K215NVU4dVVR?=
 =?utf-8?B?ZjdxY2dKUDBXSTFCSThKSVprQkZkSkVCT2Q1bHdHSzE2d0tLTHpITTQ1cmdI?=
 =?utf-8?B?RU53alN1L3AyaTdrUUJUZy91ZWg2NWFncXMreTNvYmcvUVF6QUFHRXNpUHZ2?=
 =?utf-8?B?U3Y5cUpCOHNzRTFYMjZEczdKK1NVR1A2b0t3M2dmT2hxOG9SR29sOXZQRVc2?=
 =?utf-8?B?K2U3TXQxMVNCV3pTaEJVRmN6VVo2cXFSeUZ6OEt0RWlybHluUmFDSXd0SHU5?=
 =?utf-8?B?eGV4cmp3V0pUWGxDY0JEVmdtUG94enNDY1lhbytIZTFUUENIVzd6WlV5RVE5?=
 =?utf-8?B?TG01WmNPa3Fwb3ZGY3BGZ2Z1TFZuYkFBNGdaNkg5elYrMTFRbEk5bU9makdo?=
 =?utf-8?B?ajEyL21NWWZTTjluLzQ5M1dlRkVzUlJzNXlBV1BPcktFZmh4bWsvZTZNbFVR?=
 =?utf-8?B?R0EzanpMN3NMbXBSbDlOKzVsYzJLN2hpSDI3TTBiTDg3VFk2ODJ1R1U2ME1l?=
 =?utf-8?B?L0hya1FIVjJWMkpjQUVpYmRQV1IrNmJ2S1dKcXM2RWdwLytzUGhtRWpIWXBO?=
 =?utf-8?B?K0xEQ3gySUJkS1dkKzBrVHlZeEhUdVlzVExrREVWaGFWYlhuQUQ4NGtTWXlY?=
 =?utf-8?B?eE4wTnJkMC9mUEZXdjc4Ny9tbUNvSXFNL2pTSG4rejRqbXZPYklWb2czWG5J?=
 =?utf-8?B?TmttTDBDdmU3cEJHTjFqMHJlb2FXakM2SXJSWGIwS2htS0dEcURKdGxGV0tw?=
 =?utf-8?B?MFNRRGpEQXk5eEVUcnpjeW15WGF6a0U0dUdMSUptSzM4TjFTSzdtWEhpVXl5?=
 =?utf-8?B?Zlg5eFdMb1BTRHpMTGJyaVZDaXN2cC9ZS1paZFhkbzFaRFZ5dFE4VDViTXdv?=
 =?utf-8?B?bHdITGlvME1wRXB0cmhOcklWdW9kdTNhcTNXN0pDbjdwYS9IOTNIbnlydy90?=
 =?utf-8?B?Q3U4ZWZKUGpaSWpBODlEblVURHhMejZTWVpYd1RnQzBsWWRMZGg5eXdzM2d2?=
 =?utf-8?B?aFFibGxiUnNwb242ZFBjSGJxeGZwaGo5NE9lV2I3dGU1ZnlOTlc0U21UU2Ez?=
 =?utf-8?B?Tm1penQ3RWZHV2liTVFZV1NoeW9hZ2x6RzJrZFc3QmNiRHpuZEU4Z1B4OXJ2?=
 =?utf-8?B?NWRUc1VBbStybjVJaUczMEVqWFRTTHFqdUxpQUVHNXhIb0k4N3E5alJreFVW?=
 =?utf-8?B?YkZ4S0JIekt1RkUxZE1RelRhVlFaL1V6VDFCelZiV0dtc3RFbUs5SHVUUWly?=
 =?utf-8?B?QUdQWUNDdXY2dnRzWGlpRUZNZmVpazBjQ2VQalF2OUFVLzl2UUpTS3BDaTA4?=
 =?utf-8?B?cG9rN3R2bkVaUEYwck83blFtc0tERTUwWTI1TFFEdHhaQ0tKUXkvTVkzOFlX?=
 =?utf-8?B?UG9heGlLWktHOEh5WHJocWNwRUkyWisyMUNlTTRUTkErSHVDWHAvTm05QnFO?=
 =?utf-8?B?RkJWamhtWjh5NGhTcnB3dUpyYkpvNUZwTUIvR3lKWkswT0s3TWRQZzlvQ0pD?=
 =?utf-8?B?YnJsclB2MU0yd2RoaDVYclVKRm9qSzN6S1BTZHNpVVhtdE9uMVJ3V09jdWph?=
 =?utf-8?B?dTdnQUYxZWdKSU1EdnV4RFNSSEZMZWM1ZDVRYmNqUWxsMzNhYnVPbWtQMGlJ?=
 =?utf-8?B?K1V3M0lnNzdnOVNnYmtRZUp1bzh3NkJOQmFiNi9qWlMrWFM5Ui9HenIxaDlQ?=
 =?utf-8?Q?0jibISlxLEbvLzRyMLjDFgHmm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a9e82b-4b45-4fbc-244c-08de0c707b07
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 04:57:17.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnaRd7BsvvGBqvI6CvjKcl4EPjmpuXozCLaN4Dj1bN2Tk3pLDq7hzIJWrzAHDpcij7woe85iluPgpxOMa0CKdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com

On 10/16/2025 2:26 AM, Madadi Vineeth Reddy wrote:
> On 15/10/25 11:08, Chen, Yu C wrote:
>> On 10/15/2025 5:48 AM, Tim Chen wrote:
>>> On Tue, 2025-10-14 at 17:43 +0530, Madadi Vineeth Reddy wrote:
>>>> Hi Tim,
>>>> Thanks for the patch.
>>>>
>>>> On 11/10/25 23:54, Tim Chen wrote:

[snip]

>>>> ChaCha20-xiangshan improvement in Genoa when llc_aggr_tolerance is set to 100 seems
>>>> due to having relatively lesser thread count. Please provide the numbers
>>>> with default values too. Would like to know numbers on varying loads.
>>>
>>> I'll ask Chen Yu who did the Xiangshan experiments if he has those numbers.
>>>
>>
>> Madadi, do you mean the performance score number or active thread number
>>   when llc_aggr_tolerance is set to 1(default)?
>> The score is around with sched_cache and llc_aggr_tolerance set to 1.
>> The active number is 128 per process, and there are 8 processes when
>> launching the benchmark. I suppose the 128 comes from the number
>> of online CPUs. Please let me know if you need more data.
>>
>> Cced Yangyu who's the author of this benchmark.
> 
> I mean the benchmark result with default value of llc_aggr_tolerance on Genoa
> in comparison to baseline. Knowing number of threads also helps to understand
> the impact.
> 

OK. Here are the full test script and corresponding data:
pepc pstates config --governor performance
pepc pstates config --turbo off
pepc cstates config --disable C2
echo 1 > /proc/sys/kernel/numa_balancing

echo NO_SCHED_CACHE > /sys/kernel/debug/sched/features
make run
sleep 5
sync

echo SCHED_CACHE > /sys/kernel/debug/sched/features
echo 50 > /sys/kernel/debug/sched/llc_overload_pct
echo 1 > /sys/kernel/debug/sched/llc_aggr_tolerance
make run

echo SCHED_CACHE > /sys/kernel/debug/sched/features
# to encourage task aggregation as much as possible
echo 100 > /sys/kernel/debug/sched/llc_overload_pct
echo 100 > /sys/kernel/debug/sched/llc_aggr_tolerance
make run


# ./launch.sh

Host time spent: 51,323ms //baseline
Host time spent: 51,741ms //sched_cache default
Host time spent: 27,934ms //sched_cache aggressive

thanks,
Chenyu


