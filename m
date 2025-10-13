Return-Path: <linux-kernel+bounces-850255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F826BD25BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DE1899881
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B2199BC;
	Mon, 13 Oct 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mehSCITz"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800B1A23A9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348786; cv=fail; b=A76guspaQ0mwvyY//hyF5JcjoBvHFzzC0ul1T82vON9tYy8HjRpMh55dveGGP4tGbyGC7XqR1k58Xp/sBtiiV2lR1I0j3W9RNCi+Uh6OYAgXHpqiDWuUYPzn8sWb6kWH6b4p70qMl5xSo07snQ9VKFK4w9bxqOFIShhJ5kWF5PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348786; c=relaxed/simple;
	bh=94dwXMrWts+rvHfkTFjpr5keGJkDdGe8PzfgpDJDA1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aQgpZVDGmdXVG8Hg8x54CjzvUfpHRPlifi+UEd4FTz6x1wv9j34hguYHw1UQNmeUa3yO9aHgBRTFnD3GciwzHxEWQYz3VN1Cf6VCC6Q+1gTKcGU2UvEiw4iRMyFRgKrr1Je4/x5x7j+t5HknYZNzTQf1S+6zkG5XYYPVy7eGBPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mehSCITz; arc=fail smtp.client-ip=52.101.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY0k2bGnEb36xor/taCAeKLf8OG1LEZ81IEPRWPaNZ0cTrZI8Abu+0r7BK9dBYtoJclOXAxcYxKxBQ0nE7T6XDxSw1ElbXgToAourEoeVK/yMmHF8cBL3ehB18qPdWuL3ddIIRdZ2bqcgVtcNPJsMxVJqBuQ46alpL2PL1fTs3iW0SZi6bWnflD8ILpcvQ2JIxJAMd1+upjfqwK8fO+qCbnQOn2Zvw0WCblZeTW3K9eViA+NpEiePAq2jC0Qdpim33r6z9hLs2IgFNP0x0KrET9byk9+btX5kcZgodhuOKjjzxk8fcs80bzyVvJe3iVly/AiN0TwnlqhrJgWb+0fOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idipS1dltgxYf5Y70D2kbOPxGIFRkrcNUOJ6tXV5IaI=;
 b=CJQAA6pDv6lPRGm0iodctSz+gkPusX0iamTmSgTskEwDCtNsmCBKDtDuZ0ZfpPrRA1MrmzAeujcQyT+7ql0X9awq91iCC2ta4lDiudrvF8OXzIeILBdh+OBM1L8ZJOfVBkX/KVDwXjimuqkbXKmpz0p9UGgy7Xz5wSEJo1EaMp3VF3xWE6Mkdggf8iUZAbisTvZz1++Z2loofTgLjn7XwVyI8ArJIuP/Yv0VZH7r8L9wVKIKAzBxx16Llzn5jTCsWL0DBTUy2OP6FmhlvcQhvqQngKBXb/YYRIDN5ANnudrAM08LUD0jn3JdfVq7Os/E1ecXwMPQtLijM1cWthJKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idipS1dltgxYf5Y70D2kbOPxGIFRkrcNUOJ6tXV5IaI=;
 b=mehSCITzMXGI+2d4II5+InuMsYg5op4fvjsVzcKkZDzOFRImL0IrPJjP1bnmownAGJpkt/laSX2T/G6Zx0MbvGBpPK1IvDPPvqSd3ExMX1yiZ2AgEZ3teL8zZ2wBREiPb9hVWdjr/o4H0MBy2sV95cSJdMxgsIZwiHLz/TdjgFQBRPpnXF1804ylsZ9yJRvYYRL87UP8PUuJ71t/7AUxGU/zYv84BFpHfmIBeQFrM7N40Jv9kQCDUiTfrTKm2aEOUqxCLcFKmaRAD8vGsCuLN26TPNT+65MO64D2GtGzE9XXD4KBi95SSB19sV+vamD+Z15dOw9PdMggjV1jMHYPxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 09:46:21 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 09:46:21 +0000
