Return-Path: <linux-kernel+bounces-836868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C3BAAC37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B128189E71C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7A26B74A;
	Mon, 29 Sep 2025 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VawQxnMB";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aNTCAMnJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nlKmedWS"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8D1FF5F9;
	Mon, 29 Sep 2025 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759189598; cv=fail; b=ArBxv/FO+PXBuu/7WqvwOr9T8oE0MnuxV+uaP5jjlwA27j3oBtL0HaR4K4Fk3ZGVY7gZXOcJ1VuYmdBINBZPo1//BfLDrAP5a2+rxdwNogfe8l+bp4ZofHOT1H1zzvXNM+RS6v4RXACXMg+Jbwkv7tPQ/LRb1JLPcW3hCFQH4Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759189598; c=relaxed/simple;
	bh=tGarvm9Et823pNVeoOY/6I1vxL2jsPotyM4WUBNhPlk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UUcC6xHewqTfVCZ/Cg7j8cWjFw7hwLBknB2yHr1gSxNd/y/1cZdKAfzHfRwaZgaxGel+Ny9UvEzDrVYSylyZ45wbCR7CbmlRJh9aoAmvPoZR9jHyBF2IbfOrb/cW8bIa2F3OVf7mco0JRii69LM9uIOZ1UmSZk9jfm0ef/0Z6vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VawQxnMB; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aNTCAMnJ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nlKmedWS reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLHFoX028677;
	Mon, 29 Sep 2025 16:46:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=tGarvm9Et823pNVeoOY/6I1vxL2jsPotyM4WUBNhPlk=; b=
	VawQxnMBtxLFKMzxfuGZj3HqJbwPuOnU9+K0Td49EXo3wyBuZQ4ylossmdZ/NBa3
	SsmAjpZyZhXN00stKxvaC2YnDH7Y71ZpBCFhoWzOvu1YEm0iA/NuPBdUsMnR+/UN
	BRBIAUmgUdzy3JDniWkrgucI3AIEuEVz3t9M0gZZbG3HrP0nN5geBoExIDrq8AoZ
	9yagDvgJgDN1rRuip+5ia8XTlJ4VdqYOPRh8YShDkqaG9VEkZXgQ2z9Wdquumb9m
	atXSC7NCL4XSPcXUpA4OzzzXO2EpY+ElVO1Sr6b079hbRVwqSTch22HsN+oQ53eO
	Z/03Mg0DVzuBSLPyt2wI6w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49eexj0vsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1759189581; bh=tGarvm9Et823pNVeoOY/6I1vxL2jsPotyM4WUBNhPlk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=aNTCAMnJPhqjTs01uKeRpTMQy4TKsxz8T1u+B9acFZttv0fXvESx1EU/vLiH0LnXG
	 tetvP3Pqnt/P9Nf4C5gBilny5d3Y3QZgbQAB01AlFrNvoj3YwACAannEu9i6r9vClb
	 7YwkuBgxIkHEIDVDCfgiEm1mH5YHrwQQjFeotUfiHlVX+6WoRtLq5aJhPcKVl4Ck/N
	 NZ3tKhRBo6JavN91V1pQkk9tEDdnmX/81mVMVYepwFnqeyXEyYAwUyEKfpKUA8ZoyH
	 b7E73jLHxpiJQpk9l0Y7+mF7+ta2mAGp9TwpiCF1LxFh2fc1L9fWbRV+V8v8BtAQK0
	 INVFpggXHZmWA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F2B2E403B9;
	Mon, 29 Sep 2025 23:46:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1F341A0079;
	Mon, 29 Sep 2025 23:46:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nlKmedWS;
	dkim-atps=neutral
