Return-Path: <linux-kernel+bounces-791259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39239B3B40F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5F3174AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8B81DC075;
	Fri, 29 Aug 2025 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="W/eI88in"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021125.outbound.protection.outlook.com [52.101.65.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2C28E7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451742; cv=fail; b=lO8MmX7JPi6Pw8RaG8WbjQpDUBGwrzcD9nS4gTm2vx4R9JdYrJVVKtAKcsFhVQk+PCv7t2WFscmmrTSSkV0xKZNkjDfyJzalIgkix2VRXMCQS5RUsLJ2ljeYFMyqLMMpZULM3/L9G2uOCIkIlu5Fa0FCGSAoG+ewjGqywFJIT+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451742; c=relaxed/simple;
	bh=U9V+bASeBGc8dlPcJ00fLqFBUBnljkGPhn1ppzEXNXI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qJpQg2ZS4Kl9jSjUroEo2R38y1eJKu0JsFgQfHCUoFoMsc5zL5yp0hdyt59Me3pnUtUiuNsEtV9qUnv83t6z9uJaBBYg+oNqrmT/cVEDBLw7bHOcMJVSO0AtDgXtRhRJ3MPAJgpxjCtaauSUFxQTEONfIx6Gr0f1JER4XwF5Eo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=W/eI88in; arc=fail smtp.client-ip=52.101.65.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgOL6o0I/43eKRGLGoQcdhVhBkFSBYcmH6g32JNDFSKhR2r7iIBPpz0gSz8ZxOtj5SNayH5WSUWf5gl4IeoZEqaUMmIieFnx165Tk8en1xODWcyPSpIBeWTbxNucqcz4lgN0cp46Re4Jnd22nX2h3Tw2m2SHTRkor3ceDgacuah7Ethx99pGYClnUSU06Y8JFfzPze4l55NkYOnC90mYZhRkvFjxBtcW8uZkelP4iMpw2od1Xxtt5yyN9DAB8EOFVLxv/N/3mDQ34UCOrp3+ncpCRl2HrrLNFoFecGJ2EKoDUEYir+hpd5+ohl9H+A5TTXh4Upuly6GaQ5sweVY3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJbcD/l70DFDv3xunOkLgY+jSeqQiUGhyTchVqHob0A=;
 b=pTmA7PWDesljaczjdE2M8DJkfBt0ZpXEeuMxMHjjzXjXfL8pOdRyS6J9jIvwuBUz70DjyYydUhQQT/P64vCzqAxOirrGqo0h3lbChE1aTuBwB/SiQ5slDDEdETYXPkqbdxKvAxRSG0KT3WfzvrXtdG0McVSnw/vyCjii8QLg47ZbKQA33fceolakH4994udywJr8CRRgYZzPGko70SfZ0lUCEFVZ0m64FDte8UWqs/yZ8ADIbDYRpfjKg/VYiutQa/H4Kn0LYlQTS0K0HgFgCU/DL4PwmoJ4AKuhZiVIlJN1qgje7NNLnaCJRqUWW2+GqfVL7m2y3t7XOAfMOOR6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJbcD/l70DFDv3xunOkLgY+jSeqQiUGhyTchVqHob0A=;
 b=W/eI88in6nWmyVmqtZdWRld1ylZrt6AJCdDJz+V2A++zu9bnbpUTb3QFVezSoHSdkWPNicB3E0eqktTZkiWovLvecWxeQvdd/fZ5JC/EGMXdShqRxi/rqYQFe//xVhgAmgGupZZIw/M2pvvXL+TtD9micvFzn3yq0Tym4LsQ3hIE5D2++/08SS+AKAwsz2pRwAQxj5L2+H73R5drmnE3QTxywQ+47XAhI0+gR6krAcBEaLXl1W7q39Mva0Kw3LzrekG+0GETwoDxrsfsFD9Rh51Ihf5kQB/QX6n2jAc0+e1PT1O8QZS6oU4RA1eViTHmMwXSG7z8LobKfWuuwSsmqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PR3PR08MB5820.eurprd08.prod.outlook.com (2603:10a6:102:90::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 07:15:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:15:37 +0000
Message-ID: <7a8ef758-3117-4b1c-8362-39e2efffd5ef@iopsys.eu>
Date: Fri, 29 Aug 2025 10:15:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] mtd: spinand: fix continuous reading mode support
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
 <20250824181850.3994184-1-mikhail.kshevetskiy@iopsys.eu>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250824181850.3994184-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00004535.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::360) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PR3PR08MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: fb396f67-c511-4e4f-0399-08dde6cbda1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXpjUGZSZFFxdWNjdmwwY3RKem00K0JHSTNkN3ltWVY1d1FoKzk3R1hCVTkx?=
 =?utf-8?B?aUhERkh3MXBIUms4aStINWk4UmV6Nk4zYTFNVmhhOFZ3Zy94SFo0OEsrL0g4?=
 =?utf-8?B?Ty9sZ2hKdHZxMUdYNnhyQ213d1k0V3kyVGp3SStFM0UzMVdKQjE5M1Q3UEtL?=
 =?utf-8?B?eStESVRvMHd1VSs4SndzUFZRakcrZ3VuV09GK2NrSEgraFJFNmFXQjJTS3I5?=
 =?utf-8?B?WDR5WG1GQ3VTRk9VMDhKbTdRdUZMZlhqdFhuREJLbmJaakNYQWsvMTE2RzM0?=
 =?utf-8?B?anVZUkxLTWxCZG5ScU5qV2NuQkpvZkFnYytYQ2g3RzRIVWZmNlgzOXhBQWNl?=
 =?utf-8?B?ZGJrc1F3enNJanQwOEgraTFlZjE0K3JuQmxIMFpSVjVzSlIvdDRWZTJMaWwv?=
 =?utf-8?B?S015VEF2VnQzeVNxbzJ6Qks1T2VRWFkyeVRyellOVDNNTEIyalpwM3BZSHJF?=
 =?utf-8?B?bDRGYWtIVm04em9sVDU5a3NpSkVXVktaNGwwcXo0Sjh5OStTSmVGVzZ6VHZM?=
 =?utf-8?B?Y1RwSVNJWHdMVnNjaytHSXRBWXFiakRQUU5FeGQ4TTM5S0Y3bUlocmQ0d3VC?=
 =?utf-8?B?NjlYU01kRkFrMGxYbHBTcTF6ck5BNlZPN1F3UjFReFd3aFVFMVZzRG1GVkty?=
 =?utf-8?B?TE5pL3FQQytubUM2S0xndVoyTm5lL2pEQ1FyOFpWa0xWV2RVWGJuKzB6RUNo?=
 =?utf-8?B?QUVGR3RwMEpITHJ5NTVFMVI1czhyZHl0UnpBSGltS3JEbkE4Zjd6eTIzUk9O?=
 =?utf-8?B?WWhoT2JCRHVES0lBRVhtRW9vcnoxV0drTXRjbUFsQy9DTzRUcHhJdlRXbDVw?=
 =?utf-8?B?d2FhU08xdGNqZ2tlMlp5ZkJ6dFg0a3lFY3JNVEwrQ3RmaHcvVXhnL0czZm9v?=
 =?utf-8?B?dndZNVJwdVc4aTVRbzNhcjllWWxJYlB1YUJIUlcwY1c1eitPRkRSclpYdHY3?=
 =?utf-8?B?ZkFyTGwyaXJwTzRUTVlkdndXNEc1Wm1VTHQwVjlDMEhGOCtEcUtyQkpXT0Zh?=
 =?utf-8?B?MEZ0VjVER0szd1JEYkJBVjdUTHFjd0FYRm5yZTVCM29WVUpjaTdxNUFVOHNN?=
 =?utf-8?B?SDFzVVRRcEMxVCtyZVo4Wm5CS0hIc1phM3k5bVpTZHpVa0Z4aU92b3Nhelps?=
 =?utf-8?B?c24zeE02OHdrUDVDRXBja080cHQ3dEwwZHBsTk1UZ2JXZE9iTzVQbzQ3Kzh6?=
 =?utf-8?B?Kyt5akVMaGowaXZ2VGlTYVB3Vko5bXdEMStzWUxMMnd1ZFkwME1nTmVTQ2dB?=
 =?utf-8?B?NTB3cTZWcnV4ZDdDRUJRRU9BZFdMVHVYcmxySldzK1gxbzIwV2dyU3lVZXRK?=
 =?utf-8?B?YmVGTzM2bnB2bDRxWlF1S0k0elVDRDJtK0I1NnowOXpLQnJaVFlLdDJUUlF2?=
 =?utf-8?B?Vld0L0ZKcDFsTlhaOW1TWFM2UnB5SkpsUW90YnUwUDIrQlBnb0JOaklvRUM2?=
 =?utf-8?B?dXBFZW5LZy9wT1kremJkQUdwUzVSMTZkOTZ3N0lPN3d2REsxQ3RyS0V3cWp3?=
 =?utf-8?B?R1dEQVBiOEx6UkVtbzBkY0FXOCt6ZUxBWkhNeGVIbk5CWTZpTnVYRXFxV1h1?=
 =?utf-8?B?WldVa0NqcjlEeStQMW9Vbm9QZzBSVDQxTVZkTmtTWXVmZG5aUDFBVjhNWEVl?=
 =?utf-8?B?SDFoQUVHUTZFN2pQWUpxR0xkVVQ0cmlPT05vTGs3M2h0aVlQM2FPT3pTcXd6?=
 =?utf-8?B?bE9MZ3EwZU04ODk2bFBkbUpmTTZWMnFlNGVGWkRIWGJIUGRFdHdiQW1ia0Ey?=
 =?utf-8?B?SzlCOGM3YmdEN0JJaHhvZ01TUEVoU2dHaHdwbUFhQmcyUHRQMzR0MHhTSEll?=
 =?utf-8?B?QWVBNVVWRFR1c3p5cUc0cXkzSEhiK3ExUDVEOEFTd1VOZUtSNFVtdTNJQy9p?=
 =?utf-8?B?NXhxQjR1K1ZwL08xMHZTcG1uZG9DWU9UMCtZMDdac2hTK3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTJlUFVBckU5aHpWRjlQTllGZDc1Rml1L01md0x0c3VCM3lnSUpkK2FxUkls?=
 =?utf-8?B?cEZSNGhDRWNmY2NnUCtzNkx3M1NQdWRHcGprL3EvMU9FS3R1MXFGMEVBZ0lH?=
 =?utf-8?B?L1N1N3gvcHNWdTlyTjFPQWpuc2FmSzNwbEhjMENrZmIxbnRkUFFnUnAzdkRX?=
 =?utf-8?B?eHUxTjduVDVVRjU4TWV3SWo5S0UxQTlwSEF5SGZlVFFWQVE5U0p1QWF3T3B0?=
 =?utf-8?B?WEVlUkVjUk50QU1TQW1CNEx2SzJpdzZBeU15SU1KTzBtTUViVUo5TzczOWNk?=
 =?utf-8?B?WlFrdU5iMXVucXJvQjFaRWdPdEVrTlRLdHNndi9Td1ZTYVMvNjBJZ2xoUTJh?=
 =?utf-8?B?alVuakJHSTNSZHN0a3BiWVA3N1Njdlg4QXhVRUJPMEFvbHdjUzEzTWgrSHps?=
 =?utf-8?B?dVpWMVkzcXhiMjRldjI5a3duN3RtM1VsVDBDbnZZVm1TS1ROOW9qZFRNaUMw?=
 =?utf-8?B?UFZoSUMyRGVUZ0FsVmRtT3lIaEtwa2tFeEJrV1lJUnpGN0EycWlKV2Z5SjR0?=
 =?utf-8?B?RmxpSjJXSTk4aUQ5WitmcGp0TlVWbGFxT0s3WW1KeU9MSjc1Qk9uSFdPa1E1?=
 =?utf-8?B?NWR5aTFBWFo2VDdEMC9sMWZJOGRiRTZRS2NEa1owZko2bHBDbE9VMWhXNGhX?=
 =?utf-8?B?V1F1bWZPQjZ4RUZhM3JyZGl0U2pMaSt0Qy9kbzhabzZ4T1ptYytvRUVLN0dB?=
 =?utf-8?B?UzRLQ1J0OVBrNlRXalFYL3ZrTEgwRXljVTI0ZTFOQkdpOHdvTUhiU01URlZ5?=
 =?utf-8?B?a0NkY0lBREFxenZ0R210VGV4aVo2MCt6dVBEQ2x5NklJc3Fpd0xhelFobU0r?=
 =?utf-8?B?ODNsRzlmNG1oWFhlejIzMzhTckU5dGZQTHBkdVZQbnhpTmVHK01YeW5hT09O?=
 =?utf-8?B?NXh6WVlja3RsQ2I2bVFPaWUvbE95SFdMQkR6TDM5NVJiRlY0Q25wL05wYTBY?=
 =?utf-8?B?c25ialhrN2ZJVmpWNWpUM3QwLytTL3JuQWxjTHUyeHo3WVFObmt1S05Kdkp3?=
 =?utf-8?B?WG5yY3luSktNWTVnZllGMm5paGdYZDZyeTgxcWVOaGZOWkZwbitVV21iMFQz?=
 =?utf-8?B?ait0dDc0RUR5YVp4amwwUlZJYjQ1N2l6b3djem9XMEZYV0grWnBOU3JjWXNq?=
 =?utf-8?B?bU1Hd3RKZTlJK29WeHR5U1lRcWtkNks2Y29UZW02dVp6WThNYzRVV2g5VTc0?=
 =?utf-8?B?Um5LRzJjQ3BIL0c0RUliWk1LV1BnSUpSNE9vWmtJUFYwOHVmc1luSm52VllB?=
 =?utf-8?B?YnNhOWgydnFSQTZ4N2pRS201ajMrMmRuakI3d25nSnlXZUc3ZDdvQTljSlhO?=
 =?utf-8?B?N3IvclQwVnIxOW1BNUg0d1pCTXEvSnlFUFB6TVJqTVNnYXJueW10SzF1dWNv?=
 =?utf-8?B?L0h1TCtDN05kbEdhaFlocnNneGRhcGtkSkJjVUJCQ1dnSXpHMk1GeW1yWU8v?=
 =?utf-8?B?QWRSeEFZSzEwODY3bjFTM2FjOVNrNkRZbkZzNHNSUFZmb0hLdlFFUmVMYlMv?=
 =?utf-8?B?N1lqckplbElUcnJyNkMvT0hYbHh4Y09TbFYrN2cxVXU4NDFvbEhFSWZvR2Yr?=
 =?utf-8?B?WWQ0cGtNS09hRTNkZE03QnVlQVNYRXNtL3ZNMnZYTHhkQUJpb2FWWlRpcDBR?=
 =?utf-8?B?ODNnUkNhTzVrbEt1bHhjbW5POUd1d01aTHhWdDFhNkJ4ZDRsbmFFUjZvWjBU?=
 =?utf-8?B?MzVTWG5FRFVrTWxpQXp5T21MTnpGeVBmUnZxajFUamlQRkdNNlJxMTFVZjdl?=
 =?utf-8?B?SFNLMDFwZkdwU0RDN21FOWhVWWg4U0NhOGxGbjRqOTJXcGNCakJtMUtGenBT?=
 =?utf-8?B?bkNjWnhycmFWV2JIbjV4QjBxWUdBanlndHo0bGpvSTNiQ2hERHUrWnFicWpQ?=
 =?utf-8?B?SHNaTXdXemd0dTZtZ2lwZXlaVTh3MDZtMTZ5TmpnUEZaY2h1REtqaEFpMXNu?=
 =?utf-8?B?YldzN25UaURKUVY5akh5MEVzT25STEltY0E3SnhjZTdLb2pmeTZvMXBpN3A1?=
 =?utf-8?B?L3dJSmZoZDhBbkM2YWF5MFIvUUNsY1FhREJjMk4ySlM2WHdkUEFoSy9xZXNJ?=
 =?utf-8?B?aTFkd3V1YitqT3dTa1ZCTWRsUGtJTTV3Z00wU2o2N1FyWmhkeGpPVUlCdGF6?=
 =?utf-8?B?SWJ2Slh4cys1aGxTVnBCNGJkRHlheklESnpDbHprUHYrTEd3K2FlVm9BcFpJ?=
 =?utf-8?Q?sh+SS/MagjtV3+tKkF/FvPg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb396f67-c511-4e4f-0399-08dde6cbda1d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:15:37.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3yzpN8iSRWnvCuwlL8uNZ+DwGYZ3to47LrMY71K9dnGBkxg1YeKtsIVXeHCpiJb3n1/l1VSiuY5Cbp0+N1xZLbmAD/3PXHlPpwAhDg47b4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5820

