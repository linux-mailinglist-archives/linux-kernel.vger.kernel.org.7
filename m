Return-Path: <linux-kernel+bounces-811726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36F4B52D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6464AA82A78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56A2E8B71;
	Thu, 11 Sep 2025 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GBjGQwCa";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GBjGQwCa"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022129.outbound.protection.outlook.com [52.101.66.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40191F63CD;
	Thu, 11 Sep 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.129
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582506; cv=fail; b=cR47oMjTJ+fzWuWUGePXpAv2ePkdKArc+d1UQVRUciLxk+m/3vRt7XL35EEKyR/CFw9X2WM2KvuGKvcYS/apyhYxby38lE+A3c5eNqbuQ5O7+Qo+0Q6AxUq9tVC8bBzzgRZXl6a75L7/v2iTOD672bRDMsTVdQwOEZaVtc+E9s8=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582506; c=relaxed/simple;
	bh=Rbwy8BDOVTAirownrvwqddv+FBKkUFDuhQQaxEEwxww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLeh3pauOEQrMUREqSldukUMwozZ6/zxVl7pgPiuaO+BpEZWJmvvc1rj8IiiGitEj7fofbf1f71nVILK6GyYKsD5VnnN/I3lEMPZ8Wo3t9x5IFQvGcNeaG3yMRSh6sVZi5rz+Wb62o/tPaD7q4xE7qJTDTz5EmJMTaOIRsC3He4=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GBjGQwCa; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GBjGQwCa; arc=fail smtp.client-ip=52.101.66.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=v5x2uojUuKNXZcnLuedDi6GheFvILzFN6kLX5WF+sQT+6wS4gRflVXLE6c7UtZmDUXkLhTRt2bE+NUkKgetX7Lc8/pF2/vaDCBI2ug/sXmhxU/ln3Efsft9DgxyENQnQHKtZ0zLmTXC1YPAqvWJKZQkv0J2qR+k6o8FraO9mzEIQf09cLQZq6QAIbtLCXL0NFM3j59qb0G7+2308q8x5i+9HRdiAiiYqqOWR364/G1Wb0XvrHYoXMw6Ndgu4nMuKCIGGwYUmD6OibOBZf5YUu1oO8ZyAROoP+nMPS/4IWfc5wOUddOudHC8UDKTOC2VWkrIUqv2lm+5ypsw0IcDjmA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbwy8BDOVTAirownrvwqddv+FBKkUFDuhQQaxEEwxww=;
 b=kMiwEprtjiLa/wSRmGdsnWYCw/TX7D0so66O8UEXUAMIzp3PtY3cFO58ePlRcXuUwTYcn7Gqk7NMarV6QgMyouLeZefBEv5iL1QNM5sqfmtGSkwiX+h1PE4wU6eymE6WdbkJQezXgjndS3WSf6UmTG4/efAIttvqWXSKxyY9jlisGcCwv0iS2Cxsr+XPgQrNuyXIv9lgwKTr2e/U+5yQVXJyfqIoojTZ9JJB8I81+eykiXegRcUKDCvWjv5J1g92bQl4ZvuzpRzUZAzcSnIesJfwNlPuB7Pu2v3BkOuxQ6X0B9qp2LN8xcpBKZHP+8gHyAnY+O29dHRO37Yh/Ogthw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbwy8BDOVTAirownrvwqddv+FBKkUFDuhQQaxEEwxww=;
 b=GBjGQwCaxk1HaKITMkSKATst/Y40Ltqzh0MvDIERJy15v72RHtKKVjgIyU97daNenqCk/XcPAp5/p52W/5VEt32aa3W6XcEg4Ou9HUZuRCC8VTY/1EQENSk2VBTI1iWIKgEMLXNA6ixh3LB6oToCaWInTXLsfFYiALViQ1jRSXA=
Received: from AS4P189CA0003.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::8)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:21:41 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::c2) by AS4P189CA0003.outlook.office365.com
 (2603:10a6:20b:5d7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 09:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 09:21:41 +0000
Received: from emails-1405719-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-20.eu-west-1.compute.internal [10.20.5.20])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id EFDCE8057B;
	Thu, 11 Sep 2025 09:21:40 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757582500; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Rbwy8BDOVTAirownrvwqddv+FBKkUFDuhQQaxEEwxww=;
 b=icBd527mhbpbI5WpUdR8s0fJlPFbr6eeVsa1L2w1Ctdb4vuVCpBFpUyzuNFbrbzune7Y3
 EHui7IxjqJRc/RZcM9FjWzN/YXnHYaUe7AI4PwedmqVt+nFDYQaK8tbrv0eFweI3CPIWD2d
 zqPFIQrtwCXbB+i9VEdrzFAk6OFRrWc=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757582500;
 b=MIxLcRhAyWRXNuLVkxhB6NbhrDE123c4FSCGSxiNQMrx3Jve0cRDlYg7L/rp6n0RC9Iv4
 E98iK7OdOPO4GeYTjX9meaLMx4FXiT+tYNzqTkBMJJdYVbUsfPGQzi84oGphWML7q2kWYUQ
 qTb+E5dg4zAf6VT1BvHpQi6KnWh7XfU=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU3KcU+rALCBnG1E31XEbhoMIctniLezHmfPyELRQfyxdToBoAzWRDgd2U8Q5H/GtpESvJC+A/47DuwOhaKVnIon3w5opc5DpkhJjaelMHkT4Xx04hkDZz00PBnn3K9aF+B3fLwzFOLpggmfrcAd1tVVWtqqVxYdzWok4u13AxqKsJd2aG6A1uPeSfxkqruGN6QWVJf8zxpbNLKzNqLDemJW3wY5g9Kg340SD2AQaCvb3VLV6LT9otPWEx+5Tw0C2yGRMoCkK2sn+RtGrzDWlJG+/qrSqhS1NdNygIEnOlBInFmC9Iv4Y3SztfMCRjxS2JIoF5m2gZEOWY0peTSHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbwy8BDOVTAirownrvwqddv+FBKkUFDuhQQaxEEwxww=;
 b=T/sEJlDA6zMPP+8+TrLFZ89XcaD3LqIw6UTyDDUlni0ItJvkbmtOjC4bu56n7b+gNkcrdJ5QSMSNDHA3fLzhBniG0Jl5xY0rMgLU76XebpGc+OlNp4dNFq5o4642+wnE+xr0dzZ5jYhEoyGbnG016r6U+atkOcxaCLyX0WPdQbqms9r+ByaVHqWpS1B+aSLlnBEXkdwcjX/DOhI2okmrWoiMhDh5BbGT9yfBudf7VzFrCt9XYH+dKRk4CqRD0Ij2bpDB4WkfmWByc5C2VtI1BqGZE+w61dkUpkHo6JqmA1ty7E8js/r53Ke+8wv4Ahn0fpU/wvzNeqhx1JA8gotxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbwy8BDOVTAirownrvwqddv+FBKkUFDuhQQaxEEwxww=;
 b=GBjGQwCaxk1HaKITMkSKATst/Y40Ltqzh0MvDIERJy15v72RHtKKVjgIyU97daNenqCk/XcPAp5/p52W/5VEt32aa3W6XcEg4Ou9HUZuRCC8VTY/1EQENSk2VBTI1iWIKgEMLXNA6ixh3LB6oToCaWInTXLsfFYiALViQ1jRSXA=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PA1PR04MB11454.eurprd04.prod.outlook.com (2603:10a6:102:4ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:21:31 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 09:21:31 +0000
From: Josua Mayer <josua@solid-run.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: add description for solidrun imx8mp
 hummingboard variants
Thread-Topic: [PATCH v3 3/3] arm64: dts: add description for solidrun imx8mp
 hummingboard variants
Thread-Index: AQHcFDo2H36HIzv+i0660rVLnJXFUrSNVMOAgAB9s4A=
Date: Thu, 11 Sep 2025 09:21:31 +0000
Message-ID: <3c52408e-da76-4545-b783-8c2f2abbcfa6@solid-run.com>
References: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
 <20250823-imx8mp-sr-som-v3-3-a18a21fbebf0@solid-run.com>
 <aMIrKYBPF2kMctIE@dragon>
In-Reply-To: <aMIrKYBPF2kMctIE@dragon>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|PA1PR04MB11454:EE_|AM2PEPF0001C70F:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: 663d26ce-7996-4c17-ec2c-08ddf1149e35
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bEFITUlwN2lzNmRzM2NzM0pnK0lrZU9aRFRsTFRiQUx3YXZOQkZnNU8rQlF5?=
 =?utf-8?B?V2pQeVRFMWdQUis0UEg4VXhHVXliejVaYkpwUk9GTnJ5azRoL2c5ZHZYTzcy?=
 =?utf-8?B?RjlMRzhZM1lOdkw5akRmcXVPbEhRSUVNRlVIUGRsa0RoSkJ3RUhLcTRXSlZJ?=
 =?utf-8?B?bmZDeXJlNjZpclo5S3VPUnNDZzkzcUdIWWhhckRzVXg2VW84WmtRME9XQkZM?=
 =?utf-8?B?RHUwS21BY3YxSXdJcHJZYlB2Q29RbGFoNVRlM3BVNUlkb1BJVFh3OUdCeWdW?=
 =?utf-8?B?WjFmeG0xOTNWazFXN3BvV1M0Z1hTcTdDQ2MrMTBsKzhWbGdTN1pMODdndWJR?=
 =?utf-8?B?dE5mNWF4NldjL1VsblBTaFVKQ2d6ZThRSFo5R1NaNnYxODNTamFSTUN1RmpJ?=
 =?utf-8?B?MXdzbThaQWtxOXBmbFh5eDd4YTB4UHRpU3p3QzJnRGVFTE8xWEZRRytoTk01?=
 =?utf-8?B?VHI5NUVETDlGb21hQWU3SWptM2tKanNpQi90Titta0w5S3piVVlZc2l2UkI4?=
 =?utf-8?B?ZFpRWG5BT0laTkJtRTBUSk9JN0p4TVhLMjBQWEg3ejM2cFJFU1E0QVo5OE83?=
 =?utf-8?B?V0pHYjRGTWh6bTB6YTYrSDJOeGZPdVlRWjRzbE9JZzliYVgxbWdWSkRJaFMy?=
 =?utf-8?B?L0p1Wi8rQlZrOVh5NHNBaFRoQmh1Y2gwcDFuVFo5cEFoYUVZU0EyUkcwM1pL?=
 =?utf-8?B?amp1cktEc0h0K3o2N3hidENHUUJhK3VETWJLVlFGUTZQa00wYkVJR3gzSWxk?=
 =?utf-8?B?SE9zM2c1Yy9adXFrZjBxWWtpc3NjeXZtM0VwZEt0blZuVUVoT240Qlk1VTZC?=
 =?utf-8?B?cHR1ek9vQ21rSVlmeUFpN21YY2VrVERKYXRVVHlhU1NVOExUZDNWUkp5TkFN?=
 =?utf-8?B?MHRWNkw1T0NnblJkaC9GUUk2dGwwSHlSUi8vV2l4QXArUVFTcnVBV2Q3djJu?=
 =?utf-8?B?QzFoenVQUS9xSTczOWI5dlphSWdBUmNhNkVzMEwzWWxGSUZicTFoSkFFVis1?=
 =?utf-8?B?bDRwUkNrbU1wcEYzM25SQXhpTDdGSG1IK04vWkNDelhlVUwwM0ZCWTM3NURw?=
 =?utf-8?B?L2dRSzhnMmZTVENHa0lSaHpCajBwWmQ2RFhZYXVxeXBTcmhUQUZpcGhjLzhL?=
 =?utf-8?B?UXlLWk9YQWpmZHp0S3NHRjNHZFUwRitGbWFrSHpDM3VxYmlCcE5XNTZmYURK?=
 =?utf-8?B?OWZnVWl3dFg3VEp1QUxqamx6a0Foa01RNzVKdTVtbGVoTlZSVlR5VFp2cytJ?=
 =?utf-8?B?aXJRQmtPZnl0UTNFVDF5bjg0OWFUa3B3NWhERDQwSWZURjIzSVNaQzI0UnhT?=
 =?utf-8?B?U3dYeE5KQWhkK2p1TGVaeWpIUXYzQWw5clAzYmc5OXR0ZHJSS2JWbEVjQ1l4?=
 =?utf-8?B?RG5jbVVjdnVDUE4vRDM1RTZ3dlpISENpSkpNR1BIcEhJa21KKzRKZHRvejl1?=
 =?utf-8?B?SXQ2Y2J5VlhiYU8vRjFCSDBtYjFxeFlUVnRoZlRMdE55N0dEclhOOGx1WXJa?=
 =?utf-8?B?NlF5VmFzRlE4Sk9EMXZMM0FGOHBLNHRmWm1HT2VpcFZmbzIydjltOFY1K2hm?=
 =?utf-8?B?ekFUMnVTQ1FqUE1YdndFTmxZUTJtU2s4alVGRmJxQ3VQM3JNMDh2YkY1aklK?=
 =?utf-8?B?UU8wTzljTm5LOC8wWkltR2kyVnk0Rnl2QlpZRGNKbDVVVVIvVy9VOTcxYXFv?=
 =?utf-8?B?Smx3TXlLcFgydERmYmdBNTF0cUpCMVdwTmJsN0dvUG4zdU5RclRYaVRVUk1D?=
 =?utf-8?B?c2lGbGwvOUxGbzI4Um1TK0w5eXdZbXR0VXlTV2xVUzdIc0VoeUZtYVhsaCtO?=
 =?utf-8?B?M09GK0dVUGxXRERvVUQreUdRWXFaYktFcklka2JCMThscEQybkpSVEcxS3gv?=
 =?utf-8?B?VU1tRk01NDMvRHE4ZmgzdXFQd296N0E1bWtlUXVZY1hueUlrNFRScndLOGVl?=
 =?utf-8?B?UlBraVBiUXpISCtmNGhWdUZvVzM3aURLSVJ0ME02OEtsSCtTWnpMbk41TGlT?=
 =?utf-8?B?by9PUmsveW93PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CFCE84C16A55C4FBF6F90EDBB2772B5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11454
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 9b3be6f3017748ddbc620a0a3da86019:solidrun,office365_emails,sent,inline:652d87bfe5c56d138e3e6e6824146e9f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	692379a2-7544-47eb-f905-08ddf1149868
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2puRUFheW9HOVlRRXBuOHpuWnZYaDBUTWhHTk5aQk5mNWRzOHdVYzloaGJ3?=
 =?utf-8?B?NmE5cVAxcno2cG1TK1lEOVM4bDExeXVZcWVweTJwcnJ4d21Pd0dsQzBZOVRm?=
 =?utf-8?B?VFdnL1dhQUpDbnhOTnI5T0FSNG9JdFViWWNJdGhvTzZDNzllTHFsSlkyOXlK?=
 =?utf-8?B?NDlFODdmdkttamc2REgwY3p6bHRhQU9rMS9idUFrQVdnQjRqTHlIblQ1U2s1?=
 =?utf-8?B?UThtK2l3emZqNTlvcFNxUVhYWWp5Z28vTVl3eGpHTnp6Q3lscUhydkpLeHVL?=
 =?utf-8?B?THBUN2VvMmxFRnVHTXRrb0lYSmY0aFJtOFRTdm9ZWm50OVJBYmFhM0l0cVI0?=
 =?utf-8?B?MUxmd3U2YXdkOFVNTlV2NndMdGhrYXJ2NUdXWUlkbG1Sby9aaTZNc3NVY2Ev?=
 =?utf-8?B?ZHZxelNGYndzU0llM0xLUzFjTHFTdG1kSFphS1VvdzgxcUptS0VmR1UxMUJh?=
 =?utf-8?B?bmdBdUlKZmIvdjNwWEVQbWVrRXR2YUU4Ny9SRC9UK2M4dS9aRWtxTVRmRkxK?=
 =?utf-8?B?UE5WY0RFcHFlbnNLRldOc080TzY3ZkUzTnRKK2NZeGFkVVVkdGJkUUdOSHhP?=
 =?utf-8?B?YXk5TE5nbmNSWngxVUhEcUdOak1JZ08zNFlQeXVtSDcrcWhQaTVQK1Z3OTNJ?=
 =?utf-8?B?OVJkYWxWb1AvZDZXTnhYeThHT2kyVWxPOW9NbEgzUFB6S3RYazZPL2MyaDl0?=
 =?utf-8?B?bkxHUlk4TVg0bGZlOCt1SzV5SjRRcm5uUy9aRWFWMDZkbG9vZ0lLNGNtL3NS?=
 =?utf-8?B?VGlXcm4xOENBanN2cVNoL2JqQUxGd2RxanA0RW1tVTVYR2M4YS9Sd3pzSWpi?=
 =?utf-8?B?dVJYdGxmeTJHRGliOUNHTVI1ZzljK0lGVEFYQjFFSVd5WHhwaGRQeFdUM3Nx?=
 =?utf-8?B?WVJ0REdZSm1JamtncTA1TTdrVUhMSDZSRk9WUEdXa1F3VEZzWjljcmNlbUxL?=
 =?utf-8?B?MExtN3ZhajhHeDRVK1ZuL1lRMFhKdE5qTTFsaFRTOWFaQzBqSkE1R1VHQUps?=
 =?utf-8?B?UjlZZ2U3dzlYMklFR2Z3TE9TdzVSUi8zd00wQXkzSFpELzFsMGFQd0k3Q0Js?=
 =?utf-8?B?enliRjhwS2JpdE9jTWl1TjMyRzUzSTZ2ZHVDUWtTT2E5ODVZSEJMOGFYODVn?=
 =?utf-8?B?bkJ1eFVoUzdBbXorMTAzbzlTV0FwWkxTamRZa1VPb0d6b2NjNkNVT2h6cEJl?=
 =?utf-8?B?eElrc2dDU21ycVRGWE4zREZPbDd1VDNyZU9HYzFYV1ZRYU8xd0ZlZzFONHhh?=
 =?utf-8?B?NGFOQVpBQ24wMjgrTjIyZGdpdmFoRVRycG9qQ3dFcVFIUlQzZmlDeFlyczNx?=
 =?utf-8?B?TmQrOTNocGZRMldDSTdUMFBlYlJUbzBVTDc0VG91dHJ3cHNiakN1VzF2cTJj?=
 =?utf-8?B?MHVmU0UxMkIwZlhRWHUxRXlrYWtIdmt6Q1pjQXhkdk44SWFKZ0ZBbEwyNFlU?=
 =?utf-8?B?L2pqYms4TjJxbTMrL1YxdE9CSEZBV3NZYWxpOHNvU3RSVTVKZjRiQVhjRndT?=
 =?utf-8?B?Y2JPL1N0ME5PWVVOOVduNE9zSi9DRm93VDVLUnRPNk56cUZBTUdBemJEV0RI?=
 =?utf-8?B?d1FyaGw5UXRvS0hKdENBeGlsSFh1RFZacU5PZGRQc2d5UEpFejVYRHlEejBO?=
 =?utf-8?B?NHg0aFZRTFdseXc4WGhPNlllcThwU20rNkFNVm55d0pPYzI2QWlOUTRWRmly?=
 =?utf-8?B?bVVLT0JoQ3Z0S2gwY0lOcTMrYnQ5azRyKys0dzladlBZVzgxNHN0OW5xOVZV?=
 =?utf-8?B?UWJnUUZ6bGFvZkVBN2twZUFkSEFZRzlYUWgvcGlvcjdhVnpKL25JT3h1OThX?=
 =?utf-8?B?VDE1WGRaTXA3a1RreEgrUXpkUjVZbWliajk0QVV4aW8vWHhUa2hzalE2aU03?=
 =?utf-8?B?cGtjZklvK3NZRUpnc1Q3emo1THBwQXpxVDVYWmJCU3BnQUpxVW9OcHpXR0tH?=
 =?utf-8?B?clRaaWpXVXRySkh4NWZJc3BITi94TzJkODFXVWRQMVVtSTdPQXM3V1RsQVh4?=
 =?utf-8?B?M3d3UUhxcEw1VSs5NjJxclV6NFIvUitJQmdqaTZ1MXQ0dkg0c2c1R2ZkSzFy?=
 =?utf-8?Q?7hx50I?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:21:41.1587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663d26ce-7996-4c17-ec2c-08ddf1149e35
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041

QW0gMTEuMDkuMjUgdW0gMDM6NTEgc2NocmllYiBTaGF3biBHdW86DQo+IE9uIFNhdCwgQXVnIDIz
LCAyMDI1IGF0IDA1OjI4OjIzUE0gKzAzMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gQWRkIGRl
c2NyaXB0aW9ucyBmb3IgdGhlIFNvbGlkUnVuIGkuTVg4TSBQbHVzIFN5c3RlbSBvbiBNb2R1bGUg
YmFzZWQNCj4+IEh1bW1pbmdCb2FyZCBwcm9kdWN0LWxpbmUuIFRoZXkgc2hhcmUgYSBjb21tb24g
ZGVzaWduZWQgYmFzZWQgb24gdGhlDQo+PiAiUHVsc2UiIHZlcnNpb24sIGRlZmluZWQgYnkgdmFy
aW91cyBhc3NlbWJseSBvcHRpb25zLg0KPj4NCj4+IFRoZSBIdW1taW5nQm9hcmQgUHVsc2UgZmVh
dHVyZXM6DQo+PiAtIDJ4IFJKNDUgRXRoZXJuZXQNCj4+IC0gMnggVVNCLTMuMCBUeXBlIEENCj4+
IC0gSERNSSBjb25uZWN0b3INCj4+IC0gbWluaS1IRE1JIGNvbm5lY3Rvcg0KPj4gLSBtaWNyb1NE
IGNvbm5lY3Rvcg0KPj4gLSBtaW5pLVBDSS1FIGNvbm5lY3RvciB3aXRoIFNJTSBzbG90IHN1cHBv
cnRpbmcgVVNCLTIuMC8zLjAgaW50ZXJmYWNlcw0KPj4gLSBNLjIgY29ubmVjdG9yIHdpdGggU0lN
IHNsb3Qgc3VwcG9ydGluZyBVU0ItMi4wLzMuMCBpbnRlcmZhY2VzDQo+PiAtIE1JUEktQ1NJIENh
bWVyYSBDb25uZWN0b3IgKG5vdCBkZXNjcmliZWQgd2l0aG91dCBzcGVjaWZpYyBjYW1lcmEpDQo+
PiAtIDMuNW1tIEFuYWxvZyBTdGVyZW8gT3V0IC8gTWljcm9waG9uZSBJbiBIZWFkcGhvbmUgSmFj
aw0KPj4gLSBSVEMgd2l0aCBiYWNrdXAgYmF0dGVyeQ0KPj4NCj4+IFRoZSB2YXJpYW50cyBNYXRl
IGFuZCBSaXBwbGUgYXJlIHJlZHVjZWQgdmVyc2lvbnMgb2YgUHVsc2UuDQo+Pg0KPj4gVGhlIEh1
bW1pbmdCb2FyZCBQcm8gZXh0ZW5kcyBQdWxzZSB3aXRoIFBDSS1FIG9uIE0uMiBjb25uZWN0b3Iu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+
DQo+IEl0IGRvZXNuJ3QgYXBwbHkgdG8gaW14L2R0NjQgYnJhbmNoLg0KSXQgbG9va3MgbGlrZSB0
aGUgTWFrZWZpbGUgaGFzIGNoYW5nZWQgdmVyeSBzbGlnaHRseSBjYXVzaW5nIHNvbWUgZnV6ei4N
ClBsZWFzZSBzZWUgdjQgLSB3aGljaCBJIHRyaWVkIHRvIHJlYmFzZSBvbiBpbXgvZHQ2NCBmcm9t
IGVhcmxpZXIgdG9kYXkuDQo+DQo+IFNoYXduDQo+DQo+DQo=


