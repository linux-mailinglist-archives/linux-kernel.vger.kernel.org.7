Return-Path: <linux-kernel+bounces-757113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D53B1BDE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D3518C0212
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5744F72633;
	Wed,  6 Aug 2025 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HdcvrRxL";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Hz+KRCQk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="StseLVZK"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877345038;
	Wed,  6 Aug 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440021; cv=fail; b=Dr5F2qxu4MWkLUFXqomQ+nmHbALqK4+IdA8wsQ2t45FxehsSXA7//PiFQwd6Qy096NsOLCB3aLozbPxHaDZ0m0S7znjlAMlgULAthknG1b0gwUrfuHYRcriCk6nxFyKlspp6153waiE1Hxe0F7wI/1J8zrTRCzNsEYZ8yOn4CMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440021; c=relaxed/simple;
	bh=vdUb2MFzsa+Sgpoj85DczSrLIiGOj0XTM4Hq+GKdLEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rTHexnqXnVSmF6ZxPzmpDx0n4IATos791gfAzYkqspcXfRUEPCDj1+VAtp4kjoQB81ebMkVAlhEMfGhxcgWfCUo6WUboeFIw5EtSRzYR3PIeUtTvLSVSWdF6mf9QiW3unhePwxTT9ueJ1ovd2CGrfSzDZfe6vhUOQ68HL3FhpWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HdcvrRxL; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Hz+KRCQk; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=StseLVZK reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IAh59001004;
	Tue, 5 Aug 2025 17:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=vdUb2MFzsa+Sgpoj85DczSrLIiGOj0XTM4Hq+GKdLEM=; b=
	HdcvrRxLJmccTdj8ZUV6LSF7DQ6M6ive2sKJLgvJZJGQFw2q1v9hF2ij6XjPLOrr
	7fRJym2qyVjFDStfk7AYKTaEv5OED1A/DHT7khjHTjGFyRoogingNftttHVxRUhE
	rvjqXqbhgQ4zo+ephDU7VOOXIBJ6PSvQWrhGX5FWnPmoBCXSRGwFbIrrFcprUkTg
	Bys0eBHXl1BLTZM1yUukehaGgFBaSWLNSaL2GQSyL+6KEyUctIPwwSLAQNmfCNqu
	U8eplGp2/cTaE7p7Qn3k517EYnI8rMClE5Q1jv2xfuIWLyRhQhSMshJtbb3RMQ0i
	glqgmb0fdCrbkMNp2F71AA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48bq0r9n62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754439974; bh=vdUb2MFzsa+Sgpoj85DczSrLIiGOj0XTM4Hq+GKdLEM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Hz+KRCQk12LFdy8DF3X3cWKtOGm23wGuLSTCv67C59IYpEgxENhit069fArG6Ako9
	 akECRv0+rGRNtvw78HXstig2zenZeupRx3mBhyGbsqWNH7S5mI73WvZybjpsMDFosT
	 JFF2nANywIEtzMCWeHD/fZdRZSqVQkmCQZy+AguJR9z2y6NrzqV3CC46AV+eG8hPye
	 1x91iPniq7rzDLpcSjd8TkW+NtDbWaHLkTVGDSOCMSIhbCSnIEJyTY4MDg2UVDvSyf
	 f8F1FGk2b6INYJYxb8n+qCny1kDtPyqKAgnOq7s02DyVmSkmKUN0Vtrz1ad9NIflxR
	 nDS8yHe0eUUlA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F09C240349;
	Wed,  6 Aug 2025 00:26:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E87FEA0075;
	Wed,  6 Aug 2025 00:26:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=StseLVZK;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DCDEC40533;
	Wed,  6 Aug 2025 00:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqFJqERijD1yPkd2eMQI+mYF1UlpnbectufSNJXzezOTOvjsp6xkBFXiikoqbK+beUD6q/0gCUeDZDOoLbFDNuYN9jFHBBZUAFcBy+hPMcFxyT+JCJDqtEPjepWGVjKwyLhhOy1w5BYPAwGuGQ8Ibc7rXPG1jx8iwJw/KB3kKUelchfRdi6QlLdHqfJelBXfsEv48l9dYLbd3ywbB/Si9HqaY6/HVIBh/+Sk++ESwQAczD94DKzzKYHie4M0babeQ14qN2QRX/oTHHmLZCQb7cDMFfyQPqNNdpKEmVMfP7GPzm0uo+/AFwar3xhodKWJpUsVfRymYdg0/J7ead+4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdUb2MFzsa+Sgpoj85DczSrLIiGOj0XTM4Hq+GKdLEM=;
 b=aO0LU+1hvYPRKdQ0v3fGktZLJfi4Dms2jP45wb3MKEzDtgm1POvhLhGfCisIS0YD6x7nJ2gxBldu8oBNgx1k8yllcXZNRf0QcApahGYbWsxvFNpAXJt+YB7q0QCBX3qv8xfnGmKrwBMX6St+i8F+JFAE6mJmLwN5lJBd1WrMSsC+D6YOL8AC4y9kp4oEu3KEWHlD5gSKn9l0WgSTIgR6RQjjA24/DjY5QM0Wp2JuX41mAWVFmHF5OucLKRWSKdNksdENW2eJ94nyX8aTd2Xw/90Z8HGLfbgwsMIIXL/m/F/vNNoZbyQjdRJ/us8R6ZBOZsacMDX54is/7AixDqPDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdUb2MFzsa+Sgpoj85DczSrLIiGOj0XTM4Hq+GKdLEM=;
 b=StseLVZKE0oDCuRSiXcAkCqt17VNMmo+riIFG8d0uh4gXfT8PT8gaS1SnuiMpMzYuYF8l+xGThvp56fSvItLarNIWE+MCqrliMAqy7uFvU94jhJsSRg52v6/kKFURS2ujVKISOEctU2oBCwqSMkT6kAVNskZOzFkKew1TyBUmm8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Wed, 6 Aug
 2025 00:26:08 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 00:26:07 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Ze Huang <huang.ze@linux.dev>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "spacemit@lists.linux.dev" <spacemit@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] usb: dwc3: add generic driver to support flattened
