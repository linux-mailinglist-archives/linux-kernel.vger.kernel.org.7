Return-Path: <linux-kernel+bounces-742566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F9B0F3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2BF9611E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F25A2E5B38;
	Wed, 23 Jul 2025 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zx/HUrzK"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC52E7645;
	Wed, 23 Jul 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276497; cv=fail; b=HVgTmJGdaJ8/ys/pXRRgrso3Df5Y9Sam7fop9lCv0KU7j6xpiDjVWVT5AUa6zTdhr3lMYlyxayOA4pEh+90iQfH6p1Bkq0BPFFBwsCLD2b8LwpVtjDR+l9gocVaf1bHMasBZFAuM7K7kLjJon+MoBWaTsX0tvHCXhRG3ztwE6zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276497; c=relaxed/simple;
	bh=yV1xsQ0ldvi4OaTUbOvGqiUaKTu3qBAQSvr57RbdeAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T2W9U7PFFwlo1Ka6j9NvDk3hioMD2pCETHG3cmSO74rPfIQ9w3eTUh0Zo7k9/TefdJ4OADbgWXFlrSpKMHF9OPv6On5uV3DNpcr5spu1eFTizRereGwt7Q84UkXQqXNBk93OOCGKZu8/CAi9jbFsSAwdXD/w2wayr7hTuWfd9k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zx/HUrzK; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijKXkzefEiyE+AFkDtRJHv4yQR9ACuHfBBoK3tHF5NdfVBlvU2I+Ev6jx4VZ77Nsf1IOquLUTgJFnJMkVM8q/GSc04LkS86CBh/HYj3e/5XZJi+NZ9b/PGK6DAtClYFNGJa4ZF5TLNr+IxHPPM+js70adiaG3uwqmhgsiKfaBL/7hfjiPyuFi4gMGvGI2wEPfmiLvvhP0qB+/wZG5aPCkKC0h9mxfp9EyCGrvDZvdesbpFbJHfxpydGwh0VwrSa6hvegHRNwQqzUHqbfMbpmFs9ckEEf+XF7kCHGZ+uSif2MdlsWNrn9IgsvNMA+DJu9QWqVFhAjZhs13cLceedMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS7m37wlsR1Bb8uX2gr7iSMiatAeeEwWFUSqsBNkkw8=;
 b=HuwFMIKf42nq/aTA+FI8fVC+5yCIh61psn3zdy4WeKQ0QqVgUMd6I/dY1R3RAzLmN1BC+omPQhDKBLOwDkRfOvOm9loFPkoOYAAcg8y/EtwIczGOvQzYF894N0n6uOW+pAw8WuPbXROU1yycp0y2j0HWcdf+Z3ipU23UoAgvumnrTXil4FfMqMLRpBzizpnUJmxw/UtDOhGIzeZ+fK7wEGgkCwF5d2a41Yb73k2yvZFiRfH+swQvKx0zbNMR2RumzsMu+v7EzCJJbM/xDtFvKl13XVidVPFAH9RE8S87qBemxjQl1u1RkevqzK3V5xn3upjiQDOFk2Hs2LlrB4+y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS7m37wlsR1Bb8uX2gr7iSMiatAeeEwWFUSqsBNkkw8=;
 b=Zx/HUrzKptgVcrPPM6waS5yyCOc+UPCtuYA2cSFX2yx1vZzLOoBWEqJjw3/0LeTfrUy7OIeSytykTvYb3qV9koDsqf3+fdyHczi0mPw35BsE9Nr45cuxi8k47iR82Y9VhtRfGNl1ePnpipIW/LFeG/8atnKUAcZU8JaGqqEhQnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 13:14:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 13:14:52 +0000
