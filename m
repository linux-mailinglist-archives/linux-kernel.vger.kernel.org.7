Return-Path: <linux-kernel+bounces-757064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF773B1BD4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC163A9930
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2492BDC3D;
	Tue,  5 Aug 2025 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h5CU4Uw/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ib9gQ88P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="oohmtz7y"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCEE165F16;
	Tue,  5 Aug 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436558; cv=fail; b=AuCKwsf9t+XiBrOGwK7EOwuy14X5FQ32tnw3NvkirFQd94rT1cqBpYoZDQVwPcFpChTyRFN/ss5cqbRTS1kyrfoIEZe8ccEqdR70kxh7pFYlXi2c9kqSDz/HIkwZFdqlWtlXqbiN2o13lu37m9+hMeo+cPDBxWJkv1ahf1wHShk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436558; c=relaxed/simple;
	bh=Xfi87Fn789QKh752ftSd1Gso0+C1U5xuqmwnq9AWiYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0H/fG/9JMo2J0NwVBCPFAO1HzHIl2wstBqsBv92w2fGc3xFQPzHzcVUXdq4IaViE7kjpCsDjniPaBy8QZ+gkewCayGwuaUOZU122/J4TQdMZjmJ7HxQqB+i8u5Jm9fHdS2Gbkv6AxSNVvUkEfLrd0rxrWkEfENyoqU29hjOK8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=h5CU4Uw/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ib9gQ88P; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=oohmtz7y reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I5xe5015012;
	Tue, 5 Aug 2025 16:28:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Xfi87Fn789QKh752ftSd1Gso0+C1U5xuqmwnq9AWiYQ=; b=
	h5CU4Uw/GuvrncIMq0d8KwaPMWB2lgME1Iw7K7HDm3LjGOafTCFuw11nabPgPGzk
	JIYS6JIJMTMS9Xy6AvxPsw6n9Tx1RxaS9nWDs6l0O7V0WXqN9ObuwMC6SLFDwF0y
	HnnUau7dYwtnJUM7tLOZ4rznMEg2Hc/vy7g7BvM2YV+0VpLLdbDBneJzim35qhtb
	rKGEOhU32y0fgyaz177dYcUflzkVr69/PIDuNPBZPmK/iJ3cAMgSDbpIpprjzLbK
	Xv/HCFoiqEhqTH7KbfvOmiLV/O2Bria6/mWFzU1uq1k6rAvE4KyJDGLwwuDpQL3p
	9ppmUwx2eosnF7cDR+SEuw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48bpxgsfgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754436529; bh=Xfi87Fn789QKh752ftSd1Gso0+C1U5xuqmwnq9AWiYQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Ib9gQ88P49ZwUV2LUXsEFtFV+NQc23NSxDYyonnzfEfAQOLscUmBvfzkqhH49eYq+
	 SJffG/t2UOOabVdSl3e4E3Yce6/W6qsyjSlUNpZzGFbguVGyHBuHlbAzacyaElAU++
	 qegnTeXwLBTbJ1cg9y1XUxBvTeIOhTlaCh9zbuIF+bAxNOme7cxkpbG8M6QlaY4TMC
	 zFwKrB+hS3vof9/SCmShF384lzB/pHDHsKnoFaR0JtG4g1sBmr8ceb3kwAK/08aFLG
	 k4myeXKSdexy+ODc9MjnKu8DZaKFQe6SeXbsMkcIrAWqXQ6Xxoo74OhxCNrIofY/mU
	 IOrQwCUr+jPjg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 388F24013B;
	Tue,  5 Aug 2025 23:28:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 00709A006F;
	Tue,  5 Aug 2025 23:28:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=oohmtz7y;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2A38C40561;
	Tue,  5 Aug 2025 23:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/wh7P/hy60Wc9P2dqq5f78Thhn+ioCEfXZ0jDyeTolvUvQ0gGLA5leYR4CMP4FKum2B3Ol3hHOlo0LRdVMcSxnSlA7aTeJMZtdQR8otdDyjONexw1+mH+9hFOXkD9QTs/bEwhTrmBsX46luhY3PCc5FEQ3HDlrQTgSVtIu2KYDTYZDcpwPUd1cs1frCobypqGEzChFRHk0l6fECFNCcXORHoh2RyHFXJnfA60gPg3dgRJbwd1aILQXPpwDm4MRRNVCmICRJW6WZlBI+2PRQFyCPaocYpeIOlNM100aajz684sBQyghmZmXiCBEM1GD306b4QlSG+JenfdDb8jWNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfi87Fn789QKh752ftSd1Gso0+C1U5xuqmwnq9AWiYQ=;
 b=Tg/RepsU0WvEwrQGK39bYlcyPGaseob4P/6MuwgxPFiG+EAdMA1v/27s5CSZlPfBXDUhdUD+HgQ3ieU+GSDndSpzu6OukyDShdqqmz8lSqJppH+PiY0i4gFxXG1uJsV+VbzO0YSDglfhLM/g2mGHTJZBqshgJfoPG0PmM/cxJ1fE/8QN67xxn3Run1CcHQ9pwGs3f0uRTmM9qVnYkaKMV52Evz0JSXeQdi0/FmRIjNL34v8sH/JEyaBCOzJOqjg4ZzixaAzWnRFbS1nWbZfgvJcXmc3EgluhxAjvvlIITTpjKaxZ7vO9xqNTDoLNUb8z+O3fEi8oZ3XT+EcZhgY2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfi87Fn789QKh752ftSd1Gso0+C1U5xuqmwnq9AWiYQ=;
 b=oohmtz7ys/KPr+abJnN7rI3CNdw+pVJHb8fyEMYb8336UPOrGNyVsJVJhOY+Lz5EgKZKgqTdUXle2q8Ll27aYOB4+FQ4UhKuG++wTQ5kg6Xy+NgeJUE96AGFfsheG39JOUoX2AeTujuUlCLbg+Afjw2mwgTZ9DCJwDU2cOSI4mE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 23:28:45 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 23:28:45 +0000
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
Thread-Index: AQHcBdL768zwXoO6m0m+jPwqD5QZsLRUtbeA
Date: Tue, 5 Aug 2025 23:28:44 +0000
Message-ID: <20250805232843.xka5z3edqatoyzqh@synopsys.com>
References: <20250805063413.2934208-1-khtsai@google.com>
In-Reply-To: <20250805063413.2934208-1-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB7475:EE_
x-ms-office365-filtering-correlation-id: 9a465b8e-4005-4d3d-74bc-08ddd477d23c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHhQOEhLS0VuemFRTzJRQmtIMFNuSVUxeFFDQkl0bWZiaHVOcmM3cjI4SDRY?=
 =?utf-8?B?Q2hNU0hPb1FkRThWTmR2THBvVlBudlNvcEZERXBRWVo3MmZyaW5CUUx5elZ1?=
 =?utf-8?B?OHVZTEZINkM5UVpnRTVicS8vbERrQzd1UWZib2pnR0pDWXJzaW92WWhUQUFY?=
 =?utf-8?B?cHFSTndpSDEyMDUxRUhoTXBYZWZmSUkzNW5NR3Rqb2xnemRtOTRlVTIrNzZF?=
 =?utf-8?B?QStVTWtZcDFLUkppci9rbHZ0Tmc1SlYraWtFRWZlQjRPSVZKRm9jb0tRYzVM?=
 =?utf-8?B?V3lxb1BLZ3F5M3dMYm93eVZzam9UejI3NmE4TEtobkRoampmWFUySktPMkhi?=
 =?utf-8?B?Z05OVCsvSlZnL0VtRGUrN3lPTGxYYjdTMmpwZ1pORGxyZGxMU2ZWTVFiU09o?=
 =?utf-8?B?VysvZVJqdG43aEVjS0MvUXFBam9LVkpKUlBNRDZhUlAva29IUlhNNHBRSTJP?=
 =?utf-8?B?MUxWZEZpKzlaQW1JSm5nc3dNWUFhVk5meisvbjdrL2tUbXY0SmgxSDkwN3RH?=
 =?utf-8?B?MTNSODN4ajNiSUVhcEFnRGNDUm04MTVMTnhFb3dLSVdySDRXQUNqdWk2NkpZ?=
 =?utf-8?B?Z1JTa1FaWnVQMG13b0NuUzBTOW03ZkNxSTNKbGlrRlJxNGdPZy9XVEtWUGgx?=
 =?utf-8?B?VDNrSEVIMGUwYU9DZDN1a1Z6U0h4dkZNSnJhL2FCaGlRdkJ2djIyUHJYWkow?=
 =?utf-8?B?SytBWi9kTjlvUE1DWGpGcGJJcFFva0pXaXMydHVJME5DcjNDSTFHNTNzd0hK?=
 =?utf-8?B?cDBCL0dMSW1Ia3NEbnhLaUVmQVkxR2ZHanNLcmsxc3d0cTdyVFl4ZFp2UWJ5?=
 =?utf-8?B?MG52NzlPWlc0YUZUdE01ZW9lQjQ5b1UwWU13b3Z2ZFhRdkJzdUZwK3VWOW5k?=
 =?utf-8?B?R0U5NjNMQmRkUUFkU2xnbmhkNFNqL1VZOGlOemVLUCtWN3pTMlFiTjNkbkdu?=
 =?utf-8?B?QXJJWUlOTExWT1BYODhmUmJZZk44R2V1Z0RqRS85czFMdWdqUWpZckhIRmQx?=
 =?utf-8?B?K1NWenU2R2NEVUxRK3ZPelJheTRIU2tDU1ZJck9YYTB3VEtURXNTSVhNMUQy?=
 =?utf-8?B?VFkyVXpNaXZWNUZ0NHFXbDFlMUZtanVocXk5UVhZMkZveU9aOEtWdEpNMlJE?=
 =?utf-8?B?aCswTUNEWGtRaUFLQnVnMVRMc0JXVkcveHBuYm9mbjZKWExPN1E2WXp6Q3F0?=
 =?utf-8?B?bTQ3Q1R5MWNoNG11dnpiS05nQlFMQmxCQjJKaVJvQ2ZlT1FOTDZrcmlhWTVH?=
 =?utf-8?B?TDNkNVdkVnY3SEhSUXE2ODFhbm4reTBtWEZSbHRJSUNiZ1UvS0FtZ3Yrb0VN?=
 =?utf-8?B?Z1F4NG9PNlhQKzFCYlZnYzJndVdmemEzNlhBa3lzN0JwbG1pUHZ4a3J6Zy9k?=
 =?utf-8?B?L3R2WVFLbUZIV01kNjRPWU1GYStKV0IxZHpXS2NGU0xiWHlPV1lBNTRFU3hE?=
 =?utf-8?B?TU1Jd0lkc1hRNE45L1hjRW1MUnA1dlFWRWVxT0Fyc3ZDZ3FBZ3F2cDNpNktB?=
 =?utf-8?B?aVR5L0tlU0pCOXB4azVieC9TajM4UnE2Q0R0S01lQ3FzOEVPMmVYTVUvUVlp?=
 =?utf-8?B?ZFVqY0tLR1hhN0xUMldMWVpRd2tEQk9xRnIxMldnNFlyWGVrMFV0MU1lU3Vl?=
 =?utf-8?B?TjhFNi9mSldEdER3NlNVWXdwSldHZmlGa2FmZ3kzQWpvcGxEckNVWHkrcVZz?=
 =?utf-8?B?V1pyQXhBWmU5akJYZHBnUDhoaFJEM2ZnZmw4NXhrZW0rNUdMNVh4QXdJYkVa?=
 =?utf-8?B?VFJtczhob0lOcWp2Mk5CekE5ZVV0ZS9QOEZUelc3azJHd3JxVU83dzdmWTRU?=
 =?utf-8?B?aHFIYll1S3JlWWpKL2trVWVxR0RNY3RJaWtYNTJCZnMzK1ZiSFl1WXVmeXRm?=
 =?utf-8?B?TDlnS3dLOUFKWjllRnJxT25CNnlrd0IyOGxzcmlXSlMwTDVGakUvTUl1L2gy?=
 =?utf-8?B?MTZlUGw3UTZrWDJRYzE5REx5VDZRSzZYUGZ1TW0rRkxLd2FXT3FsTFF4L1hB?=
 =?utf-8?Q?hHUvp41oDzk17wJcnpboa+43D/loZ8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDF6UWh4b0FqYlYrUHZBVkVic2xMS2s3aFpkSUFHcndzR0Jsemp1Sm5pUm5J?=
 =?utf-8?B?RG9JRGc3V2xSWXFzVTRzSHl1U3NqOG5ORU5WeTJCL1BYbVdpU1M4M3p2Mlhs?=
 =?utf-8?B?ak9SS21OWTBxb0JGaVE3dUN1MVJSeUpVd1l0R0FyZ2o0dFFnK2RuQ0hVMmNk?=
 =?utf-8?B?NEx0b2h3aGpPTXdFbUltK1hoTnRnZVlHaHM4K0xMaVM5cXNWbC8vU1VvOVpX?=
 =?utf-8?B?R2xwcDRONVF2SURMRnZqWjlmSDRPMmR3dHRHdkNialF5eURIOU80OGxHS0Yz?=
 =?utf-8?B?OUhlaWxXZitEeWFPTGhyMEREam8ycjkzVmtXTy9EbzJUWEJ6Sk05VWh1Sko1?=
 =?utf-8?B?MW5LcFNOQUJMZ0ZHQXFJajgzc2NKeDJJYnRvYzlWVjNSQTlIcGN5aTBLZlVL?=
 =?utf-8?B?VWRaQlhLWmtacHdEeGZraFNWcVFsMDRRNHVzejZGUlBNYmVja0Zjbi95dmtV?=
 =?utf-8?B?ck9WR1N1Q01tZU9TaHBKd0tCS2VZTnBidmVNaTNiQkIzVmpHOGQ0Qmd0RHA4?=
 =?utf-8?B?amUvYjhGbWQyOTk3d2ZRVk5pTzh2RDZnSldkRWhCcGQvdUNzNVBkNUlRSmM4?=
 =?utf-8?B?U1JJVWYrZXhEc3VjVDZ2T0JIdjV0KzRaU3JuYTlZSVBFd0R3cmVnR2pkZmN1?=
 =?utf-8?B?R28zUTF3OUhWMDFHS05CUGhaRHNIR2hZMUJ1V2pjbkl5ZGdCQkUwdTNxUHVk?=
 =?utf-8?B?ZmtabmdDeXZ0OUVpOHo2VDRPWVRPMnBQc1V2SVVHRXBHSHZMbEdObmpvZXdB?=
 =?utf-8?B?THBnRHJndGJXaVozYTFrM0xkd0Jtb0o1eW83RVhZdGllcUUrUTBRdk1RL2s2?=
 =?utf-8?B?NXdDQjZFZEtkTUZ5V1EwSlhnQXZrelBoa1k5eEo4VFc4YWJJQjNxUWdYWG9h?=
 =?utf-8?B?bjJQWWFRcitjMEZFakxiTENXR3BSYU42RlBMQmxhend2ejQzb1dCVXg3V1lO?=
 =?utf-8?B?RnlWRmh1QTg5bGtwa3pjVGwwYmIzY0EzK0pyS2lxVldBTG9YMzhIM211bFJs?=
 =?utf-8?B?WFRaMXRiQTNvaURDcWw0WWlHTUJoQ2FKMkpZU0JvM0paVjNzaTJVSDBma1U1?=
 =?utf-8?B?V2dYZWtsVjM4aDExMU9VL1MwZGJ4a3ZQbzJyaDRZY2d4MXRBNERlWFVBUHpX?=
 =?utf-8?B?OU4xYmNYTU5qZUw2WEF6WkV2VlZLbzBjYUxPNVc3WjIyMEJSaHlCQzRTVmFt?=
 =?utf-8?B?MEYvUGUrTjZDRk44b1ozdzN2bElMUDFabjZpTmVtcWt5eHBNMkpLSVdOUmVy?=
 =?utf-8?B?WDFWdFRlL09pUDg2b2Uwd2laZUtUN0g4RTFhMCtSRW5tU0hQMERZZjhWZmdk?=
 =?utf-8?B?WDRCVk4zZlJaSDdBbm1venJ4ZEU4elNOZFEyZ1ZGMUZESTg1ZDV0YXorMjVn?=
 =?utf-8?B?Q3BxdlFRZVVKMVBPQ3R2RHJkZkZoY2ttaVR0SExvWVFNaytzKzR1eE5OL3h1?=
 =?utf-8?B?WUo0WDhRRXQxd1pjUkNZa3VicFExa0U0UnFUZGxnRkpINElGelZTS05KVlRJ?=
 =?utf-8?B?MncrblFYU0ZiQkNvK2dCVTcyVVBObmhZanV2S0RLT1FSWG1TcHhRaWZrckhG?=
 =?utf-8?B?d1IyS0ZVWFpHdXE4ZWFjbFlaeEVxY2U1YUllamhSbS9NYzJnODlwZkZYVjdX?=
 =?utf-8?B?enFaUHR2Rkh0cEdHdU90dGlPeHVXU2dKT0x4SnVJQ0xlbGIwc0p0dmc0UXBp?=
 =?utf-8?B?N2FNK1duRDdIT3lsUWVQNC83Y0x4UW9XYXA0RTFnV24wdFlXSkRsN0w1ck1O?=
 =?utf-8?B?ZGJ6ZitwMThCV2plTGlEV0JBemYxVmllSTBnOFlPZHc0aG1KZ25tdXhvNkJm?=
 =?utf-8?B?RDN2M3RjREZPaUYzZUpZVjVQOERqd2Zac0VXM3FKYWpmSmNEQ0taNGVFTjYz?=
 =?utf-8?B?RGdGc2paNllUZ2dvUkpESGVGajdacmdqRG1SNGhleFl1SnVWZ0ZkSDVvd3Jx?=
 =?utf-8?B?cnVvUkt6eVlvMkdtL04wS3U1Vi96SzBLM1A4clova3NrZTR5WlUzMjBsNXh1?=
 =?utf-8?B?eEZ2Z284L3g5Ly93RXVuTFlRTmpWSmpldzMrWGhyZXk4aFZrNHliSTMrZmtD?=
 =?utf-8?B?ekl4NzIyU21GM3FGSU1VRVlESHBOWHQ5amxyekVsTmNQeWRJV3hsRE90SnZV?=
 =?utf-8?Q?3EhpcukOvDR1wXmqQcAX3uwzt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBDCF2A41D00434F98F788938DAA7DD8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7yPHcZFENsxXlk8bNumJxTH8Tghh2y3Rl03/y9cVYPJ3M3t+SqlBH9mu8nM1fDB4osmyaNcjinCC7CVdnFYIhIv3Wos3hDO5eQJWhkZcGjyksuXZ1/NL0GyDuRfKX39IgS/lmYztbOaIwvFHU/XIqDywTLHZT4xOUkSqQmBajNn0f9PluCn7kWMDdO34OSgnhvFApWK4NIrIwizek1fuXR+tApeARoBrc97xJzG/Uv01eiA+g9IAVvdoPC6ahmA8+NeucKAe/601NksSc06YuFIuSi7EfsEpXhFA1ln5skT/tHR9MOYE9SqOTPA/D0eoc/84ckX+fx5xAggjZbWSvSr9gBnMPgA6gWy+KdCqrKgOBRpQCbqCilrnU/DZx3tGtj8qI6++daxLyH925sQVjst5Ryp1yM48re7bxEtEHvGGuJbH6k1dLwdoKw0f57l/ecigy+AKFOMNJI7EFyYSm6JV8XqvUya71OZcIXZPr6B6+Z3E+qUbrYrMnHUHCWcRLKHgPhL3npwiovw9qA/d4vWTE55ocaEuf2YbVfibMYwOp2oeKJZ3mu6ctQ5yvacfW/UhUBCyU/aVNZFxaBx6IFgI0HpQdyLp01lUZV0WrGaP85ynOi/xFp5TRgBAtznOY9mzYS9qT40YqHs+K2PlPw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a465b8e-4005-4d3d-74bc-08ddd477d23c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 23:28:44.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anbvhqric+24NJ83OzMftYXfuYLw+oACgBkLO4RjAxMS+KzWcnr4n2bIK1u0ixH4ySbuv9RT79+X2ZZJbjYC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfXxlCEj8pUdU/4
 KiCx+DY8zmySl4lBWLLhMsKNjAGmR/sQ+jnECjC5H/pMLu0HYbG+IFPiIGh1ArpxxIxwqGwsklh
 c97okl5TP54UD1LLQ6zulbhc0urX5NRoHwW1bwexyifNt/3IYICXGFyWr1c36sI6Jd7+7nX+spL
 gAKzq/PY21bPEA1WN7nzt4iLtESiPs7NGpxV4E1c5VDRxr8WQX1x7Ik/tJYWWBl5j75aJqzv1Yi
 0aaByX64IqW4f77yOPIqjRooYuNB3ZOkFb7Ic9dFvFvKv3I6pvmhHG51JvFoE0mJZnqj2dHISms
 IuYcWQa7Crz/8MOwujh7h90k8At2UCoQpWbNAUh96tJx0C3qaYVkGQTpJUr7IntC0VeKorQRff7
 v8lXluma
