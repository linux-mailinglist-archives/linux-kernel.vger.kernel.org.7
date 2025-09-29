Return-Path: <linux-kernel+bounces-836866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF4ABAAC19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5E0420FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31936263F52;
	Mon, 29 Sep 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Qiug8ibe";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P91AD5Sv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UdRGrBZ6"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1141DFE26;
	Mon, 29 Sep 2025 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188859; cv=fail; b=URwMc+3SXTz8jsQNdiymB/574PjXDXLY//73Mee33EXT2kTUI3IZDX3csEz30CQ7s5J/QPD/i2q7guh/bbCXdS/N0gUFlQdhPBOakwg1JTW0Jo01BdNsJBzUyHvmjWZ439c6ET7JBeZulmPdJp4FuWjL8RnSQ7MyHXTDYoW1Mck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188859; c=relaxed/simple;
	bh=peSkfE19trhR39rb6m2KN0HCQlOWmz9vVMCFdWv12D4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H3qmcjaCBmwl1wVdKfeXy2JpQ48j/9Y9wAxfM9xCQSEagpr+s+IgL7+UZdFz89JDkpwgyx+ELJToiLGVlWHmqlwPVko7O+YChRCYF2AclSc38r0CYcQHsLY6HU8BYBwpn63gxieUwH0z9mWaOaULHs29Z5UbNtLhvEJRkFUSZ2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Qiug8ibe; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P91AD5Sv; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UdRGrBZ6 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLHXSw002293;
	Mon, 29 Sep 2025 16:33:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=peSkfE19trhR39rb6m2KN0HCQlOWmz9vVMCFdWv12D4=; b=
	Qiug8ibebrbHqmk6Gl91OpDnKF399SzGjw61f8TRMoCpb8ivUFjVKayt5CGjOb7x
	zojrvB3vlz9av7odFqAu0jflVCSsgFsiDitRCKtW98CBCTDpzaCLYCNRoQdXEpaU
	8WcCyl7OjHwyJmDUjcKWF/Os4rV8iZ8RCYii2JOf6232e5gUEX4AhVzMRxrNiNXs
	wYRGbCBKaCd4chX03EMBEJ4gVmgKEDgEVytPva1gQjM8/L08agZSawUxh1L8Jtoj
	j3eZsdxlCTCR6rUJg601La4RDGzl/tuNnfO9NVJ3OYRZUVm2ui+sjJL7xlm0rRDj
	y67LStG7E97q1VnHzWDGiw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49ef62gtdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1759188806; bh=peSkfE19trhR39rb6m2KN0HCQlOWmz9vVMCFdWv12D4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=P91AD5Sv5zSndK6ViCFKmZ6G8vqVJ4ExmV9kkHhHx+yshJWA2mseWNInVjyNtfAL9
	 rABMv6HSq9b256F8qIDzTnRHT7pahcS9NpzBLfiIsBzhicgFhscuxyXOs5lhM+vtsM
	 S9mlpnOHoaKQIlhfJdEsGeVt/5zUVp7+CQsAENc8qA+YyPWTVlA3D3LRvzrvxGMEoQ
	 cL4oEg4asMqvqfOHDFHAkkV4pU6CbED04zlxjBCX6I3SZ9codopmrxII1xhTiUDKqy
	 TgJb+6XRyBLn5jIfwPzJZlOPYQBNbe/Y8Mg9CmxUB2oSWyLpykAAylN8Fp1Xmz8/Bi
	 QWjB09VCeqoBA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 06A3840237;
	Mon, 29 Sep 2025 23:33:24 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B9640A00BB;
	Mon, 29 Sep 2025 23:33:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UdRGrBZ6;
	dkim-atps=neutral
