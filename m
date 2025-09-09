Return-Path: <linux-kernel+bounces-808456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A67B4FFF2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6794E1340
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7E524469E;
	Tue,  9 Sep 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MM0cVxDM"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868F2475E3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429284; cv=fail; b=MdKyOCAcA+bnjm6tlf1jZax3G1RI78I5siWeJcbuIsTlYSx4VKS0AMUsRaFw61XPY4CsMoiJUxLL6otnjmbXJH82WsE7iaCn6+gEaraSpEOXf8a1D2Ie+6w16N2CH3Tl8wbvgMDcQJn3PSZeAkT9T8hMlGHhykmQlm7Wa8ZNWgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429284; c=relaxed/simple;
	bh=jkZ9NqeVXjL8CMUGuZC/gLMgKD31UXRmK0AdIQ9w8bY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WykMulKXADFR3ryydLxJibu0aEf28Is1CwzdqsfHoCIj0no2nnQtWcsy/u30b4n2rO9yD68SUBT9wAB1/X/tUQzuJkuKOUFOBIe64Rr3rfWbnjdzxoOko+936wcBVZif5FqFpePe00Y6UUQ1TzNitP7mnkg8A91KlDTtwBjRNas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MM0cVxDM; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvy6Uc4je0R4ELawXAMKCW+YLpdSExK54u79stzxRsx1wncMOEaWT2W5f42b444ljpeBzAmyc0iEreya5NgYXctKwhuA/COisGx7OWVqLb7Kfh0pavWeiBJVzdpcp4sFby9J6AGSQ9gQqEHaEF3kQWsMjWWO1fW7oU8Rrr7DtFWR44O3VKyjy1SctDwzVPtx+1o5vsAvptn/VYnV5kQLNoxS7NzsCi1pTmczzILt9uH6mkQOx3plVpLGL9wjuNt4QvB4LC11jhnSjxMFSiR5NcN0FpVjiAofFq7X9FzTdLs2xiEM3lvnW6YefwVU+cqP2mGoWeTFLUvi/vPoEm44ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtOudSQXOQr3cc+i/dV5jCVLg46fgQQUAZ8ajmyPwes=;
 b=TnhMY9WMM6hD4247CVa8jcmvhlzj3OvSji0loDRTPwKK4Boa4UreFwtWGrJb7YOlO+6cxkqVfF2QHpN5UaXxEPdL5YiJC2/NaB7FsFU5uK/W74tJWAE+PMN8Y7HsU/OQ9TZpBdyX5GvgklxBZgQHRMPTxB8vNHtIkgu9OMAlWJuo+/sJKj0loVNyYViQ+u9Qq8lZ0FFRR1GKGiSX4b05z0Xf9joGjodCwa4NvRsH8pcks51uaoloIj3X2/0Z11skJCL5VMUKuG7gBMGyKaVr4vofvrL4qGuDBjTIK2pUYsHPHHF2fmVhNIVAvC8NapPaePIKSh/LU6FTdmP3mNfmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtOudSQXOQr3cc+i/dV5jCVLg46fgQQUAZ8ajmyPwes=;
 b=MM0cVxDMyVrLieIdsnUGZc6X7qXzhiWILs33yaqFcJr1GqWuaBuNsI1lVXoGufGPEoTZoihIQNBQDkubxzg63F6t0XZsi2jW2YpWzk9MPYCNrXpb0QpMQmCgBs96+6hAvx3e+eIjv4emKfqyyUfxxfCC9XMONGSapti86jNIke3EgW5fRtJ9UCNZDyX9xEfx8OkDf5S9zRJD/+r7JEq/sDcQrnFqGiOJ70Wv4TAPHFrV1UvkuVLjPrmlrPrGJ/VG3tNQsp1ZFyc4ijanHfoINzBadlg/SzsM0MExPkjQxpXZ26r9lr2DxluU//U8kHl5/fxYbwDzycTDNs0Eh01aSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Tue, 9 Sep
 2025 14:48:00 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 14:48:00 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: linux-kernel@vger.kernel.org,
	matthew.gerlach@altera.com
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH] MAINTAINERS: Change Altera socfpga-ecc-manager.yaml maintainer
Date: Tue,  9 Sep 2025 22:46:20 +0800
Message-Id: <20250909144620.579196-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ca0775-0b30-4ea3-4f09-08ddefafdee9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ebq+7LvgKoqfn+l77BeUnhcv8OfcdqWm3ncKi26jURc6+CniqfwyH0QSdbmt?=
 =?us-ascii?Q?39VyBaK50QytbCTfVzqJujcRllpclHoCNU2tMdqkW7SILvLkWyNbDYguPkzf?=
 =?us-ascii?Q?u5yKOmZTZ+mVcxBAyuEfAXSih9t7Nh1yrL96lohfuMcLEBiw5ONO/umvdn/a?=
 =?us-ascii?Q?O/W6myIyzPw2+adVuCxeh3WndsZuDLZNnVvm7eDOprddIRWE0G9CR3ugooyn?=
 =?us-ascii?Q?OHQXOCxy2c6omk7S3g15CFNNpaBia5wSpWa7JDQmqVEqA45nXo32FcACPVB2?=
 =?us-ascii?Q?rPv0toaMvm965igioa1Urhdu9gkjk+dDFyEf4VP+49XY+woVgFyRKeakZzNA?=
 =?us-ascii?Q?59rhIkb31S4YsvXjejRx7th7vQ/B1QFW8+eKcf2H9vnnXM7dv3BaKgFIFliM?=
 =?us-ascii?Q?2fHgNMLvXbmcBbHNm2j8Oyl2ScVNSwYSWe3J6XGzKXK6WJU9mZ6I5wDS3XHA?=
 =?us-ascii?Q?BzP83Jtt6qdPOGiTlVm5XoijK7UGqTlWCgqBmcJcCtG4/hp+Of1qO9KXEk+D?=
 =?us-ascii?Q?Y9WHGFy4oaH1gG7mA/AwKy3dZRwha+/xvYUjzWRbbghhL9/S2tNlujF75Wh9?=
 =?us-ascii?Q?5eeu+Mw7bdMLwuS9jZ95VAZGUlZBIQRU4hoxwfXzafQlgYK/01YN64KLpjsp?=
 =?us-ascii?Q?Vfi0eMtqcxHwNE49jXwKHXNj/3pGHnrK1I2C6HtmqVHJBnljGSbpXpZ1ArOC?=
 =?us-ascii?Q?iAP/XXjIScU6aBYfkS0kidC/g+tatvLZxJ8wJF+PnREjpHze4JBNAOcMKn5k?=
 =?us-ascii?Q?On3BoYQW2yu6Q47UWQIy7NebngHBDDVfUMLbwxY9WhuViZww7JsC8no+14aU?=
 =?us-ascii?Q?j+NqU6DgQhozcWuikt04UwkQzWdDtVW1XRlWWUB7O9dQlYg8uqAZDX2y0Q4p?=
 =?us-ascii?Q?AfsSjL9HXbxWSnXmOJ1oP1nP0oRs5cBbGxclmgYy9lBiPiEA0CYi/0Hv0MSF?=
 =?us-ascii?Q?IYpVN10H7QPCe9cyRqmvvIVdAlblp7mtsvmSy1RtAkzLTejwOSBMrxvnesNq?=
 =?us-ascii?Q?5cQqXnM1x7OIvMm5Hjj5kG2cT4R6QuHmsi8CrEOuOYp1EvCVfyK6ut4qit6j?=
 =?us-ascii?Q?EHNx8cRCB1Fx81wH1qkgFzPWfKBLNwjnsTjCTlRxOjG4qsGB2GjQanJlPhE/?=
 =?us-ascii?Q?Qd4SZcS3vL6xgBQJ2KO8HF3t+lcIsgTuuQXskjAe7VlCqDGspGKrr58PLzEy?=
 =?us-ascii?Q?Cq38zIRglH/QhWl7yHYWHkxkSKLhBdW5SEbU225kOd+g/96mH2qVMdbfKVu5?=
 =?us-ascii?Q?q3mWrmSV1+O03BrtVp0GxGdsTEDSHfirkYZMkOUQetFvsjaDJaK666HVd3Pf?=
 =?us-ascii?Q?eDMbHAVZ9XMqa7A+huOdsU9mXaZb3gcPOEe1748LjefoM87sa6UELnWy54us?=
 =?us-ascii?Q?X6x3/I/ir6+D1NK4SYUA9DSyzwWU/tRLxyQ74zJk51eQWxn/1kbRI6kuxo0i?=
 =?us-ascii?Q?412D9uAEHC0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMNtcw3vADPTQdlKY5lX/mwY+qycrjL61Tslvav593OGLPO7gKwI9KZju8OK?=
 =?us-ascii?Q?iMd//EpcYcN34b+qE2GlynS0Do7NE0BeBRCkB+YxgfSKeyQfdhH3v8ph0hCK?=
 =?us-ascii?Q?98udHNG8Htp6uj66T2NG2juLcZe8vzEYGxQ1YJbLPkxsn0s3gxh4dThaNfwH?=
 =?us-ascii?Q?+5VrCTsS3tipKYfuEm8ZjHiXvw02QtB4ZAh4bMsThGye/H2LgRy6gQLFY7D8?=
 =?us-ascii?Q?eKha/5ITld1MoSWSmUQuQX+cRHxeWUTuu8RnQGrszUE0kdcbOElY7j9Kn/0T?=
 =?us-ascii?Q?ftqEiYx/XgWc92v65uBWjxqH6jspSBzv03A2iFYw2Koq08UKOnvcQ9x7JZd9?=
 =?us-ascii?Q?TRILz2CBHSY8Ttt0Fe1R4GvmQF6xg204jePkwfAqOHcb3q3claRW+Hubruoj?=
 =?us-ascii?Q?/wXo8mwgDBdCRy5EEaFjZ6sEtJyMcYWoKkNr/L8FNjUWZVv8dyQrf+lDBcJY?=
 =?us-ascii?Q?CsO48BMhU5XkXzj0O27iG14OffC7+7/P6dNvKqx4EWpb4rHeE12O/MbdQM2i?=
 =?us-ascii?Q?ceBXdBVqy/jdgBezUA23kbroaxZvf1lNwQqrFHrOlS4yZLyua8FQc9NYkd5v?=
 =?us-ascii?Q?ZJArQNngIargXe6ZPo21x4EWgA0Ox+5WgqEEZAnkDbjl+xvF1yqTzhKzaxjI?=
 =?us-ascii?Q?to9XCiMqndJ9ut44p0WXWMUkXZuZNUCD8v/V23lyfNBjuyGxi7mEFjpIWHXY?=
 =?us-ascii?Q?88bCPtKzp3u8ubOdDg4xBKMZ6ih3UfWUeAJYB6dHV42KtQtUzERAbCiPjddW?=
 =?us-ascii?Q?XC8zh6m0DL/YOCJWH7H03Q+qpRs4BXBvGNg+rIao06PXOca8WnK2RTgcOQ9K?=
 =?us-ascii?Q?eWbYFrqSzVDSXkhz2bt0A35+cfgwOj2sTXslVfiZZkYugFiuAGI/+m13ZFOF?=
 =?us-ascii?Q?T/c9YkhuQNM9WeFCcYWPH2pxUQ68zHvCLhCIXmH4oJYkDAz+IctF8jgNQ92u?=
 =?us-ascii?Q?htoJ6CifXat4fFa2+b0fxAWlKTUn6IzIFVL/Ka8dH+wXnOdVnKWeWvsGHhvj?=
 =?us-ascii?Q?KWnEfpt41e1O4VwfXyfy1rtHeO8U9fFFRbRLO3zO5+S5uKB9nV2KzB+ZPfll?=
 =?us-ascii?Q?UnLYr5gocPByUyZDwFdZ5yRMngmpKHXRPltyy9gIb2RCOFLU1QC5CNKv/Ije?=
 =?us-ascii?Q?ECxucOb5BfjL+iyEWQyyCvKaNO45AEfsweKhlEV1ZYLz6pMxT68Fqs7fCjhB?=
 =?us-ascii?Q?CxLbtDPOtF6KheDbEl7xFKmbY/4SnfBqJgV+k/nNs8OYu4Da1eRyck4Y1X0C?=
 =?us-ascii?Q?PjtpXKA2/aiPIcRaT8p0LcwrvfSRgEQC60YMi7KboVeDIRaecv1RVn9xerN7?=
 =?us-ascii?Q?6gUn39DLaKk7j6+B78TitJg5ZxWVbL2++UHSdZQh2aGTXrRfiPMW7PirR/Xd?=
 =?us-ascii?Q?CnslzqkBwv6+sVknAxgGJoxuFSh1hOfN1ndo8kWcufydh2NFWJug3CVlhH0b?=
 =?us-ascii?Q?AOAKheJ/aEJX09YxuW8j/jF6cC2eTdsbGRCb6cbsZ48BWC61emTay1BjGiYy?=
 =?us-ascii?Q?577ZG3T/ttuci0j4JNId/DOWv0YigZ5+LJm2K50V8Q6sHhZ1477lUyudjtdk?=
 =?us-ascii?Q?P5Y3UKgKyV756rJi7NIl+kpHZEwLBtWlExXHr6jUT3Yp/F5aWS/QMkRqufLm?=
 =?us-ascii?Q?sCVq5etOx5tarPoimZHWm5QbeFPONW6pz3aOYSAbmUb8?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ca0775-0b30-4ea3-4f09-08ddefafdee9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:48:00.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u/Gyi6mzlobADxp851fYqOsKYU9oA1AVWwKtptu0LM8Cye9Zq+guWzaUneGI1NAQbeasmnjkl8SETDXGnlvGE4TKbxgdCU1tbJGz6cZsGAct8a2StrOCFKkG839vBst
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Update Altera socfpga-ecc-manager dt bindings maintainer from
<matthew.gerlach@altera.com> to <niravkumarlaxmidas.rabara@altera.com>
as Matthew Gerlack is moving out of Altera.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..bd97db99e75e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3362,7 +3362,7 @@ S:	Maintained
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
 
 ARM/SOCFPGA EDAC BINDINGS
-M:	Matthew Gerlach <matthew.gerlach@altera.com>
+M:	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
 
-- 
2.25.1


