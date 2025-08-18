Return-Path: <linux-kernel+bounces-773725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4325B2A7D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0870B584E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CEF2FF650;
	Mon, 18 Aug 2025 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T/1RvPDK"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B452D8DD4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524839; cv=fail; b=Jd01Je1GE421N9u+/nGV0HdTTmIF/62rlOIefWublCsBH0Z4Bd2Ai5t3sBVjy4Ur1FhWCCTEQKmIljtkewe00E1rJpCJHH7mvv8j1p+p8biHKbe5HFrUQ9sn0IaX/n4H+B5AaZBNNxkegJgj8rnpKWpFMToSiudyNhr9LxcKIYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524839; c=relaxed/simple;
	bh=n4H/5PCzKuPb248fJNVJJnuKw1fXcL8Doj1Q2c6lBns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GYwzsCkVAW8B/66CnzUMjviYW0kJIlz0FTIAlcFjrG9KeN8pYJ/0lWuZBWq2Gf/IiVHqp5zrUcAI6IJu7FyVEQW+o+PnxvpX+6J3bh7xlS+Too4bXN/kZmJ5uSoeTxZaBfSiubFpWa94niEv7uiDM8I/uEWUKv+GQPposb+8uhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T/1RvPDK; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FybmPpyU1tB0Yghn0xfeOpDqP2Sy0hwyXBX4K/cio1KhxeSCIBEreMV6CMDeIqZuA5FSUiYu1txOgqLy2xpNXP0psC8wx7E6b1JbbBo+eW6jVagnkMTwzLu9DBILoVQW/vbg0buJn1vY6q0To9jCTW7BG9ezulrfIkQuNeDJ5Q4vcvTQN8yVKkrPlmmnoQHf9bOowPwvxcLA6QJAfPlKeQKd4cIDyZXT+o0jV+wI4W1jhLDFlsUs4awgOcBPN819eEt86rTgfgBOz/BeM+iYpFTdoxBDTkgaAieBMroBkgbhYW2+szttcephTj7h3eUm+uorVAT7LoILqEQKue4dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8npfbQMbJNFRGR7RSAL3qlK+7guZeL7lcHnuHR04kjE=;
 b=oHOg2Tb3rpdFvFAIX48IkwsXazJQeGwOCxdNrpl1vSrHoYcE9o0Cbumj87cKkdT3Uu+law074DWaGSpBJkDGc8Mt5M4AZPYuseuYy21+EUsbdYy0p6nzhIWn4kziLdpDuqcBLxyn7QYMEtIsCbkqvM6l7u8F2c9PVqOJFBP/QA29BgoNV97DfYj81kyfYpgtZcUzi8nhdaZPslH/7EdFs8Y3D8yDMoYCviUTaqkN/hb5lmzWG4Wjmloi6k/n7D8vhYEf7EtdAFSFiP7sj0k8t3UufhSxeBBDJEYs2BnMJugFtvRQcuzsH0rLspmeYogkuLGof2HMeuPSYYNHwML/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8npfbQMbJNFRGR7RSAL3qlK+7guZeL7lcHnuHR04kjE=;
 b=T/1RvPDKoiuiIHDsktZ8hy13WP0RfXD+m1gnRdi8NNkt4omZYuYgNYb/19nWeG4kSHBP1qdJGWwHyC3azorEw4Wn6MdnpM+/k46gSNJbcZfdUL7M44ekKcs4BVXYaLMB7MWdOO/PkVh8p2rSdmmUgHY7Rqq5iVlJkWOMtglAW38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 13:47:15 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 13:47:13 +0000
Message-ID: <26004db5-431b-fd28-9497-4e48bd6096c3@amd.com>
Date: Mon, 18 Aug 2025 08:47:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [sos-linux-ext-patches] [PATCH] x86/sev: Ensure SVSM reserved
 fields are initialized to zero
