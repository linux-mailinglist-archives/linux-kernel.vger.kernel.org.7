Return-Path: <linux-kernel+bounces-759567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D199B1DF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 00:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398705847F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6F26158B;
	Thu,  7 Aug 2025 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sGCD0Jpi";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JmU8Lx0k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R8uVbieJ"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B022370A;
	Thu,  7 Aug 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606057; cv=fail; b=Vsv+xErYegLFQfwPRfNJc10HujQNxJ3TjqT1zfiWjeE3CHd6ghsC/EZc/Dvb7XRUQp5uH5QMimlt4lZvC1SIURwNC239AzrGScUk5VwmZAKLyEIo6fDS+EryExyIabkDkkqOKR0sj8JYtKKK5SGzX7e5gBMaDbz9O/cbiYfdN9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606057; c=relaxed/simple;
	bh=8nYwgrXLwbyagU9LxK9VVpXubOOjsvvlL0nRUFpr0VM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOmC63vQCzL3r1GjzX2dYqj5izN1FPqQT80ZFhysacjPvfzm1D6sKxZpKP/HJTStBMDJO2/AdW/sCYN5CPDlYZfFDpIvLs3tfMCSh96v/MEZ6LUvXX8fmTmXPuZsN+duo2rP0cARU842nisafLQzSspRnVGGaPUXUjcDRP2vnkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=unknown smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sGCD0Jpi; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=JmU8Lx0k; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R8uVbieJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577Ghtte002778;
	Thu, 7 Aug 2025 15:34:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=8nYwgrXLwbyagU9LxK9VVpXubOOjsvvlL0nRUFpr0VM=; b=
	sGCD0JpinCnbcxCyplTUVdwut49heHAbJsZxYsrtRLplCNthU++Ze/Ft3PGiDCjJ
	SgK1lMSVdQvYSTxIIwdeglxhtkHZ07Ven/TaqL1aVDL6+JAWUMXGc2AYUA0C4A77
	A1dx8+pjnLh5NUSRK1RLiJVlF+9uGl234P6Cfae1PY6aWvapW1zGK8OICbLLnKMb
	Lho3SipvfcvogMbLXcArlEJa254X1z+QCHfRCJgmASTwkbF2zEQafrai9vMqlniP
	wE6p4OCQlFg3S+SCdjZv0HPc+HFfSFQI7mxZOsB8OeZK98nRuEDbtuoqYuO53PDJ
	3jWtxq1Wo0oGeC0SuoUgrA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48bq0wntae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754606040; bh=8nYwgrXLwbyagU9LxK9VVpXubOOjsvvlL0nRUFpr0VM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=JmU8Lx0kUeVZxRgSOZFKJB898V0vnn1V8TNCNLoYFypQvUYLCa1x+MNVO9X0QCUDK
	 adv87q9+qrL/wJyBBsclmS76Pb406t5yVotN7syFSs3CdynFPY6y3xQOlu2M75gv0S
	 XbSPUATNcTWtXm2G8eQzUgrra/OtfttCWy/TBrq1ZDj5DCzy2fmNv9tciYYzHtNeH0
	 ycl0YKcApCFzWtMD9uCixF2FKHRArc6PlzoNgq8geJLn7PcKjrUOEtoU9y7t6CGp+O
	 wON3UsF50uVeBdUcH/UEvZD9fcx3d3KsI5FGbdtmkEQZd2DOR8mv2VlLCKF5/po5AU
	 Nra4tVgLaJqlQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DF96640087;
	Thu,  7 Aug 2025 22:33:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id BCFA1A0098;
	Thu,  7 Aug 2025 22:33:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=R8uVbieJ;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 16F47401CA;
	Thu,  7 Aug 2025 22:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtiZZE/R969n3Z4ZWGAqtG/nvR+pFhWhg20CSVxVtrjOjpuIDvKOmgwEe+JyyxkeKRWUQSELQKpvEIhCJjQdJn1gDu1+TmHjAf1G4Ql6SoeS5ZPacgilS/k2EahGS6QbGV6MBmJzWBqdVtTU4Mhp+p+1Wzz/tyFFBHEACC13hbL9gT7ZP7LwiuYCb+rwWez4K1EYE//X44FywvJKm3F2n2IQJjMq9ghk2x4m2rid+SypP5OW78JrBSPslaYDW/Ddm/G3qzB94NZBkyapkt7WbLDxBCNl89NfOailQQulDlPhsZInOVcAmJc46W/Tk8iaZXDlKPPd1KpM6nyLkfFurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nYwgrXLwbyagU9LxK9VVpXubOOjsvvlL0nRUFpr0VM=;
 b=HDjJ/HXHqrEu7kF7EwSli0E92LF5ghe49UhmwdDlFXwABrxXdzP+sDYnlGYrtwoin8Qhhi84r6ZlyRlUMVurplIbenfd/BO45hK7yWe9S8zyViuoXuyGcv1+97GMCE7kTOz9S8i7HYMb5R0Mod7vV3gbA/2iL8iX22ubMrXAl/xV/+jsQaVFpS5HcGdl5PiCBAxqETun27wlEOyFGCEGhFhvKgUDD89OpmqnuAHLG4lNo+WQCu+AZM3sJzV9e2/ktzjn8b1JAu7CF1P8vbymt++kGq5dN3knzyB3HxBPdNRtgfAcaho+M79Jec5nJd+Fedcs3Hv/0MmIAt0IQm9XhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nYwgrXLwbyagU9LxK9VVpXubOOjsvvlL0nRUFpr0VM=;
 b=R8uVbieJ6FA4RHbaH5utmb8hxvT4M1NeqOFPwYaoqXc7TcoUBBauSAM1A05k76V8JMAReggImumsCoPDwqu3h5RqpA0z7tsTxHLTY46DyAjSD4XeEFDSoCUvjzW2in+tKDfrvHiRkWDXbGGYTenhnU7hRCWBJa/37pvGy4wDkK4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 7 Aug
 2025 22:33:56 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 22:33:56 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Ignore late xferNotReady event to prevent
 halt timeout
