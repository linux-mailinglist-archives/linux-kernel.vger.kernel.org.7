Return-Path: <linux-kernel+bounces-796528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F03B4020E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893BB5451A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042C2DA757;
	Tue,  2 Sep 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UI1HYrKk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JmbeyXvR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25C20CCCC;
	Tue,  2 Sep 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818188; cv=fail; b=CGl3TUy6vvzRzRPQ5JPbT5bgAI4EIVTgEVBGGCRKugy9EAAZW1VoQkW2hTXgGCzBC3LQQ0NVfiEGVR+in6ElDkRuLcZdvPIr0/p0tIvn9Ye3nDWTno/wc74A281IGQV1eSWiJ4DlWcximZQ0uJfbVm2EnNiGowFB9vnEDGH5Qkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818188; c=relaxed/simple;
	bh=c306hOTlr5M6d91RKCihUwozSQEfPXAaPwn+zzIYvfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FTxDENWz3R+jZK9oqB5b9HRExYW9yjbm84md26CFLhjNbaG+WlnOxJbd7V+TMezud7s+GzN617xI6TTBvAyBdQRjKeILToVtHZtl6x2+V0nlvOcw1lmVxtQcLCfOXxApG0asjoPHzoQu9gXBaQxTPrThPROFjXY7jdMEFweBYNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UI1HYrKk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JmbeyXvR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ctw5E015236;
	Tue, 2 Sep 2025 13:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BIlCifWTGtwtR59dbp34Htkgo2V/fjEIWTzT28iN4vA=; b=
	UI1HYrKkvu7UUSTCtaKnqfYmpj5hNT7C/LEcoqN/sjhHikYdaWAed9lxZIkBoG8x
	mspgimya1Wn0JrjYFumN6PV2/vGOCWxgU2MDm2CDyAjMMFlvLy9qAI35smQTvKYn
	RXR9Rj0Wg1fNkdoAUCrFJXyKFV7bgSJBTd2M1Q+SWQI9L49wTOxhZN+zCsztaXh2
	LJ6MQSo09hXcwyKt+3RjMrCEPTJUsaqWO4SH2WvPRevrc/JwPpPPLZxO68ROWp5R
	bCW7r3H8wL6eVYZ0tTebZtuQU0SKYNReuvFY9lNZHScXk1cz4bClQDXDp/yLV3m3
	7Xl2H0y8JyojIMZbur+Obw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbbya4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 13:02:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582BtNMU040148;
	Tue, 2 Sep 2025 13:02:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrf4xet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 13:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwVWIylcandrlpBRY/4gap4pkp0Ww1tccwiqRyrKSw37UCddH2zjydO6KVvTmVBSOsxz+M6IzyjoTLe/bMRmM8F7Ki+Ok8cH0oMu5ATxjaMApTr1uUeMwQwkCDD4wEZMxhWA+hRzgr5347uMW2ThaP0HilfZ4IWshnZo35vqgWB8VxM/2unNXVduMbjpjNTvLq9I8vNHf+fNpWmHbOrQSKfoJOBFIwk/PmyMDYGrhcWIFY539UHaa2Lq56yr99qJLjKMXh/uGgdijjdL7YjKojFKSvq3CdbBQ4mYyofwF/CsAg+MnjxybJpF51p2k5EgPrPiqy6J0vTeUc+ETluM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIlCifWTGtwtR59dbp34Htkgo2V/fjEIWTzT28iN4vA=;
 b=uXjuvNuQl8ZYxkJM1OhWJy9tla6aYakl5uaDOcup6N2/MOicIAvxdCmLgrCWHLp1KhjrgQUExoj+hrc2oDdRLpvQ2kwC9GLN9QXNgzG6DMdlcLXJZOox8jK0+jnC+K7ADaZXhLUCf1igy022f7lOMKF2TmpOcCTvssYVxD+10syS8ka3DhevzAQff0eSpNa5/qAPwoIOu6QT4lulQm6NFmzYPceKGsbAcf7SI5qlAuCTITMY+/PwD/+r5duvz6ol3y4pXW4sqlX6UQEyggL7JCWX5RgFS87T2W6HSG7PVO1BgUhUPtvOu5WONRLNbBFqVuLnZOde0pUPU86df7EY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIlCifWTGtwtR59dbp34Htkgo2V/fjEIWTzT28iN4vA=;
 b=JmbeyXvR28qb2hgzs0SyURuBpotZSndnnw49oBQUZnuUJxmFWrLbYzgBRz2w/x8RFvn3PKUNJH35RvaA7V9tHM/vMLgoCyU1GbrO0CFIYCgWtY4jE8ou0avscfozuZCzCpcSL5+FWhxWayYnDZZYtJJTYjb9R6jQl8dgopj/wLM=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.27; Tue, 2 Sep 2025 13:02:53 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9052.019; Tue, 2 Sep 2025
 13:02:53 +0000
