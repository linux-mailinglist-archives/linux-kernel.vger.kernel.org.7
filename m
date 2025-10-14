Return-Path: <linux-kernel+bounces-853272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B73BDB153
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E7474F6D70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0898C2D24B9;
	Tue, 14 Oct 2025 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHC7OEc8"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF62D23BC;
	Tue, 14 Oct 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470734; cv=fail; b=tokbWGASXu9nL6M2NAhqrWK+Ywpc4Q+vkAQ4k9iMaplOpe3rfJDAy8CHpHeeh/Wv18YfOBuarWePiD+7uttpguHxPEHkiB+HT6ph5zFum36cuTFD07C3eZ4PAQPy0TNZMgO+4ZQam1VC7XAPFenYk0x4DZWH6k3a7RZxoHo4fdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470734; c=relaxed/simple;
	bh=kp+D5c4fcdfwelfvU50juvcloK0a6nkna7wbA0g3tW0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cb3FTgXJfEwceZf/ygCMomG4GKJ5RRKIZQKGYSkdGuvDH6R+B30swREDFztVlqRLBVuaawrc9Gyni6cAXegTvv1slPo0heHrXawRNjDWAtIghIoqOtdE5udCzswqr+OF5dEmTaeDe2+VygWEWOO+kpPpEK+jHO+e0sE0hIaQ37U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DHC7OEc8; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=belizeiXchJMqA+/DvSY7aBNsaY9ywvHUIzK1VntfZrR+mgi1PaZZtdKfeMXbCbZpvU/RbbFEOEOYBPSM6xzWwNws2bBuJSJPignJ/pS732asBioWfnAYkeaRe7dFvOrCe/7Rds8HkjCyh370sWpP9V0i4d30dQEb9/Hyvsrjl9u1+Lj6DQK7Z+dc6GBRYWMnqoIiEQ98QO0OBDMe8czSxViTtgXbidqInTxHImFcIfjqtDOj7QaWDN3Sro1Ifh6lEjsF8WDpPcgxmP9cXXLLYKpvRo1gIab9gc2ihM6mjAGPfs5LV2BXOsDgBEbEzeX0jvkLzRFnuDb+qvUOrq8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x0Gl1wguVfXFT9ai5ZglJdGvhkhWY+ibaX58fdcBhQ=;
 b=v9hZCArmwJX+rJYNEnMf+vUCDPgGwWVP26F8L77rF6wD7dhk3GCVi3cG+qdvd/3NSZThBR2f5pyCUSIh8N5c65Cfxt2JGkiqZD3n1UpNfHYasthsC4fm4JXFNF+pNHKPGn+N6US7R9XXkR2gFYOHnaBJz3r9sAFiDd96kf2Hh5LvoQ6p7JOaVTmvyJ60Kym9il/KX/lSFZK9mCRjmApD5FF6FnHPCP7r7t/IsZiUyje9c52P3XE2Gsy9PbFIQEEXF7y2jfjcoqdFJJSTnNA/oNdLgOBU+HJGPEWq0Z6U8jD4KBKd2xbS20UozgUEhLLgyPIT1A7iEEdIC88BdmCJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x0Gl1wguVfXFT9ai5ZglJdGvhkhWY+ibaX58fdcBhQ=;
 b=DHC7OEc87JjjyLeZhPFuDyZhxAnsP98RtW8+rzao/LwEVCC7IIjshGOdzCoBofjEPBEyJZZXUk4lJrRTWmsGmLwuvS6CISXXbeFBpEy+PGnKIi9jcLfauYqVqOEBhwmNvCyrHICCM7JttHomzTYkmm/rFzRZ3RGOLaJ+gU3ufx7E46UZwcvtWcQLLbhqUx9zpNin/APj2xkzP1an1V5n12Yg9t0TmjHWq1T2l9phCLUt2Boda6wZoRxO7nQ7xUHXMDwBKGrIS86h8kSqdLX+Co8aSMgS6XbtLEs5fvJv4KfQz9c+6yRp29N6TOqgwg86CCC18zga2HDlAi/Jp3ndHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:38:49 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:38:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 15:38:19 -0400
