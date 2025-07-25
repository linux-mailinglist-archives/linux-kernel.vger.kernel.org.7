Return-Path: <linux-kernel+bounces-745168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CCDB11600
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A3F1C87D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A151F55FA;
	Fri, 25 Jul 2025 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NGhpj6qD"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012059.outbound.protection.outlook.com [40.107.75.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18524192D97
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753407893; cv=fail; b=obgQnbRGeP7mNr0pnDAt5p75QSuhL8UuOBfF/gh9AenPA8y4mBnsvqL/dvPcUo3NtBGijbGRK7yPwCZynm4bEM2FAloEK8MPBGpKm1dcQqX7ZO3u7n1fQDFhzSXq3/WsyMpabK+hXFtxq0UL2ZFlKZYdWAf6hPd202io7M0/IK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753407893; c=relaxed/simple;
	bh=gfofBaF6VIamhlWWu0P1pF9h4flXq3InArji8nwn6kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YNMMJR7AvG/GtHq64Tuuic4MvxXYWRkX3+MF2pks5eXwhPnUXc53e2e+aOWXXWNv1FmIM2dlrBesh02tSgnqH4aUTEPMEkNWFFiXOgfTWz7AF9tcHb8fG9EctsD1a3eJRDbWrapRBF7aJLulxPdX7y14gUGrqltWKO0zcSsz5ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NGhpj6qD; arc=fail smtp.client-ip=40.107.75.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqw7enLUuRIpbrZtK8QFNN5S2RZ1HVBbhaK0ZZkwN9lVV6H4HROV+cAJMYtFQI4VUOYluHPtqwgN0+d2jSKs8MUFDgIuI7qmKEMYLfOsD8dASeg8T/L0VYy2jSBi0lr134gkhCg5HhOH1JFl1RyBP4XgVoNu5uOI+cjV7z8k3dilLCTMvEybOUvmIBVNpqTgcr43y9JjtOCnZ4eyeUKk2P7izYUfkJSG8eP/6R0Io3hE+s9p8NgQeQq0cWOMxDsBW4a7AnSi8sl4HzblZT679qDVrfYyHyVUe5PgwJKyZqgAPrcZLtpRMQWzRi318INhuGuiJSfIdOvevO6lADl1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb8s6ezLixBIFzdZ2j9r6x1SqMFdbRyRmBiStr3QNNk=;
 b=LLVe8me/5DCXGJ447cmjbAjNw6V4YSzTttG/sFOMqsu7U3UUu66KM1ok1KGRmVD4T3O9Bl9eAjhsfI2g9akDgWs9xH4Tpf4kcQ3g2EX/OqoVHojT4DhLic5Rk3tm87bbeK8taPKCSFq/3nXg+8Jvtgn7nnRAcy03csboFmKkYn+l4P7W6Lea2z+5o+KfIwRxkp16QgQBaT3Tn7XJKNE+EAdhJBH2j9RhZdomfrM3sOMS7qob2PPAjVsYdWb9UtzkAGTGVOuhi5I/Z3j56nVWGrtxUZTGvqaevS+KvU4LOcLTJsXcxFeJMWVZsTltZOIPCyZ/y8ffM4aGEIGqRaTUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb8s6ezLixBIFzdZ2j9r6x1SqMFdbRyRmBiStr3QNNk=;
 b=NGhpj6qDJZzRfjsaL2nr1w83IUhi1ANmEY/3DjxTy1Dm5eL1GJiWy1pPbGeIr8me9PA0Mg3CO7/tRZL9Y6moSGuFzdkfHO60AqGQjcEtEphIjPGrSsBXpLDHXR4edOLx8lVnyFIb6SgIrzM65pLpJO+Fztme9GaLNVH4TSx64GVQFxOykxkUqgWkbSUrkxxy4m0PBPronAiCHhQT21cgrFyi3fwQBF2cYsXI9W9QwAoMGTg2K41breaX+Q6ycvoW/p8tKZS1iUqP2ES58E9i7UbFKxs3vspzNHx1C+nuKlD7nNs39wsU3kCBEEAi5c7w/zaLqfYoZdo21nKVqs6Tjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by JH0PR06MB7328.apcprd06.prod.outlook.com (2603:1096:990:a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 01:44:45 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 01:44:44 +0000
Message-ID: <06b9d287-816c-4347-945b-8fda83a6f557@vivo.com>
Date: Fri, 25 Jul 2025 09:44:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O
To: Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250715031054.14404-1-hanqi@vivo.com>
 <056e083b-8e41-45a2-9b0f-2ec47d1a9f71@kernel.dk>
 <f7408161-eaef-47ed-8810-8c4e8f27bfc6@vivo.com>
 <51168786-6c30-4065-be82-6d07b2ae74a8@kernel.dk>
 <4366bf0f-64a1-44ae-8f81-301af2d179d8@vivo.com>
 <d5355d7d-4e93-4741-9ef7-c7407d600ec0@kernel.org>
From: hanqi <hanqi@vivo.com>
In-Reply-To: <d5355d7d-4e93-4741-9ef7-c7407d600ec0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|JH0PR06MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 3574afa3-5189-4c87-5de5-08ddcb1cd48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEtlVFA3Tk1SQ0hUckp1dVlZTjBlblFaV1IzaUJjZ2ZzTm41MjNHYzA2RURD?=
 =?utf-8?B?VmdDR2lRWkdiNlROdExuZlQ4KzhSMDFWNzRvSGVhM0NPblh4ajhnSlFNZm9H?=
 =?utf-8?B?TTZlMHBXdTc2MGhWYm5rbVgvdUZTNVE5SWhnKzNpS1RlcG53RWEyZUJEc1g2?=
 =?utf-8?B?cWE4Q3B4amNPT2V2K2p6RXFkOCt0TFVQR1ltNDFyRytXcXlRcUFBQlRnUkhJ?=
 =?utf-8?B?M0hEMjF2Y3NlbTdQcnB6bVZoTVQvV2NQWjVMNzlETS9QczNBRjZIN3pHTTl0?=
 =?utf-8?B?aEliWFYxdEdMdXJXY2swb25Pc05IVmVOdnNva0crK3JzaWZ6dklqZjhjZko0?=
 =?utf-8?B?dkZKd1RCV0prb3A0ZG5lTDlaVEpic2JWRFpOcndQdDdyeVBEWXIrazV6ZEJr?=
 =?utf-8?B?Z2o3eFdOOTNmdk82R1k3cGJzaEtieWtJUmkzNDFKOHJ4aDExam43RXZrTVhJ?=
 =?utf-8?B?MUdNREFpcVF1TUcwNGIrQWV0bEpZaitwS2JBenJHK2E2VTdyMzVsZEwwR29p?=
 =?utf-8?B?Qk9RUzQzN0o1STBTOW9pZ1ZweHJ5UEJzSnZ0MmxrVkxoMVNsek8wQ043dWF0?=
 =?utf-8?B?NFpuaVFLVXRKRFI0alVJU2phWGZSanJRcXVXY3l2TG9vbzVYUUI4OGh2M1Uv?=
 =?utf-8?B?aUhNUXZpY005NTRneElRalNXSUpTYlN6dzVuM1VESkpyMWNnRzFZdE9rUnhk?=
 =?utf-8?B?YzNpTG1yck5iWEhDK3VEWHp5OGdHOGxLaTN4dHQydWEyZ0pobVJiczBoMjZD?=
 =?utf-8?B?YitTNkNjSWpsREhIa1lvUFc0UlkvMytXTjlFbVI1azB0TWxOMzgrNXJLTG1n?=
 =?utf-8?B?aG9tWDhPVldZS3dKT3BCV3VqTzVsMVdCN1FvQUFtdThDSC9QMUJmcFp4cHNi?=
 =?utf-8?B?RHdPT0JvRTg0RWxwalJZKzI1bG95VWlYNU9sMFZraTNWQWJsd3A0RGdRRjJq?=
 =?utf-8?B?ek9xbkZLbWRDMXljYUVpbFFYZUVMd2ZhME10VVovYlJqTzdJUjhDbE1wWHRD?=
 =?utf-8?B?cEJPN0ZvR3JQaW5sMXhZT2MxRkYxNytoVTRiaHZaWXNJTEtZY3I1VSsza3ly?=
 =?utf-8?B?Ry9DWWY3T2ZDNEROY3AvR2J3Tm9sR3ZBMmJad0ZhQlEycHF0U3JiN3hkajhY?=
 =?utf-8?B?eU1LWW9pWWJQcXhRUFBjL2ZIWEpOQ0Yzc05neGYzYlVva25uL3BPWHpna09I?=
 =?utf-8?B?NHZHRFdFV0wvczNGc3dROTlRa0wwWThVSkpDd0JqVmZBL2ZXRHZMYWZ1S1hC?=
 =?utf-8?B?M1QyU1luZHdhSEwweTM0bnBIOHV6dlN1VWVnU3FTZXhtOWRVTThoNGs4Nmdn?=
 =?utf-8?B?eDFvTXZjellrcmRNMzhnS1JINlViS0Y5K1p0bWtTUFBqSExFK3Q0MUFiSEZP?=
 =?utf-8?B?bmFkWWs0RFdKZ2IxUnc1aVJXc1hWOHZTb3AzcjJoaTNtOUdYeUh5K2FudjE2?=
 =?utf-8?B?eHFNYWp4Qms2VWJMajhjbVFTR2RsQTdaMm5sdllBZlYyV3hUaXFic0tsOHo0?=
 =?utf-8?B?L3VhOXBMdklvckZOZ2VkVndkOVV6dExDSmlpMEpLR3BtNFdxbGJBTUdQcHhn?=
 =?utf-8?B?TlJLbWt5L2RDU1pnMnkwMkJKelJIQUZpWk9ZMFlxRW9WM3BWRHdyWkthaXhp?=
 =?utf-8?B?K3o1ZC9wRXJpN1hiZ0RaWWI3RStlY2JsczJzbWgrZnpveHhiN25jWDUxcnp3?=
 =?utf-8?B?ZXRIcHdIeWJOSmo5aFVsejlNNDdRd2VEd0RTc21MZTdJOHdMNGZnSjh0NTRC?=
 =?utf-8?B?Y20yMGE4U3BIM29TVVRadnZ0YjBLMGk3d0pXcXVzNW5BU0lIYlJ0UlZrMU4z?=
 =?utf-8?B?SWIwS1RIWTZoV1c1eXBzNC9uOVhteHRVdVc1MzQrSTBwT2pQcHRwMFdKZXZZ?=
 =?utf-8?B?VlFkaHp6aGdyV0hnbkhISVEzUit4OXJJaWF5cWtZY2hzS3VHTlZ1SUNMS29X?=
 =?utf-8?Q?zNGvkh1pn6U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDlYTFk2NU1TSUNaVG1PZDBNZnRXZ1BhRHU5U1N2MmdVcDVjc0VmNS9uTzVX?=
 =?utf-8?B?OTNNaXNselErNVNJR25kd2xmK3RUeFhTY0dSYldHSDd1TVExcnVVM0dGSjlC?=
 =?utf-8?B?QlFIVldlNmVSaGFTRHg2RVhhRldSTFo1OVJJNC9LZUJ6dS90cGNYOTc2RndP?=
 =?utf-8?B?WmVMRUJTY2lDUmc2cjhzdW45Rkk1NzRvMklLQ2pGSTBZNXozQU5RV1ZWMG5R?=
 =?utf-8?B?azErU1BPV1ZtVFFCOXVPcXo0Rlp3U2xpSDQ1SDl5MGxQOEk5QWlDYkQvVGRW?=
 =?utf-8?B?anVMeFl5d0FJaWFRbDVhUlRYTStlaGZobFZBeFFNa0w1aTBhd1FTRm0xSmRN?=
 =?utf-8?B?cmYwZjZ4WU90TnluRWZkR0FLSTVRbk9HekJJWk5UZlUwUjdyT0hvSWkzQkVM?=
 =?utf-8?B?WFMvZWhEN1dwZW43ZmxuKzFnSlN5THVlNWpwRGdYTnhUWTBUK0JJd2c1cTBT?=
 =?utf-8?B?WG1zUnFFYU5NWXBoRytMZmxKc01nTUgwRHpBTlJ0Y3FXbEdwQVQyQ2FVZEtk?=
 =?utf-8?B?ZFJGYURadm5ySzFIcGFLd2Vrd0h6WHplWHVTZ0VLbXJqTXdVSDRYUjYreEhX?=
 =?utf-8?B?MDBiNFdWY21yWGZhQVpLZzh4Tk5OWnFRUkd2MUwzT01DcmVjVnd4SE13SHJI?=
 =?utf-8?B?dW5JcnFTcjBNTTFGYnQzQlNCZkRsWTM0UllDaVk4eWY2dm5mQTZacSs1ZUF0?=
 =?utf-8?B?T29EM092OHNhTGNkUEREaTY1bkRlS3ZDalRjR1lYOGFGUHdGazg2cXFnSUVG?=
 =?utf-8?B?ZXAwUzhaNUJBZUVWTm82aXVjTHE1ZG9QUFFEQU5NTENBU0c1UFA4NnBwTy9D?=
 =?utf-8?B?QUZLYUgwRlZRTlQ5dXBTZTgwYXB5VHJBcWMxTlF6NjcwblIrTEd3aitQWUJo?=
 =?utf-8?B?VEIzWWNkNTJUWUdCTjdKTWJxWWhacFM0SFF0R0U3L2p6dWdpYjBITlpaS2xJ?=
 =?utf-8?B?WUk2TVRUZlFrVnVPV2N4K1l5RkZoZnB6MERPbXlnRVNIdkEreDlsNEJqc2tS?=
 =?utf-8?B?L3VmVDdUOTJuQlhFSGJaK0p4Rk5Pc2psbHk3ZVgxZGNGMWtYTS9XTW9NNVJY?=
 =?utf-8?B?eGs2MHVEeTdGQk1zNXd2a0w2VTFDU2dONzVmSTFlNkZOelZhK0RqWDN5ZTdJ?=
 =?utf-8?B?aTVRSWRsSHlYTWdIWG5tSWV1RUllV21tTkhuYmQxa0lTeDVkYkNNSWZ4Zzdq?=
 =?utf-8?B?Mms0SUQ3dE1tUWhTeTlTR290ZmwvY2R1L2p4dHlOM1FyTDloYVhzNlRaUVRj?=
 =?utf-8?B?L1FyM1JqWEZDODZZNVNLNWJJNzdzOTJseDZsTDE0SkNnRTZickdlQkNEK3lI?=
 =?utf-8?B?cHdwL1VPU3F6Rjg4QWpqMDJoN3dRTjZSRW85VWpvWWtEMnVHSUswVXNUdlJv?=
 =?utf-8?B?Wnk0MzFsVVBqVXFlcjlDSVdISEZUSzR2K3J3WlNGT1RaRWxSeFJucGs1SGM4?=
 =?utf-8?B?ckprOHVTUnBWMlk5ZW5jeThMY3JRUE0yMVpvOWMxUFEyR1gzdWFvZldkbzc5?=
 =?utf-8?B?bDFaOStSaDVkWEFwZGxvenJqN2owU3drV095clJ0QkdYZ0l3ZmxnZ25UeTg3?=
 =?utf-8?B?V0tzRzVaWVhoSEJFMnp0RTQ2LzNJM0x3NEd5a2ZXUWV3cUw4L0FweGRzYmZX?=
 =?utf-8?B?bkJTR2VTRkFBOXpQUzA4Zm1jOEFUTHVhYlNJZjh2b2JJS09uWkVUelNITEo4?=
 =?utf-8?B?Y1ozMkNZd1h0SURRYjMyQkFwNUFGM2tUZ3VYdEtoQUFaL1VvSG11amtOU05u?=
 =?utf-8?B?YWZLM3ZXYnptMkRCajlmM0phQkhkYUdGeXNnbTJyeDRkTmxKK09udWtEYXZO?=
 =?utf-8?B?RDNBZWtENllOM2Y4ekR1aVhuUzUyb2lwZDYrNHk4djI3dTQ0d0UrWDQ3Z05p?=
 =?utf-8?B?dzhpejBwbmZjNEN4d1YzVVE1R1ZVSFhiNjhqWlB6L1ZRZklmTE9nbVlmZ1lO?=
 =?utf-8?B?cHFtaFJxb3JHYXNMWFVEejU0R3g2SGFIcEN1T0IrbkVPWE5XcmlVanA0b0Y0?=
 =?utf-8?B?V3VmOFBxZFI5SU5GOHRvYVlxN0dNK3hpWXpGMVZYU3B4ZFVWRUJjbzVpSlZ3?=
 =?utf-8?B?TXFlcHN6ZXhNazQ1amF5UllobGpHNk5XV2xzczl1em5hUGVWT3dhZ1A0UGNT?=
 =?utf-8?Q?2aCrL3+9qIfT9zA1nF02iwF/7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3574afa3-5189-4c87-5de5-08ddcb1cd48b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:44:44.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5Bt7CLcKXY9BJkw5yAQUFeDrY9iTgD0fQ8hpcDSTGF7nu1VnVirA5I/9muPfkipribcSGjDw6YyUiKI5SPNeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7328



在 2025/7/24 21:09, Chao Yu 写道:
> On 2025/7/16 16:27, hanqi wrote:
>>
>>
>> 在 2025/7/16 11:43, Jens Axboe 写道:
>>> On 7/15/25 9:34 PM, hanqi wrote:
>>>>
>>>> ? 2025/7/15 22:28, Jens Axboe ??:
>>>>> On 7/14/25 9:10 PM, Qi Han wrote:
>>>>>> Jens has already completed the development of uncached buffered I/O
>>>>>> in git [1], and in f2fs, the feature can be enabled simply by 
>>>>>> setting
>>>>>> the FOP_DONTCACHE flag in f2fs_file_operations.
>>>>> You need to ensure that for any DONTCACHE IO that the completion is
>>>>> routed via non-irq context, if applicable. I didn't verify that 
>>>>> this is
>>>>> the case for f2fs. Generally you can deduce this as well through
>>>>> testing, I'd say the following cases would be interesting to test:
>>>>>
>>>>> 1) Normal DONTCACHE buffered read
>>>>> 2) Overwrite DONTCACHE buffered write
>>>>> 3) Append DONTCACHE buffered write
>>>>>
>>>>> Test those with DEBUG_ATOMIC_SLEEP set in your config, and it that
>>>>> doesn't complain, that's a great start.
>>>>>
>>>>> For the above test cases as well, verify that page cache doesn't 
>>>>> grow as
>>>>> IO is performed. A bit is fine for things like meta data, but 
>>>>> generally
>>>>> you want to see it remain basically flat in terms of page cache 
>>>>> usage.
>>>>>
>>>>> Maybe this is all fine, like I said I didn't verify. Just 
>>>>> mentioning it
>>>>> for completeness sake.
>>>> Hi, Jens
>>>> Thanks for your suggestion. As I mentioned earlier in [1], in f2fs,
>>>> the regular buffered write path invokes folio_end_writeback from a
>>>> softirq context. Therefore, it seems that f2fs may not be suitable
>>>> for DONTCACHE I/O writes.
>>>>
>>>> I?d like to ask a question: why is DONTCACHE I/O write restricted to
>>>> non-interrupt context only? Is it because dropping the page might be
>>>> too time-consuming to be done safely in interrupt context? This might
>>>> be a naive question, but I?d really appreciate your clarification.
>>>> Thanks in advance.
>>> Because (as of right now, at least) the code doing the invalidation
>>> needs process context. There are various reasons for this, which you'll
>>> see if you follow the path off folio_end_writeback() ->
>>> filemap_end_dropbehind_write() -> filemap_end_dropbehind() ->
>>> folio_unmap_invalidate(). unmap_mapping_folio() is one case, and while
>>> that may be doable, the inode i_lock is not IRQ safe.
>>>
>>> Most file systems have a need to punt some writeback completions to
>>> non-irq context, eg for file extending etc. Hence for most file 
>>> systems,
>>> the dontcache case just becomes another case that needs to go through
>>> that path.
>>>
>>> It'd certainly be possible to improve upon this, for example by having
>>> an opportunistic dontcache unmap from IRQ/soft-irq context, and then
>>> punting to a workqueue if that doesn't pan out. But this doesn't exist
>>> as of yet, hence the need for the workqueue punt.
>
> Thanks Jens for the detailed explanation.
>
>>
>> Hi, Jens
>> Thank you for your response. I tested uncached buffer I/O reads with
>> a 50GB dataset on a local F2FS filesystem, and the page cache size
>> only increased slightly, which I believe aligns with expectations.
>> After clearing the page cache, the page cache size returned to its
>> initial state. The test results are as follows:
>>
>> stat 50G.txt
>>     File: 50G.txt
>>     Size: 53687091200      Blocks: 104960712       IO Blocks: 512  
>> regular file
>>
>> [read before]:
>> echo 3 > /proc/sys/vm/drop_caches
>> 01:48:17        kbmemfree kbavail     kbmemused  %memused 
>> kbbuffers kbcached   kbcommit     %commit   kbactive kbinact     kbdirty
>> 01:50:59      6404648   8149508   2719384   23.40     512 1898092   
>> 199384760    823.75   1846756    466832     44
>>
>> ./uncached_io_test 8192 1 1 50G.txt
>> Starting 1 threads
>> reading bs 8192, uncached 1
>>     1s: 754MB/sec, MB=754
>>     ...
>>    64s: 844MB/sec, MB=262144
>>
>> [read after]:
>> 01:52:33      6326664   8121240   2747968    23.65      728 1947656   
>> 199384788    823.75   1887896    502004     68
>> echo 3 > /proc/sys/vm/drop_caches
>> 01:53:11      6351136   8096936   2772400   23.86     512 1900500   
>> 199385216    823.75   1847252    533768      104
>>
>> Hi Chao,
>> Given that F2FS currently calls folio_end_writeback in the softirq
>> context for normal write scenarios, could we first support uncached
>> buffer I/O reads? For normal uncached buffer I/O writes, would it be
>> feasible for F2FS to introduce an asynchronous workqueue to handle the
>> page drop operation in the future? What are your thoughts on this?
>
> Qi,
>
> Sorry for the delay.
>
> I think it will be good to support uncached buffered I/O in read path
> first, and then let's take a look what we can do for write path, anyway,
> let's do this step by step.
>
> Can you please update the patch?
> - support read path only
> - include test data in commit message
Chao

I will re-submit a patch to first enable F2FS support for uncached
buffer I/O reads. Following that, I will work on implementing
asynchronous page dropping in F2FS.

Thank you!
>
>> Thank you!
>>
>>


