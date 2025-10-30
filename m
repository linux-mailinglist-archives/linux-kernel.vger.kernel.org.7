Return-Path: <linux-kernel+bounces-878520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B10C20DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DF03B1E16
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33436335B;
	Thu, 30 Oct 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Vm+j7TFe";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Vm+j7TFe"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023084.outbound.protection.outlook.com [52.101.83.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1E2609FC;
	Thu, 30 Oct 2025 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.84
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837412; cv=fail; b=X8tOGzDtZgcP9TJqtUKG4IFnpd53ToL5/32kkasE7DgsZeWqhW8bnXep68faRaPjmPws+RLKkPp2oEH8LjT3MXCGTFHN4ShT2yxuBBNrNW3rnunN2otMgNlgVHaQogmayQqn4x6P95nqodYU1gEO5CsqnxVoQqQarLB+k92HcUM=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837412; c=relaxed/simple;
	bh=yISBFgymCy2k+WqlelUETH06pMsbrNItVcobgks6z38=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bVPRErE/UTOJLru/5LTt8WGN+k4H8Tb5GNyBynB6aIVRhpzU4hTXmv4ZnUnkOC3Opew+GXYz6vbGPrJ2IFEMFaaqcVXyx2Sq6aWq9734CoXNK/0CFdxheprxibi+3N/+A1COF0VLBVM5JGi5NyjOY1VuZoMliSQhv2NLZNpL9hs=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Vm+j7TFe; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Vm+j7TFe; arc=fail smtp.client-ip=52.101.83.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u2e2Zq2EB0CmaQs0uTVYPOmDKE8yDQs0d2hr3AyPCGc47vRHWTcTMd6xe+8bAepylisAuBNKna6YaWTL7K0DiDM/uBPy3SXq9rvrMQMWcSj+6w05AIMNij5uscRjwgPuWjyEBEYTiqdgmTgucgOuw3nDj7Ri8eufhH7zpXQ9UzFGg8471CRa8s49OG0FPKt3OXNTBmShjOJgm6EmrxMoWIL5SZpZseGHfQcXOBQGZ1ICpPWbPAlxXlgo3jG1bdrKcCEJYY9cnD03PYvJgAa85w28UQyEKSM7JAK5VogW1+gmS98KXgqcEL1Yo2LWAkAikgadXN4A6qhzWvz3pZZwPA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWojVm+JsTGLGz+dGLlldhLAlYCNaTX7aN8JBaFnq9I=;
 b=W0EzbogbpTsIQlPIM6wD0iQEQUOSlG09EyKzJIJIIEo5Mt/7RdS3TwX7dkOCsrFhxR8V+3oQD0elrlA6daK+RHA2C+pUFAnvZXQTHDdHPDVhs7qzvkKuz72pv8TeUcHTFZzdOOJxOQTVUuIvwcfi/jy3FhvBCEMhSRY2YUl68z2EKFnNYc0QYY5arQi5zWvLXo5Xcj5nwtYwVhqHLTvs9FeojK+Dzy3QX0J7mRY3XxnUyoLoDU8Nq5PzgHu5jXu1F2g9O3gLNqfQ4vFQgO0IJBYUsxnMaFVaDukvplL79Q3kXXTMubCPbKDwByd4vpL7QUrLKyF2ZBo4Fiuyfonb/A==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWojVm+JsTGLGz+dGLlldhLAlYCNaTX7aN8JBaFnq9I=;
 b=Vm+j7TFemrnxqMQh/GMPAsm3uPtykcN0MIsGPLzKMyMb/oU/p5TpVsGAPrmzanq/ssY24YY4nPBLiZtRr8lpu76xxl9/UGnoztga7CtenEm5CBsmMVhQeBqEyIGQgJNUIy/qEdbYpMG8woWSuZqtEM35MznsQGc3mO8BFoM2Tbo=
Received: from AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:16:47 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:208:17c:cafe::e2) by AM0PR10CA0005.outlook.office365.com
 (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 15:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 15:16:47 +0000
Received: from emails-4428488-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-148.eu-west-1.compute.internal [10.20.6.148])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 02FC480777;
	Thu, 30 Oct 2025 15:16:47 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1761837406; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=dWojVm+JsTGLGz+dGLlldhLAlYCNaTX7aN8JBaFnq9I=;
 b=AJ0De+rCOW0yOrlpiJBM17J7zskH/6w3laRWbvrVAcgDyZQtwdt0VrdHEW4K1m9b/Tu+U
 9Lm7e7/S+j3brzct5oxzetpnz5bGAUgkLwwa92bCIB/mQz8p/3TQLjc/P2s5OJgk+BWIYka
 wXp0As8mDm6nNlWAOxJaxXdfBSZmuRc=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1761837406;
 b=CTVDh9fbFs95qAYbEcG472c3dA3x16xsCBCFau954hU0k7PBWmHef1ix1AT1/J/WsFdOd
 xl/HlUqZrWnEDuLmAZva3TUOVUHuVZoneIbG2WPDdtZaRazwocLDBUvQ6ScJcyAykxfwxQr
 mrP9DMwLKOG0XxvmHo6l1430iwbihhA=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/B2YFK2rPXz8NyEEqdHVHzZq32GnEBsJlpGG8zhfNnqBXhwd0koSOXhllcxuqLONe0Ngsh2gjXN7EkY+3PruTb0HjUwmBnHLW0FrV00Collub5+G8q6kCoOQkJtM11ktgaJ/hp9I9E9zD1XDZKg2X2UcxhyZvXkY9o7iV9vzGxktdftObua6QjP9K6tkH4znGNVjNjW37nVLyb0U6dD+ejNGvlojE9IxTsww3dhZgZ0EiP4LTX2l3N+875zPb3oJKksPgAbKTh7bD0UOmS8lCU2waHEmRK35ixB/B33/egkgrJy5oHCdkK8oECSADl+iKxxIjC1Di1moEQfEh6wGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWojVm+JsTGLGz+dGLlldhLAlYCNaTX7aN8JBaFnq9I=;
 b=sbYqykJdRiTTYuubF3ngxOAhBVC47nMmpKyv72MxswtSugKp6sYkaEqY9tQpy6ki8+/ARc0Nc5M31au0O08/Y6I4+5lHlvpOoNcpS9mnqZZKLUsZbRZlhxut7DIfJVjSN8X2C0Qmsa228zgjzn8P09SqJyr9LxFLZ8CjOLmRyXyX2jyl544YAm9YNqouFbfmzfBnuRhqcF0xWR0Izr3bC2Wnz1BVRj5F7oRtk3tMS8YcIvedQXx4WAq/HTiHCrRRzxYvZIyPXYUlJfcNwLUBEK2qYLH2ZuXg7gYPP9skq7MQPiTJdre7qhNsF6CZkBGy161zmypdE7teVFcrB6vKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWojVm+JsTGLGz+dGLlldhLAlYCNaTX7aN8JBaFnq9I=;
 b=Vm+j7TFemrnxqMQh/GMPAsm3uPtykcN0MIsGPLzKMyMb/oU/p5TpVsGAPrmzanq/ssY24YY4nPBLiZtRr8lpu76xxl9/UGnoztga7CtenEm5CBsmMVhQeBqEyIGQgJNUIy/qEdbYpMG8woWSuZqtEM35MznsQGc3mO8BFoM2Tbo=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 15:16:35 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 15:16:35 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 30 Oct 2025 16:16:25 +0100
