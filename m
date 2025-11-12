Return-Path: <linux-kernel+bounces-897027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC6C51CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BF41893088
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0E30C606;
	Wed, 12 Nov 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BpPV/Xje"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908130B528;
	Wed, 12 Nov 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945169; cv=fail; b=CNo1jFxF7sZCtetzY31d+yHHJcgss2oYVfCcovpgwmbROUYr4gL1kO9O5vMnXlkkJM7IUM0y2xYolKP4xHGzEUUjr+a2dw+E4YyYfOvKKVXAupwyYPfhJtHouqTjNM0dykX1Zxz8LzVbqKWRU/RUg8iGmcuhxMKIsQlESpaSdcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945169; c=relaxed/simple;
	bh=Sg6Tt14OtQpw3g1KR1Ub/TV7nDjb/49sada+Cm8jyXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdbgzKQJbVOdz83OXR4JVLEajwm1FgYUGW7+MCLNW86ac+XcH9FP7joW/TscQ7GSptqnpXRIuAW7Fp6gM5QbhDBnrE8fGT3NtYUvyTymlhtqjlHBs6zjH8i9+FtFa/VkR8CsZKKDmburHctqLc2fzfcyuGe+1MPC5kFrLi+PRqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BpPV/Xje; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFuyPZQ0KFE69vXtVtQ++JKJBzATTMCCntGwW8qtrPqPj0EjAhJxh1SgdHHiEmGgnILb9bTlfgTOhzeZsEUhUYh3xAA4tIv4G0gSoeAMsXHRZFarXS5jGxe7tF7KEn8LRoxvROb8UkRaAY/g365y0TqeCEq28TahQHV0rChCjSi+1malb3msnJPH5W0Jg46+14AajqeV+VFXnH1oGXRlgG9fF2VuG2Y33OQZXCP9+j1+PosnbIG0wfDxlLlzB4z/VSTsKvWSd1gb0KczV8ob1v1XLanLJUM5ImWhGRHyLYgRMG7/NYS7tAgv5sRpUWXI9Rh5C4g1PpePMvQSGB8ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bHtEfzwGvVxenusE6ui/bgAjjazkx3JJnFHuh0jYMw=;
 b=J0e/vjaKHHUlfDCHhMLCOpsqwMv4buJIgLpdxhc7KMK2tjYvtnxWPOL7dHqmPRQUVJO4vIpdu0Fqt3rTdRN5wT20kypThwhsA+9poa5rBU6q1mXY60Cm2cxNkVVFHcQvknIXSSGzu/9L3n5AbE3fefb+R4o0kb1K2OpLcvCAZDQ0MzrkAbU9MzREyTiBV4Tcj9lvy5+sA2nnIsMqsylNBWp6Hqx4QIsKzMyaWJcBglQCApaDKtY1WophQAKFWJSMYFUoxjcr78rmDkEj9P+ssMRO5G7W4s2eKqAmCOS/f2ViMbcLLY++nudBVRCOId9/4BrXG8Y2+jukl2x87LvCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bHtEfzwGvVxenusE6ui/bgAjjazkx3JJnFHuh0jYMw=;
 b=BpPV/XjecSLslC6RSt6fp8Ku+HTSC+LjRSkC5U/SbUo3OKM4S4HiFjkb+UmbDm9arM4QsueVePpmkA2xGlX95o0W4sW4QulSIeL+JfikezX7k2CXRHdlqYOsdoVLfrzifuHaopLXBXhGA0W2rBGcx2JYnzQzIrVUOEAwMJrHkAxCYpJJ0lJGeBNQqJm7eYY3KIDObQz1NsFcy7UptbRUnusxokhF5454uDYhikzAnweFbd6UdWv8zqn8xGlyxnT5sZ11WcGYE444AMqn80yWJXjGptn3kbojlV8U/fLtFhZaSqebjH8H6OLw8dmX9nLzOKMPAL2rN3XiT/4Cojarcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH8PR03MB7271.namprd03.prod.outlook.com (2603:10b6:510:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 10:59:23 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 10:59:23 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v3 2/2] arm64: dts: socfpga: add Agilex3 board
