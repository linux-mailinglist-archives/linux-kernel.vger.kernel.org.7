Return-Path: <linux-kernel+bounces-804743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B80B47C6C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05723BFF8C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0FC27FD74;
	Sun,  7 Sep 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOudlJnU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9B26FA67
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757262551; cv=fail; b=b2UCwW66hcoLf52DSJ4waXOd/ycfNWDXqByV3UhEtDmgEpYDstK7nJd2OL18rWsknGikHwiJHh/gZJe1DXjO37y4bvSdGfCv8pmyo3c2zT17OTBeHs6NZDZVI8xschsk2DyBcQP+CDsPjH/Chjx4eNINStg8nq1GgRf3/gMPueQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757262551; c=relaxed/simple;
	bh=EKoog7OX8ZyK0UaS/zBFapxON4l977oH/qzfJNRcOjY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LTCFVaBOS3Tzy+v5bnr3hnF3YMu8keVv38R8Yb+Vmqm1U318fD2e3/mbkMbec4VICk4MymXJdEsDqUoZfTfUli5gd8et1zsgXRhQ3v5ymetGuZj3engP9dxv+2tp3YRR0FgpEM/80zSDax9GnPwGneN46Tk7QRd6OhvpBMs8KEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOudlJnU; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757262550; x=1788798550;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EKoog7OX8ZyK0UaS/zBFapxON4l977oH/qzfJNRcOjY=;
  b=cOudlJnUHjj1vYCofF+t3pGKHWyCoeN5dT8FufyTrsFlK4PKad/2S/Cu
   AFyzy94wwXxik0TN0h7a7KAH3SMnB/MDMDbv9d4zKhpcvWb7cYjEC6A42
   qv1eO4z/Syqnt6W8o2ltCPw6kwX4EFRPBX9Oh/uAEIjszvWlNrd8eUMQS
   OLWLlSKg90Dt1Y8IL77tGKL9nBykjuK3N0GD7snAXlWtoH86WP8Fq1cNm
   K9gS1APNzFG8ncj8SpShc5UPTV5ONebqCRbYcrXe526yg/2FOeeU8S2Gk
   PrwjveT/00JTpop3khWVdH1LFFp4pdRZP02pP4Zj1uDRRnqy0+X7v4hVD
   A==;
X-CSE-ConnectionGUID: QyLSxPMsRqWG2CQnp9uS2w==
X-CSE-MsgGUID: PObYyP5/TXWds4EHfv2ekA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63363151"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63363151"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 09:29:09 -0700
X-CSE-ConnectionGUID: oigjwzkcTOSHbidTLzm5Tg==
X-CSE-MsgGUID: fssOdlNlTS6+FxVJuZ4lbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="173048210"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 09:29:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 09:29:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 7 Sep 2025 09:29:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 09:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0UVI+NdtvP11DNOVGK1nqxmt67osT+aRbHXLTF6KQG4daSoPMmaf+2bBG1i15Wdq+iEjk4UtMsb5NKqV9BzcQg8Tov+cspPR04yoN9GItQxDsb6+js2jdFdAsfc3WNnDMXfNO9nH/DTaLpP40W1fTgpFxTzg1FaGEun+kIDrnPnJqu8etkWzAiYk/mZyPtHnG8wAB5zJwIu0kmqkxFZw/wAH6uizG56Z6YnTFLepGPtqwm7aCwBBp0RO1GHv8dcFgFN5e1X+Swp+0r4DSe02DpXidadI+eE0Ons4+jre/KMGJ8kMZXHSHz8gMz0uTARjs/8WJRX0ldmaT5Gqm3P+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/N/YqF/dhJTweKnF47W6BM4QzyWAIFAiTZjTnCLipc=;
 b=i85v1XY4bOeSXwLEIF/jH+6+sApYEwE72wrHT5VYNygdmIPMfqcQBGiqFu1SgW/CtA2ooee8lCwHmIWABKHrrRfSwzMG6+Qf3oou1N3Hg5JRcOv2FFLcFTQhm6tXNPuCoVggKvXRupPWSX5vkx7rL1MKK/tYhsa3m1gZv5TGoXvgFqTz8ZoGlAasOWlZX6p4XPmq6TJiyK4j7/oUouz9LByl8udx5kJjwf9DaD3I/EVdl8wYsK/foDVQefQCgggoQ+LhyXJZJTeJBQWMeIOxT39Nzbuq/cefiaGvQs7x0muQLcjjiC3pEukOVZxTsWED24OxcSe1u2nKgJEZrDEJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Sun, 7 Sep 2025 16:29:04 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 16:29:04 +0000
