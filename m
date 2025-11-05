Return-Path: <linux-kernel+bounces-885899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6DC34347
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718C73B8C2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1058C2D0C8B;
	Wed,  5 Nov 2025 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FEynry66"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E69D2D0602
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327213; cv=fail; b=oaM5b1hIoMhrWR6LVMDvksDV2nYd57Zprl0+3T9za9TeDlfJVQ5DF/0WDDcPHTmIpGqkfW2kZqcCTXpS6noTWLBPp8vjcc0AWZoGWQNkNcnm3020B3nNhjmORqehMr659mAwufZ97zGFhUP9xWRBSJJybvTZQ+6fd20XcY54ChU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327213; c=relaxed/simple;
	bh=+TR2wa4H/yVnBtImIIBCUasNRdWBu0mA2WK70WBFMbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GkzSPhObZ2PX6QGWNdTNPaRz8jLNq5BHwj7+Kr7/noshfHJkwePPBwZPZQY653GZMB86/Hfu9Ei3bC8KEIx1xMkgrZ8CsZB9mwErCma78alX0T31rLA5W5/3FN48CW5l1+2SjZOOoPLunp06OtN9WllbUJd5aBBMsdD0pdSZ+CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FEynry66; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2cz8sed8PSjN7konvHpeM/oqTb2u+vfDcChMpiy2qMjODe/0EXUzqgQRcFZDL12pUC44YpAlqrXbFNgN+9saIX0qrJTUau1V3BrPnLgNTBXN+pFReM71BXNNqqymAdsEYkXuZq2xxnt/J10gb+Q/k97MZ8dEZeGV7BSXwp2aSdaFa1OmRfZHlBGb5lJY2Ti0cp3o7uN1CX4MoB4qXRs2c3gojNXY1TrYuKPvV4EwsJ0wAi87Gt3/ElggeaoArW7NId5Z1W9KbQAaEyEC93rzDckbErf+1ZmamJp8Uy3MeV7PLI26Yr5xC684ZSLIfYwcLEz8Iek1sLxJdiGXk+HvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TR2wa4H/yVnBtImIIBCUasNRdWBu0mA2WK70WBFMbM=;
 b=kex6BBq6J/okc8Nvk/fkKVsINATdUCdarPhaOUF/piIV+M7bgLdafX/YTJHzzYA/5Z1UTOhtWPfjyAqLGL5fsP/9TCw/BOJ4izSieGtjQtBctekZNiUAkwNXR4CCHBnCH6g86UGiJIdYMaMAWB0LlUjSPbMWeindNHCi03DRMMMLg45hHjxo687CuqfufaSjlWyvcX0vdZNiUkfOalIVAItCvQ6ZPawN4pBEcdh+VVUnGidRq73A4YzDcAZRAZkobT5NLG/17bZdDz5Hbr14epNoWNfttNZDV3yTWtJPPxvvgczfBIQ0KU1XEzZyU9ocG3T2BRRNXaTlBoNRotI8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TR2wa4H/yVnBtImIIBCUasNRdWBu0mA2WK70WBFMbM=;
 b=FEynry66x0uxEGiJvJsNeLOZmPkrNNa9VSrMkAa+htK2LSl1RBRTNvH6ULp3GsAOohUFpv3uFIphmGv2J8oRpIPHZaYixZKeT+vFSYyUqNoyRESvYDoI1CDSMaHwoYhr1wC7Z4fSwxB05xVmAbl2vIK/rsiyJrZtHTG5d+k1xX9JyQGTWgreHKzNg3Ec4T8rAX8mhW1infcwvo54gg99+oTmjwAPw7/Qs/tDVjvw//5YTKK222FFC0+GwngVDckrkJzCYvEHhrB0cYy0hHLtiOgWBkAfwYmqdZLwKYsW0XzzWUcmF2drNlxoFch2SW+ukjpnw8VGZJFogrlw3sahDg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB7218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:454::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 07:20:07 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 07:20:07 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>
CC: "hui.wang@canonical.com" <hui.wang@canonical.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Topic: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Index: AQHb66DA/2ST5DqqmUGvisuiiSELdrTh5/AAgAICrICAAIdYAA==
Date: Wed, 5 Nov 2025 07:20:07 +0000
Message-ID: <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
	 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
	 <2025110513-manliness-repayment-d005@gregkh>
