Return-Path: <linux-kernel+bounces-731637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5195EB05783
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7444E3BA0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BBF2D6401;
	Tue, 15 Jul 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYFF+5jv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CCF2D5C7C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574153; cv=fail; b=mrtc9LeQEhgx0qR9xT95PAlVrX2D7s1sOGnt1KICgzgrcWJb88YIeslxyPnrgKhnKlP1IGp+Ddy0ZjPCGdNrGtDK39RidxsCB39LJpAXDxH9mydwWOFJoY0Fes3/Bjut4O6zhkUS7jhDymF/9ZqKEyOV5ynWIHFBjRwn9qoqwnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574153; c=relaxed/simple;
	bh=o0cW4uxDRI879TGFzxm0OzbopmEfTqe9XBbnogCuCN8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7ukcg45fXqJ67xY03LrDFzdNn7gvU+qwh454v+yzbILBYYUrw2JXDv7i2IazDeHpkJ7sgm812ApUg+saazR5fxhrvUo5Y70iZFcb08TSVfnNWGowp6Ed9AToYnkIrfQDfIwDSlwPaMIiEAVKK59KD57MKILP3wHnvcbaRaRPNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYFF+5jv; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752574151; x=1784110151;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o0cW4uxDRI879TGFzxm0OzbopmEfTqe9XBbnogCuCN8=;
  b=eYFF+5jvBrflBsIUSqhfFvEdmOr/LfefUujggCTfuOJ0Ijdcu0vhSRzI
   tP+NfaQEm19neNtPkU++N5A/T2zzlL+DhpBQJ+5irIAtkcy1wFgEGCAIl
   ukf93afb3BdmprL7apFKyQuL7j82nIo00BsQJ+R/YrEHpko50Nywja0XK
   1xeSFu8sEs2hYm2LEtzpQrmDD0mtuydvQp7nEouSnbpXK4zrOF9yrEbZk
   kWM+NEz1KMtAj2TYV5/Yc7rr+bkbQhAiQ0pZ4lLQ0vTuuHRMXKq+TVH/g
   glT+HJ+G2j2I+ryNdtWfVTzYw/AVMCpJV89bZR7FJBcP4GwIIilMr8fsY
   Q==;
X-CSE-ConnectionGUID: TCPMCiJBTiO/XOvfLhyE9Q==
X-CSE-MsgGUID: YcbMbAShQcaHGOGlgtdoZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53901623"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53901623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 03:09:10 -0700
X-CSE-ConnectionGUID: IM6lpfUpSw2gY1SazNjv7g==
X-CSE-MsgGUID: AYPbzgsiTQuoZe0qz7LJMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="180881477"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 03:09:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 03:09:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 03:09:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 03:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODXfeL5WOFFvKp/spmrQnyqCexMR2KscD9sJrNOh8A/Kyt7k0svFglz8uglu6qV6n472PCCOMnlZBitDVuTv6tm40tsuGgIlu/o4/Q6Y4KX6f+2qxA8NsLZynnPq+Zq2dlMeYu37eV5XmDFjXjV/0vlHs9lY9GSkBElEa4GU+1MEthMl8ZqRIYSpilFQlIIAb0HF2K19Hi1b3QWYfM/5zKXOnSUL128rvqj1S6zl7rQj1jnpydrXVf9E4kA7Y8brISWU6obe1ze6W1B0MyppYq+COr/bgXKw25h/KpX5b1NDDZh0IbzOn/cMMSFNfT9/FANzIWugqesGmlCweod/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/klWFPsV1mhofs9uCeE0f3b1evCy5q/426oH/tEmELY=;
 b=fYZ9kHHOv+fWn3gE8xmwnpZNRnNF14SZSvXxQW4B1OI93S7i4PVoX/vRfHEtHFkNHfFqT1a8Uf15dUf6NEGhBMrfdi3I1Jt+oWGDCk1jGKrsuyXbUg8+m1r66QzzPcLRT/UDHTVWIvYoGhdw5g4UBkD1+q1p1XX9ouOBwKYTWLOknHq4E2YrOzYD1i5GTurWVjOX5Luiyr/LfN6S4dQLG+ue4U54ZRvESZuClvv+5DQmPn9EzrLpH1F4gRN+JV7mS9vMs/Fb1JsgaumZRloXG3h53p0yh9Z/NYxGjCxWkCPZQ9x3NmXOZ3tsIRJPdhwS9u87JHyWMpL1IFEo38w78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 10:08:52 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Tue, 15 Jul 2025
 10:08:52 +0000
