Return-Path: <linux-kernel+bounces-893452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D9C4775A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4796F4ED6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B1323406;
	Mon, 10 Nov 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HJ+zyFmB"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2E322559
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787368; cv=fail; b=lFGGEeWoamEcYrvH8mrgzNHHl5XB5ewPEBTwCSOZyYq8/1LUCMTRP1yaTs6AkuLf+D/Dx56cZ0hGIqUrYoh1lEztluryy9m5UYz8d4vtC7CCIaQjz2B307auKJhledL5sfKOOvzl+0/jjO0Mxvk8Z37gemsqwY0zftbdlPH48cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787368; c=relaxed/simple;
	bh=eSa3qZLyI09yU5rjLaEuYPoIxe/MgKjXkJp51i4A8sE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NdnjCn7yYkRt7otKz1M6fDJT/V7OzqKVYQ7mzybCuX/JpTxwPJyQ67YmRKsjZImWNPmrt2pPzSzNLtb3iy3FqrDh4N9DJtaCm9eawgS9QELom+20n3Glk8/uSibDksixHY3p2c06sGixqaKemLigscWJFs6GQx/VpoNQa1rY6zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HJ+zyFmB; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6RIw5vLllCZZgElMM6Ees391Yra7q32RFy7y6urSiOnjjM7QoRgbbJzdV32W0EndjXSmprgahvzWB8QPFRe+CD8y1DFKxOHIy3cpa81TO6eCQt3Ip7dHcqNmtKt/GPbe/tt+hiWhTEDCEIykRuSjz5p9u5BLF+djJBFDMORcN8JuTTukAPEC6Amj0oO52UGCq7o1sIOG0B1/Wb6XTLIB4SYhy3xhi5nIZRXnmeGPn5vZLib5ELMnD+XObihIKgIoVp8IcgqoZv/wojnXOsNTADurcmyPlUC/zQ8qw844n8NvohH72N6SXxyN7zsM+Z8RpWgQcebQTT2ziFk5bcerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSa3qZLyI09yU5rjLaEuYPoIxe/MgKjXkJp51i4A8sE=;
 b=uIAMgqVZPXwz/fZ6DF+UXd0whtG2bR7aF5Pp/VaAkjEy2OR2MRLHnZOq1vu7gZ6hDimeFq+B2wmhMfkHquhBsuI0Ap5BgO9YCUDEj6D5ZQi6PWppWj9De5D37Y4oTmIX2qIAOTd975FgjsZyHrBar3oby1yknFYhOP9iCRq/RZGgmUPeYWvYx68OhwMeU8jEhXMLeb16w5czPQsZwMFHteKi7BLkgddv6SCl3lm4911/PaQolww2N54iiPBdM7T3l674ymUL9SauRZUhntm0kwETKCyrvOZG+IF6bUVE9sKMSiXRTJlraRZUp0lcR0nsejyJj6O7FTgTQXILOUP/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSa3qZLyI09yU5rjLaEuYPoIxe/MgKjXkJp51i4A8sE=;
 b=HJ+zyFmBOzko0fKoYfeCeJsPPx6rcKu6ILHMVN/B7FBGXJKMixAdDffgmkGIwjsE49lvmg4YCw/aRTOhd4TwoUKGHneDxlUxybQMEh7YHofNwTfRbzeScmxtxLdFUAGpr8PScEK8IgwPresZ2MvVdZm25P0Cv1CsAo/qH27MHUynY3Arud9tCfEPm0MDcMBc3hhPZqEYwHcNAIbJAGZ2xG2HkFxpaxhSLQSnWeiW2oiRFAz1oeAphCeWoTMXo6Q3YXde/33XHmpNeM3kk8LDIiUo2OgUjbsduwYt4auKoBIAW7NqVyoJkQCF6pkEIi7DRGoTVJ5ZluRIwdhEnycpyQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB5679.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:315::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 15:09:23 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Mon, 10 Nov 2025
 15:09:22 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "hui.wang@canonical.com" <hui.wang@canonical.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Topic: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Index:
 AQHb66DA/2ST5DqqmUGvisuiiSELdrTh5/AAgAICrICAAIdYAIADcAkAgAF1DwCAABN+AIAAB2uAgABO/gCAAw/HgA==
Date: Mon, 10 Nov 2025 15:09:22 +0000
Message-ID: <c8f51ece1db461a1606106ac6e8a135475914951.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
	 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
	 <2025110513-manliness-repayment-d005@gregkh>
	 <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
	 <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
	 <eb0cd539-9d76-489a-b5f4-ecef2a6d32dd@csgroup.eu>
	 <a88e1546-1530-4326-b0ee-dc4e50d0343f@csgroup.eu>
	 <cd174dbaa3171f92e083d5dca89732aa64e32f15.camel@siemens.com>
	 <ad87d404-3d93-4c7e-908a-d9f47daca4b0@csgroup.eu>
