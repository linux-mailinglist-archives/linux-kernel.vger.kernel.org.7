Return-Path: <linux-kernel+bounces-866250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6FBFF4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A168C4E5664
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31B279324;
	Thu, 23 Oct 2025 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG3UmMSM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98F257845
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199698; cv=fail; b=s3FQ1nP2RNL/XF5GrefZbjv7LtpHxTAx+kyYOENeh+a8CBU+GkLlKZ8crnGOzun1/wol/YjlZeoVVlwKZ9WBitZjCuErqWzvO1Os5ODLeurY1Ek5ffDgjeKAt0rW5lqs+Ofk9rZjVpuTsaGiELw25UAuxPSEd1CT6G1G3F8gtbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199698; c=relaxed/simple;
	bh=E3a+f+KxrAXn2VsH8gONfRHY5vjdptRzg22L2BucloQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdI6PmqmndCN3rb9yjv51GH4Diwhz56NiOONCa503hZA73SGd+cY9ANAqi4qOyQrk5D8Sl0To58mI1fvLtteLxQlRXjmSo10yRj8xHdMPliYJKsx9drYnRm3GATgRuzCQ+TcsltxVQdfIpl+7mWXKf699c3d4KSBekTo94Hh1Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG3UmMSM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761199697; x=1792735697;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E3a+f+KxrAXn2VsH8gONfRHY5vjdptRzg22L2BucloQ=;
  b=SG3UmMSMAvijVPj6z+QVQiW5TqoeLgsX9U4WFiPtR+FnmjC3/34H5GXu
   T2cWPGKd0uSXC/XgmHmKilOcbBwm8bxqJzCf8cDcR1+gYhPlHtt1d7RHL
   eZsHIp9WTgPr/M46DxbCQ4aj2ke0ZrgVExyTM5djE6GRItKQyAy35xdw8
   KZGtllUuf9IHULOjMVdGVAmFZ8XOOMpEWmDNPGQd8EeH32ywQ6NT3QdFr
   dA8Cv99rxtjazzIlcmz7O9sjdG/+RQVgrWRVrhUYATVbIQSneKhEU8pfy
   cPfmLbx9BRjb0aju3GFkFd2WxiY41uAAHTjXhW1f8Ez15x0A+D7ky3xrW
   A==;
