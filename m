Return-Path: <linux-kernel+bounces-851832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E0ABD7652
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3D0034ECF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87DF280025;
	Tue, 14 Oct 2025 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgFVBviq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8226F2AE
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419003; cv=fail; b=P0bxByNKUO2tvDFgAU6h6dLk3mB+v+hyI8iEHcxFRyZ7KYJnHpn8KRb6yAgMppb+hXW9Jva1flLtFKDxWw6zbhHrl14KVrbeU1K393LDM4L1RM5Y3RdZ9uYmO9LfFP+VSyMOk9QV9i/EITCpCwAd86kgOD/oAJoDOQ0yWZx1mtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419003; c=relaxed/simple;
	bh=BH9kxLqZJL+FwP6H7NjuTuE0SFM/RdETashcNNFy1Qc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aXvAyZnlcEaTa4shhzJzWrRTSQLKnMdmIwv17qZ46D8QVCL1wcoGlA8Xkts8qys2oTAeAQYWYTpeHfQwgoVpS0lhZpKi0wtD0tnktq3vLlrAIIqgyvfHiCB1TPbG44ZDLPrB2Y1/QrUyhLnopa1LFVC3m/kTigKF+vYpyY6uUkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgFVBviq; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760419001; x=1791955001;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BH9kxLqZJL+FwP6H7NjuTuE0SFM/RdETashcNNFy1Qc=;
  b=KgFVBviqHe+thAI4T9+S7iFP7eqcOuwf8227Kp7YeasciRCloYmGUjYS
   5iumwrBs1uVQQoSymp01H05y5tWjZlASJ6ChvyNYpy3KESmmhNYgSithy
   GqqgAseMH9g2irnzUsgmQXBaEnitTlhwcwDU/5F5Y+Q2urAf8H1clKTtd
   Uji/yJv6RweUvmWYA6c4mG2cakJIx9EZMWfwYM+XFdbYEPbUL0LlXvd/U
   Tx8rYi1wA0w+DEs7q70ndsagb48BHDHFjoKpX2XL0A34NQmToQJYzpnMJ
   6J8AMP8fFhoGCP4L9YsuaSfV7SVdIWXU7aZIJKfnDb/BwU6SBMomYOlEK
   Q==;
X-CSE-ConnectionGUID: RsLV4nyJTzSXAh4yfnNw9A==
X-CSE-MsgGUID: u2NuwZhhQHuZWLwUIroB4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62606378"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62606378"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 22:16:33 -0700
X-CSE-ConnectionGUID: BSF8mKCVRkKl8DnQ3LyZQg==
X-CSE-MsgGUID: v/lorT9VRKK+nOPveGExDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="186038758"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 22:16:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 22:16:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 22:16:30 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 22:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBW65gTfytWhJ/nnN5DCpbl7EZ3QSIQzSw68YpjshWvZiPtMQOZGtwVcldLmDUc9xTA1vWIBV6C10ZJGFRLX2thqtWgtTFP13dr4x/AEW6EEBmIFvplKHt2P26GvLsVPHIUxIQWGm3AFwHD/hu01n5sDs2K8ILvyOIf8y+fzBR2wAcDtgrJDhnfUIJQ/z/Vw6jiP2DGttJuZN3ElG6W15duuqVono6GmdIIfPC73imh1Lel4sSwwSDXTiQOCCrwNzA/QvXwgwcpIIBAqlh0avIhfSpaNigMTkQtaThQ2RQulI2YuDL6vSdFPsil9w+6amewI88DhfVVvTLpXHFgSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Id+kJInOqQPAHmcDB7km9KDeteqNmxrCn+mTiBoQ5Dw=;
 b=Bwp+toRWOyPBmxD1R9e8dTkiTlrhSPK2qYkIephI/U0LL2dH19hxO7JfsBYHxgmFbU8XhVyaSybOEjxZMiN3YcTwz0nGllnP5J8MGiPpMOLSiz/KFLGlkqEkJNuQTzcflRc/ziZXWvwtjjAX4dG8FtugoL3QFT3b1G4DgnYeephYld7jFP9BfEn+7pPWw+vWwDR+jqIQ54Wm0QLRBdT+N1lvUZ8btJJWPrGlAHqqF6lvUEb8Zca9ILc/KeEvuMAdH3cdCj8X9VkByYMbQ1MKko3EGsg1jM5GW7nSaHn7E/7bmTgA8ekHEgaRXjnFxV+iMASg29BD3nYjvGeSmtl/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Tue, 14 Oct 2025 05:16:28 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 05:16:28 +0000
