Return-Path: <linux-kernel+bounces-757107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A950B1BDCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725F418A7620
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE4D184E;
	Wed,  6 Aug 2025 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GOqCu5ii";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AKfy66CV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EpBRpv9V"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826CD2A1BF;
	Wed,  6 Aug 2025 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439511; cv=fail; b=SqXyh+WbEMEaX7QcaWpATmag9M+sKdmDaH7rfL22O8Ny8eACL/xDb0c2+48w/3miIIVjUSgH0RXHYEmNoyPz/6cYt4eLxhIKlbVbeUWnASeoVnd1Si89gM1mxDFASm+SQGjyko54pyxoQP0hBlrUnYPWZ30dpi1dJ0d/M3NQ550=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439511; c=relaxed/simple;
	bh=Uv39A5PwaXtHQX2R3FoT4NAbZFIOaTcfLrCxKwbzHGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UzrnY1pIqdGziNUy7casNXXU2vSTLm7Jk6BqjRZX36lsXUEGyJ0rPW3Ulzz434zNCINJvCRg/v5BxTQQbQA/6FKeRm5jxUpCeVvWQNz4h1kc8pJuc2nh2z6qyXlmZT+Qfvbi7oGomA1fQ23SsuMXZe7PHMJbfsrABOf+GxCq5m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=unknown smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GOqCu5ii; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AKfy66CV; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EpBRpv9V reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IAmVm001041;
	Tue, 5 Aug 2025 17:17:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Uv39A5PwaXtHQX2R3FoT4NAbZFIOaTcfLrCxKwbzHGs=; b=
	GOqCu5iimkL9ofAOxUXaMeTRN5iS1XVqI2fSGY42pVhjFnOpVJ5WFBjLb5CSR6Qa
	IEOLIbnHK7yaHGjKUMQ5JTJz0CLGEZ2kaEmhFD8tjkuEu2SK34gFCltgep45FiNE
	57fl4rHInuxTENQQLn+sAPqKjVCthB7kAO8laYM73UXCeZlW0NGmHZTxrKlqh07f
	R1fDtXuBBwtwFF81NRtXmPgd5b9lmyJg7Y5rYCWB27CRMiE2io96qCAm+92x2IgJ
	Uv3T3L0vPeZq7Dc+s1rssOlx7OG6tomdfL5z99o/Egh9Ku0Wapn9vy7KCZYs5E9L
	UEmzeWIHTLV7uRaXDfsSZg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48bq0r9m8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754439478; bh=Uv39A5PwaXtHQX2R3FoT4NAbZFIOaTcfLrCxKwbzHGs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AKfy66CVtaPkDXPGkkQ4Pjd+qgrOgW6IDqf1DeeHAUSdG2QTFBIokMj5h0j77tapx
	 jcJE2+VMYGeyTwbC7caQomZwyZDvtLKIaiehcozbXxeJEkTiqqEYC9kLBrs9Hy3OQo
	 YxHBRw+dy8vTTgdI49zmA29OjoumBMNQSdIV5xi3RWzvIYyoz9owWsbyM8bsRp7hOV
	 Lt9YoQZOJaWw9CkCunI9CQ6fJL0uBI6DI48vnYKmjaXqu1jX02+X7Z2BFhosioYk9l
	 /TqEpK4REYYPju5njX/djPs79fhPugs1aWwJf3tEl+jNAaf1YtWhFW8BbSL9o9bepr
	 Hgx1uditq3bVQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6B0914013B;
	Wed,  6 Aug 2025 00:17:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 00014A0072;
	Wed,  6 Aug 2025 00:17:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EpBRpv9V;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B375540585;
	Wed,  6 Aug 2025 00:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1eAW2wpJisRRm0BuBXVToyXy4b5k/IpJGekGhEqAlODOyasNzBSmHZI4quxxteCiMZJ/CUOZDzoAtcEmoHEh5trhccLPCz63vXHn2tRwQg8YZAaGmTShSFSecuMFKV3a/EhD3UgT5SAlnyHL7Fr/4nEgtRz20k34c6z/tbK5k1yctgnGCMwugdfmrbo44Mwbxe3AzZBNcp/pO7VhZzk27SZEJHqmdWfSwdSsxMSprZ43zugvGSb+Uk7bkh5la8qPmQOgV0XEr4dv1EXR/xm6CZJ9Az+BdfaIOJ8x6JEtWXeEIFAcGcEA+zKE6OLMu6IWZ6adNPStHxueUXKtToB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv39A5PwaXtHQX2R3FoT4NAbZFIOaTcfLrCxKwbzHGs=;
 b=oe02a8DDKHE0h8BjF6jJb63khr6fwLzvX2GU3GRiJ8Ke8y5EmTpJmT5g1sosxzQH6o1NndEmjOS4w+B53VNUZyHh3w9L/OAeY3JnQQ6JAkNEaMO0IsJjkqChxBFp7xVdecL7tadJy8XDFyHCQxOH+UHhkdKCyifiMR2Ie9DPsAr0fozoHB9+o2jmAm5h8A6gCCvXsaxG64S6J28mmtPtiikv58Sg6v8YyvO6wefv+MTp/QaO05YPfpPty4NVPvF6o+mna+q/2o1D475CLaGbwKT7U1a2VnRlnEDymIiFmY7GBb8RKl+xHy2KIoDyM1Wr5nuGjkr2zXqgDeI3Vas3XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv39A5PwaXtHQX2R3FoT4NAbZFIOaTcfLrCxKwbzHGs=;
 b=EpBRpv9VIc6dzMKiVuGEaci4/kiHlVNFUr6khJzSG6npuQEi7s/wtft8HlXIJcztQDV35NOY9CjC8uDXGxtgh0QjjqXPGhCBSnEWFPzYHAqh75XERMFY7nnz/McXgmctRY8wz3dWGCAMMHwIm8orl1ECfCqVzz17/u5aXrX+Hgc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 00:17:55 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 00:17:54 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "zhangsenchuan@eswincomputing.com" <zhangsenchuan@eswincomputing.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "ningyu@eswincomputing.com" <ningyu@eswincomputing.com>,
        "linmin@eswincomputing.com" <linmin@eswincomputing.com>,
        "yangwei1@eswincomputing.com" <yangwei1@eswincomputing.com>,
        "pinkesh.vaghela@einfochips.com" <pinkesh.vaghela@einfochips.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Topic: [PATCH v2 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Index: AQHcASV2RgwngLpRTUScNYz0bqUs4LRUzM6A
Date: Wed, 6 Aug 2025 00:17:54 +0000
Message-ID: <20250806001753.falbvomvce3sxgym@synopsys.com>
References: <20250730073953.1623-1-zhangsenchuan@eswincomputing.com>
 <20250730074156.1600-1-zhangsenchuan@eswincomputing.com>
In-Reply-To: <20250730074156.1600-1-zhangsenchuan@eswincomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB6360:EE_
x-ms-office365-filtering-correlation-id: a10c69a2-8b84-4e07-0d22-08ddd47eb06d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUczekdYMkpWZS8rcldGQTJMVDM5MDZ5MUNPdHJJNDhnZm03R29nRVVGYjYz?=
 =?utf-8?B?TndBSDFhOFk4dWs3Y2h4WjNxMzZCMUFSeDZMdlFYZUFoZVhMTmNMbG5ncVZH?=
 =?utf-8?B?MG9VbGlHVVF3N3A4eC9LOWJsUUxlWVRxU2RBeHVBYjRTbzFBMHRHSkVGR3pj?=
 =?utf-8?B?a0pNS3dobUhFS3FabUF2dHlIRjJ2ZG5vNUhKMHZ3a1RNanE4bWhmRzBKeWgr?=
 =?utf-8?B?NGt2cVp6RkFGSElQL3krZ0M2U0gwdkg0T0M5OHU4WU15U2haV0RmaWduUFM1?=
 =?utf-8?B?MW5CSGQ4R0tWRWdNaDV3UjBhTVl1bE5FdXA5cm90YzQ5RlV2c1dqWnlvZWZL?=
 =?utf-8?B?R3NIMi90U2JIdWFmalluRlBTVEtGSmhDL216SVZWZEFrZDNNSnN5bHp6NDdw?=
 =?utf-8?B?THorWFdya2NkUzN1T1RkWjFhR244NFhBb2dGV3RUMHVQNGVKL1JHRUpyMkVT?=
 =?utf-8?B?VElMZm5PRWpUZjdRVitWMGZRbjNVc3VlT1dFcDJIQU5IVFBOTndYY0hzSmRy?=
 =?utf-8?B?VGE4VklqaWdYRFNyWkZVVHNHZEd5N3pDR003cDVUOFN6RVBkdDhLKzhoVmFO?=
 =?utf-8?B?Uy9CT2JvSWhOZmlPdVFTL1FabzZLZ0Q0QXZqT1FZbGlKMXJtYlZXV3p3ZnFE?=
 =?utf-8?B?QTIwMEp4Rzh2bExnaDE4OS9HY0hSaGdKN2RYQnQzUFRIMlZka3c4d1ZQeVBl?=
 =?utf-8?B?VVEwWENuWDJUbW1DaHFKV1ZCblpZUUFQdVlHakxiNk1MVHd3ZGVHRnVQbktw?=
 =?utf-8?B?VjN0ODJFNURlYUhOdFVjSlZDRUx2VWNwQ1RnVDJTNjBhMFEwTys3YnFISEtQ?=
 =?utf-8?B?MXJURnY1ZTcrUEtybW9sMDJGWFlycW5zUVVhQ1grWmZzR0ZpT2dpcTlXWDAv?=
 =?utf-8?B?RjhIOFJNdStzKzd6SjE4dTJocVpQOWU0U3dwL25pMnJkdXl3MHo3M0dlaExR?=
 =?utf-8?B?K1lpQzhveWxTZDNIQmlhVWJJZ0hWajhmdjdoa09hSlRtT29hRFFhTDdJOVRC?=
 =?utf-8?B?UmFmVnNobkNEMEVMTTM1RFJOd1Z5MmFTR1VLVXBwWXc0ZHZEQnJDYm1Kc3d3?=
 =?utf-8?B?cEdpTExwNlFBWnhFQ0NBem9YZVJObE05VS91L2NyejNmemtyOUtVcTFLbWlO?=
 =?utf-8?B?Vkl1V2F0dThsZEVoRlRYMmU0VjB3WGxRbkl1QVhCZmdycDBZdGdmQUtZaThl?=
 =?utf-8?B?U2lIUDVZT1puS3BxZHFPcS9WNUVXeWtTd1BtUU83cUYyeUtkcEFFL090WHdM?=
 =?utf-8?B?SGJoZkhvR2QyYlgyZC9CdnlQTHFIRW1qdXdRdnlKV2dCbm54YVJxbnhoSndY?=
 =?utf-8?B?TUM3aGc0YmhEeVFZaVNjVGc4cE5YeE1LY2xwMEJBQWF3RlhHZW85eDVsbitU?=
 =?utf-8?B?a1FwUkJ6UUg0T3pjS1g5N1F1U3RkN014QUpSeDNZS09YcXFTNXU1Z1dzZDRo?=
 =?utf-8?B?dHcvQ3ZZVU12L25mN3FQcjBhYWJlejJkVUtpODNtNlJPRzRWRkk5TmFReHRl?=
 =?utf-8?B?aTJmTVhpdWNzVmdkaVQvMnd0NCtYVkhXamtUb2xiQ3hkaWIvM2w3U1A0Sm9P?=
 =?utf-8?B?MzhPeENhSVZzL3p0ck93eDdlRHA1MW8waUtuRXlmQitYcjlmY1cxRmhUdGQw?=
 =?utf-8?B?aUVmZXBlS0FyUXJwb1VnM3NMNHU0SDNGUmE4OVY5WEtkVG9VMUN4TmxuLzlQ?=
 =?utf-8?B?MXpyZGk5QlBHSnJiQzYzRlMybVpLdWovU1FOZ242N0FRcUZsKzBRNTlPSUhh?=
 =?utf-8?B?MmJ5VHJsRENxWmlPNk92K3laUDRlL0ZjVlNjUnFBdW1rV2pkM3hYN2VmV0Y3?=
 =?utf-8?B?VkRCQlZjWFcydEpMWEdFejhMb055TkJGUkN1T2o4bjFLYXZtNFhlci8yc3dy?=
 =?utf-8?B?WlZHc2xQaXhTK0UwclZ4TnM4VU9pVGZZeVZ5Y21aZjZXZzYwek9QRFI0YTZT?=
 =?utf-8?B?WnJLVXJBb1ZwaS90cU1KNXpDK001cDFzQnNLd0ZoQ1ZVY0dwY1hLM3ZHODE2?=
 =?utf-8?Q?dW9YJ3BmUYe0Ew1E6/R/DErUgdNwnc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1B1elNERE9GdUVBNktESXBhbXluREUyZWZIZ2gwY3JHd0orbXJUMXpzemg1?=
 =?utf-8?B?SWNBK2hxZG9vZEM0QkF0ZURIYWR3V09DZ1FUVGUrNE55OEhiaUxWSDk1NUZv?=
 =?utf-8?B?b09nL2psTWRuZ0xtZlc2MmRUWjhnenIvRzQrM015dERLdFpCc0wzOUNjM0Rm?=
 =?utf-8?B?a2JEdVV5NllPa1pqYno3Z0YzbXhhY0g5TWtibFFvZkkzZ2JsSmEzSnZ1TTlq?=
 =?utf-8?B?TXJGTW0rVWpYZ3F3a2VSMzRldDhGZUxEeVZJaHlWcXVrem9xeDduQUFUOWk4?=
 =?utf-8?B?VDYxY0ZoRVNrb1ZpRDJiVmRFTzE5dzNNT2J0WU5WU3krVTZ6cm9oUVJYYlRV?=
 =?utf-8?B?bThNblZzcmhPNWM4WWkrOUFCSFhIbkQrclQ4Rk1FdGxFekZxKzhJMFRtdXF6?=
 =?utf-8?B?Zk5oVEtBaENuN3VPMmFJOFBtTndkZGU4MzdkamVPcEx4cW5LYmtPMHRRclFN?=
 =?utf-8?B?dVlSMjVGdzRNc2twR1FvM0lqRy8rVy9rUVAzMkpZTEZvNjJRcXNtNG5kRUNx?=
 =?utf-8?B?bzM4NkZlTk1rTStxVVpQTXhqeFVjQ2FHWVZGOGtBQXRFSys4NUE2L0RCd2Yy?=
 =?utf-8?B?aUtxT21kNFI0di9UU254NitxRGdadHJMKzZyd2x1QndhQi9NZWRuVW9QYWQw?=
 =?utf-8?B?QklVeE05OGM4YnhTUVFiSlhhRlFLUjNaNFpJaFFaSnBHRzJaSDZXMkdJdXJj?=
 =?utf-8?B?WUFtRktwaTJHWFRRKzI4VkprYk9WL25rcFVja0p5SU0xdmdFRyt3anN2T0Zm?=
 =?utf-8?B?WXVRZ00yY3lueEJGTm5FWnFSZm44dHY1cXd2QXl5eHV6Tk5UbmdoUmFNNDgy?=
 =?utf-8?B?MzRIdWh0NkxNcFhpM1djQWRTalEvV3U0NkVlUkY3L0V5RGpqR0VmZFMzSGFq?=
 =?utf-8?B?dmo3TWRJWk9yNVJ5L0JvWFhkSTNZTVVueldFK1hqUS9TZ0Y3TzNkMDRvUCtC?=
 =?utf-8?B?djlmRW1EcVYyenNoWmdENnJzNEVYN05Rb2d6d1VWa0Y3VFdpTmtiQ0NOdkJp?=
 =?utf-8?B?WmlYbkNsR2dOd1pKaENQVGc0NkVSaGhpekw5WGtKYitDRzBHVzg0czgwK08w?=
 =?utf-8?B?RDg2bWlVWjVYai9tcDliQ05IU0RXSkRZTHF5Y2lFSWRZNzUrN1Q4aVFpUGI2?=
 =?utf-8?B?ajBVN0gvc1FXYjhObnlFNWgxVCszSzJzV3hrWExjV2NsRXFQNlB5OXhscytZ?=
 =?utf-8?B?OHQ4MzlmVkZQSG5WTThGcW5BQUFqSGs4VlJhMXdZRWxSQ1U5MVdES1BOTFp2?=
 =?utf-8?B?M0F4U1ZBeUNOSWhQMkVNaFVsSTVvaWRPS3hjOXpJcVFSa1h3Uit6elB2Szl1?=
 =?utf-8?B?emFVOVBIM1JqaWZLQ2xTMHlxYmRkRHNlM1dlTlQ1ZWtIN3FQQjVlSTcra21W?=
 =?utf-8?B?akxxMDVTd2pCWmo2K016NWxmZmw2aUxPSUhFaHJuYlM2YVdZKzhBUHRqdmUz?=
 =?utf-8?B?eWV2a25lZUpHSjlTclVJek94bVR1ZnR2eUI0OGNIcUp5d3dyQ09UdDg1QVNy?=
 =?utf-8?B?MVdzNlRoUWlZeDlQd2lqRFM4T01IcTB5a2ZJTHZoMThiOE8vcWJsTGVHNlQ2?=
 =?utf-8?B?VGZCMFZ6dEs1ZmNreWVkUXJHUmxXUTJBZU9CRXhGRzV0SEVORVVoMDV4ZzJF?=
 =?utf-8?B?OU9SUnVHeElzaTZDdCtnbkhROGpib1U4VXMvdisvSDFxQ3FOczFmT3hVVlJJ?=
 =?utf-8?B?WWR0Znl1M082NEUxOVN3Um45a1VIMXFjVGVuOWVPUEo5dTg1VWh6UWJseG1j?=
 =?utf-8?B?MHJIa3N2WTczY0FhUUxEdjZUeFpnc0srbGp2aCtZcDB5a2Z5d1lxRUZrRWxS?=
 =?utf-8?B?c1pJandwQWVYSmJWVmczeXpjaW5ZWU5TSGdRUTJ1QzZlNkJvRFptc01CK1dQ?=
 =?utf-8?B?b1lDSGxCMGJWcmY2R0lRODhiTVUwMkVFMTZpSmNUd3kyVjFoeEplaWdQRFhn?=
 =?utf-8?B?ZnBDd2tvRTA5ZTRaT1NBaGo5VG9ta0FXZHZaRHVRYS9KR2hJU1JFSnZwaElH?=
 =?utf-8?B?azN6RElSSHh5a05RSzNKK1lqbWg4d3R2ZWlDR2diMEhvUSs3RFVic2tDbUtT?=
 =?utf-8?B?akUvaEFQMG4xeHRBdTRkQmJxQllnZzhvYjFieWJuV0h5ZzMwSTYxb0JNb2ds?=
 =?utf-8?Q?02S/WK7uql4c+cFfQxwcDJt+K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <013B1A49525C34498542EFD08DAB3245@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FeGsoO/IVAz9x4ThynU1LVfJQHbmW3wOgSlLSTLtVFBWtitC1NEgn1MWPPcCD/3sfkO3nfG59spT641WB0GvoSf3/JtDNH3SoraxWXErJQxhP30ZoZ7m7WytJL+JyaQJbtMESnOZ/U2+yOERb8U+b+ao1uG8W2ZFWZB3bOlITnyxZvkFkjxlMpkPnsJbDY0hyg4Ux7mw8qTXWFkxJLW92gYcJrqLtKpZfqSpZgnisXwXP/btNNZYSWeOfF+d3a8ERrOdq3xZRhY0iuTMOflcwTpD+h/xfoeopAvvdMai2sqHsTu5u/E5VuIHfirT5qALXg/O0x4e7hGMQTVuzyfsydZen2c3UT+99KpIotg2W5aHdGwaOkCN+JTWTe1pC0SS9LKORovvmPFvx++0o4y6EWjcEPJsogbQU5D1z0Iows00JgqC7YJXb1xRosUNwUkX8xqVokZbKEOLurS7BLGxXHkxR9/YDq4TwnYqR1aQldI0GjI+acUkwFCABvaaH3+hTziFQnxi499L8XWLjTmk+3LbJ0ErSzqKcH/SGPhdbYF1jjmx3vYTjgDHZE8jf47AiqWu3f97CjtOiuVc66WiMiubDvWWLa81Wqe/BX+F2wX3cavNbhsh8V9/GnUmKSSRotR/Fwj2YskT5v+SvaNabA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10c69a2-8b84-4e07-0d22-08ddd47eb06d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 00:17:54.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyjomYVZ2XW1E4Qx8RWdqnpVGtIvEkcMh2mq2BYUt0Uzooy9/79hQK1wfr781+W8LD5/ueKJMEH9D/o6S5/A5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
X-Proofpoint-GUID: 7fOLERmTbkq5BvKNRxVowfR-Q2hs0NY0
X-Proofpoint-ORIG-GUID: 7fOLERmTbkq5BvKNRxVowfR-Q2hs0NY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfX8o35v9FAqNEt
 pPKUmpcQf2hwhBX/4gGR6miqCy/YMOucQAlgc8hDKhlZSvnfWxJjeTafgPhVOJwdGYykqQqZM3e
 Shw35oGcI59MoucQ03Q34b0j8VZqduGdNcKIpSMZZ2CzJtirEI3bG5tyllJwfrhK7f0isoIa8Ly
 7IC/GIJGT13t7rtGci2C5mYoAqJt2yMpIs/JStBV2V1GXBp4Vf+0KTtIwcCnkia2SWZiy/rccYn
 OqHYYygSek/pj4sk9ZhG/omwKyrYJD3TysIrn6bSt8lk10mHlrwXzVnOAHFBbkmEfBubUD/8nBn
 yblXgSJhC4NbrqtTgLjhXheBoq3yw9/J4yM5yHSL86GjkrQH03u1MvgbvipzHYy1nmilPjemVm+
 vikflTqO
X-Authority-Analysis: v=2.4 cv=H+nbw/Yi c=1 sm=1 tr=0 ts=68929f37 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=h4SL0BZ7AAAA:8 a=TYg1ubyUJ5liu25NV6IA:9 a=QEXdDO2ut3YA:10
 a=Cfupvnr7wbb3QRzVG_cV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050127

T24gV2VkLCBKdWwgMzAsIDIwMjUsIHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tIHdy
b3RlOg0KPiBGcm9tOiBTZW5jaHVhbiBaaGFuZyA8emhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGlu
Zy5jb20+DQo+IA0KPiBBZGQgdGhlIGVpYzc3MDAgdXNiIGRyaXZlciwgd2hpY2ggaXMgcmVzcG9u
c2libGUgZm9yDQo+IGlkZW50aWZ5aW5nLGNvbmZpZ3VyaW5nIGFuZCBjb25uZWN0aW5nIHVzYiBk
ZXZpY2VzLg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBXZWkgWWFuZyA8eWFuZ3dlaTFAZXN3aW5j
b21wdXRpbmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBXZWkgWWFuZyA8eWFuZ3dlaTFAZXN3aW5j
b21wdXRpbmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTZW5jaHVhbiBaaGFuZyA8emhhbmdzZW5j
aHVhbkBlc3dpbmNvbXB1dGluZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9LY29u
ZmlnICAgICAgICB8ICAxMSArKw0KPiAgZHJpdmVycy91c2IvZHdjMy9NYWtlZmlsZSAgICAgICB8
ICAgMSArDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtZWljNzcwMC5jIHwgMjA3ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIxOSBpbnNlcnRp
b25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvZHdjMy9kd2MzLWVpYzc3
MDAuYw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvS2NvbmZpZyBiL2RyaXZl
cnMvdXNiL2R3YzMvS2NvbmZpZw0KPiBpbmRleCAzMTBkMTgyZTEwYjUuLjE5NjU3Y2ZiNWQwOCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvS2NvbmZpZw0KPiBAQCAtMTg5LDQgKzE4OSwxNSBAQCBjb25maWcgVVNCX0RXQzNf
UlRLDQo+ICAJICBvciBkdWFsLXJvbGUgbW9kZS4NCj4gIAkgIFNheSAnWScgb3IgJ00nIGlmIHlv
dSBoYXZlIHN1Y2ggZGV2aWNlLg0KPiAgDQo+ICtjb25maWcgVVNCX0RXQzNfRUlDNzcwMA0KPiAr
CXRyaXN0YXRlICJFc3dpbiBQbGF0Zm9ybXMiDQo+ICsJZGVwZW5kcyBvbiBPRg0KPiArCWRlcGVu
ZHMgb24gVVNCPXkgfHwgVVNCPVVTQl9EV0MzDQo+ICsJZGVmYXVsdCBVU0JfRFdDMw0KPiArCWhl
bHANCj4gKwkgIFRoZSB1c2IgY29udHJvbGxlciBvbiBlaWM3NzAwIFNvQy4NCj4gKwkgIHN1cHBv
cnQgb2YgVVNCMi8zIGZ1bmN0aW9uYWxpdHkNCj4gKwkgIGluIEVzd2luIHBsYXRmb3Jtcy4NCj4g
KwkgIHNheSAnWScgb3IgJ00nIGlmIHlvdSBoYXZlIG9uZSBzdWNoIGRldmljZS4NCj4gKw0KPiAg
ZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvTWFrZWZpbGUgYi9kcml2ZXJz
L3VzYi9kd2MzL01ha2VmaWxlDQo+IGluZGV4IDgzMGU2YzllNWZlMC4uMDVmNTgyMTAzZjhiIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvTWFrZWZpbGUNCj4gQEAgLTU3LDMgKzU3LDQgQEAgb2JqLSQoQ09ORklHX1VTQl9E
V0MzX0lNWDhNUCkJCSs9IGR3YzMtaW14OG1wLm8NCj4gIG9iai0kKENPTkZJR19VU0JfRFdDM19Y
SUxJTlgpCQkrPSBkd2MzLXhpbGlueC5vDQo+ICBvYmotJChDT05GSUdfVVNCX0RXQzNfT0NURU9O
KQkJKz0gZHdjMy1vY3Rlb24ubw0KPiAgb2JqLSQoQ09ORklHX1VTQl9EV0MzX1JUSykJCSs9IGR3
YzMtcnRrLm8NCj4gK29iai0kKENPTkZJR19VU0JfRFdDM19FSUM3NzAwKQkJKz0gZHdjMy1laWM3
NzAwLm8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1laWM3NzAwLmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2R3YzMtZWljNzcwMC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
IGluZGV4IDAwMDAwMDAwMDAwMC4uMzM3ZjZjMWNiZTY2DQo+IC0tLSAvZGV2L251bGwNCj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWVpYzc3MDAuYw0KPiBAQCAtMCwwICsxLDIwNyBAQA0K
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKy8qDQo+ICsgKiBFc3dp
biBTcGVjaWZpYyBHbHVlIGxheWVyDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IDIwMjUsIEJlaWpp
bmcgRVNXSU4gQ29tcHV0aW5nIFRlY2hub2xvZ3kgQ28uLCBMdGQuDQo+ICsgKg0KPiArICogQXV0
aG9yczogV2VpIFlhbmcgPHlhbmd3ZWkxQGVzd2luY29tcHV0aW5nLmNvbT4NCj4gKyAqICAgICAg
ICAgIFNlbmNodWFuIFpoYW5nIDx6aGFuZ3NlbmNodWFuQGVzd2luY29tcHV0aW5nLmNvbT4NCj4g
KyAqLw0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICsjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvb2YuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvdXNiLmg+DQo+ICsj
aW5jbHVkZSA8bGludXgvcG0uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ICsNCj4gKyNkZWZpbmUgSFNQX1VTQl9WQlVT
X0ZTRUwgMHgyYQ0KPiArI2RlZmluZSBIU1BfVVNCX01QTExfREVGQVVMVCAweDANCj4gKw0KPiAr
I2RlZmluZSBIU1BfVVNCX0JVU19GSUxURVJfRU4gKDB4MSA8PCAwKQ0KPiArI2RlZmluZSBIU1Bf
VVNCX0JVU19DTEtFTl9HTSAoMHgxIDw8IDkpDQo+ICsjZGVmaW5lIEhTUF9VU0JfQlVTX0NMS0VO
X0dTICgweDEgPDwgMTYpDQo+ICsjZGVmaW5lIEhTUF9VU0JfQlVTX1NXX1JTVCAoMHgxIDw8IDI0
KQ0KPiArI2RlZmluZSBIU1BfVVNCX0JVU19DTEtfRU4gKDB4MSA8PCAyOCkNCj4gKw0KPiArI2Rl
ZmluZSBIU1BfVVNCX0FYSV9MUF9YTV9DU1lTUkVRICgweDEgPDwgMCkNCj4gKyNkZWZpbmUgSFNQ
X1VTQl9BWElfTFBfWFNfQ1NZU1JFUSAoMHgxIDw8IDE2KQ0KPiArDQo+ICtzdHJ1Y3QgZHdjM19l
c3dpbiB7DQo+ICsJaW50IG51bV9jbGtzOw0KPiArCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gKwlz
dHJ1Y3QgY2xrX2J1bGtfZGF0YSAqY2xrczsNCj4gKwlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqdmF1
eF9yc3Q7DQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IGR3Y191c2JfY2xrX2luaXQoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4gKwl1MzIg
aHNwX3VzYl9idXM7DQo+ICsJdTMyIGhzcF91c2JfYXhpX2xwOw0KPiArCXUzMiBoc3BfdXNiX3Zi
dXNfZnJlcTsNCj4gKwl1MzIgaHNwX3VzYl9tcGxsOw0KPiArCXUzMiBhcmdzWzRdOw0KPiArDQo+
ICsJcmVnbWFwID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZV9hcmdzKGRldi0+b2Zf
bm9kZSwNCj4gKwkJCQkJCSAgICAgICJlc3dpbixoc3Atc3AtY3NyIiwgNCwNCj4gKwkJCQkJCSAg
ICAgIGFyZ3MpOw0KPiArCWlmIChJU19FUlIocmVnbWFwKSkgew0KPiArCQlkZXZfZXJyKGRldiwg
Ik5vIGhzcC1zcC1jc3IgcGhhbmRsZSBzcGVjaWZpZWRcbiIpOw0KPiArCQlyZXR1cm4gUFRSX0VS
UihyZWdtYXApOw0KPiArCX0NCj4gKw0KPiArCWhzcF91c2JfYnVzICAgICAgID0gYXJnc1swXTsN
Cj4gKwloc3BfdXNiX2F4aV9scCAgICA9IGFyZ3NbMV07DQo+ICsJaHNwX3VzYl92YnVzX2ZyZXEg
PSBhcmdzWzJdOw0KPiArCWhzcF91c2JfbXBsbCAgICAgID0gYXJnc1szXTsNCj4gKw0KPiArCS8q
DQo+ICsJICogdXNiIGNsb2NrIGluaXQNCj4gKwkgKiByZWYgY2xvY2sgaXMgMjRNLCBiZWxvdyBu
ZWVkIHRvIGJlIHNldCB0byBzYXRpc2Z5DQo+ICsJICogdXNiIHBoeSByZXF1aXJlbWVudCgxMjVN
KQ0KPiArCSAqLw0KPiArCXJlZ21hcF93cml0ZShyZWdtYXAsIGhzcF91c2JfdmJ1c19mcmVxLCBI
U1BfVVNCX1ZCVVNfRlNFTCk7DQo+ICsJcmVnbWFwX3dyaXRlKHJlZ21hcCwgaHNwX3VzYl9tcGxs
LCBIU1BfVVNCX01QTExfREVGQVVMVCk7DQo+ICsJLyoNCj4gKwkgKiByZXNldCB1c2IgY29yZSBh
bmQgdXNiIHBoeQ0KPiArCSAqLw0KPiArCXJlZ21hcF93cml0ZShyZWdtYXAsIGhzcF91c2JfYnVz
LCBIU1BfVVNCX0JVU19GSUxURVJfRU4gfA0KPiArCQkgICAgIEhTUF9VU0JfQlVTX0NMS0VOX0dN
IHwgSFNQX1VTQl9CVVNfQ0xLRU5fR1MgfA0KPiArCQkgICAgIEhTUF9VU0JfQlVTX1NXX1JTVCB8
IEhTUF9VU0JfQlVTX0NMS19FTik7DQo+ICsJcmVnbWFwX3dyaXRlKHJlZ21hcCwgaHNwX3VzYl9h
eGlfbHAsIEhTUF9VU0JfQVhJX0xQX1hNX0NTWVNSRVEgfA0KPiArCQkgICAgIEhTUF9VU0JfQVhJ
X0xQX1hTX0NTWVNSRVEpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBpbnQgZHdjM19lc3dpbl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAr
ew0KPiArCXN0cnVjdCBkd2MzX2Vzd2luICplc3dpbjsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYg
PSAmcGRldi0+ZGV2Ow0KPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7
DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWVzd2luID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9m
KCplc3dpbiksIEdGUF9LRVJORUwpOw0KPiArCWlmICghZXN3aW4pDQo+ICsJCXJldHVybiAtRU5P
TUVNOw0KPiArDQo+ICsJZXN3aW4tPmRldiA9IGRldjsNCj4gKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0
YShwZGV2LCBlc3dpbik7DQo+ICsNCj4gKwllc3dpbi0+bnVtX2Nsa3MgPSBkZXZtX2Nsa19idWxr
X2dldF9hbGxfZW5hYmxlZChkZXYsICZlc3dpbi0+Y2xrcyk7DQo+ICsJaWYgKGVzd2luLT5udW1f
Y2xrcyA8IDApDQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgZXN3aW4tPm51bV9jbGtz
LA0KPiArCQkJCSAgICAgIkZhaWxlZCB0byBnZXQgdXNiIGNsb2Nrc1xuIik7DQo+ICsNCj4gKwll
c3dpbi0+dmF1eF9yc3QgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0KGRldiwgInZhdXgiKTsNCj4g
KwlpZiAoSVNfRVJSKGVzd2luLT52YXV4X3JzdCkpDQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgUFRSX0VSUihlc3dpbi0+dmF1eF9yc3QpLA0KPiArCQkJCSAgICAgIkZhaWxlZCB0byBn
ZXQgdmF1eCByZXNldFxuIik7DQo+ICsNCj4gKwlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0
KGVzd2luLT52YXV4X3JzdCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoZXN3aW4tPmRldiwgcmV0LA0KPiArCQkJCSAgICAgIkZhaWxlZCB0byBkZWFzc2VydCByZXNl
dFxuIik7DQo+ICsNCj4gKwlyZXQgPSBkd2NfdXNiX2Nsa19pbml0KGRldik7DQo+ICsJaWYgKHJl
dCkgew0KPiArCQlkZXZfZXJyKGVzd2luLT5kZXYsICJGYWlsZWQgdG8gY2xrIGluaXQ6ICVkXG4i
LCByZXQpOw0KPiArCQlnb3RvIHJlc2V0X2Fzc2VydDsNCj4gKwl9DQo+ICsNCj4gKwlwbV9ydW50
aW1lX3NldF9hY3RpdmUoZGV2KTsNCj4gKwlwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiArDQo+
ICsJcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhkZXYpOw0KPiArCWlmIChyZXQgPCAwKSB7DQo+
ICsJCWRldl9lcnIoZGV2LCAiZ2V0X3N5bmMgZmFpbGVkIHdpdGggZXJyICVkXG4iLCByZXQpOw0K
PiArCQlnb3RvIGRpc2FibGVfcG07DQo+ICsJfQ0KPiArDQo+ICsJLyogQWxsb2NhdGUgYW5kIGlu
aXRpYWxpemUgdGhlIGNvcmUgKi8NCj4gKwlyZXQgPSBvZl9wbGF0Zm9ybV9wb3B1bGF0ZShucCwg
TlVMTCwgTlVMTCwgZGV2KTsNCg0KQ2FuIHdlIHVzZSB0aGUgZHdjMyBjb3JlIGFzIGEgbGlicmFy
eSBub3cgaW5zdGVhZCBvZiB0aGlzIGFzIG5vdGVkIGJ5DQpLcmlzaG5hPyBDaGVjayBkd2MzLXFj
b20gZm9yIHJlZmVyZW5jZS4NCg0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2VycihkZXYsICJm
YWlsZWQgdG8gY3JlYXRlIGR3YzMgY29yZTogJWRcbiIsIHJldCk7DQo+ICsJCWdvdG8gcHV0X3Bt
Ow0KPiArCX0NCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICsNCj4gK3B1dF9wbToNCj4gKwlwbV9y
dW50aW1lX3B1dF9zeW5jKGRldik7DQo+ICtkaXNhYmxlX3BtOg0KPiArCXBtX3J1bnRpbWVfZGlz
YWJsZShkZXYpOw0KPiArcmVzZXRfYXNzZXJ0Og0KPiArCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGVz
d2luLT52YXV4X3JzdCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtzdGF0
aWMgdm9pZCBkd2MzX2Vzd2luX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiArew0KPiArCXN0cnVjdCBkd2MzX2Vzd2luICplc3dpbiA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOw0KPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICsNCj4gKwlv
Zl9wbGF0Zm9ybV9kZXBvcHVsYXRlKGRldik7DQo+ICsNCj4gKwlwbV9ydW50aW1lX3B1dF9zeW5j
KGRldik7DQo+ICsJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ICsJcmVzZXRfY29udHJvbF9h
c3NlcnQoZXN3aW4tPnZhdXhfcnN0KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBfX21heWJl
X3VudXNlZCBkd2MzX2Vzd2luX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ICt7DQo+ICsJc3RydWN0IGR3YzNfZXN3aW4gKmVzd2luID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ICsNCj4gKwljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShlc3dpbi0+bnVtX2Nsa3MsIGVz
d2luLT5jbGtzKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50
IF9fbWF5YmVfdW51c2VkIGR3YzNfZXN3aW5fcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiArew0KPiArCXN0cnVjdCBkd2MzX2Vzd2luICplc3dpbiA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlyZXQgPSBjbGtfYnVsa19wcmVwYXJlX2Vu
YWJsZShlc3dpbi0+bnVtX2Nsa3MsIGVzd2luLT5jbGtzKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJ
CWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBjbG9ja3M6ICVkXG4iLCByZXQpOw0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2MzX2Vzd2luX2Rldl9wbV9vcHMgPSB7
DQo+ICsJU0VUX1JVTlRJTUVfUE1fT1BTKGR3YzNfZXN3aW5fcnVudGltZV9zdXNwZW5kLA0KPiAr
CQkJICAgZHdjM19lc3dpbl9ydW50aW1lX3Jlc3VtZSwgTlVMTCkNCg0KWW91IGRvbid0IGhhdmUg
c3lzdGVtIHBtPw0KDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBlc3dpbl9kd2MzX21hdGNoW10gPSB7DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJlc3dpbixl
aWM3NzAwLWR3YzMiIH0sDQo+ICsJe30sDQo+ICt9Ow0KPiArDQo+ICtNT0RVTEVfREVWSUNFX1RB
QkxFKG9mLCBlc3dpbl9kd2MzX21hdGNoKTsNCj4gKw0KPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kcml2ZXIgZHdjM19lc3dpbl9kcml2ZXIgPSB7DQo+ICsJLnByb2JlID0gZHdjM19lc3dpbl9w
cm9iZSwNCj4gKwkucmVtb3ZlID0gZHdjM19lc3dpbl9yZW1vdmUsDQo+ICsJLmRyaXZlciA9IHsN
Cj4gKwkJLm5hbWUgPSAiZWljNzcwMC1kd2MzIiwNCj4gKwkJLnBtCT0gJmR3YzNfZXN3aW5fZGV2
X3BtX29wcywNCg0KVXNlIHBtX3B0cigpIGFuZCByZW1vdmUgdGhlIF9fbWF5YmVfdW51c2VkIHRh
Z3MuDQoNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gZXN3aW5fZHdjM19tYXRjaCwNCj4gKwl9LA0K
PiArfTsNCj4gKw0KPiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihkd2MzX2Vzd2luX2RyaXZlcik7
DQo+ICsNCj4gK01PRFVMRV9BVVRIT1IoIldlaSBZYW5nIDx5YW5nd2VpMUBlc3dpbmNvbXB1dGlu
Zy5jb20iKTsNCj4gK01PRFVMRV9BVVRIT1IoIlNlbmNodWFuIFpoYW5nIDx6aGFuZ3NlbmNodWFu
QGVzd2luY29tcHV0aW5nLmNvbSIpOw0KPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiArTU9E
VUxFX0RFU0NSSVBUSU9OKCJEZXNpZ25XYXJlIFVTQjMgRVNXSU4gR2x1ZSBMYXllciIpOw0KPiAt
LSANCj4gMi4yNS4xDQo+IA0KDQpCUiwNClRoaW5o

