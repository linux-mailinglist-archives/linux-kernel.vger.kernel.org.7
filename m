Return-Path: <linux-kernel+bounces-861186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D669BF201D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCA03B03CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423E237163;
	Mon, 20 Oct 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UPc+oniq"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF52EEBA;
	Mon, 20 Oct 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972950; cv=fail; b=kdzMWQl3i0/k98PlOersBVIKRxsPxMcWvYtm4gUfHSEA9RQeVuKS4wMIU7nLsh0KBVBxrhlxKo0x5BOKXK63QxZQXfyHBPftiUHWQVzRutGUr94EWqKDpH/FJfDo+/052Itfp8Gm1vuR6jfh45ytLk/zBVYpxB/wYd+4+0VmQ8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972950; c=relaxed/simple;
	bh=ETZJuCNbSkHKYv1rjz2xWpSYH4XkrPOVMRCQ/ijwHYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ayRqj9ATq0d72EhOXb9WuHazAYH9RGJLRhsxZ4w9nlRDByuU4e0tE+Od/bcLiiLiPZMg8054FfkhpfRIGEhmsYss30DITKBkTwjGpcsXSLPT724M2xS70qcg5VLHHHh0phqZ8vt1Ig81R3tfukCa7YjAS7Gh/VU0S2/9SE2k/kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UPc+oniq; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXzdC1nVwjTuAQmJsVtjI5lVlnTW/WJUrtwp3LN5h+NBVsRk+IUpf5ZiZc+VFZdrZ1oxpZiN4coF09mbYYwKvNbh4j/omRbyx0cNIggkaQKa2gnGv8HqAr/FINgugPYGfV3DL77cDdgarcOzumBpiYJPT9KF39F1XfRPMAMFP8DydGFlK20MJDWXG55CFuNodvpQH0pqHgJSSDF+2sIxOlao/1rJc6NY+OcwG5fWj60rSDVT75UOals0lIvhXFfJqTif7yFQlgWVJ+yjfudn8AXTFXGu96US7eFFauqpHfGaVGZRLVOaXD9B8pWaULq4lLp8ke8z6R3jJwmyGVKmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc9zluEgImfjGricsyEBAtYuL5VjnfiI3veaeHWVjy0=;
 b=cRpLUtp9KgwGsztd2Ttb2YyZFnbtbzQE5DlAEQdqh3sQdHldlvh3l+GZCGdUJKqW7jsYXiWEAxWuRB+aOLHRSrsFj73bamg22tPyEfcQKdLOaTTso1ReD3LAvGuFf1FjAKbJJAznhQrUX3QG4SYayF33AfGtZ+IVvj+GaYOmJtbUhJMnSKm+evgrdg3R4e1u+DHO3qHylrhrBIzuHCMa62XM/O+a1oVLcHOC6LDBCXKaw9kEm2CL/r4MHkMkAWw7c7V6IftS9hSG5M0pc0pFQoNoXQodSaWKfRJNDXYD0L9HGVO8FnLFv3z9L69TU4Rtg3dP/cylBKgBYi2joEDYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc9zluEgImfjGricsyEBAtYuL5VjnfiI3veaeHWVjy0=;
 b=UPc+oniqMm9T99mQP5cYUVnFzGRwomSvXmkR9WBCGabv0TQzAGH6QoeFRk2u9jSqGnRaAE71g8DomywW3RezZ8WNzTo/1CxZyQQ1nHbSGYrWQ4QwdWhWDfEZkXxgtGxwTVUbw8hNckdXgP/XptBzQihx932t3QC2ZqxIfNjhMcThQS60xsBDJfCAM2NoD05Ow1beNI9gTEcEyW1YUIg9efCoO1e8vP5YNztxK4WKu3Y6xuUFNcO8P01DnDfkZmT4kopeiAkmMC2GPp6w8OjhwQxv9C+KnlI3gCS1o0E7hOw3eKBtrYmO2+ueoQUcxwVJCaJjX56+iEQsIOiirmeSmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS1PR04MB9381.eurprd04.prod.outlook.com (2603:10a6:20b:4db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 15:09:03 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:09:03 +0000
Date: Mon, 20 Oct 2025 11:08:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 6/8] reset: imx8mp-audiomix: Extend the driver usage
Message-ID: <aPZQhdHPiqcx7Sos@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-7-laurentiumihalcea111@gmail.com>
 <aPJZCv+iG6cuxsj4@lizhi-Precision-Tower-5810>
 <7b4936f5-77ea-4077-94bc-38bb5c63f4c3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b4936f5-77ea-4077-94bc-38bb5c63f4c3@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::14) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS1PR04MB9381:EE_
