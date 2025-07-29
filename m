Return-Path: <linux-kernel+bounces-749378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB1AB14D91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB3C545389
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84D290D87;
	Tue, 29 Jul 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IwKwoXWM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IwKwoXWM"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD448287507;
	Tue, 29 Jul 2025 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791747; cv=fail; b=MuTrdBSTvUQJmDvV1Vb/jMwNpua42+kqaR5zmtOu/7VjEnT7xj2xKa55z0VzS0TVrSnlnRGMWTmM3CJTb63ZYVBV37hxATSo4buVJBWc2NLsi6CYqifVvOnt9bzaPIEmoc4Ip9KCM+/3dAkFk1ddkzWEzAWj+MXDYRJl9EniBRo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791747; c=relaxed/simple;
	bh=LhhSrl3A5XxWR9Z4iX0wZ2O77YceZdjfaboLssUPs9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=keRPCLeaRr6/bNtfid1DAIbJcIMVKOYuwNxbDynePAsPSJGbHVsZss0cjPWYqy1nG6VzkD0UFhjBSOy+6RRoz2msvKbhv7Y57Ls3Lh/qS9FZDlqpVYnuXp05sQH03C6BGE+J2QVUDIHfVgph8chLirT/l48z3/s0NfHPiXhU8GY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IwKwoXWM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IwKwoXWM; arc=fail smtp.client-ip=40.107.130.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pch1e7L2o/JBG4wilt21JEX/nt0X3+DEYOrYPWKU1loHYLrpOgaZ3TutwJwa4A9uGgZrEPaBXQKj1ZD/Bb24+WJn2QJBR+tlhjuufo9DIwCx/zRW1aJsUkTiUL3jXQ9luRLTcPAhnX96gMP7VRAYb1KELv7pzNX8Bj0A4xqMoRPTH7x3+EWhLHQb21+7s4V2gDblK73HjsE9LKrMvVO3ZZceatXzepjQaVuTaZDVunvzxqLQ4RH/3m3gsocXshU06WT5MDwFK40TYtQJrRk2FyGkKgY2MPxZ/WvfLTJ6A/rs8zl1lEyi3pROf1jcueH94/+uhQWYoFn32zoKNH3c0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJYqxonHzGpqF6hyBPbKAKrK5JOJvz1U65cb0jOkzjU=;
 b=Hcalo/UXWfzN8kMiIahZ38j7Zr3hkHKHwAqTohGwufGD87VQRrgnmCgq0yKL3Y4Om7z5VADOWprQlPzkmCl9l7UkBf2c270V/m8DzS/CydDqTBcBm61JhqTPEBSVqXDjnzlKSF8O0B4DSR31SNSMlPMAYUkDqnDtntcG8DRx3/X7B2bvoTAknXazclgtIllMBu+rtO0UJ93hfCKfN9HRBlStwV29pcOl5LMZIqJWDuTAtC7Vrj2gTrp1K5ximJSTAjV/Dh7rm1duc/38eEw5FFTWJyGWXoYR34wne/qJw2pbSEcPGu9+jMA0RERHdpG7hyNYKCUXEP9obvBU/KiB5Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJYqxonHzGpqF6hyBPbKAKrK5JOJvz1U65cb0jOkzjU=;
 b=IwKwoXWMB2twKCrOCfeyia6+ezgmEKGhGzSs1L5ONjbINGjKGQikab6rUEvfueMlae5u/dLxu42ZFXm6QsupMctWo9xs6rjOWnbkk1Q8g59LTklLce/JTOQ3DcpEDRxC22KS9DDYlNdii+7QCYyiHHK0DAZZN78kgojS7Zu6m+g=
