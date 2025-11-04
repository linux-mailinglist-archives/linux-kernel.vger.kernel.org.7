Return-Path: <linux-kernel+bounces-884106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90EEC2F5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE80D3AB198
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30472C15AC;
	Tue,  4 Nov 2025 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="XaZk3B4U"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022123.outbound.protection.outlook.com [40.107.75.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C12C027D;
	Tue,  4 Nov 2025 05:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234131; cv=fail; b=oqa6eKSlOHE1Q3OuJqi8TEuyps00EykuMW69eoWbvDIeHygTAIpNUsvwIWjrhH1NDdYf1ixCnng9Dl/3/OY7ztaza3BLFnhnLVj3hNBHzY6MyUvHJtxEs7IeFnq8aN4q6p0DUWb2MJbDL0Cy/++3n4RRShROLz+gnplUhTRE7tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234131; c=relaxed/simple;
	bh=oxu6iXSRyPTWD87gZwcjc4a4wPnfu/CnvKdHNA96JqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7G9LJXiHrqdWIGYbGYv5LdEfDZ8XJSd6YEKybnGwBEoDsUfvJEWPVNYI8PNLOZTEUrEFEJiXS5wo2s9kJbiZY/uPrzFzY8FHZ6MxUNFIQfXVAz9deZhym60+FSQpbeKxJymUfECICvuwodaJ9tvTps9tiZTpc7lYsrpF6t/FFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=XaZk3B4U; arc=fail smtp.client-ip=40.107.75.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAOVrcZb8NM7Hes8gJHlx9/TWaAsI5f9J2pQnBk1nnrkTdIGMSd7ko+QBSLPRUHZrDFHgunjxiYETXji2JUqPahcCmFPd59YGc3fL6BRBg5q5zyozn1w9GyumrNcmQqm/oYxAiAwWzEUIRgXaO4u9wH6ztryLPlDN9U8FpUOigGpKjB/VdhOhmGl+8atMjcRI73jC5aUu3Ut6swAuXPzpacKHsXNRnKv2boq3/GWiLPm+8CW8NbjhjcBEPoDz3TibS8rd18aX4WfGJc//ncWSNMiIx0mf+JcThc3R7kPRw3sKbCowRGYBeGjuZu2JiLSq3qtIQT0E744l7kdPH+lxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i+PNdAcUEsp0BMwfot0bE3vOIU0AfEh/HHg9XLLYBI=;
 b=xQiQE75Jv0RkEzS2rCAhQxiLLce9rw78KwHYpPWRYsjuHeDg3gSZxcVV00vzJCeCZXjqckGxhRMZbR0s8n8e3ofEaGw8ojHiKIoZD2CZa/RoPzJzkRg1TZAHtv3ODklXDbo2puYaSD1QDt1IugsCQNebks2TkUtiqS/Bd/YGN+bIgPcliJEQU2eA/cQNsDxgFwZKHUndG09AN0vZNBfCuuKWuOnL57XRGrmlazn8vXR29iyyGnamZHOPfSy2O1ku1s5IokKfj0tiu1FBrD4QMr0JSZpn5IrsT7o8JdBZjZld5P0W2govsSCSeunbegBSe8uQYdWDjCT3lP6wSBM/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i+PNdAcUEsp0BMwfot0bE3vOIU0AfEh/HHg9XLLYBI=;
 b=XaZk3B4UB7mJ8QZhOBHKqqu+v1q8IlKsK0+AKBlFx45HTXwPq59emdOaoxwsT4iLlkq0kXQqbrarGleXAUCemHjcjtnaiDPFks6gnNelCYp0Znd+lqpabOwGpDHCXfmhKK50K+Z1PgOUb8eH7XypySrFuZfAvZgh/iK7bQ9a+3uVTW+6vgkICGDBhD0JiOZkidhMFms8zkikMItYoUEOWTdQb0Kcn8BUQFoBT05nQE2nkCieV99RTthqaWORJqhK/hfu5Adq96PiaP4xxPFnewgvYytGhSbfUQz7xKP8Nd41+djsOOVz0W4LpIggaE+olqQlrlD+H4//YmbMNbNZZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB8585.apcprd03.prod.outlook.com (2603:1096:405:ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 05:28:46 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 05:28:45 +0000
Message-ID: <7a3c9205-8fb8-440c-bebe-090f1c49689e@amlogic.com>
Date: Tue, 4 Nov 2025 13:28:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] clk: amlogic: optimize the PLL driver
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
 <1jms57xx05.fsf@starbuckisacylon.baylibre.com>
 <9751014d-926e-4d42-b8e1-5a4d3e734457@amlogic.com>
 <1j5xbvxchd.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1j5xbvxchd.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8729ca-e3ca-4c13-1a62-08de1b630631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU1Qb2xYZ0cvUXBzcnJETzdZV0RLRGsxbzh5cW1hRXlUOFNIOXNNREpWT3dV?=
 =?utf-8?B?ZHg5TEIwWFI2NU4rak1VYkI0bER1Z3VjdCtEYUNabXQzQm1LQVRDa0ZqeXpM?=
 =?utf-8?B?Q0NYZ1JFQ0QvSDVaeFljZTlYN3p3a0NOdndlT2pYVGVCcGxpbVgrSnBRcXhP?=
 =?utf-8?B?Nkpic2RSMnM0bWxlQU1IckdGNWwxaXFLaDhseFA3Z2dXeVNIVEFmWVlPN1ZG?=
 =?utf-8?B?eTJSUzNucjVvTUJFZ3owV0dGVEl2SEJBaktXUkV4T2x5S1VGMFZRUUtZV0xU?=
 =?utf-8?B?YWIwSWhTUW5RKy84emd2Tjl0cm44Unc5aEk1SWV0YnNTczkvOTV1Q3AvTER3?=
 =?utf-8?B?VWt1aGJURnU2bjdjL0ZNdTlLR2pneW1RS0NPTGo1bUZRQUtTOXZNanV3Zlo1?=
 =?utf-8?B?QXlsVTBuTXFTNFJPWjhEdjF0cm0wQ2NWc3hYWFJsc056TzlMZmpRK3RIK1A2?=
 =?utf-8?B?TVFRdUJHVmVsM0U4cW5FMkpRZzUwM25lVDNOQ0UxK1VUTGVuTEpaWmlnZnpY?=
 =?utf-8?B?YjNBL0NuREQrdzV0R2s3MGVYb05HLzB0K0pPSk9sOTVPWG41eVBBTVZDcVY4?=
 =?utf-8?B?TWxCUyt6OUNYOWxqVURiQ0VhM1VSZGRCQmRxQzNrTndjTlFMbVhKK2tieHkr?=
 =?utf-8?B?amwweTRRVkZXNjdsZmpJNEUvS1YxbndjdGt5bmVaQTNnM21FZi9lVUIvMTRy?=
 =?utf-8?B?RHJkTXd1dHZXS1BDRktpQXlPRWVieUxWMXRlaUljQ1VqVHltYzdSTHZDV0hs?=
 =?utf-8?B?Zm9XM0NPbnZuVXpqWUdxdWhvcG1oMDV6Z09RbUpoY05BS0pBSDZqdFBEMm1W?=
 =?utf-8?B?anF5bVZ6NzRqVGw5Y1JiRUljalk1aWhneThUcnJQR3V6ZDZOS21qYi8rWm9J?=
 =?utf-8?B?YloxSDNhMEc3ZW9KSW8xZnVpZWdONkIzcGtsMTI5cmRWWXNzV0V0bDRQQ2Rn?=
 =?utf-8?B?alkwZmttU0hnQk5oSVZxWFU4djVTVnhIL1ZseWZYWS9YbVRHR1NMVFVLTGt2?=
 =?utf-8?B?cUVKUTBCQXM1aGFkb3R3Y2syUkQzMkE5bGE4b3hBV1VXQW4xT25KTEd3RWpW?=
 =?utf-8?B?NGh3bmdwR29VOTJ2NEp1Q3l1N0h6YTByclM3b1pMUGQ2bU1LTHh3eUJ6Znly?=
 =?utf-8?B?b09RNDBVdU9ibFdPTnR6U3ZvamdIUTZwN1pwUjEwZTZER2VFQjFiVDVSSkVv?=
 =?utf-8?B?N2xvMlFCZTMxeThlVnFvdE1WL1k4QUJXcElyQkdrNW4ydXczWXdHT3hEVktt?=
 =?utf-8?B?bnQyU3YvcGJ2a0ppRE5yY1U0d2JZeERRYVliSll5cHB5UGlUZ0N0NThIeVVK?=
 =?utf-8?B?cFA1cm45alVaTjZTNzNZSkk2QkVaY3p3a0lqVEZOUXhZRDBDTGZlZkxjUG9C?=
 =?utf-8?B?RUx2dlR5TWI1UllvZWVJeDNvY09tWUw0TlhtZU5TNkh0NGV3VnY2ektKTHRW?=
 =?utf-8?B?N2xzY3ZZQkhtZmxBZEo0blJsQjNEVUsrenpRTU1qcmwvSlpRd0h4VFk1Q0FI?=
 =?utf-8?B?b005Z2NZdTF4ZHRpQXRYUUk3VkxWOWwwRzg5Mjl2dVVPaW5UTk82WkZrN2Zt?=
 =?utf-8?B?cmMwYUxTcWlLdEQ4eUt1NUpOT2FpQ1ZlWlJWS1dNYzZqTVFRZ1BDRnBrbnRR?=
 =?utf-8?B?eEI0YjFIR3JhMHpjbktOWDBUc1RTYmZaNTBQNkFDY0twNmQ2L1pYbUhZR29i?=
 =?utf-8?B?VVdjbUVzbjhLZE9uMk5YdFArYXNQTVZ5YTI5UUtpN294dm41MDdtRmg1SUVs?=
 =?utf-8?B?NXlMRmRYd0UrdTVoczRrcEFLemhxVXltTnFYdGtxbTViQS9qVGdlSnAvOVpp?=
 =?utf-8?B?ZVNiaCtZMEhmK2pjSHg1SXlMRlRwdlk0R2lrVXdSVE96YlV1NTZnT0w2a29s?=
 =?utf-8?B?ZHBkK2hjVmJIb3RXdW1uc0Z6d1F1ZS93RG14dW53bTRSQmZBZ3NvWjlGTHZi?=
 =?utf-8?Q?tj6K/fCf/MgvyaBwXgKvZJLdcFL0N3T3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzBzUDJGVHBSSS9kNGhLaXMyOUoxbFBIUEd0bGpEY3kzOHA1bjZlZ3d2cGlN?=
 =?utf-8?B?aVBhNU92Qm1UUi9vOGwwaUhxVGQvZUcvWW1JY0dZdit2Nk9udkdaTTl3M2Fm?=
 =?utf-8?B?NkVPa2FsbDhZc1dIcFIySDh6UE4wOWRBQzlxblQ4MThyYVV3QlFITGRVWGZv?=
 =?utf-8?B?dlAxRHBjK21Wd2ExZWU1aUdsc1YrRUpoTzljdDZWMjcwQTdHRmVJckI4RE42?=
 =?utf-8?B?L1QzUENxZ3k4UldzT3c3c0t3bEpGdFVNUERIcTAzZE4rU0tuaXRwZWFYQTQv?=
 =?utf-8?B?ZlZqNXJ0aitqUk4zQWt1eUc4bEFid0pxN04vOWRNMTlKQ1RvQUxXdmFkc0NO?=
 =?utf-8?B?Q1J3WXptSlltUEh0bmJ2YkVzUHMwYlVxK24rME1uMmh0ZEtTSjZUVTZOTnEy?=
 =?utf-8?B?ZDU1TEJXdUptcDFEeGtwK3ljVWI4Wk1VZnFUcnNyNU9IWnBGS2NhSDBMRkVP?=
 =?utf-8?B?RnlkZkY4Q25JTHIyNk13dGRyYjBVc256YzFvVi9hSHFjdUdoTXhKWU8xZ25s?=
 =?utf-8?B?eUpTWjh2bHB5MlF3Q0ZiMm94WGp1TVRYeEh6d3UvOFBxSEticTh4RFN4MXVo?=
 =?utf-8?B?cDdwci9md0xaNlNENHhoQi90VTc2Nm1OcDg5NUFheTNIQnF4bytSbFJ6eERm?=
 =?utf-8?B?L25VaEhuOTRGRytjeG0wMmIwZkdCWXdtb1I2UTlsRmE3eDkweW9zeDhnMVk5?=
 =?utf-8?B?bDRNd3lQVkVBdFRleC9GellvN20rWStoUnphNFRoZzVIdWNoZzNnSzhEWHVR?=
 =?utf-8?B?YXdjWVlUZFNvOVhRU0J4ZTkrRmNTVHM5UU5GTko3WWg3VnltUWMxU2lZZU50?=
 =?utf-8?B?Qlh2Y1NsVXJnWG83ekJVNmlSOE93UitPM09pNlJVMCt2c3lxaE9td2lJVUJD?=
 =?utf-8?B?ZVZ1WDBVdVRsOWIwTUpqWUVyV1E0RmhMOWdHWDNtNFg1YnhYaHpYdktqanRX?=
 =?utf-8?B?Vk9oZXBpbDN1NTFJNXlIZ2J6aGVrUkxrdFk3RnVPai9IMnpHcTQvR01kb2Fk?=
 =?utf-8?B?WE9WTzQ5eHRhWHRzV1BOb3RjSEw2aDRFZmFEOFJJUEZRTGpjWmxCMkFxM2pJ?=
 =?utf-8?B?NjNXWm9zVnJyQ2FWSDBZdmo2WmJyN1lncU1vc3I1NjBIcldEVUt1UnY2a3FD?=
 =?utf-8?B?THBsUnlXVXRCN0o4QkRQTW5pZnkrMzBkc0Z0SXFrVW8rYmJBOEo3b2wrZUJU?=
 =?utf-8?B?Ly9JSXIrZjhaWVFjaGF6Zy9KUnZxZWNZaWcyRlhNVXFKUkg4ZEpyRXBqalZ0?=
 =?utf-8?B?MGxqUGVlelRJTGpuTTNZZnJRWExnYUUzdXdsSDdUb1pOM2RCZkxlNU55WDhE?=
 =?utf-8?B?b2pyVmhGYWsvemV1ZWNtSFU5blp1Rm9aZEpxTGs0SEVDMUNuZVV5L3pvVzc3?=
 =?utf-8?B?ek00RVdjcHdENy9WcHRiaTQ3ZUVDYWpOcjZaNDZDOEZVZjFOUE8vRXlwZ0Z6?=
 =?utf-8?B?ZWZ5YXZlcFdUZC9RVDFTTlBQeHNhYlpBeDZIOVFuK3pCb1V2M2NkcGJjSkZw?=
 =?utf-8?B?cUZHd050OUpYZE1oOVJWSkdKSWhHeWhHelZiNXBNeFV4N1pra1JkbUNNTUln?=
 =?utf-8?B?K0lqQVBxVE82aTRvOHNLd2lNSnp3ejhKeDVFUDVPTW96TVp2OHQzYjJlQ2pC?=
 =?utf-8?B?cXdCUGZLZ0laZUV1cTY0aUxITmhYeEt0WW52S0lNUTk3TGUya1Y1K3QwMjQ2?=
 =?utf-8?B?YTVQSjhYWGZwNGs1cGFIZE9BZ1JvbFgyeUlTOWRmRmFteGFMTEFvVm96eDBq?=
 =?utf-8?B?MURmYXhBbkFhdzR2QW95Ym02WjlaNDhzY2U4NmpxWmNSaGFkZTZUUlpnTGlK?=
 =?utf-8?B?WXpNQTh5NXh0OU5Gd2dKUUJmMk5YQlBlRzNyUmZSQ1AzeEhoQjhZR0ZKQnVB?=
 =?utf-8?B?aUt4M1lBc2ppK1J4YzhRQy85TzVOeityU0U3L3ErbzVVV1NZdDM4SkFwUlY1?=
 =?utf-8?B?d05kQklBTVcyVngwNWNRb05qRHdqSlpPUnFZSC9WczVjWFNxSHRhZWFpQ3ow?=
 =?utf-8?B?YTYvRDR0M3JIeFEvdFUvVnJ6QmdndXAydUJOMlZSZ1hHZWEwRUZyR1hvOG5K?=
 =?utf-8?B?b1VtRUFrZ1NVcVI1ZkRlUy93dUs2ZEp6UHJPckFmVXl2QWs4NzdQRW5wN21l?=
 =?utf-8?Q?GfriSl628xnQZLOqZK+2F9OxF?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8729ca-e3ca-4c13-1a62-08de1b630631
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 05:28:45.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kh2zuqNZ+28MvhTdsrblBPTvM4rg7e1cd0kgBRyti94fZFzOoXKq097DasAVZ1GjAeszj4h2/EiYYnOxQ1B0HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8585



