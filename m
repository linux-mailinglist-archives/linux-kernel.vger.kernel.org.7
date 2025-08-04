Return-Path: <linux-kernel+bounces-755609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD11B1A924
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F70623F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0828AAE0;
	Mon,  4 Aug 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PUPcFv0l";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V2GiGlqc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eKIINf7O"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2A4430;
	Mon,  4 Aug 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331770; cv=fail; b=ii6+FqWjWFzeIChaU8Ptm9aH1SlirHHU0DcM27EwgjbcLIQPnY15UTpszKup7nIdqrq48FDhT5JH8ue7tq8yrLmrBBq+yyibl3q1sfSZ0XhvSwNw4mt1WRYPHkQsh6ANbMJgF/4/FtQ1bDXPvxmych2bt0GgwuYmZJ0yHzLKl6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331770; c=relaxed/simple;
	bh=w1QxXvy6kORvS6u8sHPofUctR+/l2qbmoABIymbdf/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=siaNkHmNuV8gxRwbpoKgNx7/kMKlKwe8nYlF90Zriy1O5Clusdi1p1PNRx40tdUWFN9WFY6/UuHZduCGf9/tpUwl6mJTxNrfUWjxfN6V25r2eb2VUsQ+tAFI2NnuZH7sGqLAKM0uRGREMVCv0hF2qrFggi1v3f30A3fX0wxhM9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PUPcFv0l; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V2GiGlqc; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eKIINf7O reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574Fri5W018006;
	Mon, 4 Aug 2025 11:22:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=w1QxXvy6kORvS6u8sHPofUctR+/l2qbmoABIymbdf/A=; b=
	PUPcFv0lmZZZT2GGFVaT3oiUFunGmaxVFz6929vmLyRLvlu2ezLU2hX3R1kjwtpk
	0ugpF5yAN1DJDvd55qnrIpcMDqUcAcQPrrTduGoFOWh5NzRo0WOGUjUDAfp4jyy7
	XebhCCidMkb2xdo22uGeCMc8U+M1HPa3E4nZFXwlLT9tHHemvOz0V31XAzis2qus
	DhnahIX7Jxg3G6FJdfY+OHwq5oApA9xFgqrGH6nhQLQKf8LLBZ8K+ZHDaWzT99Kj
	LmhIOYGmf9Dzm6G2TKN4gNmxtaOVtSks/Xsvn2czvLdWKPLDsti+MX1LKaHqPE1E
	ge38Ur5cwSV+MYylexZqDQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 489hpnha13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754331752; bh=w1QxXvy6kORvS6u8sHPofUctR+/l2qbmoABIymbdf/A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=V2GiGlqc4o+V7n1zNZbbgnZVNvhB6OMx66HdDasjn3cOXGaDkKhqQfFUs58tSgVeQ
	 Gl4SvXR0uoeWnrVhR7/2lMqhZrJcllDXFWtFAE9IYKv9W4GYQFOXoXvQ+dwRgszH4E
	 03ZXnwPVPXwaDMGWdRfmFpc4oK2kuTXpj0C6ye6QcC4ABnKORUmTcH2lOpUqh4jtHg
	 oG2OknIA0IsW66TNgUPVmKVblNEq9jAXWTuv+8aGnmSk7d65kG2JqLW2ZgUbNNlX/J
	 xqrpFWr04wu6DX0sE0rGg+6yYm5T/Ld0DQuBw+Vqun4pxj66fgnYhWs6ivjY4jHSNX
	 nu49aDfgHB7MQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DFB2240467;
	Mon,  4 Aug 2025 18:22:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C3AD5A0079;
	Mon,  4 Aug 2025 18:22:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eKIINf7O;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1009B40356;
	Mon,  4 Aug 2025 18:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPy3qHVPmdBLF6JlV6ZSs+WJLqrCuayS6v9JhntAu6AvzQpTC/DrS229BOikboXPCciDOtX9xifLLqh5Oay1DsYEQG2IcFaMgFNx9ha7XOgt6hJSM2i+YrrJ2ZjJs/SUA2U9DOb7zpCBZ18MBwfE/w74skV8UzuaLxOwtEWEgobEXrORxy1mvYHVlv3DfGH5kAYxG/vEVcY2yAr9Mr5ATwfd1j2mY/v52bsfkmBjv3j/xA5G9ZOKSiuGKett1JrtBqhsj6mhALVi1mEwnhk7ZJvKd/LeZj6y7cGw8rmHbGP7fx3+P01xkCGz3d7/H4hzZ9vEC7BCdy1LS/gwpwZXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1QxXvy6kORvS6u8sHPofUctR+/l2qbmoABIymbdf/A=;
 b=A+PQf+FSgv6sVQEykPAS7j8hDDddU+fSO6qgDhc0yaGXUVMxhiPQZM41SQI1oYrYof/tPTjKKRPrLUlHWfxla2eQ+fN5iEYmGOZ3fhu5VhFgBnerVU1neGbyod22rEPU0XyXhChfU5mOZrjh2HZ+uzUcHl/RDB5wlv+oW4fUVHKoHhsEwduMy0Qzmf3r1xny7QjVLIaioMvYjfiJqW0jwpfyxK3tm+SPHCiTESc5vZVg5fff+AR0964HeiHLegDSi2cdi1UX7McD8Nvy7PKz9q8QZpNL80PWwx3Zy6yPJ646jq0eawAts1hvpOpG0lcZqcFXVQoFCLa19aRAeNYstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1QxXvy6kORvS6u8sHPofUctR+/l2qbmoABIymbdf/A=;
 b=eKIINf7OuO7BR6MRIX0sfyng3KIaqOprOpFUbRpGgYt0apEPH2MtGyQeViJKCNMUb6z0OEwsJr6PkaKAdh7Wnh6L7/7re02RHaieXX2LSOkEFFK+MxcDFnMIZ2RtzCcZB8emVhRPNEqUQ4c+0YGUG+ThxKHaxoFeDn1yVEN6jSk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Mon, 4 Aug
 2025 18:22:27 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 18:22:27 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: dwc3: Ignore late xferNotReady event to prevent
 halt timeout
