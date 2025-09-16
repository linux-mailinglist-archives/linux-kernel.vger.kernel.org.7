Return-Path: <linux-kernel+bounces-818413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4ABB5916C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5025F2A7A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0DB2BDC02;
	Tue, 16 Sep 2025 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lGWGQ7Cv"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119C29B8DD;
	Tue, 16 Sep 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013069; cv=fail; b=bnhFweyVSF6mFAE1M9r7leOX/78YkFtJSGczxoHsic2/6in45MVkYpLcoHQZbiwVQ8IzqhbGe8HHEEuQVMxs6wWhm8jAf4zM7stZXXxcjI4t0SGLZD4qea4wxc7nZCMcf2CJUKq+mPzbde3cXnbrwLS1lo0isVmijeNKpHduzJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013069; c=relaxed/simple;
	bh=qzmI5kCYsZn8y8BL5dB7a9++70Jm1pLMzJ4jwrva9HA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dfexjqZSumLugHPsQ2Loyk9KsQlvqLPkxwqZSgG8wQCiWACIjL3QA5RexBJzSzm0MCjT0wVpBy72TfcJtX1rlTsAyjxLhuDIkpXAznk627mLAKIOxIrDnMetbsin9/YmDmlnNBhRmBBFU0PHEqdDiqqwgCvLv5e8Ap5qAtpOZ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lGWGQ7Cv; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGnwLDGG/R/bS02h0M+i4hpvJruIdrUw+MgucE0QWlpTiMbUpmfWkI1WPZPDEiZL4ZIObDCJ+SnVd/PSvkN2gBWSPAm/ycsBsNmtUWNACYAHlhDmxn5RiDKq0tW7XuNwlInuphYJHDotx3DO/ssWZ1klWjw1XY2oLTK8if4f0lFdwe3oupeLPF8uE6m1gvAP5inOZBU7av/8rTXgK9XbVjOD5bbigz4v3m643DoCWJTJ+FOX4+5Y+4sImKUpfgOZMRk0Fc8EUBHzVnEDbooMCvhUq6Kgju+Q4HT+mA9lHOLj+9LT16GbH73kRrKn5+B+xZc0eBQMJWWBe2xovw6Vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+8YEM6PKNT+haZcOc0Cf6u+4QCaRua5P1vtL7qF0Xs=;
 b=PMyJOWXxQl3y4+wzsG7ELf3JQ9qcAspazM3IUCzF3/76Ioe/L7Tzu/zhaIafGO7Dj03ushn3WF3bxs/Ye6eicyKnwyYEXctyYkkhiK+l/h+Tluw4h0m5alIy65o2+3O/IAK6lmsC4xwXrylTl0ywFOyMub45+hLUObxUYQU45enF/QpR3N5jlGL/ELmlxI6CK+O5oqLor756yG0mgj00WVDqPXu8psEfzDUQW50iHA+hU1LLpSS+DaWaGrh+ngNCA5J7fnLeELZj6OKwq3Mrlv24NpS/D/grUonS9J7vR9ug/u18hQD/vhYbzNHMPQruxXDTfWmR7sj+kc3sRsDOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+8YEM6PKNT+haZcOc0Cf6u+4QCaRua5P1vtL7qF0Xs=;
 b=lGWGQ7CvdF8oj40reE8CZhJIwXnTGoKNKYwvHPosFwnplp/EQLpSHq0hLPEmIOxUWJtj7ny8vWO1MnkwsEF0zYIvIkG3ueqm/UBVDop/zI94TCJuuwvKLCSYDEjf4Gxx9wwcdLMuJkfKLVNX7Qj1qxFLkqqHapLiTi7j8rMyOa0e66ph09xmcszu0IHFaxxAsdmtAeRsd6HQLY7LqvrrmXpODiNrCDQBnGf934V1YyPVyW2ef8mxrey87e+GmkE0Jnp8R4ETt0X1F4UvHH8GP5Y6cYqD0GZoSnZr7ij8jrtlw9VbCKZVanzbhQ4zi7TYkc720xkEpr+nxkJj5fNinw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 08:57:44 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 08:57:43 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 16 Sep 2025 16:57:31 +0800
