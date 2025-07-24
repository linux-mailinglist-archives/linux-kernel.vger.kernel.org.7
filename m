Return-Path: <linux-kernel+bounces-743635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01731B1012C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293B5585758
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD322577C;
	Thu, 24 Jul 2025 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Il7G5Q2R"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89021E9B3A;
	Thu, 24 Jul 2025 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340210; cv=fail; b=tFEU2O7DJC4nbRjZJ0VrcYUKoZq8DiKI0OMNRvgQFvv66slSkNC0ivxzh9r+ca+FNnTpPldesWDu2vG6bUAe+kHrknsiUk8nX5yxAicp+m4vVxKmsPArozrzPcNN1mey8mo4/kpU15h3Hj4A+4OUJLdRnxv0dCc14OFCwcU9OC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340210; c=relaxed/simple;
	bh=Sgb0VPvlMGHCx6o40trI6KuoRnZaEUDP0/JQcldUgc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dsWOLi3/FSB4StCrRdj9LNHWjSXYhmL83IwZHzKL4kEUHAuZqHVCA30fY46e/Bzd/7+kf7bdpQDt4d/x+S3sgIQ3IaCgmuoXpd4CEKOVvzPFPhgy3L53uLngglXlusIgsT/+mfdNrvNJN5HUb0J094jpwn3/e0K3+YyssctuJng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Il7G5Q2R; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuBKlwQm5ZBLhASpR44RDaYibmjEIcmPty6wtB4VcuzPknjzfTQhJs6StsY+UH9HRxfZV6rlss1LiCAHM4bXR5wjSpSeHF10caGIgzL/2MHGaAyJtkEiuvna3kQW1TstLDDZGB/PETQSFLY/mFdvvdSwobvEyq+TR1lxZzVmeVtF4lglHDXeqsgLZcwEzJ2w82/Z2EYN7LqKR4IWOPjN8ALvoz2pHM07ege+NP7eweiSW8u08ALHJ/zQr/2K8AbVUOZ7wF3BlH9krX/os39tr2NBJaAl1IpjlhULsvI3rf52O2J75mnvkHddbqMnZ9lZOZqrE7TPoGaIoWt6eB4Qlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gj/e7ulgv3ZoKor8yjXfarVIPsOE45X/QF/nqG4Iw9Y=;
 b=jzYLd+S1ML45tKqgfGoxc9WioCyB+k8+bKO3tInbK4J3ocwn1DhISfLj3XG4hjoCebHitV1ftOIMTRVy424YS+sr1cSElIMUSHouDBLCvcwZitY9bAAHr7kBq08r6gfjunh5xX3MzAu3vohHkzh6pvQen96wL+SCQT6VNggGNgaT/rktJBeMaQoiGJPldwMKDCqx4wnHbjml9g8VSBQP1WN0Or+8gYd3t2mt3BNJUgNK/Vy4crR/7HF5oxnLEtiQxN7NQeaHvr/nW4x/v8oNZnO9mBP1Pvnsr/Gw+vhtMROGhss3mZKe6cWkmrWCOGl46/DwGLDCjakF0325kCg/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gj/e7ulgv3ZoKor8yjXfarVIPsOE45X/QF/nqG4Iw9Y=;
 b=Il7G5Q2RJ/jHZBLdomQpSOOcmEJRV1N3+5Epd68IX94nyBNGbsklUbDQFs7cVT1/ZCHfV8Z0mOGzLwBoOuSsUc1k0tBFCW6EsPGmA9oFzn+6R1Kr/wf3rBDcpR+TTkeGLfC80lQ2d7ggGs71ep6hE6VsvwGvmR80H4C+XEzsz7QMPGOk/Rc8bp8BF1VHJlZ3BrSBVv5di4YmXR0U8PWtZ0JKlyWN1CZU4l8/76Bfzgj8paEOi1Kuve+COmVfl61dYCXdjPnkX1omUpZXEBtVJT7APhcEc7u0bE1CUvaZD6LpEat567oGcEaroLI0W8DaQai1GXTcCX0glC5jcRRusg==
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8722.eurprd04.prod.outlook.com (2603:10a6:20b:429::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 06:56:43 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::c2f0:1b5b:c653:b24e]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::c2f0:1b5b:c653:b24e%6]) with mapi id 15.20.8901.024; Thu, 24 Jul 2025
 06:56:42 +0000
