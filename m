Return-Path: <linux-kernel+bounces-751949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4CFB16FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23DC3B43AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5D82BE028;
	Thu, 31 Jul 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsMWcp99"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605222DFBE;
	Thu, 31 Jul 2025 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958821; cv=fail; b=P4+lhc6vjundAJl0l70Pq6w00FetaHV5rlGoNWpL/x8i51/f4Aw5ttVp7k8E8icjLss6iushnuBJ35u0BTfo9l7cY8LxYDls29BYJF4j88lGwV4Q5CIfR1cVQViD+TvsTgX2/5C/2EmI3Q3ppaxLLCleGbareOk3LGY9gBgjoBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958821; c=relaxed/simple;
	bh=JY5oaHiW1Ha31Nj05yTt4req8A8uIB5BPBGSjOL0W+E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BIpt5Xf4+P8bIzM6jH3cKI1Xa7d2MgjS9jZIyusoxxDPLi/Alcz89/nhHkkgePA8V45AlhPaMz1S07oevif073HNNdFCaPLUiFk/3B4QPwpvGILwPqXCS7C8Y87QUZBBOZEN/CWRGWQekSgBp2ci/ahg50KXPexi3DvjcyMIZJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LsMWcp99; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRnP6n+TLcQiNlaFwTv5n/ebzXW/1gWtB62tGrjU63XVP7o8pYPlIrEQqBxBnhnOhrxWmWpb6ncJqUXqdKcvQ5qORtxYC26FetCLJRfPeZYoZxmQTYiu/9OxUJnIFCUmxTzeI+/Kzyx+SPlwqdd0PoF/UIc8lGS5vst3UvzSB9tw127R0m4OVDt6xkH9scyjDkjg3FhQMY0m40J3arANsfi4hZhZLwhbtcvgMwcalc9K5g8eD5py8wYb2JtiVuCun+KGMwXellOx7g3bsTA7FMBPL2rS1AKhg/uVgLXJUNHOnQprjUZhsxI3HYIk+IFszJmQSZ/5SQ5q0Hjin/scCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCogm7gBFBx2x7kmZXMQkYMjH+TjNqiPoT9hC7kD668=;
 b=TQa/xfxl8C6op00nRDlEW27XQhdUdyuVXwpvUlb59ElqEVuYwsR9Ng+e2vX/io7R49ZxMjgszXK0u58tGpCUkF35t6Ii/9rnxtVFcK1yPXOePXwQL3pSOVm2QbqNHQzujFrKhm7ysILuKmTFc0G3mClPOae5CVwxkKcYLgAq6mfXIVncOYxCiHyP5Pc6ytw8Hftpp/38EG59VSoGctfscCPoC+EY9sihBUMREl7NYhrMsHLvWS2JNiV37CDHwCXBCnZyJjpuAEjGAZOHoepY5XQBFDxNW1L2djTvkpORW6TiWS0i6oLMBI1x1fp9q/WOzXrI6eF6UBoOSUM++oEoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCogm7gBFBx2x7kmZXMQkYMjH+TjNqiPoT9hC7kD668=;
 b=LsMWcp99SgKcK8rGNFe86vJ137TBf2TQu+BPirYfop2NymCxeILp25+ZOWAwllTiQ6/nmMaHpFabfARVK1BDhuJJThXeRflmp3AS/PRzPR2aoX6iTAkGoDhoubnAjBw1raavE3gEOJ0aaDuYCOEoG+e1t1bCtufOm3Koo9ZnZPWbzon42YQBCJ2MKzZV7bpSdtQg5hN0hd1dLVp5SjnVJR2Evh4zD92evuA7bf82TYGsWqQOBEdEjzQOQsmU/5oZdLtFEAi0ptYYLdlwCwnQsV2M1cr4RjNyBHjzE9w8Z6avPMFGSJKrh1Dbs4yKwAUDKpT3sEL2pzuzCAK7seHIVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 10:46:56 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 10:46:56 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 31 Jul 2025 18:44:41 +0800
