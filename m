Return-Path: <linux-kernel+bounces-758503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D796B1CFF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D513BDD94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405716DC28;
	Thu,  7 Aug 2025 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jtaude5K";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bN7G79qI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cI85E1bJ"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57B2E36E6;
	Thu,  7 Aug 2025 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528352; cv=fail; b=jnhc0/pDKo3zCEgPagNUdIXIr/jpGoSB0jIcv6sOjTPycajRwR1xQn3ExIkpy74hJRVsHvcRpHpWCzJyvfBChfssdhJ/TuX6yl4V70ywr8D2doMmb4M0emzQTD7cX3sm4l36tgdBpJxZtfq+57pU3XS6gpicdlM9z9XpjsaKajI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528352; c=relaxed/simple;
	bh=quiOfXDdXdTf1p7eMQBKOQwL/cqBzXZ1jS8DTyR2nq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LrnG0ZOyKY7zvy/ijaRYgTL+yaJNh5w4t8Dq701pViorXV1eLrJ7Wskh0IiWZYAAkxVY6176P7nUWjyjAOSmthdMWXh0dMasdrc0g5XyD0JLchrqJkmGNEz8yEHraVnsalloykiaA7ZdiRgNhzFbOrsYXpLWl5SBEi4rj/htLLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jtaude5K; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bN7G79qI; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cI85E1bJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576JVlOH015865;
	Wed, 6 Aug 2025 17:58:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=quiOfXDdXdTf1p7eMQBKOQwL/cqBzXZ1jS8DTyR2nq8=; b=
	jtaude5Kb56/E1PA39TFL6hcYWLthH76D0705Emznzjm6HwEEbkLMsTMw0INef71
	IiUBHQTMk01H0pinWSVd9M2aiTZaBNn4jbP5tcFdu4beT3Dpz5MceRlCg69WIBod
	JhaN31A17JmeZQQZ253bW8Nh58PzTJgT1eBxA4UbY3sq5gELcIcuKHypl2l76BSB
	Uss29NFu6mtvk5raDYkVnWmbMA5PSQFyGXyXVPH3I8EfiBTW7+Lmi6311tvfJpSO
	XRCzCJefxLnC7synPUhgfYM3yPLTagy0ZKeadrFkCclEgjAqnSlOtUNaejoC5119
	ZSKd2BFfrazHmxi4qHENew==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48bq0wgbyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 17:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754528304; bh=quiOfXDdXdTf1p7eMQBKOQwL/cqBzXZ1jS8DTyR2nq8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=bN7G79qIViKYWW4jCYpA9i10IrZqa7/cfIpgj97sjh/X/bTNsRkuvSTvCKr5yM6g8
	 xrmo0XLaosSWLGC8U/sU/6RLmpfPyQQct2LW7MsMWO8C+6NQSIhfoxZfNHuVfLTaPi
	 BUj09uZowtMGWYb7s08DEDU5RzMpUDM/+7scazKwtoYG2/EhdWYemUI/wK4QZaIRwP
	 HAWtkRfRuLe0ai8SqCHnoXLIl6BqCkScuzZ4ZbJnwlbCDVw7iijks9n7F7JqWqIrYR
	 5vx/N5whfMRyy4j+0LR7uzULzmOlqK1ujCSe5olPpVBxv2IrVsfj+sRrmhD3O5wFa2
	 +3KjNb3tSHY0Q==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0F00E404CE;
	Thu,  7 Aug 2025 00:58:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 40323A0098;
	Thu,  7 Aug 2025 00:58:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cI85E1bJ;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8D2334028D;
	Thu,  7 Aug 2025 00:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdIPPaEHdliOMtdWrJB5ns9r8Lxb3pU7Oo3BDQTglwVUwkIT7DTIPCXZVXy3P6fqBZmuzJDr2A4VdpccSuwNd/FUzUqCCPntco/6FVhuzEJi3xh6XuqLZq7s6gpGN+htwARe56ncgrMU83crnVGVJkrmUG8Q+BjoaC68PMLxq1Q3UTM/G+3n+oIn0+7jxoBnBlnCEcqWcm4wR+uJ/tCwlV8k9IqRxyWouc7PfDoH6S+/+1wo2usz/I5H45xz3r9LSLwqKy/aho9YByVKJGRzzQsCSwsaGxLIL8jaOKzJxRIyBnHEdcn90jkvPoG+WhUUy47dHgWqw4zC41dbKzoQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quiOfXDdXdTf1p7eMQBKOQwL/cqBzXZ1jS8DTyR2nq8=;
 b=ZhApCxPwaENLEScDZuGtbbzfVSPE4Hrmx0w1oxodNYE/VXV2Ah8LphR1T7EBvFuUSwHbLMgBomQUFO+eLLo3TJJOFpouS+v5ojM7VMeM1LAlfd7jmA5zLgj2PDZl3V6uFISABX3SKt6z4rCN8PfSX7wY5I9rFs4MN6z16EpjvPcxajMpjaPo6IElUWhKhnSQMVSMnfzwtAAigk8EW1Bse4uQkLBvsJiUUThvzl2F7QmGTC3lvbvnKCBFmYwUYHAq8si7xNvkYWKUKlzYS74GrTUVIkWA0Orfp/zhl5sKWhmrG6JJmHgvqT0Fi2tpTf3xcRmag7fQzwx8NGLWWBuZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quiOfXDdXdTf1p7eMQBKOQwL/cqBzXZ1jS8DTyR2nq8=;
 b=cI85E1bJ9MfkYNnRd6TMEOlQwjBlWwft4yBMZW66RtVMFYXUbcfJ0YNqLwk57aewqjTbm2gFpD+WdyEeyjZs97nnbtLT5Lj1g5BP+DeiklIoRIl0ikbF84TjxJE4B8iD7WfVG/nxjyB3TsmXNO/YlBhGTaK6NSfPnrt5dddE2Xc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 00:58:15 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 00:58:15 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: John Keeping <jkeeping@inmusicbrands.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC/PATCH 1/2] usb: dwc3: disable for USB_ROLE_NONE
