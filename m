Return-Path: <linux-kernel+bounces-833451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A1BA1FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F7984E032B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963742EF66E;
	Thu, 25 Sep 2025 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qacISTx/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lTOR0fs2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AFndtEDK"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E71F8AC8;
	Thu, 25 Sep 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843831; cv=fail; b=S5FY4dtAZq6O2Sf96zS/hUYkGM1Yv3mnECrMptDu8bAnOnDyPXXbJYbGrAnsTB5AgpkFNwo9H6wqN+iQNMBIYHO+oLaUzqi+hMAIQKzdAaEvUcNvN82KwBUyMzK5mi3QS60seDiU2LyKk3UZeSWv7frFGQRJGUQuGDGOhIWxXfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843831; c=relaxed/simple;
	bh=+4Zi2aUijJoTS2xc+DU0fyKyKENNY9UheyMnNEdahnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KiZT1Tgp/Nqow261HUSWqRXv1vjmo8t8ze6VcLYtoSTKAAxFNX1isuviJbe1TVNxGF+dils3eSANoklaxD7OAZVOJJeLHMVpLUEJp1qlwIvBomp7huZSthPrtySqcJYS3nElxiarRnewF2Zf/gxY6hZCZMOCQpUQEHlNn0M8Ew8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qacISTx/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lTOR0fs2; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AFndtEDK reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPohn004138;
	Thu, 25 Sep 2025 16:43:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=+4Zi2aUijJoTS2xc+DU0fyKyKENNY9UheyMnNEdahnA=; b=
	qacISTx/XE15dyy1w4QnjXiySyss4kccy5knWcLuMt7y/NVdROyoQKjzJROX1Gcv
	2uvyWovalB1UQFZRqIVPB83OCWav1RecA9A8NEQ1outhE0X5Ia5uCFDqzJlZrBno
	O9ih9LnumtUrdgJFlp+Gge1QRwEy0DoV06vtBxQ6RPNpO/iXh7REkBOPAP7lv4aO
	bG057mq3/cbsuZkcfi5VxJ+2eTiYumBArARTztMPp8Cmq7Az9kcedRTKkicnhx7E
	gZD3p7YqCMBeMqgEXRUagWEsVKVwWoSer0LdK0tm1/zLvvmFa+soGmoGNmOUuuvw
	DJXjp5KagIGmRrS4sqwBmw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49db0n9bec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758843785; bh=+4Zi2aUijJoTS2xc+DU0fyKyKENNY9UheyMnNEdahnA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lTOR0fs25nRiX9YfIeb1TQC3VWIld1xakJ8cyEnn3PQJkku3/Kl58CHJvg9PZMh+k
	 Wjl7VKwW7sEBiQ0mbRx/IUbxK/2hpDCvp1cCvtjDzZiKeStfEHdtqV2ngFhZEbUtjL
	 vZEs3QZ7ur7UwN6BO11bdMqTF+qgBPbgdAVTSlK/L+51MahPVj3l3Xoo8indorc42T
	 wznhw9JHe635fnxowGnPvK8WJYbFTP2aDBJa/2FlFi6MLmjCdISu2M2Y5UREL2Vi6b
	 RvP4T6AUm9nTdhifiPCJUXjzWsqtzKjzsWebT2VId6/iL/MstzAq6QX0JPRkzVPN0j
	 nRiCEJn5DviMQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A49C740140;
	Thu, 25 Sep 2025 23:43:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E2545A006F;
	Thu, 25 Sep 2025 23:43:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=AFndtEDK;
	dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com (mail-sj0pr08cu00100.outbound.protection.outlook.com [40.93.1.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 35BE9401C6;
	Thu, 25 Sep 2025 23:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz936uOjERJ8mbSsGM/Zrd326/8r8Z6I3sbjQ8sc3obu02jDptZCGbU0wixvo8axxTH75B3xXf07fLAB5BJX13qdCsehlAPwTbyKgZLSYLalT0enOrWE9SgCCNbdZ/bwKBOCLIPOgiqno/iaFgNOwAvK7XaK6IFuYgpkKUS4Oy/42/HxzfrnZrYOZPqsYT92R5OVA3UnF3ZNjQTEjYjXBBTHJiWPxf39k012X7R+H5dXjnuehv1AGcjwIxtr0jaGyrjlbIPp8+5EkkHWo9X9kuu0oMKVwfpMo/pl/WD7e2T8g8rhp7+ojVh1m/S/FnQqSJr3nIaGOMwwmB3LtAaEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4Zi2aUijJoTS2xc+DU0fyKyKENNY9UheyMnNEdahnA=;
 b=gSjs7QkZJ0uEAA0drFcI02Hg6wU73Zk+a8GYbCfMt+WLg0A1X4SyhN32EmcUQ2YdbJGPvUUPmPuYo5DzCw8PU+M6+JFAN95LXfNMhM4qzjbOjvFgm2xavmiHkFoZygBUZvF3OcnpowkhFfuM6XH7JxOcekIcK4c7laKpiCFpPY0vM9Rjujerq67CW7zOr9Q5owmvpH7S3gbKuKjYmd6Ck1yeZIwtrdd6OB/3+Va9/ru5G44C1iFhJ7Pvn2DuoAg78disXMjCUDFPq/LpNym+dylvJy7pwfJt4mko4FHPdmTeaJk8oKn0AX0LYHJnhEw0IpQfY8jPnOoHD0afawyL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4Zi2aUijJoTS2xc+DU0fyKyKENNY9UheyMnNEdahnA=;
 b=AFndtEDKp37c7pvHQ3QUDlfOG3vsCoYqg0aJfxdtBNjd4OIFDrXhCkfY80Eq1lG7xGr8uV33LErqtJdJeC9HlRq2eH1EKbTdHodkEORdISCxx79Q0bjAFfcHSp3MzRcOFuH4NlrfJ9iC4uqjyNQEBjVSCGyP3DpEWkKYlvLUuHg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 23:42:59 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 23:42:59 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.li@nxp.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>,
        Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v2 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Thread-Topic: [PATCH v2 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Thread-Index: AQHcLMfm+bZ7U2qihEG+JeLp3z4omLSi51uAgABjjgCAAUfAAA==
Date: Thu, 25 Sep 2025 23:42:59 +0000
Message-ID: <20250925234225.6uaxndkhm5nq654s@synopsys.com>
References: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
 <20250923-ls_dma_coherence-v2-2-ce3176396bdb@nxp.com>
 <20250924221331.migo5szpf4svxpyr@synopsys.com>
 <aNTAjk1zsWF5lm3p@lizhi-Precision-Tower-5810>
In-Reply-To: <aNTAjk1zsWF5lm3p@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB9243:EE_
x-ms-office365-filtering-correlation-id: 88d61d76-1c6f-4f6d-dce1-08ddfc8d426a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGNNNGVNenliNXh2dGx1M3JiUncyZDdKVEtEcXNMZWNwVml4SXAxUmNXeERF?=
 =?utf-8?B?NlJscURBNGQvTWVKdkNwYnZhdXQxYWptWmZyTjZLMisxWXpid1JmbGtRNGlp?=
 =?utf-8?B?bksyVkNrVnFSR3dJdkNwZEw1cUZERUF5OVNqaytPakd5ekVDb0JnSGw2UVBN?=
 =?utf-8?B?MEI1TkxJTHpYY0w1N0JmaE1adWdsR3BvWFlqNWJGK3U3RDJvVTIxNmxSanI3?=
 =?utf-8?B?eTBkczRrNmFURlhTcWJGaHVzQVdtcmpEVCtPRDI1OGYwcDFzeUxMaEl5Ykho?=
 =?utf-8?B?dFpvdUNCZldSZEhwenJSdERNSmlOZEUyZ1d5bFhoWU05ZldHTTJXbFhXVTB3?=
 =?utf-8?B?b3NKRHJCRHhqa1dlZVRvUVliQmdoQnlJVzNHN1VsaDB5WEVrNVpGaThJdjBu?=
 =?utf-8?B?WXgyZXk2NzZkdy80RVNleUNQYkprR05WNEhQbkt1d2RFZzhnaGxEOGU3UFIy?=
 =?utf-8?B?NnF3NUNBRGxlT3dtVGNtc1pXL3Q4SnJhcTUrcXBUSTlvaUJiUTNmUWhsUHN1?=
 =?utf-8?B?V09uWkdkVm5aZUE4alREbHc2N2lVY0dkRzBJV3Q0WDFMdjlkajJOL1FObEcz?=
 =?utf-8?B?RjRDQ1o4K3lwUUVHMnAybVFWc2xkc011THY1T0JrOWJBQlcyNGpsWk9kYzJQ?=
 =?utf-8?B?ZHkraWtLQjZVSFgyR1JFeWw5TG9yNVRnV0JKZnNGS0JyOGNKRE43dWRzTk5B?=
 =?utf-8?B?blR3VjRhRmVLN3hvRVVXbGgwMDIxUFBsaGxFUFVvT3NCaUlrQkU0bkpWWGph?=
 =?utf-8?B?WURUNldEbEpkbGR2Q3V6QU9CNDMzMVFIYlNQMW01ZCtPbUNMYUFpSCtBUXRq?=
 =?utf-8?B?ZlVrTit2cno0OEtTOE9mb2pwRXoxall4SkQ0MGxQazFvTlRrZGw1ZjNidis3?=
 =?utf-8?B?UWk1dFZmUWtDcExVT2l4UFlHK3c0YUI2MW9TYmN5ZWhRdGVjV2hjZW5IbU9W?=
 =?utf-8?B?RG0yQUc5ZnMyOFoxb3VjR1RRVkcyWlpnVFJqZW1lMk1DcU1xOWVXS1k0RkVr?=
 =?utf-8?B?WU5LOUlnMldFaUlXaThqVzF1c2xnc0syYlJHWVo2Y1UxMG8zdk0vRzBBcFli?=
 =?utf-8?B?YkNCZUlGa0h1UGRud0lISVNwMDFXWUNSbkFzbTBNOFNCRmFFWE8wWXdwY0V0?=
 =?utf-8?B?ME1VL0kvazFwaWNERCtaMmJSMlNKczN0eXVKK1F6cENSanVPNkliV2p2bFhY?=
 =?utf-8?B?aHRKK3VLcGJCMHN4N1JFN0U2SGJmWnZGbHEzc3NFcEFzUzNGTzE4UklMUlMr?=
 =?utf-8?B?NFZZWU8zb096SzlweWtWZXVYZ21GMXVibmtoTUwrUU1JakV2Ymp1ZEhBUGdZ?=
 =?utf-8?B?QlZSNjR3R0pBSUFGWXVqWkh4aGsrMkNtN0Y5WE9NYjVIRFEvZEliZEc0d1JI?=
 =?utf-8?B?cXNBdXJkazh3WFlWbEh4RFc4dUtWamFPU3M2UElSMUdGSENBMkM5NlVEYTd0?=
 =?utf-8?B?Ulh3MEYxcHB4cWw4a2N6WllGb2szaEFzdEtiQTc5VndVTytLWG1oOGx4UHp3?=
 =?utf-8?B?S0NoNk5ZRHNxSTVzelNkNWZnUEE5Z2xEZm12UEd0aGZ6R0lBTnBFemVURTB6?=
 =?utf-8?B?MmhSaWtWbitBbkY0VFlQbEJPZ1NYelc4TTgwUExucmpEVmdIWTI3M0tOV2wr?=
 =?utf-8?B?QUF4ZmVQdkFMVWxpSUpCLzUrWGQ3Z1NoNjFmTEhqR3ZsSXlDaU5UdU5KWThZ?=
 =?utf-8?B?TURQaE9zaDgyZkpKc1JBem1xdk1SSW9JKzZJSlZleERUc012QlplcjFzOTBH?=
 =?utf-8?B?ZXlyUXhoUjBvcGc4MWRJYVQrSG9kVXdyT0hRaUl4YjBiSWg3OStNNnlya0lp?=
 =?utf-8?B?Q3ZZMnpWUTNMOVhqVk1wc0R4NXVIQjRIdTFJT0RadzhRUnN2RTh6UElNa3Y1?=
 =?utf-8?B?TUhubDFHY1JDektvVEdGdExERkVMZXhiNDV1OHlzSXZtUm1MeFZQZHoyclVi?=
 =?utf-8?B?UjJoQWlqN1phc21BQnF0NlJuMUJ3ZUFjOHczeHczczVKRDFaYjZjU0E3SWZB?=
 =?utf-8?B?QVBHMFM3TWVwKy8rWkJrQWFxSEtvd0ozdUhNSGwyQ3VTYVo4SkJtUEJWdkJV?=
 =?utf-8?Q?byCwpA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vjc2OHpFcCtrMmkybk9QYlQ1dU9yOFpkaUFBNU1uaWV6eEdvTS8zeXhtc0d4?=
 =?utf-8?B?anBnaEhwQmlSRUlCb29WajE1T1EyaWR1dVNjNC9Nd3ZyR2FCNkdPQkY3UVJ6?=
 =?utf-8?B?Wm9DY0I5c3B6RjFuaExOWE96eVVieUVyaXV6MFdTZDBUR3B3UVJ5OU1KQUE1?=
 =?utf-8?B?SUo1bWd1c3JZWXVVbVZxbXNTZm90MUp2MVRUVjlhKzhsYVgwWEFzalgvekVh?=
 =?utf-8?B?UlFyYTlNNDBKYVpmT2pQNWlacjRuelhvbVkxNjdlVTBTc1hDbGpGVE5tMlZn?=
 =?utf-8?B?S3BOU3hSQ3hVWkh6U0w5Mm9JeEN3dWxIVTZESVN4OCt2RnJIZTZ5a3ExdkM0?=
 =?utf-8?B?MEhya1dGNXFlQWJ0MHU3dkIzQlg3OGpyMmV1UjFBTHBrbWZKTmY4cUV1bXBE?=
 =?utf-8?B?SzlKWnVYbFdpZ3d1cG9RWTgyek9tMEYyWjYrY0NjLzFyVnFMRG9BZjNxYncw?=
 =?utf-8?B?Z085Q3JiTGRFNW9zczZ6WStEQ2E3RlAvSjZ4d3FJRnQyNXhsYzZmMThVUmtk?=
 =?utf-8?B?ZDkxajZzSHRVbjI1eTNTdzkrOWdGVk9jT21PMmkyd3Rtczc5YVE1STdRbEQ2?=
 =?utf-8?B?czRodFh1RkJ2YVRRV0ZBeklraldvNjJGRDFPTGZ1d1FjSklncXlCTHJHZVor?=
 =?utf-8?B?Q2NrR08zMWExNFBiUUtPN21hMklXMk90dGRNNldPYVQra0NDZTFxN2RCS1VF?=
 =?utf-8?B?K0Q5eGVrQThUdHYwT1hSNTczbkFyTkJjTTFtYmxjOTZVRFB4UGtEVEc3MFNJ?=
 =?utf-8?B?dHBwSjlBYTdpSGpxV2xpTkNoQ3Uxa3ZZNFA3RlRNYmhCUzZRZUJjd2J6dVhw?=
 =?utf-8?B?NTFwOHgvZWdZZTR0U21HVXJRZEtKWmxTNkZpcnRySzVuTkJnZ2s5bFlTekxk?=
 =?utf-8?B?UC9aZFk2akpTL3RKNmM2S3gwNXZGNm1JUzVRaEpWUG9wdlBxdmNjS1pvNlVD?=
 =?utf-8?B?UDltNUIvNzAzZ1FRdjA4R2FZNjJHUkNmK3dxV0daOUZ3RmJEN2dSbG9hdWlW?=
 =?utf-8?B?VnJNNW1yUDk4R1VjaXU1dXBZeVhGWjNYUmhjQ1RUVDBUeG42UStnbUgyY2dB?=
 =?utf-8?B?b2t0RHE1Vnc2RWZob3VsUGozQXNteENTUVI5eWNTTmt2cU1tOGZDWlBRYnF3?=
 =?utf-8?B?UHIzMzZUTGpTUHZZN1M0N3MramxROWZxbHZQejZSWGwxemVjQ0VsUk85dXJP?=
 =?utf-8?B?d1l5VndWWXpKUGFIRy9uYXVncjh3RjdGZmo1TFhvNXg4elo0d0JWWnI5NW9U?=
 =?utf-8?B?Yjg5azZ5U2Z4LzM4WkZvZ0NZa1pVaEtVV3kwTHN3YnQ5SzdKRjd5SFFyS1lp?=
 =?utf-8?B?ZHZweFA4T3NWNFJvWVJEY2dwUitpMU9tYWRDYU1LMTlhUTBCd0FHaHVWOWE1?=
 =?utf-8?B?dXgrNmJCWFlQbllDem1SK0VyZll5SWg5YUtxMnJwRVpiOVJPNDVqZlJuR3pu?=
 =?utf-8?B?WVdaU3lSaHNnbHgwRFVTRlpkcURad0Q4a3VJdVZhTTZSelhQaXIzM2M2UTFS?=
 =?utf-8?B?WCtoYlNkUGp1RENRKzhYOG9lRUR1MnF6bmlpQXh3dlltOWJsVnYwVTd0TmJ6?=
 =?utf-8?B?RU5ZK0QvdkdpbUtudTRaYjJvbjR6OGpzVGxCVzdmM00wL05nR1VIZmpLL0Qz?=
 =?utf-8?B?QzdHRVVBSXd0NzdtSk42MWUyRDZnMFF1cWN3aUo4WVM1RFRSYzVydHZyOUIy?=
 =?utf-8?B?ZzJjL1ViUytqWHRVRWNBUy91cVFQTjZsdFFQanhmR2c1WHd0eWlEOU0vVDhV?=
 =?utf-8?B?cFVNL3FHK1FiZnhXMVR2YXlXN2diVU9xcCsxcU1ubzkyRzZ3ZDU3T0Qvalc4?=
 =?utf-8?B?YXNEMC9zRUZmbnBZVjVPYzBvK0JqR2xpOVJCTkFnbUZsSjRvc3NuSG9qTUMy?=
 =?utf-8?B?QklCT1pOVS9FRGRwa3lnTXpFU2lSUU5HdGtSVlZJMkk2L29XczRycElGQ0k4?=
 =?utf-8?B?bHY1NHdOLzVmeDhtcDRJbTQ0WWlZbklFYy9EZHRld0xoaW1saitvUEZWeGhX?=
 =?utf-8?B?M0FyRGlQVVdSMFZYd0RnS3I5OEl0OHRGRmhnaFkvVEwzL0g4YkEwQkh0Yk5R?=
 =?utf-8?B?eGQwMlNDMkZxL0FsbzRXK0pWMVFaOXN2cjRoOGdoSlA3eEMxQjNRK3IydklR?=
 =?utf-8?Q?2mw8rz6vY2Ny+6E0QDDbDUOED?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3BA6C955A08FF44B190DF5F9DB050FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fvB28a9GDi85CHyov0bY+YFfLOxio2KCDatLAgqU8ewuOD4nB3luRjUYIhQKlbZvZKHacbH84q5EsPiFkTpDrfK+I/9d6C6kOHcGh4XFlf+T+hgEaT8Qgej+vZ8laFh1BdAE5uXulemUVCAQEGWNgC8BM0vLSShmHTT+fXGfvIj3HWao9YnGWKKFLz40QM7k5aK1EYmVp6mDxppJxtOOyIDU3SSjcRauz8/otBm0x93XM4ORuJV3/RP2d/7ssaTbG1oPJQ+1NkVjGpKtqSXeTT2Ym4/r9tXU4PVrkUhyPhAKn4I9BGYyuM/1x+7Zijr9BEqo/NTZSXHK37xLxt2cwL/zZY73bjmT9AuBefK/YFiCIcf9b/HlFo0T+1W8lmm2KIvLdAIydIjZocm7PJgkcU8sq93wKCUiqvqVGdtOeVB+Vncdgd84jOJZwSIPE1jia97N4FgTL9Nq+mHNnBb/m92WAxTgKspI9zbtgy9z7xgF8Qc+giY2YTW0zxKTJEP7gGDjjoq6hYhJtEXKUOsTxg6EWuAH6ebYKK2TOVxQxwT5UHUNWUrWAR0FZz+f8fk0zFuLJjVQ6GcxCTD87d+PEMdse4m/fblgDfWTul1KgYHRgV2Aj5iQ/P5HI9dpz+Fj8ydnlHZxl2pmZOEQ1si17w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d61d76-1c6f-4f6d-dce1-08ddfc8d426a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 23:42:59.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVCpbG9Sc2kuvI/M7WjhZlHuwKgNhFST1hDMrS/7OT2vCdhYEFxV1gFwKDdidFMnEVYeO4LNgTne+2HwjtDwFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
X-Authority-Analysis: v=2.4 cv=Ar7jHe9P c=1 sm=1 tr=0 ts=68d5d38a cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=rG7kDeucCybFLxvHNPcA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DHKyI_pGrj08a2XP3WUlg2p4qBG4d2jH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX4RRzumcQwA9x
 WItsR9cOfCTQjXR4pSA/4kAHhP+7LJAczxC8b5596hXVF2qsfLxo500VFkoI38NGxJo29dfzRNF
 6E+9b8zZMB/01ozqQ2+Tzq+x/ocV3WIjKq4jE5d64LyrI/HOyxuglYJ9prwL1a55bejAA+WzMYR
 MmHtH+q8kz0TUwGEQK9EoaZFb1UJxocyR1RncdKkN2Aqvf322w60jmBvgcbP7WHKrERBHPJ3nhp
 DXyY+PJu+Z1/GaFVP2uXKcXq/Dupv4kzyszyhjBexP/aXy4Wc8Zt9SWrrArVUitVT90GhzUTEiM
 gupom3gnll4wgxufgwEaJzDE8sTtABu6dUYYWtvTbqMCa51PlVJomh2XEKH/5Xy2oHWJg3zx8ty
 K5Dt/Zf5NUdg30bbodx0uRbcYZskOg==
X-Proofpoint-GUID: DHKyI_pGrj08a2XP3WUlg2p4qBG4d2jH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509250171

T24gVGh1LCBTZXAgMjUsIDIwMjUsIEZyYW5rIExpIHdyb3RlOg0KPiBPbiBXZWQsIFNlcCAyNCwg
MjAyNSBhdCAxMDoxMzozNlBNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPg0KPiA+
ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZHdjM19nZW5lcmljX2RydmRhdGEgc3BhY2VtaXRfazFf
ZHdjMyA9IHsNCj4gPiA+ICsJLmdzYnVzY2ZnMCA9IERXQzNfR1NCVVNDRkcwX1JFUUlORk9fVU5T
UEVDSUZJRUQsDQo+ID4NCj4gPiBXaHkgZG8gd2UgbmVlZCB0byBkbyB0aGlzPw0KPiANCj4gYmVj
YXVzZSBpcyAwIHZhbGlsZGF0ZSBzZXR0aW5nIGZvciBjZmcwX3JlZ3FpbmZvLg0KPiANCj4gQXZv
aWQgYWRkIG5ldyBmbGFncyBsaWtlIFJFR0lORk9fVkFMREFURSBpbiBkcnZkYXRhLiBkd2MzIHdp
bGwgdXNlIGRlZmF1bHQNCj4gdmFsdWUgaWYgcmVnaW5mbyBpcyBEV0MzX0dTQlVTQ0ZHMF9SRVFJ
TkZPX1VOU1BFQ0lGSUVELg0KPiANCj4gb2YgY291c3JlLCBpZiB5b3UgbGlrZSBhZGQgYm9vbCBi
X3VzZWJ1c2NmZzAgaW4gZHJ2ZGF0YSwgSSBhbSBhbHNvIGZpbmUuDQo+IA0KDQpMZXQncyBhdm9p
ZCB0aGUgcGFyZW50LWNoaWxkIG1vZGVsIHRvIHBhc3MgdGhlIHByb3BlcnRpZXMgYXMgaWYgdGhl
eQ0Kd2VyZSBmcm9tIGRldmljZS10cmVlLiBUaGF0IHdhcyBhIHdvcmthcm91bmQgd2UgaGFkIGJl
Zm9yZSB0aGUgbmV3DQpmbGF0dGVuZWQgbW9kZWwuDQoNCkknbSB0aGlua2luZyBvZiBzb21ldGhp
bmcgbGlrZSBiZWxvdy4gTGV0IG1lIGtub3cgaWYgdGhpcyB3b3JrcyBmb3IgeW91Lg0KTm90ZSB0
aGF0IHRoaXMgaXNuJ3QgdGVzdGVkOg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KaW5kZXggYWUxNDBjMzU2Mjk1Li5iZjcz
MjNhMTY1OGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KKysrIGIvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCkBAIC0xNjY2LDcgKzE2NjYsOCBAQCBzdGF0aWMgdm9pZCBk
d2MzX2NvcmVfZXhpdF9tb2RlKHN0cnVjdCBkd2MzICpkd2MpDQogCWR3YzNfc2V0X3BydGNhcChk
d2MsIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFLCB0cnVlKTsNCiB9DQogDQotc3RhdGljIHZvaWQg
ZHdjM19nZXRfc29mdHdhcmVfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KK3N0YXRpYyB2
b2lkIGR3YzNfZ2V0X3NvZnR3YXJlX3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YywNCisJCQkJ
CSBjb25zdCBzdHJ1Y3QgZHdjM19wcm9wZXJ0aWVzICpwcm9wZXJ0aWVzKQ0KIHsNCiAJc3RydWN0
IGRldmljZSAqdG1wZGV2Ow0KIAl1MTYgZ3NidXNjZmcwX3JlcWluZm87DQpAQCAtMTY3NCwxNiAr
MTY3NSwyMCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9zb2Z0d2FyZV9wcm9wZXJ0aWVzKHN0cnVj
dCBkd2MzICpkd2MpDQogDQogCWR3Yy0+Z3NidXNjZmcwX3JlcWluZm8gPSBEV0MzX0dTQlVTQ0ZH
MF9SRVFJTkZPX1VOU1BFQ0lGSUVEOw0KIA0KLQkvKg0KLQkgKiBJdGVyYXRlIG92ZXIgYWxsIHBh
cmVudCBub2RlcyBmb3IgZmluZGluZyBzd25vZGUgcHJvcGVydGllcw0KLQkgKiBhbmQgbm9uLURU
IChub24tQUJJKSBwcm9wZXJ0aWVzLg0KLQkgKi8NCi0JZm9yICh0bXBkZXYgPSBkd2MtPmRldjsg
dG1wZGV2OyB0bXBkZXYgPSB0bXBkZXYtPnBhcmVudCkgew0KLQkJcmV0ID0gZGV2aWNlX3Byb3Bl
cnR5X3JlYWRfdTE2KHRtcGRldiwNCi0JCQkJCSAgICAgICAic25wcyxnc2J1c2NmZzAtcmVxaW5m
byIsDQotCQkJCQkgICAgICAgJmdzYnVzY2ZnMF9yZXFpbmZvKTsNCi0JCWlmICghcmV0KQ0KLQkJ
CWR3Yy0+Z3NidXNjZmcwX3JlcWluZm8gPSBnc2J1c2NmZzBfcmVxaW5mbzsNCisJaWYgKHByb3Bl
cnRpZXMtPmdzYnVzY2ZnMF9yZXFpbmZvICE9IERXQzNfR1NCVVNDRkcwX1JFUUlORk9fVU5TUEVD
SUZJRUQpIHsNCisJCWR3Yy0+Z3NidXNjZmcwX3JlcWluZm8gPSBwcm9wZXJ0aWVzLT5nc2J1c2Nm
ZzBfcmVxaW5mbzsNCisJfSBlbHNlIHsNCisJCS8qDQorCQkgKiBJdGVyYXRlIG92ZXIgYWxsIHBh
cmVudCBub2RlcyBmb3IgZmluZGluZyBzd25vZGUgcHJvcGVydGllcw0KKwkJICogYW5kIG5vbi1E
VCAobm9uLUFCSSkgcHJvcGVydGllcy4NCisJCSAqLw0KKwkJZm9yICh0bXBkZXYgPSBkd2MtPmRl
djsgdG1wZGV2OyB0bXBkZXYgPSB0bXBkZXYtPnBhcmVudCkgew0KKwkJCXJldCA9IGRldmljZV9w
cm9wZXJ0eV9yZWFkX3UxNih0bXBkZXYsDQorCQkJCQkJICAgICAgICJzbnBzLGdzYnVzY2ZnMC1y
ZXFpbmZvIiwNCisJCQkJCQkgICAgICAgJmdzYnVzY2ZnMF9yZXFpbmZvKTsNCisJCQlpZiAoIXJl
dCkNCisJCQkJZHdjLT5nc2J1c2NmZzBfcmVxaW5mbyA9IGdzYnVzY2ZnMF9yZXFpbmZvOw0KKwkJ
fQ0KIAl9DQogfQ0KIA0KQEAgLTIyMDYsNyArMjIxMSw3IEBAIGludCBkd2MzX2NvcmVfcHJvYmUo
Y29uc3Qgc3RydWN0IGR3YzNfcHJvYmVfZGF0YSAqZGF0YSkNCiANCiAJZHdjM19nZXRfcHJvcGVy
dGllcyhkd2MpOw0KIA0KLQlkd2MzX2dldF9zb2Z0d2FyZV9wcm9wZXJ0aWVzKGR3Yyk7DQorCWR3
YzNfZ2V0X3NvZnR3YXJlX3Byb3BlcnRpZXMoZHdjLCAmZGF0YS0+cHJvcGVydGllcyk7DQogDQog
CWR3Yy0+dXNiX3BzeSA9IGR3YzNfZ2V0X3VzYl9wb3dlcl9zdXBwbHkoZHdjKTsNCiAJaWYgKElT
X0VSUihkd2MtPnVzYl9wc3kpKQ0KQEAgLTIzNTYsNiArMjM2MSw3IEBAIHN0YXRpYyBpbnQgZHdj
M19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAlwcm9iZV9kYXRhLmR3
YyA9IGR3YzsNCiAJcHJvYmVfZGF0YS5yZXMgPSByZXM7DQorCXByb2JlX2RhdGEucHJvcGVydGll
cy5nc2J1c2NmZzBfcmVxaW5mbyA9IERXQzNfR1NCVVNDRkcwX1JFUUlORk9fVU5TUEVDSUZJRUQ7
DQogDQogCXJldHVybiBkd2MzX2NvcmVfcHJvYmUoJnByb2JlX2RhdGEpOw0KIH0NCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCmluZGV4IGQ5NmIyMDU3MDAwMi4uYjliZjI3ZWQ4YzA1
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWdlbmVyaWMtcGxhdC5jDQorKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCkBAIC0zMCw2ICszMCw3IEBA
IHN0YXRpYyB2b2lkIGR3YzNfZ2VuZXJpY19yZXNldF9jb250cm9sX2Fzc2VydCh2b2lkICpkYXRh
KQ0KIHN0YXRpYyBpbnQgZHdjM19nZW5lcmljX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogew0KIAlzdHJ1Y3QgZHdjM19wcm9iZV9kYXRhIHByb2JlX2RhdGEgPSB7fTsNCisJ
Y29uc3Qgc3RydWN0IGR3YzNfcHJvcGVydGllcyAqcHJvcGVydGllczsNCiAJc3RydWN0IGRldmlj
ZSAqZGV2ID0gJnBkZXYtPmRldjsNCiAJc3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjM2c7DQogCXN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KQEAgLTc1LDYgKzc2LDEzIEBAIHN0YXRpYyBpbnQgZHdjM19n
ZW5lcmljX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXByb2JlX2RhdGEu
ZHdjID0gJmR3YzNnLT5kd2M7DQogCXByb2JlX2RhdGEucmVzID0gcmVzOw0KIAlwcm9iZV9kYXRh
Lmlnbm9yZV9jbG9ja3NfYW5kX3Jlc2V0cyA9IHRydWU7DQorDQorCXByb3BlcnRpZXMgPSBvZl9k
ZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCisJaWYgKHByb3BlcnRpZXMpDQorCQlwcm9iZV9k
YXRhLnByb3BlcnRpZXMgPSAqcHJvcGVydGllczsNCisJZWxzZQ0KKwkJcHJvYmVfZGF0YS5wcm9w
ZXJ0aWVzID0gRFdDM19ERUZBVUxUX1BST1BFUlRJRVM7DQorDQogCXJldCA9IGR3YzNfY29yZV9w
cm9iZSgmcHJvYmVfZGF0YSk7DQogCWlmIChyZXQpDQogCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShk
ZXYsIHJldCwgImZhaWxlZCB0byByZWdpc3RlciBEV0MzIENvcmVcbiIpOw0KQEAgLTE0NSw4ICsx
NTMsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGR3YzNfZ2VuZXJpY19kZXZf
cG1fb3BzID0gew0KIAkJICAgICAgIGR3YzNfZ2VuZXJpY19ydW50aW1lX2lkbGUpDQogfTsNCiAN
CitzdGF0aWMgY29uc3Qgc3RydWN0IGR3YzNfcHJvcGVydGllcyBmc2xfbHMxMDI4X2R3YzMgPSB7
DQorCS5nc2J1c2NmZzBfcmVxaW5mbyA9IDB4MjIyMiwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIGR3YzNfZ2VuZXJpY19vZl9tYXRjaFtdID0gew0KIAl7IC5jb21w
YXRpYmxlID0gInNwYWNlbWl0LGsxLWR3YzMiLCB9LA0KKwl7IC5jb21wYXRpYmxlID0gImZzbCxs
czEwMjhhLWR3YzMiLCAmZnNsX2xzMTAyOF9kd2MzfSwNCiAJeyAvKiBzZW50aW5lbCAqLyB9DQog
fTsNCiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBkd2MzX2dlbmVyaWNfb2ZfbWF0Y2gpOw0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2R3YzMtcWNvbS5jDQppbmRleCBkZWQyY2E4NjY3MGMuLjlhYzc1NTQ3ODIwZCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1xY29tLmMNCkBAIC03MDQsNiArNzA0LDcgQEAgc3RhdGljIGludCBkd2MzX3Fjb21fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcHJvYmVfZGF0YS5kd2MgPSAmcWNv
bS0+ZHdjOw0KIAlwcm9iZV9kYXRhLnJlcyA9ICZyZXM7DQogCXByb2JlX2RhdGEuaWdub3JlX2Ns
b2Nrc19hbmRfcmVzZXRzID0gdHJ1ZTsNCisJcHJvYmVfZGF0YS5wcm9wZXJ0aWVzID0gRFdDM19E
RUZBVUxUX1BST1BFUlRJRVM7DQogCXJldCA9IGR3YzNfY29yZV9wcm9iZSgmcHJvYmVfZGF0YSk7
DQogCWlmIChyZXQpICB7DQogCQlyZXQgPSBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVk
IHRvIHJlZ2lzdGVyIERXQzMgQ29yZVxuIik7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9nbHVlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2dsdWUuaA0KaW5kZXggMmVmZDAwZTc2M2JlLi43
MDgzYWIxOTM0MTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dsdWUuaA0KKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9nbHVlLmgNCkBAIC05LDE3ICs5LDMxIEBADQogI2luY2x1ZGUgPGxp
bnV4L3R5cGVzLmg+DQogI2luY2x1ZGUgImNvcmUuaCINCiANCisvKioNCisgKiBkd2MzX3Byb3Bl
cnRpZXM6IERXQzMgY29yZSBwcm9wZXJ0aWVzDQorICogQGdzYnVzY2ZnMF9yZXFpbmZvOiBWYWx1
ZSB0byBiZSBwcm9ncmFtbWVkIGluIHRoZSBHU0JVU0NGRzAuUkVRSU5GTyBmaWVsZA0KKyAqLw0K
K3N0cnVjdCBkd2MzX3Byb3BlcnRpZXMgew0KKwl1MzIgZ3NidXNjZmcwX3JlcWluZm87DQorfTsN
CisNCisjZGVmaW5lIERXQzNfREVGQVVMVF9QUk9QRVJUSUVTICgoc3RydWN0IGR3YzNfcHJvcGVy
dGllcyl7IFwNCisJLmdzYnVzY2ZnMF9yZXFpbmZvID0gRFdDM19HU0JVU0NGRzBfUkVRSU5GT19V
TlNQRUNJRklFRCwgXA0KKwl9KQ0KKw0KIC8qKg0KICAqIGR3YzNfcHJvYmVfZGF0YTogSW5pdGlh
bGl6YXRpb24gcGFyYW1ldGVycyBwYXNzZWQgdG8gZHdjM19jb3JlX3Byb2JlKCkNCiAgKiBAZHdj
OiBSZWZlcmVuY2UgdG8gZHdjMyBjb250ZXh0IHN0cnVjdHVyZQ0KICAqIEByZXM6IHJlc291cmNl
IGZvciB0aGUgRFdDMyBjb3JlIG1taW8gcmVnaW9uDQogICogQGlnbm9yZV9jbG9ja3NfYW5kX3Jl
c2V0czogY2xvY2tzIGFuZCByZXNldHMgZGVmaW5lZCBmb3IgdGhlIGRldmljZSBzaG91bGQNCiAg
KgkJYmUgaWdub3JlZCBieSB0aGUgRFdDMyBjb3JlLCBhcyB0aGV5IGFyZSBtYW5hZ2VkIGJ5IHRo
ZSBnbHVlDQorICogQHByb3BlcnRpZXM6IDxkZXNjcmlwdGlvbj4NCiAgKi8NCiBzdHJ1Y3QgZHdj
M19wcm9iZV9kYXRhIHsNCiAJc3RydWN0IGR3YzMgKmR3YzsNCiAJc3RydWN0IHJlc291cmNlICpy
ZXM7DQogCWJvb2wgaWdub3JlX2Nsb2Nrc19hbmRfcmVzZXRzOw0KKwlzdHJ1Y3QgZHdjM19wcm9w
ZXJ0aWVzIHByb3BlcnRpZXM7DQogfTsNCiANCiBpbnQgZHdjM19jb3JlX3Byb2JlKGNvbnN0IHN0
cnVjdCBkd2MzX3Byb2JlX2RhdGEgKmRhdGEpOw0KDQotLS0NCg0KQlIsDQpUaGluaA==

