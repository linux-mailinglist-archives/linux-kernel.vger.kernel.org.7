Return-Path: <linux-kernel+bounces-757721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B800AB1C5EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404393B7982
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9D28A3EC;
	Wed,  6 Aug 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b="E6iB/iYW"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021082.outbound.protection.outlook.com [40.107.130.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501B221F1A;
	Wed,  6 Aug 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483711; cv=fail; b=NFN5zbS8e4SLiBd/Gh5U666X1gpQzLfcou76i5Lyx+H0yF8tsVFjP6ZzSf/racy/EDkHkxa8vfZmaTbFn2yic18NaOCrL1qG/3c+cUKhOHCT87xPLN+Lx4ItprlnfsTfgBhcUkUTM6sOLLqkg00/2u1Y4BLflS7REmeRJ8t5Go4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483711; c=relaxed/simple;
	bh=jzuAdVYG7cXxDXPRBF8q6KHWgBeCh/sa4RT0+O5Ad1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d9kPbqA5m9O5UWadB1y9lLKymIOxUXNALJHsmMrDd/wtsWunN8/qF+7qEb+z0iTHq+ly4yAMtbG6sc+Gh4TYLfjoEaZ4Vl+OUweqRdc3kp1pJbDLtKgAwZ5tpVTcwfJl8/MY6Rh1M7QJ0DTZPaJ6zZGFbsu9m8LTLpNJn67mmLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com; spf=pass smtp.mailfrom=htecgroup.com; dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b=E6iB/iYW; arc=fail smtp.client-ip=40.107.130.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIoeAkhrMJf3aA5DwCslgiDWxlaCAmMRhd3wFF2ufUkJyH9P6NxvEc1lle/X8XC0KDTz56DfR/cC26/aV/cXLOcfrn4mvAug4NDUwYg5Q3kfAvCgGMssk7qPY3Qg9Zd3xU/FYx4YA3eVLWIi8KSPOPpSE54+n8ESysIYZShjVPDHdGGNmOBP9CQiCGKcG2e1rSShoBbFzbS7lluKDtbjoGY2r2A0453g0CHxDfyn4aSd05FvIJhC37Osmm5hthkxpy1E9F3TtpRHaQ940xe1lG6VoeS8dFD1AMEAyrbc8tPyXqY9K8qCsCvNvCDC5/EZPe3Tb/Ua1QuqfGYP3UVZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzuAdVYG7cXxDXPRBF8q6KHWgBeCh/sa4RT0+O5Ad1s=;
 b=EMpaZl4wcKus5KsYYL/aKoa6KASQF9kbJpQgs6cTsOQdmZIZMbCor4XOdRknY8NJ58EgH5ZfYV7sk0Pm4it4TCyUUYaKRNPwI8ZhTrI3JwxpNlO6gPxlAvNRGGnwt0IBxg1EqrYW+FK/gaffdPRxep+7atqDGXfSBGIbcLgOw12E+9Hups7NERl3RPPuRz5a/K/IXQx+5t9mTm7MQL98RoZRWgVfDO+TQ8bGGmguwfTLwY0At2Fc4qVp1hdyvHOqOD69PJ0z7uu9IRzgEdRFAUPBnXgJYE5PNqkx6LLFVI/R57vCSnGkVbsM9C2HMgPOC2ivZjTIOqrPCwzdExPdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzuAdVYG7cXxDXPRBF8q6KHWgBeCh/sa4RT0+O5Ad1s=;
 b=E6iB/iYWpoxbDXNV8PHwMsevSYwLuw9sIZBmjkpVQ++HZHNP2L9Ieb8+9+vDtr03L1rD7rITx/AWZ+eObh9+FTl1+CyTcigLc0JcM/S+8T5S2dBzK3WLVTwjY+b2OdoGkQM7TJ2gihygL/afDSpPE6aDNdMPGFD72IVuIld2Xqki2lcAgiKsFAEQhhi0oI3k1+5Ua9ONZzN9em0WD+u90mGwUhJNW9Edn/nHnEcQCzTyRa3FERY3Sfk4YAUGlpdmW8zfTnLQOp2vfWpk60WVWS1+ZL1KOGDLidz9O3/Xq8v336bqa3ASppisl0NfHUAWbW33EwzFAJ+drKjPz+AvzQ==
Received: from DB8PR09MB3260.eurprd09.prod.outlook.com (2603:10a6:10:105::13)
 by VI2PR09MB7974.eurprd09.prod.outlook.com (2603:10a6:800:29a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Wed, 6 Aug
 2025 12:35:04 +0000
Received: from DB8PR09MB3260.eurprd09.prod.outlook.com
 ([fe80::cad0:cb5b:959d:f7f]) by DB8PR09MB3260.eurprd09.prod.outlook.com
 ([fe80::cad0:cb5b:959d:f7f%5]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 12:35:04 +0000
From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Djordje Todorovic
	<Djordje.Todorovic@htecgroup.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: mti,gcru
Thread-Topic: [PATCH v5 1/2] dt-bindings: timer: mti,gcru
Thread-Index: AQHb8q7KQoArbVU4W0Kikurwhoorh7QxO3GAgCR8PIA=
Date: Wed, 6 Aug 2025 12:35:04 +0000
Message-ID: <98bda141-9fd7-40b8-b5f9-5e83e333da93@htecgroup.com>
References: <20250714-wooden-ebony-turaco-a0accf@krzk-bin>
In-Reply-To: <20250714-wooden-ebony-turaco-a0accf@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB3260:EE_|VI2PR09MB7974:EE_
x-ms-office365-filtering-correlation-id: 3c47e227-0dc0-4a58-de36-08ddd4e5ab6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHNqUE8yUTd0dVFlcVlpYzd2alhaenp2TE1KVEN5bFlsL1QzSnVyalR6Tmo5?=
 =?utf-8?B?cUtod2VvV2NsVmpmaWg4d0Q2ZnNKdWFCTTlqK2NraXJUZ1YxcjJUa25KdlQ0?=
 =?utf-8?B?TG5LZmNTcHpCK05URkIvbDRUWGl2aS9XNnY3cXJ5Q3hVQVJhWGNFREVLdGNH?=
 =?utf-8?B?OVEvdUg2SnB4T1RXVUlUcWpTUE5pWjFNbzFoQ2pvQ1dlSTlobm1ySzVIZ1FX?=
 =?utf-8?B?RkFxSGxKeWp3bTJvL1kya2ZDSEZ6bkY1OERUNVV0R2V5YU8yRm84TEswZ2Qv?=
 =?utf-8?B?aUp5S2RKdWVEbll2cGNWU29NZEFaOG5pT1F3TWhNWERtbEozenZWdUgyc3l0?=
 =?utf-8?B?eXduUDR0ZnNaSWlDNmJ3YSsrWkVwVmRSZkt3V2JFRWpudEJzVTNjT1ViMXFx?=
 =?utf-8?B?bXcxMFJMS1c1SkI4bVJkSk5FL3hFdW90TGpheUN3MjVDRWIvMHdacHgxQW83?=
 =?utf-8?B?WVBncFdRYlRtRVN4OWd6WmZYZ3dSVzZFeTdqTGFWZ2NaeUFIbldvUHRCUWpI?=
 =?utf-8?B?VUhzNnlzNE93YlJvVVBpaTRsS0EzZFhJUXRwU2p5R2JPKys1RGF5ZGVGYmM3?=
 =?utf-8?B?SlBQYkE4c2t0OTlhQWQrWE1GUXJnTmRMT2NiTFVDK05OWS81Qyt2NjhSdkZm?=
 =?utf-8?B?N1BoNTZ3TnNnOHNDUVo5aWUvL1Q5TDg4dkZnbDgyZFplTC9nV0RDWjFvK0ZX?=
 =?utf-8?B?M1EyZDRwaDUvLzUyQ1lHWWFORWN1MWFocEFVTzFOQkdnZFROUDc1NzFFd0xp?=
 =?utf-8?B?Q0xVeGVrUGVVaFFuYnkrbEYyTGpiUU9mdlVLM1VScWNOZWhQajM3S3Zmbjdz?=
 =?utf-8?B?Z1lmYVpJcUhtMWFieVNrdGtHbERReHB4bkZMNWNCeCt6NUVsQUl1dWJLSnh3?=
 =?utf-8?B?aWJWS1k4SlhWZWFFM3Ivdkp6L29HUHArRU16OUlQUzA3UjN1Mkp5MkQzNkxP?=
 =?utf-8?B?WEZhVFlBQnozeEtNTVFhL3dld0N4aFZja3FzK2xzajNuUS9tV1F5TFIrSnZV?=
 =?utf-8?B?QzdmTHpVRG4vRmpyK3ZNUjJEdGJqanhsUnVHck5ZNTY5V1VPeTB3OVNRSCtS?=
 =?utf-8?B?cHhOWTM1VW5KOU1ZMm9rYS94MWdqM0ZlQ28zMTJoSjNQQU9lL2psV3pERzRr?=
 =?utf-8?B?MlpkWmhDTXl3dndQTXllMDhndUJpc1lkUG5EL3V6NE5hcGpkMWxIbnlvM1Iy?=
 =?utf-8?B?TS9iN3FXUTIwV0NUSEtDUmx2bGJ5cnhDdlNKNVZCWjlVRklCNkpLQUZ6aVBB?=
 =?utf-8?B?clA4VGZDYUp0WWlTcFF0WjE5N1p5RnBLZFNMbitwSHVCczVjMzhnQWNpUWFN?=
 =?utf-8?B?c0lsVWx0SUtkTE5jTlViRmJ6OWM0VTRsbTNuMzhvdEgrZ2lmN0tESCtzbHh1?=
 =?utf-8?B?MGQwWmcxTDhMZVRnRmJYYjF0RjFTMmVGLzBHd2pHelo3a3lYWGE5UEFuUldJ?=
 =?utf-8?B?ZmFxS3M3OE9HbDR6bTNPcGl1ZUs3L3ZUMnp3a2JGbzVmaktrcE50a1pKOWt1?=
 =?utf-8?B?YmlaWUNSeHdpWXVWUU1WVXhDNWZrM2paQmtxYk1aUEhyL015Rno2MlY3WjZL?=
 =?utf-8?B?V3loSlQ2eEQvT1BCTkNYVGdQaWlyUDVlbnFPclRsOXhxQk53UEh1amtzSEoy?=
 =?utf-8?B?c1loZnRWbVhZSDBQb09FU1VxczQwTnZ2VHZSa2hqREk2eVBvRXpGU21yVHpF?=
 =?utf-8?B?TFljMzluK0lZSFN4ZXIzeElRL0VwMG9EVW5XSitaajBuN2NkaGxmTjFUNmlq?=
 =?utf-8?B?dHVTWjNaakI2bUxtOTlyL0VUbmN0RzV2bk41Q2JEOHVLazJ3VFNiZDBmZzRZ?=
 =?utf-8?B?Ly8zMHdYUXVlbURWNGtkeFhYYW9sY0VBNXpjWitwTE11Wi9DazdGL3RwNStv?=
 =?utf-8?B?M0tkREFnUUovRE1oNVhRYmRER0QrUXpyZW5xRGV4NW03U3ZZSFFUWkxBeUhQ?=
 =?utf-8?Q?4YkiOo3kFC4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR09MB3260.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVdBNlNzRXVQK0NmUFRDQzBrM1M2Y1gxTHlMaWtEM0NSMjI0SE9sOGdiSWhY?=
 =?utf-8?B?cEdRY0xHdlJLaEg4TlQ0YXMwMysrcjdpMnB1T1k0b1RkeitlZWZJcXBJa3Rt?=
 =?utf-8?B?Q3N5SkVPYTNOdlhnWGcvSEtFYVNaUGNlQ29wZGt0L0ZMZ0swR2lCdGZ1dGhU?=
 =?utf-8?B?eGF3NWlGVCswQUpPSDRCOGhDR2NKSWFTQjBLcEw1dzd2NSt5NU5sNk1YYzdV?=
 =?utf-8?B?UU1rZHZoNEpQL1RaWkpIZlpUL1d5VUJlVzMrY2twMGhDUXFwWDd5d0FuTUdY?=
 =?utf-8?B?blZLOFBlVDZqd1A3VGpOWWtNcUpSQVNTZW15eFRoMUp2cXorbzNUZmVFNDlU?=
 =?utf-8?B?Qk55VnNYcFQ3ai9LZDdvVnpqcHFucVdsWnNXeUlaSlBuM3g3ZkFudk4zUS9r?=
 =?utf-8?B?cjRKaWlnU2tTb0ZGdGxPWkN4WlpYZW15bzRtSFN6QVNsWlZ0cy80Y3dvRWNS?=
 =?utf-8?B?VFZRNEYyMnhDb1FXYUZpa3ozSWpJb1hnMmM0SlpRNGE0eGRud0ZSc0ZrVk8r?=
 =?utf-8?B?eWhmMjJjUEoxV3FaekFsZXppclJpV3RzbSt0RTZ5TXFQTFFjRnY2Z1JZd0R2?=
 =?utf-8?B?a1UwdGVXWmJTaWtROXJaa0EvbnpLYTBqNHdDTGJhWjJKaU5jdkdCRmMzcmVQ?=
 =?utf-8?B?VlVrR3JJbFhaNklNcWRjMWFncFZ4WitlUlBFM3hEbzh3MnZOZUxydFk1QlNY?=
 =?utf-8?B?TlFmQTFkQko2YnlHM05MSUdHR2RScEpaamZpRXdVSE1EOE5zYWNTNzFxWjFr?=
 =?utf-8?B?STNQTmxrUDdSU0tMdXhWY0NJYzhvTURPcTlnUEFZVkhhN2dmTUY2Q0pmc3d3?=
 =?utf-8?B?VjZrRTcvN1E5djBhb1NHTHVmNCtFczJCVUdMcVFGenBVdGZibDlkT3E3RzVa?=
 =?utf-8?B?OTJpd2xnaUdxWHdLT0cvZEFmYVhIUkppSDF3VGlYN1V0NXo1UnhGVnNPUUJu?=
 =?utf-8?B?WFhOZVU1UVFIdmRJZWR5R05vVnYwQlExWC9qc2N0S0x1ZjErL2dQK0Zpdm9l?=
 =?utf-8?B?WXlhckJXd0lCRWpMVWZJUXlFczlHajlFRFVXRGRlSnRLUmZGKy9wcVRUTU5y?=
 =?utf-8?B?VFRVMzlucEpjdWxNWE55c0JZaE4xbDBIa2VrWW9JVmEvdmtKakRPMkJKOXQx?=
 =?utf-8?B?a2hWSzNFbWludmJHVmhTUk5IRk9JZ09maEFFMGxtTElWekVBUlMzVUQvMzlN?=
 =?utf-8?B?SVhvNjZQUlpEMGI5Y3JsM3cxcjZac0hKTSt0UnJRQnNURWd3UEl0cURsSndL?=
 =?utf-8?B?Mmw0dlBlUkdBQldVaU5wcnc0UDFVYVg1bEFTUnNFYzExT3l4WDZMc0NHY2tW?=
 =?utf-8?B?TmxzRlQrWGdQZWNia2NyVlZZOUFVUkorOHBSbGNWY0NYaEZlUEZVREJjeEV5?=
 =?utf-8?B?ZXVTMXVBbUVTSmpMS05NN3BnSHo0alBidUxaQXBWQ2xpMVY5M1QvZGNEeTh4?=
 =?utf-8?B?clRFendDZnMySzlNdXB0NGpWeHhYSlRoeUw2cFNRSVJ1WWNiMUo1UGh4RHJa?=
 =?utf-8?B?UzhwNjZHUUFlQmpPR09UMmhibmJqdjNWZ0tsOVRvdnp5SkxpdTJ6NDU2c1Fy?=
 =?utf-8?B?VDZqdzFwVEZGMjlMam52SXpXY0hBdTJBT2tjRGlSclRVVTU5cDlETXByd1Rq?=
 =?utf-8?B?YUpmK3ZRdWhLNmpUUzJvKzlMQXdGcHZVWTVKMDJzRHZic0VyenlCNldJNkZZ?=
 =?utf-8?B?Q1RjcjdVMnZUSnNJTEpGY3J1WDhlcXorMVliQ0tWSDQrSHFKV0Y4WXJFL3VG?=
 =?utf-8?B?cWdOMUlMWm9iVHB2UjNRZ1gyaVMrU3lOWDFtZXhjVlV3bTg0aXc2K252aGpG?=
 =?utf-8?B?dnpBd0xOMGVqam9HV1B1T0RKTzNJSk0zaUZRWDlSWjVISktKWExVTmxUQUd4?=
 =?utf-8?B?dC9DbzVhem5BbkpzK3BNL3ZHb1ZzaE5hTlI1MXVKY1lKanowUzFkaHBWaEFu?=
 =?utf-8?B?U3N2VWdrWkdReVZob3VpR0VJWWZ1WTZ6RHQrVEVxNjk2MWZKRTFVQW16cXA0?=
 =?utf-8?B?TDJTczdwODlpeStrUi9FekF1Y1lOS0FIK2c4VldtcE10M2QzcVBpa205dUlL?=
 =?utf-8?B?djNQaUZpQy9oOHZJT1AwQ0Z2dTB1OEZSSUtlVWRjZno2N2Q3MEFWdmhiZ04v?=
 =?utf-8?B?Sk9zaFR4OHVYcGNKakRMSFZTZWJjRXYxZlpGUGp2c3o3Mm03am50U1J4Yll5?=
 =?utf-8?Q?bqCKoLhY3UJL5tA3EJdC2GA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A216B63FD2E5884C83E580B47514901D@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB3260.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c47e227-0dc0-4a58-de36-08ddd4e5ab6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 12:35:04.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTcotYkUmAghREuqwIjkSbQMd1jCkoaCRX9Zdv52z/FyLbo/H8Y7NWFERBGWa0yJPejYkOTUsE9jdZX818psxlTEelhETu48VrbbRdfLwQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7974

T24gNy8xNC8yNSAwOToyNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCg0KPiBPbiBGcmks
IEp1bCAxMSwgMjAyNSBhdCAxMTo1Njo0NVBNICswMjAwLCBBbGVrc2EgUGF1bm92aWMgd3JvdGU6
DQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy90aW1lci9tdGksZ2NydS55
YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBHQ1IuVSB0aW1lciBkZXZpY2UgZm9yIFJJU0MtViBw
bGF0Zm9ybXMNCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gQWxla3NhIFBhdW5vdmlj
IDxhbGVrc2EucGF1bm92aWNAaHRlY2dyb3VwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoN
Cj4+ICsgIFRoZSBHQ1IuVSBtZW1vcnkgcmVnaW9uIGNvbnRhaW5zIG1lbW9yeSBtYXBwZWQgc2hh
ZG93IGNvcGllcyBvZg0KPj4gKyAgbXRpbWUgYW5kIGhydGltZSBHbG9iYWwgQ29uZmlndXJhdGlv
biBSZWdpc3RlcnMsDQo+PiArICB3aGljaCBzb2Z0d2FyZSBjYW4gY2hvb3NlIHRvIG1ha2UgYWNj
ZXNzaWJsZSBmcm9tIHVzZXIgbW9kZS4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29t
cGF0aWJsZToNCj4+ICsgICAgY29uc3Q6IG10aSxnY3J1DQo+IElzIHRoaXMgYXJjaGl0ZWN0dXJl
PyB2ZW5kb3IgcHJlZml4IHN1Z2dlc3RzIG5vdC4gU28gaXMgdGhpcyBmb3IgU29DPw0KPiBUaGVu
IHdoeSB0aGVyZSBhcmUgbm8gU29DIGNvbXBhdGlibGVzIGhlcmUgaW5zdGVhZD8NCkhpIEtyenlz
enRvZiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuDQpZb3UgYXJlIHJpZ2h0LCB0aGlz
IGlzIGZvciB0aGUgTUlQUyBQODcwMCBTb0MuIFdpbGwgZml4IHRoaXMgaW4gdjYuDQoNCg0KQmVz
dCByZWdhcmRzLA0KDQpBbGVrc2ENCg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
DQo=

