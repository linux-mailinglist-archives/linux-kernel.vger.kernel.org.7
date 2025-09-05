Return-Path: <linux-kernel+bounces-802527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA6B45328
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD8E3BB070
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F022129B;
	Fri,  5 Sep 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="KXfH9xw8"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022101.outbound.protection.outlook.com [52.101.126.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFF1F4613;
	Fri,  5 Sep 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064635; cv=fail; b=KBFn7LrhLhYSZF8o24r4WXvqRMk0MFRkZWkIsLxPsXvdD35WauGXHg6yXNpdpsE3yaIYu7JJQ+a7tnkzmCDG6+9fA9cuUGSP3aTplbXr4oD4X/GR/HdElahP6PZ3nHUS+7wVubB1KQOIlcvEuIqKo2UKZS97n3qSRsVGMeLrFBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064635; c=relaxed/simple;
	bh=hoQNkvJnWmLK0JmamlkRfaF7IWjBxT9hpoUNqhdQ4Q8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YZ+t2PJasxVU3vbr1C2c+28FIGvQUu8VAoj6rA7y52Xs3/hwuPFsk8gFynI2Y1Lij2xcl3nPn0DslgOZuV8W2JKzIYS6d8nA4emFyBGAuGtPTXra3f21Tt/Dq2NdNg5pHhr73UqaexCc30yucKUgw8Y/ej/GkrLUfDd0yH06kEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=KXfH9xw8; arc=fail smtp.client-ip=52.101.126.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA9Q0GfwYWliweZLrKWDgnlFlir2pqFaXmlrtC94ppM+LQm308XtzPd5eWF8NOrS8TRwyVjT1FccS91XEEXaLL+qnsh8ZjHnEY8Fw0pjYMo1H7ZtsdgevlqxAsAwLRjYvkcNywVrNKt6x6hDRFW07iT4c3g2QuiHlrIkcs8q4q5g7UOMdPzV/DG0LkQxOfoGCZJsO4Xc3DjuNvs/X0c48iWziGIb+XbNplvHHEV2WBCYw3AgyhX9ihUZHiT+odU3XO6ZfogOdUmQdrCMLeL5lWJyB94krmxxlyS8IH0fFPg38cSEjlArHgOXf3AqSgmue99+lSlmbH1n94CgAksumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8FKnULOHC7+7BvNxcPIDyUndKIrDbyGo5yPkbk0f28=;
 b=peb24V08ppghUaxgawubHiDWHjJ5wdJV7lGatRafvjlEM8QQfor+URPBFU1nKPDI3ID9Hat8Qiu/MX6telMtURCQ25tP9wCmdPMVBmmW0QbMS3d1Y4O4SUjo/5FPuDh9ZpBTK9Son0hm+Yi2PdujbBeGA0yfvZT8HOLdQZAA2ApqrUGTNk8/RRyqzoeplyWqkMROSLre4vIy8skcb6a2neEH6XwlYV6GQmO5uL+lH/NXTPaiw79obqlAefJn6vFXAuhUQbsFLPdvPN+Ym3zOlB03Z61hqQmATgyxuPjHClIEJ6Y1oOioT+DxXWN7BjbSj4QXcnEz+N7VROThPBMWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8FKnULOHC7+7BvNxcPIDyUndKIrDbyGo5yPkbk0f28=;
 b=KXfH9xw8n79aekupH60HkR19hZFUCVjWaTbNPbgE2JdqsKjLaKZ/xyqmEGwXwyrvnH4Xm01StW7OAYgEBn7TrQyffeT4nbpWV1eOMEpq5i6VAg6iKVtzD4JesDeMonZc8lwy7OBBoR0CZSHk9bpo9jC7v+T4sg1wp66rVjUQvBGKwxRQQoyEZ//DMcMTPF8nWa8wo8tWVrm3xzjdbeW5wWNWs5SrvWVsnztTIminTncQU82hN2fBqzKmAA5jP0hTSNvKXDUV/+BELD5rv8d3f496+d6fq4xShUdM71q9oVIsxsZE3ckHs55jFDBrhzEev3BwSVWjFDoaPcxgj3JUGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SI2PR03MB5786.apcprd03.prod.outlook.com (2603:1096:4:150::10)
 by TYZPR03MB6895.apcprd03.prod.outlook.com (2603:1096:400:288::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 09:30:29 +0000
Received: from SI2PR03MB5786.apcprd03.prod.outlook.com
 ([fe80::3f37:cacc:420b:9b86]) by SI2PR03MB5786.apcprd03.prod.outlook.com
 ([fe80::3f37:cacc:420b:9b86%5]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 09:30:29 +0000
Message-ID: <5993b59e-af9f-4738-a5ef-dc5c324b4f08@amlogic.com>
Date: Fri, 5 Sep 2025 17:29:56 +0800
User-Agent: Mozilla Thunderbird
From: Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH v3 2/2] clk: amlogic: add video-related clocks for S4 SoC
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com>
 <20250905-add_video_clk-v3-2-8304c91b8b94@amlogic.com>
In-Reply-To: <20250905-add_video_clk-v3-2-8304c91b8b94@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0364.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::8) To SI2PR03MB5786.apcprd03.prod.outlook.com
 (2603:1096:4:150::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5786:EE_|TYZPR03MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 83661e6f-0341-4f10-f336-08ddec5eda51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25PUDhaeWNxeWNlVTZSay9uQ3ptZ3JHaVZIRFAzNjh3OG9GZXo4aDFYV0Uv?=
 =?utf-8?B?a05iWExTemJIQTdLVUpwNTlkM0lwRVVNZFZFdDBjK29meldmNHVFRGYzM0lV?=
 =?utf-8?B?TGJjWk43QkNPekI5cm5vM0lHN29TMUxNbDk0cjc4eTU4OXh4aVh1SW1FNC85?=
 =?utf-8?B?aUl3Z2lmRUdhK3grb2hCN2tRNkk5UkxsUGZVSXRCY2RnaG1CVFVtTndNNHlK?=
 =?utf-8?B?RGpvT1ZvdG4xNHU3UEJhTGFZN25vT0o0V0pFd00zTU1YVjJ5cXgyM25BYWl6?=
 =?utf-8?B?Ymoxd3dkMTYvRTRpaVdzNEpIelVBVE1nb3ZNVFV3L1dDYVVHNW1xYlhJZkRu?=
 =?utf-8?B?aTY1L1dXRCttUTloMlFsakhwWGM5NmNQUTNzTWFkZW15Q29LSHVlZDcxZUkr?=
 =?utf-8?B?OGZVcWZYeFhEN2RneVJOYi9ZaHRqVy96clo1Y0xRdFFXa1I3OTNOR0FHY2g4?=
 =?utf-8?B?V0FNQjcwN1pyR1hSZ2FFTVhWcmZPMERXcTdwSE9XMituR2dCTStLaklMbGhv?=
 =?utf-8?B?bGVjYnFUQVVRbFdtU0wwcUhZSjNaMXBneDBrdzlUcjdJMmNMeWxWSVU1cldQ?=
 =?utf-8?B?MUdESU1rQzdHWDRLSUtBZmhMVDR3R2JHMG4wdlZZd0p2Mk5MeENjc3hRa1Fo?=
 =?utf-8?B?RnlaSXlzYy93MXhIRThmWnAyNHg4dTJlSk9CdUF2eVZVckgrTHlsVjNsOEUr?=
 =?utf-8?B?U255bUxwZ013Q2srcnpZdW1WZUEvQnNRZ1NoaU9iOC9GcUNKeXptSG5sN1Vo?=
 =?utf-8?B?NERMd0ROY24xYlNPMDZrQTd0SE91eEpSZHR1b1FRSDhDVmNmU1padkR2NUZT?=
 =?utf-8?B?dDBDRU93cjFtKzMxT2swTVVSZXRSckNsdVFmNnZNUTIvNVo4ZzhyUGR4Ynlx?=
 =?utf-8?B?WHF4NEM4dGRoWUlLYkFDYmtqbmtrZE5ZSkxwWWhMbUFEOWZla0Q4RmZUOENJ?=
 =?utf-8?B?dFlnazlrbXJnZU15dG9KUFhHWkZzNE1nbmZnSkw3S1AyQU04QW55alF1NlNR?=
 =?utf-8?B?eUFKZmEyK0lKQnlaN0FtQlZsZWloZGRscFhSUUVPY21BVndxMGRuL3gxK3hE?=
 =?utf-8?B?ZndUajlQdjJIZWhGMXROV0ZKTWlDR3U0N25WcGlNeVJYKzRoMHk2Mk1RM3pt?=
 =?utf-8?B?K1dITlA2VDg2cjVtRjFXK3phWjM5Uk1NNmVKRW5LRmpteU1YZXltZmZaZHZz?=
 =?utf-8?B?a1YxTE94TUJWM25MV2NKdHJqR3N5TmNXekRxb25rYUNxZUhoTldtcytSbTdG?=
 =?utf-8?B?eDhXNDNMWnV0YkozVnQvQ2RZSnA5N2hzbElobEVHLzB0OWpUWGZGRW1XZ2RG?=
 =?utf-8?B?cDBGcTg4S2hCQVNrN29QcjVwOWlTcmtZclhPNllaTnRZdG1jZ3ZzZ0x0c293?=
 =?utf-8?B?RURwd2o0b2Q0OEc0UE9MQ3RoTmZ6Y1gvUXFjUWduRVNITU1aYzBIRFE1SURz?=
 =?utf-8?B?c2hyZGV2S0ZQOGZKWE44QmZzenNlY0hFVGFIS3FTbkJodnlvWU5jQW9HMGxG?=
 =?utf-8?B?cWh2VUVWcHR6R1llZ1Z5L0J2bTRabVF0Rm1OOEFPcDdFdjQ2MS9JZFBRL1RJ?=
 =?utf-8?B?c3pZSDQ3NDFEcmJHTkJRRkJkK1VOenErSnlqYXhtUG04OFdpL0h0SEc1Qy9l?=
 =?utf-8?B?WEwveUZGMFM3NUJaZjVnb1JPam1VZnloVERBaUxEVDk2c3h2czNvV01QenpN?=
 =?utf-8?B?ZTlZNFRYUHVtL1V1SEoraWJFRlVIWG1lVGlDRThHSEZUWE9CNUlJaUwxeXBu?=
 =?utf-8?B?Y1B4V0s0VW41dTA0VkJZMmIvSEZ4TXB0Y3hzeGFGS1dIVG5VOUgzdDNDcjZh?=
 =?utf-8?B?R2p4T01tZGhqN0Z1czR2YWlOYkpwRmlGT1FJTDViZHVNSHBaSTdvbXBuVVdX?=
 =?utf-8?B?MkRTR3hNdVZtS0Y1VnJHTGQrVnFkZFZabzVST1RTcHZCQmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW5xNkF4ZnkxbFVzVFkwbkVNNG5CV2c1NFh1cTRzZUlvblIvcVQrWGE3REVi?=
 =?utf-8?B?THgrMEFET21QUk5BQjV1bW1lMUVUL0JvWUhVRTU3bzFJMVdqRFFHTzJzZzRv?=
 =?utf-8?B?V3FuK3NTZ1phWjQxNi9SNkl6TXkyREh0NmlKN0pwNFB6bHFzcjNYWHpmSTgr?=
 =?utf-8?B?c2hiUXBwemFUM0lMOFpIb21hVm02bzAvcmc1V2RNTW9nalJraEQvbm5NVHBN?=
 =?utf-8?B?M3ZXOVlqSlNTOTEyMlpOc1Z0K1Zrd0JXQmVkU2hIU1hIRHI0U2lSSkwzYmRz?=
 =?utf-8?B?Vmpvd3BTN3R2dDAxMjBDaWZjUE9HcU9Td202cktMckIzcGcvcXVFZ3BmaG9k?=
 =?utf-8?B?QXlZUVd0QzZJWXEvK29CZ1c1UGltRkxvNlYrcllFUU51bVhhb0o5MlR2ckRE?=
 =?utf-8?B?U3NvMkJ0WmlpWmZmWFhXaVlDWmRRVEtaNWVubjdaRENtT0hNMGV3U0o3Qm1I?=
 =?utf-8?B?cUtpaE9CcUs3VWt3eUlJU1ZlcXlJdU5lUHlCUFVVenIvR1ZJdmZUaVlSTFVj?=
 =?utf-8?B?L05URGl6Sm0yTGFWN2RWMTZXZG4zbE5RSDZONW5NQ0lyMy80Rm1YWnM3ZnNu?=
 =?utf-8?B?bDNlTGZoYkQwd2ZhVzRmdG55dk9GenI1WEJ1cHdMSE5uUXR6NWF0T3JxNG8y?=
 =?utf-8?B?aVFvcDZEUCtVM3p2cWxUQm9IazhNU25qdnAzSjI3T1B6blVBcUhtWEk0cy9v?=
 =?utf-8?B?SlIrZHBRbXVxb2V0S2FESWNiemtNOTdKN0tGRzA5ajVlRjdYOER1YUxkcitl?=
 =?utf-8?B?Z0xoemhOL0c0SkZrZytSOWEwdjlPa1c2TERFRmNjR2hFRE9kQ1g5SlNlbHVp?=
 =?utf-8?B?UHpCM1NtaUNEQUV1dGljT0pWUXplZ0NiL1g2R3dPNDA4UHRiT3dxUm5tSXh2?=
 =?utf-8?B?OEpvOWNrWEh3dzBVYndwZ0hyOXYvSXAvTFF4cGlsbXR5T0Q2QWtBQTRzaG5v?=
 =?utf-8?B?b2dCay9XaTcvNHhsMWMyVWZna2V1Q0gwRDVDSTB3cTB4M3NIM3Y3MG9ITVAw?=
 =?utf-8?B?SnViVTkyOHpjWmNFcVMxRzM2YjRnbG5WVjl0cG45d2RxanRYZkZ5d0kxYUdh?=
 =?utf-8?B?Z1pCbXpCK1FiTmdhYjlqWHdwMkN1ZDJXR3lDOEhiZUZzMTY5aW4yWkF6MGlI?=
 =?utf-8?B?d3FYdjEzenhBb0hyREhCUy8ySis4T0hxTENZNGg3MHRzSzQyemI3emF2clNj?=
 =?utf-8?B?L0ZZMkdNdFdtSkh0bFVWZEtHeVhEaDhmVGJwSitOMFpSNWU0SSt3YUR0SlFr?=
 =?utf-8?B?amJVc3YzZk5PSjVqVnNiZkJzMGJCbE1SZFhkSnV4eFdNSWFKU1huVDhnTXlW?=
 =?utf-8?B?NnIwUVdtdWVHZ3llUkJJOEFtTzkwQmwvOEc4cEpaZnRjVVJYUStYVTNDcWVk?=
 =?utf-8?B?S25rVVJiYW1IbkZxd3N4NjdoTTJqY2cxZHFsaVhwODhBS2JkSE93YWIzT2lN?=
 =?utf-8?B?bFY3ekQ3WkFiMWVxNzZIMkZaSEI5V2FaMmMvTGNLUHliN29udVhQMWpncEh6?=
 =?utf-8?B?U204czNDT3NibWJrWHhMeWFEOFZwNEduelljUEdaMENHVGdsbW1pN2gyVkJh?=
 =?utf-8?B?QS8xaENRZCt6RVF6YzZHYmYxbDFzTlRrTjV4dVNhNEpJRlIxN3ZFREd1SmJX?=
 =?utf-8?B?ajNkS2JHbmFFYUpjemJMdlN5SUFjaTg3ZjFoSmtBc2h2Vzk3eGJwL2NUblF2?=
 =?utf-8?B?M0NVanRQbVNYTWp0a1V3SFVWbGpMc0E2cW1rT1lFRGhtOEZlSDBLY3Q0NXhw?=
 =?utf-8?B?REFmRUFrdEdZbFBYR2xDTXNQWS9xakNENmN0WjhLeEtKNlM4V2Z2c0Q2MFNp?=
 =?utf-8?B?REQ5TDN5OWg5NzRORXlNck1yMkhtSnJBYUNCMGtpMGIxaFZEQTVxWXRkUU5O?=
 =?utf-8?B?cTAyVHduUGVhL2VoL01oY2pQR0tvajIzZUczNVFDbHdqS0FqVjdMSWdYb25P?=
 =?utf-8?B?NmwwSTBtYUhaWUlxbWRNT0Yva3Q0YUhzUFlnZytuYzJYS2srSXdwNDFydWR0?=
 =?utf-8?B?WVBGbFBGSi9FSU1uM0lZN2J4NmZKZEJmYThZN3ZkUE9NZ2xydGZVZmZERDZB?=
 =?utf-8?B?ajAyTFBZMU9WNTZYQ2VBRzAvNFd5VGVQZEtrWE5TLytuVUlvSEZtYkVDbjRI?=
 =?utf-8?Q?FPS6I5dGfuQKZs5HznwQ1nHR2?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83661e6f-0341-4f10-f336-08ddec5eda51
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 09:30:29.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkkcsI5Xa336KJ+TQmAmLHGrEgOZKmeFu0pqg1yMfTRvbu6ijGm+D+4Diskxq/Zsw3hZU8nSu7H9F9HxKLbxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6895

Hi Krzysztof:

         Sorry, I forgot to add your 'Acked-by' tag in this version.

Please ignore this patch for now. I will re-add it in the next revision.


On 9/5/2025 5:06 PM, Chuan Liu via B4 Relay wrote:
> [ EXTERNAL EMAIL ]
>
> From: Chuan Liu<chuan.liu@amlogic.com>
>
> Add video encoder, demodulator and CVBS clocks.
>
> Signed-off-by: Chuan Liu<chuan.liu@amlogic.com>
> ---
>   drivers/clk/meson/s4-peripherals.c | 203 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 203 insertions(+)
>
> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
> index 6d69b132d1e1..c0f877ce0993 100644
> --- a/drivers/clk/meson/s4-peripherals.c
> +++ b/drivers/clk/meson/s4-peripherals.c
> @@ -44,6 +44,7 @@
>   #define CLKCTRL_VDIN_MEAS_CLK_CTRL                 0x0f8
>   #define CLKCTRL_VAPBCLK_CTRL                       0x0fc
>   #define CLKCTRL_HDCP22_CTRL                        0x100
> +#define CLKCTRL_CDAC_CLK_CTRL                      0x108
>   #define CLKCTRL_VDEC_CLK_CTRL                      0x140
>   #define CLKCTRL_VDEC2_CLK_CTRL                     0x144
>   #define CLKCTRL_VDEC3_CLK_CTRL                     0x148
> @@ -1126,6 +1127,22 @@ static struct clk_regmap s4_cts_encp_sel = {
>          },
>   };
>
> +static struct clk_regmap s4_cts_encl_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = CLKCTRL_VIID_CLK_DIV,
> +               .mask = 0xf,
> +               .shift = 12,
> +               .table = mux_table_cts_sel,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cts_encl_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_hws = s4_cts_parent_hws,
> +               .num_parents = ARRAY_SIZE(s4_cts_parent_hws),
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>   static struct clk_regmap s4_cts_vdac_sel = {
>          .data = &(struct clk_regmap_mux_data){
>                  .offset = CLKCTRL_VIID_CLK_DIV,
> @@ -1205,6 +1222,22 @@ static struct clk_regmap s4_cts_encp = {
>          },
>   };
>
> +static struct clk_regmap s4_cts_encl = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = CLKCTRL_VID_CLK_CTRL2,
> +               .bit_idx = 3,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cts_encl",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_cts_encl_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>   static struct clk_regmap s4_cts_vdac = {
>          .data = &(struct clk_regmap_gate_data){
>                  .offset = CLKCTRL_VID_CLK_CTRL2,
> @@ -2735,6 +2768,165 @@ static struct clk_regmap s4_gen_clk = {
>          },
>   };
>
> +/* CVBS DAC */
> +static struct clk_regmap s4_cdac_sel = {
> +       .data = &(struct clk_regmap_mux_data) {
> +               .offset = CLKCTRL_CDAC_CLK_CTRL,
> +               .mask = 0x3,
> +               .shift = 16,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cdac_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_data = (const struct clk_parent_data []) {
> +                       { .fw_name = "xtal", },
> +                       { .fw_name = "fclk_div5" },
> +               },
> +               .num_parents = 2,
> +       },
> +};
> +
> +static struct clk_regmap s4_cdac_div = {
> +       .data = &(struct clk_regmap_div_data) {
> +               .offset = CLKCTRL_CDAC_CLK_CTRL,
> +               .shift = 0,
> +               .width = 16,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cdac_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_cdac_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_cdac = {
> +       .data = &(struct clk_regmap_gate_data) {
> +               .offset = CLKCTRL_CDAC_CLK_CTRL,
> +               .bit_idx = 20,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cdac",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_cdac_div.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_demod_core_sel = {
> +       .data = &(struct clk_regmap_mux_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .mask = 0x3,
> +               .shift = 9,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "demod_core_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_data = (const struct clk_parent_data []) {
> +                       { .fw_name = "xtal" },
> +                       { .fw_name = "fclk_div7" },
> +                       { .fw_name = "fclk_div4" }
> +               },
> +               .num_parents = 3,
> +       },
> +};
> +
> +static struct clk_regmap s4_demod_core_div = {
> +       .data = &(struct clk_regmap_div_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .shift = 0,
> +               .width = 7,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "demod_core_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_demod_core_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_demod_core = {
> +       .data = &(struct clk_regmap_gate_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .bit_idx = 8
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "demod_core",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_demod_core_div.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +/* CVBS ADC */
> +static struct clk_regmap s4_adc_extclk_in_sel = {
> +       .data = &(struct clk_regmap_mux_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .mask = 0x7,
> +               .shift = 25,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "adc_extclk_in_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_data = (const struct clk_parent_data []) {
> +                       { .fw_name = "xtal" },
> +                       { .fw_name = "fclk_div4" },
> +                       { .fw_name = "fclk_div3" },
> +                       { .fw_name = "fclk_div5" },
> +                       { .fw_name = "fclk_div7" },
> +                       { .fw_name = "mpll2" },
> +                       { .fw_name = "gp0_pll" },
> +                       { .fw_name = "hifi_pll" }
> +               },
> +               .num_parents = 8,
> +       },
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in_div = {
> +       .data = &(struct clk_regmap_div_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .shift = 16,
> +               .width = 7,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "adc_extclk_in_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_adc_extclk_in_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in = {
> +       .data = &(struct clk_regmap_gate_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .bit_idx = 24
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "adc_extclk_in",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_adc_extclk_in_div.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>   static const struct clk_parent_data s4_pclk_parents = { .hw = &s4_sys_clk.hw };
>
>   #define S4_PCLK(_name, _reg, _bit, _flags) \
> @@ -3028,6 +3220,17 @@ static struct clk_hw *s4_peripherals_hw_clks[] = {
>          [CLKID_HDCP22_SKPCLK_SEL]       = &s4_hdcp22_skpclk_sel.hw,
>          [CLKID_HDCP22_SKPCLK_DIV]       = &s4_hdcp22_skpclk_div.hw,
>          [CLKID_HDCP22_SKPCLK]           = &s4_hdcp22_skpclk.hw,
> +       [CLKID_CTS_ENCL_SEL]            = &s4_cts_encl_sel.hw,
> +       [CLKID_CTS_ENCL]                = &s4_cts_encl.hw,
> +       [CLKID_CDAC_SEL]                = &s4_cdac_sel.hw,
> +       [CLKID_CDAC_DIV]                = &s4_cdac_div.hw,
> +       [CLKID_CDAC]                    = &s4_cdac.hw,
> +       [CLKID_DEMOD_CORE_SEL]          = &s4_demod_core_sel.hw,
> +       [CLKID_DEMOD_CORE_DIV]          = &s4_demod_core_div.hw,
> +       [CLKID_DEMOD_CORE]              = &s4_demod_core.hw,
> +       [CLKID_ADC_EXTCLK_IN_SEL]       = &s4_adc_extclk_in_sel.hw,
> +       [CLKID_ADC_EXTCLK_IN_DIV]       = &s4_adc_extclk_in_div.hw,
> +       [CLKID_ADC_EXTCLK_IN]           = &s4_adc_extclk_in.hw,
>   };
>
>   static const struct meson_clkc_data s4_peripherals_clkc_data = {
>
> --
> 2.42.0
>
>

