Return-Path: <linux-kernel+bounces-780840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DCB309F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8396022D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23A2E1F0B;
	Thu, 21 Aug 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UUByNlkO";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PtRLkpZv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ShjNBxb7"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F1224B1B;
	Thu, 21 Aug 2025 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818812; cv=fail; b=sd4bpXYP6FXORjYJpZspxJeG4jjJERwE0o41KXSD0sLPcq7T1vYzMiwEE1TQ6oBgsgNP3s5JzzY/fuUcyjOZV9/8NwE1CpDUObN4yz/uXh2STQy8+17SzYkq08GJ80ppHctn7kXS6hXUrwJS/1T8GLOpa923YqiSVlRcDn4KxyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818812; c=relaxed/simple;
	bh=IAcSaCsqP+xNDijQ/WfUJifB15IsbaT9axxHGhO1wAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRvslkF9dMHGEdLJq70fnt5Ixo8QQ1IUf3jYHzWeMqc6A0w/38vwC9tL5MiI3mhzdJs4NzGgju0r6hqfFnz4gRspMZj7GiSq0s9BfOsHSIAV1YU/5ZYXE4UncL+yzgR+J32hq6SahHnz94qee/JsglYKTdSdpM4loyubrHAzDD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UUByNlkO; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PtRLkpZv; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ShjNBxb7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LNMKPX007842;
	Thu, 21 Aug 2025 16:26:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=IAcSaCsqP+xNDijQ/WfUJifB15IsbaT9axxHGhO1wAM=; b=
	UUByNlkODYCJa5HNLgMbtlgqGYS6BCkvYeXxuucXN6yqljsZEsz9gE2nWTWtAz6f
	8/Ee5T3cly52IpmaDRSpqnmHsF/EaF6W6dUI1Wh7EKKEYHmdB80HfDfqkepdfu9Z
	E3OeSTCnYIZdp8ps0drgS3RtzlC0nmD44c0kkgkBQg1aAWv/sVZzRGCBuC0vw1rW
	WdUcpXqX+dJr1rlbYbqsBAerlfmt90dMNooeDMxJnw8ciETvN+teZKRRUcsfs+rL
	qgWmjjk2gFJhgtAEGvNprZucBq0jnBIcqV8OMqaEdovlGvSQzR/JHLThHvsywN1Q
	cSoXHl1+B0He6t8WA5NDqA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48p2grb6cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1755818761; bh=IAcSaCsqP+xNDijQ/WfUJifB15IsbaT9axxHGhO1wAM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PtRLkpZvmnoWMtVNq3AsVdu989Qcv7bKChZ3E/txqFqwmRPSW5JDuhFOKjwNVOoJR
	 z/6Cdn8Ewb80tDJQXPywsWxU1vw1cVlFrAJ0O1TScupk7aGMcoXQHWNioK9CFhT5k5
	 EtcaRPebW4dZub75LiZAF2vKUYYMoKPOe3Sz0W18fbrv7khB9gmqZvrDCVK5sQVnx8
	 Kqhy0DRSSHTi6SvUhPGP4lDg81mNtylMLAZmiuPSaRanEGvJCweu44er7dvxyuP8DF
	 PWboJqM/yRb4zP3Wp6X+0RxNVj6Pwyz0XHFIem3HJ07e5bSXoek3y0ENAyetn4o1VS
	 TkIgD0v7sMQAg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 55F2F4035C;
	Thu, 21 Aug 2025 23:26:01 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 64596A0073;
	Thu, 21 Aug 2025 23:26:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ShjNBxb7;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9552E40174;
	Thu, 21 Aug 2025 23:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=me4L6qqVOUR7aiZkCmkCfMb5o6126Nzm88Fts88uLmoOuBDXKs6QRSWVhRPvxmTNjBfdYDsgbuXMEf39XKOPHz8Xn5gkCeQ8bmvap9/P0oI1aioB+WnpPiLphGmVZ6kijXsWWpL7PYbHpGKnUviEdBTLBzlMBrb03HWempvQIrCyhCbYEoAKzoHvS7VfnDxg0VUYwjJoyDNm1ZFh/MVGDAoGC+G0aMgxuCVs5ORUSWsy4+Qw36vthEtcotVmy9zLWYZ13WnAisA+vudV8E3uNcpR09iEWMlAEPNEJA4NiBKFUzZGvLamAfS6nF3Q+gA7n24UFtm243WlYvChNwGcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAcSaCsqP+xNDijQ/WfUJifB15IsbaT9axxHGhO1wAM=;
 b=Gquxot+yPIogigIW0di61/wFVDi6D/iDePZNGuCYjFpIfkbWtPP+Qq9JP8MRSWWLmOj8XLdCxNEg6iGcsOAT8sueufO7X9/sYxsDsK3/Ove9106BZJunQCzUJJEDlJ3a+TqS79VHdWshmYDHJIf3qdOTblpeIZIkTzdHMtx0ErHM1HGe8Z20VjYffWQKGbQyKRgviLeWQK5WPAhAIQq0fbmHryk8QPmEFVq0Hk4x3J1KoPVF4g4dfeXEenWzEr7O/m92V+rWZGhnNYVRyp5teNXARfA8FjI2py2p6Pnl/Nw9shQpCXK5orVDAaP/ay67qxAybiFl4ed9Xu4Fb83V+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAcSaCsqP+xNDijQ/WfUJifB15IsbaT9axxHGhO1wAM=;
 b=ShjNBxb7HW8cw2Lcm9hVsRlkL1Jsa0BmtO1PVCPaZEBNM1H4yljYtGxtrzKvf0M4RonF6FbsUDRoirEpCyUrpdGEwYaGauXzIvLkFgHOWpNvdvNENrx1A20S42Zx/gI06iMX+zs/IG0udRNMjWuFUNuDlrwdsscIuDzj66xcHwQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 23:25:52 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 23:25:51 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Sven Peter <sven@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH RFC 04/22] usb: dwc3: apple: Reset dwc3 during role
 switches
Thread-Topic: [PATCH RFC 04/22] usb: dwc3: apple: Reset dwc3 during role
 switches
