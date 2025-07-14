Return-Path: <linux-kernel+bounces-730147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D992BB040B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C3C174B37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A4253956;
	Mon, 14 Jul 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z9SBwRgx"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079B253954
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501344; cv=fail; b=GtNNuJU6Fk40HyCYKbN4xQoeHAoCB2VgQRW6cy7Rnd9Yy/PPPEOAcDLbJsGCF27x0QjN58c0iFk7fkNxOxU/WvVc44XvNIn8ZFfizlW+Dz21OHKQh77EOe9TeDHYqKP5JLt56VZXkz9rH3VPKrXGjVdVtD5AitbI1PsZruLPDOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501344; c=relaxed/simple;
	bh=KdcRWUfYjNi22FRmNZZTTJkU1PQS+qmooJuOuQtEACw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S5Ates2wtnw9Mmfm+TF3gCSgeDGOTa8D1Ds3Ymgv3a9azZLsJnviTumTuR2YLQzKOakOej8d4FMUpQwwb7R/nLJQhAoJxE10bDZRrPYf2n9XdfFvf1x3Yy6c9T7I8NHTXBBsGsjBUg6v1kFGlKpDbu8UuFlCw9i2O3klaLTxPOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z9SBwRgx; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySqPo5Fr9Cw6rYiHGz7ikLee9ETvlYFt++7DEylSsMlanM5I5aVwnqWJ+QlEhd2VqYkR+ls4aGXeUJPqaGAxROwxoihXxODKlEPpE+d/EFnLggVViGIeAO37iaOMsrJSWlZ/pXYFktDKCA8L2pI1VbFpEt1IlTTkWnxSnrHTX2iL79K38h4fDbzYKjBG/qNogDN6XuNzdcCA2x92G1rvJso68ckmH2Ds58bIjtfSFY2CGpOcBHU/1NJUBbfpmWG+7u9OtOXZDmYHz8+jROFOyTTsRqZccH42XwYZqy5KoW99tAKdvXKfIZQDsA7JWbYUtuNhbd9mGFy2yBCmFhfeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la0LBKdoPsK9MeHvsADCLOAXIBDqL/G2zlSgRuPvjfA=;
 b=oCs4nLEuteAMMbL2uoiOid8PiG6YY8c62/3MYpPUdL/1tcaZD7S91htpto5aMwk5T70uYeSByHcrvuqx26ciX3OH6yA5sjWpMQbkM8qsCeZ59a3yjuEtABamuSeYLIj9sdqIUTPUd/blz4EnC38SmsH+koYZ+Wg5KtNWzOMtTn40S8cmUKD1wS9vTrchIkW/SbIZD1NyEa3wUfgO2GWjb7kI05n3Q/UmBX6tLwy7vJVsZnuV6pTHbJzQ9AlS9qX3Jej6JQODkGjycppcw5mBDVteiOTZRxxuvdsCh2tDsfHRn+PhCsGziEotts9z4HBW0/TqxOBKUyxxm/PC+OxDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la0LBKdoPsK9MeHvsADCLOAXIBDqL/G2zlSgRuPvjfA=;
 b=Z9SBwRgxws2RxoNs2tzLbPbl0dRKqaRjvJfRhVXg62TNCc99Rc4WSyyB7KZQSXLYyeQ26OA3hdjxHS2d4BIlv7O9wJhth3mWif6R2+Wa+3y0NEJHtPS2tgOc4vZSmJxv1OBIMSm+lDJ9Lz5/sEuWvRqzNoICOstold99N0Up5/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by MW3PR12MB4393.namprd12.prod.outlook.com
 (2603:10b6:303:2c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:55:39 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Mon, 14 Jul 2025
 13:55:39 +0000
Message-ID: <226304ff-e8f3-4ba0-812c-f1356d4d8de1@amd.com>
Date: Mon, 14 Jul 2025 19:25:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: introduce snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, david@redhat.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org,
 harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <cover.1752499009.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::10) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 972db554-800f-4020-18d1-08ddc2de1d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHJ6N2JqOWIzSjBROCthdUQ2MzRGVUdEdzUvWnNKb0JGdDR1QkhnaHhBNVI1?=
 =?utf-8?B?WnlwRW1jRDNzMlJsc05sK2pQUlIwZW5XNXJoNGxTaHlWOVhCZWRHS0hPNFN3?=
 =?utf-8?B?RGE3QTN5d3FIK3hzQTd4djlZZ0ErWTlwVjhQRnlhaDJWSkEzUTBHOFExOGFY?=
 =?utf-8?B?SXZmTmdWaTRQSjQ2SzNWZTEwN05KdExPK2s3S3N0MURUcFJFMzdzTXFzWFM5?=
 =?utf-8?B?K2d4OFNDRkF3aUlSSzRZeVcvOU85MFVPTmxBTHk0K2lSKzQrNEpQVHZJS1hl?=
 =?utf-8?B?ZFNiVHpQTlgwakh1cUtGaHpGeTNWSU9TZFphTW9WWisxYW4yS1gyZEh1Wk9z?=
 =?utf-8?B?WXRKWm1yTXN6M3F5aWdFVlpYZUM0Z1FTVDJJdU1jT2ZhWnFCWWJPRmt1Sll0?=
 =?utf-8?B?WDV3Z29RYmdXZ0lqT0JNL2hxYzNKZVBvTTJSNmhtSjloNkxiaVZEUHp1V2ox?=
 =?utf-8?B?VVo3dXV6bXRqMEpCK3I2T3dSU2pualhCWE1uNW92TjFXdmtqYzhYYUcrTWdo?=
 =?utf-8?B?YVJFVTF4MWVuNVZZK0lIUlh6bVN1QkhWdlJReTF1V0tyanlnNkFzM1cySWpH?=
 =?utf-8?B?VzlKU3RsT1p5M3F0V2tjeS9CK0lkdEYxcEpCUy9iS0ZCc3l1ZDMxRTBRMFZW?=
 =?utf-8?B?SEgyMUZleFNZNjNVYXI3TGF4ZWNxU05objZiRkpXRFd1VDBnWkduUzhCN1VT?=
 =?utf-8?B?cExRLzVXakk4bnhPM1ZId04rb2RzWWU5YUFmVHN5KytHMVp2UFlOUzV6eFc0?=
 =?utf-8?B?Y25XdHV0aVFzMlFZYWZYenZHRmNNQ1VXZElpMDhxSkV5SlVEWGU1OGt3U3Nv?=
 =?utf-8?B?elZQb25Zc2dxZXoxMkVvd1dsUU1lWG5NdWRPZnF2T2ttbm1uOGhNUWpyekhZ?=
 =?utf-8?B?Qk8zeUs3S0dNVHJnQWdZY3ZidnMyT0MrY3ZnbnVIdWwxQ1FkdU1RUjBnM0gy?=
 =?utf-8?B?dHdad041dnlXYXRFTlhkK2FUMGtrOW04YXJSUzh3dHVia05BZVB0eGk0aDJ3?=
 =?utf-8?B?d2xjT1JBQ251VHJZd3k1SWpJZnVMYVNvdVRhdEVrd2g3bTFJVFhVa2xjeXNF?=
 =?utf-8?B?cnNNNWswTEJmLzdHakZsMjNBcm00VW5XQVBMZG9BU2FXdlZOaktTQkZHWkF4?=
 =?utf-8?B?c2EzbEFic1c1RHRnN3VaTFI0dVlPZlkrUjBTZlc3c3Rib0t4M015TTB0U2hB?=
 =?utf-8?B?eFFGalRCUXU2dE1xNzVQbm1zRStlSkwxbHY2UzR5L2pEZUdySzJUQmoxaUpT?=
 =?utf-8?B?RG5vbDBIekNyTUVjNDZibDYrcEZ1clB4ZUVPcnFMYnZMS2tzcVNTdnU5cmow?=
 =?utf-8?B?c2YrS3lxd3N4c0J1SXVzWktWSVE1djVHU3VSQUExd1c5d3pvdnVnaWMrVlVE?=
 =?utf-8?B?aXdIZ1NmQ1BnR01JRlVkYStiazVSK05mdmFNM3g4bHBlNXdLdVZnTVk5c3kw?=
 =?utf-8?B?T2ZjY1JEWkJyTWN0YUpuNlFLSXVPRVl4OSsveU1QUFV6VFNuVWlUcWZvRWlD?=
 =?utf-8?B?V0txQ3JJeFZFQXo1cU9taXI5ejlBd2w5OUhKZE5XdGJkUGZhcnMydysyNGVU?=
 =?utf-8?B?eGZManRuaTh6dlFYNGtEQzBhTnFiQlhBVkloWUhFOHllQlJ1cEdDbVhJQnNz?=
 =?utf-8?B?UVA4ZFVRQVpyWmduRTczTDdCTENFK3RndVUrb1I0U2tBTGFjOWRRMzE5MWNU?=
 =?utf-8?B?TCttTHdhcFJORlhjQjVUdWpvQ0Z0LzVSQ3l6MVJXWHVqQjE5aXVBbnlwSW5r?=
 =?utf-8?B?cU94UmRMMFNyaEJvWURrRWxOSXNBRTFMSi9ERVRQelhTVTBvVzc1SHBFVGts?=
 =?utf-8?B?aXJwNWRFMnpOdE03L00wNnEyZVZuN2xib3lWM2pGWk56d0RPd2JUSEttelo1?=
 =?utf-8?B?cHU0T0JRT1B4c0ErSms2OEkvVHRuZVN6RWV6NHFxU0l0VFpiQnBQc08zZ3dU?=
 =?utf-8?Q?b+f7BidoFso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFRKcVc3KzZRR1hON2gvSnFaK1dZYjNTck91M0JCbHI2VEhBTWpxMHY4YWZD?=
 =?utf-8?B?Mkx0ekdwOWFZWUNtWnNYZkI5VHNFNDhHbFRKdHFrbytyd1dUWEpRdkpsQnc3?=
 =?utf-8?B?cnpLcS9ibU1TclkyUnh4UGRVRlJiY1RmU1FTMko0KzFwRnhMZ2lpZjNjQXVS?=
 =?utf-8?B?RmVtVnlYYitEOCtFaEZ2MUNDNExkTXU0VVBza3BDMlVzOTRMUkNLekRFM1hD?=
 =?utf-8?B?YU9kY1JzWDU2NDhwSmJuQW9vemVkODcyRGkxT1owOHdOTzhJRDhUWGpXWTky?=
 =?utf-8?B?L1lMdmZIZytGN2xZcGR0N01ONVNQTDcwVXhMMjNjNXVUTzBXMEJ3ejFsSXox?=
 =?utf-8?B?TjNwTDRWUUhkb2hEY0cvOXBGZW5rQWFpVUdUSURxZGpUa3lFYXRHWWg4VU4x?=
 =?utf-8?B?MFY5aGRPVmhRYU1rU2lZL1kvSXdwQ2JWdWdqZ0ROMVRSTkRjalNwbVZKZDJu?=
 =?utf-8?B?Vjh5d3ZYdGxSL0pCU2ZEdDJ6RHMxMkMxWHhwY3RiY0Yydld6bmlsd2hya1Ni?=
 =?utf-8?B?aVMraWdLbENDc1ExMEw4UlppYWcyR2FrREx5ejB1OXpzclAvb2ZORmJ3dlh6?=
 =?utf-8?B?RmdvRGh4S1AwZTZxckJEQXRkeVpNd0pSV2RYakFuNHFyQXpFZ1dmRkdJTGtI?=
 =?utf-8?B?UlRsRVN1UytwOVhYNFRoY0FYY1B2M25rbjRWZjBFNmxOR2NRdnlvdVdoUEJH?=
 =?utf-8?B?amR2ZzUxck5YQVphTWM0MVhzNzdiQlpRd1d5TWFQdVdrL254Zm9YeU5RN1Mx?=
 =?utf-8?B?WEw0RVh3NTlaaVdZaC9PVlFJVjQ5dVVTd0UxY092THYzRkhyY09jczAxYnNI?=
 =?utf-8?B?bFZuMkkzVSs4YjRVcEIzZldYS2VrVXM3YTBmR2V0RVcxaEE5eENoRzZiY3U3?=
 =?utf-8?B?M2NZNjFHcVV3RXJ3aG9YNUEwOURjeE1iMGhKdnZnYlBwRmliUVVSWjRZbzJZ?=
 =?utf-8?B?WCtTSStJTUR2SnZnNnorSGY4b09hemI2SU1SNVdjQkY4SFBtOTAzMmhXVTJN?=
 =?utf-8?B?OC96Sis4ZFhZOWxLNFNaTFJUQkRoSEkvaVJWRFB3bVJMeXoxNEJZd3RZUWRR?=
 =?utf-8?B?RWdpazhXc3Z1S1ZXVXFLWFVqRk9kYXpBTm5KVVNlYStMR1VSSis5U0tMMCt3?=
 =?utf-8?B?ck02Mm1iRzZVY0IydFlmZjJiY2Nnc1AzVW5maEFwcVVhUlBXb1ZSNFl0Z0lI?=
 =?utf-8?B?VWltcDlwUTBqZGE3eEpTbEVqUHJOSk1rdnFkbjRsdk0vRHdIMG0wcUJRMmdO?=
 =?utf-8?B?U01oS2ZiNFF4UUVFQThSNnVIYkV3ZHQzOUFWUzQxdWlxMWxqVEpwM0FRNzJp?=
 =?utf-8?B?bnM1MmwxZEZhKzhhRngwQTlMMmpIMkVXQ1IvUkhoZWZQOFB2VU1iNVV1MXd1?=
 =?utf-8?B?ckQ1QUtFeHgvUDBUdVdBc0FRS2F2bm84WWY5T3F4Um5TZVdsRXlmUE1YN2lz?=
 =?utf-8?B?M05oQWR5eC9jNVRyTGxZelV2NlErWUxOc2NtdTRyVVhIOEZ4TXJTR0s0dDZJ?=
 =?utf-8?B?aXdHWXlqbGpUUHppQmdQM3hMYkplWW1HYzZpODZUeXB5SkI4NWIrU3QzTTJu?=
 =?utf-8?B?Mm40eGEzc2RpM0ZJTEhHRTZydjl4cG1qOFNqNU9tSTNUTENKVEVlZ1cvMHFQ?=
 =?utf-8?B?K25DV2d2eGtLTTJRaVEraDg2eUxZalM0MFBtaTV6RytXZ28rRUhhblI0ZlBR?=
 =?utf-8?B?bW8xcEtHOG5qR2ZqUmlPWnpwM0tDR2kzTVNqYWFFU2I4SXkxNm5LcVBpeUJm?=
 =?utf-8?B?ZkVoemc5d0pTK0ZTbzkxRzR2ckc1VGFoems5UVBEZ2Z5UWhmSGxjRmxJOXZq?=
 =?utf-8?B?N05LbjNWeEVDY1BBc3pZRWxBWEM2ajZEVGdPY0Q1ZnhaWHNOWmxNaERpRnhX?=
 =?utf-8?B?ZzU4ZHhmbEhFQW43dVg3Z0RTMFErZ1ZnRnRPNlk2TGFmUUtUZ0ZvdjdJUWNh?=
 =?utf-8?B?MERVaDBsZEZ4RCs3RlRjUWdES2NWbTRHcU9mRUZZcm5uYkpacU0vbHlXY2xK?=
 =?utf-8?B?cUNpcFo2Z2ppV0dNV3QremJpYUY5Yy9mYnVIN0hiaFJHUWhpTjdTTUJEN3dX?=
 =?utf-8?B?SnptZ0ZLWWFrcFRjdFhMazZPOTFSQXdzRElFODlRWXFVZHhDanFHM0pQYTFq?=
 =?utf-8?Q?EOgxtEIDtVdbCq77eTeToICTK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972db554-800f-4020-18d1-08ddc2de1d93
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:55:39.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNsKCCUup+ZHqUf0T2hVqLUhwtEyAOOFqDhIDajqJ99AraXr9Q2nG0idZSDyoPtFL22DF1eDFJ9/46NmKNf3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393



