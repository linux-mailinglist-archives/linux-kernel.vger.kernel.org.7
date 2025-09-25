Return-Path: <linux-kernel+bounces-832472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26007B9F687
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522714A2A85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFBC20B81B;
	Thu, 25 Sep 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GBdZAt7x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gk8MjOnq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F61A5B9E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805548; cv=fail; b=fpwFOOCvGPfLzrAbZEDimpN0jsFfhN/GzDSdJe42QK57xTZTOm8mX+gy2iD4B7AY/qeGl3bTaRveVvNV6O9n0BObTxVQkeDbk/6TVdyptYziGh/+hiLTCbVL+KulIhxY/UmtFtRHlop8JMXt+QrAb5liAOPWwNsXYxo1kALxgj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805548; c=relaxed/simple;
	bh=rie0Mi01Z2VhY68NPwlN5190EaJM3jb5vR3ogl5THvk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b4sMCj/oYW9x63LyccZcFN195V+7V5bQuHHgwZJSJe8H1/w6rIGkZgFhGRR+ZdqNiTQ8+LivnfzvUegCz5kOIIxaQxWOGO6efM/1ayjXKBO7K9hH0Wb7CtIqg/vYQ7JS6QIsF22ba1WTDvxSbNFK5E++v3mKavF68JcU7P8HBHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GBdZAt7x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gk8MjOnq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtdnu018631;
	Thu, 25 Sep 2025 13:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2XXnOBRheBoYQvpZp+/n+vtNQwv9yysx4p4E/lvB690=; b=
	GBdZAt7xq8xbb1m4bxd0wDyt+uMOyeyAmEjz++/TrPUgmiTTu6q6qT3MbYeDSmbn
	4DLafTQ9DJ4GVB6AYGDEss90Ljx5CyB5TPh41YIbA4qksm7Zu7UWVokvPJ7ixzue
	aA9Rac9fnXZnvCZu6m9bfdZJOfXz5YknlGpTPip7CPSgud0jcVsiOt8XP7HwLQsp
	OAUYjc5srCymbXFF/FsA5PxbH8ELp0GQd2ZyiNwy97E9NpvkqZyi7SMBBbC0hIi3
	B5kkAvzoKSXMQFjFVCwln+u2epf9haNVzooCGYhbK+YaGFbdAzBBYEXnVKo73PTG
	DFXIcq3GAMMHGDGiJAPXLA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k23hxyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:05:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCUuEk010707;
	Thu, 25 Sep 2025 13:05:39 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nnfaq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY6AHmGOdmVS3Yjp4t9A3m9hS5pHiKmoGc5vSvID4TEoKW6hipzAmULOy75vIqs8GC++lLLDiM5WSjaQyHc0CPc0x33UUN3mVJ9QSwinQGWNoynpQWiyFsl/Om0gxU8Fzwlh9Yq+yb4pWuIi5s7T2vULeaIMmqTu7MqH9MREyLhvSkV3J4yGH9DO2RSV89EwqALWlXIitMDOQX3Mceu8S4NS/5cCZ9/3YeiJplDQX6Asp5vqqqKggpHfSS91Kj2hHWqy9hlBUij5yM8gnd7NVoTZ0LvEWs/m1ROEMGUkR5kh24OkrrgtO9/15DCXnQLCExdTa4r04tjXtSzKhdN2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XXnOBRheBoYQvpZp+/n+vtNQwv9yysx4p4E/lvB690=;
 b=mPCYxOtPA+9CXB8HKb5XT25lh3somuZ876Odu33SvL8BJxo6aVoG1gav+qemiH8IsuIprzukjrYvWAmW+Cmj+aPq1Vv+JOKPSmihJGu5LmRnIx3zcmZ0rPVoKCfEIXnEPzQJshoOLPb0TOjdZMc7qkuYo6hcaCCze4puTz4zDDe406eOufJDBUm83h1YoS4QUhwZKWNT+TifjFMk5uWjg6IY0Cjs9OscLLA0q/fJYu1OkJjP4w3dNdbo9JUBFGxLRoDC+LSxAssCU4dEWtpb4qY6VjszAi40knk48CJ9chII8ZZeqo80bf/yt98+aB44LlfyMAlPMUzx3+h/if1nKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XXnOBRheBoYQvpZp+/n+vtNQwv9yysx4p4E/lvB690=;
 b=gk8MjOnqxVJ+FLkLFeOSpE7FuVak1pLYOsju64jTk4Ed5E2ap+aXYyT56XGKnEyMxwdGJivu1mfSALjYxB3WrhGc/3zGEuFflrZN2N6gGS/ShCu7Z6zXWGhGJm/BBJ03IvBdoIp4KofXAULN4kfl4ZHHvPkk5mD1FSTvWbtOKRo=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by SJ5PPF0BB87A13E.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 25 Sep
 2025 13:05:32 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:05:32 +0000
