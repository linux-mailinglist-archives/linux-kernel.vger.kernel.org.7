Return-Path: <linux-kernel+bounces-723936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA49EAFEC92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB6D645D47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C100C2E3371;
	Wed,  9 Jul 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Vb6HV2Z3"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2098.outbound.protection.outlook.com [40.107.115.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E579CD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072680; cv=fail; b=NrcWVA/qdo3q2vpI+HiNYA69fi1NUw7uE/eQrh5yhD4E562EULtCqD2Km6SCoeEjERcZbdbTWWZd9YWTAj6WgRfj44Pj9OclsLQyzAWzAnFdvZYMR1qsLhjYPEfYyqZZi389XJZwhrN+37WXYtIi0QCxEpki7VlS8u4VER5trx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072680; c=relaxed/simple;
	bh=/GZhNeg6B7aqU99ibOPbbFA2i3mrdb1xTpth5hUp1vk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZN7BXKTP0T7aValjzNEXi58QR/1c2ZnvnIHmKnnITn5yioYY1YeTb3rcUW3DMQJrt3htewWU0F0SsoXoDQ4qPTVtmvGi4OKDY1aPiK9bawR1DZBCOkPhOCu3Ez0n+QlZDgCxKIrwikIUYhRGSJyjFi2vq24zDzUd6QgCaAzC0xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Vb6HV2Z3; arc=fail smtp.client-ip=40.107.115.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq6W+6paXz1t0wXZ6XdIsyQCNvklmNvtlyWpp4hxVXE1x2L7O+YRr+VZwz727e5Xtr/kwrbQxoEtLcpR9zMTQSA7EmPWFulCqgJKjVUIjJVIksSyq5bV5AHRcloj0197MpZWqq+8cRSn04OLz5EkJa4+t9DgKC5OtwWV+9w/NtDvGUEzdEJQhpF4ysIJ34lcA0SclXq0PEnnbcFJYu8VncuxP1rJ9GgC8knMLS4ctSuWMyesFwUp3wr2v1GR2I2VvbPXddPFDyWJQX5PksANpnTNho/Y/VIH/8GLtJm7owFLGrEK6PpR9XkrppmG93lSXQVBJxT/l/L2DLBniZRkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKp9zBU9j0tfE1HFbEF5eBYx89vl/H1GriGX9cy16Y0=;
 b=HCQO3WxMILrmf0eJA3gp6803/qCEFrydR+p+vYIYBNiRQXjAmjSUan/325B6bFnyKmG3mDPuqOU4UNflpvwLFUrPmoLf8ufHflibAAV+CrL9IlKd6RtgCpoYgqVPlY4UAQTZn7TpGQgNqD+g5P4Xj29tX/FRYhg35M/++JHQJ9pZAbN1dd4gOU1RE1w3so+XLRAA/XC6NJRj4LT2pd2/teUTyLJZ0dKbbqpQzPdYiRON6933ZIZ/kjT3QoT/M4bAg3x1XklD65o+wSxmSSvdTiSSGOExCoo+TC87ozzXupOVGQaxy7UISAaZYMET7+2DXPaVZzrH8+7h3qDE+CKqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKp9zBU9j0tfE1HFbEF5eBYx89vl/H1GriGX9cy16Y0=;
 b=Vb6HV2Z3eXfXt+OVXGPvS1apDifj9iDqmGRvxAqDcGjI07XAXNtf1hcwnUHWhCy+DiGqVnBLASklSR4huSidYUvCUoERAcPoQLKq7ibY5iFVMn3Vps35iEYAreOPOy9gH0jYYnFx7sNYZt0FYbSaJ/vPGK7A8Q3J9BrlU6GD6dALdkvODU7L0ANa7LgiEpOIvHZDjyUemunmrZA8h+2pR3QUUXTpFE0YNVhficfaxitjYkwG7uN3rhZj0RD01KQDff76N5sofCxBfZgrUW+gvhGC/U41agUwKtEuJcaFPJgu+P2/Xes/U3Lz7AA//QP2K7OtdQzRWaBwDyT0iPCqKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB11039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 14:51:14 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 14:51:14 +0000
