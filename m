Return-Path: <linux-kernel+bounces-797503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46529B4113A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F7B1B61B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB27282EE;
	Wed,  3 Sep 2025 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lOU5pm/U";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QJwnRYp1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KK2SgMsh"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A223AD;
	Wed,  3 Sep 2025 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858496; cv=fail; b=Y2dtuAcSfqkooa+BZMrSYxt7VOzIdXkSnqYH5OEj9FRtXjb+GHxsJM4zFijgQ8pqX0ECLR4a83SGYFXX8EChfGEzfNLjCUFDT09nqgypLZ3LMaoHA/GJd6rkFwG32lmHSN2gRDK86mDWteCFEdyRvvR+0GvOnNI/TxhHdbvpuqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858496; c=relaxed/simple;
	bh=iy3Hj6W4yfPEeytDQ3nKMYrkRK0oAePTIz/Ql7c9yME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhJny03xsDeBG/ht0+D/WLl3tvi0GOL6Wl+g42VIjBwgYHbbLc7DsBoomnjvu8dBipHaeA5dm0YwF/x0ht52ZSMMyoJXJubjBv8I/9R2MFWD1T5VOMOppMuki1+deRc9MRUOSCNLS3wJidb8GG2IUsbRNvqvsLcNVQxkv1NXV3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lOU5pm/U; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QJwnRYp1; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KK2SgMsh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582IkWgA024885;
	Tue, 2 Sep 2025 16:44:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=iy3Hj6W4yfPEeytDQ3nKMYrkRK0oAePTIz/Ql7c9yME=; b=
	lOU5pm/UYx8Ph8Goxb8P9guJNuXPv70sQ+OkRzgQ06ZXq8f/vSggkDsaU9DW2nxG
	pwynUvJup+4gXcmOvhftF6rj4B5p1s+QEMyf2UVnuBAMB8Qdo0YUn59uNwNWoln8
	LnJgOCqLXHt0fozM06FDdkAQR+yyc4A2hQcD4rA+Mt/6zXZbniLNE9kgg+fF8xoQ
	2Ki9lMc9ZK4pssAbDaQdtejkLfb4e3n/tm+fSKzZfoHNBRhTTmMzjBADqJvYbH6Z
	vaoOZV2S1+mZr+nDvzksQqwZbYka2h8CpGhPJfvUsKJVVdtV94Fqp94eucc0BjWl
	HG3pO2tFA1WcTppFu9830g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48v0j46bdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 16:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756856696; bh=iy3Hj6W4yfPEeytDQ3nKMYrkRK0oAePTIz/Ql7c9yME=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=QJwnRYp175tTkT6bf70D8eKfu/NFK4CMEXMn2K3GBQRqXu8KX9WSSiSoFEs/qnxlO
	 SVYGUwQz9wI+3R8J+kx2tY2Q1MzIwtyQxAR6/VE46N1AOkIE6YPG+ycROleK1C+ahw
	 g/ume0BHBsp1WX1SHTizXM8GDmbl/1uvtyleYpHhIcPlfS1LcDmbyFwUPI4yV3PUp7
	 HQo7RHyu188mVy5cphP46+Gi31DSZpWyFkQ4DpgEq2dW7FJj113ntfRK34Fg2pZPGZ
	 761CARFGeFJgKwCDR/1A0LvdsmVqRzJa1a1bSfwCDy8lmh/vqDsR3ewLXbI99Kl755
	 x3Po+jZUrUjpg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C40EB401F5;
	Tue,  2 Sep 2025 23:44:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 58B5CA00BC;
	Tue,  2 Sep 2025 23:44:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KK2SgMsh;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 870D640561;
	Tue,  2 Sep 2025 23:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdYR5/26sUjydJdTEKV+BXxez1MKIAxb6JnIo1URaGojs3R38BrzLXrImFVkqUueVZYRK0VRk/qSPzhNFEnaRlZZpnSkwuSAn7KzeqgFf2oC52lefSqBXJaxGoq9tZQavvDA/6e61QK+Z9hdcEHMKCxb97RCmRZ1+LUvhcDDb9Nqjam6c2V/0v23KqjMvI0GJSkfIw6e0VMLMj2s/OvaTta/E4ZxJrQVMyVO0NHh/frVqNrVLq2x2rHuApwk1rBcgtkOUIzDI9HCA/++9wTMuhK4Phc2O65ZuIab6wXW57jza3/f+S+a3bfGdgdVnNDv3HaYMTq/mN3HMoNlDA3oIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iy3Hj6W4yfPEeytDQ3nKMYrkRK0oAePTIz/Ql7c9yME=;
 b=XKLfsKnskS/Py60LxULVXzvKKKHQHW05QsO0y90byyXG9VjHVtUQONyIEOXY9WoqVZcAGChNAHdVcQFjyxwSsmN3aBrudraq7zURNTmPAfghhT/SXFhB6mqLjgef3BqwlI/so5yjcGxqi4hJ7bZefG1aNJyT4xosbxMQIKVGNQ+1Q9u+/0h5Hv4kitS1ys+J4sIWlvf9vvzTS/YW2KSh7DmaFBZtNN7OPw6MShV9ev7f5JyNL6qqptq5CysbdNCXirLpZBNHD69RUuK9tDHdZ4imSKmW19PGUaSAOvaCfXHxTf1O14cHdSY/5lX875gUimHgtT74ssSV7V+wsGWYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy3Hj6W4yfPEeytDQ3nKMYrkRK0oAePTIz/Ql7c9yME=;
 b=KK2SgMshnSewwQ/ytGc0kTFegUQLT7mw/klT3X8YMrTmqmaSybqyd1vCwEsaWm2qjJkz9qMwvQWvB2ayFebICZ6FWRA64noP0SkixhfJjGkr5yfvE7wpyQyLHm7sy5Rr7PaNBACUzLXndFiLR2oX9RgNRQZWEy52gLT3TN8Y7+Q=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 23:44:52 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 23:44:52 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Log dwc3 instance name in traces
