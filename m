Return-Path: <linux-kernel+bounces-770167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE70DB277E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029341CC5E50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983C221B8F8;
	Fri, 15 Aug 2025 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ek+k+Mdq"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00881A0BD6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755233554; cv=fail; b=fB1yFPJImPOGW2xRqOhAsfe83aCR6ZdKfjQf57bu8aljmlQIvkHakRErpG567sSGDe1bHuwL8G+RQPVeBNQP8qbH1pWoLLA+cHW5mg2BRNDXkU9RbrgmGoZVoUVBsVkI0TsQehvrxEyD5DeRzCFCmz2QyHnixuIWU0Ag95ccXCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755233554; c=relaxed/simple;
	bh=K8w1+HPM11vtgAu41io5RUYtWSFFWCv3ns6XlfMe1hw=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=nOPF8GfEv4Eb+fs2pnTn4h8zS1fn/24gx3hrHd/Q11FNy61SFU0LKW7onLGO/mT7Rxi9mOS6XNeSZnY9hCjMtec6hDfz86nOU1Rk3eHZwkDHa68UHuJmLdaDxRyrBRnBR7ZDIwHEAOkSYLqXGKoTduaBiLLTRqankqacdL/n5yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ek+k+Mdq; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mg+xfRxihG9UCY1C7ncdX8lmTJ5SwsR20KtNYfC1tNXDT83uiCrXPDNGAI6CPOmfr8bSfUzzkOX/9cq2lE40O6GCRRl7NA28109+N6xBRGzmeHBetNRMOycz67L3XVu9+E6vkRaSYOd7YIljqcByOEsj+iJC4VWkTrBeB5qPqSYva4DkExrrUss3ovkK+23CXh1Tsg7FTlgVmI9AwsgFvwL0JAmFfQA51eUCpNzbYlrGe8lCDftHKbIcbf27AJaIjVBvqL+Ic7Ru9p6ek1iJoHscf64OHIRdPhgLgbwocMeRzr2oBJKX85/exE1i217Whf754XQxSOK0/mX20aJN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfPGjrvfNwQVOelD744msQ5Zatj7IC7uNzVGlRBiDuY=;
 b=kds04W2e1ORJ1goMPpt9nWVOhab4Y1dCTXXTLikQYAx0QwzUQmYpOjVYAhN/rHxodLYrU+QnWJEEJC1kP8YWXRoZPYQBmmgCbcoiNmLtpz3hhDyLsKFSzETK6PGES4SS8G1ETW41e1d0XL/To1jHPExklS7mATqrgRKDxBzF2eIQoTMX8RyKMHjQMPH6Ole2SlhJSdPFmfeyK2TalxQE7FtOY/7iTLL+dA3M0yH3tcMScXBGrOFQqZjFod9ltdRQRhIwABT32+DyuEG52L7eGCY9K+qx8C3P7If/cDrZakvpHDatF1UYyjurV7mtA8oxLXrbhRJ2TG0+3oPgGXvkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfPGjrvfNwQVOelD744msQ5Zatj7IC7uNzVGlRBiDuY=;
 b=Ek+k+MdqlNH0pwqvMmw/K78rguDA60TEskYnmMcZIkQOt8R43EgQl6qZfje3dSkgbnZ8uXkypCfThkAamss6JOxytG6x1My8A6WOqupTBrASXlsPW0VZ75p/Yyqcp6ZsuYZ/uhbEwBQ6PuJgIlAY9CyQVnitAPU11HG9bViKHpX1FindRn+IEUegUX883deY7XFKq0owJW7MMWEmw6Q6gx15nLvFFsUGNW45mDl3NylkvQB7mKemids4hDk+7sMB5jdRyv46FS6tghOOPt6Oa3DvPiPFeA7+sErCgz26/r7AvC+vp6L67zkyyohdWgesR/JRyy3qsh8EZWyWIZr5Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10101.eurprd04.prod.outlook.com (2603:10a6:800:24a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.7; Fri, 15 Aug
 2025 04:52:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 04:52:27 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 12:52:09 +0800
Subject: [PATCH] regulator: pca9450: Use devm_register_sys_off_handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-pca9450-v1-1-7748e362dc97@nxp.com>
X-B4-Tracking: v=1; b=H4sIAPi8nmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0NT3YLkREsTUwPdVPNEc+PUJEvTJFMzJaDqgqLUtMwKsEnRsbW1AIP
 4ucVZAAAA
X-Change-ID: 20250815-pca9450-e7a73eb95b56
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755233545; l=2757;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=K8w1+HPM11vtgAu41io5RUYtWSFFWCv3ns6XlfMe1hw=;
 b=NfaXpM+042kRMPJi/GC7Sj2iCxBrUT9HZH4PWyiD9Dw1YgfxmGPW5+b0z62vSM/fvnKW4HNDr
 JMo0OMkXJ62CDJ/L6/LfF3S93XBymDyRWGLD26DstkAkghWJZ3EBVhF
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10101:EE_
X-MS-Office365-Filtering-Correlation-Id: f47ae1a2-ca88-4629-1472-08dddbb788ac
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RzNEanNLZDdKaVdtZlhuZGl0ZXdoZFR3TTlyYUhaTnBCakoxZllUVHVUMTBl?=
 =?utf-8?B?NkNPcWVpVTFtUW1NczhuekJaU05sVzk2VHZGNldrU0toc01ZU0F5VGIzcXBD?=
 =?utf-8?B?OFJwUC9ha1VhYUY3SmREUDBGOWlzbGhLTDRzZUpKaHN3Q1JMb2FZMXBnUE1O?=
 =?utf-8?B?a2hzNVV1ZTFjelArblQ5UDNGMFlrc3oyblN2WkRPWVpkNHhwSW5DNWVPYzd4?=
 =?utf-8?B?aEFOZHo1NmJ4bkFId0Vmb1ZLM0dWcW1FVUpjRE5UR3hZMHFyRkw3V2VodVht?=
 =?utf-8?B?K2JISFRoTXdibzhNNVlvRU11dnd3cXUxZUV2a0haMFFhM3FDUDNKeWp6REN2?=
 =?utf-8?B?VWt2VXF4a0p1aGo5RDhnNHUybkxXeDFCNFF1dXJ4ak9mQVpMMWlCbmJRa20z?=
 =?utf-8?B?L0pDT3ZMNW1wUUZQTUwzT3B1NW15UmZIR01iU3lySDF5blFPR0ZUMjNnWjlW?=
 =?utf-8?B?ajBpODZpaGN6V1l5Q3NWN3loODR3QmhxdU5MOWlISmgvVzhyOXgvMTkrT1JI?=
 =?utf-8?B?TnhRRVZYaldwSlZySHNsM3hNN0R1My9nRUVXNXowWkpGVzVVRDZsY3k4QXpo?=
 =?utf-8?B?cjRaTWNGVGVVL1RHbmp4N2hHa0UwZ0NEMDZOVGRUTkdFRThENHJJQ21yOHJh?=
 =?utf-8?B?aW9SVGkzSHNqdlZMakp2ZnMwSU0yclcySWFJYU84OHVsbzl5QnFEYjgxaFhp?=
 =?utf-8?B?SU5Nc2hhM3ZKNzZCdHI4RFhKT3lFR3ptSTMyOXRLWFA5U1B5cTFwS2ZhdThV?=
 =?utf-8?B?TGgwSTViNUIxZVoxYzJJbmc5STkzdlUxd1ZHdWFQOHZqOThhMXBTQU9GK2cr?=
 =?utf-8?B?dGNXalpwbHBleDBiQ2pSZHNGUmg5OEJBOERkNEtZelNrVXIvZ0o2TG95dm9N?=
 =?utf-8?B?L285dVVCeTh3ZVNnczMwUzNpYldwRk5oS3BiNEszMzd2VmJOWUNXWmc0eGU3?=
 =?utf-8?B?bERSTGZJSFIvdkZUQktET2xKTXRHbVJpR3ZvV2phY3pOVXZWUER5RnR1QUNy?=
 =?utf-8?B?dEJscUhjNndGL1dhZmVJMVpBdW5DRDJxenNZRkN0YXhpV1NpNlFUNmJFV2RE?=
 =?utf-8?B?L0R3NDMydGNMdzJIWDZINGZnZ2NHTkdOVmo4aDNXOW5TWVF6OWhmanR4cUNK?=
 =?utf-8?B?RDRIYkJhTDQ3ejBBKzNBRWY4eHRYWVg3bEVVWXgwbFpVelBQbVVGa01uQ3Zp?=
 =?utf-8?B?RDQyMGlFNkJHWFJQMDZvSG8yc01jU1BXMGhFTnhjWVVkNU95TlJpYktKamF0?=
 =?utf-8?B?YTVwSzRhWUdmZDdrRlVTcFVxK05yalpvVTB6UFFHTzhZUDRtVG96YWkyVTF5?=
 =?utf-8?B?VUladkE1VDV4M3l0cXhBWk1JNmsxMlg1ZjIyK3VwSWxiWGVycndpWmNsYWhX?=
 =?utf-8?B?STVaUW1IbWUrTitBTEdDTmV2Sy9uS2kvcjluRXluUGxmZU1ONy9QZ0pEN2Vn?=
 =?utf-8?B?b2l0bStYZFRTcU9Ba2syeTlJUlV2T24xWFh1V1JvWE11b1lybng2VnJja1V2?=
 =?utf-8?B?aXlDL3J6bzdFaEV6WEZGSEF0NUl2OUtmRUNCQmRKUVU1cXZYdGdJbFM2M0dS?=
 =?utf-8?B?UE54ZzNjSUJ4VlJjWnQ2ZkZpUzFybnkzZE9DUU83MG56ZUMvQWpDelByUkE3?=
 =?utf-8?B?WVBERXdncnRDQ0V3ZisrMm5JTnBKOXFSTXovTjNNOWVmRzE1MjNaeUxrMjAv?=
 =?utf-8?B?ZithRkJiOFZwZkZWU09EdU1Xd216ZTRRYUl2OWNrbk9vaW5HZHlZak9DVTRR?=
 =?utf-8?B?V0RJYlNUSjN4eHRDTnFaQVBxTTdJaU9PbkpPV2I5c3RGRWMwTFN3N0ZJUVZR?=
 =?utf-8?B?MzQza0Z5Sk5mL3hOalB2ZTdOS3lOV0hZa3ZQZnZTUEJTOUZSMDBhTFhVSURv?=
 =?utf-8?B?b0FNREVqNUpPZ20zY2l5bVAzNXVQTTlpc0RoeElTS0FYcDhibFlIMG5LWjRE?=
 =?utf-8?B?bVhvOHR2WTV3enAwdiswRWIzZTJJVFZ3aEV3ZEM1a1FBMEJGa1gybi9CeUZy?=
 =?utf-8?B?QThqMUxscTB3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Wi95OERnemF2Z0hackgyZDhCNjd2ZmNDNWJETG52eU14ZWdlbm1IMDlmZjJk?=
 =?utf-8?B?eDdiODJOSlppQzhjWjNUcVd0ZTBOalNzK2UyOEYrZFZySGhHcjZnbGZiUGhB?=
 =?utf-8?B?a3h2OUw2KzduNHRGcDJ4TmZNRjJUK0U0VDVWYXlYZnRtUmd4bXBJNkdMS3pt?=
 =?utf-8?B?MUJxYVdIRjRmd1dRUlZxdkpqTkljS1E5VURBdS9vZzZGVkhXUSthT0NoMUFK?=
 =?utf-8?B?ak0vbTJLMlZqR2RzVVRXLzRZUEpFNlFUOVFSTHF6TC9jTGxzL2I1c2VtZUJ5?=
 =?utf-8?B?cGgwVVVHZWVheFN3bGVNUTlKamxrYXBlekg4aUJNY2RRSzc2a0x0ZWFNekdS?=
 =?utf-8?B?S09BVkwyYzNQell1VmJkZmNuQkxGRURsSzg1REdwcUJmRTNtamFhcW1RV2NN?=
 =?utf-8?B?Y0ljRnk5S1BwN0R0MXI5UE9EdFpTTWxKTVhubnVEMnVROFVOSDZXRUpvajM1?=
 =?utf-8?B?bkoyOUw4NFplL3BEelBaQTEySithaDZ5dDJmTGJwNlh6OGNoUGpHWWszRGhK?=
 =?utf-8?B?VDhtZTB4U2dTWnRkcG5CLzUyMFNFZzArclEzY0xmK2hCb2JVQjRDZVNnM0RP?=
 =?utf-8?B?OTJZcFBhZmJPVmx6dWptZGw5anVKUnU1VzRJSStURG9OenNTV29BbjQyYk1j?=
 =?utf-8?B?aDVnc3JXM1YrVGlqeHhHT3JNNHg2NnFTemFtVGpBejJJU3FxeDBmVFkxbkJ6?=
 =?utf-8?B?R1p1NXVqME9xMTdHeUZobFhPOURzdWN4SDNVT0hpd2lCU0ZVYUl2dEFlSkdJ?=
 =?utf-8?B?SktNM0xJWDM0eEpLUFI1WGZURk5CQ2NyMSs5U2ZXeUZyS2dYS1JzSDY1V1NR?=
 =?utf-8?B?VndEUjByZ3FTYTY1M3orb0NyM3JJWG52YTltYVkwQTFmazdmWndTQkJLNlJa?=
 =?utf-8?B?ZDhWc3M2WjFiZ1NrZTZFNTcvN1pOd1ZaeUNnd3FkV3ArT01PL1VqaUE0RE9h?=
 =?utf-8?B?S21RSGVCNmRmSnBRTlFiaXdqUUdvRTR1RDVXMWNVQ2ZNd2dLdlYvdk1wMTB1?=
 =?utf-8?B?YWFTazJNY2JmS3ZqNFl0cFpEK2pTWXFXVk5IckZSVWI4QnJTbGFoQ0NIcFYw?=
 =?utf-8?B?Y1lJbWJqc3BnSHZhODhyRUNnTmZDSVphL0JPbWN1OGJKMUM1ZHpXK3BBa3Jh?=
 =?utf-8?B?d2pLV2pvRUhVOHp2MjRtcjFpM0Q3SXFvRCtxcTVLNFp1VVdOZ2t5bUxyVFhU?=
 =?utf-8?B?NW44TFAwSWwrWkhYNWdFQXBCa2hKeFgwQmFGeUY3UkM3cXJUWlNuV1pybWRE?=
 =?utf-8?B?YlNzVjNGZXk1eU45dFp6NTJ5QnFtcW1RWXhobm0vOHdWRTJVK2YrbkJkL2dC?=
 =?utf-8?B?ZTRBeHY1OHQxeG9WSm53ZXR6dTB6Q2lHSjZScCt2UUk2b1NtZER5M1lJTWVw?=
 =?utf-8?B?S1R1d3Z6OU5SUm56MGlxYm41R0M4anpCd25RNS8wdmRyRGlzVDFzMlhIeldF?=
 =?utf-8?B?emRTZGRDSGtjV2hPanJ4ZzAwUElJSWtjckxBR29ndFBtZ2RPQ2w3c3pRVEp6?=
 =?utf-8?B?QWhvNGVBN254T2JVUGtpOXowQWVvY2ZidHluVHM3YlhaSnNsMzFDR2owQ0VO?=
 =?utf-8?B?bjh6ek1xYTNuYmF5c2NGTjg0MFJWRXNDU1RiblBDdDVmVm5VNzI0S0NWVzBF?=
 =?utf-8?B?VGY0M2diOUppMG5iRENoU1hoa2RrSjViTWpMWXdYVFJMbnp2TE03UVp2RzFz?=
 =?utf-8?B?NU9lUVdWZnRSRDVsUmtSandOQ0dNeVBRaWhoazErQWE0VzVVYkVvVnk1cnAr?=
 =?utf-8?B?c0Vpd2pPWWh1bFliaDNrSlV5NGM2bnYvcDNrRUlGVUgycmVlQWpoY3E3eWJz?=
 =?utf-8?B?eFJoUy9UV1Y0RzJmZlpQQllnaERUWUErVWhxUW9oNi83T0JWc2hiZktmR2py?=
 =?utf-8?B?NlpQY1BLNnZJcWQzSnlxT00vOXI2YnFDamxBSFhFMHJTdnVVZnlEc0NGSzNY?=
 =?utf-8?B?NHRaeDVuKzViUHBYaTZJWC80dXM3T25LelBucTQwUkdwY1NyOXVaaUxRaVpO?=
 =?utf-8?B?eVlPSy8rZVZtdFBmT1BsdUM0T0x1T3pWczN5WWdDa05BakU3Q1Y1ZXdTdzA0?=
 =?utf-8?B?SGd1RkxSWXBXUXFIVmo2eGhlenFhaEw1UUlpVTJPNU85SFhKM0V3NVhlSFdn?=
 =?utf-8?Q?UTtBIYNYz92NphJqzMv8Ae1Fm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47ae1a2-ca88-4629-1472-08dddbb788ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 04:52:27.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK1hw+rNoSgRYIDYYSLtKfbR1vwKNUo3NNFBnFpHSoi1LrmVnUezl20TxP+RGpKi97DXzGMIAB9AVA3pz7nxbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10101

With module test, there is error dump:
------------[ cut here ]------------
  notifier callback pca9450_i2c_restart_handler already registered
  WARNING: kernel/notifier.c:23 at notifier_chain_register+0x5c/0x88,
  CPU#0: kworker/u16:3/50
  Call trace:
  notifier_chain_register+0x5c/0x88 (P)
  atomic_notifier_chain_register+0x30/0x58
  register_restart_handler+0x1c/0x28
  pca9450_i2c_probe+0x418/0x538
  i2c_device_probe+0x220/0x3d0
  really_probe+0x114/0x410
  __driver_probe_device+0xa0/0x150
  driver_probe_device+0x40/0x114
  __device_attach_driver+0xd4/0x12c

So use devm_register_sys_off_handler to let kernel handle the resource
free to avoid kernel dump.

Fixes: 6157e62b07d9 ("regulator: pca9450: Add restart handler")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/regulator/pca9450-regulator.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index feadb21a8f30712b514aa45824e61dde72abb7f7..4be270f4d6c35a37bb26ccf16918ff897146e80f 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -40,7 +40,6 @@ struct pca9450 {
 	struct device *dev;
 	struct regmap *regmap;
 	struct gpio_desc *sd_vsel_gpio;
-	struct notifier_block restart_nb;
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
@@ -1100,10 +1099,9 @@ static irqreturn_t pca9450_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int pca9450_i2c_restart_handler(struct notifier_block *nb,
-				unsigned long action, void *data)
+static int pca9450_i2c_restart_handler(struct sys_off_data *data)
 {
-	struct pca9450 *pca9450 = container_of(nb, struct pca9450, restart_nb);
+	struct pca9450 *pca9450 = data->cb_data;
 	struct i2c_client *i2c = container_of(pca9450->dev, struct i2c_client, dev);
 
 	dev_dbg(&i2c->dev, "Restarting device..\n");
@@ -1261,10 +1259,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	pca9450->sd_vsel_fixed_low =
 		of_property_read_bool(ldo5->dev.of_node, "nxp,sd-vsel-fixed-low");
 
-	pca9450->restart_nb.notifier_call = pca9450_i2c_restart_handler;
-	pca9450->restart_nb.priority = PCA9450_RESTART_HANDLER_PRIORITY;
-
-	if (register_restart_handler(&pca9450->restart_nb))
+	if (devm_register_sys_off_handler(&i2c->dev, SYS_OFF_MODE_RESTART,
+					  PCA9450_RESTART_HANDLER_PRIORITY,
+					  pca9450_i2c_restart_handler, pca9450))
 		dev_warn(&i2c->dev, "Failed to register restart handler\n");
 
 	dev_info(&i2c->dev, "%s probed.\n",

---
base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
change-id: 20250815-pca9450-e7a73eb95b56

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


