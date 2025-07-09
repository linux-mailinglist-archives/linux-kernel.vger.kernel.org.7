Return-Path: <linux-kernel+bounces-723525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E2BAFE7F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B076F1672B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC792D3A70;
	Wed,  9 Jul 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tO0ZLLG0"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6A227B83
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061220; cv=fail; b=XC85Ay/yH+/vCyJUvDt1Ai5zcLXV5ywq/E+yDjKDWqyTplL316AxuHcxJRXTjS+wLXUnGaxjbiMmknhxpwGv4Cvn3voCAuqohL9yvOICamnNphjIZjKVbThcjx1bDol7OwfIzyCNfCFUOXclcuYvESGrw0MPcPbXwOcIH6MiDv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061220; c=relaxed/simple;
	bh=N/zxFK4lniAfFEY6Q62Ei9VflUAve8UBjvtD9/mJbwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3FseLKE4X/FcviCzKXa+a7inMphoc5dY999WP/xlNfrVfHAw1X/9pqkwFDUCLcrKBplDnds48/F+qmka0yir9bUJ8Ksh2lr7VeM+2yCdcXjtogDlRPi6ePTmD4a/kmrb/9CVXr6nXndpCWGqtW1oWAJf6s+FRXY7He4N0zTEMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tO0ZLLG0; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QE5D5IuoztTmvxHXJ7VRaag8PQo7L+Oqq4FGwGPyhY185TBW1MdnRSytAtEzdSVaUzBgdRxtMWGnkrFjxpIkxR1f32SLcuK1CBFt7jSRUJs20VT/DhBCOhGUt7gOkjI3F5b7aWtZYYFlvCqXxRnF2m6lTLQk5ma8aJTUN0b2rJaqodd529Xk5GfZrxLwXNPWJ1tfHyBQtR/3UAO3IB4zqvao/xlWVKsyh7XIZCa4q1eqw52ATqEUSGRz4P2H7CLaqkD842GMD9S3hggPOLaFGf4VQoCJd7GaXlEKNzfCecL1dtxb4cddp/tHLDc2Rfb9gRSfoxygadgshy6hP5lSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLABzI3+yAJdvELfPbYFivIHGxNKTZOfPSY/BTzbyDk=;
 b=ixynRcKj9TZ+dNGWYcSR1dPDGVULVmrPc+PHshB7fEWCUIWXpBS8bnYy6JSn5GTBg6sFas411IsAAXAsvF9ZjULklAcPykboP4LSU0TtyiPsJEXk8FCBsWzyxmERNNdVFQDIBfj4t0dKzpykjSgjnCUZ9i70Hgs0FcA7c2bVlR8cRK/eHtFs1sBc1ngaBtIeS05f0g2UFDOQ5RtU5xgD3iTrXi0/s/wX/YgPiubSEXDYCK4er1Bv2rn5N9e4Ft4xjUnLcw/b2H3LVeKXdB2vS7QVeDFU23quI1HrkZtR43JfHECG8fNRQbjeXIy+AT/uLFRKvO5/JZCFkkzoAJOicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLABzI3+yAJdvELfPbYFivIHGxNKTZOfPSY/BTzbyDk=;
 b=tO0ZLLG0RHF5MZkeAMZcFS1DFl3LF3mNAwKLApJ77e0DSNopU7wmzlqhgVD2/xqCG7AhuypNfcRL4JWhSQI1ufZ0UfBeEl2X5oK+B5J34vYuQxWmnhzt9AOQsc/2G1Cs0CA7X7ONoxT2069U0ORZPQkwLywRSD2kMUNp94p0dKSpvOYDU/ZShoy8QfEWZLWv0GbxNarTJ4PacUARYtQVjgvRmF3lUiucMxVNjEXV5gfFkH0/q9czHTC7+vFpoH6EVH3NORkkxMp2rpfEW8ZPuCq3/ufHJdOTU7R/LinQ2JXwMaZ34oEzOP09ZKWUgCEgt6GiOvpd1nub3rP21NErxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8275.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 11:40:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 11:40:14 +0000
