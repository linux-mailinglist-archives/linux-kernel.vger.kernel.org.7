Return-Path: <linux-kernel+bounces-808312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6470B4FE03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA205E39F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FE5340DB6;
	Tue,  9 Sep 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HCYmsYuT"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021117.outbound.protection.outlook.com [40.107.192.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382624502C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425446; cv=fail; b=ESILTueky4aGiFaUxd+NnBLpKHWiSzefbGme2nm41hmqOvKFw2BXXGAKiCdUysknORE/8ONqAuaqQyq6yffNEKQRhV/1gH8qpW727FwsYAyrLbEga9bXEt8ijvcBHUp/ufr+TdN2C/ekjEg9L+izvJhB98zY7UaXm+XLuDge3dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425446; c=relaxed/simple;
	bh=8hBdT2ZfCKjASWubOCrRFO3+Wuf04SIWDS327xUexWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BPBYvq75SALT8fxWzlmxWKgb/dd+T7qjbaEZdHZpGey0KlcRPwJytx8fAfEV3osAm0RXbBsfKVwt7B70DE+mtX64psFMxUnfzoXBONUCp67BVoxKSSx6s/WycW46eh3CRBCiXh6Wp0xO4jldgizbug8Uo4PFFprck0vxxhQoC3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HCYmsYuT; arc=fail smtp.client-ip=40.107.192.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJQ9V8hRQDRV+lPcii93lZI744/ZZwdECmtwWcb2O+TOV5BKHhC3aIlI/PjYcc+i6UOeMPi73W+AUTT94ysGPzjSBAJ100D7TKBQLFLjGRfgcajm7nYdsR6vSxqTLkIT54e4VjDLTrNszRxI0zKnY1DxiFwjvvBdwxpUBOCFOIFE72AgkgT9KDu1bo9JhixdvvM/6DHz/yfTSu83tR9959/uWdvfR1EvOSFYQogqlA/zgWM1SNRBX3Y2tsbv0X3xAfeP+74982vZzWgsHgL4AbmC53yMQ7AwKoHgZyMG/UaqMUWZb+ee+QPJDv15pIdg+PuBjSmhOE6MUeyv1jjj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xdvHYLtTT/6ZwD9F0t4h6nNrsJpfOgpMda4LywyuEE=;
 b=pmebAFQnThdEZhSSdBM+ApU1AWoGlVQwKmBJrQftk+EvtafrxOlXOBq1I5npJLC52UM81DOIBqZCAwxFVuctIM6UlMgRCybWqDaS7oMg8bkEFcSJDIuaqeB1FhgMeo8SPyTuKc6+2HnpQLj7avIBsG+pp87GRuwXPUQ0YvRJezoJikl4lpfZrs2Lh8QDxI+Ivv93UQTCnoORTOUt8KQ5uTEa0StTMnGseZFFkIjOGoDg2th2Bqq0mHzjmdziuQyLnVL4xYdyFLTZpyBerHybPYGEZAxMXNQIA8ZpiGixzDByTIvqx4EPgoOzGL57Omw4dVYlqtWq4KMCNIq6vmACZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xdvHYLtTT/6ZwD9F0t4h6nNrsJpfOgpMda4LywyuEE=;
 b=HCYmsYuTbFAZ0EKuC9Y7X3sY1VLAtahonFeWT2A3Oxc1nKoXqsS2xqwWhjt+LXr8H/ISXvfJTWsz15dBi//p4p0APAEtsWnyVKFmMrIpX295dIGM+SKUyNzpCgpViGzfvRpYtv0AelDMr+TsTdKOoyWXhvt6q/SfhbggHGPyIrWpQWxsW8cG0rOlk54QcoXp842ftfer6E0OeaNOxPdyastP8pWztow4SQcLG9/Dp8PhFDg6bvB1eP3MqnEWSuIT26Xf5CXtvZLldOTdJbF6AzDeXh1+jrWSAPF1iVNaUV6uMh47OX61ZV974Pq3Tclq8KXGdWvMMZPNNFUUHRt5Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:44:00 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:44:00 +0000
