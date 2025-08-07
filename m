Return-Path: <linux-kernel+bounces-758501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E36B1CFF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D5518C21A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC228158DA3;
	Thu,  7 Aug 2025 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DISt592J";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MvPI61KB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FZmzGr0I"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FE2E36E6;
	Thu,  7 Aug 2025 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528194; cv=fail; b=Rg2ssyHiD/+3wVdGUSEcvgH3O00EG89v1Z0FmxY67J8/lKTxzgAv45xL3MOIUOmGTwDsKKyB8C7j46FdVnRSqjzNyDw1CiDc6WSTgvCPvYofqBA4G0kX6VrWvLm7QrzILc44oJAx9RvVM6IaRf5iNT9zKZXdU2C/YiPr4I9y39w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528194; c=relaxed/simple;
	bh=8R052TluXGduxy4ORdav3h0cZ5UTiPqP95u+QEy0NVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t+05at0H0GgQEdmX7P7E2jCZZaAgC9GHVZQMz7nsGTy2nnQifBPWva2POVIqqaOjKTWFfxSD1JLkJvRRBhLlYSZZoUN5iYEm6NeG6UN+NcoegGAeUj98d2Q3FOIy0ncf++jPu9769iHUEAHYNCcKnkojhUE/oGBhsfi3t2Xm6eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DISt592J; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MvPI61KB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FZmzGr0I reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576KXAr0030670;
	Wed, 6 Aug 2025 17:56:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=8R052TluXGduxy4ORdav3h0cZ5UTiPqP95u+QEy0NVY=; b=
	DISt592J1Y4CNsEpvQkvAgTrtXqdvPXPZXz+r4qgEp9gvITLAHjCIu2eq8fW+YZy
	WEAS+oQvODbefFjCbhcvZ5sNZRNMvmrA0EKx09JXapnzPF607EnXkZCxDROL3F6x
	BaEfx0LlsbLi1NAOIMR888GwIe+G+hkd+Ip6UVG6lcZvBgKYw9Zj5JffZLVvpMrp
	hToJnKA6S+LFvnb+LYOkMkNQJaezdEsrg4m8EnTJTL+jjg9MPUKTWIJ6BetFOqZl
	W4agQcz4OEK2etauNk/71tFBXZb+2tqsIDem5vizQXRigKG1i67lWQwgyo5VIZxC
	RD5YhWO6ERbFhdOsoaeLHw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48bq0v8b70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 17:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754528164; bh=8R052TluXGduxy4ORdav3h0cZ5UTiPqP95u+QEy0NVY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MvPI61KB3Js1D4OTb1L1gwcz8c4957lCR9CPMaYeypQsS9VMCsVk9URD+sdRJtk3Y
	 J58MfW9zhkIaFtcmjkVfmhpJgp80uvd5IL8AiNwDhZoBL/jPQdfvW30zo8GsHspNlK
	 qyyZmBl0HKh6qqbzhzR66U6QiA7YjavzRxgLwgjQnBLIOo8hEUmL3gCUOggkTNLhCb
	 7+gAYFJQT9QloOSjSYOYRJblQmFGcUSNuP62GNRt+8CIYydO5s+PoUaDxrVPv8O8ys
	 I84TblXJyVB+tqT2otnd6YPFEhOkrY9ayb5tMslGFU1Usi8SD+73GHICba+HsvvGjE
	 p4kUv2MFQgAwg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 941A94034A;
	Thu,  7 Aug 2025 00:56:03 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4AE32A00F5;
	Thu,  7 Aug 2025 00:56:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FZmzGr0I;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9EBEA40533;
	Thu,  7 Aug 2025 00:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3YG+XLbSkQRoSm2ykcB4ypv0+RWYfapq9IQsYS/FhnPN8CBIIrN0yEG30lkfVtJGurDAoh0pUBwTdu4GN7KzYJ729QEbg1D0ovhlhtC3jzdJf13KYKW9m0xSHqlMvqdjCGgKvYB2c68vY7WCYOpgeNkZqtyMp5DrmhZiZo2SFmoQtp/FU/zpzCiFe/4LY9SWABx5KIZwXndsa8+W/FMnF8M6bhn8KjbnMrB25ESHYg+nzq4YWQ172PiaWLTfvrfK5HFQdsHh72/pGZESlbabQdgx/NB8kjZupYgEUVkx9OoF4ac20AQwZ5fb9tm8VkClHxoLlpxyBBS6R5JzrJlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8R052TluXGduxy4ORdav3h0cZ5UTiPqP95u+QEy0NVY=;
 b=sEd4pFhcCzEraGzgYGN2U0io/kfHiYV+5/cgZ8M4vnmGIcR+SwKDFDtCE40RJDYuJP/WuHzZIXv+hF2GeIagiiMrObPTVszMGb51xhac+7kbrzi2tEu6lIfyS3di1ccefOBpVDVx2clBp85SEwMo0MJSg7hQnObCKUvVLB09vXXbK3QKti8CX4J0Bfe8e1c/sAsq9jWCeQHKZZfEevDBIZfCz1vS0paIk0yPJKDdocCmua1LzIJv9vxW+m1mhL8WTQg1G5wn9iDLieh9VnzmDPqIJx+vn1zKPcTh8JMUdasUS8l8dC3rVT+j/M7o7Qm2J/lxcbgROGkFIHMOP7Rdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R052TluXGduxy4ORdav3h0cZ5UTiPqP95u+QEy0NVY=;
 b=FZmzGr0IZfGnj8zmD+QyoKnFPtGAu9yfctJtARbAk6n1e81eeVS1D9MhssQh2tlDejXKWCVoBe4hhJSFtiir1hyn0Vxl01IkZpubwKqIKEaWwx4z8h/pDXdX64MrUp43A9TGXbphYaNFZswUOQ0nnXKWWOEUl3JDIDe9eBL7c0Q=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 00:55:59 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 00:55:59 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@kernel.org>
