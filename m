Return-Path: <linux-kernel+bounces-854912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85074BDFBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 856C750723A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2185E33CE9C;
	Wed, 15 Oct 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RNxcWQmW"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11333EB09;
	Wed, 15 Oct 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546721; cv=fail; b=tvvoafupPp3VkGEsmnaT+muqZ59kwycMhMy4DMz7b+nK4r4xk4K8krGG3oIAgMvQ5b2FBLdaEiurmMuxyuqin8s828URLukpo8R3FKNBBIuTdfYQbRAisclQXqx+m38E37Ly6u4bxRcL1xAoTdirRzZ6gs3GW0p92ZxRKtN0yk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546721; c=relaxed/simple;
	bh=ZI5N2gtHlj4iGB7i24YmmkrzQSzg5zyBSQWLZ+uuJ8Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XDzyRoVai2V4lE+ZuS8FxLPyIts2i1Csy22Flfl/7J2Pt/n6VLKRCR0kn94VkgDl6DnMDJUcogJsVXe9yQHCQwS+Au2V9FqsCdk8S4Yk9tddnRWWACc8q7EtvWOf0UGLfRC3RWH9npeZNU6UtyX8ZeXxHb6nOswyfmURs7qQEJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RNxcWQmW; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvjV2/qzI13IbCIZnzjLr4Tz/QS/Tvawa8VgKsRO1fgT+xcObvc3djLSFuh3I5AIpchA/trN6IahhGHTVMCZn/uLZ1vvgvhFnClkAUKf1cLpecsM8J7gMHRevBrEWCmAK8ixG9XJ4m+SCvgnKahdDmGcBgkj2brjzx1t3V9SiabS4v2abjCqIHVjYNl8A4WZK826eseN/sNay4EMX5ke6PbXB/kmjUFOP9wkJrAGwPC6wzx/FzAh1KMVSgph+QfN63lZQEEYmzGkaBniQAsqUAuuJ4fZl94hOkKnMEWA84YgKLlWM971wEkIrmVMwTLC5VKDZiUWvz2wgooA2AZhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVjZKXtYEMXPpwKMkHyPAc97VaahRk7nq2h6Rro7gH8=;
 b=TIGV2xCxAKZKu8aT7AeUquxgSSaLNve3Rp5jbSNUTFk2QioDJ9NNUrEyYkGeehcZV+1+CEboEsps1WFobjzRK3LSfJwwNKEstPe3eVvHIasVWlQwQHtUqy3ZUxtJPWHG5Myr4wImJ46WKGYpAORkJfMemsWaUSUkHfL7RCJyd8ouqenFj1xOowrqbWN4ROxsl0oGwNPb4TCvNOVe2PweQqhGAm9VECtExdbKFNhqLzrLc6oxk8B2DSggZZqZhYJFN8pgbSSd6Vysme9RRZBgfiWscxA3vrFO15G05dM92L6+GUJg8wZiJLQ3mad6CGwXyBk8SvGdS6I+Se2o1yLLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVjZKXtYEMXPpwKMkHyPAc97VaahRk7nq2h6Rro7gH8=;
 b=RNxcWQmWaYKp+2lLuS8G3zixOUhahsskDuLD59gyUk44j3BnK8Z5GW34m3TOXJJRQeFvNeO/bFM0bh+hyPxRSQYAAV6He2agbUQv+uSeTK1B6P0EDk9qNZntAwVGAAzvLDIZ4EAIy0vKLlOiBxM18tTgWGfDk3PlC4J495D7fMbRg5iwpCbUqAFrZQFIQslcZkMFzjUdVVhlS+hb/nBDmwATwM0hfhJg1A1gpM/IcKUVfzHRI3tSnFwBP4uOUW/p6BAqbXQZ+fFZDEfkMj6TEFSQFqFtLfEToW1g+wnIdXdrs+8qVn6GQWASGsmZkCZG9+1R9vFT4OIYKeA4RdLu5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:45:12 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:45:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:33 -0400
