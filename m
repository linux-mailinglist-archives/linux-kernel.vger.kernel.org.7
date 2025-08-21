Return-Path: <linux-kernel+bounces-780772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761D1B30934
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DA6AA1158
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05A72EAD19;
	Thu, 21 Aug 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WzhPMIAN";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AgdYXdOS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NHff2JCx"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76632EA754;
	Thu, 21 Aug 2025 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815416; cv=fail; b=rtEXuI1CZqj6Mfcr3awF2QbWNTZAvJM5XZ/Oihhy1tmM3YL1malp6PTTzgSiqA4u0FDS96ROsSih4ZHf409giWycNtwoOPSU/f9IoXq5I0pn2lzxYsgI5z6newEMZh1nXWl5fgvgWKctDKjm2Ubh7zXW5z0F3CaSJFPkgtP2iZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815416; c=relaxed/simple;
	bh=gh1VmXi1+rRfGf+mx17AFzwOPmFhjC5MZnSkPNMxokQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awEVbBA9PSdQu1csO1zqoCZNCFeFn5ldvYQIP58AXx41lexguAajLYBgRIS0XkhiunLhw58unEln/6W8u9yj3vaoZRQDp/Dg+jGmk2e1drluxbems4fVKvnWcFOLvJGOKZI47C9eKhZwc8+IBTllpxYk8qzHB1yzldLu2oq589k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WzhPMIAN; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AgdYXdOS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NHff2JCx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LHkYlF012453;
	Thu, 21 Aug 2025 15:28:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=gh1VmXi1+rRfGf+mx17AFzwOPmFhjC5MZnSkPNMxokQ=; b=
	WzhPMIANMHGUSAnI5q1tiUm1F11IV0QBWATKz6uenFZ5cJGApIzkoBI1F95tzB90
	szNXWN70qCdXCVeREsObXgZx/Z/yDZqhIuLgqnSDeNIF7RAglZaG4ENE2Han2IjS
	wXcjlbhoz8dnPtzEtYrEgOGzCfML+bsCCylWGPEx4NaCJYVazDt7BvckKQ2DTHy4
	hP6dMBRoVidQ/r6dByGaYGKmn5MCS/bWCxCtJD02+1n6M6PnNUXyMaZyfQmqiaST
	9M203/cK++AbvUCgO+6kUu++H3+DPz7BVsph0wZGQQAIdDuUE/JKntGq9v/NkP40
	CAXvSUETA+dKlUrIxXY4JQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48n8yeafh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1755815333; bh=gh1VmXi1+rRfGf+mx17AFzwOPmFhjC5MZnSkPNMxokQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AgdYXdOSLol4gvKDFEFXGCC95PQ54LupbYtOvwOauZV47gj07aVFGstUGdzL3LlOC
	 kXjS7WCZ5x88CH2TxT7aWzOXiXSpoZOwE/gZTpxKBNo6JYiftnuA0OJl0k/mGlGueB
	 i1ZJv7g7noUKNYTw3Pd1oM0O0Vu6EMpqQEO3elg/CGurLcqURElWLugODmutLXfltA
	 5XVnAWYjZ0PpPcHferi7SdPicqU7rfkD7UQJYqSIJO1fm843O/X+/SGXJPjok+ucAO
	 wn/f4as+7vamc6LAP0NXxj/gx4gNCqBjwZQr0cMk599LOeVIWcd+13j23LdDAL+Xx6
	 RFm+nrJwA5XFw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B50A14035E;
	Thu, 21 Aug 2025 22:28:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 43467A009F;
	Thu, 21 Aug 2025 22:28:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NHff2JCx;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E5BF240407;
	Thu, 21 Aug 2025 22:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3r806cUeTR2MpAX8zTjclz2naBKsFmfmxn6Odt9S1npq796yEbzlMx4VrfG7gKBJ/+bR/fnKi+0gwc9DxSDJbLjf3bluanOsGXwHwbRbvmbVPLYz1kqyTcnTk3uh8/Xp+vOYS5V1F267/ql03LMpfG7rRbtHZadOATziy/vrdbYfrWndI05EH9mvS75nxd0F9KTzcD1vbCK0sX+x8oJyZUF2qe+ZKb0jgljxyeRVHTkPuMzGwJb+scGemK6RUyLe35GYRUsJwxKiUcXcSHy+xXEjRmh5sglNZVBZw3ns/CO3Y01qFLZQn0oCh1bFIxeom6jQWsq+iI0Fl+C8HRMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh1VmXi1+rRfGf+mx17AFzwOPmFhjC5MZnSkPNMxokQ=;
 b=pXI/Q2dw6h5WVqmoY9QijhR2Ss+9JnXa99c2sSxkYI6pLrVXRPTjGwQ+UW7/SYKcG3gcKSKUwvsP7tSSyMQ5508MFjkfX1gDu21B1+cmBVHd7Dw26uHaNh4V8Hpicke6HPWe/F2VbKnrvuGHUK3+372BdDUdJSPq9Rl8r7e+0wpFF3VsXCGXWg4HjtU+lTA9ZD40KAPPHWIXsJBxhu8iQ4me0PkfqMLU3kfnJOC8GCqAEn/Zr4moqh9mFRFlSfdId70cXx8i8Wv+RrHwIZdDgsF9Z2dBBfogszTtg0MkfdcH6Qk2cMk82nwhBg1BnTkEtzsgnfJjTW5c3d4YQX4NyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh1VmXi1+rRfGf+mx17AFzwOPmFhjC5MZnSkPNMxokQ=;
 b=NHff2JCxsD6MXeFxjhYmKVZtdzAQz5gbH3e8K99zSnMl1jVdQD2xnBdpkyfpjKj3g8DfJ1eFAZ0VIqs+IBx1BoArcPuVfaz6zLuChM4qK5utnsP2Wb0pQdP4uOehm9PqpGaaydga8/vF5+tZZBIG+0qjSBH77QU52FCtAmrSBPM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 22:28:47 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 22:28:46 +0000
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
Subject: Re: [PATCH RFC 05/22] usb: dwc3: apple: Do not use host-vbus-glitches
 workaround
