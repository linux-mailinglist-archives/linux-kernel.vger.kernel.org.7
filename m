Return-Path: <linux-kernel+bounces-806297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94392B494B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7B4188C1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723930C616;
	Mon,  8 Sep 2025 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AL60slLF";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AL60slLF"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023143.outbound.protection.outlook.com [52.101.83.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565B1D6BB;
	Mon,  8 Sep 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.143
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347502; cv=fail; b=gp+e6v2HZrcaorOcW5UdkvIMHnnFPhXqJ2+3FDX4r+2TxS43M5VyJyrNpdfYzYC5vuc8LsmsrTEZIi4wqUs6RmcEFMkmiOZtCqF2KRoq5BamPixXdl1zbSLvAArYT6g1+eKtw+M+7ndPZtKvArAufCY7ycFoG6UoBnZpBpaM4eI=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347502; c=relaxed/simple;
	bh=Lxs3b69orU7uHRS8vzmW2cmvH2V++0pv9G3dGHr0kow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XViv1q2DmZwz03Vz0PpiLizO9gqTe9OjcuXZRSRo8gOcdO0Xn1Bxfj6Uu8FFWCYlimzn/2M4oJMrvungOG/Ppl49EoPb1y6eyOX2qavnQL+iWae4bgpm7JnKcVtSAPIouzYVjh5JU7TKWTjh9Peal0rDdnqq8ih+FLEuwUeVGes=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=AL60slLF; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=AL60slLF; arc=fail smtp.client-ip=52.101.83.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=e/CggoYoLSwUKgbNXcbfOuTfmUFsL0k1BVsB96J/ma6tWnb71X5V/5SDbPFmq/0Z7+t1JQ+znvW9Txtst4uS6yXKTNyBVHfKgPo9lqOiafuLN6zO/jOkVhFHDg0yHaHZfH7umatdrhWcz7tkyCnJWDABWBQ+ss9pDN8t0RMMJim6EIc3RC6CreGqxrwTrvYbD/gd944nWJfcti3YRHV10Z20rQM2eOceaOVd7dlQs0ZplyGt9cTmGIkPSDLy97AVZSaVQ24rJ31WqPbmUkGe6wP4M2nRqkg8p7JqZpRjGzAFCcY7KXDIpRtPd/V1aOJWrU8pZTNG1ujD6x4qDRb7/Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxs3b69orU7uHRS8vzmW2cmvH2V++0pv9G3dGHr0kow=;
 b=rcY8cpsUhA8oqviEHIbZSPbNwtxE0Lpjk5qMr1KImfVKsuk8Hyf4s6K8v46Q7JJu3RtDa/EaEWVl9xXD+RxG+piD81bYgMOda4povJKkqVgoyK1Okkfuxg1Yt1XdUsNbyTtowU4NwhylaVdAs35uDIVy7A0KOF0hez9GFLce3qVyq3hbyylSCsDION/mtiblOezpCHnfItnTryKtKYuQkzZ83XrZC9hx/uCYET4GvgUE/VjhOXd60z2Z95J5R7tGoC2Kx67dhNmbJOtreG/JDV6ipD6oasAMjALAvq248VcYXSr0DLYlFicSQKV8hMsnp9GCS9kFOijnGi8N/IhQXA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxs3b69orU7uHRS8vzmW2cmvH2V++0pv9G3dGHr0kow=;
 b=AL60slLFWHAy4uI6YAzydcY4mNmZa2QPaYxivZ0msB1Oo3pdNqwR2iNUB2Vej1xdQe7AtFsrGnbaiP8zKgf+X65NrU1TAb53wsTA8kyv20dfc6WISHyox7JMwEf6wZf2wLO05jZMuHIOuSvUpe6cMnFEBmh/FZnIUToD/Mz41m8=
Received: from AS4P189CA0010.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::14)
 by VI0PR04MB10255.eurprd04.prod.outlook.com (2603:10a6:800:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Mon, 8 Sep
 2025 16:04:55 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::f7) by AS4P189CA0010.outlook.office365.com
 (2603:10a6:20b:5d7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 16:04:55 +0000
Received: from emails-3534568-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-93.eu-west-1.compute.internal [10.20.6.93])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id BB9938024A;
	Mon,  8 Sep 2025 16:04:54 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757347494; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Lxs3b69orU7uHRS8vzmW2cmvH2V++0pv9G3dGHr0kow=;
 b=OrUDRbR2d9n5/hGh1WOzZpYjIGE+W1kRbwxa9TYPTRLWGexe1wu/iyE6x870rIMAMraHm
 DOHSSRovCT4/6tuHGrKBEeyGVzI8NS1w5V5Qi0cnlL/3MwEkbTBwYcV+MLDZqhMvPBc9cy/
 t5y8WyYl7IP+cSitHQ73+ZRlXKr/gyg=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757347494;
 b=nGsK4aCW67p6Dx1F2gChQzYvduPMkoxSOzKHZvHQyhN788Qhpq7JlF+bA+gmT6CGHwFkg
 0g1/6hycAeSEoyimA7BCGpBdXsocioh7mrzAaB75VNu3YRHAljK04BX3Nt0tMLRAZRtO2Dg
 KdwResFSeXrGYQ8ffcOsQSxJMbVMOqA=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkVCL3UfZe8btl3Pz07c6UzeS00wBth1Wv5dRlpS1XdSfzLgN/6kHykQ6BOzgeNdlfTv3lO/GUoEXUeei/prIa4Il2f8Q6Gotw0nSHCCKYupw6fzeBteh+PCGEqCMcNWyE0UEI69ByLviSq+Pq0lN64X3swpHqwDYyc6eHueSDY/GcU+c2qqNOsDmsyWb8Du+aCT0USoqQycGpFem9mpZiwzmlg89e7lZ2No+Kxfk5Qlduw1NhpdQNG64FZs+b0uYeV/ireUY5EFAqgn9SqPbh5jAgnk8so06Wgz2zPjYOo8S0WNn2oZZbBFe40j4Xxcd7ApVO1lNn0b+q99VGuI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxs3b69orU7uHRS8vzmW2cmvH2V++0pv9G3dGHr0kow=;
 b=aoaBJIMdUNJWwZt4SBNwYsbncLJHvUhzvLMwLLKh1Vwm2oQsYHxhslfLUXyl/Dm1SP50bMMASRlsl3NzihBa/TZ5uL3fomew1nL2mt9rMAICAdBdu60Q1lcGkQ1AroDwL2dhH1Mt5LvdCt4EEsGPRPdMTPXb1wM29MbxeYt/VuNNJJDnt7JxXFIo7grDzml2Ajl48Ob/2d4bgP+UIo7UozcB83zS6vQ4VmlPCFcOxWJyot6mPacDHBItdLlZ6rPE3g1HhWrKRmw9eZZC9xZq8j4mCPh3Y+7J7yzCMVRlnPucn2IuEfJA5RXEpnMNAouvxfuW24ltKwgRut81tqaaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxs3b69orU7uHRS8vzmW2cmvH2V++0pv9G3dGHr0kow=;
 b=AL60slLFWHAy4uI6YAzydcY4mNmZa2QPaYxivZ0msB1Oo3pdNqwR2iNUB2Vej1xdQe7AtFsrGnbaiP8zKgf+X65NrU1TAb53wsTA8kyv20dfc6WISHyox7JMwEf6wZf2wLO05jZMuHIOuSvUpe6cMnFEBmh/FZnIUToD/Mz41m8=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DU4PR04MB10669.eurprd04.prod.outlook.com (2603:10a6:10:58e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Mon, 8 Sep
 2025 16:04:46 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:04:45 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Topic: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Index: AQHcHnuYJtm9dj7MPUeeCk+9PJYwF7SE8myAgAQY54CAAEooAIAAGpoAgAAHioA=
Date: Mon, 8 Sep 2025 16:04:45 +0000
Message-ID: <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
 <20250905154150.4tocaiqyumbiyxbh@skbuf>
 <20250905-pamperer-segment-ab89f0e9cdf8@spud>
 <20250908093709.owcha6ypm5lqqdwz@skbuf>
 <2b1f112e-d533-46ae-a9a0-e5874c35c1fc@solid-run.com>
 <20250908153746.7mfobudenttdi4qd@skbuf>
In-Reply-To: <20250908153746.7mfobudenttdi4qd@skbuf>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|DU4PR04MB10669:EE_|AM3PEPF00009BA1:EE_|VI0PR04MB10255:EE_
X-MS-Office365-Filtering-Correlation-Id: bc047fec-d7a5-43b4-e361-08ddeef173a1
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Q3dyOXMxWDk1cXhCRVBqSWRBNUxqUjk1UWl4Ym1lZWtLeVVWZm5UQXZmWkFo?=
 =?utf-8?B?UE5ONmY2dHNWRFlvWUZIS2RxKzBoR1V3cjU0YlZrOFlXS2hnZGFUS044am9D?=
 =?utf-8?B?RWpXbVdXeCtRTHIyV05GUDBZYVpJQTFqRHdZMElDSDRsOTU5VVJBd2ljNDd5?=
 =?utf-8?B?OEdnM1ZFWHVBNXl4N29OM1FrTi92eHBTMEdFSnRMcUc3VHpLaXZsWnFIblJH?=
 =?utf-8?B?NGd5eFFPYzR1MWFqQjIybDRwemNIenFEaUI1VWN6b1BKM0U5N3ZjNi9EcmFr?=
 =?utf-8?B?V2ZOTmU5OVEra0JISXZQQmNkb3c3WGZYa3N5WjNSOXdGZXNBRmdkOUJENmJJ?=
 =?utf-8?B?NjVqYlFDM3N1M293N2N1TWlOUGpiMEhKb2RnaEtndG9wM3NsUFMvVytjbXpp?=
 =?utf-8?B?ejNwa2RTeWxuNTkyT25BTTJhbzNxRUVIYnQwRU5Zd3ZMYlZLdkpTS3cyV1Bh?=
 =?utf-8?B?Q1RaL0hLT0tTeWkrdzVrMStqclVZM2ZOU1MwOHRqcGE4dERDdVM4aG11dTZt?=
 =?utf-8?B?bis1bThmZENidVBaS1pxN2IwQ0prclB4V2lDWDUzRTk0c0RpTkF1c01za1JN?=
 =?utf-8?B?cXY3ZWtaeWR2UVhQQ3pqN05Lc0FtS2lySElvcHVoc1NQU2M0aU9JTHJYNW41?=
 =?utf-8?B?NEljZEs3RlFyNXhWY3gwUXQ4Umx6U2x5MWxPMlU4a0E0NHNPTUk0YkVSY2Zp?=
 =?utf-8?B?eTRucjhJdXZnMTRGY3pIRGNRNDlxRkhSNCtPbzBZdmkxWlAvWGRiQTdhRkFv?=
 =?utf-8?B?b0V5TjJBa01BblZna09lMGdxSXFwcVBMSjUwWUFTcXJJd2tQdXVGYkprOTVB?=
 =?utf-8?B?U0NJWmorZmdMR2hXN3c4MGxCdUUxNWd4TlJ0N2dWRmZWS1lDcGRmaUswczY1?=
 =?utf-8?B?NG5tMFBlaUwxNmM3L3JOVWVzcDc4aytVY3NmOFFDRVZ3QmMxWEVCY0dqcm16?=
 =?utf-8?B?U0NOV1RvTmhFVDgwTkpKTzdQWmlhZzMwTE5BQXhMemJHdkxPZ0h4Q3AvU3d6?=
 =?utf-8?B?dVBHeXVGWlJiZXNqVmhuMzN1bUVlVkRRd2hBOU1VRXdNblpya3ZKZC95c3B2?=
 =?utf-8?B?dDNGR0dLVWdKc3g4bk8yMDJ0aVhPeGlkcFBTdjRWNEYwM1ozSEVjbzdOczAz?=
 =?utf-8?B?Rk91QXQwTktvSUVkOEhmRW5YTzNnNzJxUDdPUFZVZVFDdWdqd2I3V1Qxb0tN?=
 =?utf-8?B?RUNuY21BbTZjcFh4YzBNOWpROTh2UGFCNXNHaVJEUW5od3ZZL0JCUE01WFBP?=
 =?utf-8?B?eDZIc2NWTUhVU0gwQ0pUWDVlcUFua0VVcmtzZzZVM1o5NDJGNDBPV1lybUN4?=
 =?utf-8?B?bjVRak04VmFQdHBZRzZOdXJJWnpxRm5lWkQvZ0JYaHMzbnNwK24vc3phZ2Q2?=
 =?utf-8?B?aEdVcGJBR1lHVUFOUEJSOGJhN21pS2NlckhTSGh5OEp1aWY3UWV4UDZaTVBp?=
 =?utf-8?B?WGQzNEtWT1hGRmhLNGNuQzFPS1V0bDBsYVk2SDJmemdQbndyTzdweTRCVXdV?=
 =?utf-8?B?eWVpMTlGNmFCRjhYZDBZT3k5Q3k5b09vbVVnckw2b1ZURlNtZXF0bkRrS2Zk?=
 =?utf-8?B?dE1qZXZtSUR0VnBZU3A0cFNsL2RMN014VVJBa2dzRGZuMUliWEtzcUkzUEky?=
 =?utf-8?B?c1NnVnUxd0hVU2RRdjRaZjNWODZ6OTZaYkpycjY3V3M0VDlKd3NYVHZ2TGgx?=
 =?utf-8?B?Tlg3MWxRa21DS0pFZTR6Q2tYOXFGcjFqVXpBaHNEdXlSOXpucnlrOC84Q1hs?=
 =?utf-8?B?RE11eEVsNjN6M0U3SExMdVJMQ1BvWkRnejRScmdTem1YSGZmL3pqenJZZTNr?=
 =?utf-8?B?ME40MzFBcGViT2g1REw2Sy9xajh6U2NSOVNMRVlDcTl4T2psdG5sdk14T2RH?=
 =?utf-8?B?My9WTW8zVzNqdFlLeW44TnkyV1YyUlpXdHh3NENLM2ZTcnhUVEc2d1JQL1pY?=
 =?utf-8?B?bDlRMlJBWDdQSGN3b0J4Q3hwbWtUd0VxK0FMUkNXNFJ2a1E0Ty94ZnRoNFpC?=
 =?utf-8?Q?a+xMnu8Lxj7COrwH83vKz6fWwF4af0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <C70099DFD4D4CA49A53DFC3E8BE20317@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10669
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 4ca03a77acc04e04b2f897d25047f6ae:solidrun,office365_emails,sent,inline:934066ba694f68175f9369834bf36a69
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e251761e-c137-47c1-f296-08ddeef16e21
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|82310400026|14060799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVg2azNzQTkxb09yd29QSVhjQWN3alpjbWJYQ3ZHdUdNNk9DNlYxYWk3WVgz?=
 =?utf-8?B?Y3dONkx4N3lqcGh1MExzeFMzMUw0bkZWb09NOHlQMFNZTTlHRm90OURKYjBH?=
 =?utf-8?B?SDhRL0VFTy85WFJteFA5RU53ZStJT0NGd2FhTUVRb1dYVGhOSHRDNXVTYVZ1?=
 =?utf-8?B?czlLVjVDbGhUZlFnemQrWWtydTc1VjdRdEdPWTBjc3AvUlhDMllhbzlYeEh4?=
 =?utf-8?B?S1M4N0FjSkJXTWNSaG5RQjBPaWJzNVZmRWs5dWRLM1lTMDQ2ZXlreTVnaUxY?=
 =?utf-8?B?b28zWTJKdkpzSklmeVltNUtHcjlrNDhUZ2Rsci93U0piWkZtWmpNb0VFTTRC?=
 =?utf-8?B?NlFwREFQUHNQQ1JiRzg0bzFjekNWZUZERlE4SWViOGlaMm5sMUNPSnZ0TTl4?=
 =?utf-8?B?NkFoNmNhWWQyZWtaUGRrTDVVMmVOckl6RkNYMHBpNW9OZnllc1FuZC8rbUVX?=
 =?utf-8?B?NnZxOEVpM21JYnJJY0VOaVNtZGVhbjVVNVNpSkZDNXpjbTIxUDhXcm5DQm9P?=
 =?utf-8?B?b2xhWjdlMTFpWEV4Mk0yclpza0ViSkxLMDVDazdjWHhjU2laQnBXVDkwVEJo?=
 =?utf-8?B?YTVCcDR4bUlVZG40WlBYUmtLYUdDeG03b0x2RVdWK0tzRG5FTmJDRXFwdmVz?=
 =?utf-8?B?d1g5aHo5NnhOWGZaWXVLU20vYWxCWmZRZm9zNXB2aWFUQ3R1V3V5QTZNZXVU?=
 =?utf-8?B?ckp2eElTd3NlekVxcTExMTlyYlAvcFhtWXZXa2pyN3l0b2ErbnY3cGM2TlNj?=
 =?utf-8?B?OXdkTWY3V0V0MnZXa0k1YTd1dzJ2RHZVdlpvSXRDQ0lRTVdXaC9kYzBjQi9j?=
 =?utf-8?B?OGpoZVNOdG9vVmpHb3FTSlpURTluK1ZaSk5qb0Y5U2krYmFwUGNXc1lCUXB3?=
 =?utf-8?B?aSsybTlPcjczUDNWZVREVll4MnN6cU5LZ0NzVTVsbXdja25wd0V4c2Faa1BE?=
 =?utf-8?B?TTVwSmhhZmlVMFhFWW5qeG9nWS84RldZMzVFQ0YxK2I5S0RCOWNCWk0wYzYv?=
 =?utf-8?B?UW8wdHpEcW5SSlY0ZUtudlJTb0ZEK1VTM2JSWXR6WU5ZSzBGaFNJS2ZmWWh2?=
 =?utf-8?B?UlBaNjRLU0krUGxxNFl6dEcxOGJ6U2NtR1U1RlJ4aUdwdEI1NlRnREFIVDl5?=
 =?utf-8?B?QTdScitBYmJyenoxTjd3WTQ1T0JkM3diZkhkV0o4a3VUZUhFbS90R2p2Lzla?=
 =?utf-8?B?ZzB2NlJhWUxzRnc4c0M1RU5lUFBWYjdxYTBtS2VhM3dlaVdQRlF0VkxjRUFt?=
 =?utf-8?B?aHZqSjZPRWxqQ2dNNWtCd0VKZHRyeUorZnJ3TUY5RTlyRzZXenQzL084aXJ5?=
 =?utf-8?B?ajl6VEw4cDNrTDg0U1BRUlRTaDhpUFMxOWhHYksrZ3JpRWRyNUg5Q0x5dnNX?=
 =?utf-8?B?YnVWLzhxYjVhUmdSdHdCOEZveVp6YXE0ekJQOUErMXYvWjFsVWR6NllJYi9U?=
 =?utf-8?B?M0Y2Z1lGN1ovb3IwcHRkc2lZVk14UUx6bVpNQm04eTRYRGNjVW02b2VmVzFR?=
 =?utf-8?B?TlNYanNzR1dZY1RsK1ppamlya0F0TSt3b0JmK2RiYmxxNjhCc2FPU1FZWUlm?=
 =?utf-8?B?Zll3Q3hEU1dwanlubDN4YkZuRXZRK1ozN09MSzB5NEt5OXpENDdXUWlvR1FJ?=
 =?utf-8?B?L1BMd2ZXQ3hodVB1S2dHRGpSVnFmMFIzU1lXTk8ra0gwY0N5c3dtbmFUQy9E?=
 =?utf-8?B?ZTVJWVg5eUttR2RoL2QxNWJZa1ZVMEhrc1R0dUFlSTdqMnBIN09hdHc0QzlT?=
 =?utf-8?B?QkdOQjZMa2VVQm9nSWdyRDliSkNWYWtKcHY5cjBacXhuS3lRbWZhdE1OWGRt?=
 =?utf-8?B?eCtrdU5SYVFWd0E5QXFPSjRoQ2RocEdSZi8xODBWTG9qWFIxYTFVZDFTeWJ1?=
 =?utf-8?B?dVJ4ZFVrdDZ1aCtFSDdtUjRjR25RamNZSU5jc3lOcEowWmlIR1ZUQjM5TmZM?=
 =?utf-8?B?Y2ZRVWs4c08wUmtMalE2YWlEMUcxL0lTR2VGUm9UbHRlWXFzWG9zOE1yZTN1?=
 =?utf-8?B?d012OWYwdWUrM3B3MVRrSmJCSHUwMGEyWGp2eU55Slk2d3R0T1BrOTN5VzBL?=
 =?utf-8?Q?vqtTvP?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(82310400026)(14060799003)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:04:55.0135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc047fec-d7a5-43b4-e361-08ddeef173a1
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10255

DQpBbSAwOC4wOS4yNSB1bSAxNzozNyBzY2hyaWViIFZsYWRpbWlyIE9sdGVhbjoNCj4gT24gTW9u
LCBTZXAgMDgsIDIwMjUgYXQgMDI6MDI6MzVQTSArMDAwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+
Pj4gTXkgdXBkYXRlZCBwbGFuIGlzIHRvIGRlc2NyaWJlIHRoZSBzY2hlbWEgcnVsZXMgZm9yIHRo
ZSBjb21wYXRpYmxlIGFzDQo+Pj4gZm9sbG93cy4gSXMgdGhhdCBvayB3aXRoIGV2ZXJ5b25lPw0K
Pj4+DQo+Pj4gcHJvcGVydGllczoNCj4+PiAgIGNvbXBhdGlibGU6DQo+Pj4gICAgIG9uZU9mOg0K
Pj4+ICAgICAgIC0gY29uc3Q6IGZzbCxseW54LTI4Zw0KPj4+ICAgICAgICAgZGVwcmVjYXRlZDog
dHJ1ZQ0KPj4+ICAgICAgIC0gaXRlbXM6DQo+Pj4gICAgICAgICAgIC0gY29uc3Q6IGZzbCxseDIx
NjBhLXNlcmRlczENCj4+PiAgICAgICAgICAgLSBjb25zdDogZnNsLGx5bngtMjhnDQo+Pj4gICAg
ICAgLSBlbnVtOg0KbWlzc2VkIGZzbCxseDIxNjBhLXNlcmRlczENCj4+PiAgICAgICAgICAgLSBm
c2wsbHgyMTYwYS1zZXJkZXMyDQo+Pj4gICAgICAgICAgIC0gZnNsLGx4MjE2MGEtc2VyZGVzMw0K
Pj4+ICAgICAgICAgICAtIGZzbCxseDIxNjJhLXNlcmRlczENCj4+PiAgICAgICAgICAgLSBmc2ws
bHgyMTYyYS1zZXJkZXMyDQo+PiBXZWFrIG9iamVjdGlvbiwgSSB0aGluayB0aGlzIGlzIG1vcmUg
Y29tcGxleCB0aGFuIGl0IHNob3VsZCBiZS4NCj4+IFBlcmhhcHMgaXQgd2FzIGRpc2N1c3NlZCBi
ZWZvcmUgdG8ga2VlcCB0d28gY29tcGF0aWJsZSBzdHJpbmdzIC4uLjoNCj4+DQo+PiBwcm9wZXJ0
aWVzOg0KPj4gwqAgY29tcGF0aWJsZToNCj4+IMKgIMKgIGl0ZW1zOg0KPj4gwqAgwqAgwqAgLSBl
bnVtOg0KPj4gwqAgwqAgwqAgwqAgwqAgLSBmc2wsbHgyMTYwYS1zZXJkZXMyDQo+PiDCoCDCoCDC
oCDCoCDCoCAtIGZzbCxseDIxNjBhLXNlcmRlczMNCj4+IMKgIMKgIMKgIMKgIMKgIC0gZnNsLGx4
MjE2MmEtc2VyZGVzMQ0KPj4gwqAgwqAgwqAgwqAgwqAgLSBmc2wsbHgyMTYyYS1zZXJkZXMyDQo+
PiDCoCDCoCDCoCAtIGNvbnN0OiBmc2wsbHlueC0yOGcNCj4+DQo+PiBUaGlzIHdpbGwgY2F1c2Ug
dGhlIGR0YnNfY2hlY2sgdG8gY29tcGxhaW4gYWJvdXQgYW55b25lIGluIHRoZSBmdXR1cmUNCj4+
IHVzaW5nIGl0IHdyb25nLg0KTXkgcHJvcG9zYWwgcmVxdWlyZXMgdHdvIGNvbXBhdGlibGUgc3Ry
aW5ncyBhbHdheXMsIG9yIHRoZSBzY2hlbWEgd2lsbCBmYWlsDQp0byB2YWxpZGF0ZS4gRXhhbXBs
ZXM6DQoNCmNvbXBhdGlibGUgPSAiZnNsLGx5bngtMjhnIjsNCi8vIGZhaWxzIHZhbGlkYXRpb24g
YnV0IGRyaXZlciBjYW4ga2VlcCBzdXBwb3J0aW5nIGl0IGZvciBiYWNrd2FyZHMgY29tcGF0aWJp
bGl0eQ0KDQpjb21wYXRpYmxlID0gImZzbCxseDIxNjBhLXNlcmRlczEiLCAiZnNsLGx5bngtMjhn
IjsNCi8vIHZhbGlkIHBlciBteSBwcm9wb3NhbCwgZnVuY3Rpb25hbCB3aXRoIGV4aXN0aW5nIGRy
aXZlciBhbmQgZnV0dXJlIGNoYW5nZXMuDQovLyB0aGlzIGlzIGhvdyB5b3Ugd2lsbCBrbm93IGl0
IGlzIFNEICMxDQoNCmNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtc2VyZGVzMiIsICJmc2wsbHlu
eC0yOGciOw0KLy8gdmFsaWQgcGVyIG15IHByb3Bvc2FsLCBhbmQgZHJpdmVyIGNhbiB1c2UgaXQg
aW4gdGhlIGZ1dHVyZSB0byBpZGVudGlmeSBTRCAjMg0KDQpUaGUga2VybmVsIGxvb2tzIGluIGNv
bXBhdGlibGUgc3RyaW5ncyBmb3IgdGhlICpmaXJzdCBtYXRjaCouDQoNCj4gU28ganVzdCB0aGF0
IHdlIHN0YXkgb24gdHJhY2ssIHRoaXMgaXMgd2hhdCB0aGUgc3VibWl0dGVkIHBhdGNoDQo+IG9y
aWdpbmFsbHkgcHJvcG9zZWQ6DQo+DQo+IHByb3BlcnRpZXM6DQo+ICAgY29tcGF0aWJsZToNCj4g
ICAgIG9uZU9mOg0KPiAgICAgICAtIGl0ZW1zOg0KPiAgICAgICAgICAgLSBjb25zdDogZnNsLGx5
bngtMjhnDQo+ICAgICAgIC0gaXRlbXM6DQo+ICAgICAgICAgICAtIGVudW06DQo+ICAgICAgICAg
ICAgICAgLSBmc2wsbHgyMTYwYS1zZXJkZXMxDQo+ICAgICAgICAgICAgICAgLSBmc2wsbHgyMTYw
YS1zZXJkZXMyDQo+ICAgICAgICAgICAgICAgLSBmc2wsbHgyMTYwYS1zZXJkZXMzDQo+ICAgICAg
ICAgICAgICAgLSBmc2wsbHgyMTYyYS1zZXJkZXMxDQo+ICAgICAgICAgICAgICAgLSBmc2wsbHgy
MTYyYS1zZXJkZXMyDQo+ICAgICAgICAgICAtIGNvbnN0OiBmc2wsbHlueC0yOGcNCj4NCj4gWW91
ciBwcm9wb3NhbCBpcyBkaWZmZXJlbnQgaW4gdGhlIGZvbGxvd2luZyB3YXlzOg0KLSBhbHdheXMg
cmVxdWlyZSAyIGNvbXBhdGlibGUgc3RyaW5ncyBzcGVjaWZpZWQgaW4gY29tYmluYXRpb24sLg0K
wqAgdmFsaWRhdGlvbiBmYWlscyB3aGVuIGZzbCxseW54LTI4ZyBzdHJpbmcgc3BlY2lmaWVkIGFs
b25lLg0KPiAtIEp1c3QgY29tcGF0aWJsZSA9ICJmc2wsbHlueC0yOGciIHdpbGwgcHJvZHVjZSBh
IHNjaGVtYSB2YWxpZGF0aW9uIGVycm9yLCBCVVQNCj4NCj4gLSBUaGVyZSBpcyBubyBjb21wYXRp
YmxlID0gImZzbCxseDIxNjBhLXNlcmRlczEiLiBJIGRvbid0IHVuZGVyc3RhbmQgaG93DQo+ICAg
eW91IHByb3Bvc2UgdG8gZGVzY3JpYmUgdGhhdCBTZXJEZXMuDQpjb3B5LXBhc3RlIGZhaWx1cmUs
IEkgaW50ZW5kZWQgdG8gbGlzdCB0aGVtIGFsbCwgaW5jbHVkaW5nIHNkMS4NCj4NCj4gSSByZWFs
aXplIEkndmUgQ0NlZCB5b3UgbGF0ZSBvbiB0aGUgcGF0Y2hlcy4gVGhleSBhcmUgaGVyZToNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1MDkwNDE1NDQwMi4zMDAwMzItMS12bGFk
aW1pci5vbHRlYW5AbnhwLmNvbS8NCj4NCj4gT25lIG9mIENvbm9yJ3Mgb2JqZWN0aW9ucyB3YXMg
dGhhdCBrZWVwaW5nICJmc2wsbHlueC0yOGciIGFzIGEgZmFsbGJhY2sNCj4gY29tcGF0aWJsZSBz
dHJpbmcgbWF5IG5vdCBtYWtlIHNlbnNlLCBhbmQgaW5kZWVkIEkgdHJpZWQgdG8gaGlnaGxpZ2h0
IGluDQo+IG15IHByZXZpb3VzIHJlcGx5IHRoYXQgaXQgY2FuIGxlYWQgdG8gaW5jb3JyZWN0IGJl
aGF2aW91ciBpZiBTZXJEZXMgIzINCj4gaXMgZGVzY3JpYmVkIGluIHRoaXMgd2F5Lg0KPg0KPiBG
dXJ0aGVyIHRyeWluZyB0byBhcmd1ZSB0aGF0IFNlckRlcyAjMiBzaG91bGQgaGF2ZSAiZnNsLGx5
bngtMjhnIiBhcyBhDQo+IGZhbGxiYWNrIHdpdGhvdXQgZGlyZWN0bHkgYWRkcmVzc2luZyB0aGUg
ZmFjdCBpdCByZXN1bHRzIGluIGluY29ycmVjdA0KPiBiZWhhdmlvdXIgaXMuLi4gc3RyYW5nZS4N
Cj4NCj4gQWxzbywgU2VyRGVzICMzIGlzIG5vdCBkZXNjcmliZWQgYXQgYWxsLCBpdCdzIG5vdCBu
ZWNlc3NhcnkgdG8gaW50cm9kdWNlDQo+IGEgZmFsbGJhY2sgd2hlbiBpdCBjYW4gYmUgZGVzY3Jp
YmVkIHByZWNpc2VseSBmcm9tIHRoZSBzdGFydC4NCj4NCj4+IFRoZSBkcml2ZXIgY2FuIHN0aWxs
IHByb2JlIG9uIGZzbCxseW54LTI4ZyBhbG9uZSBmb3IgYmFja3dhcmRzIGNvbXBhdGliaWxpdHks
DQo+PiBhbmQgeW91IGNhbiBsaW1pdCB0aGUgZmVhdHVyZS1zZXQgYXMgeW91IHNlZSBmaXQgaW4g
c3VjaCBjYXNlLg0KPj4NCj4+IE1haW4gYXJndW1lbnQgZm9yIGFsd2F5cyBzcGVjaWZ5aW5nIGx5
bngtMjhnIGlzIHRoYXQgdGhlIHNlcmRlcyBibG9ja3MNCj4+IGRvIHNoYXJlIGEgY29tbW9uIHBy
b2dyYW1taW5nIG1vZGVsIGFuZCByZWdpc3RlciBkZWZpbml0aW9ucy4NCj4gSSB0aGluayB0aGlz
IGlzIHRoZSBzdGlja2luZyBwb2ludC4gVGhlIGJsb2NrcyBkbyBzaGFyZSBhIGNvbW1vbg0KPiBw
cm9ncmFtbWluZyBtb2RlbCwgYnV0IHRoYXQgbW9kZWwgZG9lcyBub3QgZ2l2ZSB1cyBhIHdheSB0
byBpZGVudGlmeSB0aGUNCj4gc3VwcG9ydGVkIHByb3RvY29scy4gWW91IGNhbiB0cnkgdG8gZW5h
YmxlIGEgcHJvdG9jb2wgY29udmVydGVyIHRoYXQNCj4gZG9lc24ndCBleGlzdCwgYW5kIHJlYWQg
YmFjayB0aGUgZW5hYmxlbWVudCBzdGF0dXMsIGFuZCB5b3UnbGwgZmluZCB0aGUNCj4gaGFyZHdh
cmUgcmVwb3J0cyBpdCB0byBiZSBlbmFibGVkIChmb3IgZXhhbXBsZSBQQ0NDW1NYR01JSUFfQ0ZH
XSkuDQoNCkluZGVlZC4NCg0KPg0KPiBUaGUgc25pcHBldCBiZWxvdyBpcyBzb21ldGhpbmcgeW91
IGNhbiB0cnkgb3V0IGFuZCBzZWUgZm9yIHlvdXJzZWxmIChpdA0KPiB3aWxsIG5lZWQgYWRhcHRh
dGlvbiBkZXBlbmRpbmcgb24ga2VybmVsIHJldmlzaW9uKS4NCj4NCj4gc3RhdGljIHZvaWQgbHlu
eF8yOGdfbGFuZV9wcm9iZV9zdXBwb3J0ZWQoc3RydWN0IGx5bnhfMjhnX2xhbmUgKmxhbmUpDQo+
IHsNCj4gCWVudW0gbHlueF9sYW5lX21vZGUgbGFuZV9tb2RlOw0KPiAJdW5zaWduZWQgbG9uZyBz
dXBwb3J0ZWQgPSAwOw0KPiAJaW50IGVycjsNCj4NCj4gCWZvciAobGFuZV9tb2RlID0gTEFORV9N
T0RFX1VOS05PV04gKyAxOyBsYW5lX21vZGUgPCBMQU5FX01PREVfTUFYOyBsYW5lX21vZGUrKykg
ew0KPiAJCXUzMiBvcmlnX3ZhbCwgdmFsOw0KPg0KPiAJCWVyciA9IGx5bnhfcGNjcl9yZWFkKGxh
bmUsIGxhbmVfbW9kZSwgJm9yaWdfdmFsKTsNCj4gCQlpZiAoZXJyKQ0KPiAJCQljb250aW51ZTsN
Cj4NCj4gCQl2YWwgPSBvcmlnX3ZhbDsNCj4NCj4gCQlzd2l0Y2ggKGxhbmVfbW9kZSkgew0KPiAJ
CWNhc2UgTEFORV9NT0RFXzEwMDBCQVNFS1g6DQo+IAkJCXZhbCB8PSBQQ0M4X1NHTUlJYV9LWDsN
Cj4gCQkJZmFsbHRocm91Z2g7DQo+IAkJY2FzZSBMQU5FX01PREVfMTAwMEJBU0VYX1NHTUlJOg0K
PiAJCQl2YWwgfD0gUENDOF9TR01JSWFfQ0ZHOw0KPiAJCQlicmVhazsNCj4gCQljYXNlIExBTkVf
TU9ERV8xMEdCQVNFUjoNCj4gCQljYXNlIExBTkVfTU9ERV8xMEdCQVNFS1I6DQo+IAkJCXZhbCB8
PSBQQ0NDX1NYR01JSW5fWEZJOw0KPiAJCQlmYWxsdGhyb3VnaDsNCj4gCQljYXNlIExBTkVfTU9E
RV9VU1hHTUlJOg0KPiAJCQl2YWwgfD0gUENDQ19TWEdNSUluX0NGRzsNCj4gCQkJYnJlYWs7DQo+
IAkJY2FzZSBMQU5FX01PREVfMjVHQkFTRVI6DQo+IAkJY2FzZSBMQU5FX01PREVfMjVHQkFTRUtS
Og0KPiAJCQl2YWwgfD0gUENDRF9FMjVHbl9DRkc7DQo+IAkJCWJyZWFrOw0KPiAJCWNhc2UgTEFO
RV9NT0RFXzQwR0JBU0VSX1hMQVVJOg0KPiAJCWNhc2UgTEFORV9NT0RFXzQwR0JBU0VLUjQ6DQo+
IAkJCXZhbCB8PSBQQ0NFX0U0MEduX0NGRzsNCj4gCQkJYnJlYWs7DQo+IAkJZGVmYXVsdDoNCj4g
CQkJYnJlYWs7DQo+IAkJfQ0KPg0KPiAJCWVyciA9IGx5bnhfcGNjcl93cml0ZShsYW5lLCBsYW5l
X21vZGUsIHZhbCk7DQo+IAkJaWYgKGVycikNCj4gCQkJY29udGludWU7DQo+DQo+IAkJZXJyID0g
bHlueF9wY2NyX3JlYWQobGFuZSwgbGFuZV9tb2RlLCAmdmFsKTsNCj4gCQlpZiAoZXJyKQ0KPiAJ
CQljb250aW51ZTsNCj4NCj4gCQlkZXZfaW5mbygmbGFuZS0+cGh5LT5kZXYsICJQcm90b2NvbCAl
ZDogUENDUiB3YXMgMHgleCwgaXMgMHgleFxuIiwNCj4gCQkJIGxhbmVfbW9kZSwgb3JpZ192YWws
IHZhbCk7DQo+DQo+IAkJc3dpdGNoIChsYW5lX21vZGUpIHsNCj4gCQljYXNlIExBTkVfTU9ERV8x
MDAwQkFTRUtYOg0KPiAJCQlpZiAodmFsICYgUENDOF9TR01JSWFfS1gpDQo+IAkJCQlzdXBwb3J0
ZWQgfD0gQklUKGxhbmVfbW9kZSk7DQo+IAkJCWZhbGx0aHJvdWdoOw0KPiAJCWNhc2UgTEFORV9N
T0RFXzEwMDBCQVNFWF9TR01JSToNCj4gCQkJaWYgKHZhbCAmIFBDQzhfU0dNSUlhX0NGRykNCj4g
CQkJCXN1cHBvcnRlZCB8PSBCSVQobGFuZV9tb2RlKTsNCj4gCQkJYnJlYWs7DQo+IAkJY2FzZSBM
QU5FX01PREVfMTBHQkFTRVI6DQo+IAkJY2FzZSBMQU5FX01PREVfMTBHQkFTRUtSOg0KPiAJCQlp
ZiAodmFsICYgUENDQ19TWEdNSUluX1hGSSkNCj4gCQkJCXN1cHBvcnRlZCB8PSBCSVQobGFuZV9t
b2RlKTsNCj4gCQkJZmFsbHRocm91Z2g7DQo+IAkJY2FzZSBMQU5FX01PREVfVVNYR01JSToNCj4g
CQkJaWYgKHZhbCAmIFBDQ0NfU1hHTUlJbl9DRkcpDQo+IAkJCQlzdXBwb3J0ZWQgfD0gQklUKGxh
bmVfbW9kZSk7DQo+IAkJCWJyZWFrOw0KPiAJCWNhc2UgTEFORV9NT0RFXzI1R0JBU0VSOg0KPiAJ
CWNhc2UgTEFORV9NT0RFXzI1R0JBU0VLUjoNCj4gCQkJaWYgKHZhbCAmIFBDQ0RfRTI1R25fQ0ZH
KQ0KPiAJCQkJc3VwcG9ydGVkIHw9IEJJVChsYW5lX21vZGUpOw0KPiAJCQlicmVhazsNCj4gCQlj
YXNlIExBTkVfTU9ERV80MEdCQVNFUl9YTEFVSToNCj4gCQljYXNlIExBTkVfTU9ERV80MEdCQVNF
S1I0Og0KPiAJCQlpZiAodmFsICYgUENDRV9FNDBHbl9DRkcpDQo+IAkJCQlzdXBwb3J0ZWQgfD0g
QklUKGxhbmVfbW9kZSk7DQo+IAkJCWJyZWFrOw0KPiAJCWRlZmF1bHQ6DQo+IAkJCWJyZWFrOw0K
PiAJCX0NCj4NCj4gCQlXQVJOX09OKGx5bnhfcGNjcl93cml0ZShsYW5lLCBsYW5lX21vZGUsIG9y
aWdfdmFsKSk7DQo+IAl9DQo+DQo+IAlkZXZfaW5mbygmbGFuZS0+cGh5LT5kZXYsICJMYW5lIHN1
cHBvcnRlZCBtb2RlczogMHglbHhcbiIsIHN1cHBvcnRlZCk7DQo+IH0NCkkgZGlkIHBsYXkgd2l0
aCB0aG9zZSBpbiB1LWJvb3QgdHJ5aW5nIHRvIGRlcml2ZSBkdCBkcG1hYyBub2RlIHN0YXR1cyBm
cm9tDQpwcm90b2NvbCBjb252ZXJ0ZXIgcmVnaXN0ZXJzIC4uLiAuLi4gLi4uDQo+IFRoZSBmYWN0
IHRoYXQgU2VyRGVzICMyIHdvcmtzIG9uIHRoZSBmc2wtbHgyMTYyYS1jbGVhcmZvZy5kdHMgaXMN
Cj4gYWNjaWRlbnRhbCBhbmQgZG9lc24ndCBjaGFuZ2UgdGhlIGZhY3QgdGhhdCBkZXNjcmliaW5n
IGl0IGFzDQo+ICJmc2wsbHlueC0yOGciIGlzIHdyb25nLg0KDQpJdCB3b3JrcyBiZWNhdXNlIG9u
bHkgdGhlIFNHTUlJIG1vZGVzIGFyZSB1c2VkIG9uIHRoYXQgYm9hcmQuDQoNCllvdSBjYW4gaG93
ZXZlciB1c2UgdGhpcyBhcmd1bWVudCB0byBkcm9wIGRyaXZlciBzdXBwb3J0IGZvciB0aGUNCmxv
bmUgZnNsLGx5bngtMjhnIGNvbXBhdGlibGUgc3RyaW5nLg0KDQo+IChvZiBjb3Vyc2UsIEkgc3Rh
bmQgY29ycmVjdGVkIGlmIHNvbWVvbmUgZmluZHMNCj4gYSB3YXkgdG8gZGV0ZXJtaW5lIHRoYXQg
MTBHYkUgaXMgdW5zdXBwb3J0ZWQgb24gc29tZSBsYW5lcyBiYXNlZCBvbiBqdXN0DQo+IHRoZSBw
cm9ncmFtbWluZyBtb2RlbCwgYnV0IEkgZG91YnQgaXQuKQ0KPg0KPiBUaGUgb25seSAzIHdheXMg
dG8gZmluZCB0aGUgbGlzdCBvZiBzdXBwb3J0ZWQgcHJvdG9jb2xzLCB0aGF0IGFyZSBrbm93bg0K
PiB0byBtZSB0byB3b3JrLCBhcmU6DQo+ICMxOiBsaXN0IHRoZW0gYWxsIGluIHRoZSBkZXZpY2Ug
dHJlZSAodGFsa2luZyBhYm91dCB0ZW5zLCBhbmQgdGhlIGxpc3QNCj4gICAgIGlzIGV2ZXItZXhw
YW5kaW5nIGFzIHRoZSBkcml2ZXIgZ2V0cyBtb3JlIGRldmVsb3BtZW50KS4gVGhpcyBpcyBieQ0K
PiAgICAgZmFyIHRoZSBtb3N0IGNvbXBsZXggYW5kIGRpZmZpY3VsdCB0byBtYWludGFpbiBzb2x1
dGlvbiBhbmQgbXkgbGVhc3QNCj4gICAgIHByZWZlcnJlZC4NCj4gIzI6IGhhcmRjb2RlIHRoZW0g
aW4gdGhlIGRyaXZlciwgYmFzZWQgb24gU2VyRGVzIGNvbXBhdGlibGUgc3RyaW5nICh0aGUNCj4g
ICAgIGN1cnJlbnQgcGF0Y2gsIG9yIHZhcmlhdGlvbnMpLiBUaGlzIGlzIG15IHByZWZlcnJlZCB2
YXJpYW50IGZvcg0KPiAgICAga2VlcGluZyB0aGUgZHQtYmluZGluZ3Mgc2ltcGxlIGFuZCB0aGUN
Cj4gIzM6IGxpa2UgIzIsIGJ1dCBkaXN0aW5ndWlzaCBiZXR3ZWVuIHR3byAiZnNsLGx5bngtMjhn
IiBpbnN0YW5jZXMgYmFzZWQNCj4gICAgIG9uIHRoZSAicmVnIiB2YWx1ZS4gVGhpcyBzaG91bGQg
d29yayBmaW5lLCBhcyBldmVyeSBTZXJEZXMgYmxvY2sNCj4gICAgIGluZGV4IGlzIGluc3RhdGlh
dGVkIGF0IGEgZml4ZWQgcGh5c2ljYWwgYWRkcmVzcyBpbiBldmVyeSBTb0MgKGJsb2NrDQo+ICAg
ICAjMTogMHgxZWEwMDAwLCAjMjogMHgxZWIwMDAwLCAjMzogMHgxZWMwMDAwKS4gSXQgc2hvdWxk
IGRpcmVjdGx5DQo+ICAgICBhZGRyZXNzIHlvdXIgb2JqZWN0aW9uLCBidXQ6DQo+ICAgICAtIGl0
IGFsc28gcmVxdWlyZXMgZHQtYmluZGluZ3MgbWFpbnRhaW5lcnMgYnV5LWluLg0KPiAgICAgLSB0
aGlzIG1ldGhvZCBjYW4gZGlzdGluZ3Vpc2ggZmVhdHVyZXMgb2YgU2VyRGVzIGkgZnJvbSBqLCBi
dXQgbm90DQo+ICAgICAgIGZyb20gU29DIEEgdnMgQi4gVGhlcmUgaXMgYW4gdXBjb21pbmcgTHlu
eCAxMEcgZHJpdmVyIHdoZXJlIHdlDQo+ICAgICAgIG5lZWQgdGhlIHBlci1Tb0MgY2FwYWJpbGl0
aWVzIGFzIHdlbGwsIGFuZCBpdCB3b3VsZCBiZSBnb29kIHRvDQo+ICAgICAgIGhhdmUgdGhlIHNh
bWUgb3ZlcmFsbCBkcml2ZXIgYW5kIGR0LWJpbmRpbmcgc3RydWN0dXJlIGZvciBib3RoLg0KIzQ6
IGJ5IGxpc3RpbmcgZGVzY3JpcHRpdmUgcGh5IHN1Yi1ub2RlcyB1bmRlciB0aGUgc2VyZGVzIGJs
b2NrcyByb290IG5vZGUuDQpQcmVzZW5jZSBpbmRpY2F0ZXMgd2hldGhlciBvciBub3QgYSBsYW5l
IGlzIGF2YWlsYWJsZSwNCndoaWxlIGVhY2ggbm9kZSBjYW4gc3BlY2lmeSB0aGUgbW9kZXMgaXQg
c3VwcG9ydHMuDQoNCk9idmlvdXNseSB0aGlzIGFsbG93cyB0aGUgZGV2aWNlLXRyZWUgYXV0aG9y
IHRvIGRlc2NyaWJlIGludmFsaWQgY29uZmlndXJhdGlvbnMuDQpCdXQgaXQgYXZvaWRzIGRlc2Ny
aWJpbmcgZWFjaCBjb21iaW5hdGlvbiBpbiB0aGUgZHJpdmVyLg0KDQo=