Thread-Topic: [RFC PATCH] usb: dwc3: Ignore late xferNotReady event to prevent
 halt timeout
Thread-Index: AQHcBRbxkAv8dVEgYE6WQJ54VkkuV7RSz0AA
Date: Mon, 4 Aug 2025 18:22:27 +0000
Message-ID: <20250804182220.mho2qjdtmvdkicec@synopsys.com>
References: <20250804080809.1700691-1-khtsai@google.com>
In-Reply-To: <20250804080809.1700691-1-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH0PR12MB8577:EE_
x-ms-office365-filtering-correlation-id: 1dc1db9e-8dbe-4bdf-7326-08ddd383ddc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHFHSHdNZlBVZCt1OXl4Ui9TWUVsWHl3TGtpVzljR0NFUUlJelJ5N3ZzaVly?=
 =?utf-8?B?MTJLdndBV3hPRThyVTVwZlQyL0VqTXZGY3JtcC9WZkw3U1dzZzdiUFFSVm4v?=
 =?utf-8?B?UXIzVDNWWjZZN25pT0VZY2FOaFJNU2NLalp1cXNxelZXaGhxY2FBYk1rQTJ1?=
 =?utf-8?B?aklnaGVac0VXUVgxKzQ3T0gxakxSTm5peEtiZzl2a1ZLd0R5NVU3OFBXMjR0?=
 =?utf-8?B?OExRNWlsdGM3TC96RDBOdFhBTkpueGNwRUZ3Z3ZWTnRNK1JWU2N6R0RMYWZx?=
 =?utf-8?B?Y0VpQ09sa2VRV1JXNURRbUU5bGVpUTZsZGhRcDJ0Q3lXWEQ4NlR5NGdqVG5N?=
 =?utf-8?B?a1FXSnh1MitmY0YrVCs5d21WQnNuZndMcVNPdHV0QzFpRlVWeENkNGY2alVJ?=
 =?utf-8?B?aHNIVG5EUXViUzhydUZxVUFjdS9GTHRpUFFPbHZTZFllbDF1R3VhSU5XS242?=
 =?utf-8?B?Z0U0Vm5kdngxL3pyYmVsSTlzcjQvaFNPUmZVMCtEaUZhanVCMXlmRHdYQ0dl?=
 =?utf-8?B?SVE0bW81ZUZDMEh3ckpSc2MzRTl2aDJBbFM0T08rdDhpOEdKSFdrS1RCcUlW?=
 =?utf-8?B?S2swcmRFeEJUYWxWUUdPSlM1ai9RRlB6TXExWnY5aHlveDRnSksxc2VUc1lh?=
 =?utf-8?B?Z1czT0s0WjdrNHJhMUJLRExmZjJEYVZEOXNOaC9PdE9hYnUzVUh6OVl1ODVu?=
 =?utf-8?B?NDE1TzFvLzJRRXNrT0YxOVZINmV5U2c1Qk91S08wcHBFMG1vSWZXc1JWakZP?=
 =?utf-8?B?aVZ0a1VrREVkbm9UeFhvOVZrTVowb1lUWVo0KzBqUzRtK1dUSEM1TFF0R0Rk?=
 =?utf-8?B?T1dhZE05TS95T0RvQXhBTUVsMjQzak9EMmlEV1RFVFhIbGwxWFc3RFhEVW16?=
 =?utf-8?B?R0dWOExna0FBKzl0K1FUdzhDd3FVTXhxVitDR0lZYlQxcTBZQ1lSTU5iRnlv?=
 =?utf-8?B?STVQdTlHWDlYdW00UDJwK0FiN0ZrWVpCeDd0b2d5emtEb2NlOUh1NmFQSjFN?=
 =?utf-8?B?MmI5ODgydnQxWjNEN0FXUDdqREh5VERMVFJqd2ZxSkNMSzVwODZwaERJbWZk?=
 =?utf-8?B?TXJZSGM5RTB4cHVvSEFBK0FsaUZEQkRFRWFzN1VyUDJ2T1dLZWNFQk9GNEpT?=
 =?utf-8?B?b082Z0JCVFU2WDJYajQxZXlvY1JpMFNxdjdnMjBhZUZvWG04MXB5SkxPZCtq?=
 =?utf-8?B?UmFtWklpamNrYzlDaCtYZjM2MDFoT2lsYXZRV3M4NDVpQW1PMzVkbkVsNUJv?=
 =?utf-8?B?akJKb1l5UXErSkxGS1RyVFdaUmRCODNyblFobDNIWWhRTjJaSWVZNzFLazVK?=
 =?utf-8?B?Zk5WTGNJZ2loZ1o2NVJpMFRlalQyZWhnYmpXQlpjWWd0U3RtQmY3RkhnbDRn?=
 =?utf-8?B?d1BDOS8vamZzendTWUdHSkVUWkYxdVFFRDY3eWFUNjhVTnIwc3J3YzNNZGdU?=
 =?utf-8?B?S3BlOHNDaXNkME45NnhCZEFyRmxIZWFLbWJmSlcwUHZRRXErNzg3ZTFWWUlq?=
 =?utf-8?B?Vk5IQnAzNUdKcG9oVG9qTWVEK0orR2ozSEgwYWRBTlo3dzRkMkpWRStURFVx?=
 =?utf-8?B?VnJJSk5FWHBIenJwem9oQUFWa3BQZGxjc0xORGlWOGNjZnZ1ZFZacGhSK0F6?=
 =?utf-8?B?Si9KemVmSUhJclVYdnB1UThqbHp3aDgxYkVQMHc0M1Y0MFgyOHVPMTI4eDJQ?=
 =?utf-8?B?MkhyWTl6UGtOLzdGVEl4S1hBMG8rZHNNU3AyTkd6VjlTN3ByRGJDK3ZvTC9P?=
 =?utf-8?B?VWNBNSttcENWZ0lFY3EyVVdZWnBFV2hrMFp2SzZ6dHNIYjBPR0M2Y3M1NTlV?=
 =?utf-8?B?anVFTCszdVkzR3BFa28ydDg0N1dKQUtBanNpK1BwMktjTFlMd0w5azVBblZI?=
 =?utf-8?B?YktZKzU5dlkwM3N6Z3NNRmFuSUxrNG9jQU1MQ3NwL0t0ZEF2VlBaaGJyK2Jx?=
 =?utf-8?B?ZjVKQXAva1FtTGJFS1lDaTRRcVRmZ1Y3VDB5Tll1eUlHeC9ETFZhVTBia1Iy?=
 =?utf-8?B?bHRaQWpoY2FBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUV4eHEyR0d1amU2K3p2U3pxQUhBN2lVdFlLVkxNMXRiWTFvRE5LNkJQb0xS?=
 =?utf-8?B?eFMrMHpWVGd4bVFsQmIvVUo4Sk9GRmpYK21kSTI4NnBZWEN6cnVOQTBua0pq?=
 =?utf-8?B?UzFNNTJLYVcxQ0RSR0NWRjYxWkk2V0IvSy9majJ5ZWgydnhkbVB3bjR0V0Vq?=
 =?utf-8?B?RGxOcUswTWpsZDliMkZFZ0ozaDB3NjArVUQ0TVlHcXpIb3YxQ2VzNldSVUwy?=
 =?utf-8?B?TVhJaG9raE5vcGhmWUVxb3NwYkluU0FjQkl2WW1CNGNxcDkycG4rdXg2eG1v?=
 =?utf-8?B?d1hlamZ2ZTdLSUsreFN3eXV2bjJWYzZhL1Rta29XUHFoZER5bUdEUTVKOWJX?=
 =?utf-8?B?d0t3UXJKMkR4QnVaS1h4TzNLbVM4cGJYT3FXOEFWcnA2TUNkdmlKWWs0T1FC?=
 =?utf-8?B?L2JwN09FajdEeVVVUUNORkZIYVZiTUlnT2huSjByK0RYb09lSksxYkcrYUVN?=
 =?utf-8?B?ZjBXUjhKQmFqVksvaU8vRjYwVWt3RGpOTWxTc2puWG5GNEVrN0dURisvOElh?=
 =?utf-8?B?YXVDVGpYeXNwaC9FSGcvTmIrd1F0QWlKNWo0M1JUUzdhYlg0dlFHYUtFNFhD?=
 =?utf-8?B?M2sxS2ZubXc5WGM4UlFrMmdrQUNmdk5mdXQ4Y1dielNOREt6c1NIT3NxeTBQ?=
 =?utf-8?B?Q0taa3NGVlRuajNnNXVpUHlDYXM0SFJJd08xbDIrZ2Y1NXZLYjlqeERJNzZj?=
 =?utf-8?B?OVE4UkQ3d09wYVpuRVNXVzhGUWdVcWJWd0V1UDdzbTlEMmQ3RFhxbFU3OXFp?=
 =?utf-8?B?RHVXWDJTalprUkdvcit1Q1ZXOSt0K012MWRTRmNvVWdBSW5wb1ZNU2VkaEVT?=
 =?utf-8?B?VlRoYktpb1JreTVCeTdMTk96cXEySzl1clV0dVlGUU81L3VHYldyK2lYM2lw?=
 =?utf-8?B?U2FFcXIzS1orS01PNkNXWG8vM0hBbERPME9KdW1Ub1VidkxzYnRTT0FIRXV3?=
 =?utf-8?B?dCtWMS9DRi9LbWhscnFBZnJ6SCtlMFZOR053KzYxdkFnVFJvMEJPaTcySXp3?=
 =?utf-8?B?NzF1c1BRYk05QkdCUkt2Q2RScHlEOGhPc3RVeFFtV0dhSDVDdGpxdHhLVnh6?=
 =?utf-8?B?SzVFWTF6YzByNDlYTDRyWUhMYXZaL3Fxd2p0S1VpLzRoRkNTQkdxSCtTbmxE?=
 =?utf-8?B?eTU3d0ZLaU51amVQbmJMRC9OZDRrN1VwNjI3M0I2bUVqbEpTRWRGMnFKTGN4?=
 =?utf-8?B?SnBnZDdYc1VMVzJrbE95Z2JZcGF5dVMxRnVrZjE4emIxQlkrcTJ2ZFp4OVJj?=
 =?utf-8?B?N0REMzBYeE9hMzBHekYzSVBiTnVsdDU1TjJjQnBqOUllb285dWFYdnY0ZU80?=
 =?utf-8?B?OVJBVEo1ZXU5RTl2TUtRdWlpNzRLVVNMU2VpWFNOTDZoelpoREcyalU4VE5S?=
 =?utf-8?B?VE05eU9sbHp6OWtvM2tqa1lwT0NLNUNYeExCenh2a2hNV0l4ejZIQXN4bWlv?=
 =?utf-8?B?ZHYwMllHTmRMeWtveG12M0RvbUp4YS9QSXdtc3ZRNy81YU1BYXpXb2FUbkgz?=
 =?utf-8?B?eVZydHRYYXdhcHpIT2RPbWZ4dXdXS0tiLy9vT2hDdEVYblp0WjVUVGoyMmhQ?=
 =?utf-8?B?UUt4OEhUdVBzTnlmVnFzTWdkanBFeXVJVTZSU0VOeEtSMm9aY25PeGRUQkRu?=
 =?utf-8?B?MDFuL25ISi8yV1dWOElQZ1pBRVFJemtJTEpwNTdtUEhvK0R3aWgrWmF2YVhV?=
 =?utf-8?B?K2RyUi92aVg4T2psWGlkZFF2Y1BzNXVnV0tURTBIRk9RSTNQa2VQUlVSZGho?=
 =?utf-8?B?SURzRkNudVA2RnByRHRRek43UkpDWDE5MGtpZ0VneDJBeWUrTExlNVBSbVdU?=
 =?utf-8?B?UnVKMUdGaC9Tc3B1clQ0ZzY4VE5ONXhBWko2aGc5c0Erc3FBbmtReUFuQVcw?=
 =?utf-8?B?SFdKUGhZQTc0MTR4cVprNTdjd1BWOEJXckxvdk01NzdrTUc4dmliS1dteUJx?=
 =?utf-8?B?aVBVeENST3MxM2NHd3hkQWYwN2k3YzNLN2hUN0tVSmVBSnM5Rm0yU3p2ZWVW?=
 =?utf-8?B?cmFpU3BSbzQvRFA1NGd4N0FHWUk0dVFXQkVZNEhqY1dTOGhVL0FNc09pMGVT?=
 =?utf-8?B?cVp1K2dXbWUrNmJYTkpMY3R2UWpLMndrRjdZUVptbUo3azNWM0M3R21NY0ty?=
 =?utf-8?Q?1C5iQQeGQf/dpjC/m6w9n2jLH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2CB880BC961364CA0EF4966D1B73529@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y6erlWVZNGLwzvhadUiQNJYWzvdkp2KzXVi63rhcN+yl5TquP3SzxjBuSGVu83fHn+87bmbJ4Nya5kUqlR9GbzV9dXmK0em+haaY69WSJEJrzmOFOM19Sd72UF4erzc3X7GJxQfMAi3cRB41xx70zPXiuk2N3E+AezAK7ZVZKNvkKO59A8AXpEObQa9og62RUBmO3wH+ugcjaFAP9RE9JJaexRto7qn8wocAGaJt4bPggkJvFmp/R2IuKo4tBQqs8jYOg9XAx+DyunBTzqq+WXu8+VLPgIB2Zgj5UjLZtbBOdOy2zoetqGxbaqZun++4n9dqQCjAysK9ITeY0g7130BnFLS2dV063qlb7cMeQh7vcjKTfkaPwjX51jmK4xQYq0x6kzYcK0a6z9Rcl2l3Rxo4bxRzJgEeXK8XNJcAYxgrYhoR9lB9UGRFEheMXSqaLn2RU28TyaGbaV2Ed3se6SCVr95H2ZfSaKcgosQi0Fywi/NJMhq8vlNP18ArcwCp4HTXiQhmnhum/+xTdz1d3LbivMr6uU4eoJDwhSW+sxqX/GXsKF6+2YCa+ziUrjhhVX0sY84Ap5O6vuFF2mGVb3BW68GJrbbwyA2g/7RsZQRhjX2u7TjoYeh/QHpj20ivnhO6qEYd2+PdNU/zPGMvPw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc1db9e-8dbe-4bdf-7326-08ddd383ddc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 18:22:27.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XJVSvMBjWVow2QvkRHX5ocvjGkpjRyBQtvND6THByuwPXUJP9dH+daIq7K0xubuR+XW22kvTHG2gZWUPDmqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA5NCBTYWx0ZWRfXzHYwvhvcepul
 ijsyjKyGdOdqpkWEPH8WcdlI8qKbZ7Hv/EVLs56SV3Bs+OsnDcXXRUlT+pNEqe8i+o/s5GuPOv5
 hF05gc0iACiG9slfZuTTvqNlEy5X7D0PtFopVvkDXWjfnr1dbOSTPeO2SLTatLC7VZaD0hC97Xj
 c6fHlO0nbsHYuTRJPMIcKmtKsTVJxUNfDuQmWiLcI6AXqFruFYhZVA38p7EKrFJyUWXJbPL+Kr5
 dUtyOu5mq62mrYXFQiTPZO78IOzJO7Cmo8lD8J+o3tzqUyOlzFXV/tD25lW5oFKQO8rIzbrfnMl
 oMunz/SPRpMFsMZ7kkdmda3LaijZC6DvR5idQv+Hsl6TKE5+iWXGG+h1lftwn2czAkMKmNoaJiR
 eNFlyIdc
