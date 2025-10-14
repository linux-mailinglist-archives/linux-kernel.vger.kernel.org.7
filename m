Return-Path: <linux-kernel+bounces-853500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506CABDBD46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DDB3BBE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC7F2EF65F;
	Tue, 14 Oct 2025 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FGM7HDK9";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cGVADqQ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HN1ftOyE"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8E15B0EC;
	Tue, 14 Oct 2025 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760485500; cv=fail; b=DTcqnuB3nuAyTqGqX2LA6/ZH99wC42n/hOX0yJglNdMhBIritCUZy2yvkXUcV8wwtkkFYOipo6bUSwwXkZMQRpnLzYHhdll0FsgJXda12s7geMvkwgrAMngYmUyMfbBcmwY9gdtd8swgYHKVWzf8tKbifBaRwd0ZV+42YhbBvi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760485500; c=relaxed/simple;
	bh=qNpe9jxRbJKE5YjEVZ4C9EGQudFsvb0tr/pci9mD2pI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHXiqH2zyuxfPwpAl7Nz/AD/QbxcJheQddnXvRF4rSVsB4+EvE/M9Iu+/f+T9X780/xhkbaQFu920VKnnqRPd2PYwyqrl27M9eO79yU8YMcu2wkV4dLdfQ5KKKIfmqIOv6noIjjJL4qRi1k0G3lpNP2lF5k68z3Pn9B2MEzgc9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FGM7HDK9; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cGVADqQ3; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HN1ftOyE reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EHc5HC008366;
	Tue, 14 Oct 2025 16:13:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qNpe9jxRbJKE5YjEVZ4C9EGQudFsvb0tr/pci9mD2pI=; b=
	FGM7HDK9RSXKVqGyRIYiyXrHUF5YFounxekLlrlXOBlV38teRjNm6LDVNA6wgFz1
	y0e2GoBScY+Av97Diyj0lXhQ+4pBp2W56q1tXAUl1QYN9lUC6mOAFjpdrBkSBTAO
	knZI/+EJox0Rm35tkVJx1JeclyhxK4NkAxzokB15+6UGLL5lmVZTTNev0CQNW0cX
	/sGb2Ll9fN7d4tc+cH1+8cYmPEzKIImZhn8k/V9brSusYEgPRoM4CXHeuGmwDbVd
	EUJn8XZ6M+Iof4q5v8mKHMFuGuySjCUq7tgHACkCwesMRsU84YuIa624yIsMWIDN
	4GPi5FH+PZna3vwtM7AT7w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49qpg2762j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1760483616; bh=qNpe9jxRbJKE5YjEVZ4C9EGQudFsvb0tr/pci9mD2pI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=cGVADqQ3o0VTCBPaRj/x6JU/0V5VAyhyXX1YLwNSEVZeHaVi+CpmRyqiW29JyRgGy
	 XA+DmFmx7LufyOWwR0u2qiN89zS6ZqYStGWs4xO/jr7nLcD6LXLstBKRu1MXHkumKM
	 c8mVVkwDv2/C4dAy/r1VB6a7YQ5NIQ0KNDJ9Pyq/zabqV2Ha0AKvZpcLpHBmLarp7N
	 /YaKAyjkoA0/RyF1nmgAjQV+SLBl1299pNRZhqcAXsbcy5vmYQ4gKTUujlA4FNTdJ4
	 g/92Bp4jnuBWFQuxN8ID+Y6C5ilIq49LD1UYjha3YrsVBmxNQbA16Alw3WImHRUka7
	 /lJFv0kTeTpiw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AAF9D403AE;
	Tue, 14 Oct 2025 23:13:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id EC39CA006F;
	Tue, 14 Oct 2025 23:13:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HN1ftOyE;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00407.outbound.protection.outlook.com [40.93.13.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 702724034F;
	Tue, 14 Oct 2025 23:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjK0CJLkmwEKNTMwnfF6YqTFE6U0K1poGAaEb5UczjPkztnWA2nRI6UO56ScMO4e65Qw54oVlJZfk0ZDF5C/JGKjSQZBpd9M7ChqKTazwWdElu2wujJDa/2PVLhq4yQqkWZrYYDHkvSffejA4ScqW3SSeYTC9hvyMw77GiQ/3sdBIgMPK3iE6bLQTG/8sV/X2h2JcN4esWoyMSAuIvB7/jiUNi58D/qFhrWVZpnWWbXuYeKsdsQ4snVWDlhZ7guWRqtldnWmz8hGQT0aAia3Wq4gm5jeH6aqxAD0qtuA8Kef9rbzABgUGN8uReqQCTnIe6cL8o9bw4mqzeDUEUy7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNpe9jxRbJKE5YjEVZ4C9EGQudFsvb0tr/pci9mD2pI=;
 b=PMg9g1f/kBf5An/XdZewXyY3zYa0Evzotzto812D8lSbPGVt6osox/5dzXSbqZp+00MgeHlOP77jlKdl3n/AlJFARC7SaCf43VEb7s5EoP7qf8NJWoPD6DIAXWvk6L9nH/22MLfonbRdkvB2WcniUJ8VqGCuj2OiiJ37DPx/O2fnGCCzWMsp9DD0aA8tZNUovH1jSwPX6SQwviOEt8lgMCioXCSDcZ2xDddtSVF46U4CtbYuEijiLK8i9l7jJ3qMXVUpWh0pDUk9bMYZf7jHpKXrkGpv4j1YZLjtBaGLc3rAVZ69K9ALCfG83LxGx0nv9+3h1InBFApu73Kark8eZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNpe9jxRbJKE5YjEVZ4C9EGQudFsvb0tr/pci9mD2pI=;
 b=HN1ftOyEa9c2SrAHFR+xCg3h3XsA5rRJzwL/zgetXrseWjETQGFhA2UbO54jrdf9M47CmvxsohYuBC4x2674tlNBhrksNDLGznPnoe6DDM4XdFjlc+ebjN0m1/UgHCg+DByyDLoBZTw2C8jmj5r+orvCaq2i/FE1DtQef6Myh+4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Tue, 14 Oct
 2025 23:13:27 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 23:13:27 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Sven Peter <sven@kernel.org>
CC: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] usb: dwc3: glue: Add documentation
Thread-Topic: [PATCH 3/5] usb: dwc3: glue: Add documentation
Thread-Index: AQHcPFsXHuTDEZxdGEC9cS+qfASg8LTCR5KA
Date: Tue, 14 Oct 2025 23:13:27 +0000
Message-ID: <20251014231325.xhqsb2ijhdetxgy7@synopsys.com>
References: <20251013-b4-aplpe-dwc3-v1-0-12a78000c014@kernel.org>
 <20251013-b4-aplpe-dwc3-v1-3-12a78000c014@kernel.org>