Subject: [PATCH 2/8] ARM: dts: imx: remove redundant linux,phandle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx6_dts_clean_2-v1-2-508b36e5a3fd@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=1726;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kp+D5c4fcdfwelfvU50juvcloK0a6nkna7wbA0g3tW0=;
 b=wLZfskJfnmtEci3+Zgl+VdpjomBRP5SX8IrjKIvOqdbG/YcJmsA9xgxUjC9PZFIK9sRXpaF7x
 CNKhvAW+QPTCcB7SDOpOo1d4Ap6SX34M9KqFch/okZ+JvexudCO6b0Y
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
X-MS-Office365-Filtering-Correlation-Id: d8396ea6-e76e-4a82-02a1-08de0b594c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWNrK3BoRUVDSzZsYmRuanNCNEU1WnRkaTdPUExRNGYxWUlNdFVxL004aUda?=
 =?utf-8?B?a0dWcGJham1CTFhZT0NWU0xaaG9xOHNVRXE5NE5FcDduaVBLUjcyUmU0UzMw?=
 =?utf-8?B?cURpb3R1N2QwYnlOQkp3Q01hampEUTZWOFdwY1VQK0lNQ1FlS2piNTRDejc3?=
 =?utf-8?B?bGd0ZmR5c3kwbmUyb243NUR0alM3TzN1c0ZKV05Ia0dvRVZNWFY0K1BiMkNN?=
 =?utf-8?B?YTk3YUc5ZzJnU0tvRHVYeWhRTCtTTzJPbGhZTnFSQSt2NHBWaThGUTljY21t?=
 =?utf-8?B?M2o5S3U0cm54OW56cUxsNnBuNm1IWHVwd0pYTzY1ak5mNFAyN0IzeTJIbEU1?=
 =?utf-8?B?aFl2b0hRb1poWGRwdk05aVZoM1pIRnYrZzJSeHFrY3BuVXMrMFVCaTRVd3F0?=
 =?utf-8?B?OFB1WGx4eG9LUjBzYm9HWCtqZ1MvYUs2QU1GLzZrQW9hRmhnS3phZUJjWUZ0?=
 =?utf-8?B?UTBQVk1sOHhnZ3ZwWGx2M3BsNHMwdTlFNE9hbkc1aHFrdThSQklzN0d6OW1E?=
 =?utf-8?B?OXBuZ0N0U3BkYjlnUUdKYVZhWm9melJQREZlTm40ZUZERlFRMk1taFVMRzQ4?=
 =?utf-8?B?WTVQUlU3RHBUWDBrL1hFQTkxZWN0dG02ZHlRaVA3V1RkcjFMK3cycitGd0Fq?=
 =?utf-8?B?bVY1QnFNZlk1NU9zOTE4U2xRK3R4SXYwdkhvRkp3Vy9UbUh4bUZnNlBveW9L?=
 =?utf-8?B?bC9BNVRVYzRQSEQ3cGhJMXFlaDUvNk9lK1BHQmlKZ0IrWitFd0kwN1ZYNWZL?=
 =?utf-8?B?UEF3WmxnNUQ2VDhYODYvM3Nmdk5DZ3hPOEIweFU4WkNLL016cytxdWF1Lzlt?=
 =?utf-8?B?RXRpWVlydS9wZzBScG1pVWo2aHEyL3B1dTRWVUZwU3pPSkJDVENYcDlSUGMx?=
 =?utf-8?B?TTNONEJVb1RpQ3pVd0NzeVUzQVY5eXhJRitaZ3V1QjNPcGJ0SEZRK2ZCalky?=
 =?utf-8?B?N0Fmc1E0OVN2QkxRMVowMWtYbXRaZUo0YUhkQ0FRZkF4MTczdExyOXFKSE43?=
 =?utf-8?B?YnlXNFVMSjY2UVVqcmZDaCtkdEZJaWdhWjkwYTNXS010MFNydnpNSEIySXFr?=
 =?utf-8?B?R0dLdm5lRWZlK0toWkQ3akVKNGE5T1RlelQ5czBGOXZybWVLYUJmdDU2Tnlz?=
 =?utf-8?B?cE9RVDJrT0o2ZUxKRVhOV0xlNTdxa0ZnVXhaWGYzYXVicUV2QUQ3VlFGTGow?=
 =?utf-8?B?MnhVR1NlZzN3Q0lLeGdmaTBlQnphczh6WWZ2cjhvSUt4SlRPZkZoOEd3Y2xH?=
 =?utf-8?B?eVgrbnZUdXFEcDZ4WGVNeGpNOG1hNzlnZWJZQkRCUGROTUx4eHNlbzRIVUNl?=
 =?utf-8?B?aW9mR01ESEhFaVdMb1Z5Qm9zQkxXd3pHQWhTRVhvYzRMNGtWSGVvcmRXcW5p?=
 =?utf-8?B?SXNvaXZzUG1ySURzZUViRmhibGVVQXk3VVFlVmlNUEFsT0c2OVVGMkF6dWlr?=
 =?utf-8?B?YVZSU1JlMHJvR2hOWExDU29CUFVDc1hndTd3TVo5cEtFNk9NYkFVRkphdXgv?=
 =?utf-8?B?Wkh3SzJ1ZDF1aGgrQ0JReTA2bUY0bTRub0hHMTI2UkdteEhkeUU2S0s5U0s5?=
 =?utf-8?B?RkR2WmttbkF5ejJSRkZlU0RMS0h3L2pKNFJ2bHU0eXdBbmRWNThyTXVXV20r?=
 =?utf-8?B?ckRhN3UrcmIxNXg0WUY4RmFOS3Z5WUxWVGJ2SzNRVEtRai8yQzliRVR1UG5Q?=
 =?utf-8?B?TG5tVEFISSsvVmJDaTZRLzNVenVnZFNDUkhRd2Ntc0VkUnVUQjRmYmRQRzAz?=
 =?utf-8?B?SXBGSUR0aUNybTJqalgzRmJWYzN6V0JYY3R1ZFgvT29BVDBLUW1NdEV6cWI5?=
 =?utf-8?B?TS8xbFR5eDliYUtOYW4rTUtoRlhVQmdCQVI3aHlwNzBEUTdhMjBvNEwvVVhQ?=
 =?utf-8?B?UDB5U3VMNU9Gang3UjhGMi9TSkI4YXhrM2ZiUlpQUDdSZE92ZjlTTFMyaWti?=
 =?utf-8?B?SStra1VyZzJ5Mm5pYkpJMXZxYVYvNVFwUW9vVDQzOEZGSExBWDJNSExHa2ZO?=
 =?utf-8?B?MEliZm1lVTUrcGFJNVI2RFBFek5Xc0gzNk5RZm1INWJaS2pBOGFOVVlxMGdt?=
 =?utf-8?Q?AUJluE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01JVitCeGNmc0ZLWHlRVytVK2RMdCtlRE8vUWU2c21OUTFxOG5PZXIxZ01i?=
 =?utf-8?B?QWpYbGRzYlRzU2dLS2RpQ1N0cDNZUFVBb1VjTXJtSmZDVGVnRktVcE5xUk5Y?=
 =?utf-8?B?cDBpQWpKL3RJT1F6clA0WVFtVlRSeUQwcjUzWWExNEtXZGY2VVJGa2tOR3V2?=
 =?utf-8?B?bC9xWGowMUd4eW51QmJlSmNWZUtLZ0wvcXkyaDdNWS9VbnFLblB3eDRkVm5z?=
 =?utf-8?B?MnBlb0U4UTFuRW5WWFBZaUhPYVF5TU5PTEhkRkxVUEg1VFlTOGxMT0IwSGww?=
 =?utf-8?B?OFlWcDNLWS9MYVg1M2RvRzEvbUNWRE9UV0VxT1U4VXQ0OXJiL3pLdlY2b2t1?=
 =?utf-8?B?Vk9pRmsvSzBzajVGbktqbW5xS09JUFprK1p1VzkramJramtvNDNzMVZtQkEv?=
 =?utf-8?B?NWtsOVBQcUpKQjgrelVpQnJMNkpFOU05cWhsa0JIYkNueGRxK2poYnJtajZ4?=
 =?utf-8?B?UWZGcThzZFl3SGVDLzNjYlZZQXJkRjBqSDZjcXBIT1hsNVUweHNxNkNpbXdz?=
 =?utf-8?B?WGZvaXZRZlVEZkZmTjJHaHVpS0pJTzQzT0YvbkRGS2FzNmt4TStMbGJ2VnYx?=
 =?utf-8?B?eTBkdWF5NmtXUWd5K2ZVeVdnNkZoazdObk5GODNPR3FDT2h2eFFJUk9kWWkz?=
 =?utf-8?B?eWduWVVyVUtTamVkblhEOG5KZzEzNlN0bWs2ODhqMWhLa1FqZUFmNk56Z0VU?=
 =?utf-8?B?bXZCQ2k2M3d2Wk1lWHRKZlFxNkJ5am1Pd3dZRG4xVis4alVHZUM4WG53Tmpl?=
 =?utf-8?B?c0pyL3RCL011cnZQdnJSVnhkckdiWkIyMnJWUXQyOUV5ajlqdjBRbmdLYjNJ?=
 =?utf-8?B?TEVEZ2VWODlEMjZka244Zk52QncyRVVXNWNrZStzcnYvZ2ZYeStROEUwYjZv?=
 =?utf-8?B?UUdrOTQwRE84MEhhZWVCOG51Rks2SDQ2UmJJc2F1eVUvV2s1MUhuRGtGV0lS?=
 =?utf-8?B?NENhQURnT1BLbVg2Zkh1Nmhlemw3MWRVQ1lYVmZtSFhYSVUrd09ib1BsTTJn?=
 =?utf-8?B?Q3pCL3kyN25lOGdZdm5veHQ0d3B0bjJQeTZWRWZYMS9COHJhVzVUUWhvUU14?=
 =?utf-8?B?OUdjWDViUDhhNlVmaHJOaFlMSWtzTlVsYVVtUkphekUrRm1iWmFmejVlVldZ?=
 =?utf-8?B?UWdhNCtEaWQvRExXdWVlQzBCZCtKSm9BbEVuR0ZsM0JsY2lNNlhUdEhibXBY?=
 =?utf-8?B?K3p6cVQxcWp4ZDhmZm8rNkpEREg3N0NwWFQzdHBLN3BOQ0Ntb1FyQS9uaG1X?=
 =?utf-8?B?SDhrdjQ4akdpZHAvcVViODhQc3lwdjFxNzViQlMxdHczbWtvM2xnT2VvV2RN?=
 =?utf-8?B?K1kzeitNMUNSaHZYRm9lQytrdWZ4MVJjOHhNQlpibG84c3hsT3hPRTJCRHp5?=
 =?utf-8?B?dWFBMmU0cHVwenJvM1J1YzRYamhBTkRiSStCZ0xLalNhM3R3R3BPaGJxYlFS?=
 =?utf-8?B?MVBTQ2pnWTJKeTk2WTRKakE3YS90eXJsK0xhSFpCL3RPakNZdUxpOXRZbTZI?=
 =?utf-8?B?UTBQaWdvTFZEbURJUGM5c0pQVnZkQmdZTzdDN0ZVVnkzcE9OOU5mWlZEY3lx?=
 =?utf-8?B?dEUwKytNMVRwWWlQdFl2UDVaQ3BZd1RMT2NoaWwrOTF3M3drMTkxYXBtTEZB?=
 =?utf-8?B?RHJ4NytPQUo0OStzblhTaTNRQWdhUVhoYUh1czBBa0tPZ1lxMHk2ZkZtNG1J?=
 =?utf-8?B?NEZqeTNSRUhNQmJOa3JrRGF1aHRDY2YyRncvZXRkTEZkbGF0cmJqa05FNjVJ?=
 =?utf-8?B?ZDVKUnNNejdPRlBPaklBUzBrYmN1QlBjb2VFS3BkTDdSK1dFNEdDaEhFaE9U?=
 =?utf-8?B?SGd5ajhwdHBZZm05MndJa3ZXT1l3QnJ6bC9iOE9GTzBIbzhiTXQ0eklTZTBq?=
 =?utf-8?B?WDRwcWRSRkcxZFlhM1RTSFUrOHlkZjVVMmtFQ0UxMzZuNVg4NEFJaGNncTFo?=
 =?utf-8?B?WVdUd2hpc0dTbC9uY1lNQmpUdngyY0RNMytpSXRkdFpEczFJWkVjbHFwRXox?=
 =?utf-8?B?V2xsUFZOaU9SbmpHK041cE5NSUI3dzNDZW9nekdSOTJHSmwxcUlHVS92cVlV?=
 =?utf-8?B?OC82Y3c5U0h6VkNQMVE5NTFTRGkxWEw5MzVSenJWc3NhdlZMamwzczArWEpz?=
 =?utf-8?Q?QXcscVg0Y/8W620JL52h1zIAf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8396ea6-e76e-4a82-02a1-08de0b594c48
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:38:49.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ka3oobJVpwevlEA8GHDWo4NYS88e6pcAQkRAJnKlZFp6Y0f2P5OBSsiHuPJ8BRrP++OegcNkGkGWUSdn19pjQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

