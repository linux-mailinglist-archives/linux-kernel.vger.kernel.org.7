Return-Path: <linux-kernel+bounces-781587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB953B31439
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800FF5C48EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA652F0692;
	Fri, 22 Aug 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YLvePZFa"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE52F0671
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856088; cv=fail; b=mdnBOGUJStsBdPi2rARrOeK6Z/LdxKMXM+S7vFf7l7zY6YHQU/zQGjBGF46kJ9COexgkRB4G3EEYotwX61Fo6u9WsInEXyc/LqudlCiWp4khZHRku3NXh67ubkM20C4iWTijZ3PA7oOuy26jX5kqUfIhdmWWuBBVexeTURC4H4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856088; c=relaxed/simple;
	bh=9HP3cfjZqNOrziRZOmQjkJyDaz4uhE7nxz1UM8mMVEw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KzB6Lm5FkxMq5H6ryJHilgzViB8IDUDpNgBMgL9IKEKp9PCXzbNG5srQnfscJRAk6n+EdeDxxSnn1aOnG7lZXa7NtwYIMnyG+2E4C8yR+e9r1qxcOM5DBNBYXItEmLz0QbXXAWiNZ+CLUgh26pWuyHdfmmZKz9/xyR7fWNAW08I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YLvePZFa; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scSIEWP6iegvqcpSO/eVOJy2tMQtQ150R/B68zCfyGfJnWmxhjRPDdGHfVojjpwqgBNHU7wOeLw19sEO3fN0bN4Z4GtgRcs+mJWStFUncOSey1k4EIqH3JI/MUqy+hr+yz8PxhzZ/KYBQX/RfuCmEp+8t9Vhnt6XWxo8oZxw6CH1EqKsDrfLHTpTEukiqQNPVxDwGpGt6JEGrFR3G/HlY3XphNnv5CbY+YobIakw+UhCnxvCjo12gdKej1MFbc/Gj5hi7L6+k7k44Ueenh+eDz+w5a0Ipc0pVXvwwTird4pQ6u3wFA4z1WOtqz9u/+rnC4iSJztU+qvHUjdZWvzWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4o1vmY4XrHBRQ0mzocOABy1WExIhLHLLjHcLFwfYsM=;
 b=S6l19YLumg71mmW3u+AcHiqxQAzuClm5B6fuHuazNK0vlAxOvjDniCOqJsLrN2vAAqCP6HO0M/j2AbX4Q/JbTh1R8esmqQAIwu0a4XB2V5qMvx2h4I16V5iQ+CxfOYo4RVhp4sTJIHuwDZdG3G78kS0+HNE2Xk2UoaWjuWp3Ks29Dqwh6dEs/EYlQatffR4TOlkWvzXnO6NSw9y9Y6l0Y72zM/5q3kgSyCwQqYNpcbZUcKekvwYpTTyONiHjHh95qU3eK3StzZ/Cdtv1BcM5QhgagFXDgFrXb+YWL2g5GBMOvYVbiBc6sMLXwFjZceSfXD4RCSjqBxfd9LKoPUhZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4o1vmY4XrHBRQ0mzocOABy1WExIhLHLLjHcLFwfYsM=;
 b=YLvePZFaJM9hAfOYxomjgaV/TUkVQwj7UU851yprd9E1Gwdgx7bnWjYGP/7oFaFG2odwW2ncFQcvFgiy1VGyXKgS35FDWTHMnU6xiC/p+/OeSNwppeWhNsLHitRyTjOBCVD3a2KRuGImQMiFCK0Zkb83Pb0drnDCSfNnaCo/FoiXpXgKQ8k9ZKzdLylH2bLDDv5eVaqW3WGMysFaClxMiRU88oDd2Kl1rB+F1t8W5N32qQR06d+sg0+HDNa2M/qZTPMVFTSGxj8jv2MBMAEN1Iaavqf2C3iXhcI9au/T9Dcz13njUZk1eWpc6IuSTBtbG4wGBQMu1KkeHf16ZH+UKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 09:48:05 +0000
Received: from BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e]) by BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e%2]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 09:48:05 +0000
Message-ID: <fbbcb145-1212-4925-801a-064fbd72e67a@altera.com>
Date: Fri, 22 Aug 2025 15:18:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] firmware: stratix10-svc: Implement ID pool management
 for asynchronous operations
To: Greg KH <gregkh@linuxfoundation.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250722163045.168186-1-dinguyen@kernel.org>
 <20250722163045.168186-2-dinguyen@kernel.org>
 <2025081926-choosy-femur-9765@gregkh>