Message-ID: <10abe013-98d6-4080-ac43-0f1e02aa41f9@intel.com>
Date: Tue, 15 Jul 2025 18:08:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle
 balance fails
To: kernel test robot <oliver.sang@intel.com>, Chris Mason <clm@fb.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <peterz@infradead.org>,
	<vincent.guittot@linaro.org>
References: <202507150846.538fc133-lkp@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <202507150846.538fc133-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MN0PR11MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b515362-fc8e-4cc4-919e-08ddc3879970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE9rQ3doUlM1ZTlYaGhwdW1FTlMwb2l4b05YQVZVU2VMZlI2TWdJYWFJcmpX?=
 =?utf-8?B?MnZvdHJUWlpOa0xidFlVY2hlQXQzTFdTVDY1RjlMcDYrSjU4Sk5XaDFweEE4?=
 =?utf-8?B?c2VjckwyQ0E3cEpwODc5WmlPSStvY1J4WFh0akJmNzVzSE4yQ1hSZ0wrZjho?=
 =?utf-8?B?aFIzcFBveTRRc1M5YWdPM1pyNloyNk82NFZ4c29maFFhcVVFdlhFYk9weDQ4?=
 =?utf-8?B?eEl1ZXR0OGpqM05rNU1xNHlnNTFxeWo4UjJPQTZoWHo3dnNjalJ2aVRhVytp?=
 =?utf-8?B?U05NYktBV1BWOGluUThtNHUyQ2EwRlpWREhNV3dlVmwvVmREa1QrV0p5WVAv?=
 =?utf-8?B?OFpnZS93RG5nZ2JZYStyWHAxUG5GblVSSktkdU1UbGhOcE1MMmxMRzR4b3Jm?=
 =?utf-8?B?K0U3TEw1M0dsVTFJUnk4TEtyazE2cnFOdWhxbG5WZTYvaVZmT0FyU0dXZGRG?=
 =?utf-8?B?M1BmRjdJUWJSZE92NUQyYm52YVNDSGludnphY3QzS04zcmdGNTBkRUxRaCs3?=
 =?utf-8?B?ZHRYOVk1bkEva2FhVDJjMldlSFE0OGR3Y2pnblI4Z05Xb0tPTzUrZzN6WTRs?=
 =?utf-8?B?elI5ZDR2N1RPb1h0TEE1NEpmWllraWtWMTFXSDk1aUVidCtLbkY2VnBaNVMx?=
 =?utf-8?B?NU5jNWhZcTJYK0JNRzVjMXpJNnphb3pzVzFYaGp5TmhWYkIrK1JSWWlLc3l1?=
 =?utf-8?B?WWhRSkhSdnJKWkhadjB6d0lhV1J6NnJ4RFFOaFJ5SXFoL2Y2c2E2OW4welBn?=
 =?utf-8?B?UlhJNTgzcTdPbC9FSHZVM3dWV1pYeVBKcDQzK1VKNnI5U0svMWRoZGY4WWNJ?=
 =?utf-8?B?SFRVZlNrYmI3cDZ3Q01Ea2VPRzFHdWxGZUhHNy9waW5EbWIwTzgySWgzZTg5?=
 =?utf-8?B?TCtyVkRMSnF0OFFBRUo1NEg3RU5VcjhiNkxGSjB0bTlROGdBWHAxNXFPcGYw?=
 =?utf-8?B?VU5ZU043OVQ4b2dYbTU2YkpIT2J5QjQzbHg4c2NmQmZSMXZvNnNWN05adXBk?=
 =?utf-8?B?ajgyRHRrakRCMDZpc0plTXRkOEhDMzlaL1JkNTU5RW9pNjZ3MlB6SUxNbkpr?=
 =?utf-8?B?OWRHb2EwUXdlZHgrZ0Rlc3lYNWdxQmFpZGdrbFZJTk1jc1c4SW5RL3FacFB0?=
 =?utf-8?B?eFhiMUxtZE81Wk9UaHZ3eWp0Y1VrWjdBUFFoYk8vdTIxdUorRElzRmFCdW5u?=
 =?utf-8?B?UFQrTy9COFYzSmFJSFB3QU1sYVFMbUpMcEh4bVUyV25PWWFCRjhuSkg1dXI4?=
 =?utf-8?B?akIrVkVqK0hEMXlHU3lvMjB1T2xLQkVIZkhVbzhzbVg4c3N1TllmMWxDN3VV?=
 =?utf-8?B?bE5jam53ZnlzL3NyZnRJWXlqWmJBZndXVzJROXJKbUJ2UFNTQWwyZDZQNlF0?=
 =?utf-8?B?SjFzMWs1eFBKTUNuM2gxSUJlTTFSbnJZYmpsaktGRlFOOEJuc1VoRmJYSkcy?=
 =?utf-8?B?K0x3RytRODBLMFVOK1JLd0s3ZHJnb2o4aDVURjVDZ3BDeEJINlRzM3BBdVdh?=
 =?utf-8?B?bUFoSDhYelhydlR4NmtyY0taWjZoRC8zeGRCc0FKaktLV1RpalVSRE1FS2lG?=
 =?utf-8?B?eGlTQXpRTWpJb3NzTm5KdEUrYzhvaFRTNWVBSDlQN09Pb2FaSVUwdEpWNkNP?=
 =?utf-8?B?b2dhSTFxaEZFR3pzYWU3U1Qwd3M5bDhJVWFiekY0ejc3bE9NRVBRcWRROUFT?=
 =?utf-8?B?ZW1TMzZVbUFGOWMwSGdDdE1TT1pBVGNNSCtKL2tTNC9OQzYzalk5SVVSdWhy?=
 =?utf-8?B?cEZ1Z0VMZXJMTXVLSHdQWjdYWWgydnVqUnltSnhqdWwyRWFPMGE5aTJTazhW?=
 =?utf-8?B?cFNWcytweEFobjNKV09XN2pGV0wzeWZTNnc4MXRoODVrM0dqTWVaeDg2STJj?=
 =?utf-8?B?VHBndGEyQndxWGF6QkVZQ1FiTEpNOGhHUjltcUMyTEJtK0pBMjczOTd6L2s4?=
 =?utf-8?Q?u06ZkmboWvs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3Z4RzdydVFKa1cvZ0RzSFR5RlQwRHhaVEFtT2svSWJOL0dUd1B6Q3dzM3NT?=
 =?utf-8?B?U2xkT0NKejgwS0tqRFFjYmFPZm5kK1NDU2trbUlnZGpYRlhuUlhEV1Q4V2ll?=
 =?utf-8?B?R252em9KVXRUT0xBRUt3V09wRlZJb3pBREQ4RU1qNGZTVkhIOFNzb2dleFZj?=
 =?utf-8?B?M1B3cWptNWxYTzkrRkJXQ0thdTNkaDVHekZBWHVjbUtidHJLOEJaSzlaMFE2?=
 =?utf-8?B?SUMrZmVSZFdKMlJLOGNEU1pPdXRJQTVzZGhBdUN2RVVVTTBiVktnNHpUUkxG?=
 =?utf-8?B?QWZFNjA3U1F5Ym5xMVZ5R0tmM3ZDcDV2RE9meldMOXV6eDZsVDlOVGNYNUhW?=
 =?utf-8?B?Y1hvU2UvTTNXYlErY3ZMNytDZktWa0VnMUJTd04zZmdKSlBtbzZVTk53MG5J?=
 =?utf-8?B?YUUrbjQrQXR1T0htYkhMTXlkNHB5ckxyTUVBSGZkSVFzRHJRVU9ENEZOMXZ5?=
 =?utf-8?B?WE9xZlNOZDVSTzMyUSttdFdJSEM0bmx5ZWhJUEZXYXE4SVFnOXovdGdOWkg2?=
 =?utf-8?B?RUNHdE8zUE01NC9yRTl0VzVjQnp6T0RBYzZyRUlsRS9VT2hyWjJWaDMyUnVI?=
 =?utf-8?B?OG8vdGpLL1N0MGVoMDkyaUtmNGNXVnF4R3paTWR5TjlCRUJtY05aMDQ5MUpS?=
 =?utf-8?B?WnJyQzhhSENoOFV1VTVGa3BOSU9oRElWeXhIclhrWjBPYWRMTTA3MkNvd3F1?=
 =?utf-8?B?c3RwTHFrRWNMOVBaREcrbUpZZFBHOGw1a1dqOUFFL054cVlpYWI2dncweFAv?=
 =?utf-8?B?aVdVTTUzV292OEF2bXhITFBiWlFzc2VqYlI3eS96eXNaa1FPSVFSa0xhRmhj?=
 =?utf-8?B?K1MxSDNXWUMrd3dtbWNrWTRRcWpRcnBob05GdXFtSlkyTkZUTlE0dmQ5OEVX?=
 =?utf-8?B?UHRtdjgxNUJaZjlwVXVyQnFldkQvS0V3bXFBSXJFNmgybFovN1JsS3NpYktj?=
 =?utf-8?B?ZTd0MTFrMjRVYlFmaTFtNEJTTnhXQzVjcXBFZ1g4aU10NGJQNXpJMVVaQmFm?=
 =?utf-8?B?eHlXTytXWGhCbWkxQ0k0WmdNcDFpd3JvL3Q2N09TenFHT2FabFpOOTZVT2Rl?=
 =?utf-8?B?Y0V2Y2xCdWdqdXlHYWhxME93M1NSVDgwRjNrSkdZZnBsam5xZTFnYUZKbURj?=
 =?utf-8?B?aXNOblFwUGtnYjA1VTkzeFVEK21yN1hMbWU0SXZZNDFhSk5BZ0hFRFNjc1Zr?=
 =?utf-8?B?OUtSdWhSb2FBWWhvWFhkcWFRZ0t6eUczaVRVMDhvSC9mZ0hlUkVUcm1UdXdv?=
 =?utf-8?B?Q2NsUnl4NkRRL2M3MDR1ck8ydkFaVWIrZkcvMU5EZDRuWUtwN0hrT0xkbDNE?=
 =?utf-8?B?dlYxUFMvamczeXJTdG90a1BFQTViNkg0NzU3SWxBZ1hzeDNmV1N6ZHdzcUJ2?=
 =?utf-8?B?Vml5clVrZlo4cGRLeThkb3FhRVMrYTNUT3EwWmRXbGJRUXd6NXRsQzNmdm5p?=
 =?utf-8?B?dVJLRVJVZldnMy84clVyV3k3ZkdpcnRwdXZzT1MzcnE4WUJ0aTFtaGNGUlRH?=
 =?utf-8?B?S3lud0ltSHNLZWlnOVg5OFdlcmQxNi85czUzZDlFQjQ4WVlKQXgxcnROZG40?=
 =?utf-8?B?Zk1oRkpXSVNwUTB3RkRiZWw2c1F2T211NHhBODJGL0p0S01MWjBTek5QNHFG?=
 =?utf-8?B?SEMxVDFmd0xXS3ErRXplSmVKZ29sUWRrVFhvWU1BM1pKcnZTWUZoVktXKzFm?=
 =?utf-8?B?WWZLdzJTOGpiSmpZbVhIQWdHYmdwb0JJcHR2OUVzUmxQdk1oTWpJazR1MlZC?=
 =?utf-8?B?MHZQQ2pReURSWGdFaVJhcnI2TGR6ZEl2M3VYaXk5UUNnV0xveUNJNHc3MC96?=
 =?utf-8?B?MUlBWVBXSFJPUVpBNWkzemhQcGVLb29ORm40ekF6M1dlYTdIYXlUT0Y2NEU2?=
 =?utf-8?B?UE1vMEtpM1RPMmtUVE1teFp2b0QzUWFhNmpKeVExZGxiWGJrOUJZMHVHQURP?=
 =?utf-8?B?UVZuWmV3dkFMNDd2akY1bk16M0Z5U1VUQnNmcm5pVWgrTS9oZDdMdE1rUUd2?=
 =?utf-8?B?VERJWkRwR1c3M0pTNUp6VWFVdXBQZ0swT21UdXFUUTlTcFgvdkJqd0VyNUFP?=
 =?utf-8?B?TXpPR2VEOWFPYVpQSHVMUmNpV1lkcEpkVEc5ZGR6UVRhNzBZK2xJK1p6c29H?=
 =?utf-8?Q?dfyAAKQgFMPiDiJilJih0CUh1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b515362-fc8e-4cc4-919e-08ddc3879970
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:08:52.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snDp8mTw1ftpCoxj3CZN+ymC3HwWtt8rNCdsRqy361ImFrlKrt0SIwJUhlePqJfPvzYmGJSlZ/0Ysd78Z4ACQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6280
X-OriginatorOrg: intel.com

