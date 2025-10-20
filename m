Return-Path: <linux-kernel+bounces-860051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656CBEF34C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2557189A1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA82BE041;
	Mon, 20 Oct 2025 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eq8yBKlv"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DF17A2F0;
	Mon, 20 Oct 2025 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760932151; cv=fail; b=Vy6C7qgbWupFn5H2/bWh7LaWVoyma5aQHg7L8Azlhp4gju12HR6wBHLLbs0GzAkhM5XGyF+xUVLw2vNMnkdFmhPVlsgG3b74IimteAnJuVekaYRrmUo9UGxoDj6fBLtdRC6rOInxSPSlLqdqVvOFMEbnuXPUamOfVDb9Yb1Y+wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760932151; c=relaxed/simple;
	bh=UAOz5TcewmgESlTVsmv0rJZhGtPr4GRnLNrN01qvw+I=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ktFPlYBFklH8GNdLx+TRtzD2qFj9b4XxiLrCE7ge5QL9FjdmcYq9hAPhU2MLMYfbtXuPY2kFOi1x8md/QWeoIqhRsxv6ng9l5H7AsMe5xsINrO3+sliI7AYMyxNmJhlup/JWyWWdbikriWCxqC4DnozuL9pcatDF//wYY3mbb5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eq8yBKlv; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FN0bfVH2mp/zRcix5Q8mJaQSQfp7DIZhwXEwS3bIzq3MXSvqbQvOlOiFp5H6jiml/cLt5fOAZnec4Sy7xvk539kAU33otvsInPHrGz3jVFhA581/ZCnPOTs2k8f6vE0yGomTsj92dUZwknkubce7eB2Ba+ixnds1BUH1ZZnsOvFbuhjCNJN8dKnPnkz3CUF3NgRDtgh2CDzVwDM7DKRDYDJHM7OqPN2T6spu3O8HzZBdFkonrNbwCDcox9sJh2xUvlqBPmZ9xSRjgpNfkNQTpai5WfFkg2bt0R13AaW+CgTOVE3fZLhyB93aI1l5l1er/Tv0bTBnFdgW7ii14cbXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNPlR+G79c2ck9H/e8tSCcpD+yeoCXITWMN9Hf8yoNo=;
 b=eFl7QCYHmhxUYl6E+jGnIvx6mbreiOh03z1hKVx40OGNbvT7Y0zw0KzRaDZemoKwPAQSArH9yn2ZE3LpKBj5fwxBzUTJSWKH4gyxZyBTV9REP1bHn1iamzPCXF2LsfH8rwE7MTd3g9PHHri28C+CScNz6bahZAbWq+xYVI15iQz9myHlXmtDVf1XaSDc9OTCuE9J1wfk33KI3YVz/xibJ6gtixY06UmjsD53WdiVCxHbiFU406PGpQuXzrLucGMGLIDWVKfMdlc5woyAkEDm2ZXcMZZvjz447oob0jaUbm/Fgk9v6kLD7SruX/+WNVMKgiLpaChgbn+t5PHJl6DdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNPlR+G79c2ck9H/e8tSCcpD+yeoCXITWMN9Hf8yoNo=;
 b=eq8yBKlv/7a69Qh0PuCZ1uh78EAmPUlV6bITUK1lztRor9RtcSUIuyMx6MNJVInvQQ30s9ObjDzJEfZ/8T4XJH0n/Tqx8ScjECczpRFibnsOmbtQmPWh6iiNX1nTicwLhbXaEC8tZA4XMRpiGA/YColkfw06ocyIKEc5CLwPD5U5y95UPmvQ49Ofll0WKlxt9KzKSecgCXVwNWl1jllPJRvgHys4RzDLReDP8UwmUkvwd4oFS4Ol2Sxxtad5stUKVbi5KKIQsNAtFrUU7TNNL8V6vG0j5xe2SideEFAf9UcRoMzIPFbSvz5U8xtXdBhzq5DlhmBOGZRW2NgOcnRkZA==
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2f1::8)
 by MAXPR01MB4135.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 03:48:56 +0000
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2e35:fc95:ee3:bf0f]) by PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2e35:fc95:ee3:bf0f%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 03:48:56 +0000
Message-ID:
 <PN6PR01MB1171791524E2BC1C227E342F6FEF5A@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 20 Oct 2025 11:48:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add PCIe support in DTS for Sophgo SG2042 SoC
