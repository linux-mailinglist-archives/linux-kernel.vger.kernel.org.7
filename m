Return-Path: <linux-kernel+bounces-869616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEEFC0854A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8923E3AA3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB730E825;
	Fri, 24 Oct 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bW0yaqDg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB562EF677;
	Fri, 24 Oct 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349205; cv=fail; b=NAemaKZioYhILmAOrO95aj93/+Vu5q1xB8nuCErPoKDZkCrWmxTASbOfWT7k+eemFfduw7qBBuK7SYC66qF01Pt9fFrjX63lplQlo8I13sWZ1tbniiY+Mqvt945CO52f4upDZTWARlkMBkI0relo31e8HfMNifxvEFhe9Wpr1OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349205; c=relaxed/simple;
	bh=cklGC11OvLbqPlDglriTUBUuNH6fWZoFFPZ3CD8+7aM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WlcpAptoMoVi9XM9e/gUrYF3LRrx3UBIM07SIqO8OQz9qRh4RTrnSmhCaXLAMcvm8wZRWW/ighFGyvBlpA9reirdWm44sH8NdMsjCO8JTD2Aa/qsoaRNqOtVD8vXm42ij4uOfG35BKDwiy5fQ26LF/HOSZ+Om4n0WP4lCM25r/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bW0yaqDg; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761349203; x=1792885203;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cklGC11OvLbqPlDglriTUBUuNH6fWZoFFPZ3CD8+7aM=;
  b=bW0yaqDgo6BXr9NVaLy3rULOen+bMhjSCuceBUDuGTqteaMDARHf89rk
   QAdYGR7Z59W4fU7FylgZbqP7xxpEaqq+/rS282mCHWW/TqJGSq+KO8K/o
   RB3DycFQ47dbQwt9HboYD1sJIMmMMvobbBFWqmMOqgFBCFzXBdF+A526U
   cV6yXWbg8j3Tm6ft0JwRniCtICDNDb15a1Zj24Q/p5bDFYnVPciv2mgwB
   FoqHqqHoidPq3XkFsH8EJl2s0yPESs4uMQehHRou74epEZ6rMP0HleV2y
   whoy0/UPFz3Ill1zQYylmGzpklclCPLMJKtscCecJyY9kGGA5MCxWKvKi
   w==;
