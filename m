Return-Path: <linux-kernel+bounces-738545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8386BB0B9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E0E3B8BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577C3176ADE;
	Mon, 21 Jul 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="i2fYhhc+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2092.outbound.protection.outlook.com [40.107.220.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD08F40
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753062944; cv=fail; b=lay7A/DM1pFVCsEgt3TE2y5fG7R0qYcCv/r1tivTQP4UOcbeZfKY7PYuT26oy+haLB3goHEo+FXJdVth/k5nySB5X3ZXq83vDAbh6Vji8VriyNCqmAbP7lgS2X6WBzHiPy0Wlo/M47LLZMDSFeEL6GEqNXt5EQKKgcG7nkabDek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753062944; c=relaxed/simple;
	bh=yR5LZo9G4TTF4wF7PV4dqUZynDHwkcp23DwWlIiuseI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MBJO50RrA16rdrIDLmj6YLvlBMeSbVFYqALhsjj86SGJ5E7FawufVOXP9jLsCY47tFcobMP5m4sRPzeHBXeFfUazpC5ToPoARh2YKPhfavkSc8Psu6IHvie6XkLTZRwh6VIjohKH32EJg5Dm1kG+IU1KxU3GjcbS84tM3QobOAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=i2fYhhc+ reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.220.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzmqJybs+VbRK8XqdUFdBQPrCmj8dM9d6u7MAGCOpCKrEc4rQN5fVE8PTIqnicdge7NY9UFYnmBmc+cxiI3Df88aDC6HE//QNH1vC54ld6rLx2vbJH4kv7C8wxwLOHmuwYOKm6yjH4wiK9f9urmBI+9/DsM/BT++DSZ+FwsukSu9o0h7+M+X5IKCW22pCC7SbiLwDkIO2nXRktjM8Cl67LszRNDd8QtS9/uMKLUS3MyVTrJeHL7fAbZEA3zT+4zhjgSlemjY2iKkqV7QaqGHwb047HfOHlaTpEx0Bs0tByTOetX9Jd+ko7ZgL6af6NmnBhr4BVn2yfDTP+nix9DdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq6Sq4NhVCTEJRnKaZ9j9CXnYIYCPtkustX342NeuaE=;
 b=fB7B0IP3qXbVRqSwETy7BTLw61cckIh429H6RFr7enstrG8DuR5VRuWnhflQOhq7wL2WJb8QVe1bs/WbaBho1NnECwGTRYgVr1WDH8HvRJ2m9Ba9SsjYD7XLzckgKU07/pnyQLOBASVKBCVRHm5wbi/LGh307bIuGDzRFJGOgoGInkooyHunVlfyKN2jru3nwvTKqRSZ13hLxvIRy+lKjJ/e7/TCJdkZmq4QDvB7qJroK+kNM4W+5hWjZCU2II8QCwBg2JxSNyai+h6Q6J7CQmW3oQX5EjRzvcnjoEGSppIx1PB1ycvenc0lFKnX7I2KdK6Y5CwiNEYIVA9W1XMBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq6Sq4NhVCTEJRnKaZ9j9CXnYIYCPtkustX342NeuaE=;
 b=i2fYhhc+d8ZpND4kGqRB8P1aLM0lt24LWLYiZVSnNh174bE1ZsF//cYqBmw8b67n696uRN9jzI12T0C1AXJIB/lQFWfjbIm8/uw0obxQlU3AAKFD20u40LAVRFZWPdCZ51b4DEDUQZNt4FgeDJ51n+8iwiJ9ASx+AAeQBheb8zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MW4PR01MB6114.prod.exchangelabs.com (2603:10b6:303:79::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.24; Mon, 21 Jul 2025 01:55:36 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 01:55:36 +0000
Message-ID: <253aca31-9db1-4a1d-859e-9cf342d315a5@amperemail.onmicrosoft.com>
Date: Mon, 21 Jul 2025 09:55:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: do not scan twice in detach_tasks()
To: Valentin Schneider <vschneid@redhat.com>,
 Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
