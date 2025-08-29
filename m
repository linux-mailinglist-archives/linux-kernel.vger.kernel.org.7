Return-Path: <linux-kernel+bounces-792470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719C6B3C456
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4AF581BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CD274661;
	Fri, 29 Aug 2025 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QzY+GU0X";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y0nWw2ZP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lSiFPhF1"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB521B87C0;
	Fri, 29 Aug 2025 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504183; cv=fail; b=oYChHyq27cQf+fXOZYVn8eHqNjco+xBBsg/noK3TUowmw8CqkWRPu3ny3XXrH8FhMLFgjll0jD9coUp9dM+COIIk87lV6lUGEkqtS5PI8QweL+QctNqo2232KpnX1/9bNgh7YRN+4QJmzF2CpX0zGIwrsgX31S1o229SQ4Lrp0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504183; c=relaxed/simple;
	bh=kshivZKvo8rd6UxhHAnEPQVuqdRaqr4h5H2X3JLMxS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=suXcRyqh2AH8ATYNciULer97C/F9HP0LKwnQvaOeGX2Luy9SQrCu40l23h7FMNAXwwcKtc9AQFcN1TUw03suFgn8WqJA8sZOygRlcJdzUA6h/1N96MaMxZXqk0nJ4+ffvuJOb6JYq5Ba4uVQENgmlcUneBqYfoZ6t/DimPN8sg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QzY+GU0X; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Y0nWw2ZP; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lSiFPhF1 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TEow3O005212;
	Fri, 29 Aug 2025 14:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=kshivZKvo8rd6UxhHAnEPQVuqdRaqr4h5H2X3JLMxS0=; b=
	QzY+GU0XIngFmxOFCu4yqDrVWsx3Ytc3jbnj2jqap/AnJFm/F6dxdpmGKKrrBz9K
	9TEOie0zuOhhqsTSjEx4jOHa9ooRsJopR+f9sQbAOsO4kpi2Wr8DHWoYV3Zj+ylB
	cFDXzez1HdZ69jGnVo03Z5WPmbSkHABtmi3iIznLgMIAJ5cv2MrRGVYbFQ717URk
	t71mPZIW+E2goy+g3s1XPRgzcMSTRZLl4Uhz9bhS/31qLCv6v8HV9wxd73mWb+qT
	DpyPG7f/z9pKcPhmGqKx43/By4BjYtjxbvm63OO2gQBUFFhvEbbQHm4FXV4NfzyT
	sl8E7ZKIhBlVhIUohJ2A4g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48rpxsusb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756504167; bh=kshivZKvo8rd6UxhHAnEPQVuqdRaqr4h5H2X3JLMxS0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Y0nWw2ZPp2yZsflNqjsTZ/sXrM7gL9XiVSEoMsXADTQLjpN8HiOfJR5EUdb2fH8qr
	 SxUcJWSAeQMyNOVyvVYmOXHvlBGsU/yT/blCpyZf7qLMdoBQZ5P69FkJj59wqRJ7Ue
	 gHKzfPyLkRFPwEP1zi1y029Qz/GJFwKGm2IO0C+i1bLTfTniepIZ8KJC9CAExh2idx
	 YlfYtNGWlncuy59KzwuvRHh83v5tRL89bEcnr7Xc9N3R+ozQgrDU3IMzGzhcHF0JG0
	 YfttGEt9xVnc4lOCCibvzHKsdJ09mxYtQNxM06JoxgWtMXRDZ66ZDrlSVcN312etZF
	 aSDRHurqCHq8Q==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0D96A404EF;
	Fri, 29 Aug 2025 21:49:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A60BAA006F;
	Fri, 29 Aug 2025 21:49:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=lSiFPhF1;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7448F40610;
	Fri, 29 Aug 2025 21:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nzf5Anosm73pv3tEApQ9GV3REzMUM1ZNsX4n6sSD6QxSnzJXceUpcgcQt1sANNedi6TZH6gxxMLnibulSh17EL+4MeKrv0upLN5Cz2I4lTfR78duKzuX3PJye32Tc9hCtM5ONVcMml5Ek5xeTDLSems6hMBTLhoqlSUVXOcLkPVXN4z8Wt2GQxFLJzUK0imu7JtzMvtoeNdwapt0SfqIXac/L9yY1YrHTLsp9bP5XJyXRDbKJuHPZjAXj+4OXwQI3WpVFsJjnL6t1V6XA1CBDTlWrhuMnmGDSC58Pcsi2jbYGA4tvd561VBLiB/x1DWkF0eW+e93T1DZGIF7QbbUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kshivZKvo8rd6UxhHAnEPQVuqdRaqr4h5H2X3JLMxS0=;
 b=xqHPhffrj3nqLQYfK9sNpARLFyHu9kyRu7W/OTWv9qGXJo4jJ5i7rJoX+yF23b12NJRJcA4jCMMNJII1wHBcGyU2UQ1AmhW7OKujk/adohUEd2CorrEzCqCSkAj1+WBFk95fGjY4GgNkkOjVyChlGy/lf9aLhXyevGxhaTlePvbflebMVy1ruC3cOzVD5iZ1rOPyoOu1qevAn06FwCGt2ienWyqQJO6qPR37Q+9KcUM0373hCwGr5RC2Xn3WmdX38/AJ0qGdeN/mOPJ/IXCk9NWArUwptA+3piysH/4cFYYfzUsZsynTNyj+hDC+CWmsoI7xKVRBCpiQnbXJheWyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kshivZKvo8rd6UxhHAnEPQVuqdRaqr4h5H2X3JLMxS0=;
 b=lSiFPhF1VtYGuwiqw1WLdB14yEqyd+HnU77GQMF6NVIpr6WtrWvLHXe+DgiNDAlNX4zOIKDbHqT5IzaFXo76594SwmY0MXFHHRTGYZvMr4de9Z9fzvoPLXQbUKTDAZe+WxaNwmkMyqAWMAorexg4nW7GsdMDIcPFevBzsXjUzvs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 21:49:18 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:49:18 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "Chris.Wulff@biamp.com" <Chris.Wulff@biamp.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "punnaiah.choudary.kalluri@amd.com" <punnaiah.choudary.kalluri@amd.com>
