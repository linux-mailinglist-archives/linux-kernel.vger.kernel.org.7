Return-Path: <linux-kernel+bounces-834289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A660ABA4589
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1023B66BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0D1FF1BF;
	Fri, 26 Sep 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FwvPPV9U"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC61EF38C;
	Fri, 26 Sep 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899170; cv=fail; b=Jon6Q4sn6yum8bavTDeVbvlV2+DiRMw5ZPXat6YqTmUiAChhcmEGcvDkLe+nrhZGtBuVSx2lo4y/IKY2qNV0sF4kYhQvb8XvPzMY4t2PpgQQHdWamjmQDhRxS93LdIqWfcEcpOKh5q735XgS48Vg8cXHqiQdc+jHfFUkZOrMTJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899170; c=relaxed/simple;
	bh=URRSlCVb9ReBRc9OzF3Yn/Jqw0I2Ui/6WdqQ+/P2aJg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=E96L1tR8VdBTM1s9gFUCbzm7mX9WTjNASk1K2ABbjCRFxxbfBVWegp40AHMUzRnDrupBP64R2bBMyTLAza3OflYkhuw7+N+O6pl6GsHQ7BFdX9TgrRX9NGoiCCSZaHoo8NuiP76SwYRC4wcPhjal+0MBMCIKhLAC4fMEGNMaE0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FwvPPV9U; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDEV7lX/GA+CTNRhCwLbKvx4Ucfr3biCAeGx+ERC9X5j2oR5mgsE9Lp5dGuoJ0VOmg2tlpzSIyuVuav0pbXUFTqkpad/kjrBPrGH9dmXs+NVutfMpjAj3vss3tVVJFR3RYkIzsDPjZWaznHl9o/zyGttRI6ol5zx24yrjzWQPOKphckhzNt2zuvQ+OY5LNhE8bUxRyHHBbNri8J3QS/GNZKvPlXm/+dyzv60K0uldNP1yY/wmT3i+Dl2Zr4tChACNsrXheDE7rBw06Ndm8hckZ9x1M2/jo11y95z+KYVieDd0nGanVTtEnYj62j1OA5Ymix1dlsGgsX5hjUKnU6n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBerYbOctpmNpJxrdAF8ys6otlyrkfF7Fef/6aFpFyI=;
 b=gqLVUrZAb7I1uOx2hFn6PR5CP3CmT4F00BvskXbp37YtS6Y48Ohfv90pwLgtWkupQw4+cqLC6Dxi6Ll1LsyKGzmRJkoJzlsy5XFF794cYs3wZfXwtdEjP7WsEWimZOGr070uyAZxCiHPyiu2GOINP/HT0xuaa6noKHN9jKJpPurfEHw4SKIFnRwYu3HQC0viVY3NqYIJ1CAhBRnaNuxphNjhkPr7o7DuCWVMUrg6ouj4H88N3BF4W6Svh0Pnc/NihK6X3zv3W2PS8VMKmiEWtFVA+N4SlDrJ5VB0t0vJzhDuLoW4XHZD8VLmP8hmyIZKyQTpi14AljEwUEtUqaiiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBerYbOctpmNpJxrdAF8ys6otlyrkfF7Fef/6aFpFyI=;
 b=FwvPPV9U0zP72bcqybM6BERCAapx9Oysu31YgO6oQoxGbYuCs119bM5veZ9FjHb/ToLHRWT3Syq6VQ8eOZ6oCw8K6Xw+LRADSQHsbEZUWMBK9Ssj0MWUh4CScN/kuD+/XycmY9r/rSGAnG4zlg6jpjCwN25LbqgqpskeulPL4T7K+0Gwrp1/QzxBsLUoK3y3vmCLF3vbWN93owjp1fmJPcCZ+0lAkmVVurKxxsri2NzZkj6x5Ipkoxfo23feToJ9e6ksYJ8o8DYwZmKDTLkFkYidHSAYG4mbR4/twZaHi8OJiPzFmz9GY4BcP0WRcy/M5EzcPu+ihot/RIou1TjXMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:06:06 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:06:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 26 Sep 2025 11:05:48 -0400