Subject: [PATCH 1/2] Revert "arm64: dts: marvell: cn9132-clearfog: fix
 multi-lane pci x2 and x4 ports"
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-cn913x-pci-clk-v1-1-e034d5903df1@solid-run.com>
References: <20251030-cn913x-pci-clk-v1-0-e034d5903df1@solid-run.com>
In-Reply-To: <20251030-cn913x-pci-clk-v1-0-e034d5903df1@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB9280:EE_|AM4PEPF00027A62:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: e8564122-02d8-43f3-68ed-08de17c757d6
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Q0xhcXNhakdZYjlxNldyQXpkMzdaU2R5ZWlJNEt6Y1dJaUtsN1VoUVYvUkNp?=
 =?utf-8?B?b3VLTEVIQ3lRc1lvRFlnNUVneC9iWk5MSmIzaGtjaitwWDNXcEVIRUJpMUJQ?=
 =?utf-8?B?WmVpYVFtYjhobWozR0Jzbk95L25VdE80Tm0rSHZxdHY5TEVOUFVNOS9IVERL?=
 =?utf-8?B?dys2WmNMZzg5NFl1bUNheGpoUXN5dms2ejdYNUdUZ0E1VlNRWnR1TTlVaXhH?=
 =?utf-8?B?N05KQW8zNTdYaHBxaFJZS3lmSzE5TG5xUFpEQVJoeWNNaGNwQkRqOFVMR2p1?=
 =?utf-8?B?VC9IQVoyMi9PMGJSbDdyK1NiUWdRV3JBVDMzaFBRdE05akltZmphTWFHYjNy?=
 =?utf-8?B?d2hTbXNoV0pGMCs2eENNL0NOdUx6Z1J0bjVBMjVaT3JkaW5OZW1qbllvR1FZ?=
 =?utf-8?B?MFhERXUvR2s3MFNrT2VmbENFVHdLT2k1TkxGWk5xZnFubGwyMzB6bm1Ta04x?=
 =?utf-8?B?SXhBZWN3TkJEWmJ6UjVXVjlvb3dqSXRTc3VtUlZKL2R5WTNQdFZ2MVlxN3JH?=
 =?utf-8?B?bXJTWThjVlllcXdKcU1sQXBTemJQK3VwOUVucjBtSndSQ3hLODhDZWk0c3U0?=
 =?utf-8?B?ZUh2c3dqUEZPZ1Q4RVhMUy9QWjR6V3VvQ2gzek9IbUdTQVp0eTRWWDdrK3Nz?=
 =?utf-8?B?U2dSdURoVzJJcWx2dzhWZGp3NnZtdzJ6UHhCZDVMU20reDdmZTEvSHhxclNC?=
 =?utf-8?B?VmcyeStOd1VBZHdzQ09QYW1jMXV4cHI5MFdmcGM0cjFvSG03a3M2NmNiSUxV?=
 =?utf-8?B?Q1dnWGY2d2xQc3hmQWs0TG1KVDNwdyt6YU4rYzA2ZW1xWDlvQVQ3djN3L2sv?=
 =?utf-8?B?L1ZKdGpUNElpTXhhMklJR0k1c0FSa1RxVnptT2YwM0VmaFlvZW9jUzdESFcx?=
 =?utf-8?B?ejFGKzhweWVmamRhWEM5M0FQend0ck1IdEJTT1g4ZnlVRUJzWnJUSnlpaHJ0?=
 =?utf-8?B?MmYweTZoQmFvRmxhN2ZtVFVMbnVkWVBYUWJqbDdhZEFGRVRER2R3Tmh4Wndj?=
 =?utf-8?B?N3gya0hoai9EY3pWdnhTdlVLLy9tSVUvWW83Mjh1bjdQUEYzSmo5WEIrNHRI?=
 =?utf-8?B?dHQwMWl3SlZ2Q2g2dXJoY1N6NFlwWjJnSEtZUmR0dmFzM25TZVN0a2ZXdmU0?=
 =?utf-8?B?UXF6N2ZNQm9FQ0hha3JtUEcva0x4Y3ZwbjZsTWlsd0laVEZqQzgxc3VIKzRK?=
 =?utf-8?B?dTAxNXU2cjZSakczaE9DeFU1b1pMRVNONlR1Ti9oZjlKSzhPYlpJbk1GUkZr?=
 =?utf-8?B?S2JYcTF5L014NFFJMlJJQTZuSXZiQk91cnhLOVIwNlNHZHRMVW1XU3lyeitF?=
 =?utf-8?B?SWU3WkM4ajhKN2xVMWJLa0R0cXhPZnBwdnllNFZucmxOSXRjaElPL1JxUVlw?=
 =?utf-8?B?bm9uWGl6UkxqMVhrUHpmOUlpUDhqakk5aTlUczdxcTZqcDZrWGhCamx3b3NW?=
 =?utf-8?B?TjJFdnFhYThFY0lXU0VHc1o3QkRVNU10bTE4UzVib3BTYlZRREVxQmdiTzA3?=
 =?utf-8?B?WjY2VmVZUktoV2RucHZ6SkYvZldvZXRvRmtBVDNrcmJQZjVKMU5mTW1YRmdN?=
 =?utf-8?B?cURJTWZaKzRsYlNtNUIyaTBQMlBPRlNJZzhLc3Avd3dsSmNSZ3JFVXIrbXM1?=
 =?utf-8?B?VkNHVzZIelUxRjN6d2xYQ0NMQml0eG5tNll4SWh0Wk10RkNwN3JBeHF3SmF0?=
 =?utf-8?B?SnU5VDZXbnhwRG9OWVZiWXZjaTArOWxmaXVYQk9tc0ZScjVyTjhXZFdQMERz?=
 =?utf-8?B?U3k1VUhYNmN5VW1MOTZSVHkxc3d6cGdRS29qbUJORDJMcEZhNjJxV1hVWDJK?=
 =?utf-8?B?UzdsR0x0cTcwTGVxRnBhOVdrKzh6YjVwbnh0Q2ZyNFBYWUtwUnd1M3pTeXZY?=
 =?utf-8?B?Q1lsei9wbWprQjdwYmJSMmlTeW9McEh1b04zK2pqMENyRkVRamtuVFdZbXRK?=
 =?utf-8?B?TmIzOEEzZmJ2amRzS0NmMDhYVWN4KzJScVA3U3JjMmZPY05CbmhkaTZXM1hL?=
 =?utf-8?B?akg2YnZWcFNqSFc0elF0aUk1WUcvWnNNWStPZDd1ZG9kSFBWajYvdmUzWG51?=
 =?utf-8?Q?Xdz9rK?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: fa73c921caf14255aa11e22ccc7700ed:solidrun,office365_emails,sent,inline:4dfface508d283f6e9253e75a0eee328
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e7bf91e0-2f45-460e-3064-08de17c75095
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGFCeE9GZ1dDc2dDM1l2bDkvdTdnL3F4WXVuMHVvd1FtaU1VUFJLK2x3Wjdi?=
 =?utf-8?B?TFEvSnA3bnZncHdnU0Rtek9jQ3doemE1UUZkMzU3dnp6cmI4c1BkdkgwN015?=
 =?utf-8?B?T0ZETVdQWEJULy9td3N4ODU0OEpqMVd0dkp5TzhsMnVmN2xTbnVUU0pNaHZO?=
 =?utf-8?B?WnNXTXlQMzFkdTd5UTdBd2hiNkppMG02NTVLaitWYmlYMnZpcFJVY1lPcjU2?=
 =?utf-8?B?NFFIWFJPUE4yejJYY1NrYlplaFh1Z0RVT0JtdFpyV3EyL0xBVmQyZzJEYkJX?=
 =?utf-8?B?TUorcFU3MWRYcndkOWFLN1BvYmttVDdZalJDejRYSmR5THVZd0toUk1yeVM2?=
 =?utf-8?B?WnZiMUEwZjRiVFFMK05tckVSU2pUYjhNOFhNakQ0UzFkNk1zWmVCL3IzcUc3?=
 =?utf-8?B?eW1aakNSYU96VU9meTh0VUV3SDJKcXQwbzY5NGdrY0FFY0w3M2c4ZDhlVG1D?=
 =?utf-8?B?cFhIeGRpOWVYNXZCaTJVdi9sbzNES1hrZ1E5bWtya0FjdlFGM0t5NjNIWVJ6?=
 =?utf-8?B?QXhadmh0UDJVbnVBSStTK3FmODZDQldBUmpRdDFVTnpGekhXc1ord3ZBU0lK?=
 =?utf-8?B?WVE3VTJnRmw3TWl5YmljYWZqWThNMUd2NFJWY2FEUit5bGZxZkJTeStuMEVj?=
 =?utf-8?B?cHJHZHlENGhqSmFrZ213dmFYdiswbHpjdThMVHNPLzkyL01kamd0Uk9lTElj?=
 =?utf-8?B?TTh0bk1yVEEvSDdpbEllNWwrTTAxQS83TWZtdjZYRzVPMEs1T05SZHhUQzRm?=
 =?utf-8?B?NTBMS09HSEIxckRIcjVzQkErQ0I1QXBGcmtKRUduNjU0bmk2RXp0SHdqYTNT?=
 =?utf-8?B?VWZUcUo5VXIxTndjdndFY0lJbUpTa3B3bndOZnBsaXdHRDkzRGdTYmM2TmtL?=
 =?utf-8?B?NzJVMjBsZzlnaksrNmpXcmV0ZUNoeUJIQ2VFSWFrQTZyOUxkZ3JDYk1jS05Z?=
 =?utf-8?B?VzFxU3J0cW0yVnVRaGY0c2FBVFRDMkdDc3lpbjQwazBmZXBpRXZ2a2I5ekZB?=
 =?utf-8?B?WHZPUXFPZ3BWdWx3YkhFVU8rSEYva0UrK3RkOTArVXNTWDR0SnIvcHppLzVq?=
 =?utf-8?B?S0tZNVEzcFR1R0s1cEgwd2RaUE5tTGlVUEE1WkRrM1FwbTZmZy9IKzZDZFdu?=
 =?utf-8?B?T3N3WkdYaExybjFzYnpiVGExVVRxemZCSVZHODRoNUhKV3JrSEVFa08yb1dH?=
 =?utf-8?B?aW1FZDFrRVBrNXEzTUk2R01NbjBZRzNDUlVqTWlKTGhKVDlzMGN4RWRGK0tq?=
 =?utf-8?B?NTB0dTZibUZQT2hqSFNCS0FJOGhzTkFRZ3hkMWRoMzlVRlM2REJwdUtoY3VR?=
 =?utf-8?B?ZFFYM1NIem8vcEo0YW9KQlBwVUs4emNMajhqc3E4bkdVS0RQZnF1WkFPblcz?=
 =?utf-8?B?dVgzZWpJNEdOMDB0YkpFSG94OE1Hc0lOQWFackJGVDNzOXVBcW1ZZ0RPd3F1?=
 =?utf-8?B?R1RiT1BqMUZGNmN1V0c2U3dveVZJOGdnNEVpVk8vVW05cC8yZWtsaVFmZ3k3?=
 =?utf-8?B?TnF6Uks2RHQ0VjVxSlZCRGgyc3lwRzhhQ2dDTlFBYVQvQ3lGeHNXRmhQVGhD?=
 =?utf-8?B?OUhHalVYZVVFZXFQcjVHNnJiRWZacFczL0ZRSElPc0ZMYUlORWtDSFBSQkZG?=
 =?utf-8?B?S1czWTNyS3l0SjU1Q1pwSDBUMGFYdVNhWi8ycWEzMmZIc3ZUc2pvVlIvY3h4?=
 =?utf-8?B?OWJlRXo4UEhtZlBDelE0ek9Bb05kWE9TRU5QcDNoL05vaXdSUkwwS3dibEx2?=
 =?utf-8?B?bWNzYXNGbDZRdEpET0IwdE5VOTJoU25vVlhyMlVkZFpwYmxpZTRkeS9ET1I3?=
 =?utf-8?B?QlFZMDNHUHhrbUxKUCtUTkxnLzZIRmRmcnp2UWRJUHlBVnhSZjB4RDFCVmVX?=
 =?utf-8?B?V2RwUmpJUGVuSVBSZGU5blBncklCSkkxOUJkL3Z3aThOZm8xekZHWU5xVFJF?=
 =?utf-8?B?Y21SR0NNbXJYOVZ1bWpkM2U5Y0R1d0phcER4VXFNcEFqVThaOHB6YjJod1Ri?=
 =?utf-8?B?eHNNK04rVW5JcU1TRFRWakhubm5Tbm9ZaU8vNmN4OE1yNW1WUGVUZ08ycWNj?=
 =?utf-8?B?VlhWVS9iaHRBZVlIRk1rTk1lMWVsUEdiRFlQNExqaVczSW5JRzBnVTRyTHRt?=
 =?utf-8?Q?qyME=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:16:47.2058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8564122-02d8-43f3-68ed-08de17c757d6
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