X-CSE-ConnectionGUID: WyHpLnFQQuqBkOqxHr5O5Q==
X-CSE-MsgGUID: 0bKbVsjoTBWUmSIH6T8bmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74797303"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="74797303"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:08:16 -0700
X-CSE-ConnectionGUID: Oxn6BoyETS+FujYfG9fHFw==
X-CSE-MsgGUID: l9PsBYqxR8mEG5GYHrx6hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="188118256"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:08:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 23:08:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 23:08:15 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 23:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ35alHeUpGS0GL/rL17Iz/RSZ6GtVpaIH4idPZjyn+3SwMhdDwu5HwjV7r+ochOH4pGcROvz0r9Lt4Dg6nkEWdHhjX3M0QSq0TN6nzCu1YUbH7xkkGOQ2mV8Dk2PB62QhcI86d9Oam2kT/pz1SkREbhcAKilST5D0ab4RisKtTujfAFAIewgsjoMNcx6Mfx/+JwE1zXEX0Nw3G1G0qcZk1iuJL1t+DL4x7ltl3sBQDaHM5wZ0w6UBxNagj0rzv5x321/kCZFw+qSsjb9R+53RUC/awJknM1RLMlXXSt0zefNBB2g4MXYF5BaWWDD5krVsp+LH8UwtFlZRAmSkwXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYiaRnrd6MwKJm7prHHLD9Go0Uj9EYQBDYx+zIF5VH0=;
 b=uX2qkv0MqDhiznsNRxKjs6hF+pFnNnwajnUxoEG5fOFAnZeL2VMO/0IG0jauTWFt40/g3OTMLtVjGKreosXjtUs5cyWdisQr5EFXsM2+rEp931B0PIh9j3GSiyJBdLYHH7m0MCve0j0F6Q4o3jksbdNpLc0KvGaSwlTkX2oSJzFwpq3QgVHfnf2dU9FxGNNNV9usr+C263q6SsvXJ4XVSlvnuW4/BsdoS31KbAOPSIUqYbUjlOrAzbQ5nUxJvRc84kPlNSgtD7918M0LVMuiMhGae+rEaOEHg8/Qmdt4pf4JPO3IX2mY5JXX/pTJc4zreMyRpeEtcEb6sPNmfmYdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 BY1PR11MB8031.namprd11.prod.outlook.com (2603:10b6:a03:529::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:08:13 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:08:13 +0000
Message-ID: <68a7c8f5-25d8-4cce-92f4-99dd6a50add3@intel.com>
Date: Thu, 23 Oct 2025 14:07:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/19] sched/fair: Introduce per runqueue task LLC
 preference counter
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Hillf
 Danton" <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Jianyong Wu" <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len
 Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, <haoxing990@gmail.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <a002ffc53c06bfa0ef0700631b0cb5413bdbf06c.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015122125.GU3289052@noisy.programming.kicks-ass.net>
 <782009c48dbde2cb2912f4d5dc573ecfbd2c1087.camel@linux.intel.com>
 <a31003cc-fabd-4c18-9603-7763ec1e92ea@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <a31003cc-fabd-4c18-9603-7763ec1e92ea@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|BY1PR11MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f827ffd-25cd-481e-2d26-08de11fa8c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE1oSnVHbURaVG9qeVMrOUd3RTRIcTlBSzRLbWZ5bjJNdzdhWmhMRWM0SzI0?=
 =?utf-8?B?OWUwS3l1cG4rMTlqNjlPYUNxaGVOMGJYN3ZrZGVxeGtvTittVnVhczJ1Z0Ey?=
 =?utf-8?B?Z28rUFoxRXR6S2dUTGo1aEYwdmFFTUh0Qkc0dDYvUEtDOVNPcTJzSmIvb1Ra?=
 =?utf-8?B?a3hTc1N1SG9uSFErcjEyUFZOclQ5eXN1Z2xDU2RVZ1d5L1hhVC82bmJUK3JP?=
 =?utf-8?B?d3lwTUJxSlZ1Q1RIckI4VGJPQXBlbUlERTROdTc5SUVxQVZXaVVuOUFCa2JF?=
 =?utf-8?B?Z3Z2eHh4TVJuZ0xsaVdLeHRiZ1FGMHI4SDR2TTFOYkJWRk96a21KTWVEbk1q?=
 =?utf-8?B?Sjl5M2JWaytMZmZvZWh3YjNSWTR5RHZBTldPdWNzbHBVSVVZTzY0bU5MRXdy?=
 =?utf-8?B?M2ZKUnphci9raXB0SENmemR2WFJ2VjhHU2hka2lyaEY3TWtqZmVlS2FVUjNX?=
 =?utf-8?B?MXlqRDl6K2ZTdmhrem5oN1JPRG9tWWRRb0ppbEMycmx5SVFkd3NWR1RaTG8x?=
 =?utf-8?B?UXNFMVJhVHREaVNZelc1eWRIOFRpQlAwbmZHRENuS09oNnJWWlBlODRjZkxV?=
 =?utf-8?B?bXQ2OUtpdHdCdWRoQnhJVjlmTVdRRmUzOUlsWHl0MDVjWW1PcmUvSUFsQVht?=
 =?utf-8?B?bVRGajBQUWxzMk5LWGJ5Z0QyQVJnb015R0diLzdJbUVhOVdLWkFaN0YrNndp?=
 =?utf-8?B?ektvUTRJeGxiRnowZ01kVTZmdVFFYzVCNUVtM2ZxWCtrUCtGYzBpUCtVWXZY?=
 =?utf-8?B?Tk1Ham4yS1NIeXJTdEtydU1EZE9mM3kyM3NVSXdjRmJTNVhUemI5QWxYMlFJ?=
 =?utf-8?B?ajA5dHhrOE5vb0VtM3kxRUlwSjI2ZW94SjROMnpIcERmWkZmMnQzdnEzcDUz?=
 =?utf-8?B?QVUyK29sUE0yOEthK3dnY0hPTnZCZjl2Si9GYzA5M3l5N1NHbGJKM2lBZk5G?=
 =?utf-8?B?amZWQmVLaTkwclBEdVBSMnVmUmNYNUtFVjJNR1dJdXBkWkpxT0ZrZlR5ZjFt?=
 =?utf-8?B?QXdkanV6RXppdW1IZXlPa0xtb3VQNFo4eGNkekcrOXNzQW9iSFNDaUpCSnBD?=
 =?utf-8?B?NjNLdE5sc2pBUkJzYTlRS0Y2cmRvK0JXUGZ4ZHZ1VEMzT1A0a2NoMllJZTVD?=
 =?utf-8?B?eEdycDlqdDdocW1YTUFCMWJRUXRQYzNvbGFpYVJlRnlaYnRCODZ4ZmFGVFVy?=
 =?utf-8?B?eEdGa1JPYmN0RnJieVl4dFBJOGFieHZqR09CZmpiaXF2aWVWZzFkckhwU29H?=
 =?utf-8?B?M1NmUVZON2diVGVnZEloTjlVR3UxN3BNQUZTWHpZRWdRejJ5Q0hUYzVnQlVN?=
 =?utf-8?B?d2NhbWFwNXJMR3pWQk4zbmV0US9INGwwaWdyekV3ZkI0bjdvR2pvdzB2Y0RS?=
 =?utf-8?B?TUFsKzNMdTVSTlRrT1paakVTT3ZRVkNldTBjS1FFZVVlK1QwSCs2STlGQjNO?=
 =?utf-8?B?REtLQWFJbDUvaGJFdkFkRGV4cUhnaU9SbXUxL3RpS3FpMXR6eTRrYVBsZW0w?=
 =?utf-8?B?NkUySkNBbTFZaDFPVm9HNXFFSE5WRkVjTFY2N3hsMzJLSVlNdDdabEdVQnUx?=
 =?utf-8?B?RE9qMmg2Ym10VkxhRmlkS0VZdzc3UjVoR2taMVAxU2tzb2taNXpGdWJJNWhx?=
 =?utf-8?B?Zys1YWJTbEkyWDY3Q1JWbGFad2xaRHd2TUw4Njd4OEhyZzN4UDZZT2QrZDBB?=
 =?utf-8?B?cUdSSzRnNmUzRlFmR1F2RDV4VFdHc01nRFNsa3ZFZUM5SjNOOTVkMFZFSmpK?=
 =?utf-8?B?ay93REU1Y1Zrb29CWkFacmVsWFFBRmJtbkdrQVhZbDlkVFNxMC9QM0JMYlNH?=
 =?utf-8?B?aDYrbE9mcStFSmdnS0VQQlBRWVNrR3RJQzM4VHhLN1o3ZFRtSXFYbG13QklC?=
 =?utf-8?B?cEp4bzlLYjltVmlCTDJ0eE8vTGV5YXEwa2x4UFB4d0h1VnZ6ckRJZVk3RDQx?=
 =?utf-8?Q?DpgAczNCpvtSZCbCtFKRLeuMlcOGdq+S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUtMK0s3aEdpTi95Q2UwU0MxVWxKeklkNWZxOEhrVmY5U09RUWRqSzVFeEly?=
 =?utf-8?B?cnp5VmZvb1EwSWZFTklaRCtWOERWRXMwZ1FCQ3VJWGV3NW5sTjJIaHdrN1Nw?=
 =?utf-8?B?NkVWby93MDMrdFhuNGcrbXMrSlREbC9CSmlvUUVKQVY0SzZGVVVYWjZHd0l0?=
 =?utf-8?B?VDRXb0FmeUMyd1NSUVlTVHh1aFRUMHJud0VocEtud2U2dFRrS21DOXZTUGhB?=
 =?utf-8?B?NVpWaURvRjlYRE1rOXBPTG82V3piYklNNWpycG1rL000b2NSb3E3WFVrTmtH?=
 =?utf-8?B?b3kzcFU2S2JQK01vdm1wdlFuTVQ2VW5lOEVkUzhrdFZHVHZOck5MTEZWL01Z?=
 =?utf-8?B?SEdLRE9HeEhTdmY4elhSVmNuQ1lQbWdMRldmVTZwU202emt1enpOSmJyK2Zq?=
 =?utf-8?B?b2FOL1hZSURmelMrSUpDNjFlU3YrcWlRL25ydVpBajlRenprbitrMnFxT0JM?=
 =?utf-8?B?WnVSRkpTOS9CT2p5N2prYWtNNXZ4OTZxczBRTDQ3K1kwWDRqWmQwYVdSOVNX?=
 =?utf-8?B?N2V5Z1F4NWtqUEFhalRIazJPQ3Focy82ZGZleEVDQXlUdkpSNytiVHJOMitB?=
 =?utf-8?B?aEdYNU40Vk8vR0RvZEEvanFlbnczVUw3Y2hkZGZBYXFPY0RGWTNDeXVoSVZN?=
 =?utf-8?B?dXRJcElMSFg1NTN1RFEvQjdiYXhoTTNBQm1vaklGcUFPdWpZZWRxVDdnRndm?=
 =?utf-8?B?aHZscjdCMUtpcnJuU1ppUUhzclBwdW1nUENySW1XVjlVcGtVTFVKZGYxMmxO?=
 =?utf-8?B?MWszTlZ0NTBIakE2NVBQWk1DUEFOdzRpdVlMZE1uTWV1Vm0vYlp0ZjNpUTN1?=
 =?utf-8?B?YmltQTUxNFVhTVVwbjJNWVNUaDJnWllWcmVWRXFuOEdYek5Lem5NenMvdkc3?=
 =?utf-8?B?ZUJkVVVIWDV0OTZXU251eDdMRlBWN0I3Zm01emxuTXI1ZTlKOURoMzlOKzdY?=
 =?utf-8?B?QmNNOUwvbHNsUEJWV3FyV25tWFFmSWRpeitNdmdRbVQrV1I2dnlHYkFqUWVM?=
 =?utf-8?B?azRZb1R4YjRBaW9LWkZzSGkwdHB2bUZQNGJnaC91czlDWW5BMktUdkhhdm15?=
 =?utf-8?B?Y0pJWGVRb3ZKOCtveTF2M05LVjI1RERaOVZBMTIwVDRRbEhZVW8rMWl4cGpi?=
 =?utf-8?B?bElqdHFHWmlITFNJRlVwL2gwaExiQUFaeGFTdHcvY0FQYUthVjJLUkkrSXhn?=
 =?utf-8?B?UU0wY3o1VU15N1BnWVVPL1VuajRGWmxqVVVIVndNdndhRFlDL2FhNnhRUEtG?=
 =?utf-8?B?MHpGcHBUbmJXSWlyWDRFdlRSTmE4dnhnVldIeS9EUFJYUWx2SGVkMGQ5ZGxi?=
 =?utf-8?B?TFRpL1diZ0dRTEpFZlFFZ29GQ1ZXa2hVa1pyaE1PNnBMakZRbmJ5MWdMYlYv?=
 =?utf-8?B?QVhHQUIyQlJia2lKK0tFa0FHT2MvamZKYW02Wm8rSGttZEV5SWFmbG82Y0hS?=
 =?utf-8?B?L0pxZGsvaWZXK1FCaXpVallKWEtkMkJ4Qjl6d2I1ZVJTZTBKYXlFY0UxY2dm?=
 =?utf-8?B?MHpGL0NQN3R4ckRwK0dHNjhGd0UxSk55cmNhN3RiRkFXQWZTMVEySUo5bW4x?=
 =?utf-8?B?NzQrL1hRZWNjejIvQ1U3QUJtYU9Pc2lFaFY1MVpiTTVTMHdaenVsM2I3U2Uy?=
 =?utf-8?B?Y2lkK0VOa1lkbStvN21rdGxsbHlyYVR0VlpYbERZVm8zZkVoY0wzODQwOEJw?=
 =?utf-8?B?anAxVTF5aHhHWFIxbzlqOE1aVld0QWJwVzZQbEZyNitKb3liUnYvNjBqNDV1?=
 =?utf-8?B?MDBSS3hSNE05VXhmU21RWWM3bjNBNnY1R09PTkdoY2hFZUpxdWEvRDJ3WmN1?=
 =?utf-8?B?UUlHNXBSQWxaQS9uSlk3andPSXcyWUszNU9BRXd1R1B2eDlUUTNxWG1UempE?=
 =?utf-8?B?aWd0c3FKNXJqZ2VsMmZGV2hkV0twc3pBd0x1elp5cko2Um4zTFgzZmNvRkRk?=
 =?utf-8?B?V2hpdFpFclFhdjduSkhOVEJTRGVrKzJEYlVPRE91eGpOc29MNnV6ZGJJaEtZ?=
 =?utf-8?B?OGhlbTZLVHgxTDFVTE1UUDJNSTNaekNBK3czK1F6Mk1QQ1grWU1vRHhORGlx?=
 =?utf-8?B?dmZhT0F4R0FiQzNia2VsdEZEdVpMbGFFSWxVN1l4S1Qya0JISzRMdy9Iem9l?=
 =?utf-8?Q?QTVzBzrztI/MbkRyywRG7MW0A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f827ffd-25cd-481e-2d26-08de11fa8c75
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:08:13.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmjFCYSZ6UxHZWdrmVSc7auQliCLDI7lyTn/2QdLeo/2Iau5z7On+apmS2jB2ypF3fQT4zUY1Bn6JvBm7fDRIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8031
X-OriginatorOrg: intel.com

