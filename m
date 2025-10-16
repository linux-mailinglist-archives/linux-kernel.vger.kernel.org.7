Return-Path: <linux-kernel+bounces-855555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FAFBE19F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F01B4E8520
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECCE255E34;
	Thu, 16 Oct 2025 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mHTvAra/"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013061.outbound.protection.outlook.com [52.101.83.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4A22B8AB;
	Thu, 16 Oct 2025 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594431; cv=fail; b=k9Bf8OE/KneLB8Zt2+kVzHRADJ1nyVQxXkWDGNpoo3RW1uVE+cXi/8fP/eUzF+yt0oPo7xWBjzst88JwQeQ8ei3RKeEphhAkX695tiQEG3sU97CeZbok5O+0hijNBFo01Z1LN9Ls48B+3ffMgc+ZzN3WpRjyyBujq5ewxr7pHzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594431; c=relaxed/simple;
	bh=uycj+MMWKyh5XjCBan0nxoE+t2K9l0AsAg3/h3yqQPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nz7mStvjd8PT8DfnTDd9ul63Ov/XXISBM6aetnZ0zfdAwbZef8+bwwixAHRiuI+lGXy1UjEx89adpUpb6wwSKMYrbexnWupnDUiyb7Dl26gwQxKrFBcMeSOtW7x6udX4TXJXOMXMS8b1YynSbhTRZ1HjUt+18qxbEtjxnG6o8/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mHTvAra/; arc=fail smtp.client-ip=52.101.83.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYsXnuq+Z80zuMnvmp4iq2NTkOvfIEwR9xz5QP7Y5wBPhY1hnFLCd+j6QlmqDtTHR1SVxdIkz2oY1hP991FAvxnvgU5L8247oW6lPGUstWYh50vbRqkp8na6+0ok+U67nRD3aaPnweH6TgBGXf/nOzzvs8MTxI+CRywsSBO/oQi2IvR+YuekkOr9CQULqfaEl43zo/xBfCYWkZFzimAo+GRC1JOBL3ZA6jU8zmjJrYJp5X41oOUAgAbLAYwnGJzsUqKp+i5a+/Cig1N7+5/krzUYZHFYwHSs6U6gxow39Gb3K6sVc+6RPebNrEGnYo2ST4JJ2VQByNbyPlPBCoBsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uycj+MMWKyh5XjCBan0nxoE+t2K9l0AsAg3/h3yqQPw=;
 b=gqQhIKcoVl8gv5xyNAAIjWYpqOW1rtkoU/ycgtJR8YoTDnsrVRBkhM/mMUXKfjYMZ3PlPILlMcQg9ar8w94TeozS8f0BbpqELLbb1XRdUCsKow4sIMDw0lZEZ0+N5UE21PyruGAoxGehs7m/otoVzHhwpykr5LAF73nDodCIrNibKjZBeGOcKFy9zzD13dY08BLtMJ4O7X5v9lNueHo4U8MCq7+X7pCip72HWEjaYhuZvZilWeZqCWDwImfHP2lp24tSCUxYoJFJyBOosUtmgSPo3Or4Eo8Lm0urtdKpfNu3EFq3O53UZg2n6IQbxj5IsojIne4tZg2icG9Ov2ZRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uycj+MMWKyh5XjCBan0nxoE+t2K9l0AsAg3/h3yqQPw=;
 b=mHTvAra/TfdMtOwXj2Btx6svAY63JBv5o0p2Nbvrs8tvcQPuvru1wV6sNryWzjy2EOZE8aMfIqOnTGtLlJt0tWnKDbQ6oLGREFK5VYf/42PJ49GKHbGsltRh6sKtAWZwuTS6zPB0d0jdU0xNHfnKbhWY4JuAW+VlDeE4DOT5RhxKtTaqg5p9RcewoXnTR3XGT840eAQEA4u/mm1CDj016Xxqud0WetM7HnvgdDmhldM8kdeiPnxuFk1DKRjGQMCIoh5uwVVW6TXN/jFsuG6nAvyl9Rc2b10nj4E5DHAZWxpsPBHsCUMLBC+cAtjjUyIu4Yi5kuPGa+tdx9CFlq9Xvw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS5PR04MB11346.eurprd04.prod.outlook.com (2603:10a6:20b:6c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 06:00:25 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 06:00:25 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Michael Walle
	<michael@walle.cc>, Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v3] arm64: dts: correct the flexspi compatible string to
 match with yaml
