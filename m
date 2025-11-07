Return-Path: <linux-kernel+bounces-891018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2AAC419EF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB7204F14B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0F33C519;
	Fri,  7 Nov 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DGuYnwiM"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D233B97A;
	Fri,  7 Nov 2025 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548315; cv=fail; b=fX6VJHjiI1Vgqp9E3eAyCoX39/+IJduDImbELd1H2dpS/tTyBmzQ44OUqMjnJAkken0jGdmDvip9BoFH+URxfw6yE3b4fjHYoooNEjYbu6UnfR4C435HSRj2WIYPBCLo+lY4PceBn4QkP1e2Oxpw5WCkwy3+z8aU8jrfsCnvHfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548315; c=relaxed/simple;
	bh=eGD2tk77cR8fVglEDQuFj1Sy+TcvFsZNM0lIOm4qL3I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VUnqn84w9E90+o2wXMvBsb0NG+7nQatD4AgX3LkilD/BaKx9lxMKEhmZz9Zs8w8nd3MU8ci19ZhqMi6x76pXulF2IG/wkin4GFxVPDQfb4SSTMflDF3BNeGgEHH2enoF864WEwTTfJCedSTDRp7f2lSCeyyV3ApOs2a5chiudec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DGuYnwiM; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsGpASdjllDexzoZFdxqdXa+gbUD/Ppp0d85pg72RiDz4Y0xaajAiNq6QY0T65ZjfKy4h0QqLOWaxvh+0dp3i/3E58aXnqR8BTVxLR1Hsm5BURokWwkhvbtSHYGE96kWKFwaLiQ+fZTpE7SM0eXYAYo5DEU0ERQMj/EQGG57RWqPJWv4RgEanczK7ol2stwEwenUuz3o+g3cY8n6XV4hIdvs7Exkz32YdrEpkz3qcF5VMhQHiSw2jSt5ev7d5ceSLFC4pVH0teCjkjB7eL4Joj/ws3p9IKQh5qirQJ+OiXRlqDXeFx8swUq0RSwImQrhXfNXESq3/yvNx14XeF+0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j61iBTfAvtUUioPVvhteYZChR7xRl7RJTbqqqSt/s/s=;
 b=B7bNf/7/7ZrewToJgaXfbCb6r9gsxEAASjM286Hc9ttU80h3T9yedExA22zhgQQ1F1CMWV6rIVwKMW4T1R9Q1mlJ+LuqludPqCTuPeurQyp8uVin24btqVTJ0FQjJjFa+kLnXX+y//wlekPT/SRElDQphxkBlw1XU9JnD5iqCBIr+T67VUPWLroZJffptE2kCPzD5hEqhFBk5pRQEI84TAVwWMMaoASOv1IErOSCEkOgARBnqIn0PCGk+Na2NK4YZjUUB9WyUu/7Zf0yZUz/w8dDWPRr+L3Ejya1W9Y5mFZjTG4CBRyj8tLQYx2kjCWyk/pqe06HpxXkMdRvdKHW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j61iBTfAvtUUioPVvhteYZChR7xRl7RJTbqqqSt/s/s=;
 b=DGuYnwiMOUa2Ht7Hf5eC40FViOkP4oHg9tVYp/NzC8WH0zI8wVIWlycDKsLuTvPni+D3NoyhRL6VHl7tiQ01HvkDYdQ2OVcPhdr1fvhGCmejF8BSm/Id1KnoyoRfFfpByI6QsHnNbCCdLJ12Ue7ysh8iflHy+6CW0MhnjtmaEGUpSDGOmhQMCyJroXrFVmdHsVeP1Hg3XglIgKsHlMjupOi2moIL5e8YtCOIxZosBPJVOmvh6vbEKzFeQVZekA0ReWhPRQKR+db1Qv2NAHe9rWwtINZuT63gKErlaPp+0YPDwUUQta9m5i5lFsH2DNhavP0A49pxrE3o2uXLpkOm6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB12021.eurprd04.prod.outlook.com (2603:10a6:150:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:45:10 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:45:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Nov 2025 15:44:36 -0500
Subject: [PATCH 5/6] media: staging: media: imx6-mipi-csi2: use guard() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-stage-csi2-cleanup-v1-5-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
In-Reply-To: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762548279; l=3565;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=eGD2tk77cR8fVglEDQuFj1Sy+TcvFsZNM0lIOm4qL3I=;
 b=hAOGnwvs76FdYBFh2AXS53jAWp4b8ysbrjMdr7l4/ldR27CEWF6KZ3m7rJ/2dcyAos/xFViEP
 C2I/f2JZlShD2zgq642eOVx255u3kvBL3jDs/zR8bz8DZBEJP7GYPoi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB12021:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e76b178-3851-4eb4-adff-08de1e3e8a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU53SjZERkxDRTZjTzFSZEI1Ymh6QUR3VDYxb2RkS2lXaW9YNXJVSWRwM1lu?=
 =?utf-8?B?eGlhRjV1NkdXOGZpbTNHYk05V09NZWJ4aS9HSEdjaC9UcjdkRkROL2J2S1pC?=
 =?utf-8?B?VlRBNjRYbVBQWUJnby9mUTNmeFRyVEF4SngzZ3UzWENqSVJUdkYvV2N6VWJF?=
 =?utf-8?B?MTBJSG9XaWx1U09TLzFEYVlDRnYwNmh3MlRGYlBWcDFhMlMwWk5wNzVuSTlE?=
 =?utf-8?B?UkJ3TW1rSVlCWlk2MnhLSllEUWF5UEMxWkRveS9Uc0ZlNnQ1T2RWYUh4VEpq?=
 =?utf-8?B?dGRTNWQrOEJMdzZDb1Q2djl4NEZqaXEzODg0TUU3dDR2blJQZFIwQTdaam9M?=
 =?utf-8?B?QWoyNXVTbXlhN3dhVlNLZ242RXpDem1JUG9kSHpHMnRpVE1aYjF3MWRUam1x?=
 =?utf-8?B?RkNTbi9rN1BWcE9kWjFPRWROY1FlbTd6Rk1qa1lTT3Z6M0ZNSGtaK29zMTNj?=
 =?utf-8?B?ZEVreGlKdTZwWUI5UFNmeC9KUEEzUFVlWkJPMjdNTS9uSVdMaDJHNEF0ZzEr?=
 =?utf-8?B?WnNoYnB3SVA0ckRCNVVsRnpabWoxbG5vQnR1RGw1WEY2NWd5cnNtenNkd21w?=
 =?utf-8?B?d1JkNGdhMXhERk9TUlQ1ajl3Y0k4OUtoeDVvemQzNlhYRkxKd1NmRVBFd2JR?=
 =?utf-8?B?L2lBN09yQW1pUFZPR1JNY3NrbHVGMDVRUUJ2Tk5UcWhlaTZVbXNYWG15dThs?=
 =?utf-8?B?ZTIyUnhBeDZCRTlwMHYvS3grMVphZ1lvNWdzdWhtRXVKOUZIZjRmTlpkdUtV?=
 =?utf-8?B?dURmUUcyaEwwV1g5QmRrczI3Q3M5OGpkR2JRSXZwcWlucWEyREtDYzB6TVFn?=
 =?utf-8?B?eW85M3RQTzBHVTJPK09VTU5UdFZiUncvWlRWcm1DRE1SQzdZQjhYeEE0di8x?=
 =?utf-8?B?aUZYRkN0SXAzeEhYb0tSamQyMURqMmVQMkd2eWhJckFOazZ5a0tLUmZmVDh1?=
 =?utf-8?B?VWI1TzBKbEhVdjNTMEFtQnB2a0piOW43MkZGYktDd2xPb2hyNzlIdzBhWW9t?=
 =?utf-8?B?b2FhZ3FPaTdSOXpETDg5Z0ZtMGJRcExTZ1I3eTdVZ3ExdWYyRS9KZ2ZxSzQ3?=
 =?utf-8?B?SVRFUDBYeXliUldLRE9iU3UvdmRrVThXeS9CN0Fsc0IvZlBWRldsQkw5Qlk0?=
 =?utf-8?B?STVGYTFIbWs0UjF0ZVA2dm9hVjlCbnFRd1hqQWFHZEVLT3JnNU1tUngrQ2c5?=
 =?utf-8?B?cXY2TXFLREVUQmFrdHZZTmcydTcwc0pONXQwYW5yQWxDbnZRNE9SOXk1c09B?=
 =?utf-8?B?dHBWV1JFdWtpRE5GYWUvUGNhMUprT0N3QU15Vy8xMXQ4WkxoTWQvVXJ1Umg3?=
 =?utf-8?B?MDFyQXJWUUF2Mnk4M2FUSERKU2c4aVdNclQxa1NJRzQxMDAyNitpai96L1dG?=
 =?utf-8?B?RVJvYTJQWU5LQTIyV0tjRnphc2J4Q3dveUdPU2VMY1NoRDhrdW1vR28wdTZu?=
 =?utf-8?B?Sk14TG5uZk1PaGsvbFN1UVJpVERhLytQbVhqanBGZGhYS2d4eWU0Z1V1RDlR?=
 =?utf-8?B?WnkxTUlnU1dSUlJRTDMzL3laQ1ZOeEhmN0hrTGZJUW1MNUVLWXhnOUg0Q3U2?=
 =?utf-8?B?Z0hya0tBSVhJc1ZIakdWZTVaR0tGQytHNEJDUnVJUnNTdnR6Vjl0M3FHL1Nw?=
 =?utf-8?B?cU9IbStvZEFXV2Vvck9RNnRlUkhlY2tSdVU4VDUxY1FNQVgrTDM3RzIwU1VM?=
 =?utf-8?B?QTBYb0I4K01Zblpab0pRMVZ2RTJXRlN0TjI0NVBjelUvZkRPR1pYbDMzaHFE?=
 =?utf-8?B?eVFubGpQZVZjam5jaFFqcW01bzNqckxYM0lTS1B2M0Zlb05aN2dEOXFxWEtU?=
 =?utf-8?B?dWRMNXR3RWl5TmJINlpYY01RZUJmZlhVdzc0Ykphc2ZzYkFMMjRuMWZGbE5O?=
 =?utf-8?B?WkordmZwNUswRVB3c1JyRy9nd0puS3AycUVBNE5TTnNrMzRzWEZya0l6OVhG?=
 =?utf-8?B?VXZJcUp6MjJVWXV3aVVDbkQ2VFZCRVZWTDlNbXVsQkRmRFJoVkV5MTJZMTBS?=
 =?utf-8?B?aUJwYWxKSEdBR3ZTbzJ4QjVtUmF2ZVdvMkVJUndITy9CZUdTQ01LU2ZvMTVq?=
 =?utf-8?Q?L7CpIL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckpBQU1EczBhVnJlRTQ4d1ZoUmhyNXVpY3Z4akk1OEJsOWhaczBWUWV3QzY1?=
 =?utf-8?B?UGdBK3VtbmJHVDhNS0pwbHk4bjF6ZklCdUtzdWlQbHduZ2E1aWpGMEVNS2My?=
 =?utf-8?B?TWtsOGZsMzNaeUNSZmpVTkxmYTA0dlgyenBQb1hOUHVPYnlwSExvSjQ2YXpK?=
 =?utf-8?B?bGlQaFRtZ0daRWl0UlhCVXhzM2JqTndJblNrUGxSM2cxZnQzaFM5bnQ4bk03?=
 =?utf-8?B?UmZrUk5ORlJoMHNjTlp2cWh0a2FGOFc5UENUS29KL1ZhSnZVdmM0QSszWlhB?=
 =?utf-8?B?OUlNekZFRUEvZ1hRc1Mwb1J4SWlRMEZaeEE1N3h3bGt1bHdmNnFyM2t6MVVH?=
 =?utf-8?B?bHI1NjMvUWVtL3lEMm1TOVpWcnBKeXliNGU4RGRwSHA0OTV0cEZRQ2tJKytW?=
 =?utf-8?B?RmJFcUpuU0MwdjFDcnhXK1JaQTNBMmNpUzZBQW0raEpIbE15YkRKSTdzdGto?=
 =?utf-8?B?RjB5QUFkRW9IdnBaSGpIalNlengzRVVSb2IrZzhuazE4Qzl6a3NVOFQxTkxr?=
 =?utf-8?B?MzZuVE5yNCs1bVYvWFkvS2MzcWhPRnRXeU5lQjVheTJOZ2lSaFlUOGNUYk5a?=
 =?utf-8?B?cUptd2RrR1dEOWl5OEM4Z2R5SGRwb25sVWZaZWxLVTNQMmRGemZzVW5PZXRt?=
 =?utf-8?B?QUJjZFhqREp2VlByOE9saGpOR045U0NCM2NrbVZNV2NVbnBWcis1dEFhZVly?=
 =?utf-8?B?Q1pCQ2x4SGp1NTFRTzd1VDRpZTZaVnZtQXo0S2dPek9pNUxXK0pLc1ZpcFRl?=
 =?utf-8?B?VTRraDJSNGxwd0ZLUzhwdVNkUVhtSEE2NUwreFNEaWtaSE9lNGRQbW5RYlNh?=
 =?utf-8?B?QXVpTTJBVlBONmFXUVZzZHRKZFMwb3dYQlNtY0dYbEVPbHpPSXFBVzNIUUVh?=
 =?utf-8?B?cnd3ZW9yaklQbWhEc1MzT3ZlS1hCVzd0ZmhKMXEzWWFQMHFMeDJ4aWlOdEJh?=
 =?utf-8?B?amVSMkNFejV2eSt5d3JlZU93cXBmOGtFWm9EOWE1Sng2NjN3dTFzK2ZmOG80?=
 =?utf-8?B?OUYwR2wvVGJMU3Fta0wwZUpRVlhydW5pZTBkWTJtQjZSOEpRcU4rNVpFWmZt?=
 =?utf-8?B?WW9kaVF0enAxZlpRMDRSWUtvRlVjb3FzLzYrQjdiZEJLV2RHbFQyL05TQ0dS?=
 =?utf-8?B?WFRqbW82cGpQQjVXLzhzdExSNXpnaytzeXoxZTBFVFczSHR0SWEva2kwL2xH?=
 =?utf-8?B?blJsSVYyeUpsN3JUemVXVDZORTRRMTZpOFFualkyNmw4WGR6Y0N2dUhhdTJY?=
 =?utf-8?B?d0ZTeFYwdmNwa3BKaDBOTVJKUCtBNVJmSGR6eXMzSkZKZGIwTGFFTW9YNlVF?=
 =?utf-8?B?OU44VFVnZEZReWJnQnRhSVdOUHAvSlZ5WlV6bVVwVVdZVlJiWUpHMDRIaGRt?=
 =?utf-8?B?VEdSVHZWYU9ic29XRlJpVG9PZWtxanFLWGNJaEQ4VElWcXdlNWRjc1M4WERP?=
 =?utf-8?B?d2R1WEtrQWIzNUpCZVpqUXJMalNwaU1ONTNBY0VQTFlwcXVVQXZyODNnOUZw?=
 =?utf-8?B?bUcyL1BvSzcyTVBIQTRRdERnZGxaZ3NIcW1WbUlRZDJ3eU9iWmI2VmM4c2Vu?=
 =?utf-8?B?NGpVRm84bnhkRDNCa0plSzVmWVdlUXdkSzhaclZobkh0RURidDB3Mi9icGFr?=
 =?utf-8?B?azBrTlZRRFdKcGhPWHNoRk9GSG4yUFlkZVFPVUpvcVVHNGpYRHFCYnNOR3hV?=
 =?utf-8?B?SkhyS3VDUW1taGgyMHdHdTh4KzBHc0pQcWJrRGtrN250RmJhU292ZGVyYVZB?=
 =?utf-8?B?VHJPOVVNUGw0a1pJYXRiVFlLUzdqNUhNdkloTjBMRDdWbHRNUlVJZDQzeDZp?=
 =?utf-8?B?K3A4THFnQ1JSUGJZYWJhajFYalk4M1FOcjBOTndqb0FiZXN2bm12Yzc5R2hG?=
 =?utf-8?B?YXBENGFaTllSSHp6T0ZmK0UyRXNqaENLQ2FUcTA3OTBVbnVIN3paOXZPSFd1?=
 =?utf-8?B?MEFuclRCWWFScTZGTjNESmFzNTRlSG5TTXRKVno4QWNpeTMrU0NQV2FDZkJq?=
 =?utf-8?B?cE5qZU1Cb3NVbXRieWs2UFQ0SG5qVjA0ZWRJYnVBVlVtdXBFS3A0NXN6QWY5?=
 =?utf-8?B?cWZ2YndCVVZlRElCWVhZNkIvcTJsMnpvWUFONjZvcURXT2RLZFBVN0tlaGk4?=
 =?utf-8?Q?S7Mo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e76b178-3851-4eb4-adff-08de1e3e8a8d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:45:10.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj09ZDFs4g8hoZhhRfcbmzyxFvCoPqPWCcKdqRqpaGUfDijr21sQkA+QBpD91RgwWDmUCksExaC5PZaGkPd3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12021

Use guard() to simplify mutex locking. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 54 +++++++++++-------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index f8d0b3b8b250774af51f2aba731e639131aceff9..54e9491d3428686288a5bc9bb58a5a0a25aca696 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -413,21 +413,17 @@ static int csi2_s_stream(struct v4l2_subdev *sd, int enable)
 	struct csi2_dev *csi2 = sd_to_dev(sd);
 	int i, ret = 0;
 
-	mutex_lock(&csi2->lock);
+	guard(mutex)(&csi2->lock);
 
-	if (!csi2->src_sd) {
-		ret = -EPIPE;
-		goto out;
-	}
+	if (!csi2->src_sd)
+		return -EPIPE;
 
 	for (i = 0; i < CSI2_NUM_SRC_PADS; i++) {
 		if (csi2->sink_linked[i])
 			break;
 	}
-	if (i >= CSI2_NUM_SRC_PADS) {
-		ret = -EPIPE;
-		goto out;
-	}
+	if (i >= CSI2_NUM_SRC_PADS)
+		return -EPIPE;
 
 	/*
 	 * enable/disable streaming only if stream_count is
@@ -442,14 +438,12 @@ static int csi2_s_stream(struct v4l2_subdev *sd, int enable)
 	else
 		csi2_stop(csi2);
 	if (ret)
-		goto out;
+		return ret;
 
 update_count:
 	csi2->stream_count += enable ? 1 : -1;
 	if (csi2->stream_count < 0)
 		csi2->stream_count = 0;
-out:
-	mutex_unlock(&csi2->lock);
 	return ret;
 }
 
@@ -467,32 +461,28 @@ static int csi2_link_setup(struct media_entity *entity,
 
 	remote_sd = media_entity_to_v4l2_subdev(remote->entity);
 
-	mutex_lock(&csi2->lock);
+	guard(mutex)(&csi2->lock);
 
 	if (local->flags & MEDIA_PAD_FL_SOURCE) {
 		if (flags & MEDIA_LNK_FL_ENABLED) {
-			if (csi2->sink_linked[local->index - 1]) {
-				ret = -EBUSY;
-				goto out;
-			}
+			if (csi2->sink_linked[local->index - 1])
+				return -EBUSY;
+
 			csi2->sink_linked[local->index - 1] = true;
 		} else {
 			csi2->sink_linked[local->index - 1] = false;
 		}
 	} else {
 		if (flags & MEDIA_LNK_FL_ENABLED) {
-			if (csi2->src_sd) {
-				ret = -EBUSY;
-				goto out;
-			}
+			if (csi2->src_sd)
+				return -EBUSY;
+
 			csi2->src_sd = remote_sd;
 		} else {
 			csi2->src_sd = NULL;
 		}
 	}
 
-out:
-	mutex_unlock(&csi2->lock);
 	return ret;
 }
 
@@ -513,14 +503,12 @@ static int csi2_get_fmt(struct v4l2_subdev *sd,
 	struct csi2_dev *csi2 = sd_to_dev(sd);
 	struct v4l2_mbus_framefmt *fmt;
 
-	mutex_lock(&csi2->lock);
+	guard(mutex)(&csi2->lock);
 
 	fmt = __csi2_get_fmt(csi2, sd_state, sdformat->pad, sdformat->which);
 
 	sdformat->format = *fmt;
 
-	mutex_unlock(&csi2->lock);
-
 	return 0;
 }
 
@@ -530,17 +518,14 @@ static int csi2_set_fmt(struct v4l2_subdev *sd,
 {
 	struct csi2_dev *csi2 = sd_to_dev(sd);
 	struct v4l2_mbus_framefmt *fmt;
-	int ret = 0;
 
 	if (sdformat->pad >= CSI2_NUM_PADS)
 		return -EINVAL;
 
-	mutex_lock(&csi2->lock);
+	guard(mutex)(&csi2->lock);
 
-	if (csi2->stream_count > 0) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (csi2->stream_count > 0)
+		return -EBUSY;
 
 	/* Output pads mirror active input pad, no limits on input pads */
 	if (sdformat->pad != CSI2_SINK_PAD)
@@ -549,9 +534,8 @@ static int csi2_set_fmt(struct v4l2_subdev *sd,
 	fmt = __csi2_get_fmt(csi2, sd_state, sdformat->pad, sdformat->which);
 
 	*fmt = sdformat->format;
-out:
-	mutex_unlock(&csi2->lock);
-	return ret;
+
+	return 0;
 }
 
 static int csi2_registered(struct v4l2_subdev *sd)

-- 
2.34.1


