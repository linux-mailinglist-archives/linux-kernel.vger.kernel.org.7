Return-Path: <linux-kernel+bounces-892339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF0C44E37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 270D24E7612
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6902B290DBB;
	Mon, 10 Nov 2025 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KU90jemi"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D01CAA85
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747377; cv=fail; b=WGrYUIx27F2eLQaGmtz0OS+QByO8rGexoMPuvv+0n1M667cMTyEmg42X/PskSn/THJfy/sZMtWyGuFxO0PjW0xBlj1OEOtDqgwehhx98eMJJbp8OBPsVZi7ous9Kw58vNu+or/xmsA6cUz0J0z5QI033SX2kZDFEMFaviGb/wsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747377; c=relaxed/simple;
	bh=LvC0PmwvBMqiF7BBsuOHVhxvnan6UTT022JJSyC44uc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=agfD/GZ8XE+EE7v+9ScO7ZBcTBNk4fGO7DxV0aDXT9qTeqI6n15USMnUhzWMDwsrRQCjEGIet1MCSn9VvLrV2QI2t/vqpIOfSi8DIKBSJMx5glYSpNM+Djo11hBKbIDEClPXkJDV13FzMRYLXHr5biLJjPp+DaeAQZw92dxMik4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KU90jemi; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg5Rmh1QydN4PwUCivo4l+RN5flYZTbC9oU3ikJij2X1vYcNE6tsegvQJVojxun4DFmw3HjzQ+vhUJ83wTWKaGaxDUy82m8uj6n31hsX6bubwmxuIaxQlSNTlGgNFl1iq6RyOCWWeKS0/yvYTYeJqZ+aRmfT41zqX52bVVu1kuLo4CYTmWZPJHT99c6GxwjBgnoZpOXR1EcT4lGY+QrEfKKwHaebLsPzsndlu5a/alCrLyOQQa1g6G115Ne5c7Uttj8bKqPj+HzxwvKaczWUm0qZeRDqJe5tcFMHGKMRLpt49aRDPorUPm4WMOkXuTFDvVVgYtcZxnNAqYWwo1yyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VdRXG8yQm0f5VCUNIIQVjhY0WlA6uOMcY3O7bW7NVE=;
 b=rrYhZO3xaQa9OgzCYQUk7600+5vFFvOYKg7tBG99nNa1zsn0fTf5IXa+JWWcmLtLRNtDx1T0FKnlxu4eIK3Xq4cbGF5nCxGnEkwcBvcBpNbnsdHU8x4DPNlaqe1vUfvFDgZLtMQEGDx7rXK4N21+41bUBU/bVs2nh2Dfud8MUvx2AzkgZ1qiSJ8e+0ug+pQT12Pjo4kblS9QOppxibDJt36JMEGm9jwHP0YQlVC252JwmV8A/2bTMJh4UJ0xWyfAPyKWMeKgwii9vvc91xmXMUHqDastwnqcDdO/5NF66hw3fwBgIY37QHJKNipss16I4DUmC16SMfVdH9sFsEpfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VdRXG8yQm0f5VCUNIIQVjhY0WlA6uOMcY3O7bW7NVE=;
 b=KU90jemiazsT0FKkuS8UgmiKRiSxUVuaHG7CF8HA2W8iHVzSFZaXbQ4jq/WVLpCeFgAkdau1ewSzhTKRJLFa2XRIxbb/ZtKYXdXFTJiGGT5Dx4qTGT6NAGJAmOJQEeyuKISo9fHIy+MeP+iMidtbYUyR70Go642FehG+eMytSBvOhkk1yPW9vXbQ2zw9gbfdv9gUKuSLU0Kgj3IIXsZoNETo6Rsqdehfg2jc1/8Aicc5/X+SkySqX1ln1p4dEN2dqbgMY418CCYt/cKZUDyfIv+ZAGzYMGuTloK7Aj5iqyN+l9OWwuznyeenwwwAy8aAsss2G3TrI7Vgr6iK69dJdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI0PR04MB10949.eurprd04.prod.outlook.com (2603:10a6:800:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 04:02:53 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 04:02:53 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 10 Nov 2025 12:02:58 +0800
Subject: [PATCH 3/4] mtd: spi-nor: micron-st: add mt35xu01gbba support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-nor-v1-3-cde50c81db05@nxp.com>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
In-Reply-To: <20251110-nor-v1-0-cde50c81db05@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762747415; l=7106;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=LvC0PmwvBMqiF7BBsuOHVhxvnan6UTT022JJSyC44uc=;
 b=0MDJnc9TeSJuYltz9q4zLjIn6poEM1Zh98rv6vBFfAomkeCy8+2UXncBDmRB5Po4N+ypYPubW
 gJbmCcmszcwBhtj5iZvSPNry97FUkCzO2sEP2u4XmyUf3JD67JGfgwf
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI0PR04MB10949:EE_
X-MS-Office365-Filtering-Correlation-Id: ea41d55e-cdc2-40f1-51f5-08de200e05ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NldKaUxHOU5vNTg3YWpTd2wyRUZFT0xKbHhYL2pqNmd0cmhUc0YwNnc1TWRk?=
 =?utf-8?B?d1ViN0l6ZUJldjc5cnBvMXBBZWl6NVNOTWd2UmlOL1JRZE81SDJIZVNsSXk0?=
 =?utf-8?B?QWF3WmVvazA2NGExRnRqUFNzRklKcThnM05WeTdGNkVKMXgyK1RXeGNkN0ZY?=
 =?utf-8?B?M010c3J5SHdWVThITmo1MkkwV3o0Q3h2ajhHb0NTc1BJMldSUWlacG1hSGcx?=
 =?utf-8?B?aFBDbmhOQ1VvaXViVys1RUlhbXNtTDRYbGU2bkhiVW5KeWNRREJ6NUtmZko1?=
 =?utf-8?B?MUlPNHR3dGJkcHNVMzFZWWZ0bWtldEY0MUFvZDc2OFRPSWNwMHdWemdUR0V0?=
 =?utf-8?B?OXlkNVdKbGdnZXVFOUVIRk50Z0YrSkUrMVlwU29KNEQvaDl3Ym9JN2FEWjR6?=
 =?utf-8?B?em44Mm9kSkRMMUsvT2J6ZWtOczdwS2hnTkRJTStPVVRPZ3RhLzBhM21xTjZs?=
 =?utf-8?B?Z1llNlIvOTgyNXhVMzVJK0VTc0VxcFZMMkM0bS9ESzFKZWpOek5ZVDVvSjQ5?=
 =?utf-8?B?NWNNcjZqMGE3RWl1bU01aUFIaTJOTERZN2dWVXNBWDdFN00wVU03KzdXMGFn?=
 =?utf-8?B?NXcrUFlEWUVyY3BEand0WTUxL0lLaGQ0TlV0Z2JFd1ZFTlhyMkIxUDdhMC9C?=
 =?utf-8?B?ZlhYVngwMXVMYVVzR0F4eVNlbUwwUlQ3YlZnYk8zRm54Z3VPRWRzRi9tSWNJ?=
 =?utf-8?B?TEowZE1Jd0k5REN3ZGhIRHNvMExPbWFxeXlUTmNMYy85VHZ0SUtQQy9CS2h1?=
 =?utf-8?B?VmFicy93ZzljazRzczd5ZnpUQk9MbWdYMHYzeHBzSWxNWkRPS0k2OTNBK2FF?=
 =?utf-8?B?dVZ1NjRESHdGZzhXeVE2bEIwRm1INEFKT3d5YVpOTWxrK1VLYnM2eTNZS1Jk?=
 =?utf-8?B?Rmg5REwwSmNpejY4MDJqTlFHU2pVWUVOcFk2MXgra0V3d0lqL0tLRjR2dHNK?=
 =?utf-8?B?RG9qL1I3VUQ4ZkpOVU0vMnRpWFR2Ni9rN0loRDRsTVB4UTBVcGZEbVJwcmh2?=
 =?utf-8?B?VXdKWVlENDJrMDRpaG45a0o5RFpzUHFtYUVycGxCM2sxeUtIYTYyeHN1dUpJ?=
 =?utf-8?B?eUM5NmU0akJGN0RuOU9yQi9BWTlhb0EzWk5hc08vZGZQZ3ZMa3ZyYVM5WGlj?=
 =?utf-8?B?UVluUDIyamlFTXlDUHVSZS93bUFvQ1lKMlBJK0JRRVZpMjh5aHNEdjVOUlJE?=
 =?utf-8?B?MUVOYUdiN0NFZVkrOHB2K090RE1ydGZTTnV2UmxGV3M2ZUl3UTBaOHMzSVJh?=
 =?utf-8?B?UERPMmkxYTZDemkwVy8zWEhYNmxsTjA1WFduNEpLNjduOXdVVXlmampEK1E1?=
 =?utf-8?B?MklrMVY2T1BzeDlEcGhsNWN5Q0dUeTl5amhRMnRTVGtnd1VzdklEWGx5LzAv?=
 =?utf-8?B?QXRaYURkVW5NcmtJbXVnU2l6c3owUXdRd0tiNzdxWVpQK1BaVXVFTzdNZ2Ni?=
 =?utf-8?B?bkg0T0MyOU1udXl4eTBPZWg0OGdWTUpKdkRFajlYTG5tUEt5clRXV1dyR0Zw?=
 =?utf-8?B?Z0xlYmlnYklUVUszQVBYMUxxK0JvaXlkbTlrY2NEeEpKSFQ2YUFMK0ZFQ2xp?=
 =?utf-8?B?OWZia3ZTektlSzZaNjNLUXhja2dkdVp4WHpNajltUFhwM1FkbFNoQWZSQ05a?=
 =?utf-8?B?VC9vVnErSGtCRUhySEdKcFJKK3lvMUFrdVlMd1dUVkR4Zm1lRjB3OVNGdWZY?=
 =?utf-8?B?NE1EOWljZ2hsczkwTWtqQW8wTVplQlJCbVQ0K0htUGVwM1V1eVlVM2E2MXA3?=
 =?utf-8?B?dTRmTlNHMXd0Snc4dS8yWFNmWGd5UEpZNHVEUktvRCs4anVHMEVvN2MyVmlz?=
 =?utf-8?B?a2htMlgrWXQ5c0psc3kwN0EzbzFodnBscUNqOHpwalBJblF1cnZPTkFwSzhm?=
 =?utf-8?B?U2l5UEdSMzBCcldHUVJ1MHF4bXAyWU1FK0ZOT2wxQ2ozWTJSTUYwOTBPbHdF?=
 =?utf-8?B?SmdiTm1SdTZzRUdQVHEyTWxhRXlCNHVrcEYzejB2NFh0L3BmZWZhVkozZWFV?=
 =?utf-8?B?em91UEZNcllRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2VuRE5pS0NTQmVOK2ROZTdZWHRQTG5kRmRVYVBJNUZ3dzdQR040OWJRY0ZS?=
 =?utf-8?B?WStpam5uc1lSN3JucCtUT0ZTSjFud3BnL0tJaDNjVXNQcEdIT1NCNGl1QUty?=
 =?utf-8?B?YVVpcWN2ckxMbzZSblBTMnlEZllQY0JHa1pEazB0TllpMzNHeGVjVytCamVn?=
 =?utf-8?B?YU44eFZQYS9ZQnF1aGl6clFvNXh6MWdQK2l0elNDRTFoc2luTTlBUlJMamR6?=
 =?utf-8?B?dmxadStIbVMrMW8wY1R3VVQvakZra0t5T3B2UDAxU1NrNHM0c3pDRFdSLzdv?=
 =?utf-8?B?QXVKL0NWK1F4b3BnSlRHL21NOHNZM2ZuZW9JRWQzcElSQ2ovOGtNZWI4em1j?=
 =?utf-8?B?czRlWlJXbEw1OXIrRHl1bFVFbEdTeGd3QUNGK25SZjZuVUVjVWlyZTdYQWpx?=
 =?utf-8?B?ZTkvZGs4NXcvazJUU1Q0YldUeSt5YnJPT256ODZJTHY5Q091T0Y0QWt2WFk3?=
 =?utf-8?B?SUNwOVhkMjNvcnMxejBWYkZyYjkwS1FsRFdidWhjVnozZjB6THNvMFR4QzBx?=
 =?utf-8?B?a0FNM0xIanl3dDh4M3kweEwwenJ5c1loOXBRcjRYVXdKWFFXUjB2NUJjTW9D?=
 =?utf-8?B?eHBNa0lTeGVGN2RVYXFjN2M4RkxaU041Yk5QUHloanJFbDhCSExIQTVSZWY4?=
 =?utf-8?B?dCtPU0EwT2Y0YXVZaWJDQVNKUnE1K3hTOXNOOUNBbVdNYWFTWjB0Y2oyV3Nk?=
 =?utf-8?B?cXhWeTB1dWlyMGdPWWpZdkZhTWRuQ01ONVFBQzIzaXlNL3JlZnFJS0ZWNm9t?=
 =?utf-8?B?Q1ArZTIwenV3T1NWSHZicFVyNnEyajVuR01VSFhuT0xiQWZiVjdDTytvM091?=
 =?utf-8?B?WlN5c3Zjb2pLUm51NUp6OVlOQ2lSdW9YYXFwaG1rMzhQL0hyNlVwTGY2MXJs?=
 =?utf-8?B?bHZuNm5kQzFJcVc2ajY4WGM5YUdxUENyZ0l5MHFCM1BRRDZhL2VUOXp4MG0w?=
 =?utf-8?B?bENGRDVsckR2bjF0ZWxrMWwxTFFRVTVzUGJ0M21WNjlwZUdDdFBKZDNVanZF?=
 =?utf-8?B?ay9DY3c5djBaWkZCMk52aEJ3VG1VQ0E4b0tYK21QUHJXQ0dGdWxRSWEzN1Vt?=
 =?utf-8?B?blNlaUJ5S3dXQW9tOG9mL3IvUW0xL3h2WnRBSFRaVVR2aEhiK2RBSE8rb1Ey?=
 =?utf-8?B?aFhkT2NDdWt3WmJtVG9WdVJGanZqa3V5N25CaEhFczU0REdxcnZUWjJscGxG?=
 =?utf-8?B?TWVPY2dORUpxNmI2U2hzRHE4NGxKQmdvU2E0bWxKYnE0ZmtEa0hVZTBVaHlj?=
 =?utf-8?B?ZGZpZUcxa2szK2I3bXcyNk5vY2R3MDNtM1lVL3FUVFFTZXlqWHhoODc1RzFV?=
 =?utf-8?B?TTduRTdMeEpZUWNzcE5PNmR1VFR2V0VGWS9pUUFwVEg5SkxhaWFjRjI4alJ1?=
 =?utf-8?B?SEVXYXZzaG01RkRxNC9wQkg3eXExMjNrSDN1cFI2alZlUENTQVJGT3lxTUJ6?=
 =?utf-8?B?QUY1QitZa1ZjNFRQY3hOaXlDT0JhTjEyL044TzMwQTFaVVRtTXU2VzlrVFRK?=
 =?utf-8?B?V1dRREZBZWQzSG9ubzN0WkRKRFpVSmhlMUhnTk1UR2FmaEVKbXJ0TnZDV2dF?=
 =?utf-8?B?aERYTXY0Z1M3RHJBMWxtS1E0SlR4RGlRaWxaK0E4UEpHcEQyNTdQN0RFTUF4?=
 =?utf-8?B?Z3A3eXBCcFpMUVN1bkpYT015N3ZaWW9ZNGtvK0o3VzdWdmpKaEhXU21CbEw2?=
 =?utf-8?B?MGxody9Yd0RITVI2ZHBCNHBnQVYzUWVDc1pjejFPakt0WC94UzNRMkd5M3Jl?=
 =?utf-8?B?NHNJMTdIQkN1ZWV5OTYwMGNhS2U2SDB0REtUZ0w2eW42eUEvdVdCODJvdXJ6?=
 =?utf-8?B?eTlQZ0VVbW00cG95bVdhUW1GOU44dlJmb0xKdFgzb1J6R2ZCMzNWeGRBMlpE?=
 =?utf-8?B?RTZoUjlxazZsNkI4cU00R002ckZDQW0rZFByc0R3K2lJVlVMUCtuREJDVnlB?=
 =?utf-8?B?bk9lUXJya0FIZUJlVFJ5Q1N0anNzM1Ava0w3RGZ6c0hwQTE3Ni9MK1FhN1VN?=
 =?utf-8?B?UDUyQ1B5V3pHUUwrazRpY3Q0eWN6TWR3ZW9wYWtUWkNCaVFGNitxd1RJMGpn?=
 =?utf-8?B?TWZ3R1dXSm03bjBYSU5NRzhtbUY1SUduLy9YaHdzOG9QOC9UWWcxeUUzcEN5?=
 =?utf-8?Q?Sg1PTKxEUzQ5ZyuXNrmK0r9NE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea41d55e-cdc2-40f1-51f5-08de200e05ae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:02:53.2427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NegxDCAfMa9QnXQtuKeVITZsmyvnfaTnDrfVzpX34JW5phN9iRRFfh6y8lD5ohnkQyUJmjTkr3hOWYjSGTL/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10949

mt35xu01gbba is similar with mt35xu512aba, but with two dies.
SFDP contain the wrong size, so define the size dierctly in
the flash info. And it also support 8D-8D-8D mode, but SFDP
lack SNOR_F_IO_MODE_EN_VOLATILE, so add this fixup flags here.

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

---
1) This mt35xu01gbba is populated on the imx95-19x19-evk board, was
   tested at 200MHz using nxp,imx95-fspi SPI controller.
