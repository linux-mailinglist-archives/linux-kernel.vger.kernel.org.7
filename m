Return-Path: <linux-kernel+bounces-833247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DEFBA186E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497B3741C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBBB31E8A7;
	Thu, 25 Sep 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEwKk937"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7B2D0606;
	Thu, 25 Sep 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835422; cv=fail; b=nMD/83IQVWGfDKrMBK3ljEUgCDj96E3Vh9fDx4zFQA9acSGHzkgJ8KtscCNo97LhUA29oIQeK5sXYRIn1T9LCzP3nmJKCh7Q5nKXM86Ym8EYFeZ0NToXPdZu5LAheNYtdP8zBQgBPrRMFla9eWAB7ntv4nC8k3QrsaqKnAYGNTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835422; c=relaxed/simple;
	bh=5Ov1BB21+bR1BHbhD/vUjIMzk7r/YX/RMsNIF+DAA1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bfGKyqIsYWFqr/o+F0+wOkvUJe5/6gzPGhJAJ3SNQg2ZSp5ReO+1iBF8DCuXX4L630Vp5FJsS0gUEOVFSrUcIm6uvnSUqvFDigWE4cCSYtCq459FJCZkSg8aThpJHr5N2W1hS4A/MDtJXmqZjLUPhrfNFMTGjWchWnRpPRcJNyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aEwKk937; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaBa9lwcy7+rDud96ZXt6CGB6eCPFLw5XQSeoq8RGDs3PJhbnukPV+OnqEA7h9HCVnfrUDoJj5/4hClkxlxhtfi2B2SnXPpZC5NrprTVkOHBpo7S9u+U9K9PMksdGbVFyNMtRT862bQgBfl0Xh+0y6KcwRTOAP5CJJ9S5c1SbVxuW3skG/xN6TuITCBYLgdiEQugzu6l+7ZkHoFiJkPHZWIYT426XP5arFwp/mtnig/duzE8DZCgYtBIUHZqVEejPopPA32/Oa/MuZqCb2uCPzGDEWhDSTnR+whLfzGQRtHRudiH5OOpIQ/ysAkA6I7LBKlglZJJbwq6rE0u3QvElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EowiGHGFU7Cd5OzELc2aTWl2DywARxM6G/KVbYKgosg=;
 b=xEFVGY2uy50+lisA7ILCukQSxbTjAtGctigRFdGY7nDtC6hK3TCKvPi80IJivvEhVZbwO8j+JzVfurXVGN125KN8ci/Jx/prwqWMBxwnGz+l+yhnVQbqf+z7z5lyQDLYs9jJOg+En5n+sW9JqnlZbfhoCAMLRfPNHhuN95jPT8K8SLvLllvgxyZ3YsuaGeLZmCOedQdQILJMcZcJVgkuU9geyJVsZmnPrTojy9hT4hItf/cVCYo9lQuJPUR51jUL2koYP1uEX21Uw92+ccRsi49J7ygTJ+SVoe0hVOkFJNvNY74rkU/+t4ELfOCGxKgW/1FPlJ8VXKePQlhqVHIb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EowiGHGFU7Cd5OzELc2aTWl2DywARxM6G/KVbYKgosg=;
 b=aEwKk937JP2iO2FHRDVCI2anu3lNIszkJK9ulLEvI205F3kvOuu0ckJupCljyh/gQDbRYq/ctLf6Hnm8XABnMGQCXpwViHUVRahbt+ClSq4QtENeskUId7ApeWYc3nOrZIsNVvo9IFD7i720U9Dua1cnrmDWQ6gwTYP4fN6CE0yQpvkcpL78HIL/HDbZgU56trKTq8oJMVdwK/kaLo+GnSTTIGECaWSxZljJ0D+pJO1kZD6J1yES/7DvvDK76eFZJXntkglruKDs2KM/rh5EMaNzcihMYQRZJikSfFHULlSnjKOupJavD80sYSLPSFq62+cKfxFQ4O2Dh0zWoEh17g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10070.eurprd04.prod.outlook.com (2603:10a6:150:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:23:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:23:37 +0000
Date: Thu, 25 Sep 2025 17:23:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] ARM: dts: imx6: remove gpio suffix for regulator
Message-ID: <aNWy0ZelmcFe5vQC@lizhi-Precision-Tower-5810>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
 <20250925-imx6_dts_cleanup-v1-5-748380dd0d22@nxp.com>
 <CAOMZO5BNBp-sgeMvisvXjvrQpkznGkCY-8h_vwp46p0izwYqEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BNBp-sgeMvisvXjvrQpkznGkCY-8h_vwp46p0izwYqEw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10070:EE_