Message-ID: <63169fb3-9736-435a-a550-350fe3b3c29d@nvidia.com>
Date: Mon, 13 Oct 2025 20:46:13 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
To: David Hildenbrand <david@redhat.com>, Lance Yang <lance.yang@linux.dev>
Cc: Longlong Xia <xialonglong2025@163.com>, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, xu.xin16@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, Miaohe Lin <linmiaohe@huawei.com>, qiuxu.zhuo@intel.com
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
 <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
 <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
 <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
 <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
 <839b72b8-55dc-4f4e-b1da-6f24ecf9446f@huawei.com>
 <f12dfacb-05dd-4b22-90eb-fcc1a8ed552b@linux.dev>
 <bd374ac3-05a2-41ae-8043-cc3575fb13c0@linux.dev>
 <3e6500dc-723f-4682-9e37-b28bc78a2bdb@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <3e6500dc-723f-4682-9e37-b28bc78a2bdb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CY1PR12MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c249612-75b8-42b4-dfed-08de0a3d5d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHYzMFdBdnhkNXFuVjh3YUk0WldSMStJL3hMenhlWTNuak9YZVdjb3pGcnlH?=
 =?utf-8?B?UzYzUEp5ZDNzOHZTOUUxMlh6L200VVZ5Ry9RQkxLYUc0RGlvMlJUdTRJME1M?=
 =?utf-8?B?T0FRM0dBcFFpMjR3SHlwTmJ3VTdvZnRaN0ZKaURieDZVb05jMXd6bjdQN1Zz?=
 =?utf-8?B?anJRamU0Wm12K0czclN1MXNSVUkraExFWlB6ME1FdGZRVkpReWljcWpTd0VX?=
 =?utf-8?B?dFdnL29iTXpSTlZiZU9PendJRWVtZi95c3NWZENFdDBkaW1qeHV6SlArZmtj?=
 =?utf-8?B?ZzZYamVPbjFyUDBlc21aMWtIbm9pYWlKN3YxK2t5N1Rjc01mMHdXbGFLMW8x?=
 =?utf-8?B?Z215MEg5S2hSd2YwVlQzSy9KV2pxQ2kwdEZXd0FFM0lYU2hBa3FZUHlzb2dJ?=
 =?utf-8?B?RDZ6Y00venVBS2ROK2lQRmNRakRKemw1ajVzOWxKQjlxOUNDSVhJeUVCM1lz?=
 =?utf-8?B?Q3B3Uy8rZ2FZMXZyL3B0ZFd1UWtWdzNPT29hOStkUkxuMW16cVV0aXFZQ0pP?=
 =?utf-8?B?NStkaTlTazMwNlhxNHVqMlNsTW9Ga1g4d3g0V3A3S2diUDRjMWlla1g5VTRO?=
 =?utf-8?B?ZjFTVEpWMmNhenhiTlZEY085bDBHLzZkSDRPM24rQTNPSHE5OVByRU0zQTFx?=
 =?utf-8?B?L3BGN0hyVVJIemhpK2U5SUZqT2R1dEQ0ajNXUnd0WmN2RGQveThHQWhtc1ps?=
 =?utf-8?B?QkhSZVQ3RXRMRVZZV2lPVUYvZVNWQXRDaDlXbzRGNWk0QmJTV2o3U1BUYnlT?=
 =?utf-8?B?aXcvc2FDM1VydktabGdXc25rOFVpK3djOHVIeFpoQ1ZsWi9oSDlMYStUUmMy?=
 =?utf-8?B?THA5RjJlMnZZN0ZOUXRWQm1KcTlILzRxYVlYWEJGM3FLcG9keUNMNjlQR01E?=
 =?utf-8?B?a2R0WmIyWE9WK3pZRXVrWmpkQ21QZ1pneXRITEh1dERmM2pYT29MdEU3akly?=
 =?utf-8?B?RnpnbXdpQ2dOL2tVVFc1aXZmZmxKbWh2ZWVkVC8yaDlMM2hOaWdGNEVaZWNL?=
 =?utf-8?B?UGNPU09DbndvUUxFZ1RYN3p6RkxJdjRYbTlqb1JjUEhjQmZDU2ZlTGlSZmdr?=
 =?utf-8?B?Q0xWYlBXOThrT0FZajl4VGdxK1ZtVHNTY281alVhQk1YWXNCVlYrcmdCbitt?=
 =?utf-8?B?bXdjQWdNUHErVURBMFE1QlJ5Wlhha3RqcndsMUpIUS92dzFwYVU3NkZuR1Ex?=
 =?utf-8?B?aCtERDhxd2p5RjBiQUtnaVNXZVErYk5SbERULzdEZVAzVU1zU3BqY2Z1YUFP?=
 =?utf-8?B?bENmWDNwdlJwVjVwYyt0SDF4REU5MUxhaDd3L0F0V2ZTTnJaRlh2Zmp0THpP?=
 =?utf-8?B?K0xmT2JDNVBEWXZENnhpMXJqcFJPSXc0bjBDMkJXTWI1SXpwbGtjVlRzcUg1?=
 =?utf-8?B?enRIdm4yVHFyN1NtNHhMaEhraU1BS1JHVForL2pCOTliRDVxcUx1c2RpN0FQ?=
 =?utf-8?B?SjZsUE5PS3VOOE5GU0FobkdNYjlDTzY4ZXo4TDBFWUNiY2NIU3NGeDZrcTlt?=
 =?utf-8?B?OXZMQnJTemhZMFNkOVRUOVE3NHNFTzdsYmlhUlY4aWp6TG5GN0VpQjBXdE5p?=
 =?utf-8?B?U1F0eEJzTmFzRDNGSS94ek9adlJ6ZE11S25hSU5oRnFteWMvYU9tck1CVXEx?=
 =?utf-8?B?aDQ4NW1WMXVhN2pOYUFKZzRpdUkxUENNek5TTFlHY3o3WDR6aENhNjJRRWV1?=
 =?utf-8?B?L25peHk2Y0pqSlJGTmpzWFIvOGd1cmRBOUZjRkNVdXhTbkU4MExCc0RwM2Fw?=
 =?utf-8?B?eVFUVlNLWUxTY293eUprVERDWmV1UG94OGFWWWZLOTB0RTM3YkJtZmJzbk9i?=
 =?utf-8?B?RDV1TlAzd1BWbFovTjFEVEIxZmFkWDhsRmlFdWZ6U3lzM1p6N3NnOHZNaXNP?=
 =?utf-8?B?OGdvbS9oWHhPVkVZNGVGUDg4VVMzeHJaektWdUhCS0Q2S2ZJQ0p4Q3p3c3FB?=
 =?utf-8?Q?O+17Uxtm+ZuvadZPQmZ393Cuwy6E4flb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTVXNGZ4YjlRbFNyZWFaZTR1ZjVKSjF6TThOZVltcVo4dm1YZzIxcHBoemMy?=
 =?utf-8?B?alhXZ0NUWi9CMS9mTEZ4djVnYitjNkQ0NEhhdmNUK3BKNHViZTJVbDhWM3Bx?=
 =?utf-8?B?M2pwNzA1TXdWTUxjbFUza1VOQ3B2U2NCOURQMUt2dlRLZ3RzdmJMYW5QTVlw?=
 =?utf-8?B?NjB1UUZFRWkydXYzUnRaMDNzek9IQ0VGQlhET043alpNQXJXQ09Ja0h0RWd2?=
 =?utf-8?B?VytPWkFhOVBWM0lyQnNpMHUxdE91WTZCUFZYUHNVSG1SS3lvb3paZXRlY0Jw?=
 =?utf-8?B?LzRPbmd2ZDE4ZlZ1UHVFaHh0aUZ0cTFTTnZTcmxWN1JyZzlXQzZwQWxlVnlQ?=
 =?utf-8?B?dm0xczcrazEzbHhVOEZlUUxSNEF0MTdPK3dOa0JtTUZpRVNtc0VjSEthdktm?=
 =?utf-8?B?aEVVTGZVRWxpQThQZUorRXVvbTNsMVBxUDBJUUZuc1M5L1Y5TTBtOVVITGJT?=
 =?utf-8?B?Uks3eVUyeDZTM3VzbS9qUUluQStFMWhFL0QzL2czVXJhRlBZYVVVUzFJWlBx?=
 =?utf-8?B?YTh1S3QyRG1sVExsc1QyNnFDWGZJdTlabmJkU0VWVVAwa2JuYWh3aDVCdFVt?=
 =?utf-8?B?SWtUTFhsTldUSlQ4MGZDQnhVTkpmaDV0RmdCOVhmdjNIdEVmZ1dkSUZlbUVv?=
 =?utf-8?B?R0RjS0VCU3JLVjJZZzVqaTJWSmpDL05TNzR4bllHR3Y3b0hkeVd0UWdYN2J5?=
 =?utf-8?B?UFp2bExpUWFWbHdIQ01Vc2RSV1ljand5eGdNcDN2ZEFta1B1S1hBbkkrRmFZ?=
 =?utf-8?B?SmlZSUM5RzBvdjJLSXhSUHp5MUZhcEh2TEU1cDJRUktmcG8rUkdWYVQ4Z0RS?=
 =?utf-8?B?Nmc1RUFzUWo1K2FwdWNkTDJxdGU3enVmOHgwY2w4UndJczBnelYxdDN6cGxE?=
 =?utf-8?B?V3NUZzZWSWRZZFJwVFlmWUIvVWxiNXpuNDlmQ05NRDIySlVDTWNpT2t0aW54?=
 =?utf-8?B?bmtaRVNTUVF4YUJSNHQzWnhYWWRCT1M5NDVyL2xuMENQaytvaC9FTCt1NTFY?=
 =?utf-8?B?U2VyN0pNcFhkSkU4TnlaUUlGMktIUklrN3FwU0JwbjNLbFp0eUJRdGRocVRX?=
 =?utf-8?B?R3l3ZjV6L01TdnhBQmFDS0ViMk1pZGlNZ0lFMVZqWkExKzBValV5U1I3VDc3?=
 =?utf-8?B?QWZ2NWQvakltT3krc2hyUFhoMitJT3pGMTN4Mkx0ZmF4WlBuN0NhYmI5VXZx?=
 =?utf-8?B?QTZQaHVtRlRqWjF1TGVnaHdKMGJkZ3JBZ0ZLVnpibVFiSXpIU2tpOGlFMlox?=
 =?utf-8?B?U0RYdVllWWRXelRnenNQZFJiWCtqSjdOWDN1em0reitlMWQwVWpQS1lvVFN0?=
 =?utf-8?B?TjdIeFdvZEVlWC9qanZoeXJTaWkwUjI5Y1dIVERNa2Q1L2QzSGpNdG9EOHM4?=
 =?utf-8?B?ZVR0NnM0UEFNL1lHQWFkL1prRG1Ka0ppUEJKWmUwdmQ3SUdSY3Z2dUJDY1VG?=
 =?utf-8?B?akxIUzlJSnY0djllZ0lNSDBDdFQ1VEhjSitBR3JkeGRnM3krdys1c3ZsU0FW?=
 =?utf-8?B?L1pWa1dZYlpoZm14ck5kclkyRWRWZ1pXSXAvSVJYQmNMdlFFZ3lJSXV0NUlI?=
 =?utf-8?B?aXg3dzhmS3Z4NHA0aThZYStXTzZzSUQwRkRtT0grMnNlUlE4UDdMUWJOcFhD?=
 =?utf-8?B?YjhSM25qUG42aVlUY3hoMmdQckhZOEtyM1M4c0FiM3FUK2l5dDVXSitadDU1?=
 =?utf-8?B?RzhoOEFWNG9ncXZlZHViK3QrWEg1OFRIQU5YK0RmKzQ5SFlHeWxiMFFSRmlD?=
 =?utf-8?B?TnJxWnVWVVhkV1JZQUR5dTFLTXdSUVNYaEhWWlFaditsblRsNHYydEdHdjV0?=
 =?utf-8?B?UCtkaTdFVTBLMFBZdjI4M0JwNEtIVENxMmVtT2V3RUdHdXhaTllsK2NlcnZL?=
 =?utf-8?B?Z1YxeGFPU25xRDg5TTVCNjJ3c0Nvc1dEOUF2ZlRUYkgwMGJGaE1KWFljcGdH?=
 =?utf-8?B?M2REUWcxUkptMlZaUzRsL01sTjAzL21CMWVtSjBvMWpzNDFUOTVMMGx2TFpu?=
 =?utf-8?B?eVFLd0w2M0pjS3gyc3ZJNWRxTVpKYzVZWENTL3hzdzJLcGp2VVVvU1BiZWNN?=
 =?utf-8?B?RmxJNUVqbFRVN0gvYWRIRnd3Z3ZHTnhKdlFWSjJwK20wVTFtTUVsZnhyTWhh?=
 =?utf-8?B?TGsyeEUzaEJ1bldhVXZTVDlCVHVqNUpXNXVhK2w1Wjc1dVhYMGcxejJOeGlG?=
 =?utf-8?Q?sDi1VpCG1YNUAFW6tl8KtyZXjX68pMDCk9uuOke/5Q50?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c249612-75b8-42b4-dfed-08de0a3d5d71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 09:46:21.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n57/V1eJF1FlJTzD6iq3u83ovVvjt/wom5KW5yQmmcwRyc08Nnbn+cB37jIP7vv9n23edrbuFFD1+YK44DwsHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650