Received: from AS4P190CA0043.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::14)
 by PAVPR08MB9650.eurprd08.prod.outlook.com (2603:10a6:102:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 12:22:20 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::85) by AS4P190CA0043.outlook.office365.com
 (2603:10a6:20b:5d1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 12:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Tue, 29 Jul 2025 12:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njPdUpyoH3V/bJZjoZWfgaz9i4yrDwIFx3xapfNZjJje9LfAb13k8lXQIgmDVeW1JOKGaGHvnnEmycRjHxSGhyo5W+6bNohgQPo/g/utG7EfHVloKfdrywJcXxfgB+xokENMJhYAoRLAvVTpCH+pCnFHK6wRw37ZOGznYZG01Y3uQcLkauNZ9GvI46UGTQn+9p/BcT6aGF0ciHgzg4zi5kYSdv59qJ5bsMvbrUJbBPlCjGRjpB8U3RM7Mkcmg0Cb2IEGD5q7z4viwaqhD83TqUevnrwiRRjJj9hDf7I0yvD+0UKDt53TAhMxubgHHx1S6Swd/C+QGcCC0GZjFIp1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJYqxonHzGpqF6hyBPbKAKrK5JOJvz1U65cb0jOkzjU=;
 b=wvfzMdvauhY1+6DXzURGHdTms2pfDRrnWw29bBIGSNk9fsWeO2tod3wyJK356MNcj+uk1sUj06BpBhSG5C4ZW4z/RUyN/izknYtFqgsZC/zd/NPc0sbZHvy+aw66H9gHhwsLWzERN5ZBqiaEyS8vIMykT3eI1tJxKn8YyuN+L7pZcMGSSt60+EmvBciy4LuOKKjfv6snx44mBtxtz5hhUXepfcJshpxUO8dEJkrbQ3pdENm3eln2EVsEQJvyV19UirAOoEVsWEJgEwk8jLunK/GbmvTyMicXHAOTjrDjWorL+fSiWh12b4811dJCQeDIuKebKXdNVTycSXprZanhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJYqxonHzGpqF6hyBPbKAKrK5JOJvz1U65cb0jOkzjU=;
 b=IwKwoXWMB2twKCrOCfeyia6+ezgmEKGhGzSs1L5ONjbINGjKGQikab6rUEvfueMlae5u/dLxu42ZFXm6QsupMctWo9xs6rjOWnbkk1Q8g59LTklLce/JTOQ3DcpEDRxC22KS9DDYlNdii+7QCYyiHHK0DAZZN78kgojS7Zu6m+g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV2PR08MB7956.eurprd08.prod.outlook.com (2603:10a6:150:a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 12:21:44 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 12:21:44 +0000
Message-ID: <475bfa31-43de-4f36-8960-924971981b61@arm.com>
Date: Tue, 29 Jul 2025 17:51:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: mach-sa1100: Remove space before newline
To: Colin Ian King <colin.i.king@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729111842.1923915-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250729111842.1923915-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::18) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV2PR08MB7956:EE_|AM2PEPF0001C710:EE_|PAVPR08MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: 18319fce-9150-4f9f-1d66-08ddce9a9075
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cWV6citZbERQNHZPSGp3TGhnazNyYVFWdms1djNhbWQ2MlM4SllWekJxaS9l?=
 =?utf-8?B?VDRtU3lNVXkzc0RGS2gvQk92bzZPeFlydkF6WG1OUFhpcWNJQ3hEVWV0Y2d6?=
 =?utf-8?B?VmIwOHJsQUNyVDlESjFDY1MyR0JtZTNNNDdnQU92TnMvM3NCczE3MHJkTW9m?=
 =?utf-8?B?M3BHR0c1NmI1dWtMdExSMS95WDRDNzJqMGh2bTVrTThoTUR0NTlhcHQraGwz?=
 =?utf-8?B?N0FMNlpUR1lwL1htNVRhV291cnlpcCsvLzVqNjAxQllxdW1mWVRLekUzM3hx?=
 =?utf-8?B?Q3RyNVU5S1FsUDBTYVpZeUwzTmlPTzFxelNJT0tDSHloRkxvNnVwUUNVaDZh?=
 =?utf-8?B?NUJnVW84c0tuRjNZaXBSd0NYSmdQSlhNdkF0YU44cjA5djlKTVJqVzIzTjdl?=
 =?utf-8?B?cWZ6RjkxRWt4bFJGSVBmb3dqZW5SZ0lvaGh2N0Nubnc5Q25mSXRzOW8vL1lN?=
 =?utf-8?B?VHQxaFlXVWxvTlljZlduTXNtc0swTkFyKyttSW5pTHBLMWpBTG1RaWUwQ2Ju?=
 =?utf-8?B?d0RMUzJ0MXJDMnFOakpwdUk1ZVBSbkRrdFAvSnJpby96Y0RFdDZNanFuamtk?=
 =?utf-8?B?T2dKYkFRVjZYL0padDNZVTdaUkRNUkRJUmp3NVBNbE1rbHUyS3dRemtPVWdj?=
 =?utf-8?B?SzR0YjdsTjhMcUZLMUFmMTN2ejVMRHVPaGh5MTBFZFdSNnAycjdzK0gwS2V4?=
 =?utf-8?B?KzlIK1hYM0gwYVpRd1dDT05acVFyazc3cDBnd3ZkQVcyRGdsZ2NmaE1yY1dN?=
 =?utf-8?B?Q2p1aENQNG84TDZ0MWgrTzA3NGxPdG05c1NaQlBCUDZQZW9vWEpyWG84YjNO?=
 =?utf-8?B?YjZmR3FXSW5DWnlHanpmMFY0akloeXErU0prN3B4VG9GT2l4ZksxYmNxTUU3?=
 =?utf-8?B?REg1V05NL0ZsQU1UQ3g4NjRRaHRVSkJjaWlodTA5VWxqdnJBUW96cEpOY3Jo?=
 =?utf-8?B?Q2E4K0ZPYjlVZ3I1RTdVb3dZcitWUmJlTTk0WXNyTWZEczRxZkdUVWYyNEFX?=
 =?utf-8?B?L0FIMC9waStFMTRFM2x5K3V1bVRVdVl5a00wS1ZZQU12Zk8ySm9LUyt5MWpu?=
 =?utf-8?B?cjV5Qk9TQk5VNGVkTysxRTJpQThpTllZVVYrTFM4OWRzRWhDdi9TcWFyS0Zz?=
 =?utf-8?B?VG0wNVQ5UTVzM3hTYnFwQVIwazNLbzlFRWZGY3BQL1ljMnFHMXZrekIwZ3J5?=
 =?utf-8?B?TGJxcE9ja3lMNUNBRmZvbWo4UWdVeVVkbkNHcTFjOUsrWEJqSmlaUy8yNlUx?=
 =?utf-8?B?bkZ2MUc2blVjZC9EejhwOHV2U1BmZ2RobVBlNk8xY3JRNytMSUtURW9wMEha?=
 =?utf-8?B?NHNiaXNYM2llRTJkM0RVUXlPZlZIQ1hBSld5a1RnSFRldmhoNFJXY1pkQkJQ?=
 =?utf-8?B?cnF6aWJIWXdmeHlkOXJYNzRrbVRmblA2amdhSVRxMWcvUzZHbHk4a3Jyc1FU?=
 =?utf-8?B?dVppNU1aTHdVV3psU3dzdEhVWTEyV2FmVVY3OTZueWtQRCtiQjExSHdzMjg1?=
 =?utf-8?B?UC91bFpHRWFINnQ5ZHFDNVArT3JkSlN2RkJrb21CVDQxci9ydUVqQ0w4NDJz?=
 =?utf-8?B?YTNmSWtGTFExVFpMYnZVSHhqaEs0QVlabEVRY3N5TjYwSE1mZXNtRm1YYlE3?=
 =?utf-8?B?clJBY3JNbnYzc0RmR2dUUE5VckUwd2NwVHUwZzN2R3lJZmJHZnJGaWNxL053?=
 =?utf-8?B?b2hqaHRuVmdFcnJwMUxFdXU5UUhEbmQyRmxWNzJVRnBTc1pJQnFjY2I4YWgr?=
 =?utf-8?B?aFRvYzY4WkNsencwdUlWS1hyUmFKbHBPSnM3eG9Hc3pqbC8vcGZ3bFlQVE0w?=
 =?utf-8?B?UDAzcVZ1WlVGWkViY1IreFM3Q1VXRzI3MkcyNlEyZGliUGV1eHhGVUwvZUlR?=
 =?utf-8?B?c3pOYlJYeVVGd201eUFTaGl3elNMeURvRUNRdWVvaGxCdFpaclY3dDBRMFc5?=
 =?utf-8?Q?ACqzJW0PQxY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7956
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79f421a2-9afd-46f6-1687-08ddce9a7b48
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|14060799003|36860700013|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUJKUGZvanFsZ3BZcllFUmM1ODJkekorOHV4czRmNkQxUlBKNkpCK24vUHBD?=
 =?utf-8?B?K0l0ejM2bEl6cXhJcmpBUk1EdU04U0lFaGVTVEgwTUJYOG5QVXRZR29zdGFB?=
 =?utf-8?B?NGQ5QlJ0TFJVamsyREJEc2tUd0JJakdrUDROb2lJMW53Mm9VQmZZQmdYb1Vm?=
 =?utf-8?B?M1MxSG96WjNnTEYvVzI1UmFlMy9DZWhXTTd5elVvVlNCOG9UcjJRenlKWThB?=
 =?utf-8?B?Y3NXeWhkU1FFbkhaUmZicm9WUHBNMHJKamFMQm9qemxjb1JrcWlYR29FdGgy?=
 =?utf-8?B?amVVUHRwdGQwUnlOdlVPOXN4YXljUjFjSHVSd0kwQU51ZGY2R0xWZ0RZOFBh?=
 =?utf-8?B?dW9jUjBEVFJnRERNT1ZSdHJ4eVVhK2QzSkFLanhEQ0k3WGNBTjlmNVBnbFA2?=
 =?utf-8?B?bHVoNGk2R3pZWUhyM2dNZGRvNTFjODFiL09RK2hON3VEaGhvTm5TaHlCcE4v?=
 =?utf-8?B?SDZDbEV5dEhlT05pa2IyZzFwT2pqWWdDbDFyVEozMHBSSGkwVS93TlV4aDR4?=
 =?utf-8?B?VUIwL0VJWnVUU3Y2UDNqOTlkdHlmNDBnVFdlSVoyTER2RHZTa1FjWEM5S2Y5?=
 =?utf-8?B?bWNPd0NXZ1JSMGw5ZjJDc0U3MG0vZ3kzQlhrQ3A3ZXZCRVFTZEVQcW5mWUhD?=
 =?utf-8?B?SExSMW1lWXc4UmgwWlprWXZ1eUsrQ1Q2Z1pXcUVReFdaU3FmWVNRWlNiTUE5?=
 =?utf-8?B?SE15dEVkRWRIU0pvZHowc21tMFpPZUg4TndBUTVPNURBU3VHNUovdlM4ajdo?=
 =?utf-8?B?c29xWWlIQzl0S3BSdi9TU3AyYXlIVmlyY20ram9EaEU1b0ptbnpXMmh6TjBP?=
 =?utf-8?B?M2hlbkR3MmdkMzk1OXYvTHlYQVNKZUhWa2tVaHBIOXZNcSt3RnZZc25taXRG?=
 =?utf-8?B?SDFsU0pGOEt5ak1TbHBQS3JLYnBZeFRURG96OXRQVVplYWkyZk1ibnFBa3BX?=
 =?utf-8?B?MnVYQ0FhbnZJTUN1WlNTOFUvL01EYmpFUVQrOGYxejl2a2N0TXFTTS9iYk00?=
 =?utf-8?B?RXZndHVNeVAxb2pxMUJwdUZ1K2s2VjNqNlEvYVdvbUplTnVxZVhNSGxzeng2?=
 =?utf-8?B?QUQzZXpBeFh6U2tPRlplOTM3RXllZnZBZWhnRGtMVFB6U3lleWsrQ0hnQ01r?=
 =?utf-8?B?T0I5cFZaUkNRNHArbS83QUVBRTNjUEFtRnVDbTA0SG1YaFhteEEwdU42SDBJ?=
 =?utf-8?B?aWU0UURGU2dnaXJndy9zWU84cnlRS2EvYjdtU1dmR3hIRWV2V3o3SWdURG1p?=
 =?utf-8?B?MVJqcTd2T2xDZTkycWIrV0NlOXN2bnlWeFdNM0ZoVHk4dWN3cjVzbFhsQ3pl?=
 =?utf-8?B?d1g4UC9ld2RLaUIzRTh6THJSbGZFR2E4QlhCTGRwbjIxUGxlNFI0Z2FrNXFz?=
 =?utf-8?B?cVNJZFBHSUhVemZiYTVHYzRmSTNIWGlzeUd1bCsxZUFoVlJVU1pNL3gzSXZB?=
 =?utf-8?B?eHU2ZlRwMm41Ynp5Z2lkaXFZSS9xcXdBaG5kQ2tzRnRTaXd3YXlrb1FFVXcv?=
 =?utf-8?B?THdrZ1RJTlBQYVk4ajhnVlVobGhLdDhNTGFhTm5LYVVvUUYzZ1NWZ1pLL0xp?=
 =?utf-8?B?TjllSnZ5cVZkR21YOHF0azlEV3Nzc05BQjErNW52ZXl5M3VQSExDWEV1SlJH?=
 =?utf-8?B?dEE1clNxSWpKbk8vN0oxUE5GN2FyTysxZ3l0SnY5QTN3VDFvV0MwSDhJV2pP?=
 =?utf-8?B?STlDa1FQU0hHYkxUR3pUZTlmcGh3U3k0dFIvYTRpTFdtMmh5UkpKcTVQQVlM?=
 =?utf-8?B?VTlOeUhIRXE1eURZdThqQVVwRUoyZkRoMnhZUGFKYWZzeTJXMEtJZzVSa0ti?=
 =?utf-8?B?N09KSnVYb0ZRejErTjgzY2NybkpzOUlta3BQU1d0ZVBOYld3REFMY0VrWkpT?=
 =?utf-8?B?RTJqb1pRTXgwNXNubTRjS0lpeVdoNVd5Smh6THg5VXh5ZHoveVh4TzgvMndS?=
 =?utf-8?B?Y0tVTzg1OFRYdG1pTzlsM0dLQ2puazF2SXRLMzFNUUVOd0lkYVlzK3o5di9H?=
 =?utf-8?B?SEhMeUdwaGVPQXVIbW45bmhNNExDdmJYSzlKNUM3YTlIYU44eFBnU2trR29J?=
 =?utf-8?Q?0HaGDm?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(14060799003)(36860700013)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:22:19.9456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18319fce-9150-4f9f-1d66-08ddce9a9075
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9650


On 29/07/25 4:48 pm, Colin Ian King wrote:
> There is an extraneous space before a newline in a warning message.
> Remove it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


