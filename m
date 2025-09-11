Return-Path: <linux-kernel+bounces-811720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F25B52D01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A493AC009
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF742E8E0D;
	Thu, 11 Sep 2025 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Th5BA6H5";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Th5BA6H5"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023125.outbound.protection.outlook.com [40.107.162.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E902D2489;
	Thu, 11 Sep 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.125
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582430; cv=fail; b=VWAsrqhUGGIwOhKu9EcgjYAgbz8HBIWwm0ALffgrWNjm25T9z2myI+fKxlcP6Yw9QjH8SDXpPgPhSRqmKTJJ0EHno6taPzoZRI+bBDqhfTglvyWX8srWcXv5kMlp0x956VvsXDlXBb9KT1Ibz62lY4t6Fbhzo4M4lw8zpO4RoBo=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582430; c=relaxed/simple;
	bh=10ZZ46hcAm5/BgXiB74OXcEIcZW7qeoKPFX8y7x03YA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MC2exvg05Z8wP8X4bvXIuL/jJfBkqXqi8MhRpOL3St3NbX4tT5YXMC+5PuRjuJLKz2AcuAeaZKQ0TkZ925mlcjQUZSNgHiAx7zgu/JWhkzjG3utu4rixa+CLc0SFe64XD6NbKRSD2/c+bkhG30pu234iO/kycoWsVcxecKwd+uE=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Th5BA6H5; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Th5BA6H5; arc=fail smtp.client-ip=40.107.162.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=s+xzDO7B4rJqJ1/Mo2uQqyZATzvv1C7+7ULYknPfuN/lwEmmZRljsRPKoR5dujFZy3SwsZ44fs8sD3TuEPqGE7pVFYbUWE/lUlVosWzQAbO6EVl/5IoNhB/+ond1P4lGi3u396PkCFtcWxRxX4qS9uqLx43D1NetygRIATJRcd5e/v2gCyQb7kg5+X9foYPQGQMr4ZCb2rN8WyJ1Kr5ZWRO+s/jeFZDzqGD7INF27hWEVxFnBYFmv26J/U/x0uJvOKyp5E13hPr1Khucr1t04cpxlzJih0KSDYHRfst+1x9oToysfuEBfqm/Zd5FbD9GM+UPd/YA1yvsV0d6Bhh/7w==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKMQ/XLZsTUeFuQPm64LRPJ5+wKk9LwAljnayqzmlTI=;
 b=SySRPoIWte7ZcXfAtLV/U0Won2PGb8vw1HA2gAw+p94tTs08yx+4xO1P/JyVDLtRmIdYI46C13kqeYxLzvRKyW8R7bmaMboKf+tcELxTzmqCCcuVr/ZG4x4wunTpa4I31qjI4eGngArKhIsY8oS3Ye7W9oL/Pj29IyXT1qPRTgDtnsxix0IgUZfAlKZKWoV1EdErI3DPFV9aHPVvZYXYSG/uv/HxqkjgcYwu/KpWR23gcwcADvS5CkCxchG453tABx0jitW4qmqg5QYz5Mt8lZMs+CZm/wwYqFHYp6RLLlEUJOhNzDxZm9ek9+LA5MXDgl+9AfXZy5kr6XW+23r9cw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKMQ/XLZsTUeFuQPm64LRPJ5+wKk9LwAljnayqzmlTI=;
 b=Th5BA6H5Ocjy0fcJre/OYHLsSJA6K1+kJbeSjqzMcHTken6G7PID4GZ/BtGDtBYNoXnZ7wynuDJOyOTeuzDtjsS/cGZedJJFwOb3w2jlMAkJL5xano7l5MBYAh06/n+oSee/9Mfm5CwldK3/bYe+D1Mr2x6sIQ3zGq/rWb9EidQ=
Received: from DB8P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::40)
 by DU0PR04MB11258.eurprd04.prod.outlook.com (2603:10a6:10:5dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 09:20:24 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::a1) by DB8P191CA0030.outlook.office365.com
 (2603:10a6:10:130::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 09:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 09:20:23 +0000
Received: from emails-6309744-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-93.eu-west-1.compute.internal [10.20.6.93])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id CFE657FFA6;
	Thu, 11 Sep 2025 09:20:23 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757582423; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=gKMQ/XLZsTUeFuQPm64LRPJ5+wKk9LwAljnayqzmlTI=;
 b=PbrnRVpEzU4TKD8W+hFv6NfYeuQ59cyf8zXAGrcVTxTlYh9fH3sieBVmCST39n7X3W506
 Cawme+O/kDIG8E8uiogZH8JeZXmw4tTKR1mNZVGStgAKBu9GrmbTNYo//3nsPacamMULEQJ
 AsQaMIbXBqvpKg9Ni5ZZwmAOjQ+uZxk=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757582423;
 b=JdEJbclwKH0VYgr4ScnHrgQxhxojGPqYGyyvHx5Cc+JaIvDYfgZq89HfRSFhGd7jY74wb
 m2yWRfFaE1kLE4q/SPA69ajZyOij637UARKV6qKnBN71cxOP5mWnC7KWw2SW+D7/pKTIr9N
 7weHamT1M23wDNb2DoUNjmMJRSYV188=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5sfhog1iHDMertj+Ai9tAe3fEevfevi7Un5Ke74GSYeuVKZYZCf/VuLrlR+BTHN6qjecY5cjgA+K8Jej+u9XkObWxgMVO/SJP60bBJj8xASoTizOf1Lyvchh1mFUad2WJ2V85NSuU3i/kMj50LW+X9EXO9FR6bRo6wRbPQapvQJApWNVGNRYwCp2d6roEB3b0fIrpDOajArhtKUW81Gm4Jbg6lw10UBm+CMcMCBWmuqCToYSN3QsRRb2Q7dfUPLwUA+Cqdrl2BAgvQmYg+2rd0/bjErsyw/caNj0mI9cno+plSAb97LK6AqOtbUr7iktUNZas/JXYqiisiKzIIqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKMQ/XLZsTUeFuQPm64LRPJ5+wKk9LwAljnayqzmlTI=;
 b=fY/CQRZqVbQ+5aqKCFZBWc4q4ivmOsLTK57ezxdz7K8G80zeK9fSNHmpbiIK7CcGUcsGUHdK2shqm2s6OuEAULsN8NelhQKHHoiAxiin1yI5KQVUWa/WxS2KKDj3k6R8WxbG+C6nGMs9MuRX01/qZeYMMhY0WXy9+2bf16sV0nVlu5ZnPCkefmN3J2L1mPHQMts/1EgrwGlZcF3CFC3PC4oBSDJDLj+yuFl2Y3MErdpXoLLCQ9Dq0TVC37X0TWq9auHgYSFG7nXFkrvzqsaG2gpEZYt3DBhY1Y1EtBWLm1YRjZq1fWsQnViCk5Ax8ndx9sBWDau4++Tekhtv7ZAeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKMQ/XLZsTUeFuQPm64LRPJ5+wKk9LwAljnayqzmlTI=;
 b=Th5BA6H5Ocjy0fcJre/OYHLsSJA6K1+kJbeSjqzMcHTken6G7PID4GZ/BtGDtBYNoXnZ7wynuDJOyOTeuzDtjsS/cGZedJJFwOb3w2jlMAkJL5xano7l5MBYAh06/n+oSee/9Mfm5CwldK3/bYe+D1Mr2x6sIQ3zGq/rWb9EidQ=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PA1PR04MB11454.eurprd04.prod.outlook.com (2603:10a6:102:4ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:20:12 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 09:20:12 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 11 Sep 2025 12:20:03 +0300
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: Add bindings for SolidRun
 i.MX8MP SoM and boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-imx8mp-sr-som-v4-1-1b1fae6135e0@solid-run.com>
References: <20250911-imx8mp-sr-som-v4-0-1b1fae6135e0@solid-run.com>
In-Reply-To: <20250911-imx8mp-sr-som-v4-0-1b1fae6135e0@solid-run.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PA1PR04MB11454:EE_|DB3PEPF0000885F:EE_|DU0PR04MB11258:EE_
X-MS-Office365-Filtering-Correlation-Id: b7632274-d69b-4521-c23c-08ddf114702b
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?d3JHM083T3R1R2Qvb014RDc5Um9ETGpPR3NTZnM5Y0FHVCtYVk1hVzJXTUFE?=
 =?utf-8?B?U1BralA4WHhab0wrYndFRDJ6ZVN5UUJpT1Z3aThEQkUxRFBqWVRXbWJZRFlv?=
 =?utf-8?B?Um1KYlErTk9Wbng4WmxlVGNiamc0S0VmZ01YdkF5aEJWNVdvKzdwczZrYzMr?=
 =?utf-8?B?ZmY4WWVNOHdtY0UvYUJpZGRXV09vN0xreHU0eERuRnNKbzl5RGdIelErRGFz?=
 =?utf-8?B?V0xoNm1pY0pGajR5S0xjaFBhblFhV2s1Q2lJM3h5NG4vbWNiWVIwY3oyZkFU?=
 =?utf-8?B?S0tNNE9nSmxPZytwM3NEM05BT24wUnpOUTE1S1BuWldreU55cTZ4RmRybWtx?=
 =?utf-8?B?ZnV1Q2VZSXh3eG9mOTZlVzMrVE5WQ0lCaldJZjZCc0IwamtEWVNCUkE3UVJF?=
 =?utf-8?B?UlJyVFhoMURvWGgrSnVkZEtJTWpHSWtPZE84MHB3WThEcDhhd2M4blN3Z2xj?=
 =?utf-8?B?OFNaWU11N1l6K1FkUllBMFQ5ejhCajFleDUvd2t4TUhVZE9oL3ViSTlKZFBh?=
 =?utf-8?B?UTZ0VmNZVmh1MEJwWmRmdHBUamRBbGxXcUdhcHpOb05CeWN3QWZZMGwrTmoz?=
 =?utf-8?B?WjZ1ajBGcFFTRlQ3NE9XNThGTTRoWEtxd0xkU2VrWVl1VUw5Tk4zRERmdE1N?=
 =?utf-8?B?Z3JVUEhnL3dTSlR5WVh6RzdNMkNMS3orUXBqL2V1SmRRTzhNVXh3K2U2LzhQ?=
 =?utf-8?B?SjBwSXhZQ1ptUnRGNzc1MkFFZ1Z2NjhmenJCY0gvOEpBTFRoYS82RklCb2hU?=
 =?utf-8?B?dkdNMUQrSDRrTWxyWno2QmorR1VEYW9NdUhRVUFZTm9Dc2hDRTlvMzlMdTBF?=
 =?utf-8?B?N1A1VVRROHFaT3ltZnp6M0FCMzB4WDlzd1Q1a1d4OXZwMWxCRWMwSlNsam9R?=
 =?utf-8?B?WXBQWVc5ejNHVU9VOE9wS1lad3QyM0p5QjRoeCtyeWhiN0piVHlaQURUdjhk?=
 =?utf-8?B?TUFtbjc5R0VONmdJMVY4MWljWUdqWUVwcWMrTW5IUU5SY0wvS2lUVGNienRz?=
 =?utf-8?B?blRZNVlDcG1tYUFUZzVCNGdpOWljdWRIVWNtV1RLdnpyL2pQTExoL2xxSnN4?=
 =?utf-8?B?dGh4QkxKbEFLVEVReG9RSzR3Z1Z6WDVJKzQrckxnWFZ6dzBoVm1QUEdlNGJl?=
 =?utf-8?B?dmVhUUU4ZGx1MVVxUFdncDQxN0hsQUhicW1BN3l4QnRSV21EN2hjaTJycDdK?=
 =?utf-8?B?N2paczNhRDkvcEdLU2UzOERnbFF0TW5SUHJ0Tm4xdytJUlJwTHl4STNEa05T?=
 =?utf-8?B?cmFLMDVWNWFmQW1FMnVLVFFjWXlIb0VjbTRUZ1hGQUM5ZC9WMEN0WlRMV0tR?=
 =?utf-8?B?OUltb3FBZ09vOVdmNFNackdocWxZOVdDWHhRRXgxRkRUWEhoM1oxdDlBdmpa?=
 =?utf-8?B?THlKUnZ2dVZveGo2VnpSTy9UZlBlc3Z3SjF5encvc1JDZC9McGVQRHJ2SkM4?=
 =?utf-8?B?QjBVeGU5cWk4TkFpTmFiRFM2eGFtaXo3Mm9EVUpiV0lNTmxvZEFWTzYydTZo?=
 =?utf-8?B?bVdkUzBOclhhTWlTRDZHaldYTFVaUUFrVDFGb2xzblRVdHZpTTRpWXhiTmYx?=
 =?utf-8?B?UmE5TmxRWi9MYmxDNEJSejJ2T0R3QlFuMjBzZk4yVTF1TEVIVnh4cDlxVWRv?=
 =?utf-8?B?eVJNeEtFWGJpTEpRVk1acmxqbXZUdXRlQmcrci9DRzdlNFVRVGJ3d2I2YSs4?=
 =?utf-8?B?eFRGc2Z1SU5xMHE4TkpoeEVJY0VjYytsWjBqaG5OL1h2S29zNkcvRHVDdWwv?=
 =?utf-8?B?SWY5ZkRITjdjbEIzN1pEQ04xaUxUb2lhdVFsdi9RVmVzWGJnUnh4ZXBSOSt0?=
 =?utf-8?B?eEdEc3NRTzVlOUR1MU1kSHZVdlluTkV4YjhxVmZOZldVZEVVYUhNS1I2VzB2?=
 =?utf-8?B?YU1FajBmSERqQ1VBV1dlWmVGWXpwY0FoZWIwMnI2NWtlK0I0NzdPU3BkdTFW?=
 =?utf-8?B?SjAwRGk0cVVoNDRpMG52OEljcHUyblQ2dnJpdXR6STNiNHFySjhld0VQSWpz?=
 =?utf-8?B?VythNWN3QzlnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11454
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d3db51c9e98a43b4a2698589d4636777:solidrun,office365_emails,sent,inline:b8d89f8fb7121b0514dafe3b1055ac44
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	528303a6-4311-479d-0aab-08ddf1146959
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|35042699022|7416014|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEVCWUhTdVQ3NjMyeGROYjdOS3ViVy9tNTl5b3pqRW1yMU96eWZ3Nkcwc3Zx?=
 =?utf-8?B?ejRFYWFlZWZnVWI0bTlmTFNLaG0waWlTS05ERlZ4N0g0cW5zc1N2VXhHMXdp?=
 =?utf-8?B?NHhxRHg1bXlXKzAvYWxlTVA5WVJDQktMM2RLNnNSRjVNZGxtbXRuQm8zcmZO?=
 =?utf-8?B?YlR4TnM2QzhwUFJzQWxHbGdQVnZxWWRuTjhJalMzQi81UnlSVHFyOEJBMkt6?=
 =?utf-8?B?UThZN2dzclcremsvWWtsZ0ZQUnZ3M3VwcFU1MnAybjNVZnZXTXZXQ1lKSERR?=
 =?utf-8?B?US9EejBMai9PeDJFYXRBUWJHM2Y1ODhJdlNDekJDOHNiYWpRZSsrVEpVb1Rm?=
 =?utf-8?B?SEZUTWZ2MUdHRjJFNnRTRkhodDZKVmoyOFZGM0UyRkZldGtYVU50elU1VGsy?=
 =?utf-8?B?bGtJa3lYdnAyV1FmUENiQ1NEUmV2NDBRcXZVeUlHY3dyaW9yazh1MlRuSUo3?=
 =?utf-8?B?Wkl3a25zYmJRZVE3NkowcUZscUxBUlltRXVZa3lxbWJuQU5xWXVJbXBVTFR6?=
 =?utf-8?B?Zld2eE1IZ1J4YU9LblBVSFBrbE5od0pvZ1Q1TXAvV0d0L2plWFhUWVRDMXVN?=
 =?utf-8?B?b1A5ekxjYVlmSGxHV2NaczF5OC8rUkRiUGNSaSt0REsycGlvcFgrT2oyUFky?=
 =?utf-8?B?NGQ0SGU1REdFVHQ3enZSYkVWeHAzZWdBazRmNitjRHFxUGxVSSs1VnFMb2dL?=
 =?utf-8?B?MFNxTyt1SFRqNXZrdTJIaUNLVXIvclZ0VjlITHJJZUE2NEZoUEYvZS8xQXEv?=
 =?utf-8?B?ZUlxNm1jSlErQnlpSWl0aEpSaXV3UVdZL0pQcFYxeHR0bWlGM002U1JKZncr?=
 =?utf-8?B?anN4b3krcDBUcmYvSE9FYU9OcUVZekNxNlYzOG5scnVQTGVDZVozOXhjSVVu?=
 =?utf-8?B?emljVTVCbENkY1c2eEhIK0hLdStwSld6YmlrVit6YmZKV0lBb2lZOUMwWDBo?=
 =?utf-8?B?K1RCUXBnSm9henVzTCtXVWs4aWhSaUpZbFFiY1drY3dXYmNOSUI0MVEwT1NF?=
 =?utf-8?B?OTJQQXRNQkhabzE2cjdLOStXdm9EclJpQnJhS2s0NWxqZFUralVwLzZMS2lC?=
 =?utf-8?B?WVJQbDhIdVovWjh1M01lK1hTV29ZVzBzMVpwZVloRGlTTkhORm9sSklIZGxE?=
 =?utf-8?B?alhUakU3N3N5cGU2NURxbnJ5YnRmbUJjbWxSVUJxc2xaZk10bDMwRXU5dmVS?=
 =?utf-8?B?VHM1M1pkM3RaQ0RkNG9KWTAzek03ZkFLekFkNGI2cU1sVUU3WDBYZVYydmVN?=
 =?utf-8?B?SzRhak5QWnBQbm0vK3poTUZSVklqMlc3ZWNvYVd6OEtzSTZ0eUhseElSVDlQ?=
 =?utf-8?B?a2gzZWVaQUpEQm9QWW1oeE5rSVovREdhdzRSZG0wVmx1aDdVVnpRcnJ1WXNs?=
 =?utf-8?B?elRScTBreXpYbDFBNllITllybFRJNzJpakFmeGkrNHZEL2FVVTRzeGliT2or?=
 =?utf-8?B?ekJkU3U5T1NFb0pVbDRmckZNb0pmT1RFYTBaaFI0TzZ0T0NlWWhNQytxWlgy?=
 =?utf-8?B?aUpKbzRXVis1Y09kWGE1aGx2UEo0bFMxUVA5cWZ0UW5OeW85c3lWcjUvNVpH?=
 =?utf-8?B?TVVXdHlEUzcxU2s3ZDg2OHZrSXBFanNOeDdLcEF0UjFiQ04ybFprSWRBNUkz?=
 =?utf-8?B?S1FIWUlxbXhKZ2h0YUVYdnNzU1h6N2N4Um15U1B5OFJ1U3R0WFU2VFErMXkw?=
 =?utf-8?B?S1UvdEI4dUZmUlNFVS92RVYydmxPSmk5QmwxQ01RWDNlb29SRnBSY3hZT2RU?=
 =?utf-8?B?MVBsMTB6S3NoQWlraVh5OUw0N1lrOW1mRk56cHdxclVPdzU3RDl3TzN4dVRr?=
 =?utf-8?B?dDg3cWZxR2VmSFFOSVA2ZS9Hd2lCaTBqOUI1eFNDT3NEQm1xbkh1N1BZT0kz?=
 =?utf-8?B?ZU1RUUEwc3A5TSs4MWtsK2tDcU9Id1h5WnNkOFpXSnJML2JlMlplMnNqUzV0?=
 =?utf-8?B?USt1RndpYzExQUEwRkZac3lsK01nZ01YVjl5U3VBRGdRb2d4SVVhRUZjbEl5?=
 =?utf-8?B?Sk0ybXNBRngwTVhmMlQ0cGxhMkdJd0VnQ1VjUFh0YTMxVHNyc1QwV3huK3hO?=
 =?utf-8?Q?RmIOzz?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(35042699022)(7416014)(376014)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:20:23.9584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7632274-d69b-4521-c23c-08ddf114702b
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB11258

Add bindings for SolidRun i.MX8M Plus System on Module based boards:

- CuBox-M is a complete produc with enclosure including the SoM
- HummingBoard Mate/Pro/Pulse/Ripple are evaluation boards with common
  design but different available interfaces.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a3e9f9e0735a8808721ebba713f14818ee49172a..e03d1ee982cea851c7f8d70e8ed7b6564c8daef6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1200,6 +1200,17 @@ properties:
           - const: polyhex,imx8mp-debix-som-a       # Polyhex Debix SOM A
           - const: fsl,imx8mp
 
+      - description: SolidRun i.MX8MP SoM based boards
+        items:
+          - enum:
+              - solidrun,imx8mp-cubox-m             # SolidRun i.MX8MP SoM on CuBox-M
+              - solidrun,imx8mp-hummingboard-mate   # SolidRun i.MX8MP SoM on HummingBoard Mate
+              - solidrun,imx8mp-hummingboard-pro    # SolidRun i.MX8MP SoM on HummingBoard Pro
+              - solidrun,imx8mp-hummingboard-pulse  # SolidRun i.MX8MP SoM on HummingBoard Pulse
+              - solidrun,imx8mp-hummingboard-ripple # SolidRun i.MX8MP SoM on HummingBoard Ripple
+          - const: solidrun,imx8mp-sr-som
+          - const: fsl,imx8mp
+
       - description: Toradex Boards with SMARC iMX8M Plus Modules
         items:
           - const: toradex,smarc-imx8mp-dev # Toradex SMARC iMX8M Plus on Toradex SMARC Development Board

-- 
2.51.0



