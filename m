Return-Path: <linux-kernel+bounces-720193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11FFAFB866
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647723B7995
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D4225A5B;
	Mon,  7 Jul 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bMtrw/YY";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bMtrw/YY"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021134.outbound.protection.outlook.com [52.101.70.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A3224B1B;
	Mon,  7 Jul 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.134
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904749; cv=fail; b=Qosdb4uN2OcnjwSM0Ldt4Uos/O6JSWCA9wXBjzhtE2RS/Qy6MauJkoBLMxOrHEuEk1GbqDdgRN0bd3QIrlLRMYDQSxE27cCJSVifRWx63kCBQdBEj45wk1uR4O8gQ6t9d0y7FkhqnJMNo4yGBxrGGmpRIjeNjMfzS2vU7Ah0hGw=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904749; c=relaxed/simple;
	bh=+pQvdPRd2dNiVYNuqZ+3XQh9Nq7EqJa24L044aT7QyE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lixH1anONY+JDy3bZ6wHDl3Yrkul6ztulX3FzFN8wJZn77PUZxEG+iWYAO1a3M4vd9hybsniSl1yFtm2ahD/3Cx+KHKhMCYBIx/QmFZfz+Fzzbe5b9qmjdLN6taj/JxoSUA5pzJmK8MkCsslvosMiogvSZZCXVSxOp60K1uNwcA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bMtrw/YY; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bMtrw/YY; arc=fail smtp.client-ip=52.101.70.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PRz+mbKenBRuL+eCVqIm7V7GfEbvjazgManjLkLeWCSCFvvpJMFUeXXeO+iqox7Ti9jaDoqdUbsyUShOIBypOyyG7wcPaHf4u54+aHfXYKKfoz5UiMw0sPN1+59JczEmz+xKbqmAu3+lZ0RfZpaiwM2/ZjuoJ1SxEXiHcuOorRilH4agTBBRA92s5oX0fQfcUNFbjnsKtDLHxcsVMV4W9ZBeL10bLqXeVl4vD+57NwA9499PuTuoMZUEhOIoModbeRYPLlVHVz2uUifUG51BuiSjK3sbJ9NuReo9tx7ucQX4cICs5AZB8hy0lAhc9CaNPAukRZMLQ32IN+VjCBIxxA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yIaivYnD+GSJFmmKMTlDSUfYKX4SodWn2qFqv1vHck=;
 b=sYEAWhOP9t0lMJni5GIx/KeYR2ihtFLiDMWBfOcgioNniSwvg8SP6WqDbn0ESr7fGIS2uylU7fWCCMfq5C8HbrOv6x1kj+Ce9C2829/MwD/s1DMJTTjCA00QK8qhyJ980iputIAtESLEn8fgmncBgi0N0dxKJR9C45D/alNKe6ztLOkzCNI5cD0pL5D4kcuC0WJIkQzz/y5Dkd+cLJ7Y4jBwcw5cBIgRGVM7eWYqXSuyxW55jYNoZpCHpT0Ht/vHwVhwuTbMKGG4FdxROkf1bNl83nyA/RpbhO9Cfa/V2HvBFMXxPY/NF/U1YK7q4pN2gGLM9W5tdCjqcpO2pNkziw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yIaivYnD+GSJFmmKMTlDSUfYKX4SodWn2qFqv1vHck=;
 b=bMtrw/YYo2VwPKznLFvPHKdr0Pk0WkvfZs5y09TqaV5x46Zh/Qhl05YQ9vZX9DpmNwoYVLnJnxCLtFavUDsmHMnZ6NqQHglf/J5B3EheFSKSOG4HtNsHA8adCY2osRhpwrRalNJ8EoXYE+nkf6O6lPWnXxa+IUwW0J+/YvV8510=
Received: from DU2PR04CA0173.eurprd04.prod.outlook.com (2603:10a6:10:2b0::28)
 by AM8PR04MB8017.eurprd04.prod.outlook.com (2603:10a6:20b:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 16:12:23 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::88) by DU2PR04CA0173.outlook.office365.com
 (2603:10a6:10:2b0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 16:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 7 Jul 2025 16:12:22 +0000
Received: from emails-7501188-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-201.eu-west-1.compute.internal [10.20.5.201])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id C769980195;
	Mon,  7 Jul 2025 16:12:22 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1751904742; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=9yIaivYnD+GSJFmmKMTlDSUfYKX4SodWn2qFqv1vHck=;
 b=J0hsuziQ3uIy+ASunev8ZpEQzmNcdWy+5b3gpEp3obAHhZVVFGzMRaQffUL+dxe5elCCD
 mcJMqWYpesqsZqvm8mKwX2wrK4EK/0stZDKF5Wdja86PzhewWiJJMA21mRZDyWG5BR7DdIr
 0mDkXNpla2ymYzb+iAq06tGtWjXqYg4=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1751904742;
 b=EzHSPKTzVAHZPrlgBSvFCHzA4ldI9jvhsoNqAXP7v243fi/pVclgp1s8v1wpEno3SBvKq
 mDdAc3w/fck7Qo7jZhSqjMiW7gJMETZmlgJs2MspRa1GESeNNj2TuOJB2yrayKrv9p2svbV
 R4q/hls0a8oysDRk+y/acMnEHDYA1g8=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkL3sPAEn3mQeL/pxc4YD9Hd9tVSi6u8WY1g1RMC+CwyXiYSPGDvq2gF/9oaB/atm0XmYtBFX8JHGCuDEwD8G/F26O04UebUFtV/Lr5oIGLj5uLzEfylYwhVwzu7pfn2h6OpUuCPFbWAfHuNQcwwFGUclUY2Um1blTUAaBrB+nzVobZXT9Q4EMHbpx4Wi/fS5GfVK7B0X0YlTfafdRMZ0qbaII6105WWiUUsxn7CAuGhHSWbU9cizuiJLEWOAYjDU20QN5mlKQrnbcQdItPU2ElS9Ne0LZPdXmLStSx9MhDRhYdaTqMEi45a65laJYT1cUhOvtV4QO9gft4f4GKIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yIaivYnD+GSJFmmKMTlDSUfYKX4SodWn2qFqv1vHck=;
 b=ZV4h9OPdDWt6LRfEfI7q4rXcB0JYpebdFECk5vCyfctrhNXZXwQgSaXOBLDX8mvZfWozWm7Icig7L17bRuzL6VzoUvDC7po8JPb2t35/rgQzwIPzib94b7YQrYTB59fK50Y0CLRQiey5a5Fnh3AFvQYuvuQNvCub9+7A1HOQtfphiZ/KryVz7y+6BgS2HubLnVlGh9XUg8Pe+/ROugDg+SFPno1kMQikzJ5c5eky9c+tciNxpODQ7sjNr3uAF+6Dg8OmCzQF4tvj1SFlzpyBZw+GTL+FQCdDxu12+EYi1LUgz/JSBKi2AQCaBt0zhPdAXdJMLWzZ3d+ADuVRDs8z7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yIaivYnD+GSJFmmKMTlDSUfYKX4SodWn2qFqv1vHck=;
 b=bMtrw/YYo2VwPKznLFvPHKdr0Pk0WkvfZs5y09TqaV5x46Zh/Qhl05YQ9vZX9DpmNwoYVLnJnxCLtFavUDsmHMnZ6NqQHglf/J5B3EheFSKSOG4HtNsHA8adCY2osRhpwrRalNJ8EoXYE+nkf6O6lPWnXxa+IUwW0J+/YvV8510=
Received: from AM6PR04MB4567.eurprd04.prod.outlook.com (2603:10a6:20b:19::11)
 by PR3PR04MB7354.eurprd04.prod.outlook.com (2603:10a6:102:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 16:12:11 +0000
Received: from AM6PR04MB4567.eurprd04.prod.outlook.com
 ([fe80::6d60:a27a:fde:6c1f]) by AM6PR04MB4567.eurprd04.prod.outlook.com
 ([fe80::6d60:a27a:fde:6c1f%4]) with mapi id 15.20.8880.021; Mon, 7 Jul 2025
 16:12:10 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 07 Jul 2025 19:11:56 +0300
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: Add bindings for SolidRun
 i.MX8MP SoM and boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-imx8mp-sr-som-v2-1-785814ef09a9@solid-run.com>
References: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
In-Reply-To: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To AM6PR04MB4567.eurprd04.prod.outlook.com (2603:10a6:20b:19::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR04MB4567:EE_|PR3PR04MB7354:EE_|DU2PEPF00028D0A:EE_|AM8PR04MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 75111787-04a7-499c-918b-08ddbd710e97
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Qm4yd0loK1I3ekhFbDRITU1GOG9Wb1Y3NDBOekpPMnhDQktLSnFzNVo0Qk5u?=
 =?utf-8?B?K05KY04wTnpsSDNrQU54NU53UTNQaGpyQW5qYnZuNHJxQTdTQ3JzSmswVTVs?=
 =?utf-8?B?b0tWbUZhc2s3OEx4ODdUVEN5aHNQcDBRZW9pb1l1MjZCR0lHZ2xkekFkVkIr?=
 =?utf-8?B?eVNwRm9hOFJSNitiaGZ2VTdIU3BZN3VEYXdCSERXZTlCb0xMQS81L2VpTDJ0?=
 =?utf-8?B?WUtmUzB3bUZaSkgxaVhkN3g2cGFnTlpuMlRBRDdpaXZZRExHQmVDakFrMzJv?=
 =?utf-8?B?dHZpN20rajdUbUszbWNGbnVrNlY2NWJtSUlFeHRGOVJ6ZnVhVUtIaW1MMlRo?=
 =?utf-8?B?RnIvZnJMbG5sYnEwUm5jTTdwTTdCdXZCUlVEY0owcUdhK0hGK1lobVN3cWFw?=
 =?utf-8?B?MFVDK0g1S1hpQUpXK0EzNnZLbS9ULzJiVXBHcDdrOWlWL3dhSmFNZ0lMMWE1?=
 =?utf-8?B?QUp5ZWltUGFsVXppWEhCZkxpSjg2UU81N2NLRHZ3MVMzNmdTL0FQL1pxdG9O?=
 =?utf-8?B?VzI1T3Zoa2xIa2hjQ1dDcGNWVEwrcWtRNVFGdlorL3E1b0c4K00wVHA1c1N3?=
 =?utf-8?B?UWthYkJkcWpaSjdYUGRaM2JLSTBnWTFIZXNRbnVNU3R3eDVVRVBvU1E1T2cy?=
 =?utf-8?B?TG9iU3V4RjM1WE1FS3IwLzlIempoWEI2aE9vMzZwNWw4T0JZc3RGb2xVZHNE?=
 =?utf-8?B?c1ZRVWVodllkRUh4NHMzR2srdnA4YlB4Rk5xS1NhdG5hZ3l3UWljQytPczg0?=
 =?utf-8?B?MlVLNEY2OXlBdC90S2VkZURMQXNjZVFpaGgwcEJKTWxlN0dHWE84akoyWXZ0?=
 =?utf-8?B?dzY3UnQwb3JBb2ZQeVo0cWlxMWhtS1ZMTmhZeW9Db0pVTFcxY0RHbU9WWmJk?=
 =?utf-8?B?SFVoeVE4Z3daVnZMMzB2alo0Mm1TV3J6VmRaNFRVbDhMZ3NaeVdwbW9VRVNH?=
 =?utf-8?B?TjhZaytzOVBZL2grTHRlVlZINlZGYktvRVdYRTB2UkpzWmdqR011NXAxNytR?=
 =?utf-8?B?Nkc3N3FQL29yaEd0dGtxR1k2NWNmYnpia1RBbkxNRnd6WlRsWkVVK0dLMGxJ?=
 =?utf-8?B?RHdQcFgveC84MEloWW40NW5hajhJeHN0L0psZ1AxMmJ3WG00c1QzYzZKbmdT?=
 =?utf-8?B?MGdRMlhoMzEzYlljWWZKMFRxNGEzY3hVL1UxckRweDdvdVRrN2dqclpaS3Rl?=
 =?utf-8?B?eHhERUt3dWZidkNlWFhtYW5zbHluaGFWSjBKVk5BaTdjOUVPTllvc1RkcENJ?=
 =?utf-8?B?MHU2RjIwdmc1SHVkK3c4Rk04MVZmMmhoZnBJR2dKYW1ISFd3VW1rNWVIczNG?=
 =?utf-8?B?V2hCNXdrQ0tXU3h3cjFpMjBzdS81SzNtZy9BTWdGSHBuSGhwVzJjcThBYk16?=
 =?utf-8?B?akFyb25OVFhrL0M5dW5XNW52WUdzcnVvN2NwRTR4VzJCTTlmUXRRbndMa3h1?=
 =?utf-8?B?ZFVGMWp0NmN5ZWpuaXVrM25xWGN4WHZDZ3hhTk9KeGU1ZlBQaXI4M2M1dUZY?=
 =?utf-8?B?S043TUFId1djM083OE1VM0w3ZGJ2WkdVdlpVVW1mSVhBWWFWRU9vVGQ5VW05?=
 =?utf-8?B?bmt5dlRPM25ZTldQQkFDbUh5djRuMnVSRk1BTjBucFZEaWdsSW9kRC9TMmdH?=
 =?utf-8?B?UmQvMERBR2o1eU56ek9uR1JYTC9ZYjdMbGkzOTB2SjFaZ01HdnN3SUEzZHNq?=
 =?utf-8?B?K0lSZzhtblpFZjEwSTJkK3NpcXU5VTh3ZnNVUlpTaWxZbkhUNTFYUUNjZlF6?=
 =?utf-8?B?T0tGQUJlSnFYNWp1UVBKQ0NMTFEvdFd6NWJWVDdWM3NrcDZGUW1abERwc1lk?=
 =?utf-8?B?K2xIUjQwZTRJT0hOd3RtdkQzcmVmeVVVaGZRN0JNd3MySjhUaHl3OVA5MGta?=
 =?utf-8?B?d3dITDFBYmNTWFdIRllaemMzNWNLTjBkY2pZVjhFVXVXbjFjSmNJMEpYNWU3?=
 =?utf-8?B?em0yQnpyK0pXUFY0R1Q3SDVubDVHR2VIdldndU1kTVVuYlNFcDNDL3ZIcUxu?=
 =?utf-8?B?QXNjVFh2K1BRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7354
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 7e67b0b77db846129e0729816cca35f3:solidrun,office365_emails,sent,inline:9dc78d7a0aea7e94852b4c8673104263
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	94b06322-31c9-4e0b-0b76-08ddbd710733
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|36860700013|35042699022|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUovLzNMRktieHBvWFpreFBmREtzSVpKNG9IcmszaVhwM1Q3UE5VSlowV2ky?=
 =?utf-8?B?bDZ3TGNia0ViVkRLZDFTZGlyejJGYUlLVmlleW1uSkVZaEdveDh4WWIwQXNu?=
 =?utf-8?B?U2gvSFJ3M1NIMmgxZ1lhVUJGbU9oNEpBRVN4dDA3Ly96QUpCMk01enF3bVRs?=
 =?utf-8?B?SERaZlk0V3FFcUUxTSs1ZFQwNld3TGxVT3ZYL3JXNERxTFNtUHlseGhVMGxX?=
 =?utf-8?B?SUo5ek5iNjJ5U2VqWnFjTTljNmNobjA1OHZXNWhLeWNqV3FxUGY3a1NtdDhn?=
 =?utf-8?B?S3NXYmdZcFowZEpqajQyVDJGRFhpYmVTd096WEozMFpjZEJhaFpPNlRsamtk?=
 =?utf-8?B?SjFuaW9kM0N4YVB2VkwvUVVxWW93V1cwc05HcVpsaWhlWXRibWllQnFoRGUr?=
 =?utf-8?B?d1JOSW1EN3hKY2xpT3BMNkpRTEV6Kzd1ZHNZeFFoT3E4aDhZQWROcUwzUVBF?=
 =?utf-8?B?UEtJamFYWDVZUDhwVVVoeWdHcEtLVFY4Z1FRUFRZTEJYVU41V3NHczA2LzFT?=
 =?utf-8?B?R0t6dGhzeXhDNGJHemxzOXlIT0NqSjc4a0JIalVqZ0NBcmxsUDFEMUR0bm9h?=
 =?utf-8?B?ZkxWWnJpN2NPYklBcUhOcTk5U0pianBFcmpqVWJGNU85ME1ZNzZKR2JxbVlv?=
 =?utf-8?B?cUwzUERPWDFTbXBwbjlUSktOV1piSnNrLzBNWnp3V1hOTm1sdVNieXBKdE13?=
 =?utf-8?B?TGlubXJvUkUvSFpIUnNOSmNhZGd1eGlHRjc2L29kZDhVQzRiNWhyNG1RVUd2?=
 =?utf-8?B?RGhLMlR0VFFnblhDcCs4cjVUK1RKelFBS3dkeWF0TWV2OHBvbWxYNjF6NHg3?=
 =?utf-8?B?Qlg0UktPblZDdFRLQjg1Q1pKYnFnME14WEl6VC9Sd2JUZWx3b0VOQ1B4NFdt?=
 =?utf-8?B?bDNyNFo4OWRyUkZDWVRNWTRMR1FjUFdlcUpYSDNCbHBPUVhKWDVZZlQwelNy?=
 =?utf-8?B?dXR5ZUsvdmVUOFFKUmtUb3laZTdhNDljSTdDcjBmZ3pXTXpGVGh5SG53NWgr?=
 =?utf-8?B?c1luYyszUHVwd1pudUVOM29vZHpBcEZzRmx3MWZHYysyNlpuaGFPZGRYV0tr?=
 =?utf-8?B?bDZBT0EzYk44MXlSTU5DRFd5ZDVHWGwwNHVMOGZ6N2VxMFdqWmFOcTB5N2w5?=
 =?utf-8?B?TXZZK1c4S0tCWXZkZ2huQnlCZnVielU5UjdRc0diZEpPRmpTUU5wVGg4Zm1C?=
 =?utf-8?B?b2swUE82Yi9PNi96MUNKbWNxZW1yZEM1Qk8vdzV5ZmVzWUp1R1dGaUZ4N0E4?=
 =?utf-8?B?eXJFUTRPSDVkTHc2WWcyK3pENFp0WUp4dERPckFKVHBxMURaK05QdEx3azVY?=
 =?utf-8?B?S0pRak9TZDdsaEx2WWhLQmh0VExFWE1mWnJid1pxSzQ3aEQ3bWRBQWpuWUZi?=
 =?utf-8?B?U2pyQ2pSaDVIejVhbmgyMk9nVUI2MEE5U2ExSFg0QVZtQmJEUFlZaSsvcjlw?=
 =?utf-8?B?T1ZRQk1IcGRvNWFrbGJqdENFbkRhQkwxSFJONHJpemFZYjVoRDdkOGdHQ2hv?=
 =?utf-8?B?QWt0bTlSUDVBWXNscnpxQ285NHM3R0dubkZTSUg4Q092RUFrSVlGbkVGWlFv?=
 =?utf-8?B?QkwwTWNnNThESFhLUnFKaWl6S21EZ2FYckE2QlBobHlDSWQwSzZLeGJtckZN?=
 =?utf-8?B?VEg1VDlsaytOYklqTTQwamMwREw5Wmh5STY3WjhOcVRsK2ViR1V5YjRQVzFZ?=
 =?utf-8?B?Qzl5MHVxUi85TWcyMVlYdTRMa1lGN2pUc2VKcndqOTkxb1BEWmVVZFRFNXVY?=
 =?utf-8?B?Ym55VWRMNjdwN2hhN2xFVHMwYXBsaHJWdzFsaDBjdnpBQmdHd2VPVllnWDNn?=
 =?utf-8?B?OWhFUy8zODFWdGtsMTZCVmh2Vm05NTNmWVltVVRzTWM3Z1d6dVFZZDV3aHkv?=
 =?utf-8?B?dGpIWExXc245TmE2OGNnMkNEdldUb3lqdkNhOEMvWXZQWGdwY1pSbU9DZExz?=
 =?utf-8?B?bytUVjJIRTRVaS9oTU1XazJsVnk4L1ljVDZZaGNJK05xSjl2SE9UblZXdWw4?=
 =?utf-8?B?OVh2MUk4aVBiQzZJQWxmRmViVEFpUjlmdmRIK1dPOXo1cUtueEYxMjhJUW02?=
 =?utf-8?Q?Z+HnX8?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(35042699022)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:12:22.9828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75111787-04a7-499c-918b-08ddbd710e97
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8017

Add bindings for SolidRun i.MX8M Plus System on Module based boards:

- CuBox-M is a complete produc with enclosure including the SoM
- HummingBoard Mate/Pro/Pulse/Ripple are evaluation boards with common
  design but different available interfaces.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d3b5e6923e4166e35760c17c772aa0195137de93..1462023f35b7be47a5cb855fa64025d07361d550 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1189,6 +1189,17 @@ properties:
           - const: polyhex,imx8mp-debix-som-a       # Polyhex Debix SOM A
           - const: fsl,imx8mp
 
+      - description: SolidRun i.MX8MP SoM based boards
+        items:
+          - enum:
+              - solidrun,imx8mp-cubox-m             # SolidRun i.MX8MP SoM on CuBox-M
+              - solidrun,imx8mp-hummingboard-mate   # SolidRun i.MX8MP SoM on HummingBoard Mate
+              - solidrun,imx8mp-hummingboard-pro    # SolidRun i.MX8MP SoM on HummingBoard Pro
+              - solidrun,imx8mp-hummingboard-pulse  # SolidRun i.MX8MP SoM on HummingBoard Pulse
+              - solidrun,imx8mp-hummingboard-ripple # SolidRun i.MX8MP SoM on HummingBoard Ripple
+          - const: solidrun,imx8mp-sr-som
+          - const: fsl,imx8mp
+
       - description: Toradex Boards with SMARC iMX8M Plus Modules
         items:
           - const: toradex,smarc-imx8mp-dev # Toradex SMARC iMX8M Plus on Toradex SMARC Development Board

-- 
2.43.0