Received: from DM2PR04CU003.outbound.protection.outlook.com (mail-dm2pr04cu00302.outbound.protection.outlook.com [40.93.13.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1E5734063E;
	Mon, 29 Sep 2025 23:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzblSb6lqOJa/2Ye0/MPCPN7Nl8XHE9Inl1bDnrG7aUGv/ynX1D3TCbvdz2Re+vKuEguw3a4GPrqIPhfIZo1EfNK/rfSNrOpHAbXFrkomCWnPcAwXnwpMdUkiY5xyHpTEKY4wkVdmw6TSFUBiXWKoXRi9lueLh2dtImVhaJVhAWQ1+Ja1sFNQTqrdX3W1/k8w3Vw6jqdlVAjEMGQU7/WYp1/nSD83cGvyd6r7vD+VgUM9SmVTboin+Bv3NJIi7+PLeLHhGjZblRdi8FeS3Fe+jSee8ga6XVOlxIFVE2HNv1TDN0v8N65EJQSynvAPoakMEgWM2Lc55nSKb36jYQPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGarvm9Et823pNVeoOY/6I1vxL2jsPotyM4WUBNhPlk=;
 b=Zv48SlWalg2yf98AFbdfLK83axXtwZHoQAC0SL7wAwahI/HbDV3Yt+yEumMwKNfjHoSyU5rGpJcEGGvMo7E9FT8iKqvcbAORLSUz2TS+BECgwUu+35EVgbJyIRCuewfEgl7EDzwd9Ro4YYOVFlv40pMEdm6XAWQtv++7eXPcKRP9GHyNouLZEmrjJYb4RR6fFIkEgIp7WSn5cfQfR9NcydxkiY3YXRmiPc/C+/S1iWgCdFdwo9NK/bJwfQWqsB5omtKBtDZQYb4NOeSyvyF1s2cPlDf/u5hsWaJ3s3Q2zqYvO+CQ+MNC4vOdkKChujMT+glKvgnwROpygHsIcSVBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGarvm9Et823pNVeoOY/6I1vxL2jsPotyM4WUBNhPlk=;
 b=nlKmedWSmVFB8nYSdpzBhFJ7CICLIjF7cCBmPv8uICv7/BJ7nHJ8qFFvb6/O5tMKmwkXCbpIYFuSG54FfaLlRW092aJDLU7+Dn9FOoMOiwIur9w4OiUGPNHU6bSy8Lk4mOV2mvPQwjgHbPdWCtw6Mdi0Vhal75hGSqS6oGCzvGs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 23:46:15 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 23:46:15 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ze Huang <huang.ze@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Don't call clk_bulk_disable_unprepare() twice
Thread-Topic: [PATCH] usb: dwc3: Don't call clk_bulk_disable_unprepare() twice
Thread-Index: AQHcMW7vrKTQWD+dnkmboPbuIuYYK7Sq0N+AgAACvgA=
Date: Mon, 29 Sep 2025 23:46:15 +0000
Message-ID: <20250929234614.sqcigfpqtrkmbjlw@synopsys.com>
References:
 <371860315a5c1ef6e800fa825e4c23ce335a55e2.1759170517.git.christophe.jaillet@wanadoo.fr>
 <20250929233625.jpk2sxjxhj2kghfb@synopsys.com>
In-Reply-To: <20250929233625.jpk2sxjxhj2kghfb@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV8PR12MB9263:EE_
x-ms-office365-filtering-correlation-id: fe91d3d4-5b9b-41e7-b78d-08ddffb2611f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGFTRXo0dnJORVhGcHpVWGQ3cGMxV3kzRUhNSXBsaDlHRzBvOFZJd0dIUDRo?=
 =?utf-8?B?YmhpMDc4WTI2eS8xSU1pUzNmcU55VGRTaG9yV3NTTVJTbkFFSldKWno4bDRF?=
 =?utf-8?B?RTZxRHdub1NSb2c4djdraHFrRmhzdjBydzVuaVFHRFpXb3I2T1dtdGk5WUhv?=
 =?utf-8?B?K2pqZUlPbEUzdTFNdWt4bWdMcG5xbHVwak9lbzhwY0FDM0UvdVRFaGhCV2tS?=
 =?utf-8?B?eDlra3ZLMEdCVjNMWHdwVnVldTlWWDVpMUYxRkdpSnNTWktCSXU1RnZCb084?=
 =?utf-8?B?TlhDL25tOHFiYW1icHUxVmJoMGJhbjAzOFN0MnVDV1JTQ2oxd05YanExcSta?=
 =?utf-8?B?WHJFNTZqQ040ckRXWGx6eUl1MWUzRjlLUVBySFlENHVVampSakt4OHdrMlQ3?=
 =?utf-8?B?QnVTUGRtZWRXK1piVFN3WXlRTmh0QmIvbVd1YllMRDZ4V1diR0xJTXIxK2pn?=
 =?utf-8?B?Vk9hWmlnVTRTY0NuUmQwQ05RNFpRdWc4a3h4TG9DaWZUa3dsRXVWbmE4SVVw?=
 =?utf-8?B?eHRZRWRJd3ZrNmRZRlpRMHNnbE1jSE4ydk80Q21xT3NjOHdFWXZXMTFIYUdB?=
 =?utf-8?B?L0ZONU5BUC8rcCt2eFF4ZEl5ek1RU1ZVQUhlekFKVFNiZjE5NlZKU05XcGx3?=
 =?utf-8?B?b05XV0ltSktUKzEzbjhHbTcxRFAxNm5keDIxQUE5em9xV244VkM3WDRMZHEx?=
 =?utf-8?B?dWNnbXNZZmFVdUZpUW1HenN0VlczTkNuTE9pREtsOWxZTklhNnhwM2hINVU3?=
 =?utf-8?B?NFI1WU44OU1HbzJ5eUxRUDZBSXh2ZnpBV1FHWnB3N21INFhTaGR6TWZjWTVW?=
 =?utf-8?B?Q1hDUTZ6T2x5bUtuOGc0Um1DV3JtdlhKN3VyQ01ic0F6bGc0QWVtcVczZlJJ?=
 =?utf-8?B?UW4yQ05rS2puQzA5OVczUWpyOHFDTGRoWjlueUJoWGVjZ2tYbDA0NGw5Wi9H?=
 =?utf-8?B?MzhsUzVzN0llRXpGWUpSVXBzbWVNUVdBbXZSTTBJSXJZU1lvZG9qL0UzUFNZ?=
 =?utf-8?B?MWhHMVVnWXl0ZVZqNmg4cWEyakpPQjBxaDF4clJjWWUzU2VidVF4cWFoYXVK?=
 =?utf-8?B?L1ZQUzQ5dVNkai9Bb0loaVVTcWk0R0ltdEswMHU3ekh1a1hTelJoekdCRStp?=
 =?utf-8?B?UVhES0p5OUk5MU9FaEN2NkpHUTRvMi9BNjJzcXgvWk83NVZwZnh3bkNlK3F2?=
 =?utf-8?B?WHRpOWxLVitmM3E2aktzU25hemhucXc3N3hiM1Ardis3WVBZUHhoblBJQWxl?=
 =?utf-8?B?aWtBL3NBcjJUTzlBN1JQb3hlU3FDK1JuV0pUOTdYb3lmemlkS1RIaWRqQXlJ?=
 =?utf-8?B?b2RPamNNZWdWUmZabnhmWWw4L0dwVUE0RnNFSkhxOXl3UVo2c2FrU2JITXRt?=
 =?utf-8?B?MGdYNllUVUk1VWdMcElHbUJrU3dFWCtNUlcrMjBMZm8zaFFrazF4ZFhhTGpP?=
 =?utf-8?B?dE96WURJVmZaM25DNTJuZTN1UXFVNWl3azg1YmV1N1I4ajZaZUtubmo1R242?=
 =?utf-8?B?cEJmY2FMNVVHWDBNbG1ueXpHSTdWeUlwRkNTTER3SUQzSmpCcXFEYytYaE5v?=
 =?utf-8?B?NFBMREdHdG1KVXpIN3QrRFBXVUVHdERuclUyR3R3OTNudTFWc0pxQldEUkht?=
 =?utf-8?B?d01OZGhCbUJUbGdqc3cydENhdWVSNHNXVC9lL0c5V3ZUdzBDZ0RhRGlPYlRr?=
 =?utf-8?B?bEpsUGJ3ajRLeUJ5UjdpNXJKNjc3TStWNlRtRWNMWUJ1dGJybHNJbnhZMEFr?=
 =?utf-8?B?RlIyOFpZQlZxY1RrU3AxRENrNlVUSzk4UGc4R0FIeTBmUERHRDJIaVZnREZ4?=
 =?utf-8?B?NmxiUGs3Q2xsc3ZpalR3TG5mMDdnL0xNUzlTSDYrL0lGVHVDeW42R3EyYm1W?=
 =?utf-8?B?bmI3WHZTSFNjUFdZYm5YelBrTldaa1lLNUFRYTR0djV3VEZRQy9MZlc0dWxC?=
 =?utf-8?B?d1c3SVd6bWloejdyTXBqTmE2L3pFMzc0MDRtYTBINHk5ZjBsTnQzU2RlT01C?=
 =?utf-8?B?Rk1aSnlYcXZyK1dER3VRak1uVWg4SUM3d25SeUEzbmxSM1FpS1NreGdvRnN3?=
 =?utf-8?Q?dSQsWi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3R6OHQ0eFlPanBXMkZkTi9KblR6MDFFUDB0Y3U0S204Y3V5a0xkeW11Uk5T?=
 =?utf-8?B?UTdkYzJBS3d5dW8zaG9Nd0sxYmoyVHdZYlFhTFhGODJUOVlNTXJGRnI3ak9k?=
 =?utf-8?B?RVkzYmJYbmg5bnMrSThDZExvU0QzUmVoa082Y0FBZUZzVVpwL29HYkk5czMr?=
 =?utf-8?B?MlN0alY4WnlwaFZsTGlyN0Q0aktNY1RHeXkydmp6V1R4ZXRCTlNqQzFZQW11?=
 =?utf-8?B?aElPaUJmSjNiTXBmNTNhOW1nRFN2clQvSWM0bmVycXhpdDViZWtIVVFVSmtN?=
 =?utf-8?B?NFEyZE9kMXJRdFVlTDhqZ3B5eFRtdlV3R1ovNi8vUmNUT09LZkhGbWpieCtP?=
 =?utf-8?B?Q1dEb3lmUkYxU2NhNWFQd2RmbkFXVHlyUk04NGMwM0dXeEhka2ZIZWZONVdi?=
 =?utf-8?B?VXcxNWhuTlVyTTlGcFdybzF5UXlrbTdjTlJLcmVBYXhUekVoaWxCeTBrQ2xI?=
 =?utf-8?B?SkNSVEZRdnJSY244dzcvQ0dIS29VTzhuek9VeVNlOXVsd0Z5RjVWc2c1Ymgr?=
 =?utf-8?B?dm9PQkJOM1dQZ3QrbWVkcXN6K0I3R2xXQXdPWXB4L21IRDI5QVU5Z0pqUlJi?=
 =?utf-8?B?QWhNa1hOSC95OXZTN09HSEtHZzFJdmZVN0s3UGQ0aitIRzRaQ24vNTZ4Wmxh?=
 =?utf-8?B?a3JKbE9qN091MnZ6a2x1UEtmZ3BZN0pjb0VXTnUycFpkZGR1WTArb1d3S0dB?=
 =?utf-8?B?d1RBa01ZY200bll1YVpSeG4zQTIrc2prOWpQUjBjeVZVb2RNV0tmVmdZODh0?=
 =?utf-8?B?RFdPaTFLUEZMVlYzUnd6SkRnQ3ZjWmd3NHh4RnAyWUtYc3V6MnBWNktwTzFH?=
 =?utf-8?B?NFJNQytYNnRDQy8wZ2xBK3F3amVEWk5wUzd2VHhaUHQ0TEdhQW1lN0o4UHpW?=
 =?utf-8?B?WUdiaVJEald2bkhzajVmTEVBKzFkS1FRMGNWSzBQVVg0S01kVTlxZHdGN2Z5?=
 =?utf-8?B?WGdkaU9SZnZRV0dyY0djQmNkVjAvaDZQMWNoRms3TzhEZVBTOXFhVlpPbmJI?=
 =?utf-8?B?TjRIQXdRbnVsdk1PcmFaKytHMzZBQTBzVm8rcDBZWjhhcS90Z3luQTdoNWtt?=
 =?utf-8?B?dW9vMVVDL0V0RFE2c2NpS3Y2VnRvM24xVTh4UVlUUTBkcm5sb2k2amZxbEwy?=
 =?utf-8?B?R3VueitXZmI4ejZ1U0IrY0xqdTRLSDNGTjVHMk5hZ0RyOW5wQWR0OGFOL3pG?=
 =?utf-8?B?bXV0bklFeVZvc0FnRUJITHBSbzNLVGwyeUJzS3hBR085Wk00djVobUZJYWlz?=
 =?utf-8?B?SHZ2bkxVRWo1cFZNQk92aGxFNlYvdjBGMDd2b1cyZFcyN0N6c29GaVZUSkhq?=
 =?utf-8?B?WFRCSUdWODd3Q1h3R09WREFtNTFEbHBCaUc1ZUloTEJzdDRXbUw4NjZZVWNB?=
 =?utf-8?B?aW5UaXkvTGZvaDFiMVI0VU9haW5kWmIyekVzR1I2YUlXcUJOSXFVVzVVTW9T?=
 =?utf-8?B?NnRxZUwrb2J5L0JJTTNIbHl3TjExTzVlWXVONkQ2YUg5cHFEOVlXYk8yeEgz?=
 =?utf-8?B?V0NGQW0vNVViSkh6NGoreXNsS1VLSk5XOUxyOHNmb2V3a3d1YUdWTjhRVWI5?=
 =?utf-8?B?ZFhvYXpZTjRzZmtFY3JkUklNNEVQTWY0UExYS1p3UU9DN1BsMHBva2o5QWx0?=
 =?utf-8?B?Vmc2UjBycCs1WHlvQjZZZXhBbm1xdENXVmRtY0V4MkpyNVdZMXB2TXZpV0RS?=
 =?utf-8?B?SmpWMitQOGRTR0diSEw5OGorUkV5RTNreWs4NU9SZnJGQTZldTlBelB6Y1JZ?=
 =?utf-8?B?ZE9mS1owOXFLelArWG9lUnNnMld6UzdYTkxuemZMTWRrMERuUnN2RDlTV0Nm?=
 =?utf-8?B?QlNrY0hib0pPL3BscEcxanBQRlZ5YTFFZDArSG8rS0xKK2tiQm1wN0NoWEI5?=
 =?utf-8?B?dXRuMkFBNEk4UTNBWldvbFZ2Ukxld21WbGdOWkdCRXhqUEFxNTRBZnh0ZThN?=
 =?utf-8?B?RzMwTEZWVUNLNXJMNjI1MFdrMUNaek1PUzNEaktTdnJRTXJva3ZwcUNGWklu?=
 =?utf-8?B?WkVoa3hXa1F3Tm9xWm55ZHVZNHpyY1V5bk9ya3d5VHA4UVZOSkN5RzM4RmJE?=
 =?utf-8?B?cXpidjdVNHRHajN4TEZDRnVXTkZETG5RMnhzMkwwc0FOWEhyMmVxeFkvaXcz?=
 =?utf-8?Q?W7mKs5Cr5dz+FnJ0dpjZWiWDY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B3F1F23A3996E4991A5D6C8D29152E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lopYB7c0cFP4WPjA08KWx6KxFebXoYTYyjC/RkpqzFfKOiGqvC7OYt+GpDa8XGG6/GuWHwnHdZRsGuhW3l6QaqJ2cY3yqU3AOOS0NE+mV0zIkEhA/764eYjVQdLyRFFSnZMxn5nahOVQ/qQzor2LH2vG6rAjcSwLUJoHyKiZt0/MRh0YuvBOOUBB3VNlOjzW6Lu7ag7BJxRpQCWmcIbHUQ8ZyNkj4w+LTzEhL/p0AaDtx16ZcNVr/EwpuiqzUE0CBJYJb0bsmb0Rx4I+toDutmP9gf/TVXjjMLcuNjoZma+3iH0Eigr75Q5mqKMUZwWXjmT7l/ceFM2JIuKF3sN8H/AC/ovfTzGeJhb8r3qCyzNQq5A/qRMDhjn68UJOUrCUBelc7I4W3goy9lytpNsfZQIRx07RPaqZvhC+bwHWax4nnfdcSjt81pxigyLC1STKavMZGub7v5xGl7F/WhtsFhC650nQVEmCiND6otcD8Ubz8uftx7VMRFKD8OFBExhMBhj2iRlrqle8qYp2t9HZYgY+ItzcfvIuQI7TCb+zvuKB5Hwoid3z675Olj6aqUj+5phlJZKquPTzWOi/MePzA6HnTQQ0Sm4HXVZ1neTIU2pF5jqHor19fyxM7Zzd2IS9ttAIA4de6NHinoPjITRGHA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe91d3d4-5b9b-41e7-b78d-08ddffb2611f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 23:46:15.4674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5bJlklfnOoom6Yyt8jClbW48sCZyJ/dez/BkLnUNlBZciZ36zwOS3jX4gXQt606eFJTeUoSnCtLyKiJhN4Peg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDEwNyBTYWx0ZWRfX0uRIi/sCyYFa
 fol7qPgdfre0HWX/O0JzcySG/m/slWB2Qqfi5oWiYMPECnxF92TexlBxlj+X6N+JOkd/GP8Bp0O
 TeN31sO9ZGoY0m3pXt12lp35NgHtW0MaBzQ4yB0YF1XiBatRV0dO180iw/3MlMENRTbESols6Ug
 tGeMa+fdbWGghsSRspUI2wbrisdSIpbBQ8RQSYl/zrwjHqaVCnVfGiiLw+XJm0omuSV6NpxLMOG
 Ml2JfSHt4G7R/NNgmhIhGo7tO64epz4hh5gsPAwjqavn1r6Au73GGWMm1bG8sNQzdpHsVrfSVxL
 Oel8OSGIpjnqPnC2xRiS5Mtv+0Exl0RG/hZ0NYZ1dylscuepTq7pl4/SuU72jLjAV3uPs/hK+/D
 JAdp1qBoPycm1bzLrUXAtflQ4RcC2w==
X-Proofpoint-GUID: S1nnb8fEW2N0gyuZ184FJtLo_gwJeQQo
X-Authority-Analysis: v=2.4 cv=Wc0BqkhX c=1 sm=1 tr=0 ts=68db1a4e cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=jIQo8A4GAAAA:8 a=pmGOrT_8Fm-HJbFBHPUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: S1nnb8fEW2N0gyuZ184FJtLo_gwJeQQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509270107

T24gTW9uLCBTZXAgMjksIDIwMjUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gTW9uLCBTZXAg
MjksIDIwMjUsIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToNCj4gPiBkZXZtX2Nsa19idWxrX2dl
dF9hbGxfZW5hYmxlZCgpIGlzIHVzZWQgaW4gdGhlIHByb2JlLCBzbw0KPiA+IGNsa19idWxrX2Rp
c2FibGVfdW5wcmVwYXJlKCkgc2hvdWxkIG5vdCBiZSBjYWxsZWQgZXhwbGljaXRseSBpbiB0aGUg
cmVtb3ZlDQo+ID4gZnVuY3Rpb24uDQo+IA0KPiBXaHkgbm90PyBUaGUgY2xrX2J1bGtfZGlzYWJs
ZV91bnByZXBhcmUoKSBpcyB0byBkaXNhYmxlIGFuZCB1bnByZXBhcmUNCj4gdGhlIGNsb2Nrcywg
bm90IGZyZWVpbmcgdGhlIGNsb2Nrcy4NCj4gDQoNCmdhaC4uIEkgd3JvdGUgdGhpcyB0b28gcXVp
Y2tseSB3aXRob3V0IGNoZWNraW5nLi4uDQoNCkl0IGRvZXMgdW53aW5kIG9uIHJlbW92ZS4gVGhp
cyBpcyBmaW5lLg0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3Bz
eXMuY29tPg0KDQpCUiwNClRoaW5oDQo=

