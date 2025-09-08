Return-Path: <linux-kernel+bounces-806697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4688EB49AB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE16D206E5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723162D7DEE;
	Mon,  8 Sep 2025 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jwULAKDm"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020095.outbound.protection.outlook.com [52.101.189.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4542D7DC4;
	Mon,  8 Sep 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362084; cv=fail; b=rSXv/macwf8rxmK4BI+AVOYCW2OL7Z2/QsMzMNcsUo2qLycSIqXbG8lBzt4yHnlt9l4zSegI1mwDMco0hZUil7WoBS++RP6vXeAw4xFe1EfS8Oqtp5XNIFuzJxkv0weSAWHtrq2KK2P8lkkORjXZmGEs+8VeCDN7tCGqH6P6ytE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362084; c=relaxed/simple;
	bh=e9Vq4nWjJ90wvU5Q6BZNHOlf9CY1XZ+HFMm+E02EVyA=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=QM8cG+XMOO5HMwpHhMdrKvKsGkO5mDvwXcLltqYv6VUAJAtOLEcUq00rVePMEn79Bb1FWi1uhhgHQd7IcgTiiJWSgVy2ZhX9IhbleJOJrkdS4OvX27HcNZbdVXbp8EA0BVDZ31fjSZtS5+i/pi+dAcS79gEi8IafO9p/2U0SPvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jwULAKDm; arc=fail smtp.client-ip=52.101.189.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWnN8dcH1UYw3K0P7wMkKKBrR83tkxqsf3S4Kon4Z9k+RO1cUEdwEFWwWHAxxsUAgEnFJebw4f8A3JX+P8sNTlpScl99z37XYmbmApllM0+KrN1vHl8XFHjEcyRsqLBhNjdY0W+FPazvVJjP8c5L6fEZd7HwhrsnI/mWuuo81BsmNSCQLhrIFBd1do8RJ41T/n2utkbP0Bz/yAeXHMla+GMWB6pBfFDjrW3J99QemBMEiyxgpWch1A45ls9mx/uBOSas4w+CaPqx10/bw9p5MRs97GnS+N2vuhIFYl6BluufQqvPSoBeeI0QJprh/pGLfDOvrG42r0UMf18A7vrsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ1RxfqUyr4nxrQ7d1UHaK81U/LnW0wItp9Qh7w9xdU=;
 b=cVwl3gquzIagrGDUlnB1WwnhbrWCOHUEvMzZ2nTlVCk/FhLHSucU849mLr9Bbfw2lRuMBn5sFi0aGIXRk5BP7U7cWnbpjUJSNbM5ZW07vRmyBH4O+IlIowdToNJXWPGN6ZhCO4yMpRJaMW8Tob1W67CnA0lMn7kOI3kt2bvqZW+439tgS53zEygm0QXj/oh18IxG20HNP+HH69INUlwtbIQ6DiMwmVLS8JBF7+yooKPRwGKe/RhqOzydRv08oB0uU+OhyGouyHCSZAsDeCHZGMqlZ7+EJtsNmeT4lrr6kVZi6yApTagJmB3GkT3HDt8K+SilIHi3D2IGByhKgp0ZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ1RxfqUyr4nxrQ7d1UHaK81U/LnW0wItp9Qh7w9xdU=;
 b=jwULAKDm7SJ/drSbcI2p7vZRvLejj2+j0DnHYr+lRiKHU9EyaIaCa5LOMNDo74R/9tKGJmYrclejcj26PD2GBKxx/uYDwCZceSVAwjxKrm4CLHq/q2mzyyeKT3+Webga7xCeA+4LgJssQoI7zIGY9Om3p07bRcfYZgl8rPMyiQOKEDDdVLNvSo/YudsELLD3r25L90CqK9d3XFkK4W3fc8NNp4odnhO6r0FoPTEaX3Jzre0VgPaJwz1hV7/rIHJCPeUdBR4NpgUtIoPO9NoE2AtKrb1x3tHMucMa9x+D42yJNcYSgShinGJWz2fEFYFgRVwa0amxS9pFKHDH8/maSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10356.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 20:07:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 20:07:57 +0000
