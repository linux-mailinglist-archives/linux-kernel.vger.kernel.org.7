Return-Path: <linux-kernel+bounces-825238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7AB8B619
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CF8161360
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3932D2385;
	Fri, 19 Sep 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GfRBatTM";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jcucREp0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kg4nPD5x"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38322BE653;
	Fri, 19 Sep 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318077; cv=fail; b=qqKDyypo8VKN3oihREBeb7hGZzvH2eyLG9+/a8Qi52oVsrAi57uPmjdah122ooaeyYDTgdNdow+06h57X4/rC4b0HTPnv39DZNVkZuDPvqchKm69kvbY3zoYUEwlGZX6QO9rz7GDQwW0az5iXlZS3hcN0w6aAG208Hb5NZ5BXeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318077; c=relaxed/simple;
	bh=91f6Tq1ikVk0XNlEq/yld4KeYGnQbHTOqo7NoLtH9Qw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJFYIjtPwQvSr7sw2roGIzw/vVfQte826sTUnowzlpwEABhDGqJ13W8lVU9Hcu1t/RN6ShNMPNrzaQC3TRH/h8eu6lZQrcDvMPcXU02WC+k3wceF2DNPo4i8LTKzbSTstemp+bx2u/HtFgbKzcnOiiSXPGmcev4mjFHMIhc9Ne8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GfRBatTM; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jcucREp0; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kg4nPD5x reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JJWGsW005290;
	Fri, 19 Sep 2025 14:40:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=91f6Tq1ikVk0XNlEq/yld4KeYGnQbHTOqo7NoLtH9Qw=; b=
	GfRBatTMRn89K/fqNxlBSkoFgWoKMWtVMgvfS1c5327Hkgu6k9FxYkhmgXawVezJ
	ZEWGHLoiQTkBhKJ5exZiQMcactz7I3GdvT5TBKU6sAKXaL9cGlHFo1Ij6rQ8h8nG
	DE5yQAiTwS7DZHFboySjIgCXl3g6l1yOCixQJiOYumjm8PtoBulreAt67f49Czs3
	UsNSphLFaRMW2ImCfmFGJozFyOXb4+LZf3ZJTuEjPQeo6SlZotweXT4QrtnIn3v8
	JVWLoSb+/ZON3Tge3pZWJJs04IMIYhLDRXivaZ00nZCU7R1HbhG985vWn7+XXUIR
	K+Rbf1pwK9bXLl3RrPh04A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 497fxradp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758318029; bh=91f6Tq1ikVk0XNlEq/yld4KeYGnQbHTOqo7NoLtH9Qw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jcucREp0TbgvxS6CDpEf+LTT8rfDYC8YfB7APy2hfZrbzhgpyjOvdLDiOI7lIg8v6
	 vIFYJyuSpa8WvOCG55QUPxq+EX3GgAKzUKUcI0ThsDUUscakShzLVnbHfJ69jChv28
	 lF/tme6nx9G+jjKcf5PZHFrJH784wLhp7S01JrI7T74kE2Y+El3/02CWrXMLKAToAI
	 hyc5wv7zsz4bAllSkPZuhL/g0FAnIcy6BiyDXmRvuPVf1g6s8Um7FhSuld7ZGxNy5a
	 CmYlQ+lK1WP8HWDRXngfx0EFo/TV87ZirygikKSBnYF1ULgj332laUccvl1UDfjHen
	 yrTe7dLweFftA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E2B354048F;
	Fri, 19 Sep 2025 21:40:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C428EA01D9;
	Fri, 19 Sep 2025 21:40:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kg4nPD5x;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00100.outbound.protection.outlook.com [40.93.13.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8A57340149;
	Fri, 19 Sep 2025 21:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6lZdW6A71wOx6B5R+ijNttmhUeqpCxQBIdjFp6Lpavk2/O+nd1wBEhkjfTef6ad8KD/sdgmi6DX5W25+V1EUGCqb9jeBkX5oxEeCzsBtz3zj8gQP6eMKHGxMWeY/Zu0jzDv6nbFaohVes0GEIMWagy0xNHT9Ce6FystDTHaJto7YAqVFK+X8t4ZNDsiHLbuCj8zAPHJaOoK0pE2oc2HC7TO/GblKEYnMfZqBNGWWE9X3ASoWUVUu0i/Y4TMLB7nxVbMsWlr8wJ3ceD7QYyDFel7HTEVmnr3QxsOTG61B6zfQLdOEsZfEiSH8l3awhQ9pJgUszmvhW0wTKVN5S3zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91f6Tq1ikVk0XNlEq/yld4KeYGnQbHTOqo7NoLtH9Qw=;
 b=fb08LbCiadwy0Z4TSoT4qU485ceTtuLIogC/DS2M2sZN9lD9wc7UHNNesEx2Hud2fLvKRm/CTDhWckwwF119Eafqwy136wUZSBfj5Cw/BtFe8IR5gdoGjRa0v1ACmE0rt0lswptNP2Fzoqj4MxlewXGMilcjkNyemSMsDW1fR4+erHfpOR7EVqg9VJEcOHfuB2HB1JK63t3nz+SvCXG+/Wm4qD0cWunTEMXJ9xqjG+IVXGjvvK8FEzqZz+Kjo38eI/EJAgAtqcf2pAPj+wXuAr3XEYK193p4LNctIhXLD2v1utMhtwy1bzYcziJ8Kg9AalEjwGHt7dZoBG5gDW5BRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91f6Tq1ikVk0XNlEq/yld4KeYGnQbHTOqo7NoLtH9Qw=;
 b=kg4nPD5xTHf+hrHeaTwgqhnqIq4VsQgrc2roPqvpbwSS1wf2Nq+mAsgTpgfPIfg8i3j5O4oiGe199zyT6G3TXsBWhe2tj6PY4WJwF7hAT9oHOzUB7BAlvIIMVON4dwwiEgYLv7HVa9ajnozJkSok65GyI5TU/WHep/VbyU/gxt8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 21:40:20 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Fri, 19 Sep 2025
 21:40:20 +0000
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
Thread-Index: AQHcH0UIOVAW2qnvKUuy0q9Kv04FeLSbHWuA
Date: Fri, 19 Sep 2025 21:40:20 +0000
Message-ID: <20250919214013.gtbaknjrgd375hm6@synopsys.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-3-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-3-52c348623ef6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW5PR12MB5684:EE_
x-ms-office365-filtering-correlation-id: 139f727d-83a4-4c3f-3f98-08ddf7c521b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TE1QdE8wU1hRYjJQQ0hXVWNtM3pBY1ZMa1BqNnkzWDdld2dDYmlSYi9pM1k3?=
 =?utf-8?B?TzdTRTJubVBnZjZUZzJORFlPaXR3YVU2aXNIY2J3ZXJOMzdrNENrTFZiUjRk?=
 =?utf-8?B?UlYxOHkwbWdOdDNNb0t4YXlUaldUR25teEpKS1NOODZFcUQ0SEVDenNQcE90?=
 =?utf-8?B?N3l4ODNBRTF2em9pTjh5UTVlcDRkcjkzVk0wZ0FvRG9ZTFNuMTU3cEJTYmwv?=
 =?utf-8?B?UTBLbzZwdmI4S205UTFTcURIcENZZnV6SHJZRVZTK0UrOGl6L1Q0VmtpYS8r?=
 =?utf-8?B?SFRSdFdOZHcxQW96YlNzZmdJRk9rcThiNS80S1BUeU9EcVFGNWx2a2tMbHha?=
 =?utf-8?B?aTlTYW9RT1AvczBscm5mMEtrdURSaHY0bUNLRFAveGQ0STA4RFpzdGdJWDRn?=
 =?utf-8?B?RXZmSzhDUmVDMmVsREFkVEZCYmQ1K0JCVjNVYkt0djBaYXhXQ1NzL3BhRXFX?=
 =?utf-8?B?V2FyUm42M29nUmRKcEZRVnlpeTN1eC9RK2w4QUFnbTJ1cnFOb0pmQnlJejdG?=
 =?utf-8?B?aUxidVZrWkd3VUVHek8rL1MzNElxbmZoK3ZIamdCL1U3Y0F5amZYS1hlMVE1?=
 =?utf-8?B?OHNuaW5uOXBsbDY1R2prd2tIcUhNM0lwNEY2b3JMalp5MVppU0FQd1A3WGxa?=
 =?utf-8?B?eFU4UFdOSE5QY2JQdEFBR0oxVEowSkt4UnFycm1FRnpOREpaendjZW9lQUx4?=
 =?utf-8?B?c0p2bjlwZTlKaW83QUt6VGcxL3lLMFdmdFZmV1NHYkxrditLSDVibEI2OStz?=
 =?utf-8?B?ZGRJaU1hZ01UamtHWUZ0UHdlVTVxVUtIMVRaanhPVWhsMHhoWitFd2RJdVN4?=
 =?utf-8?B?ZExzWHVKeklVRDY1ZU10K1VEQWk4dnZFTmFUeEN3aGdNczVpMC9rbG13VURG?=
 =?utf-8?B?bXJGdVdQUWNQLzE4dDdiK2l0dDUyZXNDZXhxYW5OUHZpcFRLNUlBa0RnUzRw?=
 =?utf-8?B?WjNwanFIYmR2c0czckdzdmpBWStIMkhXeGluT0EwcllNU2ZBR0ExVVBnVmxv?=
 =?utf-8?B?eGpCZGlLVE1kVWU4MDlIK2l4bnVseTRpbEJHU2k3WFpNdGcrM01MbUJNRm1t?=
 =?utf-8?B?d3JmcHRTblpPbWtOcFFNVzJpSjdLRlUzV1NwUWtjM1ozQUNuQitFS01Xa3Qz?=
 =?utf-8?B?TFVnTGV6VGVWbklESCthMXU0SGRjWTdPSDlGRlJ4S24xL0pIaTZrM3M1b1ZL?=
 =?utf-8?B?Qms4RStoaXRGZzNSZWlidUc5ZHZybzA2WVdlSktaS1JteitDS09SSU1XS1B6?=
 =?utf-8?B?K2VET0k4VXpNdTk5a042UlB6akZCYVdZejNEWjZ2ZjhjL1hhVm92N3BuKzJV?=
 =?utf-8?B?dU5uRVNSY2VibE0xYWtSVGVJL1BXZlpwVk9JRXE5eDQwWjJ6SWJWaWRod0Vi?=
 =?utf-8?B?NnZXZGRIQVRaOWI5L1huMUpKTmUvR2JoU21uSGg2S2g5QUpTM2dkbllDVUFk?=
 =?utf-8?B?T0pGTDZoeUlldEZGcUFjMXZ4Q2JKbFdTS0FWamloSVJOVEJDKzNUMEpjVUEv?=
 =?utf-8?B?QVFCNGNMTlJ5cXBmWGRrV1dCRExMVEZtOUpjZWlmTE9peWVKOUQzbDFodGN3?=
 =?utf-8?B?Wk15bWN1RVJhcHUxZlFuc3ZrZWFKT1pUZktKTVJmQ1VXNlhmeWVqY3BnQ21w?=
 =?utf-8?B?QkJMTFNWaDlSVHgxcFF2dVpCTHlFaHZQeTR0a2dNVjNyeVRtbkNWYS9qWE82?=
 =?utf-8?B?a3Q1R2ZxSkIzT3BGVmd5c045MGloUGhqWUIxQklXOTEyZTk1M3hRdmZrZzRN?=
 =?utf-8?B?dXluWTlJQnFvSnppR3FQaTdXTGIydW1LbzhpN2pOVXVOMVFCSXY3aUpFYzZM?=
 =?utf-8?B?ZEZvclcrYzU4NDNEbU5PM05ESDJiT3owcmlYb1NuN1JqUTV5dHRaYzZibGRs?=
 =?utf-8?B?T3ZpOERhdFNwZ3hMK3U2aXJETkwrQ2w2TTNsWmRYeFlJOWVHRW9vRkszbk9m?=
 =?utf-8?B?NzFaK3JXQTZtQ1Rpc1JkS3lwV0lsQ2wvb3FacTlZaWFLVjZhdWdEb0JGVTcy?=
 =?utf-8?B?UmJkNThmZXF3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUtvOVdVOXpBMWZ3WGJGQmtndVpST2JIU1lGYzZIRk1DcUthUjlZT2dySGMr?=
 =?utf-8?B?YUFSN2N5WUM5R3NwSU9lVGFOTFhLOVZEcUFHVFVvOWlTbGp4dWJJb09qTDhO?=
 =?utf-8?B?WTMrRGpZREVXNjJCWkJnV2tOOWNOWmtxTHBPYnJrejZTM2NlQnhkb29abGFz?=
 =?utf-8?B?VjRzcDA1dTREQjA3U2RkVXQ4ZzJkVkJaQjlpZys4R3lxVVp0YjJXR3pCVnJp?=
 =?utf-8?B?SnZjVlBTdEFkd3NMQUN1bXRnR3A4b2F0czZ5cEVDcE44YkVJbHFjSlUxL2lD?=
 =?utf-8?B?MDdYbmtFZ0txd2YxNEE2NEw4cFNNeGVYbysrcGpaaVV3eFVIUlBJakpOR09a?=
 =?utf-8?B?VXNYY0Z0Q21LS2YrM0ZYMlNGVnhDZWFjRVlYNUZjVnU1cEgzenlkMytCbmI1?=
 =?utf-8?B?eXZGTURkL25KVm56T1JTUnFXUGgyYTdFWHBSK1RMUCt2M2JvRFZkQmp1ZW4r?=
 =?utf-8?B?WHlwSm5XUCtNVkUxeWZRVkdkSkluQlhzcDFWRUdGKzJWcWNQU1hFd0dRYjFk?=
 =?utf-8?B?STN3VHhSYWhCTHArZ01acE9ldE1XRndwTWFJaTFXWUxYb2U3UXJHeWhHYTAz?=
 =?utf-8?B?R1IvSGNQaS9mdHo4QmFsVERFTXVoSjJ6UGYxNFFyNlJQeVdYUjZwRytFbjZM?=
 =?utf-8?B?cDNYSG9MR1N0RnNoa0ZCYkpIbDkxaSt6SjlTSmpGTllQMXNBMHNQemsvMDhL?=
 =?utf-8?B?RkN4em1nWEprNnJubDBYQlpQZFY1bEJLMHl2VklFemhKNTBhK3dwQnJSRmFN?=
 =?utf-8?B?aUtsR255WUErSHFZMk1pZG81KzVRd2pnckU3dDVTRUd0aHR1S0g2QmY5YlBB?=
 =?utf-8?B?MHBXbUtFUFVGYUR4ck4wOVkrdVZ4dVduV2lpWXRvZDlIeEpDdTArMzdLYkVv?=
 =?utf-8?B?b2ZnaDVxdHNKUnIzeFFhaGRCSmtFZk5OWHZQekgza1pLdFZmRXFZMGJtekR6?=
 =?utf-8?B?ZkM5emtBU1F4OGh6TWZRcXdEL0FWL1EyZTkwVU5XbGovcmR4Skp4eGk0UGlG?=
 =?utf-8?B?bzBrVW84L2UwSEx5NnZpeUUxQ1VVMWdNY0RFazlpV2hjZ3EwdlF0cVBXellC?=
 =?utf-8?B?VEhRMTV1RG56cFF6eGpUNVNROWlTYjdqUEZkVWg3NnBidzhQWDBhMUtuZk1z?=
 =?utf-8?B?am1vYks4OU1hcFBIUGhGNnp4R25mYithNXNqMVcwTWtrWmh5cEVaQUJmMXZi?=
 =?utf-8?B?MkJrQ2xCMGxIRk8wZlgrczYvUzM0T3pnaGdBeFNUdEJhcEtiK0JEVkVEZFhB?=
 =?utf-8?B?ZC9XRzJ0VkQ5UGw1YTA2NXdQV2ZDd0lyUmRJbDlSYmFmNTRhanhuek82elpY?=
 =?utf-8?B?S01DQjJoWFI3OS9MeW4vN1JWVjRTUDZLbHZvN1cwcER0QTBQMGVVT2NZUEhL?=
 =?utf-8?B?alFLaE0xNWJpQkFrS3pxMDcxQjV4WExrUGNNWTlxR2hHaElIYWR5RStGMS9U?=
 =?utf-8?B?QmgwVlM2cFd4dzZMTU0vbW1qTzk5MGNXY3hScEdnSUVyWFJ5Vmo5SkNqellG?=
 =?utf-8?B?dFZJazFLNVpUQ0s2RGxiejB6VEhwdmkyc1pTWWdjNjVYMTFjazk5WmtqRE1X?=
 =?utf-8?B?Sk1MeGJ0NjVqQzBvckxWaytualZjU0h1VXQxVWxNS0tIR2tHQVJQQnoyVEJX?=
 =?utf-8?B?OTk4NFlRcHZZY09sektIK1JCalFFSHo1bnN5UTBrWEN2RnJsT1RwS1NFQ2t3?=
 =?utf-8?B?UDVOVEVWYTJUM1dRSUdpdkhPSlVUVVVOMHgyR2NBYk1Ya3pUczFGQUt1aDhJ?=
 =?utf-8?B?NkxtVWRzTUJ6dHBQT3hReDhqaXlmRWZoYjJkSXJ4bkxGMW14MVlZVXMwR1Jz?=
 =?utf-8?B?anJxRit3SWZLdTBESmFxckJ3d3lzb1hCdHZyUGNhaGJzTklya3QvL080cFNm?=
 =?utf-8?B?OSthakd2eVpBT1d4L3lqRzQ2U0lmQTlhT3duVmRJdjhKTVlpbHdZZ2hWczZx?=
 =?utf-8?B?SkYwdzdLYWliR1pMcjhHZTJMRHNERWVnb05GRCtaUmVTTys5RGNBb05CVTZ5?=
 =?utf-8?B?aEpKanlaRTFkOEF6aG91VW51OCtWRFVVUHFFejk0MHpqT0VJQ2I0dzN6RmtN?=
 =?utf-8?B?bGN0OEIwZnNHTTZxbmtxQy9mc1AzMUEvMTYyeXV3SXVQKy9YUXh4dWc3YzZu?=
 =?utf-8?Q?B2QbuFc39ni4I91BD+PbZ1BBa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DE661A2C6327044BADBB6D6211D167E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23/61iqn0t0D92qUwTzkOPQ5z40LUUaffhss8Ec/0/GL4vhKIoGNyGl8vLuE9xtLjAFHf+fPgAqSGDNhH/kiD97MYcRxExjJE+scvfxolH3yWAMjrQ10IDf1mM6F5G1d9xlffHJLB4VpzDvVAmNdPqiLi3jsO5lL2BdCyW1cv6TtlVfNfeUT03FaPLPpyfTB4cjGHxlXJKOp2sTwdpntFVFe3tUbhzIT4kCGY13MIKvWC7zJEUtBaaq/rWNQoJs6yTpbPeF4L/xiVoMd7sEgZhJjEq4SzVtfNCK8QO/Z5UyCcVezkoMrmAF1sqZKxI/YdNWfBYf/JnmSqwd0cI0eku6xwWr0qt8EuzArpcXrNrFrBQJLQeReVu4vUWWyrqVDPlk5UThZ9yeWmttRzwyFWSCVk8CP9JJlF19yGxN+X1mlZ2hua1nZ/o0OcTHa937HLHvN41BD5PnfidKvUnf7vj3pWTtI3hlaYWevJYCi3mXUOT7k3ViR3k+n+d0/C7BpnOMjNN0wg7c+NRfeHXpMbGuONIaGXmlMDRNsPLI+KPtZJwdACR73ooJJKmNNit7ckyMRSjG03+nNaYBUfjvtMsbOQyYa/5Dg4Yu2sKUMP4oLGcMyBjQJVK5yBBZbEymNs70RBv+kfgB1dSbTGkB0ew==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139f727d-83a4-4c3f-3f98-08ddf7c521b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 21:40:20.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1+foCUAny19tQL+W0Tv7eISQtKKNbyI8J0tI1AFlxrI6I0fmtZsgBEGLi5Vd0ujgCOMS04Xi6D1BjbbNay4jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
X-Proofpoint-ORIG-GUID: y1upiScGRUi4WB4qC5EGCbVEtsLK28kU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0TwmcoR+r7lE
 zcTx4sw96Z1/1x/ODfrsLPu9sg0GzWoQp882R7xf+8PMatjvj3u+GP6ZqpItMN6heV4Tv8ZCkFZ
 j1Q26BV6d6YFmJ2hqJoYoZa8rMhIQU6oBKapjMXHibPzeb/F1VPQl018Golw7DMZys+NsriRpyc
 15HekFXCJs+3STe8f5FKH1hWCdnG0HGtkqJwibBs2JCjLvlki02vauDJBhc4xWNZYmX7Nu1y2ij
 TJPLxay1YKkiS0TRkJ6e1c2IAbg25fZ08RaU7X7ZsgV4kWw6goxkPiAfZmsr8tzLldSkqHqy+gc
 jWXwIqXuLYvEDm9xAKkKQbgbQrwFeQde0zZW4/+rIZeV4c2aAZAPDWTJ74X4NwK2bLInNS51lOe
 j64XmLor
X-Authority-Analysis: v=2.4 cv=dZSA3WXe c=1 sm=1 tr=0 ts=68cdcdcd cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=ipA0ZPK-uZ5-fD56_icA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: y1upiScGRUi4WB4qC5EGCbVEtsLK28kU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

T24gU2F0LCBTZXAgMDYsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IFdlIG5lZWQgZmluZSBn
cmFpbmVkIGNvbnRyb2wgb3ZlciBtb2RlIHN3aXRjaGVkIG9uIHRoZSBEV0MzIGNvbnRyb2xsZXIN
Cj4gcHJlc2VudCBvbiBBcHBsZSBTaWxpY29uLiBFeHBvcnQgY29yZSwgaG9zdCBhbmQgZ2FkZ2V0
IGluaXQgYW5kIGV4aXQsDQo+IHB0cmNhcCBhbmQgc3VzcGh5IGNvbnRyb2wgZnVuY3Rpb25zLiBB
bHNvIGludHJvZHVjZSBhbiBhZGRpdGlvbmFsDQo+IHBhcmFtZXRlciB0byBwcm9iZV9kYXRhIHRo
YXQgYWxsb3dzIHRvIHNraXAgdGhlIGZpbmFsIGluaXRpYWxpemF0aW9uDQo+IHN0ZXAgdGhhdCB3
b3VsZCBicmluZyB1cCBob3N0IG9yIGdhZGdldCBtb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
U3ZlbiBQZXRlciA8c3ZlbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jICAgfCAxNiArKysrKysrKysrKy0tLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIHwgIDIgKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2x1ZS5oICAgfCAxNCArKysrKysrKysr
KysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9ob3N0LmMgICB8ICAyICsrDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBp
bmRleCA4MDAyYzIzYTVhMDJhY2I4ZjNlODdiMjY2MmE1Mzk5OGE0Y2Y0ZjVjLi4xODA1NmZhYzQ0
Yzg3MzIyNzhhNjUwYWMyYmU4YjQ5Mzg5MmM5MmRkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTMy
LDYgKzEzMiw3IEBAIHZvaWQgZHdjM19lbmFibGVfc3VzcGh5KHN0cnVjdCBkd2MzICpkd2MsIGJv
b2wgZW5hYmxlKQ0KPiAgCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkco
aSksIHJlZyk7DQo+ICAJfQ0KPiAgfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoZHdjM19lbmFibGVf
c3VzcGh5KTsNCj4gIA0KPiAgdm9pZCBkd2MzX3NldF9wcnRjYXAoc3RydWN0IGR3YzMgKmR3Yywg
dTMyIG1vZGUsIGJvb2wgaWdub3JlX3N1c3BoeSkNCj4gIHsNCj4gQEAgLTE1Nyw2ICsxNTgsNyBA
QCB2b2lkIGR3YzNfc2V0X3BydGNhcChzdHJ1Y3QgZHdjMyAqZHdjLCB1MzIgbW9kZSwgYm9vbCBp
Z25vcmVfc3VzcGh5KQ0KPiAgDQo+ICAJZHdjLT5jdXJyZW50X2RyX3JvbGUgPSBtb2RlOw0KPiAg
fQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoZHdjM19zZXRfcHJ0Y2FwKTsNCg0KSSdtIGhlc2l0YW50
IHRvIGV4cG9ydCB0aGlzIGFzIGlzLiBUaGlzIGZ1bmN0aW9uIG1heSBjaGFuZ2UgdGhlIHN1c3Bo
eQ0KYml0cyBhbmQgZXhwZWN0IHRoZW0gdG8gYmUgcmVzdG9yZWQgbGF0ZXIuIEl0J3Mgbm90IG1l
YW50IHRvIGJlIGENCnN0YW5kYWxvbmUgdXNlLiBBdCBsZWFzdCwgd2Ugc2hvdWxkIGRvY3VtZW50
IGhvdyBpdCBzaG91bGQgYmUgdXNlZCBhbG9uZw0Kd2l0aCB0aGUgb3RoZXIgbmV3bHkgYWRkZWQg
aW50ZXJmYWNlcy4NCg0KPiAgDQo+ICBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgew0KPiBAQCAtOTc0LDcgKzk3Niw3IEBAIHN0YXRpYyB2
b2lkIGR3YzNfY2xrX2Rpc2FibGUoc3RydWN0IGR3YzMgKmR3YykNCj4gIAljbGtfZGlzYWJsZV91
bnByZXBhcmUoZHdjLT5idXNfY2xrKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgZHdjM19j
b3JlX2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gK3ZvaWQgZHdjM19jb3JlX2V4aXQoc3RydWN0
IGR3YzMgKmR3YykNCj4gIHsNCj4gIAlkd2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51cChkd2MpOw0K
PiAgCWR3YzNfcGh5X3Bvd2VyX29mZihkd2MpOw0KPiBAQCAtOTgyLDYgKzk4NCw3IEBAIHN0YXRp
YyB2b2lkIGR3YzNfY29yZV9leGl0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJZHdjM19jbGtfZGlz
YWJsZShkd2MpOw0KPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGR3Yy0+cmVzZXQpOw0KPiAgfQ0K
PiArRVhQT1JUX1NZTUJPTF9HUEwoZHdjM19jb3JlX2V4aXQpOw0KPiAgDQo+ICBzdGF0aWMgYm9v
bCBkd2MzX2NvcmVfaXNfdmFsaWQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gQEAgLTEzMjcs
NyArMTMzMCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfY29uZmlnX3RocmVzaG9sZChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiAgICoNCj4gICAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG90aGVyd2lzZSBuZWdh
dGl2ZSBlcnJuby4NCj4gICAqLw0KPiAtc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3Qg
ZHdjMyAqZHdjKQ0KPiAraW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7
DQo+ICAJdW5zaWduZWQgaW50CQlod19tb2RlOw0KPiAgCXUzMgkJCXJlZzsNCj4gQEAgLTE1Mjcs
NiArMTUzMCw3IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykN
Cj4gIA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChkd2MzX2Nv
cmVfaW5pdCk7DQo+ICANCj4gIHN0YXRpYyBpbnQgZHdjM19jb3JlX2dldF9waHkoc3RydWN0IGR3
YzMgKmR3YykNCj4gIHsNCj4gQEAgLTIyOTgsOSArMjMwMiwxMSBAQCBpbnQgZHdjM19jb3JlX3By
b2JlKGNvbnN0IHN0cnVjdCBkd2MzX3Byb2JlX2RhdGEgKmRhdGEpDQo+ICAJZHdjM19jaGVja19w
YXJhbXMoZHdjKTsNCj4gIAlkd2MzX2RlYnVnZnNfaW5pdChkd2MpOw0KPiAgDQo+IC0JcmV0ID0g
ZHdjM19jb3JlX2luaXRfbW9kZShkd2MpOw0KPiAtCWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyX2V4
aXRfZGVidWdmczsNCj4gKwlpZiAoIWRhdGEtPnNraXBfY29yZV9pbml0X21vZGUpIHsNCj4gKwkJ
cmV0ID0gZHdjM19jb3JlX2luaXRfbW9kZShkd2MpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZ290
byBlcnJfZXhpdF9kZWJ1Z2ZzOw0KPiArCX0NCj4gIA0KPiAgCXBtX3J1bnRpbWVfcHV0KGRldik7
DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDI1ZGIzNmM2Mzk1MWJmNTY1NGY0YmY1YTk4ZDcw
NzNhMDI4MzY0Y2QuLjdiOTJlYjhjNGNjZjExOGI4MWYyN2FmYWYzZjMxYmY1NmUxYjZmNzQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtNDc5NCw2ICs0Nzk0LDcgQEAgaW50IGR3YzNfZ2FkZ2V0
X2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIGVycjA6DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0N
Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfZ2FkZ2V0X2luaXQpOw0KPiAgDQo+ICAvKiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSAqLw0KPiAgDQo+IEBAIC00ODEyLDYgKzQ4MTMsNyBAQCB2b2lkIGR3YzNf
Z2FkZ2V0X2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlkbWFfZnJlZV9jb2hlcmVudChkd2Mt
PnN5c2Rldiwgc2l6ZW9mKCpkd2MtPmVwMF90cmIpICogMiwNCj4gIAkJCSAgZHdjLT5lcDBfdHJi
LCBkd2MtPmVwMF90cmJfYWRkcik7DQo+ICB9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChkd2MzX2dh
ZGdldF9leGl0KTsNCj4gIA0KPiAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMg
KmR3YykNCj4gIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2x1ZS5oIGIvZHJp
dmVycy91c2IvZHdjMy9nbHVlLmgNCj4gaW5kZXggMmVmZDAwZTc2M2JlNGZjNTE5MTFmMzJkNDMw
NTQwNTllNjFmYjQzYS4uNjMzMjY4Yzc2ZmU0YzdmZGMzMTJjOTcwNWRmYTdjZjdjY2YzNTQ0YyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nbHVlLmgNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9nbHVlLmgNCj4gQEAgLTE1LDE2ICsxNSwzMCBAQA0KPiAgICogQHJlczogcmVzb3Vy
Y2UgZm9yIHRoZSBEV0MzIGNvcmUgbW1pbyByZWdpb24NCj4gICAqIEBpZ25vcmVfY2xvY2tzX2Fu
ZF9yZXNldHM6IGNsb2NrcyBhbmQgcmVzZXRzIGRlZmluZWQgZm9yIHRoZSBkZXZpY2Ugc2hvdWxk
DQo+ICAgKgkJYmUgaWdub3JlZCBieSB0aGUgRFdDMyBjb3JlLCBhcyB0aGV5IGFyZSBtYW5hZ2Vk
IGJ5IHRoZSBnbHVlDQo+ICsgKiBAc2tpcF9jb3JlX2luaXRfbW9kZTogc2tpcCB0aGUgZmluaWFs
IGluaXRpYWxpemF0aW9uIG9mIHRoZSB0YXJnZXQgbW9kZSwgYXMNCg0KZmluaWFsIC0+IGZpbmFs
Pw0KDQo+ICsgKgkJaXQgbXVzdCBiZSBtYW5hZ2VkIGJ5IHRoZSBnbHVlDQo+ICAgKi8NCj4gIHN0
cnVjdCBkd2MzX3Byb2JlX2RhdGEgew0KPiAgCXN0cnVjdCBkd2MzICpkd2M7DQo+ICAJc3RydWN0
IHJlc291cmNlICpyZXM7DQo+ICAJYm9vbCBpZ25vcmVfY2xvY2tzX2FuZF9yZXNldHM7DQo+ICsJ
Ym9vbCBza2lwX2NvcmVfaW5pdF9tb2RlOw0KPiAgfTsNCj4gIA0KPiAgaW50IGR3YzNfY29yZV9w
cm9iZShjb25zdCBzdHJ1Y3QgZHdjM19wcm9iZV9kYXRhICpkYXRhKTsNCj4gIHZvaWQgZHdjM19j
b3JlX3JlbW92ZShzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gIA0KPiAraW50IGR3YzNfY29yZV9pbml0
KHN0cnVjdCBkd2MzICpkd2MpOw0KPiArdm9pZCBkd2MzX2NvcmVfZXhpdChzdHJ1Y3QgZHdjMyAq
ZHdjKTsNCj4gKw0KPiAraW50IGR3YzNfaG9zdF9pbml0KHN0cnVjdCBkd2MzICpkd2MpOw0KPiAr
dm9pZCBkd2MzX2hvc3RfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gK2ludCBkd2MzX2dhZGdl
dF9pbml0KHN0cnVjdCBkd2MzICpkd2MpOw0KPiArdm9pZCBkd2MzX2dhZGdldF9leGl0KHN0cnVj
dCBkd2MzICpkd2MpOw0KPiArDQo+ICt2b2lkIGR3YzNfZW5hYmxlX3N1c3BoeShzdHJ1Y3QgZHdj
MyAqZHdjLCBib29sIGVuYWJsZSk7DQo+ICt2b2lkIGR3YzNfc2V0X3BydGNhcChzdHJ1Y3QgZHdj
MyAqZHdjLCB1MzIgbW9kZSwgYm9vbCBpZ25vcmVfc3VzcGh5KTsNCj4gKw0KDQpXZSBzaG91bGQg
ZG9jdW1lbnQgdGhlc2UgaW50ZXJmYWNlcy4gVGhlIGR3YzNfY29yZV9wcm9iZSgpIGRvZXMgYWxs
IG9mDQp0aGUgYWJvdmUgaW4gdGhlIHByb3BlciBvcmRlci4gSXQncyBub3Qgb2J2aW91cyB3aHkg
dGhlc2UgYXJlIG5lZWRlZCBhbmQNCmhvdyB0aGV5IHNob3VsZCBiZSB1c2VkLg0KDQpUaGFua3Ms
DQpUaGluaA0KDQo+ICBpbnQgZHdjM19ydW50aW1lX3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3Yyk7
DQo+ICBpbnQgZHdjM19ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gIGludCBk
d2MzX3J1bnRpbWVfaWRsZShzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvaG9zdC5jIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gaW5kZXggZTc3
ZmQ4NmQwOWNmMGEzNjE2MWMyMGFkM2M4M2YxMGU2NzA5OTc3NS4uY2Y2NTEyZWQxN2E2OTEzNGU2
Y2ExYjg4NGY3NmMxNDM5NjkzZmFiMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9o
b3N0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gQEAgLTIyMCw2ICsyMjAs
NyBAQCBpbnQgZHdjM19ob3N0X2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlwbGF0Zm9ybV9k
ZXZpY2VfcHV0KHhoY2kpOw0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICtFWFBPUlRfU1lNQk9M
X0dQTChkd2MzX2hvc3RfaW5pdCk7DQo+ICANCj4gIHZvaWQgZHdjM19ob3N0X2V4aXQoc3RydWN0
IGR3YzMgKmR3YykNCj4gIHsNCj4gQEAgLTIzMCwzICsyMzEsNCBAQCB2b2lkIGR3YzNfaG9zdF9l
eGl0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoZHdj
LT54aGNpKTsNCj4gIAlkd2MtPnhoY2kgPSBOVUxMOw0KPiAgfQ0KPiArRVhQT1JUX1NZTUJPTF9H
UEwoZHdjM19ob3N0X2V4aXQpOw0KPiANCj4gLS0gDQo+IDIuMzQuMQ0KPiANCj4g