Subject: [PATCH v3 1/2] dt-bindings: regulator: add PF0900 regulator yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-b4-pf09-v2-v3-1-4c2659516582@nxp.com>
References: <20250731-b4-pf09-v2-v3-0-4c2659516582@nxp.com>
In-Reply-To: <20250731-b4-pf09-v2-v3-0-4c2659516582@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ea6674-035e-44c0-79ad-08ddd01f91bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlZRZGEzcFdZMjVCOXNVNlZGRmliR0JpSkNrTG0zbUN2QXNKMkM5TUI3cjRV?=
 =?utf-8?B?MDBRZkVzNzVhdlhiY3Q2MW1Pdy82RjZDTmYxcjJ6WGpHVWRJbmZkdG5qd1pr?=
 =?utf-8?B?TVhrS2JtblBqckplaFdRU29wOUhlOTBPaGkySHpZOEJOd05MZHJXS0lDOXZN?=
 =?utf-8?B?dUdnMXRIVXNka1c4R0xVYWNCQkd5UEtsUisvMDBTMHBmZUxocDBwbGt6UUFF?=
 =?utf-8?B?YklIYmRhTndrUW4rOVlyalNyVEVqeXJmWE13SDltNmFOSGlMbFMzUzBNdGY0?=
 =?utf-8?B?UU55RGdnVTE1a3BLaURYYk1xcnlLa2c3R1VzZ3NQMzFlK3dOVmVKc1Zlbncv?=
 =?utf-8?B?ZGFzVnloSXc1NFlaRTlERnAvYjRsZ3dRUmltN1JpbDhLNC9zcVlkZ0Yvak51?=
 =?utf-8?B?SWVtUlVxa1g0WC8yVUNJMTdJb2JoUzF5emFjaitGVW9SamUwTVRBQzFqVGJn?=
 =?utf-8?B?bER1MjRTRmFjUTNqR2FhRU9qZE9EZ2x3aWEveWJaa0dCa01wbWYrRDRublNX?=
 =?utf-8?B?YU94RUx3V3NjVnhuUXlPSmxJMCt1MWRiUXFVUE5wMHlMemdhZTF3Q3doNHVo?=
 =?utf-8?B?VVNCYjIxQy91T2JTSlE5RzJWUWVYaGIyeUIwdmhTVnk5eG5nTnhEQTdvdi9t?=
 =?utf-8?B?OUh1TGVuV0x2Rlh4VGlZT2pzbFNyQ3JCeXc1VjBKUXpjMVp1WHgwWHJuaXZM?=
 =?utf-8?B?R0ViVGxIa2l5TWJsdlRwRzFSZWpmTXZQamh2ekhGZU83UUZpeGhhWWNyVHVS?=
 =?utf-8?B?UXo1YWpNaUpCSjl2UkJCSHZOWWpDZENpSE9rbHphR3Y0VmNFejRHY2FHZFRq?=
 =?utf-8?B?azZJY1cxRzNRazVZVVFVNmFhTWw5ZDdxcnBsZkJpaENNU2ZvTlJkQWpTZ0hM?=
 =?utf-8?B?UG9WdUVHbUE4TGZERkJldGExQ1NpZHc2UGRFK3dualhaN05UdjdLeE1SeVFX?=
 =?utf-8?B?Z1lCSVBIYVlWaWhRZFY1RXMxUldtZEF1RDhRQjZMbEdCKy9nbk5wOGhJamtK?=
 =?utf-8?B?bEJLZlhHUFAzSVdOeHRITWVFNVNVc3A4My9NRTBCbVpsZFF3SmhPaDVlOUpl?=
 =?utf-8?B?aVVia1daaFkrZ1V6U09oeEZBNlJ1Vzc0dys3Y1kzVVNhYUdjZjVqLzZGOWNJ?=
 =?utf-8?B?YmhOUHRtSTdrQVFLZUxGWmg2bG1xekl2YnEvL2FLdUZpZUJ5N2Izb1JlZitn?=
 =?utf-8?B?dGFocUlFOFlNQ2xIWk8zd0IwblNtSkx6L00yRFJmQngzdm5WTlBONjZwRWFH?=
 =?utf-8?B?N1ZBZGZlY1VwVStWdUpOTnI1VVpPQzRieERxcGtKdHIzMG1pRTlLMExsaEJ1?=
 =?utf-8?B?MkFFM0FkRy9ldEVrZ3JON0JZaEVYTlJmaDBWdmtGb0ROOHRWS3RtNzkrYy83?=
 =?utf-8?B?ZVRLdDRqdXdjMFVmTzRvb3NqeXJpYTJVNEJjSHRFKzd0VVhQUmJIcjk1RnYw?=
 =?utf-8?B?UVhNMGt5Y0FYU01lbkdXS2FzazNZOWlENzZNOFY3WFJXY2JVbkRXUFZmRUkv?=
 =?utf-8?B?N0w0akN5ckgyb1IrSERvT05TTWZCZ21vMWQrcncrSXVKTVVtaFNySzNyWTBF?=
 =?utf-8?B?VlUzOTJwSENRZmlFbHJaL1Fyc3ByN2N0cmo4QXkyQzdzbUtkNnA5aFQ1U0dT?=
 =?utf-8?B?WjR3KzJkUEZoTDliZEUrUFE2M01ZaEZvTTJxVktPZkJ5MFplVXcrUlJRRkRV?=
 =?utf-8?B?akNMdXg2Y2duWGZKQWMzV1FOME53U1owd2xLcVNvTEY2NnpLRWY4bTdDdGdv?=
 =?utf-8?B?NTdKb3BuckZaMFoxQUdoTlhkbzlzdUhaaXBLK09mK01MUko3Y0Z2Vkl0NGdE?=
 =?utf-8?B?NEJjaml4cG5hcUhpR2RBMnRsMXNVaXZkU0tBeXR5ekhDV2QrRE11TW9FdThk?=
 =?utf-8?B?cVhXSDA0WkdoUmlPeG9NTlYyckE2dHdoU0xTMFAwV1RaSnRmand1K1V4eGFX?=
 =?utf-8?Q?WvnJyI83Tzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVdLbitmKzFHY3pFZTdMTS9semFkK0hhMGwxMGRNTXd0Y1lkdlZCb1RvN1JN?=
 =?utf-8?B?RDY2dmxkRU00Um5KSERmZU9UajNvb0NNSFNuQXJaZ01zYzhJbmd1bDExanNF?=
 =?utf-8?B?ZmpYM0ZnOXhvOXpGQmJ3akhuN04zKzFXQ3R5ZmpJaC9Obk1vUjRWbFpkRmpM?=
 =?utf-8?B?cEVjT1FjdGRLWWdCT0Q5QWE1Q2Y4TCtmYjBUZWZNY1VhRG13elY4TUZOYitN?=
 =?utf-8?B?eEdSVHlUTmhYdmRzcEZOK2QzTjdNYTY2VzRRSGpQN2FmYVdoVjdBYzVpSWU0?=
 =?utf-8?B?WHBvVi90ZlZTdkFnZjhCVzFOcjhFUWdNNkZiQnBOSWV4ZEc3alQ4MzVnVTl5?=
 =?utf-8?B?MGx5Q1Z3c1hMZk85b28vN0pHb1ZYdDJEdGIzcFNyMC9kam42MUo5SVRBM0s0?=
 =?utf-8?B?THN1VFRUcTYvbmJ2VTlYWUxRTGw1SjZmcDVZNTBTNUZJQXowMXBxUHJDMGE2?=
 =?utf-8?B?RTlWUjBCS0FkejhpNDA5OS9iL05vMFR4YjhZeCt2cEdUNVFCTTdmemlCVnR6?=
 =?utf-8?B?aTJSYkhUbDBseERaQW1hbEQ4NVJwRVFZby9Qc3NFam9wL3BPLzZ0OGs2ZGZS?=
 =?utf-8?B?Nm5tZWtDUjJQVC9HRFJ4blR5Wkp3U1ZYL1h0QkRLTDF3OXU2eS9memZ6WCsv?=
 =?utf-8?B?bHJ2TGpUL1JtRjAxQVlkVi9xb0NKTEZqK2wrTG04OVVEZWoybmwzS3hpQ1BV?=
 =?utf-8?B?ZytKR3FEMHNwbXBMakhoRnFMb29ZUFFkbmpBc0tTOTBxbUphNTRNQ1hvaE51?=
 =?utf-8?B?RTh6REVObmtEMzJObm9VeTJzcEhJaHErcE8vcUV0a1lESGxKa0NaL0pKa0Zk?=
 =?utf-8?B?ekpEYlNLZDBTZDN5dXgxY2RraHBDOC8xNnFuTE1pV1BxU0N0QWd3TmdGYlJv?=
 =?utf-8?B?ZXlTcDhONEU5UFFQZGtpVFA0ZkJuZDhKajBCR1dzaHFUSmtuMXhHc01hcjV3?=
 =?utf-8?B?WWNNSjFSbmM2Z01FSFpHR1AxRnM1S3JRNUlrRDJWTW5xODRFdjA4ZG84LzRE?=
 =?utf-8?B?L0tTV0pXZHFNOHdnL2ZKd1pLeUd1a253RzFtSjhKcm5mTVVjSERrNkQrRFdD?=
 =?utf-8?B?WDhpTzZPTkd3YU5ZenJUUUFhWjdMWlhNaWw3MVU3amhFWlhHSWsvSHNJQW43?=
 =?utf-8?B?aDBpcThNUExqcE5yYjZJTzZaVHNUYzRVVEZhSkprTFFsd3g4TVVPeXJnT3Vn?=
 =?utf-8?B?Q0xWQ1NwOUV5ZmtnZFNjZFdXZnRjaTVjRWdhcFZJUkRSZ2ViL2dKcFFLWE5s?=
 =?utf-8?B?MWN1azI0Z3JBZnNOaTRXdU03MXlvbHNTa1JuamFQREJvNDVDVVNNUDFodXVX?=
 =?utf-8?B?K0gwMjFraERjNGpoNmFSejM2ZmhETlJkcHB3UFpDOTdHNFdIR3B2Nkl0eGVB?=
 =?utf-8?B?SWJBNXJWQzRhVmduWFBlSlNuczIrRm5yRFZIOE43OHh1NkdtTUR2UDZGLy9C?=
 =?utf-8?B?c01jTzJHREpEYWJGODgwd0V5cWZBc01PR2p0MWMwS3RUK2RJaEtza1F6NC95?=
 =?utf-8?B?dEdpUW5nc3BwdXVnc0NZelpWM0tEdDZFSi9tWUxwRzVHeDgrUVg5T2VTZHRj?=
 =?utf-8?B?VWJ0cWU3WCtUTzUxUzQ5emtJSVJQRHV2MVZEdGZlV2FwbVMxeFY0dzFvYmhJ?=
 =?utf-8?B?RHU4OGVrVEY2dEhnY0xIWGJOUTBLNTRlYWdhZWcwdm1nUG5jNDIyMzBjdElX?=
 =?utf-8?B?SFJyRkxsUnBKU0wxYlAxL2dIOEpaek9IOUUrdUxtTEFrcEp3NUZ1dE5uaDFq?=
 =?utf-8?B?L292MDJxbTBFWXdoWHVPQmRveFNSOEdiSUlsekoxdmFjRHp1Rnh3dUcvcWVE?=
 =?utf-8?B?NDZQNG41SitkQ2crSUtPUFovN3VSZUJjZWtlcGFHdXk3N0Frb240bERuWVlk?=
 =?utf-8?B?aHNkTlBDeXBqUWtDeWZOQW1iSTdxRytuRU44dmRVcWtNT1gwOEJqaUJmL0Y4?=
 =?utf-8?B?RVVLTk5nT3ZtVllNU2lhcml4S0JlSnlBU3JNQzU5bnpSREovUjlGRGdMRnlm?=
 =?utf-8?B?a1FEeDJxa2VsbGFEY2VGNGN1RERQMG5naDAzbGlRcEREVXczaGZ1VVBNeGgr?=
 =?utf-8?B?ZEpFdUQ1aTh0Z3B2MXFNSzBlTVFzOHplczFwRWtLUytHOFJiTFJMcEZwRUJL?=
 =?utf-8?Q?KoIcE05c1mSnLvZFwm/pYN3mD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ea6674-035e-44c0-79ad-08ddd01f91bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 10:46:56.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgDA1Kndn4Rtlo/lm4gEx98dS5yLNRsa6NtMhxAFL8uxhZ9wXf107UEY6YlPQhKq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

