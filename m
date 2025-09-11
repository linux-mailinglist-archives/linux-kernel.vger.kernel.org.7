Return-Path: <linux-kernel+bounces-811206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F2B525DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D38686FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3631990D9;
	Thu, 11 Sep 2025 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DsQ/LOaL";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EMPjejJB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KWq0yvJ2"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D81F237A;
	Thu, 11 Sep 2025 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554752; cv=fail; b=AcQ6YZcdXNsHKQ7elcI21+vT2pvKScku3oGkx+6w03zVcPmZ8xo9+Zg0ErFQwDCTXQ5MvsSTMKDV+ayVFDqrLg7sBAOfydEY4LXqy3j9BM0HDnU7zv4QFS+OkkUjSFtbatQE9fKnvDrSE/rMTNIH3nNer652cJ4QP9mIkT5DzWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554752; c=relaxed/simple;
	bh=h9aIoO+RtaPzBp4LW57p+Vz0GloNtUpdjAPyw22Yp58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iMXPN7xNBLVC1XMap7zpxwByFt5wRGjCHxqdAFvuMvNkCBzx0gCHhKW1iSDTGhlQrgyOIIBTfFeloIyRjyPpjBsF1MdPudzWBqMibiRcxHUWpg5boEqGM8JJemWvaS1Va45D3GLD2bhJc+NgDed06bU8f0ksnChhHMkU7kaoXho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DsQ/LOaL; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EMPjejJB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KWq0yvJ2 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALSelw013476;
	Wed, 10 Sep 2025 18:37:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=h9aIoO+RtaPzBp4LW57p+Vz0GloNtUpdjAPyw22Yp58=; b=
	DsQ/LOaLCc+8fvJ/fGx2WA7hcqCyads9eJgsLLM0nIqDi16Ykblot8dGf9+EJyTS
	BOdTmDDNvfurMN1dBT9tzZi7zgLi/TLhMbG+Bals5hVJe5LFeyPgacVlPeUfIQt4
	QKhFsGHIPXcoEU3V5na7j0IfVwga0q1sbtIv9/Ur9/oRyYprDnIawHxes+IXDr6I
	KoInrrsfJHfXwTGKdq9aCHH7V8cnqB3czqWSbnKm5ZZC/kG6XOkVQW9g3xzMPdYj
	NVmFnPlfjQkTqMU7796A4LAX87tcLhtHLNyx6Fzf9E8CBH0bJ4Rt+7Oj4/WbQ60U
	K7R+AllER7qZab3FeoOQUg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4932kaxdkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1757554673; bh=h9aIoO+RtaPzBp4LW57p+Vz0GloNtUpdjAPyw22Yp58=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=EMPjejJBmfMdNe0dBlqG/v8aOdNQpveCV0PV1MMyAHu8H5s5xoS/BNFvlx3hFgVSe
	 KcwaqHOEzW0EfHCZFaYwciVvLB5IuMbt6dRR+1nFpLXcMaFgvNWKXmpbDFDisyCJhT
	 X8Hb0GGRV2yE+nqjOuwGaCJPp7eXYh4TVL27cyz+/Vl/ewcoX25uReYyt/RMy0Y/SA
	 0ZhSDSHjK7TADJM/UHwtj+hwtRt2lg0YbzaVKShQwuM54UK+D12rTQPGzTGFstp1MO
	 9o4aM6rbLT8MWMRlWK53Ng+KnjL9xULknD/AL/9JJYy7yZSn6YG9OHAf6rdTY0z8LZ
	 2N2dsSoYWFCRg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3B000405C6;
	Thu, 11 Sep 2025 01:37:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1D916A00E3;
	Thu, 11 Sep 2025 01:37:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KWq0yvJ2;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1AE2740358;
	Thu, 11 Sep 2025 01:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQDxJlYR1D3LHW2Y3eYu4yFpky2jfubaurrKEZNo4RVAPY/FpJtg2x/vQnfu2g6/BEgEVLaSpskWAC/ZI0GIvcsjZYpaxOKL8Y2AGIz6GWDmbs1pZ5exmmJjxBSLN6XdFnM/kGkh5K37/E8dNemQMqvzZp+azDxSZ+JjrGXR0StAvO12Q4UlW9p4d9xK+pE+QRsVXTLFl6Er3UERsvgxpgd66pgD1rcp/VHSL5N96jF6CZ3wYhTJ2mhuB2P4B6CagjUwfuEJof70x0Vgh4N3pSZgl6+2nBvTodOCYx9g7GBgW11KSKmUZKSq6C57NpuN3ZYJwBltfUUc9eM9RkwMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9aIoO+RtaPzBp4LW57p+Vz0GloNtUpdjAPyw22Yp58=;
 b=FD7YgWMivaTXIeqF8CMUv/FwFRI6DKXcl6qzSAb20lVMSeteIB0cEcbLI4wf1+WAaM5fdObNccnbvDt988T5zSKeNnvO/B9ANJat2BA42d8ZZHtqife2gShmBVMiDdO49p8Vw/NqyT7HBky5g40jQkmwnTtlVhhFqK9XHJ0J9GkCM0tPF0uCNmyPEiFKuJt3Xx8WQeIlVrAFK6Uc2m7IxVpAQNDaniyy5isPagYX8TDvS1534/14cBHDaNjo9iY24Djhv45JA8XxCN+jWyaA7KnVOE861vdZjEhergxIWNQowL5bOAzhE63vD1Gz5Zmav2va9wu7PhOhburHrBuH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9aIoO+RtaPzBp4LW57p+Vz0GloNtUpdjAPyw22Yp58=;
 b=KWq0yvJ2iTwbqU7q0RBemFQUpwKIkfP9AybzPtbTuSGSJ30S6PuCnZitK8KC33huvnVczBbiCQ1BCJNl7Szpf4hkdaXDaZm9hwxfGncKWrFUZ8JYclmjV6oJomhckjYXqpBydFmGP4IOQRy4HfSmQhQGbLXd94BzblgZTp2LI6E=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 01:37:43 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 01:37:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Sven Peter <sven@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH v2 02/22] usb: dwc3: dwc3_power_off_all_roothub_ports: Use
 ioremap_np when required
