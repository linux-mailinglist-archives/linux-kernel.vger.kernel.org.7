Return-Path: <linux-kernel+bounces-740601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE342B0D64B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56701725E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF202DEA7C;
	Tue, 22 Jul 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iQHWbi5i"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632AA2DCBF7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177910; cv=fail; b=JxjfqCWtPpmedCp84vTFsMO+LPpDb0NwIfuA9UHEOafiDS9ds3pSQ6zG+FuIKfxhPlEKlQZWO0UymsVkZD9i2F2tTgJptHIcWqvt1b5jzuONREYvsRpONZ0po/tVRh+Z4OFZw7nOHv+/uk2ej6YVnpJ3Q09yJ6WGZpbNEBheisA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177910; c=relaxed/simple;
	bh=I74V2osVNYu2q2ZEuU7PoJ9b7//zjhM6FYODzO6kQI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SkUT4KTM1PmwZelfANZ5GYLJTavnxRbzye7VyBh4ZkojBoKEflmOOvJTajSnmUO/OBy8zlJzPPooVHKVBUtCbFGwcbQTWgOiJr2Rq4fz7n0+54zgx2O3TDzQwC8GnAJ2e0VYPxrq/b4rMSISGXIN5BWQejU3ZxEcFewDUYi9xHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iQHWbi5i; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrT8G6buQeWZWJuOZqf/ghv5q7VIhoafn5y9CwN9eJkzpmeqaKpX+v3bICFQRLr7cyJ3Gqz6c5rWAHpgGTdQ+6C5eip21vuyB4f5uhW+MvSjWPpkmjGt9HJX/l8da51Kz5H64krF6TfR+3WMlv4WXxCJwS7pbIOdWcv4q2JIfVhXeSmyad23+lWYWf12azJWSxN4SY5klLRx5Wv7Tjhb4+OwcGKSI9gXnLqN82C5gZu3PykMqVlKp/WE0VUMS50D3wCb+zUjdgYFoR3/ohXN4JCnoSxR57V+KUxXmfRUYyzg70LKXQe3ObHxultHqtJ1srY/2L+QzKMtlc69/H+1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I74V2osVNYu2q2ZEuU7PoJ9b7//zjhM6FYODzO6kQI0=;
 b=jCwDdGSVHgoALnR7nn9hTGpKnyK/ebXa532IkBnDTm7XYCKb8DIzYNlcX3iBGC3Fso1+fMcToIU0FOVzKQAtvqiBXynW+WaBcNIxIhIvdIMOVWqtgcwGFiQ4oEbTr2nRzkOebioE66umUVeuAIJPySJ9L4nER16lswpOGrp4KONmfTRufoQ9TESa+kyhNsKt0/iYWCYBGGWFDzHI+9LkXrvP3EmoFGeosVgHPhpxb66wqtCbrGsaonu16XQstVjek9yioJZZnZSlCsi32ih/7BCDGkOWtmOHDCfIjQsugGppgpFfHZS0OmelpamCVj6OfYAfQo9ye8Qma/rm2qgQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I74V2osVNYu2q2ZEuU7PoJ9b7//zjhM6FYODzO6kQI0=;
 b=iQHWbi5iv6pU/nE3j2yHZLeY6n/7WTGk5oXLetkxW2cKKu/WpgH2Rnzyoj/B89F1zjKRjwZS4fpsa5En7sUYOEdvms6B0V8MZ2A6rGPgOHkxPRguksYqnCoLnOSoFLG4CPCEPT3VSgGcZBdzNIGI2C4hyZF0+FpJfjR9wDiPT9uOrGkfABpIpmcnQDeellbRaH8sCqfxvyg5TUetGVIQkJKfeySvYLfjH4UM55NeTO3Iy2G0up+xcQ+YMqNdVo49vfszL76DAzpydHj4EPu2tEmFsIU7R9gYT0Amf5BP16HEXRYtukaIVDj93p0RAaroceqVFLNDoXjqT5PZRRnhpw==
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA4PR11MB9369.namprd11.prod.outlook.com (2603:10b6:208:565::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 09:51:44 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 09:51:43 +0000
From: <Balamanikandan.Gunasundar@microchip.com>
To: <alexander.sverdlin@siemens.com>, <bbrezillon@kernel.org>,
	<linux-mtd@lists.infradead.org>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup
 timing
Thread-Topic: [PATCH] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup
 timing
Thread-Index: AQHb6pmsVL1Yfp21NEeuFkipLHpM9rQ+Bz4A
Date: Tue, 22 Jul 2025 09:51:43 +0000
Message-ID: <24142dc4-a3a9-4d17-bc85-913cc9a56261@microchip.com>
References: <20250701133333.3871085-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20250701133333.3871085-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|IA4PR11MB9369:EE_
x-ms-office365-filtering-correlation-id: ecc40f1c-a6af-41fd-c236-08ddc9055d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmJFa2NtUktuZExDVG5GVFRVQmhwQXExd2MyVXVWa2ZCWUxZUzA2YXFqMDVj?=
 =?utf-8?B?VnM2SDBhNURaY0hrYTZHRUYxK0FkYlkvVlpKZmQ3bGFselcxeVMvTFd0KzJ0?=
 =?utf-8?B?dkU4U3NOZGZRcUFGL3REQzF4cFlSS21kdzlXNzhqNnJ3eWRrT3hxQmZvTHVY?=
 =?utf-8?B?WUlKTWVvcVdDTUdHOFp0TUZ6dlNQcXlUVWxlaWlQYXVOSWh3STVBVWx6YjZ0?=
 =?utf-8?B?dW42MGw2eUIzV2dLNytUdjNldUd6MjRsTStndmZqR0g1UXdZcFdSeVZmS2pH?=
 =?utf-8?B?NkhPYkYxSmZCclhDcjJjdHVmbSt6WDFnVUtqM3pRZ1ZleUZKUDBzaGwyMXpn?=
 =?utf-8?B?RElZdlRKY0o4QmdDdWVmbC9hN1N3Syt0T1pLMy9SWXNQR0MzOFJPWllSQjd4?=
 =?utf-8?B?UWJkZk1ZMFR6RGgrektmNWlEYjNNckFyWkxZVmdSOUNCTFlzZG8wazE2RmJ1?=
 =?utf-8?B?eXNtWHFEZ0ZNR1NHTndUb0l6S2M0aEh2MnJWRVBPclZJaVpMM2hYV0M2b1hG?=
 =?utf-8?B?c1NsT2tqWTMzZnBjV1ZGbFhhTStQbU4zN3pYajlDVndkUEwxY3Z0VmREYVE0?=
 =?utf-8?B?QUxtRTd5MUlBTld6L2pWZnFFclBjRkNycUo0Q3R4OWJkRmdSMkFucUxQU25y?=
 =?utf-8?B?YjhLelFWN2FnN1lIaDhwK25TN2JHMWFEMTdqZVQyanhnRENsS0JVdDB5VHVw?=
 =?utf-8?B?MFVoNFZzUjBIbGFEZzFLSldzdmlsYWdhZUYzT0FWcWxQcGtVN3lHNE9Edi8z?=
 =?utf-8?B?ZmNtblkxdEZraXJFVlYxUjBkZmNCU0JLSFdxckJvckI2TFl4VDN5dEYxdWs5?=
 =?utf-8?B?cnNGOUY1cGZIRnUyVTI2T25FVkNod21xN2xITnZCdDNEeGhnb0tsdUdYb0pT?=
 =?utf-8?B?VUpGSXhQMjlJZmhRZ1RJQXBtd0I3VGJNRllXenl1YktoNmVLOXNtWG5taWxu?=
 =?utf-8?B?cVA4dGtRYXR1ekt2SzRXdlFZQXpEck1IR25GVlZRdUh2ekJHSUFJbHFHbEVK?=
 =?utf-8?B?M3M2Snd2RUIwMy8yUVJERHVYa29Fb2hiWng3TWVpdjFPYWk0b3ZNeS9xZVR0?=
 =?utf-8?B?L2htQVp5L0NGNldyRmM0QmNZTEdzYmFzNmZ4c3YyRTl5R1ZnUnJCR1BSUWIr?=
 =?utf-8?B?RHU1dWR0UldQTHlGZUdxby94VURKMWZ3TmJieU9SNE94d3FVSnRYcmdHU2o4?=
 =?utf-8?B?Q0ROUXAzVjg4d0grQkIxOCtUYXVtcnhLTDQ1L1VldUVXbUQ1azA1WVU1blJI?=
 =?utf-8?B?WXlLWUhhQ1JocHlSMlVqVHBYejNKc0VqQWV5RG9NQzBDWVQ2QWxORFRJVzFL?=
 =?utf-8?B?UlZ6VWovS1dWMjBYM2Fidm5EOUJXVEJpM05wbWhMSDRrdk5ES0RXNlgvQzBo?=
 =?utf-8?B?WGtYdzRSQTRSVU9iczRHOVpZSDhVSTFtam40VXIxL0dQWHZCeXJUUjVTZ0Jt?=
 =?utf-8?B?SXphZHFnVWFrQXRJd21oeFVnWTMyYTZyZDRwamJqcmNyVnBiSTMxUnZ5UG9C?=
 =?utf-8?B?ZkZRNEMyRWllTFlrUUpUMHJrUTc5V0ZNaXJYZGZLZjdoakgxbDJkdFcwUmdh?=
 =?utf-8?B?dXhqMGJmNHVGTlAvTm1vSXhFU1NNY1Jod2ZxU2JnYm52MzRua3B0RVJCeHQ0?=
 =?utf-8?B?SUZqZGtLMU9WTVpjajJqMFdOZ3Z2aXFCMHNIQWZtVHd1akM2Z3lhRFZobWdy?=
 =?utf-8?B?ZzR3UmF3enVKZWRrUklCVjYzcHVMVGo2VEFoK29BTnNuUTdVQ2RRd3I5cjUr?=
 =?utf-8?B?cXBUcFhqaHVBSmN5cnVrUWxzd0ZjSWZ3cHYycFBzWEU5UVhsUWNoVzJnZkhL?=
 =?utf-8?B?Z0swRzNuZTNNem5ld3RTclFDUVRxSkUxajZIdmxvRmdZaVdHUGF2bGxORnFo?=
 =?utf-8?B?bUs4THlJNmk5VnJ5RENZL1o4WjZKUUJGZVRwSllZZTVYUEtXQ1VDVkJQSGJM?=
 =?utf-8?B?cmlZcmRxT0hxL0p0TGVoeTRvZXhBRWpWQlNLMXdIbUxsc0NNekEvRVhuZUZj?=
 =?utf-8?Q?5F5uKTIpbFB44D2mnel4VBOresLTUo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm1rODZsOUlYRGNPN1EvU3ZmYiswVndMSldXbE5HU3RzMzRQVHp0TXB3M3Ft?=
 =?utf-8?B?bFByWHlwNjB4a3BHSytpQUFBQTBwNjlLSjUvRVkyUjlnVzg0V0pRWEl0SFpt?=
 =?utf-8?B?MTRpMHR4bWZBcmpIcnRBNDlQVEs2dnhIUTA4V2N4VGNweHV6RjhPWXpYeVZL?=
 =?utf-8?B?S0pmS2R3VzF1UzRMMHJHZ2pRQld0cFB6dWZwc2JsNUszM0dzWm9ZTWNxeHpi?=
 =?utf-8?B?UnhoVkxiTFVrMm5UTmZiWkdicnNvSHBobjdtMCtLUWNCMUc1M0RwSUJGc25K?=
 =?utf-8?B?NThDS2RhOHFzRVlxNTBWcHB1MnBwdTJnZk1nNVNJMWlnRXpZRkFaUWJzWTlC?=
 =?utf-8?B?NlZBa0xibi9LK2VxWk5TMzN0NzkxenNZd0VxTHRvbTduTWJvUWdUL3hCeFNv?=
 =?utf-8?B?MTdEMVRJdUk3N1ZoMklRdURPS0VMcXhQb09LNXpoT3RNVzRySWZ0bWlidHRy?=
 =?utf-8?B?eXBlMzFRSFd5eVZyNHJOUmp1N01HclM4TUlML1JlVWI0bFNCb0h4enVWUU5P?=
 =?utf-8?B?bjRRR1FLaDFTSHc4TEM4bWdsQ1pjOFhMdHMwQVc0UmdYMlZLRmhQYjdpNU1I?=
 =?utf-8?B?QnEwSG40RkRzZGxwdmhqdjJna0o1Zy9WNUpkVmlmTTdObEthU0ZlSnNUUGRm?=
 =?utf-8?B?RUZJU0hLbnhnS0pmelJzckVNYWw4OXAza1hiUjNxZy9HOEZ5dUFBanQ3RUp6?=
 =?utf-8?B?RGUwZFZUK3BBbGtSV2RQQ3JqaTRWUmx3K3pxT2JpQlE5SzhiVlgrSWFrS0U2?=
 =?utf-8?B?ZDVtSlRUZTVjUzAvMzlFUnpHMW56UlljRHdzZmRuSVJpUmwvQ0dYM1JWR0lr?=
 =?utf-8?B?azl6aVp6Sk5NdDBuWEx3SnJRS2dVTjBrSmo4V1hzNng5WnBWWjFMcktPSVlH?=
 =?utf-8?B?NVFsV3RrcjdlcEtJbmpvWjNPUFZGd0hnc1hIdXNnUHcvUDBBWk93SWE0Yksv?=
 =?utf-8?B?Mktlc3lXSUp5OHBxejV3ZjZDbXlzd3EvUEk5MkxaRTd4ZDhEOXZlVEN3aW9I?=
 =?utf-8?B?VGdqYjFTSnIyWXpna0l4SHVNV291N1RWaS81cktZUHlFYngxUHNOenFGRTg2?=
 =?utf-8?B?T1R6Z003d3A2aWZtMzJhcllwaGVFc1pySHFsdmxrcTlVU2tGMkJuL25JTGV4?=
 =?utf-8?B?QmI0cXN1dFhkTktqYWdzU0Vxd2RBVEI5UHVpdENEL0RKZEhOSEVpSk9IWE51?=
 =?utf-8?B?cElYZSs4emJOcDRCcnpFb0NkRStEZzA4TkxXRXNmSDNwSjcyM0Z5OVNEeU5h?=
 =?utf-8?B?TGFTRkNNQkU2bldVdW5DMWE2MDJpamg5Q1Bac0VUYlZJYmJ1S1psaGhSY1I5?=
 =?utf-8?B?bUx1bHo1Vm5YOGVlVlljS0Fvd0FyaTMwYVpKbFNvU2ZsYXVQaVg4UHNPRkt3?=
 =?utf-8?B?aElRbHpISndZczNBMFVUYUtCVlczckR6dG5xMi81eUlUK1ZHKzVUUG9EUnZE?=
 =?utf-8?B?MGFyaHU4eis3Mk43VTZmVEVTamxRaEJvQlo3cnNmWTMvbFA4VXFGRmpqaU9Y?=
 =?utf-8?B?SENkVUt2alh5QWk5MTZIODBlcCtrNWlmQUMvT3VJeTFPOGxEbkFVV1hlRG5S?=
 =?utf-8?B?R0FVU243RVowOTBqZ3lWb2ZtMVJIaUtreVZieVV2T3ExeXVrKzZKSnRlbE1r?=
 =?utf-8?B?ZldlOERVS3ZmRHlsVmJ5NVVQc2kzczk3Uno5QmNiSGhKaVdVR2dTZVo1b0t4?=
 =?utf-8?B?V2Ztbk5WUFl3eFl3WUNkNG8vcS96Umhzdzhib1FrdVNSQmgzV2w2RWFES1R3?=
 =?utf-8?B?a2ZJUStsQXRuOVc1MDRZSXhiTjhoQkZDTkRvaHpmU1NvZ3l6ZUNuWENkb0tI?=
 =?utf-8?B?V09oWHVhb1NMY3o4RlNrVS9Lc0h0ZHhZdDc4QnVvQTBBWnd4Tmpiamk3RUZM?=
 =?utf-8?B?b0VBNFRWUWdHVFBieVUxb2JnWUNjTWh0bVZiTUk5M0NldGFjeTkrdWM3S1ZU?=
 =?utf-8?B?ZCt5SEF1QVQxc0pnTmlVNDBYRjM1R1JHdXNFakkyVTdrSUYzSEt4NDlkVEwr?=
 =?utf-8?B?OUlsblJsUGk4SzVxbnVYejArSXB6anRNbndiWWh5bWkvUmNUajF6QmpsSE5q?=
 =?utf-8?B?M0hyR0VnUlAyVkhxYTQ2OWl0TXBpVHdCQmNvcllLMDlWdU5tRVFzZzRhTG91?=
 =?utf-8?B?aVJVZ2N6bFlLcmhkdVl3bXphVDlEVmVJRVRjMDhJcGc3OS9CUTZ2Q2RzaXFz?=
 =?utf-8?Q?yPKeLR8jhrkOI5WzxrjHR/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F92D924ADCFF74418C7DDBA4CEB52B4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc40f1c-a6af-41fd-c236-08ddc9055d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 09:51:43.7228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4sXPBBKtgipRXlTa4ZSric2bcjWD+0m08RndVm2TIshLQurwK79hkX0msF1mOZaPjL2DnrP6ahs7m7VjuUS1Mwpt1agV88kYu1WXrQIsQFFaSXdnSs93elldnhA7ipt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9369

SGksDQoNClRoaXMgY2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUuIEJ1dCBpdCBkaWRuJ3QgYXBwbHkg
aW4gYW55IG9mIG15IHRyZWVzLiBBbSANCmkgbWlzc2luZyBzb21lIHRoaW5nPw0KDQpIb3dldmVy
IEkgZ290IHRoaXMgcGF0Y2ggbW9kaWZpZWQgYW5kIHRlc3RlZCBpbiBmZXcgb2Ygb3VyIGJvYXJk
cy4NCg0KVGhhbmtzLA0KQmFsYS4NCg0KT24gMDEvMDcvMjUgNzowMyBwbSwgQS4gU3ZlcmRsaW4g
d3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTog
QWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IA0K
PiBIYXZpbmcgc2V0dXAgdGltZSAwIHZpb2xhdGVzIHRBUiwgdENMUiBvZiBzb21lIGNoaXBzLCBm
b3IgaW5zdGFuY2UNCj4gVE9TSElCQSBUQzU4TlZHMlMzRVRBSTAgY2Fubm90IGJlIGRldGVjdGVk
IHN1Y2Nlc3NmdWxseSAoZmlyc3QgSUQgYnl0ZQ0KPiBiZWluZyByZWFkIGR1cGxpY2F0ZWQsIGku
ZS4gOTggOTggZGMgOTAgMTUgNzYgMTQgMDMgaW5zdGVhZCBvZg0KPiA5OCBkYyA5MCAxNSA3NiAu
Li4pLg0KPiANCj4gQXRtZWwgQXBwbGljYXRpb24gTm90ZXMgcG9zdHVsYXRlZCAxIGN5Y2xlIE5S
RF9TRVRVUCB3aXRob3V0IGV4cGxhbmF0aW9uDQo+IFsxXSwgYnV0IGl0IGxvb2tzIG1vcmUgYXBw
cm9wcmlhdGUgdG8ganVzdCBjYWxjdWxhdGUgc2V0dXAgdGltZSBwcm9wZXJseS4NCj4gDQo+IFdp
dGhvdXQgdGhlIGZpeCB3ZSd2ZSBtZWFzdXJlZCAtMm5zIHRBUiBkZWxheSAoUkVuIGFzc2VydGVk
IGJlZm9yZSBBTEUNCj4gZGVhc3NlcnQhKTsgd2l0aCB0aGUgZml4IC0tIDYwbnMgKHN1YmplY3Qg
dG8gbW9kdWxlIGNsb2NrKS4NCj4gDQo+IFsxXSBMaW5rOiBodHRwczovL3d3MS5taWNyb2NoaXAu
Y29tL2Rvd25sb2Fkcy9hZW1Eb2N1bWVudHMvZG9jdW1lbnRzL01QVTMyL0FwcGxpY2F0aW9uTm90
ZXMvQXBwbGljYXRpb25Ob3Rlcy9kb2M2MjU1LnBkZg0KPiBGaXhlczogZjljZTJlZGRmMTc2ICgi
bXRkOiBuYW5kOiBhdG1lbDogQWRkIC0+c2V0dXBfZGF0YV9pbnRlcmZhY2UoKSBob29rcyIpDQo+
IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNp
ZW1lbnMuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNv
bnRyb2xsZXIuYyB8IDE3ICsrKysrKysrKysrKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMgYi9kcml2ZXJzL210ZC9uYW5k
L3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0KPiBpbmRleCBkZWRjY2E4N2RlZmM3Li44NDRk
ZjcyZjQ1MDYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5k
LWNvbnRyb2xsZXIuYw0KPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNv
bnRyb2xsZXIuYw0KPiBAQCAtMTM3NywxNCArMTM3NywyNSBAQCBzdGF0aWMgaW50IGF0bWVsX3Nt
Y19uYW5kX3ByZXBhcmVfc21jY29uZihzdHJ1Y3QgYXRtZWxfbmFuZCAqbmFuZCwNCj4gICAgICAg
ICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gKyAgICAg
ICAvKg0KPiArICAgICAgICAqIFJlYWQgc2V0dXAgdGltaW5nIGRlcGVuZHMgb24gdGhlIG9wZXJh
dGlvbiBkb25lIG9uIHRoZSBOQU5EOg0KPiArICAgICAgICAqDQo+ICsgICAgICAgICogTlJEX1NF
VFVQID0gbWF4KHRBUiwgdENMUikNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICB0aW1lcHMgPSBt
YXgoY29uZi0+dGltaW5ncy5zZHIudEFSX21pbiwgY29uZi0+dGltaW5ncy5zZHIudENMUl9taW4p
Ow0KPiArICAgICAgIG5jeWNsZXMgPSBESVZfUk9VTkRfVVAodGltZXBzLCBtY2twZXJpb2Rwcyk7
DQo+ICsgICAgICAgdG90YWxjeWNsZXMgKz0gbmN5Y2xlczsNCj4gKyAgICAgICByZXQgPSBhdG1l
bF9zbWNfY3NfY29uZl9zZXRfc2V0dXAoc21jY29uZiwgQVRNRUxfU01DX05SRF9TSElGVCwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmN5Y2xlcyk7DQo+ICsg
ICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsNCj4gICAg
ICAgICAgLyoNCj4gICAgICAgICAgICogVGhlIHJlYWQgY3ljbGUgdGltaW5nIGlzIGRpcmVjdGx5
IG1hdGNoaW5nIHRSQywgYnV0IGlzIGFsc28NCj4gICAgICAgICAgICogZGVwZW5kZW50IG9uIHRo
ZSBzZXR1cCBhbmQgaG9sZCB0aW1pbmdzIHdlIGNhbGN1bGF0ZWQgZWFybGllciwNCj4gICAgICAg
ICAgICogd2hpY2ggZ2l2ZXM6DQo+ICAgICAgICAgICAqDQo+IC0gICAgICAgICogTlJEX0NZQ0xF
ID0gbWF4KHRSQywgTlJEX1BVTFNFICsgTlJEX0hPTEQpDQo+IC0gICAgICAgICoNCj4gLSAgICAg
ICAgKiBOUkRfU0VUVVAgaXMgYWx3YXlzIDAuDQo+ICsgICAgICAgICogTlJEX0NZQ0xFID0gbWF4
KHRSQywgTlJEX1NFVFVQICsgTlJEX1BVTFNFICsgTlJEX0hPTEQpDQo+ICAgICAgICAgICAqLw0K
PiAgICAgICAgICBuY3ljbGVzID0gRElWX1JPVU5EX1VQKGNvbmYtPnRpbWluZ3Muc2RyLnRSQ19t
aW4sIG1ja3BlcmlvZHBzKTsNCj4gICAgICAgICAgbmN5Y2xlcyA9IG1heCh0b3RhbGN5Y2xlcywg
bmN5Y2xlcyk7DQo+IC0tDQo+IDIuNTAuMA0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eCBNVEQgZGlzY3Vzc2lv
biBtYWlsaW5nIGxpc3QNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1tdGQvDQoNCg==

