Return-Path: <linux-kernel+bounces-816631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA283B5767D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7524432B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1C82FC898;
	Mon, 15 Sep 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s3FlLIJi"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541162FC029
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932490; cv=fail; b=hnSsY3YDlWblT69IblNCEYhyNHeehwVIidH/f/q7D86KjznBfqAGQ5Kn6gbKW4p2rThWako3OdAsGvds3qUZp5mATJV3BqHOrHHPH+Zys4WIMxYY3LTiNnGJMJuOTOwVtN6rccFb/s1lLgvlYi9+qDikIAsDHFzEp1Z/QXPwJGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932490; c=relaxed/simple;
	bh=0/TKmK6aTNM/w8/1bxZSTGH3akDIYB7gJmBHixsUzZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WQyymKjVZM0KTma5S+cbSaSDcegk5sTSjGlnJO3+e164sAuUCRkex7RBZwI8Qzd892Kt9UO/bsykeCB5T1Ry4Z6/roJW09767mJhZfjQbQrrr4Pra6q3abOrI3RGLqQBgaO3prrVw5t50ijU4N3rQ018xuPjDp1H0rDD1xmoLsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s3FlLIJi; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQJlfrdnBSTTGEAPCRjM/+pFgYeAFlIFzk8mPs7OqpWVZm+ABe3QUWvSZ6FAVDXn0ty0Mm6S4LNpPl6ui7223SgX4mVM5+HvhPvFJIeGQhTGq94lja++qmWzZX+UWLLcmGVOLd/v7NUegPCGX0S5QWXrMkWmKtMl0sTtCoR6tCqnazy2GUmhUxkXng9raGH9FZZRI632wwV945n4rUhZ/VrlM7dFRX5aJCJMIRJxKYnW6tcg65kjPSlWu3n4No0xdTOj6jjhkMeVDmoQezhehPSNxsuK0AEtBPoSsH+rM8eev0kh18nOGkYzQ5D5xaxdICVCzr1TXYw9yRQhyOhKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4sZyJbgHvqvNv5qS1hWDcGLFCRE6AuzwBkC+ZmqJpQ=;
 b=pkFu7sN6oF/Fw+ObW+QKzVQOYRdSGVFF1P69RRVq1lKT1AVwAN2AErIejv6xvrMNR3rkwZPn2HSKqhEQoY677jfP7X/7+TAazkf4gRbOrTiyQkQCufr4tgG3ju0IOCnUUuuS5NAnRt34v/H7eHBrsLEjS+0lNNmPBOMw4pCsD/iof/SaN+wAkuyYMsU/MvLzP7R/N90ozDOQ2pS19dpQ6bCFafu+vuL+Qxbplf89aL8Vm+/yAKBUmAemc+jVsSuRlk8xmasz/PgXn8IDHWarrdcSW3GVd2HuNIXZ/nEOzmRB0qEXmNzjup7FCU4ZMhL5g7LynrJOkeoQ1uHxTNM4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4sZyJbgHvqvNv5qS1hWDcGLFCRE6AuzwBkC+ZmqJpQ=;
 b=s3FlLIJiw0+vQ0m6tuvHIsEbpGdf69iM3PMGad6wVfWb4iDIoKKzHvfkevJeCRXGNfi9155cibn+J2gChXoKIHfXiPiQoLJvfDkB/CR+B++2SRdflPZfP2zHS3sW4PFiQrkLvtAbVoCyWPR9stdY+/GxHaIWv9cUX+5tAu2SG/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 10:34:45 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:34:45 +0000
