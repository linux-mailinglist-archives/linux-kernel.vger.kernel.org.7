Return-Path: <linux-kernel+bounces-810128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF58B51654
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A57487ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10F0285CB2;
	Wed, 10 Sep 2025 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reversec.com header.i=@reversec.com header.b="MnZkMl91"
Received: from GVYP280CU001.outbound.protection.outlook.com (mail-swedencentralazon11022107.outbound.protection.outlook.com [52.101.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922EDF72;
	Wed, 10 Sep 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505671; cv=fail; b=S2/ZPLzBREcyoSItFgN+kX5GQonn1amtNT9WP5biThfXrB3I7C8Vr/hYvU6pCjJK7eMTLvWkBRM/Mkn2u2b9k4LMfFAe2/asH/vD+2dHh89mBW1iteZ4Kg4rliaCB1WEj+VI40U3dSpVpGw3zLAm4oUF0w0yS/5FwzmdPcTIbak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505671; c=relaxed/simple;
	bh=kYmAK02XNFiziBaa9V9jvcM408MPA95dd7Awgc5KxXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AcVZL9hfku2FmT6TwiWHCnZRCJ9eNiRqcgcL8Lwv2VE8ZtxqYicM+4s9Sdwi2c/tg813/IPBOr2kKP4VnWK7A5lZ6I8ymDgIT11oIgdSE373UBNjV4CptocCRNY/Ta4WDkgDrErvSP4D6Jtm4E2jVvoPhFHDrHg9fXL3wmwQI7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reversec.com; spf=pass smtp.mailfrom=reversec.com; dkim=pass (2048-bit key) header.d=reversec.com header.i=@reversec.com header.b=MnZkMl91; arc=fail smtp.client-ip=52.101.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reversec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reversec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLAvejtwlkwElqusAC/K22cD78AS+vFQ4c8GDJzx36d8M7lXpa+nMs37NuYHHToWetmvq77kRhwGYKROaflCABtw/hEQWjh4x78aLvhYJDqXicstmv5dKweCDSEQuFLPRTOjWcHpCaxn+tqyfCu8nVrl3Rh5rvn4brBbXzTua/Xs2+MMn/xuuXymqt28L4kJ7GqbnAXSOZdtC+wHLe7v89KlP4vdKGtGwrvg8XrErSXnmoHxbU7bJSDHBRzq+yFVxsKU3zOY7O3oHYQDCTFj/zptEy45uYw496ndQ+qVCO0dkkyR8xKGhGNj9X65AcAlsPpLzcZF2rHSU+w46FVotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYmAK02XNFiziBaa9V9jvcM408MPA95dd7Awgc5KxXA=;
 b=o41/Mg+t9u3sylOQNuzc8WBc0z6XggIWZ86KiUk3f+iOqXBIR7FNuEYwMxomuEZdSEaEF+IjkqPhnQfT4cjjs5+sgwVXbvvtKk5E31QfWW5ukc/vP7pgfyVBy/umB00VNfjESsYNHqRFyx3jzcL4BSBOqALRfoAzMXIwhiIGSpr7kU1utVjSNPUy6v7IBsJgL+GEXZfm+mR5lO9+P4vueDXtnv38n20zHxrMACdippcaEgf2P9NuIJ0/ajEhSCn1eMJ0+99BLtrzWr4vUOC9l3nKR4hfZan6tv+ecl0CyEfQEA9iM8w4zcwylTuWQ04nH0Vgcp84Gwu5Isti+he/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reversec.com; dmarc=pass action=none header.from=reversec.com;
 dkim=pass header.d=reversec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=reversec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYmAK02XNFiziBaa9V9jvcM408MPA95dd7Awgc5KxXA=;
 b=MnZkMl91/WI2sclMaishO7O+8N4TdnznwI3T03+ebCzOr4kzhUOuhnjpILBLoUqYelzbq9DMO28eg2upWRKWJ1LGnImkFbLvpUketgDgj+rBRGUHFYCopQ3dZ9LjLp4/vK4mD5+70aBKSWlOJNSNXQ9MdL1QZgW4Ta1LooHLarH4DqvzPUbXlYj2JrkPnSNR9xD1zExTuunR0lwZx8/YxoWKyG5djCZNe8v+/4rw7rMgJmD70DuSLygbI9DVXUGenwCEseQ3xDY12L3/7DrzNlf8ZZOFL7qjR7lEvIdIeQYd37yqwc7B5ViiuCfK5VCxRGBRM+/97kcG27/wFLMOrw==
Received: from GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::9) by
 MM0P280MB1076.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 12:01:02 +0000
Received: from GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM
 ([fe80::dfb5:ad6c:275f:bfc2]) by GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM
 ([fe80::dfb5:ad6c:275f:bfc2%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:01:02 +0000
From: Andrej Rosano <andrej.rosano@reversec.com>
To: =?utf-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
CC: Andrea Barisani <andrea@inversepath.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>
Subject: Re: [PATCH v2 2/8] ARM: dts: imx53-usbarmory: Replace license text
 comment with SPDX identifier
Thread-Topic: [PATCH v2 2/8] ARM: dts: imx53-usbarmory: Replace license text
 comment with SPDX identifier
Thread-Index: AQHcIaFEZqmmxaguvU67FzG2IA+/d7SMUeSA
Date: Wed, 10 Sep 2025 12:01:02 +0000
Message-ID: <aMFofaIczqElAsLY@stjenka.localdomain>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
 <20250814-imx-misc-dts-lic-v2-2-faff7db49a5f@prolan.hu>
 <b48844bc-07f3-4fc1-8486-8968bf6d2362@prolan.hu>
In-Reply-To: <b48844bc-07f3-4fc1-8486-8968bf6d2362@prolan.hu>
Accept-Language: en-150, en-DK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=reversec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVYP280MB0715:EE_|MM0P280MB1076:EE_
x-ms-office365-filtering-correlation-id: 2d74a964-229d-43fa-dc2d-08ddf061b683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?alV4RHA5T29OdWZ3T1U3Z25rYmtxbEtPVWhGeGJFZWg3Uzg4cjFvd0JEZDEr?=
 =?utf-8?B?K3lUZVZrSTRRcUdOaWRDUTdhS1Uvb3BJK1I3Mm5rTlRLZG11NDVFOVhzU0Vx?=
 =?utf-8?B?a0t1dUdRNDYzUnJqVlNLZDlOU1lkMjc3bGFJUHV2ZExFTHVLUmFjYnkvREUr?=
 =?utf-8?B?Q0xZemxxazZMWGhCWURzMW1QUFJscEJub3NESzNLY1lmdmUrVGNiTTk4dmwx?=
 =?utf-8?B?RnR2cExtbUcxZlBLYzFuTnZVREVKU3Bka1lPMFFKUlIrMjB3aGlLNmx4NW1K?=
 =?utf-8?B?Skh6b3BiVWdPV00relVKb3puTVlkaGFhWGYvbGYvdXJldG9tR3kydDRlYXo2?=
 =?utf-8?B?RVlSTlBNUm5Lem9MVCtnSStFWWhBWVhiWlY0U3ovRERucGVWclRyY0E0Zmcx?=
 =?utf-8?B?c3pDQ25KMkJRcGNTanQ3d1FCaHdrT3hnUlVXSERZUXF0KzBNRFhBK3pHdlQv?=
 =?utf-8?B?LzA1Z051VUJyeVBjTzNmQk9JRHRDT1pwekczYTJmdHYrM0UveGdlSUFWSi9T?=
 =?utf-8?B?WHBnWEJqSEl5cC96bGIvZEdkQ3VaVFhMcEJhNkxPK21Kc3B4OHNzQVl4aVhE?=
 =?utf-8?B?TjFKcGJob0Q4RmVtaUpxMUx2dEdpbEZBSHkwZ0pmUGZkeVVJbGJ1dkhmMnJJ?=
 =?utf-8?B?VitiK01qSkthZXNrbG5SZmxremtJbUdObmhzMXpCY2JmeWVMMExQUzh2aWtY?=
 =?utf-8?B?dGVqQ1gya1BXVCtHVlpMbEZ6R2JnN2JNZ3pvc2kyTGNxcEdLdDBtbXZ1U2tX?=
 =?utf-8?B?dGVvMis0bmdZcnNaU1FIT2xicVl1TWcrcUdaNzFpK0tQeW1CT3A2N0liVW92?=
 =?utf-8?B?RFgvWHJDSmZSOEUzVjF1ckhsbWt2ZVY3eHc4UGdib3BiSXE5ZFNkOXNuRm16?=
 =?utf-8?B?MWJyZmxiajBZUDRURGhnNWw5ZjhHZjdBUWJ6aS9LVTU3Qk42WTFKSFVLNkxo?=
 =?utf-8?B?bXYrdkhMUGxldmtWQlFuNUZUR2kxUHBwQnZTdHp2OFhzNXdlNlNTWkRodi92?=
 =?utf-8?B?aXdiUXlaUmhwNFpiMTJzZjh6dGsrS2dHNW1DNFZHR2FmYzhuN2YxUVpEdG1G?=
 =?utf-8?B?ZzdWVEFBZ2NpUllxK2ZDNnJWa0ZNTGRxcGhqVU4rSWJEVDNJelNCd2o4RDR2?=
 =?utf-8?B?YmkvVVhWZW1WQ000d0NOY3BlZlAvU2RSWisyekwxaG5nRWNZQ1IxRGwyeG0v?=
 =?utf-8?B?NFVyOWZSTzZmWTZLTFVFWVAxVGRvMUllNVFDTnVzMTJmeXR0UFF5aEduWTNs?=
 =?utf-8?B?Rk5sTngrTHJLb3dGMVpGblR2L2djN3VZNGRLUVRmMm85RVBtMmVkTURBNFNz?=
 =?utf-8?B?RHVJSzFPVEd6NEM1dGJvaE50amo3cFkrdUxiYUkvOVZWMzBvRTFFdncyaFhU?=
 =?utf-8?B?d3plUWYwWXVXYUJIOTI3UXRIak1HNkFmb1grcGpZN3hET2RIS1JsT0JvMzFu?=
 =?utf-8?B?NkcwUUlmT3BpcUtHSkorRVdpREJ4UjJibWoxVlpVR1lzNDZaNmUxNnl2NXI1?=
 =?utf-8?B?UnhDS2VMMEg3OEhOenVXMnBqWFE1V3VMTnYwQllaclFqZ1lkNzBlSGhsMEht?=
 =?utf-8?B?djJvNWpYcTFIdWRJVXIzVFBEQ0dTUUpzU2x5WGZobitKcUp0bUJFemp6dGtF?=
 =?utf-8?B?eDEvWU9WU0hmTlhEcWcyemNuYkVEL2tEN2FjT2J1elVYdVRNNS9hM0g0TGVE?=
 =?utf-8?B?RXU3TStUMkxPOGJrWU5VdGRIMlk0cXVzTVJPbmdjTDdiTUFndXVFVEJxY1ZD?=
 =?utf-8?B?WExZN0FZdzA2eDVFTDM5cUV1L1Y3TCtQYWZpcStiNUxrb1RNcGJ0cXhXMjl6?=
 =?utf-8?B?Qk5CYUtBVHpzRFFTL21icm45T2dUL0VzVDQ3OUVSVVpvNjdGci9hV2taY2hG?=
 =?utf-8?B?UUk4SW9DaExncll3LzBtTjYzbDE0UU92aDl5SWp0ZGRBQURzVUpJSklxbTN2?=
 =?utf-8?Q?pGXWwxDtnko=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVlHZXVJZTZTYUV4azNJVTRlMklkU29yZkJKZW82QU5lYTVVRUJCQS9qanVp?=
 =?utf-8?B?V1BRWWNrYUZ3RlJwMkZ0UHIzeVpmc2FOUEMrSDFzWXJtK2JmVmZISXJ4TUFM?=
 =?utf-8?B?V3cvdVlsTlk5bnF5djNWa3EwTCtKYXdYSUFDa2Q1VVA5TmxVenBac0hEVGZW?=
 =?utf-8?B?UmZQRkFxSG5nbjhIc1hTZG1zdm1sYThOSEJYQ3BrOVhBTXkrdVdsZy8zSDhq?=
 =?utf-8?B?RXJOaCtTcGptc0NRZkg3ZEJLSkk2SHE4Zkloa0JBUURaUWdtc0VNTCt6OUJU?=
 =?utf-8?B?V3NxMVdvWmdDelBiZlRkbjA5TGpjSFI2K3QxOUdtVEk2Vys0T09EdDFBZHM0?=
 =?utf-8?B?T2UxZmRoZkVkV04xbGk2TUIzaXk5WndNTDEyeGI4aUZ6VWpaYVlPajRqVG84?=
 =?utf-8?B?UXp2RHd2Ykk5NUpqRkxqQTdkVjFBbEJGN2huZnBJUlVjQjFtUDQvczhyUklD?=
 =?utf-8?B?UC9nOXBvMDZDbC9vU3VUWnlQS2FBaDdSTFVCUEtCcTNjUGNTbituZGdtU24x?=
 =?utf-8?B?Si9OeGd2a0xXQ2N3MVRvdm0wTm9EUnFpZm1uS2FVc2dnZlQ5MkFMUkxIYnA0?=
 =?utf-8?B?Uzl3UnhIRE5Sa3k0aUpOTmR6aEUrTkhQR01FZk8yR0cxQmc4dlJ2dS9aZ3Js?=
 =?utf-8?B?RXpiVmt1dnk3UWRHK0tqSWpjUkNlZDBtSTBvSXFmZ1JMM3pwRDhKZjNXK0NC?=
 =?utf-8?B?VEtIUjE4TDBVc0FWUXJ5MUR4YnVUU0dkc1B0eE1MMEhsaEVRYnZ4bW9FdHFH?=
 =?utf-8?B?ZGNZcGxwaEFMUFByK1d2cSt4SUFqendNQ0REN1hlRXdJWjNsVHZDM05BeFdY?=
 =?utf-8?B?dkQ1aWo2cHdDZHBuL05MYTcyN1V5Unh1anQ5bkkxLy80eEphU1BlZlhlUXl5?=
 =?utf-8?B?cDQ0QmFZU0JqVXRlTEF5WE41RDloRk5Ncnhwa1hjcmhkZ3ZoZ2xiQXhFMW1F?=
 =?utf-8?B?QWVQMFhMd3RZV0xBQ2pyaTl1QTdtR2txWUREdVAwMVF0ZHBsOUoyREFISDVa?=
 =?utf-8?B?bjRUeDdyNENqdUhaemRPRG94alEyZlFGOUdiOWN6bEdab0tzMTNvSkFFa1dU?=
 =?utf-8?B?Mko2MmZtZE9LcTBNWk9iREU2dEdvRHIyNkZQWVJsYlJ0YWJoMGhNYWI1aFQv?=
 =?utf-8?B?V1kxNTVqT21BM0lEM0dIVU5wbkJ2anJHdEQvY2MvRzZqSzFJWGlWZ0NSRERI?=
 =?utf-8?B?QTViNHhwb1BSMjI0Q0xzbGdvQVhHdDY0VTNGU2wzZGRMeVo1dDhPM2dCR2M0?=
 =?utf-8?B?Znd6UDBSc3JoTmpESDA0ekUxeXg3TXdtYnlzM1ZOand3Rk9PS2dkTE16d3ZL?=
 =?utf-8?B?VzBJZTVMUUR3c0VjaHNqQzQrTnpMb2ZURnlrdkhpYldsVWRzU1VpL0lNRE5a?=
 =?utf-8?B?S1J3NSsySnBEUHVCZEU1aVkyRStzMEdMS2h0cFFNeG9xQS9TV1JidStZdFQ5?=
 =?utf-8?B?Wmo5OUNFTy9SVloyOXIraDRXMHZnTmdFcTkvZUR3RlErcjlwNHNQRlMyVjVR?=
 =?utf-8?B?Wm10YzYyd0pQcXFJbzRPTGUvUmJoT2RJNUh0dUtTcFl4UVU5aGcwd2d6UlIy?=
 =?utf-8?B?V0NZSlNoV2Z2M3NkaEl5Qyt0bSszYWQ2Y2c3ek02TUwzekRSQU1MWm9EYmxO?=
 =?utf-8?B?ZGx3NU1LR3ZHU2ZTWDl3b2c5M3l5VVNBd3J5cGcwMjhDU1ptd2czdWNkZ2pj?=
 =?utf-8?B?MzdQTyt3VXNWYTJZWFRuc1FzZUpTM0RYdE4yK2d5RGtFY2pwQ1czNHg2Yndy?=
 =?utf-8?B?VTNrcEY5OUNKcHVjVjE2aWFMS2lIcmxSeDl2UmticHpwcG82OFFEYXBvNHhD?=
 =?utf-8?B?Z0w4Z0NDdXRBbUNBYWdMQ0N0NlBTR0xBZzM3dkVyeFBxbUdnS3piY1JiS2VN?=
 =?utf-8?B?OVh0NGRYLzV1NnVpZ29uL0h4a0htdVpPbDRIb0VJV0lEeXo2WHhWRy96cXQ3?=
 =?utf-8?B?RDBoNmkvRFoyUm9SQk9IOHlML2J5Q0hkbmprRGNmV2RTUURWQTlhZ1krZVlp?=
 =?utf-8?B?ZkY5S3ZWZ1Q3MVZIYnowTGFGZ3V3RHU4cTZucDV2RkRkQ0t0QlVFT3Z1Yjho?=
 =?utf-8?B?UFhzODV3eHNlMzZYOThsYVg5ZUxiWERwVUZWK21nNk1jNWw3c1B1Sm9WeGk4?=
 =?utf-8?B?RHh6MzBXMkpjNXpHS0RxZ3BTMWZsaXhUb2JvMkZsckYwb0NDaWhac2xIQ3Ew?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DEC2F8D9F23F94E84F4D8440A6EC0B3@SWEP280.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: reversec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d74a964-229d-43fa-dc2d-08ddf061b683
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 12:01:02.0962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea33927c-14dc-4a64-9482-d3df5ef087b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cOnWSP7AJvBdvtJpVe8FBHkncnm0aeUjtCBfnX1997FDLAKEnglKDsGDxuf4KnYp/JJEj8FMCJmXzs3tQEzyo05wbtldLtnAXs5Z/owKYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB1076

SGkgQmVuY2UsDQoNCnllcywgd2UgYWdyZWUuDQoNClRoYW5rcw0KQW5kcmVqDQoNCk9uIDIwMjUt
MDktMDkgVHVlLCBDc8Oza8OhcyBCZW5jZSB3cm90ZToNCj4gW1lvdSBkb24ndCBvZnRlbiBnZXQg
ZW1haWwgZnJvbSBjc29rYXMuYmVuY2VAcHJvbGFuLmh1LiBMZWFybiB3aHkgdGhpcyBpcyBpbXBv
cnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0N
Cj4gDQo+IEhpLA0KPiANCj4gT24gMjAyNS4gMDguIDE0LiA5OjQ3LCBCZW5jZSBDc8Oza8OhcyB3
cm90ZToNCj4gPiBSZXBsYWNlIHZlcmJhdGltIGxpY2Vuc2UgdGV4dCB3aXRoIGEgYFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyYC4NCj4gPiANCj4gPiBUaGUgY29tbWVudCBoZWFkZXIgbWlzLWF0dHJp
YnV0ZXMgdGhpcyBsaWNlbnNlIHRvIGJlICJYMTEiLCBidXQgdGhlDQo+ID4gbGljZW5zZSB0ZXh0
IGRvZXMgbm90IGluY2x1ZGUgdGhlIGxhc3QgbGluZSAiRXhjZXB0IGFzIGNvbnRhaW5lZCBpbiB0
aGlzDQo+ID4gbm90aWNlLCB0aGUgbmFtZSBvZiB0aGUgWCBDb25zb3J0aXVtIHNoYWxsIG5vdCBi
ZSB1c2VkIGluIGFkdmVydGlzaW5nIG9yDQo+ID4gb3RoZXJ3aXNlIHRvIHByb21vdGUgdGhlIHNh
bGUsIHVzZSBvciBvdGhlciBkZWFsaW5ncyBpbiB0aGlzIFNvZnR3YXJlDQo+ID4gd2l0aG91dCBw
cmlvciB3cml0dGVuIGF1dGhvcml6YXRpb24gZnJvbSB0aGUgWCBDb25zb3J0aXVtLiIuIFRoZXJl
Zm9yZSwNCj4gPiB0aGlzIGxpY2Vuc2UgaXMgYWN0dWFsbHkgZXF1aXZhbGVudCB0byB0aGUgU1BE
WCAiTUlUIiBsaWNlbnNlIChjb25maXJtZWQNCj4gPiBieSB0ZXh0IGRpZmZpbmcpLg0KPiA+IA0K
PiA+IENjOiBBbmRyZWogUm9zYW5vIDxhbmRyZWpAaW52ZXJzZXBhdGguY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEJlbmNlIENzw7Nrw6FzIDxjc29rYXMuYmVuY2VAcHJvbGFuLmh1Pg0KPiANCj4g
K1RvOiBBbmRyZWEgQmFyaXNhbmkgPGFuZHJlYUBpbnZlcnNlcGF0aC5jb20+DQo+IA0KPiBBbmRy
ZWosIEFuZHJlYSwgZG8geW91IGFncmVlIHdpdGggdGhpcz8NCj4gDQo+IFRoYW5rcywNCj4gQmVu
Y2UNCj4gDQoNCi0tIA0KQW5kcmVqIFJvc2FubyB8IEhhcmR3YXJlIFNlY3VyaXR5IHwgUmV2ZXJz
ZWMgRm91bmRyeQ0Kd3d3LnJldmVyc2VjLmNvbS9mb3VuZHJ5DQpCREUxIDYyRjQgNzAyMCAxNTg4
IDgwNDYgQUUwMiBFQTE3IDhDMzIgQUI1NiA1NENF