Thread-Topic: [PATCH v7 2/2] usb: dwc3: add generic driver to support
 flattened
Thread-Index: AQHb/919tIbyhD3OhUCAdig/9wgQ9LRU0aoA
Date: Wed, 6 Aug 2025 00:26:07 +0000
Message-ID: <20250806002606.sz4s3thebvgvrqyn@synopsys.com>
References: <20250729-dwc3_generic-v7-0-5c791bba826f@linux.dev>
 <20250729-dwc3_generic-v7-2-5c791bba826f@linux.dev>
In-Reply-To: <20250729-dwc3_generic-v7-2-5c791bba826f@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB9504:EE_
x-ms-office365-filtering-correlation-id: 257b74a0-2471-4fa5-1526-08ddd47fd62e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0hWTnhwTzhXampmbDJXbVRaRUdZNjFIMGVHM2ZJeUJqdmsrWmNlNm5nMTh3?=
 =?utf-8?B?TzE4ZFM4VWxFUCt6Q2o1OHZuVU5DMW03alVURUxzakF4UUp2cG1VYjJLNzAw?=
 =?utf-8?B?UE1vcElmSDNCRlJWMjAveUFZeXp0ZjJsTHZ6ajF5dkJwZFdpMkVybkRLa2lt?=
 =?utf-8?B?SzZuNCtQb1o0VWRZeEp3R3V4WmlkNmdacnBON3VaclFVOENqaVNnQThwK3Z4?=
 =?utf-8?B?SjFMQWMyeGJPWUp4bkVxM3ZCbWlDRlZ6bjZGdFBNQnFjMHJodnUxNFVqVGdP?=
 =?utf-8?B?Mk5mUjFQbVgvTnlaMGRTNXQ5VmNhc0kvTmNyRmpOQWVwbEVCTDBTVlArT3Ay?=
 =?utf-8?B?NG5FbEU3TnVYbUl5Y1lmaTRmVG1JK0pWNGR5K2I4SzlzdHorMmVPVUptOXBU?=
 =?utf-8?B?L0MzZ0QyalJnUlF3TkxWZ1NyMHNQWTNuSUlGNGwzU1FBeDVadEFCeFlZY1VJ?=
 =?utf-8?B?ZmxtSFZWZS9la2JNcldrREFsZjJrZkpVWC9FN2hYM1paQzNMdXRhZjJOek1s?=
 =?utf-8?B?UERpSm80K0pVUXE1aTJvR1pSUFlDOE5BazZSU1k0VUQ2NExYQXcrMElTdE9o?=
 =?utf-8?B?L2szQnJXY25CU25KSzVYOHVmZndxbmdxb0p5Skh4b2dDOUs4N2tNRnJ5Y2Rp?=
 =?utf-8?B?RXBrblkxUFdZaU5ac2tPTGlBSVMrd3JTUzBvSDJGWWRTRXM4SUdRbENia055?=
 =?utf-8?B?bTNOd1cvcktRSU9XZVF6bVZYRnJmK3lwaXh0bWdmK0ZSV1hEZGhJaVJncTBM?=
 =?utf-8?B?UTBXMWo4K3BOSS93S3VtZ3FlYzJNRFl1WFpmUE5qQU9FL2xVd2JmajM5TVVK?=
 =?utf-8?B?bnFTYk9la1huTTFyYmR5TFVwOGpsWTJyaXFWK0xlK0Q4M1lsclVWUDdmczNx?=
 =?utf-8?B?c1lpSjRQeExBckdoU1RPajI0a2FNUHRJNi90VVlYV2dyNzNjM0tpbVJkVkZZ?=
 =?utf-8?B?SndpdE56a0k4bXpNdjB6QStqSFl1djAvdnpzYlpUeGpPdElxMS9rYlRQencv?=
 =?utf-8?B?d0dVNmxVcnBVaCsralZkamNUOXVPSVFkd0Rva2RzdUx5T1BTMTZqaG9rQjBh?=
 =?utf-8?B?RXoxeVJ2S3JhWm5UTUkrOVJxQkN6VG16TW9ocGdEOUdocVhzVHA0bTNIeTgy?=
 =?utf-8?B?Wk1Jc0twc2hHYnFXbnVHZDdJQ2Q4MW90TDBkK1gyR2NteDdSTEdaRFdYRCtT?=
 =?utf-8?B?a1ErTkdKNE03eHprQzhvL2U1bGxsek5CZXNXUThlMjRkUUdXTjZ2YzFIZGpL?=
 =?utf-8?B?S0QzRGFmeEkrc2ZDbEtUMEYzVGd6SmV2MmJUNk9vUzhlOUt1ZEJ2cHhxYkZp?=
 =?utf-8?B?RjM4cVFRZndiZ0Q5bjlROVJUNzdFZGxSbWZLd3hGN1BRRUNMU0lJUWVabzQ5?=
 =?utf-8?B?U1VlU3pQRkxJL21lcmZpa2dIZnU2dGpqSEZoaCtHWVFlbzVJZnJ1RVNjUU9l?=
 =?utf-8?B?dmVJSDlMbUdFT2NZUU15MVdGVmFpOCtnSC9yOG5IQlJLQmFkVHdzM3I5VElX?=
 =?utf-8?B?T0FqRTBFQTVuNW1FUjdtQUZ1aElaV05SVDBHeHVKQmpJTnp3UnM1aVU1bDA1?=
 =?utf-8?B?UVcydk56TkxIb1lOTGFaS1pFSEZOOVhtcTIxUzVYMHNDT1RBZ0JTcW5ldVNo?=
 =?utf-8?B?M01yU0N2WnZLTEZBbXZHQjU4QkNITUpTR3k5RjBUMUVKckUwTnFSQlYySDJo?=
 =?utf-8?B?VWtnVzg4djdYMFg3TjJTR042N1pmRjZYaEdMbmdIVDVPa2FERFVjN2VtSTRx?=
 =?utf-8?B?OFNsOFBzNnI1RVo2OTRkY0dPQS9WM2Evb2pFYzZNalQ2eVZwb3ZFRHNRQS9Z?=
 =?utf-8?B?VytZOXdBL0RmVG0xN1JwZ2xzMGFLTjBEVHZmOVgvSmpYL2lYWDJhWHJ4dWZB?=
 =?utf-8?B?emNmbUVmdzkrOC9Fa051eHdBYWUzTG1yc29zdXRVWlU1WUo0S2c4d08xWCtm?=
 =?utf-8?B?a3NpeGZHS0JQNU96UXdmWHdlaERWbjBQbjVmeVNtcnVUTlZmeGhZV3FGVVEx?=
 =?utf-8?Q?/DmMkxETqesyXD/Y6cEQjfws6P2ZA4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTJJT3N6WFFFbndDTkNBcTNlVnVjQnMzR2o1R0xYeEN2c09uOVUxQVBwNE0z?=
 =?utf-8?B?d3ViK0F6Smh1U2QwZlBJNGhBemNqMHFXSlVPSjc0WkxiaUJRakMycVhJNUFU?=
 =?utf-8?B?WjNhM01CQjduYlZpd2lwUjBXNWxwK0RJcjA3bXFPTkJvWFNGN0pEb2NMNXBq?=
 =?utf-8?B?ck5xNHluemg5Z0R3SllKT3FvbmtaRHRaSjdFWFRnNGdCc0NZMGNDS2tmeS9Q?=
 =?utf-8?B?L3NHT3puWmNZbHZCZzUwRWVlKzVBdGFER3lHcHJVbUxKRDEreU16T1pMUCtu?=
 =?utf-8?B?MWp4WTh0UEFHTjdpL2tDL3BRODBGSm1wWC9SakQ4OWFrQ25WeXJCdG91aXk2?=
 =?utf-8?B?NDRHR25KOVpHVG9vMFJnK1pCdk5sd1NWcW05UE1pNFNSOFpNRElveW9NZzFK?=
 =?utf-8?B?cTh3YUhZNmxyUmhpRnJBU1RhWVRiaHB5bytUbWtZZ1NTYzR4Y0hHemlZeTBT?=
 =?utf-8?B?Tk9OeE5UdnphNjdoRUQwSllMamVXQjNyQ2Q1N3p5OUZLUTdSKzJCNEx5Z005?=
 =?utf-8?B?NW1kUjR5M2NuemprckRWc0k2RDVEOTFDZkRuWTJuOGMxOWdoUkpwSWtjUGZ1?=
 =?utf-8?B?cklWZjMvT3lSdTlrbGUrRzZCdEhMb1doUEp6RDZHdU1oa2RkNUpXbzREYXVN?=
 =?utf-8?B?R3pORmI3dm8wVGtEUXZrWkZtYkp2N1NwSnhicjZMb3lhVU00MW9PWUk1aTJm?=
 =?utf-8?B?L3JFTnc2L3BiN1ZINzNXN3l1cDl4dXlGeEdhcXY5ZGllUEJWc0hxaVZKLzE3?=
 =?utf-8?B?SXVNd0xFakpGMGl1WDlCMEVOQ1F0d1FjWDBhMHF2cmMxcHN1SjRsaE9RK0VG?=
 =?utf-8?B?N3R6bWxiWXl3QnVPK2EwcVRIVGVFcjcvQTYzTWRySnhOVTVwZ0pXV0pnSU9w?=
 =?utf-8?B?K08zd2xXcmdXS3NjMmhnaVBOUWM3bnFuTVRoWmVsM3Z6SmRHWHQ1VTkzdXRH?=
 =?utf-8?B?LzlKMG44SzNsd29hVldnVzJjdTJVQjVUSW9pc1hqSjgweTVHeGhJWUdsYnA1?=
 =?utf-8?B?WDBDVlhoRWljTHdybE54MURhMnU4Qk5Pd09veFovTDdHUTBJdTNuaHN1K0ZD?=
 =?utf-8?B?dnladXE2QUx5dDZWUjJRS1cwZnNuN3MvSHVoMHFFWWkvaHRiaDJwdk54T0Jv?=
 =?utf-8?B?U3c4TTg1VG5xL2NjbjRxbjB1S3hwMk1iUmhZeC9SV3ZLZnk0blFRdFI1Q1ds?=
 =?utf-8?B?em5QT0w5Sjl5SU1NRVVsTnhRMkI4RlArWTBhdVh2K0RlRkIyc25IZHFuUDB2?=
 =?utf-8?B?Mnd2NGExTFJzOG5RVVNOOTBDTHJIK2tMVnVmMldvTGZxZnZSK2g5QmNOMkU4?=
 =?utf-8?B?aGJkYU1qVWg5Q0F0eTZ1RmZ1cmRWQzJVVjg2UHJiS21RRnVJS2poMnRhbVhW?=
 =?utf-8?B?NERJZ2ErN3BNV3ZSNVdjN2d3OEFLUWoxRFJCMktSVFY1NStEWjJ4Ymdrdzl1?=
 =?utf-8?B?eklTZmxLSHZvOXhOWTZscTQ0c3h5enN0cWVuSEZCdk9IVWhYZDlLTzBjR2Ra?=
 =?utf-8?B?eUxibzZ6dE83QTExangrOWNYSjkyM2o0M3pmU3pyQ0o1WEpTbmtFSDlZRVB1?=
 =?utf-8?B?MjBMY29TdTJVK1Qyemo5UnNMSVNSZG56RVlUd1NhNjh0MnhhcjlkYVNIeEZh?=
 =?utf-8?B?WGcwaEhoWThYMzVKZDVMdU02UVZnbTZndURBbFZjbTJ6cmYvN2tTcTk4Ymlo?=
 =?utf-8?B?WFVaTCtRcmp5Rlk4bk5sYWRHdlVkWVVRQWIyc3NSL0pBQWY4RnljQzY5UXhY?=
 =?utf-8?B?M1dDTXpKTFNjYm9oK1VZSEcxSzRGanF1NzhWYzVSK1dxSzVTak05bmQ2c0NT?=
 =?utf-8?B?T2FJNkx4aGJqVlFNL2dXbzEzanE4THVWUzVPTEZYcDBIZ21ncXE0U2NIenhl?=
 =?utf-8?B?V3F5dFdoREZIWEhIYTNkbDE5M0Z2d1dvck1WN0tBVG8wZjBsMlprNXRqbGo1?=
 =?utf-8?B?L3dpcHRyMDFHQ1ZMbDFYczQ1eUt4VTRQUGRSZVVabTNmcnlyWTlJV1kySnlz?=
 =?utf-8?B?TjJEZi95a0FzbHp3ZnR5amtmajNCVWhyR2RoYVpySUZxWEtoZ0IrVGNDQzlN?=
 =?utf-8?B?bUxLUWVjR0VsVkpVb21jUFh4MEo3dnkxc1pqQ1U3WUVmTGhwMVQ5dTEzSzlv?=
 =?utf-8?Q?o0CgUyhX9p9rJ6VBZT1K0lhXG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACE433DD10CCE646B6FEA52DC5676EA7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t74gp+PLurbJhOxzJXSLwYRvqo54/fFyyPQYqJl8Sn72LWtXW5UzABs7fb7DoUOFtiCkIKsENTK1LaOOolwZKR7b3vXFccZFD4UblSCQUhJeSPYEeGy/McIHjp85Nb3UTT8NuUTniXx4yUauWTe5GNi2aQJRIULxulLjEr+VmKMJ1FRoCqekFWQhEE3anQ/WxApWMriMagWAcYnKtQ9LdzaJquvYsOV+yRF5479wVURNFcecOuSgUWvbdoy7Xe8x17nPp2T7gVXPxvLU3Yiu6Jac0zMXfNLpDmlYXZgav2x8IXFh/ihBmSsRqg62wrhDaqLMb84lxhInzMHzaZMAALv5Clv7D1akmdlFtR54Af0RafGSimyr/JI4F3E6G2cjrVAURgJNFzPawn1jCIc9AyIORF4TyqiOAFnAYnAACL65r1akwR4/F1RIyh/62N24FKGaWSZWFYmydmJTL8DIjRpsYuhvDqn7pGsE+SfBQYkdxeaPc0bnUobNVzEEcLKKog80mxjozxY89MLdhO0j+V1Dgr3REK0V4WV0VALjixqc+vxSyxKNdG9HlvDQTHVw46N63vatBnkRXk34J/uJejb7iS1PIRZY0/UCF5Cf6eWrnvl139ThkFWdG20bwJBAJ8258LuQsg+2pL13WHeswg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257b74a0-2471-4fa5-1526-08ddd47fd62e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 00:26:07.5381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYh7eUVHAAJUZHjPoBuaIn1xuzZ3lf9Jj7RXDmBCdouME7oQTuid1tv1An2skA23er4chms8FSMzOukXnLpRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504
