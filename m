Return-Path: <linux-kernel+bounces-790847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D4B3AE48
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ECF7C5897
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CED2D29DF;
	Thu, 28 Aug 2025 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i7nP+sWS";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="inKM02Mm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jguWWfzQ"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23F2C3770;
	Thu, 28 Aug 2025 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422675; cv=fail; b=j+tsPJDFuGzpEOWQVrMJgYtQZ/s18BPpybcyQFofHF9lbazU16q/9uW97DTD6ONWe6z2ExotHjXnSxrDIz9aDEY0Mb6mp6rksshnmzzxWzA7GyD9HzMOoTqpGckcV27aptr3W8W6oMp94fkxkcNSpf+p2/BJ9tLGtL2J/ahJZWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422675; c=relaxed/simple;
	bh=vbZCdf6hhAF2eTVnAJ7djPmnu/FBsxwBitBg5ErR7Xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrdQWV4OGpiFQ+GC6IyiYW0iqfzAO4U25Uy5ASjlTQUHez7IQRBDCWqDrPniBOP5YgIyt8mMdZUbFwBrsQSF1AO0auwN1KJXUDyUQROVB16mSObootOZTI2tR5l1jxSOwhQHVSJ5w7l4thAZqTKovgBMqdipTyD82KITGncvOZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=i7nP+sWS; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=inKM02Mm; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jguWWfzQ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SIGPe0004200;
	Thu, 28 Aug 2025 16:07:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=vbZCdf6hhAF2eTVnAJ7djPmnu/FBsxwBitBg5ErR7Xg=; b=
	i7nP+sWSWkSy7pA2U7GtuYSEK+sXeEGF+NXZ90rnjcjMENCPI/UtXbm9I+fGHx3O
	uy0ziVj2n+WCUejMxUXNjp1qFXfcXX1769w9i03hIjDcsy3r5dH0RDCvDYqXG410
	kZpAnc7/mx28depsmlJNbgsuVy2uBvwLuSerig3Y3jgDXewHBbLbqyrIuUjhNKjV
	lwuflfBYmTywkWl5817DfAzs3pUB2gHw5wkkQ+pZ1wBdpXku19l8YEfy15uOwha6
	1feFMTCzdMet4SFOd5um81torg5e+K0w+H/HH4fEyu0zYCVRS//6VzMTUyOVvGyc
	1Rd6FwiImmePIvgRzz0V3A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48qc9dd4h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756422477; bh=vbZCdf6hhAF2eTVnAJ7djPmnu/FBsxwBitBg5ErR7Xg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=inKM02MmrdpfMeje/K3HyKwEMiAnwAT69J7P6Lst1HZXV25TC9u+faEM1mjncGzoV
	 TIip1n17NXZL0xqc32HTuGmA7PayKz0zTSYCFzzU48ECi1qGr7otRRejBsNg65YLt9
	 TPdyYOofxBTjIqSryTemIAabByQ11GpT1DFsmTNu2R8EGPcZR1krlo90KHmappHnY4
	 KIshcIODldk+c6geJgwC8svu6b778lHSV4nORJJtvhS6GWV6Ym3UJ3F7YA8eKLYSEl
	 hlG81UPkr7ihYc3noyDcZhwAJcNvnDTjhFGDZjz4OQl6FRQaKyGUEvEKIUtEF/1/uk
	 IyYEC6kXitGmw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7EF854035D;
	Thu, 28 Aug 2025 23:07:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CBA88A0073;
	Thu, 28 Aug 2025 23:07:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jguWWfzQ;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A6315401FA;
	Thu, 28 Aug 2025 23:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKDryxQn0PMlhWb6vsKucENkYuvr5qp5YrtNrEaG58rY3urX4BlzFl0bWu9F08wuerDRVw+YbXwQWqletC5DLjBtk8zvz8a2Jq8Uk4GimQ3tM+PX95u21a4otlfanl2mqmcpW5XXLUKH577G9EpZylKzbYVcg9gj2bcycuBN+2p+5HDAcg8BcfCg4EIcAodEDOaxqoKJKwNLsivfRehzq/Toq7/y8odG6eA05y+bDnmyVLL8KGTtM5JWibF73ycM+q48DUCtqLgM8YRNDhPeFq+JFQA3Xe9ZDUYuJltgCiXvqXQEpfQJ2N3q0y++BmoG1Ul33QYxdqKebt/uEeZIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbZCdf6hhAF2eTVnAJ7djPmnu/FBsxwBitBg5ErR7Xg=;
 b=CmAzJAVLn54DWti4yF1BYmk952ng03jz6NCw+RMSr6CkU8wf8AC8cUbZyu9YNFhBG1s0h888feddxFwP3LUWTP0mhcLVugd8Wzq+F0GwQ6EEO/VuFz4JVO5/ebjbFYvuWn/aQ7scjPCQ/FQ6SCDHCEVBpIH3dg4njs7B5evHNfr22odwqZfHFGkQc9vKaWI2vV6xhoJKf0rcFzjQX6gTj1aLVkAdkNGNDXRiBclnObINVhKAOPE+1v334g5C7nl6DhFNPe66Fb8K5lMf7AZKRuMZhBMRAyTST718A2BK1XHIOMvNj3D9Xivo1nrsGtuO5N2tdmSPlJo207kk6B+Ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbZCdf6hhAF2eTVnAJ7djPmnu/FBsxwBitBg5ErR7Xg=;
 b=jguWWfzQFuP4eAD8ippNXgiU6S6aOAyn8UZ326gycQU8aFKEqAM+toppe6FAA5TLXEC4qjVjQQukU+1IGXfnuTebGInjs6dcizFVBmmQCGSIlFT3UpIpVyc3KZp749l2EDmeoBvjZs+1P0fnRzluAUMnGlDuA311fDBMGijsrDM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 23:07:46 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 23:07:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Janne Grunau <j@jannau.net>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Sven Peter <sven@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH RFC 04/22] usb: dwc3: apple: Reset dwc3 during role
 switches