In-Reply-To: <ad87d404-3d93-4c7e-908a-d9f47daca4b0@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB5679:EE_
x-ms-office365-filtering-correlation-id: 30229295-131b-4f20-cbe6-08de206b2186
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkdGc3BPRFZncTcyQ0FqZWpkc1ZDQmZFUDRaR0tmYjdrOE5WdDQ1NndmWm9X?=
 =?utf-8?B?VExxMmpkVEY4OFpNdVRRaUFZaG1RV0Evcy9XUmlZS2EvUE93dTVSWGRUaXRy?=
 =?utf-8?B?bDZndm02MVAxV294cS9tN2oxTU5SUnNVclpHOTh6UWJDb2huRzhmTlNWWjdi?=
 =?utf-8?B?SUtzbTNrcFBPVFlZZ2pZOGhoK0l3U3dNLy9zeTZ3V1diaithTmFJODlibVk3?=
 =?utf-8?B?Yjc4elZBdU5UUjh3TEVJaDc3K2oyZldvWjYxa1ZIRGE1N1J6SUpldmtEN3Z1?=
 =?utf-8?B?aEl6VGMyY05kL2lLeUZBMmZrRFVGdy9CeWJ2dysvMmVxMlhpTnZqWm9PWCtU?=
 =?utf-8?B?cEZVQXlYRzVaek4wTjF4RlVpV0hQcEFQVjdnUnpwZCttZllEc242a2F3NHZ1?=
 =?utf-8?B?SllNRHVVZGJqKzM3YVdOOFZRdTZsNk9GZjNTbFJxQjdNb3MvT04va05IcXQ0?=
 =?utf-8?B?TWNKSVVqTjVQTFpOdHcrNkt6Vmh6N3BLalYwSXhsWW9pZTdyc0NEVEhqZWx0?=
 =?utf-8?B?RGxKV0dIQytFWUVxaml2dGFhcWFaa24vZ2lOT1ZLZGEzVWpwN2xCV0l5eXBa?=
 =?utf-8?B?TFNIMk05dTA1cUFHRnhNTUtZcHI0WXdMT01VUGZsNnFnOWNBS0Mzd2MzdFcr?=
 =?utf-8?B?NWtJbWF0RG1ldDN1NCtQSDB0ZTBvdnJUNnJqUExZUjhLNnJMbVE0aFRmWGNP?=
 =?utf-8?B?L1NZV2tZSW9pN1R4eVhvaFAwZmtCZWZydE9VZTUrQnBLOUg5dzNQREs5aGdT?=
 =?utf-8?B?amczN0M5TkJXWWJaRjlZZFNtQ09EMDhCQkFxNTg2Z2ZPaE5OK2RtMkxVK1VU?=
 =?utf-8?B?TUZWNGdNL2Z5WWxZWUE3bUltSG1YQlhuWEpPSS9DYVhlTGU2RDFKVjlmL25x?=
 =?utf-8?B?R0R3VHhqMFVnMXk3SlhPVHNTYUkxczBWbmpZb0F3ajJvVTFrU0RFS1lWMXFm?=
 =?utf-8?B?bWhkZkdSUlcrdi9taW9NM09YZXJSSHFKaEk3Mm1jRmdhaFVXN0hBdW0ya1FO?=
 =?utf-8?B?TU82T3Z2dFMxWDA2M2RjVnJJaGJUZmd2TENyZlpEb1B3VkZKU2V3QmI2U0xQ?=
 =?utf-8?B?anI1ZFllNFEyNjdMVGY0bUxKSFY5RlJtN3cxem5JbkczUVJYUnRrdEVaMmRX?=
 =?utf-8?B?RVQyQ3BMUlp5QVRTaVU2cUs2elZsYzNqWGZ4cFBMZUYzRW43aW9jT0hON0No?=
 =?utf-8?B?Z0puZW1BbS9SVmlkZWxEdXFCbXFWMU5IQzZpaXF6eHZzTURmYWpTbWt2RkQ2?=
 =?utf-8?B?aEo5d3Q4RUZmUERnT201YURMWitERWZRQ2dOSGQrWStaNmU4TmZMTmVWSGdR?=
 =?utf-8?B?MGFNVHJhdTAzQVBBbElYcEsxLzJsWjZPWndpMjkzMnRjbWZaaWJMQjVqa0F1?=
 =?utf-8?B?YmlpU0wxYnZ0R085akZGakNNYitVTm5BRXowZmpFem4wNFZESDA4VVBUN1ZJ?=
 =?utf-8?B?RHFGWm9pank1TWw3NURsdzBnRE40eFJFSktMR3dQckZ4L09LNVMydFQydmlK?=
 =?utf-8?B?M0Q4US9TVUhSMjVpWmpIMUk1WUlMNGRiL2dXZ3VzVzJqRks4QzdCVFlLNUJE?=
 =?utf-8?B?WmN2R0NpRDlDVzNoWGRNRnpFd3ZMQWlVRVp3cWJMVDd6bEw2NjRHMTExVGov?=
 =?utf-8?B?SXhrSkcvbitRV3gzTFVYK0ZLRUdmbjFkWmo0NFVHM2NYL1R2QWtQcGRObzBH?=
 =?utf-8?B?bHh1Tkh2U1h6dWRjaHRPdmQ2cmM1OFdGMjVpMXg1RWdIK1U4cXR2TFRSRTJa?=
 =?utf-8?B?TnRXQXBuMkRBbnJmNWR4NFRTdFVuaHdLWTFTZHdZa2VsK1IwMmRJUGU5RjNq?=
 =?utf-8?B?WWVoaVpiazdVOVh4a2VZRVVMWjRvak1HTWc4VThjTGRXVUE3V0lJUHZ0bG5l?=
 =?utf-8?B?VFBETzhmS1NLb0w2TE5HMGdqRFBmUlhXT09NU3lCRjlTT0d1SzNZeElidjRs?=
 =?utf-8?B?b25OZTQyK3hnZkROR2JQZFNNdUdUSC9HaUNiUWRqdkdra29yaS9nVmlMa0lG?=
 =?utf-8?B?Z3ByMUNFcnpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXZiQUUrdUloRHJTazR3R01YdENHZmxsMm1MQlFONWd5VDBad1VTYnZQV0Fp?=
 =?utf-8?B?MXlBdDZaU0FGNVlQRmwvWUFRclI0K2VBbVdNUkZrRkw2OWJoVEV4a3Z6Z3RH?=
 =?utf-8?B?bWFxUk1qMEFpVk5JOUVuTjNGUFRaOE1pWlJveFJ1RmxTT0NzdUMyMzRHM1Bo?=
 =?utf-8?B?NVN6eDd0RC9uWWpiMjFiTUYwS3BUczVKb2tPc3NHZTVlM0cwWWFxcW0wWWcy?=
 =?utf-8?B?ZEltUjJDU2hkbkpHVlQyZFQwcHZsUzZpOHpTY3ZrU29jWXRKMDFsZ3o2eUl2?=
 =?utf-8?B?UW1adzk3TW1adzBqcEhGYW56d2lIc0NTczF2YkRTSXlkQ3l0U0tFNGlWRUVh?=
 =?utf-8?B?T3UwbFhJUVVuU3F4dG9walluM09DakxnUjZzWmNsS09ZeEdzNGxLc0tPWGQy?=
 =?utf-8?B?LzZZT0NseGZGTE9CTDdnSjVJYnJzYWh5ZkhjbEl0WEVVdm82R2NnS05vNWFu?=
 =?utf-8?B?S1ZGek5FdHpLc1NGVkU5UHN6aENtMk12YnF3dDdzY2RLK254amZtL0ZhRDNY?=
 =?utf-8?B?djRmR1NmVVg5d1lhMnlrbnpVTjNzZld3c3AvbUNwVVFNbEtLVW11RkNieU4r?=
 =?utf-8?B?MUpITFZhVlhVRlhXUDgyeU55M0ZnYy8vWi9pZDlaU3Mxb3IrM0hoU2IwUjNH?=
 =?utf-8?B?dU96NjRQbFV4UTVpY0ZaUVlOUjBZaDVIRHNJaVZoSnJMb2ttOFdwZWRNR0Nk?=
 =?utf-8?B?WHJmSjdNM1FSYVRZRUpBRzBOaDZhZVFvVHorRllhWEJHeGhsaGFiZVNvaWNG?=
 =?utf-8?B?TGNmWWMrVmNkdE16SWs0c2RYeFJ3NXlBdGE0Vm84bGVrWE10ZklSQXdwZTRw?=
 =?utf-8?B?bTA5Y21qTjB3WHNrKzBGY0ZlbTBjcGt1a2RCcm9VbHBlcVJqTWtHdVFuNy9G?=
 =?utf-8?B?SThySzFscjNnMGo5aVBxYUFuTXQ3QUIwTUtqdVNCN2xxeHRxQlJ2UW9YcjRR?=
 =?utf-8?B?UEg1YmtOdE9VeDlCejl5Z2ZJQzlsdFRueFN2Q21TcDZ3YVNZeG9wSlQyaDhT?=
 =?utf-8?B?VzlzN2FIKzd4VlFqVXhhT250REFoOXpEV2lqYXd5b2hLKzJFZ3QyblZxbk5m?=
 =?utf-8?B?Q0htSmtoUWVOZktkbXphQWFQV3YvSmttelBGMGozaUpaY0M4WlhXTXZBVWtp?=
 =?utf-8?B?eWF6bzFLRUN4eVlwVVMvT2FQeE5yOWI5bmFXZmE1Y2FxV1ZLMTJpcXdoanBF?=
 =?utf-8?B?N0JmdUF4R2pySFZ1M1F1amtpSXE1NkVUbi83TGVpNFY5ZFcybjBGdkpvcExo?=
 =?utf-8?B?TXhRMVZkRHU5cTVMRnNQYUZRMkxIMThCY2g5YXVuMnozMi8rM2s1VWF1ZWRr?=
 =?utf-8?B?VU1UL0U1WWJDTjZKRk41ZnBYSjREWmhmS1RQbUp0NkdkZkVya2IxNlgxbnRM?=
 =?utf-8?B?RFRRS09KNFpCNTFsNHVNSWZXUUl6NThvNEdnREpsSUpBZWNEZjU4U0ZwTk9B?=
 =?utf-8?B?K3V1ZnZvN1Rxa3NEZ2JWSGJSMnZIaU1CUWdERGtlNGx5TVdjSUJ3MkdpYlBj?=
 =?utf-8?B?dnpQRHJYTmxUQXd2MzlMdXFaQlJXVERuWnB1VVYwajVEb0ZBekdndmxSTENP?=
 =?utf-8?B?TklGeFBqbUNiYUdBQVVYMjdscTZ6S1FINWRnRkRVY0dFdUh3UmdPQTY0UXpG?=
 =?utf-8?B?L2JQUWxCNTZJUDRna3BDRVJwMjFaKzJQaEhUTkdBNi9pWkpTTm05MmhRbkZq?=
 =?utf-8?B?TWt2bDNyeXRPNjFlZncwQjh1TGN4cHQxaVlBN0JRVGNyK05IK2ZGYi9nMTFP?=
 =?utf-8?B?ZHhrTGg1bGFvMXZFZkJSdkNkNm5sdy9EeVBzSXZjUWhJemJJSVpvclA5N1h2?=
 =?utf-8?B?SlJoV21TQ1l3bHVwUHpuVzhFRlNFaUpXbW5pUFBFbmxSeXFhUW1sWlFvU0x6?=
 =?utf-8?B?N01BaG9QbDdPL3dBY1hjM2htUFlTeEFKdkJVNFFMSmRCOWM2alhRayt0dDRm?=
 =?utf-8?B?Zk1pYjh5alJnTkdaOUhjcnRFUzNjOGdMb0hpcjh3RXV6ekdFYTJNSURxVjc1?=
 =?utf-8?B?T05hcENGeVN4bnJ6UnBlazd3VDhjcHhqcmpVSGFwY2c3OElkZVhFbE5VaVFE?=
 =?utf-8?B?VDNEc2JsckN2c3BKWlZsK3c5N1g4bnRqNmpqNmlMZVYrZTB5UnZDdHE3T3NG?=
 =?utf-8?B?ekgzU3Y0Qm1rUzdGWGJJcTR6OUp3TXh0a09qbVc3ckl2TUdXOWd3RFFYalAv?=
 =?utf-8?Q?779FAfx3gOiVc8EX4tbImdg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCEBB5FA07C66949B9ADB412A77321DB@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30229295-131b-4f20-cbe6-08de206b2186
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 15:09:22.8602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4Q5xScmbLXdJwzqpliVb0w5wV9SBmEdfcmqgEMgTyq8wtlX4ysnqwj0biF4HL94o1DmIPofN9ZH4wUA2wQJ2K2W9oqguTq4YhvgtMKU8b4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5679

