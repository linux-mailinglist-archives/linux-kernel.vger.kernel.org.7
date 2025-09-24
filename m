Return-Path: <linux-kernel+bounces-830306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE74B995E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233491624B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BD2DC33B;
	Wed, 24 Sep 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="SikfIjct";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="SikfIjct"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020125.outbound.protection.outlook.com [52.101.84.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8242C235F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.125
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708590; cv=fail; b=b7JAetVgtJran3p52UHRXeickBVoRS28rgp7qg5ERXVELvXOeltXjhJ1Wa2+fmmzG6W5l5sblFE+xqVWIgF3aZW4xphRVH0Q2S7fp25GvE78SvvGRI0UmnabWxToUCWBOnh/vZO1qtzDDUJDuOTqJAKHplCWVcnN2brT+cmfh7k=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708590; c=relaxed/simple;
	bh=aINyYOty3fAAoIj1pQEeNs3BWO5qObPOVqkSuA8EFPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEESKfXg+rAlF1m0N274cwyVVGjvmxSOzI3BXkNZVDTLfcw+2rc0b4d0ltJ8moWdXoirHTkCFU0OOnyJ0E6vdtj6j9GU8z0zxuMXcb8d3YYWAOcDXBPek2Z1HE1yWkkmW8gJ2T8wAO0RfdctqueuR0w2srW9wpTtYdG0/gxPx8k=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=SikfIjct; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=SikfIjct; arc=fail smtp.client-ip=52.101.84.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bTcBeVW7wBK8eU/7QDu4dDnqW2fKaEW7dRpvOJWOkpzI4FUC5Xar8YR5Vd/QBJuEVGHsOLXSNsjpt5+fsB2LeN+Y9ZNnppS1N7pbJJpzMz5nVSMvJdJL51Goh2STNf8lWCah6PxSZ0Jdk0p4FaJFKq67m02IPkwz0haxkJTUXh0tez8fOAuSf4b8ztaqlhwLaWKYgT8JxbSmCPsD++UPfEqTC+yGQDNtExgjoqyyRrJxJk6pbW0TBveekxWrnz/f1ZZ9AbwvbprmKNRPA8M2uSAXKL0/hfTzUvzq+WPbYFUvx1ADGfAju90qgRgA6yvCiWaKyR1pMzUrdrTgCOgU2A==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aINyYOty3fAAoIj1pQEeNs3BWO5qObPOVqkSuA8EFPI=;
 b=HKnmwypwbtl22986ujeiX2ZdXJs2/zkaV/tsngJ8OVeUGYSCxjBPHyw/7U9oW1wcAkKKe5qRM+sr3o9z3RWFIgCZYXVXRBJMmJWWZWT9DdmcEvCcj+XNGTClf7Y/aqNRpbf+Fh4tagxeQPgOYUIEYhuek7AjPfaJvDL/PzOTCgdJHWCVfN1RlNiIrMtcsawcfNjzOzuPbfbNRmI57NADOTtUDIhERXCxQCgXTM/Ld3HcFcorV6CfuSXzdomRwPpXULoKClvDWBJzTSZ9r8ObJ+nrRDatuISML1aWhdZjrbP+QB4PDz++edxNitS9Wf/Mr4NKyiS2q+gbOlkCVtMGhg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aINyYOty3fAAoIj1pQEeNs3BWO5qObPOVqkSuA8EFPI=;
 b=SikfIjct2P9huT9qUFZsOP9L29J4sXlmvd612qDRKX7V9Bnuv545y5UFuLgR1Q9v4gktGp4H+60G8MSl1cmckgpZawjjkCF66f3B4B+zVoFIzDfMZk3z1x18Jb3Z47b4fxEx7QOMjEVDVoCYA+wsoy9/d6ZNzLTn81hs0V8eO0U=
Received: from AM8P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::28)
 by PA1PR04MB10890.eurprd04.prod.outlook.com (2603:10a6:102:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 10:09:41 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::65) by AM8P190CA0023.outlook.office365.com
 (2603:10a6:20b:219::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 10:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Wed, 24 Sep 2025 10:09:41 +0000
Received: from emails-7809669-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-76.eu-west-1.compute.internal [10.20.6.76])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 14AC3803D5;
	Wed, 24 Sep 2025 10:09:41 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1758708581; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=aINyYOty3fAAoIj1pQEeNs3BWO5qObPOVqkSuA8EFPI=;
 b=j+SGxhaOOVs1ojbSu5DREGmzjHA6GkjUJ6N4A1wC+LnZo5InqvROYtejxbiibdKgkAUaM
 FIS6brpMpV4TS//oQErh/wzYtbR9kdqso6RpmY16z91h0I3wujaQL00YJ90JzBX1h1+Y72h
 ZdIk4cPtPf6vnt/XUb+7QFDSHz/MYNw=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1758708581;
 b=keb4HLI594MZmf3c9PurB4nYdpDxZuFypr+jnmkvXJyK+OOO8LQNvWva0DKlfzRaIwB7Z
 zdVFQKtE7YZ5mUxMHhGh4QWeiwl1qEubJHLeQqy3sNoLmJ3KtHhoe4cVBS46IUkj2bX7/Zy
 6rmL0fnt7FhzshlvoNyoCCMrDfGacQI=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+jiJooSptZ6gLLurFfeMjE/cRzdS18XsUMAVetVZgrNdha3qCM4xvPuqzsA3OzqkWT/8jlvJMyLXPkDSPvrbz4ufocG1eMOqPAZ2yrKFpbnZOhszFZ2irZl5xwYMbcM6s7TCev0cJ5GRrLxKqFXRn6lAt6MDe59AcOUCGrLx9y5NkV1kcrbwVi38DNkFUTU77iqFR0Uv4VADsPUsJ8hWC9+SE2mqcPyt/cTn/4GayiONYHVFN63DntHVPz0o9USmuJyiav4XMNljyX0UkAlsgtaBm8qRxWsR5ZlsX3xMaeOGMO3nqSAEuaqSHB62AdrFsnJMEv3ifsfKkf79lNlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aINyYOty3fAAoIj1pQEeNs3BWO5qObPOVqkSuA8EFPI=;
 b=nJGIUKc5woHRlbyWybZQXhOp8iX1ORc6X9xWhaZb+7dtq6d9Hm5lH7z9ht+iPwql9qcoOfpeunZy0MWUYz/2pxp1jvIBiIbmnEsRhjPd2zerrD7bQqC/pkFsJc48QSe++oK5WHE9L6CPARbPgRWTCpQzVyxfECZ1pj50td5eN4bzNovA9nl1NgKusTUSLfDMgspUbSosESeF6rRMtr+e1pUqTKSg5QNOtzeDBaO2EyKthYVoCeVUlce/Xy2T/XCBniQNPiVheNVjp/TjxCMzUXqbRr0kJwkjaa4oRtHgKgYywcwC2ANeB96x8DLldnLiYVZBQftluUwx+VM785B41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aINyYOty3fAAoIj1pQEeNs3BWO5qObPOVqkSuA8EFPI=;
 b=SikfIjct2P9huT9qUFZsOP9L29J4sXlmvd612qDRKX7V9Bnuv545y5UFuLgR1Q9v4gktGp4H+60G8MSl1cmckgpZawjjkCF66f3B4B+zVoFIzDfMZk3z1x18Jb3Z47b4fxEx7QOMjEVDVoCYA+wsoy9/d6ZNzLTn81hs0V8eO0U=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI1PR04MB10026.eurprd04.prod.outlook.com (2603:10a6:800:1df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 10:09:27 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 10:09:27 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 phy 15/16] phy: lynx-28g: truly power the lanes up or
 down
