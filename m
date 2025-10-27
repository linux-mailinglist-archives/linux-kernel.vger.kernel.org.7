Return-Path: <linux-kernel+bounces-871137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3FC0C830
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C2C403DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E69319857;
	Mon, 27 Oct 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Rbhu4H1s"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023090.outbound.protection.outlook.com [40.107.44.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14233191C4;
	Mon, 27 Oct 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554864; cv=fail; b=b3NIoCfdhuln7+k6bS3C3l534LX20xN9PpgxmwZDfoEEXYKV2Ro3oaZSSFddvSulvMBcP2AFYA4xsKvefpt5M7NKTjEQ1rvsoaoWBoKQazmZTofV8l2MDgLfcWeo8I1JvVLiVWa5CVG2xBr3V7bnEnlwbptmigiWklLWwFolg2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554864; c=relaxed/simple;
	bh=9+T1fdfYKverjItwr5Qrv2UqjKZ7b07VYzM82Cst9xU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ngygHsAEb8rXn5m+4QmC3I3VaM80AEyZA47/CCs3qHODslC7SHx4neMOo8qGOP2ugaxty8Vc9F/SJhTEHZlf0EY2sJJRFmgGe6uCidTJf9dUCUVMaE6M/BFkTURncva9X/jm9sNDVCr3IKVPT1oVO8lDVBAZEAVQovagro1wD+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Rbhu4H1s; arc=fail smtp.client-ip=40.107.44.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUSOIpH7OI8EuFETsHApxP+UBNESThumtlorOD98pLf0QxGIjmCHCHE995d345YRMvR40lRuEmc/M3iABMocp3KpiaKc6iBSz3/TM1O02uly1Q1nPswM8rCmtP/B9334zyiiKg3mshAM5SvSFUxikxzJPuwcwO270fQjjicqODXgdeZ/oFuvZIIR3LGFfB8usjMk0br64kiQp11aDbvjPYjKXugq1X87Mlzo+ONdDjJcNNSBKmkqmfEoGEv0TnQiEkAp5vgc2p19ZV1WK1gCpBHMdbeYhyy1ZixEn5zPijM1itBQSUPWd+7DmCiiTIAcF1lg+tCSAYdWFrjB0Scdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/LwD2/UG2+N6HOaszl8a20y8EbFS1tUEw67A9Cc+Wk=;
 b=WB0Ljum5OBOucjgEdnyYX7z34FEixvBDkQ8642OlyQ0wVuHqxx0XK9AeIe/1FKYrcGe1nqbszLnot9XlFoGhWiUlEEzG+UG09yVdrBvMQRjPvaFTuOsm7lohAxThOH7meU89pjIyg0UdPbapX6lDT0c4JjXVojHR6vS2xNdce1FpSJ0uAnM88sAoylaYz4UBLX3ay0w3jluOCZmmNJcChR9Z6IJjc8R+8ZO1GTkrgNl4k6K/VBXgfpHWgqkwlavA74ttRL3V8VczrQ4o7GoDiQw2kL60cAYXzmsO/pIy1Mw/o7YiRAqRWT0mDGBxOQ/4s6o1NxTDAOExtflwtk0rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/LwD2/UG2+N6HOaszl8a20y8EbFS1tUEw67A9Cc+Wk=;
 b=Rbhu4H1svjtnDqncIewImjm/nDIZqtKUrViRcTN7gS6kZ2mkZIIp9E5hLyltvPZgxvDKqX52qswa2OttKzvaTg2tARlk+FY3CMARZPHosPejRAOQUUPYgkgmDmrTnHBAT11MJxXi39r042fh93ayRtoTGGS8pRo9Uz4ZznavBIeRPmEf/X0i1pLc5jTM/6eVbsAGNFozGD5OcNGfEbaqN60frlQObAGbfm+okbNr1Oyv0HoLMNZMbO2VElQEkD7/9GmGYNPSuUgkv52zuZDMo0BdydqeCXn/FFGFqxfQ2lApxOsNmhP+sLbyPVjS+KJ+ZGR0kcYCl09wJu4UKcd2jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB9464.apcprd03.prod.outlook.com (2603:1096:101:2d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 08:47:36 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:47:35 +0000
Message-ID: <803c98f4-a9a4-4b85-94d3-38bf2d1e6eac@amlogic.com>
Date: Mon, 27 Oct 2025 16:47:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: divider: improve the execution efficiency of
 determine_rate()
To: Stephen Boyd <sboyd@kernel.org>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021-improve_efficiency_of_clk_divider-v1-0-e2bf7f625af6@amlogic.com>
 <20251021-improve_efficiency_of_clk_divider-v1-2-e2bf7f625af6@amlogic.com>
 <176144194442.3953.13998249458455926261@lazor>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <176144194442.3953.13998249458455926261@lazor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 421da696-aac0-4951-24c9-08de15357966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHhZVVZSd29wZERGSHV5QlpwRE9oeEphL0FIUWNuL3FjVzRBWldxRzdiOVJQ?=
 =?utf-8?B?dzJuMjZkZWo3enVvVzhkZ2ZNaDZ0R3owUkdWelkvQnhTS1kraEY4aHE5V0l2?=
 =?utf-8?B?SFBtT3VBbVcxVXpwY0UvRy9xTDVsSm9KOFE1aGkwaldIdjZudDlBOThzYkIy?=
 =?utf-8?B?NGJiUUJjaFhMeis3U2tJNjdUeWZPT3Q3UXJVK2o1U1BFNytLbUZlNDRZalNL?=
 =?utf-8?B?R3d1c0cwMU0zRnNUUHNHN3lBL0NxK21BQVNCYmVrT2RRZDV5eTI5ZmkvOEhK?=
 =?utf-8?B?czVVUGQwSTUzaHN6dHpxZE53N2RNRGNBVm1YYkRTcjNuNXZjZkRVeGo5bDc4?=
 =?utf-8?B?aGhRQ0FiK0U1RWVGMmdvWDh1WnZtb3VubkhBQ0hCMDlnUDlwM2liQTh5NkFi?=
 =?utf-8?B?bUwwaFBvQkJkbzRvU3Y1cUhELy82SnhDemNPMWJLa1pjY3EvakdZbmdHTmJq?=
 =?utf-8?B?bCtnWnNPQkxHNXFwaFVZMVlPTWZielBNV0FtLzdCMjBJQ2hBZU84d05FM2RW?=
 =?utf-8?B?MDN5cW1tKzdKOXpUb3dIUG9WbHVrMlArc0pJWHB5MlVmb25ZSWN3Y29POGVM?=
 =?utf-8?B?KzVlcWZiYjVnSzRUakhJS0tCRWs0M2cwb2V5L0QrVUV0SElxK1FIY1BLaWt4?=
 =?utf-8?B?R0lNbXYxZ3NNS3NYbGhWcDBUWDFvK2krUzgwTktva2xJVm9abXEzaHdNR0ZZ?=
 =?utf-8?B?UHpKQTJxRW5KbEs3TkZhaXl1eVlNdGdiRUtsYUwwcVg5ZjAwZmtkZVJhaHFp?=
 =?utf-8?B?RlVXd0NxeWtsOVR3WnJFZ2MzOEtsbDZ4WnZQa09KT0RQUWp2ZnBFUDYxZUFu?=
 =?utf-8?B?MnNZOStzOGpVVThoTUh6T0dmZmlrK1VzSktxYTh5Q1lzZzhBTUJnVGFLVmln?=
 =?utf-8?B?SzNtbnRwQk9OU3hEMy9vZE1XRUJyMCs0SDFhK3JLazZzdzJHb00xVDBVN3pE?=
 =?utf-8?B?R1BFQ05QTGU4alBrNmtvS3hEelFpL0t0dGJPSVdkYU02a1hYZkpDL1B6YVlM?=
 =?utf-8?B?aGEzWGtuTng0a0VYK29VemFxcmRpY0szWWFkRG11WHRsSmJMdFBSSWlmalJW?=
 =?utf-8?B?SHFGM0h0anhVd2dRTE9Ua1M1cnlWV20xUnhnT0xROEZmbHJ0SWNFM1BWWC82?=
 =?utf-8?B?bnE1dFUxYndNMVhOUVcwNmQ1N2pxYTI0NG9HNFE1VDVzWXNkcmRQR3U1WDBq?=
 =?utf-8?B?THo4MTYzVkFiYUJPdU9uUHNadDJDV1pvdHZ4WEhkQ01kK1hZZm5mTTVLdnB6?=
 =?utf-8?B?dzRYN0VtR1d1c3duT0F4RVFGNTdIbXlSbWx6cGIwTjZvVmN4QVYwTEFEdGNO?=
 =?utf-8?B?algwemxqY09MaWhZbDVDdW9aRHRCbVN4RWtzam9lUkRPU1R1WE9mdkVKQjVG?=
 =?utf-8?B?NHJXZ1BveDRNNjhOanhiMm5wWHg4TllSLzlJRlpNYlloVDlMdmRGYzFJdDlW?=
 =?utf-8?B?b29Zakl5RExsWDBpb1FDWUR4T1hHWEErSEdzN0RWWGNBQVUycm9zZEo3MFlT?=
 =?utf-8?B?dzRVRTQvTjNycHJZS3pyV2FjczJWcXZhdW9LMEM2c0NIWnc5NzVYcW5MdWRL?=
 =?utf-8?B?Wk5nbGlOWWVLZjI0UzVJc3dyUW5MZ1NPenB4cklNV3dRaXV4SUNQZDVkeWlW?=
 =?utf-8?B?NHpJZzVNWHdnVFJaUHBWTm1qbzV0VEZEVmpZV1NRZnprajFUYUFnYUNzOVN2?=
 =?utf-8?B?UGp6U0ZLTWFvSUU4S2szU21GWVFQQWpLNlpvT0ZPOFF4amMwZU5uYy9LMmlE?=
 =?utf-8?B?K25kc3ZMMXpORmdqeFZEdURhWmVoUzAwZFZBbDhhZ0tXRTRCcmhhR3M5cjBv?=
 =?utf-8?B?TFZGbU5jVXpocXFiczdLMXVLaEZMR091clFYWTRqc05CckRwOEZDcjhHRXVK?=
 =?utf-8?B?bU9sUkpIdEV3OWFsKytyRWoyMndYMzFYc09jY3ZzRlM0KzV4cURIS3k3N3FB?=
 =?utf-8?Q?1tdGxNhKN+lPB0BDGF78xfWqLrocrtnK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTc1V3JSL3hPTmRSUGY3MitDOHRLa1ErbDBmdHlXWVR0dWNmZGk0amMxNlh1?=
 =?utf-8?B?VXFTU3l2L1NqdnJERjRidDY5ZVdBUXRTUlVNWUpvY1lndFNSVEtBOW5SVWt0?=
 =?utf-8?B?WmJEbit4ZUM3TDVFTzh4TC9JQk5CZmQwZ1gwbGtMTWFqUHRHeEIzcUhaOGZv?=
 =?utf-8?B?LzYvVmtJNzlJZkNHc3JubjBYbG95UVBMWFZ4NG9KSDdhc1lsUjlid3Bhazl6?=
 =?utf-8?B?eXNMdlVERWpzcllTdFR5WFJmSEl4TEdqajIvbC9QNFhmOGFibDJGeUNJTUxn?=
 =?utf-8?B?WW4ya3dHa3JUTi9hRXl6dEF3eXN6RjZwWUdaa2VpelMxdGxFeExHaUh2MFVy?=
 =?utf-8?B?cFVaYjRjT2x0Rk5nSUJxQTF5ZU80SGhxUklKQjd2akQ3V0t1MlJkcnd2NlZD?=
 =?utf-8?B?WEQ4c0VGYVU4WEthNWt3VmlKTWU1TG9IV3ZjenVKY0tTakdhbnZNRVNmbEx3?=
 =?utf-8?B?UEdCYVpIaXE5bnUzQlVNQXArcmZTWFVnSlNSTGh2MlFKcmptLzd0d3FuU2R0?=
 =?utf-8?B?WXI5WURDZ1ByVVErVmF3cm1qMWFHZGQ5UzB2RjQ0eEdLMWhCZjdyVmZ2SXgx?=
 =?utf-8?B?aS81RWtrZUtaVG1oenBPc2crb2JFSTFrZVo1bXoyVnJSRXlyZVlOMTJYa21E?=
 =?utf-8?B?ZkFPM05FTmZrTU8zQnVHUGZELzZkR3NHTDk3dW9hRmNLNjJQK3c2Y0JJQkRz?=
 =?utf-8?B?UENTcG1RUWRhL1cwUnRTZFJjYkUzYTB2a21zeHBQbERTeW5PMmZ2Sm9vcWxF?=
 =?utf-8?B?cHpUT2ZRczhqT0drWDdFZVZ1MVZsSjQ4SXBpUXBBVFlUaE5jNGw1RkNoMURj?=
 =?utf-8?B?NTl6T2x1bzNHQWRVL3BzMVRyNHVQR01yNzh2czJNMUxKZE1JWVQyTEl4MGxT?=
 =?utf-8?B?MFVITXUrZWVTcnBadW5NRlhjeW94WGRIUTFNaE1TaURKTncwemNGalpJU0h5?=
 =?utf-8?B?dEJWaGszd0swSlpEc3RvTzFMUzc4VXJMWDdWb2pVVVlLL1I5MjJJV1dFY2sw?=
 =?utf-8?B?R1FwTlNZek9RZDR1a3RmVUVYRnN4ZXBWeTB5Qm9hU1EzNld3YkNDWWRsOWpN?=
 =?utf-8?B?a3BxQlBtdHlITUVYTVNvSVk3VXJ5NW95UVlrTnQybmhlT3ZrUUhjZ1RqOWJF?=
 =?utf-8?B?VFNiTHZHS1hRZEw3NGVBR2VFN2M5aG9BaytuNDRxUjRCcG5nd2FsNzByajFp?=
 =?utf-8?B?bDZ0TzMwNUsvU0xtYjBJZ0JhaGlzS0JFd3IvR1N3VUZCNUZkdGI4MjF2NFYy?=
 =?utf-8?B?UWN4K0s5N1NTTVNTRHpTVjVVRmMwVHlLSXcweFZKUzdyakErVmRDRWdjaWdT?=
 =?utf-8?B?cXJsaktDM0l4QVI0MmxZMURONFVXSFhKc0ppblh6MEV3YlRKUXh2b2h2Rjgr?=
 =?utf-8?B?TkZDbkpPTTVlT3FJTHM0TkZvL1JsVHA4TmhiRGREMktJZ3h3OWRQRlBFK2V5?=
 =?utf-8?B?N0ZYYVdDVkwrRnd2eStDMHgyUlEzQXJYeUd1aHZBMFJteTYxbFZuU1RJbWpq?=
 =?utf-8?B?SVBCNGRUNWIvemdtUHd0bmQwMGN1SEJHT1l3VHZGWk5PeTRKOTBhcUtIdUVX?=
 =?utf-8?B?MXZKdkJrVDVlZE1idTNyc3I3MTNDYVR1Wk9EYkZseDJ5a3NTcUtZbDM5d0tz?=
 =?utf-8?B?aDZobzB5citlcmtwUWxzQUh4dE00WTVZM054Y1BWUDlnWUFmaXgxWjhvazFN?=
 =?utf-8?B?VkNiQ0hjbllJSmh2Vzh0TDJZbzNFMUZtUysvUUdJSEhKbWJURlhnWUUrWGZt?=
 =?utf-8?B?U0ZUbVhkL0YyOSt0dWpQbjdMSS9TOTBzV2h6Zkx2SHQyRXZxb1QyM2hMUHRz?=
 =?utf-8?B?Tnd2Z3UrSWZaSkM0RWRCb2FHSERQSDBKVEFMWXM4RXMrVDFtcEJkTk1TaUFK?=
 =?utf-8?B?NC80Uzc1RnFpMXdqeXF1anl4dURFQk4rcndjSEJaVUdZRHdRdWd3bElBeWtV?=
 =?utf-8?B?blFMUEJKNUR1N0J5QmlnWW05Y3VpU2JtUU0wT2FoSkh0R0tON3ZZY0trR29j?=
 =?utf-8?B?YkdqVFNiWGxDTlBGT2h1Y0d3ZmgwZkpvODl0aVJET3ZzbDAzd21zb3Q4TjFG?=
 =?utf-8?B?NmJyMUNSOTRZTW0zclU4bWNKd2I4eXIrdHVlNnpMWVRtSTQyWTBLaGZLSFVq?=
 =?utf-8?Q?a+spURL30wbCVxtwcr1aj26FM?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421da696-aac0-4951-24c9-08de15357966
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:47:35.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDMhoB5isAgJaEzcY0P3l/UrjbjN1UdeQcvxIwimCfz1HcJayxqT2aJDNoHISg51rzsmz45v1PjUKLC5cAg9Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9464

Hi Stephen,

Thanks for your review.

On 10/26/2025 9:25 AM, Stephen Boyd wrote:
> [ EXTERNAL EMAIL ]
> 
> Quoting Chuan Liu via B4 Relay (2025-10-21 03:12:31)
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> There is no need to evaluate further divider values once _is_best_div()
>> finds one that matches the target rate.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/clk-divider.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index 2601b6155afb..b92c4f800fa9 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -339,6 +339,9 @@ static int clk_divider_bestdiv(struct clk_hw *hw, struct clk_hw *parent,
>>                          best = now;
>>                          *best_parent_rate = parent_rate;
>>                  }
>> +
>> +               if (best == rate)
>> +                       break;
> 
> This needs a comment. I'm not even sure if it is correct either, because
> the other exit from this loop happens if the parent rate can be

You're right.  Sorry, I was mainly focusing on the number of
iterations in the for loop earlier and missed the fact that the
parent clock directly participates in the division without changing.

> unchanged. I don't think we have any KUnit tests for this file, so
> please add some tests that deal with this case explicitly (the parent
> rate being unchanged as the desirable part).

I'll take some time to get familiar with the principles and methods
of KUnit testing, and I'd be happy to help improve it.

> 
> A general comment: these patches have no benefit described in the commit
> text. Do you see any performance improvement with this patch? I sorta
> doubt this really matters because the number of dividers are typically
> small. A single sentence commit text that only says there is no need
> doesn't convince me that any work has been put in to research why the
> code was written this way or even prove that making this change improves
> anything.

This patch came about because I noticed that the mux has a similar
logic:
- Even after finding a suitable clock source, it continues to iterate
through and calculate other sources (and even if a later source has
the same rate, it won't replace the current one).

 From there, I went on to examine the divider logic, but I missed the
detail that the parent clock doesn't change in the divider. Sorry
that this unreasonable patch ended up taking up your time.


