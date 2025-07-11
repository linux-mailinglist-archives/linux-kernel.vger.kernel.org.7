Return-Path: <linux-kernel+bounces-728383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E196B027B8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D009A40BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2DD2253A9;
	Fri, 11 Jul 2025 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PmlU6HQD";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gBVJcZNq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b9xqmuT8"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB22628D;
	Fri, 11 Jul 2025 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277107; cv=fail; b=EXs1fQLSnAj29ReFQ2C/bpYnPpHDANdsi6k0DZvWocIO/+RutAfCDxyDpoEjXpTC1AQyrCwNpafD3gDOqjMfUbenqlOP35xgFQNCbxYGjmSdPBYkN7ELTGUCQScpEvXz0ooHOgYo+CbiWUssHlrrLHawXEQFePbB8mAuExH0Reg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277107; c=relaxed/simple;
	bh=JLEcNTh5fW1RysQXudWzNyLj1piNxVwys/EQOXaDKHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4Zexlz/qLga+JMvuor+Tu5PNB5G7kFY47tb47u+/FAP9T8F/7Hj4gna+w/ySbcRkllM2bTnVeDSTKNVonqjYon3HRYcOMJvnGN/JWr++wCJ4T6T25DQ4vLtDy/RH2exqFtFI2AtYAGZIzjqZkdjzHpCzUaPob8A55xFvJoRDZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PmlU6HQD; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gBVJcZNq; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=b9xqmuT8 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BKj1Q7014839;
	Fri, 11 Jul 2025 16:37:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=JLEcNTh5fW1RysQXudWzNyLj1piNxVwys/EQOXaDKHc=; b=
	PmlU6HQDgh5KNXNZVJEI91DCCZHeucCZL4xKtUFkfyQsJmIXtSvwD3ReBEsepjj/
	x36Ptt8Md0iHulrRnfYQwrjYQOqoSk5ZRBYeuP3T2XmLXQvOr/Svz2dbv1InUkH5
	GsC9rYS9FnNMYHqUwTIOKgvpOWt2UqyWcN0qXAxsxxjCRi/vu9v83mVAK8eLXEEg
	laoqantf4ukmdrGhXy0btRCPSXtodTukLtnEhJhJvQvHat2cJBJk6HkjkX8o+5q6
	1ywQakZt0DhVaAARIdu6a9sxao4or00bmkGMGEeT/fO/68f2agjNvnGgHMv8ZPc9
	LiOpgfvOK/W66SlQg4u7aQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 47rbqua53h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1752277064; bh=JLEcNTh5fW1RysQXudWzNyLj1piNxVwys/EQOXaDKHc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gBVJcZNqyV7FpzA+SeENfp/aVvCvrO2vEIL8wqqYn8Cis4ekkXFps0o7dMBhY2Xz5
	 Ewe8FuC/nfNczwx9X5FjHEfd/9OSJHlobHmdWS1t2TjyiaLhs/PYeMdDePMYjx+WRw
	 0+R8HoyV9VI4ErQxdvAY+cdp3/TDayfvS0cHklzd3pNsL93OcBmOOM1MdJy9tLSkfx
	 H9e8WNHFQ7AHDo2b5dubOfO462+UAWJ1K0HD64N8neBEeKmTDyPMi7g/KHN7d6WBT5
	 fTJ9KfymQXleHWQz4Ova9Ffym6dEZLZTIj9uqnp+iD1lYtFotRTF69m38f+Vw/nY3S
	 zvcz04SNhgNtA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 201F44035B;
	Fri, 11 Jul 2025 23:37:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 88059A0070;
	Fri, 11 Jul 2025 23:37:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=b9xqmuT8;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7481F404D4;
	Fri, 11 Jul 2025 23:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRU5Wua6z2N3gSeHHQwIyKP23turHNHxZfzWJQ3ikUeNg7b+xf5i794BUZiqlfRPBJE37X0r3nYEARgRyReFEcT+ZWbHmUx5mY/eiDefrCyGvy5Gng32soqVobpYiGzi5g9UCB56j1PVIeWnH5l+FB8s/W+TRMVcdlDbLDkcNRpOIL+CM3C5pKZl5sLBAuSWlKluwjRC76qGEw5scJfyqZqaE67Ra0hLvDwM2wI2Xv6WYfkQH/GLj3ak1KYlo6F2sztG4h+7uk9WCIwGUpUnIdAY3C+3Pt8msUBaIyNMZKqtfX75T1c9WGC6xkaV9LVfhb7eiO/jPryIR2vV4F5TDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLEcNTh5fW1RysQXudWzNyLj1piNxVwys/EQOXaDKHc=;
 b=AFR5ApqeStiIbMwYgOnbmvrqNtxTKgsXwcgY5rOuBnByG1GKvahxA91ACbiubcKg/LJlOkhojEfxIThy085mgUPD8xnDxqDejn6V7hT6rzxsi4VsrLL/D3j+vucZDeGimEB8T8qzWZtnxM6Sfi4Y4UHrSS8KbRWx6lB6ag1DN3g24vmltu/sKOvhm7+DRZHtcHF6X3Za0CPvAO5i0WvzDYygQn0duiFuDOXQkkyl3lEyzfU7oOZ/79tFxJZP+HWA8kHeyRuC3+UrsZJ5QGUGB4pVe6i4+JvXMMDXi+IzBmXStlb6kajBWxChq7N4a5KRMxoWULLp8Nnj+MgytGfN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLEcNTh5fW1RysQXudWzNyLj1piNxVwys/EQOXaDKHc=;
 b=b9xqmuT8cDVMCMI+xZWtbj4g/DsjqrOhletbIwYyPiztOF3zpFcjHwQXysADlWwzcg2K0dPsNIz4rpIUQ1fAZay2eM0+KApY0b3rGRiMlKtDRh0XWbEzRJ4swuZWPzyyRTp/U0lG20VMiQc5a/AQXs8K6pX8XsY0EWRCrkATu78=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 23:37:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%6]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 23:37:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Ze Huang <huang.ze@linux.dev>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "spacemit@lists.linux.dev" <spacemit@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] usb: dwc3: add generic driver to support flattened
