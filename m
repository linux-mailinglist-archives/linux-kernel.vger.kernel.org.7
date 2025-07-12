Return-Path: <linux-kernel+bounces-728446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C5B02837
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920A61BC2C4A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5452F42;
	Sat, 12 Jul 2025 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sOG/Jaiq";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V+jMuToa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BgQenGMN"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF233FE7;
	Sat, 12 Jul 2025 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752279124; cv=fail; b=sd76lvpbUhAcV/BKunCTVB/GMf22kyszPQK7NnxGPvalWFUGKEhOYTgVYC8Fl94wAu3wCsSNzLRgaCqjsuSE9NwiWgADIgd3ZEAH1Xy1h7xEbqko02TGl0YpvPlAgu9730RcL4FZkGQd7wTVR6Wx7epuZ0RwuZUgTSqo6Jbh6Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752279124; c=relaxed/simple;
	bh=SSDETOb22c4JddLyZAfpaZZ9yi+MydU/31UvPKB/2CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8VwIFXssr1NX3URKsclGSUKHqcjNKL6eSHuK8OdxfdiDEdLK31/1j4Kb3qSKKCBQpQblpG3PS++4WOrVFcUDAyEXJBI7C75JLMwGRd9QNJQYyc0uZKNV3Gp2hYsuA1EqNTsi3mUXn1bLgtWOA598ASUtw71NclqVszjo/HJEVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sOG/Jaiq; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V+jMuToa; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BgQenGMN reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BKimQc032529;
	Fri, 11 Jul 2025 17:11:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=SSDETOb22c4JddLyZAfpaZZ9yi+MydU/31UvPKB/2CA=; b=
	sOG/JaiqIzaOJGw6XoWRx74SOgwZkhrPd6JCGBZfFvHzshNcq57/jU1eOlb5M97e
	4mlvxW7QBVBzdH6jkwAM69X4GsLVhaWPkMUtdoPjQDPl51Pu04EAen8pWrlvDoLa
	8bb7nanPlEKuyVNM6gZRU0JXDqphey/cXhlmGdqIZSsxYwDfAlpYUgLTRnmGxf/8
	fELu+sAhJ/AATyE8ZEkiqtbgekdCd4uN3AY86inwATMq2M2fEl9eViqMVNU2I+9u
	AalG1ctysrDU6aeObB5hllvJJUaAE8oELRPgrKBj+FlLaCA31aARfisY7yeV/xv8
	jdLOMw+w6dTHa+gGnnmqBg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 47t6m6stxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 17:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1752279108; bh=SSDETOb22c4JddLyZAfpaZZ9yi+MydU/31UvPKB/2CA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=V+jMuToaeML09SMwkG+cRhKGIDtcUp6nrg5ZPVJmZuaryrZ9aGnHgxz46dm7CtVnW
	 d7//QBKTH6ln3rxr60fCKmLkQUFYrf9212tYDYfecWDPi9W95vzvIgmze7mhs+V8eE
	 4dZpLw/24cbziZlsjaRQE02ItFXxhrXG1ajdm20v+2vyywH1bvzaUFZ01gmSR3tZcu
	 Z2oQj3mEaXM46IOdi1CvFIcXXU8K53aOzn7iDn+mkHg3SE6dXqeS8n81ohMsJMqSGA
	 krxgAU7kTcHRTApItJD6VWoK7/8ePAn98ixZdZZi/JZS4MpUccOhtfu3OiDp3A2vf3
	 CK4vX4htvzjaQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D70EB40825;
	Sat, 12 Jul 2025 00:11:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 15018A006D;
	Sat, 12 Jul 2025 00:11:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BgQenGMN;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B342D404AF;
	Sat, 12 Jul 2025 00:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWqmmpT7n4sOXgnBv8AH8Wr4qcfPC2JLgvAvr/aoyh7JZDVrL6QyfrKsiTCATlPP4ydbykVGgo0+bZ87WKQ95MgmWBD6VDi6LUK0J00Ls+8a0R5bTTIDOvMUnrL7N0wCpshbjgqiI5ecI69WR5/oltwM0f+isrkUmlx0pi8zSVtox1iSJczGU/6tom44FC0qW6wbsSGFKsNDNkJABmCpchKAD3ueM25szVDmgdnmzWZP65z4jzJU1iOrnPozBhlKozulhdZwnJ7ESknLRmjnPGfAOoVP37gw3bNbKiMlR6uDU/Mb3M/518F5ahb8TcZRm3rFM0cCgHKfK58eJgS5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSDETOb22c4JddLyZAfpaZZ9yi+MydU/31UvPKB/2CA=;
 b=G6h0lksDV+fBcuHkbVYjwp83RWl3eDVUsAaHTrhmoykRIlgJxw8Qybm05xfYIALkLBwNhW2YlL17a2LLYnb5zSi0fCXIPcWPPTr/tO6HPERTm7XqIy8RNHfMfu7TDGe+ORnLrI7m5+7+Ypjlm/s+YImheHFaY6ahWZ4qrr2D2jdCg6kSa2QpVsPvUqM4oIxjlE4560muANzkeBljePK5ppWS1QmykiReC6+hRHG8n1HCkze1PDbGKzxhlLCeKZuX4S6knLVbSiF11d1Y6Mjz8KcVS6MJdc8F8MqaB9DMB+AIaokB0IM23ZpQwHO3AthQjyueF3IcXdmHGjRwt/KeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSDETOb22c4JddLyZAfpaZZ9yi+MydU/31UvPKB/2CA=;
 b=BgQenGMNOaORkjPHQ1O3f7j5gargZtr8XDe/hP0AxrZJfs23jNSP2lra4I7Gv9NlN4NbqzBynkZyIcfTz5mS9OsWN2B4CNZ3rmeQDiWuD7q4Q3UkeWP+RKTvIzUlFZZKPJjcT2bEGu32g8VrM/Tn/aQu5OWTXU7xyjPR5FVHTS0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sat, 12 Jul
 2025 00:11:39 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%6]) with mapi id 15.20.8901.028; Sat, 12 Jul 2025
 00:11:38 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: John Keeping <jkeeping@inmusicbrands.com>