Message-ID: <5c9f7100-0e59-4237-a252-43c3ee4802a2@amd.com>
Date: Mon, 15 Sep 2025 16:04:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Target architecture of amd-sbi driver
To: Jean Delvare <jdelvare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250915112834.1d566970@endymion>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <20250915112834.1d566970@endymion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::6) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 976cbc89-232f-4690-e69e-08ddf4437ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjNEMDBBRFhQcWdGbElKd05jejlKVFRqeG05MVV2dmFxNllxWHFMTDdlblA2?=
 =?utf-8?B?WlZ3Yi9pdUc2Z1ByNDhGdDNZL1JodWpEcFcrMlNSaVpEMVIwZ1MvYmVocXZx?=
 =?utf-8?B?NVRoZkhCRmZnMzVlRkVUS1FERjc2MWwrVFZIbDdyeFJyYi9GYmFHdzI4dWpj?=
 =?utf-8?B?Y3dHVEJSTEN0YWZWeklFUXFUT2FPa2JjckJWQlJ5Q2JQSTJKTTVuZ3dBb3dV?=
 =?utf-8?B?Zmszb1RTV1c4VHUxRFZMTTBobDBuNXhqL1RyWDZaTFpzY0V2NXNWbWtkcXNp?=
 =?utf-8?B?RGpZWkRFd0x1Q2dMUkRsQnNvbzJlLzFybmxDb0dsWWlRamE0N1RBdTJONWJl?=
 =?utf-8?B?dExKYjlqcVBlVVJXcy92RFVuamdWSENFR3hJby9LOHdGK0tYM2xiOUNtVVVL?=
 =?utf-8?B?SStvbXBJNHI1dEhTeDAvQzBTTnNpVFN0eWp6eWN3MmZFMVdGVnV6NGVnZVJq?=
 =?utf-8?B?VHAvL05HYlpTWFhzOEtIV2lrVERYODdSQkJHSVZsSHExNjRJRXRkWXZObXZu?=
 =?utf-8?B?ZkxFcURIRUE5Z2VwR1lNTW53aHYzR2g2eGlnSnJIQmh1dkFkZkxQOHpSME1R?=
 =?utf-8?B?V0JXQ3VYYXhNd1JUc25kdDhodVpWNDByelJXbWhEMWdRbEIxVHhYMHpodVZi?=
 =?utf-8?B?T3lYeWtYeVFPZFhPbU40UGw4eHlRWWZBOFhpd1I1RGE3UUZlWmJKU0IrNGtS?=
 =?utf-8?B?alkyRmUreG56SWF5ZURaQXVpN2RESEVQZytieEJGOFdTMGNuanhRK3pMaXRk?=
 =?utf-8?B?TkppOWI4QnRtOWZtcUZIWWR4cXByRUMrQzJxbzFnQ093cjU5RjRySHJJQ2Vx?=
 =?utf-8?B?Um1VN21scHoxS2xWN3NYN1dLWVYzMHhkKzJtVkxENDM3T3U1d0NzanRFb3FB?=
 =?utf-8?B?bFY5ZzVFMkdsT1g4dzl5NXVJT05OWnJsMThvUmtvdXgvRE5ZdFVQSDJXVFNS?=
 =?utf-8?B?ZWs1a2lES1A2bUVISXNYaU14azErMjNMdG8rQ3lqQXdXdkxkR3pEVlBnQVJ3?=
 =?utf-8?B?ZTNTVmdRQ2gxTnYxazdpNnk5MmwveVJ1Yjk4TU9FZklHOTJXbEp3Y1B5VVV0?=
 =?utf-8?B?VnVYMXU3bm1SdEVqVW5RTTBJYWJXOVprZzN2NkxIK2wvWC8zM05zNHEzc3I3?=
 =?utf-8?B?aUZhTXdCRFhvNkFlRGlNdnJsR25GV0tuRFB1TXFQZ0R6MzRFaTdCVzR0bzRH?=
 =?utf-8?B?VEU2RElZUDkzaFdtZEV5TzhabHg5c1Q3SWFtanZDb2pNRWxLOTcrZHQ4U0Y4?=
 =?utf-8?B?WVJER2dENlV3eW5hektrZms1TmpuZVl4YUJpOXFXOGRwUjA3anNjWnBrdC9T?=
 =?utf-8?B?TDM0bys4N1NGb1NXVjBrUFJCYTZQZmlnaUkyVldzNEk1ZU5GY2o1d2dYYlRo?=
 =?utf-8?B?N2pFY3JiQWtLbEg5amdpbGlnYTQ3b2pxUVdSTFQ5TFNqaVAydjM4MjdVZ3JR?=
 =?utf-8?B?RHhZajdZUmcxWW92ZUh5dXZRbHN5dkk3azluc3FYYUQ3S2UrWnRNMWNUWG1I?=
 =?utf-8?B?SHM5YUVCNjJqQXRmRXh4Nld0aXFhbU92R3MwUjN3TmFEQ05IZWVlcm9xeldt?=
 =?utf-8?B?VmlReWpEekJ5c3prcnBhUHVtbVVFT2tnbXZ4WE1WTkJ2amhEZ3grUXdLbFlk?=
 =?utf-8?B?c0xlVXora1c3L2RPZGI5UzFmTlk3bUZzYkZMa1dSdnVPVlpqSWtNbktTbGpD?=
 =?utf-8?B?K0ZMN1llbTB6bDlRVi82dHVhYXB3RFhmSXdoRkF4alQrNE5QdFZYODYyUVFG?=
 =?utf-8?B?UmJqQ3JsZnpwNzRraUFWUTBza0dUeGdBazRKazcxN1lGanN3RjBhbDc1ZWp0?=
 =?utf-8?B?cm51ZlRRMkdYaDV3UVo5WnJxYVdCVTlBZVpwdjRka2VVUXF4TEo3SUdiaklj?=
 =?utf-8?B?TnpzQTlzbzFXMDJ4QzJFcTUramlQTE84WitGZFVyaTE2cTlydU80Q3BHekJa?=
 =?utf-8?Q?Pw7yBoCFnlc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXZHM3IwQmFxQzF1UEw4SlZaYnNBaWNzeHBkbkdEcUZZM3pabWlGMnpvUXRo?=
 =?utf-8?B?TEpLLzkzTU15RjZ2R2RESERtZk5mMXVYaHc1OE1IRlgvNm02UVdXQVJta01m?=
 =?utf-8?B?cnVZOHZDOWU1NU5temZZa3FVTThOYzJpUnA4NDMrN1VqTEY4a3I4Y0FkWTFQ?=
 =?utf-8?B?S1Y2V1JkK3RKbjFSRXpIYWR3bzBXbkFjNlcyNEptb0RHbk5IQ3E1RGhGQWFq?=
 =?utf-8?B?bVEwRWF5SWRpWGdoL2xLc1dhTzRrTlhBTGZrVE96c1B4VWVnWm92QzExZTRa?=
 =?utf-8?B?MG8zci9MbmwyUFMrY1kydENWWDJhVlpIdjRRcHBvTWNadGdzeDU5MC9XeHZJ?=
 =?utf-8?B?VE1YVmQ0dDhFRHQ1cG1LaGZIU1NpeTVzUEM2cHcyZllpOCtoNmZhemVtY3By?=
 =?utf-8?B?QzVkVmZJYWlXaEs1MGdkc2IvQlBsNkN2YkVDVTNra2dCVlRVZEsvcmtteVF6?=
 =?utf-8?B?a0VuT2crbmRnYUU5ZnMyTmlUWXA3QjBwUTdWYmVWMU8xMHg4b3ptcXh1YzdS?=
 =?utf-8?B?QkR4MGJWT1ZWU1dHSG1tTzh0Vm54SjhWb3l3cXpqQ29qN0FndFZXb3dMNzAz?=
 =?utf-8?B?SDUzQllIVDYybjhDVHVPbHprUzRoNUFyVHdPcGtuNjdMR3UyZ24xTXpUV0g2?=
 =?utf-8?B?OWRrckczckFLbnRFNXR5Z3E0RUh0T1NaaDRBN1RMSnBVV1NrenJWVmJwSHdm?=
 =?utf-8?B?dkJuTTFoVFg2Y05OdmdPOE5NbUJIRmgweTMvd0ZOeGEwVXpiNkVDK1hxVVkw?=
 =?utf-8?B?SnFHWFpxeHV4SXRhWE9KTHA2aVRSaVVpUjh4bURLRU9YTTNGNGNLWDhxbTZo?=
 =?utf-8?B?UlFVVHh0ZTBySXV0RzBBbE5BSmkxZTF3ZEFHaWUwQjFpbnM2R3JoSFJHTzRX?=
 =?utf-8?B?bmRYV1FYTlFOL2dUVlNKbXBSM0JMOTlYcFdiZzMwRGZTWithVG5PdFFwUUo0?=
 =?utf-8?B?SjR6WllWTFdobXBvYTF6dElmb0xnVEtXWEU1bGR4T1RjaDk4NXVmUWxHUDMw?=
 =?utf-8?B?eWoxbFc5ZldqZzU0MzdJdWpmaVlTNjIyUFpHR2I0MTRJbzY4Rm9raVZ5NUEv?=
 =?utf-8?B?YVJVdkx1VDE1U3pIaW9laTBNaVRzd1RyRzg5cVd5WjdneUJLc2dsczBjaHlV?=
 =?utf-8?B?ZThReC92Q3didUtKcjhmOHN0WC9yM1dMOXRSZitWRkU1UHorQVZSa1ZYWURV?=
 =?utf-8?B?Yk84L1JoWTQ4M0hsVXJlTjVmOGQxR1hhT3hKdGlrNGcrblhnbmQyM3VOTXl3?=
 =?utf-8?B?LzFhWE95MHBreVFRVk5xVDY0Z2hhN2ZTOXdwUlJIWndGYk5UT0c2ZEp5d0Jy?=
 =?utf-8?B?OFdSZHhJSU0yR0I0cmwxZnNwNExjR2xFMFVueThRWXgra0dFQkhmempSQ0xo?=
 =?utf-8?B?emhYY0JSV2hXUjJQbUwyYVNrV09oNEVsbDBJSG1yQ0VRUHBEM1YzWk5LOGNz?=
 =?utf-8?B?c21GS0RvRXd4ZTVFTzJkM0FDNnNwRUFnaUc2YWdGN0lpT1VCU2tYUlRTUTlE?=
 =?utf-8?B?ajlwNk9zbk9yT1puL1VmUm93TVZQajNjbFU0SEd3U09naUY5UXJsZHlmQnkv?=
 =?utf-8?B?U3BGWWlRTXZRTkVxR2hkYWYwVk9qRTQyREFZRmlpSTFXMUZDdTBTcmpqQk50?=
 =?utf-8?B?elFzeDBSaDIyUFB4NG1WZEFKbjZ0RXZ5NGtKNGF2MFFHRHQxMEF4M0I1RlA1?=
 =?utf-8?B?bnMza2RBcU1WQTcwUjhrVlpzMFFxM2E4dGUrbVlkbjlZNk5uS2JSMnJxSXRC?=
 =?utf-8?B?WFcwUGxrL29saHl0azlyUCs1TjBhRU9kMmhleEZhak1jWG4zMTFmU3IyQlBC?=
 =?utf-8?B?dmxsWkxRdC8vTFFVbUlHaVJWZFl5VjdlYTg2clZrYW5FenR5Q20vWXRxY1hq?=
 =?utf-8?B?U01aRkNEbm84TW1ZbkNSN1BGNVc1bU9BaXIxYTBVU29FcFZ0emsvVzdZbjlN?=
 =?utf-8?B?RDBINS96SEsyRGswR3hFNmNIMys1cUF1Rmc0eFJnUTE2U0RyS3ZpaW9YelJO?=
 =?utf-8?B?RnFpS3JtUmRWNUI5Y3ZOSEJwTU1tWDdCdG43cUdIays0WVEyY0cvWnR5Q2Jz?=
 =?utf-8?B?d0djTnRRZG1WRmtNVHBPdGR5RjVvcnFTWWV1akRtbENZTGI5elZmcVhvdzVM?=
 =?utf-8?Q?dCOuIQFX31oc1cGyyWOAXoHla?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976cbc89-232f-4690-e69e-08ddf4437ca2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:34:45.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99tm70CgfH9r3nKxZcwhq0Ah9atxmayWR7LadGVm+53daCR/YIfjRkWhTAy4zXk5iet139YMS/3PE/C6o1RYWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091


On 9/15/2025 2:58 PM, Jean Delvare wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Hi Akshay,
>
> The amd-sbi Linux driver (sbrmi-i2c kernel module) can currently be
> selected on all architectures. Is this driver intended to be used on
> the host, or on the BMC, or both?
>
> If it's an host-side driver, it should not be proposed on non-x86
> architectures by default and we should add a hardware dependency to it
> (or'd with COMPILE_TEST to preserve build testing coverage). What do
> you think?
>
> Thanks,
> --
> Jean Delvare
> SUSE L3 Support

Hi Jean,

Its not a host-side driver and is intended for BMC. Today we are using 
over ARM and ARM64 BMC.


