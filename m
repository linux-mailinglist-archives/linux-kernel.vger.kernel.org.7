Return-Path: <linux-kernel+bounces-785106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EAB3460A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590743A6BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A802FD7AD;
	Mon, 25 Aug 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="X/F3eMXN"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2138.outbound.protection.outlook.com [40.107.115.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185ED2FD7A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136389; cv=fail; b=PVyAOkLeHZgkXnodR+VYt27QfwT5NzRBZNY+Pp0quWO1G9dx6gfbksTCYTHHvpbg3Lt7MAuabXztmPSS/bl7mWkNV6DCQ5SHzr/ePqRADvCFKAajn2ir+RoElXYhurLHJ1SgG9fVkkTdMJKukRuP3rofC2yws2V5WDRPALCa+hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136389; c=relaxed/simple;
	bh=0QT5eDX/cvFp5FikYZjPBUrzaUR29HMUqsNWIlUxf5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YzwAwNJAe9o0b+4SZc/waMMyAbAEUZ8qbU2mSve7MoROj/NanY96zbe3yldWgLRExxpFknulRG3qUO69WzqOh3E8xVkFyZiQSoDsrKEGWdAoPFeYDt64z8VNnwyuK36I51Ja6R6OaHQ5yTsV64yUKceSq2QpjiHgUM2Tc7kHa8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=X/F3eMXN; arc=fail smtp.client-ip=40.107.115.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKCIYQY1unf70+g/MRWP2l/Rtp3BY7G40Lq20OPq0wsSZVhaMEOYFzCyQl1Sh2WS80vJai7wlUVziq7eyFTpiPjZ5PAW/1Aio8vslwBOwMsKiqoeUtE4oMUWWQePsQaBfnUldtaVYYKUa+yDW4QkQdhv7g9kbjSvQWUKLx1Yc0IKnBGBpntxSky+RIOPZae28gwo/WBMeucxQBxvE9DbQve8Y5glJmxmc9JxQaEYL+dy2vg5n84DOYq8nD9Dzdf4Hr3DtsXi3LruzcovjdSZ+U87kre13mOChP8Z6kI3ZH+zyzVtyGL5LKbnM529M8BNl2OBEpCqISXKwUhhs5WkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAojOX9X0oV9B0DfIJiLRGnV/XoPYn8lsrDFK6z1NS4=;
 b=db972w0O8TeRdRgn9OnwCrWQQ9jdqx4LM4JefyeseTD2nnuzdpQoXWZRRzsLapX+nrLNkgVYgFeOGuxwsExSLPeSBMVadD1NKD2G8Ve/dQbTBp+VgZTMl2mRCreVcP0T1769Y2iD01+8aGy4yOeeHwYXYV3NLXTAM0SyUHjizYH6iDZztGfS/ZVuIe3y+IXkFLNaOBgTONiHgwKMGIWt2u8QrWkxTp/rZ80PevbhrCv70sqnara+eSvH4E0NXaDlagSmAuKpUhu5imDrQRek6uHgF1fc7vvx5XiLpwMN8gbgYzqf+/BU0IDF20VnRWeHCBE1Qo0F19CB5Zwc50FYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAojOX9X0oV9B0DfIJiLRGnV/XoPYn8lsrDFK6z1NS4=;
 b=X/F3eMXNplpFDbQSFjbiongaNs/p1JHC93aqOG2Dqal0TCSj/gp22QwgtRRwaYvhvJcTBrctB3VuJhd+A8BpqsAmNeIBJdD2wIsWp06xJgXBcMrDxnaDvoMBDXBVd5Y3L6ok8rR3N9VMkTvi0BuB85HPX3M8z6D87kZe52PVPEFiVAFc0w5OBbwhTSD61FgqTp7oSmXIiytInEd28YWfshsObaf25TyS6xDQ3lqSlSGutPeFU9rfPpeyVLe+oICnBKof07oeoUkkop4TiNN31kL8HmmPkkkRt1JVWvhOLYaJikkXjCGXVmrRO57z1bCx+03fm07S3KjMXSlCJNW5rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5767.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:32::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 15:39:37 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 15:39:37 +0000
Message-ID: <e871c4cf-07d2-4357-8830-043a5b81a242@efficios.com>
Date: Mon, 25 Aug 2025 11:39:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 01/37] rseq: Avoid pointless evaluation in
 __rseq_notify_resume()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.322198601@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.322198601@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 665ceefb-57f2-4b33-775a-08dde3ed991b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDZPY25heGNJSlV2dW9KVEM5clhYRXExQTRlemNldlI4V3dyZ2xKMmVkQTJl?=
 =?utf-8?B?bVNGZmNaK1htSVpHeVBBREdXUjBHaEFxRGJHbFNJOVdHK2xTandSNzBoOFV3?=
 =?utf-8?B?ZmtLelIxUnlTaWpmNGR2dFZkU2RPREtMQndOeDh4RHAyYXVHVDRxUnBhbEZX?=
 =?utf-8?B?Yy83amxRejl6RUJxZkFlOUVsN2pIOVJ0QlVWOFZwMHk1YWxRbDJ0eVBPa1NN?=
 =?utf-8?B?MGg1QzcxRm55bytsSU1JNjVNbENCUzBXYzRBQ2xQU3IwTlp2cEVmclZxZEp2?=
 =?utf-8?B?VE1oM0kyNmdQTjdiRE1ybU8wYnUyUXFLSmlocDRQNTFhMTRLSEJzR1F2NEZp?=
 =?utf-8?B?V3JOeXpJVWg3c2xuQWpjUzhyOWsvRVlmQ05CNDN6WUtCMlBieDdkV3ZrS3c0?=
 =?utf-8?B?Nmpod3ZvNERvakpsS0QzSHFLOEU4M3ZKM0NFZlBUVU1WSFZOTHhpK1V3MXZo?=
 =?utf-8?B?VnNKN3NRSU1wZ0hpSmhacDl5WnhXRnk5UlVkbWRnUE5NTEJrd0E1YjRkSEtx?=
 =?utf-8?B?aEtMSzBHS2duUGxpeURWVUlDbFZqMFdReHJUenMyTTZjNVFiNVNpeHUyUUVJ?=
 =?utf-8?B?S01NMElycWE5aWFNMUdoUnRlOEdKbVZWUi9uNGQxd3RtYmNRN3FQdWQrclc1?=
 =?utf-8?B?TWtsSEtjako5cXU1S252MjBFZThUTVIzVkt6amdzQ29HSFh5MUUvY1FQNTFN?=
 =?utf-8?B?K0ZEQllDR3FQVlh5REZJSEdQc0VrVE5jbEZVVzhwajF4elFpNWg1M3RqZXZj?=
 =?utf-8?B?bUpyVGtSOEtENThXU1VGRFg5SlV2TlNxQVdGb2xVdVFRckY0VytYeWJoOXk0?=
 =?utf-8?B?dEp1SnBiOGVuN25DOTJhelgzTTg2bTFYSURKNW1MbjVycXEvK1hLK0hHOHhv?=
 =?utf-8?B?Um16blZtTGxMSzQ1NFl4MWl3ZURIalhzd1dVMnkrRkFwYUZCUWdDOVNXSjlU?=
 =?utf-8?B?aGE4RE1laitsNmdiaXpVdklhMnFkUjVjY25mTEo3cjdhRUVzc09QUThrRnN5?=
 =?utf-8?B?bVErSnBVY1ppZGhjNGM5SzVEOFJLbFVHVlBlNkZtM1VnK3lXb1QreFhlSVg1?=
 =?utf-8?B?VzcrRzA1VDJxMHRWelZpTzZjS3d6WTBtN29nVFhDNTQvdmVPYVpwL2lsTFla?=
 =?utf-8?B?K0hzTkFLZVdzNDZQQ1Z5REFFaWFZcENOTkM3U2ZUeDhlS3ZnS1VnNnFEQnd0?=
 =?utf-8?B?RFMvaGFmcS9leitsU1haS1c3emh4QVBhdHBxWXUvemhTVDZrTHZnYm45NUFv?=
 =?utf-8?B?ckJuL0xGaE8zd0M1WlRCdE5ONjErTDZ3RS9kZ2hyTEdyWTkyajhUVTZHWTBi?=
 =?utf-8?B?dUhRZDhqRURqUlpCbDRCeDcvMkxyQnhmd0dyaDErMGRHeS9rUkRUNHMwaW1Q?=
 =?utf-8?B?c2pqS2Jyby80NkMrWmtxQ1BXdkRpb2pMSEo1ajhjR1JqMERNM0c0UG13eGtW?=
 =?utf-8?B?aFhDWWdCaFFqeU12VzZGSjA0SzlQeTdxbG5wRllxcXhVcjNJUnozM2RlN2g2?=
 =?utf-8?B?T1pqUkxqL0l0VGZJZGVBbGQ4eHhndHZhQlhiY3g3R0lEVG8waFdleHVSV0Jq?=
 =?utf-8?B?SkY0ZDFLemNNdnlkdjVNWWk3QnFsMERWcFRJaUhFekdpSDJDWFRNSVQzVVQv?=
 =?utf-8?B?ZkhVZHFQU0RDVUpjbytzaUwrcDdCRGExdkh3dFJIY2hOM1krT1pidkRtMldt?=
 =?utf-8?B?NTQwTEN3aEo1c2hwYVkwZGM3Z2d0MEhTZmZJTjE1Vk5nYjlmbXFrQkI5ZzMz?=
 =?utf-8?B?QWl2QTdSaHlJbjBENjJlVkxsWkRoYUV1bUducERFanJSeWZyTFNpZVdXdFJ4?=
 =?utf-8?Q?kJYBRU1G6VOR0cUyPHl8oiZph+3UvyA2JK/i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjhJNm1CekdTZWlJS0RtbldjUUZXNlRKNFI1cTM5Wlp2RXFxT0d5UEtGcW1R?=
 =?utf-8?B?Vk5CejhnSWJ0YmlCMnRoQzltbzF5WEdFSTlmeUM1UE5Lcm1xalZKbXdtdkZ3?=
 =?utf-8?B?MVEvNnl2MEdKNmZWVkQ4dnNZM0RKMzF0bVBlWldVMU5ubTJ5b3ZBZXdVelpo?=
 =?utf-8?B?Q0xPalI5a05kaVBOWXpXQ1UzdkE0MS9naVRQVTFIdHRlcEhxditrNCtwK2VZ?=
 =?utf-8?B?Y3QwOVhZOVcxOGZOcXBXVzBBZW9wdmdMbzlZMEhuRkhxclNEYmttWlkzdnRH?=
 =?utf-8?B?K1Bhb3p4Zi9qVnVPbmRxVDJaa1FkODB2WTRrRzNJeU94Rmppc1Zsb0FpUlRu?=
 =?utf-8?B?Z2w4MFFyNE4zSUo0bWJtYzZ6RG5FQkljbUJpaHhpUEgvUFJ2TmtyWStNL2lt?=
 =?utf-8?B?TExUTFlKVTdIOEhrUnZmSHF1TVB6VjkvR0xPNndIR3JvbVJBVkRYcEJaek1G?=
 =?utf-8?B?eVZwUzMrbFdySCswRkZFVFFGSzd2SWlJaTA5eDRMclJ3SmlFNHdPY09KU0JP?=
 =?utf-8?B?Um9QRUt1d3V0djFNWFFNb1dQb1UySVF1dS82aC9ESDluK2pPM2EvbnhWd2pR?=
 =?utf-8?B?anRGYU9aUFFlV1VaSk0wcVFVaVEyTmkxeXNPRHRKOFV5ZTc4TVdIMVlPNjlK?=
 =?utf-8?B?bkVRTkFTaFl2Qkl1YmdWTzJPZzl3dERiZElaTlJpNU5ua2dsUndvVkVteEgy?=
 =?utf-8?B?M29zTjVTMTBwUU1pZi80YkxQWHlienhMc01qenR1ektNSWpZWWpDbEtqb3Zv?=
 =?utf-8?B?QlluaGNhbnNXWWYySHh2V0tFQy9nTVIwd3ZZSVhPM0dzU2I2V1lsS1FSa0Z6?=
 =?utf-8?B?WVBjOVFYdVYyczFQOXRqMW1BOVhDeWNpK2xDcFNrOS9VSTRCUTJDYWplVVU4?=
 =?utf-8?B?R2kwUUpvV3dmOEZaNCtJNzdPSGZqSEtjNldHZ2lXL2JnQUdEQWlHVVV3YmNl?=
 =?utf-8?B?eDRnNnFIcEdEeFZHSlNINkN3b1Y0R1c2dHpaZHBPUVNGamp1S0RaQUc0Ynhh?=
 =?utf-8?B?Y0szRkowV2hod1Z0VTNwOHZZeTE3MDNIZXZFVWdaRmFEM1lHdnZsUGs5RTNh?=
 =?utf-8?B?WTlaK1VKNGFpNEhDWEQ2SnRxbitXQU1WWnhFbjJHdnQ1elY3eVZUTy9kemti?=
 =?utf-8?B?WFZ3WHBic0FtVExzdlFsOTNUNXlhUm9NUVZETjVlbWNrU1BoaHBxY0h0QUtr?=
 =?utf-8?B?RGRySE5nRHRleWdmZ1BXTTJXMmMwV1IzMmJHeWJ5bTU3d2RRR05rdm00emx0?=
 =?utf-8?B?WWtRUk5xZkVVRVNybmZJYzkyWmkxcEQyaVRmbGhEZnVyN2dBNnhDa3FLbGFJ?=
 =?utf-8?B?Tm1WMFAvSHVuVUVwSldBTDh1UjB5T2c2RFlUSEJtSjJEd2tyQ0ZPTm9yN0Rh?=
 =?utf-8?B?eXFDdVZjRk9CWEN5MGthVjhyc2d4aFdXR2F4TXJUU0xvZVBnVHNSR1dqNklK?=
 =?utf-8?B?Q0hmTjhXOWl2dmVUdVU3RUVNZlFIa2QvRVVXVUZzbkFVMS9aUlNkNTEydnV5?=
 =?utf-8?B?RUl0MWJUaGo2SGxXUVVpQ3drYmI3TURBaUhteS84alhzdXd1emRNTWFkYndR?=
 =?utf-8?B?S1hlejlZSDNJZGJxTzRTWUVtUjU1bklSQ0htbXFVMHN5OVh4NjhpNHM1V2JR?=
 =?utf-8?B?T2NlczhBS1ZDamh5RTg4WGlHNzYxc2RLakJUVEdnUFVlRDlYL0Rqdyt5TmU3?=
 =?utf-8?B?ZWg0VmU2TWI5dmFyelY1Z1l6NGd1TXZsT3ZMYW9aNTRRZzJSM2ZKa2lXSGp2?=
 =?utf-8?B?dHJSZ2FSTFM2WTRoL2hGZERsQTVLUVpvOTM2QlB0cWJaZWhVaUpCbEJrREdq?=
 =?utf-8?B?dmRoOFhVVmJYMXl5RkVvRUJUc2liTXNQWVZubnFEaWFzV1hGc00wRXBOaUNY?=
 =?utf-8?B?ZjcyVjB0KzVWYU1xRlE1cVNVcEJWK2RGRjJLcU5ZcVFLcWgzZU11NGFDdGVF?=
 =?utf-8?B?Z0hlTFAwTXc0cFhvSzhYVGg1WER0OWt0Yjg2cG9uSWVVajg0aFNZbzVBbDBL?=
 =?utf-8?B?dXNNaFFRbUxEKy9RaFcvZ01RUWl4LzM0Yk81eTJQYmxycHlvODJZdDhjbmph?=
 =?utf-8?B?Ujdmelo3YkNnT2ZRUWh4eU1Ibm10Vjl0Z3R4TXA2N3FYZkNEWjNJY09SSXJn?=
 =?utf-8?B?ZUZQalNZLzN2ekJTOUo0NkwxSU9WYU5JaWRSMFVLOFBtKzdEclFiaCtaajNT?=
 =?utf-8?Q?vPhOEAIE4dgxqQsV4KU54iE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665ceefb-57f2-4b33-775a-08dde3ed991b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:39:37.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMiz1LMJWRBIMN6W8tZn/xVrF0Gpj6xnac2xD9I8FfkBY39gvor7CholIG/vIMp5ggGzFxIGVCIuy2Gcn9m41AJvsr7K6yGq5dY2OF/PUto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5767

