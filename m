Return-Path: <linux-kernel+bounces-780841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED0B309F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA7360054D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2E2E1EFF;
	Thu, 21 Aug 2025 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D8plR5/H";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GV+OWuxI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ts6Uvli/"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE161C69D;
	Thu, 21 Aug 2025 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755819052; cv=fail; b=Qak5KVrP1wARIcBE+UouJWuIaZThNY/saLFihrslpAiYzHOns6j5lMi3QBqQEntz6p+b/gqk6+r1oQ3NqYGrEBHdsI1+2+QCDBePvIEmIombnTVxMhEJJYqOFWX7uHT5UOvyTJTtMbbYqFxdICYssgAoJhnDyyO9Qn8xZBQ7cGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755819052; c=relaxed/simple;
	bh=W8Cs550C1r5kPcy4qGmOsMYiaSgcAgggMeR7Y2XFOKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h8+yl1K6FGqqJ25WOxLrkYereoHjZUBwb2kc2z7FMbveIsYl7wSxITIw5O+vCZ/TUduVmFZHHW/OpGPqKq8MKhqwmpEdjba84H9kFk2c7ZvZ8VqVllXnUDr6wO3Xj7GPdT0WSQOGWrPVZ4lWyrQLJ24DM4V0aJ/kCWMeH/unXU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D8plR5/H; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GV+OWuxI; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ts6Uvli/ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LNMRsZ016734;
	Thu, 21 Aug 2025 16:30:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=W8Cs550C1r5kPcy4qGmOsMYiaSgcAgggMeR7Y2XFOKA=; b=
	D8plR5/HITX1apK/s0HlTvwlrmdGHFQNCND7TAQZVd4ON1BUR4WfClpPDYFNZ+WI
	JPoiV9/338qvgi0gzYPLKLqBpy5JZQP94Bd+0y4L3N6OT8xm3pKnQVWBpyAOYWSV
	x7rZGjOJOQPBjRCo3SKekoixXJWI5IL5yeypQ1zcp8sPtzB9sei6AqkqWBDHDwef
	DoCFVkCfw2ESr1giYecxmV3nQCMk/r8c4UvA/qjtYkrcqqk8zaOSy9WVi/S0GZtK
	kvlgf3ui3dBj4lC7/w5sj1lvDNgM1umOdzQzH/gqfAWFhqKIkkLR1fTMCrN1d2of
	fY5azTm8AY4BVWTcyWJmvg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48n8yeapu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1755819041; bh=W8Cs550C1r5kPcy4qGmOsMYiaSgcAgggMeR7Y2XFOKA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GV+OWuxI5cGxUlH1KAvh+GH6htRn2k59qYcjQq4VLzoS0ETz7PKgNiZEMCLDnITWZ
	 7bpZNhyRumNgPs2V/hayQf2ncHZRKhkECjoDGmQea9edq7WCarizwfEASh+QFpO4pT
	 eHVZw7rAqJSGb9DChbVnbPgVO8fd02Xvby9WOV45KPwHnrD/wLXney1g3ksnHt0Vwb
	 1od23Z0MgZfeiEWH5KL7B/ofU+4ht7aAX/bPcjKE8q2aIdp8sVHyVftECPap5ou3vN
	 ltN7Vut8ydCc/UAMFxuHke3wWO1Cw3CDoMkeoxGXS0n2+mn51msJAQk5tniY4+glMh
	 Xf53yevzOMFfw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 269C240343;
	Thu, 21 Aug 2025 23:30:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AA696A0072;
	Thu, 21 Aug 2025 23:30:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ts6Uvli/;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 06DC540141;
	Thu, 21 Aug 2025 23:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un724lSyek/Rg+Cnm9OJ3SukzdQwtOombgkGK+89T4Kunb6NHbZcWaDIXw7uKoXqjPEuJRfPmSdSEK68BuSgQpnXgcXndfxkIpfssdbabzJnbAf3HzAvO2F/CTRICu5MSE5/laf0YfFS0DhnpjEEnbHworL6vd9MumM8jM0LxovSR2AiePf63mH0WWQeBEi9WMQ/0rqd5ipYNMPBLvJ68vH6Vt+YKq0Kk4AnWW8FrjwK5iBEEOYdYHBQyQgRUF1iNenO83br0YUgR+M+hjKytboMIVspW4nhMFMlTrALPJKKudfHM6ZAp50OH5TtsgESw8HhhW5cwarGJ0zpRlXFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8Cs550C1r5kPcy4qGmOsMYiaSgcAgggMeR7Y2XFOKA=;
 b=YfLPIyveSNU0TDvDmuCrmlTqeByp2qstEDfIueGCJf23HfY5iaDAQ7KexeqPjBAsm7j91QOhkmdS9ZUPsbYVDzO3foIT4yL+CAuEI2YBDJxmUB350jdNHfY97bYMiM/0QOIQYbil+gPeVSA7D/BgqKNoKhEPZ7Rxc/PpFrGJhbYGssNq9azKKC+MvrLpQV+XvIH9ZKHkSKcw0c2REmmASBvIcJB5NUui1zYefn/+XCBrpgocKz5to839i4s+OOe0Ku/R5Phhh5KqfJAaPo3ZnGb6y5tVCdRxhl/x8cVt0G81e3dEsTnDBsRDs5dulMc0gi4atEcDFq2huVQHRx7P+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Cs550C1r5kPcy4qGmOsMYiaSgcAgggMeR7Y2XFOKA=;
 b=ts6Uvli/OcDJ8boaqi4qApY79BdFE9HrWrXikhdMoXEMRCq3iAYJahXv8CGDguU4U2aCzftf2eAk/JJig5xfOfLxQJwmKx6jz+i+vWXIuTyeG1VKO1bdscfb46BqsGae07qGFatj+BUm2ULrswLDGqS8Y86UeNTfItHCytQWckk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 23:30:36 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 23:30:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: dwc3: Add trace event for dwc3_set_prtcap
