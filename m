Return-Path: <linux-kernel+bounces-723088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228AAFE2B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8119A58264C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A95275859;
	Wed,  9 Jul 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ipetronik.com header.i=@ipetronik.com header.b="QBGKqJb9"
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022139.outbound.protection.outlook.com [40.107.149.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163D27933A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049947; cv=fail; b=CpQbK3/hjoMXZB9bgMNeRwJVi5vHhg0PmM0GYXNyUS984d+S24jsfE80R+DMtABU87cRACuDAdptaOi1LYoh8M5HRKqqFgldIZqGfRO2u1hDMHUKAlhx05Sz1eeNpKL6RX/olVcvRYlzu69840J1SuwnV9TaOtx0N43hiodJv0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049947; c=relaxed/simple;
	bh=HGjHqeb1VqEzknBC4qcEdLwiyOycvC/myoa4Ot1rQQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6CQbiS/7SM4Y9Oh+5AOH52yHUHy+rK+CDtdF2kktkpCi1yQXzyuIR1aff6k2kl+c5hAtfXo5XJEO+/+1UaZTRxzr2LgSTYe64/98wBgCiHmNUBAydq8Zfpa2Z2cqoxEXFyKN+onH2vXBovkfi3GPN+suckQ0FqTHwMbZ2eEwQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipetronik.com; spf=pass smtp.mailfrom=ipetronik.com; dkim=pass (2048-bit key) header.d=ipetronik.com header.i=@ipetronik.com header.b=QBGKqJb9; arc=fail smtp.client-ip=40.107.149.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipetronik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipetronik.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eATvdBWNKvPeeoTBlJeidy5Hgdpk0E1WJmyzFRBrkili6L3c1FH/X3cadxi+MA/3aZRNZab9K977rjMW0cZW5qFPv1F/XFJ2a7Pkh5q2/sG8kkFXnrZMPfgs56vY1M7hHMYLfd+9RtJRAnhFRTMlosp6C/sMXG9kh0eBAxTkfbpyJPPx4X5rqagS3N32Oc2f/fcMKjC4TA+MP7wCd1k+nMYQNaZV9f0pQO6q79XzK9xkuZ1Uhv+aQJZaf5W9YBHjw4G9UyDBC5bl3XeqPHNUVehnEnH1QtLlIaCXLGmeZFAoiCuVptcS0wtfsA6SJ8Q993kxqd7QkjOj7oCAwkadzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D5IeSRQNK9YHFqcNllSDCriTpDCvJMjh4Goo74L7Aw=;
 b=q+goSfDYKDlCYeLEdu1/LdN2usZqAbmSS0WwxdwTvpLCWZMafeb/9TsXj97dcQrBX6qB6TuATylknYjMNGZ/UDXhLvDAej06njHJkwdsThnVsh4XnLg4HtEQIlKBRavHr31XaN2GmVn1uPbwOfwIacX1SQn+Ut/GL3BextQkHy4wnzw1DzrCe9x9i7lHvlorcPgqWq+i2dykwUUopXsHO9l1A4fQse22EEZzEjCBd2cBXn18Vm7dGkUpmao3HbIexRC8+q1eV8nCX9AM5jvGcm036clrDfiFbN/3fTxVmn9+0MT/iA7ZXuegn94lW7LTOs4ja63JqLy9gnleM3kWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D5IeSRQNK9YHFqcNllSDCriTpDCvJMjh4Goo74L7Aw=;
 b=QBGKqJb9rN3Z4UZeE9rjmp/bBAaZe34njexsa7COljD3T5mqWsnbO2f1+5RUL7nOmTjPoQ3VoJEDBhd88zGRoE9CLCykWrmU7DzvQmwfsM0WPUC+g6guVN1xCRnfyHu2wK2bT3GgWhwQgIVzpanC9ffWPmJW4xl815L6lG6nK/6pH+PFlcC89oiUwUfVN+6ieOMkpRwvO7Ed0hlxVryq/9xHf8iwR3CCDIGqRSEBHwiLmvf/5I7D2H7y0Mb00KLo+FLL/Xf7E6AjBljHHNgvYKx6Q/d6MTpoqL9tw6HAOJqxLjfzuTs0Zo8+55qMq7Z99Yxla36zzzOMPFiDrQGXWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::70)
 by BE0P281MB0068.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 08:32:18 +0000