Message-ID: <07938684-0010-4510-9350-0f6d9a83461b@intel.com>
Date: Mon, 8 Sep 2025 00:28:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched: Create architecture specific sched domain
 distances
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Zhao Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
References: <cover.1757097030.git.tim.c.chen@linux.intel.com>
 <61a6adbb845c148361101e16737307c8aa7ee362.1757097030.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <61a6adbb845c148361101e16737307c8aa7ee362.1757097030.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1ab684-c53d-4039-3d8b-08ddee2ba8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWVORHg2KzJnTXdxYVFtZEwvZFBOSkM4SFEvclhoaDdJRHRzL1pKbEM5cW9N?=
 =?utf-8?B?bjZabjNqRm9YWHBydlFmUUJUdlRaaStPOUhZbi9raThnRmtGZ003dG5paEl0?=
 =?utf-8?B?K3lWZWtFcHpDQVpGRE55eUxKM091OWU0Q1Y1ejVJdFM5REd1eDJ4NmEvZUVa?=
 =?utf-8?B?T2EzeHV4MkZJSk5OSnZrZEZPaUpyOWNPS1lRNFZhNUtuRnc2NWhoOEc5emxD?=
 =?utf-8?B?THVlR1lub2ZZNVZ6c1MxNENJa1BqbThTV0pva3RFMFNSTWYzWWRqWmRIZGFT?=
 =?utf-8?B?TVhyUDR0T0lPcmQ3RXkzR3RvUDMxSDlDaWNRZk9PS0ZuaWdmc25Lb3duNGJ1?=
 =?utf-8?B?Q3o3dm1QR1Jub3RzVjcyV0tLYWRYWk5IanVabXlTK0xpcnlTUnEySjlGWEt3?=
 =?utf-8?B?WXNBeXlVcUNYb1l0b0U5b0psTVBLckJvMXNKN09OWUNUVUtDOTdCMWIvdGZJ?=
 =?utf-8?B?ZTFvZlBDQ0VKanY5L0VZT2NBeGo2TEVHZUNBNmNBTHgzTlRYYWxTRHdQdDN5?=
 =?utf-8?B?WFM1dUlrQkd6bXlaYkpOZ1pkellNWjE3dE1NOXB4VUNTN3N0OGM1UnVLNE00?=
 =?utf-8?B?TUtvbVVWaHUwZUhGRk5IRDQvbVRUYlNDeGtBMDdpUUFyS2lSSzNFTmRzZTNt?=
 =?utf-8?B?ZnJZU1h6M3NvVDN4NWNkUGloc1pMWG54N3F2RDc5cFV2angvUlIwVlhiZWYr?=
 =?utf-8?B?aHdzaU1ubHNuMkFiUFd3OVdBS2hIRWJrc1JHTzVSaHE4TmFnV002RCtmSVhu?=
 =?utf-8?B?c3JyWmJ2eDY3RGZndFFOc0RSUW90aEg2Wm1QaEdhSjVOWlBKM1A4dFJ0ZSsy?=
 =?utf-8?B?OSs4cjRDV1pxNmllM1BJcUJxR2ZTTlFOejgyOGh1OXIvN1hMUDRleEMwb08y?=
 =?utf-8?B?bDd1WmM5T0FrWkUzUWk5cStQOW1DQUFSWGU5b013bk5oVG5TREthWHI0d01S?=
 =?utf-8?B?dzR5TE5pY2dvMjZRTGJPTnpoOUlPaG9sYTN0VjBzZGxrRkRsTmZBckdCZFVU?=
 =?utf-8?B?dW5obi9xU25oRXB0eUU2OUYyaHB4bTZwZ3Q1T2ZFejMvS2kzclZha2c5QnVk?=
 =?utf-8?B?OEx5dk1NYXJhcnJtamNGOU9PejdyNjFBTS9uZnJBTE1qUzVUa1ZEaEsyWnI0?=
 =?utf-8?B?NG9ic1RHTC9TRDYvcUFCVS96ZFRnQjFCMDBhTk5qSFJseGN0QWRxdmE4UTNT?=
 =?utf-8?B?SldtTHQwdVl3MHJrNENXZ1VvYkFKSjVYaHJsNERsVzJCV3dBek9wZFFJVlFz?=
 =?utf-8?B?WWV5bjgrN01aRkxSaFhDV2NZTjZXMDU0OU1wVnAzWkd5K3FGdVBaRXgrWXZj?=
 =?utf-8?B?Nkdwc2NRZGpTWkVGc3BMeUdkc2pJUjZ5SVFybTV3S294V2h6TEw4VW1OOXdV?=
 =?utf-8?B?K1JQQVBpYWpMbHNUOVVzTmdWbHZNZ05GcW94M0t4UG5Ta3B1U2s3aUJ2VS9S?=
 =?utf-8?B?K3BHa2RkU1VyQmxYcjhCejRYTDdYVDRpSFM0QnpPQ1VFcnRpWkkrOUNNVUUr?=
 =?utf-8?B?KzcrM2JTYXVMQjdxWmtNZWQrcVdzTEd1bjlGeTdTNS9MOTlhcjE3cXljMVhk?=
 =?utf-8?B?UkFwdEVEOTBtcnlsNGplZHVuY042cGU5S1NVemZBc0syVHdHKy9TTEtCbVAz?=
 =?utf-8?B?TTJXRlB1c0M5SW9vL0UwdEo3aUJXMndQUVNGVmtSeC9IK3VkaWZYeEdEaXd5?=
 =?utf-8?B?M1pBKzVaSUQ4b3hwdURXeGtza0ZnR2t3Q0l0bUtzV2xWQVJuRzUxSkJFeFBO?=
 =?utf-8?B?RUt1ekZpcS9zTUgxU1VIT3lOMFFEU0pRM1JNTnBrRFhjOVN4a2gwamwvS2RN?=
 =?utf-8?B?ZzFkMno3SjhDb3VsZzRaWFVSaUZUdDVQYVdmSFA1aCtZRXlRUXIrQXF1SW44?=
 =?utf-8?B?NHF6Q3Q1aGJWUjhOWUhZd3l0UTZFcGxmVW1JcnJXUXoralE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFkzZjZwSEE5dGVUZUtLRjN4OFVqVy90NWhmNFBpNEhlSXB2aHhFclhiTXRU?=
 =?utf-8?B?cUtsVnY0Zm5kOUVWMjlqS0RVV3NzYTRLMnkvaEoyOTFmYmRKSVlSejFrcnB1?=
 =?utf-8?B?eVNhbzVBSXV3T1Z0RW0yNTBMZmRDd0lYNzhNNG11UDRVSDUranlFZE1OdTd4?=
 =?utf-8?B?MHVUYWdIZXVYcEVFTXJSTWhWV0Y3ME8vYmkwMUYxSzEvUkVCV2w0VjZpd1JQ?=
 =?utf-8?B?QzhEbjFLbXlFbFRqYk5iWG9GWlZtNmV3K01hMjV3VUFjd0ZLSTExY0RGTUNu?=
 =?utf-8?B?ME1CbVVEekRrUjhOeXF5YzBiejBQbEFNbVlNakozc2VORlg0dC9TUVU1ZmJ6?=
 =?utf-8?B?TTRScWtMMnBVRGVMb1pERlY3ZkYrd2VHVk0rS1B6YVZpek11WHJMVmZ0bXR1?=
 =?utf-8?B?NlhpT2VDaTVJTHM2UGlaaUdoZnMvR0lxMmF1WCtxYnM5WlVFaUwzQkVyOWcz?=
 =?utf-8?B?QW5YaGNFZDdLL1oyZzZiaW5xYTNMVVNnZEZTYTNwb0srTzYvMHVQTXNIM0l5?=
 =?utf-8?B?RHQ0Q2tkcTF5VkVUOWpubXRBYmlpeVpiOFplWXpBeFZSRUMveEpLQVdCMUlW?=
 =?utf-8?B?VlVoUVo0SG1SM3BYNnEySWd0ZU50VGFNc0l0clFlL2pNNXVsNStFWmhnVGFx?=
 =?utf-8?B?VzZJVTZ5d3JDb3ZrV2x3N0N0U1BDeVNlUVM2TC9ERmJ4NjJMZWhRUDJiQTJp?=
 =?utf-8?B?c09LUXVCbW1yMUJyckIveENEdnJZNzY0eU9MTFVWbjRkSVZ1elNkaDNLYWZI?=
 =?utf-8?B?MCs0MGs1VmlQWjhwLzRydkZyZmhUMFIzT2MwTFR5NTFRc0FUbmxzVkQ1amRB?=
 =?utf-8?B?Qm9LM2c3bUZIajNBM1IrU3FXcC9qR1JwemVRaVZyYWx3SVBYT3BkKzhHbEdo?=
 =?utf-8?B?STJxakhqVVhBcVFYQ1V5R3BJaE5WSDJhYVRSV2I4bVFXTWNRTFAyS0Y4WEdl?=
 =?utf-8?B?am5DZExSTXRtRjlHanp3em5sazVhK3NSNmFZWTRNdnU5d1Rvb1h1dzVXSDQ0?=
 =?utf-8?B?a0dOUlBzYUlvaWF2bHAwQmdMZnpOZ25GU1BQOGVwcmtGWWNiRVJYQnBRelZ1?=
 =?utf-8?B?Zi9JQTlsM20xRUNDbWRjcHVMK2pKWUc2TnhjSWxab215RVJqYUpkQjZLSkR5?=
 =?utf-8?B?MHNEanAzTlJtamFsbU1FbVR5SkJpY2ZieXh4N1drQ0QyWHNLQSs5a1ZNaVRQ?=
 =?utf-8?B?MndMaDg5dlVvU2l2MGp2c003dXNVQlBKYVdzWE50MjJVL2Zha1g0QnhGRWd0?=
 =?utf-8?B?RjF4RHUremxzSnJzMkVUQm1LOUo0YWdhakIwcEMxNlJSZjZ1dVV4TzNlbHVq?=
 =?utf-8?B?bDdVcms3cVVjZ0lXNld2YzJNZkkzY2FWQU1mSndZZjVCcGRHcHJkdjF3Nll4?=
 =?utf-8?B?MTNTeDMvK0YwN0RkcWpGWDNlUENIcXBGcGZKUllDeFBQeGQyck16RVIrZTdW?=
 =?utf-8?B?UFE3aDY5L0wyOC9LemRxYU9qSVFWWnZPV2dQc2pIWG9qWC9obnZFb09udXBE?=
 =?utf-8?B?VmZTVENOVnZGZXRNSjl0dmhZSjdOWDdCclhCYmhscmFOMGhRZzNPQkV1REZx?=
 =?utf-8?B?YTlhdVpvdktQdGpvQUlOTnJ5UTJSZjUySHk0aUloY3h4ZTNoTmhJWHVxZXM4?=
 =?utf-8?B?RUhuUlV4bHN2d3hhWHcyU3JUbGFTSlZQZUhUTDF2OFV6N0hZUkRXWkFIY2R5?=
 =?utf-8?B?citSR21sQU1uMThWSG5VNXptV0d1Q1QyZXJFcGdKRFpiUDRvcUdNSms3V2hH?=
 =?utf-8?B?VFFhNThGMDYyQjNKRWxpZkxmWXVZaWkxTDB3TklXbGxZdHZpVkhNaVVzZnNF?=
 =?utf-8?B?VGU2UFRwRlVhMnVMdWlVSHN5NmZScWZUdGNyOWczNzFhanJLaVVOR0FGbFdQ?=
 =?utf-8?B?bTlYdlM4Y29ZQTZJekxXUUlsWmhkMlp4aW9EaWg3WHFOK1dzUTdHaDZxV25O?=
 =?utf-8?B?WEdtUkx3MEZmb2RFQTdyUGdYdG9jWm95TkZOK09GdjZ6OXVXQjJ4Q0Qya3Bl?=
 =?utf-8?B?MDR4bEYwbjVIS0JPUUxadzFjNFltWS91dHhJbFEyTnp6aUQ4VkRTdXIxWC9m?=
 =?utf-8?B?Snd3SVdQZUNqOTFPcDZ3eEVpNEc3V1NQcHF4WE1rZkxMMGhTZEZra1VEa2E0?=
 =?utf-8?Q?wwAik8A3yhvOGCFOaINtjt9S2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1ab684-c53d-4039-3d8b-08ddee2ba8fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 16:29:04.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox2Bdpeg9CGOivroQSAhIwj2QBP3OoXuKfTzn5CiDfQe9MmtR4pxwCxzJKyTVFgvorZJpLpIYy3z7NOuMCCwmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com

