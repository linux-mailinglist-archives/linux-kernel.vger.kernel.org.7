Return-Path: <linux-kernel+bounces-762453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2188B206C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E0C1893A45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0262BE64D;
	Mon, 11 Aug 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lz+TXBxF"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8D2BE63F;
	Mon, 11 Aug 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910149; cv=fail; b=G1hiU+QLq/WYWMSA93N+nFQDCMsv5lQkJcCt1iImnIp0k/6sK0wOxZgGlsdcswyg97jwOxrfw8vGpbuBd668E0PZqyeDNCeso63BG0O+o0X/W/TaaNUplvtxo60ZGC/Y6bw04rMqNAPaqQdFKd5fOXX6BnFn/WDCijrqN1Wsybs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910149; c=relaxed/simple;
	bh=h6yjsFJtQ+tuXYdS1Zgn3oSl1WcxoKVY4Qbgy1cRV64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KZkdGtioQmo64pOHaA8zcXvWcevhjxVNH9zl/iWDsmPW16uBpQnUfj8eNheKXd01mjtnYIFtL0uHAeT6rp+i2eCVgyy8Wy7S7ONSAts3ZcBpklUQdHxu7AkZMh3lOld4wnx/LFQ3YdhM1GO5eVZe+vbCg08q6VAJBW5I/xa2Yi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lz+TXBxF; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuNz3r8rqAmiOQqoahuNG66Z0zyWmmygGbRBp3R8VixHQ7gaW0BFDr/XGSPGdd8qu1FbOP3OgjxffMl2CgiqH6qRGD57TtS5UKE86029sFyXbRxnKnB+qdAvW9ytQ24CPJwFsGc1mhbztKB9NdDJ+/TybBMnnqtuR2G/+Xu+X/bqvWenoaWfnwxREoS7kxwrpLs+WDkYa1O7ptTxntV9s4GP8EdWJZyrTJzgqk1oD5iNvMuKSSIN2CmAS+trlc4kwyWnda7g7p8Y4YF5al2HoF62d4Ev0M0KO5vjploKNlAtIrdq/711zAHQWLyI0intuXpKa0z15UVmIOakwIETmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZTon55mvrdmOQhIIVRn+y0uwiqbSc9REAEE9lxfdB4=;
 b=wSyYneabsp9awfWU6Vmixp/7OC0OZdwZp2oXVwVFyKLy3n/FbtUtDpJfQi/xM7sFWHR+Ago2Eb0DBuQGtCMN5HfQucHe4shP5yafrNcvHDkJD11m9KbjXLivXkMZD5Qm9O/QoAoXssPeiZubvY58V/sb6WxcWqqeTRDv9KpPAoVy1p+X4+YqCiphL2S2JiDUlr2Fi6wqGOS50qzkcXKs45EzzBweCXvfForCiHw2W3flG0jG456NNnTV73j7+AeOQFafafIeRr355ZGkyC+wX8y+VAerUmY/9EZIp5MjNDCoUow2b8DIpXYz/QT6DjA9qjof3Wd5Wq22A5h4qF46Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZTon55mvrdmOQhIIVRn+y0uwiqbSc9REAEE9lxfdB4=;
 b=lz+TXBxFmlUrt2R3fUgVzCU2qUMriyfXhT8+UUrI65HyhhucJVfEPEzaql87GlTgJ00ncJxiVMBhK9M2C2zl6+WHKFrlM2reUIyD0VWEyvxLgAMhpgylRQdZXH/RtvSjltERK5pwK0OdxaZ4cve7wpJN8pk2PGjDvrKokvvxYd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 11:02:23 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:02:22 +0000