Thread-Topic: [PATCH] usb: dwc3: Log dwc3 instance name in traces
Thread-Index: AQHcFbWpI8fQ113kKk2/GPa4dCHPkLR4sG4AgAVxqQCAAnmiAA==
Date: Tue, 2 Sep 2025 23:44:52 +0000
Message-ID: <20250902234450.vdair2jjrtpmpdal@synopsys.com>
References: <20250825114433.3170867-1-prashanth.k@oss.qualcomm.com>
 <20250828224852.ukelgargocektp3z@synopsys.com>
 <5b30f63a-5999-48f1-972f-93f02fcc0ec2@oss.qualcomm.com>
In-Reply-To: <5b30f63a-5999-48f1-972f-93f02fcc0ec2@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM6PR12MB4481:EE_
x-ms-office365-filtering-correlation-id: bb2c1b34-3112-4776-d214-08ddea7ab67c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yy8rTlV5THVPMjJZbEE3SzZWNG9DOFRqTnJIT2h4a1BwdUlhS2tISzJnK2dl?=
 =?utf-8?B?UGd5aE1VeW5DQkwyMFl1YVdTdVYrY1R2Q0hZTFp4dGE0c1FvaUFseUFXbW0x?=
 =?utf-8?B?QmprcnBZenlRd1JWRXRuWFE4Tk82WDZiRytxSTkwU3V1TU1rRGlpdE5oY3RM?=
 =?utf-8?B?UmlhR29CQkVrVkJnMkJoY1hkQmRKL1kxNDRaaWRtejlQb09WWVRGZnhNQWJs?=
 =?utf-8?B?N25lOGkvNnhEYy9VZ1R3T1VzcnVxT2I1aGtZaHhJbDdaUnRSQXcyQktpUXoy?=
 =?utf-8?B?dEZ1T21JZ25nQmo2dURIOVZ6WlRpYUlydEI3T080aERqbUtJWjljRC96R0tR?=
 =?utf-8?B?VkFJS2V5a3ovaDdEUXNsN1A0c21ZMmhDdk80U2JWUW1hL044VlRLVC81dHZn?=
 =?utf-8?B?RzVGai92WDJuN2xHbE9mMGN6TlBJemIxZWE2TXJTQWt1dWxOc2YxZDBxclB3?=
 =?utf-8?B?T2dJaXAzVktQL0pwV3FVUUlDQjBIUFdJc093V3RvdzhaNExjbGxFMEJCYWRR?=
 =?utf-8?B?T2xENEJ3eEFVaDFCUzhPYkVyc1B1VUhiMWUxdHJEcENicDI5T2tzWk5hMU9m?=
 =?utf-8?B?bWtxK1dyOWRua20zN2REQjZzaTc5Tm1nLzNTNnVVVFRVaVBlVFVsTERmN0RZ?=
 =?utf-8?B?MHFlSVBsMjZuNWdsV01hcjdNclUyU0ZuKzlqUHFXMjQ0aFFueEl4WkxDWkk1?=
 =?utf-8?B?L1ZRSzhST1NWT3lwZWNTdXJ5UEJCN0N2WnJGTFlmWGdwcEhpRkNjcWN0QjVL?=
 =?utf-8?B?VzVWN2g1eFJwaDNoOHg1dGg5eFFTcDhEYzFrbjJkQzl4d1pTUzE0TllGQU82?=
 =?utf-8?B?cllRM2t5T0FaQTdiSE1vTjlsRTdiNDN6dVptWHpjd0JndmRhYWdQNjB1L2xX?=
 =?utf-8?B?SEF6eCtMZERkdWdZd3o2UjNkbDV1d3NVTTJTRDBNdU9DQ3c0cktDY0RHMSs5?=
 =?utf-8?B?VWlsNVVzQldTYW5kc05IZzZwSGNVMDNvRy8wbFJwWkQydVVIL0JDTkpORnJv?=
 =?utf-8?B?MlhTMEIxRXFpUmhKZ2N3cVFGU2QyR0J4OU5udVZWcHM0NWVBdWMwRWJiby8v?=
 =?utf-8?B?Z1RzYVV0KzdXQUh2SGpIWG01SzltaitjdEluWVVPWittd3g1Qm9aQWdxYlE2?=
 =?utf-8?B?MFVUZnJaemM4MTVVYXFWRXNNb2pVQWFHazg0VXRYQTZ5dSt4OFVzbDRiaUsw?=
 =?utf-8?B?dTRkV1UxNzZEMGtZaHdhb3IvKzl0SjFNSGV1ZVdaQlVpQnhUOFoyNXB5UHI5?=
 =?utf-8?B?QWVjamtlUDVUbVBLVG1zTlJ0c2tYYnFUWmFTaGZPbmVhcTIrS3J2TzMyVG5Z?=
 =?utf-8?B?enY0eUNSM3U4cnYwTjZMbWVFSGVMWXJIZXFNaWthYW1wMjl3MER2Yy9IL3NB?=
 =?utf-8?B?UGtQVUI3TkRnZUlXdHVJV1pJZXFyUUdMczJtSFFzcXI0Y0F6Y3ZZdytzekpl?=
 =?utf-8?B?YjZNZHlnOC92c3FlVyt2eVZnUUsvb3RGTHpzNFpaMnllSkJaV3djVkF1Zjlk?=
 =?utf-8?B?aUJaVkpVTG5NVmJpdEErMDM1eWgzejNLVzlNcTRDeDBEWml6UmwrRFB0Q0g2?=
 =?utf-8?B?TzhTMy9EakxYbjRvRm9CdlUzd2dPUFJENnozSUZzTEFvb0plK2xQekRBcDlC?=
 =?utf-8?B?eVBzU2h4dlhHTmROaXlDWkF1RStxQUtYdDBLZzkyRFBNdEQzV2NQdTlvdHBJ?=
 =?utf-8?B?UTc3UzdveTdkempkcStEeEVYelp0RWJianFSVk4zUHV1MlI4eC9RV0lqdU1v?=
 =?utf-8?B?aWgzYmpDWUx4cmRDVGgwUm0vbzViajE5bzVjdXBhaG1zUUNkQ3BHMVk5eDJF?=
 =?utf-8?B?djAveE15SkpUZzMrZDlKM0RFMjROdGN1WGpiM2lEWmpIYlRwNEtiaHVnMDRP?=
 =?utf-8?B?cHBydEVLMDFwZ3BBZkowZmdVWG92bGM4Q1QrOWJjZzFPeFlvaTNZSW1MQVdz?=
 =?utf-8?B?anBXQWJQTlJ4cGhyK0QyWVkwZmI1ZGpvckJxNXBuaGQ0aXNzd3hYRXhwUFlG?=
 =?utf-8?B?L1AxUlE4QlVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWpYczVhd2grVXhsT1lNNkRaRFAxT0QvQXJ3M2sybEhKcDdRaHd6U21ZV3M0?=
 =?utf-8?B?UUhRcjR1VmlESEJVZE00MC9aTDlJQkZrWENIWlRpeHBVMFQwTHRVQ3pQWWRS?=
 =?utf-8?B?U2VvSnVvQ2lBMUJMWFJkbkd5cVJZTXd1Q21tTEQrbnNnbVZwZFUzVDI0K3JB?=
 =?utf-8?B?cHNtZ29XVXVTeE9ZeWFwalZIbUd5S2xuaWtiRjQ4blNvbUNkV2dDK2MzS29k?=
 =?utf-8?B?ZE1pamVnMElaU3RpMnZWZ1c3NitqcUhMWTdremdBci9ZeDUwNFlGWVNoL0k1?=
 =?utf-8?B?TFdRNTlmbW9VbzdkM0JJUjY0TGVXR2hMSHhnT3hXRksyd0NydnJGVWJxRTJ3?=
 =?utf-8?B?SVR1cVEzUUdGUHk4ay9TdkRwYzhUMXFnOXBWcmhiOG9PWHNOM3N1ZmZZdzQ3?=
 =?utf-8?B?bzZLenRqRFpWOGY2ZDNuZS9idVNJUURvWGZjcXlNMXQvU1JhTk1LbnNIT3Q1?=
 =?utf-8?B?elFobFB0b2hSMXgreTUwVDluSkJGL3Z4SnRJK29IYjRwSERTcDFpcWYzNjYz?=
 =?utf-8?B?MmNiUTZYU0Z0Qi9XSFN3OUVadkVvRkd2UkNKVkQvSk13bmhFcmlUMU5QNGRO?=
 =?utf-8?B?NXAwMVRTanFBN29hTE1ydi9mMGhlQzBoWmk1ekh4MnR1QVdpdldxOENXcXAx?=
 =?utf-8?B?WHVBbzU1bm03TldZZ0VtZFVmOE5DOHRLU0FnS1kySWFLOTZCWm1tM214Wis5?=
 =?utf-8?B?Q055aXRIOTZrSmNCanovRW9YZ1FRS3cvR3JCOVpMb1k0VXBpMUU1THhNRWxW?=
 =?utf-8?B?aS9leXpldHMwOUdVUWxGTTRhRzhueUsrY1M0VklkL2g3QlpYb3RTbllHK1Zq?=
 =?utf-8?B?MThDczNHWkR6bVBZOE1ReXE4ZjNZVzQwdlRqaWlTb1NyNXV5R1Q1ZjlQZnNK?=
 =?utf-8?B?aXIyUG0wOGdPWTcxay9rR3krZXhyQ2pDUE5ZRE5hamNWaUhpMlhVQ0ZjTU1Y?=
 =?utf-8?B?c1JLYzJoUU9OVkRibEhEZEpVQTc3ODFDUjdBRkVKSDVPbitmeDVwcXN3VjE0?=
 =?utf-8?B?V3JRWEVNdnEwcFlkR09KUlNtTGNLTVNIZ3NCUHZWenlmNGR5RmNkZlhCdzZO?=
 =?utf-8?B?d0k3clBvU1BwZU9ldCtWSXVrVkJtT2VhbmVPTzJaZmZLOWFqZ3U2a1RMYnQz?=
 =?utf-8?B?Z2xzWk9HblpjTTcxcU5uemVlMDIram1kVkFRcUlHSVFzZ05KcXFhSm5ScGhs?=
 =?utf-8?B?RTlidElMTEFNdE1nVVRSdm5kMlpHTFdycGFUZzloUjdPWFJHZWRZQzRvTnNP?=
 =?utf-8?B?dlg4MzY5M3FPTTRmdzVXTzlIZXdPSi9qeUlWZU8yNVppWGswY0pFcktFSXZR?=
 =?utf-8?B?OTk4WXI4eloxemN0ZEpNQk1wQVQyLzRxSTAzdGsrVGZiUEhjUTZTSXlpTWMz?=
 =?utf-8?B?OGhWSGZOYjBRYXE3eW1sU1MyZXhzeVJMY2VhUzIzSm1aVTlkZ1pma1lvN0VQ?=
 =?utf-8?B?UWRCMndxVUE5ZDJveElRd2Y5SlhZbmNqY0RjcFFRNzRQMkZKQW1CREV0aG52?=
 =?utf-8?B?YVZzOVdSTVBxSjAvR2NuMWZKbkhZTitjMkJLRVFZTmN0cWcrRjZlZGN2amp1?=
 =?utf-8?B?RjZIV3VieG5kMWdDQWZhNmZ0akFRWG5vWU1USTFZMi9hVWp3Sm1JYzc3Vjd4?=
 =?utf-8?B?NlJ5SlcwR1ZrZWhKOWxVRFYyRzMvWnJseW1YaHRTNmJrSWw2dW0rVERaeVJ0?=
 =?utf-8?B?ejV4SGJIc04vQjJnRWJzd2xSM1E5ZElnMUlFNG9PN1lPaUJva3VQWVdGamp2?=
 =?utf-8?B?dzVUcXNHemd3ZHNXYnduSkZhSm43bGdoZldCc2YvR0NJM2s1aXE2bUZjd2th?=
 =?utf-8?B?b2x3ZmNiVGgrYzlrbCtOYVB6T2dJbHBybXhDdFRSbmhENHFxU2lNZWdMQXlr?=
 =?utf-8?B?MU4wK3FxQUVWUHpmR1g3WXVmMXEwZmFMQjlKamJCWk9qdWxYUVJLUmVESGRS?=
 =?utf-8?B?cmY5MmlTUjkxYWpIQ2ovSHU0bldPQU9lUWhWbEFTbjlEa0UvdW5Jem1ZWm40?=
 =?utf-8?B?ajFsUlY4WUREamE0ZXVxMzk3RW0vZkpFT3oxNjF5U0pMa1JxMFJOWTF0UEdm?=
 =?utf-8?B?bGtoUHNNZ3paY29vbWZJU3k2Nm1XZ0pKdzJoblFFTUkvSzB3Z1VxRlB4YnZW?=
 =?utf-8?Q?GfQcUsO7YqXJaR7PP1U+VZ3Ez?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02FC5B8C12BE924BAEF17A1230B2CC95@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yg/yFh7txrkWg1rZiRCcaC3eGWOSSjGpLXB3Wzk3vitXp/NBMKEnv4mqOXdME17F8xTXT/6dYsCjaS1ILW6WJZyzDHu/i/br62pscPql8B4cs+gw2Um8nRZxblnKyehFGMMfMsMlhbtbBlpJlhdsWebLYKVdBg9H5T8pMruXuRDOTpZmb4VYS3eBEkxTlsBCQHDifOk2PvgjQaX4fQrAtTu+HB/Mt7iy1kegGiif31iXEarGumKYy01UvdvBtYH1LVcED1aiROudFchwKG31rbOJoq/6/7fLSuOckDwKAY9IE03tiS6vyds7y9f5B4LGHE1Trzl+mplHgmLhssHMhNuVd8sZpN4S3XkVJ/sh/nUkvukVV//xcbtmso3x+CZ99KmWHt+s7LJiWWBeOxZaHztlI5PkF3A/9gMuVllKIAABG/q/vqoy3pzmdu5VihMOzmNYjBZqlU++QCyEBiBQl9qg/oKKpg60c78U38IKS0TOLDPWpBZIBVDcSudsBB5l41TqVO/Y+e+PmFnqnpk4jiGDy6cvBBfXw1wgpS4EZcL9UDih+r0j5jdoG2v0oGpZ5IxJHkqsrDY0VQ1O7Lrad7Jo4ebxiK4tEYfnmMxJhgO6dMV1gjyUHrELqwCzTs+k5DkfGLWLfj0EB+cq7HLk5g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2c1b34-3112-4776-d214-08ddea7ab67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 23:44:52.4540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOx+sorwq3B3s78WjQGktar6sKJ6wyB/kla/uTJzyGCsErYYHdKUZup8Bh82EKGxhYpN+gE7AMr8xA5GDYK5Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