Message-ID: <3a87aa8d-ce40-4909-be36-24c8ea75af8b@siemens.com>
Date: Wed, 9 Jul 2025 13:40:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scripts/gdb/symbols: make lx-symbols skip the s390
 decompressor
To: Ilya Leoshkevich <iii@linux.ibm.com>, Kieran Bingham
 <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250625154220.75300-1-iii@linux.ibm.com>
 <20250625154220.75300-3-iii@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250625154220.75300-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 39946a40-a863-463e-ef93-08ddbedd5ebf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blJuamc1djNvZU1HZkRlWFRNUEwyQXpqRUdBNThWU3VneHc1R0NVQzRCSk10?=
 =?utf-8?B?M25VQ1RUV2RLZ0pxNVhFL2ZIK1ZVVGNnOHcrMFJSU1pNWW5vQmJtZkQza1hj?=
 =?utf-8?B?aXE0NzdCaVAzK0theGZJbmoyRlRrMjY0WFlHV3dEU0UrQW1QUkd4OUFVRm9l?=
 =?utf-8?B?UVZWRTZzN3gyaGNZUFM0aU9MQW5icE82dzBPUFRYNkNjM0lTcmc1ZVRJWkZ6?=
 =?utf-8?B?L0JpTytXOGtOT3FYaWVlMFJ3UUVwc1JaWFVMQ0ZVa1NhYnlxRmZrQXRLdGhD?=
 =?utf-8?B?OEZkYyt5YjdKWU9WbERUeFdEbjJtSFZ1Mk9CQStYNVoyT3NYUVJwamFid0Rv?=
 =?utf-8?B?S0tpWFFsMGRobHpheEtMV25vUndoMm4yOG1pcDZweGNKZVdGRmY4eVNTc0Er?=
 =?utf-8?B?cHFRR25CZ2tYb3Y1WWJYNEk3Yi9EZklxampPZG1PbytkZFVFUnhOZWI2Z01F?=
 =?utf-8?B?c2JDSVdzZFBRZDZDVkVKam83VUNjc1l4YnNFL2M4ZlR5bHoxelBtVFB6Nkt3?=
 =?utf-8?B?cHZ6L0ExbkhEamNwSlVxQnBSc1ArOG9qOE5nVXlGSHo1cWErZVpQZnkxdVB0?=
 =?utf-8?B?bHJJTFU1QUt0YndMMzBsM1pOV1hrK1hhdE4zZ3JkT3Z2eW1iM1NnR3JqS1Q5?=
 =?utf-8?B?eEZ3RDczb2JOWURaT3h4NCt1MHVVek5GRGVjdzk4KzM1WkJnaS9xQkdpVVVa?=
 =?utf-8?B?dUNmTXM3ZUJ1ejJra3dGQWc2Y1V4dlhxdTBMNFprclpSWmRid0R0Q1NQdGZk?=
 =?utf-8?B?RVU3UGI1YldhWjdidW1iUVRMSHdBakhscVpQenBLc2RNNCtRSDgvQi9UUDVX?=
 =?utf-8?B?VmFBRVJuL2NIb21xYlRnNkxhWlcvMGxXY3J4VU9LdFZLUEVNYjUwV0FjWktP?=
 =?utf-8?B?WUszN0FvMjkxQm8zcGJ2b3FsZDUwQ3pVK0xzNHlXUVZUbjR1ZWUzRXVRWUdF?=
 =?utf-8?B?alV6OW1ESE8yQlBOR1gwNFVIZjZqMGdZSUJqelNBZTFoVnJOdTlvVjcwZlZn?=
 =?utf-8?B?SnIvcVZhdXBVclh4KzlHYkpqTmtnbXVXc1pXVU1kNzRraFNYWnowMXkyYmNM?=
 =?utf-8?B?dVR0SFVDRUlVSHJDdUNqYnJ1bUZwTDJRL0w0cG9qOW9GTDBNUi9zVGR2eDZy?=
 =?utf-8?B?NWpxVjQyZno0eS8xZnB0N3RRTE9jbGRJTkxGWGpIeWMxbGkxdmdJd1NMYnhK?=
 =?utf-8?B?d3pQTmV6MkovSnVQNUJadTU3SVVCU2hCbGlyWlNYWGlZcE5kZnoxQ3R3WnBz?=
 =?utf-8?B?dy80aFlBdS9FbEs1d0NtUlpZdWFsWGozcTg5NTZxUXVENEQwMzA1MkRMYlhQ?=
 =?utf-8?B?VG1BSEs1S3RNdXRoT2pxNW9tYU9MdHJJQ2JOc2g0OVlwN2ZOSWh1ZmhSTzhp?=
 =?utf-8?B?VHMyYXVWYUxjSzJZRm5IWmNZL3JpR2wwTUR2SjdVMDU0Uk13bWtHTkxKdm01?=
 =?utf-8?B?dDh0NlRlSHhlMTBLUVJRTCt1SmVPN3YrODVxazMyZzNxK1EvMXN0dmhrOWhR?=
 =?utf-8?B?bWZwdU1LbFk0L2FTQjdEdWx0d2g3YnhYQ3VtTnh1Qzlya1M5ZThGd3p2ak5u?=
 =?utf-8?B?VlRSZmFlZDhzNTlUWXE3OFdVc2hwOHVRNXlDdkhMQyt1YTFvNFoyR2FlSnpJ?=
 =?utf-8?B?RW92T0wzK0RMOGJLV0lpcGV5UHdQQ1VRTXYzSVBOL3hDdmxxQUFqemx6VU9p?=
 =?utf-8?B?b2dZTjcyeWpmS01oZVYrM2M0NGx6aVVTKzg1OUxlOEwzcmc0OG1Qc01xK0wr?=
 =?utf-8?B?aVB2dHg1RHAvMHVpS3RqcGJOQkRNdHRNZlpoblcrNG5vWGVtTkhrU21GMHJu?=
 =?utf-8?B?dXAvOU9ZRmhOWjI5OE9RdEM1dkUwNkxvendkNTdvbHF2SkVyOXgzbUg4QllN?=
 =?utf-8?B?NnU2S0tyUUdLS3ozcndzU3dUN1B0V2JiL3Y3MmwvaVd0b3U3VVR3c1BaakE1?=
 =?utf-8?Q?+xP8dzVyzSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG1FeVM2MGNYWEZ1dXRqMTNXRjc5aVhaU1NwYks4d1JpcGJDOXBzdnI3WGo5?=
 =?utf-8?B?TjNub2xDeU1WOEFIWno5cCt1U3RRY2NKV0pBU3VCdDZHdCtFSjdxOXQwRVRV?=
 =?utf-8?B?VmpMQXpWMW1jWS9mQzVHbCtCdEY2TzZucmx6SDRkZkhKcXBNN0FJc0xFdmNZ?=
 =?utf-8?B?T0tVekF3ZG5oelEwaWJpU1RjaHNMYXJHZzJWZVZXYmNtT0xHd1Y0RExZVnZh?=
 =?utf-8?B?bWFoT3FLSE03R2pmT25laWpBejVBRkEwR1BkdmZDWnYxdkREbmM1d3owRVNk?=
 =?utf-8?B?bzg2Lzl4T294ZXdVcWlGNm1WbjdyTGx1R2wrUlh0ejlKeWljTHd4NTlFQ0ZS?=
 =?utf-8?B?T1VFMFJuenhQTU1EL2xOTG04dmR6Y09Nc1FFZEVsb0x0QVU3MEFGQ1lDM3E4?=
 =?utf-8?B?V0pibFY0S004b3NocWdnQzdsa1JxYlZoS3VhelFscnNONzRoT2xsTUI5RWV1?=
 =?utf-8?B?QnpwbXEyR1dpRTVIOWI3UEJnM3YzT292dmNYUnpFZDhud0pQY1NoOTNKblFl?=
 =?utf-8?B?d0t0bDBkdHJQOW9qRmZMZXhVZUVrcnd6MzA1RFFIMGw1RGdyd0hMMVdmUFY5?=
 =?utf-8?B?QWlCeGdyUko2VmxqaE16UEV0b2paTnVCRXlOVU5FZmM0YU5IM0hQOGs3Vjk5?=
 =?utf-8?B?Y1lRaGp0bUloZm1lc2VvOEZYVUFCaXpxZnhBVzh2Q2FHVE5Ra29HRS9MWk1z?=
 =?utf-8?B?TTk1ZGl5YXBUcHQ4d0pkMlNZYXJrSVluVmd5eWw2Rmd5a0JDbG1tYTdQQ0t5?=
 =?utf-8?B?Q3JySng4ZEdMYTlxWmVJakZ4NlQ5MkNhOUlqL21JKzhJQjBldjBtN3N3NTV1?=
 =?utf-8?B?bm5sR1l6YkRreEVEaldGOTNaRFlVbHYzUXNXcDExMlFuRy9yNGd6T01zQS9D?=
 =?utf-8?B?Q25uQU9uSnFoMi9IbWxBRkNTdnB5T25laDFILzRpcmJKUmJubEQxNTZiOWNT?=
 =?utf-8?B?cHBKbXJFQThteDloVDJILzYrY2lLdjh6MFROZmVnUEZXenJiTmVhdjVidEsz?=
 =?utf-8?B?aCtxTU5xN29BcjRRd2tEZkhid0lLb0pyM20rc3hJYlJMS0tnWTJDd0dJdHM0?=
 =?utf-8?B?N1drSkdiNjZoakY5a20vY2pRK3Z0L3hRY3dxYnB0a045Y1p2MHYwaWphR2ZR?=
 =?utf-8?B?cURSOVpqVjJNMmM2WGRhSjlvWVRzcUFNak5PZkoxYk1EZ2pySDdzdTg5akZI?=
 =?utf-8?B?S0ZEWG1DQUxtaHdYQ2Zpa1d0bFlDQWNhTFVpVGdRbGs5a21JTFdTbi81akJ3?=
 =?utf-8?B?T1ludnM5MHdyVkxLOXNXeU5WbC8rUzdhdDJtd090Qjh6VVFWZWgvTnZBTXh2?=
 =?utf-8?B?Q2dTT2ZadzhvWkNjQnl6MVJBOEtHWHhsMklRdVk1d1k5L0dMTjNrWXJ5ZlJL?=
 =?utf-8?B?MWJZY09PbTZIZnhVVFNFQkt2anowRnlZbWcxSkh5c2VqVlhmYXkvL2pCZlln?=
 =?utf-8?B?THI2Mi9qbUFpeUlGc3lUamUzTFdBQnRJQlFVbDJoUDdXSlpsWEg0cVZEaDBO?=
 =?utf-8?B?eXE5UCtWVDZRWWVDSXZjaWZMMUtyYTRMMEhRWGZ6SXZrQ21YSk9ETkxkYWdo?=
 =?utf-8?B?VjQ4MjhZZzBZVzljb1oyaCtJV0g5b1pmVzRHbG1rQkl4N1J6WHlJOGxyTGk3?=
 =?utf-8?B?UDdBcCsxYmZPY0tyd21EUFZaWWxKYkR3RmpHbG1tcjFScWlFVlJVd1NlR0t2?=
 =?utf-8?B?bXM5RFMrODArZU15MjFmMHhOUWRiYVYwS2Y1M3ZUbGNpbGlodGp5eUlvQ1RO?=
 =?utf-8?B?dGpzcys5R2R2aW5maVVjOVUvYWY4ZXdXbnZialMzcXMxaU9EbFhjZ3NvTnI3?=
 =?utf-8?B?NWswVDB4b2VOaUNJUUlscndoK3VZRmZERVlzWTFaanF2eEpqK3RtWlZhZzBF?=
 =?utf-8?B?UDIzbjJ0Z3pqTDA2WnkvRnBNMjVpVllxTWZxamh2Q1VEWG1zWDRrN3N1SE5T?=
 =?utf-8?B?bFY3UzFWaTBSbXBsdXBxdDU4Tys2UVR3RlhQVlNLWkVLYS9KeDJLNzNjUUk2?=
 =?utf-8?B?aUEyenpXVCtkQ29IaEFVK3drT2R1ZWRtNUJBMmltK0JibnJsUzB6TE45MDYv?=
 =?utf-8?B?L2podFhxRUFjc0t0V3Q4Q3ZNOTRIZUp1WEZYa3NVc25Jak5rdTJoMHEvcmdp?=
 =?utf-8?B?MXJCN2I2dTJCSlBvZGUyVjM1Mno3M250Y01qbzR1OXdiMmVGYk1LdzZqc1Y0?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39946a40-a863-463e-ef93-08ddbedd5ebf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 11:40:14.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyYEhgsmUPgfq/nAKxqpjoyWbWqujHfVdHJa5lhGlGROhHcPy6uYDiD2XqjPmqB+HsAkLvY7+0613/sifWav1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8275

