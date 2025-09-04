Return-Path: <linux-kernel+bounces-801833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7DB44A87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366EB7AFD7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEC22F744C;
	Thu,  4 Sep 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dBshOfla";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Glt/6Q4Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eHFi/gIe"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B812882C8;
	Thu,  4 Sep 2025 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029476; cv=fail; b=lBaFOko/eUkt+ZZJO5dY1Sy8yLhFQsJLkRHFStQbRFSS1jB9UItEv2PDWSQAUNXoDjQdABf5InJ5f+5YPfgjiq/6J+8apRCzskG2hVF5O4/yg3AkhF5kjhfOUEHcHB1XxELcXlb0E3qcm3ZTVrhGE81LC5dbSZcFdDwanx+GV3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029476; c=relaxed/simple;
	bh=BHk4ThmVFGLBq0HPoQl8ZnbEjaqQKkdbqiRPaMeD0AI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gpw/Luv2WvAF2CdnBKuXQKtM8fo7IZxPhCiIgY0ZHHw2mQt1/uCfxDcZetj7wEGc4kfnDCdljBSLQFPtzpKdbYbhOqlbkZcXBfix9D/vtqZdFnDawok3X7uk0AZHJ9bvXez75MBm2mM5lEDq+VlXjBiuH3iOCDM55QM3p9Abj4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dBshOfla; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Glt/6Q4Y; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eHFi/gIe reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584N3II8017410;
	Thu, 4 Sep 2025 16:44:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=BHk4ThmVFGLBq0HPoQl8ZnbEjaqQKkdbqiRPaMeD0AI=; b=
	dBshOflaNapWK8awoXJtA7LIJVcPmIVS+ilrycvjKUHmxuzqsYbUVgGOrrDAYWrP
	S9ZEHan+vNUSJjFwIjXnFiDxJdaA2DzT/VG2BTPqB3zOhXa3lh1epTwET9z0o0Vb
	O6vvfqaUwRt81KJDa0eyIcI9kIqcx79N5Ku2Tz591KDsTGFmeL8QXyAwKDqbi5d8
	++uFwo2X0LtJR0UMjlspkwETNYkM1sSvPgQTbjrEHMJ42mPF1HOwISH3KKOAdXai
	sWshTB6lZc4124ueQ6F4n1VEExHvEt6x8pyYnfgQ/dOZHG+4e1ZWo5dYkLB6tDh/
	jyIIvc+dw+OgVq8oYeJivQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48uyxfd5qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1757029465; bh=BHk4ThmVFGLBq0HPoQl8ZnbEjaqQKkdbqiRPaMeD0AI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Glt/6Q4Yu1/woRtGgL9voSLt9uH5C1APFUABgzyxZnBSkUuaQ5RHa2mBysWL+stLS
	 H8yeB+G7RcJWnOhwzcKIjS5Lc5fYOA75/rre1i9UcXurhnE7/fL3wDvsLGK4rSMM54
	 CYHPpO3PVWAc5oqjV0v0hkciP4HTAzdE4KkAC5wEuzQhUbmQYJeg1f+3qMISl9c4hy
	 cmlcGiB2AiwEt7jbu56V3B8GytCmKLSO2RtXxwDv6olZHhn6fdTUW0NwiYXhBQ1O6P
	 j+vBxenO1YXj1IMnJD+0jBGBW8TO00PCGy20kToQSl19rM845wTqT3VCIH9mPSto3x
	 5Pc7b1Qi1Cc6Q==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2459A405C8;
	Thu,  4 Sep 2025 23:44:24 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9D68BA00C3;
	Thu,  4 Sep 2025 23:44:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eHFi/gIe;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B6534404D1;
	Thu,  4 Sep 2025 23:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOvo8c+i5w6fUe/EsCdRODUnTJy/zDz2CpV4vkTWQHzIUmO4iGfuWOnRjM1QirNVqJMFbfJBKimQDsGbxFTIN9c+W7z5uwuwZPuTTAMvJHea4y26Xnqssd4T5Fn15AZ4+GVT/nCFLW9Lri+wDsjPQzKPeJLUuDcq/l8z3cJrBD3rjgMZRVjlTabeBjAcsZts8BXLW+KbnzU926tUFbmZ6EHYRAlzCNhrxGnL0pXrlkqCE1seqcc06IEes8b/dwFSg812P+m9W2uuUEuxasc/JaN/+NuxSOczcf6pxHh/VPaGc5Keo+OJOIEebXx4flezvcK1wJaapHyRmWiw9AbLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHk4ThmVFGLBq0HPoQl8ZnbEjaqQKkdbqiRPaMeD0AI=;
 b=ieAVJGwAYFDI0bG8VboAEn4rYVVAUlPbAODyS+fpUqhMkLTKJXZ7IK/b2SZNw7/yCVRJsDw8lsj4nhEcR8qzIFVgB7hNGY1a0/bMcjDEmfuWATAH+hRcd/a1D4uyyPoUUrxzq9bpUIFlHPFKwa1NkQMsgVGa2qgn+prUwXnGta1fE92JcoIqgYHJiQVQTTjSuyW5E6/1mMqLsYhZCX4s9V3v3a11JMiBoEOc1Xs/qG8SJrdzCPm04zh0nNo0KoNTWJ9Nnq4kW4OilrCTiTlG9Ks2meNb1K4jQghUEAV9ovKmQK8LaUL+Y+0kw8OEm39ZRKAPg4p10ahc+nARGRlP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHk4ThmVFGLBq0HPoQl8ZnbEjaqQKkdbqiRPaMeD0AI=;
 b=eHFi/gIexGAaHPEYbOAtkIf9Uu/AE24cKL/VtT/4FDuv08hy3l9fXQ45oGa1mJZjdZ9xbL2fpCSiaRTh/wkiJjMyjUNV2PsUvz0aKbRDFCp51VDalGvBTIi7znYXQJoCXTTkgmuE8vRmlmvvHZ2A/sEzUA/fSGVBdxncmF9KoJA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 23:44:16 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 23:44:16 +0000
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
 AQHcFbWpI8fQ113kKk2/GPa4dCHPkLR4sG4AgAVxqQCAAnmiAIAAd12AgAEfOICAAJl/AIAA9GWA
