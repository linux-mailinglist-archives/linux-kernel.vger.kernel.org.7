Return-Path: <linux-kernel+bounces-896222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C201BC4FE81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C773B9A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA035C1B8;
	Tue, 11 Nov 2025 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SoOjmree"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CD35C19D;
	Tue, 11 Nov 2025 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897378; cv=fail; b=uMbn15uuFABMgJmP/Uqi9E/2wwtFqFnrVXUsGEMzbc+j3aY/VCwDiNXGWnF20WmwcoC6ZEHU+CDMXoUOFUIkBexfjjuthYRHTHh6HEVQ/wKUjD/VFFaIrkwd0kAHbdVzhqTq0KWuujFEx8XbCzPiCQ5of7lWPEnWAQV/6qQK/dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897378; c=relaxed/simple;
	bh=HUtJfZ5UwnVY167yFTUryLb7oW4vhVqma7POuJNTdq8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CAAAx61/2E8jMqi++rlMH84htrUuA/xfpemsRMjCp2uLr10erdmQYjTYckiOby/cT7rFQ8fE78E1KXxEs2gmrMyvme4YQRPzybelvXadSe5ta6TClN7cGPxmZrGDnQh3gsiEhQc8ujQRBebg4qOyxwiyWA6OjVTc+qoZJvTflm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SoOjmree; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSYWFHEGI5p3tG/Bv38MBuV9Gq9OSdhi7VADu+yhrW7OWzgv0F+wMr4fTdyvlguYuPQVZQv9Feo0I1m7e9dxhvaN1C1sp9DV0bALYQalk3UpR3TyszKc1+cN8RelWNnSr98AbK1m2jMx+eQrnndGIHp0yaJy6N5G9tIYbCdNix9fi3561JjRpoOcxYjyEFTfbiB8mjLIGJiPpbSwJEgyfZqL8GWTrYU3QR+EMNINka8nHsMtvwj1QyydEnJ7DJg6SVszi/bTpON3K+qDoSpGs9qyjN6tzavkzifNjJgbnkN0GHdsgLveRig04Gs4VXIOPZO8WMivkvuuS/f8GLFelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXO7m7C7aW85x0I8vOEzC/LeMjS7hFhZOXZcN/YC39I=;
 b=o0FYMFDHseLt1Aj5+OxlD65xKGnFkVDxK/Z/zKRLjxiCUSM6X4kWnaFl9GMNulwtmkG6C1v1j2GImX8k/Cwzz7Y0750EBk08JTwZm9NRc0+d4lsUTixcOTKdM+PnL06GbTsWPmlcJqcf/D9ik9mG0LTW2OqLknD28j2AqJXe/HPx6FNP5FCz/Cofu7TNiWx5TAVcplXXHM1htG3HzN+be2SZqpkET6z4n9pMmJkQCVV+oBfIFVZLzc6ooMi1LrK1JTf5s/lIgZvO5/DYUpZypW6xFScqEJlVlma83waxILc42adUZ37qstVuxLozurZpYFETGa1/V8M4vdNQjR/14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXO7m7C7aW85x0I8vOEzC/LeMjS7hFhZOXZcN/YC39I=;
 b=SoOjmreeOBrnmB8wwATnNmrWp3kgznxmHSSDBRV3WXPGZkg5FM1uSkskikHl2Ott8WJys9rQxvN7fNeBUkuczGhUhN95gMxe1xjyfVC0PdkSiRzZwtSYZJlEQ6tRMifOnsp5B6ekfyXzkjPxCYqFpaq4fUK30c82WG2DwH7MU36HoN3aH3Y/YaQaFauO54n/x77KxOhBkMT6wGPwAuMoVnxDIfTQge92Pn5uWn+L5G5EFpi0uJRhDAltHacX+DZKRevrjlKWuHy94tDjcsyTRbnCrr6ao2HTi5TVRg1y1F5ny5QP3NMfIcaXWmjpzlci0EY4FwZrPL2SFXcqdep8CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:49 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 21:42:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Nov 2025 16:42:16 -0500
Subject: [PATCH v2 4/5] media: staging: media: imx6-mipi-csi2: use guard()
 to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-stage-csi2-cleanup-v2-4-371bb951776f@nxp.com>
