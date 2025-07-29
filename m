Return-Path: <linux-kernel+bounces-748780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD6B145F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FAB3BC486
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A261F1317;
	Tue, 29 Jul 2025 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northwestern.edu header.i=@northwestern.edu header.b="dcvTZ/+h";
	dkim=pass (1024-bit key) header.d=northwestern.edu header.i=@northwestern.edu header.b="N9vi71Uz"
Received: from evcspprf10.ads.northwestern.edu (evcspprf10.ads.northwestern.edu [165.124.82.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C21F237A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=165.124.82.241
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753753384; cv=fail; b=umR/UXNxDfd/3m8jZYmX7H55+G5gAkBC6IDfWM96i07kmLRnZqoZ6GwwNgb+qsfRne7x7hi73eWnOmTcbJxOrV4coI255pWMqcHZ0vBwRK8xtTFAWNmkyLhsU4rPrLwzg01pMaQEvTWIvO3n62BeSLXWYj62sGNJBPqWJdjKbSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753753384; c=relaxed/simple;
	bh=N4yXk4ShAPqKAtoBLzHhipdNv/NXg8z03S7aRGgHhQA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t5h51t0nEzQuwUhpusH5QJDhhrQKH61nBJPawXxH5No7vfqq0Vs7p+R5ir/6gPzg6ZvSjKslKRDmmAt/4vtvm4vAsaBokXgvuyKz5apk+fq/2nbHKZG79WwgnKajg2+xWhxwQW+7OAMRml/s9IOMeufgdYl8koZKJNmdhigU18I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=northwestern.edu; spf=pass smtp.mailfrom=northwestern.edu; dkim=pass (2048-bit key) header.d=northwestern.edu header.i=@northwestern.edu header.b=dcvTZ/+h; dkim=pass (1024-bit key) header.d=northwestern.edu header.i=@northwestern.edu header.b=N9vi71Uz; arc=fail smtp.client-ip=165.124.82.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=northwestern.edu
Received: from pps.filterd (evcspprf10.ads.northwestern.edu [127.0.0.1])
	by evcspprf10.ads.northwestern.edu (8.18.1.2/8.18.1.2) with ESMTP id 56T0uvMX028541;
	Mon, 28 Jul 2025 20:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northwestern.edu; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=proofpoint;
 bh=ikSir2NsMxvFO1NrWrgjWtVpcnZixkbr5m7gQw4NiC4=;
 b=dcvTZ/+hMOi254oF/9a/YrD7hbnpn0wLxg18ndo3rmzYZbFmm3wb8G9KroMPbMD/6PEG
 FXs7IYzf9H2c6vO5jylc+oMSurFmQtzws7gPF0lK33lE3o7mdQvcpMqeNwb2WZ3GHfSo
 CYwLV/rnUtdpgIDdm9J3hKDUYxP8zJFT3C34/vgqptPjfGLxH8Nb9epocbcsZg/Q8Lw9
 aK50IByLJy92Z6zRxJ+G0WXhwWRlrrVgyi9QuJWBDWU2nu08Rn6n0uOZDYP/j+hsltTU
 WucC1yVA+RZ3s5HQA7AfWQIrFC9mjdq2TWkR+lgjqat6ZtKYyye2tSnnDjjTDToeHJnH 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by evcspprf10.ads.northwestern.edu (PPS) with ESMTPS id 485d75dsbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 20:22:17 -0500
Received: from evcspprf10.ads.northwestern.edu (evcspprf10.ads.northwestern.edu [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56T1MHjv020439;
	Mon, 28 Jul 2025 20:22:17 -0500
Received: from evcspexch02.ads.northwestern.edu (evcspexch02.ads.northwestern.edu [165.124.43.180])
	by evcspprf10.ads.northwestern.edu (PPS) with ESMTPS id 485d75dsbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 20:22:17 -0500
Received: from EVCSPEXCH01.ads.northwestern.edu (165.124.43.179) by
 EVCSPEXCH02.ads.northwestern.edu (165.124.43.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 20:22:16 -0500
Received: from DM2PR04CU003.outbound.protection.outlook.com (40.93.13.96) by
 EVCSPEXCH01.ads.northwestern.edu (165.124.43.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Mon, 28 Jul 2025 20:22:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq8ceULipBnG07ew0MVhvfCp+YwdCgSoygRmxJotZ53jvyS0XrzVn2Wvg0iKsNyRIfReLaSUjfO8q9kx0vDenQ+ILDH5Hq5HVAaRPHSqV9l0cRpy69mTyj68zE09KDtZz+f/pTo+vWGjiv1+TTOf/hqcFWYqHIBIPnFmB1ONJAbGEziucgvw8bdwUPxQZoy60D+tkySxqvu2ToMsuySG8vmz8220ffc0JtRRWCl8NC9NHkYFcu84yVynUEFUgCL4G1YndeLi4qWxdZqUWgW5qXi66lZRXnPY44TmRTDij9rqFIsG4HG/wQBiLuwjlnUgnRUqogCc1CpqeUtHYJYf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikSir2NsMxvFO1NrWrgjWtVpcnZixkbr5m7gQw4NiC4=;
 b=zKvEUdzm7a8BvETUhm2qUCTD9srlU1Qi3zEKiYluC5bRkescZ03x8c6iwLeE+2V/H9iQjf0a10GcEPdPWgP0ADg3K8FPpQoZYyO1+zfHtU4TvZfjsJnnhcJlZUxJUDRw4FJwgbUWMr/WHBfPsfH/BgKQQAb/c2plKgaV77DTXlrNS83hc/DgpxEZannmEzvCKtF1phkNqM2Nk3tjr/AnBrg25AHarq71QmWVOXLi0VhlXPL3XIuzPCT/FDx7oSICvLdF9doZl3Z4LIOlhG6/Qv1HDKGGIoffL6ptsNPY1e9IwKlDGjVfolWfTHfvJIiZaUIZJbh6cb5CwS1+YDykdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northwestern.edu; dmarc=pass action=none
 header.from=northwestern.edu; dkim=pass header.d=northwestern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northwestern.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikSir2NsMxvFO1NrWrgjWtVpcnZixkbr5m7gQw4NiC4=;
 b=N9vi71Uz0FT9KdSPkVpakiPdKvEH4U9etX1dGBSHSMnUw48zE/tTtl8L4q64Ltp4sqCa5Dwq1YM5h+zr5tty+o/L312MZ406ArDn8BOQwSaErYKSjOfY0RtWJDnaw6ZwY+Krb5DgQmTpvVEPMSijInHWdDq37dgQWEJejhNNEW8=
Received: from BL0PR05MB4674.namprd05.prod.outlook.com (2603:10b6:208:2a::33)
 by CO1PR05MB8117.namprd05.prod.outlook.com (2603:10b6:303:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 01:22:14 +0000
Received: from BL0PR05MB4674.namprd05.prod.outlook.com
 ([fe80::2a87:1931:383a:f54d]) by BL0PR05MB4674.namprd05.prod.outlook.com
 ([fe80::2a87:1931:383a:f54d%4]) with mapi id 15.20.8964.019; Tue, 29 Jul 2025
 01:22:14 +0000
From: Zheng Yu <zheng.yu@northwestern.edu>
To: "shaggy@kernel.org" <shaggy@kernel.org>
CC: "eadavis@qq.com" <eadavis@qq.com>,
        "rand.sec96@gmail.com"
	<rand.sec96@gmail.com>,
        "aha310510@gmail.com" <aha310510@gmail.com>,
        "niharchaithanya@gmail.com" <niharchaithanya@gmail.com>,
        "kovalev@altlinux.org" <kovalev@altlinux.org>,
        "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] jfs: fix metapage reference count leak in dbAllocCtl
Thread-Topic: [PATCH] jfs: fix metapage reference count leak in dbAllocCtl
Thread-Index: AQHcACaYk3hCTK8p0E2HtMrS6g0cmQ==
Date: Tue, 29 Jul 2025 01:22:14 +0000
Message-ID: <BL0PR05MB467408AB092885950559B422FF25A@BL0PR05MB4674.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB4674:EE_|CO1PR05MB8117:EE_
x-ms-office365-filtering-correlation-id: 1a25bafd-12a1-4132-27f9-08ddce3e5979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/yxL6Hpy+J9W+0+cVDWnwTyeN8E47ldPNQf7ako+S0znUWFIUjECe8VzpA?=
 =?iso-8859-1?Q?M9pIhtV4NWcJtp78Y9SP60D/rj1UQlGG5EMlxvyN5cKth8t/4BhZQjQPSI?=
 =?iso-8859-1?Q?3IYQ+Dq8dfBBWk7Dby4tPJFTJkZ6E3cS8PfZbQIZXPayi8V10kyS57TZFb?=
 =?iso-8859-1?Q?+7eAzEElkm8IEbSlBrE+JgqYMeLW5pjJHHr6icheD94EawbKWfcmpCe/Hv?=
 =?iso-8859-1?Q?eqyKhLxCib+JAusUrkJQ6La5w7lyfyQlu60pd7KS/IzYrxTgsndYvI6Pq5?=
 =?iso-8859-1?Q?cf4lS3S1jzoSW2w7Qczxu1i0cDWBREDqsC6cATnl0Xnge/GhcP7qnHlBJF?=
 =?iso-8859-1?Q?Zgfv+6BapYuJDaEOF3gIGIJonPw0VVluTa7ligTOARcuRrtsC4vGZVA5YO?=
 =?iso-8859-1?Q?cD8iwnNT4jDYYWazL8vKK0dTwjlSeNossS68ZWe3Bg7vu7Wvuw3cdYcJWR?=
 =?iso-8859-1?Q?CLHJ0UxFz76opikA9RUfg8DHw6tDLnnzHFYVJh2PhvvNtcVMEb0QuHHxSX?=
 =?iso-8859-1?Q?ibNABUO0Qt/NKEd8/VKlCk9wuuXleTqAVUgyFn2cIFdgi4bjJrHKpoNts1?=
 =?iso-8859-1?Q?Cj28jS0zUsnRvrvCuXHp3criiDW8JQNv1pCWJSCQtFVJKVu8QAv5l0B3JW?=
 =?iso-8859-1?Q?vY4e301sPExRo8Jk3qkOZZbNg3KBKCTiX9gdRzWo538bpt47J0SGWMNfWc?=
 =?iso-8859-1?Q?sNCdSKbplkS1kutxZmL2XCJo84PwohU0TYgYJpkAvcCiXE5Mt7iAZr+ml+?=
 =?iso-8859-1?Q?rWxtheQlkwScJR53/g5xILsnlwD51j4w4IDJIMZip5FzQ7DsYM9ytCzFYo?=
 =?iso-8859-1?Q?qYIp7BkUfl/jmNh5vqjd2W34pkeFX1bOO2EgfC7+aJskwgR4fAZbfOoZbj?=
 =?iso-8859-1?Q?tCTP7yIRqG//AQk7BOTzl4vOgg3uSiaTLXqDfC+7CnpPkryMChiy3K2tRe?=
 =?iso-8859-1?Q?N4/GsGDiz0qfDZ7LOUauGSkkNt595mQqrJnyIjeLuv9zTQnLudhQtavx3G?=
 =?iso-8859-1?Q?tQ3CiMe8QFY+hFCoXmSzwXGhQDchckSorKq81L3U79cIC6G55vy1adU/Pq?=
 =?iso-8859-1?Q?/joQNtyyksJrkM6Qkkr/TedhWHJL7b8HEVoYBZkotK12LetSB6laqkqT/n?=
 =?iso-8859-1?Q?Tb3w8qCcP2XlvkJIZ43fL/YanB48dY2dDoTlvd8PZ9QM8t2NuPNZ7vIou5?=
 =?iso-8859-1?Q?HvVX+1DdpwngBaoGfJahLnQdX6bHUbFxWMOBW5DlD17onDpCAfN0oUt4ld?=
 =?iso-8859-1?Q?r13itPdnRlbO/MEcyFFxxE8eTrsKpioiHZ5+5Vp4mFaMIYdb0VCbqdhPLq?=
 =?iso-8859-1?Q?Nh15tEeg0dJ3zx6BD8fcnf3Se7lnVTaWBwUAsWUxwNn+drP7+wEguvEKc0?=
 =?iso-8859-1?Q?xvp65Qf2XvAB0Ee9sOi58v+7dFYUDBUARoTKJuCXR84OV4jPvLaUBwGgVn?=
 =?iso-8859-1?Q?JHwk32afMZeS0libH4+Fy0ED3twGOVd6j5VSm3rymFIZBlBGD8G191gm9Q?=
 =?iso-8859-1?Q?0Kr/OP//BSYGEXluFF1P5zIJDjbxfKNr/weM/aUUdvcw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB4674.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wp1i3OiTFQ68j1B07Y7gWAFv1ivV4sw6Vu5rxDEXBM2jRpOHw5DVD2KS4e?=
 =?iso-8859-1?Q?jARRvnaSG2Ba6pNMQGZ5RXf0VagdT/HguStHT0w1nJbykMliFhSDKuUa9X?=
 =?iso-8859-1?Q?mWsUCAHLQQbmXNSbuPi8li4P/3sZujun4rP6MSMZk8gKoGugi4+ysEmuSr?=
 =?iso-8859-1?Q?H3BhWAbfv2eiYfBxWM70yUPbUZnkiyIlVlk0aiCD6PWbOwujhTBDuEqWHa?=
 =?iso-8859-1?Q?JAwaV5gDDkPC1V/D0y/1HWQI7tPiwfpotQ1EB3UQ5pd5rPnEK5HYAAbPT4?=
 =?iso-8859-1?Q?voB/krvQXT2PPyhUdbLveVynUcsF7frAtxxiI8NP72QPztN0ws0Y7pXoX0?=
 =?iso-8859-1?Q?WkabqrUdpitYhCe6QscaQSub5Tp23uF/Ihlto/CT5MLCvidCG2p2rbtCNk?=
 =?iso-8859-1?Q?YJF/Jhi+0qU2FN+04Q3H1Ub1MIW+a0JrUoCJY8ChZV7VF78lz/P8iYjwb1?=
 =?iso-8859-1?Q?8DCHktOiMYE1DeUEkX30zVpdLI0ubAXKXUOV9tVei8JGKDuCzZ2b2aVu6g?=
 =?iso-8859-1?Q?PW7iO2dpPDoe/rIMgv2Xn1WISksVQS8Tu0Zul1HiikVAGXUaYAnDzkawFl?=
 =?iso-8859-1?Q?LeJFFTKefMxt2JYMHA8Taqzo5jGchozT5g1LCjX3HzVO0w2XuufC6qtTxU?=
 =?iso-8859-1?Q?AgydN9tlhG9rk7Q4uHp2h+6jDboKp52x5FTuklww8n1Yy2ykeS8pN9H/R8?=
 =?iso-8859-1?Q?43UG+ckNItXeh7qe7eOBnErhkcWsXD2FbCCq0E8Ib8lJ6yBREwPKOrRA0O?=
 =?iso-8859-1?Q?FIVvPI1pFk5wgFqztHLM2tC0BYLXBhEXKbj1tQhNAlo/zDUuAN3zpuJJ4G?=
 =?iso-8859-1?Q?G5Re3b4x7iF4ffDpu0mNAtsWXzROaQxfC9rdVaqpYsvP0UkNajcTm6MVcK?=
 =?iso-8859-1?Q?XPSPUQCx/8OBUb1HdEyVgF1bpRwYQHA7LkNPGPFiyytmyzo++keOSP1/16?=
 =?iso-8859-1?Q?C2UymjkOgtCtyS3voyqq3gadgICaDC0mrSS9ry/8mqC2+Y0xtmELa6e+jl?=
 =?iso-8859-1?Q?EBX3GmmIktc6Fv5URElw7i1Z7w7CoGiO1emNOVYlpnhZP2AsJrz3PYoGKZ?=
 =?iso-8859-1?Q?twQpaqJSF7o1jd6EqSlOhjE98PTjyg5A35Ih6AWC+ppew7vBuypObi8uyz?=
 =?iso-8859-1?Q?5bq4x88TnZ92eL41DHhKA6bW3meWaG/50sz+4IvPOBeFoH1zaIugDoj+Cf?=
 =?iso-8859-1?Q?mG7pUTSLvfVCWkukl3qi09pMGih+5/eIM4sY8KumeS0ruCIZupK11s1oYD?=
 =?iso-8859-1?Q?YcxWCosDKmkcf48ANFdzFP22LPXAvqHUtakPxtlvkLMTkHn1v5EcjyuNjI?=
 =?iso-8859-1?Q?rE88Lefa8LAE+BTXTdiVkmq7F2DYxVg/OD0J/vJ51InjN4+2TYV+PNDbO9?=
 =?iso-8859-1?Q?GpFM4DtSrzNKjocf/INXEd7bMp5u8S3a+fo8Y7LM8IJIP2bJUC5ZT26oNt?=
 =?iso-8859-1?Q?hh2F0eLqsgMv+sAw1iBthufo9bg/aPhK2UJ2AcIIs4PQc2itr9u2rf6X9E?=
 =?iso-8859-1?Q?oT1CTVqM1DiYnSYYStlrpJ2zmZ9pLYQLQfHA7IRcOzAsXsmTYLnWZHzDvA?=
 =?iso-8859-1?Q?exQWg6uOMzu8FyGBLcxNYVGQoJ04+gQeXeEc+4hcmIWZvFg0Z1zgm7oQM9?=
 =?iso-8859-1?Q?qGaAS15D+kqQ/Wwkp3TNDPizfx1Op6W0bjiGZu8+tqEo3RWouwGkJRmoqq?=
 =?iso-8859-1?Q?fzD775uLCjhsIPvCY/hIwOoagJWqX9mhk9atuTcz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB4674.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a25bafd-12a1-4132-27f9-08ddce3e5979
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 01:22:14.0327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d76d361-8277-4708-a477-64e8366cd1bc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6FkPzXAJmA3YJaiEvwKz8ISC2QelLDDxhB5TzDQ5py4WEgdIJBRpoPitqdh13EKEKNkdjIOJ9+eK2QTwULGVvyi/OSCvcNux/BuwWNENCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8117
X-OriginatorOrg: northwestern.edu
X-Proofpoint-GUID: DydDdN7YB_9EXGjmqi5NTsQgpae3J5HR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAwOCBTYWx0ZWRfXzX9USwUAgSFB eAaQ4CT2XNZ6bKreUKWzLrmCBehDCUQ8TeBL78VFmwb64HoLbb91peQIGbtO4nu6ZgwbVymoBrM lELN33Ad1akjJZKGU6vZK6zKJzZIVbqZwWF3RiXhSb9CzAdHcVQyYLfyUmgSMxoFXjv+ssiw1T4
 QUlMpG+2vJM72zR9IdBT6HwXxEXgImgnHZS5gE7py/ACDvUCKb4qTGMeug8RvfCB5P9OeGJESkg l9lzn4/hnz9csm9HSWOVyrK7S62eBBbfG6HDFW8791hQAszS8kVQyxQiiovNCGghCjIKXIcfrBk URndkt0g5KqYKHRbiUfJqgsTNkn7lsRAQPeoSeAZE5Jv5vW7V0+bwa7a9U2IF5ZSV+YD/ocsVQH p5kuGsnL
X-Proofpoint-ORIG-GUID: H7aLVPFMyM3hfyCjb2QXGNOHVbB6qagC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_05,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

In dbAllocCtl(), read_metapage() increases the reference count of the=0A=
metapage. However, when dp->tree.budmin < 0, the function returns -EIO=0A=
without calling release_metapage() to decrease the reference count,=0A=
leading to a memory leak.=0A=
=0A=
Add release_metapage(mp) before the error return to properly manage=0A=
the metapage reference count and prevent the leak.=0A=
=0A=
Fixes: 51a203470f502a64a3da8dcea51c4748e8267a6c ("jfs: fix shift-out-of-bou=
nds in dbSplit")=0A=
=0A=
Signed-off-by: Zheng Yu <zheng.yu@northwestern.edu>=0A=
---=0A=
 fs/jfs/jfs_dmap.c | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c=0A=
index 35e063c9f3a4..5a877261c3fe 100644=0A=
--- a/fs/jfs/jfs_dmap.c=0A=
+++ b/fs/jfs/jfs_dmap.c=0A=
@@ -1809,8 +1809,10 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb,=
 s64 blkno, s64 * results)=0A=
                         return -EIO;=0A=
                 dp =3D (struct dmap *) mp->data;=0A=
 =0A=
-               if (dp->tree.budmin < 0)=0A=
+               if (dp->tree.budmin < 0) {=0A=
+                       release_metapage(mp);=0A=
                         return -EIO;=0A=
+               }=0A=
 =0A=
                 /* try to allocate the blocks.=0A=
                  */=0A=
--=0A=
2.43.0=0A=

