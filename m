Return-Path: <linux-kernel+bounces-878126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77566C1FD92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F292C3432B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7C334C15;
	Thu, 30 Oct 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jQmda0fL"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806C26AA94;
	Thu, 30 Oct 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824138; cv=fail; b=g/n5siPsvOL4y9fHe5qem/hiNfiZHA445aMgpdiShDKGSiT+eq04c7otgR5cABlLCimKbpi1uf9jjRcV9J5YspncBOOOvA3TKvQsFcPGGMYq5HDeyP2XC0XhLz31TRPxIDxfCMNuaKUCeqqeK7rIk6FDPqBAdx0QHUvukvWcqr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824138; c=relaxed/simple;
	bh=tYXxkDXi+n/8PlipTAe0YOGTzoLbsuEurBGF87myuwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZuoyfZ3zHh7WU/pCZtnmRsbTrTden+OTN0hj/6tgny2UVNvriPKYtvhWWd1uf2EcZzbfCig29FwjlFjxH8Y2QLjg3qrR5TEbss+l7upq/MxCBzTZ9fhJTA2MMCnVJH3oQR9h6nZ20r3MhBzipFAXWL1muQPGktI8DfQUA/qJork=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jQmda0fL; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7XEtNJs2lhcmKbM/hjyhgcZz7g6QvwpbD6Aujk6S2DOD0W/fHCOKoVkBAYp4hF9HUvqN7joCMQiYgeY2uZ/Ec+w3LR+iXPICQYBXVBx4SdB+lxisawd3bMwm/+b5pnzB4tN0j7cMCh8votX4H+GPD4GXLM51TTpuq4i+LLGV1+V+YM7tZZ5W3Z825+zVm0Gy5iFx9K4xNGnMFlyTmSGsQcWG0uIGo8WYEJVDACgYdUu6D0haw4sgODFbvhXE+vv28sIxg9cYa0ojEocENw1o43+thGk4PX6Cvvlo5pka4vfGRZVCKHKMiON9/sqFS9BKr+rPOBUDMiuYkAxyBkyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYXxkDXi+n/8PlipTAe0YOGTzoLbsuEurBGF87myuwA=;
 b=S20m9oDdfa1fjo67cG6tH31sbAEIYysLJuqDcLU2Ba+FXCvBdHNn+ObQlx7gde+MwgK9LwMZ1wAEYDQutA2Pz6rSc5bzHvgDFQsOVdud5mFPkX0HHjBWhZdbtJtJ9M7/QKTFNL1FZ1uDL8LzgtocluvpMhpJxGw43ZcZjm6RhE7PW1pwKqHWFRrBpU858KAU7E3t9U3qGU9XJCMVmuq9PGli6RNEIWUJCKmP6pwAhjr3gFcW2me3Z8NiBG03LSzaEWUr83RTkv9QIDmCoxeUky6zYyUh84kIrwIiTUUfW1F5Leb0rrw3ePIWOsZ3WQRQQZc0srv3sPCl3815gRoyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYXxkDXi+n/8PlipTAe0YOGTzoLbsuEurBGF87myuwA=;
 b=jQmda0fL8NNZ7PSZggBinRdUbdD75yfU4AtEyzWnxytJqJUjCLp3QBpErdCoJy8tqEr5t+CjdukZMy0ch3OlH7KTimXDB6tG4l2MjlBc2AcnWG1BLWWQrqFB3ZkcO7hUfxSuFKVD/uZCuNGrkuBlr1krgD5IZr9+uq22KiySFTfpRAPGYJMMFX/mlsrWTgmazOWLoJjbMajcgPEBDT9k7IvG+QDijZIdBksf1r2I8WFNh5+JFda1rDV3zg6O8st7lDjoJxTt0zDZKJGi1RKHYsxIbWyTmUyYoOTNGkUiPWB/c2PIpC+tkAn6ll9xPmKdCv4ECygTtqexTgRrrZM4tw==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA2PR03MB5914.namprd03.prod.outlook.com (2603:10b6:806:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 11:35:33 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 11:35:33 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value
 for Agilex5
Thread-Topic: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value
 for Agilex5
Thread-Index: AQHcSU2Jtha/h7K0JUijtynbkn4VWLTaU1KAgAA8rAA=
Date: Thu, 30 Oct 2025 11:35:32 +0000
Message-ID: <6b3cb11d-afbd-4242-b215-a3a0230cffb8@altera.com>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
 <08cacb9328c338edb6a6f291c56c6d2c32a9e0cb.1761648711.git.khairul.anuar.romli@altera.com>
 <20251030-wakeful-hospitable-eagle-9dfca1@kuoka>
In-Reply-To: <20251030-wakeful-hospitable-eagle-9dfca1@kuoka>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SA2PR03MB5914:EE_
x-ms-office365-filtering-correlation-id: 87ae7fc1-3187-42c8-a221-08de17a86fbb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFNSWnBuVUwvN1c3elB3RkFyS1ZKTmF2RmJYRURWQUlwV0h4T1VJTmpWMnNm?=
 =?utf-8?B?Z1B6eVRzMkxTTlAvMGFWWlRna2Z5RHFuaWdEbVZtb1pJUnlkYnRtRnM2enRE?=
 =?utf-8?B?VDdQUDg4SGN4bktnaUQ5VDgwNkFIckpaWUJ5blBRVHBwYndvZXAzSTIyemtM?=
 =?utf-8?B?dUVIbmdnRXppU1QzMzE4QTlxUDc2eG5oejkyV3EzU09tUmN1TmtKdnFpaEdV?=
 =?utf-8?B?TVFYTTBkQTYybTNiK0Zxdk9tUVo5elFEU21RMVluMUFNMkdWaVlwY2RXbEdn?=
 =?utf-8?B?U01JSEVjTlV5RWJvWjdBWGx1MVdrNkZZaXBLMWJrdVp6VDJqNEtFY0ZrQmZz?=
 =?utf-8?B?NlFvRENEbTlqUm92OGUxRmF2MlIzQjVNNDVMNFRxTEcvUkcxN0J3ZWxwZkxK?=
 =?utf-8?B?K0ZXOGJNK1JVU21OZ0RKK053K3pOenVTdXVxOWN6d0hxNjNFR0luREtMUzdT?=
 =?utf-8?B?SEJZdnhQbTFIZStpQ0hvMDltL1JUWEQ3VlU0T0dsclNuSUFPb0Z2ak5QRFIw?=
 =?utf-8?B?K0RYcjVGOGdtNFllSGt5K1VCRlFNcHY5WXZxZTYrYVg3L0l4ajAzWHpkaENZ?=
 =?utf-8?B?eG9oZlkzKzk1T0pySmcweXhDa1l0WjF3KzBmNnh4UDRBWUNVVVVGaENIYzgw?=
 =?utf-8?B?Y09hdnBhdFc3YzhmclFsTldsc0tLTGtKdjl3b0h1UHQzeUpnU09tOTJSK1k4?=
 =?utf-8?B?Y0tMYXpMT3JhSi9DZWVPUzNGZ2dVMDJVRGM5d3RUUGZjb1BMcmVacjA1ZmZ6?=
 =?utf-8?B?Ym9RMTl2d1R1ZWFjOGFRM0trWjlhNC9JUDZ2eTVsZzByUk1IRGY0TWRDdU5P?=
 =?utf-8?B?OUpQeGVITjRkWlVDcjllenJ3L1orUmZQZXh0OFpNaEwrT1QwQzdNSWt1amdt?=
 =?utf-8?B?aXY5WG9JMFpzOUdVV1hoNk9jR1NWK0lZVVMyT01odjFtb0NBZDJpRUhkZDZI?=
 =?utf-8?B?RjNEZm5RMld2b3RDbzI4UDFqNlN3cE1OMzk4RDdmM2Z5RWtOUTdiby9FdE1F?=
 =?utf-8?B?ZkJWb0dUTTBIZEljb1dkYVhxUnRIaFRwVFZna1ZDcVZyQWdCV0xpYThXNlFW?=
 =?utf-8?B?TE93c2dKcEtIY2F2MXpKTkwyUCtFNCtFbVE1NWkvb24rYmZZNzZtMHJUUTU0?=
 =?utf-8?B?ZTdFUDJSc3ZQVVNBR2ZsWEtHQXVLeitjRHJWUlpaSEhxTHdmajdjOC9ydS9W?=
 =?utf-8?B?bFMxUzNxNVJZYXFRdWpxb1FlcDArMnBLZGhVNU5wTzdBQTRhd2FXSmtnZm1s?=
 =?utf-8?B?cFBBSzJmTlVwWDJVc21PUXFURGNDQ3cwYnhWKzRoQ1kyRW1OZWNhQmFMdjNs?=
 =?utf-8?B?NlVPWHZkaGZ4dDlVSkhITXpsN0M0aUduUHYyNmR6OWRJUjlqQXBDYW9DMFht?=
 =?utf-8?B?WkU2STFtOHlZc0MxM01JK0UzS3AzTGhRUjFHN2RSSUsyamtJbUg3WC9paDlS?=
 =?utf-8?B?MW8xcHJ6UkY0Y0hJbGFRSWl4VFlkejFDb1g0ZmlVbXZRejlzVWxvMUFISytU?=
 =?utf-8?B?R0JHUnR0bk5TZ1NuTFYyM1hJL1BHNEdkNkZVS3dhZFZMY2JzVDJZS2RVQUJ4?=
 =?utf-8?B?a3RKV1o0Q0F5K0JnZTBJYmJST29LbnVVQWV1WFM0dGRIUzJiZGM4dm12N09U?=
 =?utf-8?B?dTV2MmRXaDBoNVFURUYzelVtRnNTcldFeEh1K0VtTFZubFVUMUx6MXVPMkJ0?=
 =?utf-8?B?Sko3UkRGNU1RZjhPWms4UWtneVpIS011UHB2aVJONDRSazFOSHg1QzdEYzlN?=
 =?utf-8?B?UEdCNXVrVFpWUGRYR2FzcDUrT0IzZEpHZEM2cittbjI1amcxcmhwQzlLTnNk?=
 =?utf-8?B?USs4VzVrdnd1WDVMSWVpTWlaejl1L1VVQnpxMG93eE1YaW5ZREt1MU9WSG9p?=
 =?utf-8?B?bFlnNm1kR3pzblBtN3gwWHo3Yk9acEVtb2QwU3JzVXZWczNrbVpTbnlXWWJT?=
 =?utf-8?B?TUZSOVZjOEVkUnl3VGhxWlVYcEM0MUV5Y3pQU2tHTGpnSmEyanBYYlQyN2Vi?=
 =?utf-8?B?UEE3MGI1OWIwaHBVUU9lOGxOZy9STjJIVUpIRmorT29IOWZSNE5ZVDNsM3lW?=
 =?utf-8?Q?bCtgQ7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlpNejRpVDd0NTVDelREeDQvbGd3ZjhVcURWUURXOWlEOS81K0E4MGxTNk1x?=
 =?utf-8?B?cS9PWjcwYmV4M3l5NW8wNllOQm93dy9wZEx1ekQwZXlBc2pqVDhleC9ZejZt?=
 =?utf-8?B?a3lZL2tvQXU1Nm92bUhsR1lSTVlPcmx1bW8rci9JMkkwZWxjalZSVmNZcVg4?=
 =?utf-8?B?Tys3NjZTYlIrNDBTWXFWVzNjbGprTDBpRHdGdmQwMXp0MDRFS2I3Qkk1QnFl?=
 =?utf-8?B?TzU4WlBmcmtac3U2dWFKOUc4bTdpZnVyK0JaZVN5RlNUYmRmSWFaSHd1YjM5?=
 =?utf-8?B?L1NUa041KzBJU2VjVnRySElDYSt3dGtNUlhjMGF2UTEyNXZYczI0bVc4bmM1?=
 =?utf-8?B?eC84aDVPNUhBMndxSUtXUFpWZ3d3ODMySGU1N2FkYU1mZTJSYUp0MnVuV1dS?=
 =?utf-8?B?WmJlRSsxeHh6VldUV1h1VHdibnpvWHFZL0lrL09UZkU5QytUU1FKU21ETys4?=
 =?utf-8?B?azlyV3JtdnU0UkpsSGZUaVpLczZ3VVBwallrWDExRUtmQVh1ZXJFR2J2eXB5?=
 =?utf-8?B?UE42ZzBlTG85K29rWnJrdS90UXNNM3FFejRGcUpIdTdoWlhlMEJQQWxjcE11?=
 =?utf-8?B?LzhwZ0hXT3AvS0dPcmQxTmE0aCtydGFPV0FLZlhPdFlWTVhra1pmSXRmSTd0?=
 =?utf-8?B?b1d1WG83cXI0UDFBZGhjTC84MzJnS1FuOHlpbEJabmVpaTY1UXZOVjJDejAv?=
 =?utf-8?B?ai83aHNHdURwbkVWTDkzU010NkJHbE5PVEtEaXh2NTBIQTJIbThOZ2lmVVN2?=
 =?utf-8?B?OEtJZDlRUjZsWFc4M1hoNWZDNlBoMC80WWVzWnNaWXQzd0t6RmxXNzA0U0lS?=
 =?utf-8?B?TDQxSW9JYUR4UmEvekx3bWVudkg3dkpoaFMrOHp1cUUyYStONm1YeklseTNw?=
 =?utf-8?B?WjJvTFY2RzBXdjZkMUNjdHMwS0hEeWRJVll2N2RUdzkwMmRqdjRVc3c0cTcz?=
 =?utf-8?B?QzdwZEJPcHd4WUNIQmp2MSsvUDg2VUE1ak9zTStZNDdXY0JvK2hoZFplamRj?=
 =?utf-8?B?MmlDZHlEanF3ZEhYQjk0eUNCTWZ3RnJjS0d6WHVJaXFFSSswM045QVJjbXph?=
 =?utf-8?B?TE1aWjJyb3N2alFwQVdVU3N5MEdJVjhQRjZKZ0VpTEY2YW51MHRiRk5uc1lr?=
 =?utf-8?B?RG4ybGFqOXlmRkU1Um84aEZPUElnK0hIR0tqMWtFeHp1cmpDSDRsWThGblN1?=
 =?utf-8?B?aTUyY1B4RW9WNkoxSGdjbFlITU5Cb0FwYTlTQ2dXSmF0dUgxbEdwYXRvcHcz?=
 =?utf-8?B?aFZINW1pa0ZjWEFoTENLMHdJeVhraVJxemc4ejFWSUFLSysvUDA4ZlZjRjg5?=
 =?utf-8?B?WGkrRWw4RDZFYWliNmtqMDFCQzEvV0htZHE0RTVlellQZ1NEeklTdldKNGkr?=
 =?utf-8?B?bFh3V2NGNHFLa2lxdG5hVTFMV2tXUjVFbk5GaEVkTk5ZemJJbUQvZkowTXhJ?=
 =?utf-8?B?dWZYNTArYzN2am5WdFM3dWtGcTkyRzVVMVlHNFZUVVBpTWo0Y3YxSXBPL3RY?=
 =?utf-8?B?U0lZYnNseDhHUE9mejFiUCt0MXdPdFBGQ1gxc2o1VHg3cVlFU0Zrd01tWTMr?=
 =?utf-8?B?QXVoRC94RDlwZEdzQlNvMkw0cjlPZXFiMVhubzlYRjB1Sm9zNm0rVTZOK2ZQ?=
 =?utf-8?B?QXdyMHdobnRITUZZMThtU0ZXaWhkMENoUHJZd0JyUk4xNWdISUh0empzY2pr?=
 =?utf-8?B?cVlIVHFyeklNVlV5aEpueDRPbjUrV1VWb2tRZWhKSmhMUC9ycTgwd01TQlFu?=
 =?utf-8?B?c0VFb0w5bHZhRElRMW5ZSEtHRDdOODlHYXZ2Z2tOQ251Y2pUY1dwdi8yNEVL?=
 =?utf-8?B?ZTc0UVBFaWhhNldqU1RPSnRBUzh5NGRFdWlvT0tVM3dVTXNCU3QyU2FsQlJR?=
 =?utf-8?B?VE1nc0Z5VTJ1NW02QUZnLy9qSmQwaUZnM3RqZE8wUW5DN1c2MWkvNmRVNWpX?=
 =?utf-8?B?RHV4aXlqOVpKL3hkdm1NbGUzb1l4YVRUYmVheFlwTlh0ekZPZ09PZnM4OU1G?=
 =?utf-8?B?QmFQNDl6UTBmY1AzVkp0dGJCZU55Rm1YMHc4WVNaZ3NJdnM5RVRmMWdWOHo3?=
 =?utf-8?B?dFFIcXJmRWN5Y0tDVkdkUks3WmJLMTdvTDdwRVdlMktSZFU4eGRXUWZXWFVp?=
 =?utf-8?B?VldPN0U3K0lTUlcveDdmazRKVUJha0xHZXFNd25xK3pxSjVIaXJwdTNKa2Za?=
 =?utf-8?Q?2F7eqWsgbqt5PfvnoJkO29k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D69679B8C927A49BCC2CEE753D6AAA4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ae7fc1-3187-42c8-a221-08de17a86fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 11:35:32.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQ8ayM6oMrO/yIl5BGaA6x2ay8eLiUy5N+KUxuT4ysEydomNzSKEHWcTkA7YiTDHD0bF9f8mxOwFcuoyDM0wRgymJ0W+j9+pHjB8LhRUX8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5914

T24gMzAvMTAvMjAyNSAzOjU4IHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiBU
aHUsIE9jdCAzMCwgMjAyNSBhdCAxMTozMDowOUFNICswODAwLCBLaGFpcnVsIEFudWFyIFJvbWxp
IHdyb3RlOg0KPj4gQWRkIHRoZSBjb21wYXRpYmxlIHByb3BlcnR5IHZhbHVlIHNvIHdlIGNhbiBy
ZXVzZSBJbnRlbCBTdHJhdGl4MTANCj4+IFNlcnZpY2UgTGF5ZXIgZHJpdmVyIG9uIEludGVsIEFn
aWxleDUgU29DIHBsYXRmb3JtLg0KPj4NCj4+IFRoaXMgYWRkaXRpb24gaXMgYW4gaW5pdGlhbCBB
Z2lsZXg1IHNlcnZpY2UgbGF5ZXIgZHJpdmVyIGVuYWJsZW1lbnQgdGhhdA0KPj4gd2lsbCBpbnZv
bHZlIGFkZGluZyBJT01NVSBjaGFuZ2VzIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBIZWgsIHlvdXIg
YmluZGluZ3Mgc2FpZCBub3cgdGhlcmUgaXMgbm8gaW9tbXUuIENhbiB5b3UgcGxlYXNlIHJlYWQN
Cj4gd3JpdGluZyBiaW5kaW5ncyBiZWZvcmUgeW91IHBvc3QgbmV4dCB2ZXJzaW9uPw0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpJIHdhcyBleGNsdWRpbmcgdGhlIGlvbW11
IGluIHRoZSBjdXJyZW50IHBhdGNoIHNlcmllcywgbm90IHRoYXQgSSBtZWFudCANCnRoZXJlIGlz
IG5vIGlvbW11LiBJdCB3YXMgbWVhbnQgZm9yIHRoZSBmdXR1cmUgcGF0Y2hlcyB0aGF0IHdpbGwg
aW5jbHVkZSANCmlvbW11IHByb3BlcnR5IGFuZCBob3cgaXQgaXMgYmVpbmcgaW1wbGVtZW50ZWQg
aW4gdGhlIGRyaXZlci4NCg0KSSB3aWxsIGdvIGFyb3VuZCB0byBoYXZlIHBlZXIgcmV2aWV3IGJl
Zm9yZSBzZW5kaW5nIHRoZSBuZXh0IHJldmlzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpLaGFpcnVs
DQoNCg0K

