Return-Path: <linux-kernel+bounces-736657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A946DB0A018
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54C25A0868
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D194F29B226;
	Fri, 18 Jul 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nFhjqMq2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nFhjqMq2"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA329B204
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832267; cv=fail; b=KR8hBs7pIx+BXQr3s/NsUSgytHzX7FC02erpZLqXFgCVHvcS/ZTzLvWKW8PLRyuASH1ePkR6pFHemWhSAvI66NNYYPUtv9TDi/xzdOrTJAI/xkvpK//TqTZHFNXMQMDVLB4Jiu1isIJGVj2m4Wfdijrkqklsft6EQYCMlUBtYo0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832267; c=relaxed/simple;
	bh=Zd76V0CcH+8QNi2q/cqHpW/zWrDMX2f8xkFwdPLdNic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNjD7eGBkj5SSeQNeib0HdmfVx0r7kbWnv4n4Z52eKxMq91D/U5Yu+b/2YTKVZ1UbTIRPSSf2EYYydZ3+VPTNxAXYp+yUe9rbkYFplth2tMjGTLReRuZcEldzI90DenzDfgQErBhx1mfBAd2dhW30NXWxzQHffMXX9AyVAuQs9M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nFhjqMq2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nFhjqMq2; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FtI8wCZDuxvB6/Uiu2OSgW2HPHoeaXC0n9jMATdwgFtX7sIYgFkWRW8a8u/4RwoJOu32cFnadGRFQfooiqF2uOvOKgyE73unbOytIQ+NX/EjAbEE5UWN5gjqqbPu4/FnqK3v5fO8Wg32k70e7wyeQmY3uo6SsEjLG20DM456gV3H5qy244DFILOrcktE0mBkY3+Am7fnXuRO9NUIAPf/1yw3K8niRuJ52cHSTABYelXA2LCbFAUMGxj30jRemzzNSsKgDwAiANFJS9NJA/O6hDB0+mSWwneh01PtDAlWQ/MYNyIz5K2wUYE9vELQ4pDSNi2KoCLtbmNpTrkfUVCvsA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9aqW2SdN1Y+M9QbOe6GErxTEdf24jikgcnHiCKVxnA=;
 b=MHaa1OpHbf7Dr9mBSxTs9jO9iGshMUFncwN1g2dpAQVgYN/ygcbx5QeZYy7Z6xgwyRWPqa8/PuhDB6/AAZT98vwt7bNPo3TTJmWEfpxZ9ElALnhICHwKzuzqMFGE6SG7kRvR3X2Ekfv2cEN/PmaOCAt1B/yzM4jtUGbXP2yAC3L95KneHGu4H2H9Y7IRvKOxwwMLkQOEaaIg0O+oeIFN2l4KAPs8gWJsp8CK0rItiCl0ZkjeMZTqggTBvasToaI20EFPwOhdGMs3XrayfwW/f7o2ylDJKzvcxso6bi3z0+OKqJk9UWkz/NRK8RfMx58AVjRbzLrHXW4CtxTgmEI9JQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9aqW2SdN1Y+M9QbOe6GErxTEdf24jikgcnHiCKVxnA=;
 b=nFhjqMq2VNROq7B3dvnTAhaz2i+sJaaiI8KB1Ss4qw8PuZhQSNsxq+6reGv7nFXt9AW4oiMdQapwU3d9fsdhmZFxAfFOxfzfqic2A/ij87Sfv8P2xCMMcrLITrY0ROtaswfhDT8hIOmTCm4F2+oTU65CT6zJWpgW5sYqdhj445E=