Thread-Topic: [RFC/PATCH 1/2] usb: dwc3: disable for USB_ROLE_NONE
Thread-Index: AQHb8a6RTP30Xr6qbkW6FXojJLTBNbQtn6yAgAQhPgCAGAbmgIAMPuiAgACCnwA=
Date: Thu, 7 Aug 2025 00:58:15 +0000
Message-ID: <20250807005814.nlf7aotts5o7navl@synopsys.com>
References: <20250710152252.2532020-1-jkeeping@inmusicbrands.com>
 <20250710152252.2532020-2-jkeeping@inmusicbrands.com>
 <20250712001131.ax3rw24h3deekxfv@synopsys.com>
 <aHUfFGnGZP4z7UgK-jkeeping@inmusicbrands.com>
 <20250729221027.jvg3bpqhc3z5j7xn@synopsys.com>
 <aJOMk_PVasn-tvV6-jkeeping@inmusicbrands.com>
In-Reply-To: <aJOMk_PVasn-tvV6-jkeeping@inmusicbrands.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB7007:EE_
x-ms-office365-filtering-correlation-id: 4208fe28-290e-4ea8-f474-08ddd54d7d9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGMwUnVmOTF6N1BneksvOEVRNmZxaWNLenFxREgvOWhoWWR1OWowVGJIaDZq?=
 =?utf-8?B?Zk1sR3FPU0lLNlc2OEt0cE5NNXJNVE5vdDAvVWRmS05rNHJCNVpjNm9WcVN5?=
 =?utf-8?B?UU9qbGtLMkpsWDl4Nm1oNXNvSEU3V0ZxcXRIQkMwVUJxM0VpY1U0cUs1Nm5Z?=
 =?utf-8?B?ZkwzWUI5SFA2RVVtU1VhSWVkUmVEMGdFeEpXd1ZaaGllQlJNT29CQ2EvUDJR?=
 =?utf-8?B?V2lNcjlHUlhsemlZOTFxVk5XaHVqSUhOVUNyVWp1YkEyRnJqSFRNZ1Mza0lK?=
 =?utf-8?B?NDd1WHNBV0xZQUY3VHhienlnbGxBbzA3T1pyVmpCd0RpcG5hQlpJZTZ5OHlt?=
 =?utf-8?B?cFpNb1VIU2ZaNU9oMGY4U2h2bUh2U3JiSEVMZ09YbjBNdm1ySTBMOXlBZzZx?=
 =?utf-8?B?YTNqdEhMaFpJd2ppTHpobXo5WEZSc0NvMkZvRERHaUdYMmhaTUxYOXZLWUJR?=
 =?utf-8?B?a1RDeUlIcWszZWc4MWFmcS91ZzNUb2NMKytib3lQNXBFcW5BdnFmV1M3ejlq?=
 =?utf-8?B?aDRFUGhqL0JnOVZYQVBBbnRLVHpHcmRGOC8zQUdtTm9URktqeVZJay9BTGtL?=
 =?utf-8?B?b3ZTUmJDNGFqUTVIWTJ4RFFPb3k2K0wrUWtJdUh5aVRkMGNjcE9DTHBDMURi?=
 =?utf-8?B?WUZ6QkRJQjljKysvNURiUHdpUWg2Z2lxcUg4SUcxRXlURUN2dTZLOWxZVUdI?=
 =?utf-8?B?dituRnlCWlZxempRamxadGZnSVpmd3liUCtWQnp1SkRsVjVSQVQ3NkJiQWZu?=
 =?utf-8?B?TzdmTENVV0cxQ0FZRzMwZTlLWnljcFVMdzRBOVBvMDI2aHVMRUQxaTFXMUlE?=
 =?utf-8?B?RE1LaU1hSkNWdmU1ZUZDMGM1OXlhTlZnb2g5U2t4bGovb1pUUVUvWDJFNEZP?=
 =?utf-8?B?NVgvWXh3L2NOallRRGhGbURydlQwNEVCc0VFby92RWU0b0RkZjV1d3BYYlZL?=
 =?utf-8?B?TCtFd1REenpIbm9oOGZpaUlLNHVFaGNiRGUvaG5wU1RsUzFoNFZzdWxHQXI1?=
 =?utf-8?B?YTdrd1g3L2o5ekVXekhaWjdZQjdudDlYUnEwbnQ0WmR2TnRXUW1OU3pSZjdz?=
 =?utf-8?B?WWN3TERVOFJKWGF3UUs3d3JSMGROcFJNK1pOd2thajVnWEF4REVPR0JRL2tt?=
 =?utf-8?B?T1VPOVA3Ujhxa1BvcnRPd25Gbm00U0JPY052cjdFWjl0YTJFSUllTEh5VW53?=
 =?utf-8?B?b09rZ2U0N2JockxrcUx4MWp1UzdkaTY4UGhVK1lGb3BqdVBJWnVrd1FyYkl2?=
 =?utf-8?B?TUdWVjFIUitpZ3N6aW55eVFObDl4SFY3VGVlZkQvMmxzajdMbGh6N2FYUFQ5?=
 =?utf-8?B?WDk1QlkwUEpWbHJHa1NuQ3BRV3FVY2xEd2FZaVZGSm9xUFp4TkFWR3Vjb1Bu?=
 =?utf-8?B?Ukk2K2lYSE50OTVMWDM1dW1PT1A5WWlvRkxWaTJlYmRUQ2xSdVRIUmorbzFs?=
 =?utf-8?B?NFJOUnp4WEpwMFZKZlhDQ0l3c1BXbzRzb3RQZENYQlFJTncvZ3NqdGRrK2k3?=
 =?utf-8?B?dTFzR3NKaTM3eFptM1FhaFZtajRpbU9zMjE2eVBMYlB5cDhWeHA0ZlRRNmtH?=
 =?utf-8?B?aDdiSVpGWHcvUEhaeFVMNHFiajNKamtoQ05NY2o4RmFqSCs5ZzJGeHo1bm8y?=
 =?utf-8?B?NUFwbFQ4UTFDY0M1NXE3SE1aZGgrK1Nya0NBVTgrckgyL2NuWmhla3FvblA5?=
 =?utf-8?B?TjFYREwzdll1c05aalhBdlArZ3BkdkRUYnV1d1ZsanNlSDhjYU9XYU4xTXJh?=
 =?utf-8?B?Ukt0Z2MxYWRwbkVvMDNadkR0cGRtanhqeS9Gc3F4MkhWa2o4bEUzMGlXekdH?=
 =?utf-8?B?RXNBMkl3VlZGZjc0d0YrK1dOOG5Id2xvQzBvMXdzcWdDQ3ZwV2FDaUJJOTBS?=
 =?utf-8?B?UHF5SXhHYjF0bWNMclRJaFByWXlQTy8wR20yNVk5aEgrczZMYS9Fb1ozMVJ1?=
 =?utf-8?B?TFVEakJlMUdkN0ovdjR4cCtteU1RK29vTFZoTTVBUVNnTm1SbEtVLzZxcVZ3?=
 =?utf-8?Q?/LOedlMV9LNtzfwzuHhePEaqwFvl0E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajYrZnNmZjZWMWhpTnBqbXk4dkZKNnJTRUUzbXp6WFJ6MkRReUdSVk5Sc1gx?=
 =?utf-8?B?QzdMRUtYeEs5aklsUlZRdWNWbFIxWVg5N1J4c0hBRmNKY0wxNW9qVTI4dENz?=
 =?utf-8?B?R20rNVNudUpvNUt4SVAxVDhCbEJhTHV6RnFHU2VWbm1xZ3V1bUdGdTVtUTky?=
 =?utf-8?B?R09jb2tMbFNYU0FYSk5ES1ZwUFdza2p3bFNNYVJPVHpLTHBwWHdkaW5pbTFB?=
 =?utf-8?B?QzVVd004ZFJZVEgvSGt5dnpDSCs3VUd4WnpZWm9xeEtpWjEvamhIa255QzF3?=
 =?utf-8?B?WTkrcUpOZ01hUkIydnRzZVZYeXZ5M3B5aUFUYjI4TS9USW00WlIycHExZjZ3?=
 =?utf-8?B?UktmRmlJbncweGgxbWhkSTNCQXpMM3hlTTdoL2J2ekgrZHIxTFIzcDkwaWxs?=
 =?utf-8?B?Z25iRHQrYUxySG5yOUZHVVZid1VaYVg5S25RY2lWRWs4MFVNWEVWbWFsQndF?=
 =?utf-8?B?c0pHNngyWUhqRHBXZGh1T0svNkpGUGFaanlsaHppM0ppMjM3Zlk4RTFoQnpD?=
 =?utf-8?B?QVpWTXJ4NFZ0N25RalZLdEE5TFdwQVpBenUrNHc2N0RnTEtPQUVSbWlSbG9j?=
 =?utf-8?B?S0g3RVkvcUkwRENnSE5XMjVwY3M3ZHBzb1VFcXlZMnJlNjhBY1JKUlRXVTVl?=
 =?utf-8?B?ZktVeTdJQ0ZjZ2lIalovL0Z4UEpMMWVxNjNwcHY5cEs0NW1sblBjUUlzcjdZ?=
 =?utf-8?B?Lzh4cVJvbUhJeVF1UE1PZUlNbmVHcGRFVFdJT1lINXUwYkZIbElvU3YvRGU5?=
 =?utf-8?B?S3B3S2hLOUtjRnBMNWE0N2k1VE9YNW9OWlpFTVF1YmhsQ1lSby9QQm5LWlg3?=
 =?utf-8?B?RGZnMjdiQ21aK1BLSUMwRENyeHlrbWpMcUpMZDdLaDZOMk9tT0hoV2d4TGlP?=
 =?utf-8?B?aEttSkFPTnR3NzFTenYyampOSWNzMGdVa3AxUGpnbUZaV2pxcGlYd3RKd0Ja?=
 =?utf-8?B?TkdUakdWSlRyeEdzU1FWbFVuMXJveVFaUXVwbmYvTno2MmNMK1h0OFc5bjdB?=
 =?utf-8?B?U0VYdFg5cUl1S2RmVHJicitYUmM4andFRXVPd2UvWTk2ZHMvV2dQZ3JzQm5t?=
 =?utf-8?B?QllkbS8xTlNQbnFhWDdRQ2R2ZitHZjIyOStSMmpxTkJndUgzcWV5d1QxWnN0?=
 =?utf-8?B?WXBsem1obDFYWWd6VXVLQzFYbmhXVElEZjBlU1ZUNnRzME9xejhrZ09GaDZm?=
 =?utf-8?B?WUppNiswRXNKSGovVGIyb2FQaVJITWlqdEVzSzg3NzFZUmFJQW1YU2dLc21R?=
 =?utf-8?B?NjJnWm9oMW5LK2FTU1BGOTVCM1RtcXlaVTRNMXZ0YU14SGsycEpVY1NuRHdZ?=
 =?utf-8?B?dnhLWWp6Nk1UZ084ekVpSHpuanYxTGU1VFdvSGpoSlEwaDVWN3MyT1pmanA0?=
 =?utf-8?B?MER0RWlEajlZWmhJUEZYZVlwbk1JV2xhaml2eXR0ZStSZHRjc3dCVEFpYnlP?=
 =?utf-8?B?MU5UYUsxSG51amNPZEhMV1V0REtFYURWNHlWOEZxYU10NGhHSXBOR05pYXNi?=
 =?utf-8?B?bVNmOGc3LzFpTy9PbTdQVmNXZXBvaitSMWkwVEhWY0kzMWxaY1NoR1EycjNq?=
 =?utf-8?B?bUt5dXY4cXpNMnhuNWdZcnRaRjFOaU8yZG5RWWN2Rk01UDFXQTNRcWlwekdj?=
 =?utf-8?B?TTExZlErUjU4OXlLV01PSVZjNWpwaklEMC9vTjJyaUhsc0JXcnRWa05sZ2E1?=
 =?utf-8?B?dzIxeUlyMWlpemJuazl6b0g2VlpENUJ2dVZ0NVZTMTlJb1NydGs3QlUrd1RP?=
 =?utf-8?B?UFNjSmdNVzA1cHVnaERjeVo1Uk00aXFJT0R4R1dWblhjMmxPTC9vaXRaZEdL?=
 =?utf-8?B?UkFTQ2srQXd5SVhQZmlqcE45WVR2bElvUHNOMFJLdE9PbDI1SkJnZlQrZjJn?=
 =?utf-8?B?SUtqeWxQU01sWjljNTNlQUE3ZDhERFoyMGRSTUxUcVhKVzNDbldPcjJoSm9w?=
 =?utf-8?B?Smc5bEU5RFNlbjVDbmdBSThUUGl6VG9nLzhiRFovL2MrWjNGVnZiYy9OdzAz?=
 =?utf-8?B?cWFOZnczTE53djhwUExHdHZYbWEzWlBPbTVOQ05CYWVqY0xFaEJqelhka05l?=
 =?utf-8?B?U0RJNmpSVjlaLzNvM0RDbmdjRTA0L3Z6b0ZacndKclVYQWtEZjVxS3lubURz?=
 =?utf-8?Q?RSO+ysDoz1EZO3WHSRji9ucxY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <241D6087F0BB4E4499D2E3F7C4298AFC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ieVPW5oo1nOBJPj/NGsWQ8hTLPZMtjVjPOkTMqg3EEsQzA3otiDY2gNZ5PqYV/pGum47JzxXwZUrS8041pWBpTbzHw0ZrAscuJWaPoDqWbZtwaDPixevDNF2cC0CmQ2SYqKhG8EMqJMkdoHyow24JLMppihlcFg+M7IoY12wnWDm5kWFV6ufNYbVEC5m325/2KLWYq2cb862KOO314LhwRWhaBHN+alA65sZOPkfMZ7+XN0pjvSKKWRFCimhabRJBFYyBdo4DY7otZuzgrHpOT34jYxKPuJpVULq+9dHNtYgicYks/vz5vx/tk3FfSkvx+SaGUgN5+nnKggCIxew0rSNi3EH31s50aObmCTDs5ulkkP8CAh6KRUmb+yQ5tWmYRSrqk67UU52JhKhOKP1gUK/1iBQXaeXRARhoTxLBgmMgiDYe7nwEDIXtsPl3+bXxw0iRYniRmCYh9mNfsO4xDK0KntRi/3PaEdJ8/34Xl5Z5KW5vz45W1JNCL89lo+IMLUsmNpyuOmRSbcoeJlEkEdpkkcNC31P+qT7gm7y/HWaUddzZYvv+ASnYqff3V4oHUyJnClGVxQpIG9TYJp+ScPhvBwwOMRlEaYpIYWemjxAYIlsd1N+ALMsRX5PyRFiHbjGfsP5nQgX2j/LI2V1ig==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4208fe28-290e-4ea8-f474-08ddd54d7d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 00:58:15.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+G52ppbAZyA/ALEehLbIrq7eAt1Xqwy5TTBDcc2NAKZpAHWm0Z7CbqwqY76IdKc56bNkw2F07WRpBCsiHoVGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
