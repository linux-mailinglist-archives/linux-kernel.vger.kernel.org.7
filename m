Return-Path: <linux-kernel+bounces-723064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D9AFE24A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB937160A5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A8238159;
	Wed,  9 Jul 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fetCA905017.onmicrosoft.com header.i=@fetCA905017.onmicrosoft.com header.b="Zm6QwTZ9"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022101.outbound.protection.outlook.com [40.107.75.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760B44C63;
	Wed,  9 Jul 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049065; cv=fail; b=g4q8ddg67cc4FwHKzuhkJIrkmTCR0FWPVq55CucdYwf+Ab+4AxfYJF4xRVwiX1sQm9lrG2H5oNa8xU6VPb1SsEhPRr+xtnX09r/dKIfR3cH3Lm8i88gfQEa/1vRHQsvNjzDBTIIv3jxhe9GLLMPSgW4CIBVEu93pd3z7XcWfh0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049065; c=relaxed/simple;
	bh=p1/C8FcvwZLJDPRxvmoYYD0fEe8tDdIM5k+p6J0hatA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJjUJ1A6Sxa9E+7q0c9hynLIaFBBq38VB0nMYUY5oNlqJixezr3PH2fMMNY0Gldbb+u+y9UQmRiOjA9mWo80/RGOH6igoUjKI4kkuJWNaVqSBy5xqU8OoFbzS3TKXK/KGGXmMUAzmH826yXmzdrRRn/5W5n6guEhfZgJ0mRtB2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=portwell.com.tw; spf=pass smtp.mailfrom=portwell.com.tw; dkim=pass (2048-bit key) header.d=fetCA905017.onmicrosoft.com header.i=@fetCA905017.onmicrosoft.com header.b=Zm6QwTZ9; arc=fail smtp.client-ip=40.107.75.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=portwell.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=portwell.com.tw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peSw5Vqe46eYiKWcnlXvg/swdeSqXb9bBWKaqtOjnz6QjOnhNWqzxs/Fl8GrmdLUg59CMbdoeK2UopVnwbvcWRypb8RL4dLzrVbuCjxkX3PhXlLGZbOteFgvGhcH27ygz667nPcl272EcrA9hxSu0rzlPT9vTDhie/tyd1/AFKjZjCxGGlhgPm752Bs8dDQDM85o9WOhAQTzxQKAMTOZuLEVzd+ObydXa2UX8RafqX2u/HDGwraQeXEED6RB1rk6XzhK8q3TRRvpu0s83S/nj9ZTDxzUBelfg2a7mY65oqKHXvR2I80q3qB7dR6z53GwRzciSmoQpKEWKUkl3V74Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhE62SHmTdIvNl8PygYfZ62hNMSTvmS+r+YQoGKjhE8=;
 b=FR0UgayIVo04fYwSbib9TtyocAfy5ThAIZiiMh2ZDr0OWqYSTS8J6yI5L+IsI45/MAV8A2GuihIvhl47lEdFbHW8mCJI1rkI3cBqq2ootWpmHbRB+KDvSRrJCeWJObqQvcI6hNLHyNQc/pqLmqdJyV+EzM/xXw78WhY0utYP/dQuDKW6T20SfGXOuo3slIWa//ye4HbYkWUPTfo3QbARwgIMz5N5VijyOlM24l4MnXwQo6zu6HEAp3LDycLOAuucWiaZ1P3vV+lRWs00gmz9zeeRYWf+OuBINYvlx7Rer5crRQ2mOC+KNDysMO3VdecpJ4RV8OTq38Dhuckd2m41+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=portwell.com.tw; dmarc=pass action=none
 header.from=portwell.com.tw; dkim=pass header.d=portwell.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fetCA905017.onmicrosoft.com; s=selector1-fetCA905017-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhE62SHmTdIvNl8PygYfZ62hNMSTvmS+r+YQoGKjhE8=;
 b=Zm6QwTZ9rHAHaQfGIi922z3u7mbabaRO2jDb6AKC63o4lvqJ/lluTA4HhogJVYnvJ/GM2sH6WAyvlm1hw1nZMeG7x72ANq9S6fzGLjbPaSGeHoXwPRSYFKIP0tHhLRhZ+0LDILDA5TfLTzxculew9pJrcu3F7qHyYz7hPqrfxWvicD2LfHYuvKILVnia68oGSyoiHsm3F+ayF+wlidjAaHiSF4Mr7aErTrqt5qAtgKOVPKS4Pc/QGUAYuvffhYUkrNUCRkXcIsVjHugA8u6P1SwgA6Ubi0DZwoC/YgSX7bU6h4Ap8+Dv8iY7cla0Lo5NeNDjBq/CsLbDYKTj452QdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=portwell.com.tw;
Received: from KL1PR06MB6395.apcprd06.prod.outlook.com (2603:1096:820:e7::10)
 by SE3PR06MB7959.apcprd06.prod.outlook.com (2603:1096:101:2e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Wed, 9 Jul
 2025 08:17:38 +0000
Received: from KL1PR06MB6395.apcprd06.prod.outlook.com
 ([fe80::9235:5570:71b3:224]) by KL1PR06MB6395.apcprd06.prod.outlook.com
 ([fe80::9235:5570:71b3:224%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 08:17:37 +0000
Message-ID: <9d5d40ed-db62-4d0a-9807-82b231135b0b@portwell.com.tw>
Date: Wed, 9 Jul 2025 16:17:34 +0800
User-Agent: Mozilla Thunderbird
From: Yen-Chi Huang <jesse.huang@portwell.com.tw>
Subject: Re: [PATCH 2/2] platform/x86: portwell-ec: Add hwmon support for
 voltage and temperature
To: ilpo.jarvinen@linux.intel.com
Cc: linux@roeck-us.net, hansg@kernel.org, jdelvare@suse.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <a35d63e1-424f-48ac-bc97-cdb48929f40d@portwell.com.tw>
 <a25733d7-535c-44b8-973c-0bc0c99047c3@roeck-us.net>
 <62e4e647-9eb4-4329-89f4-6b2b897ba15b@portwell.com.tw>
 <ec0d2c2c-6849-7863-bf0a-f1abb1747b44@linux.intel.com>
Content-Language: en-US
In-Reply-To: <ec0d2c2c-6849-7863-bf0a-f1abb1747b44@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To KL1PR06MB6395.apcprd06.prod.outlook.com
 (2603:1096:820:e7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6395:EE_|SE3PR06MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 593df0a0-9551-4e9e-e873-08ddbec1108c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UC9sVjJCWkxyNXUxTm01b0hvUncyUEMxZFJNYkhtNVVCZkg1cGRJdVpHaGQ2?=
 =?utf-8?B?eFMySHQ1SHhUQlFCY2Q5MWVXZmVMTW9aNGlJOUZzaHYrSE1HNTJrU1QrL1Vh?=
 =?utf-8?B?V0FBNFlRa05QbUNBUFNCSlVDdFZTaUU4Q05aanNvNjJzNXhLUHVGRW1ZcytI?=
 =?utf-8?B?Zm5DY2laZVd3bW1JWkR0YlJGSEtCaTZ5TzU1SkdBTlRyVTBpOXFQYTNnb0xa?=
 =?utf-8?B?OGJZZXp4cm9mSEpncjFlN2Rjak1LVlhuOG9KTGZjZnYza1FxVlhTTlFneFl4?=
 =?utf-8?B?SjR3SjlmaFNPbGg5VklIWkpyWHdlUVl3ZnRmWDVqTnpLVGpscGdwaHNzVVcy?=
 =?utf-8?B?b0NqejNBRnVid3NxeUQwYk9uZGFMeGFVbkFsalhBMFZaUVc1ZGdKUXhSMDZL?=
 =?utf-8?B?OTNkNkJBQUVsV2srRGFLWHBkSjI5N0ZhKzJPeEYwcjlGS0dGTTFXNnNCTlRE?=
 =?utf-8?B?RUlpWS8zZ1FTU2lBWTFiU0xsSzRSR2plK2lIKytEYUZyUHUrYUxxcmFHRDNi?=
 =?utf-8?B?VnI0WTk0K3lWUkRwRWZERThIRGE0WitpNlJXcEl6cWVzM0lpdlZtME0xd2cr?=
 =?utf-8?B?MU5laGtqZUREalFucTlsQTRxeHdOZDVxQUNKM01aT1Vwa1d4NmFtVEVUam5i?=
 =?utf-8?B?RHN4OTlOSitYL0d5QzNNRnJTTDdsalI5bUFaQXRsWkp6RnNiWmdGdlNMeG01?=
 =?utf-8?B?SEg1eEpyVTRYM2lWSzlMTWY0VlFXRDRwSlhoSzdLSy9IVno1czVHRG02aEtp?=
 =?utf-8?B?b3EwZEhRWW51OE5rYnRGTWJmK1lBektXVDI3RXpzNTNDNGJBc1NteHV1a1Vk?=
 =?utf-8?B?OGRWM1M1RXA4MU9WWFE0QXJqd1hydTRpMFZoTkZEdVArTnk4ZlFPSlRkK3E1?=
 =?utf-8?B?VFVvTXpaSnU1aDA2ZFFDdGZWWkdhQ05RV0dNdVdRdlRKM2dDSTFTcjJZQzlh?=
 =?utf-8?B?VnB0RkFwT1B5WGgxcTFCTE9HSU5iZW9oWFdDMkxEUy8zRGJ5SWRrOWcwZ2po?=
 =?utf-8?B?bUJRUUsxVlhseUVtQTFjNUp6ZmpGSHRnQnMyd2VGMGlHdStLOXNtb05RS3Rh?=
 =?utf-8?B?bUFIWWZKSWxFQzk4YnhzT0ZOOGF6M01SeTk0WEpURVIzUFZlTEQ5NXZ5Qlhj?=
 =?utf-8?B?dG9ybGlTeEVXdFBFdllUcytLbG52MzVGY1YySFFzall5ejMzdDN4eEpvcmRo?=
 =?utf-8?B?UWpjb3pZWFN1Ynk5Rm5FS1RDY3ZCMHpvZFFQSjdqd1lNZlJPUjFCeGk3czZl?=
 =?utf-8?B?UkpTclVYaGxrbTFCZVJydVFSS0t5QTg5aUo0cUMrbVQ2RmNiZDJOM2NLUzV5?=
 =?utf-8?B?TUMxN0NOZllGSlY2VEl2TFA4bVJkTjY5U3dEY2haQW9NeFRRNUtvaWpUYTNY?=
 =?utf-8?B?Z3d1Qm0yaEpGdTI0N2IyRVdvRDhJWHVuZjFkcVYzYmtuNFNFRUtlL1M2bUcv?=
 =?utf-8?B?aiszWTFSUE15cXVVTTBDNS81UXN6QXRNdlQwMVZwbFhVSnIxNTF2UFl3YjN2?=
 =?utf-8?B?SXVxY1A3cDdVSk43YjVCWlJSUjJuS1QrYkdRbnFVbnhzcGNzdVRXNUtDcjNp?=
 =?utf-8?B?WEZVdlZQQmNMbFB0Vnpob1g4VC9FUVhWcS9scWRYcXlFNkdTR09kTzkyMGhT?=
 =?utf-8?B?eU5EWE01L094TGxBRkw5V2p0NFduMlZMa1UwTGlEUnNjWlNrQTQ5ck92YTY2?=
 =?utf-8?B?SFhjTHRjM1IzNlV5V1kyUldWaTFNR2dGTVVZYnJwOFlvTTdQazVZVHh3S295?=
 =?utf-8?B?MDZEdXRCQS9kS21COFZubGZxd2g4c3pHeFdENXB0MEN5MzRocjEzVWhpUTRh?=
 =?utf-8?B?ZzEyL2o3VTR4OUxmcjBvTTZSK1Z1c3J2bzc5YTYxb0QxZ0pGaGpaM1dwWmpl?=
 =?utf-8?B?WEQ5Z2M5Q0t3aWdXSEh3STBvWGcrbWRrLzJmT1o1LzduVnRZTHdtK0RYMFdv?=
 =?utf-8?Q?xFMVuIbCE6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6395.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXArb3VYNW9JWVl5MllwTWllRVZXTGtmQ0xuNDF4SXhXTW1xNlNhUTZZbXdr?=
 =?utf-8?B?Y1owbXoxbUYzTWFmSjRWK1ZmWDJJZk1tZTN2YlpaWTJrVk9RckdrRlNZRDk2?=
 =?utf-8?B?Vm1aQm1iblU3N1FNNGJYZVVlNUFidlcxV2Z2WGhZdUt3WlFRQ0RHUVVrUVFn?=
 =?utf-8?B?eFIxMDRSQmVhdnNQaDlEY2tCNFNtbWJyQVB0L2xCMlU5RkMxdHJaemM3cVBO?=
 =?utf-8?B?QVd3aTlDRU9QeEdERkZ3a0ZqVlI2YW1DcVZKTzdxT05NRDcxNW1Ba1JYa2FT?=
 =?utf-8?B?cGtmSzlpYmFnK3NFaFdNcWpDL2tXL3paVk5wK2prS3YzMmp3WEZhdDFOTERY?=
 =?utf-8?B?UC9qMFcySkxrQlFYSzF0bDNGc05QT0VMM25zSFZHa0tyVnBEV1JLTUUwSlRR?=
 =?utf-8?B?Z04yZCtCY2ZVdS9MR0VpU1p6SVJFRDU4S1BBRTRSSlR0aEhsWU1WSHJmZ1h0?=
 =?utf-8?B?SmdNZitpT3dQT0VobGNxcHR5ZzYrVnhtTlN5STZoQ0RzWmZ1aGZTMERreXVr?=
 =?utf-8?B?NllsQzNJQ1hTdWVrWDdqeXZQeUFpZjZRbDhYbDQ4M1p6Z3pZRGpEd1YveUdE?=
 =?utf-8?B?VUZybWdaeUFTRW0wTVk3S3ZOMyt3eTlKYnJYaXp2Z2tkRFAwVmp1b0w4ck5V?=
 =?utf-8?B?OGFJZGQ4NWU4aC9ONGtpV010WFRWUkxzUURKaTJRNlZEYTdQQU5kZzdTM0Zh?=
 =?utf-8?B?M0hNMUpSL05heTdjNzR0OThkQ2J2b2dhSjgwWEZCWkFhMDF2YnFtaXNGQVR6?=
 =?utf-8?B?T2hwTUpOOWxsNzNicld4akRwQlJPTndBY1FZTGxpbWVpSjlRdWQ5aGRvMTA0?=
 =?utf-8?B?ZjhRTWtlQVB3Qktla28zdFZnY1V2TDVRNWcvU29NYXFSZ21kVy9yU29mazhF?=
 =?utf-8?B?Tk9YbTJHcFRWVE84RW4vUHZTZksrejZUaUZvSGFuc3g1ZGRyQWRiV3JtdDRM?=
 =?utf-8?B?dW83YTZsdWhyM0oxOFFIMEovWVRYVTFYeG9BdDZwZiswampFNzFzY3lacGpl?=
 =?utf-8?B?TDhTbFhzZjljMzBoVjkvR3YrTjJ2REVZOVRPMnZSeXI4ZkZBQ3BWaUppNHYy?=
 =?utf-8?B?V2l1NzhoOWNRL0prc3kzRGl4M0tvbE5EWGVKbVduLzdNYU9sYk9IVVdVOGZn?=
 =?utf-8?B?SGF4QjNmWGRWRzNoYVhMZGlpakFTbTBuNW5DSlVnVURrMEU1ODlGYi9Hc3Ri?=
 =?utf-8?B?QmJJU2tmbEE3WkdoMi9KVnRQMy9UdTYySkRONisxajR3dWxGS0NNYjEzeW5t?=
 =?utf-8?B?UHp3elZwb1RvNDY2U0VLcHJmdkhmWkxFaXloVVNqOStBN3Nncmd3eVFVcXp4?=
 =?utf-8?B?YWN1Y094NzU0SG83RHdxUXM3Q3FXY29na202R2xlZHZyM2xCelZYbE5VMDlY?=
 =?utf-8?B?N3ZNYjFoR3VxVDdkakJaekZac1RVd0JIYUNIZUxoRHJIY2hqd2tJdWZFWDVM?=
 =?utf-8?B?NGpZdXpjUzJEUVZCbXNra0lJZEMvN2ExTmlPdGFoNzBkb0NyaEZzQnRQc1Fx?=
 =?utf-8?B?MC9oMnJKNlM0bXd4ZlZDeC9rWU1tcHRwTUdBYlFZcmlodE1SY2luMk94MHZv?=
 =?utf-8?B?SEI5NGpiYW1uVmUvMUJMQjhqVmFKRzlhMzNYMW91dFlVOWErbkxCQmdzc3dF?=
 =?utf-8?B?YTVqUm9tVHVlQTFOSGNQeUNSaXM0dDNUbU9pZUorNEM0MCtqbFRvMU0vYllU?=
 =?utf-8?B?YjJwdlFSM1NuNGNXMENEZzNVMDIvZ1hwY0FFU2hOSGdqdDRGNjI2QkZqSzV5?=
 =?utf-8?B?NSt0aUdIUFdFWkFMYnFKd2hGMElqZWdSeUlsMitvMDVEQ0FBMzl2bURMekNM?=
 =?utf-8?B?ay9UdldHYjBwQlRsUEhneVVMWHd0Q3creU1YVGNvQlhFT29wbUpncjNQYU0w?=
 =?utf-8?B?cVRzL1J0WUF0Y3ArNmRwRzg0SElhb1E2T01BVGNPdzNROHk1amU5cmNIY2Jm?=
 =?utf-8?B?YnoxYlVCRXRGdDFreGhIdklBRXErcmVMMkZCQk1USmphbGI4aklVU0pYUFoz?=
 =?utf-8?B?K2tzZXZwaVYzWExEaXZLWkR0c042RmVQNkYyTGhKeTF0Wk5mL3RuUU92UHJZ?=
 =?utf-8?B?b1lYSXU2OXdKT3ViSjNNNHFydG9ndzhIbjZneWZ5a3E4cW1MSDNwRVphdDBu?=
 =?utf-8?B?a3Rqd2EyRjBLdGxGVG1KcUtpeHVRM1dlelBKZXk2T1hhY0cwYWNrb01SVTZ4?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: portwell.com.tw
X-MS-Exchange-CrossTenant-Network-Message-Id: 593df0a0-9551-4e9e-e873-08ddbec1108c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6395.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 08:17:37.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e309f7e-c3ee-443b-8668-97701d998b2c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1XxG3nnkGUSqykYeMvMVCy6SmSuFqldxS2qGGPBzW9PILLR26Hnu2anPYXCBQCLrVXEuN/b6PZ89YKPl55JOTaL1rRtuwmfQt0PBhrxKr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB7959

Hi Ilpo,

Thank you for the detailed and insightful review.

I realized that I had misunderstood some of your points in my earlier reply.
Sorry about that, and thank you for the clarifications.

On 7/3/2025 5:43 PM, Ilpo Jarvinen wrote:
> On Thu, 3 Jul 2025, Yen-Chi Huang wrote:
>> On 6/27/2025 7:34 PM, Ilpo Jarvinen wrote:
>>> On Fri, 27 Jun 2025, jesse huang wrote:
>>
>>>> +static const struct pwec_hwmon_data pwec_nano_hwmon_in[] = {
>>>> +	{ "Vcore", 0x20, 0x21, 3000 },
[...]
>>>
>>> Those registers appear to be always consecutive so it looks unnecessary to 
>>> store both.
>>
>> Some ECs use little-endian while others use big-endian register ordering.
>>
>> To maintain flexibility and support future boards with different endianness,
>> both registers are stored explicitly.
> 
> When do we expect to see patches to support those other boards? I think 
> the endianness should be only added then, unless the patch is really 
> around the corner.
> 
> Besides, wouldn't it make more sense to record the endianness instead if 
> the registers are always next to each other anyway? Do we expect there's 
> need to handle disjoint parts?

The `msb_reg` in `struct pwec_hwmon_data` will be removed,
and the rest of the code will be updated accordingly in patch v2.

>> To support multiple boards with different sensor configurations in a scalable way,
>> the hwmon data is structured as board-specific arrays.
[...]
> 
> 
> I was just asking why you need to place them into an array and not just 
> have a separate struct for each board variation as is the usual pattern. 
[...]
> ...Those can be put directly into driver_data without the intermediate 
> array. So why is the array necessary?

The pwec_board_data[] array will be replaced with a standalone
`pwec_board_data_nano` struct.
Patch v2 will include the corresponding changes.

>>>> +		if (channel < data->hwmon_temp_num) {
>>>> +			*val = pwec_read(data->hwmon_temp_data[channel].lsb_reg) * 1000;
>>>
>>> linux/units.h ?
>>
>> "1000" will be replaced with MILLI in the next patch.
> 
> As this seems temperature related(?), there's also DEGREE specific define 
> which would be preferred over that unitless define (if applicable, of 
> course).

The literal `1000` will be replaced with `MILLIDEGREE_PER_DEGREE` in patch v2.

Best regards,
Yen-Chi Huang