X-Proofpoint-ORIG-GUID: ySviUuLOeJPx1FZGhZolT3lR4dj2HvfQ
X-Authority-Analysis: v=2.4 cv=WOx/XmsR c=1 sm=1 tr=0 ts=6890fa6a cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=1XWaLZrsAAAA:8 a=p-0LwKFhLqh88cWBrjoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ySviUuLOeJPx1FZGhZolT3lR4dj2HvfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508020094

SGksDQoNCk9uIE1vbiwgQXVnIDA0LCAyMDI1LCBLdWVuLUhhbiBUc2FpIHdyb3RlOg0KPiBEdXJp
bmcgYSBkZXZpY2UtaW5pdGlhdGVkIGRpc2Nvbm5lY3QsIGFuIHhmZXJOb3RSZWFkeSBldmVudCBm
b3IgYW4gSVNPQw0KPiBJTiBlbmRwb2ludCBjYW4gYmUgcmVjZWl2ZWQgYWZ0ZXIgdGhlIEVuZCBU
cmFuc2ZlciBjb21tYW5kIGhhcyBhbHJlYWR5DQo+IGNvbXBsZXRlZC4NCg0KU29tZSBtb3JlIGlu
Zm8gZm9yIGNsYXJpdHk6IHRoZSBjb250cm9sbGVyIGdlbmVyYXRlcyB4ZmVyTm90UmVhZHkgZXZl
bnQNCm9uY2Ugd2hlbiB0aGUgaG9zdCByZXF1ZXN0cyB0byBzZW5kL3JlY2VpdmUgZGF0YSB0byBh
biBlbmRwb2ludC4gVGhlIEVuZA0KVHJhbnNmZXIgY29tbWFuZCByZXNldHMgdGhlIGV2ZW50IGZp
bHRlciBhbmQgYWxsb3cgdGhlIGNvbnRyb2xsZXIgdG8NCmdlbmVyYXRlIHRoZSB4ZmVyTm90UmVh
ZHkgZXZlbnQgYWdhaW4uIFRoaXMgY2FuIG9jY3VyIGluIHRoZSBtaWRkbGUgb2YNCmRldmljZS1p
bml0aWF0ZWQgZGlzY29ubmVjdCBhbmQgYmVmb3JlIHRoZSBjb250cm9sbGVyIGlzIGhhbHRlZC4N
Cg0KPiANCj4gVGhpcyBsYXRlIGV2ZW50IGluY29ycmVjdGx5IHRyaWdnZXJzIGEgbmV3IFN0YXJ0
IFRyYW5zZmVyLCB3aGljaA0KPiBwcmV2ZW50cyB0aGUgY29udHJvbGxlciBmcm9tIGhhbHRpbmcg
YW5kIHJlc3VsdHMgaW4gYSBEU1RTLkRFVkNUUkxITFQNCj4gYml0IHBvbGxpbmcgdGltZW91dC4N
Cj4gDQo+IElnbm9yZSB0aGUgbGF0ZSB4ZmVyTm90UmVhZHkgZXZlbnQgaWYgdGhlIGNvbnRyb2xs
ZXIgaXMgYWxyZWFkeSBpbiBhDQo+IGRpc2Nvbm5lY3RlZCBzdGF0ZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEt1ZW4tSGFuIFRzYWkgPGtodHNhaUBnb29nbGUuY29tPg0KDQpQbGVhc2UgYWxzbyBh
ZGQgRml4ZXMgdGFnIGFuZCBDYyBzdGFibGUuDQoNCj4gLS0tDQo+IFRyYWNpbmc6DQo+IA0KPiAj
IFN0b3AgYWN0aXZlIHRyYW5zZmVycyBieSBzZW5kaW5nIEVuZCBUcmFuc2ZlciBjb21tYW5kcw0K
PiAgYW5kcm9pZC5oYXJkd2FyLTkxMyAgICAgWzAwNF0gZC4uMS4gIDYxNzIuODU1NTE3OiBkd2Mz
X2dhZGdldF9lcF9jbWQ6IGVwMW91dDogY21kICdFbmQgVHJhbnNmZXInIFsyMGQwOF0gcGFyYW1z
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4gIGFu
ZHJvaWQuaGFyZHdhci05MTMgICAgIFswMDRdIGRuLjEuICA2MTcyLjg1NTczNDogZHdjM19nYWRn
ZXRfZXBfY21kOiBlcDFpbjogY21kICdFbmQgVHJhbnNmZXInIFs0MGQwOF0gcGFyYW1zIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4gIC4uLg0KPiAj
IFJlY2lldmUgYW4geGZlck5vdFJlYWR5IGV2ZW50IG9uIGFuIElTT0MgSU4gZW5kcG9pbnQNCj4g
ICAgIGlycS85OTEtZHdjMy0yOTc0MSAgIFswMDBdIEQuLjEuICA2MTcyLjg1NjE2NjogZHdjM19l
dmVudDogZXZlbnQgKDM1ZDAxMGM2KTogZXAxaW46IFRyYW5zZmVyIE5vdCBSZWFkeSBbMDAwMDM1
ZDBdIChOb3QgQWN0aXZlKQ0KPiAgICAgaXJxLzk5MS1kd2MzLTI5NzQxICAgWzAwMF0gRC4uMS4g
IDYxNzIuODU2MTkwOiBkd2MzX2dhZGdldF9lcF9jbWQ6IGVwMWluOiBjbWQgJ1N0YXJ0IFRyYW5z
ZmVyJyBbMzVkNjA0MDZdIHBhcmFtcyAwMDAwMDAwMCBmZmZmYjYyMCAwMDAwMDAwMCAtLT4gc3Rh
dHVzOiBTdWNjZXNzZnVsDQo+ICBhbmRyb2lkLmhhcmR3YXItOTEzICAgICBbMDA0XSBkbi4xLiAg
NjE3Mi44NjgxMzA6IGR3YzNfZ2FkZ2V0X2VwX2NtZDogZXAyaW46IGNtZCAnRW5kIFRyYW5zZmVy
JyBbMzBkMDhdIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBU
aW1lZCBPdXQNCj4gIC4uLg0KPiAjIFN0YXJ0IHBvbGxpbmcgRFNUUy5ERVZDVFJMSExUDQo+ICBh
bmRyb2lkLmhhcmR3YXItOTEzICAgICBbMDAwXSAuLi4uLiAgNjE3Mi44NjkyNTM6IGR3YzNfZ2Fk
Z2V0X3J1bl9zdG9wOiBzdGFydCBwb2xsaW5nIERXQzNfRFNUU19ERVZDVFJMSExUDQo+ICAuLi4N
Cj4gIyBIQUxUIHRpbWVvdXQgYW5kIHNob3cgdGhlIGVuZHBvaW50IHN0YXR1cyBmb3IgZGVidWdn
aW5nDQo+ICBhbmRyb2lkLmhhcmR3YXItOTEzICAgICBbMDA0XSAuLi4uLiAgNjE3Ny40Nzk5NDY6
IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wOiBmaW5pc2ggcG9sbGluZyBEV0MzX0RTVFNfREVWQ1RSTEhM
VCwgaXNfb249MCwgcmVnPTANCj4gIGFuZHJvaWQuaGFyZHdhci05MTMgICAgIFswMDRdIC4uLi4u
ICA2MTc3LjQ3OTk1NzogZHdjM19nYWRnZXRfZXBfc3RhdHVzOiBlcDFvdXQ6IG1wcyAxMDI0LzI3
NjUgc3RyZWFtcyAxNiBidXJzdCA1IHJpbmcgNjQvNTYgZmxhZ3MgRTpzd2JwOj4NCj4gIGFuZHJv
aWQuaGFyZHdhci05MTMgICAgIFswMDRdIC4uLi4uICA2MTc3LjQ3OTk1ODogZHdjM19nYWRnZXRf
ZXBfc3RhdHVzOiBlcDFpbjogbXBzIDEwMjQvMTAyNCBzdHJlYW1zIDE2IGJ1cnN0IDIgcmluZyAy
MS82NCBmbGFncyBFOnN3QnA6PA0KPiAgYW5kcm9pZC5oYXJkd2FyLTkxMyAgICAgWzAwNF0gLi4u
Li4gIDYxNzcuNDc5OTU5OiBkd2MzX2dhZGdldF9lcF9zdGF0dXM6IGVwMm91dDogbXBzIDEwMjQv
Mjc2NSBzdHJlYW1zIDE2IGJ1cnN0IDUgcmluZyA1Ni80OCBmbGFncyBlOnN3YnA6Pg0KPiANCj4g
LS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBp
bmRleCAyNWRiMzZjNjM5NTEuLjUwNjM5MTY5OWExMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBA
IC0zODk2LDcgKzM4OTYsOCBAQCBzdGF0aWMgdm9pZCBkd2MzX2VuZHBvaW50X2ludGVycnVwdChz
dHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCQlkd2MzX2dhZGdldF9lbmRwb2ludF90cmFuc2Zlcl9pbl9w
cm9ncmVzcyhkZXAsIGV2ZW50KTsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBEV0MzX0RFUEVWVF9Y
RkVSTk9UUkVBRFk6DQo+IC0JCWR3YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYW5zZmVyX25vdF9yZWFk
eShkZXAsIGV2ZW50KTsNCj4gKwkJaWYgKGR3Yy0+Y29ubmVjdGVkKQ0KDQpNb3ZlIHRoaXMgY2hl
Y2sgaW4gZHdjM19nYWRnZXRfZW5kcG9pbnRfdHJhbnNmZXJfbm90X3JlYWR5KCkuDQoNCj4gKwkJ
CWR3YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYW5zZmVyX25vdF9yZWFkeShkZXAsIGV2ZW50KTsNCj4g
IAkJYnJlYWs7DQo+ICAJY2FzZSBEV0MzX0RFUEVWVF9FUENNRENNUExUOg0KPiAgCQlkd2MzX2dh
ZGdldF9lbmRwb2ludF9jb21tYW5kX2NvbXBsZXRlKGRlcCwgZXZlbnQpOw0KPiAtLQ0KPiAyLjUw
LjEuNTY1LmdjMzJjZDE0ODNiLWdvb2cNCj4gDQoNCkFuZCByZW1vdmUgdGhlIFJGQyB0YWcgaW4g
JHN1YmplY3QuDQoNClRoYW5rcywNClRoaW5o