Thread-Topic: [PATCH RFC 05/22] usb: dwc3: apple: Do not use
 host-vbus-glitches workaround
Thread-Index: AQHcErHluSS416vmfUq2Vd/rskyBMbRtsIEA
Date: Thu, 21 Aug 2025 22:28:46 +0000
Message-ID: <20250821222842.fqrxjp56czc7ubok@synopsys.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-5-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-5-172beda182b8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV3PR12MB9142:EE_
x-ms-office365-filtering-correlation-id: 69c98669-c089-4fbf-3d66-08dde1021842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3FvTG4xZHQreEdFSHdoWXgrNHFVd2tKdENsUXJJdXBWd0N2MFZVYWYvakw2?=
 =?utf-8?B?Uk5MWHpYYlhscGtGc0orbytVeVhVSGw3SzlNeC9LMzlrVzZiU0xKeXRSYVFW?=
 =?utf-8?B?QTFHeFFnUXYzb25uQzROdVNVQ2xITG9vTmExeXBmbXlMNG9nVTIwc1FzWWZK?=
 =?utf-8?B?TzhxOWRnR1VxUDdydmI5ZWdKWWdQL1ZqUXlmeFRkT210azljanhGY2tlanRN?=
 =?utf-8?B?RjBTbC84aHNhMG9ScEt0MTArL2pOendzNGJQaTl4TFpwM0djbUo2Q3R6OUxu?=
 =?utf-8?B?V28xa0xqTHYxeWZ2d0VGN1NMTG5jekt6SVpqYnMrd3BTMG4zUGtzNktLc2hm?=
 =?utf-8?B?ZW90RjFWc2FhdG1Rdk1ZZ25pbzdsWVZyU29lL3U2TWlYbVd3K3J4M25ETCtv?=
 =?utf-8?B?bGczanZ6UThVZXRxQzYyMWR3WjdCNy9nR3FCejI0TWRVZDg4TzQyK3V5azFJ?=
 =?utf-8?B?bVVXeVF3UW5lNS9FbXVxZXliMVEvL1UwOUZsS0poL1h2UFJEYmNwZkY4L3Nl?=
 =?utf-8?B?YnRuTkdDM2c3TExpMzczeDFENFFBcG9ZNTVvYjRKQ2ZUM0UxaWZiTmo4ZE9o?=
 =?utf-8?B?OHdESXBOTUV3T1g2WVJ0eERWZWdUbXVNTEhyRFFzcDNncmU4UkFUdEhQUUZP?=
 =?utf-8?B?OFRScjRaNGs1b0I4TUpGYzM2SlBxMlJqK3ljUTFWenRiVkpEb2d4VHpJbDV1?=
 =?utf-8?B?aitHQkx3NmhFdGRFQ0p0cUZBbkl1NEhuOXdTNVlKV0N0djk3MjlFd2FtSGZt?=
 =?utf-8?B?WEl6dnlhdzRONUZmemFNelI3RVZZUkJZVGt3YTl0c05UQkVDSU5lT1grVUNy?=
 =?utf-8?B?ZnlzbFQwNjM0MVZ5MG1RVTdlNjdtUEJUbE1rc2tCYnNKaU13Wm1MYjRxSzNK?=
 =?utf-8?B?WFYyRnlabUp6WDlLaW5IOUVWSnJqdExvM0N2MUJvajM5UUJjZFh1bXplUU02?=
 =?utf-8?B?YWhNMkpkL0ZvQlpPd04xMzlsQ0dULzlRVTJUVXpoZ0RjTnJ3MW1lTDRXdFZn?=
 =?utf-8?B?L29KamNDV3A2VDU5c3Z4aWtsV3NaakNJQUlwRVRGUTdXdlRXWk5FMlJWTUtn?=
 =?utf-8?B?UzQ1NCsvMktaU0JlQjNKYnpJZFVNaWZyTUo2ZGNtR0xsSWl4b0dXbWt2eFdk?=
 =?utf-8?B?MkFoKzVNRDhWSk1NeWUwUkdiWFZIV2d2V040ZUVxZG5haTBTRFZOU3V4LzhY?=
 =?utf-8?B?WUZ2ZHoydHcvTE1RN05tT2F4WnI4Y3RxZ3lqelpPREF2VFRUaEtsOFRuTkVX?=
 =?utf-8?B?clVNNTNKUFpBWEhzZ1BqMTZIbXBYT0x6cEFQUnJNUkVtM0Y2bnpvclZENzZI?=
 =?utf-8?B?VklzTDBEM00xTnhldkdaMExYL1Z6c2tuMWlmVXNYSDRxN0Vyd1BMaXd6c2pr?=
 =?utf-8?B?NWFSRUpDeDZmSTFDZ2hKVDJRMUVRd3drbE5JbVNseFArYjlITWYvNFRJVE5G?=
 =?utf-8?B?NU9oOG04bnFUTnp3S21Lbi9XeWtpN0JsbXZvaFJrVmxLZmZTSHJTQW42Wk5h?=
 =?utf-8?B?SFd4Z290L2NVMHBmdTQ0dDcxc3F0bTEyQllEZlpjVlhFUzk2cVEwY2pGd3Fu?=
 =?utf-8?B?T1JzNExLL3RUanFudlNWbnRvZWlkbWVTbnRaSEZmeG5uU3ZjOXJSNUFhNnlq?=
 =?utf-8?B?QjNPa2VOZkhUdUFHMjlNdWlyOVc1MkprZVhDVWRscWVUOVV4aVpnbUFITnZu?=
 =?utf-8?B?b3pjM0hMaEcwSlNwNkpWZFVhM3VuaW9UY1h5SzNVOHE5bEpCWVY1MTJZNVdE?=
 =?utf-8?B?VGZuU0lJTHdsdVJBY3lPVEl4cTdSenhJZ2JHUHhKL1hQbUcwcnJwWVBzY2sz?=
 =?utf-8?B?Tmx3M04xdWFKNTBwVXNOMVVTK04rM0pIZW50aTlEN3hlTDRJNXNFY25OTFRs?=
 =?utf-8?B?aUFXSW5rTWxwNW45SnhzNEVuMXVXazRXUlBPTld2Qm9MWnBnZ0dpWEdUWlBS?=
 =?utf-8?B?dVdnbDNXQkFOVjBIeFZMb2RCZnlYbmRuMTdEQ2pzR3YvZkplVWpBeDYrSnQy?=
 =?utf-8?Q?aWrf1mbkXRJIS4RgUu5z5K+BCRbVdc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QndIQkxrMm00NkU3ZGsrNEJ6MmRtZjVBcHpyb3RvREZHSzNPcUY1OTZIcUZ4?=
 =?utf-8?B?aW9FQUovOFd0TnFRWldJcjBENENvNWVIYUlyYTV0VnpEYWtYRkpiUm0vWG5l?=
 =?utf-8?B?Q3QwZUNURFQ2dlM0VkVGTnBEMllwcndyWGh5SHBVSW5NUGZ0Ky9QclYranBS?=
 =?utf-8?B?S3M0a0g2LzBWdUhTQWY4SjJWdHZvNHNWY2FSRE5BYjUzZ2lCcDFZOHE5REgy?=
 =?utf-8?B?UDFjSVBLMUZwakQzQkZTVkkvNzdEaFpna1BCcVZFRnhvWmdRZGxXbzRzRDdO?=
 =?utf-8?B?Q1NXOXVTZWVHRTlVYUlFQjlQblVUMUdMVkRQbm9rYUF1a2Y5cW5HNnIyMjhj?=
 =?utf-8?B?Y3AyMXBkOWRUQ2JELzRrNHkwMnZjZTdHcmJTQ0IzMUNqMHFMSGdCdGQ2aXNH?=
 =?utf-8?B?eG8xZFpkWHJCSzRzT3d0N2VLdFBlZVBYUHN0R3ZTTU9mVzRjZFJaRmtTcE9U?=
 =?utf-8?B?RUpRUUsrUzI3Y1ZybHdaWEZQNWF5U2kwVDZET0svdnFPT3JnZ3hlcVRlcXRJ?=
 =?utf-8?B?QjY1eVBpdEtHbW91c0YxQ1JuNVg1YXYxOU9IblhiY1h6RVRPeXFsSndEZzMx?=
 =?utf-8?B?b1dyc29yaHgzMnNSbFBwZ1Rvc3piMThZZ3NEY2hYUG9ncGdlSUNUZlJUTXdF?=
 =?utf-8?B?bElsRDY0SDZ6YVo5cWJ3ZGJEVHFFU3NPQWM1dzdONTdvYWdrSFgyTFF2Nkov?=
 =?utf-8?B?aHBIczJWSjZ0WUhHLytyd3c5MjNXVGhCQ0lGeHBVUXZ3TlZkd0o1TlR1UG9V?=
 =?utf-8?B?TGR3a2d2YzZLR0hUSWxDeERyVjM2a3p1QTFlL29JZ09VblA2YkEwVkEyT2NZ?=
 =?utf-8?B?YkNGbkF3cnlzNGJRT1grTnNMODhmbXp3MGZQZ3JRbDBmTVh3VXVKN0tQenNQ?=
 =?utf-8?B?Mk91Umh5MlVjQldLZkVSYWM3ZmhDNjB3eGtpZm5YeHh0NzlFeE9pcDZGdXkz?=
 =?utf-8?B?THZxM1JvNWovOWoxRm5sWWVxUXRjNWJXdHAzNlBKeDlyTkhRd3RoUlNPaUx5?=
 =?utf-8?B?TnZxcmsxQUVGUTNSVWFYdVJqdGFaUTNUaFRmQUhqMDBMTjEwKzdUNHp5Nmpm?=
 =?utf-8?B?ZnFsQWNzeUpKVmc4T1JvcW5XNDBXd2xnT25MdVM5djBXbVJpUjVUcjJHbW9z?=
 =?utf-8?B?UlVvTERvN0lpQ1dNNDhHa2NZd2dGMk44UENOTWZhVXIyNFZxc3hnUmY5NGFX?=
 =?utf-8?B?MEVzUWZHTURrazBQTEZPZ0VFMG1VdmdJUUIycFBseVlHKzRyekp2amJQb3ZU?=
 =?utf-8?B?VzJwM2xCMTlRd3RZTUJvMlhMeXpadlNwS01mekdMQWtQemxSRlhKenRsNlpX?=
 =?utf-8?B?ZXRTNjBpVUc1NUt3N01iNGplcVQ1YXRscUtDZ0xTd1h5TDdQYmxyODA5dmFo?=
 =?utf-8?B?QllZS2VYaGFyVS9zQ0VqZmk0djIvakZkSjFUaWViTGxMTVZqTTFET1M4UjlI?=
 =?utf-8?B?OW40RW1UaWhzSndqZjk5TVhLek1ZZjhmYUozdVJ0b01CV1dEdFJzVGJlRW8w?=
 =?utf-8?B?aXhrMWxJd2tqNnovNGFUUGZFbktYUlptcXFVVVB3WmRBZGFLeEQ4UnRYVzRm?=
 =?utf-8?B?a05ZRTlOYTRxMGcxdkhaM0V5VXZvY1pKM1lxM0FDQzI4Y2lIWTNDQWZjZ2Ft?=
 =?utf-8?B?eFJ5aGJTV2hUcWdNSlJZcFNJeThUMWh5UVVIQnRXNzJTbFVFNUtrSmd1MWU5?=
 =?utf-8?B?SURyQWtPdDhOY01EcWlPMXk0Y2NRSGVXSW9vbkZoUVhETjhta0ZZOEdKY3hS?=
 =?utf-8?B?MExwVjdCV2NSWmtGcTIzOTVEa2tITFRtMGtlS1c2NWVJZ1Y5QkZwN0RZaUFz?=
 =?utf-8?B?dU5Gd0M0cFNHMkJWNDcwaFdOcWRiVzU5bENTcTJOaTY3UUZFYzRKOUI5djZq?=
 =?utf-8?B?bmd2M25tUnVPQlU0MnkwcGNzazVVWUZKZUlIVTcvQ3drOG9IN2E0WUNzVStK?=
 =?utf-8?B?L3Q3MGFlUXZDdjYwb2lnRDhlbkw1eVpDWnh4SEk4Z0dUZlhNM1pLeXl0WlE3?=
 =?utf-8?B?dHYvSEZxZ3pQWjdoZjk5VHRhMFRsOWtpWjBYckNZRmxaYlZWNUZFL2EwUEEx?=
 =?utf-8?B?ZHFUc0ZUSmZyeDFMbk8yZzIzUC94TDZSNXp2b1ovcmNnT1MwdDNsTEhvOHc4?=
 =?utf-8?B?cHhhU2s5b2ZNODJ6M3o4dHhFTHlaQ3RuaXdDZzZkYTh4UDNwbVk0ams4RGFU?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AC9CD77CFD96B4F9802A16274FA5956@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VWDi4ZTUD9P2IWf4G1XkChsF2A6E9XVhqOzJ23w3SqstUo+TRKKUfPnvEklmgO/uMJcBi+zE4VST8IXxssZvSHc3K0QFw5p6p81FZKSz8DBK5ywYYqDyTHeyDQ/uBOEosOvKnsRuWvnArftCYeOubFmaC7705ud3XdodeUuCVI7obYg9bi+Y1u1bvixfSS9y3jcTBjyNCm/Qy1dP0aS34oFqFY1wgqF9ZtuIE7cqjKxpFWgMR+LlQR/WYFCgrqay03n9fXWH1euBYSObkQdBxKs1faFD+PzLQFc7Uf2a95r0aoyTG3pw3jt8/5IMeGzwTDgOM80edzdBVQmWe4jZv+YYCbiww/yUnucbkFJ5lua+5LrrZ/7aqLWMah2n3A7u44jYnE66UhCxLaaDADiXt87eCKW1SNvOvYrlpRhbgAPhuvH7M2IHjFhnPS9x4henF7QSycZSpdPf5T/9E1RyC4ABYCniIThL4nQnwRZRszEU+AZGtRTnMbemoXjUt6lWHV43WA/jYmZNBKVC+qkJ+11Db6DWFG0qYi77VVNBmIa8w3k26cYh8Jr1WsrZfqAiwomhEYlaNiFM4qeknWuzYGFrbNB8DjsRxvq8tK2W+fId8UKSyMv8DB3wkQDcd0n6J0yrbaToY0cMV0/gWcd//A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c98669-c089-4fbf-3d66-08dde1021842
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 22:28:46.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfvzU2YhUws/SlVWI3sDvw+VbALGqmooaD0gExruLdNNZn2eFamYJVZ3rsmbNnadxAmgOcHXnuc9ZYp5WWkX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDA1MiBTYWx0ZWRfX6CFddEy5K8Ci
 bvpl9/UzyhGTHqb34Wfl2PqWShRoHcEE+KXilcVX9Mu79CgDy7oJyz4GOw9VGNAdRetJY9xqDZt
 3fmZyw2mbNFwxnjbjq1piv7FjvTtyqKViqYAgBcwwKE4igKozcSMaK7BpHW49NYq+8aOu8E9FMe
 9acqFFxkbxgcrZ73Jf5eB9KN7AeZtl9dGNPhsb6okQPUr1UReUkSv+ZQLtzGUjq6uK2OY3VKmNa
 2lR/ErAfQfPXFC4VxfjOgfrNuNFuAnUJXK2XyV4d8P3sx5pAiNoKxD9nHGVvwee6n+oER2QuO+Q
 MYiOEodMRzwABaoagPQfzDiJarOsus4VGRrRlEBSIftpB6wEJvvRqoyBot7iheCQOlnCO3P6sbg
 1pThQcEKS29Hk7WZzt9tvx/Dw70WiA==
