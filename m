Return-Path: <linux-kernel+bounces-784882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F6B342DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F08A17B342
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C762EB5C6;
	Mon, 25 Aug 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JApe6V2W"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2134.outbound.protection.outlook.com [40.107.115.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026CC1D31B9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131199; cv=fail; b=NYDvybXNk8nNXxRV2gafpieimZhvVvA16L6DwBptUX3W/oaeGMtm4yzbyMYZ/pLNZb82BNFSvRelMUMHvQCYeXxlQDtxsmV3o6sddvd4u+jemgrus499js1riITQcxqcyXWsVobHXLzhAg07EzhIiD9Z0g7G9z8oh0Bs19QEQLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131199; c=relaxed/simple;
	bh=9dQQZeYlwIFSL6sszPtSzYb/8GGynk3JFvImYYfyZHk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+H7LcxcguugYszw2sapN27hGn68+ug14FWjVboAIKz0OAcAMOpZQALd4al61/0v+3P8j6LQpzeyb7HKd69Kgql51kqmTmKWyATpX815Dyl5iLVGlxR+21q2cG5kYBUZbZMA55zldEe2HT6pWkrjd60LhW5pZurrh/D5HVj/1Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JApe6V2W; arc=fail smtp.client-ip=40.107.115.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDtyZjsyvfW+i4252/51LD9QBvpLwxCBgrqLCYEq7s0kz9OfsQm3g0lLsXfeGTXd45R1zyAOR8srnu+5ORuH7AdCAKizWZXRG8hoTOCw4cfXtjloYK1X3+V1eoe7Ojhw4hqQXfB3DC6uSjM6p9nNisc+za9xWuPMRkYHxvRvB1V+a63fbCX15qk7OCw1GESpN+cIzA7NVVRCt0HxD0WxG0rFCV9Vgg6NP3SuJ6SNbr6RtRNAYBftuCI9jfEmCZWV4kjGNvWRIG0LvLZtY0noTKvDC6cdK2l9S/0M6ZBkl7CSwIRFiS1x8t7az0RHgEDv5RA9Li0Zu8BD4Mdm/SwR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fv1WR5WxyMb0jg1FnofvMtw93TzvdMiWXnhQ9644ZA=;
 b=LgjabMyf5YP4PcoRPQdPf60T/sCY3kMlwAVW8JboPtEKTAXRh61AIJ3dd398jkvFvi/2oJH8ul7AEXF9CiaU4lna4zmi4CzlLrpQx399349HWkuiiQKkg/KJIxDmsFSvVaqCo96bHrgHB7UttRf6Nt8xCofApXJTITA6j7BeItfWhYS5E5wOAdJuSRxaGhgGTCwZEHmUL/QENyoPlZksJjvBSx+gjZizHAZhxrJiicNnxgwB37n3LUSc/ZBBOmF8LAvfyYUEqAyIfg7RzHJlrt0YcNfsXqfHSxg8rxxAzzOkwvB1A+tGlIr8y6MNJ198xUDYlj5nnUnI07pHQZAY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fv1WR5WxyMb0jg1FnofvMtw93TzvdMiWXnhQ9644ZA=;
 b=JApe6V2WwESsi4Dr0Sn/7ZMX7+C8FnJBdNXlceDdMej5lYOQVh07Yw6m7RJFVxhVTGD355/wDN5WnD2jq9SwXtxcfcOumRr+ZoGaBBaYGOtnvgHYkClSRl3XHKohdDE+rAsDw+MIxpO6wHq8Ud+WFCw5PG3MPecmdFimcl+5smzABpUuWFbnNehOUUOnmXSF/C89xmZ1mFK9aE+uMd9DkMtHzulHhNYxpRIFMYG8Zn8oht9BGnfzMeOaYUg54i+K2zAbcAlFishx8m9toNg2BjGQiCJLOsIA8iUN66zqdmBUJXnvFlLN4NVAZNED+REv+kZDWgEHrh1fdo+4NvAUTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB11192.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 14:13:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 14:13:12 +0000
