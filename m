Return-Path: <linux-kernel+bounces-759088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA0EB1D848
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE56188C1C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DAE2550AD;
	Thu,  7 Aug 2025 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="s7VB1wuw"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA1252287;
	Thu,  7 Aug 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571196; cv=fail; b=QE/TO5uJiKelXkS/BTiD9JmIGPy+E9cdt5tc8SS/W4CfDGzArJ2p3pPTwUl8zHYrF4+3yv9650PPEtw9l5px7n71zHQ+W50uKF2fXZBr+y4mhN3Y0O/pYCa5ZLw6QGmTGku/hbG1s6RLigQSCmS3KrcQEHEGlp9a1/lZ5pZ9d/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571196; c=relaxed/simple;
	bh=uYOJEPdVLLTn7KYojoNujaBs0UWzNNL/ldR7pIOubzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UH7DG/pZFOkuN7ZXEwaYGZ7f26smiSIPyQ5lskwUYckarMkfWdXqDzg3ndmEqfjsy5bytXAU3KOd5LaqlpgBv11DimsX4LPsivo2KZ5BYIjphu6Ca+TpbeXc+suR2Y3PrYqqgaIyX1cMu4Qk3W4PN+k7f2LRvz2YcEyllkxLlZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=s7VB1wuw; arc=fail smtp.client-ip=40.107.247.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXNClSQNogmZZLGt9wCpIr18wl6i1nRIICa1twi4VoxihUiv615FaXsy85NoR+tuF5OP4UtHKgjsAVCo60aQAhpBqvdH1L1V8OgyTh2epDei58xoLL3si+7nqc2BVrwIRfaUNLAY1MQP8TIpcaz4wIYpfHpQYRplggHLbWDnxOByC5z5LqCstfzUi6NYDF92YTlCJyhsaABGAdGxv9d6yWRUrWv3CbFH9O5P0V8sS6j/Xs3p1yqgtyZAwA45LFrIbnnRXFvCTfNsKnrM0DPe88FtJ2wd6WXKzTcOFBmV35wMKcAFybD9clIiIgrL9Fy6JBN64YMkRZ8uPXjfVvaW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYOJEPdVLLTn7KYojoNujaBs0UWzNNL/ldR7pIOubzU=;
 b=QtFTo2TaPO2wuTnXe+JlOLcRwVmIDzP7PcsjzQtkWut8ZrM85rRLwhQVAKTeO2IVchS2n96JhM3xTFNV+mt+dfgkiKoK8X/YCKQImrYqxgi5iOjyklUzJ68aYrQqPa2hoJEcBXHya3SipC+JR8X7c6ZHbw9jHZOzp8YRTpRfoapQwI0CdVk5iBQ6aADRQ8nBPj5odyedcwCzL2iHJLCf1yzLBdeAV25B6HPPpUfZuFF1Sa8y8UKNUx1CpKU+k4E0mALoyXJr/7ebAnwrRPAQ2k36qT/g59rLxUETqr274GB/K5GcbD8EnEkdVXDffxbI9D5KtGzZdcs9bnYt9VDjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYOJEPdVLLTn7KYojoNujaBs0UWzNNL/ldR7pIOubzU=;
 b=s7VB1wuw37lWTFu4Mpw5t9W4Ywy37x5zAdp1W4XDYzMutNwYmWiQRXBV54MF9BPNikRhCREs29WA/H2VQSbwNcYCpqfCCknCpd6Ypip3X43FMQXz3tNX34EvH9KL/nuyTjwKlDW/wP+ndPG7twBAcAqlmvE7X9jOFmvc4D+8GeBKpI73OeBCREplwYI6RRTVk/h22ZxtkMJPqkybpjlbVQq2e0Qa5hAHsz1Wja5V7L8AwgktioZSaZCzQZnA2o23qYC64UtFKz7y8mSZBxUSCjQMGTC+Td8jXmRq6ecksTVMWJwnSN05aKvKpTEewkxEYYcIEfDE0LxMjpeT2YCKjw==
