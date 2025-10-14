Return-Path: <linux-kernel+bounces-853273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048ECBDB15F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDA3E8D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751C12D2490;
	Tue, 14 Oct 2025 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kxs5r/ND"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586072D3209;
	Tue, 14 Oct 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470738; cv=fail; b=aBWyYv9/DRa983cWNO4qzUkF8fJnLulHVbllo2fw7kBFYq8BoMN+jdJd9avT4GRUHVj/j95D8N5X5Ks7FofGiJF0gZP4I9oy8rm4ZaEHRhHTfAM/tZ/rfQD7u4j144yXeYPPhud/ZgDY4sFtC3tuBPMj4lkRPfbpXTh+oFXBrzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470738; c=relaxed/simple;
	bh=8aTZKe3qv3MLpXNuCM/OKkmFSdtUNhaBB/L4oe/NwIg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aN8hHawkQLn8/mpHVbOqWP4TC6vVmNwegRT5PB1FDyvTNTs0IZHXXANUVs6dEWMPFpPrAW5/HxDd/QNN7VYVLi0gtHQrnBd1TqybTZIend+D6VBEZZMferi1XLBFt/BVLGacpPH9OAys3zzTbaGA3ri8j/rK6zSzVqAbVScIsIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kxs5r/ND; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kF2LkPq9VpG2TjkH7C3UAHxF32peR+CyLL5QqEyYuP284zQO+xSRp4J0gAZzRohBmen7+3fl/dZQngvYE/Gr2nVxXJNinHQBA0sLpQuk78CSpuuKDvvxuuAgvZQqMtXj0A86pV/x2um0mGDwVxwdzIIhEPyaT5mxgj3VzXOsxIV54jV9V9u26t9+cG2FYXrQcBMwtX/nA9WI0sOxEHGS8sec4l931vll18e6AQq0gxSYWTKwDJyPi19aXCwEqgSj9MiMDoBVsPkuFJiCmear93gu9IMiEznTWTFq/FA8RtZNh/lTOlMp+DBouNUZ1EEzZiI6z9OsI6NcoOIX4yqlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuJeZoRupbJ8PI+SNj3VmzUCCEFhLDT924JDikRMsGQ=;
 b=d9KkyIZKeIzG/PpnpFP64YF6DpD7V9NmVXeeRW08Oswr2lQXt6uckfApS+RWQ91sHOjaiMRLwkamxtci5zhi2bQow7Ik4XXmN1b1PvYfK3/SHF4yxJ+hLD3m/Unpbtw4mEwJg2yZUExxGF1yojedh/UlCQVTaxBDGIdwjhjetimXlEuaopbVpjWJIaPDALOeHML1BYx0TcMxAIKiGE/2ujOn4pN0TvrvKydimrpXApdrPfrenzVzDh/WMlNYjZtEZKz0ZQroEKNRVKO9yNgVqG44FgzTvXH6E1XKwPRJa9jambaMrO3Al13lpC026No0XwZhtFjQHxgLbfuwVCcbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuJeZoRupbJ8PI+SNj3VmzUCCEFhLDT924JDikRMsGQ=;
 b=Kxs5r/NDaU1IkFkH8FZycOHFILcKnVIkDeSL0J7rLelVyZ42cks8OiZAHboYqRJsGnL/PXb9zcsBBehd17+LFAnlrUyy/wm2F39gcui4PaEm9YGQ+V9ygNaHuwplbJY9cUbOkyGVtz3clwMIWqClFF5xwcl4KA+ZU0e9zJK28eLpLwG/oIAw2d2aMN6/OWA+jXfVZzdaeNbEYauJXxf38Eqq1P5Uv+g9HJQwUJd88BQ1i8EH5AdW56EaPchyqsZTNtpB2RnoukyR376PJHhSJ1WpckIXbQGEndlqIDnX4phi9LSaM33KBVtFY4A7etBScqhd3lukVN/Juy257fxSZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:38:53 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:38:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 15:38:20 -0400
