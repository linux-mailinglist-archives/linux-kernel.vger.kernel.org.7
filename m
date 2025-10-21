Return-Path: <linux-kernel+bounces-863148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673CBF7219
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F904485E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A3E33B957;
	Tue, 21 Oct 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bqW4nxh+";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="DR/cGF/U"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FF226D16;
	Tue, 21 Oct 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057589; cv=fail; b=b0d7u50ezqt1mEmVt7e+m4JbrrrEBUk5fntszSUKseHPsTBtXvp27h6TcRcQ2FFnUZNIoZMbpJssuTjWVBfyxtGkeJiMAm460MQPgIetX6IYo1mEKxK84/EblBLyJnCSRzYCLwgn69IVgFk81MtP5p6B5VIroMEnVutbaJ1sJ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057589; c=relaxed/simple;
	bh=+YqALSATaSIxN5fDi4T27ILBIIIsPmdeZlK9ntrONAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X9OddnimtFsNBTfcRS53px4ll7vHdXXgsBlKgv+4qZAjARnyLOARLo8P8UPewwtom3gQofwgviFrd+PUGOMmZFDDhetICdmreXdzlTAqR6pbZyXo9izx8aFu2ib/J/JNLkZzgcWs6l5rx/04tJL9KPfvCDPVMRgTA7rdlBR9DgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bqW4nxh+; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=DR/cGF/U; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59LE0kH9175305;
	Tue, 21 Oct 2025 07:39:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=+YqALSATaSIxN5fDi4T27ILBIIIsPmdeZlK9ntrON
	Aw=; b=bqW4nxh+VP7p6FHWXLrXt6bY9/vSPmYWcEcNXVZ7pRJcXo7fZWyr3USg/
	30DMDryDXoViCFznf3EiVhWYdd5xn3cHhzG6XqC+HZE9ChtfBJB1PVU3n8k0SGfx
	TORKmqtmRScAUsPoryffazCcRM7+l5UfBNkq+XREUyUxU7SMiaZerpuSemOMb1s3
	hJ8P3cIZ3Su0JMdulBKIyZGXPmTHFugIZ4/Bswie4I0vRatJzKJuzhs32LzCbqpx
	DZy547zJZd+5ujWnVWR+YwI7U8vhEguaQKXxGWG5NFCHIbeqbC2hQuFo/wCavrlk
	+ZXUSZBajOX4sC7xWe9Tt5Aid+FMg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023129.outbound.protection.outlook.com [40.93.196.129])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49wvmssjcn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 07:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYiUuj2FkrligpFnaejtql1CWJW7zZa0M/VgcoNdyXyvbpQvmT4SqwWJslRVtGy/nAupewz2WyPIRlKEY/nZLURpbPQf4gEvWS04wSxI9TifvioU2nNbvlCOM4v4EZk2r9UHVxi0lKfcNgRHuWcNoGoYZvaPTcqkf0xvOKlxVFiGbhqQYAvWnsJJnMV75nIdmg4EkRt0ic49Amigdv+At6ujEbhjELPwM68aAap3QSUhhsLcrJ2Nk2g14XL6zdnzvedex+vkuSaoC+rVS04DhnsUDPxpG+1jq6l06E7c/DxzVkh6xKak9PwjZYArglquPcCx/OG1NvkYSQT+LDax0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YqALSATaSIxN5fDi4T27ILBIIIsPmdeZlK9ntrONAw=;
 b=f1Cij+0svnDDjCGahR0SMkc4KkZi7r9bzzaNPS7SA8W4d9GcGTEDai1y/mjxjrFmfTHxqij3j606aGaiq4IWg2MDETdWWJ1At9aDgTVPwdmuozLvSt6VgY1kZyJ5P6LK7+IGr2Cliuz0TZ9lvvPmnqjmw9CyIieKX1fwH9r84JRq4jHekQnCANFmbtvt9eyVfrxSBAHE2qufgFVQsogNxGNd5CgHuEJ7fi2hXjUtZgkKyaeiGJa6t5hQ4vN/LzI0sZwpfFBNQQIYFZ4xWk/a2O4M3jlpzMJGs7H1fRyi/QR/7I5N2sLjvtB588/RwcP7bKCgvhLgY23D0tfpkE+6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YqALSATaSIxN5fDi4T27ILBIIIsPmdeZlK9ntrONAw=;
 b=DR/cGF/UiPY9Nu032VjSQjpS5okUpVPQ1iI5zsjr6opKgjbyPCAmL8l01vKj0m25T3U+RI4ufLTe7cMMRvWQi/KSpuAHq77+T60alNDwXB5w29+GePSojRRvSA3Let8yUkz5iH4cHz3iH5daV4yVnHCLA4xtW5Ot588YL1ADrLi+vlkZIGQjII5H3kz++dXiMaeO6g4/LzN9XdbM2uhwuSS6vvsNiRFesmKDWTr9foIl/gn2iesTffW6OGbiqH0Cex29LFcof9iSrzD0yFZ6qUOe3eigDspILlnkXEt3mbWFlICdNI097r/m6hGFtQOPLwcK+Wp6VQXaKftycV4Mhw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CH8PR02MB10814.namprd02.prod.outlook.com
 (2603:10b6:610:2b6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 14:39:15 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 14:39:15 +0000
From: Jon Kohler <jon@nutanix.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
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
Thread-Index:
 AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLdggAgAACrgCAAAzWAIAAGO+AgAAJB4CAAPrcgIAABhCAgAAKfAA=
Date: Tue, 21 Oct 2025 14:39:15 +0000
Message-ID: <883EDC14-1A26-46F4-B9E9-C75A6DF07195@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
 <20251020204026.a7xuhnagsqo4otpx@desk>
 <225134fd-033f-4d63-b88c-772179054694@intel.com>
 <20251020224159.xkhfs3phai5o6rzb@desk>
 <1D952EBC-CA16-49FE-8AD0-48BCE038332B@nutanix.com>
 <73a22a19-c492-4a75-8352-a4cfac47d812@intel.com>
In-Reply-To: <73a22a19-c492-4a75-8352-a4cfac47d812@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|CH8PR02MB10814:EE_
x-ms-office365-filtering-correlation-id: ea7be4e1-e23b-4902-20c7-08de10af9bf1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlJFN2taZU55ZjJYb2JJQ1Z5Q1VUK2VXRDFYRXBGYldHUGpVT2NNZ3R0V0dk?=
 =?utf-8?B?dHZWcE1ma3E3L2ZMN3lYQlBhUEpCTGJNKy8yN2xmNlM3TlZCLyt4dUcrK2Ra?=
 =?utf-8?B?elZzcW1LL0NuT1Z3RHA2U0YzMFRUOHFpTHlKaXVRV1dqQTNXMVFRQW5EN203?=
 =?utf-8?B?SzNGSlZZenFHY0ExcENuQ3RONFR4WGZHUlpqUE1TaHFrbDZ5WlUrSDIzUjRF?=
 =?utf-8?B?VnlrUmxxazFoZC84N0l2U2pKeUo3dm1jMEJKcXo3aXBNVFRkRW0rUkIzUHFN?=
 =?utf-8?B?ZmRtQ2hsOHpON0hyYWNDSTBNcFY5dFUxZ2J2T1p6SlBUK1l3dmIwaXJEL2Fw?=
 =?utf-8?B?YUNNRlo1WFZkSXkyN21ZSjBvMjFHUy9OVUFCbk4zVEEvTTc3QldydFc1ajFh?=
 =?utf-8?B?VmhHbE1RVG90ZS9DSlphdzZFY1RpeXJ5VWxGcUZMRGkxLzI4YWpFSzRJS0gw?=
 =?utf-8?B?UzBXcExFS08rRkZGZEdKUXJYWUk1aGJ4NVAyTU5wMTdidGNyLy9YQW5oYkR3?=
 =?utf-8?B?bTR5SmxCV0o4UGNNR3QzY3R1SldqNzRCYW91NTZ6OGhuWERucmlOL0JEMlpx?=
 =?utf-8?B?UTBNZWNsa3BjTkVlNm1hVkpZeVpyTko3Y2pLbjIxVzNyeERhaXB5SzB1NGEx?=
 =?utf-8?B?WFAwK2thSnFId2hDL3pCbmlDZG1kaUVEMDdTbWhjZWQxTVVXOEppSDloQWhU?=
 =?utf-8?B?VlZWeW8yTnk5NFdhUHc5a2lyS2dQUkdpMnpad2k5ZzBZSjZLMk1vVXdnU2NP?=
 =?utf-8?B?bHFtWlpqbFlBSktuZkdyTjRieXR3YkpjWEsrRGJoVlRwUE9xbkNNTWlWUVI1?=
 =?utf-8?B?MllJTmd3VHRtaTRMWndIZjZCa3Y0bnR2ME9SbUdlbkpPOVFJd0tkZ0pxOHNJ?=
 =?utf-8?B?eW5CZm52VHRmUXFWdFZ3QTQxMWtyYUE1SXBOOUNOaFk1ZUkwZXNYODVUN3Vj?=
 =?utf-8?B?dVEzNk56c29GMVBRb29QdHllQ2JyanBmRTMyNG5XOVBZV1RFd0hNeUdkSTEx?=
 =?utf-8?B?ZG5jSzByTmNIQVByRE9EMzRCUkY5bDIyQ0oxM1p3VGEySllKeVUzMUtQWFRn?=
 =?utf-8?B?RVNjWmtpTnA3ZTV6VjE4bHZ3cHppWVQvWjEwZm8wbEE3Q2ExRVJaVGQwcWla?=
 =?utf-8?B?QWVlejhOdUVPRy94elU4V0lyeXFadDdJN0dvNFFOQ1BkcE5mMzVhMW10SUxZ?=
 =?utf-8?B?aTdhQUk2c2lPUVIyditnaWx4a21yNWRtV2VIdkIvZW5OYXNQOVNaMEhxcUNX?=
 =?utf-8?B?Qnhid3pTSTMyb3pCTzlqWTZMRWN4V3FnSi84VVdjL3VyRlZqcDM1QmxQNkRZ?=
 =?utf-8?B?aEt3N2FqTXhNMWc1aTlhMEdYaWs3R0Nlby9xVDVZek1qNkkzR0NLSU1qRURs?=
 =?utf-8?B?YkxKWEM4OG5vRFhzckRpTUdPMmJtUXZlbnd1bUxIbkVuV0p4ai93RFUxUmpP?=
 =?utf-8?B?RGJZWndHSU0xYkFSTlEyM3FDU0dGdFE0UWZJSld5SHhCWU1MelFXRmlsTCty?=
 =?utf-8?B?YjNsK2pOc3dLbkZQVkhNZmNPcU5Jc3ZYRHQyQTVqT3VRYmU3WXphWW1TK3Yw?=
 =?utf-8?B?YVdGQmk2SWxlbDNIdVZGcWVyQitIVERIWGFBNEJYTnc0MFA2Y1NLTUFyNWRK?=
 =?utf-8?B?V0ZDTVQ3TVNvdzNjcW0rdmVCNEVKZFU4S1N0bnc4SzBhbGRoaCtSUldDWlVN?=
 =?utf-8?B?Z1ljblNKSGhQN3hlbDhtTERjcXNpbHVzT3A4MU42bE9tVnFTYi9ERTFKVWxv?=
 =?utf-8?B?RWFTcVlWUTVZWE9QdmlXaFV2SXo0VjBZcHZyaXJ3c0ErVGRvdi83YXZTUVBs?=
 =?utf-8?B?TFROMmFwbkxGeUhqenAvN29vdE1zb2RkeTBoVWE3aGtHbUo3aUJEQlVKLy9q?=
 =?utf-8?B?a1A5Mjg1eE9uNGs3QW95Wk9YNE9EZzBZVFlRYW5xNnJXT1o0bVg5bVZqaDBW?=
 =?utf-8?B?ZnZtYTVWbXNLRmxlVjlIa2srTmRIVEJhRG5wWmVyN0dHUDMvcDJVWjZEZlph?=
 =?utf-8?B?MHM3b2lNc1VSYlFlOWl2WS9WcXJaczhDY3V2UjdMTW1ta1IxSjlRZjRETzJk?=
 =?utf-8?Q?sV4NJZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEdxek14eGx5TWFZZUdPZU84T1g2UGY5d2RpdkpNa3EwSjZFOE1BVXdWcm45?=
 =?utf-8?B?ajlJVndWL3g0OWx6UnVxcWVnNTRoS0NGVS9oejN2U3Vpd1c4ZTZ1TWJzN00y?=
 =?utf-8?B?ckVGMjNSVEZrLzI0bVhkU0NxWnN6aEZtSlpYM2h6VlhMdTIrbGxsWFJia1hB?=
 =?utf-8?B?ZERaeWZPRUs1TDdGeUtONjB2WUwrNUo2NU50Tjl5dWlGRlhQU0ZNOXJLNjdu?=
 =?utf-8?B?RTJOc3ZyNmx6L3pkWWEyUmFWKzhySFJINzFvdVVmWlozMnloZ3JlUTB6ZUdC?=
 =?utf-8?B?VXU3Z0FTQ01zbHk1UUlyWlh6dG96QXZsa0lHdmJHeC8weUlkaUJRL2QzUjlU?=
 =?utf-8?B?MUpETm5BTEhiNkl6YUVWc1NuRkc3WVRScGJhOStPR1hNQTFGeVg5NnF0WFh3?=
 =?utf-8?B?Q2l1SGcyYXFYT1VoNWVHNjlrSDBEOVB2aG91d0NlTU1OblRDQ20welc3NnRM?=
 =?utf-8?B?Z1RkZkVVT2wwM0VYRHVsSk5ZVGJxQkRwOTZ0UXhNbzA1OUZSb3FFTEhUM1Na?=
 =?utf-8?B?cmtrZnh3T3hIcytjRHpXOHJJN01la0E1SWNSY2IwWUp2RUF0WHJTSVVmT2Zl?=
 =?utf-8?B?L1FvaWVoQnBXTVVucGlIMDArZ0FLcE4yMmV0c3NPSHRIYm16ellybFVFbWp1?=
 =?utf-8?B?ZnpjUnpUQ2w4NmNGYWNRa2RZTE1HdGJlSTMxZUdmTmdlQTdhUnkvcDR0bTFD?=
 =?utf-8?B?blRyNHgrTHUxN3h3aHhLWGd1WFFWTjV6eWh4ZFlVS0d0SU1VNmJadGFVdExS?=
 =?utf-8?B?NUZsS2U0d1VaYmxPYkFBYVV3M0pRNkVId1dtckdPUVkyTXBlU2w0SWQ3cFBu?=
 =?utf-8?B?aG54SGdES2JmUHU2VDU0UHQ0Y0tSeWhtbFQrZ0tHbGx1QkVJS21zcVNFalM5?=
 =?utf-8?B?K0ljS0NGQU1nUnUxdW1XZWZSNkJsVGpoMk4wSzFVbDN6bUtZVHdQZTVhaVNN?=
 =?utf-8?B?Y3QxT1cycXBUcFRQTXJ3UG8vK2lIVmtIYXowNmlqSXJVTDIvVW42QmtYTkJN?=
 =?utf-8?B?d2ZuR09UZzJ4dzRiMGZ4ZVdUMmhQZFh1N1laOUI2a3NCYUpGUGppYkNpMWdV?=
 =?utf-8?B?QTNSbmp4M3Rmckd2dlJDaWVnM25XeHRSVHE3bHRIT3R3MVF1RG5NTlJhUzli?=
 =?utf-8?B?aFh5VmoxdFBYSmRYTlJYR3hWK2NPbkdZVyszQVowMHRoSDlqTzVnbTRxZWpn?=
 =?utf-8?B?aTlsREphUkNieFluaFAzN1pnQ2pYNkxGZDNzSFJxMGNOWGhlTGNVYnM5ZHJy?=
 =?utf-8?B?UmE4TmNYRHhKSEk4aVNQS0lXUjlGRE91Z2MwYjg0YUJUaVZEMElEWlJlNWwv?=
 =?utf-8?B?UmJWbVQyTytGd2RWUkNDTXY5MVNVS0grcFRzVXVuQUdQU1lPVmppRkhKTldx?=
 =?utf-8?B?eXZ4LzRVUEdtSUxoWXdINEl0ZXRyK21GdXVRcWRUczUrbWZ3OVg5Z2l4MjZy?=
 =?utf-8?B?Ykl3cWhLUXVOMitNL0RLNXhsNll2cWZlWWRWdXN0cnJZMzRWMThJQnc4dnEx?=
 =?utf-8?B?N0RwOVNUQ25QU05qU1MyZ1J1bm45S3RuQXFDUjJWUnRhSVpjL1FsaEZCUS9W?=
 =?utf-8?B?QkFFK3c5RjczTDZpYXRzYXJCNUh1V01DTitwTHRFcCswQjBFSG5pV056YlRC?=
 =?utf-8?B?a0JGWHFMQ092TU9SVUo0Um5ZV3NhTGtGaUF3MWZjdEpQcVJDUHQ0ajdTNG55?=
 =?utf-8?B?M1pvTTROUElyQ0NrckRtbmNZQ3QySzZheHBtaS9lcGtBd0taNW55YnJ6KzJn?=
 =?utf-8?B?OEh6UUFENDlhTzE5aHJIWkg3QVlsYzZ4OTI5MnAwcVc1cjVyaWR4SHlRUDRI?=
 =?utf-8?B?dmFFNWZHaDBheEE3Q0RUZjNLYUJ4UFlMVDc3YVZLRkxhai9QNzhUODVxbkhK?=
 =?utf-8?B?SVBwbU9EamQ5WHE4d2RiZW52aytWZHdpUy9pS3hPbXNXNDI2WTNzZmdGSkVK?=
 =?utf-8?B?dG9pcTJBRnRwSllRTmNmYjVqWUFWN2YzelJaZUNhSGVaQ3lLSnB2M2h2RHB4?=
 =?utf-8?B?aEMwanRYdVNvdS85T0VUeE9jdWQ4YkswWldBblJSS3VnRHVxdWsyN2tqS2F2?=
 =?utf-8?B?Y3pOcFhZaTJNanEwSmNuT3Y2M1F4WE5pc2diQW42OHY1V1JBL284ZG1iUlpm?=
 =?utf-8?B?czRUQUdLazJVSERTZXR0N291ZVpPV3FUUVdxWkNUc0RHMjYzUFNNWWNwV1Qv?=
 =?utf-8?B?OUhHUUdoMmoxSzFnU0dHQjArWndhcVozRThOeEhkbDE0d0xqQ2ZCeTZHekZh?=
 =?utf-8?B?V01Yc0RLWHgxeTc0Yk1ackxYQVF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51C27492AF5CB84B9533C81D636A5E75@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7be4e1-e23b-4902-20c7-08de10af9bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 14:39:15.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBRqQKSEaGNKsLfgM4Cc6dPctG61PDyvJq73WHPfThkEjd/EOoOzq51Sc8iDqMrDnJV34D3nVcwWuh93O2TBSJq+YSij/b9PZ11DH1XOMXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10814
X-Proofpoint-ORIG-GUID: 8DzgnNGD4htRvJJ2RPWfOKShkPAvdHcC
X-Proofpoint-GUID: 8DzgnNGD4htRvJJ2RPWfOKShkPAvdHcC
X-Authority-Analysis: v=2.4 cv=HK3O14tv c=1 sm=1 tr=0 ts=68f79b15 cx=c_pps
 a=R6SrqWxOsMs7v49b6WFfjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=oHNdqyhEmsPgQ3YdZ4YA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDExNCBTYWx0ZWRfX+H4SVM8IxXwt
 B4q1kHQsRZSTcrb7nJGJq7fSonn38iamlsBjli1Wom8d1g2/DLnJkxDQf1Rv1uKqGmP8BBQkqfg
 LI+1swIajkjoNfqIaEZ2F2fC74NqR2lNqbqL8pUKzhstd9O1iXwWa2dCPNi4J+y+g5nATSF+Fn0
 mLZBqeKXPaDjCWQ/v68tmYIWUMv1XX0B18yR6mBPKfHvw6rynztemxIODHEIWgCHj8MsdAvRJvv
 N9XnMqfvMijBumBYtJqTs6KOvDmWCbEpyYF1Owq0nNqOZitTwyCaXS37yWvTccLBh6bCeywfmVA
 iacg64vLRPjggoyoxewMzUxF/kBOYdzhWXg9YVDa2Q3cpJ/Y/CD/lEtkT3BVpDEefCAs1GAoq31
 Atp8C9VgcGo1Ozgyud6bMn/25Tt9zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIxLCAyMDI1LCBhdCAxMDowMeKAr0FNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5o
YW5zZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gMTAvMjEvMjUgMDY6
NDAsIEpvbiBLb2hsZXIgd3JvdGU6DQo+PiBTbyB0byBzaW1wbGlmeSBpdCBkb3duOg0KPj4gQSBn
dWVzdCBWTSB0aGF0IHVwZGF0ZXMgdG8gYSBJVFMtZW5hYmxlZCBndWVzdCBrZXJuZWwgc2VlcyBw
ZXJmb3JtYW5jZQ0KPj4gaW1wYWN0cyBvbiBub24tdnVsbmVyYWJsZSBoYXJkd2FyZSwgd2hlbiBy
dW5uaW5nIG9uIG5vbi1CSElfQ1RSTCBhbmQvb3INCj4+IG5vbi1JVFNfTk8gaHlwZXJ2aXNvcnMs
IHdoaWNoIGlzIGEgdmVyeSBlYXN5IHNpdHVhdGlvbiB0byBnZXQgaW50bywgZXNwZWNpYWxseQ0K
Pj4gb24gUUVNVSB3aXRoIGxpdmUgbWlncmF0aW9uLWVuYWJsZWQgcG9vbHMuDQo+IA0KPiBCeSBu
b24tJEZFQVRVUkUsIGRvIHlvdSBtZWFuIHRoYXQgdGhleSBjaG9zZSB0byBub3QgZW51bWVyYXRl
IHRob3NlDQo+IGZlYXR1cmVzLCBvciB0aGF0IHRoZXkgYXJlIGNvbXBsZXRlbHkgaWdub3JhbnQg
b2YgdGhlbT8NCg0KQm90aCBjYXNlcyBhcmUgdHJ1ZSBmb3IgUUVNVS4NCg0KRm9yIElUU19OTywg
aXQgaXMgYW4gYWxsb3dlZCBmZWF0dXJlLCBidXQgaXRzIG5vdCBwYXJ0IG9mIGEgUUVNVSBtb2Rl
bCBieQ0KZGVmYXVsdCwgc28gdGhlIGhpZ2hlciBsZXZlbCBjb250cm9sIHBsYW5lIHdoYXRldmVy
IHRoYXQgbWF5IGJlIHdvdWxkIG5lZWQgdG8NCnNwZWNpZmljYWxseSB0dXJuIGl0IG9uLCBpdHMg
bm90IGF1dG9tYXRpYy4NCg0KRm9yIEJISV9DVFJMLCBkZXBlbmRpbmcgb24gd2hhdCBRRU1VIHRo
ZSBWTSB3YXMgb3JpZ2luYWxseSAqc3RhcnRlZCogb24sDQp0aGUgZ3Vlc3QgbWF5IGhhdmUgYWNj
ZXNzIHRvIFNhcHBoaXJlIFJhcGlkcyBtb2RlbHMsIGJ1dCBCSElfQ1RSTCBtYXkNCm5vdCBoYXZl
IGV4aXN0ZWQgaW4gdGhlIFFFTVUgc291cmNlIGF0IHRoYXQgdGltZSwgYXMgdGhvc2Ugd2VyZSBp
bnRyb2R1Y2VkDQppbnRvIHR3byBkaWZmZXJlbnQgdGltZWZyYW1lcy4=