Date: Thu, 4 Sep 2025 23:44:16 +0000
Message-ID: <20250904234409.etyz6ep3y4rfr3he@synopsys.com>
References: <20250825114433.3170867-1-prashanth.k@oss.qualcomm.com>
 <20250828224852.ukelgargocektp3z@synopsys.com>
 <5b30f63a-5999-48f1-972f-93f02fcc0ec2@oss.qualcomm.com>
 <20250902234450.vdair2jjrtpmpdal@synopsys.com>
 <67329e66-2221-426b-88a4-eece06d694ec@oss.qualcomm.com>
 <20250904000003.b4j7fnucronjf6ej@synopsys.com>
 <745a2b9c-078d-45eb-97a7-3a27a4bc5191@oss.qualcomm.com>
In-Reply-To: <745a2b9c-078d-45eb-97a7-3a27a4bc5191@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB8125:EE_
x-ms-office365-filtering-correlation-id: 90a157bb-0eeb-47e6-2eed-08ddec0cf600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHBQMGhuR2ZPTFA3YzRQZFNUeERGNmJweUZyakZmN28yRWQ4WmtlV3VldExL?=
 =?utf-8?B?YjJNRnR6c0JtaHgrL0RPSUxPUERKSHZLMUk4aSsvZFJBdjBVdm9OMFhITU9q?=
 =?utf-8?B?UjBrekx5ODJydkxpMnc2M0JSVVJYY05zWTFQelloZ2xxMVB3YTAvMzdWWVA5?=
 =?utf-8?B?YzZBdUtLenVjeWF2cWw1NGxpU0NucXVtS09UdEJxYmVNd3N5SFphZ2tPQkVY?=
 =?utf-8?B?Y2tMWmxTS3FFNGVtc2xIbXFuclZYL0RKZzE5WXY2U1NtWDU4WEk4Ykp3cHNy?=
 =?utf-8?B?NVZ1Yml6azVnQmVxTGVHQndISHpYOGhZNkxtTENwNnVCUjcrSlNqSm1CM3RG?=
 =?utf-8?B?Y21KeTFraXh3cUMwSG5scVRxa2tjTlBndkxOQ1k1L3dIU3JZN2pLOC9wdHZj?=
 =?utf-8?B?NHFMK0d5OEhRQWhRWHNGRk1YWDhzcW1vTDUyaW5OcENhMEJIYWYrak9YYUM3?=
 =?utf-8?B?WDdHTjNCTXNFSStLeHdmNFJBSHpKK3ZxcVZSV2R6b2ZOWUtaS2RwK0NqZDdx?=
 =?utf-8?B?QmliZXVGT3pCc2JSbW1BeDNRL2pROXJqSEdxMXdlcHA2Rnl6RGxPdzhkWS9E?=
 =?utf-8?B?am4vS1QwYjJuWFp1Q2dmakwxNDhIVk1Ga2hISWhyYTNhbEFlYUYrODlVdGRa?=
 =?utf-8?B?Sk9KeUhoeWVLRUYybENWdklhcmVjNXZpdGk1RjdXT2wyak9CdXBvVmh0RTNV?=
 =?utf-8?B?c1lhcndSUUNKWHZaSUJZTzhuRjVmU1FaaFVYcTEzWFVGRWl6MFhmMkFrMnY2?=
 =?utf-8?B?dmdJVlRVT0dPSmxnS2M1aXZEWGZ2VUtmNURXWUdoTVlQSnVjTUhWWWlvQ0F2?=
 =?utf-8?B?Z0JlN2I3TW5FaXV5anhQMTBveW1LcEdpWWlnYll6OHhnVUNNY1NxbWxqMW9O?=
 =?utf-8?B?U2YzWitLRFI4d0xtVXlrMWk1MFdOSDE0NkNaVktOM0Q3YU1jTDZkVmxOL0tH?=
 =?utf-8?B?QWRzQ1hNc3lSNit3MXdNTElXNFlnRmxwL2VaSkxtL0JrZnRyUFVUaWQ2NWJO?=
 =?utf-8?B?d2NJK25HajhJUXM1cklCajFGVkMvQjBPRlJOY0JBSlpLUncxTUdvWWpXSDMx?=
 =?utf-8?B?UE8vWWdUSTNSMXpDaHdWMG4yd2dxOHp1RjlCZ05SODFLZ3AyZ1hrdksvRWlR?=
 =?utf-8?B?azBwcXZ1SnlvSWtVVzNiOHZpU3hwbW1HWk1HQ3liMTVRK1JGNGZnb21pendv?=
 =?utf-8?B?c3ZyZitwNmdXR3Bnd3NjdU82VU1jYWtQUERIRTdKK0hkOU5aNXI2ZHIzTUNT?=
 =?utf-8?B?eXR3dmM4WGNUaHpmaGV4SnhIaGlaVklZWFVKclRqbFRiajV0RWM2RnRzMUNo?=
 =?utf-8?B?MEZhdmptOUVRNFdDY0RPdjgrRmR2NkhvbWVVVEFacVlsTFRLK2xELzlORmpu?=
 =?utf-8?B?R29wYmJXa1gwZ2NnTGJET2VYOHhkVnM2enUvWXFYcHdTS1hRMWVycHZwNVdG?=
 =?utf-8?B?Q0Z6N3RTRUl1OWs3SjFnbDlFbzBmZGZackZQMFNFNFBHN2hzdy9PWExSTXVS?=
 =?utf-8?B?cGNrdzVEVlQ4dXB2VS9NK0dHbDZzQytmdFcwQW8zT28rTy9ja0U1STBTbFYy?=
 =?utf-8?B?bThCbVdUTlBpM3I4R1dnZUtwd3Ixa1BjNDFBNFJIS2JQSDRiRVRlaGJOYyto?=
 =?utf-8?B?NHBZeUFSQVZ6eXlHZGNqYUNCTXd2eDVic3cwSitrS29HTGg5OFN5M0dsSlNV?=
 =?utf-8?B?ekEzNXY3UHpJTGh3WTlPZ1BLbjZSN0VOcGlObWRwdGtWalhITW5QM0ptUmFU?=
 =?utf-8?B?anE0eG9DOFpSdGdZQlMrRUlraVZkZklxM1VIeCszK3A3cFhWR0svVHY4VjZX?=
 =?utf-8?B?cWxseEVJOWttWUxBWFpFdjRVTC9jb2pkQTJoYzF2Qnh5TEY2d1o2SmR1RGtU?=
 =?utf-8?B?KzhzWklCamVmMjFXei9EUzJ6c1ozNlRJTjhyaWFnY3lQTTZTL0hndUFMMnhG?=
 =?utf-8?B?SVZmMUw3QTNMUHg5ZmdEMTQ4QzgweWsxSTFqZXZhMCtSZ3pPN1JweDVjQWFh?=
 =?utf-8?B?elpBaW9PdHh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjJGM0lMenpmSThweWFNcHlOVm1hVVljWDd2VDdRajFuYVdJOGplc2RyKzJX?=
 =?utf-8?B?M1Y1cWFzWTA3bDJadCtHSmxodjg4ckhuYm1PSVYxaXVYUU91dDV6cnlJekJn?=
 =?utf-8?B?ZjAwQ1I4UWJaYXZ1cGh2VWk5M2tJRXNDekpnR3owVEMvaENEVENCQWs2ZUo4?=
 =?utf-8?B?TGczdnArMnJVaVpzOWlhQUtGYUcwblpmeExITm5BOXk4TWp0TWsxMFRoVGhJ?=
 =?utf-8?B?VkxOZG0vcXAycU84bnFWK0QwTnZOajcxMXF2eHRKNjh0TE5mR2pKOXJ4Tnh0?=
 =?utf-8?B?L2dwYXVtbkJOQWFsNzN2bXJvcUtzbnBKUnBSckQydG04Zkh3RFRaUnVYNlFN?=
 =?utf-8?B?NWZ2Y1dmd1dIdFIwNEVROXhwRmU3eS92MFpPT0ZDL2p4LzBpYXlIUkhDQ0FN?=
 =?utf-8?B?VDRwQXlRZlFqMkJ4enI5MFNvSjExazNMZlN6YUJSN01JbE1Vd0VUa0h1Zjhv?=
 =?utf-8?B?YUMvUmd3THp6U3diaGVheDd1RDdMOVFvMkF5M1J1VzlJNGI0d2JNNXVvclY1?=
 =?utf-8?B?NmZuVkp0OHVhK0Z3NE5MT25oYk9GbE5OK3I2ZisyRlBEaVNvNnlzT3NZR0lk?=
 =?utf-8?B?ZThwdFNHWjd0Wjd5ZlUybGxPS3o5V1h4OHkzaTJWZzdacVVOL2N0bHFhLzdx?=
 =?utf-8?B?WTh2MTlmeEwvOGdCV1NBM1BKNFdQUUJuTWtLNTR5c2VkY1g5TUxTeERwVGRP?=
 =?utf-8?B?RFJyNk96bUtaL1hKMmRuT3d6N2ptZTdaTjltZG4vNm16ZVdPTm9mK0lQNU85?=
 =?utf-8?B?d3MwUTVSTGJ2ZUVleXErYjBhblYzSi9sT3BtOWNnOWtYK1ZPRnVrWXJnRXlJ?=
 =?utf-8?B?a1ZsVDBjbTI0Nk5KQXN1S2NYVFhlNTZ0OHRTUFVhazUyU1l3VFhrckZjWWdG?=
 =?utf-8?B?MEYzZVNFcTMwU3RDeU9yMUZWeWpQdW54MUt0VUNmaE5UWFdqemRWdHRhUTg1?=
 =?utf-8?B?SXJsV3pSeElFNFpiY3BWQitmQzVyOGhScmNlMjFJR0VlWUc1VWZDdTdBVEJO?=
 =?utf-8?B?ejA2U0pNczRxT0RjZGNxR2VNZjRGTTFaaHVLQ2l1NlhIdVlJZzNHc1lvVEFU?=
 =?utf-8?B?cXgvR1RuZXA4QXRlMDBzUlU3RGZWUzd2bzE1M2taR0paMG1xTXZTVUtUcFdQ?=
 =?utf-8?B?UndqMzhBYmVjOEpseFpnalczUVU5azFzdFZSa2V3YVNHcjJzallSY1dNMVdV?=
 =?utf-8?B?Z3hHaUtPM3dMSk41SWhHU25YMEV0VDh2cTJKSW9seHhPUUdGZzBBRXJKQlRV?=
 =?utf-8?B?d3NvMTlXMkpuaFhCY053TGdLQ1JBRjZwOXAwTzRxRjFzK2FnRlQ5N3VaZE1C?=
 =?utf-8?B?UkpaaTYxS2NBZ25xSmNRTjhnZEN0eWhhajFucWtIZUVaS1VlOFhldFRHbUV1?=
 =?utf-8?B?MjZVMmdSbFV3NjhsSWxUWklIWi9TK2s5L29OKzkrbzdlSnFaRkR6ZHN3dW5a?=
 =?utf-8?B?YVhreHlrdE0yZTBZWGpQVWlMT0hGS2pXYmJ2d0w5UHpZQXdmU3ZDdVM1RU1l?=
 =?utf-8?B?OXZPSzRuSys0YkZYYkV0VzU0VEc1TFNzbWZUdVl3Zy82WkZJQUE0c1ZGYjVQ?=
 =?utf-8?B?STNTdkNURDdkU2RNYjZQUFZCMFI1YkUwZWNuNHZVSEsxNVlod2xnZk5oWUR0?=
 =?utf-8?B?YkNNdVh1VWhzamJzMzRtS093UThhaW4xamdTT2FnVU9SVlN5V0NEeDgydFdL?=
 =?utf-8?B?bUl3MDNEeklHQ0QvN3JNdDM3YmZwMjJqdXdiQkpldVNYbGVtZmNHWGtROWRI?=
 =?utf-8?B?cEZLSmgrcTdsWFpMemJNMXFKTU52SjJmelcrZTd2ZmppclVBT2Q3aVdNb0RU?=
 =?utf-8?B?ZlVwaG1ndmQxdHZncGlUaDlZU1RtNFJZYlZOVStSRU9meWlJRXhEajA0WXZO?=
 =?utf-8?B?dzNKZHh1WnVIMVJpcTJiVVVYZzUyNUxUWkVLVU8xTzNobVR4UExjN3Y3SUdq?=
 =?utf-8?B?SHRqZFMwNUk5dklJTUIvUXdKVUs2cU5kQVhWazRUcjVkblBnQnZORTRoaFVJ?=
 =?utf-8?B?S05uR2xPamc0U3NZYjRsQytIK1BPTGtSOUV2ZGJNWVVnNS81emQzSE5WNHZR?=
 =?utf-8?B?VWhmbXNwb251WnFTRmFhRDNmSElZNmVSQTAwM2xyK29yOGZRUnRPVS9pSHFK?=
 =?utf-8?Q?obKeS9TrvYXMjiOS4gt6616jv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46CDC99B6467E64F8D2B4D0A01AB9784@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hEw8O0cNcD2Cdxx8UBN1z4rpGuHa0xf74wfJYG6HiZifV13yynq7cr9oOD0VIdCagOum8raXJpI9a5CW/IqGPGDbKSwNWLF1Je/G30wk/blf7KhF87z3OKjD38Ncdmx8Km13zT5pZPCHYt4/RXK7kypEsjb/CBLC+3GogH8r0RhFij5U3KdktvGHAxdyTszgyrdfjI54eOfMLQm+1H1pZeIH9KLk6rpoSlDtwwZkWDTo6I14PzrFqxZzV9MWQybMcFka6OUIhNfBdtMuFV238CMtB9FMdmWPWRX8g9Fvr7W8YwZgtxCH7VZNUrmsDmsN2wTtn7qNNXzSQ48IIgkZ+8RqHOQiAX21Hmnlfzr8c5Jm2x+HO4tr98yHNgYmsS8MtX8WeQUnpVwqe0bRx1RkdbrcWj3MN8OtCEPrO5s6yy/uAL2+2vMaDB6gm1VaUmj8v8fY83t008m3CqIg4icp5JZbP+jy4pYD7NxFcFlV7Jm3TV4hqbWW+TFPJlWEFLOR4veDZ025ymADAr/5WxoTMxJhlg4KTNlPxQJgQnasf7dO2RsLgkaBEeMCI2FtyMi/fXAoDMe0rltr1pXgCAzQMGWwnzPc0sH5jBnt+sdg/qaDe92aIhqtIAxhrH1bPxRczkfkAUR2zh4P4OyDFwSDkA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a157bb-0eeb-47e6-2eed-08ddec0cf600
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 23:44:16.6858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugB4Mm97fdo82+wqIG8jBC5dMsuMaMo6PMA33bT9ki7Jm9h4vxhvFN6F4RhzmsHK+lXjLlL43ugQG4FjuIbpow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
X-Authority-Analysis: v=2.4 cv=U7+SDfru c=1 sm=1 tr=0 ts=68ba245a cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=NKUFW7tJIe-WDTrhJ78A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mSdBGZfKojhE8Qw7ILav-HC3fVeMf2lg
X-Proofpoint-GUID: mSdBGZfKojhE8Qw7ILav-HC3fVeMf2lg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDEwOSBTYWx0ZWRfX7zpCAOjCfJTW
 Bmjy3xGizN01Z4DeWDi7lfp0SBVau5q10mFQa790SmfRzhzDViCeYWX0YSfA6xUkht69i4m4I7s
 6+x8Ag/AqKOgPJ9NTapIz7MmL13YELQGLc7pYRpPkHmBpErAa7lXJ4xV7FUW0ZXZQSqTCJ6zbC8
 p9tdfMkJuTReZkIj0Tn4GkQUiNEaOPx9Xzq99b2bdr0Iz3guCnKaixA6KtUWGtYE/bd4P/JzTd6
 PfXOhZOZ8225JTBaTA0vvgDlw5+bCCi9UYnkzBQi+Iac26JJ3ktGE0qSVMVj+oij+5n42F3vWx0
 by3oq8DSeZ0Js/oYoompsTQ/6jdK50LLkslW2ropwQ6cyu7wiKY3xncMc33SsS3YtgycSd0jRBM
 IMGI2muA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300109

