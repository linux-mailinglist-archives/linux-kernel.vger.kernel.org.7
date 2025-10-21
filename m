Return-Path: <linux-kernel+bounces-863260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F5BF76D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217F83A8F08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30A12877C3;
	Tue, 21 Oct 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="m0E1iFC6";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="gEG9Rlbi"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A079233375D;
	Tue, 21 Oct 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060973; cv=fail; b=fKf+StafE+rcH2RcbOJJlZJU+COz7wCPgiEqdz5sr5wljuLr43zZnxFgfk2pJ3r5PXoGpkWeahqdexj4OHoycpjrH5CzOz5dDlIxQBHhDRGZibN2rmgHjYqiCPZutyZXcUipi8EXD8tse2BFqR7BtbaUHjxu3WeY6mrQ9Ns0jP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060973; c=relaxed/simple;
	bh=aD/AmrFN1W3PMAwTU61mP2XPeqCsR0LRcY+ERiNGWAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NcJUidmvroJx9CvXrk+UK6ypuGe5U/yPSWlTZuNZ7RLjAEd4trm12rqdtBdHz1RW7TRgNJulj9q/E/4duODpyRFjvTmprXP7p4qE1aMUyqFC+lXU4HpgfdoW5KwG323+c65nnBh6iJd2HbAIC8Daf0C/5tR92h8CatFZ5g0Xqpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=m0E1iFC6; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=gEG9Rlbi; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L1NSuI224449;
	Tue, 21 Oct 2025 08:35:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=aD/AmrFN1W3PMAwTU61mP2XPeqCsR0LRcY+ERiNGW
	AI=; b=m0E1iFC6GPLH4nWSy3EZDtY5yf1CIxG0UZIMQMGm3hVwlP+UR1IAntJxI
	pxl++uk+R9EnlnjIZjSrwooaefp0LyRQGh+v7A4pRB8WfNdXaxtA0vnY2v3jUZbV
	HzFeg/V80mmJ8ifExQ8tGQ6bXLfHEjmZWpHZ5i8fy9eNvONodtgSvLxPl7Jf7t7j
	m1W6ia+qw75GcmNU63Ap+J2ErKvpm7PQKcILNqlIxGQH1XIUvhnFHJpXw/nCKmdQ
	cGJisj9RLQVY0iIj6t1Lr+/c9zuI7Xgb+pza84XXCxoEXarYdTQuianUCwSJ5rrS
	OUzu8paK4TiqW/TVZZlcwemS6CkrQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020109.outbound.protection.outlook.com [52.101.201.109])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49x0en98hh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckqFm/nO5OGvhv3xU8tUctvsFXzdM6zOTfxTS3tQgnsZHz7A7BNlh46aiDAqiTlr13fLRYaebUXFxY7SFT/6DhUqzBC6clZNKn8n7alHqNtVSuAYKOXXFOOPNayxG1SGoiWNCxd73xgpn628eFfrfJY+sJwE5/es8oxVQ0/Es+Z2N6R3Z6K1ya/RSf5cAx3G03nKHHwgt8OPC7Bqw1OcBYiSwb+8rqWxcaQNOiISzYAdj2wcv+OUz5bkxxYGm8NLgvxI+FSD4FVuAdrWArv8/m9qexphcuTvqwk4L9fqa7b71vgXtZ4KbXYbUQ8Xb6ecZoV0kteUHJ6HaOHg+u9ptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD/AmrFN1W3PMAwTU61mP2XPeqCsR0LRcY+ERiNGWAI=;
 b=kSXff28UbREJm2kRAecOQckoZ4QENN15TEhG6b2yHP7CEEAcKBWCImxQM4gvkqGzzXw0h8yeLtnLnXKOLCIJttf0D5p+KltPg4ftkI2Efkt/FT3quRTjOoYuLndqFALkvAqc3HQdFglS0pF4g30Kbsmr/U4Vv0j8zTAh9KTOCmA7Scf3L8yXoibrjKfSRiwmofdNBv4TbZEDmVlA99+dDNxTR8qFR6S4B+2dfpI4e2gN7LEff/NZhDHymcYed1f8sl7PKaeT/1DXRQIBdiV+1giiH8No25nVJRSSqqvVgtjJfATg48ZaJZR1uTyzeSMZlzOvPxuPwnmDTxZep0Uavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD/AmrFN1W3PMAwTU61mP2XPeqCsR0LRcY+ERiNGWAI=;
 b=gEG9RlbixBYtynQrrIkhtgWZNvotPerfbcWHVtsphZtzok2vMLXGMvpfYVJ0yPIwpHkXWkpYdEVAUsIPYcy5mIn0R0SeQzwLSZd1wBECSJR+OdDbSblrUvsRaHoKobQpIRevKoBECkIFBSUY/C4eJWHd1GWN+v9c+dVFzfbjCBhy68jfyvynrCOze5ircpKztxVtZLywrnmTIgCEx1yvJvxhVscCtDhZj+2s7lyAY/bu7VFs73OHH7J3NxiqUENTgYuI2gy99wQHLftqxv4DemFNJ4WcMoC2uRXjDWKG/d800DRi+K7SLi5+N0UBzr3T9TpAq6+hd85cLC02qW47Kw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ2PR02MB9367.namprd02.prod.outlook.com
 (2603:10b6:a03:4c1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Tue, 21 Oct
 2025 15:35:28 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 15:35:28 +0000
From: Jon Kohler <jon@nutanix.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Dave Hansen <dave.hansen@intel.com>,
        Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh
 Poimboeuf <jpoimboe@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Ingo
 Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Brian
 Gerst <brgerst@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        "Ahmed S.
 Darwish" <darwi@linutronix.de>,
        Alexandre Chartre
	<alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index:
 AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLdggAgAACrgCAAAzWAIAAGO+AgAAJB4CAAPrcgIAABhCAgAAKfACAAA10gIAAAkIA
Date: Tue, 21 Oct 2025 15:35:28 +0000
Message-ID: <5E09F6D2-F6E5-45A2-8264-34DC6DF679B5@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
 <20251020204026.a7xuhnagsqo4otpx@desk>
 <225134fd-033f-4d63-b88c-772179054694@intel.com>
 <20251020224159.xkhfs3phai5o6rzb@desk>
 <1D952EBC-CA16-49FE-8AD0-48BCE038332B@nutanix.com>
 <73a22a19-c492-4a75-8352-a4cfac47d812@intel.com>
 <883EDC14-1A26-46F4-B9E9-C75A6DF07195@nutanix.com>
 <aPemUXkliqL7QShY@char.us.oracle.com>
In-Reply-To: <aPemUXkliqL7QShY@char.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SJ2PR02MB9367:EE_
x-ms-office365-filtering-correlation-id: 5399dc5d-4aed-46d0-fd7b-08de10b77682
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUJaUTcyV1ZkUGpkS2h1UU1zZG12dzQzeEtoYXJ6L1NGbmxxN2F0VHZJTGZC?=
 =?utf-8?B?VjlWbm5zZUZrUWw2cUhLQmU1YlZUak9acWRJQjBpdkw0M09zU0dZdVFhVjhR?=
 =?utf-8?B?VGVoeGxsMThlVmNzTzFmVjIyRGlETy93ZTVwUWtnd3BaaEtCNFNhVWhkZ2Fx?=
 =?utf-8?B?WGM3aUFMT0twcEhUU24rVFBtK3IxU2NtY0h6d1Jhd1hmQm01MDdRaXpicVBR?=
 =?utf-8?B?V1pJazlUa0NqYmxqZWkyZTl1dEtNTnhUMEcvQytOcGlRenM2WWNSSWJueWds?=
 =?utf-8?B?aXdTbll5d2dxUXRUODI3MFVlaVVEeXRqQ0R2b0xmTlZrQmlybkp2bEFSb04r?=
 =?utf-8?B?cjFJN0VSMWk5OHMydzZTZ2pxcDljVWpJclh1elk4VzYyNzBndkZNUXN2Y2xy?=
 =?utf-8?B?QWJtdGhleFJXcDE4cEZyR3NpTG55cFZ2YUhRSVV4SWk4UXB2VnJJVVlja1hE?=
 =?utf-8?B?L1QzRzg1UzcyRHB6enhhM1h4YU9XVm1RWTVrS1luMXhoMDhVd3I5eTBrMzBE?=
 =?utf-8?B?N3N5Ky9WdE9OdVhFc0RBYU9IWElQTmxIMTN5RzNhcjEwbW1ydE44eUhmbjJ3?=
 =?utf-8?B?TGp0c1Blb2Nxb2ZWNjA1UWtzMzNyblRvRmdqY2dtaWpZa3BNWFplRDcxZG1S?=
 =?utf-8?B?bHg0WVJuaWF0MzNhNGd1Nnc0OERjSE9WQUZ0VnZhc3RMOWFuR2R0UytPaVBL?=
 =?utf-8?B?dnRLaGtiS3A3MXBBN3djdUREam10ZmRvY2J4RWlGcTYwZG9WbnhUTTNVZ3da?=
 =?utf-8?B?c2pjUkJTejd3N3VpeVR3clYxUXBDT3p0Um1wakZXUi9CdUU1b3RhYm83c3Ir?=
 =?utf-8?B?SEY0SzI2bGd3NE5ZeURrcURKd3hvUDBXcW1Ldk1EN0F5azlOKzNjUUJ4MXRV?=
 =?utf-8?B?aFZ0a1VGSXc0QWUxdjAzdTNsTjlhdVFoSVhWOWdWNWEvTEZ0anRrTU5ZTGRP?=
 =?utf-8?B?Wk05OC9SNGxHUXdvdmFjaUZRd1pEZStQMjZ3b2NMc0ltT3J3UEtJK0ZLVkpx?=
 =?utf-8?B?bUJNMDdiK3lPbERuNm9OYnB6TWJRTlZkQ2FsamJOUGdabUxxUHZhY25taFZJ?=
 =?utf-8?B?Z2RiMUtUelBhR0dqNE1yNG43elBzT05ycm1yQkhIaVllOElRV1lSRXdyU3hI?=
 =?utf-8?B?cXBxWTMyWU1pL1RPWno2MFh1N3d0RzhLY2VzTE9TRmFGcS85YzhXeGd4bVhW?=
 =?utf-8?B?TW96VWtDeUNLa3BrZFFOTWwvRnhYdW9UMHVUZTA5STYyM05VSWtaZngvSUZS?=
 =?utf-8?B?bFJEaHViRlFZZGtLV0RJTVhSNTZVYjU4SkN6K2xsU2ZVdzJoV2VvZ3ZSeldH?=
 =?utf-8?B?TXRuQzFneUhhMmNwcllxNERYM1ZoOEhUMDlnRi9oR0NNTEZGM3J5M1k5MXRm?=
 =?utf-8?B?NlczT3lRKzZMM1Y0WkFWalUvdWtjSTFXVGZRV1A3dVNBc1A1QUNIS2lXMGM1?=
 =?utf-8?B?NTJJbVlETWgyMXpHK25GZTRCYnU5ajR4MlVsLzdveWdBSG05R3JveU1zVGgz?=
 =?utf-8?B?NTYwbUR3SHFSM1RqZlBsMW4vaGlMc3NWMm1QYlI2bEdtYXp5UjVXRGwzN1Nh?=
 =?utf-8?B?ZzNJS09HQzVQMHNHZjRpYWl5TGx1SUtuUXk1T3ByelV4K3pzNVZJRmlrQ3NR?=
 =?utf-8?B?c1lhREZpZDNXL2l1V1oxRGhwUVdvbmp4TFJ6bWk0RnNGVUtheDdJSkxvcVQ3?=
 =?utf-8?B?eHMyQlBZTXVzdWVkZGw2OHdYRHhxWTl5enFscG4wWmQyVElBL1M1NzhVR1Jm?=
 =?utf-8?B?U1JmeFFaanNXclUzSkVjUnoxUExPVlJTWWRXejBBb1NHT01UWmViZ0oyczBX?=
 =?utf-8?B?bm02QjJNanRpRHBicS94bkh1dXVVVWFqWWlBMUZTLzlkVHE4Y2hZV1NxVG40?=
 =?utf-8?B?SmxIVThRT242Q2NFcEdYK0VtV3UvUTVZSVJFcUMweG56ZVJzcDlQNzhJOFhG?=
 =?utf-8?B?ZStmMmlBbEFQZUhCWjlLd2JHVVk4dDdQWmcra1I1RzV1WU5kNWU4dGtiK0E0?=
 =?utf-8?B?V08wOTB1UXR1UVhvajJYVTkrTUNaR05PbGQyUTVGTVlGRU1nS1Z6ekJwRzd6?=
 =?utf-8?Q?YnaRpv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWlYNWpMNzF1N0pjQW03Tld1VjBveTY4dFp0aElXYkxrOGhHays5RVd5akJE?=
 =?utf-8?B?VHMwREt4MWViemNtZklHV3JIVXNreTU1U1hoVnpwK2ZyWXNrTVRiT0lkQjBi?=
 =?utf-8?B?RUFIT3VoUXdmem5Ga2J5ZUxWYVd4Qnc3NTJyR2ZEQlIrNFVkN2RWTmJqVXdR?=
 =?utf-8?B?S0RZeklabHc4eER6NHVSa3IvZHB5UCtYYkZsSkY4bHhHUE5FWmdWVm9ERkF3?=
 =?utf-8?B?UDU0QzZQYmUzcGdHWnpLaWllR010S0hGeEtFL2ttOG12NytZek9DNXl1STF0?=
 =?utf-8?B?R2NvQUZ4djk4UDRCVkZWdlc0TGErR01pd0tIc1kxTXc2bkc0Q1JyQ1BJdU9M?=
 =?utf-8?B?T3J5K0M1TDY3SFBaN1J5L0Uwb201aURaZ3lKSnpvblZPNVJLMnVqOEpqOVJr?=
 =?utf-8?B?OWI2a29sWk1aVkRDajBXeHVoZ1lYSDEvZHhjaWgxVk9naE03cS9Uc0RVbVBx?=
 =?utf-8?B?dzhSRHNZOFNicUJYOGhDRGszWkNxTE8ySzgwOHlpcWgxeXVmYkhCdUZUR3RF?=
 =?utf-8?B?TmpzdjdsdlRUdnZPelJSTnRyV3pWcmRIUFRwaU05TFJFNDZjV09qeFQ2Y3hT?=
 =?utf-8?B?cWZ2Z1hjVC82MlBuOG1wM1NDOVlFMHpzU1RHWkR5anFJRmpGZ04rUFFUb1U5?=
 =?utf-8?B?ZWEvU0ljN0JrZE9OSG1WaDViR2QzN3ZzNkcrSFJ0L0JwY3pMSzhNUzJTdmNo?=
 =?utf-8?B?Um15ZmV5SnJrQ2R6VTZpUFdJU2tJVE8vMzQ2eGtpbVR0MVIxdm1xY0lOTC9R?=
 =?utf-8?B?ZHV3TDB1a3ZPcUNRRnBQdEYrVWNpT0k1c0ovT2ZLK21BSzQ5cGFpb1hWajRB?=
 =?utf-8?B?UlZPN2dTcjI5U2Vnd3A3NERFU1ZLU2pXbDl0WXZFTUc4dmxiaVM2RXQ0VTM4?=
 =?utf-8?B?eVJ5S0M0VGw4S0dzaHc2YzhMMWJ3TVdXZkRvS3B3ZDgzRU8zZWt1N2xIR2Iy?=
 =?utf-8?B?MHR5M3NnQ2ZMTUFkcDhnTXlOT2xMZGo2V0dlVXJaaUMrUkw3WitnRTZWUFh0?=
 =?utf-8?B?alFxcTk2WW9zSFUzTjloOXdxRGlxVGwxWWRJUEw1SlJkenZ2eDNocmZqd290?=
 =?utf-8?B?aTZaQ2FFUFYzNjFkUE51dGo3czJKVEpRclFGajYrdjF1eEQ0bmhScHR0akVH?=
 =?utf-8?B?aWhnR0E2MkJtaVR3c3VyNkg4NTRHUkc0VXpWRjltcXRxME5QMXJsbHBpTXJE?=
 =?utf-8?B?MkhuRGg5Mm1RQ2d0NzUzZ3AyTWpVeVJvMWtJTnZJSWNqR0QrWWZaNmxhZFVG?=
 =?utf-8?B?aGEyS1JIZE5VZXJzR0taN3NISk11ZklxS3pkbnRXY1pibG1PNzFIbHVYRy9T?=
 =?utf-8?B?dUdTMktPZ2l5emNzTUpQa015NGxVMTc0S1VsTlZOdkpHM0J2bjRNQ3p2SkQ5?=
 =?utf-8?B?ejdRbG8zaGJyTlMreVJ4QndiMHNwZTlNWG9oN0RaOHhnUVNBVXpPU05iZzRK?=
 =?utf-8?B?cnVzamt5b2FORzQrSWpXUkduMTJtaUpheFdQb2hqNGRnZGhRaUNqL0dFVTFQ?=
 =?utf-8?B?K0RTMi95RFpFWXZEZDF0aVhKRlUyZW04aHp4WnlmUkE1d3lLbUJTUEF1cVZ4?=
 =?utf-8?B?R2xUZzNKT3huT3JIRi9WbVRteFRrbUVpWVdCTUo0S0pnZ3R0SEgxT29GN3gz?=
 =?utf-8?B?S2U4SkEra3pldXNJK0xpcGxaTHkyYjMvRmJhQzRJaUdhV2VyVzRiay9VVlNG?=
 =?utf-8?B?UVBRZXdkSFcrQVBuZCs5cHZwUktGL010MWtFOXpxQUdqbUdhcnZ3RHVySEps?=
 =?utf-8?B?SWpaV3NNdGNDd3RRRXFrdUxUaFhobVlQVGN1dDB4cE5jZHNGRkN2ck5TRUcv?=
 =?utf-8?B?bDN1bkpTOFF1WC9VWUZiWWZyVkFIQVY5aW53VUhSaGFsOVhhaGhrS1loUlhs?=
 =?utf-8?B?b1J0cEZxbFlML0tMQnJGMG5pRXRDYWt5Z2laVVNYNEs3TE5mbk53L1NtZmYz?=
 =?utf-8?B?SjBLeklkTXZtY2l3NVNWYlFRMWpxelRpUzRlSFB4by8xWHl6SjJGeVpSbnpt?=
 =?utf-8?B?cExGQm8xYnFzd3FibC84aHpyVWNZOWIxSlRJOVZVdTJJTVVsd0h3Z3hvUE1M?=
 =?utf-8?B?OUYyYndXVnNNdkJ1dUZRSnhTQm50V0o1Ri96MFpCcWlMc0ZuamJ3U1pJT0du?=
 =?utf-8?B?L2VHRTdMMitYQ05TdkFwOElxRUdLRUw5TmhXUVdKRk1MSWlIcDYrdUVEbFl4?=
 =?utf-8?B?dzZ1WHdra3dZaEJTbjg3RTV1NzNVWWw0YXIrenFwT3ZSTzdQMWlOZHlJZ1BV?=
 =?utf-8?B?SEYyQjh1V2ltaGl1RElxTHcwTllRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B0EFAF633358649B7F696F7CD231701@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5399dc5d-4aed-46d0-fd7b-08de10b77682
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 15:35:28.6029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqbkUTOnbs1bqAKeUjOblWMIQ3HGTD3CbPE4xL66bs/Pt/mgkiGcZGABlW3f2M02oxjDJTCuWLXmiqA9KtfYuKoXRJPkoWQADIKXJMyypk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9367
X-Proofpoint-ORIG-GUID: Nsas651zs_ywlyxbjGxQ2QyMp7y4Ep_b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDEyMiBTYWx0ZWRfX7pI0fZgfRzni
 zYgOlGKnlv2YMkACVxrhZGVRwKYZRhXqotpEDbS/zi6dBETsMbeNkFlgdWOSrEilkz3IbbcVA1Z
 XF3hZZm0hm0XL7QeLyQqxuyYK+3N9qvbJq/W3fuZ58EdK1ZRm0tyxURveU4tW6llLerajFSjFXc
 qEPOeCvH3RV1TKfYr3ET20nGZ6nFdE6KbM2kGlUyWcFCFILnbsmWxKnENYkaYiwv0Y6jvdqsYyW
 9E+XrVuK9nnI0vImMEcQ2RfhwHTtk4n2aSZwfgGPXME/F2I9e7AAp1aHBBwbChIXPkcaVcMP3Hy
 zIEvjmFOFIbgx3u2VQzW9ToDOb0DUOhVKjxVXfOusTjqiDqPJvnvaiUggT+OI+4W9Q6nOXZwDSc
 C2KsBKnWcoeCTzoPZ67zPMV/VetEJQ==
X-Proofpoint-GUID: Nsas651zs_ywlyxbjGxQ2QyMp7y4Ep_b
X-Authority-Analysis: v=2.4 cv=Dfgaa/tW c=1 sm=1 tr=0 ts=68f7a842 cx=c_pps
 a=9zeqhqFsX+GWigQuve45qQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=qwmS6mAJEpyQE-TKHpsA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIxLCAyMDI1LCBhdCAxMToyN+KAr0FNLCBLb25yYWQgUnplc3p1dGVrIFdp
bGsgPGtvbnJhZC53aWxrQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiBU
dWUsIE9jdCAyMSwgMjAyNSBhdCAwMjozOToxNVBNICswMDAwLCBKb24gS29obGVyIHdyb3RlOg0K
Pj4gDQo+PiANCj4+PiBPbiBPY3QgMjEsIDIwMjUsIGF0IDEwOjAx4oCvQU0sIERhdmUgSGFuc2Vu
IDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+Pj4gDQo+Pj4gT24gMTAv
MjEvMjUgMDY6NDAsIEpvbiBLb2hsZXIgd3JvdGU6DQo+Pj4+IFNvIHRvIHNpbXBsaWZ5IGl0IGRv
d246DQo+Pj4+IEEgZ3Vlc3QgVk0gdGhhdCB1cGRhdGVzIHRvIGEgSVRTLWVuYWJsZWQgZ3Vlc3Qg
a2VybmVsIHNlZXMgcGVyZm9ybWFuY2UNCj4+Pj4gaW1wYWN0cyBvbiBub24tdnVsbmVyYWJsZSBo
YXJkd2FyZSwgd2hlbiBydW5uaW5nIG9uIG5vbi1CSElfQ1RSTCBhbmQvb3INCj4+Pj4gbm9uLUlU
U19OTyBoeXBlcnZpc29ycywgd2hpY2ggaXMgYSB2ZXJ5IGVhc3kgc2l0dWF0aW9uIHRvIGdldCBp
bnRvLCBlc3BlY2lhbGx5DQo+Pj4+IG9uIFFFTVUgd2l0aCBsaXZlIG1pZ3JhdGlvbi1lbmFibGVk
IHBvb2xzLg0KPj4+IA0KPj4+IEJ5IG5vbi0kRkVBVFVSRSwgZG8geW91IG1lYW4gdGhhdCB0aGV5
IGNob3NlIHRvIG5vdCBlbnVtZXJhdGUgdGhvc2UNCj4+PiBmZWF0dXJlcywgb3IgdGhhdCB0aGV5
IGFyZSBjb21wbGV0ZWx5IGlnbm9yYW50IG9mIHRoZW0/DQo+PiANCj4+IEJvdGggY2FzZXMgYXJl
IHRydWUgZm9yIFFFTVUuDQo+PiANCj4+IEZvciBJVFNfTk8sIGl0IGlzIGFuIGFsbG93ZWQgZmVh
dHVyZSwgYnV0IGl0cyBub3QgcGFydCBvZiBhIFFFTVUgbW9kZWwgYnkNCj4+IGRlZmF1bHQsIHNv
IHRoZSBoaWdoZXIgbGV2ZWwgY29udHJvbCBwbGFuZSB3aGF0ZXZlciB0aGF0IG1heSBiZSB3b3Vs
ZCBuZWVkIHRvDQo+PiBzcGVjaWZpY2FsbHkgdHVybiBpdCBvbiwgaXRzIG5vdCBhdXRvbWF0aWMu
DQo+PiANCj4+IEZvciBCSElfQ1RSTCwgZGVwZW5kaW5nIG9uIHdoYXQgUUVNVSB0aGUgVk0gd2Fz
IG9yaWdpbmFsbHkgKnN0YXJ0ZWQqIG9uLA0KPj4gdGhlIGd1ZXN0IG1heSBoYXZlIGFjY2VzcyB0
byBTYXBwaGlyZSBSYXBpZHMgbW9kZWxzLCBidXQgQkhJX0NUUkwgbWF5DQo+PiBub3QgaGF2ZSBl
eGlzdGVkIGluIHRoZSBRRU1VIHNvdXJjZSBhdCB0aGF0IHRpbWUsIGFzIHRob3NlIHdlcmUgaW50
cm9kdWNlZA0KPj4gaW50byB0d28gZGlmZmVyZW50IHRpbWVmcmFtZXMuDQo+IA0KPiBRRU1VIHBy
b3ZpZGVzIG5vdyBhIG1lY2hhbmlzbSB0byB1cGRhdGUgaXRzZWxmIHRvIGEgbmV3ZXIgdmVyc2lv
bi4gU2VlDQo+IA0KPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9
aHR0cHMtM0FfX2Jsb2dzLm9yYWNsZS5jb21fbGludXhfcG9zdF9xZW11LTJEbGl2ZS0yRHVwZGF0
ZSZkPUR3SUZhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1OR1BSR0dvMzdtUWlTWGdIS201
ckNRJm09VVVTdnBQVmlpVEI2Q0pRdGozR1JFSzRiUUZ6N01UOXVOaUF1NUFMM08yM2Q2STF5azR2
aGVMRHlSNDFaY2JSSSZzPXgxOWd3SFUzSEdYU2xHa0swcHBrYXdleDNTSWJzOHhIajVoUHR3TkNG
d2MmZT0gDQo+IA0KPiBUaGF0IHNob3VsZCBzb2x2ZSB5b3VyIFFFTVUgcHJvYmxlbS4NCg0KQ2Fu
IHRoaXMgbGl2ZSB1cGRhdGUgZmVhdHVyZSBjaGFuZ2UgQ1BVIGZlYXR1cmUgYml0cyAoZS5nLiBh
ZGQgb24NCi1jcHUgTW9kZWxIZXJlIOKApiBuZXdfZmxhZz15ZXMpIGR1cmluZyB0aGUgdXBkYXRl
Pw0KDQpDYW4gaXQgY2hhbmdlIENQVSBtb2RlbHMgZHVyaW5nIHRoZSBsaXZlIHVwZGF0ZSAoZS5n
LiBjaGFuZ2UNCi1jcHUgTW9kZWwtdjEgdG8gLWNwdSBNb2RlbC12Mik/