X-Proofpoint-ORIG-GUID: QF2gUOlTCDoLw42VJZh-2eJHlnjHQIQb
X-Authority-Analysis: v=2.4 cv=cI/gskeN c=1 sm=1 tr=0 ts=689293b1 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=RXhgSOCzYp4nN75w9_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QF2gUOlTCDoLw42VJZh-2eJHlnjHQIQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508050127

T24gVHVlLCBBdWcgMDUsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IER1cmluZyBhIGRl
dmljZS1pbml0aWF0ZWQgZGlzY29ubmVjdCwgdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIHJlc2V0
cw0KPiB0aGUgZXZlbnQgZmlsdGVyLCBhbGxvd2luZyBhIG5ldyB4ZmVyTm90UmVhZHkgZXZlbnQg
dG8gYmUgZ2VuZXJhdGVkDQo+IGJlZm9yZSB0aGUgY29udHJvbGxlciBpcyBmdWxseSBoYWx0ZWQu
IFByb2Nlc3NpbmcgdGhpcyBsYXRlIGV2ZW50DQo+IGluY29ycmVjdGx5IHRyaWdnZXJzIGEgU3Rh
cnQgVHJhbnNmZXIsIHdoaWNoIHByZXZlbnRzIHRoZSBjb250cm9sbGVyDQo+IGZyb20gaGFsdGlu
ZyBhbmQgcmVzdWx0cyBpbiBhIERTVFMuREVWQ1RMSExUIGJpdCBwb2xsaW5nIHRpbWVvdXQuDQo+
IA0KPiBJZ25vcmUgdGhlIGxhdGUgeGZlck5vdFJlYWR5IGV2ZW50IGlmIHRoZSBjb250cm9sbGVy
IGlzIGFscmVhZHkgaW4gYQ0KPiBkaXNjb25uZWN0ZWQgc3RhdGUuDQo+IA0KPiBGaXhlczogOGY2
MDhlOGFiNjI4ICgidXNiOiBkd2MzOiBnYWRnZXQ6IHJlbW92ZSB1bm5lY2Vzc2FyeSAnZHdjJyBw
YXJhbWV0ZXIiKQ0KDQpUaGUgRml4ZXMgc2hvdWxkIHRhcmdldCBzaW5jZSB0aGUgYmVnaW5uaW5n
IG9mIHRoZSBkcml2ZXI6DQo3MjI0NmRhNDBmMzcgKCJ1c2I6IEludHJvZHVjZSBEZXNpZ25XYXJl
IFVTQjMgRFJEIERyaXZlciIpDQoNCj4gQ2M6IHN0YWJsZSA8c3RhYmxlQGtlcm5lbC5vcmc+DQo+
IFNpZ25lZC1vZmYtYnk6IEt1ZW4tSGFuIFRzYWkgPGtodHNhaUBnb29nbGUuY29tPg0KPiAtLS0N
Cj4gVHJhY2luZzoNCj4gDQo+ICMgU3RvcCBhY3RpdmUgdHJhbnNmZXJzIGJ5IHNlbmRpbmcgRW5k
IFRyYW5zZmVyIGNvbW1hbmRzDQo+IGR3YzNfZ2FkZ2V0X2VwX2NtZDogZXAxb3V0OiBjbWQgJ0Vu
ZCBUcmFuc2ZlcicgWzIwZDA4XSBwYXJhbXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+
IHN0YXR1czogU3VjY2Vzc2Z1bA0KPiBkd2MzX2dhZGdldF9lcF9jbWQ6IGVwMWluOiBjbWQgJ0Vu
ZCBUcmFuc2ZlcicgWzQwZDA4XSBwYXJhbXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+
IHN0YXR1czogU3VjY2Vzc2Z1bA0KPiAgLi4uDQo+ICMgUmVjaWV2ZSBhbiB4ZmVyTm90UmVhZHkg
ZXZlbnQgb24gYW4gSVNPQyBJTiBlbmRwb2ludA0KPiBkd2MzX2V2ZW50OiBldmVudCAoMzVkMDEw
YzYpOiBlcDFpbjogVHJhbnNmZXIgTm90IFJlYWR5IFswMDAwMzVkMF0gKE5vdCBBY3RpdmUpDQo+
IGR3YzNfZ2FkZ2V0X2VwX2NtZDogZXAxaW46IGNtZCAnU3RhcnQgVHJhbnNmZXInIFszNWQ2MDQw
Nl0gcGFyYW1zIDAwMDAwMDAwIGZmZmZiNjIwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3Nm
dWwNCj4gZHdjM19nYWRnZXRfZXBfY21kOiBlcDJpbjogY21kICdFbmQgVHJhbnNmZXInIFszMGQw
OF0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFRpbWVkIE91
dA0KPiAgLi4uDQo+ICMgU3RhcnQgcG9sbGluZyBEU1RTLkRFVkNUUkxITFQNCj4gZHdjM19nYWRn
ZXRfcnVuX3N0b3A6IHN0YXJ0IHBvbGxpbmcgRFdDM19EU1RTX0RFVkNUUkxITFQNCj4gIC4uLg0K
PiAjIEhBTFQgdGltZW91dCBhbmQgcHJpbnQgb3V0IHRoZSBlbmRwb2ludCBzdGF0dXMgZm9yIGRl
YnVnZ2luZw0KPiBkd2MzX2dhZGdldF9ydW5fc3RvcDogZmluaXNoIHBvbGxpbmcgRFdDM19EU1RT
X0RFVkNUUkxITFQsIGlzX29uPTAsIHJlZz0wDQo+IGR3YzNfZ2FkZ2V0X2VwX3N0YXR1czogZXAx
b3V0OiBtcHMgMTAyNC8yNzY1IHN0cmVhbXMgMTYgYnVyc3QgNSByaW5nIDY0LzU2IGZsYWdzIEU6
c3dicDo+DQo+IGR3YzNfZ2FkZ2V0X2VwX3N0YXR1czogZXAxaW46IG1wcyAxMDI0LzEwMjQgc3Ry
ZWFtcyAxNiBidXJzdCAyIHJpbmcgMjEvNjQgZmxhZ3MgRTpzd0JwOjwNCj4gZHdjM19nYWRnZXRf
ZXBfc3RhdHVzOiBlcDJvdXQ6IG1wcyAxMDI0LzI3NjUgc3RyZWFtcyAxNiBidXJzdCA1IHJpbmcg
NTYvNDggZmxhZ3MgZTpzd2JwOj4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IHwgOSArKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiBpbmRleCAyNWRiMzZjNjM5NTEuLmFkODljYmVlYTc2MSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+IEBAIC0zNzc3LDYgKzM3NzcsMTUgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRn
ZXRfZW5kcG9pbnRfdHJhbnNmZXJfY29tcGxldGUoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4gIHN0
YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYW5zZmVyX25vdF9yZWFkeShzdHJ1Y3Qg
ZHdjM19lcCAqZGVwLA0KPiAgCQljb25zdCBzdHJ1Y3QgZHdjM19ldmVudF9kZXBldnQgKmV2ZW50
KQ0KPiAgew0KPiArCS8qDQo+ICsJICogRHVyaW5nIGEgZGV2aWNlLWluaXRpYXRlZCBkaXNjb25u
ZWN0LCBhIGxhdGUgeGZlck5vdFJlYWR5IGV2ZW50IGNhbg0KPiArCSAqIGJlIGdlbmVyYXRlZCBh
ZnRlciB0aGUgRW5kIFRyYW5zZmVyIGNvbW1hbmQgcmVzZXRzIHRoZSBldmVudCBmaWx0ZXIsDQo+
ICsJICogYnV0IGJlZm9yZSB0aGUgY29udHJvbGxlciBpcyBoYWx0ZWQuIElnbm9yZSBpdCB0byBw
cmV2ZW50IGEgbmV3DQo+ICsJICogdHJhbnNmZXIgZnJvbSBzdGFydGluZy4NCj4gKwkgKi8NCj4g
KwlpZiAoZGVwLT5kd2MtPmNvbm5lY3RlZCkNCg0KRGlkIHlvdSB0ZXN0IHRoaXM/IFRoaXMgaXMg
c3VwcG9zZWQgdG8gYmUgaWYgKCFkZXAtPmR3Yy0+Y29ubmVjdGVkKQ0KcmlnaHQ/DQoNCkJSLA0K
VGhpbmgNCg0KPiArCQlyZXR1cm47DQo+ICsNCj4gIAlkd2MzX2dhZGdldF9lbmRwb2ludF9mcmFt
ZV9mcm9tX2V2ZW50KGRlcCwgZXZlbnQpOw0KPiANCj4gIAkvKg0KPiAtLQ0KPiAyLjUwLjEuNTY1
LmdjMzJjZDE0ODNiLWdvb2cNCj4g

