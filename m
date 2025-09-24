Return-Path: <linux-kernel+bounces-830135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28837B98E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF22C1B2505D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738CE2857DF;
	Wed, 24 Sep 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QleDM5HK"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C202820D7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702390; cv=fail; b=biJr1eAKVxVnMIyN1SgW2GyOX5+HxBomZq1jQTBFf/ctkG8Cm3DvyhqapQsung8C4o4/EhFdD3pC6H3VR8Cy+jSxuRDQxpmm+2XE8BSccug8+kWpsRwlpqweHEX9eB2Qnxn9KgqpMAibIpuU63lPVmIAqA6482jBCRusE8RxSM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702390; c=relaxed/simple;
	bh=97PIY+NFkfywQz7BEtiO5QzdQQlcNmPtIkWduKkS5Kg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Go+7zrouxCyUYFfSRSxluzJwGjcsrBCh2LRQ67z5Fzy1LOlruh1zdwGZvfo1HkVfle8b60o8c7PfDKZ6pl0NFarq+HWfBeWeIJ/NRUCkOGpbGcRaul3oYq3yM6Lbg1eBsvv7Y7ziHQxCTWe6r6wnapJ4vFoj/J6UKjyZaJz0WZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QleDM5HK; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58O5oWWl898017;
	Wed, 24 Sep 2025 01:26:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/+vxHoUbixghqQPxnbGbhc8kl50p3vAB+Mt/mgeeKcE=; b=
	QleDM5HKJDzKHvK2Mw/0EGhjF6MUlTFiAWg0issqfDCFh/5aGmz6QqFUZUfuE7Gp
	yuI8YFSWZYiNwyTeQwhrPUfhYp4KYkkC6/pwQNbx17HyKPYVvcuOQHv/VlS3JuxO
	PZbwifkcavtiHjhr9jQn0+kQpReVfON4m6eE2hQTwjSH9ET1DoFwxS9vQFqq56lB
	PrFvwfypvsWpWAIzRrdPlPv9cWR81JPfbq5pc1pR+DVBuiuPBOuLp3R9JfngQMBK
	5e8p90UYf910FSwj8d2oOrQWH1RczPtprGa+O9H+zjGNFDW3/MqHaAW0GZpwDWUE
	iqdULRbMKv5/GSPswCamaQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499qj2vcky-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 01:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igF8W4UBzS0OT3oRuHKZ2sz+VMh1uRjfm/l8RiT0F7ggOJde8VRrUrk1JSfIvLUxDZFRvo1sneg9k/a96Qx9v32NAHcCz3AOrhc56bTywLyEY2obJV2S2lPXpLt+iVvWBZLVo9mWn+TIJnIbj3Ab2qNYVnlF9mmnjThsIVX1Zb726KvJX5Y24FGckuf9Z+tyKXKZBbHyIEI3ZIyMkK3IZ7Pv7S5jgdxzvC9JOhhreV25iWDeurcP4p0oeI/KsTfe3NUPuY2TMPFmzHCdmfCl5hPv4bUDAOXplnpFYHdgxvyArQjZW8gbjoaN0ZEcrb6tBh5TmPBTn59xQES4mLrHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+vxHoUbixghqQPxnbGbhc8kl50p3vAB+Mt/mgeeKcE=;
 b=hxSRhbZ+8D+0yDfzKCVk5vHkzB2y/UDMt89CFfpb0KCQ9Q7qECIxpq5HVX1g7+crXSMKcFs6mD6ZqN13cYtckURr1MnUkSsMpGpvNlPStYNfx1iI3tQDRmCL+pxmNZtz3iWokceutp3ub0XflilJfHTsdOObIQMa/jvGD2zdWKQ9QvhyaqtURA/N8lvRUldFjkGNibiys02gYz351q6e8DBzgPJHLQdT0WMxV/E6V76DSUB+HVF3HlpkAb5JPs0lwr1c24Xq1g53bnIBF+TqjSCNdeAabCbpsqcaJQbnifRsOm+V2dsSJdF9gw4JkIa/lpNla9t+e3a6njmd7nUALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by DS4PPF7CCC4B437.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 08:26:06 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::4b10:b3ea:35de:ab99]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::4b10:b3ea:35de:ab99%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:26:05 +0000