Add device binding doc for PF0900 PMIC driver.

Can not get the I2C_CRC_EN config by reading register. If the PMIC
OTP_I2C_CRC_EN is enable, need to add the nxp,i2c-crc-enable property.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v3:
1. change regulator node names into lowercase.
2. add the following description for nxp,i2c-crc-enable.
   The CRC enabled during register read/write. Controlled by customer
   unviewable fuse bits OTP_I2C_CRC_EN. Check chip part number.
   So can not get the I2C_CRC_EN config by reading register.
   If the PMIC OTP_I2C_CRC_EN is enable, need to add this
   property.
3. add more nxp,i2c-crc-enable description for commit message.
4. remove the unnecessary nxp,dvs-run/standby-voltage.
   These changes come from review comments:
   https://lore.kernel.org/imx/e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org/
5. add regulator-state-mem property for example.

Changes for v2:
1. modify the binding file name to match compatible string.
2. add one space for dt_binding_check warning.
3. remove unnecessary quotes from "VAON".
4. remove the unnecessary empty line.
5. move unevaluatedProperties after the $ref.
6. move additionalProperties after regulator type.
7. remove unnecessary regulator description
---
 .../devicetree/bindings/regulator/nxp,pf0900.yaml  | 163 +++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8c8fc2cd4cedb0bef220d73f5cbc9a5f83072608
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pf0900.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF0900 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Joy Zou <joy.zou@nxp.com>
+
+description:
+  The PF0900 is a power management integrated circuit (PMIC) optimized
+  for high performance i.MX9x based applications. It features five high
+  efficiency buck converters, three linear and one vaon regulators. It
+  provides low quiescent current in Standby and low power off Modes.
+
+properties:
+  compatible:
+    enum:
+      - nxp,pf0900
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      vaon:
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+    patternProperties:
+      "^ldo[1-3]$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^sw[1-5]$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+  nxp,i2c-crc-enable:
+    type: boolean
+    description:
+      The CRC enabled during register read/write. Controlled by customer
+      unviewable fuse bits OTP_I2C_CRC_EN. Check chip part number.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@8 {
+            compatible = "nxp,pf0900";
+            reg = <0x08>;
+            interrupt-parent = <&pcal6524>;
+            interrupts = <89 IRQ_TYPE_LEVEL_LOW>;
+            nxp,i2c-crc-enable;
+
+            regulators {
+                vaon {
+                    regulator-name = "VAON";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                sw1 {
+                    regulator-name = "SW1";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-max-microvolt = <650000>;
+                        regulator-suspend-min-microvolt = <650000>;
+                    };
+                };
+
+                sw2 {
+                    regulator-name = "SW2";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                sw3 {
+                    regulator-name = "SW3";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                sw4 {
+                    regulator-name = "SW4";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                sw5 {
+                    regulator-name = "SW5";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                ldo1 {
+                    regulator-name = "LDO1";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo2 {
+                    regulator-name = "LDO2";
+                    regulator-min-microvolt = <650000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo3 {
+                    regulator-name = "LDO3";
+                    regulator-min-microvolt = <650000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+        };
+     };

-- 
2.37.1