Thread-Topic: [PATCH v5 2/2] usb: dwc3: add generic driver to support
 flattened
Thread-Index: AQHb7a0JNzaQEImb90G4YNAfakciTbQtniwA
Date: Fri, 11 Jul 2025 23:37:32 +0000
Message-ID: <20250711233728.cmkhbnmgzacwx7uk@synopsys.com>
References: <20250705-dwc3_generic-v5-0-9dbc53ea53d2@linux.dev>
 <20250705-dwc3_generic-v5-2-9dbc53ea53d2@linux.dev>
In-Reply-To: <20250705-dwc3_generic-v5-2-9dbc53ea53d2@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4096:EE_
x-ms-office365-filtering-correlation-id: a68b5acb-f1d0-4781-7c95-08ddc0d3e857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWhCbkZYckVodElOeTNnQnNqRzBPNjR5T2NIZ3JYSSt0Qk1SaDdEa3VSMTJH?=
 =?utf-8?B?dm9BUHN5dGhSR25lcWRodUxpUnhxN1FJUXgzS3l0TE1zZDh1T1NBV0ZLNUNt?=
 =?utf-8?B?c2JUT2ZsQ2laVmhVVUtGc0MvRyswa3ZlL0NCU2RtVjlCQnM1RkF1L2pRdWR1?=
 =?utf-8?B?K1JOaVJGdWVHamIyN2hkeFBKVTVMK3JzeTlvcTF0ZWhDcFdQR1c3MnlIcFV0?=
 =?utf-8?B?UmllQk5QNFZxMWttNVJ6RitVZ2VkZ2JOb3dURFNQa21mdko1K1Znc1hGUnBU?=
 =?utf-8?B?NWl5aEs4UFNCUnBNUUNqYjU4eS92U0pBb2VmdWpIRU9zNThEbHlPekd4SFRy?=
 =?utf-8?B?LzhJdHhRajdLb3QxYWhGWGY4RGVTUU0zamVNd1plWnI1L1NCR1FHdisyUUQ4?=
 =?utf-8?B?dkhXc2hka0wzdTJWeU5EUVB3Q3E5ZkNuTFppdUxyd0NnbktDVG1rdFpEcmkx?=
 =?utf-8?B?SW5UYXpqK09vWXFxNGhtNjdpN3RDYlZKSVRnalFLakQ5NUJVbDNDSUM5OS9C?=
 =?utf-8?B?eTBGUDdTTDVXZTYrYXFPVkw5a3ZjS2h0TzVQOE1jck96K0JFaHNkRHg4RFFG?=
 =?utf-8?B?RkZJblRObTRtQ1BCbVVwL0RzeVBjNnJ0RVlYclB2ZXR6WTJpUXJJQjNpdCtP?=
 =?utf-8?B?ZFRlZE1oVitLQkc1MllNMVdwc0wrckkrNVh0bFdIQzRhSElCY0hPb2dsN0R1?=
 =?utf-8?B?akxJMnFQTVQrSy9wSU5xNkNtWHN4UWg1UzU2a3NBc2cyYmZaU1FFR1RmVWJI?=
 =?utf-8?B?cUVtSG0wSm95R0IwMjVFL01UeWJkRHJxRll5SnMvZUhkNC9nSmE3NWkySnpy?=
 =?utf-8?B?STZpSFdEK0tDK1dqVHVkWElMRzJxeVZhVE9ucUo3aVpNWWo3Yy9rYUxnTWRp?=
 =?utf-8?B?KytjOHlTVy81cjJGbUIydWdNUEVyK3V3bHdIS29EYkNrOVJHR3hia2l6Vko5?=
 =?utf-8?B?cUtlYnpmQlFGZ3ErUzB5RjhDWURWcXhkcDE5cnJzOXN5Qmd1eTRhMm94RWxh?=
 =?utf-8?B?L0RzZkcrdXRQUEcrbnY2UElWelZPMnlLYXJSeDAvY21LZXlaSUk5YTg4VDMv?=
 =?utf-8?B?UFBTNVRJMEFVVi9OT21QUUVQNHU3WVdwOGZubHJ2UHJXcTNPR1dvQlRvblg4?=
 =?utf-8?B?WmJjc0xraDhVTklkQi90WjhxWmtseGM1WVJwZEZkbDAzTzMrdUdyQ01ZZEc4?=
 =?utf-8?B?MGRoYnN2ZU9YVXAxZDlLYWhoZXF3MEZzYkhhK0NpRmxDcE03cjVQb21aR1RL?=
 =?utf-8?B?NGlRRWZiMkM4bFVJNFNndXBTU2dZSTRVa2p3MFpqZHhuaHc2Y0VTODY1OEhV?=
 =?utf-8?B?VlM5SkV2UzRjSGtvRlI5bG9IcVgrNUYwNjVkWXN1RW5iTElGOTY5L29qN05p?=
 =?utf-8?B?ZHZoUldIZ3VZc1dIeENrcURGQ3B5NTgxZGNvU0ZGUnYwOTZRaEl3OFZGTER1?=
 =?utf-8?B?aGVJRzBoTzk2NTdKcUdOcE8vQThGOWlnT2tTT3Z0N0N3MDZXWGcxQUdsd0l0?=
 =?utf-8?B?VmFQU3hwS0V1eDF6YlRPZVpyazFBUm1iQ29hemJ6OFlzTlpiVTF4eVlpOG9N?=
 =?utf-8?B?dW9uRVpvSTVsRXlVbW05UGhLWHYvV2p3bXRuZCtmSnI4T2FPWWVmOSs3WTBR?=
 =?utf-8?B?ME9QNDAraitoTUQzT2JEWmR1bjRwMFhNdzVnUStaaVdqNmNSbVA3ZVFYRTRU?=
 =?utf-8?B?OHdkcjRjQi9seTRiQjdwOG4rZlRRTmNURkkyWXlxM2xUaEgrQldIUVdBL21v?=
 =?utf-8?B?Q0dzWnk5ZGpQSG52bHQzWndLelk3ek80R0QxS1pnQTcyOVIvM05oMjBLLzlt?=
 =?utf-8?B?QW9vL1BSc1d2VDdNWXE0d20xVlg1MHJBalN2WmxseFdRY0lrUXBSN2tFR2Z4?=
 =?utf-8?B?QlJORkxFTllNVXQweGJJTUx6REdRdHdPWmlUaE9VSmFVV2xYU3d5WmJUSTRK?=
 =?utf-8?B?dGNGcnNZTURZYU5ONnczYk5kVXV2ZjFVdzArd2NrNUJpams1Q0xWTndvc1U4?=
 =?utf-8?Q?OZpVQne/GoBnq9SkgBF5RUOSXexnpg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXpjMWJBaHhjSHd4bVliQWE3QkpnelovdGVzU1EzeVIwVEIveHpURUdFTDho?=
 =?utf-8?B?WVI4bmlUVy9qc0RtN0czSEk1TVRMSXN0SU0veWdVN1craThVaThyR0VaMjc5?=
 =?utf-8?B?citoczhmVitpM0FPS1hUL3ZENG1mTWZCUjRWUkFkNUdjRWprS3ZLNGxoNVNt?=
 =?utf-8?B?YUFKZWErcjBYUFlURHh3a2lQZzZxRHNIWWtLd0JEL2xuSGlhdWFLUHNmM1Z6?=
 =?utf-8?B?WXA0cUlGRFlsU2JTblFDYWovVFR3eEQvdW5FTzl6Um9hSTY2ejZkSnIrNlhW?=
 =?utf-8?B?L29Cb1hRYmpBWHlheXhaZElVMU1qUlRDVmRCNnpCR3hucVpWWk02RVI4SENs?=
 =?utf-8?B?d3h3ZlNPRGtLQ1lYT1ByRU40SkhnSzZyaEErdkhTYjdyRUdxNVZtVDA4OUor?=
 =?utf-8?B?dWFRUk5tOEh4RER0WldwaEVsU3NrdlQxYTU5UTVsMmlHMmlEWGhVd0lDWEhT?=
 =?utf-8?B?dHRRR042VFlNT0V1STJLM1VZem9Nd284TlZCQzZBUVZSL016MUw4SHZPMlhW?=
 =?utf-8?B?cUVNVTliSW8vWWwvMzVIUm1TeENuNnBta3ZLWGoxL2dsOG41SlF6Ym5ZbnRV?=
 =?utf-8?B?R1l6cXc5YkhJbG5jTXBKMWxyN3RnRHVIOVlxM3JLc2ZEV3VRcUJxTUMvdHVQ?=
 =?utf-8?B?WVFBYld5cjBKQS9JL2ZBaUdZQzdES3pEL2I5UTBpeHNhVlFNR0ZPTUp1cDFT?=
 =?utf-8?B?OVNUN2ErSy80aDRObXJNaWVyZmV5S1d4SytPUlBxQldGcGNZR3ZPSkNnZklN?=
 =?utf-8?B?NmZqMkNFSU10dW9MY0JITWIvMTJhNWo5T0NkTnhkTmo4UXcxdGhoM2RNdDh5?=
 =?utf-8?B?V0VuNnZTeWZhQUVMbGZRWGFiUWNLbG5DRnkxR3lmQTIweXFmeEZvTGdqT1d6?=
 =?utf-8?B?VXBPK24rS2wyaGtGSVJEdEJWOVNqZk4wNVZ0VllaUkdkMmVQVE42Y0ptM3ht?=
 =?utf-8?B?RkNSaStpN3MxUjNsRVVaZjdmQVEzUmc5WTJwR0tjd2VCelorVWhXVFRYdm1K?=
 =?utf-8?B?d0tFZCtzekp2aHU2LzNBZUh2aitiRHBDcFRjZExsK08rNFF4K1ZsdDRBTEg0?=
 =?utf-8?B?dWdUOWx5ekpLS3pUTnJsNzBkeCtySnVmdFY3cWZHM3ZLVzY5Mld0K3M5WUY0?=
 =?utf-8?B?TjZmSlNRbHJCQlNVTFJKVWtEaTlhUVJhRGtiR2lvRTFmZHZIalNGT0FGL1pk?=
 =?utf-8?B?SUFCRklkOXM0ZTlIMS9qZ3FqVGlBTXIzVTA3MDQwbEFjNTBOWUlGd0ZNdU5V?=
 =?utf-8?B?RmZRcVdxc1JHdWVzWTFFL0JZYkNrcm1VWTNpUHJtWG9ZNEFQU1FGRU5vUEZU?=
 =?utf-8?B?eGVaWHJOVGNYcFRGUTQ0Q1pPM21FQ0p0aG5XSVFxMGxkdWdPekl5dldSNExY?=
 =?utf-8?B?UWpvdzNYaXN6WWs5MlBpT01yMnFMUnR4VW5zYXA0eEJPNlE3ZW9zM3hVckJp?=
 =?utf-8?B?NGVtQmZoK24rdUhiQS9WR1ZxOHdaL2Z0aVFlOCtNWXA5Y2xOaDZYSGlYbjRn?=
 =?utf-8?B?Q0pHSlBQei9ZOTUrZU5HNUE0bXVjQU80UGZ4Qjlhb3N6UTJEdS81T1dqNmJu?=
 =?utf-8?B?MFNRY2pGc0FLMlQvbHVHTjlDRzdJdkg5Tm4rNkRaRWJQeFB6a25jN004OFJx?=
 =?utf-8?B?aGhLb3JRRXMzd1pteHBwSVhUdExSd1BQQTRiK0E3QlhvRGVGU3ZETDRLRGN4?=
 =?utf-8?B?UlJsc2xYeGkrYmlUdDVIMEh3c1EzeGlBcGprdDljUU9ya0FpMmJXUlVrZW04?=
 =?utf-8?B?TGVOUG5qcGxPcm16UUEvZFU1VHZTeXhmN3F2aUJiTUlJTDMyYWI5OFptbGtN?=
 =?utf-8?B?RHVpTldNKzFVOU5oYUZLWE91R2J5VTNqMjRPOGFsWkhVOUkyQmRzWWl2Y2NC?=
 =?utf-8?B?MkRHT2QvU0lnNGxMVEZrbGlxY1JwVFhmUFRxNUV4UGtrbWRDMnRRZ0t0R1dm?=
 =?utf-8?B?TGY2M3ZSU3UxK2xYQXkwbm8yUTFCTjZLdkYrbzA5TWZVTVdWeXV2WFFDS01Z?=
 =?utf-8?B?YjYxVkZyWFpRMk1OaGRpM1NsT2JrZUtaVWUwUEgvTGVOd3pZb091WGFoWTls?=
 =?utf-8?B?dklsS3lGRTZwdXpRcnMzQ01rNm5hUEFLMzdSMFIyT3MvT2RSUzBubHJuNk9h?=
 =?utf-8?B?ek5sWXlQRDRjTEtLNGxBRyt1c0FJamxqNzQ5eElKYkZybjMzcU9ySlBPWmY5?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EFC7116B921F241A075AA552C3DDE16@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	soMnk75F+HJmpWYpcK6TNzw8Dbka2TiPPkQivCJ60IVFqXUhLuWeiRFP7bNp4ZCs11tX/LIIGihp2OrptTneDalpONo37djkcuM8jzQyiVQA1ODDttEdhxbN3bosVQEM5s6BriaZEwupVZR707ktwHct/jPQZUMJ9GuPGAP3cDF1JD0Eb1/x8FQMqDeOqIqDcxxTDVtHKLsj1g6LVQjvfXoAO2hRXa9hyBYkh4A1M0KQfOheWokw2JjtqfJyuum9ZLc9HmqEzGUIBGP+vc2kUW48pcqgQI78NiZY19lWU0+WQXNHSyNsSed3H+gJnHKyzgOTclprNxAS4PIaI1NqN7Sm8ezl0MYHVwOGTosDzkAKMptFaBErksGhcEiS8sxRpL8OYxvUuV/3C+TBBmSt2ZBUXjWhp+F/ObaxWcEH/9bXDOl/IgPYeFOJQ6xIrxocnl1Rs9DK3MwosMAph4FkJico2/A+MyMxOSTFlr1A/RpKUgJGF3kgotxvB45XEYsuepOxfx30DvpwyAs7ViK1mc0sVhctO03UvkbKu4crKx8SZ5hmQqUBPn8fUy3fB/JO74fYkIVtTI2k/2Wfsl+wGzLJv9BG756khXbOYDhH+zFfe5dj8M4pfJZv9L3ifxKdihUvFeXTIZhyoh3Mc1D6Ng==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68b5acb-f1d0-4781-7c95-08ddc0d3e857
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 23:37:32.4726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jo7/sjfKOcjLADsPJrLlk1uWSW9P9JKRN7fJcImymWE8D832qCYLHnGFR9BUQ3o2dWk49SdA0/PrZUFYdrvsCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE3OSBTYWx0ZWRfX3AFDFBvB5nde
 DWKEn3d0QJUE79gkBvQ1VnQZbjQ+deYriwTikWMRNtLcRD3pqZo5rXUENNtJcfUCM0li9n7fu3x
 gnnGvLWpvVw0dGdygnE34AcDNfMaZ6S9ozVscPe5YpWoIyjxCj3yrVZ7WerSHT9O2bP/xPKxWrN
 2+HQW9qoKSkth2BuJHRdyUjvBvzpwdvYlm4HEGnFNysvDfFKIMN9IXcfbjbDU87pIar5WdOcx+a
 jGcotATuyDL65BomIbg+wOXKo8YgT73ugTdGAi43qYKyCract0OZuYVInYq+nUIf3p1lpnA9uFZ
 HY32VlEe3rX41bWx4pSmDZtzxrBJo48At0nIuqdsPclAVXZcFi9L0+fEWD+VuZIlyeLHQy3hUCg
 y5vllVDlhR5NyfB8vkqpHYN5+yzspjr90jP/bzhw75ZWmq3/wCZpFlaL799Ejkfm+D1KK6+b