X-Proofpoint-GUID: YGN5kO_6j7y9IPtLIqKlRP6WvCFU0wiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyOCBTYWx0ZWRfXxDyhn51CTR/h
 E9aFXEI6DTU8SVEVV94C1lzYV3YPHB7eIftMK/QJ1vujqYWk/uFST3mUkJR0ezvLIf20B2tq9I1
 mDg21wo+Idb6fyh6z4KmJk0+jy2HiVCz6mH5N6pfQoGyC03jtsUhVWPMkLLPOeYZFLteSvNN5DP
 NWsZLFcgXm3pF8Lwqh5/BRT+e+uNwSoncW14GHWoNJPnlA65PijS7GsJKbd7k9TvEeIkxX+cttV
 ru6UG1Gma0g9IJWBvM6oWewjc705fFJ1k2LYRVG65urmfVgIKNkzPh370afNl4qF58soHbsfeg7
 z74CWcwfB8yMPos5Baomo0Y4xDt9wodwfrR16m7VtYHnsJfYdFgg6tb5e/mrl+Xs0AjGUREb3O9
 RftSRMaS
X-Proofpoint-ORIG-GUID: YGN5kO_6j7y9IPtLIqKlRP6WvCFU0wiE
X-Authority-Analysis: v=2.4 cv=HYMUTjE8 c=1 sm=1 tr=0 ts=6893fa31 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=pXuMzSUkCGukDOER0psA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508050128