Miquel,
is there any comments?

Best regards,

Mikhail Kshevetskiy

On 24.08.2025 21:18, Mikhail Kshevetskiy wrote:
> Continuous reading mode is broken for some spi controllers. There are two
> possible bug scenarios:
>
> 1) "continuous mode" flash and spi controller without dirmap support,
>    but with restriction on transfer length in adjust_op_size()
>
> 2) "continuous mode" flash and spi controller with dirmap support for a
>    single flash page
>
> In the first case, any read that exceeds the limit specified in adjust_op_size()
> will result in an EIO error. The limit may even be less than a size of a single
> flash page. In this case, any read will result in an error.
>
> In the second case, any read larger than flash page size will result in an EIO
> error or spinand driver spoofing (because the spi controller driver returns
> more bytes than were actually read).
>
> This patch series tries to fix continuous reading (spinand driver side).
> Unfortunately these fixes can't resolve "spinand driver spoofing" case.
> Spi controller drivers might need fixes as well.
>
> Changes v2:
>  * added helper to create reading dirmap descriptor
>  * fix spelling
>  * error code is not used for regular reading fallback anymore
>  * it's possible (but very unlucky) that someone will do raw reading
>    of the flash in continuous mode (i.e. without OOB), so fix dirmap
>    creation for that case as well.
>
> Changes v3:
>  * improve description
>  * move airoha spi controller driver fix to a separate airoha spi fix series
>
> Changes v4:
>  * the period '.' at the end of the commit title was removed
>
> Changes v5:
>  * rename spinand_create_rdesc_helper() to spinand_create_rdesc()
>  * get rid of controller_is_buggy boolean
>
> Mikhail Kshevetskiy (3):
>   mtd: spinand: fix direct mapping creation sizes
>   mtd: spinand: try a regular dirmap if creating a dirmap for continuous
>     reading fails
>   mtd: spinand: repeat reading in regular mode if continuous reading
>     fails
>
>  drivers/mtd/nand/spi/core.c | 74 +++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 15 deletions(-)
>