X-Authority-Analysis: v=2.4 cv=KcKLcQYD c=1 sm=1 tr=0 ts=68a79da5 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=dOLNmq4gAAAA:8 a=VwQbUJbxAAAA:8 a=YfRT58wHGhQ0vCvFLNIA:9 a=QEXdDO2ut3YA:10
 a=_m6CO-mWuQdSFutSHjXj:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: TDtxUET65OnDWwsvuUemYL1CEwx6Qk8g
X-Proofpoint-ORIG-GUID: TDtxUET65OnDWwsvuUemYL1CEwx6Qk8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2508110000 definitions=main-2508200052

T24gVGh1LCBBdWcgMjEsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IEZyb206IEphbm5lIEdy
dW5hdSA8akBqYW5uYXUubmV0Pg0KPiANCj4gSXQgcmVzdWx0cyBpbiBTRXJyb3JzIGR1cmluZyBp
bml0IHByZXN1bWVkbHkgYmVjYXVzZSBNTUlPIGFjY2Vzc2VzIGZhaWwNCj4gd2hpbGUgY2VydGFp
biBwYXJ0cyBhcmUgc2h1dGRvd24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYW5uZSBHcnVuYXUg
PGpAamFubmF1Lm5ldD4NCj4gU2lnbmVkLW9mZi1ieTogU3ZlbiBQZXRlciA8c3ZlbkBrZXJuZWwu
b3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMSArDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaCB8IDIgKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIHwgNSAr
KysrLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+IGluZGV4IDI2YWE1MDdhNzM4ZjAwMTQwOWE5N2VmNTYzYzY1NjE0MzNh
MWNhYzUuLjhkMmRjN2ZhMTgxMTQxMDJjYzg4OTNjNGNhMGU3NDVlMTZmMzA3NTQgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IEBAIC0yMjczLDYgKzIyNzMsNyBAQCBpbnQgZHdjM19jb3JlX3Byb2JlKGNvbnN0
IHN0cnVjdCBkd2MzX3Byb2JlX2RhdGEgKmRhdGEpDQo+ICANCj4gIAkJCWR3Yy0+ZHJfbW9kZSA9
IFVTQl9EUl9NT0RFX09URzsNCj4gIAkJCWR3Yy0+cm9sZV9zd2l0Y2hfcmVzZXRfcXVpcmsgPSB0
cnVlOw0KPiArCQkJZHdjLT5ub19lYXJseV9yb290aHViX3Bvd2Vyb2ZmID0gdHJ1ZTsNCj4gIAkJ
fQ0KPiAgCX0NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAzOGYzMmYyYTYxOTNjMWIyNjYyYWI0ZjM4
ZjRkMjBjZjRiMGUxOThkLi4zYzNhMzZlYzM3MzQ1YjJmOWU3MTQ0NGJhM2I5MGI1MmRiZDI0NDQz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTE1NSw2ICsxMTU1LDcgQEAgc3RydWN0IGR3YzNfc2Ny
YXRjaHBhZF9hcnJheSB7DQo+ICAgKiBAc3VzcGh5X3N0YXRlOiBzdGF0ZSBvZiBEV0MzX0dVU0Iy
UEhZQ0ZHX1NVU1BIWSArIERXQzNfR1VTQjNQSVBFQ1RMX1NVU1BIWQ0KPiAgICoJCSAgYmVmb3Jl
IFBNIHN1c3BlbmQuDQo+ICAgKiBAcm9sZV9zd2l0Y2hfcmVzZXRfcXVpcms6IHNldCB0byBmb3Jj
ZSByZWluaXRpYWxpemF0aW9uIGFmdGVyIGFueSByb2xlIHN3aXRjaA0KPiArICogQG5vX2Vhcmx5
X3Jvb3RodWJfcG93ZXJvZmY6IHNldCB0byBza2lwIGVhcmx5IHJvb3QgaHViIHBvcnQgcG93ZXIg
b2ZmDQo+ICAgKiBAaW1vZF9pbnRlcnZhbDogc2V0IHRoZSBpbnRlcnJ1cHQgbW9kZXJhdGlvbiBp
bnRlcnZhbCBpbiAyNTBucw0KPiAgICoJCQlpbmNyZW1lbnRzIG9yIDAgdG8gZGlzYWJsZS4NCj4g
ICAqIEBtYXhfY2ZnX2VwczogY3VycmVudCBtYXggbnVtYmVyIG9mIElOIGVwcyB1c2VkIGFjcm9z
cyBhbGwgVVNCIGNvbmZpZ3MuDQo+IEBAIC0xMzk0LDYgKzEzOTUsNyBAQCBzdHJ1Y3QgZHdjMyB7
DQo+ICAJdW5zaWduZWQJCXN1c3BoeV9zdGF0ZToxOw0KPiAgDQo+ICAJdW5zaWduZWQJCXJvbGVf
c3dpdGNoX3Jlc2V0X3F1aXJrOjE7DQo+ICsJdW5zaWduZWQJCW5vX2Vhcmx5X3Jvb3RodWJfcG93
ZXJvZmY6MTsNCj4gIA0KPiAgCXUxNgkJCWltb2RfaW50ZXJ2YWw7DQo+ICANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4g
aW5kZXggZjdhNzFlNmY5ZDgwYWNhNjMyZjFmOTcwZDkwMGEzZGU4YTc2ZjBhNy4uZjdjM2EwZmM1
ZmUyNTg3MDUzMTFmODljMWJhMTFmZjU5OWMwMWFmZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9ob3N0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gQEAgLTEz
NCw4ICsxMzQsMTEgQEAgaW50IGR3YzNfaG9zdF9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJ
LyoNCj4gIAkgKiBTb21lIHBsYXRmb3JtcyBuZWVkIHRvIHBvd2VyIG9mZiBhbGwgUm9vdCBodWIg
cG9ydHMgaW1tZWRpYXRlbHkgYWZ0ZXIgRFdDMyBzZXQgdG8gaG9zdA0KPiAgCSAqIG1vZGUgdG8g
YXZvaWQgVkJVUyBnbGl0Y2ggaGFwcGVuIHdoZW4geGhjaSBnZXQgcmVzZXQgbGF0ZXIuDQo+ICsJ
ICogT24gQXBwbGUgcGxhdGZvcm1zIHdlIG11c3Qgbm90IHRvdWNoIGFueSBNTUlPIHlldCBiZWNh
dXNlIGR3YzMNCj4gKwkgKiB3aWxsIG5vdCB3b3JrIGNvcnJlY3RseSBiZWZvcmUgaXRzIFBIWSBo
YXMgYmVlbiBpbml0aWFsaXplZC4NCg0KVGhpcyBkb2Vzbid0IG1ha2Ugc2Vuc2UsIHRoZSBwaHkg
c2hvdWxkJ3ZlIGJlZW4gaW5pdGlhbGl6ZWQgYnkgdGhpcw0KcG9pbnQuIFdlIGFscmVhZHkgYWNj
ZXNzIE1NSU8gYmVmb3JlIHRoaXMuIEV2ZW4geW91ciBbUEFUQ0ggUkZDIDcvMjJdDQphdHRlbXB0
cyB0byBhY2Nlc3MgTU1JTyBiZWZvcmUgdGhpcywgeWV0IGFjY2Vzc2luZyBoZXJlIGNhdXNlcyBw
cm9ibGVtLg0KRG8gd2Uga25vdyB3aGVuIHRoZSBwaHkgZ2V0IGluaXRpYWxpemVkIHRoZW4/DQoN
CkJSLA0KVGhpbmgNCg0KPiAgCSAqLw0KPiAtCWR3YzNfcG93ZXJfb2ZmX2FsbF9yb290aHViX3Bv
cnRzKGR3Yyk7DQo+ICsJaWYgKCFkd2MtPm5vX2Vhcmx5X3Jvb3RodWJfcG93ZXJvZmYpDQo+ICsJ
CWR3YzNfcG93ZXJfb2ZmX2FsbF9yb290aHViX3BvcnRzKGR3Yyk7DQo+ICANCj4gIAlpcnEgPSBk
d2MzX2hvc3RfZ2V0X2lycShkd2MpOw0KPiAgCWlmIChpcnEgPCAwKQ0KPiANCj4gLS0gDQo+IDIu
MzQuMQ0KPiANCj4g

