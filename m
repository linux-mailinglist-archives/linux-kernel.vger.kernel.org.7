Return-Path: <linux-kernel+bounces-811199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0EDB525CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92ECF7AF36D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627A1E1E0B;
	Thu, 11 Sep 2025 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L5o3/6c5";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D1nYeZzU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ARbrsPBK"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0119D06B;
	Thu, 11 Sep 2025 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554613; cv=fail; b=EXqq4MbS8kDC39h27e4sjMlRo1/p6q/5K5cU8oGhFi15ReGE6ZjeGVtqBAAKVBIrEdReMAE5GKlzyhmCSM8/NoBIKW1eDgCCede04Kev04jbossopvepRqL8CFD59KDJjDJbCY4bUpmGNLaclZRvZtlMDZMR2dNom0nlKo1rKqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554613; c=relaxed/simple;
	bh=rmZQL0L5QYKcTZIn+6kn0rPLtm+p1E2rQC6r/7ahLvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9bcHTd9kBJj+baQlL7k7kaEX+IIKk24eN0ynnvp9SjfF64nuO2AQ6UQm/DwIEszs0aBCoFdS4ixCRaChbadWv0vl1oCeqILdrxqE300LuRdorrEzsX8FcxyXXGIdy3nwpofMNOdCM9dH9uoOJ6SMkyC7J/GF0P90qIFchJSq3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L5o3/6c5; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D1nYeZzU; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ARbrsPBK reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALTgRx010390;
	Wed, 10 Sep 2025 18:36:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=rmZQL0L5QYKcTZIn+6kn0rPLtm+p1E2rQC6r/7ahLvs=; b=
	L5o3/6c5QX7Dr5zYXZK6STj3MbyrOf9Jw9ZG+cLhPR5QQ3QMO3L4zoPWGbE+IHx0
	DzJ4R4sSh4mqELqlXsHo3Djuyq9N0k0fpkVO1yOuX10uVo15k3emjlCL9ZTAZlon
	mAk7sn+ZTZ9SKog7ZrefOmRWSilaTmb6bK8W6TmgH+x36+mQictSSJPSi2Isx0n4
	HX5Q2R0PSJ/1c3HetGI7EMafffxWQk1RRpnd11lZS3QsDMw/d34ID1kOiRPMZb93
	7VaE6vu627SyoW7c/xmQXTYvI4KbEyESH8JqywdQlVswgxcDMsE+sd/1zfdyEpZY
	cJJjS9L0/wz5j3/rPq7K9g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 490kvxqfhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1757554595; bh=rmZQL0L5QYKcTZIn+6kn0rPLtm+p1E2rQC6r/7ahLvs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=D1nYeZzUqXVrKSltkDvZ7uy20HS9466KbxD827eN/1Tw9X57rAnCu/Tfssu7Nm0Pn
	 KItgEPqDHlgNLKonHbrjmOMPWBWpcTtRkTNUEl9NSfj8C64zS18D51hlyFJy11nPjL
	 Kb2ALZM6YSwz3QpPxfz5L07B6pTaMxoCh0TdhYmndjiBJCbAAzFvCdG8VnCC5MAgUc
	 wxTWi4A7P3TO4RwGPo/hS104GnfacUHxILHuVXskoekx5dTtky/K/W7M3BuTgw/Xtn
	 MMeS/lQiKNQ81qFFxuND2ChBrSt1UTlrEbT7oYWHOX+EC9+mm55lzmIcsQ3nrw2ANB
	 edVM8M5bwnz6Q==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CB1264035D;
	Thu, 11 Sep 2025 01:36:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AC913A006F;
	Thu, 11 Sep 2025 01:36:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ARbrsPBK;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C4F3C401E3;
	Thu, 11 Sep 2025 01:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8GMA+0oOn0rrJVPKZqxeiuq3JLhV8x+9poje8gcaj9c00xrBmvsWxr+N3JZK6VaASTakLdHx5NHgVFyqOpPAm0QouhgnKmtvA/IH4DbJtxl5PGDm4fPd59W+fz4OOEsPfFQzRYMZ9TLkuQiHAXTWlJBqirWrWZVvjhpPrwt2v8eJIWbKo4r1FC8o1VNVuhNljvc6TxTtXxoP4AH1Au1Bya2ONJYZ3cgEeDO4lOJ1N3fstTRZh78X3fgQmD5/Fn0r5FX1FFIje+mC5Cv4Sn6MYKu+Vetz0hIURlb/QZ+Pt+MDGkZmulwRg281bPoqMSie33j3BpeVwoDJjGyQZdreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmZQL0L5QYKcTZIn+6kn0rPLtm+p1E2rQC6r/7ahLvs=;
 b=XXsyGbh790z+l66bYVEWG1ITiMwPoJQt6JANAPU63HmRBLHvPDHZhikNgDIbd+LKY9SIgC2UvXZJjA6+uzFzCfe+bzNSSjz46lPOiF27SAj9SjJsA4+PMxWhJqvSdEKllhinK6ot6F9DQPGA8CH7ZoqA0dpTuoIkpZ2ZcghafT9q8b1WiS/B/DDel+O8FEzor/1I1BIPUYDBdy0ueBI+QFuF5UNKqNFLaIYXv5C6kgFBX2LHiCqKQkhWbKaly5aZn9taGG2Dz4GXpKhpqcGr2TPzmSvBJapyNG1oQzcfaOfIJDsJoEnukNeYlVrQR1ABuY99I1bjD1FbFJf5QbuFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmZQL0L5QYKcTZIn+6kn0rPLtm+p1E2rQC6r/7ahLvs=;
 b=ARbrsPBK8K7f/k4PWqoiuRQGOOsKC4ZBlvk2dqyd74rqQt1AoAH43KYUu7H2LV4nncq6HnbY1RiseVr7ZjehKxR+uT4U/S7W5QCbmcBQq+GxtLt83ouPbAS72zZTz+ji0k3n0nrSTcQb/HA+uZmHRFDfv9spLjOIZpU6D4ULjnM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 01:36:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 01:36:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Log dwc3 instance name in traces
