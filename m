Return-Path: <linux-kernel+bounces-877219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FF7C1D76D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56383B1024
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50DD31A554;
	Wed, 29 Oct 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K6er1RL6"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403531A055;
	Wed, 29 Oct 2025 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774042; cv=fail; b=qtcMj/bnwJaT4GBVZFpuJvZ6RmduyTorihkWHTAZSpNmtrGiKEXF2nVGjClMgc0HrQHcbOGEGLihhBCJ/QBO9RJwtJ/HDoSxErKjUDKFmCVJig46jbESJxAevFQFr93gNqs8SRojtjxgGUO6vHdx2ECf/a6PYRBgr6tBTKL5qGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774042; c=relaxed/simple;
	bh=RTg3aC1ns0VOPZ2BIfferXPcz1WZ8dCcnNHFpp/elTI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PSz6k16n4pK9iSpk6H2gtfZjL4XbrssQGEyeI9+KNw11fYcCBTz5NudTDCU3r4Em6Zr4S64YM8NCA2+sDO8sK7na3+SNPM4zplpp/5000l+dMKsyh66zOKqYt9OLwVtYuKpklUgu0nG4B5as8Kmv/Jp8jZwndYnvc8rdeD8U8DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K6er1RL6; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMbYEVsRfhZqquwR9eAXuukEHUJdxcRgRM7RZC4NRLtikiO+8mUMEqGRYOTNt/i4R/7HGBxG9YMTHQoNEtBou1kvFfeYoG2Guee8OxCpvscmKy2C7sBkLffeM/v+QnOz0zetmqZiibmqDlWIAZxG0UYmksWfWcYYUG+5QqO1ScL9INvZ0hiCb1P9yMfjZ/SrpaNllWVsq3sDWu3mM+GSfQbz9cQhEBupR/BX+RbPVE+vujSTSdRwjqDN5vNv4A+xQj+zlePzRbiiFhEZb/3FDxpZaQ2woMdzIlI7r6MwMl+jOANVmHK0PLwPae1xQdGWMhUnd2bPkOlX9wIU3jfRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzImbstGgjASRy2a+PwnFb14O0pvviAd0l/uxWgZg0w=;
 b=jv4DfVTkgyxP8GnNr6IYlPXWv7djhGCWqYaOV5ytFZ2jmXO5bqQAIWzGAN/2TmaevnMJCK+YW/EnsOOBWPM1dfBctsgm/bxarRgNEiANpYUvitBxljDYXmcryuVXIYQ277xFfdDmfAd7G+QiYNZMxnGQscIu62YuxzvnwZbukSjfoqqEnmHlcUqUl9UdYHwK4fqCeb4inJ2x9PKMQYd0TJiEJRCZo8LQuzVgGNjijN0otM6rD4M/TU7jqqcdrmibLNOG/7jgVelXtsMtr171yHvdAUMkV1jaK38DTDU0Q4WHnAiJwsIlJxblPiz+JcxBJfj3vGWl1AJrZoMATIMLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzImbstGgjASRy2a+PwnFb14O0pvviAd0l/uxWgZg0w=;
 b=K6er1RL6TwaUiIyNdPLSa+ACSlgAad/kZi5AouoOWmOCYhp16aKSdArorYsowWdpOmepXjQ3EaYt+Z5mCjzSdubXuufHAT0z53gs9LDvI+Stc6TQIUXmmTdgRIep52D3nwraa9bOHLU15Ml6bBACEVU/ytOjXgD9g5TDvN9Fai2K0rbC+AaCStW0qt77LnDXCpzuEky+q2K9Wy7rt0+/zPcAJB0Bx8j4mbE0yA8CRzls3cwGosDK+uVMXYiohG0AicTGi+Lkedz2OvK++7mgIW5omAnptNTVD1LNxKP3fYtBKlM27XXYcdCuBYvOcDkueMManfmYCwCeHEDz5pxoGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBAPR04MB7286.eurprd04.prod.outlook.com (2603:10a6:10:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 21:40:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 21:40:36 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Peter Rosin <peda@axentia.se>,
	patches@opensource.cirrus.com (in file),
	linux-sound@vger.kernel.org (open list:ANALOG DEVICES INC ASOC CODEC DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	asahi@lists.linux.dev (open list:ARM/APPLE MACHINE SOUND DRIVERS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] ASoC: dt-bindings: consolidate simple audio codec to trivial-codec.yaml
Date: Wed, 29 Oct 2025 17:40:15 -0400
Message-Id: <20251029214018.3969034-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0153.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBAPR04MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 89658de8-935e-4813-d692-08de1733cba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|52116014|1800799024|376014|13003099007|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVp1d2NHcktTdmZrN2pkNDljUWdzOHVieWQ4aDl5Q1NPa2NudDg1TGtzaTVQ?=
 =?utf-8?B?bXRSempSOG5IY1FwV0labVo2RzRCSHZTQjE0L3dQSFd3VEVmOVlFY0pGY1pB?=
 =?utf-8?B?M0YwUDJDUCtVb050K1Qza2pJMUE4aFZZOHdleE4rdGlKY2g5ODdZZ3BKd2p4?=
 =?utf-8?B?aTF5UC85bWNWUllzUzkvTHRMcGhGQ2VOc2kvWWtGNzZSM1dOK0Q0KzJHdGpW?=
 =?utf-8?B?TnUxUnNFQ0Eza0VuZ1l1L1k0M2I3d21rWWtUVDVvOUFUTWNnMFNPMlZyNWNV?=
 =?utf-8?B?enBEMUFZa3FKZ1VwM2ZMTWt3aXBoNGJVTGNPaGRwNUxWMkJQbzZoQXAzOWNU?=
 =?utf-8?B?aW9mVWlFTmVFTlZTbmxva3ZJalJwMzJSUkkyRG1aQk9jUHliZlozU0pSaCsx?=
 =?utf-8?B?MTVNa09IUUp6N2F6N0lDam9JY0NCeStVSUlmMzAzbjdNeCtHNWJrMzlJOXB6?=
 =?utf-8?B?MDRVN3Z4MEU3ZmJUeTA4MDhxTDgxT3NsbkdiZ1ZxV293UE8zRW9NK3BTZVNP?=
 =?utf-8?B?TFkyYjZ6KzU0Q1NYN0Zqd2dwK0dCRUxucGJOVm1sZEg4SGRtUzlWRjlMZWlr?=
 =?utf-8?B?TVpnTy9abngvL3NRdXNBaTNCaHd5dFloQWduaGljdmFUbnZVdHc0RHhmU0pz?=
 =?utf-8?B?Z3VMa1o3cDZ6aEs3Q1FSMm5vRWhOU0pZcWdJbTV5Wm95aXlqZmVEZnBZYjR3?=
 =?utf-8?B?Z2JlcHlwZmgvaXdzQ21yNzBtY0ZLQU5EOGlMSjh4WW5JVWMrT0FSVlBqSWhN?=
 =?utf-8?B?QWlubnJFUkZVRWpZK1lVQkZmbnFMQWpnMGlaaXFFa0hZQ2swR0RxUkQwZFFD?=
 =?utf-8?B?a1NjVXNaV3BsOGR5aExLdGQycmxFc0szZ0grbmlDVGw3ZGg4eVJKd3czOEZx?=
 =?utf-8?B?OVhkNi8wOUlMdnAwYzNQRzRCRTdBWjRaUWlER0dXMUUraEkwLzZSK3BQU3Vs?=
 =?utf-8?B?R1djNmJKcE94ZlQ0cnlzaWlYK296c2NGMXFESmVLbEVYM1BiYkFjRGVMa0VM?=
 =?utf-8?B?SE0yYzJXTHhjbGQ0eUd6enFrQXd0MHJJZTVYVjgvVHVsRldtMVJoTUFEWU5K?=
 =?utf-8?B?M2JqL09iZEYwTnljY3JteUVuLzVBOGJLSEM1Rml3ZmhEWmFVMFQrbHF1Wi95?=
 =?utf-8?B?cVp0VVlCTGpFSEtqbnRORzZ5TXNXY2VEbnA5YWxJYjNncXRPOHFvYlpIVDNv?=
 =?utf-8?B?c3lBR2FEajNhb3pOeCtvMDdEcUN5OWZGWHN0N2I5cWd1ZHhiOW5sRVhiN2tY?=
 =?utf-8?B?Rm5yamxoK0dISWJzRGFMUkU4ejh2cmdkRUxwNUFmeHpsZTJtditROEdGdTk3?=
 =?utf-8?B?RVY5c0ZHcS95ZS9oRS9BemUvZ1UveU4xbXVzZmo0ekltdWNwSzJEbzJwRW1V?=
 =?utf-8?B?MWJIY05nbXdTWkJFYWJyUWVpSnBrU29FRzVVWmhzeDZZSFl3d28wamgvSjFo?=
 =?utf-8?B?dld4UnpSYzhpU0RyZmtyMzRKaUczZksxdEFYRnByZVl1S25rbW1NYnJSQXVP?=
 =?utf-8?B?ZS9GakJNaXJzQmVjQ01BYzZXOVViY1UwVVNML2RBNGwwL1k0UTlrVkc2eDJQ?=
 =?utf-8?B?WGppTmZhTzcxby9zelVmRGZFbGNoZ0NBWThnTHlGQVFZa3lHMlJqYnJUc05M?=
 =?utf-8?B?UjJMODZDMjZZVVdtYWtYUWE0M2JFaWIzOVM1WGxZSTJURkJUYWd1a0hZSXc0?=
 =?utf-8?B?UkNtU0QzR216alplaVM4bUZ5a1ArSDFCMStXZFNHRG0xVmRPbklIQ2ZpZnVo?=
 =?utf-8?B?QzlGYmxXUHBJdmhXNUVwdVdtV1NQTk03dHBwc0lOZUdMUHJHdk1MTVorUUw4?=
 =?utf-8?B?NlVjRFdCampzbDRjZHFBTDFJZno5aGo4d0MwUmlOUTlDMzZ3QmE4NS9jOE5r?=
 =?utf-8?B?VEQ3aU1JSlltSFJxdC9XTkRhaGNzT0VEeDFUMDYvaDdYR1VBeDVYQkJGaWZS?=
 =?utf-8?B?YUVEQ1FOd1ljOFVFYWcxRjRzazlBa0xJSFlRd2JtVExXTG1vNGNkcm54RW9Z?=
 =?utf-8?Q?2l19re36cOU1tnRSBdwmJgTOmdXLSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(52116014)(1800799024)(376014)(13003099007)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRUWG1LZGwrNTVNT2Z6anlJTEVqdjJoVlp0dko3K1N5dmx4dlA5T2RYb0FN?=
 =?utf-8?B?ZFp4U29DSkRWWkM1MkYxR1Zqd1RreXMwR0RUZ2JEWGNDaFlPRldCbTcyRU95?=
 =?utf-8?B?RHhTalN0dEMvWXVSMHFVcUlsWmRsbjhuZ2VQbVgwSWFpazJSdDdGRFU3OE5F?=
 =?utf-8?B?eTVUaWU2YTB4ZHpXLzY1SWdHUy8rODFJTjh3ZldwYlIrYnY0TndJVHp0eG85?=
 =?utf-8?B?MEZyeTlCVWRkZ2w1am9pWEI2djkzWEYxT3ZDV21FeHVwU0dOa0ZOWFNUdFB4?=
 =?utf-8?B?aVF0VGIwd2d0bnI0OWdjVExlTWhNdnM1V0F1d1NSREZmSVdCTFpwNS9BbVV4?=
 =?utf-8?B?OGhFTHV6dE1YWXN4dGhvcEo5Y09hUFppQVdEcjN6OElEWndHMDEyQkhVMkpt?=
 =?utf-8?B?akRRRjJEakZzMkx0MXpOQ3k1Z01aWkFCc3gydkR3MEhnWU5UVTBJYkJUQnZE?=
 =?utf-8?B?ZGhQbUt4WmRKeGVHelRzNE1zOEdTRWk4NjAzNDRLNXU3QnFhcEZtRUFWRVo4?=
 =?utf-8?B?WnlVazVDY0UrREtTamNXM0UxWVJQUTB6MmpJeWF2aEpaa2VmQ3p3ekh5VE16?=
 =?utf-8?B?TFVqZjZDTlFUYkRzWWN0eldOQURKUHR5bmVGU1oyUHZmTHJDUHhJNzVlSy9m?=
 =?utf-8?B?STdMbngyY0k1YWsrcGV2emNKTnNIS05RQWM5Z0Y0R0wyS1EycTBkOUJxN09j?=
 =?utf-8?B?bFJTMFVkQlEwKy9PcmpZL2NDVDR1S2xBQ1o5SUN1eHAyUERwRnpLcFBvVThM?=
 =?utf-8?B?R1BBVWtYa0NCY2hhUkcxUmloRE52K3V4MU8vMDF6eXRKclN6c3NQNEd1MEpP?=
 =?utf-8?B?S09oTUNhQmVidCtaYjYxbEtTaXgram1TVlBMN0VNTm50dDZxK0p4N1ZnWDF3?=
 =?utf-8?B?NHJpTUh2R3lGRE9Sb0x4UXNtUDBjby9ubmc4aCt5TXc2SGFlemZCemU3NFBL?=
 =?utf-8?B?NHEyeXpxTmdTQlBtaFpvdXpOT3NEczlORDZ2RE5EbmZoeExzWDMvT0lLTW9O?=
 =?utf-8?B?dy9DYWwzck12MkVvUVZSNlBFUFRIVG05Nm1lTk5RcHdGTkxDNzJyc0lKcXdl?=
 =?utf-8?B?bkM4dUdPbk1rL3pFd2lSSG9udjBaSUUwQ21ibDFkODI5UVdjcmxPZ3hTOHMv?=
 =?utf-8?B?dUZoQWpmWGl0YlBSUjBtZldEUXFHY2NsRTBYc1BGRzU1YlVoUHptUHZCNmRE?=
 =?utf-8?B?TzNYMnhYNngxbk9YTm14U013MkJHZzN4RTcxcnE0eVR4L0pmS0ZhK0ZQbFpR?=
 =?utf-8?B?c2FlVzRIZFQrRVhQZzRaSllFb3NRaWxNbzZvOEhSWWhaTUJLSnRmWlMvTUE0?=
 =?utf-8?B?Z3JqV05hM2J1OGg1TGlGRlVWMmdic0V0WGl4TDVydnRlN1RjWnFhY0ZRcElW?=
 =?utf-8?B?WVlDY0VmTXhxT3dJalB4YitEVFRHd1BKVEFPeFFjQUc2TjQvbUh6cDhYeHRk?=
 =?utf-8?B?b0U3NTNVNHU4QmpWOVJXQnFqY3NBdlFpcVRMZGNBZmYvS2dRV2tOREQ1bkUy?=
 =?utf-8?B?c2RncVh4Z1FNMjVBRGVsczVRcjZ0MktMSTJsYlM3YkVmZXVNRFZrVVB2SWlm?=
 =?utf-8?B?VFcvSHk3YkJMSzJIZzBmMGRZdkNnWVF3YXlVV0IzaU9CNzlNd1BCelNDbFBp?=
 =?utf-8?B?a00wVUlsVHZzWVpTYTl2ekE0eVZIblN3ZDBlMEdQSGMrenRNdEtvZzFvZ2p4?=
 =?utf-8?B?MFpIak95MHhIZ05PanVYYlRRdG9nOHNCbEtJTzFjczk5cGxVWGhneEJQNWVk?=
 =?utf-8?B?Z3RqK1BXZHh4amsrTzc1WlYwR2h5UHE2dGZaaWN0d3Q1ZjVQc3JvaGpIUjh6?=
 =?utf-8?B?VlAySjk5WEp4Ujh6NzZMcE9nY3pJbk82WVF5WkZXVVRhcnIvYkp2dUpMQlFT?=
 =?utf-8?B?UVV6TnRBaHI0RXd3WHVYZFc2aUdHMnk0UmQwbHdPc0JLZTE0VTNRUDloVVlV?=
 =?utf-8?B?aUhXY042RkpETGxkeEJIbm0vbmJ5ZUhPQ3NOTWhyaXErMVM0dFVVb1RlRUY0?=
 =?utf-8?B?V0taU3U4MU42K1ByK0UrQU1aMmV3Qk96aXVmRzhRQUJwU3FNc2Z1MWl1QXdo?=
 =?utf-8?B?dFUxTlh3bGdpOXFVdzdIWHUwYllOS0NNcUxvN1hTc1dSTFZRbkV2UFNoWUVw?=
 =?utf-8?Q?NJHU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89658de8-935e-4813-d692-08de1733cba2
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 21:40:36.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr+oGc/oX2tjsLkQrpTgBYJRjznwlKtt15fqsKUMWDUXrEp8JLS/zq9BaqK2XUmlqrKCi/cNGXK9sXbaEsTj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7286

Consolidate simple audio codec (one compatible string, one reg and
'#sound-dai-cells' 0) to a trivial-codec.yaml.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/sound/adi,max98363.yaml          | 60 -----------------
 .../bindings/sound/adi,ssm3515.yaml           | 49 --------------
 .../devicetree/bindings/sound/da9055.txt      | 22 -------
 .../bindings/sound/nuvoton,nau8540.yaml       | 40 ------------
 .../bindings/sound/nuvoton,nau8810.yaml       | 45 -------------
 .../bindings/sound/nxp,tfa9879.yaml           | 44 -------------
 .../bindings/sound/nxp,uda1342.yaml           | 42 ------------
 .../bindings/sound/trivial-codec.yaml         | 65 +++++++++++++++++++
 .../devicetree/bindings/sound/wlf,wm8510.yaml | 41 ------------
 .../devicetree/bindings/sound/wlf,wm8523.yaml | 40 ------------
 .../devicetree/bindings/sound/wlf,wm8580.yaml | 42 ------------
 .../devicetree/bindings/sound/wlf,wm8711.yaml | 40 ------------
 .../devicetree/bindings/sound/wlf,wm8728.yaml | 40 ------------
 .../devicetree/bindings/sound/wlf,wm8737.yaml | 40 ------------
 .../devicetree/bindings/sound/wlf,wm8750.yaml | 42 ------------
 .../devicetree/bindings/sound/wlf,wm8753.yaml | 62 ------------------
 .../devicetree/bindings/sound/wlf,wm8776.yaml | 41 ------------
 .../devicetree/bindings/sound/wlf,wm8961.yaml | 43 ------------
 .../devicetree/bindings/sound/wlf,wm8974.yaml | 41 ------------
 .../devicetree/bindings/sound/wm8770.txt      | 16 -----
 20 files changed, 65 insertions(+), 790 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/da9055.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nxp,uda1342.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/trivial-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8961.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8770.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
deleted file mode 100644
index c388cda560113..0000000000000
--- a/Documentation/devicetree/bindings/sound/adi,max98363.yaml
+++ /dev/null
@@ -1,60 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/adi,max98363.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Analog Devices MAX98363 SoundWire Amplifier
-
-maintainers:
-  - Ryan Lee <ryans.lee@analog.com>
-
-description:
-  The MAX98363 is a SoundWire input Class D mono amplifier that
-  supports MIPI SoundWire v1.2-compatible digital interface for
-  audio and control data.
-  SoundWire peripheral device ID of MAX98363 is 0x3*019f836300
-  where * is the peripheral device unique ID decoded from pin.
-  It supports up to 10 peripheral devices(0x0 to 0x9).
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: sdw3019f836300
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-  - "#sound-dai-cells"
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    soundwire@3250000 {
-        #address-cells = <2>;
-        #size-cells = <0>;
-        reg = <0x3250000 0x2000>;
-
-        speaker@0,0 {
-            compatible = "sdw3019f836300";
-            reg = <0 0>;
-            #sound-dai-cells = <0>;
-            sound-name-prefix = "Speaker Left";
-        };
-
-        speaker@0,1 {
-            compatible = "sdw3019f836300";
-            reg = <0 1>;
-            #sound-dai-cells = <0>;
-            sound-name-prefix = "Speaker Right";
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
deleted file mode 100644
index 144450df58695..0000000000000
--- a/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
+++ /dev/null
@@ -1,49 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/adi,ssm3515.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Analog Devices SSM3515 Audio Amplifier
-
-maintainers:
-  - Martin Povišer <povik+lin@cutebit.org>
-
-description: |
-  SSM3515 is a mono Class-D audio amplifier with digital input.
-
-  https://www.analog.com/media/en/technical-documentation/data-sheets/SSM3515.pdf
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    enum:
-      - adi,ssm3515
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      codec@14 {
-        compatible = "adi,ssm3515";
-        reg = <0x14>;
-        #sound-dai-cells = <0>;
-        sound-name-prefix = "Left Tweeter";
-      };
-    };
diff --git a/Documentation/devicetree/bindings/sound/da9055.txt b/Documentation/devicetree/bindings/sound/da9055.txt
deleted file mode 100644
index 75c6338b6ae28..0000000000000
--- a/Documentation/devicetree/bindings/sound/da9055.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Dialog DA9055 Audio CODEC
-
-DA9055 provides Audio CODEC support (I2C only).
-
-The Audio CODEC device in DA9055 has its own I2C address which is configurable,
-so the device is instantiated separately from the PMIC (MFD) device.
-
-For details on accompanying PMIC I2C device, see the following:
-Documentation/devicetree/bindings/mfd/da9055.txt
-
-Required properties:
-
-  - compatible: "dlg,da9055-codec"
-  - reg: Specifies the I2C slave address
-
-
-Example:
-
-	codec: da9055-codec@1a {
-		compatible = "dlg,da9055-codec";
-		reg = <0x1a>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
deleted file mode 100644
index 7ccfbb8d8b043..0000000000000
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/nuvoton,nau8540.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Nuvoton Technology Corporation NAU85L40 Audio CODEC
-
-maintainers:
-  - John Hsu <KCHSU0@nuvoton.com>
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: nuvoton,nau8540
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1c {
-            compatible = "nuvoton,nau8540";
-            reg = <0x1c>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml
deleted file mode 100644
index d9696f6c75edd..0000000000000
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml
+++ /dev/null
@@ -1,45 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/nuvoton,nau8810.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: NAU8810/NAU8812/NAU8814 audio CODEC
-
-maintainers:
-  - David Lin <CTLIN0@nuvoton.com>
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    enum:
-      - nuvoton,nau8810
-      - nuvoton,nau8812
-      - nuvoton,nau8814
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            #sound-dai-cells = <0>;
-            compatible = "nuvoton,nau8810";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
deleted file mode 100644
index df26248573ad5..0000000000000
--- a/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/nxp,tfa9879.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: NXP TFA9879 class-D audio amplifier
-
-maintainers:
-  - Peter Rosin <peda@axentia.se>
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: nxp,tfa9879
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-  - '#sound-dai-cells'
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c1 {
-       #address-cells = <1>;
-       #size-cells = <0>;
-       amplifier@6c {
-          compatible = "nxp,tfa9879";
-          reg = <0x6c>;
-          pinctrl-names = "default";
-          pinctrl-0 = <&pinctrl_i2c1>;
-          #sound-dai-cells = <0>;
-       };
-    };
diff --git a/Documentation/devicetree/bindings/sound/nxp,uda1342.yaml b/Documentation/devicetree/bindings/sound/nxp,uda1342.yaml
deleted file mode 100644
index 71c6a5a2f5bc0..0000000000000
--- a/Documentation/devicetree/bindings/sound/nxp,uda1342.yaml
+++ /dev/null
@@ -1,42 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/nxp,uda1342.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: NXP uda1342 audio CODECs
-
-maintainers:
-  - Binbin Zhou <zhoubinbin@loongson.cn>
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: nxp,uda1342
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-  - '#sound-dai-cells'
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      codec@1a {
-        compatible = "nxp,uda1342";
-        reg = <0x1a>;
-        #sound-dai-cells = <0>;
-      };
-    };
diff --git a/Documentation/devicetree/bindings/sound/trivial-codec.yaml b/Documentation/devicetree/bindings/sound/trivial-codec.yaml
new file mode 100644
index 0000000000000..9467e57a0a90b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/trivial-codec.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/trivial-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: collect trivial audio codec
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ssm3515
+      - dlg,da9055-codec
+      # Nuvoton Technology Corporation NAU85L40 Audio CODEC
+      - nuvoton,nau8540
+      - nuvoton,nau8810
+      - nuvoton,nau8812
+      - nuvoton,nau8814
+      # NXP TFA9879 class-D audio amplifier
+      - nxp,tfa9879
+      - nxp,uda1342
+      - sdw3019f836300
+      - wlf,wm8510
+      - wlf,wm8523
+      - wlf,wm8580
+      - wlf,wm8581
+      - wlf,wm8711
+      - wlf,wm8728
+      - wlf,wm8737
+      - wlf,wm8750
+      - wlf,wm8753
+      - wlf,wm8770
+      - wlf,wm8776
+      - wlf,wm8961
+      - wlf,wm8974
+      - wlf,wm8987
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1a {
+            compatible = "wlf,wm8523";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
deleted file mode 100644
index 6d12b0ac37e28..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
+++ /dev/null
@@ -1,41 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8510.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8510 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8510
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            compatible = "wlf,wm8510";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
deleted file mode 100644
index decc395bb8739..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8523.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8523 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8523
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8523";
-            reg = <0x1a>;
-        };
-    };        
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
deleted file mode 100644
index 2f27852cdc200..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
+++ /dev/null
@@ -1,42 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8580.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8580 and WM8581 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    enum:
-      - wlf,wm8580
-      - wlf,wm8581
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8580";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
deleted file mode 100644
index ecaac2818b446..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8711.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8711 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8711
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8711";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
deleted file mode 100644
index fc89475a051e8..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8728.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8728 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8728
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8728";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
deleted file mode 100644
index 12d8765726d8f..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8737.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8737 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8737
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8737";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8750.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
deleted file mode 100644
index 96859e38315b1..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
+++ /dev/null
@@ -1,42 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8750.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8750 and WM8987 audio CODECs
-
-description: |
-  These devices support both I2C and SPI (configured with pin strapping
-  on the board).
-
-maintainers:
-  - Mark Brown <broonie@kernel.org>
-
-properties:
-  compatible:
-    enum:
-      - wlf,wm8750
-      - wlf,wm8987
-
-  reg:
-    description:
-      The I2C address of the device for I2C, the chip select number for SPI
-    maxItems: 1
-
-additionalProperties: false
-
-required:
-  - reg
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            compatible = "wlf,wm8750";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
deleted file mode 100644
index 9eebe7d7f0b7d..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
+++ /dev/null
@@ -1,62 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8753.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8753 audio CODEC
-
-description: |
-  Pins on the device (for linking into audio routes):
-      * LOUT1
-      * LOUT2
-      * ROUT1
-      * ROUT2
-      * MONO1
-      * MONO2
-      * OUT3
-      * OUT4
-      * LINE1
-      * LINE2
-      * RXP
-      * RXN
-      * ACIN
-      * ACOP
-      * MIC1N
-      * MIC1
-      * MIC2N
-      * MIC2
-      * Mic Bias
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8753
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        codec@1a {
-            compatible = "wlf,wm8753";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
deleted file mode 100644
index 7bbc96ee81be3..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
+++ /dev/null
@@ -1,41 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8776.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8776 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8776
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            compatible = "wlf,wm8776";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8961.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8961.yaml
deleted file mode 100644
index f580785455693..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8961.yaml
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8961.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Wolfson WM8961 Ultra-Low Power Stereo CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8961
-
-  reg:
-    maxItems: 1
-
-  '#sound-dai-cells':
-    const: 0
-
-required:
-  - compatible
-  - reg
-  - '#sound-dai-cells'
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          wm8961: codec@4a {
-                  compatible = "wlf,wm8961";
-                  reg = <0x4a>;
-                  #sound-dai-cells = <0>;
-          };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
deleted file mode 100644
index d27300207c67e..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
+++ /dev/null
@@ -1,41 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/wlf,wm8974.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: WM8974 audio CODEC
-
-maintainers:
-  - patches@opensource.cirrus.com
-
-allOf:
-  - $ref: dai-common.yaml#
-
-properties:
-  compatible:
-    const: wlf,wm8974
-
-  reg:
-    maxItems: 1
-
-  "#sound-dai-cells":
-    const: 0
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        codec@1a {
-            compatible = "wlf,wm8974";
-            reg = <0x1a>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/sound/wm8770.txt b/Documentation/devicetree/bindings/sound/wm8770.txt
deleted file mode 100644
index cac762a1105de..0000000000000
--- a/Documentation/devicetree/bindings/sound/wm8770.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-WM8770 audio CODEC
-
-This device supports SPI.
-
-Required properties:
-
-  - compatible : "wlf,wm8770"
-
-  - reg : the chip select number.
-
-Example:
-
-wm8770: codec@1 {
-	compatible = "wlf,wm8770";
-	reg = <1>;
-};
-- 
2.34.1


