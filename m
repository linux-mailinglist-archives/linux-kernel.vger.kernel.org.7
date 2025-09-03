Return-Path: <linux-kernel+bounces-799380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4C0B42ABF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0E81C22958
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F5371EA3;
	Wed,  3 Sep 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I4qDNUcZ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D123705B7;
	Wed,  3 Sep 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930842; cv=fail; b=M28yBH8M4Yir02MNdfeK+SHmhH7Flj60VByXwPZmleOev+LGk4R44M0kby37Q7A4YRTrKPtpJRjQSlD398hGvOgg1OUnPDi7WLy5cBtF9kQwIW8VWSiztCePMTLAUT6ceS2n+xDC6Ppe5hDuO+W72Lh5nrYoHhhzKt+2bBATC4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930842; c=relaxed/simple;
	bh=MA+Pybvz0YhG284LWyUdIqvPD6+sMepp+tMKiruhPb4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rol0hmGF2xuZpW3muQFwbx3dJNz07M89XKjQP0LfAn0ibORYLRVcNhes2azfIlzLxX0nK1pquNMwco035gfjwnKyVgArlDKpvae88jUELAztRYwqfXh5lip9x6EAsRDtTx9oSSdtlP8+GS5hyCARgVF8cEUbxKhnEf+Sx+Imiik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I4qDNUcZ; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ku1bumFsvJA7NJ4p/whjlVHJ+wbygjaytfD/4E93Gu5J2ubTO6plX09Dp2Ybi71H2KwKuzsZMVdDyIQhsX2E1CAUGnxQ8xbGYhFlqLiZxB+F2jaHvYR7x7rRh/JyWDXLH/IxhAkGTv7JkZJNXfs1G5AYKsaph57H98m50rB9+DfTVckRzKZsQrplsDEeaAnZAixzlwq0da1lU6erMbCef9juQqNQl2VFjv3o/szo4ejnimq//Ee6AAa9fVkXJU0N9sscoxODP5ADMM+cA0Umd1BH9lrixY7MwD+7A8x9DEf/VG2C6Dv9IcbSspnh7+uepV2d9zFQfqC1fD2D6klKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS5juFsLboCMQkvhyE49apZfRAztm95iwONF7Yf9iGg=;
 b=wHVp3hBvTjNCc2xLprNXBPy//5plnCyHcEHjfiM0EKklAjbIkiRjPGsC5NxGOlMSwOQ22U91ZM47hJYt9zt2PaM5N/qhsrPtAURWug2dIJ44c+YhLQZ10uGlXoZxGfyLIh20GjwDfkmZSQA2OOZ6mpjJVlRFX0y27Ss8uN3naPOTNZH4vmR5MxTJcMUDYQoRuNp75uN/EDzB2YyrvaYjzSlh5jBTzf4xSjfq38kZkd1mOQSKhfYACNHTv+QVMMM9bc6SxmOlM360boQEjWEEaVo64K4KftzZkvrTYvFscukk5B9SGmPAZfQHtUXhzTf3j9QXi3YMYOt/20Y/1vi2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS5juFsLboCMQkvhyE49apZfRAztm95iwONF7Yf9iGg=;
 b=I4qDNUcZWP+QF9/ydMWb8vTaYArwzhuJo4arfHoV3WO9U7f89MSJmYWvQU6BcqoOxu9r5R+r8zAyQUQQ1AGdQq7cmVhHJ1d8VniiHSPONABjBJj3Lp+1kh08ILvg0eYYLcmUiLCRRsXjsDnw2MgQnW6HqGz4TNzCdHZHabRqRPjQ9mCLR2npDfiPjUdA0r2stLiAC2um8GEKvQ98h4oLR9tL19EaACKEOi0tccdg42SbedKB32bCmhFdScWqoQhs++W9SQLgVn/uVzRfJpGZlIAvwV1FOq3MEmfklsfrDCZv19TsIj0jxiAdAZWjje9PzSVKLkGXeM3BmlC3HNePQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:36 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:04 -0400
