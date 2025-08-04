Return-Path: <linux-kernel+bounces-755200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B885B1A2F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209A01884D06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6828B25DCE5;
	Mon,  4 Aug 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="rDIzyHDx"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783538D;
	Mon,  4 Aug 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313043; cv=fail; b=Gcb4C+NudyOdymWyYXzWqLmof1LYcZbRqlRM2CIJpYJ0kV/pVDjqTVeERcgc/DjLXcDFE9SxV4B2DioDxwr+pYPc7hUAvLe4fAZDuy0nh4cpnuO5eV4DvmB9tkWJKgvcS9n3MOCVa+zCPfwPmsXlJq1Wv1fVqgjrRyImPitya/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313043; c=relaxed/simple;
	bh=+sByoKxKYd0XrD29l/E9BOiVSCQkqItu/G/WlGz0nQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scOnr51kku2zS6EaRQ/1gnK6gYb2JdwyIJWgyOJPImO64LeamHC6O0UWPe0MHiiKhGpQp8QuCEwttoM0ID+ot7B0A6Xbg7M1hveibosw/1ULp/f6vNi3VOWGGBOiAWGyVHZ7LzwfUpfpR08o5sNsQRYwc3pEJzs3Q15lsF9JIHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=rDIzyHDx; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIRH4VnFkDfKzSYfpMH+pu80290DLwM5DV+W3ryiUg0kBmJUe8Z55Icnrd2IFtBIRZNF88dClzLmwaz8EqZL8Hv5I42kYoj1k35TEdUrFwaiILE6jGFXVvVsnZZC8NmIPuFDoam0g34xSUN4d00NP6K2zlfp/FRjSNA3dF067Q7j1Rg0PaDSYXTXuKLk8ZBEWk6/mALN4oFo2EDwL5Sq0cosx5ZS7ieC4czR18QQYQUCO1LlN+6Jg24nMqyowFwHbp5pgdzTOGg1Ev8BYI9xmvloYi3u7g65FIflWPRIJFUjO0/46azjYnDWAIhurxejREn6/Gl2E1qJk0GQslP7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sByoKxKYd0XrD29l/E9BOiVSCQkqItu/G/WlGz0nQE=;
 b=XT4/QkE6N1xbNKE9hZfnR7rgu/2alwx1cUwTwBdqMf9XbKColC4dYhE8IhN5Fri4pIIvuEoP7tPI5cLykl+TzCyFwviJ/BkNQESMStltnEqKEOkuC2Woi8QggufFa88FULJTNUHUxGARJ5WxnLzrI41kkjZBS0FGDxSJg6xI1PbEOzL3cxnGSppCuVv74E75h1QbWUyFPjXYBn6Viig/FeNyRXF9yn0Z/IZGMWw5SfDtHacEfVL1XydFE1AOq6nCm8LkRrolS0WwuP1jHmB3KL23jmSfLcE6h5nwtnDlJKA1UJfnsKFdgiduPJkJdFLtykynJ3GISeDT36TGOAnGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sByoKxKYd0XrD29l/E9BOiVSCQkqItu/G/WlGz0nQE=;
 b=rDIzyHDxVUL1x0CJVBtR3uyuPkjdG1CHVWPK2bLfyyeMF7vwaVFeL1NpG6yH1cYJo58uBm4zgVzGZ56DZZ3q8xjrJjpwqOnNg7wE5AXZaxOTaRPoo6O5JkUZgWBDVQ34/dOcljvUBYbR5lMVSTkEnFmsNLU+9mSLhJaUUqjKMNQ=
Received: from SA3PR04MB8931.namprd04.prod.outlook.com (2603:10b6:806:381::22)
 by MW4PR04MB7218.namprd04.prod.outlook.com (2603:10b6:303:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 13:10:39 +0000
Received: from SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d]) by SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d%6]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 13:10:39 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland
	<samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Min Lin
	<linmin@eswincomputing.com>, Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Yu Chien Peter Lin
	<peterlin@andestech.com>, Charlie Jenkins <charlie@rivosinc.com>, Kanak
 Shilledar <kanakshilledar@gmail.com>, Darshan Prajapati
	<darshan.prajapati@einfochips.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia
	<a-bhatia1@ti.com>, "rafal@milecki.pl" <rafal@milecki.pl>, Anup Patel
	<anup@brainfault.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [External] Re: [PATCH v4 0/7] Basic device tree support for ESWIN
 EIC7700 RISC-V SoC