X-Proofpoint-GUID: N12HLjyu9WDDf2G6YYg2OU19oTIar7gd
X-Proofpoint-ORIG-GUID: N12HLjyu9WDDf2G6YYg2OU19oTIar7gd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfX+uyzjoTA1haJ
 vJxvJkyI5oIZ/XLiz8ejdURghxr5Q0NlAQUu4ehbCgk5QipBn/uSDt94gIzLLxYhkoKQTyGYm/u
 oV+URzkERG5CfA9YdRVUkasiaSS2166K2ZXoCSVSJIkjkllgwhtOm2DnoAiXEoo5vEsFMme7RMy
 pNcEUVMxjmoiL5rAIaY2z4TJk8TILOefViz4fnq1n5KovdJU2r/7TJE7Jet4ssl0z7Drqc7Qvjt
 N2DDyc9fzj4yoiLAMC6BTk7HKTeH/UYMcxs4QNvjzbnvPD/fRnUbYuKCuuWi1IUeieLaPcR1pm0
 BmxfZxdCHas9QZqBBQ4B4kqIWJyE/cQ+J3GHye6ED88QVs23SF5je4ywAYCfdeon+xMuj8+s52N
 Pp+ghzNn
X-Authority-Analysis: v=2.4 cv=H+nbw/Yi c=1 sm=1 tr=0 ts=6892a126 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=jIQo8A4GAAAA:8 a=jTgrpLQJI89nFxPhvfMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050127

