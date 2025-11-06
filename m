Return-Path: <linux-kernel+bounces-889264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A57AC3D1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0083A908B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C0350A3A;
	Thu,  6 Nov 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iIPifqcv"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27C332EDD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454825; cv=fail; b=Pebk9uAdRe5+nzqCh4QcZsi2yFDywexhJb8LW16fS2smMq/Q4Z/xcIYvGDUlItPXdooixBKPQb3X2gdxmJ4zikM06c7CsEqkZa5kk7H8RmduR9ZjVrtqcB95MBxtsPRND9DpGc42/fBSKI4CoH6bSntqLTw3wbxzYYabwPhtUwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454825; c=relaxed/simple;
	bh=WsPZC/+A615Y80JpMygveuIALyMWbS+aHlVtVYOpOQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JORJyQIDfDgnHJrwEiT+gg3qFOev6Hme+poUmUSv5K7IazYeqlofsFnsWAsKkQpRq3yzLbe19apax67+R8HxXbDx8f4A/t1oUNQesGKeECfhLyTiZ1W3V14bmFYjlnpln/hhVCQT8sYvVI3ojouOemELN/ng/Bmjm9rWEGx98Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iIPifqcv; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW/HtdUFrx9y6gnYcG6cPSahdFj6QmOUlYn1FmIOZ6paH1QaenhJt05GebIByLEhwVR0Qlm5BJiqKUMAeo72eWaHRfXFSkTvoxRt7/UgG/FAMFxV12oBUzjUnK5sLfnd1nPDMQS4ugwODezz9oZFVzXqX8X8mCaK1Y+f1XV8BPwfcT/f45Ln+ghVChvqVROMOcoJBoNuW5aIGVCRKydn1DlihcvnLwZIhj87wZJTjqdbZ1yg+jNXmHZ2c/1Rr6DRd+6H/wFPKsh2cfdOwSEUTFjNPcFUdhF9cM6FGhNm0GU/jk3lfzES+aPxiHnDhAbTcO3mS7fAt6bwLhL782lbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3TWoANhvlL4AJKNA97zuUue+qSZP4Kj4v78zsNGQ7c=;
 b=FTsvcMnljOL36kaYRjHD9YPYYBr1Y41b068WBMjAKIl0qp5qHX8zlm1xJE01RzH0c04QbW0C8LgLaXJklfNl+hHqXOcdl/uxvXjYfbKveDDdK+3o5jIMxo3h9mgb+tsh+5gn8pLwnlElAuMziTScZbOUXwQwkaAkmNSD5v0ZV/+4Vjbi/3S0igpzlBH30Eux3p2Tr8SlWmPYKRfMj0bECOuPiztl5/x9NQEGAJtwvntz6dtDYeBp6HyOG8lqAfsJ5S4oVohul/AiyTypAiS3FqrN/55NxfvPAVBQ/MhSX5gNX6URSsOWmil64x1DxYBVtV+VvXPxnXtznD+4svsJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3TWoANhvlL4AJKNA97zuUue+qSZP4Kj4v78zsNGQ7c=;
 b=iIPifqcvg0oOjEkdM5RFSgXoqM+pYFSGNpkTLItoVOH0ssBJiawjrNJBV05iEid9I6RslfZXHKM4nl+e9BWyeWkzFMfnPkPX5ogoA0pEvz5TaGdvZ2qQ0AA8qHm/RWFc75mc+Ku1Gp0yvf3pT0Ywx1oqb8JcHoXjbp5syFWoK24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 18:46:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 18:46:57 +0000
Message-ID: <a6063bc0-4ba1-4cad-9045-5fa31ea4ed7a@amd.com>
Date: Thu, 6 Nov 2025 12:46:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Ensure isp_kernel_buffer_alloc() creates
 a new BO
To: Sultan Alsawaf <sultan@kerneltoast.com>, bin.du@amd.com,
 pratap.nirujogi@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, benjamin.chan@amd.com,
 christian.koenig@amd.com, dantony@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, phil.jawich@amd.com