Subject: [PATCH v3 1/3] dt-bindings: usb: add missed compatible string for
 arm64 layerscape
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-ls_dma_coherence-v3-1-602b1c0ce6b4@nxp.com>
References: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
In-Reply-To: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758899159; l=2339;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=URRSlCVb9ReBRc9OzF3Yn/Jqw0I2Ui/6WdqQ+/P2aJg=;
 b=0rzog6DEg+rio0yzbfgPFEhIXrbKgFY12/FAKeM16acDALmJrWB6FE4j1gVXi/8ZYiJNlnF1w
 GCq0ZnyHScQDw0SxfLUtOvuvctuVD3EjsqD0FR/YZ22/rdtTFIGJuCz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a16a008-fb6e-4339-9dcd-08ddfd0e379b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFRyb3YwQVoyUHZ2MEJpVG8wZ2RBTEFsRFN3Q2RFNnhCUHRHR0dreVg0YkYy?=
 =?utf-8?B?Yll4bSs4a3g0VTlodEVUSUd0TEM5RE85MHVvMWVYRzlKd3JpNHhDOTNzbDFw?=
 =?utf-8?B?WkQvWEVtclFIamkzNndVSjkvK2xsb01DZnhOaGNJdDZ5ZUk0aGFnL0VQanFU?=
 =?utf-8?B?Z09UN0xpa2Q2cmg5THl2eUF3Nmprd2ZzcitDc1RqZDhCUE41b0N6Q2EyeC9x?=
 =?utf-8?B?Ui9WNmcvREptb2E3eHZlMWNCcU1WdForaUp1Y3QzcGVhVkdOMGpIb1NsSzUx?=
 =?utf-8?B?bGpYUUNkZUtYWGlRc0xGL2hlcHU4TzNBbCtjU0Z1R0pZQVNLRWJFNTRuQ1Qy?=
 =?utf-8?B?UmFyeW43L3BvZTlHRXQrSnNGY2FCZkxlVlRiNXNoS0xKTDdER0tqZ3lkTEZV?=
 =?utf-8?B?SXA0UFhKK3dWZlJ4QXBvTFVRNUFhTDRlOGM2TlZXdVZBejUreTg3YkJZL1pa?=
 =?utf-8?B?ZWxrZTNGem9maVhaZDlQZjBlZWxRckhQQUU4TEcwOXZnK09wV2hyTnVFTTly?=
 =?utf-8?B?OWwwbkc2dlFzdjVPT1p1QVQwT0luR21hQm8zRWRuME9CUjVXZi83bGltNWVa?=
 =?utf-8?B?SWplSVAwRlZjdERqQWhaU2FyTkpCcGlrMW4wYUtzT1FCZDhmMExJSUpUNkRT?=
 =?utf-8?B?NjREWFQyNjI4bURtNGtBU2tnMkRFWmM4RENHVUgvWjlzR0NudlZ3dWV1REpC?=
 =?utf-8?B?aFdvL3ptVHNwcldXMGxwemVNTTNCUENNN1VXNWdkbzV2NVJERnliNU8rWXY3?=
 =?utf-8?B?V1AvTGhmdi93ZUdFaGY1NmpueEh4Y1VKS3lvUHFKNXZhS0tTMmowL2NSbHpr?=
 =?utf-8?B?WFA3dmJvR3Bja0xsbFFEazJEVlA5blg0YlBvU053VGlyTVUvMUE4THhnRHhD?=
 =?utf-8?B?YmdmT1A4bUdJM0VrRmZnMEVMamZMTHN4SHcrVWIrei9yMXk4cUtQMEZsWTdi?=
 =?utf-8?B?RnlRd0xyV3FyRndJWjE1UUF4ZjZScjZteDhFNHpDSXNRQk1jQ2krZHhEQUlw?=
 =?utf-8?B?UGViK3U2Wm1Uckdwb2dxZURKK25SY2MyOEsvMjBWRzhOVElseEcwZXk3NGJO?=
 =?utf-8?B?OGhyTDVaTThIYnVOY1dPR0gzUHE4VkNBNjgxMEFWVklPYXFYYkxNcHBvWG5U?=
 =?utf-8?B?ck9wTWc1VEpqQTVKN2kxRUdTWTlIcS80VXkzWDNObzBGaC83L0thSDNGOHE3?=
 =?utf-8?B?eERqditicEgvTm5vT05WKzJlNXQzbllsNFFoNkpDenhpTXNLME1aejlqZTlH?=
 =?utf-8?B?K0JtRURlS3NlS2Z5WVFqYU5LcEFySk9rZWdRNkhaRU9ZTG9ZRmFTRHZveWdO?=
 =?utf-8?B?OUQ1YTUxSmEwVW0zUDg5a1VHSGxzVUxuNVFWYWhUazQ1eE9VaE8vOVRRYTZO?=
 =?utf-8?B?TzlFU28relR3WlNWUFY0THZVMW9DL3B1ZHhaMjMzSFRHNzFDQ2tpTmJSZjN2?=
 =?utf-8?B?Mzd1OElHYThQeUx1dG1sUnFnVmJOTi9sRnV4Y1RreGtDdUY5NDlWNHZ6ZnFT?=
 =?utf-8?B?TjE0SmZHc0lFTDFENlJqM3BRUHQ0M1lBSXhkK3NoRmFlSlNoM0tRbUxiTVEx?=
 =?utf-8?B?UXBnZ2hWRTExbVlkenhrNjVHVlBiV2N1K2VJWnRhR3Y5TXNYdXZPUkRRdFFm?=
 =?utf-8?B?VzJOWHMyd0xEeG5INjNVUmYyQUwzZ3dJL21FUVFvZGg5bjZLekFaWW8yQWVR?=
 =?utf-8?B?TEJpQ2lWSmRJdHJaZEJtRHBySkR5U2xDQS9xY2FqZU1uUjRiOHBQcnI3WExi?=
 =?utf-8?B?WE1SQWphUUtkYzhHKyt0VkNZa1FGak5nTnhiaFg2VGFFTkpIWDJlVm15UnZN?=
 =?utf-8?B?RFA4aVd2L3pDMGh6VWVMZ2huV3lRZEVGQXArejg5a1IwSTF3SWVBNEVjVDFF?=
 =?utf-8?B?RDdtM2NMZnR5bE1vemd4dEtrVml4ZzVPTXhCcDBhQ2hhbUJHVGlFdlJsOUtl?=
 =?utf-8?B?anptYjRmMXNDNm04TVBPaG9iVFVHOTIydmFlSkRESnArN2NPRWhwOTNZeHoy?=
 =?utf-8?B?RHdYQVc3NXB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VCtqQU9KbzJHV2RQSUl6a1pVOTBadllDK0NNeldQQk42Q3NyTU9TeUczeUNm?=
 =?utf-8?B?b3E1RERVT1BzY21ZQmVzZlhrRzhhcGM5MzF5SVA0dW9rcVhLOUlzQXJLYlVy?=
 =?utf-8?B?QWNSS0dCWkwvVnhVWTVJdlU4Z0VBMHVhM3FqZzA0SzcwajFlUzM4TTNuNzl0?=
 =?utf-8?B?R3VhMXR2Y0N5ZDV4aGFDMFlHV3A3R1crOG5Mc3l6NVJDVXhMS2JNeWdrdWpa?=
 =?utf-8?B?U0FkeExrREJ1UG5DUGIyaHZWZStYSFAxY2RyVjkrZUZoRm4yaVZwdUdWelJa?=
 =?utf-8?B?ODRlR1dGMll5NmJnT3B2Y1BLbzJhOUhMZGd5aW15Q24wUEsxeEJPcnBzRC9C?=
 =?utf-8?B?THFvUDJTbWYybU8zSkt1MXRWanhDVnBoSVNCN2dpWnNkVGFTYXd6SW1XV2xQ?=
 =?utf-8?B?eHQvODlxcnN6RDg3L0lVSll5WjlZTS8xbXRiZnpKakJkMURiZ2lwTlhEYzlr?=
 =?utf-8?B?d1VOU1N0a3NBV1lENlFSOGtsL0llbUhGbFdxMG5vSzc5aG9jWFBQUHpxSmJL?=
 =?utf-8?B?K2hmUGVPUXRGMXk2S0pMYk1QNHY1UVVRS1RvOWdjVi9GZmNIRlRlcW41RFJC?=
 =?utf-8?B?YUlMbmIzWS9BaHRyTDVFTnMyazBSMmpwWlV3c2pQQ3drVzB0ZWk1L2NTQWJK?=
 =?utf-8?B?WFduQnkvZVNkdU5jVTNMZXJ5YjVINXV6WFk4Vm9scVBRbjdGV3B4bkoxNlRD?=
 =?utf-8?B?VmNSMENIUnBHMHVSUzFpb0diMk5WMFlYZlFGbkVxOUMxZ050Z0M4em8wSjJB?=
 =?utf-8?B?S3JqUHM2d3JnNTk0cjFyWFZMUjBxMGN4TDlTaXVNRDBoa05XL1NVck1zaHNI?=
 =?utf-8?B?eUdUWnhNY1o2UWFyRjlMSHJDbm4zNisvVS82eURGckhlT05YK3NVRVRpUmo4?=
 =?utf-8?B?UTFOOEZjRysrTHdjZ21lM0tOaUNLMU00cEpaREY4SXI3dHZTeXFONEtaUVg0?=
 =?utf-8?B?aTVvOWx1WkJxNGk4N29YRVFqbDNkSUFBakV3S1VjQnVoZVpydC9tK2hhTVlj?=
 =?utf-8?B?OUErT3paZU1wcmRaYkkxL1RJYjlWSWx5SEpEYVk2NUZTQmRaRkRzUC9IUnNU?=
 =?utf-8?B?NWNmQXk5TktMQXE1WDlmQVZBNTJ4bi9aWTFIdnNLY3lDbGVKTUtTSkJjSk0r?=
 =?utf-8?B?dis2WGRoSFJKQ3FrTEJ3RHJHa1c0ZWxoTVJSUkltai9TR3hWU3FXVnFhT2Jo?=
 =?utf-8?B?WlcwbUZ2WmFPYUxnbERjQmlSd1ZEY0hPUXRBU0xsbk9xK1lhUVo1NjlRZEpm?=
 =?utf-8?B?c240Y2lDMVlIQmJWVUFuOTZyaER1RnBqOW11VURTUWlFeE1xTGFVcGIySmh2?=
 =?utf-8?B?ZTlTM010N1pxUDBrNVhqNWo1UElubVIwT3hwRDd6Q0pkNFc5VFdlbWN6aFdM?=
 =?utf-8?B?b3NMNHMwV2U3NTRITG9qYk1mamFGalptOE8yK3BqUHp4b0NMV1N2aVZTazgv?=
 =?utf-8?B?ZmVHUmNydmZqYmZFeEhyNE9qaWFlZGN3OTU1Z25xcENIbGh4eU42dFpiZG13?=
 =?utf-8?B?LzZNUE5WT3dFVWxHME4wcWZYWHJNYklQL0V5SWduYUlXNVl5MU5mOURHZzRU?=
 =?utf-8?B?SkdYQ3dzc0J2Q0ZWbmVIMFlDcUJlREJ6MWM3Mmx5Nnpyb2RJNUZBbkZaaUdt?=
 =?utf-8?B?WkVyNkpDMWlmQlN4WDhWbHZOalRRNExqK05TRjhVM3dnbVk1U1IzTXIxc1pw?=
 =?utf-8?B?aGl2a1MyNHQrTnM4QytoZ2U0azZIUzBpUHVKZ3EzVUNDT1FCdFRoN3lsanJG?=
 =?utf-8?B?UmtMRVFiRkZ2UmVmZzg5VTQ0RTFCNTFBT0NvQ1pvdUN6ZjFKVXljOFdEN28y?=
 =?utf-8?B?blZoL2w0YlovTGRUWWVZNHo5M05XRDIzaVRCejFCMmtVUUkzRkowZTFuaUxt?=
 =?utf-8?B?N3hMbXlMY2RJUHA0dnduOXo4bjFxeE0zeWREdEJBVUxJMkhXNWVHc1gxV2JI?=
 =?utf-8?B?WXVQeENtN2QrUk45Rlhab1YydFA2bCtPWVVwbGxZMCtvdWJJWE5XK3pPb0Vs?=
 =?utf-8?B?c3hsM3Jmd0w2NVovdXArbUlmTzM3c3dYUElJMHJvZ3ZSWmx4a2VFWk41dEMr?=
 =?utf-8?B?RlZ4QXd4ZlpOTHBLZkRBWmU3V0VoTWtoRXJDeFVrQ3BTT3VXVkRHZ1NNK2g2?=
 =?utf-8?Q?cQ/2PqXAaD4Ou9gZjbIEQRYPR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a16a008-fb6e-4339-9dcd-08ddfd0e379b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:06:06.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbatXkNNaHbt03KzFL4bnf6Z2yDFa7j8lc8AwHV75NZrWd8cPmJNZeQTxPc5x+XkhQJsB+ewwWIgR6TvjdLPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8960

