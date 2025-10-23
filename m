Return-Path: <linux-kernel+bounces-866387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFEBFFA53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6388356706B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2BE2E11DC;
	Thu, 23 Oct 2025 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtyrTHBo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF612DF147
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204389; cv=fail; b=H0enQCxO49Xwge4LY9qsGpLX4s5AT2ykinhndx+xqTefBcYlWbNXamBCBLZ9RbWk1Tx08PZw/PJyBYtIMjAVpBMp0e31BpvM6vx/YxKdMIy3qgJZh2tnm5nuOmYV6IcYcv8WGfHC3oc2fdJ766SANOVnoWMFlc/dmh24PB/oAHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204389; c=relaxed/simple;
	bh=5DjaC9sOgjeKwWsX3aUsvCDXBYVBrOsvwGWGNNkBeOs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GivXP0TbRmFrzXA9/M3yNilEPNnY85qCacKQ2MTmKIwR3C7dXyoXVncEldoEe2JA/tpmQC49Ra/B2yjjHXRk2iyagXS1/nnvp2ObSb8DsPtaZj84HyAg8LR/zuuwRaUwRPeXMcygS2eSBZn6LfZUFoA3jaP6uwssvp5rFonUmHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtyrTHBo; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761204387; x=1792740387;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5DjaC9sOgjeKwWsX3aUsvCDXBYVBrOsvwGWGNNkBeOs=;
  b=MtyrTHBovBklVXmv8YLV5j2NFd5vEgmo5khby6inNMn63SyXxr2BgYhc
   HsWF3ihcj/a6mnLMwZ9IY9dlk5eKip0uZe6yq7eS+MUhsw9TXsgoyM7Uj
   CrmmtG26NIUlAnDrzd1olBFyK0o6yVabAP3XFiyOtNo0T99+3wyafeFOp
   6Z+n/AbHiQEI9eqJBwFho35sBvbLh37b6+BRasdNA6dzeWTyKB5nCCNph
   sQy96zcyHGE/93Ni4Uw4M7lt6pphLC9feRuFONmFBQ7DAc+fJ0cT2rlRZ
   5syqT8JpPswXzQAf+heUWdRySuYkV2t+Vdxb3bTmu2aqDju2b1BQ2Z3qO
   g==;