Message-ID: <cb57d136-b2aa-4433-8b44-c66e39b1c834@amd.com>
Date: Mon, 11 Aug 2025 16:32:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] misc: amd-sbi: Add support for SB-RMI over I3C
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 gregkh@linuxfoundation.org, arnd@arndb.de, linux@roeck-us.net,
 Anand.Umarji@amd.com,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
 <20250728061033.1604169-2-akshay.gupta@amd.com>
 <039f9a44-80df-4795-b18d-5fc9c488ca37@t-8ch.de>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <039f9a44-80df-4795-b18d-5fc9c488ca37@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4324e991-3866-4ae8-983e-08ddd8c68c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2NtT1QwdjdzNTRJYkFNRlpVQ0FUeDVvak56ckZLaUZKbUhIK1ZDQXp3Uklk?=
 =?utf-8?B?NHYreDV1L1hhcTZDVy8rbkxsUXYvdzhucUQrdWR4WThSVjRrTmZ3dG5hblQ2?=
 =?utf-8?B?TDIvUUcrcXJqc2NnQWxmaitTek9aS2w5bVdVRTJaaVBkNFVNOGZseHowQ1VG?=
 =?utf-8?B?Z2FVY3R1MUJHM0M4UVFJejl1cVVNNmZWdkVraHlYeFZLLzc4aUFnbGI4d0lM?=
 =?utf-8?B?TkVkaUNUM2IyYVJSemdoeW0vODVuenhGRXc3bVN5d1VGU2tXT2ZJYndzVnNV?=
 =?utf-8?B?MDEyYS9abWYvcFZKTjAydGtvVFkwVlcxMEtCc3NHMlRGdVR5YWFxQzR6TXZG?=
 =?utf-8?B?a1IwTjEydGI3NThPSnI3T0NrQXpvck1UK1R4TkhtUjgyOXlSenQ0bDJLQ2t6?=
 =?utf-8?B?RURJOXdvc05HWFZRZDNpNC9rTFV3alo3SjBIUjQ0dWcyeDBEQ1NTd3ZjNFVU?=
 =?utf-8?B?Uzh4ZzlQMXFuQVhmQTJFWG5qelFFMEc1dlZyanZpTDBBMzdxWVc0VmlMS1pK?=
 =?utf-8?B?SW96Q2tDaHViSUNEbG5Pb2dSbjhKU0pCdmFWZUtidUljVEpMcGo0a01yTkNU?=
 =?utf-8?B?MktQcmR4L0lEQVZsb0hZN2RoS0ZwSGY1ZVNkRDhUQk5xWHZkTjNoV2ZlMGQ2?=
 =?utf-8?B?YlBoRjZWRWhhQlNvQWp6TTREUTMzZHRjRStGcmVNM2w3eFVDNG84dDVvV3Na?=
 =?utf-8?B?M2NTOGlKbko2b0lZTTVTQVpEdEZMYURiTXIydTdzWFZ5cmNsMWxQc2JFdVlI?=
 =?utf-8?B?NFpPOHB6eVhFYk9sUzAvYzZLcnByK2UzR0xVa3NRTW9zWGJrZjA1c01QSGFy?=
 =?utf-8?B?Z3RJZUUrWTcyRTYrYjRvQ1JHejAwbEpobURKWmJ1blNoT0hMWnFNUzh2MjZI?=
 =?utf-8?B?UTVNVGgxQWhEQytuK3VnSklldUVZSmJlSm5IUUpvdGgvTXpEY09vTnZCS2Q2?=
 =?utf-8?B?VXdqcFdweEdZVjZzaTRHdUtyMlZ0OTEzeWlKMFppRVRqd3hWSzFETWx6WG9t?=
 =?utf-8?B?amRDT3J6UjJDSElFWVd0MnBRaWRWYjZqbW5vbmlNNXpDTlg2N01Nbmprc1NE?=
 =?utf-8?B?RWtBcHB2MlJyeTNRODhzWGJsM3BKSUgvdy8xKzhGeWFzVy9DdDMwdzRuOHZ4?=
 =?utf-8?B?MlBacmZ5aUMvbWZUQkFFMWdZSHU4M3JuYi9jdmVtY2lGU3AxQisxWTNyNjMy?=
 =?utf-8?B?ZHh5d2hxYXpObk9QV2xCVGYxcWdFb0ErVTh1NjMxckNQcEZzN3lSNjJDa1hZ?=
 =?utf-8?B?RXFhWEtyTDdQZTMzYVllMTd0WlVDck9aeG9HRTM1bXhRYk15QTZ4TUN4NDh3?=
 =?utf-8?B?Rm52UDdEbThReHJRT1RrRG8rQ2IyUTQvQUQ3cFIxNmJsSVlRVmdnTEtjQ3NP?=
 =?utf-8?B?enZjc2gwaTl0RzBTRlNpRHpBTUxMUUVuZ25XSStiS0ZxUmp1VmhGYnRySWlv?=
 =?utf-8?B?c01qSFl2bVdENGs1UGtOOHFhNmNWaVpoL1RNM0VrWVZUTi9qVUxnbVpzeFFV?=
 =?utf-8?B?UklMZ2w2YmZpYWdzMjNFSE84dkgxbmd2aGw4dElTdjZyN3plVWpnWlF6b1p2?=
 =?utf-8?B?SG5Hb3BDSWRTZ0Y3RXNVVVhOc1U2M2VidWpTdk4zSlVtd0pZUEhKOTB4YVNa?=
 =?utf-8?B?ZUt2QUlYN3dhNWl6aGdWdWdUTjUxWGlLQy9Qb3FaUWpVcWdOMmt5aTJvTm5w?=
 =?utf-8?B?emIrWEx0MG92N1lWZWFmbWNacStwaFBodklzZnZCQzN2dW9vZ1o1VmMxOGYw?=
 =?utf-8?B?YURleXBtV2J0M1hkMGRDQ3VhM1VaajRWZFdtYjQ3eGNXWThlS2tJbG5uV0NI?=
 =?utf-8?B?MVZXekc3K3VyTmVUdVZ2N3greFNSRGF6a1J2OGxYMlg4cXMvTjNSa3k3Qm9U?=
 =?utf-8?B?Zys4c0NxRVJsemQxTmtJQ2tHSE85K3RFUHhTcWlQV1dIYXFZaFhJQnpkalQz?=
 =?utf-8?Q?y3qqcWhLHEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3ZLeTNCT3N5aytMd3hLYkVPbVZQd1Z5M3NjMWVmZUI0NENCdGJyNjJaNXIz?=
 =?utf-8?B?NnFycnhrUFhEVmQ1dUpvMUlNVDNFNUpkRzByaWw5UVIxV2ZxNS9CWU5kZ1lm?=
 =?utf-8?B?YVJOWmV3d0pKZmZZbkFVazY2K1FSMHpGM0FvWFpBRyt0OW9vbTlaenZGazM3?=
 =?utf-8?B?RDJXUnR3SHdkU0UzZUxyWWo4RWFhazNDb0Qzd2dpeElNdU51UEVIam5BOXQx?=
 =?utf-8?B?dVVPQStjVENuRExRWXRNbkhqU2dsVjc4Qm5rWFVXTXFDdWJORWYzejRNb3do?=
 =?utf-8?B?V2g0ZFlEbzJCeHZMdzhxTmt5RzA1ZytGejkvTW5YMUswcUJHZUluT1JUaHY1?=
 =?utf-8?B?TWQ2OXZsWXdYS0NmekdPb3BDQ0E0ZzAvVWM1NC9vMFdPWUhHenBuYVJ0eFlz?=
 =?utf-8?B?empwMWlsRkRSalU0VjQ3R05qQmFORm4wUTluc2ZHM21vV0JaSzRpV3FlaWwv?=
 =?utf-8?B?V1JyWno3ckhVd3E4R2lERlVHSWV6RFpWbzV1SUl2N0RSQUtRdVhCZlBOZGdU?=
 =?utf-8?B?bWg0VGNwL1pCeUVYWlhWVUQwcVl3ZEhDOGZ5VUIzMWV0bTk4OElNbXVTK3ZI?=
 =?utf-8?B?eWdhQlZrUVl0SlhieUFaU3NrTStzQ0Fzb2ZsaWh4azdBREFkcEVJK0VTVndE?=
 =?utf-8?B?d2E3RktBTGxDWWJ1VkN3Y01CNkFTY1grQmxDZXpJM1FKZGtYNkJLZUFBVUtm?=
 =?utf-8?B?K3NPbTUrN0U5ei9USEIybkdBK0w2VTdFT3psaVI5QVpoNWpPOVA4OTEzUS9U?=
 =?utf-8?B?YXZvUkNHRTBpUTdHNkxIS0lTQ1ZzampkZ0VUWHN5WXNUYVJRaWRnS1RvbDU3?=
 =?utf-8?B?Sks5TFNNUVRmeTNNNDdtMVVLTFNUcjNRMDhIZHRNeW5lYUZXcmZhWjlnWW44?=
 =?utf-8?B?S1Ira0kzTWNEc28wTUtDUnRHcklQekx1RkhEdzQ0RzBlbW0zT0lkVzVpWDRX?=
 =?utf-8?B?S0lHaFJNK1gzMGNKa1k2UHhqSnRSSVRIcGhXazZZY2QrVDdNTzM2c0RBd1gx?=
 =?utf-8?B?WHNWUUNubHF2Wmh4RWdCMGdwMThGRWZJVTVFbjNxTlArSXc0MEpTTmFTdlVY?=
 =?utf-8?B?K0pRMm00Yjg3aUttZUhtaUxvUnZ6YWl5RXkxMlk2OEprRG0xbFAxTTNXR0ZN?=
 =?utf-8?B?d0F2S2gvNktmK3R0VXc2ZnZocmxRWGxveksvZklnTWpGaHZUQ0kwb2J2S1NW?=
 =?utf-8?B?QW1BSGVjYU1QcnRRMytjdFFSajZOcEZUSC9IM0JsTUNWcm9QNmovOGRzOURE?=
 =?utf-8?B?dnRsazd0bUR6S2tsazFGbmNRcmNFL1BEQjNMdlpqaFZEUmNJSEdlUEpKYmhL?=
 =?utf-8?B?NGtJQlVuSHBzUlBBbHNoU28zdjhHUk11VG1Jek1HcmUyNTJaL0RhZlFqa0hM?=
 =?utf-8?B?elZ2VkQ5aWdvam9zSUxOM2IxdGVhVjJBYjRYeE9aUU5wcHlKL3ROZ05aalI5?=
 =?utf-8?B?QUNadEo2U1dtcm51T2RWNFpwbnBDNkgvdzZ0b3Fjdkw5aTB4TThUQmsybHBy?=
 =?utf-8?B?YTE3U0FKTWNxMFZKWUtTbEZmZ280Nm1sWUQ5UVdxV3hKcVJvUTlTOEtCVTdB?=
 =?utf-8?B?bG9QOWNkcmovTjR3b1JJeDZVQ2FpUmVXdHhMT1Y2RTF1a1Zza2k4SmQ1YWdL?=
 =?utf-8?B?L2loeDJUdzFMSnMzQ0RmS29CUXRzYmxlSzJuU20wRXR5WHBjZnJVSDdjRURG?=
 =?utf-8?B?RVBqNE5oeGVtSzkyOWFqV3BlSmE1dFhLNldZTUtUZXBYK3VESXppUTZWN21z?=
 =?utf-8?B?WjB5UG8yV3FnbDlISS9wcitjUEVIYVArb0tjQTloTDRKanUwdVlYQzFncmJn?=
 =?utf-8?B?SjBxMTE5eGV2Sk55MjFmbTJpSm1wdFdyQXVOd3Fhc0xRYVh2eVVWOWVyaHo0?=
 =?utf-8?B?azE4bDhZRGo5c2JiZERteFhyMWdlN25qa2IxZERYL0hlVDZJWXlQWGgyTGhP?=
 =?utf-8?B?T2FIVWVLZ2tUR3JibnA0T0oxUG9RemdmbHp3OTJXTnZNTWgzenIrOGFEUlpH?=
 =?utf-8?B?eVd1UG56S2ZpZzNSK2dmcTE0eHhoUzFoQnpzeUl2Z1RJUkwxdlU2T2hsaDNq?=
 =?utf-8?B?bVNMdlFRVS9PVklMYk5qM3FVSksxczFKRFVDcHBRNHBjOG1oS3RlQmtpcjQ2?=
 =?utf-8?Q?Y8/+krlBBTvg9XYeaq9YVA2NQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4324e991-3866-4ae8-983e-08ddd8c68c35
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 11:02:22.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f47SQHFqeXb18VdU2rCKrPshYj4DzO5UFwqiCfL/QwYCjxjYF0yd/uSrR2Qf0E/MZfTWdYMHARB6n5QAOFNeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914


