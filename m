Return-Path: <linux-kernel+bounces-803126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916EB45ACB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F6C7BFCA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D50371EA6;
	Fri,  5 Sep 2025 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bjYYCNpv";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bjYYCNpv"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023109.outbound.protection.outlook.com [52.101.83.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A636CE1D;
	Fri,  5 Sep 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.109
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083495; cv=fail; b=gpCKozARDl7EF8rt5worosCMfCaE8lbg8X6e9QB+w3rJCQ/Woa0OvOnSQfbNsNQH7+fNzTgGo9iosrGYc/tufMrGWOsjsv/5uewF/g3lDncUXWLKZmRmA8C/vyfIU8EhDyuZcjYLrePUBGY9X0i8FJzSrVevB8Kb0kjkceB5pg4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083495; c=relaxed/simple;
	bh=Qs7qOiSUeVOB8IMpFDaZEKDl31v3BiLQtAuHjzvo3qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QON9EplpjT/NoHZjVlW/vvhKhfcZ98r4mO3+evyf6BGn68SRJzFfk++V7ljiFLvxp7MOTMvrAOy1usKqON1UliZF0syC7YOUBB6g6pai5rcI9StDoqvWAuU22y8VWbJ7xGc/ubasxrddobYncnWkjWUAW6J1B7X+Oe/uLmW/+cA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bjYYCNpv; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bjYYCNpv; arc=fail smtp.client-ip=52.101.83.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=K0jbWUmbYfdTfD6DjmVvGWb9yV1fp1FnzlPaVmXo7FP6vSetBYJ2xUsZW2UDTlVoldy4oIfCymYXeRDKPKDluUBEa6cBz354jNVDgzFh9sv5bd3VneEa9dZsPHAIE2nXFWsOQp2L8IBMAnNSZfeNETW8of6dMI/Mhr6ddRWOlR6NxDVHlY2LwJfpmAUjQFpGkzyTVZwe+F9wVuFjVetB4q4dTmAORAnk+9uD1Zp2LPHxqhAZJ2bavk44ICTbrKud3MgoiTxRDsbMXewOS208PFuBCc7aqqPTNyiIUb1s3ie7xvBkOq0LP6DEp8e1D3hX1OxqnuKfhyarek5gKjv9Cw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs7qOiSUeVOB8IMpFDaZEKDl31v3BiLQtAuHjzvo3qg=;
 b=McNaJXsizXJEoEZij2Z766JyW0FR49HJGmmphLNFYE86COg5TOpjdnd1JMVljAziV+sksv++iFM7R0HRTR6nlEzI99aAMlwmbEeRtYVa9nY7mx61JgxmcDtRj5X7d23dItsCxN0xlyw2QhZnnrm9+TUoY6dGItO8e61NcABRv9S3cKqHBJEtk4MpC2Rgu1xVASSEFGzMjRkw7vI51iG6x7Ic+FKwfUHG2lPAPWTpWLOPnzf5cQZVjOXH2dIItx2/ua/MBgnYGZ2Cw6zJwOTZmGvTcK0qiOZNoJKf3Xy5V8Qvu2U6z0Ofe936gTCB402/b1c4VpYsYvMo4NYei4kezQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs7qOiSUeVOB8IMpFDaZEKDl31v3BiLQtAuHjzvo3qg=;
 b=bjYYCNpvd8ULnfXSjvrMsyQgN2e35pC7lvFSAn6mGEBggFI4U4ZDPyuuG0bxK8Il0hNRqNSpXGSxVCojNEuMdggEtOpjBTrOyJC7b3S8k8OjvUL+sjjf+nqHq3wm8T9VB5jFUQZK0Mrx28X27gVM7HE40MoAen3wJi/ksssqHVM=
Received: from DB3PR06CA0003.eurprd06.prod.outlook.com (2603:10a6:8:1::16) by
 VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.16; Fri, 5 Sep 2025 14:44:48 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::83) by DB3PR06CA0003.outlook.office365.com
 (2603:10a6:8:1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Fri,
 5 Sep 2025 14:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14 via
 Frontend Transport; Fri, 5 Sep 2025 14:44:47 +0000
Received: from emails-1872557-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-124.eu-west-1.compute.internal [10.20.6.124])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 856C780A11;
	Fri,  5 Sep 2025 14:44:47 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757083487; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Qs7qOiSUeVOB8IMpFDaZEKDl31v3BiLQtAuHjzvo3qg=;
 b=c2Tg2cyaLmTr7jLhcP9JePSZtlnXQp58h3uqpcN8Zbi7uiP7uuwu6ul2nKBcS1JgVAPfT
 iY1DglW2tI7AigJjI3FpYBiHnc0tzYSDaII30aebH8KVPbcDQt/yoZ0HalFIbXi8H/596lh
 tXby57+asbQ2HRhbAtqRjdGa/bn11to=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757083487;
 b=bVfXtDVT8vh/WDwPL2/B+qu9WFVbogIDWjPK+OVR4mAgCdI5DaWFv3n04siRldXAqJraX
 YTy3iAf82NmqL6/JdaERNvapztNWDouKnOt/HOVtnlYwDqFqhn9j+NfLPdj+H7t2ImOSzcu
 UHvkFLo7aj7TvvG2ZJCF0KCvcOUw6Q0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCS//G33PJze7wGPO0w7pxWdUGWR6FRgV30Io9Zpk9TvT3QktVmFjSQ/7CYMKfYxO9VsGrr8tNA69grrlV+ututNTYqeLsdK3kX22+wFoaTs7t+mefQOHj1R6Z/rcFk1GoCaspPhyZfpDhTimriRNX74Ed6SOO9lBq7jUvOm8/sKMuttGEW2GRuAIvtrsKzWia+XTaQPTtYPr1QPTjdlCuceWq9mzyiMeCZJ8vOyDOpHw3315fCQqWFvVSBNQuLjtQBlD/CBFPnqS26bUXM6oijc+O2x6FCWQYJ469dV0THAyxtkK39TUG8GxCU8HF1wOOUJlIe1QVgOMlUegpVSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs7qOiSUeVOB8IMpFDaZEKDl31v3BiLQtAuHjzvo3qg=;
 b=HrLUj1h+L6Q387SWDtnch3S28La8t+gBh3k3nTZx++WJ2G9S0tp9Gk+oEN8tfG+PW9Hec6ktVW9WZ97g2hRqmD7RaNCZdwxaLlq05mzs2sFidvmeQtH0cogYM4ro3pddGMFgXOCf/OIJ90l8bhFaQgRmyhBo3Qc/TNj2r/1MzczRM23nxZMjJ+HrienUP7adYa5hiRcjw63x+G968Ymean7DuW8X8i1PqyIIL2hNy+5oXzo4RspIwDz01Yb5lSxX5G/PzdKVAzklSTxfc2srgiTzuNI7yv72TXmYdZldXmC5eRSvlxfNsBhZcHaiSFEUw9KBzXM5KRInoSoKE/jfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs7qOiSUeVOB8IMpFDaZEKDl31v3BiLQtAuHjzvo3qg=;
 b=bjYYCNpvd8ULnfXSjvrMsyQgN2e35pC7lvFSAn6mGEBggFI4U4ZDPyuuG0bxK8Il0hNRqNSpXGSxVCojNEuMdggEtOpjBTrOyJC7b3S8k8OjvUL+sjjf+nqHq3wm8T9VB5jFUQZK0Mrx28X27gVM7HE40MoAen3wJi/ksssqHVM=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV1PR04MB9152.eurprd04.prod.outlook.com (2603:10a6:150:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 14:44:33 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 14:44:33 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Conor Dooley <conor@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Topic: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Index: AQHcHlLIJtm9dj7MPUeeCk+9PJYwF7SEbteAgAAHkICAAC5fgIAABcIA
Date: Fri, 5 Sep 2025 14:44:33 +0000
Message-ID: <27f64133-729b-448c-96ce-771716485786@solid-run.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250904-molar-prune-4d3420b1bcb4@spud>
 <20250905104921.7grpgloevlifa3kj@skbuf>
 <8bbbf34e-ff9a-481e-a45e-26cde7d8f6bc@solid-run.com>
 <20250905113757.pmumjdnbd52jxw6o@skbuf>
 <02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com>
In-Reply-To: <02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|GV1PR04MB9152:EE_|DU2PEPF0001E9C4:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 008d45bf-2e43-40ab-fbe7-08ddec8ac2f7
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NlFYb2FxYkgrdEdiYWVBRnBCaUdCRnlVTXpOTWNLNnc1dnBVRUNHSkpIbDA1?=
 =?utf-8?B?ZEp4UDMyQk1rQ21RMEFObHNhYXRjU2FybVE0VE0xbWhTSkd4dTNxTXVMS3BW?=
 =?utf-8?B?ZWZGZmEvNWx4QTlud21CVVVIRlVRUHllSVV0U2VPWEhJKzlJWW9pbUM4VWNu?=
 =?utf-8?B?dmRIeEliSDd0SWtmVTdyTmxlbWpDT0M1aEd0OVpMTzZBMVBnT1lGM3pHUEpP?=
 =?utf-8?B?Q2Jwc1BuMzdXR3JOcUFwZjNuTUo3N0NORzNWQUpyKzVtVkltTkdLaUpCOE51?=
 =?utf-8?B?MmoxRGZUTlMwbzh6ZnBQaEd5VGhKaEMwVHlxWGJtK3U4SnlGTFM2cHArQ0ty?=
 =?utf-8?B?TG9BNytpcXZ4a1A5dWZPZm8yMkFkWHJuSm5mb3FzZnFlTVJNUmYwSUY4K09o?=
 =?utf-8?B?djYvTHdNdm9mQXI1Y1FOaXBiYjRVU2xvQjN4UVF0ZjBwelJ3VU42Zm16RWtz?=
 =?utf-8?B?cjhlWkFtemh6Y2JSQ1RzUjJ0WGg3b1pzUGM0RkRtQmlFSkYwa29QRExRR3Fv?=
 =?utf-8?B?WU5HWDlrekVob25MdjZpdU1uK1NoL0cwYzVBQ1BaRy9IaENYWENUMXJBakth?=
 =?utf-8?B?R1p0NFhIaFU4b3lUeVVZdUduRnFQZUZNQjVZQy9DUy9kTXNPYjZ1VnhyQkVk?=
 =?utf-8?B?N1EwQWxuU0pyMEhTTUFHdzFjOC9vUnkyQkV6RlVJeHdiTmRNSThvNEs1ZnFu?=
 =?utf-8?B?M0tFMG8vcWtsU0Vya0Q4eXFrMWlPY3N1Q0Q1NldUc3JHQzhVemMxOWYrb3RC?=
 =?utf-8?B?dytkRG5XRHVMazErRm5oaGZiUzB0Y0xQWTNHOW5WOEpZdUl5ZS84dG55NDZD?=
 =?utf-8?B?TXU3MVZRVW1BblRldjNFaHlXWGMweW1HVC9URXFXUTJ1SWYrZ21pMElEQXdl?=
 =?utf-8?B?dVNlVktjOTJicEJRZGgyc08yTkR4OEp6Ym1iWkZyNlRValY0L2p4VzUvSllO?=
 =?utf-8?B?VWUxVHhleDJoNi82cElYemNLZmRESk9WTkZMZnJDMnJrUzdwQlYrM3lTTStK?=
 =?utf-8?B?N0ExbzgwK2M3YW8vUGNocTJtdlBrSlVxR0lNVCtzR21nUmNEU2dDR1U5VE1H?=
 =?utf-8?B?MjNrN0F4NWN2Sk5MelEyOUFvbjVjbFYyQWRyUkFXVFJlUzZPNVVCVlBZeVFr?=
 =?utf-8?B?SmpQVGJ1bHc5VVQxaDd3R1VXSGFmZURROFBHQmE2NEh3UUxSdW5QVnNQNkd6?=
 =?utf-8?B?cnFvU0g3V2dYYkIwY25JWmRHUEs4YmwzUWl0Sk90dEltMmZoSHI3NDhzUk1l?=
 =?utf-8?B?d2lxSVQ1OVVEM3lFQzhJYWtjWmgxbk9MYVRQWUtPQlhJQmdHWEFuQmQwZDVK?=
 =?utf-8?B?ZlpDcmhPKzhzZEpWWVI2Z3VwQmxpK2J4RENuWmlCaUdGQzAxZGpzdzlENHRr?=
 =?utf-8?B?bEp3Y013VHFCWEx6ZUhjVjJQRVd0dFNMQU1WbUs0Y1cwYVNJWWwyS1J4Qm5n?=
 =?utf-8?B?MTZpcTFDTWkzMFVsenpDTHp4TnFseVU0alRESUtXL3hNWHlrWDhXYTJjNHhv?=
 =?utf-8?B?TUk4V3NiM25wR1Q3T3BiZzdiK09nVlArYzExMDUxd1NkeWhPUmYvbVJldkxI?=
 =?utf-8?B?YUdGVEVxM2h3YkFLL3BEa0E0T2hsajl2MmJzQnhPOHRHYm1rZUd4c21hWEdq?=
 =?utf-8?B?b2crTUZmQlp2bnBSS0h1ZnVGcXR1NmVKWnhucTl2bDBib2pZSkZLYWJYc1pM?=
 =?utf-8?B?VUlRV2lNQVBSME1XM1JyY21iSjRVUmtZUFZ1RUpIL0ZFd0pLaUY5YjZwOHBH?=
 =?utf-8?B?WjB2ME5WRDduMnJPaHdYREI1VHdTaTFCdGxtelhBM2RBTkdibDhHMDhmRC9r?=
 =?utf-8?B?S1YrM083bW1OdFh1bGFvNnl4TDRqNTZJejIvcHF3SUlTMnhLTzVFK0hvKzlh?=
 =?utf-8?B?a0NYZ3g0UEFTSENMZlM0MFlHNEpJSmI5WEJHanFGazIwTnlTcitzWmF4c3o1?=
 =?utf-8?B?U3c3a1d2bnpWN1ZIaHQ1ZVpRbjM4M2UyZW4ra05YMkpSQzZpRjhhYXBkcGg5?=
 =?utf-8?B?QzNwU1N3M053PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <64CDF3DF1AEA4B49A554001CC024F7CA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9152
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 0ea1811585c44c33b8ca466bf495ed76:solidrun,office365_emails,sent,inline:0346c0e52b01d855d83c1b7ecef118bc
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c298377d-44a0-42ef-b5a5-08ddec8aba54
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|14060799003|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmR1VnJLY0d0Z0ZxTThGcVQ1WVFDaXkyWXE5bHk0SHNjdDA1ejI2Y3hMYXM4?=
 =?utf-8?B?MG1nQ1dXL1dZM0R4R3F3ay9RUGhvdGQxNjdJQzk0QndPOTVJT1VvcTVVR3Av?=
 =?utf-8?B?QU1qR1VSQWxYQzhIOHZiVUhiUFJmOE1xMmFZWTZzYitSMnlEcjdWRGVQR2xD?=
 =?utf-8?B?Rm1Lbm1oNWFnNHhoNlo2VWtZbzUyNG9pM0luUjJ3aUFDZVQzSW43TlRKQk12?=
 =?utf-8?B?M1V1RFlTeWJ0eXZlaklmemdqTFdCR1lBb3pxNFRLVGZLTDlHU29Ic1VURnRx?=
 =?utf-8?B?R3ZXdnNzWmM3SzRYZnpBUDBNTlZ5a0swVW5HZVRLdmdmL1Vrd1k5dGlKdTl3?=
 =?utf-8?B?T0NDQjhBN0F1R2dHaWVNSC9EVXRiMGp5N1RtMk92dDJnZmsxZzloa1ltM1pL?=
 =?utf-8?B?QjhYKzlDRnZ4Y21pcFhpbmxKeDJvbDRPWDYxVitNWEd2aUExb1Z2aExtUnpZ?=
 =?utf-8?B?Y2JkbEVwK3B3MDd4b1J5a1IxeG9vaVluWS8zbDFXcE1ZWmZCZklmWm9JcjQv?=
 =?utf-8?B?WjFpRWRETmQwM3FOa1dWa29PVGZ2QzBhZzBSZGRtZU02ZW9pdm4wKzJUd3Vi?=
 =?utf-8?B?Mkt4bXVxU0F2dTBya3VkNkViSmU4dndyRHA0bHNuZVVMRmI0MGFLS25YcVY0?=
 =?utf-8?B?Um5RUVFZbUtvanhsZy9YYTVQN0VZNUlQcno0Z2JNdG9IR21STDhzeEpnc2hh?=
 =?utf-8?B?OG55WWlWUHNXV20rekFMeGU3OEdSNjZVd0p4T2tQalQ5VW9ESGNaSGlMc0gx?=
 =?utf-8?B?SXlmWUdRQ3lJcWI0TVc1cWdTZGN2NE13bGpOQ2ZnYmxjWDRBU1FrQ2hrZWlM?=
 =?utf-8?B?TUl1bVlvL3pwRmxYVDcyc05laFhxNk5nUU90WFJsZ3NxVCtKcFh3V2NkVTVB?=
 =?utf-8?B?MTdCOWwva0pyZzNoNXp1TlN0ZDNEQjB3SXAremRZT08yNkViS1dvQlhZQzhE?=
 =?utf-8?B?Z1pPQkVBUS93aFkydHhWajJScFdKSkRlR1hXQnF3RjJXWkVaUTIxZ1pxZFh4?=
 =?utf-8?B?K1ZDeGllclp2dU9kczRMblExZmluaGdZWEl0SnlYWmliazcrU2ZUUy9mNEpY?=
 =?utf-8?B?ckNDdStXVU8wNSthdzB1V0hhRU13aUd1Qlh3b2lENjJiS1FzSC9Zb3ZBZ3pu?=
 =?utf-8?B?UEtDeWczdkl5SzNMQ3JoajRkQVFnazJWenZ6ZS9KZ093ZW12VGFEdHlGR3ZH?=
 =?utf-8?B?RHpiWHQ4ZlhmVUlNS2RSU3g4Vk0rWjFVaGxnMHRaOXlGWFp3L2tsVmgvRkE1?=
 =?utf-8?B?QmlkcHpQV0Jhd0tWaG1GMmVXNW9oTG12TjYwM0hJVE51T0RSR1JJeThxL0wy?=
 =?utf-8?B?MVh1eXovayszMjRLaXc5MHIwbG1nam5nL0U5K1BFeUo0VGNLemUxYXhMRHpy?=
 =?utf-8?B?U2FCL0NYQk1pcDZMRVI3dy9pdk1Bb1hqMytuVDBycHp1bUhoeVE1eE91SVAx?=
 =?utf-8?B?a0ZQU3V3VXZDU01sMUlXbExIdGUxaEhERGU3MnRuQUtiaVVmSmNDYWg5eTht?=
 =?utf-8?B?S3loVktTc3NTSnB1eWdJcTR1bjdjUFQyNXlJb1dFRDFvaUd5dVp0N2hTelJP?=
 =?utf-8?B?b0xiZ2xpYmtja2JjVUhRQmdJU21kT29YZkgyM2ZZMHdTOEp4eS9rUnFUck9y?=
 =?utf-8?B?ZmsxYUszQ1RIMlJIMUpEbmdTcVhwdVVlcXp6TkdIMGZOSTBmekRPWGQyU3dp?=
 =?utf-8?B?c1RzOWMyRG9UYWo2dHFpbE9LNDZieVI0c3R2RjdKd3VjcTdSMlJzTFlOS1Bz?=
 =?utf-8?B?OThJcEMwS1dZT0x1RFRnV3lUdVc1RGVpZmVMT2s2VE1pOE5OWjNyeFgzYXBk?=
 =?utf-8?B?TGlSNWV5enpMQ0s1bVoxNmYvaUdkTnViakMzZUErU2JtZGgwc1IwTmNSMHdI?=
 =?utf-8?B?OVVlZE9UMXRMOGpCMmNoc3pyb3Nlb3lCMTc4eHlMVnR0NDBLb3dkQVY5SGpG?=
 =?utf-8?B?WHgrOGhkN1BFQ2FFWFp2RjduV0d3TlVDWStVTjF0emgvM3ZwVWk4YnQ5dnM0?=
 =?utf-8?B?ZTBRZGtzQUtGNVZNN0VOdnc0Sk5rSi9OL2VDVm1aL1hvWWxGcVUrWXVZUnlF?=
 =?utf-8?Q?PdM20z?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(14060799003)(7416014)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:44:47.6737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008d45bf-2e43-40ab-fbe7-08ddec8ac2f7
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763

DQpBbSAwNS4wOS4yNSB1bSAxNjoyMyBzY2hyaWViIEpvc3VhIE1heWVyOg0KPiBBbSAwNS4wOS4y
NSB1bSAxMzozNyBzY2hyaWViIFZsYWRpbWlyIE9sdGVhbjoNCj4+IE9uIEZyaSwgU2VwIDA1LCAy
MDI1IGF0IDExOjEwOjUzQU0gKzAwMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4+IEhpIFZsYWRp
bWlyLA0KPj4+DQo+Pj4gVGhhbmtzIGZvciBhZGRpbmcgbWUgaW4gQ0MhDQo+Pj4NCj4+PiBBbSAw
NS4wOS4yNSB1bSAxMjo0OSBzY2hyaWViIFZsYWRpbWlyIE9sdGVhbjoNCj4+Pj4gT24gVGh1LCBT
ZXAgMDQsIDIwMjUgYXQgMDg6MjI6MTZQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+
Pj4gT24gVGh1LCBTZXAgMDQsIDIwMjUgYXQgMDY6NDQ6MDFQTSArMDMwMCwgVmxhZGltaXIgT2x0
ZWFuIHdyb3RlOg0KPj4+Pj4+IEdvaW5nIGJ5IHRoZSBnZW5lcmljICJmc2wsbHlueC0yOGciIGNv
bXBhdGlibGUgc3RyaW5nIGFuZCBleHBlY3RpbmcgYWxsDQo+Pj4+Pj4gU2VyRGVzIGluc3RhbnRp
YXRpb25zIG9uIGFsbCBTb0NzIHRvIHVzZSBpdCB3YXMgYSBtaXN0YWtlLg0KPj4+Pj4+DQo+Pj4+
Pj4gVGhleSBhbGwgc2hhcmUgdGhlIHNhbWUgcmVnaXN0ZXIgbWFwLCBzdXJlLCBidXQgdGhlIG51
bWJlciBvZiBwcm90b2NvbA0KPj4+Pj4+IGNvbnZlcnRlcnMgYW5kIGxhbmVzIHdoaWNoIGFyZSBp
bnN0YW50aWF0ZWQgZGlmZmVycyBpbiBhIHdheSB0aGF0IGlzbid0DQo+Pj4+Pj4gZGV0ZWN0YWJs
ZSBieSBzb2Z0d2FyZS4NCj4+PiBJZiB0aGUgc2VyZGVzIG5vZGUgaGFkIGEgcGh5IHN1Yi1ub2Rl
IGZvciBlYWNoIGxhbmUsIHRoZW4gc29mdHdhcmUNCj4+PiBjb3VsZCBkZXNjcmliZSBlYWNoIGxh
bmUgaW5kaXZpZHVhbGx5IC8gb21pdCA0IGxhbmVzIG9uIGx4MjE2MiBzZDEgZS5nLi4NCj4+Pg0K
Pj4+IFRoaXMgY29tZXMgd2l0aCBhZGRlZCBiZW5lZml0IHRoYXQgcGVyaGFwcyBpbiB0aGUgZnV0
dXJlIHdlIGNhbiB1c2UNCj4+PiB0aGVtIHRvIGRlc2NyaWJlIGJvYXJkLXNwZWNpZmljIGVxdWFs
aXphdGlvbiBwYXJhbWV0ZXJzLg0KPj4+DQo+Pj4gVGhlIGN1cnJlbnQgZHJpdmVyIHVzZXMgaGFy
ZGNvZGVkIGRlZmF1bHRzIHRoYXQgbWF5IGJlIGFwcHJvcHJpYXRlDQo+Pj4gZm9yIHNvbWUgbnhw
IGV2YWx1YXRpb24gYm9hcmRzIG9ubHkuDQo+PiBZZWFoLg0KPj4NCj4+IEdpdmVuIHRoZSBmYWN0
IHRoYXQgdGhlIFNlckRlcyBjYW4gY2hhbmdlIGJldHdlZW4gcHJvdG9jb2xzLCBJIHN1c3BlY3QN
Cj4+IHlvdSB3YW50IHRvIGdvIG9uZSBsZXZlbCBmdXJ0aGVyLCBhbmQgZGVzY3JpYmUgZGVmYXVs
dCBlcXVhbGl6YXRpb24NCj4+IHBhcmFtZXRlcnMgZm9yIGVhY2ggcHJvdG9jb2wuIFRoZSBlcXVh
bGl6YXRpb24gZm9yIDEwRyB3b24ndCBiZSBnb29kIGZvcg0KPj4gMjVHIGFuZCB2aWNlIHZlcnNh
Lg0KPj4NCj4+IERvIHlvdSBoYXZlIGEgc3BlY2lmaWMgZm9ybWF0IGluIG1pbmQ/DQo+IEkgaGF2
ZSBhIHByb3RvdHlwZSBpbXBsZW1lbnRhdGlvbiBiYXNlZCBvbiB2NS4xNSB1c2luZyBwcm9wZXJ0
aWVzIGFzIGJlbG93DQo+IChJIGFtIG5vdCBzdXJlIHRoaXMgaXMgdGhlIGJlc3QgZm9ybWF0IHRo
b3VnaCwgRFQgbWFpbnRhaW5lcnMgbWF5IGhhdmUgb3BpbmlvbnMpOg0KPg0KPiBzZXJkZXNfMV9s
YW5lX2c6IHBoeUA2IHsNCj4gwqAgwqAgcmVnID0gPDY+Ow0KPiDCoCDCoCAjcGh5LWNlbGxzID0g
PDA+Ow0KPiDCoCDCoCBmc2wsZXEtbmFtZXMgPSAiMTBnYmFzZS1yIiwgIjI1Z2Jhc2UtciI7DQo+
IMKgIMKgIGZzbCxlcS10eXBlID0gIjMtdGFwIiwgIjMtdGFwIjsNCj4gwqAgwqAgZnNsLGVxLXBy
ZXEtc2lnbiA9ICJwb3NpdGl2ZSIsICJwb3NpdGl2ZSI7DQo+IMKgIMKgIGZzbCxlcS1wcmVxLXJh
dGUgPSAiMS4zMyIsICIxLjMzIjsNCj4gwqAgwqAgZnNsLGVxLXBvc3QxcS1zaWduID0gIm5lZ2F0
aXZlIiwgIm5lZ2F0aXZlIjsNCj4gwqAgwqAgZnNsLGVxLXBvc3QxcS1yYXRlID0gIjEuMjYiLCAi
MS4yNiI7DQo+IMKgIMKgIGZzbCxlcS1hbXAtcmVkID0gIjEuMDAwIiwgIjEuMDAwIjsNCj4gwqAg
wqAgZnNsLGVxLWFkYXB0aXZlID0gPDMyPiwgPDMyPjsNCj4gfTsNCj4NCj4gSSBpbWFnaW5lIGEg
cGFyYW1ldGVycyBzdWItbm9kZSBwZXIgcHJvdG9jb2wgbWF5IGJlIG1vcmUgcmVhZGFibGUuDQo+
DQo+IFRoZSBiZXN0IGRlc2NyaXB0aW9uIHdvdWxkIGJlIGdlbmVyaWMgZW5vdWdoIHRvIGNvdmVy
IHBjaSBhbmQgc2F0YSwgdG9vLg0KPg0KPiBQZXJoYXBzOg0KPg0KPiBzZXJkZXNfMV9sYW5lX2c6
IHBoeUA2IHsNCj4gwqAgwqAgcmVnID0gPDY+Ow0KPiDCoCDCoCAjcGh5LWNlbGxzID0gPDA+Ow0K
PiDCoCDCoCBmc2wsZXEtcGFyYW1zID0gPCZzZXJkZXNfMV9sYW5lX2dfZXFfMTBnPiwgPCZzZXJk
ZXNfMV9sYW5lX2dfZXFfc2F0YT47DQoNCmZzbCxsYW5lLW1vZGVzID0gInhmaSIsICJzYXRhIjsN
Cg0KXl4gV291bGQgYmUgbXJvZSBlbGVnYW50LCBhcyBpdCBjYW4gYXQgdGhlIHNhbWUgdGltZSBl
eHBsYWluIHdoaWNoIG1vZGVzDQphIHNwZWNpZmljIGxhbmUgc3VwcG9ydHMgZ2VuZXJhbGx5Lg0K
DQpUaGVuIGVxLXBhcmFtcyBpcyBhbiBvcHRpb25hbCBsaXN0IHdpdGggc3BlY2lmaWMgcGFyYW1l
dGVycywgc29tZSBvZg0Kd2hpY2ggY2FuIGJlIHNoYXJlZCBiZXR3ZWVuIGRpZmZlcmVudCBtb2Rl
cyAoNDBnLzEwZykNCg0KPiDCoCDCoCBzZXJkZXNfMV9sYW5lX2dfZXFfMTBnOiBlcS1wYXJhbXMt
MCB7DQo+IMKgIMKgIMKgIMKgIC8qIGNvbXBhcmUgZG93bnN0cmVhbSBlbnVtIGx5bnhfMjhnX2xh
bmVfbW9kZSAqLw0KPiDCoCDCoCDCoCDCoCBmc2wsbGFuZS1wcm90b2NvbCA9ICJ4ZmkiOw0KPiDC
oCDCoCDCoCDCoCBmc2wsZXEtdHlwZSA9ICIzLXRhcCI7DQo+IMKgIMKgIMKgIMKgIGZzbCxlcS1w
cmVxLXNpZ24gPSAicG9zaXRpdmUiOw0KPiDCoCDCoCDCoCDCoCBmc2wsZXEtcHJlcS1yYXRlID0g
IjEuMzMiOw0KPiDCoCDCoCDCoCDCoCBmc2wsZXEtcG9zdDFxLXNpZ24gPSAibmVnYXRpdmUiOw0K
PiDCoCDCoCDCoCDCoCBmc2wsZXEtcG9zdDFxLXJhdGUgPSAiMS4yNiI7DQo+IMKgIMKgIMKgIMKg
IGZzbCxlcS1hbXAtcmVkID0gIjEuMDAwIjsNCj4gwqAgwqAgwqAgwqAgZnNsLGVxLWFkYXB0aXZl
ID0gPDMyPjsNCj4gwqAgwqAgfTsNCj4gwqAgwqDCoA0KPiDCoCDCoCBzZXJkZXNfMV9sYW5lX2df
ZXFfc2F0YTogZXEtMSB7DQo+IMKgIMKgIMKgIMKgIC8qIGNvbXBhcmUgZG93bnN0cmVhbSBlbnVt
IGx5bnhfMjhnX2xhbmVfbW9kZSAqLw0KPiDCoCDCoCDCoCDCoCAvKiBleGFtcGxlIHBhcmFtZXRl
cnMsIGRvIG5vdCB1c2UgZm9yIHNhdGEgKi8NCj4gwqAgwqAgwqAgwqAgZnNsLGxhbmUtbW9kZSA9
ICJwY2kiOw0KPiDCoCDCoCDCoCDCoCBmc2wsZXEtdHlwZSA9ICIzLXRhcCI7DQo+IMKgIMKgIMKg
IMKgIGZzbCxlcS1wcmVxLXNpZ24gPSAicG9zaXRpdmUiOw0KPiDCoCDCoCDCoCDCoCBmc2wsZXEt
cHJlcS1yYXRlID0gIjEuMzMiOw0KPiDCoCDCoCDCoCDCoCBmc2wsZXEtcG9zdDFxLXNpZ24gPSAi
bmVnYXRpdmUiOw0KPiDCoCDCoCDCoCDCoCBmc2wsZXEtcG9zdDFxLXJhdGUgPSAiMS4yNiI7DQo+
IMKgIMKgIMKgIMKgIGZzbCxlcS1hbXAtcmVkID0gIjEuMDAwIjsNCj4gwqAgwqAgwqAgwqAgZnNs
LGVxLWFkYXB0aXZlID0gPDMyPjsNCj4gwqAgwqAgfTsNCj4gfTsNCj4NCj4+Pj4+PiBTbyBkaXN0
aW5ndWlzaCB0aGVtIGJ5IGNvbXBhdGlibGUgc3RyaW5ncy4NCj4+Pj4+PiBBdCB0aGUgc2FtZSB0
aW1lLCBrZWVwICJmc2wsbHlueC0yOGciIGFzIGJhY2t1cC4NCj4+Pj4+IFdoeSBrZWVwIHRoZSBi
YWNrdXA/IERvZXNuJ3Qgc291bmQgbGlrZSB5b3UgY2FuIHVzZSBpdCBmb3IgYW55dGhpbmcsDQo+
Pj4+PiB1bmxlc3MgdGhlcmUncyBzb21lIG1pbmltdW0gc2V0IG9mIGNhcGFiaWxpdGllcyB0aGF0
IGFsbCBkZXZpY2VzDQo+Pj4+PiBzdXBwb3J0LiBJZiB0aGF0J3Mgbm90IHRoZSBjYXNlLCBzaG91
bGQgaXQgbm90IGp1c3QgYmUgbWFya2VkIGRlcHJlY2F0ZWQNCj4+Pj4+IG9yIHJlbW92ZWQgZW50
aXJlbHk/DQo+Pj4+IFRvIGJlIGhvbmVzdCwgSSBjb3VsZCB1c2Ugc29tZSBndWlkYW5jZSBvbiB0
aGUgYmVzdCB3YXkgdG8gaGFuZGxlIHRoaXMuDQo+Pj4+DQo+Pj4+IFdoZW4gSSBoYWQgd3JpdHRl
biB0aGlzIHBhdGNoIGRvd25zdHJlYW0sIGx4MjE2MGEuZHRzaSBvbmx5IGhhZCBzZXJkZXNfMQ0K
Pj4+PiBkZWZpbmVkLCBhcyAiZnNsLGx5bngtMjhnIiwgYW5kIHRoaXMgcGF0Y2ggbWFkZSBtb3Jl
IHNlbnNlLiBLZWVwDQo+Pj4+ICJmc2wsbHlueC0yOGciIGFzIGEgc3lub255bSBmb3IgImZzbCxs
eDIxNjBhLXNlcmRlczEiLCBzbyB0aGF0IG5ldw0KPj4+PiBkZXZpY2UgdHJlZXMgc3RpbGwgd29y
ayB3aXRoIG9sZCBrZXJuZWxzIChhcyBpcyBzb21ldGltZXMgbmVlZGVkIGR1cmluZw0KPj4+PiAn
Z2l0IGJpc2VjdCcsIGV0YyksIGZvciBzb21lIGRlZmluaXRpb24gb2YgdGhlIHdvcmQgIndvcmsi
IChtb3JlIG9mdGVuDQo+Pj4+IHRoYW4gbm90LCB1bnNhdGlzZmFjdG9yeSAtIGZvciBleGFtcGxl
LCBmd19kZXZsaW5rIGJsb2NrcyBwcm9iaW5nIHRoZSBQSFkNCj4+Pj4gY29uc3VtZXIgZHJpdmVy
IGlmIHRoZSBQSFkgZHJpdmVyIGRvZXNuJ3QgZXhpc3QsIGJ1dCB0aGUgJ3BoeXMnIHByb3BlcnR5
DQo+Pj4+IGV4aXN0cyBpbiB0aGUgZGV2aWNlIHRyZWUpLg0KPj4+Pg0KPj4+PiBVbmJla25vd25z
dCB0byBtZSwgY29tbWl0IDJmMjkwMDE3NmI0NCAoImFybTY0OiBkdHM6IGx4MjE2MGE6IGRlc2Ny
aWJlDQo+Pj4+IHRoZSBTZXJEZXMgYmxvY2sgIzIiKSBjYW1lIGFuZCBkZWZpbmVkIHRoZSBzZWNv
bmQgU2VyRGVzIGFsc28gd2l0aA0KPj4+PiAiZnNsLGx5bngtMjhnIi4NCj4+Pj4NCj4+Pj4gVGhl
IHNlY29uZCBTZXJEZXMgaXMgbGVzcyBjYXBhYmxlIHRoYW4gdGhlIGZpcnN0IG9uZSwgc28gdGhl
IHNhbWUNCj4+Pj4gZGV2ZWxvcGVyIHRoZW4gc3RhcnRlZCBiYXR0bGluZyB3aXRoIHRoZSBmYWN0
IHRoYXQgdGhlIGRyaXZlciBkb2Vzbid0DQo+Pj4+IGtub3cgdGhhdCBzZXJkZXNfMiBkb2Vzbid0
IHN1cHBvcnQgc29tZSBwcm90b2NvbHMsIGFuZCB3cm90ZSBzb21lDQo+Pj4+IHBhdGNoZXMgbGlr
ZSA5YmVmODRkMzBmMWYgKCJwaHk6IGx5bngtMjhnOiBjaGVjayByZXR1cm4gdmFsdWUgd2hlbg0K
Pj4+PiBjYWxsaW5nIGx5bnhfMjhnX3BsbF9nZXQiKSwgd2hpY2ggaW4gYWxsIGxpa2VsaWhvb2Qg
Y291bGQgaGF2ZSBiZWVuDQo+Pj4+IGF2b2lkZWQgdXNpbmcgYSBzcGVjaWZpYyBjb21wYXRpYmxl
IHN0cmluZy4NCj4+Pj4gVGhlIGx5bnhfaW5mbyA6Og0KPj4+IEluIHVwc3RyZWFtIG15IHBhdGNo
IGZpeGVzIG5vdGhpbmcsIGl0IGFkZGVkIGEgcmV0dXJuIHZhbHVlIGNoZWNrDQo+Pj4gZm9yIGEg
ZnVuY3Rpb24gY2FsbCB0aGF0IGNhbiBpbmRlZWQgcmV0dXJuIE5VTEwuDQo+Pj4NCj4+PiBNeSBi
YXR0bGUgd2FzIGEgZGlmZmVyZW50IG9uZSwgdW5yZWxhdGVkIHRvIHZhcnlpbmcgc2VyZGVzIGJs
b2NrIGZlYXR1cmVzDQo+Pj4gKEkgY2xhaW0gaXQgY2FuIGFsc28gaGFwcGVuIHdpdGggc2FtZSBw
aHkgb24gc2VyZGVzIGJsb2NrIDEpOg0KPj4+DQo+Pj4gSSBmb3VuZCB0aGF0IHRoZSBjb21iaW5h
dGlvbiBvZiBNYXJ2ZWxsIDEwRyBwaHkgZHJpdmVyLCBwY3MsIHNlcmRlcyBhbmQgZHBhYTINCj4+
PiBkaWQgbm90IHN0cmljdGx5IGFkaGVyZSB0byBwaHktY29ubmVjdGlvbi10eXBlIHNldCBpbiBk
ZXZpY2UtdHJlZSwgb3IgdGhlIGluaXRpYWwNCj4+PiBtb2RlIG5lZ29pdGF0ZWQgYmV0d2VlbiBw
aHkgYW5kIG1hYy4NCj4+IFllcywgaXQgZG9lc24ndCBoYXZlIHRvLg0KPj4NCj4+PiBPbmNlIHBo
eSBuZWdvdGlhdGVkIGEgMi41R2JwcywgdGhlIGtlcm5lbCB3b3VsZCB0aGVuIHRyeSBzd2l0Y2hp
bmcNCj4+PiBhbGwgMyBkcml2ZXJzIHRvIGEgMi41ZyBtb2RlLCB3aGVuIGl0IHNob3VsZCBoYXZl
IHN0dWNrIHdpdGggMTBnYmFzZS1yLA0KPj4+IG9yIHJlcG9ydGVkIGFuIGVycm9yIGtub3dpbmcg
dGhhdCB0aGUgc2VyZGVzIGRpZCBub3QgYWR2ZXJ0aXNlIHN1cHBvcnQgZm9yIDIuNWcuDQo+Pj4N
Cj4+PiBEdWUgdG8gbWFzc2l2ZSBkb3duc3RyZWFtIHJlZmFjdG9yaW5nIGluIHRoZSB2ZW5kb3Ig
a2VybmVsIHNlcmRlcyBkcml2ZXIsDQo+Pj4gdGhlcmUgZXhpc3RlZCBhIGNvZGUtcGF0aCBsZWFk
aW5nIHRvIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4+PiBCdXQgdGhhdCB3YXMgYWxzbyBh
IGNvbnNlcXVlbmNlIG9mIG90aGVyIG1pc3Rha2VzLg0KPj4gU29ycnksIEkgaW50ZXJwcmV0ZWQg
eW91ciBwYXRjaCBpbiB0aGUgb25seSB3YXkgdGhhdCBjb3VsZCBoYXZlIG1hZGUgYW55DQo+PiBz
ZW5zZS4NCj4+DQo+PiBJbiB0aGUgY2lyY3Vtc3RhbmNlIHlvdSBkZXNjcmliZSwgaXNuJ3QgeW91
ciBmaXgganVzdCAiY29kZSBhZnRlciByZXR1cm4iPw0KPj4gSG93IHdvdWxkIGhhdmUgbHlueF8y
OGdfc2V0X21vZGUoUEhZX01PREVfRVRIRVJORVQsIFBIWV9JTlRFUkZBQ0VfTU9ERV8yNTAwQkFT
RVgpDQo+PiBnb3R0ZW4gcGFzdCB0aGUgbHlueF8yOGdfc3VwcG9ydHNfaW50ZXJmYWNlKCkgdGVz
dCB3aXRob3V0IGJlaW5nIHJlamVjdGVkPw0KPiB2Ni42LjYuNTItMi4yLjAgcmVsZWFzZSwgLnNl
dF9tb2RlOg0KPg0KPiBseW54XzI4Z19zZXRfbW9kZS0+bHlueF8yOGdfc2V0X2xpbmtfbW9kZS0+
bHlueF8yOGdfc2V0X2xhbmVfbW9kZS0+bHlueF8yOGdfcGxsX2dldA0KPg0KPiBkb2VzIG5vdCBj
aGVjayBseW54XzI4Z19zdXBwb3J0c19pbnRlcmZhY2UuDQo+DQo+PiBUaGUgZHJpdmVyIHdvdWxk
IGhhdmUgbmVlZGVkIHRvIHN1ZmZlciBzb21lIHByZXR0eSBzZXJpb3VzIG1vZGlmaWNhdGlvbnMN
Cj4+IHRvIGFsbG93IHRoaXMgdG8gaGFwcGVuLCBhbmQgSSdtIG5vdCBoYXBweSB3aXRoIHRoZSBm
YWN0IHRoYXQgaXQncyBjaGFuZ2VkDQo+PiB0byBoYW5kbGUgaW5jb3JyZWN0IGRvd25zdHJlYW0g
Y2hhbmdlcywgd2l0aG91dCBhdCBsZWFzdCBhIGNvbXBsZXRlDQo+PiBkZXNjcmlwdGlvbi4NCj4g
UG9pbnQgb2YgbXkgc3VibWl0dGVkIHBhdGNoIHdhcyBtZXJlbHkgdG8gZ3VhcmQgYW4gdW5jaGVj
a2VkIHBvaW50ZXIsDQo+IGdlbmVyYXRpbmcgYXBwcm9wcmlhdGUgZXJyb3Igd2l0aCBlbm91Z2gg
ZXhwbGFuYXRpb24gZm9yIG5vbi1tYWludGFpbmVycy4NCj4NCj4gSSBkZWJhdGVkIHVzaW5nIEJV
R19PTiBpbnN0ZWFkIG9mIHdhcm4uDQo+DQo+Pj4+IGxhbmVfc3VwcG9ydHNfbW9kZSgpIG1ldGhv
ZCBmcm9tIHBhdGNoIDE0LzE0IGlzIHN1cHBvc2VkIHRvIHNheSB3aGF0IGlzDQo+Pj4+IHN1cHBv
cnRlZCBwZXIgU2VyRGVzIGFuZCB3aGF0IG5vdC4NCj4+PiBJbmRlZWQsIGFuZCB1cHN0cmVhbSBw
cm9wZXJseSBnYXRlcyBhbGwgcmVjb25maWd1cmF0aW9uIGF0dGVtcHRzIHVzaW5nIGl0Lg0KPj4+
PiBJbiB0ZXJtcyBvZiBpbXBsZW1lbnRhdGlvbiwgd2hhdCBkb2VzICJkZXByZWNhdGluZyIgdGhl
ICJmc2wsbHlueC0yOGciDQo+Pj4+IGNvbXBhdGlibGUgc3RyaW5nIG1lYW4sIGNvbXBhcmVkIHRv
IHJlbW92aW5nIGl0IGVudGlyZWx5PyBXb3VsZCB0aGVyZSBiZQ0KPj4+PiBhbnkgcmVtYWluaW5n
IGRyaXZlciBzdXBwb3J0IGZvciBpdD9TaG91bGQgSSBjb21wdXRlIHRoZSBjb21tb24gc2V0IG9m
DQo+Pj4+IGNhcGFiaWxpdGllcyBiZXR3ZWVuIFNlckRlcyAjMSBhbmQgIzIsIGFuZCBvbmx5IHN1
cHBvcnQgdGhhdD8gV2hhdA0KPj4+PiBpbXBhY3Qgd291bGQgdGhpcyBoYXZlIHVwb24gb2xkIGRl
dmljZSB0cmVlcz8gSXMgaXQgYWNjZXB0YWJsZSB0byBqdXN0DQo+Pj4+IHJlbW92ZSBzdXBwb3J0
IGZvciB0aGVtPw0KPj4+IFdoZW4geW91IHJlbW92ZSB0aGUgb2xkIGNvbXBhdGlibGUgc3RyaW5n
LCB0aGUgZHJpdmVyIHNob3VsZCBzdGlsbCBrZWVwDQo+Pj4gc3VwcG9ydGluZyBvbGQgRFRCcy4N
Cj4+IFRodXMgdGhpbmtpbmcgU2VyRGVzICMyIHN1cHBvcnRzIGFsbCBmZWF0dXJlcyBvZiBTZXJE
ZXMgIzE/DQo+IFllcy4NCj4gVGhpcyB3aWxsIG5vdCBiZSBhIHByb2JsZW0gZm9yIHRob3NlIHVz
ZXJzIHdobyBjb25maWd1cmUgYWxsIGxhbmVzIHRvIFNHTUlJLA0KPiBvciBqdXN0IHRoZSB0d28g
c3BlY2lhbCBsYW5lcyBmb3IgWEZJLg0KPg0KPiBJIGRvbid0IHRoaW5rIHlvdSBuZWVkIHRvIGZp
eCBhIGRvd25zdHJlYW0gZHRiIHZpYSB0aGUgZHJpdmVyLg0KPiBJZiBkb3duc3RyZWFtIHVzZXIg
Y2FuIHVwZGF0ZSB0aGUga2VybmVsLCB0aGV5IGNhbiB1cGRhdGUgdGhlIGR0YiBhbHNvLA0KPiB0
byByZXNvbHZlIHRoZWlyIG93biBidWdzLg0KPg0KPj4+IEkgcGVyc29uYWxseSBiZWxpZXZlIGl0
IGNvcnJlY3QgdG8ga2VlcCBkdWFsIGNvbXBhdGlibGUgc3RyaW5ncywNCj4+PiByZWZsZWN0aW5n
IHRoYXQgdGhlIHNlcmRlcyBibG9ja3Mgc2hhcmUgYSBjb21tb24gcHJvZ3JhbW1pbmcgbW9kZWwu
DQo+PiBUaGFua3MgZm9yIHRoZSBpbnB1dC4NCj4+DQo=


