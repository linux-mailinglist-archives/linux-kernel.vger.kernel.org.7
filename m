Return-Path: <linux-kernel+bounces-807064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACFCB49F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975A43A8D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC70E2571BE;
	Tue,  9 Sep 2025 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Fvmu06ld"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2109.outbound.protection.outlook.com [40.107.100.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A642566D3;
	Tue,  9 Sep 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386405; cv=fail; b=g0H0UDRYY4zfKv4I8vxOZJ7r9KwRoxLqLQwcavBJXFRkSp2TDsYcXy4lE5oklaTHbSnsxGRCra1pla5ZxwtOZmnVIBBmuq1Wkpk7QFSSWFSAo8gegENOL8VlwBCbxY9qnAO9qzTq7nYKrqfTZNJw+QjAIn1vLJarv55frw3vc+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386405; c=relaxed/simple;
	bh=dRfkWa2hRNvm3QHgPvrrLcw9MUxC1+xWuWN2TNDCy/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6ridzHSJYp7l4WG8z09DuYqWrv956haqU9d+I2Q3zz67EiS/3r+rGk00aq2NCnuVk1B5qllzKX+RT5W8s1wjeC/DGvt8O/rheST/3YA0lhCoODaODPHUZzvLyP9fNAtxpDnuLolurRnBg1gdJx4/Y7ubZuTAho1hb49X4TJZIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Fvmu06ld reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.100.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1icrNynNPKqrFp4ezhwyF0y4UxoxxwVXFoM75XpkOVx1iVdn36kSvpfZ3m7gUsVRlqtNFTqiBbmjItPhuTzPM4hzh6ifHT2K3P4bZTAuzx0rdfX3XnNgdGFdKUulTPLRwo0bnUGhoRjTLE57ONMYx6doTH/fgbOy+goU0gPwF5vUhh9RJS4yASxEQdyrNvnfv2ZmJO2ltmQfzP+4IA7nMYJUXz5eA048kbeEQXOoTXPBOTw0tfvKQXjR95T/x6uAnASavoGbudiBxMnWH2CiG/iJF8mOZ+VQjK+wny9XyaJghUe9N7EvTlRRbl0e9viu6hWvA0Kv3kCfAMNte80dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4xmZIjNAqie+eTHDP12RJ+GAyDU7eRFwxrdAqhmezo=;
 b=FSW0gscVR4D9LzzfRwlurrz0kEc3FtWHSNIY4mQ4H6eeK4qoAT/woF/+AVRaN8/Uvj5sxoZ6weU4rfPUMK0lVBHnJnXnNMkKpFPvPJOv0a9arMHqtvO4Sp0rvjSPG5dX6Njp4S8Wm1h8Uct1EXzyw3O1WDTR563phJcDGbTCONCuLGtewESgQtk9SXHcpcFI0MJgA3G7ngXBsH9ca3NoVTZiDtz0KBJBIivEvCGcHrfTzA4yBGAsNf+G6ljK886iqHPuDVU2RF8zH3rhS99AfqgaiDMijO/rVduyvobiqHBpf5dYF5zF26Z7cXdP2g02etqcVxZ/YVOkPnmq023Nog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4xmZIjNAqie+eTHDP12RJ+GAyDU7eRFwxrdAqhmezo=;
 b=Fvmu06ld0nBfAtFZb16OR1l/YHFXFLA4h9eAmq5sbfaLGqPI09vOUmhIxBjI2suZLok3pd6ANhznKh9wnd1il3KswfI5JjzzwKgpS6X2p8mZCZ2Fnu1QraFk7FGlnrDj6MIdnPy+0z7lhZLOu2Hof4jE8/JfDFqXtggoZNnM3c0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CH0PR01MB6969.prod.exchangelabs.com (2603:10b6:610:106::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 02:53:19 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 02:53:18 +0000
Message-ID: <3e71ddb9-f457-461e-a949-13e07a4a8b08@amperemail.onmicrosoft.com>
Date: Tue, 9 Sep 2025 10:52:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/2] arm64: refactor the rodata=xxx
To: Will Deacon <will@kernel.org>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, corbet@lwn.net, patches@amperecomputing.com,
 cl@linux.com, yang@os.amperecomputing.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 bp@alien8.de, ardb@kernel.org, anshuman.khandual@arm.com,
 suzuki.poulose@arm.com, gshan@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rdunlap@infradead.org, Christoph Lameter <cl@gentwo.org>