Received: from FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4f5d:a9f5:8b45:be42]) by FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4f5d:a9f5:8b45:be42%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 08:32:18 +0000
Date: Wed, 9 Jul 2025 10:32:13 +0200
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <Markus.Bloechl@ipetronik.com>
To: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timekeeping: Always initialize use_nsecs when querying
 time from phc drivers
Message-ID: <6rweov4mf5z7sy4k3sfhktko3qt2cj5jgo3y4hvexjtykdlgj7@7tomywnjtlio>
References: <txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo>
 <CANDhNCoRZOs0qNdJqUF=5RBWP0MCCC_4zbvvftzNWwvuX087xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANDhNCoRZOs0qNdJqUF=5RBWP0MCCC_4zbvvftzNWwvuX087xA@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::19) To FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::70)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR2PPF9A8CE9F7D:EE_|BE0P281MB0068:EE_
X-MS-Office365-Filtering-Correlation-Id: 30717809-7106-41ab-a8ac-08ddbec31dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXlta3QxVzQ3UGg4TmpRYVFKLzJ6TjRVdmJNd0VweE0weW1Ka2tkaFlqLzRR?=
 =?utf-8?B?WHJyZkYrVkRYYWdrK0N4K00wcUtlNytXS1RhU0RkcmxSdFBHeW44L2RpSktM?=
 =?utf-8?B?YjNGUkRVOU9GVUIvQkg5K2tDOUhVV1FFS3hGcmZ2WHpyb3kyRGRHZ0hGUkZN?=
 =?utf-8?B?MUFUYWc4MFA0M015b1ZCRkxEelE1cmtpdHEvd0xyMkFpYzFGR3FaZFRmbGU3?=
 =?utf-8?B?dlVCR2dqa3o5enZ1ZUhncXFQcitIY0dXNGQxa1dlZ2ptQTJBY1cyYTBTL3ZS?=
 =?utf-8?B?WjUxWUlqWlJuYzBHMUJaQ3RKYno3K3UrREQxSmlueHBUL0c1YitxbVJxamVG?=
 =?utf-8?B?c2QrbVQyc0o5Y3B4TUhWY0x6NTJtNzYrY0NicEcvK3g4QU40Z3VXSzBYaTg2?=
 =?utf-8?B?WGV1ZjVhbk93UTNKNWI5bzZVMVhoR2pKNTFlaWpRbUhVS0lLS0RqSU0xTnVu?=
 =?utf-8?B?MG52M0s4b2YyTUJtUkY1azhLQjlaZVhVTU5OQ2h2dlh1MEQ2NklmQnpVOW4y?=
 =?utf-8?B?VHRFd1IvSmJLenEzTmhZUDZWbks4amRUZ3IxenBZVFF0ZXNqYSt1ZUFRYjhr?=
 =?utf-8?B?NVhMUUVkcDVTbUJoWTBhWnV6UnRMbFZMQWpQTmladTN4SUVoOFFrVS94MCtW?=
 =?utf-8?B?RktnNVlpZTgwYkxFaTNNRlpiNkM0ZVhMdGhycTBTcWhQSXA0WlA4aTZNWjZ6?=
 =?utf-8?B?SFhaOWJGMkg5bWhSV3BvMWgvQkV6UnI4TjdWRUttaTdpcDlQTUtrYzdoSlUv?=
 =?utf-8?B?c0FwMUFQSWdRL2Q3b3NXZkQ0RWRPN1Bqc1dwM0FBaGN2R3dJWElsV3g1a3Ra?=
 =?utf-8?B?c3FpRjQ0WUpnVkkyMkZ0RnhTUzgrZEY2RmdmOHkvZ1dPaWRZNnpQem01VEVp?=
 =?utf-8?B?NW1INUpGRCtlQ1RyZUFQYVhiYzlid2pEQzRySEtwcW9VV3RPZGd1Vkhnb1Bx?=
 =?utf-8?B?TXN6VWN3WDkrRkF3MkdKSXpCTWpOOWpnOHp0b3J2TWxMdGk1RlBIc0kzU3ht?=
 =?utf-8?B?SlQ5Zmg1N2c5NVgyTHpyemRFbHRDNE5maFNvcmtHWkRKQTVBY05EUVQvSytN?=
 =?utf-8?B?UkZybmt6aGFqZTN5Q05jRDBCMzNXSUpYZ0hKTzBUNnBXUUNSL1pKdlhYRnow?=
 =?utf-8?B?K080Nm8yS3JCdTNiWW0rTnN4SEo3WlBjS0huUlpRU2xicVlJODFXZ0RMWkNH?=
 =?utf-8?B?K1Axc01ReUxYOWUwOGVPQ2hhN2xJY0x0ZVJNd2xWc3NYNG5uL2xPRXd6OVpi?=
 =?utf-8?B?aXNnSEhQSXV3SGpMNmk5em5yWGxHY3ljekJXeC9lZitsUlZFYXdWdXlFK3la?=
 =?utf-8?B?amNpN05mUzdqREM4RW5yYmk5K1pxSnVibldmNU9mUXdLNnc1cVkwb3g1M1Zr?=
 =?utf-8?B?RXhWVUNyYzQwckpBQXlIaHdWZkVHVWFIeXN6eUNGVUxzRmdkMzRkQzhHVEVI?=
 =?utf-8?B?MkxxaVhTQ0JqeVN6RU55U3VSQVA4Q0h3UzF3cXVXQklxMzdLWHpEeC8xRU5y?=
 =?utf-8?B?M3FhTjh4V3N2WEx6dDkzU0VmNnBFVWxaTmt4VDVUWmg5b2xld2c0S0lCa2I1?=
 =?utf-8?B?dHZVWXdyQ3hyaVVLT2JrKytTcU56eW1vMTd4UzMvOHhIVzRaUTE3YjBKdm5Y?=
 =?utf-8?B?WnhVc1RkdWdWOHNBK1VWcjllaGZYN0tLVEFlTkxuem5HcDRnSytrcEVMN3F3?=
 =?utf-8?B?TDhHd3MzRHpEZHFRQXlEclRCcjhBUjJTL25HQzVreUJVY2FEVWNvdWJvVlVs?=
 =?utf-8?B?MEl0cTVkL1dlQUJLUExlb3E1OEtQNk5PSDl1ZUNHWVZlR1JZamJFdzYvZkxQ?=
 =?utf-8?B?N0VNT2xPNU5kbjAvSEszZ0FGeTZnN2dnb3o2QVJ1Rnh5cS94c3F3YWNCNjJ0?=
 =?utf-8?B?R3Fkbk0zczhCMUdLaTRBQkxSYktubmpsTXR5N1A5UEc0bVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU53TUhPaGpNSHNwdWNDUzhtbCthbDBUUGNwSjJvdXhHOVRtamhUNHU4OHhE?=
 =?utf-8?B?bkU3NEUxTktNd0ZSdVgxSW81ajVzR09NNmVNbWdtWEVnYVZVVTlJRnZRWTFO?=
 =?utf-8?B?VnVYbFR2UXArOWo1TVkranBVTCtlaTdQaC9jL3lVODFHZ0FJQlJNMXBXZWwz?=
 =?utf-8?B?RlJKRUd5QURkNktHWVVzMXF5MDZuVzJSS05yTTFYamNxdCtYRGo1UXhFZFo1?=
 =?utf-8?B?Z0dMbHQxU21ZM2VtLzNGT2N3TVVoVVFveWxTZ3ZnZm12dTRZbUF4eTMzcjN5?=
 =?utf-8?B?bWNGanJ3V09PS2lKQzBHeVQ0VHd5dGFCV2R2Z0I0QnhPVmVNc2Z6dHZMRVBF?=
 =?utf-8?B?b0ErQVpWSG9QS3ZOTS9TSmdVNk9zejFNbVdJUUlxb3dqUkpPNGhicm05R3pE?=
 =?utf-8?B?cEhUNVdMR2M0WXkxdTI4SUw5b3h6UWxKcW1GUldvSURJVzFkRHY5MlN5Z1Iz?=
 =?utf-8?B?U3FvUXFHaUJWM25RQXorc3BsOC9OcE42NXVKVjhQcmtJZVVaQ0J5YTNzT015?=
 =?utf-8?B?d1k0WmVEWTkvcDlKR0dTWEZkTFdDcys5cXFEM3dURHNwcExJeTVWQWVwT3JK?=
 =?utf-8?B?OUZVdGdUdURxcHVtVytITEQ3ZWIzNEhiRzRydHRwaTZhclZMcWZXT3V6bUdZ?=
 =?utf-8?B?c0ZzUkVKWGwwQzdubUJRZHhtbDlqU2VFTjg1aTgrTmtqbHhwREVzdmxCckNI?=
 =?utf-8?B?ZThhOCtnaURoQXorYktzTmtETzNNQXJkSTZ4WGw5MkNsYmdjbVExa045MXRv?=
 =?utf-8?B?d0hVRktOeml2UjJRSmdNeGdVWi82S0U1djNYTDdXZ3BBUTR0SFNmZ1hOVytC?=
 =?utf-8?B?Sk5YR0lxVHgwNm9VY21CNWoyQVIzNDlWbXJiZGZHWnQxYk1SM25hT1BIbmh2?=
 =?utf-8?B?MUVtcjkzbVBTTnRZM3AyUWF5WENsVTRvMDRVdThpMnVRRFBGOTRSeEJVMTQ0?=
 =?utf-8?B?RktqSFlVbkoxbFUvT1h0aXMzU0dnNDZMRWNlU0YxeWNyTHJVQ3g4RFF0TU9n?=
 =?utf-8?B?bzJsMDBrYWRTVDFPUHFGbWYvOWkvemFKeDNjc3dJVHNLRFpFZHQzazlzT1o5?=
 =?utf-8?B?aXI5cTlaY3hDbXBaZkhUSFh2cVEyU0p4QkhNOGJlNmd6bFhROGdpZEFSMGM0?=
 =?utf-8?B?c3FyNWVVZjh0ZGV6T2xaUWI3NWZJbXN0WnEyVlVvU1IrUHg0SEtCN3lOODM0?=
 =?utf-8?B?alJ2eWtHejFGSHIvUlEzd1RXWEs1Y2NkSW8vYk54dGZkaXNTOG5xRHVpY3I5?=
 =?utf-8?B?Ym9Zc2R0Yy9OczltTjE3VWJNR0RmRkNOZWQ2aERXZk9QZnNMTUFKTDZlMG5G?=
 =?utf-8?B?UEE5OExrNnNvZk9aZmZrMk8zYVJ2aC9zWllwK0RmRTA1cEdtVjlFOTZnS3ZM?=
 =?utf-8?B?aDB6cWRLUTJLd1JkdkRjZkIxUTI2VkhIa2J0ZnZGVkRNUHhWK2xDNmE5K1hv?=
 =?utf-8?B?a1M1cUlqRWZxbXpKV3FYUkQ4U2JnMjFUY1c4dlExM3oreExoVFhIbVFGSTk0?=
 =?utf-8?B?T1htNzZVSCthcWpYRlRrSEtBVndQcVdxNnFHdTJHczhuQUlWSmdRZWNBanZl?=
 =?utf-8?B?RGJ0d2hhaytoWk5vK21JdFR6MXNUYS9vbk4xcVVhNEtidGtYQ1luOUcwV3J1?=
 =?utf-8?B?SHR1ODVNZmF4MnBMMFNyNGRhMEl0cWdzbEs0UDEwMlc0QUMyOVFpWXlMOUcv?=
 =?utf-8?B?NStyc2g3aFczcndWTFpJL1N6UklpWTl3VytWNkUzUGZITkhYZ1c2VlNRa0l4?=
 =?utf-8?B?MUc1QU5tNGExMlJpNGdUVWFSTzhVeUZydmhQbHFsSnJkU0JzS2hGcy8rMGhr?=
 =?utf-8?B?QUdrb3hzY3lHWVJkeU1uKzA1NVdIT3N5VG9RbExaRWVLZSt1bnl6d3Q5cUlo?=
 =?utf-8?B?Y1d3TW45cnRnY05ic0hXa1FjWkNyVmxQYWsrS3M0MlhkWSs5RUNHMUxpU1d3?=
 =?utf-8?B?cFNuTm9SU0hpS05xWU5KRy95bVM3eHI3d3dLcWEzQnRmRXlHallSdlpvOXgv?=
 =?utf-8?B?MDIxT01zQWV0VEtFcnpNNjk5MWFEZzkyeEFUVTYxRzFDNkNxNzJ6YTFON2Zt?=
 =?utf-8?B?Nm00T3BjYnYyM0JqN1F1a2R0Rzk0MFcyUFR6Rk1UUlhZL1RTZVpYeUZqUjhX?=
 =?utf-8?B?ZVBQS2l3dDZaTDRocERmakE1Z1U3UFlIU3J6S2YyWVI0SkpEMGFuOVg3cXBM?=
 =?utf-8?B?MEE2emZjbjFkeU11ejU2NWppUnVVSG9oM0lsS3dKazJGcGMyeVBhREJUWGt6?=
 =?utf-8?B?aGVmd3BYN2FUbjEySnFPVlpGenVRPT0=?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30717809-7106-41ab-a8ac-08ddbec31dc2
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 08:32:18.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8Nn6aR/638cCwGYgKq9wtWfmu9KgsWFFAJdCbwkGNGu/4wYVoe2gIDIWZUqksT1nFUyryouEItjm17mlQKMzuF4BaS4PhAp9oFadr3mNJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0068

