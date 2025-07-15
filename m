Return-Path: <linux-kernel+bounces-732602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDEEB06964
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045744A7F99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EEA2D0275;
	Tue, 15 Jul 2025 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.mcgill.ca header.i=@mail.mcgill.ca header.b="aKtJXNSY"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2114.outbound.protection.outlook.com [40.107.116.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB01341AA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619455; cv=fail; b=Hd54f8VZ3Z+BvbGHA6PNIGcOGhCqsGFqL/WiE/br474Swq36n2VHIZ403YI4ZoWfG5lLpa5wqhKVxPJz4NYppU8nFRaYwsj8o4klemOFkYhKFiY56lK8duNzL+qwYn+dXdWrge5sAYp7X2EUAQ53GJn3fXJHYbsS31HM47RG44k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619455; c=relaxed/simple;
	bh=Zx1ESciEqubUpDEsxtEedLf8dekQh9/RT5MehVYhWzc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NUp67qduuyQoWzwujzrBTKSCFMQdRv/YwlEmQgz2mWbLM7imzX+pPepE228OsJeSMNdXGDMj03fQZBPRbP2THJ7s264ZHjnYGUP2TxvQyFBRQdb+T1yoFl+K5k6qwC/uiXU4n0K7y9Q/iRvEOqTd4JNVGnzSUDylst7PMQoClTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.mcgill.ca; spf=pass smtp.mailfrom=mail.mcgill.ca; dkim=pass (1024-bit key) header.d=mail.mcgill.ca header.i=@mail.mcgill.ca header.b=aKtJXNSY; arc=fail smtp.client-ip=40.107.116.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.mcgill.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.mcgill.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcMvqOoalOVHcQ+o2OAJPOZxghYNH/PFXRdPvXU5Sssw0GEvBTcgh9UchOk/ApiprSBZ9W42nqco5pRlnfoiy1t0vnEwTnFR+VinEKT4FknmxTSp/DWXCd2Te8zHqBmzV21N3RRNRg+vZiXDr5PBILT8SR4JLZFq5QOpTNHZ3Np3HFw74rQSdjvHMLNcK33DddO8OQEIVap1wwTIYc7SCLvx8bxFcxUBwFaZjJpPGe3cQ+P0VF68F/0Z+IzZQckNJrPV0+PSnatpFuuGtjNQusNmCZUmRgqVOAFyPDmnFQR8wnigJ/5mB1rxyX9iil0ee0uRWfQq6LaqRxZTx5hczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx1ESciEqubUpDEsxtEedLf8dekQh9/RT5MehVYhWzc=;
 b=HKVTVuGiNITw04K4HaH1OzOjqnmQic246PBXKmFpqYTMmegUioz4XzH36ZyQiD2jwF8iukiAJEOXdYdAb9svya/yG41wDJhDdt/zUFdLOBbsw4vJHvz7jBSWdmoXv0FWdrKMW5QW8eu+L6MHNrdA3a0ggjCbbrguWF0RUcdFvLOpD8VMtOFVGWQoSkM18eBSOA6jieq9zE4ok2Vl51FHqP6BWr9pBS3Yar4dpIbMp7wYAJgmnP7NY/pQimj4Wh42s9uKgT+zsj5C8S5hD03KjO33av3WdmsnHU2gy78kQzi5a59M4FySOGyAapSz9jM43CpNIZCXpzGL0GKSGqdGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.mcgill.ca; dmarc=pass action=none
 header.from=mail.mcgill.ca; dkim=pass header.d=mail.mcgill.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.mcgill.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx1ESciEqubUpDEsxtEedLf8dekQh9/RT5MehVYhWzc=;
 b=aKtJXNSYWuXUefl/N7dYe064PMhh93HRt81XGMFnsw1MCU1yr5MvHbVhVu/hr1UtJojFK5fGiqSk39YDj9u9/mb/PUF/AKz+P8WIbcWuzp+eirfqAlWpIE94vNdOh5UvUtuQ0Myjf0C0SCKwP4TxQXXg70SYmOmxsUlfjTvSVd8=
Received: from YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:25::17)
 by YT3PR01MB10560.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 22:44:09 +0000