In-Reply-To: <20251013-b4-aplpe-dwc3-v1-3-12a78000c014@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4166:EE_
x-ms-office365-filtering-correlation-id: be8f285d-16af-4d7e-7909-08de0b774823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEttNEh4VGFXQU1DNkNoYnhkdHN0QU5DWEI5bktJVHJNWitpOGYzK0c3MURZ?=
 =?utf-8?B?eG53WHFPSXZZeW41Q1dxTzlaYmtpRThGVytGTElYV29LOElWMVQrd3dRY004?=
 =?utf-8?B?ZVJ0M2NoMkVjeFQ5MmxtY3BmRFBMRmk2YXlhNU45MWtvUzlrcDZLN09OSk9O?=
 =?utf-8?B?blozMjFrS3pUckR4TWhuUVpMT2FoR2NIQWJ2TzVQRG1PVFBtRHRMUmdNcW5M?=
 =?utf-8?B?NVJHSUNqeGRDTTlsYVJmNVIvbDI1S21wZVhyZEpSYjdKTnRVS2M0cmxiWDh1?=
 =?utf-8?B?SENpc0Fld2JQUTZqR2NmWHAzZThEdHloZ20rejFidXltSnE3Q3NIOUcrbzZE?=
 =?utf-8?B?aVIwaUJQWWFZRlRTS0ZuNit6KzhpSHlZaGZFbWNKUlQySDk0dEErVno2ZVF1?=
 =?utf-8?B?Y3p2WWwvYnFtbXV6QUtWdkpMZU04emhKSDRTbVFEeGsvMWw4RWZ1WVVJZVh3?=
 =?utf-8?B?NW1mcU5PU2xsU1pyNjFEWkJaT1NuelVOQVVoMW5XaE5PWlUwUkVwNUM2bGc4?=
 =?utf-8?B?bmRRVHdCeDBDcWJ3d0xhZnlpN1h2SmJ3bGxaTzBZUFZXN2JLQk1GanpzeGRE?=
 =?utf-8?B?eDFDa25rdWcyd3hSZkNCSTMvNWZnRThBQlhZak10Vzg0eHJFb1ZkUjdTWjgv?=
 =?utf-8?B?dWJ6dGljVkNYMld1UHI2L21YTnU5MzN0OTl3dEVEZlZKREI2TEQ3TmR0dUM5?=
 =?utf-8?B?cHhHT1FBMU85WW9ONWFIVk12eHUrRXJZWFhwOE9GQSs1K2JsWEhDaXUyN3Z6?=
 =?utf-8?B?VzY3TWNIelFLY1VKOXJQcXBROXVsckJmS0NOMHVacVNSQ1JzMWZDeFkySmZ6?=
 =?utf-8?B?dG40bU03T0kxUjF4WWZ0bkcyeno4NlN0bndvMzc4RGxCMUFuemkzbi9wU2Ft?=
 =?utf-8?B?cm1EOTJFTHk4VTJHR0NNNUZic3VvSDRVajBHWXRRbjh5L2Ywem53YWpyd2lD?=
 =?utf-8?B?NzZzMmZFMlE3L2lsVWFxOUFTdG94QmUxdjhmQi9KbUJFRW9uSGlzM2hFRGw1?=
 =?utf-8?B?Um54cFNzUGZPNk11elEwL01sMmVxcFgyaXNnUkVDNDBBWFg2QzNuSTIwRHd1?=
 =?utf-8?B?ZmZPMHNOZ0I3T2ovSldQcW5wdlpKcDg5Y3RwUWRGWDU4TVMrSTFTS3pRR1Nq?=
 =?utf-8?B?MTdmc0RuWmNRbWFNckM4dHA4TVhFMm5td3QvM3Jyd1h1NENnZGhHRVdrY3Nk?=
 =?utf-8?B?ZXBMZlVPR2lpbWt5TW96Qm0rQWorSmxldmhnSWlKSzZTWUY3K2lRUnEvSU5s?=
 =?utf-8?B?eXZGbVBmMDFpcFNOamVwM3RmbEpMa3RUK204UmNvQldJbm5QdWtOd2dkbUhC?=
 =?utf-8?B?SVZ0cHNWcFVjVmlTZm5ZNWNWNUhzTjl4MFVxaHZMc3J6TnlMTU1GTlJCZG1F?=
 =?utf-8?B?WFdZcUJrOEdxdkpFdkp5SUNFQm9ZNUVhd0pIOHJIUldPaXgyS242TWI5Ym4z?=
 =?utf-8?B?VVlFNlNLTnNZVi9lWHllMlpPVzJOWGVqTkZLQ1A0ai92VGRnVGhDQVd2enor?=
 =?utf-8?B?U1UvMFRKOVlFN00xZ2txZnlOV01tOUw3anlnQk96TDNrYStwY0tqcitXOTYv?=
 =?utf-8?B?dFZ5WlRTaVpPd1hlZ3d6R2ZOclhpd2dCaWlBR2l1WmhVQ1dOaDdmQWpNc1VO?=
 =?utf-8?B?SHpiNDhRYVZzUDVCbmlUdXpEZTZYZm1keFYrOEJacFRrc0ZCR2NOSjN5Rjhn?=
 =?utf-8?B?MCtQcStDUnFlUU8xd28xV1JuK28rWS9HT01DV1RORVhpaUJqSjZhbXR6UUFv?=
 =?utf-8?B?dkNzdFZ6Q0RmNU9uaDU4bmFabnhleC9oVkdmdUFTMm84eXRjWUM1QkczNTFy?=
 =?utf-8?B?NGR3TGhYS3RJeEJQc1hPd0piWmhFWnlyUkdiU1VDUEtzaU9kejg3Y2ZUNGZq?=
 =?utf-8?B?clpzQW1WUDY1UklWeGpKc3BWU1ZRN1E3UzZSRHYveFlJMVdRWE5uWTZrWmdO?=
 =?utf-8?B?L2hYM3IwT1doRktjOVdQNlZ6QjZGY1VmaXBLdTl4MHNwZFB0WWE1c1lKVSs3?=
 =?utf-8?B?aE1uV0dhc3NoQ0E5UWtFNnVVYVh1ZCtMTFdyTXplckdScklCMXVGS0RBNGxX?=
 =?utf-8?Q?376Ksc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWNRSUNJUm8wZU9WTDVQdVhpQlFXaXovVFgvU2pEUWYyL3UrdUpBOG83c1Ni?=
 =?utf-8?B?enoxemcwNkNWcXhJUXpMdmwxZEZtV2FmOHZKSWNXOVk4NDNJR2g4YlhtckZm?=
 =?utf-8?B?RFh1L1FYZ1lmdXBxUkNVN3d3SGNuVHlZNjlXUWpyWFJUcnFTQldVQ1hpcUYr?=
 =?utf-8?B?WjgzSFNIcHJKOS9KRVM3MFNGL3A5TXhsOUkyWVZPSEFvMDJPaWJ6ZjZBT3JI?=
 =?utf-8?B?QTJpdmlsWUx1ZDk3MG95K0x0RXpxU2RSbkdCNnNZelBxTmEvYURmQ1IxbGxO?=
 =?utf-8?B?WC9vUWNkczRic21XbCt3M0s4ZmdjOERvYkpQUlFidnd1V1Zzc3lJMWVXaE04?=
 =?utf-8?B?MXhQcEVvOG9EQk1QcS80ZndLckhPMW00Ni8xT0N6VkhiTFRKdnRaeVhIOWE3?=
 =?utf-8?B?QzZacjlObkhUNmFwWTVSNWVkL0NpN01Ea00rdzRleWlBTzAwRW8xU3pab0Jw?=
 =?utf-8?B?Umo2LzJpREZ5Q1Y3bW5oOGlWRzkyQTBzUHdzR1IwL1pYQm16N1MwVE9CcE9D?=
 =?utf-8?B?Ri9NK0VBV3drZXhObkxxZ2lxQ00vVlN6SFJqMGIzMys2aVNZS21qVVFpcmVI?=
 =?utf-8?B?aVNiSjVFd1VDOE56MXFYbDJGYkptaXBFeW1BYjhkK2ZjQXhONm53ZGpwQXE4?=
 =?utf-8?B?TWtaVHBlRlhPZm5BOXJRZ01FNHFMS1ozQi9MZHdkTkNqYVYyQWhZazFoVjRj?=
 =?utf-8?B?LzF1aFZKVmk4SWMxOWMzNjFjdUUyckZGNFlNaGJrdFVCNXhiczluMEdEMGp0?=
 =?utf-8?B?NFFQeFZFUkk1enJKVG1Nc2JidDdjZUtJaDV2aG10dUtKL0xkOUFtMVBrN3RB?=
 =?utf-8?B?Qk5nZDVRd0syS3RhenRuUDRuTHg1SEdhcnVUdUdzazRpeVBBNmhUb1p5NEp6?=
 =?utf-8?B?OGFDYTA1VGh6UUsyaENuNVMxb1FHWHBIaHFjUDNpd3BVWDhxcGdubHR3elZZ?=
 =?utf-8?B?TzEyREZpeEV6c2hvMjEzR1BwdVJrY2xpZG1ROVlLeHFMcDVIcjlvcWptY1NE?=
 =?utf-8?B?MFpQUnZUNExraE1IUVdDR2c4c2grTUl4QUJsZUF3MW1sUTZvaC80Rmg2YjRa?=
 =?utf-8?B?OFUvQy8zYS8wUWd5NkJsYmkvUUtwZWw0US9LNlBFemN2cktBc3laZ0RJY0U3?=
 =?utf-8?B?R2Zkei9DclNOSVc4ditUTzAvRm9yQ2EvRy9OcGovZVIvdVFQaHp3NTdNcGhw?=
 =?utf-8?B?Zk5LMFB6R3NteHdpNERhQU92SkxEdG0veEtMQjJqODBjVmt1LzhHWlBqdk1h?=
 =?utf-8?B?Qy9JRXJaMDIrampMbEtueUJyS0FEQU1ncm1ucGxnbVdJV0o4ZzlrTEFpdER0?=
 =?utf-8?B?cGpLdkUzUC9KUmtzZE1CS3hTckIvbUhYbGFiZG1SdWc2eGdJZXFJbVM5VWRt?=
 =?utf-8?B?RjlRMHcxQXJ4NEFMVTltNXNGWFI1Tm13Y2laSDF0M001K3ZQUTRQcEphUUtl?=
 =?utf-8?B?RVpBdnhmcDVBQVpUNUg0akphZGEzYkp2VTJ0em5sbnNPQVZmcjFHNElwYkd3?=
 =?utf-8?B?Z3RNNmp3OEtoWDkwR2kyUG9kWHpGNW9tbG1Ma0RMdTQ2ZmxxQUNFZzFVRk9H?=
 =?utf-8?B?a1JYYXJRQW1WdU9rVEpWS2l2YXJQOVpBZ2J4dEYrM3MwMzVienY4U05TbU1F?=
 =?utf-8?B?L3V3V3hXSS9iOU9nQ3RNMnFrR2JkVHRGbjRZbzF1Vmptdml6dXN2R0hZMEs4?=
 =?utf-8?B?a1gxL2VidVV2VzhUMHJwOXpLZjJGR2NOUTRWSC9LZ1cxbWZNRmxQZFdTRnNU?=
 =?utf-8?B?ZDl2eWRCN1ZwQXlTcERvb1pDWm9nSnJxZm5ieGdTNFJjRVVUcGlha2wwWU1Y?=
 =?utf-8?B?a1l2bWcyTnRkTmdmUUR2M0FtdEc2SC9tSDNQc0s1Vi9hbiswQ0NPV2Z6ZU1Z?=
 =?utf-8?B?QVJRR2VhQ2dMN2NqbFNxdEJ5K2prWlJpRmI4ak1ZZkFqR2ZJRWtXZnhzZEwz?=
 =?utf-8?B?ejlRcmhMMkF6WFFiZjZQSUlzR2htK0xPMHFiUFFSd0JvRi9UTlRXNU1tZEg5?=
 =?utf-8?B?VWliTzJHanlMYzRnNVhjaS83aVZyQ1VLeUdDTFgzaC9RZ0dGWWgrNldOK0JN?=
 =?utf-8?B?eDM5dGIvZDdIK2p0K3d4UEdNdFFDbmJ1UitOaEZtKyt2TXFYMDB0cnhtQ25m?=
 =?utf-8?Q?k7QnuQ9IuOR8o1YOgodEPx0qC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FAA7BE67EAF454EAAA429BC1709A2C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hQ0f3TFvBg3BT7PDSL04e7Bgvq03S0yFsVxxUFORK/BUYpKTySY0HJRf7EOJnYDHEcnzgWB8RYfkQSGFKfHcsHfnJ6nTJeAMBFY+bAqwE+tfjq8CN94xYDnYv6P42CFYCD9ftmAI/8h9e3w3jbGGW/jq8R7PsQ4LxzNXbcVEkau9CocUqfMP+WBm5q4BbUIL3MN3cvNEpf4D5eUGq0SSW9gLnx0wTKcKP1DBv9Yx2UNLZ65i8aLDIQQ7KDB+zjMRp2wA6Q+oCseqN7DAizn2eWQFtj1Zcf0xY3bFVHOs5fkYyAIPbJLUkGzR5wcWUvBeOhhsphhmcVJw6LRUZ3KkZ34vU6dx1Z32iFteN1lQbVL7U1nefa44irYHIdyGksk8g7QV2qS+PS7ruLiRym0G6FUCmUycr6n6x9TFIdtvpGuedczIi8CKl4X86b3FSvOtR8Y9YC7Ldzzu+sdeOWQQK7y2048EJg+Ju/Yo+uKP5KMw41GnyWqMlrPArWp16TmUAnnMGvJhz4M41Jb6SvST1ot05KUsOicLnp3JRx65AI0etF/TtBBvcyLeFxpzsDqRHUXttAxbbrnjCZmTRUCAMVmfIl4JRO0xRjCAU4E2X6PGYk2QCYxEVPucvF5ouZfvkykGbi/0xmsrVDEh7lPkpA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8f285d-16af-4d7e-7909-08de0b774823
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 23:13:27.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXqg7ffif6abmu3gSfBwWApMQmlCZLuDU5l/iDOTcqri2tfXAxf66sAo2D10oCRWeeoBDn3Zq0+lIzepUdugcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
X-Authority-Analysis: v=2.4 cv=ecIwvrEH c=1 sm=1 tr=0 ts=68eed920 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=dmVOBjPXIUYMjG642_8A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA2MyBTYWx0ZWRfX1daWqbrjQIkc
 jAHhHMY9pc22w01wd/pNMr3h2RI62vruqLCInfLbmlILgnEad98qm3r759iopGf+PALA41m8jlp
 OBqIlUXKGzqN7WXw0LVqYkrMyRvCrei4Lt8wvCf1r0RCDAAzo8m40d3OLytgaNi2KSCWcNPW9/i
 uANUZnZDpOuEwoYMjB3qktTUYMAHkntJfnPNIBIPgJrxesQKBC/Rak3gmKFXA73E3b2JVpRt8aU
 dHQtzedCqZ0gMOC6VAWu/NhuFG1BCfkBXM+IrBfDY5uzbxDWwvJgyiC6oI0HyaPs3LUXRdtKhNf
 4o/wgM+CAgxd6kBooftIEu+tXkagehqiSUqSfB3on+4k/CWRZrGctnBW6vvTxUwL/jzt41/gkRI
 r7kKI022JrlBzE4tGyJ6hXUfybZ5PA==