Content-Language: en-US
From: Mahesh Rao <mahesh.rao@altera.com>
In-Reply-To: <2025081926-choosy-femur-9765@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::16) To BN9PR03MB6201.namprd03.prod.outlook.com
 (2603:10b6:408:11e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6201:EE_|SJ0PR03MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: eb866bf8-230a-4d95-c57c-08dde160fdd3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHdpQjQ4bE51K0prNGJtL2NaMmlYT2dMS01HaUVSejByQjBVUHdmbjJYS2NB?=
 =?utf-8?B?QWozbFN6dGhiM1NLOFZLaDJ6ZmhsOUROL0MvYVRIK0x6ZStWQkdRWDFGVlI3?=
 =?utf-8?B?UGpEU3Y1WW9haWQ1UVdwZ0Vud3RkZmdieTlYZllBQXhWS3VhYTNyUWRaTjYw?=
 =?utf-8?B?T3ZFd2VSOURtbjQ0ck5kaFpCSThJZU9SRStEa0cwR00wTmtoWWdyRHc1eXRO?=
 =?utf-8?B?VExXU0FGMlR2M09TbVZHaFhFa3RmdkJ3TEIrRWRnTnkwQ2gwckFWT0N6TGp2?=
 =?utf-8?B?bUJOc25NTzJVZERSUk8zSHFlS1l1OE4rMGVFTTYxaDBpeFZ2emhTOEVzdUdB?=
 =?utf-8?B?RVdvZ2tJMi93WEhrd0tEZkRwcGdhcVVENFk2RmJIdDV2NmEyTXRWQ21yNTlz?=
 =?utf-8?B?ZTJmUVFXRzdOTkJ1US9DV1hVZTJ6OVp1bEN4LzlDR0VpNEJJckNUSCtJRThF?=
 =?utf-8?B?M2xuaEp3TmZnVjlPZnRZOVNwMGszKzN1Z0hjVDZKcE9Hc01DM1pBUUt3K21Q?=
 =?utf-8?B?N0lXaDV6dEY2czh3VUhzRDVKMm9zWWdBS1BHSXVmNnIwUDdFK1psWHMwa2Nq?=
 =?utf-8?B?Y1NDTUpVVG00TWJlVlQ2d2pxWGdwQkVmMlcvQ2tBTXNDc21IdTFob0NCUnVM?=
 =?utf-8?B?cmNPRWs0QzUybDlTTGYzQTBLT3ExSXMrQjBOM0xoZW1aSGpWTjljMEt1Snp5?=
 =?utf-8?B?bUNUWU5UczJoancyc0FqN09FbG1TNkVyVGtRYUZRNncrdU1BSXVJYTZEQVlB?=
 =?utf-8?B?emxGeTlKb2lTUE5jcFE5VUN0NER3S2RTU0xBTzJ3Y0s4enlTZ1Z4NGRnTmJK?=
 =?utf-8?B?MStvcWYvM29CM2xFbGtrN1l6WEpSRjMwdFhhaitIQThLK05uQWRyQkluN0dQ?=
 =?utf-8?B?ZnhZelFVREt1M0lHWkRBSVV0U0tsaytpSXd2eTE3NDU5bTAyak5Uc21oMkli?=
 =?utf-8?B?bHIzUU9XRDdENzdXNmFQNlhQL0FDaWk4NlFaWXdHcTUwRnJwVHJvdGpDSllE?=
 =?utf-8?B?OVZIWWZMek1tVFhOTXNkL0g3c0FxQXJHd3o3N1phMjVDd0pBUzRJc0kyODgw?=
 =?utf-8?B?dndxVXV5djFrVUhkdEsxZ2l1Z3ZFTUdHSndoNkg4MUlPRHVWZXlVZTRUVzd1?=
 =?utf-8?B?ZTRGN29RbTNNNTlkTE5OcGlGUXRpYXgyc01OcGE1WGtPT3ZDbjFBcUV3RmdP?=
 =?utf-8?B?RXIwbnc5aVdhS2FpUmdRclRnUHVrL3l3Qkk0bDc2TjRFeFZlaldYM3VxdGhk?=
 =?utf-8?B?cVZ2NFkzcTFuZER1dEpCM3MyWmtPS2Y3QXVNdUx0OENmZnFrcEdTSUJpdHRE?=
 =?utf-8?B?UG9WLzA3cDQrdWI2djRoNVhuQ1lyc082c3daNHc3anFuaVFYUnNQbEhEK0V2?=
 =?utf-8?B?SUJpYWlHYTBHZy9Fakx6U2xmUGQ4alplUWZhckJ0RVQrdytCME5Tb2tLdFdF?=
 =?utf-8?B?MlFWdFk5R3E3WmdSY3hnczE2SzNLRDNIK2xBVlB6QVd4WUU2bVBTY2x2UjNU?=
 =?utf-8?B?c3lxUDhRY2RLRi9aNjNtcTNGMU00MVYrc0ZiMDFXTTFBODJZVjhvMTU5NDRn?=
 =?utf-8?B?MXJOY2JaeDBGRzlvaUI2cFl0Ull3YTd3ZHArcy9IMmwzTkZUYzVmVStTVk1R?=
 =?utf-8?B?dmVZZ3ZHYTdwRFRFMHBzeWJSalNWbG9OR2p5MnpINnhWODdyeWs5bUxWRmx6?=
 =?utf-8?B?akJKWkhVbVhhTTQ5YlljV3FOOFhNVWhkUDNVVXlWQlJKbklIOS9yMTk3WjdI?=
 =?utf-8?B?UnhwenNQTzNXaGp0YVpSdWpiVzNZTFlLMFE2YUZ5Sk9SNHJYMkpPa2hMYU1W?=
 =?utf-8?B?N2lqVkcydGhXczVvWHk5aktLVEE4ZnlRdWlYNEM1MVF4ZlE0M1gxMnBVRzNY?=
 =?utf-8?B?WGNYRmpTbUpQQmtEMytWeDlBZktNTmp2bEJtT0FPcVJjZGE5T3ZFSEpWL1Nh?=
 =?utf-8?Q?PiisONDSyI8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6201.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2hhMmx5ZzI0cVR1N2NTZ0ZDV1pzdE9mcnRXdkVvRngxR25HaXYvVi9hcXRI?=
 =?utf-8?B?VkRUd3R4YzFDUHRacW5jVmR1eDZNWnNmOXJWeThsVUhib0ZMWmFNMXE5U2Zt?=
 =?utf-8?B?OEM2M3hhODlmQlBwYlNqaEpDNlk5R2s5cUh1amhKdG1PbFdsRG9Vb0dnbExk?=
 =?utf-8?B?cjM2dUVwOUl4a3RiL1owVjVQTCthTmNidzcvcmRESGZUZ0VtQXpLQksxVjl0?=
 =?utf-8?B?YVQwdUtCajBsMlUwcUhKZzc0ZG1qUXhxQmtwamxDUDR2bjEyais5Sjd3WHBm?=
 =?utf-8?B?YWh5bng3OVNKWnJLN0wxZndwSDl0WDNMRTdLTWl4T3JKWEpWVDdPa0FDSk1I?=
 =?utf-8?B?TzF0VXFzbzhYNWFBR3BQWWJRbHlzaGtpRVhjaVdlazJyYktkckVWQy95eW9N?=
 =?utf-8?B?NzJSeXR3c0xTc2dtUWFTVzU0eWRYT0p2MlRXZGRpTmdodmZKY0tndVlxSGIz?=
 =?utf-8?B?S0x4akN6c3Z2SHBoV1VndjNuaTlQbGNPYS9icWI0aU9oNjlSRjJkVG9IQ2du?=
 =?utf-8?B?alptYzVHaXowRmVkQ3RGT0xDU0NHL2UrWS82VnY0dE9VN0E1b2ljMFY1eHlq?=
 =?utf-8?B?UlYvOVh4dUxwa2twdjdQMVdsblNSbUNzd1hyYkJaYkRZZE1jY3hSMnJ2cWtI?=
 =?utf-8?B?M295dHJnamwwc1ExZHR2bFduWldWQzd0NWlZTVJJS3k2UndrcnhxZW9mVFZJ?=
 =?utf-8?B?TTl5NzdMbDh5UnNNcFNEWFlRRDVJamhyR3hkMHZiRTVsMTNuQm1jOGtubGE1?=
 =?utf-8?B?MmNrUVhTR3hHd1VtbzIveUltNG5uTEFZMXZZSGJOc0NRTEZTYUs2ekVxQWl1?=
 =?utf-8?B?S2Nqd3lFUnpWclVyYnRxVFV3RUFyN3dEREMvclJ0OERJSlp4RXpQOHVIM2FW?=
 =?utf-8?B?MXRDeUxzejg3djQvRCtibmZiSkV6bWJnUnNUSC96OUdFVHBzZDFaTXUwaC84?=
 =?utf-8?B?Qmp6am1UWTI5alY2SzFqREJvb0lZb0piN1JpSVFVdUdxMHNLMlVtMEpnWnk4?=
 =?utf-8?B?ZDlzMWVhejY4V01PRm15TVhxM2JHdlpEN3BkUDNVWDUvZngrR3VrY2tNcnBU?=
 =?utf-8?B?OWJkUjVXTlcvMWVNcXZrc2NNMmtnL1orVmRDWnJTaVlha2hBSENYbjFseUIr?=
 =?utf-8?B?SXlpS2RoVS8xWVBSczlZSGk2K081UHhmMnFDWTZUYkY4dWhwRFpzMTRBbzNC?=
 =?utf-8?B?ZnhrSkdrRVFhYnM3Tk1OdXI2OFZBVEFrbGZQNjJwcHd3N01jUVMzbUdSS2Rl?=
 =?utf-8?B?dkkwNVRPcWM4MGlqUi9hR1RmVmpLam92TEdZS2hQTTBkQ2ZxZTBkNUpUUCsr?=
 =?utf-8?B?a3hKdWtzOThYM0c3NXMvWVFGam9YMmdVU2R2cUkwbnpPMmg4TDVNUDFTR1lF?=
 =?utf-8?B?S29uMDllNW8zYk9UcndDdVpYb0ZUWUt4M3gvTUxoQmxTMnhRRHh6WDVoOVVi?=
 =?utf-8?B?VlFVVWJtb053MGFoNVgvSSt0MURTSi84V3pDR3d4dmtyWjRyc3VodDlGTWIr?=
 =?utf-8?B?SWlyNFJFUUh2d1JOYlduTENvSjZxWG9qRHdITWFBT0sxR3d5UGd6dVFmR1NV?=
 =?utf-8?B?cHR6RzFVdzNUbnhUVTUvc3YxN283MWRQb0JJdGdGMzh0NFo5TE13UTZ4YTZp?=
 =?utf-8?B?ZC9tbkE2aUR3YXJZd041VjdrRTVQdmtXelZ6UnVML3d0RHIzMDcxQksxZ1V1?=
 =?utf-8?B?SW9OdEZ1QWhDTnBPWjBPNFpjUk1OV2pwRFY4cFpkOEw3Nnp4QXZyeGZWM20x?=
 =?utf-8?B?dXBRNnk2QWFVTlFaaWMvUmM3eFlVNGo1dGFDYmd0RmlBR0FiRC9sOFBhVHNz?=
 =?utf-8?B?ZVhDckQ3RjFkOVRYSVlGUkJJcUtJVkEvQ0JuR001UVJYYTFSdG5hT2tqRFNj?=
 =?utf-8?B?Q04vRjF6Q28zUzdGeHNDOFNNekxKL0hKYXBNL3BzQlNBQUMzTEVJKzV1YWhp?=
 =?utf-8?B?WUxaYmlON3RHb3RrM0Q5NCtrL1F0Wng1d1haK2YzdVJmMDhXMVpUM0owVHVY?=
 =?utf-8?B?QjlDdEJNSUtpZkNEZW0wRWtMZGl6a25QK1VkMC8xeFBVK1kzVDBzQ0FERlZz?=
 =?utf-8?B?Wkg1bWdjRHFOVXNHNEdPQzJyWEEzZnRRdk5SeldIRFRuU2x6YW04Zmt0L0hJ?=
 =?utf-8?Q?BJNqH57gpw7d25GxNMt3JxAaS?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb866bf8-230a-4d95-c57c-08dde160fdd3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6201.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:48:05.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6o5GcyyS5aEluczEcaPKgH/ahmkoMIIFfFFO046SpbGlG9kCPGTaiDm+GZ3kVXi42C3rfbUTamtZ3TQDg7dKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5613

Hi Greg,
	sure I will make the change in the next version.
	

On 19-08-2025 04:37 pm, Greg KH wrote:
> On Tue, Jul 22, 2025 at 11:30:42AM -0500, Dinh Nguyen wrote:
>> From: Mahesh Rao <mahesh.rao@altera.com>
>>
>> Implement ID pool management API's which will be
>> used for Stratix10 Asynchronous communication with
>> Secure Device Manager. These API's will be used
>> in subsequent patches for ID management in
>> asynchronous operations.
> 
> Please don't "roll your own" id management.  Use the idr data structure
> instead.  It's simple, it works, and we don't have to review your
> hand-made version :)
> 
> thanks,
> 
> greg k-h

Thanks
Mahesh Rao

