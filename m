Return-Path: <linux-kernel+bounces-798173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79820B41A50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1262B6803BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9B2F0666;
	Wed,  3 Sep 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nMMYeN+S"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFE2EC57E;
	Wed,  3 Sep 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892632; cv=fail; b=nIARDYFurG8XsIO9lacxoWP3xK7D+Io959I7U/7n1aruxfnEq9CK09ym68TR8q8ozjeWFCfwt75mOIhMyHJQbRiHPXa94svb0b+Ug204kCVZQT5Ryd9dhwA8CIeAUVKSkBCOyaoW3lLjjySV+KdISQ9dcfi+EScjoUazNNUxyno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892632; c=relaxed/simple;
	bh=6pWLRgcIPRB4zyLEmPoVk0cBBkUTvFNIbOMavApotLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C0nvnGK4yPnrBS2zZCWec6xcjJ/nf+bA5K3DYVFl2s6s97EkRbVjWjVzm+GAYq8NvBqN6cU9gaGHDccBHfLfjziNZixZtWL40Mz5G02tGN3vDnWmu9sVlwQWIZRSmDbYKtgyOaZ6sB5Pugr+IpnFwonnr9mk17HTVVl0g4t7RyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nMMYeN+S; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izUjwmVT7kj5GWHDjKsffN8HNhJxqNfzNtzsvs00W80bBuBjV9Xkfqw350xQzUsQF8xiW+qUzBv5gqWzaGb/+rWFrWmKD/s0e6WdyT03/lcOR5VDGLD4sM7yU9mJ5fLSavHKSPvrNDazBY4ZHcxt3Kkk49Wg+/jg7D+XYIO0RKs9vtRa7+L+2GAR4wSu+Xeooy6odLs0sHqQZu11l9TWDwCGCp40bC5Hi61TiHmScwHB2/ez32FeTmpT3VHeKKErBcVYwfD4pnORJAeCb8m+ovuMo9YPaWTYwjabbmdp9eZN2NTeEp2rTejne0518iPaffvG9bGalVzAjqd2dEsyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pWLRgcIPRB4zyLEmPoVk0cBBkUTvFNIbOMavApotLs=;
 b=IY5+XnAp6pC2X4EGGWFH0ZUXo5eCxiQLKYmgsMnTxk5zYaJEKdzb04BYXHdwfovNNQR4AzMiDpjs1bm5/80HhdnTfyvTvRcGdA0Qm4qHF9Fqt0Muo8Fvx8MBnhXgLv/6f0y/WhQnrXdVOq8k7DnxWAHyLaaEW39d9fH5ZgFMylLsfzOUzngkT4KI4GzoAqQsezIRcwt0XnZSTEBE4pAx88LIPSCni/IpQET/dr2W7UTzHkyIJJxAXfVLxa+U3d2OvXBWUlXjiC41aRRPLQA8XUxll2Zrqn18M0hzSQyfNw99LMyNJag+9LOGVafkcdfPru8J/07lXGltKHnHOJ6SqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pWLRgcIPRB4zyLEmPoVk0cBBkUTvFNIbOMavApotLs=;
 b=nMMYeN+S5n8qyx6Zi/NvjgiNX1bRcYhf7SuAAwihOKxKc3QEI9hQt62+KLKkPnIojQPEDpOYnL70tAc3mmJSqzwajiOb5+gUcDoaQDWsHCCrhoRrw5fUDcwAgthIGkL0UDBsaupZpKlRMBco0c40iRTgu0RDIoNrRpvvGaodb1Dac151Qtgfi3vThdZ7GSVqKgALh8x13fNSRT9q/Z22wNe1HWgSdmXHPAIDLZK/fsSFOvGDoOqdaYLiCtGTbgTgKguH3hHfwRnxImQxw5p1ONBl3O9JUi2kL0DeQELjfh+7WfZ4bZUgHjUgCwz96DjZL0hgKERwDM1Ewqyz4tqxKA==
