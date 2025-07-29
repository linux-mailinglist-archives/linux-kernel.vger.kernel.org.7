Return-Path: <linux-kernel+bounces-749966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED000B15572
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DED544467
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B126284B57;
	Tue, 29 Jul 2025 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RVDRgmW5";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L09hBH4v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="odHv7EIH"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B51F4606;
	Tue, 29 Jul 2025 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829494; cv=fail; b=lYOXCr/rbtXuwKsNJMjklPD1W3q59WxOwlxyWinTBIAbgY9/x07lddNea7GfZPxQXeKx8ymH97+abOZA8r9NJonpuFZUihcdcrmdrLplVVzp6YqnMmtC7HQE1kFj2OxMts6wb9lBbBPeLTmkri/1ld6Ambm73Yzwf7/ax1QeHr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829494; c=relaxed/simple;
	bh=18L174S2Eg4cjSF+iKkxCOTjVt5kdHXAstSCeuwcHvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DnGhvUOdLgwWQ70b7/5DqNbWVRCuRX/bzhp28Umv33E8PAJaEq8ncUtSI06XZr7gUJeTBcgz4SEKFDLMESIc5h2nYEP8W6g0PFYt8wtUL6Pklm0y60sEUQhiQmpJOBg4Te231kE/clGKQoByUocafMZQyhSRO7fT0nET5meIJ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RVDRgmW5; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L09hBH4v; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=odHv7EIH reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TGPXoq027306;
	Tue, 29 Jul 2025 15:10:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=18L174S2Eg4cjSF+iKkxCOTjVt5kdHXAstSCeuwcHvM=; b=
	RVDRgmW577VwmFk3oFlYpsGEMKhyySit+cIDKnXGfUs8pi4w49CTHq3A92cPNLim
	pYxeLPVEsGdDuljO40oPHYrspf+YQkvl0ILUWICVDSdVk4CVyvXNAtRhtaTYFzRT
	rNruOrEnB3DgpBAaUt6jTO2GB6IMw5ciq8HuG7x55LsD1L9749yiISpQe/k4ZWRX
	QzUydEsh7Xv+QfHJT5gmzF36FS0c9ygM2RthUQFIBUzrofe9K9n0gYhTD4QE6RAp
	4WnmOIrPN3uhz8cQ1F3jRFUwx/LF8Vt4/fO05cNCWYJeiIW+Pkmyfp0Y1ZLQ2Ap0
	3pRnbtCUEATmgrz2HJDXcA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 486wbfjwun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1753827047; bh=18L174S2Eg4cjSF+iKkxCOTjVt5kdHXAstSCeuwcHvM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=L09hBH4vi00rm+wIPgVaxLz5SuHFobMack5z8W6b5P+kcPknZ4llaC+IL8jJ+4CWD
	 ZVdTEpwNsHyC3t/v6V3oGELXg/veEP8SOGOaOcdeLCeh/usZ6Oq31dSgQUiwMLGBEq
	 82TiCV0Ipc7OqXm6NyH26HVCa6ZZgqGSraLqKde/88cog8ATnBlvOtrFrzQwByhI1T
	 daBXSFJU1Z6GcMi3gSorZJIcShwVDw8TrIQ+xKrhkrAqcdcVaHKwTTXrXKSJ4aBwFl
	 mOtQkWs5GWz1b5u/2MqOmRxQ5yDNoZpzUsEx7Y6CUQV329bOYGLvWyKvGtYmbCXwOT
	 SKfHlcqleWYOw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9F32240347;
	Tue, 29 Jul 2025 22:10:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 22597A0068;
	Tue, 29 Jul 2025 22:10:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=odHv7EIH;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 445FA40526;
	Tue, 29 Jul 2025 22:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfjPhtmRKR7ktsDLHDJ29EYPjkJn6qh3w39C2LkQnpy8yx44wPK0HMbrIPaxSxeJdu+DzgPLPXtuoDzv6mD0b+h9ZoY3zuCeUvrjS/qgNSxyJdWJedozlphyLGqvGKSZzD3G5DtQQ4MxVzfx4OWlCwjkApoffLgvjGg8HmgU8PjuyjXJiEflcuXJEBL+C7wCZjw2bop8D8q3DWvrGd736de8HU2YbwlTTfm2/bKJbsNpd3O9DdaHZeuHZ6qo2Cf5cws300k4bqj+MyjuIATftqcd+RV0RZqw5CEnRDmbdor4GlzlMDbyUevESlAy2VtIXvdLDjiuho8T3/mk8bcF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18L174S2Eg4cjSF+iKkxCOTjVt5kdHXAstSCeuwcHvM=;
 b=KchU6ulDZlUs5yGafgiuIJ1cU0U7tkeb+/NgqINF4N+XhSQXIUWFCRHF02x3p3YKbI7otqfd24ozeOmHFf8YmwWZ8sh0BuZx4LR/rf+6vS6ZavXHS+mJrRmjNsY2X53V2VbOZzs6WBaCMvbmM4wehBbv8LjXOezlVAQjr01hwxmzz1AXx32D3/xhtm8IIg6CCQZge+XUasvyFkNpHRWbWptbpLQtYEdAblDLNZvLC8sSSJ4X8rTw/37E3o220ZwpfJw5UjQWpn7+Q7n2RYrAldnUvtmWmu5TCyQpN73fEregFa3ZxqOkYVE64/MPjtTDmmEZHeUJLnK8U0b35ls9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18L174S2Eg4cjSF+iKkxCOTjVt5kdHXAstSCeuwcHvM=;
 b=odHv7EIH6QL71Rb6D7D9cIdIrIkLwxpNi2mPYlk3eBIqLBsFBmtspHigQIrK5gmIXaL/nzL8fX6NMivTyY+CvDmmpVBf4qFBtzDUpT+0aCmCKos9V6TY11aW60KVQdG5L528wkwzm+bB2sM5HMetzZYqUqcPgpn4GLSvuSR64sE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 22:10:36 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 22:10:35 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: John Keeping <jkeeping@inmusicbrands.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH 1/2] usb: dwc3: disable for USB_ROLE_NONE
