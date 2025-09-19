Return-Path: <linux-kernel+bounces-825220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F536B8B4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD49C560B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9790A2D0617;
	Fri, 19 Sep 2025 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aoceelFq";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ArlOtUnW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Hcgxksyp"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1E35942;
	Fri, 19 Sep 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316656; cv=fail; b=gN7KJCxrI53RZn1c9M2Yg+NRP6hFv2La2D595f9WrcNy5Ix00cwgu3rld3T2LKccYAkRxmrAuvwGhpuY2JCkuVnjuxSbCnF5OnXVilZ1szUNrT7qzz/EcWCpQDN1o5WV9W7MZPjCAzOByegLQyEEO5i8KN3DC4pOuafR+ihZTZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316656; c=relaxed/simple;
	bh=XimCmywt4Jor4p9fcAOl7I5n1NcXtepIYxFJmDGEpng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kXcw4GlqPVtFBd+bvkXUUMRa2yc3xN9fVY1rpOouuFHS1aHoRmBp9UAM9po2Kon8PY5euobiMQ5A+g7FYPS1y0rLFemMpVcHcn0H8lGermIGzOpAu6PclLeCds4UxyrKQ3u0ljyh8L78xDUFRKngKjBj1b3ov8dr9OD2JJrw7+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aoceelFq; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ArlOtUnW; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Hcgxksyp reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JJl3Xe005279;
	Fri, 19 Sep 2025 14:17:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=XimCmywt4Jor4p9fcAOl7I5n1NcXtepIYxFJmDGEpng=; b=
	aoceelFqQGaYs1QjDVi0SPCiVHheLddDSRCwb2FDNiaTSIn3Z19cIC19IZgJP1Aa
	vj0xN/dR8xYLypTTKCZbkWkkP9qCxhPPIiQMF8VcJvGVTUN6E+L7dVn1vvq7BbH+
	QaW/jaf0JPBblZTxlsh81vEoDzPNWI2ZcDy357C8nmUGM1qU//n11mhyW2IPGyH3
	5SqiYNX9ohLVQU2wlNn255ls0JtWF6dezzCqqpTLLxM5afuD5eVutnLSnoMkcqCJ
	OlwdLskZV/iRrOwlqegwT36SnfamFOoa9mXeLdZCtfAzrAoIo0B3nbWSaJUY24rm
	9e6tzdsMv7j/1tg+wGcZHA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 497fxrab84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758316633; bh=XimCmywt4Jor4p9fcAOl7I5n1NcXtepIYxFJmDGEpng=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ArlOtUnW9K5jryaGX6U3jspwLvXFZ/FpNWro/xfW8bKEBwErPDb7MXt+DuQiimUiQ
	 YUH5glnmmTOhSoRED9OyLhKikpqEV9+eu6ZhXp+5PmquYr+13cSQECed68nLkehyhj
	 0JFCZNouBldK2O74boMU1OlSFtdB3JXV/Cszv0SjgYBBcPkGP1dBr4kYHofaofcMGu
	 qqrivw2EL+F4+o0o22FeP18jlcdWLE7+I4zp24sSXFPcUI2hD713sFX7vy9M1kvF/p
	 BUSwsJZfXBTkKZgnX7m9E1jsKLAMBfAPpQjguP2ctpNRSoIv6hsTuV8ofhSlx5GzSC
	 mG0OC+BPehQMg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C5C7640343;
	Fri, 19 Sep 2025 21:17:11 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 84D2BA01D9;
	Fri, 19 Sep 2025 21:17:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Hcgxksyp;
	dkim-atps=neutral
