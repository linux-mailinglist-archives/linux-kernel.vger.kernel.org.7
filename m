Return-Path: <linux-kernel+bounces-889576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D387C3DF20
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE573A7CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BA19CD1D;
	Fri,  7 Nov 2025 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kzP7SpQE";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eza/oCcy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UMoM1yro"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F338F80;
	Fri,  7 Nov 2025 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474052; cv=fail; b=texxcyEAR08FxrZWeaSc1n7eRlgX63gjfx/EhkAT6WbUMNrRs+MgMQ+aZ6TdjZSigdbxddRZAu+ZjS4ZVi7thGABm4XSrtaFCg7k47khfdVijbneYpvdloUD2i9PKlBT8P8Ysecsm5hEEkLMrmBV+8QO718fbBtV8VAIqxqIDnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474052; c=relaxed/simple;
	bh=SD32Az4M/oICpE3TRsIx3/3EN5Cl45M4YcfU97N1CTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJ+DnpGQGF9yyA7iQcGUDrkSInk2sRDs+2jtAQvEZ0ZFfelrHKhbTk+pVHzR83JW6H0jcAyZQ4DJNHL3Gcep1lb48hvHoH/WxwjN19vT1UUSQEgFyaY70sO6urP964n/NtSId67grAMsSzRodd6BWwBFjUCpWktUWfsB30IMT8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kzP7SpQE; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eza/oCcy; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UMoM1yro reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6Mb8tm3820572;
	Thu, 6 Nov 2025 16:07:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=SD32Az4M/oICpE3TRsIx3/3EN5Cl45M4YcfU97N1CTw=; b=
	kzP7SpQEEPpA39okuMPDXeyAeL8FBeODGzSE11w/p3DED7GtWCCTum4pu6pLyy/K
	adr3GXg8yCXXbRtnEkmsGM/9bDHxULgbE+mLtC38TWgdgpeXE61vhTvr5rwQDkzK
	9dzq/WR5pCLF2oCTAE5CZwiWo4QzMNHjVlRSGo/LJ8U0zZn61vehjyjwtWyUboPK
	j3OA6j77Cl7kkHptbVfynQKdwp/ubwVXOgm3bGmoVdafkDYwWsdOhULk7WwilGUJ
	xKvfL17u60WGUfCwrQ9+/W/2DZDlOLOdxDo3/6wVYhOxciP6QBJTjHeB89DVzRtT
	azYoH/SqgYeyRwTNxgmI2Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4a8x2utcd2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1762474026; bh=SD32Az4M/oICpE3TRsIx3/3EN5Cl45M4YcfU97N1CTw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eza/oCcyvD9Lg7aGLf5YqSjC2BPl3g+2GiKiRuteiPHEBE1DTNYykqzs4v5Be256s
	 KCvYlbyr4aqzNp2CYMv98WoVzc0+jyUBq3IPuTLWAsEvVnR90eR7Pp6mVM6rHkGMUf
	 lqg8NogWUIQapnSB51gaOeOw8E+5xQ4aUaEnWgCMjJzWT8XipcSf1MTq7gd0hAqA+m
	 WNG0mYUOAbrLrIvaUrFg/IPC8jo7+VWzdG+u9qFt5kXjfmKnqSTd4mLI3wkuSnEF7I
	 DdpIJKSuEQnTQOP0EU/9eSw4PytZ6/imiI0FZg40qCf+Q8u2+Im8hpaR1V97i58WoY
	 GiGDYCj8jTbig==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F215540409;
	Fri,  7 Nov 2025 00:07:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 51ECDA00BE;
	Fri,  7 Nov 2025 00:07:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UMoM1yro;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00103.outbound.protection.outlook.com [40.93.13.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 53ED740588;
	Fri,  7 Nov 2025 00:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBqglHm6xGbKJc0REIMNuY+Wzf6PPvZDJD+UOKw4uZ/qGeKChkdE5wdUGBA9/pDLv/ZaiUFCy3Qw2l7u3rmsvhck2MtedX0oQmPBScMsN/22TpexDc2zbCEXdkfwZ4tUKYgh8y/engH45ajMwiMYCyVHfTFNg9ytBp2Mze4IEQnFxKYfXp6+JGVqtofv0js+LopL10zziflVfpC5trMwvJx6u5+tydmQak3AygkzlDPgSHJ2SbK5YLXC54j4uM+KrJfyp2f652Pa0gk8dR1MEQBa0E41YDf19hjT5G1i53SYELprzO4qaZNYqqAnSXJ24uiHiTrtariOpQnBOh/7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD32Az4M/oICpE3TRsIx3/3EN5Cl45M4YcfU97N1CTw=;
 b=DqWfLhC0xsPiRCK6dp+gFlCKYx5XxW80dFmAgb8EJt0Frlr5dCSZOPvDcEIp2KUhhk3/L6mpt4k9VTqJdXyFJRtCOMXi1hYaBbjf+RK3vMsmdI/qKl2ix5LtX+wMjXlQV6gZB66T037ViPOzCirwkhsRLDlkboDS4sqCY/3OLTg0IvbYF8LsTkucwrpkC+iDIo793snEVAbePFpXDC/3biF3FGUduks8tIKrfKRSQNCp35mVytP1rWGSzrIBtociW9rLc76NE3bFTqCW+DOqlXj2z0sLNDLLQ6qDRAetCmYlv5hRkoEs80eO2UFDS5GpcKBZ9PH6+TzsztVsHajLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD32Az4M/oICpE3TRsIx3/3EN5Cl45M4YcfU97N1CTw=;
 b=UMoM1yroS1Cew+mJ5NWP9J7Jf6w9nkM6+1UKcDoL8WObl1oxAqh6AFGJmC28suY/kPeD9MHePnFIXWRNuz7NaGn0lg8KeLMk+W4gndlVaOyXjN7Hmo/i6dRj22jBOFh/Xge9Qc1VCAW/7xiNAoFNBxd6YWIQdM46RtMrvhnfZhE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 00:07:00 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 00:07:00 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "caohang@eswincomputing.com" <caohang@eswincomputing.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ningyu@eswincomputing.com" <ningyu@eswincomputing.com>,
        "linmin@eswincomputing.com" <linmin@eswincomputing.com>,
        "pinkesh.vaghela@einfochips.com" <pinkesh.vaghela@einfochips.com>,
        Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v6 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Topic: [PATCH v6 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Index: AQHcTwtYUGe6Kqcam022/Zr9bDCNTLTmVsAA
Date: Fri, 7 Nov 2025 00:07:00 +0000
Message-ID: <20251107000652.izkboljiodbjyvyc@synopsys.com>
References: <20251106104938.1386-1-caohang@eswincomputing.com>
 <20251106105114.1417-1-caohang@eswincomputing.com>
In-Reply-To: <20251106105114.1417-1-caohang@eswincomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB8128:EE_
x-ms-office365-filtering-correlation-id: 1de99a7f-82d7-471c-1380-08de1d9192b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?djNhQ1dpQ0JkREpvQm1aUGEweCtpWkFBdmsyakEvSFNnQnlhWmZIZmFub1FO?=
 =?utf-8?B?bjRxaUU2V2hXakhRK2xFWlBFUDU0SzhwUHBKTjl4YncxWHNyQnVMaHBLK3dJ?=
 =?utf-8?B?bzlaZG11TjlxZlNPK1p4ckZrSFlIWnhWRmhGS1M4L1FxekdHVGdGQUZJWUJO?=
 =?utf-8?B?eWZSWnBBMVlISVY2cDQvdnVEVGVQSTY1M1lWZ0o2S2wwN3NwcHVqZVYvMnNu?=
 =?utf-8?B?RjhEQk1iQ20zWEhtTkpGZDF2V0R2RC9vQlFPU0RrdmtJV0x3ZTg5d2RrY2hR?=
 =?utf-8?B?cDBWTkdCTll2N1ZRSlRYNWhOaVBNaXAyU1VJOHU0UEtHZ2tWRnhJbm5uQm1E?=
 =?utf-8?B?bUpJNytuL3E5QlM0b05URlY2WEk2bnNaWUxhUlNSQ3FTaXJGOGVwU3NoRGk5?=
 =?utf-8?B?QUdwenNkZjcxcThNQ0tOaW54Yk1zR1BydGM1TE1oaDVaN2FseHp1S2pqbE5S?=
 =?utf-8?B?RmpHcllMays2NjVBdnYyZXNvNGxkemt4bzRtMTBBSHBlemlpMXZneHVMN0x5?=
 =?utf-8?B?MDQxOHdGSm91eEJSOU52ajhYT0tQcmxtMHZHUDh4UGxCS2I2bkxGMWcwRlRL?=
 =?utf-8?B?QXkyVHFRMFB5K0pYa3FmZUdqUDlCNE40MlVuWXU4NmtHWGtMem4rUHdCaHdz?=
 =?utf-8?B?d25OYUZQQXJqM2hwMEhNUGJxQkprZGNPeDRKWTZrQ1VwY1hKZFhldG5XbFRT?=
 =?utf-8?B?NXVzZExpTnpwbFBqY3ZTOWdYWDZ5Sjc5VlV1TUo5MEhiRlM2RFM4VE42Q2ZJ?=
 =?utf-8?B?ZTdVeVZMdUV4K2xjT1JFRHhpY2pnc1JacktJZVgxMEEyd1FyQlRGd0k0RFJM?=
 =?utf-8?B?QTRzNG02L1hQVVluWXhlRVhyWS9UU3JZMU9kcHNaeDNTWkNWV2pxdG5CRXlB?=
 =?utf-8?B?SlRpRUJPV2loYmQ0bGFzVUhtZ0U2amJBRFBEbEVRNlExQ0RaNkU1Skw1K1pi?=
 =?utf-8?B?SFRnZExuZEU4SFlVcUtIYUVoVW4vNVg4eU01TmM2bVRUT0JSZThsSmRSYWgv?=
 =?utf-8?B?eDBlNFFqQ0FmVjNMVFhZWUp5TFpDMjA3SU9mcjVtT0ZFZmY4M3lvM05hN3J5?=
 =?utf-8?B?K3AxZUFBUUtTeXA0U0o1cEhSMzZiUmVGVXQraFA1Q081dkZZbUpjR0xGQyt4?=
 =?utf-8?B?L1d3YTFGWEYwc1VJMW0yQlM0WW52ZW9MSDZtam02M2Y4WXJQK2c5TWlmTzVY?=
 =?utf-8?B?NjF3OUgzbEg0Qnlqak9MUWRVemtuR0NIcVZYaDNHSklPSnVnSCtQTDAyaG1j?=
 =?utf-8?B?eldmVWRWcitwTzBYREp2TDBEVU02T0x1cVAvOGM1S1R4UWR5blV5MHFNdDQ0?=
 =?utf-8?B?bFRRUzJQZDdScFR0a3I2ZlY4cGxhamdtOW1kMVNXV2R1SlBodW1mOE5XdUtT?=
 =?utf-8?B?WGoySjhRdUZsT3FiaFh0a3VjWjJQQU1yOTVYeDlackF2TWsySGltL0RTc21x?=
 =?utf-8?B?ZCtucUlGbDB3bDhUUlF4TXd6Y3l1MkE3c0hrR1JXcFVWR3MzeW5SWnRVam1L?=
 =?utf-8?B?R2llZzlIOVhSQjIxTFNERmNDS2NMMmR2Z1NldEI3OG9LdkdPcUx3MnEwMVZN?=
 =?utf-8?B?N0VjL29PaWhUcDJKZHFRNFRWYVI5STl2eWZEL1dNbG82N1JOaVVqVURReG9Y?=
 =?utf-8?B?SUpUcEZ1RC9MNFIwNkJDUEs3N25Va2hIYldzcDc2OHlhTHhYMUpkeVYzeHhD?=
 =?utf-8?B?ekx3RGs1M0NYMFBsWDNLcVZ4ckxQdHBPQzlvZ3FpU1RwZXYyK2tSd0VCeTdv?=
 =?utf-8?B?TU4rcEhIZzdpWnMwOTh5cTl3NCtmTk83RVpBRGoxZE1uM2tSVlRBREExbFYw?=
 =?utf-8?B?YkJ1djRTVjlKTDlDMmNuTnYzT0N3YXhOOFVWSXZMeWxsUmpNYWFxaWdoNG83?=
 =?utf-8?B?WE9pODNMZUNENnlQdFRtdlhPQ2IwUUF2OW1uck5DYzVOQlhxN1pMejZCdyto?=
 =?utf-8?B?U2xNVEgyekF0a0lPMmp4S1k1YWcvbFlIWmw5bG1mRXJkM3prK29EQThhV1RL?=
 =?utf-8?B?aTBpNXpxU3JNcFBGVzdQSTI0TWdMVUNWeWE3dEc4YzhRNGh3RllGY09nNEpo?=
 =?utf-8?Q?40G5hF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG12VUlpTGVUaUpNMEFGS0I0S2pkc25LUTJqTFRoNmFMSDNpRCtHVTBvMTlh?=
 =?utf-8?B?TGhqY09zOHVaQU5MMkExVVJCUEtJRStwRGV6MXdUWE1CQUs4Nnd0bytuSUdB?=
 =?utf-8?B?cXFFUFZkTlIyYkV5eU8wTEdyMVlvazZJV3FpcnhaWDVyZUNXLzJmSXpKeFhD?=
 =?utf-8?B?aXpTUkZ5VXJCeUF3TCtnTTcwR0RnY0JUY29iOEVoMHBVZW5tekR5VERBeUpT?=
 =?utf-8?B?cVlCbUp6UUp5eUZnSTJzRG0vSHRtazU0QS93emRVSDQ5SjQxYTFPSitBU2ov?=
 =?utf-8?B?S1E2L3RBMFR0bXdTd05OdUVFRTBESjBSQUtkOVkyMDNCZ3JqcGwvMkdoS01Y?=
 =?utf-8?B?YjM0d0c5T2lWNnZFY1JWTXRSdUlFRHdLQmwrSGVyQUJtV1didk5yaTNxK0lH?=
 =?utf-8?B?MTdwRGd2RkdsQ0cvOHk3a3pqYXJkc3hmYWdndmdIVzZ3NHlRemRiWjY1U0Yy?=
 =?utf-8?B?dXdJamV3QW83aHNGRmlsSWlIdk1sbmtqV1NOT0M0UEpxSGZWZlMrVTBHVU5H?=
 =?utf-8?B?WkwrYjltWjg0RGhsdDZEZHFZcC9aWXh6RG9NUFYxS3h4enI5MTN3cFR5S2Fi?=
 =?utf-8?B?RFRLdDBzbzREUXNOTTk2dzVmWDRPWHJhakZGUUl4R1M3RjJBT245TjlaK3ox?=
 =?utf-8?B?RU9VREd3RE03Sjk3SFRnQmV1cC9iUUhLS1JPVzd5dlJxMjhJUGJFYjVnZ2hG?=
 =?utf-8?B?ajhBMEhQNHlybjFJVDJ4MEc1ajRaRVhYVktoalRxTVdBdlBhc1hQNHNiZlgv?=
 =?utf-8?B?a200c09jQ0s0UHM2ZTZ4RFYxTWVxaTUyM3lIdEcxOVp4d1BiQVMwQmV1dld5?=
 =?utf-8?B?Z0F6TkVxT0VmWm1zOFpudnhYQ214RG8wZkhmQitRMDMvR2pKN2w3bzFMZ09C?=
 =?utf-8?B?UXJlUERCV3BGQ2JoanpzVXJMb3hXYVJINmhUQTFVTmFabXJCL0FCNjVzR2VT?=
 =?utf-8?B?OVY4U3pUbk9sQWZyN2w0Qkx2eXpVeW5CcHkzcmUxZmtkdzF2Y3pSUXFrYjRs?=
 =?utf-8?B?M1dKYzVqL1pSc2szWXUvcThXSFpJQzUzVnJTN2w4ZjQyR0dCODJmS0dLNzF6?=
 =?utf-8?B?OUhvajFqSkpta0xiMzh6NFdmbExPRUxzNDBmUk1FMnJkVTJvU3JEY1lGUHNu?=
 =?utf-8?B?a2d1NnphZGRRSU8rVTRpOUpGVE1WbytGbysrSGFSWHFZdXJSaXZDUnJ0dGlq?=
 =?utf-8?B?bVpSbmFLcS9wdXVQM1o1QUZVTlZNaVRhYkZ6QmhIY3BrYmY0UFVUTnJ3eTBu?=
 =?utf-8?B?Y3BSemhHcUFyQitwWTZMVWk4dm4xbDRmYTlhdytGM3NBM3dOYXFVVGs4SnA1?=
 =?utf-8?B?WHFyU3pZYWNHbTcrOGpZRUV1V3grc1luaEN2U0dYaTc1bitpQVJ5ajBld2Rk?=
 =?utf-8?B?NnJyUjR5Z2svV0ZaMHRuY2xuNCtEZDhIZFhpeitOdWJMOVBFbzVKY25pd2Ur?=
 =?utf-8?B?N0JxcE5QTWMxSjNOTEpHUFBYSllSejNndnRuallxU2R6WklVT2ZWUFQwKy96?=
 =?utf-8?B?NDIvVzlRQUtsaFlwVTFNcDlWcitZZ1h4dmE1QTVENjNTVy9UUG5vbSsydCtO?=
 =?utf-8?B?dVpjcjM5c3dkZ0RzSEd1QWhOUklJQUhkVElKMkNyRU5mRm8rRndBaDRBZ3Aw?=
 =?utf-8?B?ei9jbkFWR1RHK2djT1lCS0FsWkFkL3BmMUZMUnYydXh5YTJPOVVpZG0xUG81?=
 =?utf-8?B?bS91aVBXOUdDdmdMWXdOSm13bUhEbGxzK3R3M0htTEhFRytxQ01XOGs0cFJ4?=
 =?utf-8?B?WjhZanEzMXVUVGJ0ajNyakJGcTVlSHhQT2pFTmgyaUN5WFg3ZGl2OGdBT2NM?=
 =?utf-8?B?Smxsai9yVnNIa2RzOUtzZHFjWGp2Y2VMSGhYajBtR2YyODBYemtMUmFJOTZL?=
 =?utf-8?B?RzFCUFMvTUd2aUF2ZnpsT0VRZVhucWNvSm1KZ3JEQ3lyYkh4YS9JKyt3b0Zj?=
 =?utf-8?B?dnAzSnRCOEVZN09Fb2E0ZkNqem9LR290b0Y3Mmo4QWduWVBZRUtST1JoMUpC?=
 =?utf-8?B?c29qMDZKMjNsMElLYXplSytZa00ybVNkZzZOK2VrUWhQc20xb2VQOHpGZnZH?=
 =?utf-8?B?VWE5eEorRG9FcUtoSGZod1NmcUdNdzJ1bWN4UFlpdmtKM0E0NXBJNnFqbHlp?=
 =?utf-8?Q?P5t1sxzZpnugox5ARlGyyeVnw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2EF20AA15D5EE4D8C0BA060541D995E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8oM2Q0Vyxc2aUiZepY+JBe0jW9B/656Yd0iKLTK50OEXwKBdSLhihmj4JdB8U6b7cTA1GWTBVKA8dt6/1kf/lTxOFzvgtBs0CLWbvjsEKRcllyNeKx3Wy1+TDswD1kDqcKnna9xe9v2UNBjaL00MR1zWNDzm0bPRrOiWZmaXxCfsuWkaEH9VplQ+cN7kgxsulf0qo3yx+FkK2rXyJTIX/Q4VRhPgcFeN4Mh+zZUs2pmTc0NlvoqR/UDpMfU+thNO4mwr+gF5phzl94JyqlK9neSRPfIY/r1O5jBZkimeVTx9EX9n9QqpvROdEda4WrAqHzzsNL5QJOZAN5YQhYM0wuKvMAsaJWLqGCF/KKBwnM+4nM8vmeAQBmDc6kgwmTUkqKuICxGABNOy1MWOmldIt1aE47krsh1gxrgvOdotqLWqrz+V6N3SFeiuMvHsTA4mIXZ+KUuVYyTZDvo+6CvEVwOAQfsgueSbnR96Ybh7Gx46dHNNXfzwmSKy1LOtlfiL5yGe/BeUw8362uhsNt/q3Dhp686+hOYwGkdJIxMmjGBy2ksrWoKWXJ3N9DuAtyHUyimmO/qL1kAe9AClttYYMGD5+HWLQ229csE0zIosDarqHAGlwsq7Qpk/jnC/s+MbUeoS3tseSUXuIb1WX1mhng==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de99a7f-82d7-471c-1380-08de1d9192b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 00:07:00.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuQ/jB+4FHQaYrJlhREJSUYWIPNQHAel+nDLTQ1vda3sV+3B82Bf0jLCo8RgDciL98Z7JlatG2LUsLo/3Y2X4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
X-Proofpoint-ORIG-GUID: -gSDxb84YJ66WYvbCWj9EOgIEJ6Qwx55
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDE5NiBTYWx0ZWRfX74zX8NEWQfvR
 wo0iYbhWyMAAKMef0fMzKzyjIYRNh+5R9PoHL28FCi8kMqqHafD1AZ/1AnZVO6ItEAbRsJAMyw5
 uLi3BG+0LottdjbpG7P2j/g8uVUKkw3j4XLkOmpE1ahfwMP2Y1HSF7tByKjkOJ1RkR5GDQebbJs
 Aad5C9XsYpHWrwtsBa9b1G7Z6TNk4mmMaiBzxLNIo0QSrxeYmLlTUnkuGdSL84xfcBbrZiTkjBg
 iXqaDM2o7F3tXLIFBZfu1ep0ZokIOObmJp0djahin9T2t1uqIpDBxzsRPup3NW3TKEgo4rWvHrE
 9tyYxOYOv9OJjYclyoJ5e5PtkWongTHXBYSTCLAu+eZsA/+nhP8+Nx6Zh/TQ0cTPKHLh6UqKtdp
 ZPMG45BQwx3KsnED0sa17msp5Q2ujg==
X-Authority-Analysis: v=2.4 cv=Qehrf8bv c=1 sm=1 tr=0 ts=690d382b cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=h4SL0BZ7AAAA:8 a=jIQo8A4GAAAA:8
 a=1YDg5Tn6tY68cwKdJxcA:9 a=QEXdDO2ut3YA:10 a=Cfupvnr7wbb3QRzVG_cV:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: -gSDxb84YJ66WYvbCWj9EOgIEJ6Qwx55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060196

T24gVGh1LCBOb3YgMDYsIDIwMjUsIGNhb2hhbmdAZXN3aW5jb21wdXRpbmcuY29tIHdyb3RlOg0K
PiBGcm9tOiBIYW5nIENhbyA8Y2FvaGFuZ0Blc3dpbmNvbXB1dGluZy5jb20+DQo+IA0KPiBUaGUg
RUlDNzcwMCBpbnN0YW50aWF0ZXMgdHdvIFVTQiAzLjAgRFdDMyBJUHMsIGVhY2ggb2Ygd2hpY2gg
aXMgYmFja3dhcmQNCj4gY29tcGF0aWJsZSB3aXRoIFVTQiBpbnRlcmZhY2VzLiBJdCBzdXBwb3J0
cyBTdXBlci1zcGVlZCAoNUdiL3MpLCBEUkQgbW9kZSwNCj4gYW5kIGNvbXBhdGlibGUgd2l0aCB4
SENJIDEuMSwgZXRjLiBFYWNoIG9mIGluc3RhbmNlcyBzdXBwb3J0cyAxNiBlbmRwb2ludHMNCj4g
aW4gZGV2aWNlJ3MgbW9kZSBhbmQgbWF4IDY0IGRldmljZXMgaW4gaG9zdCdzIG1vZGUuDQo+IA0K
PiBUaGlzIG1vZHVsZSBuZWVkcyB0byBpbnRlcmFjdCB3aXRoIHRoZSBOT0MgdmlhIHRoZSBBWEkg
bWFzdGVyIGJ1cywgdGh1cw0KPiByZXF1aXJpbmcgc29tZSBIU1AgY29uZmlndXJhdGlvbiBvcGVy
YXRpb25zIHRvIGFjaGlldmUgdGhpcy4gT3BzIGluY2x1ZGUNCj4gYnVzIGZpbHRlciwgcG0gc2ln
bmFsIG9yIHN0YXR1cyB0byB1c2IgYnVzIGFuZCBzbyBvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNlbmNodWFuIFpoYW5nIDx6aGFuZ3NlbmNodWFuQGVzd2luY29tcHV0aW5nLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogSGFuZyBDYW8gPGNhb2hhbmdAZXN3aW5jb21wdXRpbmcuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYyB8IDcwICsrKysrKysrKysr
KysrKysrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1n
ZW5lcmljLXBsYXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYw0KPiBp
bmRleCBlODY5YzdkZTdiYzguLjRlNTYxMjRlODNjZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9kd2MzLWdlbmVyaWMtcGxhdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1nZW5lcmljLXBsYXQuYw0KPiBAQCAtMTAsOCArMTAsMTYgQEANCj4gICNpbmNsdWRlIDxsaW51
eC9jbGsuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9yZXNldC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gICNpbmNsdWRlICJnbHVlLmgiDQo+IA0KPiAr
I2RlZmluZSBFSUM3NzAwX0hTUF9CVVNfRklMVEVSX0VOCUJJVCgwKQ0KPiArI2RlZmluZSBFSUM3
NzAwX0hTUF9CVVNfQ0xLRU5fR00JQklUKDkpDQo+ICsjZGVmaW5lIEVJQzc3MDBfSFNQX0JVU19D
TEtFTl9HUwlCSVQoMTYpDQo+ICsjZGVmaW5lIEVJQzc3MDBfSFNQX0FYSV9MUF9YTV9DU1lTUkVR
CUJJVCgwKQ0KPiArI2RlZmluZSBFSUM3NzAwX0hTUF9BWElfTFBfWFNfQ1NZU1JFUQlCSVQoMTYp
DQo+ICsNCj4gIHN0cnVjdCBkd2MzX2dlbmVyaWMgew0KPiAgCXN0cnVjdCBkZXZpY2UJCSpkZXY7
DQo+ICAJc3RydWN0IGR3YzMJCWR3YzsNCj4gQEAgLTIwLDYgKzI4LDExIEBAIHN0cnVjdCBkd2Mz
X2dlbmVyaWMgew0KPiAgCXN0cnVjdCByZXNldF9jb250cm9sCSpyZXNldHM7DQo+ICB9Ow0KPiAN
Cj4gK3N0cnVjdCBkd2MzX3BsYXRfY29uZmlnIHsNCg0KSSBmb3Jnb3QgdG8gdXNlIHRoZSAiZ2Vu
ZXJpYyIgcHJlZml4LiBDYW4geW91IGNoYW5nZSB0aGlzIHRvDQpkd2MzX2dlbmVyaWNfY29uZmln
Pw0KDQo+ICsJaW50ICgqaW5pdCkoc3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjM2cpOw0KPiArCXN0
cnVjdCBkd2MzX3Byb3BlcnRpZXMgcHJvcGVydGllczsNCj4gK307DQo+ICsNCj4gICNkZWZpbmUg
dG9fZHdjM19nZW5lcmljKGQpIGNvbnRhaW5lcl9vZigoZCksIHN0cnVjdCBkd2MzX2dlbmVyaWMs
IGR3YykNCj4gDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVzZXRfY29udHJvbF9hc3Nl
cnQodm9pZCAqZGF0YSkNCj4gQEAgLTI3LDkgKzQwLDM4IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2Vu
ZXJpY19yZXNldF9jb250cm9sX2Fzc2VydCh2b2lkICpkYXRhKQ0KPiAgCXJlc2V0X2NvbnRyb2xf
YXNzZXJ0KGRhdGEpOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBpbnQgZHdjM19laWM3NzAwX2luaXQo
c3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjM2cpDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2
ID0gZHdjM2ctPmRldjsNCj4gKwlzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ICsJdTMyIGhzcF91
c2JfYXhpX2xwOw0KPiArCXUzMiBoc3BfdXNiX2J1czsNCj4gKwl1MzIgYXJnc1syXTsNCj4gKwl1
MzIgdmFsOw0KPiArDQo+ICsJcmVnbWFwID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRs
ZV9hcmdzKGRldi0+b2Zfbm9kZSwNCj4gKwkJCQkJCSAgICAgICJlc3dpbixoc3Atc3AtY3NyIiwN
Cj4gKwkJCQkJCSAgICAgIEFSUkFZX1NJWkUoYXJncyksIGFyZ3MpOw0KPiArCWlmIChJU19FUlIo
cmVnbWFwKSkgew0KPiArCQlkZXZfZXJyKGRldiwgIk5vIGhzcC1zcC1jc3IgcGhhbmRsZSBzcGVj
aWZpZWRcbiIpOw0KPiArCQlyZXR1cm4gUFRSX0VSUihyZWdtYXApOw0KPiArCX0NCj4gKw0KPiAr
CWhzcF91c2JfYnVzICAgICAgID0gYXJnc1swXTsNCj4gKwloc3BfdXNiX2F4aV9scCAgICA9IGFy
Z3NbMV07DQo+ICsNCj4gKwlyZWdtYXBfcmVhZChyZWdtYXAsIGhzcF91c2JfYnVzLCAmdmFsKTsN
Cj4gKwlyZWdtYXBfd3JpdGUocmVnbWFwLCBoc3BfdXNiX2J1cywgdmFsIHwgRUlDNzcwMF9IU1Bf
QlVTX0ZJTFRFUl9FTiB8DQo+ICsJCSAgICAgRUlDNzcwMF9IU1BfQlVTX0NMS0VOX0dNIHwgRUlD
NzcwMF9IU1BfQlVTX0NMS0VOX0dTKTsNCj4gKw0KPiArCXJlZ21hcF93cml0ZShyZWdtYXAsIGhz
cF91c2JfYXhpX2xwLCBFSUM3NzAwX0hTUF9BWElfTFBfWE1fQ1NZU1JFUSB8DQo+ICsJCSAgICAg
RUlDNzcwMF9IU1BfQVhJX0xQX1hTX0NTWVNSRVEpOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICBzdGF0aWMgaW50IGR3YzNfZ2VuZXJpY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiAgew0KPiAtCWNvbnN0IHN0cnVjdCBkd2MzX3Byb3BlcnRpZXMgKnByb3BlcnRp
ZXM7DQo+ICsJY29uc3Qgc3RydWN0IGR3YzNfcGxhdF9jb25maWcgKnBsYXRfY29uZmlnOw0KPiAg
CXN0cnVjdCBkd2MzX3Byb2JlX2RhdGEgcHJvYmVfZGF0YSA9IHt9Ow0KPiAgCXN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAJc3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjM2c7DQo+
IEBAIC03NywxMiArMTE5LDIwIEBAIHN0YXRpYyBpbnQgZHdjM19nZW5lcmljX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcHJvYmVfZGF0YS5yZXMgPSByZXM7DQo+ICAJ
cHJvYmVfZGF0YS5pZ25vcmVfY2xvY2tzX2FuZF9yZXNldHMgPSB0cnVlOw0KPiANCj4gLQlwcm9w
ZXJ0aWVzID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+IC0JaWYgKHByb3BlcnRp
ZXMpDQo+IC0JCXByb2JlX2RhdGEucHJvcGVydGllcyA9ICpwcm9wZXJ0aWVzOw0KPiAtCWVsc2UN
Cj4gKwlwbGF0X2NvbmZpZyA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiArCWlm
ICghcGxhdF9jb25maWcpIHsNCj4gIAkJcHJvYmVfZGF0YS5wcm9wZXJ0aWVzID0gRFdDM19ERUZB
VUxUX1BST1BFUlRJRVM7DQo+ICsJCWdvdG8gY29yZV9wcm9iZTsNCj4gKwl9DQo+IA0KPiArCXBy
b2JlX2RhdGEucHJvcGVydGllcyA9IHBsYXRfY29uZmlnLT5wcm9wZXJ0aWVzOw0KPiArCWlmIChw
bGF0X2NvbmZpZy0+aW5pdCkgew0KPiArCQlyZXQgPSBwbGF0X2NvbmZpZy0+aW5pdChkd2MzZyk7
DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgInBs
YXRmb3JtIGluaXQgZmFpbFxuIik7DQoNCkZvciBjb25zaXN0ZW5jeSwgY2FuIHdlIGNoYW5nZSB0
aGUgbWVzc2FnZSB0bzoNCiJmYWlsZWQgdG8gaW5pdCBwbGF0Zm9ybVxuIg0KDQo+ICsJfQ0KPiAr
DQo+ICtjb3JlX3Byb2JlOg0KPiAgCXJldCA9IGR3YzNfY29yZV9wcm9iZSgmcHJvYmVfZGF0YSk7
DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWls
ZWQgdG8gcmVnaXN0ZXIgRFdDMyBDb3JlXG4iKTsNCj4gQEAgLTE1MCwxMyArMjAwLDE5IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2MzX2dlbmVyaWNfZGV2X3BtX29wcyA9IHsN
Cj4gIAkJICAgICAgIGR3YzNfZ2VuZXJpY19ydW50aW1lX2lkbGUpDQo+ICB9Ow0KPiANCj4gLXN0
YXRpYyBjb25zdCBzdHJ1Y3QgZHdjM19wcm9wZXJ0aWVzIGZzbF9sczEwMjhfZHdjMyA9IHsNCj4g
LQkuZ3NidXNjZmcwX3JlcWluZm8gPSAweDIyMjIsDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGR3
YzNfcGxhdF9jb25maWcgZnNsX2xzMTAyOF9kd2MzID0gew0KPiArCS5wcm9wZXJ0aWVzLmdzYnVz
Y2ZnMF9yZXFpbmZvID0gMHgyMjIyLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBkd2MzX3BsYXRfY29uZmlnIGVpYzc3MDBfZHdjMyA9ICB7DQo+ICsJLmluaXQgPSBkd2MzX2Vp
Yzc3MDBfaW5pdCwNCj4gKwkucHJvcGVydGllcyA9IERXQzNfREVGQVVMVF9QUk9QRVJUSUVTLA0K
PiAgfTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBkd2MzX2dlbmVy
aWNfb2ZfbWF0Y2hbXSA9IHsNCj4gIAl7IC5jb21wYXRpYmxlID0gInNwYWNlbWl0LGsxLWR3YzMi
LCB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNsLGxzMTAyOGEtZHdjMyIsICZmc2xfbHMxMDI4
X2R3YzN9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiZXN3aW4sZWljNzcwMC1kd2MzIiwgJmVpYzc3
MDBfZHdjM30sDQo+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgZHdjM19nZW5lcmljX29mX21hdGNoKTsNCj4gLS0NCj4gMi4zNC4xDQo+IA0K
DQpZb3UgY2FuIGFkZCB0aGlzIG9uIHlvdXIgbmV4dCBzdWJtaXNzaW9uOg0KDQpBY2tlZC1ieTog
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGlu
aA==

