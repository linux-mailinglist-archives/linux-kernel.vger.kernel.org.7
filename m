Return-Path: <linux-kernel+bounces-751426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C0B16984
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5761A4E016B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1B238159;
	Wed, 30 Jul 2025 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mubuceh5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058641760;
	Wed, 30 Jul 2025 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919861; cv=fail; b=Mx3h5EAzhyUUAMxwovSJjP1shNRpWzzGhb/0v+bgh7XqK/4+nv4DlJjVqjopzlvcdw/wnhzv4eOSRNKeMZopet+bESYeC+3B3bx5mt+Y2rmoOzVa2N7Mu2z8S1ntr/xvr1H+yv9xf0SdIEwdvryahfawcZQOZNiLqeTqrPGJpVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919861; c=relaxed/simple;
	bh=Y8zNRCgnBRP/+OI6fOW9TactPedjGLZ11g3TDrwOBzA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ssz6NaI1rNWfkttTxsiE18T/mq18ic2W2qzV5IfElbRifwBzmNUPHlrO1TILWmtkZZTiyaADsy5Eio+5IkRZRMW0YMWIsP2fJnNrld1SHGPCzqTi+HrJ/+YbYgsWz/thsBD6zVLBXL7k5HlM7QjE6f529gsiv5JgrdKwWtlaIhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mubuceh5; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753919860; x=1785455860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y8zNRCgnBRP/+OI6fOW9TactPedjGLZ11g3TDrwOBzA=;
  b=Mubuceh5Y7rHPBO06ifS4cqZQk0ubk3T/ty6jm2r4wF1xv9iuvMkx7BU
   tB7woTNi2bnrpdoRzLV1Xa46FcH8gytSHhmvm4oSZ3XstOg3f09Shbgev
   DRBVHtmt+oo0AlBcP8DZAah7jlNoq01pM+JEK4ywosB4arlmpsz7I5rvH
   KKLLxX0pQPqXr8zGz/yLuAc+xe0y6LQg1yejprkk1YrcQRwG0YQAUFwEc
   KsgySxDGHWuN2Rpce3LakDQgvaz/sfX4FbNXyHW/Hdhh0qwrxcUSZEQim
   Awvv9/kmKv7cvptPH59/0c+xxZZzYQgfrGLlUcpwIvFptTW9hGSjy8c4x
   g==;
X-CSE-ConnectionGUID: eu4K+amvRw+T7u/X7BLX0g==
X-CSE-MsgGUID: nognVWnBTxGj5k+dexSmwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55303362"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="55303362"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 16:57:34 -0700
X-CSE-ConnectionGUID: EuPJwtl1RGacO1khr1xSSQ==
X-CSE-MsgGUID: cULO5mKRTxGAvCB4JjiDCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="194099976"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 16:57:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 16:57:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 16:57:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 16:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZFNkhqv1X7MB+tjWtPRJ0SFk6m8cVLvOEn/IHqFoMerh3xaOoNOyt53U3iBLBDY1xTfTYw8hcjEfsLmwiIt56QPBS3XxlmPkDuJS1LAJLip8QfB+mUPYxwJsCvpfEU49hYqv5h6LttoLkri/S6NmKsWuTYlX7CQbLx8JSZthsecKyrEh5kTwhTov7kZiKJEqUP1TaRqp9XNNPyKD2quxX13lGCtVMH4rvvbBtS/ujocGwRr+xqyuiKbHEjGjzi7AtbcUwqW4UTI10RrBUHOidLGB/xKDcTMsg/+4nvqDkj5HwBbb/ZaOjYcnIY9/MFaV9GEhJGpE/Cth1MWM+LK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ss5JsUGI8+0/9GE+WTM3D63Fa6fxZTDdm6LbJEu3yU=;
 b=uTQoRUS8k1dMVxhKpKO3mV5NgFuVq9tKpX2p5oxxYTkFmMlGGz+O3fzHKqR+Eljdanq2V15etqSsnPhTarMf/mdKoP93hXb9+1iywC6eIu6MK024IBvTsAuVStTd0S6fR9f47tRXUjGvKQRWxnR5AFH0gEsouYOnraM3jk0TXdazmBDNhpbD9mDfwE7QJotgLDBlmG/fwddm2udtETLK3caF9b+Mh4gQUbj/Sb2OCftzK/mHsggJBRoeaEl9tQYRodTjGgUnaDfRkn4n3x5biLC/V8avZc+BqW8XjlpGqGcTjdl40zNwyyNgLKO0KJYnDO4H2BayddtrJ69nFavMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 23:57:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 23:57:12 +0000
