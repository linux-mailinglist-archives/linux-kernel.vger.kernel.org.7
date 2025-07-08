Return-Path: <linux-kernel+bounces-721080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23DAFC478
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B2F1AA465C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E162298CA7;
	Tue,  8 Jul 2025 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="eoAJ83gI"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2139.outbound.protection.outlook.com [40.107.104.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9343FC2;
	Tue,  8 Jul 2025 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960857; cv=fail; b=qNB5A+xOyEXqYJlbpIeGvmBj4M+VtJ6OdV53n8tVdJq0S9PM1fzaf8yvCv/EXKE41lmzugQimfzbbjfCdnxIihZSD9SmT+I+YfpH511xDoeBtu2ByOfTxu3Lw0O9yD5FisvCXQ12k2dHyk0JJyxMn4Uga7KQLdNVd+T1suxGtcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960857; c=relaxed/simple;
	bh=Xoe0c9nXbJn/mtShr2P3Eb9AhEZnpdY9WZFy/yNa51E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVjJ5V5HWyOZkDSR0MjYWWQTbd3msqujrrcj7LBubvGiRB/Tw9SbpO54zjxCjuBgvZ6Bfj/vKj9zP0qcxA/zaMisi2Jx2VoqWQzLOnI0TtEKfrRiRUEB8BVZ15FL26TfBJWUnAnCj6y6xWf9XMH2M4fuDTQdjgqEwwgB9qsl+x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=eoAJ83gI; arc=fail smtp.client-ip=40.107.104.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBCkpb1Au34mHDAw8hcPfVXhBnHXcdGbNgV+2A0Aww+BheGyLvOc45f4sEPA742CjjegGKVXIIEl/V7vDNbdNJTfuwQ1aONOjnNSBYKxeayf7mZqPIFWvexe2GYGz+SNWbmIbzd8yVZn7D7vCT1glCugfRSdYtkEQ06X2nczwr/cklVmCdLkYlDQJQG/pXoZRgtrh1Vly6TL1Inz8gJDJTg+iWWrYDmKPz5t9AGE8cFWRZj9rKmO0zMCOWHBnYAhSevOKNkNSjBYGflVTc/sDHD3FDKR7CfPkkdy9k/NbmVo/yCeWXCppnrpS3sivuJpajBusfam45FeMV3nwgz1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xoe0c9nXbJn/mtShr2P3Eb9AhEZnpdY9WZFy/yNa51E=;
 b=ZM6d0qzmCfEjrYFC/q30VlS29BmONVWZuLB7EKiR70HEtTrme2qb1hTfamg2TjQQNTvV/ojBhBAgWiFjWUYPdy6AItI137B+ZYuajaA4DzVtGqI68GJIFTTky51jVH1rUoZwOsqWfNyFNhKzAd4Hg2FrKkL9dFFzAzSxgv7ATIlQ62utsTbkvbCz80Uf1Q8sXJ4HD0KIJenf2lGAJU4lVln+qeRH5zcwUaF7RQ01KKzD96pQGF8lQosBUo1Ft9Gp1AufsXkxInwkpe+OlTnxPjVcwKqDMu7Afwwxsw0M8OO7G+CE8GmhajsFUcioYa27+nAJzTE+YjQUmvbgiyc/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xoe0c9nXbJn/mtShr2P3Eb9AhEZnpdY9WZFy/yNa51E=;
 b=eoAJ83gI8+T8lijD8qOT/gQjN85Zz6YdWVetcVI5N2QmsQdzSUyYaQ9vf2T7k+HLYrj8ErWSaUa0N2LwGsc+fHM1iFL4mTpsR9aXnUJzPfBq0PgC0H74+lReKZZhcgVDz+6qQP9VJda0trpJXB9+efvF4aaJN9yIvgk9A3TJSm6+uDQuSGcpxYCjO2WGaAbYTVPXYKh1xc6nSf7p/lDA0G6wqWREk6kPF6yqEYRiAJT10+E7eNhDUf59oIHN3ZSBDmNBnKEqSYjFTrciNoz0/TN4bZ0uUs8UF5l3SNzjZua7Gbs9fm47JOb18yT/lLCU5MfU1UYWk7yMdlOay4lWoA==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AM0P195MB0497.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:168::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 07:47:29 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 07:47:29 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Yashwanth Varakala <Y.Varakala@phytec.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Will Deacon <will@kernel.org>,
	Teresa Remmet <T.Remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, Jan
 Remmet <J.Remmet@phytec.de>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "Rob Herring (Arm)"
	<robh@kernel.org>
Subject: Re: [PATCH v3 0/2] Add new imx imx95-libra-rdk-fpsc SBC
Thread-Topic: [PATCH v3 0/2] Add new imx imx95-libra-rdk-fpsc SBC
Thread-Index: AQHb2tGWuAsdzxsEuk+czbhUVzLRrLP/9vqAgCgMfQA=
Date: Tue, 8 Jul 2025 07:47:29 +0000
Message-ID: <eb32cbf24224e711dc09441f5aa44a2812565e09.camel@phytec.de>
References:
 <20250611-wip-y-moog-phytec-de-imx95-libra-v3-0-c8d09f1bdbf0@phytec.de>
	 <174975871561.2915543.9713933816111618183.robh@kernel.org>
In-Reply-To: <174975871561.2915543.9713933816111618183.robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AM0P195MB0497:EE_
x-ms-office365-filtering-correlation-id: 1fd43b21-285f-46c3-5248-08ddbdf3b09f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDhrV3U5S3RkcW9HQUdLalBidGhZN1BVTkZZR0toVXhtcnkwN3N4NTk2RTlT?=
 =?utf-8?B?cytVRGlRL3FYN3M0MFJLQm5xS1dnUDlUSG5kSS9mcE14ZHhYNG8rM1FDS3dp?=
 =?utf-8?B?dlhnaWIxZnduTFZreklWSUhKczFCRFI4aDM4WXhJZmREdHB3TTFuK1kwQzY5?=
 =?utf-8?B?d0djTFhFSTM5eitaTHMwTndtMCtmM1ZuS1FLSEU1QXBVOTV6YXoxcDBreXlX?=
 =?utf-8?B?SXM0WG5zKzdJdkk3WEtxZ0VaSGUyajN1K1k4cUdScXlKa2thK00zNmJIT3FY?=
 =?utf-8?B?eGxzRENBOU9YR0drbXQ2elZ3NGFqSkIyb1dwTDV0RGdJdVNUMG1aRkJrNXZz?=
 =?utf-8?B?d3A5MDZwUXZYWDZLVWlSZUxCTGVkVnlEQjk5S2JBOTRUa09WeVhkWXkxVDVS?=
 =?utf-8?B?dk5OVlZUaDBwY08zSW1XY3hvQW5LM3A5T1J4Q0ZwTmJtd1BsMDM2OElEZHJT?=
 =?utf-8?B?V0VLcXdHZHYyQnNPSHZ3cTloWm1HbUdTMGVxN2NWa3I1cmZyZ0NVSW9na1Jx?=
 =?utf-8?B?cUFuS0FtVm1lcGo0QkprNmlnVmpvWldSejY4WUpUWWE4K2VHTlE2UWJwKzFp?=
 =?utf-8?B?UlBFWXBuSHBBSVNua3JjdEswQU1Qc2c4R3VBeDFYWFV5RWlITHBaOGFQQ2FS?=
 =?utf-8?B?eE81TlN6dmY0Y28ySXRSODZ1cXZRQmFYQ3dRcjB0NGVCWi9NVEhFTFFsRzJ1?=
 =?utf-8?B?WnpIUDVVRXA0a2xTOE1lUSs2OEczaDZpbnQ3T1Z1bTBYZ1VoaHAvdU8xdjBJ?=
 =?utf-8?B?WGxiQTl3REZkblQ0amRtUm40cFVmY1hocjIxUEcrV3pwUFlxdmw3YVVnTFN6?=
 =?utf-8?B?dGlXQW5WNHppaVB1V0xTUURoNmZBWVdYQzFkaWdDOExBajIxVjEvdjYxQTly?=
 =?utf-8?B?M3NqZUFkejBTaUNvLytvWkZKbjJaaEMvbHgyUzFmMHM2SWw0ektWVzM3TTFH?=
 =?utf-8?B?K0JWVzZXbGxqSnVQSFBkVk54a1BPejNzdnpFUW9NenpCL3lOKzBmRVNGZ1pP?=
 =?utf-8?B?cFMrbDNIbzZTcmdNTGdJVHVBd1BXVDBhaHIzMU1RUjlMQ2d3bnArZ3RBdlo5?=
 =?utf-8?B?eDVpdXh1NkpCckdBOXgvYzQ5Y1g1RVNyYmJNNVBJOG1aSWNCSXJRaFVRdWtE?=
 =?utf-8?B?SVNlbWMyemtJdmFQV25Hb2hTQlVnQnRPNTlFYk1xTWZkUis3Z29EL0F1VVZE?=
 =?utf-8?B?djVEYlRmdHdMU296N3VCT2svblppVVhCYjlSeEhoNW5LUzBodjhlZmpuUnZV?=
 =?utf-8?B?ZHdwTkV3SG5nTlVuU0x4MFNkdllOaWNObFhVS1hjaDZkcjRGeURIek12Nml6?=
 =?utf-8?B?dVAvSjNRNmJnMlZ5bW8ra0NDRitRQ3IwNUwxcTZlNDVBOCtXdE1MQjk5UElm?=
 =?utf-8?B?YVo4Z2doeUxzWkRKYkJqZWNaY1hSSWM3L2pjVm1zd3J0ZStGVWNEdkYraW5u?=
 =?utf-8?B?UVFrYUpBYXNWNjZ4WnZTUDE4c2JjUythNjBINnUyWThUWjVtQ3ZMRGdlcVRI?=
 =?utf-8?B?dWx4bnRiY0JncjV5LzhZWS9SR1htNWIxemJjOFVHai9LQ2dDN1Vxc2M0bnMx?=
 =?utf-8?B?ejJvNG1kWU1rbHJNZzV4UHRvWXVra0hiU1d2cXlqaGxyOWJTK0FJcWtMQk1X?=
 =?utf-8?B?QlNuWlM1K25TcXVMUGVPMW8wL1VYNURuOFQxbGtlQTdzdDJxcld0SXV3OGR3?=
 =?utf-8?B?YVJJNU5OeTBnZmp2QVl2YmdpMloveVgyRlp3Zk9ZenNOMnJHRTN5UDZFYU5w?=
 =?utf-8?B?K1lyU2E3b2NBTnBGQ3MzQlZ1STFFVXdUS3pvc1ZOTlh0dzFKckVVNXAxSXVl?=
 =?utf-8?B?ekhFVk4rMnZXMU4ycVVKWGdKYnpGVm8zVmJiRmk5TGRxRXdBL28zWjM0NVhY?=
 =?utf-8?B?czVhT0NUeWR5ekErZEtXT2hFbU5rU2cxYW9zZmFXc2pwTkU2d2xBTWRyd3Ja?=
 =?utf-8?Q?K3mKjey+RVe80ctXwfQSfgIGHHvGvadR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(13003099007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlhZbW4wV3VzNWdKaWVNdFhGUEZXM1NPVHZTRmVaaEVaTkc0TWRQMms1YXBj?=
 =?utf-8?B?R0hPcGpxNUc2WHZ2bEdMSHBHenNOd0dWa3hPbGVNUHA2SXdRU2c1bmNhOFJp?=
 =?utf-8?B?elZ4ZEJNRWg5c3cxRDRwaWJnNElyTTJDMmR6TUVvYkZTTzZFajNEbEFoOHdB?=
 =?utf-8?B?TytGMjI0OFhLUVhSTUF5N29tY3pnVnlENmhGTnl6WnZsdThsMHMwZGlZZWVh?=
 =?utf-8?B?cHBuUlVNelBGWUR2cHF1NnhnckNidG5CcXYydzc1NkRtaDd6TWZHOThnR09C?=
 =?utf-8?B?RzVlWUtMTzBGa3BjQmRYeWd1ajkzWkRadFRWL0FjbVIrS2p2NjlwNjRVRzhz?=
 =?utf-8?B?VFRXT28vcG9IOXpScitzYjlGMEdBRWRzOFBiTHRqQm5TdHNWTWFUbXZyWm1V?=
 =?utf-8?B?dVAyWnRmWnBEL0VQL2R4Q2dIV3pEbkEyRWE4RW1yL2JybGJONit3Zm93Q1NN?=
 =?utf-8?B?NWFCS3BSZzZKSTN3VXpMbTE2RlkxMG9odngyM0syS2t0dVFna2wyRjFwZFR1?=
 =?utf-8?B?Si9VZnY0NzB5SyttT1ZFU1NiZHdaV1Rac0hibHRPYjJ2QTdLTEVDSmxrRFJD?=
 =?utf-8?B?U1BtWUkvSXVBTXoveTNQMVB4dVZQV0JpQTZJSTFQSmJpVHUrTVVOcWQ3Yktt?=
 =?utf-8?B?NDRIY3dHUUhyNVhtUTNEdTYyNER3VW90OEw1MkFzSGcyWjg5ODFpWTkxd3pp?=
 =?utf-8?B?T2p4Ty9PeTl1TzdqZ1d0N0ZWYThvUWVWakphYkxwUTFXdXJZZTF3cmpGMUhV?=
 =?utf-8?B?SWRhckFtWkJOUHltTi9DZGJMaE5yZzJGcnRDZU1Vd0cyeGxuUXgzOXZXNk1L?=
 =?utf-8?B?aUpWeGliazJ6dE81cHhGQWs5Ny9QRWJJcGROMkZUM3B1OWxMR05YZG02eHgz?=
 =?utf-8?B?ZXJBekhNWk5GcnRGV2dlSUVTdHF0cHFZUFRoRkcrUEpTd1dMQVBNU3hqZFQz?=
 =?utf-8?B?WXBaQmVNVkFGQkY5YW5GWHExelBPeE14TStXTlhrNGR0ejczYkhSNDJaK2lT?=
 =?utf-8?B?Q1ZoTi9hYkxrZUFuZWNnUzJ6b1lQL0c1bWR2U21Sb1p5TWNsOHNaM2RneVdM?=
 =?utf-8?B?b0pmTjVKcmFDRjVIMXJoQ3ZxY3lIRHJwVS8rcnNwV0xYSTBldjVVQ1NXdjZL?=
 =?utf-8?B?aFFOQldtZTFSN2N5dXNJM0FRbXROSXYyalRsSnFXLzU1OHdIWW5xbVZSdmdR?=
 =?utf-8?B?azlIUktBUFA0YmhzQUZKbDBHT0Y2dUkxRTFIN0E0NlNKQlg3STNSMmZ5TVRq?=
 =?utf-8?B?TUhjZjkwUEx5K3hMNHlGTkJnMlhBNWQwdXdJRDk1djNycmdYdTF2OEo4Tkt5?=
 =?utf-8?B?cTdOeFc3b0xMeGxDZ1hOckF3Ry8wNHRUSHFBRWRFbU9vWXZDbTlCRGtYdWE2?=
 =?utf-8?B?bHlqL2tlVjREQnFmalVwQW1mdXZDQm1jV1g3c0l1U3RsRDd2Q2NlbHFKTE9B?=
 =?utf-8?B?eEpHM1BPeTlwYkdoUXlpb2pZUlBsUXpLbE5VeG1KWk5oT2lRTUk3RTRvY1Rw?=
 =?utf-8?B?NTF6VTJaTGZSNXo0ZWFNc2xUL1dQckdsZHpCY0EzcjlFSmVGc1c4WHphZ2tq?=
 =?utf-8?B?U3hPUElZMTMrcnZOaHRKZUl5Zmhya0htaXZsNysyMklrZUI0Y3N2SWczWm5F?=
 =?utf-8?B?MTJlZTJaYitlWXpDanBRdzJPTWxldkJkaVVVNVoyR2lNcFdGTG9MMk5EMjlE?=
 =?utf-8?B?MTA3NGxNalhQQ3hVR3pVQWNjOVJCbW9Yam13RUc1OWMrcGQwWVh5QkN1L3ow?=
 =?utf-8?B?RVBqV3c1SWpPQjJ5MTI2UWVERjNxRUhRRXBoTTBWMmp5SlU3aXdtR2dUN0Rn?=
 =?utf-8?B?eVlva1NhT3AweFcrK0wyTDhidU5TdkdlVFNRL2o2MXlRUm1abC9tM3ozQVJy?=
 =?utf-8?B?NnowOTY2OUhFK1g5K1VHOFMxVDlGMEJlQXl0RTVhYWs1TXZhTjBKOHNSSngz?=
 =?utf-8?B?cVFhTFlrNDNxZW9FVjA0K0d3bmtaZm1LdjFPeHk4cGRKUHQxd3VjWHlMakth?=
 =?utf-8?B?cW13Zllzb2RBQjdHOWlpRXdzMGR1Nk9yK3N1STJLOFdZQkc2OHRvS0QxUmZi?=
 =?utf-8?B?R2h2NndscXJQdFBCcHBqYUEzSGlpbWZWdmNBbVlvVDF0dVlDZ2liTUh3SU9S?=
 =?utf-8?Q?Tauw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <530D4C7A82235641951A6C17A79057A7@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd43b21-285f-46c3-5248-08ddbdf3b09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 07:47:29.4050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UsMrmr7Z1Gh2ojgicb2jt5661xxB5I2cqsNkKfTrf6aHGfo9/PEsz5nDj0+nSW29qgq7O/ig3+qgg/m4DmjIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0497

SGkgU2hhd24sCgpBZmFpayB0aGVzZSB3YXJuaW5nIHdlcmUgZHVlIHRvIG1pc2FsaWdubWVudCBv
ZiBiaW5kaW5ncyBhbmQgZGV2aWNldHJlZSBwYXRjaGVzLgpUaGV5IGhhdmUgc2luY2UgYmVlbiBy
ZXNvbHZlZCwgYXQgbGVhc3QgbXkgQ0hFQ0tfRFRCUyBydW4gaXMgY2xlYW4gYWdhaW4uCgpJcyB0
aGVyZSBzb21ldGhpbmcgdGhhdCBpcyBob2xkaW5nIHRoaXMgc2VyaWVzIHVwIGZyb20gYmVpbmcg
cGlja2VkIHVwPwpJZiB5b3Ugd2FudCBtZSB0bywgSSBjYW4gYWxzbyByZXNlbmQuCgpZYW5uaWMK
CkFtIERvbm5lcnN0YWcsIGRlbSAxMi4wNi4yMDI1IHVtIDE1OjEyIC0wNTAwIHNjaHJpZWIgUm9i
IEhlcnJpbmcgKEFybSk6Cj4gCj4gT24gV2VkLCAxMSBKdW4gMjAyNSAxNTowNToyOSArMDIwMCwg
WWFubmljIE1vb2cgd3JvdGU6Cj4gPiBUaGUgTGlicmEgaS5NWCA5NSBpcyBhIFNCQyB0aGF0IGNv
bnNpc3RzIG9mIHRoZSBMaWJyYSBiYXNlIGJvYXJkCj4gPiBhbmQgdGhlIHBoeUNPUkUgaS5NWCA5
NSBGUFNDIFNvTS4KPiA+IFRoaXMgc2VyaWVzIGFkZHMgaXRzIGJpbmRpbmcgYW5kIGRldmljZSB0
cmVlcy4KPiA+IAo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYzOgo+ID4gLSBmaXggbW9yZSBzdHls
ZSBpc3N1ZXMKPiA+IC0gcmVtb3ZlIHRoZSByczIzMi80ODUgZ3BpbyBob2cgLT4gc3dpdGNoIG9u
IHRoZSBib2FyZCBpcyB1c2VkIGluc3RlYWQKPiA+IC0gcmVtb3ZlIGVycm9uZW91c2x5IGFkZGVk
IGJ1aWxkIGFydGVmYWN0cwo+ID4gLSBMaW5rIHRvIHYyOgo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MDUwOS13aXAteS1tb29nLXBoeXRlYy1kZS1pbXg5NS1saWJyYS12Mi0yLWIy
NDFhOTE1ZjJiZUBwaHl0ZWMuZGUKPiA+IAo+ID4gQ2hhbmdlcyBpbiB2MjoKPiA+IC0gZml4IGlu
ZGVudGF0aW9uIGVycm9yIGluIGJpbmRpbmdzCj4gPiAtIGFsaWduIGFsaWFzIG5hbWluZyB3aXRo
IEZQU0MgZW51bWVyYXRpb24KPiA+IC0gTGluayB0byB2MToKPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyNTA1MDctd2lwLXktbW9vZy1waHl0ZWMtZGUtaW14OTUtbGlicmEtdjEtMC00
YjczODQzYWQ0Y2RAcGh5dGVjLmRlCj4gPiAKPiA+IC0tLQo+ID4gWWFubmljIE1vb2cgKDIpOgo+
ID4gwqDCoMKgwqDCoCBkdC1iaW5kaW5nczogYWRkIGlteDk1LWxpYnJhLXJkay1mcHNjCj4gPiDC
oMKgwqDCoMKgIGFybTY0OiBkdHM6IGFkZCBpbXg5NS1saWJyYS1yZGstZnBzYyBib2FyZAo+ID4g
Cj4gPiDCoERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWzCoMKg
wqDCoCB8wqDCoCA3ICsKPiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZp
bGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gPiDCoC4uLi9ib290L2R0cy9m
cmVlc2NhbGUvaW14OTUtbGlicmEtcmRrLWZwc2MuZHRzwqDCoMKgIHwgMzE4ICsrKysrKysrKysK
PiA+IMKgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS1waHljb3JlLWZwc2MuZHRzacKgwqDC
oMKgIHwgNjU2Cj4gPiArKysrKysrKysrKysrKysrKysrKysKPiA+IMKgNCBmaWxlcyBjaGFuZ2Vk
LCA5ODIgaW5zZXJ0aW9ucygrKQo+ID4gLS0tCj4gPiBiYXNlLWNvbW1pdDogNjgwODdkMDU2NzVl
M2FjMGVkNjMyYmM3YjE3NWFiZjA2NjE3YzU4NAo+ID4gY2hhbmdlLWlkOiAyMDI1MDQxNS13aXAt
eS1tb29nLXBoeXRlYy1kZS1pbXg5NS1saWJyYS0yN2M5Y2U1NTViOTEKPiA+IAo+ID4gQmVzdCBy
ZWdhcmRzLAo+ID4gLS0KPiA+IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgo+ID4gCj4g
PiAKPiA+IAo+IAo+IAo+IE15IGJvdCBmb3VuZCBuZXcgRFRCIHdhcm5pbmdzIG9uIHRoZSAuZHRz
IGZpbGVzIGFkZGVkIG9yIGNoYW5nZWQgaW4gdGhpcwo+IHNlcmllcy4KPiAKPiBTb21lIHdhcm5p
bmdzIG1heSBiZSBmcm9tIGFuIGV4aXN0aW5nIFNvQyAuZHRzaS4gT3IgcGVyaGFwcyB0aGUgd2Fy
bmluZ3MKPiBhcmUgZml4ZWQgYnkgYW5vdGhlciBzZXJpZXMuIFVsdGltYXRlbHksIGl0IGlzIHVw
IHRvIHRoZSBwbGF0Zm9ybQo+IG1haW50YWluZXIgd2hldGhlciB0aGVzZSB3YXJuaW5ncyBhcmUg
YWNjZXB0YWJsZSBvciBub3QuIE5vIG5lZWQgdG8gcmVwbHkKPiB1bmxlc3MgdGhlIHBsYXRmb3Jt
IG1haW50YWluZXIgaGFzIGNvbW1lbnRzLgo+IAo+IElmIHlvdSBhbHJlYWR5IHJhbiBEVCBjaGVj
a3MgYW5kIGRpZG4ndCBzZWUgdGhlc2UgZXJyb3IocyksIHRoZW4KPiBtYWtlIHN1cmUgZHQtc2No
ZW1hIGlzIHVwIHRvIGRhdGU6Cj4gCj4gwqAgcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFk
ZQo+IAo+IAo+IFRoaXMgcGF0Y2ggc2VyaWVzIHdhcyBhcHBsaWVkICh1c2luZyBiNCkgdG8gYmFz
ZToKPiDCoEJhc2U6IHVzaW5nIHNwZWNpZmllZCBiYXNlLWNvbW1pdCA2ODA4N2QwNTY3NWUzYWMw
ZWQ2MzJiYzdiMTc1YWJmMDY2MTdjNTg0Cj4gCj4gSWYgdGhpcyBpcyBub3QgdGhlIGNvcnJlY3Qg
YmFzZSwgcGxlYXNlIGFkZCAnYmFzZS1jb21taXQnIHRhZwo+IChvciB1c2UgYjQgd2hpY2ggZG9l
cyB0aGlzIGF1dG9tYXRpY2FsbHkpCj4gCj4gTmV3IHdhcm5pbmdzIHJ1bm5pbmcgJ21ha2UgQ0hF
Q0tfRFRCUz15IGZvciBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS8nCj4gZm9yIDIwMjUw
NjExLXdpcC15LW1vb2ctcGh5dGVjLWRlLWlteDk1LWxpYnJhLXYzLTAtYzhkMDlmMWJkYmYwQHBo
eXRlYy5kZToKPiAKPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS1saWJyYS1y
ZGstZnBzYy5kdGI6IHVzYkA0YzIwMDAwMAo+IChmc2wsaW14OTUtdXNiKTogY29tcGF0aWJsZTog
J29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9uZSBtdXN0IGJlIGZpeGVkOgo+IAlbJ2ZzbCxp
bXg5NS11c2InLCAnZnNsLGlteDdkLXVzYicsICdmc2wsaW14MjctdXNiJ10gaXMgdG9vIGxvbmcK
PiAJJ2ZzbCxpbXg5NS11c2InIGlzIG5vdCBvbmUgb2YgWydmc2wsaW14MjctdXNiJ10KPiAJJ2Zz
bCxpbXg5NS11c2InIGlzIG5vdCBvbmUgb2YgWydmc2wsaW14MjMtdXNiJywgJ2ZzbCxpbXgyNS11
c2InLAo+ICdmc2wsaW14MjgtdXNiJywgJ2ZzbCxpbXgzNS11c2InLCAnZnNsLGlteDUwLXVzYics
ICdmc2wsaW14NTEtdXNiJywKPiAnZnNsLGlteDUzLXVzYicsICdmc2wsaW14NnEtdXNiJywgJ2Zz
bCxpbXg2c2wtdXNiJywgJ2ZzbCxpbXg2c3gtdXNiJywKPiAnZnNsLGlteDZ1bC11c2InLCAnZnNs
LGlteDdkLXVzYicsICdmc2wsdmY2MTAtdXNiJ10KPiAJJ2ZzbCxpbXg5NS11c2InIGlzIG5vdCBv
bmUgb2YgWydmc2wsaW14OGR4bC11c2InLCAnZnNsLGlteDh1bHAtdXNiJ10KPiAJJ2ZzbCxpbXg5
NS11c2InIGlzIG5vdCBvbmUgb2YgWydmc2wsaW14OG1tLXVzYicsICdmc2wsaW14OG1uLXVzYics
Cj4gJ2ZzbCxpbXg5My11c2InXQo+IAknZnNsLGlteDk1LXVzYicgaXMgbm90IG9uZSBvZiBbJ2Zz
bCxpbXg2c2xsLXVzYicsICdmc2wsaW14N3VscC11c2InXQo+IAknZnNsLGlteDI3LXVzYicgd2Fz
IGV4cGVjdGVkCj4gCSdmc2wsaW14N3VscC11c2InIHdhcyBleHBlY3RlZAo+IAknZnNsLGlteDZ1
bC11c2InIHdhcyBleHBlY3RlZAo+IAlmcm9tIHNjaGVtYSAkaWQ6Cj4gaHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvdXNiL2NoaXBpZGVhLHVzYjItaW14LnlhbWwjCj4gYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OTUtbGlicmEtcmRrLWZwc2MuZHRiOiB1c2JANGMyMDAwMDAK
PiAoZnNsLGlteDk1LXVzYik6IGludGVycnVwdHM6IFtbMCwgMTc2LCA0XSwgWzAsIDE3NCwgNF1d
IGlzIHRvbyBsb25nCj4gCWZyb20gc2NoZW1hICRpZDoKPiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy91c2IvY2hpcGlkZWEsdXNiMi1pbXgueWFtbCMKPiBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg5NS1saWJyYS1yZGstZnBzYy5kdGI6IC9zb2MvdXNiQDRjMjAwMDAwOgo+
IGZhaWxlZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdpdGggY29tcGF0aWJsZTogWydmc2wsaW14OTUt
dXNiJywgJ2ZzbCxpbXg3ZC11c2InLAo+ICdmc2wsaW14MjctdXNiJ10KPiBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS1saWJyYS1yZGstZnBzYy5kdGI6IHVzYm1pc2NANGMyMDAy
MDAKPiAoZnNsLGlteDk1LXVzYm1pc2MpOiBjb21wYXRpYmxlOiAnb25lT2YnIGNvbmRpdGlvbmFs
IGZhaWxlZCwgb25lIG11c3QgYmUKPiBmaXhlZDoKPiAJWydmc2wsaW14OTUtdXNibWlzYycsICdm
c2wsaW14N2QtdXNibWlzYycsICdmc2wsaW14NnEtdXNibWlzYyddIGlzCj4gdG9vIGxvbmcKPiAJ
J2ZzbCxpbXg5NS11c2JtaXNjJyBpcyBub3Qgb25lIG9mIFsnZnNsLGlteDI1LXVzYm1pc2MnLCAn
ZnNsLGlteDI3LQo+IHVzYm1pc2MnLCAnZnNsLGlteDM1LXVzYm1pc2MnLCAnZnNsLGlteDUxLXVz
Ym1pc2MnLCAnZnNsLGlteDUzLXVzYm1pc2MnLAo+ICdmc2wsaW14NnEtdXNibWlzYycsICdmc2ws
dmY2MTAtdXNibWlzYyddCj4gCSdmc2wsaW14OTUtdXNibWlzYycgaXMgbm90IG9uZSBvZiBbJ2Zz
bCxpbXg2dWwtdXNibWlzYycsICdmc2wsaW14NnNsLQo+IHVzYm1pc2MnLCAnZnNsLGlteDZzeC11
c2JtaXNjJywgJ2ZzbCxpbXg3ZC11c2JtaXNjJ10KPiAJJ2ZzbCxpbXg5NS11c2JtaXNjJyBpcyBu
b3Qgb25lIG9mIFsnZnNsLGlteDd1bHAtdXNibWlzYycsCj4gJ2ZzbCxpbXg4bW0tdXNibWlzYycs
ICdmc2wsaW14OG1uLXVzYm1pc2MnLCAnZnNsLGlteDh1bHAtdXNibWlzYyddCj4gCSdmc2wsaW14
NnNsbC11c2JtaXNjJyB3YXMgZXhwZWN0ZWQKPiAJJ2ZzbCxpbXg2cS11c2JtaXNjJyB3YXMgZXhw
ZWN0ZWQKPiAJJ2ZzbCxpbXg2dWwtdXNibWlzYycgd2FzIGV4cGVjdGVkCj4gCWZyb20gc2NoZW1h
ICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvdXNiL2ZzbCx1c2JtaXNjLnlhbWwj
Cj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUtbGlicmEtcmRrLWZwc2MuZHRi
OiB1c2JtaXNjQDRjMjAwMjAwCj4gKGZzbCxpbXg5NS11c2JtaXNjKTogcmVnOiBbWzAsIDEyNzcx
NjYwODAsIDAsIDUxMl0sIFswLCAxMjc1MTMzOTcyLCAwLCA0XV0gaXMKPiB0b28gbG9uZwo+IAlm
cm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3VzYi9mc2wsdXNi
bWlzYy55YW1sIwo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LWxpYnJhLXJk
ay1mcHNjLmR0YjogL3NvYy91c2JtaXNjQDRjMjAwMjAwOgo+IGZhaWxlZCB0byBtYXRjaCBhbnkg
c2NoZW1hIHdpdGggY29tcGF0aWJsZTogWydmc2wsaW14OTUtdXNibWlzYycsICdmc2wsaW14N2Qt
Cj4gdXNibWlzYycsICdmc2wsaW14NnEtdXNibWlzYyddCj4gCj4gCj4gCj4gCg==

