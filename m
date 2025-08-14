Return-Path: <linux-kernel+bounces-769700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E41B271F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81BDB60CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34DE2836A0;
	Thu, 14 Aug 2025 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNnE3x0N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10367281368
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211434; cv=fail; b=AfE/AJGThuZpepG2PDF6M2dQ9JiGKoE0YQUOdl7C1jtIiTesJsfsfz00YYgDKghhQDcCR5pXOcXafHrQVYvp4+b6erpUPEf85UJ5m4G3xOu6KrXR+exFkMXjsYAZujJvhHmFdexWRlNNFSeyitmqZXPeXQY/lukyN4n0baz34rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211434; c=relaxed/simple;
	bh=90hI/5GaimivMdSnVSUUkc644IhcamP8xCMNJWWsmNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jTVwlHPPCR1t64KAUH1IqSKKBzwOqqkFsPIatH4/Jv2obgvd9U17sw9/w7Nmo3SomcRTjwtUny/CEJbNw4PVF8LE1Ss/R5DPeu61LoXSjT+mlfMaMU9Sb0AL990ec0ymuT9KNegP6imz5em0zobL/+N6ve+b6u4veudLnix1g18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNnE3x0N; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755211433; x=1786747433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=90hI/5GaimivMdSnVSUUkc644IhcamP8xCMNJWWsmNc=;
  b=UNnE3x0NR6g6GwUKEKTBwotuWwrf+b0n97bdqoharoPkuLzPjwboxK4C
   18AWRSj0JXOEWNuwV9sIaM00rX6Tu0ALO9l6H4Ricu/1BdIdaKjRn2hTL
   f3Zqg/8SBnHErVKXjPy/HdRZBR30RlQDbVel/YqrUs6enH+B1GQKhs+58
   bi90MPuUpeYkUgY9j4XxmhROe4R8bDM9G81RvsPuowiwLySXQ6HnbszvX
   YDbn2G9dhyGt4gtMLdn7c3BSlKKQzn5PBCPpoljnvce/uywnTFKGrSBoJ
   z9oNulKBS9F488OjHTJVZZDjgHeS9KB3f70DHffdsTwsarBbfljYLNJsO
   w==;
X-CSE-ConnectionGUID: kV9YoPD/StqtBVLaTuC+Vw==
X-CSE-MsgGUID: F0HfejRCS2uDrJTpEhKgug==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57466469"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57466469"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:43:52 -0700
X-CSE-ConnectionGUID: SZ3VNICcTUqcGBLkGEqcXg==
X-CSE-MsgGUID: AzpfHkS+R3SZQadRmRlOvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197721878"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:43:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 15:43:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 15:43:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.75) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 15:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuoUrY2j1iKruuyJefcx/EVywt9T/2prVFwO/LPWDA9qPN5+WiZu6rcJgvF8mor9chvEpYbUpTYvqMq2BmHdel0w/d8FQZOWrEyBgZF+K94LSWBx5xUXpXFcX/+k/l9MBTDRLbQkHhP0z0S0v2dF1UGZyyBMs7kL4Nz5L/gvcTc+PUPQWomlirOUAeKSRVB1jnkykaQFxFPQFauATFEwUWwJuJpf73cgAT8Pf32nMyBhb8A/8SEVxWFpjK2hriKFnMoG+wZB4xUcvjOv2kjyYPT7udoKory6PlvwxKCAEI0JdYEGPYvXLFGaqSk4z00tZPL9yEORKSP3IxMV5DdVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90hI/5GaimivMdSnVSUUkc644IhcamP8xCMNJWWsmNc=;
 b=zINebIk8c4FG9H7tzWnespr0m4t6SmsS6k9K8BZHdgxyEu6g/VcoxoJncvVxYofONlfMIyBIvyN24KUXskYoMAirm+pxMNvxxfD2UCuIH78npqIGl3ozbCsbpST6svwc3aQdmukdnQO2QVoxolyNjfSavF692E9R4O1eqQW/p1Y4RSlbLA+laT5dJ3aA2cTxFUxU3TD0YX2m/bh2nXMAlilAq/S2dZfdzLqPrPK4hlsCH75hkwIgTSkidj933Y28eNUkVFMa0zOsZDlg/Tqj7QEVtSCAuVh/D8pdGeMFjVIayAXxhHBevVqjko5uXjId+n4d+xHajLCUSgXthDTGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 22:43:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 22:43:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Thread-Topic: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Thread-Index: AQHcDQSAsgd3KMgRVUK3LV4xePzdnLRiYLSAgAAZGACAAEXyAA==
