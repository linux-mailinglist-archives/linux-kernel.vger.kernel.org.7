Return-Path: <linux-kernel+bounces-779043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45630B2EE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DBD3B3849
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3F296BA6;
	Thu, 21 Aug 2025 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LdIl2lW5"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011033.outbound.protection.outlook.com [52.103.68.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CF255248
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758260; cv=fail; b=aPC0bOZlqNh1svkMb3Az4Uhxigw6D3YG/6kgHVi5PlkYu7YlbSyFQbpXPAcgykw6MxGJV0Vy9SdoisOFN3IzL1e6+c2KVoIkCI3Fd/sCQqwSwx56LlmN1K970kil1amwQ6elVsZ6fwVMTC6GRkqDM7/yTg3Rx8jSjih6qj/vuA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758260; c=relaxed/simple;
	bh=xu7gibFo0UNKt5kZ5bt0mD4d578kt3dKbeJ3FHOhadw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qu7S9rgCFO1tiZVuO0SrVARpaWKXgW/DVOvQ+1QV4TJV6NF457PoPj0ZG1JDE7gvDRcuNww2G0uqDmK+4kUtGLgtX9/w0JIHVAYFIpxCOHnpz3nSqZGTqGFl80jXknzMoaBSiqzntYdR0faepbiHBQNKFWYhNXvCYQJopgjHH+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LdIl2lW5; arc=fail smtp.client-ip=52.103.68.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcAkSg1PInwkclibbrSK4nvra5sOmnjibcCvwRPxNh9+VNV2IAr6Lp8ackczcSn9ye1VqSmCRz0Hc2WeRS1/Y73xEiMpINM1bug114ea1WY4Tys3DZqxZD/btihV1azEvA+HKiLDdbc6pdySiwmRLXhGD+NUYxEEaQVK8HxqMjGAEuMG1z32+YRlLXOF1m2w3kFFu7toLaFeGpSPJ550xol95jWhzUTpbfKNao7MjBXniIe1a4NjntnT+ASyHIjm+P1nYvMXhO7s+20UYQM1Of5eO+rgeSFn9FZcw5VwPkTzzHcc1ZBWj8wGACooTgAPnXmZdvoXDrhUhX6eQTAzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLFrUjMld994qj3TKJkFRPLU8/7FcVMcW6e3REww3Xk=;
 b=oI4y2VvHcqLA7O7FTbOzE+zCez9MqXsh7E23gZiVcIlQ4X2CJLH3BGO5pA4We30o9fW7NIN+UI0ehurW+88gKXXpnMHH5IalpD3J6yO20LqXmONFANoQZ1JrUlHkeu++B3LLZyi07Wvhq35NS8r3SqDGnZRlPLhkqlYUGOtQcOfahoMIFX29zO+ZVZL3SDO0//Z38OC7sD7cEMp6GKgKwzjbTmjIZO/RFHnXwL3v+LJ7wxefoIxYODKZC3K5TPwYPNZEDbgT4Jk8jPz5r2UTUEDoXikPjZDp+mVgvndN/KbVimlNTk3dqpfMVayd5cgDWwaxmv7ffRlDUSgX7OwjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLFrUjMld994qj3TKJkFRPLU8/7FcVMcW6e3REww3Xk=;
 b=LdIl2lW5+JvE1TI5eA+xn1zjcTj0FeM82N8fGLzjaE1UQ58JQwxzk5TlZlkHwlej7NKUAKf4uOYIC8r09f6A39Rdy0VtTs2gnEAWzBURjfgvN2cqt1bvzVES+rkN8C4ki2Dm5PssCw6FtMpCfFODsCe/r5yp/frkrln3kYqjKboyOPPVbWUxMNlzm9hr2Z3lw0DiqV42VNx8jorHRf/erM1RNQeX+mo1p58sDCoD80L240jlX4NLmxArHWwfOizO3tgbCVI/rqfA3foo7rWIaDrHP9zZEt21UhCaZMybCB8VDvb2IX258761qFPm5e/D8arc8OdZLw9EwvA/Iuh2gA==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PNXPR01MB7353.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 06:37:30 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:37:30 +0000
Message-ID:
 <MAUPR01MB1107213FB5E04569DC6010DE5FE32A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 21 Aug 2025 14:37:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] irqchip/sifive-plic: Respect mask state when setting
 affinity
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
 Nam Cao <namcao@linutronix.de>