Thread-Topic: [RFC/PATCH 1/2] usb: dwc3: disable for USB_ROLE_NONE
Thread-Index: AQHb8a6RTP30Xr6qbkW6FXojJLTBNbQtn6yAgAQhPgCAGAbmgA==
Date: Tue, 29 Jul 2025 22:10:35 +0000
Message-ID: <20250729221027.jvg3bpqhc3z5j7xn@synopsys.com>
References: <20250710152252.2532020-1-jkeeping@inmusicbrands.com>
 <20250710152252.2532020-2-jkeeping@inmusicbrands.com>
 <20250712001131.ax3rw24h3deekxfv@synopsys.com>
 <aHUfFGnGZP4z7UgK-jkeeping@inmusicbrands.com>
In-Reply-To: <aHUfFGnGZP4z7UgK-jkeeping@inmusicbrands.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN6PR12MB8568:EE_
x-ms-office365-filtering-correlation-id: 5ebfc9ed-1bac-4681-4542-08ddceecbe5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTNBajJNcHlya2FpYVlicHVyNkxKaFQrNkY0TUhBMm0rM3ZXZGJIMEQ3OXly?=
 =?utf-8?B?N1UzbmZhLzFtdG01NUFRMzZvVnFGQjFURFlHUEFibTIwZkVtS05kTmVxMXVC?=
 =?utf-8?B?TmxXZERQeDBBZmJpNTJrckZYZDhlQ2ZqS1QrODVaSmgvWHV2aHdJUU9aR0E5?=
 =?utf-8?B?SzVZZmw5a3FNbENPVWVSRmlrWlMveHJWZFRKb0dBSU9BWXpiSlFZNDlnR0NO?=
 =?utf-8?B?MnAwZmpkMUlQQk1sQzc2V0NWTlRxaXNNTkJYVnZvVndCWnpZcW51M3pESm0w?=
 =?utf-8?B?czJGbU52SW1HakR3bzY1ZDJkZ2VoYlJJZzI2REp2R1daWnVjYWFNQnhiQW9U?=
 =?utf-8?B?Vm9YRXhhNUNmVE1mTTBvblY4MEVHK1ZzVysxL2o4SlhleFRydUR5RUM5S1pW?=
 =?utf-8?B?b1NZckZuTVluZUg2WklHdi9PbVpud0tIdE9kZ1VjRnovTnA4dXRqZXZJN3hU?=
 =?utf-8?B?aGdkbzU1YTAvaVJPRHdPczZuMXY4MmxOK0UycHoreUZNNHFWd1pDOFpuaWpu?=
 =?utf-8?B?ZUhOY1kzZjhYRE1TU0JRNlZ0Y3R5RUlsUE54MFhhQUw4eVRYSlpYWE9YRGEy?=
 =?utf-8?B?ZDNkZkR3OWNxemg4aUZmenRvL0JXbys1eHJNWDB4bk00cWVlazRDdkJyRXhK?=
 =?utf-8?B?Y2dWamRJWVZEd2MzSmsza2o4STd1WmRkN0x2UHlKMTFPeEEyOTJ3SVVOVnpH?=
 =?utf-8?B?VHBZWTIweU9qVDhPZWI5ZWpZQVM1eVk2MXBScWRDSjhyWVZVRERQdjZ0VXdy?=
 =?utf-8?B?VUQvWEMyQU5IbFJ5dkdSZVcvQTRUM3hWbVJEaHBSdlM4S2twazI3NFZYTm50?=
 =?utf-8?B?NXV3VWF2L00vOTMrbFFsUmI2K1NBM05aS09sQ0RMYjRmRjB0dUlMMjg2V3lx?=
 =?utf-8?B?eDVKbmdVdEdJZk5uS01RUTh6cnFQS3Y3K3R2ZFFOTFg4bUR5OHp6K1d3cWox?=
 =?utf-8?B?b2RoTVN4emVJRUJxcXdDcUY4MFRRcEVwaStxUkZTQnpvQmw0MXVSYXpWN1h1?=
 =?utf-8?B?YjZYMVU0d2QxS1pyeGdqdS9WN1c2N1ZqelhJOWhLNWo2M1VDbXJaakp5VU8y?=
 =?utf-8?B?MnVFdnkxRnJMWFFCZTVKUXE3eTBKSU1TSFRvenVuRVdpUzQ4SzJMNkhoZmc5?=
 =?utf-8?B?SjdicDNYWjdIUmthNXZ2QldHeHowdi9oYTlHdHhQOU1iV1RyWFdSZ1lDTUNL?=
 =?utf-8?B?SWxTZjBiMFJneGYxdmNwK2taUkRjSWxmcUVKR1FKeXBvdys2TzdDUFJXSkow?=
 =?utf-8?B?bGN0STZjdklyZkp1OUdtdkZoTmFsR1RrT0pGOWk2azl0dzV5UkZuekgvTU9I?=
 =?utf-8?B?d1VGeEgxTjM4ekxnbnVLR3ZwZnU2cklCUnA2eTVCZnVONDZBR2ZEaXhaL3A2?=
 =?utf-8?B?K3p3bWord0pGRExTU0F4bnNPTjdLUmlCNmx4a2xnMEZ4bVVHTHZzZ293Ujhu?=
 =?utf-8?B?T29BNUtuQzNzeDdYemFkcjQ2Y09OcklicU9IaitwcXZrVkxtL0ZzMmU4cU1O?=
 =?utf-8?B?b3JUaFRsd0dWVlZNTEh1d0JVcERuMlUxZ28rRTZHa1JiTEtKRnZ2dzJZQ2hP?=
 =?utf-8?B?Q3hPdmFTcDZwbDFIcy9ORE9HNytPWU5QeFU0Y1J3Z0ptMmpGOHdWQ3BiWjB6?=
 =?utf-8?B?ZDE2MWhwZVBMQVZFVFcxS0YvNGtleGFqVTJwMGNiRHFkN2NwTWdTVjZ6OHVM?=
 =?utf-8?B?Y2JHSWYyNkpsZXF2TXhPeU12d3Nvb2pVakpsWjhpWlVtS1RocVlUTzZ1M29M?=
 =?utf-8?B?anpyMHV4Q1BhYVdGcWE0WUFhaW1oUkJKNVFsOTVhWnBTRFNmSE1PdHEraC9p?=
 =?utf-8?B?OGhxcjhDdUkzQUI3THZzS0R5VTJpUHQyUDVlZitZNm9YWnRndDNldFJ5Q2Jm?=
 =?utf-8?B?d01DTlN5UGtpZkIwSGJFaXp5ZVBFZWM1WHNlazBKd3Ntb2hzT1ZwWEN2TnZU?=
 =?utf-8?B?KzRvcDh6cVNrUGZaUE4xcWFaclpvRUVsTDR5c1N3VnNDTklyMDkwdm9FS0Ra?=
 =?utf-8?B?bzRvYzZteWJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1ppRmJQOU5Pamp1MHJaeU1Ec20xb1lwWU9wYUxkVnBEWERkaWNPMlFUSG1O?=
 =?utf-8?B?d1M5VXhJV0Rxdnc2YVY0T29BaWVNK2FqTThxeTZsazFJbEk5Zmw3Uzd1U3E5?=
 =?utf-8?B?dlBHdW1uNTlDSnhDL2JGSzRaa0VWUlNaY2k0L0UrUzgvQU5aNytGcExDcGw3?=
 =?utf-8?B?V21TNTNMOUppdGhJOTlBajl2cDlHTXRvYmdQTFpaUWdkYi95NER0RXJxUWV1?=
 =?utf-8?B?NDB0RU5mdXhwbmU4V3pPUktzak5NUjlzdEJCcXZBQVRndXZkbCtKUk52aWhx?=
 =?utf-8?B?U251T0RCRVNSUTM0bTM4aGg3dDZjT0hoU0MxMkplaFViKzJPa3VvaFFaMFJI?=
 =?utf-8?B?STFYclN1b21IQWlZY3luYm5lUmM1WFJCdFowOVY2L1ZZd1pQVEd0OHpkK2xQ?=
 =?utf-8?B?SitZUmlwS29lV2NEamMwMTAyOVBwcVRGNzgyZ0hHVjE3S1R0SWErNHZlQWxq?=
 =?utf-8?B?YUlBYnZ4OTQwSForY3NCOVpyK0haNk4vMXFjbDJGS2dja0tMeGRuaG5SUENw?=
 =?utf-8?B?UUtrVGtja0xBRVhtMnBnNndlQndlOUJpMjZIdTBiWXBid3NHM0xoT1BwTExq?=
 =?utf-8?B?VWJuUWxKa0tGMkJXUEQrZGVIVEd6RVcvNU5NZGpyekt6enRVMXJ6NngyVzlj?=
 =?utf-8?B?TnhFWXIyYithb2JNbjBEVXo4Sis5VTRxVHg5OGJFTHVYMEtTWG53cnAxcGY3?=
 =?utf-8?B?RmpwWnFaVkRScG8wdjVjeVBmUS9PWFlSOEJyeU9pZldwWjZzb1JLZzJWeGs1?=
 =?utf-8?B?L1o0SUNXU05kZU96QjdzdDU0RU5QdCt4Z09QTTdIUXVOOEljN05SMVhrT0ZB?=
 =?utf-8?B?QkdwTWZFRGlEb3BkUWFRT1YxY2V5ZUVkNkZ5dlFOczlGVXNkcFNBbUNJdzFv?=
 =?utf-8?B?L0ZkUk4vOVVwdnp6SndnRTh2SExOSi9ob1BmWldla01nNDkyS1VIaWtVeFh6?=
 =?utf-8?B?dVcyMlQrOFM0bVMvUlhIcjdYdTdsTlN0SlBMODNDK1NHQjhUQUhLdkJQZHBt?=
 =?utf-8?B?VlBzdU4yVm5hbDFyWEtLTEp3N0hmTkhiRjdjWmJ3SUFZZGh4V3pPVnMyS1Ry?=
 =?utf-8?B?b3U3QWpsSVA2dGtrSDhWc1phdFl6a0pQZElBZlRtdkxNT2lpQzJqSEFVNWdU?=
 =?utf-8?B?MitVSjZoUWhQaHBFRnZLaVJvVW5KUENSMTNKTFYxVWw4TUhIZmR2OHNsblZQ?=
 =?utf-8?B?MHBMSEVsekx1YUxwMzUvbVVIN1krNHBDQXBrcWM1SUdFMTJaVmZ5a1FJbWFO?=
 =?utf-8?B?VGJheEdQWTRoS2ZUT1FDSkVYOFZIY0Y0VkRiazRubEZrQzhsQS94LytHOERs?=
 =?utf-8?B?dVBkVVVJWHJqcUw1eFYwYzQ3a0NMdkhJL0VvMUtKWVZWMnpIWi9mcHBsSVdz?=
 =?utf-8?B?WWJvMndzRm5xczlUVE90NjNCVWhlZThyQXFMVXc1UW5qZk0rQWYwU2JHSjZV?=
 =?utf-8?B?SUYzUnNZVUw1d25GVjMwTzNKZjVzTGZHVGdNMmNIZ0xhNDJTYnNCeGRsMHRC?=
 =?utf-8?B?azFsSWZwdjlzeVE2OE80djI0VU1jTjIxQUFaTjdjcFFoSGZ0THlLeWNtb3E5?=
 =?utf-8?B?Q3hLSWtqdlEwZEF2Q1IrTFJzQlZJc3o1WXFNODVLRDNIc2FTMlFGNFQzVFl5?=
 =?utf-8?B?T2RXYUpyQk9zTElodmtneWZxbGc1SERJOEtVRlhyQ09RUTkzVHU1UnQyOHlL?=
 =?utf-8?B?SzQyNDJNbXVvcDNSNWxCOTh4NW11MHYwVTBFN0Jnd05PZ3owOGdaRmFzVzl0?=
 =?utf-8?B?ZnlsQndsQlJKdTMzTlpnd0RScVhyTDBNMUsyY3FQZmhtbkdQS1JuT2VTVVVK?=
 =?utf-8?B?bEVpdDh3azIrTGZzY1FJKzR2UU5lN01UaUFYUTdFMmNkU0poVGI0dXlqdy9V?=
 =?utf-8?B?UlR3Z1V1dlJ1MzI4YTE5VERxYnVGSnM3a25sZkhBZG43YUlpY05SNk9JaVlz?=
 =?utf-8?B?MUx5UGN1VXpZT1RTSE85ZDEvc0MyYmh3bXFsYVlPSXVvMDIvMWozbndwa3RY?=
 =?utf-8?B?T1drNGRqSGRXTXRuOGVQMTBMalRacjg5WVVRdFRONDRmb3I3VGFCQTQwSzcr?=
 =?utf-8?B?ZlF1ekNZOGk3TFdBOGdidjU1RUgzWTVTVmwxNVpJVGV6SDRaQVB1RkVKUkg5?=
 =?utf-8?Q?bjMlohBxLg8lHZ1hgALGrtFe2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3230A63D7164A4438BF902654BEC5E3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	obxaM9/l0LjajPhyzMJGn0L4rqI0whThX61aPAOlK2J3H2EguDFnd2LfvPo32GXV82Pd3tjd2sIte+qdyJ40ykQuQeq8RAp3Jmse/mLtVNCDmMbwZeh4tK/4Y1Ku489kBVzsBYrwEhmL1xtI2sV0c8jK/d/jrypoIOWJVixOMUQYhFKh2K0TUpjNF69RB0Edjqp93i0ArecAeHqJMe8ufNimgarKkJhXgRK5lVbCS0RA57bheBdHu3iQcYLH3d9kQ84PCK20ytE32XLlZXPXXodseF1BmHkKWAFNk07nDBlYcIX5R2cBIx5rdzi/JOZ/3m5nCA39hjQg3MiPK9ErCo3MQdWB1aVXUPxEl5fIzu6hZxju98SvCTh+7DKEiRiSpm/o8r6uzE3Qf/0v6lhNBAKP36OAsEfpQ/BIENnQcJgqCdo583nqRaA63tjpzEGBJs06IP5JRo2Wa3cDCEKspXahIRLnyjiLbKZGLwA5hdiXFe+zzYHYrfPDqAEfT9yq6UmAG92ZOlIIudSGaNOLZ7P0/ZhDff04w4k91E1ghc6TGYbMsOCTRqL3ftNahh6hbBCW23eE7d4MJywwuvcnRWg5oA/iKEbRPXTt3mYYzOb7ULYkdcj0SVfLGscRD2KPnp2ZRt2TZbqYCZEO+qrM9w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebfc9ed-1bac-4681-4542-08ddceecbe5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 22:10:35.7447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdnTrNUvAhNP0rE8Ot0S4WiZH4tnjyMteZ4DoNHoMErIAFF83EKxqppM7uwyaN+pTaGDS3rvGPYZShhcN+s61A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
