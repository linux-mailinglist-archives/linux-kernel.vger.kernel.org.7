Return-Path: <linux-kernel+bounces-834721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79925BA55CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE8D3B46E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4A291C11;
	Fri, 26 Sep 2025 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kY7cMn7K";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XIeqzbDo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="n/eBQtqh"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7318E3F;
	Fri, 26 Sep 2025 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926643; cv=fail; b=TvnCoI2HWrlH7WavUYhOjSO1LUfcdbCuDUUdg0Leu0p9RD/px5TuHT3zkvCBLwRX8AMDNJW/pKqMs/cnDqjjNajmPjBoRyDK1+KfO7SaQ1WpjTCOCZrxep6r/hzVtzRSLulD5wE+nX5rpII/cvKl42t66CMWUSU+5u9guHuytVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926643; c=relaxed/simple;
	bh=F9TzTukgeZWYT1E5QQz6MzoYY/0cBg6l11zW34cXpk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxjV/EIk7CE2I6qdQ9verWRMKzhiT9yEak/mQwciLjx1bytUllMAkqzuf+JH8x1muUH2CR4fearW4wNaL9UJO7b1pvPZC5bnkBlWLlHlrFCcuwEXvXd9qhUxpMw/MKv/J4cWHOI73NNnWhvbRBqmWC4+8c1yCjHAFOfzi+laUrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kY7cMn7K; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XIeqzbDo; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=n/eBQtqh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QJw7D4010061;
	Fri, 26 Sep 2025 15:43:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=F9TzTukgeZWYT1E5QQz6MzoYY/0cBg6l11zW34cXpk0=; b=
	kY7cMn7K8MyT8C5V2Czrzztx5ooDcG9wArbahNxhpBKXR3wudTVmdepXdn5Svyae
	j8wSd6LE72+mMe9fK2BCxVRan/7n6wGYQ63riMOnWC3UqrfKWAF6D1QqvqmR+rcK
	aDU7+h/r2puUAkeBl4CHfRJuSjft6vRcoZF8IkHHH+13GRXaMH7FdkjwXd5TKeHq
	aX5jx/lmJsV4xTbRxrEC6OvAyXYj8EsOMNO5Pd3T7qXpvF3hjI1c6hahzUBq4FEQ
	NvUupx1FtCZC1nwXHRFU0ZR63eavMlveI3vxGkfbEPOhYJp1uSDoSmKTLjkvAm6I
	bKKcloSA7phpqOydOcBp0Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 49db0txv6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758926591; bh=F9TzTukgeZWYT1E5QQz6MzoYY/0cBg6l11zW34cXpk0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XIeqzbDotDmQUqimzMGPOLi2vvkvNxlaSkzhjeFpLhDJmytPGyQiY/tivJEU04LoH
	 CEgInMrlLjaByno/cf27ltcPcSheLxg0S2d1uM28Dsu+q/1PH5TuCgG075JnxjajdK
	 jOmKTrzBBc4hL94DKGarp8pP1QxEyrX0zjbYF+ldbz+0CE5VIwBUiSMzFJXPsUQHlk
	 EJNBweD4pwMIxQ0TJ6z/CfuLQyELftht9ne3ApkeusqG/ZKtvQWjIuMCiBl3swlTa+
	 Elz6ISyHH/w9xnrcAq6VOqR4eeRR4+0oLOCd3L1dYpuDZ56m0Ev0xYD93fKrAKcJTe
	 SWy8be9ghQz9g==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 345C240515;
	Fri, 26 Sep 2025 22:43:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5FDEAA007A;
	Fri, 26 Sep 2025 22:43:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=n/eBQtqh;
	dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com (mail-sj0pr08cu00103.outbound.protection.outlook.com [40.93.1.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6C36C4013F;
	Fri, 26 Sep 2025 22:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnETcYX+i+JRl7F5fQq4hPVidcTG+XaaqrCB54wtzxzApNgSHU8tu1KAWNciT0iQ/NTW7M2uFOfnb7pY/GoHeMtW+KJQAtx3AX+MHbRcCBG7CVToOjjbSdjd+1gVI2/U0sdvpa+82AhgiUD4OUa7U4OgmDMTc/QiAVFdaLaEyvlWwyCvAd0PVWAFBfitvkrzYc7l8PIkTaKLKlqHPXRvAdFLvdT8kNs0CNCtNxvLcZQC6bS13gPjJ7qTumIAKZFAjXGa2viT6wTPbMJK5C9xfPYO16qwBSREBHV76tcTPxuBze82Cj/PKDmuFZByRyqgaMuE8423QC9Yfz9p9CMI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9TzTukgeZWYT1E5QQz6MzoYY/0cBg6l11zW34cXpk0=;
 b=ysdWu2K4rYYk3Iwlh0mHpP6ucf3s1POqowYYAxi1YQPiZif77J4A2L8Wvb5rs/ahoRy8KkSveNl0sHlpRqetfMP3kti9whD6/gaQsUI4WZfkhshLUTU0bJRjJhQZX2iBcyzho5+EQTY9vM5so3crQx/0TqeUOXHdNjbrisweuJ0Mvt7g3gAjflpzdWm4/pGd6TabpyqTbAVsHaZh1cSr1SwqIHWkh36f3HeNPBbkIcotIB6t+CqXtoorqKqbVPqpwef/v18lCt+ly+quUmJq6ZqR4vEDy7nawQP3zU7LzSxyFutFnqExBViqIpvXX7a0w56hc4zSt/vYH368sqqh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9TzTukgeZWYT1E5QQz6MzoYY/0cBg6l11zW34cXpk0=;
 b=n/eBQtqhZ6bXm5fZRphIhDVLyxJYMBQUv6aejUAoV6w8rrhedetBTQYJD3ZAdCw5BlGJ6wiA5AZISfoAGwQjAKxbPfiSqg03m/MTXSNuGZ0x3Wr31Bqd+9X7hDyWq/ttA899vdwGNvj9UpJ04ONgbumA3BPR59xiW9ft/8YE124=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 22:43:04 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 22:43:03 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Frank.Li@nxp.com" <Frank.Li@nxp.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v4 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Thread-Topic: [PATCH v4 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Thread-Index: AQHcLxItOL4kq5x9WkWcbDHlzaw1hLSmD6kA
Date: Fri, 26 Sep 2025 22:43:03 +0000
Message-ID: <20250926224256.xxf5lobht4dndixz@synopsys.com>
References: <20250926-ls_dma_coherence-v4-0-21e9c6bdb5cb@nxp.com>
 <20250926-ls_dma_coherence-v4-3-21e9c6bdb5cb@nxp.com>
In-Reply-To: <20250926-ls_dma_coherence-v4-3-21e9c6bdb5cb@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB8117:EE_
x-ms-office365-filtering-correlation-id: 34ed945c-3252-4a93-4c98-08ddfd4e0deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVRTdXh6c0xUbHNDblBFMlBweWF1YnFzV2srZjcyMmt4NnhRa0piZGZLZHp2?=
 =?utf-8?B?SWFLQUVQcWUxaktxVlhzQ0EzalpCc0JFSzVRTTk1N1BVMlUvZUdLOC9WaDQ5?=
 =?utf-8?B?SVJ1OFJKNUt0ODQ3OUthOWMxRFBkUk9zWlUrdXpNSzhTL3RRcU5HTDZuSU9F?=
 =?utf-8?B?eXBmdlVFQlB0RldDamVHdkw4MFRUUGJtRnJhMXZkRWRVaUFTYk1aektlQWRr?=
 =?utf-8?B?SDd1L1BCb0NSUjV2eW1QV3lDMldGcXJvVnhVMkpEdUpXYzFlTTgrTVVVWG9a?=
 =?utf-8?B?KzFFbDFDdEZNNTRsMjZhL1h6NUQ3cFhOV1VpUlhSM1RBdVVJT0xCS3V2cnhx?=
 =?utf-8?B?V3B6QXZPbVdJa3YrZmhDajVNeThsUlo0Y09qLzNCdlVUbzkwdXVaaGlEVnhF?=
 =?utf-8?B?SDQ2VmFsaCs0emtJN2ZucHZGYjBETzFHeElRY3BzeitqUGQrZUN4WlF4OG5U?=
 =?utf-8?B?L3F1aFprS1pUaWFUSVdwdW9ueHd2ZkxndlhuWnNRdElrK09hcjhGYU1VaDQv?=
 =?utf-8?B?cXd5OUN6RnAvY0w3NUxkOTdweU1rYUI1S01sdEVzdzAxZG1ySFYvZTV2ZDZs?=
 =?utf-8?B?SWxxZjB1NWZRbFFwZ1pXWXJTY1lRL2dEVDdBYkp2MjFPdSt1aFV4dVRLejZI?=
 =?utf-8?B?d2JMTFRscHBGSVpFMndmVDJNUVNlTGE1WGIzTENRZk03VkFQN3RSU3hHR3RG?=
 =?utf-8?B?N2x1WWNpRFVMSmhXdFBleTVyWUQ1TW0vWEZQL3RMM0xudzdob1daWDRLVTll?=
 =?utf-8?B?enZtVEZ3NkZDS2pDSE91SDVIVU9FN2dsUTlrRFVOQXlVU1Q5VVpIWnA5b2Js?=
 =?utf-8?B?bjdMblp5WFd5QnB1TDVyUmlUN2g0cEtHNHdncnFRaXRwbER6SG5mb1ZMSjFw?=
 =?utf-8?B?QXRlQnhJUENkMmI2SjRtRWszQUJXT2ZERFBhVXFDSWxNdDlVYmF2UGhmMzh3?=
 =?utf-8?B?SnhSODB4RVVXek5rWnJDbHBNOHh1K3ZBbVhuczF6Wjk2NnNNUDlUUzlhWTh0?=
 =?utf-8?B?aFRPeXkvODY2Z0dKdjljQVZ5akowTjFaUzZ4K2piVXFyWFR0d3FJU1hWa1hv?=
 =?utf-8?B?ZUx1eVQvU0V5UEEwL3c1R2d1ZStSU3RnQ2xUblNkNXk1NHh3Z0pWMk5XbHIx?=
 =?utf-8?B?c3V6Z05LT1dPZC9DZTdqOVZyenN4VkhuNWpsR1Zjb0ZsSnlsTHNLWFVCWTV6?=
 =?utf-8?B?TmVDbVhYZW5wYWNTWldkdmNrRlJUZ3lzT1ppVVo4STBpaFJCMENkMCtQcm16?=
 =?utf-8?B?djRXeHMwdUFHdkNzbEozamI2WHRNY05QZm1GSGtCSHM0MXJ4TVJsVGJKVWVw?=
 =?utf-8?B?MEdPbnJWZkN2eVRoNkIrRDdnb2MvSng4VkZqY296cWsvbXFYalNUYW5TSmZx?=
 =?utf-8?B?b3BNWVQ2OHJQd0JaN1VUYitjMzRQd0d5NUVjUG5ENXh1YTNtZHpTZG1rZ1pa?=
 =?utf-8?B?RjZqQis1Q0MrTkNKT2hVM3V5RlRjcEdTUWFtdkhsSStQbVN0dXFmN0xKRVZh?=
 =?utf-8?B?SkJNaDR6WXU4Z0pNbnpiK01kUlA3VEpCdUswaTRJUTg3SXRDMVZBUmQxcmk4?=
 =?utf-8?B?U3J1RThqT2RTT1BDdjBLZGlzSWc4MjNPRDk2ZHZwR2Q1MGtpOWtUZVcvSENI?=
 =?utf-8?B?N0R1Z210bFZCT2JiZWU1L0p3NmpGZ0kzZldvcU1GMXF3a3ZGWnJLZks4eWg2?=
 =?utf-8?B?Skk4TERLZXV3QWJEc2d6UG1mUVh2NUxVWWNBY2xFMnVwalhsQmpaZE8yL2Nm?=
 =?utf-8?B?OW1iRnp2SVJyN3VoTW16eVJzbmdvUTJIeXBvelF1djNlb0doc3J5b1V1STEy?=
 =?utf-8?B?VnJESkZhMjEwcmZFOTdMSVV2Z1FhOHFMeFQ0K1RkRTNOdmE2UFlwVUMvU010?=
 =?utf-8?B?SWpaUFhCalRubEJUTklSU1g2TTZiMFRlZW9zd1dCRlRQUWpQL21EejVCZ3c3?=
 =?utf-8?B?T1oycDhJOVdBcktWV21SM3hiK3JEVFY1UDFwZkh4RHVnNnJsd0grVk5SeGRx?=
 =?utf-8?B?YzBuUVlWZHRiOUdPVE9DL0ltcHM0Y2ltT2RoS29McUFuSWRwZ3dxTHdBL1Bs?=
 =?utf-8?Q?o6bFO8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGlwMjJaa3R3K0JjMlBMNmhQZlVpQ1B5Wk1lRmhkNFJIQkY2azlBRGNYZVFM?=
 =?utf-8?B?VHR6ak9ST1pmL2R5bUxXK1FNUnl1NkZIcXVRaFNpeVVjZWZ1d2x3ZmsxQUJO?=
 =?utf-8?B?RjJneEtKWmljOVVCNFI0S2tDWC9BdFp2V3hxd1MvYXBiSWdFUVlvT0haQldG?=
 =?utf-8?B?anRrWnpVVFNubEVyT2daZ1czakw1N0Rvb0g0WUwxWUk3V1ZJRCtzVkVNRUpn?=
 =?utf-8?B?ejI1VHM4T0tKcysyOFRYNm5pUm5HeEx2L09tNXNQUXR1K2JrSTkxRFBQMFpG?=
 =?utf-8?B?dVhkcFZER2dPdU5VZVF3eGJzbnJ1am5TdW5wbTB0a3FmSm10YmNvM0srYXRw?=
 =?utf-8?B?VFd1UGxDWnFQMkJUZXp0QXd3R2NTN2xiQXFxT0RyY29GcEtXMTB3a2QzMVhZ?=
 =?utf-8?B?TmY2YUhwak1oUkpRVWVFWitGN3BlZ0xTTHdhVnpkc2Z3cCtuanFqWTJSMkhi?=
 =?utf-8?B?Vnd2L2ZZK2ZjY1lKVmxUNjEyclR1c240ZGFCaEZWRkNlQ201R2VXQ1FEdjEr?=
 =?utf-8?B?V3locVovYVNGN29vVXNMd2s2OC9hYU9FOXVoWFRKeG5oeFVLVDc5Nlo2cTQx?=
 =?utf-8?B?c2tvOVk2WUwyck03V0NsV2gzUVBIdE1SY2N4ZXVKZWNYSXRScG05K21uZGRl?=
 =?utf-8?B?NkFuVTZnckVITUZSMmJ2RVBLU1cwKytHZHV5MmM2UUhvTDQxaVdWc3AvcVRx?=
 =?utf-8?B?dzBMMi8zTmlsbzhLakR0NmkzSEpHT2dCdzNCZm1RYkVLMzkzdGxsQUZ6WGFP?=
 =?utf-8?B?T1pZNzU5SmpqakpDaE1KelJyZHplTnN0VzVla0NqUXV1Sm5IYURMaEFTVVNl?=
 =?utf-8?B?U3d1Zml1ZFZ4MWFKdkFGUGNEbG5GM012d3ZldHoweGZLQnRIUWdkL0V1SVho?=
 =?utf-8?B?ZnRBYmdRV0M4RnpnTmJYL2RneUZQWGtrRVRKRk1UZnhxQXY1WnQ1clgwdXVP?=
 =?utf-8?B?MTNlaWV1N2dMY3hiQWErZ0xFV2R0RFhuWTNUbm1ZSGg1U1o3Y1oyM01oZUpH?=
 =?utf-8?B?Q3p5c2pQTFpqU2lRQ2R1a25vUi95c3NCVnV6MWVSRE5zK2tiRUZVSFlCTjhw?=
 =?utf-8?B?ejFmN1dYeTlUcFNrcFdHZGs0UWVYMEtGNEh6VGgvYUR2TktxbENlU0FiWFpM?=
 =?utf-8?B?Qy9CVGd4c25CYTUxTHVoQUtrWTFxOTBHMXRFeGs3L25mTUxremw4VC8zK2E0?=
 =?utf-8?B?N1BOOWJFampMVVljbmxFZ3NOb3JmMHdFY1BmSGc1cjZPeWNERllJbXFQR0NB?=
 =?utf-8?B?VXRhWUM5aWNFMFYrMHRYYWVYelBaUzdmbE44dVVoTlVTb2t3RHdwbnBZY1RR?=
 =?utf-8?B?TDE5YjJhYlJPRG5SaEhtVk1iTW5UWjZuK2Vwb3BYWlRObEtxN2pmWTM2eXdV?=
 =?utf-8?B?SVlETTFFRWl3cWZweFZ1dFRVZzMzWE91U3A3ekxRbjVGTjVIc0xxUmpVcHEw?=
 =?utf-8?B?bjJvdHJBQ0NSWk5LaVhrYWNQYk4yNENqUXZUNUR5dFNJa0dOVG0xQXFFaDJD?=
 =?utf-8?B?eDhVbEd1MGhjN0kzcDRubGhPUnB5TWZUbUN1Z2JGbG5TQ0JQSzJiWVNRTGJW?=
 =?utf-8?B?T1BuU2FDcllpak5jZjJRN1JnMlF4WE5YaWdJS0xJajNodDFCQXFtK0NXRWdG?=
 =?utf-8?B?RTArdDFOczVxbFV2ODgxcmRweXdZd2VRNzE3Q0hxbUxtYXNqcHpDUWQ2MEZn?=
 =?utf-8?B?L2JqV2kwSVNyRE5hL20rYkVGQkI5WjVaN2NDdEpSa2dTM0ptZjBqakl0SkZO?=
 =?utf-8?B?NmNITjZDRjI2T3NtdWs2TTV4dHhkR3YrSWpBR3FyMitBSVdsaTlQejRkby9w?=
 =?utf-8?B?UFZkK2xyRGhKL3cyeHpVa2JtTnBjVGVjNjB6MGE5L1N4ME5ETWlhQk5zbmJI?=
 =?utf-8?B?c1FRb1kyNW5XTE5IUDJzWkwyMEJobUZpRzBaTlErRlRvc3MxeFZXQXMvTEY3?=
 =?utf-8?B?N1RYZnRtaTJjOWt1TFMxak9FQlp3b0Irbm1mT0Q4UGN3MWhPZWg0Vjhnb29v?=
 =?utf-8?B?dVBlbXlHQTlKcGlnSVpKQnlNc0hPL01VRmhJNFR0c1ZNVXJDRnF3Zm5qajRN?=
 =?utf-8?B?cElDTDZ6N05QL3ZMRGpCN2ZZQTVsTTRiREFXQnJZSUlUV1NtWlBxR0xvOERY?=
 =?utf-8?B?M2w4ditpYklkT1FocEtnbjdMZlphZHZWZGJ4cG01NzNHUFhHSnlvcTIwRmJh?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44002C81A8E6724A8BE6C82080D2395D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/ZhrxaJ80zeUbsvtJ+hYL9MVsl6KeL09ImFgQ3J40mYArbWUY+VW7dcBYqiKi5CYDTXSGxJr6CPWQR+x9cmMJ2XA44Zm00Vb0XovFEZVP5HmIrV0g057zN717sAOfbZRlvnMcNsMRlsl/wljhgFXqrkG3eOBJJd5UPGTgg8VsRCTntwUyp/FUuo1fDk8yZLWFWBHuadfjfMDII4Astq3uhTTNqMAUdCmLmRpOKBIgAGXGVaeTp/0dVpjpBhcqpB5IvMwHhIX7giw1c7dAdcwu+XJek6+En08Th2hY85D+0nTtKab/4gmim7TSiVB4ehw26aez+MTwPfhSv/UW79LmJ4biHCkTlgnyd+oz//mXXRE6x61QErxmzatjvAHPbVWVA325e9l0HSPAfcogFvrAcCzLwLXJsGSefHgDbfsGU1ajFwct0ORHXqBo0d8bkW+vPhTtW4E7fAjGKr1uxBmbmOkvSJhvjVXPgTSoH1xOLtTVLWJPvsbgBxRzLxF1gkVi2HuT777GOzQH+JBgtiKO+4GeAegRk0X4zpKxvZcQHMoU87GCkMhBUbidqRYR7X3zQoUy0j0C51BBD20/5EzbEPdvFSlqAUOOz9qWpLGgXZss3k54PUg+azSzchAY5S16/q3ehcXEnHFHhxdZllcoA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ed945c-3252-4a93-4c98-08ddfd4e0deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 22:43:03.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFBIQJbgP7Ba5op/vEdYhVQty2Phzh8d4FOJThe7Q30knHatXZbWs1IdeaeDywjtDRZjAbfB3D2hOCJdO/lUHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
X-Authority-Analysis: v=2.4 cv=YaKwJgRf c=1 sm=1 tr=0 ts=68d71700 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=8AirrxEcAAAA:8 a=zWFcsTb_qQtHCfoxhbMA:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: RX6A0tFdhKJ90WpLvv0qtWeXx99K3Dq9
X-Proofpoint-ORIG-GUID: RX6A0tFdhKJ90WpLvv0qtWeXx99K3Dq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXyoHDKn59PI3Z
 P2TP37tSlBGA1AJXhy2wfjKBKZpD5IPffV2Ib/EjoSa2CuW/r6wIVYhLhjGYFBJbGzTXpfWmYy0
 KjaJs1dihWGZ+f4pl48PqEj2jAOuiwJKpPLd4Y030xzOzbVmwKtvxHL065Z+3/D6tD21IMGbCdD
 dl/tdqlqNR12XqzsAN4zhB5NjxSO1V8K6dbziwi0AyhW8gvTZ0fsbHvR509jU5UFxetlDC0F/oP
 YrPWuoWGM55XavCBfRw/oW6930OK0UzDqvbkq29Wqmkl7ovmeLVcNBh5k2nsbX2Hl1KrezgpTh7
 ycL7xKWsQ2ODde1K8hR6zGsACtqqvTK53vQoY4TTbmy9RW9eSzfDY0GtBJddZjp9+Ql3XYTBHJ2
 TtKGAes1VEKQmcgWQ4tKhQH+m42+BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509250171

T24gRnJpLCBTZXAgMjYsIDIwMjUsIEZyYW5rIExpIHZpYSBCNCBSZWxheSB3cm90ZToNCj4gRnJv
bTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IA0KPiBBZGQgbGF5ZXJzY2FwZSBkd2Mz
IHN1cHBvcnQgYnkgdXNpbmcgZmxhdHRlbiBkd2MzIGNvcmUgbGlicmFyeS4gTGF5ZXJzY2FwZQ0K
PiBkd2MzIG5lZWQgc2V0IGdzYnVzY2ZnMC1yZXFpbmZvIGFzIDB4MjIyMiB3aGVuIGRtYS1jb2hl
cmVuY2Ugc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5j
b20+DQo+IC0tLQ0KPiBjaGFnbmUgaW4gdjQNCj4gLSByZW5hbWUgZ3NidXNjZmcwIHRvIGdzYnVz
Y2ZnMF9yZXFpbmZvDQo+IC0gdXNlIGZsYXR0ZW4gY29yZSdzIHByb3BlcnRpZXMuDQo+IA0KPiBj
aGFuZ2UgaW4gdjMgKHNraXBwZWQpDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLWdl
bmVyaWMtcGxhdC5jIHwgMTUgKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5l
cmljLXBsYXQuYw0KPiBpbmRleCBhZjk1YTUyN2RjYzI3YTdhMTRkMzhkY2M4ODdmNzRhODg4ZWQ5
MWU2Li5jZmNlZmVmZmQ3YWQ2YzBhMjFjY2M5YWFhNDQ4M2I5YWNiOWRjNGUwIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9kd2MzLWdlbmVyaWMtcGxhdC5jDQo+IEBAIC04LDYgKzgsNyBAQA0KPiAgICov
DQo+ICANCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9h
ZGRyZXNzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvcmVzZXQuaD4NCj4gICNpbmNsdWRlICJnbHVlLmgiDQo+IEBAIC0yOSw2ICsz
MCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2VuZXJpY19yZXNldF9jb250cm9sX2Fzc2VydCh2b2lk
ICpkYXRhKQ0KPiAgDQo+ICBzdGF0aWMgaW50IGR3YzNfZ2VuZXJpY19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiArCWNvbnN0IHN0cnVjdCBkd2MzX3Byb3BlcnRp
ZXMgKnByb3BlcnRpZXM7DQo+ICAJc3RydWN0IGR3YzNfcHJvYmVfZGF0YSBwcm9iZV9kYXRhID0g
e307DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gIAlzdHJ1Y3QgZHdj
M19nZW5lcmljICpkd2MzZzsNCj4gQEAgLTc1LDcgKzc3LDEzIEBAIHN0YXRpYyBpbnQgZHdjM19n
ZW5lcmljX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcHJvYmVfZGF0
YS5kd2MgPSAmZHdjM2ctPmR3YzsNCj4gIAlwcm9iZV9kYXRhLnJlcyA9IHJlczsNCj4gIAlwcm9i
ZV9kYXRhLmlnbm9yZV9jbG9ja3NfYW5kX3Jlc2V0cyA9IHRydWU7DQo+IC0JcHJvYmVfZGF0YS5w
cm9wZXJ0aWVzID0gRFdDM19ERUZBVUxUX1BST1BFUlRJRVM7DQo+ICsNCj4gKwlwcm9wZXJ0aWVz
ID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+ICsJaWYgKG9mX2RtYV9pc19jb2hl
cmVudChwZGV2LT5kZXYub2Zfbm9kZSkgJiYgcHJvcGVydGllcykNCg0KV2h5IGRvIHdlIG5lZWQg
dGhlIGNoZWNrIG9mX2RtYV9pc19jb2hlcmVudCgpIGhlcmU/IElzIHRoaXMgc3BlY2lmaWMgdG8N
CnlvdXIgcGxhdGZvcm0gdG8gZGV0ZXJtaW5lIHdoZXRoZXIgc2V0IGdzYnVzY2ZnMF9yZXFpbmZv
IG9ubHk/DQoNCj4gKwkJcHJvYmVfZGF0YS5wcm9wZXJ0aWVzID0gKnByb3BlcnRpZXM7DQo+ICsJ
ZWxzZQ0KPiArCQlwcm9iZV9kYXRhLnByb3BlcnRpZXMgPSBEV0MzX0RFRkFVTFRfUFJPUEVSVElF
UzsNCj4gKw0KPiAgCXJldCA9IGR3YzNfY29yZV9wcm9iZSgmcHJvYmVfZGF0YSk7DQo+ICAJaWYg
KHJldCkNCj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gcmVn
aXN0ZXIgRFdDMyBDb3JlXG4iKTsNCj4gQEAgLTE0Niw4ICsxNTQsMTMgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBkZXZfcG1fb3BzIGR3YzNfZ2VuZXJpY19kZXZfcG1fb3BzID0gew0KPiAgCQkgICAg
ICAgZHdjM19nZW5lcmljX3J1bnRpbWVfaWRsZSkNCj4gIH07DQo+ICANCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgZHdjM19wcm9wZXJ0aWVzIGZzbF9sczEwMjhfZHdjMyA9IHsNCj4gKwkuZ3NidXNj
ZmcwX3JlcWluZm8gPSAweDIyMjIsDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBkd2MzX2dlbmVyaWNfb2ZfbWF0Y2hbXSA9IHsNCj4gIAl7IC5jb21wYXRp
YmxlID0gInNwYWNlbWl0LGsxLWR3YzMiLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGxz
MTAyOGEtZHdjMyIsICZmc2xfbHMxMDI4X2R3YzN9LA0KPiAgCXsgLyogc2VudGluZWwgKi8gfQ0K
PiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGR3YzNfZ2VuZXJpY19vZl9tYXRjaCk7
DQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KPiANCg0KQlIsDQpUaGluaA==

