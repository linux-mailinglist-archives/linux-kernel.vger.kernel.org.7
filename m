Return-Path: <linux-kernel+bounces-740094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E5CB0CFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645E9170A91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AC1DAC92;
	Tue, 22 Jul 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="vrCCC1xY"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022134.outbound.protection.outlook.com [40.107.75.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB44A28
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753151613; cv=fail; b=l1z3y/KjfjRCT7ZSE/MvQ71M8ucJJr+rI4ZsRz0j7Nue6LQfn6sKk04lZmhUdf3P5vouzbujpzgzwDNPR8U8Mmqb5QuOi1X3PeJyGjuNHCcAWFfxHIaSlVvzybZ1nCPPnysXsYHS5N2FXjXNNubdAUKxu8qRQ9fuT9fCH+kTYNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753151613; c=relaxed/simple;
	bh=psapgJda1u6Vx7IBckDPneId2BSQo5UHcU/9rULgTmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PnqaysSz+8QaywHyOeSSQqs4ntfdYECcxk5CnXCI8NV9T4YDakPJO5hB/cA1Jfh2vEa7m6jcKgeaoJuXUb4B16vdBtik5DnBPrbSriitaKp8ipEzEmSuKCEwsu141uLw97SYRNgxS85NA8uf3aegwMnYSVLWfSjxq+vKkVdreIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=vrCCC1xY; arc=fail smtp.client-ip=40.107.75.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV5bzHSWC0wur3XJPN1jUr2SocqfGsuSjudmHsLkw3VfI+tfoCtCZ66Ln94bgnql0TsrJ+FeX+H6+j1PwO6o2Eyikb6KSTgOmiYDfZ0l0GGzcHqmPYVDWJZkGJaS+EQv1PMEOnapUOBW6eAA6eE9VgONN694+JF4xn/0A4hOIWZe68kQNc0wrXBcHi14vg4oKGqnQRJKQmVpqwirEQDiQpTjFNe7dhgS0OSBMh4VoCoO0plDD4C6Q7ryyTSllbweQczHpMRLddhsmEnxINXT7BrVlBggNmkP+yuDgKhGPryCh6c3AwntLW6hjap6C5ozDf7yrZIeEmG2RuIcEBhQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpe10epkVvv+nNylR9uA9P99cRqhmcYFnLttcxXz1KU=;
 b=B/Sj8iMnBvbYlKvQW7VSFZurJZ6Bj6xS2kdTbUdK+CvBvhiXixCZ8jMDOhGeh5uIj8jrFSNtQe3TwOi3FQIttS2p22Ro+bF3rN64tHqrsVPlWlR+z+uqzO8MxXVtH1zX9RaHqBE8Jlz5BXPYiwQlxAMXvGAHgJhjAOleE+Ze2SOTW5JwkZkIknstQf/QbtjHLxAyaV4xY53yoAF8Tx6ZJObfmy5OkFXFN6HBx/R4OcPM3adj90qc2yZBW7wf451TKzmfqlqe48278ToLIcvbRPXWtMip2vgASGTypsZ7TkAIKRs9Elfio6PRhLeRiGcKyQPAXM3ZmFA5At6z9C29fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpe10epkVvv+nNylR9uA9P99cRqhmcYFnLttcxXz1KU=;
 b=vrCCC1xYjugh7TbBElZy+Di9HK0RV841XTil/mAbEWPonp1+WsBIY3PDW646iuu6Zel0817Y1uuO72PcaffC49zYLEsp5lN2iztJUtGdE56fZ7O9KBiy7djLMUCMRe7g3oLjgjqMf+qwa86URuRRypCFjQecCJKX37tiVxBo+aMuZdXAyej3cwUgHuHlgag7mT1XF4yM/KOfzLdYHur+PyosNfKJX1IY2Yus7881CJkC02gDzk8EoZAObcha+snHmbEUKO8B3CMNOy0k5NgDFIDGmEUfAayx5diEJ6WMqd2gYq6YPOLCzPGltzV5Bd2pxfoK50cTKupmSNONK44rzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by KUZPR03MB9444.apcprd03.prod.outlook.com (2603:1096:d10:48::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 02:33:26 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 02:33:25 +0000
Message-ID: <9cea1e05-e24a-47c0-b974-d9e58e2e3cf8@amlogic.com>
Date: Tue, 22 Jul 2025 10:32:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: amlogic: clk-measure: Optimize measurement accuracy
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250717-optimize_clk-measure_accuracy-v1-1-3b82d7ccd743@amlogic.com>
 <CAFBinCDyjf7MOE6f_AGEEwqV8z68qRv6JAUxn7zt5ZZqwFLkPg@mail.gmail.com>
 <7fbd3743-cfda-4877-888d-bdeb28d4972f@amlogic.com>
 <CAFBinCBdCiNKWoXrL0tw1+_0BL_9XyYfuqQrRNePyzmUh=PX3Q@mail.gmail.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <CAFBinCBdCiNKWoXrL0tw1+_0BL_9XyYfuqQrRNePyzmUh=PX3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|KUZPR03MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d34e1ac-f1bf-47eb-423a-08ddc8c82230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkRXTTVCeCsrVnF2WnRwbXVzeDlNNFBBYWhaaUJLMmxVQmx3NHM0OWZVbUQx?=
 =?utf-8?B?ajFTSWw5bWxnaUVLVXF6U0MzMmJCeDVQN2RERkVtaWRBZnNrYUpvaG44NUQ2?=
 =?utf-8?B?THl4STlsRHBTUXg1RmczUnd5YjRvZ01lcWlLSXc5YnRhZlhQNjA0K0R3ck9j?=
 =?utf-8?B?bVlOOGtNaEZJS0tVTW5mRWVWRFB3d2h1Z29uOTNDRWtib3pyU1BpQ3pUWDBT?=
 =?utf-8?B?TFA4bDdEUUd3Y05jazlYTlE2NjhvMlNGL2RteUthbjB1bHB0Q0hCVnQvaGkw?=
 =?utf-8?B?eGxUV0t6WHVaUUVsa09QVmxBN1ljc25qdngrZ0F6S3k0R0Y3alI2bjdjakds?=
 =?utf-8?B?bk8xVitGNGNkOEU5MWY1TnlQVmpmb0VSMEZRSlVETzRhSVV0eEUyS1MrUDM5?=
 =?utf-8?B?VklSOE5DMHg1b0UwVmc5UjE0VFgxNWxUYXdQT0ZBLzBZTCtEZkdpdGhXSE45?=
 =?utf-8?B?eUpjd2w1SXhSdFRHWG92YVB6VG94b0FEa296RlYzS3FZTzJGWEVtdXVUKzgz?=
 =?utf-8?B?cHhhZ2t3cVMraDdqSlBkSnduallJbUprNlJkOEJqY2E3UWFOc1RGRzdlcEM1?=
 =?utf-8?B?SS9hcWhBYUptM0VjdFRITmkrUjZ1dGZDNEhjd0lRQ3JqdTlud0pXSWQ1Vy80?=
 =?utf-8?B?dnp4SWpNQWRaY1pVVGYrMHNFVmdqYTZKeUdJcVgvWk5vVjJaL3c4V1NvdWlt?=
 =?utf-8?B?cTFBZkcwTml1NTl1NkxFS0RVUFJQdXJ6ekZ6M2k4MWh0b0xLMDc1OUZTWThQ?=
 =?utf-8?B?Y25neVp1MW9VelkzN2pkV2xpeGYwZzhoMmdzQ0dOQTlpaE9nY3dyRGJiZy9V?=
 =?utf-8?B?eitiWGtsZTlpTVJESTNzUWt4MExMbE5wY2xvcHVFM1NRNUszM2ttRnZhZ0J4?=
 =?utf-8?B?cVFwSi9MWCtUdVp0Wlg4VUZjU0czTFBnaVRRNlU0Y3lPYWxlM0Z1U1NxcWxi?=
 =?utf-8?B?ZU5oWVhQMWlZMjZHRXJwWG9NODVkUndFYzJkRHFnc2hOR2krR0QvWlp3L21G?=
 =?utf-8?B?TjBxWUErQU9uY2d2K0w5cjU2NnRTZElYVWtIRCtDRFFVVEFpdzJWSzdYVFJZ?=
 =?utf-8?B?Y2EvYmJDV01rVVRwQWlLRnBXOHBDc3F5SFBLUEcyRmxxaWNXSWhhL08xc2JB?=
 =?utf-8?B?emhvZGFHS2xBUm80V3FQZ1RueDdMNlFybGlOUzlnbmdSWEZ2WUMrV2ltaDNQ?=
 =?utf-8?B?S3JURDlCWU9oMVlpcWZwbWJJMHpYQ2xoVWUxTHBicUl6N09PQlhkcFNpa2Fr?=
 =?utf-8?B?SjRRTzcxR1FRSHpja09Ya2t2L2o0eFVKMkpvM1BCNlJ4REJUMFR3OGp0K1BB?=
 =?utf-8?B?T1AxSUVNUmVjdlJ0OU5iMDFqK0pGQkdhTHY3Z0lEeFZzbi9wS0JvWHY4Z3Qy?=
 =?utf-8?B?cHBiYkNuWDlEK2FVQkJJSHFGZUhKOXEyS0pnakFnMU9qVjdaeE9PZm5yRFRl?=
 =?utf-8?B?S01sNzhxcDZtYTlmMEZiY0NsS2hTL0h4dGdKK2lJTnJ4Sk9JZ24vdTNwY3kv?=
 =?utf-8?B?QWlVZGdBSzF3alZTSFZQVWlOY3Y1OHRwczNYYTBSdEZ1TGk0MTFySERKMDRq?=
 =?utf-8?B?SDByeVYxZ3cwaGpRaGNiMFJPd1Q0TGljWXJGZUJ2aEdhZnYrcmxKNUpXQTh3?=
 =?utf-8?B?bjZiZHBpNW1RekhYY0VPa00wODE5eG1JdmlYYUREQ1VoaXNJczdOWEVOZEFr?=
 =?utf-8?B?bkQzcW81aTFVS092UnlCUGZiZXczQVNMT3RwcVVVenFMUXBJUkZLZk1UVDZQ?=
 =?utf-8?B?bVZhTWtuRVRZem5SUlByMTdlbDFZWVhLcHZHZEI1R3VtZGdCZDAvUjdlOUdX?=
 =?utf-8?B?OGw5TkpTcnoxNHltYnBoREl6UGZqNUs3OXptY1g0eThReWdOeEdNTWd0dENu?=
 =?utf-8?B?cjZtNXVjR0tzWVZsWjBVMW4rSEsycWg3ZklUUFNPakJXK3AwN2dmbkxWWGk2?=
 =?utf-8?Q?Z4HZgU4W2F8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U01qbFBxVFVTSGdsK1VHMnF3WmJIcUxBV2IrQ0s4S25rbXhGN0xQbHJjZzAy?=
 =?utf-8?B?Q0k3amRmeHhlRXJPYUlVNzg5blJic1U4ejVUZWxxdkZmblVXS0hWSnJ6NzFM?=
 =?utf-8?B?U2FGbnJCSStTUktLQk91QjhOTzlzdkRDb3p4YU0xcnZDd2RpNDJ1WGVuQTBu?=
 =?utf-8?B?T1p6MnozUWc2MUpkVlN0OFE1NDdwTTMzWlZ3a0ZnN2JRY0J1TnFHYXlXNHdU?=
 =?utf-8?B?NU5TM2lSYU5zYW9ITTJVNUQ3Nkhsa3YzQWJnV255M0JLQmx3VktVS0FrMkZG?=
 =?utf-8?B?alVSVUMxVThPRVJ5TUF3N1JiNHhLK2VOVnRXbWFIaWtXcWs5Zmw2N1dNdFVX?=
 =?utf-8?B?UHNGaXY3Wi9VeWhKUUhGaDJCRE5nT09hbEY3dEVDMVdrOWxzVVJPeFIzT3NU?=
 =?utf-8?B?S2VUWVFJSEk5akd3RWd6ZTVreDVpSTNVTFlteDMxRmRoOGduT3UxR0U1U1JV?=
 =?utf-8?B?Q1hGdFpzSE5acWpSSjByOWZLUm5XWCtEZFd6SVRpWUh2VStwMHVmOXpQb3JE?=
 =?utf-8?B?SlZZLzA2S1NrbHVlRHJXNDgxdDJ2QUk0VXRLOG9iYVlvUW43dmFVdjJYcDFn?=
 =?utf-8?B?Y1FzdzY0RGcvejRNLzNVd2h4Z00yVjFQSlN1MjUvR2R4Y3ZsUHdqT0JBK2dZ?=
 =?utf-8?B?UW1rMFBkVjgwVzFHNmVYRWRuRDYwMnkxbU5WREtTazAwWE1LSXNzbXZZMy9p?=
 =?utf-8?B?TnozbGtRZFdyL0ROazlEV216akVnUlVYTTU0Ymt1dVpVN1p5T0VrQUtyK2Zj?=
 =?utf-8?B?bDlueVplWVlkZjBKem1BaE50SHBnNjEvK3J4cDNqbWhPbzdtTjFLcU5ldVE0?=
 =?utf-8?B?c0FFbmc4R245NGtSUUVMRTl6MUVjdyt0ZnhxNVZKanZYM1huVk1JVnd4aE9V?=
 =?utf-8?B?ZW9tUkVjZ3kwRmZyeGpka1pJSERhSDB2cHliSzhjOUoxZjl1dFNJOGZtdmpC?=
 =?utf-8?B?SlZTNmF6dWFIL1orajhyNG9jRFFEMUhGTU9DVmplVjJGbXdkVXQ0aUI1MEtB?=
 =?utf-8?B?YkdrdWp3ZTBvTTZyTVBkMXdCUGRycFkwdTY3bW1sblRKTDhuRFRCMnYwUDRm?=
 =?utf-8?B?dU42dGsvb3RsbVRuSGFhdi9yWmN6SWdJM2Z1YzlMUEU3dC9JdG9za3NVZDBu?=
 =?utf-8?B?RkMyaVdNMHptb2EwbU1NSktvR25YdFlQalZWcExsSWxYOWdNUTBxRldyenVu?=
 =?utf-8?B?RnhCcGJIZ21tZ3pPTDJ5ZUliVU9rSHZheTVMcTFiZE9ESWVXd2NLMjNPakE1?=
 =?utf-8?B?Z3p2YUJveENUYUlPZWpBOU42QnIxREM3cVdWQ2dpSGEwNm44eHltNWI2OEVR?=
 =?utf-8?B?VTdqNzMxSkRiZDdLWHY1VE1Md2g3Y0dxWnR3di85WjExeEQyVDVHTUlUditX?=
 =?utf-8?B?ZkpROUxScDF3d0lydWplbUY5a1lUSEtwL0h3d08zcnM2bjdvUm9DNWEvWVA5?=
 =?utf-8?B?MnZtVzdYamtYZ3NSbWN5Zm5QQTd5aWQxQnkzTmhTL3pjYk5RVllHdFFuV3hu?=
 =?utf-8?B?UE1MSTJYU3dnZTYwMWVuVCtjSUF0ZW56TW1UbzJSeFZuYjVtbm1XVUhlQnp1?=
 =?utf-8?B?dkxYTXI3WUxLK25JZ0VDOWtrdXYzVGd3aXdPWGJ3TTVPdWJGTHJFa2RsVFlh?=
 =?utf-8?B?ZG5kYkZrMEdNeDJjUlNmM3E3bTNmZjNHRWRWQ2hKVXR6SjBwSUdMSDFlUDRI?=
 =?utf-8?B?Q3dYd0tJekd3QndPbHR4dU9ON2Z4OWJBblR6RmJIdXlaSWVuTVltRFRtRFk3?=
 =?utf-8?B?NkcrMXl4REdDdUFoQ2lmZVR6ZVkyTGVoODk4NXhqSHJmK056NkIxN1RmK1pw?=
 =?utf-8?B?aXRsREZCYUtTN096M2d1QTBSMEhic05aV1ZyZVNrRVQ3d3ViKytacjd1V0dY?=
 =?utf-8?B?QUxrQm0ycGxNSGY3RWlXY2l0M2pNRUN3YWszZ25MYmJJd0h6WW5wRzRDeFd5?=
 =?utf-8?B?bzA4eFV2bkU4YlIxT2NPdm05Y0JOODFqZ2t1UmxDazNWby9HTE5yN2RCaXgx?=
 =?utf-8?B?cGVKR0ZGNUc2SHJ2MnpqbW1lTCs5VEQ5cG4xMGx1U3J2WGhGcDZRWUt3b00x?=
 =?utf-8?B?YmNudTh4OXUyR2FIZ0RoY1VWMmFVM243Q25ESWI3TU9VSDkzZjRpdEJKbDNI?=
 =?utf-8?Q?Vxw59J+uJ8F7yGGQXY97EnAOZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d34e1ac-f1bf-47eb-423a-08ddc8c82230
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 02:33:25.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOtr8DeZ1Pcv20NicU5v1okpnO882bOVCs/QEE1k50OjWJdjsE7I8XMOwqWWIkHbb8lbzwR5ZqiJWvXwj3Royg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9444


On 7/22/2025 4:16 AM, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri, Jul 18, 2025 at 8:14 AM Chuan Liu <chuan.liu@amlogic.com> wrote:
>> hi Marti:
>>
>>
>> On 7/17/2025 11:43 PM, Martin Blumenstingl wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hello,
>>>
>>> thank you for this patch!
>>>
>>> On Thu, Jul 17, 2025 at 5:08 AM Chuan Liu via B4 Relay
>>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>>
>>>> The cycle count register has a 20-bit effective width, but the driver
>>>> only utilizes 16 bits. This reduces the sampling window when measuring
>>>> high-frequency clocks, resulting in (slightly) degraded measurement
>>>> accuracy.
>>> I checked the Meson8 downstream code [0] and it uses 0x000FFFFF to
>>> mask the register value -> this means that old SoCs also have a 20-bit
>>> wide width.
>>>
>>> [...]
>>>> Here are the test comparisons based on C3:
>>> [...]
>>>> Here are the test comparisons based on C3:
>>> I have tested this patch with Meson8b based Odroid-C1:
>>> pre-optimization:
>>> # time cat /sys/kernel/debug/meson-clk-msr/measure_summary | grep -v "  0  "
>>>     clock                     rate    precision
>>> ---------------------------------------------
>>>    clk81                 159372396    +/-5208Hz
>>>    a9_clk_div16           24000000    +/-3125Hz
>>>    rtc_osc_clk_out           31250    +/-3125Hz
>>>    hdmi_ch0_tmds         146399038    +/-4807Hz
>>>    sar_adc                 1140625    +/-3125Hz
>>>    sdhc_rx                94443750    +/-3125Hz
>>>    sdhc_sd                94443750    +/-3125Hz
>>>    pwm_d                 849921875    +/-31250Hz
>>>    pwm_c                 849921875    +/-31250Hz
>>>
>>> real    0m0.102s
>>> user    0m0.005s
>>> sys     0m0.069s
>>>
>>>
>>> post-optimization:
>>> # time cat /sys/kernel/debug/meson-clk-msr/measure_summary | grep -v "  0  "
>>>     clock                     rate    precision
>>> ---------------------------------------------
>>>    clk81                 159373438    +/-1562Hz
>>>    a9_clk_div16           12000000    +/-1562Hz
>>>    rtc_osc_clk_out           32813    +/-1562Hz
>>>    hdmi_ch0_tmds         146398438    +/-1562Hz
>>>    sar_adc                 1143750    +/-1562Hz
>>>    sdhc_rx                94443750    +/-1562Hz
>>>    sdhc_sd                94443750    +/-1562Hz
>>>    pwm_d                 849992188    +/-1562Hz
>>>    pwm_c                 849992188    +/-1562Hz
>>>
>>> real    0m0.173s
>>> user    0m0.008s
>>> sys     0m0.109s
>>>
>>> So there's also an improvement in accuracy. The only downside I'm
>>> seeing is that it takes 75% extra time for the measurement. For me
>>> this is irrelevant since we use this for debugging.
>>>
>>> [...]
>>>> +       /*
>>>> +        * HACK: The input clock signal path from gate (Controlled by MSR_RUN)
>>>> +        * to internal sampling circuit in clk-measure has a propagation delay
>>>> +        * requirement: 24 clock cycles must elapse after mux selection before
>>>> +        * sampling.
>>>> +        *
>>>> +        * For a 30kHz measurement clock, this translates to an 800μs delay:
>>>> +        * 800us = 24 / 30000Hz.
>>>> +        */
>>>> +       fsleep(800);
>>> What is needed to make this not a HACK anymore? Is there a register
>>> that we can poll for the number of clock cycles that have passed?
>>
>> The required delay duration is frequency-dependent on the measurement
>> clock source. The current 800μs delay is calculated based on a
>> minimum input clock frequency of 30kHz. At higher input frequencies,
>> this delay could be proportionally reduced. Applying a uniform 800μs
>> delay therefore appears overly conservative for general use cases.
>>
>>
>> The IP currently lacks a status register to detect whether the input
>> clock signal has successfully propagated to the internal measurement
>> circuitry.
>>
>>
>> The design of this IP has been maintained for many years. From a
>> hardware design perspective, there is room for optimization in this
>> signal propagation delay. Future IP updates may not require such a
>> long delay.
> Thanks for the detailed description. To me this doesn't seem like a
> "hack" then, it's just something that's needed to interface with the
> hardware correctly.
> My suggestion is to replace the word "HACK" with "NOTE".
>
> What do you think?


OK, thanks for your suggestion. I'll replace it with “NOTE” in the next 
version.


>
> Best regards,
> Martin

