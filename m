Return-Path: <linux-kernel+bounces-883366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97BC2D3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48BA425A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4229319879;
	Mon,  3 Nov 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aZUqIWOR"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1F2737F2;
	Mon,  3 Nov 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187732; cv=fail; b=Z8VanTghnTz1gaSx0w5/cfk+AalspuXlX5dScDOkL11OQS6cSQsj1pQ99dsiq6JKt6NqyZ7BziX0ZIXQ1hFqOcyqU+e6ysfGjNPKvKpBjh3LIWdMN0W3AufJZEnVW6t0HV1GjUHUcEMXZGXlT2cfvbh3r4njARcGpi3Z6mK1J4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187732; c=relaxed/simple;
	bh=qKEz7vMAnVCWxXpjT2AlImtgBgsCRJlcG8s274CSXRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n+czR5kEoR/zFE9REgq2RRolOIBP/XW1QwiddD6TvMG18ChjbcUfcrKryeiPJandwPQMn0sWET09z9j6aLlDJxqhH+D8SLycaNiVsxJv2JwhnK2xWE9GgRKs8JWU2BAEdomztc7o6PhoCQLPgtF5kYEdmLIOHICJQDJ4L8OsNG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aZUqIWOR; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onjDtkvJ9yYmSzkP3Mv0g0OMjns12gpHJXhAtM4/NSmZwY7N5Eh+im9ylvXVD9l4uljgDvS6NiDLeMBAmeJydNJ33/iUyIFNuWSuBYZGamQLQHSKahly25bLR8Vx94oM3tfL9iFFUREZKNqbGk93+QwTaY59zvgsVwSI+QvaNKd+PJGmcKOmxvBX4wp7gvqmQ3IojVAWpq5plg03H4rQFrSZj29C2dSCEHl2Y3FPLVbcJSAglkc38HaWt056IfO/ZHO7FxKkv8sxzM8LbRVUI3iv8/bVyfwAmQaKoe3tX+kVBReAXQRgfKlthJSgup1T3AF3ddqqSMmBwdQqinLZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKEz7vMAnVCWxXpjT2AlImtgBgsCRJlcG8s274CSXRQ=;
 b=Fc63OTJ2qjfQ+WGLfzqi6F+lU1Tl69hk82GiFLdj4ZtriBcVHyuBXxfwLbztJXkg2kQhxXFLIuPVic8JxuWIoV8jeDPJadmdSm74iLN5c8uqtLUyJZnY0SYLX4BIWAzkIAgBPV5PEZVnt4YWa95B5GVawuS2uIpcCI+CJgI0jthjngwRlE7iXBIyXx8r8sW++aS9mxv436QVgCvx834yqkW3eC3s0RuW3xAlHG7w93jqzCbwc27ZWtniTcH67o009gSDhfaeUqiGwxYp4LerbnxXLWRUl6ct+whVuIk/4XnV6heT4yXMSL9Gw2ZADA98cvMvB6diRLsd8urmWYfmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKEz7vMAnVCWxXpjT2AlImtgBgsCRJlcG8s274CSXRQ=;
 b=aZUqIWORyvl3EA1JuWJQBwAnCA47p4C0Csc3AE8aCULD/WtIxdZxdRyhSrQJBm3oxnCNqPsqm5wdzuiK8hzXa/dfsvp9q3v5JiP1ksC6bNNsQKi8IlEvkp2HLi6LMAmyIIsGPxICAswaOFFAJWtfNA1jonLGwideNFcxrFitrWl6UNsKNNy+PAj+kneJeTfvA2IicakFoPGYgs/U9hnaKyKIDmlWHKZCxggWkBueSG+OFhdsfEP4RzNLYlgdkZ6bp/+3OTCifqq7o+8d8YCA3Qq8rZjcoTUQbD6gBHiPWe85oaNgGlV7PQuq3v/AOY0VlQNSuX6weM+8iBXMSP7JZw==
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by SJ2PR11MB7714.namprd11.prod.outlook.com (2603:10b6:a03:4fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 16:35:28 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae%2]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 16:35:28 +0000
From: <Marius.Cristea@microchip.com>
To: <conor@kernel.org>
CC: <corbet@lwn.net>, <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <krzk+dt@kernel.org>,
	<linux-doc@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: temperature: add support for
 EMC1812
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: temperature: add support for
 EMC1812
Thread-Index: AQHcSOvuSU54UCbZykSapGgq8cbqPLTZcQKAgAe83QA=
Date: Mon, 3 Nov 2025 16:35:27 +0000
Message-ID: <c844428aa8d57d870b8cb55ce37d6359e3142585.camel@microchip.com>
References: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
	 <20251029-hw_mon-emc1812-v1-1-be4fd8af016a@microchip.com>
	 <20251029-blaspheme-stinking-91b73a8ab778@spud>
