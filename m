Return-Path: <linux-kernel+bounces-863750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CDCBF902B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FC033558BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48CA287265;
	Tue, 21 Oct 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nYxRunPp";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MBRc9tIN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LI1TPoy5"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8A258ED1;
	Tue, 21 Oct 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084606; cv=fail; b=AhfiX+Fw1amu+/jDqjNU5vKeSb+8ERdqmZ1pOzHUJ3ifTXBtKDssXvII3beq02QdKsOnehcZOHwYg3EkD0V1IxUtQ2NbeF+o2jDUCjOuGmeYn8Wdpq/T8RLziBsuzFfZ46ntKCB/45ySeVKQmAWk0ucvJ57F+orfwcG9nC/pEfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084606; c=relaxed/simple;
	bh=0uQsJ8w/6p89ods/QwolaMl1dMAfGgYbTr2QpQ7M/zs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n9xKC3zCVV/jE6ThbYaV9lT/QSR4kys4pqmePEiO7xYHgibcMYwoYxTvGAF1H/CxDiUrz90BDyyt1BMlqlUK3v9INbIjTHbP6Tg++K8/+vtRJtpjOLGuD220Qd4J9hO25d5/yfsLSUYRgESMnDDQpxmlhEKV5UrIOQgua/YP8Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nYxRunPp; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MBRc9tIN; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LI1TPoy5 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LJ01eG024327;
	Tue, 21 Oct 2025 15:09:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=0uQsJ8w/6p89ods/QwolaMl1dMAfGgYbTr2QpQ7M/zs=; b=
	nYxRunPpDrJdklRXVdBtrlUJ2o9HTkERrA6wlZryzo3SQaoQkCmNNLA8T6wHx+tR
	XkfRxRzcKSPA2xkDJKz1y6tGfzrl5nlZVGDN/sIiaWtNloE5Cx1Ace1Cc75Y7YXe
	QEyhuV3RppxaXeVKIiQ9hTxFJ7K92wtmyN2rTKZLM5rx0pAj8886dJ4V1FBMOCzn
	7Ychxr+aXC2P39+J+z37wmHcm9ok0qjKE8i2W8OBueVNnorkrgjiimeWOq9citun
	/vroi+7FYhAzfpDa9qVZNvVj0VW7XFU0wP14sUo1QejDGxAC4g8AkiqfUZHG1Dq3
	P/ziRF1iOLCjgOxwTPzBCQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49va54q0rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1761084588; bh=0uQsJ8w/6p89ods/QwolaMl1dMAfGgYbTr2QpQ7M/zs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MBRc9tINTFdQLdhcVF9DXfnQewKckdsy2GEjwmAlyq5rQVK4yXIQHNK80Z23lHe5O
	 oXyrm2WsAvS4QJXWmgbz6GhqhKHXU9MeVuXOrpSlfbXaIhXfBGQOzgLtOHv6cDC4ml
	 VsvERWVc3wS4TU9EuoJuEYSuI2yaKemntkj1dqAP5fq4pDeAabzCK8cKAApKsvM5pz
	 gNAXRJkpZY7Id5bDHE8nwPAXFvluROCgN+PGADZJ6n/IWj3Jq6Hqiw6L3EnhQU4FYF
	 KmCXHv/6q0Z1xbNulfa3EZnudFCEYq9lC2pM6NmD6si7XwmtTmStQT1AR6U7NZQ23e
	 FY9NNOgNKbg7Q==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8C38D4034B;
	Tue, 21 Oct 2025 22:09:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 34127A006D;
	Tue, 21 Oct 2025 22:09:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=LI1TPoy5;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00105.outbound.protection.outlook.com [40.93.13.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1E4084060C;
	Tue, 21 Oct 2025 22:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3VdPxVbmsmthpc3hTl0z2h61iNgEnZ3nxYax2bgDMtg0JonaJjDd8qeEuf/+a3oxdVS5/d27mTvT9FSZUbjMUHdWjdSxHN309Mzo4yTNlsLP0KogISiG2FA0eQUKD3KmZx3KesgsrCvBYrJmYm6k4u7sCs6ZsiSOzlBhVfcpkX1rcu6vkh9x4IYj+h9wWIQhUmQuPSougJv+ooilrtjJo/vqZ+TJHPfrTAk2glzY0e3tubi0ZVc6Pmdf6Q0OSOKg6Cg8UOxqHgsUr3Ly3nMfktliQpJIM4YY1j4C4sxHJMhx6fmwtvFAOndl7xuyAIhvuzSG8exILGLiJb9RvoO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uQsJ8w/6p89ods/QwolaMl1dMAfGgYbTr2QpQ7M/zs=;
 b=lTJYq8NtsLEJnbtnb8eiK2kyxYEcSCSYJb2D/nns1jze0CUutXUCccjA1AltuKjIUMfopOMVnu4n9hSi/UmvXffAj55kGQOm4z/iOsJx+U9/7i5htbNGwFMWaBgxRnZ0AobP/na/UFh6d/gycAOpqxakgBEEKYA0bJwkVi90sdn4BsVcVAuXCpGrrMZ1BA8EfNsH7+lG8RF3OrM5Rbx3Wky/siQRMglVegU/9XDi6xIFadG8I/ISnyP4lxAoG1kXuc89MvgMk/jirWz0X6n/Hwc3WuAhhFD8JnG8nvJ1h/GPdrUqDY70dPSO+lJoAv+348KrBpIyteMEF/VbulmNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uQsJ8w/6p89ods/QwolaMl1dMAfGgYbTr2QpQ7M/zs=;
 b=LI1TPoy53lvn59i18VjcL3xusI8AszchrSSg0qW4hGvBqMXDa/50yKNj3ub0Y4he7I3IQX6ilNAfS5fu+cVm92Byo3UXrqLRE2Acpnoyhlm1DplMmupjI1s0bRAbibf5e3/qGNVhtv3NgHnA2BEFoBISAvabZeFeuRCpjPxNx3M=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 22:09:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 22:09:44 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Pritam Manohar Sutar <pritam.sutar@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rosa.pila@samsung.com" <rosa.pila@samsung.com>,
        "dev.tailor@samsung.com" <dev.tailor@samsung.com>,
        "faraz.ata@samsung.com" <faraz.ata@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "selvarasu.g@samsung.com" <selvarasu.g@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Allow usb role swich control from userspace
Thread-Topic: [PATCH] usb: dwc3: Allow usb role swich control from userspace
Thread-Index: AQHcQbS2+WVqc65QpEKzjMRfB01DBrTNK1uA
Date: Tue, 21 Oct 2025 22:09:44 +0000
Message-ID: <20251021220935.5njyz5lyiwrsf3rw@synopsys.com>
References:
 <CGME20251020112840epcas5p28d8eded5200f096e7b80f71899371f2c@epcas5p2.samsung.com>
 <20251020113723.553843-1-pritam.sutar@samsung.com>
In-Reply-To: <20251020113723.553843-1-pritam.sutar@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB5667:EE_
x-ms-office365-filtering-correlation-id: 7a2b1494-6928-40a3-1fc3-08de10ee8a78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGhhUk42cVdvUHdqYW55Rkw3QldkY3hNOFpTZ1laUjFFdm11S25rNjgzTFRV?=
 =?utf-8?B?ckxiRllrbXVmTjkzaDlkeFFDS0tHMHZwaDB3MnJEL21lSG55b3E0azlnU3Bx?=
 =?utf-8?B?R0xzaUREaXVQWStoc0tRZ2dPbitBMExDamIraHFVQjFyMFNWWFoxMDMyNjV0?=
 =?utf-8?B?RDlSdnRILytMcGt5alQzL0dVakd0WkdxNHVYZDkrSzJHRkNlaXVVTnZ5bTRo?=
 =?utf-8?B?VHA3b1ZJQyt1NlM2azNoSlA5ZUpPbmxLdU9NWnRuWEVsOUhYa25WZ20yTnBB?=
 =?utf-8?B?M0g0ODNObnRHTldpRk02TnZnT3pWTjIzV0UrL2FCb2tHT0xTdDYrTStiYTlN?=
 =?utf-8?B?ajNMb29GMm95aTBlbnp0QUN6Q2JDd0lRQWlETm5JQ0p2dTkwSzU5WnFZeTBz?=
 =?utf-8?B?TXpNMEM4Zm9NdkZpNmpGcElrNW9GamF6TWhySzJsSG9Mb0NON09aT0ZEYXdr?=
 =?utf-8?B?aGllOHNpTUc3c09BT0F1OHB5UTNQSjJLQ0JBSU1wNitVMXVVSEczUldjWGtF?=
 =?utf-8?B?b3VENzZVeDNGbUJ0N1RHTGw4TEFSRDdMZStsZWdTWkZHQ0FxRjROM0hFTHAz?=
 =?utf-8?B?MHM2T1doNHVsVUg4VG5zZHlUZHlPdzBKRE96ZGxTeWdNNDM0UVB5M1BmK29p?=
 =?utf-8?B?SXVySG5Fc0dVYjV2RlFtWkRPNVZiZ0JIcmVYSVkvN3ZoUTBYcko4K2lObFFO?=
 =?utf-8?B?aUpFa0oxUzVzWFY3bFo5S2MvTWlxWVMyd0JRZDd2QkozWjFyTEo4SlFHMUZs?=
 =?utf-8?B?azBuOGhzdlIrU01hRkJ6dW5BeUhVekNZWnIza1ROcU42QmlYTWlWT1Q3N0Vh?=
 =?utf-8?B?Wlp2cnVRVC9rTEx3OVV0Q1FDQ0RFbThVR2o3Y2pERkpkanh1RnRLUnRoZG4r?=
 =?utf-8?B?L05GMDVGejhFM0Ewa2c3RStNNDFrdk8rNDQ5SEFGN25TUFNSTFBzZytvSDhO?=
 =?utf-8?B?R2N2ZFhVcXJtdUxYbTkrZXZWSkRtL0tQNEJRUWlTRlhlUG9HL2dZNytCTitE?=
 =?utf-8?B?Znh4ci92cUgwUElMVjBLb1dEOUMxMVdGNGZmS2JjZ1NrZkpsRWJwNVppemsr?=
 =?utf-8?B?UUdJeTczRVd2b0NiK3lJSmFGcDRwVVhlU1dROVFoRG5qcEhrSEdHdm5jRDFo?=
 =?utf-8?B?b09VdFYrYzBkcjN1a3VQbEIzVUY3SE9XS3JIaDdsYitucThYSTVNdmtIc3ZF?=
 =?utf-8?B?NkFIQWN1bDI1RHlLUGtLVUVDOXFSSFB6R1BYNC95TjZidDd5ZFY0N3IvczV2?=
 =?utf-8?B?bUZjQnpBQVFNTVpaMUhxd25OeE1MUWtlMFR2bTBleEpCSkQ3eG5oaHdWQ01U?=
 =?utf-8?B?TmF4TzJRQTd0TDVnL0N1VlpCc3FJUDVyd3Q0V25Ocm5wZ2RCeXhZbWFJYmhu?=
 =?utf-8?B?VVlWaW81RTRFVHlrLyt0RFRtaFN4UEt3eXNFNjdaV1RXeGdNSTQ5NDdMNUx6?=
 =?utf-8?B?MGQxVXhPVW9JR3cxYTJpVVVaQkdsdUtFQnVpNmdndUdlMGswVDdmTU1neUcy?=
 =?utf-8?B?K01yOGlVbURCQU8rcTdzU25KTnQyZ1o0bWQ2L0hOZjg5czNnak5zYjd3ZG9S?=
 =?utf-8?B?Y0JHVVk2NFJqd2pHYWl2WFFCTVlsSnhxYUFaYi8zalRJc2JidktHekhwOVFn?=
 =?utf-8?B?WmtaZUZMdzdIQVdkSWlSL1gxSUZueGZTcjE2ZkZEZnBndkFSRkNmZ0huZHpy?=
 =?utf-8?B?TGlTbnBvd0V1c2hmeFV1RS95anRsd0Jqb2xLRHJvdVhsTTZXamk4QnFGaFJr?=
 =?utf-8?B?Q1BUQittUUhMdFM5MVNOL3AyYkdNd0sybFBuQzRwZmhMdmZoRTZpNHdCNWhv?=
 =?utf-8?B?SVRiYm9uNUdDcm5JelJwMUNuRnBwWDdsS2g5Y0kvOGdtM2g3UnN0QTlwcjJD?=
 =?utf-8?B?dysrcGhBUE5LSXJuZXdFelBwcktaUTJ4ZVFpb2wzQUNXR1gzdUJycXl6clVE?=
 =?utf-8?B?Q0lGa2dYMkNVV0IrTVhkVFdsZU9GeHJ2MExhSFpITkgwdjZCakNxY2tpOEhq?=
 =?utf-8?B?RGt0NjNRbCttSXdCSWZESDZUNGxuQ1IxRUc1QkJCV1pmNEE4WUJDMUlZTkQ3?=
 =?utf-8?Q?tYBWQB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzR6Szg4SzFOTS81bWpMQXp5dkptVVJIWXFsaHo2Tkt2dHZhWW1TaEVCSW8w?=
 =?utf-8?B?cHJSSmRCNG03R2tXN3pnZWdZeVRoZEg0dXhoOXJncW8rOFhrUU5XL1ZJWDdt?=
 =?utf-8?B?Nnk2bERROHByWmNTdGRvR0J3M21ZeHcrWVdJaDRRdXk4K0diU3FJTXlmdDlV?=
 =?utf-8?B?RmpWMTV1ODJwV3htM1VPelJxTlA1ME9NOTNXOFhlb1JTUGh0QkZZalZyUmpz?=
 =?utf-8?B?UkdtMVQxdTc1azRzcXcxSXlkd3NsV0JNUDRLKzBRZnJNK0diZnZkODNVcWx3?=
 =?utf-8?B?UjY3ZWYrQTB4Z2RMNXE5TGRKbG9SQlhSa1FVN2ptemxHYWs1VW9oQkJwLy9P?=
 =?utf-8?B?K05GOVBITWdYVDFja1RNQUo2bzlTMkJoS29PQU5hV3V6dEdlbEZNZWtlYWd6?=
 =?utf-8?B?OW9VREVLd0libC8vMjhONi9sNE90K2V4ZXlud1BhaXZwdjB5QmdLUy9mSzM4?=
 =?utf-8?B?eHZoRVVRZzd6eGVVOG1mTDg5cXNsaUtHQzhubTdUVWJjQ2g0aG1LdVNUMmgw?=
 =?utf-8?B?L1NaMzJIOXFNV3Bjem9IZ1BNQUxla0YxQ2xyRnVuRWpZMjMyMUNXWWczaFor?=
 =?utf-8?B?SmhZYlBtQ1pBZ3QrTStXRXR6clV2WnVRcWZtbzQ0NGx2ZXN4bUNRSDdCakVG?=
 =?utf-8?B?bmQ5YS9Wc3FZKzlMek9JRWs2STRMNE9wN3J1dk8xR3RGSnI1NE9aTVVLZHV0?=
 =?utf-8?B?MktLTDdUdWc2ZWV4MUtqNHI2a0k0eGhXLzhKckU5WGprOTF6QlpGZ0k1OEVE?=
 =?utf-8?B?WjRYaXRqNXA4VU5UR3FmZFF5M09xUlM4WGNnZlc1UnhBN0hJd0hJSk43RkY1?=
 =?utf-8?B?aWxzUkhMbXp2d3ZGZnFZaHZ6VnRjdjE4elZzY09TNXFVTFVSNXdJNytCNGJp?=
 =?utf-8?B?NnFHaW5kL0pVUjFzSHNYTFNYVXBZb09uSFFMTXdpeXNlTUY2R2ZTQkdEdGpC?=
 =?utf-8?B?YXlGNCtRL2w0UU1lMjMxOUJHejlseTlaWC9BNUJOaDYyZkQ0TUozTU52ZkFE?=
 =?utf-8?B?UVNVSHMvNFE1ckRTV0g2Wll6MW9wVWEwcnBhU2oxM1VVZ09BL1pCVURVdFVj?=
 =?utf-8?B?VlJHYjJwalZDdEJYYmZDMzJ5Q05EUlp6ellnTXVXYkVUZGgvcHA3SXNpVVR1?=
 =?utf-8?B?eHk3RXJsbmY1YWJ5TExjOXNLZVpWdW5lRTZaU3J0Z1BVZzYzcUdjdmhPNmhN?=
 =?utf-8?B?ZWMzaXpFOVpNRUdwZDdGWWFxVkw2UnhQRmFhVnZMQTkvSUdXU2ZyT29QemZF?=
 =?utf-8?B?Sml5bEtCd2VtRks5UlpxZXpZYjVHdmh2UVlxRFB0em8wUUU3S09oQjNJTVNY?=
 =?utf-8?B?Wm55RFFqbDdqYXFJZnZUUUVTQ094dDNNL2ZTbGVkY2g1OXBFV1o0YlpMN1NW?=
 =?utf-8?B?eXp6cVFmMWNtdHhhenpPRGZkb2FiWjZxdXFpQXRaTFVDbmhscFFEWEZ5ZnJI?=
 =?utf-8?B?VW43OXdSZ01uK1FGU2RLcGxxV1MzRHBmVWlycnBPK0tBN2xPRzI0SmR5bEhN?=
 =?utf-8?B?V2lBSjdDV1FvK1F3Mk9vWVBmL01MMlJCTzZPOS82QjhBSTZEQy9Eb1V2S0Vm?=
 =?utf-8?B?L0I4SUZRbENid2VmMjdpUm04OURNcW1HaUY1bDFBWXlRcTRQaGNVQ1UrMkM0?=
 =?utf-8?B?VEpsMW9rOStLMU9TeUxkNWVBaFpsYXhKSG12NFBQU0JJWDJNbEU1VWhwZHF1?=
 =?utf-8?B?MUt1MTI1cm11TGNNczNldXF2TktyNEtuYW9zMm9uNm8zdWROaGlFZHRBTGpR?=
 =?utf-8?B?VFJpaXE4bDgrQjR3YzVIR0g0UnBjdXV3eVhVcitGYmxncjFOMS8zR25KdWFT?=
 =?utf-8?B?bXpUMmNkREhwbTdjRlhFSTVHbmhsNjBlMWpNMExWSHNRTzFuVjVHT0QwUDZM?=
 =?utf-8?B?clJtb0pLUVBzQkN5eWlQNUJnMHplTUVxSFVrYVVuL0FtTERqNVpOeUhiRWE3?=
 =?utf-8?B?QkR0Y1R6TWVOSXdDTW1SNWxqblUrdmsvK0JFN0xoM0NCVTZPdTVxZ2dVNHFL?=
 =?utf-8?B?Ynlpb2VmVG1JOFNxQWZycDdsQUVvbU1ydHl1REpwY2NUa3RHa3pYVHl0eFky?=
 =?utf-8?B?SFBEUFFveWZYaUw4ajVkYUhaWFRDL3dZYmRVOHFyTVd2cXZST29hbFFVN3BO?=
 =?utf-8?Q?m7KejB9AKhbuOZEAv3EW9NPAl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A57635E6DCF914486728853C606B359@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kwXzGJdL0/znzgsRUgzMaghbcwEsquk3STUQk95fjNB83we4op3HS5A1OZdlglE6N9VtPap7vuO1JYsUaX87fBVbWKqNrZ/a2OOnpIpkKPExfNP9n0GxMFvVFwcBcf89vGrnHbjsczhrWLVm0fYRtwt4LLM+cOpWrKZQktmmlFJExJl9WMpB4Uk1tFb9+QW3Ckby9Bv5n6sz2We3+TXyee7AQDXUAUjMySahoCWlxYIRmIa1AOhyZcKQE5l0wI2u7FVZoui4OtIFBR0EwGYn+aMamgHzAVELAKjhLQx3XomkPRyQN+Fh7BqLfdGn3HxZ8NBDd/gFlf/7O9vTlpTxc+QS5R3MjBH4+j7pTERJ/LOZnCHwnaP+/oIty3BrhmoxQxLTTRqL9ghZEDAv/kmIJx5A++G1QfGyN8JwG3VF2whPA0o1oXnUaPMRTTKjEUFzCgye2KjAVU7d7zCKhFSJBg6r2TyLHXYpUfbwcII+KpI8QAMubP8wC129dPNqTSS0GkQLecbVFLkblMvfMY0rwy5q+VTOGDfO7IY904Flf9FtqQlrQ8ybRsltddhuEZBn3kUUlSKtp5dnw69mOLzVjpSTUP3z3e0Xxbx8oRkVoqGfsOvWga+DkuIkmPRouuXrp0A5sQR5UcDhCSL5AKuGnA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2b1494-6928-40a3-1fc3-08de10ee8a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 22:09:44.4453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCM+Aa+pKGscB0zAHCEVL830p7YVu0GE3EAuz3p4cfRSJSZSIWuJxW5EwJSghAXn/i0qOfWnKAylJf6QVq+EtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
X-Proofpoint-ORIG-GUID: O0e9UWwCWR3sEec6Aex3ZynGDZ_JxaLr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDA4MiBTYWx0ZWRfX69se0Dl3hX/i
 T4w/XkCGrqVu2vsL+Jd0oe1KkhNGV3gvPEgTSCsjMDH6bcoMSS9Pr0lL91qicYeIVaPfBReVvuX
 Pv+x/ocSY4DoRfPWIrtQZRRXV+ZuLDBOMrTJi+7vNZPy143slQBO37jeYrjOrlV4rCM70wOb+Jy
 uvrTKvwuQRugk8VpaY7OCq3EPnZB+zfpES/h8hWcfp8PBEbrmREJZtlWdeQpwjPlpKGlDKAnZE9
 RE3sqLQIWFjeFxVGNfs6OzdQFY4X4xc3WOx+Dpi3o+cw1/Bkq79H0/PR5Js8XeKAIOOTF7Ln5BQ
 V9wtJnN3+aR3r/VmVjMZjNO9RgCswPStp/QO9TirejomrEyiuxGk8zInXCEgkSY/Bc0Uj/uneVh
 DxVF6RL27qLs/apcUSdLepxNQlT8TQ==
X-Proofpoint-GUID: O0e9UWwCWR3sEec6Aex3ZynGDZ_JxaLr
X-Authority-Analysis: v=2.4 cv=H5HWAuYi c=1 sm=1 tr=0 ts=68f804ad cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=hD80L64hAAAA:8 a=o24w9LYbuXkecPaBBSAA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2510020000 definitions=main-2510180082

T24gTW9uLCBPY3QgMjAsIDIwMjUsIFByaXRhbSBNYW5vaGFyIFN1dGFyIHdyb3RlOg0KPiBUaGVy
ZSBpcyBhIHBvc3NpYmlsaXR5IG9mIHVzZXIgbmVlZHMgZm9yIFVTQiBtb2RlIHN3aXRjaGluZyBv
biBib2FyZHMNCj4gdGhhdCBsYWNrIGV4dGVybmFsIGhhcmR3YXJlIHN1cHBvcnQgZm9yIGR5bmFt
aWMgaG9zdC9kZXZpY2Ugcm9sZQ0KPiBkZXRlY3Rpb24uDQoNCkl0J3MgZmluZSB0byBlbmFibGUg
dGhpcy4gQnV0IGJhc2Ugb24gdGhpcyBjaGFuZ2UgbG9nLCBpdCBzb3VuZHMgbGlrZQ0KdGhlcmUn
cyBubyB1c2UgY2FzZSBhdCB0aGUgbW9tZW50PyBJZiB0aGVyZSBpcyBvbmUsIGV2ZW4gaWYgaXQn
cyBvbmx5DQpmb3IgZGVidWdnaW5nIHB1cnBvc2UsIHBsZWFzZSBub3RlIGl0IHNvLiBJJ20gaGVz
aXRhbnQgdG8gYWNjZXB0IGNoYW5nZXMNCmJhc2Ugb24gdXNlIGNhc2Ugc3BlY3VsYXRpb24gb25s
eS4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiANCj4gQWRkIGFuIGBhbGxvd191c2Vyc3BhY2VfY29u
dHJvbGAgZmxhZyB0byBoYW5kbGUgc3VjaCBjYXNlcy4gV2hlbg0KPiBlbmFibGVkLCBpdCBleHBv
c2VzIGEgc3lzZnMgYXR0cmlidXRlIHRoYXQgYWxsb3dzIHVzZXJzcGFjZSB0byBzd2l0Y2gNCj4g
dGhlIFVTQiByb2xlIG1hbnVhbGx5IGJldHdlZW4gaG9zdCBhbmQgZGV2aWNlLiBUaGlzIHByb3Zp
ZGVzIGZsZXhpYmlsaXR5DQo+IGZvciBwbGF0Zm9ybXMgdGhhdCBjYW5ub3QgcmVseSBvbiBoYXJk
d2FyZS1iYXNlZCBtb2RlIGRldGVjdGlvbi4NCj4gDQo+IFRoZSByb2xlIHN3aXRjaCBjYW4gYmUg
ZG9uZSBhcyBiZWxvdw0KPiBlY2hvIGhvc3QgPiAvc3lzL2NsYXNzL3VzYl9yb2xlLzxBRERSPi51
c2Itcm9sZS1zd2l0Y2gvcm9sZQ0KPiBlY2hvIGRldmljZSA+IC9zeXMvY2xhc3MvdXNiX3JvbGUv
PEFERFI+LnVzYi1yb2xlLXN3aXRjaC9yb2xlDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQcml0YW0g
TWFub2hhciBTdXRhciA8cHJpdGFtLnN1dGFyQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvZHJkLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2RyZC5jDQo+IGluZGV4IDRjOTEyNDBlYjQyOS4uNTg5YmJlYjI3NDU0IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2RyZC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
ZHJkLmMNCj4gQEAgLTUxNSw2ICs1MTUsNyBAQCBzdGF0aWMgaW50IGR3YzNfc2V0dXBfcm9sZV9z
d2l0Y2goc3RydWN0IGR3YzMgKmR3YykNCj4gIAlkd2MzX3JvbGVfc3dpdGNoLnNldCA9IGR3YzNf
dXNiX3JvbGVfc3dpdGNoX3NldDsNCj4gIAlkd2MzX3JvbGVfc3dpdGNoLmdldCA9IGR3YzNfdXNi
X3JvbGVfc3dpdGNoX2dldDsNCj4gIAlkd2MzX3JvbGVfc3dpdGNoLmRyaXZlcl9kYXRhID0gZHdj
Ow0KPiArCWR3YzNfcm9sZV9zd2l0Y2guYWxsb3dfdXNlcnNwYWNlX2NvbnRyb2wgPSB0cnVlOw0K
PiAgCWR3Yy0+cm9sZV9zdyA9IHVzYl9yb2xlX3N3aXRjaF9yZWdpc3Rlcihkd2MtPmRldiwgJmR3
YzNfcm9sZV9zd2l0Y2gpOw0KPiAgCWlmIChJU19FUlIoZHdjLT5yb2xlX3N3KSkNCj4gIAkJcmV0
dXJuIFBUUl9FUlIoZHdjLT5yb2xlX3N3KTsNCj4gLS0gDQo+IDIuMzQuMQ0KPiA=

