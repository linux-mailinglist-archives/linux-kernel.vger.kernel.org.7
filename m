Return-Path: <linux-kernel+bounces-802097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1850B44D99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C54485450
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0171EE7B7;
	Fri,  5 Sep 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fetCA905017.onmicrosoft.com header.i=@fetCA905017.onmicrosoft.com header.b="hJYeT1QZ"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022116.outbound.protection.outlook.com [52.101.126.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61073C0C;
	Fri,  5 Sep 2025 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050549; cv=fail; b=gb3CTBwrQHgvp0wV9R+4J4mXWIltnBdQf8VwV4TwjwuZ3a1J85Yjs+3EcIKBlg+8KnW/eelZ1DU6ZBbrMd1Rrw6yrPLhJe1t9ymhjFErW+9ic6XfvaG5EdbqjQeFaeeGVEsHWATDCfDtkauz7KnCeEmeGYIFQEzZiLVgkrqDda4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050549; c=relaxed/simple;
	bh=SlNm257Snx2SeK/c7wHZJDC4NIV3p2biagogH7xXMZQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3I4WHP5K1DeuHW3KP2VCv28PGnGWByqZctZf136kbJff86cb1/bJRl9fvstM7tLqjw9MOAE+8uwpPRePQToIfUXjRBsdtxoUd5aOqAE+NhR1wzwjr7aF1iuP8DFXzMow4beeiks7wzaWqYoF0QwZb0km5IhXZ86slcFhKSGQjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=portwell.com.tw; spf=pass smtp.mailfrom=portwell.com.tw; dkim=pass (2048-bit key) header.d=fetCA905017.onmicrosoft.com header.i=@fetCA905017.onmicrosoft.com header.b=hJYeT1QZ; arc=fail smtp.client-ip=52.101.126.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=portwell.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=portwell.com.tw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4ImnruwUf9iWxDSaes/zDvNxxshuiTHkQ47RgXnwhnvzHVIXzCqIoNyFQCNiltjL/Xtizar6UtqxIGjSjiH7x/KgFlCCPGdOwMM0tISAOJAvRiSlWzAttWNEPDpz5K2YpBKewkwybz/jFm5EX2Nd6rA5VgiQO57msj1k20jH3eKZgKShGthJ2YJnEBtgZe/ml8p/wBu2hVQavdza3mQBQ1UltpneQaeDZLD3vKZVXBt/ji587nT0FCYSUJ+I9UwkXzN6C1xOmpcCrTCe81JUwGgs/0rKHmX2D948wR5O4pErFpy8tpF8gKt0dBEAqE2+JWhktvcAV5C9xxypJifdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlNm257Snx2SeK/c7wHZJDC4NIV3p2biagogH7xXMZQ=;
 b=NP+G9PheIciRcYxTpkAtVnlzPr4Tpkm+As6pFHRXeRfAxGbUMoRBhhCsujCi+9oSHrRoGzpE0SJsAtT9l22Pjw0IgCnwYJL7JMb1g5mH6Yb1VeRCD0eKfpuoX+4u64qAQhwKqlR3PtAlQiPYiFj55bzc10ldFyvLluQhlS1RNdqHTbTtSBN7YVC7P+o9isEmLmWSUtKf688umb6fCoxDhzFpkMe30vs3Denz275RAILuYJCXDrxY38JjStFiNST7hYjNEWnIbvPgBf7BbkKTqUZZYNk8svgv+6sWeSeacNUUfB/yXKBKc21NtbfKJWxD+w/aWOT90LBwpcgkwfEzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=portwell.com.tw; dmarc=pass action=none
 header.from=portwell.com.tw; dkim=pass header.d=portwell.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fetCA905017.onmicrosoft.com; s=selector1-fetCA905017-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlNm257Snx2SeK/c7wHZJDC4NIV3p2biagogH7xXMZQ=;
 b=hJYeT1QZf7xyHZBYe1OGllf6YC1CM94z5YGsmlZK9OmVXzXyIyhINu3m92pDU28is0S5HYFgfC+sRJVSefsuqFdkAUIqGZah4qRK9D6ZWzoWd1R4x2PWhCGpjO6fsqk4h5/ReKpCWQ3B8QFi/mCapwP+IJpKPzeWg+jIHdeMqmMG4ab70xD1caTpjm13q74yxvXoLktsJonRKaBhYd/NkYSEvpzCwOhNnSfMhdbJKZUuVIZGiLvBszOdxQxlxSZjj4zFh5iDvke0SnybJGc7lYJBwDgbc+CFeOWWnKv/W3vwQiB+YFy2pn20GDR0Tj4NlEDtqmt6YUZ3yo+FyRthGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=portwell.com.tw;
Received: from KL1PR06MB6395.apcprd06.prod.outlook.com (2603:1096:820:e7::10)
 by SEYPR06MB6588.apcprd06.prod.outlook.com (2603:1096:101:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 05:35:42 +0000
Received: from KL1PR06MB6395.apcprd06.prod.outlook.com
 ([fe80::8aad:9193:92da:7ec3]) by KL1PR06MB6395.apcprd06.prod.outlook.com
 ([fe80::8aad:9193:92da:7ec3%3]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 05:35:42 +0000
Message-ID: <bca8aa38-af39-4c8d-b3c8-5d452120dd77@portwell.com.tw>
Date: Fri, 5 Sep 2025 13:35:38 +0800
User-Agent: Mozilla Thunderbird
From: Yen-Chi Huang <jesse.huang@portwell.com.tw>
Subject: Re: [PATCH v4] platform/x86: portwell-ec: Add hwmon support for
 voltage and temperature
To: Guenter Roeck <linux@roeck-us.net>, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, jay.chen@canonical.com
References: <a5edf505-9b77-461e-ae8d-510e6ed3f950@portwell.com.tw>
 <07ff2b26-5518-4ccd-8509-75aab8989d24@roeck-us.net>
Content-Language: en-US
In-Reply-To: <07ff2b26-5518-4ccd-8509-75aab8989d24@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::15) To KL1PR06MB6395.apcprd06.prod.outlook.com
 (2603:1096:820:e7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6395:EE_|SEYPR06MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f272b00-0026-4378-4035-08ddec3e0da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkplV2JMU0NtL2NqVjJLWENzQ2Y0YlZ6RTN0cFpicXluZkF6d0ZWazhSK2pC?=
 =?utf-8?B?UTlaSDdYTGh0dGlXRXY3cVZqMmxoSkJhZE1yMitZTDV3cm1SMlZSNnB3Uy9J?=
 =?utf-8?B?NW9ZSzIxQmxaVDBQckV2RFVndk02dXdrUUFySlJJU1I0K1V0clMyMHpEWk5z?=
 =?utf-8?B?c3g1Z0RadFkyQjNtNTIxTmJVOUVYenVkMjV5V3Z0L0g0cUQ0YktiYmJ5TnRW?=
 =?utf-8?B?VS8wRnI0UDNNK1hYVnJ2V1pPU3hFZEhaSXBJbHo2dWpoU2tRQmtKZzVGY1Uy?=
 =?utf-8?B?ZExSN0NhWEZNbk5lOVNQZEdIZSsvb0tkakRqYkhCdDg4VXM5RE9JZGdNNWFx?=
 =?utf-8?B?Unh6MTgzeEJkZUV3MnV6YTloNThnZjhHVkRMYlpFN3lpbFhhRzdSSFc3TE12?=
 =?utf-8?B?dU0zYlBDNjdxcG5nMWZZNVUrQWN3ZW1BaFRQSFo1MzZSdDRrT3ZpTHZmbnpC?=
 =?utf-8?B?YlNKUmM0WUtGV2U4NEtzaUp1b2RaMGdNK2xjZkwxQlF5RC9zQkFuajFCMFFT?=
 =?utf-8?B?ellWRXRrdFZ5bkxEZmVBWCtDOWFUem9keXdhdWsxWFJML21tWVBPMVVnOExC?=
 =?utf-8?B?S3BIZklWREgvRnN5NTFVTTNodDlpdVNuWlF0anRSbmwyNkhsc0ZaaEVRaGJG?=
 =?utf-8?B?NVl5MlQyWUR1NTdSbUpnS3V0b3pCS3JTWk5Zc3RNbldGYnduczFFTnBBK0x5?=
 =?utf-8?B?OTFkekdzQk5jVTNSbU5Lbm1EMzdwQUFtcXJLVGFuZElJNzk4cVBSRm8vdkg3?=
 =?utf-8?B?cExmaTlFSUZVakZhTENuV3YrblkvVGRFcnR5bGNmTExPditLZEFUK01yMy8z?=
 =?utf-8?B?RmlFMTBDWTRZQWdnNWoyYW1jazZzM2FwKzF2NGtQNllMd2Zuamc4aHQ5SlJF?=
 =?utf-8?B?d25adzdqY1N0Um5HaW1uamdCaDVhYmJ3d2kxdEI5YzlZK2JnRXBDTEk4V254?=
 =?utf-8?B?WkZXeXhzLy81ZmFCMmNuQWVjYW1NNWU3cG9VV1BTOGRZVmpMdmE0aW5oajRE?=
 =?utf-8?B?ZTRRdnRlYlJuNDVqVGJCdC9JV1U1VHZOZWt2QXBDQ0w2NUIzQnRsbjlZN204?=
 =?utf-8?B?a3dFYy9jYmV4RlljS2o1bG9OMlExeUxoOU53cFFpQXEwOEFxZjJpbmRDb0Vk?=
 =?utf-8?B?bm1Gd3E4WE10TjgyTWtSVVhqbFcvSDB5MlRlVkdwVERGY0J1QVhXcDdiSEdR?=
 =?utf-8?B?UzdiLzQxUWUwRCszQk9odStLVU0xN0lzRG4yTVBtZUo2MDg4WWpqVkppZ0FB?=
 =?utf-8?B?Q3NXQTlnRVNCVExueWJWa3VkQzlTdG5aS2RraFdhdTRiSVJSTTE3dDQ2MFFt?=
 =?utf-8?B?WWw0RGRGQk5KOWFkc3YzQlE1WWR3aGc5RHl4YmdOVjRtT25vdGRxMUY0ampa?=
 =?utf-8?B?S2ZHOEFOZ29Ccnhndk9MR2NsRnlsRk8vdWxpaWM5eHgxSmlMdUJjY3Vsdith?=
 =?utf-8?B?UTRDU0tZSXBNR1FoZml1ZkFxbW9zaUErN0c5SHVpOFZUWVNyN25OMzFGN1lq?=
 =?utf-8?B?cms0STFFdmw1WnVtT0lqdjdtVjlJWDJmU3FVR0ViTS9sN3BiR3hIQU5jcHZJ?=
 =?utf-8?B?SG1PZzUrcmJ6bFpROHNkVHlOa0dqN3RRZGVpQzdYYk12clFoTXI3T3A4RHll?=
 =?utf-8?B?M1UxOTNTZTkvcTExUDZKd0lUWTgyc2FMVUt0djhZbW5VR08xK2N6Y2N1elB6?=
 =?utf-8?B?andpZmdXa3pUcnl4NnhnMzZnQTVCSEpzR3NPcHZHenhuQ29MaTlaOGU5a2RG?=
 =?utf-8?B?RkpnckRhd1NnQkh3Qmx0RU14SHcvQ09zQTJsajVYb1dDZUtlVmRHNldjL0hJ?=
 =?utf-8?B?MWFaQmMyNzVVUFEyVVJOY1BudWs0am5yMi9aVG54OURBNFFsMzl4c2VCWG9D?=
 =?utf-8?B?M0o3M3I5M2dJcWRjODRwWDhxYklRSW1DdG1QbXVQZGU2Zzl0T3RYN3BQcDZH?=
 =?utf-8?Q?ggsxq14hYrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6395.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3g0cStZTWpsOERBN2pxanNCVVdjSVBua002elFKajU0K1YzN3E5NFQybEpD?=
 =?utf-8?B?ZGp2eWY2c1NLSzhjTTFpTC9Kd3hJek5GcFFxMzhmUWFraDVKaFlFNnhnaU41?=
 =?utf-8?B?RUhiZmJKZHoyY1RxWlNXTk9aMG1sOGhuWTRCdzBMaksyWEEwZktabUlaV1dP?=
 =?utf-8?B?QmFpWUtndzE3bGVDK0VKTlpJbjZZN1B2ZlRDczZDZ1FmY3Q5SkE0bW9PZDc2?=
 =?utf-8?B?RzBYU2tQRmF5SWRTSTZwN0RyaVNLRWxGL3hVSjVBWURCTVVkd2dKRkdNQVRS?=
 =?utf-8?B?b0loUDBueTVMRUNUSDZsRGZUejhmRjFDa0p0blJBc2xKSHkxSlpQbnVCQ2xm?=
 =?utf-8?B?Vzl5Slp3RjFhUzdOMWZKM3hXTzV5eUl5YkQ2cTh5N2Q4WEllZ2Rzc0hGbzFw?=
 =?utf-8?B?eWdhME9XWWgzaC9mMit2Um94Vm1NL09nTHc2OUptUkVVcVFRKzdicmZNSSs3?=
 =?utf-8?B?Z21FUHEzUjhSV3IxajZYc1BoVUZsZkh5aWZySS8yOC91TVlVVWhHWXNtY0tk?=
 =?utf-8?B?eDJBcTRpRGduL1VjU0IwbTV1QUlHRjM1N3NUSDJ4ZlZ6VXRQV1djVGU0YUdt?=
 =?utf-8?B?RjNwNnd2d2lwazJuSGVDRGo2em1kOFkzZFREMzJNZi9kSVozWkIyUGxyY09Y?=
 =?utf-8?B?M2xUMCs2WVNZVXJPYzBwMXc4QkZ2R3NxM3hPbzJZdE01UW1uNmY3Q2hYbkZM?=
 =?utf-8?B?eTN6emlGUlhINXp5V0RyUVRSaEJXTFdNVk5sYjNFYS84d25WcVFtRVNLNHJR?=
 =?utf-8?B?NmVqVFl1R1IrZkx3YjhkaWhxa2gzL2Rlc2VCVnpEM25lOUFYaFBRK2luVzdB?=
 =?utf-8?B?dVNvbzMxK3NiYkJCeGQ2bUtTQzQveitFK3RBZktoUWI4SWw5eEtOb1BObzdZ?=
 =?utf-8?B?NGNISTFGeUEzeUVUbkVqSWpEa05hNktORVY0cUk5a2FKZ3Y2YS82bldscWV5?=
 =?utf-8?B?VllEdW1ZMllUZFZSN2h1elRQbmpXWm5mOGU2N2hoSXJYZ2lyMHplVU52QjFM?=
 =?utf-8?B?cGVyUmRoeEdWUVJjZjRvK1FSbG04OHNlY1Y1eGQyQURMQWNrZTRUcnV1MXlI?=
 =?utf-8?B?NlQ3ekZHcDcvbkVwS3dlMEY0amY2TmZTeENSUk5MV0crdW9SeFBLL0FxaWI5?=
 =?utf-8?B?MEd6eW5IU0NBbEdvaWcrSW03bkJOeUFlb1lLU0JpU2QwKzMzczBGNUNsNTk2?=
 =?utf-8?B?ZHNzQWVVNU9CVDJHdFlFd2xBZERlQW94ZStoKzBvZDNDMzBDcFQ1UjJUbVRN?=
 =?utf-8?B?WVhNcUtKQ2lKRWZJS2p0cVRWaUF0MDVmc0RHWjI3eXdwbDE4MlRFYzV0S0dC?=
 =?utf-8?B?VjlxT0pWY1pDNGpneGJvSzBuZVhtdVBZajhGMnJzOEV5YlJLM1RqUFJQTllt?=
 =?utf-8?B?QVByY1FZcE1OZUhVT2JsOERzbi9wRE8rT0NUM29lUHNBMk9GLzcyWXZlakVD?=
 =?utf-8?B?R2toOTBXd0RXRWw4YlpmVXk1UXFoaHNLaVMvMXFWMDlaUUdDcHBXSlY0WCs3?=
 =?utf-8?B?NjNsRFJDeVZoaEk5dSt6WWxwbWN0eC8wL2dCYVpPL3RiamI2czFyRzJlc0Ux?=
 =?utf-8?B?a0JFT2ZaNDZ2ZmtkM2x0Z3NIN2Vwc2h5NExacjhwQzhTaGdDYXhXQU5vSnE2?=
 =?utf-8?B?c3dza2dHblprVDZFNDdXMTJMcE9QWlU0b0hxc0lUZWRoSWtLZFlqaTdqT1k2?=
 =?utf-8?B?akxCTHVud1dGZTBNdmxqT1BGWEZyRlJUcUlqNFBXL0FRWVhidmpEa1hwczB5?=
 =?utf-8?B?YlJob05iTTJOcnpnUFJ3cHl1ZklSVEdYYTdtZUZYZTFrTVZCekZnUHNjOUhS?=
 =?utf-8?B?QVQzWDJQdmswVE9OV0NKVlhmc3Btd3FuR0V0NC9QcnZtMlBxalhYNFhVWmgv?=
 =?utf-8?B?UndlS0w5ZnV5NE4wTUtVRDk4TWxUaE5kbEJxekc2SVFjaTBoaDNSTWtBQS9r?=
 =?utf-8?B?R21YNnZZYzdPYzFnSHVYLytWUXp1bDNoOUVDRXozQXJXdjcrNmNVSS9LQjRj?=
 =?utf-8?B?SjhkVVd4djZwcVNkS0ZqQXNZUElFR3lVSmRneWRIcldpcGgwUmZwOXltSEhJ?=
 =?utf-8?B?SDhHdElld0RWVzFZeTFtUit2Y3ZIenRQeGRyUTJzSzNwbDJXSDdtSkJEcDRW?=
 =?utf-8?B?RzhXM2xyT05MYVlBVnhER1BtcjkrSHc3YXZJMm4zaVkzMHhVSGs3TG9ITlZp?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: portwell.com.tw
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f272b00-0026-4378-4035-08ddec3e0da3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6395.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 05:35:42.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e309f7e-c3ee-443b-8668-97701d998b2c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2lBtY0n7OzsP3Z4fwKr3LdMdCtUE8dsahlGrWsbrV6MLoCoCqiXkbtvJ0nyw+5JaRSqrWIVUc29I8TiWGU/YdGC4Yu46Bw99/H8ehXCEkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6588

Hi Guenter,

Apologies for the error.

In v4 I mistakenly removed '.is_visible' while simplifying and then
incorrectly tested against an older tree.

A corrected '.is_visible' will be restored in v5.

Thanks for the review.

Best regards,
Yen-Chi Huang