References: <20250718063523.9232-1-shijie@os.amperecomputing.com>
 <xhsmhy0sle3mf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <xhsmhy0sle3mf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::12) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MW4PR01MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 9296e3b5-6d81-48d4-9b8e-08ddc7f9af7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzdDUHF6TkFzbE44ajZRaUtXWGcwSHk4Ykx2WStIbmsrY0JJQURhbGhzcC9t?=
 =?utf-8?B?a3A5WkNhcFFhVkFuVU5ROEZOQUVwMWYzRjcxMU9UcUhIUy9FMzVDTzAzbC80?=
 =?utf-8?B?c3Q0QmhVeCtsODVXS29NM1ZmTThpUjYrYjlZYUpPa012YWlQeGF1d3NWbWtm?=
 =?utf-8?B?K2lHSUNheTkxaW5jYldXUWlBYis5Qml2NWorM3BxcVdScDhrQmpUbDllVWFU?=
 =?utf-8?B?b3JZSEp5OW1BdkJnKzRxM2c0Ky9wSFE3SGdDNUtBeE10Q052dmxjL3VlaU5t?=
 =?utf-8?B?akNISzJna1krYytEaHhJbGlaaDRmOXV2bVZUcVNFQmx1U29xVVJZK2UwVGpJ?=
 =?utf-8?B?OWMzS1JYWTRMbExiUXcwd2RJM0I4Q2Z0dFA0anhDTEtQczYvZ3M4YkNxK1Qr?=
 =?utf-8?B?RU5Rem5hWXBVcFAwNHBEQmpnT1E5RU5PdHF5Zk5RWC8wV2xVMnJtSWVaSkNM?=
 =?utf-8?B?Wi81cGdMVlZJWlF6K2c2SkplQkcxV25FbDRKM1NsNklZS05LSUMwQ3p0Q0VH?=
 =?utf-8?B?dGgrN05lRnBTYmZHZGd6NTlnbUVGVDNvVWJ0aGd5VTZoNFlaQ3J0UDUxTHZu?=
 =?utf-8?B?MG15Njg3RXhmZnpvZytZTmJoUzRSRTllS0ZzMHJGMTU3eVFFejNYN1MwaTBH?=
 =?utf-8?B?VXJSS0taRzQ1Ri9GMlRreUhuNE1saFVIU01MdUU2Qm5xSUx3dStPSlNBZ05n?=
 =?utf-8?B?VDIxOTFmTHVvWlBKVHVDNnVzekF4ckNJWHhJVzlvMS9OM3BrWmZ6UC95TERu?=
 =?utf-8?B?NkdTL1gvQ3hnbUVucmo3OHU4V0N6cTFjWm5RME5Ddk9LUW9ySFovREpXUVlI?=
 =?utf-8?B?dHpxTjRvWHJOOVdURmFTMFh4RGVNUjVIRjcxNG1RaWZreTNOcDdORXFTbDFv?=
 =?utf-8?B?VGkycDN4VjVMb1ZzUnNIdkZkMFk5UkpoTDcxUEVCdVdWR2FjMThxMWd2dXFu?=
 =?utf-8?B?dWZuZDZHb3dvT21sVzJaMVNEcW9uWVRxQVMzeWxOQU5ucmJXT1lnU1c2MUFz?=
 =?utf-8?B?Yml4Y0phenBDaDd4TUNmc1psZktWVU4wWW4wLzRLUm9maERBK1hQNVg3ZWdR?=
 =?utf-8?B?UU5QOHlPKzJoTzFWVmxXQ1EwbTkyQTU2OE5Fc0N5QjZsaXViK1hwd09FcEhS?=
 =?utf-8?B?d2tMQXZGanYrT0JxYWsvcXlLSnZWeHlob2hNWFZ1aGRKNVhZditGZ2ZtdVF2?=
 =?utf-8?B?VnkxWGdmTStsaDdabkF2djU4aHAwRWozOUE2VDJ5TktzQkRSaVZac05hbkk5?=
 =?utf-8?B?ZXhSNWFuM1NnM2NjbUxNcG9UYjhWMDFzcktIc0hCbjRweXF2dUw4UDlNcnVV?=
 =?utf-8?B?eHpOV2FZYnI2SUZGRlJqQkFGL3Jtc083UHFoSjJuT2E4Y2Fsc1cyVm9FWHpZ?=
 =?utf-8?B?Q0NQQ2x3V1JCOWhLRklLcjdodUl1WENpZzJLSWYwclJ3Uk9CY3NUcXhGcFZm?=
 =?utf-8?B?YTVBbEtmYVU4MzZUcjMrb1g2Y01qRytiditQZWxRdG16VlE4RWdVdGllcEc0?=
 =?utf-8?B?dUdlR3h6R0tuTHpDMkE0YXdGdHNyd3pjamZnRlpCSklhMjdxWTcvZ1hrTjRk?=
 =?utf-8?B?UkZVSURyYlJ1TUtJN0ZFMHhWRkp0U0VmVjY0SGRQOUN5NmhOSHVJWkRUbm9s?=
 =?utf-8?B?VTQwaGhDcWdFUHpYMUtwVm44WVFnbGhuOHRkbUxVdE1ZRFNEYnFhWElYYjZi?=
 =?utf-8?B?UFJSMVA0dXhJc3dLMGtvTzRiUTAycXU3M1VveUZjN0VyTy9JaHMxNFpvbktF?=
 =?utf-8?B?UHZEYnA2eXVaQ3Q2S05YYTdPbmN0WGlnVlRXMEdXNi9VcG4rWXBrS2p5b0xs?=
 =?utf-8?B?OFhLZnFsN09zWVcxQzY3K1dlUlh2UmVSdE1wT3lQUFBVVUY5VGYyZUdmeEpV?=
 =?utf-8?B?QzRRL3JCZkFHUndkdWFKYlN2NG5IYUJUcy83clRmSEplbjJnYS9DUWpxUVlX?=
 =?utf-8?Q?SpvYs5GJ8IA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckFkNzVSWTJmSlo1dDB5dVdVSi81Y0huRlZ0aU9nbk9Vb2tBRWRFS1AwUEg5?=
 =?utf-8?B?cFhoZmRTcHZoV1NNV0d5VWhVeWFtT3lyVU9LN1lJSUZmZm92QnR5cTI4dXJa?=
 =?utf-8?B?cGVhbkhiVFM5a3pYZHQreU4vR2FnQzluWmNhWVFjQzNzaG5Zd0pxNmN5NHMr?=
 =?utf-8?B?WVZlZXFyWU0zWTFCM3lVdU5yelNGSHV5bWM0RjF3TjVZd0g4Q0g0cCtmcGZa?=
 =?utf-8?B?QmVaa2owcCtld1lhTndSbXNiMGRYVzgwSy9SdFpTTGFFNHE5THYzVmRQL2Fi?=
 =?utf-8?B?RXpqcnk3dmtZQVhqRFVPa1paRmE2bEdXSTRCbFFkbEJwWDNrRW4zaVVqOUhu?=
 =?utf-8?B?RVlEc1VndThGZXhGbUpUamoyakNzbDBrTFZMN0RVbXJrUjlPMzI2ZHU3UVNX?=
 =?utf-8?B?UitKWDArQVU4aHFnV3NXQXk1RklxUTJRaWNZYTQxVWY2cHZrMjNIWDUwbjVi?=
 =?utf-8?B?QnRBblVMa0VjY2R3emRIL1BuQlNBbVNWWktKa2crcll5SVh6ZDZBaUkwVHNP?=
 =?utf-8?B?ZlpJMi9wNTdZMFZlVXdwd1pMRXI1bFhPZUcwVk5VTGgwQktLSGM3b2tKTFQv?=
 =?utf-8?B?elJyVTMwQ1M2S0YzdVRyUVdJaEdtVFl3Lzl5VUJuaUJNTUdMRnJ6dzFHUGhW?=
 =?utf-8?B?NWxtZWhTL25nYkxhSUMyM2l5OCtrNlhKa2NESXVjK2hqaEJ5YXIzTUNOVmlB?=
 =?utf-8?B?VkpscHZjTGpXT2dLcFlJdFJSWmZGTnR1Nm5jVzEwWHU5c3l2eTZpTXdFejRN?=
 =?utf-8?B?VFQxdUdIUHlUWGRibWl1UDcrOEIxQ2dLWTNxM0lBUm9ybFg5NEpSNm4zSUtV?=
 =?utf-8?B?aXZjQzNjcWVyOUFyWEJ1VFhHNG0rZkV1V0tSMDIwMVRFN2ltQVc2bUZUK0R5?=
 =?utf-8?B?WTZWdG5UN1VLcEJFSUFhVm9aZGdYQi9VZGRjMVlpdTM1R3VHT2hoYkdpQWVH?=
 =?utf-8?B?Tnk2b3AzQnZGRmVJMUZPTFdldEVoZGRNeElBczY3YTh3UjBTeERkbEJ1M2JL?=
 =?utf-8?B?dDd6cWVtRHNoVHIrVmhiTzhWS0N0eldRWE1IOHhlQUlJNWVLdy9icUxUaW9n?=
 =?utf-8?B?U0gwSUUvem0yOGhGekdWUitWd2dBNElmWGFxZld5R2xZRERGYVVldVFvT2h2?=
 =?utf-8?B?K05QcHZFcWZORmgyRkUyQWVQTjN2WFpqZUFsWjNKbEJkTU5QNjl2bWthTDdU?=
 =?utf-8?B?WXprTEFKZTRWVTRvaDV0U3VxTStidUVSc0JBY3hqbmU3UWhmblZKaGxHZ2lq?=
 =?utf-8?B?NnFSRU0wSnVzR3BORXJRcHowUEZrQWFqUS9jOXMrcUplMHBPMm9VSlhhbjF3?=
 =?utf-8?B?SFJZcnlXTENRc1EzNDhsRldQN3JCZGIrU1loOGZTaS9VdWZKOUg5TElJaGdY?=
 =?utf-8?B?ZldHN1dlMU90YURhR3FxZmRwWHFDNFVWVDJ5aHl0c25zNDJkSjc0MjJZUlRh?=
 =?utf-8?B?b25sbUs1VEVDZGMyMkw5V3ZUTTlQbDNxK0lnVmZBby8xREJiS0ZqVmZpUjFI?=
 =?utf-8?B?N3JwcGhTZ3lQL3FJb1FneUxSSkxXMGdIMmpFOTJmcmttL2drN0RRaytrSGQ2?=
 =?utf-8?B?Y05vdklJUjNBSS8vMjkrR3FTUW4yNlBod3pId2ZZUWpKSi9xUFBxV0FSMzUv?=
 =?utf-8?B?NGNxZHRDMzRvMTEraDJHdjgwckxOU0RvRG5NQUZQSUNGYXNtQzNKL2d5akEv?=
 =?utf-8?B?NTFUNzZlclY0aU1JZnhjYldzTVFaYkRoNHZFWTV1bytlYTkyd0IzZXRGY2R4?=
 =?utf-8?B?a2ZxLzhLTm1EUkV3cVcrNFFYZWJlUDAvVUJ4N1B4eWdRWGJBNzB5Q2xzQmdh?=
 =?utf-8?B?dUlZV3hwS1JsRG45YUZncnRJK09DUUZ1UGtmRzB4YmhjRjY3ZmU0T01zaEl4?=
 =?utf-8?B?c1RNUTZwZWFQYlFpSDQ0RlZZK3ZKN0hRMUQ0QmxBS3FaWC9QUG5LTmRVWEVK?=
 =?utf-8?B?WGtPZUNoVUZIemd2aGlFRFoxaHpGekkzMkRncUxOcXVHb1JSSDlpQ2lpZC9W?=
 =?utf-8?B?bFJSZVIya215MUtUL0hOSGU4UGhGRjNicHRCcU5YaEtOZlRQTGhOSzBoQkg5?=
 =?utf-8?B?R3h0TGtIRG1Za1R1OWUwY1U3WFkyTWt0MXV2UEhTdlI1UldZam1qWDF0NVFE?=
 =?utf-8?B?VHJYWnQ5bXhOcWxMTXN1b3NFTU1VZW5tREFCK3loOUtaRG5FWW4xd080TlpP?=
 =?utf-8?Q?QBNMexavmEilYJQAaKrCWE0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9296e3b5-6d81-48d4-9b8e-08ddc7f9af7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 01:55:36.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3v/HAJJ74TnSc+x1FrwgDLElfs+86MsoDB5iXtKs6/jBQ6E8tXakmc1n7z/3Ktdu6n21bjaDgHsMeHFd7M2tRUF94F+5sYdavuWEnrucFaQF0ofAGV7T7Jy2qtX3WwG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6114


