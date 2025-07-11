Return-Path: <linux-kernel+bounces-727677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797E5B01DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7076716CC76
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3BD2D97AF;
	Fri, 11 Jul 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="SjaOAplC"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BF2D59F8;
	Fri, 11 Jul 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241129; cv=fail; b=DCR660udG+56JdmQvg7E1w8NQswvX4jSdyAwsw1ivdJF5tA3sdufQZR6No6aIP+QKig0fCUrPbxtyVFmLlEVfmZ8O4u3b17A8T8TMdQIkCg+qZ62IqqjnfOsedZhswKnWzYaaIay2tNXLR6Hk1ogNB0kQaZ50DlgjghpGSEN7Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241129; c=relaxed/simple;
	bh=VkZD6E77xn/h+0P2fizRL1SKThdIA7SKn8S0UxoSuUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nT9r67mfhhRFU2kL17/QVJEwxsGNJDQ/EPeOoZDBUesQZ65Y4br2HyLXaYfkgW8poRymLeVFt/oWCcPHbP35q8J7md455XN20uXsyaJW0lDId7QYaVZ/KbdQ+K0bNEdOlus3BKnvyh64t+DR6JtBMYLW2GbvT/P9ekZQdxzy2nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=SjaOAplC; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDaNFT008729;
	Fri, 11 Jul 2025 14:36:25 +0100
Received: from pnypr01cu001.outbound.protection.outlook.com (mail-centralindiaazon11020137.outbound.protection.outlook.com [52.101.225.137])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 47psctjcqp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 14:36:24 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yb+IJNn8Gc1Fc7LSsZLUVDUDEz6f7yusqHbSPBuH8LV/JLry+qZMD7pcDnzwPyVLZQd/d9i7d6F+UYGwzpcZLgfFvkmHkvZkAGfnE6z/rFm32DfdKnNpZ8xOXyORmZDi3pCKyEgAMnT0mES/CzErINt3JOZ/it3gkL+1dGrScLZ1LoMm1YmJcovNlXWlHPshHOXa4voQIu7XZfMQcLMtAhbAEASijYMf08vfQhYc6Glq6vwbcRKnUj8y9FLFhvxf+B/P6CeW7tyFFLZPCy9qt/0iB0srx3R2hP9KZUhxt6CAm1eRhSEABpCPzyOXd1xaG2CV2o69xI5tFfz2KGtsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkZD6E77xn/h+0P2fizRL1SKThdIA7SKn8S0UxoSuUo=;
 b=dT7hLMiKj4uzz/NmUlO60K82rKRmPQGsdvm4x/9oTEoQrmQDDVaoE8Ur7hTnCUp/dMTCuu1pZPjg+qSdLJWekABRE3zjyxbGrSM+rCXuXkDP08zhTmHO201Ns/8C/5RZz3IavVyIY6ep+059gwhyi8Wnl8naX7zdZnfbVz4Q1ONitHDfx8PjAukzgfKiXc7tciFoRThGg2caC5pcLgfCfaA93pOvOhc202+/fCYeX0VX3i7UmLn671SfH3dcj/fF4ff3kSyi3PuJpSJDmJX8BYFG0hzOd+dwjSmw0hYr0bkm972vXGUIdCP//pi8uQqkHYL+3QkoRqBk6Er2us0JQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkZD6E77xn/h+0P2fizRL1SKThdIA7SKn8S0UxoSuUo=;
 b=SjaOAplCSYvPO8Mk0i202pKH1oRpYAucSKdThV3mkgEXjfc9RdXuN7jdt4/KRj1Yy1tU8cU8E7eXH+pSG8V18aGrlJAwKcDPxBKt+2u4DBNceS/I5/TALuIeGAj6W+0Xppsflg3bjBlEfJfsxrn5Gl5tTwzO6ME9nxrdD6EfOcg=
Received: from PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ab::16) by PN0PR01MB7862.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 13:36:19 +0000
Received: from PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd1:bf89:3bb0:5f83]) by PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd1:bf89:3bb0:5f83%6]) with mapi id 15.20.8835.018; Fri, 11 Jul 2025
 13:36:19 +0000
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn
	<matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nikolaos
 Pasaloukos <nikolaos.pasaloukos@blaize.com>