References: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
In-Reply-To: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762897350; l=3875;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HUtJfZ5UwnVY167yFTUryLb7oW4vhVqma7POuJNTdq8=;
 b=2LMwXYISZMbzooLTCyD7KvCJdrlgeCvDKlTXcDrLp+brwi8Wn2djCHInx13sM7b3Jgpp5I4Nt
 Luc2XGFyrEDAyTDYWnUj0tCTx5v9Wk9fl8hIRbYBmLSQEFbprFTzeyM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2eade7-642e-4dad-07cb-08de216b4286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3VTL3hFU2pEYk9xVTRTVEp5R1NkR0FzN1g2dStveUVzRHorTFo2N1BobzJU?=
 =?utf-8?B?V0E1VmVaWm0ySmV3YXFDZFQyTWgxb0RjeFY4Y3NDK1JVNkpueURBWW1uN25I?=
 =?utf-8?B?cjk4Zmd3WjIxdCtLenRVZXY3T2hycjdOTUtiZklVa2tEVXFjMXc1YnVEMlVG?=
 =?utf-8?B?eDBpT0w2cEVsTEFXWS9ieGZkMXRTZ3VJLzYwN3o2VVpQeEM4MUtwcm0xRThW?=
 =?utf-8?B?OXpmcitkMUVPWlhsV0VFbTQ3K0loZUlJVC81VjVEK2YwdCtQU3krQjhnZG9s?=
 =?utf-8?B?Nkh3ZVFwMXI1SjgzcVh5TWNjWVN4QzJYK0VUR0RhaURCQm8zRkdMSEFORzAy?=
 =?utf-8?B?cTdVMU1sRHZOY1NZZFYwaXdUaE1KTmQ5VGJlWFJWK1lpeDAzL0JiRmo4QlNm?=
 =?utf-8?B?V0RxdkJXbGV1eW1JOHpNVEZjcGRKTVE1QkFaR2NzOG52UzlxWjQxWWNjUVkz?=
 =?utf-8?B?aStNWnZPQXZKZkl4azRqY3diVnNtOTJCQThDeFNaRzRxYnlqR3g3Tjh4dzBC?=
 =?utf-8?B?T244THhJMldPZUMxZTZUL1hiSm9lekR0eWlsdlM0bmJXRTg1SEJXZGRQRyto?=
 =?utf-8?B?aXlVR0VUTUhtYlFpMHJIUGdkQ0Z2T3o4VjR3NFhoYzFqTWNJT1Bibm5pK2tl?=
 =?utf-8?B?azZCYlBoR3dNRDNLQzMwRncybnYzZUJPUnEvRE5OdjlvdUZzMjMrNWRMd3cy?=
 =?utf-8?B?alVyUUp5SzRDLzkzVWcxb0ZwTW9Hd0k5T1pybUZFcXppUHFJNTUvZmlrT1Jv?=
 =?utf-8?B?WllzdnlRbGNaWkQ3Njh4U2JEa21JQ0E0YkxVRmlIa0JINUwzUkJBR09OOEV5?=
 =?utf-8?B?SlJaK2E3T2R3V3dGekNoQVNjemVOTXBpNlExWitubjh3NjkvRmJMZ0lmK0FT?=
 =?utf-8?B?M0YvMG5LbUFpcm5PbGYzbkFwMDZ6VGltbElOakgyeXZhZU5iYk1xcGtHTkh6?=
 =?utf-8?B?TkxuZkdwVE1MTWNlNk5XN3pyL041ZHN4N3lmY1hhUFdKc2V0UFpUZmUrWmU1?=
 =?utf-8?B?K3dPQWZUYWp5V3lKbjhFMWo2bjg5YzFRTWhtY3NDWGFQbnByUm83dmMva3ZK?=
 =?utf-8?B?QjE3aE02NHRrM3NjUUhIcmpGclRRaDQ5RGNFaUFNNkhnenZnejgzYkJzaDBn?=
 =?utf-8?B?dFhvQjJTRDh1Tlp3QzU4QTk2cmpQZHRWNVVjOEhhSC9YbjFLbEg5ZmlGNk1t?=
 =?utf-8?B?WUhaMGtwSHFCVEV4WmtXbncwMUpwUzl1WjhzZlMvV3hydk9yUXVCbFNpTDlu?=
 =?utf-8?B?WTJoUXVlNjY1SWh1aFhKUjluMHZ2M0IzTHNNM1VNdU9nVTJ4c0toTmsyNjg0?=
 =?utf-8?B?N3E2bFVpb2hNOEVpbFVJbHovYmtJSWF3Q2FPelA3UDVMdzQ5QzhCUnk1Mklw?=
 =?utf-8?B?dlNLZk9VOWQ0YVZVaFFkNzV6ZEVCZTVqbFJzdm1QSTVldUcwUmlqRVNvbVps?=
 =?utf-8?B?TTlZSzJZSGgxUkh5cHBGT1QydDlNT0srK2lHcmlTOGJuTTNjKzRXU21WN0hC?=
 =?utf-8?B?NURaaXhqZzArYnBSVnhzZkQyNmtJUGZaVnZObFRUb25WQU9OQTBBZTJIYVFL?=
 =?utf-8?B?b0YwbXNqWlFpdXlPa3FxWFNVcGFsMlZxeGR6ZzZ2dWhSYkt5WEJ5VlhIamZC?=
 =?utf-8?B?V3paYWl3RlVldW9JZ0xLaUx1QkY5eGRkakQ0K2lDVWx2bzJNUSszK2c1N2JM?=
 =?utf-8?B?a1hWWCtnS29kSVp4dS9UV0VUYjFLenVwcXdvWDZvbzd0NldqNzZHUHV1NUpQ?=
 =?utf-8?B?R25XYlUxd3hzUkhNN3NodlIvNVNMUWdkcW9QQm0yYUZMdXJ4Z1h4dDJBSndz?=
 =?utf-8?B?SE5ZTVRyQnArYlc2QnVHQ3EwUis5QXpEZnJqNXhTMkhBMlU5M21TNCttMEI2?=
 =?utf-8?B?dmtPaSs2Mk5zT05sa3hIbW5seDcwQmFBbE0xNTBYUi85YjJvY1JDSEh3ZHFL?=
 =?utf-8?B?R0dENkFOV0YrbjExbi9qTW1oQkVEdHcxVGs1aFI5bFBFZmhhUVRPTWhtK1pm?=
 =?utf-8?B?R0R6d3orU2piNmI2eDl3QjU5Y29oSVNobTQ4eiszUzEySEdYN1FiNDN4TVZv?=
 =?utf-8?Q?1m+Jqp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Znh2QWduSHZOVjREVlhHU05Lb29TQ1NHeXlJYkN3UEluNHRIcWFDLzFIUUFh?=
 =?utf-8?B?V21hOU4zRmdLTW9wUFRVY3FiY0QvSG50ZGFNTjNlQmtXb29wLzczSFFLQzM3?=
 =?utf-8?B?a2Vtd0pzVjgwT2tadXU2dlpwK3NmWS9tc0RkNmRiZVFMVHFoODRkNGVlWWll?=
 =?utf-8?B?RVVSTFJTbWN2cE5wM1dQdzV4bU01SG1zZlBWdEIxS2o4YitOd0JKNDRMd21N?=
 =?utf-8?B?cld0b3FoU1hmSGgwbE5EcStXWnpSOGl0NEc0MlppMXZBQy9TTHNkdzlwQ1Ur?=
 =?utf-8?B?Uks2M3ZDdkIxT3RJQUIzZ3FuT1NRbTZIeSt0MEhUY0NxM3U0MHVzTVR2QlF0?=
 =?utf-8?B?bDhxZUxzbG5TRlZzRFlrMWJWc1ovWmhGTVlkQmhZTG1GT2Rsdm5Mc2NaQUxn?=
 =?utf-8?B?MFdncHJIWEhKTThLSERxVjhRS2Z3S2tuT0xGblo4V1pWVFZOb1N1NVVJOStV?=
 =?utf-8?B?enp1ajM5dXhkNWJaY0JMV1VyZ1N0bW12QjNnRWE5Wnk0aGphaGNyeFo5TWh3?=
 =?utf-8?B?UDFsMHdOcVlDaCt4QmZhc3RZOGYyamQwbGVqMGo2ZVM2NjZFbXQrS1Z4akhC?=
 =?utf-8?B?M2pzaDVGRmNZaWpYMjBMZmFmZGNKNGh2bUdDMytpTVNqa0drbnRNUmxYSGxI?=
 =?utf-8?B?WXpJVXZWZkMzTEQ3d0MzTXVjbFJ5K2RIUDh5YVJNWlJxREhTMjN3aU5HMnpa?=
 =?utf-8?B?M3d2NEwycVN6QUhNaTdPbmw1OVNRSFduUU55bks5dlh1YVpGVnA5WVcyQzhK?=
 =?utf-8?B?TU8wZDNEMjYyQjRVa1RVcHFwWjVXVFYvUjF2ZjJZQmFFQzJBSXcvbkJ4QS8v?=
 =?utf-8?B?WjJiYXgxYXdCNUVOMDhsVHNnamhEWGM4bWo3eFVYYUxwMmFOZWdseEUwVDQ1?=
 =?utf-8?B?MlEzczZ4RXZwN3lpV3NYdzVFcTB2aXV0dGl6WTVvck1rNHA5cHFZRFVsU2xF?=
 =?utf-8?B?bnZMYlQxMGdsa2tXaGdMcDZqb1FaMWZXZ3JsKzdsOHdiZCt3ZjVjb21TR0NQ?=
 =?utf-8?B?UmdzcnFUUTJsWHl6M0RRa0FTRnhpWEpLei9CM0dMQnlsUWVNbFFsWEVtVUY3?=
 =?utf-8?B?WmRVRHlSZFhiZURXTTFGUkR3bmNlU1YvVTU0YzA3S1E2UmtrbkxnZmlWaFVW?=
 =?utf-8?B?dUVGN0RsRUJqTGIyTlRlRmNXVW55d1FvdkJuQUJZanMraDBqNGhlYzhGT0ZD?=
 =?utf-8?B?RnZkUHdXTkdBVFlXWmxUbUQyYnFEZkJxY2VQWnBBR1NjUHBNc2RodUZRYVBY?=
 =?utf-8?B?T2xYc0FuTWhaM1VnV2tpSk5EdmFJb0Q5Z0lNOFlkOEJLQ2M3aVdiamQ5TU5v?=
 =?utf-8?B?dTEvZjVma2JlVHk4dFhZQ3hLbHRrNmlYd1dHa05DS1JTKzNGdHdEcEswcmM0?=
 =?utf-8?B?aDU2V0NEa0l6OWxidk84a1lDSjNYZVRjVUFRWTRYOWhCRXZpdEZnWWlXMU95?=
 =?utf-8?B?YlpNNFJjenpHOFo4L2dEWTZwM0xKU3JPM0diNnJyZ0lKMnVxTlpyS2hWOGdK?=
 =?utf-8?B?NDMra2xTb29kMkxJcGdJR2toRFh6bDRZNVRmV2RSUTlQL09HdVZSa3ZxSFZF?=
 =?utf-8?B?MG13aHJ3QjNSd0x2Qjl4VUxqZkZnc1ZneW5oOFdtaSs5YzY4VUpjTlRHYTVU?=
 =?utf-8?B?Q3UvR2VFbnY4WkpzSG5NVy9NaWhMVzczVEtnTWxOMXdqdXprdTBUR2xFdTAy?=
 =?utf-8?B?YnRCMUpFYml2d0pobjdJcFRhR0FTbWQzblFNaFlGQnhDM2Y5aDNQQVBJb3dM?=
 =?utf-8?B?d3hQZUpwcnRuclN6bFJEc21OWjVIUU03R1NWOEVaWTRiSksrZktNc3RETHox?=
 =?utf-8?B?SFd3a3d4MFZMem9FaVhSUENMdTdqU3k0MmtQY2RuRjM1RDJIRys5T2Q4bmEy?=
 =?utf-8?B?WnFuR3l4bWl1Q0pjUHdjR0ZqUGloYnFoV0c4b3dRaXlST3RaQmNUL2t3S2F1?=
 =?utf-8?B?QlM3NW1YMjZ4T3VQMU1LU1A1S2dmTDMzdDlZbmRDWUdlMW1GMzNwallFZURQ?=
 =?utf-8?B?QTlPb2RVVUo3bmpEWmJlVWhPMWJNV3U5Wm5SNjBXWHc1RzAxR1NyRk05UkxC?=
 =?utf-8?B?RWNJT2U2cG51WDV5c2xqOWN6a2xvcmhXWmhSUlNiZ1g4MDRPcFk4U3JVQ29m?=
 =?utf-8?Q?x0WIMN0WmAbSi7lhDQSuH/X9S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2eade7-642e-4dad-07cb-08de216b4286
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:49.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4eE0InCjMAYlBCZKZ9nUl7voof5tvzPqwr18nI2Rhr6qEkPxOO1YeyhPgT1rX4SO5xXesHAjmIZPGy21bLspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401

