Return-Path: <linux-kernel+bounces-772691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F80B2961D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4101965C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB8233704;
	Mon, 18 Aug 2025 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JIjZqJVu"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E64923D2AB;
	Mon, 18 Aug 2025 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480382; cv=fail; b=r0CQimdQBtMO1oAC1mXr4VbYAtKGvZsUHeQOTxCJR++DCVtwInNyhJc7uQJhKeYzQVz3kaClt9jKnASEm+QSZ+FYEidtze2+g+i8WAECr8Pu03bWa3152Ky1CEYQsbE38UaTC6Fb9RVSZhxMjsHCSC2vXUpsmF2dRIRslWNd7Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480382; c=relaxed/simple;
	bh=Q2VvgCJ4t8qclzBk9dDXs+WPZ6mVNhiBgdvrapImokg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lNP3rxesUBVzf3ypUw+rq6A/hLg2oC4qIJM60DYMDd055M1Svbr+Y3girBlAwNE8LdBGxO7hlmX36fkL8E9btCaPasDRp9JCfaoCrpW7ah1zNSktvAPq0Rn4hQWKHlnjSq9xxbCnVRkQqpIqkUMAMTMoCJGPre53CZcjiokVPZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JIjZqJVu; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAIaOR9UKh7KhK7PVV4otec5O4xEl+kdyKpkjJiYUOQ7kUjfJq0VMR5IiDFeMXKQB3uPGTmd9tgtwY6t51m7PNv4Gn7uFK+AZMhMi4zzKAqCxzUGWps3wSVC46KGPmQVp8iMjOfYtJTGJ++ERw60Eue3fAjuYwWjlcQlYltSDuWZNDTHH1nG7b9iN9gLxP3A9gpFxZUf55ZrT0UBQJbHAYo1JTGEsRZ4c4G0/SrTQloCaCA+oiFIkxbYhTR61+gUjs+nhoBM8l2EOcep3saekOknTyrr91aiPw3uriNcqaR+hTTRrb9tMPYiS/ydI5G8sIJASN9q6iGNf1mXXRnIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CVMwsq1XIiNQjkXU5vtGn8LPOhRhT/9hvxtzM3BYkM=;
 b=jDbNTBAKe85xSxTnq65t9OHU9I+aWd/NIl5ZNPaFgqth3rM+js/Nwce+wqtmVGGq86bA+qusUIiFWnr25ysffzONQXsQD52zODd74X0KHc1amrofCZP9pdNjIkDSXMK0zxD9aUutCircMFn6s0SlXUEaX1vrTuMTYbecIiQhy8bpvqmZP5jLm0AqKly+kavXy+30iTZTr3IZKHS+dvxZYe4ASZGZiaPPsVCro5b1W6y2toSIMBLsXgp0b4j9NGHXgYAMaKbxWVuCTJr3UIRPMJfVkBqNmGso3yjTTRlWeAQ9oKsdcSXiAveAe6YR1ro/bcDmAKS9SRt7NKL1pBU97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CVMwsq1XIiNQjkXU5vtGn8LPOhRhT/9hvxtzM3BYkM=;
 b=JIjZqJVuTI/RG3bYs6Kd3FOif1XwAiVFPPgp14jiflEKfAbrHRte++zydtLxijTT2DblCh+3g9U8T7KKq9hG2PRWFxAnYSWcYlqiBejuJ035AJLmmqf6KNRBqEiKvlKGQgRIiyLD0jV6Khrn2xVQ8KjlGu8VlBz55SvngygQfoRxqcUwQyKHaiYgXf6fc/lDEUmx7vbxfKJIi/MjWNZc7rcY4JX+y/NOiBzhD1DSrJLf90LT7ew81kLtyuNUKkiI+JepWogDaB+vv3fiiJNMkP8qksm0GHCdOqoAcoEwiWPUU1hKlJFNn2kzkB/BAGX2GwIfJKeZORO4ls6oOJUgaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 01:26:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:26:17 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:37 +0800