X-MS-Office365-Filtering-Correlation-Id: e553ac6e-5704-48cc-2ed5-08de0fea9ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlVjUkRyekRPVVRsa09KY3hVSGpKTnN3MjJqQTMxRjRoZjNXRW5Tb1Rwdk5L?=
 =?utf-8?B?QkxLd0FGVkFlQkxpdG5ndTFYV0l1VmYySXN1WFlNdkdjQlk5R3RWVmEvWjF2?=
 =?utf-8?B?cUprRXJoeDRUeU4vL0t4bjZ0YW1sWkZRRW5vNFQrTk44UTgyK2NacnZDaEts?=
 =?utf-8?B?K0I0SEpMT280YVdFbWFqeFJzWGU0MW9vN2Z0KzdaMUExclJGQ2pGeHZKM0ZE?=
 =?utf-8?B?WjA4VkxRbmFTYmFvZ0hNeVU3TnBOYnZaakhNV3hVV01KWitwUWJnbFBzdFc4?=
 =?utf-8?B?QmNNbEljL3JwVk54dHVUN1hkNmRFaGNyL1k5VXpuaXk2MXNDOEVtS1dHV3ZW?=
 =?utf-8?B?c3l4bkNmMmVVdW1FTHZpZ2FnUUdIc1FoUVNrWWJTV0o3TlpwbUxUbXhDbnBN?=
 =?utf-8?B?WUt1aFB1SDFvN0tPV2YxK3BmZ2ZzS002UVVQcXZiN2JGTmpQemFIa2Jmd0NF?=
 =?utf-8?B?eU5QYWpwblBMSlZ3Z0Y3bHFEcDlmcmZ5REp4NzRwOVB3Zi9RTDN4UVJjdGxO?=
 =?utf-8?B?QjU4TEZLcFYxaHp6ZjY5RVU1ZExEY2kvYWJqZGVoZEVWa3FsN0xEZW1YWFlz?=
 =?utf-8?B?TE1YOEhOU3M2Y05veUJGZTZCQS9tdHZnMEIwS0FsV2VzL1hsYUFOOE1TZ3Rn?=
 =?utf-8?B?NDYwenozblNka1NpQ0kva0NzazJpSkVFYjBxTzRFR3dEb0VOeXp0TWs2OEFW?=
 =?utf-8?B?MFZmNllRei8wRDJxUHhZK2c0V2pPMjFZdUt3R1dQVnRRc0kyZ2d4eUJ5UXJ3?=
 =?utf-8?B?NDFIZ1EvRGNPUVE2QThHdHpJOHF2YVRoVnBKdVhCRW95Q2lnRlMydWVPVjBv?=
 =?utf-8?B?ai9pKzR0WGFiRDFVRWZXaVduWEJHMjY2RFZzckEyQjFFQmtMWWR0R2NpSDBM?=
 =?utf-8?B?dHJHU1ZEcUtKZnBoRkVMMzFpUDlzT2FqWlp5YTlnT0Y2U0JmdmhSeGJYcTQ3?=
 =?utf-8?B?aVN3b1dZSGxUZ1A4dUhjYkV4RjJnbUhnd0RQQ0ZLeHgvZzVhdGplTUlYUElV?=
 =?utf-8?B?ajZ1NXIzWkwyRnFuSWl5R0QxK0krZW1OaDQ0NVNzWlplOHpZV1ozSzJwbm1k?=
 =?utf-8?B?cmozZWlwQm10ODlVZG5nanZLV3MyeWRUSHNxZFdHaENYbnJBbkI3SktWRldK?=
 =?utf-8?B?RDRXeEU5ZW9yWE81SVV3M3VOSDV4UFlqSkY3YVk0TldpNDJLRnZrNFo2RW1l?=
 =?utf-8?B?YVNxSHZEa043dVByOUx3ZS9SOW1FQUR4RGpscU9zV0xVNE5SLzdxNjQ0Yysx?=
 =?utf-8?B?ZG9RQ0tHMldDVnV0NzIxV1A0cGl1aU5BMUhSbGdWaUJZQ1pmMGw1Wkhaa21E?=
 =?utf-8?B?Zis3dVZGZVNDdkg3WnloMXdVODVJRW9LR3hVSlZRTVpCWmU0cGlJMDhmNlB5?=
 =?utf-8?B?YXFtSkJqUmhiakUrcHFkc2N2aTlzUy93ZWdmWHU0bU93SzlrSzJNT2RqWjVq?=
 =?utf-8?B?NmliZHBSNVloNkJWZmFvcGdwRnZEaFdOVThyYXhPWFQ0V2hOMWNDbEYyZWJR?=
 =?utf-8?B?OUJGYzFOUEtHWXhFSXlvRDZHai9yR3ByUGRSbC80Vy80bEVyZVBzRXJETEsy?=
 =?utf-8?B?OTdINys3cEZXSHJhZzB1WjNmcTAxY3o1ZWYyRDc5QmdUREU0emp5b2JLZ2xY?=
 =?utf-8?B?d3ZoZWlYT3Y2MjRubUl3MTdzODBBWDc5a3NRN3ZNTFg0WWtURXBudXY1eXRv?=
 =?utf-8?B?N1pwa0c1Y3dQeUtScm5BNW9Ub1hHK3hKb2dmeDJ4QUFCSThvOG5mK1ZzcERu?=
 =?utf-8?B?OVJqZS9xNWp0ZXhDeTZyYVFQK2pOeFUwanFXVDFlTEpUSXpEZDF6eHVuaUQz?=
 =?utf-8?B?eFZaWmVEUEhsSmF1SDNGbWN0aTRYZ09UOFhJOW83L2RnTmZEN1hSTUcwdFFm?=
 =?utf-8?B?NGFxU2ZuS3BCbjhrbmFuemVhSXVvRHRoRlhSdnMyU2FhQm1wSVBmZEQrYUN3?=
 =?utf-8?B?ZzdWLzl1QkdPdXVlM3NqT3AzTkNRbngxYlV2S3dmYzBaTTdjcGRzUVh0bG1F?=
 =?utf-8?B?UXNjc1ByMnRqNVBna2ZmWmJ1VWh5ZXQwdThETUU4K0tjQmZlUnRmVTMyVk93?=
 =?utf-8?Q?UC+sm4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0MxbkJwU2g0NnV6aitETFhDOWIzelNtdzFhU1Rkc3BDNk51MTFLK1V6UzZx?=
 =?utf-8?B?WnhUTXdNTDVIelBENDdiaXNqR2xOS28zQlNqaktyTXpaV2RHS05UclI0TDNh?=
 =?utf-8?B?Z0h6SjZJeFFUQWlQN2crTTIxdWFjZ3hsK1VuNHVHZXZHNUpYbEhLSDFHcHVF?=
 =?utf-8?B?WHY3aHJxemVXdk1VT280OVFiQzhSQXFseVB5UVk0QkhadFJzUGN1UXQ4eS8w?=
 =?utf-8?B?V09XT2wwNzFXWUFxdlhrTXpDM2xoZ0REL0swS3FaYXloejdoeVZVaVhKKzR4?=
 =?utf-8?B?bWFQV2gzckxzcDdEeExmTkVUYjM5K0pYSloxMW1IaVlCWlpLc21PRDNrZ01Q?=
 =?utf-8?B?RkdmR0U1aE1FN3phTWRET0tuTk02RTJtZGlPYjhDU1Q4dVVBL2xKcy9uQ0Fk?=
 =?utf-8?B?blhlRnBYdnZNZVBybVBWVmJCU0F2SVRSVVhraklUOWhPU0FZeWQ2TmJzTTBG?=
 =?utf-8?B?YW5pcjROR2FrYXY4c2pBQ242WnJkVVp1UWxUVCtNcUlPQVBTY1BXb1hpZXI4?=
 =?utf-8?B?STRoTnhwU29ta21NUytOTVFhZWJMSFVZUmRQU3VPdGlFc29tUkNndytxOHVj?=
 =?utf-8?B?dTdVdkY1WmhESS9nMElEWXMwd0NHallVMGRQVTVKK1h1RVZVUmE3dlkwYW5r?=
 =?utf-8?B?RFZjMlM5M0s1RXB3NDhOOTVRQnUreERCQ1FQZk56UXlPc2Zvd05yVEFWWC9r?=
 =?utf-8?B?YWtzODR5UlhEN2FVZTdTWVZZRHRKWHVSNnVjS1lpdUk3bmNkQUczTmp4ak9R?=
 =?utf-8?B?U1V2RFNmWVd1K2JMRURCTkY5L2EzU1V6cFkvQi9vdTZvRGZXQkdEcjlKWWhZ?=
 =?utf-8?B?ZjNNbXNPR09XYVcvOW9qY3hrUkEvRHZwSEZOQnJBYkNDM0Rla25heVpNdG5a?=
 =?utf-8?B?UVo2MVBYaHZqR3RTS0ovbnM1UzZtNXRxQmc1SEdNRXBuUnJVa0l6aHBaMHJI?=
 =?utf-8?B?aCtoSVZkbkc4M3NwQWZ3c3NPcnVrZkp3Yi9HRE9oWU5EcWdqWEdXSGwwMHZm?=
 =?utf-8?B?L0pGR0p2MExJL0JQZUVsV2tFMGo5eVlwVjBHS3FCNlp1NzRRK05POHYxUE4r?=
 =?utf-8?B?SFEyU25vMzRrV0dQa3VMNnZOVms1WXlma1NGNzl5dFlDUWZHUWJGWU0yb28z?=
 =?utf-8?B?b0NzMkFoTHFJbFpzQkJxZStIZ2xzQXdUdXcyc1htcVlhWGZvQ1FJRUdTSTRB?=
 =?utf-8?B?WjlyU213SUdTYldxL1FDU29XeFNyUk1TQ0pFOFJIOFVVN3RudjZwc3lCTzlF?=
 =?utf-8?B?L1J1bHJtQlJUTjBCT2dXSWJ0UkFkdG1QK3dHdVlxcE1ZUnBJZ0lFeml3Y0lK?=
 =?utf-8?B?Mm9jQkZta1dGaDVpUCtWWmpXcWJsSjlmNzMrNDZNRW1BbE1tVkh3WG1lU2ZP?=
 =?utf-8?B?eDVuTHVmUUs2RXI4OVkybzY4S2JwVlBER2VMWkhxWFRXalhUZ05zRURJOGZm?=
 =?utf-8?B?YnZwT3dyRHFzUWlKL3ZlZGttL3RQRnQ4ekNWN1p5UTR2aXA4bDB0YjBUajY1?=
 =?utf-8?B?SUJpTjAycTJvMGRLU1MzYnR1WmFjcHkyWVdjTkN4QUMyZFh2SmxWZGJEUjEw?=
 =?utf-8?B?Qzc0NkhNbDZyYm1IYVFaTlo0UzZXRHp4clBmc2lyRzR5emNxMkpxbStCbllI?=
 =?utf-8?B?SUtZNkRpU3JaNCsrSzMydWdyN3BHWTRjb2o3d3psTUl3cDF6bmdRTnl5SXlZ?=
 =?utf-8?B?Mi9FK2ZPbmZZdW84ZkJVMUE2b0hVQ3g5eVZqSnZ6REh3RDdjanpmZlJTcTBS?=
 =?utf-8?B?K2VqWDlFM3RyTmFqUzFsUUh2VjlabWN0S1h5VnRER01lYXl4TlBZYmgwdXQw?=
 =?utf-8?B?cmhCSDRyUDBuNTIycXZoQkNlWnZrRzExNUltTjczRGVFamZjSHNuOUM5Rzc5?=
 =?utf-8?B?VDg2ZnR5MnhFZnR6TVhoTnhhbXpuWVJkKzV4MUw3Q2QxdGJqSkkwWWVKbWk2?=
 =?utf-8?B?SjlINTl1bS9SeC93anRlclBIOWd0cTU0d3Q3cll3akRBdVR5S3dSVDA4L1RQ?=
 =?utf-8?B?OHBrNWlMbGJYYlREWWZqNGNPVitDWDNQRjBZR0hRZk0vWGFEVURTbXMrZ0Jh?=
 =?utf-8?B?RlIvV0JDeW1vaksrNG5NbzB4VjZMZFp2QzZqdzg2ZGVTRTNCdkRSbnd6ak9u?=
 =?utf-8?Q?1XNs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e553ac6e-5704-48cc-2ed5-08de0fea9ad4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:09:03.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AheL3P+Sa/Y2hz8qTdiF01Fj37TiR8t0N6nL9RkmdzgUggPOke9Rod3ELRBRDIxybzafnTdV3xj504JcmNwFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9381

