Return-Path: <linux-kernel+bounces-790845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9821EB3ADF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548755834F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C312D0C91;
	Thu, 28 Aug 2025 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qk8ON0hF";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fMguAEwK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uiwrUMFW"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB72BE653;
	Thu, 28 Aug 2025 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422446; cv=fail; b=tRmzJQ+TJ9CMqVTmyjetZsiGbyV94qd3Id7eQK2X9rXzrJL8Q/cPEfzy9gYgzQ94sbQoBaqQeUPPEiQ9SDCN4E2b+Vx6ZUkw3tWD4fRg22XLX3dXEjK8gEmPGHgwSKCLiUuOWjrNAclULSVO9Ar0bdBM6yfq/lt9CZk6/AmwEM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422446; c=relaxed/simple;
	bh=l97dzugPHlT2IOiy/iCft48ZckOZRAivC6YLFHGqZog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Og9zi6gts97F5d2ntVaN4OlhwBZ8h5WlTAXRZIbPLLMxXnG/cvv2tXcomaJ6MgfhSYWVT1IjYpnM6E8WSga+8w76uzzX/YeBhljnsriijzsc+VMzDXIB8Wz4M15o8GmWEjN91Qie7f1DcilJjkWg0zBUMeKyKiscz0rC0MvKe/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qk8ON0hF; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fMguAEwK; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uiwrUMFW reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SJNZSo019959;
	Thu, 28 Aug 2025 16:06:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=l97dzugPHlT2IOiy/iCft48ZckOZRAivC6YLFHGqZog=; b=
	qk8ON0hFXuLfkdfOUXA4f5e0DHRmPdwGWawQQu/osByElHkEIi4yLV181IEZfecP
	gyRh0xWrbwvazQ77IpSsoKFEg9YRojwXZSDdUxnmFkGosUQv0WGvUSP3+Tacedy6
	uNAWQS40RZudNlN12vBuk8M3fcvqY62cf8Oec4rmAR/j/3yi1/8xH19hDhLugOv0
	rNIIyrPlXrhjQWuLQ+XS3TA0dEC7/rzmdre2raBBKvf3Y1rkZFTnbo+5LWjE1MOl
	o2aAloHNZRleU39Q2Nw1dwgoDzAg1mgDN/2k3u8wGKJuA1o4c5avYa9D0Kd8+Nsm
	997Pmgn9YdcatJfGQb5eZQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48rpxspfwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 16:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756422380; bh=l97dzugPHlT2IOiy/iCft48ZckOZRAivC6YLFHGqZog=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fMguAEwKgq0avys27/IekP/tCkYdKrWacTsxV1zL+W6b8QSU9h6QADtpN7NRqc+lC
	 SyaAiDlgOFpaSfdrM8Fbg/+pII/CzNa8PrUtGpeMHwD2s8+oXcVtSCX8TeFwoiziQd
	 vJlkivk+ECdDuHl0Vh9sd3I4KJ5OZjOa39CJ+J6wak3YQZS7gYNWNQ7bNmUaR5IAZw
	 QpuETEbuMsCyJ15iqjXK4lSk1Vty/v/beJegTrXlkKqJMAY91dsWf4/85FYHXdl2ci
	 IbOhDsuuMTquRyraofwwLu+mcpUmIp+AlD1ImwXGOTSvP+AnHDxwzxGP50LJf+++fx
	 f3SXRy5q3j9YQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D45FF40725;
	Thu, 28 Aug 2025 23:06:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D63FAA0070;
	Thu, 28 Aug 2025 23:06:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=uiwrUMFW;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0199540143;
	Thu, 28 Aug 2025 23:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4sBh+tlMVij8E+DccF/F+JwRCBBCWAXkyHK5le7wpopAYFTD2uT7bAKLFl9FWjybItLm3bh+U3YQwbUKYPMujVSfCZ8uMfg5vJKFBN6aLFrnb1pLutzgmIH1DAR6PM5CCGRxe58p96nKvbIkMibmHXGSeSw3IyNbBwS8UTTKnHgrlA02EbVst/RJSMC/FsLob5WIarK0bc/SmiR/P8+lN+odqV9ojEO6YPzp3+jN03EqjBO0y1B9KIjfetGxNInL3byBG+LiivPekbUalr1ymsnC/J8dBBSpqQFjBgO8p1DW5/dkxCSbqhLj61ekYDsiFiTMIMwkK9tyqdtZN1L7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l97dzugPHlT2IOiy/iCft48ZckOZRAivC6YLFHGqZog=;
 b=kpaJ7rl6J3baEsXeltKVlptF0NZM0AoJdh8JWR8ansmp151BfzgihEi/iQH7ozSehfo8s/fGcmCM3sMN+HHX7e7dWa5nzLbLvk2jVRBerhocNQo/58YGgvyUxQjXs+BeSbYY6YZTUFHjr5LDS0kLvAIfZSZPWvSURjbg4uF86x1t677S5AEemlncgMh8DmcAU4qaWH4oFIA+6SG4G6bSQeQdRSQ+FVXT1LnyD3NFD07ky9iFEa5ATZ/eWhaAd95l8pRtO94/Fz4iug6CkRDYup8j341w9IezOblyeOYqR3svA6YMcHJEgD0oxy16OFGxyigXAfGdLw1Ujj0ArbuN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l97dzugPHlT2IOiy/iCft48ZckOZRAivC6YLFHGqZog=;
 b=uiwrUMFWv0/rC9Dy/ELfAiXqDNUom21UMYhsbhlMK657FFt4sW3YTnvFsvU5tatX7b+/af3cmQAeUwc8Fz6WVCuy/a/4siArFQ5UiRn/sB9uwzi146vzzNjH4aVDrZe6xoC2eJMAqt94qkFCneDSrHf+bAF9ieZv+3X5efqDYAM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 23:06:03 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 23:06:03 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Sven Peter <sven@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH RFC 05/22] usb: dwc3: apple: Do not use host-vbus-glitches
 workaround