In-Reply-To: <20251029-blaspheme-stinking-91b73a8ab778@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6005:EE_|SJ2PR11MB7714:EE_
x-ms-office365-filtering-correlation-id: cef77a10-f834-49fa-4ea1-08de1af6ff39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?amcvSFM4R3dGR2JkYjZWTzlzSFF4eU5WSlpIWUxDMU4wa3VuVlpHSkFESkZn?=
 =?utf-8?B?NUtkYTVLWHFjdGtjd0hlWFkxdGY1aXg0T2FUcHdyWGhnbFRnamRubEdlQ3Y2?=
 =?utf-8?B?anhxM0MzV2R1SVE0UnBQeDZaajVyT1E1eDk3d2pnSFBqOVZoQW9DdHVFTUt6?=
 =?utf-8?B?MmlnWWI1bkpDSkFKV0ZKNTFYODRCUGFmYnV6a0I5NHM3TnlDN3N0c08zVDlH?=
 =?utf-8?B?N0tYSDJRWVJCVkdON0pnNXljd2pqUHBTcjA4K3dJd3A1RmkzQms1SCtLRzlG?=
 =?utf-8?B?OXlFcUJicVZ3cVl2bXV6NStRWHB2RzRES3JYMVFlMGZRaXR2VkMzM0dhVVIr?=
 =?utf-8?B?Tm13VHJKM2J6TXVzaVVmdDRJc1FvOWY2MTN2WlRsaGthQlJVczJjS1FLV3BJ?=
 =?utf-8?B?K3ZJRVluNXhSTVVNRG5lZng3ZlJKd3h5cUc3K252bzRjSmsrM3pzZmNKcWs3?=
 =?utf-8?B?WitXZGc1SUJUVVZtUmxRaUZqRlVBK0tXV2dGZ0Y4RXVBeWtzSS8rSDMyWG5Y?=
 =?utf-8?B?Y1dtaDlQZklRNDBkUFNib2c4RFBNQ2FIRnNWK1pFMHRPUWV4aGR4R2FYeldR?=
 =?utf-8?B?TCtUejFSM0IyYVBjL3dvSytqRlYrMmlkM3VIZ0RUUnlQdFI2Tmdka2dsY2Uy?=
 =?utf-8?B?ZWgvVGU3YTY1Y2pheGlWcW84L3JTUWJZaE1xN0Z2dUk3Tkk1NUt4enRaRVA5?=
 =?utf-8?B?UzFEV05HZ3lJbUZhVk4ySUFsVG9wSzhLMnc4bEQ2aWhyZmMreHRKUSt0UUI4?=
 =?utf-8?B?UzhQRFRTYlkwQ1pXUHdKSW1WbjV2NXlBSDhUS1VVZWRkVEVrMEZxa0FUbmFy?=
 =?utf-8?B?RFduWUlld2NHUStTSFcyRGJwaUpMRHg5VXVEeEU5QnQ1M2pCcWp2Y1BSR05M?=
 =?utf-8?B?dlJSNjVaVG1SUWRXeG5GMHprbDNZanNWOWZUbFpkam5WL0JTck14a2N4TlBW?=
 =?utf-8?B?cHRWTlowbDZxUjVPaXRva2w2WE1WbjVyMlMrczEwd09xWDJ2NjdEcG9EdWxP?=
 =?utf-8?B?UWoxK2xvQVpVelRzTnpEc3RXQWpaWTlMaU5RL3kwaHRmOUw0WVRWYjhYQUpC?=
 =?utf-8?B?N3REUndiL0V0OVR6TlFjTlRtMkljQUpSRS91cGl1djJsdSs5Z1FPbGNWRzRO?=
 =?utf-8?B?MjMxL1o1bVJQNi9MSTNic1J1Q0NtbUtGUWNiZ1VnaWszOHZ2M2M4ZExDNTli?=
 =?utf-8?B?azZBeG1KNlRVWHppWjJUcXZIS1IrZ1oyUHhMRlpncUNQZUtwZ296T0pQdHo3?=
 =?utf-8?B?VHlXeWFsWnhLTVIycGYwRE9PNmNickd5TkJLUzNHZ210SUJDcFJ3TnBVMVov?=
 =?utf-8?B?ZXBPY1FCbzcxNE1CZkwxdytvZzZCalFNYlBpK3hxZmFtYlowM0xnUllobWUy?=
 =?utf-8?B?alRJa1JwVVZTaTBsTHB2MlgwZlZYbkVHbmMvNWVCQ3k1Qkg5eTB0cXhVNE9k?=
 =?utf-8?B?WmhkTSt2Z3BFTW5aaGVROG1rTXB5QmV4a2tYR2JEdDNqempxeW02dXF5dXAz?=
 =?utf-8?B?andvVUhTb3RUQ3k3ZDFvVVhvTWxwWTlTRU90bnY5bXNoMVdkMm1wUkxtM2RQ?=
 =?utf-8?B?OGFqSzk5UDVETEIyL3o5WnZCTEt4dmUwR1FtZWcveHVGL0U2b1RHWUdYRkNH?=
 =?utf-8?B?M0k3V0Q2UUpNSzc0MFd1Y1BxS3Rsd2NmWXg2Z2NHSytkZVJ6M1ozeEc0aEFN?=
 =?utf-8?B?dk8wWUE4ZGZYTHo0c0lLamRLQVdoelBacktoMFRXZ1hhM1kyL3U5WEtKaWh4?=
 =?utf-8?B?UVpjNk45UVM4ZUl3Z2h4SG80RVdWRkpicUZ3eFc2TUEvWXVscUV6Y2hzcHJG?=
 =?utf-8?B?dkhkYXAzS0RYY0Evek1rRVJQYXp0SitYQnNGWHRBOTZ2ckRzbHVXN1RBOXFu?=
 =?utf-8?B?LzUyclh1SFhrK0trVjY3Rm5TWGpCOWRDOFlETEF1L2d1UXNvcERlUWdTNzJO?=
 =?utf-8?B?ZUR3WHY0dTFLTmkxTEEvRFZTbnhYN3FIRDVkNUE0MmduVU5vWEtqdkNXWXdr?=
 =?utf-8?B?ek1KaUVaQ3dYQk55MjBBUCtoQ2k2OTdUekh4Q1dTeEltVy83czJTS3RuUUk2?=
 =?utf-8?Q?drjtqy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1hma3FLZlpUd3N3cGpwRFpjVDYyek84UTdUclBpVVB0WXg5MU5iL0lyS1FN?=
 =?utf-8?B?Z013aVQ5UmgzZ3dPQU9MY2QvNFZpaExqdHpSc1RVRFNTUWJpRDg4SlRRU204?=
 =?utf-8?B?NC94eDBKbkl6KytSR2NjRUs0ak9DRk16ZWlRWjZ2ZExhemJwTVdhNG1ubHcw?=
 =?utf-8?B?RVkyc3I3TU05aXlKRm5yMkhGbnVtUVQ4NWI0eUdScVE5cDF1Y21ON3d0MXpr?=
 =?utf-8?B?T0NpVzhKS1dSbkN2VWoxSHdjTkZjL2NhOFJWVHFuYk8zSVd5SDZQS2tJbjFG?=
 =?utf-8?B?MlR0dVZJVXV0OTgvVmxHWnp3VU5ZYUN6d0hHOUk2ejhuTmYyRUQ5d0g0TDdX?=
 =?utf-8?B?L1hYaVUxV0hvV2JsbGI1L3djZUM4Qm10dmEvSFF5VXRNd3hIZWxKeW1CS3Nl?=
 =?utf-8?B?ajh6Q2ovT2UxSUZkQThycHkwMzA4QXM2VHMvTDVWSVdEKyszdUUrTG95YkZV?=
 =?utf-8?B?Z2pNUW8wdzc2a21sb1RNZG1BYzdGdld6dmlnL3ZpODRoMENXUVM0TkRQZFhV?=
 =?utf-8?B?ZCs2WExtck1hckw4SGNnSllvdGpEQ1F6TzE2bzZHaEkwRnBEQ0dPT1AxYTZk?=
 =?utf-8?B?cFdyWnp5T1hGeUJHUHVkUXdGZ2VPanhMZkR0RmsrSWk1cmVUS2YwQmJHUzFY?=
 =?utf-8?B?UVU1WVl0cGRNTE8xaGxWcHhvQ1V6bWJiWHZyeDNDZmFmRnA4aXRUVWZHYWFJ?=
 =?utf-8?B?T21VcDR5R2JUbDdYWXpJRElZenFiSDV1Q2RHN0RzbU5uUUcwSTZ1RjFrZVFs?=
 =?utf-8?B?cTArMFRaeGpLdUJUZDNpTGx3a0ZVTnF5UHJwaDQ4dkc1bGVER2Q4Kys0cVp5?=
 =?utf-8?B?azhpcjgxTUFEZVVBcFBJS1R2ck02VjF0ZGRMVE54MktDcFBrc0h1c2gyS1Nn?=
 =?utf-8?B?cFFLSWQ5NUNhcWNIaUJTcnUrWnkrOElraTJNV01jU2dlOWRIdCs4bENqRURy?=
 =?utf-8?B?SllVNStpNDVnVnMwNDBldVA0MXN3V0xiU2MrV3o1SFllODRMWWdZdytQOGxw?=
 =?utf-8?B?dFpvRFZwa1JqTUc5UXJLRzB3MUs4OVQySFZwZVdhc1lqVDRuQXNiVGZ4UzlM?=
 =?utf-8?B?UjBsMno4YVhXVUNuU2lYemdJNVhYT2hOaDRIOEZDSUJJM3ZycXNhL2p3ZnpM?=
 =?utf-8?B?ektmS1N4QzBPRndVd2RyZERIcU8xN0JyT2J1WUFIbHFERzVmbGlEbTF6SUFn?=
 =?utf-8?B?WDA0N0NJb2ZHdmV0MWdadW03UG4zb0k3VTB0YWx6bytEUktaWndMZm5CNUpL?=
 =?utf-8?B?SXAvWTB1T3I4ZC9pdEdaZDVvQ2h4MFQ0MVFkL3ZVTjZTU0NCeHR3OTQwVWdS?=
 =?utf-8?B?Yjc2OFFEZjRHZFpaMlloUlZ4a1ZsWnE4clF3TTVzUHdFemM4MFJkWWh3bnU0?=
 =?utf-8?B?VGk0ZW8xSXdSKzc0UnVBWTdLZklHaXZWbDBSRFNsSkd0bVh1NjRCNkRvYWh1?=
 =?utf-8?B?NWNMa0pnWk9qMHk5MXBLLzVRcnUrQm15bStLeGJBTFd5NGJQSkJiYmdHYVhn?=
 =?utf-8?B?b2NaaU10MktnYWJkQ0k3ZWVnOXJvTkNWZUtLWUlQZ05kVVZvOEpvaHZDOSt2?=
 =?utf-8?B?ZmEzWmFNQnh2WnhtdHNOWWcrejhiVDAxdjB4dlhoT3FwZXpFYUZkU1BqcVI0?=
 =?utf-8?B?eTFxOWJJTnFXb09VenA4YW9GQ3Q2aGRqdjcvV3N3VHpCUXlnTFBJMkp1MTNl?=
 =?utf-8?B?TTZOM1c1d1pjMGNldXU4Q1FBQ1NUT1N0SGNTL1dnVm03d0poemVCS0UxYXUv?=
 =?utf-8?B?a25TcFc2TE5oTEloWjlKR1MvMmREQno3bnZBSWxkZ0I3S1dUTXpLMkVEY25o?=
 =?utf-8?B?d0ZseUt2dGVONUZ1cDZ4cy8zRCtqVEZLQ2o4N3lRUFlOemxCSHNTTVdJMEhL?=
 =?utf-8?B?c2FkQTVhTi8zOWVLREJVU2c2RU0vZVlyNDM3VGNQQStscWhKWlhWUEJjS3pR?=
 =?utf-8?B?aHUyam9yc29xMVJkTXU1U2s1TUQycnNpbTlGVkRNaDh6bjcrVFJWZGNuOEZN?=
 =?utf-8?B?c291dWxJVU1zQ2JvckU4NTJ2S090R0lmQlpNTHpLdWt0NGw0Z3BPQmtoM0Jt?=
 =?utf-8?B?RzJRb3ZDUkVpUHNnMUNISTFMOGVtNHA0MDVIdEg4bTFYd3c4L1FBbnV2WjJM?=
 =?utf-8?B?ODJHdGg1eWdzMTB4dnQyczFHeE96cDV4cW9OcVRTRHR2WEV6TXk3QkpROHYv?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E3172326694B441B60A03A1919B3D14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef77a10-f834-49fa-4ea1-08de1af6ff39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 16:35:27.8743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9myj98l8ulzHYLoLDFmJOSzAVjU6IbE68BuDs3f0ocM6UfIngXaH32WtYMpZiD62y4wMFPih1CRQ8xfrgc48x6UR9b/PFu/jchSTTyuh6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7714

