Return-Path: <linux-kernel+bounces-848586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE82BCE192
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7BCD35657E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DD21D599;
	Fri, 10 Oct 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="adwwQ7vG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="adwwQ7vG"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3B4A02
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117788; cv=fail; b=kDhovMRrXQuL4cwCLgFk/bFSANXNqN58LTq9A+Bw/iinMSq92ngsdvV0ciuB4f9+qV78Wh7inLlK6WgbBaPCkYxkU7mvXcxnwTsIYMqlzWsKbCtwZKTyGmMKlx8sWpHpdwbYcoLQyZBd/56qVRaAUTZ2y5IcQlDeMf1PM8/S5P8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117788; c=relaxed/simple;
	bh=Sz5PZrvnQ10WlaxJum2zDiTyFak+390hJAGY9yMYmy8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ozDxBsyMRSClp9hghxEXpJyegXhnQvhGnLL1UqDIMhdsD7/lYCvFpCLzsQeLCYdesIAJT8grtOADGxNVaWBliv3jrFXgTqic6vL1RLySQVjnKMqNRMKao3fZ/J+Cwjp0OTKRfduePl7EIOLcqc7zRBuQDZhC7Gk1aG60R/mVivw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=adwwQ7vG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=adwwQ7vG; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=knwPF9ya0wNx+rmV1s2cOD89WqgUvxlGUGFoAldvOV1ssj4/iCxfsrg0btt/4vaq9r7vlez/a53vDpbFC0T8tD+Wg97MIAxpMZqUAp1AE62WvRS0n5zLFhf1pCRYQBuGV5cRYBbf/8JwneLu8JEIVwldfDDfKiV8tMmzw6xuBO38FIdcXXDGtvjOuU+cCVgQDOpnuXYHVJckLIA75vCPmmxWxzhTONBrlH6jqsrka6utdED82X40+mNlkO9wTsgMGXqPY2yFCclCyA1sqj9BTw9NVZCab7e09/20+i7r1gqi2IShCkLF3DVV4GjmKSJGrkncWfjO2oHfYqZr4YIyNw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+m6JkgGA/zTX0bFDkom3A84zRQCcS73FrMArZnYHjI=;
 b=kaH9SsQdnsR9kCDTEi8OQP+dVB1pBe74CKQMlSi/7LuIPc4b1+bo1dTsCc5nfQv22HgOVDjM5uq4mEJcyr+acjOCEx/DsgslsPyAzjty7IHJRrZ2YW5KrQyaIu8v9Z5AvuZoTuDttUxNRUPXNFK3BE7qvrPJRelAqGwVfV9to/WoEgkgu4o2SaJhMLhny9/PlunmIRsLScj261wcRUWYeac9K29crcFq/tcUKaSqntLn3g0BvxMBfoMQbvBBGrxTnpw2En7vyceflSic49tDEYvCf/FCCkAjCV4OErwXFip9hWSlC+CNzmO1MRjEn4UE+6fHVHm0Jv33VFAuPW8Csw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+m6JkgGA/zTX0bFDkom3A84zRQCcS73FrMArZnYHjI=;
 b=adwwQ7vGI/Pu6x9gMMdGTSoO9H4Lp+1D8uUj1Ulfq8X3Qpw0wfEmy4dfs3VN+dB9V7tpSkSmrXY80a9GM+LL1f/POaFvD3vsfHZGKcF7E1YvXO3dIjlL7CKlE1cQqCa26GAFqwOEv6oJj+OpLJnbAqwMpk6tJ37a85I+f1xuPTg=
