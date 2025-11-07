Return-Path: <linux-kernel+bounces-891107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08608C41DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF253B9462
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CC9305067;
	Fri,  7 Nov 2025 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mifXYcGO"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B852E88A7;
	Fri,  7 Nov 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555549; cv=fail; b=QQQBmyzlNNaQV+8E7W8mPcS8eAwB38SJ5Voq67i7LygHTiPNNMhk0UG9PHe73jbQFNZOheJrNDh9VokFrJMcfIV7rG0/+vVzB3PCJFPnxQ5+lQng79cz62416szV0LIlG2AXCAEXNSw8pcqVlQqr+hP/wMKBr6vR72ve6eW0mQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555549; c=relaxed/simple;
	bh=ez6m14NrbQgP5asreKZj28vUoRTOpvGUdWrmSHeBvMw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rClLXt2x/ODADLQDdFTWf2ZPI1P4fYzA0tmr95HMRaeRsm5gfyOpRMJ/4GZQcIBp1HiCfcoosW/ysMnnZ521TTqxIxAaqbEFDMdu8nYbqEso5WuS2lfb4lpmrcgnPsuEpYpmWRAyPQf8QOYgR3JXmRJejOvG4Z8Clvahoau4DwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mifXYcGO; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZwNJptiWMqPcjzQZoq+sT+sE1kcxhDFOAir/Pha8FezDbxZBhML88hSnDtAjt5ntrS4+07OM7dkxox2ExbBUF1PiZqAM5/bdARZlNRoQkPtJWsk7Tivu+GHDzyDFdK3SdQIGt3dvNrD9jS5eAB51SheW6/XtWCxnoiy7ngAswwCTxcNpoPIF9jCEi91dqN/z4nx9VepHPjLbAOLJhQC0dTI52ctqQNemQQjoyXRUz0ofgM+v1a+udcQrewukBHkBCXsWYO3TMWmEXXlkjvwK6jCnm5ztvcWNen1RLACvOpYJnlWEi1pHYo+4vO3MmYbiLekQ2xS32Yz1qh457Uk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
 b=xTiPJOtaBgDn+sgel9zRtPNK8X3XY/J5Nj3Flfhbp28r/zaC9I97qeCwzUgvQnftqYvjw8Tai28rcjbVviIROyyaXkYbIXAEL1Aw2NKy3evdphQv1EtkhG7JpyEra29JF8gDcMJ0zcq8PLZWRw5XtyWz+5ncOxaNVYuHzJKZbWLlAFYzr2srf6Z13QuaZYWu/BK5QfCUQwaZ8UnMxMlrgCeVfeaVW7K9l4G86kbkVs2OWyCZAU3vmyRlxS1IJ6xWxERZVumnxnGoJm0xXw7P4Thmkdu5enC6r6+8r7xanJ/SVE5L3vYP7bQWH8ivWkYx8ya810BpuSPZr1rTqsIe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
 b=mifXYcGOiMvua+nNClgY7pm5fPD4Adc5ABxW4xZG+V+yxqC9b+hX5Ezi7GNumPJr2jJvWBTdV32FCTZ8EQfZ76LD97duU052hQpESImwI/d53Wb9m4KVNyaaXcYqcuW1NypDsk0THnjcfbLn0Mc/4TUxChh4YX6GYA5Akzb7GsmKbiP4S1gITQlBdzz19BAZpLsASDXoMjOsVzggpnT5fpBbnQsZYTWF0WelXJ1g1XjNvWHw6WWWK6cWUR8YVdTHEWGQQ4AUtdRBsd6fr4NnziFZsKTD2qJIfr4lbzU8mby8C3t2BHFKk8k3qTGLMVEfuklu0xYY35quSsN2VcE8MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SJ0PR12MB6806.namprd12.prod.outlook.com
 (2603:10b6:a03:478::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 22:45:43 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 22:45:43 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Fri, 07 Nov 2025 14:45:36 -0800
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: Add Nvidia msx4 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-msx1_devicetree-v2-1-6e36eb878db2@nvidia.com>
References: <20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com>
In-Reply-To: <20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762555539; l=928;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=ez6m14NrbQgP5asreKZj28vUoRTOpvGUdWrmSHeBvMw=;
 b=RqEeWMQ9jRCUAw/agFR7mvFVjDS/cemtryuoSc0JWNr87zT+Yf3dwYiHWh7VrpvHJudMlWK+n
 vhUpaQYwrqoB94wePxwxV6Ix74X7wqQrWguzrWCuW3moyyizrBZ3WRH
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 66097ead-7da3-46fa-f284-08de1e4f6214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHNsd29Sd0U4Nm04alNnUFZkcXZBYURvUzlVay9rNkJpSWROVlVPYjVlczl5?=
 =?utf-8?B?Z3dROTZGTFUvd3kyQ2pJZEx3WWYzdEFHajBHaDFwSS9PRmlVQXlQanFwai9j?=
 =?utf-8?B?aktnaHhDS1M0UW1UdTZSeUo5L3BvYlBsL1ErM0NHYW1GMDU1RDU1MHNENFVu?=
 =?utf-8?B?dzRMTmdEUmZqWUZQVzhXTEJZWHpraGo5ZFY3R2gxYUI3cGJadXlaRFlHL1Vq?=
 =?utf-8?B?Vjc3d2dZQUlLV01aR2wyV05sRTdHQnlsYSs5YWhOelRMYzNVb05JSWo2UU0v?=
 =?utf-8?B?ZWRjVkx5RThsWVNNUXhnOE9UZ2dFVFJQRVJ5RFFrekRpSFlpcUt4QlJ1UmRp?=
 =?utf-8?B?aDBoTlRuOGYzRFlTYW9HcGE2MGZvNDk5ZzdZYlZMN3V6RkNJL1RhclBxTVZQ?=
 =?utf-8?B?WStIUjRIYjZKM0NwbVdPbG94QWVhOTJnOFdNUHhDaFJxcktMWnRJWFVuN1Bn?=
 =?utf-8?B?NkRDYTVjVGRLaGpnZXpSam15eU15MnVrUkJ0b09SQzNWSFJHb2UvNnJSTTlh?=
 =?utf-8?B?VW9kL3VENEExbG9BUThxOHRVZ0tadlZHM2JGOFFPVDhpalprTmVZTlhVbWRj?=
 =?utf-8?B?RFdPMHdVcXhiSmRkaHVnUnRRUzlVbEFRTjhSRGY0clJKVU1TZUVmWHZoeTVX?=
 =?utf-8?B?bjlRRVpCMVRMVm5DV0g1N0l5YTY0SWx6QWQzNElYQVNGYzNqcStvSG45RDEr?=
 =?utf-8?B?UGp6Z3NrZGNQRDJOOXhybkxQQzNCeTVWTVlqbElVOTRjQVZKZGlhWDUvL3M3?=
 =?utf-8?B?S3M5c3N0clA0c2JrMzJZSElkU1Rpa0hHOUFXUFZVQnFJdkFSR3FmT1pJd1Er?=
 =?utf-8?B?RVpMNldMSElhRE9ranorUEhobVdhcm1pMnV1cDIwNGJhRCs3SlRsekk2dmZw?=
 =?utf-8?B?MXVGQi9JWStIZS9oVmVFK3NCL1NyMkNMQnNITytPbDBLTmc0bTFUN0NwQzJM?=
 =?utf-8?B?MjFISHJFa09CUEdvNm1WclZPNkYyTExTcktlTG5YbHd4aEZXZTkraGJ5VDVy?=
 =?utf-8?B?b3Y0akhpK1F3UUQ2ZWlJdE5qSlV2UjNyNk9DMFM1K0JONE1sOXR4clFaLy90?=
 =?utf-8?B?eFZJTk4vWUhiOXY1UFlEMjl4bkZYRmVWWlhZODArQWpkd21TTzBFdTFNZlE4?=
 =?utf-8?B?cXZRTHJNaFpvQlRvL2xhbHdhY3BsaXBQRFIvM1IrQ3RobTUyS1huOStSTllp?=
 =?utf-8?B?UUl3TDd0QXdzaTVoaVVZNzhVTUNwOFp5K1ZPSTcrMlhvRFNwMnVqSk1zc3lo?=
 =?utf-8?B?Nk5vWERkQjJuckZIbktZSHJVZU9ablhqNGlvU2w1cGNLTC9MdnYvVjRCM0ht?=
 =?utf-8?B?bUk2aFdBaTNpUmR5VVJIc0lkYW5pdkl2ZCtoTEI1dExtdTJKUDB6QlVYVS8x?=
 =?utf-8?B?UXFsb2g2b3BCTlZKbDRRc0pWbDhoZWRoSENWZnlicFkzVlJHNUFBeE5vQzJs?=
 =?utf-8?B?NU8ydHJ1ZjJuYVA2Wmt2MWw0aHk2aDlIUUdOYkRTc1M2YmVvZVpnaXhTcW5N?=
 =?utf-8?B?UldIWUVjcWxodzhrYURLUmsyWCtuQTZQVEc2cmErMHVCeDJtcTFueXlTOVRz?=
 =?utf-8?B?WlRGdWprVkxyQ0FjUGJXU3VrUCswaU5BOTcxbDNqODRoSEVqTHFpL2Fqd2RP?=
 =?utf-8?B?dGFPMUtJb09MSlh1c3pHRHJDOElCek8rSy9YRWVLVGkweXN2QkJOYVVIWitz?=
 =?utf-8?B?U2YzNVpkQUs3MlBkaUpQWnR4UzI1aisxd2VQY2pYUU5CTXZZV2l0RjJ3dUht?=
 =?utf-8?B?YXV3MEpRenVvUis2bWx1dmVHNTZxQUxmVmpIMzU0bXI3eVpJRER1NG1HUXJw?=
 =?utf-8?B?d0xjMjJRYVBVWS9MdVhIcSt6T0puUXI0c0ovcG5oY3NCZCtpcUJSdXIwVHVu?=
 =?utf-8?B?amw2RThkVDlPcDVKYWVEUVdpQTgwSDBpYWcvZnJRYlByK2VwQzB3VFVXTlJH?=
 =?utf-8?Q?OQ71y5j9JejKEfVCyVqZCxwWpH3x4fd/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHI1MkxDZm0rcUVST09XeGdkT0pvSlU2NURNTEFFMDExUWo5NzcyUng3NWlO?=
 =?utf-8?B?OHA2WDZ1MUMwNC9vaUZvcFJmUnVpVGJWaVRZQ1g1M3MvZ1VtVHZMeVZ4anpD?=
 =?utf-8?B?QXlIQ1poZVh1Nlh1R3dLSDY0ajhrS3EvaW9jRmgxSjduNHV4L25PMkVIdlli?=
 =?utf-8?B?Vkp4dnNwd1AyTm45TGN2dGhFanozQmlDb3N6czRqQXF5WEUxN2N3UTgrNTk0?=
 =?utf-8?B?UW1zMUVmcmx2STJPeTZVRmM4eCtJMm5PUzhtN3pHS2lZdEtPc0hWaFhOK3ZM?=
 =?utf-8?B?RitoQW5vb3ZTaExEK3ZHQjVsTTcvSkZMekZGSytuMm1iTWp6aW5jd3FXNldF?=
 =?utf-8?B?T1ZTYnZ0WGd1cGR0WWZWTnl4L1JaVEkyblc3SklQajY0OERiSFVISmdCMUVj?=
 =?utf-8?B?UjlHM1VRRDhuSDdwYXFFcEd3cTBqQWMwTm83S3VmNVVpU2dUUnJGdlF3bm1S?=
 =?utf-8?B?N0YyZ0RhNUNJS3h2YWFNbUZrK0Y4dnFJWmpUclRQL3Nrd1FObHpwV1djNEth?=
 =?utf-8?B?N2RzaVIzeVZ6SVAzWWlXUEZyOXlnRkJ2cEFwZWhIdXl0K2lJZVRVMC9xaEVk?=
 =?utf-8?B?QXYzaWtEeHJWclBjK1VLaHNEcEZiL1FPdlZvSUpkZG8wV0s5bTh2ekw0UnlI?=
 =?utf-8?B?eld6MDdlYVdqbVBGRk81eG9kNGJFeUt4d3VlS0hlQUlFZGc1WkFkM211d0Fm?=
 =?utf-8?B?cmdEU1VjTTJZWnV5U2hMUEFMSzg3RVhBRjJzMkVZZ0hyRzlkYm5qYi92QWg2?=
 =?utf-8?B?cW0wYTlkQ2FxV3BnSmw3aUhDWTZtVEV1Rmo2dTRRZGM1b0o1NUFiaWh5bDJW?=
 =?utf-8?B?WlBLSTBIeExrVUwyOGh5NHRkaGlUcFpiQ3VmWFNVNU9nVWJqbEEvQitvVkRN?=
 =?utf-8?B?UkRhbjhXbVhEYThVYWFiMzRJZjByckJZck9GS3Z2dXZiNE9kcjUrRkl5eEpJ?=
 =?utf-8?B?WTFhZlJqZWZxVmc3V3NYcFF0c1lXY3A1RlJlUkRpQ3pTSjhPNjArZUZEbUt0?=
 =?utf-8?B?R3E3S2dUTTBOYXhlamFJOWI3NjY0QXB4T3g3YTluK2dnYjVWbzc5M1g0MGU1?=
 =?utf-8?B?ZXRQcmhEUGQ2eC9qNUlwTUJEa2FrR0FleHNVV29HL3hSWXBnTXRZTEJ6bzhM?=
 =?utf-8?B?a3hKcHB0amxLeFkzbUhBdDc1RXlWTVB6TkJmOHhOaG52aG8zSTZVMURzWTQ0?=
 =?utf-8?B?b2F1RTNXVHdQNzA3V0FWVTBHMDFZK2VYSm02eHhwV05jM0lZZnA4bVFPb2ty?=
 =?utf-8?B?OFpYVlp1L0l0VThlcGkybjZWN2tuV3NIc2NEYzdxcWIxTk9GRjU4d2s2RWZP?=
 =?utf-8?B?dDNvRnMxcXEzKzQ0VURpV20ySW5GY0tOckxrSzlscHZkTDJqNW16SkUwZ2U3?=
 =?utf-8?B?ZUs4ODlTNXpnQVB2UzFJS1pZdU1aWVFKbWIxZStBc3J1a1hhT2ZGMHFkMXJv?=
 =?utf-8?B?cldYMFJpakFsUXFZZHBNalJ3YkMyRTY3M1BmbFlTM3FsbThKSXhFOGx0cGVh?=
 =?utf-8?B?d1p5aWpzekg1b3RsQUMxSXAzOWF6QjI2M1hGMlNhenZOM0N0SmxPOGtpQmhZ?=
 =?utf-8?B?ekpoWnZ6T3l5T2NsdGkzTXNHR1Badkt0REJKa2VuSDRCYzJUQjRwTVQyZlNj?=
 =?utf-8?B?ZWovakx3ZEtqQXdlcklid2l5ZjhHUG1UdUc4OU5EQ2g1VHpWNHR6MjFNdDRX?=
 =?utf-8?B?OWEzVVNxekZGYlpvWStUZnE3REk5ekVVSHB4VzkzVEhjcklYcXBiZG1TTDlS?=
 =?utf-8?B?a05wKzlNbUt2QXpPRlJpekFRTGpwUS9iem1yVGY1MGFrRmVlRTgraTNpbE9L?=
 =?utf-8?B?ZlFOei81MzFoUVRoOVhqejBvN0YvTFlwVUdkaWNlQXNUMUEvWE9OV1hjVTd1?=
 =?utf-8?B?eWZDSjEwakxvQlRSV0FMQmd5aVdtSEE5WDhuVllBVkJmOS8xZ05lNk1kTWlP?=
 =?utf-8?B?WkwzTzFqZU1tR1ZrZmR4R1ZjcS85aDVhd2JuUWlHQ1NWNXE4Z1lxY2oxV2Zt?=
 =?utf-8?B?bU9YVzdaQXJncGNRVVRJS2xteTRsR3ZDbDVIM2toejB2WGFOUS9Nb1VjMlE2?=
 =?utf-8?B?R011MDc1T1NlaEQ1OEZBalZRN3kvL0ZVKzZoU3pWcFczMzY5bEtscGpTeWVR?=
 =?utf-8?Q?NKDNG+zT9NOLnPD8qTE/QO2SB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66097ead-7da3-46fa-f284-08de1e4f6214
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 22:45:43.2528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77M5s8dpaTVl8TyoVht/sN8t5R1bXx3EffJbhYXqKdT7YVP4WjiELog0abTN87piB39OwxQbldiLKHfEMAggjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

Adds a compatible string for NVIDIAs msx4 BMC board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a80b5c9d14098b60ce277391fcdcb..5933eda3371b33f16a1129cbb84933c1393c9b2a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -104,6 +104,7 @@ properties:
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
+              - nvidia,msx4-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc

-- 
2.34.1


