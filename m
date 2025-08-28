Return-Path: <linux-kernel+bounces-790839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF2B3ADE1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DD33B1F23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287C42D0606;
	Thu, 28 Aug 2025 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fAXSYW0T";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DwIG9Ksl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CnIY+T5z"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB442853F2;
	Thu, 28 Aug 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421579; cv=fail; b=jFwjNKk+91wGPEpciLYpdjZbr1XwNXxOWRUgmjoHx2npnMO0TdSa0fXyal3qeJ0uBipk+RYfp2+l7mwiEWd3srlZc+BuZ5YFI0YLwZwTnFoH6fjxkqSmnqCDMQW/OAjmd8hGrwQQEHzxMY0cQgVoHah9WgDyc0pC7LGaMNlIi1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421579; c=relaxed/simple;
	bh=4ADmmmhiHqsUWxlXl6JZWe5ACXbB3CB+CL/4vvu9xtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VvZ1RQ9Pjp0VrqavzFZqvHxweOYqWOuTBqfNdcJ15f+Dd89FT6uEVDAkg/FgjDuDF+lO01Hm8jqTcrXtRkVPPQ/tY3kn4vb2wGSeSJAUntMDhoNrEF96CK2+ILFQ3zZKijmo8iXc7AkYNj9LnNEwsAvPCTlzgNyVkPYg8iiaSS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fAXSYW0T; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DwIG9Ksl; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CnIY+T5z reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SIknHl020836;
	Thu, 28 Aug 2025 15:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=4ADmmmhiHqsUWxlXl6JZWe5ACXbB3CB+CL/4vvu9xtc=; b=
	fAXSYW0TJ9bixaLUu4BNduy3Bh9SubnmQW7QAjuQQO2tmZmy5uxEwFM9CawZACQP
	pK+EOClQZ0FuNrP//VZlV9i2SSkKMLES9xCnohniaV56Ai+R6CK/5UHE+bgK0OdP
	O8MQ+dluwiI8WVYAdEfxjPN3TEJRo0UOV+TCpjeXlbDR8KGEmMABFqTWrkXHeOz4
	9qVtpUmHXGRLo68q5StFTxvKvimKloYugb8YyZ4CZZ6x4j69oXeGml6z0daZF8WY
	ONeYBaj9cUB5l+8BYIKZTZqCQNJWcYl+zu8vwjzR/MtEItvfmNHoOEpruSddp/bn
	MUK6xLQPKmOz+CtjSoHZbQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48rpxspdrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756421517; bh=4ADmmmhiHqsUWxlXl6JZWe5ACXbB3CB+CL/4vvu9xtc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DwIG9Ksl/yvrBv4QxObkvW8FIWkMaEQ3mj7d0wK81IXiv60/75H0ynPAn9XBnZ0I3
	 pQlt0M1O63djj2a2i8SLuUmqMPa3LBa/+D+qZmMWAKVPzUsmeD8kyVIUM9LJj5KqML
	 oUlWCvoZWjxjUgGWTUUbA4exJ5tZ/DGwge7uJSnAnHet9EUD/7u0FOaLWD+km6w+wG
	 NyKoUWgtU6g5EA6M1+HYM7XhoWdyTvT7BOwmK2CZ0T+/S1+p5SbTblmyydTJY9O7xA
	 gCeTmix+Z9yPs/WlZZtqfFtVsXOQpMR/EmZvrtZi6AvN1WlYlUz5awDgvIzzGpxQU8
	 fli8+AX2ofiKw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 050D440517;
	Thu, 28 Aug 2025 22:51:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 0E4FCA006F;
	Thu, 28 Aug 2025 22:51:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=CnIY+T5z;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D39B3405C3;
	Thu, 28 Aug 2025 22:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5dPW31GEkoFqrb75/qUjTbpsb4xZ2zdi267ugUmp8ZS31avYM/i2tFDss/WvjSpE5PqzCFNoJ//mo2FWRN+e/FFzUfWrveXAvLVsuA+vdyMPGLrbNGIY7qiay2rRFiar0Wq6Afe0yxcKFV8WgU3e/KBq8zvqJxeevpRLGij37ypNLeA/VSHbgGYEBJ58KiJB5mRxpWoB9Nt2XFG3/UZsrERHadN6Y+Feup7tWsqU+sYPMziHiv1B77ZmqPyEtK9tZmyaqZp638nNHvoOVPKgsCm6Tryak7o54XyUvN9e7Rot9Hj5nbjdk4m3HYIlnMVo86aM+BQJBCRquCSYczFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ADmmmhiHqsUWxlXl6JZWe5ACXbB3CB+CL/4vvu9xtc=;
 b=kLNv5HW4AskMFCApt9NVcj3xEMZJO/qxtct5LZNSr33FAe2jLfigpIG7clVLaEQ6rgmcftM1/zXGgEZGicyje4m3CfyDSCJMk6vgZbGbeHGscMTq2n5n3SRgrzsTHv/0Ym2RW+w2S2iJ4FMO9wx9vt6qG50cLVOMV9DKzCWHhYf7Wc+bN5eriyTfUb1FYJBNqq7EL5dI8K9yGaSqeTJazO7KRXK66zXHk5szn9zN1OzafyKOmblxuzeXlQNgV+yGvpZFjFHG65TyyKXhymSzh/BtH/yOP799cJEOyMgLfisqLVTvFifgVK/PLuYev5RGbbRH1UdekQrD5K4pOn2fcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ADmmmhiHqsUWxlXl6JZWe5ACXbB3CB+CL/4vvu9xtc=;
 b=CnIY+T5z6d4hTNoZmkBPFZefLUAxkVE+Fws949F4QLiKuwVXi9LnxqeoAMiR79gr5JxHuy7V5XNJ3Yx23Xbm0JAdTXP54VNDKAzYwxDEs0InlJtUKIGAqKnQ0mqxbaEfGOTX2VlglGmcXmIDtRkujPf5EZNo5ky8Aaq3CMhNF8A=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 22:51:47 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 22:51:47 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Sven Peter <sven@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH RFC 07/22] usb: dwc3: apple: Adjust vendor-specific
 registers during init
