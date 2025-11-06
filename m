Return-Path: <linux-kernel+bounces-889564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC6C3DE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 406704E19AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BFA302CDF;
	Thu,  6 Nov 2025 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hkgNsB4F";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U+trOraj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HtO67zqx"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839E354AC5;
	Thu,  6 Nov 2025 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473421; cv=fail; b=tBiRez1gYqQ8KTgocfZmRymXjvJKCLchttz6LRZQIcd3EHhxOfkQ1GJo1h0WmZV9ZQB7ELK3MytsT1Tx5seQtmjQyQ1Xir8C5hQTGOLlOPBvlqRXb3ogQEOs19D63rF54efGhBbEvmbMn4q+MFJ3nJtj9uHfPCsKgx8L/VT6TJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473421; c=relaxed/simple;
	bh=iDHooberNP4FRz9AS+Xi1O+NxzFZG2TYrHtRE2Guy+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJj5l6DEuo/ECWoe6Dse3KlyjO99mqAqU5BB3OebTmXqZhbMp5LfWHuNBWFwmNSq6RL2sgsFtnBB2Fg9nsSRSyUdml2H8hPDoqJB18jBCEE4UJiUNF5dlcsc5C7QOn35LwnqpdMdh48nuDOdn8/bIgxMVoMSvrwlmxe/W0OVGwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hkgNsB4F; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=U+trOraj; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HtO67zqx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6NRcHg3994035;
	Thu, 6 Nov 2025 15:56:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=iDHooberNP4FRz9AS+Xi1O+NxzFZG2TYrHtRE2Guy+U=; b=
	hkgNsB4Fga77Ckc5Eo5gX4G+w7GfOM58mm1fh5F3cTtxDDByPvMLSn+RdeKH9Fly
	ecddTUcoBy4K10K4TrjhouNwhHSTBEVf/aVWxZoXsD4DDlT7pYnw+ecxFK5t/NzX
	BSUg9F2vHPdiENF1b4DoFq6YH/OBbCz2gdnjYv4QDisvd4uDGGx30YA1oUOYEb6m
	irdhib3JZ39rsuh+D7uaT2kyMUsJVLKVpS7WcwnUgI63glxTnW6gvlrh4XpzK3I1
	2MMiM5JrgFVKqJeTAuVQBbosw+uS/FB+nm+mAU+JePazZBCXMm20muULNT4mnUmr
	mZdwytKbr7M5qv6+7H0L6A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4a8xy0t254-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 15:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1762473401; bh=iDHooberNP4FRz9AS+Xi1O+NxzFZG2TYrHtRE2Guy+U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=U+trOrajYrsPrQaNjPcK2VFcsd6qxEf2em7jPAIuuoL7+PUbkOGeePwf6S6mCN0bq
	 7MdsYubLWi8mF0GJfgKPaL+BAMO9hpbELLIuI49jsxQ0DrES6VvzLSCkpljEvxpSQD
	 0HU76vtI8Ynfj+CMDkWAysoAqL3G13NH4pZt1o6hkNtPCGm2WSUO0O6q0gWdSF7WAI
	 Kb0Ybs8McCS1VyoJtN8Cgq2SsJXN6yhobiN+dsdfCpNYOsnfnsdV9EuAJ22mSw+8kO
	 J0s3oWwr/4x95E19tZSRtAl1yt+CI/QKEyEr5Wj3wvPHv4MXozWy/Jlvun1kFjJ77T
	 xkmTrwiZCfipg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7642C40126;
	Thu,  6 Nov 2025 23:56:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id F317FA00BE;
	Thu,  6 Nov 2025 23:56:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HtO67zqx;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00105.outbound.protection.outlook.com [40.93.13.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AA7C940364;
	Thu,  6 Nov 2025 23:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GperH8EWtELWSsf0yLD75gUEMQPTHrb7ogvlKFpR30C7Fy0KqznJsciLuh8ib3TD6BaooVNZdJ4LdW0sE+G/uRzykOkP7BHRl6+PGX/gogZhQtLKItbKf0JBtTtCmDm1zB7eVfJDZxOfxwcJthRZB/6OWkwEPNe+3Yn3piOqYpcoN1maHxEwT13/H2qMoeIKhlrEbMQMsrMstB8Wf9YuMpoRg1Tw6BSS/0YtuiLccKLyWsyTAr9W/TitQ89EAZlANgFZjZg57+xC/cyZS+qo7E7rYNSFqfRq13gWg+mN8tbaNf9LZ7DDZAk2KoJPNtYVk6ic9CvlgQNGoZVJEnsz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDHooberNP4FRz9AS+Xi1O+NxzFZG2TYrHtRE2Guy+U=;
 b=bBzlI8rGzElUbyOxThZN7D5IBQU4ifxD0QfPwMA8f4TqPlaMIHzBoqv4+oMlIqMaUoQfQ2JKZAeZ3m7QqxDvmwl9KtYNcyovBAexSgNY6Uhw5J0RZVdXTsACfHsv/b+zehxcPF+4OA8kpxPShlim6NCUX/1DbTOfPOyi85yowL8o7g1Q/qv8ZxCoKthGe51Wt3UtduODSLq1Nzt9y9c83BUF28gubf/XJu+0E059ltQdrD4JczOSrVwEg8A2MbwaUI2fJxbUsCPr28h/xJ25vXzsjQ3w1X8lGbF/E0iE113YMOhObm9YlIrq33rqpRHgq7pEK1oKMT/27/CCYTD+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDHooberNP4FRz9AS+Xi1O+NxzFZG2TYrHtRE2Guy+U=;
 b=HtO67zqx7tL6qpxC5ZjmBmgo/Q/SRn0jGLQTLhb+hU1dlB/ymO3sjx2D7EjWstB7vqICR6JM9XEUD1/+7fHfpcSvOQnC+FNMyt1ePZx26rXcNODsy1sH+gQYNsFaXVrnKug/2E/YhOT2hlzNy5+szCCc1q/gFDWAFGMdrmHwsKc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 23:56:36 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 23:56:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fabioaiuto83@gmail.com" <fabioaiuto83@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jamie Iles <jamie.iles@oss.qualcomm.com>
Subject: Re: [PATCH] drivers/usb/dwc3: fix PCI parent check
Thread-Topic: [PATCH] drivers/usb/dwc3: fix PCI parent check
Thread-Index: AQHcTmShQYDNAvROeUibELkim1NKY7Tk1POAgACvgiaAANC1AA==
Date: Thu, 6 Nov 2025 23:56:35 +0000
Message-ID: <20251106235632.7gma6wodnchqalqt@synopsys.com>
References: <20251105145801.485371-1-punit.agrawal@oss.qualcomm.com>
 <20251106010123.mbtqd5epssrpbawv@synopsys.com> <87pl9v9z71.fsf@stealth>
In-Reply-To: <87pl9v9z71.fsf@stealth>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB6038:EE_
x-ms-office365-filtering-correlation-id: a2a51cad-6fff-4d44-8fd3-08de1d901eab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmlMTEY0MDVpQ1J6T3R4cncwc3V1MXVFTzZNVEFBa3I1SGZ3VTZsalNWdHQx?=
 =?utf-8?B?Tk5aTEc2SUE5UEpTN2RxYlc3SmpaalUyMTNsODRvcUU1OGJjeWRLOGd0d2k1?=
 =?utf-8?B?a2FncGxSME9iamIrbFUrazFzYis2VEU5QWFkbkVFOVlOQUhmK1g2RzZaTklI?=
 =?utf-8?B?M1dHOTNSQW44WS9aS0hhNklvbmF1T2RlNCtDQmtiN3JaRlZvczgyV2Q2MEZ6?=
 =?utf-8?B?UWJrNWEvZGhRL1hnZW1PRVhqTCtjYStIbzdZcjY3c3JibGhmWDEvWjZpQ2tz?=
 =?utf-8?B?MTVtVEtTWnZGZjJPdDh1WHA3Sld2MDhGKzJyRHR0SE1XZUN2QmNxMkZGL0ov?=
 =?utf-8?B?dUM0bi9oMjUwZWw5UUVQK28xN2diUExwc0YwSzFGMXA5MVFSUURJbGtpQllF?=
 =?utf-8?B?VkwweVpxUHlzR3NQeUNrZExoQzlRQlpTcXJHMzFCNjBSYzkyMUdvZ3ozVEdR?=
 =?utf-8?B?Y0RDNlJHM29ka3dqWGViczB5NnNUSGFoOW5JQzNidDlqKzc0eG0xWWN3L3Zl?=
 =?utf-8?B?aStjNHZHYUNmY0pOM01zR242WUl5TWc5MVpOZVdtem9RTVBiQU05K3NBUXR4?=
 =?utf-8?B?WWRwa05kaEtTVFUrd0VXc1BUakFOQkIwK0xFa05TYk5oOURqVTNZMlZMUXB0?=
 =?utf-8?B?WlpzcnNNaEVDREFaYk1vL2tGU2dUK3lwNlpubzkwOVhHYm81NWwvSG5lWEM2?=
 =?utf-8?B?TzlJR0xQeE9EeVBWZlIzSVc2Q21rd2lZNHZ3Zy9KMEk4Vm5PVURwY3ExMlZX?=
 =?utf-8?B?ZmM5SUNXbkxOM3JlYmt6RTBBc1IrME9vM0lXbjZpT0pVdmNrSGtGaFRkNk9B?=
 =?utf-8?B?NEpZZ0cvZDdOc1ZCVnBDbGZ5ZkVnd2t5QWUzRmdVTEhLOWNZMWQ5Vy9LdjJk?=
 =?utf-8?B?NzFwK0xYSFJFdktvb1Rva1pVY3VwM0VVR2hXcDhCSXNHVmJ4SE9tWTFaM0hB?=
 =?utf-8?B?WlJzRjU5SmRFSXJlRmRwTWhpNGtWMWZReUt4dXl4WnR1VVJpcFg2YThiWU1S?=
 =?utf-8?B?UUgvU3c4bGdEZVVVNk5EbTB4T3FWWEFocVJTdTVFRXUwckVkWTlYakdGYVds?=
 =?utf-8?B?d2tqSGUwdGFhak9YMTVIeGQrM3o4VVEwZEF5UXJCRzdZVEpxUmFxUFFrZ1NB?=
 =?utf-8?B?dEtwTUQ3M1FXSDlEWWpiUnlPdEljU3RQQ29xTlh4YzNZRVlqUURNM0h0V0V0?=
 =?utf-8?B?a0tSWithdlE2YnVVdnVKN0FVaEoxYVFoa1REdkRvLzZPdWhUbUFSdU4xUjNS?=
 =?utf-8?B?TGtyVHVsOEhwb2RENWIzNzhrV08rVDdBK28rN2hxblhmVXRCY3p5cktySkls?=
 =?utf-8?B?dVJucHlnY29GZSsydkllWVJzbFFlM2FNSWVXQmo2UTVVQjltR2V6Wm8rbUZQ?=
 =?utf-8?B?TU9CWHpJaFFxOXpKOHZaV0l6NlMwTFpUNFAwWllvRHlnVncwbWRwQXFPdGNF?=
 =?utf-8?B?dWhoTTUwTmd3ZThXcEVVSEVlOVF0SEVNU1dMNWY1VjZlUFEvY2JmNWNtdkJZ?=
 =?utf-8?B?c3Ezb29TVHRDZ1liUnJrbHRPYVV0dWozdkFJdFRENWQxU2E0WnFyczh6a1Vx?=
 =?utf-8?B?cDE4Vit3bm1jdHZLZE1sVmkxb3M3ZEtnd29nZmFYdzlvS3NqaUU1RWNLYWQz?=
 =?utf-8?B?Z3Q3S1ZteHhqNVdXN2U3UCtqcUVLdWY1ODlBZkx5bkRsL3Y3NzBrK2lIY1o3?=
 =?utf-8?B?R2hXdDk3OW9QeVBFa2ZBUUJZZXBGM1I4NVRqdHBtWjVaV1ZSWWJYTG1Vei81?=
 =?utf-8?B?Ny9RbkxxSTdIdG9mc0hpaGptdWRGWUo1c1ZzZ2NYTFRPa3M0cmlqbzZkZk9W?=
 =?utf-8?B?YkdLWUFkRFVrUld0emRoUXlzR0dpR2hWT3VNMExGNGxNU1h2UjhLdTNFaVZ4?=
 =?utf-8?B?SEo3ZVdrRUtMc0pMQVMyckJONVk3b0hiUzJqZDBWRUNwWVZ4cXdhelA1YlJm?=
 =?utf-8?B?bFpxcHlOR3crcUNRK3R1dnFsclJ5N3ZZTEYrUHBYWnA3Z0xoUVdSakVTQytR?=
 =?utf-8?B?K3FvMjFtRTVwcVJSQzZSR0RWOTQyMTlsZ1lNQTE3cXdKK3JqMWN4L3FYZHRQ?=
 =?utf-8?Q?3rScxQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bk5uUGNlRWlRei9aLytPMmN5aDMreDdMR085bEdYK1hKMkVwSEdQSjhBR2R0?=
 =?utf-8?B?RVJDdFVkWnJjTkZzbEEwVzNscFdvMDN4Szl4MnV6b1kvTWcvYXZuYmxlN0Q4?=
 =?utf-8?B?VE5uL2puMmZ3MEpDU1hybDA0UHNQSkZkMXdHZFk0SFU3dkdzS0F6anIwb0Rs?=
 =?utf-8?B?S3paQUZaRDZqQmp5RXdTVFdHRTBVcTNjaEdZSktoVml6Vzlrckg2YlZUeCtQ?=
 =?utf-8?B?VTFmMy8wVGgzRWo3eVdjekpGTDd5ZDFtS2RQM1RMdjg3TDBrcE1mZ0ZSL3Rt?=
 =?utf-8?B?aitmWExybmZUMFgxTFZZRWRBMmR3a3p4RjlJK0xiMGJsUSs1RzV0djg4VG1h?=
 =?utf-8?B?ZlFyZW10UXg5VzFTbzRCajlXTjE0K2FIUXJtSXFmQzVHT2lGaXdXSDFDMnU1?=
 =?utf-8?B?Sk5KOUFGVDR2V1pyL0FOanVzUUszUy9aYWk2QmVRelRmMEZldjkzZEV3UVo3?=
 =?utf-8?B?M0ZaZzhGditOWlZmV3ljdE9VcXI1UW5vdDQ4NVQ4R1U2ZVhHWmVMZVY3c1lx?=
 =?utf-8?B?RGprTEtxTnRyQllzQnFNcCtla3ZOakNkWDk5NHI3MHNhSTVBa1VqNHhFUGMr?=
 =?utf-8?B?RWk1NnlZT3lIN3A1d09tWndYVmJNUVBrZDZwUytzVWt0bGJIZVVHV3FsenFh?=
 =?utf-8?B?VlNaZUlyOUhYWVMwUTBBZjNUWExTai9qRldtQXM4YVJLOWNSbHc2TG5IbURK?=
 =?utf-8?B?RkRZZk5RZXVicldlOFZJbGJ6S1FlVFFNVEVpZU5DaEJPZk1LZU9BdGJGRjNB?=
 =?utf-8?B?NmRYWThtUFMyYmVtOFVydGVLWTAwRlhUdlNadlQ3Mk9iay81Vmw5NEFoa1ox?=
 =?utf-8?B?cVFMVnNSOHRnK1o3bFNQa3I1R1JTcDJFbnhZWkhSU1gzTHFzcFRrT0RQWEZq?=
 =?utf-8?B?d0dsaWdiejI0ZXZzRnpZY25wNktVYTQvUW4yVm8yanBrbUptcU9POWl1UkZO?=
 =?utf-8?B?dFA3V3JRMlZlMTVxUExaQjZ6NTlqaUdHRXJGTTV0NmNzNE5vVWFzbFlmOVdP?=
 =?utf-8?B?RkYxbXpKQWNpdTdNSmdnY3FHelV0SG9DVFVCSmhINThnTmF3clpkWGxsazVm?=
 =?utf-8?B?SkozMGhBb3lNcUUveENobTJ2WVVaaHdHWGVYRU0ySkZ1SVFPazdpamFONDRm?=
 =?utf-8?B?cURpVXJRcDRRckc1WFRoUStEMU9CamkzUlFqZ3lOdDkxNkZsZEJ4RVp1Z3hw?=
 =?utf-8?B?RVV3bkNmR3dzSVdKVjNHend4Zmd2b2lSUHFrSUlCTDZJUGZEb083NVZFZEI2?=
 =?utf-8?B?YVg0cjJlQ0xGZjJ0NjRvSXplZ0E0cTBndTFqS0NFYUczY3FreHJRZDdSTnFT?=
 =?utf-8?B?MDFYTEVFSS9KMWt3VE4xTzMyUXg0QW5COWo5U1J4c3RTMm1ObHFCNXZuT2Y5?=
 =?utf-8?B?OG1jWXFLU0E0VzZJSEM4bWZrWXNCVWwwbW5pOGtoTEEwK240Sm9mQ20veEFU?=
 =?utf-8?B?ejhYZ3E2dVZGK0FQc21RZzZOa3IzazdUSy9XRTNBeFJoN3R5eG1jOVVxdFpj?=
 =?utf-8?B?Zit2WFgwOHhBZnJRQU44c3hxME8zYnZVVzhCZ0NwSzZueW1ld3NzcU5OdVJn?=
 =?utf-8?B?U2JRd2U1eVdQUThKMVpXWVk4S2hkTEZUNXpBZm10MloyQTUzRTdpa0wvOUg5?=
 =?utf-8?B?Z0loYjNpUGQ3N0JuU3IvdzhjQmtETUUxVSs0NUtLeHFLa2ZYOVJLbHBKU2VV?=
 =?utf-8?B?a1NqZjEveHNqQzJTcGszNTFCODZjU2c5N2R0VHl4aUtQSWVjaEhiTDgyY09J?=
 =?utf-8?B?bURROTkzNWVad2o5ejRwQitrU29UYWhjYVEzZFB6S2lpM2RLcTJLR1BFVXhV?=
 =?utf-8?B?UlFSU2czTW9kU3JQRklSMzB5bEhYUDJWWlFxVjdBTS8wQ3R0SERRWitvZTNE?=
 =?utf-8?B?K0h0VzFhVkRIUTFEdE1OaldJcDJLMk0velJoSVJQZS8vMDd1V1ZMVit5L0U5?=
 =?utf-8?B?cWt3TFdaN3EyNWFBS1plSXl5Q283N1FBcEdtSVF2c2VWbVhHRllrTWdzSHA5?=
 =?utf-8?B?eFZla1IxcElycC9yZ1g3SnRJRmhwRjIydHBBTVlFdEZrL0VCK3RhcXJkV2k5?=
 =?utf-8?B?Q005dTBUUzNRWUZzRUNic21CZGIrNU5Zb3lkRDZwSDlNbmhxZy9RcDhMU3Vn?=
 =?utf-8?Q?2GqZ3lpxcNCKrai/HGBhJ/543?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1B005F07DB1F94AA305463825AD3C08@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ESSuurkAYv720swrmysli3sBTVihZLOWcMTXJBYMDS1PDLwOmv1C5bmcB1yzvccAPVfcddivi7KKiOXatJWKT2pdjrnmQO8PnGwAZEdW0JqhEss8KIjjzAEbW7FF/lE1IgiaR4mZeitCAKWlYUc57nbJyEw102GQyukJQ9ZWK8FF45gYz2qwwZC/2HZqbFQOkXDWvt4ucvnpKJTvByx7oJI8t8HFD1pc/ic50iq1CLeJISKGIow+fhrJQqvf5zCLXoCsTvltGoLAajScLg9VbBCEIlW6D2VbKH+sbS5NL9t2MxTAnHmJ7Dgc3TpjJOnFYIOAJrL1uA5bbjIkICG3TA5h34Fe7PpA1XXLbwle91xm9yjN+EJs/nmspcT5Lzub9MBksmo44dQ8WxlZHygrgcsE/fPDn0hYODu09TEQQhudCoaXNFPsSKm6WWH2o52uPw2kTTYSnXsAqUZik/ctwzXq0p78qR5l1mU5uSBi9VLbXqliTIPx2dHulWO6FVpnaMyLikQxkegEyDrIJ+1B9sr+OOX6CwM5pCSnXA26zR1g9RMLc1gkH4RsOJtZaes18gs45h075kmxJERbmaomUeaFU1uTMy/+4qpmrMG/xELotRP1p6hNJvtEIXWYVQdBrGgmLDEh4mwQCWzQVhhg5Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a51cad-6fff-4d44-8fd3-08de1d901eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 23:56:35.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EYNsroobUBXcYItfu3lUdO3ZEvUS5TOQgXtZROrno8FdqDuUYFtG6Yv82Mc38zBaabTt6g+EG/dDt8pDVmiPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
X-Authority-Analysis: v=2.4 cv=HJbO14tv c=1 sm=1 tr=0 ts=690d35b9 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jIQo8A4GAAAA:8 a=EUspDBNiAAAA:8
 a=aCur9PBiwGvCG8nz1owA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ncjYoolRpuiF12a2l3h6cyIozYFsannY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDE5NSBTYWx0ZWRfX0k4e9ianCcAq
 JdKMo1P43KF7A7owHYYWebePYVfqrLyOH2JNCQvHpe66QPJPEKsWn1fM4QJxGhxC/dJUj6j/s5c
 NQos6SbuLTF2y6G72UTdlXQfCu7NLJgqESh5K1LWY5gYEKOmnpuaDlMAiXwSZCsUBVu2EIx6vHt
 Ax2YoQGU+OZ9SW22KxWj5rbPk32hXbjSXhuz0kitkv2681WwEIy+bCyLh0G0GBH8oLxyAmQYzv5
 5f3jnd+lI2ZdlE1pvhRWdOKW+etguDtUrnP7ydnDS0rkMAdVrcXuDr+xT325eND4b93OBzO1gkE
 ydyuQ8xbOm/2hEjhvcLnBFDD++01HRuJzElnPIpJ6wtsr3NpM5xS0PLn5mEjI5wTHFQl0g3j5Lb
 YdPM2DzCV7yBn7Sl7tcPpEqv/i+ydQ==
X-Proofpoint-ORIG-GUID: ncjYoolRpuiF12a2l3h6cyIozYFsannY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 clxscore=1015 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511060195

T24gVGh1LCBOb3YgMDYsIDIwMjUsIFB1bml0IEFncmF3YWwgd3JvdGU6DQo+IFRoaW5oIE5ndXll
biA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBPbiBXZWQsIE5v
diAwNSwgMjAyNSwgUHVuaXQgQWdyYXdhbCB3cm90ZToNCj4gPj4gRnJvbTogSmFtaWUgSWxlcyA8
amFtaWUuaWxlc0Bvc3MucXVhbGNvbW0uY29tPg0KPiA+PiANCj4gPj4gVGhlIHN5c2Rldl9pc19w
YXJlbnQgY2hlY2sgd2FzIGJlaW5nIHVzZWQgdG8gaW5mZXIgUENJIGRldmljZXMgdGhhdCBoYXZl
DQo+ID4+IHRoZSBETUEgbWFzayBzZXQgZnJvbSB0aGUgUENJIGNhcGFiaWxpdGllcywgYnV0IHN5
c2Rldl9pc19wYXJlbnQgaXMgYWxzbw0KPiA+PiB1c2VkIGZvciBub24tUENJIEFDUEkgZGV2aWNl
cyBpbiB3aGljaCBjYXNlIHRoZSBETUEgbWFzayB3b3VsZCBiZSB0aGUNCj4gPj4gYnVzIGRlZmF1
bHQgb3IgYXMgc2V0IGJ5IHRoZSBfRE1BIG1ldGhvZC4NCj4gPj4gDQo+ID4+IFdpdGhvdXQgdGhp
cyBmaXggdGhlIERNQSBtYXNrIHdvdWxkIGRlZmF1bHQgdG8gMzItYml0cyBhbmQgc28gYWxsb2Nh
dGlvbg0KPiA+PiB3b3VsZCBmYWlsIGlmIHRoZXJlIHdhcyBubyBEUkFNIGJlbG93IDRHQi4NCj4g
Pj4gDQo+ID4+IEZpeGVzOiA0N2NlNDU5MDZjYTkgKCJ1c2I6IGR3YzM6IGxlYXZlIGRlZmF1bHQg
RE1BIGZvciBQQ0kgZGV2aWNlcyIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6IEphbWllIElsZXMgPGph
bWllLmlsZXNAb3NzLnF1YWxjb21tLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogUHVuaXQgQWdy
YXdhbCA8cHVuaXQuYWdyYXdhbEBvc3MucXVhbGNvbW0uY29tPg0KPiA+DQo+ID4gV2Ugc2hvdWxk
IENjIHN0YWJsZSBhbHNvLg0KPiA+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgfCAzICsrLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+PiANCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4gaW5kZXggYWUxNDBjMzU2Mjk1Li5j
MmNlMmY1ZTYwYTEgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
ID4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+IEBAIC0yNSw2ICsyNSw3IEBA
DQo+ID4+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPj4gICNpbmNsdWRlIDxsaW51eC9vZl9n
cmFwaC5oPg0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gPj4gKyNpbmNsdWRlIDxs
aW51eC9wY2kuaD4NCj4gPj4gICNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQo+
ID4+ICAjaW5jbHVkZSA8bGludXgvcGluY3RybC9kZXZpbmZvLmg+DQo+ID4+ICAjaW5jbHVkZSA8
bGludXgvcmVzZXQuaD4NCj4gPj4gQEAgLTIyNDEsNyArMjI0Miw3IEBAIGludCBkd2MzX2NvcmVf
cHJvYmUoY29uc3Qgc3RydWN0IGR3YzNfcHJvYmVfZGF0YSAqZGF0YSkNCj4gPj4gIAlkZXZfc2V0
X2RydmRhdGEoZGV2LCBkd2MpOw0KPiA+PiAgCWR3YzNfY2FjaGVfaHdwYXJhbXMoZHdjKTsNCj4g
Pj4gIA0KPiA+PiAtCWlmICghZHdjLT5zeXNkZXZfaXNfcGFyZW50ICYmDQo+ID4+ICsJaWYgKCFk
ZXZfaXNfcGNpKGR3Yy0+c3lzZGV2KSAmJg0KPiA+PiAgCSAgICBEV0MzX0dIV1BBUkFNUzBfQVdJ
RFRIKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKSA9PSA2NCkgew0KPiA+PiAgCQlyZXQgPSBkbWFf
c2V0X21hc2tfYW5kX2NvaGVyZW50KGR3Yy0+c3lzZGV2LCBETUFfQklUX01BU0soNjQpKTsNCj4g
Pj4gIAkJaWYgKHJldCkNCj4gPj4gLS0gDQo+ID4+IDIuMzQuMQ0KPiA+PiANCj4gPg0KPiA+IEFj
a2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IA0KPiBU
aGFuayB5b3UgZm9yIHRha2luZyBhIGxvb2suDQo+IA0KPiBOb3Qgc3VyZSBpZiBHcmVnIHByZWZl
cnMgYSByZXBvc3Qgb3IgaGUgY2FuIGFkZCB0aGUgdGFnIGFuZCBDYzogc3RhYmxlDQo+IHdoaWxl
IGFwcGx5aW5nLiBJJ2xsIHJlc2VuZCBuZXh0IHdlZWsgd2l0aCB1cGRhdGVzIGlmIHRoZXJlJ3Mg
bm8NCj4gcmVzcG9uc2UuDQo+IA0KPiBbLi4uXQ0KPiANCg0KVW5sZXNzIEdyZWcgc3BlY2lmaWNh
bGx5IGluZGljYXRlZCB0aGF0IGhlJ2QgdXBkYXRlIGhpbXNlbGYsIHBsZWFzZQ0Kc3VibWl0IGEg
bmV3IHZlcnNpb24gd2l0aCB0aGUgY2hhbmdlLg0KDQpUaGFua3MsDQpUaGluaA==

