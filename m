Return-Path: <linux-kernel+bounces-861663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B262BF34B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82D9B350A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF747331A45;
	Mon, 20 Oct 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="uOct3xAY";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="inNu7qrb"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DE2D0636;
	Mon, 20 Oct 2025 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990151; cv=fail; b=jWYLFRnSmvtEhlV4rhqiBbPqhixCkWYZ9jh4RPTej/wCQYHDp3Ti+Gfl+RDpQ6ObTEKvO3WKmOOz6NDgGQJ6VWZ1Z7pt6a+5N3bhCZPkgTQ8UDIv9HR6IaiAMnTIFgL668/HN1yrpOSf4RyeGYFXHrSLzvW991jTWA3VSuUvzy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990151; c=relaxed/simple;
	bh=JH4mjqM5VQ1o7mqpEOqiwpAs7a5SnnqG2brzwJkWY5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFFTpZBhiUsgzbb6+NjwLu0bEobipMwQ6VwzHG7wKN6lOEv8fdAhJ2Hoz+yZBeODwHHjKkJKloYejGZFWBnJV1FdruG4tspYNR5VsLkyt+q4WkXnHovB1PwWk7/xPa87JWjgFmDeQw1+C2/jfFjhoKUo4cISuLJuWMDHRKmh8i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=uOct3xAY; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=inNu7qrb; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59K9rr8t1134516;
	Mon, 20 Oct 2025 12:54:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=JH4mjqM5VQ1o7mqpEOqiwpAs7a5SnnqG2brzwJkWY
	5o=; b=uOct3xAYnMmRwuUAahEA3eNevdfwQ1nTeKtc4cVNwduzmNBqA8pJMutM3
	mknwwo9Im/+MbaXryv8jAPQvyZXWQzjcxYrJ+V6HTeI3htllvHd4zMyH4OvcBVTZ
	+W6rtRhisij+wJw7PWav6YZLSYIPlx2wtZ6lZ2R7MZKlY0fKDE+AnqTMuGxqDdMi
	a/kyIa8fUQcD+dI/gdiYzdwWppvfsAKHLkJY/3zlSgp+R09Wq2tXGVtPcUGH5XGa
	GncMN+lKtBTTQTOjVDKqcl9ecRkYGof2BPMnPtZiMiRMgjjqwZmpzmVtywDFIuJf
	t2Rl2IQ+G1Azp+1MQWJv0ziRmRckA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021132.outbound.protection.outlook.com [52.101.57.132])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49v8e8m0jp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 12:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBOc6zxBQJYrfF6WskmXxMZico2+3QmQMPt7C216dRqKEq00c5q1F9ECLIiCCODZtllyPepyvg8xVfJiqlP0fVpbZ7aMJLqE2wZ2c9J5Cvbasq6qWFfeEcoyPdy7YpR7RD2xv4KnfIy9mSz/yFGGpw6UWrNm7mgu6b9SXVnmQBgOgJSjwgp7ZTT0ou3PCDJQTlcbLLLLlQlqc0n3KRZSKhp0Pg5c8+n6Tk/JWiMNeij+r0DWJfmUQUw0rinih6et1P9L9xgSfqcO2yfgyHqHeGjVuQNA7yFs7svfVD32wraBb5x+5a16/dsh7w7OMX0CR0xjsGHb0hID8dt/b+bUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH4mjqM5VQ1o7mqpEOqiwpAs7a5SnnqG2brzwJkWY5o=;
 b=YEkSiyfh34y1SZ0pzMpjE/juf5epVxPnPnqWzVS2lypWkFPF8Dj+5tZAgqltS4OLuTVwkb/42EfM2JpZl9JdE5x09f1NGxhZw3wuWTwwa7R2JNlcXRLCsFVVnwJllYnZOQYiJe3GwVoDbe1CI6m/WCEPfxNlrUiao7I5WemqN+NJppju0nUMC3G5+js/0jviP+NFs9/u1BQL9FntJjPmnzq+UEBkivxK5jH0DepVYAZM3t5CD9C3htycqZsu/RWM6WBxvz4VvAIft0jpqcPUy2jhfY25IZpHOLgNPOjXv8zu9tqPFgmYF1rWjI+FeZG1wefEJCBvVUKpzNSg3s/5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH4mjqM5VQ1o7mqpEOqiwpAs7a5SnnqG2brzwJkWY5o=;
 b=inNu7qrblWCq+o+DrjUACR2wUMMcb3d3YjepYJVosCfSX8SIv2peB2Er3fnGOKxKFClqxeVaYXRFs5AurmLrC3jSyaTxquLJbsTkfiXLvrh4SD+kXUPDcLmuFUeeA6gISAhF36fI9wh60+4dtFpp1KVB4PqjWQqnI7hXJoaC683oaBbw8XxwHJvP0Q3/GoYSP1EfCPX1Zm/iEAiKT2dKWEF7WyInj6Rtekt5ewOcMMHPvBoXk+Oc8MiGv0HHImauqKzd2ohd1n7iFS4jRIx7o5ZI5NZ5zxzg3TC3KMl95LswyWjiL2oxTi9SQRd4sJmTndcDkq9YGLMZPhTAjE5kjw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by MN2PR02MB7070.namprd02.prod.outlook.com
 (2603:10b6:208:1f6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:54:41 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 19:54:41 +0000
From: Jon Kohler <jon@nutanix.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>,
        Brian Gerst <brgerst@gmail.com>,
        Brendan Jackman
	<jackmanb@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Alexandre
 Chartre <alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index: AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLdggAgAACrgA=
Date: Mon, 20 Oct 2025 19:54:41 +0000
Message-ID: <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
In-Reply-To: <20251020194446.w2s5f6nr7i7vw4ve@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|MN2PR02MB7070:EE_
x-ms-office365-filtering-correlation-id: 5c9f8571-e41d-4ab5-8c71-08de1012824e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjAyWVh5Z2JLVXhkd3d5ZlNDdXpKK3p1Y2p3dTRjSzhUQkRPeEpsbUhUUXV4?=
 =?utf-8?B?UThsK2E2TlN5K2FPWWNWRnZkbHdEQ1g1ZVFXaXVlem5oL0tpRmtTUHlOQmxV?=
 =?utf-8?B?TnFlNXRHZEtybU16d0F2Ry9Ib2ZEUFBRNDVORGNGVmdGSTZzQ1dQN0p4R09I?=
 =?utf-8?B?WGRVMmVxOHNiRDNoMVhldFVHamFGVGtFeGdJamxQTnF6QVdraXpGcHB3anlW?=
 =?utf-8?B?ZDFBdGYyMVZMZ0U5SlAyUksrYkViVGFxMEtsV0syaUhQVmQ1ZXhrNFZvMUZP?=
 =?utf-8?B?bloyTXhBWk1DQXlWbWQrcER4bExXazQrYmNqV1BiYXk4WTVRZVJJdk1yMTRi?=
 =?utf-8?B?V2lWK3I2cXZpZ2tzSDh6a2V3UXpRN1RqWEJmY0FxZk82MkJhbExDVy8xRUhw?=
 =?utf-8?B?OHFISlEvRnNmb3NscWdNc25TSzAza1gxTTIvYkppdTNRa3I2dlpYazM5dU9K?=
 =?utf-8?B?NjVTd0ovK00xN1ZVZlRKbTB1bVV6Q00vbWxITEVFVFN2eEJ4SnlvYzFBT2hz?=
 =?utf-8?B?MlBJOEdXTXZBTkVWc1NBNGM3d1d6b1BJaFZwOHNPVjFOVmUrQkF0RjQwUDJ2?=
 =?utf-8?B?Ky84RmZ3Qm1WTmE3blNILzNZMGlsRjlmSnQ4cFh1R2Z6WEJKVEE4TGVwQldN?=
 =?utf-8?B?aHdpckRxQzhWcGJNbE9Rc0Qydnl6YVJzeGJvTlBlWEwwTk1tSFdjNVF6SlhD?=
 =?utf-8?B?QVFyWTR5SzdORzNQMXpVZWFleG80OG9yV1R2d05HUyt2MGJHa0VaVVZTcjZ5?=
 =?utf-8?B?QTEyUXNSOUpORGx2WlRxZXptUG11akxzUzROdWlyMlMxZjZOQ1g5VkR5NjRI?=
 =?utf-8?B?SE81bmhIRVVDcGdJRE5QbXZoMi9TMjhWMVFLU2paYXpzRWYvUjBJVmYvZGNS?=
 =?utf-8?B?RFVMRmFyak8xMWw5YldoOEl1ek9Gbnk5SXZiVUFiMmE1WmRHUS9XUjZzYXBF?=
 =?utf-8?B?ak1wSk0zdHppclhDWHQ4ZGo1UTczTU1yMEE2VHIzL3MrTlI4OUpRNERNZVM3?=
 =?utf-8?B?WlRTNGFzdWNEb0p1OG9NbHJaM0FJbVgrM3ZIZFNaalJCVk5YdTlFeVl2TUdi?=
 =?utf-8?B?UjFtNk1nM3FURng0UklWaEx2WEJ4bERiOERrUVdydHJqd1B1NldGZmdmcVE2?=
 =?utf-8?B?dGpscnVRUWN5RTloU0V4c0lNVEI5WGlyTU10c2tPdXJzZzZrYmdXUk5aLzJ3?=
 =?utf-8?B?OWNxNS92cDlHVEVkQVgrdkE4VjFTUFNuTkV3c1NWaU51WlJCSllGN2Q2Rklq?=
 =?utf-8?B?akhtSVdDSmxVb3o1RTNaLy9XMU1xRHA0NTZhc2liUXUxazZXREt1eDdEYTBS?=
 =?utf-8?B?QjEwcDk2VFRKZ3dzdXc3UHNGTjlQSWt3NElhSXdONmlZZzZMUnhNVWNsU05F?=
 =?utf-8?B?T1EwVlpXZ3F2c2RJbC84UUNid1ROTG9QaXJ1NGRwN3V3WjRGRGJ4WlYyMDZP?=
 =?utf-8?B?Sy9RYWJkRUVZWHhnVWFRK2ZraXNnbG1oODVzN1NsMHdySkloRUNLcEpxOWJP?=
 =?utf-8?B?QlNDOXJGcmR3MXRkU2p4VTFFTElJd3hIRXdQdjlqR09jcld0QnZMRGU1QWIw?=
 =?utf-8?B?OStDaEhKMnhDZ0pFbzd0aTlaamVOOG54N0VMYjhiSThiYXNUQ1Fhd21IMnNz?=
 =?utf-8?B?ek96dmFVSDBFMFJkZ2xwaU1JMWhJdXpwMUlveVdWNDhpNStIRnFWMzFIUXgv?=
 =?utf-8?B?eWRIS25RQ1pJSFVpcWhjTEU0Q3FsUGM1NXlzTmNMaVhNUm9jc0YzMEhDUUZV?=
 =?utf-8?B?RWdPbElNbTJKZHNoVFdPaXBhZjN0WW1YcTdYVmNuZFF3a25xaTNZVTRicGQ2?=
 =?utf-8?B?SElrdW9EVU1CSlRnZVUvVXh1S0QyZUQ4REVwZlU0am94ZmFJbWRwZUtyWnF3?=
 =?utf-8?B?ODRNYzdEQUNEQXBBWllQcVdaanVRTUdYaDhPRnVtTkdzenZxVFEwTS9KTnkw?=
 =?utf-8?B?eUdWM1gzREpZU1BLNmk2TGxQMndHWWpET0FkNFpJbkIzRCt4eGlBa0hoV0hJ?=
 =?utf-8?B?UmFWZlhxVDFISVlNdURIaExYUzlMTGZ0OWJaUWF1ODRvdUliR25SdVRWb1JK?=
 =?utf-8?Q?ezHpZu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUMzQnhpWkNmdkpEdy9tcDBKdjhqRHc3cGZqa3o2Z3p3Y1Fpdnc5M0tLbEpI?=
 =?utf-8?B?NWxBSkZORnlWUHFIa0dNdEZZK05jS3ZzS2paZWIxNURyRXFpTEJ6aFA4eXlK?=
 =?utf-8?B?MW9lSzBBcjYxTks1VFlFdWRFQzBISHUwTTU5NnliYnNNMEhzaGlNVjg5N2Rm?=
 =?utf-8?B?cTJEWDhpZXp6Uk85MHo3VlBLcGdrbVY3TWlFWUFaOHlOVmR5MTVNeGZCNXE4?=
 =?utf-8?B?bkQrRTFJVWlLZEE5NGNTMzFPMTR3c0RsWG9pK08yRlRxS3FIaThHNkdWSmJU?=
 =?utf-8?B?OW8raUhpZ04zb3E0UVhUU0lNSnZpYW51RTBWSFdWbG9lVkU2bCtRQkhmdWlx?=
 =?utf-8?B?RzJ6WTJRMlNKS05Jbm5qV0Q2S0hXNTFZdXgwM3dHbUNrOGxiTUJIKzRFRGZh?=
 =?utf-8?B?VTB2R2hqNlBIR2ZCYkcvOTZFWFNDWm5UTHM0Q0dCUkxRZUg3ay9WK09jRXcv?=
 =?utf-8?B?QTF4TWhKUml2azEvam5oOERoQXpyeHpLeVQvYnpSem94ekhhNzd3MG5HS1VP?=
 =?utf-8?B?RjJidzc2V2VrSlhxTlFxTFFBWDQ2U3Mxckt6eUE1VkxxZ1lTRGdLWDBPK3Fu?=
 =?utf-8?B?QlF6Yk5EeWp5Nm5GMkhqWk9jSTBibk9kYTJSOTFFbjlMRE5GTCtPNks3elNv?=
 =?utf-8?B?RzhmVlArZkRya0ZLVGZzQ2F4d2NJWGc1MTdGZmVUbG53WFo0T2tPWFlCYmFW?=
 =?utf-8?B?blhCVzlmKzJ5TGZhWTRXRWRReXZ1TXRSMmZ0VVZ6a2NWUk5OT3BPcnZGV1Zi?=
 =?utf-8?B?OUtuYzFTaFArTk9xbG8vRXJZb1h0TGIvNWpNZGRwR0RJT0doK0pLaFNLcmxq?=
 =?utf-8?B?MGo2Q2s5M2EwZk4yWXNEdk4vRGFzaksxcjZJbHFVK1I3dENjRVpwTDdid3Jy?=
 =?utf-8?B?QnYrUlYyQ0VlUjJFN2IrVHdISzZXcXIxd2ZsZGNVM0ZMdlhmQXVSRmRGdSti?=
 =?utf-8?B?VXZnWkZvRlNVM2Vuc3lCVXZaUWxIOEJnYUJSMktxME96ditzUVNlNU1nV21D?=
 =?utf-8?B?VVB5UkZqTFYvMVh5M2lhRytkbWgrTTRNY2trcmYzcno0WVd2NkhUS2JNVm4x?=
 =?utf-8?B?QXhNNVlTemFEMjJzQm5zWDhkWFlBYm1Uc0VBL1BpNDg5dmIyWXdLREJBY25q?=
 =?utf-8?B?T2RXbVlQTTZlN2NTWG12eHdaOXViNHBQWDJaNU9SalRydHdZVkUrd0plNnpl?=
 =?utf-8?B?WktiRXVVYVhxbnBJKzVGdVllS1YwL0tuVGJ2YmNkWDNCTDgyQzVDV3VvWnBJ?=
 =?utf-8?B?MlpxTUJCYmFRWkNxNU4rejJLQkRtUHJDdmFvSGYzaDk0em0xV0hoMlpoNFZH?=
 =?utf-8?B?c3JjaDhyZnlJcTFPalpYcTJjSGd5S1NUSGI4VUtYN2hHZk9lejlkZ3VWR09Y?=
 =?utf-8?B?b3N1UU4wRmRrZXVLK1E2ZytZUGdvUkxQa1NKQUwwNEVDaExVS0tHRTNETXNW?=
 =?utf-8?B?czZ2T1p2aW5naWFldW5YZjJwd1d2QzNuTUlyejhuRmE5aHd6UmcrN1kxdXlW?=
 =?utf-8?B?T3pYV1UrNitKRnZ5eUtSU281NWVoSDc0UFZ0K0RFZlNBQU45Rk5DMFoyd1lt?=
 =?utf-8?B?ZmlsNGJvN3h6K284bkZ6RUE5bmNpR0Z2cmxKS0crZitGUTM0T2oyZWtEcFpp?=
 =?utf-8?B?dDEwNktDQmFkUDJLYVVTSGVtWmlZbWc0bmVtd1d4WmRKZE1kRjI5bm94b0Q5?=
 =?utf-8?B?RmlrMjRwSHFQeDU2dDViQ1JpOTJidTc0dWJFdWZlcXN5bmVoYldOajFRM2FJ?=
 =?utf-8?B?ODIvSXJoTXpOS2VqbVpBWkVLdVlZYXRwZFh2bUhocVJtNDdaZlZ3TTlWc093?=
 =?utf-8?B?dGg0RHZOWmhhdHJRSzIrWDFwdHZ3eEV5Sm9wVnJnZ2l2VEZMblp6M2xCWS9l?=
 =?utf-8?B?TmF4dXhtbzBkK09tbEl6RUtZVkEwRGNxVGp1OVBYZzRqdHl2YmhReXdkRU11?=
 =?utf-8?B?VkZBbTFzTjFadXR1ckkxNTVGYTNmZk1zQzNHVE8wWGl2alNTTUd0aWIyYVBs?=
 =?utf-8?B?c3lHTHlCc0tqS1hVWUcwTHUyb2NWenNBUzZhT3p2ZEorNWQ3Q1AvMXVxalhM?=
 =?utf-8?B?NlJsUHMxaTYrUGtuVTVZZjg5MFR1c2ZSV0gxQXcyV2tQT05Qelh3dXZKYWht?=
 =?utf-8?B?R0t0bEZDcERnYTBkNHZkOXZxblYrZm94MkZqdjUveGlkL3hiVTZieFVaT2E0?=
 =?utf-8?B?V2QzSWRkMnRwWXlPMDFtYVJPNXZTQ0tnNm1BUExPVFYzL2dlYjkyZEZHcUhZ?=
 =?utf-8?B?L3V5SGNoZEl6R2czNUEycXN4NlpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE6C6B04A7B56F4DB42D82133AE5892B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9f8571-e41d-4ab5-8c71-08de1012824e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 19:54:41.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwUnHU4AIMsp5ZtRd4WB2M33o+IkBGToMY9JjBZe+0OtTYP5AWdocg13Woww4PfBm7amR7miJ2rjvlFlqgvilI2E7xqkXPomsqpampgbAug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE2NSBTYWx0ZWRfXyR++Tgbzdmf8
 BJOnA7gRCeiDyxj7ZSLDqNZc4ei0OuGzcXpjD7hEYRrWrgAM4Fzh2dlD8xujuvQw853fI234haq
 PY5tfvfOvDE6O6rFmi5IhW7dKdZU+yM28Ho3dD1sGan56X7eAv/25+s0NITKaov7uvCbfbfgdA6
 EuxWPAEJY2y2jWdOkq+QaigybSU4F8Nqx8CtKVhphqD59TTG2NvjV3E/2BTdjCVOoKNqfncZJuK
 SYX07OtCajxqa9qWcYdvheBUo604pToK2F3gUl/T/gGlBlRoDX3iqeWC9UWeJmXDV/GFVgppR7H
 XZzpoOO7S3qYfx0CjHxoXibDa0AxdfaZdHi3YSeu6ln5LtjhBLsbpIFtg0qxDA0rVxO9GcelubH
 cJ7fPoPQG92vfe1cEv2GYVa+qpMmPw==
X-Proofpoint-ORIG-GUID: DunTzBWfxdq17T7DlGLQJvwJZTVdh8r6
X-Authority-Analysis: v=2.4 cv=Pv2ergM3 c=1 sm=1 tr=0 ts=68f69383 cx=c_pps
 a=JvsELR4xF/cD9QySNJCEFQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=lghBlkUemMxyqEPaK1oA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: DunTzBWfxdq17T7DlGLQJvwJZTVdh8r6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIwLCAyMDI1LCBhdCAzOjQ04oCvUE0sIFBhd2FuIEd1cHRhIDxwYXdhbi5r
dW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiBU
aHUsIE9jdCAxNiwgMjAyNSBhdCAwNjoxMjo0OVBNIC0wNzAwLCBKb24gS29obGVyIHdyb3RlOg0K
Pj4gQSBWTU0gbWF5IG5vdCBleHBvc2UgSVRTX05PIG9yIEJISV9DVEwsIHNvIGd1ZXN0cyBjYW5u
b3QgcmVseSBvbiB0aG9zZQ0KPj4gYml0cyB0byBkZXRlcm1pbmUgd2hldGhlciB0aGV5IG1pZ2h0
IGJlIG1pZ3JhdGVkIHRvIElUUy1hZmZlY3RlZA0KPj4gaGFyZHdhcmUuIFJhdGhlciB0aGFuIGRl
cGVuZGluZyBvbiBhIGNvbnRyb2wgdGhhdCBtYXkgYmUgYWJzZW50LCBkZXRlY3QNCj4+IElUUy11
bmFmZmVjdGVkIGhvc3RzIHZpYSBhIENQVSBmZWF0dXJlIHRoYXQgaXMgZXhjbHVzaXZlIHRvIFNh
cHBoaXJlDQo+PiBSYXBpZHMgYW5kIG5ld2VyIHByb2Nlc3NvcnMuDQo+IA0KPiBCSElfQ1RSTCBp
cyBhbHNvIGV4Y2x1c2l2ZSB0byBTYXBwaGlyZSBSYXBpZHMgYW5kIG5ld2VyIHByb2Nlc3NvcnMu
IFdoeQ0KPiB3b3VsZG4ndCBpdCBiZSBleHBvc2VkIHRvIGd1ZXN0cyBidXQgQlVTX0xPQ0tfREVU
RUNUIHdvdWxkIGJlPw0KPiANCj4gTm90IGV4cG9zaW5nIEJISV9DVFJMIGhhcyBhbm90aGVyIGRp
c2FkdmFudGFnZSB0aGF0IGd1ZXN0cyB3b3VsZCBkZXBsb3kgdGhlDQo+IEJIQi1jbGVhciBzZXF1
ZW5jZSB3aGVuIHRoZXkgY291bGQgaGF2ZSB1c2VkIGNoZWFwZXIgaGFyZHdhcmUgbWl0aWdhdGlv
bg0KPiBmb3IgQkhJLg0KDQpZZXMsIEkga25vdywgYnV0IGdpdmVuIHRoYXQgQkhJX0NUUkwgY29t
ZXMgdmlhIGEgc3BlY19jdHJsIHZhbHVlIGNoYW5nZSwgaXQNCmhhcyBhIG5lZ2F0aXZlIGVmZmVj
dCBhdCBhbnkgZ3Vlc3RzIGxpdmUgbWlncmF0ZWQgaW4gdGhhdCBuZXZlciBBKSB1cGRhdGVkIHRo
ZWlyDQpndWVzdCBrZXJuZWwgdG8ga25vdyBhYm91dCB0aGUgbmV3IHNwZWN1bGF0aW9uIGNvbnRy
b2xzIGFuZC9vciBCKSBoYXZlIHVwZGF0ZWQNCmJ1dCBoYXZlIG5vdCB5ZXQgc29mdCByZWJvb3Rl
ZCBhbmQvb3IgQykgaGF2ZSB1cGRhdGVkLCBoYXZlIHNvZnQgcmVib290ZWQsIGJ1dA0KdGhlIEJI
SV9DVFJMIGlzbuKAmXQgYWN0dWFsbHkgYXZhaWxhYmxlIGJlY2F1c2UgdGhlIHN5c3RlbSBoYXNu
4oCZdCBjb2xkLWJvb3RlZA0KdGhlIFZNKHMpIChzZWUgY29tbWVudHMgYmVsb3cpLg0KDQpJbiBh
bnkgb2YgdGhvc2UgdGhyZWUgc2l0dWF0aW9ucywgc3Vic2VxdWVudCBndWVzdC9ob3N0IHRyYW5z
aXRpb25zIGJlY29tZQ0KcGVuYWxpemVkLiBOb3csIGZyb20gYSBzZWN1cml0eSBwZXJzcGVjdGl2
ZSwgdGhhdHMgaXJyZWxldmFudCBiZWNhdXNlIG9uZQ0KY291bGQgc2F5IHRoYXQgaWYgeW91IHJl
YWxseSB3YW50IHRvIGJlIHNlY3VyZSwgeW91IGhhdmUgdG8gZG8gdGhlIHdvcmsgdG8gbWFrZQ0K
c3VyZSBhbGwgdGhlc2UgY29sZCBib290cyBhcmUgZG9uZSwgYnV0IHRoYXQgaXMgZmFyIGVhc2ll
ciBzYWlkIHRoYW4gZG9uZSBpbiBnZW5lcmFsDQplbnRlcnByaXNlIHZpcnR1YWxpemF0aW9uIHdv
cmtsb2Fkcy4NCg0KTWVhbmluZywgKmlmKiBhIGhvc3Qgb3B0cyBpbnRvIGVuYWJsaW5nIEJISSBh
dCBhbGwsIHRoZXkgd2lsbCBwZW5hbGl6ZSBhbnkgZ3Vlc3QNCndvcmtsb2FkIHRoYXQgaGFzbuKA
mXQgZG9uZSB0aGUgd29yayB0byBkbyB0aGUgcHJvcGVyIGVuYWJsZW1lbnQgY292ZXIgdG8gY292
ZXIuDQpMZXNzIG9mIGEgcHJvYmxlbSBmb3IgaHlwZXJzY2FsZXIgd2hvIGNvdWxkIGNvbnRyb2wg
d2hhdCBsYXVuY2gvd2hlcmUsIG11Y2gNCm11Y2ggaGFyZGVyIGZvciBub24taHlwZXJzY2FsZXJz
IHdobyBtaWdodCBsaXZlIG1pZ3JhdGUgaW4gZXh0cmVtZWx5IGxvbmcgdGFpbGVkDQp3b3JrbG9h
ZHMgdGhhdCBmZWVsIGxpa2UgYSBmZWRlcmFsIHByb2plY3QganVzdCB0byBnZXQgYSBndWVzdCBy
ZWJvb3QsIG5vdCB0byBtZW50aW9uDQphIGd1ZXN0IGNvbGQgYm9vdC4NCg0KPiANCj4+IFVzZSBY
ODZfRkVBVFVSRV9CVVNfTE9DS19ERVRFQ1QgYXMgdGhlIGNhbmFyeTogaXQgaXMgcHJlc2VudCBv
bg0KPj4gU2FwcGhpcmUgUmFwaWRzKyBwYXJ0cyBhbmQgcHJvdmlkZXMgYSByZWxpYWJsZSBpbmRp
Y2F0b3IgdGhhdCB0aGUgZ3Vlc3QNCj4+IHdvbid0IGJlIG1vdmVkIHRvIElUUy1hZmZlY3RlZCBo
YXJkd2FyZS4NCj4gDQo+IEkgYW0gcHV6emxlZCB3aHkgQlVTX0xPQ0tfREVURUNUIGlzIG1vcmUg
cmVsaWFibGUgdGhhbiBCSElfQ1RSTD8NCg0KQmVjYXVzZSBCVVNfTE9DS19ERVRFQ1QgKG9yIGFu
eSBvdGhlciBmZWF0dXJlIGZyb20gY29tbWl0IFsxXSkgd2FzDQphdmFpbGFibGUgZGF5IDEgb2Yg
dGhlIFNQUiBRRU1VIG1vZGVsLCB3aGVyZWFzIEJISV9DVFJMIHdhc27igJl0IGFkZGVkDQp1bnRp
bCBjb21taXQgWzJdLiBUaGF0IG1lYW5zIGFueSBWTU0gdGhhdCBhZGRlZCBTUFIgc3VwcG9ydCDi
gJxkYXkgMeKAnSBoYXMNCnRoZSBmZWF0dXJlIHNldCBmcm9tIFsxXSBhdCBtaW5pbXVtLCBhbmQg
aXQgYWxzbyBtZWFucyB0aGF0IGlmIGEgZ3Vlc3QgVk0gd2FzDQoqc3RhcnRlZCogb24gdGhhdCBR
RU1VIHZlcnNpb24sIGJ1dCBuZXZlciBwb3dlciBjeWNsZWQsIGl0IHdpbGwgbmV2ZXIgc2VlIA0K
QkhJX0NUUkwsIGV2ZW4gaWYgaXQgaXMgYXZhaWxhYmxlIHRvIGJlIHBpY2tlZCB1cCBpbiB0aGUg
bGF0ZXN0IG1vZGVsIHNjaGVtZS4NCg0KSSBjYW7igJl0IHNwZWFrIHRvIG90aGVyIFZNTXMgKGUu
Zy4gdm13LCBoeXBlcnYsIGh5cGVyc2NhbGVycykgYW5kIGhvdyB0aGV5IGRvDQppdCwgYnV0IEkg
c3VzcGVjdCB0aGVyZSBhcmUgc2ltaWxhciBjaGFsbGVuZ2VzIGFyb3VuZCBwb3N0LWxhdW5jaCBm
ZWF0dXJlL2JpdA0KYWRkaXRpb25zIHRoYXQgcmVxdWlyZSB0aGUgVk0gdG8gYmUgY29tcGxldGVs
eSBjb2xkLWJvb3RlZC4NCg0KWzFdIDdlYjA2MWIwNmU5ICgiaTM4NjogQWRkIG5ldyBDUFUgbW9k
ZWwgU2FwcGhpcmVSYXBpZHMiKQ0KWzJdIDEwZWFmOWMwZmI3ICgidGFyZ2V0L2kzODY6IEFkZCBt
b3JlIGZlYXR1cmVzIGVudW1lcmF0ZWQgYnkgQ1BVSUQuNy4yLkVEWCIp