Thread-Topic: [External] Re: [PATCH v4 0/7] Basic device tree support for
 ESWIN EIC7700 RISC-V SoC
Thread-Index: AQHb3rESAJnHCmMu6EuhdqV2JGFLn7RN4TKQgAFx8wCAA2+O4A==
Date: Mon, 4 Aug 2025 13:10:38 +0000
Message-ID:
 <SA3PR04MB89312063FB96E85ABB6F3D3E8323A@SA3PR04MB8931.namprd04.prod.outlook.com>
References: <20250616112316.3833343-1-pinkesh.vaghela@einfochips.com>
 <SA3PR04MB8931098CC4A73E8FDD481DA78326A@SA3PR04MB8931.namprd04.prod.outlook.com>
 <2ed69301-f787-4257-8d44-a8544c1a43c9@kernel.org>
In-Reply-To: <2ed69301-f787-4257-8d44-a8544c1a43c9@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=cde35d9b-f522-4197-b54a-a4a98068453f;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2025-08-04T13:02:33Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR04MB8931:EE_|MW4PR04MB7218:EE_
x-ms-office365-filtering-correlation-id: 644561eb-37e7-462a-762b-08ddd3584ed4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnlXRnU4aFp0QU8zN3JYQ1d0aGNkOGpHbXhzZ0tWVm5sK0xHb0pnaTNiQ1hP?=
 =?utf-8?B?cXM1YTVsRkNNOHBuM2t0cHpyb0VtRitTRXlNZGNYZUZXVGdOdlNDMGlTelJu?=
 =?utf-8?B?ZGlabisvaS9udVBCU2c0bFd2Y1JPdkkrcFFSZUxhK29vS1ZkWlUzZys1UE13?=
 =?utf-8?B?amVuWTUvRTlya2lOekxWSjk3dHorTmVnSk9CUVNwOGdiSXlENXh2WEgrenY1?=
 =?utf-8?B?cFBNd0FzWEdFdUpFeFJhRzFpc0pWV2k3ZXJIeHJEZkd5TG1ZbGhTSy9TcHNo?=
 =?utf-8?B?RFR6cmFUbm5jSjJTbU5WZENhN1FVTmo1dHBtYklNT1JyWEVCOHlFSkhlVEFT?=
 =?utf-8?B?OUxkOGkzL0dDYjlpRHZNZ0g5RjVvVG5hdTFyOXZYdGgwVmU3RXRZTTBKeVdp?=
 =?utf-8?B?eEhHWDdrLzNZMHVSb0RxQ09EZFRFdlRVVEtvQWMyRVBoeEtnbkFKSTdaRy96?=
 =?utf-8?B?T0NidVdDanJsU2dUQ3M2RFRTSmFDdjZJcnRkWkIrQW00V3lxT1VpcEw5alpS?=
 =?utf-8?B?MjV6dXNxZExTSGdZdlh1aC8vZUF4b3dpSm54NmpkdW9aeG8wN1ZkY1Z5ckVq?=
 =?utf-8?B?Qkh1Y092QmdIbG10b0tSWHh3OHR4OEtFWk9EWFoyakdrSVROcXBJOHRkRGNF?=
 =?utf-8?B?cWNLbEptT3VGcHBuMjhScXlDOTdCZTM1MkhJYW9ZbXpOQlJGTnRDcjVDdDJW?=
 =?utf-8?B?Wkl4M3d6bW1qTWpIaEdONG55OVJDQTBZVHlJRHdkbEFkUVlNTkZOemdZS0lS?=
 =?utf-8?B?Wk5sWllVTVBBb3JaMzRySFliNk1DZk5ZVW5pNTJiSTlEamRMU3M2S3lXWHBx?=
 =?utf-8?B?OWpaNFpXUnQwWkFnRTBrQ2o5ZHFWc3QvWlp5TXI3MEhpaTF6QldKVlM1ajls?=
 =?utf-8?B?eHpQVFduSFBtdkdiWHpHQUkyUHdVeUZwdnZKRTA0UDR0eDJOK1hHdXpsWHM5?=
 =?utf-8?B?RkhjWVVwV1BFQWhpWlgvYndDMmprVUtTTndPVmVEelY0b2dKYnJHaGNVVWZC?=
 =?utf-8?B?TWs5REY2TE02KzVXMk02SFlxbVJCNE81ZU1odThwa1JSakNiS0JFc09wY1VE?=
 =?utf-8?B?cWxqbEU1Qk8yeXJBVXA3emYzM2U4MVRYS0kybDlORzV0Yk8vbW04MTV0WnRP?=
 =?utf-8?B?Rzg1a0VLMUYxSCt0cEhvVXRHYnFJQUFXNlMxSm9OWlVMaDJyd2pVUFhRRC9N?=
 =?utf-8?B?NTUxWkRxMktFbG1mWlJQRHkwR1E3cGltZ0hvbzNzNkpDeldJeWxyNlVZcTdQ?=
 =?utf-8?B?OUhkVDl6ZGJnRkpZT3ZpTEduNmdvNHhvUEZrQlM2Q1JCcGJsQUt5UEJOV0Q1?=
 =?utf-8?B?b0k5NU1Xc1c2b0dIRXUvNFdDdENvZlhZM01SYkVMMDh4RnBUMWZWMitWN1Ny?=
 =?utf-8?B?NzdIMDlXeVoxOFVGakp2L2gyb1BCSS9oV29TQ294SmJraGZWRldoZkdNVkhW?=
 =?utf-8?B?REE0K0hYQmYzbUpKNGxZanJSNkNRaUlkcUwvdWFPb05RNzh6ZytUMW9Fckts?=
 =?utf-8?B?QWpoUHpGNUt6MVVQU0VXeTlyOEIzWVZnTFA5U29QT055SUg3cUQ0S1lMY0h5?=
 =?utf-8?B?akt6UFB6S0FFczFlVm53VThiWEk5c3hOYzE5bUw5TEdiY3EyM2F0UGJ5MFpy?=
 =?utf-8?B?aU5yNnVQbTVIa3FVQTVTYThZMUFEa2VnY1RoWklFeTdmeTBvblVlTDJkblZo?=
 =?utf-8?B?MWtGVXZkK05hNXJCbjdvdFluZ3IybXdKN0tvTDE4ZDV0TkkvdDY4M2RBRFJB?=
 =?utf-8?B?L0xsOFBDaHc2aWVIcDBvaThmTjJLcEZ0QU1ka0E5WjI3SmhZYmZMakNibzhB?=
 =?utf-8?B?R3BLTTJWb21hVGJlOE5CYXl1WkV0dGUxblFQdFpmMm5KeTVHaFFLR3hOZlFS?=
 =?utf-8?B?WWdRVVQycnJheWsyNXQ5cnVLbXMrbVUvNkZqelV2d3BZYUlKcTNqdXpONFVS?=
 =?utf-8?B?UWttK1BUQWFHd3U0UkVVenkzUWRES0QrL3JWQ21RWUY0Q1MwajBEeWl5K0ZC?=
 =?utf-8?B?c2ZSa2RSSVd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR04MB8931.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2p3My82bTEyS3BHVFF4VnA0YmdsUElCaHBVQ25mVFAxSHZvWGt6d0ZOR3BG?=
 =?utf-8?B?Ym9UUHBQaHQwTWM1SkJHU28rMHFmM010aUlGRmQ2clhhaGtXSGsrVXRWMEpT?=
 =?utf-8?B?ekZOLzNlN2txNERRbHhmb2tRVmxLYmhzN3dkcjgwcWw1cDhJK1pDZmVDYml4?=
 =?utf-8?B?bERpRnRxZ3UwTnhBb2N0TXFLOS80QjNYT1krdUgxU2JBSmd3T2NNWVBwTEcv?=
 =?utf-8?B?N01oUWFUQnlFdlFjczZuQlBVSmpFN21zUFVoc0FvTGcvUGZmYUh3bXFHN3lj?=
 =?utf-8?B?Q0lualMyUXpqTHRhZU9mNG5ySjQraWx3VnJTdEpocFJnN0wvOVRzSmdhajNV?=
 =?utf-8?B?S3JPOGxVTU1OTFBZc1ZBU0plQ3I3UVpXa29hZnBlb3JHdjZDRlk3Q2lTU2VM?=
 =?utf-8?B?Wjg2SXFjblRIU3BDdlM4MENPazhldWhKaFNta0ZBdFBvSDdlNHVHRThvVE1r?=
 =?utf-8?B?dUZnbmdUdm5uSjBoQS8ybC9SZXRsNmwycjZncFNmSjZDWGlhNDF0UlRGQXNy?=
 =?utf-8?B?bVlKcHdoZVVxNmRXRVZvdjFFSzdaanQxb3RWdzFTdU10NGIwTmRDVEJDVFJ4?=
 =?utf-8?B?YzVjR3kvWHpBbVpOT0VSNFpSMVZvdy9iTnZQN2hRVUxDSnY2M0ZkdG5DdWRT?=
 =?utf-8?B?VTJYNlloNDBmUTVJbklpL282YUc1blZwMEkybSt0dzNFYmZUTmJqZXJHUFFL?=
 =?utf-8?B?MEJTNlo3UEYzdEgvMnRQNjl0MWZLMmd0bzNjT0x5V3ZCS0d6dkRzMGxBOVpL?=
 =?utf-8?B?T3Q2cWY1bDd0VW5LK2hibDl2RVhPK2x5SjhBcWs5eGhhS2ZUQUZLZHNiWFhR?=
 =?utf-8?B?NVJ3U3orWlRILzBLalozbTJ0Z25qSUkrOFdnd1g5OUpWK2haNWtFRDJ1U3JO?=
 =?utf-8?B?d3AxZ21oZGtlSE92dERKOGdGTDJjZkhHZ0RhR3pkU1lmMTBMUGR6OGFueGhi?=
 =?utf-8?B?Z2lYdzZ0Rmh0QlA4T1RXdCs2aDZyQUw1U3NEdERxa1NZSWNrTFpmOGc5K3Zs?=
 =?utf-8?B?bnBJcGI4ZWhwanI2RkU3MzNURkVMRjlkOE1RM3hDZ0FQdUJMdFMzZVBlUVZW?=
 =?utf-8?B?eTllTjhKWW9MdHF4cVMzT2dvVCtYUHRNWjN2VVNMU1plcFpHU2cxZVZQSG1Y?=
 =?utf-8?B?VUVsRzk0dmZrR2NYL0w2OHUzTEpQSTRPWFZha2crMkFhamJiTitpTGNNLytz?=
 =?utf-8?B?eEZpWmg3bjFaSGNVYlQ5USt1dXBXMS9mL2RKc3NRVEZka3k4c1o0bTcrdGgv?=
 =?utf-8?B?MXkzakxvN3lSYjBmUmRBSnFvOGVCb3REK01ncGFjcnZoZlJtd0NmTGhpRm1L?=
 =?utf-8?B?S0hTYnlIRUNuTE1xWkJzUkFHWE0vd1JUSUQ5SzB0WUJhN2NDMjdFWnhNNGtM?=
 =?utf-8?B?MGM5UWNjMXQ3WXdTK2pqYlJTdDRXNGVQdHlNYm9zMkdVMHFHNXBJRmlaTi9k?=
 =?utf-8?B?b2dvNTRCMmFzRUVHSmJPd085aUpabXR1TUVGVUl1VThlN1h0eGMxN1FkMm03?=
 =?utf-8?B?YVVVWVZZWTNRVmhCUmtyVVdqVTdDck1DaXdiQTJGeWpqekQzdTM1alNvc2dt?=
 =?utf-8?B?MVpGYUUrNVF2N3kzdVJidWs1N1EvVkwwQXVNdHdEU3F6d0MrREZEbVB5K3ln?=
 =?utf-8?B?eXkreFhYei9GUGZJY0lEWUhSdzNqOVFyak55NGthZjlGeE1SZHlZOE95N1FH?=
 =?utf-8?B?QzVMNkhSMFFsWGJvamprVVpGUFJVclhkaUdqWmJhd21wQ1BmUDNaWCtZR01l?=
 =?utf-8?B?WTFrWklEOHl2a25rRFc1T2FieW0zcFRveXR5aExUejFZWnB6b040K25GeXJO?=
 =?utf-8?B?citoaGZHWWRwNW1CdllBZUpMK0NrU3FRTkhvNlc1QUI0YzcvcFVuelNIeVM5?=
 =?utf-8?B?U2VId256VUxMeUNNaVNhelJ5aVhVK0tMeTF6MVUyN2dEclI4OFJSM2c4Z1hH?=
 =?utf-8?B?RFh2NktXZTQzYk1EUmRXRGZyOGRsdEY3ZmZRaTY4ZmxlTkVWaW1YOVhaL1Bs?=
 =?utf-8?B?WVNuakt1SE1uV0UvbUJEN1JBYzk1emtDL3VFTkkxRWdWYW9RTDJnVEczeWV6?=
 =?utf-8?B?bU96MGRiR2g3SEM5cnk2anhndzNhUXduL1VkOHFiWTN2VTlOZlgwMlJTbzZR?=
 =?utf-8?B?Ynp2L0RQRG8vdGVMUkN4RWR2WmRQcWVJaWhVM1hMR09ya09UVGZvWXhVYklu?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR04MB8931.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644561eb-37e7-462a-762b-08ddd3584ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 13:10:38.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4Lab2NADvg9Y0IWuZODQ/xFSTtm6gMT9tVuuHP/4gHlPuMnq7jdU02Dj7pF2DC7/db+wrrar9qOlcfn2LYduuqo7CUoAxkrTYBZXv5E5n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7218