In-Reply-To: <2025110513-manliness-repayment-d005@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB7218:EE_
x-ms-office365-filtering-correlation-id: 24f8f198-f007-4dc6-101c-08de1c3bbf62
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkNoaXlydHZEalRiZk9EYU9razVRQTQwZWMwa3dDMUtvaWQ0WUt2SzF5dkVh?=
 =?utf-8?B?OEp5L1A3V0IvckYvOGJXdGNFMStDdHRwRjVhM2ZTSnRxcWc5elpZdkVDeWpE?=
 =?utf-8?B?UE5tRjExM3ZZbVljYnZ3eGJXcittZVJDdUlteVFVc3dOK29Ia3Q3clVSZzZO?=
 =?utf-8?B?RXRUMVppQUN4VG1YL2FNclRObmVnRFJ5c25OR0M3QWZoZnJvL3ljanA5alNH?=
 =?utf-8?B?YVpRbDk5WS9peHZMYS82aWdyM0VCK0ljVWNqVFFPOUpmYi8zTFlwMnZ1Y25K?=
 =?utf-8?B?Z3pqV2VZNEE3WU02NVQzT1FLd0RBUWhDcVVrQU1IaXd5aFRnN3FCTUljeXpz?=
 =?utf-8?B?SmF5YlZjU3N1SXpmTjRwSnBUYTNROHh3cEJGS0h2TDdEbE1kWU9zdjVPY3No?=
 =?utf-8?B?RDduTkZSSnBlQ1JPdmxaKy9qZU1zOUtueWdsMVdyQjFBMmE5WG9ubCtyZm43?=
 =?utf-8?B?cjBTUzcwMjNPcXBhWnNwMlRtUXJJdnBERDFlc3kxMGUwOHIrWGNjL2p6eFM0?=
 =?utf-8?B?NkpOQTFEWUt3R3A1SjNGYmpZRFlVZW5xbFlSM3BWUHdGYlB6NXlCTmRDa1BT?=
 =?utf-8?B?K3F3MElKRC9EeHRQM0szREVUV0c5R1l4Zll0ZDd0WGUxREtlZDB3TWpRa090?=
 =?utf-8?B?V0haYjFUK0RQa3BYN3BYUExBTkEwdll6OXBqUTBhVzQ4YWFTRUJkb3pacjc3?=
 =?utf-8?B?VExvSDExdnFUdldjL2xxNW1GVER1VkVhYWxaSnYxNmR3RWk0cHRUV2ZqQlJt?=
 =?utf-8?B?b2Q0QVlodkZJT1pLbVFuTlcwWmtYa3VBRnhUbldGZlFnVzFUdkdBZXRRVDN6?=
 =?utf-8?B?Qm9yRld2c29US25RM29wb1R6YXBJYWxTZ0dFNHlkemFhb2ZOb1ZxK2x1NzIx?=
 =?utf-8?B?QXVYQXpzTUFmZzRyVStzSXNvWGJCTUN5RENpRXFsYVlad1ppOHpiV3Fid1Rz?=
 =?utf-8?B?SWs4QStrV0pkOFlVNytOdWNXcVFXZHhBSjdxR1YvVExTeFdteW11QzRjdVBu?=
 =?utf-8?B?U25sdHN4OWZwWXVPOWtTL2dZdEpSUHU4NEdaTktiSkRadEU2Um1mdWNzZDRz?=
 =?utf-8?B?dHZPcEgzd2pyOVV1Q1lwVC9MS0c0NEJEcnpHelNrM0JPbW1zZkNzeCttbWVY?=
 =?utf-8?B?aXZDUFRYUk50SDlNY3Q2ZGdIbUM1cTQwMW0xckIwdStDbldCZDZIRG41VkpP?=
 =?utf-8?B?SEJnUGpENlFvMnRZUm84dVBUekRxNDF2ekRnbW4xWlBWNVgvZmZIUnJ4NUJx?=
 =?utf-8?B?Nk9GWXdyRXpyMDVYMXlhTmdud1RkNFJ2RmFSazR0ZFJ0MHBGc3BwZG9QQjZa?=
 =?utf-8?B?QUFoMCtsaE04UTRQcExQSGFTcEN2WGN3aG5kbExqdkVjemFJblZkWWR2VitK?=
 =?utf-8?B?d2kzY2kvMXlES3oyb3RCY1pNbzZrOGMwYkFKN1hOK2UxS0FCQWgyS0RJNEI0?=
 =?utf-8?B?eTh5aHNQWnFRSVFkeW5pQ2JONWxTREJ2eHg3NmFUT3R1RUg3bklJQ1FLUk50?=
 =?utf-8?B?WEZ6MGJ6K3A0WGRKNWVNaXlKQllTNU5KR3RrRVcvc21ibEFDem0vZmhrL0l6?=
 =?utf-8?B?dEQrWG1ncVJvT1dtVUZQWlMzb0hCYXA2ZlN2QzRDWEpUT2p0clZTMGgxMUdT?=
 =?utf-8?B?ZjZaMEdNYXZYZHBEc3FPYlVWVzgyTi82bVoxeHBORVduNDdOWlhNZ1E0aTNR?=
 =?utf-8?B?WWw5UmxWa3hMWUZiNVRMRlp5R0svdzMxZ0N5OEplTEVHbkF6ejdGMW0rQ1d5?=
 =?utf-8?B?blhub1RuTEora1FyVE15TVAyVEVTVGROazRta3RSeEZQdHIyaVZXZ3NadTUv?=
 =?utf-8?B?WUlXTkFxRXlKNVl4eEZKc3Jpb0JKVVF3MUd6d3czNnJwcERVL1VPdFRDd2RY?=
 =?utf-8?B?MHRvQTBrZ2Z1RlcvQkNLUlgvSS84SkprNjh1YTNlSy8xdzQ0Wm5rYW5Ta1Y4?=
 =?utf-8?Q?6eDT9PUdXcqlQrlj9k9Hqw6k00Bskw9r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHdjTUZySjhMcENHT3M3ZHBNellnME96MEtoeTVKTzVoRzVMUzJrcWtvdGtR?=
 =?utf-8?B?MUkxaGNUbFRSbnpWVVJtK3hOQm14UFhNZWtncG5mR1VJNDNJbzY5VlhPcGxq?=
 =?utf-8?B?ZHJ0OVBIdVNjT0NVNzcveXBZOUliUSt3NkpUVnR2Wkt2dVdvbzE2aWt5QlFs?=
 =?utf-8?B?REJRcjhXK0cwRmM0T0ZVNm1RRm90TzNhYWJWUlBTQlNLcUpEMnlHQkZqVnRn?=
 =?utf-8?B?ZnEyek9xOTVGOVdIK3I2YXNEcG90UGNXbHYybGpPRklIeUc3Mkc5Mll6eVgv?=
 =?utf-8?B?cmtrK3ZiQlZVU20rYThUelJSeHRmUlVYem96VjdON05FTWFNZUs4Mk1iclBF?=
 =?utf-8?B?WGZBTEhmVWVCdmpyTkFNSUJ2ZlNhakRsZmtXUTh5T0tNdmdTZzRWTHA3bm9j?=
 =?utf-8?B?Y3VBSksySXhIaGtrU3prNC93UHl3UzFWMzhZeFU3U0dUVEdQdm1pZlg4eGUz?=
 =?utf-8?B?M1JEejhLaW1va0JxdjNITDY5V1JWbDJzaGRUL0dES3RkOVVsNURwSVRUMGZV?=
 =?utf-8?B?NVhvSm5kV1JnYm95ajA0aHh6NUNvV3A4RVo2RW5EN3lGdEg4S3lBQit2enlE?=
 =?utf-8?B?WklLZ1JVTndwRDdma3NXSkVhSmJUMzJXbFdpeTJIdFUrdEUrSy9ISmRuTkpx?=
 =?utf-8?B?VHJ1bFJWTi9YNkdCeVB3Y0t5R1JvNVVnd0JUWmNTNUZFM1k3bkc5eEt0U05a?=
 =?utf-8?B?b0NJY0tKZ3FPc09YMnU3K2oxTkpZS2dCeG9rYU1tRlI5eVBQcUV0N0RYOTRh?=
 =?utf-8?B?RXltRURUWTRscE1yNnNUQkJlZTBxZ3dYZURIVTYxZEVmZ0N2NDMyNEJBUEd4?=
 =?utf-8?B?bVNKTXVNVUpNVnRhb0RJK2Y4YkFTc2RFN2NDWlBrRFVoQVpycUtxTjg2QWov?=
 =?utf-8?B?VUhuYjBPY1Q0KzdCYmxGeUllTWtuNGtkc2k4a2drcTVtRjFMNFE4aU1MVUpt?=
 =?utf-8?B?anhUTVhiR01ZcUVNWi8wcFdCdlV6SnlQaGlXMzJHcmc1andzRW91UklZd2pP?=
 =?utf-8?B?bm84NnM1UUh3MnVjMjlFVVhCY2c0NG5DUmNNYkhicFdUSnlkby9xTVBaV2hM?=
 =?utf-8?B?TDVrcEhxQmw2SFl5R3ZjdC8xVEgwNlNQdEVENXdvWm5JTnNDUnBjS21zK0VQ?=
 =?utf-8?B?OWZWNWhmOUtrWkhsUHRPd1BGSUVjUXhjT2N5cythaURaSUxEQVZLWDFNQXhp?=
 =?utf-8?B?WkF5ZDNZSzlkMWh3bnU0V3BsNVVMdWlMRTh6VlF3ZHFHdFg0cks3VXNkRi8w?=
 =?utf-8?B?UzdqNnYweDNOTGRQWmo1Z1A3S0hITC9yazNzcHBabTQzV3FNNW5WZW5ybE9o?=
 =?utf-8?B?eTJHTUZEWVlWeVJhazMrc3pBNjE0cEl1NWVaS1IrL2VnTWhBMlNSNlhRNEpY?=
 =?utf-8?B?TEhMQ2hoT08xM00zcXpZTWJqWE01VXVxbkdCanM3ZUVLaFNwVHg3RUF3aEVJ?=
 =?utf-8?B?ZnNuZ0tHeE5ESUJpN0k5RkM0Rk1ML0NWNjVZVEw3ajc0YVV5R2FQRmIwOWVa?=
 =?utf-8?B?SndGVk13NjRFdzdhMm44K1lWbDlqM0FkZHdDRC8zN0hqdFZ0VWFFbW9TT1Vv?=
 =?utf-8?B?SHBFRkVHQVR6VnV6WmlmRDloOGt0MjlONFN4b1ZPd1l2K2xtV1ZqZ2pyK2lY?=
 =?utf-8?B?aml4SnFYY2I1anJWVitvUlRHQUFKVXh4Zmp1OHRPaEk4MUJTNTR0S3NrWFhN?=
 =?utf-8?B?eFFxc0dxRlkvLzVFQ0Q1U1pRMHhhMUg5c3lUL3NQbXMyYkJjamU2QUFxQnFU?=
 =?utf-8?B?bkVjcUZJcSs2Qjd2bjg0YlRObU5aT1VsbGI3ZytzOGJpWDJLUU9ZbHJzZWdT?=
 =?utf-8?B?ckFBNEVQOEJ0cFRod1l4RktkZ1dOcW5vTWRaZ3lFUjZENk9JM1JwTUoyTEtJ?=
 =?utf-8?B?bVNsR3phUHFJL3MwMjczZ2llL1VBQng4cllKWmlBUUt3VmtET2ZobVZwL0Yv?=
 =?utf-8?B?WG1uZ1dXV1pmOGhqK3FIclZYdGhoenYwcU1PbXd4a09ZZTkwMEJQZGt1bU5h?=
 =?utf-8?B?OUNacmdKMlNLSXBRb0Z1N05CR01Ec29iT0gxcjhqQm5va1V3aWYzQlRvWG1o?=
 =?utf-8?B?TVVqYjZacURENjNudGxqN1NHajVlb2l3SFliOVVnb0tzd0JzT1cvSW13UVRh?=
 =?utf-8?B?Zms4alJ3VkRiV0diZHpyNG1rY3EwdmpjcFZCbllKbG82Zm8rMXkvQ2Mxa0l0?=
 =?utf-8?Q?nrZgCn+qPyRsRzmCyGKXNgc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B0BD02B0D047648A836B50E0E6D79E6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f8f198-f007-4dc6-101c-08de1c3bbf62
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 07:20:07.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PMJXRMuLjum0eU9ifA8HdhhBjaze/dLl5Yi2nMHZMPQxQHhSyZ7Kx12NAy5RWFJ8VXq6xB1JeV3GQZfdQ4NMAGTPMDNFcH+9Keak3bREPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7218

