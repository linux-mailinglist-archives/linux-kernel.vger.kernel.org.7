Return-Path: <linux-kernel+bounces-885618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32379C33791
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB5964ED9BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAB22D785;
	Wed,  5 Nov 2025 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWI+IW+O"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49BEEAB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302452; cv=fail; b=trjAIKw4DNv3rGJj5bbuufEIWEqMTc/RjaeKSfCBhmb+BeapQw4KbeSVOzcsDOyIes7Neg14Vsr1I5EmcDca7+WCI9qolca/rIG8yhQJ0dPhXB8qs+JhYvNs2xgND2Sb6Y2erpEwODo9N6XteOkm/N8ArIZjNfwYFIqEqS8FprA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302452; c=relaxed/simple;
	bh=vZ44/NV+Hw8vvXFuTeX8E34m7OmtHpxXRpGykWZENnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6LGkpuNRLWzZfVIfnue77Omgllh3Ri08PNRMMlatxwtlgYYAaFC1sstj8dOpo71cIcNFOw229S5bBTW8JwQlmyS7owLrTTbOhvSAlAjM2TMvsACrIZvcpJbxZzaBNNJa++CJee5kDNKaRH1KSephdS8FmqJLMKcnEkBO9bWX64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWI+IW+O; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHgSFjXKFztozdLpEOxPnlFDd4ocEOThun5O1L0sD1buJb72lDnF6bt16mhB5gXXqbCoRMWBKGCD9cCEEywJMLNvbchDAmj4LfhnAzBmpd0mBwFaIflpfTQp61lIsKxDSOQnq/ykKe6v2AgyAEmSTxI0VkG/ScKCpSXssOmdLYu6H6OwA0N8Q5BpjfYvshogzF1N4sZzQDjMgB8yivpmEtOyn033K3T0AJ4iSIrqTWY7UwBMy2tIdNC8TFBb8gaos+oNggdeZl3CD4W247+rppv4h3eXlgb/vDNhAe8+WF/xaubhWBQrC4f72NlsL+9CnHKGcKWmZyTYZ6wVsKDFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IToTSLr6TSiZDunUKUZoIZ/sQH8yARhrEyvZHSbwyuc=;
 b=gPQkiVtNRq+HTSLlLWgaK/1LRRzW6i33j+eQBesmW9vDkeA6yDEClD73B2bNF2ZPOrTTp1jrqc95yVA5FoMGB6fx1DpYS5oDnzcrDxTgvCILjxUQ7Dlv02d4n1DPPRYe2GHWnQZ5NLsTuSAL+iTEKIGqEcmam8usy5g7C1d6UduNr4Wug3t9SXVlzQ8c3Xd2iSdK+OFUB00dnevke8Q/ha5GFWiMmcCreWvFn6q3xV7cjOdgmWvhDa+YpV5lgEMPvNMN8Hpqw4OP8sTH1BjDEtxgjGo9iRLPJf45Ovr9yLl1it8pVlc2q/WFqcDwT66cAZx23BCtCsxll8ZPgBiqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IToTSLr6TSiZDunUKUZoIZ/sQH8yARhrEyvZHSbwyuc=;
 b=GWI+IW+OAUJ9bkpSKWBXlmVhFM9uRoWF45+Ml04n0gdka9GqFBUQMNV5lQlcLJDZ/I/b75LkGsKHSLjs2amzx7Hfu/1Pm8ebuHVEoVS8csLM9w6sbb0sEVUfG+0RCAOaHgw9eYjRV7znK0I9q8ZGVdPceLkumV3Iw6yImJUrAwVI+PNDM826VIcufbQTh1ZOFuNYkXH/KqumiibyUDSth/YTOQq9egeESAZr1jK6cAGsG1o4gjbBxc7skWdUsNc/9TXqdIEPpvFLVC6UbHlvN9WzIHo79OWvNiTLzKStX1jTybBTKK5FXqninhBLjjkO//+a3rqlZ9zYUL7rXNfY7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 00:27:22 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 00:27:22 +0000
