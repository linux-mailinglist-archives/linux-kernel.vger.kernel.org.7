Return-Path: <linux-kernel+bounces-730402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248BB04421
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18223A2976
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457DA266EE6;
	Mon, 14 Jul 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ra1iKedA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ra1iKedA"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9357266B66
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506898; cv=fail; b=MsY7J4qSbIU/uTeZ/aQ44LyAL5RhbbawHL7oSfYkkWZ9Syjq6HM/Y3n9Pq4ySdbhgKI5Rj5rD1DFBwwPvf2Odaw01ReU1w5b9l6TPEtUq08KZPRXF5+vM8Nmva4UJZEECaP+4RQn54WzsAUZma7ljYwO6+DO+KXRvO1zMxOZrdM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506898; c=relaxed/simple;
	bh=IMczTHED1OYqXAucoDdxD70C1jlyR0NXJBGvjAHWBio=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jh11WM1b9NJ4aK+myIE5YS1SdWgu2pCkkM6kJR6Hzvb2NEOr7ZjxUAE67VtmmZxYNsb7Ms8vv+3u57nhUe6bcfFlen22hM2Uz1pUhUt3yGBo1bQmOiq4lnanU/kj0mAZ8BuCSF4N4XqTSFrdkkCTu3cEOA1HU4jDrnCDuECUMs0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ra1iKedA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ra1iKedA; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FEjxVxL7o06Xz6z6k8FEy+Y7Z2slX8JxHhERZUIF2jq3xM3Vc7xfuXB3L+Zxppduv4GpRRMMiDRH7mMEUNma6c+12YDHfQR1BSgUXngbTwc0DY3n9x/h0gMNAL76E0whTPIRTDlAhauLejoLGThmINZcwPIXnouPHQxJa+GwFzk7a2ZGk3HGrEFntbZGZ5UwB/BSMzTmhdmcIAUHpUYjX7whp9bC/vA8bohjaDJRJtZ6+eA/Dyq4Mkb7R/XBvv+mjvqmiRNAmgTtGkc9N1GRIZtsVo/46A9+C60ImCdkPKJaqnjbpGQUxaUKfeLuZNOI8vDyZAEreyK/kytA7gXGmg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQCafW2KVBym4JCLwni4yCvp9FJqDYanmHblDamfi7M=;
 b=RxS24MctFw7vV/FSgLRil5PEzKoHtixLD5wo6hCmQQ0x5+MM06dZmzPkb2LwlQvS0FDFKfvBPLTCkUwQXqf25gsDm0KD/xpNOGjx3vienY4Ze291NubOiDfW004Zd0hkC8J9Sb3PX01+KQOEsvYekNENvib6FW8SJzDpR2YeUHX6eUs57hAHyNZqjOz/ymxvL7d4oWzh1/JwWmygUegqCmln9vodYtPdaIwbJSqZvKq/pb9FjmAecbrBnZVilVnIgSbKSu5QyqgypchcmHKLAylV8BN7vgdxzM1tR9EHB0aYOovWcRB44FTRyceMe9eqesDjD+BVGWp2CWEv6bYnKQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQCafW2KVBym4JCLwni4yCvp9FJqDYanmHblDamfi7M=;
 b=ra1iKedAUKefNtyf3h0tHWWC3oeCldK8cmtKI34RwHtAeNalvSB5E3j5Mu4lQcejpENN1EOHxswsHvQp/qebdN1dGktvTEgRu/pS7o/KmaVMHBilz8C+BKnqMmmjlqTZ6WiP9yU/nqhyxyIY3CfHkE2qnul1S6NIgvQcfptUHv4=