On 2025-08-23 12:39, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The RSEQ critical section mechanism only clears the event mask when a
> critical section is registered, otherwise it is stale and collects
> bits.
> 
> That means once a critical section is installed the first invocation of
> that code when TIF_NOTIFY_RESUME is set will abort the critical section,
> even when the TIF bit was not raised by the rseq preempt/migrate/signal
> helpers.
> 
> This also has a performance implication because TIF_NOTIFY_RESUME is a
> multiplexing TIF bit, which is utilized by quite some infrastructure. That
> means every invocation of __rseq_notify_resume() goes unconditionally
> through the heavy lifting of user space access and consistency checks even
> if there is no reason to do so.

Even worse in terms of overhead implication: given a userspace that
has no rseq critical sections, all kernel rseq events end up setting
the rseq event mask bits, and they are never cleared, which then makes
all TIF_NOTIFY_RESUME work slower. This is not intended and should
indeed be fixed.

> 
> Keeping the stale event mask around when exiting to user space also
> prevents it from being utilized by the upcoming time slice extension
> mechanism.
> 
> Avoid this by reading and clearing the event mask before doing the user
> space critical section access with interrupts or preemption disabled, which
> ensures that the read and clear operation is CPU local atomic versus
> scheduling and the membarrier IPI.
> 
> This is correct as after re-enabling interrupts/preemption any relevant
> event will set the bit again and raise TIF_NOTIFY_RESUME, which makes the
> user space exit code take another round of TIF bit clearing.
> 
> If the event mask was non-zero, invoke the slow path. On debug kernels the
> slow path is invoked unconditionally and the result of the event mask
> evaluation is handed in.
> 
> Add a exit path check after the TIF bit loop, which validates on debug
> kernels that the event mask is zero before exiting to user space.
> 
> While at it reword the convoluted comment why the pt_regs pointer can be
> NULL under certain circumstances.
> 

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> 
> ---
>   include/linux/irq-entry-common.h |    7 ++--
>   include/linux/rseq.h             |   10 +++++
>   kernel/rseq.c                    |   66 ++++++++++++++++++++++++++-------------
>   3 files changed, 58 insertions(+), 25 deletions(-)
> ---
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -2,11 +2,12 @@
>   #ifndef __LINUX_IRQENTRYCOMMON_H
>   #define __LINUX_IRQENTRYCOMMON_H
>   
> +#include <linux/context_tracking.h>
> +#include <linux/kmsan.h>
> +#include <linux/rseq.h>
>   #include <linux/static_call_types.h>
>   #include <linux/syscalls.h>
> -#include <linux/context_tracking.h>
>   #include <linux/tick.h>
> -#include <linux/kmsan.h>
>   #include <linux/unwind_deferred.h>
>   
>   #include <asm/entry-common.h>
> @@ -226,6 +227,8 @@ static __always_inline void exit_to_user
>   
>   	arch_exit_to_user_mode_prepare(regs, ti_work);
>   
> +	rseq_exit_to_user_mode();
> +
>   	/* Ensure that kernel state is sane for a return to userspace */
>   	kmap_assert_nomap();
>   	lockdep_assert_irqs_disabled();
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -66,6 +66,14 @@ static inline void rseq_migrate(struct t
>   	rseq_set_notify_resume(t);
>   }
>   
> +static __always_inline void rseq_exit_to_user_mode(void)
> +{
> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> +		if (WARN_ON_ONCE(current->rseq && current->rseq_event_mask))
> +			current->rseq_event_mask = 0;
> +	}
> +}
> +
>   /*
>    * If parent process has a registered restartable sequences area, the
>    * child inherits. Unregister rseq for a clone with CLONE_VM set.
> @@ -118,7 +126,7 @@ static inline void rseq_fork(struct task
>   static inline void rseq_execve(struct task_struct *t)
>   {
>   }
> -
> +static inline void rseq_exit_to_user_mode(void) { }
>   #endif
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -324,9 +324,9 @@ static bool rseq_warn_flags(const char *
>   	return true;
>   }
>   
> -static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
> +static int rseq_check_flags(struct task_struct *t, u32 cs_flags)
>   {
> -	u32 flags, event_mask;
> +	u32 flags;
>   	int ret;
>   
>   	if (rseq_warn_flags("rseq_cs", cs_flags))
> @@ -339,17 +339,7 @@ static int rseq_need_restart(struct task
>   
>   	if (rseq_warn_flags("rseq", flags))
>   		return -EINVAL;
> -
> -	/*
> -	 * Load and clear event mask atomically with respect to
> -	 * scheduler preemption and membarrier IPIs.
> -	 */
> -	scoped_guard(RSEQ_EVENT_GUARD) {
> -		event_mask = t->rseq_event_mask;
> -		t->rseq_event_mask = 0;
> -	}
> -
> -	return !!event_mask;
> +	return 0;
>   }
>   
>   static int clear_rseq_cs(struct rseq __user *rseq)
> @@ -380,7 +370,7 @@ static bool in_rseq_cs(unsigned long ip,
>   	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
>   }
>   
> -static int rseq_ip_fixup(struct pt_regs *regs)
> +static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
>   {
>   	unsigned long ip = instruction_pointer(regs);
>   	struct task_struct *t = current;
> @@ -398,9 +388,11 @@ static int rseq_ip_fixup(struct pt_regs
>   	 */
>   	if (!in_rseq_cs(ip, &rseq_cs))
>   		return clear_rseq_cs(t->rseq);
> -	ret = rseq_need_restart(t, rseq_cs.flags);
> -	if (ret <= 0)
> +	ret = rseq_check_flags(t, rseq_cs.flags);
> +	if (ret < 0)
>   		return ret;
> +	if (!abort)
> +		return 0;
>   	ret = clear_rseq_cs(t->rseq);
>   	if (ret)
>   		return ret;
> @@ -430,14 +422,44 @@ void __rseq_handle_notify_resume(struct
>   		return;
>   
>   	/*
> -	 * regs is NULL if and only if the caller is in a syscall path.  Skip
> -	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> -	 * kill a misbehaving userspace on debug kernels.
> +	 * If invoked from hypervisors or IO-URING, then @regs is a NULL
> +	 * pointer, so fixup cannot be done. If the syscall which led to
> +	 * this invocation was invoked inside a critical section, then it
> +	 * will either end up in this code again or a possible violation of
> +	 * a syscall inside a critical region can only be detected by the
> +	 * debug code in rseq_syscall() in a debug enabled kernel.
>   	 */
>   	if (regs) {
> -		ret = rseq_ip_fixup(regs);
> -		if (unlikely(ret < 0))
> -			goto error;
> +		/*
> +		 * Read and clear the event mask first. If the task was not
> +		 * preempted or migrated or a signal is on the way, there
> +		 * is no point in doing any of the heavy lifting here on
> +		 * production kernels. In that case TIF_NOTIFY_RESUME was
> +		 * raised by some other functionality.
> +		 *
> +		 * This is correct because the read/clear operation is
> +		 * guarded against scheduler preemption, which makes it CPU
> +		 * local atomic. If the task is preempted right after
> +		 * re-enabling preemption then TIF_NOTIFY_RESUME is set
> +		 * again and this function is invoked another time _before_
> +		 * the task is able to return to user mode.
> +		 *
> +		 * On a debug kernel, invoke the fixup code unconditionally
> +		 * with the result handed in to allow the detection of
> +		 * inconsistencies.
> +		 */
> +		u32 event_mask;
> +
> +		scoped_guard(RSEQ_EVENT_GUARD) {
> +			event_mask = t->rseq_event_mask;
> +			t->rseq_event_mask = 0;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event_mask) {
> +			ret = rseq_ip_fixup(regs, !!event_mask);
> +			if (unlikely(ret < 0))
> +				goto error;
> +		}
>   	}
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