Message-ID: <8f0722c5-203f-4f2b-8654-e77811aee7d3@nvidia.com>
Date: Wed, 5 Nov 2025 11:27:18 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/arm64/mm/fault: Implement exceptions tracepoints
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20251013035532.1793181-1-balbirs@nvidia.com>
 <aQjlzbkdzzYL2xJR@arm.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aQjlzbkdzzYL2xJR@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::21) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd822e9-8d7e-4ee9-2a55-08de1c02163c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVY3ZFhRSHJuK0hvMGNNM01XTWxPNzBhb1RxK2E5R0pyVTZCWHBtQURMTFpL?=
 =?utf-8?B?cTRRYVlCUmdhNHlmV0l5ZTUzaVF5ZERpdk1VYmlpcFNuK2cvWlVPeGRsU3da?=
 =?utf-8?B?U3Y5R01Vb3llMEpLbXdKNzYxTUw0YkdTYUozMFlVeTlDamdPMEw1RWxWMnNp?=
 =?utf-8?B?QkMwaDUyQ0IyaFVpV3ZBenFtOGNxR0FidVphdUJ1R3FuM3hZZEx0Sm1Yellr?=
 =?utf-8?B?NFJWSVFDUWZnanEwRmsyczF5ZjZGaEd5NlZONXhMQzlCd3dvVDh1S1A2Z1Uw?=
 =?utf-8?B?SnpQUStyNms5aUdKZTI5WkR5dHdXODBIQm9kNzRRK0d4dmNIL2xWTlBGTFBV?=
 =?utf-8?B?dHZPai80aVJUNE5DR1BCZDVlQlArMy9kaExHdXluclNoT3ZyOFU3U25xdEUr?=
 =?utf-8?B?bXRJY1p1OHVzRkpITlBPa1VCRzVjWkYvU0dtb0pTQWQ3U0VWQnNwZXFlc0pv?=
 =?utf-8?B?U3VBb0toNk8rcHdoM1R4M1lncFRmZkxxZG9zcXRiNlNIeFYwYzB5aGMraU5i?=
 =?utf-8?B?NUJTQWxTY3pqY1plOGFFYWtFeFdpMllmLzdrTzVMT2Y1MWw4VHNocWlaOTEy?=
 =?utf-8?B?L0JXMmxnR0hjMUs1cmQvZDZZVmIzSDg5TkRnaVNtM1hRR1JDUjlsTGRQalk0?=
 =?utf-8?B?M0l6cVJOQVU2QTNZUG9qNTg3ZUNBZ3RaQW1jbk4vbVQ4OWRXOUVDSDFIQ3py?=
 =?utf-8?B?cGprd2JITmRoK1pEOUVpVlR2eEx0RWl5Uml6djZ5dnhDK2FlWXRYbUtubnUv?=
 =?utf-8?B?QXRHOEUyd3pVb1I0M1JHT1pnczhpangwRS9MNHZpNGpPVEl6QkVZbGRNaXNy?=
 =?utf-8?B?MkxSeVBwM1hZL0dCTWFJUTdaUlhTa3pNY00ySXVnYWVaSTQzRXJuN1gwV1pz?=
 =?utf-8?B?amRFRkZPV2RwVm9EcytmSmNGOW9BbnJNTC8zM2VrRGgxN1JnL3o3RDhpeStI?=
 =?utf-8?B?V2hpUTFrd3kyMmFBM2NvQlJ4dGQ2WGZDeWM5aUdwaXFCbmM3ZEZEdncwU1Vm?=
 =?utf-8?B?a2kyakZpcUFJVEhBSkRKL2twVGVzbTRDYkZ0bTNhbG5PcU1YRWhOakxxSXhF?=
 =?utf-8?B?Rk1Mc0phNGR1bzBkUVNBS1RpTWF3RThsWlAyT1lOQkN5L21NOWZOamdVekhh?=
 =?utf-8?B?eUl1dFdNd21GNUdlaHZYVUNON0hZVmN5OHZNVXZMLzJubS9CTnRlRWVPM0wr?=
 =?utf-8?B?ZlIxQkxLREdRMDIwaG1vMFRnSEkyQUIrMGZPb1hLdVRrWEZOcTQ1WnhubktX?=
 =?utf-8?B?YWFFVkY2ckFmNkFhT1hOYmZGZ1hTV2VKVEs4ZzdHeklIVzRaemZYcEhLM2Ex?=
 =?utf-8?B?U2J2bDZVTXN4aFU0cDZhcEYraFNtVFVYTU01TThXWUYwKzg1czE0RUdsNm80?=
 =?utf-8?B?Zmw3QjcrbEJDamJWeE14ellhWmtTQmVaNy9XVmJUcjZSSjA3K3FWR1FkZysw?=
 =?utf-8?B?ZWpEZC83TWlHZ1ljYmo1NW1mOXdVY1ltM3o1NVhlMWFlVXBlaEtDcExPVXVa?=
 =?utf-8?B?UGRYTm1lck5ZbGJnZ0o2MEwwZlhKcjM1a3JYbGgvUTBQcVJjNlIxVWg2SlRD?=
 =?utf-8?B?ZTZQa0poTTlRM2JYZ1d2YVhhbnYySnluWjV3THFNSDd5dUFFU1VvM2wzYTVL?=
 =?utf-8?B?V2daUFhsUi9HZGxtdE10dVlITjZ6dVQwMUhHUVpiSzVER0g0SmJhY0xVS1Fs?=
 =?utf-8?B?MG9nalhockxza2xWbzJYbk5HbG92VWZ4aS9SUjJGeEg2L2toam9mVUF3OFpB?=
 =?utf-8?B?QTdnWDl3MkxCQ2hEcVBHSUI4cURYaVBhWjJpTktqaEVQRGw3cklSZTdJeDRr?=
 =?utf-8?B?TU5zTU84ZkI0NEs5YXoxSnI3MFpQWm5IZjRWZTZCNzFXQ1pXMnJ4MnluR2FO?=
 =?utf-8?B?ZC9sSTRMaXFibWNqcHVnVWpCYks1U0lraDR2ZlZ3NXo3WmpXTjM2YTJTeWVN?=
 =?utf-8?Q?WIe/JGRxoHZ+/8WWeQQO7COM0HZojZhV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejVFSUYwcWVQL0YvMDRFeWFiV0Y5cVN4RVk4MGZEQU1OUjd1Wk1JTzVKZlFr?=
 =?utf-8?B?WHBJQTdPOVEzQ0pRT1ZWWGEwNmNPclQ1SUc3TW0yalZsdnpzd1RYMVE5eWFp?=
 =?utf-8?B?QklFcHM2MWhJUmFSM1I2bGVoaVBZVlEzUFJobFRSeFdMTUs5dkJIUlppdXE1?=
 =?utf-8?B?bXl0QnpQOEdENThVbzVscG14RXJIYzNxVlpFQjdSR1NFVFEyaWVOVG1wdENn?=
 =?utf-8?B?SFc0bzlPSXJZNjFrMU8zV1dsTkVBa0FtcGM5TUFmcXJJN1FlQ0I5bjR6aU5U?=
 =?utf-8?B?c0tyWitOcW5iRnZyUUcxYU5PSVRWOVUrWWszd0h3c1BFRXlzRW5OV0cvV3VM?=
 =?utf-8?B?WWcxaDgvK09IVHhiU0MraWpldkhZdWtXMjA5Ym9Fc3k0c05tZERnVFZraGdO?=
 =?utf-8?B?eWhGQ0F3SEJycklONXREd1g4NkVmRGpSQ25xVkF4bW9XZDBlNmMxdzJ6S1ZJ?=
 =?utf-8?B?N0JqMitNeWJMVzd4VVY5aCtQYXBQV1k2NmJEYTNLb3VINjJmUmh4WERUR2RM?=
 =?utf-8?B?TSt0Sm0zMnN6czdxTmFDTUxKNk9iOGRZNU1BQy9KUkpEQzV0M3Z5NTJYWjBp?=
 =?utf-8?B?dEtpeTZBRmxESFFFVHlvVXVlYnY2U3NQTVBuTlVZdlBIUVI0dUhxTE9yOVVy?=
 =?utf-8?B?ZVRUWEZoLzhENzBFNmFvUnFlaTNObHBadHlNM3Y1Vjd4MEptL1hwODB4QitZ?=
 =?utf-8?B?NzdWb2p5YmMyVCszNU84R2Y2OCs4a1NkUjBCUTJlV2dZZHJ1LzFFLzd0cTVJ?=
 =?utf-8?B?d0lJUVJTS1AwNks3QWk4S0JoeWJsRk5JdXBNcDBxM1k5cm1WMEZxNnlScXYz?=
 =?utf-8?B?anBkWGwxSGZ0ZURXZG5mbXVRQkdEMjBPVE5NL0MvdXJQYXc5TU5PbUFQVEpJ?=
 =?utf-8?B?bmN1VS9MRFBJY0lHYWJyVFh0SkdleEpiR2Exc1l4djNOdTJpMW10T2Q1MERp?=
 =?utf-8?B?Mkw3TFdvVkZVa0VvaHdDMk5vVGZlMnpPQ0x4R0ptWWI4YVVMTkF6OXNEdFhT?=
 =?utf-8?B?TVNQTk0vZzI0NW9TTEJBSDhLNDNLdXdLc0psaERjT0JoZUxDbit6S2JmL0Q4?=
 =?utf-8?B?QUVzWC93YmExNjREcmFmQi9WOWV4MFBrVnE4STRZb0xaYlk1b0ppYldHUXpv?=
 =?utf-8?B?L0Z1RHNMZDc5VTZsVkplbEpPV3ptc0dRcThRNnFjeWVhc2g3bC9ISHVUSnZJ?=
 =?utf-8?B?N09oakNIbW5Zam1BWmtmZjRnVmpsTnZyTGxtTHEzbFRzWGloQjNLbzBKcGdR?=
 =?utf-8?B?UzlMblZyVUVNZ1JxTDlsV3ByZktNdldKYWJUbytwR0I5KzRJRjRPZ0JyNzdr?=
 =?utf-8?B?V1FDdGpNeE1yM3NiaWZGVFo1dXAxM01PYmFRaFlJWXZLVFhndWhOYlA0QUJT?=
 =?utf-8?B?MWV0V3FQNTV0QUVWWlpaeTJWQmFGejRhSms4WEVzdkd3cFU5cVlMSzRqeEJn?=
 =?utf-8?B?SWYvdTZBOFlVWEpHeGUyMHRHQS9EWmZ1dFhUYUpGaFdOaTczR00rTWdhS0dX?=
 =?utf-8?B?VzA2OVhyZzJuRlVPTk5CRWFWb0VaOWVEY1ZQNS9EeFlUdFd3dGFoYTlHRHA0?=
 =?utf-8?B?RkdCNG1RS0NjNUphYUdXSUNraEVJbEJXUzh1QytsRm9GZUJLbjFwSnJtYVFy?=
 =?utf-8?B?QnhLemticUttdTZnUGc3Ykpaa29IZi95NTE0WUlpaUFWaGxZNzVFQjhjSjZx?=
 =?utf-8?B?SkR4aDJvcFFFc1lCeWJ0V3dOVmNzM2tYbEpKR09NelJ2OVJMWHltYTNZdkE5?=
 =?utf-8?B?REZPOU5ZaE96bVFZaEJLQWhudkp5aE1iMWVIUC9IaDg1cURoSjlLNWJmejZV?=
 =?utf-8?B?RUZHWGtFY1o1R2d3bURGdC81SWpYRm1EZlVSUlVoUWZaendGMVR6Kzhia3Ex?=
 =?utf-8?B?RVFHayttd1A5WGluQmhwRnY4NWFLUlFyQjBaZXRWbDVrVzljdlFTSm0vVlly?=
 =?utf-8?B?NzZ3NFBQYkRGVlJNUGFsQ3N0dDQ1VUVYWkw1Snl3a0JBMXVyMElMS1hwYXo1?=
 =?utf-8?B?Tk5DVnA2dnI4T05OTFZ3cjNnc2FNZCtqNGovenZnem5nelBtVkJ3ZTFTZUZq?=
 =?utf-8?B?aERWMnlxcURUdy9xd1pHeVlteFhtVXd2RjZ6YlhYY1hodGwxK241WFg2NHRz?=
 =?utf-8?B?WnRtUFZSVW81eEN1WGRnem9IUnd0bytpeU5BWVlGam5Yb3gxcUVMVDFLUGZE?=
 =?utf-8?Q?laubM3LDXHskg91gbRD09NlHgy++zLQ6AB8z0oLsQP2o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd822e9-8d7e-4ee9-2a55-08de1c02163c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 00:27:22.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXOjJ8HKaS2NmWW2k5QPKtD418kDRNLFuwR+Wa90ouD+EROKrPTo7PzjS2njcQPNY3i62sap4hqURCtfUVZixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371