Received: from PA7P264CA0163.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::15)
 by PAXPR08MB6493.eurprd08.prod.outlook.com (2603:10a6:102:15a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Mon, 14 Jul
 2025 15:28:09 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:102:36c:cafe::39) by PA7P264CA0163.outlook.office365.com
 (2603:10a6:102:36c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 15:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Mon, 14 Jul 2025 15:28:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8y/IBND7F3RqCfOBIEoThfWyUKJB3l0NDrmtlCEdN0amRJ3rig6MdRyjrV7JL3HLPnbdgTWSWKKjhfbpAmCW7+QzjsR2gpg4DL9fRoDpr5orxlcsrC3VzFdU5QtyYTp5LfVsbJdVBk7GiclGiGegaOLHP2BzZHFBIurHXhkChROtHIdAb4vXwGWkKR9rDJVopgLnG3buALMCXhwtfYtFQ00P8fqfyuoPbhMhi643/GxtBhFfgcagFRTWCFaI7+WIdW5SZ9rgLWSkImdNDqdmR7SynaUW5VjcvkxolQGV8YRRnsYYfQ7po9ieSm47vTl2WgfaPiquQ/I15ow+b6UGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQCafW2KVBym4JCLwni4yCvp9FJqDYanmHblDamfi7M=;
 b=iz2XsXvhur8+VCXJ+TkJjogSgaCNS0/ximlcDuDtzLfzKJaIEmh2O+FNdDkmp6uMDyb13YNNEqyjM9Uz/k3qmoR1O8cM03yT1uaFAASgzC4kjMerXbaUYmpVFIrqq6mIYk9yYJMQuBfAjWd//dwCQ/2jcMh7LvqzlvCov22rtIQd+bMIM8nRDKGrNwmhVbAmV1MTT6BzP0TLgDL7IZEOTTH08iKUUKrxgMUuCBsaDpemk1rgmV811aLg49vcRg9M9hCne5KKEu60MVPyBiIMzZ6Qec3Li6dQnPxZxCSjGz2dEUvmAvHcYghwZzKdwjXqng1wN7tPTgoqF1GyuSydRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQCafW2KVBym4JCLwni4yCvp9FJqDYanmHblDamfi7M=;
 b=ra1iKedAUKefNtyf3h0tHWWC3oeCldK8cmtKI34RwHtAeNalvSB5E3j5Mu4lQcejpENN1EOHxswsHvQp/qebdN1dGktvTEgRu/pS7o/KmaVMHBilz8C+BKnqMmmjlqTZ6WiP9yU/nqhyxyIY3CfHkE2qnul1S6NIgvQcfptUHv4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PAWPR08MB8911.eurprd08.prod.outlook.com (2603:10a6:102:33c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 14 Jul
 2025 15:27:37 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:27:37 +0000
Message-ID: <7eb0fe4d-a36d-42b2-bef7-88a9d9236428@arm.com>
Date: Mon, 14 Jul 2025 20:57:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: Enable vmalloc-huge with ptdump
From: Dev Jain <dev.jain@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 ryan.roberts@arm.com, kevin.brodsky@arm.com, yangyicong@hisilicon.com,
 joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, david@redhat.com
References: <20250626052524.332-1-dev.jain@arm.com> <aGe5XjWKhgjzcw7L@arm.com>
 <bc201f93-7743-4d9d-a62e-3c8ea22e2cfd@arm.com> <aGsYZ7W0yunbeqQV@arm.com>
 <e1e87f16-1c48-481b-8f7c-9333ac5d13e7@arm.com>
Content-Language: en-US
In-Reply-To: <e1e87f16-1c48-481b-8f7c-9333ac5d13e7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PAWPR08MB8911:EE_|AM2PEPF0001C715:EE_|PAXPR08MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5111ab-6ae4-4543-8824-08ddc2eb0986
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZmZleVVlemJSRERLa2E5T0s0NUV0OXNLNC8yQVZaTWNmcFpmNVppTVNsSzRJ?=
 =?utf-8?B?Um5pVjlIYlI0TUFsNE94MVdtSU9neTBkWUt0TmhWek16NWFZU3p4U29yOUQw?=
 =?utf-8?B?NkNmZDFqVG4wZkd6aEwxV2xyUlFtcExvN0toUTRJT3JFang2QmtOclA0Yzl2?=
 =?utf-8?B?QURjY3g3bTJETmZTNzArbTBuQ09HcFpkWTJxYTBqRXY3Y2RObWNIcWVWTFpy?=
 =?utf-8?B?aXZQTTVCSk1kWlRPSzVOSDNlU3lmUGNVY3RUaGFFSjg0dzlsS3BoZVE5dnR6?=
 =?utf-8?B?NHh5Unc5MDFtZmFoOXZGK3k5Y3ZEZTE1RmZUdlZqMjRlV2ordjM4YXBqZThi?=
 =?utf-8?B?eG1BOXh2U1VsWG5kMTUyNDFNQ0lLZGlBcW4zU25XR2lGenhYOFQ1NzJkU2Vy?=
 =?utf-8?B?QW5oZFdmR0pUbk9nRVRqNzQxQVd0NW5ZZzBPR2VmZjYvdldPZHVaRHEwa2Jq?=
 =?utf-8?B?emZDZm9veXhtVmJsQnZtUlB3eWJoWitrK3MycXF3QVRUUTQ1V0p3L3Z3cy9l?=
 =?utf-8?B?dFA1SzhLeTN2bURaUnpaMGlEZk15MzFSRGtxYU1QYU9UeHM1OW1NTVY0TldX?=
 =?utf-8?B?ZXYyOXdLWWxKMllmZzZvZDV0M1ZRbWNCR3pPWGtaNm5uNjFSNXNoZnRMelRh?=
 =?utf-8?B?SFdKZWVJUWtlY21MQzBNMlhhRTVmWjFQT1puOTRmcjFMNTl6SFIrRy9QSFJz?=
 =?utf-8?B?M0ZjcHZGcDZtdFJKUHFONXZYQmhydDNlNGJTbGdFdnpkVFgzMW1nZUlONU5t?=
 =?utf-8?B?aVNhZmdWa25PYTZUNDA3SjVkZzNGYkw0YW9xS1NCUE1rU3FrdEJ2TmpiOXYw?=
 =?utf-8?B?enJYd2JsUGNBcjZCb0lES0gxdXpwQXZBOWFTbmwyOGNYZmc2OUtqVnVmSThG?=
 =?utf-8?B?L2VnYjdaM3dsRWw3bkRNVkdmeS9HakJ5UXlKRHVYUXlIaWs5UzAxY2dxTk1H?=
 =?utf-8?B?WWdTekYwbjFFbkdLR1luZStNeUltWjBIUTY5VmF0Vjd2VC93Uks0bmhDYzJS?=
 =?utf-8?B?VTFiRzVxVElmMTMrNWNjUXAvL1lGeHhicGZ1Wm9CYWpaZlJxOGd5bU5MZm9M?=
 =?utf-8?B?RVY5cERJMXhlM3hMNmttcDNlQlQ2M1p2ejRtTytGOXl5SFhQYU1VUnhyWkZ3?=
 =?utf-8?B?am1tN1pkNW9RcXdNY0tLNUFPQy9CODFiNXE1VlEzNW9EdWIyZCtGT3ZyRVJt?=
 =?utf-8?B?MWRWTFVwWGpHb3doaEYvN01zdHhvclhmL3lpd3dDYlZnSFI4NEJ3eVpNQytR?=
 =?utf-8?B?OFJINEk4dm84KzVtRjdkUXNtemU3SUV5NndCR20xbytPbzF5S0FBM0hpV2pq?=
 =?utf-8?B?Mjg2V0ZVeFNaKzdUbEZaRVNMQUVLYlg4ZWoxNDVWZUJQemtrTWFCTVFoSjll?=
 =?utf-8?B?dGFRZXdNWHd0SXBDanlUbUcydFFwcXJOSnJORmYybjhpeXg5dnlTeVphb2xF?=
 =?utf-8?B?clErM0xVVURtdW10SjF6bWRIV3lCY1hZK1FsSUhkT3U0OFh4d2oxclJyWU5y?=
 =?utf-8?B?QXhQUkZvWnc2cVFTdEl4TXhJQlRoNTFiWE1XZkZmR0tuTTYxdUpPRzBFc0ZE?=
 =?utf-8?B?ZWJKNUpHMXlnNFZ0eFJ5UlNzMHJmVTBTU1Z3S1Z0eEQwQVdwMWgzd0RWVGVR?=
 =?utf-8?B?aXdMWkdpSEdyZWdVSGFMa2tsTFpTeDZNWlRGUzBGVHJvQ256aW8wU3QxbU1N?=
 =?utf-8?B?ajhHQ3VVTTVXdUZDQ29oK2hZRGdqUzBranp3WTNjT1FxUWczMWFSWXhhb21D?=
 =?utf-8?B?d3VqTkxYUnhqVFZ4VnlIa3JlWWhZYWRSNjFKNGVnTU42d1B2MmVvZUgvVTZY?=
 =?utf-8?B?Tis5clNvRng5d2xOWmdVd3lWT29BSG5ubDRESmVydENjZERmeGxBb1dQYmI5?=
 =?utf-8?B?aTh3d1NDRVJVZWd3b3hVQlNhaEdCSEgvSDhOUDlJN3hJMU02bzZwVlJrVUtJ?=
 =?utf-8?Q?gPtd+HF1rvs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8911
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5cdd035f-45f1-4181-8fd2-08ddc2eaf646
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0tnYW5FQjVaWHFYdFM2OHNVcWt4eTZ6eFIzekUwcEtvMTZsSGtoS0cyRmRG?=
 =?utf-8?B?K1BEcjIySjhNTnJoUCtySUQ2b1J4ODdocDJ4R1l5WXZEbVhrRk1FTXNBTXE2?=
 =?utf-8?B?Ylk0L0pLci9kNE9CeGNVSkl1YkUxc3VIRkFtNlJITHdrQlJZZUxlUWRSS2E5?=
 =?utf-8?B?TjZxVS9DUEpkWW1iRUtYODRvN0p6WG4rVFBiWHJUa0YvOEFNNFpTaHJoWkdk?=
 =?utf-8?B?U094ZUhOVGtWRkRGTk5kYzVTVUUvbTFvVkJqeGhzV0VoWGU5WXR3eXRKd210?=
 =?utf-8?B?VzhEa1BwV0NiYm9KeTM3VnBKNmFZdGRqa3lDeTlyN0NwRVlxQjdhenNmR3Bp?=
 =?utf-8?B?REQ2YmNRM3ZZMGZINTU4UC93VjVTWjh0bHE4NU02alRMOWRHLzlwdldjSk1F?=
 =?utf-8?B?UU1jNCtwdjg2TDNkdWw2VXVOWHJuRE5PS0cxVGtnOFNocCtPcHU4c3ZwMkJ0?=
 =?utf-8?B?UVFMeXFjS2VmZDViNkdFbHQ4UjJqWXRxeXRaQjZ2cllNbE9RellZV002eHVY?=
 =?utf-8?B?ckt2aVlyQ2tlMVR2bWlIYlZCVFQvckxTOENSSDVhT3dPeE94cFAzVXJhSUtX?=
 =?utf-8?B?OTJmK3VsV1ZEY2xqaFVoNjBjZElEc2NlY0hQanNFajBYVjJTajlia1ZuVEFk?=
 =?utf-8?B?MHNrYnZBQ21Panl5aXVHK092aGFHaXNBaE1jK2N5OGFWV2xINkdRcnR5bnh4?=
 =?utf-8?B?SUhkQlU2VTduTzRQcXdmKzVYOVg1UVE2RDlTSGl4TFVzd0RBcXNNb2tscnF3?=
 =?utf-8?B?bEFuQWZrKzV5UDNHL3ZmNnp2MVhuNmRlUWkreStVdTRUKzJ1T0NQN3lWMm1Q?=
 =?utf-8?B?MklOWURrWmg1aVNNSk8yd1AvSHlOTDN5WlV3aXZTTEN5MElRM2IybktYWHF0?=
 =?utf-8?B?TW1XalZtNGl5L1FwOWJSKzJYcmJYYWw3M1NzbW1qU2JzS3liTm9sWC9KQjVH?=
 =?utf-8?B?elVERXZCUUgzUWh5dzgzc0NnUnUraVhCM0Nhcm0xWmQ3YVh1VXBsQy9qb3BS?=
 =?utf-8?B?MDJpVXV5OVZsYlI2TFcxN2NqU21Nd1p3K1RyVkJpOHpJMXJOQ293KzhqSUNR?=
 =?utf-8?B?QmtzSlB3V1FwWXNmc1I5L3l1ZEdvREMyZnBQbnNFQTVBUmpFWXduMDlNTVUv?=
 =?utf-8?B?TTNpa05KNEVad0hWVVBqcmM1UkVXdVZLZ1FYM0Mza2lScTR6SkxGTnlPa2FE?=
 =?utf-8?B?NWxJbzh4MXBld2VYUVBFanZnNGh4VmcyRUl2NVAwek1JbHMzMUJMOTRRNXpR?=
 =?utf-8?B?U1hNeG5QUjFXM29ieGpWNHB6cGQ0MGw1SWNJbnAzR1JIWm9XZ3c2RHlxaVdM?=
 =?utf-8?B?OVo3dGRWZWl6ekZRMGFkV1J2ckxUU2k2dHBlUVczdkpWZWpKNUJvTGJtVlFK?=
 =?utf-8?B?Ukg0NTN6S1B6UTAyd09Pa2tCSVVaL09JenFUaVRCaG9NUlN2WGhDYXE1LzBN?=
 =?utf-8?B?RG5tQnhjZStjcEcyYVdSOGZaeTJDbTlidEx2ZjI1ZE53NDAxcFhoTE5wcThk?=
 =?utf-8?B?MnFLZ0Q0WCs2d3I5NXBrYUNtdnFJaDdxdjhMOUVtdWZ4Lys2Zjd1OWd5TDZ1?=
 =?utf-8?B?VU9tdVAxOGJkeldOTU9vQ0VjRVNRRHRpMkVZMFRtUDh6Tzkwa05UYUlCWm0v?=
 =?utf-8?B?TFNFNWxsYm5DMDVLZ2xPekNiQTRPVm1Ra0JhSTdtRG0zdzNpV1ljSVhIR3VE?=
 =?utf-8?B?QUxuVkpiUS9xWU8wYmthSFJxQ3NCTXlTMFNuZ0kvS01TdEpiVFV4Tmg0aE1D?=
 =?utf-8?B?eXFucmY1akVycjF2NGFLS0F0dEV1dFUrM3E0Q1ZuaVJQMTE5RGZVMWE5YXd5?=
 =?utf-8?B?N3hRUWlCOW9PNTJMTC9oWkpZN0lsTFBtZktHYlZmeEZMdXNqSURYdHRzR0or?=
 =?utf-8?B?SVpHUDhJMmxQbmFsM2tPSGZGamcrSlprSnl0dVJWZTcxZC9IcXNSN2MzQnRG?=
 =?utf-8?B?M1lqT1JkT0dGWU9GYnp5dzhDaFNmVS9yY0ViaWdIbXFkU25ZeDYxUmtpOHhi?=
 =?utf-8?B?U3h0NmFsSzJUU1NhSjJ0Ujg2MUlQelVWeDJobzNYWTZOKzV5UWVUUWFEdVJa?=
 =?utf-8?Q?vr0zsx?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:28:08.8410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5111ab-6ae4-4543-8824-08ddc2eb0986
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6493


On 14/07/25 2:56 pm, Dev Jain wrote:
>
> On 07/07/25 6:14 am, Catalin Marinas wrote:
>> On Fri, Jul 04, 2025 at 05:12:13PM +0530, Dev Jain wrote:
>>> On 04/07/25 4:52 pm, Catalin Marinas wrote:
>>>> On Thu, Jun 26, 2025 at 10:55:24AM +0530, Dev Jain wrote:
>>>>> @@ -1301,16 +1314,39 @@ int pud_free_pmd_page(pud_t *pudp, 
>>>>> unsigned long addr)
>>>>>        }
>>>>>        table = pmd_offset(pudp, addr);
>>>>> +    /*
>>>>> +     * Isolate the PMD table; in case of race with ptdump, this 
>>>>> helps
>>>>> +     * us to avoid taking the lock in __pmd_free_pte_page().
>>>>> +     *
>>>>> +     * Static key logic:
>>>>> +     *
>>>>> +     * Case 1: If ptdump does static_branch_enable(), and after 
>>>>> that we
>>>>> +     * execute the if block, then this patches in the read lock, 
>>>>> ptdump has
>>>>> +     * the write lock patched in, therefore ptdump will never 
>>>>> read from
>>>>> +     * a potentially freed PMD table.
>>>>> +     *
>>>>> +     * Case 2: If the if block starts executing before ptdump's
>>>>> +     * static_branch_enable(), then no locking synchronization
>>>>> +     * will be done. However, pud_clear() + the dsb() in
>>>>> +     * __flush_tlb_kernel_pgtable will ensure that ptdump 
>>>>> observes an
>> [...]
>>>> I don't get case 2. You want to ensure pud_clear() is observed by the
>>>> ptdump code before the pmd_free(). The DSB in the TLB flushing code
>>>> ensures some ordering between the pud_clear() and presumably something
>>>> that the ptdump code can observe as well. Would that be the mmap
>>>> semaphore? However, the read_lock would only be attempted if this code
>>>> is seeing the static branch update, which is not guaranteed. I don't
>>>> think it even matters since the lock may be released anyway before the
>>>> write_lock in ptdump.
>>>>
>>>> For example, you do a pud_clear() above, skip the whole static branch.
>>>> The ptdump comes along on another CPU but does not observe the
>>>> pud_clear() since there's no synchronisation. It goes ahead and
>>>> dereferences it while this CPU does a pmd_free().
>>> The objective is: ptdump must not dereference a freed pagetable.
>>> So for your example, if the static branch is not observed by
>>> pud_free_pmd_page, this means that ptdump will take the write lock
>>> after the execution of flush_tlb_kernel_pagetable completes (for if 
>>> ptdump takes
>>> the write lock before execution of flush_tlb_kernel_pagetable 
>>> completes, we have
>>> executed static_branch_enable(), contradiction).
>> I don't see why the write lock matters since pud_free_pmd_page() doesn't
>
> True.
>
>> take the read lock in the second scenario. What we need is acquire
>> semantics after the static branch update on the ptdump path but we get
>> it before we even attempt the write lock.
>>
>> For simplicity, ignoring the observability of instruction writes and
>> considering the static branch a variable, if pud_free_pmd_page() did not
>> observe the static branch update, is the ptdump guaranteed to see the
>> cleared pud subsequently?
>>
>> With initial state pud=1 (non-zero), stb=0 (static branch):
>>
>> P0 (pud_free_pmd_page)        P1 (ptdump)
>>
>>      W_pud=0               W_stb=1
>>      DSB                   barrier/acq
>>      R_stb=0               R_pud=?
>>
>> The write to the static branch on P1 will be ordered after the read of
>> the branch on P0, so the pud will be seen as 0. It's not even worth
>> mentioning the semaphore here as the static branch update has enough
>> barriers for cache flushing and kick_all_cpus_sync().
>>
>>
>> The other scenario is P0 (pud_free_pmd_page) observing the write to the
>> static branch (that's case 1 in your comment). This doesn't say anything
>> about whether P1 (ptdump) sees a clear or valid pud. What we do know is
>> that P0 will try to acquire (and release) the lock. If P1 already
>> acquired the write lock, P0 will wait and the state of the pud is
>> irrelevant (no freeing). Similarly if P1 already completed by the time
>> P0 takes the lock.
>>
>> If P0 takes the lock first, the lock release guarantees that the
>> pud_clear() is seen by the ptdump code _after_ it acquired the lock.
>>
>>
>> W.r.t. the visibility of the branch update vs pud access, the
>> combinations of DSB+ISB (part of the TLB flushing) on P0 and cache
>> maintenance to PoU together with kick_all_cpus_sync() on P1 should
>> suffice.
>>
>> I think the logic works (though I'm heavily jetlagged and writing from a
>> plane) but the comments need to be improved. As described above, case 1
>> has two sub-cases depending on when P0 runs in relation to the write
>> lock (before or during/after). And the write lock doesn't matter for
>> case 2.
>>
>>>> And I can't get my head around memory ordering, it doesn't look sound.
>>>> static_branch_enable() I don't think has acquire semantics, at 
>>>> least not
>>>> in relation to the actual branch update. The static_branch_unlikely()
>>>> test, again, not sure what guarantees it has (I don't think it has any
>>>> in relation to memory loads). Maybe you have worked it all out and is
>>>> fine but it needs a better explanation and ideally some simple formal
>>>> model. Show it's correct with a global variable first and then we can
>>>> optimise with static branches.
>>> What do you suggest? As in what do you mean by showing its correct with
>>> a global variable first...and, for the formal model thingy, do you
>>> want mathematical rigor similar to what you explain in [1] :P, 
>>> because unfortunately
>>> (and quite embarrassingly) I didn't have formal methods in college : )
>> Neither did I ;) (mostly analogue electronics). I was thinking something
>> like our cat/herd tools where you can write some simple assembly. It's a
>> good investment if you want to give it a try.
>
>
> Will the following proof work -
>
> Proof of correctness: The below diagram represents pud_free_pmd_page
> executing on P0 and ptdump executing on P1. Note that, we can ignore
> the situation when processes migrate to another CPU, since we will
> have extra barriers because of switch_to(), and all of the embedded
> barriers that are used in the reasoning of the proof below apply
> to the inner shareable domain, and therefore will be observed by
> all CPUs, therefore it suffices to prove for the case where
> pud_free_pmd_page executes completely on P0 and ptdump
> executes completely on P1.
>
> Let t_i, 0 <= i <= 8 denote the *global* timestamp taken for the 
> corresponding
> instruction to complete. Therefore from here on we do not need to use 
> the term
> "observe" in a relative context. Let t_i' (t_i dash) denote the global 
> timestamp
> for the corresponding instruction to start. That is, an instruction 
> labelled
> with t_i implies that it started at t_i' and finished at t_i.
>
>
> P0                P1:
>
> W_PUD = 0: t0            x = 1: t2
>
> if (x == 1) {: t7            write lock: t3
>     read lock: t6        R_PUD = 1: t4
>     read unlock: t8        write unlock: t5
> }
>
> Free PUD: t1
>
> We need to prove that ptdump completely finishes before
> we free the PUD. Since write unlock has release semantics,
> if the write unlock finishes, it is guaranteed that ptdump
> has finished => it suffices to prove that t5 < t1'.
>
>
> R_PUD = 1 => t4 < t0 .... (i)
>
> Because of acquire semantics of down_write(rw_semaphore lock),
> t3 < t4' .... (ii)
>
> (i) and (ii) (and t4' < t4) => t3 < t0 ... (iii)
>
> ptdump is executed on a single kernel thread, which implies
> that the transition x = 1 -> x = 1 will never happen; that is,
> when static_branch_enable() is executed, then x was 0, which
> means that the call chain static_key_enable -> 
> static_key_enable_cpuslocked
> -> jump_label_update -> jump_label_can_update/ 
> arch_jump_label_transform_apply
> -> kick_all_cpus_sync -> smp_mb -> __smp_mb -> dmb(ish) will always be 
> followed.
> The emission of dmb(ish) => t2 < t3 ... (iv)
>
> (iii) and (iv) => t2 < t0, also, flush_tlb_kernel_pgtable -> dsb(ish) 
> ensures that t0 < t7'
> => t2 < t7' => the static branch is observed by P0 always => t6 and t8 
> exist.
>
> Now, t0 < t6' because of flush_tlb_kernel_pgtable; combining with 
> (iii), this gives
> us t3 < t6' => the write lock is observed first => t5 < t6 (the read 
> lock cannot
> be taken before the write unlock finishes) ...(v)
>
> Release semantics of read unlock => t8 < t1' ...(vi)
> Also, trivially t6 < t8...(vii)
>
> Combining v, vi and vii, t5 < t1'. Q.E.D
>
>
For the sake of rigor, t_i should be defined w.r.t loads and stores 
rather than

start and end of instruction, since theoretically, for example, t5 > t6 
is possible,

if t5 has a lot of, let's say, statistics updation operations. So, the 
relevant store

of write_unlock will finish, and the read lock will completely execute 
before

we actually exit the write_unlock due to the instructions embedded in 
write_unlock

which are not relevant to us.


>>
>