Subject: [PATCH 11/16] ARM: dts: imx6: replace gpio-key with gpio-keys
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-11-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=1616;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MA+Pybvz0YhG284LWyUdIqvPD6+sMepp+tMKiruhPb4=;
 b=NqISH6XJg6excmaTNcEoWP2UAHz1EKkK4JbDvgNQ4jK5BB2Fz39RTvAHecumLzFhaI3M2xyzU
 MI+QhvghO2PBxU/Ym8jBSsfHrihbdl4wy9hMyTpDtox2loKgHvvPC2L
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 304f7012-e0b1-4eab-652e-08ddeb275794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2VQSE1nSXN5ZnQzVEV3Z1dTcW42eDFGSUF2NFNsd2toWGVKNkcwNHF2RW4x?=
 =?utf-8?B?UTNMY1Yvd05pUG80TVRHb3VnVFlUSW8zeXlkeDhZeld3dmVFTGJUVVVTY2k2?=
 =?utf-8?B?VFdRSW5VMWVLejI0NDNDbEE0SUZhR09YRi9UeTVCcEF5RlZPVFo1MkR5RE5W?=
 =?utf-8?B?SFdvMXMzU1BXRmJOTTFxTSs1NHJ6VFlmRFNleHhGT2h2WFc2bVJkZWpSbTl4?=
 =?utf-8?B?dUxHNXBXSm9nZnhjdnRQZEtpeVRQb3M0NmFPdm9XcG9NaFRrQU9QamJzbnlv?=
 =?utf-8?B?UnN5Wi9RanVuUTB3eUM4eWZncHpuUGVOMWRTaTM0ZGFqS3hnZWtOUTJsK0pv?=
 =?utf-8?B?eE9NTzR4aE9MdUtYQThYQ01PQTRXL25kM0U5QVFKT0thZ1Byc1NTYVViTy9Y?=
 =?utf-8?B?dDFseGVDbGtJSWxFQ3B5TEMxcitzNGxmMUpkYmtrSEJpcXRmeitqTE5MQnV4?=
 =?utf-8?B?NWQ4eEFuU0lVYTNESmgwcE40eGd2Szltem1uNHJQTXJVd1FPRmRZdnZyZ0t0?=
 =?utf-8?B?SzZyR0ZmeXJZblNYL2lFcnQwQkRtU1p1T2FEQXltMzcxWitFWXVKbjU2bVhX?=
 =?utf-8?B?L1J0TURhWUgza0k4eU1xbnIzZUhQdTJxY0g3RkxaY25sZEtGT1I1NUk1bXFJ?=
 =?utf-8?B?RUJDcVY5Yks2b2E5My95cnl2SjJyTytuUWY5bHc2MEZaRlUrRjRXZDdmdTFh?=
 =?utf-8?B?ZjZTd0FsMG9mMWNneDNtV0FKdkxwRFl3M3o2ZXkzSGxiTm5LOS92M0FHQi9S?=
 =?utf-8?B?bk93ZlE3c3FUSnZHa2VMWWpvdmIyTVNHeTNSaVRXRm0wTTFXaWZ5K29TcWx3?=
 =?utf-8?B?enBET1NrNWpySTBMVU1UU0hVd25XVzlaQ1R1dDgwSFhzTk1kcUl1ZWdiTERK?=
 =?utf-8?B?OXB6aXEyL2JRMzJGMjVkTSt0ZUpvMW1YQ1pOSUk3T0JkZWZlT3lJT0U1VE52?=
 =?utf-8?B?S0pnOEtHYWV5NDluazlodjFQR3piWWZ5dW9hYjdRYjV4WmZxc1hjOTdWZTFD?=
 =?utf-8?B?b3JhTEZjdHFldXN0blEzR3MvMThNem82WFNuT3FrZnVDK01MbURzL0pZMEcy?=
 =?utf-8?B?ZGJzQndRbzR3L29lSmdZRCtNQjZvc2dJdnI5RHBLSnhIdnVIVGVXWGpGdUMz?=
 =?utf-8?B?S2p4c1dMRmx0OW5KUVBLdmNJLzZvcHBGTUE3UEJZRGtYSjd1VWRpSUlTc0RR?=
 =?utf-8?B?TjNJRXNuQWd4cFBSL0lPY1ltVEVXTHBrNmcxOE51REg0aU1pOS9HaGwva25O?=
 =?utf-8?B?QnBaY0hSUXAyZTdWakRzVitxM2NPVitIcm05QzArY1Q5L2RXMW1ialpKSVVj?=
 =?utf-8?B?VDlCNkJqRDNnNmZaSnBqMVVzM3RqOUQ4SitCaFJwYlVqbnlORjNSTWN2ZFRI?=
 =?utf-8?B?QVhzNExtNnVpczZjWVJsTFA1NDA5REdsQnkvTjd5czZWbTRoKzRKd2Yxa0x4?=
 =?utf-8?B?QnE5TmJFeVo5VGRRUEoxYTVZNmR1cEFoeTRSbUt3SnJMMWgrZFN0MEgyNWha?=
 =?utf-8?B?VENvNTV5dnhCL3d0SytNT1FHQnkzbXFxUERrZ25OaTBoSkxMNDM5NFloTDlu?=
 =?utf-8?B?cDNUWGFNWm1od0V4cU1wcFNDTzh3dmhtNWlSSlREMm5MRkQybk9POThwQk1M?=
 =?utf-8?B?anlkN3BjWjgrWGJPaWc3NVp5NWpHUnNyVXBDQTRodVVoWGZjbHdLSEp1YmRz?=
 =?utf-8?B?TnN4Q0RTRG1BTTRoQ1EzMDRlTVpLZ09OOWMrNW1YeUxNbHNmRFlUZDlPN0NK?=
 =?utf-8?B?ZE1iSVNYUGZTWHFQZ1NZS29IUncxTkYxek5aNmFiSkdoWjAxdnVXRTd0TmYy?=
 =?utf-8?B?eWdkQ0Q1UGpzRWd1UlU2NVM5ZWlWRlFnQ0ZVVnJla1BwUm92YUd0ajMyWXpa?=
 =?utf-8?B?cEVIekJFSTMyUGo5b3JKOEI2YWdzR2FMU3RjRFNIZkxneGZzaUlXTHJZb0cr?=
 =?utf-8?B?Q1ZtU3JDM1crdDc4eDR4VFBtZXgwYmFld0gzYmNCaENlUVY1TS9UUzEzaVJR?=
 =?utf-8?B?R1QyU3pZek5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aThIemFvTjVQNG0vZmlCUU8rbTYreGJ2UEkyc2pOODg3NERQQm5vTnlrNnRP?=
 =?utf-8?B?UXFhN0dlM1ZFV0swL3QycHlTblduTTZuTmJxYlJoeElvWnRxT1ZzeHc2NzA0?=
 =?utf-8?B?bnNhN3kySmhuU21FQ2hveUpjamdLNjFwQmVHWVF6QzE3M3cxVEVqT2VtSEpG?=
 =?utf-8?B?QVZhdDBhQitSZCtkOFBXdUdaTENjRWszWmY2a0NidHh4aG1aK0dXNGtuZWNK?=
 =?utf-8?B?dGVqRWhnQW10Nm1KM0pydkdqZjFMOEtiUFBYcmJXV0dZd2htQ3ZzemZiTSt3?=
 =?utf-8?B?ZEtjeGlPejdWdDZ4Qk5SYVI0UFFqdjNDQ2NKME4xMXUrTk11U001Wm5xd1cr?=
 =?utf-8?B?MmRIS2tnUXdXeC9RRG44NnowT292RHV2SW1JWmRjY1Vrc1J3Z3BYNCtVZW5q?=
 =?utf-8?B?eEwyV3U4MUNwdGQrTlNMSDlwcDdvYk9pNE41YUNnMGFNWmJOcEo3UWFueHBv?=
 =?utf-8?B?TmhIRnhYOXRwUUhVekx1NzIxbDY4QnZNbXlJbnJUYTBqc0FuUzNJT25LQUtm?=
 =?utf-8?B?cVdneDBRVEVHSk9lM3EzOXdXUVdsa1JJZUxtT3NmcDduQjNialRSZDR4N1lh?=
 =?utf-8?B?c3hoRnFKZUlrN3huWG90cldvZXdEM0dhMGJ3R0pEZU1mcUNkVGdUdWwvMkcz?=
 =?utf-8?B?Yjc5b0FYdmQzcjlnc2NHWlJONTBwdkdkMU5DTkhhMWtVZXJYVm5EZVZQQUVC?=
 =?utf-8?B?a1ROM3RzOEQrd3ZRUTdjOEc4aWIrenNTVkEyc3RDT0NZM2d6TUp3MiswWjJ5?=
 =?utf-8?B?dlpEVDRKVlRhaGc0ZE1YSlVGTG12NnJnU0Z4ZWZjQUtubXJNVy9rNUVNQnZW?=
 =?utf-8?B?amcrN09TK2RrUy9OdjZNbWprV3FaMXNqWjVSNTQ3UFo3RFAxOUtETjN6ZDJG?=
 =?utf-8?B?SEliR3RHK0pkcTJSV2N1a2loV05zSU03d1g3T0xuR3BDTjN1cUFZNW1NRkN2?=
 =?utf-8?B?Ky9tWjN4dHZUY0tyQ1kyZUtVZzRmTS9YZ1JyY2Z6NXdUN1BwREs2bWo4eEp0?=
 =?utf-8?B?YStFelo3a2dxdGNXbDRmR0pzOEZwZ0VJcHhidWJ2VXpIalhYd1JDUjViNzRD?=
 =?utf-8?B?VHB3SzZZYmVmZkRSRnJqL3h0dkJYUTdMMWt6V29BYytrS2hZd05kQXNrczRR?=
 =?utf-8?B?K0ZBMHZ3a0lPNlRUa05ocEFEWWN4MkN5NGUrL2dkWDBCa3VkNFlneGdzbUZT?=
 =?utf-8?B?WVVKVjdzOXBEeERnK28wZE5mSFJvZ1hKbkxJdXV6TkRSc1ZFOFFybmNlSHZY?=
 =?utf-8?B?bkpsTG1JSFRaVTJwY3hIUkI3aXZ5TEEydWlDcHZEZEFFSWZzZDBYVm1JaFUw?=
 =?utf-8?B?SFhRY2hteHJEeHZuT3NnMGo3OGFqYXA0WGVPSjFRbFovckNyS2dOSEtWbW94?=
 =?utf-8?B?Z1V2MnYzK2tWY010RFBUOTRURWNLWFFiemxTOTN0SW5lQ2pzNVZhcVRRdEJM?=
 =?utf-8?B?eFNucHd3OFNZWTltQ1R4NnFEU2g2QWMwaWFGU0NWQlE0OTRya0dzYkgzNUtv?=
 =?utf-8?B?WTFOSGhqWHYvV2o4U3h1ejlVZDNNWXNpd0Z3UWRIQzQzVzFFZmlmck9Zd1Ji?=
 =?utf-8?B?Z1VPNGdLUExCTGYrWjZmbUFUbE5NdzBoRHNxZm82SC9aQk9qS0VncDUrSHB4?=
 =?utf-8?B?TklER1BnQlQrL290bkM0bE9UZEFkaTNxdWZhRS9wUXNrRjl0MXAwc3FSb3ox?=
 =?utf-8?B?RzVDTGlJLzRKYkRZU1FpMlZjbXAxU25kZEtmT1Rua2MwOVdDVHJJekhlWGpY?=
 =?utf-8?B?SThCdkhUditia0tNOG41aGJwTTdpM3JyZXRuOVZoRjBKM0YxanlNWWtKOGQ2?=
 =?utf-8?B?QjExd2pBcWdpREd3VW5BN1hyQmNmV2pnTkM0YzVxQjhFZzlwcElCOHRobkE5?=
 =?utf-8?B?Zllxd05Jd1RkTU90eDh2VHlmOWNvSUoybk94M2dtZ285QmtNZ1pwN2NLNXNv?=
 =?utf-8?B?RXI4anE5V1BQUytsank0UTc3dnlsY21XYXJhY1czU0RGU21zZlA2UmxXWS9G?=
 =?utf-8?B?MXdWUCt4VUZLM0lCRzNiTVlTc1lvWmF5RWVKNnB1UXZXYlVyay9JbGNYQlM2?=
 =?utf-8?B?ZWJlQjgzZUVaNC95RktXbVJMbHpIU3hFTzUyN3BuR3h3cTdkNW5PMCtKOWFi?=
 =?utf-8?Q?rdm9GkrU8VFfgr0xYaLNlUnOj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f7012-e0b1-4eab-652e-08ddeb275794
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:36.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZjVivrLk6Dbqi5qicjKboFWOOX9z5+vJYzwI4AE3Or/TXqMzd9uk/wtjboIjECrBlqtxr45HWb2iqwky46Pug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Compatible string 'gpio-key' is not existed. Correct it to 'gpio-keys'.

Fix below CHECK_DTBS warnings
arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-ff-rdk-emmc.dtb: /gpio-keys: failed to match any schema with compatible: ['gpio-key']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
index d4d6ce9756390d6b7aa296eb585fc7fe61a67443..24c48cdd1797e43fb364ce6680b4f09bb526e788 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	gpio_keys: gpio-keys {
-		compatible = "gpio-key";
+		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 		status = "disabled";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
index d12fb44aeb140cfacf05a5b257d2106c79392279..8ad09fd334f74cf7e1711a57885564eb9a549902 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
@@ -15,7 +15,7 @@ aliases {
 	};
 
 	gpio_keys: gpio-keys {
-		compatible = "gpio-key";
+		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 

-- 
2.34.1


