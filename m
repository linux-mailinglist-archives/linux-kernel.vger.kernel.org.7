Return-Path: <linux-kernel+bounces-782221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB99EB31CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0A2643000
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B73128C3;
	Fri, 22 Aug 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YQNfNn9g"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108873126D7;
	Fri, 22 Aug 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874220; cv=fail; b=F4oMxDQJbPythOo7N60CgkXcBczPzwK9MCqkLXXPwDuZe25hB4sUUMVq7wUcRDA1WM3alZFqPxyym3YNPOaL0kvoFGE9gxcHfHET3ZfQp3wucTn+kNfabkcE9xmVlgotS8/2IE9BTDPG1iKMjXyS1LJA+HxyrVzhGcAHH21E8/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874220; c=relaxed/simple;
	bh=NWmUcJsvAnM6ROIyhGQejKUjCYwZ8nVmKH5A1wHxnxE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JWMdAqRTZllBYFfGJgXjblGU9voK98HMYdvt7ElLNSDNXO+WUlajmzWiT/Jp2tyrJ1UEH5T0/4uuEcuXYRkO0SxfJWrfydVEjfaAHdnWd+2kv12LU99dTJDwighi3AtIeASw03bFQmcQBe18VDBsM6jlEpLuT10B3IZnTbSPySU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YQNfNn9g; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrxwEG3h7mh1FsddGaxI/rZftIydGGQ12Bgf/fa1Z1P2lPwg+USb918bF0x0Mpfps7QJAwHT4Pil75q0ek5fya/xBqRPq58AGgTzMsTouQkDxB4AF0HhQjmfQ477h0Dv/DXtmhrLLVtu3/1j1eP6ixJYeeW+HRztK2HmOMmXBtDeoZ4XZ3OPXfjkLkmzP4QekP38Fp8y2Epeif8eK4EvCt/oBrDcyZCZn+I0biVZKUMi7R/6u/koewv9eILvFjIkgz9fdm34yqzqwnw1I0eJtakRNwicKD/BMtzEPdSSXyOebxXNaMnXdluFbDa8tzsU+t0YD/R++x7xDB6e8hfIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbUWujwXRpk5fDpO9qmpyq5ZiKCQNxD/Ntue5Kp4A9s=;
 b=YTqdVFNys+Bk7NZlM4PUX5LPPPLBK4kaBqcqzbTm/sEEL0YyIgUsCcqUmc3BKqmxQWU7k/0+Oqs1UO8KKrW+6hTbyzTtkVAqUGdjPNU4TpUipObTFA8ppVJINwzW/+aglcGMlYQDfziEJfEqiK9i54aJuyTOYAV0gNPf6OYSxOEgDiM+wYk5YK2UPd4XTNEiOsRKnAW3twDhFT1RvIx25YDIjjBWzKkLl0ZnGvtoXpcz2/UdfFAEGW+QYuyqMV6DdMcBWXV4hJzvtsRRQkVU/lv+FIagYwj96+LlbLCDTXynJ46X9iBgpeIayaRbiOF/d9E3GeExbsOxJLX9zboeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbUWujwXRpk5fDpO9qmpyq5ZiKCQNxD/Ntue5Kp4A9s=;
 b=YQNfNn9gdYj4VYGHKjmNnQe7Vz/IO/G0pMLdvx2cini/3/x3zXXA2NqVtUw/cBgvWyKGbfrMXKPQw6AfXlT1V5XIS7pgBzlJBCistCTHXVHpuS2forrgO3sHyjuXywOMtiYKwoYa6Pb0NYRzuueVIL+QwIEaaNax+WHebcHm9RcwZ/1t8Nm019aP4jCbRzFmHeYLch3HqoScv3rHCGxvU7j5orQAmhre5vweaSpD/oqOgkbZsqvyIS55ao2PQbLD9wjArH8HVQEfyjFKb5ynEXrndE+j4N4SW1JY/8NlFEOhd4gAwLaMO8OvBnvcMZZ0Bx1wXx31eMkpFK9lpgS39w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9086.eurprd04.prod.outlook.com (2603:10a6:150:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 14:50:15 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 14:50:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 22 Aug 2025 10:49:58 -0400
Subject: [PATCH v3 1/4] ARM: dts: ls1021a: Rename node name nor to flash
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ls1021a_dts_warning-v3-1-6b611a2f23a4@nxp.com>
References: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
In-Reply-To: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755874209; l=1754;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NWmUcJsvAnM6ROIyhGQejKUjCYwZ8nVmKH5A1wHxnxE=;
 b=CoP65bnF/mKfY/qYvnqdA//x+Vd/rYOmCtIPdg/xzWpjVOEiJLC22dUH0V1n8Xewc9pVhMZXS
 IWKK+MeZVnOBRcz2rl1Fzim2CKmPOmZ1Ozap41HMBHrKe0hFStVtPhH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a088592-4c57-4757-aafa-08dde18b341e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTZ5ckxxZFU4Sm9zV1RyVE91cVNsM2dwTTRBOG1qTmdiRDg1R1BZcVRVczhp?=
 =?utf-8?B?UjBJS3ZLWTNOS1gwQTE0ZWplSmRrQ0tqbVNVU0V0OVcyRGFqRlUvUTlGb3RF?=
 =?utf-8?B?RVZvNW0zVGxNMGpzbGgvaUJFeEtleXpDWTg0aUE1TFpxazUyRWR6THQvdjNK?=
 =?utf-8?B?M1hKNVhWM3Q0ZWEzWGQ3QmIvMnZJOFhCa1Y0VEdiRFZZT3RpVFcyaWZqR2o3?=
 =?utf-8?B?STRvNFl1RHY3eHBwYS9pd1g3TTVyVEFFR3pReEtjZ2F5WFcwWU5uNXB5QkVv?=
 =?utf-8?B?bk1IRnFzOXBNRjNvWUhRWjVac3NVMmZpRXFuRFU2bXpGV1lWOVJVWXRHZElk?=
 =?utf-8?B?SW9IRllHOEdpak05cWNJR3VUc1FsQ3BvUk81aGliblNCeGFXSncxdFR3dlI4?=
 =?utf-8?B?Vmw4V3pSZEg0eHh1OW9BenpCWXdvelBLTmYydDlPUXFQTnhDcWtLZlNyM2Rk?=
 =?utf-8?B?WGlNRG5qRXFmczVJM1Z6cldpeDgwcnpZNVQzSTZJN2hDeG1LQk5lMEVTYzgx?=
 =?utf-8?B?aGZ0Rmw5aU9yeTg4UHBKenRMd3QvTm9uVkFoRGUwZmFad01LN0p2UXhQTUtt?=
 =?utf-8?B?dER5RHlrWGI3KzU4Sm91UVZ5TG0vaHhrVlJRRUVyVDZvRXZDUUQzd2R2S1Uz?=
 =?utf-8?B?RzZTc0VYRXg5ajdGZVlVQzQ0Nk9DVHhxQTVhZ1FnMG9XM09sRG5sbVZHL1J0?=
 =?utf-8?B?NVhCUHUyclpSSDBPcTJ6TEtvNjJBOUk5a2wzS09EWmRuMWw3VmlzRUFqNVpw?=
 =?utf-8?B?eHJFblVSTDk5c1F1WFB2VENXdDdlbGV2ajRkTVZFNk81K3Nxb0d3M1Zxd1Ir?=
 =?utf-8?B?WHMzZ2NBMU9zU2l0Z3JwZWFHaCtkUlhCeDJWZDZ5WUlqMjBMa2RwYnZrb0h5?=
 =?utf-8?B?N2tnNXVVRlJIUmd2YysvaURZWlVHODNMYzJHZjJGelNPY1lSeG5zRmRCRXpy?=
 =?utf-8?B?TWJFMUMxWlV5MDlTVzJvYkRyOW9vM2VjSUR3R0ZyWHhlZVR6RFhFL2EyQ3Mz?=
 =?utf-8?B?bGkrWnVSenhSUzN6Vlo5TG1BNW5uZzZaM0ZuenpQTHV1Skc3NUZ5Rk04MXJn?=
 =?utf-8?B?NllBYTMvM1g4T29Ob1RHRHdwa2N1NkdsNnJGbzNwQy9WTk90Z1lib01UMEc2?=
 =?utf-8?B?U2Q0bGEyZFpLd2ZaZDVrU3N3QlBNci9CMnN2TEIrWHJ2YjQ5NStWWkJycEJ3?=
 =?utf-8?B?R3RNeUdUREl5OXBrU1pNVEJBanYvY0k0VzhYU3RwNDErdEZYZjdRUzRPNDEv?=
 =?utf-8?B?SzhqWHhSMzhicTlmSWpvNUlvQXRJQmFoemxuUVYvRmhkS2VKSnRGNHk0L1Bv?=
 =?utf-8?B?RmVSS3hLTUVibGpteVMrWFdmWE9kaVBidnIwUDcwTzh1dkE5WnY1aE15THg0?=
 =?utf-8?B?bFJkSnVzVFdpeTh0NmVSQjRXbmdMZnYxTTZXZzJiZlJ6UEUxS2VSNDJNZU5k?=
 =?utf-8?B?azl5Wk4vQ01Va0dLS0J2K2E3SEwzSmtlRGhsb2t2VnlLSVpYc1J1cUMvS2N3?=
 =?utf-8?B?ajNVK1pyVkh6Q3RrMmFNQ3kzckNZNUpZMnR4ZlJZbG9TV1Zqa0tHaHNZR1Vl?=
 =?utf-8?B?QVlTMzFQK1h3cG9xdmhhR0xQd05SMVloRFBLRUd4aDc0cWlubXUwQmxtSkVm?=
 =?utf-8?B?WlEzN1RnVFg2bm9YaHlEc2R2QVVqV0w5cDR0d2JhaGFkR3hldUxRRVQ3c0pY?=
 =?utf-8?B?NFVwUitSYkRKWXB4ZDZsU2grMDdkclVDV2FQTlhxaUFyVVkyekRFbmpwN1N2?=
 =?utf-8?B?UFVPTlY3R0tmYzc1Tm9IK2JYN1ZsVWs3ZlREU2xtRUw4RExqUHpSQ1BGa3BX?=
 =?utf-8?B?UXNGQVI3bUFmNllsOUxSbEJobzIrbUNjYTlmRDVFdkNYYUN5UGpoNXpxaFdl?=
 =?utf-8?B?ZTRld3dBM3ZkQ2w3NjhaSGdYbUR3ZWxTWGZXSUx3MGdqSmkrNCtjOFBrL0NN?=
 =?utf-8?B?dndFTGp4clJlYWkwSGRROHp5QmNZTUZWb1dUVDFJU2tpTlpQc3pnZDk0dWpa?=
 =?utf-8?B?MjV4YkdsRFZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjlKOG9GSWhvR3dNNGZtZGdIMXZSdm1zV01uYWRydjVIUFZpTkd6bDV0MFZJ?=
 =?utf-8?B?YzZ5MERQYXVQdjZuanowYUNnSXdycWIyVmg1T2RwU3RXWUd5SDIxNWJwYzR2?=
 =?utf-8?B?MTdKVUdSNjB2blkrMVZYOFliVXpudzFreUdWcjVyZ2pJTm1OWVByNUdPZEJy?=
 =?utf-8?B?ZS8vcXI3NFRjVFpSMTErVHR5alltTWFPMmdULzYzWDBaMFVCRFozYy9uQXYz?=
 =?utf-8?B?K0ltNDZ5ZU1CeFJjNm1rZUdDY1hDT2hzRjV0a1Z0cWVrODBJUGZIVk16bnJE?=
 =?utf-8?B?V0tmQWI0VXEyYVdVTkh2ZjJDc1l4ZU9Tc3hXdEt0cUF4M0VBSUhXV295SE5i?=
 =?utf-8?B?T1ZZREVQQzVIQUovbXcwelU3UDE0U2lCMWUyUStFdjd3QzNQSGxiSzdNdHVa?=
 =?utf-8?B?SU1zalVFTDhYa1krRC8zNU9tb0J0dUNTbnF5ZVNETWR0M21VbWVZRXd5MjFT?=
 =?utf-8?B?N1VTVlZWOUZTN3kzOVFyd2Y0eEtpcGpxRC9rYWFRSjhsdmlGYXlVZGdhZmxP?=
 =?utf-8?B?QkhXM2hjM24wTit4UmwzSytON0hEMnExVzRQUjlONWVPUnBsaVIzMngybmtX?=
 =?utf-8?B?bU5pT2QvQkl0c1h6NXBFQ293ZnJsVGg5NEJEbjFRekljVitYOGFMb0xiWUhs?=
 =?utf-8?B?SGgxWXhpcGl6b2ppeTFiejBzYWgzYVRLWFduWkxUUEF3cjdOVm42bVhSWkll?=
 =?utf-8?B?b3lkeitxdUthWE4zUXFZVklCMk5GakhvazVob3JsNE90MVJBWHhLZzRYYjht?=
 =?utf-8?B?cmhsSlVheGV2WFZXK25hWUpOREExMEJDdUJUZHVPVFlMOFpHVEdKOEhWUHVt?=
 =?utf-8?B?ODdldXQwT3JjU1NjZGV3ZjhPMlBUK3VYRVhvWDV6MEpXNm41QXdKQVVZL3g0?=
 =?utf-8?B?TTBiRXMxMGZDN0R0Y25Rck9DMHQzVWcxaS9Xa3F3R215dG1Ob1ViREtYL2Jk?=
 =?utf-8?B?aHpDN3Y1QlJyNHl1VHEvaGhteEJXY0xybXlUU0kvYmYybVh3dUFRMDFmUE45?=
 =?utf-8?B?cHhoWlpRNVloL0ZxemRiVzJ1TU13eW9XYXAyZFNabys5alZzM3JORXRsSWVn?=
 =?utf-8?B?TVgxTTlUOVRFNk9mQW9DMEdLcmFISnRoQm5ERjJwa042MjBocHJwcHp2NzJl?=
 =?utf-8?B?VFQ3ZGgreGcxck9xdUxpMW9SaGxPeThnYTc3OWxRMHRURkxIbUF0dWRBUjFE?=
 =?utf-8?B?c3czTVh2TkFaODZ4QzZhazVDaExXaTZuMlB0aTNQcVNuYlNFWXk4K0JlYlpF?=
 =?utf-8?B?M3hhbVB6MXM1MmdsY1owNlErcXFlMWtIcjdoRjZMTjVNQ29Ed1JxcW0vNkpw?=
 =?utf-8?B?Ky8zR2F6SjFEb0pZN0J2NERBdTJidmx2dEU3ZHFMSnJMTUtXcGlXbDNTcHpH?=
 =?utf-8?B?ZUY2Z2VpZXR6VzNhUGhyNmRwc1Y2eUZ1UXg4WGhvU3dZNHlhVkQ0SUliMlo4?=
 =?utf-8?B?ZnBzeDYxWmFscHNyblJEWk1HMW9tQTMzUnhWcWl2c3BJL3VFcjRBMkRXd0ZJ?=
 =?utf-8?B?LzJIQWoxTmpYbGdZY2crc2tlRzNEY1h2MStRdFA4MDh6NGFvR3I4RXROOVNW?=
 =?utf-8?B?MVpxcTZ2elgzOGpHM1dKUVUxc000b2F1blBnZVg3NkQrQThoMW1OclA3aTJV?=
 =?utf-8?B?MzA2ZHlTdVFLY0V3SngrcGgwaVBQUGF4KzFWRlRHRUNVR3V1ekhWaHdpamF3?=
 =?utf-8?B?TUhnZWV0OUNrRk14clN0dWxOenNTT3NCWm5RZUt1YXpheU9mZmxtU1NTY0xC?=
 =?utf-8?B?aE9jR1B2cmRNb0dwMW5EdndjdE44UHB5OTVQVjYzQ05CZk1UZGZhWER1MDIz?=
 =?utf-8?B?WVRBcmdVR3d6SFdNb3hYaUxtL3BRdWNacDZhMjRTT2xUOHVLSWFpOUwzd2t6?=
 =?utf-8?B?ZGVrUXFPSFZJb2Z3anRSQ1hWamNJUDdmSGtsZ2kwQUcrbUR4dnZUV2pxS0Vs?=
 =?utf-8?B?cys1UmpCbHJtcmR6UEovYnlFajFSaHl3c2ZmQnVkS2oyQWc2QmVyN296bkY4?=
 =?utf-8?B?U29ZNU1aeFFVNU9qbUVmK3pKWUdOS0dzRnNoYlEwZU5jRHQ5bW0vd3lOdldO?=
 =?utf-8?B?VjRSOGg1cnhhbFpCNzE5ZE8vZlBnRjIvQXh2cm02RmZpczBVVHNLZFBLVENq?=
 =?utf-8?Q?MIc0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a088592-4c57-4757-aafa-08dde18b341e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:50:14.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiOhQx/JMnXZKGQIVAHNkywoPvHsXnIDhIvsQTGiB8OinXqkCVVzMTlZUqevA05VbISxPVHgGIxUvGbyuBSRXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9086

Rename node name nor to flash to fix below CHECK_DTBS warnings:

arch/arm/boot/dts/nxp/ls/ls1021a-twr.dtb: memory-controller@1530000 (fsl,ifc): 'nor@0,0' does not match any of the regexes: '(flash|fpga|board-control|cpld)@[a-f0-9]+(,[a-f0-9]+)+$', '^nand@[a-f0-9]+(,[a-f0-9]+)+$', '^pinctrl-[0-9]+$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 4 ++--
 arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
index f1acb97aee69bbcc30c8034e627a0bc6584bf608..8bc8ff2e3b03d6eeb43d79fe0555842536ab735c 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
@@ -66,7 +66,7 @@ &dspi0 {
 	bus-num = <0>;
 	status = "okay";
 
-	dspiflash: at45db021d@0 {
+	dspiflash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "atmel,at45db021d", "atmel,at45", "atmel,dataflash";
@@ -187,7 +187,7 @@ &ifc {
 		 <0x3 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
index f5c03871b2050c7cad854afaf59db046640df3c6..38281b904301df6a9d612fdd4384475a68b0cb33 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
@@ -151,7 +151,7 @@ &ifc {
 	ranges = <0x0 0x0 0x0 0x60000000 0x08000000>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";

-- 
2.34.1