Message-ID: <3df5a8c1-7074-4fcf-adf8-d39137314fd6@intel.com>
Date: Tue, 14 Oct 2025 13:16:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] sched/fair: Assign preferred LLC ID to processes
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Vern Hao" <vernhao@tencent.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Len
 Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Libo Chen
	<libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <cfa266cd6ea6fa30cbf7b07573992f18f786955e.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <cfa266cd6ea6fa30cbf7b07573992f18f786955e.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PS2PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:300:5b::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY8PR11MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b166077-5008-4e7a-044d-08de0ae0d3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2p3b2lvdTBJMFBEeDNTa0Ixd1NwLzc2L0FLbUdGUjE2RGZsNG1tcXZ5SGF6?=
 =?utf-8?B?R3VXQmJDdmpzeHVrbDZUU1I2YTMzcW5kYXNoTmNYRmQ2czFvd1EvSzFTYkNY?=
 =?utf-8?B?U2JBSUEzNW1oVlV3d1pUaXdkWGRkSWtxQTlBbjNxcGN4Y3hXY1VRMStEbjBY?=
 =?utf-8?B?ZSt3Y2wrTGozTlNwN1REdGY1OTAwS21scWpsd0gzLzhCaytQN3dRQ3VBMVZE?=
 =?utf-8?B?QXF5WkxsNEMxNzBnNm54ZGFGb2doaHBSaWtGVXhpYnFBbjcxYzkwRzdkZTlN?=
 =?utf-8?B?S2Zxc2s1cWVzcUhPbTBnNW12ZVpiL2pLMGdhcTZQbUQ3Y3pEeHdSS2tZSDBN?=
 =?utf-8?B?SE16L1g1SFk5OG80MjJ5R2svUVhUTURPM3pHc3NKNUt0OFdRaWRhbHo5WFpr?=
 =?utf-8?B?TGxvZWVLUUQ5c2prNGM4cldUdEt3ZTAyUEdOaEdHMWt6ZGxsOUdsL1NNQWt3?=
 =?utf-8?B?S0t3RjI3cm4zaWpFL0t1MEg1T2srbTdkdXdZdkVQUjFGTnI4cnRqUzl5dkR2?=
 =?utf-8?B?VDgvOGh1d2dSZjc5MUJuVHZSRjFxd0NTM2xNYnNKdkF6K3g4SXU2RDNlVEYy?=
 =?utf-8?B?VmNBRms1akxoN0pwd3FKazg0R3BqWTduM2NwRzdoS29lYUVTbUUrNkN5aUZ5?=
 =?utf-8?B?bENzSTQvKzNGMzg5ek5TVFlJdWlhVkhKeFptQm4rcWMxL1NWQ3E3WDgvcXA3?=
 =?utf-8?B?VCtHSUU5MXNaSk11TXRYTjlidCs4WmMwU0J3QUZYdVhtWlBVcmJ2d2ltSlZx?=
 =?utf-8?B?em9JK09SV0kwblZ3MWtQOWNIaFFhZDFLTm5lbFppQXMxZ1h6ZFNoSDIxTjlz?=
 =?utf-8?B?eEpkcmdwT2hNQVBJUXo3eHBMU2NtY0s1SmNxODF4VTg3Y3JJU0JUbTdnN0JL?=
 =?utf-8?B?QlMrSGVJUll6dU1qWWtnbG1iZWV6RUJER1gvbzJEamg1d21OWVFCajRMYkxC?=
 =?utf-8?B?M216cndyMklYaUlaREM1SVVIY1hrTGVPNjhMQVloWUVFVzdDN3VHaVM2R2hz?=
 =?utf-8?B?VFlZTytTNWhXVFY4QjAxcUY5VjR4YWVFRTNaZU8va01WVEZ0K0cwcG1qcG1Y?=
 =?utf-8?B?bFlXeW53aVltN1FEaU5EU05JVXhIWTQ4a1lhYXRqRG5YKzk3Ull6aXN2aStE?=
 =?utf-8?B?RGpwUUF5NzFZT25QKzljVTNrVFdXSWoveVd5QUxYYlJDQ2Fsd0YxY1lWMTVm?=
 =?utf-8?B?Vnd2aGZMTUIyNWt6Y0Y4dDAzTm5KKzZyQ0RMTmE1TkV1QnN4RjQ5WC91eStm?=
 =?utf-8?B?bG9qTmx6cW1uSkZhcTlxR3p2WlVYUFZHVUZVVmVrZmlnaHJJbkNCc2VtK1Rl?=
 =?utf-8?B?cU8rd1RYODAvYjhDZXMrNWRUMFpmMnBNWGtUUW9seHloVUhPdlljMW9TWXc1?=
 =?utf-8?B?WjZRbTJERDFpM3hUc3R3WC8rQTVDK3ROb242U0JqVnduczZUZDBwSUJnVXlk?=
 =?utf-8?B?bE90UDdlOEhOZU5ORGVXdmFlT2szMUl6dGppU3lVVmY2OGdVRUtCOW1MaFJj?=
 =?utf-8?B?Z0VXZ0VYWjRsY3dZTWUrclhrc1pWWWdqMktwTFI4S3RPblRYazYwNXVKTmVj?=
 =?utf-8?B?ZmN2YnZXbTlGOHNlNVlha2kzb256ZHYxSWk4OHU1cDY0Vm1nRnQzSWgvZUth?=
 =?utf-8?B?RkR2NHMyaXBZeTRCd0czTWN4aXNDTVlEVXBqdWpFN2pkVC9LVHlmbHY3eTZO?=
 =?utf-8?B?NjgwRmN5djFpSkxyd3dXU29yUzVkd0QrZUtiL2ZvbEdJeXpPVHZmd25UMUVi?=
 =?utf-8?B?anFpaHcxcG9SaHc3N0d2dVRSa3JNeXZDcEpKbjJ4Z2ZlV1BqNFpsdUJ0VUJo?=
 =?utf-8?B?NmxvM2tuZWw4cUk2UGl0TTRtdFlYNlJCNWEwU2g1Z0NlY2hNVVZUZlIvYXRt?=
 =?utf-8?B?RGdBOXAxamIyYjNHaXNUNm1IcDVmcEhvcGFROWkwVEs5ZWgzTlY1eVo3cUNv?=
 =?utf-8?Q?ycWFVZuXQXfOQYkUP7wa+EUZqk8ngaAH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0RNeVlTeGI5ZWs5cFZScTFFWGtFL2N0WnV1Ym4wYWJvcUJIU0FLR0RkWjI3?=
 =?utf-8?B?RWpWczByR0E1cSszYW8vL0ZuQ05aUWZEN1lXc2lJYjUzUUE5N3BTTXpPY25h?=
 =?utf-8?B?SlBGaFRGOWdzcXlhR0krUE5KV0NYTXhYUDJDbEdIc2VDSWJXVU5wYUNXekRI?=
 =?utf-8?B?dVpyZUxUeHRZYm4ydFJoTlBWdlp2WmFXYjBSaTFUeVo2UFloeEFtQldrUlBC?=
 =?utf-8?B?cW4wZHcwOVVUNFozcjN3R3l2THd0T0IzcDRZd1IvYnhJOUpNbXFQc3Z4Y1JH?=
 =?utf-8?B?R1MwbzBhRktKNlZYZ0RVMTUvZkM4R1k0NkdGUTQ3ckJ3WEtua1ZSWVNFWkFP?=
 =?utf-8?B?UEN2ZTV3WS9CV1QzOGRmditIemllSWV0VjF2b3ZKZ254VUkzODVTblNLb1d6?=
 =?utf-8?B?bkVaZllwSFd3UVFlNjBKcUo1TDRoT0F5bXRvd2MwRTc1K3Zvd2cvRndCTTJ6?=
 =?utf-8?B?M2xBbStHT2JRRy9iOUs1MFRBbkI3UEwySFVGVS9Ja2o1c2I2dU4zallYK1Jt?=
 =?utf-8?B?MVNpWG1nb29wcStZU2lPTWlaUmFJaXIwS0Raa2dZdTVPbElJKzExUUhxVHdF?=
 =?utf-8?B?cnBlckNZdXd0c3I1UkY1a255WCt6cVIwbXl1WlNqeTFyOUN6b0g2djllYkIz?=
 =?utf-8?B?NDROVUZPemZQd2tvWU1wdEZ6UUtpRm5WNk5TL3dWcW1IYXZJK1ZqSHd1dDJZ?=
 =?utf-8?B?TjgreUlKOEhEbndvOElJOU5BR3BFZWJleUdJZmRYUzRHSkFaQkF4a1pCWVIx?=
 =?utf-8?B?TDU3THhRREVDamZNdG5zT1huUHZlMHN6K2xpVmZNMDJycWdSaCthanZvUFlr?=
 =?utf-8?B?QXZTalVxZkFlb3dUZE9WakRqRWNSMXdHMklSTE1DVWdOMnJ2cVN1aGJWZmNq?=
 =?utf-8?B?UmlZaGM4VmJ5V1pQbEN1SS84eUxBTGtiUGJxZUJpc1FEQ3hSWkdOMnVRUktq?=
 =?utf-8?B?UXNtbHA3NVE4V09HTXo3VW1yNjZocFFPWVFuRTF4Zy94NWU3S0R5ZXZrYWg1?=
 =?utf-8?B?c09XOExlaVhSTlVsUGRVbWFISUZYWTljSXl3NE9MYVM2ajJ3L0FCMmJGa0FE?=
 =?utf-8?B?d0F6OWJMc2g5T2J3UVNFaElJVi9PZG5KV2NCanFRY1hLUnpwZXRONDBtT3FD?=
 =?utf-8?B?cWdVVGtVOHZPRHc5cUxKbEhlZ3Z6SVNwUVdZRmhiOE8xTFlwY2ZxNlRrY0ht?=
 =?utf-8?B?Q0RvdG5LY1lxUGVHL0pTVWQ3N3JwR3FCVnFzTmV5R3JHT0pLOGJRTEdiK0NL?=
 =?utf-8?B?MHovcVJqTnZpbFNhK3ZyYkFkd0pMTGZqYk1vTjBkMXRaTXhxSy92QzF4MDh0?=
 =?utf-8?B?L1pjSllUajhra2N5ZFdqdlBab1VzcTVHUmFUZEQ3R2NieStwNzRtaTFPM3I0?=
 =?utf-8?B?aGlqMUNYMDM1S0lwSDdiSXMvOHN4WndqZWNHSCtmNlBRT2NWMUtvZXlwK29s?=
 =?utf-8?B?UUtySWhJcEJaWHhBVmFobE9YUDZzMUNOQy94Nk1BU3RGMU9CT1Vld1VWbTVF?=
 =?utf-8?B?Y213dytRelVUTmNteWJKSU16Q3JES05COVZSUXpNd01OTTlpdFVRc2s3c1Uv?=
 =?utf-8?B?Y2NPVjhFYmVhbC95TlNpWW1pc3ZXb0cyeDN0QlRJSjdvdkljM2pRSXUzdDlT?=
 =?utf-8?B?dVZPS2xNSlhjREowM0NCajV2TDJ5RlpaS08ya2NTbzhVcEFoQXdJanVzdVNT?=
 =?utf-8?B?aDFKS2Q4YW9GVHVxTnVpMWZuSTNJaU5hOURZNFF0anhLdysvOGlYaGhtWjlu?=
 =?utf-8?B?dWwvUUtPcEliRzUzQ29FN00xR3NGTXNZc3U0QmtDQXUvLzgxemIyMGZ1VkJz?=
 =?utf-8?B?RG5GbDRESXdOdUQzeUliZENsakFpcEkvbzdvOXF1TUdldUk4bzJiSkxENmo0?=
 =?utf-8?B?ZS9KRXFmZ3pGeGUwS3ZsenZoblBJSjhFYVd0bVhmWmpwc1ByMUN0djkrNUZy?=
 =?utf-8?B?S2hZYy9BdUxpUVMzVlBYUnN1TmE2aVRKRHJRWTQzTEViVUV6TnhUR0owV3lF?=
 =?utf-8?B?eEwvelZRSEJ6TUpNRDRkdkhJRjdPL0N2MVptZGVBeitGUlJBQXJObkduUVZC?=
 =?utf-8?B?V1pIaEtmY1pPTEN4UWJKU2I5NlBDRkRUSUFRS0NRZms4WVpDMXBrU0F5K2pO?=
 =?utf-8?Q?yCoRznGCKKxg5l5XkVkLg0uJS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b166077-5008-4e7a-044d-08de0ae0d3fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 05:16:28.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gz+7hkYN+e05qpdp5y3JrGLAWLxf8SzvsKTGXtBOYXLhhYEgX4wqtwSvBtOSwNVab4l6GoHclKLkxFc+437VyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7364