Subject: [PATCH 2/2] arm64/dts/blaize: Enable Ethernet on CB2 board
Thread-Topic: [PATCH 2/2] arm64/dts/blaize: Enable Ethernet on CB2 board
Thread-Index: AQHb8mjICVHv8e3160KBOuE0iA37QA==
Date: Fri, 11 Jul 2025 13:36:19 +0000
Message-ID:
 <20250711-kernel-upstreaming-add_network_support-v1-2-4a66a17c94b3@blaize.com>
References:
 <20250711-kernel-upstreaming-add_network_support-v1-0-4a66a17c94b3@blaize.com>
In-Reply-To:
 <20250711-kernel-upstreaming-add_network_support-v1-0-4a66a17c94b3@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PNYPR01MB11172:EE_|PN0PR01MB7862:EE_
x-ms-office365-filtering-correlation-id: 122e2ba4-b4b1-4daa-d5f2-08ddc07feb1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUl0Y2RTRm5XYVpOazgrMEVpam11ZDVlZ2R5ak5UOEFlLzloTE9nZXBoeDA1?=
 =?utf-8?B?VTJKM1hVQ3RncnFhYzB2a2hiWmZKQkI3a2tQbk1pT2Y2aTZRMitWMHYwcHhx?=
 =?utf-8?B?WUlKUGFDcmdEekpMdEl5L1JucWRqUnNwNjQwdXVRaDM1WUZPc20rV2JjVEpD?=
 =?utf-8?B?MmJORmtiKzQ5L1o3UDlsNW5UTDRXWUd4eEF0V0lDTW9tSTN5NzM3NFNVUjds?=
 =?utf-8?B?M24zSnd1cjNmdmxJR2pNZkd6blpNdlVBU3hVcmNMS2w0NkxFUzVmL2JoTkln?=
 =?utf-8?B?bEFidmVqeUc5U1JFUlMydExjN2dwMXlFUVYzZWFvV2hMbG9YQWx1Z2psdnlL?=
 =?utf-8?B?d2I2MjRuMVphU2Z4VFN1SU5sRmpHWHRhMHdlS1Z5SjZ2V2dtMzhVb3JyZWlz?=
 =?utf-8?B?RkFIYTdCU2hkVGcwVnhJbmJQWE5GWjF0Q3hsQjEwYmFHWXFVNTFHRk1uVEZF?=
 =?utf-8?B?MjVoMHpEcHFnV2VCZERMSDR2VmR3UUdOcGhDbWJEQ2pIeDBLRlljbmdhdUp1?=
 =?utf-8?B?Z0dDK2N0WXNyOE8xanhjbTIzSmVNdlRWOVQwUXcyQWMzRVhpRTNXbzdac1l2?=
 =?utf-8?B?eFBXQjFENGQxYlBhSEVHem5tOTRCYlRzVmJyV05JKzc1Sk9QKzRENVlyWlNT?=
 =?utf-8?B?SnkvYjltbFlNckxQMGxUMUJhNmR0K3R0RDc0cWxhWXZZUTQrUUFxcTJZc3p6?=
 =?utf-8?B?QUUzNVhxeWZCazdHSXNQaktRYlpIRTNIVnpYZjRSUG5PSWNmYU5FMVVSWnJF?=
 =?utf-8?B?OG5qQUJoZnoxemVzL2N0d2NhUklyWEhtemNYaHJNQVF2c2N5YzRDa1JLc1JM?=
 =?utf-8?B?L3ZGTEh5a01hVVhQMGdnZ1RzYWgrR09rdnhtY2xFVlhwb2IrQXd3ZXlKemE3?=
 =?utf-8?B?VUw0MlNqQW93UFhhenRnbmVDWEl1U0ZwdG4wT3VQaU5lM1VITWtwbWh5bWZH?=
 =?utf-8?B?NkxvRDUrNFhUWVAweUtmS2JUYXo0SitUZVFkekc3bnlZRERFdERMQ0FoaHlt?=
 =?utf-8?B?STFRQmlYR21RR1JxZWdhYnlYdnZuSG9wb3kydm0wSGlaanRPQVJSQkhSbVZI?=
 =?utf-8?B?TFZIZ1FkcUxGMXlCekxVd1B4WHFtZ3JmNHcyZGtlK092VWlMQThtcTh2SlAz?=
 =?utf-8?B?dFpMVEtwNUtNZkRralI5QTdxOUg5K3drdVU0NHBqODJVWTNSUkZlNXJyYWFV?=
 =?utf-8?B?MVZaUW1FSlNGTHFUNTVyUVB5UGs4cVIwVW9DTVg1ckQ0Q0djWkdjQWNVeHJX?=
 =?utf-8?B?alh1QzBCbHFLVzFUdFpFWEZaZUFxcy81bS9tTDNab1g1RXZYbzhSbTlsdE5v?=
 =?utf-8?B?cUVLRzJTZ08ydzBYcnN5bGhhSHBReUdML1FXSmlYcVhWUk9KemxiNzcyeFNp?=
 =?utf-8?B?M1ZOTDVWRG9jUGJwSk1lWVVoMk5QZzZwZDRsUGNTc2lvM2xRd1ZuNjNzWVdh?=
 =?utf-8?B?ZE5JMWNKU3FBS0FuSnArZEY0NTZSVmtDcXZqaW5XZHdMVTJjdFI3T1VoRkw0?=
 =?utf-8?B?M1NEUzJPQ0JsLytBMGdjbDlQMEM4WmxOanhUeFVYbHMzcW9wZkdhLzFBYmpo?=
 =?utf-8?B?aEVkaTRjVkRuTXY1clZuSE9QOElmaHkzQnpOaC90dEVrS2xYLzQwb0xEU1RK?=
 =?utf-8?B?THk3WnVGbGxySkJLeFBlUXh0YW5YZWFWVVB1RTN6eUZkcUVCWVNEdi9OM0Fz?=
 =?utf-8?B?akpOTzB4SEdpY01SZDVMeTNDczdqaGV5UGJHZWF0aFNlRS84ZkdYTE9KVG9U?=
 =?utf-8?B?MlpNU2ZPNzl2MW1NQjdRaElzaXNQYTdWZ1dBUmhkTERBUUJYYzlWaVRyc0tw?=
 =?utf-8?B?RG5RSEZOU2ExKzRtWkdjSlphdW9QM2N3Vk5wMlpjTXhJaGRQTS9UZDczR0tr?=
 =?utf-8?B?QWloNU1RbnNueVBpcWFmZFc1MDhWdDhBSEZIVjZmUWU0bWVrNDhHWGdJOUwz?=
 =?utf-8?B?RENSVTZZeEJNbWJCUGxyZWorR25na3phRkFQZ0FXRndDOFZEQTI5T08vSEx5?=
 =?utf-8?Q?jLbBFqhL+2uxjaSU1iAM65s0Jk+EYE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1A2YTZDZmZwVFdTUGxCZlI0UXlNYlRNR3FYYzdzbitQenRxWUNmSkg3L0l0?=
 =?utf-8?B?Vnptb0ZBODlzdlFQWStGcXJwdGFEelpRZmZjekdUNmlycEY4b1NDcVJOcnpM?=
 =?utf-8?B?MmllS1JrZnlXWDliS3Q2QUdwSldoeFRIdW1kOTcwalR4OXRxUlBIQTVUQUZV?=
 =?utf-8?B?MXZQUzd4K3FHTVphcU1hc3J6V0wvTU4yQThHck5ORkJRUC81NVNtK1N3bnV1?=
 =?utf-8?B?L0pJZzBSdTBqZWNHWjk1S0k3d0pVeHJQOEJoSmZXZllad1JGSmpCcnZEZm10?=
 =?utf-8?B?eXdwYmJHVllETmQ4WHhieDdKek8zTUtTKzlIdXpqWTAyZDEyUERBUEhXdnBn?=
 =?utf-8?B?TkpFTzErYXNuLzN0M1JuV3VIQkFreXN4WGMvK201NXZYcUFnL0krQlZraDU4?=
 =?utf-8?B?azh5eUtTaWhHRldrK094aUxzcnoyTXlYZ05NOFAvSndKTDV2ZzI0VGdNN0J2?=
 =?utf-8?B?VXdGV2FrY0ltM1hJS1pqa2E0bWdhY1A1aG8vUG1QQTEwWFBYZE5Ea2VVbjZD?=
 =?utf-8?B?aXh0c0J3MnVGWStwMjB4Mk9KbVJvdnliV3c4cG1ycG9FNU9zcGgvUFZhSm9o?=
 =?utf-8?B?UVJENkVqZlNzWnYxb0cvQkYvSkxQdVA1SmRZWHV1by9vcGJXUWQxKyt1S2Nw?=
 =?utf-8?B?dVZrK0lURVk3cnVEKzlLaEJ2VS9NTUdQVFhoTkVWWUFNbXpBZjJoNi8yVDFn?=
 =?utf-8?B?cE41QUxwL2FPS0RKRGlmRlpOT0dSRE5iUkdJVWpJb0RMTXNqVzhtSklqajRn?=
 =?utf-8?B?Z0hZendGQU1nV3BGbVg5ZS9sKzNEem1XMHBQK0hpMzBrcXV2RDIyMFROaTBC?=
 =?utf-8?B?YlFwK0pEWkJZUVBxR3N5YTB0TTRWK0RaVVJDalo0bjl3eDYyR1E4ZFUvVFdI?=
 =?utf-8?B?TWxLeExkTmVQL1JQbSs3RzR5b3VLd1A3NVlJLzNBS3VYN1VHcm1VRUh5ckNZ?=
 =?utf-8?B?aGZQQTAyNkxRLzc2YUI5WlM3akw3YTRFUUo5eVZZdGFFU3dna1dvSUNZK2Qy?=
 =?utf-8?B?UVpOUWpKTUJ3WlljallpbUN1QTBRdjhUWVJXdFVTbUFhYmlTWWRZRzdxbWd6?=
 =?utf-8?B?bU5RVFdybmx6UnFyb2R5YnkvV3JQTFpoVEdkbHFHOHlPTEdiZzU2MER1Rkhj?=
 =?utf-8?B?OGljNDlGZ1NKUjl1bit1RStYV2RRVmJJdmhvajVXMGJIZ0xnSWE1eEl2Q1dz?=
 =?utf-8?B?aGxoNjI5ZDY5SkVmTktrZjhOTGRpRXNpdEVLQlhIbHR3bjNobFBQbS9xdkZL?=
 =?utf-8?B?U2s3Q0J1QWlVZ0tKRUg4b2tqUy9Td1B4STI1dTI0ZzNsa2hXUTlKaUJWSVRE?=
 =?utf-8?B?QzVYOEJya0RJaFdZbVdDN3NkWXQvV0NxQi93aHc5emxXcDgvUW02QmVGdHpJ?=
 =?utf-8?B?Sm9ZZ3NITXQ4QWxiNmRFSjJ4K2hldFBXU3p3b0xGeE53OVJUMmFLb0hrNnUy?=
 =?utf-8?B?ajd0QWdYTjVJOVIzK1ZLN0lULyszanBTc0xDMUVMYVQyOFMyWjc0UjBORVNC?=
 =?utf-8?B?Z1RqMGprOU1EWkZJY1Q1T2pZUXh0Sm4wczlSTkRKY2s4Z3c1aTZPOC85b1cv?=
 =?utf-8?B?b2FPV3I5Y3RZUkN4S0xIRkVDemw3N3laV0hqY2MwQUdjc0MyK2VtTVBiMHJK?=
 =?utf-8?B?bWRQZGtyMkQvUlBzY2dBUlZSWE1xNEhKcDZ6K1dwM3dHY285dWhnelpSMHEv?=
 =?utf-8?B?RFBPWk5DRkQ0YnpnbytkaHpxb2Y3b1RQazc4SzY1MjErd2wwWVZEOGhpQVlm?=
 =?utf-8?B?cmZmOE5SVzJNeldMWHNDNE5nd0xxWndEelV3ek9WdGlUcHd2VjJ1SlovY3lz?=
 =?utf-8?B?L0YxL3Jyb0VLa0ZjY29rYStPdWZXak4xUXRLR0hKdWp1MHJnb1c5TUo2QWdj?=
 =?utf-8?B?Y1dpamkvRUdLYXU4eHpSZ3lNWTVubjhDdHpVdEwwckRJbWRzQzNKbnJYdlBF?=
 =?utf-8?B?RWIzd0ZQUU1maWhDT1NESWxWdGg2aGJ3TGZueXEwSHRBMGNnME4yeENLSTZ4?=
 =?utf-8?B?bGMycy9pakZBeGJqcGhacEpQK1owRm0yM3dFRzBJZVFNUFpVaDc4Q25xcHRj?=
 =?utf-8?B?Vm1rNmFDdXhuSkRPTHRZM1lRZ1dEUXg4dVFHcWp2SmxUMDdhMzUwZlhTaGJx?=
 =?utf-8?B?RVNIRG1tZ0x1eGduYWNKQjlGdkZWam8yOUVOYXZrZ0dNSmU4MUdUY2JuOU5B?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC2A2F601741F343B24A5BA56E862F1E@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 122e2ba4-b4b1-4daa-d5f2-08ddc07feb1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:36:19.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFNFOphm77l3vDBlrfUbdZg7BphTNutXxwOO2NgWRDUAxKIfl4wMNEfvc+31StzV2/uoVoNwDLsIWUAb8agf+Gl6yNkEG+b1eCKYdZha6M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7862
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDIwMSBTYWx0ZWRfX0t6hd9qaPJCr DXRBn0NRv8cQchItYPu2fUJ5MU5Aw5OtQLyaVeelNRdwdIG5PGTLvacUxpkOlMdwCjlLt5ygDq5 ylgjjOOrDoRYWxeq7qhn+cojC+uwRkB1SgWCf8jddE2CsIAhfb3M1hPVZfaKni4lM2frfIhm5QD
 ttuCMk1jw3Ez2mkSKD5lkS8Y27Cxr52ZUxMZcOhKP341yvjSzpnY2YLTYcOEBO/zm5C5yY8QM1n KJ76CKcc+IjqBI32DkdeXSNb3hLs1Lln6wvcV85eziDEpeHyvR3o3SRTVuu1Kf3/9+GPD/FFtkL MlyDqHXMGgVz2P34eLzqOUY//oASxhKd3x4MWmQVPVCa/j0Oug1ikEfjny6ZLhWvEJtVgZPWQqj r2sTaa7M