References: <20251105232108.107765-1-sultan@kerneltoast.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251105232108.107765-1-sultan@kerneltoast.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:6e::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e0ab4f-62de-41e4-e2be-08de1d64dcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWxNeVk0MlBtQ3pYYjdZa2FoYSs5K2d4NzZUNmdxaGEwWlI1bjd4bEdFSUxX?=
 =?utf-8?B?TGFIZzVCRDBhUTZrSXZJZXNHZDJTbEpiZGtuMUM4NVZBVXNDK1NOa1VUT3d1?=
 =?utf-8?B?cEU3QVlwSTVCeFJEWjhudXdIYTdtM3V2Q3l3dWVXR055K1N2YWpINE00Z0tx?=
 =?utf-8?B?QUdnNFdEdHRlMEZvRVpQK1ZZdmNPU3VuNDg1NStGdFhtcVUrVm42Ym01TDlL?=
 =?utf-8?B?MHg0SHdja3RnOGk4VjBJZ3JDVGdrYmN4bHlab3BmODFEWXFDSllESlhIOVRn?=
 =?utf-8?B?blpnazJBdmNSM2hHL1A0VTZpR0VKSVhzandxUGVKMGc1R0Z6RnhFeUZyL0Rl?=
 =?utf-8?B?dXExTW1xa3hXdUlsUi9CZVR2TlJuVmk1Q2JpSFhxekZMd3pUSlBic0FkTEI4?=
 =?utf-8?B?NFRDaFpLWENZeTcreXV2RVpGV0ZhaEJpQXhuYndzVGl6U0h5Vzk4a1o5Rll3?=
 =?utf-8?B?MXZCZE0ycjFHRXlmNWFkQmduUWdhNldDeVJzaTBMMm9QYTVRQklPTlRUUEky?=
 =?utf-8?B?K2V2Q242c2ZqZzV4Wm0rc0YwY2FTVVdZS1JCVGs3eFNla3hlMnh2RFUyRDVu?=
 =?utf-8?B?Tml3UXQ5bDR3YW9CZDNxcmV4NXM1RmhnK0JDaDNDaW9UbnkxSm93WHR1N2NL?=
 =?utf-8?B?L3d6R3haMVRYWkxma2djU214M0FvRVgwQ25CVFlxcnJwWDg4OEFudFVHa1lj?=
 =?utf-8?B?RHJIeHlTWTg3Qnd2NlBRQmZOR1hDN1RwS2pqaUFKVjROMHlNNEJYVjJxRGhO?=
 =?utf-8?B?SHVJOVpHTlNQTWNNZm9JT0Njb0phbC84c2RFZ2F6Q0c1M08weGVrVGZVeUhi?=
 =?utf-8?B?cmVZU3NGQzF2ekRwTFRpL2dMNytHT2d5RkhEYTFiWGVicmtXTlpTSkNlazN0?=
 =?utf-8?B?V0syUXJFMmtqUjR1cy9vTEdWdW8rQmVuZURSMTdkT3Urdi9UNUk1ai9jcXZs?=
 =?utf-8?B?UFIrd09XYTlYTnF0WHF6ZE5oczZNY3lSOXcxcVZ2cUJJenhDeU9Wa0Vla0VR?=
 =?utf-8?B?aFc2dThoTVh0cGFKQXlhd2M3Q0NDWERUUFFVcXhjY3hBb3huU1ZJL1ozWkpX?=
 =?utf-8?B?L25BS0lTT1RWbTg0bmIzNmhmeFprcExMTjM1LzRqR29JNzlUNjJLcmh3ODhn?=
 =?utf-8?B?Nm9rRkJpVHJDMEc2ZEhvOThoRGlXcndlSnY0YVR0c2hkVkpoOVl1dlFQTmZY?=
 =?utf-8?B?WEpvMXdZT0owREl0MlVRem5DUlA1a0czenVNeC9hUEVlUmUvNVkrV212NVEy?=
 =?utf-8?B?WWc3QjkvYjdLRktjQlU3UW1GYWY3OEZneURDMERhVEZ2emhvQnJTN3NBZmZl?=
 =?utf-8?B?bFhHZkhLQlJqajJpRC9RNnBjSjdsaWJ5bzUxTmdHdGdpZnZpc3NGUnVXanpC?=
 =?utf-8?B?eFVLN1liV1FJY1Z5TElSeDNvM2xjRzRmOW5NbEJVYy9VTmxTM2daTlhXMklO?=
 =?utf-8?B?d1ErMXdHbTNIYWRFRmxrR2dCUjRvMHE0SzNTTWVNQ21DRnBpQ1lXSTNsZjRa?=
 =?utf-8?B?Zi9SMjlhdEs5ZkZqa2UxN2FFeDRpbTdjMTZJMWRzWnRpV3Rmb1VSc2NZRlg1?=
 =?utf-8?B?eFRvWHpwSUJiZld1LzBmcnBDMlo1UFhDcjFmeXFrYkpCUkJ6UDA1K1FKVFVx?=
 =?utf-8?B?QkNIelp0MG9KWUd5MERxWTAxdDFFVTZHa2dkYlZnNVFPVzIvV1N4eW95c2E2?=
 =?utf-8?B?bjNYSFNiTXNvdlRRak1UcElCRmlERGUvQUxreGhNQXpoNFIvakt2VXFsYkpR?=
 =?utf-8?B?Q1RUeTNPeng2aUtvQng0WHhpYTF0VWRub3NFTGtEWldjeEd3QnZIZHhBN1Vs?=
 =?utf-8?B?bWp4bHBEeWxNQTV4MWpQMTQ2L0lhR3pycSt1ZzQ0V21LNTRzV1JoQWdGVmtj?=
 =?utf-8?B?Z0g3Njh1NHozUFhMWEpRWkFvZU9XeWhrREdSbTZ1NzgzQkRPQlZFc1RCbE01?=
 =?utf-8?Q?iS9qajeUEp9ZgFx3fdRXCnIimz+qk3Nd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2FuelBDcGU2REdsWk44NXlpOHZxbDlYTmdKQ0I3azFaZkRIN2lETFpZOGo4?=
 =?utf-8?B?VnNCUG4rYjBhTit0OVY2RkpxcFlrOHFyQ2FFazNaTVJvbHdlemNWeG5mNGp3?=
 =?utf-8?B?anZFZEhzc283QTJOaEJiMGdzdS95dG4xeVd6Rm5LemVuTDlSN2ZQYkJUdDFY?=
 =?utf-8?B?eWNZL0ZvbThOd1lIM1lRY2NTbndqU3V0VU5lZ0FuWWdlTG5jeERZTHoxMXZO?=
 =?utf-8?B?dy9HRjd5M2RkWWVmd3BWTXk3azg5QW9lcTJPd253ZFN2bU4wQzFYVmtZZDJV?=
 =?utf-8?B?MCtuWTE4bGJJVU9SYXdOSlJpSVNXNVpJY1lWQTV4R2VlczV2alZ6bEtmT0Vw?=
 =?utf-8?B?Vm1HVEt6TXVyWkEyd1pNKzRsdSttRENFUUZTdVhXQ29aSEw3NEpSWlpHVU1T?=
 =?utf-8?B?ZGFFL0EyZSs5ZDl6UENjdENhdzExMXlhK1ZIMm85Mkx6Y1h1Sk5Xbk42ZTdP?=
 =?utf-8?B?ZThJTVE1N0FDQlZiQ3Nna3NLYVBTZzB4UlRRakJxWllaRjJXMENwK3BjSzJZ?=
 =?utf-8?B?bWw0WjZYTHg0TkpqcEZhQmRsYzAzbHhHM0N3Y2hsWExaS29JWHJHMlJadWFY?=
 =?utf-8?B?Q2xCZlJDTk5LOWNPdmVPcWlhNEpQS1EwWTZhS0hwUHc0ZVpoc25wSUR1RWlP?=
 =?utf-8?B?aGFNM3dpa0xFUFpxQXFwOVYvVTZGVVlGM3BWK3dIbkphVGxweDlvQmJXZDdz?=
 =?utf-8?B?SlE5VUl6ays3L3FKdGRlZmYxZzQ1QWpEa3lOVEhBVFAzTERoSWhwTERVTU9n?=
 =?utf-8?B?SnFGcHMxYjR1cm16dVFhdms3aWV3MnpCM2piemNMK1ZwSE4zaHJuLzYrMWZq?=
 =?utf-8?B?cmlObERPd3R5U0ZOT1RwSUFyUnU0emNpeE9kVUdNcXYrV0EwelpBajNwZVg1?=
 =?utf-8?B?cGpqZ3BFNU41MFFTRkQ2R2x1K2dzdXdMV3R5bkdpT3laZlZ0R3ZOT2xvR1p6?=
 =?utf-8?B?Z2kyUGdPUzRTdk8xQ0VZRTFyVUVKOStqYzAxTEkxZUl6TmwrYlNEMm44R0hS?=
 =?utf-8?B?bEZVVkJkK3N2djhVZE9KVTRhVEJFWmY0UHdGQThIN1hQV0N1VGZialNQZHp3?=
 =?utf-8?B?Q3YrTTR6K3hJYS91WDdQU3p1YlBKckVrVzBlWXNucEhZQnhYdmJpMmVnSUdn?=
 =?utf-8?B?bnFhaXQraHA3M3l6ZFA4T0xxNTc4ZUtNT2lWcCtBR2ZVcXMyNDF4OVYwMmlD?=
 =?utf-8?B?SEhiUG1tVWJ5R1BFeWhUSHBtTHZ3KzREWWVqdGdtMXJyUXNYZVNDY3pSQ1kw?=
 =?utf-8?B?YjZYbk1VWVp4QlBWYmxic3VjZ0wzbXRBY3B0aDhmT0VwdFJST2Q2M0pvWFBU?=
 =?utf-8?B?SGQ1R2hUOUphOEhoUS9lKyt1WUMwajAwQjJWa21ZSWxEa3VBWXNIM2hmUGlN?=
 =?utf-8?B?NUFMbGlwMERUMzAwUWNLMHNzUTVhWHN0eThIdDNkREV4MHAzNGJ1ZUJMRXdy?=
 =?utf-8?B?Zi9mUGJicTE1Q1lDVzBhWHNWQmtTZWppU0hVdWdjTDcycnY1UmZMNkRqaGNo?=
 =?utf-8?B?Nm5lczVGMStKTDRxbFFCaXBZb0xqNThXQVc1SEVuNkJDK2g5VUd0Q3gvRVJP?=
 =?utf-8?B?V2dOcG00UHJ4WnRGNjBTTGNPLzMwaE5JbzVUV09mOGVUck8wSUZJMEx1QWNq?=
 =?utf-8?B?WVFTSGhHZC9aODdjZlJ5UHEwTzA4MzM0d3hwcjRhZ2Z0R010YVBRdnV1YzFr?=
 =?utf-8?B?MmtkQ3orYU85UnY0b2pVQVkzblZvcGcxRHc0NTd1YnBqdkV0VC81akVuc0lI?=
 =?utf-8?B?c1dqWWsxQkNpUGRSTzg4bTNPZTRVbEVEdXR4SVlqb3lVRW1BQVNMbCtBcWty?=
 =?utf-8?B?MEhGTnFkS1lJNHNUL29OYnFMTHp0MzNVVnlLNWhTWEl3VjgvYldOZGdCZGpU?=
 =?utf-8?B?eXIzcUlnMUhOZXkrUDFENjF1dTBxaDVXK2VkV2NncFpGM2FzVTZyMzQ3MlZK?=
 =?utf-8?B?azVJeXRCWVJDOXlEU2hKeFlIOUg0Z2x4TTJXUytxUTVqY05pdEI1YUtxYlBx?=
 =?utf-8?B?R2tBelN0OEtGZ3RzMDI5Q1Q5Rkd6L283dkx5ZjZGRHRPcWZFbmc2Q1JleDIr?=
 =?utf-8?B?d0dOOUlJVDN4djI1dk9KbzI3K0NrdVlqSEkxMXJTQXhvSWhyQ0l1T3NIdUts?=
 =?utf-8?Q?19VzTU/bf41q0hfbBhgLCbfxo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e0ab4f-62de-41e4-e2be-08de1d64dcfa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 18:46:57.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKp9obXyT4Im8BkyygCDFgYveo+FkU/KYLMfH2eY1txCRgRh7aNj/qCrbISRk/YmYn0uo8NRipLCk4LciBN2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

On 11/5/25 5:21 PM, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> When the BO pointer provided to amdgpu_bo_create_kernel() points to
> non-NULL, amdgpu_bo_create_kernel() takes it as a hint to pin that address
> rather than allocate a new BO.
> 
> This functionality is never desired for allocating ISP buffers. A new BO
> should always be created when isp_kernel_buffer_alloc() is called, per the
> description for isp_kernel_buffer_alloc().

Are you just going off descriptions, or is there a problem with reuse?

> 
> Ensure this by zeroing *bo right before the amdgpu_bo_create_kernel() call.
> 
> Fixes: 55d42f616976 ("drm/amd/amdgpu: Add helper functions for isp buffers")
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 9cddbf50442a..37270c4dab8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -280,6 +280,8 @@ int isp_kernel_buffer_alloc(struct device *dev, u64 size,
>   	if (ret)
>   		return ret;
>   
> +	/* Ensure *bo is NULL so a new BO will be created */
> +	*bo = NULL;
>   	ret = amdgpu_bo_create_kernel(adev,
>   				      size,
>   				      ISP_MC_ADDR_ALIGN,