Message-ID: <eaa518e8-2864-4b6a-91a0-4b92b5acc777@intel.com>
Date: Wed, 30 Jul 2025 16:57:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/34] x86,fs/resctrl: Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	<corbet@lwn.net>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1753467772.git.babu.moger@amd.com>
 <a259ff37-9e3e-4b4f-970f-04610c35f4cf@intel.com>
 <1a916a0a-66da-455b-9b09-4eae42e6eb1c@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1a916a0a-66da-455b-9b09-4eae42e6eb1c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:303:6a::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db48f1b-8e65-4ac9-6657-08ddcfc4cd2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWlmb0lDZGk0a3lHRm56dkpac29kbFFZVDB3YitxaUYzcll5d1dGK1RGN2l5?=
 =?utf-8?B?TTBibGswZXJIcUxkOU0wemVLVjNHanFWdElCR0xvT1l4V1RkNUJMOGFuWWEw?=
 =?utf-8?B?NVlXcE1velhsaHV0emZWbTFUNGNvY1Q0OHpaOVZUYnpGNjd1OFczYlQyVHJ6?=
 =?utf-8?B?WVZPUENrQ3RDMlVjY3pweEdwY1RBSElEd2xqdVd4TmpQYmE1V0Rta1IrVFhK?=
 =?utf-8?B?TW1vbHlEa01xTlFZSkRpNXExbDZidDlQYTZIWElReUdMVlpKUjNRWGwzWUdL?=
 =?utf-8?B?S2hiMTlnM2RyYXJJaGRudTRpeHRBcUF5Nm0vOVNwSGNkQk1nZDJULzcxS1h2?=
 =?utf-8?B?RzQrdzV5Wjk4dXIycWFScHhIODBaMytuVkV1VDFOWTVUNVp0WFZUZlRPS1li?=
 =?utf-8?B?d1ppRWVJK09VajAvY2hINFRuZXVMcWxtekhTdnFSVmlOMFo4YWY3Wmo5UTI3?=
 =?utf-8?B?MGpzdmoxWjkwYnNIcXBNWmk4VGJOWldPRytDdnl5dG9DUGhWekRudHoxNGNC?=
 =?utf-8?B?UGVUYTVlUkk5cU03QjJpRlBDSldxejlEeFJySlBpZVZsZllvSjlLZjRIdTlC?=
 =?utf-8?B?UG9ML0pEaktXeVhJR0FLWEVHdi84SkFQclJJODRyZ3l0MzdpWWhTOGxGTjFX?=
 =?utf-8?B?MnJLcWRlWDRGb2x0ZG1PQjdoaWt1TE5Bekh0UTRCNTdUck13RFIrWERYbDN1?=
 =?utf-8?B?eFVCMStkaTFjbW40dWtzakw2T1NXRTVRVzF5NzI0RW5ORzIxc2Q2QnI3UFQ0?=
 =?utf-8?B?YUhvejZlT2ZsUmFYVjhhNG9qdlNsRTd1VjYrYXo4Y1Y4WUo0Sk1GZ2tyS3hU?=
 =?utf-8?B?b0haWDU4SFhYMFBSZ3hST2YrUURWbmhOYjB6K1lnTUJZa3IxUXAvWWM5VTM2?=
 =?utf-8?B?K0orcjUxZzR1cHNOMTJzVEx4S1NLOFcxTVhXYmYyKy9MVVhqaTg3cEhwSHRy?=
 =?utf-8?B?a3dZS1FUcTdzcGEzUnY5WDVvb2t0VEt4MktSU2dxR1pCMEVKVmcrcTRGbTI5?=
 =?utf-8?B?dzlNU2VsVkUvcXhGblVrcHUwckhnUFF3em9RM1VLN0RURjNIaEhOVXpzRjlC?=
 =?utf-8?B?RGpKczhJcTUxWkpKWERlM1hMSlByOG5HMnQxZmo5bUFncXdmYmRXNTFYNjky?=
 =?utf-8?B?THI4VnA4QmxnMzlNcGRqUVdUTGxQNmljdXlDTGlleVZ3STdxdUNETVVEUVlY?=
 =?utf-8?B?UWhJdVpBVHhZZGRmTzhFckd1alJVRFk2UVYwYnFyTkJjZlpVOUNQUTBqWVAr?=
 =?utf-8?B?QXNJdmtUTlBEaElxMDA5TzNGSnRhVUlOdXRVSFQwT3RIVXErQmNPSEtxdm5F?=
 =?utf-8?B?QURMcXBpVzYwWmJkbS9LMklVdEJET1lSSlZBOUxSRURHaTBqQlVGd1JmUlRW?=
 =?utf-8?B?M0pZUk56dlkyZzJKS1J1Ymd0QXlITWFCUWQvQ3RiSXZMbjhNOG1OcEtUT2V6?=
 =?utf-8?B?UnRIK1VaYlpLZ1Q2LzhzMzNidjNaVUo5R0RiTW9NSTVOMk1GaVprQk1MdEMw?=
 =?utf-8?B?S3FCcVBzRkV6a0RHNUQ1RU9MYzZ1emJzQzUxZ1NoVE5kRWFEOUtlcEdpc2s1?=
 =?utf-8?B?NDc3bVFtNFBESUpJQWQwMzB4d3luR0FQL3VWMWNUTXo1cjJkcmF3ZTNKb2N5?=
 =?utf-8?B?M2J6YmxTbXFpTWtKMFpuR08ya0lmeDF5ZnBnMnBhUWMzOGw3ZFpzZm1EMnlW?=
 =?utf-8?B?VEF4TUlySWE0NUFJaEdaVnBxWi93U1VHTEluN0ZLRlI3L0ZlbThPeXJrYmJu?=
 =?utf-8?B?YlhPTTFGNmhuaU1FRVlvVGxFV2I2Q0ZLN25MaEVrSHJObTJxOTRZOUNsMmk1?=
 =?utf-8?B?dnp3RXBST0ZvYy9pMVhzdXp2YjBLRGQwOTV3UlJqU1dEUC9ncUNpb3B6WnR0?=
 =?utf-8?B?c24xQnUwWi83a29sUUR5SFlwRDJta3d5OXAzeEVjNWJZOUFLNEc5SVlYdVNN?=
 =?utf-8?B?R1hjVThtc2hDMTVYRG5RQStGWitTbW5HQ2F2TGU0STBkVU4zU2hvVkR5YXcv?=
 =?utf-8?B?MFRFNjNWem1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uko0LzJoeVlTdGFsSkpzelNDUERTNU1DQlpPUGRUd1ZCUHFLV1NNTWl1UWIy?=
 =?utf-8?B?UWJPRmRZWlJIdkFBMGowMjd5QjVleE5lR0YvL2ZRMFcyUXdLeUF1MmlSWmFt?=
 =?utf-8?B?WlBTcTRFOHpScS9JN1BhSEZPc1JrTnpVcEthM0xLKzlnV3pFWHgxRFBDREN3?=
 =?utf-8?B?VnlhYnl0WElaYlcvN2R3Z1VWTW14dGpVcXlyQXFnbDdmVDJWZEZ4M2hnUDF3?=
 =?utf-8?B?MWVzeVJPZ0hraGlRaWhRTzR3dVh3cmpXdGVjbW9qRDMwaEExdTdYd0RkS0F6?=
 =?utf-8?B?ZmVEeWRiM3p5OGVDVFV0ZERoellkOGh3VGxGd2xXcHJlbDUrU3FHdE5pRzlB?=
 =?utf-8?B?ZXdtbDlOU0pxQ2hOcGZPMm5laGJDRHVvUEsxanlaNTgvOTNQVlM4NkVGYmNF?=
 =?utf-8?B?RTFVSVNlTkdiaDdBMERHZDVJbVBMeVJFT3FKLzYxMFQ0NGVPZ09zSW5uVEtW?=
 =?utf-8?B?SFdNazJiVzRUQ3ZMU1pJSWZ2TTh0MnltRW41MXZnTEdOTVRrWkwybUhNU3cx?=
 =?utf-8?B?VnB1N2RjVm5qSVJVTVBSRW41VGdzZ2pGanN1UnVYZVZVdlFVL3htaW50bmlY?=
 =?utf-8?B?WnMwY2dmQml5R2JqeGc4b1drV3N1RjZoMitJTDZZR0pHWm9nVHp6cFRkSmtQ?=
 =?utf-8?B?RDFkekdxUURvTTBSbFRGcGNvcmpIUVIzRXBuYm85RzZTVkNWWGljTEhqUXU1?=
 =?utf-8?B?aHRLM1ZSRXdEamp5Y0JHYmdEbEx1WVV0NEVFdVJ6Y08vcmVVQk5uU1daY1po?=
 =?utf-8?B?QWpjblI3L2djdG5BL1NRK29NK0hmcHIvSzFSUjlhYnJIaDBRRjFGYzg0d2Rx?=
 =?utf-8?B?WGFrdmhaMDlsUzlsVWNCNFE1bFhaOE11dXhYTzhxdjIyYkFZc3lEL2Fjc3lk?=
 =?utf-8?B?MXZKaXR3NnlOT29LRjA3NzhkZWRVNkRacUR2SGYwVHB1TU5JSGo3SVl6RW01?=
 =?utf-8?B?b3M2TDBaamNrdTk2eXhOV1NRVnhsSmZ5eUN1cHFiSEZTeE9BKzBQOGN5bFQw?=
 =?utf-8?B?a1FodWxnMExCRitJRXVzYld4Z1Z0ZWd6dm1neEFOa3N1VWJCaXNwNkZIeFFS?=
 =?utf-8?B?YXNjZThuMUlnUnBhQ2p6RDhWRFMycXcweHdPcWE2emRzMkFvdjdna0pUbFI1?=
 =?utf-8?B?OHRTUElQYVlsUmlCUjhtWVhrSHhCdHJLd05GRE9xZFJjTnRDUHIwU25KQ2ZS?=
 =?utf-8?B?bG1UTXZQVWwva2pJOWhsNUI0L2ZWNVNiK0VncGpkU1kvZ0Y3RU8wVDlUMGw5?=
 =?utf-8?B?bWp1MG1BQUhkSitBUlpnOENXNmFPTUxHU2xvT0FPanR5N0NvRWk4RzBZQlFF?=
 =?utf-8?B?SmxKRk4xUEMvTjQ0cVA4SUUrT0wzRnFWNmdLWlVPM1RETlZZTkVoQlQxbGI0?=
 =?utf-8?B?OFd3dDk1WlY5L0hRS1JUcCt6Vnhicy9FT2luTXFxWFlmVmx2WFRDYlF5dUZH?=
 =?utf-8?B?VDRNdXpPMDZMU1dNQ1hZMUVMRjFjRXQ4ZVRWbkFtdnliRWR5SFJpOXhPUUph?=
 =?utf-8?B?QzhzZThxanBOVjhyOEdtZTdScGJmVnNVRkxVV1pOSEJxRTZsRHNtN04xMjZI?=
 =?utf-8?B?cmVVYmtXVEw0dklsK1oxcnBkSmFxczRGMW1mRVFOQkd5VFJDbGRPdW80L3ZH?=
 =?utf-8?B?NWE3Vlg4d1BWVnV4dkg1TkhkSXp1bjI5RnZrVDNVakJhUXE2UnF0eW9iL1pW?=
 =?utf-8?B?d0tBNU9TNkFFNzloNTRJMjRFT3lmNmt3cU52eU42Rk1wMVdvbkQ2RmxRYVE4?=
 =?utf-8?B?WE1WeDN3N1ZteVdoVWVMTDJJelBpOHVwcEh3Q002WEhsUUJYNnA1OG9YcWhF?=
 =?utf-8?B?L0NwS0ZBUElOVmRGeXc0SVJRNWxuaVBhalk2TCs1Qk9ESmF5Wno5SEJPNXlO?=
 =?utf-8?B?ZERQdE1jWjR0bWdzbHZPak5jWW43WkRYR2Y4RGxGV3FLWWQrVWI3UFJQNDV1?=
 =?utf-8?B?WDJldlNLYnNDWlM5TDVWSmQ2dHFONktFZmxvdmxVd0d6am9zbUh5R09qa0tJ?=
 =?utf-8?B?dU1hM2IzN0xIaDg1WERjMUJYRGd1Q25LdE9tZWNYV24yUmtwV0lQdksvWC9F?=
 =?utf-8?B?a0ZPOGxBVzZncWNTK0FiTHVvNDltVzZocmY1cjVqS3RYanRQcHRTaEtKdXNZ?=
 =?utf-8?B?bWY3MU5xK2JIdzRDZXo0K3BFWTFyejBubTBsalRRdUF1ZCtSRG9CVGhmckUv?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db48f1b-8e65-4ac9-6657-08ddcfc4cd2d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 23:57:12.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yuOJIv0Lpv3/jLnBKDEVvNjIXyEM1XbPyDnQU/DcTUdnCMuC8ObGOhjS8XnIeK/sVp6w7Me64mcI6lGZap3RREz6idDpT7NJaVeWViazho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