To: Han Gao <rabenda.cn@gmail.com>
References: <cover.1760929111.git.unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, conor+dt@kernel.org,
 inochiama@gmail.com, krzk+dt@kernel.org, mani@kernel.org,
 liujingqi@lanxincomputing.com, palmer@dabbelt.com, pjw@kernel.org,
 robh@kernel.org, tglx@linutronix.de, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1760929111.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2f1::8)
X-Microsoft-Original-Message-ID:
 <e18e9221-6f3c-4662-a796-dd55faa6b186@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN6PR01MB11717:EE_|MAXPR01MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: f0609acc-bead-42ec-c535-08de0f8b9827
X-MS-Exchange-SLBlob-MailProps:
	5R4zPSLKzf4FeGv1qBA1s+/m4Cy6KlrxpZ3Vn0nCHmoJKeUoFG4mM4IbcCwbxZsIl6QIj+rEO5uKFuWKNxlEtjMC38AeofIgGoINKweiTtxtayCu+UuzrDmVPq8HqjfZGFm0YceHATLkR5f0MV3t+KwOmg7x8E7EXsoZ+RNyPQgIKa0KSTNAX/fzD/MyL7enPZlWU5SK5xGyo8COoO7eIqQz/RFDIq2/X7qE+UsBNlEUPnLSIcHyVCH6OXUcpMtKIp4hZyk+uaSuzLvlAQoVKxVLrPZteqNbJv79gFc+3YCtpQwG//piE1WsjTZ5UXdcfJWZIDqbLwPeYjU79gELxf1wenqak7Xez87bYSTIabxcqsSHB4hSznxDT4PleEQz7Eec5NK9T+ptYsNc/xK41a9IIC0CjOWzuF9se98q/tgB8mn/oh0piKuRo4eOzyWBd7PmyITBIdbywrJIrIIsGPsPNpLQd8wgV4VJiP1HlKxgSpOeMTkDkaP/POFSCSCBFlDN5fbZTOMctmj49di3huw+8HoS9xSnAxiRT+Y305cdV7qMJHDRx3G3f2rMGWMH9xcVTBq4APCFCKFglpgE/VQCKlVzzwd8Ok4ErzTiq45KirqjxpEgGGBhFLPl2/u1JXB5/z/zRstCVGkV4iy3A3W/JZcee7ZfhAYRP+4agmSWMIg692N+Ti+epOS5MhnU3O5uU7r87FEnjhHQdIM/3UQVLn1xkBXATskW7y0sajJbtT9ogiJWZDmqahsd372/qsf+0yMwbwWDyi+0k27bO/NoAnZyxUojbiHa/d5B/m+h61WPl+vMr9G9/wA2iEc/xrtvAWs3NKm6n1lmnhLkDaWwOEquBNJQ
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|461199028|15080799012|6090799003|5072599009|23021999003|8060799015|41001999006|4302099013|3412199025|440099028|52005399003|40105399003|41105399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXVETG5iTEJIU2ZwQzBnbm1oK3lobHVXTFZ4cGlDQXdqWWkxUVlVZ2h4S3VI?=
 =?utf-8?B?S1BrcUpSM3BVNi85bDU3WE8zdGdYam84Y0FPUFo0b1hpbDVZb1RUOHpYZW45?=
 =?utf-8?B?TTZMVzdDN3lFMEpIcm84NnhwWlBPNzVIc1JaNUZzU3R4WkxsVm5Ta0FINDJh?=
 =?utf-8?B?NFdCMU8ybDZzc2h0cE5Mb0xma3VCY3JRRHdZZFhwMkxaV3hWVExTckFwbk91?=
 =?utf-8?B?NmF0aVgrMU1wNlRUYjJBa21YRWlRdzIyd1lzbHc2WllTRTdYTzkxcE1QQkhP?=
 =?utf-8?B?Nm5HYWk1ajJaYmZ6V1ZPdHVZSDg3SlNRSHREd0hZdExTZ3ZYajl0d3Jqc3Ux?=
 =?utf-8?B?MnNaQUxxc2h0aDNuUXZJM1NBYUYyZ1FhYXRZN0llWDhISHltMEFuYXo0c3J1?=
 =?utf-8?B?L1d6UllodnNvUGlNUUhxVXpYdm5LWDQ3SnVoZHF6amVuTlhWQjNQemRaMTh5?=
 =?utf-8?B?M0hDenB1aGt0NVJSdE1sU0pyTHZZNWFXU3NyUkJmTzU4Mis2VmxJZkFrSXpu?=
 =?utf-8?B?YnJIVFdWMnJ4UWtJemR3KytYMndpTjkwUldlNEp6UnFta3JkS3RtN3AvYmt0?=
 =?utf-8?B?MmJJaXY0N3lIc3Q2KzY4S3AxNmZaZ2YzRnM4VEZFbCtISG1oZnd2MzFUZGRa?=
 =?utf-8?B?djk4VEhuemtJdS8rRWpBRzVZdWVWbjFndjBZdXhrRUpaSE0xQ0N2NE1iT1Zz?=
 =?utf-8?B?T2YwK3RlcG41UkRLbDlYb2NtemZFc255Q0NkVThMWlR5cUFQY1pRYmZjTmJr?=
 =?utf-8?B?QjZFWDRJT0lyNGs3Mm5wMC9xdHRaTDdRbmU1c3NFWHJuQmNjQSsyOXlISko2?=
 =?utf-8?B?ZFIzTUxhdnJ0bTBkNkNEQ3gwbElNTkxQZlhROTl3Q1Q1SThSWW5DTWNhQWdi?=
 =?utf-8?B?TThvQ3VIZTlzZDNxOTNnYnFZVFBEN1lGUFJnUGt1Y09SNUFkRlZRUUd3MDd0?=
 =?utf-8?B?bUJrbWRZVVNuMSs1UTVGQ1ZVeEhUc0FxUGcxUVorSVNDdXNSVzJjbmJ2MmdV?=
 =?utf-8?B?L2dOVHh5alNVRzRtcm14aW5kbUhuK0p4V1BnNHNqRlZLOTBpMkpYMjlNTTk1?=
 =?utf-8?B?Z2VkSmRBaFdybnQrWU9XNEVVMlc0MnVHVUxWQWc2TzE1QkpKZjR1dWNmVTBr?=
 =?utf-8?B?NEVQbzdZNVlob04zbDZubGZGQVdRRWQ3UVhVWHQ4VWZUSlI0YlkyUE9pUXN0?=
 =?utf-8?B?b09hc0Z0MEZDcXNZbWxJNEZ6ZVZzNkZGRXUvbE9tNDg0S3Bna1hpZjFmb1FQ?=
 =?utf-8?B?bTFXS2I2aHdXVGRtSDlXS3p1K0pxc2VUM1dsSklmbmp1eHhXaFA2RWZIeTBz?=
 =?utf-8?B?S2FXNWdkQmNiR0dGN1YraDhNUHp0c1hFcDBhMlJPZjdEL2c2VVdjQjZhdkVB?=
 =?utf-8?B?ZWN3eVV3NndwcVhqSkt0TThVNFhKY2FCaDdOVW00djh5NEtwbW9KZ0Z1UW8r?=
 =?utf-8?B?UW5ib0gxUmwzS1M1bHcrUnA3bUFKR1YxWUdZV3E3Q1JKdk9uUFZRbEFkNytv?=
 =?utf-8?B?STNNYjEraVdmWWRDQStYU2FhTCtyMUo3b0h1dEwvODBuVDY1QjB1YWZ3Wlht?=
 =?utf-8?B?TElCc3VXNkpZdW5vSlRFZk15UmVvaU14TlFqZjRvM1QwTUx6cWNGRjB0Zktx?=
 =?utf-8?B?dXJGSGpRSlBnNG0wQm5yRjVTWFpKb3BZcE9oR2RYUld3eTZvcnZIak10ZlIw?=
 =?utf-8?B?c3d1RmZRODhyZzVpa0l5ZjNEUUE0NCtDOTZoLys3SUczeW96YW5RUHcvTDJG?=
 =?utf-8?B?QzRTTEZpRHlCYVFlcUgxOTF6Z0gzZStFc1l0TXc3c3ozWE5mdEd5RDN2Z0ha?=
 =?utf-8?B?V0dZSzNUdzZuVTdOUjFPeHBOTVJNYXBZelRqalZYazNXbEh1OUZSYUsrVVNN?=
 =?utf-8?B?TkpqNlFtSi93TS9WaHRsc2R0TGo3QllKZHR2WU92ZllUSWc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjVPUnU2Qml4Sk1SUnovWWJxQW40ckxaOVlTUHczR2RKbndRdFNXQi9oVUxY?=
 =?utf-8?B?K1hIWEsvZk5zTEVzays1aW43UFhTYXlmMVNVcFBoL081NDZtbjdqMmZ3cDV4?=
 =?utf-8?B?aDVwQUE5T0k2U1liYXFkVGdaUVUxdzUxL2F0aERvM1VNOS85YllwY09ORDBz?=
 =?utf-8?B?dmVMRUZXOGtOVGZyc1lrMm1Td2NqQVZLY0plU1krNEgrTkhuWnFXVU00akVV?=
 =?utf-8?B?WE9abldjNHNTUDlGYVNnWEEzOVdpMmR1QUpCb3Uzak8yVU5JbkIvZ2UxWkRq?=
 =?utf-8?B?RzFORnlzUHFyRGZTOUJZVkY5Yi9iY3FiU3F3cnVyS1RFMEhUYkdtY1JhQTNt?=
 =?utf-8?B?N3QzZjlpRkxLT3hGeUdjaXFYT29Xd1hkcGh0bWhVVm5NNWVJSmgwejRBdmtF?=
 =?utf-8?B?bFBYYnJiS2RZM0VlemhOdW1qZGF6Z0Y3aWFOZnZ1ZUNiUTNIYlF4bWhraldB?=
 =?utf-8?B?em95dDJDZy91dFhoWGY3eXBXMXUrT0ZmOWczQkVWeFl6clFsWFIxSk9sT21q?=
 =?utf-8?B?UWlKKzZoQUxhbDhPYlJUVG1tbGY0c0lRM3N6WWdidWYvOXhjRGh0UncvM3U3?=
 =?utf-8?B?Mi82SGZ5OUJiQXZjOEFsRVRVdXBWNVpiK3JZaDE0bDdpYUpza1J4cWRYRFJy?=
 =?utf-8?B?Z0c1cTJGWU1PemJBbFIzR1QxWWprMUt3M29LYXFtbForT2ZTdDV3Z1IxWm1Q?=
 =?utf-8?B?aHJDQVVJVm03YVQzNDQxTnJOUHZWREMwZHNVZGxTOStUbndkcEduaWxjV1VS?=
 =?utf-8?B?R0hTQy83d21ta3dBcmpEcnJYVDlhcDd1bE8yQkZ6OGx0K2F5ZS9pM05pTHhv?=
 =?utf-8?B?cDRFRHpON1E0MGpudThGZnhBbTMxemp0Rk9HMDRaMUQrNXlGbHRTcFVnY0pF?=
 =?utf-8?B?NmMyYTFBVExMTXdzNXFvR25TR2ZCVStta1ExK3ZoY3BJWEh4aXpCNzlUOXhF?=
 =?utf-8?B?bzNDME1OSzc2OE41L3ZCYkx0ZmZwbnlpNFFMb3BudWQvZmJFWTNGSlYxd1Rj?=
 =?utf-8?B?VHlsZ2lVMEhrdHg4RzJBdHI4T1dzUzhVeXFjUnl1Y0lvTjA1REZXYlV0dlBS?=
 =?utf-8?B?bVF4VlQxSHpsZUdpc3ovTXZBcXg4aytjanBDRC9CUU9xRDc1aWZoYWxXU1o5?=
 =?utf-8?B?bnBPVFIxT2VjTHZWUnFoNFhudjlnSDNrRFRYM29veG9ld2ZiV2F4WE8wZzJi?=
 =?utf-8?B?ejFFUGI3Kzlxdm5QMHI0ckhEZG1hTHhuTWxKZURPVnNLL2s5dG1YUVpYb0JH?=
 =?utf-8?B?VzNJTVo4eUpDbE9MS2ZQTGhBUFEvV0pIdTA2a0pYODVURHRnMGRSakxOdmZ0?=
 =?utf-8?B?bUdUNzZMa2V4TUY2MTRMOHVKYVA3OXNVTEZLekxBcTNrb1lYVU53N0d5OHp2?=
 =?utf-8?B?WWFIQ0dTVWYveXB2TTZtRGcrVHBmSGp3NzNQTGlVOG9tS1ZzaVJZZDltRHVR?=
 =?utf-8?B?UFRkTnVJU1pBMUZOa1R4MjYxT3VhZnhEMUsyRnRBallHeWRoeGExUGVTSTNq?=
 =?utf-8?B?d3JSNUNkeW9NVmt5MVQvdG5mbWhOb2pKdmZXVGV1UzFIU1pIa3NCUlErTG9F?=
 =?utf-8?B?TzEvc2JrVk9TRU5RYWd3L1Q0T0VONkhYalF4R0xnanZXME5Wa1prcWR5OG44?=
 =?utf-8?B?QmFkdE1LbHk0N0k1N1VyaUhnMkYvdExYNXpoQVJWMW1Ob2JvZ084anBJNEZI?=
 =?utf-8?B?MUpmNmFEUWk5RzAyVy9UejFQcVlPcmFsV3l4eWN3TUtrMjJkK0E4UmNwdkZU?=
 =?utf-8?Q?dcBhBSEDmSnvu3spnuMaVYucz9h09tAy4Unj0g9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0609acc-bead-42ec-c535-08de0f8b9827
X-MS-Exchange-CrossTenant-AuthSource: PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 03:48:56.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4135

hi, Han Gao,

Please help test this out on EVB, I don't have those boards and just 
tested with my pinoeerbox.

Thanks,

Chen

On 10/20/2025 11:32 AM, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> This new patch set is a continuation of the previous patchset
> "[PATCH v3 0/7] Add PCIe support to Sophgo SG2042 SoC" [1].
>
> The drivers and bindings have already been merged into the kernel
> mainline, and this patchset will focus on submitting the remaining
> DTS changes into the mainline.
>
> This patchset is based on v6.18-rc1 and the only changes since v3
> is a fix to address the comments from Manivannan Sadhasivam to make
> sure PCI address of the I/O port to start from 0.
>
> Link: https://lore.kernel.org/linux-riscv/cover.1757643388.git.unicorn_wang@outlook.com/ [1]
>
> Chen Wang (4):
>    riscv: sophgo: dts: add PCIe controllers for SG2042
>    riscv: sophgo: dts: enable PCIe for PioneerBox
>    riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
>    riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0
>
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts  | 12 +++
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts  | 12 +++
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 +++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 88 +++++++++++++++++++
>   4 files changed, 124 insertions(+)
>
>
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

