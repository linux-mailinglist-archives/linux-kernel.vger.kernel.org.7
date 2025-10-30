Return-Path: <linux-kernel+bounces-878141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F248C1FE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EE8189BDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13333358A2;
	Thu, 30 Oct 2025 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="fvURbuhT"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023105.outbound.protection.outlook.com [40.107.44.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF762DEA8E;
	Thu, 30 Oct 2025 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824978; cv=fail; b=PfgPDxRtpu4hsia/cFsLu4d5L2bB/mVmQS+qwZzk92Oe2PIhVClOqPU3zXoCFV9QIApmx1LTy8bPbNTFG499gqSB6PNWmy3pgaOQ7AZeWQLgzTWHN/EHIRhYVVgru4J/CxkNfXXPEwuwkzV2P3Z/JPGQ2r/PDYQ2XC7YO3NvF8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824978; c=relaxed/simple;
	bh=uEyxHv5M2/q4wwsZoKxlqOgXBBokhUrVGr+//1dd6bs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a9hYEN1RwCDTMxd/r1y0pdekgYP6osvRUI1ryJMy1+HFB7pWaRxLpzYlMdG9kEC4K5azf4G176A37qbe24u7ngBMcMm7gToXvToBqImO2HB8xvJxyKItoEEJ371dgX71uVV6a2AW9SquBf3KG3NyXK3pGHosip3bTjdgjkyKTk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=fvURbuhT; arc=fail smtp.client-ip=40.107.44.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlcjuyFjt4cVeQUaANaqyExhfKZB0IhjI9sO3wNSjHkYcG7oijLlzBNkFyMGRKv5s8ZlpjzyH6dmArSXhxJgYf0K4ZQf7awy7fV+PIp9hV4Qns/6R79mnhBmpCLA8lSP7L5/5aMrfyS7lwuuZ7uSYT0DEoZPFfx3Q01Cz0yytTEDOuT+rssc1HbhyLxm9lMj0V+uq6mHaNlQMP/1XtIWepEU8WwbCI9d4qXdefyKxzQSvtZPc3oxlto7aUGgKNCkwn3FQ06yZagm6nNfIL37Rp789Gg7mmKqAZ4I+Qflt+BfUpGNCkYWBd4fpJodseupbiBXWF48t8dyBczxvm9UhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WFHHXC343xtw8qw5ieoMEjM87QdcemwJG3ZncvL8e0=;
 b=fAzVRZqD543u1WdrRQ3i010+ckA9P7aEA9PYUicqQTmqO414YdQ2DvJr3P5g1r5kQHPM8fY7ISmnUpz7/ChFYpcP7JuQ8QEa6N5AzaVyTi//k+4MqoYX6p6RMP+SHD9boUsBhHYEsgewtwNuv7kKXo0FbS9L6tdfXfozRFwSybQyUchqU8XlMyk52kzPaYtd9GPnaK6+7qGoIfHL08sawO/f10NLel80aG3RSwaESTl2BuI/hXHU14hibRRZk5oRrwbEu/knNOc839rLx2sU5R2ls1AbqKdoH3qzO/NYCSfp+9ezHrnad6ML+rbNb2YoVMLDQxDVBSAsR0+CfMJ7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WFHHXC343xtw8qw5ieoMEjM87QdcemwJG3ZncvL8e0=;
 b=fvURbuhT5hj2K7dyNfOQTUxIgKbzLiTwOBzrj0JaCBanpxq7A778Ci2VkkPYivDbXAx3VCnjEhGOQ7ZTK3NoprO+Fqv77N0cYV5dvWYfAbXqCO11BPrSgMqyQMLFUA/Rlv4EiCVZsKBZWnYEb0+xi4pP+Ul3Rk5GW8XSqlPOzYLOJ9IbeIDBWzUG887h29rJDHfe2LqYMoYtH2yc1CrPTJZJnv1xk3M7LZ0uwaa5FedOyzVgHVEUmRkS0yNvulqfGoJ7oY1KNplpaih8plC4T/sDuD0Di8TyVLWPKsEl+h+ofPYIn9ekbdIIMCJB35obCzTYK3c9kS/l7CwTEqPBKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB6506.apcprd03.prod.outlook.com (2603:1096:101:53::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 11:49:31 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 11:49:31 +0000
Message-ID: <1dea766d-d9c5-4951-889d-9a4f126c7924@amlogic.com>
Date: Thu, 30 Oct 2025 19:48:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] clk: amlogic: Add handling for PLL lock failure
From: Chuan Liu <chuan.liu@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 da@libre.computer
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
 <20251030-optimize_pll_driver-v2-3-37273f5b25ab@amlogic.com>
 <1jikfwzt5x.fsf@starbuckisacylon.baylibre.com>
 <4f245c6a-5a03-4321-bbf8-61249a7a550f@amlogic.com>
In-Reply-To: <4f245c6a-5a03-4321-bbf8-61249a7a550f@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e118f5-7fbf-4c25-e5d0-08de17aa6382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDdHaThTZENUaHBwaW5NUUVkbWdnR0NIa2o1ZmpZb1FGMGh6MytNVVMxOXhC?=
 =?utf-8?B?OENWblJMMTEwYjRzWEVGdXdyQU1TSE9oYjN2V1NBWDhlR0JXZFYrUEExeGpO?=
 =?utf-8?B?ZXhlMXZQaFZ0ai9pRDVta3lzZFF2eDdMalBOdlhkTnNNaUQzN0RLNGpGbG9k?=
 =?utf-8?B?TERsdVNMbXFaOTRmaHBnUTRIRjJzMVI1T3FlVndLY2M3U3R3Y0VrWnovTVNm?=
 =?utf-8?B?SmQ2V090MC83YnQ2K1NlR3B1d2FibFZiMWZBOG9Ua3Rmc2hId0pySXVUUUdi?=
 =?utf-8?B?VW9ocVhqdlJBWDEyRzVzbTFWUFZJUVNCMlNiWk5nOW4wRm52TEJmSXpDR1Ay?=
 =?utf-8?B?bGFGSHJBMVRQMGRNZGFZclpRdHlnMkFUR0JmL2l0NnErREZ3dDVVZHJ4bGo3?=
 =?utf-8?B?M1N3Uit5clpMSUs1dkc3OHpFWExWL1VXVlU1MGZ0LzYxd2tBNFFiQ1BNMFls?=
 =?utf-8?B?YnhSOHEyaHZIc3JCTFZ3Z1lDZ1JtSkJkQyswM3NibG1UVVNqZVRtUG1vUGVR?=
 =?utf-8?B?SmNLQzU1TWZJSkFCWXZMS1drbVI0M2pIYWhDSWZ3WnNIU0RkMDFIZEdhcVUx?=
 =?utf-8?B?aFdFSXJkb3pKN3EzTkRwUkYzeklQNy9BTjkybUdyTHc3VXp0RFNxMEt2WGZs?=
 =?utf-8?B?M3AwRTh6Um0vT3gxMXNiWjcrbTAxdHlzeVM0T1JWQ2FMRVg2dGhRcFJBOHp1?=
 =?utf-8?B?VXhkcG9pc29XTXBiMC83c0czRE9lWHcwek5ZdWdOeDUzSWNoRjc1ck5LeDZY?=
 =?utf-8?B?ZkkvQzh5Skw3a251Q0lDeFM2M1BFdThLVU8vdzdJVU8xTVpSVEtzby9OOTQ1?=
 =?utf-8?B?amJBcDNhTXJSNWlrSGxZeXdEZ2EyaTJob0xqQk1GOURmQllZK0syZkUvTDNl?=
 =?utf-8?B?UGxwZXVtelNRWU1LWlRHTnR1OGliekdkalBSNXNnc01LM0dLRkRzNVNIeHRZ?=
 =?utf-8?B?c3BrMmlydm9QQ2g2bkpwQXhzc1pTaUcwZmY5SytjQ3ZGKzgzcGZHRkg1Vjkw?=
 =?utf-8?B?b3NYRnVOd3IxQW1KcGFhK3VPbk5tSWMrMit5WnZFSWRSbXJqblBPeUtYREZJ?=
 =?utf-8?B?NHVobVFsOXVYTUVjNm9tbktObXg5T2JyV2FzcC80Yk1lc0pKNGZqeHdNWHlO?=
 =?utf-8?B?dTVhb3NqMFNlaS9OcFgyMGlianUvNDc4Wm84ZU40aGg4Qm1yVTJ6OGRnVFpX?=
 =?utf-8?B?b0xHUm9KVWlqaHUrSWg5WUJwRlNUdlFyaVJBOUwzczJnZWYxZFlRdWJFc2lQ?=
 =?utf-8?B?Mkp4YWtCeVpsZjVNNlFyelZlYS96Qk94MExscUF3NWxsRkxDOGxKVHZPTDBm?=
 =?utf-8?B?WERIZ0MzSVB1M2Jwb3Z6Z1kwT0hndFlwbHN4NE9WVDVaamtFQnVYcmtDZnlv?=
 =?utf-8?B?dnE0S3hLVVVtUHdqRW41ZWxPVkloNjg4c0NXUWtOWjJ5ckxzdG5mVCtGWmdn?=
 =?utf-8?B?cXpqck45NUtlTGh5ck5tbTMwYVZHT0xkK3ZvOEhhL1E1M1pwTy9TK1FCZXJ3?=
 =?utf-8?B?eVE0aWlvOEhENGkvaCtwbS9PbDNqUEZ6cHZzSmwwN3ZWMTVPNFRzanNpL1Rj?=
 =?utf-8?B?R3BtMWtTSStsYjljemY4VHo1dWhaZzIrNi82KzdWSGJWTDQ3WkF1cnJ5Rkls?=
 =?utf-8?B?UVlUU1VNWnFzWWMxanE4d2h5RE9RdWwwYUszeXlDNzNyY1c5SGpvV0syR2xl?=
 =?utf-8?B?dWNyU1l3L3JmZ2hkdWpBMHU5d1RrbG1kNi9lWEZKRWM0UnNhQW13WEtmM3Nr?=
 =?utf-8?B?YkNjTTdZK2UyalJvUFdkb1BSYkJ2WVdlYU1PMWxwd0FjK2V2bmloSUxJU0Ez?=
 =?utf-8?B?cElsV2RQVG5FYytSb2NZdkhHVFhzQjQ1TjhNMGd3WCtHTGQxUDVpUlpCTzI5?=
 =?utf-8?B?V0FKQk5iM0Rodjk5MndKanRSTTNOQVYyQ2dCOUxUejBnTll5Q0hlcFE1Y3Nt?=
 =?utf-8?Q?Wn6EVXMinAdWi+YKhL3duQAx1kbE48JY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTBZakxwUjdFRWVpbndKWkxwKzk4NEJWa1M1eTBxL1UyNngzeXQ5N2lvQ2hB?=
 =?utf-8?B?cmpQUnJxMzYxYUUrSk9aQ0RaclJVVnZsYVFKUG9KUUQrRFpmTXBkK01pSkht?=
 =?utf-8?B?VkJkd0YrcVRqci8xMmR0VXhGN3Nzb3hscnZOcXFMRzN3T0paNnJuU3l6dGZi?=
 =?utf-8?B?OHVXZTRXOXB6bHdPUWVJOWVIUVl5MGhZNTdNcDh3MUdWWHRQZmk1WjN4eVI0?=
 =?utf-8?B?blN5cWhEU29FWkMwRnovMUxkWWhPSUNIMnRBZng1aUlmYkdsb09scURDOVF0?=
 =?utf-8?B?SEpCNkR4M3hiMFYyeFJuajBTZW0wYlVFaDFYOFhGbmhTK3cwVUh4UXR6aXE4?=
 =?utf-8?B?bXQ3b2xWQ29yM0tSSEN4WUpPSnVrQnZjcTlvZW9kZEJuNk1vc2FtVUQzU21v?=
 =?utf-8?B?Unp2S2VNYjZnY0ZrWDFDM2tTTXU3bkRvTWtHdGZ3ZTJ0STE1UENwZTRiem5Y?=
 =?utf-8?B?bUYvdEZGK1RhR1pJUFdCalN4bjR1b0IxS0kzWmNKNkd3YnFqb1BPaCtCdFQ2?=
 =?utf-8?B?M3VGaXNUWXJzcWk3OHVObE92aXVkRlhpTHErZ1RQTHVqb0ovVEMrcWFoTHJr?=
 =?utf-8?B?V2M2dGRFcTJLZzhneHY0enBaTWFkdmdSdFVoRysrWE0rWHlhQkZrbHc0TnNo?=
 =?utf-8?B?MHd6V01GbDBuY1dRMlNVdHJ0Q1Azb0VpdDBSK2xqRGZHVTZGK3Jsc3ZXVm1h?=
 =?utf-8?B?WXo2bCsraFphOE9xTU5vQzBKOWdTbVY3UWo0UlQwbC9Gd2M3dmZ3citqZ1RG?=
 =?utf-8?B?Rm5FTXNCbVMvdWN2cEt1MzdiZGlvRjg0MjYvSXI5cExkWmxaWUluQU1XYW0z?=
 =?utf-8?B?Y3RQU3E2Z3BBWmN3dk1wc2NKSmxoMVdtZWFCVUhBWDNBajRYZm9GM05CS09H?=
 =?utf-8?B?OWtYQ1dyYjJQcmFnaXpPaUVWdkc5WEhkTlNjbUNGV1ZYcVR0MzY5cFRDb1Fj?=
 =?utf-8?B?eVNGNDJDZWZ2V2pvVi9mSGJXcmVmRnR3cnFucHhRdkk3ZE1PUDJvMUt5RXNs?=
 =?utf-8?B?NjBLZ1pvSEZiME8zRWNJbVVWTEJ5d21GL1VRZlhkaDlEMG4yMmFVRmJpalRI?=
 =?utf-8?B?R3dITFZVcndaMEZUU2VzTGxNY1lWempGKzFsaURkUk4wcEpoOENZM1h6TW11?=
 =?utf-8?B?Wno5YTJRVERTVzlvSlFDeFJpaW9MZW1QOHNXR2dKb0htQ2RTTkRzVnZrZVI1?=
 =?utf-8?B?bjBYTDZkeDNMSVpHT3VmRU1RaG5GM1EvOWxMODIzLzIraVdsUnNlQmVyVmxa?=
 =?utf-8?B?aWFubHNxQnVwNkRGUGc4MzdmNjJjOGorS3JaQjZPUmZEKy82TithK3lWSG03?=
 =?utf-8?B?M0hBRFFOYmVPNG5MVlA1VHlvUmwzNVlnZk56QUx2b0ltY1NGSEUreHMvV2h3?=
 =?utf-8?B?OFJwd21sWHkvcmFmaTVEUjdkQkt4bk9EbVg1LzFKa0c4RTNSRk9ybU1uemlG?=
 =?utf-8?B?Y1ZpVW5zR2xHbXFNUFlOT0NWNW83QnVzRkxsTW15SmRYc2dsbDV1U2o4d1dw?=
 =?utf-8?B?U1I2QlBnYVE1cFZBaGFTdEEzYVl6V1VlaDRVZGNPTE5NQy8ydUlQcTlTM0Jo?=
 =?utf-8?B?VS9wQzhlZ3lZRWV3Sk1BQzZhektXRlptSXJKR1U5OXEvNjd3UHhWOTFnRXB5?=
 =?utf-8?B?ajlMYzRQbVNZTlFsN1pRbkNqRWMwendHOHBPUTM0UWZ6dUxKaitkYVhLbzht?=
 =?utf-8?B?dmRQcG1BUXZZb2hNcGxyYVhtQ3IvMUIxZ0hhWnUvb2d0TXRQUHVmTFBaUVhV?=
 =?utf-8?B?T2ZDRDJrb1Z6TlJxYWhuYmZhQXY2eVlJUFljWndqL0pVUUdCaUNtVUREcFF1?=
 =?utf-8?B?all5MFZtZ1dDRUJqcURwRkhoc0wyenc2Ymd0SHlac2tVbVRYNnBrQkNFR1dX?=
 =?utf-8?B?cnMyYmFVVCtxMXgxTldLZTZPSjA5REFOank3akxKNnp0TWpvSGNTNi8yTys2?=
 =?utf-8?B?cDF6N3UxcHVDUEd4TmNOcytYM21pQXFwWGJ2ZXNDbnlxSTl5QVZBZ24wVkpO?=
 =?utf-8?B?RVM0d2dkSlh2czhuT09WSzRWNll1WVRPZXJCU0dlQTlMZzdJVGJuZjR3a2Qr?=
 =?utf-8?B?UGowWlJkejFtYkJ4NW5adUd5aXU1WGNnN3czSTAwdmFJc2V2SVpPeHhNazM1?=
 =?utf-8?Q?Kio1gA0wlwnK1lFltovyX/qzX?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e118f5-7fbf-4c25-e5d0-08de17aa6382
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:49:31.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnZc2wagSCntsclpg2doT8XeNXY0Iu/C6c2uNRQfWeJXEjwtsWcEBb0PnmmMr9lMRwCpmPAO6n0A2DJbneQxlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6506

Hi Jerome,

On 10/30/2025 5:15 PM, Chuan Liu wrote:
> Hi Jerome,
> 
> On 10/30/2025 4:32 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Thu 30 Oct 2025 at 13:24, Chuan Liu via B4 Relay 
>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>
>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>
>>> If the PLL fails to lock, it should be disabled, This makes the logic
>>> more complete, and also helps save unnecessary power consumption when
>>> the PLL is malfunctioning.
>>>
>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>> ---
>>>   drivers/clk/meson/clk-pll.c | 41 ++++++++++++++++++++++ 
>>> +------------------
>>>   1 file changed, 23 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>>> index f81ebf6cc981..6c794adb8ccd 100644
>>> --- a/drivers/clk/meson/clk-pll.c
>>> +++ b/drivers/clk/meson/clk-pll.c
>>> @@ -353,6 +353,23 @@ static int meson_clk_pcie_pll_enable(struct 
>>> clk_hw *hw)
>>>        return -EIO;
>>>   }
>>>
>>> +static void meson_clk_pll_disable(struct clk_hw *hw)
>>> +{
>>> +     struct clk_regmap *clk = to_clk_regmap(hw);
>>> +     struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>>> +
>>> +     /* Put the pll is in reset */
>>> +     if (MESON_PARM_APPLICABLE(&pll->rst))
>>> +             meson_parm_write(clk->map, &pll->rst, 1);
>>> +
>>> +     /* Disable the pll */
>>> +     meson_parm_write(clk->map, &pll->en, 0);
>>> +
>>> +     /* Disable PLL internal self-adaption current module */
>>> +     if (MESON_PARM_APPLICABLE(&pll->current_en))
>>> +             meson_parm_write(clk->map, &pll->current_en, 0);
>>> +}
>>> +
>>>   static int meson_clk_pll_enable(struct clk_hw *hw)
>>>   {
>>>        struct clk_regmap *clk = to_clk_regmap(hw);
>>> @@ -397,29 +414,17 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>>                meson_parm_write(clk->map, &pll->l_detect, 0);
>>>        }
>>>
>>> -     if (meson_clk_pll_wait_lock(hw))
>>> +     if (meson_clk_pll_wait_lock(hw)) {
>>> +             /* disable PLL when PLL lock failed. */
>>> +             meson_clk_pll_disable(hw);
>>> +             pr_warn("%s: PLL lock failed!!!\n", clk_hw_get_name(hw));
>>> +
>>
>> This is something that's likely to spam, so pr_warn_once() (if you 
>> must warn)