Thread-Topic: [PATCH 1/2] usb: dwc3: Add trace event for dwc3_set_prtcap
Thread-Index: AQHcEAZ3YwSYQH0Ntkmd6fH5xoEBN7RtxyKA
Date: Thu, 21 Aug 2025 23:30:36 +0000
Message-ID: <20250821233035.e2yl3yvoq5i4jpdz@synopsys.com>
References: <20250818060757.2519126-1-khtsai@google.com>
In-Reply-To: <20250818060757.2519126-1-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV5PR12MB9754:EE_
x-ms-office365-filtering-correlation-id: 4694eba2-c6d7-4374-b0ad-08dde10abb79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UktYV2xEa284bVFLbjVyRFpKc25BNjlhNjNUMXlWZENkNGE0MjMrMFNxekts?=
 =?utf-8?B?YlUwais3ZmlWY3ltdndpWFUzQlZNZkY5eUZjak1jMjNGVDBBRE5Mb1VIbU5B?=
 =?utf-8?B?bFNSQ1A5cEdQSGhjQ1hxWnp4d2NnSGtoUE56cU5jcm5LY2tyT3dPUGtXTUpL?=
 =?utf-8?B?MndobUdYZTdFRWFXZXQ4czJ0YnR4Um12QTk2U05uSHg5aXVzODNBWWpEclNF?=
 =?utf-8?B?eHJrZTRESG1VL1VkQllPa1JIbHdhajhOZDE0R1FRYnFvYTlvcFJxWndHa2ZF?=
 =?utf-8?B?cTNabHIxaFhMU0Q4Q3g2RGl0REdFakFrblJVQWM3Smp1ekVYVEFrQXVpRk5o?=
 =?utf-8?B?elU3a2hwWHpjNWZDV0M5Zk9PUk1MMVJkMVVlakxlY2REMWc3WGdyNFNLcmFU?=
 =?utf-8?B?dC9KYklOQWVZNXBkN2pDOFJ0UFh3ZDhDMVQyck1iQzBLSDM5ZmJNdmJieDhP?=
 =?utf-8?B?anJlVmRhWmpSVWFHTTI2MmpiQU44dm4rWHBaVDdJWklkbmtpcFB1YXlJQWFO?=
 =?utf-8?B?UVB6ZXNkUUFNdXMzcXl2Vittck1xTEI5OGx6RjdiTzc4RTFKT2xFUFQ5SDRL?=
 =?utf-8?B?b0RkT293eDJCZUZjSlRPZVF6QWUvZTVsVE11aVhKMk1taWF6TFRzL2hDZ29m?=
 =?utf-8?B?VmJ0NHBlUXcwN3BkSWFYOGRQZG4xRnJWZHV5dUR5cC9OeStLUlZDMVFUYmQv?=
 =?utf-8?B?d3F6WkdFckxYRUNjM0ZnRGQrN3Vaa1owaVVHc0FlTDF3eUs5Tk43eEJYamF3?=
 =?utf-8?B?M1VxaVVOS08zWlpHMkFjY2syZE94NDE3QWZEYURZeXlqRWNMc3RUcitpOVlX?=
 =?utf-8?B?SWdxN21LRld0SUNvYU1hV3h4c0N4UWJRYmNocmRKS0NsdXpxMll6N1hpWWJX?=
 =?utf-8?B?cE1vbWhqNFFVaFM0MWc1UTJYTkQvaWc5bmNJemZhVGdHRTM0SmhMRlhOTk1K?=
 =?utf-8?B?bjhpSERmaXRqVW15aDJYSmI4UXM2MlhTQ01RQThzQ0labWdBc3dGR1pxNjA3?=
 =?utf-8?B?ZkNhOUNTVFZVVXp5TWZXVGNuQlp0WmRKMWZra2hMOFlEYXEwdmY2WCs0VU9H?=
 =?utf-8?B?TG9pK3N3M0l2STdPT3dTY0hlSG1uazNDSktWZnNVZFFRU2RtVXFPZVJzVld4?=
 =?utf-8?B?WS9leTNJemVkdThUU2hCYkZEU3RnTVZwRWFaRHBFWXJWNDh6N2I2MTlXK3JM?=
 =?utf-8?B?OW1wSlBpNy91RUt6WE1RdzNydHo3QUZXQktrNmhwb0J2cFduNG16dXVFNC9v?=
 =?utf-8?B?L2ZlTTdSNWNhY0xTSUVGNEdGMmZSRnRBR0VyMUJHUWs1amM3T05QaXYrTkV6?=
 =?utf-8?B?QlNsZVZvUDgrc1NKMmlRTWR4L0ZkbXc2TlNxMTVId1c4dE9YaXJNWVpOTkRk?=
 =?utf-8?B?d0xrOS9sZW1kR3ZQVE40WjZldnRiNXN3ODlXdEZiS2tXU3l3WW5uQzlVSnpl?=
 =?utf-8?B?NllpUGtjSXFqU1ZxSE5KelpoNE5YK056U1N5eHRxdnczRCtjRVhUY1ViR2th?=
 =?utf-8?B?ZkIvWERZSDlkQTVGbXNkUDZNd2RNZUpxa0MvZUpQRGFHaGw0MG91eU40d0E2?=
 =?utf-8?B?emlmcnpJT1BlNGlHV2JUQ2Q2WEUwSEdTMm0yamkxMGFnMHhiZWZOMkZqNGd2?=
 =?utf-8?B?OFRHbHkxY25IUVBDTFVjanJiMmpTUk13OHVLV21EQlF2a1pMSFZnUzRUSGZk?=
 =?utf-8?B?VlYwWHh4QkZEYit3YVRIclQzNEtuOU16WElNMnFDdG84N1BWL0FmaWNxbVox?=
 =?utf-8?B?RWl2RjFNcnpIc0MxSGx5Rk5Gc3NKNkdIS2liL2E3aExNRGRCYXBSdTZiQ2tw?=
 =?utf-8?B?N1JON29sTEhwTHQyd2wybFRZNHpGS2VxZFAwTHlMaEtyUk02bHV2dXh2bnUz?=
 =?utf-8?B?ODdFcjM0M0RPeDJaYTNRMzc4YUNKcWhQcEdtUjRlOUtOL291bWs4cFlDcllM?=
 =?utf-8?B?cyt2b2RVeTI4R3A4Qy9teHdCK0tSem9qUjNoQzBYemh5dEpNZjZRNzhOaEx4?=
 =?utf-8?Q?iIDb6Oklyoi/yrRsItfsmyiEaGpYaA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHhNUzhtbGN2eUZCQzV0azhzSmNROTdIbVNsS0hZWUJpNlVzck1SdHJTUUtB?=
 =?utf-8?B?MDNBVEExcWNONnRTS3VxS2JmR3B4WTIybTJYTDhUaGR2NkloUkQyWWJRYVBX?=
 =?utf-8?B?Y0dObGZaTDFhc08xOGpQUm1pREoyREFTRkxGbGFYTmRGMkp2MkVqRDk0UHc4?=
 =?utf-8?B?VXlhZGVpK3c3TWwySnB3UVFXL2pBTHY5K2wwS3FpQjRyaDVIWDExcEJLczRM?=
 =?utf-8?B?UDRuWlFKdmRVbTRob2xvcFhCMGVHMlFqOGRjeXBWVmxWR3l4Z1RSMmNGVmZP?=
 =?utf-8?B?eTJSWTlOakhQUzJOV1dNdHdCZERWQnJqek5KNnRyR08wWFJRdTl6QjNUVVBG?=
 =?utf-8?B?ekQ4c054citha1F0Wm9MWUpsbi93WDZ1UjZFYnZ1ZHliN3J5dVMvRG9EUExR?=
 =?utf-8?B?N0t4SnVzZGs0M3BMREtCa3p2OG9CK1BUR01zTHorczZUT2o2cXh1MVN5dk9P?=
 =?utf-8?B?d3o2c1k2bHlueUw5TWk2QUZIWFhLQkhPWmg3WklLemYwZDVQYk1lN3FaTGxR?=
 =?utf-8?B?QlRPbDRWZWw1T1MydmNMSTFnTTJxQ0Y0RmtWMEpxOWM4OHlodmttRkRUUVZj?=
 =?utf-8?B?dGg1WE14SzJuRU9wUzYxZVUvaEdpYThjKy9kRU5kM0ZUdkw1UnNtOGkxVnV0?=
 =?utf-8?B?VkFaUEtRMTZXZFBkMUd4S1g1V3hXNGxiazU5dmsrdVZ4MVVjc2dLSWNRYkNk?=
 =?utf-8?B?NEVkK1lrSmNiK3hpeHlIN0pjd3hpcVdyTXo0bTA1WnJOSmpvMXBFZmJWVEd1?=
 =?utf-8?B?TGozUXIrT3pkLys4ZitzejhMdG5xeUw5ajM5cTRPN0g0UVBVRWQ3NVpFSWFu?=
 =?utf-8?B?NVBycEN0UVJmUHBjbEM0SUdidlVCRFVib21ncnA0TmpuL2ladnEwR0dkZ09x?=
 =?utf-8?B?VWJ3YkRmMXZzVVdyTHJLdVV1cTlTR0dtcW1MZVEwc0Vtck04ZFN4VGhkQVhv?=
 =?utf-8?B?c25WYnRWVkt0ZVJDenF6dWc3R1oxRkxvNWR2NlJnYXFOVWhXNUdKZEQwbWta?=
 =?utf-8?B?eDhqcVNKSnJVMlBxL0taQlpjMTJZcEx0R2FDcGVHNFZYUVQ5THBzVHlIM1ZP?=
 =?utf-8?B?bFJVSTRXdk5wdktZb2Z5ZlNJYlk1ZnFieEV3VkVhMnI5ciswRUI4djhpUjhj?=
 =?utf-8?B?SzRiWGhhb2I0YUJwRW4zMUgxWlArdjNHeCtPTGcwb2JtNHpUMjFMeWJ0YktQ?=
 =?utf-8?B?Q2g0dUxrUWt5SmJVK3dBZG5SUHhzK0R5OE9LejBnWW1iemlzYUY5dE9xc053?=
 =?utf-8?B?YXczYnB5K3l3V2c5WmpkTm1yL0pFYkl2TVhWbGVMQllTeXNMT1JmK21TQXlD?=
 =?utf-8?B?R01ZVnpnTkFOQ1lRWTRiMmNLRFFnangyK1VpQm1xVStQZU9XYVRjZ0dlN1p2?=
 =?utf-8?B?UzI1SWlqeXBkNzAwQjFTcldEcDhCbThvNFpBbm9aVVB3RE9HUUtqLzI4OTJh?=
 =?utf-8?B?aEIrdlg2dVY2cW5jOG5RWjFvZUc0NVBYeHVOZStHeEpkMStvaEszYW9yOU1N?=
 =?utf-8?B?MmNVL2pZaXlxNEh2TGswelFmc054THlFWlRPRjFxaVI1dlpvaGpRdG1XS2gw?=
 =?utf-8?B?VWxhS1N0RGhVYmtJR0xwemwvQkRVdCtFcXhGdmRySlE2U0ZsaGdTNmYrMEwy?=
 =?utf-8?B?ZEdXQm9Ia1VNZ0dIOVZoOUs5MW5DQlJiUjFoNUw1UXIwUlNTejVybFRiekIz?=
 =?utf-8?B?TDRwcnlTYmg3Q01IamttWUxWOU9NTnlSdEtwYnNxaUJibCtycUJiQVIzcXo1?=
 =?utf-8?B?OXNrLzRUeGxFWWtwRkgzOTZXQTZZcVRxZmZyTUZ1N2RhSlNRR2pnbUZTMzhq?=
 =?utf-8?B?QUM3M1duZnZKeEZjc2VUOWpIdDJBSHNjN1dTMGQvWEtSbVdTV3JQMFZobUI2?=
 =?utf-8?B?MlZJNHI3RW13Z1krNkVHRkZtR0MzVk05OWhHdWcvSVlKUEhhN25XeHluSWdu?=
 =?utf-8?B?UXRmaVd3aW51d2ZFZDVsY2ErV2poY3J5alVvYWhhTnduRHFnT0ltTjlaczdz?=
 =?utf-8?B?aFgwUWhHTFh1WkxNVlhRTmp2ckZIdEZGWjZiVjdycFdZdHo0OXF0dHB3SGRh?=
 =?utf-8?B?bG9SWW0xeXdId2xtRDRYZVkyYkxwR25KakpLMzdESUdqVzRsdi9EdlhRdmc3?=
 =?utf-8?Q?G8CcbgQEFxgY0uMYW6t9sbs9C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D23853F69B9561419F7CE05A31D89ED2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g1JTYQVOD+djI//Mphxq+sWOzF0fxRk8OV2d7I4+HJFJz0jbOsGYJbypkNn8F1OatfnDhX8Z8kL63XFG5ZZNqnYpc6xWFB6EiMV3DMw4ba69wT4naRpKkgHHofrH2NEJqE5QnI9W6FS0VAPfZu/tX49FHcsrK7EjJq/tsRkKMogAtavxJ8aXr/SciFxVTVrB7g3bU88EYcXDi1mmP1oxLyqd2lAxd62gaEHIe4pbSxf19b8jL5cklSBSk+omSxxe4iKut/Np7SDg1vAVHBuhOBNtt/3HIsnqFP0WKccSgNRIP2Cm4kTUaoxXHf/GGs8riL4FwivaIHyGNg42jMEaiKmtDKr3DA1lFcGUSLozi0pqm04ydHtiDd8jXwzhyntg3iCIJV6SarTnPioD8bkc1QIodzUbTZc0hrBY1lrUIol/57sR5anpiliDpo3qz/MQciKLySE92Sd0/q1ZOIig3d2qoSfSr/46T7sMGucciA2WnheNkeEFzh1KyeIB/XavdPvpGKDBDWKLcaUP1Xn5niWWpGRQpf2ye17W/RCPyp4t16FapEBKvuUv+pgCaZ0t6HyeHbdaFdd9/LNVZMoO2glpbwx9wjUVl5KA99YgmOFl6e9p/TsIZhfsrxMiyoqgyHbXtUfeyCDBUPsRP59yJg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4694eba2-c6d7-4374-b0ad-08dde10abb79
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 23:30:36.7219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5lpqg+REh6DZ53KN72QjR6lMC9EqjRJg0K/YsZMaYCsAWcN63Zd+1XVNdmMmgDVlfHOsOLqGZYi12QB+NS5XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDA1MiBTYWx0ZWRfXw0JCOLD8/VEn
 5bLeWmzz0L+EGzeFc0nYqHuGQHPvdACNgPLeu8CW2KKwrarmhsa7tibexf3r3XnMttfDQu5U8Ru
 bvQ0G5c7ieW0I4oHP4W/hGbpJEsdlM9msyDzBBRUDuFGQHLFV1RwEvlpl3nb18hyMAtWihhu1tQ
 ZPhA37cQgY3W0/k1V7J8RTm+SaamHzcEDIfPMap+Ide7PrwZPMS+eb0UUwdO0BTC6ZtyCDn3Wjv
 hXvzGfnZJ/JNqwrCEGLa0hNtPI9CuTIsUrBFW4QhcmVItovUXtA8qkor7znw6Bz4LMkhY/Nabzx
 Yp5dfpxF+n1kbPh2Y4TowcbAY629Ce0fuLbgOjZWFq0V9C8qXVawlh3FJs0PTL5Ts9oE6rQhmDJ
 9yql+rcks8e50uAlOdDVRHA/k/GFzA==
