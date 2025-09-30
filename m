Return-Path: <linux-kernel+bounces-837556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5968DBAC91C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C67A493B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CAE2F7AB9;
	Tue, 30 Sep 2025 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sE4e7/9M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XM3rK6XZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F66221557
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229702; cv=fail; b=TfSdEMHOXVRxyDw9rJSPTwLebj7UUQxGo51Q4mZqng1CeYuCYcC/6lVSK0pq6h7CrhUO3t8lRfzCgj86/4HCzsu+JxqEJFN+pfKmCU30cCPogz/0y54vG5Fy5WQBq7QOrLi1+dCMbt3boqET1Gw8yoaHJ6Rfym9oUXsMDCylG6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229702; c=relaxed/simple;
	bh=NTBQ3lnUVqbtsC6PLkBaee4O6zMpmc2kuX1X1ZAVhS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QAIGx7VWDVFP1tkJXOApDntJjfO1oQM1EVbMHRE44o7yZUbRCXe+WMXd6oGhLHHz6XIhw/Z4XeDCARHnl7MvBnBbG6pFvg565zo8ndz6J4RyMEwlrkig0wpGeT2iSzt1wAF3KDrXblMP4lzC88t5FAfNlDVgVRMnwsdyLA8Zof0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sE4e7/9M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XM3rK6XZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U9YLBK021388;
	Tue, 30 Sep 2025 10:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NTBQ3lnUVqbtsC6PLk
	Baee4O6zMpmc2kuX1X1ZAVhS8=; b=sE4e7/9MiOLHwJovNcbFgl3DrDgEvjOjeE
	F4nb+x3OMvDttuJBAjMT0T31WJIKZyilxs7SmQy0PlVozVUi3ZMJjEdzk01FOY1N
	GRxmIrCWjmMCPpMWToJMglnobsBIcVgQPeB3zXd9IMpv6FMGqXVKoITzmWbPdHv1
	zRjfdKhxeAy4i9XFb7GoEbgNjmwIa3PJ7TMu2G2isEPsVWuWjLqG4TMRo0lmtU8I
	N55doNArFD8t0KibqWIK3+b42gjqhEkt7FHx2ObyCNH23yxLQbF9brEPqJnK8iB9
	8xDO9Kj5sL1H+ql43AUGYMfD8ofM9WFiBVf4KUP10MuoqRWpSI1w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gcpm04nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 10:54:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58U90Hg7027194;
	Tue, 30 Sep 2025 10:54:09 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c7n4bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 10:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Psto5ddkNwMuUzAnoz45hBtrU9I3tXPWqWfYDrngk6gvcChBN3H3x1x+1v1N3C9IYNanAwDa8bO2jkglPwMqoj9u8BHKbMun4FyrAAs+e2Lo/ccgmLReNuzn8RLcxbIEObWqyG+Kt9NMYD6P0B6W7EJcZOfmxhL4lY+SrcH5ROGPDw96USNIZnMcFwsJGKQPEEqC+i4ygz0ffxOCh/JUTlrN4zBeojpHG5j98/zPCNz4ADDUgqeRNICu5lvUIyizvgKzIQWiVvvVD/Mrn0kRoDevhmxof6IzdUc2Ic4D9Nhleo5S2bOnJZYxlq2y9gwtqzULMKR2WjK3y7iI6deFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTBQ3lnUVqbtsC6PLkBaee4O6zMpmc2kuX1X1ZAVhS8=;
 b=lGFCZPXlg27Rhd7nH4uM0bGeDAMzONEUI3jdgUa51+Hr1ju9b5rrOK3xgGd9THO55Vdrqon8GkENSCCTeUl+m3nYiHiEgguYrMj8BKoti/hb0OUte8NgFlevcjygDSbvqdVxJDiZI58HUngsven9eKtY5EHsHGVwglu7aoED/E0ddfOvS/yzCYJGZUKK39Wx9d9XOaqFg1r3O6SueIlU2x4OQhYg+qv8s92KpUEEeNRvhzc+IqzaZz29E7SDWXeQaYUz9W1EhbXNPWBbLc2u2lA/R852Vf3pvKnzVHywMsY+H4nK0Rk+VnIJtWg803+iSQQL/GmYMbJ1MNreGZGLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTBQ3lnUVqbtsC6PLkBaee4O6zMpmc2kuX1X1ZAVhS8=;
 b=XM3rK6XZD49g/qeMXnf2t4gXkGAbIKoWxCLhJADlDl+JWE/lOBwtlB1RcVea6nZB+E5MRBGwws816GxiOIWhrgnum2Iqye9BXx4MRZBRbkxTVB/eX1BvVWLSBekpbUexDxkhI9Yx7BvilEFrVMfZCmgtDTbQPE5xd5WfmxOJbnI=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 10:54:06 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 10:54:06 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-38495: HID: core: ensure the allocated report buffer can
 contain the reserved report ID