X-Proofpoint-GUID: tdIOxl72Nu9fuqtpKxakZvVqqB-FtFyu
X-Authority-Analysis: v=2.4 cv=OKkn3TaB c=1 sm=1 tr=0 ts=68b78179 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=EUspDBNiAAAA:8 a=-PtlrVdEU_44AtEr6KgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDExNSBTYWx0ZWRfX4i/9b62OxJwp
 lC1pJmKeA3ZSZgxX7eARViL//Q/0ox3lDG5HUqW56R6byioLzPvPMRiRWY89qTid04VZIT7Ir2U
 QQsR068STWqCHzZtdSpd8VnEXd1RpTqU7eYPh49M92HRYt8wju5Osw0LnMOMLfHoUKLcJnU8/k3
 zvB5y0NGNmcU0JswCtlCBIYmhKyQ0bK+ITFSIpt8eSVZnywM3ZbAai0TEwZexW8014yssUoeBIl
 wwoCoICbJGUb4KR89Xxqw88re1re4S/+8u9KdJ8f9mr9y97LZOTkVkRvSH1ySWd1zKsVe4+8yFW
 lsGH/N/JzlkuwUDJFzbLB+5395dfSU+fCBdtkSpWPQns9/dsIuQaOcLsDjjq3Q2/3rXJ1obsho+
 ID2PZCcV