Subject: [PATCH 2/2] arm64: dts: imx8mm/mn/mp: limit the max frequency of
 spi nor chip
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-flexspi-dts-v1-2-61567f969165@nxp.com>
References: <20250916-flexspi-dts-v1-0-61567f969165@nxp.com>
In-Reply-To: <20250916-flexspi-dts-v1-0-61567f969165@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758013066; l=2319;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=qzmI5kCYsZn8y8BL5dB7a9++70Jm1pLMzJ4jwrva9HA=;
 b=2XNrcb1RsU3ujQbwtqRJzHV9bCAgsEia4h3CJ5Rv+HQpwoLcvDzAYLweFEGNONh+yVTZPMiaK
 yutwnHuJHboCNSARo4dF0FGi/fsVdUCzptG6oDQsyUkny8cQl3IOFBW
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::10) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: d418c206-069d-4f1e-75f2-08ddf4ff1934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEpHN1d1N0dMUnpzVklZeEprV0J2blhDeGRhSktRekRzZXNjWUhyZkYzZXUy?=
 =?utf-8?B?MmxlM2kyM0YwSTJDbXBJODR0WHFuS1dESmd1Q3drR3pnR3JKaWRiWnFVUVdo?=
 =?utf-8?B?a25CUSszNEdKUkpheDM4Y1dTL3RINkkvQ1M4NmN2aDlvK1hwdzhZcVc5UFN5?=
 =?utf-8?B?bkl3VFcxZkNNWWhjK2lWTEVZem02Ni93M2lqeWFmUWdrTnU4NlVkZkNOSXNC?=
 =?utf-8?B?dkdiNDBaRFNMaEpmNitydHF0dTRWR09QOHd0NmllcW1wOHVwL2o1Mm1DZDY3?=
 =?utf-8?B?dEp1V29CeElFdTdMeUlQdWRZSVJwK0tqblpWK3J5bnZKYUJSQ2NUN2k1a2tS?=
 =?utf-8?B?Y2c5VXBoMG1IdjdmV2dJTGlWZHg3SWJpSDVSbDVQNXEwRzNKZ01TZjFyc1RU?=
 =?utf-8?B?YkIyb0o5Y2JCTkMyY045aUxpR016VzU3a1REbnFnNEhEMitUaHY4T1JZSTlK?=
 =?utf-8?B?UmtBK0o3VW1uUXQ5L1pNT0FhMkVEU1FTNHdBYlg0NXFsV0hIUTNwWktlTlhY?=
 =?utf-8?B?c2ZLc01iQ1hITk5OMzYzMFAyQVVWVVhQTXljcHNJRGZSZDRVZHB3NmNkcHN2?=
 =?utf-8?B?QVFSTm9Id1RibU5lRzZJWEQrYkRXbnduOVNnalIwcGIxN28vUGxIY3hHYUR5?=
 =?utf-8?B?NFNCKzF5MGJlbzNrdU9TL1JPMmljV1FPcy9SUHY0aE9MM3hqc0FuYVdUQUp4?=
 =?utf-8?B?dUJ5NkszbUpFUCtBKzJ5OG51TGlOODdsQVl1N0k4Ykpsb1JyRG5jck9YSWlK?=
 =?utf-8?B?UVdkUFh2YU9xZ0ZUejhYZFVIY0JZYWozZlZGRVZSeGxmeTk5aWdobS81RFlC?=
 =?utf-8?B?dHFQY1FWNTBibVRySVMyNENlTitxdXhaOEg0di96TFNHeSs3S1VWWkIwQkZN?=
 =?utf-8?B?ejZ2aUpmSG9QMWRxeGtFQksya2UxZGNTZG84bWxhL0dNbVpOOW9EN2d1T2dj?=
 =?utf-8?B?L2RheXdGYlBoU0NuSSs1VUYvZWlZYUkycmZmL3Q0VXZOeTZ6a0JHUlhVcXRE?=
 =?utf-8?B?UUdlK2RRVHQyN1pwY1p5OXovWlNwbUlGdHpqWmtOVTFiVmNYQW5rUENsV1Fa?=
 =?utf-8?B?UEV1YVZxYitnNmlDUlJtZjF2RWl2d2l2MXZIbnZRa0c0OThuYWtIMUZxaytM?=
 =?utf-8?B?YnRxS0c4VGhoYW1qb3R1dUx1cXNrZENWVEFldGZBK3VuWUxEVjJWOHlTZmhW?=
 =?utf-8?B?V2dwMktydkhlN0EySHRGdktUMzNhTXpJcllCbW9GL1BXWStYcUdSQjU4dmpi?=
 =?utf-8?B?TGpSMFBJUVlHTkVac2FrQU1BcjRQVm8ySy9yQzIrYUtmUVNTcVA0cm9WSTBN?=
 =?utf-8?B?dVZzeXhtY2ZRQ3BmMDFQQU1kSUhyTWxjNzVjQzE2bkJXT0h5ZnUrSGlrODg1?=
 =?utf-8?B?ZnRMbVh4RnlJNzRDbWQ4VmJkeS92MXR2b0l1NmUydTBadFRkY3dQbG1NQ0hQ?=
 =?utf-8?B?dUlad3dDWUZUdW1HU2xUUHlyYzVrTWIvbGJKc3BWYmRRU3JINy9HQlhnWDE3?=
 =?utf-8?B?c3BIM3NLYzJFbGwyVUVMcE9pY2lYOGFNV1g2WFEzTndLUnFiVGVHd0p2bnZY?=
 =?utf-8?B?eHBYYTM4SDFjaWRrZmZZRjFuWHFaeEY0MXlYUlBIaFYvU3Z6S0h4UHB2S1Jy?=
 =?utf-8?B?Q2RHVVgzcDFWYVYydlhETXlGQ2tGQlQ1RFl0cGJxeXNFb1VIcW1iZS9oVkZN?=
 =?utf-8?B?dE9yMXhvcU5jZnlZMU1BOTI4SWxnTy9kVkZzVzFUVjVrS3I3MEtzRWxuTHpX?=
 =?utf-8?B?K3pKejF6bDFCelFYTDR4bit1THFBWnhlNEZ0S294aWNab0Z0YlRTOFF1RUFw?=
 =?utf-8?B?VnBEelhaeVV5ak5rTmJyQmpQSWx5TnZVNm1yYUNCd1F0ZzZMWlJuZXBYeDRv?=
 =?utf-8?B?TTNOcHhvUDErSEpQMTkrSTBPUTlUaEUxR3BuOU5UZm5sOXlPWlpzYVN4YXZl?=
 =?utf-8?Q?lW7ujkUMzYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3NKbndXTEJwKzJzd25LZFAvWTd6bmJWdzBmSTJ5K01xaU0vdS9ZUGh5cW5P?=
 =?utf-8?B?d2k5Z3E3TGpTQlhnK1dwR0U3cGZ0bVZiOVAyeHltdGcrUDZrTS9pUm9rQi9I?=
 =?utf-8?B?cW5RdDFwRDNkZWlqZ2xkZjhDMnhvM1JtNVZneXZwN056VUtmUGgzMllDYWdX?=
 =?utf-8?B?YW9wTldjNG92UnVnQUFDRFNnMHVIeGhKcTFydk4xbzhBNEQvMzJWcVRMZFhj?=
 =?utf-8?B?Ykt4YzRCVW9YRTdVRnRrSjk3WW93QVdqU1dNUTJrZHIvdHJrdkdXTjJSVDJu?=
 =?utf-8?B?dmV6Slc3bGRQbkJoeElQSWhiQnRTaW5BVFRGeWFTT0ZkZnI4aHZPVHpXR0dI?=
 =?utf-8?B?YVJnTlREMDQzK2Y0WTFNSnoxMXBMNXord2l4NVpmVHN6Ri9IdWxXN0xFL2Y0?=
 =?utf-8?B?Wlk5ZkQ0N2ExeGNtZFB1a2o5bThzK2Z1QVhGTnNtVjRlRTR4eFZac2I5OW9j?=
 =?utf-8?B?MEJTZHZIcllJSjBuRU82VGNOMTdWN2pJYWc2QTZYTkJRWnNFdFlGangyNmQ4?=
 =?utf-8?B?N1hHQ25WL0Q5Tk5tT1dtWE5WRnVSQ3RNY2ZxTUlteEZtd3dCcXhwaEx6QVc1?=
 =?utf-8?B?aE13K1RwSTc5YzJ6N3RNb3ZIQzNGbTBFdy9pVit2S1VYM01QTi9aYi9sNzIv?=
 =?utf-8?B?TTIzMWNUTWoyUkRBbWhiZjhvaUcyMHhpS2ZhTnFsVnJIQXZtMmYyMmpYMElk?=
 =?utf-8?B?YW0vMG43K0paSGZtd1Y1cXgwY0JpMDArb2F3RElmS0lqRWt2SjFFZXVVYmZU?=
 =?utf-8?B?TGpkVXJCdHhQalVrNFdmVVhkZ3FvUk9QTTF6QkVMdmFMZjVtRUtldUNicGpI?=
 =?utf-8?B?cFJIZjgzcTVkZVpYUW5pK1JUSnVIYzhxOHhyTGNnSzRualJJZDV2QTQxNVI0?=
 =?utf-8?B?UWlIUEhrb3ZBSHhJZ3FPK3ZCL0pJYkY2RjBQVnVncXIwdFJFMk5XeGxvbjJJ?=
 =?utf-8?B?UUxwczNYdFZHM1k5VTNCUnl0TXJ3aTcxWllsRWp5aDFUanJaYUsvZUhhbDhI?=
 =?utf-8?B?L1psYXVjU3JOZEZYckJuM2FEcS9ES09BbzI3Vm5PMXVPaWVua0llbHdieVhs?=
 =?utf-8?B?TU9QWit4QS9uVHZrMytqc2lDdUtYVnpXMXBOcGNWMzJFMnlvcmhIRGo5ejI5?=
 =?utf-8?B?U1hSM0hQdE4rS3RwSVRCSzlUdVdoSnZReExwR05lUjRmc00xTkVTdXZmb2k5?=
 =?utf-8?B?Y0lkcWNhdjVqdmVWNnpsTDZmZ2V3WFFYTHFyc0liVHFaYU1DZUxBUGF0WFRv?=
 =?utf-8?B?dmhiemxyazQ0TXk3a0dkUFJVZHduNmFkY1pHVDBjR3pMZ3oxMm14aGxOTjhj?=
 =?utf-8?B?NFNTbXh4OG14WGNHdXNaMUd6clRVNmUzVnhNSzNpQjVMQ2J5NFM5VHJzOGpy?=
 =?utf-8?B?M0M2bEs2NXR5Tjh6Sk1Dd1psdXEvNWFIQXhNZkM0L3V2N0F3R3VXSHVMUUZG?=
 =?utf-8?B?QjVoOW9lMmRWakl4eTNQTEJGcFg5N3RIL0JGaE80VFAwNHpoZlVqaE5EaU5x?=
 =?utf-8?B?Y0dDcFA2QTUrS3B5V2MxR0RxcEpUWlpEWUxHMXRmQ21KRDlYSzRXa2M2VEdO?=
 =?utf-8?B?MVdWUi96RkdQS3hKemdDTm1ONDVXNDIzREk0dVJXOUJVb3B2eW51OXBDblIx?=
 =?utf-8?B?RlRZdjFjVitrTXI4bWpVa21RblJuNWY4NnpUdGd2aUVFNXd2Q3pkWU9XNmdm?=
 =?utf-8?B?QWU1TVRSSUhpWThSbmRkeGZCM1JLM29mT0pEWEd2ZjVWbElTaXZOTk5yOGl1?=
 =?utf-8?B?U0gxbGpIakltaVI2bHpoUXRiRnJWR3hoc0lsM1gxeHYzeEVGSFIzVzczcnNv?=
 =?utf-8?B?ZklLdThEckRORjR5elMybVV3WDc0ZGNMNzVvTEt6aVlUS3ZUbmI1WkNvMHhB?=
 =?utf-8?B?bCtNNHBSeTFEOER5VXM3cDlueDJLVU1qaTlYZ3BFZ3RLWndlWkVOWi9sN0I2?=
 =?utf-8?B?R1NRMGJEOWJoMFMzNjhDWW10dld2QjhBT2toYnNoVHJIZWx4RjM1MEQrQXRS?=
 =?utf-8?B?dzUyWUFIa1kzS1VCNFJ4YzJRQ3Bxc3lpdHVkYSt0ZklTNXlwV1RyTTB1eFhk?=
 =?utf-8?B?RnVxektyZnFZaGZMaGl6Rmd3N0RCR2orRjJqTlZoYzNWOHJTd0Uxenp4aW15?=
 =?utf-8?Q?gKwYKNzh8IvDQe24V+7ATgw9a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d418c206-069d-4f1e-75f2-08ddf4ff1934
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:57:43.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fxw0Cikw1gdrRFHN83ShhgDmQk3FJBup+gSV5JJ01ozGuxozV6hlNBZ6IhX9/8uelp1Sk0DIdWtWR29k7SyVQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

