Return-Path: <linux-kernel+bounces-751494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B4B16A47
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBA43BD762
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95C19E967;
	Thu, 31 Jul 2025 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LuDM+TmG"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013068.outbound.protection.outlook.com [40.107.44.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0B19DF62
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753927106; cv=fail; b=Rh04894a1/wctNGhT5ZFNzxcFmV2W0+nbV8LPZvvjibugy68QO4cMUFj2JUJRx4qHnNhTDX82RIPdogtiW9iEq6wIQDyxs1UwITH86QHEDxU9GUzMeZxCVJW0YJ5VPXdnFksDPs02/nh3kI8zXxh0p6UQmCsrKszwJfUfHtSpHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753927106; c=relaxed/simple;
	bh=mOF0QHibSAO0GNDz6eKI9ZbSqfo7dVLSmUXU1s21RpY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/tlniVlNOlcisXKwalo7ImO3bEtj27068bJLBfRYiY4CGtjSWsVmc7RzCMYisB1h/+xRuU2b3xjPezWlPDcW9hOPIDAVVRXbSOc/ia5NNW8f09cmmQwI5mGVJl0Xf2FzuamiFWuInn73hnsqVkSFvUkVkQXDLI9aqg0S08Z3dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LuDM+TmG; arc=fail smtp.client-ip=40.107.44.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwIEsr7cwXvQqVIaBwyCIniKTLfz/GWpDCLLTIerdxJL8rHOC82BsijzUq5Er18w0F/vMFYop6QxD7T51fJgGlRhD8GFSD+Hze2xJ8EMg3CIPU4xTJdkVmgYO2Sif4DtDRPUPyk+gpME2pjCa7SWDdV5Zsqzrcf6qj1P8Rx6Vpzmoi70M7esL7WuX6V+VV8soI5C83biToYh9QX19eRasWAdBYzd3CyAn7d7uVpcr+lyrHkC4NjjccvuFr66VA7P+t1lCFWKNRp89fYpxBbVKEOKCmoXoxJaU1pm9qGR8CAbqgAgYTM8+BdylZjXRAd8LJsCYy/WZRdrMZmp+iR3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLizKTw7+yy6XUjbXo7/EEERHNOO5mmWazZ72l0oswk=;
 b=K6P8nSAm9m1WCBORwiLcSvTf5JiFhdiWRMNa71SeDbc4vJlO++tVQSKqy0wl3kcv4yJNGW+1AyXYYenpZSmQnLldXYKdGQl6Yaz07a59gHhNZvVDR/pXY1cvV/7mAYy3TFfZRj2Twx4qat3HtYbd25SyPQdwNicKM2UHaAk1Ff4jXcBtxHls6mWmInVbRKJNDiYemKU2rE51wugOPi+r2pxDChouZDM1eHnB7K2zHAizMS5mbQqTBsorHfwii4SrG0pzwkvcv1xsTc1NQYS5sswZpbQ2d50fX9+O8joiwAPSeXCIRi9MFrkR+EQjHboOO8cL1d2KxVOgaKK/Nucumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLizKTw7+yy6XUjbXo7/EEERHNOO5mmWazZ72l0oswk=;
 b=LuDM+TmGx4eACYH8laT3j7tI2h+G218Bfw8O4yKhgMp28mF9uh2jae2y8c7f90En9Zc3CJN1y3YWlV5CgNABWI6eXBVuRZHHOvFKYymO7m22bQJqp6HbwrNxHEEteo2sLqIClV5aEL5firDChnUsMwXlYfJJhnpkHTPlPQHJPb6BZLjbekqWnS1to5Dbfw2AjaWbWmPg+BJijAHz4IhEZ9uKf2XfXrpdJbUVSQqzPahzKXJGfnDQUSWLH9mh0hpv6T6KStsHW17BcSglZT5vIm4LioQ63poCzgHin72CyXhIxbfSSQaSPUK9Dgi5DZ4AtBaCrzBG+T26rquNq+adJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by SEZPR06MB5959.apcprd06.prod.outlook.com (2603:1096:101:e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 01:58:18 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 01:58:17 +0000
Message-ID: <d3ced6d7-4037-4962-a2d4-382af0aad4cd@vivo.com>
Date: Thu, 31 Jul 2025 09:58:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O read
To: Jens Axboe <axboe@kernel.dk>, Chao Yu <chao@kernel.org>,
 jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
 <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
 <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
 <b1cf56a6-d23d-40ca-acaa-07944140b1b5@vivo.com>
 <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
From: hanqi <hanqi@vivo.com>
In-Reply-To: <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|SEZPR06MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: b17bf882-6800-48da-0692-08ddcfd5b7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2wxNHZXUDc1YmgrT2VHciszN2IxWlMyZGtIREc5OFBmNGIvL0NReUx6SUVV?=
 =?utf-8?B?N1pvNk1zeEtTdG1SRllZRFdxZkphRTNGTkJYTVpHOEYvTEVBSlFSRkFDVHQv?=
 =?utf-8?B?NmZxQWFPVkUyL0lqZHdlTld0R0UwdGs5TVdwdkgrS0FJc1Bta3k4M21INzZV?=
 =?utf-8?B?NHZES284Wjl4UW1XZmY2YUxLdXRGSXZpRlNOUllTYnhFTlVGd2MxOTdpQ1Zt?=
 =?utf-8?B?NXRpUWFKU3JLMzZ0L1lHQlh6ODhKTlIzakd3T2RMcXY2cVpEbDlQTmJGcENr?=
 =?utf-8?B?ekdXMTJaZGdnTjNpWnNTQldMUVppQ3E0OXJPTDFCWTZKV0w1cFNtamVSUVUr?=
 =?utf-8?B?T2dKTFU5Sm85YWxLM00yU01PamMrbE9keERGdVBGVC9zOXpwOUdvK3g5dlFt?=
 =?utf-8?B?eG81WllKd2JndFBWanNLWVpQaytFcTQ1TzdiQW9YOU13Ylk3bjhrTGN6ZEw1?=
 =?utf-8?B?VHphd3Zkdk1nNEtJMkZMZ09vSU5CSFJoRlhvSXdFcmNHazRDSXA3VUNvQll3?=
 =?utf-8?B?aVVRc1VJa3RMT3I4cmlIeDFHdkM2WFNXdlR0b3pJYkN2WWlRWkdzWXcyUExt?=
 =?utf-8?B?N3dPaFpWRHJNemFqRW11RmtUNnJwdjJPUGh5TVZCa1htdkM3bnhSNmxkMERW?=
 =?utf-8?B?eWlrbWN4VDdQd2ZqZnNDem5SSGxVS2JJZjlIdVd6Q2xLSTV5VURIb2RSUm5U?=
 =?utf-8?B?Ny9hMTVwYlF3TEtVTjJwU3ZQV1pqU2FTM2EwUmVUSmxFb045ci9NOTNRcy9n?=
 =?utf-8?B?OHBFbGhMMDJ6djQzM1NYOSswd2NtVTEzRUx6K2YvbkNlRTFROXIwVUZNVUpo?=
 =?utf-8?B?OUZmeGpQeDkxTVNVRktXbnloaUVCQWtFZUw0YU1IejJWMmZMSlpEMFdpTWNP?=
 =?utf-8?B?bGxMRVYyNFdTYTNuZFdIc3AzYkVHL2FyblhJWDJ0R0tkQ0hlWE41M3kvc3FG?=
 =?utf-8?B?MDU1ZFErRGZUQ0pvQWF0ekZJS1NBWDlISHlBK0FMSVRDOWZNRDFNUjV1Wmxr?=
 =?utf-8?B?YkFOanY3MEZVZXVTdDJhWDRoeVZhdUpJc2Y4NmpjbWh2NFROVU92b3YzSkdF?=
 =?utf-8?B?K1VNbHFkaWFzR016YmhXb3lDWFgwa0NhK0JHMi9wOWdjdXdiemlpK09EUVJz?=
 =?utf-8?B?MTVaNEJ2TjJFaE5LQ2NKT2RpZFB1YmViNnB0NFRjYXdsSDk2M3dSWmpGdGlV?=
 =?utf-8?B?Ym1pUTNOMVVQZjhSb3hVT00xNFFWcFJpSDh6cmg5Wlh2MUhVZDdZTkxybzJJ?=
 =?utf-8?B?Q1AvS0Z0WkdXMjRHWUcvdmJJem5QcWFBS0xxSE5IaDRoa2Y5Q0lLckhHUTJN?=
 =?utf-8?B?ZTNvT0NNZ1hGa3hrV091TWZlU0ZSczRCL216b3UydHNZZnRFMm5JRERzVkZJ?=
 =?utf-8?B?TDFWMGpPaHZBcFczYm55UTVKODNZTTJKa3RWS2tXZitvU2N3bUdtUlZBcGVI?=
 =?utf-8?B?YzQ0dG1KbzZiUnRhZVppYit1SG9qTUVVNWpyZ2VCdmhtRC9KeXMrZHVDTmdV?=
 =?utf-8?B?QlQxMWpGWkNnV0o0bWpaNzdTN2plOVlwd3FQb0p4Rzd0WWNSRzFlTnNERVE1?=
 =?utf-8?B?cG5sajMyWWtSRnhDWXc5MlZVckdKMDdTenhSMEpodCtwMnNWc0draVl5bG1J?=
 =?utf-8?B?SnU2MXp3b1BUUExWbzgrWG83Tnd1K2t4dDA0QzlwQW9adjl1NWRUMnBLUytQ?=
 =?utf-8?B?WlFyRVAxVmx5Q0VCSTdGNmxJZ3BHcjBOSlJJRFFtV2R6UHhaakhQY3NabkVq?=
 =?utf-8?B?OXhwRk5kNFNzRzRFV0R2a2NyOHRsUGVxZ2ZNbjllRWd5K1ZYNjhscFpaS1Bn?=
 =?utf-8?B?TXFlWmtFYjdaeTNSNnpmZXdTMVp1UTA1a3orcE5KQWg1YmJjSEhBaHkvTWN4?=
 =?utf-8?B?akhuanZkUXorSEFGYk9EVVpCRzZia3FVaWlkMVN4RmdIckdGMmtnRTZVeVF3?=
 =?utf-8?Q?YWGXHm+OId4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG1CZVRvbGZUUEhheVgzNFpQbXAxNTV2NmZQd3dER2NDQ09rcjZOUDNxQTJz?=
 =?utf-8?B?bVpPRTI5U2dIQWRvck9PWmw1dHFBSmhOUDhqakRZczNlcnNwK2JKc2VwOUVD?=
 =?utf-8?B?NnlIcWVRdE5kL2RJWTFnRjlwM2RSaUhITkRoY3Bib3Fmc2k3R29ja0VNY1Ez?=
 =?utf-8?B?bCtUdm5YVGVlamdBS1dUNFdpWlpBRUtjN0VqQVFGR2w2dlAvVFBkZDdDZmVx?=
 =?utf-8?B?Rno1VXU2YWFYZDB1UW8vclJTNHd0MFhWNkE2VjNhOFRERlZMd3ZxbTRLT0ox?=
 =?utf-8?B?c09YSTg3cFIzMnVkam51L1grcnBiN3FEdHJSVGFITjYwSDVlay93b29JWDFm?=
 =?utf-8?B?Z3haV2xTQkFDOHlHUkorZWZaQSsyR2M0K0lmTFVQdDFNTExTZW9lZEhaSm80?=
 =?utf-8?B?OXlwa3ZTTWJXSVpZWmZaMTFIS3MvNGJqSWNYckNRbXpjNWRveEdTenhVbktm?=
 =?utf-8?B?Z0RzVnphQW9JNTJaaEVwWTg2Mk1xSzV3Y0xmU2R6ZGljMkU4aVJvSEpzYmNC?=
 =?utf-8?B?Y3VVTWxIQzRqeWxDVFRXbG9Ja3BYOGtQbm03ZXB5a2NpeDJ5NVlPL2svcS9r?=
 =?utf-8?B?NS9wOWcxcXAxWXFOSENLajB0MkZlZlloWStMOHJjVWo4MXdrOFQ1dll0dEtJ?=
 =?utf-8?B?cXZmbnpEM1Y3YzRmRXM0a0UxbWgzKy9EdmxiTlJRY2VoUXhPOUJpSElacVZL?=
 =?utf-8?B?NkZrSjJQZFZVMmdnNjMwbGcyRVRaVERmVDBvMXMzMm1rTmZiYjNMSytoOFFP?=
 =?utf-8?B?ekZPQ21mMWtWR000d1JCaWRhOTJNeEh1QkJRWGFmeVpLbWZZQ2ROZldEazNN?=
 =?utf-8?B?OEcyVlhTM0F3Y0ZseTV4NUlGNXB5S2had29CckxXS1l0THIzTzlEN0lWTE9t?=
 =?utf-8?B?ZFB3R0RwcFNrQVJ0c2hSc3pPSGZJNFd2eDNJdHBBdUJPQ2pwL2JjYlRGSTJr?=
 =?utf-8?B?cWJjc0t1eWh1MjhwUnBpNEFDL3NBM0E0aEZQZnB2NGRhV1htQjFxOEpqYkZS?=
 =?utf-8?B?SW5hNUdwMlRQM0VhMzdhdGlKMEliRTFEZGlWSmZjelVFcE5NaVhEQndvNjlP?=
 =?utf-8?B?NHQrbUJKNzdQUjB6c0c0aVA4QzIyajBCcmJ1cEtVb2dRZ2xrWGV1Z0RRN0Ri?=
 =?utf-8?B?b3hkbWI2NENOMzA1QTBITlowSkVtWlI5WVhuMGhBTzg5S0NoQ04vQ1ZHeVhC?=
 =?utf-8?B?SDduaWhITGRNbDdqa3hubzJEYjk5K3BxbVNjTzFKaTRHbFJ6L2ptaW9Lb00r?=
 =?utf-8?B?OG5NeXJydUxiKzRBK3BQNEZKdGlzMGkxSnRpKzNFdFRvWExFaERBNDBrd0Zi?=
 =?utf-8?B?V2N3Q3BaNkhHT0tkMVNpUXRlRFBVcXJyS25taFlld1UyU1dpUW9ZQVFGZGFC?=
 =?utf-8?B?OHd1WGdNUW5aVXRmWGh1UkZXNWRmcCt4UEpPR2JJZmQzTkpHNVZ1NFc5bG03?=
 =?utf-8?B?TDYyMTBvNEFmQWZobzV6WmZLR2lzb20zU05mallRZEpkeWVFQ0VTOUVGb0li?=
 =?utf-8?B?Zjg0blhHM1BmdlhSeE81MlUzOGJkSGJtaVhZbExHbGxIZU0vMGxXSE5sWWI5?=
 =?utf-8?B?M3N0R0JWUUtIbDBBOXA0RUNjNXpQQmkxUlY1Y0U5MjFLWWVjQWFrUnVPTldH?=
 =?utf-8?B?MlpZdnQ2NVZHSFFEaHRqK1UvVFlGNmNlSXJDZGo3RHdkWHdYTE9VbVh2ZEJa?=
 =?utf-8?B?dzE5amgybGtpRFRXVzV3ZmZTNi9IczNWemZoVU11dmFBZVVTQWt0NDRPdzRw?=
 =?utf-8?B?VTVpLzcrS2VwTjNaMjJiTTFJNEk3dmNGSi8xTHZEdjA4NWhncStWNFRIYWxx?=
 =?utf-8?B?NUJxQ1p6b1dlZFJCeXhyZGp1dnA5MEdYSW9yVlN2Q3pqR0JYMzNQcEhaWmpw?=
 =?utf-8?B?cyszbkgvN3RaSEFHMVJoekNOTmszdzgyQzhtQ2tPUEJTd1o2cW9yZGFUNk9x?=
 =?utf-8?B?d3NpQXBuckNZcm5tS3hUS0xJMlJ2eUdTUm96YlRERndra1BYc2xUZlRNUHBJ?=
 =?utf-8?B?M0Nxek1XakYzdjVWT1plQlFDS2sweWZibXpCOGpZSGN4VFZBdWNKdmZzVHdt?=
 =?utf-8?B?ZUlMR1JiWEZBQmVORFAvOVBnaGtiSEt1UGNaM1JXMDVndUxSSjNFZkNIcmFR?=
 =?utf-8?Q?YEe5lOE2JbCn1XBWGXakqp4zF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17bf882-6800-48da-0692-08ddcfd5b7b2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 01:58:17.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVkPimv58Eh/RRXnaXLdyd/qOegRHCMdCFS/4A2JDskE1gm0tlM4ptCsO7LyEubwKMghdD1c2h8YOOMBk9jtBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5959


在 2025/7/30 23:20, Jens Axboe 写道:
> On 7/28/25 2:28 AM, hanqi wrote:
>> ? 2025/7/28 16:07, Chao Yu ??:
>>> On 7/28/25 16:03, hanqi wrote:
>>>> ? 2025/7/28 15:38, Chao Yu ??:
>>>>
>>>>> On 7/25/25 15:53, Qi Han wrote:
>>>>>> Jens has already completed the development of uncached buffered I/O
>>>>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>>>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>>>>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>>>>> as Jen mentioned in below path, right?
>>>>>
>>>>> soft-irq
>>>>> - folio_end_writeback()
>>>>>     - filemap_end_dropbehind_write()
>>>>>      - filemap_end_dropbehind()
>>>>>       - folio_unmap_invalidate()
>>>>>        - lock i_lock
>>>>>
>>>>> Thanks,
>>>> That's how I understand it.
>>> So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
>>> you can walk around for write path in this patch.
>>>
>>> Thanks,
>> I think the read and write paths can be submitted separately.
>> Currently, uncached buffered I/O write requires setting the
>> FGP_DONTCACHE flag when the filesystem allocates a folio. In
>> f2fs, this is done in the following path:
>>
>> - write_begin
>>   - f2fs_write_begin
>>    - __filemap_get_folio
>>    As I understand it, if we don't set the FGP_DONTCACHE flag here, this
>> issue shouldn't occur.
> It won't cause an issue, but it also won't work in the sense that the
> intent is that if the file system doesn't support DONTCACHE, it would
> get errored at submission time. Your approach would just ignore the flag
> for writes, rather than return -EOPNOTSUPP as would be expected.
>
> You could potentially make it work just on the read side by having the
> f2fs write submit side check DONTCACHE on the write side and error them
> out.

Hi Jens,

Thank you for your suggestions. I am currently working on modifying
F2FS to handle the dontcache unmap operation in a workqueue. I expect
to submit the patch soon, after which F2FS should also support uncached
buffer I/O writes.

Thanks,

>