X-Proofpoint-ORIG-GUID: tdIOxl72Nu9fuqtpKxakZvVqqB-FtFyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508300115

T24gTW9uLCBTZXAgMDEsIDIwMjUsIFByYXNoYW50aCBLIHdyb3RlOg0KPiANCj4gDQo+IE9uIDgv
MjkvMjAyNSA0OjE4IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4g
T24gTW9uLCBBdWcgMjUsIDIwMjUsIFByYXNoYW50aCBLIHdyb3RlOg0KPiA+PiBXaGVuIG11bHRp
cGxlIERXQzMgY29udHJvbGxlcnMgYXJlIGJlaW5nIHVzZWQsIHRyYWNlIGV2ZW50cyBmcm9tDQo+
ID4+IGRpZmZlcmVudCBpbnN0YW5jZXMgZ2V0IG1peGVkIHVwIG1ha2luZyBkZWJ1Z2dpbmcgZGlm
ZmljdWx0IGFzDQo+ID4+IHRoZXJlJ3Mgbm8gd2F5IHRvIGRpc3Rpbmd1aXNoIHdoaWNoIGluc3Rh
bmNlIGdlbmVyYXRlZCB0aGUgdHJhY2UuDQo+ID4+DQo+ID4+IEFwcGVuZCB0aGUgZGV2aWNlIG5h
bWUgdG8gdHJhY2UgZXZlbnRzIHRvIGNsZWFybHkgaWRlbnRpZnkgdGhlDQo+ID4+IHNvdXJjZSBp
bnN0YW5jZS4NCj4gPiANCj4gPiBDYW4gd2UgcHJpbnQgdGhlIGJhc2UgYWRkcmVzcyBpbnN0ZWFk
IG9mIHRoZSBkZXZpY2UgbmFtZT8gVGhpcyB3aWxsIGJlDQo+ID4gY29uc2lzdGVudCBhY3Jvc3Mg
ZGlmZmVyZW50IGRldmljZSBuYW1lcywgYW5kIGl0IHdpbGwgYmUgZWFzaWVyIHRvDQo+ID4gY3Jl
YXRlIGZpbHRlci4NCj4gPiANCj4gRGlkIHlvdSBtZWFuIHRvIHByaW50IHRoZSBpb21lbSAoYmFz
ZSBhZGRyZXNzKSBkaXJlY3RseT8NCj4gSSB0aGluayB1c2luZyBkZXZpY2UgbmFtZSBpcyBtb3Jl
IHJlYWRhYmxlLCBpbiBtb3N0IGNhc2VzIGRldmljZSBuYW1lDQo+IHdvdWxkIGNvbnRhaW4gdGhl
IGJhc2UgYWRkcmVzcyBhbHNvLiBMZXQgbWUga25vdyBpZiB5b3UgYXJlIHBvaW50aW5nIHRvDQo+
IHNvbWV0aGluZyBlbHNlLj4+DQoNClllcywgSSBtZWFuIHRoZSBkZXZpY2UgYmFzZSBhZGRyZXNz
LiBQQ0kgZGV2aWNlcyB3b24ndCBoYXZlIHRoZSBiYXNlDQphZGRyZXNzIGFzIHBhcnQgb2YgdGhl
IGRldmljZSBuYW1lLg0KDQo+ID4+IEV4YW1wbGUgdHJhY2Ugb3V0cHV0LA0KPiA+PiBiZWZvcmUg
LT4gIGR3YzNfZXZlbnQ6IGV2ZW50ICgwMDAwMDEwMSk6IFJlc2V0IFtVMF0NCj4gPj4gYWZ0ZXIg
IC0+ICBkd2MzX2V2ZW50OiBhNjAwMDAwLnVzYjogZXZlbnQgKDAwMDAwMTAxKTogUmVzZXQgW1Uw
XQ0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBQcmFzaGFudGggSyA8cHJhc2hhbnRoLmtAb3Nz
LnF1YWxjb21tLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3VzYi9kd2MzL2VwMC5jICAg
IHwgIDIgKy0NCj4gPj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAgMiArLQ0KPiA+PiAg
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaCB8ICAxICsNCj4gPj4gIGRyaXZlcnMvdXNiL2R3YzMv
aW8uaCAgICAgfCAxMiArKysrLS0tDQo+ID4+ICBkcml2ZXJzL3VzYi9kd2MzL3RyYWNlLmggIHwg
NzYgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4+ICA1IGZpbGVz
IGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAw
LmMNCj4gPj4gaW5kZXggNjY2YWM0MzJmNTJkLi5iODE0YmJiYTE4YWMgMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gPj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9l
cDAuYw0KPiA+PiBAQCAtODMwLDcgKzgzMCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZXAwX2luc3Bl
Y3Rfc2V0dXAoc3RydWN0IGR3YzMgKmR3YywNCj4gPj4gIAlpZiAoIWR3Yy0+Z2FkZ2V0X2RyaXZl
ciB8fCAhZHdjLT5zb2Z0Y29ubmVjdCB8fCAhZHdjLT5jb25uZWN0ZWQpDQo+ID4+ICAJCWdvdG8g
b3V0Ow0KPiA+PiAgDQo+ID4+IC0JdHJhY2VfZHdjM19jdHJsX3JlcShjdHJsKTsNCj4gPj4gKwl0
cmFjZV9kd2MzX2N0cmxfcmVxKGR3YywgY3RybCk7DQo+ID4+ICANCj4gPj4gIAlsZW4gPSBsZTE2
X3RvX2NwdShjdHJsLT53TGVuZ3RoKTsNCj4gPj4gIAlpZiAoIWxlbikgew0KPiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4gPj4gaW5kZXggMjVkYjM2YzYzOTUxLi5lMzYyMWNjMzE4ZWEgMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiA+PiBAQCAtMjcxLDcgKzI3MSw3IEBAIGludCBkd2MzX3NlbmRfZ2FkZ2V0
X2dlbmVyaWNfY29tbWFuZChzdHJ1Y3QgZHdjMyAqZHdjLCB1bnNpZ25lZCBpbnQgY21kLA0KPiA+
PiAgCQlzdGF0dXMgPSAtRVRJTUVET1VUOw0KPiA+PiAgCX0NCj4gPj4gIA0KPiA+PiAtCXRyYWNl
X2R3YzNfZ2FkZ2V0X2dlbmVyaWNfY21kKGNtZCwgcGFyYW0sIHN0YXR1cyk7DQo+ID4+ICsJdHJh
Y2VfZHdjM19nYWRnZXRfZ2VuZXJpY19jbWQoZHdjLCBjbWQsIHBhcmFtLCBzdGF0dXMpOw0KPiA+
PiAgDQo+ID4+ICAJcmV0dXJuIHJldDsNCj4gPj4gIH0NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmggYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oDQo+ID4+IGlu
ZGV4IGQ3M2U3MzVlNDA4MS4uZGM5OTg1NTIzZWQ4IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5oDQo+ID4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmgN
Cj4gPj4gQEAgLTEzMSw2ICsxMzEsNyBAQCBpbnQgZHdjM19nYWRnZXRfc3RhcnRfY29uZmlnKHN0
cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCByZXNvdXJjZV9pbmRleCk7DQo+ID4+ICBzdGF0
aWMgaW5saW5lIHZvaWQgZHdjM19nYWRnZXRfZXBfZ2V0X3RyYW5zZmVyX2luZGV4KHN0cnVjdCBk
d2MzX2VwICpkZXApDQo+ID4+ICB7DQo+ID4+ICAJdTMyCQkJcmVzX2lkOw0KPiA+PiArCXN0cnVj
dCBkd2MzCQkqZHdjID0gZGVwLT5kd2M7DQo+ID4gDQo+ID4gVGhpcyBsb29rcyB1bnVzZWQgd2hl
biBpdCdzIG5vdC4NCj4gPiANCj4gPj4gIA0KPiA+PiAgCXJlc19pZCA9IGR3YzNfcmVhZGwoZGVw
LT5yZWdzLCBEV0MzX0RFUENNRCk7DQo+ID4+ICAJZGVwLT5yZXNvdXJjZV9pbmRleCA9IERXQzNf
REVQQ01EX0dFVF9SU0NfSURYKHJlc19pZCk7DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2lvLmggYi9kcml2ZXJzL3VzYi9kd2MzL2lvLmgNCj4gPj4gaW5kZXggMWU5NmVhMzM5
ZDQ4Li44ZThlYjMyNjU2NzYgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvaW8u
aA0KPiA+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2lvLmgNCj4gPj4gQEAgLTE2LDcgKzE2LDEx
IEBADQo+ID4+ICAjaW5jbHVkZSAiZGVidWcuaCINCj4gPj4gICNpbmNsdWRlICJjb3JlLmgiDQo+
ID4+ICANCj4gPj4gLXN0YXRpYyBpbmxpbmUgdTMyIGR3YzNfcmVhZGwodm9pZCBfX2lvbWVtICpi
YXNlLCB1MzIgb2Zmc2V0KQ0KPiA+PiArLyogTm90ZTogQ2FsbGVyIG11c3QgaGF2ZSBhIHJlZmVy
ZW5jZSB0byBkd2MzIHN0cnVjdHVyZSAqLw0KPiA+PiArI2RlZmluZSBkd2MzX3JlYWRsKGIsIG8p
IF9fZHdjM19yZWFkbChkd2MsIGIsIG8pDQo+ID4+ICsjZGVmaW5lIGR3YzNfd3JpdGVsKGIsIG8s
IHYpIF9fZHdjM193cml0ZWwoZHdjLCBiLCBvLCB2KQ0KPiA+IA0KPiA+IENhbiB3ZSBub3QgZG8g
dGhpcy4gVGhpcyB3aWxsIGJlIGhhcmQgdG8gcmVhZC4gSWYgd2UganVzdCBwcmludCB0aGUgYmFz
ZQ0KPiA+IGFkZHJlc3MsIHRoaXMgd2lsbCBiZSBzaW1wbGVyLg0KPiA+IA0KPiA+IFRoYW5rcywN
Cj4gPiBUaGluaA0KPiA+IA0KPiANCj4gVGhpcyBpcyBqdXN0IGEgd3JhcHBlciBtYWNybyBmb3Ig
cmVhZGwvd3JpdGVsIEFQSXMuIEkgdHJpZWQgdXNpbmcNCj4gY29udGFpbmVyX29mIGluIGR3YzNf
cmVhZGwvd3JpdGVsKCkgdG8gZ2V0IHRoZSBkd2MgcG9pbnRlciwNCj4gY29udGFpbmVyX29mKGJh
c2UsIHN0cnVjdCBkd2MzLCByZWdzKSkNCj4gYnV0IHRoaXMgY2F1c2VzIHRyb3VibGUgc2luY2Ug
d2UgdXNlIGRlcC0+cmVncyBpbiBzb21lIGNhc2VzLA0KPiB0aGF0cyB3aHkgaSB1c2VkIGEgd3Jh
cHBlciBtYWNybyBpbnN0ZWFkLg0KPiANCg0KV2UgYWxyZWFkeSBoYXZlIHRoZSBiYXNlIGFkZHJl
c3MgaW4gdGhlIGFyZ3VtZW50LiBKdXN0IHByaW50IHRoYXQuDQpUaGVyZSdzIG5vIG5lZWQgdG8g
dXNlIGNvbnRhaW5lcl9vZi4NCg0KQlIsDQpUaGluaA==