Use guard() to simplify mutex locking. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
leave as it without cleanup goto branch because there are two path to
update stream_count.

And it will be replaced soon at

Use new v4l2_subdev_pad_ops.enable_streams(disalbe_stream) replace
deprecated s_stream interface.

https://lore.kernel.org/imx/20250821-95_cam-v3-18-c9286fbb34b9@nxp.com/
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 54 +++++++++++-------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index e1b4b7fb53131ce9515b9441d8fc420e85d3e993..762f19ffd0858c952027afa8e0f36fc87246e1ea 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -412,21 +412,17 @@ static int csi2_s_stream(struct v4l2_subdev *sd, int enable)
 	struct csi2_dev *csi2 = sd_to_dev(sd);
 	int i, ret = 0;
 
-	mutex_lock(&csi2->lock);
+	guard(mutex)(&csi2->lock);
 
-	if (!csi2->src_sd) {
-		ret = -EPIPE;
-		goto out;
-	}
+	if (!csi2->src_sd)
+		return -EPIPE;
 
 	for (i = 0; i < CSI2_NUM_SRC_PADS; i++) {
 		if (csi2->sink_linked[i])
 			break;
 	}
-	if (i >= CSI2_NUM_SRC_PADS) {
-		ret = -EPIPE;
-		goto out;
-	}
+	if (i >= CSI2_NUM_SRC_PADS)
+		return -EPIPE;
 
 	/*
 	 * enable/disable streaming only if stream_count is
@@ -441,14 +437,12 @@ static int csi2_s_stream(struct v4l2_subdev *sd, int enable)
 	else
 		csi2_stop(csi2);
 	if (ret)
-		goto out;
+		return ret;
 
 update_count:
 	csi2->stream_count += enable ? 1 : -1;
 	if (csi2->stream_count < 0)
 		csi2->stream_count = 0;
-out:
-	mutex_unlock(&csi2->lock);
 	return ret;
 }
 
@@ -466,32 +460,28 @@ static int csi2_link_setup(struct media_entity *entity,
 
 	remote_sd = media_entity_to_v4l2_subdev(remote->entity);
 
-	mutex_lock(&csi2->lock);
+	guard(mutex)(&csi2->lock);
 
 	if (local->flags & MEDIA_PAD_FL_SOURCE) {
 		if (flags & MEDIA_LNK_FL_ENABLED) {
-			if (csi2->sink_linked[local->index - 1]) {
-				ret = -EBUSY;
-				goto out;
-			}
+			if (csi2->sink_linked[local->index - 1])
+				return -EBUSY;
+
 			csi2->sink_linked[local->index - 1] = true;
 		} else {
 			csi2->sink_linked[local->index - 1] = false;
 		}
 	} else {
 		if (flags & MEDIA_LNK_FL_ENABLED) {
-			if (csi2->src_sd) {
-				ret = -EBUSY;
-				goto out;
-			}
+			if (csi2->src_sd)
+				return -EBUSY;
+
 			csi2->src_sd = remote_sd;
 		} else {
 			csi2->src_sd = NULL;
 		}
 	}
 
-out:
-	mutex_unlock(&csi2->lock);
 	return ret;
 }
 
@@ -512,14 +502,12 @@ static int csi2_get_fmt(struct v4l2_subdev *sd,
 	struct csi2_dev *csi2 = sd_to_dev(sd);
 	struct v4l2_mbus_framefmt *fmt;
 
-	mutex_lock(&csi2->lock);
+	guard(mutex)(&csi2->lock);
 
 	fmt = __csi2_get_fmt(csi2, sd_state, sdformat->pad, sdformat->which);
 
 	sdformat->format = *fmt;
 
-	mutex_unlock(&csi2->lock);
-
 	return 0;
 }
 
@@ -529,17 +517,14 @@ static int csi2_set_fmt(struct v4l2_subdev *sd,
 {
 	struct csi2_dev *csi2 = sd_to_dev(sd);
 	struct v4l2_mbus_framefmt *fmt;
-	int ret = 0;
 
 	if (sdformat->pad >= CSI2_NUM_PADS)
 		return -EINVAL;
 
-	mutex_lock(&csi2->lock);
+	guard(mutex)(&csi2->lock);
 
-	if (csi2->stream_count > 0) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (csi2->stream_count > 0)
+		return -EBUSY;
 
 	/* Output pads mirror active input pad, no limits on input pads */
 	if (sdformat->pad != CSI2_SINK_PAD)
@@ -548,9 +533,8 @@ static int csi2_set_fmt(struct v4l2_subdev *sd,
 	fmt = __csi2_get_fmt(csi2, sd_state, sdformat->pad, sdformat->which);
 
 	*fmt = sdformat->format;
-out:
-	mutex_unlock(&csi2->lock);
-	return ret;
+
+	return 0;
 }
 
 static int csi2_registered(struct v4l2_subdev *sd)

-- 
2.34.1


