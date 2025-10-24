Return-Path: <linux-kernel+bounces-868266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 796A0C04BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBC2B500C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71522E7F0A;
	Fri, 24 Oct 2025 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iuw50Pbq"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D62E7BC3;
	Fri, 24 Oct 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291156; cv=fail; b=aLjy00DmmI3N56F1IqVR9OBh6cdcW1lOiXMuE4U6VNmpx0DAwVX5XgYhg1YvruTLXRjeyzo6oWU0+HL9Ka7Okma+y/fKOMwnShGQBlBJPENWjCeyPKU4aawaioFkuPVeb86ARKVZWMtaMC5uqkSwPo096BXVb4KI19aVUJ3w7yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291156; c=relaxed/simple;
	bh=t2l/YQCPaAjMtXXpU9P6CtxqUiR2doTj25msDlD+n08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4ciBzgxq4VdTpR/otpjiCZkjXzHPFPwjltRuKpDD5N/vKD7BSsR2aFZo1Rk9qjCyC4+sAJBP+0RTbsk9WDzG8SvWhWEsU4S13jlalHH1oksvXz3tu/nHG8LBB3UMZiPpr1+7oTL0gyJtZ48/hBRJTpkO1Cstl/HZowh9ScYB8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iuw50Pbq; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqMczEKSQd9NCdEtV3lwI4kIB7KLC5VocebWL1cTBkGymehNDBLwUEKeAVnAYjsdBA/tvZVKts2rQaWSxpUxhMKkonsdSynaeTw5UR/+ldktiKKA+i4DUN8QQOdvbeYBTlZxLWBbOGbEDTQSqIuPNYCwRpM976u+8mtFDDrqQrQpG77swwF7Lf8SRQeEHfdAoddZi9tdLICco75eVC1wnbYNW736sGbY+YL12mKxU+Dhaliy4zBXJ2hr0CPgbroYa+nAvhjT+1GFIEez8QAcNNhZ1ROGjjJpFSmnC08qhhXXuOjhhZHUktPv/tue8HTNxZTgHl9hlZrU7qNs6hGFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt6Gc/+wBKEy+7Tv0JFZ08skhfGVZ97w7eHMHqXDfAI=;
 b=BTOsFAtRJvitdfNKa94OtQ9enxxpW8fn3gi4e5xXR+1m3kQanH+WcozKLDcbzVP5Vjs52YY2lB0BdwGGpvNTBJgR+A4uwcTm380ZuduQsHNW5nc8R3Aej5ndAxaIwjLG6ISfhuyLBdT95gn9QO/5nJTMcvAtullCWuBvDJG8AJGNwu5L4rYgjOQktg91F4ovHznwl5jcQWDbHfJ08WZuZ3kAgQSmAjjNRg95SaDi3omtKWuwOPlZrqYR4wEHCYo6GJkpfM+epYoF9w6PWCk9PYYKmrNTIfANrGRD4Gdv2WLSbysg2+YeCzfYk9CaJE49YVpj483jrtp0vk7lu0GCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt6Gc/+wBKEy+7Tv0JFZ08skhfGVZ97w7eHMHqXDfAI=;
 b=Iuw50PbqIl/mLBX7HzsBzdag+5+k54rmwJTw9MPujMS18mKSincCv2rZ7ahVTDUgl3XKGrtnukmGJc2q4+2PIeqcWWURKkv8/0MuLJs+iMJOBOamktw9mfSECgIQNqgMb7xJGtdylnNes0Xv5L98UffyzVVtqAQmItZi9OeUTaEo8kpM7iYajPeVqz/DYLBGocpZuAJzgnbbZT7gcUL9Wi4fedEvAporyd1pTED42vqbqXGAl2cCGgEUEDqALrJ6nffJW+QsULbadaxotLSf6wCAv51RKstv9/usxwRzt97cnhZVVwY2DB4RV66T7zgGE1GapGm3IPSgTyBkeYKSZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 24 Oct
 2025 07:32:31 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:32:31 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 2/7] arm64: dts: imx8mp-evk: Add vpcie3v3aux regulator for PCIe M.2 connector
