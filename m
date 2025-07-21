Return-Path: <linux-kernel+bounces-738695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461DB0BC04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0710718961E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BF421A457;
	Mon, 21 Jul 2025 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4sKNO2+e"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECA3C30;
	Mon, 21 Jul 2025 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753075587; cv=fail; b=QkcF0HwVgu56mF3puipyrMM5FVoDdZw4NlHtHXgDdgqfXc88ADRnxLKEOkYDmoxJexvS1PhzuQ7MFM9FcjN4pIF4C+X1Dc3qZJO0iG4BJBMSeJxcxzsLRNFsbcEGRzkTLtA6DZVrgXY5GjTgrAn3a/Zjg4RR8ZCFQiQn6SkT2s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753075587; c=relaxed/simple;
	bh=fWWQD0U6jqnud3Vt0fS0paoKz5Hxpr/f9XNNuzspaHw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A4j1bVM5QWY7ZUWHvCxmNGEaPCAjBM2RYDPwXpoXxJzjh08GG97XIi4ET9h9uS0J3w7V4I25gsLTLwK0B9TIvh3Bxr8lQ2XSh7LZOIVa44xEQ/S6E8aGFfwX2xiYOA1qqPrLeuo2FtFSR+e2AHm6MNSmNPcFIwTv4eSOxmnPbHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4sKNO2+e; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2FM7rsUSswX9pN1KOllOcqeRwZEejIVn6CvDi+8i2FAs7bTQgrjK7y6MOB8GeT0EBvcY6p82o72/z/siIHTf9vk26cOLpy63V43f5v8o39Zjkk93ydQmrO8SsaqTcPMlhWEtu+G4XXGAq1TpfQIjfcdjAhQfYtBEAdRuvexbUr/G2+q42/4GMv4hH/pZZwS478vpUqq8OTJkUn2QFNlzuXY2mOToALTaXwIvwJBw3+Tmn6dkEcHO+6T8XU5ny1WD3qTI8q0EtMazoCN9zRir7xPj0QJAyGoDJtEXZHhaRe99EYHs7e1ahnobYf432dJYsi4ly1gGz+aKLRgzFcxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWWQD0U6jqnud3Vt0fS0paoKz5Hxpr/f9XNNuzspaHw=;
 b=ONrcgOjjJC+Xe8bur6mCb679rpdi6ZeNl4qxCWJCgMlT6A+QOyrof7dV6gVQTOK4A1kTos8yYLiNAOvTYKRC7rmbD63tdtuGV2Q3916YnbeL/sEddC7AUBOi16DPhQo8kPKeR9FV43pnHY2Js9A+DfTNmdcFKi8MPlvUpe9zfudWR7VDLJrwDdp66mhNoq8sWkmQwqoYMUzAIlyIut1jtgFb6RuP3/n5U0IsExoMpCPjPt/nMcKdxYSyAMz3Cto276ru1NeLQQ2jUFY32T+v5LcO0IFOiohZfs149pvDluApujpuFEEz87ep1K8zbDbTC5kpa/3vdUxG0NPK+w3JDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWWQD0U6jqnud3Vt0fS0paoKz5Hxpr/f9XNNuzspaHw=;
 b=4sKNO2+eZVgrOcreFxgBiCcNuC0zPMx5qFJbDWROthYGdx1b3ym6LTQXvoDzzNgU2qMvoeZ+Ag3yECEopAgsIbb13EaWZZ/BqvHEKmw0qG1FYx5cfxp1+vezOoI3I3Hvvhp8pVXibNE3uOWpSmIdlSlxiWKn38AB3BmvP2vMQOeAPcyp54vCPP3Rs/bL1qyWUTdWwMogc3WRdRwQQ948pHo6Xwox+0993R3TlQ5qQlkShk8Ly/kgvBv2YWc2+rYFPGckeGZ6L/YEQpps5op6GNx4EkW4ts8keuuvmmZkyEcQxPlq0Bq0Pc1GIJF+WuDlmIZroC6enZ3JviGENKImKw==
Received: from IA3PR11MB9014.namprd11.prod.outlook.com (2603:10b6:208:583::17)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 05:26:22 +0000
Received: from IA3PR11MB9014.namprd11.prod.outlook.com
 ([fe80::b229:255:43b1:7ae4]) by IA3PR11MB9014.namprd11.prod.outlook.com
 ([fe80::b229:255:43b1:7ae4%6]) with mapi id 15.20.8857.038; Mon, 21 Jul 2025
 05:26:22 +0000
