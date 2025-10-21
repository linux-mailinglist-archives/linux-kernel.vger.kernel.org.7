Return-Path: <linux-kernel+bounces-863352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C7ABF7A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8C7422A51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE43491C4;
	Tue, 21 Oct 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="puqbbGl7"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B2347FE8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063698; cv=fail; b=AOGJA05PakD7DZMMLKR3XsBVhC6UGZ83UVvV7QUESLf0uACRFjtmgjhvzXnASk0b/ii5ecO2yHuTl8VX37xoniDdNrZ5Mm8AmNmAHchQLgMzNXejexfrVFxkhEefpcaGHkqQjxUCeAGEgvi4mKX0ho/1AYX60yJw8+BIq1IUHlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063698; c=relaxed/simple;
	bh=FV/JiMbfECa0PSruCETWUoLhx7T/679EegxsnBWqiuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SqLiKmy0vxwgc0wrszrf2cIDsI1LcG0ZPucindDz4JPyIxaEUDzN2VoAQhz+Q+en+3qVI3hzjnbHPvrDLuHnlX1BfYKrGC1bUneL8UfIXYAKYv1JLc45cCpyO+uFDSSCrSWUfGhOnMF/e+SXkRaa9gBHRPfyQgQTNpTrGVloczk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=puqbbGl7; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyuSD1csxr+oGug9jSggrSG/LjmGClFEWaAw5Li0ppo3Ch1R3s9EPPDQ8CCUKBvdHkURcd+h0mF4IVxwrN1SGqDrpt3G1evGiwTtj/A5CR8ejFh3trFT2ERns5nxJ+wZ+SC5Wbfq/EBQw+9epbkmZZXuaD2Eb/4eskY/MgqulpBINEk9K5mK0q9UMtXUDT5B5NeV0NFOUXnzAEb/aW6y+Fn4PpdIO7B8YvEh8tJCriYjqMnrtrzPOQzx6N2EwP1P6bI/3xudU21gAZmVcRooXszEpnW8qkOCA2SNl2oUIpHIdLhy79Knpa7/xs58r2Vi7rNUI/khT69Uk9JDEAYjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a5c0yRmho6PCj2F4fgLJucsRvGcFqFqORAPViH2gG4=;
 b=BW19sQDaigxmoveB7E0eJxkxIw/K9QwkMhAltnE/kAFM+htvdarq8clFjR/4eB2v13i09rsonIAvN0xegO49D8rL1uCxoGN3mHz3HIYikU6c1ldlJ6kyaeLhDl1BaBuiDIZ3NykZdSx7RCYxOFMRcEFndh30JmM2re4PdUepsuu5G318NUPCF2GL4RmFJtzuncUESo3dBsRxfO3PXzQ/A0GgS3tWg2+52nX3C9HjwnfTWsTZHtf3aWfXHldbO+X/zq4UvK25O4UD4Q/C46IfKkxiujCg+w63Xm6VOKve3cIIEMNYDtgxjceQxUcK5QzcEGY3Ch91hIIyu2gT2nz4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a5c0yRmho6PCj2F4fgLJucsRvGcFqFqORAPViH2gG4=;
 b=puqbbGl7bx9G3OoQM3T1O0G7fpev4rSL2+nQNt4vyCMmSs7l+OjSP9AvwL9VQWocS/XCstRb4HWWPz20bV6xfw8yM1Atu2v+2jymqsEW4NpYjweJDaTWCpyDVZyVcdqjqkmlMy+dxvVUz641s4AD+z7zacegaQvU4Qn9KaJWtgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 16:21:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 16:21:34 +0000
Message-ID: <ee113455-2a1d-4b1b-a5be-bcd3f1bf3c19@amd.com>
Date: Tue, 21 Oct 2025 11:21:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't program BLNDGAM_MEM_PWR_FORCE when
 CM low-power is disabled on DCN30
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
 alex.hung@amd.com, daniel.wheeler@amd.com, roman.li@amd.com, misyl@froggi.es
