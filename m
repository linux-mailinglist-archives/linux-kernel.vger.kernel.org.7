Return-Path: <linux-kernel+bounces-837593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A0BACB00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B459919239F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DA325784B;
	Tue, 30 Sep 2025 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/wYIeFR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z9CLnY2u"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F991E0E1F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231956; cv=fail; b=B4c/D0aZWcBLht7xllZYJSdF7lkNAJ4h3pF8mZfzbaUQOptvOO1+965pP1FFM0uIIK5VlJnKBFbKL6DY3fcCwX9mADOC5zeZc7kLfRRcYQq6qIvNK/1YRSOWU5YO7cyRco1KRYjGmrAlNcTW2qOfn+gne9bB+ETq4+B7jMLMYaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231956; c=relaxed/simple;
	bh=Mp+r40PxKKXwKC8nO2nOC03qMCELeAjAMDPsKiGIRmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xh/YBeE52wOJi2xB0XGdjjAgg9BuyLGJt6VJXTlv8qGa1VLR3k3Tgaa4uvXlw5RUwhbhKCBCwPXb2oJzCs/rtGcos8MwPn0o/FEK1BfUZOnguiAaImLKNOsFcXlEABwTjvRouhP71eplfULzphSxoStP21RjpTIpr+Y8IUGq2oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/wYIeFR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z9CLnY2u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBQImh021450;
	Tue, 30 Sep 2025 11:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Mp+r40PxKKXwKC8nO2
	nOC03qMCELeAjAMDPsKiGIRmY=; b=L/wYIeFRNQ1/nqvqtUybH9DXsRivVv+SUn
	y/otZ4Q7grsiDtDzs3bb8HV50fgCmlEiccE6NA9VsZbnzgImczRiFf2YIMim3eYI
	/h+AuQYRmMjkTvg1562y5HgYxtKNRSDqiJmyGGFobf3/WtXZ6gv3DeOrNzMI3+wo
	UYtsuAf79reGdki4TXJUAq8TdLQRnsoRskllKNz7YWLhmjzvNsaQWXtwzB6cU6Iy
	iyqYmy62M1IkhJxe+b6rhxfAUpP7qGtqL5L7TxMsvTzmiEQEsu4Wx8BIiAd455uH
	7QQG6vJ8i3yPTRzQpP9b08EeyzKGk35TlygWLYZvHhseGL50LsCg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49geb400ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 11:32:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58U9tSNq001990;
	Tue, 30 Sep 2025 11:32:29 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ce7560-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 11:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jwwwcabzob88742xaehJV02+iCpQ8QElmlNOwXymjeurCeE/SB13maX0PECgNUu/bcIOgz4mBr1SLLhIGNrZXq9AZAGUa9R9+64DnaQCvLozu3RHDvTOw26k4CBYalUiuunAl78+ATWw55r9bwKk3z4OsQjSq2f7iQjfxUpIN3BY3qLA0j2mj8vcePwBmAS9OFk7b09rWbSmFQTstLcEbz7fncCZxj9FoKYgSuCl/+ucU12BCfyAnVBVbcQ0W+/h0Ug1NWdZQQI2gbkoxMpDwUbYIeX482pwBZo4uSfY59kLAcXRRFK41I1X0wq/LkytzmkE/RlOivN5btyv9pfEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp+r40PxKKXwKC8nO2nOC03qMCELeAjAMDPsKiGIRmY=;
 b=Xma9Cmo2a5VOM6RbXLIM3QFiTD0zjNWvgpX47M2aanALWxuVgeV1QaJXoi/ODgnuMTFtx41StAdmzGVaUrM1loK7rB7UWV5yv/qfrZMCyN81Jp4ccoBknMnZGVtnOKYg5gn8G4OLUpKjqxlJ3drhcnbgazHPrrWOxZuUBr2XDLAUH+579A8i4llMfyGBitXF77dfXEDnbsIIzli7pYC2jr2KOBm9y51JxD7iuazyAA21W5god9kdtmahUVpbGnq3OcyulrYpkqH6kcC0QCQeiumnu5b2al30JRN6cqPDTKu3nrQYte6ntzF4PYAN9ZMpSwcxWJ5V+6QR3LpDTELlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp+r40PxKKXwKC8nO2nOC03qMCELeAjAMDPsKiGIRmY=;
 b=Z9CLnY2uYPiVZ2J6EQ9eaiOSIflP1QiSlG8JergoE24KCaZI4urJCuSBZbiwXyskvsxMtxJipwlSYtiAYxONd5QFF2yR28u7DwtZt0VMI4SEqLsEF+YyQ/cjcl8Ot8Fv3/xk7vgmAsvkvaTG9rNvYGlPJPp0GhZT3HDi6Y+Nmqs=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DM3PR10MB7910.namprd10.prod.outlook.com (2603:10b6:0:b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Tue, 30 Sep 2025 11:32:26 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 11:32:25 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-38495: HID: core: ensure the allocated report buffer can
 contain the reserved report ID
Thread-Topic: CVE-2025-38495: HID: core: ensure the allocated report buffer
 can contain the reserved report ID
Thread-Index: AQHcMf3lnxoOQSHvAkGBnOSU99iCqg==
Date: Tue, 30 Sep 2025 11:32:25 +0000
Message-ID: <c0d698cbcea6f46e6959ab1db07735cea76f3770.camel@oracle.com>
References: <2025072818-CVE-2025-38495-3b28@gregkh>
	 <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>
	 <2025093000-shrank-vending-2bd1@gregkh>
	 <552d5ba4368ce43b12b4aa8b01852a4d8af1bdbc.camel@oracle.com>
	 <2025093001-petted-boney-29c2@gregkh>
	 <883ad6064549f85dc56b2669bc3f395191b3da9b.camel@oracle.com>
	 <2025093058-iciness-talisman-8a9f@gregkh>
In-Reply-To: <2025093058-iciness-talisman-8a9f@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|DM3PR10MB7910:EE_
x-ms-office365-filtering-correlation-id: 711e5f53-84ae-4624-017e-08de001507da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021|7053199007|4013099003|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzEyL2JNQi95cnJVa003SDZkNVZ2TWppTDcvR25Ba1RaRit6WTFIbUlnVkow?=
 =?utf-8?B?Q2c4M240VTFDRjlLYytQREtxSkNXalZaQ3FVRzMwNjNVb0hwelpRK245ZWxN?=
 =?utf-8?B?aGhQQ3NzVllOU0JHWEhUcWlWTk5YSFdCelhVN0NoeDM2UDJLendrcEdNL0ZQ?=
 =?utf-8?B?YnpKUm1IRVN5UzREd1cxQUdMaWJ5VFNaSVowZlIxcnFjVWI0SWFwYUN5dDlS?=
 =?utf-8?B?SFBYZ0R4RTJXMkFpWnM4Q2lueUNNQU53STNUMEdJNzFaVHd1WUZoZ1dHeEFD?=
 =?utf-8?B?UEFpTjA3NXg2cFZXNm1YUzQ1anRWRnVOT3I0ZnZiSWs1RFZsR0djTWhkbkd4?=
 =?utf-8?B?VUE0UUZXOGdwU1g1RmNCR1NyRExVUnRCRzYzaWJEVjN6M1ZsZngwUTN6SFpk?=
 =?utf-8?B?WWJqTkJLcUNNZEVyaU9HenZuWXg2UzVsbVFtYW81ekhtUmVYWmhFUUs3L29P?=
 =?utf-8?B?YXJRL2JMbU9qUUtpOXFmaGJLUVlsSmxTeGtsaUxTT3B1RVJnaTBIQ0w1RGEw?=
 =?utf-8?B?L05UeXRNSXhSQ1dSUlAweUc0NVpPMEJ1V3lvbGpXcXp4VFlscDQ3TlhhYzNI?=
 =?utf-8?B?RTQxaW5rZ1kwdzRnQWFPTEJJNWRrMjlId0x3N0dJYmVzN0kzWHNZNEpMZEMy?=
 =?utf-8?B?MGk3QUhwVGZWOVgxQW54K1A2MlN5OTNGSFBRMnJKWExoTVJiRFNlR1FnSksv?=
 =?utf-8?B?a1BYazRhZWZ5UE1IL252OGNjcG1wT2JLSksrbmJZZVl0VTBZdzU3dWZ3bHV2?=
 =?utf-8?B?N09uUHhtYmV5bjgrcVowVHpJdE5GUjZxY1p0YTFEckFRZExwdzNOTHE2elYx?=
 =?utf-8?B?QlNZeEtWSWNabXJBVkJ0blpyV0hiWFIvSmFnN1NUQ1BkbzRGakxsL1RVWmxz?=
 =?utf-8?B?VStpbSt6TS8zSi9pWG9UUWpJY0lCVjZZVlRLZHRnT2tkUHo5NnYzbTJObE9V?=
 =?utf-8?B?OWdwTVBGMFQzazdHYS91QTFGRlFIQm5wTkMybklLUlMzbGwvcitqSGdWZU9W?=
 =?utf-8?B?NlJVa21pTk80OWhFNE9pSkVXa3VrRmJ4Qi8zUlBDV2dUYVNUbGVIQVlITjFh?=
 =?utf-8?B?SFZMNUFCM1NrMHg4VW9oY0RRaUpaZ0dmWC9mR3JSOXlhZmxIN3k5TGgrT2hy?=
 =?utf-8?B?UWRPMUhGRjRCMzdKTGZjSjJiS2VNNFdhR1BOeDNkaExjM1dSTjBHdmdUWEls?=
 =?utf-8?B?TjZ3NWxJY1JiZmg4TG15STFkWVFibzYyZFlUdFlNMUtrcHBXUDBxL0w4Nndz?=
 =?utf-8?B?U0ErSUlDVkVXQXdDSEFETjlVY0pwQ1N5YXpHQjU0OC8vb21HT1lJMHdpNnE5?=
 =?utf-8?B?eWRML0c3ZzlrblRkM1J1czVCdW11SndWV1grQ2FERjhSTFBrM2JKclpvR3RB?=
 =?utf-8?B?azIyMmpKMzdwSXMvOEZzZjVIZ0hUL2Q5WFhzTXBHc3hNcTl0RFJzekFZdFJC?=
 =?utf-8?B?d2xjSGRCTUNQMHVYRzgvSWhXQmhXdGY2RmF0ZXZjYzRsY1VpT3VVZU5jN0t6?=
 =?utf-8?B?T0ZHOE5jM0QyR2pLWEpvbHM5cnJ3dFl5UDhYcEhKVjBLL1dtdUJjNzZiRVk4?=
 =?utf-8?B?dDZkMGxNMGdscFVYOFoxTTM1WkprSktBbHFQT214ZjVDS0RiRGZGK010TTVC?=
 =?utf-8?B?REpqb3loREZhcElwc2pDTkFYaDhaTVhQYWNqdXFPVE5pSVI1L0dlN3Qya0kx?=
 =?utf-8?B?dnVWTGVhd1JzaEhKYmN5aXo0T1ZzSVpPWGZ3dTFYa0dHTEIvb1lOU1kxeXBt?=
 =?utf-8?B?enYzZnBNNS9CUUFHMWpEUmFFSEF3YzJsNm9rUG8xUzhXU3JmbUtjRW9XTXdP?=
 =?utf-8?B?bkVCNXc0aGN4WmtHb3I2T2lIcWJaSmNReVhSUFNuMVg4VjYzT2N1Nnh4RTZz?=
 =?utf-8?B?RjJCZzF6TXNLMWYrbU80aFJFeCtLV3VRUEFvb1FzNU5za0cySVg1VlE5aU15?=
 =?utf-8?B?LzU2cnBRRlA3VWpjaXFvZkoxbEZaYWhORVVlQ1I0M2dVSlFmQVZvZmNGN2JP?=
 =?utf-8?B?dnVSZ1RnQ3RBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021)(7053199007)(4013099003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFRTVWlFL0JTM1dzSGZHcE0xdGUyWkc2eitnRHlCVVdyOUFXd21QL2dTQng5?=
 =?utf-8?B?bzdveEVlNWxFK3FmbkVyWWR4YkRlTytDUGhGU2s1L2t6cmJ6TUtYcDFXMkhx?=
 =?utf-8?B?NlZnK0VPNE10VW5tQlgxaUhycHM5Y1l1YkhWM0hxM1ZEZ2ErM05VS05mL0dq?=
 =?utf-8?B?QTVmNjJSZVBtNjFGRXdINTBRdnJGWUhiMzcwWEVYc1hCaStKcEFuaUk3SFdl?=
 =?utf-8?B?ZFhIYXRZekVCNmtqbHVGL1hOeC8zZVZWUEQxZTNVak5vTlRSNDNIa0pNZjJp?=
 =?utf-8?B?M1FrM0RJL3UvR0RJNkxmaUVKNTFUL2JtQTVJd1lyUDcyeXNiR0JaTkx5NTdY?=
 =?utf-8?B?ci9rbEhTQThnWTRoS3ZBRE5BSFZhVkhvTk93WlRBTEYvVWF0OGRFMGttNGpO?=
 =?utf-8?B?QnY2Sml2eHk5dUJVajJINFovbTdFajh1eXp5WnVhait4SVVPak1ndWV3M0Zz?=
 =?utf-8?B?SEpiSURMMDd2WWd4ck0rV0UrbytQYU5Fd1BBV05tSlVYby9MNE1OVWxBZ1Rn?=
 =?utf-8?B?aG85NzJtTW1xTXNLT2NFNlpINVUwczRyRzQweE1RMXdlcVp6cDFUYXNsZ1Nr?=
 =?utf-8?B?WGl2Nm9PSWFzbUJiQWpWbVlyNDVhSjE1NDlHNDljMlRpcmk2MUZtWXovc3Jx?=
 =?utf-8?B?ZXNiNHpaTXB0cVNCU25yaHJJY1BMNnBaSEdxTTE5MHJaWGFzVklicGZ1dFRl?=
 =?utf-8?B?Qkk2RG1yMncvU1NOY0hDWkd0SlRDUlVrbFVEekx6alc2REYwYy8vNm10OE5z?=
 =?utf-8?B?WkZaTFhxQmpnbFl2TjYxYzlGUG5oTzFRYjRZRlFDbkl2S0RhclFLZVNwWXM0?=
 =?utf-8?B?ekpvOFVTTEsrejcxb3d5SEU5SUxnRkZVZUR1SUdKMTZRVVlTcUhadm9XMzNS?=
 =?utf-8?B?WGhLb2N1RTU1KzNwM1JhWURaWHdsSFVlNVU4Sis5ejlZOVFjWGJjdFk3eURw?=
 =?utf-8?B?cWRPdVZGemVpMHU3MEFrSXRuUDFFL3pndFdaRC9hTGRCSkpxKzltY3YzYmJW?=
 =?utf-8?B?MkIwb0dybmdqV2RsRlZnU05aaGJFRmI3ckFJbWw3dFdaUURaM2FRZlJ4bkgr?=
 =?utf-8?B?WkV2djRFK3N2R0lKVTg4YnozdkdZdS8wRHpEb2Z6SzZPelZGeXE3SkNQcEhI?=
 =?utf-8?B?S3pWK3NDWWFTZWUwdnRlWjY4SGtKQ081a1pRNDdSa3R1eGtoaktGcDV3RUZ0?=
 =?utf-8?B?U3hxWFFuem9YNWxXb2JmL056VXJoNlduZ3d0emxwazk4eVdkcmYyN1huTnlw?=
 =?utf-8?B?c0IrZytmTzNsYlV6bUFwamZPQklrM3kyRnhCTlFDdzUyYXZzaXIxQVRwbU1K?=
 =?utf-8?B?OFExNVNTNkgvSzl2YzJyUkFZUGFrcWh0NFlHUTBjSERabHFMK1ZESmppSld2?=
 =?utf-8?B?Nm1icm9HLytFSTZsOHdBdE43MXdhblVBQjAxb0FCQ0RBWXFOK2hEVkxOMXRD?=
 =?utf-8?B?endyZkVEcEY1djRWampURUhQYTZlRWE3T2wwaDNKT3lRWUpBMTR0MzczVXR1?=
 =?utf-8?B?dncxd3dMaUtkVEcwUmtnbGpqbDhZOUdFMXRCZE1GMnlkeVozVmtuYlZwNnQ5?=
 =?utf-8?B?RWduQXJ3dUtHeW1LYnNJbmRxWTFVSUYwUzZlV3ZCMkdEd3FWQVN0TGRKZXQy?=
 =?utf-8?B?cENtQ1lOV0F5TVYxSCsxMTNUK2VsaDBsS3hlSnRLb2w3VDdlVkZrQi9GdEdC?=
 =?utf-8?B?KzRzU3JDN0lPRkhkVHhPdnlRbkRTMUVLQU9DVldmaTNJOHpPZ1NKaDhoMWY1?=
 =?utf-8?B?eGlGdXBISkV2SDVVQ0wxWTZkQWUwR3hYVmIwZTNtUEM1dGJHLzFnWkRJNWFX?=
 =?utf-8?B?dmpBbFhrWkQ2SkxWaHd6N3IrWmsxR3JBSkwyeHIzWWVJaGhmL1dkQ3RKcWl3?=
 =?utf-8?B?M3NMdC9sTVZwcEtNWDlaakhHSXdPSHBrcG9LRERNVnJxOHFnaVdLNkl4YU5s?=
 =?utf-8?B?QW4xaWFtQ0xBMnV0WU9yd1N5M2xBcFNsQW5mQnFVWVpPd3hDZ0tUUG9JZ2xR?=
 =?utf-8?B?UkFwUnY5clpGSWdPT2t5RVU0SjdmTHJNQ0pYdmNkTEtCZUxoMEpXM3ZWNTBm?=
 =?utf-8?B?aFNEYy9NNmZaVk5MMVdWczBEYVl1bFFqVXF4SEI5OUh5TUJKNnRBNG1sakow?=
 =?utf-8?B?d0ZCSy9FQWc4L0ZrNFhLd2l3SGRlUjc4dG9yTStBWmdya3RuaXZvT1V6U1Js?=
 =?utf-8?B?b3JqbUNneGlBcncxKytJeDZtaWg4K25STDNCTEt3YkdsNFVoR0JEOW43OHh5?=
 =?utf-8?Q?DlYZY/DS8gw/CyI+RIBXgudZ/LIzWARhAzwnIgy0RY=3D?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-Zj1aqj81eipTgoyksAsh"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5aQI55V0THHnB4C2WIBzYvO0zX2gMXwACtwU9EZP217wAH03zh5udcm/h78/e1LuTZ+eeFdHTxiLiIylDF2AYR20JkHh/1lRlcYlUMEAV9y88MxWD7sI7z4k3VA5EMbuKx3kObpWmVflAP75Dey6oDzX40hbQt+pjMOjftqNuVZ/UuRPx2kWLAcwzwp2Jc3hnl5I7y9tzMcB9CD/chmdWEEyGrEGK45jmQrJzYYV0i+dMXvEoR6bL/ewmOM70qpG5eLq+9zIjWqaWN+pOitU0QAY+XD16n5MZ6p9K6qeG2ytFX7q5OLw90oXqaB7r7dPEilQOc7SYJhnImY+HqV4h+h7Uj9/RQuz0v8cfbMibrJoIRZB1Z8TvK2iShm02TDLo7k8rKNT+hSp4L1waL2Orx03WpFl1tTOnF2n6KWVD4+t3oEu9eehTfmZdGNuLQ3a6ncyWLVOSP9DcweUp83nSDHd/+deYAgV3yAy++9rIKNq9LnzRRU5wYWNKSqV4oGpRalMnf1b6OYB5yTeHTv+qn05Io8Md/02zmzAX2X5oUn9uR4WG+WqvHSVJI60yCiXOagNKS83RJpkrZ85lbF1gOsxE5FiZLpwSevDUhLbd4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711e5f53-84ae-4624-017e-08de001507da
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 11:32:25.8901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TabqlxahB0KEYEaPsMf0O1t5w6FKLh5eOH+4Df3k5oWNZQZ0kf815KNjpbTiDKUoDuRELAh9vBN7wvjawlhR44TgUPcu0r78241a6/Zfdpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=969
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300102
X-Proofpoint-ORIG-GUID: P8mMWbnY37GxM_tIh61lEt8MhEcHesd6
X-Proofpoint-GUID: P8mMWbnY37GxM_tIh61lEt8MhEcHesd6
X-Authority-Analysis: v=2.4 cv=G98R0tk5 c=1 sm=1 tr=0 ts=68dbbfcf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8 a=ag1SF4gXAAAA:8 a=0Z19ih05sqsYLfVYuyEA:9
 a=QEXdDO2ut3YA:10 a=81BqKbFT-C0ZIYEygsEA:9 a=FfaGCDsud1wA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=ntf awl=host:12089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEwMCBTYWx0ZWRfX0K0qGz9Vih/p
 UyumiwBY+SldpQnrIhGDYrVuPt7gfQmWyBPKvMuf51rOJRbS+ASI8H054uLpHAPl1hR4ZsKKDxL
 aP06EY/Gs8hsjJJcv4mFAD10f51gz6QO2hLqgbJcsUSPPL1rIsIsztbu7vp4r5moMnPCyNzKpaK
 xI31B/4d+JSLPnZ2V1Hsulrof8JDt7Xxih90q4xHZNrNgmyr0eFlmJoN9DwpDwxVch1rlVhV408
 Udc3an4PixDrG2CYptnoxQR+h7Bez32oLE36mSENFQXUdvTbZ3m5OJR0qBoPhXhcbgByBfJeIki
 F36gQ3iW802i0GGIwRvkcJiggA5lIT8L39whEpLA4xJMaybX+yB9FvXJVuzpSVoroxnKxzT0SZQ
 6+3GClNQiiFzr0o9DwdacYJRGY8mnzQeyaQ44xMVoXWHma7b0+k=

--=-Zj1aqj81eipTgoyksAsh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30 2025 at 16:52:30 +0530, gregkh@linuxfoundation.org
wrote:
> Is the CVE referenced here in the Subject line, and the git id it
> references not valid?

It is valid.

> Is there some other commit that also fixes a vulnerability
> that should also be assigned to a new CVE?

Yes: 0d0777ccaa2d46609d05b66ba0096802a2746193 which is immediately
after the commit in title, and fixes the underflow reported by
syzkaller (see [1] and the commit message for the tested-by), which is
the main bug, for which there is also a public exploit (see [2]).

[1] https://lore.kernel.org/all/686bb229.a00a0220.c7b3.0081.GAE@google.com/=
t/#u

[2] https://github.com/xairy/kernel-exploits/tree/master/CVE-2025-38494

Thanks,
Siddh

--=-Zj1aqj81eipTgoyksAsh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmjbv7wACgkQBwq/MEwk
8iorhRAApzkvmgeSZNvLYJSrd8/hijBtQmVf/m3gS+H8dgRcDE6uTbFYHbt9Qw2a
vKZoOcZSG/Hte5EZARf1XIcwQKq44y29jhSY/Lrq8a6eT/oKytYEclkhvVYyE0N2
IjSu7AOFdgMuTJ/Ic0gVM2+Ul+b/j/E19M+HcpkQWQRO+6DUXWJ3xm+N8qkF7vZh
JCrv3zyrJrGoa+a8rCm0BQsuhqKfHPU7hLNHizpQfpUrh4+0tv/ioiWCiVdLfEf1
WQG5o0sjILz9LC9yOlWScx8YnkcHk9GEmlxxsEgO3bgC9E1TXi9suxQiEE3fBuZC
whNiiizPXUs2zqG/ZFmsCWQ87MzE9NYrgrYjrhID7bwlVdtMRJsSn7mpLbMC750Z
33S5phUv0PYQ9mfNegEMLpPzOhwQhskycFkt0TcghOSZ/E8TgXRK2hUUVUz5IsXD
r7F/544r2724FKX/0lahIo4xmgsDKBUMIrGIbOngEugM7XeoN5yvPpZ6Q2VMcN46
119H8w+1aQSSz3GG0OMbdnbUkl3SqNs5MjbW6l9uaMYJQ18vxyeVLBaUOEfoIevz
KSxv2RpNvNDMt94P+nG59RY1mne1hKqkQ8WLQ9veuUkLHae9nY26fv3hxQUvoU1E
rHeauzHVCVgJ3XCnEkbYAf/5HL+454JIQnQ/8EJiOISRAJRU3Ls=
=weyC
-----END PGP SIGNATURE-----

--=-Zj1aqj81eipTgoyksAsh--