On 7/15/2025 3:08 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 22.9% regression of unixbench.throughput on:
> 
> 
> commit: ac34cb39e8aea9915ec2f4e08c979eb2ed1d7561 ("[PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")
> url: https://github.com/intel-lab-lkp/linux/commits/Chris-Mason/sched-fair-bump-sd-max_newidle_lb_cost-when-newidle-balance-fails/20250626-224805
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 5bc34be478d09c4d16009e665e020ad0fcd0deea
> patch link: https://lore.kernel.org/all/20250626144017.1510594-2-clm@fb.com/
> patch subject: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails
> 
> testcase: unixbench
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	runtime: 300s
> 	nr_task: 100%
> 	test: shell1
> 	cpufreq_governor: performance
> 
> 
...

> 
> commit:
>    5bc34be478 ("sched/core: Reorganize cgroup bandwidth control interface file writes")
>    ac34cb39e8 ("sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")
> 
> 5bc34be478d09c4d ac34cb39e8aea9915ec2f4e08c9
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
...

>       40.37           +16.9       57.24        mpstat.cpu.all.idle%

This commit inhibits the newidle balance. It seems that some workloads
do not like newlyidle balance, like schbench, which is short duration
task. While other workloads want the newidle balance to pull at its best
effort, like unixbench shell test case.
Just wonder if we can check the sched domain's average utilization to
decide how hard we should trigger the newly idle balance, or can we check
the overutilized flag to decide whether we should launch the
new idle balance, something I was thinking of:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9e24038fa000..6c7420ed484e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13759,7 +13759,8 @@ static int sched_balance_newidle(struct rq 
*this_rq, struct rq_flags *rf)
         sd = rcu_dereference_check_sched_domain(this_rq->sd);

         if (!get_rd_overloaded(this_rq->rd) ||
-           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
+           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost &&
+            !READ_ONCE(this_rq->rd->overutilized))) {

                 if (sd)
                         update_next_balance(sd, &next_balance);


thanks,
Chenyu