On Mon, Oct 20, 2025 at 04:59:52AM -0700, Laurentiu Mihalcea wrote:
>
> On 10/17/2025 7:56 AM, Frank Li wrote:
> > On Fri, Oct 17, 2025 at 04:20:23AM -0700, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> Some NXP SoCs integrate one or more, per-subsystem, block control IPs,
> >> which allow users to control the assertion and de-assertion of the
> >> reset lines tied to some peripherals present in said subsystems. Some
> >> examples of such SoCs include i.MX8MP with AUDIOMIX block control and
> >> i.MX8ULP with SIM LPAV.
> >>
> >> Some of the aformentioned block control IPs exhibit a common pattern with
> >> respect to the assertion and de-assertion of the reset lines. Namely, the
> >> user is able to control the state of the reset line by toggling a bit from
> >> one of the IP's registers.
> >>
> >> Linux can take advantage of this pattern and, instead of having one driver
> >> for each block control IP, a single, more generic driver could be used.
> >>
> >> To allow this to happen, the previous approach, in which a single reset
> >> map is used, is replaced by a per-driver approach, in which each auxiliary
> >> device driver holds a reference to a certain reset map.
> > Can you shorter your commit message?, basically, you just add
> > imx8mp_reset_info for difference auxiliary_device_id.
>
>
> yeah, but the commit message is not trying to explain the code, but, rather,
>
> offer a bit more context to understand WHY we're doing this. However, I'm not
>
> fixated on this so if people don't think it's useful then I'll just shorten it.