Thread-Topic: [PATCH RFC 05/22] usb: dwc3: apple: Do not use
 host-vbus-glitches workaround
Thread-Index: AQHcErHluSS416vmfUq2Vd/rskyBMbRtsIEAgAJwBYCACJq3AA==
Date: Thu, 28 Aug 2025 23:06:02 +0000
Message-ID: <20250828230558.euvmnbgij46kqkeb@synopsys.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-5-172beda182b8@kernel.org>
 <20250821222842.fqrxjp56czc7ubok@synopsys.com>
 <c052860b-c239-43a6-b05d-c8495bc1c731@kernel.org>
In-Reply-To: <c052860b-c239-43a6-b05d-c8495bc1c731@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB6257:EE_
x-ms-office365-filtering-correlation-id: b2a5a82d-a40b-4028-fbf0-08dde68775fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTVYakJWVlk0ckppU0NSQjhpTnVkWHRoK2c5Wi81NHRDVjQyOFAzYVIzUU9S?=
 =?utf-8?B?T2dhdS80ZlEyUWtkZ3B5dWoxSDh1Wk5pSWJRZGFUZno3YlJyV1FvTFNrWWtz?=
 =?utf-8?B?M2xwMXlPZ09udlowaVM2ZENWNHVWYnc5OTk3OGNPeVVkK0FEMDl4SVVQQ1RU?=
 =?utf-8?B?ck80VklJaS8yNU12SVhnNDltVGI5SGZvWGx1ZFlPeFRqRU5XKzQ1OFZNc3A3?=
 =?utf-8?B?Qmc3UHQvUUlaM1JIeUNET3Z1MEsvRXNQeG0yZDdWanhHYUFmRUVqbzgyT1Y4?=
 =?utf-8?B?RWY0YXVQNyt4bXhMeUJLdnB5S1VvQUNYY2FLYzBKNXRVMmh5NkQwcE42cVp4?=
 =?utf-8?B?KzNyK1lxWW1aajZsRzFHcGNSSWhFN3ZNTGZsMi82KzdZTjlabitBWklZTkc5?=
 =?utf-8?B?Tm9Va1RWdjBYVG9Rc212amhuM1AwaHVrSWg2K1ExMTZsY3ZFbnNMZ082SWlF?=
 =?utf-8?B?aDRFb1BjMmNJZDJ2TVBNSUlBQkU2TXlXRXlMc2x0QThQTEVsTEFaVjNHb1dG?=
 =?utf-8?B?aFBjcXVMWlhhV290WWltY2p0RUJjN29MMHJGbm5vdkkvbTNyTGM5N0JhY3dN?=
 =?utf-8?B?Nkx0dzMrZDdaWEg2SURSNGRBN2swNkZMZ0RHcnNndVZCUTRMY01QV24ySUJ4?=
 =?utf-8?B?TUpJcjdLdkNJdmVyakRPeklES21zYzRhVHk5VEROanM3OE9MTmI1TzFPVmxZ?=
 =?utf-8?B?RE5Bczc2NmNDeGJ6V200Vm5ScjVRK0c5RS9yM2hnQ1gwRnFEK201R0kvMmlP?=
 =?utf-8?B?ZFpNMWptU1FMQ1krcDIwSEk4MXlVSDJjeDk5dXFZMEJDMGhLaGtwcDNiTHMy?=
 =?utf-8?B?Q0kyYWc1R2pnQ0VtMmJsNkRZTEhlVFg4d3NMUDdZb3pobW1VUXlyNm9VQ01R?=
 =?utf-8?B?V1hWQkUrQUJQc2U3c0VHbGRRNm9TOVRmZkZGNEdmSzlCOEtJcHhTWUlxVHJi?=
 =?utf-8?B?bDkycng4V1QxQVNOQ3A3T2dNY3VQSnhZRVdmKzVRdVJldnVUZ2RKN0FVeUJF?=
 =?utf-8?B?RFFWc2N6SjdIRnlmblp0SkNJd2U2RDFraEZFRTBFcTljcFBNbkVuYVZBUzZu?=
 =?utf-8?B?TExzQ0NOOE1JN0U3UGYwY2M0RE5mSUVyeGJ5ZlJlOFVEWGRRODBuZis4T3JT?=
 =?utf-8?B?K2tIR2VYTGkxd0ZCVW1mYTVTcXg2MTBUTG9INzJWOG14cGNlOW0zam5tM3Fq?=
 =?utf-8?B?emZYKzJuMlVYckRmMG1ValB4MVdNc2gxUkhEeFcyWFpJSjQ1MVVqdDN4Zlh5?=
 =?utf-8?B?endrbUFUMVNLRElTOGs2SWlPWWFpbVZWUEtJRnBUU2pSUE9saDRSUUV5aGRn?=
 =?utf-8?B?bEdRZU5MVUMxK25SWUtyRVZOWUNhL3JvV2I2TnE2dVhLNjNqeTljcUhOZ2Nt?=
 =?utf-8?B?bGtzaFBGdEhmT2JtQmp2U3JVblY0NFdublFIU25VZVZ4b2FqaFRINUFJL0p4?=
 =?utf-8?B?SXRQR09lSW45Y3lmeUFSSzVrTzdvYXJmbHdSZW5YcmJnaUY5eVd1T0hxY1V3?=
 =?utf-8?B?RmRveVVPVjRwdUxpTWU1RkFvdjdLdlV1OFVGc29ZdEN3SGlqd3NybkNJR3lp?=
 =?utf-8?B?SlgwWmpTYTRUaXJjNEdFMXJua3puRVpsdldhZ2xyV2NXcWFJYytUVWozTmFG?=
 =?utf-8?B?TDBlNEhDU3FCMmpIU3lXK3RIK1pWeUlyeDIwWk9aR3NpYStUeHF4MHRBMWR5?=
 =?utf-8?B?Q2oxUUxwc0pHLzZ0TlMybTB6WFdoSTRzTndhL0FLeHMyNFlWNzgybDhlUFBX?=
 =?utf-8?B?MHNCYWhzT1dsM01WQjNFOEVFTmhLeUZTaDdNdmZVOXNzZmZnandyaVF6VUU4?=
 =?utf-8?B?RGF0L29EemtCbzhic0RydUJEMUc1cHgzUGRBWFord05qMEw0cXRtYUhKUWM5?=
 =?utf-8?B?Y2tRYkhIUHdUZXQzT3lBSnZxWVo1V0hBQXFBOTk4SW11ZytkSWZXdisvZVlB?=
 =?utf-8?B?R0pmZ3RrVEFwQnh1VnUrM2xSSlpvMmg1S0JXN3pBWHdrdm00a25SenExcmti?=
 =?utf-8?B?TTkvaURFUWdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTNmaUVGaCt6WWhQSlNUTjYzSUFZeFpaTERkSXpXOVQ4ejF1LzJ6djhSblZO?=
 =?utf-8?B?RHBPazRXdUZyOTMwaDBlaDMrS1FFTW1ZTm5neWRWRVB6K2hrRU1OTUNtMzh1?=
 =?utf-8?B?aTRROFViNkFEUW1pRzltQjZuTitsVjlGc3h3aWRYT1h5YlhPM2s5RU11V2to?=
 =?utf-8?B?cjV1SEtaY0l0d28rejNxZHc4TVlucUVUU1FFcEVzQ1NKYjJFcjJjeHg0WlFi?=
 =?utf-8?B?RDR3cm05QkNzSHFGWWVGaUV1Q1JXV2pFK1NYYTNwb0g5Qms1QXpnc0RGTEdC?=
 =?utf-8?B?MUtIaUg1WXNjWFA2MzYxREdQMDcwTGpRL2NTR3FGVktMYnZvbTJNNGhIVGhJ?=
 =?utf-8?B?VnZOUFpZNnNsRlN6Y0FOaDJVY1FmL1BLU2RlcWM4L3JMY1V2dExhaXdBbElV?=
 =?utf-8?B?YURlNHdpVGxNRXJnbFJPazF3akZoaGNXZHlpeTRka25jQnFFdFRoMGZSU2x1?=
 =?utf-8?B?UW9QMnk2bnRLSE1tbTV0Tzk1L2t3Z1FHbHQrem8rOEVBNFdsTGZ0QkpQWEZB?=
 =?utf-8?B?TkpYS2xIQ3NsNURXZ1E5K0t5d3hyRUlpdnVWdVVRRzVjZUJib01kUGRGblFG?=
 =?utf-8?B?eVFjUjRTSmQxSEFNeTV6UU9BdVptN3lVcWJkbmxsaFk2NXVTbHNqc2g4NTRX?=
 =?utf-8?B?Smt3OXpnUlRaeURoMURVc3dzRndYSzZBSkcvRXdEWCtsRjE1Yy9nVHhQbkZt?=
 =?utf-8?B?cFBQanVRV0wxYzEzMlgyTU1IVXRXNVBmOUN2dUpnSzVrbExLUWRySEd6eEI2?=
 =?utf-8?B?d3FkcFN1N2RTckk4aXBoT1dGVDVjTy9nQ09WNDRzRksydVAwUFRrRUtWMTJG?=
 =?utf-8?B?UU8wejZEczYvb0VVNUJCSXc2UHUwemhQNkFqUzZpaWpHVko4MWptUTBoQ2lI?=
 =?utf-8?B?N0IwdEpDbVZwSHNCL2I4MUY2SzRtaUpHRzE4WVM4YzZqM1QwL3dYRFNoWnpS?=
 =?utf-8?B?Wit5Z2FtbTZ6b0E0T0tWZjhUYzlDTTRLelNrQ29uRXRNeEExOFVwck10Yno0?=
 =?utf-8?B?VmtPVy9jZG81Ky9zNElRL0ZiWUNJR1g5NnR6MXNNMHh5Y1kxa2o1THNUUHJz?=
 =?utf-8?B?amcvOEsyMFMwZHNBQTd4alRaR3hPcEdoeDhBNjlCbmw1Vkk0SzV1UnVSVFV3?=
 =?utf-8?B?bHk5UmxUdVZxK2VmaW13MEFHcFYvdDM5THhHWEpDZEdXaGZYeXd4bVc4bC9R?=
 =?utf-8?B?aUJ3ZllqYU5uSnhHYjN6M1FJcXkwZ3NadWtVQmtuRjFCVEJiZStNM04rWlht?=
 =?utf-8?B?US80ZTFtTUtNSUpoTzVhc1dkck80YUNBaGxpby9JTW9YeDlhQThNc05IRVkx?=
 =?utf-8?B?ekhaZW5UcDBON1FBM2hOZTRSRDBBbVYxeU5ablMvcWlBeFFpemtVUGkwME9S?=
 =?utf-8?B?VXU5MnN5OXVqZ2hrZ2tPaXhRZUV4bUV4VUZPdFBmNDcyc3RWeXdDNlRPZFJP?=
 =?utf-8?B?ajJpYTNhTDVuUUw3eFJsN2FiQmVqVEhJbkZ0Mnc3K0tYSERXWXkxN1NqcjMr?=
 =?utf-8?B?L05SK2hZbjdEaXJsR29PM1RNdTJaenJZbXF3ZitCdFVuVFFzSWRrRjRCakdy?=
 =?utf-8?B?N2JzQnRkNThVK1VNR1l3NTdwOVNtYVNEc2FqeUsxelFTVzdOaTdoZC9UYWEw?=
 =?utf-8?B?SEFPTjQ4emI4Z0dxUUE2SFEyTE1uc05OTDl3RVZ5Qk1tY29NZ1RNU1NSTS9q?=
 =?utf-8?B?VXAycGJCUW5ZeXdxZnRQU2I0SmhLZHlFNE80dkIxcW1wZWQzVWNNdDUvSU5i?=
 =?utf-8?B?RmRFanA3Y1VTdWg1OE1zUTNnQiszTDlETkF4ME5GMnhxNElVYlZldVpuc2Qr?=
 =?utf-8?B?bzQwRis5cEduNlJJdGpGK3QwVEZTc29ZQ3JIcExsb0RUbkRhMTZqUG9QamxN?=
 =?utf-8?B?QjlZbGNmMGxDYm5Hd3pUM1RBUHVJcXdDeEhzVktlNWVXZzBrZnZCMlRqWWdC?=
 =?utf-8?B?bzBSb29nYzdGZng2cVF3M0NnZ3Z5UFZ3MEZEbmdYK3g3SUJnNk94ZGpaUC91?=
 =?utf-8?B?NWJhM1lzbXpIYjE5dWdTYS9NblRyRWUvT0tPczFMeGFzbEp2UVJkZGNCNE5i?=
 =?utf-8?B?aDNDcHpEc2haaWN2Q1NBRXlnKzVZc1haZTdwR1UyQUEwRUtmTkRMRjY4QTNW?=
 =?utf-8?Q?FjAnNDY5VYhKvmII76vUx/3TB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7C1151D7898824291DC610A6EA46529@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NLXFufReoOryHZAHGe6QZl/fBni2za2PcpP7MR+7CmkFcreu9iky6I5Bgk5+m1zfYJwYYtX1lWigcM3Kai13rUd5vW0ShNt4nJWzVRuD6E67opOIJbZQU9GYoz3bc49dpPQqsL0o1B8RhjomSodYQteGlhixEzi6isG7oV9ph1x9rt+V0LpnrSRPyAagwWm2rAaezxDFhwxNm287ez72AGRyX1I/2oD1//Ccbkr8zHNwWiHgVQ6VpSaJMqjDnQ/2993/Eq8x1csqgLpQHVK/QjbISoUdyS5q4c+qGZm1pDm9yJdNgbtpb7t8i83ILHWyATkHiRZFkpS6PNiME/8g/n77h5hXZCTM7lV1ixAYUYPYaV6nf+lAwO1H1DOR5zlUUcLtHPVPsSJAFuE6R+Aefy/3wLSchm1pkd+BPPiPSR6xoZtYrBPg8aQbPWtNviiyT8JTCEFNbETX1w7gCAhT4VKmc7Zg1jRN+KpGpO41dwr5/tCde4WJJ5s41rM8rUkD1Wehwa6cTNDfkyo80SRKGnd2YCan7xaQSGaXYtW/a9y0BM+TeginYuIdI5qICO4JMdMzCz3DNLJognsQ+nIXMUg0YR/LHY2OpI60tDaXo5pWtcqanoo0l5oo2oih1uaiVopKVFtr/QQ4KdAW2ihAHA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a5a82d-a40b-4028-fbf0-08dde68775fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 23:06:03.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WW5SkrE/JiL3l1xB8Gcq65Trsf4iegQJHOJtX0Zn5xNmvDH3s0FhX7ggk6cuMx5HO0EwCh1Z1+daxGsh3Ir9nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
