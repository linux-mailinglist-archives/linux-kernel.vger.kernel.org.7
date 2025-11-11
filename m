Return-Path: <linux-kernel+bounces-895801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8FCC4EF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C3C18C0C30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A136B07F;
	Tue, 11 Nov 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/8gk+MU"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903036998E;
	Tue, 11 Nov 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877482; cv=fail; b=AkhhtlbAeVPgH6IoewGDf09v61MSWtUluRsOAUPqaLN20jg+JqgdrN/ed15I66D5nJ7gpu7tnBhgZZUkufElg79ZtL+cbm9UwHH6PpvTvJ2a5mMrhJ5Dnz+yMIOg6Dw1SdBrBw+S/WlxP4jBuDI3wJ7zaXSwjHAqF1uF/+hGRRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877482; c=relaxed/simple;
	bh=juYpoNyjscdRBkI1Uh0JvtgyLAxMEIyfXq5o+i1qi4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EljSdbhbnQqUBk8xW3EXm/6PuwLYqeqFvGkQKaW5J/pRK3H6CN18RqYAgUW3/5eAb2VnIDvwuJz0Yv/3zeUY9/d8VARDhFOoS+9UBkOWHna2Bu0RpG//+j+bMQrvuTPKjPgvd4goJ3skg2LVMIxg6uBAWxZaeRVd3y4Eh9XFdBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K/8gk+MU; arc=fail smtp.client-ip=52.101.83.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmbFAx3KghxzOXGSh9yqpIul2eBy3KssM+CloQsyVIen53PcKW0bscToSOHjJMPrv9T0z6y803q1GEzb0xIhHLHrRMi67JD/UQnFFZ/JZz8y5oJVIbKmVUqEhlv8fQ4dN4VMrPmWRXe/Rm0Nvwg3GV45nXv3LguaPPzJQduuubH8m+MYMZi/WPEsMD0obXIoDjSLGj/3RhlilS6vkDPT5oHhpNLzPl/h5a7Wq6M7T4rx3DrRcY2sMJTD4EnyU1aY4VBA9sXoDLXWzIl7ejzd/rAWtS+jKLJDk4he7KU6fCxhk3mMDblmDkclU3p+cvQh5/uv6UZRQzmdG1yxRsYnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JeptvRrbC7Q0cylzJ15eGK2xNtMmM5rPxfs258sf4I=;
 b=xX7oG+kZRzVcBv7QnLx/ojJIypUTyk9VyAZmEcCuV/wd7XpejX3Op7N/Dgc2hOj2XumFsPcmZ2Y6DKgQLUemT35XQUp0Ikyk9lpDVIZt/ZjXIcqCJcJ0hu6thZagHSUrFiTd0hK46PnmbsRFmjcAwhmVZxBS/Vw5v3i4e2gTX87vc6Fe9GlCBi/nxyKG3hQJ9ih7KjQiFzlokiH+ipKvurdkwhj9VLznnDgjEuJCC3dHNMB6DQtHBu1W9lkuG3SPJ01ae64GizB6+23kkWL9i1cL+TXoBld8vY8YYfbYg7UE7z1IH/2S0LnQmAO+LFNNTY0L1V6iF97hKSk3nd5quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JeptvRrbC7Q0cylzJ15eGK2xNtMmM5rPxfs258sf4I=;
 b=K/8gk+MU6DXbvvx3czzMTIicaVpoeF94/cW9U6VuXudM+ihcP2msUHcXKeRrA3R98vguVnu4GHUA4nSP5SB5OzUY+lLtqjqYR6v95Mo8wqwdHc569dz83511lmr0ci4MxjcT8N5RqxfNpr1+ovRbSznx7GXXbTkXa1YnPxRu2KWO7V048JJ15Y7ySZI/A9el7+A+Bz4dS8ZbvnYLCBwW2ToI1dcIGVQcU/dMbgCGw+GyJqjy8tKhxbmaMgkxXsXabVvT3/L3l/uLYypw3ATLgGnPsctInGXfUkEuSQddee1+dFAIV0ME0ss7FXAIgC6qlu39MD90IiAOvSImNvt9jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB11934.eurprd04.prod.outlook.com (2603:10a6:150:2f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:11:15 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 16:11:15 +0000
Date: Tue, 11 Nov 2025 11:11:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Shawn Guo <shawnguo2@yeah.net>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux
 regulator for PCIe M.2 connector
Message-ID: <aRNgGhZEmp9TLi9m@lizhi-Precision-Tower-5810>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
 <20251024073152.902735-2-hongxing.zhu@nxp.com>
 <aRLnoXX54oG6erhW@dragon>
 <AS8PR04MB88332E188669CAA95CC89AEC8CCFA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB88332E188669CAA95CC89AEC8CCFA@AS8PR04MB8833.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB11934:EE_
X-MS-Office365-Filtering-Correlation-Id: 15271ad1-b823-4077-027a-08de213cf078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODJPWE41WFdwYXVmR3c3Z1FKcFdSMnhyWWgrK3RyT0NBSFEvUUtWRFBZZ0tu?=
 =?utf-8?B?aU5BM3RFVFIyVTNyQzFZZ1VhVmVpejMzWStWN245MXJvSkwzbklkcWxYcWpT?=
 =?utf-8?B?cEpsNStaalp5d3Zlak1EUW9WZjJSQ0hKcHdtNHdGSi9jaWQwOCtzdUg1eENq?=
 =?utf-8?B?THpUaFNRVWlQZGx2a1pZQW9YRC92bEVkNVQ5bHlKZGN3aEpIaDRFeGFrblFq?=
 =?utf-8?B?Q280cEtDZ05RZmYydE83YVVPT3VvQXpkelhTSEtmY3R5dHZhK3ovcHFhd1Bp?=
 =?utf-8?B?dHdvZ2NrSExHTUhOODNBQkpBK1U5azZRd0Y1aGxNdDEreDdEa2Y4aXM2SHJ4?=
 =?utf-8?B?d3MwYTl6bC8vbS9xNHNzR3hsOUNSUjMzNXJLcFJqM0oyQ1Iwdlg4MnduR1FR?=
 =?utf-8?B?RGRpSUtNZ2M2SytPR1ZBM0ZScE5SSWZSNWJlQzJUc28yOExuSWg2QzlPcnVs?=
 =?utf-8?B?VmlLS2Y1ZmRhZ0pNRWc5WlRNajBtM3NoSmx1WXNER3psN29sWFpmamhVajJR?=
 =?utf-8?B?WlJMN3pyeFN5UkFYV3NybEVHVzdlVmIxZnR6RTVONXYvcjR6SHNxdFJ3LzE2?=
 =?utf-8?B?elN2U0NEWmVaVzI0Tm9ZTUdvN1dlYzlZK3VjeUFObWdicGE4dlNQalQ4ZFJt?=
 =?utf-8?B?ZjhhaXJOUmtneXpMTjMySzFkOWh1ODRCM2Q4MlZLdXRVMjZPeFo3N0ZSdXhW?=
 =?utf-8?B?cTJRUzZ0Zk5xeGg0bDZPbmlmbnJkWlVsd3JnVTJLNlgvUldsMldvejZXYmJK?=
 =?utf-8?B?NkFmSXdBcndQUWJDdGMxZzN1SjVPbTY3OGdUWk5rdUYvUXVKWDRZREIzbTFm?=
 =?utf-8?B?OTBkUnhyQ0hHaGU5Z2tjVzJuSnRqTTkzbFU2ZVRCZHVpVk5zMjB6aEZFa1po?=
 =?utf-8?B?Z2xidGUxcWk4aEo0ZUpaNXRBdDVDZmJpUW5OREZwbkN6eUFmSmNaRXVZVHJK?=
 =?utf-8?B?Y0J0TWNYcENkcDIxdWFuQnlCMjc4N3pSSzBjbjY5T1pseTFsMjQzVGVQblJT?=
 =?utf-8?B?blJDK2Q3ZkcxdDNuSEV3NGNqaHNUaE05KzJseXVtTUhGZndIYmZUNzhUWTZ0?=
 =?utf-8?B?QWJkSHhkMVp0ZXFWL2UrK0JaV0JqVXNzaTIyUHhCYTJEd1RXMmphS0ZTVENr?=
 =?utf-8?B?MENhek16SGhQK3ZMZzNzaytvLzVrUnlyd1FWd1lBZ3paeVNkL3hRWjlaVkpI?=
 =?utf-8?B?cTBWWmxqdFhlQ2l6eUZXZmg2blRGS21TbDNnRnFtOGJISnhSQ2VkcXcxU2Jt?=
 =?utf-8?B?OFdGbTJNMkI2d05FYUdSY3M2S0hheVNsdkFISlUyZTJsRFlwcGZSa1NkV0J0?=
 =?utf-8?B?Mit0b0dRVi9tV0U0QzdIN0k2K04velVWTGR5eC9MemF2SW9TaEFJN0oyenpv?=
 =?utf-8?B?cys4R0UwbkhrZXhwTzRVM3N6YUJVWjFPdUU1aVBXaFV2aTlhMGEwdzZ3d3pE?=
 =?utf-8?B?UDF0QnE3UU5NczdHdUx5dlVNTU1qR25aWk9FSS9HSlVQamJDZnlIWXBUZW8v?=
 =?utf-8?B?MXdjMDNOd1RoWCtTME90SVhwMmV1ZzRoTkdXcmxIZ05NYWxqSkxyRlhQZ3JX?=
 =?utf-8?B?S1JTRkE5WitLV21HVGNWdXBrOUY5Y2ExZjNSUXk3YVFRRnR5Z3JqcjRrTGti?=
 =?utf-8?B?TVBTeFh6Y3hQdTNBLzZaUVVReERLcitZbCswTloySmJzdmg5UjRSN2twWEg1?=
 =?utf-8?B?cGJxR05MMXBBZjZOdXpSUFR2dUNWT3pjSTVhWlRrRXk2NUhzcElEbFc0ZVdr?=
 =?utf-8?B?YkUrT05GclIyT2tvdUt1YzdBQmNsOTY1RklwVlJDWURvbGN2eDBNa1c5Y1h5?=
 =?utf-8?B?b0tEbzFJMStGcGpmRHJLT25UWGxmT2orZXRSQ25hUnVZVXluekdoQkVFR0xr?=
 =?utf-8?B?MnY1eFkzdU04aFB0YndraUVmTC9PL0JmQlBEc2hSTHluMTNoNmE1cm55S2pq?=
 =?utf-8?B?NWlMOFlCTFZkbUZzd0FXL0YyZGcvYndiMGVodnlpZ0dDS2ZYeHZJNEpHMTJm?=
 =?utf-8?B?dEMwdFBkYXQ3RTQra2VtYVVCYzRPSXZMUng1Wmk5QjBvL0tadEtDcENnMVVB?=
 =?utf-8?Q?jZH4pM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEJQRkZmWjJlQUtZWENVTVg5NWcwcDJ5Z0QzZEJkRHF6N1FZejhuejBvQk5P?=
 =?utf-8?B?M0JnR1U5Ym00WjIvd3dqYmUrallvTmJSRjlDcTVIRDc2SGlUZmlWR3dnZVhG?=
 =?utf-8?B?UUF1NzI4U1ZDZEpwSEZSMjNFKzFEZ3dMQW8wZ0NIVXZ1YXI3c3UwaDM1RkQr?=
 =?utf-8?B?NVZOZmYxaGpqZncvTHhXUnRpQTNJWVZic01KNmRTd01aRmdxWFBFWDRjMXpU?=
 =?utf-8?B?RXo3TDR3MkgvaXBjWGxSMlJ3QVpuWlZHazlQNml4MkJNQ1l2bkdtSTBZNjdv?=
 =?utf-8?B?bEVsUDM0dEpENEh1SmVJem8weXpNNkVRZjRERU9TRktibGx3aFhIdWlQUGNZ?=
 =?utf-8?B?VHA4S2dWRVY2OEhabjdlaDFWSGtvUTZJU3F5bCswWVM4YWx5ckpYWThYWEpI?=
 =?utf-8?B?Q0tjSU9xYjJheDhhY2RNdTZaUVVVN2FhbkFuSjZNZXB1SWhpczJ2L01tTDUv?=
 =?utf-8?B?eG9LODZZZU96NTlPemZwSGxERlFWaXpKMkl4WmdNb1diR3RsV09pdFh6dWM3?=
 =?utf-8?B?MlJxL0tlM1pEUzcva3RxN3RscHM4REtkZHpVdkFONDBDM0o0Rk1WMUExQ0Vl?=
 =?utf-8?B?YlRzcTZySUhFbWE1MGVEK3NFV3hsemcwN3kvUFcxSml6Wnh6ZGtlWWZ1cm85?=
 =?utf-8?B?MGJHMlV4RmNrZXRkL0xQVENpQnNQSXowVXFwTWk5blV1VDVoYktDZWpXSURj?=
 =?utf-8?B?M29rd0ZHVHdKL1M3TjlHYi9iR1JUS0ZDQkMyaHB5dlJvdkYrcUVYOXNXc1Rz?=
 =?utf-8?B?RUxsRyszVkV2OTFLWlppZWxMZ2lTeGlJMjQ0Njk0czR3SGhpQlRnYm1LeUFa?=
 =?utf-8?B?aHgyeU52NEVhWVR0VWNBTTcrMUxuMDJ3a21oOXFEbFl2QnBoQ2NiaXpkcVFP?=
 =?utf-8?B?RVd2VWxiM3JDS1R2ZXdBRklmMDRQVmYyb2l5MmZqcm1NRDdmTTF0WVp5bmg1?=
 =?utf-8?B?MU9qT3RyUnB1UTRlS1R0M2VERHR3dmF4NXV1Y2htUU0xcEdHd0t2Tyt4STZU?=
 =?utf-8?B?Z0JFVmZGQUtRb29aNzlnb2QwL0VrUFloK1prTmVmT1k1K3FyeWc2VDY4MVFH?=
 =?utf-8?B?dDc3THF0RlYwSEFSMUhvK1VxenExNjlRNmRDYWdzUWczQlAwbURycW9VWkl1?=
 =?utf-8?B?QXVrM0pjd3ZkTDNLVjRWWTlrNUoyU0ozK1htR3ZQOHpKWWw3bFh6UVM2U0ZY?=
 =?utf-8?B?dUVSS2ZRODNxTFl3bytlcWVzc2pNQUtpN1BnQlV0bWtCY3pVOFRrR0tuMm02?=
 =?utf-8?B?RTlicGhYOU9KT3J1T2FzZnVNdVVkR1hFQmZTU3ZGOS9LWldvcE5RNllxREFF?=
 =?utf-8?B?cjZtdWFjSGkvZEt0c0pQRC9xWFV2cmM2d2pFM0J3SWViVkhnMEtUc2thUWVJ?=
 =?utf-8?B?ektmQWIvMHFORUxzS2JubVFvRVhZUTRYM1Q5eUNXczhRNENzK1FoYk1pTDJv?=
 =?utf-8?B?bGU2RXp0YnplZ0FES1BVb3VRQzIrazV3ZUNzdGNtRmg1V05VaHR0WkE4L05x?=
 =?utf-8?B?S0xzUVp2elFGbHRKbjYwalEyZ3VJVG8vOVQvNk9FT3AyeitHN0hibmF0ZTBB?=
 =?utf-8?B?Z2RTK1ROOHFiTkRpNUxsd3dOWm0zMXJZZGU4djZobEtZNCtZbGplQ2pMMFBh?=
 =?utf-8?B?RVp0Rm9hdGlubVo1UFJRcTFJVUNLSXV6azNmYkEwQWVnYk1zazhLOGI2OWtR?=
 =?utf-8?B?UWlIMGRaUmVsck9EM25pUjdKT3JvclFZbXZJbnN2Mkd6ZHNENHp2NWxYSGF1?=
 =?utf-8?B?dWE0TXpVOG1PRjNhc0crMUl2eXN2bC9yaUtLNEhVNzRRWHlCVWlXN0FzSmtY?=
 =?utf-8?B?WW0zVHNYYnBxU08xemJaeGdBVDFEamhxRmpDSkk3dDBkK216Wm9RTGpZM1o5?=
 =?utf-8?B?ZHNxeFVyZzI5T0ZQZDRQdHYxQTlwL1FLSjgzaW1aVk5oaXBSL25UeUI0UnFr?=
 =?utf-8?B?b2RFeW1uaGNLbERXRFo5Q0JBSWQ2aTBVOVQvVS9XTUVyOE05YVR1T1dhdmM3?=
 =?utf-8?B?SEhQM1BtSXlWRjBHKy9DV09IUDdOQkpLZVRzUVJGOHA3dnNHVndDa3o4Rysx?=
 =?utf-8?B?YmFEQ0Q3bjZjR2ZPVHpQSGVIQzZWQXF4cDZuMnhRSUtYOVlHSjJNTU5DcXJm?=
 =?utf-8?Q?IVKm3zXQC3Ud3ha+PnODBPQdA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15271ad1-b823-4077-027a-08de213cf078
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:11:15.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/Q+vJq7U0BfKVhaGXJVHXPVHF2ttsHQY+IMjNGi5GupX7U3L0iDcqSa50sIYsLuQOiw1WfUKlXwDaLb57QHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11934

On Tue, Nov 11, 2025 at 08:02:20AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Shawn Guo <shawnguo2@yeah.net>
> > Sent: 2025年11月11日 15:37
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; festevam@gmail.com; kernel@pengutronix.de;
> > devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux
> > regulator for PCIe M.2 connector
> >
> > On Fri, Oct 24, 2025 at 03:31:46PM +0800, Richard Zhu wrote:
> > > Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
> > > Grounds.
> > >
> > > PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
> > > source, 3.3 V, is expected to be available during the system’s
> > > stand-by/suspend state to support wake event processing on the
> > > communications card.
> > >
> > > Add vpcie3v3aux regulator to let this 3.3 V power source always on for
> > > PCIe M.2 Key E connector on i.MX8DXL EVK board.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > > index 25a77cac6f0b5..7704dba9e37c0 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > > @@ -649,6 +649,7 @@ &pcie0 {
> > >  	pinctrl-names = "default";
> > >  	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
> > >  	vpcie-supply = <&reg_pcieb>;
> > > +	vpcie3v3aux-supply = <&reg_pcieb>;
> >
> > Is it a documented binding?
> Yes, it is. Please refer to what's Rob said below.
>
> "
> It is standard because PCIe spec defines them. pci-bus-common.yaml already defines these:
>
>   vpcie12v-supply:
>     description: 12v regulator phandle for the slot
>
>   vpcie3v3-supply:
>     description: 3.3v regulator phandle for the slot
>
>   vpcie3v3aux-supply:
>     description: 3.3v AUX regulator phandle for the slot
>
> Note that these should really be defined in the root port node rather than the host bridge node. We've done the latter because the RP node is often not defined.
>
> Rob
> "

Shawn:

	Check https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml

Frank

>
> Best Regards
> Richard Zhu
> >
> > Shawn
> >
> > >  	status = "okay";
> > >  };
> > >
> > > --
> > > 2.37.1
> > >
>