Thread-Index: AQHcErHjYWp/DJLz50yFjSgGSmwaTbRtwHSA
Date: Thu, 21 Aug 2025 23:25:51 +0000
Message-ID: <20250821232547.qzplkafogsacnbti@synopsys.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-4-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-4-172beda182b8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7305:EE_
x-ms-office365-filtering-correlation-id: b2af6a2b-0bd8-44c4-0d21-08dde10a11b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjluRjZuMUkrQzIvdEZzL09taDA3VXRiaCtUYUJGaEIrQWxXKzNSY3NLQ1Jq?=
 =?utf-8?B?dGpibTNrOStzN1B4VHpEd3gzTitLOHFyYjRPZDRidDdZL1VhVnZ2TzNJZU56?=
 =?utf-8?B?b0liZnB5cVNBTFdRaTY1Qm90NVVlclJaQm9JOWRuSFpGSlVaQkxGOTZQM2E2?=
 =?utf-8?B?d2lYVlM1VUF6bWEzMUpzL1BFVytVaEdqOVNLY2diRVBCVEF3b0ZFK0tkVDNq?=
 =?utf-8?B?R0luK2NEUjNWWGJQNEhHeVJrYWtFNkFreEs5d01HR2QyK1gvMnloMU0zdE1j?=
 =?utf-8?B?VjFrSzZSUTI0ckt1VGx3VEErSEhkOW1BNGdZUDNMbFg1eWZPakJWZmxiZFNS?=
 =?utf-8?B?bUpJMVlwSDN1RTY1UzdxYjFQTlRHaWZ5Q0pRQnBxa0VBOHpoZ01mamRVU0Qr?=
 =?utf-8?B?RTFSRWNScUxKYTJ5Mi9aaDdUSGhwVjVVRTFyeEcyYXNGMkozdnRNSGprdTR1?=
 =?utf-8?B?NFNXMDVGdnY1ZWN0VGo4dFdXYi95cjV2OXNYS21WTWxzaHR4SnJHTU9WMGhl?=
 =?utf-8?B?RkpYaEtmVkw3UEljYVloTXdQVUp3eWdMbnc3NFBFbzNXSEpQdWV3d01qU1dV?=
 =?utf-8?B?SXJIdC9JQ2xyODdzWGM4cXBSMGhGRno3cjZDN0JFMHBKcFBjYVVEcGZvbzJE?=
 =?utf-8?B?d2doK1pWdkxlamNWV3ppaW55YnRCcDcwM1FJdlE0RGRhSzRzaFF5cm85TDlM?=
 =?utf-8?B?SWhOUDk3MzFORUFDOHFOVnJUc3BKUmVjelp3bGpwZDNoZEJIMHlQZ2d1MzZF?=
 =?utf-8?B?NFJVZThwaDUrVDgvM0NTRGZhOU5yQ3R5TEpsV0FESEdEVnpRQlZuZU9PWndk?=
 =?utf-8?B?Sk9PanZUb0N0UHZNUUdqeWIrQWNTSU1MUFBhb3Z2Y1Q2bjF4dmt5a2lFMlVL?=
 =?utf-8?B?K3FXdUFDVmxQRU15R2dQWkFwY0p4TURtU1FVQS9rNTBDQjJkelJvTGtJNkhN?=
 =?utf-8?B?U2poaGdnM1RINzZTcWs5OTFTYnhTaEFKSklOWExiWjVwS0RHMG9pTEYrM0ky?=
 =?utf-8?B?MW1kbFZBd3ZBd3czU21VOEw4dTNKb2kvQUwzYkZPeEc2dER6M2NucndpQ3VR?=
 =?utf-8?B?WjlqZVpFaXJ6RXhZd2N4SkFRKzJRT3R5Y1kxdFphRlZyZHA1VEdHL0U3SXI2?=
 =?utf-8?B?S1RmTnYvSG1tYlE3QjRMWWIrMHdZOW1LaUJ0Unora3dQK29sR2xNK2xoMFI4?=
 =?utf-8?B?a1o0Yk5GMzdtVUNQRzZmVmR1dk81R09IdXp0cFNScE5GemRoNUFRVVRHQlZN?=
 =?utf-8?B?UlpTUkFNdjFXeXY0Y2I2cFl5MFRBWHVETFFtbFNBS3dsSXZvb0hWbUxHdHRC?=
 =?utf-8?B?TVRTeU5rMlJ2clgwM0JpRU9NZjJyVmFHbUw4ejBXeE1kV21YdWFwT1F6WEhn?=
 =?utf-8?B?RDFTRjdRVzZ5djNTci9weEFLSDVaZzA4aStweFNicHVsR0hqaHBkWmtkU2VF?=
 =?utf-8?B?TTh3a1Ara2ZVVEQ1aEtrRFFaZnQ0am1kcGMwZEJLSlZtN1RodmwrMEdhaWVr?=
 =?utf-8?B?cU9yOWRHWEJ3UE5ZeXpPdkw5WjUrenpKbDFra1RNTFJnT24yUDkyTTYveWlq?=
 =?utf-8?B?WVozVXFwQmhMd0FVMnB5RVliRUxiNGExLzF6aThMVFBDVHlabXkwa1dTYUxH?=
 =?utf-8?B?ZEdPMDBBby9SSkRJRENHdUhvQkhoZHZXMzZyZ0JqbmQrS0lQT0ZmN3VEYTFO?=
 =?utf-8?B?Ri9hdWtPZE5RcmkyOWtPWERUbEhYZEhyWDhOeENvNUZrZ09rRjZnUkxHR0U5?=
 =?utf-8?B?bVFaOUpVRFRRQ3NLM2JzdHZESldCM0tlcVY4YzgzTzZnbmtLSjh2b3ZYbEVD?=
 =?utf-8?B?cnkwcjIzSXZnREZwQ1A3RVVFa05FbUYvdmJZMDltQ2tHcE94Z1p2TGZxSUdp?=
 =?utf-8?B?NTVOUVBMZW1iQjFQZTU3RFZUL25JekRRODlRemx1QS9XNlZYa3p3bVJ6NWMz?=
 =?utf-8?B?RGZKMWMyL2Q0L25ySldOUU5RT3RweUN0d2dsZ09qV3M5WlAzNE9rckI0YkE1?=
 =?utf-8?Q?VnFBDMpiz+US3uI3jh64C1ZyTAr4yk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTRhNjdHUTN2QmNvZk1lV3hZcEp0SkEyRkZaUHkzUzFPM0lWWnVoeHVlN3Fu?=
 =?utf-8?B?eGJnTGY2dzNLcG9WdXh4K2laVXR5d3VjcloxMU9LOEt0S2p2YnZMMzVJdVRi?=
 =?utf-8?B?bFRGeCs4bXhFSFQ4N0dodFBMcHJiblZ0TkJodXNOSXRSN3ZwcDJ1dnpZU1l3?=
 =?utf-8?B?S3kzZGNjay9LZ0JGNHJiR0svSERrcFNCWXk5N1R0azlLWTFOUWxKZGVWU0xl?=
 =?utf-8?B?cE1malRwYmFJbEZyR3ljNGlZWE5GM1Q4QWVPN2lFUnVTREx1Unp6NkRGY2Rs?=
 =?utf-8?B?NUMzTEVPVDJJdENpYm9TdFJlUEpzai9hTW5lTnloWERWamtZb2tsSmFJQmdj?=
 =?utf-8?B?a2FDbFhsb1hmOXV5MTJBcnpEVnJYeEhZd1FOZ0xid2N4dGtxUTcvRlpyL29Z?=
 =?utf-8?B?aGxzWXZ1SEdGZCtDRjVnK3JwdUlNQndFNm1hQWI2N2NKbFIxSEhuNWY4aXor?=
 =?utf-8?B?TmNBcFJGNGgrZ0VzemdjZkQ5YklDSUk3NUk4bjQra0pEUkdibThnU1lJRGxK?=
 =?utf-8?B?VU1zVFdaQmtSeCt1eWt5dStnMHJxZXBFdS84OVl0TjRXREdRY2RhQnFzdXlt?=
 =?utf-8?B?UjFjNVVmWVlDQTJpY0c1NU5GNzFseEQ1QjlDaStwdHZzYnB5M1R6SjdBSnhY?=
 =?utf-8?B?NFJZNlJSeDEzMXkreWc1T2pEWXNWciswMFRLRTN2cTI5NlBGNE5OWHVSTlFn?=
 =?utf-8?B?Umduam5WTGY2RGNCdTlpa25mY2pDbWRzMXVJbnVTT0dEUS9ld2tEZlNwNGg3?=
 =?utf-8?B?aDdXZEttTVF5MkpnQ3MxSGxGMnF4ZjdYbXFnU2phNDJOL1hua0VCSlo5M0Fr?=
 =?utf-8?B?anFIcXRTVEJVM3NteUo1SHRCeHFaZmhSSVFpWUhCU1RMQ2FYaEt1bVBzQ083?=
 =?utf-8?B?U1NBN0twNnl5TXlKRXVENGdKUEhSN0xZSjNsamVtbVA5Q0pYS0ZnZmQ0NUxt?=
 =?utf-8?B?eUxRTTJ2UU40Zk51SG1tVkxjQUJ2MDN4S0dabmpBUnhpYm9taGdBT1p0QWMv?=
 =?utf-8?B?V1A5YUhLNitPYlV5b3ZwR2FjcUs4ekNmZkhyV05NWEZacWJ4bW91bmxUbStl?=
 =?utf-8?B?WERKT0ZDa0lhMWNHNXg3NFZKSTlia3NJZDYveGx6Y0VnamVDMyt0UTQ5M1FT?=
 =?utf-8?B?ZWMvL0V0dVFKQ2FId3llSjRoaEpxcUkra2FhV2psUWZvcWV2ZUlHMnRlMldW?=
 =?utf-8?B?QVJoSkdlQVdRMlhub3YrQ2czWEhUV2NnVVhrTzJlTVdnK2dCQTlkdXl1M0ZJ?=
 =?utf-8?B?bVoxSUV4aWtWWlJPVXoyL1VUMkc1VUEvWUIvL2RwOGloL3V6bGlIUWt5ck1j?=
 =?utf-8?B?UFJiZXpxNk9sTVhQZHowVThBR21jZEQwYTBEWnRraStLbjNBVmV3bTQ0TE9z?=
 =?utf-8?B?NW5kQUhaRkt3RWpDZDlmdlZ2b09iUUpmZzJkUTNUc09jZ004V2p0NG5wY1Zx?=
 =?utf-8?B?VG1IUGhHYmttSjdXMDhFV2t1dlM1Z0Y4WWhPSWM1RTE1TStDNW9CajRFVHJ0?=
 =?utf-8?B?aFVLUjdWeHQ2SS8zNmR6M2J6RGtSd3Z5TlZUeHFDVTVsVXNmZmlHSjU4ZzJ3?=
 =?utf-8?B?QnVZTUpXNW5CWG9Nczh4TWwrdTFrRUN2MzZzYVpsd2pGanlHREtzc0pMNXB5?=
 =?utf-8?B?ckJhazk0SHoxcXZpVUowRXY3TTVMMFJHSUIwRk51aTd6Z0piWXpwQmxPSmJj?=
 =?utf-8?B?STFVWGtqMzRrNlBEVzU1SHlHemFJd0d2cVZJcG5CWWVjaG1sWUlvUnB5YkpK?=
 =?utf-8?B?ZGswcFovOERXUkYyd290a0kvUndQc0wxeUxDT0M1OEJKM0lJSzJKVXJkREVo?=
 =?utf-8?B?WTV5R1dXbUJHUHBvbU1zZk5CaE1qRis1NHc4M2VjYU42bXRoRlMxU291UmMr?=
 =?utf-8?B?YUJGQjVFRkxwdTErdFhMMjUrZ1JSK3J5dHhFa1ZjRENaT1lSL295OWt3ekpk?=
 =?utf-8?B?K1E3NzJYRVRMUlA5ZUZVOU5yOU43NWRhMnVMZzlDalhaSEpjZ2RKYmljckdS?=
 =?utf-8?B?Y3RwVlBuaVB5LzRQQW9tTXFJSmZqZVJZVG5tOEJDRUpxNmtmcHB2RkVnY2JQ?=
 =?utf-8?B?UVJTRjhhREFWcXlqYkZHRVl6ekQzTDM5OGxPcXV0UDllZVhGMEUyUDZaWW10?=
 =?utf-8?Q?U/yfBGeN3RoWuyxJqV2I5+z5z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A021A47C537F241BD8888112D69BB6D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MsptWtOjL77r4X9zzildxPYhp8W6y7aWO35oEPoXECihAI2cSugO+MxXlNNi3aClDwilhonnbFNDmioJoonYlkp5bZU2fybqJHfAntYrCdXX+DiqpWagRXNyr9gN6Hu/b0GzryjZ01e87CgDwAmHSKLUbcXUF8eZNCNdSPtFjdB9/PdZjNgyVm/bCN/0BilXfBHgoDQMPSMRTrhhGvV/Cl1WqLUkmlly1aD/v0lT8ZcSY4pOfiC1iyslNtK3Lt+qG01S2vfnzhv3zgMcbhkUswbYbxuDj6Oc3Xdc06x/wcS8AEKd8RdFnbbe2gnhffG5FBut7vaAvooZwx9DGcPLNrFDnpRU1j1DEpsDG42KbJY16H+wXzULRoBaUIUDGNUEQM62Lo8FP6zNnG/2A3YGJhua5zOeDibtg8kuXO07GorXXyfCQG6gLzEi7vPXfwZG0mmAzdH6RUyEMSDG5WPApZgk+QTNfTQl3334ZykhT7QSItjcM/fFw/XeH287bt4St9rTM4FdY6cwAYD36J/vCER9+qP9i+QmzYA6ehT2QVJke/vnFqM9yBiqjG5osUtaMl91Pq1JQOscKKEK6Rcq3luuJ4O3fpd2voXEtcmRN15MusC8fR5OYDVEQI2rfndOsbFfUTazOvxdJXFP7hD4rw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2af6a2b-0bd8-44c4-0d21-08dde10a11b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 23:25:51.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mu782q+kVIfvfgBvNG8HCdL4YApsa1tELCqbkzFNm/VwA63qlyzVvTmZRkrWVMKldzicEOQjgwbo0mjogfa+QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