Message-ID: <7f5ce50e-d1fa-4180-95ae-201195521e12@efficios.com>
Date: Wed, 9 Jul 2025 10:51:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tracing: Prevent double unregister of tracepoint
 probes
To: Steven Rostedt <rostedt@goodmis.org>,
 Aditya Chillara <quic_achillar@quicinc.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
 <20250709-fix-double-perf-probe-unregister-v1-2-2b588b3c0140@quicinc.com>
 <20250709104017.69190334@batman.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250709104017.69190334@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0221.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB11039:EE_
X-MS-Office365-Filtering-Correlation-Id: db1c1b14-3a2b-4eb5-31e9-08ddbef80d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXN1Z2ZzbkJWOVFZakVsNzB3WWRiQ2V0VFZkMFkzNm1zRFFxN2IvMXRQc1ZC?=
 =?utf-8?B?UEdLcXYxdHVkUFBKWFFNVjFkaUdZR1E0Vmo2YzlaUVBBeTZBZWUyZVR1RHNW?=
 =?utf-8?B?djVFTTJiYXZLVURzeHNmU0FlYUF0SGljUTJJR1Q2djlCeGF5MmZid0J4NlhS?=
 =?utf-8?B?dFYvQ0pET3czbTdyczZ0QVhHKzVpSW9RTTlETWcrRE5CNzRRRHJTeUlYdXJJ?=
 =?utf-8?B?U1RYckNnbGx0VWx4b2c3bkJSc0kvU3NYQkc0Y1ExQ0VkbDlVK0szVGRIQmVy?=
 =?utf-8?B?akcyckxZZ0paQkJNRk5FWE51REdQS05hdXk5TFZQbDJid3p4bitZNG1yWXg5?=
 =?utf-8?B?d29PRy9pTE8xQUIrMUp4WEN2ZVRDcmMrZFE4eUFaRzBpanNUeGhRUCtyU0Z1?=
 =?utf-8?B?SjhUWlZuVU1uZVR2YndES0d2MVo0ZGU5T1dzS090TW8wWWtEdHF4OXhRaDZh?=
 =?utf-8?B?ekhMa2VUaGFxM2dQS01zV3BveG4rUGxKcDhNbnE0Uk45SDJTOXRSRU9VRmRq?=
 =?utf-8?B?UEVNQ2NvYTQ4RmFJMjQwZXFKZ0tGbk10ek9GcmZ3YkNhK0JITmRQTmtNa0dr?=
 =?utf-8?B?Ly8zcmtsYVZQR3UxbDJGRWlVTnlMQkNSaVRaWkNXdXE1dEtnYXJlZkc1d2dB?=
 =?utf-8?B?b1VHTnZtR3ZINXF2NU9wMC9SdVIwSVJzVzVBN1V1NVJqdGlJbWhXMmtibUFa?=
 =?utf-8?B?OFJ1TEY2MFJQZ25JeEhRdUJVbkdtZGdPRDVRK1NWNG5ibWEzS0t3Zm9KTzM3?=
 =?utf-8?B?OVpZWk1STW10czJkZ01KWGlLTWVpOS9yTStKL2c2R2RtVTN5a0R5OXlHa3hw?=
 =?utf-8?B?WjI4b0xYNllJS3ZUNElJcnpGbkZ4cnRBQWlJNzFRbWNndURiU0EyNUVWY0VF?=
 =?utf-8?B?bHRYK21HbW1DTlNhb24rTU9GWlJDYXo0bzMrQ0JOdDVUOW9Ec0RFOFhibDl2?=
 =?utf-8?B?UnZGNklOeUJUM04xSkxSQ0tMeFlqaFBERURtMTFibjBGbEZvSy9LZjJJVzBI?=
 =?utf-8?B?a0dMazl4Si91dTFlOURJcFIyRmNEclJvd2tVWnljcW95OHN1VG5QWmRRejEv?=
 =?utf-8?B?SnNiNmpxVjd5QTdkQ1lhcm1xOUZPMHJJS0QydzNHK3BEUzZHTEZDMW1ZVVlz?=
 =?utf-8?B?bjRvcTU2VkVETTcvcythSUpWUUU1OFVOcEZVZ0NjKzBOTnVZelBSeDFWZGJ4?=
 =?utf-8?B?ejErQzkzZ0k2bzZTNjkyeDdXYWsxVjhTREtDdVJJL0pGMXFCWHpoWjkyWXZH?=
 =?utf-8?B?YVFZVFJ5cGhHb2V1R2pqSUlIOXR4b2VkRzRjcHpCQlRkM0tXTkZ5VjYwcmtx?=
 =?utf-8?B?YytJME42Z1NYVWZOeVRPNmVLcEN3QnV6VnowV0JYSGdWcGd0ZzNuM0ZGbWJv?=
 =?utf-8?B?QVN4R1NjOWZ4RTNVaVpHNXRyajZwUVc0SyttV2M0ajIzblA3eVNpNjg2cXE2?=
 =?utf-8?B?elVlYWt2VlFvV1o3VTI4TDdhSFE5Wld1QjFkTE53cjhSNkxsTC8xNFQvWUVR?=
 =?utf-8?B?UHV0ckJyRFNIejhGZmlmQ2pudDlwOEswMWRtejRveTZ4d2kxekF0OUFOV3JQ?=
 =?utf-8?B?emxKZlRtRndQSUl3c0s4VVpZVEtQa085ZmRGY1hmcGcwTFJBNTloQnYwQ1ZJ?=
 =?utf-8?B?OFJCQncwSHZ4Si9meGNMSVRGcC9HY0hHaWN0RWcrdEp4Zm9GTlVWYWM2QlU0?=
 =?utf-8?B?VXVIZmh4M0JybnBIa1g4bk0yZnQyQXM4ZmR4K09lYnExMDE3TUwrNUpEZzh5?=
 =?utf-8?B?bVFXZmVpcHlteDdsazlTSGw3eGVkY09vMHZnSXYxcFg2RVFpVVI3ejQxSkt0?=
 =?utf-8?Q?aXT83XXh8mRGl/cdWfjy7qyr9Oqc+LFSSuads=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTcvUDVFazg0WVdqejAxYnZiakNzR09YS0hsZnNnZFJtWHJjMHZMeXdreFoz?=
 =?utf-8?B?STB3Q0xPVzYzTCtEbjl3ZUxXSFhYWkpLbTM5ZER5UFFTSXZoaWw1WU9VanQ4?=
 =?utf-8?B?S1F4ZVlUSFZqQWZTN2paVXZ2eWRZTzJFamRZSTVwRkR1dTNBamM5azdVY0V5?=
 =?utf-8?B?VjZ0eUI1Z3VPWGJuOXZMajNZUFJJVlJtdkZvSitoYkUwcENKSWd1S0VHdGdT?=
 =?utf-8?B?WHd4alpVQ2QwcFFEd0JoZFVhNHNnK1VXVmt3SGtGME9tSlFwWjFCejNSOEZD?=
 =?utf-8?B?cHd0NnVqS0huOXROdTZ5NVgvL1oxaFZublN2NDU1bXB3ZWVZaG9OYnZZdlRk?=
 =?utf-8?B?UVIxVGp2Z0Vscm94M2xJWjJyWnk2VmpaTjdpeDJMMVBEZncwd2g2RXR0U2x4?=
 =?utf-8?B?Tm51a0Yvazk4TEZsUzlSVGQ4OTZmWVNLS213eXVUcHFHdi9KQW12cmo3U2RM?=
 =?utf-8?B?bUphc1JDVXRUbllPNURvem94UVdpcUJxV2Q3dWRHbmZZK2FWdkxNVnppZ3Fq?=
 =?utf-8?B?WjhWM2UyL0VlQ245d0xRTEIxQnd3OFN6SFZaWE5rZFRsUGJsbnU5Q3o4WXEx?=
 =?utf-8?B?ZmZXZVNKMXo1UCt0ZDlYWElRSHFjZFNZSG5uWlRwRVVoWVFHV0NiR3A2cmZV?=
 =?utf-8?B?M1VkT3JWL3FaQjVDZDlLeHRiNjF0SEtVTzYzZXhOdTV5ODUzdzdDc1RDRUMy?=
 =?utf-8?B?UWljWk0yejdHdkp6QkdKaGp3aVAvUHRDZWNlOE5GY2h2TnZLRVZRNDNsWlh2?=
 =?utf-8?B?eFRETVpmdGUrc0liY1l5THl5WkRhNXVkd2RxbmFNeC9qbk1uVGk2U2wvdXZn?=
 =?utf-8?B?QmpUcnY5WFkvYWE5TzArQThLRjhobEtSZjZNd0ZEZHpnb29jMi9KZVZ4djI2?=
 =?utf-8?B?TkFpWTNGckRRUGFNV1ZMMWdnbmlFTWVsOGVjdzBkQTBINHN3MnNiTm12RFBr?=
 =?utf-8?B?VVllREJ6WVczZDdCV2k5UmdRRlhXRUNZK0NzMmp6V1JLWVY2TlVYN0o2ejhk?=
 =?utf-8?B?WTJmbndDZVVUMTA4bHR2MWhKTExHOXF0N3dwdVZWWXZEWTJVR01kb2lpT1Jm?=
 =?utf-8?B?T3BqVUVkYlhTMGVHNmZENlpYeUs2cEduYndYa3BuNVluZVRHZHhCRmllVGps?=
 =?utf-8?B?a04zekJjem5JV1NzUTJUMzFUcEZBN0c4bE1zdXJUNkpRenNKd0EwSUVwc05U?=
 =?utf-8?B?S29mNG9CZUdDTkQ1OUphUmdlalBRcWdNaDdiWDMwRmZ0WE03Nko0V3UrcTB2?=
 =?utf-8?B?UVV3SE8xK1YxZ3pHaDBHS3NJN0NyY01WeXBYL1dqdllwTjIrQ1lYdHVCNjUr?=
 =?utf-8?B?N2lYQUNvNWtKRHhFNTJuUEJNek1pOHdSa081MEVhTE0xNWt2TTJLVWN0c01z?=
 =?utf-8?B?T1NtZEJEcHF0N3ZQSW11M25US292RVBRdmNSWWdNdE0rcjJYc21LNy90dnhL?=
 =?utf-8?B?aURZY1BOa3ZLWEU0M2VNRUNrcXBtb2ptdjA1SGJEQ2gxR0Zsd1R1K3NZeDdx?=
 =?utf-8?B?OWhGL2ZhQzk3dUZCL3N5OHUvZWNYeXovKzk3dkdGcW80dFJ2OWpmUUFZUkRR?=
 =?utf-8?B?eEY0akdkZkFyTUlScVBPOHg4QUR4dVFsQzhnejNoc09IYzNOSHErZ2dENDVI?=
 =?utf-8?B?L2NOWDdub1F4cHhCMlFndjJRMnBlemUrMjRRaFNKaEEwZlVkVGZGK2JRMHZL?=
 =?utf-8?B?SGNYNjM3ZCs1M1crc3B6U2RQcEFKbHVTWDVEMWZuZWptUUtYa00zUVFyaGpy?=
 =?utf-8?B?ZGhmN2hHZUQxcDJxOXgyZW5mQXhwRlBNd0Q3VUZFVSs4a1RPZGJJNXltNUEr?=
 =?utf-8?B?OUJETGMzV3NUUGFwQTl3Wlk1SU1lalhHcHhOSzcveXcxT2w4Slp4aTJLMFFV?=
 =?utf-8?B?TG1XYU55T0ZCSWxKQUVRNSt3WEw3TmtqazhJWE1ocVdZNkV2T1A3aS9Cc1Nw?=
 =?utf-8?B?SmpiWG0yZkNydHVpbi9OcGRvOUtScnM1S0tGUVkzVGlpUzN5ZklJb1FsOThp?=
 =?utf-8?B?Z3hTc0JoamsxWTVCOUtUQmorb3grYnUvSy9oZnBZTm9BZWNSR09wSUJxQXJj?=
 =?utf-8?B?TWNmeWoyWTF3Z2cxczNSZlVuTVl2OXJHM3N5Nk9MeklKajNISXBHem02Z3ps?=
 =?utf-8?B?SFpiTXBla0NRbXV6eDBZUlJjV2xiTTBGOFJ0NUZoZHoxdlF4V1R2VWVobmQv?=
 =?utf-8?Q?9WIye+5CJvTWtM611I6e428=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1c1b14-3a2b-4eb5-31e9-08ddbef80d44
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 14:51:14.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czIZ0Fydy2LIGZd3gdr3UAWP36kUZy+mNqZoRLyfU8sgfuS0gE6Bn+OlqJD4GZ5Qg0RZo2iukIiTlUXzXyiusdyRVNTUxUunCuNdkXAdsrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11039