On 7/28/2025 12:07 PM, Thomas Weißschuh wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On 2025-07-28 06:10:30+0000, Akshay Gupta wrote:
> (...)
>
>> diff --git a/drivers/misc/amd-sbi/rmi-i3c.c b/drivers/misc/amd-sbi/rmi-i3c.c
>> new file mode 100644
>> index 000000000000..b960743afad1
>> --- /dev/null
>> +++ b/drivers/misc/amd-sbi/rmi-i3c.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * rmi-i3c.c - Side band RMI over I3C support for AMD out
>> + *             of band management
>> + *
>> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/delay.h>
> Unnecessary include.
Ack, will remove. Thank you.
>> +#include <linux/err.h>
>> +#include <linux/i3c/device.h>
>> +#include <linux/i3c/master.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
> Ditto.
Ack, will remove.
>
>> +#include <linux/regmap.h>
>> +#include "rmi-core.h"
>> +
>> +static int sbrmi_enable_alert(struct sbrmi_data *data)
>> +{
>> +     int ctrl, ret;
>> +
>> +     /*
>> +      * Enable the SB-RMI Software alert status
>> +      * by writing 0 to bit 4 of Control register(0x1)
>> +      */
>> +     ret = regmap_read(data->regmap, SBRMI_CTRL, &ctrl);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     if (ctrl & 0x10) {
> Magic value? Use a define.
Ack, will create #define
>> +             ctrl &= ~0x10;
>> +             return regmap_write(data->regmap, SBRMI_CTRL, ctrl);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
>> +{
>> +     struct apml_mbox_msg msg = { 0 };
>> +     int ret;
>> +
>> +     msg.cmd = SBRMI_READ_PKG_MAX_PWR_LIMIT;
>> +     ret = rmi_mailbox_xfer(data, &msg);
>> +     if (ret < 0)
>> +             return ret;
>> +     data->pwr_limit_max = msg.mb_in_out;
>> +
>> +     return ret;
>> +}
>> +
>> +static int sbrmi_i3c_probe(struct i3c_device *i3cdev)
>> +{
>> +     struct device *dev = &i3cdev->dev;
> i3cdev_to_dev();
Ack, will update.
>
>> +     struct sbrmi_data *data;
>> +     struct regmap_config sbrmi_i3c_regmap_config = {
>> +             .reg_bits = 8,
>> +             .val_bits = 8,
>> +     };
>> +     int ret;
>> +
>> +     data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     mutex_init(&data->lock);
> devm_mutex_init().
Will address with new patch to use guard(mutex)
>> +
>> +     data->regmap = devm_regmap_init_i3c(i3cdev, &sbrmi_i3c_regmap_config);
>> +     if (IS_ERR(data->regmap))
>> +             return PTR_ERR(data->regmap);
>> +
>> +     /* Enable alert for SB-RMI sequence */
>> +     ret = sbrmi_enable_alert(data);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     /* Cache maximum power limit */
>> +     ret = sbrmi_get_max_pwr_limit(data);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     /*
>> +      * AMD APML I3C devices support static address
>> +      */
>> +     if (i3cdev->desc->info.static_addr)
>> +             data->dev_static_addr = i3cdev->desc->info.static_addr;
>> +     else
>> +             data->dev_static_addr = i3cdev->desc->info.dyn_addr;
>> +
>> +     dev_set_drvdata(dev, data);
> If you get rid of _remove(), then this can go away.
>
>> +
>> +     ret = create_hwmon_sensor_device(dev, data);
> That's a very generic name to have exported.
Will create separate patch to address this as this is used by i2c driver.
>
>> +     if (ret < 0)
>> +             return ret;
>> +     return create_misc_rmi_device(data, dev);
>> +}
>> +
>> +static void sbrmi_i3c_remove(struct i3c_device *i3cdev)
>> +{
>> +     struct sbrmi_data *data = dev_get_drvdata(&i3cdev->dev);
>> +
>> +     misc_deregister(&data->sbrmi_misc_dev);
> create_misc_rmi_device() could use devm_add_action_or_reset() for the
> misc deregister, simplifying the drivers code.
Ack , will update.
>
>> +     /* Assign fops and parent of misc dev to NULL */
>> +     data->sbrmi_misc_dev.fops = NULL;
>> +     data->sbrmi_misc_dev.parent = NULL;
> Why are these two needed? The data is freed anyways right after.
Ack, will update.
>
>> +     dev_info(&i3cdev->dev, "Removed sbrmi-i3c driver\n");
> Unnecessary.
Ack.
>
>> +}
>> +
>> +static const struct i3c_device_id sbrmi_i3c_id[] = {
>> +     /* PID for AMD SBRMI device */
>> +     I3C_DEVICE_EXTRA_INFO(0x112, 0x0, 0x2, NULL),
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(i3c, sbrmi_i3c_id);
>> +
>> +static struct i3c_driver sbrmi_i3c_driver = {
>> +     .driver = {
>> +             .name = "sbrmi-i3c",
>> +     },
>> +     .probe = sbrmi_i3c_probe,
>> +     .remove = sbrmi_i3c_remove,
>> +     .id_table = sbrmi_i3c_id,
>> +};
>> +
>> +module_i3c_driver(sbrmi_i3c_driver);
> You could have the i2c and i3c drivers in the same module using
> module_i3c_i2c_driver().

Idea was to keep I2C and I3C separate as the drivers will become complex 
with

new platform specific changes related to register address size.

I will update the existing i2c driver for now.

>> +
>> +MODULE_IMPORT_NS("AMD_SBRMI");
>> +MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
>> +MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>");
>> +MODULE_DESCRIPTION("AMD SB-RMI driver over I3C");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>

