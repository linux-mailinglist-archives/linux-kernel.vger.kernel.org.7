Return-Path: <linux-kernel+bounces-867874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A878BC03B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4051AA4309
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2156285C9F;
	Thu, 23 Oct 2025 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PMMZFmwk";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Xx1mRiHz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HpOJ3tTZ"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214F26B742;
	Thu, 23 Oct 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259539; cv=fail; b=UHQ19Vgn3T78Pn5PNPkfVNBZ9wWgpf4xowpkzMd0NIbab3l1qTsHK4dV8vIAQQleISFNjroNhJ6T61hJiwMQTWrj48JDw2zTk8Ws2qbCV3yzAMIDFoeUgkCUmNmo4KM9fF6t8mDDruy6gAnfZSNPhdXyC4feWw18/VP6UCqdTBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259539; c=relaxed/simple;
	bh=XuTTD0LlBQ7GARiNhGnBKBw85FFhzUew15cFcWjVpk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P6VNU1lA5PYwWNK5Gke+pF+PxDukXn7jd8VB49x5m6ee+0GWEgTzrpvj1hu2z9EU3gBq9itpeUWN7PzRP+g0tnZf2OjBNJjTPFjkiPguOtXTiGL36npvmkmSBjj/AikA05nxfMw08GhEXq8yInH3KqUXumZD6B8U8+Ufz/ZFxic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=unknown smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PMMZFmwk; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Xx1mRiHz; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HpOJ3tTZ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NI69TN004969;
	Thu, 23 Oct 2025 15:45:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=XuTTD0LlBQ7GARiNhGnBKBw85FFhzUew15cFcWjVpk4=; b=
	PMMZFmwkL79no03856xsQakpO/0UiPIZeK9U5utdiSjgMeEkV0CGPeKKIAzuMr9m
	3EfLLOKSTBhppQ4vNM01VE6BiZs1EjEqoJDVTKSby86VIy6C6WLkHR640rWKNEXD
	pHWtLN/MLOCnBv4/um5mhi3b7CwqlYvjbJSlJKF9DlWaetX7MtvfT/TVZ7yBq5gX
	R6r8LJ225qRPtNJb6UFgA7oD6vnEgpV2gOuR2rK5AiK8LkTsZlYn69G4qhRlZqk0
	Ba94HyQsA1dEdfk7V0fu8xWdL8S0VWvKHDLPLeHQxqm6sS42/XzM+HpcVWYhZg+V
	YcjJNwAeXNf+cESh94F9mQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 49v9hfn07s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1761259511; bh=XuTTD0LlBQ7GARiNhGnBKBw85FFhzUew15cFcWjVpk4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Xx1mRiHzni4Kaml4i0ma69/CU5FxRJ3UVPgzPsUnpMf87IhBR1+e/zpejapAwVJW4
	 1PNa9S7g3u48ZN5M9nWdXA6DnGJD2z+1AqkYhrEQH506vsDkGplfYcJgufe9++DQ50
	 VW77ed+hWoRNZas5lqc+WASN5Ymn1GD9elUShhiPOutANPzk1/5vylHKSnFh3Dq2Sw
	 oWVsu/6bp/7el3NW+arKUje9zMM6bW8ZDvwS9avmiFytvgvYHkDG2t1bK1nUDgmMz5
	 guSwtO9qomJNl8vuFHCMLhKU878Sfyl0C4i9h1/yBkMp5a3Po/2FWH5OpvEyA0FZbE
	 qhBdDTIUHwckQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F20E401F5;
	Thu, 23 Oct 2025 22:45:11 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DC661A0070;
	Thu, 23 Oct 2025 22:45:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HpOJ3tTZ;
	dkim-atps=neutral