On 11/1/2025 12:27 AM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri 31 Oct 2025 at 23:09, Chuan Liu <chuan.liu@amlogic.com> wrote:
> 
>> Hi Jerome,
>>
>> On 10/31/2025 5:04 PM, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Fri 31 Oct 2025 at 16:10, Chuan Liu via B4 Relay
>>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>
>>>> This patch series consists of four topics involving the amlogic PLL
>>>> driver:
>>>> - Fix out-of-range PLL frequency setting.
>>>> - Improve the issue of PLL lock failures.
>>>> - Add handling for PLL lock failure.
>>>> - Optimize PLL enable timing.
>>>>
>>>> For easier review and management, these are submitted as a single
>>>> patch series.
>>>>
>>>> The PLL timing optimization changes were merged into our internal
>>>> repository quite some time ago and have been verified on a large
>>>> number of SoCs:
>>>> - Already supported upstream: G12A, G12B, SM1, S4, A1, C3.
>>>> - Planned for upstream support: T7, A5, A4, S7, S7D, S6, etc.
>>>>
>>>> Based on the upstream code base, I have performed functional testing
>>>> on G12A, A1, A5, A4, T7, S7, S7D, and S6, all of which passed.
>>>>
>>>> Additionally, stress testing using scripts was conducted on A5 and
>>>> A1, with over 40,000 and 50,000 iterations respectively, and no
>>>> abnormalities were observed. Below is a portion of the stress test
>>>> log (CLOCK_ALLOW_WRITE_DEBUGFS has been manually enabled):
>>> Okay, this little game has been going on long enough.
>>> You've posted v2 24h hours ago
>>> You've got feedback within hours
>>> There was still a 1 question pending
>>> The rest of community had no chance to review.
>>>
>>
>> There might be a serious misunderstanding here.
>>
>> In recent years, we've mainly been maintaining our code in our
>> internal repository, which has led to some differences between our
>> internal codebase and the upstream version. The patches that account
>> for these differences are already queued for submission, and several
>> SoCs are also waiting in line to be submitted. As a result, quite a
>> few patches have piled up, waiting to go upstream.
>>
>> Previously, I had been waiting for your clock driver restructuring
>> patches to be ready (which have recently been merged), so for almost
>> a year, we haven't made much progress on clock driver–related
>> upstreaming.
> 
> Ohoh now you are just teasing me !

