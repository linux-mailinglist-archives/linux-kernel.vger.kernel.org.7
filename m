Return-Path: <linux-kernel+bounces-799381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9EB42AC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B367C2AE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74623680BA;
	Wed,  3 Sep 2025 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G1rMU1Rc"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6D371EAC;
	Wed,  3 Sep 2025 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930846; cv=fail; b=QQwbqy3aBL2Grib4ObVi35P2o4csSX7J8BuIa51XkUndU+9thIQXFTbbLgF4/dRfBhLt8Hy4MzdH7s9U8sX2knkxgss8ZnaVA0LXMKcaxMAwyjCUlICP3450QsOLpAP8494cQCRMpJLMT6zGUaJ3l7LhugIRdKNb2DZeCIEQ13A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930846; c=relaxed/simple;
	bh=as4Xbg4OXSc6QuO+JMvYi2ayqf6VP5q4Q6Tm33ccLic=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AzWVaO2hjGKBigQWDlUnGOhFaVI4TkAYWfoN4zc/CMfqSNtp+nVd1VAx8p230PbC+PWYltySh/QzvKYWLTRBtu/zwmorp9DfTL23e4E5Pb3EfkS04UYAzhyYp9xYdsC3a9zUsUtA/e6VlKpBv+4fe4HzU7zxXar4mzk89p2gjQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G1rMU1Rc; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvuLDKwpiJ1fdcwH2TXvAGKUNjHAuH25rNPzownMILE0U63JX+eTnV7fr+W1I49SngXE4/Q6qcYzCWicGLd+CHWyQLhH6WxXrRRgck6w20amolhHBW1uK+DPQZEXlmuUv7Jh6njxZUlUFJuPTVbYSU9n8EAfo9WckT2Y2T7RIESnGQcYZcxF1mOaL2J8ePU/n6NIOnqm9/MBVDU+KLI8BBXViG7pyutzGvGeBZToPa4c0xtsdDUHfaAOq+M/KqYaDlhxXfNo+i627jiniWfR8dcov77fCSyKCu8MOyGyTtO56ynLggsotON/GdPfNFRuR1BIS50gbUgD5KOSM3hfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EbwoE/Iesj2w4NFARQ8ZMpEFEdVBEKhCKsSFbWJozc=;
 b=ToNd+EMVIuAj/3W+fIXfxeS6E2NBfSND36fXhCNVDQvkhVy1OKL25BjEwu3y9RusaptUmLgw02E0s/EWZZEsUjf21kfaPXoY3bFmSYONc5HZnDf0DJAjeWjW+Ke4pUBoyu1eROou6CuX3iAW+MzNBxyk7WdLtuCkk5Y3WTO3JR4Uo2UWwI/Dip6rkOzjPej9delarNXhsXp7sBtsNxdI6nrJNKgI32lMjbanGxojoCaf1BtJWxSLO/T17bqyKXf28es2Rv7nmO8aira5lC86kSrdqx/K4yNHxzHBrOO59fKz0Ru1PjJNHDW3M+1hbaph1NpKT+hQshsABQKhtQJKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EbwoE/Iesj2w4NFARQ8ZMpEFEdVBEKhCKsSFbWJozc=;
 b=G1rMU1Rcha9cJcjL72XFbZA3LWsJAcefqU0wXAjOImuQ7FYG9cv+Y7/goFZVC0YoyULZ+frNUKJJtPKjLGcBnqNZkIaoTfqF+O7XmDz889DU+FybcxSGsctwSESjlQLJlmtYXVfhrrWSVmMEqVUn/CaCV2jB1WxRK1tm5WAIw3X/wbi7jwHjVQiPsk8z/D4ZUNIk8NAbhOEIwpexeg27hOG8BG8hH67S0mR00ZBvpiGjHqk9xj69lqk+nIXyQSKXcBSC6snEMeb9yCNbPJVIInS7VJsCnOIROjEUprh+EybMtzpFAuj2ztjESxNnT/Ma4oPCNqZ8LN8HN56mu1Upzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:05 -0400