T24gV2VkLCBBdWcgMDYsIDIwMjUsIEpvaG4gS2VlcGluZyB3cm90ZToNCj4gT24gVHVlLCBKdWwg
MjksIDIwMjUgYXQgMTA6MTA6MzVQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9u
IE1vbiwgSnVsIDE0LCAyMDI1LCBKb2huIEtlZXBpbmcgd3JvdGU6DQo+ID4gPiBPbiBTYXQsIEp1
bCAxMiwgMjAyNSBhdCAxMjoxMTozOEFNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4g
PiA+IE9uIFRodSwgSnVsIDEwLCAyMDI1LCBKb2huIEtlZXBpbmcgd3JvdGU6DQo+ID4gPiA+ID4g
V2hlbiB0aGUgcGh5IGlzIGFjdGluZyBhcyBhIFR5cGUgQyBtdXgsIGl0IG1heSBuZWVkIHRvIHJl
c2V0IHdoZW4gdGhlDQo+ID4gPiA+ID4gY2FibGUgZGlyZWN0aW9uIGNoYW5nZXMuICBCdXQgdGhp
cyBzaG91bGQgbm90IGhhcHBlbiB3aGlsZSBEV0MzIGlzDQo+ID4gPiA+ID4gdHJ5aW5nIHRvIHVz
ZSB0aGUgVVNCIGNvbm5lY3Rpb24uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSW4gdGhpcyBjYXNl
LCB0aGVyZSBtdXN0IGJlIGEgY29ubmVjdGlvbiBtYW5hZ2VyIHRvIG5vdGlmeSB0aGUgcGh5IG9m
DQo+ID4gPiA+ID4gdGhlIG9yaWVudGF0aW9uIGNoYW5nZSBhbmQgdGNwbV9tdXhfc2V0KCkgZW5z
dXJlcyB0aGlzIGhhcHBlbnMgYmVmb3JlDQo+ID4gPiA+ID4gRFdDMydzIHJvbGUgc3dpdGNoIGlz
IGluZm9ybWVkIG9mIGEgY2hhbmdlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEl0IHNob3VsZCBu
b3QgYmUgcG9zc2libGUgdG8gZ28gZGlyZWN0bHkgZnJvbSBkZXZpY2UtPmRldmljZSBvcg0KPiA+
ID4gPiA+IGhvc3QtPmhvc3Qgd2l0aCBhIGNoYW5nZSBpbiBvcmllbnRhdGlvbiB3aXRob3V0IHRy
YW5zaXRpb25pbmcgdGhyb3VnaA0KPiA+ID4gPiA+IHRoZSAibm9uZSIgcm9sZSBhcyB0aGUgY2Fi
bGUgaXMgdW5wbHVnZ2VkLiAgU28gZW5zdXJpbmcgdGhhdCBEV0MzIGFsd2F5cw0KPiA+ID4gPiAN
Cj4gPiA+ID4gVGhlIGNvbnRyb2xsZXIgaXMgZWl0aGVyIGhvc3Qgb3IgZGV2aWNlIG1vZGUuIEl0
J3Mgb2RkIHRvIHVzZSAibm9uZSIgdG8NCj4gPiA+ID4gaW5kaWNhdGUgY29ubmVjdGlvbi4NCj4g
PiA+IA0KPiA+ID4gVGhlcmUgaXMgbm8gY29ubmVjdGlvbiBpbiB0aGlzIHN0YXRlLiAgV2hlbiB0
aGUgdHlwZSBDIGNvbnRyb2xsZXINCj4gPiA+IGluZGljYXRlcyB0aGF0IHRoZSByb2xlIGlzICJu
b25lIiB0aGVuIHRoZXJlIGNhbm5vdCBiZSBhIFVTQiBjb25uZWN0aW9uLg0KPiA+ID4gDQo+ID4g
DQo+ID4gSXQncyBub3QgYWJvdXQgY29ubmVjdGlvbi4gSXQncyBhYm91dCB0aGUgY3VycmVudCBt
b2RlIG9mIHRoZSBVU0INCj4gPiBjb250cm9sbGVyLiBUaGUgbW9kZSBvZiB0aGUgY29udHJvbGxl
ciBpc24ndCAibm9uZSIgb24gZGlzY29ubmVjdGlvbg0KPiA+IGV2ZW4gaWYgeW91IHRyeSB0byBy
b2xlLXN3aXRjaCB0byB0aGF0IHZpYSB0aGUgdHlwZWMgc3dpdGNoLg0KPiA+IA0KPiA+ID4gPiA+
IGluZm9ybXMgdGhlIHBoeSBvZiB0aGUgbmV3IG1vZGUgd2hlbmV2ZXIgYSBwbHVnIGlzIGRldGVj
dGVkIHNob3VsZCBiZQ0KPiA+ID4gPiA+IHN1ZmZpY2llbnQgZm9yIHRoZSBwaHkgdG8gc2FmZWx5
IHJlc2V0IGl0c2VsZiBhdCBhIHRpbWUgdGhhdCBpcyBzYWZlIGZvcg0KPiA+ID4gPiA+IERXQzMu
DQo+ID4gPiA+IA0KPiA+ID4gPiBDb3VsZG4ndCB0aGUgcGh5IGRvIHRoaXMgYXMgaXQgZGV0ZWN0
cyBjb25uZWN0aW9uL2Rpc2Nvbm5lY3Rpb24uDQo+ID4gPiANCj4gPiA+IEkgZG9uJ3QgdGhpbmsg
dGhlIHBoeSBjYW4gZGV0ZWN0IGEgY29ubmVjdGlvbi4gIElmIGl0IGlzIGNvbmZpZ3VyZWQgZm9y
DQo+ID4gPiB0aGUgd3Jvbmcgb3JpZW50YXRpb24gdGhlbiBpdCB3aWxsIG5vdCBtb25pdG9yIHRo
ZSBjb3JyZWN0IGRhdGEgbGluZXMuDQo+ID4gPiBUaGUgcGh5IGhhcmR3YXJlIGRvZXMgbm90IHNp
Z25hbCBhbnkgaW50ZXJydXB0cyB0byB0aGUgQ1BVIGZvciB0aGUNCj4gPiA+IGRyaXZlciB0byBy
ZWFjdCB0by4NCj4gPiANCj4gPiBPay4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiBJdCBzZWVtcyB3
aGF0IHlvdSBuZWVkIGlzIGEgZnVsbCBjb250cm9sbGVyIGluaXRpYWxpemF0aW9uIHVwb24gbmV3
DQo+ID4gPiA+IGNvbm5lY3Rpb24gb24gb3JpZW50YXRpb24gY2hhbmdlLCBhbmQgeW91J3JlIHVz
aW5nIHJvbGVfc3dpdGNoIHNlbGVjdGluZw0KPiA+ID4gPiAibm9uZSIgdG8gZG8gc28uDQo+ID4g
PiANCj4gPiA+IEknbSBub3Qgc3VyZSB3aGV0aGVyIGEgY29tcGxldGUgaW5pdGlhbGl6YXRpb24g
aXMgbmVjZXNzYXJ5LCBidXQgd2hhdCBJDQo+ID4gPiB3YW50IHRvIGF2b2lkIGlzIHRoZSBwaHkg
cmVzZXR0aW5nIHdoaWxlIHRoZSBjb250cm9sbGVyIGlzIHBhcnQtd2F5DQo+ID4gPiB0aHJvdWdo
IGRldmljZSBlbnVtZXJhdGlvbiBvciBzZXR0aW5nIHVwIGEgZ2FkZ2V0IGNvbmZpZ3VyYXRpb24u
DQo+ID4gPiANCj4gPiA+IEl0IG1heSBiZSB0aGF0IHNpbXBseSBhdm9pZGluZyByZXNldHRpbmcg
dGhlIHBoeSBpZiB0aGUgb3JpZW50YXRpb24gaXMNCj4gPiA+IHVuY2hhbmdlZCBpcyBlbm91Z2gg
dG8gYXZvaWQgc29tZSBvZiB0aGlzIHByb2JsZW0sIGJ1dCBJIHN1c3BlY3QgdGhlcmUNCj4gPiA+
IGFyZSBzdGlsbCBwcm9ibGVtcyBpZiB0aGUgY2xvY2tzIGZyb20gdGhlIHBoeSB0byB0aGUgY29u
dHJvbGxlciBhcmUNCj4gPiA+IHN0b3BwZWQgdW5leHBlY3RlZGx5LiAgSG93ZXZlciwgSSBoYXZl
IHJ1biBzb21lIHRlc3RzIG9mIHRoaXMgY2hhbmdlIGFuZA0KPiA+ID4gaXQgbG9va3MgcHJvbWlz
aW5nLg0KPiA+IA0KPiA+IFRoYXQgc291bmRzIGxpa2UgdGhlIHRoZSBwaHkgcmVzZXQgaXMgZG9u
ZSBhZnRlciBhc3NlcnRpbmcgdGhlIHZidXMNCj4gPiB2YWxpZCBsaW5lIGluZGljYXRpbmcgY29u
bmVjdGlvbiB0byB0aGUgY29udHJvbGxlci4gQ2FuIHRoaXMgYmUgZml4ZWQgaW4NCj4gPiB0aGUg
cGh5IG9yIHR5cGUtYyBkcml2ZXI/DQo+IA0KPiBJIGRvbid0IHRoaW5rIHNvLiAgSSd2ZSB0cmll
ZCBpbXBsZW1lbnRpbmcgdGhpcyBpbiB0aGUgcGh5IGRyaXZlciBhbmQgaXQNCj4gZG9lcyBub3Qg
d29yayByZWxpYWJseS4NCj4gDQo+ID4gPiA+IEknbSBub3Qgc3VyZSBpZiByb2xlLXN3aXRjaCBo
YXMgdGhlIHJpZ2h0IGludGVyZmFjZSB0byBkbyBzby4gUGVyaGFwcyB3ZQ0KPiA+ID4gPiBjYW4g
aW50cm9kdWNlIG9uZT8gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgY2hhbmdlIHRoZSBiZWhhdmlv
ciBvZiB0aGUNCj4gPiA+ID4gY3VycmVudCBmbG93IGFuZCBhcHBseSB0aGF0IHRvIGFsbCBvdGhl
ciBwbGF0Zm9ybXMuDQo+ID4gPiANCj4gPiA+IEkgZG9uJ3QgdGhpbmsgaXQncyB1bnJlYXNvbmFi
bGUgZm9yIHRoZSBjb250cm9sbGVyIHRvIGJlIGlkbGUgd2hlbiB0aGVyZQ0KPiA+ID4gaXMgYW4g
ZXh0ZXJuYWwgdHlwZSBDIGNvbnRyb2xsZXIgbm90aWZ5aW5nIHRoZSBjb25uZWN0aW9uIHN0YXRl
Lg0KPiA+ID4gDQo+ID4gPiBUaGUgaGFyZHdhcmUgc2V0dXAgbG9va3MgbGlrZSB0aGlzLCB3aXRo
IHRoZSBMaW51eCB0eXBlIEMgY29kZSBub3RpZnlpbmcNCj4gPiA+IHRoZSBwaHkgZHJpdmVyIG9m
IHRoZSBvcmllbnRhdGlvbiBjaGFuZ2UgYW5kIHRoZSBEV0MzIGRyaXZlciBvZiB0aGUgcm9sZQ0K
PiA+ID4gY2hhbmdlOg0KPiA+ID4gDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0t
LSsgICAgICAgICAgDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgfCBEV0MzIHw8LS0tLSsg
ICAgDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgKy0tXi0tLSsgICAgIHwgICAgDQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgIHwgICAgDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgKy0tdi0tKyAgICAgIHwgICAgDQo+ID4gPiAgICAgICAgICAgICAgICAg
Ky0tLS0+fCBQSFkgfCAgICAgIHxSb2xlDQo+ID4gPiAgICAgICAgICAgICAgICAgfCAgICAgKy0t
Xi0tKyAgICAgIHwgICAgDQo+ID4gPiAgICAgT3JpZW50YXRpb24gfCAgICAgICAgfCAgICAgICAg
IHwgICAgDQo+ID4gPiAgICAgICAgICAgICAgICAgfCAgICstLS0tdi0tLS0rICAgIHwgICAgDQo+
ID4gPiAgICAgICAgICAgICAgICAgKy0tLSsgRlVTQjMwMiArLS0tLSsgICAgDQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICstLS0tLS0tLS0rDQo+ID4gPiANCj4gPiA+IFRoZSBhZHZhbnRhZ2Ug
b2YgdXNpbmcgdGhlIHJvbGUgaG9vayBpcyB0aGF0IHdlIGFyZSBndWFyYW50ZWVkIHRoYXQgaXQN
Cj4gPiA+IGlzIGNhbGxlZCBhZnRlciB0aGUgcGh5IGhhcyBiZWVuIG5vdGlmaWVkIG9mIHRoZSBv
cmllbnRhdGlvbiBjaGFuZ2UuDQo+ID4gPiANCj4gPiA+IERvIHlvdSBoYXZlIGFuIGlkZWEgb2Yg
YSBuZXcgaW50ZXJmYWNlPyAgT3IgZG8geW91IHRoaW5rIGl0IGlzIHNhZmUgdG8NCj4gPiA+IHJl
c2V0IHRoZSBwaHkgdW5kZXJuZWF0aCB0aGUgY29udHJvbGxlciB3aGVuIHRoYXQgd2lsbCBoYWx0
IHRoZSBjbG9ja3MNCj4gPiA+IGZyb20gdGhlIHBoeSB0byB0aGUgY29udHJvbGxlciBmb3Igc29t
ZSBwZXJpb2Qgb2YgdGltZT8NCj4gPiANCj4gPiBUaGUgcHJvcGVyIGZpeCBzaG91bGQgYmUgaW4g
dGhlIHBoeSB3aGVyZSBpdCBzaG91bGQgb25seSBhc3NlcnQgdmJ1cw0KPiA+IHZhbGlkIGFmdGVy
IHByb2Nlc3Npbmcgb3JpZW50YXRpb24gYW5kIHBoeSByZXNldC4gSSdtIG5vdCBmYW1pbGlhciBv
bg0KPiA+IHRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4geW91ciBQSFkgYW5kIEZVU0IzMDIuIFRo
ZXJlIHNob3VsZCBiZSBzb21lDQo+ID4gaW5kaWNhdGlvbiBmcm9tIHRoZSBwaHkgdGhhdCBpdCdz
IHJlYWR5IGJlZm9yZSB5b3UgY2FuIGFzc2VydCB2YnVzLXZhbGlkDQo+ID4gKHRoYXQgY2FuIGJl
IGZyb20gYSBjYWxsYmFjaywgYSBzdGF0dXMgcmVnaXN0ZXIgZXRjKS4NCj4gDQo+IFRoZSBGVVNC
MzAyIGlzIGNvbm5lY3RlZCB0byB0aGUgQ1BVIHZpYSBJMkMsIHRoZXJlIGlzIG5vIGRpcmVjdA0K
PiBjb21tdW5pY2F0aW9uIGJldHdlZW4gaXQgYW5kIHRoZSBwaHksIGl0IGFsbCBnb2VzIHZpYSB0
aGUga2VybmVsJ3MgdGNwbQ0KPiBzdWJzeXN0ZW0uDQo+IA0KPiBUaGUgcHJvYmxlbSB3aXRoIHJl
LWluaXRpYWxpemluZyB0aGUgcGh5IGlzIHRoYXQgdGhpcyBjYXVzZXMgZHdjMyBnYWRnZXQNCj4g
Y29uZmlndXJhdGlvbiB0byBmYWlsIHdpdGggImZhaWxlZCB0byBlbmFibGUgZXAwb3V0IiwgYW5k
IHRoaXMgaGFwcGVucw0KPiB3aGVuIFZCVVMgdmFsaWQgaXMgZGUtYXNzZXJ0ZWQuICBUaGlzIGlz
IDEwMCUgcmVwcm9kdWNpYmxlIG9uIGJvb3QgZm9yDQo+IG1lIHdoZXJlIHRoZSBpbml0IHNjcmlw
dHMgYXJlIHNldHRpbmcgdXAgYSBnYWRnZXQgdmlhIGNvbmZpZ2ZzLg0KPiANCj4gU28gaXQgc2Vl
bXMgdGhlIHRpbWluZyBvZiB0aGUgcGh5IHNldHVwIG5lZWRzIHRvIGNvb3JkaW5hdGUgd2l0aCB0
aGUNCj4gZHdjMyBjb250cm9sbGVyLg0KDQpPay4NCg0KPiANCj4gPiBXaGF0IHlvdSd2ZSBkb25l
IGlzIGEgdGVhcmRvd24gYW5kIHJlaW5pdCBvZiB0aGUgZHJpdmVyLCB0cmlnZ2VyaW5nIGENCj4g
PiBzb2Z0LXJlc2V0LiBUaGlzIGNhbiByZS1zeW5jIHRoZSBwaHkuIFRoYXQgcHJvYmFibHkgdGFr
ZXMgbG9uZyBlbm91Z2gNCj4gPiB0aGF0IGEgcGh5LXJlc2V0IGFmdGVyIG9yaWVudGF0aW9uIGNo
YW5nZSB3aWxsIGJlIGNvbXBsZXRlZCBiZWZvcmUgdGhlDQo+ID4gaW5pdGlhbGl6YXRpb24gY29t
cGxldGUuDQo+ID4gDQo+ID4gSWYgdGhlcmUncyBubyB3YXkgZm9yIHlvdSB0byBrbm93IHdoZW4g
dGhlIHBoeSBjb21wbGV0ZSBpdHMgcmVzZXQsIHdlDQo+ID4gY2FuIGFkZCBhIHF1aXJrIGZvciB5
b3VyIHBsYXRmb3JtIHRvIGFsd2F5cyByZWluaXQgb24gcm9sZS1zd2l0Y2ggY2FsbC4NCj4gPiAN
Cj4gPiBMZXQgbWUga25vdyBpZiB0aGlzIGlzIHJlYXNvbmFibGUuDQo+IA0KPiBJJ20gaGFwcHkg
dG8gdGVzdCBwYXRjaGVzLg0KPiANCg0KU3VyZS4gSSdsbCBuZWVkIHRvIGdldCBiYWNrIG9uIHRo
aXMuDQoNCkJSLA0KVGhpbmg=