Thread-Topic: CVE-2025-38495: HID: core: ensure the allocated report buffer
 can contain the reserved report ID
Thread-Index: AQHcMfiKn3nVJRWmb0SM4jEEfxsDeQ==
Date: Tue, 30 Sep 2025 10:54:06 +0000
Message-ID: <552d5ba4368ce43b12b4aa8b01852a4d8af1bdbc.camel@oracle.com>
References: <2025072818-CVE-2025-38495-3b28@gregkh>
	 <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>
	 <2025093000-shrank-vending-2bd1@gregkh>
In-Reply-To: <2025093000-shrank-vending-2bd1@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|SA2PR10MB4684:EE_
x-ms-office365-filtering-correlation-id: 44931836-c61b-483a-e998-08de000fad62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|4053099003|38070700021|4013099003|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?YSsxUHdnV091Y0VuTjNSR3Q0ajdFdlk3cjhiNVByRmRZc0paVjRta2dPWjAx?=
 =?utf-8?B?MjBCdzlJcU9VeGhQUzZzaWZ3TlNVRWF0NE9nTVliajFzTEtCUE5RQjU1bjd4?=
 =?utf-8?B?L3hVNGlhL2ZIMnhzVEhvQmQxWXdhRDBUSEpJenNXcjVLTWdVeXFBUTdlSDIw?=
 =?utf-8?B?SGd6QlBQeGIrb3dNSy9mNHVnellJTjlYWDAxOGR5ZUJYZmFsaEwwam1aYXRC?=
 =?utf-8?B?Rzh6elZzQk9UdUEzRTcvQUU1OGdoWm1oM1FLY1dOWVVXMytWQ3dIWnZsY3Bj?=
 =?utf-8?B?VVA0d0I2SElwZzNLRGh0cDF2TFdvejlLQWlzVjY3ZUlEZmhhdWZOMjdXdUxv?=
 =?utf-8?B?QkFETUpNQUhOOCt4M09KNEVqYWJIMlpyYVJ6Z1gvWXIrYmVGU3Y0YkMzZFFK?=
 =?utf-8?B?VUZGU1labDB0Qk1VSkpMMXJaN0l5QmJrek1raEE2ZGJPQ1E2cmdickdlbW5j?=
 =?utf-8?B?Z1hGTE1zT1BpS2lhQTRwa0RRQzFQZENnSzN5M2hrbDRCb0lrOUVaSzVlZ0V6?=
 =?utf-8?B?dDVoRTRPcjhSSGF0NE5ic2g3VWIvcGJyN1doWE45WGdxNFprSVVwS3FiU3gv?=
 =?utf-8?B?bXNMSWpobFBUYlQxNmEwQ0ZPZUVUSTk5M2hNd0VJTWtLUUgrbGcvOWJHeXBn?=
 =?utf-8?B?eVBSRkdUTytjcDhsYnNCcWU3R3NKbGI1RlpNRitaRnNHeUcxRWo5Q1J2bnRE?=
 =?utf-8?B?UlljbVNZUThLWWwwRXpPd1lkZjdvWW1PSWZxY09RQW5jRi8vS20xT1hueEFU?=
 =?utf-8?B?K0xOT2RxZVllYVZZMFE3emhIczF6TStnU3Z5Kzh6VjhLajdOMmNxOEY2Rits?=
 =?utf-8?B?bFlvV1N3eHMrMDgwbkh0UXRJZVVVa0lDTUQzYVowaXhPOEVNK3lqd1M0dlFQ?=
 =?utf-8?B?dGZUekZoeDkyc2dZNzVQK3BFK1dVb0RRYWV0bTRzeGd1OGNzMHBFL2RJVFVL?=
 =?utf-8?B?b0xjdTZNSnljTDdSbW9ma01jUTdpWmlZbnFPbW5ONWxWSFZHc2JTSFB5M29l?=
 =?utf-8?B?RE9qalN5YlIrU3lPT3puTFNyM0k5UGlhdE8vWWJ0aXprMGpUdzIydkw3eDli?=
 =?utf-8?B?VW1mRVBia2Jab0JTY05pdGZOZmNER1dhZld4VXRDN1dvRXRlV3Z6TG1xMEZz?=
 =?utf-8?B?M1lCUXZpVTFsS3VPTW1tdTVJR0xWWFlwM2JrcnlJc3NhdE9YQktPR1BrVzNU?=
 =?utf-8?B?b0dkbisxaUlVZjVZVnZ4aWVFWmxtZ0Q4ZHZPblBNaXRocW9UWWIzT2EwczdP?=
 =?utf-8?B?Y3F5Um1JbWhmQTNIRHlVeUpHbXFEZVE1Y0M2RHkxV29OanhnSlVITVFxa3JI?=
 =?utf-8?B?dkdaZDlUb1hoeXpkeWxYcVdsVnYzb2tWOTNzZC9HWXVqQnpjZXNzQnBhbmhB?=
 =?utf-8?B?eHY4N2l3bnFBS1h3NG4xeXdEYlA1SHJCSlNFM0Vkb292Z2RrWGpkMjg2cnlB?=
 =?utf-8?B?NUdMc0w5eTU5VHhCUVRLUmFwd2huSlF5Ylg2VnNnUTk4VjVheUVBZkIrYW85?=
 =?utf-8?B?VGdJT3c3d0JrNm5rTGhjWEdJd2dpcFVmMFowTTl6S3d5SkJZY3pncDRRaENr?=
 =?utf-8?B?ZTR4Tm85RTZyTEZudE9qQWlKZ082Yysya3RVVlY4UkptZ1ZBa3dNNXdCZkVM?=
 =?utf-8?B?dEJCS21MMXJPa05jUkg5RzIraWs0aXJYSFYxdmdPVG9QUkxOMEppR0ZucDRy?=
 =?utf-8?B?TEY4bEw4ODBjbFpSeWl2SUNoaWNJeXJyNWVlQ3dReG5PcDEya3pNYmIyV0FM?=
 =?utf-8?B?cGlDd09NNXFpanYxcXgzZXpYNHkwNWM3Zlo0bG1ZbDVXRHZwYW9ranNzRzB5?=
 =?utf-8?B?WUJ2ektyWm9ZTlBEenM1MEJDcDhqSW1FT0p5MnpCSmdsejlHS1ZPYjMrbVFG?=
 =?utf-8?B?TFRYU3YzQXNBOTFzL0RsSXNIdFV2S3VNclNqb2tkR09MVUpzTVVzVEZITnZl?=
 =?utf-8?B?S2UzZnJyaEJiOTg3b2tDRGtZUUlhOUtKT2FDc0dTYkdhVnNZVUExMEZWRWdC?=
 =?utf-8?B?VHJIOTErbGJldlREbncxTWgwc0NoeG1ESHF4RGZlakE5OUpFdTE1QUVrZE1t?=
 =?utf-8?Q?bQGRfo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(4053099003)(38070700021)(4013099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlBINHRUaXA2RDI3eWF2Q2ZpNjJrTG1CeVRZNzZ6OS83SkhQOVdWUy9mcUNj?=
 =?utf-8?B?eHNPKzV0a2FzLytsNmZ0Vmx6YW14NC9qYXlrOU9WR3VwSkkydDdBcWFocGhv?=
 =?utf-8?B?em9xZS8xQnVSNXlsRkpXMnI2aVN0Z3dDNzVxMW1ESVI2TXRZUmpxMGt5dERy?=
 =?utf-8?B?anB5U0hZaUlLb2N6SnFQbE9IcmFwaXQ3ZHJ2UVUyOFlON2ZXUTJSd0lheFlD?=
 =?utf-8?B?cDgrK0NPbW1pdkxlcCsrRHp4NjVnR1NuZlZYVy9Fa2dQMDJIR21VeCtkTVBt?=
 =?utf-8?B?cFk3VUxTWDIzejNMQjY2Q2xtQ2EwWDJuK21iWTl0RUxtZW02OVlINHVsZ0Fs?=
 =?utf-8?B?YzltTEowRjhIWWx2eVYzYVRYRFRXTDRYSGVVbXF1QW5ua3A3TDdCWmZoMTF3?=
 =?utf-8?B?cWc5alpyaDdmTzRpdjUxVmJmUk5ZSjFwYXJ5VmEvK0szYXdLZCtvUkM2Y2dY?=
 =?utf-8?B?V1JUbEMyM1E4b3RzL2puZkw3bzJ2eXd3UEIvckc0d0VseGlkUlNoVy9VSHJv?=
 =?utf-8?B?U0lLOFBjRzVVTHJWRHQ1K2hqaGlNYzR6TXRBa3JIcG9BaDFvYWRhUWxlYjcv?=
 =?utf-8?B?VnVHTyt1T05NN2l0aWxubFFEaUhEVXNKVWpEUGxsT1hmNWJORGhMeHJBTGNl?=
 =?utf-8?B?RDRlWnBYMCtGYXFhUnB0T01Ra1FPc0s4MW5PUzJVendJbUs0NzRZQVZ6R0ZL?=
 =?utf-8?B?b2FpeElYbjNsbTQ1M0o0aHFORXNVL3orcEYwaFRFekUyUzNRTGt4SE92T3Yz?=
 =?utf-8?B?RFh5MVp3S0ZTZWZxdXp2MVpyaHJPZEFZMFZ5Ymx5T0N3SnVBS2lRbC95VGlY?=
 =?utf-8?B?VnN3VDErYTM3QkFJcjdaM01OMXZFTHJJVUZGYnQwaDdGcTg4RlNyc05KZVdi?=
 =?utf-8?B?K09lWGo5bXI0c0NROU5Md0pVU2dwZzBXWUtqSlpyQnpDWHdIYmh6TTFQSXA0?=
 =?utf-8?B?V3lxcVhZWTJ4MTk3bW9JR29iVmtQdEdTTmpIQi96eEhSd1N4a2I5RTh4cUVj?=
 =?utf-8?B?cjd2ZnZNcWovZzJUT2pwbVdnd1BobFZ0SERWN2ZtMGJpRnlNSnpWcWN6cHpq?=
 =?utf-8?B?Z1JVTmdPcEVDbWNXYi9BdkF0QnpqVDhMYWZpVHp3ekh3eFFPNU1KSm9ZOUVp?=
 =?utf-8?B?SnVVNEdJcHh3aC9xbzJQb1NIQXJ6S05DOXJJYkNDOUY5MnJRZ0o4SjFGL3Vn?=
 =?utf-8?B?dGRjK3dzWjBxc3JVNFlIQUJBU2ZDL3FkcWJITDRXTHpPZ3h4c3R3UERPSzNx?=
 =?utf-8?B?UXdnSnRQTmsxWnM5VnFXWXpjcmJmaXdVMzF3T25Fczhpb1V2ZE55eHVEZ1o4?=
 =?utf-8?B?U3g1eUxJa0ZPaUJmc2l3ZFEycTF2TkJqcHRLdGlNNEdPUmVkSFIxUU40dDZz?=
 =?utf-8?B?ekE0YzhsTkxKNFpPTWdVOUJHTksxeDEvRjdkenN6dUUvcTZuT3duY0tqL2RP?=
 =?utf-8?B?T3o1Tk53SHlkS1BHQjRNeW1UcjJMckcyUG4xdkQ5d1RESUhFUk5GTW55ZnE3?=
 =?utf-8?B?R0V5N0JPaDhtNDNOcnAyRUNqRlg2UkI2NUsweXpRYmt3TGh0ZHE0bXlYTEdG?=
 =?utf-8?B?YUppa0FJblBGRVhsUUFmZkdRUWwzN1gzZGpRQmt0OVRxVVZNOEZobmxMTytL?=
 =?utf-8?B?cm9qZlFoVmY5VHlpZzZSdDBzM2hWQmNWN0cyZGNJZG9HYlZpLzBXVlVFQlp4?=
 =?utf-8?B?UVFkM2ppSFZPVmlxZDl1WFJYNFBEUWx5ekQwMHF3Y0RGazlNWE9sWHk4YzJj?=
 =?utf-8?B?WEo4VXl2RTBjbkdOTlZuQkZUamNQdHQvUXkraHV3OUpoU1BjenBlRWd4UzFM?=
 =?utf-8?B?Z2JFOXZMMTJvVUw2Y0RPQ0RFUjRMb3FDQ0hXajcxZEZpVmhOK2o3NkpTaFJL?=
 =?utf-8?B?Sk1XeEluY3R4ZllLNmpXTE4vVTNDNzdKcXdMQnUzOW1wdWNjQlg4aW1QM3Zl?=
 =?utf-8?B?bGFCK2FWVmJJUEFXSGozQk40cUs1dFVUa09IWXdXTVJ4QU1zTGJYbTBqRGpI?=
 =?utf-8?B?a01sSnA3b0N5NWFPQmlBYWpwUVJtVVBIQmxDblpNTFRlRWp5c2VhZkI1MG5M?=
 =?utf-8?B?ZDFYWXp2MXRwNjlJOE5tN0I3ZHR2UmRNcUdYKzJvc09UYnMzclN1SExKRUxO?=
 =?utf-8?B?dHdnYWxYc0dJY0o5N1N3Z3Z1TUpEYkUyU1ZkdGVheXZ2d0JLQThzL2Q3WDg2?=
 =?utf-8?B?Z3BtWXpKU3laMWMyWXZma1hsWVRvVTVwUXBkTXRQT1lTcmhJekRlNlp6WWVR?=
 =?utf-8?B?RXZNVjJ0SzVYbUdCb3J2dUswZmt3PT0=?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-JdXSKEE7jV69sQAAtza/"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TIoadEjtTWX8WCMgECJfFoMYsjJttk1UaJrWMMcfhoR+txfMrpjOM2vmK3vCXaInWg6Ld+CGHMb1nRriJk2t4qOK6q5ww1D0K0d6WiFq8wuyiC50WgaiU2C3mFdh5ABs0aq8Pmsse+N9yNH47aMrE8cfysnGmlORpe5i8Y5vCEwHNWZplW43ZA2xr15jBmOAnGMt7ml3qoFttpJLJwScY9ECLTO9QCQ/2eq9FdQ6KUox+uAu8dETZ0mlg4WNQt9Iz2TGrf1j5FNrNJVvN3LsZogazLPdh1Ekff0j3OomYfu7SgehCR2tKcYbxDc7G5F5TxexLnWXAUCSYv7XqLuqd0hIFk3pac/7N2isXodVclAuJ9uTGqyNADntTcmiRhnYWxGAnWuPza7i65CzCP0LAHE0myHWC0qSwCbgKBhUHw7OLT7Sgs3Ta16KihL3RzTFh4DRhYCfvZmfsIf22x0alMJz8R7h5Y8v1DUVMmECHcqSRo7+yXNyzBdKlI/U8CZgzHw851Qeerc4O3QOP5qq/SQXyYNX4TYgT/FmEMTewAc3w4NQ+bF6pW6XEXI6IrI8TRRKCz4pMFAm/C+EYhRQ8a96HLfynynZBwKvknSoLFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44931836-c61b-483a-e998-08de000fad62
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 10:54:06.6239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehXLmAM9x0osw8b7DY7gpGjQpusziOj4ivDRMd2K9sDWbuuy/7+fXBRFCFP1lCN+9HU+bjyWVCQbIX/CAbNqRPqsKMPLVUHOCGP+xUWqC00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=886 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300097
X-Authority-Analysis: v=2.4 cv=H9/WAuYi c=1 sm=1 tr=0 ts=68dbb701 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=ag1SF4gXAAAA:8
 a=r4O46JjdtO_BfldeB2wA:9 a=QEXdDO2ut3YA:10 a=hDrkhndmxGQA:10
 a=YCNPRjBJbUA-A33l9CQA:9 a=FfaGCDsud1wA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: QWRcaEDbeESTb8BBZsIGI3UWEJky4cEf
X-Proofpoint-ORIG-GUID: QWRcaEDbeESTb8BBZsIGI3UWEJky4cEf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA4NSBTYWx0ZWRfX9fNpAtlIkrtd
 8Qa7awmTeOqyZ+wk+HbOeaukt94CkPM8yMsWQZ7N/B9cAwKaajPdIT7hr+x0CsdMpUK/Ie7BUbf
 JycvrARwhLFu34pn6BG9Tnw/puAOrDmJOXYm6CXSIqM0B9GyMefPY0M3R0/y2MpCBn0Eva4tAt5
 UPutUNw0GhPB8ilHOV9LQg4O2n6sd0PjFgmTOjABWVvvR42R9sZXhprkvK6ve1iRVn+nFB1WuNd
 t1ONcWk0z5tB8Ao6j+f7i58yr8Ryyu8zZ79/9lDbpkY/5PEDJrUVl6l6xpi6RrQRYvZufgbYKh8
 /DqGnfFxHopneH2Sxunjohud5MH3YdFIuDG6gr/TyRd9hOdpPh4phV/zzzvoyEOyU7825y5VN1j
 KzPrl8P3CTATF+PXnvYajwamfloYGA==

--=-JdXSKEE7jV69sQAAtza/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30 2025 at 16:19:44 +0530, gregkh@linuxfoundation.org
wrote:
> What git id is that?

0d0777ccaa2d46609d05b66ba0096802a2746193

> And this commit on its own fixes a problem, so it should be a separate
> CVE, right?

The reservation of 1st byte happens in the next commit.

Not sure why the change was broken up into two.

Thanks,
Siddh

--=-JdXSKEE7jV69sQAAtza/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmjbtsQACgkQBwq/MEwk
8ipcVBAAl8/8kBIrHzcevfrrMkI6JW9Tj6+w+8fqRn/M8O+L4+cfpN2n8BW40mDp
IDxRuU9XXFhLKdRbJ1sVUmUzksE2hzDU2l0gA/GtxPCEiOCiv5QgHqkAfSw4Tkpi
dtSXwYbQIPnA8RjmYNCxf8+Fa5AZSLJPuvV7SSStmUntXg2uMvd7PEUhck1WYLwB
s3s7NeWIHZATq1WNHx/mfxdFaOb6m39++fdUioNWiDf1IgCFcVy3O6/cHOk+UlE/
LqFRQCOtIPqxjo/Vy3zFjXSjctqpKEaMHSxaFU+6mWN+7X0VSoHEoKCFzLoJf21e
ZXcdsPXi070wqTqbojbpBp+0uVXLs8oY3eYk+HCc6ntnpUdVMJKfe0tnEeGo851t
0oYSNcpPuuOuL1OtyRbpzjNlhHBZzCFc156Wy8d4AQWDHvgIU/NPcz8LQoM8I1cf
XTgpgLCOPVHkzThyTxTGOpxJ4xr//fHhNgWb/nPY/lhDwrQQNUcqdhFz+Yc9pOZ5
ZZm2UOzLPLHJD4n3i7cwFwmz6VTWzOCz1fSzODhBrwF0St2ZFaBfpqItI7OaaW4l
ZqWmc4gI9hzdm5ZLT9dT4DC320m+3AymXPVs8VKXhcVy8s25GOhGvUBxnFBKU5HF
LR/0GPQS4BbhJ167xjd2zm75gyZrjhBT3/99TZAkp4Yc69oYH4U=
=bCGZ
-----END PGP SIGNATURE-----

--=-JdXSKEE7jV69sQAAtza/--

