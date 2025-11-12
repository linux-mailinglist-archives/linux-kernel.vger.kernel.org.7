Return-Path: <linux-kernel+bounces-897121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF65C52138
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E2C64EF7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE82312829;
	Wed, 12 Nov 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkOWnFAr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89202D7818;
	Wed, 12 Nov 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947677; cv=fail; b=QkAFg10D6S/9p11T/0ynVHlRzIp2QvUnvYHhlrZGsXe4cMc1CwRcmXWphatWrvxqJdLuY3uV8TXD9UThfmdoy6jVBuqvP7Yb0JOzLDpATbRglwu7gk95jQWpUXVvjhW7K5krXeLUkJ5crSrc7WJ/w40WMNbjDZxQxUtCDVccvY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947677; c=relaxed/simple;
	bh=1iECY87GBIFsr7ptJAqYOIUokqD+dvV+XZcTHIDYK5Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHzNI6USeUCyJygpJyj7XXXtdDH5Fs9gX9qyP1oRKBnCwrXVtQwo9RejzoSuVJ69UqbhX7pHj1kWJQBXqHWrAEHraB31UD/CeYimvLhVzGCQz7XWsAxAPpQyGz9NtYxx0bm4ZPb+B4ATGJ6mn7J7WD9FzBQUdN7SzZmL64kh1Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkOWnFAr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762947675; x=1794483675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1iECY87GBIFsr7ptJAqYOIUokqD+dvV+XZcTHIDYK5Y=;
  b=MkOWnFArUkUC9fmQzMc2nFH1EkweVGyuAH3xvFvJ+e/TjjVkigLhXsC3
   iDozonKKSXo0oXnAfMe+NvNdryA/ennKnG1b3Z7gR0QMDnuPW+2nSJWGx
   eUAA5c4/XdcVvnP4EbSzk4m4kdLwagTuZliDdR1FxMS4A3nV/rPoDie20
   oidsLlVj2gWefCSJKC9OOA1bAchKkS17vRKCVCZnAUkQNjB/3WIyfOI1c
   VevODsoXr78M4DThpjIWDeTD3wqxt9V7ytIPbiKWLG9lPo3+lfW09A4KX
   /yhXoPGTSe0bixf99KWtbIUyG2T1YcdFsdSVj3zCDwzDhpKpxvdHfoMkH
   Q==;