On 7/14/2025 6:46 PM, Luiz Capitulino wrote:
> Hi,
> 
> The series introduction will follow the changelog. This is against bc9ff192a6c9 .
> 
> Changelog
> =========
> 
> v2 -> v3
>   - Small snapshot_page() refactor to simplify and fix stack-out-of-bugs bug
>     reported by Harry Yoo
>   - Use clear_compound_head() in snapshot_page() (Shivank)
>   - Read head pointer from ps->page_snapshot() for tail page case (Shivank)
>   - Improve comments and macro name in snapshot_page() (David)
> 
> v1 -> v2
>   - Include is_huge_zero_pfn() patch and use it (David)
>   - Move free page detection to snapshot_page() (David)
>   - Changelog improvements (Shivank)
>   - Added Acked-bys
> 
> RFC -> v1
>   - Include <linux/page_idle.h> to avoid build error on sh arch
> 
> Introduction
> ============
> 
> This series introduces snapshot_page(), a helper function that can be used
> to create a snapshot of a struct page and its associated struct folio.
> 
> This function is intended to help callers with a consistent view of a
> a folio while reducing the chance of encountering partially updated or
> inconsistent state, such as during folio splitting which could lead to
> crashes and BUG_ON()s being triggered.
> 
> David Hildenbrand (1):
>   mm/memory: introduce is_huge_zero_pfn() and use it in
>     vm_normal_page_pmd()
> 
> Luiz Capitulino (3):
>   mm/util: introduce snapshot_page()
>   proc: kpagecount: use snapshot_page()
>   fs: stable_page_flags(): use snapshot_page()
> 
>  fs/proc/page.c          | 50 +++++++++++++++-----------
>  include/linux/huge_mm.h | 12 ++++++-
>  include/linux/mm.h      | 19 ++++++++++
>  mm/debug.c              | 42 +++-------------------
>  mm/memory.c             |  2 +-
>  mm/util.c               | 79 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 144 insertions(+), 60 deletions(-)
> 

The changes look good to me.
Thanks for addressing the feedback.

Reviewed-by: Shivank Garg <shivankg@amd.com>




