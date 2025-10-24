Return-Path: <linux-kernel+bounces-868421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839BDC0530D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC46560464
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7933064A3;
	Fri, 24 Oct 2025 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WZlIISwV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AT0bcGHF"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F353054D8;
	Fri, 24 Oct 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295307; cv=fail; b=gUceB/+SdC9W5r2OKRuXYQpTDZ8KBl+OcEnMq51YruKihrdimIN1mxYljbLwn5GRPZDuWv1GgHpmUQ2HtONnD+j/BXxCSruBVZnmtjM1BF2AnLhwPal8g51IpD/A31FVxyPyNDY90Ucp1e7dLpxixmch5H8mhTKatzGtTmPsx+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295307; c=relaxed/simple;
	bh=azkmWrgFL0PUNWyOQGIxUnKbF1LVIFsqPplUnCgQipM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GOOlHib+HpGW6wMsopeeciQ2+I0iqotsjbKXsjRQebqKjLdYn0234a+fUW5Gxd4b+SBjWgxdtNVPqEXZ46dStrCFmUYiWkJx9jhztJ7WqdWXSNT5qIvK3z7Tk174vHXxLHbd8PvCj937/o4OluAP1nVAIgioQ40I+wOXQW9EGiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WZlIISwV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AT0bcGHF; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 417f0d34b0b511f0ae1e63ff8927bad3-20251024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=azkmWrgFL0PUNWyOQGIxUnKbF1LVIFsqPplUnCgQipM=;
	b=WZlIISwVi3Ej6gAfN8zIs5njQINHnoZWuwCMM5QJkip4563LfUnWtHB0gApbZp8hL/Z85MBleQdZw5T0EaONFvlTkL8cWYIsITeVQYhMM7OCcFyVyyyo/zwCHmukX1MPcJNv0ghdZC/skDHJirxYew53FCvGdsNvSN77boqHMm4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5f5728ff-5b11-4ef8-9cd5-cf58c9d5e3eb,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:fb994384-4124-4606-b51d-d5c9eec0e7b9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 417f0d34b0b511f0ae1e63ff8927bad3-20251024
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1751733337; Fri, 24 Oct 2025 16:41:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 24 Oct 2025 16:41:37 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 24 Oct 2025 16:41:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1G67SQOP9787lr+Zpzs5oriN6aoNV3tOHGs1DYVvG4A5ALcipzT4WCERq+5WJNJHCWU/dC8LDiWsRcS1v9w5IWvnpxNYyHXvG+dp9twO2ygoR+d6NcoY14LUUNTvhdaYnY23our3Xsu3KdynYUmBnt97iWMZLMf0ZesTvqPPHsuidymFYiCScnuFc0f29PnC+X0KLiTlQGwNB0kb/BypulFJwAqHO9/dLLb4x8SWU9z5D3UFCyIKm2Yldfz+efBLSy//LmjjEHf1eTm1/Hu0ta70fU5cMmZyrVGYflYHxyLQBELvZnw+N2BH4z83JVF8ry+7NDe6gS2mlACR6qidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azkmWrgFL0PUNWyOQGIxUnKbF1LVIFsqPplUnCgQipM=;
 b=fNj8uQbwKWiNwKwW/j1XRqzeuZLqASoZsQaEajp3OjP+oxk46PwnJ6Rvi0OlVRvB+d23eGAGcxB225CmocKaUHA8g1e0Yd6USG64IaWgLLnsbxQAMkPlWkA+lgqPC3qWLdDpKw84vanvJmdVFdmQu7rSqEbXM7rrg3uRVcnD2jJpHoMbTpOh2gpdXWwrrp2S1uiVz2+2+shFwYTUNPVGHuezkUWCKyVzdgkeXhkWAi5JmDZBPC+hi1P5L/1nYa0wshXzvfGA7CpbGu/oSFR4/u2O+LI69nsFBLY8Ep4W6BxG1QQRjNLc+hPGHO3zQ6RbxI0DDL6vpuFLa/2YPLLblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azkmWrgFL0PUNWyOQGIxUnKbF1LVIFsqPplUnCgQipM=;
 b=AT0bcGHF6R6j9/NBYzrCBM8rL2aigXbZLTRJivDtsI9kTn1N+lBDe0DC3Xf8nUxMr+ce6bCsi1di3rlnFw4NSzym/A6ILVU9XryWg+ztpvc0bdBwUTS2zoV65YnD/NY+FMpcc4LFxZ/6hAMYVz1TeZnDVrmw4xA3nuAtsKAou7o=