Received: from DU7P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::21)
 by VE1PR08MB5646.eurprd08.prod.outlook.com (2603:10a6:800:1a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Fri, 18 Jul
 2025 09:50:59 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::5b) by DU7P250CA0006.outlook.office365.com
 (2603:10a6:10:54f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 09:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 09:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ0MyYfD82x1biDEDYL+WKw3T78ZASUh1d+RH1gFJwkLCsMIMwJUHRVfhTPq1HQ/2gUHwWJRxmtVnK8c6SbFN0BQ2WPlA09o2kfJfhrMYZfsHycdxHH8WlgQn+1RAAga1dMDpHqxJkhVdBbd/uxGl29GskVcIOUalUM5JKV6eoAlI0qZ9iPZEkKUKS5fRuvA54WS1B5F0odjdD4xFZiyzDaTv9zCXLWvNIsJn34pWn/O6nTeOGKZz60OKe6vsTUOK/3A4nkoSE/7TVvulgEzV0A0LgEeSBBrWXMVE2l2IkARKJ89P0m4fKLtIfRlgfK4RDCOEzngFUPXZcmAbrYRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9aqW2SdN1Y+M9QbOe6GErxTEdf24jikgcnHiCKVxnA=;
 b=kolepzzE0HpTXl9PbQuIMVOQvZFXr3tCtT63SpE6O7d0woyYIZRNJkJfR7F/Nefs/V5mJKX2cYLYJkGuA6xc6oznIB8VpZ4LYt9eWE+BqpjN2c1jdoJ9Rqybe1ale3milNkVIwCDNWjcOn0P7l1CdDFw9pSAHVPiMwkcOfNjZEyPvkemRpXyXx4n4utH7jE0fAHPghsmEJNW52Q8mUuKKRYcdSTDfut81RLfs5Y3vbUPBkeox2zv8IAP73CwLEqh0twnJQSxtfHOFD1FhYFeCbbV0lt2Fy+wZVzqTsRThkkXQJLoKDRovHCLBsz1GPLg7C6thgFUxeFJXGZaMV16Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9aqW2SdN1Y+M9QbOe6GErxTEdf24jikgcnHiCKVxnA=;
 b=nFhjqMq2VNROq7B3dvnTAhaz2i+sJaaiI8KB1Ss4qw8PuZhQSNsxq+6reGv7nFXt9AW4oiMdQapwU3d9fsdhmZFxAfFOxfzfqic2A/ij87Sfv8P2xCMMcrLITrY0ROtaswfhDT8hIOmTCm4F2+oTU65CT6zJWpgW5sYqdhj445E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB5PR08MB10285.eurprd08.prod.outlook.com (2603:10a6:10:4a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Fri, 18 Jul
 2025 09:50:24 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 09:50:24 +0000
Message-ID: <fdd6203c-dd9b-4c33-98d7-255f97973ad2@arm.com>
Date: Fri, 18 Jul 2025 15:20:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Optimize mprotect() for large folios
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, david@redhat.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 will@kernel.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
 peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
 baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250718090244.21092-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::18) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB5PR08MB10285:EE_|DB5PEPF00014B9B:EE_|VE1PR08MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 780d775c-601b-4303-bd86-08ddc5e09934
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eWxvRTdwd1ZMSjRmSjNad2YzS2QrVlFjSEc2czJOSDlBVnNpQXdFcUo5bGxW?=
 =?utf-8?B?citEUUpyeWozL2JrT2VreStlTUVCRHUxc043RzZCeTlSaWwyRWo4bGFzMTRZ?=
 =?utf-8?B?dGttNVZYcnNhR2VvcThud0ptNExXWVFOYWd0aXNraGRlemdtUXRUZ3NNMVg3?=
 =?utf-8?B?RThhdWxNbjBzWG9rM3krYjNFOUhqRVRLZVl0OGsvVEQ3T0xXaVVjK2ZUaTg0?=
 =?utf-8?B?aXA2NGprcjhra1BGTHRPckNQSEs4VUMvVXg0d2lMNitNejFrRGhTVng3bjdQ?=
 =?utf-8?B?R3hWbGd4eU9lSG9WOHJaNGVQSHY4YXQzMFpPa1pRVGsxb1A5Yk93TllLbURw?=
 =?utf-8?B?b3kyaE45YU5OdEpZejg3Y1grck1IbkRMbDJ2aUcwUE93bUdocmpHeTU2K2Zz?=
 =?utf-8?B?MlMrbG53U0dqdjRZaVNURnJPcU50bDMzNFRDTFZ3b0dKbjhxZGRISkY5TS9S?=
 =?utf-8?B?YTJUK0FkQVhPN2dvYkx5c2UwYW5HQSs5ZWhwb21odnEwUC9UM0c4a1F5NXRq?=
 =?utf-8?B?eEM2V0VPNzVEMDdnR1dMSUhTeWwrM2JCdzlmZHIwcXZHZzFac2hpQUhqVG5W?=
 =?utf-8?B?TTZlQzlEZ0xTSnBkcnFIM3Q5UFU4TDRyc25XTGdEaW9rdGtaUkd4UElBajls?=
 =?utf-8?B?dURSbTQrQnJmeVVCdTBBTUFaVk12SkU4UzdZUDFGN2E3SDBTQ2NoR0plR3di?=
 =?utf-8?B?bkpDc1AwN0xSWlNYaTExd2JRK2JVYzBpTm9uSk5aU3l6Mlh4QTBBd3R4U1pO?=
 =?utf-8?B?aksveGtlcFdGVmxxNkVoVHY3eDBuNktTR1VDUG5CcURBd2Ftbm5QbHZkZlBD?=
 =?utf-8?B?TDB5MXozU2Fnb1gwT0RZT0pYQTN1OXJMRnUzUG9DSldQT3VOUGQvNXk2NXps?=
 =?utf-8?B?c3JLVjNBWExSdGlPZy9UNjUyQjBqTGFmU1dMWUNJTUh5RUpjUjJVdVZ0dWxP?=
 =?utf-8?B?eFFrUys1eWJoTUlJbjh0Vm5CYzkvQndpbzNmTDk3MjhDalBuZ2IxTDNKZ21i?=
 =?utf-8?B?WHpoNUl4UG1KY282ZERHc3dGcnlHRHoyczBsZjRnZmh6VWZsNHZucDlCQVBF?=
 =?utf-8?B?MWdrTTR6Szl6N0pRRlZBVktBY1RVSTNPUlBaVVVsUFpaaUdYME9HZDVXRExO?=
 =?utf-8?B?TUZucjgwN202dVA2K3l6TVNFY0N6djNtTHlaMjRlZi9IKzlmVXNpRytWaCtS?=
 =?utf-8?B?SGlQbWdPMTdIV2gzOFFCbWk2blB5WE5FcjNtdnNhWVdsYkY4UUxQYUU1Nll5?=
 =?utf-8?B?Y09hbEdGQUZ3TmFYR2JES1k4SEF6YXBia1lVOVpxLzlnMXp6NE5iYkZPTHBC?=
 =?utf-8?B?MnlpRlg5UjhQK0R6OUdRMzh2MEpaSUJWS0ZHSDRMTVlDWnh5R21jSGJGaW92?=
 =?utf-8?B?dC9LRFYzMFB6aURJQ2pRaUcrMEFmQ1k0R1BObnl2UUNWd1o4aDZ0eDZXOGNL?=
 =?utf-8?B?cTM1eEpGRnFQRFZyTkk5QmEwY3c4UURxMnZIdFJyN1dOUmZkazQ5VkI0YWE1?=
 =?utf-8?B?eFptVnRjemI5RmRrRFBaampnUjRvVUFLcE41U1prbldZZkV4V0hTYVpncENS?=
 =?utf-8?B?T1JUSEtXOWMwQjl2R2FZVUx1dGhzYzMzRGtEZGR3Q1UxczRGeTIrNUp6dCtk?=
 =?utf-8?B?aHh5b0gySEZuR2loOG1ZYmlLdGp2SHpPS3N1VC8rWjhxMHRUdG44WTRzUGlw?=
 =?utf-8?B?M3pNb1dwVTZLZ0x1WDJxTnpqOFRqWmdlU0Z4dU5xOGE4amFzZEZKZzlja3N1?=
 =?utf-8?B?Q0c0bFk5eHJEVzJyanJ6VjBRZVFoNTBkeWVacXprUVVxK3pITUxmeGNzblZq?=
 =?utf-8?B?UEY2OWt5VVVRSTRrTlpwSTI4WDBiYmR6M3kwM3Y0OVZQUnphaEVRWkw5amtt?=
 =?utf-8?B?OFlDRm1qcjIxa2pEd3NrSnc0YXQrZnQyOFlnRGFTS2xrK25wSXhZaXkxeE01?=
 =?utf-8?Q?vLUbD0xPjYo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10285
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b1b0cc11-01fa-4c49-6f75-08ddc5e083e6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|35042699022|1800799024|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em9nNHFGTnR0K3FsbERjVWl2ZmpEMVdXMUZqeExzZllkTTFpUjVsVk0vQ2lC?=
 =?utf-8?B?QWNLVXJyMlpmYWJiZlVGUGdqbDI1S00yZmZTRXlPbTdDakErK2pFREhXaVQr?=
 =?utf-8?B?VVRFbzRNQTRrUmUwc2VFcTRyRmF2MmJDTDZhOXh2bS96VzJqNnJXbHlzZFZU?=
 =?utf-8?B?TFJiTUluQitmMHVCZXNqMVBPYVJ2OWo0ME53UUprd01iQ2tFemM0TFVUUGRz?=
 =?utf-8?B?Nm15eXhxZy9WSUI3UUJMSTk0dzNGMm4zNWhBUGFMeHhYWXUyb202c0lqdDJV?=
 =?utf-8?B?U01Gd0VQODNmTUNtcW1IbDg4ZXR4S3l5ZzhWdlNRVGd2N0xVSEpvWjZIekRF?=
 =?utf-8?B?NU95N3Q4S0V3RmFEenlwMmRSRVptOTU3Tys2bVg3UHpLVG5kWTRoQTJ2Sk5C?=
 =?utf-8?B?bmVUN053dGo4U3NGMDBTc2czWTVFRFZGSmlON005UGs0cUVtRlc5Tm1ySHd4?=
 =?utf-8?B?aFlYTWJ4d1V0RlB4TDl0amN3eE1tcE05a3I0b3RQU21aRDdlTGtYaGZtdGpu?=
 =?utf-8?B?Z3AwRE40TnlPbEZKUEYyM3VhUm9ES2tpYkdWdW9RaHo0bTJ3SHF3L3VhT0pp?=
 =?utf-8?B?Zk1Jck1kSlExT2JFMWxWZUdtQ2Z4K3pMYjhWQ09ZekUveWM1Z0xlc0JXV2ZD?=
 =?utf-8?B?RE9GckcxdTFBKzVrT28zRUQyZGFlT25DT0VYdXg4RUY0U3MySHA0QlVQNUpa?=
 =?utf-8?B?RERJMDRXdnVoMlBNWkpYZDZ2WmdKdGs5T1J2a3hyUklDaXAxb2FmT3ZNYzlG?=
 =?utf-8?B?cjRzK3dVejNXYlY4VjNvYkFtM2JvVmhUdC9wNUxMUTM4cTgxS1IvTHZ2THAr?=
 =?utf-8?B?NVQzcXQzdzd0bVdFanJMR0s1Q0J2VStpZ3FUSm9NYmFRZ1AwZE82dlRBdHY3?=
 =?utf-8?B?MkVTL0JLWVhMVFhMQWJCODNYNmF4WGw1OXhubUFtRGFsUWI0bWxTQ3JDNnNq?=
 =?utf-8?B?Q2FvQnpIeFpKYy90aTNNc2VZUk9seE83VnhzODRtOGxSdkc0SnhMVks5andZ?=
 =?utf-8?B?V2xWVG44NmNmSitXK2svbnZDbGkrRzBFc01GRDhGT1o2akxuOUs3c0dYNkxs?=
 =?utf-8?B?RGpTL2JQQUhsZmppWm9hOGtvc1l2cmRCWW9NbkhTMUdiWitPRWFzZ0F6R1dw?=
 =?utf-8?B?YjZ4bkNqT05pYW16ZkhVMy9KcXkrM2VnZzB4T0FXZU4wczVoL213ZzVMVWUz?=
 =?utf-8?B?Wk1PK0xvc09EbFlxVlc1RGFUdWFHWDJ6UWpjb2p0VHErc3NNcUY0ZGlvTEZO?=
 =?utf-8?B?R21HRWtFeXhEb09WOXBmaDJYbTd6bkkyZ1Nqa1dNMVVrNUVvSjBsNGpkVmV4?=
 =?utf-8?B?bDVLTUhhOVhCbVpaTFdqVlhrbDZTemdUdk9uUTRWN29Scnk3WVVvWFZBMHV1?=
 =?utf-8?B?R2ZYQVJySjFvakN2SE9pWnZBYWQxZVQvMjFDN0tEMTViVE5tdnRwT1phS1FF?=
 =?utf-8?B?ZG93b1BaTUYrVmZtU2lvT3hCOUE4RTNiTlZVWEdaNFp0d2lmMytUNWk0aDF1?=
 =?utf-8?B?T2s5ZzEyNGZnclpNZlQvSU5iY0RzYldaRXVKZ1BXYUtBTTBndnVtcFZsWmZi?=
 =?utf-8?B?Tmx2ZEVhSUpjd2JmUnJnZHNIenNYR3NvVlAwRnhqNmtERjdtaTBjR1dZNnNZ?=
 =?utf-8?B?VFRXbmZWLzlWcWRXZThIK25rQThxY3k5azltdU9XT1EyWm5DbC9pWEF0aUZ3?=
 =?utf-8?B?ZnFFWHB4VVVUY0ladGZiWmxUekJNU2xkelFkVEFBbmZlLzR0VnFoV1NVekpT?=
 =?utf-8?B?T2k3S1dRVjBsMjhCRndRdTBZNXA4WG94MzdEL3lyRVlWOWI2dzNQVVNlbitY?=
 =?utf-8?B?SmNzbFhrNHBYenhHeTYvcmZ1Q0dwd0RNYVZURUFiZXJZZmtWS3RYRUd0a3My?=
 =?utf-8?B?eSs0Mm9GeDFmMXdJcFNzT2Y3Zm9CL1F0VGphWG9BS3haWjhQMDl1c2VnWlNE?=
 =?utf-8?B?QWRNWTFHZU5YYi82VW04d0lOcXZWRHJ6blluRjRUY2JXZlBFNnZ6cXZ5dzBh?=
 =?utf-8?B?V1hBSk05RGxwWFNmOE01aHlTQ2NsRGFrbDVHT3ZIS3NMSURzSytnOGwrWVBR?=
 =?utf-8?Q?0rzqab?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(35042699022)(1800799024)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 09:50:58.9135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 780d775c-601b-4303-bd86-08ddc5e09934
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5646


On 18/07/25 2:32 pm, Dev Jain wrote:
> Use folio_pte_batch() to optimize change_pte_range(). On arm64, if the ptes
> are painted with the contig bit, then ptep_get() will iterate through all
> 16 entries to collect a/d bits. Hence this optimization will result in
> a 16x reduction in the number of ptep_get() calls. Next,
> ptep_modify_prot_start() will eventually call contpte_try_unfold() on
> every contig block, thus flushing the TLB for the complete large folio
> range. Instead, use get_and_clear_full_ptes() so as to elide TLBIs on
> each contig block, and only do them on the starting and ending
> contig block.
>
> For split folios, there will be no pte batching; the batch size returned
> by folio_pte_batch() will be 1. For pagetable split folios, the ptes will
> still point to the same large folio; for arm64, this results in the
> optimization described above, and for other arches, a minor improvement
> is expected due to a reduction in the number of function calls.
>
> mm-selftests pass on arm64. I have some failing tests on my x86 VM already;
> no new tests fail as a result of this patchset.
>
> We use the following test cases to measure performance, mprotect()'ing
> the mapped memory to read-only then read-write 40 times:
>
> Test case 1: Mapping 1G of memory, touching it to get PMD-THPs, then
> pte-mapping those THPs
> Test case 2: Mapping 1G of memory with 64K mTHPs
> Test case 3: Mapping 1G of memory with 4K pages
>
> Average execution time on arm64, Apple M3:
> Before the patchset:
> T1: 2.1 seconds   T2: 2 seconds   T3: 1 second
>
> After the patchset:
> T1: 0.65 seconds   T2: 0.7 seconds   T3: 1.1 seconds
>

For the note: the numbers are different from the previous versions.
I must have run the test for more number of iterations and then
pasted the test program here for 40 iterations, that's why the mismatch.