SGkgR3JlZywNCg0KT24gV2VkLCAyMDI1LTExLTA1IGF0IDA4OjE1ICswOTAwLCBHcmVnIEtyb2Fo
LUhhcnRtYW4gd3JvdGU6DQo+ID4gPiBSZXBsYWNlIHRoZSBSQVcgU1BJIGFjY2Vzc2VzIHdpdGgg
c3BpLW1lbSBBUEkuIFRoZSBsYXR0ZXIgd2lsbCBmYWxsIGJhY2sgdG8NCj4gPiA+IFJBVyBTUEkg
YWNjZXNzZXMgaWYgc3BpLW1lbSBjYWxsYmFja3MgYXJlIG5vdCBpbXBsZW1lbnRlZCBieSBhIGNv
bnRyb2xsZXINCj4gPiA+IGRyaXZlci4NCj4gPiANCj4gPiBXaXRoIHRoaXMgcGF0Y2ggKGtlcm5l
bCB2Ni4xNy4xKSBvdXIgcG93ZXJwYyBib2FyZHMgYXJlIHRvdGFsbHkgdW5zdGFibGUsIHdlDQo+
ID4gZ2V0IG11bHRpcGxlIHJhbmRvbSBPb3BzIGR1ZSB0byBiYWQgbWVtb3J5IGFjY2Vzc2VzLg0K
PiA+IA0KPiA+IFdpdGggdGhpcyBjb21taXQgcmV2ZXJ0ZWQgdGhlIGJvYXJkIGlzIHN0YWJsZSBh
Z2Fpbi4NCj4gPiANCj4gPiBUaGUgU1BJIGRyaXZlciBpczoNCj4gPiANCj4gPiBDT05GSUdfU1BJ
PXkNCj4gPiBDT05GSUdfU1BJX01BU1RFUj15DQo+ID4gQ09ORklHX1NQSV9NRU09eQ0KPiA+IENP
TkZJR19TUElfRlNMX0xJQj15DQo+ID4gQ09ORklHX1NQSV9GU0xfQ1BNPXkNCj4gPiBDT05GSUdf
U1BJX0ZTTF9TUEk9eQ0KPiA+IA0KPiA+IEhvdyBjYW4gd2UgZnVydGhlciBpbnZlc3RpZ2F0ZSB0
aGUgaXNzdWUgPw0KPiANCj4gV2UgY2FuIHJldmVydCBpdCB1bnRpbCBpdCBjb21lcyBiYWNrIHdv
cmtpbmcgcHJvcGVybHkuwqAgQ2FuIHlvdSBzZW5kIGENCj4gcmV2ZXJ0IHNvIHRoYXQgSSBjYW4g
YXBwbHkgaXQ/DQoNCndoYXQgaXMga25vd24gZm9yIHN1cmUgaXMgdGhhdCBpdCB0cmlnZ2VycyBh
IGJ1ZyBpbiBTUElfRlNMX0NQTSBbMV0sDQp3aGljaCBwcm9iYWJseSBqdXN0aWZpZXMgYSByZXZl
cnQgaW4gLXN0YWJsZS4gQnV0IHRoZXJlIGFyZSBubyBpbmRpY2F0aW9ucyB0aGUNCnBhdGNoIGlu
IHF1ZXN0aW9uIG1pc2JlaGF2ZXMgaXRzZWxmIGFzIG9mIG5vdy4gSSdtIGdvaW5nIHRvIEtBU0FO
IGl0IG9uIGFsbCB0aGUNCkhXIEkgY2FuIGdldCBteSBoYW5kcyBvbiB0aGlzIHdlZWsuDQoNClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNzY0ODU4ZDUtNTYzMy00YWViLWFhYmUtNTJm
OWViMWViNTMwQGNzZ3JvdXAuZXUvDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5z
IEFHDQp3d3cuc2llbWVucy5jb20NCg==