Date: Wed, 12 Nov 2025 18:56:57 +0800
Message-Id: <20251112105657.1291563-3-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112105657.1291563-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251112105657.1291563-1-niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH8PR03MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: af4dc8f1-4df3-4fb9-be1b-08de21da89af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDg0eVE5UkNYMGtXMVBRUU1SZjAwcVMvK000SERhTjdiUEtPK3F5VU5KYldN?=
 =?utf-8?B?RUhHYzRJczc1UFhKMkdUSkhnQlJTTGFWMnVWbW1GbDVRU2tYU0hvZkZQN1dG?=
 =?utf-8?B?cmptd1VSLzVvSGJNdHk2SS82bkZVQVBsRFlBVFJicEZCWHh2Q1RNWlVLdlZn?=
 =?utf-8?B?TkFBMzM4K1NIY3d5dFdlVkN4ajExZlQvK2owWExiNHdVS2xpaFlhNmxNUjk3?=
 =?utf-8?B?TjFyTVdtck5abEFseWtNdXh1RzN6T3J3WEpXRjFKS01qelg5ZzIvOGlUSnlh?=
 =?utf-8?B?M1g1aDNkSDBXS0V3S1FVMCtLNGg3OTByY1BPcHI3ZDAwd0VLV0ZpYnRyUGlD?=
 =?utf-8?B?aWlWLzN0TXpEdFpURGQ5NGY1NVVFMUFKTk1MVlVRRnRoVWNxTUdQTnJTMFpL?=
 =?utf-8?B?dHpNV3RxeHc1N1hJdW9jL3BpbUZEQ2k2WHRWSzk2Mi96QlF3TXdKWTFSQ1Bp?=
 =?utf-8?B?VEJLNUZzZHkvT2l1QUg4SGdHNzJGUlhsQk0yTlF6R3RxZ001akE4SE5oelh2?=
 =?utf-8?B?T0FGN1ordHlOZE1VemNVQ3AxRFhKT3g0KzhHSGRnU2R4NzR0VHFHREpGM2JP?=
 =?utf-8?B?eFhYdldYbitVMWRpVzFZQlZNMDNjcnMyUjc5b0FSTENKd3F4VmFRcVNIbTRV?=
 =?utf-8?B?NXlZRXJVYkxRZlhwY0FWQVFTNkw1aEM4K3JVbHFURGFya1d5QzhuUXQvcXJH?=
 =?utf-8?B?M2lJTnk3elZmOVVmbzNGN0tvM3BSUnZEWEpIYzhQWjZrbklLZHBVU3o3WU1Z?=
 =?utf-8?B?UzFwVDdScUdrMjZWQUxrTmo5WWtNZUhJbFU3TEVqMUFjNDdwTU53eUJjSU5X?=
 =?utf-8?B?cSswS3FueXZBRytVU0JFbHVpN1dYRWMxeFN0dVNHSjVrbGt4THkzeHp6UDNG?=
 =?utf-8?B?TG15RmRqS2kwSU9LVE9yWWRXZDhzZk5Ka3NMcFZ4bU9CN0pEcVplaUVYZTJt?=
 =?utf-8?B?U1RjeG42TlJyaGxiRDNrMWZZV2U5aU04elprM0N3dmpkUWg4b21jR0FTZzIz?=
 =?utf-8?B?VFVaSGlnaFMxQXIrRUJiTHR2MU1ySTNaV2FYK1RvQ0krYXk0cVBGQ0ZGMkhS?=
 =?utf-8?B?WXpnV2JCNHExNlVHMHZyZHdXSHVCNmxxM1BGYWpMemRWdGFETGZma3JZaExo?=
 =?utf-8?B?MDhPdHRwbHBXaVZNc3hLaTYzdWtnMW9Lb1ZBRGJDU2lHZDJpWXp0bnEzMEw5?=
 =?utf-8?B?cThUK3ZZYUVsOFNZOEFzZEFFQlRPVk81YWJiMmd5RmVFWWlqTUtZYmIvY2o0?=
 =?utf-8?B?Skk0citNaCs0UDVneTBLWUZPTVNOYWpxak1wL2I4V09sS2lCVG93c2MybzNt?=
 =?utf-8?B?T2w3Ym8zYWt1VXd5Mk9obkxGZVpYREhQTmIrMHRJbEV0OFF4THRGRHpsdVVz?=
 =?utf-8?B?Lyt0R0JKUGFnY2xpTm9ETFNUNXRKcEZreHZxZURPdmQvaWsxaDFiaXdoaU5n?=
 =?utf-8?B?MkovUnliUjd3SVo0Y25STm1SN0Qxa1BWbGIxNzAxUUo0OWxLaWE0Q3cwZVpU?=
 =?utf-8?B?ZFpodS9tMGl1Mi9Ma2hpMldISzlDRzZadXhHcHk5K3pJa25iTmNQazV5SWIw?=
 =?utf-8?B?dnRsczdWY2g4bVdoTFpGbE1oajRPSGtUMHhSZkx5VXBKUFAvaDZ2UjF6VC9B?=
 =?utf-8?B?WEVlYlRselIvWG1RSmZ3NDVLeit1aEhneldzSDU1Y295WmdpNFpteEtRTWQ2?=
 =?utf-8?B?bWkvQjR0Z25wL0VTTzhUbjMwcjVpU3orM3lENDFiQ1AwSmw4bkpkclh3bFhP?=
 =?utf-8?B?aG54WWZXSXNvcmJDOFZMdUFNeGM5OTNlTmdtZ3pSQ1V3VGNvR0hkVStteWdH?=
 =?utf-8?B?OVhJNGxzWXdwTkRscWZIRXJyalBURnNzY1ltdktrL1hJSGJSc2c5MlpNNjF3?=
 =?utf-8?B?SnEvdVZNbU1xcjAraTN4YnVHQUhselR4a3pUZjBaR0NKTms2YXIxR3FQblo5?=
 =?utf-8?B?ZWlUZ3lINXR4WVArNmREVGIvTEVocnpyUHpEaFRwbWM4T3J1UkJuOHZoUzRi?=
 =?utf-8?B?amEya1cvbzFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHZab1JNTVpGRS9pWGpIVW1iSFhaV2w5V1JPYW1qWUtTbzlEaHBEeWl0YTZj?=
 =?utf-8?B?dE9wWCtPdjRVcW43bngwaWpvMTFTYVZVK0oyRGZWTkY4eDAzMWYwOG01cjE1?=
 =?utf-8?B?SmtYY1EyVUtSbTZvZ2plMXM2dVg2SnJIZ0plVnV0aTIrUVB0NWRjOTluSXRO?=
 =?utf-8?B?bklUVVJvZVNSbVZoaGNIcXZiTEtJSlNZNitkcVJBd2tMNW1lbVpzajVlSHFQ?=
 =?utf-8?B?UVVpdFdvVUhmcnk2Vit4ZVdleGtaL1orRkErNTI0cmkvU2ZESXVXSkprUXZl?=
 =?utf-8?B?MVVkZkFidW40ZGJESFdFdHo0eE5tWERwS3cyZUsrVStUSHBMRVJza212WUlt?=
 =?utf-8?B?eXIvMXduN2g3dFBqVXRSR1BWa0dCWWpkVTNBUkpnVnpzTU9QVzhieStneHhH?=
 =?utf-8?B?cE9BY29iUFE1cWE0OWpzdzRhc0owWlRnS0xLWVhmdWp6dllJVnVwb2taM09t?=
 =?utf-8?B?ajdNNktqN0tCOFpOdEl3NzRyUTkrcjlsOHN5NGhnZlYwRGpjZG1CN0FJTWRX?=
 =?utf-8?B?K3V5Vzl0SEpUK2w2V1craGVyTWxJSkNKTzU2bUN4bERCUU9lRFRRZmwzZlRV?=
 =?utf-8?B?dW1EVFlNU0NpZ2RDMUJCQ2I4blNvZzJtajJiYmV6b2NEcDFtYVhVYmlFZ0Jz?=
 =?utf-8?B?NEpKQVFRK3NPZzZoMVVVQ3Z0azdWdmQ5MnRQNjVpZURrV2NvSFhhVVBWVXhq?=
 =?utf-8?B?elhveTFuRTg5Z3cwSitKNTNHZE1hV20zOW0rNyswV2Y1UlpqL09wTXJ4MllF?=
 =?utf-8?B?UUpVM2FrMHNpVTY2dTExR3lsM3dqMlhTUVR4eUxhWmM4K1NmeDdwcDRkWUNZ?=
 =?utf-8?B?WXNyeUJ3K3NtU2VaT2xxTENwOHE5SDJLQzByVWE4ZXI1SEJtUU81eE5BcFMx?=
 =?utf-8?B?WFlXZ2xRTjJXZVpnQytRMVEyeGZ6Q3E0UzB2K0RZZTdGNGxrRXZJYW94Q3kz?=
 =?utf-8?B?Mjh1YW50Y1RBYkdIYldPWkZnNlpDb1ZCUC9nRG51ZGdsWnZxUXZIVENHQXBl?=
 =?utf-8?B?aUtSNVBWSzJCbm4vNHl4YVl1VlQzWlZ3SmpWc0lKTTN6MUpNTUJJM1lxcXNZ?=
 =?utf-8?B?ZVJ2UjV2bUcvZHBFRmJwMEEvMWFKMHlONk9rTkUzRXcwekNFMG1BMGdSbFkr?=
 =?utf-8?B?d1dRQ21ERE1neVAvRWVoTFFtWk1nWmdiYUp6KzN2NDNKMnd4bWxWdEJlcng1?=
 =?utf-8?B?cW5DK3hJM0t3Z2hiTDREMmtacjdWOVdrN05mZm9YWlJneTFIRnQ3WFgwY3NF?=
 =?utf-8?B?V05taHhYaktIYTNHL1plTHF5MFRITFpGTTlyV1VFd0M2SHdydWVEMFpJSUZP?=
 =?utf-8?B?emUraE9RQXkwWGZHU213dGh4VHFWM2VwZjgrU2FIMHUwdGpxYXZKQUN1Rlgy?=
 =?utf-8?B?SmxPWnhmSmxlTEVEczA1US90Y3ppWUs5MndhZURXYkVLTWh4ZGJWOVMzUHR1?=
 =?utf-8?B?eS95RXM0ajRtZmxTREdYS3BrNjNkOVFQM2I5cndLZkI4NlN1MGVqY1VqZUhr?=
 =?utf-8?B?eGV4VGtGZ1NnZFJ3Z3R5My9EV3loRk1DdmpRekFiZi9tM3dYdkkzWDQ2Uldu?=
 =?utf-8?B?ZHZuQm5VelVGczRmazRQMmx6ZU9vcTVEajZVbmpjaURGRGJnYnk2Q2JpQTlq?=
 =?utf-8?B?UUtidEwwNW9kVE03dEYrOVpJNWo1VlpKYWZOVmlxTnViWjc5ZUkvTjFPejht?=
 =?utf-8?B?ajU4ZEZOWElwTFZwa0JhVVA0cEh4MXpYaHo4Nm5DUDNTcWFXRG40aGlWWExN?=
 =?utf-8?B?c2lnREpISHQzaXFGcEJ2NkZaNWpITzNuNHhPbWx2UE0vNlNlV1ZLb1BFSXho?=
 =?utf-8?B?N2oxVzNnZCtOcEFYQjkrMVlZelJ0WXlSbHhXeG9BQWdGK3F0cUJ1TXd5amR2?=
 =?utf-8?B?NFZLS2RJZWdVTjY1dnpDNjlhWTk2ZmZTQVo0Z1pnT0E4anVtNjRaVDJoNGlF?=
 =?utf-8?B?Y3VidSsxN2pORklsbk5qY3JyTmJ4bHFuVXN3VkpaYS8zNkgrTHo3c3I0R2p2?=
 =?utf-8?B?NWdRa2w3MDVpdno0TjhiSzRDa2dqMWZ2RzViOUFGWHdGT3R2eEZxMFVYUGRn?=
 =?utf-8?B?ckFMaUVQOG00UG8wSmx5SXk2RWh4Uytvd05XV0JhM3ZUVWVWbzBGcEZkTlJt?=
 =?utf-8?B?ZzlzdVR5bzA4Q0M0c0lSTmxsUE1lcnkrUTk1UDRJNjJHN3VRTHA0K1RRM2VG?=
 =?utf-8?Q?D5Z2yjRr5Gd/P7/ktKE9gPLBXOjoj8sJUQudNtoaMWvj?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4dc8f1-4df3-4fb9-be1b-08de21da89af
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:59:23.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmTxKJ7xPdONrCx3VZ5QBT/ZXWKeXIp0IgvKlw40yY6nYsIYYtrySNkorhqBWSjH69KYoUfzP0UyD5zM0efXM58TZtBkeGUCcClTf4qQ06Q7iGk4BAERuB9c2JSO7GNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7271

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex3 SoCFPGA development kit is a small form factor board similar to
Agilex5 013b board.
Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
of CPU cores — Agilex3 has 2 cores compared to 4 in Agilex5.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
v3 change:
 - Add agilex5 fallback compatible string.