T24gVHVlLCBKdWwgMjksIDIwMjUsIFplIEh1YW5nIHdyb3RlOg0KPiBUbyBzdXBwb3J0IGZsYXR0
ZW5lZCBkd2MzIGR0IG1vZGVsIGFuZCBkcm9wIHRoZSBnbHVlIGxheWVyLCBpbnRyb2R1Y2UgdGhl
DQo+IGBkd2MzLWdlbmVyaWNgIGRyaXZlci4gVGhpcyBlbmFibGVzIGRpcmVjdCBiaW5kaW5nIG9m
IHRoZSBEV0MzIGNvcmUgZHJpdmVyDQo+IGFuZCBvZmZlcnMgYW4gYWx0ZXJuYXRpdmUgdG8gdGhl
IGV4aXN0aW5nIGdsdWUgZHJpdmVyIGBkd2MzLW9mLXNpbXBsZWAuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBaZSBIdWFuZyA8aHVhbmcuemVAbGludXguZGV2Pg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNi
L2R3YzMvS2NvbmZpZyAgICAgICAgICAgICB8ICAxMSArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMv
TWFrZWZpbGUgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2Vu
ZXJpYy1wbGF0LmMgfCAxNjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMTc5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL0tjb25maWcgYi9kcml2ZXJzL3VzYi9kd2MzL0tjb25maWcNCj4gaW5k
ZXggMzEwZDE4MmUxMGI1MGIyNTNkN2U1YTUxNjc0ODA2ZTZlYzQ0MmEyYS4uNDkyNWQxNTA4NGY4
MTZkM2ZmOTIwNTliNDc2ZWJjYzc5OWI1NmI1MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvS2NvbmZpZw0KPiBAQCAtMTg5
LDQgKzE4OSwxNSBAQCBjb25maWcgVVNCX0RXQzNfUlRLDQo+ICAJICBvciBkdWFsLXJvbGUgbW9k
ZS4NCj4gIAkgIFNheSAnWScgb3IgJ00nIGlmIHlvdSBoYXZlIHN1Y2ggZGV2aWNlLg0KPiAgDQo+
ICtjb25maWcgVVNCX0RXQzNfR0VORVJJQ19QTEFUDQo+ICsJdHJpc3RhdGUgIkRXQzMgR2VuZXJp
YyBQbGF0Zm9ybSBEcml2ZXIiDQo+ICsJZGVwZW5kcyBvbiBPRiAmJiBDT01NT05fQ0xLDQo+ICsJ
ZGVmYXVsdCBVU0JfRFdDMw0KPiArCWhlbHANCj4gKwkgIFN1cHBvcnQgVVNCMyBmdW5jdGlvbmFs
aXR5IGluIHNpbXBsZSBTb0MgaW50ZWdyYXRpb25zLg0KPiArCSAgQ3VycmVudGx5IHN1cHBvcnRz
IFNwYWNlbWlUIERXQyBVU0IzLiBQbGF0Zm9ybXMgdXNpbmcNCj4gKwkgIGR3YzMtb2Ytc2ltcGxl
IGNhbiBlYXNpbHkgc3dpdGNoIHRvIGR3YzMtZ2VuZXJpYyBieSBmbGF0dGVuaW5nDQo+ICsJICB0
aGUgZHdjMyBjaGlsZCBub2RlIGluIHRoZSBkZXZpY2UgdHJlZS4NCj4gKwkgIFNheSAnWScgb3Ig
J00nIGhlcmUgaWYgeW91ciBwbGF0Zm9ybSBpbnRlZ3JhdGVzIERXQzMgaW4gYSBzaW1pbGFyIHdh
eS4NCj4gKw0KPiAgZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvTWFrZWZp
bGUgYi9kcml2ZXJzL3VzYi9kd2MzL01ha2VmaWxlDQo+IGluZGV4IDgzMGU2YzllNWZlMDczYzFm
NjYyY2UzNGI2YTRhMmRhMzRjNDA3YTIuLjk2NDY5ZTQ4ZmY5ZDE4OWNjOGQwYjY1ZTY1NDI0ZWFl
MjE1OGJjZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvTWFrZWZpbGUNCj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9NYWtlZmlsZQ0KPiBAQCAtNTcsMyArNTcsNCBAQCBvYmotJChD
T05GSUdfVVNCX0RXQzNfSU1YOE1QKQkJKz0gZHdjMy1pbXg4bXAubw0KPiAgb2JqLSQoQ09ORklH
X1VTQl9EV0MzX1hJTElOWCkJCSs9IGR3YzMteGlsaW54Lm8NCj4gIG9iai0kKENPTkZJR19VU0Jf
RFdDM19PQ1RFT04pCQkrPSBkd2MzLW9jdGVvbi5vDQo+ICBvYmotJChDT05GSUdfVVNCX0RXQzNf
UlRLKQkJKz0gZHdjMy1ydGsubw0KPiArb2JqLSQoQ09ORklHX1VTQl9EV0MzX0dFTkVSSUNfUExB
VCkJKz0gZHdjMy1nZW5lcmljLXBsYXQubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9kd2MzLWdlbmVyaWMtcGxhdC5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWdlbmVyaWMtcGxh
dC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAuLmFiYjE0NDg2N2JmNWY2NzgyMjM0ODNjOTQ4NTIxY2ViNDRk
MDUxOTANCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2Vu
ZXJpYy1wbGF0LmMNCj4gQEAgLTAsMCArMSwxNjcgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gKy8qDQo+ICsgKiBkd2MzLWdlbmVyaWMtcGxhdC5jIC0g
RGVzaWduV2FyZSBVU0IzIGdlbmVyaWMgcGxhdGZvcm0gZHJpdmVyDQo+ICsgKg0KPiArICogQ29w
eXJpZ2h0IChDKSAyMDI1IFplIEh1YW5nIDxodWFuZy56ZUBsaW51eC5kZXY+DQo+ICsgKg0KPiAr
ICogSW5zcGlyZWQgYnkgZHdjMy1xY29tLmMgYW5kIGR3YzMtb2Ytc2ltcGxlLmMNCj4gKyAqLw0K
PiArDQo+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gKyNpbmNsdWRlICJn
bHVlLmgiDQo+ICsNCj4gK3N0cnVjdCBkd2MzX2dlbmVyaWMgew0KPiArCXN0cnVjdCBkZXZpY2UJ
CSpkZXY7DQo+ICsJc3RydWN0IGR3YzMJCWR3YzsNCj4gKwlzdHJ1Y3QgY2xrX2J1bGtfZGF0YQkq
Y2xrczsNCj4gKwlpbnQJCQludW1fY2xvY2tzOw0KPiArCXN0cnVjdCByZXNldF9jb250cm9sCSpy
ZXNldHM7DQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVzZXRfY29u
dHJvbF9hc3NlcnQodm9pZCAqZGF0YSkNCj4gK3sNCj4gKwlyZXNldF9jb250cm9sX2Fzc2VydChk
YXRhKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBkd2MzX2dlbmVyaWNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjM19wcm9iZV9kYXRh
IHByb2JlX2RhdGEgPSB7fTsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0K
PiArCXN0cnVjdCBkd2MzX2dlbmVyaWMgKmR3YzM7DQo+ICsJc3RydWN0IHJlc291cmNlICpyZXM7
DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWR3YzMgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2Yo
KmR3YzMpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWR3YzMpDQo+ICsJCXJldHVybiAtRU5PTUVN
Ow0KPiArDQo+ICsJZHdjMy0+ZGV2ID0gZGV2Ow0KPiArDQo+ICsJcGxhdGZvcm1fc2V0X2RydmRh
dGEocGRldiwgZHdjMyk7DQo+ICsNCj4gKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRl
diwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiArCWlmICghcmVzKSB7DQo+ICsJCWRldl9lcnIoJnBk
ZXYtPmRldiwgIm1pc3NpbmcgbWVtb3J5IHJlc291cmNlXG4iKTsNCj4gKwkJcmV0dXJuIC1FTk9E
RVY7DQo+ICsJfQ0KPiArDQo+ICsJZHdjMy0+cmVzZXRzID0gZGV2bV9yZXNldF9jb250cm9sX2Fy
cmF5X2dldF9vcHRpb25hbF9leGNsdXNpdmUoZGV2KTsNCj4gKwlpZiAoSVNfRVJSKGR3YzMtPnJl
c2V0cykpDQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkd2MzLT5yZXNl
dHMpLCAiZmFpbGVkIHRvIGdldCByZXNldHNcbiIpOw0KPiArDQo+ICsJcmV0ID0gcmVzZXRfY29u
dHJvbF9hc3NlcnQoZHdjMy0+cmVzZXRzKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZGV2
X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBhc3NlcnQgcmVzZXRzXG4iKTsNCj4gKw0K
PiArCS8qIE5vdCBzdHJpY3QgdGltaW5nLCBqdXN0IGZvciBzYWZldHkgKi8NCj4gKwl1ZGVsYXko
Mik7DQo+ICsNCj4gKwlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KGR3YzMtPnJlc2V0cyk7
DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWls
ZWQgdG8gZGVhc3NlcnQgcmVzZXRzXG4iKTsNCj4gKw0KPiArCXJldCA9IGRldm1fYWRkX2FjdGlv
bl9vcl9yZXNldChkZXYsIGR3YzNfZ2VuZXJpY19yZXNldF9jb250cm9sX2Fzc2VydCwgZHdjMy0+
cmVzZXRzKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0ID0g
ZGV2bV9jbGtfYnVsa19nZXRfYWxsX2VuYWJsZWQoZHdjMy0+ZGV2LCAmZHdjMy0+Y2xrcyk7DQo+
ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFp
bGVkIHRvIGdldCBjbG9ja3NcbiIpOw0KPiArDQo+ICsJZHdjMy0+bnVtX2Nsb2NrcyA9IHJldDsN
Cj4gKwlkd2MzLT5kd2MuZGV2ID0gZGV2Ow0KPiArCXByb2JlX2RhdGEuZHdjID0gJmR3YzMtPmR3
YzsNCj4gKwlwcm9iZV9kYXRhLnJlcyA9IHJlczsNCj4gKwlwcm9iZV9kYXRhLmlnbm9yZV9jbG9j
a3NfYW5kX3Jlc2V0cyA9IHRydWU7DQo+ICsJcmV0ID0gZHdjM19jb3JlX3Byb2JlKCZwcm9iZV9k
YXRhKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwg
ImZhaWxlZCB0byByZWdpc3RlciBEV0MzIENvcmVcbiIpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGR3YzNfZ2VuZXJpY19yZW1vdmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjM19nZW5lcmljICpkd2MzID0g
cGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICsNCj4gKwlkd2MzX2NvcmVfcmVtb3ZlKCZk
d2MzLT5kd2MpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGR3YzNfZ2VuZXJpY19zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjM19nZW5lcmljICpkd2Mz
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IGR3
YzNfcG1fc3VzcGVuZCgmZHdjMy0+ZHdjKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0
Ow0KPiArDQo+ICsJY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUoZHdjMy0+bnVtX2Nsb2Nrcywg
ZHdjMy0+Y2xrcyk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlu
dCBkd2MzX2dlbmVyaWNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1
Y3QgZHdjM19nZW5lcmljICpkd2MzID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJaW50IHJl
dDsNCj4gKw0KPiArCXJldCA9IGNsa19idWxrX3ByZXBhcmVfZW5hYmxlKGR3YzMtPm51bV9jbG9j
a3MsIGR3YzMtPmNsa3MpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4g
KwlyZXQgPSBkd2MzX3BtX3Jlc3VtZSgmZHdjMy0+ZHdjKTsNCj4gKwlpZiAocmV0KQ0KPiArCQly
ZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQg
ZHdjM19nZW5lcmljX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+
ICsJc3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjMyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAr
DQo+ICsJcmV0dXJuIGR3YzNfcnVudGltZV9zdXNwZW5kKCZkd2MzLT5kd2MpOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW50IGR3YzNfZ2VuZXJpY19ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjMyA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiArDQo+ICsJcmV0dXJuIGR3YzNfcnVudGltZV9yZXN1bWUoJmR3YzMtPmR3
Yyk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjM19nZW5lcmljX3J1bnRpbWVfaWRsZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjMyA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJcmV0dXJuIGR3YzNfcnVudGltZV9pZGxl
KCZkd2MzLT5kd2MpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9v
cHMgZHdjM19nZW5lcmljX2Rldl9wbV9vcHMgPSB7DQo+ICsJU1lTVEVNX1NMRUVQX1BNX09QUyhk
d2MzX2dlbmVyaWNfc3VzcGVuZCwgZHdjM19nZW5lcmljX3Jlc3VtZSkNCj4gKwlSVU5USU1FX1BN
X09QUyhkd2MzX2dlbmVyaWNfcnVudGltZV9zdXNwZW5kLCBkd2MzX2dlbmVyaWNfcnVudGltZV9y
ZXN1bWUsDQo+ICsJCSAgICAgICBkd2MzX2dlbmVyaWNfcnVudGltZV9pZGxlKQ0KPiArfTsNCj4g
Kw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZHdjM19nZW5lcmljX29mX21h
dGNoW10gPSB7DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJzcGFjZW1pdCxrMS1kd2MzIiwgfSwNCj4g
Kwl7IC8qIHNlbnRpbmVsICovIH0NCj4gK307DQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBk
d2MzX2dlbmVyaWNfb2ZfbWF0Y2gpOw0KPiArDQo+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2Ry
aXZlciBkd2MzX2dlbmVyaWNfZHJpdmVyID0gew0KPiArCS5wcm9iZQkJPSBkd2MzX2dlbmVyaWNf
cHJvYmUsDQo+ICsJLnJlbW92ZQkJPSBkd2MzX2dlbmVyaWNfcmVtb3ZlLA0KPiArCS5kcml2ZXIJ
CT0gew0KPiArCQkubmFtZQk9ICJkd2MzLWdlbmVyaWMtcGxhdCIsDQo+ICsJCS5vZl9tYXRjaF90
YWJsZSA9IGR3YzNfZ2VuZXJpY19vZl9tYXRjaCwNCj4gKwkJLnBtCT0gcG1fcHRyKCZkd2MzX2dl
bmVyaWNfZGV2X3BtX29wcyksDQo+ICsJfSwNCj4gK307DQo+ICttb2R1bGVfcGxhdGZvcm1fZHJp
dmVyKGR3YzNfZ2VuZXJpY19kcml2ZXIpOw0KPiArDQo+ICtNT0RVTEVfTElDRU5TRSgiR1BMIik7
DQo+ICtNT0RVTEVfREVTQ1JJUFRJT04oIkRlc2lnbldhcmUgVVNCMyBnZW5lcmljIHBsYXRmb3Jt
IGRyaXZlciIpOw0KPiANCj4gLS0gDQo+IDIuNTAuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5n
dXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