X-Authority-Analysis: v=2.4 cv=cOzgskeN c=1 sm=1 tr=0 ts=6871a048 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=qPHU084jO2kA:10 a=Rl9bu5jJuELA1LziygoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Qypial7bS5ofd9svbQ0hn22MoRkpLIav
X-Proofpoint-GUID: Qypial7bS5ofd9svbQ0hn22MoRkpLIav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000 definitions=main-2507110179

T24gU2F0LCBKdWwgMDUsIDIwMjUsIFplIEh1YW5nIHdyb3RlOg0KPiBUbyBzdXBwb3J0IGZsYXR0
ZW5lZCBkd2MzIGR0IG1vZGVsIGFuZCBkcm9wIHRoZSBnbHVlIGxheWVyLCBpbnRyb2R1Y2UgdGhl
DQo+IGBkd2MzLWdlbmVyaWNgIGRyaXZlci4gVGhpcyBlbmFibGVzIGRpcmVjdCBiaW5kaW5nIG9m
IHRoZSBEV0MzIGNvcmUgZHJpdmVyDQo+IGFuZCBvZmZlcnMgYW4gYWx0ZXJuYXRpdmUgdG8gdGhl
IGV4aXN0aW5nIGdsdWUgZHJpdmVyIGBkd2MzLW9mLXNpbXBsZWAuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBaZSBIdWFuZyA8aHVhbmcuemVAbGludXguZGV2Pg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNi
L2R3YzMvS2NvbmZpZyAgICAgICAgICAgICB8ICAxMSArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMv
TWFrZWZpbGUgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2Vu
ZXJpYy1wbGF0LmMgfCAxODIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMTk0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL0tjb25maWcgYi9kcml2ZXJzL3VzYi9kd2MzL0tjb25maWcNCj4gaW5k
ZXggMzEwZDE4MmUxMGI1MGIyNTNkN2U1YTUxNjc0ODA2ZTZlYzQ0MmEyYS4uNDkyNWQxNTA4NGY4
MTZkM2ZmOTIwNTliNDc2ZWJjYzc5OWI1NmI1MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvS2NvbmZpZw0KPiBAQCAtMTg5
LDQgKzE4OSwxNSBAQCBjb25maWcgVVNCX0RXQzNfUlRLDQo+ICAJICBvciBkdWFsLXJvbGUgbW9k
ZS4NCj4gIAkgIFNheSAnWScgb3IgJ00nIGlmIHlvdSBoYXZlIHN1Y2ggZGV2aWNlLg0KPiAgDQo+
ICtjb25maWcgVVNCX0RXQzNfR0VORVJJQ19QTEFUDQo+ICsJdHJpc3RhdGUgIkRXQzMgR2VuZXJp
YyBQbGF0Zm9ybSBEcml2ZXIiDQo+ICsJZGVwZW5kcyBvbiBPRiAmJiBDT01NT05fQ0xLDQo+ICsJ
ZGVmYXVsdCBVU0JfRFdDMw0KPiArCWhlbHANCj4gKwkgIFN1cHBvcnQgVVNCMyBmdW5jdGlvbmFs
aXR5IGluIHNpbXBsZSBTb0MgaW50ZWdyYXRpb25zLg0KPiArCSAgQ3VycmVudGx5IHN1cHBvcnRz
IFNwYWNlbWlUIERXQyBVU0IzLiBQbGF0Zm9ybXMgdXNpbmcNCj4gKwkgIGR3YzMtb2Ytc2ltcGxl
IGNhbiBlYXNpbHkgc3dpdGNoIHRvIGR3YzMtZ2VuZXJpYyBieSBmbGF0dGVuaW5nDQo+ICsJICB0
aGUgZHdjMyBjaGlsZCBub2RlIGluIHRoZSBkZXZpY2UgdHJlZS4NCj4gKwkgIFNheSAnWScgb3Ig
J00nIGhlcmUgaWYgeW91ciBwbGF0Zm9ybSBpbnRlZ3JhdGVzIERXQzMgaW4gYSBzaW1pbGFyIHdh
eS4NCj4gKw0KPiAgZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvTWFrZWZp
bGUgYi9kcml2ZXJzL3VzYi9kd2MzL01ha2VmaWxlDQo+IGluZGV4IDgzMGU2YzllNWZlMDczYzFm
NjYyY2UzNGI2YTRhMmRhMzRjNDA3YTIuLjk2NDY5ZTQ4ZmY5ZDE4OWNjOGQwYjY1ZTY1NDI0ZWFl
MjE1OGJjZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvTWFrZWZpbGUNCj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9NYWtlZmlsZQ0KPiBAQCAtNTcsMyArNTcsNCBAQCBvYmotJChD
T05GSUdfVVNCX0RXQzNfSU1YOE1QKQkJKz0gZHdjMy1pbXg4bXAubw0KPiAgb2JqLSQoQ09ORklH
X1VTQl9EV0MzX1hJTElOWCkJCSs9IGR3YzMteGlsaW54Lm8NCj4gIG9iai0kKENPTkZJR19VU0Jf
RFdDM19PQ1RFT04pCQkrPSBkd2MzLW9jdGVvbi5vDQo+ICBvYmotJChDT05GSUdfVVNCX0RXQzNf
UlRLKQkJKz0gZHdjMy1ydGsubw0KPiArb2JqLSQoQ09ORklHX1VTQl9EV0MzX0dFTkVSSUNfUExB
VCkJKz0gZHdjMy1nZW5lcmljLXBsYXQubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9kd2MzLWdlbmVyaWMtcGxhdC5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWdlbmVyaWMtcGxh
dC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAuLmYyNTFkZGE2MDkwMzM2NGQ2YjMyNmEwOTA0ZWM5YjExM2U2
MWY1YzANCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2Vu
ZXJpYy1wbGF0LmMNCj4gQEAgLTAsMCArMSwxODIgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gKy8qDQo+ICsgKiBkd2MzLWdlbmVyaWMtcGxhdC5jIC0g
RGVzaWduV2FyZSBVU0IzIGdlbmVyaWMgcGxhdGZvcm0gZHJpdmVyDQo+ICsgKg0KPiArICogQ29w
eXJpZ2h0IChDKSAyMDI1IFplIEh1YW5nIDxodWFuZy56ZUBsaW51eC5kZXY+DQo+ICsgKg0KPiAr
ICogSW5zcGlyZWQgYnkgZHdjMy1xY29tLmMgYW5kIGR3YzMtb2Ytc2ltcGxlLmMNCj4gKyAqLw0K
PiArDQo+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gKyNpbmNsdWRlICJn
bHVlLmgiDQo+ICsNCj4gK3N0cnVjdCBkd2MzX2dlbmVyaWMgew0KPiArCXN0cnVjdCBkZXZpY2UJ
CSpkZXY7DQo+ICsJc3RydWN0IGR3YzMJCWR3YzsNCj4gKwlzdHJ1Y3QgY2xrX2J1bGtfZGF0YQkq
Y2xrczsNCj4gKwlpbnQJCQludW1fY2xvY2tzOw0KPiArCXN0cnVjdCByZXNldF9jb250cm9sCSpy
ZXNldHM7DQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVzZXRfY29u
dHJvbF9hc3NlcnQodm9pZCAqZGF0YSkNCj4gK3sNCj4gKwlyZXNldF9jb250cm9sX2Fzc2VydChk
YXRhKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgZHdjM19nZW5lcmljX2Nsa19idWxrX2Rp
c2FibGVfdW5wcmVwYXJlKHZvaWQgKmRhdGEpDQo+ICt7DQo+ICsJc3RydWN0IGR3YzNfZ2VuZXJp
YyAqZHdjMyA9IGRhdGE7DQo+ICsNCj4gKwljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShkd2Mz
LT5udW1fY2xvY2tzLCBkd2MzLT5jbGtzKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBkd2Mz
X2dlbmVyaWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlz
dHJ1Y3QgZHdjM19wcm9iZV9kYXRhIHByb2JlX2RhdGEgPSB7fTsNCj4gKwlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiArCXN0cnVjdCBkd2MzX2dlbmVyaWMgKmR3YzM7DQo+ICsJ
c3RydWN0IHJlc291cmNlICpyZXM7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWR3YzMgPSBkZXZt
X2t6YWxsb2MoZGV2LCBzaXplb2YoKmR3YzMpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWR3YzMp
DQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJZHdjMy0+ZGV2ID0gZGV2Ow0KPiArDQo+
ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZHdjMyk7DQo+ICsNCj4gKwlyZXMgPSBwbGF0
Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiArCWlmICghcmVz
KSB7DQo+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIm1pc3NpbmcgbWVtb3J5IHJlc291cmNlXG4i
KTsNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsJfQ0KPiArDQo+ICsJZHdjMy0+cmVzZXRzID0g
ZGV2bV9yZXNldF9jb250cm9sX2FycmF5X2dldF9vcHRpb25hbF9leGNsdXNpdmUoZGV2KTsNCj4g
KwlpZiAoSVNfRVJSKGR3YzMtPnJlc2V0cykpDQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRl
diwgUFRSX0VSUihkd2MzLT5yZXNldHMpLCAiZmFpbGVkIHRvIGdldCByZXNldHNcbiIpOw0KPiAr
DQo+ICsJcmV0ID0gcmVzZXRfY29udHJvbF9hc3NlcnQoZHdjMy0+cmVzZXRzKTsNCj4gKwlpZiAo
cmV0KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBhc3Nl
cnQgcmVzZXRzXG4iKTsNCj4gKw0KPiArCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChk
ZXYsIGR3YzNfZ2VuZXJpY19yZXNldF9jb250cm9sX2Fzc2VydCwgZHdjMy0+cmVzZXRzKTsNCj4g
KwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJdXNsZWVwX3JhbmdlKDEwLCAx
MDAwKTsNCj4gKw0KPiArCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoZHdjMy0+cmVzZXRz
KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZh
aWxlZCB0byBkZWFzc2VydCByZXNldHNcbiIpOw0KPiArDQo+ICsJcmV0ID0gZGV2bV9jbGtfYnVs
a19nZXRfYWxsKGR3YzMtPmRldiwgJmR3YzMtPmNsa3MpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiAr
CQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBnZXQgY2xvY2tzXG4i
KTsNCj4gKw0KPiArCWR3YzMtPm51bV9jbG9ja3MgPSByZXQ7DQo+ICsNCj4gKwlyZXQgPSBjbGtf
YnVsa19wcmVwYXJlX2VuYWJsZShkd2MzLT5udW1fY2xvY2tzLCBkd2MzLT5jbGtzKTsNCj4gKwlp
ZiAocmV0KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBl
bmFibGUgY2xvY2tzXG4iKTsNCj4gKw0KPiArCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNl
dChkZXYsIGR3YzNfZ2VuZXJpY19jbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZSwgZHdjMyk7DQo+
ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCWR3YzMtPmR3Yy5kZXYgPSBk
ZXY7DQo+ICsJcHJvYmVfZGF0YS5kd2MgPSAmZHdjMy0+ZHdjOw0KPiArCXByb2JlX2RhdGEucmVz
ID0gcmVzOw0KPiArCXByb2JlX2RhdGEuaWdub3JlX2Nsb2Nrc19hbmRfcmVzZXRzID0gdHJ1ZTsN
Cj4gKwlyZXQgPSBkd2MzX2NvcmVfcHJvYmUoJnByb2JlX2RhdGEpOw0KPiArCWlmIChyZXQpDQo+
ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIERX
QzMgQ29yZVxuIik7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZv
aWQgZHdjM19nZW5lcmljX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAr
ew0KPiArCXN0cnVjdCBkd2MzX2dlbmVyaWMgKmR3YzMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShw
ZGV2KTsNCj4gKw0KPiArCWR3YzNfY29yZV9yZW1vdmUoJmR3YzMtPmR3Yyk7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBpbnQgZHdjM19nZW5lcmljX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiArew0KPiArCXN0cnVjdCBkd2MzX2dlbmVyaWMgKmR3YzMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gZHdjM19wbV9zdXNwZW5kKCZkd2MzLT5k
d2MpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwljbGtfYnVsa19k
aXNhYmxlX3VucHJlcGFyZShkd2MzLT5udW1fY2xvY2tzLCBkd2MzLT5jbGtzKTsNCj4gKw0KPiAr
CXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGR3YzNfZ2VuZXJpY19yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBkd2MzX2dlbmVyaWMgKmR3YzMg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gY2xr
X2J1bGtfcHJlcGFyZV9lbmFibGUoZHdjMy0+bnVtX2Nsb2NrcywgZHdjMy0+Y2xrcyk7DQo+ICsJ
aWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldCA9IGR3YzNfcG1fcmVzdW1l
KCZkd2MzLT5kd2MpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwly
ZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBkd2MzX2dlbmVyaWNfcnVudGltZV9z
dXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjM19nZW5lcmlj
ICpkd2MzID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwlyZXR1cm4gZHdjM19ydW50
aW1lX3N1c3BlbmQoJmR3YzMtPmR3Yyk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjM19n
ZW5lcmljX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1
Y3QgZHdjM19nZW5lcmljICpkd2MzID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwly
ZXR1cm4gZHdjM19ydW50aW1lX3Jlc3VtZSgmZHdjMy0+ZHdjKTsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIGludCBkd2MzX2dlbmVyaWNfcnVudGltZV9pZGxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
K3sNCj4gKwlzdHJ1Y3QgZHdjM19nZW5lcmljICpkd2MzID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ICsNCj4gKwlyZXR1cm4gZHdjM19ydW50aW1lX2lkbGUoJmR3YzMtPmR3Yyk7DQo+ICt9DQo+
ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2MzX2dlbmVyaWNfZGV2X3Bt
X29wcyA9IHsNCj4gKwlTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhkd2MzX2dlbmVyaWNfc3VzcGVu
ZCwgZHdjM19nZW5lcmljX3Jlc3VtZSkNCj4gKwlTRVRfUlVOVElNRV9QTV9PUFMoZHdjM19nZW5l
cmljX3J1bnRpbWVfc3VzcGVuZCwgZHdjM19nZW5lcmljX3J1bnRpbWVfcmVzdW1lLA0KPiArCQkJ
ICAgZHdjM19nZW5lcmljX3J1bnRpbWVfaWRsZSkNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGR3YzNfZ2VuZXJpY19vZl9tYXRjaFtdID0gew0KPiArCXsg
LmNvbXBhdGlibGUgPSAic3BhY2VtaXQsazEtZHdjMyIsIH0sDQo+ICsJeyAvKiBzZW50aW5lbCAq
LyB9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgZHdjM19nZW5lcmljX29mX21h
dGNoKTsNCj4gKw0KPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgZHdjM19nZW5lcmlj
X2RyaXZlciA9IHsNCj4gKwkucHJvYmUJCT0gZHdjM19nZW5lcmljX3Byb2JlLA0KPiArCS5yZW1v
dmUJCT0gZHdjM19nZW5lcmljX3JlbW92ZSwNCj4gKwkuZHJpdmVyCQk9IHsNCj4gKwkJLm5hbWUJ
PSAiZHdjMy1nZW5lcmljLXBsYXQiLA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBkd2MzX2dlbmVy
aWNfb2ZfbWF0Y2gsDQo+ICsJCS5wbQk9ICZkd2MzX2dlbmVyaWNfZGV2X3BtX29wcywNCg0KWW91
J3JlIHN0aWxsIG5vdCB1c2luZyB0aGUgbmV3IHBtX3B0cigpL3BtX3NsZWVwX3B0ci4gVGhlIGtl
cm5lbCBidWlsZA0KYm90IHdpbGwgY29tcGxhaW4gYWJvdXQgdGhlIG1heWJlIHVudXNlZCBmdW5j
dGlvbnMuDQoNCkJSLA0KVGhpbmgNCg==