Not necessary to mention obvious facts. A commit message should summarize
meaningful information — it’s meant to highlight what’s important, not what
everyone already knows.

Using driver_data to distinguish between different chips or blocks is a
common and well-established approach used by many drivers.

For example: below commit message is enough to bring necesary informaiton
to reviewer.

"Managing peripheral reset lines by toggling a register bit is widely used
on NXP SoCs such as i.MX8MP and i.MX8ULP.

Add imx8mp_reset_map to the auxiliary_device_id's driver data to allow
reuse of the same driver for different reset controller blocks."


Frank

>
>
> >
> >> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  drivers/reset/reset-imx8mp-audiomix.c | 18 ++++++++++++++++--
> >>  1 file changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> >> index c74ce6e04177..c370913107f5 100644
> >> --- a/drivers/reset/reset-imx8mp-audiomix.c
> >> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> >> @@ -24,7 +24,12 @@ struct imx8mp_reset_map {
> >>  	bool active_low;
> >>  };
> >>
> >> -static const struct imx8mp_reset_map reset_map[] = {
> >> +struct imx8mp_reset_info {
> >> +	const struct imx8mp_reset_map *map;
> >> +	int num_lines;
> >> +};
> >> +
> >> +static const struct imx8mp_reset_map imx8mp_reset_map[] = {
> >>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
> >>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
> >>  		.mask = BIT(0),
> >> @@ -45,10 +50,16 @@ static const struct imx8mp_reset_map reset_map[] = {
> >>  	},
> >>  };
> >>
> >> +static const struct imx8mp_reset_info imx8mp_reset_info = {
> >> +	.map = imx8mp_reset_map,
> >> +	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
> >> +};
> >> +
> >>  struct imx8mp_audiomix_reset {
> >>  	struct reset_controller_dev rcdev;
> >>  	void __iomem *base;
> >>  	struct regmap *regmap;
> >> +	const struct imx8mp_reset_info *rinfo;
> >>  };
> >>
> >>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> >> @@ -60,6 +71,7 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
> >>  				  unsigned long id, bool assert)
> >>  {
> >>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> >> +	const struct imx8mp_reset_map *reset_map = priv->rinfo->map;
> >>  	unsigned int mask, offset, active_low, shift, val;
> >>
> >>  	mask = reset_map[id].mask;
> >> @@ -144,7 +156,8 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
> >>  		return -ENOMEM;
> >>
> >>  	priv->rcdev.owner     = THIS_MODULE;
> >> -	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
> >> +	priv->rinfo           = (const struct imx8mp_reset_info *)id->driver_data;
> > needn't force convert from void*
> >
> > Frank
> >
> >> +	priv->rcdev.nr_resets = priv->rinfo->num_lines;
> >>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
> >>  	priv->rcdev.of_node   = dev->parent->of_node;
> >>  	priv->rcdev.dev	      = dev;
> >> @@ -168,6 +181,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
> >>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
> >>  	{
> >>  		.name = "clk_imx8mp_audiomix.reset",
> >> +		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
> >>  	},
> >>  	{ }
> >>  };
> >> --
> >> 2.43.0
> >>