Subject: Re: [PATCH] usb: dwc3: Ignore late xferNotReady event to prevent halt
 timeout
Thread-Topic: [PATCH] usb: dwc3: Ignore late xferNotReady event to prevent
 halt timeout
Thread-Index: AQHcBdL768zwXoO6m0m+jPwqD5QZsLRUtbeAgAC1XwCAAPVWAA==
Date: Thu, 7 Aug 2025 00:55:59 +0000
Message-ID: <20250807005558.72hmwuwsjknejhsb@synopsys.com>
References: <20250805063413.2934208-1-khtsai@google.com>
 <20250805232843.xka5z3edqatoyzqh@synopsys.com>
 <CAKzKK0r7StRcA=dEZSzK2=yN-HdFyKDsDV=+yzTdE0_UJboORw@mail.gmail.com>
In-Reply-To:
 <CAKzKK0r7StRcA=dEZSzK2=yN-HdFyKDsDV=+yzTdE0_UJboORw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB7007:EE_
x-ms-office365-filtering-correlation-id: 74f5be5e-424e-456a-4732-08ddd54d2c9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnAwY3oxdFZsdUZPam9HcG5Pb0NXN0t4UVZDY3FDaThveGpSMDRJeWFyRnNQ?=
 =?utf-8?B?NXdtd1ZkN1N5bkRGRDJLMWpnUlkvbEZKeVZRdDd5ZzdSb245QldCWm1zUXVP?=
 =?utf-8?B?blpvdytOYzByR3ZMV1V4cTJ0RzhJUEdZTTZOTkgyYk9TYmFSYTgzV0Nhd0k4?=
 =?utf-8?B?bDczOVQvWnZqRllGejRHQitsK0NBRldGdjlIV0llVC9jTSs1UmZJRFJHUU5F?=
 =?utf-8?B?T2NpQ0tqdXFYbHIvZG1CazhpelJmbkNZUzB4SWFaYW44OTVJWEp4T292Rzh3?=
 =?utf-8?B?cWFnQ3psMmRTTC9mamV1N2hDb0V1dEVwNzQ1R1VSWjlYRWxrL3o1WUZEOXpu?=
 =?utf-8?B?MWc1eFg4ZTJHcmlZTXBZekhNK0l1eWVTdk5pOXdFcVRDaUxMVjhXdWZBTmIz?=
 =?utf-8?B?VnMzaXdLQVYyYS9hNWgzK3RCdXN5dGdCQVNDUUhSaUwzaEpVeWlrRmM0SkZI?=
 =?utf-8?B?QTVSRGFyc0xyU0MvaWNubThnNHpOSmxtb1poUXIvSHdYemsrdHdrSy8vLzRT?=
 =?utf-8?B?S2FOZHNWa0tTMW9mODlVNXY5TCt3d2NkZFVpdnBtZnJua1N3QTJMdnh2YjF3?=
 =?utf-8?B?eFJVOWVnQ3dWd0UvOWM4TkdjeVJLbG5TcmpLbHlxYTBpOVRWeTUvTy9HNWx2?=
 =?utf-8?B?anJ2a1o4QzRkdG1jeThPSFF5Rm5zZ1AxNzBTVXNqVUVLRm9LYjRRTG83QTF2?=
 =?utf-8?B?TXJVQW9malBoWTRVcEFHQTlieUIxODZMSU1yN3REcTBoT3hNYlYxMUpaYXA4?=
 =?utf-8?B?bU9ScUZkNU1sNHNmS3d5MjYrSjhWOFF0WmhFZ01YOTRQUWlnZXY4eFc5VUpy?=
 =?utf-8?B?azIxRVFTQ3hFUHQrbmxRa09XNkptRVlpSE1QdEVSWUoxV0p3L1A3dG53QzRm?=
 =?utf-8?B?VmhPSDczMFJ5WE5UakJ0UTNTTy9HQUhyWkZpTDZNZEk5Q3JkUXpQcUZIdHF0?=
 =?utf-8?B?QklQQWdJTTRUM3pZSkVzeDBOSnRoOWlOS1EyWmU5U1V4SWs1emRuUG5DYWdX?=
 =?utf-8?B?TTltUnNDQTV2WjRTVE1CUTUwakd6VXpCV1k0ejdFTUo1WGE4blE4OTFjdThk?=
 =?utf-8?B?QzQyRUEwL1FWUlBzZUl5WCtTelg4SHJPQkJWaTRxZ01XdlVlcjBuVjdGQWND?=
 =?utf-8?B?SExYeWFqN0I5R2xGVmNhV0JiSm96dFJWRUdSZVMrYkU3T2RBK05VVlB1WjR2?=
 =?utf-8?B?aFoyTm5uZHo2Zm54S0tNa3RiYTBBKzlHc0RJT1pYSVdWTWlST0tBd2FZS1FL?=
 =?utf-8?B?TUY4OSs1V1dXUStWcjVud0dxSVVodS8rcEp6blgvYVR0SGwvRTYxbXpmWHdK?=
 =?utf-8?B?Q0RORW1jMlJNekZ1ZENMcVhYU01rV0lZeUpwYUVwUElnbVJwTmdEcm5MdFR6?=
 =?utf-8?B?VUYzR0JpMUwxNWd3dWF0bjBZcy83R0c0cUN4czlncXpLbVpGSjZTVTFQQk5m?=
 =?utf-8?B?K1RITkJtdFpUZGg4QURUZncwZzRxOTJlS040c0R1SlhIT2dEL1dTcFh0Sksr?=
 =?utf-8?B?S0NPZmlrTnJNc1ZvVTY4MlVGWGpXcW5ZQ3crK2lqSytwMjBlTnFMQnI1TTl2?=
 =?utf-8?B?Snk0MFByaklFK3pPV2JvaVJWRE1aUFlUYXVoUXA3WDV4NkF1NnRsV25jZlJW?=
 =?utf-8?B?b2VRbWhIWW5xdFR4aWp2RVkwOUtpdUhoSllPeDhvMDBBcmZFd0toN2tVcThk?=
 =?utf-8?B?Vnpha25OOXVtd0diMUFKNGtMbGFCK0UwZ25kK3Y3L3ZjOWhBYWtYajNGN1Ro?=
 =?utf-8?B?akw4UlZkOUNpVUhKSDUvMUtSZFpsSzNGZERpZ1hMNDREQllxUkxnTnUzNGc1?=
 =?utf-8?B?cnZhZTBCbnh3MkZjSDN4UDBYSHdteko3Z0Z6ZlhzeHFrTDQwQUY2VUJPcUpY?=
 =?utf-8?B?eFV3aTBBNEFZOVZUYk02c29VQi9ZS1JmUEN0WUs2NkJaK2NzNWdZVi9XL3hk?=
 =?utf-8?B?R0hBSWtyZ1ZET1lpejZCZGVWQVl6cFB5Tjl4UGthRnlrWVJNN1Ftb2pRRzkr?=
 =?utf-8?Q?QiL8urt+gA7tCXRXpK/gIogis70Nig=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGt3dDErSzlZMGJNMXdCKzZzSVJHVE83dFlnb0FaMVJZTzQ4akdseDBmNnA4?=
 =?utf-8?B?d1hyb1Y4QlUwby9wSmVvWk44SkdVbE5scnJsSTdpdmh3dGpzZmJ4SnlmQ3Iw?=
 =?utf-8?B?UVpzMHZ3VXl6Wk8yK0JJL2plY2NRVFg3T0Q2dFd3eFQxK0RzUTZDamRWSnZD?=
 =?utf-8?B?QVFQVjdPM1pPY3BRWHFhNUlVajNzUW9sMUQ3Q0JrNkxFWnlNYkhkTzNVRWF0?=
 =?utf-8?B?ejhSYktxck1pc0tTY0x5STVEY0pEMXdjaEhiRXh3SEF2ek5lRDJIM05NNjVr?=
 =?utf-8?B?Y2pLbHYxNVlveTJXSHBTcGN4RXo4WHJTK0NjeXJmZWg4N2c0SjdFTU9VMm1S?=
 =?utf-8?B?UmV4WDNRck5TOU02c1hWWEFCSjRQSHNlZllGZ0RtaUVuTjc0V1o2ell5bWgr?=
 =?utf-8?B?R21VV1QwdjNJVXArWjUvTSt2Y0l5T0x0a0U0ZTFXNS9iUlN6RGEvS3FxdlNZ?=
 =?utf-8?B?dXM5WWxTTi9XQ2MvV0xOcm5xNzNTZng4T3I5Q25nMEZ3NWZNa0Q1cFpiNzBT?=
 =?utf-8?B?Mkdzc3BRMGZ1MXpoY3hpcG45Tng3Y0llbkt2VS9CeWx3bEZXWERtbVBFbmVr?=
 =?utf-8?B?ZWt4WGN6dzEzcmwzdXpHczdIYXM3dDNaTkE5MGhpZnVwL243VlFLNnpDc1g2?=
 =?utf-8?B?UlE2WFB6WnljendqbHJmRzkreTZjT2g4VlE5UitmbEhxbGZjUWhPV2dwelVv?=
 =?utf-8?B?R0NJSkRCK2hwcm5vQ0ZwZFhtNjJpa0gxck1IUXVVVzdMR0FORU1vZGVrQkIw?=
 =?utf-8?B?bTV5THVyTG9BeHg0MnZKU0JnR1d1K3N5ak9KMU82Yi96SFI1SGlWWm9UZnV3?=
 =?utf-8?B?eE1IQjJONis5cVBSNXg2VXArV1gxckVzdy9zQnVQRmU5bHFhdHJVQnEvREhD?=
 =?utf-8?B?SHdPM1RZR2phQ3djdmRINTM2ZFJlY1kwMWJWU2FEOHBhOTJRZ3dQc2p4YTBL?=
 =?utf-8?B?aSttSWJ2SWVMTFZVU1dFUmZ1bDFpOXBza3VTcGpFcnYzT2FrLzh6QWZ2aWxs?=
 =?utf-8?B?Nm5Zalk3cEp1aDZJVmR3RnBiUHdNRzlObTFWT3hKa0pLQTJNU1RrOGVPdUNw?=
 =?utf-8?B?Qm5QcUpWR1Y5a1hJUmpZVm9TdFdTZTFRR0N3aTYwdzE5ZzNvLzROVzdSZzc3?=
 =?utf-8?B?YmZHNEVWbGFyNWVCYTc0Q001alNlVEljbnRFNXQwMnIzNjY4MnBBK0NTNnQx?=
 =?utf-8?B?Y1dubWI2SWpJU2ZUekRhNnh0aUR5MndtcW1iaVBhNDhSa2NCancwTkFHdlhz?=
 =?utf-8?B?dFRGaVVWdlR4aEpMMExLMjZBWElCaUZlc1Zmemptdnc0QnZFeDgvWGlhczVn?=
 =?utf-8?B?Ty9LaUN6YVFyazFaRmE0NFlXN2dHbnBKdHQ4U2ZBOE4yelBRWW02OWJUNytm?=
 =?utf-8?B?ZzF4WXNrVEdIeFVTa05vRHhjOElwTGwrc3lheVJlU01wS29WbVhiUFcwY0p2?=
 =?utf-8?B?QjRmNjRzbDlNbXFVNDVjRjBHTjhqWGNucDB4T0FKc1dhY04rMVA0UE05V0lP?=
 =?utf-8?B?ejBVUFRJSy9ManpNYnBRQlpPd1JWbklNZTMrV3I0bGdYSytUNitSVlZEVUJq?=
 =?utf-8?B?a2lYY2ZPOEIzdjkvY2NWVG5WWER6SEp0NUk0cUo4ZWpSTGlpYi8zZTZnekxM?=
 =?utf-8?B?aXgwY2lDaGViaXIySm9NcVREY2ZHekpESnUvZnhSejRaQk1xdW9LZ0g5QXJG?=
 =?utf-8?B?elVPTXBQV3FzbUVseGwzQmpNMDAzNmNid3ZtVUtZeDBEdWV2SWwvWWJQa1pP?=
 =?utf-8?B?U2owa2lQWElyMGtRM01jQzgzOEtjS0pJUk1DNzVvU09zQnZTUlVTOVU2VEo3?=
 =?utf-8?B?dEdUbEVLRW1lWks0c3p1TkVkQ3BVNmQ4d3pEMjdwbG9nTkp2M3BneHRNMWY1?=
 =?utf-8?B?dFNDMWpWWnJkUjhxZm9CRzVqRnZXazNiaTY2R0RRYVZYamkyTTFranQyY21S?=
 =?utf-8?B?R08yTUlsR3duRFlHNEVOT2hCeHJEVWdhakRPako0Z1g5aTNsdnRzV0xsVmpR?=
 =?utf-8?B?NGlNc1lVVEZPRmxPdWhOYnU2VGdXMmVNKzliM0llaFJBVnpMVDZKRzhUeWE3?=
 =?utf-8?B?U2xUZXJGN0I3eG51dW9TemJPNVdZR1h4RUwybmtEWWxMQTlPQjloMTVvK00w?=
 =?utf-8?Q?PUr8YG9b2KJ91VZ6GtR2bxF/H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F74ADD256FD94D4686C00BFB28311D7A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u5PcsUnAsiH39jUS+JsCtw+ZZuZ6odhEMQN/s8s0NtUFM2nWAmCik+ORjfaTFtmUP8QrJyMaoxYfuNg8HKuKXZnkxcQjgCNscTexgzboc9uFjAuvK1VDRjDYansg8+9v5+9czFhH2y1Ws1Q0Hd9/u9qLBLNmxxCJDe0+gBGYPGfRK5tO+4kZpDChSc2fZeQMnDUU4DqCXepP8ifdNtyv179s18R8cl11USTv8vYrlKJzWBMwtAYw+ld7+1q8XSq3GQ35POD0u6zRqn4ELjQuh9+dY2HnjxgFjOSa2WR2JBdLPq34H9aR1iaFOT2GFxEylR759L5fsrJzGQ5JJoB/36JNw8CaQ2daHMayAsmsqez4GW7zHXeMxXCQ+eEoGnG/cAxhmLjTRXRSh3UDatRUuW56EnLwFI2pk7sesVP2tGXjfBNv3q7ZxaNZdD8dVOuSqf30B7vCC8Y4352+bNNoJubrn7tiW/QNfNR1pnHuegidCpjYUicuj5ZQwmjhyGnMrZPaGcUXsjNMbwQTrLdJ03BUnxec4Zm8fAABUiEp78eM31ZwNvgP4jCdb7ozslOVed4AFxZjjca+mHZFEJpB9moi13lgQnHhLoWMFDB4inrD61qzWWhTR5FvyJLp8MKAVk0tO4uxMPMJXCB7TdG2Mw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f5be5e-424e-456a-4732-08ddd54d2c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 00:55:59.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqsINe9ZcQOq6cEvkTEEI1Mmz1dkxoOrEuWzcd+ZXctvIm8aevH+E04sL3EvPlhtTYI+4B4uimKqj/xhiUD17g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
