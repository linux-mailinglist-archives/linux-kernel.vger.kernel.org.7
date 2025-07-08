Return-Path: <linux-kernel+bounces-721549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58874AFCAB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37424188DD87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8089881E;
	Tue,  8 Jul 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ORWXYrqx"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296D2DC331
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978644; cv=fail; b=YQ1evLyVtRzibA3BgtPJOqYvM1u3dMYDIh9J9pphojqyG/xZIZ4smi9CbVaR/KwtM5rXyzNoYa9ETymZstRx0Xf0dbLa77XuBZe+/893KNExGiypCJuDCFyu1zqRlsvcy6nOEjEg2/Tc+vahQzCBYUTu6EXTOQ+EMzv24ZjEf7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978644; c=relaxed/simple;
	bh=CtyyQO9BpLylPlJTjIIuTDGFjlV3JJcOPms/fj/WFBY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g+KyxgsypAYqeFg+tSLawlibo37HfGZxHw8i5T1Ukdyu2ZlRhUmvIRtboeZ+2wf1tAJUV1SSFRsrMoEjoq9MjTIvKQyX+GapQRP4PxeEu+qCeWc7yODLFqRUmZXSVGQLP8wVQZK0luYDDvU9q9MSqnUL7h8CGxPDETalCe85GVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ORWXYrqx; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCP5HeXqpOWHu82rXeJABNcWKxApOrICzRa0HgotFkJix7PzDzhOTtaaz8zUXyXu1wIqeHP7/2Pqpwy1p5qyapxOnlasWTv2NOy7P98KTrG+SulEPEyfv9+udmYJaXjnzabGErVALwyqV+MxLv574DkLIlBydPBvygylkIM/VaQjZwCNMKA+DVsJabBUIN6Z8/X9B7cUTgYYaFmHH6hsb7CFAxBgb7khSXdPfZ5Ymlm+5du5wdri7gRQE3P+/PExc/dFrQduBruQmS7X8Ep5uHv3d9VH/smF5UKUtUepuYsX0e/DnrGNAICLXg4rDGT+23u3cC1AidOtbP0Zvv7IGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tO9Wv1Vwkb/7KtWnbxYnxviQHtVeXJyJT2tGdHuAAk=;
 b=UHxBjx5UvkbinfXvPzFD+QAi4LiAzhQyGBstLXsw1JFqNxRCHI1Xm0QGKKDwRFkpv4h8DrHA48QVg2/y/y5RdDKlu+ylGVXQ0J+1FTSae1iVdB2rYWakT1JDKuJl9XqV2OxP3qsFVk+o7HL4BsIqy063HPRJZUmgbLuz1wcAr0XJARW6eknfOXklX7HkHuq9gwU6NKewcvUhVoJEdH5z/FhN7oTIAYAJvV5fI1uMfdWbjm84Nd2XK/NrEAYdzQ7eJE+9bouHyVflv2OMX0T132KrN+SH4jZijd4OjAVoXpwGPLpLbKmMTiGqpRQ+APAV9+8SKsYAuFr1tfJPg5FWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tO9Wv1Vwkb/7KtWnbxYnxviQHtVeXJyJT2tGdHuAAk=;
 b=ORWXYrqxryk3S+mUcQ/S/x9J7ZV7JAY6QMheGD7piE5+tHZRpm0q8l9euLfH9Q0ZFSoeTiIO+oFud0btMLB/No+jbXJKovSN69vrripAu5t3/X/ELg72kXo0VM3FZKDcfIjCMS0zcbcz1hiY3WveK/EOXa+R91omr2E4mr9lYSoJwxtzyxBRHV7pkd3Zotwk703+4o1lwCPuvgAaZKe4gpQV6ZAyYVWPsgx0DRU06uL+WlSG6ZKLhSsHlLFvbrvfcsY5Qq/URbM1rRlOb2EKsRYQywp0VU8pbn4JmIXX5Rn3Co44MYRUqjQHnMB89/9cDHKO1BQjJc71GdCDyZiYvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7760.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 12:43:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:43:59 +0000