Message-ID: <57032268-b034-43e4-8490-2a5db66095dc@windriver.com>
Date: Wed, 24 Sep 2025 16:25:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: freescale: Initialize priv->lock
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-phy@lists.infradead.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250923141611.1295395-1-xiaolei.wang@windriver.com>
 <aNL0pDdQ4HfQH0ZF@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <aNL0pDdQ4HfQH0ZF@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::17) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|DS4PPF7CCC4B437:EE_
X-MS-Office365-Filtering-Correlation-Id: 19293ffb-5a1d-4a49-4dfb-08ddfb44013d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDFDM2s1ZDVibFpoRnVJanBYRlRMdW92L1AzOXFYb24ycmxJaitGaVBXZ01i?=
 =?utf-8?B?SWxoN05YL2VXU2RvMnUyM21nL0Y3Vk1oQ0tzc1lYZis3U3ZQQjI3cVAvQm40?=
 =?utf-8?B?cmQ1SGpKWVVUN09WdW8wdU5WNG9aMHAzSU9hSUlwTHJoOS9JaW10M215b1Q0?=
 =?utf-8?B?V1lSa1R1Ums2eHczdGJ3S2F3RVRoNmtjTVVIUGUweDBTa2xJeHd5NUFzZyti?=
 =?utf-8?B?cGY2MmtDVTl4Kzlra0JLcm5SbndtcW9QcmwwNC95ckpXcWtQQ2NjZWRLT2pK?=
 =?utf-8?B?dkhTTWhMb3o1MUtQNStUdjRtWjc5dHplTjZlZE1Edmh4MEEyc1o4ZnkxRi84?=
 =?utf-8?B?dFJkUDZGSStSaExya3c1UDdQOEczQkVhLzUzVGxaOURYYzAraWMyU3FucVRV?=
 =?utf-8?B?QjlJU1F5WUNyQ1VES0VUQjJCY2VCeWlGa3kwSUc1TVBYVWhRb1VWNUtFZ1BT?=
 =?utf-8?B?VXhHR1VYVENTd0VqRzZVM2FhTU5FQkdlZllqSVNVdkFjS2RwNUk5UGQrZHVQ?=
 =?utf-8?B?MkUxTXloUklMWHBnWERVS0lGUEdjRDIwSFBpc0ZINW54VkRkd2FGQU1hNWk2?=
 =?utf-8?B?VUpydjN2SGs5Z2R6b1hpWlllam1mSDB6ZW5RMVBHZmN4ZG5DOWM5NEQ2N1BL?=
 =?utf-8?B?ZmU1dDc3b2Q1aVhCQllCbHhHVVp0d1ZFTW53Ti81VzFrQzZyVjFSa1UxNmdi?=
 =?utf-8?B?NFc3aVRQTEpNeHBCbW5yWGorVXR2QUpEL1QvM1BCeFFTOGJxTDNpcFF4YmdP?=
 =?utf-8?B?WDBUR1B5YXZCRi8ydG1ITVNXaTg4Z2o0Q1lCeUJ2bmFsS2VTWHpDRHNIc1lY?=
 =?utf-8?B?Mlo5Qi9RTkVzOTk3UFJJanVVMkNGWkxodDFsYk1uOW1rQU5PWFRuSCtJYjFo?=
 =?utf-8?B?UEd6UnlCRjFFSjFzVHlkQndTOHRYU2oydDVJSnAwQjAyR1F0QzdDT2xwYmtY?=
 =?utf-8?B?NUZiellkV3Jib0RIZ3ZQNG5vLzdQV2FnZEU2MnB2MlhrSUxxbmE0MGtlYjI0?=
 =?utf-8?B?bC84U0R1dTVYQjdueDVEVGI2SDc1MFZ4REVqVUZRdzlOTU5selBRVkpCdTdy?=
 =?utf-8?B?bWMyMWMyQ3ptRDRNakUrcElNd3hqaVpQSFRtaDMrNk1nSW8wNlU5c3l5bzhG?=
 =?utf-8?B?TDFHdU5GWHJzd01Pa3lWZVlYOEUvRG90bEo3QmlSSnQyaXUzNmtBM3NJQ3Y0?=
 =?utf-8?B?RzEzMkU2Nk5NMEdhTUhnM3lTclB1ZHFqTUlEUEdkRUVkaWVSL3JPSEdYK25z?=
 =?utf-8?B?dThWT21SZEx1SzVqNGlmUmdYUUZQbWVsYlJBNmxseU56ZzV5ajJLL2loRzBB?=
 =?utf-8?B?MHI4OUtaS01sekcwZkNJbmtsOWlVQ3pGS2RGUEp4bHNMQ00vMEVudTBCZDIv?=
 =?utf-8?B?bFQ5ellEVzdtNDV0aUFsd29LZlFIcm14L2d5bVlqWWp2NGxwZm13cjRNY0ZU?=
 =?utf-8?B?K3I0UFFxYXhoWnlCS0dGVkJUS0t5MnFMNm9QYVdjaHdTWE01V3Z1SzFrWFdW?=
 =?utf-8?B?SUVBOVpHSDVLaHFSQWhNTVppZDE0QWFUTjZZRVBRWE4xRjU1bk9wZW5OR1Fi?=
 =?utf-8?B?RFFjcmRGQTRmTHJLbkF5Z1ZhamFSRnJzYkt2N2pyb1FaWWpZSjAvL2c3RXd0?=
 =?utf-8?B?WTdaQnBwa1J5ekl3d0cyZlJVYy8wYXRVNkhiSVJ6NHJkOUY2UGNHUTJaN2tn?=
 =?utf-8?B?TEZHZjBXY1ZOc0Vzd0RXNDlSTVZkMTc0cWZ3bC94TmNqUDRzQktjdDJTYVox?=
 =?utf-8?B?ZDNJYzVoaVhnZ0NtWWl4M0huUURQU3UrQy9MMW1sVEI2Slk0eWdmM2RMQlQr?=
 =?utf-8?B?Yy9rMEdFVk1Ma1YyNFhlRE81S3JaTTFBb3REYjBBZ2RkazJxWlNSZmo3L0Zo?=
 =?utf-8?B?Q3NCQnJOeTdJUWpxQndZSUNmVTJQSnZYWnNQSmRjeTVqUW5YSEkwajFrUkl0?=
 =?utf-8?Q?972PTaEBZ4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk5aZHBhWTRLSTF0OFFzaUZ4TnBSSnl0WHFPdEhWcyt1d0praCtZWkhuN0xD?=
 =?utf-8?B?WVcyU3hla1VQYlh3OWovTEQ3SGdzVUpsSm5ZbUtrY3VYRTI4QzhYMUEwb2s4?=
 =?utf-8?B?d1pTUmpDa0ZtbDNPQzFLWDMzL0FteWJFMVFJWmpEck51b2R6aGJBVDNyVnVm?=
 =?utf-8?B?UDY0Y3VuKy9YZk41ZmpsSjFrY1djTndta2tBTkZkcW5OQnVlOTZqRFNiMDJp?=
 =?utf-8?B?L0Y2bW1sRFl4cG1uNHdrM0V3N09UaEl6dVBPa2ZEWXVVUzFWYmlBVHZ3TzRi?=
 =?utf-8?B?OU5zTHFWWTd1bVRlTzVkb3FTV2RzMTVlNzhJYkxXOHFWaThITVlZalNuemE0?=
 =?utf-8?B?c0tyWm1IWUtDYmZOdStrbjVndWhzaTIxRUY2aDlHVVU4RFlkbGwrWng0UFJ0?=
 =?utf-8?B?dTRMTVVjNmZBZmZxL2ZUb0NYSkUzYjdBWjNmbEFpRG5wL0M4ZThjWi80bFpE?=
 =?utf-8?B?dFU2S2NGM3ZmNkJ4dXFianJSMGxNL2V0UGxUYko4OXYwc2dDT29HYVNhZFM5?=
 =?utf-8?B?OStRSExqdkozSjJFeGpaUTZaY1FwN2NmaXVOL3hiWEkrZVpnaWY4SS9oZjg4?=
 =?utf-8?B?U0pHNUdUamdDNzhNcnp0QVdqRlRRUkdjWmtEZmFreXB0MGROdEx6UjJJRDFy?=
 =?utf-8?B?bEowRk9mY2NjMEhnU3ViaExBdTkrczhqQXVqL2MvRzNEeVB2SGtIT1ZzR0w3?=
 =?utf-8?B?V28vUUl5MnNyN2d4YlRQOTNQbThrWVdsV0hPbVVMMmEvT3VGQjN4OTRYMlU0?=
 =?utf-8?B?YmQwRktaYzJ3UVlrM0dzN0N5dEgzY2JVRU0zTVUyVERNQWZ2Y044cHlXbFNn?=
 =?utf-8?B?VWtxUDdHRnlPL2FLaktuS0szN1VnUjlzSkdDRXovZWRHTWphVmVZNVRTSmJn?=
 =?utf-8?B?VFRpRkZIcTdGdTJWeUZtZ1ZxeTBOdVlWSWJub2dYWXFSc3lpNnc5bHJ4K010?=
 =?utf-8?B?MG1rTGtnZGt4eFBMcTI0VVFKT2FQc3F0K1BjSUU0TklQV1FHRTE5VlJmNlYy?=
 =?utf-8?B?MkFEbzZmYzR6YVhITVFhQkF6NnY0NHJMNjFyTTNwVHk3UHN0VWZHYy9FcXI3?=
 =?utf-8?B?SEswdnNiWVdnYnh2MytjSUR5clNSWjlHQTNKaFZldDJGbnBhTXFRdmxsUUZZ?=
 =?utf-8?B?NXAralpCZ2svNmsvdm5yWHNKWTM2Y080SEt0TjBlZGdDejdDTVhoTVlYSkhN?=
 =?utf-8?B?S1JEcmFuaVhBTWkxQ2VjSG54Q0IzdFViRy9YYXM3T0Y3d0JkR0x4Q1dPczRo?=
 =?utf-8?B?cU1xM0FWa09Lbkd5V3ZIZjF1WkFBMHdkS1FQUXlQclcxdXZsdmhLRG9peXRh?=
 =?utf-8?B?aUtPVDJ5cTdEWFpUMFg1a2hkejVpb0poQnE4UmRxWTF6TTZFcDRjdlJka3BB?=
 =?utf-8?B?ZUVkL01TYjA4UnQxVTZpTk9jUDFpdWpOcThpUE1MaXd5UGdKRjl0MkZrWmo2?=
 =?utf-8?B?Ujc0c2JQTTVIZk93RUdqRzNPRHZ3Qmk2QzkyZE9qZUVGM05xcm14YTJobmpl?=
 =?utf-8?B?Z3V1REk0SHdvMGhnR3NUVURaNWMvM3ZpMk91bllheFc1R3Y3YW5ySTEzR2tT?=
 =?utf-8?B?anExeVdEZ3BYV2I2V253MERyQ0YwdjFhM2VrdXNGdXI4WmkvZUpaWHRtOHBZ?=
 =?utf-8?B?QkxOVFN0ZGgzV1J6M3FZZjNnbjZuQWcxbFZzaUx5Z015bHVFdmdsZzNON01M?=
 =?utf-8?B?ZG0xdWY4Vnp4WjhZbG5Sbmc5WVNtK25hOVMwdUhybm5Tb1BYS2VNSmNjZXRj?=
 =?utf-8?B?Uk5lVmNVdGJySnJ5OXBVODI3MUpLa0E5aUVmRVZFSjZzVWRRYVgvTzk2bkFx?=
 =?utf-8?B?S0VucHV6Mzc0RlNES29sdTVIakFvSXUwcFdDSEhwQmxidDk3aGYwMTBIT0pa?=
 =?utf-8?B?MnF5QjAwWDh4aVBzSzczU1Job2x6ci9pNGFpRm9uYSt6OE9DSXlEMW94Q2J6?=
 =?utf-8?B?aVdrQXV6SFdubzY1SlhrRXhYQUszcW1rUi8wS2M3WEt0emkrZm1mNG1zQnhX?=
 =?utf-8?B?NHdURlA4bVg0b0J1dmczWSthbHhnclgrVkxXbFB3T2JnU1FFbDFoOXI4b1Z1?=
 =?utf-8?B?N3JKMng4VEFVeDJXOGFqQTQybHN1dDZOMUdLcnNNTm03aFRHTy94RzJXSVFR?=
 =?utf-8?B?MVBCeG9LMXVPN1djQkpPd0NRWnBCQndYblQ5S1N0a09aV2V0Vk5UTFB0a0Za?=
 =?utf-8?B?eUJEekFZYzN2U05FbnlVenhpemNFMFBQVTEwNkloZWRNcFJpVGxSd0pTVkNk?=
 =?utf-8?B?MitRV0tFWFVrM1hVa2pZRk1UK2VBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19293ffb-5a1d-4a49-4dfb-08ddfb44013d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:26:05.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWds63+Dw2nvdKXVfbx0r+ZXs3AM5u6wsJLcl9qUsTBmrTQVgpZR5rp0HqPQMlgTKemXl1Y5nI9U1QSKUFTiZIgAzSD3AmO+53YwZFUM9FI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7CCC4B437
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI0MDA3MCBTYWx0ZWRfX3dvttXyErtFg
 lszdHKzWxLi1Z7t8bTEtfrGTqnIPoB4ZVnGTC+2qnSiMeDTtoIm97rkFprAI9D2X5FqsDAu4GzE
 DWWJ9Dil6n/LfcN1ddymBrRWp/qIacPH1Vj2f+PZID5EocM3uq3Pt/FL5Afzj1724gm8W7NsZfR
 F9pPTWU31XkNFdVeLahJgLPtgXySrgC20YBvtWtHKo2hPXy6b7CRhuwcue/ZzKrFcsMb/IAq0NX
 xNFysi3ulMzwLPFoFfPRJAUaIfb7fb3kAnEC0Z0xKbiFtzXIUZYzZ+0S6VSOBZrzEh46t4/lD4T
 7lcujzpmmbIP68Pr+R+Zi8NU5OC+tTK/r7hw2U+X7TMiXZARaCqQU69jBPOl5g=
