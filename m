Return-Path: <linux-kernel+bounces-899224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AFC571EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E84E106E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3FB33971D;
	Thu, 13 Nov 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0ALC7Ba"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457733509B;
	Thu, 13 Nov 2025 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032482; cv=fail; b=Q2Bcb76i34LGffQdqPbjYRh5gwqsLIRvwFENndNOD7L8zn9XHI7KcEEvzSIMUzywvCN8/pL+zIH1lAN9rkhTmyw7kiWvyN8+aMqpvQj2CpFfa8k2P7owOFXuLzM14CPEqvXjxqN9xucl9vA0FB6KYSNNnRR6DxATbCjICvg8u8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032482; c=relaxed/simple;
	bh=bG4y25v1lqmrWUTW79HZGPLdWDryOOSQou7fxLZdfK4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GJ4keBR6KF77QyZZs9jTdh5mkD8qd3xx3sx4t9xM4jHm/zk/NggtjBio3d47k7vUyWLAlYEXkHdhCBt7H1MO8XHrCXyh7yeumsP5zbBu3grJclzYGkmbiEaFyvfltYmrLUBKvwNGQXGCJj9jkgPM27amnjqWGcTO8AjPMbsriP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0ALC7Ba; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763032480; x=1794568480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bG4y25v1lqmrWUTW79HZGPLdWDryOOSQou7fxLZdfK4=;
  b=a0ALC7BaBTZWjC4qUcyKye5601kuqZyxBAt8kGARrKKOhvOHDOIfxEoh
   MpZ8MqikjtUciYV6PShMH5s139p6kcBkajvBOTy1H4NkTXvUOLduW9CoH
   yx72+4cB3kPPiqxkwukUdFrLHdfCHjEMd7CRuD9DpIl5U6qwdLh7ZhruI
   19W4lmR9BxeHGRLpQ2Wuu65g3RgXHW18D7Fh+v85m5BrLwIgHBs/wCxpc
   4JbqBD7DoKt9svsTmX8suIepGTWwdOzpXAkUjBPFx60pDSEQMmeLM8pXm
   I4WUeqoxsJ/YzqegMfgoREjinV48B3GIwGltIVtFuswfLXegSvhdzQAEC
   w==;
