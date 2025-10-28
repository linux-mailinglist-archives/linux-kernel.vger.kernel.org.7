Return-Path: <linux-kernel+bounces-874653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B4C16C92
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EA14357168
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8D350D42;
	Tue, 28 Oct 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NnnrHPR2"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD5350A14;
	Tue, 28 Oct 2025 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683474; cv=fail; b=GT/U7+fNpSzOH8Ldg5Dk2QE4UCApSpJJ0wwdq/SanuFwjzqMpqLwikwi+RAfrfCw9QBU6M8WwkGTvcer8tW+SRix37IJ4WxT32590hHIFAhBiRfMoy0j9ER1UfCi6eHBhFZwMZ7wGhPcdSIzQxWG5nZ5MtCt4CapbS9qil17LBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683474; c=relaxed/simple;
	bh=DrxEzrYy8PCD++h5JmbbwZz78cIVs9pVx2NFFtqrwkc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e7UJq/+hnnNb95gjROpT2Jowd1L7cSMQWk4KI4Vtt5TnotKULXW9yi0iv4p9ROgHXtdL7rFHlQqDl1DQXbus2kGflEcNQpO6l9X0M0SK8MTdu//XSudJYIxC9ayFVhCaVtNftOCcwAT8eqy1gd6U0NHBn6ViYYnhWEnDI8wruFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NnnrHPR2; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0PzWn802gs+yDJVQCEMWoyPokXcfSAgoZHLkWulDi78cf1slw8TbYmDlhy5qPXKgMZ+N3uAm7BY4JN+y7Yq7yeizK31AKNJcRpOMzlYYCuwu+/N/Q5LkZRl/mkzn9S8TGUiHI43m5E5pZa6UUp2nM7xJeEiBT/8jaCdPXN50ienXmZPYO5xrQh0ltAyifrdnCth32jbyD58abDPdtoRmWEASsqAAmDcPzFz+rbp+rT+zhPEwjnGw65GqG3yOLe6qq3SMgQBF4hjfjy5T04XTqhaN5TMrCpwcYJc/RB8pAjy/EQDumj5hPmTJe+YmPKc4eG6tiGMumfzELnRK7kZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffXwDDvpOZduW6ag/bmDx3l5CIq2d9zaQ5Jpw0m1xUY=;
 b=CS898AOn7OXyvipyGbXVmYIetaZl6QqnWvv475JL3NhT/Z3icwy5lSgDLd3ApNCPFaY9SGOTbVZ4Lu7eT1G0t9ZeauYpvtM3nMX9ER+POp3eX5ehCwHHlfE70ZVT0+iGMSyHb/JWPYhphKq6hTPrpDhjnzOdYerWBQr/86jZwCZA6LMkQ0tY8nUMf/t409wFWBmnrN3tcItlTLoENf2jXMdDUltGvv24PjyOoTMAyqAqh0MAzb9JbLWOJJJFpM+e/4p6SW4I3t7csSFvf9eXn6HnyRzAc7AMvP1kVfkei3HJcULL+OtNfPHwJu/3OF0F9qnlfkfNay0ONMbf6ZB3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffXwDDvpOZduW6ag/bmDx3l5CIq2d9zaQ5Jpw0m1xUY=;
 b=NnnrHPR2VLYEnTbgONSUrVuq3bCN97f1HqJZK1KQ78rSbvNEYOGDcxqsd4AkJqfzf28c1XbTCv52O9+gYXh0UPehJhlBOT87dGPqVMk4svR27zMX3djyUb/G5w7vwATcZs3U8/FLk6mZ9+vQFagtpO0fnyAZ9MBHkS9kejfKH2/qJ8LlC3NZCvU9LeGNbVOytvh/dUMGqYiZupPpYxvO2MRZcrvSgz4YiAxG3xie2w9DAL9dWUvk8oCQo63/rdnUBlYQriioaFXRjXufXvlNv4O2mLrhRfxa2XmU3tCJR/sb9H66VmJxU0Thslo7zvhOfg+qC7JOOuCkk+AjnUfPEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:31:10 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:31:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 16:30:46 -0400