On 11/4/25 04:26, Catalin Marinas wrote:
> On Mon, Oct 13, 2025 at 02:55:32PM +1100, Balbir Singh wrote:
>> x86 and riscv provide trace points for page-faults (user and kernel
>> tracepoints). Some scripts [1],[2] rely on these trace points. The
>> tracepoint is useful for tracking faults and their reasons.
>>
>> Adding the tracepoints is simple and straight-forward. For arm64
>> use esr as error code and untagged memory address as addr.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Paul Walmsley <pjw@kernel.org>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: Alexandre Ghiti <alex@ghiti.fr>
>>
>> [1] https://www.brendangregg.com/FlameGraphs/memoryflamegraphs.html
>> [2] https://taras.glek.net/posts/ebpf-mmap-page-fault-tracing/
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>> ---
>>
>> Tested at my end with a kernel-compile and running a user space
>> program to check that the trace points are indeed reported.
>>
>>  arch/arm64/mm/fault.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index d816ff44faff..9d7b86e92434 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -44,6 +44,9 @@
>>  #include <asm/tlbflush.h>
>>  #include <asm/traps.h>
>>  
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/exceptions.h>
>> +
>>  struct fault_info {
>>  	int	(*fn)(unsigned long far, unsigned long esr,
>>  		      struct pt_regs *regs);
>> @@ -572,8 +575,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>  	if (faulthandler_disabled() || !mm)
>>  		goto no_context;
>>  
>> -	if (user_mode(regs))
>> +	if (user_mode(regs)) {
>>  		mm_flags |= FAULT_FLAG_USER;
>> +		trace_page_fault_user(addr, regs, esr);
>> +	} else {
>> +		trace_page_fault_kernel(addr, regs, esr);
>> +	}
> 
> This has come up before and rejected:
> 
> https://lore.kernel.org/all/aG0aIKzxApp9j7X0@willie-the-truck/
> 


Thanks for the pointer, since it's been five to six months since the discussion, I don't
see the kprobe handler being merged with the trace point. The real issue is that while
we fix the issue some scripts are broken by default on arm64, see [1] and [2] above and a simple
search for exceptions:page_fault will show up many more. It's just hard to be have all of
those break and fix them as and when needed.

Can we please have this fixed, so that trace-points scripts can work on arm64

Balbir