On 9/6/2025 2:36 AM, Tim Chen wrote:
> Allow architecture specific sched domain NUMA distances that can be
> modified from NUMA node distances for the purpose of building NUMA
> sched domains.
> 
> The actual NUMA distances are kept separately.  This allows for NUMA
> domain levels modification when building sched domains for specific
> architectures.
> 
> Consolidate the recording of unique NUMA distances in an array to
> sched_record_numa_dist() so the function can be reused to record NUMA
> distances when the NUMA distance metric is changed.
> 
> No functional change if there's no arch specific NUMA distances
> are being defined.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>   include/linux/sched/topology.h |   2 +
>   kernel/sched/topology.c        | 118 ++++++++++++++++++++++++++++-----
>   2 files changed, 103 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 5263746b63e8..4f58e78ca52e 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -59,6 +59,8 @@ static inline int cpu_numa_flags(void)
>   #endif
>   
>   extern int arch_asym_cpu_priority(int cpu);
> +extern int arch_sched_node_distance(int from, int to);
> +extern int sched_avg_remote_numa_distance;
>   
>   struct sched_domain_attr {
>   	int relax_domain_level;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 977e133bb8a4..1f08dfef2ea5 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1591,10 +1591,13 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
>   enum numa_topology_type sched_numa_topology_type;
>   
>   static int			sched_domains_numa_levels;
> +static int			sched_numa_node_levels;
>   static int			sched_domains_curr_level;
>   
>   int				sched_max_numa_distance;
> +int				sched_avg_remote_numa_distance;
>   static int			*sched_domains_numa_distance;
> +static int			*sched_numa_node_distance;
>   static struct cpumask		***sched_domains_numa_masks;
>   #endif /* CONFIG_NUMA */
>   
> @@ -1808,10 +1811,10 @@ bool find_numa_distance(int distance)
>   		return true;
>   
>   	rcu_read_lock();
> -	distances = rcu_dereference(sched_domains_numa_distance);
> +	distances = rcu_dereference(sched_numa_node_distance);
>   	if (!distances)
>   		goto unlock;
> -	for (i = 0; i < sched_domains_numa_levels; i++) {
> +	for (i = 0; i < sched_numa_node_levels; i++) {
>   		if (distances[i] == distance) {
>   			found = true;
>   			break;
> @@ -1887,14 +1890,29 @@ static void init_numa_topology_type(int offline_node)
>   
>   #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
>   
> -void sched_init_numa(int offline_node)
> +/*
> + * Architecture could simplify NUMA distance, to avoid
> + * creating too many NUMA levels.
> + */
> +int __weak arch_sched_node_distance(int from, int to)
> +{
> +	return node_distance(from, to);
> +}
> +
> +static int numa_node_dist(int i, int j)
> +{
> +	return node_distance(i, j);
> +}
> +

numa_node_dist() seems to be used only once by
sched_record_numa_dist(), would it be possible to
use node_distance() directly
sched_record_numa_dist(offline_node, node_distance, &distances,
				   &max_dist, &nr_node_levels))?

> +static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
> +		int **dist, int *maximum_dist, int *levels)
> +
>   {
> -	struct sched_domain_topology_level *tl;
>   	unsigned long *distance_map;
>   	int nr_levels = 0;
>   	int i, j;
>   	int *distances;
> -	struct cpumask ***masks;
> +	int max_dist = 0;
>   
>   	/*
>   	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find the
> @@ -1902,17 +1920,20 @@ void sched_init_numa(int offline_node)
>   	 */
>   	distance_map = bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
>   	if (!distance_map)
> -		return;
> +		return -ENOMEM;
>   
>   	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
>   	for_each_cpu_node_but(i, offline_node) {
>   		for_each_cpu_node_but(j, offline_node) {
> -			int distance = node_distance(i, j);
> +			int distance = n_dist(i, j);
> +
> +			if (distance > max_dist)
> +				max_dist = distance;
>   
>   			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
>   				sched_numa_warn("Invalid distance value range");
>   				bitmap_free(distance_map);
> -				return;
> +				return -EINVAL;
>   			}
>   
>   			bitmap_set(distance_map, distance, 1);
> @@ -1927,17 +1948,70 @@ void sched_init_numa(int offline_node)
>   	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
>   	if (!distances) {
>   		bitmap_free(distance_map);
> -		return;
> +		return -ENOMEM;
>   	}
> -
>   	for (i = 0, j = 0; i < nr_levels; i++, j++) {
>   		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
>   		distances[i] = j;
>   	}
> -	rcu_assign_pointer(sched_domains_numa_distance, distances);
> +	*dist = distances;
> +	if (levels)
> +		*levels = nr_levels;
> +
> +	if (maximum_dist)
> +		*maximum_dist = max_dist;
>   
>   	bitmap_free(distance_map);
>   
> +	return 0;
> +}
> +
> +static int avg_remote_numa_distance(int offline_node)
> +{
> +	int i, j;
> +	int distance, nr_remote = 0, total_distance = 0;
> +
> +	for_each_cpu_node_but(i, offline_node) {
> +		for_each_cpu_node_but(j, offline_node) {
> +			distance = node_distance(i, j);
> +
> +			if (distance >= REMOTE_DISTANCE) {
> +				nr_remote++;
> +				total_distance += distance;
> +			}
> +		}
> +	}
> +	if (nr_remote)
> +		return total_distance / nr_remote;
> +	else
> +		return REMOTE_DISTANCE;
> +}
> +
> +void sched_init_numa(int offline_node)
> +{
> +	struct sched_domain_topology_level *tl;
> +	int nr_levels, nr_node_levels;
> +	int i, j;
> +	int *distances, *domain_distances;
> +	int max_dist;
> +	struct cpumask ***masks;
> +
> +	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
> +				   &max_dist, &nr_node_levels))
> +		return;
> +
> +	WRITE_ONCE(sched_avg_remote_numa_distance,
> +		   avg_remote_numa_distance(offline_node));
> +
> +	if (sched_record_numa_dist(offline_node,
> +				   arch_sched_node_distance, &domain_distances,
> +				   NULL, &nr_levels)) {
> +		kfree(distances);
> +		return;
> +	}
> +	rcu_assign_pointer(sched_numa_node_distance, distances);
> +	WRITE_ONCE(sched_numa_node_levels, nr_node_levels);
> +
>   	/*
>   	 * 'nr_levels' contains the number of unique distances
>   	 *
> @@ -1954,6 +2028,8 @@ void sched_init_numa(int offline_node)
>   	 *
>   	 * We reset it to 'nr_levels' at the end of this function.
>   	 */
> +	rcu_assign_pointer(sched_domains_numa_distance, domain_distances);
> +
>   	sched_domains_numa_levels = 0;
>   
>   	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
> @@ -1979,10 +2055,13 @@ void sched_init_numa(int offline_node)
>   			masks[i][j] = mask;
>   
>   			for_each_cpu_node_but(k, offline_node) {
> -				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
> +				if (sched_debug() &&
> +				    (arch_sched_node_distance(j, k) !=
> +				     arch_sched_node_distance(k, j)))
>   					sched_numa_warn("Node-distance not symmetric");
>   
> -				if (node_distance(j, k) > sched_domains_numa_distance[i])
> +				if (arch_sched_node_distance(j, k) >
> +					sched_domains_numa_distance[i])
>   					continue;
>   
>   				cpumask_or(mask, mask, cpumask_of_node(k));
> @@ -2022,7 +2101,7 @@ void sched_init_numa(int offline_node)
>   	sched_domain_topology = tl;
>   
>   	sched_domains_numa_levels = nr_levels;
> -	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
> +	WRITE_ONCE(sched_max_numa_distance, max_dist);
>   

Would it be possible to use
WRITE_ONCE(sched_max_numa_distance, distance[nr_node_levels - 1]);
so we can simplify the code by removing the introduced 'max_dist'
both in sched_record_numa_dist() and sched_init_numa().

thanks,
Chenyu

>   	init_numa_topology_type(offline_node);
>   }
> @@ -2030,14 +2109,18 @@ void sched_init_numa(int offline_node)
>   
>   static void sched_reset_numa(void)
>   {
> -	int nr_levels, *distances;
> +	int nr_levels, *distances, *dom_distances;
>   	struct cpumask ***masks;
>   
>   	nr_levels = sched_domains_numa_levels;
> +	sched_numa_node_levels = 0;
>   	sched_domains_numa_levels = 0;
>   	sched_max_numa_distance = 0;
> +	sched_avg_remote_numa_distance = 0;
>   	sched_numa_topology_type = NUMA_DIRECT;
> -	distances = sched_domains_numa_distance;
> +	distances = sched_numa_node_distance;
> +	dom_distances = sched_domains_numa_distance;
> +	rcu_assign_pointer(sched_numa_node_distance, NULL);
>   	rcu_assign_pointer(sched_domains_numa_distance, NULL);
>   	masks = sched_domains_numa_masks;
>   	rcu_assign_pointer(sched_domains_numa_masks, NULL);
> @@ -2054,6 +2137,7 @@ static void sched_reset_numa(void)
>   			kfree(masks[i]);
>   		}
>   		kfree(masks);
> +		kfree(dom_distances);
>   	}
>   	if (sched_domain_topology_saved) {
>   		kfree(sched_domain_topology);
> @@ -2092,7 +2176,7 @@ void sched_domains_numa_masks_set(unsigned int cpu)
>   				continue;
>   
>   			/* Set ourselves in the remote node's masks */
> -			if (node_distance(j, node) <= sched_domains_numa_distance[i])
> +			if (arch_sched_node_distance(j, node) <= sched_domains_numa_distance[i])
>   				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
>   		}
>   	}