X-MS-Office365-Filtering-Correlation-Id: 09598d5e-fa46-48df-5802-08ddfc79ca61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VW0rQlJaREc1VnhPZHdSSWVQNFhTUllSRWFtNWZLc2xVamlPQXJzZzhuRVBG?=
 =?utf-8?B?ODMxTHVoZExNTlU5dWtuWHVSZmNnVE1tYzFBMVJpeisrY3ZpdFlDZjZNVDRo?=
 =?utf-8?B?Rm5YK3RaUnJqT2JnbCtyOE5HZjhSbDdqVktLdFNPTHBiOGhLSjRMSENMVjF5?=
 =?utf-8?B?eStLcFAzOUl0aGJjWUIvejlsUXZTTHMxdDByVXBkbWtQZVFBeGZXMGtaTG9B?=
 =?utf-8?B?OHpIUDI5WXNTem01ZkNvTURQNXVvT0xCTnJwN2h0Qzc4emo1eUNmNVAvQ3cz?=
 =?utf-8?B?Q0UyMWRDOVpTZkhBTmtYbFlTWHNNYjQ1cDRwL0NWSjl2SzRSNlgrU0JGNmtW?=
 =?utf-8?B?elRWQ2ZnY3d3VzFmZ0VRUDdmMEN0UHMvMWtQWU9rekR3L1RXdFJ5Z0VFRU1i?=
 =?utf-8?B?dWowSDJIUFFPVmtIb2t0cHNEU042aGJKZlVPQ0dNRnNoRzRvMkVlbHhNUGVB?=
 =?utf-8?B?L2IvYkVEbDhCMGpqTTdaL3RSTlE4b2tQbkw0dHhldTRTd014RXI3bU5JMVky?=
 =?utf-8?B?TkpEdVF6NWVPZWdsR2JDT290TElCc3dYeUJFaGZXK1hmYTdZTlI4eFR3Y0Vi?=
 =?utf-8?B?aDBYNkcrNEtMZTY4b1BLc1A5YUlVK2o4OTMrMnEzc2doUVAzQ3diQy9sSU44?=
 =?utf-8?B?ejRDR0tLazhhcVFjZTRBVkZ2SlhoWTJNUisyTnVLd254TW1RVDdGL082OWQw?=
 =?utf-8?B?QktRek14eTdJdi8ydWIzZERPWW9UTjh6b3owMUtFbktkVUd5ellzTVJqam5i?=
 =?utf-8?B?Mm94MVVxVkFSemVhZzJSSWp3YnRRT0ZUdWE1R1ladDZzVEd3bXFjZ3hLSFJn?=
 =?utf-8?B?YmY2NVdUQ1NrckFldjhMcFpocm4vTDE1VngvOURMWVliV2NjLzlKN0l0UXJS?=
 =?utf-8?B?RUhGbkRMbGJSZFE1NXcwcTlvNENpcXZzUnlzSTJ6MStRUGJhYVE3bmxSNWto?=
 =?utf-8?B?alNqRUVpMHE3NXhrc3gzZG0rTWNla2RnUlIveEl2TElmSytEeXhkcWhHN0tm?=
 =?utf-8?B?SG5LRzdwNnMvRkJJYS8zaWtYVmoxNE9rZ0pnV0ZTK2VOdlpVR3h5cU53bEND?=
 =?utf-8?B?Qksya3V2eS9HTUJldzQyclhLZmprK3Izb1NHOXNXQWRYZ3RvRWdBVWpqSWNs?=
 =?utf-8?B?VlVnZHFNSytVYzJyQ0NETTdTYkdYUDkraFV1NjVyWWFRVjRGNjV0RUtFYWpY?=
 =?utf-8?B?ME8zMHlDSTgzTUVpN1luVTNGNDBnU1lBK2s5NUg3WHQ3WDE5K3ZXR0JDcEtv?=
 =?utf-8?B?WUpKZk80TTkzNFBzQlUybk5XVXNJQXlwMFVkOVVnYXlTMElGU1pPT1pCdzhT?=
 =?utf-8?B?cEFnaVA1T0JrS09vd1h4bWt4cUtLQTBkbmRwMVlZampLU2dScjBXWVltWUJX?=
 =?utf-8?B?S0NLbFhKb0k2N1Z5Y2xaVzlyZ0Z2QW1wT1JLUHVuMERteElsbUsxcHJhY04v?=
 =?utf-8?B?MW5MbnhSeTVMKzZwY0R6eTdDTFFYZk5sUXpXcEZzbnNSVnJGMWZJcVR0SWo2?=
 =?utf-8?B?RnVlVGdUTEZrSUtHZitraHBYWWJNWUlRQTFrZEZNYW5yNmU3cWgxSkFraHg4?=
 =?utf-8?B?Wi8vRE15NFY3Rmd0TTRUZEJRbTRIYm5DajgxK0t5U2UyRG92Z0t1TXNxUjJq?=
 =?utf-8?B?MHFFSjZVTHlPV1pmMFNXTzN0ZDJuZlJjTitJRnFOODVYYmZoVkdMUllreExw?=
 =?utf-8?B?eHlxK2pGRmdtazNJdVNweXo1Q3YwSG92WmRxb1phWXRUTm5yWk5BUFU5WUNR?=
 =?utf-8?B?SUt0TW1ETzF2VUVwUEFKQ2JjQ3BBVEdKMjhreXN6UDVlZDZvdDVpeXlmMitq?=
 =?utf-8?B?dE9uUHpiWWJaSTMzanBhYVh5WGtNTjU2K2Y3c3J6aGYzVFgwN1dtSVM4UWI3?=
 =?utf-8?B?SzFaemxmZ3U5OHY3YUxoQTA2V3ZWU1RRNDByb2pRMVhxTW5zTm5ubE9Kc1pP?=
 =?utf-8?B?MXVFUGZKTndQbjR3U2hWQkJpQURocmkxbFU3V2FJR3FDT2l3VU9JRHhjUHhM?=
 =?utf-8?B?Q0Q3SHMxM29nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVJ0NnFKMUdRYS93MTNBMnUxUUUrclJHSFFSYVo1aGh3TTZONkdRVWJGcWxU?=
 =?utf-8?B?V2c5QWh1TXJCTXJwM2lpc1Q4c3hBZHltN2NCYk1CVEtXN0xIZXhtQjNLMnpO?=
 =?utf-8?B?N3hFK0lXL2Jwb2JNU1pXQzVubkttcitsQnhvY1FlOHE3MUl2N1VzQUNzeUF5?=
 =?utf-8?B?MmJPT2NTYm1iVmFnUHRmMjJpRG1jcUdhdHBLRDlKRU1jTk9USVZJUmlTTjFF?=
 =?utf-8?B?SlNNTHR0YWdoTTN5NGljUDRQYk85b0VjL05lSDNzdXlYbVJrTHJmQnhwckJq?=
 =?utf-8?B?aitnOXA5em5zWTNsTEdaSFgrdWxnODJ2dzY5Y0c3UGtpRmdJMTN2NkYveGpI?=
 =?utf-8?B?MlR3Q3BIMTVCUmtlY1ZTc0RsZUdHdm9UdVRLb0RuZHE2anRPSTZYWTIxVndG?=
 =?utf-8?B?OFVsaXhUdy9SSXZjTm1jci9GYU9YamJLeWRrU1BsVUxxcEUwQUMxNEV6OW5B?=
 =?utf-8?B?clNXZDFuL0lOR3BpMDBKcDYzNEJoU3ZRUTMwU3d3Ti85WnI3dUExeW5vUjdi?=
 =?utf-8?B?TFNFU1kzSU5ncmZOdHpDcllwTC9FdVduVDYrcXpFL3E5VkRIUFR0eXFRLzgv?=
 =?utf-8?B?RDdIVGNhcmJlWmV4MXhEemF4TU5vb3o2YjlhdGR0dWllL1dVUmJhbG5nSHp0?=
 =?utf-8?B?N1ZjUUpnWWorQlpEb3pYZ3JLc24ybzFmVTlQaFZaaGh1SU1oclhqQjJqOGRX?=
 =?utf-8?B?K0NleFkxVms2T0NhUlppaWJTNS9tcU1KUy9sT281NWZRYUYvVkZxL2RwTlFK?=
 =?utf-8?B?QXdEUmNyQTVEZDNPTDRSaDhkNmRnY25RQm1DaGUrcGtqR25uSkkrMndEYUFi?=
 =?utf-8?B?ZEZHQ1NNcksrc0JmMDVkb2YvMmplNVBPY2hOSVRYakhvSUxwOU9kSnlYMXo5?=
 =?utf-8?B?Yi9QNDNNYWpZcVJVK202eTRlUnNiR2J0Wk96aFplUklPbTNXZmMyS2ZPNVJF?=
 =?utf-8?B?UFZxYlNQYVVRcjh2TlIxNk1mWlJ4ckRYK1JsVy9UdHJXbXJnMExqeUI5ZU5m?=
 =?utf-8?B?QlNmbDRqTml5bktvamU5NXdqQXRjSUxkWVZyR3poWHNLbWJ0QktweTVmWTdB?=
 =?utf-8?B?ZWdsN2NDd1h4Y09lSW5oRkdzdm9zVmh1c3FvOGhSaTNqV0JjckFUMHBzcCtD?=
 =?utf-8?B?dHRLbTl1WDU3VVRab0pHc0VHb0oxTmtQL3RUK2hQK2JhM2xyUWdXSnBpZjVG?=
 =?utf-8?B?RmVSWjdIME4xVnJSVlV0MlI3TzYxd2o3aDZHZUJPR3p6aUZBeGpHV3dKalow?=
 =?utf-8?B?dktxYVF3NERrV1lqbWhHWUF2bCszQ0ZRbXpNREdLdUdqUTM1TkVhTnAzZzdn?=
 =?utf-8?B?RWViK3RwaHpyb3RoZDNON3hrK2Y3NDhkckNrZ0I1L0dyMzZIQmM2ZnR3ZS9R?=
 =?utf-8?B?dGdyUWtUNEZyalY3S3gwYm91cHNGdHBYU3U1WGtnT3phQSs2K3ZRVGlEaDda?=
 =?utf-8?B?UjVHWGtBYlBqdVBGQmJ0UFVaYmJuL2hLUzNod0VFbnBCYkh1RGV6eml2dWIz?=
 =?utf-8?B?Q3RHOVI4Vk8wbnprNW92Y3lWVmJyTUwxdU5wMERXQ2EzT3ZiWXN3N1V4ZEcy?=
 =?utf-8?B?RGlqczhQNTdnTE54S0RITEVCZnRvcDJuR3RQUEZBcFMwdXFYTndncTZESHhn?=
 =?utf-8?B?c20zdmZDa0JEVStjYnp1SlBQcndzdnBxbEFNTmhFbGYvWGVzZ1dqbEpxb1VB?=
 =?utf-8?B?V0ltR2NjZjFyZHBncVpCeVcwWm9YY0Z3ek90dWlKT3pEWXpibHl6OXFFZGZM?=
 =?utf-8?B?MEN1N1U4ZTcvR3IyNElkV3JTVHdTUjQ3T3BMcmZJc1ZRcHpuZ2ljSkV4Y0s3?=
 =?utf-8?B?bERzWlFzNTBld0lVQVVxbXVrUXQ4bXhQb1pEMTFGbWJVcEFGWDllN0VOencv?=
 =?utf-8?B?R0x0b0xSTG5WNkZVZHFrRGl4KytZeVJuRDJHWW9mZnAzYnB1TjlabEVOdWdH?=
 =?utf-8?B?RVhoM20yWVR1ZTNlbjc4RHNzTTgraUpFallMV292ZUQwMG1sako3ckJTdjJu?=
 =?utf-8?B?a2srL25OUkdiNlM1aStYekYyNG1yRmdTaW04azVWRnV5cU1EMkpQQzVOYkdz?=
 =?utf-8?B?R0xrbk9IVVkxSzBXeUMvOStrS1lEMXJzdWYxMW1EUG45NzMycWhHaEloeHJt?=
 =?utf-8?Q?zeu6h9pVbhYs8+dJI07aRmZ3K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09598d5e-fa46-48df-5802-08ddfc79ca61
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:23:37.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWZxYGqxKEW/lqNEP/VqLYNnqWgsDF4Dzm6XdnQJh4orLLXEuuWZci1pOK7Rblo3PYQkblusxnJGrvX69Gp3UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10070

On Thu, Sep 25, 2025 at 06:16:30PM -0300, Fabio Estevam wrote:
> On Thu, Sep 25, 2025 at 6:14 PM Frank Li <Frank.Li@nxp.com> wrote:
>
> > -       reg_pcie_power_on_gpio: regulator-pcie-power-on-gpio {
> > +       reg_pcie_power_on_gpio: regulator-pcie-power-on {
>
> What about removing _gpio from the label as well for consistency?

change label also need change ref's place, look like it is not neccessary.

Frank

