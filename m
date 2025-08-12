Return-Path: <linux-kernel+bounces-765477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79EB2388D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1263B8700
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718912D3A94;
	Tue, 12 Aug 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HL19aX0V"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90527703A;
	Tue, 12 Aug 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026611; cv=fail; b=KzidKaKQVA3u3+mAoJeV+i2o1Djh4FyLUI635Z9SjHfPBuFPUlyO1lhh5e3L3c8ClF0oi4A1ah1acznIfv6+E0Zm0f1RIpOghIbGNmkeA8Xjk5i4a0f5udRWeI/cvb9JFh+JiHxOmanC4da1aR6EAgPAYiWdt/XY0XSCjkjBZ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026611; c=relaxed/simple;
	bh=hgZ/GIxEkF/CEtJ8JME3HYZlWWGWUJ3bgKmPH6qTIaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCDjCYDIVhRzOpBs19KcsF+jem814siFIZDe0iwek3ci3+yxou8605tlCS+gsAV1v4j4TwGzSmwv5kLqDwSV2dhKJCBnhRwJbbvOMJHxhcGBH5Dfvvj71FuO7z8UemUs18XtlLXywT/oEwFpsZuRZ/9QylRhvfDjlbuIvf5RPG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HL19aX0V; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRaaVhXR/7CEre3sAwwv+XxbVVINObKU1eck9uHLA35yJ8PI1UjTty0p6uk/Fzy7cqrM3WqJ5DU6AMyO6pjYOYXKJa0hum1JDwKQsgEklWRMv1wCI5n+HcRhp5d/OLi8eKzkNs6U27WOaiyhRJN6t3s/r/k18zQs58W+VJWzjvgIzdQW2csKOTTI2Qjzf3qUhJJZ03myZzOEokm+zH8mhevlKgGMgZv1NDIpA/vFunFa5ZSkYJfmsK1ypsBE1NVvesMYRJvOK8Cx/zku2tWx91Jogpoqp670YIBm5bDni1Ydy/Zc8dTQOHJp0fJyYVMBOGlBzoKMjuXFUuc0aGuTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=584e+vGE6gwRHe4Ey3M6t+KRQ1TVMGfYIKUufK0Ibu8=;
 b=sqARwxitGvacy8o/bjacaB7i6jDjOt+bUDjeLs4UUgM3sR0YdW/WmEZWT70kiAgGZYIgem0bgO/kNPeSKhdYJlqqT7OFBHM2QRHH40hliDnmcBSXfTENixwGbaS7+Urcpj1RtemGpaRc/f68r/klSb0cj7sG4Bl1fMT3SaOC6j9Mxi6Xaas6FLmirjV0f2/qahtkgPgBA/ol8pXjsfBWOKWFktvvurAxzXFOO5bApSrYr6/XpQ6KZrcnCOQPsJlhtjirxSky2xHj/f+TCBPgk7AYMwVtTo+qdS040mwOYcHUqq8U1GO0s2UtqID7oqhNhzt953SL25rfPZiEstEfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=584e+vGE6gwRHe4Ey3M6t+KRQ1TVMGfYIKUufK0Ibu8=;
 b=HL19aX0Vg6+emkzu+axp8QBNCMDFgdRg+NZo1z5RNHOBEAD3BuPSMUCxfUJSYXlyUk3FNb+EBmQf57iQUcYmbHz+tZLM0HgiUWk1Bj5sy1yCiWDOdDMNGOrzza5nf+eMbPPQBYa971sSK1Zng80Puzn5XFz8ilNU6UbNYtF6Pp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN2PR12MB4335.namprd12.prod.outlook.com
 (2603:10b6:208:1d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 12 Aug
 2025 19:23:27 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Tue, 12 Aug 2025
 19:23:27 +0000
Message-ID: <a5ab8459-c5f4-4fdc-ad7a-f174adba0732@amd.com>
Date: Tue, 12 Aug 2025 14:23:23 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 34/34] MAINTAINERS: resctrl: add myself as reviewer
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1753467772.git.babu.moger@amd.com>
 <716f7dd7550b7cce8d4a3b1b29904cdf7224a090.1753467772.git.babu.moger@amd.com>
 <12501ece-0106-400d-93dc-de5f05a03acf@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <12501ece-0106-400d-93dc-de5f05a03acf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:806:f3::20) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 567f509f-eb76-4e99-3e83-08ddd9d5b6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmgzNi9UQzNSMWNyWTQ1ajIzazZTZGk5amhvcERNQU9vZWllSEhCN0tNQXFs?=
 =?utf-8?B?UHlWbkhuNUViL2diQ1lMcTlGL093MWg5Qld5blNOR3FDVjQyUktsRU1OQWlM?=
 =?utf-8?B?am93Y3IweDE2YUVkSnlrUFlIQlg3Mk5JNnFCRGNjVUlkRzV1dXJYblduTE9E?=
 =?utf-8?B?cjA5eWxLWTJJUGc5T0wweDU2T0hKZ1FmVk5md240aWJjU0dodkRZeW92TmFi?=
 =?utf-8?B?WmdxQUh0dTVuZm9BSExlU1pUdkxhZ1ZRVmtka1Z2UldQTE9TZGllSzk1a2Yr?=
 =?utf-8?B?dzhQeVFMQkhaTVphRjZuNWViVDI4ZDFyL3hEbXpPS2pUS0ZQa3Bud2dNWjgz?=
 =?utf-8?B?LzlKUy8vSzlNQnJnZ0hrNFdtVkNVWnIzYnRVL0hROWNTampibFVHSW50SHJP?=
 =?utf-8?B?czNOWDJaL0F6RXg0MXdxYXdBcGlIUDRBcjM3a2RtaEdOaWEzMFk1WWE1SVVZ?=
 =?utf-8?B?NWw2MzhGRlNkTjJGbENkN29mNkR5U0JzSjhPeDJ1cUJ5c3QwYW1jRU9BTXZw?=
 =?utf-8?B?L3U1VnVOQXRVMUFsaEhIeG1NQjVyNGRiaGpHOHBmcGlkQXVlM2xQR0ZQOVpY?=
 =?utf-8?B?cm9FdFJjZy9GRTlmYTBLc01KZUpXNWdzbjBVYi85SHZ6OHhWK29pampqczg0?=
 =?utf-8?B?RnVjV1BQK0taVVN0Zzc0Y3kzV3JsQ2pQTFY5RHdqVHhBOVFHVUJhdmF5SXoz?=
 =?utf-8?B?cHl3ZUVqelk5dmlGTnpmSUdDZTI3SGNybE84Ni90a1lGZ2dWNS9rYndXOEFF?=
 =?utf-8?B?YmFOZWc3WWYvM0JlU1NyZUdsMm1kOHFLSW5taDFMRGpWZEx5REl5dC9VYjU1?=
 =?utf-8?B?Kzd2bGtnQmdPTFpDSWkrUlRrcm1kSy9jWldOK25lMlFadml2OGJjMS9tZEZw?=
 =?utf-8?B?SUR1Z2JiWlFlSTBFWEFRUlYyNnIrNk4wazIxWHp0eEJad2NTMHl1VXRSU05S?=
 =?utf-8?B?Ym80Ly8yTU9BMms4d3A4ZFdZM3JmT201a1M4bE90OHRzeGVsNzFwUFZ6VXVG?=
 =?utf-8?B?Z2dzcVdVZFRYR3hNNFhvRDdzN0syYzQxbnFSU1FqUFFSUytsQVVvd29CbTRW?=
 =?utf-8?B?cExIcXhUUHRzbVFiT1F5cGYzcGFSS3AvVExqeDNlaTgzeGVCQUNSMUFFKzdK?=
 =?utf-8?B?MXJQS3lOeFlCTmd0SVdXMHc5WGE4SVJBMnAvM0FHVTBjb0M3WFQ0cnZBUVJw?=
 =?utf-8?B?S2ZKcHlId05IdmRlMi84dFB0MTllN2M3WlduN0Fjc1k2UlhEV3BmbCtNQ09S?=
 =?utf-8?B?amRoMzBaTk9JOHdUTFBoOXhyTFQxMS9Cc1RDT2NMNHJxWHFkOCtLQmkrQzhr?=
 =?utf-8?B?d0o4b2xDQXF2NlpBNkVMU3dESGJzUXBnU29lcUtNRmxnbEYyNDFqVWxHRVIx?=
 =?utf-8?B?UHNmdXcxSzZST29kRURYSzVkb2pVUExwd0ltQ1JOUDM3SE52SndqZWZ6ZFEz?=
 =?utf-8?B?eUZBd2JRcDlQeWFuYnhzMlQzUzYxSGcvL2I0WmdXWExQVzRHUGFVYmNBSUkx?=
 =?utf-8?B?anJ4OUswMnZjR3lURUtqYlNXKzFDNnFjZnBpUGdIRU1GaGFTb1hVeGZiTHI4?=
 =?utf-8?B?U1h4L0oxU29HMXBoYWlYQ0JHTjlVTW4zUU1GcXoyeVR6aXE4b0FxcEZBM09E?=
 =?utf-8?B?RVA0TWRGdDZPejNNR2hubWFXSnFBVS9RNXRTVS95anBYYmJOTXhkZmsrMnpy?=
 =?utf-8?B?NWlXSFBNYVJ6MXhqVkQ0OTgxR2ZIUWVUSkFZajI3K3ZqK0VrZjloOEd3RVls?=
 =?utf-8?B?MmduYWNlbnNVNzF0WmRySE9UVTl5bXc4V2FnaWFvcmcwTlZNZVJPa0R2Rk1h?=
 =?utf-8?B?a2c4aXlxYnFYWUhEWXdyc3FLbmVLZVRsaGJJKytmS0c5ZjFsTE5TNnF6Uys2?=
 =?utf-8?B?MGp3YVJuMmdoMm1vWmt5RlVVUE1EVmZjQkhwUEpabkxIdFBjYzRBL1huYytN?=
 =?utf-8?Q?VWtRrrD2Q6U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHhtOTVKS1V2d04yQy95bVE4QTZQMzBOTFo1bGZMYWE4MENWdnRqQ2FtSzdj?=
 =?utf-8?B?a0o5MGtnTkN5andSQ0VhK2huQ2dad3ZuU2JhY2VSTnhtOVRvYU9SazU4d01q?=
 =?utf-8?B?ZlA2aUpLbkc1Vi8ySDV0S3RwT1p6Uy9HMktHRFhFY21qOGpIT1VqcEpRNjdh?=
 =?utf-8?B?OGV1OXBJZnY4NitYMzhWdVNuaTZtVjdKQXZoUWgrbUJDQ2lYbGJsY1lGV1F4?=
 =?utf-8?B?VWplbWpSaTV0ZGxIUks3a2FYT1Y4K0NqV0xRQWIrdzk5M2xQYmRiL3JKZ1BO?=
 =?utf-8?B?VlQ1VG1XeWZ5d0t1SGpRU2Y1N09UMEtJNmdMZ2VnM084YVdQTWZ6ZkxkSUpI?=
 =?utf-8?B?UjFtV1ViaVF5S2M5V2N0ei8xeGoreUV4LzVyQVhXMlUvMjMwTUFvL3c4UmpW?=
 =?utf-8?B?VkRmcU9QbFFBbnI3VHhHbm5CckM1RXdNd1c1ZXpLbFpPeEpZMmpEZTEzR0tR?=
 =?utf-8?B?bTJrMXJnRmlwNVd0aEI1cU8rR2NURWZBV09nQjdBVlRDN3h5dnprVXNybUdB?=
 =?utf-8?B?elIzZ0NOQjYvbEFObS83RHVnRFhZZTc0dm5sby9KQUpKck9hZFowZE9POHc4?=
 =?utf-8?B?ZklGVFAvV3N6WVlOVC95NGl6MEtGRnZWZ0JUMjNOTUJOSE1lc1RpYmx6a0Zr?=
 =?utf-8?B?L0QvVHhtNE0zbDdFV25tdnBoQU9vQWFKYjJQQVlPMHdnNGVQRXByOWxwSWc3?=
 =?utf-8?B?Wm5weVJTSXlST1M0U25aTlhSd2JnK0JDaEluZHorZGozOTFiZGpvaTZQaEJ5?=
 =?utf-8?B?VnovbzNEbUZvbnByQWN1US8ydnJqNVQ3MUFrVi8weDArdVEzUkZra2NuL0RM?=
 =?utf-8?B?dVFNQTBrOGhQbXdPZWplZVVYVFY0bkdtdjJGZXdYbWoxbEZsbHB4YUF4TjZQ?=
 =?utf-8?B?aFJYcXIxdnVyM05OTm5GQnJFbHJwVGVIc2ZPcDh1QTIydmcvN2lwQm03VVpw?=
 =?utf-8?B?WW4yMlRZYVpmL2V0QjRoWDVPU1Mxd082ZEJtU3hkV3FCcmkzbjdMVEFBZzFV?=
 =?utf-8?B?VG5EblVKZDMvZGVBNmR3RVhPS0xFTEJ2L01MbXB0YmNOS3hDT0ovMEZiSDJD?=
 =?utf-8?B?OWMyQUZReEJzSUd5aHpaM0ZRZE90SWw0ZDQxT1FteWtMTmVrWUZYd0dtenVC?=
 =?utf-8?B?dEZnbmVJbzN2aW1zM1hSamdIRC9WT0REOGJ6aCs0VUsrNkJkNUxZd21iRFlk?=
 =?utf-8?B?MTgvdkVCOTdKZTVYRGlWcElSKzg1OXpVcnltTGUwcTBzOXduYlJFMEw5UTBr?=
 =?utf-8?B?a1NGaWFVTnlqMXB4aXo1ekZUWXpXMFRaYkxiMS9sdlR1cEV5MUZYVE5iRDlO?=
 =?utf-8?B?MkNVTnFBVGRPOWdkT211R05IejhNVkZuL0dnRW5mc3piS1hMbmFZK2pJZEpN?=
 =?utf-8?B?Y3hFZE5vZFVvOEF4M0FZWmF6Ly81T0ZNTmpGcngrQW13cVF0MitqQVJnTVly?=
 =?utf-8?B?MlRmM2NpbDM3S2IwVFVMZU1lakZjVlBxeExPOEVNQW8ybGo4Q2JkNlpDYlh2?=
 =?utf-8?B?NTc2cDN1dkNDSUNEanlhTHJPRkZLeXVSS0RoTWtYUVFRUmlra0hGZk9XWVBN?=
 =?utf-8?B?TENnUHp4a0RhV0VOWjhVSVlXTCs2aHhEWlNXaWMzbW93UzNHdVg1bTlKSDZl?=
 =?utf-8?B?Qi9ZeldjeXVsWDR0SjJ1eWpPZ2Z4aFNvbHA2dGZ2dTBub2JOQ1lVditwOTR1?=
 =?utf-8?B?bmt2RnByZlRuRVFoaEhidXh0VXhqQVJnajE0eUlScmVrM2dNaXZ0ejdEWElO?=
 =?utf-8?B?eFdjamZBQkpucnc1NTVWRmx1bVdDUDZEWEVlUHI3RmdnbWhDK2czQUVlQy9H?=
 =?utf-8?B?SmdaWFA4dFVNVVFHbUlNVnIvMGFQaGUyVS9ZZlpGdEsxcVIyOVk2ejlVOW02?=
 =?utf-8?B?bFh4VGo4SkdpSndpUjYzbi9jU0NIOXN6VnU3V2pKQnhoZUpuQ1dpUlgxYzZV?=
 =?utf-8?B?RDgyTStXL1FkTitHaUsxdEFHK2tiT1RUU2xiSit2WUxaZmh2ektHTGkxbVVE?=
 =?utf-8?B?TmxIRlIxc2taTThOTGNtVnpiZG43cFRSbG5KTU9WUUJNLzBGdDNqRWFwam05?=
 =?utf-8?B?Q3lGcU5TUTdBY3pta1c4V0paTFEvM0dzWExNaHJvM1QwQ3d6M2FRR2lwNEE5?=
 =?utf-8?Q?EXhY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567f509f-eb76-4e99-3e83-08ddd9d5b6e5
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:23:27.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6Z3N7D//AUDj8u64U0Hb9xKKQ0bjwrVj3ZWCqY3dB6kv4KD2QIih0Qtggn9HA2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335

Hi Reinette,

On 7/30/25 15:14, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> I have been contributing to resctrl for sometime now and I would like to
>> help with code reviews as well.
> 
> You do not need to be in MAINTAINERS file to help with code reviews. I do believe
> it is important that you are cc'd on all future contributions since I am not able
> to test these new features you are enabling so having you keep an eye on the health
> of these areas is greatly appreciated.   

Agreed.

> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v16: Reinette suggested to add me as a reviewer. I am glad to help as a reviewer.
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f697a0c51721..70a2f83145db 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20866,6 +20866,7 @@ M:	Tony Luck <tony.luck@intel.com>
>>  M:	Reinette Chatre <reinette.chatre@intel.com>
>>  R:	Dave Martin <Dave.Martin@arm.com>
>>  R:	James Morse <james.morse@arm.com>
>> +R:	Babu Moger <babu.moger@amd.com>
>>  L:	linux-kernel@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/filesystems/resctrl.rst
> 
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> 
-
Thanks
Babu Moger