X-OriginatorOrg: intel.com

(Copied the question from Vern as the email seems to not reach LKML)

On 10/14/2025 2:09 AM, Tim Chen wrote:
 > On Mon, 2025-10-13 at 17:10 +0800, vernhao wrote:
 >>
 >> Tim Chen<tim.c.chen@linux.intel.com> wrote:
 >> With cache-aware scheduling enabled, each task is assigned a
 >> preferred LLC ID. This allows quick identification of the LLC domain
 >> where the task prefers to run, similar to numa_preferred_nid in
 >> NUMA balancing.
 >>
 >> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

[snip]

 >> +
 >> + if (mm->mm_sched_cpu != -1)
 >> + mm_sched_llc = per_cpu(sd_llc_id, mm->mm_sched_cpu);
 >>
 >> In high-concurrency multi-threaded scenarios, not all threads handle
 >> same events, so their hot data in the LLC is not completely shared.
 >> Therefore, if every thread's preferred LLC is migrated to the LLC
 >> pointed to by mm->mm_sched_cpu, this would lead to the incorrect
 >> assumption that all threads prefer the same LLC, thereby intensifying
 >> competition between LLCs.
 >
 > Yes, that's the reason why we stop aggregating to the preferred LLC
 > once the the utilization of the
 > LLC becomes too high relative to the other LLCs.
 >
 > If you know your threads characteristics before hand on which of them
 > share data together, you probably can use cgroup/cpuset
 > from user space to separate out the threads.
 >
 > There's not enough info from occupancy data for OS to group
 > the threads by data sharing. Perhaps an alternative if NUMA balancing
 > is on is to group tasks by their task numa group instead of by mm.
 >
 > That would incur the page scanning overhead etc and make
 > cache aware scheduling be dependent on NUMA balancing.
 >
 >
 >>
 >> So I'm wondering, why not move ‘mm->mm_sched_cpu’ to ‘task_struct’,
 >> so that each thread can individually track its preferred LLC?
 >> What are the losses in doing so?
 >
 > You would need a way to group related tasks together and put them
 > on the same LLC.  Either group them by mm or some other means.
 >

While Vern's use case is common in production environments, switching
to per-task_struct prefer_llc might not aggregate the threads to
dedicated LLCs. It is possible that each thread will stick to its
old LLC because the thread was forked there and the occupancy is
high on that old LLC. As a result, threads are randomly "pinned"
to different LLCs.

The question becomes: how can we figure out the threads that share
data? Can the kernel detect this, or get the hint from user space?

Yes, the numa_group in NUMA load balancing indicates
that several tasks manipulate the same page, which could be an
indicator. Besides, if task A frequently wakes up task B, does it
mean A and B have the potential to share data? Furthermore, if
task A wakes up B via a pipe, it might also indicate that A has
something to share with B. I just wonder if we can introduce a
structure to gather this information together.

thanks,
Chenyu