Subject: Re: [PATCH v2 3/3] usb: gadget: f_sourcesink: Addition of SSP
 endpoint for ISOC transfers
Thread-Topic: [PATCH v2 3/3] usb: gadget: f_sourcesink: Addition of SSP
 endpoint for ISOC transfers
Thread-Index: AQHcGA8sd4XivDK58kuqYyfukkFg0bR6LWkA
Date: Fri, 29 Aug 2025 21:49:17 +0000
Message-ID: <20250829214916.fqxyu2baer7apkl7@synopsys.com>
References: <20250828112944.2042343-1-srikanth.chary-chennoju@amd.com>
 <20250828112944.2042343-4-srikanth.chary-chennoju@amd.com>
In-Reply-To: <20250828112944.2042343-4-srikanth.chary-chennoju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY3PR12MB9556:EE_
x-ms-office365-filtering-correlation-id: 74ea9de6-26fa-457a-e73d-08dde745e7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2ozTzZzMVR4SGgyaEpiWkJNZFZHZEhzMVFTNXhZYkhlNlNwQWlrWXcrU3Rx?=
 =?utf-8?B?eGtPYW1qNXdtd1l0VHg4bWtocDc5ZXpSRVVWZlJTd2tjKzdCaFdPL0tFWmNH?=
 =?utf-8?B?NmcvQ0RhUXp3S0k1ME1jWXJGNlJYUkQwSTM3Tk5YL1N3NHFhVmNpbGExODcz?=
 =?utf-8?B?UUIzMlV4RXFZemwyZVlzR3F0d3dZKzh4b2sySUhGakpDOXY4OXA2Vkw5bk9p?=
 =?utf-8?B?QUMzeXVsd3dRVTRpRFNpd0ZlM29RdUVmaldGSFlrbjJaUy9qaUt1cW8vcmw4?=
 =?utf-8?B?Ty9FRGhLT3hGSWhOZXhRdytkOVBqZTVya3F0V3FGNmZITEVpZnZzdEg5dWtO?=
 =?utf-8?B?WmllV3h2NnVaQk1vbklKM2dNWnRBQVdTTE9zNEtUeHFFcmJjT3JTT1BXUWIv?=
 =?utf-8?B?L3doVWs0aDRMV3FDKzdkeXhoTVpaeWNCdUlJZzhDeFdMV3U4bVpZQ0ZWS20w?=
 =?utf-8?B?ODkxbkxDUC9ZRWhBeS9tcGZwZ0J6VjE2RlFJdVpXZ3ZBaThGK3I1RzVZWG13?=
 =?utf-8?B?Q1NCZEhzMmpKZ3dWRGtybFhObm5UT2JUNDM4alJFdHB4V1BLOUp4SnpUMzlT?=
 =?utf-8?B?OWlhYXhBQUN0TytzbHZ1dVFRdWdRRnFNNStPZGtkWGUyRUk4K3l6R2xLUWZM?=
 =?utf-8?B?VkpnU3VxQXZ0ek9wOUtzSVNnNTdwd0hHT0FOWWNMQzU1WitTZUc4OEJ4M3ZL?=
 =?utf-8?B?L080cXBhck1LSWhjVE9zekdMcy9LaHNsa1ZhVS9OcC9jOW1zVnJOS3JldkpL?=
 =?utf-8?B?V3JySHluR1duTEJXS1BLVGZNb1grTW1IL1V1aXh6RWljcFZZQzFJWHAzNHhn?=
 =?utf-8?B?dTVHOG1BNW9Ba1pFTUdlTVpuQmlId2t5WjN1N2JIRGxOZ1BiK3ZzcUZjY3dm?=
 =?utf-8?B?VldvMHNBeisza1UrN2x1NEFQQWJ0NUM4eXYzdURaMHZDMmozVXhOaHM2RHpU?=
 =?utf-8?B?T2hDTFFXVk5DSWZhYjVvT1h2UHk4TThqT0l3SE9ZRVc3ZzZDNDJSclY0S29y?=
 =?utf-8?B?S09RSHZwd3M1aUl2SXpkalBxV3R4d3UwWGR5Y2ltemNKeDZhcGszcnR0VkpP?=
 =?utf-8?B?U3owTVhVSmgzaGpJcFFON2xYT1cxdXE0WlREVWFUZXRhc24rL0I5eDBtSmNq?=
 =?utf-8?B?dm1zc0g0ZDFEUjNaK3VHMGpOZzJXZkpnS1pLUm9qZFU5UVA2RkVOUDBjVHcx?=
 =?utf-8?B?RWdHcEdLUXRYTnVqNkhaeXRpL0taUjk4U0hwdytTY25hM0s5NXRzeVBDZ3VJ?=
 =?utf-8?B?N2JvK2JzakxjTE8yMVF6V2xwWVpPQ3ZiNndacSsvRnRUbzVJckpwdmIvVy9s?=
 =?utf-8?B?K0s3aWdJN1pXeTA1aEh4VzVjY1FWdUtja0k3VGVxRWtOLzhVb0xKUEFuUllY?=
 =?utf-8?B?UG9ZMFFubFp3bkxyaThVU29kaGQ1aXJWYWo3YUlJaHlwM05ZL2h2bVdSZzlr?=
 =?utf-8?B?VzdCTHJOYUozaW9jeTRLQ2hCalF5eTFMWC9wSDM1SU9VSSs5Q3BqcENadC9z?=
 =?utf-8?B?bVlXSlk4YmxsaW9oNE9NTEtSeDdkUWVGSWJPdi9SdkQ2cTJRcHFETXU4MUZU?=
 =?utf-8?B?a3lYK1JyZEx0L082a3RJc0RHVlNreERtRVIvM2w0UGV3NFpleUJQTnBhSnV1?=
 =?utf-8?B?QTc4WXh4cFBtQ0ZicmFSd2FBUU9DODJhczNyVnpRK0RobE96SXd4MXM0b1d6?=
 =?utf-8?B?VDJBQjl0UDFJL2NjZ1NDRzJtckhHLzUyY1Ayd0lZaDBTZGo2U3BGRXMxNGJI?=
 =?utf-8?B?UVh3TngrOEJEUkdFeFhyTFNUcHB0TE91czhqNkdLQ09Nc0JSN1Z5M1NTWUhF?=
 =?utf-8?B?MG1uRVpaTDNYanJkcFAwa1M1VHhoKzBJZnBBZCt4ZUlEQm9SVVU1L3l3QXY3?=
 =?utf-8?B?WUZwbVNXbnl0R2lkN0QzTFFWYjh6Nkk1NW5GeldxZVVWRVpCMVV1NGwxVmVM?=
 =?utf-8?B?SjRrZk9jS1pOcGEyVU5CeHZWcjBvUHlnR0Q0SGgvY2E1MXFVRWFxa3A1cmtm?=
 =?utf-8?B?RWQzOTF0VkJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWZ5cmxoa3JzUGlRL3JBb2hXTzBHQ3h0NlRPSWFiNjBJZ3RYeXI2enRtUCtt?=
 =?utf-8?B?T1ZLVlVDblZNdXB4R1liYW4zb0FTVk9JSXNkbkxDUjJWUzdXR3Vad3Q3TjRl?=
 =?utf-8?B?RjlBWk5BeVRMSG4xRFphZ3V2U2JyMzlUcnordkdlOHVHa0toWWsydSt2Yllk?=
 =?utf-8?B?eDNxK25SMmc0RS9UY2UwV1MyZ0lRZ1FhaFEwdnVITmdRZ3Zla3NlZ0Z6cnpy?=
 =?utf-8?B?K1g5WXdrQm1CNzVTTGFUOHlBUDlpcVBUbHBvOFlJSFFVM1grZGI4QmkwSVp2?=
 =?utf-8?B?WW0xK1BzcjFBTnNkM015MDNEaFRvT1BvTVZUV3o4TytYTS9temdWRXlZUng1?=
 =?utf-8?B?WWZOY3pobEJrNXZwZ2U3bEgzS25jOERYc3BtT0lacVBzVmpKdkc1OW1OTk9z?=
 =?utf-8?B?SS9lWDN4dG1wN2tUMnBzRk1QSWR0M3QrcDJneXNMMFR5K3VWT3B1RlVCVlVl?=
 =?utf-8?B?VzUrU1ZuK0tXZHN4cW1nSXVtb1J0YVZISnA5V1p1VExuTGlUOXNRVFNEVlNB?=
 =?utf-8?B?aWw0VmFxdU5HMTdvL0VDOHdzUEcvY2kycU5xc2JDZys0MG9NM0dTVHNNTnNq?=
 =?utf-8?B?aTVOa2xtaHkwZGdRREF1V3lELytWekJuN1VKSmdJSzVBd0IvanZhR2VqQm5O?=
 =?utf-8?B?MUc3RzRYN1JrRCtOZHJsc2pYR2Fsb21MSjNuSFp6VzRaQktNSnY4TDNJVGxQ?=
 =?utf-8?B?M2l0ZjVUNVdMTUJ5TDIwYUZ4bWpFaklvamNIcjl1bUpNOXhXNXhmR3FjSW93?=
 =?utf-8?B?ZXpYRlVUWktsdks0K3A2RkpkR2J3WFkvbTRLa0R4ZnJURWt5TWRiYlc0SFZr?=
 =?utf-8?B?ejYydmF0SnJoc3cvVFMxYjF2Wk93TnljZlJ2NTRHUkROejFjZWdDYXZWMHFn?=
 =?utf-8?B?U05OS25BUmo2a0RPUk1tSkY1bEhtSndhbnJtbytGaFpCNTZwdHlUNkRGcWpD?=
 =?utf-8?B?UGg2eGVMc0x4eG1leS9UanhiVlZxQ3QxOTdjV2l6VmorUUF6OWtJMkVNV0dR?=
 =?utf-8?B?KzM3NlFYTktyZDErNDBzNVVMaUlHK09BU0JNYTBoNlBvRDlTOWxaOXlGQXhi?=
 =?utf-8?B?d0NkeVJ4UnYzVGlZNm5BOWk1T000WFl6bXBrSG8xME1qaHNpeEVqMW1FRkp5?=
 =?utf-8?B?ZnZJb0lKUFBmR0xhaXlDR0VZNXovYnovR0tuV3ZhUUg4WFM0dUhIZndzdTZv?=
 =?utf-8?B?U1ArbnJJU0FEc3Z1SjMvUzBFSE9EbDVhdjNiOWpqT3NDR0w3dUxLOXN2Vlo3?=
 =?utf-8?B?a1hpcE5XODNkb3liTW03QnlTMVR0R094OXE1amdrQ2VSK2Z3bWE0MVVqSnp6?=
 =?utf-8?B?ejhKdjJSU1hyV0x5M0NZb1dlaXhmV3p5YXJ5R2RsM2tqbkFXTGd3d05yR0No?=
 =?utf-8?B?NlFEMit0SG9WZEJ2SGJoTnIvOWsxZ1pmSHRyM0ZIc3JiTHhWSWl2MytSZU5K?=
 =?utf-8?B?WE1qOU5xQmZLVEpxYWE2YVVQZXJDWWwxUGFGUGI4YmUrNlFyblphYlpudnRZ?=
 =?utf-8?B?a2FzSlFNaTQrWWFpUERpLzZJZlplUDE1b00zeWcxZlp5N09qWTF0N295VnlN?=
 =?utf-8?B?eXd4eHZHbmx4K1dzR2FhQkdiSXRPbDgwRGo4dThyZXBTcU9idjBwMkRCaDVj?=
 =?utf-8?B?YlduZEp1Unl4ZnFRZGE5cnpRR0dqSndkQ0l3Ny9qRTJ4Z09aSjB2RUxreUF2?=
 =?utf-8?B?ampJN3Q5VzNDd2V0eHpvcVA3bGR4clREYS9oWHRFU083dkd5NFhjQUYxWHd0?=
 =?utf-8?B?NUcveWJteXp0SnpNN2o0dmlRSFlFV0FaWE5QZGgzYXMrdTY3WW1kc01ZZlh0?=
 =?utf-8?B?WUZjQUdMcGdrcW16WVhDVDdrRGd5dXpkY1NDR1ljUEJWcUZUa1BQTVpjKy9h?=
 =?utf-8?B?Z2Y1dkl4dkRVQ2p2YXF3WDJzTWQ0NXhCekdXUDdRam9DY1A4R05OWVg0cU5B?=
 =?utf-8?B?eXBTTjBndUlJdUYzdGx1eVVrNGo3SHVaZmhzSTFudXQ0WUkxNmh2SkZGdW55?=
 =?utf-8?B?VnJMcTlReldOWjRtWWl4NlpGZDhxMjNIQTlUeHRSc1dJcHhrY3B4d2pLNEw5?=
 =?utf-8?B?dDdqeWFHTG9oRlZVNCttMGJuNEF0WTVGTGxLRnRrQkJjOGFFTmxuWit1eXJD?=
 =?utf-8?B?WHpnR2JTY0NrbUsxckxzL1M2YVZsUm1ZQkVwVDBGRlVlWFNZNHQxRDB3SjZ3?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9693C0A52DC5B04597048738C528B8B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/y3i6Zfvtxy9w4kw8VkjDztOuCED7M5uHphf4AdOJtFFTvAvkW1Kw//MnTQwns7Rs2Leo/YXFNfZHHeeXJ4hAMvbyL/Z6XDku14Pd3HrdfkKg7JwTJnyvo+KHnSeNC5PzD1UiBwFvqA0MVu4iZjjD1SO7cBcTZG/Z/NfBGLBYLxOvatEQopFqnO/XZv5ok45IOuaBsCUzT00YIQ5jKb6fawIG2Vy5uJtr8qs0a5KnVPYlXuJJXTXp3FS8MaG5U8hk/dfsLSHhGSdl6ce+8WSB6tDMik1HG5xlCfJsiuw66RYCuH/hvcXrNBtqQGKGGo6qwGmTzypuCmXF1PR/Wg0RQN9UE2yEmmn9n2oJs+/J7ZEKLaSrpBEflSsSqojqAiB1klgUKw2ckWYhbu4+IZhtbS9twKGWwTMtqfKCQ7cKiuAI8VWGWhB2Is7vSuJSlUpj/ojoiAcGBdawCWN2D5RpxFOvvExE4SRdOpK9paxGFz2UdPDqGqxt5FgfIN80c0Al2ISMcRNhtV380ll9m5IgiY2zi0dQWdk+9ai/oJwV3C59BzV2ZVka8qRkCqWI+L9YkpMTxpPnMDxynHhtLA2mmnqAs/0Uy6oweykNRDprch7rZ/GRbBdBZzAD5d3DoIVNrwjhdVirDLdVpOMgbpLaw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ea9de6-26fa-457a-e73d-08dde745e7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 21:49:18.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eaM0YJ7e+DoVAIONeM93KwkUQfAs0WO00eIljjhoE8EvzJ3JiJ2X/XOqwWu3I/Z7wtw5fva2SFHdL+a5tCTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