X-Authority-Analysis: v=2.4 cv=JrfxrN4C c=1 sm=1 tr=0 ts=688946e8 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=qPHU084jO2kA:10
 a=oClPffFv5t4VLOMCPmEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qHq2O0w_uDMpMpYZbIEUwe4IOUPY0AXN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4NyBTYWx0ZWRfX/W3JxtXHT8pZ
 LVa3jXKhpWfEae+ACkt8xlhBw+iTYwWkootJE8/+e5CMTBN5WJ7oEpCyyVjCE6+984e8fOg0L7h
 EJ9LH1TwmGmIbEaSvN45bIV9MxE93TUI/4yRHKm/vTAcLGNQyo8VcmuOXGVdOvkMogpZ1XduTCH
 bGV+kh84R9ixpxHbe21sDfR9NDaBXDIf1sdBY9mOwV9FzDqSXeWlW7V5zNxOCbL07VFSSK6Yzre
 v2QNskVwXVLUaEFrIrxnP1qwED8OwXZPNn5iSO1ka+UcV764aBGm+ZRUCUKQN0ASVPVDkoVmytR
 nGDJ9Vhth/hYqDDKkH6nApOvVOpE+1tyg+6YB1WtKn8R7W5sciN9m2l2Mkuc8OW5/EZTlVfCmDd
 DVknq15q
