Return-Path: <linux-kernel+bounces-877052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D51C1D11D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED9C189C4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6035BDD8;
	Wed, 29 Oct 2025 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oip2qaEb"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD035BDAC;
	Wed, 29 Oct 2025 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767709; cv=fail; b=ZfAjy1K82xTN2lwpAUZ/PEzDVJcFOuB5K5du5vegKH4jO4Cyd9b8uRgzdotQQulmZNlETGjzyLstuQdWl5lX9KOvSDs6i7B1QNMB4wOW4hpQLxP0LoOsUtK1DZEQu0mRQft4qUAt4vBFCOdIgjuPGbAHG64U272r2b/iVNL6oJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767709; c=relaxed/simple;
	bh=Sl6xysDJw0nHVThbTASABsjnOojpINxjxOhE2W/YKG0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SvxLf5uZsRq2ckohp6MQHSZmJSTs3/RPhjIwS5AtvydbBhMyEkQ0cPW/DmwdbYBx5DwTYQ7tQ5JyeCrlr7c0mQGroCfOEBEeKdYPZ1zMWv/TA76iGTkrkBywLiUlLFUloRfdYA35zB7elJcp2FczbzrIXZNUGvDFLSqp9neKkWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oip2qaEb; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z79we3boh5rYXfc5VegwXAtNrj2gIPmEvAaLTVXDBfhxfAGuYhENC4QZO/XJAoXhfRxN+vRQPeHAhLS928Spf11wSStenDehiDE25/7+O4Ykz8pUSFINlCxdsR8J0tbbX1Bd14trs89dkbaCL6T2Ozm0YUd12I5tqbU0mZkgdzHlGWts4cd2kKV/ZVdh+G40gyUuoyIhLCP6cKog1AtyOyO50orim2kL+dBETX5+UfXGyVQNXPiUmwsI26Y8asQ5kXqOCzva86CVftTE2tLnGPYyLwDqvSL+LZwKrCtfTjrCTVSkNUZ9f2wSrnKdrWpKfy7ilRff5noOO+Hw8zrGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbhh7juj7j7WGlQWhGuq2TD6S8uEuLDxRKne2pOsrT0=;
 b=USeUj4BnMcG5KOojhoVtnqfi8xTRE5AMNRoIbVgGIvaEGBdb2qDG3GnD8ereAxOXv35UprDQYPrN4T9YqKq3lfSuM1W6Ro0UrHACj81TDfgtvrlKulH37ObJZH7zSiDhw6ADqW5FPsIx1Y1ce4bQqFNxfV4SwcXOXODqplhsq7/87ywuNUUAYbxm23bo73LgdmLxBg3cJSBdyI+I/MMzG9HSaerksUdKde3lTH6YLPlCuw9qDszkf6WHIBD2Wwc6sG2zzVsNPfw3anE5rGHMDXVKjEn99EkL2jrKptw9BTbmQucPfm50e21DRclwwjAyUcu+hB3s4FE5y7xoeEBnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbhh7juj7j7WGlQWhGuq2TD6S8uEuLDxRKne2pOsrT0=;
 b=Oip2qaEbhO5hVRjhXwK3epRxYyqC7+qHEa52+MjPBDZGcFPzuwuwZ5kqzEJwIFJoV0iKdKaYcG9ZPmpouN6rfdoUUme4d6wFhZRC9dQjIm90UrSkwszuFTQrwbG44IXl5Mmu8cykXHg6cV1dT2YBL9xV8Si7M/GDJvoWFDmMQBbb7t7ujdZbvKDP3I1j3o2jC5h/VbIH2f2gEgcyYwIPsb5bucifwb6fP2DMbQwXo2F8fX2lcw0JvqrbOKBpRob6XmuVb3BFefc0zipSYLkYTOig2Okc+GiRc1XSlZmRe24IvXpT+9Zz3C7qFhLjZJ8sec6uMnatVF7IZ7WAlaT5Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:55:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:40 -0400
