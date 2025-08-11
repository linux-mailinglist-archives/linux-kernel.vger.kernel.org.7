Return-Path: <linux-kernel+bounces-761716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF2B1FDAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557453B98ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AEE70823;
	Mon, 11 Aug 2025 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uwWrVZj3"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012063.outbound.protection.outlook.com [52.103.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B543BE49
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878781; cv=fail; b=cAKUmDCEDl/2iPpdcAX4Tu17SffxFabvR80FUaWzu2Ghd0qR6rDhJzpx1kjGpxh4sDGT1Yi+/etRaagjPR/dyJjwsPPcfStfBR98GSuvbkaCI5KYwTzrt0hg765ui78eAjnUOSHEip+WNeqJJ7c5l1YXIA6NtBDajIp+v/luOlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878781; c=relaxed/simple;
	bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t5isKLe9vl1SI2KYQFcWZGIMP3jd+DqImxqs4uBaukoNyF666d0eZLPrZU2hLRaelNE3n2RuwmaOR+wRG1J6J6K2oPWT6e3jmcgcnFIQn6v/56ZftVx2eOC27DjfIbwh9ibIqadGc9rdn1mq2O/RyrJlpqDsDrUyumkNLKbNldc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uwWrVZj3; arc=fail smtp.client-ip=52.103.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3hIEqEd7rBqka1sXt1gHQkYBdOOFSfH2hpcL2OlpMXIMWtD8Wm8esDjhJaNkw5YfPfkfAGmhFHqFniVDdvvf1MlwTzchak7p8+Bi7g+oSP84B03DrBISREC6fa9zNaNubUWpdgeIvf5FUxkaOu2iSowDYKhV526MT1EuXDbXnzICLUnrHNW3TUpISE4sXlJN5wgNXfyYV1Si70o5Bg3H69lEyosgFQDlOahCKhEz0r0zLepFZJsjQQrh7bA4fXPIqx+EH1IllT5VNuW4XavyOaWUiKeNgWZ5Pj/r0Wp2C2+n1Q0Z/Mrr7it82FKJRfL7xISRCBRGhp5rf3cQtO33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
 b=Nm6Fh/3kzK4FJBWmvjkSsBuOREkJC/PpDdxqjZFZUHCTpiigGyjVtqVEaprHYlEtk4IdOegxCKx6HvmdZ/12Oe08dx9LfcTHPtPNDMSiSr362Gr22BslRG3OAnXcVyS9dYyaFvBLBXtY1Jg8TeyVUUTqGOZ06Rk21MCt7E8+5SY8xD20hh3DWDiZuMOD8nYbTRmDf9/bQepjMqaBiTEuZI1KEhg2uf9GSZcL8TcqxGw+ogVusmWs12SOb9gul4JOZArPfbWMzsRJ7zA6aBgx5qmW9JonzRq9xu2VTtxr/rjcX5fNj4T8bBePov8OW8sMTmAziVqQRIG94kfyBV1tLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
 b=uwWrVZj3CVv9umibPBWOOmWXgtRznBQf3RY/hsfXNyu2Yse6xSia2LY20gqeXznOSZk+QAizt3uKoO8ruVUME+h7q66r7cByYUvTAWTWz3pnExNxWN2HpOYlX9wKS2Tfny8Q4RkwHE+zR/londr3qex7GCkhBMbW7UufXzksaMsCWNgNMAlsaw12uo0xYTv6lNzyiNShEGnaBScUFsFpEReTZKk7ywbL+Y88jOENpU/oBWNXgpn/RS+Oh9tEphxtkzM7MSoCOSZgsR+Y2ABSqCHDlm8G06cFf1kZ/KthnitWGWcvvvxO1hLgk2faaZVV2ZwEyV+OlspPFV4AeWPMRA==