Subject: [PATCH 3/8] ARM: dts: imx6qdl-skov-cpu fix typo interrupt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx6_dts_clean_2-v1-3-508b36e5a3fd@nxp.com>
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
In-Reply-To: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=1122;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8aTZKe3qv3MLpXNuCM/OKkmFSdtUNhaBB/L4oe/NwIg=;
 b=PbOWpXTqTRmOVXegQXsplsoReMK11UtFS9COYz4+5lbAldSgeQHwt/PZFKOBnlOxclQu7CCEp
 eALzACluibtBQNDTu2Zbi2PyL1voczlylyqojN0Ec9urX4fWE10smue
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: f464981d-dcef-4b5f-9072-08de0b594e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MCtYSHRSOWxyYnZQQkxpV3NoSVlvd3ZnakJCSXBHM282WEdoT2lTenhOQ3Bp?=
 =?utf-8?B?ZkxoaUtSWW5RNklMMFp6UEk0azhRQk4weGZBY3ExdjF6WTV0Uk9iTE9oRkw1?=
 =?utf-8?B?NEdMZzd5RnFXekNOd0VhdXhJMCtHazZ5OHN2WlNsbmxPL0pjM0tpRFBHdzNE?=
 =?utf-8?B?YXNSMkFtU0hobjZ0eXhMb05zRmFKallJRGZJOENCbFFaQWhiTCtOWDA5VEpj?=
 =?utf-8?B?Z3lGTjZZT0hQWngxU3lldGpJSTVSQ1dKM3lBbFRBZXF3b2JYclVvN2hkd0sw?=
 =?utf-8?B?dENJd0NSenNrWU1zU3FUVldLV00xdlgzRkFoOERpNHMyY1ZxbU1qRzdqMXh2?=
 =?utf-8?B?U1JlYlQrV3RqQTZNdHhwUWNJL2dubWVFVVhtUXdNSWtMSWxaeXd4aFlsMVV5?=
 =?utf-8?B?dE1BQmd0cFhmTkM4a2RrODVLb3NNS3JkQWFzZUZkbTN2WG5meFlWcTN4NmEr?=
 =?utf-8?B?Q3Faa0JobG1OMU9VSnY4dW1IVG9NZHpBTGdwd2lRbVBsdytCTGFSVU5FZlF4?=
 =?utf-8?B?VE8wWE5OMG11cmFENklsQmxMVFduclZibVNnWnlFTGE5OEFVaE03QlM4Q3ZJ?=
 =?utf-8?B?Znk5Y2p2SVFqanJ6NDVhQlJzNlRRZE0wM280QllYZXVQY1VDekJwbUJadXlH?=
 =?utf-8?B?Y1ZKVDUwYkdXYlVGR0ZRUnF2V0Y5NGVGSmVpbW5jWFdyMFYyZWFFeUo5NXE4?=
 =?utf-8?B?VXRZb2FNcWIzamRmTjZSeEh3YlFsMkNya044L29XRkJxdHhzcTR5RDFuWWtI?=
 =?utf-8?B?RmdpZ2Z3RjRRMGl3M2gwOVhpTDB3Y05GWWlBR2Vzd2ZXV1lOVVAyTDhaN2pM?=
 =?utf-8?B?MXk3Qm0xYzlWYVkzZlNGYlZmeGhhV2d5L0hMSVM3NEhMMHU0VHhkcUdHOTJa?=
 =?utf-8?B?TmVvejhrOHZ5Wk14SERpaFRMT3ZVUnBncW1yZ2poNTZJSmlmZkMvdnZwUkxL?=
 =?utf-8?B?eGFLQkE1Y2g1TWhsUEZxSDl5RDc2WWFFSm9iM0UrcEtkNXhiK1dtUG01UUhv?=
 =?utf-8?B?NHllN0V4UDVIZHpUdEJEZmVSNlJmcHhPL0oyMy9RMmtWZGlnS2hCa3Uxdk4w?=
 =?utf-8?B?NEpIRFlmcmtXSGtURDBpejM2WndHV3lTa0RPN3ZDWExkVUo3b284U3dWeXZl?=
 =?utf-8?B?Y09Tb2c5b05jY3dGTUFGRDdHMDBkOGJ2YTFKbFBWRVI3Y2NJc0UwQnhqbHZZ?=
 =?utf-8?B?VVhSWWgzSFlrSUZUTGpza2pzaFFtUmFaUkQ1enNhZ1JzVjRFalJuU3lteGVv?=
 =?utf-8?B?allOZXF1eU1iQ2NudEtSaVEvNWZHdGZlL2F6TkVDU1lia2ExajIwaktsU3RK?=
 =?utf-8?B?ek5HRUhSRkRaNGxKMEl4NFZpbXc5WGorQm5VWVN0YTM4MG5xd2t3cEJyYUJL?=
 =?utf-8?B?cHY5RWRKY21QT2prbU5VWmpJb29mZk0ycmh5cEV1Y1JGZ25HT1JkTksrNE5Y?=
 =?utf-8?B?WTU4NkdDZm52Y3RsYnJrVzQxTW0vTHhSRlVzNEJQamFEVXFDUldycHRGdGpw?=
 =?utf-8?B?N3JwYTRTWUtrTTNhOGZZUkpHV2IySTkzMzN5bW5wTHhsOVM1Q2dVVTlsaC9W?=
 =?utf-8?B?Y2N2ZWNvakgxZ0hwcVJGUlJ2cUltOUg1dnFIemJmbnoybXN2Rm1kMmZodGsy?=
 =?utf-8?B?T05sV0RJU3RubEVOMEx1bzZSeENSaWpOSWlFSzNUVG1YOG5wVUFtTk96T2l4?=
 =?utf-8?B?UFlJR21jUENtZzd5V2JTMEVtVkQvWlNuU1piY3ZtSEE1d3ZQbHlHTnpxRUJu?=
 =?utf-8?B?QUNoUE5IQWt1cXlrdlpZMDBOaDI1QkNhNmljcmQzTnBpWlN0NjV6VjZTMUJU?=
 =?utf-8?B?cWxqV1NLSUFzazBiWkRGSlpWWW9kKzVlcWVxMjllSUZWOEZMSTVjQ0VkR3Yz?=
 =?utf-8?B?VTRNcnllNCtPaGdFMmd0eDh5VWhxeHUwOFNTTE1wQ2ljOUZvTWN5SUlRKzlj?=
 =?utf-8?B?cmhnaGNTRm1qbWhlQkZISGFIcDFxaS9aU05CZUpNT1VEUFE2MUhNeGlma1ha?=
 =?utf-8?B?Z0hSNzZEUXlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZyU29JVHBRbkhHRWxkS01pN29rY1A3OU1GY1cwa0d0VVdDSjZZRUN6V0J1?=
 =?utf-8?B?Q21wK0d3YnIzRzNjbjJodFd4ZkJXQ3lnY1VnaEZRZTN4enR3cEpxMTJnbSth?=
 =?utf-8?B?L0JVbzZjd1BRVFdpeTZ1SFhENmpnSG5udGl6cXJEYVZVTit2YnpEMFJLbHpI?=
 =?utf-8?B?dEhJc0gybTRpZFg2Mlh2QWJ0T2J0RjFDZGNNNzR5cUpFUHIzeVVrSWpSckxF?=
 =?utf-8?B?ZEtmb0UzRjBMeHBzRktNNm50dUUvRVBvUUZBZklIYjRGekpxSHhjcG5BNGpO?=
 =?utf-8?B?cVVqQncxTnZrNXVwQUVpMkF0bFphRk4yUXROTnlHZUMvcGdub2pRZWNlZEgr?=
 =?utf-8?B?T0dmWEJSeGhxTkdWeGxSTjR4dDJocERRYmNvTnptMHVjVVBzWGNybENLakdY?=
 =?utf-8?B?NnJRcE9kdjNKVlpLRDVxbTduWm5NSFdmMWRPUHBDbFVncEhsNGk5K2pXcU9H?=
 =?utf-8?B?UTZqR0N6NXZlOHUrUjFMWnZVUEUzSkRDYnNZbWNTSlNseXlHYTRyRDhieEJx?=
 =?utf-8?B?VFU1Unppa0VQOGtEWWkwNnlkNHBsL3l3WkVaUE5WaHU0YjI2RjVaOGlQSnlr?=
 =?utf-8?B?SjR2azcwNllWdGdDbVpXUHg2U0pmb3FaN3MvNi9RV1hod2Y2aHYwaTB0QXN3?=
 =?utf-8?B?YldyQnA1WHEvdVNNNEw3Q3ptZGNmUHpYQmJhL1lTdnM5SzI2K2h4UzI5bTFv?=
 =?utf-8?B?VWFZV2VqcDkvL3hKa3BYNHQxbkhKQjVxRWNESlhmNU9wNHY2ekZlMitZeTN5?=
 =?utf-8?B?ZFJZano0S0NpR254Y3FScFdRN3l0UlJQa2ZQZnV6MDJRRXJqYzJwWC9kMCtt?=
 =?utf-8?B?dkEzQzJDR0RsZXliU1AyY2ZaL0tzV3ZRcXMrVFNyMVJKSkJYUGJwY1d0QzR6?=
 =?utf-8?B?OGdYWkExTjU0aFpEd1ZrdWM2SkN1bFhhMG5yeEl2NXo3TE5pc0tCSmgyR0Vs?=
 =?utf-8?B?UVk0dmdCT1ROM0N6TzdHbGtkSjZvWm5HUXUxS2dqd25mMmJqRXlZRzQrTGNi?=
 =?utf-8?B?T1VOS2VlbWQ2RlRuUzNBNG9lbzcvd3dzL1hhQ0JwamFoQXFZancxQmIwSTBR?=
 =?utf-8?B?aXJEODNQck01b29pUWxRYUswYmhLMTlSblJ4WUtxK3ZiZ2pvSi82V1p0eXh4?=
 =?utf-8?B?M3g5cTJrZXZrSE5aSWx4YkZPcnFtOVZtSmRoRVpNeUlUNzI1cWRjY1htWVow?=
 =?utf-8?B?ZWdNaEtOVGc0V25tdU1pdlMxOTRzWVZ2dUVRcjhoSmVLNHBjNm1SYlRsVGdR?=
 =?utf-8?B?WGFDVDJPRzBzdUZuQXRoQ3N0NGNqYURSRkluZ0V6b01oNHVvL3g4MkJyV1Ur?=
 =?utf-8?B?UUs4cUxUdGxkNGtwUmswbWt6OHJ6a3RpZ0xhM3dnY0xQZklRZ3FrK3dGOXdw?=
 =?utf-8?B?c09kcHdWbncwRUsyYnpKTHRKS0l5L2RTR0JmUGtoOFpKUjdyN2IvNkpYZzNr?=
 =?utf-8?B?SFlZWFFoaHJkLzdIYlFzNUtFbFV3K0xRM2dSWmFHVksrekNJMUNDYW53UTJW?=
 =?utf-8?B?eEJUMXVYaENINVgxdUt6QkZaUFVJemxDZWFBK29tTnJCMUFDMnZjNGdHbEN3?=
 =?utf-8?B?cXhieGlTOTVzYUc0Yjg3eTljSHY5NXJOUWYvUVlQSHRVSHdwUTRwS0c5OGVr?=
 =?utf-8?B?MHJaQ2hmWlo5bjZYNnU4VzFjb28rMTNXR0F3UlRZUitiUjllZUV4WGExNEJs?=
 =?utf-8?B?QjBxeHM4Q1JaS1RIYW9Hd1JRYVY5NEs3cC9EcUIyR3hmOXZhT0x6TUl0enhR?=
 =?utf-8?B?alJpSG1mVzBsaEhESkM3MklsbCtPd2UyUWs5RXp1WVVFSm9WSjYveXg4aHh1?=
 =?utf-8?B?a1RSSmpQMzUwdW9FZ2dCV2dzOXNMZ25TMDJ0Q2JucTFSeDVXSkc4Mk9rL2dp?=
 =?utf-8?B?Z2pLU2hxRFVMSWloajRSbk1KOEdxVU9SK1F0ZXowd3QzdEIwd3VQc3l5WHo4?=
 =?utf-8?B?UVhvUENpV3d1ek01MnZZUzdwbWRvTUtOSXl5QnBQOWpOMHdqdVRwOFRaRTQ0?=
 =?utf-8?B?NnFseHljWERJd2ovT0lPWUU3dHpWMW9qMERkZEpTajV1aGtaWGNUS3RBeDZq?=
 =?utf-8?B?Zzc0eFRzRlE2UmdIbmVuTG5hdFE5R0NwYnlvUHFpSWRZZnBSaEtmNWY0RVk0?=
 =?utf-8?Q?5DptL8bSEt89isCa+uuV5rey/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f464981d-dcef-4b5f-9072-08de0b594e9a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:38:53.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeDhr9cTr5IFA+q9JQNeT6LJzQ1UbTaqLJsk9HCzz/6dGqMT0FayFh09VHntOYs04IJIpBdkAUoG8p+VyjBfpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

Fix typo interrupt, which should be 'interrupts'. Fix below CHECK_DTBS
warnings.

arch/arm/boot/dts/nxp/imx/imx6dl-skov-revc-lt2.dtb: switch@0 (microchip,ksz8873): Unevaluated properties are not allowed ('interrupt', 'pinctrl-names' were unexpected)
        from schema $id: http://devicetree.org/schemas/net/dsa/microchip,ksz.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
index 6ab71a729fd85d0b0b6dbfbd810692b1a0e05ec6..c93dbc595ef6eceda5fdf7b90dac57bfed59e489 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
@@ -69,7 +69,7 @@ switch: switch@0 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_switch>;
 			interrupt-parent = <&gpio3>;
-			interrupt = <30 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <30 IRQ_TYPE_LEVEL_HIGH>;
 			reset-gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 			reg = <0>;
 

-- 
2.34.1


