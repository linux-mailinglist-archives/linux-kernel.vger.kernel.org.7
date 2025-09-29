Return-Path: <linux-kernel+bounces-835691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DB0BA7D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 04:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831C23B43D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B38204C36;
	Mon, 29 Sep 2025 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="leak0rxA"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAA21C160;
	Mon, 29 Sep 2025 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759113654; cv=fail; b=PPe9GRnhw3G1MGkfh2Ur5/W9kYhiuie+2Zm/eq7NcHZ24Ql03E+vC2WtNm5JzG25xA3sw5+Xe4ruZPrFjbIvYlHF4ivH/SB6aONr3kcSv/3SSMUFlL+mpZkarjYfjfN/RKwmB2FVQF+cVN59HrmBWxH9VZTyh/lk5fJekME01qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759113654; c=relaxed/simple;
	bh=uIQtd3Dhg8ZLtrPzWzp3L/9r5UyjitMpfFw8BXJb05A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qzyuW6vWO0Q83Q3cr4y6Y9kxpDJ2lUXgiD3xjadOzt5eJO9zRMHhXkciuhNWP+HxdwDc9AHad/yJOY17KkRsNtHsxn2Zc9TQJ1UCGFk0GWvplCXOxf3FeDOK/u+iQ5Zi+zkNzxtHjP3ZEJzHDKS1813KKNOjMPGBM1KL5nV8sZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=leak0rxA; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrxQPt0NnphEb1raTFiVkqvJ80zkA4ZlRAPOOTpOcuAArzYVRK7kKoOQwaXwwRnssfu7i8y9+PcW/XSSl3AyrmvM2pC9ktfpCVhbhkAf7ZjKh5vCb2XswMHf2v/5BQv3S3rdIl6jsIs9K9j0asmlnSyCV9KZTE3+2jBsKh7pWXgEMEmHI2PpQ+dNSJbxCPKVOW8udmy0EA/p9bS16/i5AOOr/aen5Vzd4Bm1HRTw9Xm1MWUmmz6QBkDlmIQsJpJLS9wuuv99M8hU44XEZrDSksIVD5IKfwmENBh6CVWYXSPQoerHF+i49jqWhW+uKJ2689dRM6FBZfzFxQ/QLkMY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YpyBcgT4tcXzbwtlQh0CkkgokUsPVk9FkmGCIgOanc=;
 b=PW5zSD3EwGGL9brQPeGhBEuwMRad2LhmdDinET1JadF3/xBu2uUTpJcPUt2PesSHjDjKwqnjcrCIGpn/sRN8zxqF7uSDYYL6tWNfB7q1HoKod67bQmb5V0lO4UUlRCV75sXNl5v2o0XLk1QG22P6wSDC5DKOOgL002ayYvP2mQXYSMUP0Ep5bQERRVD8sPm/V1D/hHgLBNnUpUEsk4wTwoYCUDDFGv81PUggA3K1OPgukTmYh59XrUqwcCgF2yA3nCR+6V4s2mmk2CkqnvURBq9uaAwDrwa94ZcIFtNCh/WTTNoE5Z8i887Ev8s6NP6mcKfdCnV1HcWR/rhLKQwggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YpyBcgT4tcXzbwtlQh0CkkgokUsPVk9FkmGCIgOanc=;
 b=leak0rxAyUb+fMbCTYz+CWxpPp0EoTDd4fYcGUko5cluLzkrBkUTg8VH+Rmo0p7AiP32Q2z3zc/M1z45X1uIXH3gm3IVy/JbopTrTiD6dQZCzzfmaCylU0dnkI44R21/NkUklt3E7vJvo4Ms5ybif1knp26y+U5S7fXyi/p59zHL3NGJVuOq22x6HkA0P7mNLgcX0FArNujezuiXkLgLAnWgjmcc1TpXzAn43WAjOtu5kjjC77QXKG6pAZpFB0EUDlkZeYuRklKZtKLyOuUfC7RRdwZ6d8/mfrhoJxB4u8qc/HxsTxdEIOdwKH/or+y1ctn5/fnCvBHvGyNDMBWe3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI0PR04MB11722.eurprd04.prod.outlook.com (2603:10a6:800:2ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Mon, 29 Sep
 2025 02:40:49 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 02:40:49 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 29 Sep 2025 10:41:39 +0800
Subject: [PATCH v3 04/14] drm/imx: dc-fu: Fix dimensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-imx8-dc-prefetch-v3-4-c01d0608add2@nxp.com>
References: <20250929-imx8-dc-prefetch-v3-0-c01d0608add2@nxp.com>
In-Reply-To: <20250929-imx8-dc-prefetch-v3-0-c01d0608add2@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI0PR04MB11722:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d08543c-19d4-48c4-894a-08ddff019983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjVnelN5b0t5TDVXK2VGTVZJb294T3VpWDZjcWIwQjh0OHpSSlp5cXdXMnJp?=
 =?utf-8?B?VUt6bUZyRGVKeFZrVm1ONnJkUmdZNkMzMlZwWWVPQkJqbXpJRm84RXNjcHh1?=
 =?utf-8?B?ajg1TEFISzNHYnNwNlFUVllZL2F0MHNRTGcrNUJTQlhXaUZoRlVKM2U2Ri91?=
 =?utf-8?B?NjkySTJIMUMvN3FnU0U1bUkyem8vNmdBMUczQ1g4RGRKQkdzRS95RFhuUGx0?=
 =?utf-8?B?a1AvZmxNVEg2SG0vWi9leGk3dE02ckhBYkp5elY1QXUvbmlHMkhpYTc1UGN0?=
 =?utf-8?B?RHp2MkFIZ1AzMGovWm5tQVduY2tRU1ZNVENRTTZsNURSUnhFenhjbU1mbVEy?=
 =?utf-8?B?UExZRFBtOVZPZVRQV01JeG9vaU1MQjE3VWdHVGZvU1Q5NnM0bU9YVzFFck1D?=
 =?utf-8?B?M3BkaDZHOTNjTGZCQngxZld5Y00yWHVLRGVTSVk0eldTamsxN2srckRNNExm?=
 =?utf-8?B?QlBZSHF0L1p2WEFKaEg4cEx1QUhRSTBKWk5WeFQxM3Znc3FkZzVPUjBzZlAx?=
 =?utf-8?B?RzFrVENqOXNVYlVPZHNWZFl6OUlrRUpIMVpmUzFDNFVXMEoyL3JNL0txSU13?=
 =?utf-8?B?M3E2S3J6WmorT3dlRnhBNHFjK2w0UFVKV1prNlExaVVZaGEyQWJqa2NmTmFJ?=
 =?utf-8?B?MTYxbWh3ZmhpNkpQd3hhcnN5ZXlodTNiSkprY0I0UU5FRlAvOFVLcHMwL1lz?=
 =?utf-8?B?bzJnRWFJT05rR25ld2V3Ti9XSmt6K1hVYkFvVjA1eGpYaFQ1VVMxUXI4KzRR?=
 =?utf-8?B?ZWE5eVdLNXNma2lELzJhZ0tDQ1ltWVE4WUcyL3paSkMzOVJnenVSTGJjVjdU?=
 =?utf-8?B?L29aLzhhSFNySU9NQlNWcjR6SE1GSEJMSTI0UUJ6QUE2R2doc0VuMGR6TUg3?=
 =?utf-8?B?OGNkVGIrU0tjN3dYcVZEL3hXNHJFU2xrQlRseW5NNFdlZG9hcUc3V1RUbCtX?=
 =?utf-8?B?V2pZSS96MkxjOWJJWFUrZ0RnVGZ6SFoxZXBWZk02TjlnMS8wYmVXOEtTZnZa?=
 =?utf-8?B?S3liMnQvam8yMEROZ1RPMUdid3V3eWdrNGRQVjUvZ2VPQ1dRcktWNzlTRXR2?=
 =?utf-8?B?MlhubVhlaTlpU3ozd2VHOEN4elkzSnh3YUdENUxub1U0c0JvTmF4ZzdyOTVk?=
 =?utf-8?B?Q2FaOTI5dWNBMFBRL05oVVBvUzZIcW9QQnNCZmpKaHpRNEUzTkRPU2ZnYjBC?=
 =?utf-8?B?VzFTTVI0Mm1VcmtXZEt4WnR3d2hkSHNsei9DWjNYdSsvdTlYMFFGNUpRTjVP?=
 =?utf-8?B?RlZLMHBVWWErSTF0N1QwdWUzT2UrVXhEUU5teXVwY1hkOGlESUM3MytNL3Fw?=
 =?utf-8?B?YksxVjRCYXY4MHBHRiszNHREMEZPeVg5Qmh6S2Vva0o1MHgreEpXQUtxc1Ft?=
 =?utf-8?B?Tm1HQUtSMVUzQ2FwamEwWWtqTUtTOG9CY3NSLzBadXZkSmZRd2gzKzhpWUpZ?=
 =?utf-8?B?RURyTkdvQjVYcHd5NmtMOEh0eFpONUt5MnEwNnFzSG83TXplNHNORHJWVzNZ?=
 =?utf-8?B?M01nU3pVWjZnaHVqdC9IeVBCRnZEaEdVWkowNlNBNEIyNjJTdEZENVU2V2U2?=
 =?utf-8?B?OWxEc3ErOTF1Y0FJN0ZjZDdtUUVpQnI5aVZGeXMvaDlueTE1dlI4b2tlQzgr?=
 =?utf-8?B?aWtiR0NkYmQ1RmVleGdjWTdXU3ZEUlN5VWZKVVRuanhUM3VQYzdZaG5xRnNy?=
 =?utf-8?B?cmF1QWFyRDM0QjdwSFErcnVmdEJHNlNyS1l6N2lieDVLaGZ6WUw5bFRieENI?=
 =?utf-8?B?QU5xZXE0d3IyS2hBcEsyZTJmbnM2NGtScHloY2ZvdFdaVFFTcG9XampydHIw?=
 =?utf-8?B?RVNtMTAyaGxhd2JjMXJoa0FnWUJaU3BuOXlxekFPazhZYlhwZnRmS0JkQ1Nq?=
 =?utf-8?B?aUxUZG1ueHdQVWEvdlMySnlMd09wWmxPM0ZxRFFhR3pkTHp6ck8ycnY5Y0xr?=
 =?utf-8?B?SlhOLzJLWUd5Mk9JSW9aWDNRVzh2YitaNGhWOE0yZ1duT0ZjYXVGZVZwblJY?=
 =?utf-8?B?Nmg5cy9BUm91ZjE4cXFzY3RuQ2VOWFhVNmVDUWRqckg1bEpyRUdKNEpjcWtr?=
 =?utf-8?B?YzdTWlc3MURyOXF3VWZBMjYxTUNxNlZEaHh5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0NraEEvM0J5MmV6TWJMYjNLVVF1TlBhR1JjQ1dPVElodU9aZ1V1cC85VVZa?=
 =?utf-8?B?dlRLRWJOS04rV2lvS1EwMHlmcUdodGtwUVgxV3NjUnNBSFR2UENRLzg4aENj?=
 =?utf-8?B?N2VtQ2dQOWdidklqTG44YzdOQ3NEb1pCdzZTWjdnU2NCS2JDeUZnZDZzUU1S?=
 =?utf-8?B?VlJZbEVhL2wxbmFnbk9zaThFRDZmNEJQeTFlMHFPdE8ybEU5UHFKQW1kUnpR?=
 =?utf-8?B?ZFJnSUl3UVo0aW9JcllFMHltb28vaHVITnNDVm44c0J3WjU5TDkvRWZhZDJk?=
 =?utf-8?B?WXlaZHVEeVlQVTA4b0xkeEV6SFZDRWlpRTNCc01PQzhNTTFiNE50SEIxbndY?=
 =?utf-8?B?NWhIY05jcXVUZmZrWjJvdnN3Y1NEUHZMbFRqN0dETDFXSzIwZXlSdE5CSDFO?=
 =?utf-8?B?UXFkL1gvKzY3MUVQeitLN1VrQ2kvVS94azUzMkozVE10cUllY1ZiRXVuUXMw?=
 =?utf-8?B?RXlvWThaOTFXdDVaK09VZDVXQXFhSWQ5MTBQenpudTZOVVZCQU1XRXN4bXNU?=
 =?utf-8?B?RWY4NGQzYjlBL2RIbEllOEhwSWRTVndZTzRsYk5YMlNxK2IvNnZqeHBHNzNj?=
 =?utf-8?B?NmYrYzkxL2h6WEZhaFNYZnY2bzBrR1ZENk54YjQ0YkhIbWhURHpZWUZ6K2k2?=
 =?utf-8?B?eURsR3FiYWZNdzJYYTVlQ2pYdDY3dk9nWURTTVpLVXFFdHlMQWJVK1hOY3Nq?=
 =?utf-8?B?QkFaNWMzNXl1MDRWc0JVMXYwcXd5Q3lTai9NUG5zV3RZMlBLSkUxc05teWEx?=
 =?utf-8?B?bUQyOFlHdzRpMW1xeXpNY0dBdG82QzhjekIxOElISy9YelhPN3RSYUI4T080?=
 =?utf-8?B?Wkt2R0pZSWM3cmtCNUw0d1dDcXdoT0s5VlJOdXRYMmlUWW5kWHRtVGI5SGh5?=
 =?utf-8?B?dmV3NVlsWG0yQnNUUXZiWCs0ZklmTXBBRXhKUW1ObC8xcWFIeFJESSt6ZGFG?=
 =?utf-8?B?eWduY09pMWhRMTFHOGJHV1NkenpkWHNhWk5kVEdEYlZpNWlCNUVQOFA2R0F5?=
 =?utf-8?B?NFRKc2RkUnhzSURGdXlhS25BanJIVno3UEJ3c1RtYWhtSHp3Q3YzVnJYSkhB?=
 =?utf-8?B?NVVFbjduZkpNYlRKZVVENjNzcy9IRy8yWCt0SU5jWE9yVkhDY1FqT2J0L1VT?=
 =?utf-8?B?L3RlQlR3WUluV2phUUNsdTdjaTRpU1c1VDhQR2FyK0RaQWRxUHl2UGNib0Fp?=
 =?utf-8?B?UHNPbG5NVTRqVXFvMzBZMmloS0gwRVNiTDYzWFhYZ3Qwa3dxWlZKVnVoUDZp?=
 =?utf-8?B?RFpiY3RSdFozQmR4NHFuZ1gxUHdYdzdVMVFUalo5M1UzSGN2cElhNzRqNXdW?=
 =?utf-8?B?MGNPNkpjR01COVdtV1VoMUFUOWpqMXRYUzVlTENQa0VobVJKZTB4emxxN2cz?=
 =?utf-8?B?ckxjdWJONjF3cS91N0dWUENIMkd0VVBoNU1FQVdSREIrOXBHR1lBUVdlM2FN?=
 =?utf-8?B?ZVNDa2lDTnQwOFc1Z1ZoeEpGWkVKOHJzK2dVV0haRmJ6NmVoOHIyUGFRTWI1?=
 =?utf-8?B?SDlsYzFuN3ZmbmZVVnBBMTJFOUFZNG45Q3N4WHpScCtqUVpRZjF2WVNLWndp?=
 =?utf-8?B?dU9peEJrTm5pT084NUhPZGlMM1dpQTBRWEpsd0JmRGRkNzRkYS9YZG0zbXE4?=
 =?utf-8?B?MWZuWDVrUnBWQ3I0V2swdjM4d1dWblhOcmM3QSttRi81R2I1VFl2OS85Y1lU?=
 =?utf-8?B?Sm9HQVQ2SVlDTlllRGRxeHBVQndURFBXYUgydmhHc294NzFaWG5SL0ZJMjM0?=
 =?utf-8?B?SUF5S2ZpajhCbVV1QlcxajdpaDBFOTdoQzMyR3dDL1MyM0p3Ry9NZHdxZEFh?=
 =?utf-8?B?eit5bHpHT3ViRzl2bVFKSVVlL3BWQjRiZENnQ3dudk1LVjlBQWRNb1BuUHdL?=
 =?utf-8?B?bGFqOU1EeTFwU3huU1VwTkpHQm9wQitzNXZJR29OMGxOK3Y0TlNTK1ZJVWZY?=
 =?utf-8?B?VTQzN1FDRGNGaE9xclhOQVB1UHArRmJqV2xOVWNpbHJkeVJWM1lyclJEaUVS?=
 =?utf-8?B?NmFmWC91OXU5U2ZoMjg4WjBGenpHL0M0T0tYQUp0cE9nUmM5ajYxeGRsWXdZ?=
 =?utf-8?B?eXZPTmhObGRyanV5TERPcTUrSnMwMVVSb0xpZFdaVThiN3lmL1lUbHQvZ1Ns?=
 =?utf-8?Q?dDHrJJTktmOTzA17ems07eFCy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d08543c-19d4-48c4-894a-08ddff019983
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 02:40:49.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3ZZO5cZ4Wk81iLYqvZN35pO2FIVPm0TQgTskGY/pVO+1+yJhOPNr/NwDA+3hcDe7bxNqkn4WklfluS96w5BGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11722

Fix off-by-one issue in LINEWIDTH, LINECOUNT, FRAMEWIDTH and FRAMEHEIGHT
macro definitions.  The first two macros are used to set a fetchunit's
source buffer dimension and the other two are used to set a fetchunit's
frame dimension.  It appears that display controller itself works ok
without this fix, however, it enters panic mode when prefetch engine(DPRC
and PRGs) attaches to it without this fix.

Fixes: 0e177d5ce01c ("drm/imx: Add i.MX8qxp Display Controller pixel engine")
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Alexander's and Frank's R-b tags.
---
 drivers/gpu/drm/imx/dc/dc-fu.c | 4 ++--
 drivers/gpu/drm/imx/dc/dc-fu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index f94c591c815891468a5c2a940076963eeaa4d51c..b36d3034b8d5962eaab212b6b65ebbb5c29f978c 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -31,8 +31,8 @@
 #define STRIDE(x)			FIELD_PREP(STRIDE_MASK, (x) - 1)
 
 /* SOURCEBUFFERDIMENSION */
-#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
-#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x))
+#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
+#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
 
 /* LAYEROFFSET */
 #define LAYERXOFFSET(x)			FIELD_PREP(GENMASK(14, 0), (x))
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index e016e1ea5b4e0471cf6627782603e72d0475c4e8..518d1af49f5ae9d4f67da5e6c2e80abd7e962120 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -38,8 +38,8 @@
 #define SOURCEBUFFERENABLE		BIT(31)
 
 /* FRAMEDIMENSIONS */
-#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
-#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x))
+#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
+#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
 
 /* CONTROL */
 #define INPUTSELECT_MASK		GENMASK(4, 3)

-- 
2.34.1


