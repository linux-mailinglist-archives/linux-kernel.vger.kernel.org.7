Return-Path: <linux-kernel+bounces-607188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE3A8B90E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 14:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D6418973A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B601A248876;
	Wed, 16 Apr 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QY1y5x4z"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB331E9B06
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806571; cv=fail; b=N/Z7dgxeJF0CvNjo3gJtxl2iHjf/ISc1wdHH6OB7UzAosDTMTJIalUL4lmCcnuYSBmBXdMnuoV5fOHEq7lN1a5SC3vAKmL8e9juzCPSIlRhBDM9gGhGr+XrD5wbUinJOrE9p01GZmosr0i5DzS5cSDKrSrKzoT9SH7kQ1LOjPBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806571; c=relaxed/simple;
	bh=xVPg4QlPzbi4HBhNxO7AcfwBFLM/Et+wKqwb4guMX9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuSNKZlo7XY8nD4PSR5WVf1xvhIyfXsT7gJ4wRuEE52QArqW50cGIjWr//HlZ66gJApNK7QRBNPtEiPYMuhkFjoi+0YLI4KiCT6lRtwkNrTga1O9Ufo353rgWaBEGXKKdZUgevkAAipet7j+tGbslvPar8i/EbADPkAR6VW1Dsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QY1y5x4z; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcjjuThV15M+NXeU/OWfs+e9sI0VWW2T5k+VzFxB19t48kH88/92lSIAeSyHmk1358pGtnMM2es2ElQN89XGqQo1H6QXJqCxijQ1g46ZzLWJ4QDKtEG371O1KjDsGHiG3b0MvEK3yiNY1fAAbwVGcViKTBsuYkw544HZfv1dHfJ6veNRNLO3Il1FEhLYtYZ/izM+KnioCzj/oKWSkRY38N48EL6bx0YQvELq/NTLVZ8VVk2Eokk1cHgRcosmlp7xiei9Br9BdfhW5ipRU859ywpL8IqxqL6YMhJ+PT9dThe38jENSvicsCXQqhh0RKKvByabkuz0rdc0to/S6p7R7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVPg4QlPzbi4HBhNxO7AcfwBFLM/Et+wKqwb4guMX9s=;
 b=wGaZPU142jjhtjxI9KEN4/y3XnTrgnRv1TXJCZD+IDs6AF9Wz++2WUCNXPBvDYH08FTcBFukrCdA41Whk1B+HZMmFMZIoMZRME1hcMuDcRiWAuoETuXKljjyFa0XHRFcifTw8X/tHqyEtYZEkPcNjpBx8wkyud5aZc+0BoAhggWpnseNylpscPpRjeKu/jke1XibuAbvG+TkZs635tgX5QhfoIqWoWM/2gkG81P/MB0DHgbchXjTR1x4Adftf24SscOli8V78EUv2JAYH/Q/CoTeBPEu6fCwqIjGcg63alOklElbZGjLRVabH4Tkvow+NUwXZBU0NXo+7ESUVr6/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVPg4QlPzbi4HBhNxO7AcfwBFLM/Et+wKqwb4guMX9s=;
 b=QY1y5x4zLj//n5+VtD1gBtsdOgyr0wj2QLltQ4XRSuhDpeM0SmM/j0pK1C9+BORQWrwxQuIYBnWphjgTmRtbWz6p17A8+NeD18ZFX9MUKx1xhS/5cu5L98nnMN9mvqgNHDvjS1988OnvClt0mhmo8+xZHdVmg+xc414ATEjp04o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 12:29:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 12:29:26 +0000