X-CSE-ConnectionGUID: 94Qyj2XRQy+zDCHIjehHwA==
X-CSE-MsgGUID: r61pqv45R4uPfZley/H2uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75788135"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="75788135"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 03:14:39 -0800
X-CSE-ConnectionGUID: Bmo855gMRE6w1BxA0JWoGg==
X-CSE-MsgGUID: eeDt1dD9Tt2kjsiL1XiL5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="220129126"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 03:14:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 03:14:38 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 03:14:38 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 03:14:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hmc/1x0qScBZwFyJFBoBv52Jk0URXyFtpiBhKHcH9yPoDmIAtk2DA7rKVo6fwxxTJUM3rT6/hjIvf9Q0fWB2CJwkxfMVVFuMe95ivdH55wTVmZDd1/nCHjvTmypbnLNoNKQP9CIotBtuXBkR/t7WDRyMqD6zHx/YinY953vmUQm1LL9iQLvQlp5f/3EA4hGqPl4JJ10XT6Z0bvzwVwZ2fkoXTSiU6jn48UAKEET84Wf1w8RIsvDxS5r+BHtm/RSOQMkx29nmkLfFFvXkUBwudcBo4f5L9m5cOEJh3TIx6nWYOUhEShRfQnao/zDxMnNEtA7cJBVqbkYzR/KLcsunjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACGsCReq4CMYhVRtTIAT50ZON/bY0w8BsgEfdiWFH2U=;
 b=q+Eo4NgphaqJ+IGRPsZ3RgaELDZP6V1wBzpN36Y/ZYI2B059Uh8oVGJeCLThNno5MGoAFZstM5lsjaRmxPeajaf3rCR9iryzIQT9Msu00lN1gU7OAlukWvbkqLppEKz3cEUlFKWN+KR3k++/KYDFTn3htDLDpXGA8V835Ze3SxMBUSrZT0y7v6xh4ZL/RkaPpIW+tFfYzVBLo2Tr+adUjKMQKSRp/R2vR1+c1Net33+Cbrz+zk24BjCO29O45u7PvQktVhKMXXqN5S2PUHgdFsM3HEwc/tTfgLjY6nEWigoQ2n6zuoETaBDDwN+HUdglPvoT6AWcgFJywP8xOoyfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by DS4PPF69154114F.namprd11.prod.outlook.com (2603:10b6:f:fc02::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:14:37 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:14:37 +0000
Message-ID: <18c161e8-974b-4a4c-9ef2-c2cacef481b5@intel.com>
Date: Thu, 13 Nov 2025 12:14:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: intel: avs: Fix potential memory leak in
 avs_pci_probe()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
CC: <liam.r.girdwood@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251113104121.79484-1-nihaal@cse.iitm.ac.in>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251113104121.79484-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::25) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|DS4PPF69154114F:EE_
X-MS-Office365-Filtering-Correlation-Id: 17915176-f3ee-4cc6-fe05-08de22a5d4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXA0YWtLQUI1TkxBTDJORHo2a1l5YVZHckpSMTNSTkpzMEVBT3RacWRMdlVa?=
 =?utf-8?B?bFVpMUpkcWZWUGNwZ3c3SEh2cnRldmxQQ0cwcm93bVJtbHpQMmJyN2lkc3Yr?=
 =?utf-8?B?WFR3NHhPR0NwTHpxOE9vOUR1RXBDYUxYQ3pUdGVHVnlvSHEvU2lHVlFkSkVr?=
 =?utf-8?B?b1hEMTJ5ejczQUl4cVQ4TGhDSUdQUCtaUFJ1cnA4Z3VCRHI2UE5LWWFwU3FC?=
 =?utf-8?B?ZFJTYVVGZ281VFVKSFBGNWdJVm1VSFJsRmtDWVZWZTN3ZW9mQUFPTDV3aW05?=
 =?utf-8?B?T2hDVXRKVnZ2OFQwMjlaUjJzcWJ1dC9ZRno4SW1PZ1pDUVErWVJRS0w3TENx?=
 =?utf-8?B?eE9yNlRvYTlEVjJRdEM5dm51Q1U0Wkc4dDlJQWZPa3lqWXpyRml4bm9NSSty?=
 =?utf-8?B?MS91V3Uzcy81R0hMNEQzLzFZVWJ3SHJmK1BsNUtxMXJhc2VXdlVTR3NJeDNS?=
 =?utf-8?B?OGw1TzV1NEd5bTV0UEFsOHJKSXBpTEVWYmRNNjZpYmZZZEZ1Nm45WUZXTXNw?=
 =?utf-8?B?UUs4NW1ZeUpxUVJnZGdCcndhUmtGK1ZVOGdicGx3ZUZrZldUaVI2cGQxTS9l?=
 =?utf-8?B?UnkvcUVpNEd4Uk93QlVIMmM3U2ZrQUFKTEVxYVRZYTNYVUE2N244V3BkOGZt?=
 =?utf-8?B?ZWxETHBrb25aaVBINjlMVzhONklYUlIyYTNNSUtVYmdRUzVVNFhpRXFhUXRP?=
 =?utf-8?B?aVN1bmw4Y0dCWVV6MkVwMytHeGN5SG93TS9RWFFkeHBvR1dwaXpoN3d3OTJs?=
 =?utf-8?B?OUNoMTQvZ01oY1NiNW5Ha2NPaGQzLzNkY09uUFIzMklnV0RxNDBrS1RRbHpt?=
 =?utf-8?B?MDlCK1hTd3FPZ21qS0xSbGlqMnB2L0dPNU13a3NNZE5tUEc4NTB0b3VEdkVD?=
 =?utf-8?B?ZGlUc2JvdmNBdjJxNVdIbTF4TFh0MkZJNkpkU0lqTWhaZGJ6QVdBR2ZSRmJh?=
 =?utf-8?B?d2puTVBMazBpTGdQcnR5ZkZYd3VNRzJMTENWNXNZVVE5NHQzZkN3eXlkZFBl?=
 =?utf-8?B?dlNGQ2p2M0tzWSt0a1NNRytDRldGYzdYUG13VjE3Vk5ZRnVOR3BZTE9jSE9a?=
 =?utf-8?B?bEFKT2t3QzRWWXlSR3BtZFhzZ2xTYnpZUGlWN2JZZXIvV1BLdlRVY0w0NDhs?=
 =?utf-8?B?eWRIREoydkpTK09mcDBXVEhOYU5FRjA4RkZXTWdOc3NFYVdtTG1OU0w5K0tx?=
 =?utf-8?B?dWlPVUxsYThBd1Jrc25XRXRrdkZwN0VsbTJJR2dSNURRZ0dYZFFPTWZwUXVX?=
 =?utf-8?B?cjFIOGV6R0JOb1JhVWVTWTRHb0Vkbm5EbVI5UXFuOG9ZVXdUcnpyckJOU1lC?=
 =?utf-8?B?MHlaTzllTU0vU0dNTWJnTVlkd3V5L21hMDdiTUVRWVJnTDFsKzA1RnNXVHoy?=
 =?utf-8?B?QXhkM2NmZmovY1J6aUZKL2pqV3NVdTZ0Qnc5cmcwUlpNcHN3RHM1QjliQVlw?=
 =?utf-8?B?SEZuOFBLOElnNVE4MWEwbG43MzVZMnhFT0dzQXFDS3dJeDVMUll1TDZYU25N?=
 =?utf-8?B?M2haeWZIMkZkemdxbStYRlF6RWh3L3RVR0pEdUEvZVRTTjR0cVA2MThWeUxZ?=
 =?utf-8?B?Rm52MTVxOWM0T1BQb3YxTzBrUkJzenVJVUg5ZnBDa05ibGZHeUhLZjd2SHhv?=
 =?utf-8?B?ODRZMjZlSjdqUU1jL1pCZnhCLzd1djBjVVQvb3prUnpSWGdIZ0s5RExVTW5L?=
 =?utf-8?B?UVZ5WU0wUEN5RlZUaXpJUndyY1kvQmozS0tsSVRHUDZpQ2RsRkVzMWhRTDFU?=
 =?utf-8?B?K3JOb0oyVXh2czRGMFRuQ1hWVndqaU1xVGhQUEYzbHo3QnlWMGtIK1lqdHNO?=
 =?utf-8?B?UjRxb1VBVElYbGhQbDhHRUpuODBjODlNTWREemhOQjNRUFNUeForYjFkV0Ey?=
 =?utf-8?B?RGVuQjBtRTkwV00rQ3g3cGFMUDlGd1Fkejd2dEl5YkJKV3VQMWNJbEtCRTJB?=
 =?utf-8?Q?XBrBM/1jkhoNGTpZQ9SmP9RgER0ciY9A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0k0ZkxVTmplQVdodGRHWk94SlJXSmhXQmZSNUVnYjdNRk9hTU53bWdOWjVh?=
 =?utf-8?B?S2szaXF0TTNIWjJmQ3RkK3JaanJxeUx3ZEdvV0dkSGpoMS80MkZEcEI1QmJO?=
 =?utf-8?B?L2g1bFg0ZGp0MTFMbGpKSkoxLy9la1NkRWV0cm9BR0J5YzBlbml4WHRrWDhO?=
 =?utf-8?B?RTBMN0pJMmVOdVRXaVZKdWpCdVowMSt3NFZWT211SnBweFI5cDhtZjB2enR0?=
 =?utf-8?B?U1FvVllSdi93RGVqZUZWeW0ydjFBVWQ2dHNCNnNFSVNrb0tXaDM2OGIxNEJH?=
 =?utf-8?B?MVVWdDRSWEtydUxwdVpuZmRzOVIrWmhpL2EzVVpYd3BldHp4VHJwejlpTHBS?=
 =?utf-8?B?NXRGdmsxbVZZSEN0TnQwZzY5MHRUWCtRMTkvWnB0dS9nQkFGU3QyS2ZVbThh?=
 =?utf-8?B?aFBmdDkwSzFmZGVSMUF2YkVNeGRDenBJSUo2QWkvR0dWWGFNWTNpakszemVN?=
 =?utf-8?B?QnBQSWY2ekxkY3pYcDMwcjJwWmtxUWpJOVhFdXlkOUh3UU9FTmZiN0VpZVJa?=
 =?utf-8?B?UitReXlobkpUMmF0M3FZVUVpRnJScG42cldub1JtMWRJeHpERnY5ZDJOa3gx?=
 =?utf-8?B?VDRvbmpCYm9PcUIrV2FPcy9ON3dlUi94R1djQ2U2OTEyb015SmNNbHpFcEJK?=
 =?utf-8?B?YlMzR0Rrdjd0K1ZZYkR4L2loek5taW1XcXNETFpNTEgzSzVaZzd3R3gxbHI4?=
 =?utf-8?B?MDNCNWJlZW9JZFRPZTAwYjZWQXg2R3g2M2x1ODhyU3VJK2h5QWkzcXY3V2FH?=
 =?utf-8?B?MUJNWThXcVdFTHowME4veDZhUGZZK1hoZ3h6M2NtQUxselRzZDlKdXB0dDBK?=
 =?utf-8?B?bXVVbk10VmY1Uml6TDJJWkE4aFhJOGdzTTh3SFFkbXUrMGc0UGJhalhZQ1Jx?=
 =?utf-8?B?OGJhR3lwYVBDMnNzbEg5dEY5SDl4enc4N1NxU3FzcGMrRGRNeTJqalNDdmFF?=
 =?utf-8?B?YlZUTFk1M3p6Vk8xdzlHS0NaOWIxdG83R1J1bDFhaWRqTkRRTzJRbXFYRE9W?=
 =?utf-8?B?YmI2dnZMSUJ4M2pMcXM4L0JYWU5reE9IOWpaQmpZaDNNOHpWOUJMSW9CK1I1?=
 =?utf-8?B?N2k0WjVBaVdBNGd5VnlXcVZHRFpmc0FCRnB3NTE0SVZ0S2k0d3c3NzdETXA3?=
 =?utf-8?B?WlZYQnNEaVhFY01RL2NiSXZKbU1scWNzZ2xqQnYyeVBWcTVaKzBCeGQzS2NF?=
 =?utf-8?B?R0ZSMmF0NlNVUExNS3FhS0NIeUJyeVVOUm5uODRnd2p2L3d4TVJqbmdFc2pk?=
 =?utf-8?B?eTVnQ0tyRVpSV2x1YjNVK2Q5c1lIL0ZOZDdlaFVNalg2emdSMU5XaEpQVWZH?=
 =?utf-8?B?WlZlNDJmaHVMWlpnTHlUamV0N2J2anFlNUFXN2pOeFc4SThXYkprWlNvRGp6?=
 =?utf-8?B?TDJtTmZQOGZ5RUR3eVhDT0NqRlByYmZQa2tOZzlZekxGT3hpeVRhTHl1ajRh?=
 =?utf-8?B?S2FoRmFJdTNQTE8wUmVEZUJOa2ZFMnFLM0cyQmRFSEVjMUxWMnpTazl4TzhN?=
 =?utf-8?B?S0tLaHc1Y2xhRitWN1VBOTlwL21xMDNaV3dhenA1c0E0VEQxNWlpSFQwRita?=
 =?utf-8?B?d2ZoaGMzVnpsOHIzM3JBekJoUnkzOWcrcmYxbmVtaFZmWUdieWZnamxacFdF?=
 =?utf-8?B?NEpmOExTM1c2YjlJRm1rM1BhSHYvWWxGUUFWeWxnQnZyVU5XU1BTS2R3ckRF?=
 =?utf-8?B?Z1Mvd1d0TjBXdU9wR0o5Z0xpRlMzRzdFSElDaWZQaDMyb0k0WnVUU1R4RWNl?=
 =?utf-8?B?dkRSbjBJamtBbzhwVjFhZk9BR0p5czE0RVI2VWluVk95R3FtQWxXTWRxTFRN?=
 =?utf-8?B?V09NVjFVQTNFTDlLakNMMkZoMFAxQUFENnpUSHloRjJib1piZTlTc0J3UEVS?=
 =?utf-8?B?b3d4cFg1UXJ0eFJIREptZHNpVTBsTmEvRUs2VHhkbUNSWVZOa0kzZ2d0MzFL?=
 =?utf-8?B?bUN3Y1ZoN3o3TDVHNUI3cFpSdHBMTDlHcksxOXlOTGxvdmxmWHpaNEsxM1Bv?=
 =?utf-8?B?bTIvS2M4cm1JOGZGeTZhOHFLVER3aVU4c2VXSGw2dXQvSm4vUFowSlh5K0M1?=
 =?utf-8?B?YkdsQU9jMlV2Z2IxWmd2YzI1bXp0M2N5UWdXbGkvaERkd1R4eHdYcTRjeEd2?=
 =?utf-8?B?RHp0d2ZubmxZZ0d2UWtYdzN4N1hmOTdKRWlFbkZONlUyd1FjeTNXSlpJNGMx?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17915176-f3ee-4cc6-fe05-08de22a5d4df
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:14:37.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVwYlPKP+MuLmlK6NioNjZ+J6PfqbvIlwSLxvd4jKOx2JyH1AKeNkFpHLvggNq4WR8AsCY1t5Oj/Sm7rOVdPSNnTrIGiCy0hzIF69C6263c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF69154114F
X-OriginatorOrg: intel.com