X-OriginatorOrg: intel.com

Hi Babu,

On 7/30/25 4:31 PM, Moger, Babu wrote:
> Hi Reinette,,
> 
> On 7/30/2025 2:47 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/25/25 11:29 AM, Babu Moger wrote:
>>> i. Change the event configuration for mbm_local_bytes.
>>>
>>>     # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
>>>     /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>>     # cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>     local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
>>
>> Above are some more "counter_configs" stragglers.
> 
> Yea. Sure. Missed that.
> 
>>
>> Also, while considering our exchange in [1], I encountered quite a few functions doing
>> counter management work for which I believe monitor.c would be more appropriate. Centralizing
>> MBM counter management code to monitor.c was something that you planned for this version
>> so I may be missing why you decided to keep some of these functions in rdtgroup.c? I
>> highlighted these functions as I noticed them.
>>
> 
> I looked at them. Most of the functions you mentioned are directly referenced in res_common_files[] (show or write) and some of them are even named as rdtgroup_<>. So, was not sure about moving them.

If you prefer a precedent you can compare with rdtgroup_schemata_write()/rdtgroup_schemata_show()
that is directly referenced in res_common_files[] while the implementation can be found in
ctrlmondata.c that is intended to contain the "Cache allocation code".

I assumed we agreed on this since I specifically highlighted the topic of the handlers in [1] and you
responded to referring to the handler event_filter_show() and mentioned that you plan to consider the
others. This version thus looks different from what I thought we agreed on :/

> Sure, I will move them one by one to monitor.c

[1] https://lore.kernel.org/lkml/0fa9a12b-e900-4ceb-b59c-e653ec3db0ca@intel.com/

