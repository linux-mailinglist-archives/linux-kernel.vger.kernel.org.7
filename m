Return-Path: <linux-kernel+bounces-836886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7713BAACD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03B33BBA54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63B15C158;
	Tue, 30 Sep 2025 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XnLVWoYI";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MiQllnwj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jAxXZeLn"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A58F54;
	Tue, 30 Sep 2025 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759192261; cv=fail; b=QUaaM7bRGOkK0Kiied6AVXOiVIhVtYQQcxgtJOKZS9MGUwCTeBoc6ORnpsvErAMErCASowOU+k0ceVJ19z7CSjJXTa/2lRbN93dyn+/2t4iDSrZXTYd4XzDTXGA/yAxe2fBrbFWD2k3u2TbAjxsxTmHuqYsGUtQqwD9dLr/UJPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759192261; c=relaxed/simple;
	bh=I2tlvYo2kfOtqtWYkmVs0qKKWr7a/BI22npjw7TM9kU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k1HuguIJqcP7ZHskPwkGcd4Oqg7uZ/sX1nEglsGsojdE+lWROKfhyiw3YDuJaIjOHKQ3CxYaC8BfrZ3dQTg6blHAt3b14hREwlbAlLKmjm/d7EO+rYKceOkVrNeIhJoso9G+kGwu+/r0HlwBWyoMmiOH+I2jl0wyNY6kolOBehw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XnLVWoYI; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MiQllnwj; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jAxXZeLn reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLIF2g013040;
	Mon, 29 Sep 2025 16:36:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=I2tlvYo2kfOtqtWYkmVs0qKKWr7a/BI22npjw7TM9kU=; b=
	XnLVWoYIJZ9pfOLlA8gDUW0CkERryCBZ0OGZ5RP0Eo/YmA8V4tPoA/Zxf8gS3pWA
	Ps6Rvlb6blzeo/hkGQU9zJAOdFSgbROM1trudY++z89mOjOVWxHibLhIpDNddbb0
	vjmG+kI2jSKecTlldR/znFpxHuYgFLRAxQnpeeWCUdSHaasWzh+g8lo/cMxemszy
	QMlKALYj+AZo9i5pHfQuiSw59IfKj+rNuwRSQ6kUYhZ+34BAXJrKO0Kc8vVj04FS
	13sP9Y0A+F6Srsj+z6Zcp4ThDd4BHp8gmcW664JweChDe6eMQLVebajekpmdflqA
	FsZLy086KEbBAj15/qqe6g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 49eejcruch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1759188992; bh=I2tlvYo2kfOtqtWYkmVs0qKKWr7a/BI22npjw7TM9kU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MiQllnwjMZjmWxSVvK29y409XNT28xyCyAwNg4kZULCUJ7VRJ/6XDLekjWzh4s1ns
	 Oo3Qd/ZcEuQpnjW1NZ3834iAgK21nOjMRZ+GluIjdeXQAetKpuQXzUxCgC6mewHgSC
	 BrbaVMdtcDnxYKd7ssAZ9JbKX46WhHglxQVgChbj+tpgDgpGAWh7kP/nNfiPUKHmMI
	 UhlU+jBEc7hCdogFQ2sKQGRSxbI4mIxk1YInWFfOM26uoQf9DNitxjZw1YCxjKPH1/
	 UbgXI8p2zTrE+Eh1lBg1kZg/71VvtWGFZ6hV++ya15+Vdtz00Tw+hiFHe8tNwY0B7E
	 ZCi0vy90p4BoA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CC733401F0;
	Mon, 29 Sep 2025 23:36:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9F41DA006F;
	Mon, 29 Sep 2025 23:36:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jAxXZeLn;
	dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com (mail-bl0pr07cu00105.outbound.protection.outlook.com [40.93.4.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D154840355;
	Mon, 29 Sep 2025 23:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4Jeg+x3kRsJFv2lQcNAebJksDJ+lL61Ty8YEqzLZbKkkew7Gw2JnqJjztRRUp9KAFx/y0xiUo5MMeURSIeZdqeNfZX8YEc6DtAVxJMtG8/yTbSXtm42EiApfc7vQyKTr1cDmNbL6CXeK8P+/BK8Z8LfAhTg3WGR7Kqiz8Vt699dt/0fHrSlZ+GcHUMeKbDhvkaEBWgwEJgB7Dgm6975xz91ALcHvOfJ7HiBPmu/QzBfWO6R+Kv3EQQBulf9mILO5nU9mLSYXlVIZus9/mMpetpW0d8lS4ca/PR22Epvfp0PS60UdT2IXLbDCsJ+PACBDxBi5HsbVIjuMUjX8wfGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2tlvYo2kfOtqtWYkmVs0qKKWr7a/BI22npjw7TM9kU=;
 b=wz0xd8bvA4RpS86QmNC6nhKo/npmjy6XHugDwDZtsWSsA5cUZPZ4+NHesz5BEyp+tbBHRsXh8xy8U4xrjkPciGXfexh2EzYAPLNXaZ1ZPVDnP5ipy/3El/xPInMpwtYkH5hDBKQhco7ezVzPUWzhg6vMeEATwIqWWUTapsD2jItCQNJM2RQ1/1KjxLjXgpxaT0u4TwaxU++HK73AjjWvf5TdJAtdyzbSdxqpf7ODhfvDPIq5v6SLgk307Pg2gyl/EdcEgY0cgQipRAh2bqQRsjR1G+Bz0Vu3v7NNiBMT2tJ9sjl8r65veamPhAFub19zo/woSN5sNKl98hnrfOXU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2tlvYo2kfOtqtWYkmVs0qKKWr7a/BI22npjw7TM9kU=;
 b=jAxXZeLn2LRaFatESwCsktmZ2WuVBmlXfuUT/HkUi5SwUvXDhlEjsKv9PiiohuOzmriUqJZy8jCXm49X4vbEYm66cUuY55LR1Qn3YSDejlBt3iurG//lQSasZ9qQKZIMVVNXIoIciAIv/VtKDsQaN5TI9C+gx10qHigRD/8P7bY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 23:36:28 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 23:36:28 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ze Huang <huang.ze@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Don't call clk_bulk_disable_unprepare() twice
Thread-Topic: [PATCH] usb: dwc3: Don't call clk_bulk_disable_unprepare() twice
Thread-Index: AQHcMW7vrKTQWD+dnkmboPbuIuYYK7Sq0N+A
Date: Mon, 29 Sep 2025 23:36:27 +0000
Message-ID: <20250929233625.jpk2sxjxhj2kghfb@synopsys.com>
References:
 <371860315a5c1ef6e800fa825e4c23ce335a55e2.1759170517.git.christophe.jaillet@wanadoo.fr>
In-Reply-To:
 <371860315a5c1ef6e800fa825e4c23ce335a55e2.1759170517.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV8PR12MB9263:EE_
x-ms-office365-filtering-correlation-id: 0bc6d390-b0d0-4c73-0448-08ddffb102e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0l6dis5ZDI0MDVucDlGU3ZWZE9TemFBZ1JESTdhdnZvZTJId2g0QVRqSUts?=
 =?utf-8?B?a3RCUUh1eW1PNHJOUUk4NWppY0xvNmlFcUZUcmtRTXV6SVdSVk5LNTVhOG1z?=
 =?utf-8?B?Q1AraVpWQXlONXlCb25HdWZ3b0p2L3p6RFg1eDRsRE5VZnZTcDUxSS9wbXhT?=
 =?utf-8?B?cXNDYm40VjkwN2RhQlVEUzlybnB1VUdWWjRSNXNkN2VYUkRJdHZaRWJrRUNx?=
 =?utf-8?B?M0NNZE95aFZUZmlOZVhXK2hrRXd4RUwvMEorOW1NMEVqT1E1UFB2NDQwR2Nz?=
 =?utf-8?B?RUpEWmNWZmpna1ZwSktUNlFpbnhUeUllYk4zczY0VHo3ZGpDWC9UcXhwNTlC?=
 =?utf-8?B?UlJ3UDVaSUFoNnpXcEN5RjhGU1NQcVVPZHR1T21EMDJ4ZFk0Z2xneGxiSXc5?=
 =?utf-8?B?TTVLWkQ0dzNnVXpNd3NXTnVPNDhNWmVPMXllalVES0VIbFJPN3VvWUM2eDdv?=
 =?utf-8?B?UUdjS1hZd0lrV2w2V3N4REUwSWprZ1JjTG5yclIrUVBHOVVWakZHNExhNnEv?=
 =?utf-8?B?OE5uem9teUFsSHdlbEo1YnczUFBCeDVkNUJLU2lpOEM3VGJYNzhjVmNTWWZj?=
 =?utf-8?B?K3dZckovL2pjaTUrMUFEcWg3dVg0TzRFMWMyL2pPS1NwUjEranJlQm5DWFB1?=
 =?utf-8?B?YVphWFZWbXpnRXpueFZzVXVPYU5xQ21CWDY5VjBBZElPS3hXYU1FTHdIUU1q?=
 =?utf-8?B?aFVLN2pka2NKREhpSTFua3BEZWpDNUZWTlVvM081YnpjZUJYc1NaYUZVYkdk?=
 =?utf-8?B?L01Nblplek9DQ0ZnaHBtMCtEYnJsUkh2UnM5a3lkSDBneTBCcXBwcktuWVJ6?=
 =?utf-8?B?NUc5ODIyMmFwL1M5MjVpbVcyS0hkeXIzMTVUZFBJMWxBS1FUc3ZCN2ROSlpi?=
 =?utf-8?B?cFZrNVFUeUhCTlhBZjRZY1NJS05JNVZ0TmZTMUQrNmZFM254TjV4azJTczJI?=
 =?utf-8?B?bzkyMm00MFV1TkF1REhWTmJ3K0ZrZHVsRjdwbTY0SCt3SElLZWlxNk1Bdjlv?=
 =?utf-8?B?Tmh1bVkzU3ZKQit0YVJjdVZ3aDJtVUJQelgrOGhmL3RJU2pvVDV1YmZReEFt?=
 =?utf-8?B?QmVjUS9VdW5VRFlWRFpCMGZtbUlhSHFHYitJaCs5Sjc3MG5wWTd2QjNOcVox?=
 =?utf-8?B?S2hjeG1GcnArOVovSXFuTGw2Uk9GYUU0RjdoRHk4bVN5bENuU3lxbmoxbkNY?=
 =?utf-8?B?L2lWQ3p6TDcxZ3dnSTZOSHFIQmZlTDlaNzhDYkZXTEVzaDVQdm9iOXg3bEVY?=
 =?utf-8?B?Y0FaVXZWbTAyUWNBcWxLMC9JZFU3YlNIdnlLVUUzVzV0MkxObUEvRGUyR0Fi?=
 =?utf-8?B?L25Jb255WGt4YjkzdTdMTkYrMXJ1d0t2R1FLdDFMZUQ0TlV3M0M5QUd0R2hO?=
 =?utf-8?B?SzVtVVdxajFwZ1hmamphMUQxNWl6WHZnMmdvMERLV1ZWSzg3dWwwQXlqOXF2?=
 =?utf-8?B?ZkVxc00rbm1qZDJyMHpyWEF0OXBDTmU1QVBPYi94TnhYajYraHQ2MXcwcnlC?=
 =?utf-8?B?dkJyNVZRTDVXWTVaRmU5eEgyTUt4ZU1BM2k2UUp1YWFXaHZOZlpPK2tzNEVz?=
 =?utf-8?B?NXBDM2t5QVpSaWQyUHNVbGhHTlRod2NGSThNWUk1NU15d3I3dlBqaWtaYzI0?=
 =?utf-8?B?bTRwbjRFeUQzZTdOcHpoeUk3Q1FPWjc2N0pBMWFSS3cwQkNOZWxpZGNxTDJ6?=
 =?utf-8?B?cVVFRXJIZ0JEeVpDU3ZDUHBlZU43TVRoTGdFMmR1NTNKQVhDcERBbWNRMlVC?=
 =?utf-8?B?bHVFTGtaUTR6TndiTlV1S24vTUNLSTd0eERRbnk3Q2ZHRGY4YnBBelRXc0JT?=
 =?utf-8?B?eEVwc1Noc09kRExQMXBoRklyQ0txODU2RXdqZjFOODkxdGJTMVRRSEdCVTRu?=
 =?utf-8?B?S2xTbTVEb2dCTDYwb29DRFFhZGFFUTRQcXF4cVZIWk8xcGdsSUYxVm12d2x1?=
 =?utf-8?B?NzhoZ1RoeXRNbjdFQ1R5TFVxSTh5KzVUaXBjM1oyRVptOFpzM0wrcmVaWFVN?=
 =?utf-8?B?bjl2UHpoOVVQWXdZZ3ZxOGlmV0JCRm5ycjIrTnd2NElDai8zWjNPZHkzcnBm?=
 =?utf-8?Q?MZOI0d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHI5ZWowbVR0L2RpNjF1UzZESUFDNEt0eWYwOFRjcm5yNUdzcGE1MysrWEN1?=
 =?utf-8?B?MFNxU1RvZkpsaW05bTV0YzBnaGIxV3JyQTdBQm1lREwzNGpFUXNaZENPTS90?=
 =?utf-8?B?bVdvUmtCWXhNdHZiQWpNWkFLNzZoMS9XN2xGUnNpTW9XdExxM0J1SHhGakZp?=
 =?utf-8?B?eVJDTHh4MnJ2T1Y1bnE2dGIxQkpMQVE1aEFYVHo3OUZMT2o0SXFKSmQyRmpT?=
 =?utf-8?B?WkYyemtrR1E2czJQY0RxRFBWVGR1ajdlMVIyK0I3bGVyMWhCUW5xRkZPZzFl?=
 =?utf-8?B?Z0dibWp5VHBzSktqNkh0Z3g2K0FJLzY1aEY5a2Z4ZWZaN0xkMVlzMGNtQzFj?=
 =?utf-8?B?Y3ViSmZleEYxdmZJbk05K3lFb3NMY0NDRXUvcCtFSzJMUDdRSk9NeHp4N3Nx?=
 =?utf-8?B?cDhDQ0hlcnQ1RXpqL2lncENDUGdXWkdtd1VubUswdHZicDhKNzM3Q2t5OGpm?=
 =?utf-8?B?ZUxBZkwvcUFJVXpGU1E2L21FVisxc3ZwVDFYYW5jZXhhRWMrRURzZ051aTBu?=
 =?utf-8?B?dyt6WmFyQ1hmNnlxcW5McmhkeTdHQ2IrYUlMcnN4MDgwS0JWa3lWN2t0d2pa?=
 =?utf-8?B?Tk80SHRrVUpEZEE1MWt3WjRYR25Ca2RTYnNCMWxOOXZtZm55bFltaGJpZVhE?=
 =?utf-8?B?UGM2N1dSbHpZTkhxTDQzMWlZdXlsdkg4aEhSUGdTV1JWV2lCeVAyMnMraEox?=
 =?utf-8?B?Mi80aVhtKzRjcWhySXRDaE15WW1zVzhSeUNTdCtjMlMzVnFZcVFJYk9QT2cw?=
 =?utf-8?B?MXlUSGdGL0N4bVV5WUV2YWpFS1FORWd3MmZtMlVaVjVEME56b3RGVUxuWndD?=
 =?utf-8?B?ZDg4TVJzL0RFNU5MRytWRzJwY3owNHJJQWtwdEZWcGJXSVBCdmI3WnRyQU1y?=
 =?utf-8?B?Si9rRmVDRW1oWGJ1d0JqbGZONEJWaGwxYkxjSG8wdnRDcWpiWHRtSGxLRFYv?=
 =?utf-8?B?bEtmejg3T2RCeDZrTm1KeXpXRDcvVEhIRnJncytaRVliYmZjWGx0c09jMngz?=
 =?utf-8?B?Q09PYTNUcWFWVHQyb1lEUXRwSGVCSWRLTTNValhvMDU1bFlhMWV5MXNiWlNx?=
 =?utf-8?B?QzltOUJRTXJxbUxrWTlqeTh4R2dJb3Vpby9WN3NHTFdKT20rdkFJaE9xQ2RG?=
 =?utf-8?B?aUxhMEh4V0lWRlhVWVpPenZQSG1ybVp2SC85L1E0TkJYck5OZy9USDhocEZG?=
 =?utf-8?B?cDdxTW9CWlhtSVREUWYwOU9SOG00RW4xUzBIS2lWNlNyZm0zNFVobmNNc0Ji?=
 =?utf-8?B?Rlc4UWtQc2RUL2FOdEh6S3gxN0R6d2w4cWpFejRwUFlVQjhaVWZlRGplejY4?=
 =?utf-8?B?aWI1N2NrODQrSEtGNXR3Q3g3MXBVS1Zid3FSY240Ukx4cVlJTktMS2syeGlm?=
 =?utf-8?B?WG5xenRxY0YvYkNzdUhKZlZrTGR3VUdncnJ0MHNVdUE4YWdIUlNtWkFHdHpr?=
 =?utf-8?B?ek1ySEM2clI4SUhIUGN5ZWRhQzFzeEkxV3JsdFBDN3VRU3F0NHUvejN6OGdu?=
 =?utf-8?B?RXljWEVQc3FPVGFKUnJORER6bUVuaU95eTREbWxvbmJXQWlOK2NiWHB0VEI0?=
 =?utf-8?B?alBqYTBTR1U2TTFoV2xnMVQ1QWQ5Mlh4NkNmKzN2Q1dLN2R6alg0Vm45ZEhi?=
 =?utf-8?B?STZpWGVVMjRiWXJ2UGQ5NytGa3NKV1pDbjU5NFlYc1dKb255cklydHJ3VThX?=
 =?utf-8?B?Z0NpSTZGOUo2ODBDUGZibkxOYjRVN1IvT1Y4eVpzaG55OURCL01Ha1U4bVZ2?=
 =?utf-8?B?THA3NDNvN3JtekZ4UGNrZUZNMUhjL0ZnaDhBOG8vZUdQcndPK0NDcW5XQ1dw?=
 =?utf-8?B?alBrK3VxcThBM0MvZDBRT09xNXh3aUVHMHBEWGN4eS9DZ1p6Z0NGVXhqRlJO?=
 =?utf-8?B?R0hGbXl5UHpkYkNYUzNWVVZGTDZaT241V1pZUkpUUkFkRHAxakF6NUhaeC9s?=
 =?utf-8?B?R2xrWkhmZmRjZE1aVnNleGphUlYxU3o5STYvUUhkWVhERjZJbTFpSHZVd3Fn?=
 =?utf-8?B?cjFETGZSYWxPNUx0QXZ0UG9OQnljbkE1LzI1eXB2UzNwZFhVVmtsZ1ZRd3d6?=
 =?utf-8?B?cVlNZDZLclJDU2tybEhMT1JCM0M3UGJxOW5Qc1hHRHFGTTlZM3VYeGFzSFVZ?=
 =?utf-8?Q?U+zRoKwAmK9f62m9Eprw6TUQd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F198DD4CCC78F45B7C8B04E546FCD1C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uSJRbOFhmF5pHKNr+z48Ro4H/+hP/0G1YUdeotrHUYVW/MN7058qXRuQIUl4yTWccVTwL/N2OEYV95nmdX+0SgzV2stkn3jNYaFK6IxLjh+npCVQLCnbHTDXKCC/Ims1Zf18oJu9MggGQ2hS1UQWNZTl7j/Q9+eW+fDfO4HZC13Yt9GTQ0brp0AmB34wzCDibdqKeDyG2uJC42fJGjiJK4GKZiBNbUMSH+Bp25/0iqghzjLwbNco6MGjhvxFfgLECppzlRTRimG126ZxIthoFM9vUWMp+7Vz0boEWUsmScUBVnUf1jIimf2lxgmU8KShwH0jGlFJRs+GuTgB9Ao/1M4NyZDQgXbeWV2stQreNX00Fy+Hwgn/QfxmoU+HoWcOAjShJdB6uoLbZf8+444xhBjx/EzAEki1n3Ovs2x/YPV1bANyncLwqVh2wy7qU5BYK0GpaENUUId6F+SUnQ1t0QaIl+R2mlNi1icCSxa6iJDPufBMAOzmhly+YLuSp1pzJ4gmwkerTnPCpe6gT/Xzwxd1RJK5cIBcOxyHUdLeBBhu8hh0gkZTRcXQMeyTUS7+YLPfFchzYUrQue8jLvVJWXywmlSaXeWJnEKrWS/xx2/Cq87cL8cjfW+wxnHSoOpOLkShOHLxO9lUTqN6BXoCig==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc6d390-b0d0-4c73-0448-08ddffb102e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 23:36:27.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcDvdPLiVQFj2H63TYNkEJOQNmaNSV6qsP4BmVGK839bV3WMwOvwjbsMIpOVImRSMZm2+4Qsb6xg0dlmev4tmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDEwMyBTYWx0ZWRfX0ZxkNDyp28QE
 JKbk+NN5pFkTBpECUJozbG+QFOH/tuWoH+tnZPmHKtzwfxL9irkHC/ih93hWQUpIeDOzGN8sg+4
 a63mH14V7hvM/0j050ffWEjvHcTdf+vu/z5DafpNSr7Qjv/GrMJfnwY6Q6KMjT6Na3RPDoZoYVL
 4soZVmiwrqJzzqn1G+iLQFSibsSy4vwMirwHASy2iYcy4P9Sd+MxVOTJgH0kC+ay2Kq+AoLbJ07
 iLgtI/P8foLb+2eds0mLfDoty8jr6GSTkC4m176GnCZ90VvPBmCsy8A0S853S2QhczlGMAr5ija
 bgEXkpsTY6rRTxoIrhmFHKk7IncIbO/hfYyXeE7X4ctm8okw7vKNc02PPPGNU7do/sQZsSgSeAl
 1NYc0jKE9ABqw6KJoSvMXmKBn/KWcQ==
X-Proofpoint-GUID: plElmwHDitafrBXcQTMXvRs0tGqPQocb
X-Authority-Analysis: v=2.4 cv=APvnFWnn c=1 sm=1 tr=0 ts=68db1801 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=6lsWm3Hnz1wPcTI6twcA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: plElmwHDitafrBXcQTMXvRs0tGqPQocb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270103

T24gTW9uLCBTZXAgMjksIDIwMjUsIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToNCj4gZGV2bV9j
bGtfYnVsa19nZXRfYWxsX2VuYWJsZWQoKSBpcyB1c2VkIGluIHRoZSBwcm9iZSwgc28NCj4gY2xr
X2J1bGtfZGlzYWJsZV91bnByZXBhcmUoKSBzaG91bGQgbm90IGJlIGNhbGxlZCBleHBsaWNpdGx5
IGluIHRoZSByZW1vdmUNCj4gZnVuY3Rpb24uDQoNCldoeSBub3Q/IFRoZSBjbGtfYnVsa19kaXNh
YmxlX3VucHJlcGFyZSgpIGlzIHRvIGRpc2FibGUgYW5kIHVucHJlcGFyZQ0KdGhlIGNsb2Nrcywg
bm90IGZyZWVpbmcgdGhlIGNsb2Nrcy4NCg0KQlIsDQpUaGluaA0KDQo+IA0KPiBGaXhlczogZTBi
NmRjMDBjNzAxICgidXNiOiBkd2MzOiBhZGQgZ2VuZXJpYyBkcml2ZXIgdG8gc3VwcG9ydCBmbGF0
dGVuZWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUu
amFpbGxldEB3YW5hZG9vLmZyPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5l
cmljLXBsYXQuYyB8IDMgLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCj4gaW5kZXggZDk2YjIwNTcwMDAy
Li5mOGFkNzljMDhjNGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5l
cmljLXBsYXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMN
Cj4gQEAgLTg1LDExICs4NSw4IEBAIHN0YXRpYyBpbnQgZHdjM19nZW5lcmljX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMg
KmR3YyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiAtCXN0cnVjdCBkd2MzX2dlbmVy
aWMgKmR3YzNnID0gdG9fZHdjM19nZW5lcmljKGR3Yyk7DQo+ICANCj4gIAlkd2MzX2NvcmVfcmVt
b3ZlKGR3Yyk7DQo+IC0NCj4gLQljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShkd2MzZy0+bnVt
X2Nsb2NrcywgZHdjM2ctPmNsa3MpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IGR3YzNfZ2Vu
ZXJpY19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gLS0gDQo+IDIuNTEuMA0KPiA=