X-Proofpoint-ORIG-GUID: XM9Wf2vk3IVQxFcl8YhQtSNwdxPpVJNQ
X-Proofpoint-GUID: XM9Wf2vk3IVQxFcl8YhQtSNwdxPpVJNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2510020000 definitions=main-2510110063

T24gTW9uLCBPY3QgMTMsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IFdlJ3JlIGFib3V0IHRv
IGFkZCBtb3JlIGV4cG9ydGVkIGZ1bmN0aW9ucyB0byBiZSB1c2VkIGluc2lkZSBnbHVlDQo+IGRy
aXZlciB3aGljaCB3aWxsIG5lZWQgbW9yZSBkZXRhaWxlZCBkb2N1bWVudGF0aW9uIGV4cGxhaW5p
bmcgaG93DQo+IHRoZXkgbXVzdCBiZSB1c2VkLiBMZXQncyBhbHNvIGFkZCBkb2N1bWVudGF0aW9u
IGZvciB0aGUgZnVuY3Rpb25zDQo+IGFscmVhZHkgYXZhaWxhYmxlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU3ZlbiBQZXRlciA8c3ZlbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNi
L2R3YzMvZ2x1ZS5oIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2x1ZS5oIGIvZHJpdmVycy91c2IvZHdjMy9nbHVlLmgNCj4gaW5kZXggMmVmZDAwZTc2
M2JlNGZjNTE5MTFmMzJkNDMwNTQwNTllNjFmYjQzYS4uN2YzMjZjZmYxMjQ1ODkwMTkwNGQ0YzMy
ZjYyZWQ5MzU3ZDBmNmUzYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nbHVlLmgN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nbHVlLmgNCj4gQEAgLTIyLDkgKzIyLDM2IEBAIHN0
cnVjdCBkd2MzX3Byb2JlX2RhdGEgew0KPiAgCWJvb2wgaWdub3JlX2Nsb2Nrc19hbmRfcmVzZXRz
Ow0KPiAgfTsNCj4gIA0KPiArLyoqDQo+ICsgKiBkd2MzX2NvcmVfcHJvYmUgLSBJbml0aWFsaXpl
IHRoZSBjb3JlIGR3YzMgZHJpdmVyDQo+ICsgKiBAZGF0YTogSW5pdGlhbGl6YXRpb24gYW5kIGNv
bmZpZ3VyYXRpb24gcGFyYW1ldGVycyBmb3IgdGhlIGNvbnRyb2xsZXINCj4gKyAqDQo+ICsgKiBJ
bml0aWFsaXplcyB0aGUgRGVzaWduV2FyZSBVU0IzIGNvcmUgZHJpdmVyIGJ5IHNldHRpbmcgdXAg
cmVzb3VyY2VzLA0KPiArICogcmVnaXN0ZXJpbmcgaW50ZXJydXB0cywgcGVyZm9ybWluZyBoYXJk
d2FyZSBzZXR1cCwgYW5kIHByZXBhcmluZw0KPiArICogdGhlIGNvbnRyb2xsZXIgZm9yIG9wZXJh
dGlvbiBpbiB0aGUgYXBwcm9wcmlhdGUgbW9kZSAoaG9zdCwgZ2FkZ2V0LA0KPiArICogb3IgT1RH
KS4gVGhpcyBpcyB0aGUgbWFpbiBpbml0aWFsaXphdGlvbiBmdW5jdGlvbiBjYWxsZWQgYnkgZ2x1
ZQ0KPiArICogbGF5ZXIgZHJpdmVycyB0byBzZXQgdXAgdGhlIGNvcmUgY29udHJvbGxlci4NCj4g
KyAqDQo+ICsgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBm
YWlsdXJlDQo+ICsgKi8NCj4gIGludCBkd2MzX2NvcmVfcHJvYmUoY29uc3Qgc3RydWN0IGR3YzNf
cHJvYmVfZGF0YSAqZGF0YSk7DQo+ICsNCj4gKy8qKg0KPiArICogZHdjM19jb3JlX3JlbW92ZSAt
IERlaW5pdGlhbGl6ZSBhbmQgcmVtb3ZlIHRoZSBjb3JlIGR3YzMgZHJpdmVyDQo+ICsgKiBAZHdj
OiBQb2ludGVyIHRvIERXQzMgY29udHJvbGxlciBjb250ZXh0DQo+ICsgKg0KPiArICogQ2xlYW5z
IHVwIHJlc291cmNlcyBhbmQgZGlzYWJsZXMgdGhlIGR3YzMgY29yZSBkcml2ZXIuIFRoaXMgc2hv
dWxkIGJlIGNhbGxlZA0KPiArICogZHVyaW5nIGRyaXZlciByZW1vdmFsIG9yIHdoZW4gdGhlIGds
dWUgbGF5ZXIgbmVlZHMgdG8gc2h1dCBkb3duIHRoZQ0KPiArICogY29udHJvbGxlciBjb21wbGV0
ZWx5Lg0KPiArICovDQo+ICB2b2lkIGR3YzNfY29yZV9yZW1vdmUoc3RydWN0IGR3YzMgKmR3Yyk7
DQo+ICANCj4gKy8qDQo+ICsgKiBUaGUgZm9sbG93aW5nIGNhbGxiYWNrcyBhcmUgcHJvdmlkZWQg
Zm9yIGdsdWUgZHJpdmVycyB0byBjYWxsIGZyb20gdGhlaXINCj4gKyAqIG93biBwbSBjYWxsYmFj
a3MgcHJvdmlkZWQgaW4gc3RydWN0IGRldl9wbV9vcHMuIEdsdWUgZHJpdmVycyBjYW4gcGVyZm9y
bQ0KPiArICogcGxhdGZvcm0tc3BlY2lmaWMgd29yayBiZWZvcmUgb3IgYWZ0ZXIgY2FsbGluZyB0
aGVzZSBmdW5jdGlvbnMgYW5kIGRlbGVnYXRlDQo+ICsgKiB0aGUgY29yZSBzdXNwZW5kL3Jlc3Vt
ZSBvcGVyYXRpb25zIHRvIHRoZSBjb3JlIGRyaXZlci4NCj4gKyAqLw0KPiAgaW50IGR3YzNfcnVu
dGltZV9zdXNwZW5kKHN0cnVjdCBkd2MzICpkd2MpOw0KPiAgaW50IGR3YzNfcnVudGltZV9yZXN1
bWUoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICBpbnQgZHdjM19ydW50aW1lX2lkbGUoc3RydWN0IGR3
YzMgKmR3Yyk7DQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KPiANCg0KQWNrZWQtYnk6IFRoaW5o
IE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzIQ0KVGhpbmg=