References: <20250811002633.55275-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250811002633.55275-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <85005b4c-da92-4429-a152-ce4e706719b3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PNXPR01MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: b86743f0-64e7-4309-101c-08dde07d339d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|5072599009|8060799015|19110799012|6090799003|15080799012|23021999003|461199028|3412199025|53005399003|440099028|4302099013|40105399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlFjdnpITHRBbDhUUlR1RDBEYU9vY0VXaXd3ODI4bWlSMVVrNERIdE40Njlm?=
 =?utf-8?B?U2xCTFFITUJhRjhkY1I1MVgrV0V3RWd4cjdtT1QzWndoQ1JXRmU1OUVRdFd3?=
 =?utf-8?B?MDFjbE1mWVhvUEh4S2JhSkREeFdiMkNxcVhNQWNJYUhUc0tMOGVuTXZjTXZk?=
 =?utf-8?B?ZEtxbjZ3ZC93akNCTzk3VHY4MUZGWnl4YlhyY1RTZ0lISEJMZGJtbis2UW0v?=
 =?utf-8?B?N2VKTmsrd0JBZGFlRWJCV3pSVlFjU2xTZTFpRExTQXo5NHhwWVJQME14OElI?=
 =?utf-8?B?QmFucjh6SnhTRFJ5NDZldmZSV05lcmtRS1R4NnJvOTdDVXVqeHVJOEVOYXZ5?=
 =?utf-8?B?Mk1tUEYvZDNWclUyYTlvbFpCL0c0ZW1vQU91OVZPTDV0TTlnN0VwdDk4aDh6?=
 =?utf-8?B?ZUFaUVdIcUNzVEJqUHdMUGFCSFJwTGNIN2R0dXd4T3hKWmNPUjFwWmllNWQx?=
 =?utf-8?B?a0xOMlZhMWljeXpsZkNKOFdOL1lleXJobUl3RGZMZkVGS0xuWi9qMlBxZEFU?=
 =?utf-8?B?UXJaN2Zva1ZzdGMyRUZIMlpiRnZJU1RkSUNIYXc0T0xtV2RVUzBJV1RCWEpW?=
 =?utf-8?B?UDRuWUhrYzNmUHYzUzNZN01kYjk2V3BYTVlrUGZPR20xZjR5K1ZCK0tLemxj?=
 =?utf-8?B?RDBndnBVRksxaHZhR25ockphRkgrejhUcXZzQXBHQWlNNERMU3F4dHpLWS9v?=
 =?utf-8?B?Wm82TkkyenQyMDB6YWhTdHI3ZTQrUVNDZUl6RTV0UlRoZVhuUUx1cVF3Ukk0?=
 =?utf-8?B?MUZyTlBqTkxJLytPTUdZdXc1MU5JZ1hRYmk2M2lhQmNlRUozQTF6Tlp5WHhp?=
 =?utf-8?B?YndTUmlGVHdJTmh2YXEzQXJGaDYzUXBnU0Z3MWRRR1RiUi8yR0Z5MHRrMGEy?=
 =?utf-8?B?TFhsK3VBNlZsYnlCS283YXE1SUlFNzYzS1pibGVnSVh6dU1QeUdTOGQzVDJl?=
 =?utf-8?B?dW1hVTVJNVFOemc1VXBpREZKOUxEZ05kVjIvaTF6VFhoWlI5Wis0Rk9iNDhY?=
 =?utf-8?B?bjBqRENOQlVnQjVWa1B1M3B0djJRTjhGSnZNdWZ5Q0hEOTI0d25pMlpzdU1r?=
 =?utf-8?B?cVdvZXRIc2VFclhHbms5N0krb1d5MXlyVG9OaGh6U1NkRndsMURIZ2dwU24y?=
 =?utf-8?B?R0hmZ2N4c3hQZDduL29kRldLb2VkNWJMRVFneTB5RnBYblRXYlorSjFGTWxv?=
 =?utf-8?B?NFBIRTIrUTdIcGNCM1hOdk1ReUFmNlorWW5hcFJXQ29BZS9hWHRPWmV1am0x?=
 =?utf-8?B?MEx0WGRZVnZ1ZWk2Wk5LWW1SbkdTL3lXODBsTVhvcFU0amZvcGt3UGk3Qzc2?=
 =?utf-8?B?blRPRHBQMXJvLzFHMFR1dUZKSUpxN3FMbHR6Z1U2ZUJCbG5pMDZDdnBUUm84?=
 =?utf-8?B?dkIvTEZvKzhlZ1JrVC9qOEVxbTByQWM0QlNYL3JvUjlEK2xsakk2YUxHNlpJ?=
 =?utf-8?B?RXA0aitUWndTeHpONUN1a0ZSdEpvcms3YUNFUHhSdFZhRGZFTFNzNGVodW0z?=
 =?utf-8?B?MEtQL0JVek96SG9CZXR6TXVtbm81NjhnakhYdC9UWjVuOExaQTBaTElPQjRV?=
 =?utf-8?B?Q3QyVDVxbWU3NExqWEM2K2pta2hOK0w0ZXBWei9tL3NWRGx0bVdFcklHTHRy?=
 =?utf-8?B?T3VlK2ZrNU9qNWsybmh3UTlQZzluTHF2NXhVczNiQkl6RjhDTXMxeUhzbDFj?=
 =?utf-8?B?d0V1U0RPOFFjb3JOVFh1cGk2NjJOa2VOSmJBeHVhZ3BPZjZEMEFqSml1S3Jr?=
 =?utf-8?B?SCtLQ2pVZ2pyMGh1eDRPc2lmcmJFQi9paFZwNnFYMHVjVHE0bURIOHFlNFVD?=
 =?utf-8?B?eWtFeWhBZjRacFBabkdLNUJSOFBKSnNWSFdiei8ybHdWRmJMZURkb0N4VXdv?=
 =?utf-8?Q?2DXKKHa17Z0nb?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdqYlJobWw5U3FBcUcycXBZcWFvWnkyL0VaTlVYRkVCWHI4b1lTWU9jU3NV?=
 =?utf-8?B?ME90RGl1Vkc5ME0rYXEvNk1ucGZYb0NpNC9YdWYwU0JMY01HbWo5eHRjQVM0?=
 =?utf-8?B?VngrQWdiMXhkWS9meE5XclFLSk9nWEgrMGtoQW9QV3A0c2pncHFPYkNFaXBE?=
 =?utf-8?B?UUhqMWh1T0pLVjgrV09TQkZVRU81UXhqa1lTSjR0NHBmUThMbFdROVJBdDBS?=
 =?utf-8?B?VC9KME95Vnh0OGFMUFlITHZ0eHI4WmJ2WEk0MlRvNHZHUktNR0hRN2pLeFow?=
 =?utf-8?B?SzZDWWo2SC9VUXBDYkRmWTZKd2loWTNQdlJpMWw1eGVMdnZMVzFnaVh5QldV?=
 =?utf-8?B?Q0xTc2FNeElBYm1Cd3RpR1IxRXFsb050NFRrei8wRlJCZ21USjU2MDdvTUE3?=
 =?utf-8?B?RmNYeWwxTkM0YnlQeWZsUHdzR1MzcEN5dmNlcjhmcjBjano4SUVTWlpNYzFC?=
 =?utf-8?B?YlEyMVpCcnV4bm54SlF0ZURxZVQrNTBCQi9jTWphK2xISHRjbXVuNTZYMEla?=
 =?utf-8?B?ZHVyUkNLdEJXdHBBcENHSjlVRGFybjFwc3JPbElTZEtPdERWUHVoR2M3dzVS?=
 =?utf-8?B?cnZiWmIxTFZ1ajVMazJrMUQvVDZBMytnYnh6ejhxMzRDNGpnaWlRdTBIenQz?=
 =?utf-8?B?Q3lyYjRmMExVV205RHVtU21aMHg5T2hTeXpsN1gyQ0t2WHZ5WkRQdU5BSG1k?=
 =?utf-8?B?YzhIclE2SVpBb0xla0t2TERNb21VbERxZUIvd0FVMWR0WStYNk5aczRxZHJu?=
 =?utf-8?B?UHpQbmxEemt2dmJFcDBUbytEbzk3MCsyUklINVVJb0pNTUFJaitIQnB4MnNn?=
 =?utf-8?B?WVkvVm92eHB1NnVPdW5RS2VmZGNxaWt5OWNTZkZOR0dlMWFNcXArdDBOYlI2?=
 =?utf-8?B?bWVWcTJEUzZtd1RoN29ua2Y1MXlMYUV4L1pJNTVsRXVNMjNmZ0NNVG0xckxY?=
 =?utf-8?B?akcwZW5JLzdPa1d2M01ld0xoZS9sb3Z0ZkRBVVVQNS9PWGxMTzRLZUpVdVFh?=
 =?utf-8?B?bG9lbU1weWFiTEtWZW9kS2k2Y1dyTE9oNSs4eDE0YWlReUFSZmN4bmVVTXVz?=
 =?utf-8?B?WHcwdHZlUkNmajVOZ1hwbkVUMTI0Q2svUDhBd2dKTVZlZUVZQ2NoNW9MT0h0?=
 =?utf-8?B?amJzQUZhQXErRDZSc0lWVWdsanNQTVRGN3oxeHJiTnhzUERzWkY0TlJPbW5t?=
 =?utf-8?B?V013YisydmtaK2RMYzdkMGllSllHOHRKbDQ1WFFBZzdFR0I4ZU9jRGZHMStC?=
 =?utf-8?B?MHc3ZThtYnlHWlNId3BHU1k1a2VxdU9IOW5GUXo2MFQxcWhqa21wU3RjLzFl?=
 =?utf-8?B?K2J1QTNaUDVRWm1PajNTaUUxMmgvV01mZDdDZ1I5Yy9ELzRkK3RyTDBoc1Vz?=
 =?utf-8?B?MzN6ZHZPaDIrbWlBaUNadWlZS1BMZVU3RXJ1amM2dlFvOWVwYWx6NEU0OHdI?=
 =?utf-8?B?a3NaQWNjOXc1bDVmSWlPNEJmWnZQUXkvcXB1WHlZNXdQZUIyOVlYaUVUYmZm?=
 =?utf-8?B?UzQ0K0cxQTExMmRBQ3NiMVVxeENZOG9LMDVsWmlNOFFkdW1xYll2b0VybDk3?=
 =?utf-8?B?QmJKcVIrc0NLcGZlNDI5TFcrcG10WHF5SUllTm5mZFJZUlpVTFF2Zno2bytT?=
 =?utf-8?B?dHZVZXY0Wm9vT05OOWVZV1A4dVVMdnl1ZzJvQlRhdlhRVmJIbmZ2NGJuTGdz?=
 =?utf-8?B?SW1SOFJsTXJpRko3ZVN4aHcxQlJGNFl4d29lRzdGKzF0UmdmSTZlSlNlRFV1?=
 =?utf-8?Q?af6vBrNfEZKUc7jHUjGZHgdniLJdCRKTHrqPiij?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86743f0-64e7-4309-101c-08dde07d339d
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:37:30.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7353