On 10/13/25 20:25, David Hildenbrand wrote:
> On 13.10.25 11:15, Lance Yang wrote:
>> @David
>>
>> Cc: MM CORE folks
>>
>> On 2025/10/13 12:42, Lance Yang wrote:
>> [...]
>>
>> Cool. Hardware error injection with EINJ was the way to go!
>>
>> I just ran some tests on the shared zero page (both regular and huge), and
>> found a tricky behavior:
>>
>> 1) When a hardware error is injected into the zeropage, the process that
>> attempts to read from a mapping backed by it is correctly killed with a
>> SIGBUS.
>>
>> 2) However, even after the error is detected, the kernel continues to
>> install
>> the known-poisoned zeropage for new anonymous mappings ...
>>
>>
>> For the shared zeropage:
>> ```
>> [Mon Oct 13 16:29:02 2025] mce: Uncorrected hardware memory error in
>> user-access at 29b8cf5000
>> [Mon Oct 13 16:29:02 2025] Memory failure: 0x29b8cf5: Sending SIGBUS to
>> read_zeropage:13767 due to hardware memory corruption
>> [Mon Oct 13 16:29:02 2025] Memory failure: 0x29b8cf5: recovery action
>> for already poisoned page: Failed
>> ```
>> And for the shared huge zeropage:
>> ```
>> [Mon Oct 13 16:35:34 2025] mce: Uncorrected hardware memory error in
>> user-access at 1e1e00000
>> [Mon Oct 13 16:35:34 2025] Memory failure: 0x1e1e00: Sending SIGBUS to
>> read_huge_zerop:13891 due to hardware memory corruption
>> [Mon Oct 13 16:35:34 2025] Memory failure: 0x1e1e00: recovery action for
>> already poisoned page: Failed
>> ```
>>
>> Since we've identified an uncorrectable hardware error on such a critical,
>> singleton page, should we be doing something more?
> 
> I mean, regarding the shared zeropage, we could try walking all page tables of all processes and replace it be a fresh shared zeropage.
> 
> But then, the page might also be used for other things (I/O etc), the shared zeropage is allocated by the architecture, we'd have to make is_zero_pfn() succeed on the old+new page etc ...
> 
> So a lot of work for little benefit I guess? The question is how often we would see that in practice. I'd assume we'd see it happen on random kernel memory more frequently where we can really just bring down the whole machine.
> 

empty_zero_page belongs to the .bss and zero_pfn is quite deeply burried in it's usage.
The same concerns apply to zero_folio as well. I agree, it's a lot of work to recover
from errors on the zero_page

Balbir