X-Authority-Analysis: v=2.4 cv=btpMBFai c=1 sm=1 tr=0 ts=68d3ab20 cx=c_pps
 a=1oswHZhTlIntAJ9aeONiTQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8
 a=JmqyOsm01RiUq3GRwxsA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: bAPfhqFBy51MCTOIrCB01l92yAVxFCYf
X-Proofpoint-ORIG-GUID: bAPfhqFBy51MCTOIrCB01l92yAVxFCYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun


On 9/24/25 03:27, Frank Li wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Sep 23, 2025 at 10:16:11PM +0800, Xiaolei Wang wrote:
>> Initialize priv->lock to fix the following warning.
>>
>> WARNING: CPU: 0 PID: 12 at kernel/locking/mutex.c:577 __mutex_lock+0x70c/0x8b8
>>   Modules linked in:
>>   Hardware name: Freescale i.MX8QM MEK (DT)
>>   Call trace:
>>    __mutex_lock+0x70c/0x8b8 (P)
>>    mutex_lock_nested+0x24/0x30
>>    imx_hsio_power_on+0x4c/0x764
>>    phy_power_on+0x7c/0x12c
>>    imx_pcie_host_init+0x1d0/0x4d4
>>    dw_pcie_host_init+0x188/0x4b0
>>    imx_pcie_probe+0x324/0x6f4
>>    platform_probe+0x5c/0x98
>>    really_probe+0xbc/0x29c
>>    __driver_probe_device+0x78/0x12c
>>    driver_probe_device+0xd8/0x160
>>    __device_attach_driver+0xb8/0x138
>>    bus_for_each_drv+0x84/0xe4
>>    __device_attach_async_helper+0xb8/0xdc
>>    async_run_entry_fn+0x34/0xe0
>>    process_one_work+0x220/0x694
>>    worker_thread+0x1c0/0x36c
>>    kthread+0x14c/0x224
>>
>> Fixes: 82c56b6dd24f ("phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
>> index 5dca93cd325c..9453ab98e475 100644
>> --- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
>> +++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
>> @@ -545,6 +545,7 @@ static int imx_hsio_probe(struct platform_device *pdev)
>>                return -ENOMEM;
>>        priv->dev = &pdev->dev;
>>        priv->drvdata = of_device_get_match_data(dev);
>> +     mutex_init(&priv->lock);
> use devm_mutex_init()

Thanks for the suggestion, I will send v2

thanks

xiaolei

>
> Frank
>>        /* Get HSIO configuration mode */
>>        if (of_property_read_string(np, "fsl,hsio-cfg", &priv->hsio_cfg))
>> --
>> 2.43.0
>>