T24gVGh1LCBTZXAgMDQsIDIwMjUsIFByYXNoYW50aCBLIHdyb3RlOg0KPiANCj4gDQo+IE9uIDkv
NC8yMDI1IDU6MzAgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBXZWQsIFNlcCAwMywg
MjAyNSwgUHJhc2hhbnRoIEsgd3JvdGU6DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDkvMy8yMDI1IDU6
MTQgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+IE9uIE1vbiwgU2VwIDAxLCAyMDI1LCBQ
cmFzaGFudGggSyB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gOC8yOS8yMDI1IDQ6
MTggQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4gSGksDQo+ID4+Pj4+DQo+ID4+Pj4+
IE9uIE1vbiwgQXVnIDI1LCAyMDI1LCBQcmFzaGFudGggSyB3cm90ZToNCj4gPj4+Pj4+IFdoZW4g
bXVsdGlwbGUgRFdDMyBjb250cm9sbGVycyBhcmUgYmVpbmcgdXNlZCwgdHJhY2UgZXZlbnRzIGZy
b20NCj4gPj4+Pj4+IGRpZmZlcmVudCBpbnN0YW5jZXMgZ2V0IG1peGVkIHVwIG1ha2luZyBkZWJ1
Z2dpbmcgZGlmZmljdWx0IGFzDQo+ID4+Pj4+PiB0aGVyZSdzIG5vIHdheSB0byBkaXN0aW5ndWlz
aCB3aGljaCBpbnN0YW5jZSBnZW5lcmF0ZWQgdGhlIHRyYWNlLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IEFwcGVuZCB0aGUgZGV2aWNlIG5hbWUgdG8gdHJhY2UgZXZlbnRzIHRvIGNsZWFybHkgaWRlbnRp
ZnkgdGhlDQo+ID4+Pj4+PiBzb3VyY2UgaW5zdGFuY2UuDQo+ID4+Pj4+DQo+ID4+Pj4+IENhbiB3
ZSBwcmludCB0aGUgYmFzZSBhZGRyZXNzIGluc3RlYWQgb2YgdGhlIGRldmljZSBuYW1lPyBUaGlz
IHdpbGwgYmUNCj4gPj4+Pj4gY29uc2lzdGVudCBhY3Jvc3MgZGlmZmVyZW50IGRldmljZSBuYW1l
cywgYW5kIGl0IHdpbGwgYmUgZWFzaWVyIHRvDQo+ID4+Pj4+IGNyZWF0ZSBmaWx0ZXIuDQo+ID4+
Pj4+DQo+ID4+Pj4gRGlkIHlvdSBtZWFuIHRvIHByaW50IHRoZSBpb21lbSAoYmFzZSBhZGRyZXNz
KSBkaXJlY3RseT8NCj4gPj4+PiBJIHRoaW5rIHVzaW5nIGRldmljZSBuYW1lIGlzIG1vcmUgcmVh
ZGFibGUsIGluIG1vc3QgY2FzZXMgZGV2aWNlIG5hbWUNCj4gPj4+PiB3b3VsZCBjb250YWluIHRo
ZSBiYXNlIGFkZHJlc3MgYWxzby4gTGV0IG1lIGtub3cgaWYgeW91IGFyZSBwb2ludGluZyB0bw0K
PiA+Pj4+IHNvbWV0aGluZyBlbHNlLj4+DQo+ID4+Pg0KPiA+Pj4gWWVzLCBJIG1lYW4gdGhlIGRl
dmljZSBiYXNlIGFkZHJlc3MuIFBDSSBkZXZpY2VzIHdvbid0IGhhdmUgdGhlIGJhc2UNCj4gPj4+
IGFkZHJlc3MgYXMgcGFydCBvZiB0aGUgZGV2aWNlIG5hbWUuDQo+ID4+Pg0KPiA+PiBCdXQgdGhl
IGJhc2UgYWRkcmVzcyAodm9pZCBfX2lvbWVtICpiYXNlKSB3b3VsZG4ndCBiZSBoZWxwZnVsLg0K
PiA+PiBVc2luZyB0aGUgYmFzZSBhZGRyZXNzLCBpIGd1ZXNzIHdlIHdvdWxkIGJlIGFibGUgdG8g
ZGlmZmVyZW50aWF0ZSB0aGUNCj4gPj4gdHJhY2VzIHdoZW4gdGhlcmUgYXJlIG11bHRpcGxlIGlu
c3RhbmNlcywgYnV0IGl0IHdvdWxkbid0IGhlbHAgdXMNCj4gPj4gaWRlbnRpZnkgd2hpY2ggY29u
dHJvbGxlciBpbnN0YW5jZSBnZW5lcmF0ZWQgd2hpY2ggdHJhY2UuDQo+ID4+DQo+ID4+IEFuZCBm
b3IgUENJIGRldmljZXMsIGkgYWdyZWUgdGhhdCBpdCBkb2Vzbid0IGhhdmUgIGFkZHJlc3MgaW4g
ZGV2aWNlDQo+ID4+IG5hbWUsIGJ1dCBpIHRoaW5rIHdlIHNob3VsZCBiZSBhYmxlIHRvIGlkZW50
aWZ5IHRoZSBjb3JyZWN0IGluc3RhbmNlDQo+ID4+IGJhc2VkIG9uIHRoZSBidXMvZGV2aWNlIG51
bWJlcnMsIHJpZ2h0ID8NCj4gPj4NCj4gPiANCj4gPiBXZSBtYXkgbm90IGhhdmUgdGhlIFBDSSBk
b21haW4gbnVtYmVycyBpZiBpdCdzIGEgY2hpbGQgZGV2aWNlIGFzIGluIHRoZQ0KPiA+IGNhc2Ug
b2YgZHdjMy1wY2kgb3IgZHdjMy1oYXBzLg0KPiA+IA0KPiA+IFRoZSBiYXNlIGFkZHJlc3MgX2Rv
ZXNfIHRlbGwgeW91IGV4YWN0bHkgd2hpY2ggZGV2aWNlIHRoZSB0cmFjZXBvaW50cw0KPiA+IGNv
cnJlc3BvbmQgdG8uIFRoZSBkZXZpY2UgbmFtZSBpcyBpbmNvbnNpc3RlbnQgYmV0d2VlbiBkaWZm
ZXJlbnQgZGV2aWNlDQo+ID4gdHlwZXMgYW5kIG9ubHkgcmVsZXZhbnQgaWYgd2UgaGF2ZSBhY2Nl
c3MgdG8gdGhlIHN5c3RlbSB0byBrbm93IHdoaWNoDQo+ID4gbmFtZSBiZWxvbmdzIHRvIHdoaWNo
IGluc3RhbmNlLg0KPiANCj4gWWVzLCBJIGFncmVlIHRoYXQgZGV2aWNlIG5hbWUgd291bGQgYmUg
aW5jb25zaXN0ZW50IGZvciBkaWZmZXJlbnQgZm9yDQo+IFBDSSAoYW5kIEhBUFMpIGRldmljZXMu
IEJ1dCBJTU8gdXNpbmcgYmFzZSBhZGRyZXNzICh2aXJ0dWFsKSB3b3VsZCBqdXN0DQo+IG1ha2Ug
aXQgbW9yZSBoYXJkZXIgdG8gcmVhZCBhbmQgaWRlbnRpZnkgdGhlIGluc3RhbmNlLg0KPiANCj4g
UGVyaGFwcyB3ZSBjYW4gY2FjaGUgdGhlIHJlZ2lzdGVyIGFkZHIgYW5kIHVzZSBpdCwgd2hhdCBk
byB5b3UgdGhpbms/DQo+IEhlcmUgd2UgY2FuIGF0IGxlYXN0IGRpZmZlcmVudGlhdGUgdGhlIGlu
c3RhbmNlcyBiYXNlZCBvbiBIVyBhZGRyLg0KPiANCj4gc25wcmludGYoZHdjLT5pbnN0LCBzaXpl
b2YoZHdjLT5pbnN0KSwgIjB4JTA4bGx4IiwgKHVuc2lnbmVkIGxvbmcNCj4gbG9uZylyZXMtPnN0
YXJ0KTsNCj4gZGV2X2luZm8oZHdjLT5kZXYsICJhZGRyOiVzXG4iLCBkd2MtPmluc3QpOw0KPiAN
Cj4gT3V0cHV0IC0tPiBbICAgIDQuNTIxNzQ2XSBkd2MzIGE2MDAwMDAudXNiOiBhZGRyOjB4MGE2
MDAwMDANCg0KSSB0aGluayB0aGVyZSdzIHNvbWUgbWlzdW5kZXJzdGFuZGluZyBoZXJlLiBJIHJl
ZmVyIHRoZSBiYXNlIGFkZHJlc3MgYXMNCnRoZSBoYXJkd2FyZSBhZGRyZXNzLg0KDQpJIHByZWZl
ciBzb21ldGhpbmcgbGlrZSB0aGlzOg0KDQogICAgZHdjM19ldmVudDogMGE2MDAwMDA6IGV2ZW50
ICgwMDAwMDEwMSk6IFJlc2V0IFtVMF0NCg0KaW5zdGVhZCBvZiB0aGUgZGV2aWNlIG5hbWUgbGlr
ZSB0aGlzOg0KDQogICBkd2MzX2V2ZW50OiBhNjAwMDAwLnVzYjogZXZlbnQgKDAwMDAwMTAxKTog
UmVzZXQgW1UwXQ0KDQpCUiwNClRoaW5o