Message-ID: <f1e46d95-bb10-47bd-ac48-c62c949afa3a@efficios.com>
Date: Mon, 25 Aug 2025 10:13:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq: Protect event mask against membarrier IPI
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <87o6sj6z95.ffs@tglx>
 <a2f916f1-0693-41aa-be72-465d84da5123@efficios.com> <87tt1yw76g.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87tt1yw76g.ffs@tglx>
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
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: eff57da4-f86d-4c82-e3c7-08dde3e18693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFkrYlZSa3FnVGdTc25lMnVFMzBNSktpeG9QaG1vWnRJUlhmZDQ5ZGtTMnJH?=
 =?utf-8?B?L1pSdG4zeklIcFNHTGo2Q3E4cCtrbWNPYmt5d1Yvdk5kUmIzd3BKTjJkY0J5?=
 =?utf-8?B?Rml3RVk1VEo4YUtsRFhpdmFNWVZYem9LNkF0eU1PbUwvNFpTNEtyYmNibGF6?=
 =?utf-8?B?UGJ5ckZ4VWQveGJ3Yzg0cTBWdXNyd0dNSTBwQXJ3c3FxY0hmNStrZTFHVUcw?=
 =?utf-8?B?R0toSmRBVW15elRpbTQ3aVcrVnN2eWlhS2plaEpVUnN6TkFqTDAvTktnTzAy?=
 =?utf-8?B?dk95ODRna1dIR0JHY1NwQWFZaEszQkJQdEtMR1NqTlc1VDJzc1I0dGMwRGZv?=
 =?utf-8?B?WS83THpGUHpJSTE5cmlRYjdBOTc2bGF5RE5hRU5YOHhlVVh0QldUNncwYXlM?=
 =?utf-8?B?MCt5WTQ4NXdUZFViOVNPcG1JODl4azF2L1ZUb2hzQ21xZ2txb0xxejEyOStD?=
 =?utf-8?B?akIwZXRoOVo0dFJ0K3VSRUZIUTVTMXdaZUxwUFdTcDZMYlMrZGJJUVhCREZy?=
 =?utf-8?B?Qm9UMlhOdjZ5L2VKN0JhZnpOdFpCQ2Y5ZFlRcUVBTTJsYS8reGVLNHhTNWFN?=
 =?utf-8?B?c2RvbVZXd1ZHYS9Gbyt0Mm9rb243a0FOajFxMTVGdWJDQms4cFdiUnNMeFZJ?=
 =?utf-8?B?YWpPeU9vVzQrRkRTQ1IzVmFoeGl2WG1LS3RoeTUyMm5XNTk2WFBvVlpUbkp6?=
 =?utf-8?B?ZGVmQyttY1VIbTF6TExHdXdVR1VZV3BXYzNXcEJxaEFjSW1nU3VYVWFENXlJ?=
 =?utf-8?B?aHpzUCt2ZUx6b1V4S0F3eXFKSURLQjJBZGxVZWNhSjg3YXJ1OTRZbDlwR2l4?=
 =?utf-8?B?M0QzN3o3OGNubnlPRXY0L0pZcDcxZ3NnTmVBOWsyL3JJUjcwYmp6SXZTQUVm?=
 =?utf-8?B?cGd3K1dyajhxSFNkMDJjY3NNaE8wcmRFdFFldHNiVkNyS1hQSXR0Q0s4TWJ6?=
 =?utf-8?B?YW9haTdBTERGNXVScG5OZzV6dGxEcWxiOWl1WTdMazdPbC80UzhuUFFsdHg1?=
 =?utf-8?B?cGJoUzZqakVRQysrdUx2K2V0ZDRsaUI3ckVsMzN2a0lOS2dCM3M5RnlOd2VM?=
 =?utf-8?B?VHB2ZXE4UWhMTkhINTM2ajFFOGlmSVd2czRWV2NnODczbFh5NnhUWlhlM2pt?=
 =?utf-8?B?ZWJrMDFTSzNaWWowNWNyeWV1a21jdEh6WDlmb255R1B4eFlYYVRGdWNEUTBS?=
 =?utf-8?B?S0tiakVUaGtUREttdEV5eGZnVDgyWWJDR1Z2NUI2R3YrZ09kRVFBZzY1ZGF2?=
 =?utf-8?B?bmFOcUhwTGVxc0V5d1ZtUktOd3ExUjJXOGtKUEFCNks0RTMyU0RrZWppTnp0?=
 =?utf-8?B?UlhyajZobXB2UnNSVm42NlZqdGxZemU0Rys3ck9EMGdHQ3RUcHhDRXozRy95?=
 =?utf-8?B?cU8xYStMamQwWEU2cDVYdnBITVF2THNwVUNoYkduRUs4aGF1c29ONG9wcUhK?=
 =?utf-8?B?TmtpcUE2eUNBa3RIZWtxWVJZZUQrcGRhdktkbmp1TjQ5RThwQk5oNUlJc1I4?=
 =?utf-8?B?bW02a3NhSjRrYWhVdTM0d0hlc2hFVTJCQmNpU0FkN1lsWDVnTkd2TFZQYStu?=
 =?utf-8?B?SXpsTEdwK3FYTUllQmR3NlN2a3ZsNmlrcjdVUGJQMzBNMk5CV28vazEwcWFx?=
 =?utf-8?B?REdsRXZza1M0V281VlJQWkdyR1lZaTBIMi81bU82bk5LMENGTzJqbVVzVXhL?=
 =?utf-8?B?V1JBSGJsL1IwN1pFZUZpcnl1dW4wUDlHeURiSTRUOUZsWEFuWEQyaDVYbTJp?=
 =?utf-8?B?MDNqQUFjeS8vWTI1SjdlRThEV3kwMTlrQ2V3Tnh0eGVacEJPQWd3STZWNnRy?=
 =?utf-8?Q?Bh4nEXXxjHfX9yovBT44fc/z8cQlaXCOOxRw0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTVIaDhVZ0dRajFhUHdvdnZCQUl4NnlFOENRd0VoTmlwYkl5VHhNVGZ0R3lT?=
 =?utf-8?B?cm1VNFFWSm9ReTlvTVFSWlpZRTJHK3NDS1VGREhuQVNUelJpdG9Ibk1TOURU?=
 =?utf-8?B?a0cwOWxuQ2V2aXM5NGFEeHpLR3Q2NFdMSzFkTjJvV0htRk1zeTFlVStTcXhy?=
 =?utf-8?B?aHlOS2hEUHdFV0NNOWVYZjFnUmNkU0xVdFdEaG5TS0pUYmN3cW5JdDd5emFS?=
 =?utf-8?B?Ykc3Um9uSUJLelZSSWJnRUlPbUZUbG1PQjYvSndCa2REM0M5RWxuandPdlBZ?=
 =?utf-8?B?WWNmazdhOERZWlFaK0grVkpYUlB6Zi8vSklZdm9zcVAyYW0rUU8zZTN6bmM5?=
 =?utf-8?B?ek5VamsxNFladzMzUVF3cEM3eDBTVjNXTDBXdkpucC9ZVHJwb29lUTAzNlQ3?=
 =?utf-8?B?YWtZOXp5MVBUNGhxdTJWSXlwWWwrbmt6NThEY0pOSm9WaGx2MG5maXIxS29s?=
 =?utf-8?B?QXBOYXpnNHd0UCtna1I2Rit1cHBuVUVrcW5jZnFZcWpQVnlFRmxqQlIrM01O?=
 =?utf-8?B?em1PQ0RkYzdOdVFrTFRDK1NOWkhyeDNCSjAxZjBtSGJ0c3BmaU5IWG9tcXMv?=
 =?utf-8?B?a0cvV0dUNTdvWU1wRWhzR0lzNzRhbW1RdWNqWitiSmJJbjhZZGVuam40Skg0?=
 =?utf-8?B?eDNVUnhXbHNESzNNcmVlQ1hLb3kwQW1UdW1hWTJHU05FOGxvY2tPZWszTkRr?=
 =?utf-8?B?VVZpVzlXeks1V2hiU3JFOGtzNUJFN0hFNmdheTBDM2Q3OXNBRW9VanZUN3pM?=
 =?utf-8?B?SWdRNytaT2pSL2VLdjBwcWl6UEZYUEtUTHFML2JtRjBONm9QVXhoVFRIWG13?=
 =?utf-8?B?Y0xkaUNka1VWQWN3RGpkVVJ3bUhQNzM0UDRZaW5jMWI0YkhZRHNCVDk2WlFL?=
 =?utf-8?B?c0V5b1BnVDhmR25OOUlNelZrMERSWGU4c0JnYUFaY2Q3bDN6ekIxVkpwVThW?=
 =?utf-8?B?d1l1MHo2UlRlZHNDRllkK1ExT1hNdzFkMUExTHVmOGRITGxhK2tjWHhqMEx6?=
 =?utf-8?B?T3RnYkJ5WnVRT3BJSVJHV2xWMG9HZUYvSVZLUlpSU1k0bHVwK0N4clZYSjM4?=
 =?utf-8?B?azhQWkVEZURLb00vMVdpNTN6ckprak9MWWIrWlBZd2NkZ0lYRTJXQ0RaSjlw?=
 =?utf-8?B?dWUxbExjTnFFbHd0Q3ArS01nWlBDSWlLRnM1SEVXbk9TYlRQOGpORFpBRXYx?=
 =?utf-8?B?NW5Mb0tvZE5LUDlCWG51bUs2U3d4MU5nZHYwZkhKQjl4WE9hNkdnOXZtQnd6?=
 =?utf-8?B?MHhRNUtmL2NLdGVXT3drNmZGNVRBUW43cXRCcng5ZWM5eXA0bDJKNUdhQzQr?=
 =?utf-8?B?VERPQWVUNzFUTm11MkdJZHR4b2RqdW03SStjRWlYdC9nUTAzYmVqUUs3NGJM?=
 =?utf-8?B?NTNCcGxaanlFUnhNRGE4WEV1R0FLTElsVkxKVVdwaS9pMHhXS2JBZTVVTXlQ?=
 =?utf-8?B?aHZHWVdzS0lab2FFUkFrTE0vWXVDT21SRXJOMURieUVsSVNXb3lsRjFjaFRG?=
 =?utf-8?B?RGVFN0R6aEJIVEZOYXMzWGo1WW8ycFRWSkdRNmpzLy9kcFQ1aDhycitsWXor?=
 =?utf-8?B?S2VXVjdaQnE0L05SRjJZTFVOM2pUTVp0MzhZbzVjM29jV2Z6Z2ZqdkpoaGw0?=
 =?utf-8?B?WC94Zms5eHVvMGp1YkZiTjhHcW9TazNhd0N2M1NraE40RlpwMDNZUUxDNnhJ?=
 =?utf-8?B?ZnV4SFNkWnZNMUdxZ0JkODFwUVhrcm5BNXloZyt4TFFOcktmMWdtT1grZUVO?=
 =?utf-8?B?T1ZKZFRib3FodE50OEkrbG1aR3A2QUN5SFE3U20zVW5FUzlpZXhFRFNpNDhM?=
 =?utf-8?B?S0hUcnFjM0loU2RhR1JJek9sN2FRdkZ1OThtbi81MDBFbm14SXhkTC8wNU5z?=
 =?utf-8?B?RURXQjFwY21uUGhrYjFrNW4yQk5aWEJocnVJc2lqek9qQmJmNzM5dkN1Rmhu?=
 =?utf-8?B?dzV0ZjhiVHV1Y1pBUFZoQ29rQXhFVk1CQ0hPTmgzUVp0STl5S1VaYVo5S2pQ?=
 =?utf-8?B?amF4NTZ3b3ZSaXI3QzAxeHU4LzhxcUZsOERmVi9id3JkSlJGNS9ZT0ZKYmNH?=
 =?utf-8?B?RURPL0cwRE1ZbGkraVlDSVAybHZMbmpmMUlLeXp0MDIxSDJoNVdHWXJUUFlN?=
 =?utf-8?B?ekZVR2JuR28wQWMwV2JETEdXaE9YdjFxTythS3BWMnpNMG9xYjhJWXdLMmZy?=
 =?utf-8?Q?Wtnn775ymANZvz9QFXwfT0k=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff57da4-f86d-4c82-e3c7-08dde3e18693
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:13:12.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iK0UhnmboLHNnsLd2keEwvf0hhmMgzEQt6nsWSMI7ercSj4OVaB0Pbg+vNQ0gNEsp09yu/p4DNUiWaZNlJF3k6/GMCHf64YaY2aiQRF+RAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11192