Received: from SEZPR03MB7007.apcprd03.prod.outlook.com (2603:1096:101:ac::12)
 by SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 08:41:33 +0000
Received: from SEZPR03MB7007.apcprd03.prod.outlook.com
 ([fe80::641d:833a:915c:d1f0]) by SEZPR03MB7007.apcprd03.prod.outlook.com
 ([fe80::641d:833a:915c:d1f0%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 08:41:33 +0000
From: =?utf-8?B?WmhlbmduYW4gQ2hlbiAo6ZmI5b6B5Y2XKQ==?=
	<Zhengnan.Chen@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"krzk@kernel.org" <krzk@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: memory-controllers: mtk-smi: Add support
 for mt8189
Thread-Topic: [PATCH 1/2] dt-bindings: memory-controllers: mtk-smi: Add
 support for mt8189
Thread-Index: AQHcKT0hOp0pivb9MUCopXi244ULI7SuDnSAgCMjD4A=
Date: Fri, 24 Oct 2025 08:41:33 +0000
Message-ID: <ab52d3c9eb3f0cdf238d82afd289ca1d282f0f53.camel@mediatek.com>
References: <20250919081014.14100-1-zhengnan.chen@mediatek.com>
	 <20250919081014.14100-2-zhengnan.chen@mediatek.com>
	 <20251002000657.GA2511095-robh@kernel.org>
In-Reply-To: <20251002000657.GA2511095-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7007:EE_|SEYPR03MB6700:EE_
x-ms-office365-filtering-correlation-id: ee3b30e7-08d5-4eb9-1e70-08de12d922e4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cEt4akNqYkI2eUNQZFF5VXdDY1B6Z3l0ZUFrYTBqYUhqRTdWWXQvdmViRE5u?=
 =?utf-8?B?cTdKK0p2ZmIyWStZY2RKMEt6bUgxb1g4V2k1azVCZi80ZnVHQVZHaWdMUU1U?=
 =?utf-8?B?R0d3TThGQm1VRnFzSWpIdHlXMUNHcDBWNjZ3VmNsYnlnTkJoLzM0MGdqSkYy?=
 =?utf-8?B?M3htcUxLWFN3MzVQSlhOcTlCR0FoQXB2QXRET0dKRlFQZHNnRGNrLy8ySHUz?=
 =?utf-8?B?Y05rVzNWOHlZMVYwemdvZmNja3dUM0pZYVU0VmZVRWpEVmVQRWFIV3FMMHQ0?=
 =?utf-8?B?SDd5aVQ0cHljQzNQekZxSzBjZHpuS3djN21jcHNoMURZTG9qQ2QyRWtVZG5s?=
 =?utf-8?B?R1ovcFY2d3dtcVN2U2UvS3ZRelV4YjJGL1hIVFpIREcwUXU1aGdaOHJhMGhG?=
 =?utf-8?B?TVduRURXQ3BoR1FMTSt1WEFNWHVDUDAxdDh1TW5teXgrcEEvRWg3VDIvRHd1?=
 =?utf-8?B?d25UcmVIQmkyb0RDQzZySXp4NnVCRFg5SU9MenhDQndZYzROcFc5TUFwOXBT?=
 =?utf-8?B?NFN1RFNWNytkZFJ0QmdzM0ZlK2tIQUNOUys3SC9vU2NyMEFCMHM2TXdyNGJp?=
 =?utf-8?B?RXlpTE8wSlh6TmxsMzBpT01FS29HeHEyaE52cHlQOFZrUEt2V3pjK1U5QVBn?=
 =?utf-8?B?VXpJcFpYcjdMQmZwcTk1YkpqeE9XTFd3UkJWelZidUNueWZ1Nm9XWE5ldGJB?=
 =?utf-8?B?S2RjbTIxa0h0NVRwQ2RQYnlOWWFscU9rbFZpUGIzOThjVW5kWWFsU1luc0pm?=
 =?utf-8?B?Tm93bHhwTzY5MzFEYlhGaW91WU5Fc0srZXJFUG5DM2tkbnNwNlRnQnVueFZR?=
 =?utf-8?B?QS9BZ0tNM1ovZjhzRm44eWhKNWJHQ2dickFpZ3NmUUhLY1h3UGFlc3drdTI1?=
 =?utf-8?B?bzJOYUw0c3haazQ4b21hNG9QaVlMOHltTGFLd0x3Mlp5OVI2U2VxUGR6cTFE?=
 =?utf-8?B?OFlrVXJjNEp1SE9Gcm8zMkUycjllSjE4OEZscGJWRzhpdGNSdDAwOUFXbCtz?=
 =?utf-8?B?bytxWm53WWNhd2lHRmtocFNWNnhqc05oelNOWHF2dDJCeWpnNTdoY29LMXFs?=
 =?utf-8?B?NHgwZkdjVTFBRVZkK2UySld1L0o5VUtpZ0tDSmhXM1lCUVhlY3BmRXNSVUNG?=
 =?utf-8?B?ODNIMkNqUElkOG9wU1JCMjRocU5wS01QRW1jSlhGSU9TMG1lNkpmMlNHZzZQ?=
 =?utf-8?B?WkhvQVcxdVRYZnlQSW1reE03U2NYZnB1ZXdVMyt4alp6UFFKSzRRbXJLRUFq?=
 =?utf-8?B?OEk2NTB1RzgzY3h4TDc3RkNmZUI0aXhZM01qclAzeFowcEN1bjJaK2lscjNR?=
 =?utf-8?B?NzVKQWtrV2NUeGhUN3BsV0FSTG5yeU5HdGx4S21sMVBZbVVBVFlSRmMzWHpB?=
 =?utf-8?B?RjdoT1ZNTG1NN3BucDRqeVhRNXEyUThneC9UNkFTbEM1VU5CZEt0KytQN1F5?=
 =?utf-8?B?WUc3TW5TODFPU2Z3a0FGSDVIMVJ6NEVPSWNHekFJNTVkV0JFN2ZZcGwvODJR?=
 =?utf-8?B?RmdPeEdTRVJpNGw4RFJXT0I2a2sya1B4dk4wcVlORWNhdDRVc1phRTdaWm9l?=
 =?utf-8?B?eGQxdW1yVXNuUTdBMzZwdFhpbEI2Y1R0cjJUOURSQTk3VVkvQXVSMTZxZmtQ?=
 =?utf-8?B?K2pRbXBaNytwYVRucXpiQ0xlRVU5TnZWVTVlL0dOUm1Ib0NPYXNMckF3ejlF?=
 =?utf-8?B?bmx0YTZWTE9aTXFObVhLaGd0NWtYMXBoY0c2SzFkRnlwNVNLdFkyekVxUmVa?=
 =?utf-8?B?Ukx2NE05ZlV6UDJmUkx6aktJQ0RhVS9KUFhxNC9OeGcvUlpLYy8vbnloRlRm?=
 =?utf-8?B?SXZVL2IvVXJ6dzIwbkw4WEVjb1IvVjdUYlVJQnJxUGZJbXBXcXlvZ0VNZHk3?=
 =?utf-8?B?MDNVMVBZOWp5UG5aUytHYVZ2WlFpalE0azZPQzVDSlA5NC9jdVVNY25xTWNB?=
 =?utf-8?B?N2loc2VRQWJra3RTYllncWJramNQQVc5UGhEMzFyYlM1Ry9GOVFDQnZNTDJw?=
 =?utf-8?B?Y25CT2kva2dhb091TEhyYko1eWlJdEQzQXFyUDUzOXA5SmlQRXVqeGZ1Qm5S?=
 =?utf-8?Q?uEl4pu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7007.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WThkMXVWQTkrTU0yOHUyYThheDMwVlN0K2lWUXdadVlTWk55OXBPZjhQSlZy?=
 =?utf-8?B?emRmMEVTLzhHSTJIUVZjZ1Q4N1o0emxxYTdoSWRDMWNXY1VFbC8rVHpWTUF5?=
 =?utf-8?B?TWZIZXMzUDRMYTcrNjZZS29sQ1J6bHgxSGpIcDV1cjUwdTFYekE0eHRyWExX?=
 =?utf-8?B?a1VQbXN6TnR4cXZYVXNtMHdJZi9DWmQ1bE4vSVhZcGtmUXg3WjZrdXdjU2FT?=
 =?utf-8?B?eCtmWUZsazFlL1ZOTnN0RkFONjY1b2lJS3J1R2hJN0Uwa0dUMWdtWVBYTE9m?=
 =?utf-8?B?N2plelZlSnhNY1V3Mllud1lSN2U5aURIdDc3SnpTaTZNdkxKYUtHcm0vV0hH?=
 =?utf-8?B?SDVoVDNGOHp0eTVJQUpmamtvSngvYWFXaS9YdlJHM0QzUVcwaWlQcGVqeUxN?=
 =?utf-8?B?MVYzTXFHT3QzenJNUXYzNkFUQmhWSHJyd3IwbHRlVWxQTlllLzN4M3NXVjEy?=
 =?utf-8?B?VTBUN3FYc21BQm92TEFWSjFXL3NmSTl6dE5nWnlZeGVicEJjSWFaUjVYL2hZ?=
 =?utf-8?B?S000cFpLWDRMTTcrb2dLTzFjTlBqeGFXR2R1K2YrZkt4MXliTWhPVGo5TWJN?=
 =?utf-8?B?Tk9TSlRXaUtNcGdJK3FVSWVzdzVwLzd3U2Zoa3I3eXFCbHJ1RzNrcGRhZ2Ez?=
 =?utf-8?B?S0QrWFBsWnBnRE9EZ0k2TEJEVEhDY095NmxieDFMb01memJtRFF2NTJBNDFO?=
 =?utf-8?B?QTlOU2E2OHJqVVRMeU9kY2lwTEh4bHpEbW1FeG05WVVKUzhwZHV1VnVGT3N2?=
 =?utf-8?B?aXdzMlJxMlhSdVBFN3BEY3dhLzZrc3ArRHEvZUwxZXFZMmhLbDFVbmhWYllw?=
 =?utf-8?B?WnNkNDdrTnV0cTM0U2ZLNjNxcjJRdUtiaVdJVlNSK0hHWHNxcnY3QTdYZ2JT?=
 =?utf-8?B?Q01UcExvaTBISHlneTlTdnFOK1Z0RW5vYU5YRUlZUVlCZWNMK1BzODdlN2Nr?=
 =?utf-8?B?MGJFaDhTZEhHREl6NW90aFBxbEFidHhpN1JURzBycHRnS3JKaHYwUHppak5O?=
 =?utf-8?B?d0kwMlV6b3hqSDJVMkorWndVdCtKZ2hEMGRVN3lnMDNtVGFHV3NNYUZySC9x?=
 =?utf-8?B?eWZrOUppeW1MNktaZlI1RGxFN3JQaG5nQlczaWFyT1lDeTNTL3FMVzVHdThw?=
 =?utf-8?B?WXRoSzZkVnNza2RrckU2SEtQcmdTdkduNXZxbDgvejBSeWNjNE4ySHZDeFYz?=
 =?utf-8?B?SmNQeHFIS0hXZXRHSTN0UFkwV1dTSExuRmcwL2p0bzhBZEhLZkZ2V3A3MHEy?=
 =?utf-8?B?UDR0S2w2RzBKQkFBQkZQKzJLTzkraHlKUW9EdnZvc1NwN21wLzdoS2V6REVS?=
 =?utf-8?B?MnpWWFA3aUpHT0dGaWNkQ3hMWllpVnlubzZhdVVjeHB3RDJPMTY1bld5RGw4?=
 =?utf-8?B?a1Bob0M1amxLTFFWUFA3U2t2dnUwZWVVZWt4SmFRQXpKdGMvSGV5NUlKUHR4?=
 =?utf-8?B?UVlPU254cG1vT3o0U3BCQlBSeTYrV0JLNmdzVmpiMXJQZitIOXkzUDIxZUdk?=
 =?utf-8?B?TGxOUDcyMWFNU0ZBbkpUd0IrUHpJbVY2SFFFN1A1RWU4WnZVTW5yZW82ODJS?=
 =?utf-8?B?dFVRSlE0VG5OakdLQzFOVGlSYXpsVW54U2FGZTNtSzBwV29WdHVRblBLeFhq?=
 =?utf-8?B?UWZhbmgrQ3VuWHZSVTJLS2xvSCsrRGtEb3JENXVCVS9udU83OGxXQWhYL3Zi?=
 =?utf-8?B?VmNNaFFHOGVoWC9JMXBhVTZBUWU4Q0sxMGJDS1VpbG5ZRGZISGhiZ1Y2WVpR?=
 =?utf-8?B?b3VwbGFUWjYxTHZxUGt3cFZ3ZEpySkVLNzFQRVdtWDM0TWhqUlZHZjhlYUMy?=
 =?utf-8?B?eFFVSVFwVU5iT0NxYnhmZVNoMnVRZTEwRzM5RjlHTXYyS3NuMmdOWUo0emRt?=
 =?utf-8?B?cUxLWE1pT3I2RjFBSjhZR2Q3NlYzSWtlT0pFaHVvbUpFSXljMm9sYktjMmp2?=
 =?utf-8?B?dnNiTEJxVzFIKzBrRDFmZktta2VCdmh5SjRJL0xBRjhFc1hROHRlaWhjYnJG?=
 =?utf-8?B?MncyMjBOQkgzZUVYVnovem1HWkczRHJrZk9QdDk1VVlzWXZybWtueTEvanUr?=
 =?utf-8?B?S3VDY2J0czl0N05ubTd3aU1VUGw5czFwRzYxT2xTZjJCUFJ3ak05bEk5dzNs?=
 =?utf-8?B?QVNRTTlRdEt1YmRWUkJ2Vm1FbVdXMlAybTZUKytxaVNPZlhmbXFHeFMwUEtl?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8E43AEA10DA914B8AF58141DC0F187E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7007.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3b30e7-08d5-4eb9-1e70-08de12d922e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 08:41:33.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jv0v8vIzvQgkN8SRcbOQGUqMKZCJPKDrMmyfDSSdJC5MzZY1xuzFaB/4PrQkJTW7AlrV4fh6LjRCpfq0giVbnPIpZl1LWPQ0QdmzwPkouY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6700

T24gV2VkLCAyMDI1LTEwLTAxIGF0IDE5OjA2IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBGcmksIFNlcCAxOSwgMjAyNSBhdCAwNDowOTo1NVBNICswODAwLCBa
aGVuZ25hbiBDaGVuIHdyb3RlOg0KPiA+IEZyb206ICJ6aGVuZ25hbi5jaGVuIiA8emhlbmduYW4u
Y2hlbkBtZWRpYXRlay5jb20+DQo+IA0KPiBQbGVhc2UgZml4IHlvdXIgbmFtZSBoZXJlIHNvIHRo
ZSBTLW8tYiBtYXRjaGVzLg0KPiBvaywgd2lsbCBmaXggaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4N
Cj4gPiANCj4gPiBBZGQgYmluZGluZyBkZXNjcmlwdGlvbiBmb3IgbXQ4MTg5Lg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IFpoZW5nbmFuIENoZW4gPHpoZW5nbmFuLmNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVr
LHNtaS1jb21tb24ueWFtbCAgICAgICB8IDINCj4gPiArKw0KPiA+ICAuLi4vYmluZGluZ3MvbWVt
b3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwgICAgICAgICB8IDMNCj4gPiAr
KysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gPiBj
b250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21p
LWNvbW1vbi55YW1sDQo+ID4gaW5kZXggMDc2MmUwZmY2NmVmLi5hYWM4MzY4YjIxMGMgMTAwNjQ0
DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4g
PiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiA+IGNvbnRyb2xsZXJzL21lZGlh
dGVrLHNtaS1jb21tb24ueWFtbA0KPiA+IEBAIC00MCw2ICs0MCw4IEBAIHByb3BlcnRpZXM6DQo+
ID4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1zbWktY29tbW9uDQo+ID4gICAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE4OC1zbWktY29tbW9uLXZkbw0KPiA+ICAgICAgICAgICAgLSBtZWRp
YXRlayxtdDgxODgtc21pLWNvbW1vbi12cHANCj4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4
MTg5LXNtaS1jb21tb24NCj4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg5LXNtaS1zdWIt
Y29tbW9uDQo+IA0KPiBQZXJoYXBzIHNvbWUgZXhwbGFuYXRpb24gd2hhdCAnc3ViLWNvbW1vbicg
aXMgY29tcGFyZWQgdG8ganVzdA0KPiAnY29tbW9uJy4NCj4gb2ssIHdpbGwgYWRkIHJlbGV2YW50
IGV4cGxhbmF0aW9uIGluIHRoZSBuZXh0IHZlcnNpb24uDQo+ID4gICAgICAgICAgICAtIG1lZGlh
dGVrLG10ODE5Mi1zbWktY29tbW9uDQo+ID4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1z
bWktY29tbW9uLXZkbw0KPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtc21pLWNvbW1v
bi12cHANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lbW9yeS0NCj4gPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sDQo+ID4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiA+IGNvbnRyb2xsZXJz
L21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCj4gPiBpbmRleCAyZTdmYWM0YjUwOTQuLjlhNWRhZmQ3
YzA3ZSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVtb3J5LQ0KPiA+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiA+IGNvbnRyb2xs
ZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCj4gPiBAQCAtMjcsNiArMjcsNyBAQCBwcm9wZXJ0
aWVzOg0KPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODMtc21pLWxhcmINCj4gPiAgICAg
ICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg2LXNtaS1sYXJiDQo+ID4gICAgICAgICAgICAtIG1lZGlh
dGVrLG10ODE4OC1zbWktbGFyYg0KPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODktc21p
LWxhcmINCj4gPiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXNtaS1sYXJiDQo+ID4gICAg
ICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1zbWktbGFyYg0KPiA+IA0KPiA+IEBAIC04NSw2ICs4
Niw3IEBAIGFsbE9mOg0KPiA+ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1zbWktbGFy
Yg0KPiA+ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1zbWktbGFyYg0KPiA+ICAgICAg
ICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1zbWktbGFyYg0KPiA+ICsgICAgICAgICAgICAtIG1l
ZGlhdGVrLG10ODE4OS1zbWktbGFyYg0KPiA+ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5
NS1zbWktbGFyYg0KPiA+IA0KPiA+ICAgICAgdGhlbjoNCj4gPiBAQCAtMTE5LDYgKzEyMSw3IEBA
IGFsbE9mOg0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ2Nzc5LXNtaS1sYXJiDQo+
ID4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODYtc21pLWxhcmINCj4gPiAgICAgICAg
ICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1zbWktbGFyYg0KPiA+ICsgICAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ4MTg5LXNtaS1sYXJiDQo+ID4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxt
dDgxOTItc21pLWxhcmINCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1zbWkt
bGFyYg0KPiA+IA0KPiA+IC0tDQo+ID4gMi40Ni4wDQo+ID4gDQo=