Subject: [PATCH v2 07/11] arm64: dts: imx95-evk: Update alias
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-7-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480344; l=1697;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Q2VvgCJ4t8qclzBk9dDXs+WPZ6mVNhiBgdvrapImokg=;
 b=3kvlS2dZtvpDIlqVrPzmAN3m+5sOGa1dHmZg4vOHz2CyBDiOZyZwYu9B1Q2D6Vj2bZO91l0MN
 y1IGTyg7VZoAF3MsbwPVd+r9ZmHq261CBrjrG6LrcucRX0+z2U1ChH2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f64c31a-a936-48da-1d48-08ddddf63af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjVZcU05Z1p2T1A1NExMRk4vcThYS1ZZejZYandFem9BeHdLajZMdGNFUVdC?=
 =?utf-8?B?UUZ0N0lQdzlkY1oxR3V2blpvS0NHUzBSNnZrWEZRMjhwdU13TXlrNm4zVlRO?=
 =?utf-8?B?bWtZeFZZSTd4M1BaOGl5Qk4yR3paRVZHa3BNTUJNS1I5OWFDWUhBU1ViY0cw?=
 =?utf-8?B?NGxMRnRhSlhGcFZxSjVnNDFQVU4vclVqdFg1VVlCZ2lGMm1nc05JaWpsa04v?=
 =?utf-8?B?d29VM3dTaExteGVrUHNKeHd3SWpMeEpoRFM5dGlPN2VDRGVNb2xHaE5tSHp2?=
 =?utf-8?B?SFBSRDZobEVoT1JqYm9HUG5Ec3hxb0NGYjRpU3poYjJ3eUJ3cThwWS9aeC95?=
 =?utf-8?B?MXJWWmlQZUYyUVlFbSt3cVdJajdxWVZSd0JzYkx6VmNva0xyTFl6Q3dVaG5m?=
 =?utf-8?B?QVdLM1FtZm16SWhBV1dlMDl1YThLSVR0M09aVlN2SVlyTjlwcXBWYnFaNDcv?=
 =?utf-8?B?YU8xN09GeTc1NDk1M2R5MTlmUmtVeEJQR3NWbWI3ei94eUNqMUI4OFdzS0oz?=
 =?utf-8?B?QVFGNS9XdmxTeVhzMlNqQTNmQWUveW1iTDMwVDBNK2JpaFFMdk50NDNXRWFD?=
 =?utf-8?B?cEpRU0JscjJlM1loaFpJRFIwTkZJVnpZVjdqY25udlM4RHl2OWEvaW5LNGdV?=
 =?utf-8?B?MHhBcmJSK1dPVkFnSm95dlZ1cWJlVzg3UzQvenRra2IxNTEyUGg5eUZZTUQy?=
 =?utf-8?B?Q1RuZDNBQW9TVDJiUEFSL0s5QUhvQmFEZFpoM3huZlNOWE9ieWVNM3lHUjc5?=
 =?utf-8?B?NEdqZEYrSnhQQVhrQ3hYeXpQOVpHMVpPV2FqSHkzMjNMejJQUUNnOG1qZUdJ?=
 =?utf-8?B?SmZzeSszUGtBbkFrbXAySzIxaW5KeGVrVDNXSWZvWTZjcTN1N0FNd29sU01a?=
 =?utf-8?B?bVRmam9pTi9VZTBka0JmUmNpaVJ3cEJVZnh3NnFNV2kyazR3OHUvN2VuT2wy?=
 =?utf-8?B?RmhBWVYvc2hvSWF5YjByV3NNZ1c5SzRtdmlQbHVsZlZJZWhrdlE0c2NBKzJM?=
 =?utf-8?B?bWJ2R1Q1WTZVcjdZVFlSZjd6Y3VhQnlUYmtXa28wcG1ZTTRVYkEvSGZMKzBu?=
 =?utf-8?B?QUgrV1NjcUt3UUJ3ZUJ6MGora3BwQXVJM3pOMDZrUWFyNG1kblVlUVdCemtH?=
 =?utf-8?B?RExtSDQ4cUVWZlQ4ZHpEZHNpMUhjWXplNVM5MUhSNzFkTXgybUVycmRKekJL?=
 =?utf-8?B?TWxRcUhmK2JoQTU1UkxLT3pqeXNFTGtuekdpaSsva3pzS0hOK3hTWGFJeHBx?=
 =?utf-8?B?K2FOVmRVd3B2VHlWUE1qT2pTMjNlMExGNGRpTHgyUUFRUkJnS2lqVzhKdi83?=
 =?utf-8?B?SGdqaVpKV0UxcVIrU2Nad0pKYTRicVQyVVJYWGx6TmNLL2Y2WllQUG43TFRU?=
 =?utf-8?B?TUluSXpRYlcvcXZlWExhUkwvWEhVQ0VvRTNlcm41VWtkY0orNkU5OW9ObnQ3?=
 =?utf-8?B?T3FVc1p0QjVha0U1RWdCNndobVNmTWgxRzVuR2FpOXVVb09OeW1ic0tNWVdq?=
 =?utf-8?B?SWJ1MmhPVjUyT0ZxQXNkZldJWVhYNE9aTXhDRDVYWU96VjRtcUMwRW1VVm9s?=
 =?utf-8?B?MWFpK3d3aUxKbjJtL1R2anZMblhKb3J4am5iZFhhS1MxL0dXS3JpcFFuYXNK?=
 =?utf-8?B?eFU2Ui9tR053TkxLQWlkRGpDa3RQQ1VvMXNPT0Jzai84NWRKajlVTE1YYUlS?=
 =?utf-8?B?ZDZYMGZEN3BNd1pENGtaL0kxUnBwWUNWajZ3bTI5SVZFOVB4TlFVUHRRdW4x?=
 =?utf-8?B?eCs1dWhOajB6cTZMalh4ZExEOGE4enlJcmJ4c04vK1pPTVNiYTBsSTVjNXJ4?=
 =?utf-8?B?VTZvdjgySi9URVRBc0YrZGFLcUswUzFYZzNYZjVVSkNhS2ZiNkNLd0hrK1pp?=
 =?utf-8?B?QnY0eFpvb1RJUWIrZUEwbGhlbEJxeEg2M29VQjY0dzFFRVNacUlWTWtKQTVj?=
 =?utf-8?B?Q3N5anV5anRhWVJwc0JkcWRWLzFtckJiejhKSlU1RUpZOWNFRFF0b05xWFlI?=
 =?utf-8?B?OWkzc2doM0FBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU5HK2gvbFU3VElBcTJMV0NyZjBHRTkxTXZudlE4R0tJU0x5Y1h5R2lCekhS?=
 =?utf-8?B?L09laTg0bnpkY1B3SzV2SVRNMWRCSjBMZ1R3SHlRVHFjcFVaV2U2MWFkSjJw?=
 =?utf-8?B?eFludVBjVHNhUHJRUHoyQnVwWnNSZ20xY1JDNTdTejRBTFhtL2pMVUZaN2NL?=
 =?utf-8?B?K0pwU1FHbjZVUVhxTy82dWg0Q1ZmcVdjODhMUDhTWFRlVCtLY25yYWs2YW95?=
 =?utf-8?B?RnRhc0ovZXV1QWhMb2oyOVVobWhzd3M4U1plc2RkNWxZZmJSazVLK0czNUs5?=
 =?utf-8?B?Q1RSQ0Nyem1PYm5SWlVjR0syL3B6MVkwWU5EcHUwMzYzcEM1ZlhlcHFLSnJh?=
 =?utf-8?B?QW9YUHA4dWlYY1NDVi9qOW9hTVBSOFRxWGY0ZE5QdktoRlVlQnRRUlc5QTJm?=
 =?utf-8?B?amR5QjdYMjZRYVhDT0RMUVRGZk15TC9uejd1cmZCK1JJbEY4MHBsSHdYajI5?=
 =?utf-8?B?NUxaeHMxNUp0QlorNXlsUGxrOHZVclE0UEQ1Ykt5TGcyWk9UeTFrWEozaFI1?=
 =?utf-8?B?R1ZZcFl3MFNKN0drTVdPRlhVbkc2ZG90TlptTzRNbThsdXVXOTM1TjEyb3lG?=
 =?utf-8?B?ZnZacGU3N2N1UGtGTkpBdUhaTElkNDBpQ3JuQmVZOVNrRThjaFR0T3ROalNp?=
 =?utf-8?B?cUFXNmFwaUwxUXFnS1huY09iK2ltbGY0WEhTUWRkYjkvajV6Wjl3ejI4MzA4?=
 =?utf-8?B?eWJhdG4wQWhOUnRUaEFsS0o1RTZLakw3S2F2aUoyUld6cFVaRWV1U1hLWUhs?=
 =?utf-8?B?bEoySHNzWm53U0ZlbFczV0hoR2pVcld6OEVBdFQvaXN0cDBnTDQraXlpQ1dh?=
 =?utf-8?B?N0tpRndSWWFXUDhSWHJWbmVTVXJIMFU4Y1kydENBUXQzNUpZSUU1UkhtSE84?=
 =?utf-8?B?elFhcFc3aEhlL2JwMXk3QlNwSFR2d09HV1FiTVZndU45UWpXdklWSVByMjdj?=
 =?utf-8?B?VUlxWFFsKzdIbGcrN0VYdXUxZTlDOXhqb21PYzUydEJiM09QL2lsVmo5RUhO?=
 =?utf-8?B?UFk1eWVlaHZrVWFnQTJkRU9ST2Ixa3dMSW5WOUtsckhtdUs4OGkrSjhCWWFU?=
 =?utf-8?B?WFNtczAvREZvallhREpqYytqTS9aS1dKK1A4NmhjZFh6YmhRdmlPckdURytJ?=
 =?utf-8?B?TStRcExPNHNxQWg2aE14bVZJMXlzcXhZTG4zc0ZXRGVDQ2N5c0RzRkx2VjBZ?=
 =?utf-8?B?UU9Uc0pJWGRPTnNaZ0FMKzBUUTRyRzUzWkNEdmZWS3R5MXdWTysxbDhGNHFS?=
 =?utf-8?B?S3hHdjN1dGJLRUN1V3dKd3Q2bTdHL29EanNmSjJ1Ri9IQlZNQjk5MXYzTmZ1?=
 =?utf-8?B?N28zdjk0QklKNG9vb3Z1V3VIRnRaQUZ5TmRsbmNBbURib25JYVJMb3lEOUs4?=
 =?utf-8?B?SkpsSXNITW0xa2EvVzB0cjBLQ1BwRUQ2SitkWExJKzkrNTJrdlljU2NBOXQ2?=
 =?utf-8?B?M0hCQVJiZEcyVUIybjRrQ0Nvb1pQZnJlcGNNcVFuNXg4TXRxcE9GZTZuLytN?=
 =?utf-8?B?R3BwdHk1bVJnRU9kL1VKUFRaVXZxUUltK2FIN29uZU5kUW9zL0dsV0RmUzJH?=
 =?utf-8?B?dmk0NzhyZS9JZ0pTUnFYYlljMUROeDlTVTBSbWl3aVZyTzdRME42dnZVaG5s?=
 =?utf-8?B?NG40UHBNRjBpc053RTBuai9TbW5WN20rTHpMb21BUjBOTXA1RC9EcGFaRTNQ?=
 =?utf-8?B?M3kzVzdObTliSHA1Z0hLS3I0YlpsNHExUHdDOXJPaGYwNTdnUzZPa0laK1dQ?=
 =?utf-8?B?bzI1aHpCdWZlN2tFM0QxR29kTjdRem9pQnJwRXdCWVpGVHp3ZXhCd0lGOTU0?=
 =?utf-8?B?TlhzaVpndGdLMjFralVEVDU3aFNMcElXTm5xZU9MWWdxSk4yOGsxUkdMcWw2?=
 =?utf-8?B?UXV3VlFQUWRhL3lNSHRqNk05Q29WbDNMR1grMHFxK1NiQ0Z4eWlxcWtrMU55?=
 =?utf-8?B?NDFGbDRPYUwxV21JRjZrZ1NSeWRSM0tjSC93T3JxWjY0UE9QTFcwc2UxaTQ5?=
 =?utf-8?B?cnZoYkxzSlVHbXlITjRJWENzWmlDVXlhS0tqMzVIS2s1NG9rYUtLK1AzTklt?=
 =?utf-8?B?SWN5ZEdmSEtMbTh3TTloUUYwK25IcFlmYTRCZWdyaUd2MjRDUlBrcGRsZXNL?=
 =?utf-8?Q?qhJFVjD8OoT2w4IZYNKSuBPoF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f64c31a-a936-48da-1d48-08ddddf63af5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:26:17.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H79t9RO51pl8YUo5HYE3O87GRj0mtgGC08EQdnPaYC9EM7MgwpVJnohqwiZirT/UMcwX2B0YPL7kfwRIXsB+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

Add i2c, gpio, mmc, serial alias for 15x15 EVK and add lpuart5 serial
alias for 19x19 EVK.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  1 +
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 46f6e0fbf2b09106e6e726ff8b61522d1359cfa4..de7f4321e5f9d7d6a6c46741d3710756dd2b69cf 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -28,7 +28,24 @@ / {
 	aliases {
 		ethernet0 = &enetc_port0;
 		ethernet1 = &enetc_port1;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
 		serial0 = &lpuart1;
+		serial4 = &lpuart5;
 	};
 
 	bt_sco_codec: bt-sco-codec {
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 2f949a0d48d2d8066388884703c3b3cd678f16e1..39815b21d235d2f8cfa49720d3be49d056ea039a 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -40,6 +40,7 @@ aliases {
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		serial0 = &lpuart1;
+		serial4 = &lpuart5;
 	};
 
 	bt_sco_codec: audio-codec-bt-sco {

-- 
2.37.1


