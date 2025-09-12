Return-Path: <linux-kernel+bounces-813134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD86B54107
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD5F1B27834
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAE242D9E;
	Fri, 12 Sep 2025 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YACpRn3e"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896823AB8B;
	Fri, 12 Sep 2025 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648173; cv=fail; b=TC69/oJyyPUIKgcn4dWMbBzjU3e1xzwTriZKSBTJZTjWKqHwoR3U2wAF/YEvwdHzjMqWQK4+VTC3CP/EsRsAOuqEDMW/nj2WnCFQQ4VYL6Hk2gHjxIm+ahvFccOuRtIniFtmeWvCZHIycyT1hSFBXduK/llO3ypkJMrEUZNNlSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648173; c=relaxed/simple;
	bh=wMbTftlAEe7Gma3VZtrW9YNadN9te92bEc4Yk+OP+hU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VNvdu3Vd0C4UyhlJ7sRkLNzRb2N2LSnxTLOe9rFJwyi7FYrJERt4BrpliOFNMa/QB5BtMq+R4jzFTXVS5/EUn1RH3uFzazBeAIb0iTT8W3eLByso3VToBhbL1Q/1+O0MtM5v5ntFvraUnLllQF/PS0shnhcY3Mt8Ro5YrkFGBQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YACpRn3e; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCACBzTMHToxTzG+Y1JRi/8oCsuIz3pfBs01ZOB3x0VLNDfy4xHWkWaCkeEdy58AboUBg+Nk3blsUhMBHbNJ+1YSyj6D/0UrnsH+tDVs6+5iYGKFYXB67B1E/rKRoRjj74ppYe2wO9NkpnBJ4QqLOShfQFnsmwFoy6UMiARzOweeNPQKOrns1g0zvAzm1M5KI+mZpYT8eWgRSI97bz5XKvIcvcRzc710WJKir7KhbjC2qQh/GkvwHeSa3KZSB+iJ7CYnqNefzif7dtzzbNdK65NCmLZTrgcMXU9Hi6ooOJIzssJelAX1YwqiNYqAQOLQ9mdlM7G1Xu1OO+R3egDkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS2XaewpYjaK9e4CwZocVYB/heKGrxA49E11IICyxUg=;
 b=tNk33Z1ZDarUE4ntObL0OQg/+Ebw06nyiUCKMw1DAU+0dPfW3EUm8btk2tkzrODziazkXrpmU05wDaIcU5Z/ds/wpbD/bZGtqkc0mqdnKGB1wiLtaclo+ZsBLGjKLFPg1VxYp+4mblt46gXs0GzHfln8Z4SdeZSopEe7i0cQLJmm2QIx+/VWQNe2Pd286g7BYl+WFqw+mNyZKKCi+ZZL4jjcOOwl4hbsMf20Kx/oELYg7YUKBguH9L9HWhRdWggmYWzwbFIBBNB+Gg1Kwp0h6VG/cDNNxiCVWMy6/wAijiQnAfo0rtbuw9vutuGqRIK3l+mtRKJ99X7/+8iWNAgrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS2XaewpYjaK9e4CwZocVYB/heKGrxA49E11IICyxUg=;
 b=YACpRn3efBhxJ3cV5WFTZAaUzZBMtq4OkPYYtzNFzwDSSv2ilYvMPVNlQYTrPHMZWR62HofiSnsu8DRtz5HQqaoxSqs7uMFoyVvMhKrvgtjKRVQ7KU5UOlieOPQL72iYwbVHj19UjFP4ksKGxug13y5bP3+ShAFo5IgivqFbdp2YIqNjk8wzOpsdcBj9llZp9PfsSzrFFMx7XgMt91aeAk6iz40nQrij6yCbXWbhkh85qoUF0QCke9otHZjPmINfsul4h07qwl5ML9o72PH2x8n0se8I+Ndl/zsArxFBNhi3k5aB+jKOSXCSKqtJ3g/3CvmS8joVxFaciD0fBsB6ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 03:36:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 03:36:10 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 12 Sep 2025 11:35:50 +0800