From: Joseph Guo <qijian.guo@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Robert Foss <rfoss@kernel.org>, Maxime Ripard <mripard@kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Jonas Karlman
	<jonas@kwiboo.se>, David Airlie <airlied@gmail.com>, Andrzej Hajda
	<andrzej.hajda@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ying Liu <victor.liu@nxp.com>, Jessica Zhang
	<quic_jesszhan@quicinc.com>, Thierry Reding <thierry.reding@gmail.com>, Sam
 Ravnborg <sam@ravnborg.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/3] dt-bindings: display: panel: Add waveshare
 DPI panel support
Thread-Topic: [EXT] Re: [PATCH 2/3] dt-bindings: display: panel: Add waveshare
 DPI panel support
Thread-Index: AQHb9iB2JvnnmFHDH0+Wvm3t4DReZ7Q7pekAgAU9vNA=
Date: Thu, 24 Jul 2025 06:56:42 +0000
Message-ID:
 <DB7PR04MB401079D15E5B4E93EC9DF994945EA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20250716-waveshare-v1-0-81cb03fb25a3@nxp.com>
 <20250716-waveshare-v1-2-81cb03fb25a3@nxp.com>
 <175305199815.3017932.12028214384187991932.robh@kernel.org>
In-Reply-To: <175305199815.3017932.12028214384187991932.robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB8722:EE_
x-ms-office365-filtering-correlation-id: cfa96153-5648-4bb5-bd0a-08ddca7f3f3f
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TeU12DTYhAFdydg4XJjQH/+nl+b1NltW7QYkq1GoAtc1rD3L9xFp1ZKEHoN9?=
 =?us-ascii?Q?GbzyvJhhdA07spQAqn5wUNx3P9gEeFro+bT0uGGOKf1c+EOzxnPzhS9ygvA7?=
 =?us-ascii?Q?h3jzjbXNSoycC7qFLz3aUELDVpfesnykn7ZYgM63MxyXhBqG/ibmxFluQHXm?=
 =?us-ascii?Q?8ynVCRyS4J8zFgvIKfWr7//vPb08Wy9txIwAGPoLgTQ39BRo4H1E9MtyTJ4i?=
 =?us-ascii?Q?pfa5p27Nu0kgN2uXvd2HgiVYxhxc+sUw6M0EDp25lZXbmvu+rUHLGGp94JVb?=
 =?us-ascii?Q?P9HBvX/MH3GMoJ6G/itrj3+IqNfjDCVjdVIW7wHuxW+IQK52FLufr6BMeeEr?=
 =?us-ascii?Q?JESMTNswStxkNHO1hOKi/kGToP4SyjtcXasq1REQs9Hwvtgiy+73D8uRip6P?=
 =?us-ascii?Q?ln6JSHSHRL92UTwc6ho8gAtT4OGBFBn+9PWWVuMNBxlOwWfOehed0MzPReOB?=
 =?us-ascii?Q?XB4A+bGCVX1sADiKG+OaSEWx6af2kLbU/CgEx1Ij3PhE7parKI7HOT2w+UI5?=
 =?us-ascii?Q?pBCUWE81Bunt76v0Snn0YnPtqghwpgx4yplMFjPY4D/v3KbNzSOIJ97i19NO?=
 =?us-ascii?Q?tItoSBRqWYOnV/Mf/5R7RMcQG3CANd4ArEnV7CZz4cQd3o8x+t2wk86KEsX6?=
 =?us-ascii?Q?ks6BYrmkL1H/dhohLnDt4uYHvwPhKJHn6zJnkUiLG4v/DTttGzeNuM4AX6Gy?=
 =?us-ascii?Q?kKNloLDS8eOa3fgV82j3ZTmABjBOoSMCICPTi07VhUSPf37v2Tfs46grt1ri?=
 =?us-ascii?Q?t5ZaftuOUGrIe6ltxyJvqX7dkkq/Pl6Vxp9gU+j3OIHvhnLIHEOvyZY0K+7q?=
 =?us-ascii?Q?6285XR8VS9UBRLCKVAyOUcJW5Q8SPmtkhM1fqC4qZL0NqnR8s6xnCUMiNXRo?=
 =?us-ascii?Q?ZRFj5vCY65vyd4DmOCuFB6fDDlr9XscGmuLMq/DzlgGH03b7oONNOuF4HINg?=
 =?us-ascii?Q?8EjsDQJJ7OOs84lwx3U41f4eEtDLlQ7a0/thmZeIiw8d+9si345TSrKYjQSx?=
 =?us-ascii?Q?ingJT3YBw2b9FjiAt+vhuzTM0BZ18UyyZUeAbj4hc2zUAfe4TQ3evjLs90tD?=
 =?us-ascii?Q?cOg44MVm2WLgIB+Y4/j4/dRSSx9UXafxJ6EyaInxikno0hSM9XHqPBSddFZ3?=
 =?us-ascii?Q?rGEYDH4uQob+cuTXr8EL+pFGfR06PFAwQdSBXgm9XUWV7/inGsedYpONuWL8?=
 =?us-ascii?Q?aOFhn1DqFzXbPwDyu3QgFtmYRQ4IiizDo/Wu1jwwqaD58XPFiVuDW/KzBmKX?=
 =?us-ascii?Q?lF/2A0ZgFNt3srAl6QBdN66ox9uDOkwx1W/gTJbA+px8kybLls8r90qmIodm?=
 =?us-ascii?Q?YbWm1rhCYAtOK/Wz2mTMZx7lFxckosHi43ZjdrhuoTdfrb3O47TAlgq1XbyY?=
 =?us-ascii?Q?ClC/ODD96DcH3L3BNH8oyxg6Q4IFIyCfMAGUuVIL7fuqGiuE+PjRhsyJ0/LJ?=
 =?us-ascii?Q?B42+G049cGeUPParGgRckyMYtblDNm7VXIO12/26gptVahp2AFaSSw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x1OkPaVUmASiL6qA0dZ8U/TH3Arq+Ki9k9mus94SEBm1ebDOdL/0tvDKa9Oe?=
 =?us-ascii?Q?b/+4hzjvesZW3zW8faaeTsHYFrnb7ojA9Hqmzs9MyOQZf9y7A8hgdyiHvzaQ?=
 =?us-ascii?Q?Y++IHcq/vZPgphHe+wfZgSlR8zPjwVvJmqoLID44veSK0+CKsnA/d8Wh8k80?=
 =?us-ascii?Q?o3nd0oT15uqG61YlRTiKLkx/sPCHfAGRsZvqU0+SZSXKHOrAUOtsMqOSh0Q2?=
 =?us-ascii?Q?3WlF+8+foVg1oqWrVZO7JzTZe7fVN+D+8HCtUi8j3bWIwok0aqL4ef+WaHf/?=
 =?us-ascii?Q?6DJY19OOnRixThEqIwKs6Uy5892GHdmMDednlSD4BLtE2CY1uSL7zUjotl6t?=
 =?us-ascii?Q?pgSz6SK9q2/i8QvnVdzTHG8BWheWlydmw53BvDt7zd3GADiIU6r6w59ZFIHN?=
 =?us-ascii?Q?TfEkMwxBuV8BeadOfuJII2xUFmrTj6SXPIx/P1WR66q/d5y9JCcLvcbK7M5t?=
 =?us-ascii?Q?nB5iGnhRMtTrc6xmdbjKGqZ9kSNHMi/WklGPoe7wB7G/C5IbV0cuYFaed2Mp?=
 =?us-ascii?Q?wtfIxcdFNmFjql40e7uo2J+jK7ynzdzznzIcttaeXqcsb7OhXLdMwA1tE85g?=
 =?us-ascii?Q?BYQvn7vCIxllfYnTLCY45FRRDq3LkKU5nVxqBwFEzqkpSvBgT9oCT/9MDBRg?=
 =?us-ascii?Q?X7lsqv6ljx2ApRBGXDzdJZRoGMHKp81mBALNsA5MUaeQO7y4Mutl8mnvuY19?=
 =?us-ascii?Q?2AfUPI+I3AAQAceQ6iw0oXU2j1HICJrpyoWNQWXojAyPyAvOYiou1Y3IDjoV?=
 =?us-ascii?Q?bITpISnHslRPyNNhgF+QzCM5Bb5OAMsx90D9KeXucJGrQUb7r4VZwQ6I4hXB?=
 =?us-ascii?Q?xD1dciGLtIm8bJa9Qw4XmVwLEvMt8cYx2EFsvIB8TQF0c1nAe+nnqa3UA1ay?=
 =?us-ascii?Q?GNJXI//UMG7b2Bv6DiZjZFlVSu+CHfKkozbEiuPYaHtO+CsDaEBdUmJ7zXov?=
 =?us-ascii?Q?Wuwut4BAZF6o58X8lPU5XvO/NQuyPTo4ltglSm82FsoUTFVKYaEbvdkqWgOF?=
 =?us-ascii?Q?XinS04ANxmW0HdXGN2KC44WasAp+r3yNdEPFIMtxrz7ePoY5JGTO2emip/gK?=
 =?us-ascii?Q?saiRCg57XKYNFpqrLtpRwpVdYKe9kZ8lKFQJ56e5hO6UkoxeAAnJ5oON7ZLE?=
 =?us-ascii?Q?iGgsUiiVENo12hgDQDZhBB1NRWclWH5kUOrIM916I45oB1jhKpfLhV+jcyqt?=
 =?us-ascii?Q?o1K8XnXXSh/U1ScVpheIzGX3aaa71aQE2nA9gZzrzhR5i0Y0HIVC93G6RXbQ?=
 =?us-ascii?Q?az+0MHkeYxvECf33mMhhitc9aMwaaidb8GSNrbe7ee1uMhmz8CqFR0RxAZzC?=
 =?us-ascii?Q?50jRD/Bxo15v3NuMWaf3jCM8Q6Xs2thzKF94lIQr1cZ+yul4an0Ke6BLDkK9?=
 =?us-ascii?Q?l4SuWAGJDBhrUGIcHnBavuVsw3MYysXU4SOUC4UBJl6SeoC8Fe8prStC3/eG?=
 =?us-ascii?Q?s/NdN1BmUfeN8Fwg1Bc6kD6YfN9yQ4/NMY3YbXBAAkJNLF2dS9X/hxF6rDW5?=
 =?us-ascii?Q?JPGJ8Lvk4OB/kUmWlMtA7h4IKO8a/ZzIVWNIv4eAbkbp1Z0iZbr7CXfqPrpq?=
 =?us-ascii?Q?52Vj0QDS2Sm1Wrrk8+Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa96153-5648-4bb5-bd0a-08ddca7f3f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 06:56:42.7014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odpcs7Ks1K9W2Trx23VCzVdlV+U50JX28dHHfYS8+9JV1drritRKMjy3tCkriGVT8M9CFUuARjf76jwojlZeBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8722