X-Proofpoint-GUID: yZX6qioDCfr2yKUuz2jYYJ0knf42WL8I
X-Proofpoint-ORIG-GUID: yZX6qioDCfr2yKUuz2jYYJ0knf42WL8I
X-Authority-Analysis: v=2.4 cv=SOEblOvH c=1 sm=1 tr=0 ts=68a7ab0a cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=SwCho7sAO_BpSnubJl4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA5MCBTYWx0ZWRfX0Sg9YRN9OPki
 0cgUhS1+57p9VfXBcY4iMeJAETJ/W1b8Hxf25bssDMc7Q8hLr0Nn8o2iDkGNRPn8dSuszYMEWw1
 7Q4FIxtPkbhh2vAVz+k9aN44Uu6Bzk2mWXx1WyGi6fmP7cX8EiOCqZLbR2qFO2WdwwqgVltICgc
 yqK855/GwhMhBFK8kGKjh+4MlVvb1KjNzhHS/899tqbhOsgmctQoQQGFgZ3uLUp8hPtdQff9vnk
 m/AagSzu8Ea/E/2jzYdVzztGg3yss94zKFcjXpd6M/RwH2xH3JQNdne2Njd7B0izMdGkDrlhbfD
 RouiVvUf+z5PX0PH4JtnEn6UDxShWM9aHjkH65gMSHItGw0ovzBq8QyFkBD4o9fBQEOdLYPtbLN
 8ui1Kn3AA1CGbaecdsGZcmbMPu/y+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2508110000 definitions=main-2508210090