Message-ID: <eecc93ef-8d3c-4b2a-857c-471295ee6ec3@efficios.com>
Date: Mon, 8 Sep 2025 16:07:55 -0400
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.13.20 and 2.14.1 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: 9428475b-9f92-4b1d-8cae-08ddef13670a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDlGQmhjZXJzYlJPbzdwS2cwTGdxWUJnTTRENklnU1hQQVVkaDh0VjNjYXJS?=
 =?utf-8?B?TTBEQXFzZVRtQUI4VkYyaE95L2pMYTN4N3Q5SmY4bHhkRDhJNzVCNG5sdFE3?=
 =?utf-8?B?bm4yOWJITDA4TEtVa2FZeWpPNytwQkMyRlhMQjZLeTFzK2NhdW9XNWN3UjNI?=
 =?utf-8?B?S3pkdjFXeDVzb1VaSkRndDdReFlONXNaZjFJYXRWa3N5K05WQ0ZkVFl4eWRl?=
 =?utf-8?B?RDBPR3FJa3V6TGxES1orUzBSMm90ZTZhenVUT3BtVFNRQUVVOFA3bzZwQWpH?=
 =?utf-8?B?UUxXYjMrNjg2RUV4QnA5SVo0SWZhT1RMY290T3JDc0lBQ3RFMHJjR0lFU0Z4?=
 =?utf-8?B?K3E3MmNYeGp5VnZobDlUZ0xMeXpUUDl5M0dCUkxHc3AzcE5wOUlRd2NYU0Rv?=
 =?utf-8?B?a2Q4Nk50WDJ2TVM1T3IwdHZvbGk1ajhBR0NQUmV1bzlNYml4NzdVb2IwQlZG?=
 =?utf-8?B?ekVLVXcrNG1YU1laNkVZMkYrSWFOY1JMVWc1RHZuRWh5d1RUczA4UTNGUlpo?=
 =?utf-8?B?Q3RZclRNZXFJSTVKQ0NPU3M0VjVVSzg3cEJyeStRZHVCdlk3aFYrZ01wMUFi?=
 =?utf-8?B?MC9lUjV3Y3dkWU1Ha3RBVS9ia1daaExSdzBtd0R6NDNlcUxZbWxrMG14cDYx?=
 =?utf-8?B?bTh6UGJoa09EZkJFbHhPckRKTDd0eVVQYWgwNGJzQnJKK1czdkt5Q1Urbjgz?=
 =?utf-8?B?TlExNXdZZTE1eEJ6MysrM0VvMWdRbExmN2FjMVBFL2hZdExaQVdJNUZ1MW9l?=
 =?utf-8?B?RTJzY0REM0wrbTlOc1BKMXd6RE9RMkJWazBmYkxhaS9zR0VwVFY0TkhHU0lv?=
 =?utf-8?B?UjlCSHNvdmJ0RUN4ZUI5ejMwR3pWMnY4ZzJxWWk4eEN5dkdzN3Z5Ymtrc2g0?=
 =?utf-8?B?QUtuKzdmN1AzeHFKWXQ3WUg4bEhweDZLTjhqTENVNENwN1R4RjRTcFAvVkdx?=
 =?utf-8?B?UXJza1hZVE1QYW5PanUrRHNDcDBzQkJnSzlnaG82OG52WlBUM2VoN2pwSko1?=
 =?utf-8?B?RkxwaG9IK3VNSVRHOUMrc28rQ2dYZHVnWWZuc3pJdXlWMzdYQ2VQK3RQdkkz?=
 =?utf-8?B?YWhIWEZmaFgzOUFEWUYwS0o0alZPSzJRZm8zMXlqNS9maVh4ZGpUdmpJWEZi?=
 =?utf-8?B?NTdLSzJpeW9MNUhWRjRLY3libFNsT0dYNUt0U2pCVWFYTVMrT3FFR1FCY0NP?=
 =?utf-8?B?MEFlYnZwMkJEUFd3d1Vld0VocTRxY3BHdnVEd0doc1VreG5GOHVvcUJjeXRD?=
 =?utf-8?B?bVZsWENhalBjcklxUm9FL2dpSllFYkxWak9pMlFTRG1iNCt3Z3pLNmFxMStJ?=
 =?utf-8?B?ZkoyNTMzb3Q3TENXZ0Jtbmpqa0hVTWI3TEtjcHFLbG5rVW9OM3dqendIUnQz?=
 =?utf-8?B?MDlNVFV6N1B6d3B4eFRQK2htd3pCWDhnazVNMFcvSisva212dXlpYTl2Z0po?=
 =?utf-8?B?UjlhOUIwSUtWRzZFb1V6SXhOaWdOYnFLY1hkVDNYSzlacjlrL1JjKzY5NXBP?=
 =?utf-8?B?TVpQdkwwWU9hb0ZhbHdQeTlrdHJvT0llbENKOE1ENnM4ckRVbUZHcEZMVmYv?=
 =?utf-8?B?NVdTMStTNE1iazNPZzV4YXdsb3V0VTFjcElyZk1LK1hyQXJNaVhBdFozak1z?=
 =?utf-8?B?cnQ3QVRkUlg1RmdXQXAyVStwV3VqdVprWStWWDFJcWVGVysxdDIrRWd6UUJw?=
 =?utf-8?B?RERvaUJWdEJKUmZ3YUx4cndMemZ4SFM4UUtRWWRoYVpYbThtWEVlWkU3U1gy?=
 =?utf-8?B?TXNza05neUcyQlNtanV6Ri96clM5M3ZpQXQwSmJuRTVZYTZ3WHpUbk9BRmMv?=
 =?utf-8?Q?I9JWEEKbr/tnEHE4Aazsq1pGSa7PciLVm5H9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWpKT2JaVUhYejNjVlhEa0paaEtDOFZZd050SnJJMW1veXpCNzJkTFpJa3pE?=
 =?utf-8?B?OGRuYlhYMlh1N3d0Rmh6cS8xay9tc0VrTjFRV1dkbytESWtBeUJERmZYcFNQ?=
 =?utf-8?B?VVNIcGk3WTF5L004WC9DZWQ3akhzeHVveXpiSWRMZVN1SzJObi9veEp5R0w4?=
 =?utf-8?B?VXhjNzBQK0dWRUl4VkJ2L204VUlsQVpQWVNYRHEvdTFZdlFDVmVMQjVpWHAy?=
 =?utf-8?B?K0M2ZGk4NEpXbnZmRFUvNFN1dTUreGs2VDlXbTZyeEtsTmFJdzViek80RlV3?=
 =?utf-8?B?NjZTZjl4TkhmK0hDcEdNeDhrV290MUxpZExVb2F2bmdPMHNtVTFyYTlINjFo?=
 =?utf-8?B?RWpQbndLNVV5eW5IckkyMHlQb1RjemNnb0NqUGpaNHgrMHR6M3RDVm8wak9U?=
 =?utf-8?B?ei8wVytBWXh4THVWUGxHeEhublNqK0VsZVhqR1ZPQS8yYXNLZk5BaXZKMCtw?=
 =?utf-8?B?ZFB5dWdiMVFTUjA5ZkowYlFXVm1Za3ZJenNVbHVaSzZLdGV5eHZERlFGVDdx?=
 =?utf-8?B?SFFSMU5sVG9NRWtiN1VUUDhmczU3djYyeEpTQ1lBQzNoa084dktkS0tRaFRH?=
 =?utf-8?B?YzhQNUdieGtLSGtjWFlFN3BSZ3N4NmxGY21oeXYxcm5Qd3QxL1RwM1hkZDRP?=
 =?utf-8?B?R010N2laR1hBUHc5QlB2ZWJqQ0lmT1RUemQ2V0tnU1AxdlN0Zllja080cW9D?=
 =?utf-8?B?VW1BaU9DbklPS1JyUDRObFhMTStkY1ZUdFF2aHR3QzdCY21ZanZPMkQzaDRF?=
 =?utf-8?B?WWtadmxMYjZOY25ENGs3bXRzTURySTh0d2RycXN0djJFc2diZGFQOXZHQTB4?=
 =?utf-8?B?WEtzMUV3YVJpVkdDUDBjN3FtTWtPcXhyNThGeWNIcXRjRDNnam5hTm5uQlhI?=
 =?utf-8?B?V3VXTnZYdTRjVHVGQW9leGx6c05hQVh3c3hhelJCVm1DM0JtRzV4TXJaQ3Bj?=
 =?utf-8?B?SlVmUSt4emExU3FTMXVVeEtvdWVEaUhORFk2UUZkVGJTUWFHMm81SFVkS2Zn?=
 =?utf-8?B?aFJWU0dVSGFMalJ0eUYwOUdnazZNN0dvU2NMaWZ0NzRaL3ZrZDhTb3c1TDN5?=
 =?utf-8?B?eFdQa2xKMmdqcjdCMTJkVXVmZkRyZEsrM2ZhVVpDNkJWbDlVNTVJUUc3VEJG?=
 =?utf-8?B?bG9sRUl3Q3dzaEVIUWIyS2RSQWhNNmVWdk5MK2Z2YzA5T0FKa0FrZjA5NmFo?=
 =?utf-8?B?WWlQajVkUVVyMTQwUVMzaWJ2MVV3T01BZkQxYit1bVM3eU9HajlocFd1K1da?=
 =?utf-8?B?YTdvOUE0c1lRa1JXbkxLdlhBUlE4d1B6MWZtR2hKeElOb2k4cGsxbG9FOGRn?=
 =?utf-8?B?YzBRUkVaSTE1MVdOQXhPZVVLYlRBMWV5a2R2TW9jMms3bmx0MHovb3JxUG9R?=
 =?utf-8?B?bWhTSDd5UFc3bDhJMytQTHoweCsvSFJlaUtydVZzelRMUitFU0kxemhiZkg3?=
 =?utf-8?B?QTV1ZkVOdG1iVTFBeUNUNlpZWm1CK01nOWp5ZUhBYW5ZZ2Izc1J2ZFJXQ3Rj?=
 =?utf-8?B?ckVyZ0UxZVppYlRXOUV4dnkyZ1BwUTBSdjNLbUE4MUpMRDdlSXE4bGJSVzFl?=
 =?utf-8?B?R3NLN0pDZnZCRXVnZmZUcXNpUjM4dERpSlQyeUVablhqWkIveE83NGZ3VTFQ?=
 =?utf-8?B?Vk00TXloYUdsUlVrRzhqa0hjVzUwMTl2Z21mUWxjTFk0dTBNSEtDd0tGVEhF?=
 =?utf-8?B?Q3VoVzBabVhGNUd3R0o2VG02dWdsUDFSTlNZa0gxY2lZTTN4SmE0dDl6Qmtx?=
 =?utf-8?B?UVlJVjZZL25yUStZa2pQZytHUUZzbzRad3d3dGJWMENFbmtKRkVGNVdQOUNp?=
 =?utf-8?B?ZXFyU2xGVWlGdVcvUU9ic1M1ejNzbVVjdG5iNC80eEgxTjBlODlmbVBJTXo2?=
 =?utf-8?B?UFBsOXE4elNreHdiUDY1bzVkbzVsNVJ6LzlvN09iN0VtYUFSS3BCSStCc2po?=
 =?utf-8?B?c0EyYjRxdkcwRlpRN01Ubnd0UXMwY0FFVS9VcWZVQml1ZnhFSUJVRmZLdWNN?=
 =?utf-8?B?NDltbmNjc2owUVVwMnc5UVNjU0FSOXZ6aDZEUkthRDdmN09SWXVrcC9tODdj?=
 =?utf-8?B?QmNEd1duRjB5YWJIRm9rN21IQ0Q1Q0RCT1RsczJQbHNkeDVnanRabE9WZXBS?=
 =?utf-8?B?MWtWR2M5QnJwYUNGNDRRZEZmOVdqdkQwUDNhdWtmUHlHSVkreGVLVXkwd1Ba?=
 =?utf-8?Q?3UdmY0vKH2on98D0bAKMlcY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9428475b-9f92-4b1d-8cae-08ddef13670a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 20:07:57.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/1uAy5yBM2764Kz64NlMeSBZGXJ8n133PW0ET8DOOz7N3ba8ekwu7yUJMowtKBzOQzTwgtn0la7f2HT2X9Wd9TJIM3V/HlTkhvUzWWVhNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10356