Received: from DB9P195MB1212.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:294::16)
 by FRWP195MB2852.EURP195.PROD.OUTLOOK.COM (2603:10a6:d10:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 12:53:09 +0000
Received: from DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
 ([fe80::2d26:fa56:5972:5247]) by DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
 ([fe80::2d26:fa56:5972:5247%6]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 12:53:09 +0000
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
CC: Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [Upstream] Re: [PATCH v3] arm64: dts: freescale:
 imx93-phycore-som: Delay the phy reset by a gpio
Thread-Topic: [Upstream] Re: [PATCH v3] arm64: dts: freescale:
 imx93-phycore-som: Delay the phy reset by a gpio
Thread-Index:
 AQHbzJ5IkKiCUrqPH06p42f/+549BbPiDcKAgAJsSwCAAChcgIAABDUAgAALOQCAACRcAIADjdKAgAAQWYCAAsNAAIAD9cmAgAChPwCAAAtVAIA4UzkAgBBNlwCAHyBqAA==
Date: Thu, 7 Aug 2025 12:53:09 +0000
Message-ID: <39243f47f601253ebf6e7ef30475f70ec2a932a4.camel@phytec.de>
References: <b2ea6b7f-3623-4486-82a0-cab97053a53e@gmx.net>
		 <34a4441d4b4ed8db7cac585ce93ec2357738cc11.camel@phytec.de>
		 <7f6d7199-0a20-4370-a8b0-1d05326af052@gmx.net>
		 <bf0eb48fc72f4b0abbf62077c2f1fe4438579746.camel@phytec.de>
		 <967484d9-4165-4b75-bbb7-a203c36e8beb@gmx.net>
		 <517be266ebc3b55da53372a76a139245f8945cd8.camel@phytec.de>
		 <5afa6d62-4a3f-4c28-8165-363075ac36d8@lunn.ch>
		 <a948b903766a82897e5fc17a840ab40e29f5eda4.camel@phytec.de>
		 <8e448625-b4ad-4bf1-8930-6fecdedb1d8d@lunn.ch>
		 <78ec24d09d129d52d3442f6319cf1ef5b6ce7f3d.camel@phytec.de>
		 <739f93d0-4cb4-4f1a-8792-84502d4beefe@lunn.ch>
		 <626bca58-e481-4d6f-9bb7-252c040f4b3b@norik.com>
	 <ad5e7450c5cf3a2f9a5d3c23f7219eb08be31062.camel@phytec.de>
In-Reply-To: <ad5e7450c5cf3a2f9a5d3c23f7219eb08be31062.camel@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1212:EE_|FRWP195MB2852:EE_
x-ms-office365-filtering-correlation-id: f34a0b45-7460-414f-29fb-08ddd5b15c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3RLby9vTmd3dDRsQ0hqbXAvM2o0Q3hUazh0aDN2YzYwWmplbk5haDNWWFFi?=
 =?utf-8?B?eXJ4eVcxOHRhWVZOaDN4YmQzb0h3cHNEdS85ZFQwRHVJMCtVdTRQVUw3NnRL?=
 =?utf-8?B?WnljeGxPV2F0aHljR3hCNjNNb1RIYVBNTGJmNFRoVTlrUlg1ejZoL3lCNHRV?=
 =?utf-8?B?cnU2OHY0NGFwMkdwMmlOTnlONTI3ZXlBY05Ea3h5ZG1sY0dVWHpWQWNqNEZF?=
 =?utf-8?B?TGdPS1BhTloyN0ptUnRTZlRFNHRLM2NnZVgwNmRTb29KYmdxNlhtZGFZeHgz?=
 =?utf-8?B?U0E1WVZVaGwrMkFlb2tWZEFtSE9rOXIxREJOZ2dPRSttSDdSVHk0b1BWMTFj?=
 =?utf-8?B?OTdKS0kyZ040OGNvemlXVWNxMjZJNDJ4c1FlUmE0dVRKS1pDK3RURnNhL3NZ?=
 =?utf-8?B?cE9CLzFSNVBnWTB4eS9SSVUyY2duZE5Xc0krRjR2a0lqNyttZHdwWnJyRzFF?=
 =?utf-8?B?dUQrdXVTSTFCeGVkVUdLNFJYbTc5eWdaMVJ1ZTJid1NiZm9JUE5wazNwQ3R4?=
 =?utf-8?B?QjhMUUNGSnpwMWZLbDdqTzJXOW9NWE1LMTBhanpzcnpuUkZkdUZoTTc2S0pD?=
 =?utf-8?B?YUhGMlNsMEY0NllVRmtuZDVZL29zQ1Nlb0VsUnFvUEpNYWdiU0JIQmtHempS?=
 =?utf-8?B?cDFwMjJIc2pXL1NHeWcwUEdoU2tWN251SFg5eDluNklTVGZkejNnUUdaWTdi?=
 =?utf-8?B?czhKZExUWUQwdWpZd2lZSjhjV3o2a3U3N1BOK1lhcHJWdDZndUNrK2M3M3px?=
 =?utf-8?B?YmhMcEduU1RoMXJEeHJmVFI3RmNyejBwcTVDVlg0d3FDME95aUpKVXo5R0FB?=
 =?utf-8?B?dk5PLzVlVlpSNyt4Ui9ZRTkvRE1iR2lRMElyR0tMcjNwTzZsMGNFdHpTZ2VR?=
 =?utf-8?B?Ykl4MzhMYlowZ2k3RURvalRCUDFrRTlVNlZhclQ2NnRWMEg5S05PT1hLVjN5?=
 =?utf-8?B?Z3VqUFJSaCtjZURZdFFnYlZGUWt0NXllQmhyVkszd1lSam0rQUNvdnA3VzdH?=
 =?utf-8?B?NVBPSUZFYU9FTGIyNzkwbG1kWkxTeTZxVEIwT21mREtEYXpodGhNN2YyVHRU?=
 =?utf-8?B?OVZaM3ZneGR3K2p6Mnkvd2FJTVViUVRNMjg0ME1VOHR3QlJuMlRyR3dPN3di?=
 =?utf-8?B?K1oyWlFFR3VRTHpCWFp5SnRJeVA2aTRSNFYwaHZadTIzdVE2b3Z0MmNEeFlQ?=
 =?utf-8?B?WVNsUHB6bXhpYm11OXhYZ05WemlWUFFxY1hMTTRNZDRFbjVkMmw2Z1l5Kzk0?=
 =?utf-8?B?VlQvRndYcVQwWWlkY1VEd2xCRXVWa0xzNEVQSzBjS1FaOVdKQ3ovNVg0UHRn?=
 =?utf-8?B?TUFNMkRYa3ZWTWw3Y2JEejVvTjFBTFk3QTMrMEdicko4cTFHcHNJRzJjOWNt?=
 =?utf-8?B?bEJqc05HekorTlQ5UFZ5QXU3WFkxRDVXQ1JpQktldDFxVkkwVkRaRjNkcjlX?=
 =?utf-8?B?bFpYMlFnN202dFdueHJPZkZWU0JPYTMvVEViQnI5dkdhbTlscWZGa2djUC9D?=
 =?utf-8?B?VEd2UW9LN1B1VFVWa0xpWExOWWhSVVo1RkgrdGJBNkRmY0J0OUgreDZlK2Y0?=
 =?utf-8?B?NHhUSUY5T0NHL0RaUlpqd0MyVUlSYUhwTlZSV2RxZGtIbzBCUVl0Lzd6TzJS?=
 =?utf-8?B?SDh2UTNXZWJVQVpxRlBSQ3JNN29kM3Rla2JvNU85aGkzeTByWDFjWUI4WUM3?=
 =?utf-8?B?YnlaalJrTUZ5Yk1MWWM1bFJEajdPQzRBSjVuWlQyY1p6eHdNSWpyWldGMkRs?=
 =?utf-8?B?VGZrYXZ5YmtLTzVldlBLZFRkdTlxVFMwd21UU29FTXVLNmZoalJCbEI4dE1X?=
 =?utf-8?B?a2hBUGRad0dpSmV1NElTaFlZSm9XaTZhRmFVaUo0UFprQmVFWVFBTkIvVXpE?=
 =?utf-8?B?bGRibXRraUhzSGxiRzg5Rm8zRXl4aHNidVIzdjhXQllweUQ5R2tqOHIvZlZC?=
 =?utf-8?B?c1hueDF6SGY5UDQ2NXRCMmU3a0Q3N0tZMEM1RHNPbVFURlJla1g3Rk1pSjhh?=
 =?utf-8?B?cDFFWFMwQnl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P195MB1212.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWV5Y3JIK2xwNHl3d2E3bnNKVXNxNGdyNzMyYm9KYXBkSUNyNUJWOUVqKzk3?=
 =?utf-8?B?ai9xSENMUTRFY3p1dVc0TEV1T2ZBNjNhTXlRdlpQU2dQaHBKZXRWQXFKbDdF?=
 =?utf-8?B?dDMvdFpJUlBXRC9tNTlNMUdEMEp1TkxGUzJFRjJEdlgvUGR6TWQ5bEJPWE5h?=
 =?utf-8?B?L2tvQnFyT3VmelpVc3I2M2dUN2Jod3JxWE1SeVJkd2tQUzVvamUwdUMrdW03?=
 =?utf-8?B?clNhOHVKcEtqMkdIZFpkU0p2VXhoNmk3UWRPelJyZExPYUo2bGdnN3hPRm1q?=
 =?utf-8?B?TEJ2b3BmTzlILy94YmdSRXdtTEdDUEw0QUxJN0tHWDdnMTFNQVpiS1VtcFNj?=
 =?utf-8?B?WUJSS05RemxBdDlmQUZNcjlTRERGZ1U3ZDRuN0FjRmJPOUh5N0czSnFyUldE?=
 =?utf-8?B?QWxPYmFMWmlrTEdDYmRPaFBZcHA1WG1jVlE3bkdyZGZRNHlkZUZPaVJBWjJV?=
 =?utf-8?B?Tnl5aGI4LytSUERlNkxSK20yNmU5K0l6TVduNklsUG4yOGtvYm5IaHlMeFZp?=
 =?utf-8?B?TmRmL2JieWIrcU8rVTRHZE9jSDVkZnBHdVJNMjRTYmsrSDV4K0MyR09ySkE0?=
 =?utf-8?B?RGtjbk9VdnY2WnZ4aXJYc0VTcVNJMHRhRG8zY1B6aFU5MVZ5dHZWYzJRdElD?=
 =?utf-8?B?ZnpZNEFSSWlxNkNSYkkzSkN5dGI5YWhwM1dkcS9QK2FjaGU4SjNNZVZaUWNV?=
 =?utf-8?B?UTkrM29uQlQzRUtiVnlQM3h3d3ZPdzNRczhVcC84SGxHLzVIK3V0REIwMVNa?=
 =?utf-8?B?U3h3aTQxUzB2ZjFRQTJkclkzZTEyK0FMTkovOVFKbWY1OUdycHZ1VUlPbVZj?=
 =?utf-8?B?bXFBTXlZZ1p6YTZMMlNRKzg2R1pxY3BEUmtMdmJrVFZXdHJkc3c2NmNISHNt?=
 =?utf-8?B?Y1ZIb2kvTFZvMGcrNVg2QWZnQmVUcHpUekE1VnlIZ2FvRmxSZEhZaCtPNDcr?=
 =?utf-8?B?YmZ5OS9Zb1VXY0tydzRnblhJb2N1ZFNxYXdJMnNocFhRZ2NnaERDQ3lXNHlY?=
 =?utf-8?B?WHNOK043RUVkUjZxVDFVNURxUlJyOHZWbWhZc0R0SWRhdFdjanBMdjM5Q0Mr?=
 =?utf-8?B?d3lzaGxMSWtrTHNWQlJNcFllQ1Nqd09NNFhwTXpiNGpYZnc5ZjRWbXU2MG1H?=
 =?utf-8?B?TVdLUU5qMnp6UWlQRkxuYXcvODU1NHlHcVR5c3d0eEhJYmRhUUVEUmlycTZJ?=
 =?utf-8?B?RVBPbXZrWVJncWhGK1VDS2RnRVRJbUJDRmllT2tUVWN1MGo4Z2tscmErWkFM?=
 =?utf-8?B?cFVRaVd0clRiNklaRTN1RXJyRVhJejRYVi9QNnE4N2xtdHg2VEtGRDRTUHdN?=
 =?utf-8?B?ajBXOE56OTdaVGhEQ3RRUkZ3OXUxMFN1OHh2Tm5OS3hKa3RZWVpBSENOZmlY?=
 =?utf-8?B?M0FBMEJGbi9VWkxWVm1Qc2hhZU1rZWNwSitlUWtTWlF5SXVvY2RiTVNIWDhs?=
 =?utf-8?B?SC9rNjM5Q2d0a25CNXNpdW9nQ2lpclZkclI5bXVHZVNkSzVXc2YvMDZwckRs?=
 =?utf-8?B?MUl0WW1NVTJQRmdCempFUWlhNldHMmlQWmpBNnRNZlpOb2w3Q3Nnd25LeGN2?=
 =?utf-8?B?bGxIcFFYQ082aEU1UVpaWkE0eVY3YmJKWlI5RG44aEpLaHNYdjVoajltd3U4?=
 =?utf-8?B?L1RGZEo1VVFxRWRtNDFiTzkzUzZpUkF5WUR2VXpqUmgycExmRDVvODNyK00z?=
 =?utf-8?B?cGhLN3VyZ3d0K2krQm9aV3NqeVBaYm5xV2haZGVCZThMbkhrdGxZUDlmNmRZ?=
 =?utf-8?B?U2dnVW40MThSWjZ5NWlCcFk5NW9rNXB6cFJ3RXI1MFVnM2hjdWx2ZjcwWGZB?=
 =?utf-8?B?ZktKZlRneFJKNXNtSVVWYnVRU25PTVArNGJSdmY5dWtZQmhmZnZYazlwYzI5?=
 =?utf-8?B?cW5OSEN6ZkcrRS8vTWVLWGNwczZWa255Y08zcyt4ZStoSytXaGQ3b0QrRlRh?=
 =?utf-8?B?c3dNd0ZpeXZDU0tIRUpXdE5JY1cwQi8rejJTYTF1K0N2cEpCbW9YeEJnalVE?=
 =?utf-8?B?aXNGR3RQMG56Skt6Zi9HWkpxd2F0cm5MTnFaQVc3eHU0NWZKWWpRY3p1bWNI?=
 =?utf-8?B?NEtrR1ZFdEhuaUEyVnFwUENMVk1xeW9IbHptREZtSU5venowZ0NxMy9WU0tC?=
 =?utf-8?Q?c1hUAM14YzCw8cMc9VkTvMZcs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F526776F9345814DBCA257E739BE124C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f34a0b45-7460-414f-29fb-08ddd5b15c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 12:53:09.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6bM+Yc258FspAnJeWdhjbxMttk+0WUhInqRnsujq+CG6UmJDd7M1aCqjltgJd1Ctn+cgtzR52ZtOav6vsAehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP195MB2852

SGVsbG8gU2hhd24sCgpzb3JyeSBmb3IgYm90aGVyaW5nLgoKQ2FuIHlvdSB0ZWxsIG1lIGlmIHRo
ZXJlJ3MgYW55dGhpbmcgbWlzc2luZyBvciB3cm9uZyB3aXRoIHRoaXMgcGF0Y2gsCm9yIGlmIHRo
ZXJlJ3MgYW55dGhpbmcgZWxzZSBJIGNhbiBkbyBzbyB0aGF0IGl0IGJlY29tZXMgYXBwbGllZD8K
ClRoYW5rcyBhbmQgcmVnYXJkcywKQ2hyaXN0b3BoCgpPbiBGciwgMjAyNS0wNy0xOCBhdCAxNzoz
MyArMDAwMCwgQ2hyaXN0b3BoIFN0b2lkbmVyIHdyb3RlOgo+IE9uIERpLCAyMDI1LTA3LTA4IGF0
IDEwOjM1ICswMjAwLCBQcmltb3ogRmlzZXIgd3JvdGU6Cj4gPiBIaSBhbGwsCj4gPiAKPiA+IGlz
IHRoZXJlIHNvbWV0aGluZyBob2xkaW5nIHVwIHRoaXMgcGF0Y2g/Cj4gCj4gSSBkb250IHNlZSBh
bnkgYmxvY2tlci4KPiBATWFpbnRhaW5lcnM6IElmIHRoZXJlIGlzIGFueSBtaXNzaW5nL2Jsb2Nr
aW5nIHBvaW50LCBjb3VsZCB5b3UKPiBwbGVhc2XCoGNvbW1lbnQuCj4gCj4gVGhhbmtzLAo+IENo
cmlzdG9waAo+IAo+ID4gCj4gPiBCUiwKPiA+IFByaW1vego+ID4gCj4gPiBPbiAyLiAwNi4gMjUg
MTQ6MjYsIEFuZHJldyBMdW5uIHdyb3RlOgo+ID4gPiA+ID4gSSBhZ3JlZSBpdCBpcyBsb25nIGVu
b3VnaCwgYnV0IGknbSBhbHNvIHN1cnByaXNlZCBob3cgc2xvdwo+ID4gPiA+ID4gdGhlCj4gPiA+
ID4gPiBrZXJuZWwKPiA+ID4gPiA+IHdhcy4gQXJlIHlvdSB1c2luZyBhIGZpeGVkIElQIGFkZHJl
c3MsIG9yIGRoY3A/Cj4gPiA+ID4gCj4gPiA+ID4gSSB1c2UgYSBmaXhlZCBJUCBhZGRyZXNzLgo+
ID4gPiA+IAo+ID4gPiA+IEJ1dCBpc24ndCB0aGUgYnJpbmd1cCBvZiBldGhlcm5ldCtwaHkgaW50
ZXJmYWNlIG9uZSBvZiB0aGUgbGFzdAo+ID4gPiA+IHRoaW5ncwo+ID4gPiA+IHRoYXQgaGFwcGVu
cyBkdXJpbmcgdGhlIGtlcm5lbCBib290LXVwPwo+ID4gPiAKPiA+ID4gTW91bnRpbmcgdGhlIHJv
b3RmcyBpcyBzb21ld2hhdCB0b3dhcmRzIHRoZSBlbmQgb2YgdGhlIGNvcmUKPiA+ID4ga2VybmVs
LiBCdXQgaWYgeW91IGhhdmUgYW4gaW5pdHJhbWZzLCB0aGVyZSBjYW4gYmUgbW9kdWxlcyBsb2Fk
ZWQKPiA+ID4gYm90aAo+ID4gPiBiZWZvcmUgYW5kIGFmdGVyd2FyZHMsIGFuZCBvbmNlIHRoZSBy
b290ZnMgaGFzIGJlZW4gbW91bnRlZCwgeWV0Cj4gPiA+IG1vcmUKPiA+ID4gbW9kdWxlcyBjYW4g
YmUgbG9hZGVkLgo+ID4gPiAKPiA+ID4gPiBIb3dldmVyLCB3aGF0IHRpbWluZyB3b3VsZCB5b3Ug
ZXhwZWN0Pwo+ID4gPiAKPiA+ID4gSSd2ZSBzZWVuIGludGVyZmFjZXMgY29uZmlndXJlZCB1cCBm
cm9tIGRlZXAgd2l0aGluCj4gPiA+IHJlZ2lzdGVyX25ldGRldigpLiBJIGRvbid0IHJlbWVtYmVy
IHRoZSBleGFjdCBjb25maWd1cmF0aW9uLCBidXQKPiA+ID4gaQo+ID4gPiB0aG91Z2h0IGl0IHdh
cyBORlMgcm9vdC4gSXQgbWlnaHQgYmUgaW4gY29tYmluYXRpb24gd2l0aAo+ID4gPiBpbml0cmFt
ZnMuCj4gPiA+IElmCj4gPiA+IHlvdSBoYXZlIHRoZSBFdGhlcm5ldCBkcml2ZXIgYXMgYSBtb2R1
bGUgaW4gdGhlIGluaXRyYW1mcywgYW5kCj4gPiA+IGFyZQo+ID4gPiB1c2luZyB0aGUgInJvb3R3
YWl0IiBvcHRpb24sIGl0IGNvdWxkIGJlIHRoYXQgeW91IGFyZSBhbHJlYWR5Cj4gPiA+IHBhc3QK
PiA+ID4gdGhlCj4gPiA+IHBvaW50IGl0IHdvdWxkIGZpcnN0IG1vdW50IHRoZSByb290ZnMsIGFu
ZCB3aXRoIGV2ZXJ5IG5ldyBkZXZpY2UKPiA+ID4gcG9wcGluZyBpbnRvIGV4aXN0ZW5jZSBpdCBp
cyB0cnlpbmcgdG8gc2VlIGlmIHRoZSBqdXN0IGNyZWF0ZWQKPiA+ID4gZGV2aWNlCj4gPiA+IGFs
bG93cyBpdCB0byBkbyB0aGUgbW91bnQuIEF0IHRoYXQgcG9pbnQsIHJlZ2lzdGVyX25ldGRldigp
IGlzCj4gPiA+IGdvaW5nCj4gPiA+IHRvIHRyaWdnZXIgYWN0aW9ucy4KPiA+ID4gCj4gPiA+IMKg
QW5kcmV3Cj4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gPiA+IHVwc3RyZWFtIG1haWxpbmcgbGlzdCAtLSB1cHN0cmVhbUBsaXN0cy5waHl0ZWMu
ZGUKPiA+ID4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byB1cHN0cmVhbS1sZWF2ZUBs
aXN0cy5waHl0ZWMuZGUKPiA+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gdXBzdHJlYW0gbWFpbGluZyBsaXN0IC0tIHVwc3RyZWFtQGxpc3RzLnBo
eXRlYy5kZQo+IFRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gdXBzdHJlYW0tbGVhdmVA
bGlzdHMucGh5dGVjLmRlCg==