Subject: [PATCH 04/12] arm64: dts: imx8qxp-mek: add state_100mhz and
 state_200mhz for usdhc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-4-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=2035;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Sl6xysDJw0nHVThbTASABsjnOojpINxjxOhE2W/YKG0=;
 b=hv+upD9i88QJgi2vSzOlqmZYS5NaP+V8wSxMtgl0Zbdh24jzxkc3z2LBdzPtJPOZsJudvNcMT
 S5xkCrx7O02AIAYevYjuj8OQ3NkIaR5j0vDkW28j7Mb0CsRtzHTF9Vx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f11178d-9c95-451b-780b-08de17250e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlg1bEdwRjVKSFVtZjhPdFEvcCtWTXluNXRqQlF2RStXVmY1aXdSbG9SME5y?=
 =?utf-8?B?c2lSZGJlYkx6ejVNNEhsS3pNbmtSb0RpNXhobWU2TmNXSVJ1QUtSNXhRV1N4?=
 =?utf-8?B?RzErWExVR2Z6WGdmKzl4QmVjWFNQOFc1UVd6bU1oTEtoVXJCSjBSTEZTcUk5?=
 =?utf-8?B?TW1ZNjR6TXJ0dk1rVW9OSURNV0tMWHRDQUFwOWJ5ck5GeEpabFpiYzdXUlNB?=
 =?utf-8?B?aTdjM0x0V3RDa0J6YjBhKzk4WGlscHFZU0Q5NytMU3lYUC9qQ1JXQjFBdU9F?=
 =?utf-8?B?RG5ycW5mUlhYZTNrK0cvYXUzWVlVR0xCckVPMk5pUG15ejlkeUQvSnpxc0FN?=
 =?utf-8?B?Q1k1bjZyV3VUK09veWFoZUxvK3ZXVm1aeTYvc0dnVTlBc0xMRlJrTWI0Qlo4?=
 =?utf-8?B?M1lmNHFrMVJ5dlVQb3hCbFZCZ21EOHQ0dU1EU0N0V3lCVUZLcTdtaHNBQm9T?=
 =?utf-8?B?SzdHdFZOVVdDVFN2bENtMFd6TzRMakY1b0d0S09XT2tMVlFoRTA1czNVUVlF?=
 =?utf-8?B?LzR4MkIwajI1T0tXbkVZbGxrbkhVRVM1L1BGZ3o1bG5McG95ZUlkanhDRk1T?=
 =?utf-8?B?a0pvMk9mdFZuazdGRkF5R3BJaXVYd3ZSQ0NhMDNCeXZhWjFicFc1bmd2Rlor?=
 =?utf-8?B?bTRtQXJzVHhYeDJObWkxUjRpblVrTmhyMjR3NFliTzdmaXdRTWZ5a1B4T2tz?=
 =?utf-8?B?SmswT3hKSW4wK0ZVRkFrTWQzRXYxMGUyVVRnV0RSVzNwa1M0dlNTSlc2cjRD?=
 =?utf-8?B?SVhneHhqVTZXUU1VT0xPRTZENWtmN1NwdkFweGdweTUwTWVHRDJsRUhFejRH?=
 =?utf-8?B?bm5xYkpLN3dKYUJIMXp0QW9NVTdId2pvZlZQeXJRdzhlQ2I2aTRlSW9XOXUx?=
 =?utf-8?B?WW5zS1E4WkIwM1E1WmpUUTR0Z2tmdXVBUzFKWHRVa3VSN0FDZTlnUy9jUEd2?=
 =?utf-8?B?NVlvNlVSdDI3TE9MMWZRMXB1eVZJbnl3MmNGVjhqSmVkaVJYSzIrbW1rNlhP?=
 =?utf-8?B?UDNIeU5hNDg1UDdvRVgvVkpGRyt1RjhVZVZndzNETjFoaG9JQ2NLOHZnY09N?=
 =?utf-8?B?OFVaYTNKaWM2YjRSa2svaDA2eFZqK0pSbVA1NnFNd3dvaWtQN3NnWXlpUjNT?=
 =?utf-8?B?ZDltK3ZEWFVVdElTcnp3bHpmT09TVUs2UUppUVd4d2tWR1ZuTkNiY1AzeEYx?=
 =?utf-8?B?YURuVlRZem9zUnpaNEx2ZWJZcTNETEZtVUpZcjQrQ3Z3d2t0V2xJUy9pdjlk?=
 =?utf-8?B?aHV6dzlZTnhYdjhkb1ZNUDZpditjQ3F3ZmZHRktrVXNhakg3UklYRVhyeFJs?=
 =?utf-8?B?V3RGdXcxcWFUZzdybTF1TVkvYzZiN1pmL3UvbkFnODUvTmJmb0gxQW1pQ1o1?=
 =?utf-8?B?eEpWUEtTZkwxNUUvMW94OXg0a1RkVy8reUkrNCtRcExkMGpRazJZcFdCZ0Jm?=
 =?utf-8?B?ckVha2F2dEJmdURtc0JHdGRsdGo1NjBwZklkV2F1R2MzbWRmWkZ4NVpGQnd0?=
 =?utf-8?B?c0tZMWxFRlpYSmZveXRZK2lXampzZnE1Sm1iM05OYmpFckI1anRLVGVyNnpi?=
 =?utf-8?B?bUlvSjl4bTRHTzM2enZLajY4czB5VWp2NkRVKytJaFg4NGZSbVFtY0tScllP?=
 =?utf-8?B?Y01lZzN4QmI3M1B3bkwzTXZnZjIza0ZxVlhhZjh3V2FpS2RnWTA3VmVLSE5T?=
 =?utf-8?B?aDltVWs2RUZuKzlLQWlxL2c4TWVBVjVFaDNteVlGM3g1bVBjemtZcHQxdWtx?=
 =?utf-8?B?WWc2UEhkRTVqc3Q5QkJ4UnNaMWlTa1lhaWVLOW51ejFYSDM3V1dEWHdOcWNo?=
 =?utf-8?B?U0M0KzZFdzhDZ2JVY3Y0Z3l4ek9xbUJUWWxNUTE3d1ZMSjZqUmFhV2tLZ1ZN?=
 =?utf-8?B?aXQrWkJHM1lHUDl5UmNxV0h3RjB3b080c1ovbW9PNEJZR1RrcEl3REhRaGk0?=
 =?utf-8?B?QWo4bm9oNDdkTGkxUnlUVWFCckMzNHB1UTE4bmhVaGhKWW9LZXN1Mno4NFY2?=
 =?utf-8?B?V1JIVGRHNnV4MzR4RmxQa0hWS0RaemxybjMxOHlaM0VRSTdsUnk5NFEvSHF4?=
 =?utf-8?Q?SHR5Ne?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlY1RllRR1NzQmFHS2hoTGI1cmtPSllhTW1VblVRLytaRkxvQWc5K3l3Z085?=
 =?utf-8?B?NzNBZVFjZXN6WU91SGd4MzVIOHVVTWd4YTFNZ3JGdnRpYkFOWHZrbVBwcjdP?=
 =?utf-8?B?eStFWHN3WFdqd3cvNXBKaVRtVWdSTW4xVWloTHlna0tvckRDckpMdkVLK04r?=
 =?utf-8?B?VjdySnI5anM4N3hoN0FkQ1p0alRWU2Exb0ZOVjZQaXUrSHlsbHQ0MndLcW9P?=
 =?utf-8?B?ZEhqczJydFZHY250UDBSNGo3V2w5eHpBTURSb1RYY0NxbTdYcG9ISnVSdHJX?=
 =?utf-8?B?OFAxYmw4YlYyb05RRUVOQ2Y1NTFDQTdIZGdOeEgzWTNpUHh5eU0wQjVqbmVi?=
 =?utf-8?B?NVZUcDlVY0tYZTMrMy9EOVJ3N240STBNK2gzK1RmdTJraWk1akllZDg3dHN2?=
 =?utf-8?B?MklBbXUxZnd4Vko2Qml5bWM2dlZQbXc5RUg2V1NuZWhyUmtadllQVm85RzYv?=
 =?utf-8?B?M2p6bmtxZVFoU2ZxZGhYOTZWUWtwRGEyWnlJelZHMmRVbVAzb1Q0ZklwRmVq?=
 =?utf-8?B?NHJwaXc5Z1l0NFlZZ05waGRDRmhjL0VSd05uR295dXljbFNWd1hrMGRyb2Jx?=
 =?utf-8?B?bXp6M2FrSGVNV1E3SytINndVcStoZ3VpaVZlbmYzcW9zZXVRbFRGak1YY05k?=
 =?utf-8?B?OW54cGtwaFhMMDBBZ240OEVEM2oxQ2Zia0dCQTFKbVJQODhTd2NjQ1BLMU1G?=
 =?utf-8?B?eG9DMmdCUy9IVStWYXBGeUcvaGppdVZaSDh4RGd1SFNoTllOREtQK2NiTnY2?=
 =?utf-8?B?citaTllzYVpBOXFCVkc5RE52MjViRjJXMWJqQ29RWGRHRzJhTWZKV3dsQXZK?=
 =?utf-8?B?MWEveGNMNkh3ZmhROFByRzlXQW9jak5RWXg4eGNjcTFVNWJsbmZ4cm1kZWdO?=
 =?utf-8?B?ODlBNGR5Nll2VFlITFNEY0tWb3c2ZTBucVl1ZitYSTczRkFjb1JCMW5zVjYz?=
 =?utf-8?B?WHRZemo4QUZEYm5SdGpOay8zb1p3MVBHNU56bHY3Y3BTaWxLaWF2cDJMN3FB?=
 =?utf-8?B?blNtbkdVMkoxM0VuU0ZxeUJzbnBFcE5uUkdJQ3Bpem1qdVphdFRPdUpqenRv?=
 =?utf-8?B?Z2ZPeFEyOXNnR0kyWmV4RnZ3c21JdDhJU21kOGhEWXRmSzFWTy96RHY3R0FV?=
 =?utf-8?B?ZnF5Zm14R1FSYkRDdmZGV2ZETkpmZUNHV0Q5MS9WNFdtVXM2M24zZ0llbmZO?=
 =?utf-8?B?TDVKVnVYanZxc09JeWZoRGRreTd2ZE5hcFIrL0ErV2JLRUZzU0F4dXd4enJy?=
 =?utf-8?B?TDJSY0xRWFZwZ3JrRnlQUnF5Z0ZiNmNidVl2UG1mdFBGdzdTZUhPbDdjcjFk?=
 =?utf-8?B?QVhWekVxTmY2R1FnRXdscTVoaUFBMUJpcStDM0RtZU5wZXV3UUVIRW5Jd2ZC?=
 =?utf-8?B?Zmx0WithRmdvVGttTWRKQks0b29zd0hlOVNtdmtMTmRYYllEQ3BJWHJJR2E4?=
 =?utf-8?B?Sno0elhQWTE1cWM4VElMK1ZuR1Y2ZjJSVEZpUVNOaEREc1BUc2FZTzd5OXUv?=
 =?utf-8?B?R1RLUG9FQ1EzU2lkbFdvNWFxM05ldm9vU0xrZ2MxeFo5b1NwNVNqMWhoSXVW?=
 =?utf-8?B?UnFRZ1NGaTg2YklpRUdmd2UxeEZwRHdRNDJOZ0dSTElUWEF3WWVuRFlrY3ZG?=
 =?utf-8?B?dGd2N3ZySHc1amFQSHYvR1N6Ky93RlpHYUpIcnAzWWxjbUd4Z2t3U3JSQXgw?=
 =?utf-8?B?Y0xYZTRQaHFvTmJOUytTajljTWxUbmFtc09nTHQ3OXc0aGlNM2tZQWR0ZWFr?=
 =?utf-8?B?RTFtQWF5MnpwQy9pVk42eWNaSW16bDZVMkZCS0I5TFl3RDJ4R01oNzZRRXlP?=
 =?utf-8?B?WG04L3FMbktjd1Qzb040OHdZeVZ6TEdRUjYvSWdaQWNZN1h4NERlVmV0bkdO?=
 =?utf-8?B?ZFBxQ2xXMEVjOGdjc3JNSGRmdFZKRGk3bmozdStXc0svQ3l1VDVqbmg5b0U0?=
 =?utf-8?B?ME5CbG5mZnd1ZDNpblZmVG92SktJNnhNZC82ekVWQUhpMkhhOUcwcnNrK0pB?=
 =?utf-8?B?eXZOc1JsQXZ6b1M1aUVsY0pDSEx3RGxSQlg1NzZPa3BsWVZMTDA3SUtzczdJ?=
 =?utf-8?B?MUQvbzJnRDVHNnowWTg4NVcxQ3dBclJNVi96M1Y3Q294YVFiazdROHV4K1g5?=
 =?utf-8?Q?jJIMjyBn/JuDEOPtDu0ff95jE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f11178d-9c95-451b-780b-08de17250e29
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:05.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUY4bkvtW0kEPWyHBYGfeyPsmJkBqEEJo8DtG8GKylyl5vbDaMB2Qm+vKdy+9PJQsHVpXDhxk7B7DFBaaATiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

default, state_100mhz and state_200mhz use the same settings. But current
driver use these to indicate if sd3.0 support.

Add SD gpio pin group (Reset, CD, WP) for usdhc2.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 7b033744554105de6dbc4366f21e3c90f1768deb..617370846de73940f2d6c7ec9f8a4d119cbc17c0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -730,8 +730,10 @@ map0 {
 &usdhc1 {
 	assigned-clocks = <&clk IMX_SC_R_SDHC_0 IMX_SC_PM_CLK_PER>;
 	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
 	bus-width = <8>;
 	no-sd;
 	no-sdio;
@@ -742,8 +744,10 @@ &usdhc1 {
 &usdhc2 {
 	assigned-clocks = <&clk IMX_SC_R_SDHC_1 IMX_SC_PM_CLK_PER>;
 	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	cd-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
@@ -977,6 +981,14 @@ IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE			0x00000041
 		>;
 	};
 
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19			0x00000021
+			IMX8QXP_USDHC1_WP_LSIO_GPIO4_IO21			0x00000021
+			IMX8QXP_USDHC1_CD_B_LSIO_GPIO4_IO22			0x00000021
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK			0x06000041

-- 
2.34.1


