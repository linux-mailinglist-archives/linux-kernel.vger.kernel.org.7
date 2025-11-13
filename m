Return-Path: <linux-kernel+bounces-899128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DA7C56DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3973E341195
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97C334368;
	Thu, 13 Nov 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Nbva5uj0"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1033372D;
	Thu, 13 Nov 2025 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029665; cv=fail; b=XobC1OUc+Tmol6p2A2SHJbd9oC+7Y5rZt+6SS4+kTV3gKx5PTkGeibur1whqBzheRGZaI7HNR5W60Qw16CTKAPJ0kBkag0Vh3m4NnoS1QfDuAOff2W5Udw4gmtQ9kB7wbfqvNmFVqo8Ti7y0LKOZj/1Wgu8lc3UtSj/VPtXORA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029665; c=relaxed/simple;
	bh=ql10e9FvYTXj8WZ9a+SM2YUD/Lat+5NyU2KEDR7orUA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MnqbUZO1QoiIwOePYOw6+osx/qR+f8+RjZQv4XsC7nT8dGYRktmFuJ5XcNRmfytil47s1DE4F8F5tVBYDWh1j5sPP5RgVMv1VfdrURXCE/U+KoeLXpHNCRgci91Omim++LkBOsRWOPDzZ8UqhEDG5PkEXHTc6CTmFskr9q0vAnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Nbva5uj0; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR6ReuX4052Glbf8H0uL+GoFlYU35PB/ioljn6S+eEbNihpkxgbsa2zqmur+dkXl8KK1eKJvp0eNIHOhHqvP5pWZ0/qxPjPnPjZLIbxxJpz4XxSp8rh7cZjIeE2pis5pRb1ucazWAHm73xW0rUTzulOvXTQOKPLcvEcHwFt+HqoQq9zNmAXxZzEJV71pu4fWKMzjMePJk5zWXDgOust4IOtgTofhJ4GKHOjmb09tg4TkTjVKF9eI9FWYAasdXG6W79EC7LRjt4txLZaTtG+tq4UTDQfdvoHN4ekBfp1JL8fMNPl+NrFxbmvypi2iz5YTspkx7JVTch3Xj/2wdjKM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak+Xk1tHc+PdASJuL5lIdU0S/pQV6RVIc6Ca9eiNf0c=;
 b=zFsz3DY9UcwmUBthVY8ePPP5KuKzsxzMVGAyYGEIWGbwKtZlPkJUDlAgp9Hw4l9aJrYAZ1wskUFnmSOMN0r+FLbdgbyQRZm1JRzBP0u4KSF4Z3wKDWXWotE/jyZE6D96evvN3LgNSUFlY7a0/dc5hOzf4ogO21rCojth/dHvHzw9jufvLjEmYwYvz4SxAFQr8pLcnpK8HJGf9J+s8xS5kmFD4FJLzS+xsGT7KsG3ebUJj4QJWuQPxTqZVdYnK+o33conQ0C5x4Bs9b4SnDDiEENzJaGdXwzrI7bTY+IXIc/qUIGzirtsrC2zDdZI3vkxpl9BmPuBqqzGr6vQfIH7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak+Xk1tHc+PdASJuL5lIdU0S/pQV6RVIc6Ca9eiNf0c=;
 b=Nbva5uj0dg9NVLFO2hOzbo0+eu0fZRApPoR1WNREE7ldezHqgIRDw1eB57akxxJnwsYcLQraFJJx7vorpj+7PM1KpNbwKiflFaBHeuITvVVOJlM1H5H5tR5nzyn+529novVnrSmNS6NwAcIfp9w3T/U58VklpUjwgAvfaj04992Uv/LlOoquuPeMjqs15JCI5eePiTkAI5uJWok6w8wdQ1z5wqoLb613MxdPUjLF+CWG1EAI94aDMm7KVLu0gjic/Hus/iP105qS67cdp8P2PxxWxRqp4Ap6Kxi/QOfleZCJUTyCPxy3oU0nH3dUH15hQFHXNDXXQh43JLjvXWTPRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:27:38 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 10:27:38 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Thu, 13 Nov 2025 18:27:34 +0800
Subject: [PATCH v8 4/5] media: imx8mq-mipi-csi2: Add support for i.MX8ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-csi2_imx8ulp-v8-4-2ebe378f7111@nxp.com>
References: <20251113-csi2_imx8ulp-v8-0-2ebe378f7111@nxp.com>
In-Reply-To: <20251113-csi2_imx8ulp-v8-0-2ebe378f7111@nxp.com>
To: Rui Miguel Silva <rmfrfs@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763029686; l=1214;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=xuhdrfJ8dgfLO3wYo/egDnBTtYjyl0lzSn53/i5gQ94=;
 b=3n5ZGu98WBmQV9Ln43eTcvonuPYQasw+aBT4FQOW0Q+EcEAeG950xZYIx1/sBP5ouzSoAwnrQ
 08tL+KH0zQyDxjpnz/qEIXAB2Y0KsQ0OaWnEzouxVNuUQW2uWeGprvw
