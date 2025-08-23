Return-Path: <linux-kernel+bounces-783080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5382B32925
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C1AA1373
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2AB236454;
	Sat, 23 Aug 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dXaaPMo3";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dXaaPMo3"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021085.outbound.protection.outlook.com [52.101.70.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40F2459F7;
	Sat, 23 Aug 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.85
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959336; cv=fail; b=Rg40Z6MBP2q2lPJ7xqxquHiF0vSiRkVoeRvbdBBs4vv1VKUBnOYpvoxOGBCtpGGrrTjJD5G9zfh8RJxcTvNyzVLBBX5YuDBP1yYuJxzCjmfetuNkE/kO9fGBj8YRVF3mBTHKJ/PYu+Xefp8plm07gKvplVW5s+nvKqR4Auyvghc=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959336; c=relaxed/simple;
	bh=xZ+C8DN79YzpG7YAFsSm9zYXvF7vG4CcF6Ji8ggcM+8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IsfmHye67OdyeEGisJxORq4jHh9fryDpZdg5dU9trGt+ABbh11xhkiiOheNXAUObtgq0lNa4ANxmUpeSHslSLW8ILeLtmqyV9zJQ0w36kKuyYVPwxk3rGnSk40w9C3V+6lWce11mS1JOqXC25abd9RI3sjei23xI9aSXSJJZFWc=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dXaaPMo3; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dXaaPMo3; arc=fail smtp.client-ip=52.101.70.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JeE+okdGBGPS2j0ZOvFcWtcEm3h0cyvIKiU0QlrbVz+80kWYzFyEr6rqQldwwTNXwm2EDwG/VJ+lx5VUthZs3uvKOSDICo190YeYD68uzKu/ge+GmCeCL/YRbzEV7gLu/LAEA+yDrRM+RQJR9WInlFf0h2A6DdTWdV15WaLmfs3FPOPhNQZlFsTbVLLVNa0KcQVH1hjrc9ohgEhsbzqxuPGk1ENjPts2aCwjuo+xJD61cbZ+u0m2Vt11L1YNkyVAB+CY7eOdp68VjCDCBmCJ/4kATXkkwZLqO+ba7Q9lb+vN6UhRLc4DS2c00CE6Dgx04wqqxpUSAKrD/uNrM2NUoA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIAhRCb2/JTixFvWkN7L2feZlppRnp6j+MA0FybcfDY=;
 b=gAJ3K7Ox0iHe7PTAFfD63nc+a3zJNY57HR1LNAC4L3dDQ9baJ/hshtFugcsoDXetYJEjYLcOboy2Xu4B3vUIVqxlPP3iiVqJfS2m3MWXfoPI5VmhA/yN2mJBkND96u2ELMnqP+JSw5rmZmtWvWWM6IKqtUdvQy+/CCa0QhXTfj7LS9pjKdDqCm7sL/Gv3iKegnfnB+neMOLRi9FTwxPy9UJZbVHI7MokNh3dRFdG1lGZvm8ByjdIlhB/8wDxIonO2cO92qba8uUGt0tttrYQKpAK+/3B3Ii+wyJZ1nKqwq8OWIBy0qrNLcXqo3IZ8SUXrtf4yNXBfFx7qrd4fm7XYQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIAhRCb2/JTixFvWkN7L2feZlppRnp6j+MA0FybcfDY=;
 b=dXaaPMo3rSEO/DDSXz0VwGp0I6I40apQfADDExpQkdlxqxTkSIb/dMHCYZYihZNZ2BW34hDle4AFUhWy/Ku5/kAgJ/60Eq2X5dgzdukN9SX6r9AORDWYIuD4dvVgS6aN2sOBKgXdTS2TBtKQF8hKZmXD7MDO7/cUFmhGT6Rcpjw=
Received: from DBBPR09CA0035.eurprd09.prod.outlook.com (2603:10a6:10:d4::23)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 14:28:50 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::91) by DBBPR09CA0035.outlook.office365.com
 (2603:10a6:10:d4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Sat,
 23 Aug 2025 14:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Sat, 23 Aug 2025 14:28:50 +0000
Received: from emails-9206919-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1273180043;
	Sat, 23 Aug 2025 14:28:50 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1755959330; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=mIAhRCb2/JTixFvWkN7L2feZlppRnp6j+MA0FybcfDY=;
 b=He5RIw2AkQJn3ksaaXBs1A6I0yKwb8lLbXcCmpUl0Ob39zEKskpsrL22Z+2Iv1ADW0cD7
 taDe1S352C/roE2s5BtUzMTJzKP0khWk841g7RHOAbqXp7/f2yM7mzAYB9oKIGObI6jmuVz
 Gpzc0PUr6AvEKKtlBpXld3j928v7wJM=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1755959330;
 b=NMXcsPK6qp3mGQBtrZSL1S9nJIYc64buknrajclrTt9FKChp8+ZR5nE5H2jth6kx3mMK6
 yCcfxLVJzV+huQtSnafYtzUDPSSj6gwulglEbi7OhOyuGYz3sjoVZeqQ+nYlE86r1LXw1/9
 IyqkyySiPrmUQ3yNUKlFGwdcnGV1JII=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZ5UJnwZ8hl2PryAGiR+9huUbpcJat/WOaRQDLnWaZAenTAD4V5v4ToUuqywl76popH3J5PllZENA3uOx1mghYKLBokbQIzi+C8b2jBnavse2ACtArOU4h57HFmN5Jajai6W4uDRa8nXlIMrqZ9I0w6BQNogeUzxSAbvJSQ0cCUaIICtYGD9aJljw87K74wxSxXLmxSudk9M4p4qzaZbcNsNMwDLRytAt4nK8vW+0E/PLVhJ1d2RAUs85DFLabse9C1/qrO3ye9/HtTQqBo7MsgSyxCFfm+vZy5byEYPM6VwX7QRkU3tXOOOTWY83p7BPefjp9H2H374cuCG1TWTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIAhRCb2/JTixFvWkN7L2feZlppRnp6j+MA0FybcfDY=;
 b=MHE+ZWbhhI9L1J65aPvOyh56/LfKMz9tamy78K9XacxwIeDDyP8u88lfqX8Vb/qj5gIFHdY9d+XfZU0dUVhvPJZaMuU3m67dKxVaYc9naWbrWy5PiootcbPw7txRNe9qTdYdKKWJQ2mRmATKonvOE/HvQjcvQQazDcWE9k2Q/QjK1UDotDI/PEJWLW2+TXUXRQod46JXeuzDkrISE7ydKDAKrxPyQOOkylS7R291Z1JwwXmxzrbIrGnXRbzRzhnMYNW72lFIjb2Ecn/e8YngxOyJ/dVrf/JX0jWw0ya8Jqe9gMlM8vP59TUBWlDHgm67sFvsu+C2vY1Mt2llJ6AMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIAhRCb2/JTixFvWkN7L2feZlppRnp6j+MA0FybcfDY=;
 b=dXaaPMo3rSEO/DDSXz0VwGp0I6I40apQfADDExpQkdlxqxTkSIb/dMHCYZYihZNZ2BW34hDle4AFUhWy/Ku5/kAgJ/60Eq2X5dgzdukN9SX6r9AORDWYIuD4dvVgS6aN2sOBKgXdTS2TBtKQF8hKZmXD7MDO7/cUFmhGT6Rcpjw=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB11146.eurprd04.prod.outlook.com (2603:10a6:800:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 14:28:37 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 14:28:37 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 23 Aug 2025 17:28:23 +0300
Subject: [PATCH v3 3/3] arm64: dts: add description for solidrun imx8mp
 hummingboard variants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-imx8mp-sr-som-v3-3-a18a21fbebf0@solid-run.com>
References: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
In-Reply-To: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
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
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB11146:EE_|DB5PEPF00014B8B:EE_|AS4PR04MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da57832-8e85-4d09-96b7-08dde25160e5
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bzZjdlVhN3c4bEthTW5qMC9MWHJkOHpVL1JSc0E1U0FTbWlvcEdONnRwazgx?=
 =?utf-8?B?RlgrWWJPOEdNQU5NM2IxZGYwRUxmTDZXeGk2WElwendwQnpNQVppcFY5VnND?=
 =?utf-8?B?czEzQVc4V0lSWWQ5bnZLK2FkTUJOL2RhL1lDK1dndSt2UFJvWWRFRmtQQmQw?=
 =?utf-8?B?RnFSemlmR3JpT0RXSWd6WURIalNYVmlaSEVuVVVzRE05SmZLbkY4TFRQMXV2?=
 =?utf-8?B?YkJQWjJIdXRXcDgwUTBSVGo0bFlnSWdLc0RlV2FEVUNxVzNscWhHanMxejdU?=
 =?utf-8?B?Zi9td1JwczVYMi95OFM4ZkI5MDRyZk1XcXpvYjE3UHcwNXhpeWI0aDhmNmhS?=
 =?utf-8?B?VlhXUllIWENtOVVCR3R0dzRnQkpvbVcyQmZXS3NQMHZFSGtVbnFpaFlzZ1BV?=
 =?utf-8?B?a1dENGhJcTV1NjJleGt5MnpXcU84dTNUaDFBV3ArMXNNc3JkcHdQVFJMNWND?=
 =?utf-8?B?dUxVWnB3cUdaTmVkT2FOWmtZWDIxS0hxb1dubGkyMlFlYmF6S3ZKVmdjM3hv?=
 =?utf-8?B?YjZFSVJvS0hSSUdLYUFJeWp4VWhzbnUwTDRxN2lYWW9qTnhGd2hjQ0lnWE5U?=
 =?utf-8?B?TG5QVTVCMEpucnUzWm1acDNGTnc0QjZnWDJhUnQ4QWI5TUJ6bExCQ3psRkh1?=
 =?utf-8?B?blFDZlRNQm9aamZuaDlRc1h6VG5ZTXNpNXBQcjhhdW52dC9FWFE3ZTNsYU5Z?=
 =?utf-8?B?LzdXdkpyYjZWWjdyTTg2VHBSN2YrT1E2OFBpQ2VwUFZiUFNIUXAzd0I3K1pD?=
 =?utf-8?B?WmtjdDhrakwweXJtdGJDWlFkNVpoUmc0N3YwUGo3bmxhRk5wR0pXdmNCYnBT?=
 =?utf-8?B?aVBTRGpOU0RqUDBZRWROYXU4bHpZTG9OUW95b3lNWGt0clM0MUdpclNkZzN0?=
 =?utf-8?B?VXlrOUFWdmhmQnkrUWdoZGEvZ1AyL2JDTEhGT3NGRlhqelVxeFMyL3liOWNt?=
 =?utf-8?B?bjI3ZzZDRCtSb2hpem9mR3V1OTRucFlPY1dHRzV4WDNzczFMNEFNbGxrWEcx?=
 =?utf-8?B?dVFDRDVDVDVyYmFjcHR4TmxmUWJEVEdhTTltWVd2UGpwYmtmb0RVUVhLWE5T?=
 =?utf-8?B?UUVKOU1vMnY4VTg2WkVJOTkvcm1NU0RMUnV0VnlQTDV4bXN3TGtRQjdmOUR1?=
 =?utf-8?B?WngyS3cwSHFFQUttRElhbDZPWVV1R1hDeDZvZ09taHpiREdFZi9xeExyb2VN?=
 =?utf-8?B?VWs3QTJrVXVCMmRucnlxeW9LTUxBRmhPMm15WlV5aWxHaCtXUHdjanJCais2?=
 =?utf-8?B?a29JM3dOREhBK2xVd0huVnFyaDJmMUhTL0pnREV1eUJJaFNjUlRKVW9VQy9U?=
 =?utf-8?B?UWVqZ2g0Ty83V095ZFlEQkZNMGU1bnRBN0JXOEs5MVZUNzRSL2RKS3FBQjd1?=
 =?utf-8?B?MU9Gd1A3NzRCZ2wySUt4MXRseHVSSjg5N0Y0ZlRDeW15bk5mZjlnN2RWQzNH?=
 =?utf-8?B?TUlYcFE0cDlhTUZ3M1V4UCt6SXowcTNFbzlJNWRUMDdOcm05QlhrUVJQNHNG?=
 =?utf-8?B?eFRTblo0OW5NUnhOVXhLWHdXaEtWajlHdXE0ZVpEVkNqSFlOYzhCMmYxRFpo?=
 =?utf-8?B?aXoxWTNPRzFMbzJKQThNK05tSEdWSmh1alZIZlY1LzBhVW1jRDVwQUtPS0o3?=
 =?utf-8?B?WUdNYTBic050bkN1RzNPOHVxaUwraFFmZzRMekZ2QkVlK0xic1VQWWJQTHlP?=
 =?utf-8?B?bytmTUVmNmdaQU53bm1vMXNzRVNXYzRlZHI0K0daRTJHSEd4VERObmFOOG5N?=
 =?utf-8?B?RDJuTnpzOGZ0NSs2V2E1SkN4cTUzaGRNSTlCbEFjNTdMQ21aSlk3YlBieFBv?=
 =?utf-8?B?aG5TWUsrZEZoQUh2Tjl1WnhIYVd0UHhTYk14NDlpbHRvYklYSTEyY3h2WHQ2?=
 =?utf-8?B?Yk5EejFveXJzbU5tcnlqR3YyV1lXd3U4c0Z0RU5WV3htaVprTDdUdU9GTGVy?=
 =?utf-8?B?VGVhZUptdkRPOEVDME52S0tZc2FXdTlyRTE1czRUa3pxbEs5VFJod2lMbmhI?=
 =?utf-8?B?VWtPVXVjTllnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11146
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 665a6b32b60f495185a3bc6b0500061e:solidrun,office365_emails,sent,inline:a9cfcf818f3381afc2c17a6361a4db5e
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	094ef201-974e-4aae-aeb1-08dde25158da
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|35042699022|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Umo4QmxHcEJ6MDZSdmVaNGFTUS82ZjBFeVB0MVplYm0vdzdMS08vbXVNb2oy?=
 =?utf-8?B?bGdTSk9DRjVjaVpPbEtJWERJdXk4SCtFV2FzOU9VL3hMY0t5eGRvUTEwZndv?=
 =?utf-8?B?MlkzeGdaMjRFd2FCaUl1QlpEcFk3eStaZEt2bFplc3ZoTEFYeCtTTkNlMGQ3?=
 =?utf-8?B?NmlaZTFxRGdvS0E1VERuSXZydE1wcDdkajRzbEtjdmlvTGVNV2JSWWEraDhP?=
 =?utf-8?B?Y09Qa2ZEVU5TanZlNFNkbFBUbm9WOUszSUs2ZllyajJCYm9DRXVTM21FSnNo?=
 =?utf-8?B?N2JUSHdqSGdJc01aRG9zb1hzQUVvaS9PaUNCL1NZUzBYSUFOTllJaFdkNDUr?=
 =?utf-8?B?RWg1U0pORkwxTEZsOHIvdXBITHJHdkh6enloaWlnZnJsUEpXRHZVSjBYaGlB?=
 =?utf-8?B?U1NsUTZZc3gxb3F6dy9ER2pQQXZzbkk2UjhjREdrRXFLL1Q4SjJCVmNlRnJZ?=
 =?utf-8?B?Sm9HUjFrQy9UWHlqSU8yYTVnd0dTOTZsdG5FeDNwNzhKeXhhQkVGNjZSbXd0?=
 =?utf-8?B?TENJd2tVSnZqRXo3TjhCZHhPOFZsVFo2OHdKTEh1SWtOaHpIMEVJWlRNaHRN?=
 =?utf-8?B?MkNIcjA1aDlreGdHWUZGOG9SUGtMYllnVktyUXJXbFl6WjYwaEcwLzZKZERh?=
 =?utf-8?B?d01FYk5ENVF6TEhEdkVxT3dhT2JoNkg2REU2N08xZW9DdDNDOGh0R0czU2Zp?=
 =?utf-8?B?U1ZRTkJKbGVLODJRU1hnQmFSeEh3Tnh3bGV2YzRmbUk4eTg4SjAwUFhVS3Jw?=
 =?utf-8?B?RExZQWRqTUlreGQzTFJCV2xFSXgxL2xmajRIdGRuZWhsTjJJQkJpRHRDQ1BJ?=
 =?utf-8?B?U2JiS3NmMXd4WjFtNXB6SlpsOHN3OHhTSVZWU1I5ZFFhem1lS3hPWjRIbzcw?=
 =?utf-8?B?TjRRa2xySDlHelFVZHk5TkdVSUFhUUlJZnhMMEROM3doN0hGVk1aalh2Nng0?=
 =?utf-8?B?cGVUVDAzUjFEMG5KRElEKzdORnpnNFA0Q0FiK0xVWm93aWV6Ky95V1NpTjJ3?=
 =?utf-8?B?U2dLQXEyaVN6Slc5TklyTDRNN1ROS0Y0YjdDVzFDYVZDTUpBQlRiV29iL244?=
 =?utf-8?B?NC8xSzYvcTBkcWpyVXk3L3FvT2lLT2xSemNKMlFvUWcvYUZqL0JnZ3pEZXZ5?=
 =?utf-8?B?SVlVcmJDYnEvMkVHeS9TdTFnUGRVby9xZzRoSWtyTTA4VTA0YzNtK2dNYkxo?=
 =?utf-8?B?N2ZkeEVLMDNSLzJYMThmYjY4SG9HMFZFelgzNXVqaVFKTGZFazJxNkxIcXMz?=
 =?utf-8?B?NGtZSGJKcmtuOTFQOTRJS1poMnlNV2pIK1pZSHNRWnkwcWxDWVBRZTZuWktp?=
 =?utf-8?B?RytsL04yUkNOQndNQmV2MndOWktRaERhQ0FiQUhlUjRGY1Z2eVNxb1czRDc0?=
 =?utf-8?B?eTBhbTR3S1FPWHpmeVlrdXlDNyt4U3EwVzBqUzExU3NtU0VmZ1EyWDNoN2Fq?=
 =?utf-8?B?K1dDYzFrUU5HZ01jbFRySHBuTmZvTmJ3aWlTRFd6S0lFakZlbVZCK1lvdGln?=
 =?utf-8?B?K0dwdENVeE9zeG1uRFdXenhwUVJDdzJzRGpOZU1KV1hpS25WeWFhSkN3eExw?=
 =?utf-8?B?WFpRdTZ0Mm0zVytxdWlpeHV5Y0xVenZCTHRuM2x0aThrVTRFYXpWdjFlalhL?=
 =?utf-8?B?eTc0Z01tSHVTMWRnOVF1SDcxTUh3Z21vSjFoMW80UnBNaHRoc1ZCWUpHZG5U?=
 =?utf-8?B?eFVsa05GYm1IMmsxZWxTMU83bkVYQnZsSGtCUy8zNUNJdmtVVkNMUUQrTUxC?=
 =?utf-8?B?SlZpT0NRUWF5a1NYa2p1TFVxTTMyc1NpbUZwMlJQdlBhYk5DWiswL2tleWV4?=
 =?utf-8?B?R3ZtWHZ0YWJac1RUOE80TTlqcG53UVRJb2xncEhKVnFqd3lXdzg1REZleUFz?=
 =?utf-8?B?Nkp4WGY1OUNPV2QyT3MwZThEck5XbmRINm1GNTdnRFVlckpjaGhUWkY0RzJB?=
 =?utf-8?B?QlJ6MVdXMk84UlhYZ05tQS9KK3NsT3YvbktCM1JmUzVLQkw1c0JVY0dMajRz?=
 =?utf-8?B?ajU1aVFoYkx1cFAzc2lQeHVxYXVySC8vQjUrQjEvSEdEdjV0dWt4WjJDUTFj?=
 =?utf-8?Q?8vkrPQ?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(35042699022)(1800799024)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 14:28:50.1943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da57832-8e85-4d09-96b7-08dde25160e5
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574

Add descriptions for the SolidRun i.MX8M Plus System on Module based
HummingBoard product-line. They share a common designed based on the
"Pulse" version, defined by various assembly options.

The HummingBoard Pulse features:
- 2x RJ45 Ethernet
- 2x USB-3.0 Type A
- HDMI connector
- mini-HDMI connector
- microSD connector
- mini-PCI-E connector with SIM slot supporting USB-2.0/3.0 interfaces
- M.2 connector with SIM slot supporting USB-2.0/3.0 interfaces
- MIPI-CSI Camera Connector (not described without specific camera)
- 3.5mm Analog Stereo Out / Microphone In Headphone Jack
- RTC with backup battery

The variants Mate and Ripple are reduced versions of Pulse.

The HummingBoard Pro extends Pulse with PCI-E on M.2 connector.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   4 +
 .../dts/freescale/imx8mp-hummingboard-mate.dts     |  31 ++
 .../boot/dts/freescale/imx8mp-hummingboard-pro.dts |  76 ++++
 .../freescale/imx8mp-hummingboard-pulse-codec.dtsi |  59 ++++
 .../imx8mp-hummingboard-pulse-common.dtsi          | 384 +++++++++++++++++++++
 .../freescale/imx8mp-hummingboard-pulse-hdmi.dtsi  |  44 +++
 .../freescale/imx8mp-hummingboard-pulse-m2con.dtsi |  60 ++++
 .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |  81 +++++
 .../dts/freescale/imx8mp-hummingboard-pulse.dts    |  83 +++++
 .../dts/freescale/imx8mp-hummingboard-ripple.dts   |  31 ++
 10 files changed, 853 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a2c59c4308164e6be66402a8e2a181227ad6bd3f..6311b7bc5c3b9bf0f3dfaea169f0393245d5817d 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -203,6 +203,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-mate.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pro.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pulse.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-ripple.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-bl-osm-s.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts
new file mode 100644
index 0000000000000000000000000000000000000000..00614f5d58ea9de51aad9a5f36212dc3d4f3ecaf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Mate";
+	compatible = "solidrun,imx8mp-hummingboard-mate",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&mikro_rst_pins>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts
new file mode 100644
index 0000000000000000000000000000000000000000..36cd452f1583987a1e826d33798d9aecaaf21568
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-codec.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+#include "imx8mp-hummingboard-pulse-m2con.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Pro";
+	compatible = "solidrun,imx8mp-hummingboard-pro",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &fec;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&hdmi_pins>,
+		    <&m2_wwan_wake_pins>;
+};
+
+&pcie {
+	pinctrl-0 = <&m2_reset_pins>;
+	pinctrl-names = "default";
+	reset-gpio = <&gpio1 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie_phy {
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	status = "okay";
+};
+
+&phy0 {
+	leds {
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		/delete-node/ led@1;
+	};
+};
+
+&phy1 {
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..77402a3db9ef8747358e847daa9788f6c82c8df9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	sound-wm8904 {
+		compatible = "fsl,imx-audio-wm8904";
+		model = "audio-wm8904";
+		audio-cpu = <&sai3>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"AMIC", "MICBIAS",
+			"IN2R", "AMIC";
+	};
+};
+
+&i2c2 {
+	codec: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
+		clock-names = "mclk";
+		AVDD-supply = <&v_1_8>;
+		CPVDD-supply = <&v_1_8>;
+		DBVDD-supply = <&v_3_3>;
+		DCVDD-supply = <&v_1_8>;
+		MICVDD-supply = <&v_3_3>;
+	};
+};
+
+&iomuxc {
+	sai3_pins: pinctrl-sai3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
+			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
+		>;
+	};
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sai3_pins>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_IPG>, <&clk IMX8MP_CLK_DUMMY>,
+		 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>, <&clk IMX8MP_CLK_DUMMY>,
+		 <&clk IMX8MP_CLK_DUMMY>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..825ad6a2ba14ec5530b9c317cf3d749a8b5022ac
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		rtc0 = &carrier_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		led-0 {
+			label = "D30";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-1 {
+			label = "D31";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-2 {
+			label = "D32";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-3 {
+			label = "D33";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-4 {
+			label = "D34";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+	};
+
+	rfkill-mpcie-wifi {
+		/*
+		 * The mpcie connector only has USB,
+		 * therefore this rfkill is for cellular radios only.
+		 */
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mpcie_rfkill_pins>;
+		label = "mpcie radio";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	vmmc: regulator-mmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc_pins>;
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <250>;
+	};
+
+	vbus1: regulator-vbus-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus1";
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus1_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vbus2: regulator-vbus-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus2";
+		gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus2_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	v_1_2: regulator-1-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	vmpcie {
+		/* supplies mpcie and m2 connectors */
+		compatible = "regulator-fixed";
+		regulator-name = "vmpcie";
+		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmpcie_pins>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+/* mikrobus spi */
+&ecspi2 {
+	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_spi_pins>;
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-0 = <&mpcie_reset_pins>;
+	pinctrl-names = "default";
+
+	mpcie-reset-hog {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "mpcie-reset";
+	};
+};
+
+&i2c3 {
+	carrier_eeprom: eeprom@57{
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+
+	carrier_rtc: rtc@69 {
+		compatible = "abracon,ab1805";
+		reg = <0x69>;
+		abracon,tc-diode = "schottky";
+		abracon,tc-resistor = <3>;
+	};
+};
+
+&iomuxc {
+	csi_pins: pinctrl-csi-grp {
+		fsl,pins = <
+			/* Pin 24: STROBE */
+			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07		0x0
+		>;
+	};
+
+	led_pins: pinctrl-led-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22		0x0
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21		0x0
+			MX8MP_IOMUXC_SAI2_RXD0__GPIO4_IO23		0x0
+			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24		0x0
+			MX8MP_IOMUXC_UART4_RXD__GPIO5_IO28		0x0
+		>;
+	};
+
+	mikro_int_pins: pinctrl-mikro-int-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x0
+		>;
+	};
+
+	mikro_pwm_pins: pinctrl-mikro-pwm-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_MISO__GPIO5_IO08		0x0
+		>;
+	};
+
+	mikro_rst_pins: pinctrl-mikro-rst-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXD__GPIO4_IO30		0x0
+		>;
+	};
+
+	mikro_spi_pins: pinctrl-mikro-spi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SS0__ECSPI2_SS0		0x40000
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82
+		>;
+	};
+
+	mikro_uart_pins: pinctrl-mikro-uart-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
+			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
+		>;
+	};
+
+	mpcie_reset_pins: pinctrl-mpcie-reset-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01		0x0
+		>;
+	};
+
+	mpcie_rfkill_pins: pinctrl-pcie-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x20
+		>;
+	};
+
+	usb_hub_pins: pinctrl-usb-hub-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x0
+		>;
+	};
+
+	usdhc2_pins: pinctrl-usdhc2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_100mhz_pins: pinctrl-usdhc2-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_200mhz_pins: pinctrl-usdhc2-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	vbus1_pins: pinctrl-vbus-1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14		0x20
+		>;
+	};
+
+	vbus2_pins: pinctrl-vbus-2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x20
+		>;
+	};
+
+	vmmc_pins: pinctrl-vmmc-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x41
+		>;
+	};
+
+	vmpcie_pins: pinctrl-vmpcie-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x0
+		>;
+	};
+};
+
+&phy0 {
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		/* ADIN1300 LINK_ST pin */
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+/* mikrobus uart */
+&uart3 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
+	vbus-supply = <&vbus2>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	vbus-supply = <&vbus1>;
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_hub_pins>;
+
+	hub_2_0: hub@1 {
+		compatible = "usb4b4,6502", "usb4b4,6506";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&v_1_2>;
+		vdd2-supply = <&v_3_3>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb4b4,6500", "usb4b4,6504";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&v_1_2>;
+		vdd2-supply = <&v_3_3>;
+	};
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&usdhc2_pins>;
+	pinctrl-1 = <&usdhc2_100mhz_pins>;
+	pinctrl-2 = <&usdhc2_200mhz_pins>;
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+	cap-power-off-card;
+	full-pwr-cycle;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..d7a999c0d7e06a8c47a61632a59eb97faea9e3d4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		model = "audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+	};
+};
+
+&aud2htx {
+	status = "okay";
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&iomuxc {
+	hdmi_pins: pinctrl-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
+		>;
+	};
+};
+
+&lcdif3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..8d8d8d2e3da8ab486eb82ad72db7be875fed4929
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_gnss_rfkill_pins>;
+		label = "m.2 GNSS";
+		radio-type = "gps";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* M.2 is B-keyed, so w-disable is for WWAN */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_wwan_rfkill_pins>;
+		label = "m.2 WWAN";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&iomuxc {
+	m2_gnss_rfkill_pins: pinctrl-m2-gnss-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x20
+		>;
+	};
+
+	m2_reset_pins: pinctrl-m2-reset-grp {
+		fsl,pins = <
+			/*
+			 * 3.3V domain on SoC, set open-drain to ensure
+			 * 1.8V logic on connector
+			 */
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x20
+		>;
+	};
+
+	m2_wwan_rfkill_pins: pinctrl-m2-wwan-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x20
+		>;
+	};
+
+	m2_wwan_wake_pins: pinctrl-m2-wwan-wake-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x20
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..46916ddc053355b6708629898fa13e55c6493cc2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "c";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	hdmi@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3f>, <0x3c>, <0x38>;
+		reg-names = "main", "edid", "cec", "packet";
+		adi,dsi-lanes = <4>;
+		avdd-supply = <&v_1_8>;
+		dvdd-supply = <&v_1_8>;
+		pvdd-supply = <&v_1_8>;
+		a2vdd-supply = <&v_1_8>;
+		v3p3-supply = <&v_3_3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mini_hdmi_pins>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7535_from_dsim: endpoint {
+					remote-endpoint = <&dsim_to_adv7535>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&iomuxc {
+	mini_hdmi_pins: pinctrl-mini-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27		0x0
+		>;
+	};
+};
+
+&lcdif1 {
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,esc-clock-frequency = <10000000>;
+	status = "okay";
+
+	port@1 {
+		dsim_to_adv7535: endpoint {
+			remote-endpoint = <&adv7535_from_dsim>;
+			attach-bridge;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts
new file mode 100644
index 0000000000000000000000000000000000000000..d32844c3af05bdee2e56f60670244738063a4ff4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-codec.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+#include "imx8mp-hummingboard-pulse-m2con.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Pulse";
+	compatible = "solidrun,imx8mp-hummingboard-pulse",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &pcie_eth;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&gpio1 {
+	pinctrl-0 = <&mpcie_reset_pins>, <&m2_reset_pins>;
+	pinctrl-names = "default";
+
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-reset";
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&hdmi_pins>,
+		    <&m2_wwan_wake_pins>;
+
+	pcie_eth_pins: pinctrl-pcie-eth-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x0
+		>;
+	};
+};
+
+&pcie {
+	pinctrl-0 = <&pcie_eth_pins>;
+	pinctrl-names = "default";
+	reset-gpio = <&gpio4 28 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	root@0,0 {
+		compatible = "pci16c3,abcd";
+		reg = <0x00000000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		/* Intel i210 */
+		pcie_eth: ethernet@1,0 {
+			compatible = "pci8086,157b";
+			reg = <0x00010000 0 0 0 0>;
+		};
+	};
+};
+
+&pcie_phy {
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts
new file mode 100644
index 0000000000000000000000000000000000000000..4ce5b799b6abc514ca00e2e2134d5ff1606dc87d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Ripple";
+	compatible = "solidrun,imx8mp-hummingboard-ripple",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&mikro_rst_pins>;
+};

-- 
2.43.0


