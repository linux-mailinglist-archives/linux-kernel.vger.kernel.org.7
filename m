Return-Path: <linux-kernel+bounces-807084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C1B49FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058724E0767
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06FB26CE10;
	Tue,  9 Sep 2025 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wUbOAAvw"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B3273803;
	Tue,  9 Sep 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388125; cv=fail; b=AjbwHOdehURcaguMBxWyZ8cW1bc1g4DdogGmW2Sorz3G66RAW0DBCi6jFkpC90wMMvYayd9Hnf1c0Wn47PlKNTMRJA+zl6qmCZuYP3W75L3+tIaZs6lzoiui4eq+4i2L0SirBX0Jo1Gn33lnLnmoZQgworfYvXdW5qvexQd/o3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388125; c=relaxed/simple;
	bh=IkpOJsOx2OxlcK46aGRJGZijoT/5/5kkWouu7fk0fdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sWV5yr6r3rSNOTRQ3QyCVh3sKyuMj7lOs6DksvWG1LCQQOp7rWv5t9BnQb4IYvnLZw+KgY5penhn9DRHJrN68xMOjk8VcqiLb0nFLbZK3DeBKIO2F01byp/YgkXAPBJ1IvKx1QvLollBPRcQcgmAwXJbwpwNP6vbTKlDSG1kfEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wUbOAAvw; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ4h975nDvJWyMqHVsWTqCo26BJ8ACqZqBgJBOJnrbICsOOKF+Ehd/LttENniWk+iBlIwyT7/WCVxAzI9ZawTghQgFsC9cgn0XhWLqmpACmGhmUWVRCuFPCF67aIm+0pK94Ua2HN1OM8VvEHhpVJqTdR1CcQ8u4BxLTLnTYX3iEZRX+YsijeZjRugWyeJJYsuEc34VZjl4xdssfW6hgAp02Vl+rDbhByjuabLFcT1ULbfAtQ6I2DZjRuDyllYZ76YwxVv4JhnbtRXTZoUburWMCTX7vgpLNuVUTNxFxFkPU9dHRJoFUk6ZuOt8KEnGaWYfcPgK/W38jcxy2XbByy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkpOJsOx2OxlcK46aGRJGZijoT/5/5kkWouu7fk0fdo=;
 b=qWjJqNCtWN5Ra0v8laPVAqDpVYHewev571SzS43MXvkMy8o7hw8NAAbYoGSmrC8qrD+N30M17NrtNLlnXAWIdzPuOM+td7dt1VSd05zBgcQiBgqatq1i+IMVXJGpuPnt46RTsJ7VppxgyknxmldaXlTbsC9f6Z1jzOuxwsVfoNn+D4WWQBKHQ8LnbjgnupW3lVFRPie43K+bSbkRbxZm6OZVF7LUbXuCEtfOJqxXlgAVcGquW0OLhLOuYRpqaQxmZJaEXMNZOpMKUUukYe1Gfx13hPTOcZNLKJR86d4kMSiMY8FmaS6g5T2u4Wdlo8gEV0e6aHD33FN8PMV0zScilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkpOJsOx2OxlcK46aGRJGZijoT/5/5kkWouu7fk0fdo=;
 b=wUbOAAvwF7kizN/J15uiQvJJbJAg6q0VTE6mN/Y4UbN87gCOdhnHKVSTbusFO7pYGMSK3dLpae2f5gNg0MxPZ2PDbVY98DB2y0/Rg+HGbQxfOqBiiGu+Ce7UvzgxgILyqoe8cuqWoJYQ67mt6k/E9OLR6LhBks8aCHipsTT0fXJLbTDyVmODjV7NpOSzbx0Ggc0uWDEKZHi8ixH059Xzw2mPBX2DGM40WfdegN8h4fSXFBTsL7VZiyiTn9wwG5u3MKA6BbQI2pBF9HLY10p2Tpy1ZWxMIYmykcjo9UHstcZR7VkzsqN3OMct2NTdHwB1VcKZAagGvZn0m9CuMyr+Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10938.eurprd04.prod.outlook.com (2603:10a6:102:486::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Tue, 9 Sep
 2025 03:21:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 03:21:58 +0000
Date: Tue, 9 Sep 2025 12:33:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for
 netc
Message-ID: <20250909043327.GD20475@nxa18884-linux.ap.freescale.net>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
 <CAJ+vNU2hro_ZoRvmQ9yowKsX25AnrgZdGMn2D-RCkyJA02CEhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU2hro_ZoRvmQ9yowKsX25AnrgZdGMn2D-RCkyJA02CEhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10938:EE_
X-MS-Office365-Filtering-Correlation-Id: fca5e776-e317-492e-5ae1-08ddef5008b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SjM0RmRMNXMvUjNlcllOUVpNblRWWFVlcXlVRHJnV0lJbkpqR0RYT1o0c2VR?=
 =?utf-8?B?TWY5MU5WQXpTR2dSbVFPOTlTc2ZjTlVBdjh2MXF3NVJsbWx4dDBPLzltTC9M?=
 =?utf-8?B?aGZNWWhWOXN0V3ZscXlVd09aZFp1cE1sWTRpUzJTOStyQmdEN1JaZDVBeS9V?=
 =?utf-8?B?WXFzekpOQ2hFZEtHR2h4K0xtbnhXNzlUanFHUVJTcXFCNTVsK0VFSlkybSt6?=
 =?utf-8?B?ekQ1Vmhxa1FQdE9HQS9vbGlWRnYxZjhmMUtTTWhTZnhiUnpwM1VSZ0RmN0lE?=
 =?utf-8?B?cnAydG9FL0RWZ3RrbmxZMFRIaW1kOHlnUThCWHU3NmJRWkpwK0ZzbGFmVE1t?=
 =?utf-8?B?aWRSWVpKbW15ZlRpQjJrS202Y05lb1dXNktubTNxRDJvd2tRWDZyUnBQeFBX?=
 =?utf-8?B?WVBXNnNaQTU4VVh1ZVpKUjlyMVY3cm9HZHZ6Y2h3aFYwcFNyMWF5cE13SVVC?=
 =?utf-8?B?QUxUTitYOFl1NlptRHVvNmxJc2w3UGFib0VIQzNIRFg3OGgrU01McVBlQ28z?=
 =?utf-8?B?QXV3ZDVVRDZnUDFqKzgvNFA1b3N1bFBjOE1FSFJnTXAvMWZDbDdwam1JcVFs?=
 =?utf-8?B?NGo1WEIvK25tMFdRbjlORldTK0dEK2orUWdpaS9CQitQU1RPbjVhMkZJNXVD?=
 =?utf-8?B?YmtUMnJGWFRVTWZpSFdCcjVOMDB4cEJxRzFIOU52a0N6ck1oZ2YyM2JYdE1k?=
 =?utf-8?B?cjFVODQycXdxdk1TZDR4elFKNm90WkNhRjRUSmRQTkxnVkN6RHpQTUpzdGxP?=
 =?utf-8?B?cERHNTVMc3ZkQUxVMFI5MlhWdldNWTcyMlRXQWlrbDlTY0FOMFVvSG9ZK2Y0?=
 =?utf-8?B?YmFyZExDNHc0QXNYM2tSR25aa2g2bDljSmFZbUFmWEFIMFAxZVpVSW9keGEx?=
 =?utf-8?B?a3h3bW5IN3pkdERCWjNMc0hCK0hIWGR0ZW4xMU5FbXRLQjFxWXFvTVFPNlFJ?=
 =?utf-8?B?WFFsV0MrMldoRkMxcFdIcjI0K0xRMEdRTitVS3VXak9BcXQ4WHBUcGUzcTVK?=
 =?utf-8?B?Y1g3WXcxR2tjMUJMaUZQa1lLZTMwZWF0UDVZTHNudXRGTnFuM05GNFNtUDh0?=
 =?utf-8?B?UExQSjZqZXFzbm82WHR0enFzYWxUQ2FYcnIwMTdCNXB1aHVEUTlOSjI2eGdp?=
 =?utf-8?B?ZGhhNGsxbUhSQzhRNmJjQThQWGxHOGhLNW9CbTY2NG9DMXlkQ29OUldHQitm?=
 =?utf-8?B?ekpEYmNwc3ZyM2Nyczg3dS9DT3lKZjNSSjZKZnY2VE9rMzJVeVJjVnloQStE?=
 =?utf-8?B?UHpIbzNNbEpCelVLR0kya2pXMjZTdGQzUE5XdmxSVzBFWXF1SG56Q29MbWhj?=
 =?utf-8?B?dHpoS0xqb2hMTG9Sd1NpSzVsTmJiT2VmMTExd3lnU09FamptWXoydVp6MXNR?=
 =?utf-8?B?Z1JwWFdBc3puNEZTbkdHY0JVNDZBOTFRRTFrREVGYi9BdFBLQ2djZ0NGbWdy?=
 =?utf-8?B?dTJ2MDBnSEpDRE95R25IbFk4NjB2QzNQdnB1Y3FHaERLV2lPVmlWTDI4Vlpp?=
 =?utf-8?B?RUt5bFFyNWVIbHFhcE9aTkZYc3BBa3VXYnZOcjY3OWZlMjI2ZkFBUUJ6bGJn?=
 =?utf-8?B?M0FaZ080eVVhYVVQQkFsa3J2UEhqNHlUWHUvMlZ1MVJvVEdub1h5Tjh0VTMw?=
 =?utf-8?B?WFJxTlo2eFZuSDVMYmxhaDZQZVNkR0I4NnJ2c1JwVmtmaVpVWlFtRFIyTStK?=
 =?utf-8?B?TTEwWjBnRUxUQ0dMWlJDdHU2TGdyVkR3Vk85TEFYR1l6Z1FYZnJQMHFUUmk2?=
 =?utf-8?B?cVRvOHNkSzBOOGQzc1QyRWFSUThMS3JLdkVETElFL0J1Tkd1eEdwOHI3dmpU?=
 =?utf-8?B?Q0V4NlBzUmJYYit5VU5wQVVLcHV0QzlIaXh2UTdFMnBWT0dDcy9HbTRxT29h?=
 =?utf-8?B?aTZzNGM1TWxoUjN0VGNrUml4YmJ6TTVPZlVoWkU1NGY1RmczTFhwYXhyTUV5?=
 =?utf-8?B?b2FyVitkdXBNZHNQZWdnMnNrOXZKVnZtTlRJd3lHTkc1Nys4bHdzSjM3ZCt6?=
 =?utf-8?Q?DDDxI4uhwxGxXHQjfg9mDOsY9SLJQg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QnAvN2VBOWU5Wk1UUXc1UkxOL1hhbTlna2dwSjFHT3hPM1lrWjd4Zld5UEU3?=
 =?utf-8?B?N1VpcW1NRTFvZXc0VDFwNVhIaU5SVzdqYmZZSUlvQnZGelZyMzZyMGU5Vk5j?=
 =?utf-8?B?LzhSL2ZsdzB5Z0ozQkRuQzFHRUQzbWd2OXUzTkltSGxZckhCN0M4TFk0S09W?=
 =?utf-8?B?ZmpUZ1ZFNFprSDc0K3FySEpLN1FzSldZV2NEMHFUYldCd1ZxZ2Vyb3pFTGZS?=
 =?utf-8?B?KzJKUzJxSHhwbTljaVhJSUg2THJmazFIcjZWUS83WmFMOHcwbkxJRmxFL0pk?=
 =?utf-8?B?Si9NM1k3ak1KRUk4RG9rR3NLMlBjK0xOWTI1Qm9GVzM5eTJwQWpOOEFVTUlO?=
 =?utf-8?B?bzYwM3ZqbDk1aitjVWVOdFQ0RVoyWmtRd3pTT0ZQMld4VHA3aWxaaW5NaFJO?=
 =?utf-8?B?V3lESlNUaFZ6RU5jRmlFeGxPS3I0NW5aU3AvbnZWRFpEVFlyaEFqTDJNemh5?=
 =?utf-8?B?aFJ2dUU0QXBBUjFjVGtpQVU1d3pMWCtNMzg3RDNtNHM3NkgxaTNXcFc4dENt?=
 =?utf-8?B?dElzTmQwVzZSSzRkUFBxWFhFdm96bzlwVFZ2MFFDaFViMUFGNHhiL3RyTGRY?=
 =?utf-8?B?cW9Hc1FwZXJnc1Z2b0ZZVFk1dUlsd1dQdTlITHMwSDdPa1E4TnkrQXZBUHlx?=
 =?utf-8?B?cHdDb2VyUzlXbzIrNytuK1FYR3lpNk1aSklGMzFLWlg4ZTNsb0Zrb3ltZ2pC?=
 =?utf-8?B?bFliQ1lQVStWSHJFa1FQREQ1aTV1RnpjeGw4cU91MGRTU1BlMHg2UU5aYTR4?=
 =?utf-8?B?UUZUTHR1UnJMdzRxNnRKVlR3c2lUM1pheGdPbTVrVWZrUS9CeWh2NW1za05n?=
 =?utf-8?B?Rm9RVytuNmcvblZ5L0xIMjR0NHFaYVFpWVRxVVBnbVVKVUN3Uk5aV2ZORThM?=
 =?utf-8?B?L2wzRXRMTG1lcWFsb3FzeENNTWtteGhVT3RHK0htN1ZIeUlnT2xDT3NBcFRZ?=
 =?utf-8?B?UDNvTTJhRXYxaEVkSHlMSHJScDM4eUhNdVZWSE9xRTFCQ1JkL2hITjcxekxP?=
 =?utf-8?B?WGxWNjc0ZWxZU0ZCMG5IWnZqbFhpeVZWZUxZRldpckxBbDFLWElsMXpIc3JO?=
 =?utf-8?B?U203bkRvYlhsSHRtakttMDFGTWU1TmVENll1bmxGSHRtYXMyWEp1ZTlIQ3Jt?=
 =?utf-8?B?eVlzRHp3cytJVHpyTHNTeWw0SCtxdzluQjVmMXhZOFJsekZMTTRxVldMNWFF?=
 =?utf-8?B?Q0orNGMwZ3RNMmNZTStwSU0rbzZ6akNHNytjd3ZReUpSOEhvS3Q2bmJucjJr?=
 =?utf-8?B?MWtKL1FPU3N4Sk9SVU1pb0V5Z2tnb1NUdU0zRGtlSUhlbFgzQ0JXMzZpRnJ3?=
 =?utf-8?B?a2lMNXMrckpETHVtZjN6ZTVrdWRLc2JKWVZRajFpWWUrNVRRS3c1bXJXZHdh?=
 =?utf-8?B?R1kxVjVQU3plNFBMeWFhOFBkSXEydTNZV2VGanRVYkZEZkhYY1c3eHBqUFBL?=
 =?utf-8?B?aUtSSnIvS21sRTZmVFVCZjlQSnpKcnhPTGY5T3ZNazN0RHpnby9IY09tb1Ez?=
 =?utf-8?B?MDV3WHRKbmNDN3VqbGhwOVB1ellvYm5rWlFuZnVJV1E2bTZ2bG14QkhtNkJ4?=
 =?utf-8?B?SFROL3lFY0NXbGNkby96NFBLU3pOSStKaEhidEJSdmN2dVkzb3NWTmZTbkxh?=
 =?utf-8?B?Q2lVZmsrK3Q5andhUkxEdUlvZmVZbFVUckpCZVRlaCtMUkloNkZjYXJmV0gv?=
 =?utf-8?B?ak1qcUx3anFVOTdMUysyQWtuZllmYmdRbFpwUzA3cXlDUVFvbitFT28yb1JO?=
 =?utf-8?B?anNLeXRja0hLK2c4WW9zcXVLczhMblg3ME9ranlKRFdJTVYwUUNZVmppNXlm?=
 =?utf-8?B?d2hHaTFpbEJJaWdvTnlCMllFZ2lKa1ozOGtXVTQ1Tkg3VFRWK05DbEw4N2Mr?=
 =?utf-8?B?d2xoMW0rdTVJZzNkcGNLU2hlcWFPWG9GZGUrNEVaUSs4a2hod0tBYy9YSGRF?=
 =?utf-8?B?ZHAxR0lyZFNsWFUvcUduQkpLVC9LaWM5ZE55WkFSeWdGclNDNDhGdHpxZEVi?=
 =?utf-8?B?Ylo3dmovdlRzWUtITXJSdXdWTDY0RGM3SExQS2xPSm0xRkpRSXZXd2p1MVBZ?=
 =?utf-8?B?SlIrQnhYajRaN2tQNUNrVlp0a3V0eEhyK25ISVhGRkgvc1Q3NkNISi96Vkdq?=
 =?utf-8?Q?yn7LkLhFIwUta4YkmWqCr2K2D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca5e776-e317-492e-5ae1-08ddef5008b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 03:21:58.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGWgrL/8p5b47UoeoAWpEq00Vkm/OcVWpoWq/WVaewqg6ZA5HrHtKcOQiDr9r/O7W4ZWaLgdTRLCuhPkIVB3fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10938

Hi Tim,

On Mon, Sep 08, 2025 at 04:43:25PM -0700, Tim Harvey wrote:
>On Fri, Aug 15, 2025 at 4:50 AM Peng Fan <peng.fan@nxp.com> wrote:
>>
>> Add phy supply for netc emdio on board.
>>
>>
>
>Hi Peng,
>
>I'm not sure where you are with regards to this patch but it indicates
>to me that you may have the enetc_port2 10G port with the AQR113 PHY
>working on the imx95-19x19-evk with upstream Linux. If so I would be
>interested in knowing what other patches you have for that. I'm seeing
>the interface fail to register with:
>nxp_enetc4 0002:00:10.0 eth2: PHY has no common interfaces
>
>I'm wondering if there is some support missing from enetc or the
>aquantia phy required to work with 10gbase-r.

Thanks for raising this.

This is just to add the missing pieces of device tree.

For 10g port, it is still not ready for upstream.

You could only use the rgmii-id port. This change itself does not break
the rgmii-id port.

Thanks,
Peng

>
>Best Regards,
>
>Tim

