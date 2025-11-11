Return-Path: <linux-kernel+bounces-894849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE2C4C404
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639FC3A6CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCD299950;
	Tue, 11 Nov 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VYpDNBsG"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B969476;
	Tue, 11 Nov 2025 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848146; cv=fail; b=TcC+HV2wzjU3VodwJCwEjU3eUL304t1on2fJD4O15JepwYY6bMi33u9CcA3ncl25NtUgsj9EB/qzAuiTXprMGkU9DaDsLrtqXWAKZ5HPtfuPrl23UFvnwBSG/0INwEy2YBNuSbzs2AuV6wmK9rlU6IpgjZm0rc8TsTe2c0nU41E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848146; c=relaxed/simple;
	bh=jiJoX6NL3mOcd0LIjmcJXjrF8kSPAghpvN8NRMWgS7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0co2FtbpC33rNujQpN424iyGuRRx/TbFvkKR1LcDC34eRSYqHtLiPZ6rd4HSQ1hjD/VAS5fPyWYmr7b4tt48aeg7kN/Me6Kx1LyXZd9JlMdLzgy2o8J8MmlGUxSsoGtAdh9jT7KgcvFYlV85KxBYj4oymxpnUyCCjPDCeqBd9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VYpDNBsG; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsGYxYVymkmxyTpPHbOsVrBOo7rrHZPB+YbhQ0Fe8pB+dW7iyze0+edm5geZFiDeaeU5cdOCC7Zil6cV7NAXl9Fer2jhuiFhAbVwjxPwqnl35rqd8hzdc7MTN1TkQ6tmrr25MzpjFjychL7osAknStOBVb4ImzVQ9Z1LmWVXMAbXhbBhbS/QY//gbaLKtPLsOitNq/UPfAKbfjluRckD/49Q0XYfHdZNixKSxBkDtM4oorvFqrHjtF43c3waO7voW1pZQfVeyOKM2/vORQZjklvtImMot2uezMNYbE5/kEWitvukbN5uZvSLHoTMsvO58Gy87HDPWPDrot0WP4C4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiJoX6NL3mOcd0LIjmcJXjrF8kSPAghpvN8NRMWgS7w=;
 b=cZSlO34em2nyfvCNVBsSq15iYAhP+Oto85HZYXcePaDUfXx0TSarCA4iQOpoaaKtkePjlxGuoaC4enVSf70pzTmolBtY+njquJe/C3SPCV5txZGyNihpkY4BFNGvTZBQzkU+LcnD9noAhLKz4yBsCykJfsi4o3uXlG9XgGmXORZL/G8heeUUx9Xtm3QDfUmDwUS0pRJ7rKcxp5k4UkxtKRvEJ5TbCNhS5X3rzbOPV1IO6YfFf1ojayQXxLW3VHrZ/1T/ZFZ1dwYLO+MG36VpihWsfOx5T2DY9le5HD80c94obUjg0ZI+3qFAs/C/gOiPx9vmBdRa/FMgVwEYh7DfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiJoX6NL3mOcd0LIjmcJXjrF8kSPAghpvN8NRMWgS7w=;
 b=VYpDNBsGguS2xs3Fq7lXppNsX54apP2P2O0rCO7IFtOD03rdg/I75+bpY9Bh7e7qMX3DrQrwTq/RWObQS4WPLptT0NR90rYx0Qoqq/odtO/orDNTIO8npZYA/pFC2gtZ7OjY13sBZv1iBxA+YLdR1jW8uNz6glwdM5uCsz6YkcB2dgYrB0xhvilkaRt3QoB8O02vJVelyNm0cfjqarJ3ldsMjC9ecxJghU7FYsmXnNe4DrBiBJ1c+Vh9cRYHruUphReNMUUvJHvoxMBUQFIwovon97XBD3mI0Ez/TEYf9O7OjcEKWDJAzqoDHS6sbHG1bICa9dz2BKru1Cj/mgjrHQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:02:21 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:02:21 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux regulator
 for PCIe M.2 connector
