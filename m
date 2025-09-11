Return-Path: <linux-kernel+bounces-811910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06851B52FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BB8A839A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A630BF73;
	Thu, 11 Sep 2025 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fO5xht1K"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3951C3C11;
	Thu, 11 Sep 2025 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589342; cv=fail; b=F9Yz/8OdOTJ/RRH/bX9pvGf+sPNq52AxbxiVRSoQICgDA4Ysfm3w8WMA2OmhtgCSQGzeJEBDMhiKraOVuT/JQVrjvQSS27I2ccAAtrOmnzzLFom6Bzw8Qn5ATKmchlUfVN0FqON0Q3QfmmJPQiBGaFyK6AUVBvcalj4dN2Hb5cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589342; c=relaxed/simple;
	bh=Nk7BQDHZpo96/sDDMAAW9JNBhvRxgKvX+D1uioBvbSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uresy7sTn7TFjrMtTXuEjIS3IznygM84kH8C4Y5Uc54jmxpzX4aPgB57GvoNwxhufa0+vyL3aZji3cXQnqCngIMUVVcDzBTTTbnJEZuj+J1d1Q3O0JCiCceEbghEH6avJ11zMQd+rzEtgkIxm/bOFShaqH3F0DTTlLDTO0H3nD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fO5xht1K; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSjVOjGkAMAbvp3FF5kPsYMQNFZgOtLe/stZebmOy81qfmSvKEIEsMdX0cZQGw1q7DxeUYvv3v8/dzREPu/KfDeQkUePoLqJ1pCebKrPfroysOP5HpBZgbxne1x0RHm/Adq7WU2T4mAGSS6+zQyLEvBUHJoHSUU1/sYH1EoNXibn6Y/v0kcos9J0oh2GQjsqvLb5AEIU25W/LX75rq/WXudIBRP+nHFBgtkrgfEpBllJN8RxVc2FSDRYwidlT4oZNpJjPUlyqNXXZH3FkZGHufydpUd3pOcY90iZcAEA/JgSxhb0nqqf+7Vwnn8Gb01mSY1BYi6heqfV++Q4pGeL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk7BQDHZpo96/sDDMAAW9JNBhvRxgKvX+D1uioBvbSg=;
 b=Yx9S3/0ej0GA+XU8icpGgsvjUg1r1Wo247G4nFRNobQOIubz/N9oYbh0z5Da6EuWGBamFitopk2TdTwrluBTI+gdPM/J6Q8mcl2rA9sD52R4Z41LNRcUQQu6ZJp8qqlRt+lwaIdgpnNp4oc6/9qMlUGOCoF5hA2h99aig8aEckJ5fj3dw4lm5DoJnzX4yGz5cfJWsL/9iPcGB3k3EaSBRw9E6K3EjZtOSqozDtHAYtNU/hZ6c0UgEz93xscyjbW/ov8YJ0sY1gNm5a6M8SVVCFGmkVyVIMdzdezTEcsG3r2o5/mlQaUjr9XAKNQSMYRg9MqctE8r/SLuOo8ehcf/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk7BQDHZpo96/sDDMAAW9JNBhvRxgKvX+D1uioBvbSg=;
 b=fO5xht1KzIWAFQfvueDchH1kljh4ZKbVQitHybBLY++zy313AenW80kurNsXD2lVc8ieIQnZc33nXkTeQttPVNJZqRlqaenkY1XYPIl6S0WAeh9IauxvvShbqatzbe/bx7lccfAcBZsZLYH30nM/s16b9rKEREjKWZaMmB/S0kbrf4Me6LiAb+KVSRAbOuqjo/g2Z1JTuLgFnKyKIf5eae1FP4soRsDuJ1vWW402TotwLhYwuXkMT0AbOw4Xmzpw5AjUob5/64LJP25kDmnqN1s5KNeWijcLbCdFRoq7oJkbtaV7f0fYS0cBMWaS3PXbdipjZQFYdIfUiEDpvvPD9A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10349.eurprd04.prod.outlook.com (2603:10a6:150:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Thu, 11 Sep
 2025 11:15:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 11:15:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Cristian Marussi <cristian.marussi@arm.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Thread-Topic: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Thread-Index: AQHcHYiHR2DPVilmpU2z96PMF4sNSLSJJYwAgAAL0FCAARCNgIAAUsWAgANJ/FA=
Date: Thu, 11 Sep 2025 11:15:37 +0000
Message-ID:
 <PAXPR04MB8459B7B9A42DB387368629608809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
 <20250904-sm-misc-api-v1-v4-5-0bf10eaabdf1@nxp.com>
 <20250908-sparkling-owl-of-judgment-f17eeb@sudeepholla>
 <PAXPR04MB845929E7106141E785A32387880CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250909040159.GC20475@nxa18884-linux.ap.freescale.net>
 <20250909-excellent-unbiased-seriema-8d619f@sudeepholla>
In-Reply-To: <20250909-excellent-unbiased-seriema-8d619f@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10349:EE_
x-ms-office365-filtering-correlation-id: 31a9ec06-d128-46fa-0e4c-08ddf12488d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cGg0dWLJXH/lB+Rb6Q/AB7V7nLVjEDFbzadmH6idVLz+ekryQWtm2+cjb9oO?=
 =?us-ascii?Q?VVdKqvjPtwo64k/Wee939PFTxELJ2WpJLIiX3vOwbu3xZtrrWGlMEJ+4w8NQ?=
 =?us-ascii?Q?fipdGJgDjyiL9K0BUHoL/ouXUlkI1UvKZdYWhZHQttwHFgNymAdxAow+6xcy?=
 =?us-ascii?Q?hpVgfJrIgwA9a8mMb5hiYT4SY1lyRAhf8tNHMqqrOQLTwPMupsZqr1zgqsif?=
 =?us-ascii?Q?c1VnA4kPTo0HxAwyTwvInHQgz4N2ieU49nQbDAmmT4FOrWxTiLNOqiMMkl6F?=
 =?us-ascii?Q?wfC6CtlGsB3Pt8fGyiDdKQVE0gkxrJu5eYyx/4fVx4EqcxPhD9ZS6UQFBSzs?=
 =?us-ascii?Q?xRkVNBnF0hfTiVTOvT8aBp5W5CkJ/mkAI/eBNXqn6qEQafJ+k1KMPa0pJIhn?=
 =?us-ascii?Q?Ve1Wm76j0YwvAUiIFh25KbA9Bf6RtMgOiXLO0avkD55vOvDxR9WSm17sxYKu?=
 =?us-ascii?Q?wckRopLW+sJyQJ8kWxf+JL9m5Ykr67vKCmc9bnv+NGv2vwidTQxzKQ/GD29k?=
 =?us-ascii?Q?tKogxdQUKrUlypprNBn6xlTAOQG/K0G9i1Xs/fSXePxuPjEHRvonZ+2Fp9ZZ?=
 =?us-ascii?Q?BG+kXH+Ni74gWRMLTh53NtdT85ZeEhUmV1l0WdL/Io1BmcBuxJFhlYmKArPj?=
 =?us-ascii?Q?8HTvAb9fdLfyTZH5DYH+S7xfj8CFiPIWP9wzKegJc4V32a0g8rjhttE7RgYH?=
 =?us-ascii?Q?TyKH2klkDd9Fhg3wtnjaVAQ+wKijhcINSTCa2c9s9AvZhUQ/KoVi5CVUtyTj?=
 =?us-ascii?Q?bFYbo1lCE0/rrcTKCvoUpTkqyJA1eW9wVMPjV7+82kxYOblcdFKkqqxlv1gs?=
 =?us-ascii?Q?jDQifMuwBG2KfSmT76wQITUZLV4hrBWeoubW6n8Ztmug8zROkLgGBxK5hj14?=
 =?us-ascii?Q?uUjr9Ik8L0l5UkIoaLrvRAA0WBlCGT9qoO/bUun7YDSMVTsvQAeruHQT5oGr?=
 =?us-ascii?Q?/D/L0synbSwMb9BXvBGhGHP7HbSveqih5mCtejWFFkFBVh/vG4daRHg+uF1g?=
 =?us-ascii?Q?0VErAlkZUqlKDj/Cpg2VY7of8mpkMKjKKYuvB6bTQCM5YZTY2Q0cEIHODvzV?=
 =?us-ascii?Q?pY8mjx08bHYQg6CF8RdHi+I+XJhgN/zob2dNL1qSjx+BngyOJsv6bDK8Gh7k?=
 =?us-ascii?Q?XrAShV06b+xknSAZgD2RHwhYnE82B9tamvFaOV8+BMg2yp3CvN/MdFoVh5E0?=
 =?us-ascii?Q?XAr8okHvBh8wIp2I9IlRJ5ASUF/vYeU9udyV71nVR5faVJh1121fl+T3iPBN?=
 =?us-ascii?Q?HFicyMN4NjyNxcSlTDx8vl0/W+O8lBtPqCPZ6AKMlcwmfJbhsw0m9B/bB8Pc?=
 =?us-ascii?Q?wsdIaZmb16JIsCIJA/CGeJRSzMi3hEklDucRqSzLFuuLC6tkvdZaTqvTjVXR?=
 =?us-ascii?Q?xvtmMlzN2VaWy4aIgq5nc0vf8EqyjdJZo7YZpvoHxRpEy4Y3D+iySo9wGPNF?=
 =?us-ascii?Q?wvr5sCfxyLo5tmku1ugYRc12sAXsVyjgcNyFGmoRWKrFWRbiT9XEUfl4XXG5?=
 =?us-ascii?Q?Kr9hC8yGo+CTP+A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zD6YhV2mCDM+fLwQHL2959mjbb4U5u51BiR4F19QsfnzlB83eJqQGvRqBANm?=
 =?us-ascii?Q?jEDovUhy1q0jz2H5zOZGvR1ujEhbim1iQ4DLXW2BerWEcHd5WSnclxKAP4rz?=
 =?us-ascii?Q?hfG/no7p/4TRQNsh4Spk4I4gDtCPx1ero+u+ixsZvx57ANDAjg1UzjqDn1cY?=
 =?us-ascii?Q?/70tWxLcQvvqUQHdhofib2RADz87KJvNtQ6E1CGYecykjdsw5i/JqDE15GS8?=
 =?us-ascii?Q?fn9lbjJa218ZLJphVvOWXaYnps9vqZWV0YiCzElhslX+P3BeBjDMXyOia/ZR?=
 =?us-ascii?Q?f7ONY+Je346U4OGNv7OJ7L2Rhf/TKz3p+1Iv6kiCOcwxFV94+JKm86WcGUDo?=
 =?us-ascii?Q?Uoq+zMCvk/8aOpjW1cWPOr//jH5aSv3S2TdsJRlAbn2k+wZdCccyasLAiQRC?=
 =?us-ascii?Q?KJCVvD0nOQ2+VmnlTY5tDG1NRwAF6Reapjv084NM4KW3cc1IenPupA2d29yL?=
 =?us-ascii?Q?Gxt2ZCyaCl7JCQP2w2BdXUdJTtt/WpnZ1A7C1kbQwHH8cxELFMssFGQgntPV?=
 =?us-ascii?Q?QM4SBu9Va5F75Z4T5Kr/V4v/4f6Jv6lCP9rexiXJgxMSJ/pPc3S9/kTnW2Ef?=
 =?us-ascii?Q?Ty4ph6oCqxCD57PUfxphmUZy4h3UM8bQSn/xP4as+STHepgmyzsAVTyON/Cw?=
 =?us-ascii?Q?BsebefESOi+6og4nBxqMKjM6UE6Hov+y5ACTvdIm65I/uaaZwgNmPUUsK1j8?=
 =?us-ascii?Q?iah0iJKlFwJ92QI0alqyIoLWFfgtQzHa+nLtWTH9HjeHOPbiLcXH9rgPh8Io?=
 =?us-ascii?Q?MP631uPF/uI3AKPmD7EnQrOOLBjNk8tuIkEaLNNw1xHsEOKtShbaYhbiVY57?=
 =?us-ascii?Q?lyfG9Fo8Y05iNFoONjyaR15k11dR3v5VYyf45aUJ32cRc9GE+hM6b9RGqiEe?=
 =?us-ascii?Q?+aHyoyRgN9AyvnKQrfWNOafOWQseRGFkofxWNaDLZ4Iq+TuCbRIMAxO7COvc?=
 =?us-ascii?Q?2SIp97fW0Hn9MY2QX+FWiBJdg3F88z7tFTmSdiw8LXULcRxFQ7Z+F3/pSruf?=
 =?us-ascii?Q?19I3ZZNa7ZL8iNFJRq00Md6xRwF628SiKmF2GRdWocp/+RxtI1I6sBnAVRJe?=
 =?us-ascii?Q?8YKaJKjebI9YK06F6ymCvIR8XIGU2lAAdIjxFqQLnHSYz/vqNC24n8/i9ySD?=
 =?us-ascii?Q?pl2avDaZfgVNqDwR6U4rtA1bMK+cDf8mCZGVcHXFNGv2/mzguQvVFbMPLMI5?=
 =?us-ascii?Q?HXV2SJt9m35twQZ2jE3Ntlc1/aVPjFoixbyIq9ZbmYVGleAg7Vm8mL2Kx5e+?=
 =?us-ascii?Q?SOk3zoUx2Ap7ghOR7xBun1V0NJlFiNMjUa3xCgaq5ahECiF4Ivw3Ns1OO9zB?=
 =?us-ascii?Q?rypzHHZEDjJpx+UXSDwfkJ4b3euL+yLuf58e0eSMrvAHvVUTSrrc6xmA9KEJ?=
 =?us-ascii?Q?vrTzi/UpXBmJXNWb/KPFGmO7uw43mKxpvisgg1e7XNNo80aapK+KraIup7eE?=
 =?us-ascii?Q?hN5EVznrxpqRjXkegTakzb39LliQ++rRrk/TM+7CyxEmsgLKw8am36dVh4o0?=
 =?us-ascii?Q?8m1OOX4FF7KQZMxhMXzJqgynaRftEAHOzxBrcLq4fQAA3KpnTL2E30/DZzRM?=
 =?us-ascii?Q?bUIq/s9mO9jyTx6x7+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a9ec06-d128-46fa-0e4c-08ddf12488d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 11:15:37.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoWvAynKzVbPjjr2bLn3wmuW53pvOUFb85WbKrd/PqWZirP5RmwmF6OvjwcE0oBtihs2vptMeNzSkFcgy5uXlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10349

Hi Sudeep,

> Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting
> syslog of MISC protocol
>=20
> >
> > I checked with firmware owner, this should be using raw dump.
> > The layout would be changed for new platforms.
> >
> > Since this is raw dump, I think debugfs might be preferred.
> >
>=20
> It can be sysfs, but it can be just one single 4K dump, no more details
> from the kernel than just raw bytes.

Thanks for approving the use of sysfs. However, I've already developed
a patchset based on debugfs, and following a recent internal discussion,
the consensus is to keep this functionality for debugging purposes.
Given that, I'm inclined to continue using debugfs unless there are
any objections.

Thanks,
Peng

>=20
> --
> Regards,
> Sudeep