X-CSE-ConnectionGUID: XBm4qJFjRFOKo3yFvpteBg==
X-CSE-MsgGUID: cKZoNVHXTMS+7qaNO8K2Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="67611268"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="67611268"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 03:41:14 -0800
X-CSE-ConnectionGUID: 9xV3rp1AQx2cR8GZMilDKw==
X-CSE-MsgGUID: nT60nG3EQRy63rzpWmhsvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="188456940"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 03:41:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 03:41:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 03:41:12 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 03:41:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJd5Vws+ST7xbfyLSmuGvL3pacVOEkztBN3IuSNK8LuVjMCkHBWYRzFkA7nHuQUC1OYQUIJtHqNbusnFEXLqbBble+jku4wq9cHBqCcML4o4cWmhp0Hrpk+SZD2xj76vH44R0Gb8s4IVBYzPE0RFsai5zYb1MtJJU83jrlQ0WfrlOarLU01jtmCgp7K0d99FklIpN0+wyM+dee9w78OzkIWVqZ/sqpiaqhwlD92ILNnVRE/nCUibPbTQfj71ZbAOD5b4i77oodGlnKke+9SLoQc6/0PZzQAy0WO2FFPKCZfXp6h26pUT31fmshIucS0KxW64nQkJ7h6rkg4tO9wUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3cAauSWYiktknyIM/LkCiMgO4XeQDbqVqbGjPz+83M=;
 b=NntuV5oo8pmZUouHIUraws/tnCBLugmSLlVCC17Knwu6xZQdk9euKRWHUmRl3Ce+XIKxxsR/gwSogQlaY0BSXSfwX7Si0its1Fh65EkoRRgNucXmJ6lYduXHfM0p42+PMNKPFZEO1VkRpNhiImC71F0UiLmjLFiInQ9tVlTxlbIq8OrgF7/dRl9IImORbZ+2OlwRb3g2KAaDMMgAppFEnJNKUG8yLRMqUXZJ62Zz6JyG6H8iRO3MixMo1alnfmK+1whcQGbPOw68Cet5SyNU7IhFl7uVq0m9ydtzPGRdl9rt7hhbMM9R0ZgvNkjpdwcNfrODtxA2HKlBPifMDxtGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by IA4PR11MB9250.namprd11.prod.outlook.com (2603:10b6:208:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 11:41:05 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 11:41:05 +0000
Message-ID: <930835ae-b65b-408f-84ff-d2ddaf4b58e8@intel.com>
Date: Wed, 12 Nov 2025 12:41:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: Intel: sst: Replace deprecated strcpy in
 sst_acpi_probe
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Liam
 Girdwood" <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20251111224706.87508-2-thorsten.blum@linux.dev>
 <20251111224706.87508-4-thorsten.blum@linux.dev>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251111224706.87508-4-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|IA4PR11MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a86847-e480-4d5f-fcf8-08de21e05d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkdscGlJd2lGNEpVMmJmSDY2azZDdkNxSVVTMFBCMjFvVHFpMmtPZ0V0dExE?=
 =?utf-8?B?OGQxWkdXWlNvZm9VWG1vRDd4TjYxallBL1d3cXl4WHZYZFBSK2dTRUxWbThl?=
 =?utf-8?B?YUdQWFFkNlJNdVBSazgreW5VUUFtZG02QUkrUTZJNFBOMDZFSnFxRmdvYXdm?=
 =?utf-8?B?Zll5R1ZhU2Q5SVhhS215aHkyUWw5OVh0VVFTTTNsUzhDbXV6V0UzdFoxa2g1?=
 =?utf-8?B?TDNsWUNvNVVoWU5PM0llT01zWUFpN0JTRUpkUHZ5SGgxeDV1c0dqZnhIQk92?=
 =?utf-8?B?QjlKYSszKzJMWnlCVG9mc25FZElyZVk3c1RmWW9RcG5TRFYxM3hRVjFtR2lP?=
 =?utf-8?B?YXMxbTdSM3F0MnZYUzBCSlZ5NThVZGVvcjFJS1NraThUVFlDKzNRSVk0MnZq?=
 =?utf-8?B?a2pLUjB6YlBCb2xPSkRMVU9BVUkybWx3dGhvUk9IMGNDcy82ZUZETDQ5a25H?=
 =?utf-8?B?eDFRRWgwdk1PRUdqMHcza3hYZzk5UVRFUHFyVkJUdkdvR2tSdzNWdWJuZ0pw?=
 =?utf-8?B?R1NBVThGN3k5QXRSOWIxYUNqTTI4cWd6UDZXT2d2TW9FZTZSb2ZtWHNCNlFz?=
 =?utf-8?B?Q2kzUEJ6YnZqMjk2K1FDL2hCWHFLMUZzNS8yWEhuS0xSV3NSVHBuaTFma1ow?=
 =?utf-8?B?ZENmT2d0Zk8xeDZmeDYrSzgrbGJaMkpGU3BvUXVRQmpNWngzWkRhNHBrMkFK?=
 =?utf-8?B?Zzk4SDJsNzR1bHVneXBtRWltUnJaZ2p3UXFqVHZaRzBqQjc5YlBFdDQ3WUNs?=
 =?utf-8?B?ZjdmMVJzdkNIaGNMdVVHRkozNEdPbjVoSTJVOXZYYjhwbHdmaTRZK1B4cHps?=
 =?utf-8?B?U3V3S1VCWklNOGttVkx5T3NYQ3lKNG9lcVhlbnppQXRUOUhuY3dQTVh3dUhI?=
 =?utf-8?B?TWtGOUs1d3g0aUxyaTRtVlpxdVF6M01UWkczdG1VaTZJVmVnR1pPc1hLM3lx?=
 =?utf-8?B?QjJpOEJpa3o1SzhRNHVaSEhuY3RvTDc4SjMvT2FCUDNwWDBXRUQyclp6UUJP?=
 =?utf-8?B?ZTkzR3RJRy92dTV3NjlVZDRONDZNZjNFZFJiRVBUc1ViQm9naUZBVE5LcU84?=
 =?utf-8?B?dzZGTXVGOEFJbG9HRTZ3dGU1T1BDelNtTlBHRnBlWEFscXB4ektYNDRSU0tt?=
 =?utf-8?B?MjgxbkFWVlNYZHQwZi9HL3A0WFo5cE9rcDZndDMyMTNzY1AwNTdjcDIyTHlC?=
 =?utf-8?B?VTVvUjhOZVNHbXlVdGZEeVVTazBtRmQ4MERrdThRVjRPdmk4OGo3dFV4c0pF?=
 =?utf-8?B?a1gwaGpDKzJ0VTlyZzlaRTF2ckhJMjJnTE5vQThwNWdYRCt5Y3VYY044WWxL?=
 =?utf-8?B?cUI1dmZ5TFRhdDZvclJ5VHlDVzk1K0o2SldyV05LTnFmT3ZqaDdvY2lBeE93?=
 =?utf-8?B?TnpqbHBhaXVXY3EyMmN6aDkrNlR5MVN2bHBVVkt0QmQwc2hGTUNOdzhKN01a?=
 =?utf-8?B?THVTK0pVSFRJTHJQTFlHQmJjNC83Rm1Ldjk2U2dtNlRUb0dKWXIwaFM5S3o3?=
 =?utf-8?B?Y1V0SEVWaUphbGloY1FBUlo5V2tyS0VrSFpycDQ3WkZxa0c0K0FreHRaRWZY?=
 =?utf-8?B?SzJOWkIvcER6aVdWSlNuM1JLbGdydnB1OWVhckwrTDlrTkI3M3oyREZla1p4?=
 =?utf-8?B?WkgvSTEvamI2ckorOUhwb2R2R1hyWHQyVWdlYnE1amhPS2xMSzlURmhsaksv?=
 =?utf-8?B?WVpLaWpNdDBhT29LeXByZjMydW9sbk9yS2paSHl1ZDlHdmY1eGxtU2x1eHNI?=
 =?utf-8?B?ZmsvdmgxSWl1UTZvaEpFQThSeURZaWxkUTFlNEJIODVJbEUzZHJSakJpZXAw?=
 =?utf-8?B?RlhGZmJta2o0RVlabHVueFE4Y3pYS0QyQnFqa2VUNHhqcnppR0QyZG1KTmlE?=
 =?utf-8?B?alVXWGZqaUVVNlVHZ2o0L1lsUGpnayt5TzlsWlhwWXZjbmcrZEh1RmJPYzJj?=
 =?utf-8?B?UmVpaDE2NGF0SzdOU1BVd0pqM3J3czIrUmRLb0FieTlVWG5jUW5qVjFjSm5l?=
 =?utf-8?B?OWFsd0NNam5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFMbjhVNjg0OGtmMFNITzJTbUMxV1VaRjJ2bmZhQ2Nna3hsM0Rzei9kSVhm?=
 =?utf-8?B?ZElaUVVic3AyWCtyS3czbStkZWJHOXhFS1dGUjFtenFDWXpaNUNySlUreUlQ?=
 =?utf-8?B?RStTc2UxQ0x2QjBCQkJ5QWtNcFJMZW5JUklBd1l3cm9qR001cGtPU0RRTjhW?=
 =?utf-8?B?Ri9pMjZ0aG1ITXJrMWhKNk81ZWtyWU01bmxiWDJBSDgrRE5UV2JvcE4wd1p6?=
 =?utf-8?B?VHMyVVYvek9EbTQzazU2Y01Yb1ZmYXRLb3RZWlFOR1NRTnN6bGJQWUhnODc2?=
 =?utf-8?B?WTVWYXpxWDFnWWxSblVsblZDNW1TUkVER0t6VUtaOWF5T0tCWU1wVDJUVVRB?=
 =?utf-8?B?YnRVdVR6RXIwY2hhclh3alFyZDA0U2JsUm5scmxBRnM5TWpUaU9YeGx4ak5h?=
 =?utf-8?B?MDI0eHh5RGhReE5JbkViSTRPSUNWNDRIR1BaRGd5eDBnWEdUSDVTWjA1SEYv?=
 =?utf-8?B?bWE0M2R3aEpTYWF2Q0w3NFlnQVN3cGhPSk16TFRURWJGdGthN0I1cUxUZlEw?=
 =?utf-8?B?dkwxK2ZWL2N1dFl2WG9zRC8rWG1LUkl0d1ByTDlxajk0aUhjN3pZUVJ6NWQx?=
 =?utf-8?B?OUQ0T1Yza2hLSGxNZHFOSGlra0doa0dRNlliM0ZRYTVlRXRZSThwWkMzUmhU?=
 =?utf-8?B?dFlkZjNKMDBwNjNlWFVreTBVL1h4aEtGYVRGaGNONDZ1YmV0aERyQzVWRTNp?=
 =?utf-8?B?YlZvaWY4blYwbzhCaVZFMVFZZjFYZFlpVGRPS1NlbXRIMEtFUm5uc01yZUtD?=
 =?utf-8?B?ZklCbzFkMno0dkpMVDMzaHlkZ1c3c0htN2pwMTNVNzRRS0lUUXR3ODRWcTFF?=
 =?utf-8?B?VVgzRDJwSmkwa0RaV1BXVjZqVUR5c1gwdUNqUlJuUWZ4NjI1K21xbWZQdUxX?=
 =?utf-8?B?M29LRm4wbFMwSTNabzhhdUJ0ZWJtZ1Fma2NkT2tOc0x0OGtlUGhVT2k1Z3hS?=
 =?utf-8?B?VmVNd1M0elBGQlJPNFR4STZKRUVRVkdiZmJyRzlNQUxnQnBMbjNQbDl1UElU?=
 =?utf-8?B?UTJvVEVZUElSYXkyTXQ4dGVjMkpxSDlTY0xvOUp2ZzYwVlpjZWNQK0p3cXpG?=
 =?utf-8?B?SUo3V21VaDkvbE1lY1hhQUFDNGZxRFZNRXpoV045aEJXUThNdGdJenZWVHlo?=
 =?utf-8?B?MlZzMmt5bEtnNVJ2aUJOUHVBSU5Ja0tsL1ZrQ1EzK2N1bVRTK1UwK3lpTDFG?=
 =?utf-8?B?VWhuR05hRVRBZ1h4ditKY0ZkSExHbDBNVERheXJkb1JZdzkrek9yTm9QNmpN?=
 =?utf-8?B?OHloWmZiNWZUakJqQXZSR0R4SzFNNzhQNzVFQkhiNC9pRkd1aGkySm90NGJo?=
 =?utf-8?B?VUFZc3JZL1Rvc00vcHFuREgyNURBV3A5blRrWkorSUFjNU9YS0kybEx6TlZJ?=
 =?utf-8?B?OVRraU0vN3V6SnZnOHpBZjhybWdFLzVZcXBuUXY2Y3UxMC9zQnBZL2hSeFFO?=
 =?utf-8?B?VHNDOXZKOXhHcE9EdUdDeThlS3pBQktXUWNpMnFheWFFcFRjT0FFcFRPMmZ3?=
 =?utf-8?B?Z2ZKMlczeG00ODFaUUZxQ1BBMTcrZWNuS01qc3NyUktUVDJFVThkSDZTYVg5?=
 =?utf-8?B?WklYT3FHeldNT3loTVhtcWkrZHVZWWRyVFdEanhOUWEzUzMwQkVGMzNuTU40?=
 =?utf-8?B?ZmJjV09EL3YwUXBSVFFoQTd5RjlhaEVldVN3RVp6dUljWFdZd1N6eWJISWRM?=
 =?utf-8?B?NTlKdXJQUjExaCtTSnhwR1FBRjdKVkNLdHVQNFMxQnlSMFY0OElaQ2JpN1pX?=
 =?utf-8?B?d0xYS01QM0hTSmh6bHdLOFlNR2NsVUJwZFhtZ2lqMnpKdmV1eVljY3FwWFNv?=
 =?utf-8?B?bG11M0o2VFhPRkg1aEhwNDlLc2FmbW5NZ29hZ25XY3MzcEVNM09CazN0dmxz?=
 =?utf-8?B?VHRkdmJIUjRsMnlieHFhbERCekQ0T2RVZXA4UWR5Q3lRWXZIY0o3RkI4QVRj?=
 =?utf-8?B?MHR1U3hDUVhkMUJYcHcwUjR4Y3NybUc2RkNrSm5ud0paNC9iMTdGZy9sYysr?=
 =?utf-8?B?eWRIcTRXSDhFWXFIdGNhYW55Ylo2ZzRMc20zWVVKOWVDS3ZMK1ZYc0ZWQXBm?=
 =?utf-8?B?Z3BMZ3NMdEdDbEZicmV3aDRBZjI0U2owaDFnOVovMk5Dbk9oRFNwamlnTkVG?=
 =?utf-8?B?RFNqM2ZRam1WSFhqSit1MlRrTGEwSFhCaGtXOHpCZXBqc1p1bGV5ZWpTeVpy?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a86847-e480-4d5f-fcf8-08de21e05d2a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:41:05.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMuLwM4Ape5Ofp2pFcuYI3Bq92kgELULVuY9/6j/FO4AiwK62UHFTq6FdCCgokgN9W0WUtFAoDccspqnc71cJ/brni0g7pBtcdlAf2c4Z9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9250
X-OriginatorOrg: intel.com

On 2025-11-11 11:47 PM, Thorsten Blum wrote:
> strcpy() is deprecated; use the safer strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   sound/soc/intel/atom/sst/sst_acpi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 257180630475..73624e1b138a 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -12,6 +12,7 @@
>   #include <linux/fs.h>
>   #include <linux/interrupt.h>
>   #include <linux/slab.h>
> +#include <linux/string.h>
>   #include <linux/io.h>
>   #include <linux/platform_device.h>
>   #include <linux/firmware.h>
> @@ -356,7 +357,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
>   
>   	/* Fill sst platform data */
>   	ctx->pdata = pdata;
> -	strcpy(ctx->firmware_name, mach->fw_filename);
> +	strscpy(ctx->firmware_name, mach->fw_filename);
>   
>   	ret = sst_platform_get_resources(ctx);
>   	if (ret)

Thank you for the fix. I'd update the title though as 'sst' is 
confusing. It stands for Smart Sound Technology and applies to most 
things sound/soc/intel/*.

Go with either 'ASoC: Intel: atom: sst: ' or just 'ASoC: Intel: atom: '. 
In fact, I'd just merge the two patches together given that both address 
one driver - Intel atom sound driver.

Given that this is a small change, feel free to append in v2:

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