Thread-Topic: [PATCH RFC 07/22] usb: dwc3: apple: Adjust vendor-specific
 registers during init
Thread-Index: AQHcErHi2Now8OYB4E+7dzV5JFuJ0LRtraoAgAJOm4CACLr/gA==
Date: Thu, 28 Aug 2025 22:51:46 +0000
Message-ID: <20250828225145.lma4lp2afvmuop2l@synopsys.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-7-172beda182b8@kernel.org>
 <20250821221832.zsn4rk7nomsbgytx@synopsys.com>
 <0289f92d-0d18-43d2-b98a-da8bb08e9342@kernel.org>
In-Reply-To: <0289f92d-0d18-43d2-b98a-da8bb08e9342@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB9738:EE_
x-ms-office365-filtering-correlation-id: 6cead652-c36d-4047-f093-08dde68577bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlRLeFhtUGIxb29xRFIzMU5NUjhuNlhDSTVNRlhPenZ2L1d5Zy9OVk9pOEZW?=
 =?utf-8?B?ODZ1WTZYNjYxNjBNYnRhYXZlR0VmcmxaSnM5d0VjbDhwOXlVM1FhdUpiSzdQ?=
 =?utf-8?B?VzhOelRtSEV1WExiRHplL0V5dDhUQ3c2dVhUL1ZUTmFLSEtDaEd2a2FPYkFL?=
 =?utf-8?B?c0dIcHYzWWhsdndwMkVhZnE1ZFdvdjJvTmw1MlZKVHd6OHJYSDlSVWVtRzNP?=
 =?utf-8?B?RGl3QVdpOVZwWEVLbTZGc05Ba1NVNUFTMEIyc0Vub0ErRjNKUU9qYW1mdW12?=
 =?utf-8?B?aXJKYjJIRndPL0MyT1hFQ3M3Y3RhZ21zdG10ekNQdFNRZVB4bTZES0YvY1BZ?=
 =?utf-8?B?TVRoVlRPUDIrekE5cHZzdTQxOStvYXFCdTJyUmNYS0lUVERFTzcxVksyWDJh?=
 =?utf-8?B?WUJwV0dKVTdJSmJaR09EMWlFOWxxUmlnK1lkQ3JKdGhlQU9Bdm5XcmhhLzBt?=
 =?utf-8?B?aUo2R3R4RXRKVWErZ2RxMktBcXlMM3h1bDY0aGR4bUUzZXJCVzlJU3JKVmpt?=
 =?utf-8?B?bEh2Qmd5aXlRZEJIOStiRzg3MGlUMUsranAzaFNBMURRRGljZTlZUE1NNnh3?=
 =?utf-8?B?RmZXTDc3NGNtZUhncTd4NGNsdzBIZ2ZLcGxZZW56UzFnMTE3N05PUzI2L2JJ?=
 =?utf-8?B?eHdMOTRFOFYra3VoUWovVjg3cHJHTFVaa2VBQW1Sbm9aNWZiZEdKZkNvTWJD?=
 =?utf-8?B?ejN6YlkxUTNJekl4ZGd4ZzIrK3JBYVdZQ0NNbTJxL3ROeW5xdDRwcU9mR2NZ?=
 =?utf-8?B?N3A4MDFzNUlMNVcyaldaMnRRczN5eUQ2aGEzN2xaaVgyS3VMeWhERzcwVzZi?=
 =?utf-8?B?TEF4NVR1aC83UnZHRUVwckZlclo3YzgyRUJWV3J5ak5qVWVDNHRUS1NkU2VR?=
 =?utf-8?B?ckFTc1BiaUhZK3l6T0FqR1ZZNUp2V2FNTE1XdlViVENxV3k2eHpzSlpXWFAw?=
 =?utf-8?B?cTU0ekhId0NCRGxwTDJVZVZpbnM1d2NqN05wS2VuV1VDNTRoN0lJM0FuMEJq?=
 =?utf-8?B?RXN4a0pRSWN2dG9FMVlMUmEvTGZCYmsxQ0FJRzcrUDFPUm51dkltakFRWllj?=
 =?utf-8?B?NzZYKzAyckZKc2J0NTVjbTM2cmdjREh0dWdRM0hSejJpQWovdUNPUDVwajg0?=
 =?utf-8?B?aUZwQTNRSTRadTAwRDhTWmtjQVl0YnZXK09hSzBVR1FtblM5WVF1a243Ukxn?=
 =?utf-8?B?R3l1cDlCYlF5bTZENXhJaWhLdUFidjdsTWlnV3VlRUNpTEdnZHhPRDhsN0ZF?=
 =?utf-8?B?M1dwOTEvZW9DMEUzUzVEelVKYW1rMk1Ya212N1BiUW1KQlJvR2J4TUhsWDZ5?=
 =?utf-8?B?Y1NMaU5sRkVZai9YMUd0VlpCemZzWnhBWk53OHBmVHN2QjRTQy9tc0xLeVpF?=
 =?utf-8?B?dnFyWmlGeG8rRDZxZnNtdEJwV0xHSGg5eHpsZys3NHBuck8xRUJxOUwyUUJq?=
 =?utf-8?B?RnVzV0FpamgyZ3NpQXNXOFlQRWk0VDhLTUtGeWlpazBRekZyLy90OEZxUk5p?=
 =?utf-8?B?VitrUnc1SDB5bXBHellTd2c0YXdUOU1weFpZZ0tXbWpUc21pZFAzT1FYOXcr?=
 =?utf-8?B?dVJNclMrcTRHMWpaeFZUYjRadWpYakxxSER4bDZjQ05zZVg2Y3U0NVVILzlS?=
 =?utf-8?B?QnI4czNUVGJTNFpTVkM0QjBETzNyNHFtVGtkSW5lREt2K0FvaDN5enhHNmxM?=
 =?utf-8?B?Mnc1UmdTVUNucnFtVDhnY1dkTlhwd3BYU21tSlhCajlrYXpsVEVyMnFDK0J3?=
 =?utf-8?B?NEJtdUdlQkJoUjdmUEMzdzg2UjI0YTdvYXNiVExiaEpCV05TN2RjSWp6Y1Q3?=
 =?utf-8?B?d1pCTVlVc1M1eklrZ2RwR29mcEcrN3VKa1pnNmg5YndrbStQeWMyMnpFb0Fr?=
 =?utf-8?B?WEtlT0t1UVAzdzM4TGxlNFp1a2g2UGViaWhaeko2eEdSaytuSDRZVmRUUDVO?=
 =?utf-8?B?bVZYeWVObGhSN3JRZENzVEZ0Skt2a3ZEQ1NmSEh4TjZYM3lRUmwybzRmc2pY?=
 =?utf-8?Q?7O0m19Aors5lgWrEWTync2gGEFpaVk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cW5SZW0xU1FXeTI3WGdqNnlTNUxzV2FIaUJXNmJFNmh5R1hBbDJkSU0vcWxv?=
 =?utf-8?B?TW42RTREMTRrbE81NEZSTU9udVlKam91aS9Lb0w5Z0hra21TbmREZVowdDhh?=
 =?utf-8?B?VVZ2bHd2WXpaUjJSZTZPYmZYVjNaSTZteExCc1Z5N3YwQndzdmdkV2h6WU5N?=
 =?utf-8?B?clpHZ29jK2UyQktKbk9za2s5WjNqK0xBRHpsQmNUdFEzVkl5WEFBdEJneEw2?=
 =?utf-8?B?MkRlZnY1RVphdHJUemM2NFA4K2VscC9VeXlkR3dtRjBMYWthcGRGM1JWY3pT?=
 =?utf-8?B?Q1IramFYcEpLYzNYaW9uUlRrZHZMdndpSm5wU1hhbk9pQkhVNzBJakJpVXpS?=
 =?utf-8?B?akpKYnoralF2L0Nzc1hoYVRGYkJTTURkWXZwYTlpVEFudG1JUm5Wd2lKb3o4?=
 =?utf-8?B?NlRLdmQxWTU3WlhHSU9hcEdyMWM2bWJWK2RrcG9RZy9NS1RxcndRWm5rOHJL?=
 =?utf-8?B?eDBGcTR1R1M3T2hjY01KZC9TQVJEWTgxU2lpdUwvSUwvRTNLakxqa212eDBP?=
 =?utf-8?B?YVR0ZFd0RnZsZ0lObTNiZVF6TjVETll2THM2bjdWVndvRVRHdXhIRlZ2RkVJ?=
 =?utf-8?B?b2EvQ09FUmJBVzJqWE1UdUpSd01MTmdNZks4MzhQcVJzOTZwS1VMdDZwUUpL?=
 =?utf-8?B?WHhwQm9BSFNoRFNFZHZldGdUcFliVTdNbEVycnJYSnVmai9vTXAzS0ZaY09C?=
 =?utf-8?B?ZW9ySHRWTWh4aUJobC9PNVdLMmRMV2NIZHRnZEVXRlk0SjVaT3NESi9HNC8z?=
 =?utf-8?B?cTB5czZXcnE1MkFIOU9wN0hFZHZLaklSenFsUVIyRi9PcnlNYklTVDlZQm5L?=
 =?utf-8?B?VktYT3VtSjdVVWovMkdVZlJJb2RaanRyWHZEblQ0WlRnQTlySlBURU8wcFh2?=
 =?utf-8?B?akllWFA2WW1EbmF1ZDhrWVZ6RWRKL202RmdDUTNjc2x6dkdvM0xBMjJRQ0F5?=
 =?utf-8?B?MEQ0T25hajVGMndPNXpCcDhVTFRtb2lpZmljSkt5T2grK3FFTVNIUFF4ek1y?=
 =?utf-8?B?YkZtREdVenZjcGtCU09MRkFEZ1M3SHVxS2pGMTFUYVBiK0kyMGw3dE5ZS3gy?=
 =?utf-8?B?b0xRRDhGTEpTZDV3SFdZbjlQOUdVWVFTNTZWbVY0b3M1bmNJYklaOFlCZk8v?=
 =?utf-8?B?M2NhWmlMdGorYUdUNnNqV1lHdDFEUGRMZHRPaXdpWURYQTVBVFdWWDcyV05y?=
 =?utf-8?B?NVlMWDNKZzVZRjBKN3FDb1ozT09DSTVmak9GcFVQUHE3MmtFZWllQThCUWFL?=
 =?utf-8?B?VDNxVlFCb0tpRVBJdXNyZTVKa2hBTGJpSHh2NHhzakppYmVkY0VIeWVCb2ZP?=
 =?utf-8?B?K2pWamFQSjhuODY0b2p5MFZDNXo3K3kvd3VIZExaSU4zcWpRaVFaTUxwU0l1?=
 =?utf-8?B?ek1uY2M0bGNibDRwSzVQWjhLb0d1TzJieEVCdEVJcXVjN25HKzNLbStXVHdl?=
 =?utf-8?B?N0FzYkYxaEtaa0gzVDBhSXJXV1M3QUNaMjJKVmxLKzRpME14c1g3V0Z4Nmpi?=
 =?utf-8?B?OXlnVGJpMUhXYWZpQTN1bHNUcUU5b0ZCZWxMK3JoSHNBQlZpU1EyRUl3SWxr?=
 =?utf-8?B?UGdhSno1aU9iM3k1Z3ZnVG1UQnB0K1JvTS9hNlR1ZWdWVEE5WFVOdENhVnpK?=
 =?utf-8?B?MldneUZ6S3UvcUh2ODdHTkdrVUx4MjNmSmZjeTY5d2MwY2FMZFV3WWJhMzgz?=
 =?utf-8?B?SUlVMUpPd1dOQk9wRXFJRnJVR2VZUHRGRHN1VENGaGxnbWErRWdWeHJwUmY0?=
 =?utf-8?B?WUkzQkRZejlFWTNNakVLM2MyUXVWYzJaM1JJZ1VCL0xpZEVSeDZxRTdCRVEr?=
 =?utf-8?B?MlJ2ZDB5ZGNJWDhlZ3RSdy9oVElhYU9NRDBTK1JBb0JGdGJRZjNBVHF3UDVl?=
 =?utf-8?B?R3k5VmIrQVB2Rk5laE93dmwrVHdBNzdRZVp4WFpTNmVocDltdTdTWVE1bVAw?=
 =?utf-8?B?V0Eyanc3NnFRYXdrdTJhVTMrWWk4dVI1SzJKR25KcCtqc0pWMk9NOFB6R3JU?=
 =?utf-8?B?TUEyYjIrVjhIa3JCV3hUQVJxN2xUeUJ1Z3YwTUJMbm9WRVFBa1dkcnNwLzE4?=
 =?utf-8?B?Uk9MYXJoYWQvTmJnSTJaTmgyT2VRRzBaeVBxQUtTaUIvU1ZWa1diSXdReHg3?=
 =?utf-8?Q?avjkv5f24ERuwv4dfxTiOxXRt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5573688383EF344E9BCCE39A9AF2BB35@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NK1nxEe5KcmcYBFYF2hMYWLTn4jlxU07+Q6KdkN2H/cM6koKY3rgrX+/XgCrMPk2vuLpzv+q9qYn8rD3UkZBKDNTClD2ug/f+3hbHKk2H/n/iPmD2H3ethfvOxnzARgLr3ri5r3mMlP9UJsrr4fhBvBLkSYsWYaMNmeNS4KmO9xcDVcg3CaB6RN/dpDmPtDbLG9nfv5ebaPcvpDQQsKj8dNW0cXV9Ki7zp6s0+PRCzBxkdfk4y9hlE6VVmSjNJZ30r08D9zHt25boewsdnUP8W5GeJyipJN+rHYPeJlgTOT9RI4K+yt2ZjZomxwt8QonwL1QtfPhxFQ7ZHBzMZKHecx3uuOq0HUFj0ZC77muovePEdCAlDStOAE0D3Eg+pNt5S8lOUbGQMerXfhsTw9byA2gJCB99adgf6Luv51qNS0vHNuE6E3t7WRtbPh8JcktD1My0O81AEkZsQY30+8AD2bfYvTpQ+fPgIMjohjEkoxgWz9p2FB9x8bEA89fkAbys888mlRzXYNB6q1x0g5uHua5K+cUuLiADb1w9AwnQFSOMv9BCq3/atOWV80AfUY4WoXI0oElugz8mIDPGkTWYstwFnNFX5raAZ5U6UpAk3ukqH+HRJhqpuwf2yI0JlTO5TDD7QrplkPUUbtc0T6GzQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cead652-c36d-4047-f093-08dde68577bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 22:51:47.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wklFNyfbRffq9ZPgai3VxRiRwNiFpaFox7+jhFPPj0CYoAiYKa8UGwim/51xWR9t7QCqfjqFzX4Db2Vd8Ptjew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738