This reverts commit 794a066688038df46c01e177cc6faebded0acba4 because it
misunderstood interworking between arm trusted firmware and the common
phy driver, and does not consistently resolve the issue it was intended
to address.

Further diagnostics have revealed the root cause for the reported system
lock-up in a race condition between pci driver probe and clock core
disabling unused clocks.

Revert the wrong change restoring driver control over all pci lanes.
As a temporary workaround for the original issue, users can boot with
"clk_ignore_unused".

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
index 5cf83d8ca1f59..2507896d58f9b 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -413,13 +413,7 @@ fixed-link {
 /* SRDS #0,#1,#2,#3 - PCIe */
 &cp0_pcie0 {
 	num-lanes = <4>;
-	/*
-	 * The mvebu-comphy driver does not currently know how to pass correct
-	 * lane-count to ATF while configuring the serdes lanes.
-	 * Rely on bootloader configuration only.
-	 *
-	 * phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
-	 */
+	phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
 	status = "okay";
 };
 
@@ -481,13 +475,7 @@ &cp1_eth0 {
 /* SRDS #0,#1 - PCIe */
 &cp1_pcie0 {
 	num-lanes = <2>;
-	/*
-	 * The mvebu-comphy driver does not currently know how to pass correct
-	 * lane-count to ATF while configuring the serdes lanes.
-	 * Rely on bootloader configuration only.
-	 *
-	 * phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
-	 */
+	phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
 	status = "okay";
 };
 

-- 
2.51.0


