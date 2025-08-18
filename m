Return-Path: <linux-kernel+bounces-772694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19583B29639
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F86204CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E514245005;
	Mon, 18 Aug 2025 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="judboBuD"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C6244186;
	Mon, 18 Aug 2025 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480394; cv=fail; b=qRNnrYlA2fq4hyBe/+6/ncKIZD35mvCp3iQMKEecMugqk2NP2BfEJfTe39xeLpFmxDKzrVDshMv7ZTeK2UljmXRoDg+Qm1e4fFTTxJpfWSYtPIIig0+j5NI/G08RHejnebCSLcdo4sEQqNQvAhzXQaZ+CFlSWbe0Mfk1e+g8T4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480394; c=relaxed/simple;
	bh=xlAxbfmBehuxdPPQTYQiTtOjB9HqmbNk2mIFswG44nQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j/AIhj9ryHAntJEDdP8Fc3+kdJIuacSqfaALhwnMgqUINhDg8fH7rOz8D6t0AZ/pyzEq7UJw0zICwuh8Ynk20/NS/s3C0cSK+EFib934wnx9D+u+goeDhIpjBV/9zPREJFBWLszazyX2DKx8NqaPcEvIaMat9IdcGYWc5A6C+uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=judboBuD; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhE9B6vqA0nFyURNhH3LJ3P1y3xYjTt40uS5U4NLCZVT4BQp0Lfb66w+0fKKoCnYkNJqnnoE6eXSH4sT00Crre0BSwjH6nxGfzVuRp3Tt94HxJwnN068ze+eFMmmSZD3Auy8dx3AMrexwhKw2D1MiDox2HTKFrjuyn+COpvrIs5UUihrcS6pWfUrAUmI3YBt6iGTbOF7AHYXhtFPqcpDm7A8ydNbKEmA5kFxgtAOzEh7SYvC630wmXejlk9vPU1FIqMrc3c53W3PxyjBrgGnxglhma0bFniKLTZ7RN1qYIuHhZZ7WBEznVmBZsK+GAMYPvOZc14Y6e0RY65ikpGmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQrq6KWZXHW9k0Q++Ng0oSSAFUkmWUGUVO9xCzqVEWo=;
 b=oYfBDrJSesJkHZlOILS7gFkthmkL5cZuVedFDBnWK+ETfQGb7nImTRQ/6SKYRTJAZLaFeila+e1g57vXCLzMtLwwEA7ZW2WIpgtf1KmrZOK1a0UdeB9c8BQZ/+xWyowZ8uqn3eyqXowHOqc5RrpJRuoksC2FUSdwV7GzKp84X+wr7O6cKT0QJCHDJGdsUGyWjL4MwwBS53WJv9UFnahPW4om3VcrGlB3X/ojdsJCHMfp6VUAtAJ6kFE35l8E08JDBDZEuvkkaIBJ894KynAJPiH2jxhRkmrw+1EqUHCaX+3xb7fx+uFFa8LXac2mIGo5VF6S9iQbjpgV1edc3Kr7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQrq6KWZXHW9k0Q++Ng0oSSAFUkmWUGUVO9xCzqVEWo=;
 b=judboBuD1rGtBUazq4leX7wB0Ucdeov5bl+7+r+uBReNJ3/fpLRRp6gv3AaWH900idtHCs/4CTqocihYQORCKLA1P8tNC9kEREmyVXo6oQFsqDOXetNtFZ24YkCkxSGTT5iRwnGYUl2qFWYVmmvvLdTjh4UFfC/Hag9RqGs1PKdwXn8QFBYMi+ju3BZaQPoWlSuP3Xud4pbF9D6q14lpaYi8P4IyuYI5KpET4AQFmCbCTRlJ81/GSR145BssHXlLcz2VrHHx2m1Zd3lSvUE1BS75vAevpLFYGMFnYYpUUVCSfKFp7Z2AvwR8cMjYOXl/gUO+GOe4yty0iGsL/uGyMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11530.eurprd04.prod.outlook.com (2603:10a6:102:4e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Mon, 18 Aug
 2025 01:26:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:26:30 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:40 +0800
Subject: [PATCH v2 10/11] arm64: dts: imx95-19x19-evk: Add pf09 and pf53
 thermal zones
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-10-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480344; l=2381;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xlAxbfmBehuxdPPQTYQiTtOjB9HqmbNk2mIFswG44nQ=;
 b=ySbyzzsOnkeo9uwH3dfqBcKcE8/chLwpRinL79s03nyWt4FjJeGi08YE0+7jlVXJHo/y/2Yfh
 M4aiw/rKy/wACBIwQ94dz13cg2deeVabuQ6Gk8tndY4RJM7k22dg+oF
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3017660c-1e59-4b47-7080-08ddddf64256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGYxYk9mN3lQSVlPckgza2ExTDM5aGF2Y3NoWFRyU1ZUcVZMTVZsWXBzbjha?=
 =?utf-8?B?Q1kzVjhFNC90SUxDSlNBWDBwQUhlL245bnB4UXlBY0JUMDhZV3ZVdi93RXBz?=
 =?utf-8?B?U1lUTktMU3Urc3F2eWZoZit5U0UxaUNoYUYrVWNkNjVBM1Nuem9JTUEyczE1?=
 =?utf-8?B?ZSszNkFjUnJ6L3J5NG1jRGdUNm1XVkpGc09rcFBmZ2VPSkYvdXhoYmVuR2FZ?=
 =?utf-8?B?UkFNV1FVdWZHZ2hPRDd4dDlNU3lMWG1uZ2NuY1Rad3lwNnlIVURFTTZLOFFq?=
 =?utf-8?B?VExUTnNTbEpGdUhqOXRGVTlUUWFPTlNwcVdHYU4wSVJYL2Q4SEhaN3BKY1Y5?=
 =?utf-8?B?UlNuY2JOSk80cUx3eDhYdnJ0TlVFSzV2T3d2SjFlaDN5S1BQMjdLNVlTREZw?=
 =?utf-8?B?L2JyNS82ZklHWEdsQ2VtNHgyckJ2NGp3UkZiMTRITG1qR0JDeXcrQ0c3QmZ6?=
 =?utf-8?B?dk90REwvNTBZWWpxMmxMeTEyeGU2R0x5OGNadlVtZjI4OWtwZmxJUEEzeVJr?=
 =?utf-8?B?RmovM0dZWkJtYzUydW9qNHJySVRKUFYxenlrTnpEWVQ5dmJRZ2ROdGd3cXIx?=
 =?utf-8?B?aWFSUm81amt2K0UvdndSdWtneXhKYXIrREM3RmNnaG1GVjJVcmR2KytJSHFS?=
 =?utf-8?B?Z0lLTVNydlF5cW4xc2ZNeGM4TVRxbzFQaythQTZabDQ0dmFSRTFINzg3YmtJ?=
 =?utf-8?B?UnBMYWhJOXRoQk0xb3NiYWk4VG1Ub0x2N0NIYUNVVTh5UFF1RmJrYjh0R0RO?=
 =?utf-8?B?U1ppUXlLbzZvNzlxWTl1Ky94YkNXWEZtN3pRVFYxYmRVSytBZHEwTndMSWRH?=
 =?utf-8?B?cnV1Sk40YWk2clFxTGRIY01Rc1ZxMXMxNXRGTGkzMUUzZzU3ZVc5MGNPTDhQ?=
 =?utf-8?B?cGk2bHI0ZlJrTkNIaWhrK1JlM1hFc0tsUm54TzM1aURqUmNITjVnWEIxbk9z?=
 =?utf-8?B?cXp3YWtNYXNCd1VYdzhjRkY4M2txb1pBS2JsTEdESHlNZUo3dlBrSmVGZnFR?=
 =?utf-8?B?Tm9jVkJPelFzZWlvTVpOMWRFTTFUaGkyYldEMStIaGNrUzJDNmZFMlhaVTBj?=
 =?utf-8?B?KzJWelRVcUhzUHhKekN0VjBIYUNMdENNUm1KUTkzZGtxdFltV1JZNDZwalpp?=
 =?utf-8?B?bEJ4TlFoeEpXWmFkaE5zd3J2ckFTekVuTXArdW0rR0ZrRm1hVSt4YUF3TmpR?=
 =?utf-8?B?NjlZbTlDVUZPWDF3N1N6M29zaXJhWWV0WW9qdzlia3FBemluQmVqdU1ucTFq?=
 =?utf-8?B?OEN2dVNEWlUya05lL3BMNkxlWGVYcktDNnRUODFaVW5LcWc5VVY3QVgvZytG?=
 =?utf-8?B?d3pBTmVXdjBudzNNbVU0R3VxaWwrQm5nVkdKaGRST1B0V0JKL0dsN1ZnTnc1?=
 =?utf-8?B?NGMveVVqOWQ4c2R5Y3JIMjdxcWw1YlREcVUyVlBzZS9CbkwyWFVaS2kyUjlS?=
 =?utf-8?B?VkFDem5DWTFkcStERm5USHNBcFQ1RnFFYmpScUx3ZmdvVW9hZmV2eEhZNG1s?=
 =?utf-8?B?N3Q2dUZHS0pmY0RpV1c3Zi96VmZHNzBFajBoajNSRlJkMGhKSG44elh6TmhP?=
 =?utf-8?B?OFRHbHpJWDg3bUZ0bmdTUnh2SkV4b2xpVzRhb2lOZTdqSXRENm53QUJhdm5n?=
 =?utf-8?B?UGFlVWpHTDQ0eWZRM2VwVm9JUEgzMG1kSmhqdDFIUTYvWVgrWXRvaVdLT1ox?=
 =?utf-8?B?YUZnUE5yWHVSdFdBQWk4YnVTNkNWc29yUjFwOVBPb2UvZlFpazFkT3FkQjFM?=
 =?utf-8?B?ZXJNQS9VTUlINEFXQ1A3c3ZpMWR5Y09rWlpBdnJXZTFNY0dDc1FVZk9GQVpC?=
 =?utf-8?B?SDQwMWtJby84RnVkRjlxbDhMUWl3YU1Qdi9WWWl1b0hsdGw4N2ErakdGODVh?=
 =?utf-8?B?Rm1QV3RUUzBtS3hqREhkaDk3dnQxR1RrOHBSM2xrRGYzMmFlelhkSENOc3Bx?=
 =?utf-8?B?Z2oya1RERXJXYjIwblZkYXp4MWQ2M0o5V1hGUndZd0NmR0ZaNWFEQjAybGIv?=
 =?utf-8?B?NEVVdEtmeGpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzZNaU84NlJNdDg0d2ZBZUpoTzh5aG1va09DRExZTzlNNXRrY3ByT0pmU1pE?=
 =?utf-8?B?dExjaXorYThzZFNta1lDTEpNSU9OZXpodi9xSlFJbEJQU2EydHpYa3RvWGEr?=
 =?utf-8?B?WGFtL1JMbTBoVng5NjVlTkNYenBIbHppWkZZVW5MdVlwMGRyYVFweDMzVDFZ?=
 =?utf-8?B?bDNlQzVySDNNMXZ4QlZTamJQdGp1VHFmTDEzRUhqZUYzT2pkQ3BLNGVXbGw0?=
 =?utf-8?B?ZGZWV1czRmxLbUxKV1JrSE0rRmVOaWtPMXI3Ym4zR1ZqZmhNSFlsdmFFcXNB?=
 =?utf-8?B?YVBhTnprRUNwaFhLbnlubHhCTUxlUlJTdi9XUUdwbHc5VVA1bkxUdzhmSVdJ?=
 =?utf-8?B?Z2hIYW81M21sRS9Fekg2N0lRUVJHc3JoRStMSjg3SnpXQXFrU1pSbmh1V1dM?=
 =?utf-8?B?RkRsY3JmUGJQUGVmdi8rVkdQcXNtTnJtT084SWx4aC91UUUxTDJIU01YOWo3?=
 =?utf-8?B?YnBqaVh6dUkxYURYUVdPNlcwc0NHVUVmcTY1cTV2eis2Nmhpc2N3ZWpvZ05u?=
 =?utf-8?B?cFRLTVM5dW8rSTIxVnlJc21NY01SS1FYVWZrdS95WkJXRk5XdTI1ZkM0TVQz?=
 =?utf-8?B?bVdMbjRoL0pwblYwcjhxTmxTNjhJbEk2NFZuNGZjMGRhN2NLSjNSWTNzR3Nn?=
 =?utf-8?B?ZzRacnJVcHRKMFk0ckdPSTFXeUVFOWlHUjIwYzNJbTg5NU84M2VHZ0UySUhI?=
 =?utf-8?B?ZlF2ZHljWndGazlSbHdYa2xRRXE4bUV4aWpoSElneFZ4V2xSOTFtdGJzN0JR?=
 =?utf-8?B?ODMwMS9kVjlnbE1vblJuVStLRVZ1ekFOektMQmFoc0kzaDV6djhWd1FmTU0y?=
 =?utf-8?B?cUJaOHFUQk8wZHQ4ZitwY0M5NWkwZHlYNFYxTStDT2RhMkdKT3d4d3krZy9y?=
 =?utf-8?B?MzFTVzlJekdpTjVBYktPejVSNXljQzNlUzdTbFliaFBHSFdRT0wwVDBvaXpJ?=
 =?utf-8?B?TGwza3ZzbWxvQWJoWkRLK2NxU0lCMlFGbzQ3c3JCK2NFZHpuQ1B1VkR6QWRN?=
 =?utf-8?B?bnNlOFF2SFdaMlRRczBGbHBHRm1zQjMzTU53LzZZNnVqTXd5QitNVW5wOFV0?=
 =?utf-8?B?aU9BRWFWZERYSDBXZFNaQ0dyYWgwck5HekxlNFVkdEFWT0dqWSs4VTVrZTdu?=
 =?utf-8?B?ZW9RTTQ4WUpJcUhaMFQ1Sm84Uk55VFRIWjZzQUVkem5ETXRGTVRMZGNCQWJB?=
 =?utf-8?B?ei9Ra0ZJWExFUWVYZmQ4Z2gzRnhIaElBZ25Tcnhxck5ldUtxTDl2eGRIU3lG?=
 =?utf-8?B?Uk9oKzJGK3dBLzRMbHRjTURQS1RVOUQrbElSK3FjU2JIZ0tCV2hXaVI1Y1lB?=
 =?utf-8?B?eGhPa3lHUUtMYU1hRjlOblozcHBtdXlmbjFWOUdUbWwybFhUd2M1eFlTVUl0?=
 =?utf-8?B?eUU5RUhJR2RRN1puSGU5bE9JUDZVdkQyTkdqSEZVYjFsTGRtUHpDcUtiLzNa?=
 =?utf-8?B?RkNHbFR0VzZjbUNtNXJBcDcxTXdIV1Y5VHBvVmpMcVA1a0FMUkhNRTI2Z1Ru?=
 =?utf-8?B?V3puNno4ZEVFR0NteHlDY0JNT2NDZEhxY2VmY240WllZcnVEWnFqZVhuakpr?=
 =?utf-8?B?YkZmZ3lmdThUaVExY1Q4dmIveVRnaUJTeXQxMTZFb1JCSy9IYnUzcUVxd2ZQ?=
 =?utf-8?B?dzBGMk8wM2ZUdXd4QW1nRGIyWU1TU0pDMEVOWkx1dTBFamZJbWt4NVZ2Sitn?=
 =?utf-8?B?NHlPL282TVZkN0F3TVlvOFlHVWNHZk5LWFliUWh0NXJQaTVBV0pUVDkzT0V5?=
 =?utf-8?B?MjFKeDlGVXplUmpScWNScThwdVpKUytQUE5PM09aTmM3S3pqVUJpak1MTkZI?=
 =?utf-8?B?ekIxY3JGenRhT25JRDJqZ1JtYjRRTzFVNkhMYUd0a3lITzFBVkZ3QzRoK0Nk?=
 =?utf-8?B?NFBlVUQ4d1VLMTZERit3UlJDRDc5WUZWWCtjSEdrQmJRMkNXQXB4NHluMWFU?=
 =?utf-8?B?Z2FDd3I5eHpNMENlZmROZ2ZXRXNuZ1l0aTZ1UC9Tc05pMGVpZjFueDIvekUv?=
 =?utf-8?B?aGxEbVFmTDhSVG52N3dRWTFLQ1pJaEMrKzFaSk9pOWtXZ3lKT05sL2M1UnYv?=
 =?utf-8?B?QWhrY2dWTTEvclI5NEhLR1VaVU1BOXFhVjdJRmxQaWVZdTJoOGY5WWJpOGZ2?=
 =?utf-8?Q?aMt8+Q4zfxEoG8dgZl//fUlMs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3017660c-1e59-4b47-7080-08ddddf64256
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:26:30.2427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18s+GynCAtu0AW4nN1AKMfH4b8n5/GpRdEhkLVYP89Qiq7LSrjT//ztTpwCw+bV0QfNBPnIfpuLTthjz6q6A2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11530

System Manager supports reading out pf09 and pf53 temperature and
SCMI Agent could get the values through SCMI sensor protocol. So add
the nodes to allow Linux to get the temperature.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 11393bd57582dd9097732c84e6281be2662145f7..d0c7c9fa43beda4aed83c4b4ecfc4e7f65ae0386 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -1058,6 +1058,79 @@ map3 {
 			};
 		};
 	};
+
+	pf09-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 2>;
+
+		trips {
+			pf09_alert: trip0 {
+				hysteresis = <2000>;
+				temperature = <140000>;
+				type = "passive";
+			};
+
+			pf09_crit: trip1 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	pf53arm-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 4>;
+
+		cooling-maps {
+			map0 {
+				trip = <&pf5301_alert>;
+				cooling-device =
+					<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+
+		trips {
+			pf5301_alert: trip0 {
+				hysteresis = <2000>;
+				temperature = <140000>;
+				type = "passive";
+			};
+
+			pf5301_crit: trip1 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	pf53soc-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 3>;
+
+		trips {
+			pf5302_alert: trip0 {
+				hysteresis = <2000>;
+				temperature = <140000>;
+				type = "passive";
+			};
+
+			pf5302_crit: trip1 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
 };
 
 &tpm6 {

-- 
2.37.1


