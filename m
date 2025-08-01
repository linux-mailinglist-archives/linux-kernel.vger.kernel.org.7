Return-Path: <linux-kernel+bounces-753321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857BB18183
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A433A431A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79272248BE;
	Fri,  1 Aug 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Chpia6bI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Chpia6bI"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE382F5E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050604; cv=fail; b=TKewvNdin9Ra3bCxa2VnJmrb1g75x7f8ZDlJfUJom3cIoRL545UUgiFDT/4W+5f5QsSD1odKWGe3EQsmu8sTsb5p/79KNpKtGdameQTAvaX7KP9xVPjePYRgMmBKc3QWlyr2TPbxUVHhcnG6XMEDyQ1YargACLIcbnBUtaPNLrs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050604; c=relaxed/simple;
	bh=uTRJorfVz/BnFMPvQjI5qAOOkM5aob0gPzRy8oxPmNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=elzPclVNbshYwI7Ri/ikylCSTtOJaP6BDJAtM18bb94iVcLkK3hrC6s0pmbZ3ssOViZkNQtOjOCK7A85Y44ntnz5BVGzVjadbHjmDJKcMXKf16Rm6Tu362p8pHPSoCbOk7pErneIgxr7yHA5MISQRNHzGmdUm149Yx6FKFxpKRs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Chpia6bI; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Chpia6bI; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=L7NvKtHudL0AIj2sTsdrPP3uub4QDg6HSKZzsTEr+uIIXzDFzmjh05leRT1w6/EHfkmWywWa4mbOdECwXfnaXM2V4OQ7EEaDVEViFLLbl1hKkOmICYp/zWhSwFnCc2foq9tKrGef7dnXjeXV4G/OGed5tuhCpynU+5fhJFSTEMS3sMSXRLi8oeSsNW5f1R9GTMvEIduIJPX5gg9Y1G+D/wmRMD3Ne62tRDY8IpeIOcVS19z0Oh+3qaU8jx0LzyxReo6dTTNR+J+4v1DduKicx/1qoHSW8/Jp68Q0YYDiqlBLJeBEJPLM1+4bXwoQ0DUQVBlqJSqo/LMz5lPQTEMtjA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hduTLdLnLUZnZmhqstig0kCUCA8X4Tr37lqGO6hjCmk=;
 b=wel/kAeHIptJNbctEQahk4ApuKs8iaZXSGoHKJGhH3UZPql8o6SyyOIWT/5EgDv3AZyJmhJseKs+SKgg3tJpPbXHRa5R++FHWxO6clLpDjGFIuSBIPUaBOyHrB2YAM1VNdQsgFuvUwLJhGWzlzGlZSBHANrCT6Tl3feql84VDzzcvAY22sBVf1RGhPgedn6mQ61tjB25ppbjvmkmdypkiOGrEYhR/MWuFQhoXPYvPG25m2IjiW4FUhml9fDBrKXnjw2il/P3/fMOKiIZMFTeNQb7J7XKe8U7aNrZkIiyL+ELEqD3DSf/GrQKH95zC9BrfxF/LXNg+4j5+1pqej1qLw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hduTLdLnLUZnZmhqstig0kCUCA8X4Tr37lqGO6hjCmk=;
 b=Chpia6bIQUJqE8LYbv39j2/SELidnA0ihFUQ3ru+yEr71h0HenZcG+eA0bZDXDGiU5e8EBotvPdJOMbCKZMnCBRG1sNr0WJ8VkUP9sgsVPxKoRqQi+yVF9JvgVjHnvUKyQ7w5RIadGwaPBYuN2NnF465iuYgd5AnC2Rf68k/6Qo=