Message-ID: <b79094aa-89de-4afd-a4a0-3337a6a0054f@amd.com>
Date: Wed, 16 Apr 2025 14:29:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/amdgpu: Block userspace mapping of IO
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 lijo.lazar@amd.com, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 Jun.Ma2@amd.com, Yunxiang.Li@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250416072825.3790-1-ujwal.kundur@gmail.com>
 <241a9bbb-6d59-4c24-8e18-a0acebc6f536@amd.com>
 <CALkFLLLKT=4LD_YFJdq8QdzybknRQW+W3P-3GnJzT1eoYuGg8A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CALkFLLLKT=4LD_YFJdq8QdzybknRQW+W3P-3GnJzT1eoYuGg8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: e33e9ed2-b2ae-4b64-b375-08dd7ce2537f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE96bGFhVzNMby82Z3MreUZnbTFYVzFIUXRKWi95TEZkWGZyZTBueXRwNWhl?=
 =?utf-8?B?b2RyT1JZUjN0ZEY4R1l1RmJGQTM1WUVMV2l2S1JaRGxvOS9VVGl4cmY4Vlll?=
 =?utf-8?B?VVQ5RFViVzJEZUlvQTAzanB5am14QmVQMFNEMVRFN2lobitBaHo2UmR0TnJV?=
 =?utf-8?B?aVJwWnFSMkhRekN0cExXc3dPZHRDdTMwa0VCZXluUFFkM2VzT3dyRlFadkVN?=
 =?utf-8?B?amF5a0p0Y0ZacURqZUJWdjVXR0FSa3MyNGdZSFR5cTR6RmNlRW1PdHROdXI1?=
 =?utf-8?B?ZnhCb2J5aEV2eHdWQkhIV3Y4cGc2UUxWNkQyalljdDQvZVZtbElITVRqOVVN?=
 =?utf-8?B?L0Uwd1RPVlBBck91RzVMU3NSUWRNR0lUNG5pSXczUlp2TlZIUDBRY2xtTGNj?=
 =?utf-8?B?ZzhTMjFpYjZ0NnY2dEJjM2U0dklmYm50bG41NkwrOWRSYzNpV3htdlRFNksr?=
 =?utf-8?B?UEVKTEtxb0pMVm5IMzNLNjI3amNtblUwZW4xdTQ3dE5ERzF6NFU4aXRXVEph?=
 =?utf-8?B?dVpkTDl3RnE5MDZ6SUVOUUdsQkVqSUxyMjBNVkFoMktqNWVMOUxtY3lKQ1FH?=
 =?utf-8?B?WmgxbzY1clRFSmZ0OG04bUNKVEdCSkpTeGhBTExONThtcEpNRXVLWXZUTkQz?=
 =?utf-8?B?eHVnaFlXSmozaEtMc0d5RUs5Y1djMG5VSFNHZGkxdzZkaVZmWUY2UTdua0Rk?=
 =?utf-8?B?SjB6R3lFVldLS2J3Wk5aZW9VTjZCZUIzTEkrTzc5VWtpRjFaQ3R6SzBxeWZD?=
 =?utf-8?B?cXFpY1A5VThVYTAxNU9YQVpNcEJ1YmYrSS9PTHd0NEtTTDRTY3k1Rm5JTE03?=
 =?utf-8?B?andoa3VrT2JjbmVQdnJLSldnNkZSd01ISWN1MURsOU8zYkdYTDZaKzJwZzg1?=
 =?utf-8?B?SHRwOENIREJnOGpRZHFqakFNN0dEUm1pMm53cGMrTzVtd2ZseGJPMUlMUVZS?=
 =?utf-8?B?T0tWb0RnSDljMy9PQm5TSUl0MHB0ODdMUnRqQjloTW5wRVYxOHFJRU1GbGo0?=
 =?utf-8?B?c2JRRGxrTVZXNmZIVEFNMVFzbTg2TGM5K1FQalhseHFoRkdQZjlmT29lblpO?=
 =?utf-8?B?bGYyQThaaEw2TVFsdnV5SlJ3NUZtQXdib0JRYWs2cy9zZiswbklORjhxN1pV?=
 =?utf-8?B?dG5JVzMzSGswc2Q5UTFNVEJ4SzM1Z2l6eTd1enozeFM1cktrYytaUTNIRkVF?=
 =?utf-8?B?R0RVZlhraC90ZXovYU9sQ1Iva3ZTMnRndEVtdEZFZys3SFVvOHRPMzFQMXRs?=
 =?utf-8?B?ZXplaVVCcUM5S2xwbVI3c2JVNm9MeGl0RVNKTUxXdkFjbFlINXhLc09MZHBT?=
 =?utf-8?B?VllqZUtNUzJrSlBHcjlTMGw4WTVZd21FNUhqYW9obm1oZkU5d0x4ZXVyNm1N?=
 =?utf-8?B?cVZpWG1jRk0wcDJmTFF4Wnk4Y1d0UlJsa21RNG1xazhvRXN2N0k3ZTdpdDhF?=
 =?utf-8?B?b3BadjFDbFpVdWxpSFJ3dUtuTWJUcStqcW11NXpOYzNFcytDMlpXdFdPNkRk?=
 =?utf-8?B?ZDU4WUN3ZElCMnZXUm84clYrQ0ZGWWpGZ3dUd3lmakVTN0hObkZNZkNpYjhN?=
 =?utf-8?B?M1o2YkRmeGJxUjhtL3QyNWRGbEhrRXdwQjZDalQvdHA2V2dCOG5mK3gzYmls?=
 =?utf-8?B?SUN0Ukt3c0RoVmQ0OHhlKzZwd0JRZUZXbjh2Wi8vSXY3Njd1OGtLWWtqcWI3?=
 =?utf-8?B?QW4yQ2RqeE1XMkx4NEhoZkMvUVhzWGE0L1BrS0hpdFpkQ2tmTDd2UnNKZDhq?=
 =?utf-8?B?bUxZc1FiR3hUOFlFVDUza2NTQmhMVHlCRlcyNkR0SzJQODA0a1ZhdE1sdDND?=
 =?utf-8?B?c2Q3Q09xRWhEVUJPWi9PdDFmWFpsMVFaUEMrbDUyVTU0bmhxUnE4Yk1manJh?=
 =?utf-8?B?cHA0Q3ltQ1dmNGVPUGRDUVY3aFdoTWxjTUlnMmNTb0I2V1RLWkhreE1QVEJU?=
 =?utf-8?Q?mX/j9vMTyUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWxhNEErY3IwOG1KalpOK25Qa3FLWUU4SHg3dWN0eVBmUm1zdFhwemM3WlVN?=
 =?utf-8?B?NHpnOGREbjVRNWdCbTlrUm1wK09JdXY1eEl6RFdoL01aU2VMOUNQVU9leDE4?=
 =?utf-8?B?S1FIdVNwNDNhZE95RTNnU3V6ZzMrMk5jbitzbkVlbk1XMS9mM25SNUNGc24y?=
 =?utf-8?B?OW1xSEg4SW50eUJGaFlScWlqZ1V4WkpsVjcwdmwxcjRiQmFndjlwMW5UVDJJ?=
 =?utf-8?B?bWx5Z2U0Tnd2VDlmQTJUZ3FYTFc2QW1YRElHMGVmLyswS3MxMkJHZ2c1cVBK?=
 =?utf-8?B?bWxnKzRNZ3JCU0xtbDE0dkRsVTlIM1RtV1dCazlqdGd0ZkVNYk1od2MwZ0gv?=
 =?utf-8?B?Ny82dllDOTJMdlVVOUpTTlF3ejBtNko0WTJ0UmJOdlF5VWxtNGR6Qis3dVlO?=
 =?utf-8?B?Z0liRjA3c053dm9qTDU0NnlWNjVjOUROTXN2MFcxeGQ3dmcvbG93UmNGU2d1?=
 =?utf-8?B?MzZpd21WOWg4VWZZUXlvOEF3Rnp4QzRaZnhxdS9sakc1MXEyVzgxcnFCd3RO?=
 =?utf-8?B?WFp4MGJTOER0U2txQlhoVFpCM2duY2wxSXN1dVRwUlNMQVVSRVJqVEJKTERV?=
 =?utf-8?B?TG1WZVlMM21zNGtSN3FxTHE5RS9ESE5uYVgweHNrcG04QTFvZ3d0dWh6cCtX?=
 =?utf-8?B?cFVZRTdRcVorZENXdjZteUw3Y0pGTngxNVJWWXp3KzFKTnVqMFBoMHQxWVU2?=
 =?utf-8?B?OGYwUXA3dGVyR1M1V3l1akVVT01SbEdpYStkcnc2UXZEU0pSdzRjUmY2UmJE?=
 =?utf-8?B?UGpjZkNsRlNGbmhZMUplU0dZcnVvNEJoclVWTzBsbE95RkVadG45eXBBZis0?=
 =?utf-8?B?M3JzV0gwL0dOa0hzNjg5VkN3ekVXUkdKZEhWcTFlUHNZSkt1TjVWb3l1UFpN?=
 =?utf-8?B?VjJKV2xCZWdENlFheWtQZmhDVVIvNFQzQnRIMG9NOXdZbzh4YkpEZFVkUFFW?=
 =?utf-8?B?QjNlUnU4TmhjTElnRi9ud0NoTTBuWUFMbU1RaFMyWGo5R0JGVlBLd1ZMVVpi?=
 =?utf-8?B?Z2lldHZKZkFjOEJNMTJjNndkYjNKeHU2TzZsZEJkZUJqZXhCOHgyY0FtbWc2?=
 =?utf-8?B?MFlITW5lVEIrc0ZnRE55OFhZOVBsQ1U1dDd4YjNiQnJheEQ0b1hud1ZCV3FO?=
 =?utf-8?B?MDlFWHhwY1I4R0tBKzRvM1JSNlNxV0dENnZIbmE1NlozTC8wc3d2ek9ib0hm?=
 =?utf-8?B?MEp3OUJnOWZVVkx6QzBwQkhMVUtsYnJoSzZuaS85YTdFK01ZL0trUFByVW9y?=
 =?utf-8?B?cm1jbWsyY1hVa1BGaU9RTklNUzg2VG9iNGtoTHJ5K0lRRkVnRU9HV3JZRFVL?=
 =?utf-8?B?VCtUR2k1cEFKMTJFZjF5OTg5MmVWNXBkUDRGcDNnSFlEVjBpQzBZaDdmY1lX?=
 =?utf-8?B?NklaRXNJUTJzRjc3V3lFN2tPQTQwY2VGbmtrRm1YTnQrZlVhSnNxVTlwQ2xU?=
 =?utf-8?B?bXZFUHdsTjRFMTZQQ0gvWUltOEc4Tk1iTndJYTAyWlNlM0laUC9iYWtsazE1?=
 =?utf-8?B?L2dPZ1hoTHVYL1lBekx5N2hUdnliZXlMdFF3TWxMVGtaekhETXV5SytoUStl?=
 =?utf-8?B?OXRXTGNrTFAzNWVOTkZSTHlkeTcxQXFLYk02WnhmZ3Yrc0Q1Q0FodEpTTVpv?=
 =?utf-8?B?VDBvK0FBakIvaWpEczhNViszMSt0cHNTOWhHWEZFazFXa1YxbytNTnJOTGNw?=
 =?utf-8?B?NFRDa1preDd4TktrUC9SUjN0S1doaXNqSzdDUWVyaUhXY3lzd3BKL2I4bHkv?=
 =?utf-8?B?bjkxWDhrN0lxUzAyT0VtNHFZdUdBbHlSc0ZIZXZlc2ROcm4zdGx1NjVINHRP?=
 =?utf-8?B?S1VCRkIzSkZkWUtpWEpveUo0KytXcldSNFdYU25KVFgwTVlHaERXMkJOdmI3?=
 =?utf-8?B?alhvOENNeUlYZmoyTGEzSGhJZjQ5RXNoUFRVRXhXQ05ibnRKSDNHcXczSkto?=
 =?utf-8?B?Y013NUwxTzdSc1Z6aGE2emZhYnRReU5GYWVMQUxVVjFldGs2eDFqUHVMb2tq?=
 =?utf-8?B?Z3Q4aGFHd3ZtNFN2MGVBT0pTZUNnZytRZ0kzcEZ3SGlmOUd5enFHT3NOZHRs?=
 =?utf-8?B?cERyV2xNL2pIMkJ0c1laYUErTWowRCtKcmxJSzdsVTJjVkZRZDRtakRTeTdx?=
 =?utf-8?Q?jrNNse1U/2ZkegKUR503DTX9k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33e9ed2-b2ae-4b64-b375-08dd7ce2537f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 12:29:26.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Keobvt17V14PTb6thI3N4iIyUO9knIYdAcDYiuZthATljVPvnYO5JQsisSpSUR1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

Am 16.04.25 um 13:43 schrieb Ujwal Kundur:
> Thanks for your response.
>
>> Hui what? Why do you think that grabbing a reference to an interrupt would block userspace mapping of IO registers?
> It looks like I am missing a lot of pieces to do this, I'll try again
> once I have a better understanding.
>
> Sorry about that and thanks again for your time.

No problem. If you have questions about the driver stack then just ask.

Regards,
Christian.

>
> --- Ujwal.