Message-ID: <2c107793-1258-4276-8b29-03359fa605f2@amd.com>
Date: Wed, 23 Jul 2025 08:14:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 24/34] fs/resctrl: Report 'Unassigned' for MBM events
 in mbm_event mode
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tony.luck@intel.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1752013061.git.babu.moger@amd.com>
 <296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com>
 <4b5eef45-9110-47f7-8e1b-a59028d66c52@intel.com>
 <1a7e2a89-4006-4180-88c6-aa7cad76fba1@amd.com>
 <791ff5e0-dcd8-4bfc-810c-b085bc4ca543@intel.com>
 <37f2b5b1-0e99-45dc-bba3-c8c22fb298cf@amd.com>
 <0fd87712-0a71-4f4b-8780-648099e708fa@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0fd87712-0a71-4f4b-8780-648099e708fa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:805:f2::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a7e207-0c37-4bf6-8b7c-08ddc9eae8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVV1TzMvWTlpMXladDBMYzE3MU5GcFkvUnRaTU1zNVNFbFlyclVTbENvM0la?=
 =?utf-8?B?UVIvMzdmSml0MTlvUGNwWXBpWTdLRnlkQ1prNE9tMEFQV1ViZFczZXM3Rjk4?=
 =?utf-8?B?T0d4QzdkVnhBaFdjM3lhdCtUSFJRekpLUldMekdxSERMQnhnZGoxMTU3S2h6?=
 =?utf-8?B?RGNOOFJZdXg3SVBZTWdBZ0ZkOEs3d1lqNkFIaUNWU1lBTWNLQmQxVmh2NzJI?=
 =?utf-8?B?ZEswNnNiUzd0emxxaEFzSkdscnQwcm5zd201QTltcFZCWGFyQ0FvSUh6aGxM?=
 =?utf-8?B?d3lDRTA2dW5ya3RhcWwvanhoT2xXMk5Ta3JHRnFEWElPczVhQzdCcURzQ2Jr?=
 =?utf-8?B?Wi95NDFkSmNCSjdSenNycHRicy9qRnB4T0VZYS8zRXdZVTlXZm1zZ3hCVXFM?=
 =?utf-8?B?UHRWazFub1dIN3B1ZU9EL1plcDJEZ01nWWV6SkRTVlA0R04xd2dTUW03eDZo?=
 =?utf-8?B?RlZvSENHNko3NVllTFZlUXRvbWRmZUxOMGd3QXRxSTBoM1NBWDVPODNNMmtj?=
 =?utf-8?B?TkNCbytBLzFpMUppQ0ExUVJQQmpDY0V6WEFBOHhHU3VyRHJQS1ZjNUZoWndO?=
 =?utf-8?B?eVVYMkxYeWtUZkhGWXEwVU9OQmtFRWZ2bWsza3VCNWY0TkpUbTFJL3lWNHR5?=
 =?utf-8?B?QmhqYXBNc0lIQm5kdzdud0twYnhpWHhWa0tMZW96VTBGc1Y0V3lLY01jRmJV?=
 =?utf-8?B?U05aa3JYejBXY2J3UzFjQ2pRRHNrSVNwWVdMUXVGVHdiZC8zcWZLejJqUUlp?=
 =?utf-8?B?d0JkWklHaS9ZU3ZEbFQ1RUROSVhZdElUKzh2c0hUQWUzNE1wOHpDSFlDMVRp?=
 =?utf-8?B?MDJqQ2VrQ2xmS3JzRUd0NjNtc3hBaEp0bFpXL2VuU0cyZkhQZzNNSG5XQ0ZU?=
 =?utf-8?B?QU5CMWNlSlN2VjhFeTlGQSs2VlRqQ05Wc1pvODQ3MGI3U2RCQ2ZCcElHN2g1?=
 =?utf-8?B?ZmpjOHY0TVNLdzN2WUcreHZwKzJNSUZpUTVNUUwySncxYXpzSFVUQjFqMExz?=
 =?utf-8?B?SXRMaXlZSnJlMUt3dVZjYThrajlBTXVhUVBPVC8yNGpFV0haWFJGUjBNbHVJ?=
 =?utf-8?B?dHBOZG5DZTFoUlp4dDZiRjAydTBSSWg3WWtuY29XMXFrOGdua1crM1hvUktP?=
 =?utf-8?B?ODJvcTBZNXFnekNzbnljNkJwa3d3bWFaY1hscnZJRFdFUko3YkZDQ29MRGND?=
 =?utf-8?B?RlpQTFNRbWx3Q2lhUXdVbE96VVYwUldzS3dFQ1ZpSkRHbE9lWHVQdnV1N1Fo?=
 =?utf-8?B?bUozQ0xVZ1ZXOTU2ZWlQRlFMN2JpVGlPa2R2ZkpCejJmQlJybnY2dTJhNTNl?=
 =?utf-8?B?NXdUZ3RCdzFxTWJnWGN4ZHNpYjNWd3dBMEZlOG1NMGFHS0lycXZmb2FSZWcw?=
 =?utf-8?B?M3pyWTQ4NTR6Q3BjUnB1UHJqNC9FWFl5R3h4cm5GMVVxSDRkd0NpK2t6Y1lY?=
 =?utf-8?B?cFFNSDZqYnVRQjJ3bG5QV0lnNEZVcEkxM3RKWDI3cjhtVGg1dzVaMGs2M29o?=
 =?utf-8?B?ZFhJdys1Z1pldlA2L1JXK0dwNmNGMW9JdVlLdCtYM1hkNDhoRnlmd0pSK05B?=
 =?utf-8?B?QUovZTk3d1BnMms0cC9WMjRHd2N4elBNdjBIQUhRbExTczVRU0lBTFhPMzQr?=
 =?utf-8?B?aXA4S2hkRjNTM2c2NTJ3VXIrZnQ0UVVJNjUwemFlQ080VHg2VnJTdmx5TEVQ?=
 =?utf-8?B?SjdWU05pOVZzNVB3NUY3TG1qNlMwc24zQkpsZXZSSm8rT1NQTEpsSWVib2xs?=
 =?utf-8?B?L2NXT1plQXRtWkluaFFuTmhJalVHS1l2enZaZ3N6aFM4cEpTZWwxVVhrRElm?=
 =?utf-8?B?L2tNTWU5Q2VlWW1HV0FNQ1YrR2FjeStoNEdiaGpYelNsZTN2eng1a2xUMWFq?=
 =?utf-8?B?UnZWN1dEOEtONUZTVWJBZDJvZnFpZm83Y1YvQ3BWZDI3aDdyQWZnSHh2OFpI?=
 =?utf-8?Q?rsT/Y/FVQoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUUzbUFhLzRzS2JWZStJclBwcmtOQmpITEVnUkl4WGY0aHNENUZkTlV6QjNM?=
 =?utf-8?B?SzljV3huTjlWMk9ScVp6clVRbm5FR2thMGtGNVZTcTlNYXdwZmVTalhrUXZT?=
 =?utf-8?B?MzIzRlhaQ2ZHNllSOURpV0dTNS9lS3F2UGdFNDVHdU9wNXZPbjlLY1hodzlq?=
 =?utf-8?B?Y0NRZHV3N0lXYnhmdTk5cHZpUEpLeUhIcXgydThhb2pSa2xrZzQ2Z1daRzZi?=
 =?utf-8?B?RWY3cEtwQmxBUXg2Ym1TVkpyVkM5TXRTYlJab2k2NitYVVRyTFpiZ2c0S3p5?=
 =?utf-8?B?cmNXZ0MvRHArYUs3NXp5Z0pWWmRRMjFuU3RSWTcycnVQemxuK0JrOEZEdFlH?=
 =?utf-8?B?dUdKaHRvVGdDUHNQWDlWU2xIcjRQcUdCSGNTbHBqN0dXWmhmdDRoYS9CTTU1?=
 =?utf-8?B?SXZPazlpZEE2Vm5XKzlsQ2IvUlBjT3pITmJ4THdKVER6UUdGeEgwUDRwU05i?=
 =?utf-8?B?cFdqZ2kwMmJLZ1JUMVdydE8veWp6QWJCdndWVDBXUXZJU3pGYlQvZTZqbXBh?=
 =?utf-8?B?VCt5b3dtdkxqZSt0V3V5NWpzTURSUUlPK09ORWdhaDFxNmVzQWEycmtvSXJ4?=
 =?utf-8?B?MktnaHBBVGpDM2krcjFob2VzV2pSOFU5WExYSHVtNkhMazNGOFZuSDN1SFpN?=
 =?utf-8?B?aTBRYWpuR2V0RGVTQlhKaTIzODB1YmwrMzFXV3htVkxzcXNvemcvd2NqK1RW?=
 =?utf-8?B?Qk9sRmhJc2RFRFBUcEVlZVJBSi9GWVJLOFc1c0dMVHBSS3pLeEZDeVk4QUlO?=
 =?utf-8?B?V0orSENtSTFla0kySFZXeGhQWlZEd0YzeWlFVDVwRHZrV3Z6dzBjeFQrR01V?=
 =?utf-8?B?MWtwUjRqb3U1RmtvSVNXVjRHNndjODJ0dTdKUFQvWjd1Ynl4aHlBRnJPWHNs?=
 =?utf-8?B?VURzQm05RFRqR3VmdWp4WWRzMEhvR0FLWVJ6L0Q1Mi9aOG1CYiswOG1zZm1O?=
 =?utf-8?B?ckl6Z1VTNi9ESlA4K2RuU2pBTmdGeCsvR2tYNVArVXF6OTV6cEVtMVVPck1r?=
 =?utf-8?B?RUNFOEl4ak1jRHpKejVRblVBQTNoRlUzTm1ReWZodXpmQ0FnMmd3eGpsRjFQ?=
 =?utf-8?B?NkNIREd1ZHh2cUJLY2JWTTJTUG9TQlhlVFBQendZZVN0SFpqOWVTTm5namFy?=
 =?utf-8?B?L1JLOGtBYWVCbGtLVllMSG9jMVNUZU90Y0FteERxMkkremFMSS9pTjBRbEF3?=
 =?utf-8?B?blR3TFNLMEhTTm9MaG5xWU54LzY2WDZ6OGpabmlQdzc1dHRZTU5VbWNoaFVD?=
 =?utf-8?B?YVJVRldVeVNDMEwzb0JIVnFhbEo0Z2RJR29zdmNpTG9oakhxdkhCMzVlOUNr?=
 =?utf-8?B?UktsMVhYNXdWTWJVY01vWEpqTWM2SzE2NlFBL0VPS1htSFZWR2doU2V2ZXZQ?=
 =?utf-8?B?YlhXdm50aDNBeXRTMWpubkE1UzVUckF6OXZSdThXQ3VXVnpsbHpkNEV2TDIw?=
 =?utf-8?B?UEhaMjNiZlJ6aENyZkEwZjRQb0FyeFVINGlNcEFKWjQ3aGFrTW9FMTdXbytn?=
 =?utf-8?B?cDRlRWZWV0xNTStKdnduYW9BMHZFTkVUd2JkeElpUWllTXZsOHMvYUplclRC?=
 =?utf-8?B?UUVIV21ORS9FNVJwS1NoM3BEY3ZTTVlwSnBOZkFTbmZqRDEzdUJ1SWg4T05u?=
 =?utf-8?B?cEFheGg2MTdET3Y4YlMrN0FkaGljY3RjZnluVlhsVzdUNHVycmd4aC95Um5l?=
 =?utf-8?B?Zm5mU3BpUVBTTUN4S0JkYjBwdU5OR1pGUTlOejhTNW5oYUxrdzdrYkFmUlZy?=
 =?utf-8?B?RFpYaHczUlZNVTJGeitZYXg2WjZKUkNlU3RjZ25YRkpsOVdhSGNucGI0WW4w?=
 =?utf-8?B?NDBhL1JkczJKcXJRdndhTnFYOVg4S2t0SnVzeS80VDJuZ1VrNy9YMjdxeC9i?=
 =?utf-8?B?V2dNRjk3TGF2YWRXRGZOQXU5M2pOWVZ2V3FQYjRLZnlkTmYyM2UvUWFteWdy?=
 =?utf-8?B?RWxwcWRuRHBUNGQxWHNEaU5UeGhkYmdlOXJmZlZ5WVh0YVBBRlk2ZlhPMHNa?=
 =?utf-8?B?enlKMVVUcFg3K3VKWkM3OG1Ic1c3NStxaTdkUTNsSHMxUzNHQ0dZVVpSMEpi?=
 =?utf-8?B?OXNMYTlsREEvdFFqYS9GM09sNXF6STdZTVd2clc4R0grTXNvMlRmN09nSFNu?=
 =?utf-8?Q?Nh/2gdvMTgFkjlgojupE1Ig0S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a7e207-0c37-4bf6-8b7c-08ddc9eae8b9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 13:14:52.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+/9aQ9nv/gIAHstEm3EKsStuXH/mPf27x+qduYksdYPom9XOcAXJPnaMjUFxcN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

Hi Reinette,

On 7/22/2025 9:05 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/22/25 5:26 PM, Moger, Babu wrote:
>>
>> There is no redundant text now. . Users can look up about "mbm_event" from "mbm_assign_mode". Here is the complete diff.
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 446736dbd97f..01c33f62ce74 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -434,6 +434,12 @@ When monitoring is enabled all MON groups will also contain:
>>          for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>          where "YY" is the node number.
>>
>> +       When the 'mbm_event' counter assignment mode is enabled, reading
>> +       an MBM event of a MON group returns 'Unassigned' if no hardware
>> +       counter is assigned to it. For CTRL_MON groups, 'Unassigned' is
>> +       returned if none of the events in the CTRL_MON group or its
>> +       associated MON groups have assigned counters.
> 
> The "none of the events" could be interpreted wrongly with only one MBM event
> being read. How about the last sentence as:
> 	For CTRL_MON groups, 'Unassigned' is returned if the MBM event does not
> 	have an assigned counter in the CTRL_MON group nor in any of its associated
> 	MON groups.
> 

Yes. Looks good.
Thanks
Babu