On 8/11/2025 8:26 AM, Inochi Amaoto wrote:
> The plic_set_affinity always call plic_irq_enable(), which clears up
> the priority setting even the irq is only masked. This make the irq
> unmasked unexpectly.
>
> Replace the plic_irq_enable/disable() with plic_irq_toggle() to
> avoid changing priority setting.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Tested-by: Nam Cao <namcao@linutronix.de> # VisionFive 2

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

It is recommended to add the following email link about the relevant 
discussion in the commit message for quich reference when there is a 
revision or merge:

https://lore.kernel.org/lkml/20250722224513.22125-1-inochiama@gmail.com/

Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox

> ---
> Change from v1:
> 1. apply Nam's tag
> 2. remove unnecessary off-topic change in plic_irq_disable()
> ---
>   drivers/irqchip/irq-sifive-plic.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bf69a4802b71..866e38612b94 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -179,12 +179,14 @@ static int plic_set_affinity(struct irq_data *d,
>   	if (cpu >= nr_cpu_ids)
>   		return -EINVAL;
>
> -	plic_irq_disable(d);
> +	/* Invalidate the original routing entry */
> +	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
>
>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>
> +	/* Setting the new routing entry if irq is enabled */
>   	if (!irqd_irq_disabled(d))
> -		plic_irq_enable(d);
> +		plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
>
>   	return IRQ_SET_MASK_OK_DONE;
>   }
> --
> 2.50.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