Message-ID: <a04049a0-d626-4f42-92ca-0e6d3b847d6a@oracle.com>
Date: Thu, 25 Sep 2025 15:05:29 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, jpoimboe@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
To: Peter Zijlstra <peterz@infradead.org>
References: <20250924134507.288529132@infradead.org>
 <20250924134644.154610650@infradead.org>
 <b6aaa53d-2658-491a-9308-32ae2b5aefb1@oracle.com>
 <20250924184158.GZ3245006@noisy.programming.kicks-ass.net>
 <f17d5e92-2aaa-43e7-ba67-ea5e7d07601a@oracle.com>
 <20250925100323.GY4067720@noisy.programming.kicks-ass.net>
 <20250925104251.GZ4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250925104251.GZ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0124.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::18) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|SJ5PPF0BB87A13E:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b21b6a-161f-4a33-45a8-08ddfc343568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWNiM2xYenRZakJHOW1PYVJ5R0xiemxqMldKdU91WTVPc3k2SmdDQzJNeDZq?=
 =?utf-8?B?RWJETDRyWUFXYU5keTlURzYxaHlXeDlLNkpCbjdscjdObFlzYjFQVDZQTlFv?=
 =?utf-8?B?ZmQxWFd3UzV3TWErWHQ2TUVwUG5aVm9naHY4dmQ3VjRNV2s3UjFubHlzRzh6?=
 =?utf-8?B?bWxLZ2oxNkNMMVFVajY4aU1WbVBmQnF5UjF2eDlTQy9vSm54MGxaY0FtUW9v?=
 =?utf-8?B?VlNJU1FZYW1MU3FmajVXMXlxWnNhK3Bxbld6UExxUXowK0g4WXQxb2NBTHJz?=
 =?utf-8?B?VlArVTNhUmt0dnIySTNYOEcrY0MvMmZCSW9BRHRYUEpCRFk5MUN0K1RFR2sv?=
 =?utf-8?B?d0ZPcWd0RUtqc3BjcUYzUVU5NmJ4Q0NMMC9xL0ovbXZhdWFDZHhsK1V6MEcw?=
 =?utf-8?B?Q3YrdDFuNml5cmxBUnMxSlpVR0tUZDR4V3NDTDEva09xbnBjNWkrV2xRQTNu?=
 =?utf-8?B?VGswdUowMnIzN3B0L2Z6WE1ES1J3Z2cxSFF0b1pxK3B4Vkp3Q2VteXhTZ05J?=
 =?utf-8?B?dnQrV1RHMC95N1FBL1VvZkNLOTlKK0R2QmZ6ZDVnZkdkUHFNVmJQbXQrUnpJ?=
 =?utf-8?B?MmdsNVl1UEZwM0Vtayt2NGJLNmZiNXpoRDlZU3l4QzB2am9hdGh3QmZtRmpO?=
 =?utf-8?B?MG53aURUb3NhUzJCdmpraVJFdHlES005UUxDUCtwZEhjNmJLdGFFSDZvbHcy?=
 =?utf-8?B?M0d0YWpRSW44L3BCQVRqMnFzbXZrVVl2Sm5nNWZuRTloSmFxL01BQUNmZXdB?=
 =?utf-8?B?SDcyNTNqeHJMaU5HaGFwamI1alBqVzFjblBBSnpXSUsxelVtRGVtRUdKalFS?=
 =?utf-8?B?SEpFQmRYN0ZyZjRPNFI2UFYrM2hlaUdXTU9XNUw0UWozZktaTEd0ZElEYU5O?=
 =?utf-8?B?SkIrQktPUGZ3Y2dWa2tGY1N0UzZvSi9iR1l6U3RrMFE1UW5qSUZyRzRwbnov?=
 =?utf-8?B?UVZXelYwVTVINCtBL0F0MVBMM3c0UnJxOG5pdWU5YlpnMndyODk3Q1R3M1RL?=
 =?utf-8?B?M2F5WXlwZ2ZreGVuVFdmV0htS0FYNDBDRUFIemJ2Rys2SjlCMDAxaFQ3WDNR?=
 =?utf-8?B?ZXhQOXRoQUJ2QVNwSmszdkZFOGYrUWNwTTN1ZUJkNVMzV3ZLTG0vemxBOTBy?=
 =?utf-8?B?Z0dmOEJ1ZTdvV2l2ZHpaVVVyRmRCS2RwOVdPUzF0b2NBemlHZmlNUnQwNFVw?=
 =?utf-8?B?SWVqWG5UanB4d2RjMEU2QWpBMFRDc010VFJlWS9WTHd0MGx3OHJZTEtqS2VN?=
 =?utf-8?B?dTVYczRucGg0ZExoclpveEdCdlFWUTd0WC9EeGw4d2tncExJTVhMTmt6aXo4?=
 =?utf-8?B?V0E5dmNndE94RkFlRHJ5RnBRYk5VM0FMd08xRm52WTh6TkpYdWUyemxWejVk?=
 =?utf-8?B?K2xDMkJOMllnanF5WS92dWgrQlVUSElwZWZCaVVpMm1PRFBCeGdyTTRlNzN3?=
 =?utf-8?B?ZTBJVHFPcTlTT1FkbWJDbUZTR1IzVXh4aFNTWmV5MHlXbjVYbldEVkJXVWpP?=
 =?utf-8?B?c0pRYlhGWmp2MEc5SjdUcXcrQW4wd3VqNlYzOGw0R1p0TlVtTmMvQWE3dUNv?=
 =?utf-8?B?bTRjTUZRd3ptRXFVdjdBTm1IQ05MbEhYWjBjWnZLdVE3ZDg0NGQ3emV1Tms5?=
 =?utf-8?B?WFh0QU40MUtybXcxK3hGLy90Z3B2TnFMWmZ1enh5M3g4bi9TVGc5VEcxdjFY?=
 =?utf-8?B?ODZlQkprTjl2SFdOZXVJaTdRMjVuOXp0NVovWk5JaXM5Sk9xd3Fjb0tMMFY0?=
 =?utf-8?B?WW5VN2t1WDRHdlkzeXpRdU44Rko1S2dOUmtrVTNZOHhUbnljaVY2KzkrSHJa?=
 =?utf-8?B?cnFzYTlMYnNJUnJnckpHZVZGQVhYc2lPanBVV044TXBZVDlqR1B6WSszUzBm?=
 =?utf-8?B?eG1jYjlRbHgrWVVDbFJ0NWlHZUdzbmttZUxSRjFHRFRWZEdCaW1xYXkvalY2?=
 =?utf-8?Q?sGeZGO1f/YA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW9pSUl1dUJkamZDSG13bkNpYmFQRHM4aXJEa09nb1FFem81VEVHZ0twQlIv?=
 =?utf-8?B?YWFLUXF5UStkazNzSk1lWkNlOGNwV3RpRkxHMTY1VzJvTDNaMWgyM2ViazM0?=
 =?utf-8?B?UXBXVkJoSlpnNDZQRUk4MFVjd09oRThKQ3ZkMjQzeHoyTGtmQlFQcDgwNEJQ?=
 =?utf-8?B?aUFaWGRwLzJNaEp3aC9XcDhUaHlZcFJoUm9MQzYyTUhoakZURDUzTXFHL1Qz?=
 =?utf-8?B?cCtLbndScUZ1cmRxZisrT2hMNWg4bUlyelhWRDZiTVFKTGd6a2dMY0k0L0VK?=
 =?utf-8?B?UjEzTlBzenYxK1FGRkowUExnN2VDekhSU0tKREhQL2RKcmFVVW13cUVHOXlH?=
 =?utf-8?B?S3hZNlhtMnhRS0ZXdEREMGxLTDVQK012OEFxQk13anNUb0R3Rmh4QlR5aFJ4?=
 =?utf-8?B?WCtYK1pwaEcyRDNIUzdjc2JJOGxtVXhldlcxQUVLdjlPOGRuZjZ0VGtMbzcx?=
 =?utf-8?B?bjU3cllXWWljUEJzSXR3YTAvWG1ndmFveS9zMWlzZzdQdnBkNndmWjlqbHpK?=
 =?utf-8?B?OUZUb1dseUtuOW1JVWRkWjZXNjI4YmVMc0lyaUF2bG4wUGp1bEE0enlSb25P?=
 =?utf-8?B?NGg2bjNUVjNhVjBkcmxRV05velJwQkw5T1F4WnhSd3VDeEtuZnNjSnBsU20v?=
 =?utf-8?B?WTRITmZJd0liQTRyRCtGdTdkTnBRU256NVF6YWtYU0lWVzEyelUzbC81S0Zy?=
 =?utf-8?B?cytNWUF6ekVURm93TmlFKzJsRmpKbEFlRU9ZTHZHRjdUdzArcFR2MlNFbzlR?=
 =?utf-8?B?cHF2Vm9KTktra2dvYlI2cXJFQjJvVGNEQ28wV0tydjl6LytOZStMSjh4eG9k?=
 =?utf-8?B?Y0xhVmJTS21ZQk5RNTMvOS9nWmNjNGFJemtLakptT0REaW1pVHErOVFYLzZr?=
 =?utf-8?B?Rk8xOEFxY3ZpSW5TQmtLNEg0Q0ZtYms5cno4eGZvd1NRc1ZlQ1YwRmZzbjhp?=
 =?utf-8?B?V1dGdWV6djd5OVpzUHZ2dDFHaFVvRy94d1QvNHhBSGJRMjFacFI5TU5sb1du?=
 =?utf-8?B?Z2FQemNrZ1VBbkxTOUZkOGo4bDlIdTd5WHVkelA4a25EdE1ibGRPNE9Ec2dv?=
 =?utf-8?B?SWlIWlZaYXZBTTRGdmtJai95QVo4U0VwdSt4Vk1yY1E4VGZBQXJxZnJDSmUw?=
 =?utf-8?B?MS9FZURDSnU3QVlIN2pXRlZrVkxQZWVKWUFTTmd4M3FCekpsb2pnY2x1bFo4?=
 =?utf-8?B?TFlyWnZTc1E0NEFOb1FKbjdIb0RTeFVrV045WFVXanhhanpyVnBDNFpSaVJt?=
 =?utf-8?B?VWh5eE9naHV6YkZZQXRsUjYvTWxLdUpPUlNCV3dzWVAvTXoxdGNva1NJK2Ew?=
 =?utf-8?B?TTJXUldNWEpRa1BsTVNxV2trOTc0ME1YcXJwUFB6bDdsWnkrSUp5Tk55VHRR?=
 =?utf-8?B?QTltY2RCdzZQbzRYUnBXNDhmVU9PcHpERFN1TlBkYndQNkFCbkI3cWUwRzZy?=
 =?utf-8?B?TjV0d2g1KzF5azU3UDgzM0NLU1pNc3RIQlZXTXRHNnU4eFNXeHRMdGpsNVlF?=
 =?utf-8?B?MVBUQUZBK0diUUtRd005SGNLaUdsV3FHOFpVcDRDSm1FeTdaRk5DR0hQMlBq?=
 =?utf-8?B?UkJMRXVYeDk4Ym5tRm9WVTF4THliWXVLMWlrRDduWkRhdEdocmM5bmVmYVNm?=
 =?utf-8?B?b25mYVFabzZWZlJBcTB4WmpOb3J1dHRHN0paRmVocFBWL25FSm1Mb2pKdUU2?=
 =?utf-8?B?KzlmTnByUHJSbjk5NkpQUUxGVTltWU1HSVN0S255Ti9LbEJaUFp6ZTFNLzVH?=
 =?utf-8?B?R2NaVURscUVmaWs0SThaUUlGZXlXa0M4VWhYazRZck9TSnV5eXRQTmkraU1Y?=
 =?utf-8?B?eWJYMWRZSUNvNXFPbi9wd083anc3Nks4MUwrNW5laDNGRWpMK2dxSnhGYnFi?=
 =?utf-8?B?KzZ4a2dkYnJoSUphMDdtemJ3Yjh5WXFZSUNlUzJVa2VwejN3NWpCQ1Z2Q1k5?=
 =?utf-8?B?ZVMrSjk4Ti8zU3pnNDR5WFhiVHExcTM2STQyYUZKTEg1K1RTeFVQMHBkWHhR?=
 =?utf-8?B?dGVzUGZkWFVBdXlrRXRvZUxOY0FIY3dOdGM3QTdQc0lkeUJjVkJaQWU3MC9v?=
 =?utf-8?B?cWQzRUEyVytaeXdoRllSREVxd0EwR0pZQm5BZ0ovdGpaWXZLM2o0a0JKamZm?=
 =?utf-8?B?N1lJYVF1Z2NaVU42dGZ2YUM1WGZQL0lGVUdKUTM3MW9MOEx3REpjWXFUYUhY?=
 =?utf-8?B?NysyK1VadERxWmtGLzBRb3lUeVlKZ3AzNHJkQjNKRGZVaEVId1BLK1A4NUFV?=
 =?utf-8?B?ME55bjFaaFlwaERBb3E5cWRkc0l3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HGSGQQYCDcznUX5HrULl+oBdISSOKo3M7C/d7zfOg4LqDbZ1wSdZFSRFktYnQokW3IVnuL5FdkEi7da8itomwnD2rKxyUYG39eVkSg7dhsVxg1Pho8I1cUCsb1zni/tnjlTYOREeyZKay/3FQyQdwqQviZmceYJ7BVw2ZozZ7QX9pDjXo31C4n67+2ng+aBvET0YmvGcp83IPB50lnReM0xzwAb9EEBKl/+JvNHfKueo3shSHveFSLDpAfp8rBl7YXsESzrL0W/OQMH6Vl9pYjeYOz+7o/1/s+i+Mpxe8RE+Q/iTFFa5zW+tTSqmAw8i0YROssWUa1wMXZZK6e9OZ6m1+h93mRBnAn0jjwf5fV0c6gt5SWuwZK1+5+nrNtbi87GSDgKop19apkJ6NXqajkwpc5vE8r6sG/H12Tga0og/WYII704vX2CIl04i12GKoKRQzFLFxt0p3pm6bZC3CgwYm8kV+c6f6eXTc14XjCpgWrg4I+xIWQz7T7hazIjTnGhFRMohKTiymmE/cBD6785nQ2RsTO9jPNF1KvSKQlzTdVmygDE7SOzXgITQMQUIxIiiIPzSZhNzIwDeNSVIYcPwXvUn02sdxqSu+YyGAG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b21b6a-161f-4a33-45a8-08ddfc343568
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:05:32.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a72TXbwWI24obXfKDIotw08jCLgaBXd1mHBb0ZhYlYEgZDZrF6ocbWUbQPSBbuuHJmw0iw7QBccmThiuhPfE0urhXrDsjPSIrNKRjevblm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0BB87A13E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250122
X-Authority-Analysis: v=2.4 cv=C5XpyRP+ c=1 sm=1 tr=0 ts=68d53e24 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=OIndoutni1OYuYBYa44A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13622
X-Proofpoint-GUID: Kqvv2bb9tcaS20LT5X0XX-FiSQhDDS2Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNiBTYWx0ZWRfXwLaXc3Urkmak
 ffE/u9aCIByiiLXfqPuv7xVuQI0PB1Hawrs3nlFSabcri8xU9Hs3Q7JHK/l5bkxX76TNZNMgUzW
 QQwwl7MJ799R4f11NjqYhwS8lLSZKT8A4HLNm/0X3o9b415OeuYqnM0lmp+/vi3gxh5z/EtU3Dw
 Bh7fyML3k2FsF1RMfsQtdPwj92H8Qn4C6ViCHVqu0SkkG8Gy7FPsgrZUrw0C65srMncxDdzel/J
 P3EDh+oCzGcTytJ/t3krFgBtKBfvvitlzJD7Kz2XdMH0bENQqil7fSmDneGvUXL91klvV7m8Mxv
 xGXJMxqMzpplbicopONAKaPPQPeiSIPIzyp9+PT+MxoeTrU0mX6taoDyzqleyfhT5YJB95ceV8E
 lKcMp3SUx/x/Dz2jKN5WlFz8NHlrGg==
X-Proofpoint-ORIG-GUID: Kqvv2bb9tcaS20LT5X0XX-FiSQhDDS2Y



On 9/25/25 12:42, Peter Zijlstra wrote:
> On Thu, Sep 25, 2025 at 12:03:23PM +0200, Peter Zijlstra wrote:
> 
>>>>>>     	case 0x90:
>>>>>> +		if (prefix != 0xf3) /* REP NOP := PAUSE */
>>>>>> +			insn->type = INSN_NOP;
>>>>>>     		break;
> 
>>> What about 0x49 0x90, which is xchg (XCHG r8,rAX) ?
> 
> I've made that:
> 
> 	case 0x90:
> 		if (rex_b) /* XCHG %r8, %rax */
> 			break;
> 
> 		if (prefix == 0xf3) /* REP NOP := PAUSE */
> 			break;
> 
> 		insn->type = INSN_NOP;
> 		break;
> 
> 

Sounds good.

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


