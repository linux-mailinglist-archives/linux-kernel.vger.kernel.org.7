Return-Path: <linux-kernel+bounces-884652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5BC30B10
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 905CC4E3822
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07902E5B1B;
	Tue,  4 Nov 2025 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="rjLp4Rfj"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E42D8371;
	Tue,  4 Nov 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254896; cv=fail; b=X0ldOc5MySInEiXDvu611kRHuPVJzJPhQO1zgx3RyUGoN9S13hzbBorRkOqyBXQTE7kZ7vOYlE5Af1ouSE+jyXknAsp7WePdBInLz5xpXhNDsGWr6zTt7rL9g9uJSSUBPB8SpacN+r1AI72ESMi3MhLWa318BTzBwFVWlZcRwHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254896; c=relaxed/simple;
	bh=C065+WwILlHuONe5iL8npz/lPNFKVkpvC/xIcTFoYKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XR9C6pj6ndSzri5e2JnywNEwf+9folVABBGSwGrBNn4WzdevZod19lmiOI7yzd6/5OodbuIACMMcimJeLn7ph327sD1yVT0/GXc96Ji7eJydGsFkitcUmCGbkWBAHviTujW3wh5AhdsH1f7k3TJBWcdgen1TI1oa9Azze7YYF9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rjLp4Rfj; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHPzbM2EfNfnzdE89e2yHb5WuCy8f7Clxv39WDdmiaVlc+8PRYpn1O6tXxFWltC6nZy3wW78h3Uaug2blo5Nj+V/bZKhmU+kMb4jFaMBOJGQuecPihUPOOOciFhRL0PufL01HEHM/QggjNC/5SiAPlMjyjmld2+LgkpjXK9Nler38RmDDzW7VwPtfFS3syP4NsOHUydExP7n5yOukopUkx5iPPxVHSGqhDgadl+h/jhwcJgef3ISa9zFoC34YQRrTZEnzmhJ55m0iyGFC7QWXc3QNvOof+Z+sObr7tZOGUmnHYGsTEYQ0XPKm5oDc5S2GzAzkS7bGaahf5bDXjE/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C065+WwILlHuONe5iL8npz/lPNFKVkpvC/xIcTFoYKE=;
 b=ll/fJzh8hFgP8PDKfJ3CZsjB5839wDUp6mpzYNp3sMbb9q3gPEqg87V5yL64lKWN4AhAQA6J4X49wxpHRjmsXh0ThWa3sjr8EBg6XHI9PeFOGOVM912mvbyawBom+T5EQHVGeNPVm6vlAvofDNUSABhoKjbr5zRNudPrsoThjxmaTFXCnC9GFV869xGC1yST1QpHSznmy1TlkRmOLShKJ0dhK9OLMZXqnoCWItAoLxuW7bTMT53qlHgxdufAoBVCj7Eu2KiXRELR3HWW0fuQUplMDcClUMWoYjk2Re/E4OsAyovulWeIM6PztX7IbG4l4SzBE2WU0HJzLUDFt+5wRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C065+WwILlHuONe5iL8npz/lPNFKVkpvC/xIcTFoYKE=;
 b=rjLp4RfjPuNHuK8StlZnLcvNfT9HOhFjfLSlYlFjGZFvUfmxuEtLB0az8GpR/SNQ7wJWtfoYJQRonajq+fRnmXQaKoqZONAms5Tq6DYqdi42Gmm8OjtKfBY7ZVEx0i7jx/cHvdME/yFSk9lGqv2t/eSWp6GpLT4tl6Kny/DXqJlfPk2+zzFESRJ6NRtT9Z0JagyLAehjc0XSmKBtuG2SJouOo30u1S4DZQVE904I2wk+KQN9d5rRi9f6cjvP3vvNCMAxY3PRC2xJz2JGZIpFechWfcyPl2HT4joSmPjEs27PfhRNQyc5yjgLVCh4fr+KTdDMbAN4LwYNVLbWUO8HjA==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CH2PR03MB8113.namprd03.prod.outlook.com (2603:10b6:610:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 11:14:51 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 4 Nov 2025
 11:14:50 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Ng, Adrian Ho Yin"
	<adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Thread-Topic: [PATCH v3 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Thread-Index: AQHcTRsfYhpQdyjrIUmvh9KarfOPLbTiRhoAgAAYKAA=
Date: Tue, 4 Nov 2025 11:14:50 +0000
Message-ID: <fc68b68a-586c-4af6-ae59-85b79d1d8002@altera.com>
References: <cover.1762135710.git.khairul.anuar.romli@altera.com>
 <ca75b88a64412274d415e17d4aef6dd018ac7167.1762135710.git.khairul.anuar.romli@altera.com>
 <20251104-bipedal-sheep-of-advertising-08450c@kuoka>
In-Reply-To: <20251104-bipedal-sheep-of-advertising-08450c@kuoka>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|CH2PR03MB8113:EE_
x-ms-office365-filtering-correlation-id: d8be3010-6999-45e5-05d0-08de1b935f6c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEtNTG9QMGdHVThkUjhHRWR2NHMwQkU2blJKbFd2SFhnR2JsTmNHcUE3Y2NB?=
 =?utf-8?B?OHVSTkdTZHQySmhjaytiT2QyUEpHRi9HUlJKZm0zSmF3cUFYMFdDR0JWVStq?=
 =?utf-8?B?N25OUzlabDVTZzZxcjlZenlWNktoWHRpaVo0aG1JeW9mQ3o1b2t5MVdFVlNT?=
 =?utf-8?B?U1VBVTIyOFA1VnN3bUY1QmxjSGd1T3hLRDJpbnJVTTRzYXpMdzhMTkptVEJa?=
 =?utf-8?B?a1pMVjNWMUhNRVpSWGxVUmlmYlRPOVUzUUpKQU5Yb3lhQ0JTck1FUDZLenZF?=
 =?utf-8?B?d1p5dkYxZ1RPdmtEL3hUOUg0Rk5PV29NRWlIRnlRMkMrWmdTekdaUmFmd3JT?=
 =?utf-8?B?N2ZoY0lmSFdCN1o5Y1BOMmdqQ1ZtbFplaFFPL0NLa3Z5Vy9TeFlxeWtxcUpE?=
 =?utf-8?B?R1FTdjA5cUdwbVB5aDRPdCt4NFlVbStVYm5nUXRGOWMrUkpBRFVOUzRCWU92?=
 =?utf-8?B?SGsxZkhRYWFpRW9VcGNqemhzTGNXN0M0MGxVZHNMWHhKOFR5ak1OZGdrY05j?=
 =?utf-8?B?R0M4d0FoMGVKM0lwYTR5SHdHcXgyKzhjZlhFOGwrazlhY0xHNDNuWEgwakkw?=
 =?utf-8?B?Y0dGL25KWVhybmVzU1IzKzZWS1FReGFXVnVjalgxMlJtWHZVbEYycWNYNXFL?=
 =?utf-8?B?bkNycUZJTTFTaE42RUVEanhYeUhnQmZCRXVaWnlnbUY5NHdrd0tVUEx4Q0RR?=
 =?utf-8?B?TUVYYjZpZy9vQW5aeHR0bHkydStMaENyV1grYTdVb28rbUJLekZwQUVxWFVj?=
 =?utf-8?B?TjczeEVzTWVnS3RzNUVJQWpCdHhaQ1BKY1h1alZMeVBLT1g2d0k5T2d6YWdk?=
 =?utf-8?B?TTUwOFBHc0Fkayt2VUZvdXZlSWVlaWQ0RmhLaHlhNENySWNJRDA3Y1NiNTBH?=
 =?utf-8?B?dXFPejA0ZngwUzdIUjJtelBPTHVsOFNjUi81OFZuNy8vTEhDY2I4Z09yTDU0?=
 =?utf-8?B?TmhLd1lKdGxadUdIL1VkNHF0MTErZzhZUFFiVUFMamREU2VybjhGbmNjUE5p?=
 =?utf-8?B?WFo0dExVT0QzMTNVUjhxVWdLS0tQb2ZETGRSTVExZkJPVlB3UFdMUUJMNTV4?=
 =?utf-8?B?cUI1QzhBWVV1NGUxZ3F2VVc3T2lkd25ZQmFneHlsNitGMHNFUEdxY3hYWGRk?=
 =?utf-8?B?cTFKSWhWdTlLL2NBWW40cktuNjNSUXBIczlXVVFOWG9UdnN2TXlKUkV2TFJm?=
 =?utf-8?B?UkZJcWJqaXZlb1NsS29qNFdGMFVOQ2xhQmY1UHh1VmVMUU1uaGNncHVDVU1h?=
 =?utf-8?B?Q2JOZDFEazJlMXFKNTkrazFKci9HYzZYcjBobTk4YzZqbFZYdzAweVJBdzVZ?=
 =?utf-8?B?b2ZGblZZRlBHVjZtcDFISlgwbElOZXU4K0JLdEpNVUNkQWUzTlN2TFV6TVVj?=
 =?utf-8?B?eXZxL3FDM2lVN2UyWmlBVjdQRXd1Q08vWi9yRUlhRUtDNURJamxCS1hndWZt?=
 =?utf-8?B?RnFDY1RkS3RldXlmby9CbmZ5REIxUWxSOFpFSjR5R04rU2ZHUFlYejhXWjAr?=
 =?utf-8?B?alVPLzJHbmVvV2pkU0xhTHNyZE1TNm9qSFFoZXhvSitDcGZHWCt4QnFwVlll?=
 =?utf-8?B?eGZCT0R5bEZLd3FVT3NFdk9RazdIWnB5V09Qdk9QT2h6MUZzbmtCTk16dkRI?=
 =?utf-8?B?VXlkS0xBdGFXeUIzNURvLzhnd2NjOWpFMTBpWDhGVXNwMjFYbnllcHZSODJs?=
 =?utf-8?B?V1BKSko0cm1XZ094aDExSkNKTEdtY3I1K2tBdm9YS01KT05NMVVyV1Zra1Zu?=
 =?utf-8?B?SkhxN0xFMTBvWHYwVzB0d1lNNTl6RVp4eXpYMjRla2hjMGdmaEFsb25NYUFJ?=
 =?utf-8?B?R1JqRFRoQi9KM3R4SytRMTFsRWw2anVoUFNtaFppM1N2OFBjK0gxcndaYjkx?=
 =?utf-8?B?eTQ1c1dCUmVUblFUQjludnF3dWg0bUtUa2pBckFNUW1XNVdWaEROa0JLRkRN?=
 =?utf-8?B?MWEwdlBhbEtKYXA2R2VWYVpBWngreXpOSWhFVDlnbkI3QlFQVzV1U0ZWV1d1?=
 =?utf-8?B?SElhTnFCT0xCcW5lZ29RTlovNE40aStzdWFYS205aVBlTm1ETDdXTE1taUZM?=
 =?utf-8?Q?q0BeDy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVI1UFdhRUZ5K2NHVi85ajR6cXdVMDE3RkJ0VG9UZ0VtdjljYm5wNjZoeXR2?=
 =?utf-8?B?QnJIUVllVmwrbFVsZy9wYy9LWUNoN0pQVWliQ3FmU2sxVzQ3UGN2aXIzY3Zn?=
 =?utf-8?B?VnRuTW1mZmxjZ09qWlN5UmZGWUQ5OW1vbGVaNFFSemhhVmkvRmZidzNiRFVr?=
 =?utf-8?B?QzZ3blEvM296TEcyZitYTi9ucXZJMVpKWnF2SGdwaXB1UnB1ajVEOTBabTda?=
 =?utf-8?B?SGRYZnBza0dISDdvT0t4YnNlemdjZU9ReUh0SENxZUhvQXlGYVRPcG1kZWtX?=
 =?utf-8?B?YThrR3NVUUF2b2UzT2diWkdkMTFMOU01a3FhZ3RvSmpCcGROdlZuUEFwd0N3?=
 =?utf-8?B?bFpBMytNZkVjUjNHWnc4b3NyUFB3YlZ1WmU0enMzUW42bUNHZ2Znd1lrU2pV?=
 =?utf-8?B?TkNtbkhOTGZTZzI1RmhIdGNrSGtSQW5iTWdZU0FuaG1HREJ1QzR2L0x0NW5E?=
 =?utf-8?B?U1dCY0JzckZEaTMzcEhkTVNkb3dCbmV6RXI5SEt2Zi9sbVgwVmhQNDNPWUZV?=
 =?utf-8?B?YlpZamg3TDJvZmlSMU1xdGc0SHY5cEFLakFLM1VQTThhWUFCeUhRdXdWbG9V?=
 =?utf-8?B?bmF4a2dRdVFLK2lzdEFOTHlteGhPOU51MFdKS1Z4MXEzM0lNak16VXRVeWZW?=
 =?utf-8?B?S0JwSHpTZXJDTGtnQ08rRUJtaUd5cm5ka3o1cUxTSXZONERZZ2ZUd1FWaGd2?=
 =?utf-8?B?VmxYakJGYUtOZXIyV0ptc1EwWUZLZ1JvRFUxa3BWdm11VTIrQTZ0WlpxZnpm?=
 =?utf-8?B?VHZOQUw1V0liYytJVko2MHRkY0JyTHk3S0FBZC9KdFNFaWV3dXJKNkhWaWgz?=
 =?utf-8?B?Y29MVDNBTkdhMGVmVUNZcEk4NUNZRHVLZHZ5UGFaNGlNVDhzeUd0bXU4Tkla?=
 =?utf-8?B?ZlhxeEoxWWkzSE5YUHh5Mkk2SUlsVHJ0NzRiYmxDRklSNGdBUlRDM0hDSjQy?=
 =?utf-8?B?ZkpkeThYR0puTDBuczhncEhCdXRoRnJLcld5MW5FWEFQUUVMdlNISG5vRTBR?=
 =?utf-8?B?emVLMzBKZ1p2QzlMVFUyYXVwRmhBaWQ4dkcwc3ZuVENZbk9WSkE0QUNxMEZj?=
 =?utf-8?B?Q0NtL0pERW1aTTB3TnNnNVo3QVNKL1BaOHBPUFA1SmppUkVoc0FGT1YvQ3Rl?=
 =?utf-8?B?Z1pWYldWbU1ka0dJdUJlSkRZT2V2U0lrenZvemxxRkJYbFdzbXBZTTNrZTA0?=
 =?utf-8?B?MUI5b1o0QXQ2cFZpaUlrckFNZ29GZGV6OW5pZm90R2twb2xUSFcxRlRkQ1VQ?=
 =?utf-8?B?eDdMdEx2ck01eVJKUzd4ckEzRGFlV3NwMWhUZWRGd0t6R3lObDRHMWVvUzk5?=
 =?utf-8?B?Tm9mekllWHpSNFpVcEtZZWJlZVAyYUFzdy8rby9vSE1oVFV2aldMMEd3RHo0?=
 =?utf-8?B?K3ZLMktrQ3hCYWlDZjJudVNLeTBKamVDMWxkUjAvQzhuOE90SVh0NlJ4Nk5F?=
 =?utf-8?B?ZWJjWDFrd0s3dlpmSXZLRm1pbVFlajk5WW4wZE1YcjUxMmI3VVhPR0JxcWxG?=
 =?utf-8?B?MWlwanpvNmhKQUQxR2JBcE9idVdyeDJaWE1uVTRuazVhaHdnZFhTWEpPZmQ1?=
 =?utf-8?B?RHk0MUpTdC9Va2c1bTJ3UkVZRmpyR1hvRlBpYWpjRVFvdWR1K2t6V245a0ZI?=
 =?utf-8?B?YXBsa2Z4SVliZ0RKUTFGdDBQVVJTdTN0dEh5dHJ1VmRieTdjVW4vellreUJU?=
 =?utf-8?B?eFM1WEhiWFZoOTRGS0pLb3g2bVBFUHdHUWExMTdVdGxtcEYvS0RjZVhENHNz?=
 =?utf-8?B?OHBLRjF6R2xaWnpZQU81VWxCckVzaFNyTWRqUXNObnErZGppTVNMdmY1akRN?=
 =?utf-8?B?Wk14SmMrWE00OGpPb2sycnh0TStzdTNWdTZlV2t6WnpNVGtGL2wyRkt4NHBU?=
 =?utf-8?B?VTBFaVU2enVKNXRZbTgzTEpINkVwaHpLaGdjSU5oZzBFcWFkYmVhU2EzQ3Z6?=
 =?utf-8?B?TURKUU9BaVZwTjlwV09DaTRNV0VtZUVjcU9pRVFZM0U3dUQwN0V0aVVySU5l?=
 =?utf-8?B?Ty9Jb0NxMGM4TVRaVkI2cEJHK0dodGRnNFRVR0tSbmRSSUxuajZBQ2EzQUgx?=
 =?utf-8?B?dXhTZm9nMEhaRFhrTnBOajlOTXhia2tjdHZqQ2FDWXRuSVdEZ1pRcHZGRFNu?=
 =?utf-8?B?cy9pdkJGWU41OVhOMmlHNU96cEFncktxdkw3T2JWUURTbXR0NFhWSE1pVkJT?=
 =?utf-8?Q?CmWUutjhvv7tJw/SZPTRZSU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C13D733C613644489120B4E110EC4893@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8be3010-6999-45e5-05d0-08de1b935f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 11:14:50.7789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zY86SLvJ90zqgNFd3uRY1LnOKWfAVLHxckFet5mjnf5kspY42NWCA7h5uNjMa+GEF5lHvA5wW+QxFVYIFOUzRvrS1HCmVerNum3avCF8jHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8113

T24gNC8xMS8yMDI1IDU6NDggcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIFR1
ZSwgTm92IDA0LCAyMDI1IGF0IDA3OjM5OjI3QU0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkg
d3JvdGU6DQo+PiBJbiBBZ2lsZXg1LCB0aGUgVEJVIChUcmFuc2xhdGlvbiBCdWZmZXIgVW5pdCkg
Y2FuIG5vdyBvcGVyYXRlIGluIG5vbi1zZWN1cmUNCj4+IG1vZGUsIGVuYWJsaW5nIExpbnV4IHRv
IHV0aWxpemUgaXQgdGhyb3VnaCB0aGUgSU9NTVUgZnJhbWV3b3JrLiBUaGlzIGFsbG93cw0KPj4g
aW1wcm92ZWQgbWVtb3J5IG1hbmFnZW1lbnQgY2FwYWJpbGl0aWVzIGluIG5vbi1zZWN1cmUgZW52
aXJvbm1lbnRzLiBXaXRoDQo+PiBBZ2lsZXg1IGxpZnRpbmcgdGhpcyByZXN0cmljdGlvbiwgd2Ug
YXJlIG5vdyBleHRlbmRpbmcgdGhlIGRldmljZSB0cmVlDQo+PiBiaW5kaW5ncyB0byBzdXBwb3J0
IElPTU1VIGZvciB0aGUgQWdpbGV4NSBTVkMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1
bCBBbnVhciBSb21saSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4gUmV2aWV3
ZWQtYnk6IEFkcmlhbiBOZyBIbyBZaW4gPGFkcmlhbmhveWluLm5nQGFsdGVyYS5jb20+DQo+PiBS
ZXZpZXdlZC1ieTogTmlyYXZrdW1hciBMIFJhYmFyYSA8bmlyYXZrdW1hcmxheG1pZGFzLnJhYmFy
YUBhbHRlcmEuY29tPg0KPiANCj4gVHdvIHJldmlld3MgYnV0Li4uDQo+IA0KPj4gICANCj4+IC1y
ZXF1aXJlZDoNCj4+IC0gIC0gY29tcGF0aWJsZQ0KPj4gLSAgLSBtZXRob2QNCj4+IC0gIC0gbWVt
b3J5LXJlZ2lvbg0KPj4gK2FsbE9mOg0KPj4gKyAgLSByZXF1aXJlZDoNCj4+ICsgICAgICAtIGNv
bXBhdGlibGUNCj4+ICsgICAgICAtIG1ldGhvZA0KPj4gKyAgICAgIC0gbWVtb3J5LXJlZ2lvbg0K
PiANCj4gLi4uIG5vbmUgdG9sZCB5b3UgdGhpcyBpcyBub3QgdGhlIGNvcnJlY3Qgc3ludGF4IC8g
c3R5bGU/DQo+IA0KPiBXZXJlIHRoZXNlIHJldmlld3MgcmVhbGx5IGhhcHBlbmluZz8gV2hhdCBl
eGFjdGx5IHdhcyByZXZpZXdlZCBoZXJlPw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCj4gDQoNClRoZSBwZWVyIHJldmlldyB3YXMgb24gdGhlIHByb3BlcnR5IGFuZCBjb21wYXRp
YmxlIGFkZGVkIGluIHRoaXMgcGF0Y2guDQpJIHdhcyBhdCBmYXVsdCBmb3Igbm90IGVtcGhhc2l6
ZSB0byBjaGVjayBvbiB0aGUgc3ludGF4IC8gc3R5bGUgZm9yIHRoZSANCmxvZ2ljYWwgY2hhbmdl
cy4NCg0KSSByZWZlcnMgdG8gDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5
L3Fjb20sc2M4MjgweHAtcW1wLXVzYjMtdW5pLXBoeS55YW1sIA0KYW5kIHRoZSBjaGFuZ2VzIGNv
dWxkIGJlIGFzIGZvbGxvd3M6DQoNCnJlcXVpcmVkOg0KICAgLSBjb21wYXRpYmxlDQogICAtIG1l
dGhvZA0KICAgLSBtZW1vcnktcmVnaW9uDQorYWxsT2Y6DQorICAtIGlmOg0KKyAgICAgIHByb3Bl
cnRpZXM6DQorICAgICAgICBjb21wYXRpYmxlOg0KKyAgICAgICAgICBjb25zdDogaW50ZWwsYWdp
bGV4NS1zdmMNCisgICAgdGhlbjoNCisgICAgICByZXF1aXJlZDoNCisgICAgICAgIC0gaW9tbXVz
DQoNCkRvIEkgbmVlZCB0byByZS1zcGVjaWZ5IHRoZSByZXN0IG9mIHRoZSBjb21wYXRpYmxlIHBy
b3BlcnR5IG90aGVyIHRoYW4gDQppbnRlbCxhZ2lsZXg1LXN2YyBhbmQgdGhlaXIgcmVxdWlyZWQg
cHJvcGVydGllcyB1bmRlciB0aGUgYWxsT2YgYmxvY2s/DQoNCk15IG9iamVjdGl2ZSBpcyB0byBz
cGVjaWZ5IHRoYXQgaW9tbXVzIG9ubHkgZm9yIGludGVsLGFnaWxleDUtc3ZjIGJ1dCANCm5vdCB0
aGUgcmVzdCBvZiBkZXZpY2VzLg0KDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCktoYWlydWwN
Cg0K