X-Authority-Analysis: v=2.4 cv=KcKLcQYD c=1 sm=1 tr=0 ts=68a7ac22 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=DeF17jhmhywNsQ1Vb-gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JwwFzQI18TFIVNBNlvmyIUjNbBFVszd8
X-Proofpoint-ORIG-GUID: JwwFzQI18TFIVNBNlvmyIUjNbBFVszd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2508110000 definitions=main-2508200052

T24gTW9uLCBBdWcgMTgsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IENoYW5nZXMgdG8g
dGhlIHBvcnQgY2FwYWJpbGl0eSBjYW4gYmUgaW5kaXJlY3RseSBvYnNlcnZlZCBieSB0cmFjaW5n
DQo+IHJlZ2lzdGVyIHdyaXRlcyB0byBEV0MzX0dDVEwuIEhvd2V2ZXIsIHRoaXMgcmVxdWlyZXMg
aW50ZXJwcmV0aW5nIHRoZQ0KPiByYXcgdmFsdWUsIHdoaWNoIGlzIG5laXRoZXIgaW50dWl0aXZl
IG5vciBwcmVjaXNlIGZvciBkZWJ1Z2dpbmcuDQo+IE1vbml0b3JpbmcgdGhlc2UgbW9kZSBjaGFu
Z2VzIGlzIGVzc2VudGlhbCBmb3IgcmVzb2x2aW5nIGlzc3VlcyByZWxhdGVkDQo+IHRvIFVTQiBy
b2xlIHN3aXRjaGluZyBhbmQgZW51bWVyYXRpb24uDQo+IA0KPiBJbnRyb2R1Y2UgYSBkZWRpY2F0
ZWQgdHJhY2UgZXZlbnQgdG8gcHJvdmlkZSBhIGh1bWFuLXJlYWRhYmxlIGxvZyB3aGVuDQo+IHRo
ZSBwb3J0IGNhcGFiaWxpdHkgaXMgY29uZmlndXJlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt1
ZW4tSGFuIFRzYWkgPGtodHNhaUBnb29nbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5jICB8ICAxICsNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZGVidWcuaCB8IDE4ICsrKysr
KysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy90cmFjZS5oIHwgMTcgKysrKysrKysr
KysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gaW5kZXggODAwMmMyM2E1YTAyLi4zNzBmYzUyNGE0NjggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
IEBAIC0xNTYsNiArMTU2LDcgQEAgdm9pZCBkd2MzX3NldF9wcnRjYXAoc3RydWN0IGR3YzMgKmR3
YywgdTMyIG1vZGUsIGJvb2wgaWdub3JlX3N1c3BoeSkNCj4gIAlkd2MzX3dyaXRlbChkd2MtPnJl
Z3MsIERXQzNfR0NUTCwgcmVnKTsNCj4gIA0KPiAgCWR3Yy0+Y3VycmVudF9kcl9yb2xlID0gbW9k
ZTsNCj4gKwl0cmFjZV9kd2MzX3NldF9wcnRjYXAobW9kZSk7DQo+ICB9DQo+ICANCj4gIHN0YXRp
YyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnLmggYi9kcml2ZXJzL3VzYi9kd2MzL2RlYnVn
LmgNCj4gaW5kZXggMDlkNzAzODUyYTkyLi43MGQ5MDc5MGY4NzIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZGVidWcuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnLmgN
Cj4gQEAgLTEzLDYgKzEzLDI0IEBADQo+ICANCj4gICNpbmNsdWRlICJjb3JlLmgiDQo+ICANCj4g
Ky8qKg0KPiArICogZHdjM19tb2RlX3N0cmluZyAtIHJldHVybnMgbW9kZSBuYW1lDQo+ICsgKiBA
bW9kZTogbW9kZSBjb2RlDQoNCk1pbm9yIG5pdDogd291bGQgYmUgYmV0dGVyIHRvIGRvY3VtZW50
IGFzIEdDVEwuUHJ0Q2FwRGlyIHZhbHVlLCBidXQgaXQncw0Kb2J2aW91cyBsb29raW5nIGF0IHRo
aXMgc21hbGwgZnVuY3Rpb24uIFNvIGl0J3MgZmluZS4NCg0KPiArICovDQo+ICtzdGF0aWMgaW5s
aW5lIGNvbnN0IGNoYXIgKmR3YzNfbW9kZV9zdHJpbmcodTMyIG1vZGUpDQo+ICt7DQo+ICsJc3dp
dGNoIChtb2RlKSB7DQo+ICsJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0hPU1Q6DQo+ICsJCXJldHVy
biAiaG9zdCI7DQo+ICsJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gKwkJcmV0dXJu
ICJkZXZpY2UiOw0KPiArCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9PVEc6DQo+ICsJCXJldHVybiAi
b3RnIjsNCj4gKwlkZWZhdWx0Og0KPiArCQlyZXR1cm4gIlVOS05PV04iOw0KPiArCX0NCj4gK30N
Cj4gKw0KPiAgLyoqDQo+ICAgKiBkd2MzX2dhZGdldF9lcF9jbWRfc3RyaW5nIC0gcmV0dXJucyBl
bmRwb2ludCBjb21tYW5kIHN0cmluZw0KPiAgICogQGNtZDogY29tbWFuZCBjb2RlDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL3RyYWNlLmggYi9kcml2ZXJzL3VzYi9kd2MzL3RyYWNl
LmgNCj4gaW5kZXggYmRlYjFhYWY2NWQ4Li5iNmJhOTg0YmFmY2QgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvdHJhY2UuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL3RyYWNlLmgN
Cj4gQEAgLTE5LDYgKzE5LDIzIEBADQo+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiAgI2luY2x1ZGUg
ImRlYnVnLmgiDQo+ICANCj4gK0RFQ0xBUkVfRVZFTlRfQ0xBU1MoZHdjM19sb2dfc2V0X3BydGNh
cCwNCj4gKwlUUF9QUk9UTyh1MzIgbW9kZSksDQo+ICsJVFBfQVJHUyhtb2RlKSwNCj4gKwlUUF9T
VFJVQ1RfX2VudHJ5KA0KPiArCQlfX2ZpZWxkKHUzMiwgbW9kZSkNCj4gKwkpLA0KPiArCVRQX2Zh
c3RfYXNzaWduKA0KPiArCQlfX2VudHJ5LT5tb2RlID0gbW9kZTsNCj4gKwkpLA0KPiArCVRQX3By
aW50aygibW9kZSAlcyIsIGR3YzNfbW9kZV9zdHJpbmcoX19lbnRyeS0+bW9kZSkpDQo+ICspOw0K
PiArDQo+ICtERUZJTkVfRVZFTlQoZHdjM19sb2dfc2V0X3BydGNhcCwgZHdjM19zZXRfcHJ0Y2Fw
LA0KPiArCVRQX1BST1RPKHUzMiBtb2RlKSwNCj4gKwlUUF9BUkdTKG1vZGUpDQo+ICspOw0KPiAr
DQo+ICBERUNMQVJFX0VWRU5UX0NMQVNTKGR3YzNfbG9nX2lvLA0KPiAgCVRQX1BST1RPKHZvaWQg
KmJhc2UsIHUzMiBvZmZzZXQsIHUzMiB2YWx1ZSksDQo+ICAJVFBfQVJHUyhiYXNlLCBvZmZzZXQs
IHZhbHVlKSwNCj4gLS0gDQo+IDIuNTEuMC5yYzEuMTYzLmcyNDk0OTcwNzc4LWdvb2cNCj4gDQoN
CkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRo
YW5rcywNClRoaW5o

