Return-Path: <linux-kernel+bounces-767813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58369B2596B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E05188DD43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC12459F3;
	Thu, 14 Aug 2025 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dF49u97b"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012043.outbound.protection.outlook.com [40.107.75.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF624291C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755137467; cv=fail; b=aUgqJ8Gq63cexI9/JlL1A06IxgjZhlNU4QHdvC+9V6kFgeZJSotD0nUbMe4MKuWasa7GA8swr4uUpwC7yr2NvuUC0lHlIgI6aNUIG8XqxZa7zk162lhSCrHp8JpA0lKWvLDabmT4C4la7SBru3AzRCrgk9PtRQjfL35GPMAapYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755137467; c=relaxed/simple;
	bh=ogdqfd7p60i4Gn5VqLDafMby22MG9kj2bFCfdsw9ch8=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=avI2wlCF1dK0uPqKq6//ijVe1ls9C6T6Aa5eOm5UazG4CaMOTsdLqNOcW9mav1NRuawiwtUocLjkStfS6+coxwyakBRuv0zX9QId3M8ZwHHkX38ahaMd/n6xFLfA6EmIcZw6OK4g4sQmxPLMuLfbMYPUX8kUney3Z+8y32QwATE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dF49u97b; arc=fail smtp.client-ip=40.107.75.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiY1poiyP3QM/o0mYImbPj90obTKqodhdEGPl8WkAcpzaVygIP3rjScuS1eA3ny3bHQq2N1uWDDyycFwsrkCp+f9FulCD60t3DUyx3+B80p7OFnU+yorvFcDhK7RuhPMOUwvgJ+FoMbby8ASyByL7+bSA0vEi8oDC+NKdLE1NcNbD0VR+IwmrKcBCe9pH8B/v4uOXe1TX6nBv4lh1tex2s7mBwgyFcv/Ns/y7t9k8tQsX4BBrKhYOhhoZecsxJJXYVlb3/NeYfrVkJ6i/K+OmBpERT+4gzXn4eMIVWBXkVJj9zgwgOZY0ovej8f3+3aMFpLsLJCOlQMLNqUCvdu5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19oC8GR11FlZuiFBvJsvQk6t6N4elzUFGi7RBsy6K2k=;
 b=AhNhv/1oBCzmVPFtAzoiLL5+efalMXJFq0WBvDqjv3MJ75BfaCvVGiwO8cZg/cWOvmEn0DDTbCba6NpfzQtQJ0Ly7YbKZJffLjQQBgJoGrFMcmFDCwVc1iCQpmnE4GAuBefyQYRQKLdxjrjFcEXbP+g5RNsG/t7+qWxVUGvcBZ9MQi5J59FcGd020OInbYSYUicVD32hWGgGkWl8av4pM7VgQJoMYE4JL/1PnQde2054vWTx09Kpo6RWyKWV/RscDZRgqJIk0tO7UdAJJPxzcYu/8t+O8Pr8tjW3ESDHUs0KcOEHVLNNJziOzF2anBw3mO4s9EIFF4u/T2wHTpMjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19oC8GR11FlZuiFBvJsvQk6t6N4elzUFGi7RBsy6K2k=;
 b=dF49u97bBaXiVzd7w+7zGJk06sNT0nP7cMoyMyhqA5LTqT9ydWniYw3XHOWpVh7w5VNiHc7jOnR9++uk3xPzP1umnMIeZ0HWJ/WWdJlPCA1pbaNVPFBiIn9NQTZY4vekgR8tGBPwzFdNDgYLXrSj1+zqDKVKUUB2t1DiRls7PS93cufo8fj7/grclHnV71t9h83K2jVhno9qcwf+aUK6SdHQDXtP28XJYWOOG1DgkU6AwD8w6xPuub5YcFcd1sIz1UOkTgINc7YeXNdQ/Cmd0Cp5y+QNPOR+AwdOeqdPDVHmgQP421vxUHRxa3Z3wOnOGFktnnVux/H0QPhDNcrReg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7087.apcprd06.prod.outlook.com (2603:1096:820:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 02:10:58 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 02:10:57 +0000
Message-ID: <b2703fdf-0c51-43e1-8df2-16feb1d245d9@vivo.com>
Date: Thu, 14 Aug 2025 10:10:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maple_tree: Remove redundant semicolons
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <20250813094543.555906-1-liaoyuanhong@vivo.com>
 <qlw2pok75g3wx2kic5tn2wtb4xjz67po2m56epcx3mjhev6y4h@m2hmlrt7xtv2>
Content-Language: en-US
From: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>,
 "open list:MAPLE TREE" <maple-tree@lists.infradead.org>,
 "open list:MAPLE TREE" <linux-mm@kvack.org>
In-Reply-To: <qlw2pok75g3wx2kic5tn2wtb4xjz67po2m56epcx3mjhev6y4h@m2hmlrt7xtv2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c52e55f-e4bd-4364-aa50-08dddad7ce90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1c3NnJNRENGa2lyZEo1aFN1TkNvOURwZmYxSTVLZnZvSDFqZmxpYllqb0dm?=
 =?utf-8?B?UksxU1pOS1hJRzB2eVc2dXNuQTZFbUtiVU12TEZVN1ZBTlNRbUEvT21OOEdo?=
 =?utf-8?B?aEZ6Z3Znei9SVi9vRkdSMHd0U0dTamk1SUY3aGFYdzBKKzI5eVYyQjhTN3Mw?=
 =?utf-8?B?ZnA3QU1EUXNoVjU1YlVLTnlhSndkQnR5SGhwRzd0elI4UFBuN3FiRHJFeXJI?=
 =?utf-8?B?U3Y5TXBBcXFtZkZaWnZqMUFuV3lRWUdFWlFkS3hzKzZpODNxelNQQk9oV1F4?=
 =?utf-8?B?YWFFd21Lb1RDSllST3BvZkd1M0RYeENRR2JjaGxwUGowekZmeFVjNFZvbXNG?=
 =?utf-8?B?MWd3WkVLanU5Mnh1NGpzeWo3aHJXRTA3U2h1RXRqcVpZZllMam1GVmYwR0ZT?=
 =?utf-8?B?dHg0UjFaTGp2WnVVY0VaUE1GdldBaUZuWkt1QmlRcldSUUUva0VPb0FWL3BX?=
 =?utf-8?B?U0pJQ09FQXczYnkrUHVWbUQ1U0YxUEZicm0yMDE4dmFPNDVGUk5yR2J4SWp1?=
 =?utf-8?B?MW1Yb0dNVzdObXhZVEplWThtNnI2WHY4UXlSdVdsS3FmRThZV2gxTWxtSDJr?=
 =?utf-8?B?a1EzUXdMK0hFMWVlVXdrck83eEpuWFZTRzFLSDJlV1lMMzJSMlpWRHRzV2NU?=
 =?utf-8?B?MWxVWE55Yy9KaVNKczNCZHF0QklVYjhrUFdWUWkwVHRIS0ZtNm91eVZFU2t6?=
 =?utf-8?B?b0QxVFg5ak9wVFltVmlYLzlVR1EzcVI5UU43OUFsUzhDVUkzUFRxTitCSWNQ?=
 =?utf-8?B?NG5EejBpSkdmZHF2U1ZLbGRpQk5vUFdwQjEwVXdJaGRrajh0ckdndEdNN1Vk?=
 =?utf-8?B?ODNtMkVmZHppakZ6VHE1ZGVhMmhpaWtaZWdaTjJ5SWJZNjl4dy9nLzA4Z24z?=
 =?utf-8?B?NDBwQ085VC9jUHhYWTJ0L0FRUlg2SytLR0czenJLd0hHMU9lYWd6cVMrVmpi?=
 =?utf-8?B?d3R4RG1XOGxOcTg3S3d0aEFlQzJ2cjRkVVJPM0ZMTklZcHkvSHp2SlFOT29u?=
 =?utf-8?B?bWowUXRHKzlBYTJJTUt4dmNJQi9TeFpuaHF1SzdYNE83aG0xaExIWFg5Nnpw?=
 =?utf-8?B?aVJzSnJNdDdFQXk3SnVvdDFHRFNDVkRiVEZtM3d6R2NBSUM3WmlOR0s3aE9w?=
 =?utf-8?B?YkhuRWN5Ymc2SEVVUE5LWHNhWDQyWWw0N2ZVQVNtVm5uWHRBUW8xRHR5RnR6?=
 =?utf-8?B?ZmFyYnppTXpySHRxanVjUy8yaHNFUlFDQUNuMUlvdWVLbGhCa0YzaXVHNWhO?=
 =?utf-8?B?SEZUY21EakkvcDhLT2NMaUFQZ1J3RndQckY1ekh5SWE2c3gvaGhDR3VzSTlk?=
 =?utf-8?B?a00xb1BxTEZDS3JidEpIUG1HRXNsUVdqNnh0UGxuOEFFbEZvSUhSZnhDczFo?=
 =?utf-8?B?TVFCTDJjNm9XK3hxTGRVdUJQdnVXa09PRXVpQkRiL2ZPYW0zTERCL2NOYVMw?=
 =?utf-8?B?RFkvYzJlSWttdjlic1JwYjBydkVEN0RkMXZrakp2UkNZSWNVTjlDaU5lTUZz?=
 =?utf-8?B?cDJ6NEpCdTh1WlA1bWNEeUlUMFI5RTkra3h3S2VsTmhvMTN5cHJWcFFHSUNH?=
 =?utf-8?B?ZmtwUmxzVVc0QzVRMVhlRFBCcUJ1Yk1oUG93SHZyNXJPM3d6eHFyZkxRd1Z5?=
 =?utf-8?B?QVQ3d0FxOUk2MlFCall0SG1aM2MwdzVRWGVGdVRxdFVNTG5mUGVZbGhybU1w?=
 =?utf-8?B?cmRYY1E5RnN1TkJkMDJVQ2RtbU1uSmVkWjdoYm95Rkk0Z1N5TGVqYTFjWWgx?=
 =?utf-8?B?VTlKTW5DclhiTzY1eTgxdzNiT1dUTHg4ckdwTDJzU2t1T2phNk0ya3ZxL1FN?=
 =?utf-8?B?NWVUNHpQMHd4ZFRRalZtNUpHQ21yYjg4cmVNUXFSU2NNaDVBdzMvMzdld28y?=
 =?utf-8?B?ZlJ0bEJ5REluay96eVp5aExFNHZRZU1qdWlWMGFJWmxlTnhRbWgrbzZMTEpj?=
 =?utf-8?Q?28PGuwm5614=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eExyRWhrUHM2NnFCWXZ2d2pPNDBwWlNEOC9KR2x4WHZxTmNES05FMFl1aEpw?=
 =?utf-8?B?U3duQjhzQk5lSTdOaDI1cHN4K1RaNkh2bFhUNEE1NjVlRTh2REZyejdtV1lT?=
 =?utf-8?B?aE1YL2RiZjNmeUpmNGdVZDV2cEdzSW9qVHRBMzc0RTV0TThrY3gyS2Vub2xJ?=
 =?utf-8?B?SThOVDNSckhhajNhNFVQRXliTnY5M0o1M2MxVHc0TzNzcjVMdWlPK0x0WnFq?=
 =?utf-8?B?SFVtaXhaQzNVTE54UHE4c1JiUm1sa014RlNrTS9zVEkyRTVlcWVybFIwdklU?=
 =?utf-8?B?STN5Rmpxblc5QzRtekxKMDlmc05mNEVnNDRxVTVvcmtxWWFCYVE0ZGZIVTc5?=
 =?utf-8?B?YnV1ZUNrOXYxdVhBaTJZdnh3T0IyVHVhT0VuTGtpWkpua2RON3dqSVJ0K2Rq?=
 =?utf-8?B?cXU5UmY0c3QvbjZXT2VhYTVJZXN3bVNNcDg2a0YzNW5CVUJOejBaUmlDTDB6?=
 =?utf-8?B?SldiUjN5aCsvMUZHY2FxN2dJcXdDTTRGRGpRRDhOclVjcEZnSjNrMFJEZUdx?=
 =?utf-8?B?c0ZYQ3ZqSCtvVWdabFFhL3M0ZU0xNUtHejZ4SDB4aHN2UVhBU3FkRHg5Tm41?=
 =?utf-8?B?VUU2c1FPUjFtSWlzOGNhS1BCYjlpNGhuaWtrMzNYMUhzRnVLTEh5aWkwdVJo?=
 =?utf-8?B?eWdzb0d3djh6cGVTOEdRa0o0RlJGTGtKSHVGdDFaYUFzbDhqQzc4YkxRcHBR?=
 =?utf-8?B?YUtLejJ1a3V2eUxnZ0FoTTZsYUZZWjlNSXMzN2ozNnJrbGJYZGgxKzVOSElP?=
 =?utf-8?B?WTQzcFovanpQM1YzNGtqditabzZZbVlreG9QaTlEakd0YVNBRVJDV1E3eTZS?=
 =?utf-8?B?dFJwMU45MXVXVjVoVklWcXlNSFhVNEZUaXJrcTUwbVU0ZFpiMitCazZTODdP?=
 =?utf-8?B?ZGJYaml4QmdFenByazNsa09NUmx4aWVJS1c4bUNuQkxML09wcG43dExQeXdM?=
 =?utf-8?B?aHhvUDZjQW5tSnlxQnZ1T1hEYUlCVGZ6cHRRR1ZJYlErcVNJOWpSU0ZOK3VP?=
 =?utf-8?B?WWZ2TEVZTVFwVFBKaDlVMVFNVEcrUHNaVmdmU2RmcDJKN25FbFoxWW5Mc1Nl?=
 =?utf-8?B?YVVhSnVML1NEWHo0UVk3ZW1vMytrWWYvTVE5a1EyWk9yVDdZNmFNRDY2OU10?=
 =?utf-8?B?OEd3YmlpMWVpa3hsWDFKL1M5aUpXalRxOTBXK3FOZGsyenEzU3o5Q1pZOG9Z?=
 =?utf-8?B?TFdMN0pCeXVXT2M3WVR6VXFvTlo5VTVVaUg4WUJYd3BYRkVIc0Q2aDdyUTZm?=
 =?utf-8?B?VStNaGNVR0ZQUkc5Qkk1RExEUDF5dU9tWlczd3pybGlHWkRIVUVTOGVNVW9y?=
 =?utf-8?B?WUhxWUg5dFp0cnhBcXBjSG5ha045L2U5S0Q2QmY5NmhhVzhQak9GdjlJR0NB?=
 =?utf-8?B?RlpqMUticHo4U1FhQy82TmZyQ3hib0lDODA4akhWeE82cXJmelVSN2RQN2Jl?=
 =?utf-8?B?ZTEzWGt6ZVcxbndqalJMQkhLV1c1WGZmanpaVXBjclBHUXZlQXVuQ3liQzJN?=
 =?utf-8?B?bmFLNmIvckxTd3BOVWptOUlpSFZFOUpjZDFFOVo2WUt2a1pqQWlvWVE5WlFT?=
 =?utf-8?B?UDkvL1FBR1crS3JBTzMwaWVxcWtLNExYZ2JRdnVFVlowdDcxMUFoUjlYaDRG?=
 =?utf-8?B?RXZaZHBjNVI1UEw3NndNOFpiaVRWenBrSUxlYVdXaHROTnRURmtuaUV5NkFV?=
 =?utf-8?B?VTA5ODdiNkl5SkJ0UndEVTRCeUVmNGlEYkNTanI0RHczdFY3ZmtIcFFJV2NW?=
 =?utf-8?B?Sk1hcHJOZnJlbUFFazdnSnpGUEFWSGd1bmRtdlFkY3d2Ty9UaXk0SEMrMCtI?=
 =?utf-8?B?WGtiNkxxOGt1ci91dnhMS1k2WnprbFVFd3hHeFBGVy9CVnNPWlZ2TFVzOVNH?=
 =?utf-8?B?RFNNMTRObkZHOEszMFl6dW1XRXRLQTlMekxKaXQzL1NjLytnbkZUWDlzSEF4?=
 =?utf-8?B?bTVhVzNLbFdieVlpWHZNbzRzRG12R0pYY0VKT0g5bnFyKzNCTmY2MzZyaWNt?=
 =?utf-8?B?RU9NRys0bWJqQUYvaHJNNmFPeE1BS0YwT09GNzhNTE1sSkVQemgxdGFBWURR?=
 =?utf-8?B?Q3c5ZTQrTjFta3AyZy9BMnNDaWtJR2UwWWRNeU80c2h4bHI2SHFTS2x6K2Rk?=
 =?utf-8?Q?OwJoOw/Ckgs+VbkfgiIuCTcKh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c52e55f-e4bd-4364-aa50-08dddad7ce90
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 02:10:57.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WBkIwQp9uuiFIO+mQKe0BoEaTsj5GxzCFOzrHrRuPeBxlHSjBOy7f8OAsn8N/Gjwu3PeAF/kHWsUsnHyKeQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7087

On 8/13/2025 10:02 PM, Liam R. Howlett wrote:

> * Liao Yuanhong <liaoyuanhong@vivo.com> [250813 05:46]:
>> Remove unnecessary semicolons.
> Thanks!
>
> One nit, it would have been good to state that this is a test code
> change in the subject.  Usually I use "test_maple_tree:" or something
> like "maple_tree: Remove redundant semicolon from test code".
>
> Please mention test in the subject next time.

OK, I will pay attention to similar submissions next time.


Thanks,

Liao

>
>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
>> ---
>>   lib/test_maple_tree.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
>> index cb3936595b0d..1433ecc854cb 100644
>> --- a/lib/test_maple_tree.c
>> +++ b/lib/test_maple_tree.c
>> @@ -3562,7 +3562,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
>>   	MT_BUG_ON(mt, mas.last != 0x1500);
>>   	MT_BUG_ON(mt, !mas_is_active(&mas));
>>   
>> -	/* find: start ->active on value */;
>> +	/* find: start ->active on value */
>>   	mas_set(&mas, 1200);
>>   	entry = mas_find(&mas, ULONG_MAX);
>>   	MT_BUG_ON(mt, entry != ptr);
>> -- 
>> 2.34.1
>>