HI,

> -----Original Message-----
> From: Rob Herring (Arm) <robh@kernel.org>
> Sent: Monday, July 21, 2025 6:53 AM
> To: Joseph Guo <qijian.guo@nxp.com>
> Cc: Robert Foss <rfoss@kernel.org>; Maxime Ripard <mripard@kernel.org>;
> Thomas Zimmermann <tzimmermann@suse.de>; dri-
> devel@lists.freedesktop.org; Maarten Lankhorst
> <maarten.lankhorst@linux.intel.com>; Simona Vetter <simona@ffwll.ch>;
> Laurent Pinchart <laurent.pinchart@ideasonboard.com>; Jonas Karlman
> <jonas@kwiboo.se>; David Airlie <airlied@gmail.com>; Andrzej Hajda
> <andrzej.hajda@intel.com>; linux-kernel@vger.kernel.org; Ying Liu
> <victor.liu@nxp.com>; Jessica Zhang <quic_jesszhan@quicinc.com>; Thierry
> Reding <thierry.reding@gmail.com>; Sam Ravnborg <sam@ravnborg.org>;
> Jernej Skrabec <jernej.skrabec@gmail.com>; Neil Armstrong
> <neil.armstrong@linaro.org>; devicetree@vger.kernel.org; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>
> Subject: [EXT] Re: [PATCH 2/3] dt-bindings: display: panel: Add waveshare
> DPI panel support
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, 16 Jul 2025 16:08:30 +0900, Joseph Guo wrote:
> > Add dt-binding documentation for waveshare DPI panel
> >
> > Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 4
> ++++
> >  1 file changed, 4 insertions(+)
> >
>=20
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
[Joseph] Thank you Rob. The PATCH 3/3 is not reviewed yet. Could you kindly=
 take a look?