X-Proofpoint-GUID: 6K0Yf_xNkniFuqWHQmRdPYUXo-b_6-Ym
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDEwMiBTYWx0ZWRfX98XL4f98DuVh
 voUL1jia7UBwNhDiyJ2BlbOyH0MSbdwr6x0cSnHn2BiUB1aiJvChAp9kIVS6oSz3gAceuv7kuQp
 MxEgBze3d1TlgrLGVKXxIuioijJD1n2f4t9KL354RFlEW3Ww7qOjkQCosI0tvPPuuip50vd1XMI
 jbJUtJCO2yptuKTWxl3qpXrb2z6jILuoavOnxZ08tSK+Kfo4tr/N7gDcDsuQLsv3p2e0zaExI1t
 vLTuf5oEDRkMDnrDJSYf+T9F8GYHBU2M8OdmjNe6UBIufKsVUzloAZ1abdmNIYUlsHGUUYNZ4i0
 /8XFYget2y8qZCQjJ1GslrPHBqPGSfB5+us5vguYSF26xoZee3kJy3o1wkbwIyB0f2d9LN0VSpO
 5JAubHaV
X-Authority-Analysis: v=2.4 cv=aLTwqa9m c=1 sm=1 tr=0 ts=68b0dd8e cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=-U0qHfGb0dM-AjqhiDsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6K0Yf_xNkniFuqWHQmRdPYUXo-b_6-Ym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250102