X-Proofpoint-GUID: IP2db65sc0coPjfiH9PgqQWXlbe5tVsY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDEwMiBTYWx0ZWRfX/3YRYIVY9hQ+
 oiu764QAdsVJGya6YdzrcgRg4tl0DWCCS76zZK1kUXC7z5jA7H8osf4AOTn38KoWVxmglWyKfK6
 p9Q3TjwD0UHQQ7+kpLUL0iUjKtKxfC6UbaeaPgtnF2AOpM9uQnfSs28jUUoHAdixGJ4GSw4Me4U
 d31MzW09LzQW+PFogqRon9KAqf1x5dr/V4Glho4Lo9wZjRUKE/uqzOrrNrh5x8PIeHUCY/a0JxC
 9fvCcEl/uZSf4d57cmN2A4O7SE8LHxpsFqNgoZwMEUZg1RjLG+4zPW4O6fz+CvLwPzV++pTrp1s
 9zH+nRME2xDdlPAoGcuO65mpsKwXGj3/SsktRnNhcZ1D/h4TU26CTlDsGOoR/L6vDOzjesFfYey
 /LrK+ySY
X-Authority-Analysis: v=2.4 cv=aLTwqa9m c=1 sm=1 tr=0 ts=68b0e0ed cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=dOLNmq4gAAAA:8 a=8dWM4PO68dpLbA8M5icA:9 a=QEXdDO2ut3YA:10
 a=_m6CO-mWuQdSFutSHjXj:22