CC: "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH 1/2] usb: dwc3: disable for USB_ROLE_NONE
Thread-Topic: [RFC/PATCH 1/2] usb: dwc3: disable for USB_ROLE_NONE
Thread-Index: AQHb8a6RTP30Xr6qbkW6FXojJLTBNbQtn6yA
Date: Sat, 12 Jul 2025 00:11:38 +0000
Message-ID: <20250712001131.ax3rw24h3deekxfv@synopsys.com>
References: <20250710152252.2532020-1-jkeeping@inmusicbrands.com>
 <20250710152252.2532020-2-jkeeping@inmusicbrands.com>
In-Reply-To: <20250710152252.2532020-2-jkeeping@inmusicbrands.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7793:EE_
x-ms-office365-filtering-correlation-id: 352c231a-55ad-45b3-4d56-08ddc0d8ac16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWpkZi9Jd2NrKzdpWWdBTWZ3RVlDSHkzVzcvYmIvSVZLYkY5ZVV2WitGeUd5?=
 =?utf-8?B?U2FlYStQcjdibHFaWjZrOGVMVWQvZWZ5NlYrMGwxZVR6ZmlOc1hUbEI0QUl4?=
 =?utf-8?B?UWM4VWRmUldScUhBbUtYUjFwRDFkZzhzeitsSVQzeUJZYms0WnNuNjBKMHps?=
 =?utf-8?B?WjRBS29USVhLTE55bmFFYTNvMW13bHZxMWFjZzNudnQrZ0xEMlE0aTZOanNJ?=
 =?utf-8?B?MkRoOGtVMnZCOUFFZUdWYzRqQVBOS1haaW5QekJLbm40TjExc1RobDZucjVZ?=
 =?utf-8?B?MWFSTmFNQlB2Nno1cENDVHFTOE8rMHdLaXJ3WTBsd1FSMVNpK1dJL2liL3Yx?=
 =?utf-8?B?blpLRGRxWkp6amJhaE9jbWhkak5RVWc1eEhibW9hNkZ5TUNyWTFBNGQ2QldK?=
 =?utf-8?B?RDc4YW5NQk5xZGczS3RyeEkrYWY1dlJvblZMMjg1TDlBSTlmOWFVTjQ3WjRz?=
 =?utf-8?B?WDZKamJodkl2NXpkNzRzOGNGazZRTzNveDBtb211V01pZEdIOEpyUm9lN1VJ?=
 =?utf-8?B?bERMTUE0U1Nxa2xkMFcyZzk3dFlHRnNSZnNBYnVzaFNZSkFPNVdLZWYybVNG?=
 =?utf-8?B?RnY0cXNZczJsZFNKL0pNZ3VLTG9NdWVNVkVobVhEVk5BMDMxRU56MlJGKzhT?=
 =?utf-8?B?UUxhQjJ6aCtkdVZiNldwVGxnNFowR1Mya1lLN2Nxa1crQ2NTYnN3VUZsc2Yr?=
 =?utf-8?B?WE5obk5qWklGNEdVYndWTkpNQVNJUUJNcFRIbmg3NzJqam5XcDFQSHp4dzVJ?=
 =?utf-8?B?RnpZUWd5QVQxNlY1d09oZm1BN0RGU1crenhTdURvSDFxVzI0Z21IVCtYTTNI?=
 =?utf-8?B?WmVWZVJ6VnhsOTdOYXZ0ZDRZa2xKS0lIbng2cjFncTEzOUZnaWNFSXJ2TWk1?=
 =?utf-8?B?U3NYNzNDbGRTY0hRMVk1VDVXUmZSVTZVSGhGWG5YcVpqNEZxcHpMWlpGSStY?=
 =?utf-8?B?WG43TThkM1d3UGRvelBoNjNzMTJ3cWkwU0ZjcDIxdnZTd3ZTNDVEQ3g2aEhS?=
 =?utf-8?B?TXUzNTJuNWd6ZXhSYkdDbXF0emVMYlducHFrUFFOVEhTU0pVMGh1OGl5K0pR?=
 =?utf-8?B?RzQ4UURkeHJVY0EwTTdrZmxYaWo0UzQvWEJOT080ZDdoYlc1ZnNJbjduS0dG?=
 =?utf-8?B?cmJxdjFKRzQwMW5yZ2RtZEtEMUQ3WTBSREl0RHJaNW5pd0U2YTYvbFhwb0dP?=
 =?utf-8?B?c1J6dHlSQ1EvRVFIQ1U1S2w1U2kxWVdOMmlGU1ZDZGR1aER6ZlZZMFFwSUJp?=
 =?utf-8?B?eGVveXlHWEx2dHp6NHpXYTVEWXJnaytVRkhFUUEvQ2dKNXhReVV2OTRnVmhZ?=
 =?utf-8?B?L3ZpRE9hREZRUFE1YnFKWTIzS0VDZ3Eva21PTVQyOWY1THZtZ3JkQjdvTkxQ?=
 =?utf-8?B?eWZxdHJiQWJiWVFCa0RwLzBEZUpuWGtxbUZMR2VDRW1LOG1tY1BmTmZiUkJx?=
 =?utf-8?B?V1RPc09sdUVCaWM3ZnU4cURDL3lBemN4VXdSUDZXc3REMzFvcFAwVnU1eG1B?=
 =?utf-8?B?QnJKQ2RGN09UK2cwNXROQVlRZmJGMXJGVjJhblF0dEpqUlMvU1MzSzQ1QW5E?=
 =?utf-8?B?YmV2bnZ4QjZlcS96Nm5lWmdNOUdVaHJ2UXF0MzhBVW5sekxpSy81RGRFTGVL?=
 =?utf-8?B?cFFrZThXSUV0aFRJSkFKaGFvUENpRG5ZbnpaQ09DZEZ4eXF3SjNFOVllNVZ5?=
 =?utf-8?B?ZGtKWFIrY1R0MnJyY3VjcDRyUm1SWXYrTmhUR01HU0RhSkhza1h6N3dWK0VG?=
 =?utf-8?B?WjBZcWZYZVNXWjliMGRnVW0xdVgva29UQ2FMOERaTlhyZzFYT3BmMFplaXlP?=
 =?utf-8?B?TGtRYWNxelc5YjMvTVpjM2hNSjBWWWpvK2l4cjBoWFNBZFdwL3Jma1N5NTg1?=
 =?utf-8?B?WHZNL3NQZzBJcUdSOFdtUjUrcllJcUJQMGtVdHNLb05ndmt6OGhPWjkybVE4?=
 =?utf-8?B?bDZVU3FDZVB5TGNhYUI1WkVBeUZIMitmbjF1L0IvRW1KNzZvT0k5VlpTclc0?=
 =?utf-8?B?NHJOeGFiajlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czdOZXZ5c2dXMS9TSXBhMnk2R1NNYmRXWEpzT1NoaFErVDdUVzNaMThhdDkv?=
 =?utf-8?B?RXVLUkQ1aEIyYWtJc2dGRzVLb0JUcVBMU3hKL0d6cjgvdU40cGpkN1p1U0hL?=
 =?utf-8?B?cXBsZ0phM3pDWmNjT2lRdWdSNzlzUzVCbVQycHkybVBOcmhNMDJ1Z1lHbmxJ?=
 =?utf-8?B?WFd4Uk9pV1EvS3E2cytxTjdVaXdFa2ZRTHlQTVNOTi9BcENiOUhCMllnNVVL?=
 =?utf-8?B?RnRoWFJ5Nkx5RHh0SHZYdUF6QjlkRTlFQTVZaldNRUNGam5QT0FhUlV5U2lw?=
 =?utf-8?B?UU5ZU2pncVB2RGY3czVVU04xenBQYzRUeEZuNHZWMEM2aFQ1N3ZlTDdTTzhQ?=
 =?utf-8?B?dkg5MnQyQW1LR0NvQzdheEkrMFoydGhJQWpiNnRMRWhEQ3ZwVUF6dlMzZkxo?=
 =?utf-8?B?ZnEzUU5ETkNjNGUweEl5UWVTRkE3WnZwMitwWWNNUDd2M1JIRlBGN0NXNnVq?=
 =?utf-8?B?VFRIQjYzZ001NlMramVrNUZ6b0M5enNOM0xGRHMreWxVdmlVdUZ2dmU5SEtQ?=
 =?utf-8?B?ZHpUZlVNVWNaU1lQK2xaTUhWbDBia2hsS3ZhV0ZNUUhUOWtWcTBRMUZKT2RO?=
 =?utf-8?B?WnJmdzNmVDdTVkhSeVNoVHNCTHZmVHJUYUdDKzIwVXdERlR5WGd3cXVqOEpG?=
 =?utf-8?B?QlExZmZva0xXSnZxZ3V2TUM2N1FKZ0dJSUlLZUFuNllNY282dTZ0NTdlWFpQ?=
 =?utf-8?B?K2VlckI3R1dmem5RbGlqZGdxR1lpN0pOVmtheUVMRG9qYnJLamZzSmtRd1kw?=
 =?utf-8?B?T0FXZmVMbUp3eWs5VHVyRU9Ic1BQY0t4VEZyeUlBM3oveFp4NHVNaWJYcDZP?=
 =?utf-8?B?eDBYSkplaWdGT3B1MWV0eTBtQWRlVDJXVldVd0sycDlZOXNWSmUwR2FUcEJx?=
 =?utf-8?B?UkFrM2VubVg5UkNhNmV1QUllUjg0Nk0vMm5sVHJ2MWdhTUNYeHVxSnJlQmQy?=
 =?utf-8?B?YndKZXNpTlZSbFhyQUlrSTJjaW1qcGhFS21ZSmw3T1p3YkxKMnZmcERPVWpP?=
 =?utf-8?B?RzIyYXhiK3ovOHVtWmhvbmNDL1YxWkVLWTZZRE43TEdGRW5rS0E4RWZKMS9L?=
 =?utf-8?B?M1hibCs3UnJmMnpmUjBsUEZLMU1aU3hrWjZ2a2ZMdWVSSFJBMEd6blpRdk5U?=
 =?utf-8?B?eG5JdHFpWWFPdm1HTldkZHFhNDFnR0V4VG4zRnltanE5c3hDcXc5bm80SWZm?=
 =?utf-8?B?UXEybndQRmFKSThQcDNNUjRjbDV0dFc4SC9YbEt0eVJOUnBRWFltTldGOWs0?=
 =?utf-8?B?bldEYm9nUlkvK21xckdSSXAzTmpmZTNkeE9CamtzWFdOcGFSbStQYjY2aEdU?=
 =?utf-8?B?M0xVTG9KVWFJZGRnS0pCcm1XRW1abWVNenZibngzYUNvV0JCeFFIUUhCZ1F0?=
 =?utf-8?B?cDBtRDN3VkhjeGxkSEJDaWJlSjFIcW16R1dvMlUxZHhmdnJzQndacjNTbWZJ?=
 =?utf-8?B?dTNFalNGSHRjWk5rUThUeVVONHo2VTI0OWhyWnp3K3I3MTdSbk50SXpTWFRN?=
 =?utf-8?B?Mzl0ODNRU25sRGtCODEwRGRjMHpjVVpJdHhXZDVmMmdvRnpEU0pyZm56RFhp?=
 =?utf-8?B?a3Fra0gvN0tJS0RDejZmanRxV2U3Tk8xYlpSNHdWRnVyK1E3T2kvaWlOejJk?=
 =?utf-8?B?dDhjQkYvcHV5S2NSQlBtTU91MlpVcGg5NnJTWG9CNFpoSmJwNmdubVBnS2Jx?=
 =?utf-8?B?Unkrd2RkU3JxbklwSDdCc0lPTUF2SEZKcnNOdTdxQ3dabkZIUnNvRDNiaFA3?=
 =?utf-8?B?TjdyekNibEtvbFJ5dWppMHpkcFpyMlo3TStSQ3A1OGxzMVVtN2NUV0xTSTJF?=
 =?utf-8?B?c1RSWGtFRTNtWE1BdXA2ZlF2SFVheEcyTDkrczkrS0V1YmQvQXlhMjBCUDlq?=
 =?utf-8?B?Vk9sOW1FeXdlS0I0VWVuRFdMb1FDNU54blpPRlFzOVZFUDNyOVlYc0MvcWRj?=
 =?utf-8?B?Z3lONDYwdzJseStDYWFremlLZW9OeVdKRzVBWVZoRlVvSkh0KzVpaEE2dVdj?=
 =?utf-8?B?Z0NWajNCbXhzd1kvUHZnTUoyUHRhUFBqUFR4Q2pCdmQzMktzWDRQNTZiTU9U?=
 =?utf-8?B?bytQSDdBMU1YMUlKZHFaM2ZQTjFWeWpINDJTeDBrcys4V01pOGI5TFIvdDNW?=
 =?utf-8?B?N2daMGY4MUNtNnIvK1BYOU14bGNvUDR2WXpQWTZocC9KbnRVWjJjcVZJSCsz?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50CA1361AF6D144488919041C50F26FE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q+nXHCPMNlIMkXFjJY+58Atkktxsvt0aA4go8VSjKXieaAEo5AFA/l/P5OgazQljCNRTA7UmRBhCmhyLzCTsi834wyaLFleGb2B1RWW3I1Cf8ZfltU0q86HyzAwtNezyeA0MpMx9tVau2f5BdYcMHhqTUgcz+HdOC6xUWXjo40IqOV3ObJDHFS0yT4Ee6QPzxgiEL5ffw5PQxT7XFHX+vnmerji4pHivZKhS2rPO5nOh1Ah3gjay6HBBWxKxYPE0bldJ/XZrT+HcMBh5T7jvLf4ca4WpIHVHq7YWNZr8PUaOdXp5cm+Rj/tDxr4+aj68rij1g5WG6yWiqej46xOuy/TLuRbjG3UUOEcO5g+duOut+N6e351ckDSqXsSS/msYPpbiPo09Z9CxOgF5b9qM6FfsHe9NU9kuKW07rGS8xvl9JHnnv08sHx987pxNSqagkOZQPx9G3iQU2qPQoN9qUg42VcpCB2jwhAlmNlI9HvXZ1TmcZiN5WwTrXWHOOSw77ckU8s9iBWSCgWttghwDq88xNIDa9wjp32UM3AF2EPEznvONq9u3hyaKKm7Zjv8vZQS5AMFyF/+/eCQtijPt58HIgMV/LQpkYQ0MSbs4Vq7fKazIs8wREe5XjPckclqX4TmTVXIqlaAW9oTBx9MT5A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352c231a-55ad-45b3-4d56-08ddc0d8ac16
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2025 00:11:38.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNF8k9j/QS3RS7yBCRf/4iIy8NbF0yu8E77Uasi4O/jvhjB3CUjxWTN2QKvo7bzEsYh8PIqUtuBckZJoMeigkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Proofpoint-GUID: g0y8XRoNqM8DuZeHEpi_HELdot1_Tf3d
X-Proofpoint-ORIG-GUID: g0y8XRoNqM8DuZeHEpi_HELdot1_Tf3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE4NCBTYWx0ZWRfX7Ne0tozBMRwu
 UXsuYx1Ps2DL5bOJAK741HAZzom5c9jk3ahEvgSlX4ttf/NfX5tKuB/ibsibbY9oPAnhVFluRw5
 3rJH6Lef/L3CFvRGL9Qr2sW0YbeyqiDoc3/oeQd4k2kEK5CG7p6xweXcMYbDnDmluRGLb2H4wNu
 PC+xg7dCqGhJoG7uMzsSFRrl2J2Nd5aezw4NQoXJJxKe76PkaX1hj48Qyu4rRrh7yk81x4gGfdG
 mT/wwn7OQOyF5EElQ1fEf8RcgE+osyPDvIj+RfNougfVJ2FZMfHydCN2dfsDsQK5azDC9565+Om
 PZWvqnd3F2+PZS40NWC5yLPac7Oj1QQpHDJaYiEB1lPP255MgybO2/q+RkIMM/Z9noN/LZ/v5mi
 fjBi+VjnutQybNaHUXQeyvwUU5uhURzVIlWWIVJIqvLtvkzpYEajb+YtmesIRlmzCzdULV3H