Subject: [PATCH v3 1/5] dt-bindings: clock: Add spread spectrum definition
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-clk-ssc-version1-v3-1-fd1e07476ba1@nxp.com>
References: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
In-Reply-To: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648158; l=939;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=wMbTftlAEe7Gma3VZtrW9YNadN9te92bEc4Yk+OP+hU=;
 b=HKWrz0l9NBd9Tx0sheWFZA4elUQKijmCzE5xEkeS6QfLzruYOtxVyVYlmh5FgSEHTfD+/oyy5
 UEtApGJk1PoDoNJC8B3WG2BUCMKm6GokqKDzSwCBH/NN3QOn7IfiiZv
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 5781aaac-067d-4e7e-b096-08ddf1ad83bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG1uOUdXeStJOE8vdE4rMW4rOWdGL1Z1ZDJrYkhBMWpFMzZWV3NESEQ2bFZT?=
 =?utf-8?B?T3NaaVZ0Um5DOWFSWThmdmgrbm1vQWJMT3Mzc1VOL1dGMUVGSkUrb05HMEIx?=
 =?utf-8?B?dVFPRGMvUmR0Y0ZWa21OUHoxYys3NTBxcnNsT2tNTGZoSlBwS3NiU3lONGhK?=
 =?utf-8?B?Ly9COG5EQ0JZdjZwZVlNWjF2NE05RnBuL1VWY1VuMmFmQWpqeXhJVEMyNHJp?=
 =?utf-8?B?VXFjRzNhaVRRTXlOMk9pcS8wV1l5S3RKR3MxRVVpZVZEZGphMUJUSjczbnMx?=
 =?utf-8?B?RGdEa3hWM0E1SVNNeStyRzB5azB2UmcwbnY2WWdHakRjV2JHZFN6RHRmQ3dJ?=
 =?utf-8?B?QmVDQW9QVmZXN3ZtbGV2WmxnSWxtUG0wM245eVRqbGJ2aUhJQXdHamFVMmEv?=
 =?utf-8?B?cWlsa01OLzY1eFZtUGhVcERxMDJGbkZGRExSbzRmaDN6eHVUNG82RjJEMHU0?=
 =?utf-8?B?cVR1UE9sUk9BWjV5UmduV3JQM0VXaWxWbW5vdkpFcHdFU2tGWTJwSVJsRDJ1?=
 =?utf-8?B?dmhUc1FnajMxSjZ0bm5kWHorUHdwUDJNbUVzQVZsMnd0QU83OUc2dkIrT3Fp?=
 =?utf-8?B?QUkrOHdwY05xWWpob2dYbHQxLzM0TFNOemtPM1ppNmNrcHZwc3UyaDZWbHN1?=
 =?utf-8?B?d1hmNldodWt2cS9EMHFxU2s3UTBFN2swRGVKaURvSUxSN3A4V3QySVA1eXR6?=
 =?utf-8?B?RTMyN04yRGEwQ29yT1cxdmx2d2RTQ0swdEhMRzFKRnVYdGpEdWhSeHFEbEZh?=
 =?utf-8?B?Y1NNZ21CRGRwVVZGL2lJSit3NW10K0ZxV3BSQzlwRWF6bXpSaGR0cGt0RFE2?=
 =?utf-8?B?Tmt5WmZWZmFaS05QRmpyL1c2TDZrc3IzeHRUT0o0eHhKMkMxNXloVDVvTkJE?=
 =?utf-8?B?Wnp3QlN2VUdtampqZ1JTSUkxaEJjdVUyYWtrbjdRYXliVlB3RVhpczZQTFBi?=
 =?utf-8?B?MlR3T1NFLzMwQ1cxTTl0MDdCaWRWNUIyOTFWeG15eElTSkJXUk81aG5rYVI3?=
 =?utf-8?B?cHd6VHZteXVTNGlNdlJSWlJxRkwyZHdZekpiTXBINjBNVHBCaXNjQ3EvZTFM?=
 =?utf-8?B?R25kMGhNMU9FbWZmMHNKVlNjd1hvaXQwUkFwWENGUnhURmhjMXl3d3hTTkNB?=
 =?utf-8?B?YTlKdHpGOWdUSEVxSElIKzBSbDZiZzIrdFM1dnVHRnlxZGFsYml1NVpmdlJH?=
 =?utf-8?B?a1RyOUU4Q2FzanBPNXpJYmVibWxSTHQxdk1LOEg5NU5YeFljSkR0TnF4KzFU?=
 =?utf-8?B?ZVNqN2Y2Y0VPZzRaRVRJMVR4ekhVNTZLTnV1VC9uK3RDclo0VnB0dVl6Zlkr?=
 =?utf-8?B?MGNZblphZm5pbDc3cWEvM2h1RjZvUEJXblNhMHhKZTBsRi9vdU43emUwQ2Ft?=
 =?utf-8?B?N0o1dkREdFkyTEdWdjJWM0Fab29uSU1INVhYbDJYUGNxRzVLKzI5dm1pS29J?=
 =?utf-8?B?ODVpam9MdWVwSlp4YlduSTJveWpkTW5nU0pQaGdHenBXR2Npb0V5bU1yYllK?=
 =?utf-8?B?dHVoTjhvdUpta3dFMnVkVkxaUzI2ZHFYbUNpWVp0b0t5ZmJZTTBSdmFKaStC?=
 =?utf-8?B?Mmc2blpBYnNKYkZHb1JBU1V5SDNNTWd1Sys0WHhGQnBoSGhESk9FMWMxdE1U?=
 =?utf-8?B?ekd5MXdaM2lLNDM4cExUMlI3Nm1YMnhUZFhNWWtKdnBST2hoYWFKeE1UbFgv?=
 =?utf-8?B?VTRZUXVZcXFzTHFHb3F5eFFQOFFLTldCc0RkZ1JNcHRBQlZETFJDZGJ1K1c4?=
 =?utf-8?B?dDQreUxyQzhzVFB1UC96dUpDVmZHMnpKeFZadm5TVlErQTdwdjd5cFJqc2NR?=
 =?utf-8?B?U1ZoNlNSa0xFUGg5a2h3MXBXT0lqZzJBWXpLTDI1cXhaYVE1Q3NXc005d1F0?=
 =?utf-8?B?R0tNeWxxaURVWXZQbkc0czRiTElGSVkrR1lsc3Vab3hYQUcwbVc5NE9uQU85?=
 =?utf-8?B?RThobkpjWWd2YzA5QTdZWjhuSDZLSXdLVG5zbWNOTEFObWxUUE01R0k0Z2p5?=
 =?utf-8?B?Z09qZUorT1l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXBPNXJJbFNpZmxyb0JUMFduS1lWWnRMcUZ4ZjFiTnFDbTRONHBsOWhvN214?=
 =?utf-8?B?QU1ta3QzVGpvRDJUY3A2SUFvT0t1ZXkxMEd5Q3AvQlFmbGY4M0ZxazhOck1q?=
 =?utf-8?B?bndvSUpxVHRhYnZNaGNua3dQWmFkNzY1eDZTQ2RQOFBKOThneWZ2WVNDNks2?=
 =?utf-8?B?b0podU8vM2xISjg1K0N3T0h4N3JXVWdtbUorQkUvM082UGV3WXZoOXV6TTd2?=
 =?utf-8?B?MUo4KzNQaXAxQ2lOemsxMmdheElET1A0Y3JueGhSVzExeVhjcWsweXNMYk5T?=
 =?utf-8?B?dzlYN3p2V3QycnZMMkJrQndjaXd0dWhsTXRNNERnazZvNjRydklQNE1JQ0lJ?=
 =?utf-8?B?ZXZ3UjhSZ0lHWFlLL2tRcERSWWIwRDVUZU5yNHpncVFUQ0R4alNsWVN6VHpR?=
 =?utf-8?B?cVJxUm9pbHVFNGtBS1hFYjFLTnVyaVBWUlJwZ3ZHMWdmUXdHd2tVeitjRXVs?=
 =?utf-8?B?d0VMdVdNM2xiOVB0NHpQaTR6SERJLzUzaUlsb2cvL05yK2czQVV4dDVsbnZZ?=
 =?utf-8?B?MEpobEpwbHBTYjg0YWJGWFNHbzJOTzA5K1FHTHVrVmRWMFo1ODdTbjc4bTRH?=
 =?utf-8?B?dTd0S0FCMjhSTGxFUUNJZkVtbERXMjVLY2lsZDloQzQreUwrUFo3UElBVU9G?=
 =?utf-8?B?TmgzSUVsVWtsdFBVcGxJTGdYL2g2bVRGTnFVNkJGcFh0b3BHREt6YXEzSFJM?=
 =?utf-8?B?NnFWMXhQWXk3YUtncmhudU9vUndqQ3NhRFprc1RYMkVqcWd3ZTFmWkxVdGth?=
 =?utf-8?B?V3pCRDVPQTNNY3FoUjFNZXJGYS82VVVjVjRZUkFUajJKY0hOK1RQNnplcm5E?=
 =?utf-8?B?b3NiSUR1b1U0dXl0MTI4VEdndXhudnR6UjFtVjVsdGNobDJRZUFkempDRk5Q?=
 =?utf-8?B?ZzFGZjBEMTdOUTB3VTUvMkQrL1BRdFZpSmxUVW96MEsvc2loeG5XbzRzL1hC?=
 =?utf-8?B?S0I3elgyRzVXd01Tb01DdmhvQXBvL2ZGcU5FQWZSYTBoV05JZ1RnQWhXNmJO?=
 =?utf-8?B?cVN3emwzaVViUHJYQ2xHdXZaMmRISWtTSnBEZ0txZ1B3U0Rmd1dtWXFCdFZT?=
 =?utf-8?B?TFMvUEZFUTZreG9XTG5CRHA0bXhoWVRhTGdwQTVCYlJjTm9QdzZhdWgzaG5H?=
 =?utf-8?B?M0hEOGJiNjNneGNaN1d6MmtqQWFUbVByaFc2Um1oVGc2My95OHNMZDFyZmhK?=
 =?utf-8?B?dFVoUDViVUl6ZFpmTTE2dU5QNHJkTXRhMGwxZll1bHgydU95d3pKaFFDQVRv?=
 =?utf-8?B?djVkWmhIeUV0Vlo0SGdOME5zWGlDSmFldXJOd2NOQk1zemozRzRRYjFBenRk?=
 =?utf-8?B?MFFLN2RNQ2ZiMDBiMmtHQ2dqVHV5aEJ4V0J1djJ3dGduTnlDUTB2R1U2OUNR?=
 =?utf-8?B?QjRRRGFPSU5VTXlrTUhncTFraXVlQk9PbEtqWEVHL2hPaEFlcEc2SFF5enRs?=
 =?utf-8?B?ckJaU0lsWTh6Ui8yZVFRQ2l3YnZJMVZHNXhCYlFHNTZ0eUVsUUovVU4rWTU4?=
 =?utf-8?B?a29wUEw1b3dSVGJqSGR3bDRtQWtpZFZQbGw4cHBubHI4N2libytSa0hUZm9n?=
 =?utf-8?B?Z1Q0a1VMZUlkYzJZU3p6dmxwSTBsME5VcVIyNXRTcEFpcVMwcnFGNm83c2lO?=
 =?utf-8?B?L0xKTFp6L1dNdUNrRXFRQzNlKzhheGdtZWJ5ZkRLSSszb1NhZTVTaEtYMlNm?=
 =?utf-8?B?UjRJc0dDd2hVYWpQbGZUaGk1eCtrMkxXU0FrTE1ZQnVMb0pwaFR3dU45UjBu?=
 =?utf-8?B?dS9UM2ZQN2tVdkdUaXB2ODNuYzFnM3ppSGRaR24xZVcxcGxvNzl5MUVjQ1JY?=
 =?utf-8?B?ZXNOSnZrVEZROElpSnVGLzhJdURkVXNHaTM3TnJMTklSc3FYNkVncmFVWmFy?=
 =?utf-8?B?ZmVXYzFSaURxTUxZZEZEMUxSMVlpY3kwSTRBb1FNK0p3amNBVXk3dEVFaW04?=
 =?utf-8?B?a2tPV0wyZWVOWS9ZaWNsL3llM0tkam9Cb0thbVdiakMrY3pEUDVTaXdHaEN6?=
 =?utf-8?B?cnpUbVpJUkZxb24xcmx5MU1JbVNkQVNEazNaL2dHQ3hSaWNxU0p6TnMzOTla?=
 =?utf-8?B?N3VDZDZXYWNrZitRQldpaXdZNXRpOHVvaFF4UFV1VDZFeFJVaENqY05QWjk3?=
 =?utf-8?Q?kwJi9U+SPFGrG4LzLt3UKekPD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5781aaac-067d-4e7e-b096-08ddf1ad83bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:36:09.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0FwiMfH28OxMj/FMhl3kXfcodmeVnpA+doE5v0FQF2g5ZD3ctNF96TwLFKcuBTHO3l8QnlybFdg9HnGiKkpvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788

Per dt-schema, the modulation methods are: down-spread(3), up-spread(2),
center-spread(1), no-spread(0). So define them in dt-bindings to avoid
write the magic number in device tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/clock.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/dt-bindings/clock/clock.h b/include/dt-bindings/clock/clock.h
new file mode 100644
index 0000000000000000000000000000000000000000..155e2653a120bf10747bd7f4d47f25e0493e0464
--- /dev/null
+++ b/include/dt-bindings/clock/clock.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_H
+#define __DT_BINDINGS_CLOCK_H
+
+#define CLK_SSC_NO_SPREAD	0
+#define CLK_SSC_CENTER_SPREAD	1
+#define CLK_SSC_UP_SPREAD	2
+#define CLK_SSC_DOWN_SPREAD	3
+
+#endif	/* __DT_BINDINGS_CLOCK_H */

-- 
2.37.1