On 10/21/2025 4:28 PM, Madadi Vineeth Reddy wrote:
> On 16/10/25 02:11, Tim Chen wrote:
>> On Wed, 2025-10-15 at 14:21 +0200, Peter Zijlstra wrote:
>>> On Sat, Oct 11, 2025 at 11:24:45AM -0700, Tim Chen wrote:
>>>> Each runqueue is assigned a static array where each element tracks
>>>> the number of tasks preferring a given LLC, indexed from 0 to
>>>> NR_LLCS.
>>>>
> 
> [snip]
> 
>>>
>>>>   
>>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>>> index 3ab64067acc6..b801d32d5fba 100644
>>>> --- a/kernel/sched/sched.h
>>>> +++ b/kernel/sched/sched.h
>>>> @@ -1101,6 +1101,7 @@ struct rq {
>>>>   #ifdef CONFIG_SCHED_CACHE
>>>>   	unsigned int		nr_pref_llc_running;
>>>>   	unsigned int		nr_llc_running;
>>>> +	unsigned int		nr_pref_llc[NR_LLCS];
>>>
>>> Gah, yeah, lets not do this. Just (re)alloc the thing on topology
>>> changes or something.
>>
>> Will have to think about how to keep the tasks' preference
>> consistent with nr_pref_llc with the new array.  Perhaps
>> make it size of NR_CPUS so we will allocate
>> once and don't have to resize and reallocate it, and
>> fill it back up with the right data.
>>
>> Tim
> 
> IIUC, what Peter meant is to dynamically allocate the array size based on
> the actual number of LLCs computed in build_sched_domains() or somesuch
> rather than statically allocating NR_LLCS which is 64 by default.
> 

OK, this might involve dynamic adjustment/data synchronization of the
nr_pref_llc buffer during CPU hotplug, and we'll make some modifications 
to it.

thanks,
Chenyu

> Making it NR_CPUS would be even larger and waste more memory on systems
> with few LLCs.
> 
> Thanks,
> Madadi Vineeth Reddy