Hi,

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New in this release:

The changes in those releases are mainly kernel enablement updates
to allow compiling against recent kernels and building against the
full kernel source, which allows building additional instrumentation
such as ext4 and btrfs.

* Detailed change log

2025-09-08 LTTng modules 2.13.20
         * Add missing prototype for wrapper_get_pfnblock_flags_mask()
         * fix: mm: remove the for_reclaim field from struct writeback_control (v6.17)
         * fix: btrfs: use refcount_t type for the extent buffer reference counter (v6.17)
         * fix: percpu: repurpose __percpu tag as a named address space qualifier (v6.15)
         * tracepoint: Have tracepoints created with DECLARE_TRACE() have _tp suffix (v6.16)
         * fix: treewide, timers: Rename from_timer() to timer_container_of() (v6.16)
         * fix: mm/writeback: Convert tracing writeback_page_template to folios (v5.16)
         * fix: mm/page-writeback: introduce tracepoint for wait_on_page_writeback() (v5.2)
         * fix: btrfs: use the flags of an extent map to identify the compression type (v6.8)
         * fix: btrfs: update the writepage tracepoint to take a folio (v6.12)
         * fix: btrfs: tracepoints: add btrfs prefix to names where it's missing (v6.16)
         * fix: ext4: Change remaining tracepoints to use folio (v6.5)
         * fix: ext4: Convert invalidatepage to invalidate_folio (v5.18)
         * fix: sched/tracepoints: Move and extend the sched_process_exit() tracepoint (v6.16)
         * Fix: `fast_page_fault` changed in RHEL 8.7
         * Fix: `kvm_exit` changed in RHEL 8.7

2025-09-08 LTTng modules 2.14.1
         * Add missing prototype for wrapper_get_pfnblock_flags_mask()
         * fix: mm: remove the for_reclaim field from struct writeback_control (v6.17)
         * fix: btrfs: use refcount_t type for the extent buffer reference counter (v6.17)
         * Fix: `fast_page_fault` changed in RHEL 8.7
         * Fix: `kvm_exit` changed in RHEL 8.7
         * fix: percpu: repurpose __percpu tag as a named address space qualifier (v6.15)
         * writeback instrumentation: Add missing provider name prefix

Enjoy!

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