Received: from YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ca3:6de0:6ebc:bed6]) by YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ca3:6de0:6ebc:bed6%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 22:44:09 +0000
From: Carl-Elliott Bilodeau-Savaria
	<carl-elliott.bilodeau-savaria@mail.mcgill.ca>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>
Subject: sched: cgroup cpu.weight unfairness for intermittent tasks on wake-up
Thread-Topic: sched: cgroup cpu.weight unfairness for intermittent tasks on
 wake-up
Thread-Index: AQHb9dhZsypup3GXDU2xH3TeTysyuQ==
Date: Tue, 15 Jul 2025 22:44:09 +0000
Message-ID:
 <YQXPR01MB511370FEF51299CEFBF7A511C257A@YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.mcgill.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQXPR01MB5113:EE_|YT3PR01MB10560:EE_
x-ms-office365-filtering-correlation-id: 15465b20-9d21-4db6-3235-08ddc3f11cee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0hkQTd0WjZQRWQ3ZDlpaWxsOHFlWDd4M0pBZWxwaVp6YlV1UDZlOHdKdzZ3?=
 =?utf-8?B?cWxDYUNhTCtMQ3JFZUY4cEdCSGRsVUxBa3MwNk82enpPUVhMOW1xVWl1eFN4?=
 =?utf-8?B?THdCWUhxbk95SitmUWg1eG9DK1Y1NXpUZ091Rmoyc2NOQlA4ZjNUOE1GcE9t?=
 =?utf-8?B?WUphaUZCVFZsanFVRCtmYUhUcG1RaTAxRGxzcXF6K1pNblBHNHI2MGJLeHZs?=
 =?utf-8?B?eTZlbEk5OE9SbWhYdjFDcmp5VkxRMnIyZkpCVTZYMmpaSEpZMUNxK2RHL0Nn?=
 =?utf-8?B?TjY0c1BBZ0JSWUJ6OG1qN0hOMTFOT0pTblN1aG9zYUdaTkdjbWtRNVhaTGN1?=
 =?utf-8?B?cE9JSHJFWWttazhyc2krT1VtOGV6aTAyLzNRMHpDRnZ1MktRSzlKazhpeHlV?=
 =?utf-8?B?dXJtVWlqNENRdko3V1N2NlV4RENRYmQ2UXpIeW81VWI1MWJRVDJJd3N2Rjdi?=
 =?utf-8?B?eS9oZk43eHErOCtzU0JMNjcxM1pRSU9mZ09Qc1FXcjlJbTBxNUdKU2prUFN5?=
 =?utf-8?B?bUdBRklEcmtMSGQ1WWp0cFg2ZmVXakNHWW1SZjlFYXVCYVhqYXprZy96b0Fl?=
 =?utf-8?B?YUFpOTZGMzV2eTBFR1pKS0RiWDRWWXpxdTZZeUYxWTlJQ0lVOVJqZVR4Y0hw?=
 =?utf-8?B?eHhCaUJTclFLd2lHd2VqdE5lcWw3NHJnUHdHaDM5UWcvaDBLN0JkRWJHR2I0?=
 =?utf-8?B?N2tib0ZxZVIrTi8rQXc0NE1ONUlqczhNMHYzb2w0TUJoYnFsK3EvY2FaSE5y?=
 =?utf-8?B?TFlmUGt1MkR3ZERrQks0VWdnKzd2TE5kb1VqS0RVN09xRHUvT1JUZHJtL0xj?=
 =?utf-8?B?S3g3MTJPRmxjN2hGWDNHVW1ZL0U2S2JJUi9QK3FIWWRBamxKbExmWHJxY05J?=
 =?utf-8?B?OXVNODhCSDhwcUpBSVFuTWZXeFlMcVNMSTMxSk5mS3pyRDdXVTBha2c0MG9W?=
 =?utf-8?B?cWU5dVkrdUpqZWpTWkxMUGRiRjZzMzdqaEpXeWRUTU9ibTFpK0k5TC8vTWtG?=
 =?utf-8?B?Mzg0a2RNQ1YyakZpUGx2ekVGL3dHWHF2d1EyQ3YwVVBQc1luQlcxaUt5Mm5U?=
 =?utf-8?B?eTR3a0ZZSEkySUVETlV5Tkk0OElWeGVYYnpwd0ZqeFhVbjlqN3NLYVdGWFFx?=
 =?utf-8?B?KzBPcnY3QWZhQS9IYUdVV3hTUnlIWHJWRnRVc0psblBSdU82dGEwaHMrTFdu?=
 =?utf-8?B?bnhJdHQ5T0pEenJoU0d1SG9IVXc3T1kxSEt4L3o0b3hTcUpVWUpUenY4QWtN?=
 =?utf-8?B?SlpHbExNaGtVbUVILytqNmZBUnNlQ1RpSml4TzVFaVhEbkI0UEdGN3FabkpL?=
 =?utf-8?B?MTZWOUJaTTRQblJiMGNSaWc0UFdpcmpVNnBYaUltSDdBdXZUVkZxQmpnVFlm?=
 =?utf-8?B?UW5FVDQ4RW9oeXMzL0FWTWx3UmZXakdUSmpOZGdjL29SalpGUG1DZmRuYUJl?=
 =?utf-8?B?RCtlUTBTM3RwNlhHZU5iNlkzUFRCTTVnQjJTMUg3VEIvUGpsWTN4dEEwVCtB?=
 =?utf-8?B?cHBMcjE0VFhNb1BGdkhUQjlLQi9TUHlRYVh3b0E0UStTVTZYWGVIT2lPMitT?=
 =?utf-8?B?SVAzVWp0N2gwSmttL0taZ2hSNkl5Nm14cFhWcXVibWxiV2MzMXJKVW1IMHc4?=
 =?utf-8?B?em9EUm4xWnBiUzFUVmtvd2NQNWNCb3lVMTFNcGFtckpKNVVhRjlDZFRhbjZn?=
 =?utf-8?B?N29YNUZLckE1R2xSditRKzdIOThOdlhpc1FNUFpqTUhpdEh3VjV2dHZ5ZytV?=
 =?utf-8?B?VXRMWVJDeSt6NXA5RjlPWXhBRDIwTXlMZzQxb0tBcFUvOUhpSFNLQmdvZk10?=
 =?utf-8?B?RXJzRWRrS1JkbjJpVVA4bUQ5M1BOQXNldUlBM1ZEWmFqT0FKUW1kMlRFbUpO?=
 =?utf-8?B?aUJ0S09jaVRNUFFiakVVNEY1WGhqdmZOL3lFSmtjT0hwek96M01HcGhYLzVH?=
 =?utf-8?B?amZ0NUJ3ZERkejl3Y1BnUDVLVWd2TFFFWGJ3aE5KRFhDc2tpNnpvUU5nWVlz?=
 =?utf-8?B?SDZ3bGE0TXFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym8xVFRoWk1RTFg4UHZZZHB6Zm1LaGNYM2xZaWlqYlNPRFc1TDlDbTIzcGlS?=
 =?utf-8?B?QlIxb1FrajlwcG1sRUdSMktjYmpQTGl4NTlTRkRvY0c1OUVqUFdhTjVsQVZx?=
 =?utf-8?B?NElHd3hsWG1qSDVWVm4zK2dFdG81M3dQNXpOaXBZVWllRjMybk9QTExXV0J5?=
 =?utf-8?B?bUJ4Z3BvRDV2dlhmUStTWnZMbzYxeURIOU04KzNaR25ncU8yOHRWOXo5cUNr?=
 =?utf-8?B?SDkvN2xOK2JNQ0RQYlJqYWt2UHlkR0pZck1iWE9EeUFZOFJZSkE0a3hzdGty?=
 =?utf-8?B?andjcXlVMjltaWxqVjFUbzQxYXB1bk9iWnBIUVFxUVlHN0QzY3FYQ25kR29C?=
 =?utf-8?B?ajBrSlJhTFRPRm1IRWYxNGQ1dnBiTTJqalJsZFI3YXVXWGhzVmJHNS8wYUth?=
 =?utf-8?B?VmRzRFczWmRCSlJBZmVWV1VHNGZ2TkFOWFE5cENwdkUwTFBrUUZDYWRSVmRC?=
 =?utf-8?B?VHZLRkRjS2pUNTBCNW93amJ1ZDRRNzZYTG1pNjVWUE1HSXp0RGI4eVdrdmo4?=
 =?utf-8?B?NE9vYjFWaXU3M0JjRWk4WVh4dUprb2VFTHliZ1kzd3F6ZmhrZFE4UW1aaVN5?=
 =?utf-8?B?Z0l4U2NqS2dETFU3MXN5a05oZlNaSlJlcURhQzlJNzRuUkZUNkdVZ1p1dE5l?=
 =?utf-8?B?Q2ZHUytWRC9tUTdacHJCNk9wQUpsMU1rM0RocFR0VnRkbXd4Uyt6YWYxdGRa?=
 =?utf-8?B?RkliVUk2aUJJbXNXQW5ENEpBZitOR0U4eWdRZkNWVENueFJTS3Naak1peFpx?=
 =?utf-8?B?WHdGZkdJOGlMY1RuTlhQK1hsYVlZTUVLem5RVFpoTEF3NkRNeGdaWEtwbEE5?=
 =?utf-8?B?YitHK0NnbEhsb2lqQzZtMnpwRWdvUjlOUHBYdGlnQVJBa3BoZW1xWnVHbmpW?=
 =?utf-8?B?Wnc1OXNBbGkwVFZkT1RFaVd4TFlrQy82TVZ5dVJtT0NOQUY0QTUzOVRmaEg0?=
 =?utf-8?B?c1J6WTh1RWsyYWVyNHVKN2R1bER1aWdNR3B6SDEyaVpFNDIzZU82cXFsMy85?=
 =?utf-8?B?czBDaGRUenQ1a2QyNHJubk1oeUdhS09jUGxBODJWZmhhWGVnbDg3eHJGZFNV?=
 =?utf-8?B?K3pvUGVuSDQzZTR0Y251ZmN2eXYxa01CSlNqeEdVR1hsWUF6ZWlmUmhtUVFu?=
 =?utf-8?B?RG52S2JQTTkzWVdoL2JtZGJOeEVLbjducW94Qk43b3FNam5zbUFHRzlEODFM?=
 =?utf-8?B?ZldPMWUzREJTTjhIVUlid3N6Nzc4VVk4NGdWV29kVmZNLzluRHpyOTBKWXpj?=
 =?utf-8?B?b0Nncjl1MDBVQkNmaE0rYzBPNVpSU0UrUUQ0TVBHZ0RmNkZ5Qm80SmMxcFJw?=
 =?utf-8?B?OVR1V2RmdE1reUhwUXpPSXUxSUV3a3NCTy9xd1Q0Z0srellKYk41SHZabml4?=
 =?utf-8?B?L0dDeDVCL3lSNjNpbXVxUCttb3lKNjVGRDVwNzNmSTF6RTdCRlIvQ2JMVE1G?=
 =?utf-8?B?Z2hCOHlYTXNxNG44aW00NmYzNnEvQnhySEc5ZURRNERjb0E4TytyaGVHeGQy?=
 =?utf-8?B?U0hBcGZ4TVhRb2I3UEk1TGhrYVBweU5GbEJCK0JuN3dVRzd0L1Q5YmQxaERI?=
 =?utf-8?B?V0lsdWRjT3ZqZ3MzbDRpaFcyZjBjRkk0M09jZzh5Sk52dEI0UFRjdTlwNisz?=
 =?utf-8?B?YVJ0dWVzaUJlbnVEY0thYmFzamVBcnVQWTc4WkR3b29SeG9SNGtWUVBtTnZi?=
 =?utf-8?B?dUJqSEdXSmFIZnBiZVVMOVFxOWlJTkRDTHRRV0VwcDErRHNHZXdYNGF1NDZ6?=
 =?utf-8?B?T3lPalJnWHJJU2d0eGlmVjVCKzFiOXpwMkh3T3FXYkJVb0Q3dDZXQUd3T0lq?=
 =?utf-8?B?cDFWS0JxZFZuTGsxOUUzT2RwTUFLdXo0d0pUai9tTThsRWRmQ1VJSjgxc0Vk?=
 =?utf-8?B?VkpzTHo3bFE3dVRsWTVqVU1Sa1NKUHRPdnkyVGY0bWh3UkpSMVRFZXp5SXdZ?=
 =?utf-8?B?K1dNbkI5aFd2cU1aS1JGc045RGEvcHZjZ2dueGlVQm1nelhLa1dCU084Sm1o?=
 =?utf-8?B?TWdpOUxveGtKN0RtOEZiMDdXY1dHbWxTUWs0TGVOQ05vWnBwWmk1cmVNbGdS?=
 =?utf-8?B?d1RWVS82NDFRVC84TUpXaGE2VGJWL2NmR3p5TzVGTURscHBveG5QWG02akY4?=
 =?utf-8?B?UG1NaTROQ0h6aUFYdjAzVEhTQk9LU3lVNFRjYVZGS0JCNEJieldYWGU2OUVu?=
 =?utf-8?Q?+uMfa9kftw3LqEIKQfEyBW/OmZD0qKc5vrI2m0iaNC5e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mail.mcgill.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 15465b20-9d21-4db6-3235-08ddc3f11cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 22:44:09.6149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cd319671-52e7-4a68-afa9-fcf8f89f09ea
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCZi1/SxE8cGVP1LUPrQY+k6uaQxBed+rZr5B450TTQtKwn/gWmDrLYUNMtuGdCsMEpwsBjtF0oADa1ySA6XdHlChQLfn//kZ7hI7FdmsP/SbzQ5W0+gZ/rbDdPjWgukPaNlS7gv5uHducy8HhRPvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10560