2) root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/partname
   mt35xu01gbba
   root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/jedec_id
   2c5b1b
   root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/manufacturer
   micron
   root@imx95evk:~# hexdump -Cv /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
   00000000  53 46 44 50 0a 01 03 ff  00 08 01 17 30 00 00 ff  |SFDP........0...|
   00000010  84 00 01 02 90 00 00 ff  05 01 01 06 a0 00 00 ff  |................|
   00000020  0a 00 01 08 b0 00 00 ff  ff ff ff ff ff ff ff ff  |................|
   00000030  e5 20 8a ff ff ff ff 3f  00 00 00 00 00 00 00 00  |. .....?........|
   00000040  ee ff ff ff ff ff 00 00  ff ff 00 00 0c 20 11 d8  |............. ..|
   00000050  0f 52 00 00 39 61 99 00  87 8e 03 d3 ac a1 27 3d  |.R..9a........'=|
   00000060  7a 75 7a 75 fb bd d5 5c  00 00 70 ff 81 50 f8 a1  |zuzu...\..p..P..|
   00000070  2f cb 27 8b 00 00 04 01  00 06 01 00 ff ff ff 8e  |/.'.............|
   00000080  00 00 00 00 00 00 00 00  00 00 00 00 ff ff ff ff  |................|
   00000090  43 0e ff ff 21 dc 5c ff  ff ff ff ff ff ff ff ff  |C...!.\.........|
   000000a0  00 0b 80 9e b1 81 b5 85  00 f0 ff 9f 00 0a 00 00  |................|
   000000b0  00 0a 1a 88 10 00 00 00  ff ff ff ff ff ff ff ff  |................|
   000000c0  00 00 06 01 00 00 00 00  14 01 81 03 00 00 00 00  |................|
   000000d0
   root@imx95evk:~# sha256sum /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
   3848f0bd2436d7ca1373cee33f90e09d6479d0f4dc4bfd19f6a082d9e0039495  /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