Date: Thu, 14 Aug 2025 22:43:45 +0000
Message-ID: <78b04d05b94b605f287b9a594cd2aa9f1cda10df.camel@intel.com>
References: <20250814101435.GA17362@redhat.com>
	 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
	 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
In-Reply-To: <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6118:EE_
x-ms-office365-filtering-correlation-id: 08e360b8-2be9-4dc5-7148-08dddb8406e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZWRUTktmWmlOQnM0UTNBZ0RoejgydVRBNUM1QWRKOVhnWlg3bHMvQm9KVDNH?=
 =?utf-8?B?MFh1UUV6OHpnci92djRRWWljSU8vbUdtSzA0ZGpNclYzcXhRd1NpTmxIbkRw?=
 =?utf-8?B?MmRMQ0FETnVSTjRkVUFXbXRpYkd5RjVEbFZKY2xLVzRyU1JaVzNFWTFrU3RS?=
 =?utf-8?B?WDB0NGxXakN4amIwVHpEMXkrSzUyejJON29EU0tQMUJQT3k3QjZQZzFEVUJX?=
 =?utf-8?B?LzQzV29MTWROZUZERDdodk9OTEhmMTh6N2dpRXlBVTdlczE1SWdncjBxYUpx?=
 =?utf-8?B?dFhWaDl3R0NkS3B4RENYQWQvaDM5OVBjYlFhUDNNMlROWmh6Mnl3dTczM0w5?=
 =?utf-8?B?Q0w0Z1dGZGdrNU1obm1paGp1azBJWis4NDJoZWp5ZzJJeDhXdUJVaWQ3T3Jh?=
 =?utf-8?B?ZkUwekZhemQzZjgzYWNYWHQ3ZDlmSktnREFxZmNVcDBoTGhLRldnVDlzWlEw?=
 =?utf-8?B?TDJRTEF0anN4dGc3SGVVN0QzM1Uwa3BwRmtDUWNCazhBTE4xT0ZkR2tSU2JS?=
 =?utf-8?B?N3FUZ2Nsb2ZjbXZ1Zm5kcFBDMlBJaUhIOHgxQXFweGxSc05sQTIzbUxPUS9O?=
 =?utf-8?B?WjgrS2d2eU5OS1E0V2JrdFpWbmEyTlBwbTZUZUs3RnJzOU42b3FuY2IxeDF6?=
 =?utf-8?B?UkJ5c0ZJVnFKMFdrdGxJQlZmZDkzZWgyTENhcEtQRHF6TGg2N1V5bXJUNlZC?=
 =?utf-8?B?UG5MMkJvZ09yOTFGcFY2ZmNtUERUYjRrbDRKYVlvUFlsRG9ROTdzazBwaSt0?=
 =?utf-8?B?YnpDZ2VyeHd1VkJYYjN4NWMxa2tNaU9DeXYrU3dQczk3aFhqWHZHUTlVcUpI?=
 =?utf-8?B?eGp1WWgwS1dkNmN2SzVDL3BkTk90V1AzUWNDR3UvVXo1b2JuaitzOTNxS3FL?=
 =?utf-8?B?c01US2dCVmlOdk5mQkZkSlBOWHh4TFZvZk0zN2tyQXBsRDJEOW5GVjdTWm01?=
 =?utf-8?B?THZFY1BYSE4wOE5wdnlsZEU3bWQ0Y2RCMG4ybDd6UUR4QTNkMm9GVVowbTJD?=
 =?utf-8?B?dlpVdldRMXNvTG82RzJHTHFPcXhBSG9OOGVHSFNIQnN6cFpHak5aeUlJR2d1?=
 =?utf-8?B?WGJPNCtUN1NJZG1rYnYrMnhHdUhsVmo2RGlQU1g2cDNmV0Q1R1ZzVk50VE44?=
 =?utf-8?B?RGowMSt0K2tjS2N1MTdGU0lTZ0FqWG5DS0ZNQzUvRytybnNlME1KWEx0RHdD?=
 =?utf-8?B?aCs1dVZNcVRzc0FyNnRodjJoamNHQzZaK2NlODAwN0ZBTldoT1Z6SGEzN2Yr?=
 =?utf-8?B?U2d2U1pCSUJnL3N2QjRtR1ZRb3M0azBHNENvR3lONUczSEVqaG1FZjBMWlJW?=
 =?utf-8?B?S3JqRVZGMzQzYXY5dm1CRENmWXRDOGc3WlpkblIrWFhGWkJub0lBeUtRNU1Y?=
 =?utf-8?B?bHBmV1hQYWZsbnBuanREcEoreXZvWXRpeTQvQkRDWVZBOFhFTFFtQ3ZRVGw4?=
 =?utf-8?B?Uk9iK3ViYmJKUWR2K0ZiMklZK0NwK0ZxdStTbUdGNmxjd3pNQ3FYUWhyNExu?=
 =?utf-8?B?YU1LbGEvSTdPRUgxWWpjZXRHK0ROTDV0eXAyVExXb1hWMmFKMkt3MERxaDVN?=
 =?utf-8?B?c3c0RDZOclo0RjNORlhmQjZ3NzJYN3dHckhUQWJDR1FqUW1xZFRLWWw5ZkFr?=
 =?utf-8?B?Mmlub1l5ekpMMWw2OGhUYzhjV21hSjd3UGhmOW9zSmdjK1pkREhJL01KS2U3?=
 =?utf-8?B?MzlIWmszZHVNbU9ZWjFpSFpqTmUvaEhuazUvWTB6emFEN3p2QS9Gdy92U00y?=
 =?utf-8?B?bHcwOGs3MWc1cHc1NXk4amxSaTdWbkxodGxjNEVqaUNkUG5XMmFQUnU0SWli?=
 =?utf-8?B?a1orV0VwSkJycHQxODJCRTczU2RuZ2tlNzZBZkpnSDcvT0grUmlZNWVzbTBr?=
 =?utf-8?B?TlA1TGJ2azViMllZY0Y0TGJQWUpLOE5PeGhpMVVtRGtIcmNyYXZHaHA4YkZI?=
 =?utf-8?B?Sm81aFN2ZjlscnNSalRoV2VrUXNDbUEwbnpMWEJ3OVpJR3Y2cGRNZjBMek1X?=
 =?utf-8?B?VEl5MDBNNTl3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHV6WVY1dVRJbnRVUHMzM2VWOWJkUy9zNExhc0ZyaDR6N3RRZ3BrVnhFcVp5?=
 =?utf-8?B?SSs2dW14azFWcDJiWGxycXEvSjRkRXFib1pwMHgwN1A4N3pOY3VoRVdZWHRv?=
 =?utf-8?B?bEhYRThsS0dVWkJqTGVVZklhbDRHSnpqVHRhMHJwWVQrV3FKcExGU3FWZTQy?=
 =?utf-8?B?QU41SlM2ODRNUGMrOFVRMm5XNTd2WjZoU1lRVnBwaFRQNjNoMjNMVDlSMHFj?=
 =?utf-8?B?ME5zbU0wMHNRYisxZGgzNjBLdHZ4SkVydjVScEswcVZmc0o3VUMzNWJhL1FP?=
 =?utf-8?B?cnE2UjVTNVJ5YkdMTVplNzhSUW83ZUR3Uk5MMXIxcXU1VGxLdEF0aFFpZFhu?=
 =?utf-8?B?QXhpdUZBczN4VjdCMnN2Snd2bG01UTJuVjg4TzluaDcvMW12SHE1alNpUmR4?=
 =?utf-8?B?dHVTNVRFcksrMlZDUTdobXB4QW44dWV5MUNpWGNhNFFPaWxUZk8wL2FxeEFK?=
 =?utf-8?B?cVlOSE5vWFlmSnJVWFo1eHEyTCsyeVBvbDN5cmlRbW5GY0tmZjJqUkFBNytW?=
 =?utf-8?B?a3R6NHBOLzdlb3JBVzNDUkpOTTEwT29jMVBseHhKMktkSGwrQklYUjhPWGFJ?=
 =?utf-8?B?T3RLVWtMMXc1VktnSEZTM2ZhcjBXb2wxZ3ZNZ2pXZjF0ZFBScDhJem5MZTNq?=
 =?utf-8?B?ZmlaT3lXdVpLdHQrUDNGQm1rYW5xay9qNHV2b044ZXFXY1ozanN4WFgxNnpS?=
 =?utf-8?B?c2tMcnZrYW1jSFZaRGxlMDVWS0xxRnJaZlFYL0RyNkhaYkl4a2VJOXBrci9L?=
 =?utf-8?B?QmxwQTBBdFNub2g4ZFN6OE9vYkhEeTBoS2hkdHhSYlhLSlRZUGR0a09hOEpv?=
 =?utf-8?B?QkpyV0Z0RVVGMGRFVjFlSHZnamhseDJiRjVoZTlKa2h2U21KN0dycjRiSjUr?=
 =?utf-8?B?SUNXMklPdHFiL3UrYjkxVmk3TVhkTGRTL3JiTE5MVCsvZ1hCNHhyaFRjSEV3?=
 =?utf-8?B?SWhjVzBtOVdrZTVjTnhraUI0MWRKS2lvQVRaaUtXWGR0R1Fmc25rTjA5Rkpy?=
 =?utf-8?B?YlJrS2hQeWRqQ2VtRnpuekdRNDF2THlRQ3VJUmZVNi9JNFFtWVMrMkhSVnph?=
 =?utf-8?B?V2puN2RUYmg0K1NOT2tLdzFjRVdDanhTenhFcW4rRzNWUUZrdThFbzF5ODFh?=
 =?utf-8?B?M0xWUTg4SGc3Y1kySk9yZHdxa2tWdFB2WDhBZUZobjZwa3NtdkVtYjgxeTUw?=
 =?utf-8?B?SDFXdGJHNWx2QU9uMmhoemVvdWJOYk5UYWVRUU1JeDl6aWpXRUdWSDlldFFm?=
 =?utf-8?B?WndmdmZjR0h0NUN1dmpZakRBVUFRQUlOYUYyT3NjTGFYZFhySXM4VGJ0dnNX?=
 =?utf-8?B?cGRDYkNYVEtEeTJlVHIwWXFZMDVZRG5MaURxaU1aeHEzZHBERHhhTUF3akZv?=
 =?utf-8?B?bFhCem5MQmg2NDVwRXhNTUxTUEpHOUhKaVZocG9HakJ5MVBrNGo5YldDTloz?=
 =?utf-8?B?ZjhoczZLZ2piVjE3Z0xKeEYvVnlWRVVQUUxOZVlRVE9CamFkVkh1M0w5SnNt?=
 =?utf-8?B?RElhdEtrUnVIU1NJK1J5czdrdDNxTXVpdk8xVlBIaGZuL0JReTRhZDZqUFpu?=
 =?utf-8?B?aER5QTFkMkFhRFVGWE1jRCtHZWhiOSt1MGZZdHprbWx1NDd6bTRYT2NrVkZJ?=
 =?utf-8?B?SURBNjhjcnZlRm5YL2lwTDAyYzZRYmlFS1JiSGFQWUlWTjN6YlJHR1pEcXlF?=
 =?utf-8?B?M0xzRHF3S3BYcXB4UDZrMFJLOTdRdUpnaHlBeG40dDNGczN6NFo4UzB6UVdG?=
 =?utf-8?B?M3ZVenI5RTAzK2ZLakVtMWJ4bFVPU3FEZUdmQlhHWHkzcHQ4NVZNWklyMVZD?=
 =?utf-8?B?MTA4YmtlTXJkVWR4RVFOMWdlcEZLSmFiNUdUV3NUTGRjMzdIQ28wVWVyaS9R?=
 =?utf-8?B?Z0RhVjlNakUzMXpMM25tNklocHphVUs2OXpLVXQ3UTUxRVVtQStvaTFJd1JD?=
 =?utf-8?B?am5hMlVhNEN1SXlnM3plaEx4eEJRSUZudGhudTQ1KzRPNytWTTlZdm05dmV1?=
 =?utf-8?B?Wm5Vbm8wS2R4V1ZYMTR4R2s5Zy80bW5CSVZxWnRDZXlPRkZCNml5czg1SW05?=
 =?utf-8?B?T0l6K2g1YndBQjVpOHE5MmJzcjM3M0JNeEoySnhKNHlyempldWtrNDNEQVAw?=
 =?utf-8?B?UHljSkxHY3hBN29DK3VEbDQ4cnR3N2RGQ3VxNkl4UjlvaXQ0THZKc3g2alpI?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F154273B29B87144B9FC1BAF1D140E48@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e360b8-2be9-4dc5-7148-08dddb8406e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 22:43:45.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6niUTvmvk8COrlou+oXO+qqHDGrNsb4FmIhDOtuF9yUuBhkRJVo0+rN7+8PFwhhBQtK46IYthi1tnr8hSDV4wZGuAERE33wSd3awXPgx+qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA4LTE0IGF0IDE5OjMzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IEhvdyBhYm91dCBqdXN0IGFkZGluZyB0aGUgJ21pbmltYWwnIGNvbmRpdGlvbiB0bzoNCj4gPiDC