Thread-Topic: [PATCH v2 02/22] usb: dwc3: dwc3_power_off_all_roothub_ports:
 Use ioremap_np when required
Thread-Index: AQHcH0UH+sWw2onBu0G14qfW/cCqz7SNOsuA
Date: Thu, 11 Sep 2025 01:37:43 +0000
Message-ID: <20250911013743.gs4omfdlg2adzdhs@synopsys.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-2-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-2-52c348623ef6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB9543:EE_
x-ms-office365-filtering-correlation-id: 53725251-f6ae-4481-8db9-08ddf0d3cddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmtxTHZKNXp0NmVSMG1FNTJ1SWsxUzI4Sldoa1lmRmd3WTkxQUx6ZWw1Ymtw?=
 =?utf-8?B?Q0hoSm5PMWNybzhNc0R0c3FtUzhhUEhRUURnK3hJWHZEVldidjhsenhVZERn?=
 =?utf-8?B?S2pLQWhQZS9SU0JyRHdEbnc3ZXRQRzIvK0FJalZVWkNRbU9RUTJVTW4xYUsr?=
 =?utf-8?B?TVFQTUMyNldHZkl6Y1ZscUtWQStta21xL2wza2pySHNCYzRJczZtU1YxRXNV?=
 =?utf-8?B?NWhLb1pDZittNzk4UnpiQzhCejZ0RUVTTUJySHdtdzdhTXJUWmc2RlYvbmJJ?=
 =?utf-8?B?NjJ5QU9DYW5WRWI1ZngzUnNsdU5nN3Bzc2t5THNzUGVPMnBhelRIc2dkTUcz?=
 =?utf-8?B?aVNYNkIyenF6MThwOHAxNk51NU8xWUpEVGxVMU8yQ01GbFVNMWl3dTFIbjRG?=
 =?utf-8?B?MnBDUGpyYzFzcDlkSXJKNzN5dTBGbjFvV3R6eEZPYTNpNlV3NGVGSkQrRzhm?=
 =?utf-8?B?TzZTc1RzbFF4VHAxZGhGQnJ1cUVWZDVlbmlDdXdUQTdiS2wwL0I3WkNHWmxL?=
 =?utf-8?B?WkRZUVVnZHBjVDh1dFdJL3JCZll3ZkttRVdFdkUwcW5TVGNraEY5ckovR01F?=
 =?utf-8?B?OU1ZQTZORUh5eDRRNjdhVnd6bnk3ODV3cytNS1ZFczVrL0w5eDZMV3pEaC9l?=
 =?utf-8?B?K0hwejdFTGhQaDJWRzRpbkQ1dmFWcnRoMGRtdVhsSy8vTFVreFIwaTlQT1hk?=
 =?utf-8?B?Q0dNRXdVZGRLdFJkRmVSNzM3b0ZrVjdZQVZwVEFjUTFRYzNqSVBYaGU1aXhQ?=
 =?utf-8?B?OWlsMUpGU1gwOHF5Q3VKUlA2VUcwb3luTGpkZTJNYkp5eVpFRmp0RWRQekR6?=
 =?utf-8?B?dVdudHV4WXp3NG9kdWdvQkZaRHNvNVlrSnU5SVYrRkI4dXJyUkFVVmdhZXdk?=
 =?utf-8?B?SW5WOG1zSVE3ODlyYkhjZzlITVdrQ2dXRWF1QW83dWhsYW1oMlM3ZzRNczY1?=
 =?utf-8?B?U1RpSThaeWRkQS94QTQ0blQ5Tk0veldTWTQ4a2FJZlA2NzI0ejYzZ2xES2FK?=
 =?utf-8?B?blhKNXBkVWplQ0VEUEFWUGNmOGJZVTVwT2d6YUZFb2dNeDlsWWYzOVVnc1Rj?=
 =?utf-8?B?T24vWVRqK3FwR2tHcTJUSE1ZcjZrdnI4VTlPQkZXUlVNMjM1MGVYdGwrQ1Fo?=
 =?utf-8?B?SWlBaTh4ZUlxRUVwaU81UnZEbkdhRUxGb2NFc0FyNU5nTnpLWE9qN0duUEF3?=
 =?utf-8?B?aXNpeldKdVF6MUpSMVBPZXMyekRGcHZEdWlib0N5UDVaMEszclF1eFAzanlz?=
 =?utf-8?B?VmpqTG5pWCtzVlZtVnJjaWhXQTlJRjJSclZLUmlNTXE5K01aWHNYdTMyMVRm?=
 =?utf-8?B?YkxuQ0FJc1krd2ZzOVdta2hnWkFDbjZqaGEzNUI5NUdic29iMm5Ta1pVWE9X?=
 =?utf-8?B?TyttTStnWkZZY1ZxUEhyVWZ1amJXMEV2N2NpTDhqRkdLc011UTJ2Y1NLMGQ4?=
 =?utf-8?B?QTBNczFldnpBaW5RVzZMQ2NpdDk2OFFqd3hDdnJJdGp6RU5NWmJ0d24xZVFW?=
 =?utf-8?B?WC9USXFCdFl0WXZvcDdkUmsweEpOczNYcytmNVVwV0dhUGVXVDVJZlF4a1pL?=
 =?utf-8?B?UHVOOGFNZzc0WmRJNy9yQVhwcnloTlRTSXVVbTR3Z1VER05HY0tRcU82UWp2?=
 =?utf-8?B?RXZlWGpxaTRTUktxYU1pSXB2aG1hWnBsTDJpN0ZDYi9oQXVKRjhjMnhMcmNw?=
 =?utf-8?B?UW0ySm8vY21CR2JIZEo1MnkrMmVLNUdLZDlBTkRBZVJIbSsvWlA0SU9uVG4v?=
 =?utf-8?B?K2haci8xakNMU0svOFlPZXhIdnd3ekFwU0R3ZVZuU0xtNGhVYTdqMXByMzVI?=
 =?utf-8?B?aU1hSk9VcVFPdUtYS3NUVEdzS2plSW80SGJ6MXliQ0hneVFScXVJMkszTDNK?=
 =?utf-8?B?RnRTR043eGlwYVFzRmJValdYM3g5QkFscjJ3UkV1SkpybUU5eEtRRVNuMHU5?=
 =?utf-8?B?MnN0VEFPd0htczh1TkFWdUhDQUhQY00zYnUyL2o2c2c0WnBzWEVoaVZmam9V?=
 =?utf-8?Q?uKqs6PJkUASYbv2r0scfwOe1Asm6xo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHpITWdZOXdCU1JWY0piVkJoQWZEeUluM0NSWnN6bUhHWVUvL0RiYUNXVWJ2?=
 =?utf-8?B?VjhJQXdsaHR6WUJ3dFRhd1dEbzFQU3FtME1Gd1A4UDZaUGxCcjBnVWlJdjRR?=
 =?utf-8?B?K3NuN3NFY1YwaUExN2c2M3ZZKy9NUnJNbDh0eVdJcnBKNCtxdGZvVXoycnRM?=
 =?utf-8?B?bVBBbktxdUFDTE5HQ3YwZncxbzJZNnFZem9vVUZoS0FmaXVJd25ZQ3FxLzNR?=
 =?utf-8?B?UTIzUXAxRzd2VkdwL3loVlYzRHdHRTRUazYvSWRscVk5WVA5c2tMRy9BSkdU?=
 =?utf-8?B?Z0VPZmhVeTNFY1ZxTXp3WUtDaWh4TS9neU84OXVnTkNaVzkweHI2cFRMajhq?=
 =?utf-8?B?dDRMVE9TVjJQRDhjL1ZiQTlZcnR6bFY2OHJVZHR5a3FvbU16NUVPTnRYWEVK?=
 =?utf-8?B?elZQUmRxZ1NxTG83ZWhURVFPeW45SEorWWw0a0NFaUgwWSs5VlZjWGd3ejNq?=
 =?utf-8?B?eERnbzRUa2taUkpjTmhPQVg5Z1R6aGwrb3FCbndqV0ZSOGZyaDR3ZFNnNHpm?=
 =?utf-8?B?VG5tdkRodERIQTVjblFWbXRHdDBubmNlK2tUTlIyaVBLZkdzSTFNSHV1SVVn?=
 =?utf-8?B?YTlhUmhMbmNrZGlQd2YwZTNIdmEzT3N3aHozZXI2b0RZbkc5MlRFdkx1dE53?=
 =?utf-8?B?NEVzRjI1TmY4eTFnQ01qcFpYZit6dmVrK3FxUWNaRUszeVpkRGtDM3pjdTNt?=
 =?utf-8?B?cHZYcE03SGdMQXJmOHZBTVhtRmt5TStZcHhKYVVzRFBNUlk4NzBEcEc4ZHVN?=
 =?utf-8?B?OEZSOU5yK3NYTEhmZjNzWmk0RndTWnUySnEzbXo4Y0RzM1RMMHUxTGgyQVJs?=
 =?utf-8?B?VCtCbFBIZE44cHdSUHdBRkxqaWFLRmpnY2REUnU5RXE0Y1ZBdG5BbzBIMVNM?=
 =?utf-8?B?MUE2d3hPZGo3b1lNRVdxZGdqNnRLRWpaZzJxZlgwSFNPUWdxdkQ5MVNES3F1?=
 =?utf-8?B?QTlZRTJjNW1sa2t3WTZSTjNMWEVhRklWWlZwakUwSHZpZjFvVVVxWEdJRXNx?=
 =?utf-8?B?cUU3ZHFtSUtReVpqa0FiREtmZVREN0ZCbkc5ZjNSRVFzUzJ4cjIwY0hMQlA4?=
 =?utf-8?B?RTM1SUxQYWlSb29zWTVsUGhtL1oyYmw5MTJXV1pwalhrc3ZnT3RmRTZpQUNG?=
 =?utf-8?B?VHNyTmpmNHJ3UlRURCsvVVJRWU9EY1FqSWJIdW5QZm95WktyV0RGMlp3dnZU?=
 =?utf-8?B?SFVONS9mZFlqS2NCdzNMYTZhaFRJR3RCdW5ac2ZqRllOTFo2dzlMbmtvZjFT?=
 =?utf-8?B?NFVMYlNaUDQ1N0s0ejJCdE5uK1JpelRrbEdTUmFlbzFPYTZPUjJMZ3V2MVpj?=
 =?utf-8?B?anpJSzNsb1ZBV1d1dC9la2gvN1ZaNXNPZjhBeTEyQmdYT2lVVXMvRUEzeEt1?=
 =?utf-8?B?bHBqMTFTRDRzRjA1TWxlUlZWOFhXc1pILzJZZlhLMlhWTnpSMm4rYzFvcEw5?=
 =?utf-8?B?aVh5TXE0cGdETG9iMzJ2V1RRaGRJNUtRWWhBcjVKNzY2Q0pMdHRqakViN1pM?=
 =?utf-8?B?eXAzbDF5ZjY0OVRPNXpPWHpCQU5GYW9jMm1LU2xTb2h3WU1YK081a3BRVmt1?=
 =?utf-8?B?RExEWC8wTEU1NmVvcHBYQndvRk1FT20vWjZmb1hvcDgzM0RBZVJtMW9rZXE0?=
 =?utf-8?B?RHNIOGZhaWJmNVNlNm50aDVDblJBaGYvNnR2YmRPV2ozemdVVXVuSXE1RHlE?=
 =?utf-8?B?aTRqaEVacldpcGRieW5MbkxUd2puSVYvRytVd0VKVDZySWI1N1hRdlk0OVdO?=
 =?utf-8?B?eGVORDFtKzFIYlNBMWtCcm9PUXhNRnNZTmQvWUVJU3RSellHaUVLb2t0cWNG?=
 =?utf-8?B?cU44L2FmU3dNR2QzYm1yWmJ5U2tsa2NLVGF0ak43SmVxL25jckJTbTdzQVho?=
 =?utf-8?B?a252aGRCajdHenNIUWxDbWVabHVTcHQzdmQrUmVFOUxGaHU0TVFRTTMvdHNQ?=
 =?utf-8?B?elQ2eWZDNDNRbWxjOUhYbkFrQWVpNDAvK0pBYVQxWk9Pbytna3RmK2JEWjY0?=
 =?utf-8?B?TlcxalBFOW43bEl0aVJ2SkNvcTFPdWFmMi81OHd3YmZjMlBlVVRjT1VPaFJG?=
 =?utf-8?B?Tm5LdzRkSW1YWmhjK0tYczVsL2R1VWdMMXF2eUZRT09ROVJ2dTNxRU1PUGVn?=
 =?utf-8?Q?N++rtdLK8lP9K/DVCazXYK/6e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2DE330A1DC9414BA327DE04A9106D14@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j2+584GozGZ3QgtQF3acI4/zgdsMPb0UwvI7z35oGj4kbLNjitYxwB6MC3oEPPP0bWi8TlHPOPs5cn0R2tuBdgN/WTd5C3Hr1dc4cXHgpk+VEOqivAjxI0RyT/jkVhc+QZ5bC7mhUi0Hf4E+oZOiMzIqDF06H0lB18EWClHYWWID+t5J80BylwOlYUkZm2oz29BtmVGTLfg35EGXmYrf6FgmeK31LeWQUq8nquWP9gRqID428BaOXvBdv0rjDBW2Qiqu7TdZ2LuZnRqPWeDQ2zYYC80aQWEFA4OoGeOOt9KgruIGC0cSpanWooBchhJs8Q+KXcNwpx8jvWDQGGWD6en8ehjfrIOp07IZ+/pBG3t8r3z7LbQYYawx9TjbL7I3Gg9vu0yZbcCpts+PfGmYM/dozij34PDdzC26tp4i2gAiJ3MHJHs3GMKfPfDvhirbBxdg7BXn+SiwPUkElYiZEnpRkWF28itHioYz5ljOQ550fdZPJ3qSt7wdYnM7ZfhVwbykyZUHVLTu4XlHId9BkYllFgveJya3PjTa2ZCPGUZSiEZgJY8Mds0YgNSoTzZfvr5bG7J5ON+BDQ2KtUc86NV8Z2RBjJuvLbpmzAQFDpORqekK+G6r2p9al5YHzvOuskrKD4Dy+kUBP9ShAcn0sw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53725251-f6ae-4481-8db9-08ddf0d3cddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 01:37:43.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMvePIdYBN1SvqQTKQGDxZ0WqY9wyCSC75joUCybogIuRTlxK2b4DS6BncGOxVu4SYx01sm7a5zWGAuTzqI/gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