To: "Nikunj A. Dadhania" <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Joerg Roedel <Joerg.Roedel@amd.com>
References: <7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com>
 <4918f481-bbee-4337-870d-e62d8d2d86cf@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <4918f481-bbee-4337-870d-e62d8d2d86cf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:805:66::48) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 7866f24d-14b3-46a0-b335-08ddde5dbba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S29IR1VuYnFXUHpoWklKM2QrR0dMamxBSEVscDhjOXJzQXZnMVZEUVNvRlNB?=
 =?utf-8?B?K1BGVk5vakE4bXM0aFJKY1QxeEljV0o0UDBNSkZiQW5pRHc5cGkrbW92SU50?=
 =?utf-8?B?ek9DSW1Sc3ZKdElNVUVocFk1bEp3a3o2bGRiUlNubmhqaVJHVkMwVlFMNXRx?=
 =?utf-8?B?dFA3ck5jcWQvSWpwNXlGQVFkL0c1aStLMVhpQ2pWOVQ4ME9udCtBajRteVhY?=
 =?utf-8?B?WkZKTWxqNkc0SmUwK25qRlQrMW12KzJNNHIzMGJvb28xZ3BSK1Q5STUxTjNl?=
 =?utf-8?B?cFpKeXNrYmFOdWRkczNPZjNReTY5M25HZHhha29jQkM4RFNhOUhHeG11aHBs?=
 =?utf-8?B?MlYvOE5USkRiUjVBbCtWbHowRzllczJiQ1pDNUdodFY2bTBHdzBsdDNNdHVn?=
 =?utf-8?B?Yitjdnh0Y1Z4VWVPTHVFSkJ0UWJSMW9FYnhLTXJ0WGJRKzNvTXFrUGh0dWUv?=
 =?utf-8?B?WDJWZy9vQTdvRDZENjcvYmpqOFVpTytoQk1JQW1TcnlISFN4QlhDbGpUd1ZQ?=
 =?utf-8?B?K24wM3ppTkc5eTRFU3daN3FTeklkb0dtaTNkUTZlQlFaeStFRklBOFZVTzNZ?=
 =?utf-8?B?RjAxRW9jRFExTlQvOGZMMUgyYW8yYkFKVW05Y2V0WFR3U2RWVGU2c25HYlpz?=
 =?utf-8?B?ekZsZjNCK3orZ2pvOE41MW1QdGFacXFKVU9aS0J1WDJtWmI5alNGeEY3ZXg3?=
 =?utf-8?B?WWpZb0Z1WnVFeEMyUm5YL1R4ZGRXZmRqYmV6clhpcmZOaVNyOHVKcnJCeE1u?=
 =?utf-8?B?Y1pZcEcwZW9tSDVubk1sWUZRSjVtRHBFTittSjlLaXZJYXlPWEtzNjlab215?=
 =?utf-8?B?bEZIa2NMMC80RDNzdFhIN0NsOTFrOGlZekRobXdDVXhpQURDYVhLbE1wOTl3?=
 =?utf-8?B?RHFrL29taXhrazB3RmtGd2lCSEpoM1ZvZXBlT0hxV2U0S25meWVXZUxIZCtN?=
 =?utf-8?B?VEo1MU5JTXoxV2dhS1RMQmhTdUJGS1loZitlSURNaE1oM3ZCNmJpeC9RRFJE?=
 =?utf-8?B?OGFoRHJuQ2hYdkJoVUJDbkxpSDdGRkRsampsY1d4a0xCbWR6cEpQSHdhTXha?=
 =?utf-8?B?ZXB1UmF6Um1rTjNHNE9ESFo2bTArMTdmbThjS3J5U2dJbDJHS0tvdmlJbmlL?=
 =?utf-8?B?N0dodEFDSllEWTlpME5mODNheGtLMFhjUmF6d0Z1clZOWWRCUUZad1J0TU05?=
 =?utf-8?B?TWFXMy91TytpdnBJTEVwaHVlb05ZM0VIU3BhOXZzbEliUzMwNUEyZVhUUGx6?=
 =?utf-8?B?WndMQThuT3o0M0poa2NLMWswa3p1VFV5SjlCSHNIUXhVeExvajlEaHdsT2RP?=
 =?utf-8?B?dzYwVmNjY1poUlhjV1NORVNER2x3OFJLS1FxaDA3NDZzM0VXWEJzUFhYMytK?=
 =?utf-8?B?SmlZUDJMTTllbk5ZVXJ0VkdrMXliSUdrSW4wWlJQT1ZRZ3k0ci9IRmFxNWox?=
 =?utf-8?B?K2hGQ0lUU1dOQUd2WnIxT3hhcjl1WG1SMFVOa3VUaGFyVG1ZZGhhTVBWUUI4?=
 =?utf-8?B?eFI4NDYrYkd3MUhUYnFUVk5tS2FiZHpNbEI3VFd6WGNycGN0N0hqakxCUGhx?=
 =?utf-8?B?aVNqNTQ2V2VNTjlIR2J3WHU5V2hrQUtNMktpQlc2akYxTTNMbkdZVkZGYWFa?=
 =?utf-8?B?aUZTV1RwQ05LUVNWSWEzS3hVRnJ6ME9aR3dTYVpuYnFpcnJCdHE4N2JlUXhY?=
 =?utf-8?B?bWZpS1pmRFRsR1dPcWhhWnBGdHYvYm5Ya3IrRytBMFowdVRuR3pPcFNtRTNG?=
 =?utf-8?B?YmVVblBjZ1RSZkw5UHVDV0pIUXI0UWpqdDVrdkFaUWQ0ZXRDTGdkb0lEWExY?=
 =?utf-8?B?amdiUnlDendPMysrSjFYdnJ3ZVNSWW9nczNsNEE5VEw2Z3JNUVRzRDNjNFBv?=
 =?utf-8?B?S0FuWk1tUWpYbmJxNVR6SVVYM0V1djVKUFpSMXFjdlZ6VVgxd2NwNWw3WmJY?=
 =?utf-8?Q?BAjIEBtb6qk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGpSeWhRN2RGSjVpVnQxSnVsZEZ2OXlrYUN1ZjR3NGl3MDFNdTFDTGVtUnl4?=
 =?utf-8?B?SVQ0K3k2YklBVkZxSGFvdHcvZENsWXNIK3Zkc0VZOVpaS2I2NUNnMngwYkxN?=
 =?utf-8?B?NkZqSUFvWUFZSkxKY2JmQkNrN2FYTEdJVUQ1cy8wdkZWa0VWRzhJNkdkNFd3?=
 =?utf-8?B?U284ZlNNOGpYSE0xU2pidC9iRnlUYlBaZ3ZScThiZHJuN2doTitlc1k5dlZW?=
 =?utf-8?B?VmhEdkxCSnhzR0pQMWJ1UFVzUlFBWUxCYXNkSVlKWjVGSWdQaTU5L1BDNWhn?=
 =?utf-8?B?U21JK240Y251WHRra0NNSXRENDR3MTlDM0diRFhULzlWeTFaWnBUYkhoTWFs?=
 =?utf-8?B?NjBpdGU1cnpET3RUMHNsditka2ZzTkFDNlQwZjBFb2RTdkFEZUw0RERnN0lC?=
 =?utf-8?B?bnVwdmdERnRZL2txc3R4eXREL2JNVEw2RkNqekM3cGRCVCtlMnZkdFMxVzZB?=
 =?utf-8?B?OXdUaXo1NTA2SVhmcXB1VWhoSENYamhKMTdvbUNMekxvbEZHYkhqZW5QbVVC?=
 =?utf-8?B?MFJadTc4STZMYjlVcW1GNHZDS0drcnBtVHV3UVUvZzJORUp5UHRBYW5BN3pZ?=
 =?utf-8?B?RU14TUZIUnkrYWJkWWdoekFxNFd5bWZXd0RwZG4xZGVGejVrM2pVUFV6WVln?=
 =?utf-8?B?S2Rjb3R6RHFYdUFjUzYwcUpiakNMRE4wZ3ZhYm0yRXRZbnVNN01qRVQwTG9m?=
 =?utf-8?B?QjFiYnMrazdXZkEvanQ4S3A1eDRDNXd6bm53UFZsSkVqWHAvOHNJSzZ5cGp5?=
 =?utf-8?B?cUVwNWNZalcwdmVvMlpYRzdGNGJxVGt5NmxaLzVqaFRUSC8zcmNJWUhtWmpK?=
 =?utf-8?B?dCtCbmtTM3hyQU8rUkpweFFNWjdxQ0pNSXJyNUVwZUZ6VGtkclhpYkNuWHV5?=
 =?utf-8?B?WU1LQjlnVGNtOUxQeDFDeExXUk5hYlJoYXowTjhQT3RxSnpEL1R5ckpKcnZh?=
 =?utf-8?B?Mk8zNUl5TG0zdFRXLy9WSlFSK0xPL1hEaElCRUQzY004ajRSU2pCOWVzQWFm?=
 =?utf-8?B?c1lQaTU1SkVXdjgvWnlzTHd6UjV0V0RXa2pGSWlxVHNvenFNOFVQWjZOS3I2?=
 =?utf-8?B?TWgrL3pKM0JSQjRwcU16aFhqd1NOZWJJTGVRN0ZZVzlZU3k4RjVlT3Y2dkNU?=
 =?utf-8?B?YmpWMmhaSnpmYnB0VE9tMkpScVpla1YyMEZPaExIWGNOZS9VaWtuT0tYa08z?=
 =?utf-8?B?THpEQkxkbndHRTIvZk9oOGtwOHk2bXg4L2J2cm50WVVqT3JxTFNZNmdsN1JN?=
 =?utf-8?B?NFl3ZThIT2F6Sk5sbFFmUkxVWHhYcldqWHErdFpHdlRJd0dCdzU0dzIvcDEz?=
 =?utf-8?B?aEhUSEFsSHhHQ2V0SFpLWFNrM3ZpWUR0ZUhUbDZ6VmU0U1lScVI2YkdpUTZv?=
 =?utf-8?B?azllVmhCdWJRQ25raHYzUWxTamZYZXkrWTdqRUM4R0N2Tlh3NWdENmVqVnQ4?=
 =?utf-8?B?M3FtWXpmUmtXWmN2UUhPL2hsSlNLWHVXN1pScmdPWUI1SnRZOFExTTNXQ2RF?=
 =?utf-8?B?MWdTd2ZTZkVnOEtPZ3Z2ajBJZmRWd0o2UEFRM2hrMU5kMWpPd0V1WmxGd3o0?=
 =?utf-8?B?ZUh6YUxTYWZpNzFzQkhKMlRNT1NRUHpLQ0hiS2MvVW9hTG56YzJiQlNBWW9P?=
 =?utf-8?B?NFJ2U2poR0UrU3RtdXhUbE9CcFBiMnVkTmZkbmFEUjdqZ2o1YXRuV1pKcCtU?=
 =?utf-8?B?YlUzclRLTjFrenVYSHd6N29UdUpYQUh6MERya1NlNlpwcXBEN05aUTJEbmNn?=
 =?utf-8?B?eVBoWHVjeXVidGZkaXJkS1lrZEYyWjdxUkpxLzBIbkVZdEFXdVpvYUg3ajBZ?=
 =?utf-8?B?dXVic3Q3MjIvaUF5UmxCMWx3bnNWNnJVYk9ZeUZGU294YTQyaDJJNC9xOHVC?=
 =?utf-8?B?R3p4OXF5SGJ1ZkUwbm5jczBkOGpMSXBzemR0TmpZWDVzd2NXeDRNWTlZT3JS?=
 =?utf-8?B?bjg5ZTlrU25xYU5GQmdLVENMTzZnQkxiK3JlblRLbW5NWkR4NGFmeExnWWxI?=
 =?utf-8?B?TDlIem5NL2lacG5FM0dSeVdRZkdtWlhtV1VHN0hJOEFzL0tMendxWDBMUUFY?=
 =?utf-8?B?Vm0vTC9mNGQwN3RVeEh3QTZ6NHQ5eUhXOG52YitsQXZRTElzQnRJYjRmaUg0?=
 =?utf-8?Q?Ozctxb0A9b7xY4Iby9DZY4I8l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7866f24d-14b3-46a0-b335-08ddde5dbba5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:47:13.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoHEtD9uyIy33yrWB9wEwV2xSL0i1rSZf2Q8FFzPEMrsb4Mbj8xZOYMV1C+zXHz7y60QxthOz+n7VA8d694xfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

