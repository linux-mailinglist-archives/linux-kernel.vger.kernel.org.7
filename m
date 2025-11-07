Return-Path: <linux-kernel+bounces-889595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56090C3DFFC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1917346B87
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948F2E2DFB;
	Fri,  7 Nov 2025 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y5HrGNyJ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="akqUW51i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E53+LaWX"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306E1F461A;
	Fri,  7 Nov 2025 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476153; cv=fail; b=S209T9BJk22lz7TGxHkXbKZC0CfhOvpiXkh8/91snoWdsi3qScT4OsItCeBk+hxcmwhoK/L7iPsEXJFMQtSHCZMtUbWsIVKJz8GLd8CPGygy6FuJMDbdxp+OLz9F++E9PyhpP5yjgS33ETmoOlvEFu8etlRRhpQTe8ZSTwHYUo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476153; c=relaxed/simple;
	bh=tnb7Btrv4OpjHhLaLoWCtf4IeJY3AIQsvgEh7Z4j3Rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1bj6MOGq+2brmcUUzDadtCELprjt9tf43eKhXI0bLBcVYjLONFmi+rz9Z3rB8ZsBNhE7dtMHKnZtL5xUmZIbQ20SswrO1NiUpaftZJFSQSFX7lmOxS2THQu5YMG3O500EaaHqsOzHYTwGQnMF3jHwFQgCGyg1Dg/HMGc6eYjVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Y5HrGNyJ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=akqUW51i; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=E53+LaWX reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6N0n5v3820604;
	Thu, 6 Nov 2025 16:41:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=tnb7Btrv4OpjHhLaLoWCtf4IeJY3AIQsvgEh7Z4j3Rc=; b=
	Y5HrGNyJANbQtORrwxtYo7l1hZyqk2hwE6X33rFBYs+QgnhT846VqfWFMctzCODl
	CD0NX+VcDBT5g8KSxkXd4osSCGrxnCza0LbrZz2IiGopDyF50aU09fsLvBUX3xu2
	uMdTu6IdyzTEOaRw2esfV+0PIEDLIIzuyfo7bF7wHNciwGPwENXuSvFsrCDUXDex
	tduXhLvldvx/EgTTatT0uRr4xvjgxRVrXdweXYUrvgALgMUW1u5Dj2eOkb7ujJfX
	lgBKgXdGnj7EM1R69fc8ZWwdaTmc81XCeiLe3MoUAuVJukWgTcsy4s6cjP+hrGpO
	/rJzRllYvCOWUXXNsuYUdQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4a8x2utfrn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1762476108; bh=tnb7Btrv4OpjHhLaLoWCtf4IeJY3AIQsvgEh7Z4j3Rc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=akqUW51iuHaI97WvIHLNg3XLPP1yzFYRIaAfHC+I94X8Cvcxr9SOXmI1RZQxQwOrz
	 wndllu/QoboJf8eFoF7iJ9oK48yKRt/7crkl2eU1q5xs0IjcYwJmRXSKotowrDMA4D
	 YykeG0Dk1zKMfUwcJlLxM3Qiyc5/yE+7YUi9P7VQ8xN4lr6d5WRw3FpClJVzhgmybT
	 ms6u3dITLjm6lwNyssDUF6m7d7wOb8yy6AOiX+LxEVS3y82Tfw9jEwrmSdksoF2Wji
	 ueQWOpYDyHSJdHQkcKdIrasxIxOzi+dxue2+qYmMyYP+P7i+Pl9Wu7a/62wMdoC2PS
	 GI+X8HqKqRj1Q==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CC9FB40340;
	Fri,  7 Nov 2025 00:41:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7FE81A006B;
	Fri,  7 Nov 2025 00:41:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=E53+LaWX;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00102.outbound.protection.outlook.com [40.93.14.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 89F87220151;
	Fri,  7 Nov 2025 00:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffTlJa06T1/Ezykp5MWrtuadTtHzZ9pQgd5Bcn0X8BKkT/gYiihI1w2wQ5u/9GuYLxGh4IIl/n+XCRMRs/TsZoP0/mDHHT5DgZ/BR9bLabsigYFJuESq7elptWJCp7pxBWveljaugShTgJYjWNexKJsDI5cIv/tQzmxQ82GjmFiKFfSqKt1YK49Okx1o0+rQXgRzUZY0Q9wOeURaC97jfP3lwR9KZ/3j/UmdL95/1+gv+A85ZFoh4KIXqVrY9pHcljgyrbjroSyiVupyN5vR6RgGzwb5BMRiGdfedgAEEiVD3OjhjRs6NiJmStsV/Gj+Lx5s6woQAMo3et3RdvqAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnb7Btrv4OpjHhLaLoWCtf4IeJY3AIQsvgEh7Z4j3Rc=;
 b=JgMJWxF04nVKsY9qHXj8o1Xf2HzEWDNxS0t4eVCAHBQ/WTunAN5u+I6fHCeJBXqJUlACTgvnxQ9UUqBcDnHCzO148Fv+arTnNf58SDSq+6mmJqyGpEsPvKXqyFH4hLQmoIJYhO90w22EkIdHvXyhoBofDNRBeqTUs7Nu+T32zz1FwH45TxYglvwSnQqkdL2UXL2gUTZjbwbkgO9BP/BJAb8RDWHszKpteXH+SYaykrWLb6RV/3n/ubIfZWErVYKW2DLYOp8VWgLjNaS3sODqHHmbClAHmNROk5l/l+UoFe++IwqHW0apiQ5ctIy0wBo5gT+F9Hwht8gxQyCtkC1NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnb7Btrv4OpjHhLaLoWCtf4IeJY3AIQsvgEh7Z4j3Rc=;
 b=E53+LaWXrJG60dH07DRb4/ravWX7b+50BJ8feDANUAPoDSMqI0vyiYpKtYAV6X6E1og7N/WnDJfINQQO8EvPUVdCzrRYL6XfIbnUUho5CJ+WKI5rfGfWngBENapkvj4kOecODWdlGb4SI1acijES9ATN80J8s0q8wnT9yygAnTg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 00:41:36 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 00:41:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Marco Crivellari <marco.crivellari@suse.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: dwc3: replace use of system_wq with system_percpu_wq
Thread-Topic: [PATCH] usb: dwc3: replace use of system_wq with
 system_percpu_wq
Thread-Index: AQHcTzHiXML5vHtjG0iBWT/hjvz/krTmYB0A
Date: Fri, 7 Nov 2025 00:41:36 +0000
Message-ID: <20251107004128.amtrbvb3gtpe7gc7@synopsys.com>
References: <20251106152712.279042-1-marco.crivellari@suse.com>
In-Reply-To: <20251106152712.279042-1-marco.crivellari@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB6763:EE_
x-ms-office365-filtering-correlation-id: 338644b3-3cec-4c26-727a-08de1d96686b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTVDTGU2N3AzSEphaTg0d1lMcEtFQkhSVUVNL1IrbWgyTTVlTy9ZeW0wcC9Y?=
 =?utf-8?B?eGFHcGJ5UUc0VGtyUlRBODVGOUNpeEFHOXRrV0k3QUNZVldiNlhPV2t0L0pG?=
 =?utf-8?B?YTZ4dVBkdVhZUU5aSlpQZ0lzYjRwM0tnSXFxbGo4QmlnOVNHd0ZxbEZOcEFF?=
 =?utf-8?B?bmpxYWwrSkZ3MGNYUzRNMmNzc1pnTG81SVYwVDFicVN6MEdaQzEzYTFiTUhl?=
 =?utf-8?B?ZUIwRW1OM0N4OWZLZGdZZXVDUmNIaFRDbWFya3oyZTZDVC9CKzRJMkV5ckVK?=
 =?utf-8?B?aUp2V0lqOU1YVy9RVW1EVWQrY1RGN2hLNE9HYld0RjJDQ3V4ZU94cmllRk1G?=
 =?utf-8?B?YTNoQVk4MTFUY0ZoR09lUWJyWE81ZGI1VlBWN05iWDlDNVRaRmNncEFoWFJ5?=
 =?utf-8?B?ZWNKbS9VL3ZoME1lQjVDV2xyMHdNMHdlNnFMZGNYZVdCbWdaRnFnc2UyS21Y?=
 =?utf-8?B?aFl1em5FQXhhWWEwNTlwYS9YOFhuUWlodVN4TXlEM0k0V0tEQTVldmxwL09V?=
 =?utf-8?B?emorTStsV004VVV5RWR2M3AwTU92T29GeDFRbklPUUhEczZEL1hIL053ckQw?=
 =?utf-8?B?WTA0VmRPeUlaVTh1TEJlNGx4ZndyYXpaM1RmRU1TTUt3QlJWWVgzVTRjRjhP?=
 =?utf-8?B?MG5BdGdYdDR6RVdBUVNwL05FWkEwMXRKTExGeEpNTng5azJMOXJKbEY0K1da?=
 =?utf-8?B?SWJtL2xTRWtkcE1lZXJOTkEzWTYyYXo3dUNEU3JmSWpjT0tBQ0owUmMrMGtY?=
 =?utf-8?B?Z3NpWDVFSkc4b3U4a2pLWkhoc1UwdkpHN0ZweE9pWm9aOVV6aWVMV2Q3RFpw?=
 =?utf-8?B?Wm9pZ3JvOHVoRzhRNlpkYWF1VjAvWlQxblMxNCtuWmgzRTZ6bUo5SzQyTE42?=
 =?utf-8?B?b2pxMHViK2poWklQaGorWWRyUFpWYm9EN1NkRUVxdnVLMjl6bmFTUWVRQ3E0?=
 =?utf-8?B?OXk2SmIzb2dIbnpabHZPSmtnM2YrOG9CVlUvMXBwMjYrU0QvOUt5ZDY4VzB4?=
 =?utf-8?B?VUlFNEowc3ZOSjJhYTF3YmdCVHQwZlhCek9pS0tuZFNtcGZXYVFjblBtQlpQ?=
 =?utf-8?B?NFJiUjBQRDRudEdXS0gwRzhXUFVnNnNTZzVWL043aDBlRUVOS1IrQ2M0LzhQ?=
 =?utf-8?B?NG13M1B6emJQL0Q2bC83YmVuYzkydHpncnB3aE1SSzZhT2JvZ0d3WVpOeGsw?=
 =?utf-8?B?NG8wOVpMU3FxRG9zYTc3anpDUUNxdXROYXZZWTdqeGc0akJXYUYycDVlbzVo?=
 =?utf-8?B?eWdUVmJVMVhDSDhJL0h2T0dKaHJIUjdGNGEvVUFuYVZ0RUhFelVOKzRDSDB6?=
 =?utf-8?B?alN0VkNOVWZKM29JdE5wcWhvQzl0MU5sczdtc3pQalBtNktoZFFnVjRaRkV6?=
 =?utf-8?B?KzJRY1Z6NDExMlM1RTFucTYzY2N6K0hGYUY2TjNOanVvRG5wWTlFVEpSTXBJ?=
 =?utf-8?B?dDdkWkxGeUpMMFMxVnZyeGF4b01FQjdNS1Z4clcvVjd6MTlkQVVFV1E3ZGJl?=
 =?utf-8?B?c0JJQ25TZ0NKME9aNEREYXIrUTRVMXlOZExmbmxuRTVXTnhza1pXWUpIdGh6?=
 =?utf-8?B?anZrMW4vWWNIdGYrck94YzZXc3NpOXlSSUUrUGIyMkdZNUZVS0xBdzJCaHJ2?=
 =?utf-8?B?WC9weXJ1aWZtVFFJeUdITzBkRHFEVnIrUFZMbzd2WHVOeE1KQ1VjMXRRVTIx?=
 =?utf-8?B?R2pERFdQN2FxZzlhVGhUYW1NdVRXZzZNd1doanltT3c2UXFWRE8yYk16NVZE?=
 =?utf-8?B?YStKQitXalcxekRPblBHSTJVWnM5d0dWQ3FEYWp3am01M3RlYWxuSy83OHI4?=
 =?utf-8?B?aHBzUTRZejRzZ05sem1lN3VINnNsUUVsRzZJeWFLZlI1Z3pnZlUyNGZUUFlx?=
 =?utf-8?B?NkgyKytNZkFqSi9OeXNNNDhVN2d3TDk5cjg1THh2TmcwYTFrMUYxLy9MVGx3?=
 =?utf-8?B?VjVnVHNabzRPdk9xNXFhRkZBcnhKaUZNSEhXN2l6NzhBWlZZMUhJVVViUENl?=
 =?utf-8?B?b1lqVDgwdmFRYWprVUVQWnI1TGFvV3hRd1lndmQ3bk5LeDMrSUMwNWpKaEFR?=
 =?utf-8?Q?OMtUyG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzJjUkNMN29YY2swZHF5QmViQWhEaDljNnJiYWRGVnlyMlVmVGg2dTVHanpq?=
 =?utf-8?B?ZDhkaVRxNEhxcmFCMXBLcGJGSTZEcVg5SDB0a3daZVpyMWErVTdFblljbmhJ?=
 =?utf-8?B?TUhhclJQRTVUSVpPamE1U0lJTzNwMGZnS0NXLzUxNmNCK2VQR29MLy8yclNM?=
 =?utf-8?B?eCsrVUhuNkJEMWpaMmc3c2tHbmlyQmRZUVdLaVBxTlVSS1BRNERhM3kxdjgy?=
 =?utf-8?B?bFpXb3FQUExEVENpSTd0RGVkRFo4MzhVbjBMTHFSNTFTVC9PWGtCVTRmb25q?=
 =?utf-8?B?cDluaXBvZU0vaCtDY1pPT1J2ZFp0TUVhaEpOWEttWEZGeDd5eFZKT0V1bG5D?=
 =?utf-8?B?YjIrTVQxaEZaWmxIZVJnWnB5UG0ybzltMUVtSUxWUnJIdVczWHpWdU1VS2RO?=
 =?utf-8?B?R2JFV3d0WGRCdU4zbFVraEZMQTBQcmJkSHRZU1V0WklDQWRWNHp0UDZ3aHdH?=
 =?utf-8?B?VXlXa1p6eVZUTTJyWHJJWXdCLzNWQmdYNE9FczU3eWl1Y1plUTJRSkRzcHB3?=
 =?utf-8?B?cU1ZekpmMFdjbjN4V2hTMDZvT2pKbExDaWhIZEt6d0NYOCt1a1BIMDYvR2pD?=
 =?utf-8?B?bkNyT1o0dEZTaktMMnl6M0pMd2NQdjZpMklUbGhOV2p5a2V5K0tFSlZ3c1Y2?=
 =?utf-8?B?akpvaE15dnRZL29aUVpLVUhSdXFKVjk1NkpNc1ZCeVlTNjh5QXlhQ3BVUSsw?=
 =?utf-8?B?bG1JUnF6bDVsMTduQ1QvUE9rMkFZVFZ4ZVVUV29ya2l4VDhjY3BMN0xHQVZO?=
 =?utf-8?B?NmF5cWZCWmdqUVJOTTRXdmRyc0MzbG9zV015UmtlTVpaVkZHL3R3VUEwbkxj?=
 =?utf-8?B?WlFUR3VXdFQrVFdRbkRVRnE4ZXUwZmMxK1R3SGw4WW9BWHQzb1pDSE9pMUhp?=
 =?utf-8?B?SGZRSWZwYkYzbks5QmdHRzdVYVhOU052SDVidUdTMjEyTEhSUVJrY2RVZWRO?=
 =?utf-8?B?NndBUVdKeWNkMGZySENYRnlIbTcwcHpLVVhpYVdVY2RlVXErOThVMFNuQ0RS?=
 =?utf-8?B?SGI5VlVuOFhGeEFqaDFZaGpVV0k2UDR4RUloL2JkaTQybitXVENYRGRrSktF?=
 =?utf-8?B?d0RlZ2p0Q1QrU2YzM05mRGFXcEphUVJCM3RlR29lNGFkSG5VRzltVXVCQzNu?=
 =?utf-8?B?WUphMGVWMEZjbGpRcXZNSDZ5R0dTLzYrYWZ1K1QyeU0vTXBtUlY5NS84Qnc0?=
 =?utf-8?B?YUhMRTkzNVBPeFJuTTJySi9WTjZmenFNUkM5eit6NUU5NzlkQ01BdVA5K1hi?=
 =?utf-8?B?cFlBQlF5SFdkWWFsYnhjT00wNVRNSzEvVGhWbjNKSHo4Q3RZRzRqcjJaQXZ4?=
 =?utf-8?B?TmNWQmVDL3NSc0xPa3BvVzVzQXI2Nk0zZStCdlpFeDQxclJMRUluSVhDdjVy?=
 =?utf-8?B?aGFSSEZJZUdINGgwSnFpNWRML2Z1MmZHK0c2TGtSRzZXYVRJdXBldUFoRFlj?=
 =?utf-8?B?NzNLMWxlSE9WOEpUaGdEbk01QXFJcjRHb3k3ZWJQcW1TZ0JIQjhUemRpZUZN?=
 =?utf-8?B?ODVrUGtQY1lrSGhuL09yZzJ3clFYczN2UHBkbWRtRVF3MU5QK0lpNmFuN2tL?=
 =?utf-8?B?Qk9Ma2NOYnRNSy8vWmMvRkdmSCt4QUxMbUJ6aENreEFweWxBd2VMMHA3elVl?=
 =?utf-8?B?RDFraEUxVDRpdGFPMFF3SlIydjIrOTFUZmN3YVpua2F0cmNrclIwcEVXNjlr?=
 =?utf-8?B?QjBmR0g4TlRMUEVmRVdaUzRmSHlna1ZsSW80Unh2emdGQ2dGMmJndUNEZ3BY?=
 =?utf-8?B?bTFFTXczcFRqeXhVMVl4RmJGMXdpOTI2MWF6Z1ZSK0hVclpmNzdZNnlvNE1s?=
 =?utf-8?B?RWlkbnA3WEp4Zmg3Y1BYUXF1Q1lJcXVtbS9HWkc5emlFMCtsUnZyWnluVEZU?=
 =?utf-8?B?Wis3cDVPWG9SUnI1amxmZ25NTlV5QU95SHk5eThRMWRZOXJkTUJ2TG16TjB3?=
 =?utf-8?B?MmtXZjZpWmdya2ZVczRoVlJKS3Y3L3hMVi9oZFJsOTZvQXdRL0lVamQ4cW5S?=
 =?utf-8?B?SFcxRU1pSVlPWTBQVnhieGdiSTdUdml4VXJxdERBbFJZUjJ0QzNSUWZ4dWVH?=
 =?utf-8?B?TTFzYWpaamVRclJ2UHFFeGNDTmFnMnV4Q2dkYUJ1bXM5NzJvbW5tTi92Y3Ur?=
 =?utf-8?Q?L8IDKRsuowgJUM9wHGr8iLkpe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6A1D3F7C8762A43A21A58DA23767601@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	21KylbWf7N6S/J7JAbBxg8mv3gQiRKSOO6G1IUK7rpCsc8IWU2mWUKhiV/HgsqRX7TeIWrNcK9uDs6dwD0BQauLZsOWbFbUEHKspvGgeOp5Ja6bfrDinpjyqo0jOhYbmxTk2BKgRFmFvG02FW3ZRJy2Ba0S2syWFwkOgW8Kqv3m6d0+/ZVM8FPICiThS0fW6qmE74sQ6fiQJq3l7EKnyHTA+767LtTyUz1hpFgWlKt+OzfYzz4GWd5jr/Vq/p+IwYl7DsmzY7IzArEPpLX2/CxNnVqYaOXmg4geYGhN7QLvkFdRjx8LJdYes37CXi/tYU3e1Ev56k4mpW2k1yRjOO8CQJU6JnXgnpGYMVAlSOdfmz0XVmCdYCe+m5UrEk/5ggDhtEpipw4ue9YNW+2xM6Pc/nOLwUVFAlUjT5jQXH6MPH+d63UljL0juPn+iqVqCo3AI1l41fN7zA6XY05Ugr+V1BILXRdqVFzoLSo/IPPP9wMl+hqxfEvNBw8yqWhho1VuM4EpPwfWKh3HlbEDzsKMN+JNpU+CfZBqQucBkftFe260tsYMBV+YjsVyGtivqT0sGU+y4yhgMgI82KR8lUE4CzraLLWYaVVC9tvQ1WsMGMnnzc6IX0u1nwUCbl0cpqOwQeEvYKKdmY9/GL4NXgA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338644b3-3cec-4c26-727a-08de1d96686b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 00:41:36.7060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QHNhvJr5yxo6pVLK2kHHwKsIAJTgx1zMOxxuFqt0u5XRoNR1+eDQDWuu85IPVtRbLYTtYGohBm8OerYYabLFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
X-Proofpoint-ORIG-GUID: KNSoVp9k2JqyILA9EV5pI5fyDkJbb__P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAwMyBTYWx0ZWRfX99CFt93yVR6I
 2TFuK6fZ7AYmaYEn5g2Bab1vXcE2YV9/m8IHQTAQnRksABjiKDmnc3fwRLdAMbrQJxUGO4PztxD
 YTuMCPLmZDaciodP7RocTJ1wil+ChhVeD05TksprlU8A+4NT85QgIoLHeTSIdl3QuDa2v3M0Ei5
 XUzsdhiDSCTFbs0LSGiufCSWunKkIrKU7RALWgG55eVJHKNVNaAp1PSNCq6iZZqt7Cwd8w80OOj
 7HzcP+5h0kto/XZaUpBRcHWZKJYZk4KjdDBrCfU6YCWZNowfV5+syd6mr8N9uN8aiPQb1yUQETq
 yY0bRPwmJCRB98bMO9Qz1zAdk/SmcDDxUemMPGaRM6M1h3pLy9FwbkhgXAwW7UOLoBoj8eQW8Ia
 yeiSj2jxTE9A2ep8OZ7XpoWCTK3PxA==
X-Authority-Analysis: v=2.4 cv=Qehrf8bv c=1 sm=1 tr=0 ts=690d404d cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=jIQo8A4GAAAA:8
 a=6K911Lx7mGFY9qHY268A:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: KNSoVp9k2JqyILA9EV5pI5fyDkJbb__P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070003

T24gVGh1LCBOb3YgMDYsIDIwMjUsIE1hcmNvIENyaXZlbGxhcmkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBpZiBhIHVzZXIgZW5xdWV1ZXMgYSB3b3JrIGl0ZW0gdXNpbmcgc2NoZWR1bGVfZGVsYXllZF93
b3JrKCkgdGhlDQo+IHVzZWQgd3EgaXMgInN5c3RlbV93cSIgKHBlci1jcHUgd3EpIHdoaWxlIHF1
ZXVlX2RlbGF5ZWRfd29yaygpIHVzZQ0KPiBXT1JLX0NQVV9VTkJPVU5EICh1c2VkIHdoZW4gYSBj
cHUgaXMgbm90IHNwZWNpZmllZCkuIFRoZSBzYW1lIGFwcGxpZXMgdG8NCj4gc2NoZWR1bGVfd29y
aygpIHRoYXQgaXMgdXNpbmcgc3lzdGVtX3dxIGFuZCBxdWV1ZV93b3JrKCksIHRoYXQgbWFrZXMg
dXNlDQo+IGFnYWluIG9mIFdPUktfQ1BVX1VOQk9VTkQuDQo+IA0KPiBUaGlzIGxhY2sgb2YgY29u
c2lzdGVuY3kgY2Fubm90IGJlIGFkZHJlc3NlZCB3aXRob3V0IHJlZmFjdG9yaW5nIHRoZSBBUEku
DQo+IA0KPiBUaGlzIGNvbnRpbnVlcyB0aGUgZWZmb3J0IHRvIHJlZmFjdG9yIHdvcmtxdWV1ZSBB
UElzLCB3aGljaCBiZWdhbiB3aXRoDQo+IHRoZSBpbnRyb2R1Y3Rpb24gb2YgbmV3IHdvcmtxdWV1
ZXMgYW5kIGEgbmV3IGFsbG9jX3dvcmtxdWV1ZSBmbGFnIGluOg0KPiANCj4gY29tbWl0IDEyOGVh
OWY2Y2NmYiAoIndvcmtxdWV1ZTogQWRkIHN5c3RlbV9wZXJjcHVfd3EgYW5kIHN5c3RlbV9kZmxf
d3EiKQ0KPiBjb21taXQgOTMwYzJlYTU2NmFmICgid29ya3F1ZXVlOiBBZGQgbmV3IFdRX1BFUkNQ
VSBmbGFnIikNCj4gDQo+IFN3aXRjaCB0byB1c2luZyBzeXN0ZW1fcGVyY3B1X3dxIGJlY2F1c2Ug
c3lzdGVtX3dxIGlzIGdvaW5nIGF3YXkgYXMgcGFydCBvZg0KPiBhIHdvcmtxdWV1ZSByZXN0cnVj
dHVyaW5nLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+DQo+
IFNpZ25lZC1vZmYtYnk6IE1hcmNvIENyaXZlbGxhcmkgPG1hcmNvLmNyaXZlbGxhcmlAc3VzZS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+IGluZGV4IDZmMThiNDg0MGEyNS4uODEzMDdhN2IzODNiIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
Cj4gQEAgLTM4NzIsNyArMzg3Miw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2VuZHBvaW50
X3N0cmVhbV9ldmVudChzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPiAgCWNhc2UgREVQRVZUX1NUUkVB
TV9OT1NUUkVBTToNCj4gIAkJZGVwLT5mbGFncyAmPSB+RFdDM19FUF9TVFJFQU1fUFJJTUVEOw0K
PiAgCQlpZiAoZGVwLT5mbGFncyAmIERXQzNfRVBfRk9SQ0VfUkVTVEFSVF9TVFJFQU0pDQo+IC0J
CQlxdWV1ZV9kZWxheWVkX3dvcmsoc3lzdGVtX3dxLCAmZGVwLT5ub3N0cmVhbV93b3JrLA0KPiAr
CQkJcXVldWVfZGVsYXllZF93b3JrKHN5c3RlbV9wZXJjcHVfd3EsICZkZXAtPm5vc3RyZWFtX3dv
cmssDQo+ICAJCQkJCSAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwKSk7DQo+ICAJCWJyZWFrOw0KPiAg
CX0NCj4gLS0gDQo+IDIuNTEuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmgu
Tmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KQlIsDQpUaGluaA==

