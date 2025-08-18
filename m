Return-Path: <linux-kernel+bounces-773765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC8B2A92A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB915A4C58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12178322C7D;
	Mon, 18 Aug 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p0E9/zA5"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013029.outbound.protection.outlook.com [40.107.44.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A1345726
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525433; cv=fail; b=nXG8KkIvPnrjLTq6M1GyYf8XR66WQxhk6tEc7es4CnSNmbsQhSZbE18kap1W0jYc7p9coS8hv9/fv6rMSmGxDlWMPeRAfZ8OP6ETFBcL9JKejgn1qccJSEg30qJywozRc6ojoVY3gro+dxcF/fX4M0uLOAvi2zIyeIHmuPZZXLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525433; c=relaxed/simple;
	bh=h7YAZN1o78ozsLNJBLs6UYywpqObjSCETVITr+cF3PI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wzn0x0cStnLC3vYWNe1SvnPG4OL/ocWkckgRaGlNXp3zN90s0revqb3ylOoKf0D4hYOMVhviiENiJb9Ygm/OuMYKGxpcNXAG0fPuX4EnXJJ8vWaQst9qdO8wkLoDKGKvUYb7t0scf8jiV0w8UBR+YAxpOCzedP/ur3QJiesmEok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p0E9/zA5; arc=fail smtp.client-ip=40.107.44.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smeOmCIZm5K77SzpfL5XGTOLs9I4aQ51T2+PxcD8pEmseFcb3lkPoS5b5aag15tmaq60/eaCSa/wMUx01pxFr15v352iQPr/zyhHWpbK+nWcwwHQLF/cJa2pUHY4wCPjtyHb3GfciWANFn7D2jSLppgGJ+RVtLO5Gh5smgaCt0ZgckmQXL1Qcku4cZkGx7yVV55+8Oa+WmEG3RH8J3bX+CwIPjs8SgiwAxPJfLzRvln9RO52ZQx3o3BPNtDvQ6VlYlCh9hPflvnwQM8CWuU+ssxFmSryJUyJRDKSr/c8XWrmwpLjFfFkVYBN3akW7v0fqmh+1oA3fk1BHUPIhBEAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXBYMiTfMWCMQ/fvwfcfXPqhnx72tbROfjbrWn751+w=;
 b=FAkVY/Hno/17x+WgdbOKo2DNUu0PAumtUl8Lfot7mUAo+/x959z6djJJqv8gAiLiAbi90igFCIl0wXR0IagIxgqjOkzX4O/z3bMLEQR1NTYK1KH9iNJbXHtFQ8Kr0EnysVHMH1oKUR7sLCukaw099nod0OZI9hjRTbtkBUdXB+u1DuuxUjbm4/O30/Ur26DG+gxrrP56J3qxmFW4+tT2/TMyedNuhD0iPUyJjnL3sXL7pctoLLBct4o1xc9TOdbNCB/sitIFZO8ZpA4Zr3d/nJV+/ynlFB82JdlilVoFSwYF6NBHPRea6OLAzNn/hxGKq65jeSA9mRBdGXeJ1xml5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXBYMiTfMWCMQ/fvwfcfXPqhnx72tbROfjbrWn751+w=;
 b=p0E9/zA56owkxbqRxWd5QE9O3H9sa7p9wNuswcuv4pz6xSw8sPAW7UjwDOx1nruPjJknmtxTid/f2givijs1gIyMwXB0FpnAaGOXf7LJDjG3CdBO0MiAcrUyNCXaV3Zr9qXgjkU/b+ConbT2VxOBBE43EOnBEXSqJrbX1HIc+z60ngVUZweL0Pn5EkFDZoNwITrjjyvRRFcu1sZxUoIgdvvKYcb9PyNka1dqYiIouv4YyGpAtK5DI7geTIdm6UliUamfUA0KEw0pod+VQU6WJmvVNZCeLgNw9n76tBY6elcYmykZhUfTPceB+gFKeBTxau728+PsvxQCxaBBj1/BCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY2PPFCC183E929.apcprd06.prod.outlook.com (2603:1096:408::7a9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.21; Mon, 18 Aug 2025 13:57:06 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 13:57:05 +0000
Message-ID: <51861587-3ea9-4d74-9ccf-81c174be32ca@vivo.com>
Date: Mon, 18 Aug 2025 21:57:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ubifs: vmalloc(array_size()) -> vmalloc_array()
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250817081238.44785-1-rongqianfeng@vivo.com>
 <CAFLxGvy0c=Ja6WBmpmCmqKMpe-AX5n3xMpuFiKz3JWOanrLqvA@mail.gmail.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <CAFLxGvy0c=Ja6WBmpmCmqKMpe-AX5n3xMpuFiKz3JWOanrLqvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY2PPFCC183E929:EE_
X-MS-Office365-Filtering-Correlation-Id: c96e6db4-d9f7-48d0-4ad1-08ddde5f1d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU80MHc3bDVUSmJVSUd2a0EwTElTcG5scFlJQnpzeXdlcEh6L1JNa2liY1VO?=
 =?utf-8?B?NjAwL1VRN2lNWUpBdWtFbzM1VzdUczQ2RC9ad2RIbUZnZm00d2RxZCtCdUhw?=
 =?utf-8?B?c0RiUTNsaVBQc0JrMVZQQ3RJQldxRVEzWUtpNjVFaDJCMUprYUUvbDUxT2xF?=
 =?utf-8?B?RHhvQld4R1dvVzBpNWtTdjhQbE9DUkJYRzVkRENGQ3Q5V0RjNUNQRTBTTWlt?=
 =?utf-8?B?Nkd2V1pNL2J5UjdFK3BLdXBWVWpNclJsWWdmMnZzQzVpczYzWVQ3anBUUlBC?=
 =?utf-8?B?aGljNHdRWDJtQ2JhK0FtdkFrYWZ5eHdRRnF0cWRUNnE1bWl5UlgxSnJub1VU?=
 =?utf-8?B?UEVYdkFCcjdVNjBMd2ZJWGFxWlowQmprQzQ1bTljRWlaYkF3Ti9HMUt1SXRU?=
 =?utf-8?B?SHpmdVdQSGlKaWF5dXV5VmZVMlcwK2VGNFBYeFlnNDVqUkhETHBWUDhLQmdB?=
 =?utf-8?B?dHV3OExGakhWUkc2d0swUWNrZTd5bG1ab3BqU1pFNXNZU3U1OVZYUUN0cXZF?=
 =?utf-8?B?NEpYdkQ3aldHcTU4WGpJbEFKWWJ4KzRNVytzK05qNUwvc2NhVnVsS3VXenps?=
 =?utf-8?B?Q1VKUDlLVUhaZU4yL2VxMFQ5cEZqcG5YNGJtRTRIVFRESW84WC9tQ083YkJV?=
 =?utf-8?B?ZFhicUxUb3RVRDQ4cGxLYmpBWjk3VlBjc2FKbGpBU2JuLzd0enBoNGhKZkoz?=
 =?utf-8?B?bVh5MEdISGpuRnNJb0pIZXByRzNIVEJjS2NRZlJ6bWtsZTY0c1dLbEdzQit2?=
 =?utf-8?B?aG4vbk9aTy9hYy9NRGp2dWw0a096a0NGM3lwVXVTSnBjaTRxSmxaK0l0T0xV?=
 =?utf-8?B?Mjg5bGRreUlqeXQwZXU1VU9YcXpBNTEwcitxL3RaM0VycE5UMEY2R1NIRHVw?=
 =?utf-8?B?dXFMT3JQUEhlRjFSUE9EZ1BMZTNRU3kxQmY4ZkdZUElJQjUxNFN4dDdObDlL?=
 =?utf-8?B?NnlpWXNteWVHMExVYjh2cGQxY2JKSmdodzV0SVRueHlJaVZxY2VNMjNMTktn?=
 =?utf-8?B?NHJOdFpiclRlc0lXcFNPdW9Uem9nVGlRR0dMUHJoZzBjdzBjb3hSOVFYQUlH?=
 =?utf-8?B?M0I2c2xsKzFSaS90dTFORldJbDhRN0F3cVc1SHFtM0N2bE1FN09RR24zNlZ5?=
 =?utf-8?B?SG5vRDVUamM3MU4xYm85WEZjSUZPcmFnNDAzUzNFeFZ4aHVmN2dFeHRqa2JQ?=
 =?utf-8?B?aStyNWxnM21oVDhXMVd5Y1lXVXRNMnVqOUpmMHg2ZmVSRUx3cmVWOG5JL2oz?=
 =?utf-8?B?Z2xqKzc1QmZUU1hIRE9ZTm9XU3VMY09xSjhlMEVrcWJZeXpkU2pzWTlIaGRI?=
 =?utf-8?B?VUpqVm9JOWN1RGE0TkZwM09VMG5KQ2hQSTkwNTV3YWdCTVQvTzN0MFZ4T2Nz?=
 =?utf-8?B?UmZNb3V3TXpBUEUwWWU4TWxpU3l2S3ZPWEhhUWhFSjk4cHZlODdoY0VKQXhQ?=
 =?utf-8?B?ZFcvQk1wZFh3VUpic0twLy9ZdlpyVThHQUhacE5Jd0pDdXNYZFFkdERWY3pu?=
 =?utf-8?B?R0NZTHpIV2p4Yk4rd2pkZzRYRkhFVmdWZ1c0V3NrM0hacTZZY0VOMXpGSWR4?=
 =?utf-8?B?OEZlbC90dkZNRjZQczF0M3BlWnlxMXpRNGxjYzdycGJaUzhPMlhZRjM0MUdk?=
 =?utf-8?B?Q2lWemhSMHhHd0JYMXdkL1RxZGhUVkR6YzhQYitSRUYzR3MyRzFtaDMzMnhz?=
 =?utf-8?B?TS9wUlZzR0hTa1pQTG12NG9sanFXV0owckQ2R25za2tiY1NWNDBDbzI0emFt?=
 =?utf-8?B?djd5MHRVV2hhc01lU3BiTWtCaVFlbUlTZ3dvZVM4N3hQNlZ1WngxZEx2NVZu?=
 =?utf-8?Q?34tweRJCU/IqTI2eEnkeGH0tVCSCyNemRV7zU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzJ6c05FY3dKcFdwV011Ky84aGZyYjIzS3U0VDFrT0J5dE10SC9yTXZWa2lI?=
 =?utf-8?B?eExzbU4yS1FIWHdvSnVEYXoxNHVpUWgxRy85THpzQmpabGg2TktINXM3cFZL?=
 =?utf-8?B?em92SDlWNnV4cHUyYmlmNHI0ZDZQaVk1L0Z2RXpza0VnM2xxSUlsU0JJUkU2?=
 =?utf-8?B?QlNXaU4wWmVNbVlYOE1TaWNTM2txWjQrRVRLRHpNdG5yUHZrT1dqRW5lcnND?=
 =?utf-8?B?bXFjbXh5TGJDZjNCNFZRcDVHeXdNa0dJdzNXQlR0bUtydzE0RWJnQkkwTVJX?=
 =?utf-8?B?SWt2MnZMRHYvNkNxTklHdlZvQTJBeHNVU2QvdWhYNlNLOXRuTUhvaFVuejBU?=
 =?utf-8?B?cWpkLzg5OG9aRytIK0VxRU5pRUpWZUlaS0tLY1EvYnpLWmlHZ3dhK2l0Qldw?=
 =?utf-8?B?QTI0SlBkQUxQdmZxSForMGJzVEJEQncrQ0labTdiU2tRY0xiOTBSK2ZmZzVO?=
 =?utf-8?B?TFVoUGt2REsvSlo2bUxEYm9jTXozeUtRL1ZiTUlKVWdpczc2aWxNZHBxTmRv?=
 =?utf-8?B?YTJTUlMwWTdtdkd6MjZkV2tJZGpxZFpEWHk4bmJ1YkJTcURYQ0RScVVZZzYy?=
 =?utf-8?B?YjZNYXdzbmZ0ZGp4NXhrTlhpZGtKbDJOR3M5L1pUSzdjQ09wSnNELzNSOHAw?=
 =?utf-8?B?aVl6YXBOam9hTE10L3QzWU5Edm14WURXbG5PdUJRVHo5emRvR1o5US9OR202?=
 =?utf-8?B?ODVscGxLS2pvOU9NU0MvcXRyNTQvcTVDTG1qSS9yRmpSVmFtUStHcFErYk9h?=
 =?utf-8?B?SFJaQUlXbnlIdUpnQUNhY3h3cUZSK3V5TkEybkxXVzFmdTFVQmVLZlFUVEhk?=
 =?utf-8?B?S3ZGb2lQK0JsNlM2THkyK1FsaFZiTWRUTm9VMzlZbjl4akpYRVpuMU1NSXQ1?=
 =?utf-8?B?YVRRTWZjOGFkOW1YSk1ZdkhxRStYV2kwK0xxcFJ5NWhrUjVnalNNd0JJRlpC?=
 =?utf-8?B?QkYyTkFaSk84NjJUK09sZnpXR3FLZURWTGsrUksrUk9PY1g5ZXBsb09ZRVl5?=
 =?utf-8?B?Y3NDdFh6THZtN0dkRFRwUDROZnE3V3E1cFlBK2tkellSUHZONTRPUWw2ekxF?=
 =?utf-8?B?Z0ZMMDNlTVlES3FzVlJqR2NML1dkRE8xblJUSFQ0OEFRWUJvb1dNeXhzbENM?=
 =?utf-8?B?WENuMnFIYi8rajdPYUZzR2xEd0xRK21SK2ZiNGtESjQ5RjdPR095VWR5RlQ5?=
 =?utf-8?B?L2FORkNPL2RpdnZFK2Ztem9iN3Rkd3oxanVuNVBHbnV0aEhCVVRlK2xvdG1q?=
 =?utf-8?B?VXFnTUhJZVA5Y1YyQjNBSUFsQytsTnFkZDFSeDN5QkhHZGVaanYzLzUza0RN?=
 =?utf-8?B?VUt3ZkVhMFBiU2NjQ0hKZUtRTmxHMWcvMDA0eVVWWDc0QjgvMzk5bWR0aVlS?=
 =?utf-8?B?RFVJdi9jQWlsWkJ4c2FsaGorRE9XdUxDNy8zSHVEZUtYOVl4b3huaElXM1Nt?=
 =?utf-8?B?anAvMjZIcWRHOEExTTJHNWVWOE12SzNHdzJSZzBkL01sM05ibW54MEU4T3Yv?=
 =?utf-8?B?bCt3VjVqWU5Xem1TdkMvTHA3aisvUU1sMlhBclRWS3ZZWHFsVmt2WVdlVTR1?=
 =?utf-8?B?akN1YUhJMGhMR2krYkROeCttd1dydDRYSXFUd2lnVlNOMGpHMlZFSkc1alhF?=
 =?utf-8?B?MzJkQndrSk4yUWZhSGdTTllVazdlUmJPdkVmaTkxeVFoUjN1Y29lQjRxSjdL?=
 =?utf-8?B?VDBTelFxMzZwSEUyMnNORkVGU2tyWm9wOUE1NHA0TUxpeVpFTlNQa1ErUXcx?=
 =?utf-8?B?NDZqZmw0NFZHVjhGRlU5UmJkU3Q5dnRqcEJtT3Z1SkxPd1pUUFpGZ1cybFFk?=
 =?utf-8?B?MFpUOGNlT2R4VlExYmJ5c2tWdGR4RzQyR1F6enNOb01NMFVpWWlyaEtML3V3?=
 =?utf-8?B?NFprQk92R29SVG9KYXB3QXI0bmNIM1pwL0dxSjN3OTJXSVFWMHlDZjFYUFdB?=
 =?utf-8?B?bTd3ek5wR2V0NTdCbGxMR3VxWiszQW5SNjh3QXRoVVpMdmZveWVuR3RkaDlV?=
 =?utf-8?B?TFZ3R0kvTDZFbHN2d2IzUFRNMVE4SUVNaVZQWHpUOWloUlcxUzJ2UXMwa1BB?=
 =?utf-8?B?TC80Vyt3VDRLYzluQUdXdnZoMHFldUQ4R3VoOStzb3JOZUNLNmRuNEFham5z?=
 =?utf-8?Q?Jrw7kPfgoiKS67ras8gXQJWuB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96e6db4-d9f7-48d0-4ad1-08ddde5f1d59
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:57:05.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vP15YMCl6QCOz1IjMVVFN9+xe1zxSDfDGiq2Qlqk1tKb3za+4t/LmmXZNX9rFWwYVw4ItYNAP4gjOjSne/KXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFCC183E929


在 2025/8/18 21:49, Richard Weinberger 写道:
> [You don't often get email from richard.weinberger@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Sun, Aug 17, 2025 at 10:12 AM Qianfeng Rong <rongqianfeng@vivo.com> wrote:
>> Remove array_size() calls and replace vmalloc() with vmalloc_array() in
>> ubifs_create_dflt_lpt()/lpt_init_rd()/lpt_init_wr(). vmalloc_array() is
>> optimized better, resulting in less instructions being used [1].
>>
>> [1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   fs/ubifs/lpt.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> Makes sense. Do you want me to carry this through the ubifs tree or do you have
> a distinct tree with all your vmalloc_array() patches?

Please carry this through the ubifs tree.  Thanks for handling it!

>
> --
> Thanks,
> //richard
Best regards,
Qianfeng