Thread-Topic: [PATCH v2] usb: dwc3: Ignore late xferNotReady event to prevent
 halt timeout
Thread-Index: AQHcB3qycPVjROvtA0CQjVH9ZxIRnrRXx7+A
Date: Thu, 7 Aug 2025 22:33:56 +0000
Message-ID: <20250807223353.2h6ytbxqkkzijfgx@synopsys.com>
References: <20250807090700.2397190-1-khtsai@google.com>
In-Reply-To: <20250807090700.2397190-1-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA0PR12MB4381:EE_
x-ms-office365-filtering-correlation-id: aa173fc8-1656-4e5a-5056-08ddd6027f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?alB4S1RHdHQvMnRGQWRUQ1RxRFd3TkY4RSt6NEJOSnFsRFVuVjRXTUlOZXJ4?=
 =?utf-8?B?VWNPTkFJR1BuZFYyL29Qa1o3VnBPTjREMXk4TlZzVThTb0xJVVlsZVN0Smh5?=
 =?utf-8?B?NFcveTFncThxSFZsY1JhYWNVcWJOQXVIOUM2bkZuelpEeDNNQWtoU2tra0tu?=
 =?utf-8?B?WjZhUzdOazREYXlXSERISXcxTkpYUllkQkVJUzJyT3I3VnQwQnpxOFNQR1ZF?=
 =?utf-8?B?TTlBVHNJbDk4R1ZJNU4wbUtCNlJvcTY2NTZUSGs2V0FkS2JEOGJFVEhoWE1s?=
 =?utf-8?B?dDQyNHgzMExaYW5oUUo4L0pIT0tzbGROaENpUG93WVdtblIwYUt1aTZyTFoz?=
 =?utf-8?B?dWVrMkJqcFNKcFR4bkJDSmh0bmNBNWUxdFhzTFNCeXFRVDRDUHRtOHhORy9K?=
 =?utf-8?B?UkZzKzhqUmpzWUpQK3JZU0laYlVZc1A5Ym90ajRpUXE4a0xqczZoSklsWEJE?=
 =?utf-8?B?NWRmaVh5SDJhRlJOTjRENnFWclNOK2NYSHBLSWpoQmxvYnp5OGJ3QU53N0xZ?=
 =?utf-8?B?WkVFUnBmcUZtOFBUVmJESkp4ZnpKOWN2WUM4R2tHU2orYWZybStoblB4czR6?=
 =?utf-8?B?RmQzd2dMcmFTa2NrdmFTb3JEdy9oTUpUTHlXZWdzOGIrdlhvNGpGdTNaU1VG?=
 =?utf-8?B?Z1Y5cUpaOFNpUVZFMFZhTEtHY05RdTJSM2tqY3ZaekFFS0VBaW91ODdsWG82?=
 =?utf-8?B?Skh3aHBKV2pER3UzT2R0S0xHcDU4QVlrT2dYcyt2QlVwbzhoeTFhUjA2T1dY?=
 =?utf-8?B?Ry9SZGdOK0NQZ0ZaeHJXV1kweWpkRTY0RUg0WVRGdkVBbkxMeFF0TVRib1hE?=
 =?utf-8?B?czBmdVpaR0l4NmxPMXpLZTBPUHpmWTBmcEM1cFhGclpBUVhUbGFwbWp2dFI5?=
 =?utf-8?B?VWhpcHJOUHFFSDBJNEpPSHVReU0zaXJuUHJMUjdrdEtDelFvNWVhQTMvWmZJ?=
 =?utf-8?B?elpLcVR4cklXYy9keHFPYUlmTlQ1WVpJcjFuUVpSWTF3dk9Da2FxL2k3bFlj?=
 =?utf-8?B?L1ZOS00wRFlaeTEyd0cxUXJyRjZRL01qNWR1bFFGQ2dENVAzVDUxTlh6bHB1?=
 =?utf-8?B?andLeFB5RlBWUjVMV0h4ZUlxSU9wdDY3SkY3TnZCQlR4L3hCdUpHcnE4eEk5?=
 =?utf-8?B?a2o1enR1WlM0alhJQjhiMHRuUDNKREdWc0F2YlEySUlMVGI1OFpnTmdCWmpI?=
 =?utf-8?B?L0lPQzE3citNbGp5bGFSL2FFVHREeDNzZ0dtTG1kWG1UWlV1UEc5cGFISThP?=
 =?utf-8?B?dXVBSTY4UnNEQi90MXMxaGp4WHlTVnd3SlRjS09xMVczYU8ySTB0eVA1MnpI?=
 =?utf-8?B?bFM0b2VoWFQ4LzBNM3BIRnMxbDZGVnBRdUZDYmtKc3BBaFVVUG1sL3NsVUZQ?=
 =?utf-8?B?cHdPTi9jejg4Wi95akQ1OG9ydW9pVlpnSk5NRFlXbzJ1Z3VkdXcrZWRRakUz?=
 =?utf-8?B?M0VQaklldFIvdXZaLzNIQlZkemlCaHdNaUV0U2hYSDZkZ2cxeWZOT0ZyWC9q?=
 =?utf-8?B?cGJsTmNBRTVFTjFiZS9mUStOYU5EQVZ5a1lVRkVKS095N1VWODlBQ3F1V2JR?=
 =?utf-8?B?NmZsMzU3OEJkTmhpRk9tTTZxRzRadWpUeWlUS1FqdGllT2puTTNLaCtjblNa?=
 =?utf-8?B?VFdhL25tTFV6OE14NFV1UlB6Mk16S0tMVm9FbDRwdDl6ZGpXUFVTaExDOHdL?=
 =?utf-8?B?ek1ONWZzVlJVY0dRYVRpbW9HalRZTVRjb1dqNWdhcU5jcDIzd2l4bE90TVpQ?=
 =?utf-8?B?RFkrSEk1b05IZ3J2TFBpNUdwejZOSTJsQ0RDVnJyVHNIS1VwdGdhZTFXRU5t?=
 =?utf-8?B?Z21FNTdkd2tOZUxEa3lZUmY1djhibm5IQVJnZ0FwWk8vQS85YkZKNjhDckJU?=
 =?utf-8?B?aFk0RTNGK21XQ3BVUTdsb0YxZ0dpNTh0MmJ6WFpYSUxPUnBUSllpOGZEQWU5?=
 =?utf-8?B?bjRsOWlURjdFNUswZmJFK251dUhla2ZvbUxaYmJERDlmM2k0WHcvSTI4VStr?=
 =?utf-8?Q?EjN6+67f+ogRYNhNeK88ArbwUjfzyg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmx6Ly9rWkh2bHRUYUIvdEo3MkNTNGFJTUlWVXZMaGhUeFo0enRuY1dzcFF0?=
 =?utf-8?B?cEgrbmFKYUFyQVROci9kaTU1aWpjVDU2YVp0WVJaSmNRcDUva1gwQUkxMGRm?=
 =?utf-8?B?TmZHa2lpelZ4c003TGhDQy9yNzBibGN0UHRmazljQ1JxU0Z6UVRlL2VtQ24y?=
 =?utf-8?B?TitZM1dlbXJNaHAvemN3Z1g5akRVUERlNjcxN215NWZvMTA0Q2hVbDVMTGdH?=
 =?utf-8?B?cDhKUGJ5WHpSTzVhbU5jcjBCNnVpSEVNa0dNMWNidzUyTEc0MWZyRUdiTXhI?=
 =?utf-8?B?cVZqWCtKVldtNTdFb0NWb2NEenZpMXRCQTRpK2lDT1J2Mms3dkZlRnRHeDlX?=
 =?utf-8?B?VUdmMEVucmxjMEM0dlVOeG91REJpYkE1aTMyRjlOdlVPSkwrM2Q5VDBDWEha?=
 =?utf-8?B?QmI2Z25SakdBdE94R1EzeGd0MzliREJ5blVrTDVWUzJRd25XNlQzdlZ4ZGtG?=
 =?utf-8?B?MTJqaU1UQjFYOW0rVzlkMHNIdGFRK1FlQ1VDM0xISThVeXV4Uk5VcnJ6QWd5?=
 =?utf-8?B?SzR3TjZQQXFLR0s5cnpBRFZxSjIyU1F6VU12RnRadWV1dnNGbGpXS1RONHQ2?=
 =?utf-8?B?Z01zZU5VbjIweTBZcnF5NlU0KzRodU1PMHFaMnU2bWNtTWJtWFlhbUlmSXdJ?=
 =?utf-8?B?SldOMlkxKzNFRDJmYTB2V1lpeXVlUnFSNUlBS1VmTDRqbTZUTnFoWHgwWHZM?=
 =?utf-8?B?QjNIcUxublZtaVZJTlNnYXVJTjZOTkRSRGo2QkFydWg2S0x5a1ZZL0x0SmlV?=
 =?utf-8?B?cHJxWk1MUWNWVUUrWUZ5SzZseCtaYkE1ODVuekpYdjNzUmk3Wm1laUdsaTkz?=
 =?utf-8?B?NlJOeHBiNlowdGgxNk5hYis0SDh0ejZwRVliNVdFN1Z6S1Zvd3A5QmxaRy9G?=
 =?utf-8?B?OW9CMWpoT0FNa0tIN0l3bzcyT0Yzb0puZVVoM3NCUThlMnJhdE9YZUxjRGs1?=
 =?utf-8?B?ZHd4NHBGSVFVUENlSEEvZE1UL0k1VmlpZUhleVkxY1RTVTNVaUpQMDAraWxM?=
 =?utf-8?B?dktpaGVHOGQ0OTJrNkl1d2RFY2x2NUpJeEphSjF5d3gxWDc2YVcwcUMyT3lY?=
 =?utf-8?B?K21CWGx5Tm81ZkJyL3c0RWRLNFJSUjc2U1lueUs1cHlGYXpoZnRiRkg1K0Jw?=
 =?utf-8?B?aWJHc2UvNXdYMkcrb1FoOVg0dmlHMi90TkljUDFzVmhCbDVOZ09DeFRocTRZ?=
 =?utf-8?B?dldwdkwvZ2FWVUkxV1NKSElyTTZwSzB1cEZrRzVHY1l0VExZSWRRU0JKeVRm?=
 =?utf-8?B?UVM0eTNWcFFQc0xQdllTSktJY09GSUNaQmJHSWVuQzhRRFBRM3REcXpPVTVN?=
 =?utf-8?B?VHBJSktGbDUzejY4UzNQKzV2K2cyVUEvSlBGVklxWG5ITFozQ1BVbjdrTjl1?=
 =?utf-8?B?UWswVVNhQXRiais1VGs1ZmZ1V2R1alJLNktHOXZFVlNQODVyemFMcmJ4TGJO?=
 =?utf-8?B?bmUrd1IzYW93UE4yRWVLUnJSSVZBR1hydDJCVndGK3IycUJaZlhERXpKaThQ?=
 =?utf-8?B?TzhreFJUZGVjQUhSRm1iVGgybFYzNkFOY083OFE4ekdWNlNVTldETVpiRWdl?=
 =?utf-8?B?Zjh3RkI4bko1NU5LaDRHQnNBaGE2dE8yeldGeWluVTNIODkrMXM4a1RlU3l4?=
 =?utf-8?B?T2dxZ3daekpCeDVUWjRSUkx4WUNtT2lCZUlMZHZvcFk2L0d6TGFEYzBZNGR4?=
 =?utf-8?B?c1RRU2NPSmZrUzNQUWhBbGhyTmtjRHFvTU1PVjFheWQyc3JTOGg4dGk1eTJi?=
 =?utf-8?B?SGVaNll1citNT25qMXVQdU9CbnFHUWFDYlFhcWJKQ202bkp5NVJwU094Y2d0?=
 =?utf-8?B?UkZFNkFvTUxjQnIraWlHUlZzVm8rb1FrK3VYTU1zZXpPY01PTkl6WGZRWGsx?=
 =?utf-8?B?MHBFRlNuYnYxbnllUmFkUHpESE5QRG1wekM1YTlVRFl1WS9xbUJLMk9vTzVF?=
 =?utf-8?B?dDNHYWYvdXZBbTZsSHFBOHc1VVoxaXJ1cXk5T3JNVXlJTkU5MzZKSGkzV0hw?=
 =?utf-8?B?SzYzYzJWVU5GU0dTaXVQbi9qWFg2c0FmVS8rMFAwdFZBYVZGWHZUVkEyOUU5?=
 =?utf-8?B?VzlrZy9hcjRuMmNadGR0Q3dRRzhxRy9pdDk2UHdiR2ZHa3BzRUcyRnBhWWM3?=
 =?utf-8?B?dDNHWms1VEtNRE5EdmlGSWswc3hrdmt3MGVjZDc1SUQwalFUUmZwN2dPUlFC?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4CDEF699144D34AB358940F785B40C0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NP30c/VNRn3JwMKY4/WqQf/Iyx2zzBJg+vus6+CJv/akscUd2LNib1aq1WBTgc9JvmgPMtr+NRJwlhq9OoQLBtucUAmjIhUPnPcGxMpGcCcM60Za7h/Fdqhx7AhXDi5+4iDa4acnmvzLR/D0UwyiifqXJK//SxOU2i3YQjrD08pHx0hH10RlZ36JAEwNFZnQ4J0KRp1UtUqWNuF8Xc3RgVt6u5jS2clTGcrGxrfKk+xFJT5ZpIgMx7Aiu1OAVdwx3t/pmlKuYtmz7FqiXJ7L7gVJYEN8XamCFCg0Unnn2M34PUI6QhSeebyIelWSQSIUzv4E/b68hqT5PwLvYVCW2UgXqmjWIScGqom6gqOFjcyjNCYegX3GmZZOBrB0YDSJcUOJqwV9PrEBGVwNGFPGsqI46uBLVKFn70SN5PT0CptJPEXi500bNw6pKThPQckbRl5qRTxO9IJ2028LfC3Qh/rH2Imav8go6UwvGlcgE2ojoOWuuchjhTEZQnrKEFFEaJVXvEK3lSy2jp4TDOOM0C234xAnwM/eTR/tEjuEkMxjLjFo62hPVsE7LV0F/l8ohpLjY4c+Rs3KeW5ZPssO4afNxmDz94nuDqf9rl9SDpzrSgnYsTy8v3u4foKt+ttI8KOdz7IVu3mwFRmR0eljhA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa173fc8-1656-4e5a-5056-08ddd6027f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 22:33:56.8036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcfJRaCbgtpMpSw6ngRwb1OeshOV8c1YY4A5J3NzmtdNEJkDUCPBwC/pTWFhN3/82wiqR4b07WO2jpudYFUkkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Proofpoint-GUID: I_7wRZRcLOMfg56cjK3LNjP9d8rHXU_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyOCBTYWx0ZWRfX/Gp4GIHbb1+E
 iPUnENRnXub8XWirr8zOc9UMRStlA1uyiQ0x7CEVCAwPfSsdmcjiYHtXTuDKQ5vdggGIZ2Lxwzr
 qsaMew5ex12ya0MKKiHdKe8xI+lxzUBMJpiOrDHyXPO+l7XzTjaAkKzVXSNDDn+4Pst2WkRAkOW
 d0kRkeEpiGua+3tX/GxfOZIAuejna6HqFZKR+AeNs0Wx62R8oGAQ0lE0MU9cZYCKMsJA84ttkKU
 SVvnk4X0Fh+wUgAA4q6zdqEtGQ1JAGlTSsuEadGkmd4/eFg0fRVGUKapBNk9oniJuyB+I9GuqXV
 21P5yN5JTgeWM/C/xAURZVL+II03m1RSwKoAr5CT2UIgwjQmabObbVMhl+ZEatWMX0Uf28O7yel
 uCk0N6Xk