X-Proofpoint-GUID: vYWKcP3LhIQdimgApxGC-EP-OkzrERm_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDEwMiBTYWx0ZWRfX3Hye7f9SbXSS
 0fcI0fWpl8yGrT4dNbL7eyzppHjlfnE0KxU8iRU46LScDSvE9UAcq5K2/3YqLhBuUuNVgS4rjzE
 jvpIkhubZsCxTRkJxuEK+zBKdEVvi1M32JeaFXKV0Uh+Cu8JhlbUgsGwEbxvaclX1g7jaaprU4X
 fvSU3tIG9BvXVkDAqO6HSI9ZhlKhuLtYe6sd/ssD5pmW3dzU5Z3UBDdeloOhivf4V0vCS01+ebr
 m/1cLyJ32uk/xkT/+umwqvmU+rNq8hqQb53kgrHm6/gzHt1sD5+TeLh/3cLEoY3BX2RD2TBSEZe
 rx3PWR9mNDAwzHsbuQ+6TarzWR67Jb1vAylRVYh3ev6gF/2VdkXshHZyGvC9noQO/wdzrVupT+T
 d1Wm/q2E
X-Authority-Analysis: v=2.4 cv=aLTwqa9m c=1 sm=1 tr=0 ts=68b22067 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=zd2uoN0lAAAA:8 a=mTfmUnEY1X8FpjWefGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vYWKcP3LhIQdimgApxGC-EP-OkzrERm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250102