Thread-Topic: [PATCH] usb: dwc3: Log dwc3 instance name in traces
Thread-Index:
 AQHcFbWpI8fQ113kKk2/GPa4dCHPkLR4sG4AgAVxqQCAAnmiAIAAd12AgAEfOICAAJl/AIAA9GWAgAah1QCAAuuNgA==
Date: Thu, 11 Sep 2025 01:36:32 +0000
Message-ID: <20250911013631.hv4ibt3j452tbsex@synopsys.com>
References: <20250825114433.3170867-1-prashanth.k@oss.qualcomm.com>
 <20250828224852.ukelgargocektp3z@synopsys.com>
 <5b30f63a-5999-48f1-972f-93f02fcc0ec2@oss.qualcomm.com>
 <20250902234450.vdair2jjrtpmpdal@synopsys.com>
 <67329e66-2221-426b-88a4-eece06d694ec@oss.qualcomm.com>
 <20250904000003.b4j7fnucronjf6ej@synopsys.com>
 <745a2b9c-078d-45eb-97a7-3a27a4bc5191@oss.qualcomm.com>
 <20250904234409.etyz6ep3y4rfr3he@synopsys.com>
 <d805d060-be0f-4d23-ade6-683bf5ffebc6@oss.qualcomm.com>
In-Reply-To: <d805d060-be0f-4d23-ade6-683bf5ffebc6@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB9543:EE_
x-ms-office365-filtering-correlation-id: ce6b237a-2398-453f-6ef2-08ddf0d3a340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Slk0VlF6bm42WGJOUEplVEc0cUN1MWhrL09HczdlbnE3L2VvYVBPMVo2RWtl?=
 =?utf-8?B?U3RLeU9qTTFHUEhScVFJY2Zza1FMbkw0WnFiSmd4ZlkydnFSQU9QSU9KSTR1?=
 =?utf-8?B?dVdtYWhiUkJ2dUc5c2pVRGV5WUhXS2dybWZlZm9RN08yRVhLMTNJQVQySjlu?=
 =?utf-8?B?V1o0NUl1bm9KSWk5RS9oUVdMeUQrVUhySVh1NnpYLzM4eFpsTDQwK1lkRCtn?=
 =?utf-8?B?c29JZFFmeTNGbTZDNVI1SVZEQ0d5d2JnUFJzQTkyd3BQV2JDOW9QVkxkOVZ1?=
 =?utf-8?B?TmNJVjI5RExXV3l0Sms2VVYyMWpUZXlLRjM3aXJzZmRMODFhVVhLWE11amd1?=
 =?utf-8?B?Yk5WMTBVQXEvVmxuUjNyT1hIcERDczFQblIycXNla1h0MmRKRC9zUG5XOW1M?=
 =?utf-8?B?WUJ0alNSRm5jSEkxUjI5M0FDTXlRSGgxYTBHY1gxYWsxYUpHRHJaZ290aG5J?=
 =?utf-8?B?QUFTZjN1RElFOXNoOHFpY3Zld2NoVC9PTWhLK0FqbXJSNk9paGd3RWNaU0pw?=
 =?utf-8?B?VitVVEFad0loQ0VlL0k3ejRjK1VyTTEvd0RSVHJLT3ZVLzI1N3NVNmhUaGRC?=
 =?utf-8?B?L3hyb2puTm4zc2F0SkI3N1R5VTB4UXVjREdONm1abllJcVNEaDFmV2NBSkR6?=
 =?utf-8?B?MTdPQXR6Z3l4cE1UNHBEWSs0NGxhMXBpNlFKMWgwUmREVGQ2SXE4Uzd1bSs2?=
 =?utf-8?B?U1AyR3RrUGtJcno2OXcvMllocjZhYjZyeXRSU0N1azBpdGZjTWdxOVNuV3lr?=
 =?utf-8?B?SDhEQlY1cks3V05NY3RwUTdzb2srdnVIVVZ6TE1Md0pRalNKSUFFNE5wVjk0?=
 =?utf-8?B?QWcyTzRJZU5Vbjc4Vlk3VTBpNHZzWEhpWVh1Yi9DM3hRM041bG4rRk9IKzNY?=
 =?utf-8?B?eVFnM1ZyS0IxREkrUnphMDRhM1A3MkVwNkxWWFJReWQwZXZzN0VBYlB2RWVS?=
 =?utf-8?B?TS9QU0Q1S0w0N0ZlNnNZOU1qNFlUNktvSmxoTCtGUWJGNS84emV2cE5FbENo?=
 =?utf-8?B?aVA0dFBQVGQ5TUdtbjdTc1lUUTJmZXNyazAyMGllSEhQNTlmNHIwaW91ejlz?=
 =?utf-8?B?U0kxZUh1dFFZaG8wWU1vM0kxcldCenplcU1oSzlKWTNwMnJOUlVBV1F0aDht?=
 =?utf-8?B?UE1jT0QxT1oweXJJUENrcmRqY0xtcTRLM0s1UGFjMVhjNTZreU00ZEQzWTE4?=
 =?utf-8?B?T1IzRVIybldnTE9nRFk2REJaUEhVejE1MlFFRllld2Z0VnVkQ0w2amtCanli?=
 =?utf-8?B?RjRkdW05T3F2ajBuazlQb1BRM0NqV0Z0K3FjZWFDYXRQb1NzUFlPdUQ0NlV0?=
 =?utf-8?B?Z01GVGNpQzRNOFNjdUNLNHJob09SYm5XZ1NhOXBsYUVXUDFUY3RsbUluYnpi?=
 =?utf-8?B?Y1U2cm1JeWhnK0JzWkZYWUVSZ0o4aEJXTmcySWV5cFVBaDJkKzNSNTU0SXIx?=
 =?utf-8?B?YnZsTmZSNS85TVRVTUF0K3hHbFRlaGR2MU9tOGdlTkdWdEpaOG9uRDdUOEV1?=
 =?utf-8?B?Ui9DbUZGbEZnRDVhMEVKU041Y1FNMGZudWNORU1jY243elk5SklJZEtGMktD?=
 =?utf-8?B?YlRpNmlRM2lmVDAySStoOTRXTElQUW9GVTJ5Y29kODEyMFByME1sOW94K1k3?=
 =?utf-8?B?V24yVFZUc1NWdEw1UEVYTkd4OHFrZ0ZpSEhPRzNiazE2NlFsYkNZaHRJUEwx?=
 =?utf-8?B?cUdzVVhUODZBZTBmQUEwbUhERmt2UUd3cDZLSmx5MDNlNFAxd3JQQUV2amdK?=
 =?utf-8?B?UnRWMm1wU3BMeW82ODdtWTJ3cnVnVG1EWTZJai9Ka1RidUVpV0RNMjZSSHdH?=
 =?utf-8?B?VXJ3ZWpFMGRyUk1jQUF3MElQdkNBdUM4a2VVUDR2N0tNSDJVSmV1d0dJZ3RU?=
 =?utf-8?B?S2xVQWY2UzhQOXNscWtkVVRFcUJUMDJhbEFVY2dQdXhjNC8wbE9HSGRtUkhl?=
 =?utf-8?B?ZmowVUt5NDZMdHFYOWN3R1pON2tERTdUREE2ek5mU09WLzBuRFVKMVJNbkx5?=
 =?utf-8?Q?HI9/F7xevgW7BLJC1FU2zP8SHXyA44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUsyenZLRUg1VkpMcXI2UWxmZ29kUU1VR0RhOWM5TThITTVqTmVtY3djWDB3?=
 =?utf-8?B?N0xkZVg4RXdrNWI1ejRWTXdrRUV0K2RJUStmQVlVQ0pqVXlhYXIrdGZ3cTFk?=
 =?utf-8?B?YnhieHFITVEwM0JLZGVrQWN1RmpwVHhEQnh3MVJCcXU2V2VPNVZ2WXFCaklN?=
 =?utf-8?B?VkF4L1VyV0JLY1ViVFJYWTQ0cytwYS9LQlpnK2M0V0o1K0lWMTUyTzBIRk93?=
 =?utf-8?B?eGRXS29qU0kxd1VzL29CSktiWHM0U2dWeUJXenYzV1NSb1BOWkhJTmJiWTVS?=
 =?utf-8?B?T0Y2RWVSd3YwRk1hSXk1eGJLeVk4VUNudGc3cVBqTG9CTkIxcXhqUS8wb093?=
 =?utf-8?B?UzBvYnpxQmlIV2pEbkJzOUNhOFJOTE1DbHVhanlwQWUxelhGNmlTRlNERTVp?=
 =?utf-8?B?RmRaZ2w0SlIzQ3RXNndoZzdhWXFGOHVDT1BOUUVsZFBTQVRKSUxSaWJibVRk?=
 =?utf-8?B?OFlNd1Q4K09GeGRxUVBDeSsxOGM1cGZJemNQbEFyQ1dSakF4aVNCZ3Jhb2g4?=
 =?utf-8?B?STFuYytTMCtnbGhtZnd0clRLL1JhZ3dTQzNtQXpSckZXNFJqNGV6MVByd0F1?=
 =?utf-8?B?T3g1cng1cldIaXZqcHl3ODZlNUZZZmxnMkNST25zdHd3RVV3RzVtVWRoRXB5?=
 =?utf-8?B?Y2JLdUdwdUlxcERCRHl2NU1OOGxyNGRWcE5QNjVWTXRHeXpHRWxSTnAwRlhu?=
 =?utf-8?B?ZXVZRStraVR2UENTUys1QkFxSE1MVWMyRWZ3azhyVHYraHJaeFNTYlJEVWdp?=
 =?utf-8?B?WDhBSVJoVk95SUlNbXdtenhsUnFXY1FQUis2Ri9ONnROTjFYditVRHRrbzh0?=
 =?utf-8?B?L3cva2E5RHp6c2hYRlFqN3hZa1FVYjA0OFFZS2ZCai9sc1pKRHRHQ1JGVUJQ?=
 =?utf-8?B?ZjRyVndjUEVFcHFrZnFYS1JINjBxM3RDL2FNREg5Zm5SOFZkKzc5b0xzc0p1?=
 =?utf-8?B?MlNNa1FoUVhOWlI5UjM2U09ka3MybHc2MXZCR0FOYk1yQjdjM1JIU3pxbk1v?=
 =?utf-8?B?UVFpdE12NlJXYldFdUFHWmFGMmZGTExmMkpyMU5yYnlSWlo0Mm9NNzd6TFdM?=
 =?utf-8?B?M1AzUk10UUY0ZXZ6SDNnRk9CclAzZ0pERCs1TU1XcjN0ZnVCdnJ4ZzhsbE50?=
 =?utf-8?B?dGRGR1g3YjhhaWhGeUdZRzVVMmxpbUg5M0l0eXVyYmhCaDAyditubm1LVDNy?=
 =?utf-8?B?Sm9KV09OMFA1c2NWQVpyU1VoSSt5cjJSUk1ydVY1ekVzMlNyZmQ1N09pL2hj?=
 =?utf-8?B?NnNZTlA0ODUybDFIc2ZUT05UTUgrSzIwb255YzBiVnROUDVVazFpQXY5Vm8w?=
 =?utf-8?B?eENlNmsrQ0l4WFNPbXFzeWkyMVpaM3ViU2M4NVhJNUNPTS9oc3Zxc0w2NmVH?=
 =?utf-8?B?VlVZQjhmRjRuNTRaQzVUWkk2amJkQzRiWUhzeHBsNkhGYmRnd3RsYzZDSmY2?=
 =?utf-8?B?S3g5QlQwYmpELzFDNjNiSWtOTU9xQzF4ZmRwNnFWaTArRUVPaW5waFFpczFL?=
 =?utf-8?B?b0dGSGNROU91YldzRW1HVzVHd2tYZUl2bko3ak1DVHUzTC91bUhQMTU5bVBu?=
 =?utf-8?B?VUd3dkRuNFlXaEEyRlJPdjJhWURPb3o5NjkzbjIvUDJEdTB0UkRwZG4ySXdj?=
 =?utf-8?B?SGtyUGZ6dDZHbjU0T1VrSzhRUTE2WUM1TUwyQW8rSVJ3MkdFRTUvd2lkK2J2?=
 =?utf-8?B?bXQrWDZxSENDbkR2Sy9MMi9tajZRV2NzSnJ6bXF6c3F5MlBtQVYyTlhZTkE5?=
 =?utf-8?B?T3VVdFhyblBPcFR6QVR3WEVkWUVZVCtMNXdQTWplbXRndmRQTnoyT0lOQ2k2?=
 =?utf-8?B?RjcweldaVTBJNmRDZ3VhcllrcU1Sb1BkcXJCTlF5bTVCaW1DQnlxUzVDWFd4?=
 =?utf-8?B?eGt5aHJ4UlJXMCs0V0ROemZySVk3MkRpSW55ckNYNjlsRDZIa2RFMVo5cVRw?=
 =?utf-8?B?TzAxOWdoem9FVjRKT0xyYmxia1lyTkZlMDh1RjdQQ0RQNHNoa0lkb0pGUkVv?=
 =?utf-8?B?YmFSQWJ0Q2JUMGxic1dBTXJ5bWtyTndOUHJHSzlKVWFZUnpLRkhMRXlKSDJH?=
 =?utf-8?B?Tm8wbE00MkQyT3ZQbElqUEQ5Z2ZiYVh0dzFGUHNxSEdpR2QwU0VCVXdNU0p1?=
 =?utf-8?Q?DJk9D6VnLsvFerxhj7v52ep0i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE489089A49D504991AA1C83E9CAB2D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pOZXi9rZ+fdzMpFmisIk7hbzCNGMYpKvuxOXWZU8bkWcX7tMdcknQUIieuj72ROcjL7NdHZD2DfeMeGcbEtB782cfZZaCtCmeDhjFkgtp27Opp37Swf4jf4EeAIOwUe7ElY/SGO5NDHFTU+FpcuVdFVK2sUxXem1HBRDRoTwA4qOSLg8nO3KKl/23Im/YND1AlvPmxhMGLVcWCMNYTXUxcLp6PWfd/nESUSq1l44Sy/HI+NEcZ4hvvCBphu89platFYP2om813PhWtPa7LMeq+xLhvNL06gnaYLN6Mn5hHtJpBnJy6zHPl0hLwb6G0uK8C0XpcHAE3hmFkmqyFpH9Bz5mAdfzgBEfwMddnvByo0+eFYr/jL6h2oF30BcWGBy6XlngW3RNokIruYSqeiL96VXD+EtNcYvGygH+Lh2tzqmEi+SR4nBaGo5sHckjfQX29enaz0JJ0l+1m5nYBMMKdEVgPJG4QHpQW3C361w0yPXf1zVwoPvEmmsUcSfeL8eTha6lYU23UrrirOOYp0nWTuovsZllgW9bM3xWl3UAfjAlPFGYVpNbmb5mummnOqLnFyBfr827icHxlqx1ROtpSs+/Zk8O2SylpIVowNhodiUaRs2IXqfSc44JA+rKMdhYyeIGNJ9Sa0lntlvn+8rRg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6b237a-2398-453f-6ef2-08ddf0d3a340
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 01:36:32.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVNue/Tq8Rq3/15KBnzwLhPUrBYnkHcDbm262vzfIvg/jbvf9tYzxwozMYILEGMborZTGmoykzG/LOGe2gE3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDEwNiBTYWx0ZWRfX0jGjRwVDMsVi
 wcKiv77ImcSz8P/izWxL2OgB273sf6KBS1vSDlNqNrdIoSQ90G9eg1oUBVRFiFzrbNgVp92M4VO
 HzA4UeGx9BQlrXgMnaKIoCWVkVuMiRb3Dxgm2Q2iUp3yM4AJh3FEqaEXaqolqCKQU678RboIEgQ
 jm55ZkehbtZHyE4ubL9BjDkENceraJ6dZdd5Xq5Yvs1JBqb2P2buby8xTvqx38GUTkIu/IiAMRU
 9IV8GnjnOwY67WvxLfZT/I+oDiz6cgITbnKfliDG6YboNtdGN/tVSBpBFOgLJ5JEbpcOv2wNFXI
 Bcj+5AbrxjMXbDHGgSC3tGZttpcVE1oYKSeEGLeGZqRFglrBrv0GhMTVbjTdsVCLKBh0C7Ez2dC
 cTo1hkVH