Add missed compatible string for arm64 layerscape platform. Allow these
fallback to fsl,ls1028a-dwc3.

Remove fallback snps,dwc3 because layerscape dwc3 is not full compatible
with common snps,dwc3 device, a special value gsburstcfg0 need be set when
dma coherence enabled.

Allow iommus property.

Change ref to snps,dwc3-common.yaml to use dwc3 flatten library.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml b/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
index a44bdf391887f9c7d565c01d2c3aede99c4a9fc3..4784f057264ac7b18cbc8b41a405f9c9268605bb 100644
--- a/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
@@ -9,21 +9,19 @@ title: Freescale layerscape SuperSpeed DWC3 USB SoC controller
 maintainers:
   - Frank Li <Frank.Li@nxp.com>
 
-select:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - fsl,ls1028a-dwc3
-  required:
-    - compatible
-
 properties:
   compatible:
-    items:
-      - enum:
-          - fsl,ls1028a-dwc3
-      - const: snps,dwc3
+    oneOf:
+      - items:
+          - enum:
+              - fsl,ls1012a-dwc3
+              - fsl,ls1043a-dwc3
+              - fsl,ls1046a-dwc3
+              - fsl,ls1088a-dwc3
+              - fsl,ls208xa-dwc3
+              - fsl,lx2160a-dwc3
+          - const: fsl,ls1028a-dwc3
+      - const: fsl,ls1028a-dwc3
 
   reg:
     maxItems: 1
@@ -31,6 +29,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
 unevaluatedProperties: false
 
 required:
@@ -39,14 +42,14 @@ required:
   - interrupts
 
 allOf:
-  - $ref: snps,dwc3.yaml#
+  - $ref: snps,dwc3-common.yaml#
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     usb@fe800000 {
-        compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+        compatible = "fsl,ls1028a-dwc3";
         reg = <0xfe800000 0x100000>;
         interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
     };

-- 
2.34.1