Message-ID: <ac375e1e-87a6-43ab-8f2c-7d9ab4f2f34d@efficios.com>
Date: Tue, 9 Sep 2025 09:43:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 14/36] rseq: Cache CPU ID and MM CID values
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.161186107@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212926.161186107@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b31849c-5cb5-4ad5-90bd-08ddefa6ee50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aldQTi83c25ueGZzRTBIakpFWitpYnByMVFrcXEyUW05MXFkNURQZmREZEpu?=
 =?utf-8?B?Z1FHdHJQYW9kd1pnOGgwdDc4cDVaT2lzdVdiZGZyVXplRnA5TlFYTnVaNlpk?=
 =?utf-8?B?ckV6WmNhdTNJdFNrTGdNOW55eWo5b0dzaWVubE5CZEpXbFF4YlBmdExnN0hq?=
 =?utf-8?B?bERBc2wxc2tDTDI1SVg2eVFzUW53NTdLemx0MjFLZzk1TEZ1U3N1WkE2dGl3?=
 =?utf-8?B?RXMzUUgzN3JDaWpqbVFqbXdrbXJrS2VFTTlaM0tJenRjbWtWSUpYOGtjaWxx?=
 =?utf-8?B?elc4bS9QSmVHM1RyaFpaRmc3ck9nSFZFSVVtVmFwU1ZQNC9yOUROYUd4M3da?=
 =?utf-8?B?ZENXcEdnSHlXbU9GYmJ1WEVrVlByZmE1SkVneStiTjRGaTB5SGFVdE5YR1Ja?=
 =?utf-8?B?Mmk3cmVPampCMDJscXNNcWFkVkE1SnFqalJvVU9VUDRoaGVGREF0Tzc4WjlP?=
 =?utf-8?B?YkMzVzZjbDVuREx1YXBUYXNHTy9QVFRUUzF5YXlqb0UrcFprUFZpUEZxM3d2?=
 =?utf-8?B?SjJ0Nlh1NzdEOWdtcnBpY1hRcG1sQThEU0lxbE1hYlhXT1NmZmlQNlAwaG1s?=
 =?utf-8?B?c2hiazB4OG05STMxS05BUjhxTjZ1UjJla1R4bXlDRkh5STRVOWRtNERMV0F6?=
 =?utf-8?B?ek1SU2p4anExamFvVVVtRVRzQWxSeng5bmJQUFd5cFgwa2NweEhVbVJoR2FL?=
 =?utf-8?B?Q0V4d3JyMW1rb0dYQzFrRENUY0RwenJMdU42eDFtRWZ0Sm5lN2pVYmx1Yllm?=
 =?utf-8?B?QkZmZDR3czkzbVA5bFZlUTlFUkI4TGZvMXJkd1VqcVlJM3pLdWZ1RFZZUkdl?=
 =?utf-8?B?aEFTTTlFSWpFNVc4YUFIRFI5M0J6ellHalZEemtONGUrWk4zaUxHaW10bGZF?=
 =?utf-8?B?L3NLbjJEbzVET1c3NGZoekVmUXJWVlR4NnlQYm5LTUFFVkxlMVV0TzJWZWxD?=
 =?utf-8?B?b3Z2b3Vlb0ZpK1ppcDlVM1BLM042eGh5TW5wbFoxekRIYU5IQTlnWEF5L012?=
 =?utf-8?B?R1pFS3kvOWErQ2Fsays3ZUVtd2pMZEVWMjBhS1BZUmoyVkdYd2YybW5paWt1?=
 =?utf-8?B?dUNOdTV1YUhyb2YxdTNxbVBidW9DSkJSQks0d1VVZUVZWVRiL1FQSmNqTy9m?=
 =?utf-8?B?UmF3TzV1bEo1K0RySWgySll0YldVbFdmc1RkemVOVDJIeXdKSzdDYnc0aUJ2?=
 =?utf-8?B?Vm1rOTNEM2xKVVo0Z0NGTW56RFhqOGdVNCtWQ1dJRUp6dE91eHA3VXRndkJh?=
 =?utf-8?B?dWZqQ0pIZk4wT1M5T05NRDQxUHFEOG9xY2hldVdzSXlVdmVBTThoOFo5dHRr?=
 =?utf-8?B?TTcycGE1cEIwOU5mZ0c0ak9uMjhaTElXZWR0YTIzUi9jMUUzL2RFckViZ1o0?=
 =?utf-8?B?bWJONVM1RkJMQzh2YzlLWFRxQXVoQWthbVVWTGZ3NHFDcG9sMTRTWUZxMnF1?=
 =?utf-8?B?Kyt1MFZTZUhDcU1WRksxRjNiTmtoZk5vUGRJdE5JWnZZanpiZDFtanBpUExS?=
 =?utf-8?B?L3JXbzVYUXZsQ0R2dXhjaktneEhDMVRWY0FTSzFEU211UFN1ckVMR1IxZ0N4?=
 =?utf-8?B?MzNUVnN4WTJ5bE8wZTFyQzlNN2pCTXVuT0N6OWQvenNtVWZLMjFqRVhMZCtR?=
 =?utf-8?B?dmNyOG1SU2tsai9KUTcwK0JFaHBwdUsvdjMwV05pM0l5SElYVVNuV2FuNTA3?=
 =?utf-8?B?TVN4d2x2Z09hbjQ0TjhtRFhObTdmUDg5MmozVDBqOUxWYzZHN1F1YW81aWlS?=
 =?utf-8?B?OWkrSXpHd3ZIMkJVTVJ2QjZ3OGlDVVh0TXF3SXBOaGlndjQxV1ZEZXV5QkFG?=
 =?utf-8?Q?LY2O5UJEjMaMXXIkniCpPh6eJBzf0112lJIso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUtIb0d6RVNLM1BjTUk0UGhEbGJ5czh2T2RMV2hJbE9BU0tQYWFjdFV0QUtI?=
 =?utf-8?B?QVRielYzNDExaFJnYXlWb2lTdkdBc1FvbC9NQ1Jqc3dPbGttUU1yTGkyckhL?=
 =?utf-8?B?eDZzWlc2M3o3eWdJRENhTVZkaDBFc2gwLy9IZHc4c29lNXU0eWo3aGI3bDI1?=
 =?utf-8?B?eG1jZlBpUU03bjRYUlVkN2h1VGhnNFhtVFJkWmljU1M2cXd3cXpuUnhWWlhs?=
 =?utf-8?B?NjdJOEpWYVlUK0xnOGZkNVgwWERkK0dDZzBTWHFtbmZPMEYxdkNaR2JTQlFD?=
 =?utf-8?B?alUvSFdkbGkxUGI4UVdrUzVreXpwRkZiZE1vSGZobktuTHVoVXY4NTNudHgx?=
 =?utf-8?B?TkFxQUVTZ3phVjU2YkQ5eStTcTFWcWdZTVBRTjZwS0g5MEx5OXp0aWxDbzZL?=
 =?utf-8?B?RS8yZXo4SlNZNWR6MHVNeUEwSnZsYytEbUpXYkZSaG54ZVZlVTZNWWhDajUw?=
 =?utf-8?B?UDBjeCtlMXRzamxIOUhHU25CeVptQ24xUXZMUDJJdzR0QkswcTB3WGExNXJJ?=
 =?utf-8?B?TjN2a0RtNnF1YVpjbEs2T2VFMERVdHlXZ3BTajR0MlRuZ1oyOFF4R0x6K09q?=
 =?utf-8?B?RWlqZ3YrUFJOYTdvSC9yL2F0aDdTajJHdWsyZDEyalpDc25VRG8vTzhtWXh1?=
 =?utf-8?B?c1BlNEg2MXlITkxXRzJWbE5oMEdyS3ZDT21DRUF4SERDazVzNWhraGI3MXRj?=
 =?utf-8?B?ejlHY3RVMGl2V3VWaHA2b0RQSllJMDRLMTh0UFFuT3dhWWgvOEpvZnN1RlVt?=
 =?utf-8?B?MkJxK2ZMMlE4SktlOU5uYnBHZ1FldXRPQUlmREJ4SXZueUl2cXFXY3NuaE5t?=
 =?utf-8?B?alZOZXRWNEdDNlozeDlQMXNsOU85Y0tpR0lWSzBZTGtZbHVQZlJJemxxWEZ6?=
 =?utf-8?B?SXppbUg3ak1uNEtITmFUTFk4YzZldGlBVmNGUXY1eHNXd0FEeVMyQmJqdlU3?=
 =?utf-8?B?NmY2SEJFUHdRZ2lheHFPcElzNkV4Zms2RFAxaUk0WGd4alhXektxaTgwblpO?=
 =?utf-8?B?NmVjWFV1ZkVYVmQxbXlHdEZPQ3d0Ny9YNk5WT1UwMHVqclBsRUpMekRqenpJ?=
 =?utf-8?B?WGI0ZXY2dzJpSVUxZ3cxMXVCWVduQXltSWtsbGh6RS9OU3FKQmJZS2hhOCtX?=
 =?utf-8?B?MklRMlBTenh0QkNnSStRN2hzYXdaZkJ5cHpvVGk2QmNLZFQxdERDZHhuYTNK?=
 =?utf-8?B?NmJHa0VKS3NDMnFudDhlU2xZdkdCT29PZWQrTDNFOXZHN2p2TjdMa3NYUWdC?=
 =?utf-8?B?aWhwQ3d6S0ZzRklLcjh3dHNNeUhLYkxWRVpkZXl2Zy8zdEQvV0FsbEdKaUov?=
 =?utf-8?B?S1RGbE52djhUUElrZm1XbE0vbTdQZllOZStiVk8yQjZWVkpiYmpLUnd2bFNF?=
 =?utf-8?B?Ni9mSlhrclJGMHNrWEpqbzJZSk5vS1MwUVZEWnBSN2NYUjdGRHNmaEwydDF1?=
 =?utf-8?B?NXNJcmRNcXJQUUI4Q1lRbk1ScFJpQXljK2Vqb29nb2QxNjhIYmlGanV3cnZW?=
 =?utf-8?B?b3pVTkFYQ2s3TzBmZzEwSksyVFNyS3VVbkkvZkRwVEFzQ3RnMmg2cGNYRS9X?=
 =?utf-8?B?d3pJQ1VITTFkME1OVS9HZ1VSci9KaFNlc0VrU1VKdzdvT2V0ODVaWFpEaW5B?=
 =?utf-8?B?d3VrQ2Z2UGpJci8xWjlzM0lZZ09hUDdNWFlIandRSXpSNy9UUVBsRlJjTXpu?=
 =?utf-8?B?YVo4amFjV2VtcUFVQ0U5RDBmdVdZTW5ZMmRDM3BrKzg3NEtWSU5GS1hvbklE?=
 =?utf-8?B?V3daYW1Ed3p5WUU1bk0zUWVJU3RJSXJyYXRMR3V6a3pOdHpDTnlSUCtlcXRM?=
 =?utf-8?B?TTQ1SDZpZkJiOGU3eVVzMkNVYWZhVFFlVjZ5RE4yUVhFN3ZPRUh3SzhnS0l2?=
 =?utf-8?B?SzdoZnMyRU1rZTFEMks0L3U4b2NLa3l2QXlXVU5xKzVMcFFJZ25PaXJXNHUr?=
 =?utf-8?B?djhQUGh3Y1NmbVZjVmZaRjcrWEVNQ3YzR0JOdU9YRWZwbEVQUW9OTnZzV2da?=
 =?utf-8?B?Q2w0VVdwRUxmVnJVU0pEVDBONTluL2F5TnNwVytIdmxJdmtUODlHRjlaOEVO?=
 =?utf-8?B?TnVYZGhzM0tpeHBPcTNqSHFEZkRONjNrN0FjaWg1WERQQVBMVTkwdEFYc2tR?=
 =?utf-8?B?akRUcTZvaUxvYjRkZ1crSEgxL3lEaSsvb2prcUw0TWFSb0RUMm5CSk9qK2l5?=
 =?utf-8?Q?Js0Qnmtyl0OzOEY/pYT2Dz4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b31849c-5cb5-4ad5-90bd-08ddefa6ee50
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:44:00.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6m7VIcaO9v8b8WMdR/1MjKNMgr0sO57ntfFVg45rKZ9cRnlJrt0jw078V3HIUwEH6mB5yjaSv19ehlaTaJzFUuZmUUdJGL2/3/2zBEViRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9142

