Return-Path: <linux-kernel+bounces-885841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C8C34053
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 743414E42E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83944288514;
	Wed,  5 Nov 2025 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ai86mufV"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF0287506;
	Wed,  5 Nov 2025 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762322104; cv=fail; b=WCpXvCC4gDFEgXhv2KMCp+O0rPSa41xbF76dBhfqYY72kv301cHTkN6YDJQwJgxRbPf+ILz06O9imTKjtZ+Aem0TmLI0x7275exG11PHvsQBXdJJ622IQrmLh/MAuqa7yxT62KcMWBMOyEyMTr6X0+IuLZehoyF1Un+z6f1ZUtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762322104; c=relaxed/simple;
	bh=6PvCcggTpfhHNtgFjlChbRIhaR6HWTa1MtjwNCkpMN0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y4XltQvmKmQ/zMMv4FMcTzWk8zKD37rjA/jHKNy59JtrXrTMMMt7GX9Lrb5dNom1lZn29Zv9fjl9r5ThArr33jsqoYEU/1L5TyyR7+hKEmYPrW2i83xgUd2efyj7M7S/tzgRYb+ANsDqm4+ZxjE1yG7M0guoCigfCwspsLanL9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ai86mufV; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw8AWbg3D91IZI0N9vRP+HRNsjOm42RwmS6jNlMHVwXNGNdX3psmjWN0UJOihPIlf7LFNkkrzyPc27+7cl8gQHTKAQmglHY8VOi64iSbL/6f59aXrRS7lxzFPYv6wqKe3RF1OYq6TRMuCIvmQzDr12Q8x2fCbzKkbUot4Z5WJQw7+5gZrJlvkEICfEjceVLwff8xTumjQLSckVy//eJ0f/g9SxP+WADzEf3bCCXQrS5mU6sPq3oz4fn++8si/LhVdlnkniNsFgtDA6kx3IzU8ChRh7A74MWC76CN3uwBwfp9LFPwuXILvIdwwmsUyf1GtRPObstLnmkt1jp1BeH1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RYHSYah9niIS2Fl+vMV8fN4VTLOuhTMfNRJCqYo0Po=;
 b=mcNFRfuODvuSmHxSAa+xShkadSoEfWnIHvaUqFBhsFYsCba+GzFnVKBq1EJhwA/is3TiNBwc0caxHoJ7XcQSL90VktkLMH4m/KPRs+D0jsMPd31SXQYoN+fOLlRgYqDvP0jHjOui6a82oA2HjXQblUiZLYQ14bp1ovzikT5ynhW0iNW3VrjNiSDnyNNbfLF7AZgFrX/IuHJu3rMAuGT2YS6qzoR+yJ4ZlGZr38QekW5y72LpsanNXTDGCgWLHVb7ndn9ouqME6/0AcA6m4vxjuhh+OwoSzlVe94JXCmJY7CZ9aJT/jWtly4qDfB1k7QtyQrUnb8NBFawS2rmCrvTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RYHSYah9niIS2Fl+vMV8fN4VTLOuhTMfNRJCqYo0Po=;
 b=Ai86mufVqLV5xndnauZbLeAR+BXhMEecH1ok0cPNwoMsE/oNwz2lTe8condhKSin3RBfFcJZF2AAUu/bMfsDubPmyFyRupM/ZcnYjbzz/RLtdrl+wo0TBAcP9ULShocrBds+c+MuJ3w/0+pykxPY9I+UzvsXmwNTAYt/12q6169RWnfGV2ZqOeiyI631r9u2b9q1OH9iXjw4GU/wJhCodToxuhCvnmyquzNg2s7nG9wej9lL5X9ZL4Nnp1twOVWgTjT7BJGkkxsFPqCUo0gv/+8DTpSTmRFt8hNCdN7+/A1BAjgGlLJoTALOrE6v4JQiwNlw/TvRyLmmzbZfKkpjuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 05:54:58 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 05:54:58 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Wed, 05 Nov 2025 13:55:12 +0800