On 25.06.25 17:36, Ilya Leoshkevich wrote:
> When one starts QEMU with the -S flag and attaches GDB, the kernel is
> not yet loaded, and the current instruction is an entry point to the
> decompressor. In case the intention is to debug the early kernel boot,
> and not the decompressor, e.g., put a breakpoint on some kernel
> function and see all the invocations, one has to skip the decompressor.
> 
> There are many ways to do this, and so far people wrote private scripts
> or memorized certain command sequences.
> 
> Make it work out of the box like this:
> 
>     $ gdb -ex 'target remote :6812' -ex 'source vmlinux-gdb.py' vmlinux
>     Remote debugging using :6812
>     0x0000000000010000 in ?? ()
>     (gdb) lx-symbols
>     loading vmlinux
>     (gdb) x/i $pc
>     => 0x3ffe0100000 <startup_continue>:    lghi    %r2,0
> 
> Implement this by reading the address of the jump_to_kernel() function
> from the lowcore, and step until DAT is turned on.

Why do you need to stepi until there? SW breakpoint will likely need to
output of the decompressor first. No HW breakpoint available? Or missing
<end-of-decompressor> address?

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  scripts/gdb/linux/symbols.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 2332bd8eddf1..6edb99221675 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -84,6 +84,30 @@ def get_kerneloffset():
>      return None
>  
>  
> +def is_in_s390_decompressor():
> +    # DAT is always off in decompressor. Use this as an indicator.
> +    # Note that in the kernel, DAT can be off during kexec() or restart.
> +    # Accept this imprecision in order to avoid complicating things.
> +    # It is unlikely that someone will run lx-symbols at these points.
> +    pswm = int(gdb.parse_and_eval("$pswm"))
> +    return (pswm & 0x0400000000000000) == 0
> +
> +
> +def skip_decompressor():
> +    if utils.is_target_arch("s390"):
> +        if is_in_s390_decompressor():
> +            # The address of the jump_to_kernel function is statically placed
> +            # into svc_old_psw.addr (see ipl_data.c); read it from there. DAT
> +            # is off, so we do not need to care about lowcore relocation.
> +            svc_old_pswa = 0x148
> +            jump_to_kernel = int(gdb.parse_and_eval("*(unsigned long long *)" +
> +                                                    hex(svc_old_pswa)))
> +            gdb.execute("tbreak *" + hex(jump_to_kernel))
> +            gdb.execute("continue")
> +            while is_in_s390_decompressor():
> +                gdb.execute("stepi")
> +
> +
>  class LxSymbols(gdb.Command):
>      """(Re-)load symbols of Linux kernel and currently loaded modules.
>  
> @@ -204,6 +228,8 @@ lx-symbols command."""
>              saved_state['breakpoint'].enabled = saved_state['enabled']
>  
>      def invoke(self, arg, from_tty):
> +        skip_decompressor()
> +
>          self.module_paths = [os.path.abspath(os.path.expanduser(p))
>                               for p in arg.split()]
>          self.module_paths.append(os.getcwd())

Otherwise, this series looks good to me and could be picked up if there
is no better way to reach the end of the decompressor.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