Remove redundant linux,phandle to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-gw560x.dtb: pmic@3c (lltc,ltc3676): regulators:sw3: Unevaluated properties are not allowed ('linux,phandle' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi | 1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
index ea92b2b5c50d93b2e3a03d3a6f8d7526bb8e6785..e9d5bbb43145f8260873b60164e713cd1012cb9a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
@@ -462,7 +462,6 @@ reg_vdd_arm: sw3 {
 				regulator-ramp-delay = <7000>;
 				regulator-boot-on;
 				regulator-always-on;
-				linux,phandle = <&reg_vdd_arm>;
 			};
 
 			/* VDD_1P8 (1+R1/R2 = 2.505): GPS/VideoIn/ENET-PHY */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
index b518bcb6b7a99673de2a7eb49e2a34b75d41fb29..01f77142e153b2775050de4d792c37a8ccc47cf2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
@@ -360,7 +360,6 @@ reg_vdd_arm: sw3 {
 				regulator-ramp-delay = <7000>;
 				regulator-boot-on;
 				regulator-always-on;
-				linux,phandle = <&reg_vdd_arm>;
 			};
 
 			/* VDD_SOC (1+R1/R2 = 1.635) */
@@ -372,7 +371,6 @@ reg_vdd_soc: sw4 {
 				regulator-ramp-delay = <7000>;
 				regulator-boot-on;
 				regulator-always-on;
-				linux,phandle = <&reg_vdd_soc>;
 			};
 
 			/* VDD_1P0 (1+R1/R2 = 1.38): */

-- 
2.34.1