On 2025-11-13 11:41 AM, Abdun Nihaal wrote:
> In snd_hdac_ext_bus_get_ml_capabilities(), memory is allocated for
> multiple hdac_ext_link structures, and appended to bus->hlink_list.
> But the subsequent error paths in avs_pci_probe() don't free them.
> 
> Fix this by calling snd_hdac_ext_link_free_all() on the error path.
> Also handle the return code of snd_hdac_ext_bus_get_ml_capabilities()
> correctly, since it can return -ENOMEM.

I'd suggest to be strict, no need for lengthy message when addressing 
simple problem. Your title already answers _what_?, the message shall 
answer _why_?. Example:

snd_hdac_ext_bus_get_ml_capabilities() may fail when allocating LINK 
resources.

> 
> Fixes: 1affc44ea5dd ("ASoC: Intel: avs: PCI driver implementation")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.

Well, it's good to do at least a simple functional test before sending, 
see below.

> 
>   sound/soc/intel/avs/core.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
> index 6e0e65584c7f..ece78a1c0e42 100644
> --- a/sound/soc/intel/avs/core.c
> +++ b/sound/soc/intel/avs/core.c
> @@ -473,8 +473,13 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   	}
>   
>   	snd_hdac_bus_parse_capabilities(bus);
> -	if (bus->mlcap)
> -		snd_hdac_ext_bus_get_ml_capabilities(bus);
> +	if (bus->mlcap) {
> +		ret = snd_hdac_ext_bus_get_ml_capabilities(bus);
> +		if (ret < 0) {

Just 'if (ret)' here.

> +			dev_err(dev, "failed to get multilink capabilities: %d\n", ret);
> +			goto err_ml_capabilities;
> +		}
> +	}
>   
>   	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
>   		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> @@ -516,6 +521,8 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   	snd_hdac_bus_free_stream_pages(bus);
>   	snd_hdac_ext_stream_free_all(bus);
>   err_init_streams:
> +	snd_hdac_ext_link_free_all(bus);
> +err_ml_capabilities:

Don't believe that's correct. -ENOMEM may be returned when allocating 
resources for an entry N>0. Skipping snd_hdac_ext_link_free_all() may 
leave things at status quo - memory leak.

>   	iounmap(adev->dsp_ba);
>   err_remap_bar4:
>   	iounmap(bus->remap_addr);