I must clarify that there seems to have been a misunderstanding. We
are increasingly focusing on the development of upstream ecosystem
and actively working to make it more comprehensive.

> 
> That work was made necessary because of all the copy/paste Amlogic was
> submitting. Despite many requests, this was never addressed so I had
> to step in.

I fully understand your perspective, especially given the challenging
process of upstreaming our clock driver due to historical reasons. I
have always maintained a friendly attitude and kept communication
open with you. My intention here is solely to provide context and
avoid any further misunderstandings.

First, I acknowledge your approach: these optimizations are
beneficial.

Over the years, we have also recognized these issues and have
implemented a series of improvements in our internal repository, such
as:
   - Reducing driver code volume and improving reusability,
   - Standardizing naming conventions (e.g., clock names, clock IDs)
   - Optimizing image size
   - Enhancing driver execution efficiency
   - Ensuring compatibility between ARM and ARM64 architectures

To address the challenges encountered, we have also contributed to
optimizing SoC hardware design. Improvements have already been
observed in newer SoCs, and we plan to gradually submit the related
drivers to the community in the future.

> 
> If you want things to go faster, then *really* pay attention to the review
> you are getting, do not ask question to ignore the answers and stop
> making people repeat themselves over and over.
> 

Thank you and the other reviewers for taking the time to review my
patch.

There may have been instances where I misunderstood your comments,
but I never intentionally ignored your feedback. Moving forward, I
will actively submit our company's drivers to the upstream, and I
certainly hope not to be perceived as uncooperative from the start.