3) root@imx95evk:~# cat /sys/kernel/debug/spi-nor/spi1.0/capabilities
   Supported read modes by the flash
    1S-1S-1S
     opcode        0x13
     mode cycles   0
     dummy cycles  0
    1S-1S-8S
     opcode        0x7c
     mode cycles   1
     dummy cycles  7
    1S-8S-8S
     opcode        0xcc
     mode cycles   1
     dummy cycles  15
    8D-8D-8D
     opcode        0xfd
     mode cycles   0
     dummy cycles  20

   Supported page program modes by the flash
    1S-1S-1S
     opcode        0x12
    8D-8D-8D
     opcode        0x12

   root@imx95evk:~# cat /sys/kernel/debug/spi-nor/spi1.0/params
   name            mt35xu01gbba
   id              2c 5b 1b 10 41 00
   size            128 MiB
   write size      1
   page size       256
   address nbytes  4
   flags           4B_OPCODES | HAS_4BAIT | HAS_LOCK | IO_MODE_EN_VOLATILE | SOFT_RESET

   opcodes
    read           0xfd
      dummy cycles  20
    erase          0xdc
    program        0x12
    8D extension   repeat

   protocols
    read           8D-8D-8D
    write          8D-8D-8D
    register       8D-8D-8D

   erase commands
     21 (4.00 KiB) [1]
     5c (32.0 KiB) [2]
     dc (128 KiB) [3]
     c4 (128 MiB)

   sector map
     region (in hex)   | erase mask | overlaid
     ------------------+------------+----------
     00000000-07ffffff |     [   3] | no