SGVsbG8gS3J6eXN6dG9mLA0KDQpTb3JyeSB0byBib3RoZXIgeW91LiBJIHBpbmdlZCBiZWNhdXNl
IHdlIGFkZHJlc3NlZCBhbGwgdGhlIHJldmlldyBjb21tZW50cyBvZiBWMyBpbiBWNC4gQnV0IG9u
IFY0IHdlIGhhdmUgbm90IHJlY2VpdmVkIGFueSBjb21tZW50cyBzaW5jZSBsYXN0IDYgd2Vla3Mu
DQpDb3VsZCB5b3UgcGxlYXNlIGxldCB1cyBrbm93IHdoYXQgc2hvdWxkIGJlIHRoZSBmdXJ0aGVy
IHN0ZXBzPw0KDQpSZWdhcmRzLA0KUGlua2VzaA0KDQpPbiBTYXQsIEF1ZyAyLCAyMDI1IGF0IDI6
MDUgUE0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDAxLzA4LzIwMjUgMTI6MzQs
IFBpbmtlc2ggVmFnaGVsYSB3cm90ZToNCj4gPiBIZWxsbyBBbGwsDQo+ID4NCj4gPiBHZW50bGUg
cmVtaW5kZXIgdG8gcmV2aWV3IERUIHBhdGNoZXMuDQo+IA0KPiANCj4gWW91IGFscmVhZHkgcmVj
ZWl2ZWQgcmV2aWV3LiBEb24ndCBwaW5nIG5lZWRsZXNzbHkuIE90aGVyd2lzZSBpdCBmZWVscyBs
aWtlIG91cg0KPiByZXZpZXcgd2FzIHdvcnRobGVzcyBhbmQgeW91IGFzayBmb3Igc29tZSBvdGhl
ci4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

