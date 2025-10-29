Return-Path: <linux-kernel+bounces-877055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D1DC1D13E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFBE74E2DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E5363B88;
	Wed, 29 Oct 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z/XQOQDe"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD76363371;
	Wed, 29 Oct 2025 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767718; cv=fail; b=iDY5EZFVk2zpvFQ/fqV51G5TULSgo1SwEtfKDft567addEbiseK4WtCFspQ87NAk01NXirpAEhzOzbHGlew2cw4rmR8vezZE1MXD3NzgQswo9BCJJq+OuhhbYtBqjz8LhC1Q2KI0dAbtE7exwvA+pT1ljzcbMFyUUiybqyjU+tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767718; c=relaxed/simple;
	bh=+CieYNc8xOZwI9brf1pSZ3EvAGnRZs+CTvH3EnVhLTE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LKRGFwu8Clxzuhx4f321j/h4R+7LeTotpkfkbOtT7I4/3uI0jhFXibPVoKW5VC/GzLduNbQDg5T7NLPQOLt0KwDxPfJxZoTbHx2ScdqOhXo0zy855sZ1TTc5k4oXkTeVFHErWQYa086M75rjTmH2y2HBxQKCsag2GSvh8LAy8ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z/XQOQDe; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH8glBk9pY2SV3H9L00fdAEkIcs/Hpn2FSYCuxDCVMLnfhc4SFALd1epfsgOKe1d2MRY6nRnJvRwAsxrDjOhPA45M7cNPz6l+c871RYBnQMJ/xj7twX4hApdjeMFuKlMqCDqF3HDC3+MxgdLgPVXjCamWEK0/3y8cLkEx/VSpuUvLAmHEpBHD2GePM1RYrHdQMx2oZnvpAIgk/nu0bhyym2jm8MDxOG2RQ86tTWgoAdg9cyKfK3xv9/PBQdm7dSXjll9Z2qNAvt69RFla/wto3zHUMV6tQCCGdYFdCxN0ldmkf/FDf7JLY6dEEBNir3sOlhcHLUMadDspt81kup8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0Kwsu1RHXxR1dpLzcGGOc2EaPIe9Pkj3KMT/TlPhwM=;
 b=KgrTpjPeIzNi58BnU3AbeSrAjYkyD+DDM7wxAzq+29wXRkMZbkFdDhPkEdXSvDPBs1eorRR6RPCNiSbceOXhhjcVEe3zDmQwEV/MDL9ChSnWsK4GrXa2jBPtevwMcX9uqTL1XPTvhfJvd9xdwSFjQuFepdxPytIYR7AKGyjWNpudSe/99kA33QtPS/COsRWZehnR79LU6JT11HYcfFRQ+WpwSiGZ70lLPCFI6HFtWxGujeeSdB4dWNqnClDpYtaL4+59KNlWdBspwTBtXj1WmmD4t0XJ2gLHqExkZhamJKfTDlRqWxxpjqM1W+dVcyefBeqERALdAuKdLdtrhTolXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Kwsu1RHXxR1dpLzcGGOc2EaPIe9Pkj3KMT/TlPhwM=;
 b=Z/XQOQDeShoWpCS4ISRKm+ZhpK6rLeZd3u42e6RztncCn9Xsl9tpSzMVYKgsSKpmoIFqeucOyJZWw+BxvYA8Jxf0Es4JhTkvClcADJVV7GYOjCYO9HeFyVxMkZJI0RYsoaB9C9VcqBQAtXXT5ECG3o3bajweEEIdQtIiWUMpo/UfhDIwFBuvjcLNNBzDkZGZLb6fydppaYslWV4BlzKvAjWnhAzEjDFCTUFRttXKkp5LAtuHW3J5RoZcru2t7FZ7T/95ItVdcBBOZ/WsNWZA+UdB0wL60P6SVk4Bt4KKuPnYpaNeRTPX23OYdv0iUK1lWLJtI0pcZ+TQ8qqigVirrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:55:14 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:43 -0400