Thread-Topic: [PATCH v2 phy 15/16] phy: lynx-28g: truly power the lanes up or
 down
Thread-Index: AQHcLMKfxh213jh6uEaWFmieGVJ7a7SiHRgA
Date: Wed, 24 Sep 2025 10:09:26 +0000
Message-ID: <e04dd32d-801b-4019-aa2f-95bf8973c566@solid-run.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
 <20250923194445.454442-16-vladimir.oltean@nxp.com>
In-Reply-To: <20250923194445.454442-16-vladimir.oltean@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|VI1PR04MB10026:EE_|AMS0EPF00000192:EE_|PA1PR04MB10890:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9e8139-7ffc-4c15-8e85-08ddfb527a5a
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eWgxNTRYNXJvTDFLT0NSSCt5Mlc1MElWU2dFU0Z4d1hSa0JFR2xEb1JlZWNZ?=
 =?utf-8?B?VjNab0ozbUk3ZHgzS2tDZmVITUUwT0U0VDFPc04xVXFjRXZDUEYrTktRM3FN?=
 =?utf-8?B?VWJVOEx6OTNOZXpFaE50cEVGVkVPNmZLeE1hekt4SlVtNTFTRXFKd245L0VU?=
 =?utf-8?B?Vy8yWVBOSllMbE0wcWlpbXNBaFYzdHg5VGIvVTVGSlp5N3c1NHhVVWNZU05F?=
 =?utf-8?B?Uk1MMTZIVFJLU2ZqZXV3VmxJdituRWZxd01zblh4d3JYd2VGS3VCaDNScEFu?=
 =?utf-8?B?a0IxSzk3VC95WFZ5OC9LZDZpVjFEN3JZYlVvUXgyVHZUYXFvcGhlWURCc0t6?=
 =?utf-8?B?MHdld2pEcWcram1xRHpQdy96cmpPL0NqTW1KYk5heHVZa1JaS2NtWSt2Y2Zt?=
 =?utf-8?B?VmxwVndoaVFUeEdrL1NTV3ZvR0RRQzhlV083Q1ZRRkNqTG1XdXAwS1lrck5O?=
 =?utf-8?B?cy85cXhrRlZpQXlOeU9qaWcwTG9SV0lwcHlxWVBwUXpnN0NLMjBiS3dyTmN3?=
 =?utf-8?B?RzI4bmczQkdGQWw5TnI4UVphMjE1OTJmTlYwUXBjVVhUOVBMRGdTUnMrcHlS?=
 =?utf-8?B?cmllbGJCd2lRYkRYR000Sy81RmVZRVorTE11SEVkVVBJc3habkh6bjI4SUxX?=
 =?utf-8?B?NFFnOWplaTNVVWNkM2Z6WG13VkpWcTdFSXVpejRoZFRyTGdwRmE3VVBtamdO?=
 =?utf-8?B?SVVKQzdlWVllQTFvRUxYZWNqcWw3TCtKYTVObCtrMmNTMWNBblJDZi9xdmVN?=
 =?utf-8?B?TXk5anlzUGpNVi9LRkJYdVkvblQzRVBpaWIxRzN0bk1uTnk0QTFnbmpybG4z?=
 =?utf-8?B?NHl3ajBNNHlXV3dab1I3U2VlcStTVi9HTzErcGEvaERnQ3hhUTM1aEI5TUZY?=
 =?utf-8?B?ZXBQZVViMS9LUnBwdUE1WkU2RjJ4eUIweURMMG85NG5EdGtPd2tWRC9Qc1Yv?=
 =?utf-8?B?Y2MvcGcwZVl6T0NDOFJGNytXdnBxTysvYzNONWRJdmFVaDZ2RFhUaG9UamJE?=
 =?utf-8?B?R3NQSXk3N25sTXd5a1ZmbGNFeEVDblk3dktqQXhpQVNWRFBoQ1JyQ1ZUMk9T?=
 =?utf-8?B?TStPZGZrdncyQzMvakxBeXZ4ZWZKVElqZlJycnJlQVl3S1FpOE5MVEdTWG9U?=
 =?utf-8?B?VVk3bWNYbzJrbGZXTjdEUDJqL3d3TTlHRU8rMFdjcHkvaUtJeEgxZXBUUTkx?=
 =?utf-8?B?NFlpZEJWaFl3a2NxOTBxOXptQnNxZ09HOGNmLytCRG55RG02L01Jc2kwVUJ4?=
 =?utf-8?B?cFdrRktBVExabVRaQmFXaGhXdHhOTi80alQvOSsvMG92WDMrcnNGREU2VkY4?=
 =?utf-8?B?aFRJM2I5enk5TmVmbjJFVmIwWkdBelRlc0JybW9aM2VRd0tHQU9OQTZoRXI5?=
 =?utf-8?B?RC90UnRsQmdaazUzdWx4MjdGcDRMVHFLci9oRWZTQW41d2FySVIySVVSeW9z?=
 =?utf-8?B?aHBib1N5MjNSUWhqMXZ4YVh1dnphcDlRVDZKQ3d4YStqbGNWWHNtdmx6YlBr?=
 =?utf-8?B?S20wTU1pSHdUdCtKdzh0ZGhEQ0ZwSkErT1N1V2h1NnAwenRubHJsdzl2V2R4?=
 =?utf-8?B?L1BwSzF4YitnK0MzVDFMK0tBZlJSREhGdkkvaTJDNGFrTGV5OCtiWEZpbWxl?=
 =?utf-8?B?MzhuL0NnamVlbVpUb0FqcWxrS045cGJDSnhtSXVMbHdjRmk3M0ZUYk0rcEo3?=
 =?utf-8?B?RERGOWhDNmxGdURkditqNEVOUm1iWXJ0Y0o2b0lTVmF1eFEzTitQMC8wY2RW?=
 =?utf-8?B?SEhSUzIrSXBmQW9Ed01vRjFpUnFtcU9jL2dzU1lrOCtHZlo1ZzhrZ2VUa2RX?=
 =?utf-8?B?YnQrRDJET3VsNGExZ1lQV0tOVG5mSVhhczV4WFptNXNQSEhOT0t2ejFUYzNr?=
 =?utf-8?B?K1BpU1VPZU90SFE4WGpQOEJjNGpkUG1NQUlqbUF6VFN6WHhoUThVb1owbW0y?=
 =?utf-8?Q?gP+pCrPRiKI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDDDCC764077354DBA42E19147465F81@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10026
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: c60f690a971a4c1698d3ead7977491b9:solidrun,office365_emails,sent,inline:d640f59c16670ba48aa2aa7a8b88689d
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	48776113-5df4-4f20-1227-08ddfb5271ac
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|82310400026|14060799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzNLTndYdWxWSTlRdUI5M2ZjYk5ZQ3JaWUlOeE1sMXc2RkhEVlJKK2ZjeTFE?=
 =?utf-8?B?ZmFyN3pock1ERkxwMitrZE1TYkF3Y1dZTUFIUkJCVlg0Z2M2L3V4MUFWRFVP?=
 =?utf-8?B?VmpTNkNCNCtqQzY4NEIwMzJwaUhiQlhqZ01raUlSTHpXY0pBYk10Vmp1aHpQ?=
 =?utf-8?B?WEQvdDFzQ0VJUWNHRnhvQmhBQXBOWGdzRDgxbk1SNWYvTGVmUXJQUExSQ2p1?=
 =?utf-8?B?M2hpQmNzL2F4dWxqdXh5OVhmU1BCaWxESHNWWkdYTWd0V1YxZVpNbjl4clNP?=
 =?utf-8?B?UFhhdGoyRGJjMWhvRTNsaUsrdHFSRXk1WmFVRDhjUGtNbzhkYUpLQURzN01O?=
 =?utf-8?B?YnkzMTRubnNwVCtBRGtmQUtvbThLQ0JIcTlTclBzQklWK3pJVG0xUkdqT1pX?=
 =?utf-8?B?dUg4dVRqZXd2TEhpNUFQRmtqRzZwVllObWJDa3duakp2eUU0SjdTNVNabzA1?=
 =?utf-8?B?MTFvcThsYVJlZDMvWDB0dFRFUmQrank0UlV2WmhQQWtINEFTVFR3NWIrdnQ5?=
 =?utf-8?B?dExUZi9QM1FZL2VHalI2cVUrK0NTTXNHemMrRXRwbFZwSCtTa1krZ0xObWlR?=
 =?utf-8?B?Ykg3dFJuQ1czVS82dzFWVnZab2pGOGlxVlU0V0txWEgzMmhPaGt6TVRNSmty?=
 =?utf-8?B?K3VDVGhCWHdic0tvdnRldnUrYVJlcXpGUWNONmMyS2szcGxJTHVyWFY3WWty?=
 =?utf-8?B?cXRkMEp3aGdOSEJ6N3VCRUpxRm5GQllIL0NlVS9KYm9ieWZsQkltYVF5S05W?=
 =?utf-8?B?N0FHUmgycCtKR1k0S3g5UmJ6V01mNEh0aDZzN3g4VEl0YWJFRE14ajdveko4?=
 =?utf-8?B?aThQSCs1b1BjUWExQ2FMN0g5RkF6bWxxMWVwVkxMMDJvdSthY2pNTzl0ZEtN?=
 =?utf-8?B?RnJFYkt2ZjZQMkoyajhpcXo0aWhBNmRTWElBVENlNE9rYXFKWWJYTkNKQjRD?=
 =?utf-8?B?UmU1YWdBR0JwamtIUFRqeUV4TEpmQ3luamd6Q2tzcXN5UjQxM0ZSc2FFUEZD?=
 =?utf-8?B?T052dFQwaS9LeXJKaUlVamtXT3dONDY3ZDFuMzJEOGQxUGFnM05hMkgxMHpV?=
 =?utf-8?B?YzR4UFFrYmRmUGJYNWtEL2x0TllwTTlWUjZCZUV3UVBnNGxHeUhiWDR2YU5C?=
 =?utf-8?B?VEErUWZhb2RCK2JEQVI0WE0zR0d4alZrVXphTzlZcWo5dG91ZUNvZkpiN3p5?=
 =?utf-8?B?SUYrMnJJUUZKZ25POFFMcG40SThIWXR0MVFWWS8yQ2krbEg1V01hRnMxa0Jl?=
 =?utf-8?B?dmdiNnoyOTBlaUFuam1sZnNNeGU4bVg3ZEZPMHdiZWxJa05zWjR1dE5hWUh2?=
 =?utf-8?B?QVlMS1IrWWVNTWp1U25jQVZEMjhrcDkrRVJJRWlibEM5NlhYL2UvU0lhUzIr?=
 =?utf-8?B?MEtXRWFRYmw1UEZIaWRneGVQeUNTamdha04xbzFWK2J4MUtNN252TXdRV2hY?=
 =?utf-8?B?bFY5Q2dJbHN4VGQ4TUdWaW16ejQyd0VQamZocmNHVlE5bXFJUDdkVFV5ZW8x?=
 =?utf-8?B?TVM3dlBuK3BuaVJoMzdKaGsxOG44amh5VFk4dUJQWHF6YURyYzA0TWVuSEt4?=
 =?utf-8?B?U3lveXBaNXpmNHJyZG9xZ0Z3RkZEVmprclhwcFFoQTc2b3VWa2lZdS9aZnJR?=
 =?utf-8?B?TS9GcFBLV2NoNGQ3YmhaTHdDRkpzOUlBdWl4eEFuL1FtRW1JMHgyUFZ1bW1C?=
 =?utf-8?B?cHpMSjQ4amJnOWRxZFZRakVnSHNFOTY3QUllUCt2VGhHWEZnb2JHeWM4bk55?=
 =?utf-8?B?N1FvQlhrS1JYby9MZjJuVkxoZGs5dExHRWpHMWVMUnJac25nY0FocDBTOFZn?=
 =?utf-8?B?VVBMdzhSQTVvbzgxUzgreWdFWTdjNU41dFZNcGswczlabnhvaFhTRnBIRXM3?=
 =?utf-8?B?aHB3YytENlNIbXZTK1FkV2ppYkFqOCtWazU1ODQxREhRM1FDVkorcE05SWVo?=
 =?utf-8?B?bGE3MlM2d2Y0OUhNa2k2YTVtdS8zVDhvQTd4b1l3aksvdDFYcFNuWXlpVnUx?=
 =?utf-8?B?eDYwcEFhd0FRPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(82310400026)(14060799003)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:09:41.4218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9e8139-7ffc-4c15-8e85-08ddfb527a5a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10890