X-Proofpoint-GUID: Ug2XKxHsnMSKoz48X1kre9ReqE6h_pZw
X-Authority-Analysis: v=2.4 cv=Tc+WtQQh c=1 sm=1 tr=0 ts=68c227f1 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=tCHIWAufYMr41Y9WVmAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ug2XKxHsnMSKoz48X1kre9ReqE6h_pZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDAzOSBTYWx0ZWRfX1vVxfuyYh4PM
 zNUJgtTqg2LjKwgO25z0t6q1MClAPlyHluUXOj4SN2s5cuBxn0FO3TZLrcDHhLEvt/Hu5h9v9TE
 jTWFeF2fxQS7SaonF4vMTu+LHwrzNMb8kP0ouzbHr0sUgpY1DwKKCpYw0mhqI+HjuEVt02QPgQG
 mpwPxlMWhCuVjU6Ke1NlcngRDQhE5L75EZof2v7h/nm4maTaVkXVytbSZFKLETtaN4w3UPH3Xof
 fDMoDKOvbxT4nAC5aZ5HM0TUj5RyKeDAQsBWH6BHwrLqAGe4ouPAuyXqgy54vDr4isT3HhGdwaV
 jp9TRUQI2lFYG3Ts3tRkgS776vIB53jSzjxdKcZ1i3ZnnpHxcxrKjZoMsmFPSXJ4BCe3qoIyEMK
 e3o7F0Y/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509100039