Received: from SEYPR04MB7476.apcprd04.prod.outlook.com (2603:1096:101:1db::8)
 by TYZPR04MB6861.apcprd04.prod.outlook.com (2603:1096:400:335::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 02:19:36 +0000
Received: from SEYPR04MB7476.apcprd04.prod.outlook.com
 ([fe80::7dbc:c330:4703:b34f]) by SEYPR04MB7476.apcprd04.prod.outlook.com
 ([fe80::7dbc:c330:4703:b34f%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 02:19:36 +0000
From: =?gb2312?B?0f7R/sHsz8gg0f7R/sHsz8g=?= <shishuaipersional@outlook.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: unsubscribe linux-kernel
Thread-Topic: unsubscribe linux-kernel
Thread-Index: AdwKZlku9xvIBITXSwCoop6jx7TyPQ==
Date: Mon, 11 Aug 2025 02:19:36 +0000
Message-ID:
 <SEYPR04MB7476BA0CE9769DAB602CA816FC28A@SEYPR04MB7476.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR04MB7476:EE_|TYZPR04MB6861:EE_
x-ms-office365-filtering-correlation-id: a02184b9-ced7-4c29-dae4-08ddd87d84b6
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|8022599003|15080799012|8062599012|19110799012|461199028|102099032|440099028|3412199025|850799032;
x-microsoft-antispam-message-info:
 QeZTvBFDX/1Bsol7KlaCHtzfWp6eS4AeZv/2+hOUVbnrc9Wy3/KaN3VCtQ5fcaBVDSUWlkCeKqfQ22fAm+dqqqYbg4kVRBJygc80EYb8X7g2On2nN7UtknSeQMgRHP85AvPTUZys3Jj2T7lZ19fHo2/kaqP6mTtOcMCCXBJQZ9Um0ko5/Jz9D2owIG8LNM7SnwulK0ry4vlUVIhp72RNQ1G4ByqDs3O/62ZZbciqQPlcOKixqXU1k+Fltwhm2MA8uzoTkzsIQJ0TZXR9B5xowBoq67WJsaFKRL9Xrucmvde/2uOusavIupfa6QXJ2lf3mTuYMwDbMryf1YhIk4zFwd8uXyNjlXvJ/tz75DxpIyR3UlQLtZf257OIYQIJhrqfya0bKQtCz7zxsbiNyu3d1+NUFWgIANOLvryNfTnVfKXAHZoQ/3hWgjmTg6ZA5Cwh9hs7ZOAjIPz4WeaycXIXp+FeRckcfALDH7gz6JIJet+C+iY/Of5ICiKmAmEhPXwzvOW2mJdE4qm80GqdMJiD8TETaHxi6aNO0UgRFhf4CZpuQ/WwDDHiJQpO7JpDq++CWLRfK0wjpZJNYHvOJmeIjNEmxt2xjmspU9U81nziDoWc6omYWng5hzWCGENm1KXBBH/z6GZV2ypx4SB8uPSPAe2wcnmk/G+bgWN5PARSK11hRVFpIWVOrPWxheypQGq5g9PwRrQR9oWR/1L99XkcCS2RydM8n6Cza/y9MiOw3OvIMzUuwPYwFjKnL/xoj1jceVryf1xQDyshB9TAW9fMni9JqTCTTR9Rpj9FR7Q34ueWlH/1/mcuAZyB2w2ifBadRs9YXRhrxxH/1n4knkSaK0b+/6zRlfrwUvtjfMRSk4Y=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TWxwL0R6Y0MzRkQva3FWRi9qYkFjS2hvNDlXOGFvNmQvVFlnSklSMmRnOXpS?=
 =?gb2312?B?YUErd0svUElhTFNZR0ZoVkhHVHN4bU8vT0pSeWpZR3FBb29nSDZUMjVvaElo?=
 =?gb2312?B?OXVEMTBBNVpCTXdEVGR6SlNqOHg4YllOR2s5YTEreEpieU1pQ1cvYkxibVo5?=
 =?gb2312?B?YVJTTCt3MmF4UnBtUklNejEwZ21abENFeWYzTmZUZGNzWnFSWnBjSVlDcTZz?=
 =?gb2312?B?OU14S0pNbW9NcTZNb01YVUVIUU9pMzB2a1BJTCsyV2w0eUlPWE1jeVFlOVNU?=
 =?gb2312?B?Y1VSZTkvcUhuT0p0ajZqMXRnbDRXYldzRm5aOTQ0N2UveGNhNTVkRS9IWmpR?=
 =?gb2312?B?aTFnQTgrc3F5K3llTk5OMUtXWHRnUjlwN1RHSDgwQlY3ZXJDNmdDTERJbU55?=
 =?gb2312?B?ZkhjVS91QlBqdGpXWlV0WkNNUFpDbmJ3QW9ycG9LTU1CamNQVG5NMGdXNzN3?=
 =?gb2312?B?enRFbHdBcGJtMWpmcXF1UkVmd3pWMUJERThtSU5rL3I5ZkxFd3R1VWVYQXdi?=
 =?gb2312?B?TWhlbC9TS3N4eG1uRnhHVW0xbHA5YnJhM01mK0djRGhuU0I0cUlnQ05FZUpR?=
 =?gb2312?B?enlRZFc1K2h4eU96UFk5M2NQb3J5bGIzMTNzYXZrZHB0WUd5TFdrZDRnOVo1?=
 =?gb2312?B?ZWVrRk51SSs3Q0xqbm1UTkFnc3ZFUzNmak9NR1VzRzZja2FmaVNHTW8rOFpl?=
 =?gb2312?B?ZkZ1TFREUE43QnAzZHEyME53ZWNjazhzaS9WTUEwejltVGFTNUo3VnZkYnpF?=
 =?gb2312?B?MlJaQ25Cd0hhYysyVlpUZ2puVmVFQjRNSGw3dllCZFhEWjJJQzY4cTRvZHE5?=
 =?gb2312?B?OXcrTmxqL0hGKzZOTU9RYlJ2K1l0TkEySzg2Mm9aekpNSEtGNUJ2N0trQmZh?=
 =?gb2312?B?WmYrQyszb0hKMlgwblFGbUxPczJocFduV1hUZFM3eVEzOWkrR2pFUFVRb2Rq?=
 =?gb2312?B?V3JLNGs3T3Zud3BFcGZ0NXI0U1VJT1Rqa2Q2TEduVnNDVVBjejhuRm1TL0kv?=
 =?gb2312?B?YmxLSWQxN0VoUWhpRnBYNzhLK2pwRkhkNkx3a2NSZEFJdURPU3RsU0tlYmk2?=
 =?gb2312?B?KzJ2MVlhMWdnYjdHV3M0Ny8xZUxsNXdhVDF1VU9TaUs5SzIyM2RqKzZFc3Zr?=
 =?gb2312?B?aFFvc3ZKcElwcS9wUTdpWW5XRCs1RDg4MktiUjhmUExHTXNDWkFsVExsNkVG?=
 =?gb2312?B?MFlsSFJpdDZzVHYvR0NQUzhXUENDcktMQ3dLbkM4U3pKVktybzBVaGJTSXlE?=
 =?gb2312?B?ZmNzR0FPMXdxc0FhSnBhNEMwVS82c08xZnk0YUp3aitZdU94bzMrTVIzUVZ4?=
 =?gb2312?B?N1E2SWZwSkU3WmZNdUdmZ2o0K25FeVpyb2QrcUV4TllQSnJnc2xjMkZwdGt2?=
 =?gb2312?B?b1BBbGtMODN1ZlVVd1NaWWpsZjM4elduc2NuUmZCQjBjTU82SFFYNEJVSUtx?=
 =?gb2312?B?QnVoMEx2L1hvbDk2SkIrbk9ZcVZqWWd4bzBHaEpmay9idURvMHZkVk16YlRX?=
 =?gb2312?B?eCtTMkNYM2RZN2wyZFdyMkNIR1lqRzlGdFdFZ3pMbWk5OWJNc0hoeXFQZXJm?=
 =?gb2312?B?UnpTeTE3Ly96TjR0WHlxYnVVSzkwUXJnSmEzTytnZlRUZ1BGNWp4a1A3Y3pi?=
 =?gb2312?Q?oRAMoShIiUwy0Qv6n16K9GMbv/At5Jp6Z1Cw4PqkRpEg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR04MB7476.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a02184b9-ced7-4c29-dae4-08ddd87d84b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 02:19:36.5322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6861

DQo=