The spi nor on imx8mm/mn/mp evk board works under SDR mode, and
driver use FlexSPIn_MCR0[RXCLKSRC] = 0x0 for SDR mode.
According to the datasheet, there is IO limitation on these chips,
the max frequency of such case is 66MHz, so add the limatation here
to align with datasheet.

Refer to 3.9.9 FlexSPI timing parameters on page 65.
https://www.nxp.com/docs/en/data-sheet/IMX8MNCEC.pdf

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index b68954bcc383cfc799877ff64c5d9a59dd863907..bb57c1db7c64adb20c996bbc2e3996e1fde5b98a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -47,7 +47,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
-		spi-max-frequency = <80000000>;
+		spi-max-frequency = <66000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 145355ff91b454795478b504eb403b0590848d46..fa43238e7b917a5b5f0bd9af96bd900f6dbacb8d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -199,7 +199,7 @@ flash0: flash@0 {
 		reg = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		spi-max-frequency = <166000000>;
+		spi-max-frequency = <66000000>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3730792daf5010213cbb9f6869a8110ea28eb48a..0b47d72cae9900ad53eed04c810a9ea8af795446 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -272,7 +272,7 @@ &flexspi {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <80000000>;
+		spi-max-frequency = <66000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 	};

-- 
2.34.1


