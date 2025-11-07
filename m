Return-Path: <linux-kernel+bounces-890479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD319C4026F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1083B9709
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53F2F363B;
	Fri,  7 Nov 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Cos/LjFf"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020135.outbound.protection.outlook.com [52.101.189.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8EB2F12C7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522640; cv=fail; b=LkyT28EvXn8++lNbVbU7pGkawba8HpGaESDQmpG5c5sgZZa0d4hkElKJhHfvmLlF/ZTJMRynhYzMnSl7xrX+HDGjXQN8nuqihkrG3/nx5evHXRaQLVFwzy/wLf4AXhvbLhWIE8N95Rvi6Z2XHDpQr9D6UIi3XL+INSSgEby7v9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522640; c=relaxed/simple;
	bh=gfW7KIGLts4/rhnWEM8uF0GmYmVye9rTArDZId4cQ14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fx07BVvCnHT6gt6O3At88BBkNZhvFCHD/JoBDhtw6lP9ta3CXNSYEM501nfMoGYYD9PGORttoTdB0XvBiTa61LkJeHfjJsW+F7xn4T1bpWnncMAtYSpG6XNDcqP58dJvjZuk6Jk7GKaGEf/fQ9MTxI5koVHsLYXgyvDmzMWPVnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Cos/LjFf; arc=fail smtp.client-ip=52.101.189.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV8/j4/8gDexkYbXjRfaOgIBzJZ1wj0rh7TLx+nCu1X3+0L/yA1QBLIcejp8U+GxnBFqtKbOtjnGyIFloxeT92TOgS9PsPS2JVWtVN8ygk4OyMgURUK36JNXVVEE+XGoB+8fLCzNE/wQfPfhsAWUVflYbqvB5foGkprXE2AX0DDGEPYQ3dZ41WRtusijxuy06vj5sn1ZR1YsL+gcpyX1MFC6FMnNBpxxaAk0M8yBAkbd8QiqKa9C9Twao2vFU2vFwnCezWL6vrrkJB5Y/X34afv4TO/oC/5A/SmzyZXZei1/ivh91hqDRGyefXuoiLzzzQVBC0WthlLgAMPsj0102w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFkEhNdeirzYDLgHMlCbUVYH5Ch+cyRvfYuoLUYYQjA=;
 b=Fa1bVpPgHZClD2KvHpgyr75J1H0OY3v7lD1zQFpFYYRAsCXzbbe1hAFS5uka85SVFuXIGWSj0hDo27R2SPfnhlwbU6aNnS5+X7xrlxTAF/DA6zuF1Fw/n/xPUU9JSEkjbil1bN+o2ZfIqB4S/EpNvI3jzA5/QQ+NP4AdO/rbDMU9kN3BP4Mu50YEgub8LeTW1dSQmH6dVgzPU/A2UgRZnHH8XHz9MlKK8lHs4UeCR7byfm2GWXRnEyQSkxaEvF1jlXp8kULzd8IP1PPcN1mon7L6ctT3wDtKtA5PWsiXevuXEybxKlsfy6durP96cHPWr7zlmUdqz5dlML4BxQ5DxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFkEhNdeirzYDLgHMlCbUVYH5Ch+cyRvfYuoLUYYQjA=;
 b=Cos/LjFf8ljmQq6HpljP8YYJLoIbSv/G+xYgbARz33+dzniZNzUzUr8ys6XqkCgdNgEBDtxuEnivZr5pL3JTD/Ia+yQTrDJcm7gWfwtN+XKEU3f2yLi4juA8JJB2HD1wkohmFMXa1BRFln6PDJFJBLLPVtaE86ra10vDFho5IINp+WlNoUurPrympGODGbNQNapGPKlkHD+nTvsS/vOgbftqVuHoxBtam8PKRcBvAe6NZEEnTEVdz5qpwj679Nt1sYTWGlbcKmFSOi/2UbFOA6rOr7riRfgcXyAn6PVoHDNQpjjDyD9kWQ7gdgGWTmgp74fuoECqsQ4WOhn/Dbq0AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10394.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 13:37:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 13:37:15 +0000
Message-ID: <af44f010-313f-46ea-b1ef-9be43bbf4f14@efficios.com>
Date: Fri, 7 Nov 2025 08:37:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [for-linus][PATCH 3/3] tracing/tools: Fix incorrcet short option
 in usage text for --threads
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>,
 Zhang Chujun <zhangchujun@cmss.chinamobile.com>