X-Proofpoint-ORIG-GUID: IP2db65sc0coPjfiH9PgqQWXlbe5tVsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250102

T24gU2F0LCBBdWcgMjMsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IE9uIDIyLjA4LjI1IDAw
OjI4LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gVGh1LCBBdWcgMjEsIDIwMjUsIFN2ZW4g
UGV0ZXIgd3JvdGU6DQo+ID4gPiBGcm9tOiBKYW5uZSBHcnVuYXUgPGpAamFubmF1Lm5ldD4NCj4g
DQo+IFsuLi5dDQo+IA0KPiA+ID4gICAJLyoNCj4gPiA+ICAgCSAqIFNvbWUgcGxhdGZvcm1zIG5l
ZWQgdG8gcG93ZXIgb2ZmIGFsbCBSb290IGh1YiBwb3J0cyBpbW1lZGlhdGVseSBhZnRlciBEV0Mz
IHNldCB0byBob3N0DQo+ID4gPiAgIAkgKiBtb2RlIHRvIGF2b2lkIFZCVVMgZ2xpdGNoIGhhcHBl
biB3aGVuIHhoY2kgZ2V0IHJlc2V0IGxhdGVyLg0KPiA+ID4gKwkgKiBPbiBBcHBsZSBwbGF0Zm9y
bXMgd2UgbXVzdCBub3QgdG91Y2ggYW55IE1NSU8geWV0IGJlY2F1c2UgZHdjMw0KPiA+ID4gKwkg
KiB3aWxsIG5vdCB3b3JrIGNvcnJlY3RseSBiZWZvcmUgaXRzIFBIWSBoYXMgYmVlbiBpbml0aWFs
aXplZC4NCj4gPiANCj4gPiBUaGlzIGRvZXNuJ3QgbWFrZSBzZW5zZSwgdGhlIHBoeSBzaG91bGQn
dmUgYmVlbiBpbml0aWFsaXplZCBieSB0aGlzDQo+ID4gcG9pbnQuIFdlIGFscmVhZHkgYWNjZXNz
IE1NSU8gYmVmb3JlIHRoaXMuIEV2ZW4geW91ciBbUEFUQ0ggUkZDIDcvMjJdDQo+ID4gYXR0ZW1w
dHMgdG8gYWNjZXNzIE1NSU8gYmVmb3JlIHRoaXMsIHlldCBhY2Nlc3NpbmcgaGVyZSBjYXVzZXMg
cHJvYmxlbS4NCj4gPiBEbyB3ZSBrbm93IHdoZW4gdGhlIHBoeSBnZXQgaW5pdGlhbGl6ZWQgdGhl
bj8NCj4gDQo+IFlvdSdyZSBhYnNvbHV0ZWx5IHJpZ2h0LCB0aGlzIGRvZXNuJ3QgbWFrZSBhbnkg
c2Vuc2UhDQo+IA0KPiBkd2MzX3Bvd2VyX29mZl9hbGxfcm9vdGh1Yl9wb3J0cyB1c2VzIGlvcmVt
YXAgd2hpY2ggd2lsbCBtYXAgdGhlIFhIQ0kgcmVnaW9uDQo+IGFzIERldmljZS1uR25SRS4gVGhh
dCBqdXN0IGRvZXNuJ3Qgd29yayBvbiB0aGVzZSBtYWNoaW5lcyBhbmQgYWN0dWFsbHkNCj4gZXhw
bGFpbnMgdGhlIFNFcnJvcnMuDQo+IFJlc291cmNlcyBvbiB0aGVzZSBtYWNoaW5lcyBnZW5lcmFs
bHkgaGF2ZSB0aGUgSU9SRVNPVVJDRV9NRU1fTk9OUE9TVEVEIGZsYWcNCj4gc2V0ICh2aWEgdGhl
IG5vbnBvc3RlZC1tbWlvIGR0IHByb3BlcnR5KSBhbmQgdGhlbiB1c2UgaW9yZW1hcF9ucCB0byBt
YXAgdGhlbQ0KPiB1c2luZyBEZXZpY2UtbkduUm5FLg0KPiANCg0KT2suIFNvIHRoZSBmYWlsdXJl
IGRvZXMgbm90IHNlZW0gdG8gYmUgYmVjYXVzZSB0aGUgcGh5IGhhc24ndCBiZWVuDQppbml0aWFs
aXplZCB5ZXQsIGJ1dCBpdCdzIGJlY2F1c2Ugb2YgaW8gbWFwcGluZy4NCg0KRGlkIHlvdSB0cnkg
dG8gY2hlY2sgYWdhaW5zdCBJT1JFU09VUkNFX01FTV9OT05QT1NURUQgdG8gdXNlIGlvcmVtYXBf
bnANCmluc3RlYWQ/IFRoYXQga2VlcHMgdGhlIGxvZ2ljIGNvbnNpc3RlbnQgYmV0d2VlbiBkaWZm
ZXJlbnQgcGxhdGZvcm1zLg0KDQpCUiwNClRoaW5o