On 2025-08-23 08:31, Thomas Gleixner wrote:
> On Wed, Aug 20 2025 at 09:23, Mathieu Desnoyers wrote:
>> On 2025-08-13 11:02, Thomas Gleixner wrote:
>> We should also update this comment in include/linux/sched.h:
>>
>>           /*
>>            * RmW on rseq_event_mask must be performed atomically
>>            * with respect to preemption.
>>            */
>>           unsigned long rseq_event_mask;
>>
>> to e.g.:
>>
>> /*
>>    * RmW on rseq_event_mask must be performed atomically
>>    * with respect to preemption and membarrier IPIs.
>>    */
> 
> True.
> 
>>> +
>>>    /*
>>>     * Map the event mask on the user-space ABI enum rseq_cs_flags
>>>     * for direct mask checks.
>>> @@ -41,9 +47,8 @@ static inline void rseq_handle_notify_re
>>>    static inline void rseq_signal_deliver(struct ksignal *ksig,
>>>    				       struct pt_regs *regs)
>>>    {
>>> -	preempt_disable();
>>> -	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
>>> -	preempt_enable();
>>> +	scoped_guard(RSEQ_EVENT_GUARD)
>>> +		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
>>
>> Then we have more to worry about interaction of the following
>> rseq events with membarrier IPI:
>>
>> - rseq_preempt, rseq_migrate, rseq_signal_deliver.
>>
>> Both rseq_preempt and rseq_migrate are documented as only being required
>> to be called with preempt off, not irq off.
> 
> They are always invoked from the middle of the scheduler with interrupts
> disabled, so just the documentation is wrong.

OK

> 
>> Can we just move the event sources requiring preempt-off to their own
>> word, and use a separate word for membarrier IPI instead ? This would
>> allow us to partition the problem into two distinct states each
>> protected by their respective mechanism.
> 
> signal delivery can just use set_bit() which is atomic vs. the IPI no?

Good point!

> 
> But as I pointed out in the other series, we don't need that whole zoo
> of event bits at all. There is absolutely no point.
> 
> signal delivery does not need to set an event in the first place. It can
> just unconditionally invoke this stuff, no?

Yes, as long as it can take a page fault from there.

Thanks,

Mathieu

> 
> Thanks,
> 
>          tglx
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