Subject: [PATCH 07/12] arm64: dts: imx8qxp-mek: add phandle ocotp
 mac-address for fec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-7-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=805;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+CieYNc8xOZwI9brf1pSZ3EvAGnRZs+CTvH3EnVhLTE=;
 b=OL+0RKo0tcn8D6l9NqJR+YGYsJtCuybYjDu2/3y7/xrU2b7LOXiounJL+A9eqwhqJVwYDxIKE
 th+KxeTU6T0AoN19y2SUQkvUVSHqwSWL5me3KgsWYC2UY+y05d7gMrM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e492eee-c4e9-4844-d8ba-08de17251355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODduRWdkcm9haHZGLzBMVkR4bUJtQkpzUCtGZEQ2eWQwL3VTclFiUjRVYk5t?=
 =?utf-8?B?OHFrTE5scS9ldWZZSzZpQzlkam1JSTc2SDduYk1xcVZ2b01lL1pxT2tUMmd1?=
 =?utf-8?B?NFNRTlc2SXVVYVhxQURvT0M0M0NKL3lRUmZmQXJFeUVNRVh6VEgrVU11TmVj?=
 =?utf-8?B?czBxbUxuWU8wQzZOaTdOK3VUejFVdkZjNzI4bVNCc0lxWmFZRnF2V0F6RTg3?=
 =?utf-8?B?czZnT3N3R0NDTTVnamNMaEt4UHFMN3lKb2F2VmxXbUZScnpoV05iMHVwdmJJ?=
 =?utf-8?B?NWgvNW1vbDJtODU0c01GTVZvMGEwTEJKVTVLOGR1N0EvWXdFRkNWZXhPWkgz?=
 =?utf-8?B?ZExUNDF0QlFaVVdMY09EWUxSMDI5TWZPSG04TEs4ZzdhbS9uOFFzdU5RaDRM?=
 =?utf-8?B?dVIrNDRsZG5jYktqWTIxNEFHOVZwYmV3L0RERnNlWG9ycUY4czZlbjJNL0h5?=
 =?utf-8?B?YkVSOTU0QldhRTJOZjl6akFKeDZMd21qelJBalUxZjBRbzd1Q2pwUUV2S1RE?=
 =?utf-8?B?Q1A5UC9SRllYZTV0d0JxajFRQTh5THp6NHBSSVl0Vk8yZFExZTJQdEF2NkdV?=
 =?utf-8?B?bUFDVEVVYklBRlU0NTRpR0UzVERseS8yWEpEUnBaaWJZOW5CK3lPc0N3ME4v?=
 =?utf-8?B?US9YNVBaUzRZcGVyTGdIQkM1b2lKVDVPRE05WmRQUVhlUFMwd3ZwVm9Id0lt?=
 =?utf-8?B?a2wreG14ZG5rWHpSeHlGSnhCYml5Z1c5VU10NFA1T3NDY20rVWpVSVEvbEFG?=
 =?utf-8?B?d0FqVkhxaW9JOHd1R0tEZU8vSmlBU0RDMWpZTDZscE5uZHhVeFNiYjd1bXBQ?=
 =?utf-8?B?T1VBNDBpK2hqK2x5NnhYUEtDU2lkQ28wc1VRRXBmSnRmMlg0Vzdld2xCK2F3?=
 =?utf-8?B?RmtIcTFVaDQzZmFxUzBSamltbnI5Z1JOQW00SDdQdllLc2pSZ0p3UXV2eUZM?=
 =?utf-8?B?amE0SUQzeGxNd2xORGlGcWRJbHhSUFJBVHhnN0xIL2pHdStyeDV1UDNjUW5s?=
 =?utf-8?B?ZDVyYnhvSWVOZmxEMXI2RGZyTjNFb000b2VVdjVna3RxTWtvUHNvbXQ2Mk1K?=
 =?utf-8?B?cEo1MXVKbmZVUnJ5UW40OHBmNnFNV2xhb1phV21zYVViWEhrZld0RjBBS25H?=
 =?utf-8?B?NW5WVW5ueEFPeXFrNlJkTGNqd0c3KzhEeld0T0tscFlxRlpRcHA4cXNNdTRj?=
 =?utf-8?B?TDdzc05DYWdKTFhQKytJMmFyWit3WGU3Z3dQN05HWC81ZFVGTzNTUVJIaU15?=
 =?utf-8?B?bVZ0NFRpSjl6RHpQMU5abXNtbDVHL2ZTN2lLUS9QL1JzbGxyL2pPaERnY1Nr?=
 =?utf-8?B?N1JsNm9QR3JOV28xVHIrNFh4bHNlTytNNFJQY0RLb2FxRWM5TUNLc0lMeWgy?=
 =?utf-8?B?dmZJSDZyQXR3YjBuTWZuanArVXFTUFVjR2xYVFNMMVdzY0ZqL2k4QjlrMmlo?=
 =?utf-8?B?NzM3UUN2N2ltNGFPZ3QwRzNoeFR3eG1OUkRvOW1sNFY3NzZObFJJT3UxSGZV?=
 =?utf-8?B?OFU3b2pRanJVaGIvUmpzOExjZkNRazJhWk93MldnMnI0TkdYR1ZzQytFNUN5?=
 =?utf-8?B?TldPTUFORzVCeS9aUmZTUEN6OVZsOHJvSm5SdUFjMTlWNGROR25LTEZKY2hR?=
 =?utf-8?B?OXY5QWdVUElWemRRdUdzazlmQVFxS2Y1em1qcTRPY1hQdFg1UWt2QWlka1BJ?=
 =?utf-8?B?Zkc2MFJiOXhsNmFQZFU2Ynl4TUYzcXYwS1h2cnV3UDVmSjlYVE0wcWxuTkVM?=
 =?utf-8?B?TmY5SWNNeUpPZCt6ZVFMTU9vSWV6TXIxQzdJWTRjVlYyL0VvRFI2YkxQUjJB?=
 =?utf-8?B?U3JXUDJESXQyWnJDZlhQMmxjY3hkL3NkckhoTzVnYmYxcS93bDJyUEFsYk9Z?=
 =?utf-8?B?Qlk0cUkvR01uMU82a3FncGdKSWkraldvTXlRK0JjQlkyUUZiZDhCb0RmVThP?=
 =?utf-8?B?ajVOR2xtbFd2OFNaZ2NYQUJKNm9TbHk2MnRXb3BiZUVUWXZ5OTlrb3RNUEtY?=
 =?utf-8?B?enFxYVhCbVZFT3M4R092K0hJd20xUTFLMlJpVElJRlJWWlRaTW9YWDNVOTZS?=
 =?utf-8?Q?6LxE7t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjlxYUpWMThaekZ4WVVqclB3bzcyNmh0M1c1MjRuT3FGb2tvaUhsTTBxWGsz?=
 =?utf-8?B?UUUrTGhhL25GMHk5SC8xUGdwOUFCL1MrTTV6SFhSUzhtL1dlallBQk44VndP?=
 =?utf-8?B?K1p5YlluWEo4WGVFZkR2anJCTmFMSkxpVjhOY0dJUEtXNGg5TmI1MXFJTVl1?=
 =?utf-8?B?L2c3dkR2M0lXd3dnd3p5QlYwdk9ET3VycW93ekcyb2Y4WmxHd01peFkxVTBF?=
 =?utf-8?B?UGFJZGhFVUY2OG01UnJldnR0RnJIMlczd2NVYXhtVnNXMmROK3B5cmZaSFpX?=
 =?utf-8?B?eUJZeGNiT21RWHZFV0QrdmMydFVtVUFwTGFvNkgxcHZIL1ZDWGE4aUpDUkor?=
 =?utf-8?B?S2ovdmNoaXFVRi9LOU5SQzhUUHFUMkRsN3p5dUpRSFFOR3lvL21qMXhhQ3Vs?=
 =?utf-8?B?MGlJaVFsYVhtK0xOdTZXU1B0OHhxQVZpZThzcENLZnNTRExoV3crS2wzanlh?=
 =?utf-8?B?UjFTU3ZXcklSdVFqYmRNT0Z5d1YxVDBiK0FzcitjVHJFMHJxR0NXM1ZPZFZF?=
 =?utf-8?B?L29ZZi8xK1c5UkdybHc3aHZuTlFxOVRHU214NWJHVFpyR3N0TXI2anVqK0Vt?=
 =?utf-8?B?MzZMMDBZQ0swSTdBOWUzS2M2b2lEaGVncUQxcmJKbXdpR014VkN1YVg5eDdW?=
 =?utf-8?B?cUtIUWJHR0dsY3VYbS9lSytsOCszbDNmcUN0RndCa3g0V3p3SXdBQzlPb3hM?=
 =?utf-8?B?K24yWWdGRTRGOSs5bmpYcjFVZDJVRWo0OEk2Q3lCc2hCdWVVWWI0bjhhWDFk?=
 =?utf-8?B?SWZsTEdacWVhamN4c2Uxa0ZzWWtaT0pSYXJkWngxOWtZN2hxV0dHOXBFOTJO?=
 =?utf-8?B?Sm92V2Z4eDREQ3gyRWxOcGVhNS9STW9Ybm1OV2JnSnA1bUR0ZkVVWWtXYTUv?=
 =?utf-8?B?OE5DRWlVMSs0YWQ2ZlA2NUlqazBERjEyRFlZSG5Jc0RjUDR3d2hQRnVQQS9L?=
 =?utf-8?B?Z2tRS0VpMTBUV3NJNVBrWGUyMGY0dlk1YmJ4ZG1hMlV0amkwTkdneUs5UVpt?=
 =?utf-8?B?WTJlVDlEUzBvZE5YZmE4bmR2QTROQmI3SlF4VlRaQjNROXpsNDRpMVo3ZTdj?=
 =?utf-8?B?OVE4aDF6YUtFcFJhaUZmV0NlSUo1SkJ5Z1E1ODhlK1JVbjVNa1AwRlpNVDBC?=
 =?utf-8?B?RWlaRFd6NkpscDVRRkdqdnU3MTE4MGEyOGo5aWlRcG9sMHRTSTdzZWU1QXFC?=
 =?utf-8?B?NUQzb3E5NUxlWnZJYWZJWUd6Y2N2MmR5T1c2clUyRmNWbE9KMUtRNjgxZDd3?=
 =?utf-8?B?T3p2YWxscXczM1BMU2MzZEgvV3BWQVMwWlE2UTR4bjQ3Yjc5TlpoeHpxZFBx?=
 =?utf-8?B?ZlhkaFJMSlZ1OVdFNjdMSGF4VTU0UEF0ekp3TzEzL2RDbXBFTkRYbEZ5WkI4?=
 =?utf-8?B?Q0dqa0I2RGdBcDdMdjMxUGhhaHpJcGxzdnNaWitkMmwyQUZ1QnY5NjMrY1cr?=
 =?utf-8?B?ZVZja2FRQzkybHcvMGNwYVdXcmZhNWdEVk5XbzU1dUJ1T093d2pEcE9xYzFn?=
 =?utf-8?B?Nkd3amRqdlNsOEg0WjAySlFhUzlaNVdGaDd5cVd6ZmlPcHpQSE1keFlROFFG?=
 =?utf-8?B?SWNhcTFVMUgzSUtlSHhQTXBzaXFTL0ZKeDMrR0RTUkthVFQxajJVWGtNY1A3?=
 =?utf-8?B?NGx4L2NCYlNrbk5OdUZWdmRtdlpIOWVvenI5UGd4T1lYdENTVUNYM1lWWENa?=
 =?utf-8?B?MlEvaSt1Zlk5ekViQ3VVV2hwOGlEL21TenhUUzd4VWlLam84eTdUZkdoVWd1?=
 =?utf-8?B?Y1pSQytEOUEvVXduVXlCUkRTVGpEeVVGVFlPbWZ3RDFrbFBKTnlkQmh1NDZh?=
 =?utf-8?B?c1JvaVZXWE1INEdPWnVkSENacTdSSWU3bng1UktGcHZpK3M5b0xBcjYyek5Z?=
 =?utf-8?B?VmUzVFdZaFN2SStIU3dCbjNZa05ibEJmVm1zaFcrMEIvcGpGVnZjRjRtejB1?=
 =?utf-8?B?TTZEQUlETjJWVnBGREN2NjA2UjVCM01IZnNNanl1aWxTZjJqMkQrNEd5OERo?=
 =?utf-8?B?a2ZqUW5KZ3NRaFMyWVVVb0xKeFVGd01LQ0tVLytnR2V1OE5qMXJUTjB4aFVz?=
 =?utf-8?B?aWd6Q2RKbTVPVTMxUlVaSThSdlBvWURndW5yaGFPVkxSRDM0Qmt3enVmQXNK?=
 =?utf-8?Q?4tNrRLxWNh88/ExjTbsHYguSc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e492eee-c4e9-4844-d8ba-08de17251355
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:14.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zldO7YtLpwE5im/fiqWrQ41rChxe6cnMYm/ge10xnINh40TkeoQjfNIurCFLgwFCx379x5kAZrZrbRlrt/R5Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

Add phandle to the OCOTP mac-address nodes so the FEC can obtain a fixed
MAC address specific to each board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 25a73d376eed85049e78e4c8b209ec23638ffcce..8ff2e4d4c21908826c7801d3d269fc60f4b5778f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -397,6 +397,8 @@ &fec1 {
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
+	nvmem-cells = <&fec_mac0>;
+	nvmem-cell-names = "mac-address";
 	fsl,magic-packet;
 	status = "okay";
 

-- 
2.34.1


