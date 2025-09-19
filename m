Return-Path: <linux-kernel+bounces-825217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234AB8B4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBAD7BAAD2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670C28CF52;
	Fri, 19 Sep 2025 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fK1FckOQ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O4E6wY+f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K26E9E83"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE662D2385;
	Fri, 19 Sep 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316537; cv=fail; b=lM+G9DMZ2ZUerAG70RCD4SMnAUn75+YW86Q//4Cga9CQYhWOOOyT+679t2N4qGJJ+CT+9ndoZ0HGo3Yn7ajR93Vb8ZxnNtKvJpCwx8SVBSeNCiQ/vwm1gD13S41GPPX1sUb4LP5MTePsLiU+4jXJyfBrPyjt7Zhw2Er2OfkBhFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316537; c=relaxed/simple;
	bh=5jiI6S3ZXn7jBLAsaAgraZhBONwY8kPeLQe0E12ZXyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TNQv5PJERqkYGFXv8dZlHlZluv/zmNt8gaKZW4DA2xkBvg/EqR5r+XsXDpTaXFBeR8sBs7LcOu5kuMARUtW/1LE5Bmt19WrSFt3KPuzFJOPICtBUPHWzgPuS5+6F8XYHwJvCG/8Upx9VFC9Hrk02zAcvD6HSJWDHfQqgugJRlA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fK1FckOQ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O4E6wY+f; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K26E9E83 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JF0PYZ012591;
	Fri, 19 Sep 2025 14:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=5jiI6S3ZXn7jBLAsaAgraZhBONwY8kPeLQe0E12ZXyg=; b=
	fK1FckOQaLECAtxX15oZFMZ1H+bayakstCYmTcgCyH5c9xWcQjj7h2D5Amo0okXI
	TizrpW0cTSzN0UdCZKyT/TUbQeQT0hk4AtuA9h1Blzt+kiY9akoNddIEldrkHYrW
	Xx0Y9gEafUP4iFMMGD9K+69KqAQ6TI/m8OxR0YdcFK5HJwHRCC8/UPCmNdrwXRV6
	NNTak1PUGc0jeYkLGnmd6D8ZX3bY3capCundsoUlYZX5bz4qe6mtfD2U+IEQmP9e
	3/38vGlmHCjeaq+vSCUYZuWybxezGS7mQkhHglUN3O0MN6ss16FLX1iqCOheslHQ
	KTeEvwX3w5ytQdPf+kGjpA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 497fxy29xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758316494; bh=5jiI6S3ZXn7jBLAsaAgraZhBONwY8kPeLQe0E12ZXyg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=O4E6wY+fXcRMEqMRHyX28X23qpaOWMscuPWjoIH+3N3zgvJiOqsUTPtwWA6LO1REr
	 SSrRzAOcyGwx4AW6av20KnqKfTpLWk4BZyUmyA7bheqfPSRZFigfFEUOSDiCsi5kBL
	 qr7z/F/rwC/t0VzwW1PMwx7nCCOKA7bGkdvl/TSuFCGh+P410AGkjOSrJlE0Qk0FHE
	 52ifP1pXXy2Lw0N97Mx+jNLJUJwQfMhuDAagv/Z3erEVMdYJsP/UqxY4grEsPAUQUX
	 /MsjECHAhIn/02+1KZVmPhowUGLthSeKkc5dc/1sJBLtST88FPWNyMpO5vM5f4hzUV
	 t98N//cq6bMJQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F6D8404EF;
	Fri, 19 Sep 2025 21:14:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 20739A006F;
	Fri, 19 Sep 2025 21:14:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=K26E9E83;
	dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com (mail-bl0pr07cu00106.outbound.protection.outlook.com [40.93.4.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 050D940108;
	Fri, 19 Sep 2025 21:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrgMRk6RqchgXZd/E6gtjpERpJqM/uJyAiYregLViH+7yglJEyd0z8U/slWPmIr+NfZe2ehrwlKH3PaMZK0UlRW6iRXj86QnFkCBxNRbwpGzNwTbCr3UeohvSi7njLqNFRAD3QgqtCxec/M3xkuYxWGNkvycanFWViGnSiaBQEhiCbPSf+X/q+VLwFgNhkRpQqjPfFKGNGwI5UwItlQBPhu1s8Zkz/FUknyKzDno5qW7EO4IjcKmOwrKCkCcndh/1phsPf5uS9oqlEh9yUmM8Tf1fMpriSnoSDhHBdfIiXs5mcyNdERDzhS92Elc0joHguiiQCVt8k0yK9rnLXPTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jiI6S3ZXn7jBLAsaAgraZhBONwY8kPeLQe0E12ZXyg=;
 b=d8cEPez6I4P3u/vBf8tGC4Bwj82iDdmjXAdv67m9b2b1zS+H3fE0axnvc+jFFPebF0uLgcdLmWh++Ece6HY2uWHO+BzC3fvWmODlaM87d7XgDNn8f/p7xjtLn1Pj/C45WeZwtUqLR9kEJJ0wt6JIDy7mWClEEU65mOdCHHOoxXqAzSb9kbS3GoPZbKm2tlEBSyc5GxbmONV/Q32uN/OfNAKsZN1HjQJq9f81c9J7B9tIVLX+7r81CHLKmU+ntzM0aTjfE+FaUDxspZzhVk5SG0F4rAQri9wkWPjMakfJYPS5pqEhhnePQ5DgxB0wxH9a2r/MrE1nARitrgoQjTpJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jiI6S3ZXn7jBLAsaAgraZhBONwY8kPeLQe0E12ZXyg=;
 b=K26E9E83yThfvYVly0jjhc7KTkkin/OIgVKUOBTcyn+uchO0MJnaRgS88wv6XNwndde9jmKFO0S+lYziK6bvBAloHwgjfxyBEqqc14tKq9aqNDR7j04BiFA7QiuHmRQTIvfyEuo2c2WeJZnnqTUB1k80cim3N3CbmCWFovNcKh4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 21:14:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Fri, 19 Sep 2025
 21:14:48 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "caohang@eswincomputing.com" <caohang@eswincomputing.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ningyu@eswincomputing.com" <ningyu@eswincomputing.com>,
        "linmin@eswincomputing.com" <linmin@eswincomputing.com>,
        "pinkesh.vaghela@einfochips.com" <pinkesh.vaghela@einfochips.com>,
        Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v3 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Topic: [PATCH v3 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Index: AQHcJiCxWmezSI9mRkS7PpgfdJfraLSbCIuA
Date: Fri, 19 Sep 2025 21:14:48 +0000
Message-ID: <20250919211435.p2s2trwk5vkwa6qg@synopsys.com>
References: <20250915085329.2058-1-caohang@eswincomputing.com>
 <20250915091051.2148-1-caohang@eswincomputing.com>
In-Reply-To: <20250915091051.2148-1-caohang@eswincomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY3PR12MB9677:EE_
x-ms-office365-filtering-correlation-id: d007ba75-9e91-4ff1-0f39-08ddf7c190b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?bExmRFhDbFRQYmFPSU5ReC9wVnVBQlp1U2lYVWxWVVBBT1hyd21rWG1jZ3pT?=
 =?utf-8?B?N2pMYjVqSkhkcmxxcmhoZEhoUHcyb211elZoWVY2MUtUWkdFbGcxcFpsalRN?=
 =?utf-8?B?aEFrVVc3dnVmNXVxaStEdk5sZ0tsMW5QQzFsNldyQTlPUXhiVXFnUW9jUXIr?=
 =?utf-8?B?b2tTbGRsdHJCRVVNYzhQVEdOYVRTTXFHT0FSbEs1Vi84OHo0OUdwVXRvU01L?=
 =?utf-8?B?eVpDVlBzRzFuTEdwakQwRHVYaHdVR25PTlZWaUlmTjJ2Qk9ib2F3OXFWT3g0?=
 =?utf-8?B?MklvTHM1bFNiS1lyYm5BV3FSS2RPUUhjbXhPcGdhYmVNbzMrSkVpQy95VFRx?=
 =?utf-8?B?S0puWVpWazdVZUl5aFVhbVJ3anZWU1IvendEdWFMc1lMYlcvRHJPNERTQW05?=
 =?utf-8?B?MEhYVUViWFUybGxCS2NodTZJRVFJNHBDM05CTUFIUlpOUWlIaVhQamszWmtH?=
 =?utf-8?B?NGNzaW5hcWQ2cjR6TEhNa3U5WFNNa1hpMzBweG9qbXZRMUVEOUU2cVBGT1Ay?=
 =?utf-8?B?aHRibmljVkNHdXJ3ZzhSMVRoWEVmQzFsRDdyVkxxajhHSW9FZE9EbkxiQjBV?=
 =?utf-8?B?TVQ3YnFWOXVjcDZSV3VDUEtNOWZJd2thOWZwMVFLcjBCOHFkWmVBSFI4TXA3?=
 =?utf-8?B?UDNzTkNGb2xYVy9zK2JIdys2QnY5VHpWempvVlk3emZnRHdwZlFaYjRJYVN2?=
 =?utf-8?B?NFVqblJRMkl1bkxZbmxDRDFZMjBHano3Vk84SVFwZ281NUtTbVh2SEhUUjJE?=
 =?utf-8?B?UWpiaExNR2VmcHk3dXRQSzVKYjd3YkloVE1oc09kM1F2SG5GQ25EejZaVjg5?=
 =?utf-8?B?NU5vdGtFYnc4ZFB1WXEwY1lQL0tpWHIzOUhKK0FSN2Z2Zk5yeXN5MGpyTjJN?=
 =?utf-8?B?bmNLVWFIbXhGUFd1UkhDWWJnR2h6OEt5dWxXcVJIalNmazhpd08xRHQrTnRU?=
 =?utf-8?B?YUlOdzg5M2kyN0xQWnNXdndGdTgxRHdneThFVEJiZGxZY0FRaDlZRlV5TmJN?=
 =?utf-8?B?RWVCRnNteXNTZGdQVDBpNWFXWHpFZ0ZIaEc0UUdTamhwMnR6Y2JyamRweUky?=
 =?utf-8?B?a3htdVF4elVJQWJuRnRsZHRmM0xCMU83MlAwODBsUks5ZUpKZmNjZmZia3lJ?=
 =?utf-8?B?bklHRmtQUXd2R1F0OUk3WEQ2R1V2R3RDeEFpZjZHOXU0a2xpeGtlOUlUQW9a?=
 =?utf-8?B?bERIRWJXL2xzOXN1bkJMZTBwZ3BpTG9URGNSYWR5b3VsSEpTSndOUEJ3VVNw?=
 =?utf-8?B?M3VQZnNCb2Mwald2Z1Y5bjdsQmw3VjFtZ0hKd1R1YUg5SkZDK1FBaTdieTU0?=
 =?utf-8?B?cjVWZEIzcDNLcmNMKzVKRmc0aXNrbGlicENScjBrWXJYY3hPOFBQSFV4VmZS?=
 =?utf-8?B?dUZ6T0lsVkN6MHlnQU95b0doUHVLeWhkemFvaFFDZFBzRzRzQmNkTUJucTNo?=
 =?utf-8?B?MG1EUllycUg0L0t4ckd1eUNlWTQ2dWxuNW1QcUVESVByNUk4dEp1dCtrQ2xk?=
 =?utf-8?B?SDN6Z3RLemhLT1hkYzdDT0lMSm9RemZhNjhEeWZETFliSzhtQXhTOHdHQ1pW?=
 =?utf-8?B?L0xlaEtTRjJsSEE3WUVpZzZBOHJ6a0x0SjIzN2tacVk5OVk0R0xWaGczTjd0?=
 =?utf-8?B?eVRnMTI4aER6V0hDV2VvQzJObW5tZUZFcVdNd1ZMZk1zMmV1T3NkdEFBYUJE?=
 =?utf-8?B?UzRYbUlSVk9iZ25pUVphMnFSTEZ3dmFucDlmTVJHNFdXM3pNTFZGMi9TNkZG?=
 =?utf-8?B?WElqNVQyZGFBNjBPc1JTeWJkK3hpWmlkRjhxdVphRGVlUnQ5eUdjMUd3UmMv?=
 =?utf-8?B?YURhampCdUNzOFJ4MGN4Wjkyb2ZhYjl3c3Nxd1lYczF2U04rQWViTXlHbVBH?=
 =?utf-8?B?VkJsdFE5RnBPc2Y2Y0p3UXd1QmxqT3VqUHM2S0NLYzdSTTBzNitadlVmdVNC?=
 =?utf-8?B?SC9CTmlNdFRPcU9oNW93dEQ3ZzFyUlRLSlp0VlhNZ2tscE10a1VTdnU5K3B3?=
 =?utf-8?Q?j8YH2fK18OePfZsBFl0F4/gm92s3FY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1MvT21xUHJVTGM3aUFtTk1nc0tmeHBscEZndy9xcmlaSUF0SVpRb0o0bEhI?=
 =?utf-8?B?ZVBYdWdTOUpDSDlCZWt6LytEUDF5U2xMYW9WaHNhajBTQWNVeldUYzRzWFkw?=
 =?utf-8?B?NXREY0hvOHJRR05BRkpXMmdydUtFalNpMTRtcGVReDdPUjNDNlE3YVlxdThZ?=
 =?utf-8?B?V2xZejRxb1F1NGhPNmFLMDRYL3pkWlJxR3ZvSFlpNXJoRS82K1lXSWdSNTRv?=
 =?utf-8?B?YlBYMzBuV0hFOFRXaFgvMVJqeHZSclRoVTFpREdsNTRSS2l3SnIwMm1pM3k4?=
 =?utf-8?B?RmJ1YTJOODdlTHB3U2VrMWYyQUE5KzJVS1h6QmJReHNVbDhSd21WWGJ2R1FD?=
 =?utf-8?B?eVluTlNXZnRLSVVBZFdqMWdVU2txWGxPQzMyVElwb2ZMeC8vN0h1MWMvTGdu?=
 =?utf-8?B?d2JwWW1ybENpUzRSZTE3YUZKdm01RWZNQXZyR25lQjZvZThkK1dzWDVZWUli?=
 =?utf-8?B?bE5BaHNTOVFTZFM3SHFDYWEvbURLbXVSOSt1aGgwQ2ZYZHpub3R1SVlweGpo?=
 =?utf-8?B?NGw3YTdBTEprTjlGcFdkWHIwTkFWUDl6N2VVcWg2YTFyVVhjZlBZaWw4UG1D?=
 =?utf-8?B?enZZT2o2MnBKWGlpbFZ6dkRSZWQ3SCs4cVRSNEpuVnlGanB5VWZKTjBONFNy?=
 =?utf-8?B?akxSTkZNZUVITXFNSXBTZkpJQVRnZjdJcnpkQlFmVW1aK3RlaEFENHplN1NJ?=
 =?utf-8?B?WTdQZXFPa1Flc2gvSy9QUFB6V3dBWkxYS3Z5NkVKNVd6TXBVY29iRlE1bjNY?=
 =?utf-8?B?cksxcjhScTdGeHJxdDcyOFZJQ0l3aXRZczJMdzRUazJ1VFNjZUZvbVpzV0hZ?=
 =?utf-8?B?RCtidHpvTC9QUnpBcDk0a2RUaWxrczV0R3JKZjNJd2E1cW81VEx6ZFprQk0y?=
 =?utf-8?B?YytxOXd2UFQvdHM1dEFNS2lFeDRQNWlYRnVFanN6WWhPUXgyR0tIVHY1c3J3?=
 =?utf-8?B?ODhES0h0cUNudXNPb2tGb1QzcUhKMWZmMGp3WUlYanl3K20vVithOFY0bi9v?=
 =?utf-8?B?L2hVcHNucVg1d0pWL3FzUVdQaDExV0o3R0R4TDBaQTNnYzJmNEZmNTRMUm01?=
 =?utf-8?B?ejRkcFkwOVFObWFFd0xLQmdBcHZYNlNXS2ZycjNTQnBKamdOMGtyczJ2UVE5?=
 =?utf-8?B?WFFtbi9FVzE2QUZETis2QzR2dmJGRm5FbGtLL3NtM1BXYjJ0clQzaHVmVTdk?=
 =?utf-8?B?R2ZXbHZJV0QyUHRwOEpYS1lTOVZ2aHpPa0xOdFc4OHBiazVjOFV1RGcyZ2k0?=
 =?utf-8?B?ZGdBSzBqNHFVSFlSZm9ZRHMwQ1lTL1k4SDJXODNONE5EQytsU3d0YXZLWmZm?=
 =?utf-8?B?d3prUTNIYkhQc2UwTXVHamxTeXB0dkJXNlFkVjVYNzVyMm9iMXNIRkRVcTMy?=
 =?utf-8?B?aDFnNEluR1FvNmpsLzg2VTVrM2p1TUR0RmRqZnB4K01Wa0xHejk1dDJwNDBQ?=
 =?utf-8?B?ZWVvbGhxbGUvbzNnQTFvaXpvcmp6U21ST2JwaDhNemdEZXo1YjRNNU5TeWlD?=
 =?utf-8?B?ZmVaQkwwbGxRa1VNQ0RhQXp0dmNJTFBINHFSdThTOUtkcFo4RFFpaGxYS2ZZ?=
 =?utf-8?B?QkpkajMxTittKzBHL2QweUFFUU1MMERSQVYzK0hjZ1ZCaG1GTmhaSCs3TmMy?=
 =?utf-8?B?bGlYckxQTytyUTFKL25UQURlUzI3RjVxbGdRUFQ0UjBQeW5mWGVKbXF6Rllq?=
 =?utf-8?B?MHFLV3QyMk9xRXpyZGhFTzlqVGRybjRvUGR6RHhGUG54K0Fha3J5MEg0MWlY?=
 =?utf-8?B?Mkl3U0FDenVrQmNRN1N2WlQ3dkdYV1dkVDMxd3N2dGxBRjZycmdqUU9WTy83?=
 =?utf-8?B?TmMzenlqRjdHbWR0WVNNKy9hS3FWZE1LSk92TWlMSXlLY093eHFDanhKSFRM?=
 =?utf-8?B?YnRjYmFOUzZWQjB2c0VPbHVrRzN6bXBGcUV4Rk1wSjBhanpTeWUvN0liMzl3?=
 =?utf-8?B?alY1OG5qSkZJUXlnWStvQWVqdTVkWGRheTBrbUlNUXhyWTZTdXRDUUZLUGQv?=
 =?utf-8?B?UDdJUVgyTmY3bW4yMWRaNUlqc2YwY0xuSXVIaVFZK0tEbk1hVzZ1MVgxSTI4?=
 =?utf-8?B?UTBEc08xZ3RTUFJiQm9zY0Zzbm93WDRrOXFoL25OU0FqakZOK2g5RUljUVda?=
 =?utf-8?Q?D8uF4FBrL3v8sMG/5YZbzWm5q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB3678CC81AA45469F99225C01CECC57@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+vwDk6rOiGN4Zx4R4o4+lnCED/e1qBF0CTF2memJbPIA7NUzSm/89yw5nQ9XA/RUeG/LwGlIA1fsBLhF7irH097HixTdtt4D9oBiiY0qqC2gjTrnN6/xaizK8sG+60W5q67FV7nbJ31pJlCeVZHoFb2fRSoBEK0EXx8svGWQsvUxaM5HamGpNnWhXh0zhGQXSMjPaOWr4zIAoEWb1xWWHqqnoRlHu6FdJVNCEOZzQaRcWRa4TkQ9Z7l9HmrAOR1Ox63OdDwgCk/BII0OUAIPvZJdM2j650qZILI/n5U8UQaS9FELPxrWXdeqXYX2M+Ou3U5vMPZ+5dOqdSOA565ad//15t5QfnojkvSGhc8yo9IeCo2KhmtA/TAMcQgR16FXNPI2/2qakYPGPhF3/4ADbkU6UL3kgeOjHEmCAPyVAUA7HNfbAdst/NVCwwRB7FZxR5FbA0P0XuCjNfqiRqqJCkkMjdbOvNEKTk9vBMnxbm3K2IAg7TGRGnmaBzY+3TFJafMjxV1er3iE7Dp6CKdvICqEgpsYR1A6PHIbSxSTzTC3DGzLLY97ZUbtsuKdRyUq297SDho6h4WqKvRQjrpYgGe+fZOnTfpomZRnHTjwLJ3TeEQ3NJlO6NDpgbjja4VtjLPRW7JU/sdBNfBVXa4QWQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d007ba75-9e91-4ff1-0f39-08ddf7c190b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 21:14:48.4809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRTgpBG8OAmgYfjwNir5rjNC3z9Yq7pnFQb7T9eS+UtYcy9d3/WjQQFg/0lhOUx+fWVBTI7AGE2juB/PgiUrfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
X-Proofpoint-GUID: st7end0xrPzvigsyWCm9vYlJXplFBPBn
X-Proofpoint-ORIG-GUID: st7end0xrPzvigsyWCm9vYlJXplFBPBn
X-Authority-Analysis: v=2.4 cv=NsbRc9dJ c=1 sm=1 tr=0 ts=68cdc7ce cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=h4SL0BZ7AAAA:8 a=pPZvZw4OAHAizGLbyzoA:9 a=QEXdDO2ut3YA:10
 a=Cfupvnr7wbb3QRzVG_cV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2wAl3MwUvkCC
 B/XVX9ooFYlX1+ByPjjH0HMCspYW2PJWOmNFtpR+gS7RDiN7/u52cS9fpjsDZOVh0yD5qwTebdt
 bjI8fxHJCm8hVwct7U8nlTLqGbHsJu08NCDwdlporl3918wc0nL0IVHLjdax201ElBbe+e/myLk
 pD1UjDyVgd7KBIXbHoB8zcu+Hzm6ufChWf+XQc87cVtfO5Ujfymxo4cHc0YvtNKrjjsflGILQZX
 63sE6smxUmWeHjM5JaZfyqp1Kh59IpclJcDc7vdgUU3W5ELVfLZqtzbF7cghnhKcoC+j3ZrWKfH
 06srUU5T+tljenRgVzOHPVFN3JKVk6N5yz7TnyIF1DNTmd4Oy0Djhs4kNuj1LBHveMr/3FsCZkE
 Ivxi2yef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 bulkscore=0 adultscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509160202

T24gTW9uLCBTZXAgMTUsIDIwMjUsIGNhb2hhbmdAZXN3aW5jb21wdXRpbmcuY29tIHdyb3RlOg0K
PiBGcm9tOiBIYW5nIENhbyA8Y2FvaGFuZ0Blc3dpbmNvbXB1dGluZy5jb20+DQo+IA0KPiBBZGQg
dGhlIEVJQzc3MDAgdXNiIGRyaXZlciwgd2hpY2ggaXMgcmVzcG9uc2libGUgZm9yDQo+IGlkZW50
aWZ5aW5nLGNvbmZpZ3VyaW5nIGFuZCBjb25uZWN0aW5nIHVzYiBkZXZpY2VzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogU2VuY2h1YW4gWmhhbmcgPHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5nIENhbyA8Y2FvaGFuZ0Blc3dpbmNvbXB1dGluZy5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9LY29uZmlnICAgICAgICB8ICAxMSArKw0K
PiAgZHJpdmVycy91c2IvZHdjMy9NYWtlZmlsZSAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtZWljNzcwMC5jIHwgMjYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI3MyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy91c2IvZHdjMy9kd2MzLWVpYzc3MDAuYw0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvS2NvbmZpZyBiL2RyaXZlcnMvdXNiL2R3YzMvS2NvbmZpZw0K
PiBpbmRleCAzMTBkMTgyZTEwYjUuLjJhZTE4MTc5ODdkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvS2NvbmZpZw0KPiBA
QCAtMTg5LDQgKzE4OSwxNSBAQCBjb25maWcgVVNCX0RXQzNfUlRLDQo+ICAJICBvciBkdWFsLXJv
bGUgbW9kZS4NCj4gIAkgIFNheSAnWScgb3IgJ00nIGlmIHlvdSBoYXZlIHN1Y2ggZGV2aWNlLg0K
PiAgDQo+ICtjb25maWcgVVNCX0RXQzNfRUlDNzcwMA0KPiArCXRyaXN0YXRlICJFc3dpbiBQbGF0
Zm9ybXMiDQo+ICsJZGVwZW5kcyBvbiBBUkNIX0VTV0lOIHx8IENPTVBJTEVfVEVTVA0KPiArCWRl
ZmF1bHQgVVNCX0RXQzMNCj4gKwlkZXBlbmRzIG9uIE9GDQo+ICsJaGVscA0KPiArCSAgVGhlIHVz
YiBjb250cm9sbGVyIG9uIGVpYzc3MDAgU29DLg0KPiArCSAgc3VwcG9ydCBvZiBVU0IyLzMgZnVu
Y3Rpb25hbGl0eQ0KPiArCSAgaW4gRXN3aW4gcGxhdGZvcm1zLg0KPiArCSAgc2F5ICdZJyBvciAn
TScgaWYgeW91IGhhdmUgb25lIHN1Y2ggZGV2aWNlLg0KPiArDQo+ICBlbmRpZg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9NYWtlZmlsZSBiL2RyaXZlcnMvdXNiL2R3YzMvTWFrZWZp
bGUNCj4gaW5kZXggODMwZTZjOWU1ZmUwLi4wNWY1ODIxMDNmOGIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9NYWtlZmls
ZQ0KPiBAQCAtNTcsMyArNTcsNCBAQCBvYmotJChDT05GSUdfVVNCX0RXQzNfSU1YOE1QKQkJKz0g
ZHdjMy1pbXg4bXAubw0KPiAgb2JqLSQoQ09ORklHX1VTQl9EV0MzX1hJTElOWCkJCSs9IGR3YzMt
eGlsaW54Lm8NCj4gIG9iai0kKENPTkZJR19VU0JfRFdDM19PQ1RFT04pCQkrPSBkd2MzLW9jdGVv
bi5vDQo+ICBvYmotJChDT05GSUdfVVNCX0RXQzNfUlRLKQkJKz0gZHdjMy1ydGsubw0KPiArb2Jq
LSQoQ09ORklHX1VTQl9EV0MzX0VJQzc3MDApCQkrPSBkd2MzLWVpYzc3MDAubw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWVpYzc3MDAuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1laWM3NzAwLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAw
MDAwLi43ZDNkMDUxZmQwYmINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtZWljNzcwMC5jDQo+IEBAIC0wLDAgKzEsMjYxIEBADQo+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAqIEVTV0lOIFNwZWNpZmljIEdsdWUg
bGF5ZXINCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgMjAyNSwgQmVpamluZyBFU1dJTiBDb21wdXRp
bmcgVGVjaG5vbG9neSBDby4sIEx0ZC4NCj4gKyAqDQo+ICsgKiBBdXRob3JzOiBXZWkgWWFuZyA8
eWFuZ3dlaTFAZXN3aW5jb21wdXRpbmcuY29tPg0KPiArICogICAgICAgICAgU2VuY2h1YW4gWmhh
bmcgPHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tPg0KPiArICogICAgICAgICAgSGFu
ZyBDYW8gPGNhb2hhbmdAZXN3aW5jb21wdXRpbmcuY29tPg0KPiArICovDQo+ICsNCj4gKyNpbmNs
dWRlIDxsaW51eC9jbGsuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gKyNp
bmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L3Jlc2V0Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvdXNiLmg+DQo+ICsNCj4gKyNpbmNsdWRl
ICJnbHVlLmgiDQo+ICsNCj4gKyNkZWZpbmUgSFNQX1VTQl9WQlVTX0ZTRUwJCTB4MmENCj4gKyNk
ZWZpbmUgSFNQX1VTQl9NUExMX0RFRkFVTFQJCTB4MA0KPiArDQo+ICsjZGVmaW5lIEhTUF9VU0Jf
QlVTX0ZJTFRFUl9FTgkJQklUKDApDQo+ICsjZGVmaW5lIEhTUF9VU0JfQlVTX0NMS0VOX0dNCQlC
SVQoOSkNCj4gKyNkZWZpbmUgSFNQX1VTQl9CVVNfQ0xLRU5fR1MJCUJJVCgxNikNCj4gKyNkZWZp
bmUgSFNQX1VTQl9CVVNfU1dfUlNUCQlCSVQoMjQpDQo+ICsjZGVmaW5lIEhTUF9VU0JfQlVTX0NM
S19FTgkJQklUKDI4KQ0KPiArDQo+ICsjZGVmaW5lIEhTUF9VU0JfQVhJX0xQX1hNX0NTWVNSRVEJ
QklUKDApDQo+ICsjZGVmaW5lIEhTUF9VU0JfQVhJX0xQX1hTX0NTWVNSRVEJQklUKDE2KQ0KPiAr
DQo+ICtzdHJ1Y3QgZHdjM19lc3dpbiB7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2Ow0KPiArCXN0
cnVjdCBkd2MzIGR3YzsNCj4gKwlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSAqY2xrczsNCj4gKwlpbnQg
bnVtX2Nsa3M7DQo+ICsJc3RydWN0IHJlc2V0X2NvbnRyb2wgKnZhdXhfcnN0Ow0KPiArfTsNCj4g
Kw0KPiArI2RlZmluZSB0b19kd2MzX2Vzd2luKGQpIGNvbnRhaW5lcl9vZigoZCksIHN0cnVjdCBk
d2MzX2Vzd2luLCBkd2MpDQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjX3VzYl9jbGtfaW5pdChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IHJlZ21hcCAqcmVnbWFwOw0KPiArCXUz
MiBoc3BfdXNiX3ZidXNfZnJlcTsNCj4gKwl1MzIgaHNwX3VzYl9heGlfbHA7DQo+ICsJdTMyIGhz
cF91c2JfYnVzOw0KPiArCXUzMiBoc3BfdXNiX21wbGw7DQo+ICsJdTMyIGFyZ3NbNF07DQo+ICsN
Cj4gKwlyZWdtYXAgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlX2FyZ3MoZGV2LT5v
Zl9ub2RlLA0KPiArCQkJCQkJICAgICAgImVzd2luLGhzcC1zcC1jc3IiLA0KPiArCQkJCQkJICAg
ICAgQVJSQVlfU0laRShhcmdzKSwgYXJncyk7DQo+ICsJaWYgKElTX0VSUihyZWdtYXApKSB7DQo+
ICsJCWRldl9lcnIoZGV2LCAiTm8gaHNwLXNwLWNzciBwaGFuZGxlIHNwZWNpZmllZFxuIik7DQo+
ICsJCXJldHVybiBQVFJfRVJSKHJlZ21hcCk7DQo+ICsJfQ0KPiArDQo+ICsJaHNwX3VzYl9idXMg
ICAgICAgPSBhcmdzWzBdOw0KPiArCWhzcF91c2JfYXhpX2xwICAgID0gYXJnc1sxXTsNCj4gKwlo
c3BfdXNiX3ZidXNfZnJlcSA9IGFyZ3NbMl07DQo+ICsJaHNwX3VzYl9tcGxsICAgICAgPSBhcmdz
WzNdOw0KPiArDQo+ICsJLyoNCj4gKwkgKiB1c2IgY2xvY2sgaW5pdCxyZWYgY2xvY2sgaXMgMjRN
IGJlbG93IG5lZWQgdG8gYmUgc2V0IHRvIHNhdGlzZnkgdXNiDQo+ICsJICogcGh5IHJlcXVpcmVt
ZW50KDEyNU0pDQo+ICsJICovDQo+ICsJcmVnbWFwX3dyaXRlKHJlZ21hcCwgaHNwX3VzYl92YnVz
X2ZyZXEsIEhTUF9VU0JfVkJVU19GU0VMKTsNCj4gKwlyZWdtYXBfd3JpdGUocmVnbWFwLCBoc3Bf
dXNiX21wbGwsIEhTUF9VU0JfTVBMTF9ERUZBVUxUKTsNCj4gKw0KPiArCS8qIHJlc2V0IHVzYiBj
b3JlIGFuZCB1c2IgcGh5ICovDQo+ICsJcmVnbWFwX3dyaXRlKHJlZ21hcCwgaHNwX3VzYl9idXMs
IEhTUF9VU0JfQlVTX0ZJTFRFUl9FTiB8DQo+ICsJCSAgICAgSFNQX1VTQl9CVVNfQ0xLRU5fR00g
fCBIU1BfVVNCX0JVU19DTEtFTl9HUyB8DQo+ICsJCSAgICAgSFNQX1VTQl9CVVNfU1dfUlNUIHwg
SFNQX1VTQl9CVVNfQ0xLX0VOKTsNCj4gKwlyZWdtYXBfd3JpdGUocmVnbWFwLCBoc3BfdXNiX2F4
aV9scCwgSFNQX1VTQl9BWElfTFBfWE1fQ1NZU1JFUSB8DQo+ICsJCSAgICAgSFNQX1VTQl9BWElf
TFBfWFNfQ1NZU1JFUSk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGludCBkd2MzX2Vzd2luX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICt7
DQo+ICsJc3RydWN0IGR3YzNfcHJvYmVfZGF0YSBwcm9iZV9kYXRhID0ge307DQo+ICsJc3RydWN0
IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gKwlzdHJ1Y3QgZHdjM19lc3dpbiAqZXN3aW47
DQo+ICsJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWVzd2lu
ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCplc3dpbiksIEdGUF9LRVJORUwpOw0KPiArCWlm
ICghZXN3aW4pDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJZXN3aW4tPmRldiA9IGRl
djsNCj4gKwllc3dpbi0+bnVtX2Nsa3MgPSBkZXZtX2Nsa19idWxrX2dldF9hbGxfZW5hYmxlZChk
ZXYsICZlc3dpbi0+Y2xrcyk7DQo+ICsJaWYgKGVzd2luLT5udW1fY2xrcyA8IDApDQo+ICsJCXJl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgZXN3aW4tPm51bV9jbGtzLA0KPiArCQkJIkZhaWxlZCB0
byBnZXQgdXNiIGNsb2Nrc1xuIik7DQo+ICsNCj4gKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiArCWlmICghcmVzKQ0KPiArCQlyZXR1cm4g
ZGV2X2Vycl9wcm9iZShkZXYsIC1FTk9ERVYsDQo+ICsJCQkiTWlzc2luZyBtZW1vcnkgcmVzb3Vy
Y2VcbiIpOw0KPiArDQo+ICsJZXN3aW4tPnZhdXhfcnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dl
dChkZXYsICJ2YXV4Iik7DQo+ICsJaWYgKElTX0VSUihlc3dpbi0+dmF1eF9yc3QpKQ0KPiArCQly
ZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoZXN3aW4tPnZhdXhfcnN0KSwNCj4gKwkJ
IkZhaWxlZCB0byBnZXQgdmF1eCByZXNldFxuIik7DQo+ICsNCj4gKwlyZXQgPSByZXNldF9jb250
cm9sX2RlYXNzZXJ0KGVzd2luLT52YXV4X3JzdCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJu
IGRldl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+ICsJCQkiRmFpbGVkIHRvIGRlYXNzZXJ0IHJlc2V0
XG4iKTsNCj4gKw0KPiArCXJldCA9IGR3Y191c2JfY2xrX2luaXQoZGV2KTsNCj4gKwlpZiAocmV0
KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGNsayBpbml0OiAlZFxuIiwgcmV0KTsN
Cj4gKwkJZ290byByZXNldF9hc3NlcnQ7DQo+ICsJfQ0KPiArDQo+ICsJZXN3aW4tPmR3Yy5kZXYg
PSBkZXY7DQo+ICsJcHJvYmVfZGF0YS5kd2MgPSAmZXN3aW4tPmR3YzsNCj4gKwlwcm9iZV9kYXRh
LnJlcyA9IHJlczsNCj4gKwlwcm9iZV9kYXRhLmlnbm9yZV9jbG9ja3NfYW5kX3Jlc2V0cyA9IHRy
dWU7DQo+ICsJcmV0ID0gZHdjM19jb3JlX3Byb2JlKCZwcm9iZV9kYXRhKTsNCj4gKwlpZiAocmV0
KSB7DQo+ICsJCXJldCA9IGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8gcmVnaXN0
ZXIgRFdDMyBDb3JlXG4iKTsNCj4gKwkJZ290byByZXNldF9hc3NlcnQ7DQo+ICsJfQ0KPiArDQo+
ICsJcmV0dXJuIDA7DQo+ICsNCj4gK3Jlc2V0X2Fzc2VydDoNCj4gKwlyZXNldF9jb250cm9sX2Fz
c2VydChlc3dpbi0+dmF1eF9yc3QpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0K
PiArc3RhdGljIHZvaWQgZHdjM19lc3dpbl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjMyAqZHdjID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEo
cGRldik7DQo+ICsJc3RydWN0IGR3YzNfZXN3aW4gKmVzd2luID0gdG9fZHdjM19lc3dpbihkd2Mp
Ow0KPiArDQo+ICsJZHdjM19jb3JlX3JlbW92ZSgmZXN3aW4tPmR3Yyk7DQo+ICsNCj4gKwlyZXNl
dF9jb250cm9sX2Fzc2VydChlc3dpbi0+dmF1eF9yc3QpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMg
dm9pZCBkd2MzX2Vzd2luX2NvbXBsZXRlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlz
dHJ1Y3QgZHdjMyAqZHdjID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwlkd2MzX3Bt
X2NvbXBsZXRlKGR3Yyk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjM19lc3dpbl9wcmVw
YXJlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjMyAqZHdjID0gZGV2
X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwlyZXR1cm4gZHdjM19wbV9wcmVwYXJlKGR3Yyk7
DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjM19lc3dpbl9wbV9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjMyAqZHdjID0gZGV2X2dldF9kcnZkYXRh
KGRldik7DQo+ICsJc3RydWN0IGR3YzNfZXN3aW4gKmVzd2luID0gdG9fZHdjM19lc3dpbihkd2Mp
Ow0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlyZXQgPSBkd2MzX3BtX3N1c3BlbmQoJmVzd2luLT5k
d2MpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwljbGtfYnVsa19k
aXNhYmxlX3VucHJlcGFyZShlc3dpbi0+bnVtX2Nsa3MsIGVzd2luLT5jbGtzKTsNCj4gKw0KPiAr
CXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGR3YzNfZXN3aW5fcG1fcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjMyAqZHdjID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+ICsJc3RydWN0IGR3YzNfZXN3aW4gKmVzd2luID0gdG9fZHdjM19l
c3dpbihkd2MpOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlyZXQgPSBjbGtfYnVsa19wcmVwYXJl
X2VuYWJsZShlc3dpbi0+bnVtX2Nsa3MsIGVzd2luLT5jbGtzKTsNCj4gKwlpZiAocmV0KSB7DQo+
ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbG9ja3M6ICVkXG4iLCByZXQpOw0K
PiArCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiArCXJldHVybiBkd2MzX3BtX3Jlc3VtZSgm
ZXN3aW4tPmR3Yyk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjM19lc3dpbl9ydW50aW1l
X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBkd2MzICpkd2Mg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwlzdHJ1Y3QgZHdjM19lc3dpbiAqZXN3aW4gPSB0
b19kd2MzX2Vzd2luKGR3Yyk7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IGR3YzNfcnVu
dGltZV9zdXNwZW5kKCZlc3dpbi0+ZHdjKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0
Ow0KPiArDQo+ICsJY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUoZXN3aW4tPm51bV9jbGtzLCBl
c3dpbi0+Y2xrcyk7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdj
M19lc3dpbl9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJc3Ry
dWN0IGR3YzMgKmR3YyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXN0cnVjdCBkd2MzX2Vz
d2luICplc3dpbiA9IHRvX2R3YzNfZXN3aW4oZHdjKTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJ
cmV0ID0gY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoZXN3aW4tPm51bV9jbGtzLCBlc3dpbi0+Y2xr
cyk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBlbmFibGUg
Y2xvY2tzOiAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwly
ZXR1cm4gZHdjM19ydW50aW1lX3Jlc3VtZSgmZXN3aW4tPmR3Yyk7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBpbnQgZHdjM19lc3dpbl9ydW50aW1lX2lkbGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAr
ew0KPiArCXJldHVybiBkd2MzX3J1bnRpbWVfaWRsZShkZXZfZ2V0X2RydmRhdGEoZGV2KSk7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2MzX2Vzd2luX2Rl
dl9wbV9vcHMgPSB7DQo+ICsJU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoZHdjM19lc3dpbl9wbV9z
dXNwZW5kLCBkd2MzX2Vzd2luX3BtX3Jlc3VtZSkNCj4gKwlTRVRfUlVOVElNRV9QTV9PUFMoZHdj
M19lc3dpbl9ydW50aW1lX3N1c3BlbmQsDQo+ICsJCQkgICBkd2MzX2Vzd2luX3J1bnRpbWVfcmVz
dW1lLCBkd2MzX2Vzd2luX3J1bnRpbWVfaWRsZSkNCj4gKwkuY29tcGxldGUgPSBwbV9zbGVlcF9w
dHIoZHdjM19lc3dpbl9jb21wbGV0ZSksDQo+ICsJLnByZXBhcmUgPSBwbV9zbGVlcF9wdHIoZHdj
M19lc3dpbl9wcmVwYXJlKSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGVzd2luX2R3YzNfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gImVz
d2luLGVpYzc3MDAtZHdjMyIgfSwNCj4gKwl7fSwNCj4gK307DQo+ICsNCj4gK01PRFVMRV9ERVZJ
Q0VfVEFCTEUob2YsIGVzd2luX2R3YzNfbWF0Y2gpOw0KPiArDQo+ICtzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBkd2MzX2Vzd2luX2RyaXZlciA9IHsNCj4gKwkucHJvYmUgPSBkd2MzX2Vz
d2luX3Byb2JlLA0KPiArCS5yZW1vdmUgPSBkd2MzX2Vzd2luX3JlbW92ZSwNCj4gKwkuZHJpdmVy
ID0gew0KPiArCQkubmFtZSA9ICJlaWM3NzAwLWR3YzMiLA0KPiArCQkucG0JPSBwbV9wdHIoJmR3
YzNfZXN3aW5fZGV2X3BtX29wcyksDQo+ICsJCS5vZl9tYXRjaF90YWJsZSA9IGVzd2luX2R3YzNf
bWF0Y2gsDQo+ICsJfSwNCj4gK307DQo+ICsNCj4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoZHdj
M19lc3dpbl9kcml2ZXIpOw0KPiArDQo+ICtNT0RVTEVfQVVUSE9SKCJXZWkgWWFuZyA8eWFuZ3dl
aTFAZXN3aW5jb21wdXRpbmcuY29tIik7DQo+ICtNT0RVTEVfQVVUSE9SKCJTZW5jaHVhbiBaaGFu
ZyA8emhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20iKTsNCj4gK01PRFVMRV9BVVRIT1Io
IkhhbmcgQ2FvIDxjYW9oYW5nQGVzd2luY29tcHV0aW5nLmNvbSIpOw0KPiArTU9EVUxFX0xJQ0VO
U0UoIkdQTCIpOw0KPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJEZXNpZ25XYXJlIFVTQjMgRVNXSU4g
R2x1ZSBMYXllciIpOw0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpDYW4geW91IGxvb2sgaW50byBk
d2MzX2dlbmVyaWNfcGxhdFsxXSBhbmQgc2VlIGlmIHlvdSBjYW4gZW5oYW5jZSBpdCB0bw0Kc3Vw
cG9ydCB5b3VyIHBsYXRmb3JtPyBHcmVnIGhhcyBhbHJlYWR5IHBpY2tlZCB1cCB0aG9zZSBjaGFu
Z2VzWzJdLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjUwOTEz
LWR3YzNfZ2VuZXJpYy12OC0wLWI1MGY4MWYwNWY5NUBsaW51eC5kZXYvDQoNClsyXSBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ncmVna2gvdXNiLmdpdC9j
b21taXQvP2g9dXNiLW5leHQmaWQ9ZTBiNmRjMDBjNzAxZTYwMGU2NTU0MTdhYWIxZTEwMGI3M2Rl
ODIxYQ0KDQpUaGFua3MsDQpUaGluaA==

