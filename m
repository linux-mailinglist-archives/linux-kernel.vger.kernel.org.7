Return-Path: <linux-kernel+bounces-894908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EFC4C6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DC4F4DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92582EB87E;
	Tue, 11 Nov 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="js5q9nkU"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9E23E33D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850002; cv=fail; b=Dbf2kYDM52e9XEj006HurPeuZp+7YmqAOePv/CC/+m71F2NZJU9TNzsUuooqcBWgW8aAsHWgFRdUnvBk3WTh9uDn4FIkN3G06KjarPoeQ8Ek0OnQqlpPwVv37RpLHCTG534gk6kR6GlPFRdZwcrGmrF0MTkdgtsoF7cQXx5Zq0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850002; c=relaxed/simple;
	bh=ARpF9XScmjqEpwFx3635Zv4Jl1aX5bi+zfkoE2EUT2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLazr9uUyR0ytB09ihLAAIRmHhG+FCiUbvxEleI4Na57tNcnqNa+VB9Q4XPXZLXLlRwPgdHREvfxPlFp/2FP9cMWtD0I3IwAYfVoYuKbF8ogmefFhj4O5lAJ6BEo4yEdo9bIuCpcjKJ5xRt8R/GfXffSxck10D2elyO6+s11Fd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=js5q9nkU; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpWtwtFiUmEic4+tTx2R6G/pYq+9B85fqfAFeHxlwK4SN4u6r6nHFFlVf3ZHQZe8PFcO6nfmadn2opHGvNQiOqklTe9DAyC3qmPCcfWREewJYIzDOiiODTOht/+k3/PCGxMCdgv0SsWOMYFqLsNEPxFlwzXYNJtRuLnPbEHuHTaeuzbblYOflEg7y4BYxh/5LqZqidshYD47wx7FOiBmloufDsUCdEhvRBH7y4Qjjzx816TAvCdYkjLpKJca8bgrToxjHsFozv5JaxY/UVlbzJu9IOa9qOKD0OXzsqSgAlC3sree4Z4A1JOLQEcyn57Pds9NNwFG6R7sXeR7EcD+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARpF9XScmjqEpwFx3635Zv4Jl1aX5bi+zfkoE2EUT2I=;
 b=N/+L7eakmLtwSPP2eT1uKKTbnmcJvLDfhvawtU3S+vXBtMk3K7xuxgYG79tMaf4UEdD9HVA16G5E++KbeqGVxiVCR1eCjPx+OjKzM1dUNsZV47iL1/JI4aiKHNG9xO1mITx3+noUlo3uU//8cRC1VNMobzcZHSX+0fqXfUIx/xzIThUl+lCtPQB4Nt/aJO0t+CFaM9r4RT4B1TRzymkQ+wWkf7YuuDUdzdV8MSmSiyywbRqe1MBbXgz/2is8OLaX7Im736SQzfyz5A3jgmXdOpTGWJWcjS6M1CJKUMVD5xggq0squ0fhWHkhSnMPWZk0u2YZncrB1h+/STYODnv+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARpF9XScmjqEpwFx3635Zv4Jl1aX5bi+zfkoE2EUT2I=;
 b=js5q9nkU8a3a7hpOnupCgyRtVOpZBs2ZPcIbqbmH9fUeWyybdbkyEI+/o9GhM1noJTtyg+4dkQszOevXAlBduddnifgYicnAXAGpKjNAzeSEdKsOwdB5flHlEKvQdzsP9HVNt7W2/Q5WOrTQG2BXvjmYWe9RqAsF/TZC1CELTKYb4tqoUd5YO4Vfa/uTyV2VK6vW7mKj82CJfhr/XbUsjRd0vW912RzcffMB7gGoQ44xiwFrCmTmLmeST8BDjG5o5PZWvoVGpiv7WkxI2ov5ulLfsJMyoqTT3F2Bk7q7O1ilA1XKnuFmb03cx1RFQYWpRrkwItbQzUlMrDIIHqmSAw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB11789.eurprd04.prod.outlook.com (2603:10a6:10:621::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:33:12 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:33:12 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
	<pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 4/4] mtd: spi-nor: micron-st: enable 8D-8D-8D mode and die
 erase for mt35xu02gcba
Thread-Topic: [PATCH 4/4] mtd: spi-nor: micron-st: enable 8D-8D-8D mode and
 die erase for mt35xu02gcba