X-Authority-Analysis: v=2.4 cv=FYQ3xI+6 c=1 sm=1 tr=0 ts=68c227a4 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=aVVSdnKGZeivX__PFcgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ml8dNdGLHKbBX_Z6l6ETxmBrjVXIW6kr
X-Proofpoint-ORIG-GUID: ml8dNdGLHKbBX_Z6l6ETxmBrjVXIW6kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509060106

T24gVHVlLCBTZXAgMDksIDIwMjUsIFByYXNoYW50aCBLIHdyb3RlOg0KPiANCj4gDQo+IE9uIDkv
NS8yMDI1IDU6MTQgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUaHUsIFNlcCAwNCwg
MjAyNSwgUHJhc2hhbnRoIEsgd3JvdGU6DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDkvNC8yMDI1IDU6
MzAgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+IE9uIFdlZCwgU2VwIDAzLCAyMDI1LCBQ
cmFzaGFudGggSyB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gOS8zLzIwMjUgNTox
NCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4+PiBPbiBNb24sIFNlcCAwMSwgMjAyNSwg
UHJhc2hhbnRoIEsgd3JvdGU6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIDgvMjkv
MjAyNSA0OjE4IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+Pj4+Pj4gSGksDQo+ID4+Pj4+
Pj4NCj4gPj4+Pj4+PiBPbiBNb24sIEF1ZyAyNSwgMjAyNSwgUHJhc2hhbnRoIEsgd3JvdGU6DQo+
ID4+Pj4+Pj4+IFdoZW4gbXVsdGlwbGUgRFdDMyBjb250cm9sbGVycyBhcmUgYmVpbmcgdXNlZCwg
dHJhY2UgZXZlbnRzIGZyb20NCj4gPj4+Pj4+Pj4gZGlmZmVyZW50IGluc3RhbmNlcyBnZXQgbWl4
ZWQgdXAgbWFraW5nIGRlYnVnZ2luZyBkaWZmaWN1bHQgYXMNCj4gPj4+Pj4+Pj4gdGhlcmUncyBu
byB3YXkgdG8gZGlzdGluZ3Vpc2ggd2hpY2ggaW5zdGFuY2UgZ2VuZXJhdGVkIHRoZSB0cmFjZS4N
Cj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gQXBwZW5kIHRoZSBkZXZpY2UgbmFtZSB0byB0cmFjZSBl
dmVudHMgdG8gY2xlYXJseSBpZGVudGlmeSB0aGUNCj4gPj4+Pj4+Pj4gc291cmNlIGluc3RhbmNl
Lg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gQ2FuIHdlIHByaW50IHRoZSBiYXNlIGFkZHJlc3MgaW5z
dGVhZCBvZiB0aGUgZGV2aWNlIG5hbWU/IFRoaXMgd2lsbCBiZQ0KPiA+Pj4+Pj4+IGNvbnNpc3Rl
bnQgYWNyb3NzIGRpZmZlcmVudCBkZXZpY2UgbmFtZXMsIGFuZCBpdCB3aWxsIGJlIGVhc2llciB0
bw0KPiA+Pj4+Pj4+IGNyZWF0ZSBmaWx0ZXIuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+IERpZCB5b3Ug
bWVhbiB0byBwcmludCB0aGUgaW9tZW0gKGJhc2UgYWRkcmVzcykgZGlyZWN0bHk/DQo+ID4+Pj4+
PiBJIHRoaW5rIHVzaW5nIGRldmljZSBuYW1lIGlzIG1vcmUgcmVhZGFibGUsIGluIG1vc3QgY2Fz
ZXMgZGV2aWNlIG5hbWUNCj4gPj4+Pj4+IHdvdWxkIGNvbnRhaW4gdGhlIGJhc2UgYWRkcmVzcyBh
bHNvLiBMZXQgbWUga25vdyBpZiB5b3UgYXJlIHBvaW50aW5nIHRvDQo+ID4+Pj4+PiBzb21ldGhp
bmcgZWxzZS4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiBZZXMsIEkgbWVhbiB0aGUgZGV2aWNlIGJhc2Ug
YWRkcmVzcy4gUENJIGRldmljZXMgd29uJ3QgaGF2ZSB0aGUgYmFzZQ0KPiA+Pj4+PiBhZGRyZXNz
IGFzIHBhcnQgb2YgdGhlIGRldmljZSBuYW1lLg0KPiA+Pj4+Pg0KPiA+Pj4+IEJ1dCB0aGUgYmFz
ZSBhZGRyZXNzICh2b2lkIF9faW9tZW0gKmJhc2UpIHdvdWxkbid0IGJlIGhlbHBmdWwuDQo+ID4+
Pj4gVXNpbmcgdGhlIGJhc2UgYWRkcmVzcywgaSBndWVzcyB3ZSB3b3VsZCBiZSBhYmxlIHRvIGRp
ZmZlcmVudGlhdGUgdGhlDQo+ID4+Pj4gdHJhY2VzIHdoZW4gdGhlcmUgYXJlIG11bHRpcGxlIGlu
c3RhbmNlcywgYnV0IGl0IHdvdWxkbid0IGhlbHAgdXMNCj4gPj4+PiBpZGVudGlmeSB3aGljaCBj
b250cm9sbGVyIGluc3RhbmNlIGdlbmVyYXRlZCB3aGljaCB0cmFjZS4NCj4gPj4+Pg0KPiA+Pj4+
IEFuZCBmb3IgUENJIGRldmljZXMsIGkgYWdyZWUgdGhhdCBpdCBkb2Vzbid0IGhhdmUgIGFkZHJl
c3MgaW4gZGV2aWNlDQo+ID4+Pj4gbmFtZSwgYnV0IGkgdGhpbmsgd2Ugc2hvdWxkIGJlIGFibGUg
dG8gaWRlbnRpZnkgdGhlIGNvcnJlY3QgaW5zdGFuY2UNCj4gPj4+PiBiYXNlZCBvbiB0aGUgYnVz
L2RldmljZSBudW1iZXJzLCByaWdodCA/DQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBXZSBtYXkgbm90
IGhhdmUgdGhlIFBDSSBkb21haW4gbnVtYmVycyBpZiBpdCdzIGEgY2hpbGQgZGV2aWNlIGFzIGlu
IHRoZQ0KPiA+Pj4gY2FzZSBvZiBkd2MzLXBjaSBvciBkd2MzLWhhcHMuDQo+ID4+Pg0KPiA+Pj4g
VGhlIGJhc2UgYWRkcmVzcyBfZG9lc18gdGVsbCB5b3UgZXhhY3RseSB3aGljaCBkZXZpY2UgdGhl
IHRyYWNlcG9pbnRzDQo+ID4+PiBjb3JyZXNwb25kIHRvLiBUaGUgZGV2aWNlIG5hbWUgaXMgaW5j
b25zaXN0ZW50IGJldHdlZW4gZGlmZmVyZW50IGRldmljZQ0KPiA+Pj4gdHlwZXMgYW5kIG9ubHkg
cmVsZXZhbnQgaWYgd2UgaGF2ZSBhY2Nlc3MgdG8gdGhlIHN5c3RlbSB0byBrbm93IHdoaWNoDQo+
ID4+PiBuYW1lIGJlbG9uZ3MgdG8gd2hpY2ggaW5zdGFuY2UuDQo+ID4+DQo+ID4+IFllcywgSSBh
Z3JlZSB0aGF0IGRldmljZSBuYW1lIHdvdWxkIGJlIGluY29uc2lzdGVudCBmb3IgZGlmZmVyZW50
IGZvcg0KPiA+PiBQQ0kgKGFuZCBIQVBTKSBkZXZpY2VzLiBCdXQgSU1PIHVzaW5nIGJhc2UgYWRk
cmVzcyAodmlydHVhbCkgd291bGQganVzdA0KPiA+PiBtYWtlIGl0IG1vcmUgaGFyZGVyIHRvIHJl
YWQgYW5kIGlkZW50aWZ5IHRoZSBpbnN0YW5jZS4NCj4gPj4NCj4gPj4gUGVyaGFwcyB3ZSBjYW4g
Y2FjaGUgdGhlIHJlZ2lzdGVyIGFkZHIgYW5kIHVzZSBpdCwgd2hhdCBkbyB5b3UgdGhpbms/DQo+
ID4+IEhlcmUgd2UgY2FuIGF0IGxlYXN0IGRpZmZlcmVudGlhdGUgdGhlIGluc3RhbmNlcyBiYXNl
ZCBvbiBIVyBhZGRyLg0KPiA+Pg0KPiA+PiBzbnByaW50Zihkd2MtPmluc3QsIHNpemVvZihkd2Mt
Pmluc3QpLCAiMHglMDhsbHgiLCAodW5zaWduZWQgbG9uZw0KPiA+PiBsb25nKXJlcy0+c3RhcnQp
Ow0KPiA+PiBkZXZfaW5mbyhkd2MtPmRldiwgImFkZHI6JXNcbiIsIGR3Yy0+aW5zdCk7DQo+ID4+
DQo+ID4+IE91dHB1dCAtLT4gWyAgICA0LjUyMTc0Nl0gZHdjMyBhNjAwMDAwLnVzYjogYWRkcjow
eDBhNjAwMDAwDQo+ID4gDQo+ID4gSSB0aGluayB0aGVyZSdzIHNvbWUgbWlzdW5kZXJzdGFuZGlu
ZyBoZXJlLiBJIHJlZmVyIHRoZSBiYXNlIGFkZHJlc3MgYXMNCj4gPiB0aGUgaGFyZHdhcmUgYWRk
cmVzcy4NCj4gPiANCj4gPiBJIHByZWZlciBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiA+IA0KPiA+
ICAgICBkd2MzX2V2ZW50OiAwYTYwMDAwMDogZXZlbnQgKDAwMDAwMTAxKTogUmVzZXQgW1UwXQ0K
PiA+IA0KPiA+IGluc3RlYWQgb2YgdGhlIGRldmljZSBuYW1lIGxpa2UgdGhpczoNCj4gPiANCj4g
PiAgICBkd2MzX2V2ZW50OiBhNjAwMDAwLnVzYjogZXZlbnQgKDAwMDAwMTAxKTogUmVzZXQgW1Uw
XQ0KPiA+IA0KPiA+IEJSLA0KPiA+IFRoaW5oDQo+IA0KPiBJbml0aWFsbHkgSSB3YXMgYWxzbyB0
YWxraW5nIGFib3V0IEhXIGFkZHJlc3MsIGJ1dCBzaW5jZSB3ZSB3ZXJlDQo+IGRpc2N1c3Npbmcg
dGhpcyB1bmRlciBkd2MzX3JlYWRsL3dyaXRlbCBmdW5jdGlvbnMgY29udGV4dCwgaSBhbHNvIGdv
dA0KPiBjb25mdXNlZCB3aGV0aGVyIHlvdSBhcmUgcG9pbnRpbmcgb3V0IHRoZSBIVyBhZGRyZXNz
IG9yIHZpcnR1YWwgYWRkcmVzcy4NCj4gDQo+IEFueXdheXMsIGkgZ3Vlc3MgdGhlIGFib3ZlIG1l
dGhvZCB1c2luZyBzbnByaW50ZiBvbiByZXMtPnN0YXJ0IGlzIG9uZQ0KPiB3YXkgdG8gZ2V0IGJh
c2UgYWRkcmVzcywgaXMgdGhlcmUgYW55IHdheSB0byBkbyB0aGlzPw0KPiANCg0KWW91J3JlIHJp
Z2h0LiBJIGZvcmdvdCB0aGF0IHdlIGNhbid0IGRvIHZpcnRfdG9fcGh5cygpIGZvciBpb3JlbWFw
cGVkDQpyZXNvdXJjZS4uLg0KDQpJbiB0aGF0IGNhc2UsIGNhbiB3ZSBwYXNzIHRoZSBkd2MzIHN0
cnVjdHVyZSBpbiB0aGUgZHdjM19yZWFkbC93cml0ZWw/IEkNCmtub3cgdGhlcmUgYXJlIG1hbnkg
cGxhY2VzIHRoYXQgdGhpcyBjaGFuZ2UgbWF5IHRvdWNoLCBidXQgSSBmZWVsIHRoYXQNCml0J3Mg
ZWFzaWVyIHRvIHJlYWQgdGhhbiBjcmVhdGluZyB0aGUgbmV3IG1hY3JvIGR3YzNfcmVhZGwvd3Jp
dGVsLg0KDQpUaGFua3MsDQpUaGluaA==