Received: from BN1PR07CU003.outbound.protection.outlook.com (mail-bn1pr07cu00301.outbound.protection.outlook.com [40.93.12.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A15724013B;
	Fri, 19 Sep 2025 21:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVnm+bt4cuFVHI8pXpjuKho8iMoQcxJHobkntJt71QlnjEfViMuYGVNyotmDDg9pho/r0cA8WslkCTJgoxedY1C5RlIpN5uGjbbxU0DGh347SmhUl64GvwKCQJaKxq7hG6xNy9ysT41lqiT+xIFnqKWArK1fD8ubkpaFuAW2SBDdPK1jY5ocdosstbcs6I09Ji4JpZBs/e9G6xrz+00aChJNKo6Z1/6XPMQDw72bbHoLvlWFzI+QW6fAMOOa7sKxhVM2wRfmj/yyXP9bGkH+J+WljN6U/xKgD81CgX3DnypaMosUVHU+DUToMW+oMqNkvGZuQ/Z3BPNG3W2ggKM1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XimCmywt4Jor4p9fcAOl7I5n1NcXtepIYxFJmDGEpng=;
 b=WReODesw2f3Alu8hMFncbc2HnaVGURMyz+ltVJmcYJ5UyjMUQcNrD0i4dyvOz1g29D3amBWzO222OyXrHR8rhdrDphRh3C4+BLtpNt9hz/virvikrKcZXJXEu3yiEB+lJKDS7ipJzL/i0SiAhuwPjdwcyB/qOf0mPL0AcAXEAK6od25s5NNmAIr6DGAD4g0G3KeWR/zi+mO50rz1FBInmA/3ztuQd1Zw30oAZID7ywMTUnehuBvfo55nEQEuDW89F1iP40NvPvcuYwhhwvsZnauxUV0xL10LEHpE6aYjaMe66/fzeC9F5YL7xr/KEe5u4bzeljkN90TXc5B+52TQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XimCmywt4Jor4p9fcAOl7I5n1NcXtepIYxFJmDGEpng=;
 b=HcgxksypW2e4JmRfnjfSy1ptHNtQAaSQypVxurI/lfrJZVrRw8PU8wCfM3Fs/6tYmHC/TrWuClw+DyFIUMXUKlvEsDjjAneYS0p2jT8c7T/qgaiM8ndWZAOApmJHgbxrtQqACtSs7DZr1MQXos16OnH+DXy3M9mdgKaWiYqhpOo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 21:17:04 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Fri, 19 Sep 2025
 21:17:04 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.li@nxp.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] usb: dwc3: add layerscape dwc3 support
Thread-Topic: [PATCH 2/3] usb: dwc3: add layerscape dwc3 support
Thread-Index: AQHb1AnlUE7hkiv/E0uGFrAejSyRRLPwpAGAgADkEoCAqiVWgA==
Date: Fri, 19 Sep 2025 21:17:04 +0000
Message-ID: <20250919211703.gbaqcc6mhtgolomt@synopsys.com>
References: <20250602-ls_dma_coherence-v1-0-c67484d6ab64@nxp.com>
 <20250602-ls_dma_coherence-v1-2-c67484d6ab64@nxp.com>
 <20250603012259.gyat6ungxyufhhbe@synopsys.com>
 <aD8NxfmJjSMeQKOu@lizhi-Precision-Tower-5810>
In-Reply-To: <aD8NxfmJjSMeQKOu@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY3PR12MB9677:EE_
x-ms-office365-filtering-correlation-id: 0716f3d7-95a5-4c04-bd35-08ddf7c1e1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0pUbjQzVWh6UzFoUVFGYUhROE9xQUQ5anpZdVJNN3h1V1JKQmhwUjF1TkIr?=
 =?utf-8?B?elV6U3Y4VVlkMTVQLysxQ0JUcURhbDFyWHpaeGVBMDErRFZ5cjZEMks4WVVR?=
 =?utf-8?B?UXN2K2FOYmsxeFE1VFRrT2Q4bkZnS0syemR2ZUgyc3FtSVBET3dSd1ExRWhM?=
 =?utf-8?B?eWZRbmRMcjcwdW5nc3dtckdwOGRhMC9hbFhVcmZBd05kSlVvNGpWVVRmdit0?=
 =?utf-8?B?Y0g1TFJTaTYwa0dhWm45VkZWVDhRa01jaStsMUVuZWlhaUNjZDVuZTBncTIz?=
 =?utf-8?B?QUJUa0k5cmNudE1UcXB4SmNLeThmcVNXUEVCZFRoZXBBcldWNUkvR1lKN1lp?=
 =?utf-8?B?TzVIaFp4a0xKOHUyZ3lIbStKNWlMTlhVTUFpRTUzTjN6ZVFtd2RQc2kxbkls?=
 =?utf-8?B?eEowSGVYc2UvdEp4SDFsV1podUI3N0NnbWw0WUtCQ2E3eHlTbWdUWjVkemE4?=
 =?utf-8?B?N3pwU2tDSEtjUUxZN0p0NkVCQjdxZzJnSXZJQk8vWFJ5ZFRLbW84c1FvSzRV?=
 =?utf-8?B?UUtpQjQ5L3YrU2NmSWJpSmE2TTlOQlhmUzRvdTYrU3c5NVZoQmllWlgzL3lG?=
 =?utf-8?B?MzdKREN5ME10c3dQQ2h3bFUxK2ZBZlZudWFHSXFra0VtM2kzanBCTFJFSWFW?=
 =?utf-8?B?VFNUSXo3Q1cyUk5lM1k5bTJqNUpuNWhxSFpURkoyNk0zYkduVjY5YXMxR3pj?=
 =?utf-8?B?ZkNsSTAxZS94WVdLM2tacWVxSTNJSjl6WTlvQlVucEpXTmpCSGI0S0pnV3h0?=
 =?utf-8?B?eXNnU1ZWTW0yM1dGMnRiQnBheGhPSWxUNWFsbHRwUVQzdTBPVk1yR01Cc2lX?=
 =?utf-8?B?ZVViSS9YVHZzeGxPM0JWL2w1QnRPSW1nQmNrY1Y2d0wvUUpUQjFHU2dzbDBi?=
 =?utf-8?B?KzdZTjZBN3ZEa0JTcUROOW1uYUtjaFRIaEJmZ2sxWWkxeFlDd2dnQTJqd2Ey?=
 =?utf-8?B?c2dhVU9LVzBpVWNiRURod0JNZ1VHTXA3cUhXS01YRDdhM3dvWlRtdzNHZGdp?=
 =?utf-8?B?WHBRVzZoTFVxQUpJcWNWNVZpOG1memd3ZGI0eWtkREtmdFErOWtPVEo2Q1E5?=
 =?utf-8?B?RlVzdUR1YlBNYnNSb1M3cXdvNm84U0lLdEFNQ3FXS0hHVFhieGo1dTdhR2cx?=
 =?utf-8?B?Ti9qcFl0aHZ6WFc4TFVOVkpDbXBZbUxack4zSy9mUDl2MWFNcmUxazVyM1NP?=
 =?utf-8?B?eXdxR08wemVVTVgwM2YzWHY2dXJYQ0gvMDRJK1g0aUdEazl2clR0UWt3TG5h?=
 =?utf-8?B?K0I1UDlROXJxT0pvT214TFBCQmVVSmEvbW9MUFZRdHFVZWc0L0NzY1ZoNDds?=
 =?utf-8?B?SzRJdHJkSHFJelZuZkFNa0YxL0lwVEJ4T2Z1Wjg5aW5RZTNDeHRmUE0ydnN4?=
 =?utf-8?B?ZGZSNkQrTHpDRmdhS2wzR3JCbUZhQzAwWGFmQ3k2eWFVVUJER3pBcCtqSmov?=
 =?utf-8?B?UFBKc3lUNVJMWTZ5Qy9BVmxwWU5IejVES2I2N0tiTU9YeU9HQzJpQldNNmdm?=
 =?utf-8?B?dDVvV0Z6U29tZFBIbjV1TnJWVlZ2UjJTSVBIb0dxTWVtRmpzaHB0UlgxSnZL?=
 =?utf-8?B?eFoyOW4xMTNPTmpRaDBZSVBIREFoZXRyWXUwUEhhSFFOYi9nRklGV0tBLzI5?=
 =?utf-8?B?K1BOM3o0TkQxMmRSUGYwN2xtanY4cFBSZXd3YWIwQmhOekg4bUpBMTByaFFm?=
 =?utf-8?B?cUZnV21TTFVVQ3VuMFNFL2V5elRQL2FIcVJTU1k0Vkk1Sks2RGtGOFNsR2gr?=
 =?utf-8?B?eHJZVGVVUHpNUlgxdG10NHltdUtjcWRJRHRXU1EySXlPK3NnZUc4ZlFDVEh4?=
 =?utf-8?B?cjBvNS9lM0NVQzltMnI4UzhPRVFqTStpdENKcUp1WnJhdmdOVWQ0WkIxcGk1?=
 =?utf-8?B?bFFFYWhPYnFaQXBWendOank1RG5za1NuWTRLeTM1dXNFWk52REdOaGFrWlA2?=
 =?utf-8?B?UTkzaERDL013VnlkVHpnUEpqMldOY0ExNGpMN2xvSjNxbjJDbkhsNktleENE?=
 =?utf-8?Q?raAChZ1CboJaBaufL/qSsLpugnCKnE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkhpM3gwNUkyb2lNRjlGVFVTTDNKT0xwMWRJNGJtay9uUndYY1dMOVFrYjIy?=
 =?utf-8?B?WnlObVk2K0Q3cFAydS9HNzRmb2ZBaHRyTS9OMTZYM1Z1a0JPa0pYckxKelJR?=
 =?utf-8?B?eW9DMjhISEhWc3NDbnVCbGdHNnpYZ3J5WFRVaGs4ZzRFbHREdUQ3RzZ5VGZ6?=
 =?utf-8?B?dExkc2xZZ3lKeTFTdXNjU0dnamEwMmJWc0FaeDRud2hrL2R3U2lQWDF2N2NQ?=
 =?utf-8?B?ZGhKNkgrMUNGL2l2MGpacS9XZEh0a2JueEpSUnVmcTNCS0lDZHp4NUpDSXhN?=
 =?utf-8?B?YnJxb1hXV0ZqcHlXejRmWHBLbThQY1RNR3o1SVlTcHV1RUt3ZlBvYWQvbFVL?=
 =?utf-8?B?VXF0Y2swZXJDUDhmUUhNK3JwREFsT2ljOGU5Y1d5NnR3SnlWVlh3SWJMQnJU?=
 =?utf-8?B?cmZ0aGFXbDNmaXNYZHlrQ3hKR3QrbHliTE1MQkZpSFVpZ2xETU4vcU9hUUdU?=
 =?utf-8?B?bnRIWlA2dXR4VnlnQzFSNk5ZYndLZXI5S2syUENpQWZ1b0gxOXhMRUpKNkFm?=
 =?utf-8?B?em9Qb2lnK242RkpBa1V3THFuM2JIYW1QaHNqWG9JV2hVTTZDMlhmbVI0c1JX?=
 =?utf-8?B?LzdUa2RDNmk1MFlEcHJURmRma1h2a2V2TStHUWpsWnc1OFZtUDFoKzNJNHVW?=
 =?utf-8?B?VnFXcVNOc1dXWUlrOVNMaDkzSERmcElIYzR4SllaaEpzOUp2T2ZMUmRhaHMw?=
 =?utf-8?B?S2JJclNka2tEelQxYitSQkw3Nm91bkFnT3BRbUJWK2lOZUtZaERGdTF5eHhm?=
 =?utf-8?B?Z3M3ak9PeEtHY0tCWGJGdGZZalRMV2R4Tzk2cVAzQkxpVHNJcVFmVlFIdjdz?=
 =?utf-8?B?c2xySFYvN1pmZkJZUlhHckVMNUNibkVKblltNTE4aXNsZzR6OHh5WXJTSzVY?=
 =?utf-8?B?UkZGc0VFWTNSaStVUWF4YUpoTFB6Q0JjQ3N3d05laURJNWZTVFAwME80aFRk?=
 =?utf-8?B?d2pKRG1INGZudTJBSkxxKzNHdWh6a0RJemhtVnZzQ0tRUTF5UjVQbEJRMUlO?=
 =?utf-8?B?eEgyMGZtTGlRTmRjVGVkcmduTm5CTnkwRzRJODI4b2NCK3V4Vk4xeEJqMGdr?=
 =?utf-8?B?TFoyNHAzTnU1d3p0VUI2TGRadVZKYmsvR2VOYllKL1pjcHBHb0FrbGVOaVdn?=
 =?utf-8?B?TCtUZTYvbTh5K0VHMWxCSjRZU3B6YVdLellsYkZDK0pzd0plOHBtUmxaMHA2?=
 =?utf-8?B?clEycmdYcklmWDNDcEUvUElEZmIxeWNkTEh4ZnE2WnJraE1FNVlHbXIzSzVK?=
 =?utf-8?B?dGpzQjlKQndUQSsxc2FGd1Q3QzlsQUxMd2twaVN4UjBNL3IrUHE1S2ZZb21u?=
 =?utf-8?B?QWtqVWlXUGpudjdzQVN4RExYYzRxNS9wU09Kc0s2WDY2eWg4T3FjRVNSbW42?=
 =?utf-8?B?VTBLMXUyLzVOL2V3VVE2Mm5jNDEybXVCQXhkS1JhdDFscW13MWttaFM4Zisx?=
 =?utf-8?B?QzRTYzFKdFZObTE1NDhpUFRRR1F1L0toamRlT1cxL3dUa2VtK3BPMUVtT0RR?=
 =?utf-8?B?Q1FGTHJndER0V0RrUkhHWUtBN1pSd1lHZWpFSHhjcnA3bTU4QWp5V1hqZUE2?=
 =?utf-8?B?MUljaWF4VlYvcXFENlpEWTFKTEFYcGM3QzNHSk1lNkNFUzdyQkY3REdBSG9W?=
 =?utf-8?B?UXZxUW1KSUtLRno3bDFOMXc1SFpnMlFDelhEZ1dzMTRCV2tKU1NJYXl1L3R0?=
 =?utf-8?B?M2x2d1hXQWVmVFdsMTBpSUdQUmtSb1VUZ0VGTm1nS3FoQlBZb3JkcXVONnZs?=
 =?utf-8?B?Q25iWFhlSm8zNVRxNkRaY2lKSHZCd2t5MndQeU4zNjV6NmlKZWZqR0RkQVVh?=
 =?utf-8?B?SFMydVhTU1ZLRWc0M3FlejVOT3VFeDBrVUdrUFJWdUhodFU3MmxoVzhHalZ2?=
 =?utf-8?B?ZGNRb2Z3K0w4WE0xby9oYkVaZWN6ZzVXam82UEdiTFdianE0bnM1NFZoSW1k?=
 =?utf-8?B?aVpKbnRqYUE2QlEwWFdmS1pHZkUrOERsRmIrblNUd1BOb1hESjA3YW4zNm1I?=
 =?utf-8?B?c0VTTXdiWFZnbnZnMmxJYnZLQlIrZzNvbGNKVFVhRzU2cjFORnVOZk1yMWpT?=
 =?utf-8?B?K1B0djVueEcydENaU0Q5TXV1ZUlBNjBZTHZuSDRPek5qaEVKVkEvZWhNV3N6?=
 =?utf-8?Q?mVCYbdeC/2cR/KLlbxK1OsE+Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6097C0F225F754DBF97179AD79910D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MWVUaN3ESXzuW15WQDXlJQN9qYf4l2D/NATC7lYbaOiWp3WlhsExuIYjOqaHzebNpQbM5Pn2pFhxD/AL9GSKwDSCY0I6wcIEHEuzhTW36Cy4btgtkSf7k6jl9WK+tANk9HhbGtb5t83bCHR1LEhv/1zhFvcvKP+BU29NDm1Gz11McgjJzGwADx6p+WEQhQ4H0vaOBP81j2qh5DlXA43Q7X3IT46WFjVum4+Himqy6ZPx0ivnotJ8wv/RxLmNitAqRtbyg3MPEH92eKb91Jd0VtX/yFCDJDKWnTRhJi95z9Zp9PWDfmSaUEQ83QArE7vm/ZNZJciMUZDBIz1hUkFc1kTaJiZSo97n8l95cJr5Rtuv6neqGGTnny8OJCLEsZel6unLqFtVF7LxZwawe4QFoc2TdvQj/TvMoCXgSuJ3V4qy5pUz4e7sQBLie5cQEpNzsKNMDUgsM5mObnWUM8/pHbuFs3gyOIhABFfGaP+92IKmrmBbcR+uVM7irkelFV1iRga/4GljfDK8hnGDC5KWVUFYzzx10T0uXMAM9YfdEcrIf0KzHI2eqip4Lj92SASRz1VnhdCNFbu3CJ64l7y3XFI1HRc8ZQQHEhQ1AmcHixftJm8pH36DXyKpV2vKXL7MyOc+hDs80y9SYyUyHVV0zw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0716f3d7-95a5-4c04-bd35-08ddf7c1e1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 21:17:04.3099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+LmZFgkwcuiPUQG809OY5z4aNEinLHdwJ3Es6ux0kysaIc4Mi8AJv1NCFUACboHNpuScDEimYz2+1iyc93q1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
X-Proofpoint-ORIG-GUID: ar12AJtlsh-mPtnZEfQ1uyTtv7YVOkX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0tD5JlTSKIf/
 ydDJTuHXdm0g+2Z2A26QWxcnra7FnF83Xh0QvbWcR6agwLi4tLL+RMKLlCLanrODGTc4qjQr+u7
 Zlgu26yS/MRX52t7GneXc3XACtcNYhgM46fbhNnMnOdN8OMqC2YPJ6vUhKsBIuPOKERwJY3binC
 gGnKraEDerO48werAVgIETwKmSvsuPvs1UA6zg+r8+It2uwFJhn/GaBGBSAiUFvnG+89zT0K1rS
 9C3bPnW89OP2c6KVe0zyvn8FZud6d+x9QXIt9dhY7sWdiz9d80kxM2yfJRve32+PRlKmn0zAnGy
 ZNfRzHvlx8KoCVGLNpVKp/sN+Lu4BaygBKepwO1ctz5KsIdEU61QE+hw/Qu9RaqG2JP5HpYFo98
 AJs08Q+5
X-Authority-Analysis: v=2.4 cv=dZSA3WXe c=1 sm=1 tr=0 ts=68cdc859 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=V1l9cnpSBp1A0dnrW1QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ar12AJtlsh-mPtnZEfQ1uyTtv7YVOkX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

T24gVHVlLCBKdW4gMDMsIDIwMjUsIEZyYW5rIExpIHdyb3RlOg0KPiBPbiBUdWUsIEp1biAwMywg
MjAyNSBhdCAwMToyMzowM0FNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4NCj4gPiBJ
cyB0aGlzIHNvbWV0aGluZyB0aGF0IGNhbiBiZSBlbmhhbmNlZCBpbiBkd2MzLWdlbmVyaWMtcGxh
dCBnbHVlIGZyb20gWmUNCj4gPiBIdWFuZzoNCj4gDQo+IFllcywgSSBjYW4gYmFzZSBvbiBaZWh1
YW5nJ3Mgd29yayB3aXRoIGxpdHRsZSBtb2RpZnkuIFBsZWFzZSBsZXQgbWUga25vdw0KPiB3aGVu
IGhpcyBwYXRjaCBtZXJnZWQuDQo+IA0KDQpHcmVnIHBpY2tlZCB1cCBaZWh1YW5nJ3MgY2hhbmdl
c1sqXSBvbiBoaXMgdXNiLW5leHQgYnJhbmNoLg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9ncmVna2gvdXNiLmdpdC9jb21taXQvP2g9dXNiLW5leHQm
aWQ9ZTBiNmRjMDBjNzAxZTYwMGU2NTU0MTdhYWIxZTEwMGI3M2RlODIxYQ0KDQpUaGFua3MsDQpU
aGluaA==