X-Proofpoint-GUID: qHq2O0w_uDMpMpYZbIEUwe4IOUPY0AXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290087

SGksDQoNCkp1c3QgZ290IGJhY2sgZnJvbSB2YWNhdGlvbiwgc29ycnkgZm9yIHRoZSBkZWxheSBy
ZXNwb25zZS4NCg0KT24gTW9uLCBKdWwgMTQsIDIwMjUsIEpvaG4gS2VlcGluZyB3cm90ZToNCj4g
T24gU2F0LCBKdWwgMTIsIDIwMjUgYXQgMTI6MTE6MzhBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+IE9uIFRodSwgSnVsIDEwLCAyMDI1LCBKb2huIEtlZXBpbmcgd3JvdGU6DQo+ID4g
PiBXaGVuIHRoZSBwaHkgaXMgYWN0aW5nIGFzIGEgVHlwZSBDIG11eCwgaXQgbWF5IG5lZWQgdG8g
cmVzZXQgd2hlbiB0aGUNCj4gPiA+IGNhYmxlIGRpcmVjdGlvbiBjaGFuZ2VzLiAgQnV0IHRoaXMg
c2hvdWxkIG5vdCBoYXBwZW4gd2hpbGUgRFdDMyBpcw0KPiA+ID4gdHJ5aW5nIHRvIHVzZSB0aGUg
VVNCIGNvbm5lY3Rpb24uDQo+ID4gPiANCj4gPiA+IEluIHRoaXMgY2FzZSwgdGhlcmUgbXVzdCBi
ZSBhIGNvbm5lY3Rpb24gbWFuYWdlciB0byBub3RpZnkgdGhlIHBoeSBvZg0KPiA+ID4gdGhlIG9y
aWVudGF0aW9uIGNoYW5nZSBhbmQgdGNwbV9tdXhfc2V0KCkgZW5zdXJlcyB0aGlzIGhhcHBlbnMg
YmVmb3JlDQo+ID4gPiBEV0MzJ3Mgcm9sZSBzd2l0Y2ggaXMgaW5mb3JtZWQgb2YgYSBjaGFuZ2Uu
DQo+ID4gPiANCj4gPiA+IEl0IHNob3VsZCBub3QgYmUgcG9zc2libGUgdG8gZ28gZGlyZWN0bHkg
ZnJvbSBkZXZpY2UtPmRldmljZSBvcg0KPiA+ID4gaG9zdC0+aG9zdCB3aXRoIGEgY2hhbmdlIGlu
IG9yaWVudGF0aW9uIHdpdGhvdXQgdHJhbnNpdGlvbmluZyB0aHJvdWdoDQo+ID4gPiB0aGUgIm5v
bmUiIHJvbGUgYXMgdGhlIGNhYmxlIGlzIHVucGx1Z2dlZC4gIFNvIGVuc3VyaW5nIHRoYXQgRFdD
MyBhbHdheXMNCj4gPiANCj4gPiBUaGUgY29udHJvbGxlciBpcyBlaXRoZXIgaG9zdCBvciBkZXZp
Y2UgbW9kZS4gSXQncyBvZGQgdG8gdXNlICJub25lIiB0bw0KPiA+IGluZGljYXRlIGNvbm5lY3Rp
b24uDQo+IA0KPiBUaGVyZSBpcyBubyBjb25uZWN0aW9uIGluIHRoaXMgc3RhdGUuICBXaGVuIHRo
ZSB0eXBlIEMgY29udHJvbGxlcg0KPiBpbmRpY2F0ZXMgdGhhdCB0aGUgcm9sZSBpcyAibm9uZSIg
dGhlbiB0aGVyZSBjYW5ub3QgYmUgYSBVU0IgY29ubmVjdGlvbi4NCj4gDQoNCkl0J3Mgbm90IGFi
b3V0IGNvbm5lY3Rpb24uIEl0J3MgYWJvdXQgdGhlIGN1cnJlbnQgbW9kZSBvZiB0aGUgVVNCDQpj
b250cm9sbGVyLiBUaGUgbW9kZSBvZiB0aGUgY29udHJvbGxlciBpc24ndCAibm9uZSIgb24gZGlz
Y29ubmVjdGlvbg0KZXZlbiBpZiB5b3UgdHJ5IHRvIHJvbGUtc3dpdGNoIHRvIHRoYXQgdmlhIHRo
ZSB0eXBlYyBzd2l0Y2guDQoNCj4gPiA+IGluZm9ybXMgdGhlIHBoeSBvZiB0aGUgbmV3IG1vZGUg
d2hlbmV2ZXIgYSBwbHVnIGlzIGRldGVjdGVkIHNob3VsZCBiZQ0KPiA+ID4gc3VmZmljaWVudCBm
b3IgdGhlIHBoeSB0byBzYWZlbHkgcmVzZXQgaXRzZWxmIGF0IGEgdGltZSB0aGF0IGlzIHNhZmUg
Zm9yDQo+ID4gPiBEV0MzLg0KPiA+IA0KPiA+IENvdWxkbid0IHRoZSBwaHkgZG8gdGhpcyBhcyBp
dCBkZXRlY3RzIGNvbm5lY3Rpb24vZGlzY29ubmVjdGlvbi4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsg
dGhlIHBoeSBjYW4gZGV0ZWN0IGEgY29ubmVjdGlvbi4gIElmIGl0IGlzIGNvbmZpZ3VyZWQgZm9y
DQo+IHRoZSB3cm9uZyBvcmllbnRhdGlvbiB0aGVuIGl0IHdpbGwgbm90IG1vbml0b3IgdGhlIGNv
cnJlY3QgZGF0YSBsaW5lcy4NCj4gVGhlIHBoeSBoYXJkd2FyZSBkb2VzIG5vdCBzaWduYWwgYW55
IGludGVycnVwdHMgdG8gdGhlIENQVSBmb3IgdGhlDQo+IGRyaXZlciB0byByZWFjdCB0by4NCg0K
T2suDQoNCj4gDQo+ID4gSXQgc2VlbXMgd2hhdCB5b3UgbmVlZCBpcyBhIGZ1bGwgY29udHJvbGxl
ciBpbml0aWFsaXphdGlvbiB1cG9uIG5ldw0KPiA+IGNvbm5lY3Rpb24gb24gb3JpZW50YXRpb24g
Y2hhbmdlLCBhbmQgeW91J3JlIHVzaW5nIHJvbGVfc3dpdGNoIHNlbGVjdGluZw0KPiA+ICJub25l
IiB0byBkbyBzby4NCj4gDQo+IEknbSBub3Qgc3VyZSB3aGV0aGVyIGEgY29tcGxldGUgaW5pdGlh
bGl6YXRpb24gaXMgbmVjZXNzYXJ5LCBidXQgd2hhdCBJDQo+IHdhbnQgdG8gYXZvaWQgaXMgdGhl
IHBoeSByZXNldHRpbmcgd2hpbGUgdGhlIGNvbnRyb2xsZXIgaXMgcGFydC13YXkNCj4gdGhyb3Vn
aCBkZXZpY2UgZW51bWVyYXRpb24gb3Igc2V0dGluZyB1cCBhIGdhZGdldCBjb25maWd1cmF0aW9u
Lg0KPiANCj4gSXQgbWF5IGJlIHRoYXQgc2ltcGx5IGF2b2lkaW5nIHJlc2V0dGluZyB0aGUgcGh5
IGlmIHRoZSBvcmllbnRhdGlvbiBpcw0KPiB1bmNoYW5nZWQgaXMgZW5vdWdoIHRvIGF2b2lkIHNv
bWUgb2YgdGhpcyBwcm9ibGVtLCBidXQgSSBzdXNwZWN0IHRoZXJlDQo+IGFyZSBzdGlsbCBwcm9i
bGVtcyBpZiB0aGUgY2xvY2tzIGZyb20gdGhlIHBoeSB0byB0aGUgY29udHJvbGxlciBhcmUNCj4g
c3RvcHBlZCB1bmV4cGVjdGVkbHkuICBIb3dldmVyLCBJIGhhdmUgcnVuIHNvbWUgdGVzdHMgb2Yg
dGhpcyBjaGFuZ2UgYW5kDQo+IGl0IGxvb2tzIHByb21pc2luZy4NCg0KVGhhdCBzb3VuZHMgbGlr
ZSB0aGUgdGhlIHBoeSByZXNldCBpcyBkb25lIGFmdGVyIGFzc2VydGluZyB0aGUgdmJ1cw0KdmFs
aWQgbGluZSBpbmRpY2F0aW5nIGNvbm5lY3Rpb24gdG8gdGhlIGNvbnRyb2xsZXIuIENhbiB0aGlz
IGJlIGZpeGVkIGluDQp0aGUgcGh5IG9yIHR5cGUtYyBkcml2ZXI/DQoNCj4gDQo+ID4gSSdtIG5v
dCBzdXJlIGlmIHJvbGUtc3dpdGNoIGhhcyB0aGUgcmlnaHQgaW50ZXJmYWNlIHRvIGRvIHNvLiBQ
ZXJoYXBzIHdlDQo+ID4gY2FuIGludHJvZHVjZSBvbmU/IEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxk
IGNoYW5nZSB0aGUgYmVoYXZpb3Igb2YgdGhlDQo+ID4gY3VycmVudCBmbG93IGFuZCBhcHBseSB0
aGF0IHRvIGFsbCBvdGhlciBwbGF0Zm9ybXMuDQo+IA0KPiBJIGRvbid0IHRoaW5rIGl0J3MgdW5y
ZWFzb25hYmxlIGZvciB0aGUgY29udHJvbGxlciB0byBiZSBpZGxlIHdoZW4gdGhlcmUNCj4gaXMg
YW4gZXh0ZXJuYWwgdHlwZSBDIGNvbnRyb2xsZXIgbm90aWZ5aW5nIHRoZSBjb25uZWN0aW9uIHN0
YXRlLg0KPiANCj4gVGhlIGhhcmR3YXJlIHNldHVwIGxvb2tzIGxpa2UgdGhpcywgd2l0aCB0aGUg
TGludXggdHlwZSBDIGNvZGUgbm90aWZ5aW5nDQo+IHRoZSBwaHkgZHJpdmVyIG9mIHRoZSBvcmll
bnRhdGlvbiBjaGFuZ2UgYW5kIHRoZSBEV0MzIGRyaXZlciBvZiB0aGUgcm9sZQ0KPiBjaGFuZ2U6
DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLSsgICAgICAgICAgDQo+ICAgICAg
ICAgICAgICAgICAgICAgICB8IERXQzMgfDwtLS0tKyAgICANCj4gICAgICAgICAgICAgICAgICAg
ICAgICstLV4tLS0rICAgICB8ICAgIA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICAgIHwgICAgDQo+ICAgICAgICAgICAgICAgICAgICAgICArLS12LS0rICAgICAgfCAgICANCj4g
ICAgICAgICAgICAgICAgICstLS0tPnwgUEhZIHwgICAgICB8Um9sZQ0KPiAgICAgICAgICAgICAg
ICAgfCAgICAgKy0tXi0tKyAgICAgIHwgICAgDQo+ICAgICBPcmllbnRhdGlvbiB8ICAgICAgICB8
ICAgICAgICAgfCAgICANCj4gICAgICAgICAgICAgICAgIHwgICArLS0tLXYtLS0tKyAgICB8ICAg
IA0KPiAgICAgICAgICAgICAgICAgKy0tLSsgRlVTQjMwMiArLS0tLSsgICAgDQo+ICAgICAgICAg
ICAgICAgICAgICAgKy0tLS0tLS0tLSsNCj4gDQo+IFRoZSBhZHZhbnRhZ2Ugb2YgdXNpbmcgdGhl
IHJvbGUgaG9vayBpcyB0aGF0IHdlIGFyZSBndWFyYW50ZWVkIHRoYXQgaXQNCj4gaXMgY2FsbGVk
IGFmdGVyIHRoZSBwaHkgaGFzIGJlZW4gbm90aWZpZWQgb2YgdGhlIG9yaWVudGF0aW9uIGNoYW5n
ZS4NCj4gDQo+IERvIHlvdSBoYXZlIGFuIGlkZWEgb2YgYSBuZXcgaW50ZXJmYWNlPyAgT3IgZG8g
eW91IHRoaW5rIGl0IGlzIHNhZmUgdG8NCj4gcmVzZXQgdGhlIHBoeSB1bmRlcm5lYXRoIHRoZSBj
b250cm9sbGVyIHdoZW4gdGhhdCB3aWxsIGhhbHQgdGhlIGNsb2Nrcw0KPiBmcm9tIHRoZSBwaHkg
dG8gdGhlIGNvbnRyb2xsZXIgZm9yIHNvbWUgcGVyaW9kIG9mIHRpbWU/DQoNClRoZSBwcm9wZXIg
Zml4IHNob3VsZCBiZSBpbiB0aGUgcGh5IHdoZXJlIGl0IHNob3VsZCBvbmx5IGFzc2VydCB2YnVz
DQp2YWxpZCBhZnRlciBwcm9jZXNzaW5nIG9yaWVudGF0aW9uIGFuZCBwaHkgcmVzZXQuIEknbSBu
b3QgZmFtaWxpYXIgb24NCnRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4geW91ciBQSFkgYW5kIEZV
U0IzMDIuIFRoZXJlIHNob3VsZCBiZSBzb21lDQppbmRpY2F0aW9uIGZyb20gdGhlIHBoeSB0aGF0
IGl0J3MgcmVhZHkgYmVmb3JlIHlvdSBjYW4gYXNzZXJ0IHZidXMtdmFsaWQNCih0aGF0IGNhbiBi
ZSBmcm9tIGEgY2FsbGJhY2ssIGEgc3RhdHVzIHJlZ2lzdGVyIGV0YykuDQoNCldoYXQgeW91J3Zl
IGRvbmUgaXMgYSB0ZWFyZG93biBhbmQgcmVpbml0IG9mIHRoZSBkcml2ZXIsIHRyaWdnZXJpbmcg
YQ0Kc29mdC1yZXNldC4gVGhpcyBjYW4gcmUtc3luYyB0aGUgcGh5LiBUaGF0IHByb2JhYmx5IHRh
a2VzIGxvbmcgZW5vdWdoDQp0aGF0IGEgcGh5LXJlc2V0IGFmdGVyIG9yaWVudGF0aW9uIGNoYW5n
ZSB3aWxsIGJlIGNvbXBsZXRlZCBiZWZvcmUgdGhlDQppbml0aWFsaXphdGlvbiBjb21wbGV0ZS4N
Cg0KSWYgdGhlcmUncyBubyB3YXkgZm9yIHlvdSB0byBrbm93IHdoZW4gdGhlIHBoeSBjb21wbGV0
ZSBpdHMgcmVzZXQsIHdlDQpjYW4gYWRkIGEgcXVpcmsgZm9yIHlvdXIgcGxhdGZvcm0gdG8gYWx3
YXlzIHJlaW5pdCBvbiByb2xlLXN3aXRjaCBjYWxsLg0KDQpMZXQgbWUga25vdyBpZiB0aGlzIGlz
IHJlYXNvbmFibGUuDQoNCkJSLA0KVGhpbmg=