v2 link:
https://lore.kernel.org/all/97fea9a15bfe2a3d52d5b75bee6bda25615422e7.1762840092.git.niravkumarlaxmidas.rabara@altera.com/

v2 changes:
 - Use separate dtsi file for agilex3 instead of using agilex5 dtsi.

v1 link:
https://lore.kernel.org/all/aa19e005a2aa2aab63c8fe8cbaee7f59c416690f.1762756191.git.niravkumarlaxmidas.rabara@altera.com/

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex3.dtsi |  17 +++
 .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 127 ++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 391d5cbe50b3..a117268267ee 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
+				socfpga_agilex3_socdk.dtb \
 				socfpga_agilex5_socdk.dtb \
 				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
new file mode 100644
index 000000000000..4e55513d93c4
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+
+/dts-v1/;
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	compatible = "intel,socfpga-agilex3", "intel,socfpga-agilex5";
+};
+
+/* Agilex3 has only 2 CPUs */
+&{/cpus} {
+	/delete-node/ cpu@2;
+	/delete-node/ cpu@3;
+};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
new file mode 100644
index 000000000000..76efaac82e27
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include "socfpga_agilex3.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex3 SoCDK";
+	compatible = "intel,socfpga-agilex3-socdk", "intel,socfpga-agilex3",
+		     "intel,socfpga-agilex5";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "hps_led0";
+			gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "hps_led1";
+			gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00600000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x00600000 0x03a00000>;
+			};
+		};
+	};
+};
+
+&smmu {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.25.1