Received: from AM6PR01CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::39) by AM8PR08MB5602.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 17:36:21 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:e0:cafe::94) by AM6PR01CA0062.outlook.office365.com
 (2603:10a6:20b:e0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 17:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Fri, 10 Oct 2025 17:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUxs2FsQKm+6ECY3j+zNZs7ykznkZJiAebmVrdnWkYgQfsoJVpWDuQOJSzwEPOO4WBxFzCkISoyXekGeLroDHbGXEGjCukhIDmT3H1cjB7G6CDAd0D46ETg0muQg5ZtFjb2OJAXHp+KT7NjWCooJyQYhjBU33ciXJw5Xj74NRhifM4FjPqHkQHu7lfITK74RUn2a6XVoCKNSmW2HpGoulRy4A5syxcxpvP7lbqouUclH0WgZSbvqY/2o8f+5d1YjkSla/gwFtxIiLjJugDxll0BF/S/NjERTZoIo0fECFRPaSO4VrIHAcL4tG02GkSZrqYoBZiQ5MYSgOY/r7/2T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+m6JkgGA/zTX0bFDkom3A84zRQCcS73FrMArZnYHjI=;
 b=UWsSnt3bnOODZFZf3ASnVPizmdA32P09os9kSsfTWp+b6aw84ltkxEz7ioUGRUG1LSLFJZfFfn4AmhMyeM2aUI8sU080frE+77dzmHKHliBw10L4S4uRpoavyn2oGAzymriyHXxTSmOSrzie3y12ZT/gWcGzlUaKWX2Rz6uE5DAVyYVoItxJG81KEU7MV0sY/PyKbgmlQAirFG1ZVQM/szTC7FbKXuLvAnhTuw9+xlbwT5AReEQ2ANdK9dua8dAGE785v4Tgb/34MnCXhdNvvznn0RG3Vq8gf1sWLcrkGEuyrhM4wRdsEpGJqp+fQQ674bKczLrxJtDkCHRIWk/r7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+m6JkgGA/zTX0bFDkom3A84zRQCcS73FrMArZnYHjI=;
 b=adwwQ7vGI/Pu6x9gMMdGTSoO9H4Lp+1D8uUj1Ulfq8X3Qpw0wfEmy4dfs3VN+dB9V7tpSkSmrXY80a9GM+LL1f/POaFvD3vsfHZGKcF7E1YvXO3dIjlL7CKlE1cQqCa26GAFqwOEv6oJj+OpLJnbAqwMpk6tJ37a85I+f1xuPTg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB8636.eurprd08.prod.outlook.com (2603:10a6:20b:562::7)
 by VI0PR08MB10537.eurprd08.prod.outlook.com (2603:10a6:800:204::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 17:35:44 +0000
Received: from AS8PR08MB8636.eurprd08.prod.outlook.com
 ([fe80::1094:5f13:4566:e0d5]) by AS8PR08MB8636.eurprd08.prod.outlook.com
 ([fe80::1094:5f13:4566:e0d5%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 17:35:44 +0000
Message-ID: <12598032-3f12-42db-8fc9-6ef879d9a3ba@arm.com>
Date: Fri, 10 Oct 2025 18:35:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] firmware: smccc: LFA: refactor, add device node
 support
To: Vedashree Vidwans <vvidwans@nvidia.com>, lpieralisi@kernel.org,
 mark.rutland@arm.com, sudeep.holla@arm.com, andre.przywara@arm.com
Cc: ardb@kernel.org, chao.gao@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, sdonthineni@nvidia.com, vsethi@nvidia.com,
 vwadekar@nvidia.com
References: <20251008190907.181412-1-vvidwans@nvidia.com>
 <20251008190907.181412-3-vvidwans@nvidia.com>
Content-Language: en-US
From: Salman Nabi <salman.nabi@arm.com>
In-Reply-To: <20251008190907.181412-3-vvidwans@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To AS8PR08MB8636.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB8636:EE_|VI0PR08MB10537:EE_|AMS0EPF000001A2:EE_|AM8PR08MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 736b66b1-1614-4da9-3b6e-08de082385d6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|10070799003|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UWw0Yyt1Q28zMmlWSnA5SUhrTWVzVy9VRklRUWF0cjd4MzhBNU55WGUvR3Av?=
 =?utf-8?B?VlVxWXRNN1ZldjlFWUpQRDNIbHJEalM2ZTJiVVN4OW5UakRFV2w1ak9OVzB0?=
 =?utf-8?B?UHRQUUdQbU1uNERMUDF5YS8rbVZGaEhlYlVNZDlHM0c5MndkRE9MenFHNkZT?=
 =?utf-8?B?ajlQQzhBZEVmU0xSMWE3L2pvYkpuNGNzaXZseDB5NVVJRiszLzAzeGtrY3lr?=
 =?utf-8?B?bUlvMW9veFV4RDk2VEN5akZ3eHpmVFNlSEcvQ1pDWUtUU2w0bUJtOXFoQUxE?=
 =?utf-8?B?UTIvazV0ZW93NnBjbEQxWCtyQy8zcXlPdnp4NXVvRW03VFFwd0ZXcEhKNWh3?=
 =?utf-8?B?WFZWbUpmMFJtVm4yZ1QxclBNVVQwNitwdEJRdW5hSDJ2S2Fob0VoMmlLOGpB?=
 =?utf-8?B?czk5K1lZaW52UXVGdlpxYXFtSDVXUHBRMUVlcFB1aFBMSEZMUzJ5Qmxjckwr?=
 =?utf-8?B?N2xYZTI4Rm5PRGNjNnNsdkU5ODRJWW1iNTZxN3llV1NkZHF2SWI1ak9yc1RN?=
 =?utf-8?B?SUJQQTFzR0d1N2hrZUdHSDNsSGZBTUFjSWIrV1B6SEVTTWw5eE5EOHljcnJp?=
 =?utf-8?B?eTU5L1F2N1kzZmdlSE53RFdyQ1ZaZk83bWNGWTE2di91Z0hVU0FiZ0FoQTRR?=
 =?utf-8?B?Mit0cVB4bTZCWVZCNWtmUWxSdzB4ZjNnZ1ZOSmt3L2R1N01NbHhEOTJtL2ZB?=
 =?utf-8?B?VkFRdTlzY2xtdUxPeU5iaytkSnNZdTNoUExEcjhrVjRzVVJIUmh1akN3R1VG?=
 =?utf-8?B?c2F6RTRoVjhSUE1zSGFLNlBuK29sSXd0T3F0bGthNWJBWVJTVUV3SUI1QlJX?=
 =?utf-8?B?eG1zdERLZDdldkRYZ2FuTWhDMHh2c21jc1dBYTBIKzBCZ2pnaWhJUnF1QVhZ?=
 =?utf-8?B?dFdhNTZMSnp6RGVZSnBjcVI3RXlKWTFneklkbjQ3d3dtZmJHRzh3b084K2s0?=
 =?utf-8?B?UVBGNG1XTzAxdmdjNGtKcHo3aDZiNGtWMWpvRjU1NUJqL2crcEo4dzlqNEdv?=
 =?utf-8?B?aHFqKytSdTdVVHVQKzQ3emIwSE9nRExqUXpldUduOTFpTE85ejU5bldDY3ZC?=
 =?utf-8?B?YnF1TXNacE14SG82WHlGZXdvdGN3TjN6ZU50dEF2NnhhdkZUWFVwczlPcEVa?=
 =?utf-8?B?cjZFZXkwYVhiSHNTZGlWSHg5RG5SZ3FYa1lTQ1ZRU1RyajlOWWszV0RZVG0x?=
 =?utf-8?B?Y3VkZUFvR2drRGE1MVRPVmhmaXlrdHI4U0pDbFBKR1JwRWRObEFaOE02blI1?=
 =?utf-8?B?UkFPSk9lanBHaWhMTVdnbHd1RG5sK0lNM3pGcU1kZzdhbEZJQ0JRTDZjL01V?=
 =?utf-8?B?SW42cXpmU0dHdnpNbGlubnJuZ05UVkQ5OVo3Vk5PMWRiaDVBcjErc2h3RExY?=
 =?utf-8?B?akZEa3J1Q1hUUTk0NTVNbGxuc1diZkJ0a3lockNoNUV4VlZFY0Fqblg0Y3hq?=
 =?utf-8?B?akdRWG12OUM5WVpNc2tVYmEvTk15Y1B1ak1SZlM3ZDhIc091K0pRNmNaY2dG?=
 =?utf-8?B?SzJtdVc3bFdQVnhpMUEwUzJSd0ladE0zd0FOVDJZYU01RTFQQ3dUL3p3cUVy?=
 =?utf-8?B?cXZOWlN3eHgzRmF1RjRNM2diU01TUitVY0FaaDF4Sm1OMExnM1BiY1l2WWdZ?=
 =?utf-8?B?b1ZFS0tLd1RBSitnSTBqbC9CL3dYUC93cXVJL0kvMmp3STFYR1dKb2JHYlRU?=
 =?utf-8?B?OHVPalo5ZkpNTXpra1RrQkM2MFRqeUR0QS9Pb091Uk5pQkhpTmlZcnlBUko5?=
 =?utf-8?B?T2RhbnQrbEh2dFRkdlBZWENWeVpQeXBHT2ZNdXZHdml3REVTNUFYWk15WE1v?=
 =?utf-8?B?eHFSZm5nM2ZPOHhIZFZWVlIyWER2UkdBQTV1UUpKNlNybjFsM09MTlA0SUFi?=
 =?utf-8?B?RmkzUjZGaHZsZWtRYnZZUm5IZzJibEE1OHdaUHdZVmpuWlNsTlZUT1Q0VEFJ?=
 =?utf-8?Q?L/7KTsO0Mp3gWlD6WfkKKOOm4a+Woe/i?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB8636.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10537
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	df54515b-20bf-4949-dc06-08de082370d7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|35042699022|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckVqTkFaYlB6QWxHcWtDK2NEYzJHKzAxTWU1RzVwdGxQWFVlVjBWaGRZSjVu?=
 =?utf-8?B?bzNPWUIvWmlXUGJqOVZqZTdFY1dSdllZclVLbkNjamtBYTIvQzZkSjgydXJE?=
 =?utf-8?B?ZUhjTEF6N2pIL3ZUazJuYmxWcnlNbnFmYnczOUxuVzZzdjhENmhaeDMxRWFu?=
 =?utf-8?B?bFRTSGx4eXdMa1d4cUlaeFhLcjlKMWlTN1l4T1I1eXAySTFITnU1S3dGK1pP?=
 =?utf-8?B?VFdqNVdKUTJoTjhqV1FPOXRMRVZhZlY1dWlBeDdwUlNhVXNXcmVXb0ZsV1lH?=
 =?utf-8?B?SkRIV2prTWFrdHc2OW5PanhodGJuQ1h5V3p2Q2ZVRWgxWjd4dVp2SDdiT2tp?=
 =?utf-8?B?Smt4aUVJWW5mLytTa3RHcjVGeEdQeGNiZzI3K0Jad3ZrampaTlZiZ2FORmsx?=
 =?utf-8?B?MktpUTRKV0hZSTZlWlREZ1ZoblV5Y215ZXdPRjM5YktjT3FZZnBId3lCQ2Vs?=
 =?utf-8?B?WHJXeGMvdGNHdFViZnRBZEF6elBWWThzb0gwYnhXRy9OaXVXdkNvb1ZCS3dY?=
 =?utf-8?B?NDlMdWxqMHpIS09US0NVbWdtekZZbENOSWcxSkM0aVBjTlpOR2VzdkNGK000?=
 =?utf-8?B?QjAvWmhRaXc4eFo1ZUQrR05aYVhIZ3FCVkdMbXpQT1ozN2RVS3ROZlRyK1lT?=
 =?utf-8?B?K0tZUFlsRDZaZHdIYnMzY2lQZ2hIUG9qUlYrOWFycGcyOU5FdWY0eFZhV0RF?=
 =?utf-8?B?Y0dnT3E3b3doVWFCWTR1ZUJPS3ZzR2lyanZmZlRFTmxCL2toZkZLK3lpbkRV?=
 =?utf-8?B?aDlabmxHdHNoN1dYb3NHS0hMNmoxY1NTNUlWOWN5WW9GeXZJMGVMVE5TM0ww?=
 =?utf-8?B?U1VBTTNkVUt2QXdhb1RMVERXekJHQVIyRHFOUis3cGg0VmtEQ3pZZGtWNUFC?=
 =?utf-8?B?UDR3OXI3aU5CVFZqMEZ5MHRkejdCQmRJUFhoYnUwNzMzaXVFeW1NUldXSEUx?=
 =?utf-8?B?M3o1anlwWG50TWZsU1FNNGMxdkFxZ3QxUURoaVdyd1N3VytKb09pNExObWV3?=
 =?utf-8?B?SlNwL1puTTU0bThuNzQwUVFXMS83T1BoUms1YVdCalpQSmtLeW4reU51WHgx?=
 =?utf-8?B?KzR0aTV3VnpuNDNvVmZHQ3NhWDVnOUNYYWZ4N2J4VFhLYnlBTTVYTjNXYWEy?=
 =?utf-8?B?cTlFSkxReWNWK2RiSS9Ic1RRdVYxcFlKMzA5UHhhOGxJWm5zZ2JhK29pYS9q?=
 =?utf-8?B?d2gxTUNLWWl4YjlwYUJTSUJ6ckVYRW9KbkJJRDh2bmZscDZYclQybDExckJT?=
 =?utf-8?B?alNjT1MveVhxZXFOWTJKWGx1NlkzSkU4aWZ3ZUN0ZjNMUEY0OXhWY2dGY3BO?=
 =?utf-8?B?TFprTmFYZ2Q2NGdoVkl2YnZOL043bmVUWG5md293QmYxWmU5V0NCemNIKy9X?=
 =?utf-8?B?WldDRVBMenh0a2RtUnNqUWh0dElHVDZha3JNcWZIOUIrbS9TM1U0QlFqSzUy?=
 =?utf-8?B?UXRsTXAxeVh5Y1l4aGxKcndrQjBuemY4MjdVSmh2ZUxZcHQ5L1pNKzVUNGJ6?=
 =?utf-8?B?SmZyWGZLUFlkYWlkOW5oc1lJSmtodGw5eUtic0Q3VFhJRnY2VG15QmluWGxh?=
 =?utf-8?B?TG9HMEhKcTduMFRFczVYajVOMHg0OTllTVVHcXZ2UTljRkY2bkxwUnlkTU9P?=
 =?utf-8?B?VkdZSzhBQUMvcUpPSEFVQjFsUHpXNE12TVN4MWsvZ1g2amExdmFCQkJEYmVJ?=
 =?utf-8?B?N1VFdW0vbG5mVGR5Q2dtNTFua1NZT1hKQkFwcE5sWGRQNFVyK3M5RHkraWRy?=
 =?utf-8?B?N0Y0dHNWRldSZ2xkc0FkdzJoc2lIY3BzaEZDZkJGNmkzQ2pzSGdpV3N3NEVu?=
 =?utf-8?B?SURBWnVrRE0wczRTNjhjMEJHY2l0VE9qenRVblUrVkZNOFZlZDlQZE4xdUlR?=
 =?utf-8?B?VVZjT29mZ0ZSZ3IyeThvUDZ2bHRPMldvZUhpWmUyUndmZi9CckZRM3FDSWJW?=
 =?utf-8?B?cThkZUxvOUlmYklmSjNOUnhQY3lyUkZ6Z2w0S21sT3dNajcvd3lrU2NaYzhI?=
 =?utf-8?B?dTk3eHVpbFluK3pSRWo3d1U1V0pnRWJDZWJrNW41VHJuc2FnMWZSdTNkUmg5?=
 =?utf-8?B?TWhkend2elY2eUJpMmx2cTA4eElTMmc3V3VXcXB5OGwvNTErdlRJMUR0bVg0?=
 =?utf-8?Q?T2V4=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(35042699022)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:36:19.4363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736b66b1-1614-4da9-3b6e-08de082385d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5602

Hi Vedashree,

Thank you for sending those pathces over. I just have a few comments.

On 10/8/25 20:09, Vedashree Vidwans wrote:
> - Add support for LFA device node in the kernel driver. Implement
> probe() to register LFA interrupt and threaded interrupt service
> function.
> - CPUs will be rendezvoused during activation.
> - On IRQ, driver will query FW components then triggers activation of
> capable and pending components.
> - Mutex synchronization is implemented to avoid concurrent LFA updates
> through interrupt and sysfs interfaces.
> - Refactor LFA CANCEL logic into independent lfa_cancel() function.
> - Enhance PRIME/ACTIVATION functions to touch watchdog and implement
> timeouts.
> 
> Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
> ---
>  drivers/firmware/smccc/lfa_fw.c | 299 ++++++++++++++++++++++++++++----
>  1 file changed, 262 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
> index 49f7feb6a211b..b36b8d7457c30 100644
> --- a/drivers/firmware/smccc/lfa_fw.c
> +++ b/drivers/firmware/smccc/lfa_fw.c
> @@ -16,7 +16,15 @@
>  #include <linux/uuid.h>
>  #include <linux/array_size.h>
>  #include <linux/list.h>
> -
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
> +#include <linux/nmi.h>
> +#include <linux/ktime.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +
> +#define DRIVER_NAME	"ARM_LFA"
>  #define LFA_ERROR_STRING(name) \
>  	[name] = #name
>  #undef pr_fmt
> @@ -34,6 +42,18 @@
>  #define LFA_1_0_FN_ACTIVATE		LFA_1_0_FN(5)
>  #define LFA_1_0_FN_CANCEL		LFA_1_0_FN(6)
>  
> +/* CALL_AGAIN flags (returned in res.a1[0]) */
> +#define LFA_PRIME_CALL_AGAIN		BIT(0)
> +#define LFA_ACTIVATE_CALL_AGAIN		BIT(0)
> +
> +/* Prime loop limits, TODO: tune after testing */
> +#define LFA_PRIME_BUDGET_US		30000000 /* 30s cap */
> +#define LFA_PRIME_POLL_DELAY_US		10       /* 10us between polls */
> +
> +/* Activation loop limits, TODO: tune after testing */
> +#define LFA_ACTIVATE_BUDGET_US		20000000 /* 20s cap */
> +#define LFA_ACTIVATE_POLL_DELAY_US	10       /* 10us between polls */
> +
>  /* LFA return values */
>  #define LFA_SUCCESS			0
>  #define LFA_NOT_SUPPORTED		1
> @@ -114,8 +134,9 @@ static const struct fw_image_uuid {
>  };
>  
>  static struct kobject *lfa_dir;
> +static DEFINE_MUTEX(lfa_lock);
>  
> -static int get_nr_lfa_components(void)
> +static unsigned long get_nr_lfa_components(void)
>  {
>  	struct arm_smccc_1_2_regs args = { 0 };
>  	struct arm_smccc_1_2_regs res = { 0 };
> @@ -130,11 +151,40 @@ static int get_nr_lfa_components(void)
>  	return res.a1;
>  }
>  
> +static int lfa_cancel(void *data)
> +{
> +	struct image_props *attrs = data;
> +	struct arm_smccc_1_2_regs args = { 0 };
> +	struct arm_smccc_1_2_regs res = { 0 };
> +
> +	args.a0 = LFA_1_0_FN_CANCEL;
> +	args.a1 = attrs->fw_seq_id;
> +	arm_smccc_1_2_invoke(&args, &res);
> +
> +	/*
> +	 * When firmware activation is called with "skip_cpu_rendezvous=1",
> +	 * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
> +	 * cancelled.
> +	 */
> +	if (res.a0 == LFA_SUCCESS) {
> +		pr_info("Activation cancelled for image %s",
> +			attrs->image_name);
> +	} else {
> +		pr_err("Firmware activation could not be cancelled: %ld",
> +		       (long)res.a0);
> +		return -EIO;
> +	}
> +
> +	return res.a0;
> +}
> +
>  static int call_lfa_activate(void *data)
>  {
>  	struct image_props *attrs = data;
>  	struct arm_smccc_1_2_regs args = { 0 };
>  	struct arm_smccc_1_2_regs res = { 0 };
> +	ktime_t end = ktime_add_us(ktime_get(), LFA_ACTIVATE_BUDGET_US);
> +	int ret;
>  
>  	args.a0 = LFA_1_0_FN_ACTIVATE;
>  	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
> @@ -148,9 +198,32 @@ static int call_lfa_activate(void *data)
>  	 */
>  	args.a2 = !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous);
>  
> -	do {
> +	for (;;) {
> +		/* Touch watchdog, ACTIVATE shouldn't take longer than watchdog_thresh */
> +		touch_nmi_watchdog();
>  		arm_smccc_1_2_invoke(&args, &res);
> -	} while (res.a0 == 0 && res.a1 == 1);
> +
> +		if ((long)res.a0 < 0) {
> +			pr_err("ACTIVATE for image %s failed: %s",
> +				attrs->image_name, lfa_error_strings[-res.a0]);
> +			return res.a0;
> +		}
> +		if (!(res.a1 & LFA_ACTIVATE_CALL_AGAIN))
> +			break; /* ACTIVATE successful */
> +
> +		/* SMC returned with call_again flag set */
> +		if (ktime_before(ktime_get(), end)) {
> +			udelay(LFA_ACTIVATE_POLL_DELAY_US);
> +			continue;
> +		}
> +
> +		pr_err("ACTIVATE timed out for image %s", attrs->image_name);
> +		ret = lfa_cancel(attrs);
> +		if (ret == 0)
> +			return -ETIMEDOUT;
> +		else
> +			return ret;
> +	}
>  
>  	return res.a0;
>  }
> @@ -159,8 +232,24 @@ static int activate_fw_image(struct image_props *attrs)
>  {
>  	struct arm_smccc_1_2_regs args = { 0 };
>  	struct arm_smccc_1_2_regs res = { 0 };
> +	ktime_t end = ktime_add_us(ktime_get(), LFA_PRIME_BUDGET_US);
>  	int ret;
>  
> +	if (attrs->may_reset_cpu) {
> +		pr_err("Firmware component requires unsupported CPU reset");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * We want to force CPU rendezvous if either cpu_rendezvous or
> +	 * cpu_rendezvous_forced is set. The flag value is flipped as
> +	 * it is called skip_cpu_rendezvous in the spec.
> +	 */
> +	if (!(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)) {
> +		pr_warn("CPU rendezvous is expected to be selected.");
> +		return -EAGAIN;
> +	}

The purpose of cpu_rendezvous_forced was to allow firmware components, that dont
require cpu rendezvous, bypass kernel's conservative approach of always requiring
cpu_rendezvous. This was per the feedback on the first LFA RFC patch. If we are
happy forcing cpu rendezvou than I don't see the point of cpu_rendezvous_forced
switch.

> +
>  	/*
>  	 * LFA_PRIME/ACTIVATE will return 1 in res.a1 if the firmware
>  	 * priming/activation is still in progress. In that case
> @@ -169,20 +258,36 @@ static int activate_fw_image(struct image_props *attrs)
>  	 */
>  	args.a0 = LFA_1_0_FN_PRIME;
>  	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
> -	do {
> +	for (;;) {
> +		/* Touch watchdog, PRIME shouldn't take longer than watchdog_thresh */
> +		touch_nmi_watchdog();
>  		arm_smccc_1_2_invoke(&args, &res);
> -		if (res.a0 != LFA_SUCCESS) {
> -			pr_err("LFA_PRIME failed: %s\n",
> -				lfa_error_strings[-res.a0]);
>  
> +		if ((long)res.a0 < 0) {
> +			pr_err("LFA_PRIME for image %s failed: %s\n",
> +				attrs->image_name, lfa_error_strings[-res.a0]);
>  			return res.a0;
>  		}
> -	} while (res.a1 == 1);
> +		if (!(res.a1 & LFA_PRIME_CALL_AGAIN))
> +			break; /* PRIME successful */
>  
> -	if (attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)
> -		ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
> -	else
> -		ret = call_lfa_activate(attrs);
> +		/* SMC returned with call_again flag set */
> +		if (ktime_before(ktime_get(), end)) {
> +			udelay(LFA_PRIME_POLL_DELAY_US);
> +			continue;
> +		}
> +
> +		pr_err("PRIME timed out for image %s", attrs->image_name);
> +		ret = lfa_cancel(attrs);
> +		if (ret == 0)
> +			return -ETIMEDOUT;
> +		else
> +			return ret;
> +	}
> +
> +	ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
> +	if (ret != 0)
> +		return lfa_cancel(attrs);
>  
>  	return ret;
>  }
> @@ -286,23 +391,23 @@ static ssize_t activate_store(struct kobject *kobj, struct kobj_attribute *attr,
>  					 image_attrs[LFA_ATTR_ACTIVATE]);
>  	int ret;
>  
> -	if (attrs->may_reset_cpu) {
> -		pr_err("Firmware component requires unsupported CPU reset\n");
> -
> -		return -EINVAL;
> +	if (!mutex_trylock(&lfa_lock)) {
> +		pr_err("Mutex locked, try again");
> +		return -EAGAIN;
>  	}
>  
>  	ret = activate_fw_image(attrs);
>  	if (ret) {
>  		pr_err("Firmware activation failed: %s\n",
>  			lfa_error_strings[-ret]);
> -
> +		mutex_unlock(&lfa_lock);
>  		return -ECANCELED;
>  	}
>  
>  	pr_info("Firmware activation succeeded\n");
>  
>  	/* TODO: refresh image flags here*/
> +	mutex_unlock(&lfa_lock);
>  	return count;
>  }
>  
> @@ -311,26 +416,11 @@ static ssize_t cancel_store(struct kobject *kobj, struct kobj_attribute *attr,
>  {
>  	struct image_props *attrs = container_of(attr, struct image_props,
>  						 image_attrs[LFA_ATTR_CANCEL]);
> -	struct arm_smccc_1_2_regs args = { 0 };
> -	struct arm_smccc_1_2_regs res = { 0 };
> -
> -	args.a0 = LFA_1_0_FN_CANCEL;
> -	args.a1 = attrs->fw_seq_id;
> -	arm_smccc_1_2_invoke(&args, &res);
> +	int ret;
>  
> -	/*
> -	 * When firmware activation is called with "skip_cpu_rendezvous=1",
> -	 * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
> -	 * cancelled.
> -	 */
> -	if (res.a0 == LFA_SUCCESS) {
> -		pr_info("Activation cancelled for image %s\n",
> -			attrs->image_name);
> -	} else {
> -		pr_err("Firmware activation could not be cancelled: %s\n",
> -		       lfa_error_strings[-res.a0]);
> -		return -EINVAL;
> -	}
> +	ret = lfa_cancel(attrs);
> +	if (ret != 0)
> +		return ret;
>  
>  	return count;
>  }
> @@ -418,6 +508,11 @@ static int create_fw_images_tree(void)
>  	int ret, num_of_components;
>  
>  	num_of_components = get_nr_lfa_components();
> +	if (num_of_components <= 0) {
> +		pr_err("Error getting number of LFA components");
> +		return -ENODEV;
> +	}
> +
>  	args.a0 = LFA_1_0_FN_GET_INVENTORY;
>  	for (int i = 0; i < num_of_components; i++) {
>  		args.a1 = i; /* fw_seq_id under consideration */
> @@ -437,6 +532,125 @@ static int create_fw_images_tree(void)
>  	return 0;
>  }
>  
> +static int refresh_fw_images_tree(void)
> +{
> +	int ret;
> +	/*
> +	 * Ideally, this function should invoke the GET_INVENTORY SMC
> +	 * for each firmware image and update the corresponding details
> +	 * in the firmware image tree node.
> +	 * There are several edge cases to consider:
> +	 *    - The number of firmware components may change.
> +	 *    - The mapping between firmware sequence IDs and
> +	 *      firmware image UUIDs may be modified.
> +	 * As a result, it is possible that the firmware image tree nodes
> +	 * will require updates. Additionally, GET_INVENTORY SMC provides
> +	 * all current and revised information. Therefore, retaining the
> +	 * existing fw_images_tree data is not justified. Reconstructing
> +	 * the firmware images tree will simplify the code and keep data
> +	 * up-to-date.
> +	 */
> +	// Clean current inventory details
> +	clean_fw_images_tree();

This isn't an optimal approach to updating the firmware components. Removing a
directory that a user is currently looking at will still linger around as its
ref count won't get 0. Also, an attribute read/write operation during an
activation for example, reading the activation pending flag will result in
the mutex lock waiting to acquire the lock which will keep the attribute file
around. Trying to remove said object may result in unpredictable behaviour.
We have a WIP patch that is supposed to refresh the data i.e. firmware images
attributes and seq_ids, instead of deleting the objects and re-creating them.
Only firmware images that are removed from the LFA agent following an
activation would be removed.

> +
> +	// Update new inventory details
> +	ret = create_fw_images_tree();
> +	if (ret != 0)
> +		kobject_put(lfa_dir);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t lfa_irq_thread(int irq, void *data)
> +{
> +	struct image_props *attrs = NULL;
> +	int ret;
> +
> +	mutex_lock(&lfa_lock);

mutex_lock() can sleep and is unsafe in an interrupt context, mutex_trylock()
doesn't sleep but is still considered illegal in an interrupt context as
mutex_unlock() can still sleep.

> +
> +	// Update new inventory details
> +	ret = refresh_fw_images_tree();

According to the LFA specification IIRC the firmware images and their seq_ids
may change following an activation, not after an update that is pending an
activation. Thus the refresh should happen soon after an activation only.

Kind Regards
Salman

> +	if (ret != 0)
> +		goto exit_unlock;
> +
> +	/*
> +	 * Execute PRIME and ACTIVATE for each FW component
> +	 * Start from first FW component
> +	 */
> +	list_for_each_entry(attrs, &lfa_fw_images, image_node) {
> +		if ((!attrs->activation_capable) || (!attrs->activation_pending)) {
> +			/* LFA not applicable for this FW component, continue to next component */
> +			continue;
> +		}
> +
> +		ret = activate_fw_image(attrs);
> +		if (ret) {
> +			pr_err("Firmware %s activation failed: %s\n",
> +				attrs->image_name, lfa_error_strings[-ret]);
> +			goto exit_unlock;
> +		}
> +
> +		pr_info("Firmware %s activation succeeded", attrs->image_name);
> +	}
> +
> +	// Update new inventory details
> +	ret = refresh_fw_images_tree();
> +	if (ret != 0)
> +		goto exit_unlock;
> +
> +exit_unlock:
> +	mutex_unlock(&lfa_lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init lfa_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	unsigned int irq;
> +
> +	err = platform_get_irq_byname_optional(pdev, "fw-store-updated-interrupt");
> +	if (err < 0)
> +		err = platform_get_irq(pdev, 0);
> +	if (err < 0) {
> +		pr_err("Interrupt not found, functionality will be unavailable.");
> +
> +		/* Bail out without failing the driver. */
> +		return 0;
> +	}
> +	irq = err;
> +
> +	err = request_threaded_irq(irq, NULL, lfa_irq_thread, IRQF_ONESHOT, DRIVER_NAME, NULL);
> +	if (err != 0) {
> +		pr_err("Interrupt setup failed, functionality will be unavailable.");
> +
> +		/* Bail out without failing the driver. */
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id lfa_of_ids[] = {
> +	{ .compatible = "arm,armhf000", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lfa_of_ids);
> +
> +static const struct acpi_device_id lfa_acpi_ids[] = {
> +	{"ARMHF000"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, lfa_acpi_ids);
> +
> +static struct platform_driver lfa_driver = {
> +	.probe = lfa_probe,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = lfa_of_ids,
> +		.acpi_match_table = ACPI_PTR(lfa_acpi_ids),
> +	},
> +};
> +
>  static int __init lfa_init(void)
>  {
>  	struct arm_smccc_1_2_regs args = { 0 };
> @@ -464,22 +678,33 @@ static int __init lfa_init(void)
>  	pr_info("Arm Live Firmware Activation (LFA): detected v%ld.%ld\n",
>  		res.a0 >> 16, res.a0 & 0xffff);
>  
> +	err = platform_driver_register(&lfa_driver);
> +	if (err < 0)
> +		pr_err("Platform driver register failed");
> +
> +
>  	lfa_dir = kobject_create_and_add("lfa", firmware_kobj);
>  	if (!lfa_dir)
>  		return -ENOMEM;
>  
> +	mutex_lock(&lfa_lock);
>  	err = create_fw_images_tree();
>  	if (err != 0)
>  		kobject_put(lfa_dir);
>  
> +	mutex_unlock(&lfa_lock);
>  	return err;
>  }
>  module_init(lfa_init);
>  
>  static void __exit lfa_exit(void)
>  {
> +	mutex_lock(&lfa_lock);
>  	clean_fw_images_tree();
> +	mutex_unlock(&lfa_lock);
> +
>  	kobject_put(lfa_dir);
> +	platform_driver_unregister(&lfa_driver);
>  }
>  module_exit(lfa_exit);
>  

