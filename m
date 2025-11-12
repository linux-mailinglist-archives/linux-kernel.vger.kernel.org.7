Return-Path: <linux-kernel+bounces-896545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C418C50A32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816583B4B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8E2D9EDD;
	Wed, 12 Nov 2025 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zs4s2ffF"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A8E56A;
	Wed, 12 Nov 2025 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762926574; cv=fail; b=WAu4o8lZdapzoorVL3uowwYqry3bcfaD+ClgzZ2dFhzDP6RhLYJ6RLLEPFu6ywSfpgxW0BaVO62B+DIfa3lZOmakuIpnEwJNqKDxLY1je1kHkl8LcGH7UcpAbZDLo4eU+FJAI3CkX3XxoEBbsu2U5FbJG+y5e3l/QCIiyYfeEHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762926574; c=relaxed/simple;
	bh=BtfJXjo5eyi0Sp3kKqxNUNpLf+2ufIILujZQrAkpHUM=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:CC:Subject:From:
	 References:In-Reply-To; b=k0SQ8lTsKe+zmUG5jOnhYbGvepqtmCUCwoCiXkOPqo8f6LcTZKFhkRJlWZWbKwR9eDmCXvgb1wkFYqzYqkeSb1If0+401l4QrfGOrfOaBAdhMSFYRGv3+VYzaWuQQzmimfYwkTxyKnXWIL7llAZD87iS4u2O4t77vq91YIllBvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zs4s2ffF; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx98LVV9y10a/Kz+8gSST7CXB7z57/nwvm9ym+E2e0ufFhnSueQxS8DCb4/t2S6ifgZrZ1LCi0OhfdmCJKmOHcS+xUPBjY40H4FEP9tihqfDcVYlihVKVXZysd1gmm86CiEe1JmznqLz3SPwJhWSRX+EELJjTqfbYL6Ap+r9yMGj9ydb7UiZRGY7MW7tkhQPrQAzV1+9U8V0PK3xHyviyBfxkgxcdGE1UBMaH95QHVAZLqzTeWZ/Mjq2aO3NpczQ2NrNeZI7zNp3f4UVxf90LUCcfCLKxoRSy2ybAYORhVZpiDANM1aK+UwsqGXJZF8y5ml09O9gk4SD0gRkZ40N4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8Q398y4bqFWxBv1tTdB34IcME7Y6YxFO0srZdL2lBA=;
 b=O6KkAlQZKuFE4ZHpvrPM4MAXboMBETH43oPEp10g+RrOaOeX/UPOUM+wlfyaZpHcSUmikRJmB5nswJcumuyEYCOyZMl5M4fbJMWPDFNz6MtRQBp8IgOeVvE4e6DesTUYox5CvfQXf64eMB7R7P/8ZJ3eiON2mm/4UFHvoJrkLbVNhOHH8wfpapvRIiZuc805A/KG6i/vX8ukgtS8yGspKMnvmUb140tw0rF9zKMczailQPGQTqq6vf6wwWlAXrqzB/JHGTO7nm/IK45sHCODfOZFObr9o46RRxWjzp0CIk8vcHsKraR6o93N3FUq9V419og+9iKFYjUn4/e4/OPb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8Q398y4bqFWxBv1tTdB34IcME7Y6YxFO0srZdL2lBA=;
 b=Zs4s2ffFdFAKhw9PII/EvjeLtyC+DYNg0TMzxP2ehsvCv4Uz7MOwM/lqSxBKh8IsZoghQe0+fDzTzr/f1RYSdjMOUBibfEFvN8ZzbMRaQgbJeesqfbOKsJjqrCaTnnbOISZPpUsvDCIIVvlduq2x7pG0s9yxXsoUlJer2450bkE=
Received: from BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44) by
 DS4PPFA1C1B9420.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 05:49:28 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::ed) by BYAPR01CA0067.outlook.office365.com
 (2603:10b6:a03:94::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 05:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Wed, 12 Nov 2025 05:49:25 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:49:21 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:49:21 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 23:49:21 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC5nKNo2173818;
	Tue, 11 Nov 2025 23:49:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Nov 2025 11:19:19 +0530
Message-ID: <DE6HB50YE2YA.101VZ1IK9JUBT@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Anshul Dalal <anshuld@ti.com>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH RFC] dt-bindings: arm: keystone: add boot_* mailboxes
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251111-k3_syscon_add_boot_mailboxes-v1-1-529a27f21076@ti.com>
 <f372ea12-b8ed-4372-8657-96f09a6d4fec@kernel.org>
