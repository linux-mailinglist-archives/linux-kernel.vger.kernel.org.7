Return-Path: <linux-kernel+bounces-782755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DDDB324DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D65E265F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B9275B0F;
	Fri, 22 Aug 2025 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C9v318gS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5920322;
	Fri, 22 Aug 2025 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900462; cv=fail; b=Xm/5zTd68PZDyPkXhSi3f81SAMsilOYYv66O2MmBTWxZNo5uLpackVDSlxHnIuOv7GY94KMCsTfg/KrPpV24PHGBZK60nEj4GJBzH5eilV3fnSYlN9Co8reQUsfO1HoiBNBj8MlcSkjKanroi8QIsqBa09FsIB9p/11dg0ySmK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900462; c=relaxed/simple;
	bh=QgBuy2GkWGXvmfsHiQcxh427xy7I3Di/7l7N+pLH63Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCO+oZ7jUxSsrG+CfTPIxOHTMEhTyzVmvlgoyHuFyR5vIxRqNJAnjIFvhP9sbxtu1b2W8IF1Z+QIOQfwPB1GsFqUpbti14LeqKMqyewq92UfPsTx+DN5fUFrObiy5wIspvji7RAu8exm+TuNBzYC/DHEJCA1u66zYY1Q5wtX5OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C9v318gS; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhpPQmIGO8wDaYoc8JddxWLrMzYS8O0+65aAB+easoZN34EmYaWrKb265C++4p7tllCQvmzJ2XwvkC+IYpDX5cadfmxjJYiCFNbwa3HmcTeV18X60+xv8T2+8NSOa8VPyP9y319JCB+GSnRFg+lbgw6muUnPBWwDjogttKRpSkcBBpHxiq/fxYr5pvgawRUc09c0e2ntVHVrpXT/61XitxYzVBtyLMFKzpUwXl8I1wGVFvDzR37oUxk07hzRu01aEjbIKbqBAcggyCUOQATR07JkwVCU46s91sqc1gUpyYvF5Ih4Cca2UNvvJpTuWKgHH21G0rJwHVM3xvAkWjFGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2DtKH8z8HG1MIZ/qLCkcO+7OYoTnqQYyLGsP0RQVVI=;
 b=eWw/ti1pdiIPoe7YuRn10TA8I2Ba7IVpwomnjN0GHESBBKMe7l60qt5QE/tPk5TYE2DOZZ1EHDQtBAq+dfLi48ZxBhZFz+Iv5CxhOF15lQmcQfopk0q/44vEheDl/T60Xr3q503H/cmxJ/NkBzWFJsyoiktUNeuQMabSq3dD8a7TxzmJ910VvzOFjAQtz6VwHcBsicJZ2QAvGZfbd++XpKlXaZ/PtcODV42ud8V8Cj7peFNpWiY8SXyD5lQht+/m8K5seq5hlkJUstEB9ctsBeglZ8R1R8fd2PWHf2pMWFsvKmEBCA5JUX/AgDo11YlgXzgKJeNfw48GYrpqUqyzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2DtKH8z8HG1MIZ/qLCkcO+7OYoTnqQYyLGsP0RQVVI=;
 b=C9v318gSoOtXcidES+LfCKlfKm84+3o0UhddmQxYvaI21cah2Qz3O/1VcZyou0mONjXz4Fa/O2ehREwLw5KFlI8wiKv3xfPyg/iR+Vp8fyKw3aXPyIDV1XANO/VCtQGzQM/hnwW4ZdONbEO8OOb6q25PZuPNRnBzQQF5yI0zlJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MW6PR12MB9020.namprd12.prod.outlook.com
 (2603:10b6:303:240::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 22:07:37 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9031.024; Fri, 22 Aug 2025
 22:07:37 +0000
Message-ID: <36712dbc-6a4c-4637-b896-9fbd210d37bb@amd.com>
Date: Fri, 22 Aug 2025 17:07:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/10] x86/resctrl: Add SDCIAE feature in the command
 line options
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, manali.shukla@amd.com, gautham.shenoy@amd.com
References: <cover.1754436586.git.babu.moger@amd.com>
 <c6fb4ecdf3412fbfeb1c12dd0cee5d52b7306e01.1754436586.git.babu.moger@amd.com>
 <195d8806-9a00-49d8-8891-f59bca97582e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <195d8806-9a00-49d8-8891-f59bca97582e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:806:f3::6) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: c5007850-f189-420e-cabd-08dde1c84db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXcxMkJJSU1sV01oU1JTa1FpMitiTUdhcU9IdlQvT0pxbGc3VDN0dTduZ3hD?=
 =?utf-8?B?SkRkTHY4a2thSnhWK3c1bEh2d01uQTk2MkRWVEdqeUJwQzJuUlo4TDlRd3l4?=
 =?utf-8?B?Zld0SHJBbGNhVWVROHVWN0t4S3ExZkNtdDNIY2l3QlYxczZEcTd0SVFnT0dD?=
 =?utf-8?B?RGNhUHNuSjB0M2syZ3lORU0yYVowRnhSbDU5K1V3STVONjRnT3NHdVU2WndW?=
 =?utf-8?B?QUhjcUh1QjJFZHRuTmtPQzJtS1NvTHNBcmE2elpBTTNuY3V1WlNnb0w0WWlC?=
 =?utf-8?B?RENBR3liQTFhQnQyR0ZIdHdtYXNxZU11RFN5NDF2bDUyUWxqeDY2NElSQzk2?=
 =?utf-8?B?VERObStodlllYmFqUmt0UUwyb2JrQ1ZJengyTGxiS0xhNmZJbmYvVjUzV21n?=
 =?utf-8?B?YWtqV251N0UyQ1h2QlhMSzJqamZlQ094TjE3b095Q1F1TWtYYjEvMGFIWWRB?=
 =?utf-8?B?VnNEM05XTUdwMG9GSGRENTBxbFBpT2tBZ0o2TW4vV2p6ZlZmdjVsTElSOHZL?=
 =?utf-8?B?cTlBaTBWNTh6R29LT0NDa21sTHRiSXZ2a0c5TUw3MzVpTTF0Y0Y1SFZMd0V4?=
 =?utf-8?B?Yi9QOTVjWmJ6RCtxNDRvQnZzdXhaUFRsTFJ1MFpPNkt1SHZlbldwd0VQOGZN?=
 =?utf-8?B?VGpYQmdXT0Rrc2xNRHdUNmM1WUJ6VGxjeUt1MThqL2FmcXNheXcvcmZiT0k4?=
 =?utf-8?B?d3NGbXh5aHppV1hOd1Z0dTMzbjRpSjJlNVFWczVSWWRWc0tod1ZBQXNjMnVs?=
 =?utf-8?B?NTRDNVFvcjdHVzNKektQWGFkWndad25yTW1KOS9kcjVxbUsxQkcyUE9NK2J4?=
 =?utf-8?B?dmVadDNJb3lhTFoxUXlCM2R5b2hiOGN5RmxzZHRBSy9wY3NWdnZEOWVUYkhL?=
 =?utf-8?B?YzNRZDJjUDFWSDY3L1RDcm92MVhWd3FNU2NIaFNRQ1RnSUh5UEJOWUVnbHJU?=
 =?utf-8?B?Wks3RU1xRHBReU9lOTBXOEtBMDRpSVFhOW9VWVBaL1Mya0txVVJmRmdJbk9v?=
 =?utf-8?B?Z3kvTDE1Q2RKQ2ZSY3l3dGlXZWdjTmpWakJmemZVUGNJR3RBNDNRdmZMNlNp?=
 =?utf-8?B?c0dVU0J1b3k2TnViZkwxdFp1MDhHWjViSFBMN09SeHVob2xXaTUrc1J4UlhK?=
 =?utf-8?B?UWJhVlBZajE3RDZTOE5sMS9DZ0diUDR6MVBEc0VDWEYvUUNRS0RaUjFFbmNI?=
 =?utf-8?B?QTBFaHUxeFUyVWZiL3lERDlyQ2dpR3R5Ump5eTRoWWV5WThFVHpPYlc4cFY3?=
 =?utf-8?B?dVFmV29UREk3Z0htY2kyYnFwVWZUQjNic0FsNWk4b1BlR1B6cEw5cDIzNHpG?=
 =?utf-8?B?Zi83U3NVR0tVZTl2UnNSM1Q0SlR1TDNJWGp2TjlhLzRkT0ljQVRHT3AybHdG?=
 =?utf-8?B?VGE2dlJKZzhFTXozaXpQL09FWDRoOStHdkNKODhsTUtyRWhwb1h0TEYwUzUv?=
 =?utf-8?B?dGZ4Nzg4VnFENzFUemxia3c5d3A1YWhMMElTcEZEWWRpVlVsZWpERm0rR25M?=
 =?utf-8?B?bXFUd2ZjbTBzeTY5U2ZRYWpSZVFjczFac1ZGeWhRRmhpNVpzZmw2b201Ulhh?=
 =?utf-8?B?TmdBVXJBSXFLM2VqM3kvUnJpZmRtOFJwejNyV2NJNlE5dVhFVjMwN3FiSHVK?=
 =?utf-8?B?YlRWd2dXVmxoNWJnYVVrajcvYWQ3L1dXMkFteGl4L0V3RzZ2Nk9zTzlHM3Fs?=
 =?utf-8?B?TGVuNkhKbS9yYy94SmFVZ1dkNUpLZWxXVFAwRXJKL0RPWittK2l4eHZMZFlE?=
 =?utf-8?B?dWl2WlZpU2hnQ3VndUVxR1laZFh6ckQwODZiTHNvUVZtbTRRRExCMGtDdzlM?=
 =?utf-8?B?VW1DbjNNMUpsWE1BaWFEYVZJNjR1U3RNb0RxZHBzcUxQb3ptODRRdXYyL21l?=
 =?utf-8?B?T0hCdnBCMjcraHpyc3BtYU5ocm9mcnNCK3pIVE44MEhhVlFFekZWQXJaWkhq?=
 =?utf-8?Q?x6FQTSbK/KE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tlp5M0U2VURmVmpyMU1VMU5zdFpqYnBraS9tZ21CU2Zha0RrUjdSS3c2SWEr?=
 =?utf-8?B?WHhsSDJjTkFLRUhWWkRZV09ZVk4xa2RGRmxUUEdsZzFSQk9KMy9lLzBUQVVj?=
 =?utf-8?B?SUlPZ1pvb0wxak13YVFOYmhtUndubXVYaTZmWXozOTRpZGFycGpxbkhEaU5x?=
 =?utf-8?B?N2UvcmhZcXpPMDUwTXJQWnAxUXVwMGhtcHBKK21WczZiaThxL0RTQXIyWFg1?=
 =?utf-8?B?VjZPRCtpVE1XdStrcXV5NXB5WWVaTXNBUVk5OTJkbVBSMnArYnpGbTNrWlVK?=
 =?utf-8?B?aVU0Q01HWTk5RzkxWmw4Q0lFN3loZ3l4MXJQOXlUWDhRaUlTNWdqbC9wdEp3?=
 =?utf-8?B?N0ZKRHcvOEY1cXU4SGlUakRmQ0RFQWdzZG1lQ3Nmdmd1eisyZk9XLzFUazBT?=
 =?utf-8?B?aVpxenB0MXJ0QVh5enlUYmFISTdVdDErOXpLUHJ3dEFRTG5aYnZGQm1ndUFy?=
 =?utf-8?B?R2IyVzVOWXZ1RDVCTkxnQjhTM3IyR3AraE1xOGh3Nnd2c1RLaksrdFJjeHQv?=
 =?utf-8?B?K0dmMk9YUCs4OEhnNmVCOWovdVYwTlI2akxiNE8vVWZ6R0djSXJURk5UVDNa?=
 =?utf-8?B?MjdiWnFONWN6Vk1qclN6NzRNS1FHR2Y0U01qaUp6UFcvNzNZejQ5WGR4V1gw?=
 =?utf-8?B?U2pYcDIxcS9iR2pUY1B3bDRhNHJ4Rmd5YmZqWG9PdS9vQlRVV1B6UlpWY2JB?=
 =?utf-8?B?alUySy9mZGtBNnZmdWxuUTVHcEZrUk5MQ3kwVnltNzhkZGRxMWs1cUFacU4z?=
 =?utf-8?B?VlQ1dVBpeXN2OUhFRUJ5NncxV2ZLZk1kdEFsamJCRWZveDBBL0hIUS9lV2tY?=
 =?utf-8?B?eFlwZW1TVE1lSDVsSGIwZGdOYXJPNldBN2pmODJMT3JHVE91c1EyQWI5NzNh?=
 =?utf-8?B?WTkwMFV1QnN5R0RIRjN6UEF3RkxBTXpGVnZ2cjBIMlBuUGN1emljZDBybkZL?=
 =?utf-8?B?SlFwVW1xaGloVmdsYVdzWnVzNG5hQkRHT2NxSW14R2N1TmtDQlFPY08yWlRv?=
 =?utf-8?B?UEtuQXJLbGU5WTZEeDFrbFdzSkQydXNkTmFESWlMKzdhMVF6WlJ5bW1HRUMr?=
 =?utf-8?B?Z0Jsb3NJemZVL0lRSW82RFBTTW5vRWpGSWxYcFc1cER6VUMwYjV5aXBFNnA2?=
 =?utf-8?B?bzJ2RzJvODh1QmhFVXB5SWZabTdObUVIMjdXOTJwV3dyL25LclhXclFrblFm?=
 =?utf-8?B?dXpXM2tZWTN3OW8xMi9adkxTRGNCRW03c04ySnJwbnV1TkJZcmRWbVQxSmZo?=
 =?utf-8?B?VTVWNmhERUQ0MlRMaUZXMmNsa0lLc2Z4ZENTZG1jc0ZwejFORk9ObWowWXZK?=
 =?utf-8?B?cFRpN2hpMzNuRjFFTFBYckVDZmtSL3B2akhzVzZYcjB3YnE4My9QQ0g2bmEy?=
 =?utf-8?B?bHAxZEI2bEVMbENrejZUUjJsMzFkNHpyNU83M1FLTmRzK1MwdkFYT2Z1VGU1?=
 =?utf-8?B?VFV1NEU0eWloZDBQSkZTNytQYW44ei90TnNCQytzWFNNWEI4WUlBY0xqVXFh?=
 =?utf-8?B?Y3k0ZzZzMTB5ZEhtb0tpMnY4Sm1mdXgzUzFIbi9RRG4vdVpGQU0wWHhYa005?=
 =?utf-8?B?Rk56Nk1VcDQ4UVlpQmY0SWpFcW5TZ2luWTFBdGlzQ1o3V2dQcEg3OHd1SGhu?=
 =?utf-8?B?SUpQcXBOUFR6VlV4bFJ2VWdLZlNnNXM4RHRIZzJYTXFYcHhTQVpreGdRTjYr?=
 =?utf-8?B?clBLYXVBUDM3cjRzVnpobEFlQ2VSUFdoUFVXbElBN2NoMGlYNHhRa0x4NlVJ?=
 =?utf-8?B?QmFmc0I1blVyVmVkR2hlRHBuaWhCZjVsWjRWd0VyOU5vTkRmQmZYWXByRExw?=
 =?utf-8?B?UnpUZVUyUFQ0a09jVTZMeEpIRjdwQXVxaFZWVGkzKzdSOGJ6cUFLZEtNWnB1?=
 =?utf-8?B?eXdqMnYrdDI0UTNmYmFIS2hDSUF6RDRTYm9ESXZ1S1hRWFpUTFl5VlJYTENR?=
 =?utf-8?B?OUlVbEZRNXgxeHFjM0o0bUlUMHVEcGFrVEF1UDd5d2FDS1gwSlVUNUpFYjNa?=
 =?utf-8?B?OC9iZGFEUmpLUk11RDhYM1BqQjg4TEd1eU11UUFTc0RranovQlZzbGJkSC9V?=
 =?utf-8?B?NXJqOEQxaENZcXFrSGI5bFJheW1wV3p6NEkyR0VmVGplR1RxQTBYSHFQM1Nz?=
 =?utf-8?Q?kQnC1px7Aw/EfaYuNkvtq3Dwa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5007850-f189-420e-cabd-08dde1c84db0
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:07:37.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alno2McWod/ChV1/Va71Ii6t+Lk+PMv/jTa6kRo94JRQb2WBDR0lwHaqZH+KMVNO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