References: <20250703094212.20294-1-shijie@os.amperecomputing.com>
 <20250703094212.20294-2-shijie@os.amperecomputing.com>
 <aL6_gZWeqAGZjda2@willie-the-truck>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <aL6_gZWeqAGZjda2@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CH0PR01MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: dded108b-7bad-4bc3-7d24-08ddef4c0792
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2N3QlgxV0FqVXdjWDdUZnBNa1pJN0xmYi9CbmJjNSt3WnJtdmhxYndWV3d3?=
 =?utf-8?B?WGNtSmpoNHRtN2hidVVYT0Q4SEVFUW4rRXpRM1BUZ0pjcmxpeG5MM0JSNEI4?=
 =?utf-8?B?QlRvdDFsZkdvdUhxdmZReisyTlNLSnVGek90NTBXYTlDRnUraEdaUkZ0WDNR?=
 =?utf-8?B?TTU4WXE4cHJzYUpQMFhRNDRvTW5yS283cnREUVRWQ3VqQTBhdzNVUHI3RVdL?=
 =?utf-8?B?QURRS1lWVWdOQWFTaXBQb283QXJQdEJmOFIxZWNoRmYxUGJNb0xwbmZTOC9o?=
 =?utf-8?B?VDRGcmp6c1NZbDFMVXUrUVhJTmVDY29tTlUxSzF6Zi9qMUtnQklWUXBKSmxi?=
 =?utf-8?B?REF1aFZwTjd3Mm44WVNjVlg0S0U0OUsvNTh1Z0krUzJua0wyRFhiNHJDalFi?=
 =?utf-8?B?SUg1elhvQnlPb0h0WVRSK1M4NnlJUlh2UCtoQTNtSWV1Uk5KNER6VldkRDBo?=
 =?utf-8?B?aEJWZStXQ3pKWFRja3dOQVc4Ym93OHVSR3lTN0lKRjcvWXhOUVVvVHZkR05a?=
 =?utf-8?B?N2tpclIrdXlaR1RCZGxiVmVkbDZOa0tVOEV4cjcwRTFPekpoU2hrQW8rTFFT?=
 =?utf-8?B?WVhtdCtNZFFla2xPZll2SE9xeUpCb3EvNnN6UmpRVktCV1dPRmFRVE1hcTlB?=
 =?utf-8?B?dDhBaU54cVdXL1dnYzJ3bm1sZ0pjbHRVSCtlYUUvWWJNUGxLWVBXRTZGVk54?=
 =?utf-8?B?ODFFMkRPNEJiNGhjRmM2KzMxaDJJUWk1VzgrYm9Gd3BUMllSV0I5U3c0bVIr?=
 =?utf-8?B?L2VZQTh4RCtPY0RyZ1BvUko3akhJeU1pQitOUGJlbkRPR3FRaGxMZDZrTC9j?=
 =?utf-8?B?Uk1LRTNtY0NDL09aQ252N0VQRUVYckZnUUxBMDlBTVJSOFRJRjd1VnIzTEFu?=
 =?utf-8?B?L1MxNUJvYjdBOS9SaVJqWmZMUERuQ2kzbUNaM2xGRStrSUtoZzZQU08xVWJ5?=
 =?utf-8?B?UXdlbkY3NHF1S3l5dlhTR1VUY1FCUUx4RUhWdmZoTXJWNVRiN0NzTlIzUzg1?=
 =?utf-8?B?WGF2MWlERStWWFVyL0FkVzRQdnpPdDhLdXNhbXQ2Q1h5bTdZbjlVSnBjeDF4?=
 =?utf-8?B?d2JCQk05NWNlcHlycG5iMTlESkx3WmM0eWpTYW1LN2NvQlFLeXNOOFhlV2tH?=
 =?utf-8?B?ZlpjZFkzcWMxRVZlWUg1YlJSMFdTWnlZL3o5RW8xakx6dDh2Ym04WS96Q1pF?=
 =?utf-8?B?Q0dKT3Q4VDdaWUhEZkYvclQ3Q3ZMbmx0cmEyY1RuY2xJV0ZmRXpxVTZyL3ZS?=
 =?utf-8?B?aUVCSkNpMEYzZ1UrSG5xSFNkOTdlNStHbDlidjM0aXBwditWZWlZUDVSNm8w?=
 =?utf-8?B?SEttek9YWERvSHV0WERNTUxNYzVVWkxYajNPSlRBSUZCZ2o4cmZ5akJ5MjBX?=
 =?utf-8?B?RHZ6eEtWdVpJeTdOU2dwSUVvUGFFS3pmZDZnaWV0UnF2TzFRckZoS3oxLzJj?=
 =?utf-8?B?aFgzVGhxSVVNaVo5S1E1Y3poTzNvc1Z6WUs2bWVjVlBub2djUjAzbTBTK1ND?=
 =?utf-8?B?eWdIOUkxMHkyUXZFcUZBeXUyTk9hV3YrVEJ2clIyU3J3K1ZyMm94ak9HT2Ew?=
 =?utf-8?B?eXBjaThNZmdrYktnc2RaN0MwQUNsdGhUMnNwQ3UxYmdtWWlLcyttRW0wSksx?=
 =?utf-8?B?aGs0a1F0MlFMNk4yeHNwWDNJYmwwT2lYRlhhdEhXZE5ncmhUMEJ4a1U4SFA3?=
 =?utf-8?B?ZkVtSUJHQ3BETXl2OTliVDQzMmk5V2Rmb3phejRmcjFJMWFwK3VUeEdScVhF?=
 =?utf-8?B?aVFscDlYZTU0Y3UraUNZWWJQcGZyZEpvRHBXbC9abkxtSXorWmNtYVhNdC96?=
 =?utf-8?B?aFMvS3F3MW5WOG16NTdhZjZDbWY4OVFZMnFKeDRuZUJ1M0c3WFB4alZad0Z1?=
 =?utf-8?B?QmNmYld3bTJIUDczeENNbWlzV2pOUU1zMHRvdUZuZ0VSWlZIQ2czTWpNeFZI?=
 =?utf-8?Q?5HnYRMedHEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXdrREp1TStjaEtHYjNwQjRUbjdTQ0FkWFMzcjJKMnhtcDFwUzBHZkE1V3Az?=
 =?utf-8?B?TnlCWGF5TG9mWWxtNnhPNko0S296clZTVTNyMkdVcVg2M0lHbVhwM0tFUXF0?=
 =?utf-8?B?WHBkakJKNjFwNEwxNk9wbzFacTdYd0tZSWs2ck5pbEVKWjdaWHlzNHhTMmh1?=
 =?utf-8?B?RkJpWFBYTitMSjhaREFaZlc5VDhYZk92L3FNWWx6VFhJelA0dEtibU9CL2U5?=
 =?utf-8?B?YTgxem9iZ21sakU5bjVYUUQzb1N2OXVSQUFUYitoaXBJRHNHTzlJdzJ2emZw?=
 =?utf-8?B?UTFFMUc0djZkWTYzbFdMSUpCeTF1SURKN05XcnFNWjkxb1lZZ3hqbjlXby9T?=
 =?utf-8?B?RVJIMkZGMkwwK1BmeHVpcmpndmUvNUtGNjg1L0NzNnRQYmNJaDlxOU9UN0pG?=
 =?utf-8?B?ekZ4bGplcjlqZGF1ZDh5dmNNK3NJY3RyeFZxM3FwNklwRExLTlhGT09OWVdG?=
 =?utf-8?B?cWNvNUpGRFJTYTl4NU5tbmo1ZkpqVEpLa0I5QzdsNThHT28rVzRVRkpvOEpP?=
 =?utf-8?B?RWEwSmVsRCtiQnlZY0ErZUNXY2FFcGZaU2JOQWtRbW8wMURibnd5aVpieWhj?=
 =?utf-8?B?VHR6QytObHBBbDQwWGZobzluYlMzUEk2Q3NqTzlSa1NQVzZwUHVtaGMvRjhu?=
 =?utf-8?B?UzZBVmlwdnhTN3A0TWlRNlNvUENreFcrZDNhVlF4ZDZJOWRKM0pzRi82aGNH?=
 =?utf-8?B?cHA0REx0MkxaQjFPbTFMTUQrd0hOTnA3eE5KQ2Z3MXdWVHMrR2RGNWo0RWo0?=
 =?utf-8?B?UUppeGFZTzFoWVV2QXlyY3BaSFpublNFMnRsSGNiUFBiOXlHNmRZMFI3UUcz?=
 =?utf-8?B?Z3pIUDB2dDdJMlZaY090SnBnWmhKWDlpbDNGVmpKUVRwdE1kdGQvUzBKK05u?=
 =?utf-8?B?NXBDY3hRTTJaTENOcGNzRW56Qnc5Z0E3empCMWdTOTBmbEZEcjFnQ3BEcVlJ?=
 =?utf-8?B?aUh5T1BXeW1yTHg5NGFTbFI3QVovZmkyR0tFTks0SEZ1cVh0cmFqdVByL1pN?=
 =?utf-8?B?eHo0eHk2SWx6SGpNYnVIUm5BSUs3bnBjOWlmZ2NLNUlrQVVWeVBoalRhN3Fj?=
 =?utf-8?B?TW1ZN2JGbnlzeVkvUjMyTld2OTJScmQvTENuQWlsZkM5b1VDQ1UyeElvYzVY?=
 =?utf-8?B?Sk9BUVdoR0xqM0EwNzY0MHJDQWhQVHAyYjV4K2l1ckUvYzNMUXFBYlFpeE9B?=
 =?utf-8?B?S2tlc051elpRZkhhVzkzVEoxWm5neStvNkt5cnFFbnI2RHpKVzM0RnBxRHhq?=
 =?utf-8?B?RVYwTGNHWXlOamhkbGh0VHlDeS9xZlhzemNKSHNEZ0lvTXdabVNRMUJRcElK?=
 =?utf-8?B?VkNtUXJ6d1BBQXN1RjBpL3NueTMyS3VqU2JkNDkyS3BScUZCczNQalFhMlJk?=
 =?utf-8?B?UEk3Y0JON2ZIanJhdi9HSGdXMW5CM013SDVGWlgzaG1uaG1Nd1lOMlpDRk1i?=
 =?utf-8?B?ZnlzalZvbG9lODBONTZZTXluSjIrWUY4T2FyOTh6c00yMGZscnVVUUNaVjEy?=
 =?utf-8?B?dWU0RWpuVXVhbDU0VHJNRWVLVjNSUnBtRld6Q2RTRXRDc2F5MUhMVDRNSlVP?=
 =?utf-8?B?emtRaDA5QUljRGNNVnYwNkhacFdNQVN6ejlRQVFmYmtiMnNna2dtUTFCV0x3?=
 =?utf-8?B?S1RsWXpCK1pFUjNVY0NGMTMrbXFnYWJrT1dkTWRzOWpYVkdLNjZyWWRpZVBv?=
 =?utf-8?B?U2hxRnRZVHFvdUhGNUxoUnV0NGdDSDc1RXhZRWZJdWFRbjBubnhQalRFZVRy?=
 =?utf-8?B?OUlxY0xiT21sVGp3dnJoOXZOTHJqbU5iSnhwWkNSc3VIZHcrZWNrTmxoNU1B?=
 =?utf-8?B?K0k2MlV6OTdCUjA4ek5WWGh1UmJKeTRXVGpJS1lIWE5RTFJrbzM2UXU2cVVx?=
 =?utf-8?B?YWpxN3FjSTUrbncybGxDNWt6R0N0S2wxTnpCOFprV0sxa2RQQk5kZ1AwejRl?=
 =?utf-8?B?aU9UcU4zVnJDRGRJTVg5T2pqMUpiNitZL29JaFFESUZ2N1c3RVFMaThudWNm?=
 =?utf-8?B?TFZ6WlBFeFVicU0xZjVZcXc1SmZ2UGtHZ3hhMHhGdE9TUXBmSW9udFRnc29r?=
 =?utf-8?B?UXpGd0dITjJpaXc0THY1YmVXU0s5V0dGNFBsVU9uOUZMMzJwWnJ0bEQ0eUlD?=
 =?utf-8?B?ajFYYXBGRE16Q3VtdzVRL1RQYmV3RUkrYXV3d0U3aWp2SzJKNDk4L1UzMEF6?=
 =?utf-8?Q?C12d6mw3Vi+F9IlZYUis6Dc=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dded108b-7bad-4bc3-7d24-08ddef4c0792
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:53:18.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: du/FlzATKdDNkltOdXyV7pIfKroFlwNb8vQqR5ZlTNbphiTDUs2Oc7RWFDKIr4IAnd5voQ0zMR476alCvPkPYHFZe5XuWns5Xxzvz05pfRkthIFS3N5tHXq2GCeZ7Tlp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6969