On 2025-09-08 17:31, Thomas Gleixner wrote:
> In preparation for rewriting RSEQ exit to user space handling provide
> storage to cache the CPU ID and MM CID values which were written to user
> space. That prepares for a quick check, which avoids the update when
> nothing changed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>   include/linux/rseq.h        |    7 +++++--
>   include/linux/rseq_types.h  |   21 +++++++++++++++++++++
>   include/trace/events/rseq.h |    4 ++--
>   kernel/rseq.c               |    4 ++++
>   4 files changed, 32 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -57,6 +57,7 @@ static inline void rseq_virt_userspace_e
>   static inline void rseq_reset(struct task_struct *t)
>   {
>   	memset(&t->rseq, 0, sizeof(t->rseq));
> +	t->rseq.ids.cpu_cid = ~0ULL;
>   }
>   
>   static inline void rseq_execve(struct task_struct *t)
> @@ -70,10 +71,12 @@ static inline void rseq_execve(struct ta
>    */
>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>   {
> -	if (clone_flags & CLONE_VM)
> +	if (clone_flags & CLONE_VM) {
>   		rseq_reset(t);
> -	else
> +	} else {
>   		t->rseq = current->rseq;
> +		t->rseq.ids.cpu_cid = ~0ULL;
> +	}
>   }
>   
>   #else /* CONFIG_RSEQ */
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -31,17 +31,38 @@ struct rseq_event {
>   };
>   
>   /**
> + * struct rseq_ids - Cache for ids, which need to be updated

need -> needs

> + * @cpu_cid:	Compound of @cpu_id and @mm_cid to make the
> + *		compiler emit a single compare on 64-bit
> + * @cpu_id:	The CPU ID which was written last to user space
> + * @mm_cid:	The MM CID which was written last to user space
> + *
> + * @cpu_id and @mm_cid are updated when the data is written to user space.
> + */
> +struct rseq_ids {
> +	union {
> +		u64		cpu_cid;
> +		struct {
> +			u32	cpu_id;
> +			u32	mm_cid;
> +		};
> +	};
> +};
> +
> +/**
>    * struct rseq_data - Storage for all rseq related data
>    * @usrptr:	Pointer to the registered user space RSEQ memory
>    * @len:	Length of the RSEQ region
>    * @sig:	Signature of critial section abort IPs
>    * @event:	Storage for event management
> + * @ids:	Storage for cached CPU ID and MM CID

It's far from clear from the diff, but is there a missing space at the
beginning of the line above ?

Other than that:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


>    */
>   struct rseq_data {
>   	struct rseq __user		*usrptr;
>   	u32				len;
>   	u32				sig;
>   	struct rseq_event		event;
> +	struct rseq_ids			ids;
>   };
>   
>   #else /* CONFIG_RSEQ */
> --- a/include/trace/events/rseq.h
> +++ b/include/trace/events/rseq.h
> @@ -21,9 +21,9 @@ TRACE_EVENT(rseq_update,
>   	),
>   
>   	TP_fast_assign(
> -		__entry->cpu_id = raw_smp_processor_id();
> +		__entry->cpu_id = t->rseq.ids.cpu_id;
>   		__entry->node_id = cpu_to_node(__entry->cpu_id);
> -		__entry->mm_cid = task_mm_cid(t);
> +		__entry->mm_cid = t->rseq.ids.mm_cid;
>   	),
>   
>   	TP_printk("cpu_id=%d node_id=%d mm_cid=%d", __entry->cpu_id,
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -184,6 +184,10 @@ static int rseq_update_cpu_node_id(struc
>   	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
>   	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
>   
> +	/* Cache the user space values */
> +	t->rseq.ids.cpu_id = cpu_id;
> +	t->rseq.ids.mm_cid = mm_cid;
> +
>   	/*
>   	 * Additional feature fields added after ORIG_RSEQ_SIZE
>   	 * need to be conditionally updated only if
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

