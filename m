Return-Path: <linux-kernel+bounces-732810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E13B06C52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB20503E40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAB1F416A;
	Wed, 16 Jul 2025 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MV/Hp9ao"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26C3594E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636907; cv=fail; b=UarazT1KxsaQ8g82lwG2ij6frSrsI/Ec+wbhCFHc5yEf1VMv8xTZOp1e0wmMH0+2kPWD5kS4kiTIXI4T6IJU6RHTQ0jCh17+gkDn7t3PkrBbSOH/N+B+R127oocNDvXsmg07H+DzkvR0dAxYCkYGg9qDyzqKO7l2u0km7LwrAYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636907; c=relaxed/simple;
	bh=Ofy+GdBubySjN0btLzh9yrbljgbutZY4qUqpKBoS44E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PWjp7C71KzoXfHWQrLTHylsc4MG/DhjJY4AMvV9HBWDhpqn6G+KCTfc/g9z+kuaO2T2f1vsMbH/rNRrKvSmBkA6AnHOHRuMh+o6SFZvEVF8EPwe3RWNZT3Zz3mvWBWRVtGSl4OzVygqiaJm6aHF4ZVIHM7dQVzsKkAw96BhtUqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MV/Hp9ao; arc=fail smtp.client-ip=40.107.75.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIuraEjny4ELk7AL7ESEb5M/BS75cBvzUOxamGXvs7YOE4F7NxuElsWYo9vgiMp1lOzl/vh6QGa2LYlhRLj0Fh5a7Bj1dq+zzGbusqOLqU5rdUp9gAtEiaBzRu4+fySPr0dfjlrYjhvdaMC3vnSqVNI4Bz+3yVizEgf7hFTtvCtT/7R1/SbWigroV+IAYBf5PzGqzeLhic0Tk88hOCr1jiRTMFN4XyuQdE08gW51UV3TAW2G4RINN1CGWb1unNUuA0LvP8lXE+NGj7/67z5dZkMAfBs9cu0cZ8bVBQUqg5SjiI1RBDW6ZTSCHawZ2W78eRPcUwL3dN6ZU0pezceS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofy+GdBubySjN0btLzh9yrbljgbutZY4qUqpKBoS44E=;
 b=GhBJqtSfOezG0WnSnhQvbfKYM6CziCTApVT/HLQMAFtfVKCPR/NMbEY0dsdsRiNyBQaU9gl5GaSlnYAZ+iw4nyRGXCzcwTGhy0zXFXl2opdzu/uEolVF070ly5A3fyvuk1x6N9d8jUXNL+A5as3dVbwiimdj+k7yb1E6rWQZDH4LeyC+feA+st0Q+MZ+Ze4jKxNxWk3GCflGHK28E5I0aWcaCpLYaEQU5bNcvC8ZZcR0gbnk7y/55oFHEbeoU74IHReQxbtBl10erpeecx8Z+dgX64549P6If4L11ZDN7v2Z3Yw3Sr3M4WM8NSDkVELJJtjTYdvYJauIEwtXb1TR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofy+GdBubySjN0btLzh9yrbljgbutZY4qUqpKBoS44E=;
 b=MV/Hp9aoNtQWr5Bcj2LdMkFoIGs5nvuqNHqZHeAWR++tYKT6vLoblntgVomVEyBc/iZvpYoCDdRV/XqsCEfKNe9OzJAJHTRWdoBZJOjgMGBtN00a32bRZiTRmFW6RbDQxnhqyPUwo2TeGr1FBvkXfu/6lmZVPdGfMqd7FNKB1G8k1moSUfzdm8J5Z/lOt+i/G2Sv23LTzAKJu5AYdSbddqH4lOHusYMqOpeeqXydoumLogVH6heA3WDKafuE1EPBSqAb3RbSnYizAhk586xTgRCbJnbQ3doZqcnbdl0/j6tREQ9VZbOncjrL5zbf+WloDAW0TmoNUrMtvt7D+dAobg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by JH0PR06MB7105.apcprd06.prod.outlook.com (2603:1096:990:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 03:34:59 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8901.028; Wed, 16 Jul 2025
 03:34:58 +0000
Message-ID: <f7408161-eaef-47ed-8810-8c4e8f27bfc6@vivo.com>
Date: Wed, 16 Jul 2025 11:34:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O
To: Jens Axboe <axboe@kernel.dk>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250715031054.14404-1-hanqi@vivo.com>
 <056e083b-8e41-45a2-9b0f-2ec47d1a9f71@kernel.dk>
From: hanqi <hanqi@vivo.com>
In-Reply-To: <056e083b-8e41-45a2-9b0f-2ec47d1a9f71@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|JH0PR06MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: e5250174-dffc-4145-9c51-08ddc419bd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHdGQmxna21pNHZMTm5HbFQrbDZ2d0lhZ0VFZ1ZCb3VqL2piVjErSE53a0xR?=
 =?utf-8?B?cU8yVTF6MW5GNVh4RjA3bms0Yk5iMnhxMHpDV3g0dkpNSkp6MkRIb1Z2SXV1?=
 =?utf-8?B?eGVydmJNc2RrTThGV2VlRmJ1WHFOZHZQOTdBbklKVWpJNW1HQlZDZnNaUnU4?=
 =?utf-8?B?Mmd0aHVsUmIzMjlhbWh3MU9qN1pheStRb0N0OHVYMWJ0bk8zb2tReTVBbmVI?=
 =?utf-8?B?RXFKMFFydGVSWFdtVXRlK0JJZWl6VTQveW8vUUxIVTUyRGVEMzd6MTB2c3R0?=
 =?utf-8?B?SEFZWTlMS0YwTCt2ZE5YYUFpZlVMdjBHcGdJQkJjRzRhM1RrbUMvdmZrSlly?=
 =?utf-8?B?VTk4QkhTQXNWWmpsY3NpUzZqRElkejY5blh6TmZiK0xJMGp1WWgyUEtwaWVP?=
 =?utf-8?B?eWV1VGluVU9hUUExT3BVZ3k4ZUZMT0xGVEJYK3ZpbThLeVlvU05hMFV0RHcv?=
 =?utf-8?B?OHBtZU9iRlliUWRzbk9GZEwzOG0yTWl5ekd4QmJpT2FwSldnSlRRVDQ1bVhS?=
 =?utf-8?B?WkNFUDBkUVNBV0QwYzVqTGhUK0dWd3d6ak5zRWpJa3JSdVBBWXYwS0ZFclE4?=
 =?utf-8?B?YnBZWUhUL0tOZUlvb0R2dnNVZEVIalN2RVlnbjdjNlJLNjJLSVRFRFR1UDFr?=
 =?utf-8?B?REYxUnU1Zld3aTRsSWwyRW5Ebi9RKzFRUVJUeTJET2JVZm1GMnRyVmxjTGsw?=
 =?utf-8?B?cHFjTC9HeUZUYldBcW9VdmZXa3JQS216dTVxdUp4RmR0Vk5ySm1Dc3dKNTJs?=
 =?utf-8?B?NUhYTjA1R3RBVjVZZzFPajJvRTFSeW56a3JtTkJCMnpGUzdaRE5rWXVWZFZB?=
 =?utf-8?B?ZmpzUUxrWHUvMWxWeC94SUpFNHlZSGk3Zjh5cENMdTk4c3pySHBRYUcxSVJB?=
 =?utf-8?B?cGJFMmEwQXhxTGJMSjRLZ1VzTUp5NHU5a1U4WjlLL25xWU54K2duTFRDNWdP?=
 =?utf-8?B?cktMeERRd04xK1BEZlJJNUFibFJIUmhrUVl3SnpTYzJtbDF2bi9UNnYzWkJQ?=
 =?utf-8?B?eW5sREdrQ0FOakhPWlVtaWkyV1ZYM01uQWFhTUErZGV2RUozakRKS2syeTNH?=
 =?utf-8?B?UVFuaVRjVGxwUHpSdGNvcU5aVW5TVEtFSzl3eXV6WldvSXl5YTgyODd0aGRV?=
 =?utf-8?B?Y1J1SjVlNjFvWkhEdS9Ud0Q2ZzRLZnRoSE5mRGZsK09PVEROTUhTZTh3LzhE?=
 =?utf-8?B?aE9Da1VMejlvaUhXTlFIVVo5eW5RcjY1dEdJOHptUXhYQy9tQWJKTDdmNTBK?=
 =?utf-8?B?bHFjQXUwUWlhR1cydDhWYlloZlN0TFB0RDhjNStWQmV4V2RENVBOWkd3aEtE?=
 =?utf-8?B?WWMrR2N3b2ZJQXRVQnR2SmVxQzY4V1o4U2d1YUc5YUVpdlAzeEZTS2FZRXds?=
 =?utf-8?B?SlN4T3pyY1hnT3NkZVkxOWo3S003cGx3cE13My9vQVhUK1dsaUxZSHF1c0RH?=
 =?utf-8?B?RmZXVWZIRFJTZkdhbHppZHNML0k3V1hXd055OHViZXd6b29IMFA4aFVoRVdL?=
 =?utf-8?B?Y09KWUY2alkrOTR5MjB4enBZUi9Xek1UUkR0OEVmSXNNREVVR25PWU5lM3NP?=
 =?utf-8?B?NG9wNEVHME5hZXJ2ZG1MUkpBcGgvWnJqZm01VTFwV2RvN24xYk5Oem5GaStZ?=
 =?utf-8?B?QXo4aWdxRDJwaU56bXRFUm12bVpVa0hZN3JVNVR4ZFdibVZCcXF4blNUazVw?=
 =?utf-8?B?QlhOZ3hFVDVkalZ4Vy9oOWlubnU5SGs5dHdJVDI4UXhoblVROVNrMnZmOEFI?=
 =?utf-8?B?RDUvRmoycFc2M0crVmp1ODhLVG9sM2dlSDNnV04zbWRNTWh3R3RydG1KWHcw?=
 =?utf-8?B?TzF4clV1Q0hTWEJqRE0wcEhCZERXbG1XbFlzWERsMmhlczhFNGswdG94ODE5?=
 =?utf-8?B?YVpmS09iV3VjQ0VqeHRacm1UbGIvVGVOUGNOeEtYM2ovZjZxOHYvMjIrNmpk?=
 =?utf-8?Q?x1LaZY9BFhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0JFVGE3WHFneHhlVnBSTFFza0toekcxckNrL0QveHRab3lDbit5QjVSOExr?=
 =?utf-8?B?VXN5aHViSUZvZXY0eFE3bW40dXJlVDFvVjI3SU04d0JCZ3pRMXhlcWRiZkJV?=
 =?utf-8?B?ZGdwYzIrTWF4Rk1PaS9jRHR6RHVvVVRSRmVDVDBUVU1MczVac0Jnbk8rMzFX?=
 =?utf-8?B?Z3dDZW5sWjJzQVBkVzg4VXVKZkhBaWsycVhtcUsyVmxZWE9MQlpqUlR2TGlz?=
 =?utf-8?B?OFNmcnZUM2RzUzNzVGtLNmtNUzBqRkQ5RkVzYk1IT0FqRWxWQW1PZlluVHpY?=
 =?utf-8?B?QmQyVjh3Vmlra28wMGR6MXdzK2VaRzk2elVXak1SZVRoL21lVU9RMXlQd3FH?=
 =?utf-8?B?anRNVlNxd2JvYys5Tkt4RnlhWE1FUC9IcGI2TGhvMnNVcEVJYVhhdFpTLytv?=
 =?utf-8?B?U2hLenlwbmduUkdkUFFMUGt4eDNjZW1pZDF5YVJqY1dNNXVTZWp1MWNKb2U3?=
 =?utf-8?B?eUswT1ZnVTB5K01Md053UW5SQ0RvdGlwdEU5WERWZnVFYzJXTEFRZlJNeFM3?=
 =?utf-8?B?YndWUzRsUWxFdERZNnhLRkFZOXhBUzc3MWdjeVVCUytxLzZ2Ukgva2hQdktS?=
 =?utf-8?B?TVhpMjhHejBHOWU4QTl6UGF6Z3FLb01EY3VKQmJRQTZSMlFKa1d0SEVoM3FI?=
 =?utf-8?B?VVpRSnpSTVdNOWJMQVp0MEc2UVdQazBLNmdJVXpld0JFVjNJMnZaSVp2WVN0?=
 =?utf-8?B?V0JOSGRiWjJWc0xLTGZiaWgzUmoyOVNrNHJFam1zaEhYNDlJVnVsNXBWU2xn?=
 =?utf-8?B?N1lIK1VNM1RlRDY5d2NVN0xadFNuUnMyNzYrNUE5RmV5Ukh2Q1hiR0dLQWJE?=
 =?utf-8?B?RE4zTVVYQldvVHg3ZnpJb2NXVWFOTkVmdWZvQWxNbDBDcFdEa1JOR3JOSWJ3?=
 =?utf-8?B?UnVOUzZtMFpzdWZPNnBlQVMxYlpqVVBkUWJzeEJDNFFFL0RRUEFpUUtuYmlO?=
 =?utf-8?B?a3pVZ1haR2FWMDlkcUp0RGpIb1l4OHNCcU9QOUVuelhKMW5sZmM2QmVEdTla?=
 =?utf-8?B?aG11ZFlMQThVMXBlZVl4ZmxSSm5JNGsxY1Zja2FlclpvM0VCQzFXVDlZZ0ZQ?=
 =?utf-8?B?K1JBWmJwRG16ZW1ZNVU5N2hTOWdtU0IyOUtQd2xocDUzWjVuN1c1MW0yZjh5?=
 =?utf-8?B?QmY3SFowT3hkS3h1Qm1nZTFjc2NqZFRKbTd2MDM2K0o4UVRONy9ZTmU0eXZU?=
 =?utf-8?B?VlJ4WENtZVBkQVpVQllwUWYrU0EzeGE1NFpoZWdtTHV0bFdMWWtXQUN2bEx0?=
 =?utf-8?B?NTNMK3JWTElXWU9JT25aSEV4ZjAxeklGYmE2dW1DVjFpeko5MzdicU5YVlo0?=
 =?utf-8?B?WWg0ZEhPNXc4WXdKSkRDWCt2WXd0MHdJQ2VZUjVqd0RBSkZIT2I0bEhFR3c0?=
 =?utf-8?B?cnlsZGdqdTdnK1lZbHBNeFZLMWdMZFVYWmliUEp5Z1V3QXEwNVR0RFZhN3Ns?=
 =?utf-8?B?UHZ3Zk1SampuUXRROE1PVCttVGpHNXAwcU1qaERRdDR4MlJlZ3BCWXRxWU9v?=
 =?utf-8?B?SlpqMXBnVG1JSlJtQWU3eGpkb0hlMzlqVUdPWS9XS0ovWTk5R0t6LzQzSXJr?=
 =?utf-8?B?R0U0OXYvT21vVVJnRG9Db0MrSmtRVlVYSVhHZGk3QnNtTDh4dWhHYkZONnF2?=
 =?utf-8?B?c3A1YzZUbE5OeURwbXRPcmpxUkxTRXN1V0xQaXNLcm8xVXpXM1ViWFFQa1Vs?=
 =?utf-8?B?ZE95SUhxY1JYb0FRU3Q5d1dTQ0hhT1FBNWlieG1HajJDU05XN2lFTjZiVmto?=
 =?utf-8?B?TWtPaktndUFKOGVDVkFwMmcvajc4WXlmMmtVTXNGVDE5SkhtSnRFUnZzNDNl?=
 =?utf-8?B?NlhBNzdOUVZUaENDSVNWbWI3ZXRvS1ZSTW5IclpvTktWZUZLcjFQanFJc0pB?=
 =?utf-8?B?blAveUFubkZVam1QR3dET21HWkY2bUV6V0xaTG5JZmtKcExLanorWTgzSE85?=
 =?utf-8?B?K1lyd1E1VTBtR1paTmwyNGlRbzZlNXFjM0lKUlBnSTZiYVN6NXZkYnFGM2xh?=
 =?utf-8?B?M1JEblYrdi96TjBqOThlRTFPb2NVNC9rbEJ1WDkrRFROY1dBNURGcFBUcE5O?=
 =?utf-8?B?NlZNRnFYbUwzaGFnbmVUVXhNWGV0T3ExNytMZ3RmVUNxU0E2eWd6ZnpXYUZt?=
 =?utf-8?Q?jYdp4PAcnlKfBQhkEgVnY0i0u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5250174-dffc-4145-9c51-08ddc419bd0d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 03:34:58.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZfPzodoOc7i4zK9aaw1dt0BFBbOEfHf8TU19ENP4oZe2CEFxpELdt+JGS3pvf2H2v/pcflBQmoSLxiLTmkvBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7105



在 2025/7/15 22:28, Jens Axboe 写道:
> On 7/14/25 9:10 PM, Qi Han wrote:
>> Jens has already completed the development of uncached buffered I/O
>> in git [1], and in f2fs, the feature can be enabled simply by setting
>> the FOP_DONTCACHE flag in f2fs_file_operations.
> You need to ensure that for any DONTCACHE IO that the completion is
> routed via non-irq context, if applicable. I didn't verify that this is
> the case for f2fs. Generally you can deduce this as well through
> testing, I'd say the following cases would be interesting to test:
>
> 1) Normal DONTCACHE buffered read
> 2) Overwrite DONTCACHE buffered write
> 3) Append DONTCACHE buffered write
>
> Test those with DEBUG_ATOMIC_SLEEP set in your config, and it that
> doesn't complain, that's a great start.
>
> For the above test cases as well, verify that page cache doesn't grow as
> IO is performed. A bit is fine for things like meta data, but generally
> you want to see it remain basically flat in terms of page cache usage.
>
> Maybe this is all fine, like I said I didn't verify. Just mentioning it
> for completeness sake.

Hi, Jens
Thanks for your suggestion. As I mentioned earlier in [1], in f2fs,
the regular buffered write path invokes folio_end_writeback from a
softirq context. Therefore, it seems that f2fs may not be suitable
for DONTCACHE I/O writes.

I’d like to ask a question: why is DONTCACHE I/O write restricted to
non-interrupt context only? Is it because dropping the page might be
too time-consuming to be done safely in interrupt context? This might
be a naive question, but I’d really appreciate your clarification.
Thanks in advance.

[1] https://lore.kernel.org/all/137c0a07-ea0a-48fa-acc4-3e0ec63681f4@vivo.com/

>