Date: Fri, 24 Oct 2025 15:31:47 +0800
Message-Id: <20251024073152.902735-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024073152.902735-1-hongxing.zhu@nxp.com>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c6e1d8-7d00-4be8-3a8f-08de12cf7de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEN2Ly9qSnAvWU9WdEJBeFZzTkN6UlRnSWxhWjZ5SUllak9iWDdVbUVBbEpX?=
 =?utf-8?B?bHVBY1l2TVFrOXdnN3pUT3BwdkYzWkJiQmlYT0RnU0gwdStzeldaYmxxRHZk?=
 =?utf-8?B?TE1CeTdlekEzYVRkcTVranV4c2xRd2o3cjZYS1h3alM3TjU2RDlBckdOSWRT?=
 =?utf-8?B?bVhlVUtPQ3lBVWI0VmVLc3dreUNreURCQ2R6OTVDeW5EdGVRelNBdzFaR04w?=
 =?utf-8?B?dmlxM1FBUXl2T3EwTFpPTzI1clBGbXVPNE92U0pDWi93bjBGVVUvTG9DYm1r?=
 =?utf-8?B?UWxxVXYrRUNGTFFWRFg3cWNyeEh1eHFYckEzRnE1c3g4ODVNdzdFdTR4WlE3?=
 =?utf-8?B?RDZBZWhpNW5yc2VvQWpkaVZOM0V0TFY2eWx4UGR0ZDlCc3lxQk1uZHJwbGg3?=
 =?utf-8?B?VDduUi9SR0RHS3F0dFdjTE1iK2ZtWS84VmoxTlFnVjBCZGFjS2FFRjJzRmY2?=
 =?utf-8?B?cXJtdkNwcE9nUXBpZFgrSytRejBqSTZtU29NOU44ZEY3dUkxUlhLR3h2OFFE?=
 =?utf-8?B?cDMyclJiUmRPVjU5OTYyZ2F4S1VFNjErNUo3MlVVWmM3R2hQamo1M3NhcE1Y?=
 =?utf-8?B?MkpNM1YwcEM5RklaZVVpWDZ2QlJIdENOMXZ1c200bnVic3ZBU2F4YVJDYUNR?=
 =?utf-8?B?eEdDdjZlbGlWV0QrZVlhQXJuU2t2TTU3dll4MnJ3UDQ0M0RwSmNvNHd1djMz?=
 =?utf-8?B?clFDbTgvRk9wOXAzVVBOd0NpMUUrQjBPZHlOVTN1eUdwOEJsUnRFQ0JIMTg3?=
 =?utf-8?B?VzZ1UjYzRUw0bFY0bXptYzAwWktRdFRLWXFVSGVVdUVqcDZ4M0pqNzRSZHU1?=
 =?utf-8?B?TXA4cUFnQ0xFWHpGeUU5OFlPZ010YkZLUjF5L3Nva0NtNnZmOVhMMjFMSEVn?=
 =?utf-8?B?YWdlaml2dmlxRDNSelp1SGo0ZmF3eWl4OWJySVBKbGIraTNxdnl6MnpKV0dy?=
 =?utf-8?B?UlE5K096WmJ6WTcvMTNSWUpyNFA3Z24rT2dROGt2anlFNDlLbGhNaUFzeVlu?=
 =?utf-8?B?TnJqVDFKNG1hblJPK29zd2RMWHhPNDlDbGxmMjBHanFQOCtXMHg0c2xvUGsy?=
 =?utf-8?B?K0gzSXF2VUphcUhHa3luQTRsVUxPL0JIeUtGd3ZMZUNpeS8rc2gvbHhWVkhj?=
 =?utf-8?B?Wk5yeDNSSFhpZXZVc09KdEdVR0ZOUUgvRkJ6cWI2VFYwaHQ4VHFKb00yUTIr?=
 =?utf-8?B?ZDFYdDBEOUEvUVgrODF0M2JPUEZSaDhxK25oeXh2L3U0YVZmR0hZbE1CT3Z0?=
 =?utf-8?B?Z1dKMURnbHVyajFYaEcrMURvY3J4dm1XaEJDaDZQMkQvbUtJaWtzMFcwNEpZ?=
 =?utf-8?B?QzFCU2NzdVFMVFZyNXdVNzdSQkordWtZVzgvMVFiUCtIR0pLT1lGaDEzOHFM?=
 =?utf-8?B?aGVyeTBXQlVTVjBlbERvMnk5Y3lyZUFFTlhJTnhUZGxKb3V4VnRNcGFMRy9H?=
 =?utf-8?B?Zjh1cmVmMXNNY2pwWU9td0k2OGJvUjdpT0FybXNPUURJMURVcnBiMDRNemJZ?=
 =?utf-8?B?a2RPbWUrVnEwcktyWnVpOXVCRnRoZVlUK0ZGZ2VaS2s3Q0lMVEdGZlNFU28x?=
 =?utf-8?B?QS9yVTFUUkRFSEk0c1VHZ3dWVjZKOWx0Yi9XVTdMckF0U3dSallVOG96Z1BP?=
 =?utf-8?B?enhyWVpEQkVtdi9xYmNtZ3NNZlQ4MFh1ajJ3eXpiWVE2Y0ViZE9kSHJMckg4?=
 =?utf-8?B?TXA2SzdFTlpoNjRjSDk1SE80eHIzcVJFZVE4U2hCSFgzdjBBRE9rbisrY2ZS?=
 =?utf-8?B?WlBJalVOSkxiZjhsdnVCb3dMUXV2ZStXN1d1bTRRSVNwczIvaThxRW1DWm1U?=
 =?utf-8?B?Y0xRUldsUVFNL3I3eC9lRUZBUFowRlYxVFpwZTUzZXJWNHFTeDJEUGhoa29N?=
 =?utf-8?B?QkRwSVVPMFN4M083LzZrdjE4TGdGK2tuY2M1NkhGYXZXT2ZOUGZreFZJclh4?=
 =?utf-8?B?bVRRWWUyV2tSYnFubCtLNitPRUpkNHJKdE1mZit3UVdRdXZtbm1yTDFuOXpV?=
 =?utf-8?B?V2crQUFOZTZFMDFpRm9yV1MrS2xGNkpCSlNiVVVpRm1jQnJIZVN3WlZHNkJZ?=
 =?utf-8?Q?ai5Nj0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3BDSFVBN0dsU1gyVElzUEwyYzcySVZ6VEZyUmhrS25ibG1TVG4wTWd4c1Za?=
 =?utf-8?B?aHZIQWZCUVpWeUhBVzRFL3pCTWtFYlEvdGNnRGJKQVR6SzhJTVQ3VHptTlBT?=
 =?utf-8?B?LzRzZnVTd3dJMEJ6U0ZlRk1tWUJsSzUvT08yWnhJQU92YVJiZ2h4a1VEUWxy?=
 =?utf-8?B?dlNMYnhXa25ydlVMSEExRTlYbmE5SngzQzhTanU2QTI4VUc5S1hTWHlVc2tx?=
 =?utf-8?B?b1VxQ0pKZEFQQzI0VXpPdmZISURCWU9SWXhnT0czcUpiaGRTZ0R2Si9HaWxk?=
 =?utf-8?B?cXpVbnN2N1VYRlpzNExORjB1a0grcmk5NnVqa1BrOUVad2RmdE5nTDlQRUtS?=
 =?utf-8?B?cjZBalZEeGZadW5TSnpkLytiQXdyemEweFRVc1ljbnlkZHZrdVkxRXJFRWRX?=
 =?utf-8?B?TVFVaU9rYXVpTmZlYktDckYway9CVGR3enV2engzdXQrZXNQNjZZdk1qaTIx?=
 =?utf-8?B?VlBJZXFFajdHbWdUWG9xOFJ3QWhVdVJjc3RzbXAzcHhiMWpPYmdyak9mQ2lT?=
 =?utf-8?B?aEhIby8reHd1c01GZWw3d3hSWm9VUCtXdjIrbUpGaUFaWjFVQ2U5ZkNBV0ZI?=
 =?utf-8?B?eTA1djcrYVlrQnJXbC8wVjNKRkdnNFo4VGsyQkt2NDY4TmlOVUpvSnc1VG52?=
 =?utf-8?B?akh3YXdqVUducmc4SklPVGFyOTc1M0RRUEl4cFNmNDVaRmNsRVlEMnpOOGxX?=
 =?utf-8?B?dzZSVnRKcjVPY2JNam9CR1dBQWxVUnlQNnN3QkpqTmtORUxZQnl2aXp2MVVI?=
 =?utf-8?B?NFZtZjJSNWUxN0ZpOHNqWk1rcEtWQ0NlQzc4RklDVGJyanBZL3M3RGkzdWFU?=
 =?utf-8?B?QVlxcDdPRkY0S1B1SGxPNEFjRlFYSmZZTlg1L2tXYUN3UUNIcVI2SS91Qldu?=
 =?utf-8?B?WlJ5WEFjWFpEVHdPOTZCOTkrUVkzMDlxSGpDc01MOWNtSjZEbmF6WTVEV2wy?=
 =?utf-8?B?WlU3b0lCZDNpN3kzZERBSlBnRUhBU2JPbSt2ZUFRY3JLS3ExMGVuc05xZGZU?=
 =?utf-8?B?d1NDL1prR0RmV09ESFhnbFR5MVlrT0h5TUt5U1lrTjAxay9Id2xqcU5Hd3cr?=
 =?utf-8?B?QWQxL2ZNWnF1R2t3UlJha2llckZvZERJQWJHNGlhV3FjSDkvVituZHZNYkZx?=
 =?utf-8?B?TVh2dUdOYkxnYndDWXlTcXhMVy94d1VGTUowTTFML1YrVWVFc0RDT2owUUUy?=
 =?utf-8?B?dEVyTWREeE9ydzExVCsrRFJzOUl0bEl5UWpUcktmNjRJOGlFQm53bU0xUFNV?=
 =?utf-8?B?dWh4QmpIdzlVU1ViOGQ4OGpmOUJ4UExXYXNWVjhFRzEwSWRIUnoralhnK1lO?=
 =?utf-8?B?dXEwOE11WE45dE16ZmJ1b09lSVJQTldYamhseDVaQUxld2RoM0hYS2l5QU9q?=
 =?utf-8?B?K3JGTUpPSFNxdURUSU51b1ZoalFXdml4Z0h2dHpjZjBLRnh5NDFZRnlKMlYv?=
 =?utf-8?B?dndCRVlNVlp1MTkwek5aTWdYWDBWekp2VDV2ejVUNEJzWEhRaldnR2s5Rm1C?=
 =?utf-8?B?VDNDS0FTbEE4WUczdzUrSVI3c1U5V2J6OFI4U24wdk9kRjZJdG1BTTMvQnFB?=
 =?utf-8?B?bUtNVzBRazdqMm1FaGgzLzFHUndKMzNxTktCS1V3LzlpVGhYaGlnWTJiNko0?=
 =?utf-8?B?MjRxMnQ3M2F4R3BTeFUrNEY0bDlOYmRBRW4yc0FGTjE4V1ZmY1NIaFNtemRI?=
 =?utf-8?B?K0UwL1ZVUXJ2Nlg0eWR0U3l0Y0d2Zm96cTUzRjVwUmhoVWJFOUNIVi9xOHhF?=
 =?utf-8?B?VG1lYXBxc2t4VVh3OTJobmZmYWRxOUI4K2swbFE5V3JhaXQwN3A1Ym96ek1B?=
 =?utf-8?B?SUxIUjlXRXN2NnR5UXQwSnJVQTQ5OUZnWmd4ZFViTFE1b0VLWUtVQmVDTG0v?=
 =?utf-8?B?bzhEZi9HVzNDVzZTVDVFOFRzMDhqa0Q3RlBHemExaEw3VDVOZURocTQ0bEZJ?=
 =?utf-8?B?L1JGbmxsdU4zeWhaWEJMczFmT1p4RWNIV21lSkNOd3JGN1dMT0JWTlFJKzR2?=
 =?utf-8?B?NDRMZ0Z4QTg5QXI0cjc4SlN6c1k1ek1PSXVBUGpUOEhGR2JLQ1QzNnVlOVRC?=
 =?utf-8?B?VHZ1aUFjZTRGa2RlT28wWTMrcmNodE9zY1lNRXpick5vakp3WjFDQXFySmxT?=
 =?utf-8?Q?jQFjtLP6xBTxxsorFSRSyjEQF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c6e1d8-7d00-4be8-3a8f-08de12cf7de4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:32:31.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8lH92fXozRrhp7M8iztGZ/OELhJgvhCjwcdfHoAm7eAK2dzVl1UoltjKfU133+RE5fvzN4hxRA8OwHk4TTHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
Grounds.

PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
source, 3.3 V, is expected to be available during the system’s
stand-by/suspend state to support wake event processing on the
communications card.

Add vpcie3v3aux regulator to let this 3.3 V power source always on for
PCIe M.2 Key E connector on i.MX8MP EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3730792daf501..3942b1fe75d00 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -710,6 +710,7 @@ &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 	status = "okay";
 };
 
-- 
2.37.1