Received: from BN1PR07CU003.outbound.protection.outlook.com (mail-bn1pr07cu00300.outbound.protection.outlook.com [40.93.12.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0CA2F4054D;
	Mon, 29 Sep 2025 23:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFtIWYWzcM7y3n2Fsld2bTfZX+GsC+lUCxVLdd4hL6h2fONGcl48gYxjWP/aF1ZNpbqibNS6abVkwa+Q/9czitANo+ZJ8PMS5QTXacwDvSI9prsEu7J+/2cCF0siIQZsbI5c8hPTiBQ2+UeoGqO1xn6vBeTX3p5Vb12eegWWR+RaD8J7OGL/kgfmo0HdTNw0C77UsBdJ2VThsYgDnCbbyszEp11oPEmEXSjXnKnJq2XI8ImXmbL1N9ZLS9aqa0/E0tqSrrn8lKbj35Y3ZOHtLkxEujNyRDxAXQBeczA/Z+te2dMwrwS9hihkWXvlKaXttm5IEWM7t4OeF8+eYAEBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peSkfE19trhR39rb6m2KN0HCQlOWmz9vVMCFdWv12D4=;
 b=mRYuEJhTKLoks7PoR1QfJhc+mh7A4ks+vnKFKEg6/JID1S451lInLBk2TP5uXDmDH+qgQLnQFHfOiuzGVOdFtvyXVrgFs0JbLrkaeug/VZnVC/WcHvPkmPTWVZWOcA6uUJk6MOklfdOw3V8XjmtK8c7CdL5jSGse3fqa+yQpjPSpc8im9IqyaY1AqTbySmMXwXm0udNUM3PAazEbHI21lqpb4TqZzvrSEW0MyYRgoWrudgvEoP0H0Rhf/osslvTB5X2BVOkjk0xa06dUt+u1xhzHylc5ZHTlwLl7/RkF1toA4Lo8yOKpU8iP7XvYkHJX91Kc4H3yhhJcQdxQekpHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peSkfE19trhR39rb6m2KN0HCQlOWmz9vVMCFdWv12D4=;
 b=UdRGrBZ6PP0FwfbHmardTNUNfTMIZVDTOKNCrcAsyZ8wU3d75ioXUBGeWr0WpHumhFgmDVlol5/UJsQU51lstno0d+i7NAhy1Rt6/J3g7QDfx/D5nt4/s0wnXg7wMxnv46GaOHihIwb/YNboJBeVqRhJpacbagrDRBQXq9BaT6s=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 23:33:18 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 23:33:18 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v5 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Thread-Topic: [PATCH v5 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Thread-Index: AQHcMUzQQtYFoVbWSUKOJXp6DJh+z7Sq0DyA
Date: Mon, 29 Sep 2025 23:33:17 +0000
Message-ID: <20250929233311.een2ii6t4l5jnezq@synopsys.com>
References: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
 <20250929-ls_dma_coherence-v5-3-2ebee578eb7e@nxp.com>
In-Reply-To: <20250929-ls_dma_coherence-v5-3-2ebee578eb7e@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7563:EE_
x-ms-office365-filtering-correlation-id: 72d01367-f9a9-4390-aa2d-08ddffb091ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkxhNzNsOE9NbHVtTGlFL0hId0JFcWs2Y2RybEpKckJmR1BUdUgrcTF5d0xI?=
 =?utf-8?B?cElvdS92bXhmWVRhWWExWVltWEdhVDRLMDNRd1lJL0xkZ2trU1JCRGRaM1cv?=
 =?utf-8?B?SXBqREdRSFdObmszalZUTXVhNE9RUVV2UWFCMXlWcHoxRW45bDRnZVovL1Ni?=
 =?utf-8?B?eDN1RkhIMU9Yck9CS0dIRXdldDRMRjY3Wm54V29YYmVtbjdrRDJ0ZUlXOUlu?=
 =?utf-8?B?OEtPVVdTMDhOQnJvYzhkcDFoRWI0T2NKdlJtbjVvcVdLclBTQVp0OU5XSDBQ?=
 =?utf-8?B?aTYyOUgrUlE3YTRXOHNoZUQwdTY4U1dVOHNkLzNzOWZIelNXNFdCOUtMWFl2?=
 =?utf-8?B?TzB6RmV0NXg1UDJHMExkUjVQUXBnZTYvS291QUFOcEJZTUMxYjlIZGhmdkZW?=
 =?utf-8?B?ZzE5citqVzVCMHhaRXRLb3ZyUkhjRGc4Z002YXl0Sm1OSHo4VVNCb3N4ajl0?=
 =?utf-8?B?c2dRNkFEWCs3dnVXbWppczAxdVBiYlpiUmZQVnNXRlZkcVc0VVV3SjNoWG1m?=
 =?utf-8?B?YXJwR0NvWWZzM20wdFdHYis1bEh1SENKNXNOWk14em53V0RlZmtnWVpmODFD?=
 =?utf-8?B?RDVtdjkvcEY0YjVkT25aUzlxYURQRWlKMWIrVzgrakRVYlRpdmVleXFNWnRR?=
 =?utf-8?B?YytSc3FzOTN4cGdhWXU5QmpVTXpvckF2RjhHT3gvZmlKME1LVFZ6c204MTV4?=
 =?utf-8?B?aVZvdXlGcDhxb0tjY0dQMXJobVhkdHRvbFY2YzNNa09rL0VTaFBvME9icVBR?=
 =?utf-8?B?Rld6SUVsWjZ5SldLU3FWMmVYbUN2aDZRMEJ1ZXNWa1U0WXJXcUZSNHRVcDhk?=
 =?utf-8?B?MW5rVHFDNGxTQ251QVFZV1JVN2dqMzcrbGRjSkJtMHMyT2s3VDBkYlZPU3E0?=
 =?utf-8?B?alZRS3hhc2l1UUY2NzhHclM0UGZRYXM3cG9KdHVhNU9ZSE9YbUxrUGplcDkw?=
 =?utf-8?B?RUVwaG1MRmV1ZC9kZFp1RGRlTDBkOWtqZyt1YVUvbE1PRHdWRVppeXVKZU1R?=
 =?utf-8?B?MTRyZU9aVy9pUHRyNldkcVFwTWYwU0FvMy9FeWN1bHhqSTFhTDZGUzFlWnlO?=
 =?utf-8?B?L2hHSWx5b2hwTzAvK2hDNStpbXo4clVNajRVb3pEbURocWZiU0FKUlo5MW9Z?=
 =?utf-8?B?eTVKVHpiRCtIQnBLUmZIYWxFdmVybGJWMGtvUEM3U1JWaEdFV0NaQytPdVBr?=
 =?utf-8?B?UkU5ZnpjclVCSDVyK3d3L09rVmlXWW82NU1LcXFEVzg3amJHYVNZZVJpR2Nx?=
 =?utf-8?B?SFR5eSthcnBOYnl5Y05Pdld0MXBSZzltWTcvRy8rYkNCSkxCVlJXRVhiYk0z?=
 =?utf-8?B?ZDJwaEkzYWFTUTZrd2trT0Y1eElEdndKSVZWdHlkQlJqTmJ5ZWZWV0Y1R3E0?=
 =?utf-8?B?c0tla2tMVmVha3h4bjVVK0NzQTFmd0dxSmw2OWFCcWJRWTEwb05wNEVaWnhY?=
 =?utf-8?B?SWhseG4ySFJkRmNCdi9tUTlXL1lnak5sYlR1MWhnQmY2eUZXMkQvaWtUWjRk?=
 =?utf-8?B?a2tTSVFmNnA0QU90elEyN3B4Z0djQWI0YmxWZjJubERLZG9xS2lxNm1vTmZO?=
 =?utf-8?B?Y1pSMGk4eXYwZFNYc0ExTXRhYmJCUmF4clg3aXRVVWQ1SkxJYzNUWE9yRjNi?=
 =?utf-8?B?S1hlYVFFL0dxNE9nRWVyeTlURUJoNjMyS2I1Y0h6MzJLSTN2Wk1kdjlBUDZZ?=
 =?utf-8?B?SERTMjIvM2NYQjJBTGk4b2MweTMvSktSN3lEb1BkU1djQ3JhZVAzbTBiVitF?=
 =?utf-8?B?OEFoOGVuQVdhN01HRjd3MjBOc3dQZ1N2eVNEMXdYZG0zYW1ha3B1SEhsUE01?=
 =?utf-8?B?UXBHbmNvYzUxNU95WDNFcGhhZXFPbkhnbWtzOVBOTDNxUHh6OUxTY2pVNEtZ?=
 =?utf-8?B?bHQwOVhtYXo1ZUpXM1BVV2dhNVlmOWF5MjUxRW9lT294cjZvQ3YrQ3VGeG1P?=
 =?utf-8?B?T01vVTI0Wk1yVWN2OTA5dVgvZWFqMmdOcCtuRzZZNmdxeUgxM3k2YUZYOWU1?=
 =?utf-8?B?YUVMd1hFL0dPQXk5a1N6R0hOb0ZYZitmTmpuWkpwNk5QZFZTc0NNUndYR3B6?=
 =?utf-8?Q?XlWWSZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1pqSFFIc0JJdlhoQ3lscnJSd2NscEtrUDJxbC8wMDJDTHBNTHNXS2k0Rk5v?=
 =?utf-8?B?YjNsOVRkeCtNT1AyUzZ3c2F4a0ZQL3VGSTlFVWFqV1BXVFNBVlMxeUV4MlZE?=
 =?utf-8?B?SDhmUCszYzNNZFBUVFgrN1VPQ2xLalJmNHNZdVV5UVBQcU5xTTVEWHVZUkwx?=
 =?utf-8?B?cnpQZGFvczJXbjVsVjdRK1NITUdNczhRdzNzTXZsM05LaVU1NWJhaTczWjF6?=
 =?utf-8?B?SUJKWmM1UjdPQ2haTVNyOXBpL3k0VXRJb0V6bENTcjF2RzYxME5kdFR3Ti9K?=
 =?utf-8?B?WTBxSmFLOEdYZ1BrY3lUU29PRlhpUHJJVWEvcTVuazE5cHk5dU1oZzgvckJq?=
 =?utf-8?B?SXE2THE3Vm5jN3lEdGJkdG5ld3E4TXlzS2hqMHlmQm55VWphWjU2N0IrUTZz?=
 =?utf-8?B?TC9GaWJhem1Ia3c2T1hjcHJGNlVveVBZcnA1Vm5wTDl1RVpDSEhuRVVqUmtI?=
 =?utf-8?B?bCt1SjNKRnhXelBWNWozWkVzNWRJZ2NQRjdzQUV2RXNrWFRPc0ZzTnNZR3Ri?=
 =?utf-8?B?d1kxOGRZZGo2UTdESFNMQVp6cnE1ZDRybXJjek9iWTV1U3FKL3lEd3ZRMng0?=
 =?utf-8?B?a2dxUlZaRjUzSmhkbGFlOE9tbTB1VEZKQmIyTUJoanRpSklBb081VTc3QWNH?=
 =?utf-8?B?WDRYTGU3TEx1bndaVFpPdWZPOVZPQ0hxSzMrZ0IxRVd6cE5Kakl3aGR3a04w?=
 =?utf-8?B?UEl4TU9ad2VwNXNRZTRJQmJrQWNQZkhEdkVLWW1TeFczL0xaUnhYTFo0NURu?=
 =?utf-8?B?NXhEL3JGUHR5QWRwcGxzTkNaU0E2djQ3cTBhaWJrZVpyZWt1UWpjVnc5M1Q0?=
 =?utf-8?B?TkRhdDJ5Vkg1Q3czSG8vNlNzVzZIWmowUk5ldXFST2Q3TjdkNkN5amhqa0ZL?=
 =?utf-8?B?WVFXMnVGbTJ4VlQ0T25FZzd6WlNmWnV6dDNpc0VpYjZvYVhNUEZCUmNlOXVS?=
 =?utf-8?B?N1hKdDZ0c3pOaHFhdzBJdFFscnl2TkxObUh6SUpBd1JVSnk2ZmRrZVpaQVAz?=
 =?utf-8?B?eE9lVG1tcGFIUmNnKzliUzNxMjVhL21JcGlkL0ltUlNOaDAybFVkdGN5N3lK?=
 =?utf-8?B?OXFWMW03cEsvYUFzK1pidmNXRTFpa0JIVCtVY0FWSUxMWW95ankybFV2MkJi?=
 =?utf-8?B?VzFndk5MTmtLVkhtZHR2R2Z4ZGt6NTRTWndOS0ltRXNEbFFqZGV4dDRBNHBV?=
 =?utf-8?B?dDVxUk94NmN5QnRCVWVvUVZtTG1KSmswbzBhKy9saVUvVkk5S2had3NIY2RN?=
 =?utf-8?B?dFRyMTNjNGxjcjd3eWp5WnlLbXM4eVQvVzdNVHh4MHZFTFNmV1pVT0svbm9u?=
 =?utf-8?B?U0ZONHN4VkRNZkVXQU9GRDZKbW1BMm1rc3BFcmQ5ZWhYTEszQU91dS9qMUlk?=
 =?utf-8?B?MFpCZ3hWZ3NNMm81ME8yTU1OVlhPR2JRUnNGZ2tZVGhwVGM1MllwZW53bXZ3?=
 =?utf-8?B?ODJlSExtL0FsMjdhaitJajhpL2xvbEEzTXh6aFZqemNUUzR2ZE54NEoyK3Nt?=
 =?utf-8?B?eHA4QWlpMURkSU51ZkxibFRIalIvTmxZNWd3aEF5Vm0wdU9JV0VXZlkxWVJT?=
 =?utf-8?B?ZGJSOVhLbFpUWnJIVEY0eUNrUjdCcGk2eG9ZQUM4d1pzVWFBZXB2NVlGWWdk?=
 =?utf-8?B?Njd3NlpLYlVtdmkrWHBwdnZpNEFxQXRDSEpQNWFYUE1oZEhNM3Y4ZkJDdzUy?=
 =?utf-8?B?a0NDdzhERGhUQ0pQNysrMkRkc0RzbWEyQUJ6Z09DcDc1bks3cEFuZW16bU9L?=
 =?utf-8?B?Z2xOdU45UUxIelBrOEVMTEtnbzdmeXhZelQ4QWd5Wm1VcFpzWjNiQk5udDFk?=
 =?utf-8?B?Qkg3VWE3ZDFWeFRFK1JPOTZ1RVNMK3pyU2NxcEhIWCtxOFVnaEg5ZTlBM3d4?=
 =?utf-8?B?R3o2cytjc09UbEVPeEZ0QjdaQ1A5bm1zeitUM3lBSGY5eGlkd3p6WHo1ZTRW?=
 =?utf-8?B?aFcxb3RXcW85TlloLzlKQTZGempERTlQOC9Da3hTQ1QrNVdqTGtzM0IwTFM4?=
 =?utf-8?B?RHhwSEl3aGJCQVQvQWEwRWZoVHV5Ym5SdEl3N1UvaisrRmVORVNFbUdseTh4?=
 =?utf-8?B?NGVyemtWemY2b2JHdnZuRitQV0YyZjRBdEFLdlZ1T0NQQ1JIay9mNU82elBa?=
 =?utf-8?Q?dOY7wEFDkWYzdAHtVEFeviOi7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD6663BE73380A4587B115B6887B474A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O6hod6qBaMe1hGGN7aQzTxy2hN49Morigvu2/IJVLcf0nXlBTEBlQqxOqUCXa/mqfxngUTdm+Z0PGJxHTGaKWi0z7ONlKbDD0Bi8xb0hTUAma1/rtbGAOxTr3z9mYoImxnahVzH7MXhckLM1Oo0oFxYMWksDQvd+lIfaVwY1PniNqiPkPmNd7wBr8LeftsbzlksvQsA725RdC1Pz6+xi/PBYbCz3djbblYmOG2g1SLMh4n7pzNzn+qxWY63opZ9+6SmMMsf3VkQRUW92hsJTCx+ZfXxxC/3MPP9nLKexJ4ruH5pyWBa8wwmxtKydZ4RsCuuKWEoIhLPZp9PXtqefYLRtXJv7hfA5aWHvIK5wrBxxGzHd74vzr6qvb265ukB1DilQFRxgSo29yjzD3Fv7wi2gskiZ7SuvXIPDGmvrqGmPTtNnX4eI59J0NZp8Bg3TPOWfNuCsv2EKTxD68+omMlkz7XTgDAyfodSm/FuOnKKsygNnmmchYaArl+lzUijaoojEdu5T/ogZgniJTKKE0n6fE4WB4WVSkgSywloVyyPZxkfxzlRafE8SHReIupBBHK9BSkxRBO4Ch2zi3rEBCDBE7Bo6a9uh8VusMQLBDShXaQOdcthccsaYLrMU6c4SisgeZl1wpmCmAbwpfllIAg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d01367-f9a9-4390-aa2d-08ddffb091ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 23:33:17.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQi7uleWRgH9bV++tnvAgQKaAGTm8ERvtKjNUnS0YVi7VnKKvK/eqVnx1IZD5Va9Bh+97yHp9VbFQl4WxKRavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
X-Proofpoint-ORIG-GUID: EmBgTcLmBwrOM1w-cgHk8rJWTD_TLUwM
X-Authority-Analysis: v=2.4 cv=J4qnLQnS c=1 sm=1 tr=0 ts=68db1747 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=8AirrxEcAAAA:8 a=jIQo8A4GAAAA:8 a=pJD5MdrXAgXmh2OisoMA:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: EmBgTcLmBwrOM1w-cgHk8rJWTD_TLUwM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDEwOSBTYWx0ZWRfX5eIXN5UPV6BJ
 994tgLi7uxA6Dnsv8pf7gS2itJi4Dolq5+OvqFRXvYDG1O1FOSOCjeiZBh81oiDRPWb+rtBXlvC
 sGiuZsAFyA9+GmAJrXBR2YA1K4LM3x/BehNFUH/0sQZXxw6IxjfZxfktQumFn5KPd78YjUF9ViS
 UhxBerp7m0O+elz18qUOVQ2L9AWimVWVFTC0nOea5UzSwzal5tJkBdkCJEjIMhIydy70bGwMC9B
 SzLiNWnHjdlU0InC4NptKpPph2LEYoHYh2ilOK+u0djgnOdx2WZ2DLF7uGFISdKzuesXyLbvVmq
 S0Ig/wN5bC8fPBKJ700/pwohc5RP9VibH5PYYAQgPAF5NE2/AEVNts1zZLQgt25YqSweX+XSchX
 fOzY69o9dmiYngZq2l9HRYe7ezjJbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509270109

T24gTW9uLCBTZXAgMjksIDIwMjUsIEZyYW5rIExpIHdyb3RlOg0KPiBBZGQgbGF5ZXJzY2FwZSBk
d2MzIHN1cHBvcnQgYnkgdXNpbmcgZmxhdHRlbiBkd2MzIGNvcmUgbGlicmFyeS4gTGF5ZXJzY2Fw
ZQ0KPiBkd2MzIG5lZWQgc2V0IGdzYnVzY2ZnMC1yZXFpbmZvIGFzIDB4MjIyMiB3aGVuIGRtYS1j
b2hlcmVuY2Ugc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54
cC5jb20+DQo+IC0tLQ0KPiBjaGFnbmUgaW4gdjQNCj4gLSByZW1vdmUgb2ZfZG1hX2lzX2NvaGVy
ZW50KCkgY2hlY2sNCj4gDQo+IGNoYWduZSBpbiB2NA0KPiAtIHJlbmFtZSBnc2J1c2NmZzAgdG8g
Z3NidXNjZmcwX3JlcWluZm8NCj4gLSB1c2UgZmxhdHRlbiBjb3JlJ3MgcHJvcGVydGllcy4NCj4g
DQo+IGNoYW5nZSBpbiB2MyAoc2tpcHBlZCkNCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3
YzMtZ2VuZXJpYy1wbGF0LmMgfCAxNCArKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMt
Z2VuZXJpYy1wbGF0LmMNCj4gaW5kZXggYWY5NWE1MjdkY2MyN2E3YTE0ZDM4ZGNjODg3Zjc0YTg4
OGVkOTFlNi4uNzcwZmVkYzE2YmI4MGRmZjk1ZmYxMmM5NTA2NzI4ZGY1Y2E0YjgzMSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWdlbmVyaWMtcGxhdC5jDQo+ICsrKyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYw0KPiBAQCAtMjksNiArMjksNyBAQCBz
dGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVzZXRfY29udHJvbF9hc3NlcnQodm9pZCAqZGF0YSkN
Cj4gIA0KPiAgc3RhdGljIGludCBkd2MzX2dlbmVyaWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gIHsNCj4gKwljb25zdCBzdHJ1Y3QgZHdjM19wcm9wZXJ0aWVzICpwcm9w
ZXJ0aWVzOw0KPiAgCXN0cnVjdCBkd2MzX3Byb2JlX2RhdGEgcHJvYmVfZGF0YSA9IHt9Ow0KPiAg
CXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAJc3RydWN0IGR3YzNfZ2VuZXJp
YyAqZHdjM2c7DQo+IEBAIC03NSw3ICs3NiwxMyBAQCBzdGF0aWMgaW50IGR3YzNfZ2VuZXJpY19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXByb2JlX2RhdGEuZHdjID0g
JmR3YzNnLT5kd2M7DQo+ICAJcHJvYmVfZGF0YS5yZXMgPSByZXM7DQo+ICAJcHJvYmVfZGF0YS5p
Z25vcmVfY2xvY2tzX2FuZF9yZXNldHMgPSB0cnVlOw0KPiAtCXByb2JlX2RhdGEucHJvcGVydGll
cyA9IERXQzNfREVGQVVMVF9QUk9QRVJUSUVTOw0KPiArDQo+ICsJcHJvcGVydGllcyA9IG9mX2Rl
dmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiArCWlmIChwcm9wZXJ0aWVzKQ0KPiArCQlwcm9i
ZV9kYXRhLnByb3BlcnRpZXMgPSAqcHJvcGVydGllczsNCj4gKwllbHNlDQo+ICsJCXByb2JlX2Rh
dGEucHJvcGVydGllcyA9IERXQzNfREVGQVVMVF9QUk9QRVJUSUVTOw0KPiArDQo+ICAJcmV0ID0g
ZHdjM19jb3JlX3Byb2JlKCZwcm9iZV9kYXRhKTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4g
ZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byByZWdpc3RlciBEV0MzIENvcmVcbiIp
Ow0KPiBAQCAtMTQ2LDggKzE1MywxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMg
ZHdjM19nZW5lcmljX2Rldl9wbV9vcHMgPSB7DQo+ICAJCSAgICAgICBkd2MzX2dlbmVyaWNfcnVu
dGltZV9pZGxlKQ0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBkd2MzX3Byb3Bl
cnRpZXMgZnNsX2xzMTAyOF9kd2MzID0gew0KPiArCS5nc2J1c2NmZzBfcmVxaW5mbyA9IDB4MjIy
MiwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGR3YzNf
Z2VuZXJpY19vZl9tYXRjaFtdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAic3BhY2VtaXQsazEt
ZHdjMyIsIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YS1kd2MzIiwgJmZzbF9s
czEwMjhfZHdjM30sDQo+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ICB9Ow0KPiAgTU9EVUxFX0RF
VklDRV9UQUJMRShvZiwgZHdjM19nZW5lcmljX29mX21hdGNoKTsNCj4gDQo+IC0tIA0KPiAyLjM0
LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+DQoNClRoYW5rcywNClRoaW5o