X-CSE-ConnectionGUID: slOsE0TCQWOMbv9t9cGAnw==
X-CSE-MsgGUID: avc7QGg1RIqI5/l6dN6dTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63438737"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="63438737"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:40:03 -0700
X-CSE-ConnectionGUID: OGekvkeFTIimqPCoNjBs4w==
X-CSE-MsgGUID: Qs2bffVeR3mFDfafIZyCNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="184253830"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:40:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:40:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 16:40:02 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:40:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gD1aqQtL6G2DaJpD1ajy16U+flOY1gOzzXevjyHGaZuB8ZO7MTLyJ11FlAv74f3kUMIDw39ym0QsPzYyGFFaXEDLEsji9F8Fc6lr1YjxlMvdXoNiZiJYA6E/C/IZwUT0AziLkmdnNk7ZPHKaVn2lCOHbyxlLqmVRH5ohTHP+TMzFNvmFykY9WpDefJE37UuWjtDkVbpXBr5up01XiFC4EWipwBJpc3H+xP5EndKdu9Iq60cxoGAidtijfaJWevmhg+KQt7YAoWW6+p+WsS0qdAPnJbsj4L6YQB7gOO37YMgCNHqZElH5F+dm9kQjWcBMeFbVtPR9E7U2M595AjHKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DZbEIDfeKxu4KtE1h+SK5SpOZWY2aTDvRweP4fJzs4=;
 b=lAnJaAyRwkCQn+uH0eQn1hW+CY28FIzZ4F471w1EJExWYkT21J9nnCcN4AtHPw4ViYGie8GFTFgIEQdiI9ZKjrVM0s83FuNYr1mEmyJdeIb9yLh4RkyqMzke2MBgsSXxcF2D3BwkINL50eol1lwqSdJb5ovvj/2/vhARL1pWJtvZnSEThRXXKmNIv/vtOo4POctgMPnwaIqKhyxc47b0aXB5bjWaI0NcscHdROCpe/UqGbXaT4W8wW1kdvRJajl1PqalXFS5wpmP1UcSscs2hsKnc0fSr5d6KxN640fKR9kmpHVpBNmF/ZsWRvY/5o31Hv0z5X0BfCl+seEWT14OfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8554.namprd11.prod.outlook.com (2603:10b6:408:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 23:39:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 24 Oct 2025
 23:39:53 +0000
Message-ID: <20bcb73c-9bb1-4030-8ae7-1a2d0952ac01@intel.com>
Date: Fri, 24 Oct 2025 16:39:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/10] x86,fs/resctrl: Implement "io_alloc"
 enable/disable handlers
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
References: <cover.1761090859.git.babu.moger@amd.com>
 <8356c090156a90b080dfa2332a70f8aa71f34621.1761090860.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <8356c090156a90b080dfa2332a70f8aa71f34621.1761090860.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:303:dd::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e30f3e4-15ca-4bc8-2b3e-08de1356a1bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGV6ZjFkWVZZOFJRc0dTZzdWR3J1Y29IV3lHajdVaG9VaTJsZktKWVEyakZ5?=
 =?utf-8?B?WHNsWnpoK1VhVm5vZ1g0UTVQTm1wbWM4VU1TQVRZSjZKUldBWkNyRkNpN3lv?=
 =?utf-8?B?RmQvbFFUb3BDOU1nYUd2enhNeFYzakZPRDAxOEgyL1JmT3FINlpDakw3WEtw?=
 =?utf-8?B?dlpuQzZjQW1FdzNqOGhBVU1RS2x3ZEc3NGVObmFyazQ2QVpQQVRzb3JMSkww?=
 =?utf-8?B?bmdPVDBXZGZ2SVp4RFR2MUtQaE9HOVR3YW9mRUQyeENDN3RrOFBVa25PSnFY?=
 =?utf-8?B?Mm5mREJHUWt2aFJaRmMzM0FhenJBMUFCdkJqQk5RaE5TbkQ5a3Z6Z2tiZnkr?=
 =?utf-8?B?Uk9XWFQ0RmJRcFhYRHp6S2wvYWFSRUxhck13ZUtIWEh3YWhSblNpdlRqUEZS?=
 =?utf-8?B?bkxGNHppRVF4YXpLWC9qSWoxcm1pRjhYejFnZGhMNURoSWRtU2wzRUsvem5K?=
 =?utf-8?B?MExxd3dTQUFlOFN6aGRienMreXRwY3ZIRzRzUHkzd0ZMNW13UzF6alZLMlUx?=
 =?utf-8?B?NUpDSnZGcERscUZFeG41YzBHNlFhM2NvLzUxVEswSkUxczFzem5maUNhdXI1?=
 =?utf-8?B?ZXlSQzBnOVQ2RU9QcFB3SkYwemtGNnIvSEh5K0orMjNOWUw2SE1LSEVkVVVh?=
 =?utf-8?B?Z21Lbk9jMTJKS3U1QjdwSU9JeTFxaFRwRlJRMWlPYjgvK0lPNlFLcmtlWUlj?=
 =?utf-8?B?RDJyVk1QU3JNZytFYnJ5bUljMXlReTFpOCtGZTBGOFFYMHF3WDhTajVQWkR3?=
 =?utf-8?B?dXhZM09EU3FvMmtTaC91VS82dEUxWnZ3NHJITXRNRW54Mmp2emgzTVVDZXUw?=
 =?utf-8?B?RkV3bkZybUswczZpaWlhZE9IWTZrcXBmQStHZVVkYXMvcVNuV2NXNHpxbG9P?=
 =?utf-8?B?WThESlV0S1JmWkxPdVpabGswZ3hic3pEckZhTEV3dnQxNXdhWnRCWkZzWmk1?=
 =?utf-8?B?dlljYzNxTCt2blZnYTN0dG5xYVg1Ni90QS9Za3VraVNZUTBKZ2NjbC9PakRB?=
 =?utf-8?B?bnJobHl0UFc5amdzb1RNRTFuZm9CeFJKNUh2ZnRnUlQ2MHI4Q1lJYm5weWF4?=
 =?utf-8?B?Qjh3VkM4blV3dCtkUDJ2bENqUm1PYmZEc2hqVzZwNVlyZThFbWlJemEydTIv?=
 =?utf-8?B?NmFMK3IxM3pKcGNPKzA4WmdjM2FMc0Y4RU00YWE5aHNqZG5nV09UKzhTRzA0?=
 =?utf-8?B?VHgrUk16YmFjdWFlelJTYzlxSVJ4K1NxT0RodU81dno2SG5ocVM0MGxQZVZY?=
 =?utf-8?B?Z2VCRzlXRlFVZHZhYjBES3FOQjdPbXh0ckx0dTRrbVZwVVlYb1AyZ3RXNUV1?=
 =?utf-8?B?bVA1QTliU1QwblpCZlc3OUFCUUpqSFN2bmgrRnluMlo2RWEyNXhBUENiRW1E?=
 =?utf-8?B?bVJCaGQ0R2d1UkFSaW1DbHpVVUt2VGR5ZGttNU5BRW5YdkY4OHRQZVRYd3Mv?=
 =?utf-8?B?OFFCVkZ6TUE5a2ErNkNTd21mNE5SQ2U2UjlUbkFTMUsvcWxORENDM1I2MEJV?=
 =?utf-8?B?eCsybmlwY2RCeHhJTnQrZUprbWFSSkluS2RUTlIvYmhEaVhVUXQyOVRCVFpF?=
 =?utf-8?B?Qyt6b0xuRjlHb0N6MTduQTVFTVhxVFhiSHRMNXI2am1ybk1QUkd2SWk5a1BD?=
 =?utf-8?B?ZTJqbmJwMC94Z29kUlovdjYrNmNCRjJJZU9ReFEzbU1DK0dOWk5MQmhBbllL?=
 =?utf-8?B?RWpZcStNdGZsdDhLRm1EMHdJQXhTbi9PYldyOWtEb2pUUHcwd1lVb2lnVlox?=
 =?utf-8?B?NXNKaXhTUEU1eGVFYmhxNnl6cHdQejkvL0xBWk04aC9SV2xpZktraDE1UFZ0?=
 =?utf-8?B?Mko0RDhjc1JBRmVPVUhDbjNqOWo5d3A1NTcxSTJIVjg3cmlGR3k1TWEvQVd2?=
 =?utf-8?B?NHR6YnNyY2lOemVvRkRtNElYTG1MdGFaMlpQZlpWS2FGN2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmdEUnZFNUdhU0dUM1JjSG9tMW5DRFFlbkV3b2pxYWNPNmR0elhzSjFyUVln?=
 =?utf-8?B?Z01rRG9yZVZhYnR0RUxaWklOTmNoTXJCQnYrT0hkV3VEYk9IY1EyUExLK3Iv?=
 =?utf-8?B?em43UXo5UE0wUEw3dCtoaXNQSThiWDJacXVINy9qWG00V3cxTTVOK3k4bXJm?=
 =?utf-8?B?OHZGaUtvR2M4ZTRNOVNBVlBQaC9VdTdLTXlCdURCQ0VuMDRSc0FPeE1WY0Zw?=
 =?utf-8?B?Zi9WSlVheGNYQjE2WFloc3VaYWJEZXFHYUkxUTdjdWRGemV4MWx4WEpaaHlv?=
 =?utf-8?B?WWVmdWVwZlJRUjhXRFdLdXppZnZwemFxbisvWk52NGdBRm1TazFwZThnVFJH?=
 =?utf-8?B?cDZlWFdoWTY0S2tvSkVyd1N3b29OZklnQXZGbkFnWDlvTHV3dE1jaW84NnBy?=
 =?utf-8?B?d3ByOWVuYjFRMXVEQVlNYXlCUWtRMW9mUUtBdUl4Vkw4ZVB6aUtuaXpYcDJQ?=
 =?utf-8?B?K3plNDVibXhMNVpnTE5qUWc3Q3dLdTcra3BWOUxJOVM1TkRBai84UHRyTTE0?=
 =?utf-8?B?Y2U1MUkwUVdsQk5COUYvNGZPeFhMSG1jdG95c25SZW8xUDhkZE1rS1VLVGVw?=
 =?utf-8?B?ZXJBNHpoN1pxZUxGZ2ZybmlRSXZ0eVdyVmR4MkhLU3hGYmkwODV2MFFrOUFn?=
 =?utf-8?B?bG5Vb2xnRS9MS3UvUDc2ZVpsWHY0b0tkdklvSGtZNGRoZU5QNFZZV1BjRHN1?=
 =?utf-8?B?ZTd3aG81MEF2UUlMUWtvRjZQZFhQOGJUbUZGNi9Lam1lb0k3UmRoT0FudXVz?=
 =?utf-8?B?djcwK2s5RDBwSnM5RG9ueFlqR2JQYWdWME81ZUthZGsyUDJVRXNFaUtaek03?=
 =?utf-8?B?bHpFRTYwLzRSZzJpc3dOTW9QVkYza0VZalBKR2lyazBMOWpuUlVzL00rRkVk?=
 =?utf-8?B?cTVGbjRoU1NlZ2UxbWQyM3E3N0I1SmRHSFRsUjBBZjNZSXBvT1pxdGoydnZ2?=
 =?utf-8?B?YlBQQ1l6dGJxaFFzNXZWNXgzQmF1TnFwNVl6dU1zbklwR0lBK01OM0oxOEYw?=
 =?utf-8?B?WjQ5ZVZzM3NjelpOVlJkaGVnWXNjK3RWSkhqcUV0NVVyY3l4WlZ2dWZ4SjRR?=
 =?utf-8?B?WEVFTk9hejMyd2xtNnBIUVJ4T3pVRjFEbXJKbCszYVdUaXcrVDF5OVVGZVdB?=
 =?utf-8?B?NlMvMjVyTXRGMS9vMGtqaW1QQ1N1d2pubEp3eFgwQTZXTG9VSEYwdmRDNmVQ?=
 =?utf-8?B?RHFjMFZxSk1vL1BmQ3ZwSy9LZDk4REIzbmM0TEJwTkluNXVISUJLaTVMMVdC?=
 =?utf-8?B?Y0dBellrWWtLclc0bWYzREQ5YU1meEgzbHhwNTRZNm1LcWM4ZGpVcUNxRXZl?=
 =?utf-8?B?VXBlUDBmMkdpOFJLK0MrVDZrSXdiaElLQ0hvRTY1cHdsSVo1T1czNXhpQ21C?=
 =?utf-8?B?MlpVa1ZWS1ZrMWdvdTNJNjMyRUJDS3FUV1BUTXA1NytQVlFkNUVlekhBeG5K?=
 =?utf-8?B?QmxabkxqMGFrVG5Hd2NxUUwwL2RDcGVBT3dGZm9BeXpLdldjQjdmS3FpYVNL?=
 =?utf-8?B?bVlTcU9QaWFsWXRYSklBSmZLWWRJNDJrSUZuSVk4QkJybm1udVhWZTNCcEhF?=
 =?utf-8?B?dUMwMUJUN2dIM2lBRDNLWldIZGJxNmpqTWpWNXI4OVZCcmVUa0Iya0ZyRFhX?=
 =?utf-8?B?aUJKd1dPaDRibTkzeDhUblZwcU5ybGQxb25yMml3aTRITGNnaklvTFYzMVBI?=
 =?utf-8?B?WXdmd01pTGFPWXJlTzV3MDNpSGVjVlprUHZ0alNhVVpZdXlqQk1rME0xV2JX?=
 =?utf-8?B?QmxYVlNOaDloTUJGbkNCTkdNbFZPZUhSNlljS1MvL1BRWGs2a29VTWdQaStT?=
 =?utf-8?B?bmxnQlR3dGp0ZlVLdUJOSGpreXBDMmxocCtKdGNVeW9FWStnRUFpMndJamtW?=
 =?utf-8?B?bEdsOTJyekpEMVUrN3RlMkNJUlB2QTY0eGxHZFAxeTdTblpYSktzNkdlNU9N?=
 =?utf-8?B?aEI5QUFjTFBvK2w3ZTFtaDJnMUZuNXU1WHpjK1FmckYrWU5Mcng1QUN1ZFFi?=
 =?utf-8?B?YjlmM204cCtKRytXWDR2cUpDMlRNNG1FMk1RTWlGanRCZmVXQi9XaFRkQVFZ?=
 =?utf-8?B?ckFSbE9uV29nNE93OTVOWTVaV09MOEF6ZURsektoOXFhdmZXS0JuQmpaeXp3?=
 =?utf-8?B?VTNBM2JPbWZmWXNvTGpXNExOTDJIaVIyUkwwZGsycXU2enFPUklUL2NoQjJq?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e30f3e4-15ca-4bc8-2b3e-08de1356a1bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 23:39:53.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRhZv+bT7+Aqq5pUNNCJ7bQ/+zU0dfETwDg0h6xQpU37IZM7DQOh0xSk7WbEzoazP4F+6X9b8k0ailVwIWAOAEZ0tOPK+9VS/NTBmMflgrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8554
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/25 4:54 PM, Babu Moger wrote:
> "io_alloc" is the generic name of the new resctrl feature that enables
> system software to configure the portion of cache allocated for I/O
> traffic. On AMD systems, "io_alloc" resctrl feature is backed by AMD's
> L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).
> 
> Introduce the architecture-specific functions that resctrl fs should call
> to enable, disable, or check status of the "io_alloc" feature. Change
> SDCIAE state by setting (to enable) or clearing (to disable) bit 1 of
> MSR_IA32_L3_QOS_EXT_CFG on all logical processors within the cache domain.
> 
> The SDCIAE feature details are documented in APM [1] available from [2].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>     Injection Allocation Enforcement (SDCIAE).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