Message-ID: <d2a5b07e-2da1-47f0-b2cb-a4ffa12a99b0@oracle.com>
Date: Tue, 2 Sep 2025 18:32:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: dev-tools: Fix a typo in autofdo
 documentation
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250831150710.1274546-1-harshit.m.mogalapalli@oracle.com>
 <CAMuHMdXSNoXjxAbALr7O_dD_btJDGR58XaDa5=bd8NmL50wcaQ@mail.gmail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAMuHMdXSNoXjxAbALr7O_dD_btJDGR58XaDa5=bd8NmL50wcaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|DM4PR10MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a867943-430a-44be-401b-08ddea210751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm1zMXBXVXBPUnl2RnNoNllIYkJKbXNFbHN6VW0yalZTMjErWkcwdktyNVVq?=
 =?utf-8?B?bUhQK2Y3N0FXbGp6aGgwY1pFbnBCcklWb3hZN1c4S1BjV0ZOdFZsMlZHZGJk?=
 =?utf-8?B?VXdoUkdEc2RxcUI5eUVlWDU1Vlg4RWQ3K2ZBcDM5YlJyRWVlaXpyYkx6d0lJ?=
 =?utf-8?B?Nzk2UVVPTTYyVVk3VU1IUXRhSHArWUpoUWNkNWkrVnBKM0FqU1k2Z3BlU1Nq?=
 =?utf-8?B?ZGM2M1JjbjV1UlpPRkJZc3Y3OEViK1p0M0E5MjZZRlp4NTRhK200S2FBS2dp?=
 =?utf-8?B?SjhwZTRvUVo0cXgvVmpMNUpzSzZ0TUlJWC91aldHaG1FcjJRRndzaTIzREpN?=
 =?utf-8?B?eFU3R21mWjdieDJOMGlacVQ0TzZEK3d2OUZkcHUzZGYvbU5DRkQ3ZWRPcU8x?=
 =?utf-8?B?cDZhRXVqcXhZVUdaOFFRc0JTWWhzQzJ3YURFUHdReS9iS2Q3akkyemtaTWg5?=
 =?utf-8?B?VVN0OXVnWWgza2JackthYzBXWk1wTmZLa0VvcGYxSHYzS3F0MFZLSXVXSHBV?=
 =?utf-8?B?OTRGVVprbU5EYTFMYm9tWWNteElLMlRIQmZYdG1SRXhjWEFGZUtBY1BKSU9Q?=
 =?utf-8?B?dDVXNytheUxuaXZvZEFnVktLZ0NsRW1KLzZDQWNtWEM2SWVUYW41VCsyMFY3?=
 =?utf-8?B?amhqajMrNnNKSG5wS044WVBEOHo1b2JoV0JQQlpFQnliNk1WUGdXUVJCQVBB?=
 =?utf-8?B?YTJEOGRjS0xtTlVpbkUvaEQxZG13RXcyTnY3YStqU3JLOTA5eHVtR2JYYk9L?=
 =?utf-8?B?NnNqYmtYQnJnZXlnOThMdW1FYjJyR1Y3azZlSEFkYWN6emRnazFvaVBwTFdI?=
 =?utf-8?B?OHRGR1VFaHBEYVFydjI0K0xSR3NZd29jZWRYRXpKM28xNEFDMkZqNk8vejdK?=
 =?utf-8?B?eU1keDZncDhVL0d1cVhzZEVycUFmdlh5Y202alM5VVN5ZUFOOEV4UFhqQjBN?=
 =?utf-8?B?M3lOTTRncmdqbEdZWStRNm1tRnFHcGZscHBiTEtkeUovVy9rUjhNWmpjNHp0?=
 =?utf-8?B?OWM4WWtFRVNnSjhGUk1QY3hiNUlsSS9odkJHb0V1RmNqcjZDdWI4RlNKKzE2?=
 =?utf-8?B?c0JqaHBoY0V1MnJLMXFSdGkyOG1FOUZVVEFTSlM0L1BrbTBBT3lNM2VhclNi?=
 =?utf-8?B?bEpMTFVDL3Z4SDhaOFJmcENrWjJtU3F6V2x3M0hMN3dWVnRocnIrcFEwN043?=
 =?utf-8?B?L290aFhvbjd0U1IrMFdLQ05ySk05cFZqQWdXRUJuVkpXckNhYUJ3R2JoTTdC?=
 =?utf-8?B?L1VFR2dHTVo2SXFmQjdUaG5VQkhkQkd6NXZmSnZidWJQL1BkQ3p0b2VsREYr?=
 =?utf-8?B?SkZzbDUxV24wSUM2UWh6K0t5Zzd0YVFHYnFEYWZOSGFBdHZDWUFuMzE0TVF2?=
 =?utf-8?B?Wno2T3hiUFZjcWxuTUIvNFN4SjdyWFEzSll1N0ZUQUhwOW9mVFROT0pCckJT?=
 =?utf-8?B?NGIvNU9Qai9id1FxWXJUN3laZ0xPVHpBbGlHR3dqM1hjU2lNOHJneUJ5Ymp2?=
 =?utf-8?B?YzRMajJiM08vZFBTUFNpeEZ3ek1zMWtHSzdhMnp5V2Z0dGVGeUhFY2xpaTlM?=
 =?utf-8?B?MUxRWDNNQ0NELzk3TzBzMjdCUG0zL2h4N2Y0cEcvZ0J6UTFTQW55VGs1c1hF?=
 =?utf-8?B?SHpFSm1pc1lUUm1aSEVoMEdSdUYrTXBMcDJtdFpsTUZYNW5DNWltSGgremxy?=
 =?utf-8?B?L1VINVRzL3Y4LzBJb3FOS1ZJTm8rUVpQQmxUSVp0SzN4aUwvdEVvZ0hwMHNs?=
 =?utf-8?B?eG5xbzlBdStMMUNIUTJtbTVveWp2ZWxIUGtKWmE0NzZDV1RjZE5QUEFOZSs1?=
 =?utf-8?B?c1VkdXJXQUlDSG03UTBla2hNWThzZ2JGajhBMStQdnVvbUtoK2ZNV2E0RjBR?=
 =?utf-8?B?bmlDZENLeHZEZlZKUFdOdFVuNkVhNW40a2YzT2FVRmRqYXd4RDh0R2NUY252?=
 =?utf-8?Q?ABn9GNLmZ9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djVkMzFTY0NhS0xnRGZMMXp0WGlQRWxLVXEraHFvVVFPZ0lrcWluOGZXSC8v?=
 =?utf-8?B?QS9zdnhtZjVRS2tqQWZBNmJOUnhSblZScHhKYVJsblY5SVRJMnZkdVJXVWYz?=
 =?utf-8?B?dHJuTHd1WXlWenJOUUhxazArNno2bVZiVlFHcTRPU01OV01NWnRJTlBqbCtT?=
 =?utf-8?B?NFpDd0hlaUJkK0tjaU9DOEpMbFl6OFBmaDdoNkc5NXJsSUNaL2gvQkN4Rld2?=
 =?utf-8?B?UXdMc1FYaHB6Rnkyb1prZ3owWjFaMUlHVTZBWHNxRlRpTnBEYkJCaTVWMzlp?=
 =?utf-8?B?a0ZFMkc0Qkp3V1F4aGcxdTlJMWZITFB5c2J5TWh6VEoyL05nUlRaczdYbCtT?=
 =?utf-8?B?cDlIR2dYUU92OTNGL1dEeHhrb2JBYlc4L3RhSkdmMytuS1pZeElqcGFHS0xo?=
 =?utf-8?B?ZE10elkwbGtWZ25IV2lhcVRvTGxua0g1eThjZDlranBoeWZQQ3FYRmFxYlVD?=
 =?utf-8?B?VTNKWTFvblgxU0plbjBqV2pySGdLb3FENWswOHJNbktlcENmQmVBUU1uT0hx?=
 =?utf-8?B?MGY4V1QvanIxWGJvUzlkN0U3R3Z6NTN2MjlFaTBpVHZ1Rndqck9rcXZ2dURK?=
 =?utf-8?B?WXFJTWNSdVVGaEtnTVZGZlpDei9BUE41QlE0QkNyQ09NK1lCbmUrYm4xTVow?=
 =?utf-8?B?Z0lYZHFUNUtvdVhsdjdMc1QrSzRVVTNySE1QWmVLOEdFQUtNa1g2K1dYaGhR?=
 =?utf-8?B?S2ZVNUZqbTJ5QTF1WWszcGI2S3pvWGdoZGEveDFhTFVUSGUxSkRVQlV5RXRI?=
 =?utf-8?B?U1Z3cGJXZW9UM2F5bFZvRGpma0Y1elNsRE45Ui9PL3V0UG5pZlZYN1ZyUmZz?=
 =?utf-8?B?KzVHQ3pURFJRY05UWG5yZWNKVlo2K21ycVZtcHBydG9KZlBLSWF3L3hkS2JR?=
 =?utf-8?B?VkYwU2J2NU41NDhCQjF4djRaY21tRXY1enZvYTN5UE1vbEpCZTZPK0haaVBI?=
 =?utf-8?B?Q2VZQ3BYV3k2V3ptUk9MRjdOYTErR083T0NXVFBMUVh5T0EyN09zVVA0b3Uy?=
 =?utf-8?B?T3ZpRnhNcWNjZFA1d3ZmYXlKR1Z5QzBnbGNORDdYNDlPWGFTM1dneXlQdE9j?=
 =?utf-8?B?QnNYL1A5M0xZV0NUWE5wdXNXeUFzZjRQbEh2cS82NFJkbWhUaVR6MCt1SU0v?=
 =?utf-8?B?b01SeUNEY3ZmRnVnU3pkcVRMaWw4djAzR3NSL0VKTVErc05yQkJHVXV0QUpX?=
 =?utf-8?B?V0lsc1k5bWE3SXlYRm90TVdQdWJYd1RVN0ZZS2NGY09hYkRQZWU4VStzMjEz?=
 =?utf-8?B?M2FsRTFPUTRwSXFJOG1YRlQ1Q25EdW04NzRGbXRaNVFLd1o1T0JrenU1ZEhp?=
 =?utf-8?B?ckhQUlJFT0xWMk5wbDZBeG5WT3lUWitRdGRPVXFkRjZDNm9aYk1OYU8rUGRD?=
 =?utf-8?B?RHF6MUZzbTdKM3JoK1pzcVhNdUhmczVuSG9jelRJN1NOZTN5TzA0V3QwbEt6?=
 =?utf-8?B?dTRYQnNWQUlMRmYrVUlwWHhqOVZjemM4OVhkU3RWVlR0bzlaNzRRM1F1eWFF?=
 =?utf-8?B?dVZUN1dpUWM1QzZZZEFzMmRxYTdCaUJQQ2NmY3h0NFY2ZzVRT1JDL0JmMzRX?=
 =?utf-8?B?b0VES2M3Z1pidFVlSWE2V1E0NkgzYk4vblpFUTE2ZjZOVlI0dDJIRHpxQVE3?=
 =?utf-8?B?Nml6TGcycThNL3ZyVFQvemVrOXFJZW9EU05ya1FxUmdzY0sxUjllcjBqN1Vu?=
 =?utf-8?B?ajNTYW9lU2ZnSXVBNVBIakRURW9icUc0dUxBVkQ3RkF6YUJKOTZxeVdmSnl2?=
 =?utf-8?B?TUtTQU9GbVdlK3RxQkQ2QS9KNVZ0bS9qa2VnNFpkMXZvMmEydTNObjEybUti?=
 =?utf-8?B?cytURW5kZUZQSFlyTVE3VE92SS90VGw2VEVTZG5xMXQyYjNNTEhKNytxMnB0?=
 =?utf-8?B?K1ZqYzB2amxKQ2R1WHFwL2pOdjFzUEozVkd4dC9rM0w4STNkTUxSZDVsWjJm?=
 =?utf-8?B?N1EwQzR5WTcrc0VRUHQ2cmpRdkVDVHlPbnVZY1NKZFloYm1BUHpmcnB1RHE4?=
 =?utf-8?B?aFZzYng4MEoxTko1c1k3L1JKeEV0VzEvbEoxYUZXUlQxNEUwZkdYU01TWDkz?=
 =?utf-8?B?UnovSkgwMURKR0g4aFVRUVoyWVpna1BUSHJPYXJ6V1BPS1AwRFRrYUIvV05Y?=
 =?utf-8?B?WVp2bjQxaFFweU1pNWZDYWhURlhZQVFpbkhBcFZ4MG1ra3U5eDdiR25FK2Rk?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tZNYPNaAKQCsDpfidjsNVaGijpM2IgTtaJhan9wtHgex5pz74l2xBbyxUhD1LboePMcgfpYIvSIqqhNRMW2aVWQxUDPM7bBRZHAvT4/3G3WyJ6moO9xO3EVnbF5Og5AUVojkQa1gjPUIPSf7MDIiabm4GSCac/+4JTDhP2taYzix6MqDsZ+Jx/eC2R+fMcJ0WtbPRdqRzPUIH5FxJ4dzyRaMQd/jh6OwV2A0ZRZutEXRZFyUt+YtXQajK+Jo+0tXcAKHwQ1SPt+jPKiG6bPahUD6IBLEtYNxtHCqrNrn45mU7iuar/VlZorOCypKRIOATHj6l8RbguILl9AfFVRtTN5oXD3Z2CZSYi+F37BGGcPdq7htsiU7GsFl2yob3Ej67s7QOjLhrdTNgcKS65dP6V7LO9X+pn+pqLU43DGzYSm3F913d0kHRKu3HPVz8ZMgVSqRoQneGESkGEnUfGqgctsr03eBaOkaJcx+vk1tcnP7DuyeKssBrU0kga6itqJTQKl/298ALxxKfm/n/U5puBmpVtmOvUIjyTkYm/66IrqTa6LY2OTb0UeVQRtpl4gUl44E0FppsMuJkQ9eWT45t31Qa37Gq8t0PpBcphk5c2c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a867943-430a-44be-401b-08ddea210751
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:02:53.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svUrD3YQgxuz9R+cAr5G2/NOmcbb6cPCY+1xmJy8Fim7JAqLRn+9Y6LNszUa8aVXmgp6zxQUkqQDiJkQO4n1pFH5BZPHJlhqJrtl4B3PvBRNJXtCnu07Z7nAWR6PZ712
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020128
X-Proofpoint-ORIG-GUID: 6j7UzqV01GLGr0MdrAA9ejsNFYQi3Pww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX8naTcUwHRv9W
 Eun0tx1ODDmcgywuOTzGpwSnPVng2ASdOOWlTxO2aZULyQblcqdLmUE6TAa8JcFInOzOyoWMzCi
 Nlo2MUJCczUOl20CIQ5t84Q2s9lqHm7lpwcYnax6pEIdHni60bEGc1bMg4qJxobXJVOIZlaevBo
 IF0k/yCAd6WwxUkwq6/8+peIzt9Y5eCd7aWjsKfQXuL8paiHgJ4cZ60tgUed8OyxYSy9oq37ceo
 LvaHL/UTIxyjt2BW0MKX3ribyfmkKiwA53s2VQg2Bmbi+IyUa/oR2HPR2xOBdwTkmXznT103fXh
 g7lTfplkokhlEMrpD3djHASABap7jrG56DPCHngwwcxxOzmA0+DFxUyWUo0yhgfLoveUW9LL4mI
 ZAQus+8x86M74E97DKzMy8jlP4rEfQ==
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b6eb03 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=m6p-qJ6QTNPInMt6FhsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: 6j7UzqV01GLGr0MdrAA9ejsNFYQi3Pww

