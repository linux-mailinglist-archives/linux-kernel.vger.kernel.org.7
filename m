Return-Path: <linux-kernel+bounces-849142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19552BCF492
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D0B425895
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D92E26B08F;
	Sat, 11 Oct 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hbWoLLBr"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017D26A1BE;
	Sat, 11 Oct 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760182467; cv=fail; b=JcXUZLlkM8myGMDnVkIiW3gzxUOSdBlUQrrC5iaqM7B5rf8KGF3BVoYmh1qTbS2LeAt994zZpHpCj+EVcVs4h7aCUlqYEnknyc0nA7sHU7XYqFBErbvTdGaPcx6eH7rosW8smaRTcgSpYeAqjIhQv8H1iRSHWkn1fFftms5lpxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760182467; c=relaxed/simple;
	bh=Dz9+esv7AXc9KgbbfRIedVmgDeW4rHVX/9l9waCKBuE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RpyTiPdtvgT8izCVKjytMqQ2nYVckWkLUIrXR1If6uxVz6brgv5xp4TwvIzrdR2nXJxFGLBey9Zz+r3/i8g3IxzS1mAQfx9lhhembJCS0rd5ezqhpwKdEK3wdiKJ7pj0vBjP7VWwBmqtZx4/aiGh9FvCGmrAzQJJ4Wvb6TSs0Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hbWoLLBr; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gypnqHWzKAkEwUSUlzCAvcVCInDpPh4Pm25QiV9rVnWkFSsY70mZx5s08+2eEFBi4OvpJAPAqH12L+5lQb8K/ajugzZE/vZbwLbjxpROItrVO2HYBoA/KUbQ11ls1quvq2smjunxa7ouU4YNHDbki8OPtIAOi1MIk3pLe/Y4S04ojs61m6u8JBHjLaAhkDmD4zpCUeRa64NnNVzNd6h0rBdvI4d0HKUq8nQqyqYWIAhdk/NRHFmTwz9tZPel4GBpLjW4f2M4/L5cnV7tYfpUeQP2w115gfrogU47fWurfDZeTccbLhPRZGmii4cbyOhtuU4w2eXDLG7Lf/9GiZDing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nyjd9QgDv4Q9P0ZGFFQHggAyQ7r/yplnHq6HvKD1JQ=;
 b=Lhqdgr0QIrjHJJlZT4xG9AmV7wHFnN8uvCWKKQXtD8iDJiySZMgvywSdleNev0JyfhTPnbrHpWMT+VdRlMLaflmG2ZAhZzhOxcwVlEuhj+EqPO1KEgqIV/dbE9d9poG3/oQSjsUyMQufYxwjBnzK6vgnEdWO2xRdtTZ0hSpbgAV/FECh8cPnf2j7rq35+Bh+xQBsYHj8t+4JVaaYsoGdLUbRnqNo26anYBdaHb55WqDKvIJkFIaxdPopL0NAUg0doM3RqtG5jZKh8vesJKp6IEHsfWn5eN3EWoAX31ER2y3j7+RTh6rJcWb0K2ifNZNhvdsOHCN5dSTzhF0bbqTOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nyjd9QgDv4Q9P0ZGFFQHggAyQ7r/yplnHq6HvKD1JQ=;
 b=hbWoLLBrb98A671vT8NSpKi+myVNErqd76Zgj+O82a8wBFsFTgO94jc+Pyo4Kz0WRq1k1KWnI3nBCVViqpSK/L3RNVA8aKgQjNbWHFq0UIBZdiAnALOkSyLkbdJaNfrq8osWSH/kSLsuRNwgg8yj70Ci9KVl2fqhkbVImxySXm+ivATGrzcEz1cA/90fJoedMQiigZ8wyzVAdGPsYU4RTvdaSqDTzu6I1/4W0Qv881bQdZGyoAIqDAvsCL1TWOMaebeQQEPejfuG9yUoimyy7wkfUHn/IBPTGo5pBKYSdeNQ/1q2iMfN6jyx5l6rMrnzji6YAQ6UNyzg0ih6NZ82Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9181.eurprd04.prod.outlook.com (2603:10a6:150:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 11:34:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 11:34:11 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Sat, 11 Oct 2025 19:33:43 +0800
Subject: [PATCH v2 2/2] firmware: imx: sm-misc: Dump syslog info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-sm-syslog-v2-1-v2-2-f43a3f6b32e4@nxp.com>
References: <20251011-sm-syslog-v2-1-v2-0-f43a3f6b32e4@nxp.com>
In-Reply-To: <20251011-sm-syslog-v2-1-v2-0-f43a3f6b32e4@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Frank Li <frank.li@nxp.com>, 
 arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760182435; l=2423;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Dz9+esv7AXc9KgbbfRIedVmgDeW4rHVX/9l9waCKBuE=;
 b=ivPUBM/7L5KQkG6KTtjygbJpWK3vDpVjc4dSX1lhi6u1Ol7iDosH21/U1gbKm1eju9CqRk+p/
 Do3IuMHq0OgBNmiNlIcqDwMMC/tgpTP+0Zrj3mAJW7gwec4Xhy/TZir
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 100150ac-d065-48b4-6a82-08de08ba18f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cy8yTVlQNFdWZFk1SmdNa3MvQ01XbXlxeUNlQnE2OHBwbm1nVGFsbU03cXN5?=
 =?utf-8?B?Sy9OZjRvUnVrNjNEY2tYeERneTRMNVIzZVl5N3c3ek1EUDUrMkRSV0JwMDgz?=
 =?utf-8?B?OEVuVEJZcmx3TUc4NGNqdG5Ia3Z6M2F5Qy8zRTB6bVJ0ekFQc1NUWWlsRkJo?=
 =?utf-8?B?UXoxNUYrNnhBcEQ2azRWWVB0ZitETEkwMm1TT2prRUdHMUlPQWg2VC9FZ0U1?=
 =?utf-8?B?Z3oySWhsQWJJV1AwQUtPdTJ3ZHZwWm9aZ1kyaDlWeEpyWGRrUkx5ZXFKZFlr?=
 =?utf-8?B?ZXowUGpZNTRvdUNlbWlwTWZyYkIzbHhyZXhFdmRTcWRmRzJwdVE2QnUwdmxP?=
 =?utf-8?B?SVBVTnlDc2tBMVB0RjQ2SFd4aG5xcnY4V1hDeHZwc053MmlQUmJXdWQxRTQy?=
 =?utf-8?B?NytGbUl1b1dlWHhtQ0FZc0ppSHBHZUVIWUpyTVp4T1NPN1pyRUlvYm1CZ0pE?=
 =?utf-8?B?YVFseEk3SmpiakRHSm9yWks1QkxhRDVwR2RaZitkQUx0aE5SdmE1MTNJK2hO?=
 =?utf-8?B?MzRrNzZWMmdocFhtTmZDZ0FpdlVvVTNCVDJxaEhJc1RhRHgraE9qenFjQ1c1?=
 =?utf-8?B?MkkwZEFCQjN4aGZPTVFTVkJzSm05TGZ0SkhuclpFSzVEeEpWU3NsT2lMWXIv?=
 =?utf-8?B?cjl5QU9jVWg0b3d4REFXZTdFdWNjbDVtZ2dUYUNQSzUvTzNxWEVXZXQwTTJW?=
 =?utf-8?B?UTluRmZDUWhyU25ncU5zZGxOVXI0RVFrK1RLOFdPQnVvREszUG5kbVV2UWJP?=
 =?utf-8?B?ZWtpTGdEVHRVdGJoUmY3Y0FaN0xVQjdVbWE1VzRVZDZEdThhK3J1RUdSWmdR?=
 =?utf-8?B?Uk9RUXdVdWJUSkEwdkVLdVhhcEpNWkJEeUQyT0M1a0pmVmYybmRzRGU2N2dG?=
 =?utf-8?B?aEZSTzdXVG02Ym91YXhUVUhqd0pGWnB1ZzEzVnQzVW1jQ3ZqaXBRbDB1TWlF?=
 =?utf-8?B?dXBocWdQbEQ4RFo3VjRYcE1ZTDhESHpkdnVrc2IrTGxtYVVpSEJsUmxwcXJl?=
 =?utf-8?B?KysrbWhhSXFRR0UzRm5oNjNTTk50SmxoMGdmZS9xUVlPbGExVlJ6aDZiZlZq?=
 =?utf-8?B?RXF3YUFJekN4OHZwZHVYTXMyV3NsN3NsajhsRG1renVJOUtZZlc3L1JoRWFO?=
 =?utf-8?B?Qm9OZnlUVkRlMFZQNlVDRUNDdysrUTRIenZPUVBNR20xMVA1eVpEYWhnTU0v?=
 =?utf-8?B?WE5pMFhGVUoreC84a0dSbkhmSVNBN1ppS3QyNWduei8rNHhBR1VEV2RMTmow?=
 =?utf-8?B?UW1ZckFOL3ZXdSszQkdjYTFJK1pFekpIYVBRMk8zSVIwM1MwWGxxYlBsUGJp?=
 =?utf-8?B?by9EUjV3TVBDWHJmZWxKeDdEQzZqVmNBcWl6UXJYYjkxTkgvT0JaV0l1L1VN?=
 =?utf-8?B?L2QrSzh2S3dQSVlkQ1ZkcVpxUHJzQmJyeGpEVVc5cit0WXZ4SjFtTU5NWTlp?=
 =?utf-8?B?aDdtTVk3c3haRU1XUE9kWUJjRnBka3h4NVNjK3NveU5MYmEwczY2REV4SDZG?=
 =?utf-8?B?Y2pXamk4R2tWZDluQWxQMjY5MTBCOUtXUXhvYmJoQUJzdGk4RDhKb2orYjZl?=
 =?utf-8?B?MUlFcERvNGhuUkI4ZTRud2JsbWV0QllLU3laTVk1cjVycldLbm5abUJLWXFW?=
 =?utf-8?B?U0VzdHdMQWRyUmljN2lReEVXOTRkbEVXZ0JJUGpCbnQ2SW01czIvaXBnTzRn?=
 =?utf-8?B?ZUVTZ2F2bU1aQUtobDZmRzdHZEJUalFyUWNNNDMzVGVJOThUU1VpT3FjS1I1?=
 =?utf-8?B?SS85T3JKTGlKdGJ0b25xSHpnNHRSOUYrTkc5SXpydGhXRHM2YkJFOUVPcldQ?=
 =?utf-8?B?NDVXckliR21KWkttZElFWWJUV3NmTEpMMTR3RjFXNkMzWTBhVEI1Zk5UVWlZ?=
 =?utf-8?B?a0RqbzNNTnFCcldnTGhMOHYzaXR4YnQyZUZ1TXpsL1JFQUJ2ajA3YXNuejN2?=
 =?utf-8?B?TXdsOEFRVW1xYjBZTEtPcWhOTVNQa0Frd2M5YkJxUjRjL1Z4VG9meXZyK0pD?=
 =?utf-8?B?WmcrM3V5aXRQTU9Gb2N5Z2NOOTM2SnAvTHd1dGxsb1l5VGsvVUtzN21JWVIr?=
 =?utf-8?Q?RRUOxj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0NhalZ3Y2dBdWtITmZncUt5STNpMmFwZERocHF0ZzJCTEVOYWRtVkYyZVZH?=
 =?utf-8?B?WkxaMG1XQkQ2MDlrQUgzT3BUb1l3WXRwT1JJUTQzZmVvNlVzYnhsaFFmd2x4?=
 =?utf-8?B?WVdWSUQ1TkFXeElPKzNvajlDcVRnQ0Uwb3RpV0lCZ2V2TWFNZ1lVUExlNFhG?=
 =?utf-8?B?K255cTRkSmRPT1RiZkg2YjkvZkFjeFg4dW5mUGZxcFcrcWhSSzFCQy82U0di?=
 =?utf-8?B?WjBhNWVQVjZ5NFlvZC81eUhsT2hHQ0tUWTVQRXo2R3JFNi9UaXR1ckhYa2pM?=
 =?utf-8?B?aHBnS0FxRWp5UHRaMk04ZzJuNm1NcHBkcXlHWjJjU3RKQzZBNHpvbTZlWlpO?=
 =?utf-8?B?QjllTjk5bTFudkErTGMyUWNXdFkxQlMxdjBHRUE1Ym9FVXg1VTQ3NUFiY2Mv?=
 =?utf-8?B?SkZPbGR5NFNHKzZtc1hOUnJ4R3dVNnk1U3ZVTm5JeWJySnlRUmZ1elVNQWhJ?=
 =?utf-8?B?YmlCWWtGS2EwVzc2RmVOZjRCWWZzS3A3bjdHR29FL0p1OFowck5WZXI1dnFa?=
 =?utf-8?B?MzJiTnFIK2VLQjZZeFJXZXErNW9WbmtSZU9pRld5dm45cGNNSForaStIb0ow?=
 =?utf-8?B?bUZJMFBhTFg2YysrRjIrR042WWZ6L2lPS2UvVWVoOUVYZVdXQjNsNzd2TDh3?=
 =?utf-8?B?K3dzdjhDbEFtRDJTVmdHZWJKNzZ6NXVaR3ZhUnpNbnJZWWl3SjJLcGVYUGhD?=
 =?utf-8?B?YktBZ1AxSWZ1RVpxRENxRCtDQXdmM3Z4RTRPYXA3a3FwcitCOWNLaGpOSFA3?=
 =?utf-8?B?SnBqZEY1cDlVbFY1V0YyK09yczlYT0tYRnlnd2RJc050bTh3WU5WSDF1anlJ?=
 =?utf-8?B?WjlmSlZZVjdvbGZHeXhoOVV5OG5FVWJ2VGc0RDJFbytER0NhYjJZWFJuSktM?=
 =?utf-8?B?a0ZaK3Y1cFhNcTFhMDFySkdmREdkcXZJUWpzWGpqczcvREhQK3VxeE9Gd0lM?=
 =?utf-8?B?b1NUcllROUV0VWF1OHZpUFIwWTJaS0NZeFVuYk1uVklzNG9zcFp2OWVjM3RM?=
 =?utf-8?B?OXM2bURmVXdBdDV3L25PSEFVWjBxUWFLWWQ4RkVkM2l2cGRXSXM4NDBuNSs4?=
 =?utf-8?B?SExudUZLRFpRTlpyc0ZCbzJESFVJZnhtVXR4QjE1MFRCbmJpS3F1aVJTSkI5?=
 =?utf-8?B?amZHd3NKQWN4UnB2UExFRUt6bi9EUHYwYkN3bDFtUkFVT2xkWkxHanh0ZW81?=
 =?utf-8?B?SW5maGpoRkFRVkRoWEI0VitZR05DRG9MOGNEKzJZK1QrK29yVGNiTmUrVVBY?=
 =?utf-8?B?SW5XU3FQbXZSYU9CcjJZa1ZZS0FCczNnU2xlVU5YRVlPc1hzYVpuWmRTaFNQ?=
 =?utf-8?B?bi96NERNOHJhYkZ6NjBVRFk4WURuRG96RnVpTG9YSVQwODFPQURCcnd4bVFt?=
 =?utf-8?B?a2Qwd082N0RUMUY3b0V5TDNlSXMrSmJEWU5kMXBrQWhFRnJnTmtBSXpXS0s3?=
 =?utf-8?B?OHBJdytocmJGR2lmVWJNQlhKaHIzS2FQelkzV3RmZGR3QVRGZ1RQbHVxK1Vw?=
 =?utf-8?B?eFNOM09HaFRXUVcrOEpzNWhORVpWbEd3SDNUaDlyOVJ1eEtLdzQ3NlNsMGIr?=
 =?utf-8?B?eUVhb1p1NllTR0J6Y2JWV2FGNnJUTFB5ZXJwUmRCOS9naFJOUng2V0Z4Q1pJ?=
 =?utf-8?B?SmliQVREK0xjZCtXUkprQWtHZGJYUHFISE5nemZrbHFGWmcwZCtaRGZ0WHVp?=
 =?utf-8?B?WVdMdW5idDd5V2ZCZThJS0x6ZDBFbHBoT1ViaEo5bzRhL3FQZ21XSDF6NVpK?=
 =?utf-8?B?NElscHhRaGs0SDdyUVRUL1NOcWtXYnlxMmt0bDdnVEYvTXY0Sk5yL0FvOGpU?=
 =?utf-8?B?V05OMlM0QmkzblQ1bGtTczQ4ZnZCZ2dUcU9xK2Y1MWVQcTg0MTRqL1RqYzZx?=
 =?utf-8?B?N3FtazN3N0V6SWtsVzlNTXFFTXdFODFwTkRMYUFpL24xZ1RlTXVJQUkvZVBW?=
 =?utf-8?B?UkN1UG1hTjh4YkhvcVVyOFluQkNkUWtETSswMklWaDZYcTFSUGd4aDBjV211?=
 =?utf-8?B?dTFTVnM3S2cwQllVSXVSRXI5Yy9MQmJjcGpSOVFZQk9QVWpmNnlRUkJ1MjFv?=
 =?utf-8?B?clhWaUpOM2FKMTlJUllTTFcvOElBYlBSRGtBaVdiUWkzaWdLNEhxaTNpc3hy?=
 =?utf-8?Q?0FI7T12f8CfZCQK+5zP5HfYHa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100150ac-d065-48b4-6a82-08de08ba18f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 11:34:11.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otMRimyP5CvuL0AhkUjkDDWsCmv60RmexOIkKiKF3lTmUURp0FSreiXtDiPbGM+l5Vty4J3ZwBnUbKMtUzU5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9181

Add debugfs interface to read System Manager syslog info

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/sm-misc.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
index fc3ee12c2be878e0285183e3381c9514a63d5142..d99b9420277ed11b297234acb62a6e695576c844 100644
--- a/drivers/firmware/imx/sm-misc.c
+++ b/drivers/firmware/imx/sm-misc.c
@@ -3,12 +3,16 @@
  * Copyright 2024 NXP
  */
 
+#include <linux/debugfs.h>
+#include <linux/device/devres.h>
 #include <linux/firmware/imx/sm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/scmi_protocol.h>
 #include <linux/scmi_imx_protocol.h>
+#include <linux/seq_file.h>
+#include <linux/sizes.h>
 
 static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
 static struct scmi_protocol_handle *ph;
@@ -44,10 +48,39 @@ static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+static int syslog_show(struct seq_file *file, void *priv)
+{
+	/* 4KB is large enough for syslog */
+	void *syslog __free(kfree) = kmalloc(SZ_4K, GFP_KERNEL);
+	struct device *dev = file->private;
+	/* syslog API use num words, not num bytes */
+	u16 size = SZ_4K / 4;
+	int ret;
+
+	if (!ph)
+		return -ENODEV;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	seq_hex_dump(file, " ", DUMP_PREFIX_NONE, 16, sizeof(u32), syslog, size * 4, false);
+	seq_putc(file, '\n');
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(syslog);
+
+static void scmi_imx_misc_put(void *p)
+{
+	debugfs_remove((struct dentry *)p);
+}
+
 static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 {
 	const struct scmi_handle *handle = sdev->handle;
 	struct device_node *np = sdev->dev.of_node;
+	struct dentry *scmi_imx_dentry;
 	u32 src_id, flags;
 	int ret, i, num;
 
@@ -98,7 +131,10 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 		}
 	}
 
-	return 0;
+	scmi_imx_dentry = debugfs_create_dir("scmi_imx", NULL);
+	debugfs_create_file("syslog", 0444, scmi_imx_dentry, &sdev->dev, &syslog_fops);
+
+	return devm_add_action_or_reset(&sdev->dev, scmi_imx_misc_put, scmi_imx_dentry);
 }
 
 static const struct scmi_device_id scmi_id_table[] = {

-- 
2.37.1