References: <20251020230934.387745-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251020230934.387745-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:5:15b::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: e046feba-4d28-4dc4-4bb2-08de10bde6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Lyt5a1IvN3l4aVczcXVRYlVrdUE5eWZhdnRWMTE3aDJWdFYvVUxOVUJSVkhG?=
 =?utf-8?B?c0hoMWpxNUlXekFtajBDQkdIK0VTNFpQQXFBYzlreWJ6MEtITWdySnp6dE1J?=
 =?utf-8?B?a1REUjBxQm5wMlhBOTk0UGFidnFBVkEwL2N1RHBTWUY5dm9keVpSb0t0MXZB?=
 =?utf-8?B?M3J6OUFEc3V2MkRhYnY4U1ZRMGlEM1VFMHB3WUVGL2tMYTBpSGJ1ZXJVVW0x?=
 =?utf-8?B?cENIYkpNMEZsUWR3RXZzVnNlTHpTbzJhRHRVbTE3cnBIbllWSEhLUlpWSTNH?=
 =?utf-8?B?VWhmZGp3ZmJXczhaUHRvL2xtSlU1NzBHWmNuWE00bWJkZjgrUUxFeXdvUXdX?=
 =?utf-8?B?TE9PRURlMjRaZFk2eXlHdVNiclF2eVpla2pibEdGSWMzQVpTWnBqdHQ2VlFB?=
 =?utf-8?B?WDdod3ZhWThVTyt0alFPcWlWeDhZdEE0R0JtOXloZE44dWNMYk5oNnNIZzl2?=
 =?utf-8?B?RmpFa0U2aFlmZnVEYWM2TExZSU5EcG9Bd2tYTzVyS1E4WG4rSGo1MmdSd2s2?=
 =?utf-8?B?dnd2b3lBWWJGdnE1V214bk51SXR2UnAyYmgyaHFpL1NvdEttRUhybDR0VWJs?=
 =?utf-8?B?aG15bGNERzhwcUZEZ3hpM1o3anVnSlV5MHR6RHJFaWYwR3BQWG8wRkVoOEpY?=
 =?utf-8?B?QzBpS3V3dWQ2NGFmbmt0bHVwNVRyZlVaTHNXQzV0dVVJbUxwS2tSdmpSdmI3?=
 =?utf-8?B?ZlNuYVB5SnpVSkt0aEhLeWNnd3h1eGpvY25WTTF6bXRxaGkrOFFlanhQSDgz?=
 =?utf-8?B?TG93LzlQVUZXVlJqalpUcnpscWV0VkdDZGRSMnRaTmZKQ09XZEZwVno4NHJY?=
 =?utf-8?B?aENDOXIvekcvYk1sMElEb29Ua0lkSGtGTUlrMDlFZW1IUXVNSEtPOVNhbkNr?=
 =?utf-8?B?VnZkYVQxbGlSbk5FZG9oamdkL0tXZnZTRGVQQkxxYitnL1lrWHYreWxoWFJZ?=
 =?utf-8?B?LzNsUUJYQkk3cEdnTHdFNlcrS1Nhazg2MjBDb0tjT2VmbHA4WUFab0M1ZGto?=
 =?utf-8?B?ODFXeTdiUmhSOHNXWGRIRVJFMmFDd2FrUmlBbjI5ZmRxeC9mUEl1bXkwRUQ2?=
 =?utf-8?B?d1daa2J6TnJodmthTU9RNUpMejJPdTFLT2FDN0FJY1R0bU03bkw0eEZCODFC?=
 =?utf-8?B?SThrbWpKLzFUSEJ2Q1MvcWU4Q2pFa3JpdkdlUEtGVndabHYzYkpPcUhTd3ph?=
 =?utf-8?B?c2Z2R2JScFE3aHMvQ0VDSGgvZHhBa0pKeTBocHNsUk52WEFINUZIY0FQNFVR?=
 =?utf-8?B?bjlGRDJQdjlLYUFhOElaa0ttNkg0dVdlOXR2QUx5SHllV01lelRaZVdqMDlT?=
 =?utf-8?B?bWJxQml5M2lsNHpXdmNuOG1xVUowQkh6dVB2cW5VcW1QRU9QTDg4ejFKeHFU?=
 =?utf-8?B?K1RzZC9aNXIrMlFRSXdoSjF3Nk8za0oxTGFacjZyU2NSN1B5cHRQd2EzUktv?=
 =?utf-8?B?allFdC9zYStQbnp0ckVZQmZhMDd1eldNc0RYQzFEMHAyR0NuaWo2dVZHY2Iw?=
 =?utf-8?B?ZTMxRUZMQ0Q4dm9qMHVBOXFyNjlpU0VZbG5qWjM1ZjZOdzJzOE9iL2JTaEc4?=
 =?utf-8?B?RkJhZVlhdkJYdGlmN3R4RC9IenJnNVVRNHgwM0QrZ0IxMHNjRllQTjgzeGNm?=
 =?utf-8?B?L2xzSU5wYlh5amJRYTFKOVdvVXZsTDd3SHFkQjhLNlNJVldEdFhRRkdjUTM2?=
 =?utf-8?B?Lzl1MjZLKzA1SXhqdzhwS0JHeERoTERNcE9zR0RVa1ZzMXE2Y01abFViRVlQ?=
 =?utf-8?B?TkI5MS9wcHdYU1RoR2l6QXZQcXFhZU1YUkFVbUZuUWhyWTRWZDk0WFo2azdy?=
 =?utf-8?B?WTBkUm5QeGVGTXUrSUlQOUdNRjdYL3pJTExTOTR0RDNscXJLTzhyOVVlTWln?=
 =?utf-8?B?Ylcyd2N5Ui9Hcno1SVY5elNwR01jWWMzS3R4MGo1MnlBTDZjY1ZKVUZXNmpM?=
 =?utf-8?Q?u/ecZzwiHiG/pcoBJpmcl4V+BcyGjk6u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czh4WVU2QzVGdnZYTUN1cXJlaU5BYjdFdlhNd2ZITW5Xb3Z2T1g2MGRXMEFE?=
 =?utf-8?B?QlBNZUhpZG4vTHh2Ui9HZFlrWndDdlRnNjdJeDhEeDhhUDJCeFRkWWlLc2hy?=
 =?utf-8?B?bHJmdXozakNoR0g4T2F5UlROcHRhMG1Ub0gvN0tDdUgvM3hNV2ZJM1N3dStz?=
 =?utf-8?B?YmtsV1hpemFQanM1QnZlazZ2VzhXU0x6c3FlU1ZNOG1FSGY1NmNoSGo3eTN4?=
 =?utf-8?B?eUZWTmpzZGZOZFNkb0J3eURLL3g5YVlGeDlqVk51M2JLbHZISVZ5S25nQktz?=
 =?utf-8?B?Qmx4VUFsMUE3MVFIeXd2VHFOdXkyOVpXQS9CUkNicGEzN3Jza2hqSUFXYmJ5?=
 =?utf-8?B?bzZaNXUyUXJCK1Y0b0pkUURTZVZkQU9XRTYzMEFQWWEzUWJSMldpSlFxeDhn?=
 =?utf-8?B?SnY4VnBnZ3lhc3Jta3VjemJMWWtwdjU3dkpOQytUekZMTXR4S2lld1ZhQWow?=
 =?utf-8?B?YmY5bHc5Zml2aTh1NzM2MTdwS2d4Y1BFZE1CNmI1T2UyK3hPTy8rdllMaXhW?=
 =?utf-8?B?N0U5bzJEVUdtUnJJMVdIQXBURm1McmtSQXdKZW5nbGNXTHllOGc5SDh2UzNK?=
 =?utf-8?B?ck1Pd20zaS9FZ08vdTdoMllUbDBiY2dRQ0NxTmtGKyt4RG1tOVQ4UGFnb3hU?=
 =?utf-8?B?eXJPYTd1dktGcVBBRlp6Um0xTEQ1OG9yZXF5bDdmM0xkOXlDU1FvVGZ4YW5D?=
 =?utf-8?B?cVlKekRUa09BMWdNMnlwbWVnb2Z0WThoTzBsWitxVG1uQld5bi9NL0VjQW05?=
 =?utf-8?B?VkxTeVlybW54Y29XTGRHZzZvdFZwMVJ5d1dVUUF4ck5LSzBnQkpTN2NHOGtt?=
 =?utf-8?B?ek9kMkNBUmVoNjRqSStuMVBXOHZxNUU1b1UvSFZIeUZwZ2lpRDF6c2xqNi9D?=
 =?utf-8?B?RDMvLzFLeElETWgxSjd0SW4vOERKNGg3bGEzbVVueGE1TmsyM2NiREhwQ2dU?=
 =?utf-8?B?dytMVnVXSEhOeDJmM3I3cTVla2M3NDAya2pFTG5FWHhSdENYTE5QNGtKejBk?=
 =?utf-8?B?UHpXUWo0QzBHOVNzMjhiaDh5ekwxbGgvNlBuYjIvaGNpYVZUQzhzMjZJY3lr?=
 =?utf-8?B?dXlteG5kTFdWa0ZCQzJJYXVyOUtBbVQ5TWRWZXdMbFNvMUZpS0FwV0sreGZ3?=
 =?utf-8?B?a04wT1FnU1owME16WDZuL1JoUExrcDRJbTRSQkVmVEtUMW9VNXM3Q1JJWWg5?=
 =?utf-8?B?bm83L1BsVUJLS1Jxc0U4ZFc5aytLY3JOSko5SXlINFh4MzVMWWEzVlk0eFZB?=
 =?utf-8?B?SG56cU5hU0NuM29VOE1SeFkrVHRtcU9uZjBHNDd5TFZ6NUlldEg3VkZvaWcw?=
 =?utf-8?B?OFZHVy9DcUZrcHpaWE9YRjN1cmNEek1Tek11RXJGd2xrcnY5MURsMUpXSEE5?=
 =?utf-8?B?ZENHMUJuczdsQ1BJU0JEOEJPMmRjNVJGM0RCNkNYSDFFM0FmTEZHL2wrWThr?=
 =?utf-8?B?bk4vcnlJQk1WWjVYcmNZZCtjRVh5VmdJcnd2ZmF3UVRLUW1HMHpZcjQyYndE?=
 =?utf-8?B?S09oUGVZVlFleVZjVlVlaTRMUm5vQUZUTi9TMkpxLzJnSFVZTUVIK045MmFS?=
 =?utf-8?B?ZlliK0hSekZxY1IzNEJrOVJrUmtlb0ZnUU8xZHIvMStjbjNXdnpmU3dxWVIr?=
 =?utf-8?B?UHJyWXNRbmxkUVZQZncyaUVEeC9UQmpwOUUxTnIzNGtSamRnL09lUzkwbWcx?=
 =?utf-8?B?RFA3MGI2cGpXREtzV2EwZEJRUFp6UiszeG9XSzczR3pJSGxtUlo3bGloLzdl?=
 =?utf-8?B?SlJJaHdUd0FKdElRaTRmUkdwVXN2Yi93YllCSzY1ckNaOTRBbisxK1lZVDhN?=
 =?utf-8?B?QUFnTUE0V2o1Z1JmYkpHMVFvREZhazdPTXpvTklBcVhDTGlvcnowQlc5QUJR?=
 =?utf-8?B?VUhCMk0wS01zdFRpdjgvNTFJanRSTXpTSE1yR2lMaVpocjFzQ3RuL0NrdjRI?=
 =?utf-8?B?TVZhWlYvem52dzQ0VldHSVM1OXlKOE1UK3FIQ3FxaHVrd0QvZjhJcGJwc2Mv?=
 =?utf-8?B?bkNkOE1VQ2VYRlFmdWdlaXBLTlBPeDRNTU5nYVBSQXBPdTJoeE5NUklRaVM1?=
 =?utf-8?B?NWw0WW9wYTVrekhOaU9aTnhsaGJobldaRkx0UkQ2eFpWS1JjU0dtTWdCMHdT?=
 =?utf-8?Q?svi5IzFLmro04nyWjRlXg4ulw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e046feba-4d28-4dc4-4bb2-08de10bde6ba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 16:21:34.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLdD+BMQgd00k0jSJlv7dPRLAt1d7m2FtGNtYdwwBE+pq/BQQJPawpBxWkoNOytqbcB9y2XDMUtuiqpp4WfdUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251