On 2025-07-09 10:40, Steven Rostedt wrote:
> [ Added Mathieu who is the author of the tracepoint code ]
> 
> On Wed, 9 Jul 2025 11:11:10 +0530
> Aditya Chillara <quic_achillar@quicinc.com> wrote:
> 
>> Prevent tracepoint_probe_unregister from being executed multiple times
>> for the same probe, which can cause issues with perf due to the lack
>> of error handling.
>>
>> Return an error if the probe is not present in the list of probes.
> 
> This patch even shows that the first patch is fixing a symptom.
> 
> Yes, I agree with this patch (with some cleanups below), but there
> should be no reason for perf to be ever calling unreg() if it doesn't
> have a tracepoint registered. Something else got screwed up in the mean
> time.
> 

Agreed.

>>
>> Signed-off-by: Aditya Chillara <quic_achillar@quicinc.com>
>> ---
>>   kernel/tracepoint.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
>> index ef42c1a1192053cc05b45ccb61358a4996453add..e6eee7e44a9d6f4f19114fbcf8fd9e5c85075324 100644
>> --- a/kernel/tracepoint.c
>> +++ b/kernel/tracepoint.c
>> @@ -232,7 +232,7 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>>   static void *func_remove(struct tracepoint_func **funcs,
>>   		struct tracepoint_func *tp_func)
>>   {
>> -	int nr_probes = 0, nr_del = 0, i;
>> +	int nr_probes = 0, nr_del = 0, nr_tp_stub_del = 0, i;
>>   	struct tracepoint_func *old, *new;
>>   
>>   	old = *funcs;
>> @@ -246,11 +246,18 @@ static void *func_remove(struct tracepoint_func **funcs,
>>   		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
>>   			if ((old[nr_probes].func == tp_func->func &&
>>   			     old[nr_probes].data == tp_func->data) ||
>> -			    old[nr_probes].func == tp_stub_func)
>> +			    old[nr_probes].func == tp_stub_func) {
>> +				if (old[nr_probes].func == tp_stub_func)
>> +					nr_tp_stub_del++;
>>   				nr_del++;
>> +			}
> 
> I would make this a bit cleaner by:
> 
>   			if ((old[nr_probes].func == tp_func->func &&
>   			     old[nr_probes].data == tp_func->data))
> 				nr_del++;
> 
> 			 if (old[nr_probes].func == tp_stub_func)
> 				nr_tp_stub_del++;
>>   		}
>>   	}
>>   
>> +	/* If there is nothing to delete, do not allow */
>> +	if (nr_del - nr_tp_stub_del == 0)
>> +		return ERR_PTR(-ENOENT);
> 
> 	if (!nr_del)
> 		return ERR_PTR(-ENOENT);
> 
> 	nr_del += nr_tp_stub_del;
> 

Indeed func_remove() already returns ERR_PTR(-ENOENT) when
old is NULL at the beginning of the function, so its intent
is indeed to catch this kind of scenario. I agree with Steven's
recommended changes.

Thanks,

Mathieu

> -- Steve
> 
>> +
>>   	/*
>>   	 * If probe is NULL, then nr_probes = nr_del = 0, and then the
>>   	 * entire entry will be removed.
>>
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