Different PLLs or different timing conditions may trigger PLL lock
failures repeatedly, so using pr_warn_once() might not achieve the
intended effect.

Do you mind keeping pr_warn() here?

>> and I don't think 3 "!" are necessary to convey the message.
>>
> 
> In the next version, I'll remove the "!", and replace pr_warn to
> pr_warn_once.
> 
> Some drivers that reference the clock may not check the function’s
> return value (even though that's not ideal), so adding this warning
> makes the issue more noticeable.
> 
>>>                return -EIO;
>>> +     }
>>>
>>>        return 0;
>>>   }
>>>
>>> -static void meson_clk_pll_disable(struct clk_hw *hw)
>>> -{
>>> -     struct clk_regmap *clk = to_clk_regmap(hw);
>>> -     struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>>> -
>>> -     /* Put the pll is in reset */
>>> -     if (MESON_PARM_APPLICABLE(&pll->rst))
>>> -             meson_parm_write(clk->map, &pll->rst, 1);
>>> -
>>> -     /* Disable the pll */
>>> -     meson_parm_write(clk->map, &pll->en, 0);
>>> -
>>> -     /* Disable PLL internal self-adaption current module */
>>> -     if (MESON_PARM_APPLICABLE(&pll->current_en))
>>> -             meson_parm_write(clk->map, &pll->current_en, 0);
>>> -}
>>> -
>>>   static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long 
>>> rate,
>>>                                  unsigned long parent_rate)
>>>   {
>>
>> -- 
>> Jerome
> 