Thread-Topic: [PATCH v3] arm64: dts: correct the flexspi compatible string to
 match with yaml
Thread-Index: AQHcKUwjbc21PPrSfESg6LmaAOEMFLTEcaCQ
Date: Thu, 16 Oct 2025 06:00:25 +0000
Message-ID:
 <DU0PR04MB9496B69270A50704DE8374B990E9A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250919-flexspi-dts-v3-1-44d43801eae7@nxp.com>
In-Reply-To: <20250919-flexspi-dts-v3-1-44d43801eae7@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS5PR04MB11346:EE_
x-ms-office365-filtering-correlation-id: cf52bf1c-173d-4133-fa6f-08de0c794ce7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mkx1cUpwOUxrUHFobzcxT0NDNnBOR2ltSi9Md2NVZnpLaGE2dDQ4V1NWd2hB?=
 =?utf-8?B?T0ZoV1hDV2d3M1IvWkdnR3R3WUc0ZVY0eXpTRHptMlI3Y2RhbnRFVGt5Z0VS?=
 =?utf-8?B?WUxZSEdsNDZvNmlldzBKU0trYjQwS3RwSVZic01wZ3VNNXg2aCt2Q2xWL2sy?=
 =?utf-8?B?anZqdGk2OHNLZFhWQm5maVBGNzRqRDhraW82blUyeENIbUMvRml2cnEvYmV0?=
 =?utf-8?B?YzYvcjBDUVlWaDlvRUxKYVdiM3U3U1hUVE1NWHFudTk5S1RtemFrOGNkSGFH?=
 =?utf-8?B?dkZPTlc5WUJRcUl2UzZVRFpzY1BZQWs5aEh4L3RqL09GaE5RY2VXUitBVmFL?=
 =?utf-8?B?S1d6cVJIU3gvUCtzdXc1dmU5cmFzSnE3cUN0ZFc5Y3VMU1E3L3lBOTI0MmN3?=
 =?utf-8?B?cFIxRDhsemJUb01zVjFiR1pSSG9Oc1laWm9xdlRRUTU4UE82b2txUlFQSVk3?=
 =?utf-8?B?SDBpSjBCcDZxaHF2NTlyaEdVMzRnOEJvZlRoNUVFVlcrMUxVcnRqSmxCdkFS?=
 =?utf-8?B?a1RGVEhWNkpWZEVLc2NObjRjcnF0aEI4Z0swaGJ2OTZxRVpzbVNSbGJ1U1By?=
 =?utf-8?B?d0FpbFI0UG5WVmpsRjZNTlpBZzAxMHJJcHVtYzZndytyYkMxTUV5b2dDR3BQ?=
 =?utf-8?B?SzhGSVEyL2V1czdUOW5lWEVSWDI4ZGRqSDQyamJuM0VIcG5OVkdJaWhuTVp5?=
 =?utf-8?B?YnEvOFV3enV3WGhROS9WYm0vdXhZdGJJc0RsQXAvQlFKNG9jN1F2aXhLTWd3?=
 =?utf-8?B?S0k4eXV4SmI0c1pra2ZnUSszYitJUzV3MnorYkkrMFNqdlkwdHF3UkoxTlhS?=
 =?utf-8?B?VitSNGMwemd6TnI0NEcrZDg3czJnUVJzVkdmSGJtcFkxK2lnZGJXVUltNmFI?=
 =?utf-8?B?Q29ZU0VrWjhXZHRWZDFDY05Zd1VpRy9rSnBjR21Dczd5Q2pJcEwrdFFiRmI1?=
 =?utf-8?B?TElCUlorUzJGc0JySG16TDhBdzNFUXVucXlmWXRubUdrZ0NsR2RSOFNLSWJR?=
 =?utf-8?B?SmRSRC9vR2N5aUFVNCs2Q1NWVFVxc1p1STBsNzR0QVhTNWFQWWt0TERHa2Mv?=
 =?utf-8?B?N0gyN1VKWExUWlJFa3FLMldycVZLWHdXdUV4U0grWUNmSE1ITkZQaVdBRFhK?=
 =?utf-8?B?aGt1TG5tN3hPeC9RM2dza3Jnekt6aWRSSkdxakpqdTRkRWZnc3ZhcjFOT0VD?=
 =?utf-8?B?anIwZTV6SkU1SnBlY3ZxanVWWXZ6cmZIZlYrUllsRU9vYk5VbG1aMjkvOEE2?=
 =?utf-8?B?c2JHTkFHaWhZYWVUZERXZ3BWWXV0TDNDdy85bG8zR0s1dHZUcGx0ZHhZclZl?=
 =?utf-8?B?Z3pMSnliemtHMU5ySm1BbTFMNzY2RzFZRjE5eVVjZ0xTa2l5TWpvMkxmanlH?=
 =?utf-8?B?aHFKcUpUanZYaFp4QjZtM2Nta3NLYTR1M2IzTmJMdm1qc2ZpdnFwcklwdUdJ?=
 =?utf-8?B?SEZ1WUJIVjE1RkFwNlJnNlludndrTFVic2hTYjRYcmVZWUlWdlBuRWsyMTcz?=
 =?utf-8?B?dEZyL1JQNXV6WGhzNnAyNnlzV0xmblM5eTBreVVrMUx0NTZlczZFRDdUVURN?=
 =?utf-8?B?RldVU1JrNjRuMUFGbzBkQVlvVGZtZXd1WEF2bldvUTB3WkJtV1QzbWxMVVJJ?=
 =?utf-8?B?TjBmNWs1WTZ3dnQrME1hMnVjOWJKTlBXTnEwbTYrRnNpRkVsSFR0ak80Um5q?=
 =?utf-8?B?S1hGTXJ2d0xrUFFzbnRnZ0crdlc0amxINko5RVNWV3NCQlZGRUtLN0JCcURI?=
 =?utf-8?B?dlpPbjROc2d0ekZQRXVkWElyWmlqaTlBL3RpQjE0R3EwTkZTU0xHbXhiazRn?=
 =?utf-8?B?NHNIUUFpcUVwS3VRVS8rbXRyQXBYOTRIaGxRUjFlVEQ4dHdFMTl4MnovNVZD?=
 =?utf-8?B?QVNsSkFsb1htL0RoaXBaRzk0dUw5WkNDcnRnSHJaSngzZTdpUjlKNVVzQk55?=
 =?utf-8?B?ckx2Ty9MYVFaamN1bVo3dlZWZHQwTStDYWhVVDk5TXJJcEY1K3p1d3V5S0lN?=
 =?utf-8?B?NnVYbFdNM2loaHByNnZSRlNnekorZXplcmNXR2M2K0c5RlZWeHJpUjRTM3Ir?=
 =?utf-8?B?M28rOG9ENEcwNDVjTExBQmxXTUdLaURIUFh5dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2tITzF4eDBucm5EeVkvNzJyNlVER3d6U2pCUlV4OVpMRkhSVm1mcjFqMm1p?=
 =?utf-8?B?MlIvd0VacTJXTFFSUUJNWUFWRThBRmFTb2JuRFpLd0YzcHJNZThEQm40ZXR2?=
 =?utf-8?B?aHJ2M0t1YXR4eW55L1BzczhYRGtjZmRjdUdLVkN5aUo1MllML0tBR2l3eUpq?=
 =?utf-8?B?YytDeU9mUEF5YmtzZ1B3S2ZmL2MvUHBoTmtzTWZKakxKMkRwMXA2WFhrUlBH?=
 =?utf-8?B?ZndJbjl6L2pIVkVjbENhMjZWdEFHYXltRDBmM1NLU2EvWG1aSDVrWDR5bFNx?=
 =?utf-8?B?cm4xcENNNmxlbjlFYUJKRE44RXFaUkF6dDlPZWhOQjVSRXBRRTZxYkZvYkhT?=
 =?utf-8?B?VDRiZysyc01xcVZqVXJNaHpWaVRVZlpPUW9FK01XcWRGU2IybXF5dThvVTND?=
 =?utf-8?B?WG13U1I3VFZ0MU1aamZxWGR3U1NjQ0VMV3dLcEdQUzE4bXJDMnl5SkFkTGZ5?=
 =?utf-8?B?Z3grNFVlblJUS1Y3Z3lZK041QjdFTjlsakF3Y0FGNHg5TDBGRUlyZ3JkRXZk?=
 =?utf-8?B?dEY2M2EzS1ZtcC9PVlhtS3BwSy9USkFhNzIzWWtDdTh4MHFoWVJnYU45cVVj?=
 =?utf-8?B?ZnhWVUtQYjFSUGVrNTQya1FlalhSbVJmZlJ1TWVoa2x4TjB5ZmV3cDZXdFE1?=
 =?utf-8?B?VkRzWmMvOFVCRE1LdHUrUHh1OXRwY2RMZmpsNldGckRlKzB1bVdTa2xycUdN?=
 =?utf-8?B?U2dsd2crVERlRXlPZkFxUUdIRkQyajFmSFZYVW14Q0ZrUGdiRVNxYkdIZWpN?=
 =?utf-8?B?bWhGcmVabFdVV3BpQTRKOFV3eVd3TUpTbHBUMUdxM2p3cEtYSFFsaUJ5ZmZh?=
 =?utf-8?B?TUJ4WXNSeFhHS2dEQ3E0Y21uRjBocEhqSVFUYXdrb1F4eWIxMDQyTy9xUFVr?=
 =?utf-8?B?c1VIS1BHaWloUXdKRVBSVm5obnlnL1BSSEhlSm15clRhQWlHcEJIdStLTmJm?=
 =?utf-8?B?amRXSCt3Ym4vWm84eHFGcDJZNlhjM2lFM25GWEhXQmNnS21OblFaUndSZi9F?=
 =?utf-8?B?cElzeTUybEJOVUZoWTM2TDBxMlA2MXNOeFV0bkRuemV4ZkttVm5SaFdsOTZs?=
 =?utf-8?B?b0RjY2U4TnlyTW04RnVqdlBUVFRYa2htdGRQR1F5UXhKMlg0dHhuTXRmdjF1?=
 =?utf-8?B?ZWY0QStvU1pwbVhHbkR1S3daRk1KWUtnb2xjdW5xb051U051UTVXVVVsbzhI?=
 =?utf-8?B?Qk53NzREYWxKS0hmRTRQbVFtd05pZC9KeDREeWh5OC9XUjBaQ3hHMmFnNWg4?=
 =?utf-8?B?N0VsbXd3MWErbUgvak1ROExWUzNKaFNnd2lMK2p2b3ZnY0RDUGNhaDN4cVVI?=
 =?utf-8?B?ZTk4SU40MFUyMDBwM20zN1RBaWVPbHlNano2NWkxUjNGVFQ5cGtJRDBTWElW?=
 =?utf-8?B?Wmx6RTUrbjRQK3dUN3I2ZXY2Z0ZTY016S0VBYmdCNTcrY1RvQzVpaFozR2R4?=
 =?utf-8?B?NE1ZNHdwTmFnWXE2Zy9lK202WmlJdnU4WmQ3cm5ZcUxmS3ZFa2lTUGY2ek15?=
 =?utf-8?B?N2NDVHRQT3p4NDF0UCsyNjFqeS90bytkV3VrVEcybGR5aTRVeitaa21nYnJv?=
 =?utf-8?B?RzJhL1hWbSthOVlEVGFRSitSQ3lYL2RSd2VNVXpPbkxUcmY1L2xTQmpUWitq?=
 =?utf-8?B?a1E0NzhYS1BGcDdNNzdldW93MGFvUGNDUDhMbFJybDhqZ1lqQjVBTDAxTTNr?=
 =?utf-8?B?YXVCZ2t3MjltMkFJQ2hpcmlBbTZDN3dqUjZISC9WYWpMU2pndWZneDZJOXFI?=
 =?utf-8?B?bVQwT3RoVGFpdE0zcEY4bE9uUVVJYkd5NGVkd3QzYTdkTVlRSzVzSWJHcDd3?=
 =?utf-8?B?TFhET3psblVzRVFjNStYeUZWdFVlT1pRQUYyKzBLNzE0MTdFWVZMcXBqR0pl?=
 =?utf-8?B?VzljRHVJOHpUMnhabzJsRHZuMUFUV2Z3eVdJZmt2RHI4QTlCWm5sTTRjTFBM?=
 =?utf-8?B?VmRzelV2MCthMWhCVmhjTi9YSzhvbWs4YlVvVFh5T05sdVhyQnFsbStLV29N?=
 =?utf-8?B?WkVUMStRc3hVdWh1L1hRUFpSKy9LVzJGVEkzNzNoKy85MzJrQkowbldYN3FU?=
 =?utf-8?B?Tm11VU1SMlIwdys4QnUvYkwzd2lmdUZBejdnS29TY1h6YlVMU2FPZnlrYWc0?=
 =?utf-8?Q?KpXw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf52bf1c-173d-4133-fa6f-08de0c794ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:00:25.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60BfkOvyHT8ouTi/arGMpwq9hsJJni3dBqNSrynAZPAOiyNgbYV7SgNM/IWk9rMzXt2thX0iZyNebWjTiTta7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11346