4) root@imx95evk:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
   2+0 records in
   2+0 records out
   2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.0207974 s, 101 MB/s
   root@imx95evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
   root@imx95evk:~# sha256sum spi_read
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   root@imx95evk:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
   Copied 2097152 bytes from spi_test to address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# sha256sum spi*
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_read
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_test
   root@imx95evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# sha256sum spi*
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_test
   root@imx95evk:~# mtd_debug info /dev/mtd0
   mtd.type = MTD_NORFLASH
   mtd.flags = MTD_CAP_NORFLASH
   mtd.size = 134217728 (128M)
   mtd.erasesize = 131072 (128K)
   mtd.writesize = 1
   mtd.oobsize = 0
   regions = 0
   root@imx95evk:~# flash_erase /dev/mtd0 0 0
   Erasing 131072 Kibyte @ 0 -- 100 % complete
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
---
 drivers/mtd/spi-nor/micron-st.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 89cd146095584ddebdd258a186f6398b420e5800..f724313f4dd3720908968c670e8d3d58f41c099c 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -208,6 +208,12 @@ static const struct spi_nor_fixups mt35xu512aba_fixups = {
 	.late_init = micron_st_nor_one_die_late_init,
 };
 
+static const struct spi_nor_fixups mt35xu01gbba_fixups = {
+	.default_init = mt35xu512aba_default_init,
+	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = micron_st_nor_two_die_late_init,
+};
+
 static const struct flash_info micron_nor_parts[] = {
 	{
 		.id = SNOR_ID(0x2c, 0x5b, 0x1a),
@@ -219,6 +225,16 @@ static const struct flash_info micron_nor_parts[] = {
 		.mfr_flags = USE_FSR,
 		.fixup_flags = SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu512aba_fixups,
+	}, {
+		.id = SNOR_ID(0x2c, 0x5b, 0x1b),
+		.name = "mt35xu01gbba",
+		.sector_size = SZ_128K,
+		.size = SZ_128M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ |
+				 SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP,
+		.mfr_flags = USE_FSR,
+		.fixup_flags = SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE,
+		.fixups = &mt35xu01gbba_fixups,
 	}, {
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
 		.name = "mt35xu02g",

-- 
2.34.1