Thread-Topic: [PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux
 regulator for PCIe M.2 connector
Thread-Index: AQHcRLhYGmftLOEhIEKMmNbSOmnHM7TtMoOAgAACxmA=
Date: Tue, 11 Nov 2025 08:02:20 +0000
Message-ID:
 <AS8PR04MB88332E188669CAA95CC89AEC8CCFA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
 <20251024073152.902735-2-hongxing.zhu@nxp.com> <aRLnoXX54oG6erhW@dragon>
In-Reply-To: <aRLnoXX54oG6erhW@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AM9PR04MB8485:EE_
x-ms-office365-filtering-correlation-id: 6473503e-9ba2-486a-9d6d-08de20f8a43c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cG8wVnNNMGljb1N0QkRld3d5QWM1OCtvdVh1dGhIWmtKVXllZVZmekZvOEIz?=
 =?utf-8?B?T0o5WTFLdEN4NnA5NENtM0lVV2pkV2R4N2tnZzI1NTlQekMzNDZNeEVaOFVE?=
 =?utf-8?B?bUY1QTVMQU5hVzUwMDhxei84ZEdSS0tzWU9uQk9lbHZDU2lidGFPcHU3WFR6?=
 =?utf-8?B?RGNpNXlMdW1LL2NPNFpGZEVHOEtDdHpMU2U4UVlyYTRrOHY2SmtpeTZKQkxR?=
 =?utf-8?B?RGhVNnBkaU1DQklQSmp6Y0FvK2EvYzIxd2EvNkJHSHdEZm54V3R5UkFRRm9H?=
 =?utf-8?B?Y2pZT20vWUV1dVVFZlpMUEFIRDZrUUs0VldlNTF5T281Y0ZkVUdPSDRjWmg1?=
 =?utf-8?B?a1c2T2ptWHpUYzI5eUttWHowaTltSHZXODlqcmUxL0FhZWJ1c21mWGtPMEc4?=
 =?utf-8?B?cmc5NklKUTQ0eGZ0bSs5MFZxOUFXNUFCRklWcVBWRmdNVkgzeStEckdQT0Ey?=
 =?utf-8?B?VkJnd1VWTGtTV0NQWFhQckh6UDFWdS9iOU1HZmtjT2dLODBKOGxaMWtaelU3?=
 =?utf-8?B?M0I0U0VSL0tqTVZ3R2F3MnpETHFMdVVXTnBjYTh5ZldsNWRya3JaK1BSTk9m?=
 =?utf-8?B?aVFNZU1VT28rYW5pYzM2REh6TXVOT3J1UVJWb2ZsU0ZKVktpM1o3WXhYZ2tq?=
 =?utf-8?B?ZWxhd1V0cFFxTVkrNExFTks1clFMWW16WkhVazUyMFF1RFBkYVAyWWVJTWtJ?=
 =?utf-8?B?NmZRU1krd2E4ZFhtU0h2aXI3eDEyRTQxWnN2K3NmL0ZISjN3Z1lGcEpOK0lQ?=
 =?utf-8?B?NGZBSUNZajRtUTJiakdmTXZEL0JCVmlaY3BJNHAwVm8vUC9mRlBsM0thYlo2?=
 =?utf-8?B?TmlSL0lZbURKeW9reS9NK2pnaGpDc3FtaDNqOWVRajBPK3lVWVZvUXlvdUVP?=
 =?utf-8?B?K2ExWDdqenpENFJwVUVBK0FlZDJCKzFLWW5zTkU3RS9XalBsMnNTd3RpTmpW?=
 =?utf-8?B?Ti9VVzdsYXZHYXArZThpeVhsZkNxc09BWWwvSzhxYzhIWlZGSWZValk2eTJB?=
 =?utf-8?B?M2lxbVUxMDgvbjZJZWxHTnc0Z0syM2pOUWRVQVJPSHBSemVUc3RpNjJmSlgw?=
 =?utf-8?B?eE0yVUl1VUxUQi9zeHhMUkVncWgvKzd6aXA4NlJvazgzZjNUNEtIZU02Uk1w?=
 =?utf-8?B?QnhxeG4vMFZHYzJjNVFtSDAySTRLeTlzSy94dmM0WjhYYmluVjhzbGUwQmlT?=
 =?utf-8?B?V0VSM0lHejhLaVVITHA4SGJ4QmdKQkpNeXJDSVR5dGZMWjlDTCthMSsrVXZk?=
 =?utf-8?B?VHBBZm1aV094Y043dXpmVC9kazBxSnNFeTA2U3F2bzFRUkxwUGlES29GSE40?=
 =?utf-8?B?N0s4b0tRckF4T0M2WFk5SHJUbHg4OURyWjFHY25LLzY1Z0N3MDU0em9IWDRa?=
 =?utf-8?B?N3VzYVZZNEsyaW5RQkN3TFhna2o0T21hVWdVdWNMdEJtKzlsN1g2WmJFSEhY?=
 =?utf-8?B?N1hoNVJRanozVTdnY2t5bWJmWHRPV0FObWpOOFgxSzFqZi9QaUxuMUZBaUVt?=
 =?utf-8?B?L2pGYnhDbzNHTTBSQlF6Tk04TmxZU3l5YmFYZm9ZNGFFVEpoMkM4disxbjhv?=
 =?utf-8?B?SzhSMW9wVTcxWDgvVHFmRnZYZnJDTTl6cWZ5cExiYjlhNCtzUkF5UmtvVHhY?=
 =?utf-8?B?U2JpSFZPdkRkS3ExS0s1am96QmVmSmRwdWNGbDU1R0xKZUhrcG9vVkkyczAz?=
 =?utf-8?B?MEhaSlJBRjNZRTRXeFZIQnVpaEJqTFdaL1dWRG54SUhCNGNUZDJnOEsyd2dD?=
 =?utf-8?B?ODJlZGtmZTdybmIxWmN0Q0JwbHFRT2VVMDhmK3JFclVnODF4clJUYmhwMi8w?=
 =?utf-8?B?NlczcHh3Z0JGUDRpR3ErTnkrU0NkblBsRW5Wb0E2UlZJNmNHL3dGa2l1N2dE?=
 =?utf-8?B?T2c1c1RTWjJFcGswbk9lZXk5blhLS1NOTzhnSStiWjJ0cWtUU215VFUvMnBG?=
 =?utf-8?B?R3dmb3FPaStwUzNQQkR4QlNnWkNmb2lTM2pnd1g2RVh2c1ZaL2dvcUpZY2Nu?=
 =?utf-8?B?ZENOSERCZHlOWGRJK0t5MG1rRFpjczV3OEdzWVE2QytoeUpjVGR2NkU0cVFm?=
 =?utf-8?Q?rbOK3r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEFNVkpXUlZLTnBzVFowOGRLeTVTbWNBOER5cldabDlwVThFblNObFo5NzVM?=
 =?utf-8?B?Z2tUNHZnWkVrRjFMYzEwM1VydFZTQzdZaTE3c2tiTHRRNUtFVUFWNkJoK1d6?=
 =?utf-8?B?T25vTklGMFlYNVdJWXBXckdnaFQ2MTFqTlZ6ZXZuc3J5V0pmWkFlQk05YnI5?=
 =?utf-8?B?d1VyaFdhcDIxNHN4M1ovQzE4akxtcUg5dDRsd2cxTjJDZ3ZxYmlmT2tocTcz?=
 =?utf-8?B?dDNjZkZSTURuOXJVS1VyNFRYVWVvdktzbGc0Wi9oVjZOaHM2NTJDd0VHaWUz?=
 =?utf-8?B?eElxSTIzU3EvTHEvVjRSVUQrY0xhczQ1ZU9tNXRTb3JleHVneFlJeEVOREx4?=
 =?utf-8?B?UzhlQWkvMkM2aTMrdHFkeEl3QjlvNjdrM1h0bG5XOGRLeVRJMWM2Q3p4RG5B?=
 =?utf-8?B?dy96Q3p0UHQ1aEhsYXBMc0cyRGc0dTllMDlkWGRrWGM4bnlFcm9TZ0t4Y1pz?=
 =?utf-8?B?TDJjUFZGZ2pkRlkrSlp0TDFSVHFvYXpTTm8yREFHdnhhWHdaVG9vbTBDNUxH?=
 =?utf-8?B?ZVZLVTB5SlQrOHN3LzR5My9FaXJUbkJJZlNOQ3ZHMnhzV2wvUnQ2cnhSbVho?=
 =?utf-8?B?ZStjakZhbFlSYTlaOG0ycWhWNWxTSmJzUlIyRE1SS3VjMkRmbmwvZGJWYWxT?=
 =?utf-8?B?WlExT0NMZEVtZGdQcjlybDRyZFJ2WFJ5RHEvbmJCdC9aaHRZbDhkcElzZVJt?=
 =?utf-8?B?ZTJqcU1OT01sMU9HUGtBcElOUWJTMXZ0dU1NTEI5NzBzL0xFN0RkYTh6ODM5?=
 =?utf-8?B?SGtaU3ZxQkF2WHBQTnU2RXlUWVFKb05ScmZac0tiZTBMd3pzVzRVanZFS0t1?=
 =?utf-8?B?QTBYRFB0WSsvNWRwTG9ac0ZXMzk3RGlwY3N5N0xpTFcwSUtVaGI4OEI2MVp5?=
 =?utf-8?B?cEV0aS9vcEw5UU8wZ01FK2s2M3ZxVlRaVmgwTlNZRWV4T2puOHByZHF5WXhS?=
 =?utf-8?B?VG0wZ29jZXgzV3JuSU5WN0FpZlRzbXFMazdWSUVsV042anVuVjdMc3Nub1lY?=
 =?utf-8?B?RkxpVzRGemg3MXU2S2t1dmE1bWRQaUcxcVErTFpvSjFmMk5SY2M3VGVjbEdz?=
 =?utf-8?B?cHlTWUZ0MkN0L01GVXJrandyRXE3WnlPUktGTzlSU1hvaFZpamdHbVAxSjV0?=
 =?utf-8?B?UGdkZVdqK1g1WmpaRnFGZG1JMmE5Q0M1Y2p0aElMWFB1bUo3Q29BMkNSRDVX?=
 =?utf-8?B?UHhHdzArMHgvZTUvWnZJL1hQb21KUlFqTDk0eXQvT0FRbWVOdWpvdVY3dDc2?=
 =?utf-8?B?a2FZdnZybHk0NlA4UEFvOHlTL1ZLWDhjOTFUdjhxaWFqNXNNRzNYWHlpSmN2?=
 =?utf-8?B?RlVsUUVtbEJJMjFtTUZTMmJWalJnS0J0ZkpmelZXdHlLcFJuUG5idlkvZEx2?=
 =?utf-8?B?VVZycFdMMEp1UXpkbllyVUFFbjVGWWZ2WUovRGtrbDJTMENiczZYQ3phY2pJ?=
 =?utf-8?B?amh1dnpxRU14WmtBbUZ6NWlUL01WTE02S294ZW5vOUxpT0JzdmlQc3ZITGRV?=
 =?utf-8?B?MEhmakNNYThkdnpwUVdPMXBNbjJMa3czNnVXb09hSENQMVpQbzNwdzJlQm8r?=
 =?utf-8?B?R0VaZkNramxGV0ZCRGhkWVdKVTdMRTdyTzRYaS9kNDBQWktxMWVMNmFTejRW?=
 =?utf-8?B?ZEZTazZZNXNNa3UrZHRERVFhMFRTSjhqK0N3ek5Qd2g4cHFlbHdzbDFBQXJK?=
 =?utf-8?B?M0w2U3E5LzVicUgvRWtGUjFFMW5Gb3AydXY2NGNQTXRGNm44d3JyMUwxZ1Uw?=
 =?utf-8?B?SmhFVGg3Z2RDVkdBOGJDNC8yOEJheW0rUkJQUFRQWFNLVThUVkdwdlhsSWtW?=
 =?utf-8?B?eGZwWWIxa0pBdHNRSDJPMjBOZTNSNWVHdkh2MkFqczI3QjZpWk9ROVdPZ2JK?=
 =?utf-8?B?dW1YZVYzRnArRFpPNHhxK1ZFU2h2WEZJbnZlQmlNUm84bFVrZUF3RmRNMUtP?=
 =?utf-8?B?MVVkTnhTS2UrVWZubjBCWXIxbDYvMzQ2b2orUEd3UG9raVROMnIrNlVEZlA2?=
 =?utf-8?B?ZVpWOEdKUWQ1Ti9LMVJKNFMxMWFFRGRCeXlPRjltbjh0M1FhZUxUWEt6WTF1?=
 =?utf-8?B?WHVpUmN2L1Q3aUJ1ZFRvK250a0RoQnJPVnVwTE01MmxRMWt6emE2VGd4MElN?=
 =?utf-8?Q?7FvvvCqP0JZ2E/8YdWL+ashNl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6473503e-9ba2-486a-9d6d-08de20f8a43c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 08:02:21.1754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wo5Io+Fub/rEh6CXw7wx2/qKBE+1P2eN5Bms3anxDK+YyEhn4HO48lC872Pf9/KHLFEK3kY0mdQoLLuNTIhzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
MkB5ZWFoLm5ldD4NCj4gU2VudDogMjAyNeW5tDEx5pyIMTHml6UgMTU6MzcNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IGty
emsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVs
Lm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvN10gYXJtNjQ6IGR0czogaW14OGR4bC1ldms6IEFk
ZCB2cGNpZTN2M2F1eA0KPiByZWd1bGF0b3IgZm9yIFBDSWUgTS4yIGNvbm5lY3Rvcg0KPiANCj4g
T24gRnJpLCBPY3QgMjQsIDIwMjUgYXQgMDM6MzE6NDZQTSArMDgwMCwgUmljaGFyZCBaaHUgd3Jv
dGU6DQo+ID4gUmVmZXIgdG8gUENJIEV4cHJlc3MgTS4yIFNwZWNpZmljYXRpb24gcjUuMSBzZWMz
LjEuMSBQb3dlciBTb3VyY2VzIGFuZA0KPiA+IEdyb3VuZHMuDQo+ID4NCj4gPiBQQ0kgRXhwcmVz
cyBNLjIgU29ja2V0IDEgdXRpbGl6ZXMgYSAzLjMgViBwb3dlciBzb3VyY2UuIFRoZSB2b2x0YWdl
DQo+ID4gc291cmNlLCAzLjMgViwgaXMgZXhwZWN0ZWQgdG8gYmUgYXZhaWxhYmxlIGR1cmluZyB0
aGUgc3lzdGVt4oCZcw0KPiA+IHN0YW5kLWJ5L3N1c3BlbmQgc3RhdGUgdG8gc3VwcG9ydCB3YWtl
IGV2ZW50IHByb2Nlc3Npbmcgb24gdGhlDQo+ID4gY29tbXVuaWNhdGlvbnMgY2FyZC4NCj4gPg0K
PiA+IEFkZCB2cGNpZTN2M2F1eCByZWd1bGF0b3IgdG8gbGV0IHRoaXMgMy4zIFYgcG93ZXIgc291
cmNlIGFsd2F5cyBvbiBmb3INCj4gPiBQQ0llIE0uMiBLZXkgRSBjb25uZWN0b3Igb24gaS5NWDhE
WEwgRVZLIGJvYXJkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4ZHhsLWV2ay5kdHMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OGR4bC1ldmsuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4ZHhsLWV2ay5kdHMNCj4gPiBpbmRleCAyNWE3N2NhYzZmMGI1Li43NzA0ZGJhOWUzN2MwIDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhkeGwtZXZr
LmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhkeGwtZXZr
LmR0cw0KPiA+IEBAIC02NDksNiArNjQ5LDcgQEAgJnBjaWUwIHsNCj4gPiAgCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+ID4gIAlyZXNldC1ncGlvID0gPCZsc2lvX2dwaW80IDAgR1BJT19B
Q1RJVkVfTE9XPjsNCj4gPiAgCXZwY2llLXN1cHBseSA9IDwmcmVnX3BjaWViPjsNCj4gPiArCXZw
Y2llM3YzYXV4LXN1cHBseSA9IDwmcmVnX3BjaWViPjsNCj4gDQo+IElzIGl0IGEgZG9jdW1lbnRl
ZCBiaW5kaW5nPw0KWWVzLCBpdCBpcy4gUGxlYXNlIHJlZmVyIHRvIHdoYXQncyBSb2Igc2FpZCBi
ZWxvdy4NCg0KIg0KSXQgaXMgc3RhbmRhcmQgYmVjYXVzZSBQQ0llIHNwZWMgZGVmaW5lcyB0aGVt
LiBwY2ktYnVzLWNvbW1vbi55YW1sIGFscmVhZHkgZGVmaW5lcyB0aGVzZToNCg0KICB2cGNpZTEy
di1zdXBwbHk6DQogICAgZGVzY3JpcHRpb246IDEydiByZWd1bGF0b3IgcGhhbmRsZSBmb3IgdGhl
IHNsb3QNCg0KICB2cGNpZTN2My1zdXBwbHk6DQogICAgZGVzY3JpcHRpb246IDMuM3YgcmVndWxh
dG9yIHBoYW5kbGUgZm9yIHRoZSBzbG90DQoNCiAgdnBjaWUzdjNhdXgtc3VwcGx5Og0KICAgIGRl
c2NyaXB0aW9uOiAzLjN2IEFVWCByZWd1bGF0b3IgcGhhbmRsZSBmb3IgdGhlIHNsb3QNCg0KTm90
ZSB0aGF0IHRoZXNlIHNob3VsZCByZWFsbHkgYmUgZGVmaW5lZCBpbiB0aGUgcm9vdCBwb3J0IG5v
ZGUgcmF0aGVyIHRoYW4gdGhlIGhvc3QgYnJpZGdlIG5vZGUuIFdlJ3ZlIGRvbmUgdGhlIGxhdHRl
ciBiZWNhdXNlIHRoZSBSUCBub2RlIGlzIG9mdGVuIG5vdCBkZWZpbmVkLg0KDQpSb2INCiINCg0K
QmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gU2hhd24NCj4gDQo+ID4gIAlzdGF0dXMg
PSAib2theSI7DQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQoNCg==