X-Developer-Key: i=guoniu.zhou@nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 06da128c-0010-49fe-8941-08de229f44e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d01oTitvY0dxcFRCWDU5cklKUjh1SnJpSGFrQStUUTZQUE1rNmd5MWpqSHpQ?=
 =?utf-8?B?N1cyVnpjdnFxaVlXUmFkTVB3RGZQajA2OHhoeGN5dEo4VFZvUWpzOVRXcy9w?=
 =?utf-8?B?SGVDN3FEbWZuZU9GV2dJR3hKd0d5RnVTQVRUU1J6cjgwZ3pscjVjVlJmTzUy?=
 =?utf-8?B?WCtMWXVpb1hvMWtJaXMvYU1mbTY1bzNRMkFSaXhrdzg0YjBEMmt0WFhZSy9Q?=
 =?utf-8?B?R3BSQm56YUE3M2ZDUlY1eU9jZXY0K1lxVlNqTnFRMkNmU0VIK1JOeWlFSHlY?=
 =?utf-8?B?WWZoVzRkcUxXb0QrMzBUUEpyU0d0eThHZU14akp5TjVDZ2FKU1lQdzJzTGpF?=
 =?utf-8?B?NjZrcWJ2QWRqMldtbGJNQlFqZktRdEt0cUhBc2ZiazVFRysvRjFJVFJJQWhM?=
 =?utf-8?B?cEo3ZG5ON0YyZmZyVkhEWm1SdVlJdFYvUGJUekFxbWt4cUgxV3p3SjdadmdH?=
 =?utf-8?B?RXBKU1YyamdrbWc4ZUFOcXFMaUo5Q205NTVnSk05cmNEYmU4dDd6NnVXbkU2?=
 =?utf-8?B?NWZlNXd5dlFkM3FhM1RVV2ZBODNLN0Q2YWF2RGZTdjVkM0JWZ21mZGgyZHg1?=
 =?utf-8?B?RTRlaGFFbm5JdE5oUVo0RHEzRTBDQUJxTEljMHRvZCsrU2R6d2lsRTVWSkRS?=
 =?utf-8?B?NWRkSXE5UDB6dFFLQkJLNHlYcFpOS3lIclpPU0NmNVNXaUNZSk1GamdZQTAv?=
 =?utf-8?B?RHZOL0oxbDNna0RPM2NBaUhNM2llVXlCNHNjblhqenBwTDRjek8yL1cwcFBC?=
 =?utf-8?B?alBGeHo2MUVQa2pFNXB4TWZUbVM4bUhrZnFWQzhLVnVLSFN4NkowSjB0bWRv?=
 =?utf-8?B?M1p3MG9SVVJCdUdaV0EzdHRHUjJac2JKVTVBeGlSVEZKTlVWTE1RbUNKYmMx?=
 =?utf-8?B?WWJQNzJwTld5elpoWUZ0b25jTjlkWHpTYXU5N0RpYWNDdWNVbkhwYXNvWFdJ?=
 =?utf-8?B?T250dXZPdDcxTzRCWDFIRHUrZFN0MUhucGJQLzZDNm9YQk12OUl2SGxJQ2E2?=
 =?utf-8?B?d2h2RnJ5SEU5R1RjRlZFM2VxQjNCRzJackNyZVU2U1J5Z2l3ZTl4eVc5dnBZ?=
 =?utf-8?B?aWRWV3F3T2tGZHRzNWZjMVZNVWwyeHVvV2RBRVRnallZRUxiV0JickF2V2h5?=
 =?utf-8?B?Wmp1KytWRWlhL1pEaWcrSzFvbmdOZ2l3Qkh3K244VFBLeE9LaTdGTVk3d0dq?=
 =?utf-8?B?eWZvcnU3TSt4NGZ4RGtuLzZuMXBUckJVa2NGRnQxQzNjR3hHQU9zU3I1V3I5?=
 =?utf-8?B?eUdoR3NFbDZMVk12Y2x2TGx6aVo2OUR0TVRtNG9ZS3QzUGgrazF0eDNCN2VL?=
 =?utf-8?B?SWNFTm50cEFIUmdGWXlXcUNZS2tJQ0s1SktnaFp6M1MwaEMyVFNVbHd3aENZ?=
 =?utf-8?B?K2N0NHNCc0lHZTBkSkwrSEQ5RWk4VnJTQ3lBWURzVHlONHZ5UjdQOGFSSWYz?=
 =?utf-8?B?N1RrSUFISi9hTG5TcG94MStUWCtpbVVBN3RPaFEzRFBaZVgzNHBxWXB6QzBk?=
 =?utf-8?B?WTB3bzFsQlVSeTNMS3J6UEdqYU1TbGJEdkR4OUl5bEdFdTloWVJaUG5RSmJC?=
 =?utf-8?B?eHNRSEZmNmdIbzczeW1SM2V6eHVEQ2V2WjY3cHBLNGVMOS9BU0Q4VlhoZ20v?=
 =?utf-8?B?a3ZVUVFDMmk3VGFKTk1Pa21jbEErb2pySHBXUG91RDBaaUF1UEhraThXUEpy?=
 =?utf-8?B?V1crU2pnRDROc0xuWmQxYUNhbnVNZGJqK1FkYVQvdnZ6dE1NczNuY0o0Z1RP?=
 =?utf-8?B?d0FXd3N2eFRtaU9DbGxBUU84TWtLR2c2V0JUbVFlL1pwSlpzQS9uby9ZY25t?=
 =?utf-8?B?WmcwQUcwZ2Nha0xQbjE3aTdPeHR0aksvazIycUUwT09ZTEZHUUgrbDBCSzNj?=
 =?utf-8?B?V1B2Y3NaV04wSDB4cHpsejRoaDVXWEFzbGlJakcwQTBZTDE2S21KQ0IvTjZ2?=
 =?utf-8?B?T3VWYkxwWG41S0hiVVVHaXVVUXhlQUZGZzljbHI5bm1FOG1mMXM3QlpDVlhs?=
 =?utf-8?B?RzdodVh2VXBaeGlFRFBkUnFWRUdxTVhPaDg0YzhiRy9tSXpNYzNuTFNMbFZP?=
 =?utf-8?B?b2JlNU56KzBZVjBhQWFpWWtYZUdtZXlxYkNQQT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ODAwaC9HSGV6eDhsK3REdUZwYkIxYUFRQTNGby9ybGVrZngvcXlMTzVnNC9P?=
 =?utf-8?B?Y1JyYXFFOGVVK0lnclN0MnlhbmlqWXhZa1RpVGQ0Z2g4bnE0dnVhYi83MkVF?=
 =?utf-8?B?VnpsbmprTHRnQWlRUkx3YVBhL09KYXZpd21wTmVBWXVYaW1uZkcyNEg3K045?=
 =?utf-8?B?WXNTMG92ZWNCWWNsVVNRK0xua0pFLzNhcWdjMThlSlQ4U0lyOEl1QmFzMSs5?=
 =?utf-8?B?K1ZmNGVRNGgzVnJ6L1phcVdRUG11SjFneTlNc2ZIUlVJTDZvSVIwOTJnQTB0?=
 =?utf-8?B?dTJOK3ZiWFVSV0NGRG9NMjdMVSt4ai9qUkZLWEpDVHR2bjZYRUFBV3BlUmNx?=
 =?utf-8?B?Zkdobk9LejA1Y1hIRUU5YWtpUmxhZjA2dFBkaGxIRTdsRnZDbmQxTTB0a3Ir?=
 =?utf-8?B?enAxbmsyWDJPbzdndXdmR3g0d244ZmZRSGx4K09oS05BNk9SeVJ0ZXBXUjIy?=
 =?utf-8?B?VEYwZVpDazY1UVFHSW1EYXJvN09rQmJEL0F2WmFpVVlYZVFRNGxxNVYrVTA4?=
 =?utf-8?B?VE1KWWxzQUlicVpxMVJINTRRVENlUVpreEllQmtja0tXMG1GSHQzZHFoeUJI?=
 =?utf-8?B?K3l0QndEcGZ6Z3pHYmI3QlQ3N2dhMTVCUWs1R2djb2NtY2xiSnJ3aWdGRlZC?=
 =?utf-8?B?MElKcTBEM3B1VVBWUW1aMU91YVk2MFdXNWRvZDVzWmQ3SjNROEY2dE9vKzZU?=
 =?utf-8?B?ZlQxVUJsWmFkdnFCdUNiM3ZMbTduRjR5WmtZMTBZaXg3L1l0am8zbFZXK2FL?=
 =?utf-8?B?ZmRkVzVDYmMrVkVWdGZxRW42NXYweEt0NXJxdkordk5uZWs4Mi9WYnBiUlox?=
 =?utf-8?B?MG1BK1JRVnY4aUdkQStrdXdwcS8xWFB1cjhQQ3ZjRDE4Nlc0SGZZMHhDREUw?=
 =?utf-8?B?cXpKVnVVTW93ejVwdVVPMHpVd0ZmOGdGU1E5andVczB6ZnZrUHJXQk5JSHRQ?=
 =?utf-8?B?SVBScnRNbktBcXFlUEVIZEtjZWtJQmVWL0U3eTdGeEw1TjhycTBKdG00OEs4?=
 =?utf-8?B?eVdiNXdPVWZwTGx0aUhaUGlSN3BMRU1ydGRIWHYwN2RTV1U1NkwyaU8rVXlp?=
 =?utf-8?B?UlpaeWpJbllEbldvMGh2UWtCeDExRUl1elZHZUpLbVN6OExXTmEzS01sQVh1?=
 =?utf-8?B?SWd4OXlqbHpFT2JXZGh1OExybHZEd1EyVk9HUDJiSXRSQ284SytBbis4R3RR?=
 =?utf-8?B?aGJ4OTl0aksvL3QrQ3N2cVdVdW4vYnYzcnZuSUpBaVFXd2xvQ0pwVTZjNXJq?=
 =?utf-8?B?YTJVZ3dITlI0L1pucHFIYjcvRDNISlV1djJyUGlqU2VDalNYUzRFeUZIMmo0?=
 =?utf-8?B?bVFJMk9TTDYrdjF2cXpLeC82MC9QUmt0QkJieHBYT1JtZDE0MXViNTFUdzd3?=
 =?utf-8?B?QjFwTE82TitOcGhWWUlLaWVpTGhwOVlQclE3dWlLSzZ4QnNQQWdNc3ErbmNz?=
 =?utf-8?B?aUNnRmlrZyttN1l4L3JlcFEyaTQ0RjAwdk81QmxOZ00reVc4U3oxdHVNYkxS?=
 =?utf-8?B?QVlhOHRnaFNBZ3RyUXBrbTBscjN2L1d0S2hLY29tRURLaVpiZFdPTXJ5Y05J?=
 =?utf-8?B?Q09odHI3Yk1qQlZqUWVWVmpHZUtUazZiV09ic3VmSjJMQ0lvN1VSWE5CbGc3?=
 =?utf-8?B?VTNKTURBTHBHa1ZlOEM2czAxWUtvSitaTmY4TTV2aDNXT0dBSHV5NjBHUTM4?=
 =?utf-8?B?OS8yMW43S0RYUlBJczNldmRnNUVWdXBPRjZxOE9nelgyUEpHV0s1Y2FzYkFY?=
 =?utf-8?B?UXVQR1VQbDZWL3FjUFJmOUdURDJQMG1jUDFyTmVHdGhpMG5aMStPQ3ptaEV2?=
 =?utf-8?B?RzZ2dDBpQjlDbWl4Z3BHbmMvaGhPQUVBM2N1RTdoOWdzb2lkRUNnLzIwWHIz?=
 =?utf-8?B?NVVvNXhuZCt4cVJQSlY1YjhmZEVnZW15MlJkdHByTWhlTS9vd0lVc3d6WFhy?=
 =?utf-8?B?YXJQOTRuS25NQ3VwNWhHZnRIaGowTEZFYVdyTmR4Qlp2RWNyUElVeFNPcko1?=
 =?utf-8?B?WVBwcy9XekNGTUZIUnE3aENiMjhtRUNuaW94MVhOOTBud3FYNFc1Rk9SYmh0?=
 =?utf-8?B?VU1jdE9tRGJrMHNPQW9aMXVPaWcrREdzT1hXVlZQY0dRTjQyMjNLWFQ0bUpk?=
 =?utf-8?Q?T0nKYL0tYeocrxYUQwr3rtqyS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06da128c-0010-49fe-8941-08de229f44e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:27:38.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dv5dpXakU0TkHww34ZZnHEYyQyv3imNVn69K00awuyY7gIhtOOOX8yYTAr27t3/NOdK/4EZd7girNKKgLUpZDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

From: Guoniu Zhou <guoniu.zhou@nxp.com>

The CSI-2 receiver in i.MX8ULP is almost same as i.MX8QXP/QM except
clocks and resets, so add compatible string for i.MX8ULP to handle
the difference and reuse platform data of i.MX8QXP/QM.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
 drivers/media/platform/nxp/imx8mq-mipi-csi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
index 05fa17e48fce428e7be95ebffa645c2e6dd0e36a..f0bcb2baeabf2805f947ba92e5366438cc1d5ce9 100644
--- a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
+++ b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
@@ -1074,6 +1074,7 @@ static void imx8mq_mipi_csi_remove(struct platform_device *pdev)
 static const struct of_device_id imx8mq_mipi_csi_of_match[] = {
 	{ .compatible = "fsl,imx8mq-mipi-csi2", .data = &imx8mq_data },
 	{ .compatible = "fsl,imx8qxp-mipi-csi2", .data = &imx8qxp_data },
+	{ .compatible = "fsl,imx8ulp-mipi-csi2", .data = &imx8qxp_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx8mq_mipi_csi_of_match);

-- 
2.34.1