Thread-Topic: [PATCH RFC 04/22] usb: dwc3: apple: Reset dwc3 during role
 switches
Thread-Index: AQHcErHjYWp/DJLz50yFjSgGSmwaTbRtwHSAgAQNYICABu3mgA==
Date: Thu, 28 Aug 2025 23:07:45 +0000
Message-ID: <20250828230743.l2774axh67aivjl5@synopsys.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-4-172beda182b8@kernel.org>
 <20250821232547.qzplkafogsacnbti@synopsys.com>
 <20250824131841.GG1270980@robin.jannau.net>
In-Reply-To: <20250824131841.GG1270980@robin.jannau.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB5787:EE_
x-ms-office365-filtering-correlation-id: 0637d4c4-c5bf-410c-539d-08dde687b31b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0RXU3dKdmJNRDc5REllWFk0VzVYMDVJTmUvMVhRNjVDaHVrTzNnOUJzTW5w?=
 =?utf-8?B?NTdPdzBxRUhpZGtGQktUN3BRYVg2MTFROEJOREtQaDVjcnk5ODRRMWFaSi9t?=
 =?utf-8?B?N2dXK1FuSVU2Tm9vUkR4T2FnVHJOYXYzR3FZemFGNEE1dXdsM2c5TzdtVmhx?=
 =?utf-8?B?Sm5hWlcrVHJqaUwzRmlHZ2JHZEFONjdEWnBIejdDNzRZU0xheDhicXpKMUt6?=
 =?utf-8?B?N09Jb2lmalk3ZXhnQ2twUXJjUHowVWRxejlicXRIZmRpb1QxVHJPT2Z4T1hG?=
 =?utf-8?B?ZCtQbWRobWNYeHFZQnlZSGFYVnI3MXYvUmlDcVJVNldIdGdZTGVvdUg2ZnZR?=
 =?utf-8?B?T2JYeG42OEFvTjd1Q1hwMmF1ZHdwKzRrcnRwR2xkaHJ5NWFHSlhPZTUrQnNl?=
 =?utf-8?B?SS9rWlN2TjAwbHpvV1FQSFRTUGJaTE5lWVIzNlczQ282UjBsamZyYURMd0xP?=
 =?utf-8?B?YlVDZWhZaXkzQkd0d2toQ2l2aXh6aFU3K21vNWdBcS90ZlVKVjJtd2R3K1d4?=
 =?utf-8?B?eDlqQnYzaGZVaGRYcDQyVW5Yc0hlSGdDUHZQZlh1cndLUm5pbDZSM2dFUWtM?=
 =?utf-8?B?ZjRyMStLY3VPR1FsaUZxUnl1bTVtWGU2aWZ1VG8zeEgzSlQzVkFMcGJKMkl0?=
 =?utf-8?B?WjE3aGxvUlBlZW9pdGNETWx0RERHRkNmQlh6YTZTalRyM0QyNXlTWm4wTXZJ?=
 =?utf-8?B?ZVpmVngwc2tiZGFaV2EwdXlQcUpMaUxYYW5PTzhVQ1h1UUpuMTl5RHBVWU9N?=
 =?utf-8?B?bmk1V3pHL05malFpbE13a01saHpuWGJWNnlQenNCUGNFdnpxNEtSWG5SVXpt?=
 =?utf-8?B?N0FYSjdrVXVKWHBkOERRaVp6Q2RZS0pYd0twTUlZUGZrdTJzMGY2OGYxQ2Fy?=
 =?utf-8?B?SSs5djBFM1lQbWp0V2tVUjE1cElYV1Bua1lsMlRmR1dWOFFKWGM5Nm1jOUFK?=
 =?utf-8?B?TUdKU1V5TG5uNC9mYlRraFVMbXZxVGpmMFVZbGo0TXZwRFNvWCtMd3F3c3Va?=
 =?utf-8?B?RHM5QXVocTAzaVhZVy94L1ROOUttdDcyY0lYR3JKZGw2V3ljcTIrNHBqSVor?=
 =?utf-8?B?TUtyTXhqQVFZSmhiNWhBaHNsR0hjVnJCRGJvaFlCSi9iZVZkOHNGQTJYL3Zo?=
 =?utf-8?B?Y0s3RU1hdEpwekpHMXNkOStiR3NkZk5TUkVzSnlWVEFoSTRTTEZWVXlZUngr?=
 =?utf-8?B?eEJpUDRzM09nQWNiYVdhOEZwaThLL3JiU3gxOFhmVExOc3RSN2VpeXBhOXQy?=
 =?utf-8?B?bk5CVTVGTGhKd2J6TGdSZUFoMGduK25qRi90WTUwMjJCb21uSnpnalE0SGNC?=
 =?utf-8?B?VmlyWjE0MFdnOU5ydzF6Rys2T2IxUmxjWWtHbENvNnZyZzR1VVNQREhDNzh4?=
 =?utf-8?B?aTRLdnp2UFZIMm1nbHZuVmZoVzM4UTFTTmtoeWtYZXVvalBOL1pBOWZPTEZa?=
 =?utf-8?B?dHRveVE5MjJJUjY3T3lScDBkYTEvL2IxUzBpaG1qdWlkZ1BVcG9JSmdtRy9X?=
 =?utf-8?B?Q2VrRXBodVFSNDVRczRWdGFTTjUyUG9NTkNRdzEzYWp3SzdDUmROeGdiQlF6?=
 =?utf-8?B?TGt2TU04dUEvSTZ4L3lCZ0RpK1JMenE2Q2NMc2dqcm5ZcHRaeXpRR2ZvTW5p?=
 =?utf-8?B?VnBIL2hsem1yazVGVFp0MjRsUFVCQUlkSS96VmtkRGhmbkxtSHVoYVJxM2ls?=
 =?utf-8?B?NjJhUk1MSkY5a2hPSTRGK3ZOcGV2cGJaNGFKSWdvUmpCa0FJV3FBZkJ1Nlox?=
 =?utf-8?B?aWtqVGRGOEluL3pjci8reEdkdHNSU3lGcHVtclhBSlF0SmZ3ZHpwWFZQdUtS?=
 =?utf-8?B?OE1JN3ZVVUZRYm85MFpRZFlqZGIwWmRxUE1GN1ZCaUxVR2E3eXJXdnRxd1FH?=
 =?utf-8?B?SmlzbkR1RkRzc3lxOWhmTkw4dnROWWJUem9LbmtXdTdTQ2xoOUY3eEVTaVdI?=
 =?utf-8?B?V3VJSmJCak93bmlDVDk5YzRJeTFUaHMxV3J0bDZnNHpYT3UvNGx4M1ZwbjE5?=
 =?utf-8?B?eFplOWNYUjVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dExDbmxPVktEbkxRaXRJQWpuSHpDMEY5eG9aa3FXMjJrdFZaV0h6R2RJQmJZ?=
 =?utf-8?B?RGxCMDVYUERJRFprWjdiZWtFS3c3SXY4QjFwY00zZFlsekhIZUN6QzZnU3BJ?=
 =?utf-8?B?UHZCZjQzQitBT0xFTU1YRFgyeHc3R016NHZtRFJxT2ZvVXpUbmpMb0RCM0Y2?=
 =?utf-8?B?SVIvRkR1c05NL3JmbWxxT3dkcUVHMDhObHRZWmRzOHdXUjZXMm1wSUx3cUV0?=
 =?utf-8?B?dG53TEtqZUFDQU51K2dydlMrVmEwVlMrbmpaajI3MitnZlpXTFltb2lVbHpC?=
 =?utf-8?B?cXN3Nkt2MkFLQmVnbWhOK1hRVWNoOFoxREg5ZEQ0TlJsWTRsUVRWbjlieXFr?=
 =?utf-8?B?OUl6VzNNeVErdXVCVGVuY3AraVlMbmNGZHQzSjRyT2wzVURIeU9TUU5xYU8y?=
 =?utf-8?B?TXBvYW5JSGdkdW02NGdSNHdhb2Y0UHJDN2ladnduQ3NoUlEwMFRRTFEwWEZx?=
 =?utf-8?B?ems0RWFiTWlrSEQ3eFJoQWZ1N1pFNG5ka3c3ZkR1SCtPR0RFdEVIQUpWUzU1?=
 =?utf-8?B?TlV4TklzK0FqMG5Xdis0d05XbWRoemdFZEJ6OVBvMzRHVzVlbk9uUHZ1MUNz?=
 =?utf-8?B?dHhLU1crUHlIQ3lpQUtZTFRwL3NVeERBTmJtNFllKzhpdFk3eldzTlJwTFRa?=
 =?utf-8?B?bHkzcDg2U1ROZjVRQ0czVW9BZ1I3djZzK1JITDdxMjcvUk9HVDVFd3Arclhh?=
 =?utf-8?B?UiszQXVCQ3pNVVF0SmhkRTdLRGtHL2pyNmhQY05MWVUrbzVYUDdFZ29GN29r?=
 =?utf-8?B?WWhlY09wWWxkTDRPc1FDcDRaUzB6NHJxYnJHUG1xUnJMaU1VeTVmY1NsQTZ4?=
 =?utf-8?B?L3lUOFFZbDFFYVloTUtEV1UxUlZNWVhzN2JRRTViS0FMRFUwSXhrRmZuTmFx?=
 =?utf-8?B?eFVLcm9zcmZWZU5UODRVUkJORE51WVdoeWY0OEZab3ZHYnlYQlIrOG12Qjl4?=
 =?utf-8?B?dVNYYTNoVTczMnlFZlZ1WHB3b1lnR1liSjRCN0hKNStNazhGbW5IK280UWl4?=
 =?utf-8?B?aFkzaitwWDVxcTF2MDNocjAwRU4vT2xoOFNBaUsvMXQ4WVlFTXc2TlhxaUZ3?=
 =?utf-8?B?YkthbE0rUzk5c0t2cG56czRvSjRXV2xwcVZjQ2Zod0pQS2N4T3c0VzR1NHBr?=
 =?utf-8?B?alhHUHFtSm5ENzBZbDZReEdIQzh3aWI2QXR2SStHWUtFSDY4S0ZWeGRlbUk2?=
 =?utf-8?B?MkRwNlUzS3JBMnRIakhzaDByMWxOTnZzYXBrSkVRZHBnemwrMkxCL3FlNXNv?=
 =?utf-8?B?cy9EQXpiVS9ISVdoQW1UQ0V4L0wyTWpMR05vanAxV0NmT3UxZWVNanV0a2Yy?=
 =?utf-8?B?bXRZRnVCUUpFVHdEYmxiUWVGSVJNOTBoY2RtVzlibStubERCUlBHUlhZZW5w?=
 =?utf-8?B?aEtUNk81eW5ZMlM5cUp2YzFJUStqRDVsbno1U20zRGt4TTl0ZE42dWJRSmJz?=
 =?utf-8?B?QWVyZVFES0s1dEV1SjVwM2hPVjJ1L29SNzZnN05nU1RBbU93c3pTenBMcmtr?=
 =?utf-8?B?N0ZPSDNMaHN5V1NpY3FveG8zNUNXejQ0VTY0YThjdHJ2VmpDeURkVnp6K0hZ?=
 =?utf-8?B?cldYK3FGMVFJekV3bWVUWDVXc2dFSENxOGJxMExNODNuMFB4MzhRaXVVbmRX?=
 =?utf-8?B?ekxUWGtkcDZKQjQvQ0tTV1BvSUJPMy9YNGNhTHZLay9aNWRWUU0zc1RLS3FD?=
 =?utf-8?B?cmowdFhFRUozcVVjRWpIeTExM2FnL2g1U3hPYjU1TXVkNytOUUlOazB5cU50?=
 =?utf-8?B?TkkvMDE5dnRkenJSbnlJYzIvMk5Mbk5KRmt4ZStFTGtvS0JDdE04by9Sanh0?=
 =?utf-8?B?Zmc1ZFpoOU5URGZjSHE5aU02Q3ZUbVQzanlHSWtBWWNGa3RtcC9EWE51bENT?=
 =?utf-8?B?Z2pPMWdSaDNZY2dvcmNJMlNqVDd0K3k0ZXZKMTJlOVo1bVRFYmlsdGFVWkFQ?=
 =?utf-8?B?NnpaaXczMnJPc29BTkRMRlVVSkRGc1ErWDJkRUUzOWVoL1lSSTd0MGVJdGNr?=
 =?utf-8?B?MXVUbTFDOWRCOHM5VlJQVStLT0E2TkdxSVVzN2w4UFlWMWZYaVd1SkRjSTVz?=
 =?utf-8?B?VFVhb3Vwa2gxZGgvNE1wYkRua2hNMFgwWWdPdXlkTm9oenpoajFPWnZjOUpX?=
 =?utf-8?Q?BNhI1irmE9tUMAn8GHKKfk4+L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FF1947CBE360E489ECC096F866FB697@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iZj6njG4+400mxrehgvrTmfwhaHRSsAp8orWwv+36s66ZBDbq9H8nl/Umezp44m6aFGfFusu8PRbeTN2jFgBw/WY2y7LdK3jGzfcGXxjTabQNczaUHv2zFwRk2SEA0zyeAFYM/oA8vop0562pAmcwfeq5wXjBROQHTWY7wfNyu/ow86NLhaFdGWdItbNzsBUI16raVt0ewwZX8KK5kq4QQ/hM8Ytc/XYeV+2cGyNRvboGvr/tpaUDQJcppBsZH42HsBu8mTX0KszC7vpQC+hQ3Ec1lhtn0Bsw9TGo1+a/7IJAc1eWcZJjjxRohMwec/le0pZklIzf7YGZDD75sAnM2QeAARmaN+we4CA7wEquAKgdz9Ltd8D8vmwR8pl40PxGSkuigFuwY61VIDJxFJ8Jc9Il2tY+1a+D+nDN07KKNEp0T7cgHY0iJOS22f/4m4a1jMX23B8J6scXL9Avbf7hpo3YnxS+3zowR3ql1FB6ypkEGpU2baTrf1ixiXruRRLoEfAekXskbzUz+s0Q/gmxafXud4Sb+U6AB97MOyJmA4zZ19sEUqJUrUgV5wEzTqTSDBnrZ6w/v1ks/A+8Bq0YUb8BmZh2d61RScsdAVF+gBbcaxuqwIPXXn77VBV76r+bAVul8ym1VCB6xO20dpEXw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0637d4c4-c5bf-410c-539d-08dde687b31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 23:07:45.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecD8UALTeSdrjGYuh7rixqMIfX9IDCfRlkuYmfmibZlIYPANMTJKSvkz1lund4eLOmW8FgR0Sy/UyW2JE91Xxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDEwNyBTYWx0ZWRfX2KBW4nVS4Y8Q
 fJNmxldKAHJzIMOlb3Il2K3evhQeZCjWVTHQkzXz5KY5zEMivSkBAdmqOpT42+SzvhjSCbIlPPO
 0RgKaddUQe8/waU7A27Roq1A6SMexqG9cySbq66WzOgpA+amI/ZjneP47vt5t29pmmsz2yzqVuV
 5TJD0u4rOIUYx+Esxw9eLxC+IaePH7963FBPigTEaia5MDsCJS8/23hMqRuJEfZZu4VvcLkzxjO
 xcB7qIn80eA/r8KJYrzqVzz5fIwNZcwr6y+hsX8jydGs/8M0ODy0/hTniv4bIytezibhMI5uiHr
 Eg+xogHKZ8seDAScmFd6K/pwSuf8D67soqgOg/KydsjQqxNQhlxntD+yZOCD0xhX5Nj8pvspxqx
 j6RYobaX
