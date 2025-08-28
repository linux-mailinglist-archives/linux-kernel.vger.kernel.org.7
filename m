Return-Path: <linux-kernel+bounces-790775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252DCB3ACDB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFC7A000C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383862C2341;
	Thu, 28 Aug 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDtDaKg1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32F2BEC34;
	Thu, 28 Aug 2025 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417427; cv=fail; b=QsWY8/aCSsKhRroIagsOx2D30/f76TSF9fTmv1eIgRBjqNKjCUBaQKGuRblWtR22MXR/axes8M7eCpaTmYP4t5Z+qEwon0x6LT+4TROc8cdXXBQHPJQd6F1PRSsGd3dCE6KNqmSWmXuOejyftLdD3Od4kWzaBdcVSVMEAmAi260=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417427; c=relaxed/simple;
	bh=/Seo2kqJcwz2UvWPbptJFC7gpLgAiuBcRTmWyj9WfoI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WKUoes/HE70tqb/6Y/AcQ07PgT+x8oSxM4XnyX0ZiI/HmQ0wM6/vfh0nM1s56x3Vk5Sqp0bKvfhxPBwTw3NDwiE94a0Cr8TrG8yP9dGJ+6KxmnjQgzDrl+SMnXLskzDM7uYDGfrUO2yVJFdLSlWwFTDXGtat9UuFoS++CDk8waI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDtDaKg1; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756417426; x=1787953426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Seo2kqJcwz2UvWPbptJFC7gpLgAiuBcRTmWyj9WfoI=;
  b=fDtDaKg101k2sQhl0amqBDoplhKlRWhGmqKKJFId6C6+l5YlIK5X29qo
   5G4ssSXlbPTllEx1O8iMfoAsmYpLl9kwsmKumkTA9mTRgeyrsdk/KaMml
   bXxwixuOKvIM7NOiDsHMbGXfUuLvGNBrpDnxXNbvlWYu3rUXHABHGGHZl
   sFHVmeewMJVsVRQy9oDkNMK1xhcyxSujTHd36WkCgq+msM8LV6wPUzuWG
   zYCgm96/thl7lpFl7E8Y0wj9PtT79EzRQvD5Rt7nrshmnggY1u3B8X6wh
   leszNHvmZDUK46QW0xRuloL/Lxxx7kt3OqqnNdkhPajYmIVIJQsmLl+tb
   g==;