Thread-Index: AQHcUfbl9VdnnpBiUEWwbRZsy0JYI7Trd2qAgAGlnnCAAAmHgIAAAOOw
Date: Tue, 11 Nov 2025 08:33:11 +0000
Message-ID:
 <DU0PR04MB9496B4A973E205BEF684A0A590CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-4-cde50c81db05@nxp.com>
 <7d8b0062-a6ec-43a9-ab00-3e11f0e2fb26@linaro.org>
 <DU0PR04MB9496D24A8424C578C942CDE590CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <8263aa0b-f223-4e67-9923-9f7882b90646@linaro.org>
In-Reply-To: <8263aa0b-f223-4e67-9923-9f7882b90646@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU4PR04MB11789:EE_
x-ms-office365-filtering-correlation-id: cf45d9d7-5361-4c33-31e1-08de20fcf360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDA1dDhKcjdsd0kyeStGQkdPK2dZMzZGL0xMaUE3N0RqUHRwNmtGdHlDOHFK?=
 =?utf-8?B?clNUVVM5SHFWTTlzVVBqV1lVZlRDZTNXTWMwNkZmZ3NOVHJML3M1eURoU2ZX?=
 =?utf-8?B?dkF1WkNSWVRuQ2FyNTNhaUVLYXFMVVM5aS9oMVdrYVpPQzlwcnYvcEZ5cmw5?=
 =?utf-8?B?NE03OHFhTnlkSWtGUENkd2NEK1RnajZqQmN2NTg5VGNMWjJyemdGcHBrUktq?=
 =?utf-8?B?YVo3THU4RzdjckhxbkYyNUxBQ3NwRHhRYzA2Q3VwMzEyWHEvMnVsUk9PamRh?=
 =?utf-8?B?YmtQckNKNW5qeXdsOXlZbXRUbXFYdFJ2TXFCVHpIb082OEhvL3pqUmFnQzF5?=
 =?utf-8?B?Q093N1QwRnZaR0h0bXpiQ2xIUzBIa1dRZ3lqR3ZNMlNyOG1abXZIWDIzVUF5?=
 =?utf-8?B?czBMK3JuSXhJSFp6V2RvRmdhdEtLN2tWaWZDS2ZjSXUycng1SS9WK1JoWjFU?=
 =?utf-8?B?Y0FzWGMxYkRJWktRZUJrT1pEdjFCSmpMbTRvcm93S1VFZ3Y3d3dsVG05QXRQ?=
 =?utf-8?B?VFJ3bmRLUkhHbmVJdEdkL3QrS2pMZzJyRTFLVXU1NFBrVDJicCtXeUt2UUZy?=
 =?utf-8?B?dFQ2dEE5bHNXeHN0YVFsN00vblRLc0xCRDFQbHRsNzNWc0pidjdFdFM3SnhD?=
 =?utf-8?B?bmkzK2RuMWI5STRzbXVvblIrT2JCbVpUbEd0SUo5M0RJek5RL1pONHl2eGhD?=
 =?utf-8?B?a3hLMGg0Q1dpNnN1bFV1UGpyWTlUckVodXQ3VklLUmZIR1RlL29pdjg5UGd4?=
 =?utf-8?B?ZXlzYlh5Qk9zOVc1VlV0SUpSVkp4UlNSVzlUUWU4aGRKMlJ5VHFaU0lpSzRx?=
 =?utf-8?B?REttL24vVG9ZTXhZR1hWMnZhejF2VGZESlJRd2xQZ29jZGk3VHFUYVd0c3o4?=
 =?utf-8?B?WEJVM2RGa21lb285R2Q5T2RIUHovTjQxMWRTU0orU0RrcVVLaVBTL1VnM0Y4?=
 =?utf-8?B?Ly9QMGQrTncwOFZwK1g5SzY2WXZJS2RsYXVVM1RyUnU2ekIzWlllK1V5MFlZ?=
 =?utf-8?B?VzgwUU8xblZBWGpyMDBIODhib1lWKytIMGUzcm1IVHhmVm5TdllhVjd6bzNI?=
 =?utf-8?B?ZWtwMStxOWVuUTl1a2hReHVaUVdhWVJYeDdUcUxPeHZBcW5GNm91aHBHUlhy?=
 =?utf-8?B?SkM5S3BnaVc4R2Zwb295c2o5Uld3cE1jRll4UnV5UnpMMjd6WlFmYzdibFo3?=
 =?utf-8?B?eGYzYkc1QnlKQTl1dHd4ejN3S215VHVlSy9WTTFHVTVjVmVMRllDRTZvNm1s?=
 =?utf-8?B?NEZNUlY5U1ZURGY1bkk1NkdJd0wzSEpUaklSNWQ2MFdOMm9OazAzZTVHZGZG?=
 =?utf-8?B?dWVtTWRlcDhjUElFWFRsVi9Gbm5yUHVJQ2JMRnNyaTE4NzhKeCs0d1VMajAx?=
 =?utf-8?B?aU5jckNSZGN6cU1DSlJmbGVFdnpqbEN0ZzFGcDNGVzlEdkc5SVVKM2VPS3hm?=
 =?utf-8?B?VWlrdW9GZW54eU90NzZNVXl5djhlUnhTQVg4VDNSY254NjF6SS9sY1V5QmhT?=
 =?utf-8?B?KysxbFBYdkFEcXRDWUJLWnFWRE9DODNDWGJyZE9JR0I1dXpFNVN2aWJtdG1U?=
 =?utf-8?B?aURvT3NaZGxQOXl0c2dPMGNQaUwwM2I4WWM0ek5tNUlyTFlQT2VYZ1BQRFoz?=
 =?utf-8?B?QXY1VGRVdEY2cVlhUTRNNkFHV2hmYzBiQ0JwKzA0cWpTRGN1d2p5Q0lWdmJL?=
 =?utf-8?B?RTUxU2d3aXhFVEx6MnphU0tmMitJeW5IMUFaTllJMmtFL01oamNnT2NxeUli?=
 =?utf-8?B?UmFmUGpaRnUrdmxHa3RWRStWOWxmUXZ3T3RYamhkVytXU0FkaDhFcnlwQmhi?=
 =?utf-8?B?enlZakFHMVYza0pVUGtrbzB3YTZ0b2tUYzJzQkthblZOSTBCbG12RGc0Wnl5?=
 =?utf-8?B?SkJ5V2pUNkJJQ010bHFHNGt0UmJVUVlhbEhObVd1UUFHNi8vSWpkODI4Vi9h?=
 =?utf-8?B?TGxzdk1UK2tWZWxUajJ2RDhQV2wyNEQrMlVxcVdad2RrcUdIc2VLYUtuaVph?=
 =?utf-8?B?TVloQS8vZUd0Q0tYaHpNOTRPREF1bWxGNlVZWldVT3IybWFid2VpYnpaVEV2?=
 =?utf-8?Q?n6Bi5M?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzRHRXFiZFR0YkZVK2hOZ1NRTEVWbTMyNm54Qm90MENQTEpZYmJwZUdWQkxX?=
 =?utf-8?B?QVRlUEhvamVjZHhyK2NSVlRzelVZYmdweWhiamwyTGJnYm1GYmNsODZjN1NP?=
 =?utf-8?B?U1dlTXpLaEtHdkg0N1ZNNW8vb0VsS0J3QVAvRFdnRXpQU0Y3di9DcnVmMWY3?=
 =?utf-8?B?U1FiNUpXcGM1Z3BxUkhuWDdkcjJRVWlRdUYwenBNVWxZVXF5bHlNZDBySmp5?=
 =?utf-8?B?L3ptY01naWN6SzMvMjM5NitvckFTY3VXSjhaNXMrTHdDTHBPQlljajF4cTlq?=
 =?utf-8?B?TlpycEhaQnhjYUgwc2NOa3gxTUdDYy9xNkVzTnFUSEhHWVJvNTFyUTNYZ05h?=
 =?utf-8?B?VWc4bEJkdDhveW5aVVRUSWtlT1JQdTNwZUtPOVdrNDhxRjY5YngwRTQ1eWtE?=
 =?utf-8?B?c01TdnJJRDE4K3phT0lJaTc5UWpVRUR3MTRGR0lVYVRTM2s5VDllQ2pZcEhK?=
 =?utf-8?B?azJtcVZNc3JrMlJPK3JsNEZkRFp1OUlwbk95SmRWKzJ3dG9OTyt6WVArL2pL?=
 =?utf-8?B?SUpoUFI3YTVZOXpJd1pZNVFZRWZYOFhEdHBBNUprTU1jS0pBNnl5Y01SdERj?=
 =?utf-8?B?MEEzQnBQcnJoVFJEU2RlZ2dHeTRvTDR4eG5PcE4xdnBpVXRLeldGZUlwcWp2?=
 =?utf-8?B?ZmtaRUppZDNSQ2lXSm1UOTY0ay9kNC8weGNLUzdybnFRRWRMU1lOclg5SFky?=
 =?utf-8?B?cUVKSUtpb1F5a0ZPeCtxbWxwTTAvY3JzZmJtMmpWU2lmQmJLSlpOQkMwNUJK?=
 =?utf-8?B?Ym5oclBSVUlRcWtGUjJ6UnVJbDh2YTdhcFVPTXJMRUlQN3VkYTJVTDhsRFBr?=
 =?utf-8?B?cjFMV1VVNjk2eklQc2ZiYnJOc2tjWkRrNDNIbzA0aFMzMllDY2RENk5XK3FK?=
 =?utf-8?B?VGY1MGZ0UnBPcC9udjFKZ3d4aS96eENrd0tIZ3p1VFVNdUR3VkxKd3c5Z0hS?=
 =?utf-8?B?K2lORTJBOWZMZHdGY0dON2dTTkFHbGNWZmRVMjZKbTdoK0ozenIwUjFjcHBn?=
 =?utf-8?B?L0dzZjhURjFHeVhZbUVtZ3NMV1NSUzB6Rkp5NVdUNllqTGI3MkttU3Fidmkw?=
 =?utf-8?B?ZGtTZ2dRcHBDVmZUWHFtWjE1STQrM0VpbzRqanlUQWhYVkV1aDAyTVFFOHp2?=
 =?utf-8?B?aFdoYmhLWnNhRGtocTFXWXNnMUxtUXR6bnZDUGl0ZUlGSUNkR3I4T1FYaUQz?=
 =?utf-8?B?cGJjNGZXZVI2ajJPdHFRME1XRFdwQXdJMDFUaWZyV0I4UEgzZS9wNTJIS3k3?=
 =?utf-8?B?RWhNNFVyV1NaSXRLSC9QOTAzVUJmWi9tOEhFdlkza2dXczZJSzFNM25ZYStU?=
 =?utf-8?B?ZXVFR3Z1bDRKWFJpaTVIQ3c3QzIrOHdhd0tQTjI4TEpVcmloNEtRcUlFOTRQ?=
 =?utf-8?B?NytlK0gyempZbDdRNTQveDlJUkZpMGZnamFKckxLanBjZ1ZUQTJUTUNmVFQ2?=
 =?utf-8?B?R0NFb1F5SjJOdm8reXVsMjZOWUNvN2lYd2hjL3Mwak1QUGw5S25XYjJzOFZJ?=
 =?utf-8?B?M1YvZ3I3Vm8rQkdaK0NCcmNwaHFrY1VMNWZRV2FrWnRUdGtnY1hmV0ZWUHVx?=
 =?utf-8?B?bmhEZ01Kblo4UW9mTVhUMFQyV1MyY3QwYkMzNmZpeG9rNE9JYWhzYmlOTUlt?=
 =?utf-8?B?RlEyVDVoanFLNlI0eXlZdWJ5NFJ6dlV5dXNHZGhWdWE1N1Y3aC9nNFQwdmNY?=
 =?utf-8?B?b2k1SHRXMXBCclNNR0FqSFQyaDFBeHBQN2tML3ltUzk5OEVPMWg4eU9rSXdZ?=
 =?utf-8?B?bWlER1lKWGQzVDdmYnBzdVZtNXFldnV1NkZWU2VKYndCeXo0WWFoMW1BNW1Q?=
 =?utf-8?B?UXA3UHphSis4UVNxUGhhbDdwZ3NUUXdzNEd6TnIrSlQ4cmN2WFYxMm5XZ3k4?=
 =?utf-8?B?MDUrT2FGd3FjSTVXWndGdXl1SmtieGUxeE15QzhDT0lpSkNxeDJHSlFiUzQx?=
 =?utf-8?B?QXhBOGQ5V3E1Ukt4azlpY1djbnB4TjljcEV3VENtQWhWaFAzMUpGZ1ptdWNs?=
 =?utf-8?B?MVlsSklCdjFDSng1aVN6UERlTnlIZ0hPYjZ6TktETTR4cFljOTAwcVBIQUlL?=
 =?utf-8?B?aGhMNC90U2VhV05JUFd3aDdNZEVXWk9ZeTUzeGF3R1N3emhkd1IwcWJXcTdP?=
 =?utf-8?Q?vAtw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf45d9d7-5361-4c33-31e1-08de20fcf360
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 08:33:11.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/znYtAyzkGpiDD3XhQPPDyx/WrPm2XYDM0W+8JqdJf9EwrND4cZPIddvvS2RcX9vGfkT5Ua96F24BeAfZp9Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11789

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRv
ci5hbWJhcnVzQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjXlubQxMeaciDEx5pelIDE2OjI5DQo+
IFRvOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBQcmF0eXVzaCBZYWRhdg0KPiA8
cHJhdHl1c2hAa2VybmVsLm9yZz47IE1pY2hhZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwub3JnPjsg
TWlxdWVsIFJheW5hbA0KPiA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47IFJpY2hhcmQgV2Vp
bmJlcmdlciA8cmljaGFyZEBub2QuYXQ+OyBWaWduZXNoDQo+IFJhZ2hhdmVuZHJhIDx2aWduZXNo
ckB0aS5jb20+DQo+IENjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDQvNF0gbXRkOiBzcGktbm9yOiBtaWNyb24tc3Q6IGVuYWJsZSA4RC04RC04RCBt
b2RlIGFuZCBkaWUNCj4gZXJhc2UgZm9yIG10MzV4dTAyZ2NiYQ0KPiANCj4gDQo+IA0KPiBPbiAx
MS8xMS8yNSAxMDowMCBBTSwgQm91Z2ggQ2hlbiB3cm90ZToNCj4gPj4gcGxlYXNlIGR1bXAgdGhl
IFNGRFAgZGF0YSBmb3IgZXZlcnkgZmxhc2ggdGhhdCB5b3UgdG91Y2gsIGl0IGhlbHBzIHVzDQo+
ID4+IHdpdGggdGhlIHNmZHAgZGF0YWJhc2UNCj4gPiBIaSBUdWRvciwNCj4gPg0KPiA+IEkgZG8g
bm90IGhhdmUgdGhpcyBtdDM1eHUwMmdjYmEgb24gaGFuZCwgSSBvbmx5IGhhcyBtdDM1eHU1MTJh
YmEgYW5kDQo+IG10MzV4dTAxZ2JiYS4NCj4gPiBJIHRvdWNoIHRoaXMgY2hpcCBiZWNhdXNlIEkg
bm90aWNlIHRoZXNlIHRocmVlIGNoaXBzIHNoYXJlIG9uZQ0KPiA+IGRhdGFzaGVldCwgYW5kIHNl
ZW1zIG9ubHkgaGFzIGRpZmZlcmVudCBudW1iZXIgb2YgZGllcy4NCj4gPg0KPiA+IFNvIHNob3Vs
ZCBJIGRyb3AgdGhpcyBwYXRjaD8NCj4gDQo+IElkZWFsbHkgd2UgZG9uJ3QgY2hhbmdlIGZ1bmN0
aW9uYWxpdHkgZm9yIGZsYXNoZXMgaWYgd2UgY2FuJ3QgdGVzdCB0aGVtLg0KPiBJZiB5b3UgZmVl
bCB0aGlzIGZsYXNoIGVudHJ5IGRvZXMgbm90IHdvcmsgb2theSwgd2hpY2ggc2VlbXMgaXQncyB0
aGUgY2FzZSBiYXNlZCBvbg0KPiB5b3VyIHByZXZpb3VzIHBhdGNoZXMsIHRoZW4ganVzdCBhZGQg
YSBjb21tZW50IGFib3ZlIHRoaXMgZmxhc2ggZW50cnkgYW5kIHRlbGwNCj4gd2hhdCBzaG91bGQg
YmUgY2hhbmdlZC4gVGhlbiBpZiBzb21lb25lIGNhcmVzIGFuZCBoYXZlIHRoZSBmbGFzaCwgY2Fu
IGRvIHRoZQ0KPiBjaGFuZ2VzIGFuZCBmaXggaXQgYXMgeW91IHN1Z2dlc3QuIERvZXMgdGhpcyBz
b3VuZCBsaWtlIGEgcmVhc29uYWJsZSBjb21wcm9taXNlPw0KDQpPa2F5LCB3aWxsIGFkZCBjb21t
ZW50IGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJlcGx5Lg0KDQpS
ZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBDaGVlcnMsDQo+IHRhDQo=