X-Proofpoint-GUID: Pdr2KgpJ7OHO3I2fpVdLmG-6gWM1FzQp
X-Authority-Analysis: v=2.4 cv=QJ1oRhLL c=1 sm=1 tr=0 ts=6893f9a5 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=jIQo8A4GAAAA:8 a=8tCWahwWGO0d2bI00RgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Pdr2KgpJ7OHO3I2fpVdLmG-6gWM1FzQp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyOCBTYWx0ZWRfXweYW2exSSaFq
 OdKcQTYlaoFFKfBrqC7FIsDD47z8qenEBzt/SXlB+GabMmyJbjgPUPuUXDHhyo9AL3wZtB9q3eL
 xg7WYVVeJwFiG/WRg2Kg1lo/JQocNlCTOueUd3/PPEcxhji/GANiRynH8Uu1KtV7e+ve4i8L0Kt
 wbi1+rIFXU/DGumbmbt06IvMCX9cRAaegBX2dhDIRx4v3IFbEQiQ1pRKmsg4UTdRV4K3Thi2TPg
 W0wJ+bAGLTyjFnTVkg+z84oaQ0cbApKXUe2Yh6LWrWcT1PEgmdrz33QMqSk1u+dSpioCDFzhfNo
 3IJ6yRbzoXflgh80DkrE6h0/91xLt2jU0wKpq4RCf3OnQy12ueljy4X9p1Rc/RcMndKdDRQNC63
 EowWAY5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508050128

T24gV2VkLCBBdWcgMDYsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IEhpIFRoaW5oLA0K
PiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4NCj4gDQo+IE9uIFdlZCwgQXVnIDYsIDIw
MjUgYXQgNzoyOOKAr0FNIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIEF1ZyAwNSwgMjAyNSwgS3Vlbi1IYW4gVHNhaSB3cm90
ZToNCj4gPiA+IER1cmluZyBhIGRldmljZS1pbml0aWF0ZWQgZGlzY29ubmVjdCwgdGhlIEVuZCBU
cmFuc2ZlciBjb21tYW5kIHJlc2V0cw0KPiA+ID4gdGhlIGV2ZW50IGZpbHRlciwgYWxsb3dpbmcg
YSBuZXcgeGZlck5vdFJlYWR5IGV2ZW50IHRvIGJlIGdlbmVyYXRlZA0KPiA+ID4gYmVmb3JlIHRo
ZSBjb250cm9sbGVyIGlzIGZ1bGx5IGhhbHRlZC4gUHJvY2Vzc2luZyB0aGlzIGxhdGUgZXZlbnQN
Cj4gPiA+IGluY29ycmVjdGx5IHRyaWdnZXJzIGEgU3RhcnQgVHJhbnNmZXIsIHdoaWNoIHByZXZl
bnRzIHRoZSBjb250cm9sbGVyDQo+ID4gPiBmcm9tIGhhbHRpbmcgYW5kIHJlc3VsdHMgaW4gYSBE
U1RTLkRFVkNUTEhMVCBiaXQgcG9sbGluZyB0aW1lb3V0Lg0KPiA+ID4NCj4gPiA+IElnbm9yZSB0
aGUgbGF0ZSB4ZmVyTm90UmVhZHkgZXZlbnQgaWYgdGhlIGNvbnRyb2xsZXIgaXMgYWxyZWFkeSBp
biBhDQo+ID4gPiBkaXNjb25uZWN0ZWQgc3RhdGUuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDhmNjA4
ZThhYjYyOCAoInVzYjogZHdjMzogZ2FkZ2V0OiByZW1vdmUgdW5uZWNlc3NhcnkgJ2R3YycgcGFy
YW1ldGVyIikNCj4gPg0KPiA+IFRoZSBGaXhlcyBzaG91bGQgdGFyZ2V0IHNpbmNlIHRoZSBiZWdp
bm5pbmcgb2YgdGhlIGRyaXZlcjoNCj4gPiA3MjI0NmRhNDBmMzcgKCJ1c2I6IEludHJvZHVjZSBE
ZXNpZ25XYXJlIFVTQjMgRFJEIERyaXZlciIpDQo+IA0KPiBDb21taXQgNzIyNDZkYTQwZjM3IGRv
ZXNuJ3QgaGF2ZSB0aGUgZHdjLT5jb25uZWN0ZWQgbWVtYmVyLiBTaG91bGQgd2UNCj4gY2hhbmdl
IHRoZSBGaXhlcyB0YWcgdG8gZjA5ZGRjZmNiOGM1ICgidXNiOiBkd2MzOiBnYWRnZXQ6IFByZXZl
bnQgRVANCj4gcXVldWluZyB3aGlsZSBzdG9wcGluZyB0cmFuc2ZlcnMiKT8NCj4gVGhhdCdzIHRo
ZSBjb21taXQgd2hlcmUgdGhlICJkd2MtPmNvbm5lY3RlZCA9IGZhbHNlIiBsb2dpYyB3YXMgbW92
ZWQgYmVmb3JlDQo+IHN0b3BwaW5nIGFjdGl2ZSB0cmFuc2ZlcnMgd2l0aGluIHRoZSBwdWxsdXAg
ZnVuY3Rpb24uDQo+IA0KDQpUaGUgRml4ZXMgdGFnIHNob3VsZCBwb2ludCB0byB3aGVyZSB0aGUg
aXNzdWUgZmlyc3QgaW50cm9kdWNlZCB0aGF0IHRoaXMNCnBhdGNoIGZpeGVzLCBub3QgbmVjZXNz
YXJpbHkgd2hlcmUgaXQgY2FuIGJlIGJhY2twb3J0ZWQgdG8uIFlvdSBjYW4gZ2l2ZQ0KaGludHMg
dG8gaG93IGZhciBiYWNrIHlvdSB3YW50IHRoZSBmaXggdG8gYmUgYmFja3BvcnRlZCwgYnV0IG1h
eSBub3QNCmhhdmUgdG8uDQoNClRoYW5rcywNClRoaW5o