In-Reply-To: <f372ea12-b8ed-4372-8657-96f09a6d4fec@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS4PPFA1C1B9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a830d40-46eb-4d39-4949-08de21af3ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFlIczd5VndZZ200WEE1NjZvSlpNZE5iNENldUJPUnJvSHFydXNZUHNTQXcz?=
 =?utf-8?B?ak03NHFXMVQ1NHNDRmxzRDBPN1hiQ0R2YkpKNzQrYlJ0bXhsRzliajZJYVVV?=
 =?utf-8?B?MGNEMVJHQW4zTzJibFhNM0l4dFh4NDZQZHU3a1IxNXU3ZnhMOE5rVW5kRVZJ?=
 =?utf-8?B?dmc3TGZCYlZlVUttQ3J4M2h6ZHN2TkFURmF6YTRQZk1XeXUvT2dtR2ZzcEtG?=
 =?utf-8?B?b25ZSGVSZDNlQWhyUWJKMVhENE54WVl0Y2JNY0NUdy9qT0VFS1lmRFJadmp1?=
 =?utf-8?B?TVhYbjFaS3NIam5OdHhuOGx1VC9EMlVBV0h1Qmk5Q01CUGV6OGpxUXNKeWZv?=
 =?utf-8?B?WCt1WXlPR1FNU01vZHhtZ3MvNGpZbzY5UzZ6Q3BOTVdndkNUWDNNdFRmUUsw?=
 =?utf-8?B?NG1kenRMRVM4NUFreEhpR1p5dUtSMEh5QWNjaTQxVk5SME43aTYzcWhXeUl0?=
 =?utf-8?B?QkdMcEQ5bWdyeFVlT3ZnbGJlRWlhOUh0T1oxUTA5VkNDOE1UczRWMU1KenBt?=
 =?utf-8?B?QldwTytlZ3VZQ3JWZm9ocWx6R1hDbjh6WHczOWxtT0tjTjJmQVdYSXQ2S05M?=
 =?utf-8?B?NGRrMW05T1l0VGkxd2VIWXhaMUZRNk5OM2dvazBFTDM0SmtUV2JYL1piSmU5?=
 =?utf-8?B?NG9USVpZaGlVOEFwbXgwYU5xV29WRkUzcW9RZjN1UWF6T25ENXFWSDcvOEtt?=
 =?utf-8?B?VjZsUGs4dWE3UG1rY2dEcWV6b05KeWx2RzBRb3RVMS9jcko2czljU3JZQmFS?=
 =?utf-8?B?VnU2L1E5NVhONFowMG9TZStROUV6VHRseFJkNFhSMXpVckRrOWUrZXptSUV1?=
 =?utf-8?B?bHNRNjFabE5ZNnllcHphSmVabmxFaXd4a0o2Q0Y0RDM5azl1Vy9pSnE0UDlZ?=
 =?utf-8?B?bFNYK1RvQWhLOWEzM0pxb1NSZjRmUkpkbENKNVNOME1lVUxoWjQwRVIrTzhn?=
 =?utf-8?B?OXBmS3lwTHUycDlVY1U4OGF4bFlydzFNTnBkSW0yMUVaSzd1TFl4ZldENEl5?=
 =?utf-8?B?dXVxSkRQYWFzQlAvaEJHWTgwSXY4eUQ4SnZ4REswVWpKcEdDMjRWdUUyMHA1?=
 =?utf-8?B?Q1RCbU1zL3AxckRXVVliMkF6RG9vTU9MZ3lULzZhZFd1SWhvSCtpTHhCQTBu?=
 =?utf-8?B?dXdnS1RXZjd3MUNrT2poN1huc3ZYdXNsVWprR2pUZ1VYZDZuWmN4eHZjRXEz?=
 =?utf-8?B?V1NPV2h0NFlPR3h4NWRMVy90bVdlRzNUOFVhR0dldHM1Vk1jRXhZQStTUEZ5?=
 =?utf-8?B?OEV3dEhiMmErZy9JZmN6ZzVJblRHa0lsMUUvV0VpUkZQRWxPU2xRQWlvaDRB?=
 =?utf-8?B?RFBySk9jdmxDV04vM3RtMlRDaS83RjhKQmR4dDlJUkxXTkhQMWhkc2oyT3RV?=
 =?utf-8?B?NG1nTEdtQ2IxVkN3ZGZ6ZzdEL0x2cEdyNG50MnFwb1k3NnRLMkE0d0NXNVp0?=
 =?utf-8?B?WGVBYzVpQXBBeXA2bUpYMTVLT2VZQlZ0RlJjMEF4VDJ4Y21scE9BdGVhb3Yx?=
 =?utf-8?B?bm1qYmNaTEkyVHVUY2oydXB5dFZIVTRhdWFjWStzbGZLbndBR3pNVXJFU1hi?=
 =?utf-8?B?VUs2TDhPT2dHWFBqRDN4R1N4YXdHdkpHWXFjSXFlSHlsL3hDOVkvTHppS0hm?=
 =?utf-8?B?ZTNIR0NDcDREcnVhcExvenQwMmJ4SjNKK1RkaG92YVVxcUU5YWRRRXAwZWNa?=
 =?utf-8?B?NWZMQ3hOM1FoV2VrUytFcTJTdklLeVQwZnpLTmNBVUV3R0VCdFMwN3R5NnJu?=
 =?utf-8?B?TXlzbzZZOVFXU1NEdko3YkwvREp1dEJrbmRwcWJJRWFONmFqWXcraWgySjFU?=
 =?utf-8?B?UXNOTXZCaXdzYUhXRTY4NnN5Z0V0ZkpwelU0bHYrcHVIaWdVOElKRDhUZGZw?=
 =?utf-8?B?cHhSQlhHUDNJUDlzYXYrVUNUQmtKVGdiR1F4VktJY1VxTGNIRkJoY0FjVlpE?=
 =?utf-8?B?Y1NhYmE0OCtNLzhTUjNIQ0ZYL3ZVUlFWcUJySGVQRW5vMGtOK241ZnpBcm04?=
 =?utf-8?B?eVhTTlk4a3BtWjhiUlNCRWo0VnhqbkYzTm1lcW8yKzUzL2VHVUI1UktxTXIx?=
 =?utf-8?B?UXo1MFZtcG9xZ1RrRGt3VmdyZVNiMm5ZMHpEKy9LMThuZUhBTHJ3RmFQelc0?=
 =?utf-8?Q?L2Jc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:49:25.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a830d40-46eb-4d39-4949-08de21af3ceb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA1C1B9420