R2VudGxlIHBpbmcuLi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBC
b3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IFNlbnQ6IDIwMjXlubQ55pyIMTnml6Ug
MTg6MDANCj4gVG86IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+Ow0KPiBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtl
cm5lbC5vcmc+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Ow0KPiBTYXNjaGEgSGF1
ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29t
PjsgTWljaGFlbA0KPiBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz47IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPjsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+OyBNYXJjbyBGZWxzY2gg
PG0uZmVsc2NoQHBlbmd1dHJvbml4LmRlPjsgSGFuIFh1DQo+IDxoYW4ueHVAbnhwLmNvbT4NCj4g
Q2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPjsgQm91Z2ggQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjNdIGFybTY0OiBkdHM6IGNvcnJl
Y3QgdGhlIGZsZXhzcGkgY29tcGF0aWJsZSBzdHJpbmcgdG8gbWF0Y2gNCj4gd2l0aCB5YW1sDQo+
IA0KPiBBY2NvcmRpbmcgdG8gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9z
cGktbnhwLWZzcGkueWFtbCwNCj4gaW14OTMvaW14OTUgc2hvdWxkIHVzZSBpdCdzIG93biBjb21w
YXRpYmxlIHN0cmluZyBhbmQgZmFsbGJhY2sgY29tcGF0aWJsZSB3aXRoDQo+IGlteDhtbS4NCj4g
DQo+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiAtLS0NCj4gUEFUQ0gxIGFk
anVzdCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgdG8gYWxpZ24gd2l0aCB5YW1sDQo+IC0tLQ0KPiBD
aGFuZ2VzIGluIHYzOg0KPiAtIFBBVENIMTogYWRkIEZyYW5rJ3MgcmV2aWV3IHRhZy4NCj4gLSBE
cm9wIFBBVENIMn40LCBhY2NvcmRpbmcgdG8gUGVuZyBGYW4gYW5kIE1pY2hhZWwncyBjb21tZW50
LCBuZWVkIHRvIG1vdmUNCj4gdGhpcw0KPiAgIGxpbWl0YXRpb24gdG8gZHJpdmVyIHNpZGUuDQo+
IC0gTGluayB0byB2MjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDkxNy1mbGV4
c3BpLWR0cy12Mi0wLTdlMmE5NWUzY2Y0ZEBueHAuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIFBBVENIMTogc21hbGwgY2hhbmdlIG9mIHRoZSBjb21taXQgbG9nIGFjY29yZGluZyB0byBG
YWJpbydzIGNvbW1lbnQNCj4gLSBQQVRDSDJ+NDogZml4IHR5cGUgYW5kIHNwbGl0IGludG8gMyBw
YXRjaGVzIGFuZCBhZGQgZml4IHRhZyBhY2NvcmRpbmdseS4NCj4gLSBMaW5rIHRvIHYxOg0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwOTE2LWZsZXhzcGktZHRzLXYxLTAtNjE1Njdm
OTY5MTY1QG54cC5jb20NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg5MV85M19jb21tb24uZHRzaSB8IDIgKy0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDk1LmR0c2kgICAgICAgICAgIHwgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTFfOTNfY29tbW9uLmR0c2kNCj4gYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5MV85M19jb21tb24uZHRzaQ0KPiBpbmRleA0KPiA1MmRh
NTcxZjI2YzRlOGEyNzAzZTQ0NzZiNTU0MWZhN2FjYTUyZjEwLi43OTU4Y2VmMzUzNzY2YTQzMGRm
NWU2MjZmZg0KPiAyNDAzZGMwNWE5NzRiMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTFfOTNfY29tbW9uLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OTFfOTNfY29tbW9uLmR0c2kNCj4gQEAgLTcwNiw3ICs3MDYs
NyBAQCBmbGV4Y2FuMjogY2FuQDQyNWIwMDAwIHsNCj4gIAkJCX07DQo+IA0KPiAgCQkJZmxleHNw
aTE6IHNwaUA0MjVlMDAwMCB7DQo+IC0JCQkJY29tcGF0aWJsZSA9ICJueHAsaW14OG1tLWZzcGki
Ow0KPiArCQkJCWNvbXBhdGlibGUgPSAibnhwLGlteDkzLWZzcGkiLCAibnhwLGlteDhtbS1mc3Bp
IjsNCj4gIAkJCQlyZWcgPSA8MHg0MjVlMDAwMCAweDEwMDAwPiwgPDB4MjgwMDAwMDAgMHgxMDAw
MDAwMD47DQo+ICAJCQkJcmVnLW5hbWVzID0gImZzcGlfYmFzZSIsICJmc3BpX21tYXAiOw0KPiAg
CQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDk1LmR0c2kNCj4gaW5kZXgNCj4gMTI5MjY3N2NiZTRlYjhjNWYzZWMyODc0YTE3YWQ2
ZWZkMDExMTE5Mi4uYTBmZjcwMDJiZTlmYTA1MjliYTU3MTJkZjQNCj4gYzA1NmM1NmYwZTMyNDIg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LmR0c2kN
Cj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaQ0KPiBAQCAt
OTQ1LDcgKzk0NSw3IEBAIGZsZXhjYW4zOiBjYW5ANDI2MDAwMDAgew0KPiAgCQkJfTsNCj4gDQo+
ICAJCQlmbGV4c3BpMTogc3BpQDQyNWUwMDAwIHsNCj4gLQkJCQljb21wYXRpYmxlID0gIm54cCxp
bXg4bW0tZnNwaSI7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJueHAsaW14OTUtZnNwaSIsICJueHAs
aW14OG1tLWZzcGkiOw0KPiAgCQkJCXJlZyA9IDwweDQyNWUwMDAwIDB4MTAwMDA+LCA8MHgyODAw
MDAwMCAweDgwMDAwMDA+Ow0KPiAgCQkJCXJlZy1uYW1lcyA9ICJmc3BpX2Jhc2UiLCAiZnNwaV9t
bWFwIjsNCj4gIAkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNv
bW1pdDogYzMwNjdjMmMzODMxNmMzZWYwMTM2MzZjOTNkYWEyODVlZTZhYWEyZQ0KPiBjaGFuZ2Ut
aWQ6IDIwMjUwOTE2LWZsZXhzcGktZHRzLTI0YWY4YjZiZjQ2OA0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiAtLQ0KPiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNCg==