T24gU2F0LCBBdWcgMjMsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPiAN
Cj4gT24gMjIuMDguMjUgMDA6MTgsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBGb3IgdGhpcyBw
YXRjaCwgaG93ZXZlciwgSSdkIHByZWZlciB0aGVzZSB2ZW5kb3Itc3BlY2lmaWMgc2V0dGluZ3Mg
dG8gYmUNCj4gPiBpbiB0aGVpciBvd24gZ2x1ZSBkcml2ZXIuIEkgY2FuIG9ubHkgaW1hZ2luZSBt
b3JlIGNoYW5nZXMgd2lsbCBiZQ0KPiA+IGludHJvZHVjZWQgaW4gdGhlIGZ1dHVyZSB3aXRoIHRo
aXMgdmVuZG9yLiBTZWUgaWYgd2UgY2FuIHVzZSB0aGUgbmV3DQo+ID4gZ2x1ZSBpbnRlcmZhY2Ug
aW4gZ2x1ZS5oIChzb21lIGNhbGwgdGhpcyB0aGUgbmV3ICJmbGF0dGVuIiBtb2RlbCkgd2hlbg0K
PiA+IGNyZWF0aW5nIGEgZ2x1ZSBkcml2ZXIuDQo+IA0KPiBOaWNlLCB0aGFua3MhIEhpbnRzIGxp
a2UgdGhhdCBhcmUgZXhhY3RseSB3aGF0IEkgd2FzIGhvcGluZyBmb3Igd2hlbg0KPiBJIHNlbnQg
dGhpcyBSRkMuDQo+IA0KPiBXaGVuIEkgb3JpZ2luYWxseSBzdGFydGVkIHdvcmtpbmcgb24gdGhp
cyBJIHRyaWVkIHRvIHVzZSB0aGUgcGFyZW50L2NoaWxkDQo+IG1vZGVsIGJ1dCBkaWRuJ3QgcmVh
bGx5IGdldCBhbnl3aGVyZS4gVGhpcyBmbGF0dGVuZWQgbW9kZWwgbG9va3MgdmVyeSB1c2VmdWwN
Cj4gdGhvdWdoLg0KPiANCj4gSSB0aGluayBJIGNhbiBldmVuIG1vdmUgc29tZSBvZiBsb2dpYyBm
cm9tIHRoZSBwcmV2aW91cyBjb21taXRzIHRvDQo+IGR3YzMtYXBwbGUuYyBpZiBJIGV4dGVuZCB0
aGUgZ2x1ZSBhIGxpdHRsZSBiaXQuIEknbGwgc2VlIGhvdyB0aGF0IHdvcmtzIG91dA0KPiBhbmQg
bWF5YmUgZG8gdGhhdCBmb3IgdGhlIG5leHQgdmVyc2lvbiB0aGVuLg0KPiANCg0KVGhhdCdzIGdy
ZWF0ISBJJ2xsIGxvb2sgZm9yd2FyZCB0byB5b3VyIHVwZGF0ZXMuDQoNCkNoZWNrIHRoaXMgY2hh
bmdlIGZvciBpbnNwaXJhdGlvbnMgZm9yIGV4dGVuZGluZyB0aGUgZ2x1ZSBpbnRlcmZhY2U6DQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyNTA4MTUwMDQyMDcueHd2NG42eHNh
dDQ0YnlkaUBzeW5vcHN5cy5jb20vVC8jdQ0KDQpUaGFua3MsDQpUaGluaA==