Subject: [PATCH v2 08/11] ARM: dts: imx6-tbs2910: rename ir_recv to
 ir-receiver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-8-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=954;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZI5N2gtHlj4iGB7i24YmmkrzQSzg5zyBSQWLZ+uuJ8Y=;
 b=2mqtct+sLwy0q6SiDGryt0kuMw/PPXkORTuKPkSYzIclH/WxViUKCUg0NwwYObSWEyQZaQ4rZ
 aBEvXCe/NjrBw1iPkKDihD03LYlST0URX26w+96qvkcTRuA+CL8+96s
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 716acdcf-a19e-4024-122a-08de0c0a3559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWNyemdVRW1wdi8rN0l4aTE0WHJkdmw4eTRwZUpkUGNiOVdpSFBvV2V1TUpL?=
 =?utf-8?B?dGc1UzBDYmZMSGtoT0YvWk5BRTlvalVMOGROSHpBd0VnMGszWU1rRUtsSTFx?=
 =?utf-8?B?aWhZMDhzeVdsTU1zbVhVQmY3SkNCVTFZVUY2Vy9nYm1idXlycmVJUllERUZ4?=
 =?utf-8?B?RlpVNE9XWDlIaGtScmtXcmdOWmtpUHVST2FmaEFCYldXZm1uZzlQWkRHS3Ew?=
 =?utf-8?B?TEwrYWp2bE1BZGhYNnZIZGUvcU5RS0oySG8zQ2cxZThsc3ZRcCs4V28wc3Jk?=
 =?utf-8?B?SVJJdHMvQ2w3eWZoMm9HT01UUmIwTmgvdHQ1SjYybzNKckVKamgxcnpGWkJo?=
 =?utf-8?B?R2I2SmgwMEpGdFlYd3Rhc1JucVVmbVpXS3ZzS2o1eHhVQ080SXJyRUtiRjJt?=
 =?utf-8?B?VS9vR1d1Si8yWVIwd3dpT0xJcDgwYkdxSWkvSEZnUW5xZFlpVFVrTXdxNWpi?=
 =?utf-8?B?RjJzcVIxVjB4NlN6WnpDSG44d2NEMWlrc0VFbisyUEo1NFc0UGlBTDBXSnYr?=
 =?utf-8?B?WDY4SktOaFJyNUdTcU5qOC9wZlhTaTB1M21BVXcybkNuYXluVC9zWnd0blk0?=
 =?utf-8?B?UGhqRHlhVWtUcTB4L0h1eFEzNUhJTGVrY3FZVVJ3UzVablFHZ0dTeU13OXNr?=
 =?utf-8?B?U3o4YXdabm9VdWhybUUyMXZac0liZ2xZZWVObHhzY3lXTDEzSmpyZlY3MGVJ?=
 =?utf-8?B?UUhpSFNzYlFmbTczakx2ZVRMNUIyVmwzSlhlMVRXR2l0V3dmamRPQ2dCazF5?=
 =?utf-8?B?VzRKVnhkVXF0OUJiV3FadDR2ZThlY28wUEJLT1l0aVI2RTZGNllFdFdCQ2hI?=
 =?utf-8?B?djJpaVprWEV2Sm40MWdvZTc0a0FRT0x5cHJZaTdEeTNLMS9JY2srT3pKQnB5?=
 =?utf-8?B?QzBDSVo1dW1KZjFLazFHTi9jMHV0NDlzUnZQT1RuT3kvTS9lVWxSUUowZEli?=
 =?utf-8?B?ZkdqOWhxSVdIQTN6NmFOcWQvbHpSczJlOXJPbXJ5ekZucEFPQUtxNDZtUWJW?=
 =?utf-8?B?ZXhzUlVOdGRxMkFsMm90MmQ4a2VRYjdTd1J5UWNpL09UQ2N1MjBBVERXd3l1?=
 =?utf-8?B?c0FVV2dvRU9QMGN1OHV4YjRhajFFT0tjNmFZV29qeUx2YTRIVXlNbGdYMEoz?=
 =?utf-8?B?djZTWXE4M0k0bG9vM3NtOWp5N09kNFN4aUE5UVVLWFBRcTR3MVNIUW90WG5J?=
 =?utf-8?B?OHlkRjF3WmxYL0J6RE43NUVPVndNRFJ4WUVMWGRaUmZNQnh6Y1lRVzhMMi9S?=
 =?utf-8?B?a3EzZU9aZmlRc0dabVRNTkkwcGwxQTIrMkdPZTNRNFBEOHpQc0xnQktZNzZP?=
 =?utf-8?B?eDA0Z3Z4T0RRMmFieENTVnlzR0lxaEN2QVluQ1ZEYTZNcVVsY1p0cndZN0hU?=
 =?utf-8?B?UU5OTVZicERFV3JtN2ROR2paRHVqRU1tWmVnbkZmcyt2YlUzcDMzK0Z6bEo4?=
 =?utf-8?B?TkdWS1NIMEd6VG00ZnFseFloVkkwd0NhdkZtUDdiZE52QTd1OE9RR2dMMkhX?=
 =?utf-8?B?b3haYlZFdDZDZ25ocEdEV2prYUFKT2VEdEhDampMWjI0SXQxMHR1YmNCMkFK?=
 =?utf-8?B?UzI3TVZYMFc2dzZ1dEpRaGFaY00xNHBBT2ZTL1dQUG9TVEY2dU4zYzBBL2Y1?=
 =?utf-8?B?eU9FekNERE5ZWDNCQTFRWDFxdkd2SVBqbDFBejF2YWZyNGJxaDNISVNndWMr?=
 =?utf-8?B?dzBZQmVRR2w5WFR1RmppMTVCQVFjbnp5Z2F1cVp2QjhhSTNNUFdjbVpMTHI0?=
 =?utf-8?B?QnpuK29XQURwTjZMUjdJOW4reE9KNklidWJBMGgyVVd0UDJkMHBpN1lyVlp3?=
 =?utf-8?B?b09rdEtPWnVpNHdVWC9kYTExYThpT0ZDSDBMV1VTbjltSU9vS1NZKzNuMkZm?=
 =?utf-8?B?TlVYS3ZzSjhRdENsTVBNQTU5ZXRhR2lsc3N1V0gwVTJKN0dMc1FlQXNlc3NX?=
 =?utf-8?B?dVQ2N2puTkFRZStOTTFaUHFjR1gyeEZnaWlvUkpLTHRrdHJKUHV4U1BCSDlM?=
 =?utf-8?B?alZvdm9EMFpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1RwRlhRWFJaYmdtSEMvMWd6eWlwdVFNOVlKWStMY2hBYUNDUkhjaTFianJG?=
 =?utf-8?B?UkxsNDR4S2s4SzdLUmNhQ0VCSDExTlNtWXBmc2tzNlJlR3hOdytLVjIyWUJk?=
 =?utf-8?B?OFFGZUFkRlFORmp2bmpWbXdPSjB2a1ZlMGFFU1psejVkOUlHN3Y5TzZvMzZP?=
 =?utf-8?B?djgrbmdzZDBoTTJ4TGRNa1RjV1lYYnh6WUw2T2FDdlAxK1l6a1Y4NjE4RXFs?=
 =?utf-8?B?VGtKR2thdmtycFBZc2RoTSs1YndRdUJWZ0lxQWt0RVJsdGdxTnF2ZGJaRzVu?=
 =?utf-8?B?L1lzVW9YWlNScGNaaFVlc1NlaDBYOHJRbE9RdzlNeFpJOFBBY0tMRTlCTVdL?=
 =?utf-8?B?V3BtM0liMHJmVGY0U2FvV0EvZkIvbEF0SUtub3JCTy9pOGJCWGgyUDFlTmUy?=
 =?utf-8?B?MjVDTUxBVWZmeW9TUm5nV2F1bzY4cVRuU05NNm42b29YS2E4Ym5aMG8rVjU3?=
 =?utf-8?B?N2RKN3pWaEt6UnhFeFJtQ05MQk1JcVlYY3l2VzZ0Q2FycXpWY2pJRzhhNVo5?=
 =?utf-8?B?NUxWSCt0MThNSGpiMkVyVWRhQ1JZRThBZEFBZENXV25nTmJjSi9ZRXVhZlhQ?=
 =?utf-8?B?SzM3RkZGa1BMN3pQSmJWWnozVzliek51em5Dbk1DWDJRd3dLZzBrVEhpMjZr?=
 =?utf-8?B?T1VkMTBicUdzcVFtdnhUK0FSMTU4WTd3NzBHUU9wVDFlTFByS0VydW8wMnlx?=
 =?utf-8?B?UVFGdUxkK2t5UDlaWlBDMXY0c2poR3ovemdzVGdCb3NGSzF1TXoyYnRIbllo?=
 =?utf-8?B?U3F0NGFVdGx4VEpCekRQZGgzVUIzZUtTRysydXh3UWJwMzVranlxR09wa2pO?=
 =?utf-8?B?NVNKeW45N3AwR0RVb1IyWTFZUnd4L2RublVUeFdsaW1JQUlsL2pyN3cvWUd4?=
 =?utf-8?B?YmRraWM0SkI3SGVIQUd5ejEyT3llTVRHSTNYRC9QQ3ZoWHdabkNNU0tEMmZ6?=
 =?utf-8?B?Tlhsd0kyMnNCaEZYZHB1cTdXV2JDVWpNVG85TXlLSys2YjQrUDdtVE11cGpP?=
 =?utf-8?B?OXBqSUZha0ZiSnRmZWNyRm5mNkNicDhCaGRTSkFJSTVyTHJ1WEFWTXRUMEFR?=
 =?utf-8?B?eStqcTgzSEU5N2lqNlR4eVo3TVhOMXFLRDF5T0Z2Ny9kSDdIQmZmMllmQVAr?=
 =?utf-8?B?ekY3QUZ2S2R1L3hGWml6d1gvMjdyVnNUV0t6NnpZQWpOOTR3U2RwQnVUVmJS?=
 =?utf-8?B?ekVYMzE5cjYxRzQxcyt6K2hZQlpFaTdmZDhIUWFmenc5Ris3NjJWYlo1OWM3?=
 =?utf-8?B?dUIyckZJNHdnOXRVdEZTZ2RaaUtyYVg4NnZva1RLbXZBMEg0aTRVMm9wbWlw?=
 =?utf-8?B?MWVUcEhvbDhjbkRtc3NkRTEraFhTb2Y2WDcyWm5FY1h2U3gxZ3NGcE95T3NZ?=
 =?utf-8?B?NzNpb1JxZThuQ1Q4Z2FUU1kwZUg1cGdKQzRoaWY2Q3N1MmtlMFZpQ3ZDcEVm?=
 =?utf-8?B?UjNNVjh4bWxsVm5xSXA4TU9GU2NnSWVjQkxHOEc0MVZ3MGFVN1IzazdCN2Zu?=
 =?utf-8?B?UUQwd243NFVUekExbEFiQ3VuQUgyUVdWMy9ZV3cvRFNoUkVLY0t5d1hwK3lC?=
 =?utf-8?B?QmVEVzVEK0FGRDM5N0dnUThwS3ZZZXQybVB3WllqVVJpRnhWOWdxTjRwZ3pw?=
 =?utf-8?B?dVpMMEx6dEJzVFl3S1YyVWtEbm1OcnBHRXFFV09STFZobG1SQ3BSMGJSa3Nj?=
 =?utf-8?B?TjA0L3JQRS9BVUhhWXJGcm5QdnZHUmV4WXpWZnZZVWlZQm1NSXRTNVNaSTVp?=
 =?utf-8?B?MGhkUVVsMmdDWVkrL3pJU3dHTityVDV2SXZJdDZKOU5PcmlKVDBUdUdvMHFm?=
 =?utf-8?B?Z0NmMW9TQm54SVNVckZGMGZWV0ZXOXhIUFhyaEYrdm9pbW93M0dKRzFDOWZ3?=
 =?utf-8?B?elpvdi9Qb3lxVFRCWXMrak1DQ1h3OW1yc0ZWK3R5U3NQUU81dXU0bEVvY0FB?=
 =?utf-8?B?eTdkSEtHTDMvU3FKYnNMc3FIcEwxVG93Nk5wN0xGbElKcXdHbmduNEZkbnR4?=
 =?utf-8?B?aXBCb2VPMDY4eUovcmM3U1dyalExeFM0VFRTMmZtSzVkekVxU3g4eXkvNW5s?=
 =?utf-8?B?ZzNBOStmREpkWEVZUmw3UE9JbXVlMmk0eDM2R203N0l2TW9sL1pNTDhScGQ3?=
 =?utf-8?Q?e48o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716acdcf-a19e-4024-122a-08de0c0a3559
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:45:12.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnV26dJ6Vgy9KWvbGVs8fLOW2Pu3Kzmdp8nKE96l2lIIPYw6/ADWhlTuNEVSfDsPqogqbdLPUjfU7O3ViH6cPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Rename ir_recv to ir-receiver to fix below CHECK_DTBS warnings:
arm/boot/dts/nxp/imx/imx6q-tbs2910.dtb: ir_recv (gpio-ir-receiver): $nodename:0: 'ir_recv' does not match '^ir(-receiver)?(@[a-f0-9]+)?$'
        from schema $id: http://devicetree.org/schemas/media/gpio-ir-receiver.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
index 5353a0c24420504470b8b095eb7506e7713319c2..3bd0e2c9e57acaa8e491d01ba029c60531181aff 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
@@ -37,7 +37,7 @@ fan {
 				      3000 1>;
 	};
 
-	ir_recv {
+	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio3 18 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";

-- 
2.34.1