Received: from DU2P251CA0007.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::9) by
 DU5PR08MB10516.eurprd08.prod.outlook.com (2603:10a6:10:528::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 12:16:38 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::1b) by DU2P251CA0007.outlook.office365.com
 (2603:10a6:10:230::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 12:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8 via
 Frontend Transport; Fri, 1 Aug 2025 12:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcJr/Q5/1mzN5D5FKdSt/DpWRkZL9rxtH/1/eSrVn+Y9Qjrlw0OyDW+qeO+4UQv+d+Gc7F1bv3/hlVsnPWhFpX4nIeZ3mMz2XUCyKAbMSVFhmghjKfgZ8+fTa4ChFs4WGVYVM/6QAsLRHtAN2+ZY+003bCLDPrLtTjg72v5CPrddAiaEKU/oWVtLkYmnS5SK4uW1U7CvQKckjzwwBKhY3VMMz2fe+Y83tsjTRCMYrD414RGCqfHBqisqvGnW3cWhl2cJCAo8nyadhWmsC1x3/KtCycUXR3IeUow5qh3lBiQMUDjFIZxpPjp8kO+sjM8xr+LqPk8CSW3SEMQ6fmgZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hduTLdLnLUZnZmhqstig0kCUCA8X4Tr37lqGO6hjCmk=;
 b=CD1NnEUZRPrOo/I/NEsQSDL0+uhkVF/q5WjC1IUbipLC8uZt/hp+Vcv9KXEkv0Wv9jv1yoif+tRv4MrsSxOTojoYfPM/OzF94GwsCSl3gG2V0zPPAfXPpW722lSKB4/xaTRYXO1LVKMCGsv5Iyoc4wlRg/3Li2aWhyka8XH8ZY0xzQx0g+XFO7CjhU2P1/9l6dFzuwGk2snZWoucAgbIY+eC8gj3iYkEJp/jdYLX72yHfkyfYujEm2WXdRVwJzDybDqT3oV8jhB6Np0E5uLc4AQtHguDOs5x269ps6MmwCuNKJ3t29bPP2pnKqrHJSLX2AkI5sJEj7zAOzTr2rejuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hduTLdLnLUZnZmhqstig0kCUCA8X4Tr37lqGO6hjCmk=;
 b=Chpia6bIQUJqE8LYbv39j2/SELidnA0ihFUQ3ru+yEr71h0HenZcG+eA0bZDXDGiU5e8EBotvPdJOMbCKZMnCBRG1sNr0WJ8VkUP9sgsVPxKoRqQi+yVF9JvgVjHnvUKyQ7w5RIadGwaPBYuN2NnF465iuYgd5AnC2Rf68k/6Qo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GVXPR08MB10964.eurprd08.prod.outlook.com (2603:10a6:150:1fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 12:15:59 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 12:15:59 +0000
Message-ID: <c53ec40c-1fe4-4092-a876-61d5b37d8b02@arm.com>
Date: Fri, 1 Aug 2025 17:45:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 ryan.roberts@arm.com, kevin.brodsky@arm.com, yangyicong@hisilicon.com,
 joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, david@redhat.com, mark.rutland@arm.com,
 urezki@gmail.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aIpPsg1Kij8Knnjl@arm.com> <9169f4a1-1ad3-4ef0-8d16-eabebfa64cf0@arm.com>
 <aIuihRzw1xvZ-PaY@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aIuihRzw1xvZ-PaY@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GVXPR08MB10964:EE_|DU6PEPF00009529:EE_|DU5PR08MB10516:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fedb20-9ee4-443e-9360-08ddd0f542dc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QVo0dHBmYitlVzZ4UXBRUDV6aGxEcVFnUlE0ZXNaaE9nV3NpMVNNeHUxc2FX?=
 =?utf-8?B?ekFjbDNpVm1mLzdpMXdCL0l5ZmFzRC9DOE9MZXV0S2w5eUtKT1doeWhTWS9Q?=
 =?utf-8?B?eDFYblZpeGNVbHRUZVpCYysrMWExRUZjZkRRaDVJbHhKajBndFNYa1UwUkNB?=
 =?utf-8?B?bm1JZnNUUFlGd2ZTTVZPL3k5SHhiSElTdnJSRGdKVmpCMUU4SDRSN0FrWExV?=
 =?utf-8?B?SHhCZ1NJQ2tjSUxjeitZUVhDdHB4MFZ1cWlUK0NKOFRwalVwZGpHQTVZY1Bq?=
 =?utf-8?B?MTY0T1BzSmZWYWl4clQ0WVVmbXhHVGZpQTNIUHhsUGpmdXhuZUVLK1doUWF1?=
 =?utf-8?B?V0loT2hGcmtDRkV6RVhGRncyQ0Y1OGIrV2dNT0Z1U0VtOE8reWhMTnpreWJm?=
 =?utf-8?B?blFsUk5sNnRaRzA3QjdIaU1hbHFmNlZEek5HdFcyUzBZUk9kYUVpdVVEMi9S?=
 =?utf-8?B?OVBvQkcrTnNzb0REYUNwK0t6MUQ5dGZoeWZpcGQ0MGFJd3VXNzU3V0xML3hN?=
 =?utf-8?B?MnkvWjR5Rjh5NXF3RVE4N3ZaN1BiWlU3aWk5YmFwSlN0VlorOWM4dlNBcFNK?=
 =?utf-8?B?dndQNjZqaUI3dzI2QTV5VzhUaVNhK0x5NFNIUXVoWkFYVWtaTU5LUUFaQ29J?=
 =?utf-8?B?YzFxUldiNHltNWJUUFB2SXpBN01IOW9SaktVUlJJNXMvQ3NNUEpSTzg0RXd0?=
 =?utf-8?B?OW10bE16QTBOTEpmSTlhZXNKQ1ZpblpRejdzS3RsK1dRRitqdUpyQ1lyWllI?=
 =?utf-8?B?ZnlwWHNRUG1qZEtBWjk0Wmw0bnN5cGV1NHV0Q1F1U0pNZVl1SXFsZUlmZ1py?=
 =?utf-8?B?RDhTYzlCK2Z5STRkQjJ5c2dLcnprb25Rb3l5SzEvWFgzc3RWUWpudU0rdm5N?=
 =?utf-8?B?Mm93TlljTUxrMkk5aHk4aHJFRTRzQ3FiM29kQWx2dS9xbEF2QTZvVEhEVEFn?=
 =?utf-8?B?NWErY2h6dzB3cWlqOUtQVUwwQStDSWdoUzZwQ1NQTXB0eUZ2czZOUHVSMlhJ?=
 =?utf-8?B?Q056SCtYUWdkUHZLVTZ2Qlk2eDU3NnRnOWphWWJjRWUwQ3FzTE4zcHk3UVVq?=
 =?utf-8?B?UEwxUmtkRHR6WnROc0NnRjhlOGNFNEpOYlEveTJzeG05V3hoWTUwQVlmRGJL?=
 =?utf-8?B?ZHhUb1lUTG9EbVhnSG52UjhLZUxYMGV0WmxERG8zcHhyWSthMjNES1VaUUhq?=
 =?utf-8?B?NGNHMUVDTVR0SnhqWHBVTnJPVjUyc1NPYlB6Ky94U0FId3lLZ1VYUDdMRGFS?=
 =?utf-8?B?NDE2b0F3RjB0Q2kyb3dMdTVyeFZHWWw3YXk3bGhMOHRtR054YlZQRmhBZ2lr?=
 =?utf-8?B?MWczUTdkRHBXakhmSk9aS0NRYTVjczArbnJaSjkvczBKbktUS1dYdGFSV0sr?=
 =?utf-8?B?NjFMSDF2RmtqcDBtZkZQbkRsOEIrN1dWdWxBNWQ2NEw1UEMvWGVveGx4eFF3?=
 =?utf-8?B?WWd3TmJ5dUR1TDg3YTh0Q0ZaY0JVQ3Y4clVNVkdwMWZIRi9NeGFiSjlHZXUw?=
 =?utf-8?B?Z3MvQjBIakhuY2M2Snc2RGpRR2dzL2UrV1JWM1BXLzJWbGk5MStoRUdsOUFl?=
 =?utf-8?B?NDVTRlg2SG1SUWJwYjl6S2lmdlgxUUZLTk1JZ2NPcFZmL3NzQVVSazdQc2p5?=
 =?utf-8?B?YmgrbjFhdTVUanFYUDZqUFk2SVZ5NkFXNUhKTVFCdWQ0b0Q5Uk5lU1RGR1Z5?=
 =?utf-8?B?cnArZk04RlFhbEFGd3lPcXFsaDBqSTNmMGw0cHcvQ1h6UWhJa1UyTi9MU1JO?=
 =?utf-8?B?cGtIN1lzcFJ3bFprNkp6a0ZFcjE2L0VyTjhNamZFV3QyaDg5cTA4SlpkYzda?=
 =?utf-8?B?ckhjUS9waGVHTk1WT2VOVDhDblZzbXQ4bzdnWFI1MlFwejBJaVpZV2FuU3Vw?=
 =?utf-8?B?cjRyeEEwVzM0OGhOMFRkQUx0UFNjeW9EeVJIYk9jNy9DRit4KzZFNnQyNExl?=
 =?utf-8?Q?DHBzfdjkEKQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10964
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2ae34878-8b8f-461a-be1b-08ddd0f52ccf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|14060799003|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zng4cW5JZFlGazlKV0wwNTQ5dVh1OUc5RlhyU0FxODJpWDUvZmV4Kzk1M2NN?=
 =?utf-8?B?UDQremdaaDJHRnQ2dEZ3VEttcTdoVGF3ZkJEekJ5VlBSVklBenJuWFlDSVg1?=
 =?utf-8?B?bzFQbzRaTFlrUHRGQzRjOG5ERU1lWWV4dTFTcEJXRURDbXFVNE5MNHhGZzlD?=
 =?utf-8?B?M016ZkxsNW1tcWhiWG1URmlycGo3TlpCclJaYjQxRzA5SUticXpObWtHVjRT?=
 =?utf-8?B?Z3RyZjg0WCs1aHVUNkNuVUNPOWlaK0JVMGt6MmRlYysxZGJDS3FVUjdqV2p3?=
 =?utf-8?B?dTMrUHdDbmR0SFpMMkFpRTR6SURSVnpiVVJLeE1yOTNyMWp6VkF6TVZ6SlE2?=
 =?utf-8?B?MWJTei9pa25WcUM5OE1YcU4zbDBaSmlzR1hGZDdSQ1V0NVY5N1MwanlPWTJu?=
 =?utf-8?B?bEFSZDE0b05DckNZTXlVOXNQTnIyK3lBTjUrejcxNkZVWnRkbDhDNTNCZHJw?=
 =?utf-8?B?SzU0djJuekJaNGRISjVWYmQ1QXBJdVhmTnl4cVVTNnM1NnkxYUVKMHJDS01p?=
 =?utf-8?B?cU53dVJrUVBBUWtlUjVsL2xRL3dHOE5wSWVxanBGSGVvTzA1aFA4cC85elJL?=
 =?utf-8?B?MUliOHlsaUJOaVg5VHFaYml6aE05U2E4N1ZzcllrSU1XUHJMcWE4aG5FOHYv?=
 =?utf-8?B?THBzWnIxeVhsS2FKOElDWHlWMjNxbEpyZUV0VGFYTDRkbElRZXRBSmVJbm5h?=
 =?utf-8?B?QWNrdG5wWmR1ZWd1S2lHTnVvcVNFZy9VdzRObmlCUk01UVJ6bUxqcFBHM1I3?=
 =?utf-8?B?SjQ4T3pGeW5DVVBrM01BTklrZnRxZ09JYlhNSXpiOGdzMEdGeFdwUDZNQkZr?=
 =?utf-8?B?UnBvZ0JHUnAxbXhxU3R5S3FEdnRQcFFMcEpMQ01BUlpvTWpvbmVSQWZiRSs1?=
 =?utf-8?B?T0RJc3ZpcVRmbk1VUDFnU3dmclJ6U0gzZEZIVjM0VVoxTHFOM09yaWVjdVl4?=
 =?utf-8?B?bWtyRzJhcm5KZ0pabnpoNHd5UFlmWTNZaDFKOGdTbTY0TWQrSUJCaCs5ZGJ2?=
 =?utf-8?B?anpkZll4N1Fra0xkSUJUekJJNDBLUkNxRmRCd0xDa2xHYTlLZGlpSDRZR0dq?=
 =?utf-8?B?eS9QNlU3eVZHNERqeUs3aTFvRTR6bTlEckZ2WGMrbE5Hd1R3TDNGQ1hwUFhs?=
 =?utf-8?B?N1F6NmZkSTJ0aEF1VWpBeTRNT3NYMDNDbkJtZzVTcnc5UHoyU0ZXaWJEYXFI?=
 =?utf-8?B?NCtneWVuYnI4bldXMkdSdGJCMDZ0UGd3cTdzYkJITlkrVWVGai9rNXR2bWF6?=
 =?utf-8?B?QUJTVURZUWFPY0hVY082QXhXdU1ScXBrbmRlRE9LdzRCZlUyMDJmeWVYcjBM?=
 =?utf-8?B?OHhldmRuQU13TjJGdjgvcnkzMGpJUkw2UnFNVlQvY1RsanVuc0U4L1c4L1d0?=
 =?utf-8?B?V1N0eFhQd1dLMnhKZmQzV2gya29XRUgralcwaU1ZMjJGaWRRTUUvMzN5VUEz?=
 =?utf-8?B?SkxOd1pVandWM0xTaGk1SmU5MDRJYnJSQ05uMEovSDlNbzNLRUgwMHhiZCsy?=
 =?utf-8?B?eFI4RFVpVnhINXNNWkk0dFNUTDJPaHJLV2pmTURYV29ETjFUZmxvODRYSnJv?=
 =?utf-8?B?RXNCNkRRaHFlb0x2K0RFVjJ3cmpBTTRxYjV1RnIxZ0MyNVFJQThuSXkwRTlP?=
 =?utf-8?B?OS9YRlFwdWVJNHhTN3BMUTRGdXYwaGovNnlZS1I4SGNzODZXVWUySEpzdnZi?=
 =?utf-8?B?ZDd3Uy81R0JING9iWjFVQVVqd1JybHZSak5QaVlBTzRMSUx5YkFkMUxsT1Rx?=
 =?utf-8?B?OGR2a3Z0QUVEYjhMK3p3UjRLZndnWmFCRFArVEZ1V0lEMTY4NnRtMnAwaklO?=
 =?utf-8?B?YlZvcXNyTUNxNWI0MkRpRnFHN2N5a2xWNGtMb0J6WUVnWHBTaEx6WCsyY1FD?=
 =?utf-8?B?clJoN0QrL2JoMjZ1L2lJbmpYclhvNzN3d0YxRmFuNDBob2dUN0lOWDhhbHlR?=
 =?utf-8?B?YkJOVUhXTGt3Mmg5NnhHYXBLejVubTVLc1NTaHI3a1hNeFpKT2lCbUQzTFBL?=
 =?utf-8?B?VElNeEZxdktsOUd3OWEzSDNGNUpDWi9DdSt3eUtySTBJeHVtQXZrYld1RTdX?=
 =?utf-8?Q?QHI+wP?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(14060799003)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 12:16:36.2630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fedb20-9ee4-443e-9360-08ddd0f542dc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10516


On 31/07/25 10:36 pm, Catalin Marinas wrote:
> On Thu, Jul 31, 2025 at 12:42:21PM +0530, Dev Jain wrote:
>> On 30/07/25 10:30 pm, Catalin Marinas wrote:
>>> On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:
>>>> +	 * Case 2: The static branch is not visible to T2.
>>>> +	 *
>>>> +	 * Since static_branch_enable() (via dmb(ish)) and mmap_write_lock()
>>>> +	 * have acquire semantics, it is guaranteed that the static branch
>>>> +	 * will be visible to all CPUs before T1 can enter CS. The static
>>> Does static_branch_disable() have release semantics? I think it does via
>>> some atomic_cmpxchg() but it's worth spelling it out.
>> Yes it *should* have, but this proof is already getting complicated so I thought,
>> let's not mention anything which is not required in the reasoning of the proof :)
> The static branch observability relative to the mmap_lock is essential,
> both when enabling and disabling the static key (i.e. you don't want the
> static branch to be seen disabled while T1 is in the critical section).
> That's why it's worth mentioning.
>
> On the static_branch_enable() path, we have a kick_all_cpus_sync(), so
> the T1 update of mmap lock will become visible after the branch update
> (of course, also subject to correct ordering on T2, see more at the end
> of the email).
>
> On the static_branch_disable() path, we need it to have release
> semantics _prior_ to disabling the key. We get this via the
> atomic_cmpxchg() in static_key_disable_cpuslocked().
>
> So I think it's all good here from the T1 perspective, just capture this
> in a comment so that we remember in a couple of months time.

Got it, thanks.

>
>>> As I mentioned on a previous version, this visibility is not absolute.
>>> You could say that it will be observed by other CPUs before they observe
>>> the write_lock.
>> Hmm. I probably am bad at explaining all of this in English :)
> It's the other way around - I don't think English is appropriate for
> explaining this ;).
>
>>>> +	 * branch not being visible to T2 therefore guarantees that T1 has
>>>> +	 * not yet entered CS .... (i)
>>>> +	 * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
>>>> +	 * implies that if the invisibility of the static branch has been
>>>> +	 * observed by T2 (i.e static_branch_unlikely() is observed as false),
>>>> +	 * then all CPUs will have observed an empty PUD ... (ii)
>>>> +	 * Combining (i) and (ii), we conclude that T1 observes an empty PUD
>>>> +	 * before entering CS => it is impossible for the CS to get hold of
>>>> +	 * the address of the isolated PMD table. Q.E.D
>>> OK, I nearly got lost. That's not a straightforward memory ordering with
>>> as we have instruction updates with ISB as part of the TLB flushing. I
>>> concluded last time I looked that this branch patching part works
>>> because we also have kick_all_cpus_sync() as part of the static branch
>>> update.
>>>
>>> Stepping back to a simpler model, let's say that the static key is a
>>> variable. I wrote this quick test for herd7 and the Linux kernel memory
>>> model (fairly easy to play with):
>>>
>>> -------------------------------------8<---------------------------------------
>>> C pte_free_ptdump
>>>
>>> (*
>>>    * $ cd tools/memory-model
>>>    * $ herd7 -conf linux-kernel.cfg path/to/pte_free_ptdump.litmus
>>>    *)
>>>
>>> {
>>> 	pmd = 1;				(* allocated pmd *)
>>> 	pte_page = 1;				(* valid pte page pointed at by the pmd *)
>>> }
>>>
>>> // pmd_free_pte_page()
>>> P0(spinlock_t *init_mm, int *ptdump_lock_key, int *pmd, int *pte_page)
>>> {
>>> 	WRITE_ONCE(*pmd, 0);			// pmd_clear()
>>> 	smp_mb();
>>> 	if (READ_ONCE(*ptdump_lock_key)) {	// static_branch() approximation
>>> 		spin_lock(init_mm);		// mmap_read_lock()
>>> 		spin_unlock(init_mm);		// mmap_read_unlock()
>>> 	}
>>> 	smp_mb();
>>> 	WRITE_ONCE(*pte_page, 0);		// pte_free_kernel()
>>> }
>>>
>>> // ptdump_walk_pgd()
>>> P1(spinlock_t *init_mm, int *ptdump_lock_key, int *pmd, int *pte_page)
>>> {
>>> 	int val;
>>> 	int page;
>>>
>>> 	WRITE_ONCE(*ptdump_lock_key, 1);	// static_branch_enable()
>>> 	smp_mb();
>>> 	spin_lock(init_mm);			// mmap_write_lock()
>>> 	val = READ_ONCE(*pmd);
>>> 	page = READ_ONCE(*pte_page);		// freed pte page?
>>> 	spin_unlock(init_mm);			// mmap_write_unlock()
>>> 	smp_mb();
>>> 	WRITE_ONCE(*ptdump_lock_key, 0);	// static_branch_disable()
>>> }
>>>
>>> exists(1:val=1 /\ 1:page=0)
>>> -------------------------------------8<---------------------------------------
>>>
>>> I sprinkled some necessary smp_mb() but in most cases we have
>>> release/acquire semantics. It does show that we need a barrier before
>>> the page freeing. We also need to acquire for enabling the static key
>>> and release for disabling it.
> The smp_mb() before the write to *pte_page in the model above is only
> needed on the static key disabled path. As Ryan pointed out, on the
> other path we take the mmap_lock and we have acquire semantics.
>
>>> Next step is to assess that replacing the static key variable read/write
>>> with code patching preserves the model.
>> Thanks for the litmus test!
>> I ran it and I get the same result. But I still cannot figure out where is the hole
>> in my proof.
> TBH, I couldn't fully follow the proof. The arm memory model is based on
> relations between accesses (e.g. read-from, coherence order) rather than
> timestamps. They may be equivalent but that's a whole new (and complex)
> proof to write.
>
> So I'm happy with a simple English explanation and a formal model along
> the lines of the one I posted as the equivalent of a proof.
>
>> I think you raise an objection to Case 2:
> Let's follow your approach, you are missing some timestamps, adding them
> below:
>
>> T1:						T2:
>>
>> WRITE_ONCE(*pmd, 0) : t1			WRITE_ONCE(*ptdump_lock_key, 1) : t3
>> smp_mb() // flush_tlb_kernel_pgtable		cmpxchg(acquire write lock)
> 						^^^ : t3'
>> 						smp_mb()
>> READ_ONCE(*ptdump_lock_key) = 0 : t2		val = READ_ONCE(*pmd) : t4
>> WRITE_ONCE(*pte_page, 0)			page = READ_ONCE(*pte_page)
>    ^^^ : t2'					^^^ : t4'
>> 						smp_mb()
>> 						cmpxchg(release write lock)
> 						^^^ : t5
> 						smp_mb()
> 						WRITE_ONCE(*ptdump_lock_key, 0): t6
>
>> Let t_i be the global timestamps of the execution of the labelled instructions
>> (note that each labelled instruction is atomic so assigning a timestamp makes sense).
>>
>> The fact that we read ptdump_lock_key as 0 implies that
>> t2 < t3 ... (i)
> Or that t2 > t6, a plausible scenario in the litmus test above.
>
>> Now,
>> t1 < t2 because of barrier (ii)
>> t3 < t4 because of barrier (iii)
>>
>> So we conclude that t1 < t4, so val will be observed as 0.
> Without a barrier between t2 and t2', there's no guarantee that t2' >
> t2. If you remove the last smp_mb() on P0 in my litmus test, you'll see
> it failing (run herd7 with something like "-view evince -show prop" for
> a visualisation of the transitions and relations; you need graphviz
> installed as well).
>
> The way it fails is that t4 is seeing the pmd=1 prior to t1, t2 is
> reading from the t6 write and t4' is reading pte_page=0 from t2' (since
> t2' < t2 is possible without a barrier).
>
> A control dependency would work as well without a barrier, i.e.:
>
> 	if (READ_ONCE(*ptdump_lock_key)) {
> 		mmap_lock();
> 		mmap_unlock();
> 		WRITE_ONCE(*pte_page, 0);
> 	} else {
> 		WRITE_ONCE(*pte_page, 0);
> 	}
>
> but the compiler is probably free to only issue a single WRITE_ONCE()
> irrespective of the ptdump_lock_key check.
>
> Of course, using smp_load_acquire(ptdump_lock_key) would also work.
>
> However, things get fuzzier as we don't have a classic load from the
> ptdump_lock_key but rather a patched instruction. We need to guarantee
> that t2' is issued after the t2 branch when the instruction is patched.
> The kick_all_cpus_sync() on the static key disable path doesn't help us
> since P0 (T2 in your description) may see the patched branch/nop and go
> straight to the WRITE_ONCE(*pte_page). Not sure what barrier helps here
> (after more sleep, I may have a better idea tomorrow).

Got it. The hole in my proof is not with Case 2 but with Case 1: the assumption
in the reasoning is that pmd_free() will be observed after the patched-in
read lock/unlock, but that will happen when patching-in happens, for which
we need to observe the branch before the pmd_free(), but that isn't guaranteed
since there is no barrier between the if block and the pmd_free(), nor is there any
control dependency, like you describe above. So, in pud_free_pmd_page, the entire block from "pmdp = table"
till "pmd_free()" can be observed before the observation of the branch.

Reading tools/memory-model/Documentation/control-dependencies.txt, I interpret that the
compiler is free to hoist out the WRITE_ONCE() out of the control block, and then
we have the same problem, BUT I tested with herd and the test passes :)


>