Received: from DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19)
 by IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:43:46 +0000
Received: from DS0PR11MB8739.namprd11.prod.outlook.com
 ([fe80::f0f:4a3f:e3a3:d3ad]) by DS0PR11MB8739.namprd11.prod.outlook.com
 ([fe80::f0f:4a3f:e3a3:d3ad%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:43:46 +0000
From: <Valentina.FernandezAlanis@microchip.com>
To: <ziyao@disroot.org>, <Conor.Dooley@microchip.com>,
	<Daire.McNamara@microchip.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v2 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
Thread-Topic: [PATCH v2 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
Thread-Index: AQHcG98gqG/pvteh90S9xnhdl7vCCLR/kIYAgAGmNwA=
Date: Wed, 3 Sep 2025 09:43:46 +0000
Message-ID: <8b371196-c853-4e47-980f-3f2b3525180e@microchip.com>
References: <20250902075548.1967613-1-valentina.fernandezalanis@microchip.com>
 <20250902075548.1967613-6-valentina.fernandezalanis@microchip.com>
 <aLarlSG9tDA-1YiL@pie>
In-Reply-To: <aLarlSG9tDA-1YiL@pie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8739:EE_|IA1PR11MB8198:EE_
x-ms-office365-filtering-correlation-id: cc1105f8-2f6c-4c8e-8636-08ddeace60f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFVqcjgxbDh6NVFvQkxzRU5uMytEbEpuYWNsU3FERkRxdnI1aVRjU1RmYVMz?=
 =?utf-8?B?RWhuWmlRaGdFVDgxTDN2dG85emUzbjZldktsZnZ1aGZnK1gwZVRWRis4M2Uv?=
 =?utf-8?B?SmxKYmVYYmpQQ0xiSkpZL1h1bGxyMTlXMTlxQUlTZlk3N29KUzVuYjhMVGpl?=
 =?utf-8?B?cXAyME1ubzh0cmxXRVRWVnp6Wjhma1VCSnRManlSZEJ1Z0FPdU8wdnJ4eDRS?=
 =?utf-8?B?ZmpIY200aVZ2cmVicVU0RUtGS08vejBCV3lDK1NsWSs5ZHV5UmQyd091R2F4?=
 =?utf-8?B?NEVpelhYZVFWMGc0RnJrNWN0N0s1MkNmYXpEOURuVVdjRFVpWUE3NVdYRTlW?=
 =?utf-8?B?NjNxQVhnZ25PZkVCNDEySjJSUEhLWVFMbGluNFQxcGRCdGxML3Qwbng4Y3NT?=
 =?utf-8?B?RWVOcmhKVSttT2JPeXRTRXBFZTZWeVZjbXV1N05aNW5CREVKVW5MdU1IT3g2?=
 =?utf-8?B?b2tYdG1PcTgxd1RLTHV2OGhtUVRwNWdIUGtFOFpyUFdEZ2k4SlJZbE5rOWly?=
 =?utf-8?B?c2cvM3pVZElGd3RhdEYvdURvc3VtTG9pS0tlM3d0NWUxOHVmQTY0eVE0UklD?=
 =?utf-8?B?eCtSS3AyK2FvUzhyRU0wS3N1cTZPQkJOTnZ2SjVmN3p3ZDVSUWtZZkxLbFZ4?=
 =?utf-8?B?SXIyN3kydE5XaDdBd1hSZ0ZCM0xqaW83MnJNNllEMVM5QVBTZVZrZFFLZlBM?=
 =?utf-8?B?QUd4a1ZncVFyMmhaTmlWTWpJUWQrdE0zMDIranMvQ01rWkxrNWdhQWlpQklH?=
 =?utf-8?B?RmlRZFFZamFQR2plbCs1TC9ZRVpsYk1ncUJtYytwQzNoM1R2RzNsM3ljQkxX?=
 =?utf-8?B?ZmdGK2k2eEhtdkZ6UjMybW1wcHhpTS9qM3AvVUFJYTdxSm1MQUlQb3pjRWx6?=
 =?utf-8?B?TTM3Z2VBYVYySGpGTStQQVRramR0YWJFQThzT09XbHZuUlhPeG1Tc0NQRTBy?=
 =?utf-8?B?dEswU250d1JWYXdpK1o2M2Rwc2lGWkQ0VDVLMk1YOTl4K0xDRmZsd1JCemNQ?=
 =?utf-8?B?eWJCQTNFT3dyZkJzVDZLSEZsY3FHRk9VK001U0VhczVaRGZBbUpOU1RoMWxq?=
 =?utf-8?B?S3RJR25YaTlNU1hhT2FKcm5XTWN0cndGS0N3a2t2TFB5ZlB2VjUvUXpDV0FU?=
 =?utf-8?B?WFg5UGFIbkRRdWpKQVRsRkpqRHlKQTA3Q000cDgrQkE4RHovM05ZUzBjQmJj?=
 =?utf-8?B?UnBpelgwZHd4UWp1WlhLWVUyUGNOTUhhcVZja0lYbWNMQmlXSCtaNHJYV0F3?=
 =?utf-8?B?SGg1azhCRTl6aDdNWnNZNnVhMEY2eFE2M0pTWnUxNDVzUkluVjhsK0k5WDVO?=
 =?utf-8?B?VEN5ZGl5cEt3RDF3VDlrU3lPZWVHakNXN2Qxd01mb1J2MUVKY3oyMEphcXkw?=
 =?utf-8?B?MCtZYmpGZHQrQmt3N0IvS1JwdVh1S2JDSXBETGJFVmw0ZVE5dlUxMUdNL3lB?=
 =?utf-8?B?eGF6Qm1kNWNZWHI1bmVpeUFGbmt1TU1sQm5sWXlWZ0FYUXR4bDRNd1paOXNX?=
 =?utf-8?B?MUlibGFWaTIzZ3BHT1JRTVZSN2U1YzF1ckVvOGtBSzZldnkyMTVpOCtxcGRh?=
 =?utf-8?B?UEFGZ2xyZEtLejVNWFhONjhkR1d0NGFmZWpMZXRRaEh2WHhUbm5xTS9Sd1p1?=
 =?utf-8?B?TGExeUFjZTl2M082V1NyUUJDeVVESDVhNVdaRkhvVm1YTGhldmV2enpHVDBB?=
 =?utf-8?B?WEg4dzUrUmM4cmJCL0VZQkJocXNNdW15MEdEb0pYL2NFU3JGYjFQVmFPRjBl?=
 =?utf-8?B?c3dLUjRzZkNEV29oSXExME16QVRNT3ZKNVNwMGtCeVhhRHVzSTNWMFc4WDBM?=
 =?utf-8?B?TENpUXdpNW1QbUd3OHgxdXpYeWVDeXFWandiUk1Lb25idkEvSXMwQmxzdXIr?=
 =?utf-8?B?Lzh0ODFyckVBVnp5T3dXbGExdmxERmFXaWtIbkl1dDNEOHBTMkY1ODdrUXlr?=
 =?utf-8?B?T3pWNmNlbndzOFZ0Q1gvV21mWm1EQUxKVXpBaFFCc09uYWlFcWU0OUxranlG?=
 =?utf-8?Q?EyB0En2jAYGt0c1f0by7I2Lvdzu0iA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c01MdWp6UDVIQllqTE1nNkdxcXZDcnVSc2pIdzh6elFFV2IvUVJTYW9tdVhz?=
 =?utf-8?B?eVhvT3pLbDltdzlpOGJjQUxFTXUrNkZLb1R3cVRXSzVkbHROSzc0ZnRYdFVB?=
 =?utf-8?B?a0I4QjIyKzVSNTJrWG5EOEdPMmFwRkY0L3JlSGhpVHEvYnp0NzlTVWJGeUFk?=
 =?utf-8?B?WGNLcEFjc0trM3dPVkdEc0NPNmhMdU41eUdFYnFKWWlpcEJGcXlEcUFiUjEx?=
 =?utf-8?B?K0ZkU2xXUXFJSFY0NzA3WHZ4UUxYa1p0MkIyeHFMZEdoV0Fna1d5c1hUV1dj?=
 =?utf-8?B?NGZuZUpEekVXaWw4RHdNR2J2UVZBeVBsTVVNWldDNXk1RmQ4bTV4V2M3T2Zr?=
 =?utf-8?B?b0NieVJHRkpFc2ZiQmdsL2dtQnlCMU5waFNaZ2ppWDBDQXBTRUJLVlFqNGpO?=
 =?utf-8?B?dFN4MDdtbHBOZjIyMzBEWmZQemFYV0xjZklTeWV1a1Z2YzQ0VUlDVnB1Z3pw?=
 =?utf-8?B?Y1FQamxDM21UUlpJdGlZSm5sRlBXT3lQeVdXeGI4UmZmYUZVc0JXK08vWXdV?=
 =?utf-8?B?aE1MOTR4cHFzUXRvV3gvWHlqRDdrNDIreVlYbkhQZ3B1a3hTRDNHQm00RGlp?=
 =?utf-8?B?WS9xK0t2aW5LZmY2VENESTZTbWNDazRCZE9XZ0g1NHAvL1djSTVFaHU1OTVO?=
 =?utf-8?B?MXl4N1Q1dVN4T0xrRDNLM3dablJ2WVU3VWo3QmdvSFh1bmhZZXZKTlNNMXVH?=
 =?utf-8?B?b2d0WHhEWFQwNitwUm9WTTJzMDV6TmExK0s0d1VpYUVzZmdWa0hjWkJaRFlX?=
 =?utf-8?B?WGlxTE40QWVpRjBZZXZUcm5JdzgzWENNUEh2UU0wRWRQaHpDdDBHSm00a1Ji?=
 =?utf-8?B?blVxWUVnckFqeVp2SFBhcVNCbThWeWFIYU03NktBYUhldGZGcmFrQmpTbDBR?=
 =?utf-8?B?OHl1T21Gd2p2SHlldk9CUm5Wa3JFQ0tBQk9HU29CTGQwOTZMbVlSNzd3UVpB?=
 =?utf-8?B?aU9IbFhCRS9DUVlvMFN6ekVWYTBZemoxdUFNdkxDUi94SS9WOHc3TUVsOUVz?=
 =?utf-8?B?NGF3bklTZklKQ3dsQWFta01yRGdBa2NwbGpibG9UbVlMclc2ZnJ3ZnRmdmQr?=
 =?utf-8?B?WVc4WGJseHA0bjdSRmtVUFNkbk4reE9XN3pxb1VDT2xzS2VIUzY4YnZTclBW?=
 =?utf-8?B?MnN0K3ZZQ0NuZTNiZGlvY201bHptSzV0a0lIR3VsUTZPSFRWVlJiWUQ4U1NV?=
 =?utf-8?B?dEZUSFpzcERjcCthV2xEalpVU1ZYQkpmUDBPbE5sN3dQSVd0WTNzNng0UllD?=
 =?utf-8?B?aTg1eXNlc1I0Uk1ka1BuUThVT2RaOHZrMlpNbzU2bmIvTHUxVDFIVUVQNkdy?=
 =?utf-8?B?L2NKZ0o0MEFQRzhkeHY1NnFIL3A5eVdQcGdhL2lqbUN4bTk4a3F5ZWo5ekFK?=
 =?utf-8?B?bzQrQ08wbEpXLzNUT3FCWmJZdzJlbThib2xxd0U5QVpDN3c5bEdwWVlIclcv?=
 =?utf-8?B?ZThxUzg5ZGQrZUpGK1ViMmZzZUNxbldjTVhxRHByQWZQd2FkWUtSaWJmYkdz?=
 =?utf-8?B?SHh3eHluUDVUT0MrQ3V4b1k2REJqTWtXZU5vMzdxRHNwNTRsTzlGUGJ0MnlL?=
 =?utf-8?B?MktMM2lZWExkS0RZU1BTTUE2bzQ4bDJ2azhTRTcvODlSZkRzd2dKYzdkdkVC?=
 =?utf-8?B?WkJnK2wrWjRPRWtBcDZ2RW9nN0RTajdtTzNqbFFJQ1pEbFI3Rjlqa0NsNWVJ?=
 =?utf-8?B?eVBSWHpEUEhQRmhlTGw3MzI2dzBCV3ZVTGd4dkg1ZCttUWt3MmViYTRCQnpU?=
 =?utf-8?B?NWJyNlZLVEZzU0plQ0gzSWl5S0E2RVVrN1YvUlRPTDBkK0JDblVCcnlNV044?=
 =?utf-8?B?blRSVXFyS0FiVXZObWVITUhqVFFTcXNPNW1zMlc0N1hSMGc1TmkyMnBkMEdt?=
 =?utf-8?B?RVFXWjdiR3ZKc1lkd0E3N3VySkp2ZU9UVU1OcE9seE0xMk00Wnk2MjRaeUpM?=
 =?utf-8?B?elhuOVlVOEFBdE9tdmZoa3BDUW9Ca1NkVll2VHRJRU15T0JXYk5TTVc2eXl5?=
 =?utf-8?B?VkwxWVArSHhLYmd5NzJaQXdqVzNyNGJ5SS91QWh1dnV5bzg3MmN5MXNNZ2Z6?=
 =?utf-8?B?dXd3Y3laRXVabVhXZjFUamVyTDZqNE1lRG92ckI5dnBzWmw0ckFING8xU3VD?=
 =?utf-8?B?TkN1TXpJaCtTQUVXSDZ0MmliY01xbnpaWWpxc0xCV0NYMnd4V1lLZ3ZmOFRq?=
 =?utf-8?Q?J+NPmyDp7l3tiKpZ76Heuz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <107DFB84020CB04CB7591C9D19DAD3FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1105f8-2f6c-4c8e-8636-08ddeace60f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 09:43:46.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAeKTFTHtQVNKYkT3lV0uCFo0HnlG5AsBWG+MRB4gEuelgthoguAeFnTrJeUyvF5Xwwz4AiEJqZlreHUJuUeIURWD32TBCAThJacq7lJP/36GZY2i9snbOOLWHd1xcTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198

T24gMDIvMDkvMjAyNSAwOTozMiwgWWFvIFppIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgU2VwIDAyLCAyMDI1IGF0IDA4OjU1OjQ4QU0g
KzAxMDAsIFZhbGVudGluYSBGZXJuYW5kZXogd3JvdGU6DQo+PiBBZGQgYSBtaW5pbWFsIGRldmlj
ZSB0cmVlIGZvciB0aGUgTWljcm9jaGlwIFBvbGFyRmlyZSBTb0MgRGlzY292ZXJ5IEtpdC4NCj4+
IFRoZSBEaXNjb3ZlcnkgS2l0IGlzIGEgY29zdC1vcHRpbWl6ZWQgYm9hcmQgYmFzZWQgb24gUG9s
YXJGaXJlIFNvQw0KPj4gTVBGUzA5NVQgYW5kIGZlYXR1cmVzOg0KPj4NCj4+IC0gMSBHQiBERFI0
eDE2DQo+PiAtIDF4IEdpZ2FiaXQgRXRoZXJuZXQNCj4+IC0gM3ggVUFSVHMNCj4+IC0gUmFzcGJl
cnJ5IFBpIGNvbm5lY3Rvcg0KPj4gLSBtaWtyb0J1cyBjb25uZWN0b3INCj4+IC0gbWljcm9TRCBj
YXJkIGNvbm5lY3Rvcg0KPj4NCj4+IExpbms6IGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vZW4t
dXMvZGV2ZWxvcG1lbnQtdG9vbC9tcGZzLWRpc2NvLWtpdA0KPj4gU2lnbmVkLW9mZi1ieTogVmFs
ZW50aW5hIEZlcm5hbmRleiA8dmFsZW50aW5hLmZlcm5hbmRlemFsYW5pc0BtaWNyb2NoaXAuY29t
Pg0KPj4gLS0tDQo+PiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL01ha2VmaWxlICAg
ICAgICB8ICAgMSArDQo+PiAgIC4uLi9kdHMvbWljcm9jaGlwL21wZnMtZGlzY28ta2l0LWZhYnJp
Yy5kdHNpICB8ICA1OCArKysrKysNCj4+ICAgLi4uL2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLWRp
c2NvLWtpdC5kdHMgICAgIHwgMTkwICsrKysrKysrKysrKysrKysrKw0KPj4gICAzIGZpbGVzIGNo
YW5nZWQsIDI0OSBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jp
c2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLWRpc2NvLWtpdC1mYWJyaWMuZHRzaQ0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1kaXNj
by1raXQuZHRzDQo+IA0KPiAuLi4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290
L2R0cy9taWNyb2NoaXAvbXBmcy1kaXNjby1raXQuZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0cy9t
aWNyb2NoaXAvbXBmcy1kaXNjby1raXQuZHRzDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4g
aW5kZXggMDAwMDAwMDAwMDAwLi5jMDY4YjliYjViZmQNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsr
KyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtZGlzY28ta2l0LmR0cw0KPiAN
Cj4gLi4uDQo+IA0KPj4gKyZtYm94IHsNCj4+ICsgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+ICt9
Ow0KPj4gKw0KPj4gKyZtbWMgew0KPj4gKyAgICAgYnVzLXdpZHRoID0gPDQ+Ow0KPj4gKyAgICAg
ZGlzYWJsZS13cDsNCj4+ICsgICAgIGNhcC1zZC1oaWdoc3BlZWQ7DQo+PiArICAgICBjYXAtbW1j
LWhpZ2hzcGVlZDsNCj4+ICsgICAgIHNkLXVocy1zZHIxMjsNCj4+ICsgICAgIHNkLXVocy1zZHIy
NTsNCj4+ICsgICAgIHNkLXVocy1zZHI1MDsNCj4+ICsgICAgIHNkLXVocy1zZHIxMDQ7DQo+IA0K
PiBJIHRoaW5rIHNkLXVocy1zZHIxMDQgaW1wbGllcyBzZC11aHMtc2RyezEyLDI1LDUwfSwgdGh1
cyB0aGUgbGF0dGVyDQo+IHRocmVlIHByb3BlcnRpZXMgY291bGQgYmUgZHJvcHBlZC4NCkV2ZW4g
dGhvdWdoIHRoZSBrZXJuZWwgdHJlYXRzIHNkLXVocy1zZHIxMDQgYXMgaW1wbHlpbmcgc3VwcG9y
dCBmb3IgDQpzZHIxMiwgc2RyMjUsIGFuZCBzZHI1MCwgdGhlIGJpbmRpbmcgaGFzIG5vIHN1Y2gg
cnVsZXMgYWJvdXQgaW1wbHlpbmcgDQpvdGhlciBtb2Rlcy4gRm9yIHRoaXMgcmVhc29uLCBJIHRo
b3VnaHQgaXQgY291bGQgYmUgdmFsaWQgdG8gZXhwbGljaXRseSANCmxpc3QgYWxsIHN1cHBvcnRl
ZCBtb2RlcyB0byBlbnN1cmUgYWNjdXJhdGUgaHcgcmVwcmVzZW50YXRpb24uPg0KPj4gKyAgICAg
bm8tMS04LXY7DQo+PiArICAgICBzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gWWFvIFppDQoNCg==