Subject: [PATCH 12/16] ARM: dts: imx6: replace isl,isl12022 with
 isil,isl12022 for RTC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-12-1e883d72e790@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=894;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=as4Xbg4OXSc6QuO+JMvYi2ayqf6VP5q4Q6Tm33ccLic=;
 b=n6kkYpxj5qpZqxgjAkU6fH457dposW5JBAm5+Bu7vBz0XQiYUnuNhmmKEefTg4oYHVz+54sW6
 dVvmdUl41A5CJXCTDJpS+ZDipYRUvsIk8nAK8bMnpH/aPS826AaNBJf
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
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d51a97-401f-40df-7067-08ddeb275903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mmthb1hwNFlnSHBNL1QvdEUwZUhxRFl3Z0FIWXpjZmdSeFNkNld3VHowRlox?=
 =?utf-8?B?L2RXRUxSVnlhZGIwY1NZQmM0SElVRWtTNVRjb3dlOHBVck0wUHdVRldaNERs?=
 =?utf-8?B?MGtHUTlyMmdMaVpTWjg1eFJoUE13T3U1SUFHbkR6RUJpQTdSbjFzR3JKeURw?=
 =?utf-8?B?cUllWDRBd1VHSGVYWjJPWWtvUjdPVTdhQ1NSaXp0UEp5QUxFdFhrWk9wNnh5?=
 =?utf-8?B?clEyOE5oVWVnRlpvclFRS0dsZjFpMk0vWWhBOUhIci9oa3hBMjc3TlhuUThh?=
 =?utf-8?B?ZGJ5ZHpEZktCNFN0aTRGWjcvTC9KVm1CTjBkTjZIcFVDRGN2cHAwNzNDSUFm?=
 =?utf-8?B?NU45WmtXQ3JqTnlhL1lEWHNJeUxFY2htbElPcEUzTVhlbG1CQWhrWlk0UzJR?=
 =?utf-8?B?K3RWNWZmdE9hbGQ2bjNBejVmTEthNUhaR1RXa2lBc2JydlA3RkpTb3lHQzIy?=
 =?utf-8?B?c0d4R1dTd2JDK0V4QkprQjliekV0elZVS3pKTzFWR0loeXZ5OExqY3BwTWVS?=
 =?utf-8?B?SmR4T0Ywc2Q0cWQyK1ZpdEpyaFc2aGFXMlF6WThwMG84cEY3YkQ2RGFDMUJa?=
 =?utf-8?B?OG1LNzFZRHNXck80NXFHVVJzbUJxNWpsWXl0R1hzVFpwUkx2elpEZFBVRkFi?=
 =?utf-8?B?U2ovQkFyS1RKU3o3SW9kVk12d3RSV1JoMHVPbTJHbGpkcVg1V3R0b01TNlN4?=
 =?utf-8?B?amFndjZ3UlZ5SVFoNVo1MlF2eEVGWURlY00vRUFkWkJBdEQrQWh2QmRkTTRs?=
 =?utf-8?B?NE4vNStmTGp4eWFpTjBrZkhETlF0ck01bnZobG5JSlhZM3lEUGtoUUxtRE1E?=
 =?utf-8?B?bGpxREY4MElaSS91V3ZRbG9ZN2dlbHUvc2JWNis1ZUo4YlR1dlVuV292NEFL?=
 =?utf-8?B?V2x2aERPWFU5T05OY2hrNFUyVEdQMFA4VDZ2RXVreVJhNFJQMUNYanErcHph?=
 =?utf-8?B?L2tRc1pVM0dNTFlMaVExdHhad3ROS0c3aHRwMjMwUlRGTlNkd2RRcGZGNGk4?=
 =?utf-8?B?YldTNkhST0JhclRDTlFHeE9taTRyV0J0SEY4dXU2amM4UGF3Q0dJQ0dkUW5y?=
 =?utf-8?B?WDBDY21GMUx5dlRvOExTZU1hNW15T3V1Vis1S1VTTVdsMXRTSGpUdE9iZlJR?=
 =?utf-8?B?M29BcU9pQm5iV1JRYyt3aTA3NUsvWnFpWHZkM2FyV2I5eFZuWGozYlhDRy9z?=
 =?utf-8?B?T3B6UXhwMTllZ3Zabk5pOGkzcXdRaFQ2NUhnRXBOMjZrVFFhclNMZHB1RFBR?=
 =?utf-8?B?WHlzQmozak85bGVGblhuZFdxcUZjQXVnNmIySHZQN1U5bW96ZHBOcy9qQkFK?=
 =?utf-8?B?UVFLOFNZV09ab2o5dFB2L29FRkFkTkJ0dlNSYXh4c0tnaEdHMjk5S2Jha2Js?=
 =?utf-8?B?RVF5ZUUybFJoZWRweXhtTnYvZElkT0ZQNFZ0Sk5KTVB5cU9VR1RSbGhTZ25H?=
 =?utf-8?B?ZkdvblA1ZW5nakpyeHBwSDJ1VldqTkx2OEdHc3BxSWxSRG1DNVdyOThOaDdK?=
 =?utf-8?B?YXdGT2xOWVlya3JyWDRTcy9BMFhMUUlDYTRTYzFIMGg5WitHWk9FT3BQMHpU?=
 =?utf-8?B?MndObFg5TEtYSDhEWU1scmxFU3IvdmszQzdKVHY3UkQwb2lNVjN0NWFjQkhW?=
 =?utf-8?B?bmJRbVBmVXgyRVJsUkluUmxWWmZkUHNpS05uME4wUnJFSjkvalN0UG1kbUEy?=
 =?utf-8?B?di90OGpJeUlzWG9BbnNuMnhUK2Z6Q1R0R1BJakVQRE5nR0hGbmt4ZHAyWEFI?=
 =?utf-8?B?Ymx3T3pBS3hPaFBLUXV2VnhFQnJodEZFVk9IekI1SHIveWx2WGh4cnRLTmIr?=
 =?utf-8?B?aExEdE04elNRN2EzTnlJTXVhR3BtZXpoLzd4ZEkvRFpnb3luVHBDR29ra2h2?=
 =?utf-8?B?ekEwR3JCZ1k5bjhZRUcrMU55VFR5Q0pUcXRXSlZMWGx3bjQwdlh2MnZmY2Y2?=
 =?utf-8?B?V0V4Ymdad2VHb1kwcmZkQzU0QkN3WTM2K3NGSjFYaUtLVXhBb1FnUjJ6Y0o2?=
 =?utf-8?B?WnFIazZJVzlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG53YTRzN2tmaDkzVGNoRytpMmc5Nkp6RlN4ZnBXb1ZuMjNoRkZTTVJHTmdq?=
 =?utf-8?B?STV6ajMwMHFnc0RQOEZ6ZklMOTUzUUVVMkpIZERTMnJhSmxORGtWeWkvSXRn?=
 =?utf-8?B?b0ovL09TTXlwcDZmNVNzTHYvOHVnWFlsaXg4SmtlMkRHVlBDTlJKbUptemdM?=
 =?utf-8?B?MUIxYXAwdjBRTGMvb2RqK1duN1ZMY0JLcEVBRGh6aDNvY29iZFhNZUpKamNy?=
 =?utf-8?B?SmpVVU84cEs3cllZdStxQmczRGhJcTI4ZFNhSzJ5NWlZSmIvYzIzTElVRlNB?=
 =?utf-8?B?cGU3TnVCWE9Ic3RDQVpjNHRyVlNjeEtmUjNHaHZSWWJhOERid1hhdjhJejlZ?=
 =?utf-8?B?U1Ivanp4L1cwQk1oUDhGNXArWGJrZ2FWMzl0ZXpoZkZpREI2Nm5OS0xYYVdq?=
 =?utf-8?B?ZTFDN1dLK21nMjIxTVNIdTFnWHVLSWZLa2N1NFhSQVl2RzJ0TXp5MlhWU0d1?=
 =?utf-8?B?dHAxeUVrNlJKL245emQyNmdnZTdFdU10cHIvcFhzSWFVdjRzbGF1MEh4c25r?=
 =?utf-8?B?czZCRXhZT3VnalJqNjBRT2VMV3E4aGxNRThNUUFJTTBPYTFmMHQ3L1lvNWRI?=
 =?utf-8?B?eGV2bHJHQmFTenpDMERRTjZrU0hMTVdoR0lwTVE1OE5hcXIyamVaRGVDWDVE?=
 =?utf-8?B?dHVCbVR3bHUvWmZCcGg1RitDZUcxYVhnYTJidUx0ektLN1VoQktjdTdXT0RQ?=
 =?utf-8?B?OUl0YW8xVk4wOEZSTDJreWx3RFBib3krblZ1VUVBUDFxWUU5TkhrcFJoT1Vn?=
 =?utf-8?B?M3V3b1JaOU83MGpBWGtiV1JidlFqN3FMdm1peFlXM3JEY0VsUkZjcVk2cElM?=
 =?utf-8?B?d3o5bmh5TDlRUEhOQ3VuZE9BNUFLakU1NXhDV21DUEV2V0RwT0srMEtiZG5N?=
 =?utf-8?B?cVJsejZuUnNQeHNqcyt3MDg2ZzFuVW5MZ0trT1EwQWUzaXdBYmdWSXlKNHY2?=
 =?utf-8?B?WVRjVEN3ZHpWSWYxci9NN2VTSFB3S3RlemNBbitaem9Lc2Q2eGlWZStKRzMx?=
 =?utf-8?B?MHgzRDlzL3FScHdLT1BkMmdtUWt1dUVVdE1SdlA4VVVUVHBmK2QxY3Fhb1ZP?=
 =?utf-8?B?bjJSdnR1bEVGUU5Db3AraldXdGMwckJQRWthdTZBTjRnRCtBeDhOSVdpdEor?=
 =?utf-8?B?d3pXcXIxdnAxTEg2c3FSVFFKQjllQWZCQnRWNHdRb0RZNldiYUxnRFFVY1Zp?=
 =?utf-8?B?Q1hndHZCMzZHSzUrYWdWbXJ1Q2U3anUzeTNtcldRTHcvbjE5eGJKcWZDVXlU?=
 =?utf-8?B?WGZZeURvUENBUE56dTJPVmVoSmVuYnV2bUdlSFhwbWgvMUZ6VnNJQ1p2MWww?=
 =?utf-8?B?Mi9ZTGI1Zm5DRmNHVC9ZVXo2cVh1TGgrdlNVbW9TYUtvQk9mMG9PWWtGZlN1?=
 =?utf-8?B?T1BRM2gvdkJvYXhRNGlpNjRnVkpCdisyaFUwVGVoTTFZWmpWSWZ4Uk5kOWxk?=
 =?utf-8?B?NW5seno1NXAxRDN0NURwU3RYcXo5TEdXZkpYbFY1bHJIWTR6WmNIcWw1Qk9y?=
 =?utf-8?B?ZkRGTmNFMTFBdlk4WGZ6ckszVE5NdkdvZE1OSmY5NU8vT2hvN0xLT1FsQ01u?=
 =?utf-8?B?bCtqdlA1MzU0UFRpckl3R09ia2dXanNqTURWWWVTaUdMOE9ieFZYOGtHM2dS?=
 =?utf-8?B?QUVwM2V3UWFqaHZoM0VhSmR4citOc1pTclpTaUhhN0RwcTdLSExybXVVRmdE?=
 =?utf-8?B?YkMxWTdadElEbjY2YkJZYWZoZ3JTdG16TWRrL1YyMVNqMHlnRk1vTDB5L3pr?=
 =?utf-8?B?TjQ1OFZIUEZIcW9CUnBUOWNmQk9ZSlAwemRQMytpNkF3NndqNlY3a09rVGpJ?=
 =?utf-8?B?SnBvY25YRk5mNVkrK3ZoOTV0amwreHM5UktLczh1UmpDWjlpNS9DMXpoZkpK?=
 =?utf-8?B?bGRzb2NBeFp6VUxibGlMbFJTOTNvUWpTTGRQVDF0TkdXd3JLWkZZc3JIOEZM?=
 =?utf-8?B?OFVHcHBZZTl3OFRTNWNZZzV1b3hZWTl4cHlSYkFZc3hrcG4zSXEwcjRjaGd6?=
 =?utf-8?B?ZHRzZWJNcm4vZ0ZKWWk3YzRlRTRkZjB2byszWFdlZC93RnFYd3oxOHl5SGFC?=
 =?utf-8?B?VW4zdmhmL2JydEZBOWdENkU1dHRLRm5sbHZ2aWkxUmxCWlJFNGZrTkl5a0Fi?=
 =?utf-8?Q?n5Oh0CdFvd58G8bWzHPoV/6SN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d51a97-401f-40df-7067-08ddeb275903
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:38.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkHyWS6/ly/ZXvc/OWbvTbnJjsPynkhU4MCHhsStB8BpjAV+bzRuKAGr12ZrKlnW+HMFQBerzI1YwUrO753qpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890

The compatible string isl,isl12022 is typo, it should be isil,isl12022.
Fix below CHECK_DTBS warning:
arch/arm/boot/dts/nxp/imx/imx6dl-ts7970.dtb: /soc/bus@2100000/i2c@21a0000/rtc@6f: failed to match any schema with compatible: ['isl,isl12022']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi
index 11c70431feec902ef76a67d1ea02d2af5d467b68..2e8573dac39e86f408a45da3c013e67e96c02fc9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi
@@ -218,7 +218,7 @@ m41t00s: rtc@68 {
 	};
 
 	isl12022: rtc@6f {
-		compatible = "isl,isl12022";
+		compatible = "isil,isl12022";
 		reg = <0x6f>;
 	};
 

-- 
2.34.1