X-Proofpoint-ORIG-GUID: I_7wRZRcLOMfg56cjK3LNjP9d8rHXU_k
X-Authority-Analysis: v=2.4 cv=HYMUTjE8 c=1 sm=1 tr=0 ts=689529d9 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=RXhgSOCzYp4nN75w9_4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508050128

T24gVGh1LCBBdWcgMDcsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IER1cmluZyBhIGRl
dmljZS1pbml0aWF0ZWQgZGlzY29ubmVjdCwgdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIHJlc2V0
cw0KPiB0aGUgZXZlbnQgZmlsdGVyLCBhbGxvd2luZyBhIG5ldyB4ZmVyTm90UmVhZHkgZXZlbnQg
dG8gYmUgZ2VuZXJhdGVkDQo+IGJlZm9yZSB0aGUgY29udHJvbGxlciBpcyBmdWxseSBoYWx0ZWQu
IFByb2Nlc3NpbmcgdGhpcyBsYXRlIGV2ZW50DQo+IGluY29ycmVjdGx5IHRyaWdnZXJzIGEgU3Rh
cnQgVHJhbnNmZXIsIHdoaWNoIHByZXZlbnRzIHRoZSBjb250cm9sbGVyDQo+IGZyb20gaGFsdGlu
ZyBhbmQgcmVzdWx0cyBpbiBhIERTVFMuREVWQ1RMSExUIGJpdCBwb2xsaW5nIHRpbWVvdXQuDQo+
IA0KPiBJZ25vcmUgdGhlIGxhdGUgeGZlck5vdFJlYWR5IGV2ZW50IGlmIHRoZSBjb250cm9sbGVy
IGlzIGFscmVhZHkgaW4gYQ0KPiBkaXNjb25uZWN0ZWQgc3RhdGUuDQo+IA0KPiBGaXhlczogNzIy
NDZkYTQwZjM3ICgidXNiOiBJbnRyb2R1Y2UgRGVzaWduV2FyZSBVU0IzIERSRCBEcml2ZXIiKQ0K
PiBDYzogc3RhYmxlIDxzdGFibGVAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogS3Vlbi1I
YW4gVHNhaSA8a2h0c2FpQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiBUcmFjaW5nOg0KPiANCj4gIyBT
dG9wIGFjdGl2ZSB0cmFuc2ZlcnMgYnkgc2VuZGluZyBFbmQgVHJhbnNmZXIgY29tbWFuZHMNCj4g
ZHdjM19nYWRnZXRfZXBfY21kOiBlcDFvdXQ6IGNtZCAnRW5kIFRyYW5zZmVyJyBbMjBkMDhdIHBh
cmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+
IGR3YzNfZ2FkZ2V0X2VwX2NtZDogZXAxaW46IGNtZCAnRW5kIFRyYW5zZmVyJyBbNDBkMDhdIHBh
cmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+
ICAuLi4NCj4gIyBSZWNpZXZlIGFuIHhmZXJOb3RSZWFkeSBldmVudCBvbiBhbiBJU09DIElOIGVu
ZHBvaW50DQo+IGR3YzNfZXZlbnQ6IGV2ZW50ICgzNWQwMTBjNik6IGVwMWluOiBUcmFuc2ZlciBO
b3QgUmVhZHkgWzAwMDAzNWQwXSAoTm90IEFjdGl2ZSkNCj4gZHdjM19nYWRnZXRfZXBfY21kOiBl
cDFpbjogY21kICdTdGFydCBUcmFuc2ZlcicgWzM1ZDYwNDA2XSBwYXJhbXMgMDAwMDAwMDAgZmZm
ZmI2MjAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPiBkd2MzX2dhZGdldF9lcF9j
bWQ6IGVwMmluOiBjbWQgJ0VuZCBUcmFuc2ZlcicgWzMwZDA4XSBwYXJhbXMgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogVGltZWQgT3V0DQo+ICAuLi4NCj4gIyBTdGFydCBw
b2xsaW5nIERTVFMuREVWQ1RSTEhMVA0KPiBkd2MzX2dhZGdldF9ydW5fc3RvcDogc3RhcnQgcG9s
bGluZyBEV0MzX0RTVFNfREVWQ1RSTEhMVA0KPiAgLi4uDQo+ICMgSEFMVCB0aW1lb3V0IGFuZCBw
cmludCBvdXQgdGhlIGVuZHBvaW50IHN0YXR1cyBmb3IgZGVidWdnaW5nDQo+IGR3YzNfZ2FkZ2V0
X3J1bl9zdG9wOiBmaW5pc2ggcG9sbGluZyBEV0MzX0RTVFNfREVWQ1RSTEhMVCwgaXNfb249MCwg
cmVnPTANCj4gZHdjM19nYWRnZXRfZXBfc3RhdHVzOiBlcDFvdXQ6IG1wcyAxMDI0LzI3NjUgc3Ry
ZWFtcyAxNiBidXJzdCA1IHJpbmcgNjQvNTYgZmxhZ3MgRTpzd2JwOj4NCj4gZHdjM19nYWRnZXRf
ZXBfc3RhdHVzOiBlcDFpbjogbXBzIDEwMjQvMTAyNCBzdHJlYW1zIDE2IGJ1cnN0IDIgcmluZyAy
MS82NCBmbGFncyBFOnN3QnA6PA0KPiBkd2MzX2dhZGdldF9lcF9zdGF0dXM6IGVwMm91dDogbXBz
IDEwMjQvMjc2NSBzdHJlYW1zIDE2IGJ1cnN0IDUgcmluZyA1Ni80OCBmbGFncyBlOnN3YnA6Pg0K
PiANCj4gLS0tDQo+IHYxIC0+IHYyOiBVcGRhdGVkIHRoZSBjb21taXQgSUQgZm9yIHRoZSBGaXhl
cyB0YWcgYW5kIGFkZGVkIHRoZSBtaXNzaW5nICEuDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYyB8IDkgKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggMjVkYjM2YzYzOTUxLi42OGZhMjgxM2U1ZjQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMzc3Nyw2ICszNzc3LDE1IEBAIHN0YXRpYyB2b2lkIGR3
YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYW5zZmVyX2NvbXBsZXRlKHN0cnVjdCBkd2MzX2VwICpkZXAs
DQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lbmRwb2ludF90cmFuc2Zlcl9ub3RfcmVhZHko
c3RydWN0IGR3YzNfZXAgKmRlcCwNCj4gIAkJY29uc3Qgc3RydWN0IGR3YzNfZXZlbnRfZGVwZXZ0
ICpldmVudCkNCj4gIHsNCj4gKwkvKg0KPiArCSAqIER1cmluZyBhIGRldmljZS1pbml0aWF0ZWQg
ZGlzY29ubmVjdCwgYSBsYXRlIHhmZXJOb3RSZWFkeSBldmVudCBjYW4NCj4gKwkgKiBiZSBnZW5l
cmF0ZWQgYWZ0ZXIgdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIHJlc2V0cyB0aGUgZXZlbnQgZmls
dGVyLA0KPiArCSAqIGJ1dCBiZWZvcmUgdGhlIGNvbnRyb2xsZXIgaXMgaGFsdGVkLiBJZ25vcmUg
aXQgdG8gcHJldmVudCBhIG5ldw0KPiArCSAqIHRyYW5zZmVyIGZyb20gc3RhcnRpbmcuDQo+ICsJ
ICovDQo+ICsJaWYgKCFkZXAtPmR3Yy0+Y29ubmVjdGVkKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4g
IAlkd2MzX2dhZGdldF9lbmRwb2ludF9mcmFtZV9mcm9tX2V2ZW50KGRlcCwgZXZlbnQpOw0KPiAN
Cj4gIAkvKg0KPiAtLQ0KPiAyLjUwLjEuNTY1LmdjMzJjZDE0ODNiLWdvb2cNCj4gDQoNCkFja2Vk
LWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywN
ClRoaW5o