Hi Geert,

On 02/09/25 12:43, Geert Uytterhoeven wrote:
> Hi Harshit,
> 
> On Mon, 1 Sept 2025 at 17:57, Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
>> Use cat /proc/cpuinfo as opposed cat proc/cpuinfo.
>>
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> Thanks for your patch!
> 
>> --- a/Documentation/dev-tools/autofdo.rst
>> +++ b/Documentation/dev-tools/autofdo.rst
>> @@ -131,11 +131,11 @@ Here is an example workflow for AutoFDO kernel:
>>
>>        For Zen3::
>>
>> -      $ cat proc/cpuinfo | grep " brs"
>> +      $ cat /proc/cpuinfo | grep " brs"
>>
>>        For Zen4::
>>
>> -      $ cat proc/cpuinfo | grep amd_lbr_v2
>> +      $ cat /proc/cpuinfo | grep amd_lbr_v2
>>
>>        The following command generated the perf data file::
>>
> 
> One might say the path depends on where the proc filesystem is mounted ;-)
> However, all other documentation (except for two occurrences in
> Documentation/networking/proc_net_tcp.rst, which you may want to fix,
> too) assumes /proc, so it is better to be consistent.
> 

Oh very good point, yes I did check other instances and thought we make 
it consistent.

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 

Thanks a lot for the review.


Regards,
Harshit

> Gr{oetje,eeting}s,
> 
>                          Geert
> 


