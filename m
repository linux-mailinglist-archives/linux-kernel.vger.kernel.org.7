Return-Path: <linux-kernel+bounces-803083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1111FB45A57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435763BAD3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76B336CE00;
	Fri,  5 Sep 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nkhyhjF3";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nkhyhjF3"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023125.outbound.protection.outlook.com [52.101.72.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC13705BE;
	Fri,  5 Sep 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.125
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082254; cv=fail; b=cpQz68h14hMSkS9hBGS9UdXy5p2BVDD6+fNbeupd0H3S04PhxV9K5mKXIqeLZHPEg9cRSbrVGMCvmb4LhViMixWhVOqt3P/kthV+Mal0uGch3USHW4T05ILTAoYa1A3KjNL08L1F2eO6I2ATTnNe8t7c2WWguTddm3NNywb+yxY=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082254; c=relaxed/simple;
	bh=jAOz0ue59EM7lV+MnMq5fWOXpxFIdXW4gS6IVZS5boo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwH3FIcfUDgVU8avGCKfNvX75E/cDlG8pUneOT6gxOHfKsS1Bvqst92TwjiCtd1zTbWykKjtXi36CQ90KzpS6CmazA0DIPq51hmyEszm9HrVCOTjTdwTKnCAUTOiPBeylExikU6SLqG3XNVQKOfMQZhfX0pyRCG9fps0JeYenjc=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nkhyhjF3; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nkhyhjF3; arc=fail smtp.client-ip=52.101.72.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oQjKN6ckbIX1Du0eViofohpQfeTVL/7Ww0ZrAKcG3b9kWRhJvYD7Yg+W8HxCIZbRLcr3XG1tSyIrDejwGpDpqoNSUzRDyHzuuZd86Gu6tBkqHCBp4U5lTUI6RcqCcJJMfyyO2YDfaMzFDNw3DuK9Ie4+asQggIWodZFGnRKjgfBMnTLo7ZeEAxbvxxNlckZQuqVImaDq6UPvJPkpwd6YnF6JgH9q1XiH656SvOh4WBOfrBnmTus70JhW1m/boZPCd8bj6NMdmvWcFOkOmoJDl0QwGtkyM16iI7+y1qWaEUrgk2NfFcqRfe4MGHBrd/b+0ShKSTRQCGk/Ic6uhvPGJA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAOz0ue59EM7lV+MnMq5fWOXpxFIdXW4gS6IVZS5boo=;
 b=Cct6gbR12Iixgxs1Pq9Em90XaedOdqyKKApyOdTbD6VZq1+c6nNaym3VEsnt6wvuABMZl2qGk56dpl6QCeoR1D4oV2hfg5qIusU4rXhaSen1aHima6U+683PQ5mHQBV7dpCOyRG8LugE9uqnE0XSAKb40KmelO5wjRBJINxRj72J0GYX9ZQb8JoXKHXi2T8oOPzCeVtYzbH9tkdUNkV0tVWD6MUN5EcJNIzOjjX9jpL6Lxso8HoHYYXIwtrH24B4JU1FH+js5FBo2bg1lka+QdzqRy5ohRyET8n2AA11YYQgCYymJsouD1qjojiBcdhJqHZXgYrCs02DHjeq7Z0Ejg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAOz0ue59EM7lV+MnMq5fWOXpxFIdXW4gS6IVZS5boo=;
 b=nkhyhjF3Pf6vjTc/P/N7+hxo2Dx2M8ZTfaZdp298zkt3e6N2VFn/D466PFrJiqUNsq25oLsD9A7hAiLGIf9qULBal7sylJVnL5X1fz+WlmZnnMsNqAg66v1etZuEzyJOqbeTVAFGbkfMCeXkNOncvfHCxy8AEH2i6ByQf4XQ04s=
Received: from DUZPR01CA0271.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::27) by PA2PR04MB10124.eurprd04.prod.outlook.com
 (2603:10a6:102:407::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 14:24:07 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::fb) by DUZPR01CA0271.outlook.office365.com
 (2603:10a6:10:4b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 14:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Fri, 5 Sep 2025 14:24:07 +0000
Received: from emails-8922816-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-124.eu-west-1.compute.internal [10.20.6.124])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 2DCE180A10;
	Fri,  5 Sep 2025 14:24:07 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757082247; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=jAOz0ue59EM7lV+MnMq5fWOXpxFIdXW4gS6IVZS5boo=;
 b=HV1Du+mMEy2pCCWzz5WpCykDSEUKyuskvMEd2U0wPHCMlrFJuUB20JjKJep8PAEx89de6
 Rq187l47I1kHGC4jJuo9v/UP9kCajC8QLr8RGOoQh6VFnUaVVJXTp8D01abs435lXpyYaLE
 FxxFjvWt7a6aO5gqKiJ5lZ67EjqyY60=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757082247;
 b=bUQF8Uz8pISv3td8DgAw6QbW4bSG3K119ujsieqYKssKk1plEfIpCAX8u9+0QITvQxcpS
 GOhgTDCwv8Jtw07UUyikok4LdYgkLz4SfWBi7sEx/FM8Kh8i5JkowbtNWGAUclg3/u3DEBr
 6oOPbBsg/HoA2gB1ODnWayV9easnkuo=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abY0g3LIHvAwRnNzVh2qsiGFdPo1zaYtclP5fBwFPk86S7bNRCLkGXqVpr2CM3pZBPntsC4u9Ntlvfd+fWIXTKOWbcqpeLfWvxk+G12JGnneXb4W6LvjmcvCMOSzCpeTokGZq+HURvL5yH0DTC5WezadhJNTplfVVcHMHrjbpYealmWpgY8m9gjzqGAgP1bJRqfMrZAhCg2zZ/9TlshlDQ1GKz+yaOZeo2GTt+O7kMYy8kGSFrHAQS0nIGn9VZFFPykG1aYmdyMAEfBMcX2TAoemEemrznqLbuCQ7Ae4NEb1CEw0SPxksv0FpHDDRbJ1Twdor3YB2aHyeTk4TOuJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAOz0ue59EM7lV+MnMq5fWOXpxFIdXW4gS6IVZS5boo=;
 b=co/MFabQF39kpkN0meEeQMpHS5Xm6AylUmhzmZwQp0wYZWstigd+ddq+nwIYeDpmauhXzKg9abXjbCnTY3jExZ2eYN9/7OAhYOGPn+lBWEV0c+POBlyAOhVnAEw1I+jazwIIQyRsCCW57eVHzeH1AjwbjqK6UDLtf/JgLwma0kSBadrKq/j7p9TrcHuU1/cqTY9XbKt2jBafzX0DpClCExPkchfixh93MQu8NhhK1MabB0h17LlSSl/A72S277kmbSydMSZ8EiETp1nhoweRwxtgXmRV4aG9iSTsA6dZ/4zvexPr4JMae+1ktsADo4cTo0+sn2LLOHWHUF7BNjd2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAOz0ue59EM7lV+MnMq5fWOXpxFIdXW4gS6IVZS5boo=;
 b=nkhyhjF3Pf6vjTc/P/N7+hxo2Dx2M8ZTfaZdp298zkt3e6N2VFn/D466PFrJiqUNsq25oLsD9A7hAiLGIf9qULBal7sylJVnL5X1fz+WlmZnnMsNqAg66v1etZuEzyJOqbeTVAFGbkfMCeXkNOncvfHCxy8AEH2i6ByQf4XQ04s=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DU2PR04MB8519.eurprd04.prod.outlook.com (2603:10a6:10:2d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 14:23:55 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 14:23:55 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Conor Dooley <conor@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Topic: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Index: AQHcHlLIJtm9dj7MPUeeCk+9PJYwF7SEbteAgAAHkICAAC5fgA==
Date: Fri, 5 Sep 2025 14:23:55 +0000
Message-ID: <02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250904-molar-prune-4d3420b1bcb4@spud>
 <20250905104921.7grpgloevlifa3kj@skbuf>
 <8bbbf34e-ff9a-481e-a45e-26cde7d8f6bc@solid-run.com>
 <20250905113757.pmumjdnbd52jxw6o@skbuf>
In-Reply-To: <20250905113757.pmumjdnbd52jxw6o@skbuf>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|DU2PR04MB8519:EE_|DB1PEPF00039231:EE_|PA2PR04MB10124:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec1c3c0-f9ac-4d48-087b-08ddec87df9b
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YXg3TmpJTTY5cXROUTlWSG14MWxGTm9CdjY5OW1MTzB6SFo4L25lSlFPdkFw?=
 =?utf-8?B?WEVqc0c1UHIrSE45SENCNE8vYXpQc01TdkJSN3J5M2lOUUFaNzZuYmM3Y2pV?=
 =?utf-8?B?SjBZQzUrVzVQZzQweHBoN1R6b1FCZmNZMGo4QlFITTdudFBaK1g0UWpjWWFL?=
 =?utf-8?B?emcrdWFBQmNiZFArYUhVeFA4Y2xoaWJPeHg1eDhtK1I5QkJLa1lEelByRDZF?=
 =?utf-8?B?R1ZVeUlTeGI1TDVzekR1cm5zaUY4dC9tMjlBNWZvaVJ3NkMrTmdHcE1jcmR0?=
 =?utf-8?B?WTV0bjloc0VTc2VneENWakY3cmVMaGJyVTRCalFtdjhEY2hKdHhpdFRIQncx?=
 =?utf-8?B?VEVPdTVTQ3oxU3hibFF4NVBhM3IzRUpzb1pTZW1iZVo2Y0sxSWx5WG1FMSsx?=
 =?utf-8?B?cDRLS2E2QUlsSk52MXhhT29LcEw4R2hLRFdQYXZMMDJ1a25XNEY5enZCNUxa?=
 =?utf-8?B?WGVKZTVBVFgxTDQzOFNPTnRlbk5QSWQ5aEJzQzJIRW81K0hPTGx0V1lpMEZH?=
 =?utf-8?B?b1Brbkt1eE52VXA0MFFPWTl0OUllemtpUmxWZEI2REIyQTFBMzlWWmFwYzZI?=
 =?utf-8?B?clMvQnd5VUhwTjJiTjNUa1dNaUx5S0k1QTdMZjYrV1ZjTU5xNWZ4RUZ1OTBl?=
 =?utf-8?B?UFR4UWEyaWVUeDZ1V2V3dmtzckE2QzROS3N4QnEyLzZpRjU3VXdFUGZpL0Vu?=
 =?utf-8?B?d2VIa1B2NCtWY05ObDIyUjJraTFkV0lxV2hwNkhhTXBKaHNScTNTTWs3RVB1?=
 =?utf-8?B?a280TVBhakVLZ21zdEJTRXdoaFVzZFNVaDlCVWpLeVZwU0VDbHFHeUFMT3lD?=
 =?utf-8?B?S2Y2TGcwYWVBWkFqcW4yNnhkM01GR3o3c1dDQ0pQVVltZHlod0ZCRHJLR0Ju?=
 =?utf-8?B?MW50Ny9qQW9yWnBaV2dvMTRrMlF6WGp1enJXVHk1UTh2OGM5dEQ1RU5PcExL?=
 =?utf-8?B?am9uajFvTHRkR2c4UnY5UmVwdHEwY1ZXV1JzZ3RjWUYrMmRHb3R4L0F5ZFdv?=
 =?utf-8?B?SlREOXlpbHRjeTFUeUp6MlJQWDZSejV4NGE5UURhMUFGcWlsVnFJTEYyYnFD?=
 =?utf-8?B?MDBlZzAxejYySEpDVVZ0bmZxRFk5SERVQTZuNlp0b2pXK3h4cUZEOFlSdGRt?=
 =?utf-8?B?V0dWRDRBYnZpM2hrd2dWYVkwK05CRVBhYWVJRFVZZGUrcEh6dkU2SnlLMEhB?=
 =?utf-8?B?NmNSWWhJVmM4dFlSS0o0QVFoa0NXcHRjKzE1ZFQ1bGwxdDhzdlZaejdQWkcx?=
 =?utf-8?B?SEhhRkZtMGFBMTkrVEU5bGpCYnF2NnlOQzdnL1JMeDVlQ0kzM0ZUL2JPTEx6?=
 =?utf-8?B?SjRUSVBEU2E4QTVJSFdVdVBJeDI5TzhGYzczUjZzc2ttVHhLVlM2ZDJXUDhu?=
 =?utf-8?B?TUNIODBBVHFUT1Q0TkxrT2p6REVHUDdBeDlaRVZLVDNZVm5aa1IyZWtLd091?=
 =?utf-8?B?RHhEVEErc0YxMldabDZtQlArc29YU0dkcXU3T28zaGI0bVo4VnVJcnBzTm80?=
 =?utf-8?B?WDdVNDFGMi9IaFU3RVN0ZjZ6QjcyVkZFckRnZXVkQk5DcmFGNVhjc1NjUE9R?=
 =?utf-8?B?RlFSSVR5dGs3QzlJVER1SUwxMVVrMDI1eVZEYXdBdGZ0YTRqR21XdmVFOXJC?=
 =?utf-8?B?SktmM2tVTGlpcE9LVm9HS1NBVDhFODIvZXZLRVpOT1dyNjQzV0lvSmMvRHlE?=
 =?utf-8?B?MHRxSXVPeHdCR3QzcXVNci85d2hMeXR2alI3K0luekFHMk9PZC9mc2J3eTgr?=
 =?utf-8?B?ekRkS0JESnhvK1hOTEhia2h2UnVneUtLNDhrM1U5OG5aaWJSeGpHK0tGUklO?=
 =?utf-8?B?cENkbXloNEtGOFV6eFd1aTllNTVxU1Zqa0dHNUJiK1NyaGNVaHM3VllGTmZX?=
 =?utf-8?B?VDRKOU5sTVVuUlUyZGt6TFFNaW9LdldlYWU1QWV0N0FJMjdiS1pUcGtEMnFR?=
 =?utf-8?B?bmIyY3F5d3RUeXA0Ui8rT2FzQWlyNnBvek1VU2s2dTBWVXF5ZnhURlNCSGlv?=
 =?utf-8?B?a1diUjNkUEJBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EC46D844348594A94FDCBA35B11CCFD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8519
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: dc85e50f194743579c79d251446f34ee:solidrun,office365_emails,sent,inline:0346c0e52b01d855d83c1b7ecef118bc
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7da2ea71-e66d-4285-c9c5-08ddec87d8ae
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDlKTmV4bHBUZnpJOXk1WDc0aldYd0hWUmp0WG5yek0yYmNaR0dMVGNOUGda?=
 =?utf-8?B?eCtIS0ZuOG01S20rZE5iMnp1ZHFQc0dISE8yZ1VuckVWSGRSVkFhbUlhQ3o5?=
 =?utf-8?B?bzd4Nm1ERVYxaFlsVnRPc1lNZ2FYMmF3N2pwaEhNVmVkNFFZV2hnb0VLQjBS?=
 =?utf-8?B?NGwvV3U0Y3RFQnk5aTZ6eGFqbWRKTGRiTFlLM2NFdXNlVXpXQmZqZERrSksy?=
 =?utf-8?B?L2NFYVZzZmVNR3JYR0syRWxtQndySzUvd042dHBYeUFUSUUwejVnM1JKN0gr?=
 =?utf-8?B?ODdQNzkyRkhNaWM3enN2N04vb3REQlZ1b2VtQU1rRkFEb3dxWkxRTnBYZzht?=
 =?utf-8?B?NnVnLzY0MnEzYlZaYysrRk9qVFNSeXhYY3VORS9jVVhoUnVXK0RvMURSWkRS?=
 =?utf-8?B?cXdXWi8yK1R3c0doMitsN21EMXNnVVJGUHhzbDErNjdvYW9ZbjJLRjZHMU11?=
 =?utf-8?B?empPU2Eyazg5UzdORWp2ZFBPdjFveEFKZGY4WHl0MXJSQkNkbTVaKzQveFV1?=
 =?utf-8?B?Q1pMSElJNUZLVEVTY3pOaGxVMHR6UnRzV3A5QncrUkRhMHRMb1V1T2RIb1Jt?=
 =?utf-8?B?Q01vVXhwT0Y3dHg0VUg0NkFyMzZ0djNhQ1FpQUhKNk5Wem84WldHWk10Vmw4?=
 =?utf-8?B?dVJieXZlaG1kWDFMN1IwYkt2Y3ZUYXpYNWZXWXFlQ0JxbGt3QVhXcHZFNi9G?=
 =?utf-8?B?MEJpb1ZMREpNenZVQzJ6SXNXa2duWS9uem85ZWhvNTlhMVF0K1FrVHdRYnVU?=
 =?utf-8?B?NlZiQTN1T2lsV05rVFROaUpMUFdreHdoWVN4SWlneTZLMVd2RjFjZjRGdUhM?=
 =?utf-8?B?UHo4eWRZbFQwM2VWOXZTOUZvZURVanV5QTUzby9ieXV2UnQ3OGJsTWF5Z2dS?=
 =?utf-8?B?RmxuMTJINFZMcWZCbGY1dkpSRzQ0TUIzeEhsTElVMkhHZTAyRjN4UDZPaEpH?=
 =?utf-8?B?YjRvUEU4ZTMxOEIzRU9FdDA3SFBUeWV4YXJyMUNGc0Q1aVRlRHJEUTBXNkVv?=
 =?utf-8?B?SlNIWnYzUlFWYmVwMTFhMThscm1rNFJFSHZQRTFhZmExVVBMYzlyOXBuT3Ba?=
 =?utf-8?B?c2FJNU41U1NMMWtIcVdPcWFMaXU2M1dtajJrRE9zdzZkdW96bVBoalhvNHdY?=
 =?utf-8?B?dVdEQUl6RWRMZWdDb2pQaGZ5OHBTd2JteGxxWXY5bm1WR0lIVFJhQzVpRDI4?=
 =?utf-8?B?NDZrWDZrYWZobXpKZUpobGowdGdkcmtVV1FzcS9BZmNEeElndC8raXY3eWNY?=
 =?utf-8?B?KzFGaGNRbk5TMU5yUk03MGhtS3lzOVdRZjBNL2ZiRTRkMTlqRWJnOFE3ZWlI?=
 =?utf-8?B?dm0wWnBrSWQ3M3dQSC9sNTJYdGZFNyt1WkNCNjdyQ3lGN3c3VURvbmFCZFdw?=
 =?utf-8?B?aVZwQUVKNDV4dDlaT2RVMWw0bzBPQ053Zmt0Nk9yZG1wOGdTSHVrZ2ZDaitm?=
 =?utf-8?B?UVlxd0w2eEFkUWRQek01U2Q2NW5mUnFqV1JZcFR5L3o3ZGhCSVpKSS9URG5R?=
 =?utf-8?B?YmRYblFYajIyRHZIbG93dmtpaWJWb040NGdGdWVnZDVHSW00YzlKVThNdW44?=
 =?utf-8?B?UDRsOVBqT3AvMVE2ZkFYM0NPa29Bb1hjcXZibXdsVWs2UFN0bFo4OHhKc3Q0?=
 =?utf-8?B?elFzWjBYa1VlcUhqMFljall4ZUtpdkFURm02dlNXSFlIc2FPb093ZTJON0pL?=
 =?utf-8?B?N3owVkdGay9ZMVpUZmd5M0F4Ym5LZWFsdXEwL255UlFhcE1CTFlQNDVNbys1?=
 =?utf-8?B?cGFXU05JekFhYjNKOUxvOU5LOHFkMy9va0lMOTlxVEM4T211NzN0M2RabXB3?=
 =?utf-8?B?Tlg5N0FPL0YxU0tiVWd6d0NZbnh6dExFeENNZWh5OU1VZUc2bStlZjJGblIv?=
 =?utf-8?B?ZW91SlV5VDdaR1F6UVhYT3FTbThoY0RRVUlVZ1hISVY5Qk4yWWdjSzJyUnM4?=
 =?utf-8?B?Nk9ZdXFVNmdZckdQTE9TVGVweVg5VFoyUm5Sc0hNZTl1MDFRTFpkandmRngx?=
 =?utf-8?B?cXJPY0tkTVdWRHF6d0dReVYzNElkTGhqalNLOWhaOHkrNlRNMnB4RFplaEMz?=
 =?utf-8?Q?u2svGg?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:24:07.2257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec1c3c0-f9ac-4d48-087b-08ddec87df9b
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10124

QW0gMDUuMDkuMjUgdW0gMTM6Mzcgc2NocmllYiBWbGFkaW1pciBPbHRlYW46DQo+IE9uIEZyaSwg
U2VwIDA1LCAyMDI1IGF0IDExOjEwOjUzQU0gKzAwMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4g
SGkgVmxhZGltaXIsDQo+Pg0KPj4gVGhhbmtzIGZvciBhZGRpbmcgbWUgaW4gQ0MhDQo+Pg0KPj4g
QW0gMDUuMDkuMjUgdW0gMTI6NDkgc2NocmllYiBWbGFkaW1pciBPbHRlYW46DQo+Pj4gT24gVGh1
LCBTZXAgMDQsIDIwMjUgYXQgMDg6MjI6MTZQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0K
Pj4+PiBPbiBUaHUsIFNlcCAwNCwgMjAyNSBhdCAwNjo0NDowMVBNICswMzAwLCBWbGFkaW1pciBP
bHRlYW4gd3JvdGU6DQo+Pj4+PiBHb2luZyBieSB0aGUgZ2VuZXJpYyAiZnNsLGx5bngtMjhnIiBj
b21wYXRpYmxlIHN0cmluZyBhbmQgZXhwZWN0aW5nIGFsbA0KPj4+Pj4gU2VyRGVzIGluc3RhbnRp
YXRpb25zIG9uIGFsbCBTb0NzIHRvIHVzZSBpdCB3YXMgYSBtaXN0YWtlLg0KPj4+Pj4NCj4+Pj4+
IFRoZXkgYWxsIHNoYXJlIHRoZSBzYW1lIHJlZ2lzdGVyIG1hcCwgc3VyZSwgYnV0IHRoZSBudW1i
ZXIgb2YgcHJvdG9jb2wNCj4+Pj4+IGNvbnZlcnRlcnMgYW5kIGxhbmVzIHdoaWNoIGFyZSBpbnN0
YW50aWF0ZWQgZGlmZmVycyBpbiBhIHdheSB0aGF0IGlzbid0DQo+Pj4+PiBkZXRlY3RhYmxlIGJ5
IHNvZnR3YXJlLg0KPj4gSWYgdGhlIHNlcmRlcyBub2RlIGhhZCBhIHBoeSBzdWItbm9kZSBmb3Ig
ZWFjaCBsYW5lLCB0aGVuIHNvZnR3YXJlDQo+PiBjb3VsZCBkZXNjcmliZSBlYWNoIGxhbmUgaW5k
aXZpZHVhbGx5IC8gb21pdCA0IGxhbmVzIG9uIGx4MjE2MiBzZDEgZS5nLi4NCj4+DQo+PiBUaGlz
IGNvbWVzIHdpdGggYWRkZWQgYmVuZWZpdCB0aGF0IHBlcmhhcHMgaW4gdGhlIGZ1dHVyZSB3ZSBj
YW4gdXNlDQo+PiB0aGVtIHRvIGRlc2NyaWJlIGJvYXJkLXNwZWNpZmljIGVxdWFsaXphdGlvbiBw
YXJhbWV0ZXJzLg0KPj4NCj4+IFRoZSBjdXJyZW50IGRyaXZlciB1c2VzIGhhcmRjb2RlZCBkZWZh
dWx0cyB0aGF0IG1heSBiZSBhcHByb3ByaWF0ZQ0KPj4gZm9yIHNvbWUgbnhwIGV2YWx1YXRpb24g
Ym9hcmRzIG9ubHkuDQo+IFllYWguDQo+DQo+IEdpdmVuIHRoZSBmYWN0IHRoYXQgdGhlIFNlckRl
cyBjYW4gY2hhbmdlIGJldHdlZW4gcHJvdG9jb2xzLCBJIHN1c3BlY3QNCj4geW91IHdhbnQgdG8g
Z28gb25lIGxldmVsIGZ1cnRoZXIsIGFuZCBkZXNjcmliZSBkZWZhdWx0IGVxdWFsaXphdGlvbg0K
PiBwYXJhbWV0ZXJzIGZvciBlYWNoIHByb3RvY29sLiBUaGUgZXF1YWxpemF0aW9uIGZvciAxMEcg
d29uJ3QgYmUgZ29vZCBmb3INCj4gMjVHIGFuZCB2aWNlIHZlcnNhLg0KPg0KPiBEbyB5b3UgaGF2
ZSBhIHNwZWNpZmljIGZvcm1hdCBpbiBtaW5kPw0KSSBoYXZlIGEgcHJvdG90eXBlIGltcGxlbWVu
dGF0aW9uIGJhc2VkIG9uIHY1LjE1IHVzaW5nIHByb3BlcnRpZXMgYXMgYmVsb3cNCihJIGFtIG5v
dCBzdXJlIHRoaXMgaXMgdGhlIGJlc3QgZm9ybWF0IHRob3VnaCwgRFQgbWFpbnRhaW5lcnMgbWF5
IGhhdmUgb3BpbmlvbnMpOg0KDQpzZXJkZXNfMV9sYW5lX2c6IHBoeUA2IHsNCsKgIMKgIHJlZyA9
IDw2PjsNCsKgIMKgICNwaHktY2VsbHMgPSA8MD47DQrCoCDCoCBmc2wsZXEtbmFtZXMgPSAiMTBn
YmFzZS1yIiwgIjI1Z2Jhc2UtciI7DQrCoCDCoCBmc2wsZXEtdHlwZSA9ICIzLXRhcCIsICIzLXRh
cCI7DQrCoCDCoCBmc2wsZXEtcHJlcS1zaWduID0gInBvc2l0aXZlIiwgInBvc2l0aXZlIjsNCsKg
IMKgIGZzbCxlcS1wcmVxLXJhdGUgPSAiMS4zMyIsICIxLjMzIjsNCsKgIMKgIGZzbCxlcS1wb3N0
MXEtc2lnbiA9ICJuZWdhdGl2ZSIsICJuZWdhdGl2ZSI7DQrCoCDCoCBmc2wsZXEtcG9zdDFxLXJh
dGUgPSAiMS4yNiIsICIxLjI2IjsNCsKgIMKgIGZzbCxlcS1hbXAtcmVkID0gIjEuMDAwIiwgIjEu
MDAwIjsNCsKgIMKgIGZzbCxlcS1hZGFwdGl2ZSA9IDwzMj4sIDwzMj47DQp9Ow0KDQpJIGltYWdp
bmUgYSBwYXJhbWV0ZXJzIHN1Yi1ub2RlIHBlciBwcm90b2NvbCBtYXkgYmUgbW9yZSByZWFkYWJs
ZS4NCg0KVGhlIGJlc3QgZGVzY3JpcHRpb24gd291bGQgYmUgZ2VuZXJpYyBlbm91Z2ggdG8gY292
ZXIgcGNpIGFuZCBzYXRhLCB0b28uDQoNClBlcmhhcHM6DQoNCnNlcmRlc18xX2xhbmVfZzogcGh5
QDYgew0KwqAgwqAgcmVnID0gPDY+Ow0KwqAgwqAgI3BoeS1jZWxscyA9IDwwPjsNCsKgIMKgIGZz
bCxlcS1wYXJhbXMgPSA8JnNlcmRlc18xX2xhbmVfZ19lcV8xMGc+LCA8JnNlcmRlc18xX2xhbmVf
Z19lcV9zYXRhPjsNCsKgIMKgwqANCsKgIMKgIHNlcmRlc18xX2xhbmVfZ19lcV8xMGc6IGVxLXBh
cmFtcy0wIHsNCsKgIMKgIMKgIMKgIC8qIGNvbXBhcmUgZG93bnN0cmVhbSBlbnVtIGx5bnhfMjhn
X2xhbmVfbW9kZSAqLw0KwqAgwqAgwqAgwqAgZnNsLGxhbmUtcHJvdG9jb2wgPSAieGZpIjsNCsKg
IMKgIMKgIMKgIGZzbCxlcS10eXBlID0gIjMtdGFwIjsNCsKgIMKgIMKgIMKgIGZzbCxlcS1wcmVx
LXNpZ24gPSAicG9zaXRpdmUiOw0KwqAgwqAgwqAgwqAgZnNsLGVxLXByZXEtcmF0ZSA9ICIxLjMz
IjsNCsKgIMKgIMKgIMKgIGZzbCxlcS1wb3N0MXEtc2lnbiA9ICJuZWdhdGl2ZSI7DQrCoCDCoCDC
oCDCoCBmc2wsZXEtcG9zdDFxLXJhdGUgPSAiMS4yNiI7DQrCoCDCoCDCoCDCoCBmc2wsZXEtYW1w
LXJlZCA9ICIxLjAwMCI7DQrCoCDCoCDCoCDCoCBmc2wsZXEtYWRhcHRpdmUgPSA8MzI+Ow0KwqAg
wqAgfTsNCsKgIMKgwqANCsKgIMKgIHNlcmRlc18xX2xhbmVfZ19lcV9zYXRhOiBlcS0xIHsNCsKg
IMKgIMKgIMKgIC8qIGNvbXBhcmUgZG93bnN0cmVhbSBlbnVtIGx5bnhfMjhnX2xhbmVfbW9kZSAq
Lw0KwqAgwqAgwqAgwqAgLyogZXhhbXBsZSBwYXJhbWV0ZXJzLCBkbyBub3QgdXNlIGZvciBzYXRh
ICovDQrCoCDCoCDCoCDCoCBmc2wsbGFuZS1tb2RlID0gInBjaSI7DQrCoCDCoCDCoCDCoCBmc2ws
ZXEtdHlwZSA9ICIzLXRhcCI7DQrCoCDCoCDCoCDCoCBmc2wsZXEtcHJlcS1zaWduID0gInBvc2l0
aXZlIjsNCsKgIMKgIMKgIMKgIGZzbCxlcS1wcmVxLXJhdGUgPSAiMS4zMyI7DQrCoCDCoCDCoCDC
oCBmc2wsZXEtcG9zdDFxLXNpZ24gPSAibmVnYXRpdmUiOw0KwqAgwqAgwqAgwqAgZnNsLGVxLXBv
c3QxcS1yYXRlID0gIjEuMjYiOw0KwqAgwqAgwqAgwqAgZnNsLGVxLWFtcC1yZWQgPSAiMS4wMDAi
Ow0KwqAgwqAgwqAgwqAgZnNsLGVxLWFkYXB0aXZlID0gPDMyPjsNCsKgIMKgIH07DQp9Ow0KDQo+
DQo+Pj4+PiBTbyBkaXN0aW5ndWlzaCB0aGVtIGJ5IGNvbXBhdGlibGUgc3RyaW5ncy4NCj4+Pj4+
IEF0IHRoZSBzYW1lIHRpbWUsIGtlZXAgImZzbCxseW54LTI4ZyIgYXMgYmFja3VwLg0KPj4+PiBX
aHkga2VlcCB0aGUgYmFja3VwPyBEb2Vzbid0IHNvdW5kIGxpa2UgeW91IGNhbiB1c2UgaXQgZm9y
IGFueXRoaW5nLA0KPj4+PiB1bmxlc3MgdGhlcmUncyBzb21lIG1pbmltdW0gc2V0IG9mIGNhcGFi
aWxpdGllcyB0aGF0IGFsbCBkZXZpY2VzDQo+Pj4+IHN1cHBvcnQuIElmIHRoYXQncyBub3QgdGhl
IGNhc2UsIHNob3VsZCBpdCBub3QganVzdCBiZSBtYXJrZWQgZGVwcmVjYXRlZA0KPj4+PiBvciBy
ZW1vdmVkIGVudGlyZWx5Pw0KPj4+IFRvIGJlIGhvbmVzdCwgSSBjb3VsZCB1c2Ugc29tZSBndWlk
YW5jZSBvbiB0aGUgYmVzdCB3YXkgdG8gaGFuZGxlIHRoaXMuDQo+Pj4NCj4+PiBXaGVuIEkgaGFk
IHdyaXR0ZW4gdGhpcyBwYXRjaCBkb3duc3RyZWFtLCBseDIxNjBhLmR0c2kgb25seSBoYWQgc2Vy
ZGVzXzENCj4+PiBkZWZpbmVkLCBhcyAiZnNsLGx5bngtMjhnIiwgYW5kIHRoaXMgcGF0Y2ggbWFk
ZSBtb3JlIHNlbnNlLiBLZWVwDQo+Pj4gImZzbCxseW54LTI4ZyIgYXMgYSBzeW5vbnltIGZvciAi
ZnNsLGx4MjE2MGEtc2VyZGVzMSIsIHNvIHRoYXQgbmV3DQo+Pj4gZGV2aWNlIHRyZWVzIHN0aWxs
IHdvcmsgd2l0aCBvbGQga2VybmVscyAoYXMgaXMgc29tZXRpbWVzIG5lZWRlZCBkdXJpbmcNCj4+
PiAnZ2l0IGJpc2VjdCcsIGV0YyksIGZvciBzb21lIGRlZmluaXRpb24gb2YgdGhlIHdvcmQgIndv
cmsiIChtb3JlIG9mdGVuDQo+Pj4gdGhhbiBub3QsIHVuc2F0aXNmYWN0b3J5IC0gZm9yIGV4YW1w
bGUsIGZ3X2RldmxpbmsgYmxvY2tzIHByb2JpbmcgdGhlIFBIWQ0KPj4+IGNvbnN1bWVyIGRyaXZl
ciBpZiB0aGUgUEhZIGRyaXZlciBkb2Vzbid0IGV4aXN0LCBidXQgdGhlICdwaHlzJyBwcm9wZXJ0
eQ0KPj4+IGV4aXN0cyBpbiB0aGUgZGV2aWNlIHRyZWUpLg0KPj4+DQo+Pj4gVW5iZWtub3duc3Qg
dG8gbWUsIGNvbW1pdCAyZjI5MDAxNzZiNDQgKCJhcm02NDogZHRzOiBseDIxNjBhOiBkZXNjcmli
ZQ0KPj4+IHRoZSBTZXJEZXMgYmxvY2sgIzIiKSBjYW1lIGFuZCBkZWZpbmVkIHRoZSBzZWNvbmQg
U2VyRGVzIGFsc28gd2l0aA0KPj4+ICJmc2wsbHlueC0yOGciLg0KPj4+DQo+Pj4gVGhlIHNlY29u
ZCBTZXJEZXMgaXMgbGVzcyBjYXBhYmxlIHRoYW4gdGhlIGZpcnN0IG9uZSwgc28gdGhlIHNhbWUN
Cj4+PiBkZXZlbG9wZXIgdGhlbiBzdGFydGVkIGJhdHRsaW5nIHdpdGggdGhlIGZhY3QgdGhhdCB0
aGUgZHJpdmVyIGRvZXNuJ3QNCj4+PiBrbm93IHRoYXQgc2VyZGVzXzIgZG9lc24ndCBzdXBwb3J0
IHNvbWUgcHJvdG9jb2xzLCBhbmQgd3JvdGUgc29tZQ0KPj4+IHBhdGNoZXMgbGlrZSA5YmVmODRk
MzBmMWYgKCJwaHk6IGx5bngtMjhnOiBjaGVjayByZXR1cm4gdmFsdWUgd2hlbg0KPj4+IGNhbGxp
bmcgbHlueF8yOGdfcGxsX2dldCIpLCB3aGljaCBpbiBhbGwgbGlrZWxpaG9vZCBjb3VsZCBoYXZl
IGJlZW4NCj4+PiBhdm9pZGVkIHVzaW5nIGEgc3BlY2lmaWMgY29tcGF0aWJsZSBzdHJpbmcuDQo+
Pj4gVGhlIGx5bnhfaW5mbyA6Og0KPj4gSW4gdXBzdHJlYW0gbXkgcGF0Y2ggZml4ZXMgbm90aGlu
ZywgaXQgYWRkZWQgYSByZXR1cm4gdmFsdWUgY2hlY2sNCj4+IGZvciBhIGZ1bmN0aW9uIGNhbGwg
dGhhdCBjYW4gaW5kZWVkIHJldHVybiBOVUxMLg0KPj4NCj4+IE15IGJhdHRsZSB3YXMgYSBkaWZm
ZXJlbnQgb25lLCB1bnJlbGF0ZWQgdG8gdmFyeWluZyBzZXJkZXMgYmxvY2sgZmVhdHVyZXMNCj4+
IChJIGNsYWltIGl0IGNhbiBhbHNvIGhhcHBlbiB3aXRoIHNhbWUgcGh5IG9uIHNlcmRlcyBibG9j
ayAxKToNCj4+DQo+PiBJIGZvdW5kIHRoYXQgdGhlIGNvbWJpbmF0aW9uIG9mIE1hcnZlbGwgMTBH
IHBoeSBkcml2ZXIsIHBjcywgc2VyZGVzIGFuZCBkcGFhMg0KPj4gZGlkIG5vdCBzdHJpY3RseSBh
ZGhlcmUgdG8gcGh5LWNvbm5lY3Rpb24tdHlwZSBzZXQgaW4gZGV2aWNlLXRyZWUsIG9yIHRoZSBp
bml0aWFsDQo+PiBtb2RlIG5lZ29pdGF0ZWQgYmV0d2VlbiBwaHkgYW5kIG1hYy4NCj4gWWVzLCBp
dCBkb2Vzbid0IGhhdmUgdG8uDQo+DQo+PiBPbmNlIHBoeSBuZWdvdGlhdGVkIGEgMi41R2Jwcywg
dGhlIGtlcm5lbCB3b3VsZCB0aGVuIHRyeSBzd2l0Y2hpbmcNCj4+IGFsbCAzIGRyaXZlcnMgdG8g
YSAyLjVnIG1vZGUsIHdoZW4gaXQgc2hvdWxkIGhhdmUgc3R1Y2sgd2l0aCAxMGdiYXNlLXIsDQo+
PiBvciByZXBvcnRlZCBhbiBlcnJvciBrbm93aW5nIHRoYXQgdGhlIHNlcmRlcyBkaWQgbm90IGFk
dmVydGlzZSBzdXBwb3J0IGZvciAyLjVnLg0KPj4NCj4+IER1ZSB0byBtYXNzaXZlIGRvd25zdHJl
YW0gcmVmYWN0b3JpbmcgaW4gdGhlIHZlbmRvciBrZXJuZWwgc2VyZGVzIGRyaXZlciwNCj4+IHRo
ZXJlIGV4aXN0ZWQgYSBjb2RlLXBhdGggbGVhZGluZyB0byBudWxsIHBvaW50ZXIgZGVyZWZlcmVu
Y2UuDQo+PiBCdXQgdGhhdCB3YXMgYWxzbyBhIGNvbnNlcXVlbmNlIG9mIG90aGVyIG1pc3Rha2Vz
Lg0KPiBTb3JyeSwgSSBpbnRlcnByZXRlZCB5b3VyIHBhdGNoIGluIHRoZSBvbmx5IHdheSB0aGF0
IGNvdWxkIGhhdmUgbWFkZSBhbnkNCj4gc2Vuc2UuDQo+DQo+IEluIHRoZSBjaXJjdW1zdGFuY2Ug
eW91IGRlc2NyaWJlLCBpc24ndCB5b3VyIGZpeCBqdXN0ICJjb2RlIGFmdGVyIHJldHVybiI/DQo+
IEhvdyB3b3VsZCBoYXZlIGx5bnhfMjhnX3NldF9tb2RlKFBIWV9NT0RFX0VUSEVSTkVULCBQSFlf
SU5URVJGQUNFX01PREVfMjUwMEJBU0VYKQ0KPiBnb3R0ZW4gcGFzdCB0aGUgbHlueF8yOGdfc3Vw
cG9ydHNfaW50ZXJmYWNlKCkgdGVzdCB3aXRob3V0IGJlaW5nIHJlamVjdGVkPw0KDQp2Ni42LjYu
NTItMi4yLjAgcmVsZWFzZSwgLnNldF9tb2RlOg0KDQpseW54XzI4Z19zZXRfbW9kZS0+bHlueF8y
OGdfc2V0X2xpbmtfbW9kZS0+bHlueF8yOGdfc2V0X2xhbmVfbW9kZS0+bHlueF8yOGdfcGxsX2dl
dA0KDQpkb2VzIG5vdCBjaGVjayBseW54XzI4Z19zdXBwb3J0c19pbnRlcmZhY2UuDQoNCj4gVGhl
IGRyaXZlciB3b3VsZCBoYXZlIG5lZWRlZCB0byBzdWZmZXIgc29tZSBwcmV0dHkgc2VyaW91cyBt
b2RpZmljYXRpb25zDQo+IHRvIGFsbG93IHRoaXMgdG8gaGFwcGVuLCBhbmQgSSdtIG5vdCBoYXBw
eSB3aXRoIHRoZSBmYWN0IHRoYXQgaXQncyBjaGFuZ2VkDQo+IHRvIGhhbmRsZSBpbmNvcnJlY3Qg
ZG93bnN0cmVhbSBjaGFuZ2VzLCB3aXRob3V0IGF0IGxlYXN0IGEgY29tcGxldGUNCj4gZGVzY3Jp
cHRpb24uDQpQb2ludCBvZiBteSBzdWJtaXR0ZWQgcGF0Y2ggd2FzIG1lcmVseSB0byBndWFyZCBh
biB1bmNoZWNrZWQgcG9pbnRlciwNCmdlbmVyYXRpbmcgYXBwcm9wcmlhdGUgZXJyb3Igd2l0aCBl
bm91Z2ggZXhwbGFuYXRpb24gZm9yIG5vbi1tYWludGFpbmVycy4NCg0KSSBkZWJhdGVkIHVzaW5n
IEJVR19PTiBpbnN0ZWFkIG9mIHdhcm4uDQoNCj4NCj4+PiBsYW5lX3N1cHBvcnRzX21vZGUoKSBt
ZXRob2QgZnJvbSBwYXRjaCAxNC8xNCBpcyBzdXBwb3NlZCB0byBzYXkgd2hhdCBpcw0KPj4+IHN1
cHBvcnRlZCBwZXIgU2VyRGVzIGFuZCB3aGF0IG5vdC4NCj4+IEluZGVlZCwgYW5kIHVwc3RyZWFt
IHByb3Blcmx5IGdhdGVzIGFsbCByZWNvbmZpZ3VyYXRpb24gYXR0ZW1wdHMgdXNpbmcgaXQuDQo+
Pj4gSW4gdGVybXMgb2YgaW1wbGVtZW50YXRpb24sIHdoYXQgZG9lcyAiZGVwcmVjYXRpbmciIHRo
ZSAiZnNsLGx5bngtMjhnIg0KPj4+IGNvbXBhdGlibGUgc3RyaW5nIG1lYW4sIGNvbXBhcmVkIHRv
IHJlbW92aW5nIGl0IGVudGlyZWx5PyBXb3VsZCB0aGVyZSBiZQ0KPj4+IGFueSByZW1haW5pbmcg
ZHJpdmVyIHN1cHBvcnQgZm9yIGl0P1Nob3VsZCBJIGNvbXB1dGUgdGhlIGNvbW1vbiBzZXQgb2YN
Cj4+PiBjYXBhYmlsaXRpZXMgYmV0d2VlbiBTZXJEZXMgIzEgYW5kICMyLCBhbmQgb25seSBzdXBw
b3J0IHRoYXQ/IFdoYXQNCj4+PiBpbXBhY3Qgd291bGQgdGhpcyBoYXZlIHVwb24gb2xkIGRldmlj
ZSB0cmVlcz8gSXMgaXQgYWNjZXB0YWJsZSB0byBqdXN0DQo+Pj4gcmVtb3ZlIHN1cHBvcnQgZm9y
IHRoZW0/DQo+PiBXaGVuIHlvdSByZW1vdmUgdGhlIG9sZCBjb21wYXRpYmxlIHN0cmluZywgdGhl
IGRyaXZlciBzaG91bGQgc3RpbGwga2VlcA0KPj4gc3VwcG9ydGluZyBvbGQgRFRCcy4NCj4gVGh1
cyB0aGlua2luZyBTZXJEZXMgIzIgc3VwcG9ydHMgYWxsIGZlYXR1cmVzIG9mIFNlckRlcyAjMT8N
Clllcy4NClRoaXMgd2lsbCBub3QgYmUgYSBwcm9ibGVtIGZvciB0aG9zZSB1c2VycyB3aG8gY29u
ZmlndXJlIGFsbCBsYW5lcyB0byBTR01JSSwNCm9yIGp1c3QgdGhlIHR3byBzcGVjaWFsIGxhbmVz
IGZvciBYRkkuDQoNCkkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdG8gZml4IGEgZG93bnN0cmVhbSBk
dGIgdmlhIHRoZSBkcml2ZXIuDQpJZiBkb3duc3RyZWFtIHVzZXIgY2FuIHVwZGF0ZSB0aGUga2Vy
bmVsLCB0aGV5IGNhbiB1cGRhdGUgdGhlIGR0YiBhbHNvLA0KdG8gcmVzb2x2ZSB0aGVpciBvd24g
YnVncy4NCg0KPg0KPj4gSSBwZXJzb25hbGx5IGJlbGlldmUgaXQgY29ycmVjdCB0byBrZWVwIGR1
YWwgY29tcGF0aWJsZSBzdHJpbmdzLA0KPj4gcmVmbGVjdGluZyB0aGF0IHRoZSBzZXJkZXMgYmxv
Y2tzIHNoYXJlIGEgY29tbW9uIHByb2dyYW1taW5nIG1vZGVsLg0KPiBUaGFua3MgZm9yIHRoZSBp
bnB1dC4NCj4NCg==


