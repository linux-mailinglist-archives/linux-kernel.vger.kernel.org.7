Return-Path: <linux-kernel+bounces-864696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60677BFB5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B1E3AB2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0A31B104;
	Wed, 22 Oct 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="umuE3dR1"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021094.outbound.protection.outlook.com [52.101.70.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4E3101B8;
	Wed, 22 Oct 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128318; cv=fail; b=Catafrhj514RjElLRVcTnxio5as62JqgvGhOCb5pmebQkJIKagPWV04rMrLlotP+aTKzWSDORK88a6SpLoqM46M8ijJ2RsbNGwHfW2SQ5LIGWkkOSISorIwvUBwp8MBGFCiKuC6wjgmjOAGYaNZyOPhwuRW4T9W7nPK5BCZHBGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128318; c=relaxed/simple;
	bh=uiatHTKm+hoJ8CSLjqcgZPx9wp3PHA7algfKHiK3BpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fi94fEC9nYL5/rziGLP5OezG8zF5v92a0nnjhXsGvl4DhGFilyhCWnPOK+ELY5SRXz4zJ/YcDkkP1NRSGvqFThFAx7NPq7wt4TzwZE895CvA2eNNT7mj1XXbLfTTVFkezi3U2qzlEhm0UneeqFswbbDEkJ7o1qxs/Y6wzQE0QVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=umuE3dR1; arc=fail smtp.client-ip=52.101.70.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO9YWAh7BEPLapUObN0IUs6r+67P3XS7mp3z3Cmtq94wgGUNaxhmAOsjA8bPHb1p9ZOSNCSQq+F4YcgX878TKjycN4z+EOAcLfzKSAuN8LHbUs/P08e4wCYyym/s/Uy4bHwp85f9e4ibQFI04XJTYxl1OBIZFNH5Rw0R2gWEPaezdpK1AApx2GySl6qhszNN6F0/LhUea/ll2kkP1e9O6vXr89saG+MnxjfnfvAxQSR/7oxoEJgXKf7Jipk0UZVEO3M1nCZt5y3b8tx/WHbS/UGyYUSvbZlv+e/Z6v2Qvg7Zyb563V/6V/pi5MajPmsuSiiE7PsYX9Xb1ExTlJ3nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi3qKScnQe+zHab0phvKS1ni7CI7e1UrTBKPk//qOf0=;
 b=DCdORkvKQo3+0xxxdPKzJfPSA7DEVX1Dt34WSoASM5Leq2Gtv4vcIT9kRGxPJW5gsCaa/7RoKAVA+sf3/GzWg6eyIe/6Qk4bRjEN+iMNInmaODzvYRDH2MtTNhNmiRKbNaWwoL84OwffA9F66vHoRe44aLhCWPI7QCzue0Jso5cLpRMDWIsjR95afFS7YyaXqK40mPbnmEvgyWw+PLyOLpDHqAUy1Ii95cmegBKaJxvU7Gfh/fL2SkYuuqracfpQVkwLL0i41jIlm2BgIcjmdQ269UtOAV8YeH7prIMbLENNaFCj+I3R05jbBm+kil74pkWsHSFL9Dx/ogPPaMg2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi3qKScnQe+zHab0phvKS1ni7CI7e1UrTBKPk//qOf0=;
 b=umuE3dR1BE7mTYEIIZQLi2T1M6/SN+5eF0HeRWwUGDyf7ObUoqy/dPwTTQgyb8Fp+Mwr3GloUt1+lQ9dTrgylK0hH0eokn3P8orUFw+46KD4IjV2iLJ3ciBSvcK5BxbXvRHIb5GtaVQe2qSRIIuEWxr/GMANuhv/Ck9J4eGkUCl87/qkhBVcan6dx58QSR/YlqcNP+WOdDLqXpZYteWX50WJU14IVTdjRIF4mTXyr+D0nsAGFUrYBEd36kmwtGOGoWEyAiqHisqTecd3lsqcfl0+I/8lULtkhZ2aWFNFZHAjm2qlRcIcwJXh1cC+53MlVbSnfylAP/+WVfj9pdoapA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by AS5PR04MB11322.eurprd04.prod.outlook.com (2603:10a6:20b:6c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 10:18:32 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 10:18:32 +0000
Message-ID: <886ac8bf-528e-42a7-b462-f453f74ed32b@gocontroll.com>
Date: Wed, 22 Oct 2025 12:18:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: freescale: Add the GOcontroll Moduline
 IV
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-4-20af8f9aac14@gocontroll.com>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <20251022-mini_iv-v2-4-20af8f9aac14@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|AS5PR04MB11322:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc93241-0f03-4a13-578a-08de11545a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2FGWXl4MzRlUFdqNzlLSmkzNVdielg3aVJUVTdWTUtxYzZBS1BRUERIRnR4?=
 =?utf-8?B?V0tZVS9KTm5BQWdvZk56UUpkcnA2ai9FY1dvS1A3MEN6OGtSdDdkVnRmZlBr?=
 =?utf-8?B?ME9ucmZVVDZ2dXYrNWR2dkRVRTNBQTVnRHFsamt5c1YzazRtRU5jMEh0VE1D?=
 =?utf-8?B?YTVqdVlXR2p3Y2sxWGxvMmp6Y2pDTU1iVlRUU3NKdTAyUmZuSGp4bnVOLzU4?=
 =?utf-8?B?QVJtdnhEcUQvaTBRcUFXcm56aTNqR2h4ek81ZXlpZVcxRkdEdzJmVnN4azFt?=
 =?utf-8?B?TWpmdnp5YVNyQS84bnVGQlZVQVlMNHBGOXJUdUdNVmg2bFhqcmFMY2RYVkh5?=
 =?utf-8?B?QW9PTHlIUm1lOUFuYkV5SjZKd0dqOXBBdUhaMGNXR2g3SzdrOUhSREMyeVFF?=
 =?utf-8?B?WGVjc3FvUDB0VVBoTmNiYzExMHlobERHOCs1WkVDNUswckFHZG9Jd2VrclpE?=
 =?utf-8?B?OXNLdkg4eGxjd3ZjdnVwQ0JPYVdvS1pyZ3c5Uzk4YkdEZGF2Rkp6YzgvcEx1?=
 =?utf-8?B?SUtaU05YTDlCdS9OeGIwRHFJQXFxY0gxN2FoR3RkUm5iNzRQU3E0cHlWOUVQ?=
 =?utf-8?B?ME1RcnZteThDTnhmVkVIV0tUVmFTM2s4VzJBeE9vQzYvRm9NWUU4c05sQ0xK?=
 =?utf-8?B?cm5rKy9CdnY4V0dNTFFXS3d0bEg5YjkwSUFicVJhSDFQSWU2eFgyZ3hFTEdu?=
 =?utf-8?B?Q1FteDhqSis3MWduc3hCQ3IzcVZCTUNnZGtEdlUzejM2Nk9WQVhPdHVCc3E1?=
 =?utf-8?B?dEsrcEVKSXVjck5NSkNZTGFjbHhSYmpTWUpkMzc4YUdTa1F2eGJRRVQ3RGhr?=
 =?utf-8?B?b0Y0Z0hzalJaL2JPNHF0WWFOWHBKeVQrWkNRa0h2Z2ptSExwdmpsNjBrc2I2?=
 =?utf-8?B?TVJmZXN1bmtxUG1BZXc4UXNmRUtBVDRLTTNmZWFsQ3JQRlFkejZrM0hCMWdq?=
 =?utf-8?B?NlBnNGdMN2lKNGJZVDlpbG5tWFRqR0tHekNuM0JlVjZ3bFFJTkZkK0pYWDRQ?=
 =?utf-8?B?WWpMSkV1Y0lCV0d0KzU5ek5kWHZZNDdrMkhtTVZNWWE2VlJxV3NhbUpsYjI5?=
 =?utf-8?B?eXZWRHV3My9Bb2VPcWhqM3J4cytxMHUxNVVsRm5RRlRCUDlmaTVHbE5wQjZa?=
 =?utf-8?B?czl1YzJiU2ZYWU9lRld4aWxoaUlyUFVrbW9tQkFsNHRLL2ZxMDJ2QkpXclY0?=
 =?utf-8?B?ZlNwd2RIZHFTblNXckRibXNON3g1RWVySjhmWXdTb0ltUU03UXlnYkZHWk1l?=
 =?utf-8?B?dHZUbHFQN3RXZElCci85R3VTa0dTNDZ0RUowQ2hzT3FuR0hzNmNCTENpUitE?=
 =?utf-8?B?ZjRKNkZtZ0plSzRpN2U5ZEhpSzFQNTNrVTJIY0p3L3ZCbGVSbS9PZmRaUnJi?=
 =?utf-8?B?RlJRRUJaZ1ZZaGwzbVpmNFd6ejRYK2txYW8vMkp0djNka1M3bG1JYWI5UU1M?=
 =?utf-8?B?T3N1M1I5cGx5TzRYV2J2YW9rNFpCL0t4M3ErS0pxSlAxVjZsdVpJbVZhZ1dJ?=
 =?utf-8?B?V2Yxc0xMNlpQckdHeWl1Q0lTMWRhbmw4MC9Udjc1NlBsKy9nMitCWnF0Vmti?=
 =?utf-8?B?a0dnWSsxazZXNXAvVzRTblNMRXk3QTNKb0Z1bWNSZTlQcEMyRXF6NUJ4TEZq?=
 =?utf-8?B?MkNxQjY3ZGROQ2hwS2ZDRVBQcDF5NlNoRlZra1NpSVhWUnZGTWtqbnJyZzBv?=
 =?utf-8?B?cWNEMzUvdGUxaUJpalFyQldIaVRHWmV4cDIzNjdsUUx2OUtwTnd1dUsxeHgv?=
 =?utf-8?B?bjJBNWpDendTM2lNczdXNTRHTkJjYVp3ZTRmYU5nT0tub3ZKemx5Y0twTWh2?=
 =?utf-8?B?SERndmhHVXoranlFdEhVQmNVRmpPRExUOG1adVFCeHA4RW9GbzRDUVA0a2pN?=
 =?utf-8?B?K2VnLzJiNU5xUHNldmdZUlpxbUR5Z2xiL09DdGR2elFVajNQaEp2L2N3eS9C?=
 =?utf-8?Q?elIGfJzBNPEhdO+SuVFhfpSr2YK/fWQj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG5pazlFbkZyTVhEOXYyd2tyV20vc0ZhamN1MEpLNHNCUUFWUkp0NkdrVW9Z?=
 =?utf-8?B?ekpSSEhJSFJYQkJOb0lhZ08xRVNhMDA2TkY0V3ZMZkRUeXpjMmkxRWVWeU5x?=
 =?utf-8?B?WmFlMktWK1E2TmROZERKOUZSZEhvV1BvU05oR1N6QXc1VEFaVjMrRGxnRHZF?=
 =?utf-8?B?QkVtcVc5U3FLbWxwaTU3Y2dIcnZYc0NJUmcrRzNUSWNKY0dvanFBNUw3OEwx?=
 =?utf-8?B?bFNVdTNqdXVzTStVQ1FlMnIwS1hBYTJCU1hzTDRZQlRRcUV4Z0p6NEw2bkZJ?=
 =?utf-8?B?RjV4dEtXbStVTk5nRFBzb2NwdTdqQjFxRXRURGIyOFpLa2h3MnNjWnNjeTdI?=
 =?utf-8?B?QWJUOWxQQ09rM1RFT0tNVk5QalNybTZERHZzZFFXSUQ4UDhjNGZ6YlNGODJU?=
 =?utf-8?B?RWhvRlNIZEQzOHB0ZHZ0WFJNdk50TEE3WUtiRDVvdHJ0ZTRLeGpqNVF1bmNE?=
 =?utf-8?B?T2ppcjVtWXJiUVFTYWFDa0JNaHFxS0NpbGZVWkZHUWg0bENLN1FOOEc4UlRk?=
 =?utf-8?B?bjN3K1RTVldRZG5UZlFUWWI5QkxjSVdVWVJicytQOWNpa2t4cUk1MGRoZWFi?=
 =?utf-8?B?ZHh5K290UThBUjAyWGFIUkhqeXRhN0JjYitJYzJZK0JHWXQvb09kcXVTcXZu?=
 =?utf-8?B?YWM4ZUlicDNkbFExOGp2dkY2WUVKSHBpQVZEUUhuKzlQQlhIUTI1alppaFZs?=
 =?utf-8?B?YXBpR05KMU84a01NeENTQXhoYlo0RWdJRVM0eWVReWRIbm9heVE1OEVoWXhl?=
 =?utf-8?B?UkxRQ3I2RmlQbngrYVBlTVNUaWE0RXd2REsxS2tUc1kxVFcyNUtjamtuQUhD?=
 =?utf-8?B?YmIveC9pVkFjUVVCV0FtVUhwcWpmVEVrQ1B2RFhicmQwazBXS0x3NjFoRjNL?=
 =?utf-8?B?WTVTWVBrZ3ZiSzZtOFJUUzFWL2FTRkd6eWx3bllSK21BVk1WUnZnWVljZGcy?=
 =?utf-8?B?TjUrRXdCRVpBakFZc1JBTVNwYjhIN3pQUGQ4OWUySFFMdlB2QmVMNWRMRTdT?=
 =?utf-8?B?QUZVZm0vM2RQcjlFekVBcWJYOC84dGZWalFKOXVpYXpFTDVsRFlFYzlQUTFP?=
 =?utf-8?B?SWRjeExPUGxEckFqTGVwMUUrRjdHamFiMmliSjd5bUUzbXhOWUt4cW8yRzZs?=
 =?utf-8?B?ZUZ5cGczaGUyUWNySGVjZDRrWSt0azg0WUlzRjBMamQ1RXJXMTV4VkdyOWRn?=
 =?utf-8?B?VjYrMkxxMVd3Ujl2ZFpSUVhySG9oNXJoWkFmMHpMVm1sVUtsWStTcTJmR1lv?=
 =?utf-8?B?RTczRVpSQUxXUm84cFVOS3BaRDBIci8vMkhpdVN4SXVsMXU2bzU1L2J2c0FU?=
 =?utf-8?B?ZVI1eFd4YlB3d0hPa1JJemFBbnJWeGkzSU1FWlFOajh6T2QvU3Z5RnlyY3lG?=
 =?utf-8?B?OEZjTDYrNWp0Q0lwbHJJZUxOY2tBTStyQ2ZxZUVMcFZMR2JEWDhlOUJoUkV0?=
 =?utf-8?B?Uy9iVUlOcDN6SXQ4Y3ZSVnc1ZHZlQ2ZtU3NSUGl0VzJpZERrRzBjV05iaTR6?=
 =?utf-8?B?K2NaRS9xUHhSWEhHVWZQUGhvd1VVWkYwU053amFVTDI3ekRidFZUNXV1TDlX?=
 =?utf-8?B?T2ptUFpLRXoxU2ZkcExUb3FkYmVKb3V3WEF0VC9VazNncy9sNlZwRnpXUURI?=
 =?utf-8?B?RHFWMTM1QTk1MTBQRDRndmtsa3ZpSmhIQmZhWVJZa1k5Tk5tZ0NPc1RoUit6?=
 =?utf-8?B?c1JCZW55cnJFMU8zY0F5eTZzeFdhd2RkNzYzVG9RM1Bpa0dBL1VpcWxHTHpL?=
 =?utf-8?B?dkprSHR2M0VORTBCcnZEV3VjWHNKbzJhWTRMS1VVd3lPSng0Nkdibi9GRjZV?=
 =?utf-8?B?K3dEZmFrckJ5elU3YjJVWUtwTkVkeTFwTWg0ZWlFenJRWEpsUW05MEw0eGVs?=
 =?utf-8?B?c3hIVlViQ0ptaTlObmwzSm1kd050L0k2OXFLU244OEF3NXExbVhDQW5JUUpq?=
 =?utf-8?B?c1JVdUJSdHp2MXhMY3dQZTJCOU8xdmlIKzFyVWhPMEpzQnR3bVNVcHFnR01i?=
 =?utf-8?B?Y2JMdTg2cFVLMFRLM2RQSVlDTGxuZXE2Nkw3U0FNb0hQNk1SRURXVG4xMGU1?=
 =?utf-8?B?aTM1dllkTnBWYlh0clJJQWpmY2NTV0RtTE5SYk1mVDNzVmxseVlyZFNtMWpz?=
 =?utf-8?B?VnJxUHBSNkJrVFJibTM0YTExbUJsRThOb3JEYVZUdTZ0dTNzKzBzUzFDK1VQ?=
 =?utf-8?B?aHJKa3djVWUveWRhMlpNSFVNaVNwdGxsN21oekFmYjVqRjUvSm9NdkE5cWh4?=
 =?utf-8?B?TDdiR2xCd3czMmhLdTI4NGh1SDV3PT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc93241-0f03-4a13-578a-08de11545a58
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 10:18:32.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PG7lpDf7RxTjIQO33Z1h1OykDxTPzxAYO9J5ORKceMWy1ksE2Xr+5FRIzBpyYHW3hR05OuzpwWH99RS+emznM3n2l6z6yZoJib8jr7l688E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11322


> +/* SPI 2 */
> +&ecspi1 {
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	pinctrl-names = "default";

This is bad, missed this. Will be fixed in the next version, same for 
the mini devicetree and all spi interfaces.

> +	cs-gpios = <
> +		&gpio1 9 GPIO_ACTIVE_LOW
> +		&gpio1 0 GPIO_ACTIVE_LOW
> +		&gpio5 2 GPIO_ACTIVE_LOW
> +		&gpio4 27 GPIO_ACTIVE_LOW
> +		&gpio3 1 GPIO_ACTIVE_LOW
> +	>;
> +	status = "okay";

Kind regards,
Maud