T24gVGh1LCBBdWcgMjEsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IEFzIG1hZCBhcyBpdCBz
b3VuZHMsIHRoZSBkd2MzIGNvbnRyb2xsZXIgcHJlc2VudCBvbiB0aGUgQXBwbGUgTTEgbXVzdCBi
ZQ0KPiByZXNldCBhbmQgcmVpbml0aWFsaXplZCB3aGVuZXZlciBhIGRldmljZSBpcyB1bnBsdWdn
ZWQgZnJvbSB0aGUgcm9vdA0KPiBwb3J0IG9yIHdoZW4gdGhlIFBIWSBtb2RlIGlzIGNoYW5nZWQu
DQo+IA0KPiBUaGlzIGlzIHJlcXVpcmVkIGZvciBhdCBsZWFzdCB0aGUgZm9sbG93aW5nIHJlYXNv
bnM6DQo+IA0KPiAgIC0gVGhlIFVTQjIgRCsvRC0gbGluZXMgYXJlIGNvbm5lY3RlZCB0aHJvdWdo
IGEgc3RhdGVmdWwgZVVTQjIgcmVwZWF0ZXINCj4gICAgIHdoaWNoIGluIHR1cm4gaXMgY29udHJv
bGxlZCBieSBhIHZhcmlhbnQgb2YgdGhlIFRJIFRQUzY1OTh4IFVTQiBQRA0KPiAgICAgY2hpcC4g
V2hlbiB0aGUgVVNCIFBEIGNvbnRyb2xsZXIgZGV0ZWN0cyBhIGhvdHBsdWcgZXZlbnQgaXQgcmVz
ZXRzDQo+ICAgICB0aGUgZVVTQjIgcmVwZWF0ZXIuIEFmdGVyd2FyZHMsIG5vIG5ldyBkZXZpY2Ug
aXMgcmVjb2duaXplZCBiZWZvcmUNCj4gICAgIHRoZSBEV0MzIGNvcmUgYW5kIFBIWSBhcmUgcmVz
ZXQgYXMgd2VsbCBiZWNhdXNlIHRoZSBlVVNCMiByZXBlYXRlcg0KPiAgICAgYW5kIHRoZSBQSFkv
ZHdjMyBibG9jayBkaXNhZ3JlZSBhYm91dCB0aGUgY3VycmVudCBzdGF0ZS4NCj4gDQo+ICAgLSBJ
dCdzIHBvc3NpYmxlIHRvIGNvbXBsZXRlbHkgYnJlYWsgdGhlIGR3YzMgY29udHJvbGxlciBieSBz
d2l0Y2hpbmcNCj4gICAgIGl0IHRvIGRldmljZSBtb2RlIGFuZCB1bnBsdWdnaW5nIHRoZSBjYWJs
ZSBhdCBqdXN0IHRoZSB3cm9uZyB0aW1lLg0KPiAgICAgSWYgdGhpcyBoYXBwZW5zIGR3YzMgYmVo
YXZlcyBhcyBpZiBubyBkZXZpY2UgaXMgY29ubmVjdGVkLg0KPiAgICAgQ09SRVNPRlRSRVNFVCB3
aWxsIGFsc28gbmV2ZXIgY2xlYXIgYWZ0ZXIgaXQgaGFzIGJlZW4gc2V0LiBUaGUgb25seQ0KPiAg
ICAgd29ya2Fyb3VuZCBpcyB0byB0cmlnZ2VyIGEgaGFyZCByZXNldCBvZiB0aGUgZW50aXJlIGR3
YzMgY29yZSB3aXRoDQo+ICAgICBpdHMgZXh0ZXJuYWwgcmVzZXQgbGluZS4NCj4gDQo+ICAgLSBX
aGVuZXZlciB0aGUgUEhZIG1vZGUgaXMgY2hhbmdlZCAodG8gZS5nLiB0cmFuc2l0aW9uIHRvIERp
c3BsYXlQb3J0DQo+ICAgICBhbHRlcm5hdGUgbW9kZSBvciBVU0I0KSBkd2MzIGhhcyB0byBiZSBz
aHV0ZG93biBhbmQgcmVpbml0aWFsaXplZC4NCj4gICAgIE90aGVyd2lzZSB0aGUgVHlwZS1DIHBv
cnQgd2lsbCBub3QgYmUgdXNhYmxlIHVudGlsIHRoZSBlbnRpcmUgU29DDQo+ICAgICBoYXMgYmVl
biByZXNldC4NCj4gDQo+IEFsbCBvZiB0aGlzIGNhbiBiZSBlYXNpbHkgd29ya2VkIGFyb3VuZCBi
eSByZXNwZWN0aW5nIHRyYW5zaXRpb25zIHRvDQo+IFVTQl9ST0xFX05PTkUgYW5kIG1ha2luZyBz
dXJlIHRoZSBleHRlcm5hbCByZXNldCBsaW5lIGlzIGFzc2VydGVkIHdoZW4NCj4gc3dpdGNoaW5n
IHJvbGVzLiBXZSBhZGRpdGlvbmFsbHkgaGF2ZSB0byBlbnN1cmUgdGhhdCB0aGUgUEhZIGlzDQo+
IHN1c3BlbmRlZCBkdXJpbmcgaW5pdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN2ZW4gUGV0ZXIg
PHN2ZW5Aa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDYx
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDMgKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2RyZC5j
ICB8IDExICsrKysrKysrLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9ob3N0LmMgfCAgMyArKy0NCj4g
IDQgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IGluZGV4IDgwMDJjMjNhNWEwMmFjYjhmM2U4N2IyNjYyYTUzOTk4YTRjZjRmNWMu
LjI2YWE1MDdhNzM4ZjAwMTQwOWE5N2VmNTYzYzY1NjE0MzNhMWNhYzUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+IEBAIC0xNTgsNiArMTU4LDkgQEAgdm9pZCBkd2MzX3NldF9wcnRjYXAoc3RydWN0IGR3YzMg
KmR3YywgdTMyIG1vZGUsIGJvb2wgaWdub3JlX3N1c3BoeSkNCj4gIAlkd2MtPmN1cnJlbnRfZHJf
cm9sZSA9IG1vZGU7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIGR3YzNfY29yZV9leGl0KHN0
cnVjdCBkd2MzICpkd2MpOw0KPiArc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1l
KHN0cnVjdCBkd2MzICpkd2MpOw0KPiArDQo+ICBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUo
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzICpkd2MgPSB3
b3JrX3RvX2R3Yyh3b3JrKTsNCj4gQEAgLTE3Nyw3ICsxODAsNyBAQCBzdGF0aWMgdm9pZCBfX2R3
YzNfc2V0X21vZGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCWlmIChkd2MtPmN1cnJl
bnRfZHJfcm9sZSA9PSBEV0MzX0dDVExfUFJUQ0FQX09URykNCj4gIAkJZHdjM19vdGdfdXBkYXRl
KGR3YywgMCk7DQo+ICANCj4gLQlpZiAoIWRlc2lyZWRfZHJfcm9sZSkNCj4gKwlpZiAoIWRlc2ly
ZWRfZHJfcm9sZSAmJiAhZHdjLT5yb2xlX3N3aXRjaF9yZXNldF9xdWlyaykNCj4gIAkJZ290byBv
dXQ7DQo+ICANCj4gIAlpZiAoZGVzaXJlZF9kcl9yb2xlID09IGR3Yy0+Y3VycmVudF9kcl9yb2xl
KQ0KPiBAQCAtMjA1LDEzICsyMDgsMzIgQEAgc3RhdGljIHZvaWQgX19kd2MzX3NldF9tb2RlKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+ICsJaWYg
KGR3Yy0+cm9sZV9zd2l0Y2hfcmVzZXRfcXVpcmspIHsNCj4gKwkJaWYgKGR3Yy0+Y3VycmVudF9k
cl9yb2xlKSB7DQo+ICsJCQlkd2MtPmN1cnJlbnRfZHJfcm9sZSA9IDA7DQoNClRoZSBjdXJyZW50
X2RyX3JvbGUgc2hvdWxkIG5vdCBiZSB1c2VkIHRoaXMgd2F5LiBUaGUgdmFsdWUgb2YgdGhlDQpj
dXJyZW50X2RyX3JvbGUgc2hvdWxkIG5vdCBiZSBjbGVhcmVkIG9uIHRoZSBjYWxsIG9mIF9fZHdj
M19zZXRfbW9kZS4NClRoaXMgd2lsbCBtZXNzIHVwIHN1c3BlbmQvcmVzdW1lIGFuZCB3aWxsIGJl
IGRpZmZpY3VsdCB0byBtYWludGFpbi4NCkFsc28sIGFueSBzeW5jaHJvbml6YXRpb24vbG9ja2lu
Zz8NCg0KPiArCQkJZHdjM19jb3JlX2V4aXQoZHdjKTsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmIChk
ZXNpcmVkX2RyX3JvbGUpIHsNCj4gKwkJCXJldCA9IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUo
ZHdjKTsNCg0KVGhlIGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUoKSBpcyBmb3IgUE0sIHJldXNp
bmcgdGhpcyB3aXRoIGl0cw0KY3VycmVudCBuYW1lIGlzIGNvbmZ1c2luZy4NCg0KPiArCQkJaWYg
KHJldCkgew0KPiArCQkJCWRldl9lcnIoZHdjLT5kZXYsDQo+ICsJCQkJICAgICJmYWlsZWQgdG8g
cmVpbml0aWFsaXplIGNvcmVcbiIpOw0KPiArCQkJCWdvdG8gb3V0Ow0KPiArCQkJfQ0KPiArCQl9
IGVsc2Ugew0KPiArCQkJZ290byBvdXQ7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gIAkvKg0KPiAg
CSAqIFdoZW4gY3VycmVudF9kcl9yb2xlIGlzIG5vdCBzZXQsIHRoZXJlJ3Mgbm8gcm9sZSBzd2l0
Y2hpbmcuDQo+ICAJICogT25seSBwZXJmb3JtIEdDVEwuQ29yZVNvZnRSZXNldCB3aGVuIHRoZXJl
J3MgRFJEIHJvbGUgc3dpdGNoaW5nLg0KPiAgCSAqLw0KPiAtCWlmIChkd2MtPmN1cnJlbnRfZHJf
cm9sZSAmJiAoKERXQzNfSVBfSVMoRFdDMykgfHwNCj4gKwlpZiAoZHdjLT5yb2xlX3N3aXRjaF9y
ZXNldF9xdWlyayB8fA0KDQpEb24ndCBvdmVycmlkZSB0aGUgdXNlIG9mIEdDVEwuQ29yZVNvZnRS
ZXNldCB3aXRoIHRoaXMgcXVpcmsuIE5vdCBhbGwNCmNvbnRyb2xsZXIgdmVyc2lvbnMgc2hvdWxk
IHVzZSBHQ1RMLkNvcmVTb2Z0UmVzZXQsIHRoZSBuZXcgY29udHJvbGxlcg0KdmVyc2lvbiBkb24n
dCBldmVuIGhhdmUgaXQuIFdoYXQgdmVyc2lvbiBpcyB0aGlzIHZlbmRvciB1c2luZz8NCg0KSSdt
IGNvbmNlcm4gaG93IHRoaXMgY29uZGl0aW9uIGlzIG5lZWRlZC4uLg0KDQo+ICsJCShkd2MtPmN1
cnJlbnRfZHJfcm9sZSAmJiAoKERXQzNfSVBfSVMoRFdDMykgfHwNCj4gIAkJCURXQzNfVkVSX0lT
X1BSSU9SKERXQzMxLCAxOTBBKSkgJiYNCj4gLQkJCWRlc2lyZWRfZHJfcm9sZSAhPSBEV0MzX0dD
VExfUFJUQ0FQX09URykpIHsNCj4gKwkJCWRlc2lyZWRfZHJfcm9sZSAhPSBEV0MzX0dDVExfUFJU
Q0FQX09URykpKSB7DQo+ICAJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dDVEwp
Ow0KPiAgCQlyZWcgfD0gRFdDM19HQ1RMX0NPUkVTT0ZUUkVTRVQ7DQo+ICAJCWR3YzNfd3JpdGVs
KGR3Yy0+cmVncywgRFdDM19HQ1RMLCByZWcpOw0KPiBAQCAtMTM3Miw2ICsxMzk0LDkgQEAgc3Rh
dGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWlmIChyZXQpDQo+
ICAJCWdvdG8gZXJyX2V4aXRfcGh5Ow0KPiAgDQo+ICsJaWYgKGR3Yy0+cm9sZV9zd2l0Y2hfcmVz
ZXRfcXVpcmspDQo+ICsJCWR3YzNfZW5hYmxlX3N1c3BoeShkd2MsIHRydWUpOw0KPiArDQoNCldo
eSBkbyB5b3UgbmVlZCB0byBlbmFibGUgc3VzcGh5IGhlcmU/DQoNCj4gIAlkd2MzX2NvcmVfc2V0
dXBfZ2xvYmFsX2NvbnRyb2woZHdjKTsNCj4gIAlkd2MzX2NvcmVfbnVtX2Vwcyhkd2MpOw0KPiAg
DQo+IEBAIC0xNjM1LDYgKzE2NjAsMTggQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdF9tb2Rl
KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCXJldCA9IGR3YzNfZHJkX2luaXQoZHdjKTsNCj4gIAkJ
aWYgKHJldCkNCj4gIAkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRv
IGluaXRpYWxpemUgZHVhbC1yb2xlXG4iKTsNCj4gKw0KPiArCQkvKg0KPiArCQkgKiBJZiB0aGUg
cm9sZSBzd2l0Y2ggcmVzZXQgcXVpcmsgaXMgcmVxdWlyZWQgdGhlIGZpcnN0IHJvbGUNCj4gKwkJ
ICogc3dpdGNoIG5vdGlmaWNhdGlvbiB3aWxsIGluaXRpYWxpemUgdGhlIGNvcmUgc3VjaCB0aGF0
IHdlDQo+ICsJCSAqIGhhdmUgdG8gc2h1dCBpdCBkb3duIGhlcmUuIE1ha2Ugc3VyZSB0aGF0IHRo
ZSBfX2R3YzNfc2V0X21vZGUNCj4gKwkJICogcXVldWVkIGJ5IGR3YzNfZHJkX2luaXQgaGFzIGNv
bXBsZXRlZCBiZWZvcmUgc2luY2UgaXQNCj4gKwkJICogbWF5IHN0aWxsIHRyeSB0byBhY2Nlc3Mg
TU1JTy4NCj4gKwkJICovDQo+ICsJCWlmIChkd2MtPnJvbGVfc3dpdGNoX3Jlc2V0X3F1aXJrKSB7
DQo+ICsJCQlmbHVzaF93b3JrKCZkd2MtPmRyZF93b3JrKTsNCj4gKwkJCWR3YzNfY29yZV9leGl0
KGR3Yyk7DQo+ICsJCX0NCj4gIAkJYnJlYWs7DQo+ICAJZGVmYXVsdDoNCj4gIAkJZGV2X2Vycihk
ZXYsICJVbnN1cHBvcnRlZCBtb2RlIG9mIG9wZXJhdGlvbiAlZFxuIiwgZHdjLT5kcl9tb2RlKTsN
Cj4gQEAgLTIyMjMsNiArMjI2MCwyMiBAQCBpbnQgZHdjM19jb3JlX3Byb2JlKGNvbnN0IHN0cnVj
dCBkd2MzX3Byb2JlX2RhdGEgKmRhdGEpDQo+ICAJCQlnb3RvIGVycl9wdXRfcHN5Ow0KPiAgCX0N
Cj4gIA0KPiArCWlmIChkZXYtPm9mX25vZGUpIHsNCj4gKwkJaWYgKG9mX2RldmljZV9pc19jb21w
YXRpYmxlKGRldi0+b2Zfbm9kZSwgImFwcGxlLHQ4MTAzLWR3YzMiKSkgew0KPiArCQkJaWYgKCFJ
U19FTkFCTEVEKENPTkZJR19VU0JfUk9MRV9TV0lUQ0gpIHx8DQo+ICsJCQkgICAgIUlTX0VOQUJM
RUQoQ09ORklHX1VTQl9EV0MzX0RVQUxfUk9MRSkpIHsNCj4gKwkJCQlkZXZfZXJyKGRldiwNCj4g
KwkJCQkgICAgIkFwcGxlIERXQzMgcmVxdWlyZXMgcm9sZSBzd2l0Y2ggc3VwcG9ydC5cbiINCj4g
KwkJCQkgICAgKTsNCj4gKwkJCQlyZXQgPSAtRUlOVkFMOw0KPiArCQkJCWdvdG8gZXJyX3B1dF9w
c3k7DQo+ICsJCQl9DQo+ICsNCj4gKwkJCWR3Yy0+ZHJfbW9kZSA9IFVTQl9EUl9NT0RFX09URzsN
Cj4gKwkJCWR3Yy0+cm9sZV9zd2l0Y2hfcmVzZXRfcXVpcmsgPSB0cnVlOw0KDQpQdXQgdGhpcyBp
biB5b3VyIGdsdWUgZHJpdmVyIG9yIGRldmljZSB0cmVlLg0KDQo+ICsJCX0NCj4gKwl9DQo+ICsN
Cj4gIAlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KGR3Yy0+cmVzZXQpOw0KPiAgCWlmIChy
ZXQpDQo+ICAJCWdvdG8gZXJyX3B1dF9wc3k7DQo+IEBAIC0yMzkxLDcgKzI0NDQsNiBAQCBzdGF0
aWMgdm9pZCBkd2MzX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWR3
YzNfY29yZV9yZW1vdmUocGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldikpOw0KPiAgfQ0KPiAgDQo+
IC0jaWZkZWYgQ09ORklHX1BNDQo+ICBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1
bWUoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAlpbnQgcmV0Ow0KPiBAQCAtMjQxOCw2ICsy
NDcwLDcgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKHN0cnVjdCBkd2Mz
ICpkd2MpDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiArI2lmZGVmIENPTkZJR19QTQ0K
PiAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21l
c3NhZ2VfdCBtc2cpDQo+ICB7DQo+ICAJdTMyIHJlZzsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggZDViOTg1
ZmExMmY0ZDllZTNmMzE4ZWE1Y2NlN2MxYjIyNWNkMzYyMy4uMzhmMzJmMmE2MTkzYzFiMjY2MmFi
NGYzOGY0ZDIwY2Y0YjBlMTk4ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTExNTQsNiArMTE1NCw3
IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAgICogQHN1c3BlbmRlZDogc2V0
IHRvIHRyYWNrIHN1c3BlbmQgZXZlbnQgZHVlIHRvIFUzL0wyLg0KPiAgICogQHN1c3BoeV9zdGF0
ZTogc3RhdGUgb2YgRFdDM19HVVNCMlBIWUNGR19TVVNQSFkgKyBEV0MzX0dVU0IzUElQRUNUTF9T
VVNQSFkNCj4gICAqCQkgIGJlZm9yZSBQTSBzdXNwZW5kLg0KPiArICogQHJvbGVfc3dpdGNoX3Jl
c2V0X3F1aXJrOiBzZXQgdG8gZm9yY2UgcmVpbml0aWFsaXphdGlvbiBhZnRlciBhbnkgcm9sZSBz
d2l0Y2gNCj4gICAqIEBpbW9kX2ludGVydmFsOiBzZXQgdGhlIGludGVycnVwdCBtb2RlcmF0aW9u
IGludGVydmFsIGluIDI1MG5zDQo+ICAgKgkJCWluY3JlbWVudHMgb3IgMCB0byBkaXNhYmxlLg0K
PiAgICogQG1heF9jZmdfZXBzOiBjdXJyZW50IG1heCBudW1iZXIgb2YgSU4gZXBzIHVzZWQgYWNy
b3NzIGFsbCBVU0IgY29uZmlncy4NCj4gQEAgLTEzOTIsNiArMTM5Myw4IEBAIHN0cnVjdCBkd2Mz
IHsNCj4gIAl1bnNpZ25lZAkJc3VzcGVuZGVkOjE7DQo+ICAJdW5zaWduZWQJCXN1c3BoeV9zdGF0
ZToxOw0KPiAgDQo+ICsJdW5zaWduZWQJCXJvbGVfc3dpdGNoX3Jlc2V0X3F1aXJrOjE7DQo+ICsN
Cj4gIAl1MTYJCQlpbW9kX2ludGVydmFsOw0KPiAgDQo+ICAJaW50CQkJbWF4X2NmZ19lcHM7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2RyZC5jIGIvZHJpdmVycy91c2IvZHdjMy9k
cmQuYw0KPiBpbmRleCA3OTc3ODYwOTMyYjE0MjkyNGVkZDE5Zjg1OWY3YzQwNDFkMTFlZGE2Li42
NTQ1MGRiOTFiZGVhMDBiYjMwYmZiMzY4ZjUxOTVhZDJmZDU4ZGE0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2RyZC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMNCj4g
QEAgLTQ2NCw2ICs0NjQsOSBAQCBzdGF0aWMgaW50IGR3YzNfdXNiX3JvbGVfc3dpdGNoX3NldChz
dHJ1Y3QgdXNiX3JvbGVfc3dpdGNoICpzdywNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+ICsJ
aWYgKGR3Yy0+cm9sZV9zd2l0Y2hfcmVzZXRfcXVpcmsgJiYgcm9sZSA9PSBVU0JfUk9MRV9OT05F
KQ0KPiArCQltb2RlID0gMDsNCj4gKw0KPiAgCWR3YzNfc2V0X21vZGUoZHdjLCBtb2RlKTsNCj4g
IAlyZXR1cm4gMDsNCj4gIH0NCj4gQEAgLTQ5Miw2ICs0OTUsMTAgQEAgc3RhdGljIGVudW0gdXNi
X3JvbGUgZHdjM191c2Jfcm9sZV9zd2l0Y2hfZ2V0KHN0cnVjdCB1c2Jfcm9sZV9zd2l0Y2ggKnN3
KQ0KPiAgCQkJcm9sZSA9IFVTQl9ST0xFX0RFVklDRTsNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAr
DQo+ICsJaWYgKGR3Yy0+cm9sZV9zd2l0Y2hfcmVzZXRfcXVpcmsgJiYgIWR3Yy0+Y3VycmVudF9k
cl9yb2xlKQ0KPiArCQlyb2xlID0gVVNCX1JPTEVfTk9ORTsNCg0KRG9uJ3QgcmV0dXJuIFVTQl9S
T0xFX05PTkUgb24gcm9sZV9zd2l0Y2ggZ2V0LiBUaGUgVVNCX1JPTEVfTk9ORSBpcyB0aGUNCmRl
ZmF1bHQgcm9sZS4gVGhlIHJvbGVfc3dpdGNoIGdldCgpIHNob3VsZCByZXR1cm4gZXhhY3RseSB3
aGljaCByb2xlIHRoZQ0KY29udHJvbGxlciBpcyBjdXJyZW50bHkgaW4sIGFuZCB0aGUgZHJpdmVy
IGNhbiBmaWd1cmUgdGhhdCBvdXQuDQoNCj4gKw0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCXJldHVybiByb2xlOw0KPiAgfQ0KPiBAQCAtNTAyLDcg
KzUwOSw5IEBAIHN0YXRpYyBpbnQgZHdjM19zZXR1cF9yb2xlX3N3aXRjaChzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiAgCXUzMiBtb2RlOw0KPiAgDQo+ICAJZHdjLT5yb2xlX3N3aXRjaF9kZWZhdWx0X21v
ZGUgPSB1c2JfZ2V0X3JvbGVfc3dpdGNoX2RlZmF1bHRfbW9kZShkd2MtPmRldik7DQo+IC0JaWYg
KGR3Yy0+cm9sZV9zd2l0Y2hfZGVmYXVsdF9tb2RlID09IFVTQl9EUl9NT0RFX0hPU1QpIHsNCj4g
KwlpZiAoZHdjLT5yb2xlX3N3aXRjaF9yZXNldF9xdWlyaykgew0KPiArCQltb2RlID0gMDsNCj4g
Kwl9IGVsc2UgaWYgKGR3Yy0+cm9sZV9zd2l0Y2hfZGVmYXVsdF9tb2RlID09IFVTQl9EUl9NT0RF
X0hPU1QpIHsNCj4gIAkJbW9kZSA9IERXQzNfR0NUTF9QUlRDQVBfSE9TVDsNCj4gIAl9IGVsc2Ug
ew0KPiAgCQlkd2MtPnJvbGVfc3dpdGNoX2RlZmF1bHRfbW9kZSA9IFVTQl9EUl9NT0RFX1BFUklQ
SEVSQUw7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvaG9zdC5jDQo+IGluZGV4IDFjNTEzYmY4MDAyZWM5ZWM5MWI0MWJmZDA5NmNiZDBk
YTFkZDJkMmUuLmY3YTcxZTZmOWQ4MGFjYTYzMmYxZjk3MGQ5MDBhM2RlOGE3NmYwYTcgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvaG9zdC5jDQo+IEBAIC0yMjMsNyArMjIzLDggQEAgdm9pZCBkd2MzX2hvc3RfZXhpdChzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiAgCWlmIChkd2MtPnN5c193YWtldXApDQo+ICAJCWRldmljZV9pbml0
X3dha2V1cCgmZHdjLT54aGNpLT5kZXYsIGZhbHNlKTsNCj4gIA0KPiAtCWR3YzNfZW5hYmxlX3N1
c3BoeShkd2MsIGZhbHNlKTsNCj4gKwlpZiAoIWR3Yy0+cm9sZV9zd2l0Y2hfcmVzZXRfcXVpcmsp
DQo+ICsJCWR3YzNfZW5hYmxlX3N1c3BoeShkd2MsIGZhbHNlKTsNCj4gIAlwbGF0Zm9ybV9kZXZp
Y2VfdW5yZWdpc3Rlcihkd2MtPnhoY2kpOw0KPiAgCWR3Yy0+eGhjaSA9IE5VTEw7DQo+ICB9DQo+
IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KPiANCg0KU2VlbXMgdGhlcmUgYXJlIGV4cGVyaW1lbnRh
bCBsb2dpY3MgdGhhdCBtYXkgbm90IGJlIG5lZWRlZCBmb3IgdGhlDQpwbGF0Zm9ybSB0byB3b3Jr
IHByb3Blcmx5LiBXZSBuZWVkIHRvIGZpZ3VyZSBvdXQgd2hhdCdzIGFjdHVhbGx5IG5lZWRlZC4N
Cg0KQlIsDQpUaGluaA==