References: <20251107130730.158197641@kernel.org>
 <20251107130758.272051237@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251107130758.272051237@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10394:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bed941-4e82-4112-65c7-08de1e02c38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3BjM05BSy9jZ1JEZFpDVG1NZ1BHejBmckw0TGJvTStoR3ZUTktGcDUrSXBs?=
 =?utf-8?B?Q0haMnJoU2xSajVqQStuWUxPOG1RR3h2V2lCcmdjalZaNFcrMnNPRk1sdkVp?=
 =?utf-8?B?b3BiYlB4ODBvaWVZN25vMnpuMjdNY2lGL29hR3F3NWJCaXR3Y1Z1Y1gwM1lM?=
 =?utf-8?B?akhCY1JsK2Q4VUNJRXFMNnc3ZnRSWVFoUnMzVzZDOWZZaUJKR0Nla2N0OCs3?=
 =?utf-8?B?WVVSdzVEdFFIdHFCZ0JxNm9jQWtQTnZuTFFGVmZBL0RVSWhtVk01YkJGaE1W?=
 =?utf-8?B?MTNaNDRyTDhPS2JuMjRpSURVaVhIN2FNU3lIY3dBeGdETmNQVW9qSlRmNTZj?=
 =?utf-8?B?bWtlTEZpR1YrdXZ3RjJYRkcwRlZFejVnMFhGSWJqcmVTdlBmU0FzN29OKzZu?=
 =?utf-8?B?aG0ySmNPSXhsM1lBdFdMb2xYU1IxdWJVNjF5d2JIc05ZdFdEK2NDNDVxY2dG?=
 =?utf-8?B?NVRJMG02U0RaL1dkd2lrRm50bFBGNmMxeFRrbTFPWXJ3OW1nZEdBUmVEdDhX?=
 =?utf-8?B?SHh1UDlzbHUzT0lONHVialB6c3Y2ME00Tk1aRm9xZ1c5ZElMUnMwWWFiRjUw?=
 =?utf-8?B?K3YvcmExY1BIQXkycy9BZHlMMVhTZG4zTUE0OVJSbUlMRlZlVXV6bkZJUDIz?=
 =?utf-8?B?N2lXd3ZWeWQ5TDhqaTNIYS9pWFJsTENISU9Ya3lycHcrZm90TGltTU5jVE1l?=
 =?utf-8?B?L3pVVDhMU2Q3TklHTmZxNU45clhKaGs1RVhyaTFTTm43RmNySExpQlBXNXJt?=
 =?utf-8?B?UW9UTmlDc3V0Q2xRSm9XWVNDc1BaQVpTOG5wbjc3MGprL3dEQWMvTjlkUlVJ?=
 =?utf-8?B?TFpERkQrOENpc3VyQ0lyUkhGMFByNXFSQWJLQ2RnQVF0Z09xMGtnZDBqODhk?=
 =?utf-8?B?WUxDVVNFOEJKWHpoSzhML2RpNGxJWHU0Qm9wOXZBOUtKTWhrTk1TTE9Cd0lX?=
 =?utf-8?B?MkM2MUx5Vk9LNkRIMHJXSUswQUxaMCtZMnFsdFM4ZGpPYkx1Y2tlQnhiYTMx?=
 =?utf-8?B?Rk1yMGpTS1hDd3owanJwbzIydm9pL3VhaGNVa20zTDJ1dmQwR3FWK0thZXN2?=
 =?utf-8?B?ckZPRzN3QjcybkYxa3lobG9va0c3cExNMXdiTDlaeFEwSy9GLytJdXMyMVlz?=
 =?utf-8?B?NEdWdUY1V3ora2Ftc1BYRENVR1VXT2JGZG5RTVkxYzBNYkFOaS9adHFubTI4?=
 =?utf-8?B?cHhVRWIvWEVPekkzdmE4d2JJZ0RYcmhaR1QrQlZwYzN0VTJ0SFNRYjBiTWQx?=
 =?utf-8?B?TXEvZzR3eTc5U0JaZHdhc0RXZ1ZSL1ZBQmE4bDg4SVlwRjZBS2p0RDZFZFV0?=
 =?utf-8?B?cGw4OGNPeWZuOVJQcUlWdXVTT3VFTllzRXhWRng1OGh0SW5mSXFmSmdvY2JE?=
 =?utf-8?B?L05nbjY3Zy91TDFLbUFJSUt6THh3YXZIcGFxRnBIMmxXUWtra09Gb2V6dUN4?=
 =?utf-8?B?dXk2RGVWR2E0MGl6NjBWKzk4WllOeDZnSHJRQVdXQktYbk1lNWRHS3pLaGI0?=
 =?utf-8?B?Kzh2YmMwaVNBUkVLSW9CRU9LZlJQK3JlZFdFUUJlaEN6bHIwWkgvbEorT1VN?=
 =?utf-8?B?cWxiVnFXSmVXeHFJL3pjQTE5WmV1di9BVVhvTTZLS1IzWTRFdjV2YmFCNVFM?=
 =?utf-8?B?bE5keG1MajJEQUVHaDAvT1JMdGFXT2c5SmtWdTNaOUlZQ2hPdm10WEhqUGNF?=
 =?utf-8?B?UEZvbVpyR3dUWndLL0g3a3gwREVySXpKNTVmTUxKWDl0SUJTYjYwQ1RoSEZE?=
 =?utf-8?B?QlhsYi9JaVNGcXFDTExUc3JGS3ZDMXlzaGE4RGFtakZza3NLdnRLUkRxdkhB?=
 =?utf-8?B?dmxJV1hiUXdRTnptT1Z0OCtrUURqY05CREtVNDRaaTEzZkdldy9OcVdPVzUr?=
 =?utf-8?B?MmJoUWhYV3FNc0wwcm9GQTRWSmxtRzhxRHNZaHN2NEJwOUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnBsSEJIRVJYSEhvV2lwSDFKb3FFbXZQaTNjVFRFeG8zemx0T1V6SzlnWnkv?=
 =?utf-8?B?TThzZ0cyeGdXV2dwVG1MbTFYSkJxakpESUtha2JIcENHaUhUbnBmR2hyeWY3?=
 =?utf-8?B?TGNIQWFrdHJycU9Mcy9HYTBYMXVIRVpmL293NTlEVjdJK28vbmltRHFuWGdO?=
 =?utf-8?B?VlNHbTU3RlBZSW1WRDlOSXVtSmswbE5CbzM0d2VFRTNsVnVVdkYreER3a0xs?=
 =?utf-8?B?Mk1MQzB6S3k5cTU0RzBuS3dlZWVwZllocTRPVHVGMlVTaG1iWSt5MVZidUdm?=
 =?utf-8?B?TW9HejNNdnVrU1BWY1NyU2pRV0d0aWRvd2JHUk9Wd3YrTVNNQXJJMDRaL3Ri?=
 =?utf-8?B?WVRFOVZmU29JeHpDQmp1S21meEVhcWV1WDdlNVRSZXh2Q1FvWnk2elBxdXFj?=
 =?utf-8?B?SlRmVFc0WXNhS1BOeUVDdFNVOE5TMFI1b2ZzMEF5T2d1U1p2ZFhDbzh1V1Ir?=
 =?utf-8?B?STlLL0c1QXl4MkJWZHFKSTAwMFkyUWVKcm44LytkZTZCMVhJbVBRd0dwMmJC?=
 =?utf-8?B?eGlraXJpZElOdVZyRitnRktqV3JUMHZrM0JERDErQ0VlbUtSZXdCRDhPY1BE?=
 =?utf-8?B?T0ljOWRGR3A5eFpRK2FTNjkxRFhuTlAxV0tTWXprSHIzTmhWeEROaHdLejNu?=
 =?utf-8?B?TTN3UVBGMGJhQnlQMkxyYlR1VTIxWlFZTC9ycFNpcUkvOUp0K2l1Q1hqRjhZ?=
 =?utf-8?B?cm8rU0xScVc2c2NaWHJsQlB1M05ieVJ3RUc5QXk3b0gvT3phbGtZZGZhRGpS?=
 =?utf-8?B?aUhHY1FHNE51MmphTEpiQTA2VnJydlQ1djY1MEw1OVRDT1Z0ako5a2RYcmpS?=
 =?utf-8?B?VHY2MGZ6WTJxTkV1S2VOeC8xQzNBb2ROdkJpODJhcDRTdldGdGh4SHlMMmly?=
 =?utf-8?B?TUIyMmNyN0w5WHRJRERhMC9KTFhFbi9HVzl6enJXV3RuK1N4YlhzaHdodzZP?=
 =?utf-8?B?Z3pDQ21xUXEwT3hkN01Jckt2MStha1hZNTUzZ3JJK2VFZWFFNnFnQzBLODgy?=
 =?utf-8?B?QlkrN1F4SEFqYkN6UVlKK3VYYWxPNU9ndDNsK1V2dkxycUlTdUpyalJNeXB4?=
 =?utf-8?B?RytFOXFHNzJuQ2E0VTJSWFBBMksxZDVyRkhKRk44dnJUdHhLdVdPblBlczEy?=
 =?utf-8?B?UEFKRWd4Qnk5YkZreGdqOTk0ZTZHaGVKYnJJeFhDRW15Y0xhdW1FSzVYdm82?=
 =?utf-8?B?M3ZodCszWnBVTjFWM2o4YXhxOEpJN0tkS3dCNjlWRjJLVlhJeEJWYXlEK1lo?=
 =?utf-8?B?UDZnQldIZzhiUUUvTXBUNVo1OWlvTnVUaGVwWWh4WTR4TGdDdDlKak5yMmxM?=
 =?utf-8?B?WllIRW9kNS9NUkEzWTRYTjZOMkZOdEpEZVNnajJUcTJ5Mmx0Z3JnTC9kN01P?=
 =?utf-8?B?bzdXcldsQUxzQXdBRVhkK1YyNCtydnNVWTV0WEhYOHk0cG10ZnZZK2h2cUF4?=
 =?utf-8?B?Qi84cWM1MHFJNjBGWUxTViszSHdrTFkzZ0lRTDVJNVdwT0dnWUh0bk9Wem1P?=
 =?utf-8?B?dVU2aEZIT1ZqTGppeFY0cXp3Yjh1YUJkbkxtTGdZVmV1b3NsTzZrUGU0RnNl?=
 =?utf-8?B?VnFjQmYycEFaeWpiSGJDYzYzMmFiMXAySFQxdXp3WUNzTWVQZzJvcytTcjJm?=
 =?utf-8?B?ZUtiQnR3SzJ0VUdscGVhaEdWNFY5M1hnOEFMMlF2cnBCdXpESjJPYXF6MFhj?=
 =?utf-8?B?aWE5RDJ4VysveSt1bEVUdzZ2bUxjdWZtbnA0dUx0ZzF1K0NZTUt3VEJWQm5p?=
 =?utf-8?B?eSs4WndoN2VJVUErSERBbXA2RHFhYjhrb3VRbjd5T2cvMzhTMDZjQzV6TU5W?=
 =?utf-8?B?RkluazE0MENaU0xzOEZMZnJueHJ6UEhiSzJPUWNQZytDRWJ1aFhQY1BNRm10?=
 =?utf-8?B?RmkveVorWmF6N0ZJUm5pbyt2WWZsMFlGNmhPbk85cnptNmNUbmtwQlhBWnZF?=
 =?utf-8?B?b2JNWVNoRDJUV2hjR01LckJoOE5uaGVvUEdRQ1lkS2xsdXVIdTF6ZHZFNEtp?=
 =?utf-8?B?VHhna3UrSXdGR01nMnA0UVh6TzJOeWNMMFd4WXc5RFpyaVNnWHJqQUxrdTB2?=
 =?utf-8?B?M2RQc2tZVWEzSEZqWVJZemlXa0RnRVFjSG90aTQ4ZzdzeWp1STR0dXFZQzdG?=
 =?utf-8?B?Zk1PRzNCZzF3N2JJbFZZTCtSblNjdmhLWlBzWUR3cDdzcFRKTE9RZXJsVGtW?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bed941-4e82-4112-65c7-08de1e02c38a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 13:37:15.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBJUnyK7xqy38JW28iV+lUahrBRnXRMOg5XPMq2y2q5XtwwIOUjfMPXXVyUmfajyl1VDykWxaLiQmsY4WAF/jw0lKN+iJMcohMV5K7NI0nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10394

On 2025-11-07 08:07, Steven Rostedt wrote:

Nit: Subject: incorrcet -> incorrect

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

