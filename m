Return-Path: <linux-kernel+bounces-736297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA812B09B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96148188D871
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A71EF363;
	Fri, 18 Jul 2025 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="IOfJ/Uhh"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023122.outbound.protection.outlook.com [52.101.127.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7AD17578
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819270; cv=fail; b=QizGzVwNilmUftBO9glp2o2mMq6FO8UQ7fZSJb6GMPu9li/hbSZm6anvtPRt1UeRs3yjcmV6P8sblnHpttOhRp9eFeoFC3WIcuonuLoRZ5QppZKu1AB4xl13VWap2vUoeX40oy+Qvp2YwJ1S3aBrR4Q2KT9+RgJ6DtP8ZrCR85Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819270; c=relaxed/simple;
	bh=0WglxWZprNrVnyPh/7rtazDoKd/WOt28Dt6jAcs1odo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lzsl3AGTe+TQmOvnxbLDeofEDab+9THH6BfT0bWD2+mDeb04mGP4IwKbjR3Vjh7KDY3HfecOa9+MGB4CpWD82CZN4nPcaBrp3vJrMm+QBKkCADfmCT112yN65L8GkApv6tyq13uwLI3cMoCVFwc6GvrD710lGHgJkZkC3QpcBdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=IOfJ/Uhh; arc=fail smtp.client-ip=52.101.127.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEQPPi6o0LODTOU2zLkwblacIwl3YlXo1Nun2SSAMRBR5j4a1sXKXJOGvFdZ7mdOyxi2znzYIRvprAsrwSuMgIefXTuCCAYI3shcFQiBzcPNn8ZAF/yceqqZTQ/1DqI61BFwdAHiH4W1RVQzjNmbG5vwH0E2p2aj03K5pKR7zHtjq0pDGLs/679tfUQXJeFwe9/GD1KdOOTvW98iWCyvpFBNY2onuX9FHR8MMhGN2TfuVTlnf4RZVqGpUJGYu5elqjF7xeexsr2f85uqzG4VEvLEgoGJyMumFRq3y8xhQF3sAi5UPhdIsM/uVBqoLzRhotHmbYFou6NKY+W0lvEj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KR2P5TDHyImTGXQs3TWYCrseWvN8K+YVadgl6Ddrms=;
 b=c0dVaM89azyaN4mS/O7opcrTaiBu25kuP8QK6qxkbrJfNyKyfbAAwR6imSqyG4jNaRfK0zR8rhTy4rcqDIYTnZ7YYj+ztqaV9uQ/5MfVbixMHK74p5T9UvsoxrW+hF+btOZMIWtYKqachms6LYGUWAiRiWoqfbzqfrOOgRedujd+8kYsVnNUH50hKvaI/fx8BXNkZ0gGpSFrqN3h0XoZt/9CB1n/9zZLt/JkPqZG/3afkW0ldMTw5h4yl5O5C7zF+a3IeKocjeqD4GnE8CfOyYU17Y3ViMc1PkOuZtS6uP43Br8BCg6CuX3dTj4OlJQYCsW2QJZOI5dRaH94LEeK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KR2P5TDHyImTGXQs3TWYCrseWvN8K+YVadgl6Ddrms=;
 b=IOfJ/UhhzaW6hevo0HT8xM3aW/zrHxQx49L4TcYdzINCjnq1umAQwmjJ3xuU8YpkG3VqL/OBr80ubLYO3z5apemrui4h9sdWuqJy80ozT1BJLGH/P3gXwpLzAYsGiL9ukxAARRMgySPxBPDorzAbuHAA18VMtPHhP/jLwKwQ8O1ROauM5aYjE/QIAPaoZqVZ0T/z+STFz1h2PoScJQYbEZd3EwTjnJxbO2oyhjkzkxEJJJMO9CwYWnuuF5xLhGXp/EqdmrNtQMdylu+uY84yBbQp3VKuta96NOUGeZ8L9ftAvjyvVmZ3Wm1ymTdF8sD9cTrMfSTj63NJQf2/oV3ADg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB7181.apcprd03.prod.outlook.com (2603:1096:400:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 06:14:24 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 06:14:24 +0000
Message-ID: <7fbd3743-cfda-4877-888d-bdeb28d4972f@amlogic.com>
Date: Fri, 18 Jul 2025 14:13:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: amlogic: clk-measure: Optimize measurement accuracy
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250717-optimize_clk-measure_accuracy-v1-1-3b82d7ccd743@amlogic.com>
 <CAFBinCDyjf7MOE6f_AGEEwqV8z68qRv6JAUxn7zt5ZZqwFLkPg@mail.gmail.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <CAFBinCDyjf7MOE6f_AGEEwqV8z68qRv6JAUxn7zt5ZZqwFLkPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ff7ad7-5960-420e-6f50-08ddc5c2578f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UElzQVRrdm1BdnhFQXpxM3VSZ1lLaklaUWJCWExwenlja2Y5cG9iQjdaUUsw?=
 =?utf-8?B?MXFWL1ZKMitTektzcFExYXJvTlEzOXAyQ3FGTkJlUks0OGNDU3ErN1MzNW15?=
 =?utf-8?B?UU1YZXhGZjBnODFlMzhaU0p0NkpadUFzSkJ0dW1ZNmNVQjFpcFgyYnFTaW9X?=
 =?utf-8?B?eklMWkRXaXB5MnBZZFVVZ3dJbEZLZHIrSHhON21JY3NZVmJRWU5zVWFaRnpD?=
 =?utf-8?B?ditvemxCakxSTFZNWTVmaTMrdi9Zb2JCZDZObS9jQzVFWXNXY04vYmJxVlJZ?=
 =?utf-8?B?TGIvWmZTdWR1SXo0bHdRYjRFWjNQREVXYWg0Y3RnTjVrWVJSSmcwTzJjNVlq?=
 =?utf-8?B?ZHVjakVWRjdpa0J0TklPSVpXN255cVFsWFpkMDhQNzU2TExxYkNnRjMxSkNK?=
 =?utf-8?B?OUVCRHRZLzRzeUZkVzJndFgrdHA0MGNiOWIwTW1hei9Ca3FMRHlHVWFQaXRh?=
 =?utf-8?B?c3k5aXllV1lyRXJRNVVNanQ1UFhpMTd6dlM5Qy9hZG82ck4wODNqTlVoTzNB?=
 =?utf-8?B?eTk2dG5GN2ZpS00rK2c3V0dPdWF0eVRSMkptajFkZnhRMmhmRHNCQmxYMG5x?=
 =?utf-8?B?R0MxZU1CSmxoeVpBMEhaaVlNRmxmeTNlTGN3UUtuWExTUzZzWG9NMGpnUkl5?=
 =?utf-8?B?Y0liSDVqYStIOVM0RzVFdjNMNUF0RFNFTFhjSVg0aEhlVzhzR0hCWFdBT0FX?=
 =?utf-8?B?cVpHcEZVMHpBb0hvTGI0VFNPcm1yZ2lGSXVNbVF2cXdZQUIrSEF5aGR0MDlZ?=
 =?utf-8?B?cWdTYWZwQld1QXFpemZDTUhrek5Hd2VvVkxNOFhEUm15TnBwRmk4VU0xaE1W?=
 =?utf-8?B?VzJvQ1RzVmtCR1pDQ3F1bjRZNWtNMnFnNkVWUkVIcSt0K3F6VkxwSThHZFNq?=
 =?utf-8?B?eXpMTmUySkd2MHg0bDFXV2g1ajZqQktpRGtWNHFkMWY4SW5DZXFReXlTOXVt?=
 =?utf-8?B?QVB2cjNmQ21HVFlCUGFybEUxbWRibStqNm5GUjU5MFFMWGJkNDhFSUNBSWRk?=
 =?utf-8?B?NEFpSVcwSkw4Q2dXRTZkVmE4YUVqNEFLekVieXNINWFLNnRsekNOOW9PK0d1?=
 =?utf-8?B?K3d4VW1LU0tGV2svSEFkdUF5MlBhZ05pRnhSNzZvMlJqSW42RU82UDk0NVlD?=
 =?utf-8?B?V0JKTUJKY0xRb0lKUzB4eTB5MXcyMG1OcnZmZGpRWUpueTRDM0ZPNGhHZWFN?=
 =?utf-8?B?cVZLcnlCbmlnZlcyR3BXWCt3TXg1NDA4UERKSjFlbTFLVDJ2K1ZmU1FwOUJH?=
 =?utf-8?B?Z0s2VEYwSVJqQjVFV2k3cGZtZlNlWkljbi9jVXR0emY2MFlsNlRMOWN1VVkz?=
 =?utf-8?B?SlpwcHVKMytLd3h6UTl1RU95a25BZTdoMlhSenVWcU9BM3p0b3NvOHFTZFBM?=
 =?utf-8?B?bU96SW52T1JZZUlKVExxVitVMG9LVThOWjFBZXdqRUZ6czZKMUpZSUNUbFdw?=
 =?utf-8?B?WVRMRWUzNjFQblJleDVZa0hkYzA1ZUpSOU84RkNmaDBGQnVIRUUvOS80QVda?=
 =?utf-8?B?cUEzTW9CVkZVMmpIaWdqdWpaUk90dlFEMS9BdlhvTHZXUUVxQTNncWRRcXov?=
 =?utf-8?B?SzlWdmRwdTdJU0s0Tnk5VmE0dS8xM2QwU2hxTVZCelhNUy9tazJIZTV5RGVi?=
 =?utf-8?B?cHd3MnhPWnlUVW9xZDI4TTZpRkxzcEloMzlmRU5EeUphWDVJNEtwMGt1WmV0?=
 =?utf-8?B?ZjZUdEFnNWM0SHh6TGFLaXB0WW1QMlBxUnU0ODl1TVNodCsxUS9ER2paTVJ0?=
 =?utf-8?B?NWhJNEZPMmk2Z1hBNmpFMVdycWYzZXp0RWNkUDlPS0pUQkhENlZ6dmErdnlp?=
 =?utf-8?B?aW9RcnUxSTI4Y2Mvclo1NG00UVJlcFB2QjFiWXF4TGFKdEo1eGdlN0NEWk0z?=
 =?utf-8?B?ZlNqS3FVSjMxdkNMeWo1RVd5bXIySGgrUkh1WENwUXRSUXlBMkxYZE03SmVD?=
 =?utf-8?Q?hxO0x+o5lh4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGx2ZXhoV1dMejdiZ1Y3eFJ6TmNIem42S0c2UCthOGtFRmFZdDBKZXpMZ2pv?=
 =?utf-8?B?cTlNOEswWVQ2Q2laUytWazlrU3dQSWhDNExYMXdWSnllQ3Z6bkhBM3FERW5z?=
 =?utf-8?B?NXhXaFBFcHBROWNCcjFCVGNIby9XUVNlWlM1S0x5TkV2MGE4bXJXUVcxbzIy?=
 =?utf-8?B?MFlwd2hEWmZsZFRTV3hOWGR3Tmx6K1g0eFhwTHZsK2Z0T2N1amtzY2tKWThj?=
 =?utf-8?B?K1B0Z2hlNUxMWHo0SS93WUJndmVBMVpRcjNGRHdmSUpmSEdrTjRFV0lYM2JG?=
 =?utf-8?B?SitWQlV2S1BBOXZRRXN0TC8zOUhKcURzNGFqd0V6RjBxTkZZVDl1UUdnVmVa?=
 =?utf-8?B?dlVXMHRJY1VkR2pjangrMVc4MUhCRWFoZldVOW9sWU4yM21pZVYzVytXZTJp?=
 =?utf-8?B?dVpxK28xNTlRbDVvMXJIV3dTVVRFNlZhS3p5U3lyNmpyVUJVck5nd3BDRitQ?=
 =?utf-8?B?VEdSV0ZLdDYrVzVGMDI3aDlxNmwvc2RyYmg0V0pXa0hrZ3BIeTV6SytrUjJk?=
 =?utf-8?B?cmZKejMwWDhFRXhyU3FDRXlyaDRmMXlzSDdBZ1B6dWJyZmptNnhqUXhmNDdN?=
 =?utf-8?B?NnVWVDYwTzRoNEcrSHd5Uy84WmZVMHF0R1VacEhIdTRQaVgrWURsaThEZ3Rw?=
 =?utf-8?B?cFJES2pFNmlPT2lTNE5BazB1bkRHQ0dGd3ZuUGQ2TmhweXk5STdicUQ5eGVy?=
 =?utf-8?B?T20zUU9ya2tiMmRUTVVRY3MvNUJvVGgvUHhjSWd2blpCSDZHQkN6K0NSaUpQ?=
 =?utf-8?B?SnZkeEhRakQ2OUcvelE3ZjIyRFdNVG1qRGlia3F0QTRXN1ZZOUt1amdFeWFh?=
 =?utf-8?B?eTBNaDIyYncyTXFadEJ0R0ZSaC95aStBWWhCaWl3bGpVS2RzaWtURS9uKy9S?=
 =?utf-8?B?ZWdQV2ZybHVsYXhGeW1hVFduQjd4TlE5ZVY2WmtYZnBSTWhkRVBYK3JLL1hM?=
 =?utf-8?B?TnFDK3BuVTZiM2loemNyMlhSaDBoUksvcVNMRlk0bEFYSzY4SlltOXMwcGVM?=
 =?utf-8?B?SythNTZDd09LaW8vZnVQNmE5a0hZMU9mSGswNDJWd0wzRmZESkJPd2phbkJz?=
 =?utf-8?B?L0ZFVHRDWEI5akpLUFZBVEFsRVVMU3lJTXJFYjlmNFRXZ1kwYWJxdVhGU2Ri?=
 =?utf-8?B?OHpORlhIek0wbXB0cHhLSlhnMFRwZzJCLzdoVHI2eVdiYy96V0JNUVZVUjF6?=
 =?utf-8?B?QmR5UVp5ZU5OckJBSlBQNHZvcSs5ZEJXZjZBSTE2aHNudjFXaXhxa1g2aitN?=
 =?utf-8?B?dlFRUVJXWVNWYm5EbkRnRTV0bSs0Vi9YSHQvQThHbHpISmxiL0wyRG5MZXZR?=
 =?utf-8?B?MndnbHl5alBtUEpuL2piUGRVYkp4Z25sTDJySU5VeTZ4a1g5dEZMQTRiSUxM?=
 =?utf-8?B?THZXK3VHK0l2bVZnMnRZSVMwT3VzVStvYXZOVmkyOXZ4WWdsSkdkNm1DZ2tz?=
 =?utf-8?B?R2pIM1Y1a3R6VjYwcm1mcUdYQmsyWW5mdmNOS0I4NnlOTlp2MjI5MGlNdlAw?=
 =?utf-8?B?VGMyYkh0OEw3dStRdzVzK3Zxb05JakVoT1ByYjhkMy9HOGY1SHhVTzRqRnZ6?=
 =?utf-8?B?NHV2Q2FvL0JxM2FqZXNLWmJtYXpRUVA4OXVSRm9JTG9LS1M2a1BxV2R2VUQ1?=
 =?utf-8?B?T0crdjB5S09qUnlEQnA0Mk5ITVhtc0h1eHFVN3lzSnZ0ZkdNVHIwVEZacDY4?=
 =?utf-8?B?VlNBQkpaK3pzY0ZyMzRYcjlNUGU3bk1hSCt2c202TTR4Rnk0V1VoZi8rNlFX?=
 =?utf-8?B?QVJwTnRZakwrbGozMVEyOXZqZXF2OFkzUHdkQ05HQi9BYUxYQng1NnZWdWJ3?=
 =?utf-8?B?YVVlY0V2TUFzK1lTS1BXVXVlVXVkbTBEVE9EVXdTUGFjYU5OY3VYWVcwNjZK?=
 =?utf-8?B?VXRhSEJEL0FaZ3VFak8zcDJNRmJsbmQ1R3k2NXh0clRqMzBTcWxNVUxBWVkv?=
 =?utf-8?B?NDU2L2NnZ1k5c3pLcWlLSnc2cEFLUjBkaEJiMmtjemIyVXNOV0FNY1ZyK01T?=
 =?utf-8?B?Njg5VzJyM2xEU0NnOG9Pb0VPUXRQSWN1ZFJQWmQ2VXNYd1NNVktoZjlnQ1NB?=
 =?utf-8?B?K1RkR2QwbU93cjZNbmdNQUxQNUZkMXJqUkZUWmE5aUtyaTBad2tTazhJb3d2?=
 =?utf-8?Q?s3IViXJdLJn6GyWuRSWzlZ++l?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ff7ad7-5960-420e-6f50-08ddc5c2578f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 06:14:24.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+DHDkYbTNX6VKJlFO9Cmo5VFStprP+VVupqClqUu7LtF17KU6A3f7lJ6roi2gKTErFFVa4UWBkIS7Zp9kyJig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7181

hi Marti:


On 7/17/2025 11:43 PM, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
>
> Hello,
>
> thank you for this patch!
>
> On Thu, Jul 17, 2025 at 5:08 AM Chuan Liu via B4 Relay
> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> The cycle count register has a 20-bit effective width, but the driver
>> only utilizes 16 bits. This reduces the sampling window when measuring
>> high-frequency clocks, resulting in (slightly) degraded measurement
>> accuracy.
> I checked the Meson8 downstream code [0] and it uses 0x000FFFFF to
> mask the register value -> this means that old SoCs also have a 20-bit
> wide width.
>
> [...]
>> Here are the test comparisons based on C3:
> [...]
>> Here are the test comparisons based on C3:
> I have tested this patch with Meson8b based Odroid-C1:
> pre-optimization:
> # time cat /sys/kernel/debug/meson-clk-msr/measure_summary | grep -v "  0  "
>    clock                     rate    precision
> ---------------------------------------------
>   clk81                 159372396    +/-5208Hz
>   a9_clk_div16           24000000    +/-3125Hz
>   rtc_osc_clk_out           31250    +/-3125Hz
>   hdmi_ch0_tmds         146399038    +/-4807Hz
>   sar_adc                 1140625    +/-3125Hz
>   sdhc_rx                94443750    +/-3125Hz
>   sdhc_sd                94443750    +/-3125Hz
>   pwm_d                 849921875    +/-31250Hz
>   pwm_c                 849921875    +/-31250Hz
>
> real    0m0.102s
> user    0m0.005s
> sys     0m0.069s
>
>
> post-optimization:
> # time cat /sys/kernel/debug/meson-clk-msr/measure_summary | grep -v "  0  "
>    clock                     rate    precision
> ---------------------------------------------
>   clk81                 159373438    +/-1562Hz
>   a9_clk_div16           12000000    +/-1562Hz
>   rtc_osc_clk_out           32813    +/-1562Hz
>   hdmi_ch0_tmds         146398438    +/-1562Hz
>   sar_adc                 1143750    +/-1562Hz
>   sdhc_rx                94443750    +/-1562Hz
>   sdhc_sd                94443750    +/-1562Hz
>   pwm_d                 849992188    +/-1562Hz
>   pwm_c                 849992188    +/-1562Hz
>
> real    0m0.173s
> user    0m0.008s
> sys     0m0.109s
>
> So there's also an improvement in accuracy. The only downside I'm
> seeing is that it takes 75% extra time for the measurement. For me
> this is irrelevant since we use this for debugging.
>
> [...]
>> +       /*
>> +        * HACK: The input clock signal path from gate (Controlled by MSR_RUN)
>> +        * to internal sampling circuit in clk-measure has a propagation delay
>> +        * requirement: 24 clock cycles must elapse after mux selection before
>> +        * sampling.
>> +        *
>> +        * For a 30kHz measurement clock, this translates to an 800μs delay:
>> +        * 800us = 24 / 30000Hz.
>> +        */
>> +       fsleep(800);
> What is needed to make this not a HACK anymore? Is there a register
> that we can poll for the number of clock cycles that have passed?


The required delay duration is frequency-dependent on the measurement
clock source. The current 800μs delay is calculated based on a
minimum input clock frequency of 30kHz. At higher input frequencies,
this delay could be proportionally reduced. Applying a uniform 800μs
delay therefore appears overly conservative for general use cases.


The IP currently lacks a status register to detect whether the input
clock signal has successfully propagated to the internal measurement
circuitry.


The design of this IP has been maintained for many years. From a
hardware design perspective, there is room for optimization in this
signal propagation delay. Future IP updates may not require such a
long delay.


>
> Best regards,
> Martin