oAlpZiAoY2xvbmVfZmxhZ3MgJiBDTE9ORV9WRk9SSykgew0KPiA+IMKgCQlzaHN0ay0+YmFzZSA9
IDA7DQo+ID4gwqAJCXNoc3RrLT5zaXplID0gMDsNCj4gPiDCoAkJcmV0dXJuIDA7DQo+ID4gwqAJ
fQ0KPiA+IC4uLnRoZW4gdXBkYXRlIGFsbCB0aGUgY29tbWVudHMgd2hlcmUgdmZvcmsgaXMgY2Fs
bGVkIG91dCBhcyB0aGUgb25seSBjYXNlDQo+ID4gdGhhdA0KPiA+IGRvZXMgdGhpcz8NCj4gDQo+
IFBlcmhhcHMgd2Ugc2hvdWxkIGZhY3RvciB0aGUgbG9naWMgZm9yIGRlY2lkaW5nIGlmIHdlIG5l
ZWQgdG8gYWxsb2NhdGUgYQ0KPiB1c2Vyc3BhY2Ugc2hhZG93IHN0YWNrIG91dCBpbnRvIHRoZSBh
cmNoIGluZGVwZW5kZW50IGNvZGUgYW5kIGRvDQo+IHNvbWV0aGluZyBsaWtlIHNldCBhIGZsYWcg
aW4ga2VybmVsX2Nsb25lX2FyZ3MgdGhhdCB0aGUgYXJjaGVzIGNhbg0KPiBjaGVjaz/CoCBJIHRo
aW5rIHRoZSBsb2dpYyBpcyB0aGUgc2FtZSBmb3IgYWxsIGFyY2hlcyBhdCB0aGUgbWludXRlIGFu
ZA0KPiBkb24ndCBzZWUgYSByZWFzb24gd2h5IGl0J2QgZGl2ZXJnZS4NCg0KU291bmRzIGdvb2Qu
IExpa2UgYSBsaXR0bGUgc3RhcnQgdG8gdGhpczoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyNDEwMTAtc2hzdGtfY29udmVyZ2UtdjEtMC02MzFiZWNhNjc2ZTdAcml2b3NpbmMuY29t
Lw0KDQo+IMKgIFRoYXQnZCBjb2xsaWRlIGEgYml0IHdpdGggbXkNCj4gY2xvbmUzKCkgc2VyaWVz
LCB0aGVyZSdzIHNvbWUgb3ZlcmxhcCB0aGVyZSB3aXRoIHRoYXQgY3JlYXRpbmcgYW5vdGhlcg0K
PiByZWFzb24gd2h5IHRoZSBkZWNpc2lvbiB3b3VsZCBjaGFuZ2UuwqAgUmVkdWNpbmcgdGhlIGR1
cGxpY2F0aW9uIHdvdWxkIGJlDQo+IG5pY2UuDQoNCkFyZ2gsIEkgbmVlZCB0byB0ZXN0IHRoZSBs
YXRlc3Qgb2YgdGhhdCBzdGlsbC4NCg==