On 8/18/25 01:16, Nikunj A. Dadhania wrote:
> On 8/13/2025 8:56 PM, Tom Lendacky wrote:
> 
>> In order to support future versions of the SVSM_CORE_PVALIDATE call,
>> all reserved fields within a PVALIDATE entry must be set to zero as an
>> SVSM should be ensuring all reserved fields are zero in order to support
> 
> Does "an SVSM" mean here an implementation like Coconut SVSM ?

Yes.

Thanks,
Tom

> 
>> future usage of reserved areas based on the protocol version.> 
>> Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/boot/startup/sev-shared.c | 1 +
>>  arch/x86/coco/sev/core.c           | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
>> index ac7dfd21ddd4..a34cd19796f9 100644
>> --- a/arch/x86/boot/startup/sev-shared.c
>> +++ b/arch/x86/boot/startup/sev-shared.c
>> @@ -785,6 +785,7 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
>>  	pc->entry[0].page_size = RMP_PG_SIZE_4K;
>>  	pc->entry[0].action    = validate;
>>  	pc->entry[0].ignore_cf = 0;
>> +	pc->entry[0].rsvd      = 0;
>>  	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
>>  
>>  	/* Protocol 0, Call ID 1 */
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index 400a6ab75d45..14ef5908fb27 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -227,6 +227,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
>>  		pe->page_size = RMP_PG_SIZE_4K;
>>  		pe->action    = action;
>>  		pe->ignore_cf = 0;
>> +		pe->rsvd      = 0;
>>  		pe->pfn       = pfn;
>>  
>>  		pe++;
>> @@ -257,6 +258,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int d
>>  		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
>>  		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
>>  		pe->ignore_cf = 0;
>> +		pe->rsvd      = 0;
>>  		pe->pfn       = e->gfn;
>>  
>>  		pe++;
>>
>> base-commit: 4c699535a3d483562354432a945a035f15dfceeb
> 

