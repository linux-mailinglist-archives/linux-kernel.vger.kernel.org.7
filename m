Return-Path: <linux-kernel+bounces-729531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08DB03803
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6C017A6FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7C23371F;
	Mon, 14 Jul 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="BK+CKbR8"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023123.outbound.protection.outlook.com [52.101.127.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A474944F;
	Mon, 14 Jul 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478329; cv=fail; b=rMovB9HpeKUoFGhYkcVOJ3dazFnENtbGnciv8myPmZQQX1H8DF9KnAW61zYnz3SDYeqS84JgOE5KU6Gcc/Gh+vN2OnHa3zkTZFdiXDcJgPzHNXtJ+ENU5PnOfyOEW5N9jbgYhN+Dx0x4JEmWI8N54aSCBYWfmoci1oBnladWfjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478329; c=relaxed/simple;
	bh=8vdcRxO2zLf3gvIup6aODAuZS5SddhlwmoE3JAOlffY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxUMstPPf++LzbaCodOoxAXeds/FoS81R27js4g5osqMU8/BJEt5FVTGWn1lkI68AW4ckTNCGxx0ZHnyVawWSpdJWZlWXdCQAeZ41uGCCTOldBtbTfiJ0ESJHXiSSsl+tEHMCM1arkAKSK9ZfKm6NA6xFpD5yqPuVuaZa16okio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=BK+CKbR8; arc=fail smtp.client-ip=52.101.127.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6EvQmEo5+MvQkjoz7MmJa2sYYmGy7eQNRyVSpoIJquv9ceqEAR7AJlN2q2V1smhZcQZqW1BX5jPMZdszSSrwv/V1C+RbctIyW4k3DO9DPSlmUi8YpjYtTQEGDT+Jdxp8nXANFuUTu0YSuezwbFcZKpuKfxVfsRlNpdsL3AMJEgbJY3UvrUuA79cUXJma3MQuCeXkEwjr44NTGTPmV3weZ7LbSb47ezmLBzXbpD5H6AYhOWjw+mJEUiN2EreK8iDZFUBLGMemwpziSy+i2LNCSyh7Gu5SqwnXnf2gZTUjHbYpqiRRtdtd81TqJzIxl3pI4aM6GtRV23zVoSubNoOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vdcRxO2zLf3gvIup6aODAuZS5SddhlwmoE3JAOlffY=;
 b=rb9+TtKUdnwqgu1+z0MsJ1IiII2v6yujF6bc/wBqzWdCRWLJ+TxiBrxIUD1YFw/9wCck5AjhBpOso/h3G8KyhuwD4t2l16R5JohwmeloTSd0YAd/IlVZzRIwj5AC2axP2hL8F1JTEbwX7WvWzmR73fTqiTCy4w4cvxemFhVyrg08L0CJO/DhkRe/e10E+qOO90a4EJYXdNEWVBS+wWfqlpyAZrjr8YuWZ1BCi+IZPZXnu+6j5GZgiAtB99XZApcS1BZc/npxqnZQZ/ukbec85ZZF8CWW/wAZqs9mo6VNnmOySscVFo0IMk+ZgYmEnI/95aVO9mcG6WJNF/4H7vg6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vdcRxO2zLf3gvIup6aODAuZS5SddhlwmoE3JAOlffY=;
 b=BK+CKbR8flrMIRrZHMdb1UCY8S1eO23dFjQAYsUtbzzp6RMown8RrCh/JfeLn9E5Zizu71CviZtrZmPQAiFmeYG2/ue/aBu2g4ipm50e+/BP35xev9IxbPJ2E4NVVUbivzTAIrxCzAcAocNbF29OPgiXZUzojWOqz5/o1PsBDhVztePhRMQ462m/sbjr/D00+GKxqJHYyF8tSobk/mlt8aluAerMGgY12YcjNDdhI0HJpxHzVQgNw5FyDTs5A96GfaWjWkWfhdmR0PwQlkFQVZxlwTWpKEwWKxKYHEfCLQQXy8spUBpZNpDwq9KA5bhjg4W8AtG5eFiAVMO4vLK6ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by SEYPR03MB7862.apcprd03.prod.outlook.com (2603:1096:101:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 07:32:04 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 07:32:04 +0000
Message-ID: <6846c3f5-0d73-44d7-9330-5edce7813f0e@amlogic.com>
Date: Mon, 14 Jul 2025 15:31:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
 <20250710-audio_drvier-v5-3-d4155f1e7464@amlogic.com>
 <82f1a34f-bfdf-466f-9c44-2e58d172f3fd@kernel.org>
 <b8d61abb-a6a6-49cd-94c3-f397bb30203e@kernel.org>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <b8d61abb-a6a6-49cd-94c3-f397bb30203e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|SEYPR03MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 11819406-6636-4ec3-8dc2-08ddc2a8874e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmFubDZCbWRBK3cvNndFZktkcW9ySDdmc1BQREpEdzZQVjRlM2Z2RmtIWnAx?=
 =?utf-8?B?WHJBZ2pEaEZWc3RLVXFBc3hKS0J1TzVNemM1Y011UHNncWRVTXFROTYwSjMy?=
 =?utf-8?B?SGsvVWQwVjcyUVZtZTRHN2Rkd2x3bExodlNMcnpxNENTMHU3U054UmFRWUdv?=
 =?utf-8?B?OWNWY3lnWmhOUy9pbFpoaHIrems0THVrUXd4bHJzUTY3Q2tUR0RvNVYwVVl5?=
 =?utf-8?B?UDRwS1IwK1RUWWpqSEthV2NJWUNuVlhXaXM3ZHNKeGRNUS8vV2dDN0ZtcmZh?=
 =?utf-8?B?TW9EMERpU01RSWhXWVJnSXBINnNvUWJaS1J6VzJWUmVDc1kycXBwamw3ZTll?=
 =?utf-8?B?MUhmMFJ2ajFJVWwwSkxwdSs3KzlkVVRpZ2RDUjI1Y1poMWcyQTRTcHkreUE4?=
 =?utf-8?B?biswU0x1Wkk2c1ZMckc4Y3NCdWczWkdUQ24rcWF3dWo4OUlzSjlmWitZWXov?=
 =?utf-8?B?aU5hcHcycmtyVDQrYVJDc0piVy93RXJtRk0zbVR4a2hLcWdGL2JDMDNvZkdK?=
 =?utf-8?B?aE8vVFpSb1V1QmhUS2VGeUZjaWhGOGFQZ0dYQ2xCS3ZuaHJTQUM2cnRhZEd0?=
 =?utf-8?B?YkFXYnFMTlM2SXBMUXd3T2JHS1Fubm5vdVdCM2d4L3YzbHJFY2pyVHhTYm1i?=
 =?utf-8?B?b2s0ck5ZZS9Iclg1ZEFXa0o2RVM4SjZlT3hJL2t2RzJIcFEvc1ppaHczVlhv?=
 =?utf-8?B?M0llWEcwa3VoV2ozdXd2dzRXOGFVNExTS2Z5ZU1FRWRkaHRHOFJtR2tQRWhj?=
 =?utf-8?B?NFVUQmJPbjZJb0ZnTzJvSkY5anNOUzg4aDRxZUJXWDVyenN0LzBrMWFFc1gy?=
 =?utf-8?B?QkZhSlhSLzN5TTI0OGFTUERIT05HK3k4U1I3WjRjNXE0YVB2OGJqNVdFa3Nv?=
 =?utf-8?B?YzZxV21naU5hWGtUU1ZjSUNyY1VKOUtIWlZBcmJPbFp0ckJBaitGZVY3OVVN?=
 =?utf-8?B?STRQWnlZSUJWbmVINlh6cmJPazhSMkJ3dzhEWklObzBjVWg1N0NBN3RhTldr?=
 =?utf-8?B?Y0lJQWdEaDhET3oxYTIzSXM1SVo0aVVGclhUQzRuWnp5QktQRkx6VWMwVVha?=
 =?utf-8?B?Vi81clM5TmNpTnRpSURINFNNbWMxY2lDWUkwOGwwbmpmSTAraFRyU3RvWDhK?=
 =?utf-8?B?RnB1cFhxSEVtVlRQR3NNNTZBZzd4dXBpVWxmSHhHMFd1aElteFpOdCszR2xs?=
 =?utf-8?B?eE5Bd0tTY0llYXRxRHJEWkVDVHY3Vzdjb2tnMi96aHJGRUZObldxSlV4OCtS?=
 =?utf-8?B?bXVMcjAwM245eWkvd1YvQ2I0cHI2alF1cGJPSzBvUDhvQmFDSGtsOVMrMEVM?=
 =?utf-8?B?SXB1cDhsckZzYjZZOFRjOWR2d3AvR1JZTG9WZEl3VWVzSXhFdlB2d3pvRW9x?=
 =?utf-8?B?VG16clBIZzBYSDNRQWtEVUc3OThObTlST3oyU1ZRVnQvZm1OVjRVS0txU2k1?=
 =?utf-8?B?cVJZNVkwUkM4M0lwRHlwOWpvVUhxL1B5MENMM1N4eU5ZRVY1bERka2diYzJZ?=
 =?utf-8?B?V2I4elpWZUZrM3NBUjRrTDdHMG9aTFhVL3JWa3VuQWpLL1phRFJ1cHljOGFa?=
 =?utf-8?B?aEZEMDBDMHFSZXljNDN3cDJDc2d3R0RPd1A1WnBCaHkvaXQyZkxmSUtkNFlO?=
 =?utf-8?B?RmlpeTkxcmtqSGZhcG1ad2FBTmJvRTJwMXhUUDVSSzBFUEgwK2syNWRJb1Y5?=
 =?utf-8?B?bjFZMFpYRXRKMWZIbmdiOGVETUZrV0ErZERtWStQdC9MTWdodklsVzl2K2dY?=
 =?utf-8?B?RlgxUlJ6SEhZeUVuSlp2dEs5ZlhMaGtRcElWOThFOTFvZk4veTlLZk9ja1dt?=
 =?utf-8?B?UURiS2RjWkJCbU1oWE9hSXZDVWVEY09rMHplY0dsdjFFdWJxNnd6TWdIWUJT?=
 =?utf-8?B?OThzSzJCSWxzZFd4ck02WVZZaUlnWmZpMGlTamZZV0NBMjVVT1E4U2pRZWV2?=
 =?utf-8?B?bU5DeUFYUDJQK3F3UGFKMStTOHVlUm9lT1lYdFZzR0JDcWxPcWk3VXBoV1dp?=
 =?utf-8?B?dHBKaDFsMTB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlhEQXhldzdVcEc1YlRmOE9IZ1YwR1RkdHZJNWZvL0l6ZTBnano4T0JNRUFw?=
 =?utf-8?B?RnVHT3hHMlkycUk2RjFpWFRVMzQ3aHB2SUJtL0lrcWxuSGk3eTRzcWdOMzJr?=
 =?utf-8?B?dzR3TmVOdjh6RXUrNUtOVkxUK0NaMGNaQkZEVVVNL3FaaitXanM0S01LS0xI?=
 =?utf-8?B?aElreVluUHZSQXd2MmQ3RHhFemFSaThseVJYNU1HTXhxKy93M2N5amtEaEdx?=
 =?utf-8?B?aVZNVituS3RHNkRxei9rZDFYUHBOekZHUGxYWXZXZU0yLzFHaWs3Q0t3SHlO?=
 =?utf-8?B?TDFzZzBtbWJoUE1jeHRwUGh6VThUaUMwMXJXNngrQUxxYmVKWEt5ZTNFZTV1?=
 =?utf-8?B?V3BHWG51M1p6RmY5ZW1ZR0xJb0VnRDFuaHlyL20vR0RHUEU0NkdsKzU3czRm?=
 =?utf-8?B?bmhFNlpNVWE1TkdJditTSUxIWm1xcThXY21EaFh2aU5odThtdDFyTW5oakIx?=
 =?utf-8?B?eTBnYTZZdVRhTm5aM3FhMnlUWnpQdDNQTzhJVE5TZlVmTHZiUi85T3E0eWYr?=
 =?utf-8?B?ck41Y0Nja0NIMzM5d0pEYk10aWhQTGxyb2FxbUtUWmpiQ1U1RWtDTVRtelFq?=
 =?utf-8?B?MmJnRFJ2a3dGMDg4QXFXczBlSTZDQWxUVmpQemxINFEwTUNRU043M3lOcmU1?=
 =?utf-8?B?aDh4ZXF5STE1WlZMd2FSZm5Rdi9SWVU3ZTZvUXFuWjlTYmRrSUF1alpFV0Nm?=
 =?utf-8?B?TWQ5cWgxRTRZK05rZFNZYVNERVRpTXQwNFRVZ3BlcG03RWpLa1QrMWxxSk9k?=
 =?utf-8?B?QTMwSE1CUUJSMlQxcVN2TmFZRTBFV0FTMDlCOEc0NXJFLzViams4ZXR4aUNq?=
 =?utf-8?B?cEExWkhNRVd0UlRnc3U4a1dxM0w4NEdHeEx3RTVIOTRGL0U1YmNDNGtUck9U?=
 =?utf-8?B?VnY2a0QxdDdMVno0elpnRmpZRXZKcUhoTzhrRElqSG9EbkVmVjhFWlpzU2R1?=
 =?utf-8?B?K2JwZ3Y4SUpBejlBaFY5RGVkWWN2dUJlTEtXUWNrWHdybEY2c0J0eVZLeVN0?=
 =?utf-8?B?NEQvS09VdGJDUFJYSmdCb3BYWnN4UlI1d3o4WmdZMG44VlMzbGlMTWY1OUZV?=
 =?utf-8?B?ZW8xTTJld1UzT3BVOG5ZRkw3TTJGejQrSUtNK1hmZ0huRm40QmhoWWZKaFNl?=
 =?utf-8?B?bzVvc2FjMEswTC9qR29sanNKQXkrVEN3c0htbEw3QlZaUFF0bTAyRlZvNnZZ?=
 =?utf-8?B?NnorM05zREt5ZUFJeHppdHFBNTJhYm0wQXplYTJwY2x1MTNVUUFOR1Yxd3FR?=
 =?utf-8?B?czhTMXByb0J0ZHVBQ2RWQjBSZVlNYnJ4Nkx2anhMTFJhWVpXdWxIaHZRWnRn?=
 =?utf-8?B?UVVsRDJVVzd5Tm56SFhSYW90bU5CR01oOHMrNEpMbGQ3RGxoWmg2bU1oZXUr?=
 =?utf-8?B?MjBSRmhVcFlUdUYvbnFIRGN4V3BnZW5lem1GWk5PVnMveDJKMlQ2NzNOVGRO?=
 =?utf-8?B?QUZjZWUrMnJkODhYK2VXbko3UVZobEc1eTdiZUV3MVp3U3BDY3JLSDJQUm56?=
 =?utf-8?B?eGNXWWxoTDJKWEE2SXRkZnVPRGtDSkpQMXV6d3dpdnNPeDZkYUxqdlpLZm9O?=
 =?utf-8?B?K3pqcTNDeG1BbUZrNDhaUVcvM0dYRExRbWM0UDA1WndDVFhFQ0tQbGhPU3VX?=
 =?utf-8?B?VU9QWHp4RWpEQmFPRkZIQTBmRFdLNlZ1TEw3MlZCTnVCWitJVWtjdlBEV2Qx?=
 =?utf-8?B?UjJOZ05JRC9SNVQwY3VRNDZOWmwyMFpmcFo1MFo4dUFsS2E4dFZxSmdNOXFK?=
 =?utf-8?B?aVVteW1NYzVrVVIvQi9uaUR3WlJwVWU4a3l5cjMwZXh6QklRMmlLTHZxLzFE?=
 =?utf-8?B?ZklKTTZSYzhpU1NNMU05anhvcTdGMmM3aFJUbVZ5L0hGVWhSNE9QRUtJTFM3?=
 =?utf-8?B?L2Y3ZXVkMmxmZDNBbGFKZ1A1ZmFrTCtFb3dLbDUxK0dMV2tCUWdNd0hCY0JC?=
 =?utf-8?B?OEYvZTRwVVVjMEZzUFBycTlTR1hRcHJJMWY5TTBQNUVPNmpDNlFPQ1p6NWRL?=
 =?utf-8?B?cTAwMEVoNFVPb0xsUkVkNkNCUEl0OWVRRGUrcWtaUy9WWi9IdDJxdEwwbjBI?=
 =?utf-8?B?azZCUmZNcE84NmJhMWRKVG5TMGdaOStPREx4cHpOeUhGUi9zSnJQVTZPVkNp?=
 =?utf-8?B?R2ZYWCs4bTkyQW1Yd0VUbU9wUUhCRnVoS1dKRWdBRXdtZzkzTjBqTmhUdEc3?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11819406-6636-4ec3-8dc2-08ddc2a8874e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 07:32:03.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehedE5UGpHRUeXbB9mWJ6e8U/R/9D+RLtwtBJRP5EhY3Z745jfj7L1oAdzTHaOhYUSfhUbRRwJswxgGaKIKRS78UOFHy9YYWSvXZ6YgC5nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7862


在 2025/7/14 15:22, Krzysztof Kozlowski 写道:
> [ EXTERNAL EMAIL ]
>
> On 14/07/2025 08:10, Krzysztof Kozlowski wrote:
>> On 10/07/2025 05:35, jiebing chen via B4 Relay wrote:
>>> From: jiebing chen <jiebing.chen@amlogic.com>
>>>
>>> Add S4 SoC tocodec compatibility support.
>>>
>>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>>> Signed-off-by: Jiebing Chen <jiebing.chen@amlogic.com>
>>> ---
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>>
>>
>> <form letter>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
>>
>> Thank you.
>> </form letter>
>>
> You responded in private, but that's not how we discuss here. Please
> keep all discussions public.
>
> Above form letter means you received feedback at v1 or v2 and you did
> not implement it. You did not respond to it, either.
>
> Please go back to v1 or v2 and implement entire feedback.

thanks, I will refer to the previous submission.


3fda85324b8d ASoC: dt-bindings: Extend name-prefix.yaml into common DAI
properties

ASoC: dt-bindings:

>
> Best regards,
> Krzysztof

