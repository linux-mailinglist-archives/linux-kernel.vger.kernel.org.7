Return-Path: <linux-kernel+bounces-900038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF1C596DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9CA3B651A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775CF345CBA;
	Thu, 13 Nov 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="siMOc5MI"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022075.outbound.protection.outlook.com [52.101.48.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44C2F8BF7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057709; cv=fail; b=X0OcnFafcOleQg3+4q20tHQqL9z6oaCJvOQ0qyytRLHIR+3dfcqzyPFLtgUiIhWOhmKYe4eW3Ndr1wgXIZ/61L4GyPcULs3xQ6Dq8VbhYR6hkhXDfJylqbHT+BzhXuDaFjAOfqGFArTxv4tf24YvbxzCyPKxRooCs7pH9Wn89pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057709; c=relaxed/simple;
	bh=2ckDRWtyFo6v+2KD8rJJNPRaFj091aKEQ0hzPM7S6fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mQVxg8XIaBruR8HpxsLPk+1dKxWEp3I2l+eC951i8ICh3EziSyEICF50lYh/uSDHp+J+JvJBTPHHZ9Ex25cBmepx5CnGrd6HeKaOhLRGWDhUkTSNso9LluIs4hOsH7yUMVqyRRNQN3SbxDXGfeJDsWUSW8L/uslJSNMqIc44dWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=siMOc5MI; arc=fail smtp.client-ip=52.101.48.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcgSVJ5MVoSHZz/mLdMlvspVEUOlNu5q4CZ+sd1Gg1CzF3PwDKF1oO4PPXrkCtkBsDdDXw0apAilzWZxhSsDHxE5mgIvMdRymz3yCoDIbBc31gLH/7ftwqkYxPBt2Zg3VhBPswCXvkeUs2w5vlFFRXdsA6bVYZcwfHs/EI7qEqtq/mnI7HqQL9nZXkVI/cSmzocqJNjMlekELhRkKP864I3iyYONsp3QcUeiNmdD5WQuIkyC9VNkgIM1aOc/IApLNgy8Wij4spdXwG0ce99OJ/Wa4u0ZJnX3SoRQY+bevF4wzGKYvNYrGIiOakIvyMMUUuOerz9BQ3kuFumr/hzlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRiHwSNDKQ1NECK42dxxS62HQ6rAVHKhjebcL2yrAzU=;
 b=ovQj1ClAcgV/aG83v/5gYEBh7V+op3TJJ2OEz2a/yPc0loS8v9E8ychPeFXlbOUD/QWEEk+wxpYrltQTSuqMbCIE2z4kf3PgTu4UOIUGSMv1jcl+TzVk0tZ8fU6D2fPHrQJcA7iKceLYPN4yghphF/bonqgD886o4jLtU60f53P8BOCuCpIAKmRmXRJQZsFz7IEj4W2MpPhlwbuV6tgdLyZP2KGEs6TIPARv3K2pGFXJt+yrFutphk5U0mF6e0y/SvQ/wr56KEb3r4Gf/1qacIP3UP2kxk/SGOt6HEbcZ6OVKEnW3CUHJnwe3q68hv+VaaN8JKvXr0lHWke3NYcpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRiHwSNDKQ1NECK42dxxS62HQ6rAVHKhjebcL2yrAzU=;
 b=siMOc5MIKIA2KSKUFCM9bx7tMya+XetQzW8mf4OwGwIfByG4WCpELgMOlbrr3N2ojD99ERuK3G8zAZVaDAUzuY7yKpz562hYWvwxwui/gK1AZIdIxt4BCX+77X7WhyadbYPL4bkyIphyLPtfLkIelYyHP7MzavjSF5ktEbJxMNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CY1PR01MB9315.prod.exchangelabs.com (2603:10b6:930:108::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Thu, 13 Nov 2025 18:15:00 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 18:15:00 +0000
Message-ID: <0fb97638-a678-4afc-9d96-cb1b95fc2194@os.amperecomputing.com>
Date: Thu, 13 Nov 2025 10:14:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: mm: show direct mapping use in /proc/meminfo
To: Ryan Roberts <ryan.roberts@arm.com>, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251023215210.501168-1-yang@os.amperecomputing.com>
 <3af5d651-5363-47f7-b828-702d9a0c881c@arm.com>
 <0bb112c7-1ed0-4ee1-a1df-6a7d4b224fb6@os.amperecomputing.com>
 <6a3c7a5a-fcb4-4a46-b385-74153f78337a@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <6a3c7a5a-fcb4-4a46-b385-74153f78337a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR19CA0107.namprd19.prod.outlook.com
 (2603:10b6:930:83::25) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CY1PR01MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe705c3-9fa1-4d90-3344-08de22e08eda
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTdaaVVWM3JFZngrVHJ5NVptSzQ5Q2J2aXNadzh4SFBGa2lhTHE2eUw5MnM4?=
 =?utf-8?B?SHNzU2phcSt0L05wZGVCUWlqTGE1RDgyS1hVMjFSL1B4K1lQVWE3S0pCSFpt?=
 =?utf-8?B?RTFFRWFwd1ZpRk5nc1dLZysrMEVKMXVwS3hmcDZtMTBNSG5ST1dBbkZscUYx?=
 =?utf-8?B?b3VxUDRhc2lnbGtkdmk5UktxOWcrYjJFc2QrV1prMUZ6OTdWT2RHQ1U1YzND?=
 =?utf-8?B?QVdHZnM5RkZiZjFvS05QQzk1TE5zcmVDcDlCaUVITk14SW1USjNmN2NIdDlK?=
 =?utf-8?B?Skp2SllNakVUblM4RWRMUG9nTFdPUFFKWU8wc0pVdlhxTGlkOWE5Q2s4TXNB?=
 =?utf-8?B?TFZROG83ZlRyUy9Pc2tXby9Icnd6RXFWVi9ObkorNlNxaWJKdi9BUnlpeXA5?=
 =?utf-8?B?bCtxK0VvYUdrRzVBeUc3RUlyUHFqSGtrT2NjMjFVbmVyYjkvZ1ZCRWNkZEJx?=
 =?utf-8?B?akN3ZDNzMzhtZXBTUGtKaGJlVWh0YXpyM21yR01zbldNRWZvM1dRVmE0SDM0?=
 =?utf-8?B?RXdIbFdHU2lWTzlLb1UzRzBkbzFNdnJzcUJTQzdsY1Z3ZjkvQ05nVzZLMFhp?=
 =?utf-8?B?NkNVTnRCRXBpckp2Z1h2blpCdGs4N043T3NDUmFKYW12RFYxWmVhMG9IZncy?=
 =?utf-8?B?MldkZlpXMlZreDd5eHdRZ3N1aUkvcTRDcjQwSFRHY1JkNHhseHZwcFhYZ3RO?=
 =?utf-8?B?TzdFYVpSby9JUnpwdVNHa214ZEJkV21STDFPcURCYU9BZ0daZU1YcWZ1UWdW?=
 =?utf-8?B?RnlGTStuRjVhQ1FYRlVvd0owVDVRSG1mMkR6cDVETVhNenNPQ2Rhb2cvT0hR?=
 =?utf-8?B?S2FNVjZCOGk5RVhHR1ZGV0JaMHBKNXRWNjZiMTdyNEd2NWN1WTloNFpqY2xD?=
 =?utf-8?B?VkVwTVhsWFJZOXZwdTVCb3VrSlJaOGU3bjEwRDhOZWlBdjFhUnhoMy9XWDhq?=
 =?utf-8?B?QSsrQy8vdjA4ME53Ynh1YVFSWDJzUlphR2hKdHlZSTJtQndmbW5zY0paazg4?=
 =?utf-8?B?cnNvcFk4WGIyeFZlSGxoRTkzU1hpVHR2aWZKY0VGTFVpaDVjUXM0b2d6MHBr?=
 =?utf-8?B?VjFVenZiVWZoKzZEMTBDajZrU1hNWVErZ3c0ZEpEbFRrMnpTeXNhUlNGQmJE?=
 =?utf-8?B?SVNsNDNVNldZalNBYUI3Qm1Zbng4RTVYYTkvTkJ3Nmw4NFpWUm9Ub3V4YkRV?=
 =?utf-8?B?MEY1U1NsSW1UMzhyQnQvUVdPeEU5ZWhXdXp6RlgwbTZUKzZIRkhQL1Eyb0x6?=
 =?utf-8?B?cEc4WU9EMHlaMGhOdElvVkxjZk1ZdkFzazB5cGczTzJJT2ZySkN0dEZTSkNl?=
 =?utf-8?B?ZmlsdnNJb1BWb1h0MCsvS0JMMUNzZkkvK3pUQ25xdTdXbSt4TGtPTlVSTzFM?=
 =?utf-8?B?eXBsbjc4ZVBSbFFrbU9IOXRWaHVjWmE3SnhTTGxCaTFySUJyT2F2TnpSSUhl?=
 =?utf-8?B?OGpOdWFpaGI3dmpSalk0eGNCWWNocWZkY3B4MGRFRFNoMjFsalpkd2xwNUdD?=
 =?utf-8?B?QmpBQzQ5YzAzK012aGRIN0Q5dnRtMnVLaHRiSSswcjVaNlh6QzFIZ2x6K3NC?=
 =?utf-8?B?L2tuQWYzVkdpNDNiSU1TY2NCNS8vLzM1dXhENWFTTXgreWZMREl0c0M3WVdy?=
 =?utf-8?B?MFVlMy9hTFBMd3paYWF4MVFDdzUvN3lIZURYWFNwMFJOV2pXZUp2cXZQZjB4?=
 =?utf-8?B?TGhlQ1dtS0tOZjR1K1VSOEhzNEZiT1pjaS90UWVRSEpJVkZWUE9sV3NSYWpE?=
 =?utf-8?B?aFZiY0wrVzhmeU5LNVVsNW5yelNrcVBDNG8yY3VNWGp1RGZXVklySm5oUFh3?=
 =?utf-8?B?Q1ViWVhoS2FiVWI0ZVYzcUxPR05rV2tQSlQ1TFdhR082TjY0alVTVmdwdWVV?=
 =?utf-8?B?dTh6OE5aSlJpSzZkdXE3NmZHZ2hiNGpLdGFiTzNLa1ZpNFo1WXhSZlpxSGRk?=
 =?utf-8?Q?qsRbVA6EENifK0y0+3906uoqhCrBLB7I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N045NHZsNmh0cjQzSDFZNkgvMjNORWh2R3RkN0tRVHdza2JaRUxld1cxODJo?=
 =?utf-8?B?ejg2aGxMZ2lTbWoyTzNJbldta1lNWFBDVU1ZM2JvdWRhSUNvc1A2T3E3WFBP?=
 =?utf-8?B?VEExVkNUQjlWREtLN1Y3UTFQV0NYeWVrNDZvaTlKeVhFcVIwZXlRcFBkVXRi?=
 =?utf-8?B?Y1puZXJINHpQZTdkalM0Ty9uVEczdW4rNXpiclRmOWsrNTlTL3Q5ejNEZWlw?=
 =?utf-8?B?YTFicnNnV1ZWZDd3UjJkZk9BZFp4YVpEejVhNDJGT0d5RHRwOVJsQlNnL3Uv?=
 =?utf-8?B?d0M4aUxOSzJyYW5yMkozTkJySmNKMldLMlVyeUZiNVRlNWxHVm5aUGFuYXNs?=
 =?utf-8?B?Yng4NFM1L1BjbmpkVW5jZGpmS0JMK0VnU1k0cCsyazdwZENRbEEvYmFVUWEw?=
 =?utf-8?B?ZDhMR3NuNGZBRTJtU3lxSkhIWkwwalFiRmFOeHlHYVFiWHpUQlRiZEswYitS?=
 =?utf-8?B?WUlzeFpRek93c2grRDc1VFc4QVhnUGdvOEpQWmZVYkRpc1F1TkU1RUdRQWtp?=
 =?utf-8?B?NFE3TFFmM282L1BtSk9lUUlTTUpNV1ltaEEwWWxTcy93OGFFenAyVDR2bW9l?=
 =?utf-8?B?MUtxOEY2dkJLUkFtS21jdXN1dkdGUGJUMG1WTDlxbHJvaTZoc2lYdy9uR0My?=
 =?utf-8?B?MnlKSkhwcjBWNlBZZTBITDZRRnBCUDN1L3JQNFVpWWJZMkdYUXViMTgzK0J4?=
 =?utf-8?B?WVhMeXFVdDZ1RlkwdzE1YkhPbi8yT1Rpb1hBc3NadmE5RnpCeUdmS2ZqNkk4?=
 =?utf-8?B?b0RBSjBJcDg5MjZzdzF3MktDeGE0MS80b3c1OWNVZHlTd3B3ZmcwZ2hRZ1Fu?=
 =?utf-8?B?cEJKUXdSM0MyMGtvUG80NWREdWtQVWRpKzV6MGpKRC90OXdJUTA0bFEyeTB4?=
 =?utf-8?B?WCtUaksrMlJVN2RXMWJzQkJlMjVRdWs1OFoyREJnU2EwWUFpYllqTnczR0NV?=
 =?utf-8?B?OVhvMVRDRFJ0NmR2dWZZOXVJc0NmNEVwUnhQdjNNRXA2d0krNDFxU01xKy9T?=
 =?utf-8?B?amdDcW9IWEFXV2hWSEQxQzlmdXByNGo4WVJXTWptOFp6M0hXSEJ1dS9qVGw2?=
 =?utf-8?B?UzVsUzZmdGZIdmcvRnh1dlRwUmdGZ1lRckU1RVlVRThYVHdXSC9DWTVEdXhh?=
 =?utf-8?B?OE9kamdIbHowU3pzWlZSOWZ6RGhrb3BUOERlRFN5L1MxTENVUmh1Qlg0ZmpC?=
 =?utf-8?B?WmcvS1AxNWNpd0xkQmxHOWttemdNYmZqclRoUko3NERCZ0RZejI0S1lxK003?=
 =?utf-8?B?ZzNyUUVlMXdVVnJ1Ykw4ZStDSmxrZ0lRNy9QUmo3MmExNUZaalMrUDZ5N1pt?=
 =?utf-8?B?S01IOWRiVm9FanlsdjlUajZ3MkRra24xcExKQ3pVSWtBeGs0K20zcnh6djNK?=
 =?utf-8?B?dzZlNTR1andGZTRoMVYwZitQdURHZVhBUlRmWHZuMVFEWWNnMWkwc2dDRUUy?=
 =?utf-8?B?REUzQUZCR2locHFDNjhFVkZNWGdFS2ZTNURIM3NYWkUvdkdWVk5nQmEzVlND?=
 =?utf-8?B?bW1za1pha1lxY1lzay9Da3Bhb0ZTak4zQm1TQ2RFOEREdTU2RkFjcXdFY0F4?=
 =?utf-8?B?RzVVSXFZZ0lFUndTYlk0SjEyYkFHdzVXblNndndzeE5MQmM1b3JVNnREVDBt?=
 =?utf-8?B?MUFRdGpheXI2M044OGhhTlErRnArZzRwQXI2T0lqN0lJSFN6d2FXU3Z4dXVw?=
 =?utf-8?B?L3NSK0JZV1hKY0VDaGlaTXNHeVBJcWV3emtvYzN5dFVmZU0zRGYxY3NDTlo3?=
 =?utf-8?B?UGo1bmhXWXRlaEJNL0FBOXMxQ0ZIOGRidzNWbWxrQlB2Qko1TDJ5OWJYUTc5?=
 =?utf-8?B?RHRUUnhWNEdVWXhVVjZEcDl6b1ZUSnVPL05DdlpyeDVvVlFIdTIzYzJjRS9h?=
 =?utf-8?B?L0F2MkZQTkd4aGNRdUcxemtJL1RUQnFKdHZxY1V0NFlITktWWlZiOUVsNkJX?=
 =?utf-8?B?T0ZzakVpdG9nOE9SMDE1QlhSdXJ6RHNwamt0c3dnQUN1KzE4QlNrYS9Fblgx?=
 =?utf-8?B?Y0tBRGxmVmV6bnFDRnNpTEVaczhKT25XZVpHVlRJRGpEbU9yL3NaRWl5Vk53?=
 =?utf-8?B?Tmo0Wmd2NGdkRTJpOVVMV0NUSWIzalg5aEwwOUI3V2dSOGVlcSt0VWR6ZFNW?=
 =?utf-8?B?QWhzWUtmRFI4UGl4TWNxK1I2V2JjZjR0UGpnNm01TlR4WmJpQ2xGUEVLUjRG?=
 =?utf-8?Q?6vhsYwL/UXAedhQhSqgnWl4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe705c3-9fa1-4d90-3344-08de22e08eda
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 18:14:59.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0lopihzSzAMOIqp+1iGG6LXwFnS8VQXYw01FjKYspKHRach9qWBClWB8HMUN6PSOr28cJM/8nHrvUwo4ytj3nZfqlRbRhxGtJDhSdQaYng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB9315



On 11/13/25 3:28 AM, Ryan Roberts wrote:
> On 12/11/2025 22:24, Yang Shi wrote:
>>
>> On 11/12/25 2:16 AM, Ryan Roberts wrote:
>>> Hi Yang,
>>>
>>>
>>> On 23/10/2025 22:52, Yang Shi wrote:
>>>> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
>>>> rodata=full"), the direct mapping may be split on some machines instead
>>>> keeping static since boot. It makes more sense to show the direct mapping
>>>> use in /proc/meminfo than before.
>>>> This patch will make /proc/meminfo show the direct mapping use like the
>>>> below (4K base page size):
>>>> DirectMap4K:       94792 kB
>>>> DirectMap64K:      134208 kB
>>>> DirectMap2M:     1173504 kB
>>>> DirectMap32M:     5636096 kB
>>>> DirectMap1G:    529530880 kB
>>> I have a long-term aspiration to enable "per-process page size", where each user
>>> space process can use a different page size. The first step is to be able to
>>> emulate a page size to the process which is larger than the kernel's. For that
>>> reason, I really dislike introducing new ABI that exposes the geometry of the
>>> kernel page tables to user space. I'd really like to be clear on what use case
>>> benefits from this sort of information before we add it.
>> Thanks for the information. I'm not sure what "per-process page size" exactly
>> is. But isn't it just user space thing? I have hard time to understand how
>> exposing kernel page table geometry will have impact on it.
> It's a feature I'm working on/thinking about that, if I'm honest, has a fairly
> low probability of making it upstream. arm64 supports multiple base page sizes;
> 4K, 16K, 64K. The idea is to allow different processes to use a different base
> page size and then actually use the native page table for that size in TTBR0.
> The idea is to have the kernel use 4K internally and most processes would use 4K
> to save memory. But performance critical processes could use 64K.

Aha, I see. I thought you were talking about mTHP. IIUC, userspace may 
have 4K, 16K or 64K base page size, but kernel still uses 4K base page 
size? Can arm64 support have different base page sizes for userspace and 
kernel? It seems surprising to me if it does. If it doesn't, it sounds 
you need at least 3 kernel page tables for 4K, 16K and 64K respectively, 
right?

I'm wondering what kind usecase really needs this. Isn't mTHP good 
enough for the most usecases? We can have auto mTHP size support on per 
VMA basis. If I remember correctly, this has been raised a couple of 
times when we discussed about mTHP. Anyway this may be a little bit off 
the topic.

>
> Currently the kernel page size always matches the user page size and there is
> certain data passed through procfs where that assumption becomes apparent. First
> step is to be able to emulate the process page size to the process. Exposing the
> kernel page table geometry makes this harder.
>
> But really this is my problem to solve, so I doubt a real consideration for this
> patch.

Thank you.

>
>> The direct map use information is quite useful for tracking direct map
>> fragmentation which may have negative impact to performance and help diagnose
>> and debug such issues quickly.
>>
>>> nit: arm64 tends to use the term "linear map" not "direct map". I'm not sure why
>>> or what the history is. Given this is arch-specific should we be aligning on the
>>> architecture's terminology here? I don't know...
>> I actually didn't notice that. They are basically interchangeable. Just try to
>> keep the consistency with other architectures, for example, x86. The users may
>> have arm64 and x86 machines deployed at the same time and they should prefer as
>> few churn as possible for maintaining multiple architectures.
> Yeah fair enough.
>
>>>> Although just the machines which support BBML2_NOABORT can split the
>>>> direct mapping, show it on all machines regardless of BBML2_NOABORT so
>>>> that the users have consistent view in order to avoid confusion.
>>>>
>>>> Although ptdump also can tell the direct map use, but it needs to dump
>>>> the whole kernel page table. It is costly and overkilling. It is also
>>>> in debugfs which may not be enabled by all distros. So showing direct
>>>> map use in /proc/meminfo seems more convenient and has less overhead.
>>>>
>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>> ---
>>>>    arch/arm64/mm/mmu.c | 86 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 86 insertions(+)
>>>>
>>>> v2: * Counted in size instead of the number of entries per Ryan
>>>>       * Removed shift array per Ryan
>>>>       * Use lower case "k" per Ryan
>>>>       * Fixed a couple of build warnings reported by kernel test robot
>>>>       * Fixed a couple of poential miscounts
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index b8d37eb037fc..7207b55d0046 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -29,6 +29,7 @@
>>>>    #include <linux/mm_inline.h>
>>>>    #include <linux/pagewalk.h>
>>>>    #include <linux/stop_machine.h>
>>>> +#include <linux/proc_fs.h>
>>>>      #include <asm/barrier.h>
>>>>    #include <asm/cputype.h>
>>>> @@ -51,6 +52,17 @@
>>>>      DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>>>>    +enum direct_map_type {
>>>> +    PTE,
>>>> +    CONT_PTE,
>>>> +    PMD,
>>>> +    CONT_PMD,
>>>> +    PUD,
>>>> +    NR_DIRECT_MAP_TYPE,
>>>> +};
>>>> +
>>>> +static unsigned long direct_map_size[NR_DIRECT_MAP_TYPE];
>>> I wonder if you should wrap all the adds and subtracts into a helper function,
>>> which can then be defined as a nop when !CONFIG_PROC_FS. It means we only need
>>> direct_map_size[] when PROC_FS is enabled too.
>>>
>>> e.g.
>>>
>>> #ifdef CONFIG_PROC_FS
>>> static unsigned long direct_map_size[NR_DIRECT_MAP_TYPE];
>>>
>>> static inline void direct_map_meminfo_add(unsigned long size,
>>>                        enum direct_map_type type)
>>> {
>>>      direct_map_size[type] += size;
>>> }
>>>
>>> static inline void direct_map_meminfo_sub(unsigned long size,
>>>                        enum direct_map_type type)
>>> {
>>>      direct_map_size[type] -= size;
>>> }
>>> #else
>>> static inline void direct_map_meminfo_add(unsigned long size,
>>>                        enum direct_map_type type) {}
>>> static inline void direct_map_meminfo_sub(unsigned long size,
>>>                        enum direct_map_type type) {}
>>> #endif
>>>
>>> Then use it like this:
>>> direct_map_meminfo_sub(next - addr, PMD);
>>> direct_map_meminfo_add(next - addr, to_cont ? CONT_PTE : PTE);
>> Thanks for the suggestion. It seems good and it also should be able to make
>> solve the over-accounting problem mentioned below easier.
>>
>>>> +
>>>>    u64 kimage_voffset __ro_after_init;
>>>>    EXPORT_SYMBOL(kimage_voffset);
>>>>    @@ -171,6 +183,45 @@ static void init_clear_pgtable(void *table)
>>>>        dsb(ishst);
>>>>    }
>>>>    +#ifdef CONFIG_PROC_FS
>>>> +void arch_report_meminfo(struct seq_file *m)
>>>> +{
>>>> +    char *size[NR_DIRECT_MAP_TYPE];
>>>> +
>>>> +#if defined(CONFIG_ARM64_4K_PAGES)
>>>> +    size[PTE] = "4k";
>>>> +    size[CONT_PTE] = "64k";
>>>> +    size[PMD] = "2M";
>>>> +    size[CONT_PMD] = "32M";
>>>> +    size[PUD] = "1G";
>>>> +#elif defined(CONFIG_ARM64_16K_PAGES)
>>>> +    size[PTE] = "16k";
>>>> +    size[CONT_PTE] = "2M";
>>>> +    size[PMD] = "32M";
>>>> +    size[CONT_PMD] = "1G";
>>>> +#elif defined(CONFIG_ARM64_64K_PAGES)
>>>> +    size[PTE] = "64k";
>>>> +    size[CONT_PTE] = "2M";
>>>> +    size[PMD] = "512M";
>>>> +    size[CONT_PMD] = "16G";
>>>> +#endif
>>>> +
>>>> +    seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[PTE], direct_map_size[PTE] >> 10);
>>>> +    seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[CONT_PTE],
>>>> +            direct_map_size[CONT_PTE] >> 10);
>>>> +    seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[PMD], direct_map_size[PMD] >> 10);
>>>> +    seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[CONT_PMD],
>>>> +            direct_map_size[CONT_PMD] >> 10);
>>>> +    if (pud_sect_supported())
>>>> +        seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[PUD], direct_map_size[PUD] >> 10);
>>>> +}
>>>> +#endif
>>>> +
>>>>    static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>>>                 phys_addr_t phys, pgprot_t prot)
>>>>    {
>>>> @@ -234,6 +285,11 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned
>>>> long addr,
>>>>              init_pte(ptep, addr, next, phys, __prot);
>>>>    +        if (pgprot_val(__prot) & PTE_CONT)
>>>> +            direct_map_size[CONT_PTE] += next - addr;
>>>> +        else
>>>> +            direct_map_size[PTE] += next - addr;
>>>> +
>>>>            ptep += pte_index(next) - pte_index(addr);
>>>>            phys += next - addr;
>>>>        } while (addr = next, addr != end);
>>>> @@ -262,6 +318,17 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr,
>>>> unsigned long end,
>>>>                (flags & NO_BLOCK_MAPPINGS) == 0) {
>>>>                pmd_set_huge(pmdp, phys, prot);
>>>>    +            /*
>>>> +             * It is possible to have mappings allow cont mapping
>>>> +             * but disallow block mapping. For example,
>>>> +             * map_entry_trampoline().
>>>> +             * So we have to increase CONT_PMD and PMD size here
>>>> +             * to avoid double counting.
>>>> +             */
>>>> +            if (pgprot_val(prot) & PTE_CONT)
>>>> +                direct_map_size[CONT_PMD] += next - addr;
>>>> +            else
>>>> +                direct_map_size[PMD] += next - addr;
>>>>                /*
>>>>                 * After the PMD entry has been populated once, we
>>>>                 * only allow updates to the permission attributes.
>>>> @@ -368,6 +435,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long
>>>> addr, unsigned long end,
>>>>                (flags & NO_BLOCK_MAPPINGS) == 0) {
>>>>                pud_set_huge(pudp, phys, prot);
>>>>    +            direct_map_size[PUD] += next - addr;
>>> I think this (and all the lower levels) are likely over-accounting. For example,
>>> __kpti_install_ng_mappings() and map_entry_trampoline() reuse the infra to
>>> create separate pgtables. Then you have fixmap, which uses
>>> create_mapping_noalloc(), efi which uses create_pgd_mapping() and
>>> update_mapping_prot() used to change permissions for various parts of the kernel
>>> image. They all reuse the infra too.
>> Yes, thanks for catching this.
>>
>>>>                /*
>>>>                 * After the PUD entry has been populated once, we
>>>>                 * only allow updates to the permission attributes.
>>>> @@ -532,9 +600,13 @@ static void split_contpte(pte_t *ptep)
>>>>    {
>>>>        int i;
>>>>    +    direct_map_size[CONT_PTE] -= CONT_PTE_SIZE;
>>>> +
>>>>        ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>>>>        for (i = 0; i < CONT_PTES; i++, ptep++)
>>>>            __set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>>>> +
>>>> +    direct_map_size[PTE] += CONT_PTE_SIZE;
>>> Similar issue: we aspire to reuse this split_* infra for regions other than the
>>> linear map - e.g. vmalloc. So I don't like the idea of baking in an assumption
>>> that any split is definitely targetting the linear map.
>> Yeah, this needs to tell whether it is splitting linear map or not.
>>
>>> I guess if you pass the start and end VA to the add/subtract function, it could
>>> fitler based on whether the region is within the linear map region?
>> I think it could. It seems ok for kpti, tramp and efi too because their virtual
>> addresses are not in the range of linear map IIUC. And it should be able to
>> exclude update_mapping_prot() as well because update_mapping_prot() is just
>> called on kernel text and data segments whose virtual addresses are not in the
>> range of linear map either.
> I'm not sure if there are cases where we will walk a range of the linear map
> multiple times? I guess not. Probably worth double checking and documenting.

AFAICT, I'm not aware of it either.

>
>> And it seems using start address alone is good enough? I don't think kernel
>> install page table crossing virtual address space areas.
> Agreed. I suggested passing start/end instead of start/size because you have
> start/end at the callsites. Then you can calculate size in the function instead
> of having to do it at every callsite. But looking again, the split_ functions
> don't even have start. I think go with start/end vs start/size based on which
> will look neater more of the time...

Yes, split_ functions just pass in pudp/pmdp/ptep. But we can make them 
pass in "addr" (either start or end). For start/end, I don't think it is 
going to work well for split because we just pass in either start or 
end, never both for split, right? And we know the size for split because 
we know what level we are splitting.  But if we pass in start/end, 
"end-start" may be not the size we need to deduct. We need check what 
type it is, then deduct the proper size. So passing size should make 
split much easier. We just deduct the size for the level directly.

Thanks,
Yang

>
>> So the add/sub ops
>> should seem like:
>>
>> static inline void direct_map_meminfo_add(unsigned long start, unsigned long size,
>>                        enum direct_map_type type)
>> {
>>      if (is_linear_map_addr(start))
>>          direct_map_use[type] += size;
>> }
>>
>>> Overall, I'm personally not a huge fan of adding this capability. I'd need to
>>> understand the use case to change my mind. But I'm not the maintainer so perhaps
>>> my opinion isn't all that important ;-)
>> Understood. I think this is quite helpful IMHO :-) Thanks for the valuable inputs.
>>
>> Thanks,
>> Yang
>>
>>> Thanks,
>>> Ryan
>>>
>>>>    }
>>>>      static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>>> @@ -559,8 +631,13 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp,
>>>> bool to_cont)
>>>>        if (to_cont)
>>>>            prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>>>    +    direct_map_size[PMD] -= PMD_SIZE;
>>>>        for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>>>>            __set_pte(ptep, pfn_pte(pfn, prot));
>>>> +    if (to_cont)
>>>> +        direct_map_size[CONT_PTE] += PMD_SIZE;
>>>> +    else
>>>> +        direct_map_size[PTE] += PMD_SIZE;
>>>>          /*
>>>>         * Ensure the pte entries are visible to the table walker by the time
>>>> @@ -576,9 +653,13 @@ static void split_contpmd(pmd_t *pmdp)
>>>>    {
>>>>        int i;
>>>>    +    direct_map_size[CONT_PMD] -= CONT_PMD_SIZE;
>>>> +
>>>>        pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>>>>        for (i = 0; i < CONT_PMDS; i++, pmdp++)
>>>>            set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>>>> +
>>>> +    direct_map_size[PMD] += CONT_PMD_SIZE;
>>>>    }
>>>>      static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>>>> @@ -604,8 +685,13 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp,
>>>> bool to_cont)
>>>>        if (to_cont)
>>>>            prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>>>    +    direct_map_size[PUD] -= PUD_SIZE;
>>>>        for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>>>>            set_pmd(pmdp, pfn_pmd(pfn, prot));
>>>> +    if (to_cont)
>>>> +        direct_map_size[CONT_PMD] += PUD_SIZE;
>>>> +    else
>>>> +        direct_map_size[PMD] += PUD_SIZE;
>>>>          /*
>>>>         * Ensure the pmd entries are visible to the table walker by the time