Received: from CY3PR08CU001.outbound.protection.outlook.com (mail-cy3pr08cu00100.outbound.protection.outlook.com [40.93.6.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3687C40054;
	Thu, 23 Oct 2025 22:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B07dzmMCesCHXIhPjzXGyFyOdFzXMSQ73JeBJrzPsfG+xDk4j/D+MvMDLFMc6EbFuDEArz4IITH8pZJj58DgYCE9dBRZCyDBxL/xa23PCV65neYO3aQhRR44+S4RreojPjWnST+YUGc/Ss67ENKh+XpYlS2Jh/XZh0ytNVXPs+RAcHx888HZPnZB7XOskZUSbuxWkpW1tQ/Xh2JY0G8IZVVPJ5xY1rq5Us+LDFlfFFicrSX9Eafs2wPlO3/2obv1s0mwzu8X7vbEzoT+jAvWBp2ttuE/rwQHNTMa5YPh3H4Eon/hr82kiDrQOOhEUJCDG+G3d+dA2k9BuLeoBqhedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuTTD0LlBQ7GARiNhGnBKBw85FFhzUew15cFcWjVpk4=;
 b=MX1JrNagI6kB2Ij+kpcQEETYSDkvT7L15ZNKgwdXxyrV46mA/cA2YhOBwbfk9xntxfFi5bQMlUiRJ4fJiIh21RXZtE4gYCzVyObXtgswMqkXCyGBLNQDRrsBE/kl3XsAe9sFCbWYtghN0R9MRkoYdKIhSgZnrN6O2WNZpL1wgqR2YujE5prm3BtH4l7K8Z56wjBKqC3IXVhtj11iUqIfB3I2oaOBhdYJ1juyNntUH6Wt1tFZwCPBnN6dscWSjpAlSj/cjPOE5AYMAwH46ubiKF+JU2DslpMfPv7AhK5bdROU3Lik7S8FUpoQn3vcKyeribSJfyV2zFxR9VZOGvCUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuTTD0LlBQ7GARiNhGnBKBw85FFhzUew15cFcWjVpk4=;
 b=HpOJ3tTZSqs982bSsOPer6Gw4+gNNeRfqo4Lt4P/FVk08KMLmm38B7iQLuNt2Gu1ZzWQ3M414rM9SmSFny6bU4HQ/hNlNYGkx95ToZsvYncbsMBWkXVvTy75upSAa8ua3umRz05bId0c1pzCXvXueZapA9Cw4BuBce+BYCzN7B0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 22:45:06 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 22:45:06 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Pritam Manohar Sutar <pritam.sutar@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rosa.pila@samsung.com" <rosa.pila@samsung.com>,
        "dev.tailor@samsung.com" <dev.tailor@samsung.com>,
        "faraz.ata@samsung.com" <faraz.ata@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "selvarasu.g@samsung.com" <selvarasu.g@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Allow usb role swich control from userspace
Thread-Topic: [PATCH] usb: dwc3: Allow usb role swich control from userspace
Thread-Index: AQHcQbS2+WVqc65QpEKzjMRfB01DBrTNK1uAgAJXnYCAANb4gA==
Date: Thu, 23 Oct 2025 22:45:06 +0000
Message-ID: <20251023224505.jipasxaokcfu3xyk@synopsys.com>
References:
 <CGME20251020112840epcas5p28d8eded5200f096e7b80f71899371f2c@epcas5p2.samsung.com>
 <20251020113723.553843-1-pritam.sutar@samsung.com>
 <20251021220935.5njyz5lyiwrsf3rw@synopsys.com>
 <058201dc4403$334b0f20$99e12d60$@samsung.com>
In-Reply-To: <058201dc4403$334b0f20$99e12d60$@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB5665:EE_
x-ms-office365-filtering-correlation-id: 249fd732-8a27-4526-1d18-08de1285d003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXRQaUEveGs2aFNyUU1LalVhek9OYXkvV1BSQU1XMDRtTUg3Q2t1Wm5uSWVS?=
 =?utf-8?B?UXZMc1YrakJBTVh0eFFQNi9KOXFsYlhmTXZJbndTT204bVhMODNJU0Q4YWRP?=
 =?utf-8?B?VFFLY21IVkc2TjVFZWFNS2lGMWFNU0pIbVoxb3EzRGJVTmoza1UzdGJDVnd5?=
 =?utf-8?B?VEV4eEtKMFJpTzF3UklocGJvQU1nYWcrYjFqWGp4eWRtaXA3OThmTTVqOFZl?=
 =?utf-8?B?RUsxMlhDRi9HMVNxeTVDWVZqVXVpZEVFbXhiUHhJQzAwRVRnMGpHTDFsU0N4?=
 =?utf-8?B?VXNHQi94QmVoQ2VHMkF4QkNaMkdQNkNqY0VWc0xERTFBV3NlanJQYWxkU09q?=
 =?utf-8?B?ZDk1WFJoR3FvZE5XN2lobmY3NG1jbU5jdHEvUU1Wd1FKdVZna2pBZVgvMUtG?=
 =?utf-8?B?WGdqNVVlVHZyT1ZzUjUvWHdqbkNPREMwL2NreUpEbGRvS1RReHdIQnJmZE5Q?=
 =?utf-8?B?blR4Q0VPL25JdS81d3RNL0dGL0ZmNXlvakxtcWhkcTlkR0VOS2lsdmh1Rkp4?=
 =?utf-8?B?ZGhONDBNUnp4alJVWTd4dmlHT1Vwd0tjRmJZbW9JRS9Qb2RXajJsZzIyNFlY?=
 =?utf-8?B?MVIzZzdIVEQvY01VUzA0SCtYTUpKK0lwZGtOTDdNYzZWYXluM2h0YUhMcU9Q?=
 =?utf-8?B?YTVGcXpjMlJzamQ4ZkIrVHNCSkdmNmd0ZWVNZ29EanI5Wmw1UGNqWUVFVi9N?=
 =?utf-8?B?S1VsR21Oa1ZHUGZTby9ndUZsdWRYSG80K29ZVzFUSGRMN0ZBbW9Fd05sSC9i?=
 =?utf-8?B?bnB3VGQzRnNjK1dydkQ2WHMrY24yMld1RnNUMWR5dGZySVc1Vm5jVWRoZGor?=
 =?utf-8?B?Zm95UWRhRzFWWHpKK1JNQmhBWGl5VUo5aE5xWDRSUlJpUWsyWXN2eTNtNVpC?=
 =?utf-8?B?ZkFoRExZYTFKaE8yWDlFUVdxZGUxTWZLbTNNVFFRSlBnQUl0U29vRUhVVmMw?=
 =?utf-8?B?MithNW1VOVl6WE9TdmZRcnVHVzJoZGJMRHZQSVBvTEtRU0NVK1RTMThPWkM2?=
 =?utf-8?B?Mk5HNi9jdnI3cmhIOFd5N3YzRFR5YlpBT05COWFmNXFKNTJxMUR0RkxhM3M3?=
 =?utf-8?B?WmNhUzBRcnpCMkt0YVVIV2hSQzRUeE1VNU4veXhZNG9SK0NYY1R5aXJYckRC?=
 =?utf-8?B?d2lJWGphT2dvUVhSdmd4N2l5cm9SbXJVSjlocVVxR3VuL0x3WjdRb0F3UFQ4?=
 =?utf-8?B?Y1JOOUhxOVFWakdRSzQ4TzByU0Q2aVlzV2ZIcDJrUFlwN1FORVdYSVhFV2Ju?=
 =?utf-8?B?cXc4dkN3L1l5QVVXbEx3aWtSQlBoRnV0MGpMQVRIWlJZYkxidGJTaGxpZHV5?=
 =?utf-8?B?c285MUVRM0lCT2FjTkRFWWVHRTdxK3JXRklwYU9ZU0VaMmY3VGljRGVVYUc3?=
 =?utf-8?B?elp5eEVTdFd2OG12cE0yNlBsWE9YUUN2OGJFMU1WZDdPT3ZLZ2tBNmNsNTdB?=
 =?utf-8?B?UkI5MzI1cm5VYTZoS2NXUFZGMWRGSEc4bnRIbkY5Sjl6SmJSVFZnY0VtZ01o?=
 =?utf-8?B?ay9ITnpIUk5UY1FMRFFvMzc0TVYvV0l3ZExURDJPeE9adzIrR3E2a0l1bUQ2?=
 =?utf-8?B?NG1jOXJsRVk4V1krNEVuUTZnWFNjYmU5eHFad2tLVUY2YzI2aEo4T2xPK0NZ?=
 =?utf-8?B?M1p5UVhzZTVWdFErTWduVWFLVkRtS3BYWUNNa21jdGt6NUdwNnc0KzkyS0dV?=
 =?utf-8?B?OVVYdzZjVUZpbEs0a1VXQVRaOEtmUEc2MEY4VklJNzNRTFZFZjRqQm1oQXZC?=
 =?utf-8?B?N3N4YTF1UDc3TlhPVnJMZWE1c2M5QXlHUy8xMFNoeTAxQ0F5ZDVhS0NUN09V?=
 =?utf-8?B?dGt5RlVqWlRmMlYwR1BxUStDcElCbnIvNlNVVUVleTBYR1diOXJxMzlkbTVM?=
 =?utf-8?B?N3p6VXJPZGdwV0pZYW84UUFhUmlyRnkvKzJJWGhNdVllTytrQ3E3cjk3cDdB?=
 =?utf-8?B?VzUwKytKL0hTRmdpb1o5VnBOcXNrWTU3THgrYUVYQzE1bWVxMjkwWkFJUVNK?=
 =?utf-8?B?ODR2SWY5NlRuRS9YYmJucTR5THRwbW50MG50UElidG1ITFlDbG5WZ0VvaE9J?=
 =?utf-8?Q?q3twkr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmdnVzdyaCtaYjJSQUVIRlVTbWhKbGZkZGtiZzJTb1k3R1h3UUoxbUpUbTFp?=
 =?utf-8?B?WXNGeU5TS0ROQnFwQnlVcDJPZUE4VUtFUFVYZ2YzazhNSUZ5alRraWVaMlpM?=
 =?utf-8?B?bXV3WWR6ZzFuZ1Avc3haWGJ3KzlZbkdVUHVBWUFJOWxlRU0xSlhPNDVnV0pw?=
 =?utf-8?B?S2hmL1RlSmY5bUpidmlkbHNvNEZaZmV5UUxNM2ZNLzRtaEczeGhYcGZQcUFn?=
 =?utf-8?B?VHV2ZENOSHcvQjJlVDV6S2VYYXZhU2F5TlVVWXZ0RzUyV3RGeFpXSnh1OFAv?=
 =?utf-8?B?VGg0U3g2MEJBUlAvWklEUjBOYU92dFpiZ2FmT05xMGxqcWYzenZkUkpTRmJ0?=
 =?utf-8?B?UzIyUWdBVlpKMnZmd0UzMll5NEY5dnEzei9yZ1BKWFZpaHhMT3lXaDB0a29X?=
 =?utf-8?B?d1FsRHhmM1lSdHV2NWVMZXpGbXNNcFdLSXViWVBCQVBCcE51a2ZYQkRoZHBp?=
 =?utf-8?B?VGZIR1doRG9IdURWQ25GcFc0ZTh2alBmTzhId1hLMnlwSENFRHdteVBYNWQ4?=
 =?utf-8?B?eE5OS2FHWFVFL05TdzFGQU55VWxReENiZlhMMFhjdmVrN2FtVmhveHhvcGQ3?=
 =?utf-8?B?K1BRVzU4TGVPL2F5aGt3c3I5NzRmeVJyTy9sNUQybTBncm0rejhxZUFvNDRC?=
 =?utf-8?B?cUJodzZqRllJUmJVMWhlcVJXaGFhMkZYWS9WVUI2VktyMDRkSFhrbFVOK2l4?=
 =?utf-8?B?OTR6WGZQUDJjSFRXc2xXVWFNZHZocEx5dkFNUjg5V0l0TDdIMG5jbVhCZzFr?=
 =?utf-8?B?V0M0MXJ6czJGeHhKQlVWcjZmUm8rVHYvOGV2ZWtNeTNSL3JSMERlejNnUjZ2?=
 =?utf-8?B?Q3JQWjJ3eFpUcjd0c29nYXF2QUNGWnhoNXhlS3pla3p0NDdwMVZzTDRlZGxZ?=
 =?utf-8?B?djcvN1VvckJ4SUhZZk1wQ1RMWU1iWUVoK3JFeUlkcG1aY0pWRkZZVnR0M2Mw?=
 =?utf-8?B?am1zWlFOVzByV1dPcVMvbEVna2RVdWdxc2xHSUZBK01tbjcvc3dqaFlLNTVU?=
 =?utf-8?B?TnVsWGZ3bU95cnlVVXBJYVlMbUxPWnY2MUErSWsvOUNnSmRIa21pcjlkQW1v?=
 =?utf-8?B?TVl4QlROd24vQzN1N2s3UmVUdTJxWWJ0QkkybG5Kb2FCTE94Z2xPSDFTVU5K?=
 =?utf-8?B?M3BFL09JR2VESTJ2U2ZReTc5UDcrZGt0aEdBcnJML28ySVlNUUlHZ2JHQk50?=
 =?utf-8?B?YXBZNXRBcWJ1NGVRY2RCaUJZdWsvTTdhTVF4c1h1anI3eUpkNzZlbGx6Z2RN?=
 =?utf-8?B?eFF0dXZYMTFLTEZ0YkovSjRLN1JTZ2R2bmxTcGNoNks2OW5aZXVIU0FRSTZw?=
 =?utf-8?B?ZERqaVI1L2I4eEVwSm1nbVI5OHVUR2lvT2o0UlZFSUZ5OGdPTnBid1VDY1B4?=
 =?utf-8?B?UTYxVGtINGRUdFV3K0xCWmhqanJDUGpkaW9MVG9WSUxnSmhiUlNhRmRkaUxp?=
 =?utf-8?B?RGdRNTJHeFpkY01nbzZiUEZIVzJDNWhyNFZRR2kyZFFMYklUOUw4cCtzbUFa?=
 =?utf-8?B?QUZJSzVTUGdpNGM5OVdSLzZudllyYmVhb3dyZkNjb0ZXcDFNNE1paXUxZmNC?=
 =?utf-8?B?eXE5Z3JIcVpldmI3S2ZmVTdCeUM5ZUlNRmFXMUMzcjVrZXJXbERmeXltL3FS?=
 =?utf-8?B?OWQrb1NkV2crd3hLVlVjallCTHE4SmlQRkxra2Q1ZHBEc21wS2NZWjZKUzF4?=
 =?utf-8?B?cThYbzJGRXhVdmZQTXRCUzU5aysrVWFlTXpMTERWNW4xZEdXcktZaDNBeEw3?=
 =?utf-8?B?Nm5pbDNkZDIxbG1pV0Y5aGhzREpkQU5ZNWQrTXV3d3ppTVRreHZSejlWL290?=
 =?utf-8?B?QysyN3phQUNqLzN0bUFnRW8vaTV6THltaUxPazc2MFhvNXRkYTc2WFdVbDJC?=
 =?utf-8?B?V1ZTQ0xKdE8ra0NxVUJnbkUwdlBBdmIrc285cnRRNEdJQmpXTmJPcU02SU42?=
 =?utf-8?B?MHhpalRMUHpDRTNrNHVRSThvMjc2ODg0S044SXR6MU1Td3BRemw0M2plZFdE?=
 =?utf-8?B?TFBYTjFsYmRFNElkOWVmZzBqMTltTFBhZEo1cWZwZlV1SUNmam5KS2MvUzVV?=
 =?utf-8?B?ZzNxRHFWbDJka2ZnQjJEdmp6SnRsUVV5eWhBSTI0eklnTklUVlR6T2sxOWl6?=
 =?utf-8?Q?ovHjNY5WZB3uUgvf21cMpYq5o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C4A817FB9724B49A6CD930B7F48E4AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vt8H/cVabCVO8Ag+qKVVd+cA8wGSPMyjrcTz4Gtdngy5S3fLNoUlGevUYbiQcMjboLqvy0OH4Vjm/v80s6oJF3hLnaXuioOlYdSt3kN+Gt06IQ9Bb4ejDkzisI5IWD2Qo05W9IXoQtMRqf1mpQi3+26STlshcVhrT+LtUp9xea8ELmDMKlVnl83Qn3LmHRlbVrMEuBJV4zMojtr4ntNSYWXjnSg1oyuxSKmE+khvZfWNEnVOBTHJhZ2LXH+sDv7cgILmvqoEVY8evqzusk9GXSEmPH7aF55kQ4bTR40C2awbBV2fD1mWffJv/q9ZyuHwtqd9biNJb5fPt1dKwMQ8a3IHqidyWgyI9/mA3QnB7he1q58RVm+zXzW7lR6qWj4TOT8teEkAk8eHmFLj6YdPrloRLCVTuqBb7n5CbnaL236taIBUpn0/SM2yfn0xeKHRZkgsoPdIwiumjCw6XWoNfDWvVGdJ8oWkiPFysMS2ROx62TpAP3ZYjAWDrCpAN++GqOAEKs6u6sBlfCnVHqg9MjkaCOyPEuCuLwXE07rJlgoYLRcq0KFdCqs9loJCf6GRuqETDOtuqel8/qdoFFVKLQg51csZyFwaZnYmIazYkqPb+tVIeWb2XCZouRakRM9vmAsUx2G8iA7znjc0z5KEcg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249fd732-8a27-4526-1d18-08de1285d003
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 22:45:06.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFJn2lBkmO0jBc8CQuXiLILk+AJrqN3OpzSNE3cT943rqJQUJMySWlSZoZkajY0pIwWqEgqQmlZG0CNYJ9TAcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDA3NyBTYWx0ZWRfX6dGoBRSexsdH
 58dylbVppvANUotfiIn6bzUHJp6V35ErYjblGOgqtzzaRvZ2e1GxhcMmtjkY3GGeIrfegVMr8Uq
 7F1EuiSaFgd0YteOkZq968zm038t46QFN06l1J+T4lG9CkJqqTi1VZQx9tg40PdcF7FUU0qC7YL
 NY7+Gq3ImcrKVoN1Ewfq4p0C1LVO9WDKlv6ofEaMQ5GM50zUxeAVCNNDDlTtfKWWmRq+/bKQ3n5
 SXAogLf0ZgDwBIiDVCsh9JYhkmSmgY78NfWjTAsQdmIPqOJGtqDw8hxpqXCSnr2rUU5bI0vsDiE
 hE0n6SK7MyT0bddb3JTe3X1zy7+2IlnDdgjrjxezmCLMl8uJYWpmOOQi3vMgqS/T0UY9afTrps9
 pO2yrP2+lbMm+yPeOA0cTz+5kMJ1fQ==
X-Proofpoint-ORIG-GUID: OYvWYn7iESpMF3fxGPLFgbGNDw0UIA-b
X-Proofpoint-GUID: OYvWYn7iESpMF3fxGPLFgbGNDw0UIA-b
X-Authority-Analysis: v=2.4 cv=A4ph/qWG c=1 sm=1 tr=0 ts=68faaffc cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jIQo8A4GAAAA:8 a=hD80L64hAAAA:8 a=ag1SF4gXAAAA:8
 a=VwQbUJbxAAAA:8 a=m5FI0OlkO_12KoyvZ1UA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2510020000 definitions=main-2510180077

T24gVGh1LCBPY3QgMjMsIDIwMjUsIFByaXRhbSBNYW5vaGFyIFN1dGFyIHdyb3RlOg0KPiBIaSBU
aGluaCwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBUaGlu
aCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+ID4gU2VudDogMjIgT2N0b2Jl
ciAyMDI1IDAzOjQwIEFNDQo+ID4gVG86IFByaXRhbSBNYW5vaGFyIFN1dGFyIDxwcml0YW0uc3V0
YXJAc2Ftc3VuZy5jb20+DQo+ID4gQ2M6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9w
c3lzLmNvbT47DQo+ID4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LXVzYkB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJvc2EucGls
YUBzYW1zdW5nLmNvbTsgZGV2LnRhaWxvckBzYW1zdW5nLmNvbTsNCj4gPiBmYXJhei5hdGFAc2Ft
c3VuZy5jb207IG11aGFtbWVkLmFsaUBzYW1zdW5nLmNvbTsNCj4gPiBzZWx2YXJhc3UuZ0BzYW1z
dW5nLmNvbQ0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMzogQWxsb3cgdXNiIHJv
bGUgc3dpY2ggY29udHJvbCBmcm9tIHVzZXJzcGFjZQ0KPiA+IA0KPiA+IE9uIE1vbiwgT2N0IDIw
LCAyMDI1LCBQcml0YW0gTWFub2hhciBTdXRhciB3cm90ZToNCj4gPiA+IFRoZXJlIGlzIGEgcG9z
c2liaWxpdHkgb2YgdXNlciBuZWVkcyBmb3IgVVNCIG1vZGUgc3dpdGNoaW5nIG9uIGJvYXJkcw0K
PiA+ID4gdGhhdCBsYWNrIGV4dGVybmFsIGhhcmR3YXJlIHN1cHBvcnQgZm9yIGR5bmFtaWMgaG9z
dC9kZXZpY2Ugcm9sZQ0KPiA+ID4gZGV0ZWN0aW9uLg0KPiA+IA0KPiA+IEl0J3MgZmluZSB0byBl
bmFibGUgdGhpcy4gQnV0IGJhc2Ugb24gdGhpcyBjaGFuZ2UgbG9nLCBpdCBzb3VuZHMgbGlrZSB0
aGVyZSdzIG5vIHVzZQ0KPiA+IGNhc2UgYXQgdGhlIG1vbWVudD8gSWYgdGhlcmUgaXMgb25lLCBl
dmVuIGlmIGl0J3Mgb25seSBmb3IgZGVidWdnaW5nIHB1cnBvc2UsDQo+ID4gcGxlYXNlIG5vdGUg
aXQgc28uIEknbSBoZXNpdGFudCB0byBhY2NlcHQgY2hhbmdlcyBiYXNlIG9uIHVzZSBjYXNlIHNw
ZWN1bGF0aW9uDQo+ID4gb25seS4NCj4gPiANCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb21t
ZW50cy4gDQo+IA0KPiBZZXMsIGEgdXNlIGNhc2UgZXhpc3RzLCBlc3BlY2lhbGx5IGluIGF1dG9t
b3RpdmUsIHdoZXJlIHRoaXMgZmVhdHVyZQ0KPiBpcyBuZWVkZWQgdG8gYWxsb3cgdXNlci1zcGFj
ZSBhcHBsaWNhdGlvbnMgdG8gc3dpdGNoIG1vZGVzIA0KPiAoaG9zdCB0byBkZXZpY2Ugb3Igdmlj
ZS12ZXJzYSkgYXQgcnVudGltZSBkdXJpbmcgQ2FyUGxheSBvciBBbmRyb2lkDQo+IEF1dG8gb3Bl
cmF0aW9ucy4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGNvbmZpcm0gdXBkYXRlZCBjb21taXQgbWVz
c2FnZSB3aXRoIHVzZWNhc2UgYWRkZWQgYXMgYmVsb3c/IA0KPiANCj4gIg0KPiB1c2I6IGR3YzM6
IEFsbG93IHVzYiByb2xlIHN3aWNoIGNvbnRyb2wgZnJvbSB1c2Vyc3BhY2UNCj4gDQo+IFRoZXJl
IGlzIGEgcG9zc2liaWxpdHkgb2YgdXNlciBuZWVkcyBmb3IgVVNCIG1vZGUgc3dpdGNoaW5nIG9u
IGJvYXJkcw0KPiB0aGF0IGxhY2sgZXh0ZXJuYWwgaGFyZHdhcmUgc3VwcG9ydCBmb3IgZHluYW1p
YyBob3N0L2RldmljZSByb2xlDQo+IGRldGVjdGlvbi4gVGhpcyBpcyBwYXJ0aWN1bGFybHkgcmVs
ZXZhbnQgaW4gYXV0b21vdGl2ZSBhcHBsaWNhdGlvbnMgDQo+IHdoZXJlIHVzZXJzcGFjZSBhcHBs
aWNhdGlvbnMgbmVlZCB0byBzd2l0Y2ggVVNCIHJvbGVzIChob3N0IHRvIGRldmljZSkNCj4gYXQg
cnVudGltZSBmb3IgQ2FyUGxheS9BbmRyb2lkIEF1dG8gaW50ZWdyYXRpb24uDQo+IA0KPiBBZGQg
YW4gYGFsbG93X3VzZXJzcGFjZV9jb250cm9sYCBmbGFnIHRvIGhhbmRsZSBzdWNoIGNhc2VzLiBX
aGVuDQo+IGVuYWJsZWQsIGl0IGV4cG9zZXMgYSBzeXNmcyBhdHRyaWJ1dGUgdGhhdCBhbGxvd3Mg
dXNlcnNwYWNlIHRvIHN3aXRjaA0KPiB0aGUgVVNCIHJvbGUgbWFudWFsbHkgYmV0d2VlbiBob3N0
IGFuZCBkZXZpY2UuIFRoaXMgcHJvdmlkZXMgZmxleGliaWxpdHkNCj4gZm9yIHBsYXRmb3JtcyB0
aGF0IGNhbm5vdCByZWx5IG9uIGhhcmR3YXJlLWJhc2VkIG1vZGUgZGV0ZWN0aW9uLg0KPiANCj4g
VGhlIHJvbGUgc3dpdGNoIGNhbiBiZSBkb25lIGFzIGJlbG93DQo+IGVjaG8gaG9zdCA+IC9zeXMv
Y2xhc3MvdXNiX3JvbGUvPEFERFI+LnVzYi1yb2xlLXN3aXRjaC9yb2xlDQo+IGVjaG8gZGV2aWNl
ID4gL3N5cy9jbGFzcy91c2Jfcm9sZS88QUREUj4udXNiLXJvbGUtc3dpdGNoL3JvbGUNCj4gIg0K
PiANCg0KWWVzLCBjYW4geW91IHVwZGF0ZSB0aGUgcGF0Y2ggd2l0aCB0aGlzIG5ldyBpbmZvPyBU
aGFuayB5b3UuDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5
cy5jb20+DQoNCkJSLA0KVGhpbmg=