On Tue, Jul 08, 2025 at 12:09:40PM -0700, John Stultz wrote:
> On Tue, Jul 8, 2025 at 9:46=E2=80=AFAM Markus Bl=C3=B6chl
> <markus.bloechl@ipetronik.com> wrote:
> >
> > Most drivers only populate the fields cycles and cs_id in their
> > get_time_fn() callback for get_device_system_crosststamp() unless
> > they explicitly provide nanosecond values.
> > When this new use_nsecs field was added and used most drivers did not
> > care.
> > Clock sources other than CSID_GENERIC could then get converted in
> > convert_base_to_cs() based on an uninitialized use_nsecs which usually
> > results in -EINVAL during the following range check.
> >
> > Fixes: 6b2e29977518 ("timekeeping: Provide infrastructure for convertin=
g to/from a base clock")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Markus Bl=C3=B6chl <markus.bloechl@ipetronik.com>
> > ---
> >
> > Notes:
> >     We observed this in the e1000e driver but at least stmmac and
> >     ptp_kvm also seem affected by this.
> >     ice was recently fixed by a5a441ae283d ("ice/ptp: fix crosstimestam=
p reporting").
> >
> >
> >  kernel/time/timekeeping.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index a009c91f7b05..be0da807329f 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -1269,6 +1269,8 @@ int get_device_system_crosststamp(int (*get_time_=
fn)
> >
> >         do {
> >                 seq =3D read_seqcount_begin(&tk_core.seq);
> > +               system_counterval.use_nsecs =3D false;
> > +
>
> So if the argument is the local system_counterval structure isn't
> being fully initialized by the get_time_fn() functions it is passed
> to, it seems like it would be better to do so at the top of
> get_device_system_crosststamp(), and not inside the seqloop.

Probably, I was just afraid of the case where get_time_fn() would take
like *very* different paths during different iterations.
But that seems really unlikely, indeed.

>
> But having the responsibility to initialize/fill in the structure
> being split across the core and the implementation logic (leaving some
> of the fields as optional) feels prone to mistakes, so it makes me
> wonder if those drivers implementing the get_time_fn() really ought to
> fully fill out the structure, and thus the fix would be better done in
> those drivers.

Yes, they should.
I also intend to patch the current drivers to do so but the initial
addition of the use_nsecs field could never have been safe without
some default initialization.
I know that we shouldn't worry too much about out-of-tree drivers,
but the fact that get_device_system_crosststamp() is exported,
the compiler is still perfectly happy *but* it breaks silently and
occasionally bugs me.
So this fix should cover all known and unknown drivers and is easier
to backport into stable.

Meanwhile I am preparing some follow-up patches for net to make the
known drivers fully fill out the structure.

Btw: Do you happen to have any patchwork queue you want those
timekeeping patches to land in?

Thanks for your input
Markus

>
> thanks
> -john


Impressum/Imprint: https://www.ipetronik.com/impressum