On 08/09/2025 19:35, Will Deacon wrote:
> On Thu, Jul 03, 2025 at 05:42:11PM +0800, Huang Shijie wrote:
>> As per admin guide documentation, "rodata=on" should be the default on
>> platforms. Documentation/admin-guide/kernel-parameters.txt describes
>> these options as
>>
>>     rodata=         [KNL,EARLY]
>>             on      Mark read-only kernel memory as read-only (default).
>>             off     Leave read-only kernel memory writable for debugging.
>>             full    Mark read-only kernel memory and aliases as read-only
>>                     [arm64]
>>
>> But on arm64 platform, "rodata=full" is the default instead.
> Please mention RODATA_FULL_DEFAULT_ENABLED here.
okay.
>> This patch implements the following changes.
>>
>>   - Make "rodata=on" behaviour same as the original "rodata=full"
> You should mention that this gives us parity with x86.
No problem.
>>   - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
>>   - Drop the original "rodata=full"
>>   - Add comment for arch_parse_debug_rodata()
>>   - Update kernel-parameters.txt as required
> These last two are self-evident from the code and don't need to be listed
> here.
>
>> After this patch, the "rodata=on" will be the default on arm64 platform
>> as well.
>>
>> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  2 +-
>>   arch/arm64/include/asm/setup.h                | 28 +++++++++++++++++--
>>   2 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index ee0735c6b8e2..3590bdc8d9a5 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6354,7 +6354,7 @@
>>   	rodata=		[KNL,EARLY]
>>   		on	Mark read-only kernel memory as read-only (default).
>>   		off	Leave read-only kernel memory writable for debugging.
>> -		full	Mark read-only kernel memory and aliases as read-only
>> +		noalias	Use more block mappings, may have better performance.
>>   		        [arm64]
> This isn't particularly helpful documentation and I think we need to mention
> the linear alias rather than talk about the page-table structure.
>
> How about:
>
> 	noalias	Mark read-only kernel memory as read-only but retain
> 		writable aliases in the direct map for regions outside
> 		of the kernel image. [arm64]
>
> ?
Okay, thanks.
>> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
>> index ba269a7a3201..6b994d0881d1 100644
>> --- a/arch/arm64/include/asm/setup.h
>> +++ b/arch/arm64/include/asm/setup.h
>> @@ -13,6 +13,30 @@
>>   extern phys_addr_t __fdt_pointer __initdata;
>>   extern u64 __cacheline_aligned boot_args[4];
>>   
>> +/*
>> + * rodata=on (default)
>> + *
>> + *    This applies read-only attributes to VM areas and to the linear
>> + *    alias of the backing pages as well. This prevents code or read-
>> + *    only data from being modified (inadvertently or intentionally),
>> + *    via another mapping for the same memory page.
>> + *
>> + *    But this might cause linear map region to be mapped down to base
>> + *    pages, which may adversely affect performance in some cases.
>> + *
>> + * rodata=off
>> + *
>> + *    This provides more block mappings and contiguous hints for linear
>> + *    map region which would minimize TLB footprint. This also leaves
>> + *    read-only kernel memory writable for debugging.
>> + *
>> + * rodata=noalias
>> + *
>> + *    This provides more block mappings and contiguous hints for linear
>> + *    map region which would minimize TLB footprint. This leaves the linear
>> + *    alias of read-only mappings in the vmalloc space writeable, making
>> + *    them susceptible to inadvertent modification by software.
>> + */
> Please remove this comment. If you want to keep it, this information
> belongs either in the commit message (to justify the performance impact)

Okay, I can move it to commit message.


Thanks

Huang Shijie


