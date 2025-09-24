Return-Path: <linux-kernel+bounces-831335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C636B9C624
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0B319C6142
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66C128935A;
	Wed, 24 Sep 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Mjw8jgv3";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mVNfF1c+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z3G1vMEq"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24325FA1D;
	Wed, 24 Sep 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754254; cv=fail; b=mP98f2CC5jQ7g7B7DksHTv7hHevpSiinKKGZQpvE8fQSHDKqAJ0lxUub83wErj8st4HfcbfRRgEft6IOcysztd+ljjrOyOklwXvu35NRTONeUNuQPlbjzb4p3PdOJpXQxyyVdPfA7pUoYHo2aVrw2tA5WqBkoqDRm7wLGqaJmo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754254; c=relaxed/simple;
	bh=wwQZt4Q36gsdgITUGdPQEPQTiw/mY6teaNgkHHylsYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oRX6daOH1SsjOngGTJEek2nar8L1f+1cmkx5jLGIdel+yTaTkaAGzmRrQcG4Yr9VI+uXBqh3SUq6Dq5TxgUz+EJnLRMYSK9ehEVFk6KJYTDzbS9oNYk5e6nENnPeX7w1xLsn2CbZI6hvosiTrrymjXJqdNaj1gyK3mE98xO8rqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Mjw8jgv3; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mVNfF1c+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Z3G1vMEq reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OKXm27009719;
	Wed, 24 Sep 2025 15:49:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=wwQZt4Q36gsdgITUGdPQEPQTiw/mY6teaNgkHHylsYM=; b=
	Mjw8jgv32N1SIMmI/CZorCVzjN+RGn6Pbs2bMkX4qck7eZ6lYKW7pfhvgOdA1RuB
	9wFHgUtde2tqOAK7LkV1Q2UBGZ8e2o5KIOVEFbGhDimQqsTEb7KKpxdQxlqFVSkJ
	pso1o1WzkeUUDlkciDtxGgY/cPWJJ6SxLYxGGMqBy6TEzBhbL2/FzleiMzqekm7Z
	1mBVor3VnmxNsGezQPIRB040m/gF72XQ+CwfFr2R/Mzyxa8NQFr+aSYgshEMqlvK
	nW/U8TOUiBoQL4anBHGNbMrEaFxIWPaHbiozxJ+n3iJ8VG/5T+sZKowxK2bRqs1K
	KAm2h0jaNX5X9luev0QCLQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 499u9mp6ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758754172; bh=wwQZt4Q36gsdgITUGdPQEPQTiw/mY6teaNgkHHylsYM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mVNfF1c+Ng3SAp7JhpResPcnyX6ew2t2M7Sjr+YMAbTyrLjUc/ceAur2FUzUQbFwe
	 a2HB4OakuUq/4la1tOkzeVUdhP3ncctGrC0MRsuluB0E3bUVpdd5tSPxptXsiHzxJ1
	 OlmK4SG1xiQaJ5igA8yML2PO+iBGgNHLi+dxK3bxbykzrzDpjjI+zyjiFmESRezJXA
	 nFRlhnsmED7OLJ9IIs39xwXSI9mmXo7wyc7ToEDXV2aCOkA/ciMnSYwC8+Cq7kLjWK
	 qfsdVHgfajSyllTFx1Bs2TeDio5YL+/77n3tC4z8UHG2U18EhAOMOxFVmmkW1uuocC
	 +QyQtiV1aa8gw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 91B4340140;
	Wed, 24 Sep 2025 22:49:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 31FF4A006F;
	Wed, 24 Sep 2025 22:49:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Z3G1vMEq;
	dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com (mail-bl0pr07cu00101.outbound.protection.outlook.com [40.93.4.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DFA9640352;
	Wed, 24 Sep 2025 22:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nt8vgVbk6BzdgWCbwev6l4iPJh48aKirdcmFCXMoeQ1KYzRi+n5XV25RH5Wjjc5ZAnn+wgF38eiy4FExAQ5lxT8A3hpfxU+hMBjJRw1brGDgr8WE+ZXpCt10NHZ9Repp629DynFgPP5fPWzT25Uquj+rAP6CiecaoZMUBaKtvmd6qOYIbYlz0LL54G2uxRCAzbEILkhI0Ev/vxRjcFu2+oc/EE2t2aookzTrCkFUktIuCs45CvrPDDTKTzS+JgP4m50DnPJCYHZF/Im9Xkngiv9dDghko+OKm6EYEgMTvOfQ9fC3k93ElbkiTPojUuJaKnnoY7kvEogQYMXpsRb39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwQZt4Q36gsdgITUGdPQEPQTiw/mY6teaNgkHHylsYM=;
 b=XGudDM3k0JEKXeBTsltCdFZYDxcYUf5yDwliBC2eL4wNR9sbwT802c9Zj1GSKuOchFo2/ymKyavhR7kgmtaBhfeL+bZeAW0cw9m0OxXQLovd4xxXrDyHjXaoM5TG+TEZWmU4cyDEUk5pARYukHQVgFr+tfQ6LEPyme9Atc4P3gpPhGzcnEvjgG4iKsSutHTvd7hzAaSq+DiFZV/sfyCh3lRahWnXxREDD5fgKooV0eOJwKhH+cv/UiDjBnukKE6fUhllV7i2hFog+QW8RdPvlCW38mNqZ8KYabgJI9u9wIs8Zn+Y0YRmDNuZsmKm+Kz6LtQi5PL5f03Agq7/ue9FwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwQZt4Q36gsdgITUGdPQEPQTiw/mY6teaNgkHHylsYM=;
 b=Z3G1vMEqoPzXti9UNzLT5TAi18aSOtEbXKtzbM8Jlh81rRqjbLU8bwQR2tFvH1aeQDFHXAKPyFWgKM1h/jl6a2gKB17cGP9OHDQjvOcQ4Yn9W60Ptf7dEYnfYWnTzZecTyUbLAIYTVLLt/yQ7l7T/1JN3ngHY/v5Sl5jE1zlKOI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 22:49:16 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 22:49:16 +0000
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
        Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v2 03/22] usb: dwc3: glue: Allow more fine grained control
 over mode switches
Thread-Topic: [PATCH v2 03/22] usb: dwc3: glue: Allow more fine grained
 control over mode switches
Thread-Index: AQHcH0UIOVAW2qnvKUuy0q9Kv04FeLSbHWuAgADs7QCABwIBAA==
Date: Wed, 24 Sep 2025 22:49:16 +0000
Message-ID: <20250924224912.riddb2chjqrdi2xj@synopsys.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-3-52c348623ef6@kernel.org>
 <20250919214013.gtbaknjrgd375hm6@synopsys.com>
 <5bae4ebe-dd42-4e84-9ee6-c9f6a88f7db5@kernel.org>
In-Reply-To: <5bae4ebe-dd42-4e84-9ee6-c9f6a88f7db5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB7101:EE_
x-ms-office365-filtering-correlation-id: 3cee9cce-146e-464d-d9d6-08ddfbbc974d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTdyN0Z2WHRDbkZ6VmdpakU3ejM5Z2lMbkcxekVsdUZ0MTZSN3ppRDZpVWhN?=
 =?utf-8?B?RExJamtaQWZGUWhYT2JlYUtndVI3UCthbTRMVXNiWVFJWHUzT1gyZFFtVDM3?=
 =?utf-8?B?NHZmUlZILzVFOHk0enRYRDNJMHRUbzkzRFZMb05nNVNpekZ4UTVKVTAwMEpz?=
 =?utf-8?B?d1hWK3AyREw5TE9ORjlxUU9EWUFta2RsUjAyamd1UWZyWjVjN1cybTNqblc4?=
 =?utf-8?B?dFNtTW5HMjhLV01UeDhFL2dldFd5WWE5RVdrTHhZa1pkQkRMMHhyOHM2OFNn?=
 =?utf-8?B?WGtnYjQrSUxiU1ZNZTE0Rks1OGtBY2MrR0VNU1ZaTmYxa21EcjR2OWx3UUEy?=
 =?utf-8?B?a2dmcXpwcnFLZzNIajhrRXNOMmxFODZHUHU0TGMrbFRoQjFUdjFjWjNVUzc1?=
 =?utf-8?B?RTVRWEVvYU8vQkVjc1M5ZE1lVGpoQXlJckVrUDVVN2xyZEdSbkprdTdCRjJJ?=
 =?utf-8?B?aHVzQUtmUGlIS2M4QTh6V21zV3dlcko0ejBxT2JoZjF6NWx0YmlrdTlwWG4x?=
 =?utf-8?B?cGYzVnhLWHhoVVFVZzN1SFk5VWRINUdoZGUxdC8weFhGVG9pQkgzK2hEZEFG?=
 =?utf-8?B?MnI3Ymp6blRadDlmYzF1ZGdkWVQyMVNTOGZRQXk3S1RYbUFpNm5pSm5HMUI4?=
 =?utf-8?B?U0dDQnBiQU9pOWRzbng2VktPT05iSlBDdmc3RzJwRWZueEQrbTg2ZjU3bVNy?=
 =?utf-8?B?NUpsVk5mcTd0ZWVMOVBPWU4xb1duczl5UkQzSGNyb2pSSXd0RHJmeHhRbFVL?=
 =?utf-8?B?cXYxNk1YanFBeVB4WmNEQldKdkQ5R0UvYXFBaTRZU2dHazFVMEl0TXJxKyta?=
 =?utf-8?B?a2pvQ0c2UmpsSlJnZWd1QkJMY0c4OFNmR0prTklyQlZUS3hscXhCM0Y5UERu?=
 =?utf-8?B?eHhKeEZMNG5rRDBrRkg0bW1WUDVmdGhoSjYwSHhhekMvZ0I0aThOcy93aC9S?=
 =?utf-8?B?SlJVOTNOTFNoMmovNzZmalMyaUhhUHp4ZHZHOGNQRmZMb1hSc0hlcDNTZ0dq?=
 =?utf-8?B?akNHMFdwREVySzJGUk5FWDNpaE5KV3ZjRlEzb2NZOGZ3RWpSalRRQ2x4bW9Y?=
 =?utf-8?B?MTZmdERBOXY3UGFicU5XdXBjUWxOUXZkQWVDeWFOS3ROb0Z5ckY4enBKOVBs?=
 =?utf-8?B?R01oTG15aU5Bb25mQy90NVh1KzltZHVOVkNKeXh1WXMyUVFJOHdSRUtjQnAw?=
 =?utf-8?B?YmIyTExycEZsN3phbVBKSGI5Nzc5d3BPb1lNNjllYW50b01xTTNNdERWWUdV?=
 =?utf-8?B?UFppS1cyV2JUL2k0aFQrbWhXOHFDNEU2YmcrMWpSNmR3VzJuUEpLalEzU0Iv?=
 =?utf-8?B?QVNIQUhiL0hmU25WSitGOStZdS85c1JqQ296V1dmYlgzUE5WRGEzbkNDMFU0?=
 =?utf-8?B?RVRneStEaXh4UjQydDRoT2NIaGZ4TmRqaFlkMkhmLzFZd280M2dxRG5FQlhv?=
 =?utf-8?B?RDNUSUxZUjU5ZlFmdTZlTGhHY1pBelc3a09JNFNpU0RpR3JSOW9tWU84RjJ4?=
 =?utf-8?B?NkN5L0dod092bHQ4MHBaQjkzU1ErK2dENXhBRzdxN3Rxc1JsU2U4dXhUUUQw?=
 =?utf-8?B?TVp4QWNOdDNDclJxL3MwaGZKZmVTZVFYZ1RYRE5TYllFbGdTOCt5amQvTjBl?=
 =?utf-8?B?dlhOd3ZPVGVZdjhqUHk5TXVkR0RpOXZ4MFRwd0RmVC94cFNOSER5MnpYbjk1?=
 =?utf-8?B?RzM1VkZ0MlkrUGpxVURsNTVDdUtZNFZBOC9IOFhPekNObHZDTENaMERPWUE0?=
 =?utf-8?B?YTRsN3VmeVdkNnR6NWlvaU9SMHZieGY2RysrT1MyTDhFeTZMZ3FnVGd5WDMv?=
 =?utf-8?B?N2ZWc0xEeFBTaWVIa2ZGZXNJRDZMNFpPMGxPVmZsbTU3OHRadzRFRWw2Tkc4?=
 =?utf-8?B?UFd3ZmRsUVhmNnZKeWhvODdpVHdrZDVNb1JUaDRTTkdqUUd5Yms0RzFhRGI1?=
 =?utf-8?B?Mmo5SW84ZHJsRmFobkpZakJmN1RtL1poUW5Md01DeFYwdkRRL1FYTzlScm4w?=
 =?utf-8?Q?LmZe1jP/e80ufEky0EHe2+rgAIto2Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUdBdHYzNUdzaHFOK0I4ekZUWTM4NTZaT2M2WDl2aFR6NWUwZ3drSXliQzdY?=
 =?utf-8?B?RmRkeUVFUjlYUklKTjdKaUZpNW9uOS93SEwxWEFzZWRWRFZNc2pHR2FWVmZq?=
 =?utf-8?B?MUpPTE5mQ3RYTjVTNFZlNldVSjMramlzM0p6dlh0Nm01UmxMRG5reTBVa0Vu?=
 =?utf-8?B?WkRHaG0zNkU4cndiaGw5THN1Y2tEaUJPTnlNTFNmeUxrOWdYejlnZjg5eHBj?=
 =?utf-8?B?MWdmL2F2b2R6STl3WUVyMFVFNVp2UTYvc0Q1Y2RQbC8wcU1SRDFwNmpDT3Rn?=
 =?utf-8?B?VURQeEVqQUJBMmowNDRiOFRkVENTZ0ZEMkRuai9YV2VQSmtCc0FEbjdZdGxs?=
 =?utf-8?B?QVRuY1IvMVlwZGRqUXlxM3hhTnJaYlBmTmdGeVVLQ2cvM21KSEdDb1d6eDhn?=
 =?utf-8?B?L0Fxbm91RDlxOEVmQlZuV2NoU0RZNURYM0lqNXBJUHFqU29zN3g4enFwcDhr?=
 =?utf-8?B?M0pMSHFJT1Jwd0xpeXNHRklXUnJhaFMrQWxFcXhPWXEyRUt1S3UrOGc4Sjlr?=
 =?utf-8?B?RG1VcjB1L2RrNVRsU1VGSTd1eTVWT0p6S2FIUWpvRzU3dDlFeWliNGtDUlNV?=
 =?utf-8?B?MGlrNWNVYWFTQVZGRlNrUGtRLy9KK0RYMWFMZFpEdVU1SDA3Ymt1U0QyQ3Mv?=
 =?utf-8?B?STA4cW1rV1hUbWpwaUJUSnhTM3BDK3hmRzhaY25rWUxKbksySUVRaDdUb2pi?=
 =?utf-8?B?WG9YcC9XZDNzNnZubjZmK2dHNE9paSsyS1FEUjFyeXhDNTcxNjFEYys2NTVW?=
 =?utf-8?B?YXdpeTJtUVBsOExlcUJqWUppUnpRaXUveFQ2UVA1WnNhR3NlVnU0bEFwczRS?=
 =?utf-8?B?NGcxbTY0Q3E4dTlXdUJCQWFtekVjY3NzS0hRYVlVZGNYRDhCVzBtS0R0Ry9H?=
 =?utf-8?B?NjdUNy9vVmFCems2NlNKc2R2eDd1NXRGa0V6Y2x6SHBhUmN5T2Nwc1BFbTFU?=
 =?utf-8?B?NVZLQnZMRGxWQ2ZJQlZ6N1p4YzRRNzR5cFhrUWUyckMxS2RNbGM1Znh3NFZE?=
 =?utf-8?B?S1ZKSG01TmpmS2lrdmdSNGRDbTdtUmc2T2VkR0JOREY1MU1rWWluRm1tWUNh?=
 =?utf-8?B?enRGY21YNkxuWm1URW1WUnF6dDVaRkxYZ3ltVnB1QjFpYUlIQnN3M3JBbDA1?=
 =?utf-8?B?UjczZ3VhQTgzc001bmdqZ3dLc3pyRmJWLzBmeEhXdG1oM01PdUdVcUdIbytE?=
 =?utf-8?B?LzFmYjhnZ1QxaDRrMGdnZUdkM2NqclZZaHRERy9WQ3JYS3lTVEVPNDAwejNR?=
 =?utf-8?B?a0FlZkp0L29zRjdSZVkyWnJDcGZueUxZY3hWUWUvNCs5emVQcUhiVVdJS2d4?=
 =?utf-8?B?enpoSWtrMksycWp6c2d2R2U0Z2drMUxMOFlLTHNMc3JYemtvWjJ4c0d6dWJi?=
 =?utf-8?B?VXZUVnY2R0dMUWhiQmliS1R4ZlJ0VzhuL1ZjcGUyV2ZsZU1LYmk5UW16S0du?=
 =?utf-8?B?cVBleUQ3clBpbEdFRmN5MTltQkkwSUZML0lmaVBHeEVjajJDNkNKS2NzWXVv?=
 =?utf-8?B?Nmg1SG5LZVpRU1RGYjJJTVhiM0lIbE1BeHBFNTJFRS9lOWhBOHFESzdLTXNR?=
 =?utf-8?B?bDFxdlpwczFsNVFIV3c3OWVzNDFyQWxzNkJzVTBHaHFzamhZQjNPTWlub0Nx?=
 =?utf-8?B?K2xqQmRCY2dYVTJCU3RrcEw0cEorVVg2RjZYYUFTTmRoUERoYWJlN0RRN1Bt?=
 =?utf-8?B?WmttS2JtdCtOTm5kQnU2SkVrQzI1OUYvYXE4VjhycndyT3Z3d2M5a3hxdno4?=
 =?utf-8?B?cVo3Yjcya1BGOVp2TUl0ODU0VTVrNTgyeGlXdGV2Mm41QXNob0EzRUEyOE9p?=
 =?utf-8?B?WkNzeWZianZGZjlMVmwvbXRFcTZUREY2dGdvWHJzWER2c09WdEh3UVl4Q2I4?=
 =?utf-8?B?NVd5dkQ2NHAwWXBXWHZybjl5ODZaNlJvNFpwNWRUVW4vdFlHVmZjUDg3Zisy?=
 =?utf-8?B?U2QwTTVWSXZjOWhoc3FweVVvUllTdnFYeWVUUjlyc2hUbUc0N2E5M090L2Jn?=
 =?utf-8?B?d2U3RlpueUdSMkZZajVvSEc4OVM0UGlCVGd6c1V1ZGdPR2Q0OFBHbi9iMWRs?=
 =?utf-8?B?RjcvVEtiRng0N2plSlV0SkpuaURScjJNRHBteHZKcHFUd08wS2hsdC9NUG9h?=
 =?utf-8?B?aFFhVDlwc2lLVmYveXhtci9USXRZeU5EODBpSDVYRUxXMi9kVzVjV2pteEN5?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA7F93E63B12E04F9F7F3F5E7459F47F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K36sgIRn4UTK3YMve2jI7ERUMv1YZrlwQDCMdqOid4maXjLlbzwf9mVwQygKZjliNprMVNLM5vj6Wil6O0cMgXv/PkbF7O8DNJuINFTt2D6qa8QJ6riJG0fSDiqEhQJX3RNXdUKcW2dVQbwHg0lwkPoTLdyTGnkdOtZXtSdLCbIQPOXTkR8koRkjeUJSpwurzHEv+g3Oyakb3GPZUJNKTwcpUmqqXpsEUSlK6aQCu8LVJEoJg1Vqtl1MGOcbb+doKF/KDFZwBrMfp5yuMS0rHVRJ77jiZzy3/aQJ5rsI/Tje/nJAmpFjdDJWg4XC5sC16gp1/5cNcxvJfvm6ICGXo1SIqZEIEjqzTGstNPp8QCV439Tw48i0eYtF2+7YrkvfM/B1g23kfhSmavh2tLfLBwaGzt0PQKkiaO2uMy7AVDAZBbunrpz9xFBI0Achi4O1DqVBJnrA4TtQAhTy+lRhWpYbZx3BrZHznvUxVI/bnmKVpCbaG8BdNkTE3ZDfcesxWq4frhv/Ck+2s2KDEINdQcWi84gE+zWfMb/pLpC3gLb7LFom+18nTXxofQAaXuceW31y+lIku9ojRQMahCz/mYNtMMFvrzhVMJ6lynt1IYWO+zJC9MyOSnlwvfCSR+uMQDuV6q18iecT4ovSLxA2xw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cee9cce-146e-464d-d9d6-08ddfbbc974d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 22:49:16.7304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Z7fLHtb4HZRQrZbrdIUDWpAbY/K60ojAlgj48YuNwd4hyNTy1nyGyyndMlM5JYHNHtx2EDufJ19FXcBHeix1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
X-Proofpoint-ORIG-GUID: Zwpm6UjfIwu415Y0MPf2deasU97Fr2wX
X-Authority-Analysis: v=2.4 cv=HuV2G1TS c=1 sm=1 tr=0 ts=68d4757c cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=QgVaPGcqiHsWV3tMJzIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEwOCBTYWx0ZWRfX6/ykMcGiKbZ0
 UqyQiMTmUXoPqPhENjVkn/cOUj/8Y5SN1EVJOurpaPekGisXzCJSR81irzFLtKaRrlLBx10hbTQ
 ULe2Y+yG0Jke6ESUTejRXoMYZXhJSS387M+z/7tsU8VYHegC1QH3jX5xG6d2f8BluyLzwRrNYVz
 3W7a9RivcBp6t1pSLHvOIIVaz7MzqtihNLRAmEOH4CQqmlB1GcIx72Vkyu2fwt3Y3rn5aWHx8qR
 0cVmUp6H9cQARTMQinrl45NrXsJl8dD4XvhcPI0chN2+NWyStiqPLl7g6bhZVV7HR0eT/ZonC8O
 ETDNnMf69ZGsgESOxZ/MpTSg3ZmF0SYo/cL2CP1zu+F5D1hzJX58y1SBtwrPJXs67Gl/D6Oy2Nq
 /d6QpUJh
X-Proofpoint-GUID: Zwpm6UjfIwu415Y0MPf2deasU97Fr2wX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509200108

T24gU2F0LCBTZXAgMjAsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24g
MTkuMDkuMjUgMjM6NDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBTYXQsIFNlcCAwNiwg
MjAyNSwgU3ZlbiBQZXRlciB3cm90ZToNCj4gPiA+IFdlIG5lZWQgZmluZSBncmFpbmVkIGNvbnRy
b2wgb3ZlciBtb2RlIHN3aXRjaGVkIG9uIHRoZSBEV0MzIGNvbnRyb2xsZXINCj4gPiA+IHByZXNl
bnQgb24gQXBwbGUgU2lsaWNvbi4gRXhwb3J0IGNvcmUsIGhvc3QgYW5kIGdhZGdldCBpbml0IGFu
ZCBleGl0LA0KPiA+ID4gcHRyY2FwIGFuZCBzdXNwaHkgY29udHJvbCBmdW5jdGlvbnMuIEFsc28g
aW50cm9kdWNlIGFuIGFkZGl0aW9uYWwNCj4gPiA+IHBhcmFtZXRlciB0byBwcm9iZV9kYXRhIHRo
YXQgYWxsb3dzIHRvIHNraXAgdGhlIGZpbmFsIGluaXRpYWxpemF0aW9uDQo+ID4gPiBzdGVwIHRo
YXQgd291bGQgYnJpbmcgdXAgaG9zdCBvciBnYWRnZXQgbW9kZS4NCj4gPiA+IA0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogU3ZlbiBQZXRlciA8c3ZlbkBrZXJuZWwub3JnPg0KPiA+ID4gLS0tDQo+ID4g
PiAgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAxNiArKysrKysrKysrKy0tLS0tDQo+ID4g
PiAgIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAgMiArKw0KPiA+ID4gICBkcml2ZXJzL3Vz
Yi9kd2MzL2dsdWUuaCAgIHwgMTQgKysrKysrKysrKysrKysNCj4gPiA+ICAgZHJpdmVycy91c2Iv
ZHdjMy9ob3N0LmMgICB8ICAyICsrDQo+ID4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+IGluZGV4
IDgwMDJjMjNhNWEwMmFjYjhmM2U4N2IyNjYyYTUzOTk4YTRjZjRmNWMuLjE4MDU2ZmFjNDRjODcz
MjI3OGE2NTBhYzJiZThiNDkzODkyYzkyZGQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+
IEBAIC0xMzIsNiArMTMyLDcgQEAgdm9pZCBkd2MzX2VuYWJsZV9zdXNwaHkoc3RydWN0IGR3YzMg
KmR3YywgYm9vbCBlbmFibGUpDQo+ID4gPiAgIAkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0Mz
X0dVU0IyUEhZQ0ZHKGkpLCByZWcpOw0KPiA+ID4gICAJfQ0KPiA+ID4gICB9DQo+ID4gPiArRVhQ
T1JUX1NZTUJPTF9HUEwoZHdjM19lbmFibGVfc3VzcGh5KTsNCj4gPiA+ICAgdm9pZCBkd2MzX3Nl
dF9wcnRjYXAoc3RydWN0IGR3YzMgKmR3YywgdTMyIG1vZGUsIGJvb2wgaWdub3JlX3N1c3BoeSkN
Cj4gPiA+ICAgew0KPiA+ID4gQEAgLTE1Nyw2ICsxNTgsNyBAQCB2b2lkIGR3YzNfc2V0X3BydGNh
cChzdHJ1Y3QgZHdjMyAqZHdjLCB1MzIgbW9kZSwgYm9vbCBpZ25vcmVfc3VzcGh5KQ0KPiA+ID4g
ICAJZHdjLT5jdXJyZW50X2RyX3JvbGUgPSBtb2RlOw0KPiA+ID4gICB9DQo+ID4gPiArRVhQT1JU
X1NZTUJPTF9HUEwoZHdjM19zZXRfcHJ0Y2FwKTsNCj4gPiANCj4gPiBJJ20gaGVzaXRhbnQgdG8g
ZXhwb3J0IHRoaXMgYXMgaXMuIFRoaXMgZnVuY3Rpb24gbWF5IGNoYW5nZSB0aGUgc3VzcGh5DQo+
ID4gYml0cyBhbmQgZXhwZWN0IHRoZW0gdG8gYmUgcmVzdG9yZWQgbGF0ZXIuIEl0J3Mgbm90IG1l
YW50IHRvIGJlIGENCj4gPiBzdGFuZGFsb25lIHVzZS4gQXQgbGVhc3QsIHdlIHNob3VsZCBkb2N1
bWVudCBob3cgaXQgc2hvdWxkIGJlIHVzZWQgYWxvbmcNCj4gPiB3aXRoIHRoZSBvdGhlciBuZXds
eSBhZGRlZCBpbnRlcmZhY2VzLg0KPiANCj4gDQo+IFN1cmUsIEkgY2FuIG90aGVyd2lzZSBhbHNv
IG9wZW4tY29kZSB0aGUgc3VzcGh5IGNoYW5nZSBpbnNpZGUNCj4gZHdjM19hcHBsZV9waHlfc2V0
X21vZGUgYW55d2F5IGlmIHlvdSBwcmVmZXIgdG8ga2VlcCB0aGlzIHByaXZhdGUgdG8gdGhlDQo+
IGR3YzMgY29yZS4gSSBzaG91bGQgcmVzdG9yZSBpdCB0aGVyZSB0byB0aGUgb3JpZ2luYWwgdmFs
dWUgYW55d2F5IEkgZ3Vlc3MNCj4gYWZ0ZXIgcGh5X3NldF9tb2RlLg0KPiANCg0KSSB0aGluayBp
ZiB5b3UgY2FuIGhlbHAgZG9jdW1lbnQgaG93IHRvIHVzZSBkd2MzX3NldF9wcnRjYXAoKSwgaXQg
d2lsbA0KYmUgZmluZS4NCg0KPiANCj4gDQo+ID4gPiAgIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRf
bW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+ICAg
aW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ICAgew0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2x1ZS5oIGIvZHJpdmVycy91c2IvZHdj
My9nbHVlLmgNCj4gPiA+IGluZGV4IDJlZmQwMGU3NjNiZTRmYzUxOTExZjMyZDQzMDU0MDU5ZTYx
ZmI0M2EuLjYzMzI2OGM3NmZlNGM3ZmRjMzEyYzk3MDVkZmE3Y2Y3Y2NmMzU0NGMgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dsdWUuaA0KPiA+ID4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9nbHVlLmgNCj4gPiA+IEBAIC0xNSwxNiArMTUsMzAgQEANCj4gPiA+ICAgICogQHJl
czogcmVzb3VyY2UgZm9yIHRoZSBEV0MzIGNvcmUgbW1pbyByZWdpb24NCj4gPiA+ICAgICogQGln
bm9yZV9jbG9ja3NfYW5kX3Jlc2V0czogY2xvY2tzIGFuZCByZXNldHMgZGVmaW5lZCBmb3IgdGhl
IGRldmljZSBzaG91bGQNCj4gPiA+ICAgICoJCWJlIGlnbm9yZWQgYnkgdGhlIERXQzMgY29yZSwg
YXMgdGhleSBhcmUgbWFuYWdlZCBieSB0aGUgZ2x1ZQ0KPiA+ID4gKyAqIEBza2lwX2NvcmVfaW5p
dF9tb2RlOiBza2lwIHRoZSBmaW5pYWwgaW5pdGlhbGl6YXRpb24gb2YgdGhlIHRhcmdldCBtb2Rl
LCBhcw0KPiA+IA0KPiA+IGZpbmlhbCAtPiBmaW5hbD8NCj4gDQo+IFdob29wcywgeWVzLCBJIHRo
b3VnaHQgSSByYW4gYSBzcGVsbCBjaGVja2VyIG92ZXIgdGhpcyBiZWNhdXNlIEkgdXN1YWxseSBh
ZGQNCj4gYSBsb3Qgb2YgdHlwb3MgYnV0IG11c3QndmUgZm9yZ290dGVuIDotKQ0KPiANCj4gDQo+
ID4gDQo+ID4gPiArICoJCWl0IG11c3QgYmUgbWFuYWdlZCBieSB0aGUgZ2x1ZQ0KPiA+ID4gICAg
Ki8NCj4gDQo+IFsuLi5dDQo+IA0KPiA+ID4gK2ludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdj
MyAqZHdjKTsNCj4gPiA+ICt2b2lkIGR3YzNfY29yZV9leGl0KHN0cnVjdCBkd2MzICpkd2MpOw0K
PiA+ID4gKw0KPiA+ID4gK2ludCBkd2MzX2hvc3RfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4g
PiA+ICt2b2lkIGR3YzNfaG9zdF9leGl0KHN0cnVjdCBkd2MzICpkd2MpOw0KPiA+ID4gK2ludCBk
d2MzX2dhZGdldF9pbml0KHN0cnVjdCBkd2MzICpkd2MpOw0KPiA+ID4gK3ZvaWQgZHdjM19nYWRn
ZXRfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gPiA+ICsNCj4gPiA+ICt2b2lkIGR3YzNfZW5h
YmxlX3N1c3BoeShzdHJ1Y3QgZHdjMyAqZHdjLCBib29sIGVuYWJsZSk7DQo+ID4gPiArdm9pZCBk
d2MzX3NldF9wcnRjYXAoc3RydWN0IGR3YzMgKmR3YywgdTMyIG1vZGUsIGJvb2wgaWdub3JlX3N1
c3BoeSk7DQo+ID4gPiArDQo+ID4gDQo+ID4gV2Ugc2hvdWxkIGRvY3VtZW50IHRoZXNlIGludGVy
ZmFjZXMuIFRoZSBkd2MzX2NvcmVfcHJvYmUoKSBkb2VzIGFsbCBvZg0KPiA+IHRoZSBhYm92ZSBp
biB0aGUgcHJvcGVyIG9yZGVyLiBJdCdzIG5vdCBvYnZpb3VzIHdoeSB0aGVzZSBhcmUgbmVlZGVk
IGFuZA0KPiA+IGhvdyB0aGV5IHNob3VsZCBiZSB1c2VkLg0KPiANCj4gVmVyeSBnb29kIHBvaW50
LCBJJ2xsIGFkZCBkb2N1bWVudGF0aW9uIGZvciBhbGwgb2YgdGhlc2UhDQo+IA0KPiANCg0KVGhh
bmtzIFN2ZW4hDQpUaGluaA==