Subject: [PATCH 5/8] arm64: dts: imx8qm-mek: add pmic thermal-zones
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4_qm_dts-v1-5-51ba94389c1f@nxp.com>
References: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
In-Reply-To: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=1371;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DrxEzrYy8PCD++h5JmbbwZz78cIVs9pVx2NFFtqrwkc=;
 b=YuPRTsXVzlg7PSF8iImdNqYzTcVdObZiIBLUkCnWkK6z2mHb5NPQelyxKZ2CxxtwuaZI4EM8i
 rEb7gT94OLuBO7Tg1eG1oFX/ORaZySQ3lYtyEcQzUqSPMA9YpMvrThE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe28637-426b-4e77-9ae1-08de1660ee76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTJVNE5rZEJaeUdRTkhwWHlaL09xZnBDc21kbm14OXkwOTJhVCtxU2ZoVWZZ?=
 =?utf-8?B?MlcyY1A1Vjkzb0xaS05mNlYwdWhURGVLdk9oTkhnYUI0cmd0bGY1YStqeEZO?=
 =?utf-8?B?YzM5ZU01ZGFCWEJORDM5QnRuREVmbGgrU1JVSEtIS2hSSW9uZmJ5Q3BqWmNZ?=
 =?utf-8?B?dTVXK2ZHS1FJdnA4TjRNUFErWldTbW9WaXhqTnVVTWJqVE5IWnExd3ZjQnp3?=
 =?utf-8?B?eDVuK3h1UXlDbDNOeUpSUGpLeXlhSWs1TmNmbTNOR3cxWENselhKV3JaWFNa?=
 =?utf-8?B?K2d5aG14MzdyaUxPOE1rK21DOVdnZWxRazlCU3hlbGhXaDhEWklnRDdnTVQx?=
 =?utf-8?B?TlQvQ1pBZS9xR2JFN0tUZ3ViSkhlaHVyTUh2eXhJdS9vN3NKNUIrYktYUXVN?=
 =?utf-8?B?NlM4RUZkUHBndDluWkVUdWowRVdseFR2OGd6RS9OUUJTUEQ1YlNxZUtVNFdq?=
 =?utf-8?B?dGR4bi9uWmJwRndXNTR0M1VLcFR5YmlyNG1Tbyt6c01LMmdxNUZTc3pPcU0w?=
 =?utf-8?B?Nzk4b3pneGRycmJ2L3Z3dzhOUUp6N1JmNURud2Z1QkpsYnVicXlnUS8wdTU4?=
 =?utf-8?B?eEtXYTVhbWhCMXdSK3VvSVhGYm5uQk8wWWh4bDFMNXhMNWx1U3lENVdBYTh2?=
 =?utf-8?B?UzJqWnpRMTJvVEh2Uk5QZUdmaDFhSkpjeXBBWURQT2V5NkNuUEdHT0VkQU5G?=
 =?utf-8?B?OU9NNkpkV2ZmSHZxSXlaRjdwNkE1Yzk5aVlDNlMwYmZkTEg4TzYvWGMrbi9u?=
 =?utf-8?B?QUVCUS96SlhqMzE3MGs3YVN6bVNtbzZST05RMW9yOHhXUEdGU2RUcFlldG9n?=
 =?utf-8?B?eDYxS0RMaVZpWU0xTDRUYXcyV1k4VXVQR3VzbzQvWlk0ang3L1hoekJMYTds?=
 =?utf-8?B?dkMyMUcvdzVCRnZtSDdGSmFBQmI2SUVGdWx0dGdWRjlucGZSUzI1OGp3djk3?=
 =?utf-8?B?cjhLRHplUVNVVFI1VnpwcERhSWlvcWlVdW1qYVk1Y0N4ZWNoT2J6UDNId0o2?=
 =?utf-8?B?V0tkeGI4Q0tYTzkwT0tqd25ueUhleHFFUFdYdENmNXB2L21lN1ZtVHVtaEQr?=
 =?utf-8?B?djFuOEFtcUZVTkRaN1pIRS96U0hZTlM1ZzQra01mTitBVFF0eGNkTHVJK1Jw?=
 =?utf-8?B?NG5HNzV6QWF4MkdTa1BkWi9aY284OHZyWWdIcGRoOGNLOWlwL3VVS1JNd2hw?=
 =?utf-8?B?S3MxOVU2azlhRUY5Q3pFOTNsRGZQaytQR1ZmRUEwY0tpTXJkaDJob09aNnRT?=
 =?utf-8?B?L2xtMzFWeHEveGZRR0xFMEJObFg4azQyMVZibXUrakJ6dmpZWXcrVHFGRnVt?=
 =?utf-8?B?MlNvUVhKQU1SN3M2Y09QcUczY3hFOHcyekxVN0NSNG9yTG5xdXhLM25hVkVt?=
 =?utf-8?B?eFlxMURrdk5ET1NuSy84bWNJS2IwTnhLeEpiZndoOVVTc2o2RFhXdkxWNzd6?=
 =?utf-8?B?KzlNdUVaWGRJRXNjaytNVUREUm5Jb0FjYWhmMFg5MEhHT01tM0lPdjUycWt4?=
 =?utf-8?B?RGNuTGRZSzdPUnNTUVBtWmZEcDJRT2YxekdoemxzckFHOVdpN1NaU0VhWlVq?=
 =?utf-8?B?NVJkU0IvQllHWlZDeHQycmxtZ2ZRcDFGcWUxVjRtQlpBaEhHVElaZStrQS9z?=
 =?utf-8?B?azk2VTFwMUNRZjkxaUZJajRWakovdDViTThEcDdlODFPWWRyUWUyQ1RUb0Qw?=
 =?utf-8?B?aVJMVFNTUzlBclJ2MUtFWTJ1a3QzTW04UnZkdS9MSU8yZW5lNTd6Ym5HWXBt?=
 =?utf-8?B?Rno1OHgrMG5qd3FCRm00dzNPUm44dUVXYk50SGVjVDAvYVBRbXloaFYvWUhn?=
 =?utf-8?B?a0ZUWnp3RXpRYUVmZzRjVEdwZ3I1S292WFgvV3FWUlo2clJIUmlvVmlIM1pD?=
 =?utf-8?B?cVo2SzZYMGlZM29KT3JnTDNITlNVWlJjWFBxckF1aFRrY01OU010Z2RaUTZR?=
 =?utf-8?B?VXJqcW4wN0NqeGRPa1pNRnkyRTdoR3VsK2cxTlVhck9UN3BtWEQycEtranZj?=
 =?utf-8?B?a2Vya0tvcjVFQXFZTjVzVm50V0xpVmNXWE9FNW9QOEpjeitvV2UvdXJiaTI0?=
 =?utf-8?Q?lHl5ne?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkFrQ05MVUdHTFYwajhWNWNhS0U4YXQ5SFB3aWUxVjZkUmhEYjFyZ1Njb1pC?=
 =?utf-8?B?a1ZsWUN6c0Y3UG5GUnBEckpzQnJCQW5BenhqOGpaWXJDZ2d6MEs3RkxzMzlG?=
 =?utf-8?B?Sy8raGdtZFVubE1WeTZqTUxEaWlkcGx0Zm40dGtaQytsYmdIZDhiVkM3V1ZZ?=
 =?utf-8?B?U3BYZWM4WHl4QlRVck91Tk9GMkx3azJLRnpvaGt6aExVRy9lVVZHUTRhL2tl?=
 =?utf-8?B?TzNRWm9qM3M4MVZmekwxNzlITVl3Q2V2R040Nis5dEdJUFdDbUp5YTBVTE5i?=
 =?utf-8?B?UGV6SmJ6Yk9TVVBUdVd5S3RjMFMzUUd3T3h6VEthajVMSzlSM1cweDJFZThY?=
 =?utf-8?B?OVFJRTJMNnEwTjZ5TzhEb3MyOHo5RUROQnU1SDlUMFFzczZiN01VeGxoMm4z?=
 =?utf-8?B?eE1YMTFtbXJKZWVzeVNtL2hIUTdxSzJFOWNnQnVXTnVuZXErem5pOUxmakN1?=
 =?utf-8?B?S2tYM1VJQVFXYktPWkt6SGFwS0Z3TFdKRDVmdnNYaUpUcjRZV2dsanQvNGlm?=
 =?utf-8?B?QWgvQVRCbXpnZCtrLzFaVHk5RlhlNzFMb0k3V3JSVGt0YnZMdzhPUEZUcXVE?=
 =?utf-8?B?UWNuOUVWeEo4N0N5bVd0czRYTnZlNVVGT05KdGkyYll5bXdpakRDU0EyOEht?=
 =?utf-8?B?cG1QVXcwQmo5K3A3ampVdzA3UVJCaTA2WVZXb01XK2NhMzdneG83OG51T1FH?=
 =?utf-8?B?ZFp6SE9vc3AveHNlY2VZOFg1d3E4Q25WZXdGbmtiRlduUFhWZWRlWWZaUEJL?=
 =?utf-8?B?ZFcvNTZxeWFwMFYybmtjQ3A1WUlFUWFON0hJU25udWdsZHlGdTlMM0JSQS9K?=
 =?utf-8?B?N1dzNEZuQ2R3dlM5NkJjOWxCRmhGVlA1Mml4ZHlmakVLRlg3M3J0dEppVVNz?=
 =?utf-8?B?QmdtUFIrYmxnakZjbVozSTBDZDlzZzlNYnhEekpPUmNPbTRlQnltTndITFNn?=
 =?utf-8?B?eVcveDhEK1dYM0hhU3BkZ21vTE5QOXBYTk1MZEtwRDFYYlpnV0o4N3UwV1N3?=
 =?utf-8?B?MVB1b0VwVlJyK1BXa0JsaXIxVGNLbkh6UWhtdzZOT0Q4djYxRzVqMnhNWms5?=
 =?utf-8?B?NnZjWWNQc01uZjVnTHlmYTdRVHEwSW9mcnNNTUhGcjd5N2tJVzh0bGczRW9V?=
 =?utf-8?B?UVRTMWp2M3c4Z3oxOEp0MW9FanJJSFUzQXNUaUlUL0dwU0VzQU1CWnJFVnFC?=
 =?utf-8?B?Z3RyVHBKMEJ4Sy9WR1k0Tm9hWVZ3b09wQnlldEhaWlo5aDg1QTlsWWoxd0xZ?=
 =?utf-8?B?ZnVqMUhZNjBvcUthaEIva3h5eFFlWUxycTgzU3lJbkdsMHNKWmRSWStsNStn?=
 =?utf-8?B?c2lFRTliQkZ6c0xTcjFiczBwWXVxU3FReUR6T2hmSGpMa2NBbTJzRzNYbDNm?=
 =?utf-8?B?aGFKSGZHVFZrSWJwcmNTSEFkZkJBa3phdTRwSG1oOHBmQ0E5RHFjVEEvTCtj?=
 =?utf-8?B?TkVFaTBEOXU2eUQ1ODBqR2hpN2JUeDlWMWdNRkJzakFQK0J4T2ZUV0EzL3ds?=
 =?utf-8?B?ZUJIaUhPaEwzL3FDdThGaWYzS1NWdjJsSWRTeEp3MGE5YW9xVU84Z1VIZGhO?=
 =?utf-8?B?ekJGREpWSUg3NnRERFJsVndmb2c5elYrTzNlYThGMjJaWlgydFRZSEJudVJl?=
 =?utf-8?B?TmFVTDJaaTA0azB5Ry9JeVc5SGlHNVdSOStYMUdrVWpHeXU3NGx4UlpnNkRp?=
 =?utf-8?B?TW9zMDNWOVpEWmFnSE1RNFZGQXRWb2JNeHNCa1ZNaUJkL2V3ZkNSbEc3UU9O?=
 =?utf-8?B?ZzRUeHVjMjRJeDhrQk94OHJLWDJYOFc1cWpuN0NaeERJUmxlZ2cxT1ZabEho?=
 =?utf-8?B?WnFPaW1FU0kyanYwTkUvWmR3SFhQbVRWLy9BRWZ0SGhsNGJIWHdORWFNVm5H?=
 =?utf-8?B?NnNucGp4dkJwVWhxZHFtQnB1a3diMWpiZkl1dkVtam5aWVovKzlVZHN2ZitW?=
 =?utf-8?B?NVF2Z09DNHRyM2FVb1gxWEpFRXRuZHVWVWdhT3NYRVRDZUpCQm44Z0lSMk1I?=
 =?utf-8?B?L2Vlbjd6cUhZdnNDNnVHV0xVYjFwN1czeGNOVHZmRVRRd1RaV2FNdU1LZmxG?=
 =?utf-8?B?ZUVXVDJ2QVJtZFhDaXRUUy9iZFhjQy8zSnNwOGc2VHBKNkNzc2JpNjhlZC8y?=
 =?utf-8?Q?UEOk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe28637-426b-4e77-9ae1-08de1660ee76
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:31:10.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40OpZgtWUvMZ160ZT3/ZsVoM6N0fBfYRPbu+j+5I+2BpYvHS/J+/oPZqu8Zwq10fuZyi5sv7pN1WdGZA0VeZgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

Add pmic thermal-zones.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index a88e8600999adf53e66785e608c6231bee53b162..90daa3de24c6697554a75ab5176682ba8fbf5ada 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -912,6 +912,38 @@ &vpu_dsp {
 	status = "okay";
 };
 
+&thermal_zones {
+	pmic-thermal {
+		polling-delay-passive = <250>;
+		polling-delay = <2000>;
+		thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
+
+		trips {
+			pmic_alert0: trip0 {
+				temperature = <110000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			pmic_crit0: trip1 {
+				temperature = <125000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&pmic_alert0>;
+				cooling-device = <&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;

-- 
2.34.1


