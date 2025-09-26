Return-Path: <linux-kernel+bounces-834345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C06BA4801
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271742A2BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73625394A;
	Fri, 26 Sep 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Geq/1ICx"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D3226D14;
	Fri, 26 Sep 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901713; cv=fail; b=RlNUufJDiQ+9x+GkNkRPKksBPsoahmnZqeXWPxEg+vvz6eodTOhHmJoIs5C9N5Zuh55h/Etyj6kQ9V2tVnD3k6BlcPHHDe3rIxTysM87MY0hNkIb2H5J8MBPpBtvvl2OiKRDw7NJxqEzRD0wL3r0pnZmCctj1O9ZKDEEiY4qBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901713; c=relaxed/simple;
	bh=C+/byolstUK3qbG2fKo1MZ04D0IETXzzliSh+5Ny0lw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UUOnNOkvHhXlFwQNAthLjIg032UQGbhhQl6xqn6YWPsuY5RGofcEVjS4b4CVKhC4j/gp/7cunQ0bQI7sAp4CuL2QEsfNvZur9/Swm06gyeMeSvNq78clhKDZ6t6Jj4jK4KrvzQR1hDfD2PJPz6l+8PeSF4O8hbVVKQdhOfd6fuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Geq/1ICx; arc=fail smtp.client-ip=52.101.83.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgvrCinfwOiVCoP23CLVWpUNRt1VwDUtaWY/onsFGmqp2RVns+TMNzaESG3MgIh06TgnRUFIKCEHzgXoNHDR8foijR3MTgoSiiMIXJQQIk4JD/R0UaG9K33GwMxQtrNa8knwbav+wInxZBmrsapdZmEQff55tqisVyEG8y+fUjJweNNeYtLqJkazKB3v0osXnKtAGfnwS33UvYw4q2u0aFCvmsOqTmy4Z31OUOOAmRnlfe+I5iSFnA9b0foxflg+ubMFHBjZf7W+LS4QnyVRjuVieHJBM9tuo6yAVNWiHAwqmZYyAOjmPE9PwBOhBeYeO/zmEOpda02yWnHWkWuHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twxCJtmU2KZ98rqCXb/Uh81mNSAdCjdLoHTNJdLz9Gg=;
 b=yrtHbhzSYTC/oxzzJHu8bpwDFXBmkNtNLkN535aHjqMQfAulWT7qutD8vnDTkJwsx/0MXtP1jEW8CR9Mwtz4eP252aTJhaloIn+FUI0me2xgMFuXztWW0JjEosOq8rcqeyP0G486KAk+4fgIn88M23iYxsZ11YvRvXd5auaygbkWAi7EoibetttQIHeho7g6qEXtue350dLxRqlfG8QdPmAMRqYg68zfZDx4BXVu1zYpymVY17ebEc6MJ/b3YQZQp4vLSenQo/z00BGxZ+DlA6Hjh2f85GLWoHd6pU7njO4qhyz8YLdUwoQNsMSM+edL+nNbD/VuLBSCFOc/LKmgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twxCJtmU2KZ98rqCXb/Uh81mNSAdCjdLoHTNJdLz9Gg=;
 b=Geq/1ICx3urDSNql1zR/HTTaol1ciV0NQfQFt7/qcANcRIgPgTY0RF2oSkdb4syebOz3AXTVi24VLEinKr884gAIoqsdPWgpa0xKY4Bc/eoTbIrWhzYfL3U9yu0Ez2aMUJ/3HMy2g/pseYtTTgvvOEEE7UBEzfzqMYG1Sgu0r5xlv9y/ftH1TC1XQ6wqdO8MeBqKPuYN8YRztIZLkgg1X1I/eUhkopSsUcf53pLwjqZjPUetyraIaiHpmU5FVz0J83Ff56IJo+aAX2L+VzzZzvi4bisvKKEg28hjn73+GSQ0qJC5u2Y+vP2uivou5x4n0d3GsA7kJywyfu6euijreA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GV2PR04MB11826.eurprd04.prod.outlook.com (2603:10a6:150:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:48:28 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 15:48:28 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Sat, 27 Sep 2025 02:39:37 +0530
Subject: [PATCH v19 7/7] arm64: dts: imx8ulp-evk: add reserved memory
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-imx-se-if-v19-7-d1e7e960c118@nxp.com>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
In-Reply-To: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758920996; l=1279;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=C+/byolstUK3qbG2fKo1MZ04D0IETXzzliSh+5Ny0lw=;
 b=ciAOYMCpeXC4MjDJB+9qRgewwRjNB4PMCE2jAR5Co0jwIFvkol84tIExkvPR2T0QLVCgZp9Ls
 zNPziVA+KkICLaehBBWGpFHUMWQsntmFhjGa/sTkuRVwQ5d4QVmx554
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|GV2PR04MB11826:EE_
X-MS-Office365-Filtering-Correlation-Id: 319040d5-ccc1-42db-6c8e-08ddfd1422f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXFaUWxRakExQ1RyQ1ZQS2VObnVxNTFjalV2MW8wOUw5c3dBa1Brd0NmZ1R1?=
 =?utf-8?B?bHpEcGVBMzB4aUpDZ283cjRaeGtEcnJxemdySU1SU0FDVWM4b0FReCtKRXFV?=
 =?utf-8?B?TzVRb3o1UEZTTlVVR0pVM3dRandIMVF4VXUxV3Q1S3lvY1l4ZVZZbXpNblhY?=
 =?utf-8?B?enVKS0o5R3B0SUMvbjZkYTB0TnNhWTc3NE43Z3JiOHVIM1JDWkxCZ2FTNVFx?=
 =?utf-8?B?d1pLQXE3dFB6VjVaS0ROd3NWUVBqWmI5VnlKREk1RlR6YjU0M1ByU1d0T1hz?=
 =?utf-8?B?WEVsVytUSFZYNUw5RXJRdUM3c25zSVVvWkt6QzhmeDAveXVCRS9YL2Jla3Zr?=
 =?utf-8?B?azMrZm90WUpWaFB2dWJtd1NiMHF5bWdsd0NJSkt2ZzlueFo1R20yZGxPeUFH?=
 =?utf-8?B?b3VKUXZjc1NGQlB3dTRZbEp0YWZvZk1FeldzL1ZvVXJPS3RXUWo4TUNFeWRN?=
 =?utf-8?B?UUloWWIrNjVQWUpROEg5QlEwZWtUcnFYUmlVa3FiNlFzN1YvWThnb0MvUGds?=
 =?utf-8?B?cDk0eGIvNHdyZHQrczNPOVE0aXRjZVpIb3EwTnR2ZTBWTkJPUmlTb0FBVzly?=
 =?utf-8?B?Z2pSWWNSamEyMzFidGc4WEZ2UWJ5ci9JVUpOQysxbTlMUS8wUVRKTEVJV2xq?=
 =?utf-8?B?Q01ZTW94STlOT2tRMmJGdkV4eGsvY1pHVVg4YnJoQWxPYUQ3V1d0WmlJNXYv?=
 =?utf-8?B?VDRIaFdvTVJJdjcrMlpXNVdoc1lZbmRtdVZ3dUNSdG1GdTdsYmdLZlJrcFQ2?=
 =?utf-8?B?Y0h0cjhhUVJvNU9jbHpSMXJxSDEzMHYxOVE4T2NDSXhqdnVMWlhrYzhER1k1?=
 =?utf-8?B?MUxsMEhtQmF6WUJ5SlN3NjBGQzV1Z1I4MW5jekIrUGJwTitUTGtmSnNUVzlL?=
 =?utf-8?B?V3cvSzFOSjdZUTVTTHRxcmk4dWRMZTNJdVMzRGdmTG1mUFhKSGdmVGVxVm9I?=
 =?utf-8?B?K3VTLzAwb0dWeWdnS2NkdytObnRKREJiRERHMGFVbjV4TEVzYUhVRFRKUzFx?=
 =?utf-8?B?WXRUYnRiWllvRnpKeHpXUU1WaEVVekd3UzFJeVF5Y2ZjUmN5bytSclBVTU0z?=
 =?utf-8?B?citiQXRXZmdzbUd3Y1prU3J6TmkvUzk3UkxOWlZFYitlVS8yNjA3RCtWTVlv?=
 =?utf-8?B?cHJ1eXlIVklJNUlGS1h0MCtCb1F6SEs0S29rVDRpMFJSQXpQdU8vVVVnZXVl?=
 =?utf-8?B?OWZoOWtpaFJOZGFBeXhleWpheVdEZDVLNmdZUW0vWU8rM3BhZ2xtTnU3eUpo?=
 =?utf-8?B?dWhDckhNS3hSeVhRTjJXRFA3ZmJ6SlhSZVNjVW1sRmRGS2IreDlvTTdkZkN5?=
 =?utf-8?B?dlpIdzA4cGl3bDY0UXlQMUtxRVptL1krUjlBN1g5RnVjSXduVDV2cHQ4ZWlJ?=
 =?utf-8?B?YU1jTVVCYnhIaEpyYTAyY2o0V2oybkwrbEQ3WDd6djl5U1JWZGRHcGhmYStF?=
 =?utf-8?B?SEl4YUFjOEQ2dGlzUDBTRGxjMFVYYnl3TXIrRW9QSHFwUndRTk4raUY4dVMv?=
 =?utf-8?B?L1kxWVg2UFhMdURmeGZCemNsMTZNMXVISXZkb29objBVTmJac2Ezd1hyK1Ru?=
 =?utf-8?B?WWhodmdaa3JsT05QRUViU1Q2RkJaMmRBNTBxZll0NThFT1lQbHJydTkrbFNW?=
 =?utf-8?B?OWdMakJoRGRQeFNKbmNHNzk4YWppWXBPTFRRZFlKVHpCdVEyNTdzempieldj?=
 =?utf-8?B?dU1sQy9ZY1BYR2l6U3QxUml2ZXVtblJ1bVVuK0RjcHdRZ3VCSmtWcTRZZ2tC?=
 =?utf-8?B?UXNlcm1kTlpad3ZOMCtUZytJWHE3L2JwV3U0VTZUVmtJMHBFdnBTR2o0aHRp?=
 =?utf-8?B?bWZrM2FTSmVJelNROCtxdWJUV1hzaHJDbWVTeWRLSmdEcm53QnczYjl2ZUpH?=
 =?utf-8?B?cUdLV3ZLWEpmdlJDcXY2SkJqSDFJdkw0UTgrZ2tYRElpZ3VqT1hMdml0ajhZ?=
 =?utf-8?B?alhRSHlYRzU1bEdzZlNUVFBkVWVLWFkwVWxrdEtEN0pVZEExb2M5Y21HZFRv?=
 =?utf-8?B?VVM0NGROT2JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUZZbzBhUUUrUC90NWhuVXAxeTZkWUxVWWNZTWlYS1puSHZrTmQyNHpxdlg4?=
 =?utf-8?B?a1RicTRmQ1BOd01XMWZWQUxkTG9XZjIrcnYvS3dtWnFueUw3eFhZOWdTZm1z?=
 =?utf-8?B?TU9KUVVOaDRNL2Iyd0p0RzNQWGFIb2FjNlQ4Q1BXRkZkc1NCQWg0MkFpdlNN?=
 =?utf-8?B?bEFzMmdVUU1jOUU2SG11SUhhYy9xR1cvdjQwMm00OXNhdjBuTzJtcXovcVd2?=
 =?utf-8?B?RHArRFlqSmdHNTZ6TjRQODZJTm9EK1JGaUN2U2QvU0pWTlVETTJkVzJJbTJj?=
 =?utf-8?B?aVYvMkI3N2VSRlBFcWxZYzZFcHZHeW9NZzJiZnZQcXdmb1lMUTlJYzdXU2o4?=
 =?utf-8?B?UkdNbzZyWVB6N3EwRmN6ckgvYTFVYmpwcUw5NWxBVWNJWWdIaHNabG9yTDdZ?=
 =?utf-8?B?N3A3L1E1VUNiVFdUR0dKNVgvZ2JFVDI4VEFuK2RtTk84MThMZGI4ZEVvRngv?=
 =?utf-8?B?ZmhONzRjVHBzbWNoUVQvbDQ4aDhkMXN0OUFrL0hPNlJxWlFnbzE1eE4wL28v?=
 =?utf-8?B?eGxkZU5VTzhjU0t2aDJoUWQ1SXpjNVVYby9WRmhGS2g1RmRpVGozb1JkM084?=
 =?utf-8?B?R1NkUUNSMkkvQ3dpMjI4cmJ0MzNnQ1NJbmhHMlhNVXc5UFBkOG40SmhUU0Zl?=
 =?utf-8?B?S2dTQmNwQWgwL2YrL21uZTN0V1N5RnhSWGtTaHdCbmxWcjZySEZRMUlvZHN3?=
 =?utf-8?B?dktMa0NWSWJmUEw5YzVVMEpkcHc2TjhsWFl4OE9PbWRNT1RjT1hScnJsRWNy?=
 =?utf-8?B?WkIvWmRhcG0zTzlnZlFlM05uTWt1ZWZubjkrTElCNDJTZlVMWWdXcEJKb1VU?=
 =?utf-8?B?aWV3UHR2SFplNUZnbHZKd2pmTFVGK29JYTJZY2lSQnV5UmZnMlpUSVhkNndB?=
 =?utf-8?B?SmhhTldMc0lXZG9yaThRa1lJQmg4RXhmb05xdTJVU3JqSDhBWFRTYXc4NS9m?=
 =?utf-8?B?WVdSRVhwVjY4SC83aXVkejN6T2UvVEV6MEttMnYwMnU3TjJqQ2hnQzlxZmUv?=
 =?utf-8?B?dUJEQXVYMXJPMDNjaTFKTHZMZTNsY09BaE5LOGhXSlpXSEdLdUR3bUlPaC9k?=
 =?utf-8?B?Q3FTMVQ1Rysvc3lqV2t0eVNUYzZock9HUGVtakxQMllpSDZZTlkxTmlRam11?=
 =?utf-8?B?ZzlSVmk2OW5pMFZaVkM5eXJEZGpUeG5rYTdRUXhZSUViZWU1SDZzamE3cTFi?=
 =?utf-8?B?M016TmlkRzJQNUp6TWF0aEtubFlhK2lPbHZqNVV1bFlPOERLZkZUcmFZUmpW?=
 =?utf-8?B?MHBobUtzQXFjb2J0YTZNWkw3UjZxN1pNd1RERlhZbG55R20wTTJpWUJYN0w1?=
 =?utf-8?B?YnJGcUxBeE9ieWVZR3hLVXdDQlhGcVN2MUlocTNqdUQxSHJSRzBYTitGWVVR?=
 =?utf-8?B?K0FwMEdEdkUxSld5YmN0alZFN0ZSMGt1S2dqWG1LNG0rK2QxVlYyZGdZdFdE?=
 =?utf-8?B?QVlienZ0NVVDd0UvaHFPOGVrUTNNTHhxUnBOeWw0Q2FCaXpRa0lIZlVJNlJM?=
 =?utf-8?B?cmJLTksxSDFLK3p4ckxRVGJDaHdhVzFSMmVHSlE0WHpyTDJRakVzNVZFVzhH?=
 =?utf-8?B?aTZRQUJiU1Rpc0U0WUhtWVZQTVk2dTBJbTlhVmpiSXYwUUxRdnpoK1UvSEZp?=
 =?utf-8?B?dDRPV0VzbGluRHNVaUd6SDhoKzFJdDNkQ2grSEtNZ1FRVkU4YVpCWDZxa2VB?=
 =?utf-8?B?WTJOV0M3RE1pVnMwazlCVFpkYW1ucEREdDZFenpmTUZXamUzWlJpN0RBL2dL?=
 =?utf-8?B?UEUzU25XK2ZuWThxTEVFY1BLamZBTUdYL3k0TFlseWNiUVVESitLNHpFbkFw?=
 =?utf-8?B?S1liMUpQR1RBamRmejRsVDV6RDBmY1lTdEMvTDVnYmxubVNqeU5TQ1pKaHgv?=
 =?utf-8?B?ZVV5Q3cwLys3eklCbmVxdWVObjR2MWRXVVpCNy8rakJyMXVnQXZldjkrbWNx?=
 =?utf-8?B?TGFkOTJpK2k2ZlJnbDlyRVVmcDZWa21LR05EQ3VmeWVMNWh6cTNDZm9YTm5N?=
 =?utf-8?B?QmtNaURxZjFyaHpBWjQ2Rm9DUXlHYlZKTk1TcUNjUE1FcnlhVFQyTnY4UzR0?=
 =?utf-8?B?R0FSNm9KV3RTRHljVjk2UzI3Rk54MUVtS1ZuS1ZFRGJtTEVrczA2WmJsclM5?=
 =?utf-8?Q?HEJ3DEaKXV9csCMKO/17Zv8ro?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319040d5-ccc1-42db-6c8e-08ddfd1422f0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:48:28.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIS1XH0vyyTq8HfdndeiIiuSFG1FBLNEaIscGil4NQOfwVpOPT8j8TYu+bgzThHx6c9s/O5ATWesNbLR5lemCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11826

Reserve 1MB of DDR memory region due to EdgeLock Enclave's hardware
limitation restricting access to DDR addresses from 0x80000000
to 0xafffffff.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 290a49bea2f7..10aaf02f8ea7 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2025 NXP
  */
 
 /dts-v1/;
@@ -37,6 +37,12 @@ linux,cma {
 			linux,cma-default;
 		};
 
+		ele_reserved: memory@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+
 		m33_reserved: noncacheable-section@a8600000 {
 			reg = <0 0xa8600000 0 0x1000000>;
 			no-map;
@@ -259,6 +265,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&hsm0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;

-- 
2.43.0


