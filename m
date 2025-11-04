Return-Path: <linux-kernel+bounces-885102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A9C3200B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B57E74EA7EE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A532C93A;
	Tue,  4 Nov 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="evMpRdtZ"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020125.outbound.protection.outlook.com [52.101.85.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD271A8F6D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272985; cv=fail; b=tQWWUVJWoqYPZWJiv4gKvYr6q7WnNGMcUvE2WVc9LYs/ezkhHdpO+0th8KqoFpPdBeQji4QnoPwzN7PbMK0VjrSzWHxYCxXmgQUvguMlvLPELiTLo+yMv+jOPPzDNhpRJBDA7MLeLH3KVCWY3Abp+KLz64G7zXpYZy6ShVrBuCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272985; c=relaxed/simple;
	bh=dtc3a2AfEX0ElN29moxxlge2ZOTI+82/lxA1l/UmkgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eJakIQLLC3j2m0Y6Vpr/2n8TUSCXfFBiKXpzGRYHf9ow0EkraHxQhg4LNSFEDN50VAz7kVyA2n0oDb9WMKAR513sT1T60z3FiNuIUqc7JdHGlLFQMpd24P4twi2VRNW3tqMjwCkkH5GW5WXkh4SiBwgLKToURhsY48INbtgLxk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=evMpRdtZ; arc=fail smtp.client-ip=52.101.85.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ggnw7VELM8ffFCA9G/uY5boGG23wsVwcOtak1LWwzA4BUmyeWil7SKHuqug7RevIayRd63iiU5oGbV33usxtJjymD527KgwO7KtHWLzUObt9uBCBSG4eDA9Zk080Di9yVMaq7A9E8eMvbSF7skOQ3GZ0SsZqVEuxETrQM6Ujpne+NBt5j6cvthV444/247mELpAra4ssm8gafDzxh4hK57ffOuV5pPFoqCiUgQwNxwKnXwitrSQvNKf3VtScNP3CR7kEQh2170OLnC8S/zStGFACbSxIgtOCEnld92aV5/hUrcO7n2hpO4iDkyh6mx0DEo01tqdH9MrptjTI0caXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIyUX6RMpCkACU7RwK94Xr91WpCdO/XviTe1NPqGoUU=;
 b=I696vNOGkCgAZRC1HpBQ5MibNXU2d1J5WZBGHM89Llm87vEf3O/XXF2kMQ+ueTH+gN2vsr7+w1MxMRZpyAQ4BygW/TWmx332dXxm8gKjVz7VpP4qy2ygbkJconXIoULs9e4avq+Tf1oYeXCY7SuuXwErPqIgeJp0HRnCsi7UlV7wt1MqZ4wzscaBlqaDMJwZAzPG+H65wQTZQ1xd2960358VIl/63ksE1om06Wy4PuiZUsXGgt5tQrifvKb2U2vuUV2LKRpI3rFya9aQT4T5yBPK06KeppbGIB0ER+icJdECUv3DL/7xG49pq0lxOWODe5a2ZoE2GQAteyUAs5jpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIyUX6RMpCkACU7RwK94Xr91WpCdO/XviTe1NPqGoUU=;
 b=evMpRdtZs82K/DVGt7oNlvEvkIGGemSya10yRfPQftcPr1VGItMmbL5BpyXjBO8zuLVgC/eSH0bBCGpiVittvIEOToXWwstJeCNsr2BubPLhnZ4W5Us/qvl6L1/EniLxaNVmETXJ7pP3WKwvK1ERUm3TZ3d6x/gSxWWNWTBW7dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV0PR01MB994221.prod.exchangelabs.com (2603:10b6:408:32d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Tue, 4 Nov 2025 16:16:21 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 16:16:21 +0000
Message-ID: <453c5296-fe6a-473f-8169-3cf2d3802691@os.amperecomputing.com>
Date: Tue, 4 Nov 2025 08:16:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: kprobes: check the return value of
 set_memory_rox()
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org,
 ryan.roberts@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251103194505.4077265-1-yang@os.amperecomputing.com>
 <053b2bfd-df5e-41fe-854c-f0eb96564dcb@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <053b2bfd-df5e-41fe-854c-f0eb96564dcb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:930:cf::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV0PR01MB994221:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1f1acf-2397-41b2-22a3-08de1bbd7e3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU5yZjlwMDFpemJtL25sYm9RMG1IejNsRUNKNjIzRE8rSE5aNmFZbEpzeVE2?=
 =?utf-8?B?bzJ3czhpWlRNVEhOMFFNZVR1cVlrbWlLVlJCc3Q0TTZCWnNXUzR5eVNUbGk4?=
 =?utf-8?B?d0ZUSTdJbWFEdHF6ZndxWlJUSUpMQ3g4YmdkTWxDdUdVdFY1UGwxdk5xSWQv?=
 =?utf-8?B?dHNrYzNuY05HanhxellWV2RhMGNENUhTZTU3T1VpcTZoQnRLejJHV3h2d3VR?=
 =?utf-8?B?Mys1a3BseWZybmNMZUY1ZGMrTXhaaDFUWEZUYlBaUmlDT2pLdEtkWWZEeDVD?=
 =?utf-8?B?TGtsZTM4RkVxN0kwekJkR2hIV3NIck5GenQyVlZRd0FsUzFkUlJubExUbVoz?=
 =?utf-8?B?dU13c09tWGxaeWU1WlFzSjQreFJpZ1E3cFpnaWtxOTFVZ1dtWWNxVVRyL0N2?=
 =?utf-8?B?QldlZS9JekFPWmNPYWJORGZUeWpjbmtvQ0dKWHQ5Sk1LdlVSQkJwNzd3Y1ZP?=
 =?utf-8?B?V0lpVkNHNWNNU2lyeXk0Zm4yN3BkRHNLMzAxc29uUnJuaXJLZG8vc2NXVUVX?=
 =?utf-8?B?SU1QRUFlbmVFM2pHT3cyUnlWN3QxejJuZFVsYUhVRGRXK1ZUUFl6ZnBHbzVz?=
 =?utf-8?B?ck96Wi9naWxGWW5QZUU0Uk9NUFRtWloySzRKc0F5MmtXb2RIekN0akxCWW9C?=
 =?utf-8?B?Nk40ZzlWdVFBV0M4SXFDM3FpSnpOOGN5Y3BNN3JNWnNhNmVqMjJNeUVGVFFW?=
 =?utf-8?B?dkdZd1VyaGdRQ3M0OXRId2E3SUM0VG5FY01rdzhSYUtWNEhFendWR3ByMHM3?=
 =?utf-8?B?UVN4Mm5adlJ5L1ZFcG4remNFd1BOai9Bc0d6RmxKU3JQbG9IeTFLV2Q0T2ZQ?=
 =?utf-8?B?K2hMWHhzL2RFWHpIYis0OHk4MDNBclcyOU9nS3g2YTBPUmZ6UTl5SFRZVit4?=
 =?utf-8?B?RE9vamZHTHdNT3dmd0FFWFBIYjZ4U1pDdllBMWMrVHpUeEg2U0FtakR3a0RY?=
 =?utf-8?B?ckpxU0xlVVErTEhBMSs2RWlzQlBzWkN0cUhwNzk0MmtNL2ZqUU5DUjU3TEsw?=
 =?utf-8?B?RnNyVW12c09vTGRRK2NHMTBXSlljc3Z2SlFjVzRULzNXWm01eTR3Ym9KeVFy?=
 =?utf-8?B?aXRudXNLR3JqSkhBdTlrcHZHNkV0YmlvakFMbFEzUG85MWFobmRYSnYvV0c4?=
 =?utf-8?B?TjVXZzcvbU5wOTJxRytxdkoxV2trN2c4U1hZZi8zRUhvK2p0Ui9zOTA5Znhy?=
 =?utf-8?B?MnhrNFlTaFB5UTJ0SlpUVFh0emhGMzBpRXFQSHlOdjFDVFZ1Wm13OG1nSzhF?=
 =?utf-8?B?cDB2K3A1M3JYbGFNSGZoKzVpOHBRTnM5NEFySm8xNWhQdmxzUmJvMHQ1Snh3?=
 =?utf-8?B?bnJVVG40eTFuNzhOZGtMb29JRitLM2dsL1dEM0p0L0Q2VGlkLzJkNno4cVds?=
 =?utf-8?B?eVZHcjRMU24wZVVPanprYndyQVJUUVA2N3BFNms1WnZwUEdaN3pnc0NBS1BE?=
 =?utf-8?B?MzRaU2p4bjljU1U1TXpwWlE1dUw5RW1oeTlpWURKMUhzMDVVNmtCTHZIK0tz?=
 =?utf-8?B?TWFtS1NPNUI2M2VlS0lmejlSNERHUmRnWHdXS2tFdnQvNThsazM2dk40Mm1l?=
 =?utf-8?B?RmhKYVRlbnQwMy84eXpxakhoQTJqN2Z3L1lpRm9vY0JYKy9CNHRtR3dZZDVr?=
 =?utf-8?B?cXQ1QTdhZTV6RXhTOXkwNHpPOWxpWmc4YU9EQi9tbjd1cktkUlUvRUdodFRM?=
 =?utf-8?B?QXMvdVkxZ3d1R3NzeHo3WXhUbDdHS0gwMTEvNmFZMitlWFByRDNiRElWcWdQ?=
 =?utf-8?B?bDN1eHUvTTV3OU5UQ1NTZnpzQTh4NU9mN3E0MndONExOcDZuSjhLWHIreHk2?=
 =?utf-8?B?NVRmZGpYMnhORnNneEVpUURYTlROR1R4MFVqU1JCN3FqMG5hc1pvcFl3L2w1?=
 =?utf-8?B?TXQrenFvblpicEhwWXFCczRiTHpEU2liOVZnQ3ZEN2dSNGNWV0NGK0hjYjhy?=
 =?utf-8?Q?VMDwOWaApICWPZkDT8SIWRJtR4ladWF0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVBqT0JCSmpXN1dEQUplLzRDODJJWFlOamtVTitEa2ZhOGVjZXdtYk9VMGJV?=
 =?utf-8?B?L3hSNmpiN3NJaWRyeDQrZEN6cGhSVUxxYlR5WUhxNGliQ05XeTlaL3FTSUVk?=
 =?utf-8?B?ZGVmb2Q5dG02dGNlTWVWUktITFpucWcyNUt2bTMwSWE4VGt3dUJkM1ZqNGgx?=
 =?utf-8?B?NG1NdzlnNlpZMkxVd0wwdXY5dmU3dUxMZHRXdk9GR29MQnVYUjVTVUhybG0z?=
 =?utf-8?B?bElYbWFoYnpvdHp6TGtnU3BDb3B6MXc2WTBERGVDeHl5MDdxRFU0U0F6TW1X?=
 =?utf-8?B?K3BYejAwZ2VvUE1Bcnk1di9oZkFSZnhLUkptWS9WNzNlZFpvcEx3YXhZaUNw?=
 =?utf-8?B?WEN3eXdUZ3YwL3NpY1ZxY3RwS1VMelEwd0o4RVBzSS9ndW8yS2ZPS2tVZkox?=
 =?utf-8?B?YnpaTDkrS0cwV0xxRzVRaVgwVklRUTRZOXMyenZza0NTUlhqV3pWakVjU01x?=
 =?utf-8?B?d216bmovNFFuL0VwTkJIdDFtZG4wMTRSQzlUdlRpeVh4dzg3ZDVnMGNSeElR?=
 =?utf-8?B?dzFUb1ZoNW4rQWJVbkpVcWN5amdHSjFWNmlyZG9iS1RHL2pzNG5EQTBZNU15?=
 =?utf-8?B?ci94cm5rVElYYXhYWXdjT29jMmljYlppZWRLRXZmdEp4R2NaSXlJRnNOYVFD?=
 =?utf-8?B?OG5HQm9aUDJ5bzNzeWVnWktudGlrOFZJRnBqYXBxYS9QMklkZXRwS3VOeGJW?=
 =?utf-8?B?Wk1vcVkzNXQxbDkyU2pHU0R2WER1RWhPWXNKM2NXU0phVEdwOVYrZVBtYzEr?=
 =?utf-8?B?a01YYUk4RjBUQllJbTBjdGdmMlNNOU83MVJSWmxKbmV5OWFxYWNyQzkzZlJN?=
 =?utf-8?B?RFYwRm40aldGWXROeFZjdUFWdXFOcG1yS0hwSVM0akxIdFpJVml5akN1VGVw?=
 =?utf-8?B?RC9FR1RWb3h2dkpkR0JVZlNpb2ZYYy9XNXM0SmRQWHpya21vTElyRXdVWElZ?=
 =?utf-8?B?eFllQ1RmVzBRN1dTUld3SE1QTk1MZDNrTGc1THpjbUx6STQ1b0JMYnc5c3lF?=
 =?utf-8?B?c3lOOEliUEJ5OTdkeEZoaFZxNm5pM3d4RFFnazM5c1J5WHRaWnd5cHRkOEd6?=
 =?utf-8?B?RHh2UC9OREVOcDM0R3N0WVg3NWlJNGJJYVBrZFZHVDJxUE11Z2ZPTDdQRkNT?=
 =?utf-8?B?VFV5c2RRUXZ3YnIrUm0rQ280OTQwdUVkM29FQ1o0M01pZ0d0RkN1dllGSktE?=
 =?utf-8?B?U1BUWlIzRHVTdnFPWHpVM0kyTk9CcEJKOU1kWU5kZXdtdHh0L3FhSVgzbTdF?=
 =?utf-8?B?bEZmaUZ6a243UVErcXZQZEdRZld4N3Z5M2FJd1hnNENLOTVDYi9XbXF6Ym1D?=
 =?utf-8?B?MTdJYkZGNmV2aWVpK1dPeG9tanJPRHlHbWZ6NU96VkpDVG5mZmpzZWFlUXdY?=
 =?utf-8?B?NHZTR2RWOTNGaEUvdHQySDlwRHpjT2FzR2s1b0FacHBNdHdLcUZjSlBOVmJ1?=
 =?utf-8?B?V2NsRTgxdlNKY2tOWHZiZHo1VlBxTmFDemN4YnVSTldxVDcwREgxbHd3ZDl3?=
 =?utf-8?B?WTA2cGFSemhieUZWT1IvbW9pbGJobUo0OVR0eWN0MGhyWVZTNEF0N3A4bFhY?=
 =?utf-8?B?OHhabFBnNzI2WGxPTlh4cnVkY21mUkEzQUU1OHU4VHlPNDdhZFZncitnL0ZK?=
 =?utf-8?B?RHJZQ0U3S0l2eEh6RGpEMm5hNVNKbEhOSFJnM01LRkZDNmJWWEZEUjVJUzdX?=
 =?utf-8?B?YSsvRENUZURuVFNuOWFvajdsOHpwbUVMRW16ZnEzL1FyeWRrU2VLT1hpN0xX?=
 =?utf-8?B?U0xXS04vZkxuMUNLdk5BNUlsVHIwNTBnQ3JtenBVTmVWWDFkOGhxWld4MXBQ?=
 =?utf-8?B?OGcybGs5NjVQdlVXd0pXRHNjdGdKTlN4V240SWR1SDgwVUNYR3RUMHVGRXRL?=
 =?utf-8?B?RWUwc2hmU295TWJRT2VmRmdNRng1cmNkSUxMN3FuQzJxSHVUQUxpNnpzWk9z?=
 =?utf-8?B?Mm56QzRVQXl3U01WZ3dLYW8zZ2s2VGo5SHl6RGhFUlRxUVM3Vjl5b2tUTkdt?=
 =?utf-8?B?aldpQWtDRXpyRmhVVjlvMHpYZ21Ldmh3Z0FBOGlVRXpxWGRhZTY5a1A5RjIv?=
 =?utf-8?B?YkhZc3o5aExJa1VFelE3QmVLMXdnK1l2TGIzVzBsa29RZEZBUC9mMGIxa1RQ?=
 =?utf-8?B?TGhUZmR6dVNqOXEwWWlYb3BCaDVDektwUUh5cVM2RDNMNjBlbERVRXE5dG9z?=
 =?utf-8?Q?w71LcI36PatpaszgZ7Yjhus=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1f1acf-2397-41b2-22a3-08de1bbd7e3a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:16:21.4950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5s16nSHrngl3ZZpQGDXIJTvAsJjqvpv/gJz4u6P7WIDxbOFjy0T5EsY39W6KiBb6UC9gCVcNHFRoThY0PA8BifaOPJ87ZRV0WGFCUsdKA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR01MB994221



On 11/4/25 6:02 AM, Dev Jain wrote:
>
> On 04/11/25 1:15 am, Yang Shi wrote:
>> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
>> rodata=full"), __change_memory_common has more chance to fail due to
>> memory allocation fialure when splitting page table. So check the return
>> value of set_memory_rox(), then bail out if it fails otherwise we may 
>> have
>> RW memory mapping for kprobes insn page.
>>
>> Fixes: 195a1b7d8388 ("arm64: kprobes: call set_memory_rox() for 
>> kprobe page")
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>> I actually epxected 195a1b7d8388 ("arm64: kprobes: call set_memory_rox()
>> for kprobe page") can be merged in 6.17-rcX, so I just restored it to
>> before commit 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in
>> alloc_insn_page"), however it turned out to be merged in 6.18-rc1 and it
>> is after commit a166563e7ec3 ("arm64: mm: support large block mapping 
>> when
>> rodata=full"). So I made the fix tag point to it.
>> And I don't think we need to backport this patch to pre-6.18.
>>
>>   arch/arm64/kernel/probes/kprobes.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c 
>> b/arch/arm64/kernel/probes/kprobes.c
>> index 8ab6104a4883..43a0361a8bf0 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -49,7 +49,10 @@ void *alloc_insn_page(void)
>>       addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>>       if (!addr)
>>           return NULL;
>> -    set_memory_rox((unsigned long)addr, 1);
>> +    if (set_memory_rox((unsigned long)addr, 1)) {
>> +        execmem_free(addr);
>> +        return NULL;
>> +    }
>>       return addr;
>>   }
>
> Looks obviously correct:
>
> Reviewed-by: Dev Jain <dev.jain@arm.com>

Thank you.

>
> Although I got confused by why set_memory_rox() is being called; it is 
> being used
> only to handle the linear map alias perm change, which is not nice :) 
> but I don't
> see an obvious way to refactor the code to only perform the needed 
> functionality here,
> and probably this is not a hot path that we care about.

Catalin actually raised the similar suggestion before. He suggested 
extract the linear mapping update code into a helper then just call it 
here if I remember correctly. However I have not gotten time to look it 
deeper yet. Anyway we agree it is not a critical path. It may be not 
worth all the effort.

Thanks,
Yang


>