SGkgQ29ub3IsDQoNCk9uIFdlZCwgMjAyNS0xMC0yOSBhdCAxODoyNSArMDAwMCwgQ29ub3IgRG9v
bGV5IHdyb3RlOg0KPiBPbiBXZWQsIE9jdCAyOSwgMjAyNSBhdCAwNTo1MDo1OFBNICswMjAwLCBN
YXJpdXMgQ3Jpc3RlYSB3cm90ZToNCj4gPiBUaGlzIGlzIHRoZSBkZXZpY2V0cmVlIHNjaGVtYSBm
b3IgTWljcm9jaGlwIEVNQzE4MTIvMTMvMTQvMTUvMzMNCj4gPiBNdWx0aWNoYW5uZWwgTG93LVZv
bHRhZ2UgUmVtb3RlIERpb2RlIFNlbnNvciBGYW1pbHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0t
DQo+ID4gwqAuLi4vYmluZGluZ3MvaHdtb24vbWljcm9jaGlwLGVtYzE4MTIueWFtbMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDE3Ng0KPiA+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgTUFJTlRB
SU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArDQo+ID4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDE4MiBpbnNlcnRpb25zKCspDQo+ID4gDQo+IA0KDQouLi4NCj4gWW91IHNob3VsZCBiZSBh
YmxlIHRvIGp1c3QgbW92ZSB0aGlzIGludG8gaW50ZXJydXB0czoNCj4gwqAgaW50ZXJydXB0czoN
Cj4gwqDCoMKgIGl0ZW1zOg0KPiDCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246DQo+IMKgwqDCoMKg
wqDCoMKgwqDCoCBhbGVydC10aGVybTIgYXNzZXJ0cyB3aGVuIGEgZGlvZGUgdGVtcGVyYXR1cmUg
ZXhjZWVkcyB0aGUNCj4gQUxFUlQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgIHRocmVzaG9sZC4NCj4g
wqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9uOg0KPiDCoMKgwqDCoMKgwqDCoMKgwqAgdGhlcm0tYWRk
ciBhc3NlcnRzIGxvdyB3aGVuIHRoZSBoYXJkd2FyZS1zZXQgVEhFUk0gbGltaXQNCj4gdGhyZXNo
b2xkIGlzDQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBleGNlZWRlZCBieSBvbmUgb2YgdGhlIHRlbXBl
cmF0dXJlIHNlbnNvcnMuDQo+IA0KPiA+ICvCoMKgwqAgaXRlbXM6DQo+ID4gK8KgwqDCoMKgwqAg
LSBjb25zdDogYWxlcnQtdGhlcm0yDQo+ID4gK8KgwqDCoMKgwqAgLSBjb25zdDogdGhlcm0tYWRk
cg0KPiANCj4gQWxzbywgc2hvdWxkIHRoaXMgYW5kIGludGVycnVwdHMgaGF2ZSBtaW5JdGVtczog
MT8gQXJlIGJvdGggYWN0dWFsbHkNCj4gcmVxdWlyZWQ/IENhbiB5b3UgaGF2ZSB0aGVybS1hZGRy
IHdpdGhvdXQgYWxlcnQtdGhlcm0yPw0KPiANCg0KUmlnaHQgbm93IHRoZSBkcml2ZXIgZG9lc24n
dCBzdXBwb3J0IGFueSBpbnRlcnJ1cHRzLCBidXQgaXQgbWF5IHN1cHBvcnQNCmluIGZ1dHVyZS4g
VGhlICJhbGVydC10aGVybTIiIGlzIGEgbWFza2FibGUgaW50ZXJydXB0IGFuZCB0aGUgInRoZXJt
LQ0KYWRkciIgY2FuJ3QgYmUgbWFza2VkIGFuZCBpcyAiYWx3YXlzIGVuYWJsZWQiIGludG8gdGhl
IGNoaXAuDQoNCkkgZGlkbid0IHVzZSAibWluSXRlbXM6IDEiIGJlY2F1c2UgSSB3YW50ZWQgdG8g
bGVhdmUgdG8gdGhlIHVzZXIgdGhlDQpkZWNpc2lvbiBpZiBoZSBuZWVkcyBhbnkgaW50ZXJydXB0
cyBpbnRvIHRoZWlyIHN5c3RlbQ0KDQoNCj4gcHctYm90OiBjaGFuZ2VzLXJlcXVlc3RlZA0KPiAN
Cj4gQ2hlZXJzLA0KPiBDb25vci4NCj4gDQo+ID4gKw0KPiA+ICvCoCAiI2FkZHJlc3MtY2VsbHMi
Og0KPiA+ICvCoMKgwqAgY29uc3Q6IDENCj4gPiArDQo+ID4gK8KgICIjc2l6ZS1jZWxscyI6DQo+
ID4gK8KgwqDCoCBjb25zdDogMA0KPiA+ICsNCg0KVGhhbmtzLA0KTWFyaXVzDQo=

