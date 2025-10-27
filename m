Return-Path: <linux-kernel+bounces-871104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029FC0C73F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFE418A4294
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3753112D3;
	Mon, 27 Oct 2025 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="eqlVqqr2"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010064.outbound.protection.outlook.com [52.101.229.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CF310645;
	Mon, 27 Oct 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554696; cv=fail; b=WdcdqNkzULPmNB+3ci6CsvDB3/sgNlLkN/1N/7cUPE7nuvsksZ3qgPOkt+Lv4igXSVArPo7KZxJ3Ksgj1xOC8qJ9zW9FxJxQUXburP1ysD7pJm8lo7H7DthtRKUrIX+k6rXDRYTscUwMxn9Lzgwy4df+7F5oyHBP1oSrprKyQp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554696; c=relaxed/simple;
	bh=e7j0MwbaoBrq8nhmWAlN34UHjmpRyd0bH9k1zkJH9Nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rIH67KG4UpihqrizeKwpjD43TBRAxSkkeRyqhfAaVVvuUSUYvpNCiKhc+oxCMvwO+bqFvP5T9ojUAkl0o6Zcl8r000wTBXQlV5S9834j1ukQj0j9E2YQtLniWy2sQQIoihtRP8/vY2N4bBfk5Lo1NwsUCLr2uiRl87XKnELF3AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=eqlVqqr2; arc=fail smtp.client-ip=52.101.229.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOAXCJ0hfA4sSifenrO80Rqd3Qy8k0LV8rliLaO7EHarw7hpyMRh/iHqB7uCwECoDR2/QSnfgCQRQTP2b/gYQMCa4sYBacjWrT+GARUt98vEOPw76Qe9WvlVDTnzLrmAKs0XkUQ6ZgyrJCMQqPJQLo8eaCrLeSTJ1aloJ0PdkagM8t3BEl2ks17rmePvCEQhRrAeMBwXztc0TmifTNKnD2N/HwzLwIXe6s1ISf1C9WdfjAQJWEiqOL0MRo95mODz1iTHE7zXzz6dNwZLqHGAUXLsfJ6/kUE4WA1tgwpza/HpA6nViijUbl4HEj0bIa58uBc1GPs5720qI51FDTKFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7j0MwbaoBrq8nhmWAlN34UHjmpRyd0bH9k1zkJH9Nk=;
 b=VygZPtjFRP32EZVU3baMHjQOmbmml9ERDGNpSPrRgpWoatIQ+HnrZL+Ix/tRpdAl5HEr/htmClq5V4ZecMOC4aWnhzytFeL5jyu+ucV8pdsRUqFDbejUOBSnraHyA8RwSS8BbqukdkovCOmjW11WqFOgaN2b0qRcJw9IwWRz6M356xlzw2j/sNH0sc/4mzUJu9WbUV1aGJWMzv7/ZFzStI5Bct02oUjeX4A1fsdEi6MQiIlZ6fcd8L3kbvD1/ikturt5G8/uwqUlCzJzbxpQDFKsMIpLh1A+HsmIZxMxL6l9JBRzVOZYe7ElzC4r5gMgYzGkJ0Ha3sOkVR40QD9IrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7j0MwbaoBrq8nhmWAlN34UHjmpRyd0bH9k1zkJH9Nk=;
 b=eqlVqqr2oxK1pQtwrm22Lr4tGH2djMIyp5gfls+BAml8Nk+5DrtSv2+rR0Gm0WM6hqgf83YyUkTekrD7b8HSKJ/uoITcapYoChsZHzKYgPsg78vWk2pz5gE7nYqwDJqOzaph/T/D7pVHWafJzdP+ona5RedyW+2o/RAY9CsegS0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB13754.jpnprd01.prod.outlook.com (2603:1096:604:369::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Mon, 27 Oct
 2025 08:44:49 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.9275.011; Mon, 27 Oct 2025
 08:44:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
Thread-Topic: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
Thread-Index: AQHcRxM5EedFYnj970OO3gpVzFQbFLTVmUIggAAQ5YCAAANhYA==
Date: Mon, 27 Oct 2025 08:44:49 +0000
Message-ID:
 <TY3PR01MB11346C11E93AF51BDBD964BF986FCA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-2-krishna.kurapati@oss.qualcomm.com>
 <TY3PR01MB113460779967E7BC8FEE11DEF86FCA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <e4ebf454-93ae-47be-bb12-2ab363812b1b@oss.qualcomm.com>
In-Reply-To: <e4ebf454-93ae-47be-bb12-2ab363812b1b@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB13754:EE_
x-ms-office365-filtering-correlation-id: 9f83ba32-228c-407f-5477-08de1535171f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmU5YlJNVjJnODdaZ3lTWUxHd1dmK09iMjhNZSsvV2hEU3VUUG4xR1NyMDFY?=
 =?utf-8?B?TGc1K3hWME5FM1g4dXR3eDBhWHY2Q0g3VWRFUkFkMnNFSkNhamtHNkxiM3gw?=
 =?utf-8?B?RU5TZjRySGgwYWtIZWtsbkVvRXkwMktTdUkyUU1SOFd5SEt0dkpXeVQyNjJl?=
 =?utf-8?B?Qy9peHphZmV4RnA2Z3k2OExFWmpGK0RkYVAzZlhqTXQwaWh3RmFQUHh2WWFR?=
 =?utf-8?B?dmhhMTBMZDU0TStrdk5GN0F4M3dCaFF6a2k2VmhaVkJNNWp3cFJUWWxpSy9G?=
 =?utf-8?B?bmVoT3JPMmdYakhvYVNJOUJvNTdNNVVpNGFySkRudnlLZUtrRXdlbGhtOURN?=
 =?utf-8?B?V3RZZnEydS94Uk1nOHY3aXJOOFJLVDh5djJRMjdoa3g1Q3hkV0VYNThsaSsr?=
 =?utf-8?B?ekRqTDJHT2prUnU0Y2VEOGpSb3hsVGdFcENzMXhBUk9TZXloWjJhTnV2SnZG?=
 =?utf-8?B?ZEpUSzd5WUkvZk5TUE9KNE8zdHZQYlVZak4zL2thdXkzb1ptWE9MOXRtT2ZW?=
 =?utf-8?B?YlU3dnkyNyt5V3VEUWlCSkt2dmpwNm9YamNpMUNDUXhRWkloNjdoN2dOOTdL?=
 =?utf-8?B?TTdRUHNHWFVTT2ZDR3V3ZktKcit2L3B0WU5xWVpmMGxjMGlkV1owVkJ3U2Y1?=
 =?utf-8?B?MENLM1BacmxKSW85eTA4YjBUaVliNEpScHY3STh5THNFNWN2eFVWNm5UZ0dE?=
 =?utf-8?B?VHZycTRLalVwdDRJeGpYQVo1NXdIMjdoa2RVcnhRNitvcEJsQlhqRFV4eWl6?=
 =?utf-8?B?Ukhhd2hmN0xub1NlRUN5R0NTaGN1M1piSUpiZUFYZFJSekhFaWVUcVFMck5j?=
 =?utf-8?B?NVZvdHJJNHJHU1JFbXdCR0pERVBDTHE1QVFrYXJqNXp1RHVZM2lVL0JsYjZX?=
 =?utf-8?B?bVJZTVU1KzlYZDVJM1VqcUQrUEFtdGg1Q0xyTHdCMU0xZ2xWUkcrWmp2ZThO?=
 =?utf-8?B?aGxTbCtTOTRQd3lITTFoZ2pwOWRybENOdG94enE3V0RDN1FXQUVEeHh5SS81?=
 =?utf-8?B?a0p0SjlJM05zRVB3UUlDMVJVNjlabkFvYTROUGc3aUd1L3d2WTRzZzVBdDV6?=
 =?utf-8?B?d3JsQkE5UXIycUs5STh5b1VyT3YwSENuZjJTZXpINnNPT2RWVVhROVBnRkhl?=
 =?utf-8?B?UnA0czU4NDhmNjlYd2wvb1dTVDY2bFhTYmlVNmRKY3ZkaXJmMzJndEx6a0p4?=
 =?utf-8?B?YWpaRHA5eVBESmk5Z1VMWWdnZjE3VnRkVC9Vdk9jZFB1RHAzek84ZElzeWxv?=
 =?utf-8?B?RDVKWThFdDhmUUJPaDJnRTRnbnpGcEFuWjkzQkZGTXlWY1U4R21sVVgxU2dI?=
 =?utf-8?B?YzFYaW9hUmZyRWNKSElNSEhpWHJ1UlhTRXBaTitTejZHU3krVDZIb0NFV2lh?=
 =?utf-8?B?MXJlRDFZcFYvSzA1Z3hOM1V5cjdtR3pzbmVid254UmVReFZBNFlVaUJpRTZi?=
 =?utf-8?B?bkd1YmE3SGFRYTQ1UEhBMm1aUWlLSVBaVyt0VWVHb1htakhHSnBzVVpzVis3?=
 =?utf-8?B?QnlPckMyaDlLcUVJWjFSWVU0YlpEd1NZZ1BtRU4vNHN3Q05QSis3VWVFb0Nr?=
 =?utf-8?B?UE9NVmdnY1hieUlBTDMvRlNramhoeDBaVzlyMG5KNEY0T1dDWnh3dGhoV3Fi?=
 =?utf-8?B?OEwxWEJwQkswc2MwWG5vYnJ6NDc2Q2xPZ1QxQzdDellKVXg4ZzIvY1hYcXVO?=
 =?utf-8?B?RU5raWFibTIzTEN0RkxVd2E5cU1kWHdMZ0psQ2ZmdFBrZDlWbDdKWmxBOGpj?=
 =?utf-8?B?anJpT0d4cVdzSCt2RDdLZmJKRDJVS1VhRE4wNVdMVFhZTEZURTVJVVlURWUy?=
 =?utf-8?B?eEVRbkJZY1owREpLanB5S2cySmxwanIzcEt2cnFUZ3NzQWpKcFhGdWtDR2hk?=
 =?utf-8?B?SVM4RlJ5REJLSkdXc3RsOWFGMGt6RFdkbi95N3NSM0Z6K2kyTmdjQkpWUWJW?=
 =?utf-8?B?N1BVUnVRQ0VBcFZRVWtlSWhjVGxQT1VwM3BPdzc0Wkl1a3lSc2RNSjRkUnZw?=
 =?utf-8?B?ckt2Rk1KQ3VYMGMrSU5wZWpvVHZoR1gxUnhySVZDYlRmNFNqVFdFSTAyQUVD?=
 =?utf-8?Q?14B9pi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUFwQVkrY3R2VCtXRDAySE94SDI5L1oyZDBkMlU2YzAxZWhaaVFEdkdZQkRu?=
 =?utf-8?B?SFdUN00wbHpXdGtCeDJQcHYvYk1Qekx0VHpOR2VCdXdKVEt0ZENuREdJSnhm?=
 =?utf-8?B?bUxCZEI4cFlZblc4aWlHUm1NRGdybHgxeWpDRE1wc3lhS1dUOWh5MjJRR1dj?=
 =?utf-8?B?MjRWelY4aUUxYkVyWGEwa2JwUW55andHYTB6dnFhMzZoeVRaL2tRa2Z0K3Rh?=
 =?utf-8?B?bkVnSk5YeFZkMTl5MElhNVg3alVDKzNhT3hNckErODVpVlhkRkhaQW56MmNF?=
 =?utf-8?B?eUJuMDF3eFJ3OVJhdUJwNTI1VnNzWGE4eVF3V1F3MkZpV3VZM2NDOVZtVGhm?=
 =?utf-8?B?OTZtNGhsZFJMYW9aTmVWVkgrTXdDOG5kLys0Y25wUDNYUmhtekNDVzdPNWlR?=
 =?utf-8?B?Uk04SkVidVkvQVk2TWNlY2NVanJMUmErNEI1TzhNMGcwdmZlU3d3R1pkaVM1?=
 =?utf-8?B?U1BLR1llaHRiK0tCS1ZNNWNRYXF4UEZCVytYMjMrMU84bTlvclAwa20vZjA5?=
 =?utf-8?B?dlZ5WFowaDlOYkFjaGJDSjhLc1c3dGhGMDRISzlVa0VRb1ZoQkVFK0NwR2tH?=
 =?utf-8?B?REJXZGhsU0psbXRpQ0xWOXNQc2NOU1pIalhyUkdkempTRkszMTZOTGZaWTVa?=
 =?utf-8?B?Yk02VUhGV0U2enFpVytrTVo0VEJiMVJEQVFuT2l6ZERVTzcrR3FrMWZKSy9U?=
 =?utf-8?B?L2RhRWlaV3pKb05DS0pVTFpFWStSYXFBREF4Z0xwN1FMdHB1Z1BoYit1KzV4?=
 =?utf-8?B?SWlUQVV6NmRvRW96UlZXaUpvYWRuVzZrbGxsYmxscVd2bXJiV1MxSnkxVmY5?=
 =?utf-8?B?YlpEZGwrWkZnSThBL2pWaCtZQlVSZkhDaEZJaHYvL0FNd2JPMys5b056WEc1?=
 =?utf-8?B?OXZReWFCQ2hyb0JhVjVPVmhuZXBpZ09hSVVmYzJzUjBCdmtqM2ZySWhnZ0VF?=
 =?utf-8?B?SDRKYUFhY0xsWWRtYnNYcmozRHhNNFdjQXFqanJSTVcyYmZrU1gzMGpybjhX?=
 =?utf-8?B?THpJRHp4VDhDWjZhc0FYQUJSaCtLTEFGZTBvc29QdDFHamRjNmpGNkY2eEJM?=
 =?utf-8?B?U0dnT1dkdFR4RlkrMW9Fa0o1SFV0ck1XZkdoMzk4RXRKeitreEFSMDI0WndB?=
 =?utf-8?B?Q3RjOUszUy9lTVRrUk9EZDBsNmxxbENXd2pQUG5JcllDODlvYVhZYW5xa0NQ?=
 =?utf-8?B?UW9JVlF6RkJiS01HQndMR1BGOEtXL1YwU2JQZHh1dUxNLy91U1pEV1d5TCtL?=
 =?utf-8?B?TGtKL1phdnVpK2kwRlhXNVhjc2taeFpzTFFtVUNiazZlSlFNNytqenUrWi9p?=
 =?utf-8?B?cjNsZm1Zd1J1dU8ybWlGMWpsOTBneTV1QnB6b0hZdEV0eTRKcHMwYkRnU293?=
 =?utf-8?B?UXVBOWpmcWNCVjZxK3FVQVpQU3orMFZhYzFqT1RlZWxkNUQ4WDI5ZFhTSk9Q?=
 =?utf-8?B?UUNCV0wzWm00amxTZFpEQno5Z0R1ZHNGZ2hzd0l1MVRDN3paVFpYRHZzejBE?=
 =?utf-8?B?WS8rL2VHK1ZMZ1gwdkNibnhpd21WZjFkNU9IZG0rOGtjeDBHTnN2Sy9Fb2tB?=
 =?utf-8?B?U1dTUzE1bjN6VktkSG1NQXlNQVFuL3VRaVlZU2E0VW92RmpHR3hxWUtxNDhB?=
 =?utf-8?B?RlZvc3F0MVIwQm9PeGcvS1NYSnVMa2NiM3lvckx0R2RRUEZ3Q1M0QkFwMjgw?=
 =?utf-8?B?L241aVVoanhXNWhIbVY5MmZubEUrZFcvbXlsWWJhZEhrTTVmeVV3dkFXOUQ0?=
 =?utf-8?B?RnRpWnBZSitaZHZ0czN4bWxwUG9yNHJPTkdUckQ5alJGVElpemp0REtzOWhU?=
 =?utf-8?B?bGFHUjNOWTdHamFJY0hKQnRBQnVCT3VIVUZTREZrZitnRmlncVdDc3hhZGQ4?=
 =?utf-8?B?aVMxODJiUUV3clpxR3E0QXo5bWtyazNlN0t6SDYvcFhURlVwcHpycTAxTDhB?=
 =?utf-8?B?THlXOVZpQkNtUUsrampFa0xJK3JiaU8vclFzcFBpWE8ybDAweERLZ0xaRWpK?=
 =?utf-8?B?Y0hyeE0xaGVSbzVVb0hIRGtuWXFKcnI3L1FWRGJuU0dRa1dpRFRjK05yRy9v?=
 =?utf-8?B?Uk9LMWpVSHd6T0RackFPbUl3VGErOHptWUFvUUNIeVozTUZNbFBydFhkR3p3?=
 =?utf-8?B?TUx1WnpMcmZTOE55dDVtYVBiZitrU0srdmVxL3ZodFRiM2V6Rk10SEpJNVZ3?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f83ba32-228c-407f-5477-08de1535171f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 08:44:49.8516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5HDlQOiUID636Uo7Xprs85awVL2oyrnnZwAGyGMBE0NGzIFBix7lInTm5c8MZJV9z4VMoxmgc0xcJ0w1zTM+TTzZOrEKCCDtoqifM/cd3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13754

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3Jpc2huYSBLdXJhcGF0
aSBQU1NOViA8a3Jpc2huYS5rdXJhcGF0aUBvc3MucXVhbGNvbW0uY29tPg0KPiBTZW50OiAyNyBP
Y3RvYmVyIDIwMjUgMDg6MzINCj4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBSb2IgSGVycmluZw0KPiA8cm9iaEBrZXJu
ZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3Ig
RG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj4gSGVpa2tpIEtyb2dlcnVzIDxoZWlra2ku
a3JvZ2VydXNAbGludXguaW50ZWwuY29tPjsgRG1pdHJ5IEJhcnlzaGtvdg0KPiA8ZG1pdHJ5LmJh
cnlzaGtvdkBvc3MucXVhbGNvbW0uY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzJd
IGR0LWJpbmRpbmdzOiB1c2I6IHRpLGhkM3NzMzIyMDogQWRkIHN1cHBvcnQgZm9yIFZCVVMgYmFz
ZWQgb24gSUQgc3RhdGUNCj4gDQo+IA0KPiANCj4gT24gMTAvMjcvMjAyNSAxOjAyIFBNLCBCaWp1
IERhcyB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IEtyaXNobmEgS3VyYXBhdGkgPGtyaXNobmEua3VyYXBhdGlAb3NzLnF1YWxjb21t
LmNvbT4NCj4gPj4gU2VudDogMjcgT2N0b2JlciAyMDI1IDA3OjI4DQo+ID4gLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEtyaXNobmENCj4gPj4gS3VyYXBhdGkgPGty
aXNobmEua3VyYXBhdGlAb3NzLnF1YWxjb21tLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIHY1
IDEvMl0gZHQtYmluZGluZ3M6IHVzYjogdGksaGQzc3MzMjIwOiBBZGQgc3VwcG9ydA0KPiA+PiBm
b3IgVkJVUyBiYXNlZCBvbiBJRCBzdGF0ZQ0KPiA+Pg0KPiA+PiBVcGRhdGUgdGhlIGJpbmRpbmdz
IHRvIHN1cHBvcnQgcmVhZGluZyBJRCBzdGF0ZSBhbmQgVkJVUywgYXMgcGVyIHRoZQ0KPiA+PiBI
RDNTUzMyMjAgZGF0YSBzaGVldC4gVGhlIElEIHBpbiBpcyBrZXB0IGhpZ2ggaWYgVkJVUyBpcyBu
b3QgYXQNCj4gPj4gVlNhZmUwViBhbmQgYXNzZXJ0ZWQgbG93IG9uY2UgVkJVUyBpcyBhdCBWU2Fm
ZTBWLCBlbmZvcmNpbmcgdGhlIFR5cGUtQyByZXF1aXJlbWVudCB0aGF0IFZCVVMgbXVzdA0KPiBi
ZSBhdCBWU2FmZTBWIGJlZm9yZSByZS1lbmFibGluZyBWQlVTLg0KPiA+Pg0KPiA+PiBBZGQgaWQt
Z3Bpb3MgcHJvcGVydHkgdG8gZGVzY3JpYmUgdGhlIGlucHV0IGdwaW8gZm9yIFVTQiBJRCBwaW4u
DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPGtyaXNobmEua3Vy
YXBhdGlAb3NzLnF1YWxjb21tLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi90aSxoZDNzczMyMjAueWFtbCB8IDggKysrKysrKysNCj4g
Pj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3RpLGhkM3NzMzIyMC55
YW1sDQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi90aSxoZDNz
czMyMjAueWFtbA0KPiA+PiBpbmRleCBiZWMxYzgwNDdiYzAuLjA2MDk5ZTkzYzZjMyAxMDA2NDQN
Cj4gPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi90aSxoZDNz
czMyMjAueWFtbA0KPiA+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL3RpLGhkM3NzMzIyMC55YW1sDQo+ID4+IEBAIC0yNSw2ICsyNSwxNCBAQCBwcm9wZXJ0aWVz
Og0KPiA+PiAgICAgaW50ZXJydXB0czoNCj4gPj4gICAgICAgbWF4SXRlbXM6IDENCj4gPj4NCj4g
Pj4gKyAgaWQtZ3Bpb3M6DQo+ID4+ICsgICAgZGVzY3JpcHRpb246DQo+ID4+ICsgICAgICBBbiBp
bnB1dCBncGlvIGZvciBVU0IgSUQgcGluLiBVcG9uIGRldGVjdGluZyBhIFVGUCBkZXZpY2UsIEhE
M1NTMzIyMA0KPiA+PiArICAgICAgd2lsbCBrZWVwIElEIHBpbiBoaWdoIGlmIFZCVVMgaXMgbm90
IGF0IFZTYWZlMFYuIE9uY2UgVkJVUyBpcyBhdCBWU2FmZTBWLA0KPiA+PiArICAgICAgdGhlIEhE
M1NTMzIyMCB3aWxsIGFzc2VydCBJRCBwaW4gbG93LiBUaGlzIGlzIGRvbmUgdG8gZW5mb3JjZSBU
eXBlLUMNCj4gPj4gKyAgICAgIHJlcXVpcmVtZW50IHRoYXQgVkJVUyBtdXN0IGJlIGF0IFZTYWZl
MFYgYmVmb3JlIHJlLWVuYWJsaW5nIFZCVVMuDQo+ID4+ICsgICAgbWF4SXRlbXM6IDENCj4gPj4g
Kw0KPiA+DQo+ID4gTWF5YmUgdG8gaGVscCBEVCB1c2VycywgYWRkIGFuIGV4YW1wbGUgZm9yIHRo
aXMgdXNlIGNhc2U/Pw0KPiA+DQo+IEhpIEJpanUsDQo+IA0KPiAgIEFkZGluZyBHUElPIHRvIGR0
IGlzIGEgZ2VuZXJpYyB0aGluZy4gQWxzbyB0aGlzIGlzIGFuIG9wdGlvbmFsIHByb3ByZXR5LiBD
YW4gd2Ugc2tpcCBhZGRpbmcgYW4NCj4gZXhhbXBsZS4NCg0KT0sgZm9yIG1lLiBKdXN0IHRob3Vn
aHQgdGhhdCBleGFtcGxlIHdpbGwgY292ZXIgcmVndWxhdG9yIHVzYWdlIGFzIHdlbGwgZm9yIERU
IHVzZXIuDQoNCkNoZWVycywNCkJpanUNCg==