X-Proofpoint-ORIG-GUID: HJBC9Uj9wugTOe0HobxXe_FVqMYyM-us
X-Proofpoint-GUID: HJBC9Uj9wugTOe0HobxXe_FVqMYyM-us
X-Authority-Analysis: v=2.4 cv=MMVgmNZl c=1 sm=1 tr=0 ts=68711358 cx=c_pps a=oCCLDGIEOjCsJBocmZPjNA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=WQsBsLtPPbzHpxbNYyQA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: orgsafe

VXNlIHRoZSBTeW5vcHN5cyBnaWdhYml0IEV0aGVybmV0IGNvbnRyb2xsZXIgb24gdGhlIEJsYWl6
ZSBCTFpQMTYwMA0KU29DIHRvIHByb3ZpZGUgRXRoZXJuZXQgY29ubmVjdGl2aXR5IHVzaW5nIHRo
ZSBUSSBEUDgzODY3IFBIWSB3aGljaCBpcw0KYXZhaWxhYmxlIG9uIHRoZSBDQjIgYm9hcmQgdmlh
IGFuIFJKNDUgY29ubmVjdG9yLg0KDQpTaWduZWQtb2ZmLWJ5OiBOaWtvbGFvcyBQYXNhbG91a29z
IDxuaWtvbGFvcy5wYXNhbG91a29zQGJsYWl6ZS5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2JsYWl6ZS9ibGFpemUtYmx6cDE2MDAtY2IyLmR0cyB8IDIyICsrKysrKysrKysrKysrKysr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9ibGFpemUvYmxhaXplLWJsenAxNjAwLWNiMi5kdHMgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2JsYWl6ZS9ibGFpemUtYmx6cDE2MDAtY2IyLmR0cw0KaW5kZXggZmI1
NDE1ZWIzNDdhMDI4ZmM2NTA5MDAyN2E0YzRmYzg5YzgyODBmNS4uY2JlOGYwOTMwYWQzNzQxYjBl
NzcwZGQ3ZDQ5NDkzMWUzYjkzOTgxNSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
YmxhaXplL2JsYWl6ZS1ibHpwMTYwMC1jYjIuZHRzDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2JsYWl6ZS9ibGFpemUtYmx6cDE2MDAtY2IyLmR0cw0KQEAgLTYsNiArNiw3IEBADQogL2R0cy12
MS87DQogDQogI2luY2x1ZGUgImJsYWl6ZS1ibHpwMTYwMC1zb20uZHRzaSINCisjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvbmV0L3RpLWRwODM4NjcuaD4NCiANCiAvIHsNCiAJbW9kZWwgPSAiQmxhaXpl
IEJMWlAxNjAwIFNvTTE2MDBQIENCMiBEZXZlbG9wbWVudCBCb2FyZCI7DQpAQCAtMTQsNiArMTUs
NyBAQCAvIHsNCiANCiAJYWxpYXNlcyB7DQogCQlzZXJpYWwwID0gJnVhcnQwOw0KKwkJZXRoZXJu
ZXQgPSAmZ21hYzsNCiAJfTsNCiANCiAJY2hvc2VuIHsNCkBAIC0xMTcsMyArMTE5LDIzIEBAICZn
cGlvMCB7DQogCQkJICAiQk9BUkRfSURfMSIsCQkvKiBHUElPXzMwICovDQogCQkJICAiQk9BUkRf
SURfMiI7CQkvKiBHUElPXzMxICovDQogfTsNCisNCismZ21hYyB7DQorCXN0YXR1cyA9ICJva2F5
IjsNCisJc25wcyxyZXNldC1kZWxheXMtdXMgPSA8MCAxMDAwMCA1MDAwMD47DQorCXNucHMscmVz
ZXQtZ3BpbyA9IDwmZ3BpbzAgMTIgR1BJT19BQ1RJVkVfTE9XPjsNCisJcGh5LWhhbmRsZSA9IDwm
cGh5MD47DQorCXBoeS1tb2RlID0gInJnbWlpLWlkIjsNCisJbWRpbyB7DQorCQljb21wYXRpYmxl
ID0gInNucHMsZHdtYWMtbWRpbyI7DQorCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCisJCSNzaXpl
LWNlbGxzID0gPDA+Ow0KKwkJcGh5MDogZXRoZXJuZXQtcGh5QDAgew0KKwkJCWNvbXBhdGlibGUg
PSAiZXRoZXJuZXQtcGh5LWllZWU4MDIuMy1jMjIiOw0KKwkJCXJlZyA9IDwwPjsNCisJCQl0aSxy
eC1pbnRlcm5hbC1kZWxheSA9IDxEUDgzODY3X1JHTUlJRENUTF8yXzAwX05TPjsNCisJCQl0aSx0
eC1pbnRlcm5hbC1kZWxheSA9IDxEUDgzODY3X1JHTUlJRENUTF8yXzAwX05TPjsNCisJCQl0aSxm
aWZvLWRlcHRoID0gPERQODM4NjdfUEhZQ1JfRklGT19ERVBUSF82X0JfTklCPjsNCisJCX07DQor
CX07DQorfTsNCg0KLS0gDQoyLjQzLjANCg0K