T24gVGh1LCBBdWcgMjgsIDIwMjUsIFNyaWthbnRoIENoYXJ5IENoZW5ub2p1IHdyb3RlOg0KPiBU
aGlzIHBhdGNoIGlzIGNyZWF0ZWQgdG8gc3VwcG9ydCBzdXBlciBzcGVlZCBwbHVzIGVuZHBvaW50
IGZvciBJc29jDQo+IHRyYW5zZmVycy4gTm93IHN1cGVyIHNwZWVkIGVuZHBvaW50IGNvbXBhbmlv
biBpcyBhY2NvbXBhbmllZCBieSBzdXBlcg0KPiBzcGVlZCBwbHVzIGVuZHBvaW50IGNvbXBhbmlv
bi4gV2l0aCB0aGlzIGNoYW5nZSB3ZSBjb3VsZCBzZWUgdGhlIElzb2MgSU4NCj4gYW5kIE9VVCBw
ZXJmb3JtYW5jZSByZWFjaGluZyB0byB+NzQ5TUIvc2VjIHdoaWNoIGlzIDk2SyBwZXIgdWZyYW1l
Lg0KPiBUaGUgcGVyZm9ybWFuY2UgbnVtYmVycyBhcmUgY29uZmlybWVkIHRocm91Z2ggTGVjcm95
IHRyYWNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3Jpa2FudGggQ2hhcnkgQ2hlbm5vanUgPHNy
aWthbnRoLmNoYXJ5LWNoZW5ub2p1QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL2Zfc291cmNlc2luay5jIHwgMjMgKysrKysrKysrKysrKysrKysrKystLQ0K
PiAgaW5jbHVkZS91YXBpL2xpbnV4L3VzYi9jaDkuaCAgICAgICAgICAgICAgIHwgIDIgKysNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9zb3VyY2VzaW5rLmMg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9zb3VyY2VzaW5rLmMNCj4gaW5kZXggYTNh
NjkxNjZjMzQzLi43OWVmYjYyOTU3MjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi9mX3NvdXJjZXNpbmsuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vZl9zb3VyY2VzaW5rLmMNCj4gQEAgLTIzMiw2ICsyMzIsMTIgQEAgc3RhdGljIHN0cnVj
dCB1c2Jfc3NfZXBfY29tcF9kZXNjcmlwdG9yIHNzX2lzb19zb3VyY2VfY29tcF9kZXNjID0gew0K
PiAgCS53Qnl0ZXNQZXJJbnRlcnZhbCA9CWNwdV90b19sZTE2KDEwMjQpLA0KPiAgfTsNCj4gIA0K
PiArc3RhdGljIHN0cnVjdCB1c2Jfc3NwX2lzb2NfZXBfY29tcF9kZXNjcmlwdG9yIHNzcF9pc29f
c291cmNlX2NvbXBfZGVzYyA9IHsNCj4gKwkuYkxlbmd0aCA9CQlVU0JfRFRfU1NQX0lTT0NfRVBf
Q09NUF9TSVpFLA0KPiArCS5iRGVzY3JpcHRvclR5cGUgPQlVU0JfRFRfU1NQX0lTT0NfRU5EUE9J
TlRfQ09NUCwNCj4gKwkuZHdCeXRlc1BlckludGVydmFsID0JY3B1X3RvX2xlMzIoMTAyNCksDQoN
CldoeSBzZXQgdGhlIGR3Qnl0ZXNQZXJJbnRlcnZhbCBhbmQgd0J5dGVzUGVySW50ZXJ2YWwgd2hl
biB0aGV5IHdpbGwgYmUNCm92ZXJ3cml0dGVuIG9uIGJpbmQgbGF0ZXI/DQoNCj4gK307DQo+ICsN
Cj4gIHN0YXRpYyBzdHJ1Y3QgdXNiX2VuZHBvaW50X2Rlc2NyaXB0b3Igc3NfaXNvX3NpbmtfZGVz
YyA9IHsNCj4gIAkuYkxlbmd0aCA9CQlVU0JfRFRfRU5EUE9JTlRfU0laRSwNCj4gIAkuYkRlc2Ny
aXB0b3JUeXBlID0JVVNCX0RUX0VORFBPSU5ULA0KPiBAQCAtMjUwLDYgKzI1NiwxMiBAQCBzdGF0
aWMgc3RydWN0IHVzYl9zc19lcF9jb21wX2Rlc2NyaXB0b3Igc3NfaXNvX3NpbmtfY29tcF9kZXNj
ID0gew0KPiAgCS53Qnl0ZXNQZXJJbnRlcnZhbCA9CWNwdV90b19sZTE2KDEwMjQpLA0KPiAgfTsN
Cj4gIA0KPiArc3RhdGljIHN0cnVjdCB1c2Jfc3NwX2lzb2NfZXBfY29tcF9kZXNjcmlwdG9yIHNz
cF9pc29fc2lua19jb21wX2Rlc2MgPSB7DQo+ICsJLmJMZW5ndGggPQkJVVNCX0RUX1NTUF9JU09D
X0VQX0NPTVBfU0laRSwNCj4gKwkuYkRlc2NyaXB0b3JUeXBlID0JVVNCX0RUX1NTUF9JU09DX0VO
RFBPSU5UX0NPTVAsDQo+ICsJLmR3Qnl0ZXNQZXJJbnRlcnZhbCA9CWNwdV90b19sZTMyKDEwMjQp
LA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKnNz
X3NvdXJjZV9zaW5rX2Rlc2NzW10gPSB7DQo+ICAJKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFk
ZXIgKikgJnNvdXJjZV9zaW5rX2ludGZfYWx0MCwNCj4gIAkoc3RydWN0IHVzYl9kZXNjcmlwdG9y
X2hlYWRlciAqKSAmc3Nfc291cmNlX2Rlc2MsDQo+IEBAIC0yNjQsOCArMjc2LDEwIEBAIHN0YXRp
YyBzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICpzc19zb3VyY2Vfc2lua19kZXNjc1tdID0g
ew0KPiAgCShzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZzc19zaW5rX2NvbXBfZGVz
YywNCj4gIAkoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmc3NfaXNvX3NvdXJjZV9k
ZXNjLA0KPiAgCShzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZzc19pc29fc291cmNl
X2NvbXBfZGVzYywNCj4gKwkoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmc3NwX2lz
b19zb3VyY2VfY29tcF9kZXNjLA0KPiAgCShzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICop
ICZzc19pc29fc2lua19kZXNjLA0KPiAgCShzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICop
ICZzc19pc29fc2lua19jb21wX2Rlc2MsDQo+ICsJKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFk
ZXIgKikgJnNzcF9pc29fc2lua19jb21wX2Rlc2MsDQo+ICAJTlVMTCwNCj4gIH07DQo+ICANCj4g
QEAgLTQyMyw3ICs0MzcsNyBAQCBzb3VyY2VzaW5rX2JpbmQoc3RydWN0IHVzYl9jb25maWd1cmF0
aW9uICpjLCBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiAgCSAqLw0KPiAgCXNzX2lzb19zb3Vy
Y2VfZGVzYy53TWF4UGFja2V0U2l6ZSA9IHNzLT5pc29jX21heHBhY2tldDsNCj4gIAlzc19pc29f
c291cmNlX2Rlc2MuYkludGVydmFsID0gc3MtPmlzb2NfaW50ZXJ2YWw7DQo+IC0Jc3NfaXNvX3Nv
dXJjZV9jb21wX2Rlc2MuYm1BdHRyaWJ1dGVzID0gc3MtPmlzb2NfbXVsdDsNCj4gKwlzc19pc29f
c291cmNlX2NvbXBfZGVzYy5ibUF0dHJpYnV0ZXMgPSBVU0JfRFRfU1NQX0lTT0NfQ09NUCB8IHNz
LT5pc29jX211bHQ7DQo+ICAJc3NfaXNvX3NvdXJjZV9jb21wX2Rlc2MuYk1heEJ1cnN0ID0gc3Mt
Pmlzb2NfbWF4YnVyc3Q7DQo+ICAJc3NfaXNvX3NvdXJjZV9jb21wX2Rlc2Mud0J5dGVzUGVySW50
ZXJ2YWwgPSBzcy0+aXNvY19tYXhwYWNrZXQgKg0KPiAgCQkoc3MtPmlzb2NfbXVsdCArIDEpICog
KHNzLT5pc29jX21heGJ1cnN0ICsgMSk7DQo+IEBAIC00MzIsMTIgKzQ0NiwxNyBAQCBzb3VyY2Vz
aW5rX2JpbmQoc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpjLCBzdHJ1Y3QgdXNiX2Z1bmN0aW9u
ICpmKQ0KPiAgDQo+ICAJc3NfaXNvX3NpbmtfZGVzYy53TWF4UGFja2V0U2l6ZSA9IHNzLT5pc29j
X21heHBhY2tldDsNCj4gIAlzc19pc29fc2lua19kZXNjLmJJbnRlcnZhbCA9IHNzLT5pc29jX2lu
dGVydmFsOw0KPiAtCXNzX2lzb19zaW5rX2NvbXBfZGVzYy5ibUF0dHJpYnV0ZXMgPSBzcy0+aXNv
Y19tdWx0Ow0KPiArCXNzX2lzb19zaW5rX2NvbXBfZGVzYy5ibUF0dHJpYnV0ZXMgPSBVU0JfRFRf
U1NQX0lTT0NfQ09NUCB8IHNzLT5pc29jX211bHQ7DQoNCkRvbid0IGF1dG9tYXRpY2FsbHkgc2V0
IFVTQl9EVF9TU1BfSVNPQ19DT01QIGlmIGRldmllYyBpcyBub3QgY29ubmVjdGVkDQppbiBTU1Au
IHByb2JhYmx5IG5lZWQgdG8gY3JlYXRlIGEgc2VwYXJhdGUgc2V0IG9mIGRlc2NyaXB0b3JzIGZv
ciBTU1AuDQoNCj4gIAlzc19pc29fc2lua19jb21wX2Rlc2MuYk1heEJ1cnN0ID0gc3MtPmlzb2Nf
bWF4YnVyc3Q7DQo+ICAJc3NfaXNvX3NpbmtfY29tcF9kZXNjLndCeXRlc1BlckludGVydmFsID0g
c3MtPmlzb2NfbWF4cGFja2V0ICoNCj4gIAkJKHNzLT5pc29jX211bHQgKyAxKSAqIChzcy0+aXNv
Y19tYXhidXJzdCArIDEpOw0KPiAgCXNzX2lzb19zaW5rX2Rlc2MuYkVuZHBvaW50QWRkcmVzcyA9
IGZzX2lzb19zaW5rX2Rlc2MuYkVuZHBvaW50QWRkcmVzczsNCj4gIA0KPiArCXNzcF9pc29fc291
cmNlX2NvbXBfZGVzYy5kd0J5dGVzUGVySW50ZXJ2YWwgPSBzcy0+aXNvY19tYXhwYWNrZXQgKg0K
PiArCSAgKHNzLT5pc29jX211bHQgKyAxKSAqIChzcy0+aXNvY19tYXhidXJzdCArIDEpICogVVNC
X0xBTkVfU1BFRURfTUFOVElTU0FfR0VOMl9CWV9HRU4xOw0KPiArCXNzcF9pc29fc2lua19jb21w
X2Rlc2MuZHdCeXRlc1BlckludGVydmFsID0gc3MtPmlzb2NfbWF4cGFja2V0ICoNCj4gKwkgIChz
cy0+aXNvY19tdWx0ICsgMSkgKiAoc3MtPmlzb2NfbWF4YnVyc3QgKyAxKSAqIFVTQl9MQU5FX1NQ
RUVEX01BTlRJU1NBX0dFTjJfQllfR0VOMTsNCj4gKw0KDQpNaXNzaW5nIGNwdV90b19sZSogZW5k
aWFuIGNvbnZlcnNpb25zLg0KDQo+ICAJcmV0ID0gdXNiX2Fzc2lnbl9kZXNjcmlwdG9ycyhmLCBm
c19zb3VyY2Vfc2lua19kZXNjcywNCj4gIAkJCWhzX3NvdXJjZV9zaW5rX2Rlc2NzLCBzc19zb3Vy
Y2Vfc2lua19kZXNjcywNCj4gIAkJCXNzX3NvdXJjZV9zaW5rX2Rlc2NzKTsNCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdWFwaS9saW51eC91c2IvY2g5LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdXNi
L2NoOS5oDQo+IGluZGV4IDgwMDMyNDNhNDkzNy4uMjI3ODJjNWNiMmYzIDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL3VhcGkvbGludXgvdXNiL2NoOS5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51
eC91c2IvY2g5LmgNCj4gQEAgLTcwMiw2ICs3MDIsOCBAQCBzdHJ1Y3QgdXNiX3NzcF9pc29jX2Vw
X2NvbXBfZGVzY3JpcHRvciB7DQo+ICB9IF9fYXR0cmlidXRlX18gKChwYWNrZWQpKTsNCj4gIA0K
PiAgI2RlZmluZSBVU0JfRFRfU1NQX0lTT0NfRVBfQ09NUF9TSVpFCQk4DQo+ICsjZGVmaW5lIFVT
Ql9EVF9TU1BfSVNPQ19DT01QCQkJKDEgPDwgNykgLypzdXBwb3J0IGZvciBTU1AgSVNPQyBFUCBD
T01QKi8NCg0KUHV0IHRoaXMgdW5kZXIgYm1BdHRyaWJ1dGVzDQoNCj4gKyNkZWZpbmUgVVNCX0xB
TkVfU1BFRURfTUFOVElTU0FfR0VOMl9CWV9HRU4xICAgIDINCg0KVGhlcmUncyBubyBHRU4yX0JZ
X0dFTjEuIFRoZXJlJ3MgR2VuMngxLiBBbHNvIGxhbmUgc3BlZWQgbWFudGlzc2EgaXMgbm90DQoy
IGZvciBHZW4yeDEuIFdoYXQgeW91IHByb2JhYmx5IHdhbnRlZCB0byBwdXQgaXMgcHJvYmFibHkg
Z2VuIHZhbHVlDQptdWx0aXBseSBieSBsYW5lIGNvdW50Pw0KDQpCUiwNClRoaW5oDQoNCj4gIA0K
PiAgLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8NCj4gIA0KPiAtLSANCj4gMi4yNS4xDQo+IA0KDQpCUiwN
ClRoaW5o