QW0gMjMuMDkuMjUgdW0gMjE6NDQgc2NocmllYiBWbGFkaW1pciBPbHRlYW46DQo+IFRoZSBjdXJy
ZW50IHByb2NlZHVyZSBmb3IgcG93ZXJfb2ZmKCkgYW5kIHBvd2VyX29uKCkgaXMgdGhlIHNhbWUg
YXMgdGhlDQo+IG9uZSB1c2VkIGZvciBtYWpvciBsYW5lIHJlY29uZmlndXJhdGlvbiwgYWthIGhh
bHRpbmcuDQo+DQo+IEJ1dCBvbmUgd291bGQgZXhwZWN0IHRoYXQgYSBwb3dlcmVkIG9mZiBsYW5l
IGNhdXNlcyB0aGUgQ0RSIChjbG9jayBhbmQNCj4gZGF0YSByZWNvdmVyeSkgbG9vcCBvZiB0aGUg
bGluayBwYXJ0bmVyIHRvIGxvc2UgbG9jayBvbnRvIGl0cyBSWCBzdHJlYW0NCj4gKHdoaWNoIHN1
Z2dlc3RzIHRoZXJlIGFyZSBubyBsb25nZXIgYW55IGJpdCB0cmFuc2l0aW9ucyA9PiB0aGUgY2hh
bm5lbA0KPiBpcyBpbmFjdGl2ZSkuIEhvd2V2ZXIsIHRoaXMgZG9lcyBub3QgdGFrZSBwbGFjZSAo
dGhlIENEUiBsb2NrIGlzIHN0aWxsDQo+IHRoZXJlKSwgc28gYSBoYWx0ZWQgbGFuZSBpcyBzdGls
bCBhY3RpdmUuDQo+DQo+IEltcGxlbWVudCB0aGUgcHJvY2VkdXJlIG1lbnRpb25lZCBpbiB0aGUg
YmxvY2sgZ3VpZGUgZm9yIHBvd2VyaW5nIGRvd24NCj4gYSBsYW5lLCBhbmQgdGhlbiBiYWNrIG9u
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBu
eHAuY29tPg0KPiAtLS0NCj4gdjEtPnYyOiBzbGlnaHQgY29tbWl0IG1lc3NhZ2UgcmV3b3JkDQo+
DQo+ICBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1seW54LTI4Zy5jIHwgNzggKysrKysr
KysrKysrKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwg
MTggZGVsZXRpb25zKC0pDQpjdXQNCj4gK3N0YXRpYyBpbnQgbHlueF8yOGdfcG93ZXJfb2ZmKHN0
cnVjdCBwaHkgKnBoeSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbHlueF8yOGdfbGFuZSAqbGFuZSA9IHBo
eV9nZXRfZHJ2ZGF0YShwaHkpOw0KPiArCXUzMiB0cnN0Y3RsLCBycnN0Y3RsOw0KPiArDQo+ICsJ
aWYgKCFsYW5lLT5wb3dlcmVkX3VwKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCS8qIElzc3Vl
IGEgc3RvcCByZXF1ZXN0ICovDQo+ICsJbHlueF8yOGdfbGFuZV9ybXcobGFuZSwgTE5hVFJTVENU
TCwgTE5hVFJTVENUTF9TVFBfUkVRLA0KPiArCQkJICBMTmFUUlNUQ1RMX1NUUF9SRVEpOw0KPiAr
CWx5bnhfMjhnX2xhbmVfcm13KGxhbmUsIExOYVJSU1RDVEwsIExOYVJSU1RDVExfU1RQX1JFUSwN
Cj4gKwkJCSAgTE5hUlJTVENUTF9TVFBfUkVRKTsNCj4gKw0KPiArCS8qIFdhaXQgdW50aWwgdGhl
IHN0b3AgcHJvY2VzcyBpcyBjb21wbGV0ZSAqLw0KPiArCWRvIHsNCj4gKwkJdHJzdGN0bCA9IGx5
bnhfMjhnX2xhbmVfcmVhZChsYW5lLCBMTmFUUlNUQ1RMKTsNCj4gKwkJcnJzdGN0bCA9IGx5bnhf
MjhnX2xhbmVfcmVhZChsYW5lLCBMTmFSUlNUQ1RMKTsNCj4gKwl9IHdoaWxlICgodHJzdGN0bCAm
IExOYVRSU1RDVExfU1RQX1JFUSkgfHwNCj4gKwkJIChycnN0Y3RsICYgTE5hUlJTVENUTF9TVFBf
UkVRKSk7DQoNClVuYm91bmRlZCBsb29wLCBwZXJoYXBzIHVzZSB0aW1lb3V0Lg0KDQpUaGlzIGNh
biBmYWlsIG9uIHVuYmFsYW5jZWQgY2FsbHMgYXMgeW91IGRpc2NvdmVyZWQsDQpidXQgYWxzbyBl
LmcuIHdoZW4gYSBwbGwgaXMgdW5zdGFibGUuDQoNClNlZSBiZWxvdyBmb3Igd2hlbiB0aGlzIGNh
bWUgdXAgcHJldmlvdXNseToNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjE4
LWx5bngyOGctaW5maW5pdGUtbG9vcC12MS0xLTU5Y2M1Y2VmODM2N0Bzb2xpZC1ydW4uY29tLw0K
DQo=

