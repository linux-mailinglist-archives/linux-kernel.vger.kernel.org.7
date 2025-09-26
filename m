Return-Path: <linux-kernel+bounces-834344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E7BA47F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC5D1C06B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80F245012;
	Fri, 26 Sep 2025 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ianW6t0u"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210F22F764;
	Fri, 26 Sep 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901708; cv=fail; b=hwC7tUlZtUHl1AgrKD6MGempD76ckcrR8mFpw4jMZ+dOEeTPquTrJ9u9yty2usUJzEEWOJWDGaAXc78Rrn17Il7FURibHtZ3yYGgpnDRgzHYU9LTOHRa1/gKoUA7kYXDqmIvXfXHmcwDy8Uj/HdchRzpuv3MlbvTX50kWc31/70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901708; c=relaxed/simple;
	bh=7QEuAhxOIw0u2oO8DRHrZP/iK1N7H24f44E0a+y4C1Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AIfMZ9zzm6SasZ/pwjATmvRma1uDCq6yk56h+x6jsPiyFJtxhaV2Lo0Ut2/iQM/Ht7WzSEYjFfIcakouq0totaCN7buwBUZRRNCGIf499Y7CfFdGNn7Pdx7nDUnclMl/Hq+jy90wSHXzdNNZcv9hRBWdxuPRgxiVeKywmM0GQt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ianW6t0u; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chHflWNTNl0fuXfXuSbxAZK/EsbdjbUcAUN5K1TDiqR9bZBm7JxaGyunwQGc8mQ/q5i7e50lIbMvLCqREZPCzK7Z+2J4+gkVGS2MwBpi0hmowHLyOkxXDuJAVcVei7Tjl0/cpjVR5ME7kv84oV5FD1B4fENkS/WBfX73tXOY5TiEZJr8+LhMiemPZ3zsWERqMYpI9yy8d3qoS640Egxthj/WquUEYr3Vk3+xy2q+ll3xYHHY3Erj0Ah7AZz4TbopDMrLnT9pQy02+31b1oKl4FfD4TMdLO4ip+71K36jJRSHEukR7A9IJX0FQhT7Ebf+lmX2+cz3WremvVuMXT0UNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaQYmFXhZmj9KETYFrL1rTXvxZAHd+VSOAIQc0lwt8o=;
 b=f0C7EESVywbYfFKYgRt8EOmFqBAIt3LPFQx1cRY9GtKj8FOXyetEnxE6n2tc+U+BszMpewg7FBUAelmeyPzaHy1L0jV8yTQznd/cL777R66jakxM6T5Zd+3OTjcQ/HnXaAd49n9fuHZ67mSrLNTBYacuNpeMoTHmdzGtgXs2/m+c7pvIhJDHYPeyzHBlOQHapkMAap3RPPBzm93zkIACj6Wz58FSU6aX/qCJf3iEDnVLHkVMnB7rCfxOM4WKSbVJ3YfBZjytBws9qXRGRHs/QXdRdbrFNjKa2Ww0KSUmB6yWbsJJYQ0r94mXqn8ld8PW5IB1JFZKVXYwPZmR2dxKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaQYmFXhZmj9KETYFrL1rTXvxZAHd+VSOAIQc0lwt8o=;
 b=ianW6t0utolB02/wxtYXmRF1naWYuqXrjWpSWsRa+sqJFLqVMucbo5zcEpzjmJ9YNIJFdlRNfCKKvVVNEdwdgsWuMkc42mebc0kOZDWIY/juADqvssBdElpCMAgpmpUFPjtemiAamTrMesYMghKR5kHxyAL141+VBeuhXtAOszkqxPur5GiLhlk495HU2bt4TRxSy7hQtgduYDj0C2B4JVElO4b4DVULIVrN49BKTWzd7zehYacx4ienHhSsPc0QTscp79p3HNYnmkxxcgVafwGsSsZMY1BFeEKCoTid7AG02n/iYeM2Z43urtv3UviFDCQ1C5XJr1DBrKy5OZuH8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GV2PR04MB11826.eurprd04.prod.outlook.com (2603:10a6:150:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:48:24 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 15:48:24 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Sat, 27 Sep 2025 02:39:36 +0530
Subject: [PATCH v19 6/7] arm64: dts: imx8ulp: add secure enclave node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-imx-se-if-v19-6-d1e7e960c118@nxp.com>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
In-Reply-To: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758920996; l=1320;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=7QEuAhxOIw0u2oO8DRHrZP/iK1N7H24f44E0a+y4C1Y=;
 b=qhBMX7KjllSAsZDUALibCLSiGiq9mXt/7q0hD5A7JTbBrTxG+s60hYSNhpISEXsqMVPw6b4wk
 4l6rmxnkaP4ChXC+SkLszXiclgLsQxNQ4mJvpRmyZqjPHX9A2HkIPYS
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|GV2PR04MB11826:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b91638-5aeb-4961-7fcd-08ddfd142056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3BnLzVYeHVZQmhmMnUyRHR3ZGI1UHp4cHBHMGJ6ZERTOHR2QVVCbjBhRjRR?=
 =?utf-8?B?dnFveENjWmZySlBNRlFWZFJ6alJvMTZRV1RYQzRoeWlGUmlzazczK2VudUZO?=
 =?utf-8?B?aUoxWkV5elJndmVIZU4wQXhYQVdJZXZUTEwxb0R0VHhGNkVMMzRvMnNUdmlw?=
 =?utf-8?B?elFVQXNLdCthZWdzNVl0NG0zVnpjWnlVK2p0VENIcXQxSEl2L2Vhajc4dENK?=
 =?utf-8?B?dVRqczA0UnhIcnNKV3hoa082Zmc2MzBWSFZqaGFLWDRRZENyVTFhTjNkOWNN?=
 =?utf-8?B?K3ZadEVjb09MTjNETzFFYUFCZG5wS0NxRXN2b1ZYM0ZPaGxQTDlIK1RaeE1k?=
 =?utf-8?B?WUxHSFZHc3JGMUJlaC9hV3V3MFREeU9kNGFTc1JHZHZmbXRNMlNwNVkzZS9H?=
 =?utf-8?B?TDkydE8zUEhZMHp5Y1pXNTZrQ2tGL3JOZjB5N1IxeXYrc2lyWjVuYW8yWGND?=
 =?utf-8?B?RVJWYlpMWkhubTQ3Vi90MnVqdWZoK0orak9zbEVIZVZvRHEzN2E4dThPaDgx?=
 =?utf-8?B?QStlSnA0dU1SRjVnaWlHcGhhaG1WV0FPS1dnYjd1bHZwSThLNnhPZ252Mmll?=
 =?utf-8?B?OWFORHZTV3NROU5yY0ppWUZvRzMrcHpQM0FkaG5Bb1REam96M1JNaDlVbDMy?=
 =?utf-8?B?WldsNldiUkNTRlhwTjJYRkRDQzdqamNwUkhxaVpTRFdIQkZmTWtEanQ5azdL?=
 =?utf-8?B?Wi9iakx3SStjVkhRaGNLVlczaHZvL2xCZnJKZFVLQnhZS1AvRnMvdmN1SS80?=
 =?utf-8?B?RHQ2Vkt0dHFqRVNQL2taMkJmYzcrMlIxYi9yOVkxWG0reVU0blZlNk9vcjdk?=
 =?utf-8?B?UFovRFJxZFJKSUZGd1hSVk8xaE5URmdzbFhYWVlBTTdCRzJmejFoY2hPdGxa?=
 =?utf-8?B?MUJCMjNZK2lVN2FoUE9jbGxXMFhCa2FkMnRuUmpyN3N2aVlYS1ZNeFFrZU5Y?=
 =?utf-8?B?Ykg1VEd4VWxOd2VTU3lKd1F5YjdQZ0F5RkhnUXkyMGVISlp2RSt1S0RUOHll?=
 =?utf-8?B?R1BGZ1lhb05lMUYrZW9QSllPb082cXNvSTJBdnJHRGwydmcrSkt5cGdBRDRa?=
 =?utf-8?B?NzhSaVhuUG1xTVJtdHBFZW9Dbk5QekhxY0g3VUN3d29JV3hOeTZBTEJOVDFH?=
 =?utf-8?B?WmRjWmFlQjcxcis3RDh0cXgrRDJQaHJMQ05wSy83aXNveU56TGpWNnlkRGRI?=
 =?utf-8?B?R3Q3UTJROGJEUThqZGdOM1JrQlZCaVVySEdvT3VEU2xDTHd1MzhVb2tUeGVD?=
 =?utf-8?B?VlB4OGYvMXlvZ05PS3dFb3ZRYTRZYWRHOUI4MnNibC9mZHhZVVg3ejZFWnpU?=
 =?utf-8?B?Y3llZE5FWEVXRDF3Q25JVUp5bHZZNmZKSkdRZ1dtdVkrMzRjTXlvMlRkMVpi?=
 =?utf-8?B?TFpScjBvZjdveEcyVjJDU0JXbkI2RW90QTl3ZXBZYkJMd0RGOG1Pdk5sU1BW?=
 =?utf-8?B?Y1JRQVpPVWFmS20wQXZNem5zZ2RDdTJLSExJa2pVWm43dkoxa0laUkdYcWh5?=
 =?utf-8?B?V0pYM2dOOVFpbjdudG1pTUNRa3dKWXJZRGlDTEJWbUh4RDFYMnFLYjhuTjds?=
 =?utf-8?B?UDEvSEtsb2FVQlpncGphSCtLTU44b0JObVJUK0ZmMnp5RnYxQm9EMHdEZjFj?=
 =?utf-8?B?dWptUHNVc0xuWnlJdVg2V3BUQ1BRWWxaSDA2WkdKamxjQU5yRHczUDh3N2ln?=
 =?utf-8?B?OXdBN1k3eHNMVXhUZUFjb2hZWUlvK0NOQWkzaUU3dEE4bktSYTRzanR2Q1Fi?=
 =?utf-8?B?QWlrMEJDQ0pFYzFpVWNmVkM2Wmw5eWliMXowQ2pKUTM4VnE3eHR4VVpHSGJV?=
 =?utf-8?B?blJhRDBPSmM4akd2aEs4US9zdGc4blJZaE1BRWRTWFdPOUZ0NkN5NlNlZ3lX?=
 =?utf-8?B?M21pYmhadjBZekdlTktXV3ZTa09aYTM2L1hqOGxTTjZkeWpKVEdsQ2EyYmo2?=
 =?utf-8?B?bE04WXJnRFVCV1Zna3RSQWNKV2hrajFYK3NqTXIxMllPcHBJczFjeUg1YUdp?=
 =?utf-8?B?UEVhZVlCMnBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JrOVNOWlZSYWhYbnNGbk1LZDUrT3E4d0tQWE9zWk1peFVjbHRXdEpqQ0l4?=
 =?utf-8?B?eUQrYUtIRjhHRnhXZWt0QjQ3azhZZlVTUmhWbnc2NUdNbTVjVWx6bTNLd2Vz?=
 =?utf-8?B?OG5MWDJlSlB4TlJnU0FFcE1uTWllMFZ2R2gvbnRBbXZhSENUQ2poK2RhMkpl?=
 =?utf-8?B?QzE5bjV3bVhjQy81MkNISFVZMGN4dkhnaG9jRmpaUmZBVnlNRE1VMGd0bHIw?=
 =?utf-8?B?WEhNQ01YZURUS1VhbFNQZmtmczFzNUQ1U0J5Q1FoZWRZUEJzZFpENytiRDZO?=
 =?utf-8?B?Vk9nRWU1UFpaRllxaVdvVi90K2JpUncvS1ZMMGlDdlQzY2Q3ZjViRnova0hQ?=
 =?utf-8?B?L3lTVlFnR3F2dm5Qb2hqZGtOSkM2cDNXYUp6ajFxZTY1TTBpOGcyeVZ4bFFn?=
 =?utf-8?B?WnFWS0pqc2FhUGtZQzVVd00wWlVIR3hNUkZ2RHZ5YUtIQjREQ1lPTnpTT2k5?=
 =?utf-8?B?SjFmcnJLM1JZMW90OEg1bG9FZU1VRXQ2WkhBem9PZkxiUHlhcXZCWEpPVGVQ?=
 =?utf-8?B?U3NwOWttSjdtN3hyR0g2d3R0cFVrcTFKWFE3QU9YNUgxci80cS8vQkdWWCtF?=
 =?utf-8?B?cjhQT0NIYXB4cmJFOFhNSXNFZ1luYS9KOTJoU2NNWi9IblZ4SmFCaFhtM2Nm?=
 =?utf-8?B?cGgrMEtVUHNnbkxjNVFhL09RWGdCbkhUYWJqQy9ZYVpzckZEaUxoV1FXeUZx?=
 =?utf-8?B?b1hETy9jeXhmM3RjZzhiR1ZxdW9ndWwrNDUyZTlIQm9Zb01HYllkNlJGSGR4?=
 =?utf-8?B?eWZEM2IvRmUrQ0MrcUFJdkV5UVZUbmRNZldxTUlxa3RUeXNVVDVGM2hvcFcv?=
 =?utf-8?B?QjhBZENGYVBlMHVTSGJweGllckloUTFIWUQ3Rnh4bjVqai9UTHhXY3hTcXNi?=
 =?utf-8?B?dHlRbmJya0hpYWpGbXZLNUxEWlFxSnp1emhYNzE5RmJjS1RSNldXOU9Vd1ph?=
 =?utf-8?B?NjhUWmxaRGRnc0UrazhKdC9iTUsraTcxbkc2QlUwazlXUi9vWC9yYWoyOWpV?=
 =?utf-8?B?YlJUWGl5TmhyZFg2dWs0YTRhYkNuUE9Sd2Q2aG5OM0hkRCtmVlRTcnZPRzc3?=
 =?utf-8?B?L3ZyQjhPZkZUcWhHVzJxT3BQRzF0NnBFVkF2MDFSdTlldjl6Vk50RUNFdUNJ?=
 =?utf-8?B?alRIcGtFNzhYR1JNdldhOGUrbnZSSmpCdUZpN1JudlhhS3pTMktjVFU3NTNl?=
 =?utf-8?B?RFNFS1c1bWJVdk9tRHFpQ3dvQU1neTdqdC90RFloMDZsbzlDdkx0QzJFSEwr?=
 =?utf-8?B?UFljU2RBa1NrSVZJUUpLS2VvZGoyTTVkeFl0T3IweWhtMkNtMnZOZ1l0ZUMw?=
 =?utf-8?B?RGZ4SjFITVk0ZGxrK0RzYlMxS0RIeWQ1TDlXRUFSWDJzZjhSVFFvWXJiMFpo?=
 =?utf-8?B?MEphdklmWmxmblBkcWhMbS9rMkNtbnM2NUV2eHN1c2hqRXoySXM0STMxZmJo?=
 =?utf-8?B?ZEJMaXN3WThHYXJsbE1WYnViU2dlVEkza1ZTZ3BuRjBBeFlWUG5BNUttcDJK?=
 =?utf-8?B?Y1BaM3dEVGJHOXRCcTFqRHFtekxSbHJZVEdUUE9nQWhEZ3BsQU9HY3RqY1ls?=
 =?utf-8?B?Zm9TNEczWFBJdHBSNlp2dWVmZXFIZkVXNlVodzdjNHpiY2svU3R3SkZFbWs2?=
 =?utf-8?B?d2dlMFk4MHY0d1FNZzVOZDlnK0VrMHU5TmdmNUdOSDN0RWkzQnJKbzRzQnRJ?=
 =?utf-8?B?NlM3dnFFUmJhWGxkTXhUMTJKNEE3c0NCZUZSNWJoNFVQOXdjS3lSUlE1TnBF?=
 =?utf-8?B?QUNObTkrdDFTOWRrSVREOGxxRlRTZnVGQzJ5N01xRll6d0FEMi9WaE9WNlgr?=
 =?utf-8?B?Qm9HdzVGdVQvR080WkNUREdLd3IySGVpN0p1OVM4N3lPRmFxdTRuQWc5Z0Jj?=
 =?utf-8?B?TzZEZjdINzFjWDduVFB2TjMwWVJuM09QOUI5UUlYM3BGdzQxckxyUDVUd0g2?=
 =?utf-8?B?QlpvSGNFK3NDd29DUFdTUVJSZFFyZlpNeVdEOU1rUFk1akRtM1F3TDc2T3R6?=
 =?utf-8?B?ZzZkOWZnT2psa0VKcnFqbGViczRBazMvMHdMYVNQQ2oxTldtMVJuanFSeWUw?=
 =?utf-8?B?RUFGTTJTYkZLaExQYjlkRjRPaGhHVVRteEdrN0ZseWNTTWdDZGxvS0ViZkda?=
 =?utf-8?Q?nP7W95XGz5NU1Ff0ZWertfkS7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b91638-5aeb-4961-7fcd-08ddfd142056
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:48:24.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvkmN4h4XBeoeOzT0Rm14Y04lcagLZVAMzp1mAwlYVN1b4ExUPRKcExVHv8a33TvE3p01u8z57cPcZXcZfoAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11826

Add support for NXP secure enclave called EdgeLock Enclave firmware (se-fw)
for imx8ulp-evk.

Add label sram0 for sram@2201f000 and add secure-enclave node

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 13b01f3aa2a4..10a4779dd24c 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2025 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -154,7 +154,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -186,6 +186,13 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		hsm0: secure-enclave {
+			 compatible = "fsl,imx8ulp-se-ele-hsm";
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.43.0