Message-ID: <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
Date: Tue, 8 Jul 2025 14:43:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Executable loading issues with erofs on arm?
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c67bf4-4ca9-4dfa-b5bf-08ddbe1d1c4c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW9sVjZHNmpDT1FvWGFzRVpna0ZEaEJOK3owNHJtVHNXSEhGYlAyVHZqMkhr?=
 =?utf-8?B?MFI0K2dCR3NpZ2cyKzAvaEU1bm1NdHlDZVRIZVZZaTN3ZmJsM0pFUmxZKzkw?=
 =?utf-8?B?cUh1US9uRUZpL3RDWkFPZFU0YXFOT29pNS9najZLM3ZDbHQ3RXFLNGNCa0dU?=
 =?utf-8?B?Q0NCL2tyWXZRQVl1b2JZT2ZyR0NnMlduNGlObjcwUHB5SHdLQXJMZHFva0o3?=
 =?utf-8?B?ZlRjTGVGbXpnVGNvWDFid05RNVBkTHpZNXdla0RxTEowZ25FUnZzL3BwWWhT?=
 =?utf-8?B?OC9VeXpwYzBDdkR1emRrbVdqeHhpQnNIVGxlb3liUGlxWmxBN2JXczdMRWpv?=
 =?utf-8?B?SlVuODZUeXhRUUNSS3FFRlJCKy9yVXNCUGcvVWovYW5oc3VrY0k2L1ZoeHJz?=
 =?utf-8?B?a1pvQWMxb2hGYkx3M0JJMUFMQzQ5cklSdDI1S2prMmtmMlFVQlRsdE5iQ2Nj?=
 =?utf-8?B?Rk1KanYxbEgxTDlidUVkbk82OHAwRzdqbEhiL3NjN0RqcHNwVVh1NFFrdE9R?=
 =?utf-8?B?Q0lwTW95Ujl6ZTZ0RTdoYll4RDczRHhXOXN1N2UveFlUZno3Y3ZlVWJRUVda?=
 =?utf-8?B?YjZaTTJFcGJabmJDSkpDME91MU9BWTkxVVRPcGhBZEIwWlhQZjRhcndNaVJs?=
 =?utf-8?B?MGhBdXdYT0QrNlp5dEdpQ0k1Yk1CUDJSbUpDanp4NHlkMHhsUlBLTW5DdVFV?=
 =?utf-8?B?N2Nhb2EvRmxZd0VGSHVQd2Yzd1NObXE3NE9sNVkxMjA3dXo5dXFXMU5uU01S?=
 =?utf-8?B?VXg0WWZQK1NYOEdHNEJyWmE0VFA5K29kK3NhTUhlQ2l5ZzhYVFhQU21aMm4r?=
 =?utf-8?B?Qk10UmNVVytDRG9JNE4xMkZSYUlDZDdoVnRFSEROc2xqR3hkS0NYaTFmN1R4?=
 =?utf-8?B?cXlvV3JPN0RCVWZlY2p3YURQWkV3L0Y1K3k0VWlCamFHeWFZdDVmckRrWmVt?=
 =?utf-8?B?dzIxczloN0hiUWJaay84K21PanNJeHJIWlYxcEFERGNTWjBqUENNbHcrbzVk?=
 =?utf-8?B?ZHNpM2VJd2NGQUNMT3BsVkFDMllQNDNVODN5b2lnUlc2NFc0R21sYTRSbkZN?=
 =?utf-8?B?Tk5wMEgwQTFPTytvSS9kdHVwT2JSZEtwSWl6UC9KTkhDVXhkcHl1K2tqQUtF?=
 =?utf-8?B?SEw5SGNHeW14ejl5dWV4SEdCT1VDYUFEZFBoNDNyYllVekdjWE01cjN2ZnZV?=
 =?utf-8?B?YVFNVWJnWTBMRjJqYXJwbWYxVjd5ejZYOGRoOW5IVFZIN2UxQlBVR2xqUnl5?=
 =?utf-8?B?UFRzTjdaOUdRYU1pUjI5WjcweG9nUFQzMXlHK2ZRYXpoRHdrMkw5UHNhTVVE?=
 =?utf-8?B?bGZJYWFpa3EyMGtuMHcvckRhUzUvS2dKck1GK05MY3dsMkxFWVpXWEY1c2VS?=
 =?utf-8?B?YzFJajFHRGYxQ0phN3pHUk5kaGM1enI3Ym1hbWZrWmUzOUJVTmx6dEdMUHFo?=
 =?utf-8?B?dmhBVVk0aVlVNmR3bWltWEpFaUR4RE1GZS9iTlVzODNlVDRIWjM0RUVVa0hl?=
 =?utf-8?B?ZkMrSkUvTWdJUThKbFd4K29mc2NSdmt4eWpEdk9FbnRibE1kZm5ZSnpJcG8w?=
 =?utf-8?B?OVNVeXhvTEpmMjBTbklWZ0I0aXpvVkw2Mm9heEZCMDQ4aTBBT0Q3NHk5WXJG?=
 =?utf-8?B?MFYva3FwSGpjejc3cUE5QlZXaktSS2JiamcvU1REb3R6dVd2SGFweHd0SlVj?=
 =?utf-8?B?b2FIcDlKV3NGNjFtTEVwdVZXUEVNVitrdlRRSHNIQXdMZmdBb3RWdEN5VzVU?=
 =?utf-8?B?aHpPRXI1UUI0T01JTWNnUDl1L2srajdGZ0hvaTh4RWlmMkJiZkZILzUyamtN?=
 =?utf-8?B?OXhjRE5kYWtVL1F4SkhMK2hqblZ6RFhsSUI3TE5IcW1LU3BuZ1hzNUVQczRC?=
 =?utf-8?B?ckNra0pJdGVpLzE5ckZlZ2h6L2drSHM0OGZMZDJIVHErS1FDbStMRUhITUhy?=
 =?utf-8?Q?DASFe88HCFA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUZzaEJ0dDNuYWc0Nkw5bzRGL2ZGeXpQZjROSFNFWENhdlJuOFU1czhVN0Ry?=
 =?utf-8?B?OUdxd0JIcEp2WlRDNEdqa2o0VytNcE4zQ3F4aTVyK2F1SUkrN3g2SHkzdTBp?=
 =?utf-8?B?VXBRZFBuTHRNSGlTTW5NRmlqMjB5STdwa1hiVEFvdkp5L3BXWU5yQkZYRlpw?=
 =?utf-8?B?dHFSbCt6bm9vS3hqeFIxZkM0VDF0cEZCczlKVlNTckh2NFVXSUtYR2hVYlF6?=
 =?utf-8?B?d2tFYUxEbDRXRnlYeG5zSHhlRmhjSXRWazU4bkJEZm1GK3g2RGtWMDYwaEpr?=
 =?utf-8?B?WUQyc0NqQXVQcFZjN0tDZmhSRXVJZ1BwUjl4MUl6NVVOMFlCMzBLYmtycWZX?=
 =?utf-8?B?aHlHdzJ4eXFFNXV4SEpXcllBTkRDbXhibWxiaytJQlovM0Y3enJZekxJVlhD?=
 =?utf-8?B?QlN1TDVDM1ZHeW1CU3NGcnRGMnIvU1A5NG1lOWZjdmFEdGR5YWRJNTdaV0ps?=
 =?utf-8?B?K1VrQnhBV1pzY0hwb29EMlo1UnRwYTV5b3EzUFNjK0twZDM0bDhsa1poY28w?=
 =?utf-8?B?c0JwL0tjMllYZGdjenkyREJmQUd3NW96UVlFY1BxcmRTZ1B6VnVDRFlRZ2Rp?=
 =?utf-8?B?UnZ0TWw3QkxDQnUyZ2FYZmlveUZXdnBhL042U3JKZXp0bmFCMEVGZnZMVXlo?=
 =?utf-8?B?UEJEbkVCeXVpS2tyamE3UGZMRytQUVQxT2d2VnBBY3diUFdleEVZWTJwdWdK?=
 =?utf-8?B?bFZwN3JLMVlZRHpRVURvMkdNU05oTjEvcFBJYmt4ODVjVElzZlpkM0Nkc1Zy?=
 =?utf-8?B?NFpKQS9XMlcwM0lsdS8yRFJGZ2xFeHlURis0UWQ5emNlcUo2OFJZVTBYUlQz?=
 =?utf-8?B?cVlKYnU3QkNaT05idnhNUnlWMG9QV0JLT2tjL2dSeE1sVlJzT2pETXp3V3p1?=
 =?utf-8?B?TXpnWENWTlRMVFhSSkRBeUxqWnRLRFlwcFVCTjFibmw3ZHdsUFFXVkJiN0Ex?=
 =?utf-8?B?WjlLTHQ0aGxIOXVsVDRzYXNLRDhuTEVoSG5qR245ZU8yemh1NW5iRnBYc2R5?=
 =?utf-8?B?WllIMG91WjFZcy8xL0ZGekVlNGthZmFqd1VCOENBSVpaNGU5cytWKzhIbm9H?=
 =?utf-8?B?RW05ZEF6Qko2QU1MaG0xQlIwVDY0dEtkS0R4ME5Ld1JxZmpkK3M3dWpHSElx?=
 =?utf-8?B?SlJ0UzIvNkMyZ0laSy9KZ29QVnBDSGhYS3hxOTFRN1FFbkZYMWdVaDV6RGtu?=
 =?utf-8?B?K0ZISG8zbnVNQlA1NGJ6eDIwMzg0amZGRmM0NkxYTmFVRG5oQnpZV2RGOUdw?=
 =?utf-8?B?bjN1b0xVSkxqSTlRSVY4Y3RucS8wU1ovVm1sUFpqRThISVJLc01zMW9yWFU0?=
 =?utf-8?B?MmVuYitrRkwzU0N1aVM0V2pTUDRTay9pQVowNXhtK1ozaHQzZGJQOUtLNkdL?=
 =?utf-8?B?by9XdlkzYWNPak5vaS9XeDA1SmJaZENOeVBka2lPeDV4ODA0ZE04a3ltUktt?=
 =?utf-8?B?SEFuVisyMjBvblIvZHBmNzdNWE1MRzBBUDBSUXpKY09RRkszcmZHREtDY0o2?=
 =?utf-8?B?cFJRZEVmbVdnQk4wenRKb3haYXN2UDdhUzNSM3ZHaXpyZUh2bk5vYVZtN3lT?=
 =?utf-8?B?Z1RYY1FJa1p3YU5OY2V5bTN2WHB2SGpFcUptVzJTUVBTcmVRQjNWQlFVMEcy?=
 =?utf-8?B?M3BCV1hUcVdWQXdvb0RuTWFLK2E2dXpjU2dBVVlmRnVMamZ4dmc0eVdGMURD?=
 =?utf-8?B?cVhtWS92blZCbzRTZUtQaTFvdFpNaXF3ZTNVKzJYbHdtQXliN3RvMEJJaWl4?=
 =?utf-8?B?RkxMb24wdkF4WkhXTWtGZkxNSnRFbjUzL3ovMmJmRUErSUgyc2tBQnRWVmJi?=
 =?utf-8?B?V3FKOTZOT1Z0VzhxNkdUN0xEZUNXRzdMbm8zakxscnZKZ0xJYmZTTVNlQjF1?=
 =?utf-8?B?SGVYR0krVERISDRhYnZxTmpGalZ4emloNXJic3MraTlWODZBOFY5Y25qMGg2?=
 =?utf-8?B?NkRmMFpmckU4eGptelV4TjIwR1l0M1BtM2dDR1VBTk5WSjF0U0tkR1Z2YXpp?=
 =?utf-8?B?USs0UGl6aHdScmdxZUJ5ZUJ0bEtLZERjS25JZld2NzRBTXQ2a2tRM2FjUG93?=
 =?utf-8?B?WURPL0t4ZUtDc1oxSFdrdEFDQnNXdVQzVytqM05WMFNCakUzWFFoVGNIMGV6?=
 =?utf-8?Q?VlP5UDxbW+nVgr/f7qVqtqt2W?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c67bf4-4ca9-4dfa-b5bf-08ddbe1d1c4c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:43:59.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9knIasbPVZ0q9Ado7cyINHvwOvlMWGQQC55JagKKExYP0xOX+HfxsM8koVMF94zJr5XV6hxtpz23P5OYvI/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7760