SGkgc2NoZWQgbWFpbnRhaW5lcnMsCgpJJ20gb2JzZXJ2aW5nIGEgQ1BVIGZhaXJuZXNzIGlzc3Vl
IGluIGtlcm5lbCA2LjE0IHJlbGF0ZWQgdG8gaW50ZXJtaXR0ZW50ICgiYnVyc3R5Iikgd29ya2xv
YWRzIHVuZGVyIGNncm91cCB2MiB3aXRoIGNwdS53ZWlnaHQsIHdoZXJlIHRhc2tzIGRvIG5vdCBy
ZWNlaXZlIENQVSB0aW1lIHByb3BvcnRpb25hbCB0byB0aGVpciBjb25maWd1cmVkIHdlaWdodHMu
CgoKU1lTVEVNICYgVEVTVCBTRVRVUAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpTeXN0ZW0g
RGV0YWlsczoKICAgIC0gQ1BVOiBJbnRlbCBDb3JlIGk5LTk5ODBISyAoOCBjb3JlcywgMTYgdGhy
ZWFkcywgc2luZ2xlIEwzIGNhY2hlKS4KICAgIC0gQ09ORklHX1BSRUVNUFQ9eQogICAgLSBDUFUg
Z292ZXJub3I6IHBlcmZvcm1hbmNlCiAgICAtIFNNVDogRW5hYmxlZAoKV29ya2xvYWRzOgogICAg
LSBjb250aW51b3VzLWJ1cm46IEEgc2ltcGxlLCBub24tc3RvcCB3aGlsZSgxKSBsb29wLgogICAg
LSBpbnRlcm1pdHRlbnQtYnVybjogQSBsb29wIHRoYXQgYnVybnMgQ1BVIGZvciAzIHNlY29uZHMs
IHRoZW4gc2xlZXBzIGZvciAzIHNlY29uZHMuCgpDZ3JvdXAgQ29uZmlndXJhdGlvbjoKCiAgIHBh
cmVudC8gKGNwdXNldC5jcHVzPSIwLTEiKQogICAgICAg4pSc4pSA4pSAIGx3LyAoY3B1LndlaWdo
dD0xKQogICAgICAg4pSC4oCC4oCC4oCC4oCC4pSU4pSA4pSAIDF4IGNvbnRpbnVvdXMtYnVybiBw
cm9jZXNzCiAgICAgICDilJTilIDilIAgaHcvIChjcHUud2VpZ2h0PTEwMDAwKQrigILigILigIIg
ICAgIOKAguKAgiAg4pSU4pSA4pSAIDJ4IGludGVybWl0dGVudC1idXJuIHByb2Nlc3NlcwoKVGhl
IGdvYWwgaXMgdG8gaGF2ZSB0aGUgdHdvIGludGVybWl0dGVudCBwcm9jZXNzZXMgaW4gdGhlIGh3
IGdyb3VwIHN0cm9uZ2x5IHByaW9yaXRpemVkIG92ZXIgdGhlIHNpbmdsZSBjb250aW51b3VzIHBy
b2Nlc3MgaW4gdGhlIGx3IGdyb3VwIG9uIENQVXMgMCBhbmQgMS4KCgpQUk9CTEVNIFNDRU5BUklP
ICYgQU5BTFlTSVMKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKVGhlIGlz
c3VlIHN0ZW1zIGZyb20gdGhlIHNjaGVkdWxlcidzIHdha2UtdXAgcGF0aCBsb2dpYy4gSGVyZSBp
cyBhIHR5cGljYWwgc2VxdWVuY2Ugb2YgZXZlbnRzIHRoYXQgbGVhZHMgdG8gdGhlIHVuZmFpcm5l
c3MuIAoKMS4gVGhlIGludGVybWl0dGVudC0wIHByb2Nlc3MsIHByZXZpb3VzbHkgcnVubmluZyBv
biBDUFUgMCwgZmluaXNoZXMgaXRzIGJ1cnN0IGFuZCBnb2VzIHRvIHNsZWVwLiAKICAgICAgICBD
UFUgMCBycTogWyAoaWRsZSkgXQogICAgICAgIENQVSAxIHJxOiBbIGNvbnRpbnVvdXMtMSAocnVu
bmluZykgXQogICAgICAgIChTbGVlcGluZyB0YXNrczogaW50ZXJtaXR0ZW50LTAsIGludGVybWl0
dGVudC0xKQoKMi4gaW50ZXJtaXR0ZW50LTEgd2FrZXMgdXAuIEl0cyBwcmV2aW91cyBDUFUgKENQ
VSAxKSBpcyBidXN5LCBzbyBpdCBpcyBwbGFjZWQgb24gQ1BVIDAgKGlkbGUpIGJ5IGBzZWxlY3Rf
aWRsZV9zaWJsaW5nKClgOgogICAgICAgIENQVSAwIHJxOiBbIGludGVybWl0dGVudC0xIChydW5u
aW5nKSBdCiAgICAgICAgQ1BVIDEgcnE6IFsgY29udGludW91cy0xIChydW5uaW5nKSBdCiAgICAg
ICAgKFNsZWVwaW5nIHRhc2tzOiBpbnRlcm1pdHRlbnQtMCkKCjMuIEZpbmFsbHksIGludGVybWl0
dGVudC0wIHdha2VzIHVwLiBObyBDUFVzIGFyZSBpZGxlLCBzbyBpdCdzIHBsYWNlZCBiYWNrIG9u
IGl0cyBwcmV2aW91cyBDUFUncyBydW5xdWV1ZSAoQ1BVIDApLCB3aGVyZSBpdCBoYXMgdG8gd2Fp
dCBmb3IgaW50ZXJtaXR0ZW50LTEuCiAgICAgICAgQ1BVIDAgcnE6IFsgaW50ZXJtaXR0ZW50LTEg
KHJ1bm5pbmcpLCBpbnRlcm1pdHRlbnQtMCAod2FpdGluZykgXQogICAgICAgIENQVSAxIHJxOiBb
IGNvbnRpbnVvdXMtMSAocnVubmluZykgXQoKTm93LCBib3RoIGhpZ2gtd2VpZ2h0IHRhc2tzIGFy
ZSBjb21wZXRpbmcgZm9yIENQVSAwLCB3aGlsZSB0aGUgbG93LXdlaWdodCB0YXNrIHJ1bnMgdW5v
cHBvc2VkIG9uIENQVSAxLgoKVGhpcyB1bmZhaXIgc3RhdGUgY2FuIHBlcnNpc3QgdW50aWwgcGVy
aW9kaWMgbG9hZCBiYWxhbmNpbmcgZXZlbnR1YWxseSBtaWdyYXRlcyBvbmUgb2YgdGhlIHRhc2tz
LCBidXQgZHVlIHRvIHRoZSBmcmVxdWVudCBzbGVlcC93YWtlIHBhdHRlcm4sIHRoZSBpbml0aWFs
IHBsYWNlbWVudCBkZWNpc2lvbiBoYXMgYSBkaXNwcm9wb3J0aW9uYXRlbHkgbGFyZ2UgZWZmZWN0
LgoKCk9CU0VSVkVEIElNUEFDVAotLS0tLS0tLS0tLS0tLS0tLS0tLS0KCldpdGggdGhlIGNvbnRp
bnVvdXMtYnVybiB0YXNrIHByZXNlbnQsIHRoZSBjb21iaW5lZCB0aHJvdWdocHV0IChtZWFzdXJl
ZCB2aWEgbG9vcCBpdGVyYXRpb25zKSBvZiB0aGUgdHdvIGludGVybWl0dGVudC1idXJuIHRhc2tz
IGRyb3BzIGJ5IH4zMiUgY29tcGFyZWQgdG8gcnVubmluZyB0aGVtIGFsb25lLiAKClRoaXMgcmVz
dWx0cyBpbiB0aGUgbG93LXdlaWdodCB0YXNrIHJlY2VpdmluZyBhIGRpc3Byb3BvcnRpb25hdGUg
c2hhcmUgb2YgQ1BVIHRpbWUsIGNvbnRyYXJ5IHRvIHRoZSBjcHUud2VpZ2h0IGNvbmZpZ3VyYXRp
b24uCgoKUVVFU1RJT05TCi0tLS0tLS0tLS0tLS0KCkkgdW5kZXJzdGFuZCB0aGF0IEVFVkRGJ3Mg
d2FrZS11cCBwbGFjZW1lbnQgbG9naWMgZmF2b3JzIGlkbGUgQ1BVcyB0byBtaW5pbWl6ZSBsYXRl
bmN5LCB3aGljaCBtYWtlcyBzZW5zZSBpbiBnZW5lcmFsLgoKSG93ZXZlciwgaW4gdGhpcyBtaXhl
ZC13b3JrbG9hZCBzY2VuYXJpbywgdGhhdCBsb2dpYyBzZWVtcyB0byBvdmVycmlkZSBjZ3JvdXAg
ZmFpcm5lc3MgZXhwZWN0YXRpb25zLgpXYWtlLXVwIHBsYWNlbWVudCBsZWFkcyB0byBoaWdoLXdl
aWdodCB0YXNrcyBkb2ctcGlsaW5nIG9uIG9uZSBDUFUsIGxlYXZpbmcgYSBsb3ctd2VpZ2h0IHRh
c2sgdW5jb250ZW5kZWQgb24gYW5vdGhlci4KCiAgICAtIElzIHRoaXMgY29uc2lkZXJlZCBhIGtu
b3duLWlzc3VlL2FuIGV4cGVjdGVkIHRyYWRlLW9mZiB1bmRlciBFRVZERidzIGRlc2lnbj8KICAg
IC0gQXJlIHRoZXJlIGFueSBleGlzdGluZyB0dW5hYmxlcyAoZS5nLiBzY2hlZF9mZWF0dXJlcyBv
ciBzeXNjdGxzKSB0byBhZGp1c3Qgd2FrZS11cCBwbGFjZW1lbnQgYmVoYXZpb3Igb3IgaW5jcmVh
c2Ugd2VpZ2h0IGVuZm9yY2VtZW50IGluIHN1Y2ggc2NlbmFyaW9zPwoKClRoYW5rIHlvdSBmb3Ig
eW91ciBoZWxwIQoKKE5vdGU6IFVzaW5nIFJUIHNjaGVkdWxpbmcgaXNu4oCZdCB2aWFibGUgaW4g
dGhlIHJlYWwtd29ybGQgdmVyc2lvbiBvZiB0aGlzIHdvcmtsb2FkLCBzbyBJ4oCZbSBzcGVjaWZp
Y2FsbHkgaW50ZXJlc3RlZCBpbiBmYWlybmVzcyB3aXRoaW4gQ0ZTL0VFVkRGLik=