On 2025/7/19 2:49, Valentin Schneider wrote:
> On 18/07/25 14:35, Huang Shijie wrote:
>> When detach_tasks() scans the src_cpu's task list, the task list
>> may shrink during the scanning. For example, the task list
>> may have four tasks at the beginning, it may becomes to two
>> during the scanning in detach_tasks():
>>      Task list at beginning : "ABCD"
>>      Task list in scanning  : "CD"
>>
>>      (ABCD stands for differnt tasks.)
>>
>> In this scenario, the env->loop_max is still four, so
>> detach_tasks() may scan twice for some tasks:
>>      the scanning order maybe : "DCDC"
>>
> How about something like so:
> """
> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
> iteration count limit. It is however set without the source RQ lock held,
> and besides detach_tasks() can be re-invoked after releasing and
> re-acquiring the RQ lock per LBF_NEED_BREAK.
>
> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
> as observed within detach_tasks() can differ. This can cause some tasks to
> be unnecessarily iterated over more than once, for instance:
>
>    env.loop_max := 4
>    detach_tasks()
>      // Here env.src->cfs_tasks only contains two tasks which can't be
>      // migrated anywhere, so they're put back in the list each time.
>      env.src->cfs_tasks := [p1, p0]
>      // The iteration goes:
>      p0; cfs_tasks := [p0, p1]
>      p1; cfs_tasks := [p1, p0]
>      p0; cfs_tasks := [p0, p1]
>      p1; cfs_tasks := [p1, p0]
>
>      // IOW we iterate over each task twice
> """
Okay, I will change the commit message later..
>> In the Specjbb test, this issue can be catched many times.
>                                           ^^^^^^^
>                                           caught
>
>> (Over 330,000 times in a 30-min Specjbb test)
>>
>> The patch introduces "first_back" to record the first task which
>> is put back to the task list. If we get a task which is equal to
>> first_back, we break the loop, and avoid to scan twice for it.
>>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>


Thanks

Huang Shijie