From: <Varshini.Rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <Andrei.Simion@microchip.com>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: atmel,at91-ssc: add
 microchip,sam9x7-ssc
Thread-Topic: [PATCH] ASoC: dt-bindings: atmel,at91-ssc: add
 microchip,sam9x7-ssc
Thread-Index: AQHb2dQNW3MKOC1fvkW4ldoW+ewb8LQ8TFaA
Date: Mon, 21 Jul 2025 05:26:22 +0000
Message-ID: <7989c547-2346-4e1e-8327-0c085885faf9@microchip.com>
References: <20250610065005.64070-1-varshini.rajendran@microchip.com>
In-Reply-To: <20250610065005.64070-1-varshini.rajendran@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9014:EE_|SA1PR11MB8594:EE_
x-ms-office365-filtering-correlation-id: 6b228f18-24e8-4769-2eca-08ddc8172123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHI4b0VBUlQ3TnY3eVhQWU5pOEEvek9SMElVdnBJK2RyK2xrN2I0cnZvUVdB?=
 =?utf-8?B?aG1sak1MQnBxN3p1NFUrci9Ma1VDWFR6Rms1L0RuOWZKajJOU3paNlNqcnlz?=
 =?utf-8?B?ZWN2clpXMUdDR1M2RzNMSnV5d1ZWeExkTE5HbGNQTVRNY2IweHB4dU1GQjdZ?=
 =?utf-8?B?QUVjTnpLNGVxcTAvSFRMYXNYSlFsM2RCcVFxZnZuVVJ4MVBybkk0V093RWV1?=
 =?utf-8?B?eEVNM3VSb2RKdWI3eGw1K2ozRWRIRTRhcXdLUVlOMm14WXFJZ2dwZ0ZadWVq?=
 =?utf-8?B?UHpHT0E0RStRaEpSRkFBVmhwWlJ2NWVLeUt4dE50K2RucU5sZjBjREdzSmJs?=
 =?utf-8?B?c1A0cUlSc1hXK3R0WktRV1BNV20vYTNtYjluMm5KcTA2NnlmSEJXcEVWdG5G?=
 =?utf-8?B?QUl3aGNRRmZFVWpsaGJYSlZ2MjFmOHRpRkFZVHJPYWRKMEhrT1NJVmdmU0hV?=
 =?utf-8?B?QmZnVmNScDRib1RVRlA4dUp0b080eXdvSUs0THdpNm1Wbzdwb2cwaHhQb3pP?=
 =?utf-8?B?Sm5WRytqSFVXU1p6aHplaWhqdlVoeW1yaExVY2hMMkVPaFc1VnNhMDJZN1Rj?=
 =?utf-8?B?dE5jK3ZKdlRheXBOdWdsWDI5WHFJTnRmU3N1VDJ3YkJuOTU1UzBTZnYyNUlK?=
 =?utf-8?B?bFpkdmtZZnhuVnI5Y0RQTFA3RFVKdFJXQzZmUStRZTc2NWJJQ1dkcEhra2tk?=
 =?utf-8?B?RDNpTGNFa2NRUzRxSG01WThwUitSNms5STV0UzZYN3RDSEdhTjZUTVpORGtC?=
 =?utf-8?B?Z0VESUNJLzNMT2hCcW5ET2ZvSmpIaXZscHczNUZkandOK3pCWFJOLzJGWGh3?=
 =?utf-8?B?WVFra0NRUlFSdEtOdUE5bmlBYlMxb0RtQ3J3RERVTUFhd1o5WldqUVFyV0l0?=
 =?utf-8?B?enhVeVhQR1pWL2s0MHJTZG5CQkYxcS90Rms2ZEJSVzRFaWJTcXdIbDJxeTNs?=
 =?utf-8?B?RTdlR2YvM3BzN1UwWnVRM1ROVGNITWxXWjJNR1dreXRsOXdreElVVzRCYXhF?=
 =?utf-8?B?R2o2TGxrcEZnVzBLTjBSdTljalZ0bEg0K05TTzRLSFU3eDNtSnRVNHJ4U2JY?=
 =?utf-8?B?NnZWR2ZrSkNMMFRjbm80aUlKM0hmS2V2SEFGM3NYUkZSRVd5Y24xMW1xN0RE?=
 =?utf-8?B?QmlVdkdlNjZKQTFBL2xqR3lNeXd2VG42ZWRlZFQrVHdQemduSFArWGg0REhC?=
 =?utf-8?B?MmlaZ2NVVWdvcnZpT09pM0FKeEdRQVNKQjV4NHQxa1NVYjFFczk3ZDAwditz?=
 =?utf-8?B?MGR6TWE1WnFxVnFtQkYwWERoYzVsK2Z1UlBNZjlUeWFYUHIvOWRwNzNjVGhU?=
 =?utf-8?B?dXdIQWhlZ3RHODlFY1NwNmZScG1yS0RDSnBGSDNoMC9PUFRObld2b1VoSFUw?=
 =?utf-8?B?VDRvenZuNUR4QnVSOWkzV1FoSnczb0RERTZXOWl4V3FTb3k3bTZ0RHcrNUc0?=
 =?utf-8?B?RE4zOU5nZ3hKNHpJUVZSVHZWSlVFY1Foam5iMnZPdzVDVDYzZWcraFZIVExw?=
 =?utf-8?B?SXprTWZHWnVtVkVsTGxNYWJhQmUwY1E1eGRNL2dFMDBNUTNSR0JPUm9LWXdM?=
 =?utf-8?B?M3JzaXRtbExxd3FNdC9kSVA5MHJzanhZdlQ5T1FQY013K2FVaHlvV3lERTRZ?=
 =?utf-8?B?WXpyZDllS1BXREN1MmNwNVVzSkhqeWtPNmNFbGVsR3FiZndScU93RTNNK3dw?=
 =?utf-8?B?VlJrUHZjMGFMcGtHOFBHSWJZeklPcDRRcWR0d25ZZ0xNd3Y3ZkZCUk90Y09T?=
 =?utf-8?B?V1JsSXY5ZXBiOCtZb2VjK1E5Q24xS2FCaFRqcFpkYXFteGRQRTJnY0xDa1V2?=
 =?utf-8?B?eUV0aTYvSEJPenpBZVBScUhkK1dDWFFuRTVGMzB3WTVRSVRzNTRWdlZjNUdE?=
 =?utf-8?B?NGRza1FLZHM3TTZUcFh3NGJ3RDFsbU11NGtaM1V0WVRGU056Skd0TEFMM1hZ?=
 =?utf-8?B?Zi80TFhPZVdaaTJtYzBVMEsvSUNpazBXVU94eWVZU1I0bWdpQ2owU3NheWwx?=
 =?utf-8?B?R3J0N3UrV0xGa0NEa3VEUGdFeHMybnZLcTloRzVBUkVKOE5ZKzVEb2dhVG5w?=
 =?utf-8?Q?HgoksY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9014.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWk1QjZUL0xoVUQ5bFpkRHlzZlQ3aHdhYnJZQUsvdmN4dXl4aE02V2lySlVB?=
 =?utf-8?B?VGtXUTM2RXg0Z0FaKzkxRHFNRS9ZU1BiSXhIZlJaTTJLWXZFUUNOUlFNUW56?=
 =?utf-8?B?UHAyVGhGeUkzYndydVBEc2pqbU1QQ3NHMFFVWU5kV01LMUk1SmorZXRQL3lj?=
 =?utf-8?B?M04xWFVVUTVsbENSNDZ6TDEyU1hkTnpYL01lTW5jLzNLNXF5WllrOHByRFQ5?=
 =?utf-8?B?OU11QmFUL1hkWi9MdFpoeWxPNm1ORWZaZWFVWEd3Vi9iQ252ZG91UWpudU90?=
 =?utf-8?B?NERlTit2Wit2R2QrekVxSVhzVHJkTGFCeTBpcmZrSml1V0liU280aFJ3TG1X?=
 =?utf-8?B?eWVycXltczRrQlVVc2FNSVpERWJmN1VDbVRsSDRzSDlkZGZsTklUcHVpMTN1?=
 =?utf-8?B?clVTeDU1elk0RFVtVC8ySVlKSHZ3QWg5Qml4alJYYlA3RkE3YlNrd0hLWUp2?=
 =?utf-8?B?VVAvc0gvcisvTzh0a0RyQVFUMXZvUWtTSDRnbjRDRmZWQWVsMmp2UURCMGRW?=
 =?utf-8?B?Mk90eCs4SG5qaDRrNk1lNm8rT1R6Yld5cjlRdGI0TFhnTTIrMWZraGcxZlJE?=
 =?utf-8?B?MFFUQ05DenhpZ0NRNEY2N3FzblI1dnBUNE9vMFlRbS9xMVJuRzRBbnNZWmdJ?=
 =?utf-8?B?c3hWRkdkYjdlTFVBZWxyWGc0N0p3S2JHQ3EzazBnVXhvZWIwSHo3TmY1U2Nn?=
 =?utf-8?B?a3NIdFRDVWl6Q3UzbDNWQkVRaTA4YXBxdnFacHp1cTNKZmYzOVVZOER1M21S?=
 =?utf-8?B?ZHZqS2pnTjhGdmNvQy9iQkEwR3FoNEpEUTZOd1kwSDQ2Zkp4ZGhrK2VBNUxu?=
 =?utf-8?B?Z01PWXR3a0o2czhqZzF2WENGM1lZY1NlblRzem9ESG9Na2VESkcrMXFoSzFY?=
 =?utf-8?B?OHBPN05xZGl6dWVMYXYvZ3NmNENMNnNDekVsZmtkZ28xUU9Eall6bVVNNUhZ?=
 =?utf-8?B?MmdIRFdtUWhZZlBJTkdtTlBlK3VNSEhwRWFhaGVMNnIyRFhTeUVvODRaUUEy?=
 =?utf-8?B?LzdCOUNsVnlPeXJzc1NaMldRQ0RnSlFqN1R1UDhnMzhDRC9QaVR4MnFPRWtt?=
 =?utf-8?B?aEhiblgrRlFUTzhlU1VJelgxc1NLSmVvSC80RkdPVnlQSUxZczFzV2twOFNX?=
 =?utf-8?B?WVJLSkNIbG5MQkZCaUMvS1hzT1FQckhOckVqRUUyUVhib3BDNS9SaUF1VHNr?=
 =?utf-8?B?bkdXcVBNTEo2WHJxTnVsN2FQNnplRmlBRzRTbVYxV25pUWVZTFczVkI5TFVn?=
 =?utf-8?B?Mk1CZ0kvcFNYNkZMTllzMllHMGkrdXRGUCt5YmZjd3o1TmVLaTcwVDhuYzhM?=
 =?utf-8?B?U0lwbDNxa25lRU5kcEM2blNEYkV1dnpoeDVrcVhoeTVXUDNXY1AvNUNmY0E4?=
 =?utf-8?B?dW4raE12cjA4clFVLytEVFZhUEZrdTJkOWlsMDl1Y2V0Y1YrK0JMOVdjZjNN?=
 =?utf-8?B?VkJheFo2dkRpNjFkbS8wRCs5Rmkza3ZGRFd2UkM5MmxFT2EvUndCY0pxZDdW?=
 =?utf-8?B?UUtmbitNQnFJUUxSS3lNVERJUjFtWXl4ZHJZb0ZxcGlFeUxVeXgwc1pXcnBz?=
 =?utf-8?B?UlFGamtUTzh5a0h4eFpqZm4vaEhkMHlrVWkxdXBZbkhqSTlXanNCL1VXR1pJ?=
 =?utf-8?B?c1JHYm9RSjI4blhEbW9PRnFBTzM2MHQrVzFMV2dJSkEvUktxS3lhUFlxZVJh?=
 =?utf-8?B?RDEvT3N3ZnZtbVpKL2tBeEx4S2tjSGkzVUIveCtnRkxua2h1U1FaQkQvTmVj?=
 =?utf-8?B?MnkzdklBcCtWVFFaV1RoNmFWdmxKR0RtY3ZURllocW0xNDNLVTBJQVFGRXFM?=
 =?utf-8?B?OFdEZWhrRUZ2UWFPbERNZzVFNmIrVCtjajNDenF4eUpXT0s0bUxBMVRLRSta?=
 =?utf-8?B?bXZpdmgyQ3NyajNOZEVqd1JkUnhWNVRBWUVITzFSUDR2aTJpdmZtS1dFZ05x?=
 =?utf-8?B?ZUR6bW9kak9vN29EZXpucUpXejB0TkZtSWtWS1lTRVNSWnpqd2hPZWlIQThh?=
 =?utf-8?B?SW1yYXBQRmdzUEVDMmhMS1Y0TFJLV1IzZXJVUzVGWkRDeHVGcndTTEx4dmdm?=
 =?utf-8?B?VFN3bll6U3hCTDZlM25rSGNWSkZ5c1JTVE9qakx6dXlxekQ0THpnTkl2T0NW?=
 =?utf-8?B?cEJYc2k2OUt4UkRKTjFZTGF6cG9kcU9sUUxOMTF5elRnM0pKTDRQbVdMSFFT?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EABC458AF6B6064798A62F0F84242A2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9014.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b228f18-24e8-4769-2eca-08ddc8172123
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 05:26:22.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPg6NWnt9i+qNPS20jAQZfcOMcfjdRFFRSMqYleG53Bjejl7O/pr1cxqbRCgp7490fqwCvvS23npAFSn7xYZuq8vfurkCoTspM4v4DvQeoLhfEuTKqESzDQGDx3mBXme
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594