X-CSE-ConnectionGUID: loJjSBDiSqi4xvHgoVf9tg==
X-CSE-MsgGUID: Toj7jmArRkaPfcKTghsLzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="84103836"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="84103836"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:43:45 -0700
X-CSE-ConnectionGUID: voXf7+eIR4G5rWDQpbZtXA==
X-CSE-MsgGUID: tjnKnxvyRBy/gsHr72fQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175512290"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:43:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:43:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 14:43:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5RA/vuYWfyTygBGSCM9mPQ7RLoY7l9CO1bJb0M+TWzpEkCGWilHICmdsc06fvmCO+AD2Z7e6VvkTm6b9Nyv8RAcDd+HYCiqf46pI18TwVU2c4XzmoaSdsQYpURazeHbI47LoffcVjnDvnb2vw6O0ozABKFm+a096Z14J7ue8hqzjiMogo8fBT4iCWRTdUiD+7DLFd/RBZPDdzAInoXCNXS8rjsLjlJHlXQLicd9ZBZCu5zVQtC4bcr/jJopdBTLK5CZJzrgLqcw0f4Ovvz+zXaz9b/x8OWFJFt+qNikPVUTrKMHshzOdPbJ3d5FYZOtfbZ8KqttCKJhsxwxUxOa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2ihjlXkYX2ry+JqHa6M7wZcC9o9eIbhZrTAipQVcmE=;
 b=OzRP+/7P52uk2PvFJaasA66/phEEVmK6UxIjzfvxI4Rtu6COlUtZhNVagbrZ8flUHzQ1147G3HO6IjZoXMUPUY/2pTNPEyXNDwyzpkJMGPJvHs0aKbSBRVVhxoh2tk4oLKtCNVTSPA0kjb/O0HPLixMOuUEjMJ5wk/RescNVHa5H/qdkVqguDFkgquVagnS5XemgWtHyjoYSbo9riUo842vgdb7eNMCpwQ81ilC3FQHOI/ncMp3O6RGaPyP8MZ+tuWHGvBDSXZxY9dSg+5qCvOcqu6RSbTDCKiRj61GQ4j6d6J8bnsaCzYDFmHikJs/ksU57/xM1qOr4U33LBgfLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA1PR11MB8280.namprd11.prod.outlook.com (2603:10b6:806:25d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Thu, 28 Aug
 2025 21:43:39 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 21:43:39 +0000
Message-ID: <7cb92a9d-b622-46c0-84e5-546fc82ae759@intel.com>
Date: Thu, 28 Aug 2025 14:43:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (coretemp) Replace x86_model checks with VFM
 ones
To: Dave Hansen <dave.hansen@intel.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-hwmon@vger.kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250828201729.1145420-1-sohil.mehta@intel.com>
 <16286fa2-3949-4aca-bc52-4090eb96d305@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <16286fa2-3949-4aca-bc52-4090eb96d305@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::21) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA1PR11MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: be8dd8c2-8808-4ad8-0fc1-08dde67bf336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmJxaldVanB4cDVjenZnalE2UFYrenRWQnZSNVNCWVlqdDdRTVVjYURudlZx?=
 =?utf-8?B?NlhuUDJaSXZlZWlISjNycUZFYjVEZGpZc200QzU4cE1sS2hXZGdNQ1pvRWNX?=
 =?utf-8?B?N2h3eC9pS242aWhZOHZrV0JoU3JPMkFWOFhqNEd3VTNENzNuVHpjWVZ3eFVO?=
 =?utf-8?B?T2krSG51N0h0RFE1d0NLSnlRWWhEMlN5V3Q0WUxrcW1TWGNDUWZoWVBGcmRm?=
 =?utf-8?B?VVZZMm1UMXVia0RMM1pucU1STit3eFgrUUVQMXJ4SzA1R3p2eFJiYlJpRld3?=
 =?utf-8?B?ZCtrRkNnS1NKZ1oxdFdxZE55OWlPZ25wTnBlc0tMMVZKRG5GVkJEaytsTE5N?=
 =?utf-8?B?VnJWbForWDZDdzdIeGlnbXVhcTN3OFQ3RThLZXkxUXhWS2hudXVXZ0EwN0w4?=
 =?utf-8?B?UnZEdjkvcDZIZnU5ZkhSQ0ZsNHo3emg2M2FRNktIZmRnVHdHZzhrSDYrcmhz?=
 =?utf-8?B?MjBZUjZwVFJ4Z0ptT1ovbHFmNGI3d1BKdmZPUE5hRHVLd3NycnB1eXYzM3pN?=
 =?utf-8?B?a3hkQ2NOQ0Y3ZGNaSWJkcXM1a0RHd1lkN0tvQkFpTGxGTHArNUdxSEQ5UzlL?=
 =?utf-8?B?TUNIRUErMWY4ZkNQRXp5OE8rc05Qenl1eStGMmNLVUM5TnVuTnN5Tm1oUGEy?=
 =?utf-8?B?bjl5MHNYejArRHRoby9yYm5Ca2crQlpTUlQyTnAxU0xVWlR1NXkyU1IvZ1JW?=
 =?utf-8?B?bDJSSmR0Nll4RE1NMm5ubWxSVlNBbHNnaFhuN1ZLT0hRQzJpQ2k4OUZQcW1t?=
 =?utf-8?B?eDFxMTc3WXFhelFob1dsWUVKV3RBTDJBM3EzcmxMdTJSbzRNOWFBUlUvbWd1?=
 =?utf-8?B?emVsZktHOEhzbjZheTNaTG1tYnJ1NE1XcHovSzVCb3NtOWFDSXFFcFE5S2dE?=
 =?utf-8?B?cUdQV201bTJ6VUxQVXdaRWhLTHlSTUxKd3NUZmR3U29OOXBLNkgxVXpycmpO?=
 =?utf-8?B?ZHYzRW1lUUFmeDJwRCs1UFlUQ2VOMVQ3dmZqWXZVcjJzck4yZlNQRktJV1d2?=
 =?utf-8?B?WWJuRjNJQ0srSjV2Q0JPalVkSTF3c2trRkk0S2hidURPZGxrZEJPTGF3VFB6?=
 =?utf-8?B?dFIyYmdRNTZabGxBdzVUVFFuaWtBR1hQYkV4RG8rV1ZlaElhd2FUSXJ1dlNy?=
 =?utf-8?B?akJBa01FRG11cDErOE5Kc0tucEU3Z2doZW9hdXl3aUJzWnIrQ0xUWURLV2o2?=
 =?utf-8?B?bWZlQ0dWeTNWT3NHQTk4dUJRZjNzNzRLUGd2d2VwUlg4NHlsNzBxTUtnVjJP?=
 =?utf-8?B?TVh3aWNVUnBDZE9VNXl2YnVkY1owTjNWU29WNmRzSVFVMXVKL1EzK1Fvekxp?=
 =?utf-8?B?amxMUjdRNHNDTFdOYm9HeTVjMVJjT0hURTVnSVdoOG0vZHJTUWVURmdGRHJw?=
 =?utf-8?B?eTEvSzRvbjFtTkh2SmdIL0tIcHAwU2lGSUkrTFdaaXo1cUw1K0EvSlcrVVNv?=
 =?utf-8?B?bDFpakV4MXJxQ2hWL1VHRjRuNDBSNnBSamRJbDNtRWVUcWU2dDlOWnVJVFdw?=
 =?utf-8?B?Zkt1N3RjRys4NENEdTRLMjVpQVduNkJoSHU5eGFFblVZNXgraHlINWJQbFB0?=
 =?utf-8?B?Z29YUWpXMThMMVdVYXphVHlWd0RwS0NDNlNTYlFUNWo1NExpNmxtRVFEWUNu?=
 =?utf-8?B?WE1tNHhSTVFTRzJEUE1MRUxJRG0ycDNIL3VvWU11dTB2UUFhMzhvYTROQjda?=
 =?utf-8?B?NE1sUnVMOWdiM1dTSkZZcW95dSs3eFV3akhJeUljU24vMHZsQWNTbmE4czk3?=
 =?utf-8?B?VFZkemNTZmRLd1kwQlprT1h1ZDJZYzM2S2VxRzkxTXdvVGFiOWVCVXNZazQx?=
 =?utf-8?B?TGVWdVUvdGc5YmN2UkNLaE13OFdSWGRNSG5LcFUweGRwVG1hdzZIODJEYjJ1?=
 =?utf-8?B?QldmenZqRVN2eXVWamk4WkFvUituUkFFYjFQazhpZHFhQ0YvRkllbTQ3RWwx?=
 =?utf-8?Q?yh6JDF8dXzc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW1ITE1NQzNHalVYUTlycTNqaEhiZGVJVlJTamk0OGJCSm9zamcrT1RMQU5V?=
 =?utf-8?B?OEd5NTRjV0oweVlDZEVYS0xzbUxQeFZBWnlwd2N4UTE0S1BmcE4xMmhNWmhM?=
 =?utf-8?B?Z05DRlBLSmIzeVZncUdNQ0Y1YjdQRjVoRXc0QUpJZnUxY0wvd1JlRmxBU1Rw?=
 =?utf-8?B?SjZ6VXFjZC9ZRHd6VXhSdEplcm94WWU4am4rSG04ckMzY25GTHVoWUY2TS9p?=
 =?utf-8?B?N0ZlNWJ5bTZKWHA5SFNLY3E4ak9rc0h0dUFTZFRiY0RvQzM3dGpWUDUxTTU3?=
 =?utf-8?B?RS83eUR2em1Va243QTQ2dEQxeW1KQm1CVDFPVWlmbFY3cmJCbHpOWlJsOXlL?=
 =?utf-8?B?WHltL0hzei9aK0hPUytZWWs4TVBKNTBjN0JSL1U2R2JZanlZenNFclk5c3Y5?=
 =?utf-8?B?Q1VQOG9FZUNXWXgwNHkwdFQ0RjhLb3hXaVJpNTVRMGRYSFlDTFRrTGhPTU1Y?=
 =?utf-8?B?S1llRTVEc2VlZENIMWNxeTFnd1FSS2Y4NDJyK05JSWFCQXhqVlMwcjJpMnRC?=
 =?utf-8?B?TFdqdUNvZXBsYnBGTGlWWjlub2RBcDZFbHZqbXJsZE5PVnQyb1daVTd0TEZl?=
 =?utf-8?B?eGdsak9oZ3U2amFzVGdKbUE4M0V5dHVCU0F3Q0FqVXcxUUQ2M2ltQjIzRXRh?=
 =?utf-8?B?UlJWRnd5Y0dLN0luNENVQzBwR1ZqZkJSL2psVG5oZmFYclRwS2lKSmNSbmIy?=
 =?utf-8?B?QythSHR6VEgxbWlMQVBOWUswTUpCRmNWcnRyemNBc1ZpMmZUdHlpNXZzcDJu?=
 =?utf-8?B?KzI2WW53UlZ5SHlQUnNSTnpYQjVwYjZpYlppY1RSSW9MajlTRGRqQmNmNWFI?=
 =?utf-8?B?Vnk2aGFIcGxsT0ZRNER5VGRURyt0Qy9pcUUxTHYxS2ZOcG9neTFPR0Z4Qzhw?=
 =?utf-8?B?RTRiTW53SVh1MWNvVjhCZzdYd2pUaUorVFBqbGp2VDFnd3FDRFRzbGc3ZVBE?=
 =?utf-8?B?QmxyUTBQTWF4ampQZEVzM3RxQWdLRXZWSFZ1ZDdKMU5lYWoxV25LWHdjYzQx?=
 =?utf-8?B?U0d2Z0YxNGdPSUFOVVlUKzJqWkozSy9CcWljWmZweXNEbTFZT1luZ1JucjB0?=
 =?utf-8?B?OGxOTlNPSThsVGVtd2hhYUl1dER1QUtOMEdtdllmR2VnT2I5VFNBOXcyUlpx?=
 =?utf-8?B?T0RZQjdqODUwL2cvWnNHVkhEZThDZW0wUmRsYjAxeW9LTXVKeXZPTGFjNTN6?=
 =?utf-8?B?WU1uY0NkeUpJczhIejI0RjlZZVpXNnhxWlRjMi9DZXhIMVN3TERaYXYxVkIy?=
 =?utf-8?B?YmZndnFCMy9aRWF2cmtMUkxaQ3JtUVYvcUtjNU5LbUxpUUlyUlZuN0pxdnhV?=
 =?utf-8?B?VG1tQW5rWlY4blZtaG5VbkI5bk1ZMmxaSHNOWjE4Z3NIaTBNcGZSQmdOSURG?=
 =?utf-8?B?VXozMTlqS1ZXUEV2eXdhOHNQYUpIajBzM1hIUklpa1drNlNSMWtXR0FOVmFk?=
 =?utf-8?B?bG9NamtBMkpUT3d0Skl5ZGV6cER6b1QwaGRQYkZnd09vcHp2SHFzQnZ2MFli?=
 =?utf-8?B?NkVCZUFnb0Q5VUdjb01oM05NYUxDK0tZTjMwTXdCS1p6N3hMZDl5SmlMRkRl?=
 =?utf-8?B?NERQNW50UmwxL2JxK3pQQU4xZm1YV2xybUZVSWg3Y1hYNWdlRU9kQlpvVWVL?=
 =?utf-8?B?bE5SK05wbDhDcGpDeDU5ay85MS9jUXBmU0hhdEFjbFArR3J4YXAzd1pqeWI0?=
 =?utf-8?B?bW1MNU1iMTkxUGhjN0hUR2ZnQng4UmpncG1vWkZQcHJsNVoyZzdtL0JJMlRN?=
 =?utf-8?B?L3B2MktQc09XTDVRVVBsYWcvOFgrQjk5WTZvSnJSRmwzdjNxQm55REt3V3Rm?=
 =?utf-8?B?Z1IwYlZhOTFSalBaWHFlYUFBVjN3ZmU4S3cwanl4VEtNbCtMMlAxSVFFZ09G?=
 =?utf-8?B?UXBVOE1JWG5HVlE0cHhTR3dBTG1BNHNzb0JnUklaZGRFQXhyNXdEbW1JL2pP?=
 =?utf-8?B?MjdaeFlzU3gvZjJleThWcEpvWWxRVk1OWG54U0FqWFQwNFNHWmFlckw5UEdG?=
 =?utf-8?B?SXl4Rmx1RzdqRkxrcjJKOTRrSmdBK1U4ZFhYeHV1K2RLYzd5SXNCVjE1Z3py?=
 =?utf-8?B?WkdvRlo4ZFlNVDhVSHdXdGk5OGJTcE5CM1JxQWsxWFJNczJJS3RwVUthTEtL?=
 =?utf-8?Q?vw/5SEsxcytuTwzO1yekpWjFB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be8dd8c2-8808-4ad8-0fc1-08dde67bf336
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 21:43:39.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVFDQSJfyWpwut0WWKs7Z1l8sAYg6oJL1v022WUrjUYtQaWP5FPYJ/mW2Rt7sib95GsuynRQyWXrufNpUteNRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8280
X-OriginatorOrg: intel.com

On 8/28/2025 2:18 PM, Dave Hansen wrote:
> 
> Oh, and do we want to cc:stable@ on this? Could this end up biting
> anybody running an old kernel on the model 18/19 hardware?

I haven't evaluated the exact impact. But, maybe we should cc stable.
The patch applies and builds cleanly on 6.12. But beyond that, it may
need some massaging.