T24gU2F0LCBTZXAgMDYsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IE9uIEFwcGxlIFNpbGlj
b24gbWFjaGluZXMgd2UgY2FuJ3QgdXNlIGlvcmVtYXAoKSAvIERldmljZS1uR25SRSB0byBtYXAg
bW9zdA0KPiByZWdpb25zIGJ1dCBtdXN0IHVzZSBpb3JlbWFwX25wKCkgLyBEZXZpY2UtbkduUm5F
IHdoZW5ldmVyDQo+IElPUkVTT1VSQ0VfTUVNX05PTlBPU1RFRCBpcyBzZXQuIE1ha2Ugc3VyZSB0
aGlzIGlzIGFsc28gZG9uZSBpbnNpZGUNCj4gZHdjM19wb3dlcl9vZmZfYWxsX3Jvb3RodWJfcG9y
dHMgdG8gcHJldmVudCBTRXJyb3JzLg0KPiANCj4gRml4ZXM6IDJkMmEzMzQ5NTIxZCAoInVzYjog
ZHdjMzogQWRkIHdvcmthcm91bmQgZm9yIGhvc3QgbW9kZSBWQlVTIGdsaXRjaCB3aGVuIGJvb3Qi
KQ0KPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogU3ZlbiBQZXRlciA8
c3ZlbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIHwgNSAr
KysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9ob3N0LmMNCj4gaW5kZXggMWM1MTNiZjgwMDJlYzllYzkxYjQxYmZkMDk2Y2JkMGRhMWRk
MmQyZS4uZTc3ZmQ4NmQwOWNmMGEzNjE2MWMyMGFkM2M4M2YxMGU2NzA5OTc3NSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9o
b3N0LmMNCj4gQEAgLTM3LDcgKzM3LDEwIEBAIHN0YXRpYyB2b2lkIGR3YzNfcG93ZXJfb2ZmX2Fs
bF9yb290aHViX3BvcnRzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIAkvKiB4aGNpIHJlZ3Mg
YXJlIG5vdCBtYXBwZWQgeWV0LCBkbyBpdCB0ZW1wb3JhcmlseSBoZXJlICovDQo+ICAJaWYgKGR3
Yy0+eGhjaV9yZXNvdXJjZXNbMF0uc3RhcnQpIHsNCj4gLQkJeGhjaV9yZWdzID0gaW9yZW1hcChk
d2MtPnhoY2lfcmVzb3VyY2VzWzBdLnN0YXJ0LCBEV0MzX1hIQ0lfUkVHU19FTkQpOw0KPiArCQlp
ZiAoZHdjLT54aGNpX3Jlc291cmNlc1swXS5mbGFncyAmIElPUkVTT1VSQ0VfTUVNX05PTlBPU1RF
RCkNCj4gKwkJCXhoY2lfcmVncyA9IGlvcmVtYXBfbnAoZHdjLT54aGNpX3Jlc291cmNlc1swXS5z
dGFydCwgRFdDM19YSENJX1JFR1NfRU5EKTsNCj4gKwkJZWxzZQ0KPiArCQkJeGhjaV9yZWdzID0g
aW9yZW1hcChkd2MtPnhoY2lfcmVzb3VyY2VzWzBdLnN0YXJ0LCBEV0MzX1hIQ0lfUkVHU19FTkQp
Ow0KPiAgCQlpZiAoIXhoY2lfcmVncykgew0KPiAgCQkJZGV2X2Vycihkd2MtPmRldiwgIkZhaWxl
ZCB0byBpb3JlbWFwIHhoY2lfcmVnc1xuIik7DQo+ICAJCQlyZXR1cm47DQo+IA0KPiAtLSANCj4g
Mi4zNC4xDQo+IA0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