SGksDQoNCkdlbnRsZSByZW1pbmRlciB0byBtZXJnZSB0aGlzIHBhdGNoLg0KDQpPbiAxMC8wNi8y
NSAxMjoyMCBwbSwgVmFyc2hpbmkgUmFqZW5kcmFuIHdyb3RlOg0KPiBBZGQgbWljcm9jaGlwLHNh
bTl4Ny1zc2MgdG8gRFQgYmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFZhcnNoaW5pIFJhamVuZHJhbiA8dmFyc2hpbmkucmFqZW5kcmFuQG1pY3JvY2hpcC5jb20+
DQo+IC0tLQ0KPiANCj4gVGhpcyBwYXRjaCBpcyBhIHJld29yayAoYWRhcHRpbmcgdG8gdGhlIG5l
d2x5IGNvbnZlcnRlZCB5YW1sIGZpbGUpIG9mIHRoZQ0KPiBsZWZ0b3V0IHBhdGNoIHNlbnQgWzFd
IGFzIGEgcGFydCBvZiB0aGUgc2VyaWVzIGFkZGluZyBzdXBwb3J0IGZvciBzYW05eDcgU29DDQo+
IGFuZCBzYW05eDc1IGN1cmlvc2l0eSBib2FyZC4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjQxMDEwMTIwMzQ1LjkyODQ0LTEtdmFyc2hpbmkucmFqZW5kcmFuQG1p
Y3JvY2hpcC5jb20vDQo+IA0KPiAtLS0NCj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3Vu
ZC9hdG1lbCxhdDkxLXNzYy55YW1sICAgICB8IDExICsrKysrKysrLS0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvYXRtZWwsYXQ5MS1zc2Mu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hdG1lbCxhdDkx
LXNzYy55YW1sDQo+IGluZGV4IGEwNWU2MTQzMTgyNC4uY2U5OWMyZDhjMzVkIDEwMDY0NA0KPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvYXRtZWwsYXQ5MS1z
c2MueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQv
YXRtZWwsYXQ5MS1zc2MueWFtbA0KPiBAQCAtMTYsOSArMTYsMTQgQEAgZGVzY3JpcHRpb246DQo+
ICAgDQo+ICAgcHJvcGVydGllczoNCj4gICAgIGNvbXBhdGlibGU6DQo+IC0gICAgZW51bToNCj4g
LSAgICAgIC0gYXRtZWwsYXQ5MXJtOTIwMC1zc2MNCj4gLSAgICAgIC0gYXRtZWwsYXQ5MXNhbTln
NDUtc3NjDQo+ICsgICAgb25lT2Y6DQo+ICsgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgLSBh
dG1lbCxhdDkxcm05MjAwLXNzYw0KPiArICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnNDUtc3Nj
DQo+ICsgICAgICAtIGl0ZW1zOg0KPiArICAgICAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAg
ICAgLSBtaWNyb2NoaXAsc2FtOXg3LXNzYw0KPiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0
OTFzYW05ZzQ1LXNzYw0KPiAgIA0KPiAgICAgcmVnOg0KPiAgICAgICBtYXhJdGVtczogMQ0KDQoN
Ci0tIA0KVGhhbmtzLA0KVmFyc2hpbmkgUmFqZW5kcmFuLg0K