Subject: [PATCH v3 3/3] media: nxp: imx8-isi: Add ISI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-isi_imx95-v3-3-3987533cca1c@nxp.com>
References: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
In-Reply-To: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762322131; l=2279;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=9R00AQIZRrqb5+7VFio1Tr6VpyWVnXygGe1guVwRhrI=;
 b=m6WZd1YUVzWvzUyBzPosRj0ilC4KUzzzZ88Ctfl7I+H1T/ZWYoPt1PRDXc3TafwGcSzQCeYXR
 J21sFJ638dQDLKZVGP5O/fw+SO/6mViidVQJMB+wnme7pPSHIohe8uu
X-Developer-Key: i=guoniu.zhou@nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: d15dc434-4200-4580-3cd8-08de1c2fda37
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bU1XQjM1aEpidEZMUDZOTElQUUt6Z1oxdjNjMWc2cm9RUlFBQ2t3cXY2TGNB?=
 =?utf-8?B?ZG5RdTFIQXZPUXl5NnlPYmdvYUo1SXc4ZnNUUGJlTjYvZjRXeDdWakhNNm9o?=
 =?utf-8?B?SXFyNkgyN0xoWlFLdHJuYnVNbDJ3S1lQbUVRdmV0bmFZMldpV2g0cy9OYzFZ?=
 =?utf-8?B?Rk03cUxXYzQ4VGltOWFNcnZFUFEyaWdWQ2lPNG9uY1JPT2YyQTQ4bTFyOG9x?=
 =?utf-8?B?a1RIc0tkazNFRmdLYmNxRGtjeEdRb2ZTWXlDblJsRHRQYmxjcmJLRlBFSFBC?=
 =?utf-8?B?NkxiSTNiZDAvU2E2Mk44ZGJ4Z0R5cjNZeEdtdjJGWHAyUWtUQ2NQaTdzYnpR?=
 =?utf-8?B?cS9Sa2RLYlp0NFFOY3JqRnR1eXFoMld5ZEU4S2lMcFBXb2VOdmhzL0dub3Za?=
 =?utf-8?B?bXI4eTk2Qy9FTHJPUmxkVXAzUEt0VTNGQVhxUVh1dkFwRDlOdE9Ub2pWckdp?=
 =?utf-8?B?bTlVSjdBSUhJYXNuSjRPL2xXNE0yRklYazV4VGNBemM4Q09UU0hJNzhRUXF5?=
 =?utf-8?B?dWtDWGlvQ1kvQmx5TTI2aFhtcEZ5NWExakFSRTV0U01vWGRuMUdZYXVHRkp0?=
 =?utf-8?B?dW01ZUhGV090RFlici9TYVpmL0ZoczhIanhkVktBRm82WDhWa1luV3QzM2ZT?=
 =?utf-8?B?QTIrT1ArS1cxS3B3VDQwNzJLYVIwREFxcXdsaDh3ZnFtbHFCdjBOblZrVHRP?=
 =?utf-8?B?QnZxbEZmb0p2NWlVRFVsQUhLKzhRUHAycHoxVW5OaDRrc0pTbEQxVW9odXJz?=
 =?utf-8?B?c3cwVjFWUThlN0FMR0cvYXJhaEdoODNVRytWQlNuVTBuNGlja3hSQ0RtM3lO?=
 =?utf-8?B?eUVwbzh5QmJ4YjA1dldpSnA1SnBQVWhBSTQwd1I0RStDZi9GQ1FBeUZKRjR1?=
 =?utf-8?B?L0NyMFV2WDBQdHNLZE56N240cVZHVjhkRzN3Qmw0NHpid000eWVleDBrcHJZ?=
 =?utf-8?B?ZEIzYkM4UXExRmY1bW9PK0hlL0s3Mng2NERXYldGOGdvVzROcEZXTGM3MjZr?=
 =?utf-8?B?T0tva1gyV053Wmx0VFVycks5Y1pQeHNwN21QVWFoVm1nYW8vUGxydXExaDN3?=
 =?utf-8?B?b0IzMDBTV1htYldMSHg3UHVGb0RucTRaNGRlckFsQ1h3ZE1mMGZjRENodzlw?=
 =?utf-8?B?Kzg1Nm9KMHNvYU9zV0J6Mm1CSElIdTF3RnF2NTV0TFFmVmdpSXFSNzNaeWtz?=
 =?utf-8?B?bzVOV29pZEoyRFhsN0V5SENwamIzeHZRV1prd3VRSWVjNWROMCtZVEtyRWpW?=
 =?utf-8?B?OEZrS1A1L2tqbDVGa2pVL3RuK0FPK2hhNG9lbjQ2eDNNMC9abnFKNURBb2Zk?=
 =?utf-8?B?NVc2TXRyaVNCQVB4QWVsWGM0aTNGaDljMGhKazlBWnhWanNLRXUvTUxsN0h2?=
 =?utf-8?B?a05YSDNRdXM1d2ZlTEdnWDRobFJ6UWJad3VyM2dXYjFoK0FDNHUzNTRmRjda?=
 =?utf-8?B?Q01qRFdqdTRjVTNIQWhWV2FPZll5dnFQRmliQnBwQ3A3L2xyWVFLcXJIY2VJ?=
 =?utf-8?B?djlFTytXN3FJY1dwbkpXVnYyMTZVQ1l6eXZiTGVRRkhpRnZqTGFydW1uZHBm?=
 =?utf-8?B?bTB0TGVTZHhDTDJiZmVKSjZsejNVVWZXQ0NXa2ZJcDhqZGlld2R5QVdHekFW?=
 =?utf-8?B?M3hrTkU2YTZHS1pmREtzbnNobDVnQ0Fxa3RFbytTaHJiM3lKblNFSC8xTGpy?=
 =?utf-8?B?TnFNb3pOZ0ZRZm5MTjRyNytZMU1aZDVjK09vdVJrOGRDbVVaNWRyK3Q1ZkFj?=
 =?utf-8?B?UDYyMU1jaGdUdU9oY2szeWg0cnBxSU5lT1hiMmdBaWJKejRhTnk0R2RYOGt6?=
 =?utf-8?B?cCtyVGh3aCsrNzFqbkNOQVNTQmRTeGg2NzdxZFVkNU1iYlY3VndsYjYzNjhT?=
 =?utf-8?B?aGR5QTlnSjlTei92VkFFK3dvVXlSSzV2bVNUdkZYeUhFWXF4YWswSkJRTklt?=
 =?utf-8?B?SDdQN29qRFh3SFZQb2VtS3czMlFHY29FMTlLWTJPNDcxVlA1dExzSllyYWZL?=
 =?utf-8?B?cnVFTGZSNThuTGk5Q3o0UmgyLzljY3pQZDJ6amp0K0JGbVY1K25lME9QQXlx?=
 =?utf-8?B?bnJ4S3NJdDB3eVZLOGRhTzNrZW1ZZXdKNGtIZz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SWRpL0lPb0VlelhjR1lHcmVmdFVQZ2pPK2JEQlFvVXhGd1g1eDE0MEJwY2M3?=
 =?utf-8?B?WTlrWnFqKzd3YmlwTzN1djZPelJsTTFlRmg3enY0ckFDd2c1UUM2OG5TWWRM?=
 =?utf-8?B?ekE3SnIwK1hJTE94a1VpaEE4UnM2OXphYnVXeUt6QktTd2dZYlRtbW9aU1BB?=
 =?utf-8?B?c0NPeEZlYUdhZnFBdzV4d3Y4TG5jbXJWYXZEMHNDUTVPcDduYm5CUDZkbldr?=
 =?utf-8?B?cnQzU2JNNWhLUllPSlppQjR3RW9yTEFxaVhsWDFxUUQ1RXg2d21NVVpLNmFw?=
 =?utf-8?B?c2hCVGNMN1ltN3YvdTZVcFFZZkphdHFLeWxwS1NvbUw0bzlLQjBkVHdLS1Rz?=
 =?utf-8?B?OFhETVZ4VUNaaVdMcEdDZXVCQ05TNDBIQmVIc0pDMWw5QTcwTU1IeWF0QkdI?=
 =?utf-8?B?UmNzTlN2d0tTS0Z0MlhITUlVV1lWLzZXZHMrTjVCWHZqdUYvbFNFZW1GTGxW?=
 =?utf-8?B?N2trcW9iYjVxOVFiVW5ndWFCRHl6YWxHZzNldjYveExZS21VcmlORkhCNDNW?=
 =?utf-8?B?MUZjNCthVjgxL1hVWkJxbmlka3RsUGp1M1FEZjdkUnFJQUViMGYwRkV5c2pj?=
 =?utf-8?B?bXFtL3BHQXEvM1B1NmNTWFF3NGFFVFRDS0ZyaGx4Z3MrSHloYkIwcVFxTlpj?=
 =?utf-8?B?YjRnYVFBQ1NLZWI3ZE1NY3JjeWdtcnFoQU9KWEI5eGtWZUQrV1B6V3cxMjgx?=
 =?utf-8?B?Sy9HUnUxMGJLK1hLYXZibUx2bjA1OUJwdWxiODZud2xJSVpLdUlIWS9za0lB?=
 =?utf-8?B?UzlpTUYwQk1XbjNYUWo2TUtpSm5zc2JRTDFyN0tIeldrblRHeXdUWklNdHpu?=
 =?utf-8?B?eGRuN25pb1BoZUUvcGVYZ3NpSDk0eks1ZkNIeCtoNklTUW0rSDE3OFMrMmpw?=
 =?utf-8?B?SVIrTE9XN1ZDZU9HczYveGZCaHQzdWhlNG01RmNkbVh6aWhXS2I5OVIvcmRh?=
 =?utf-8?B?dERZUGxMeHFub3A1RGlNeXVGY0F0MnBybWNCUEhEOUEyWmY5aGdUay8yNlhR?=
 =?utf-8?B?OGZPcEFTVHRhdEpRSU5lM2NORWhtVWFCU01ETStqOUE3QlFHdVM4RFZXMis3?=
 =?utf-8?B?T2RMb3lIamJ1b0JNTzFBNno0NWlnYlREdFVsQjhzQ2ZCdGVsZy9DVWFhZWE1?=
 =?utf-8?B?MlVvbmhuL3liTHBQakRhR0psUmVJbnE2dVhORTVDYk96L29Wa3JqZXdFTlFG?=
 =?utf-8?B?WHd1eTZhTG5nL1VLY1JSNUdkMDhBL01xemlTUWIzY2JtdjhWOHpsaVZ0Z2Jj?=
 =?utf-8?B?R0lITFlZL2d0bTBBVldUYXhRSmVKeUh2N2YySVZSMXBIVWpXdVJkd3dlaFcx?=
 =?utf-8?B?TzBEQ1R1U3Q0Nml1VXpUbHVlQUI3ajg4SjBLOW5CY0NNdFdQTmgxY2ZmVUMr?=
 =?utf-8?B?VVpZNEtnaW00bE9VckphTzRhVVFBYVdxYmYvRDhidVUzR2JvUkhRbFlmNldt?=
 =?utf-8?B?K3owWlV1NFF3S3hsRmx4STRzY0ZwVkJrRnZRb3pKVFB2VGlNdnFOaG5LSUlB?=
 =?utf-8?B?VENick8vWVJWWGZRQ1g4Z2pZeDRyeWtOY29LZTBnVkIwUG9Vem42WUZsL2Iv?=
 =?utf-8?B?dUVNTVV4MlV2S3BCaTVuRDJNcWhtNXlwTWpHMDBvMitGTEFsUE9qb0pUOGpm?=
 =?utf-8?B?UW9nMDFMdEQ4andEN0FiWk43T0FaVTNCQlZzaU1pbXRpQmtyNExxOTVOdkps?=
 =?utf-8?B?dlo3THZMWmpIMHNFS3pUTFNoT3RUb01JT0RxTU0xTVdxeHBycVgvTGRlbTBp?=
 =?utf-8?B?UldyaDJWd0hDY3RKY3RTQ2cxWW0rdWtvQmxZcVpmSXJDNXRtL0RLKzBOR2hI?=
 =?utf-8?B?bjAwdXk3Ri8zRUxHa0JRTDZHa3NacFN1V3lOMWdjTFdLK09EeG1YSU9CT0VK?=
 =?utf-8?B?OFNpS2JNMUlCeFkzNjJXMFRXQmJuNW1BRnRzWGp2NkpjMUlFaTc5eUVSMXlN?=
 =?utf-8?B?WDNVZHY0aGRRL1JnN0NrWUo5b3Jwd1FSMzlNQXNvOHBkRnNiQisrU2Zyc0Jq?=
 =?utf-8?B?T2hXQmVkSlhKTXlZU0dycWdkYUFlRjRrT2EwQldhb2tRRnR5WUR6Rjd1a2Fn?=
 =?utf-8?B?aG9vNjNOT0lGSDR4bEYyakxoTVRjRUNSMWdhUzk0bjNmNDVwQnNRMGRJdzlZ?=
 =?utf-8?Q?DxciPe3apV57/qFZ5qEethwnW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15dc434-4200-4580-3cd8-08de1c2fda37
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 05:54:58.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwzwd9SwwBhxEvBgJouNigvDlAFayPtO183EPxUPje+GqJu5MesaTsouOXPTAtp7iMt+RJnHbsCL9rZaDbEYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002