Hi Reinette,

Thanks for the comments. It took a while to get to it.

On 8/7/2025 8:44 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/5/25 4:30 PM, Babu Moger wrote:
>> Add the command line options to enable or disable the new resctrl feature
> options -> option?


sure.

>
>> L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  2 +-
>>   Documentation/filesystems/resctrl.rst         | 21 ++++++++++---------
>>   arch/x86/kernel/cpu/resctrl/core.c            |  2 ++
>>   3 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 0d2ea9a60145..0170c0af03cc 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6089,7 +6089,7 @@
>>   	rdt=		[HW,X86,RDT]
>>   			Turn on/off individual RDT features. List is:
>>   			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
>> -			mba, smba, bmec.
>> +			mba, smba, bmec, sdciae.
>>   			E.g. to turn on cmt and turn off mba use:
>>   				rdt=cmt,!mba
>>   
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index c7949dd44f2f..f08699030312 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -17,16 +17,17 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
>>   This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
>>   flag bits:
>>   
>> -===============================================	================================
>> -RDT (Resource Director Technology) Allocation	"rdt_a"
>> -CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>> -CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>> -CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
>> -MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
>> -MBA (Memory Bandwidth Allocation)		"mba"
>> -SMBA (Slow Memory Bandwidth Allocation)         ""
>> -BMEC (Bandwidth Monitoring Event Configuration) ""
>> -===============================================	================================
>> +=============================================================== ================================
>> +RDT (Resource Director Technology) Allocation			"rdt_a"
>> +CAT (Cache Allocation Technology)				"cat_l3", "cat_l2"
>> +CDP (Code and Data Prioritization)				"cdp_l3", "cdp_l2"
>> +CQM (Cache QoS Monitoring)					"cqm_llc", "cqm_occup_llc"
>> +MBM (Memory Bandwidth Monitoring)				"cqm_mbm_total", "cqm_mbm_local"
>> +MBA (Memory Bandwidth Allocation)				"mba"
>> +SMBA (Slow Memory Bandwidth Allocation)         		""
> With all these adjustments this looks like an ideal time to fix the missing TABs in the SMBA spacing?


Sure. Noticed both SMBA and BMEC had tabs missing. Taken care now.

thanks

Babu

>
>> +BMEC (Bandwidth Monitoring Event Configuration) 		""
>> +SDCIAE (Smart Data Cache Injection Allocation Enforcement)	""
>> +=============================================================== ================================
> Reinette
>

