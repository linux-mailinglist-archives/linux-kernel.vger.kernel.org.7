Return-Path: <linux-kernel+bounces-781606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A199AB3145F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC9616F2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871812F3619;
	Fri, 22 Aug 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="f9UXWdFr"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012056.outbound.protection.outlook.com [52.101.126.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58A2ED15F;
	Fri, 22 Aug 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856202; cv=fail; b=RgCNYOLgOR2pS8ccI+XAqMmQfb1+N1g7UigKrkdx36noWC32KpoD7xOQlxxQDrJiHHicACKoT7C8KVHd8yn4tGg/iasoSlikxkC3wy1pKiqpaAxRxcmSt7JzKN1YqC3qM+zrKgg9Q79+97rAlAfgj86nhPjbawoaXGDtcCfwyG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856202; c=relaxed/simple;
	bh=9VtrnhNnul4ySK/PXUEtIcEV+n4F0KocxsdtBwmprvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gS0m8CFX8MHI6anzuDVoDAmZujo0gnm5WjRvtPgxqig3g+0Tyo4tBbsClZHiOL5u46rDHpqjhSzVM5Qwj81beWHE039ZKBw6WJllaYmhWLwaRXo27cWC6vFQd4IyNJvKVhwecVJN01JlJxlCQV5KikcHilS9x+juFwF/qM/ZNNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=f9UXWdFr; arc=fail smtp.client-ip=52.101.126.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTlrdjE5Q84Dw5iq5gtTfOwfkmQlqemFt51rTP9orcmMJFcCHgxZRKyMRVgb34+DQq7eaDdInRZsEyV46wNpLkGCldshRUMOUEfG9XvX0jx9JsTMlAmYYpywF9ZFv2BoxCrKJwdskKUBwOSYvqk0kL2/iZ0nW7fPD9ProkCXOiyRo9xdbS3AVYw3DPw3fxUD9jYyS/PAZmD6qIJpg6oIE3GZTfGQk9FqHQiLT3vaBs4DGE3TQ+Tva4HXOPj06Oxglk2F4c1WqQNxL4G4tbuz6zeGz9qpfgV/3TtRoP+g7suDL+RHPDfjmsJShsgc+8R4zQ5jiqxh6YoRngU5ALDoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VtrnhNnul4ySK/PXUEtIcEV+n4F0KocxsdtBwmprvA=;
 b=bNCjZcQzUBq0RZwTqGuBaBNEKklMABbPuVhQlqjvryKsJ87QFqTegikzT28hgBB9/ZkUdkoo/F/7H9krv1IeMU2IStfcDDxRAKkoT5eKOE1zZLU5EJDvH0Qb3L9aTA5Yu/frHieCKwSVj5hghK7QGGFtk0k8Mqd+c016BWnHrt7I/Gp94OF9D92viV3FVeb5p2oMHwJ8a+R4TEY+jkLqUdw5cfZSs9g2HZhUaxmqM/9gpAbJTuBYC2Zkoe3olakKpBOsm/y/Ng+a8iv+tI85sr3cX5l19b99iHbnh4ucdt8KQGjUZlLuyZyybOpS0xZyGPh65YnzUEA+RPF4birWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VtrnhNnul4ySK/PXUEtIcEV+n4F0KocxsdtBwmprvA=;
 b=f9UXWdFr6G11Ca9/CgxPPXGUegmNFRk8NkwKHpaFD3Q41Xe0lRVrKTvlzgMYs2qnPR9td9Em2dDKFxplaBgByZRc11m7eoJ0SPLsy4HGcuTiiAKcop3KCvOk8S6A2dUzZc3jEKxUPQIPcF/pTse9Gvw1t1iCOfKVpfLHwAPd2JSz3ldiOwXhgeJxHhXaxAXejfrcoulfuz0DPvWCtB2kXRSoWRcB8EU4QKd2939OQumpJ/32d+Pib3a1e9gneg4H4J9GXwJLTRjhApdT7EUOgdP9ObOn2qEQFI8DcNwxoFUKZlmQGzVWPeiJ9+78rDwzklZxB0eoY9wLZxSchXALsg==
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6687.apcprd06.prod.outlook.com (2603:1096:820:fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 09:49:45 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:49:44 +0000
From: =?utf-8?B?6LW16KW/6LaF?= <zhao.xichao@vivo.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: phy: twl6030: Fix incorrect type for ret
Thread-Topic: [PATCH] usb: phy: twl6030: Fix incorrect type for ret
Thread-Index: AQHcEzy+Jmsrfz0DeUOP/iAQSewg37RuW7aAgAAR/QA=
Date: Fri, 22 Aug 2025 09:49:44 +0000
Message-ID: <07068f88-7daa-4951-b680-945f36169867@vivo.com>
References: <20250822081403.12932-1-zhao.xichao@vivo.com>
 <2025082212-monorail-impromptu-ec1b@gregkh>
In-Reply-To: <2025082212-monorail-impromptu-ec1b@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6020:EE_|KL1PR06MB6687:EE_
x-ms-office365-filtering-correlation-id: 0c9c3159-fa50-4c7a-06ca-08dde1613972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tm5PMGNmSis4Q2hURm9DYWxOVCt4dzJwa3NjUTlHRkJoWURWYmxGVzVTYitG?=
 =?utf-8?B?VkFJNDBLQVBsSGhETVN2L2llcGQyWVl3MnJBSVkyZW9ObDE5T3RFaHlKN3ZN?=
 =?utf-8?B?QTRjVzQ2Q0MzaWlXUmgwWGNYSG9SSVpjcmdBZ0ErMmdDNWkyVmEvZmpkSUtI?=
 =?utf-8?B?UldJOWo3MzhFUm8yc1VjNkNsQmE2NzZzVEVnNmtLWi95ajIrTUlCTDB2eU5U?=
 =?utf-8?B?alRoMktxWkFsVXZLVTF6VVUzUmo4ak8rWTNZSkxBWVZmUjdEUmlqWC91Q1Rx?=
 =?utf-8?B?UFlneXpwbmRWRGhhbUdiM0k4M0hQRXZWYS9aNjJqLy9TWjNRN3lPUXhjWGx6?=
 =?utf-8?B?V0tvL1FabzJEamlKbEk3b3k2QXhXRG5PVFVJZW5KK210ODQ2U2cveHMrVGJp?=
 =?utf-8?B?NnNZWCtlejlTd0Q2UTNIZVE1aE5FQkVoSnZjYnRLNC9LMVpGNC9kQlBPOGgx?=
 =?utf-8?B?UXd6cUYvRXNjMVFBVkQyYWorY25aR1l3Vy9RdmpWckxmWkw1UFFnbEVwMHBE?=
 =?utf-8?B?aFpPTjNvYVA3eUludlppZkkzN0xDMWRwaVU4elRaZnRFNnZBbk1Gdk1ZRjFY?=
 =?utf-8?B?Yit2cU9xMXBreUFtQ0VYb09wZmhZVUExWHh4S29pek5DeGprcWtpcVNHQ2Qz?=
 =?utf-8?B?UmZudmZSblBpZmFXR05zL3l4VjlMSjIrR2xCSC8yZVp4NFFDeVlVVnQzWmxP?=
 =?utf-8?B?SlpoVm80eXZSNFMyWDhuTFJTS2djaHU0Zit2M01LcUZPOFNsZU5Hc00vZ0pn?=
 =?utf-8?B?VlhPU1pjL1l4djZKbHRXQVUzOUJnNVJzRVZad04rRUtmRGtPV002YXVxai82?=
 =?utf-8?B?YlhRVGpVQ3oraUJBdC9qQmwydVZPOWJvbHlCYTQ0TEhxSFBoYkxZWEhGN2da?=
 =?utf-8?B?aHlnTmcxV3ZyVUZmUk5zVEVIcVlMWFU0VEZSYVRhWnMwK1ZqQTdUSnF6NkJ4?=
 =?utf-8?B?NVAxZjN5TzAvUG5temY1azRNRHQ2Vy9ORTBtS0VOSkFldUdJT1Q0RjlDc0ZW?=
 =?utf-8?B?U2dFbEhXSmN6QUhrTFN2Q2RTdGRkVXZta0lKZGlPR011dS9mQklsVXlxT3dU?=
 =?utf-8?B?K3pCYjY3TFpubytkN0NTWlhQUDE4QkJFYkRUYStwSFlFbWlMMHJ6cUpGRERE?=
 =?utf-8?B?RFdhZzcza2hrUTgveFkvRWNDeVlZd3pmdzZKeUZNMkpJS0RQMk5oY24xSkQv?=
 =?utf-8?B?aXVmNHRwZXVFVWhMd0ZUSzBNQm5qNE5TTFYvcFVnRk9hanRSeVhhd2VYWlA2?=
 =?utf-8?B?VkRjT2ZhWWRQY1VuM1FTcFpObG16RVNqaHZNcjlMaExVYURsSGNFS2F1bzNK?=
 =?utf-8?B?a2hBdS9SeFE3Y0VJeXdpQ3NMNE5ETkJaaU55V3A5UnM5QlU3OG15Y1pyMmNP?=
 =?utf-8?B?YmcxSUpqcHduRWVsazdrRjgzbHMrbm8rQ2ZjeGl1cDU3djJCdnlmWHBsN0tz?=
 =?utf-8?B?ZFR5T1U4YktYWTNpc0htcWZ0TUJHdTFGVVBhbzBVeXl6bDFETzRhSTJlMzFV?=
 =?utf-8?B?cFdpSEkrVzF3WkxHTUhaeHJmTS92Nk0yQk8zSno1eXluUzNBWk8wb3BSQ0xj?=
 =?utf-8?B?eHd5UlNUaHk5M3B4bkFqZ0NjcDRUVkZ4UnU5RUM3aklGcGs3ajJyaGFpVzRC?=
 =?utf-8?B?TUNZZFhSN0ZjdWN4Y3JwWWlPK0loOEMvdFU4cDMwVXE5T3FYNTNOckZ1MGlW?=
 =?utf-8?B?QXR6aWppcytTWVZ4YU5EWitiQW04d0l4OUxDQ2w4ekxocEl3b1lPcCtiVjI3?=
 =?utf-8?B?ZkFVWkZaek5wVm1yWTU4anNoRVFDNnlaU2RuQTBmUFNwaHMyVFFRWjJ3cTZC?=
 =?utf-8?B?UjhnZE9tdzBMZzNTd09DcDlzbldBMnhhOXZyemttMGNYWnkvRDR1RXNLdlFD?=
 =?utf-8?B?S1p5dmZzazNYVnpvNjZNOUgwZ1VnNnJIWnlFakxmRFg3eWxrR2VnMVpPejN5?=
 =?utf-8?B?eFZYaVJTaUh4Tko1RjR5cldQd2htaDZkNUdOU3NHNnpMRVZFeEp1V2xkUkg3?=
 =?utf-8?B?K3o1Q09QdjBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3QybVFmUTRzejVWdzdHWFlMbEtPcmdnYUtkR29tWEpPZUVuNlhkaStoQ250?=
 =?utf-8?B?T2l3S0hadmZEWE94dkdjYXRDN2ZzMnBNeWJVWUtFeG41azJaQzk3V2VHZWZl?=
 =?utf-8?B?akM5M09QOFgrWlVSdm9XVDZxVWVBWWdPUFlYemZXcUd0LzJQTTRCcTUzRFoz?=
 =?utf-8?B?ZTVSYmVuL0pjVnNPc2lRZVAzTjUxV2FJYUJZUE1JTjZqR0Y5SEMwQkFJNmQ0?=
 =?utf-8?B?MmVUdjJpZHB3QjBFSHpjdXpicjBLUHVFeWNtNElaQmNIRmNBZnFUNjlLUXFw?=
 =?utf-8?B?eStLWUdjRVYwS2tmQ0s2a1ZaeHFEVGZwWlVlaVdvTjMwb25GN3krOSt5V0Za?=
 =?utf-8?B?L0lmcERERWtQM3dkOEtsaFFiQ1gzZHY0SmxmTFVPWStWbHh1M0Y4UXJhTU9q?=
 =?utf-8?B?QjhvNUZhL2laR0dsU2V1Z2c0OVpjbzZlM0V3TURJZndVamRkZUlMSlc0YmVm?=
 =?utf-8?B?T1IvSmZlemJYZVoxRlhEOXV0U1NqN3BmdEJ4TVlKRDc0L1J3aDkvT1BnYzJG?=
 =?utf-8?B?MmtLVlkyeUpGbUg3WnZGWmlWMWpKWVdlWlhzVVJWMWYwU1lzR2JZZU1XeGZy?=
 =?utf-8?B?QkVBSGFteFRTeDlvdjcxKzlqT0wyVTZ2WTFWQ2lBWk43ZmhRZmp1Nm5FV0VD?=
 =?utf-8?B?WTFEZSsrTTVZYlpNSkNvbXU1NkZ0TDhWdlJzMGgzdXNnamg2YUpvM2tsbFJD?=
 =?utf-8?B?eE55MjZra3NFeDdWYXZ5UVByektqb0Z4Wk9vVzZWeDBJZXJoTzNhZnowYVYr?=
 =?utf-8?B?dHpqSmNuYW5TR1lYV2tEU0tKbXBSbU1yRUhyQjg0bEcvVU9EU3hscXZMblpF?=
 =?utf-8?B?ZmVJT25MR2hHK3kvWVd4YitlQmllU1MrYTVGaVpsRXVldldjSEFtQ2czdmF5?=
 =?utf-8?B?SjdENDdtclAwL0ZvOFdJa0VrOW8rdFE1bE1SSWhEdlBQZ3A1ZjlST01qNzNH?=
 =?utf-8?B?TTJ4THMzV29OY3RiQUQ1QWJwNThyMEoyYTlUdjIxc1BIaEYzZ3REcmVDVEk1?=
 =?utf-8?B?S2d6OStoNWRqanBFQVhmamdqaTNoWWlJeTFJV3dCU0NRcHFyblRJZ1dWVmIx?=
 =?utf-8?B?TGxrVkhzQnpoZXZPRjN1TjVHZFBFeEtGSkNhaS93eEN4enhxS0kxUXFvY2Zp?=
 =?utf-8?B?dG9waUpSRjRoVG5FZFNOWVBjMDhIc3JpYzk5b1BPZ0loQ1FtSHdvbU1yYVE3?=
 =?utf-8?B?NjFDYjgwcXZmQUpta2djUEhMamdsWFNQbFMyRk01WGxLOVV6YzZ2cjdWWFVt?=
 =?utf-8?B?U1hOTmhYb3M2eTFGQzJsellKdDJMM2M2ZkRFZHJDMlMwblB0eVhDSEl3Wk95?=
 =?utf-8?B?akFQN1FJRmREOE9xUWxYaG5iWHphemFDaHJZMi9LRzVXNS9JZFhmTXd0YmR4?=
 =?utf-8?B?NTBhRDhlMTRCcU9ZbEoxTlZrdU9oMFdVbmtRMTJLVGphTm93SmhLL2lPdzlr?=
 =?utf-8?B?T0l5NCsvVlVoTHN1Vk1SWU1EeHg5RGVEU3BtcWZPbER3L21vcDBGaVkyUExR?=
 =?utf-8?B?NEtGVVkzdDlETy8wQmJXdmMxa3NsZ1pWV1k5a0JiRWNoWkJCYnF2Q3JEWW8y?=
 =?utf-8?B?TWExRWp3TXh3NjBLcnRMQm9GaEQ0ZUhMYnNkbUVNVzdLWk85ZzYzYWVqVXRG?=
 =?utf-8?B?azRyeFFRdkZQa2owZ3RRdjdlMFFHbElzckpocDlMYU5TdGY3Y2Qvd3g3UmNu?=
 =?utf-8?B?TDJZanNRZFFHRVF1L0hQbDRJUk9uQmtPTmVia0N4elNPTlV1VU5SalpheFdN?=
 =?utf-8?B?azhLZDh0WnBCcG12S3VWS3pLRnYzcVFKM1F4N1hCTHlwTk9nOVVsUEpsNTJt?=
 =?utf-8?B?amxMSjNRUHJqdmNOMXU2c2h1RDA3Zy9BdnR6dWZXLzhhTWsxOHJvRzdvVlg5?=
 =?utf-8?B?MWVibklJRHc5aGdVcFVxRkJrbVd3bjlZTCtFRFllbU9MWGVaK0JISktnNUJY?=
 =?utf-8?B?eGN4U052dDcxNmpQNFJkYlduc1hCUDBPQVQ1c3JDMnpBbDh6OWtCeEgvSlhO?=
 =?utf-8?B?UkphYmtNWFg3QmhmS2R1U2RieEdnTHRlRFoxQXZWWGRhVnJWTlc2cUxHeWJ5?=
 =?utf-8?B?WUtpQnJQdG1LcFM5TkJnQjJVTENRZC9LTEZOcy8zcWpYVlhrOHo4S1VhL1h0?=
 =?utf-8?Q?yuco=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D72E927FC81B3D4284769D9EEE8D8974@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9c3159-fa50-4c7a-06ca-08dde1613972
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:49:44.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhPIsPIL1dTTjg1Vz/5pD+DQnLtsTViGdRtG91MnolwQdS4w4ez3RTOzcU8YF/jTJ3kaURBRemOeCFAETy7M3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6687

DQo+IE9uIEZyaSwgQXVnIDIyLCAyMDI1IGF0IDA0OjE0OjAzUE0gKzA4MDAsIFhpY2hhbyBaaGFv
IHdyb3RlOg0KPj4gSW4gdGhlIHR3bDYwMzBfdXNiX3Byb2JlKCksIHRoZSB2YXJpYWJsZSByZXQg
aXMgZGVjbGFyZWQgYXMNCj4+IGEgdTMyIHR5cGUuIEhvd2V2ZXIsIHNpbmNlIHJldCBtYXkgcmVj
ZWl2ZSAtRU5PREVWIHdoZW4gYWNjZXB0aW5nDQo+PiB0aGUgcmV0dXJuIHZhbHVlIG9mIG9tYXBf
dXNiMl9zZXRfY29tcGFyYXRvcigpLlRoZXJlZm9yZSwgaXRzIHR5cGUNCj4+IHNob3VsZCBiZSBj
aGFuZ2VkIHRvIGludC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBYaWNoYW8gWmhhbyA8emhhby54
aWNoYW9Adml2by5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy91c2IvcGh5L3BoeS10d2w2MDMw
LXVzYi5jIHwgMyArLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiBXaGF0IGNvbW1pdCBpZCBkb2VzIHRoaXMgZml4Pw0KPg0KPiB0aGFua3Ms
DQo+DQo+IGdyZWcgay1oDQoNCkkgaGF2ZSBhZGRlZCB0aGUgZml4ZXMgYW5kIHNlbnQgb3V0IHRo
ZSB2MiB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4NCg0KDQpCZXN0IFJlZ2FyZHMsDQoNClhpY2hhbyBa
aGFvDQoNCg==