SGkgQ2hyaXN0b3BoZSwNCg0KT24gU2F0LCAyMDI1LTExLTA4IGF0IDE3OjI0ICswMTAwLCBDaHJp
c3RvcGhlIExlcm95IHdyb3RlOg0KPiA+ID4gVGhlIHJlYXNvbiB3aHkgaXQgd2FzIG5vdCBhIHBy
b2JsZW0gYmVmb3JlIHdhcyB0aGF0IHRoZSB0cmFuc2ZlciB3YXMNCj4gPiA+IGRvbmUgaW50byBv
Zi0+cHJlYWxsb2NfYnVmIChmcy9rZXJuZnMvZmlsZS5jKSB3aGljaCBpcyBhIGttYWxsb2MoKSB3
aXRoDQo+ID4gPiBzaXplIChQQUdFX1NJWkUgKyAxKS4NCj4gPiA+IA0KPiA+ID4gRm9sbG93aW5n
IHRoZSByZXdvcmsgb2YgYXQyNSBpdCBub3cgZ29lcyBpbnRvIHRoZSBib3VuY2UgYnVmZmVyIHdo
aWNoIGlzDQo+ID4gPiBhbGxvY2F0ZWQgd2l0aCB0aGUgZXhhY3Qgc2l6ZSBvZiB0aGUgdHJhbnNm
ZXIuDQo+ID4gPiANCj4gPiA+IFdoeSBkbyB3ZSBuZWVkIGFuIGludGVybWVkaWF0ZSBib3VuY2Ug
YnVmZmVyIG5vdywgd2h5IGNhbid0DQo+ID4gPiBvZi0+cHJlYWxsb2NfYnVmIGJlIHVzZWQgZGly
ZWN0bHkgYXMgYmVmb3JlID8NCj4gPiANCj4gPiB1c2Vyc3BhY2UgYWNjZXNzIGlzIG9ubHkgb25l
IHBhcnQgb2YgdGhlIHN0b3J5LCB0aGUgb3RoZXIgaXMgTlZNRU0NCj4gPiBrZXJuZWwtaW50ZXJu
YWwgQVBJLCBsaWtlIG52bWVtX2NlbGxfcmVhZCooKSBhbmQgSSBzdXBwb3NlIHRoZXJlIGlzDQo+
ID4gbm8gcmVxdWlyZW1lbnQgZm9yIGEgZGVzdGluYXRpb24gYnVmZmVyIHRvIGJlIERNQS1hYmxl
Lg0KPiA+IA0KPiANCj4gQXMgZmFyIGFzIEkgY2FuIHNlZSBudm1lbV9jZWxsX3JlYWQqKCkgYWxs
b2NhdGVzIGEga21hbGxvYygpIGJvdW5jZSANCj4gYnVmZmVyIGFscmVhZHk6DQoNCnNvcnJ5LCBJ
IHJlZmVyZW5jZWQgd3JvbmcgZmFtaWx5IG9mIGZ1bmN0aW9ucywgYnV0Li4uDQoNCj4gCWJ1ZiA9
IGt6YWxsb2MobWF4X3Qoc2l6ZV90LCBlbnRyeS0+cmF3X2xlbiwgZW50cnktPmJ5dGVzKSwgR0ZQ
X0tFUk5FTCk7DQoNCltdDQoNClRoZXJlIGFyZSB6ZXJvLWNvcHkgY2FsbCBjaGFpbnMgYXMgd2Vs
bCBpbiBudm1lbSBjb3JlOg0KDQpudm1lbS0+cmVnX3JlYWQoKSA8PSBfX252bWVtX3JlZ19yZWFk
KCkgPD0gbnZtZW1fcmVnX3JlYWQoKSA8PSBfX252bWVtX2NlbGxfcmVhZCgpIDw9IG52bWVtX2Rl
dmljZV9jZWxsX3JlYWQoKSAoZXhwb3J0ZWQgc3ltYm9sKQ0KbnZtZW0tPnJlZ19yZWFkKCkgPD0g
X19udm1lbV9yZWdfcmVhZCgpIDw9IG52bWVtX3JlZ19yZWFkKCkgPD0gbnZtZW1fZGV2aWNlX3Jl
YWQoKSAoZXhwb3J0ZWQpDQoNCkRvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9udm1lbS5yc3QgZG9l
c24ndCBpbXBvc2UgYW55IERNQS1yZWxhdGVkIHJlcXVpcmVtZW50cw0Kb24gYSBkZXN0aW5hdGlv
biBidWZmZXIuIFNlZW1zIHRoYXQgd2UgYXJlIG5vdCBhbGxvd2VkIHRvIGRyb3AgdGhlIGJvdW5j
ZSBidWZmZXINCmluIGF0MjUgZHJpdmVyIGFzIG9mIG5vdy4NCg0KLS0gDQpBbGV4YW5kZXIgU3Zl
cmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