On Tue Nov 11, 2025 at 4:22 PM IST, Krzysztof Kozlowski wrote:
> On 11/11/2025 11:37, Anshul Dalal wrote:
>> The bootloader on K3 devices makes use of mailboxes as per the ROM spec
>> which might be different than one's available to the kernel (firmware
>> spec).
>
> Why is this RFC? You don't expect review?
>

Oh my bad, I forgot to reset the b4 prefix. This patch isn't meant to be
an RFC.

I will incorporate rest of your feedback as well and post a v2.

Thanks for the review!
Anshul

>>=20
>> Therefore, this patch adds the missing mailbox entries to the DT binding
>> to represent the mailboxes exposed by the hardware during boot for the
>> purpose of loading the firmware.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 10 +++++++=
++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml =
b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> index 25a2b42105e541cb3c8ad12a0dfec1af038fa907..b5f48647a0f09bb930f052ea=
0f84a78525c925eb 100644
>> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> @@ -51,15 +51,23 @@ properties:
>>      minItems: 1
>> =20
>>    mbox-names:
>> +    minItems: 2
>> +    maxItems: 6
>>      description: |
>>        Specifies the mailboxes used to communicate with TI-SCI Controlle=
r
>> -      made available from TI-SCI controller.
>> +      made available from TI-SCI controller. All boot_* mailboxes are u=
sed by
>> +      the first stage bootloader to load firmware for the device.
>
> Description does not go to mbox-names, but to mboxes.
>
>>      items:
>>        - const: rx
>>        - const: tx
>> +      - const: notify
>> +      - const: boot_rx
>> +      - const: boot_tx
>> +      - const: boot_notify
>> =20
>>    mboxes:
>>      minItems: 2
>> +    maxItems: 6
>
> You need to list the items instead.
>
>> =20
>>    ti,host-id:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>
> You should update the example so it will be complete.
>
> Best regards,
> Krzysztof