On 08.07.25 14:41, Jan Kiszka wrote:
> Hi all,
> 
> for some days, I'm trying to understand if we have an integration issue
> with erofs or rather some upstream bug. After playing with various
> parameters, it rather looks like the latter:
> 
> $ ls -l erofs-dir/
> total 132
> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
> (from Debian bookworm)
> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
> Build completed.
> ------
> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
> Filesystem total blocks: 17 (of 4096-byte blocks)
> Filesystem total inodes: 2
> Filesystem total metadata blocks: 1
> Filesystem total deduplicated bytes (of source files): 0
> 
> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
> target BeagleBone Black. When booting into init=/bin/sh, then running
> 
> # mount -t erofs /dev/mmcblk0p1 /mnt
> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
> # /mnt/dash
> Segmentation fault
> 
> I once also got this:
> 
> Alignment trap: not handling instruction 2b00 at [<004debc0>]
> 8<--- cut here ---
> Unhandled fault: alignment exception (0x001) at 0x000004d9
> [000004d9] *pgd=00000000
> Bus error
> 
> All is fine if I
>  - run the command once more
>  - dump the file first (cat /mnt/dash > /dev/null; /mnt/dash)

Forgot to mention: That first dump when done via md5sum or so actually
gives the right checksum. So pure reading of the binary is also ok, just
trying to load it for execution fails on the first attempt.

Jan

>  - boot a full Debian system and then mount & run the command
>  - do not compress erofs
> 
> Also broken is -z zstd, so the decompression algorithm itself should not
> be the reason. I furthermore tested older kernels as well, namely
> stable-derived 6.1-cip and 6.12-cip, and those are equally affected.
> 
> Any ideas? I have CONFIG_EROFS_FS_DEBUG=y, but that does not trigger
> anything. Is there anything I could instrument?
> 
> Jan
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