X-Authority-Analysis: v=2.4 cv=TbGWtQQh c=1 sm=1 tr=0 ts=68b0e14e cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=or6s5TGVYFTeFFg22sUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wLHdI6w3Y0f-O0OTQP0gbiBDWNMjNDHq
X-Proofpoint-ORIG-GUID: wLHdI6w3Y0f-O0OTQP0gbiBDWNMjNDHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508230107

T24gU3VuLCBBdWcgMjQsIDIwMjUsIEphbm5lIEdydW5hdSB3cm90ZToNCj4gT24gVGh1LCBBdWcg
MjEsIDIwMjUgYXQgMTE6MjU6NTFQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9u
IFRodSwgQXVnIDIxLCAyMDI1LCBTdmVuIFBldGVyIHdyb3RlOg0KPiA+ID4gQXMgbWFkIGFzIGl0
IHNvdW5kcywgdGhlIGR3YzMgY29udHJvbGxlciBwcmVzZW50IG9uIHRoZSBBcHBsZSBNMSBtdXN0
IGJlDQo+ID4gPiByZXNldCBhbmQgcmVpbml0aWFsaXplZCB3aGVuZXZlciBhIGRldmljZSBpcyB1
bnBsdWdnZWQgZnJvbSB0aGUgcm9vdA0KPiA+ID4gcG9ydCBvciB3aGVuIHRoZSBQSFkgbW9kZSBp
cyBjaGFuZ2VkLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIHJlcXVpcmVkIGZvciBhdCBsZWFzdCB0
aGUgZm9sbG93aW5nIHJlYXNvbnM6DQo+ID4gPiANCj4gPiA+ICAgLSBUaGUgVVNCMiBEKy9ELSBs
aW5lcyBhcmUgY29ubmVjdGVkIHRocm91Z2ggYSBzdGF0ZWZ1bCBlVVNCMiByZXBlYXRlcg0KPiA+
ID4gICAgIHdoaWNoIGluIHR1cm4gaXMgY29udHJvbGxlZCBieSBhIHZhcmlhbnQgb2YgdGhlIFRJ
IFRQUzY1OTh4IFVTQiBQRA0KPiA+ID4gICAgIGNoaXAuIFdoZW4gdGhlIFVTQiBQRCBjb250cm9s
bGVyIGRldGVjdHMgYSBob3RwbHVnIGV2ZW50IGl0IHJlc2V0cw0KPiA+ID4gICAgIHRoZSBlVVNC
MiByZXBlYXRlci4gQWZ0ZXJ3YXJkcywgbm8gbmV3IGRldmljZSBpcyByZWNvZ25pemVkIGJlZm9y
ZQ0KPiA+ID4gICAgIHRoZSBEV0MzIGNvcmUgYW5kIFBIWSBhcmUgcmVzZXQgYXMgd2VsbCBiZWNh
dXNlIHRoZSBlVVNCMiByZXBlYXRlcg0KPiA+ID4gICAgIGFuZCB0aGUgUEhZL2R3YzMgYmxvY2sg
ZGlzYWdyZWUgYWJvdXQgdGhlIGN1cnJlbnQgc3RhdGUuDQo+ID4gPiANCj4gPiA+ICAgLSBJdCdz
IHBvc3NpYmxlIHRvIGNvbXBsZXRlbHkgYnJlYWsgdGhlIGR3YzMgY29udHJvbGxlciBieSBzd2l0
Y2hpbmcNCj4gPiA+ICAgICBpdCB0byBkZXZpY2UgbW9kZSBhbmQgdW5wbHVnZ2luZyB0aGUgY2Fi
bGUgYXQganVzdCB0aGUgd3JvbmcgdGltZS4NCj4gPiA+ICAgICBJZiB0aGlzIGhhcHBlbnMgZHdj
MyBiZWhhdmVzIGFzIGlmIG5vIGRldmljZSBpcyBjb25uZWN0ZWQuDQo+ID4gPiAgICAgQ09SRVNP
RlRSRVNFVCB3aWxsIGFsc28gbmV2ZXIgY2xlYXIgYWZ0ZXIgaXQgaGFzIGJlZW4gc2V0LiBUaGUg
b25seQ0KPiA+ID4gICAgIHdvcmthcm91bmQgaXMgdG8gdHJpZ2dlciBhIGhhcmQgcmVzZXQgb2Yg
dGhlIGVudGlyZSBkd2MzIGNvcmUgd2l0aA0KPiA+ID4gICAgIGl0cyBleHRlcm5hbCByZXNldCBs
aW5lLg0KPiA+ID4gDQo+ID4gPiAgIC0gV2hlbmV2ZXIgdGhlIFBIWSBtb2RlIGlzIGNoYW5nZWQg
KHRvIGUuZy4gdHJhbnNpdGlvbiB0byBEaXNwbGF5UG9ydA0KPiA+ID4gICAgIGFsdGVybmF0ZSBt
b2RlIG9yIFVTQjQpIGR3YzMgaGFzIHRvIGJlIHNodXRkb3duIGFuZCByZWluaXRpYWxpemVkLg0K
PiA+ID4gICAgIE90aGVyd2lzZSB0aGUgVHlwZS1DIHBvcnQgd2lsbCBub3QgYmUgdXNhYmxlIHVu
dGlsIHRoZSBlbnRpcmUgU29DDQo+ID4gPiAgICAgaGFzIGJlZW4gcmVzZXQuDQo+ID4gPiANCj4g
PiA+IEFsbCBvZiB0aGlzIGNhbiBiZSBlYXNpbHkgd29ya2VkIGFyb3VuZCBieSByZXNwZWN0aW5n
IHRyYW5zaXRpb25zIHRvDQo+ID4gPiBVU0JfUk9MRV9OT05FIGFuZCBtYWtpbmcgc3VyZSB0aGUg
ZXh0ZXJuYWwgcmVzZXQgbGluZSBpcyBhc3NlcnRlZCB3aGVuDQo+ID4gPiBzd2l0Y2hpbmcgcm9s
ZXMuIFdlIGFkZGl0aW9uYWxseSBoYXZlIHRvIGVuc3VyZSB0aGF0IHRoZSBQSFkgaXMNCj4gPiA+
IHN1c3BlbmRlZCBkdXJpbmcgaW5pdC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU3Zl
biBQZXRlciA8c3ZlbkBrZXJuZWwub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tDQo+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAgMyArKysNCj4gPiA+
ICBkcml2ZXJzL3VzYi9kd2MzL2RyZC5jICB8IDExICsrKysrKysrLQ0KPiA+ID4gIGRyaXZlcnMv
dXNiL2R3YzMvaG9zdC5jIHwgIDMgKystDQo+ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA3MiBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gaW5k
ZXggODAwMmMyM2E1YTAyYWNiOGYzZTg3YjI2NjJhNTM5OThhNGNmNGY1Yy4uMjZhYTUwN2E3Mzhm
MDAxNDA5YTk3ZWY1NjNjNjU2MTQzM2ExY2FjNSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiAN
Cj4gLi4uDQo+IA0KPiA+ID4gIAkvKg0KPiA+ID4gIAkgKiBXaGVuIGN1cnJlbnRfZHJfcm9sZSBp
cyBub3Qgc2V0LCB0aGVyZSdzIG5vIHJvbGUgc3dpdGNoaW5nLg0KPiA+ID4gIAkgKiBPbmx5IHBl
cmZvcm0gR0NUTC5Db3JlU29mdFJlc2V0IHdoZW4gdGhlcmUncyBEUkQgcm9sZSBzd2l0Y2hpbmcu
DQo+ID4gPiAgCSAqLw0KPiA+ID4gLQlpZiAoZHdjLT5jdXJyZW50X2RyX3JvbGUgJiYgKChEV0Mz
X0lQX0lTKERXQzMpIHx8DQo+ID4gPiArCWlmIChkd2MtPnJvbGVfc3dpdGNoX3Jlc2V0X3F1aXJr
IHx8DQo+ID4gDQo+ID4gRG9uJ3Qgb3ZlcnJpZGUgdGhlIHVzZSBvZiBHQ1RMLkNvcmVTb2Z0UmVz
ZXQgd2l0aCB0aGlzIHF1aXJrLiBOb3QgYWxsDQo+ID4gY29udHJvbGxlciB2ZXJzaW9ucyBzaG91
bGQgdXNlIEdDVEwuQ29yZVNvZnRSZXNldCwgdGhlIG5ldyBjb250cm9sbGVyDQo+ID4gdmVyc2lv
biBkb24ndCBldmVuIGhhdmUgaXQuIFdoYXQgdmVyc2lvbiBpcyB0aGlzIHZlbmRvciB1c2luZz8N
Cj4gDQo+IEl0IHJlcG9ydHMgRFdDMzEsIHJldmlzaW9uIDE5MEEgYW5kIHRoZSB1bmxpc3RlZCB2
ZXJzaW9uX3R5cGVzDQo+IDB4NzM2ZjMwMzUgKE0xKSwgMHg3MzZmMzAzOSAoTTEgUHJvL01heC9V
bHRyYSkgYW5kIDB4NzM2ZjMxMzAgKE0yLCBNMg0KPiBQcm8vTWF4L1VsdHJhKS4NCj4gDQoNClRo
YW5rcyBmb3IgdGhlIGluZm8uIFRoaXMgdmVyc2lvbiBzaG91bGQgbm90IGJlIHVzaW5nDQpHQ1RM
LkNvcmVTb2Z0UmVzZXQuDQoNCkJSLA0KVGhpbmg=