From: Guoniu Zhou <guoniu.zhou@nxp.com>

The ISI module on i.MX95 supports up to eight channels and four link
sources to obtain the image data for processing in its pipelines. It
can process up to eight image sources at the same time.

Add ISI basic functions support for i.MX95.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 12 ++++++++++++
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index adc8d9960bf0df87d4e475661a3439beaf5ce9f6..cf609320f19e91c9c0f57634fabd62e0ff65123b 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -337,6 +337,17 @@ static const struct mxc_isi_plat_data mxc_imx93_data = {
 	.has_36bit_dma		= false,
 };
 
+static const struct mxc_isi_plat_data mxc_imx95_data = {
+	.model			= MXC_ISI_IMX95,
+	.num_ports		= 4,
+	.num_channels		= 8,
+	.reg_offset		= 0x10000,
+	.ier_reg		= &mxc_imx8_isi_ier_v2,
+	.set_thd		= &mxc_imx8_isi_thd_v1,
+	.buf_active_reverse	= true,
+	.has_36bit_dma		= true,
+};
+
 static const struct mxc_isi_plat_data mxc_imx8qm_data = {
 	.model			= MXC_ISI_IMX8QM,
 	.num_ports		= 5,
@@ -548,6 +559,7 @@ static const struct of_device_id mxc_isi_of_match[] = {
 	{ .compatible = "fsl,imx8qxp-isi", .data = &mxc_imx8qxp_data },
 	{ .compatible = "fsl,imx8ulp-isi", .data = &mxc_imx8ulp_data },
 	{ .compatible = "fsl,imx93-isi", .data = &mxc_imx93_data },
+	{ .compatible = "fsl,imx95-isi", .data = &mxc_imx95_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mxc_isi_of_match);
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
index e84af5127e4e7938e55e31b7063bee5e2cd4cb11..e52c7fc334b0f5624ade600914c275e7539290b4 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
@@ -161,6 +161,7 @@ enum model {
 	MXC_ISI_IMX8QXP,
 	MXC_ISI_IMX8ULP,
 	MXC_ISI_IMX93,
+	MXC_ISI_IMX95,
 };
 
 struct mxc_isi_plat_data {

-- 
2.34.1


