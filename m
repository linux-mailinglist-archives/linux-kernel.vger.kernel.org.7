Return-Path: <linux-kernel+bounces-886646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC744C36292
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C902D4F5D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92B32D0CB;
	Wed,  5 Nov 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="W16ET2FR"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021073.outbound.protection.outlook.com [52.101.70.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01895246BA4;
	Wed,  5 Nov 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354176; cv=fail; b=s5LeBy7SpEFSLAd/rzkbnAPtPvDiNos4m1rL0D9clDfBWlDGzbl9I9BGXXE3KV0OtkXlw4LSdoY6ESx1B8QEwOAwEdjN5QheszEMqDrhSkyD7btZfT9BiO/2IBUQsqqdkl7yBBnf7l0qaxRBApxhAVgEEHZ2SQJiynPQ+YXGwnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354176; c=relaxed/simple;
	bh=PMyVIG8XmdOG8gK2UtZqXQr8eMBxLe9XwXR1loBfn1s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aj0pH35p2Gebidpy688ABfTsKGx7Bzfwd4/qKs50gBQCPGOXQQquaQFAG2o39fDmUSdMAsXAGe5W+/ATCLmTxAAoiowe9P/9Twvwi0tSp/KoMiB9IxJPQi0xhCpGtdu9W6tJU1A09RyUTkFRbaCVqjO81zMEaJlZf/V87engoMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=W16ET2FR; arc=fail smtp.client-ip=52.101.70.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+fmenDp9dD2X7/UT2MwxfYyh/m1vYZRaLqkXrepEN1UWZJr9Assl5FQweJC5lHyLcwOkoCKrWO8mS6Dwans+5o/dV+9VAULuyQlJBG7QweYtBXNnXjPbRnpRoUNioUitYUKOGpgZh16h6uxODkbiuyhEaWfYGRtfNaq6a2TmwJ/CXOy4yYDkIvxsVJzWCxQS6tF6TwaJHePKGPPRoCpPEZOx1LgpfOAz3AgCAvx1LwAGyqtLSEMQDj1e30jGUcDKHu7wDURqfbbXLZ5RKC2j2tjgXeqNE/GVJ+LoRXdom3PZMQ6tOPYtjiW19TkcuDcz99qv5CYdX+BXrc+4Iss7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLUW1xxtrrgyjakkmNJw+id45st+fOn0JJkXCFBSmUI=;
 b=IT7XQRuBzXco7ycuyCzke+Ml58KOFGs0cQ7B+L7pxQxFFdf2xGxfGxzKBdB9YOUCVRPLyIOEIBoiv+HXik7oyFG1nkMfacxAzUzzRcZ1FEjhvzNe5P+F23Z/s+zqrQIFUzIk7EVACsup1KV3FMsiqdWXB6jz/yQZQuoUrFKfLJn437JaZV1gh02KW2IMzWoXWRiUwNW8zhhr8Hy6VV/L5280f8kHFBuejiItkEh753s7Zhk1HdLO2rcqHUu6yrIAtnnY1KpoIF5mqlJejdWqgZOxsDedfM6ECHxpoHYZpjTbcBK6OhTO+n6im7ks8RM9emyzNlzDdwEw+8oMbA2GTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLUW1xxtrrgyjakkmNJw+id45st+fOn0JJkXCFBSmUI=;
 b=W16ET2FRBUaLhkwP7CArGlXBMMClZrVsyBohLNMxq8540fqL9a1UcE5EYE4oJM2HVEXgenl5snmD2IV7BIBuVUE8m5PC+KTtcD1vUoUOhVLBGQbSsP3p/9Bq4fhZvYsmYYcSMmunJVCmIpe+WI9Nn7fikLMnyyy2qQa3UC0nYCeJeOtKqb3VJjBgG5WfTiThVKxcj4mSGSv+Ub+5plsCLZfQgjoyTut8Fh1Ug3bakaDrksV/4+XOvlASOi/1LO/1sw/VsCQN9U2cgTeXijAioT3c3zblA4CzZi9B3iionmUv61FrzOsEqT37aL3fbQ1Mj8CGD6VgYXTykrb7h/kDyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by PA4PR06MB7215.eurprd06.prod.outlook.com (2603:10a6:102:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 14:49:26 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 14:49:26 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 05 Nov 2025 14:49:12 +0000
Subject: [PATCH 1/2] dt-bindings: mux: Add description for enable GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-add-external-mux-enable-gpio-v1-1-e59cba6f9e47@vaisala.com>
References: <20251105-add-external-mux-enable-gpio-v1-0-e59cba6f9e47@vaisala.com>
In-Reply-To: <20251105-add-external-mux-enable-gpio-v1-0-e59cba6f9e47@vaisala.com>
To: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762354165; l=963;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=PMyVIG8XmdOG8gK2UtZqXQr8eMBxLe9XwXR1loBfn1s=;
 b=poI+1NAebvYR6nUrZCY6Ctc+rbezzU8pOucF7HFb/ZxrG7WMg+FB7krlOk8gTF8/frfPtEXMi
 QoeqCg6LPACDP+Zmskp3O4lLqxjHd4rVZ9uuH9ZP6pYUUbSi8V1lJ/B
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF00003826.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:5) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|PA4PR06MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 1122f2c4-fb82-4ed3-d486-08de1c7a8437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0ludHo5aDFiSUpKVEdJOUVmY01va3VmMytCczdNT2RQL0kvdTNYSXUvMGFT?=
 =?utf-8?B?KytkYXk3dkhzclcrMEJnVnB0QWJJYlhqemhFVVRObkFuTTZFN04yTWplUUh4?=
 =?utf-8?B?U2p5TXR0b0U1c1ZYVkRWYXYwMGd1MkMrN3ZGR2lRM1lDQmN5T0RsNmFQNWVN?=
 =?utf-8?B?dnI2cmUwOHpwdk1KTkoyZE4wcXFzVmJHVk9nL2JIanZsczFrZ0JueGpZUUs0?=
 =?utf-8?B?akd1OWZ5M0g3QTdtK2xPd0dlVmFwY1dQa2hCeDFrc3ZnNCtLeUFteFA2OHVa?=
 =?utf-8?B?RXF2cHY1SFhlb2owY0pLaDBHT0NtVUlVQ1B3WUdzcjJPVVJjeVU0QkZ4Wnl5?=
 =?utf-8?B?bVgvMWV2Q2YzUUpHeG45OEtnOE1zQlJVQitnWWphL0ZjemdhbENWdXViVjRF?=
 =?utf-8?B?NWY4d29HTjBSU1hIUFZObzZqWFh4VXlVRE03eEV0aTNRRFNRTktoU2xmYm9U?=
 =?utf-8?B?WDkwVi82N3pKREFWdUlJd3d2cXFld0NTNWxHdlRxNk9jaGU4eE4zcmR3eGEz?=
 =?utf-8?B?U0piMHQ2ZDgzMmcvSEJydHpQV1pkK0FBMkg0TzJhTnI1eC9SZnM2azNHQ2g1?=
 =?utf-8?B?SXhyM3lkQzFKSGtvR2gvSFBTSUNEUHJWdkpsUExtdDhpbzVOMEMyNnlTczZi?=
 =?utf-8?B?NXljTlJ6SldyNk9yd25ESmpQaDBENFJmUGtaVHJ1WUU3ZHZFTHZaVk9jY0N6?=
 =?utf-8?B?V2hhc2I0OHNNV2dEekZJRzFyMWdNR09DQ0FldW0yWmJzRDBZSTgyRXJMV3Bz?=
 =?utf-8?B?RUlWYlVCNFNNRW14Yk8yYWxOLzRhR0daTkFoTVVETXZWcUhBbnYvaHdIYitk?=
 =?utf-8?B?UmE1SWRTS2dPM1ZyWGtveVcvSGp1YVJZZkZuUVJkb2VoWXJQNE8yNGZJQVFP?=
 =?utf-8?B?ZUxmY01iNTFTTzBTM2F4QUNNSEU0R3p5TlY5Uk9qTGM1UTJieU84eFpqaWt5?=
 =?utf-8?B?K3lQc3hIaTVRTXZWbnBkWWttTFI1SVdjcllGM2t3VUNBVTZsSU9wZzR3bWVQ?=
 =?utf-8?B?T0JZNHBRelBicnRaLzJsa0pSMVgxSWY2aW9WbkpBbVM0QmcrTUczQzJmYkxL?=
 =?utf-8?B?dk9SeitSWGhsYzErRUtwamF0L0ppaUdKZ2Y3WTRsQzJKSlIzTlhnZGZqblFG?=
 =?utf-8?B?Wm9EWFI2ODJ1L3p3dG04ZXVnZGJDcmppKzdMNHdXblg2V3JoNGpCU1JMWEpC?=
 =?utf-8?B?TTZpd2VNR1ZyRE1hY3dvZWxGd3BiekJFMFRqbkZxYW9wVDRLZmVmMFpRcnk1?=
 =?utf-8?B?czlVdzBta2RaMFJvbGoya0tjd3IxK2cyb2xxZ1RHUXpMVHJQOWRTOEFSUmhr?=
 =?utf-8?B?OXhZWi9UU3FjejNvQVdDZ1cxRUp3elVTR2lXc1E0ak5TcTZSbGhaSW1UcGNt?=
 =?utf-8?B?aFptaWNtdDRxR3Urbjl2NG8xQ2VsSG1FbG5TVXNCMzM2R3laVEVNcVlzOXhQ?=
 =?utf-8?B?bmZjdmkvRXo0dGtXUGpMZnk3TzVLektlMEM5ZERiZWJBckZsS1RUMWEwTGRS?=
 =?utf-8?B?S3Y2c05NbEdZN1hCaVlHdm1JSlg2QnkxMEh6VDBVdjJUbFN3VmtmOFRrdzZR?=
 =?utf-8?B?QmpMaTdxcVpBdzl0TkNLYituRytJR1ZUQXdsazcxU3Bham5ENldVZmZLeSsw?=
 =?utf-8?B?ZUxVZlI2ZDcrME1yOEVzSUZqU01aS2ZSdkZMZUlJS2VVbUxTV1RYSk1weXRq?=
 =?utf-8?B?eHlUU0hFQmMwV3VScUJLYVBhQS9ZTzBOTjdLRWRVcnl2R1E4VEF6d3dEUURE?=
 =?utf-8?B?eHlqMVpMZUxHUmV0Z2FLWS9pUmVBY2hhemZ2U0ZLSmdZL00zNVBzYzFqblpY?=
 =?utf-8?B?MXlhR3YyVjdRbSttdTBTek5yaWdNeXlCd0c3OUs2Umt0NUtVT1pIMW5yNFV2?=
 =?utf-8?B?ZCtGT1dKMHczSUI0Z1BDNjA4czJ4V1kwS3pMVWVDQzM1cFZNb0lkVW13ZXdo?=
 =?utf-8?B?WUJwUC8zNlBIY21Rano0OU1PMXF5WEF4NVJsTGhRUTByay9TenR3ek14MU9t?=
 =?utf-8?B?YWlSNU53WUlqWDlHejBRK3ZZK2ljLzRKK3hhc3pEYkhxditzbnpVTkRuRTc0?=
 =?utf-8?Q?aylnOJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHV3cU5VTC9CNmpOOXlUcFJqL3phUEoxSmZFVVdNcWhBcytpWGdHdjU0WXJG?=
 =?utf-8?B?VFlDQlhIVmVLK0tkNFkwN1NFTWxYSHBrUklMOE1qb290TU13RHRxSFMvdWQ0?=
 =?utf-8?B?SVFDaDRQTkgyeWNaS1JkT0Z5NndPQTlFSVA4elZyMW9CMlJURHlzWG9hdHky?=
 =?utf-8?B?SDUvNWRqbmlzVGU4cHA2VW9DTFNkR3VNdGI0aDhRaFpYNXErS0w1bk5WUkF0?=
 =?utf-8?B?eVRMNG00eDZJVUNVWGhNL09GcHFndTVNeVZFSjNSWEtmSFBrT1daODNRV0hN?=
 =?utf-8?B?L2ExdUJQeGpwMFpOd0ROR01jaXhiY1QxSk1ocVkzNEc3RnlJSXZheUV2WHNm?=
 =?utf-8?B?NjQzWjRtaEcvYUFXc2xzc1B1QVIvbSswbnJiU3lySUd2bDhpelRtYm9OdUpC?=
 =?utf-8?B?N1VkNDlySDRXK1dmTkw1M2hxNVRMMXhqUVRjQnFLQ2VmNGN3TlFlQ3JKdVUx?=
 =?utf-8?B?eER1ck85dGl5WDBqMWxqeWg1Y2lWN0NvNUJrNG0wOS8vOHd3dldxU0dWMzV6?=
 =?utf-8?B?SVBjN2xNRTM2L1hoOUN6WXBtZnFmSVFXSGhVQXR3NThtdWV2ZnlGeStndHlz?=
 =?utf-8?B?b3NWUUZ5aldWUTc4Wm1Sb2xsUElVd0NUUnFmVGw3UjRNK3I3bjIwVTBBYUdS?=
 =?utf-8?B?SS8yTlV0Ly8zZ3IxMWpXN3FHUHpjakI1WGRpQWRZL2d3L00xUzdrKzdORnI2?=
 =?utf-8?B?bTVpMUxIcTVPV2t4azArcDBLaUtkYmZTeWQrM3ltRjF5Z3poczVaVEdTSTlR?=
 =?utf-8?B?aU1seGhhSzZ3VEQ0bnVYcXB6VitmMFFPM2pYSUlmUzdVbDI2aTZmblhIQzZW?=
 =?utf-8?B?ZkpDS2R4Vkc0aDlmOXhQbFlBc0crVjJacmlFTFNXWFozbmNxWERuUjR1Slh2?=
 =?utf-8?B?VFg1aUlTMi9BNFc5akxTcjkwZW1ZUzVnU0hKSDA3Q0hLbmE5YkFwS2szWlBw?=
 =?utf-8?B?WU9sRlpqelV2U3R5S1ZkQU5LT2RHWTlndHRYbDExaHoyaGRLK0g0ZHdZdVc5?=
 =?utf-8?B?aEZNSU5nQ0RrWEFLdlZ6RzlWVXI3YXc5T3dKSENIcUJOVmlNMnRJRUxqTFdi?=
 =?utf-8?B?S05rczVobENnZ2RRVXRYeWdmRnRBUHJjdzdsd01LVStKYkdjbDFKQW1EMWhr?=
 =?utf-8?B?WVN2NWUrdVViTGkvdnpnY0RkRXMxL3N0cEpuM2xYVW96VStvT2ZyRThmb2ox?=
 =?utf-8?B?YVpkbWdhd2R3N1F4a3ZFR1o3SnplL3hzZERaQTlocTNCVDhQbDQrTVluKzl3?=
 =?utf-8?B?RXVwNmVhc243VHEvTitySFFaQ0xBSzZLNVprRUMya0dKcEpFWEttR21Idmt6?=
 =?utf-8?B?M0tNQ1RpM1p1UXlBMVU1TE1lTkp1MzExWjdxeHI4MG9WdjlaVUZqaHhpNUxP?=
 =?utf-8?B?WmRTUERncnYyN1VLdU1oYzhTbUJ5K1hvckRCWERLNlYxL1drM2YzNjdYTElz?=
 =?utf-8?B?eDI1UjJUempJRG1zMEdtUmVYVGcxZi9Lays1SHRDMU8wM3ZSdHdwd0k5WGdx?=
 =?utf-8?B?YlhIR3JaNGpYZTF3RVl6cS9kRWcxc01CbCtMQzltTzdERVBLOXFjRDgwQVFU?=
 =?utf-8?B?MUMyd0c3TUszQzhqNm9vQ0hiUHFBQUZ4RVBPU3c2M1FndDFMbmE5QzFlcElv?=
 =?utf-8?B?YTMvK3E4ZUNkcWUxMDY2VWlYczIvenRHMTF5dVlvaWc0T0tUS0R5bHJkTFdm?=
 =?utf-8?B?WG5MYm1sNjZVcXJCeEhqWTZxVEd1N25NQkk5VG80NEZ2UUlEY0lnb1BNdWYv?=
 =?utf-8?B?QTlWSFBOQlFMNnJSdUcxVXlJaWhmUkNFWVVRb0VtNSs4a1A3dTZwaCtpS0tC?=
 =?utf-8?B?cE9ubmN4a1ZQT0R6VDQveXozUzJ5a2lvYnU4YU9XOG5YZmNIN3NrQVhTVkVJ?=
 =?utf-8?B?WnA0OXRTK2NweGExa1JLdVgyN2RhQzVENlM2ZkJSZStoWlVVNHBBWWZkdHpK?=
 =?utf-8?B?K2d2VVp4b3JoV1ViUGZtdHU0UjVrUC9UTVlyeDhTa0ZoWktmeUFSeC81Z3ZG?=
 =?utf-8?B?RGhPRlQwWlRMUkJQMERQN0FsNjRzMzV1aXBualkrcUZmcFZxL2dTTFh6cGJo?=
 =?utf-8?B?eTJoZVdVUEpZQVVBYXE5YjdxQmJZcmNpZ3c5Q2NrSmFmeEZ1bERLZERyVlN0?=
 =?utf-8?B?N3dqRW1LUS9hMVlCNmx2djVnK0pvUFR4S0ZzTjI4OUttVTVpUnpSUzJ0ekoz?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1122f2c4-fb82-4ed3-d486-08de1c7a8437
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:49:26.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxY8+VXkvLU+2QmmcF5Cv6k0xJ4xcP4kgR1zSsh0NUrQl7jn2uTiCcrM595u7G5XtcOqvj98dzODSGQPhnijhYj8MTDHYwzLrh1Uv1feeEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7215

Add description for enabling GPIO-controlled multiplexer
GPIO pins, according to the state of the mux idle state.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 Documentation/devicetree/bindings/mux/gpio-mux.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
index ef7e33ec85d479ce57c5fe4a780f81a08a6ab6ba..5fb26f4b65d5a24747e515f6ce358eecc36f182f 100644
--- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
@@ -29,6 +29,11 @@ properties:
     description:
       Regulator to power on the multiplexer.
 
+  enable-gpios:
+    description:
+      External gpio output that signals mux-gpios are in a valid state.
+      Logic low when state of the mux is idle, high otherwise.
+
   '#mux-control-cells':
     enum: [ 0, 1 ]
 

-- 
2.47.3