X-CSE-ConnectionGUID: V9tPreLyTB+Y2rikEjr9Dg==
X-CSE-MsgGUID: g1f7Tm/gS4SSJir91qzCfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85990178"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="85990178"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 00:26:26 -0700
X-CSE-ConnectionGUID: TFLmuzgMSZWOF90DzZxTVA==
X-CSE-MsgGUID: u46UQ07GQqi9FKETyxLNZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="207741240"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 00:26:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 00:26:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 00:26:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 00:26:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSLckk7kpVqskuV98g7gfe765hnMc0VBrleRHubGIjC9IslDz7O91cQL321fUvm7n6x2e4SFvq88PkReLPIiokKRvDTvXPwlOzZKPK34R0gUldtGXihvij/xnySgpYN2+DVX3hls9TXVJ0Of+txKnkV/edjymnrUkBl5/vpNUAI4ARGMYdxGXYw1+6XAVN6NdLJZypz71JMv7pC8Z9whAHaqyeztzdYRNUAdMBcHgtXJMHPltXWeJf0nBjiWu90JKp8KJ/TYeKLmexwgEKMOMJXJ9StF39Dbk2zG8BsBsmtKxpr+Jg9vWIWbMgXbdgAsUBFDe7tFb4lVS4BxkwvlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMdtZPnyAhaS0PeTI/ir3rbUVCDPh3WixPB1QckWOrU=;
 b=GyhmSSCyve5KCSR5u5Ww305fr1/Zq5RcybJ20Ax9Rsna2yeXtj95WxbQmJwanndPyevQI76Inuhrbgn/7N9AM5hkTA94taFT8gBb2qwPqVAeCl5EIaWaa1+hZuaJSg/t4pyV99DW3kUGMaPkM3+GSHKzPkPrwyMH4A4b5Sp1fUeVzgyLca5ztvNF1y1JwfzX7n6mktmPM2jeO4xoz4W2MfTYvO39RQflfJ/8swDaAzLR3DqMF+q3NnawLrL0eQ0CzUAQRUFLHRSdwWWkxj5cP1daXY+rpUDUK/eblMvFNybhCv/cNCKiFTUu2UJYYKaVJhps47c6hzfTpW1MCkNaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5312.namprd11.prod.outlook.com (2603:10b6:5:393::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Thu, 23 Oct
 2025 07:26:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:26:23 +0000
Date: Thu, 23 Oct 2025 15:26:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Chen Yu <yu.c.chen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Libo Chen <libo.chen@oracle.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware
 load balancing
Message-ID: <202510231459.ad690ecd-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
X-ClientProxiedBy: KL1P15301CA0066.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eaa28d2-d58d-41f5-c776-08de120577f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9c3pKPK8CHeo8+ByCLzk68zKA658EIm8VfzpGhdmvwWaLdVbgLpFi82rwW?=
 =?iso-8859-1?Q?+G8l/XghBUNdPSY2G5D3WfvXJ0JUxbAg9o3/LYckIa7g7VBEbicPAmGlwa?=
 =?iso-8859-1?Q?p03Wa329uBUtNtyeUypmaw1L63qoRjm38al/yGsR2V7nBwqZ9hTfLYMvST?=
 =?iso-8859-1?Q?38Tz0Vuu8X3dWcN+42JPUcTxL/NkltVtwD8iYc04MsiqGTNaIu7XSo3hhM?=
 =?iso-8859-1?Q?KDn7FP1QNbNsvhqcn+BKBHyltQYBJSk050PNNURZbQTW66r9+9qyWqO3GW?=
 =?iso-8859-1?Q?H3DPrc31CWY1rwF5e7M68SDuNZJVZJofp6zb/wA8Mbyy4mr1tg4mMqNQ1E?=
 =?iso-8859-1?Q?1kb9WQsPbl3bZqP8ssF0TqK8GUwLQsaeaSOa3e4J46UnydJjuOY/mTLsOA?=
 =?iso-8859-1?Q?9hJ5OsXnxSuTebzhaWVERZi6H4FcrbI/Md9UzfNSXmtdB4CXPzDyFpfGUw?=
 =?iso-8859-1?Q?QEvxCzs+UOG480s7RVQzLv048WoBWArsfJ4Kwi30Qp/2Cfhb7kSzo+wpOW?=
 =?iso-8859-1?Q?kSWTIwQrOF1B13NVHF9pdEgJXCoGlWJt1W996bnyqs6iKYWtiagW4RKSKW?=
 =?iso-8859-1?Q?5YoCUMs9B/Zogg7cPsTCaqBxxJYAuIKzRrTMPyPq93K2Q0iXSbx4Tmf2pM?=
 =?iso-8859-1?Q?Czh35Br8cBXOVclqVWvsl27qz2BvQP5DUqozJnIgDUftw0fw7taURO31GW?=
 =?iso-8859-1?Q?iBtU+HNPlc00A6HaI3mbywIDaDkYVkXxW6Xu/NzjGOtJZHqofRxs3JmoRS?=
 =?iso-8859-1?Q?o7sNuvbfnqz28m9y5YitgG8WkV14o6dzCmCgq7VLcV3fsDKgsfxoZ4E3EE?=
 =?iso-8859-1?Q?rqj8uHS/hOAy5jU8Ns6w5rLP4Ph0vXz8YGsmcWbctEowGp93VzCT/3cZLj?=
 =?iso-8859-1?Q?XsFh2n0WZNt5ouc+Em7ahdjLZ//LhVpfYlbkrX4SEbnPcMV21lPbXhrjAu?=
 =?iso-8859-1?Q?FZc2DPOSzHy4pWXyPZKdKIT/opdZ1MM7qnC3iK8SdH8xaiwYO3wj1ZSae0?=
 =?iso-8859-1?Q?+cwUYDdwi3IvhrqTu7NIeuyGZaAdkxIuHCTa8ZPLDaDMlxbUTDAfX+qMKU?=
 =?iso-8859-1?Q?DyTn414+QQvwSwmo3zThXI17efAo6KZguFpIwH2SSC3u9DpT/lU42GJUD/?=
 =?iso-8859-1?Q?B1OthktTXEmQ/NnIvlc0XxRHbNAsdiJTsyxP0/4t4pxEyS6pBWapmIrq3H?=
 =?iso-8859-1?Q?CE2fM8vBPxOA7iXGSoyw2JQlGVEsIgWP5VAI9V/e9Dus5i3F21zYI0Y40t?=
 =?iso-8859-1?Q?FRRS5GDFe7drF3zXkQZV4ojTx9Vtl8pO73MaLMGRYDADtX7E9jFD6Job9T?=
 =?iso-8859-1?Q?ofTVnMvd77j3LEr0aGymK24Y8JSvlgQn+NhkeoNuE4DalvipZAoVPl2buH?=
 =?iso-8859-1?Q?cC8PR89z0+/XzNCJ8jWiPigAdW8Ydyv2ZiixdE0vFCxNR7SYNspVXFaITP?=
 =?iso-8859-1?Q?qEM8m1qX1bKA4mtRsbFftMoLVFLE86zMb3Q5dLJt17J/00iGOvxg43qUCS?=
 =?iso-8859-1?Q?TXykzqOw9OGBZhSzhP97s30suGM11rTp9iYk1T2KnpiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tD16Y9IzHdip8knsstcDMpHD8V3ivjEJ3fzlAcbJP5HUlXYY9fQAP9nMG/?=
 =?iso-8859-1?Q?81Ltu4QO4UHlfOrvSmMBx1fAlSbOR9k0TVq/dYNEbc2g8+PD7lMNHY3S1w?=
 =?iso-8859-1?Q?qEf0alHeob0Gl+kl95J28znwP5vCDgWVkyrj1IR/7V7kgetsZEsasD49PB?=
 =?iso-8859-1?Q?u77Bl6MKuj5UZgqWhe2WxR2SV8nOMoRZmfILq+H2gFgm8Tn0wxFYA7hAUV?=
 =?iso-8859-1?Q?LOtkfTOPDxNae2mfxobSYhty8F6r8IYR+n/coId+x8z18GG8/iBmb/C/xY?=
 =?iso-8859-1?Q?yLWEpv+G+U7EaXB2qr/vjqg2UnF4gfLTPn3GdR5quue7jNfXhhUxiJj/00?=
 =?iso-8859-1?Q?vytF4xojoDiV82GLXL/D5sQdCh+tB/v9wxo3T//TihQDAMouN4MHs6PqvC?=
 =?iso-8859-1?Q?2RzGdBkqst+Bxmhs380w/ofmvLh65w6/LZlqBXFPMrHSwY4RW0rk5Jwxzz?=
 =?iso-8859-1?Q?MXLzBgnDRQO3csMIpj9WwOvqimQJ9nMmBKHpXb6gL5FwszlPWF9KEQySjh?=
 =?iso-8859-1?Q?8WnE+edOlZFHYEzt6vf9E827bobI6uJrUnDmbfN5N8BECPJNsAJs/+QtjZ?=
 =?iso-8859-1?Q?mk8hDRFIAF+/K4VXjchqK60owzOyCSpfODqMryUxbFIdKxbWmHpT636Luh?=
 =?iso-8859-1?Q?bdKU1mkitF7GFHVBbqZcO/lk/PVDu6m+cyRnB6z4m2WoDD6KWHqFZbV0mA?=
 =?iso-8859-1?Q?Ee4UMKs9VpnuoJ/Sk031TE+Zd3s1O9evNZD9OgZSE+XbnMEyiI7eOFvwO7?=
 =?iso-8859-1?Q?4SbF7qgdJutAwoZz9mf5hPmfUxnxBGrTxIFyDDX+mDS4L5aWBjyzoOzJ30?=
 =?iso-8859-1?Q?UUocbpEz9ITwvF1EqEgheLVDqFL5dWNfDANplC8VgrMk738KLPYin1iWhH?=
 =?iso-8859-1?Q?r8hD/+1oBorICEew0iSH/Vc+LlRrqlXWPDI9LZ4rfPliGfB65onBOgywyy?=
 =?iso-8859-1?Q?9pgBnP6b5vLxnWotl9/qoESg7knBt3wCS6Hn2mDuNfT8JVYzkBYgYUN5XR?=
 =?iso-8859-1?Q?Utxbbq9ULtzrIXAOHs89witixpRjnynESMmkW90aXmCk40gG0mhhsxVSPM?=
 =?iso-8859-1?Q?FIdU4USR1o6e6nNbwYGLx27bv5enKEGzxoAZi7P6ouDgDqEoITtXR9GdRq?=
 =?iso-8859-1?Q?aVb9549sHhvRt5BufDRoRoRtQPKVVrbcTCbDTBP0juoixGAIlfhLA8cU5i?=
 =?iso-8859-1?Q?0ajqu7dHff3eXSdPW4+NTXZEvLrn2XrYi4r24CcL7Z3//C3oxch/igkEEs?=
 =?iso-8859-1?Q?UvJGm6fuOpRPrytAJQTUDdAknbwkea8mxxzHIO56jrOx01cxymmhoW2K8k?=
 =?iso-8859-1?Q?6hnkqM6grIsJ0OE01Ypxc6hQUza13+ABjwwAcHjCOGAJ7El3dy54ZBWJpA?=
 =?iso-8859-1?Q?pmhCuCiLdbRN7MoR1uSsBgesScBJgkayQvHZfIP2g+UMvm2rK5nEiazAkB?=
 =?iso-8859-1?Q?NGuYg5Ug0NklLJeTpbS+5KFw91RPbxrauUZffIoEfdXO53HwsJQvTj1Lfp?=
 =?iso-8859-1?Q?AsGlD/a6C+05ustHG0WgblreLtoH5rlmdc5c2ItB1FmdlpRwXusgQgyaFm?=
 =?iso-8859-1?Q?bSBZroRAfn7RexnpyE28YJb49utYFv4iTgJexqLAhdyAGJX6CcyXoULmIW?=
 =?iso-8859-1?Q?IrgsRaf42CWH5CjVl7d04StTUCZMIqNyXXBN7GBYebQbie2VD0+Scv/A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaa28d2-d58d-41f5-c776-08de120577f0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:26:23.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5vtzSuL0cWFjCBuHiyTNntkJfRzEueCY46HjlyB/KFjRfL0pJ6xg+f8xp65S9odbNaFJ9fR/pcNxJGyS7TEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5312
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 5.1% improvement of will-it-scale.per_thread_ops on:


commit: ddf7df94672b42db9a86b3225cf9ebcfdfefc506 ("[PATCH 01/19] sched/fair: Add infrastructure for cache-aware load balancing")
url: https://github.com/intel-lab-lkp/linux/commits/Tim-Chen/sched-fair-Add-infrastructure-for-cache-aware-load-balancing/20251012-022248
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 45b7f780739a3145aeef24d2dfa02517a6c82ed6
patch link: https://lore.kernel.org/all/865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com/
patch subject: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware load balancing

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_task: 100%
	mode: thread
	test: mmap1
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251023/202510231459.ad690ecd-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/thread/100%/debian-13-x86_64-20250902.cgz/lkp-icl-2sp7/mmap1/will-it-scale

commit: 
  45b7f78073 ("sched: Fix some typos in include/linux/preempt.h")
  ddf7df9467 ("sched/fair: Add infrastructure for cache-aware load balancing")

45b7f780739a3145 ddf7df94672b42db9a86b3225cf 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     12.30 �  4%      +1.2       13.54 �  2%  turbostat.C6%
     16510 �  2%     +11.0%      18333 �  5%  perf-c2c.HITM.local
     14007 �  2%     +11.9%      15670 �  5%  perf-c2c.HITM.remote
     30518 �  2%     +11.4%      34003 �  5%  perf-c2c.HITM.total
      4216 �117%     -82.9%     720.83 � 87%  sched_debug.cfs_rq:/.load_avg.max
    230030 �  6%     +21.9%     280349 �  3%  sched_debug.cpu.nr_switches.min
  32696287          +100.0%   65398751        sched_debug.sysctl_sched.sysctl_sched_features
     71075            +5.1%      74710        will-it-scale.64.threads
      1109            +5.1%       1166        will-it-scale.per_thread_ops
     71075            +5.1%      74710        will-it-scale.workload
  20012272            +1.8%   20374679        perf-stat.i.branch-misses
  20662368            +4.4%   21568525        perf-stat.i.cache-references
    181255 �  6%     +10.5%     200376 �  2%  perf-stat.i.context-switches
    177.39            +5.8%     187.65        perf-stat.i.cpu-migrations
     22226 �  3%      -5.9%      20924 �  2%  perf-stat.i.cycles-between-cache-misses
      2.83 �  6%     +10.5%       3.13 �  2%  perf-stat.i.metric.K/sec
      0.26            +0.0        0.27        perf-stat.overall.branch-miss-rate%
 1.609e+08            -5.6%  1.518e+08        perf-stat.overall.path-length
  19825311            +1.9%   20209803        perf-stat.ps.branch-misses
  20712472            +4.4%   21614327        perf-stat.ps.cache-references
    180352 �  6%     +10.5%     199276 �  2%  perf-stat.ps.context-switches
    177.05            +5.8%     187.32        perf-stat.ps.cpu-migrations
     47.47            -0.1       47.36        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap
     48.49            -0.1       48.40        perf-profile.calltrace.cycles-pp.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.39            -0.1       48.30        perf-profile.calltrace.cycles-pp.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     47.36            -0.1       47.27        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.do_syscall_64
     48.44            -0.1       48.35        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     48.34            -0.1       48.25        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.70            -0.1       49.62        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     49.70            -0.1       49.62        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     49.71            -0.1       49.64        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     49.73            -0.1       49.66        perf-profile.calltrace.cycles-pp.__munmap
     49.71            -0.1       49.64        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     49.11            -0.1       49.06        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.52            +0.0        0.54        perf-profile.calltrace.cycles-pp.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.54 �  2%      +0.0        0.56        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.67 �  3%      +0.1        0.74 �  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.68 �  3%      +0.1        0.74 �  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.71 �  3%      +0.1        0.78 �  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.99 �  3%      +0.1        1.10 �  2%  perf-profile.calltrace.cycles-pp.common_startup_64
      0.97 �  3%      +0.1        1.08 �  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.97 �  3%      +0.1        1.08 �  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.97 �  3%      +0.1        1.08 �  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     94.85            -0.2       94.65        perf-profile.children.cycles-pp.osq_lock
     96.81            -0.2       96.64        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     96.87            -0.2       96.70        perf-profile.children.cycles-pp.down_write_killable
     98.91            -0.1       98.80        perf-profile.children.cycles-pp.do_syscall_64
     98.91            -0.1       98.80        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     49.70            -0.1       49.62        perf-profile.children.cycles-pp.__x64_sys_munmap
     49.70            -0.1       49.62        perf-profile.children.cycles-pp.__vm_munmap
     49.73            -0.1       49.66        perf-profile.children.cycles-pp.__munmap
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.wake_q_add
      0.23            +0.0        0.24        perf-profile.children.cycles-pp.kmem_cache_free
      0.15 �  2%      +0.0        0.16        perf-profile.children.cycles-pp.anon_vma_clone
      0.07            +0.0        0.08 �  4%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.07 �  5%      +0.0        0.08 �  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.08 �  4%      +0.0        0.09 �  5%  perf-profile.children.cycles-pp.__pick_next_task
      0.07            +0.0        0.08 �  5%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.22            +0.0        0.24 �  3%  perf-profile.children.cycles-pp.vma_expand
      0.09 �  4%      +0.0        0.10 �  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.10 �  3%      +0.0        0.12 �  3%  perf-profile.children.cycles-pp.schedule_idle
      0.08 �  4%      +0.0        0.10 �  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.09 �  4%      +0.0        0.11 �  4%  perf-profile.children.cycles-pp.try_to_block_task
      0.45            +0.0        0.47        perf-profile.children.cycles-pp.__split_vma
      0.08 �  5%      +0.0        0.10 �  4%  perf-profile.children.cycles-pp.dequeue_entities
      0.16 �  2%      +0.0        0.18 �  4%  perf-profile.children.cycles-pp.commit_merge
      0.16            +0.0        0.18 �  5%  perf-profile.children.cycles-pp.vma_complete
      0.12 �  7%      +0.0        0.14 �  3%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.25            +0.0        0.27 �  3%  perf-profile.children.cycles-pp.vma_merge_new_range
      0.54            +0.0        0.56        perf-profile.children.cycles-pp.do_mmap
      0.08 �  5%      +0.0        0.11 �  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.05 �  7%      +0.0        0.08 �  4%  perf-profile.children.cycles-pp.update_curr
      0.04 � 44%      +0.0        0.08 �  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.41            +0.0        0.44 �  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.39            +0.0        0.43 �  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.18 �  4%      +0.0        0.21 �  3%  perf-profile.children.cycles-pp.schedule
      0.17 �  3%      +0.0        0.21 �  2%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.18 �  2%      +0.0        0.22 �  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.18 �  4%      +0.0        0.22 �  3%  perf-profile.children.cycles-pp.wake_up_q
      0.35            +0.0        0.39 �  2%  perf-profile.children.cycles-pp.update_process_times
      0.24 �  3%      +0.0        0.28 �  3%  perf-profile.children.cycles-pp.sched_tick
      0.25 �  3%      +0.0        0.29 �  3%  perf-profile.children.cycles-pp.rwsem_wake
      0.07            +0.0        0.12 �  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.28 �  2%      +0.0        0.33 �  2%  perf-profile.children.cycles-pp.__schedule
      0.18 �  3%      +0.1        0.23 �  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.update_se
      0.69 �  3%      +0.1        0.76 �  2%  perf-profile.children.cycles-pp.cpuidle_enter
      0.69 �  3%      +0.1        0.76 �  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.72 �  3%      +0.1        0.79 �  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.36 �  3%      +0.1        0.44 �  2%  perf-profile.children.cycles-pp.intel_idle_irq
      0.99 �  3%      +0.1        1.10 �  2%  perf-profile.children.cycles-pp.common_startup_64
      0.99 �  3%      +0.1        1.10 �  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.99 �  3%      +0.1        1.10 �  2%  perf-profile.children.cycles-pp.do_idle
      0.97 �  3%      +0.1        1.08 �  2%  perf-profile.children.cycles-pp.start_secondary
     94.33            -0.2       94.10        perf-profile.self.cycles-pp.osq_lock
      0.32            -0.0        0.29 �  2%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.07 �  5%      -0.0        0.05        perf-profile.self.cycles-pp.vms_complete_munmap_vmas
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.wake_q_add
      0.06            +0.0        0.07 �  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.06 �  6%      +0.0        0.08 �  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.04 � 44%      +0.0        0.08 �  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.34 �  4%      +0.1        0.42        perf-profile.self.cycles-pp.intel_idle_irq




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