On 10/20/2025 6:09 PM, Matthew Schwartz wrote:
> Before commit 33056a97ae5e ("drm/amd/display: Remove double checks for
> `debug.enable_mem_low_power.bits.cm`"), dpp3_program_blnd_lut(NULL)
> checked the low-power debug flag before calling
> dpp3_power_on_blnd_lut(false).
> 
> After commit 33056a97ae5e ("drm/amd/display: Remove double checks for
> `debug.enable_mem_low_power.bits.cm`"), dpp3_program_blnd_lut(NULL)
> unconditionally calls dpp3_power_on_blnd_lut(false). The BLNDGAM power
> helper writes BLNDGAM_MEM_PWR_FORCE when CM low-power is disabled, causing
> immediate SRAM power toggles instead of deferring at vupdate. This can
> disrupt atomic color/LUT sequencing during transitions between
> direct scanout and composition within gamescope's DRM backend on
> Steam Deck OLED.
> 
> To fix this, leave the BLNDGAM power state unchanged when low-power is
> disabled, matching dpp3_power_on_hdr3dlut and dpp3_power_on_shaper.
> 
> Fixes: 33056a97ae5e ("drm/amd/display: Remove double checks for `debug.enable_mem_low_power.bits.cm`")
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> index 09be2a90cc79d..4f569cd8a5d61 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> @@ -578,9 +578,6 @@ static void dpp3_power_on_blnd_lut(
>   			dpp_base->ctx->dc->optimized_required = true;
>   			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
>   		}
> -	} else {
> -		REG_SET(CM_MEM_PWR_CTRL, 0,
> -				BLNDGAM_MEM_PWR_FORCE, power_on == true ? 0 : 1);
>   	}
>   }
>   