X-Authority-Analysis: v=2.4 cv=LNpmQIW9 c=1 sm=1 tr=0 ts=6871a845 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=qPHU084jO2kA:10 a=2xWeXl8dnucLxNU7y-wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000 definitions=main-2507110184

T24gVGh1LCBKdWwgMTAsIDIwMjUsIEpvaG4gS2VlcGluZyB3cm90ZToNCj4gV2hlbiB0aGUgcGh5
IGlzIGFjdGluZyBhcyBhIFR5cGUgQyBtdXgsIGl0IG1heSBuZWVkIHRvIHJlc2V0IHdoZW4gdGhl
DQo+IGNhYmxlIGRpcmVjdGlvbiBjaGFuZ2VzLiAgQnV0IHRoaXMgc2hvdWxkIG5vdCBoYXBwZW4g
d2hpbGUgRFdDMyBpcw0KPiB0cnlpbmcgdG8gdXNlIHRoZSBVU0IgY29ubmVjdGlvbi4NCj4gDQo+
IEluIHRoaXMgY2FzZSwgdGhlcmUgbXVzdCBiZSBhIGNvbm5lY3Rpb24gbWFuYWdlciB0byBub3Rp
ZnkgdGhlIHBoeSBvZg0KPiB0aGUgb3JpZW50YXRpb24gY2hhbmdlIGFuZCB0Y3BtX211eF9zZXQo
KSBlbnN1cmVzIHRoaXMgaGFwcGVucyBiZWZvcmUNCj4gRFdDMydzIHJvbGUgc3dpdGNoIGlzIGlu
Zm9ybWVkIG9mIGEgY2hhbmdlLg0KPiANCj4gSXQgc2hvdWxkIG5vdCBiZSBwb3NzaWJsZSB0byBn
byBkaXJlY3RseSBmcm9tIGRldmljZS0+ZGV2aWNlIG9yDQo+IGhvc3QtPmhvc3Qgd2l0aCBhIGNo
YW5nZSBpbiBvcmllbnRhdGlvbiB3aXRob3V0IHRyYW5zaXRpb25pbmcgdGhyb3VnaA0KPiB0aGUg
Im5vbmUiIHJvbGUgYXMgdGhlIGNhYmxlIGlzIHVucGx1Z2dlZC4gIFNvIGVuc3VyaW5nIHRoYXQg
RFdDMyBhbHdheXMNCg0KVGhlIGNvbnRyb2xsZXIgaXMgZWl0aGVyIGhvc3Qgb3IgZGV2aWNlIG1v
ZGUuIEl0J3Mgb2RkIHRvIHVzZSAibm9uZSIgdG8NCmluZGljYXRlIGNvbm5lY3Rpb24uDQoNCj4g
aW5mb3JtcyB0aGUgcGh5IG9mIHRoZSBuZXcgbW9kZSB3aGVuZXZlciBhIHBsdWcgaXMgZGV0ZWN0
ZWQgc2hvdWxkIGJlDQo+IHN1ZmZpY2llbnQgZm9yIHRoZSBwaHkgdG8gc2FmZWx5IHJlc2V0IGl0
c2VsZiBhdCBhIHRpbWUgdGhhdCBpcyBzYWZlIGZvcg0KPiBEV0MzLg0KDQpDb3VsZG4ndCB0aGUg
cGh5IGRvIHRoaXMgYXMgaXQgZGV0ZWN0cyBjb25uZWN0aW9uL2Rpc2Nvbm5lY3Rpb24uDQoNCkl0
IHNlZW1zIHdoYXQgeW91IG5lZWQgaXMgYSBmdWxsIGNvbnRyb2xsZXIgaW5pdGlhbGl6YXRpb24g
dXBvbiBuZXcNCmNvbm5lY3Rpb24gb24gb3JpZW50YXRpb24gY2hhbmdlLCBhbmQgeW91J3JlIHVz
aW5nIHJvbGVfc3dpdGNoIHNlbGVjdGluZw0KIm5vbmUiIHRvIGRvIHNvLg0KDQpJJ20gbm90IHN1
cmUgaWYgcm9sZS1zd2l0Y2ggaGFzIHRoZSByaWdodCBpbnRlcmZhY2UgdG8gZG8gc28uIFBlcmhh
cHMgd2UNCmNhbiBpbnRyb2R1Y2Ugb25lPyBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBjaGFuZ2Ug
dGhlIGJlaGF2aW9yIG9mIHRoZQ0KY3VycmVudCBmbG93IGFuZCBhcHBseSB0aGF0IHRvIGFsbCBv
dGhlciBwbGF0Zm9ybXMuDQoNClRoYW5rcywNClRoaW5oDQoNCj4gDQo+IExpZnRpbmcgdGhlIHNw
ZWNpYWwtY2FzZSBmb3IgZGVzaXJlZF9kcl9tb2RlPT0wIGluIF9fZHdjM19zZXRfbW9kZSgpIGlz
DQo+IHN1ZmZpY2llbnQgdG8gYWxsb3cgdXNpbmcgdGhlIHVuc2V0IG1vZGUgZm9yIFVTQl9ST0xF
X05PTkUuICBUaGUNCj4gaGFuZGxpbmcgYWxyZWFkeSBkaXNhYmxlcyB0aGUgb2xkIG1vZGUgYW5k
IHRoZW4gc2ltcGx5IGRvZXMgbm90IGVuYWJsZSBhDQo+IG5ldyBvbmUuDQo+IA0KPiBJZiBhbiBl
eHRlcm5hbCBkZXZpY2UgaXMgbm90aWZ5aW5nIFVTQiByb2xlIHN3aXRjaGVzLCB0aGVuIGl0IGlz
IG5vdA0KPiBuZWNlc3NhcnkgdG8gc2V0IHRoZSBkZWZhdWx0IHJvbGUgd2hlbiBVU0JfUk9MRV9O
T05FIGlzIHBhc3NlZC4=

