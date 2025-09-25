Return-Path: <linux-kernel+bounces-833455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D02BA1FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED527741087
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848142ED84C;
	Thu, 25 Sep 2025 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N2wl37ev";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PU8VPo8I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ga+AHQea"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB578F39;
	Thu, 25 Sep 2025 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758844112; cv=fail; b=GPuR3LCq0GFoZe7YL8eXgelklA9Hzb5eIwaeI01ycN9UTh2ZLx5uP08lKN+joPSsKjnhn1Yf/ULQR9xOtMDTSgEAMuIY7fsvT+ij9iaxmwoAaDf7fkBSa54WocLg07qQTSdOj/WIP/zdx69XTvF9CF302XD1mjbrrEg1/rVB60k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758844112; c=relaxed/simple;
	bh=qFe1cOH98vhnq2q/b0i7dU4QJ1wrlgxCqJhbx6Aba8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VbxRCzcerDr/O6r+20kn9KiYtv9LtY+sckM+fDtu/3u2e2oXSCRDcll+G8DCDIdhwaUyFD7cPRNj5kniqjT0O7f8IZXvnkTtz+nJkGnXyElSKdppTk/lrGoJVGJTEpz229rDxWqiGPBJzX03dXrxGL0Waw6hrmJiQr7pEnMDGlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N2wl37ev; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PU8VPo8I; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ga+AHQea reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPZdd004040;
	Thu, 25 Sep 2025 16:48:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qFe1cOH98vhnq2q/b0i7dU4QJ1wrlgxCqJhbx6Aba8U=; b=
	N2wl37evL7Mj+uAZOsXjTS7HgYa4eoV/qp5XKy+C5RGBbu+YmkrnkWp1G2w24f/q
	QuQd9/vEFIvy+vBk6u4HQG+6RGWNW46QUoIpPvfWUMZByKln0HtFIZ4bOr5+y/DG
	7CsDAMU4iDIXTT5/DBrkWQUyWkSW4d1UHDuFNbN1o5YWh9BVYv/dU014rgx8HA3D
	tnhFfolZGKwmW0vp1QVhvOF2GkZH7XFDMZ9x5uKM+dcHx88VVxe7azNx/5vY033g
	ggWBMYpqK2TKJn95Vwcur+HXzUxoUGJeGKxxGCWQoqXkdmbl130twwzf6nd1v6CB
	/9641v/jXyRA2mYnqLE6yw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49db0n9byw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758844083; bh=qFe1cOH98vhnq2q/b0i7dU4QJ1wrlgxCqJhbx6Aba8U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PU8VPo8ILFQb3QhJesC0YzMe//EOMuQPitQ/Clw1gSWrtKkMc6zBTIxud2q9Xnome
	 hbZqc88dyvOaY9mdHOJCvzvAgFe/YVgs6grraYn90nn/nCRqIQPtS1/tjUaV3Lhz3g
	 1e4PJe4IoyEYKO+qpTScPs84XiqgJ8GR1Gu4s35Kc2FEUF2eIFaKKduiYJbaXkW/wb
	 qMCrgqHB26x4BSRtylUAOzq5FXq7d0nBJgylkTo7GnBIEvvLRr3oCWyXv6nr8TMFsn
	 NRzlAPeD41fv/EjdWUxErpuUPieQ5zgudhMLm29bHYmQ12Zf89wACeiOv04q+Lkzhw
	 hTp5RjMI/S6ng==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A7F91401F5;
	Thu, 25 Sep 2025 23:48:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A9408A00DA;
	Thu, 25 Sep 2025 23:47:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Ga+AHQea;
	dkim-atps=neutral
Received: from CO1PR08CU001.outbound.protection.outlook.com (mail-co1pr08cu00101.outbound.protection.outlook.com [40.93.10.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D3B8840358;
	Thu, 25 Sep 2025 23:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+NZLn3aRasWwTjJ+JNbqCWeKfVhxp66aZzWNnw9bRuyl2J7rDtIYcnYPKolVQlSQ5J59CRkVTr4C+BLyXc25vodCMgG4J10edn+BdJA+lHDt4zDpVr/kk0rEdHBBlgQ3LuiTIDhyqYYwJWhyvx3eeUBiKfXZv0tFmFoYHdZsu76nqWSg7tXC2J+4eYwxDh0peQkfw+LQ52pP6//LW+aBUL0xjNZcB35iX3GFHmXzemBRAE+BzF0/7+ofOm84gSgoalu6qr5uXx5RhxjLTozdVz/N9JrsCgI94TR6xDimtHmAsxDhD3mDg56oYODuS3RRbf1xJfolfuIpsptpKIffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFe1cOH98vhnq2q/b0i7dU4QJ1wrlgxCqJhbx6Aba8U=;
 b=RiTM+gaefaQfHg+GiyzUc7hp83VTdmkQO9Hmm/JOVcMZgX2encRLUELVZvoh0elt6CWMjk163KMQnN0G5lZeEolndwOLXrhb7PWvu9hVoEmUpU4cysykzPzg4iri5glLr17pmgl9SGfK6qpwWjDaLKrLnyxlWkOUocxdBy+jLKC4c372pReVG68gqNErdToWh6eY2QP75EHWD2Llb8oHJJ+8MAN6EFZh368/ULpHTfFxF2pp8XniHQlGl577ys05Ko8sN1+EHAu429hyPat5/G/JayJdcyKhikMZ3JgBj4kOI+J6aTtz9YJewNEwWe/903wUUhRVKsDOZhD+V7L0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFe1cOH98vhnq2q/b0i7dU4QJ1wrlgxCqJhbx6Aba8U=;
 b=Ga+AHQeawi46QMR+i/nxTWMyrffAo+XEbajpRbsfzPkrUW+7/tCufWO50MHBsHryl/ECpsoMDZvfPnWx3DOSaGKKEPHNUj7hG6x2LXTC91QbQ0bOclY4h5+Drp6NJ9poje4vrkpg1NOHsxAlToaAOf6dqNMFdaJA30H3o7sg+/8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 23:47:55 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 23:47:55 +0000
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
        "bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>,
        Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v2 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Thread-Topic: [PATCH v2 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Thread-Index: AQHcLMfm+bZ7U2qihEG+JeLp3z4omLSi51uAgABjjgCAAUfAAIAAAWWA
Date: Thu, 25 Sep 2025 23:47:55 +0000
Message-ID: <20250925234753.3q7nx6nuhi3ha5my@synopsys.com>
References: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
 <20250923-ls_dma_coherence-v2-2-ce3176396bdb@nxp.com>
 <20250924221331.migo5szpf4svxpyr@synopsys.com>
 <aNTAjk1zsWF5lm3p@lizhi-Precision-Tower-5810>
 <20250925234225.6uaxndkhm5nq654s@synopsys.com>
In-Reply-To: <20250925234225.6uaxndkhm5nq654s@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8563:EE_
x-ms-office365-filtering-correlation-id: 49f95cbc-7f39-4a78-2b5a-08ddfc8df2d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVpmQmlMM2FyVjBERkwwMjIwbXpIeWxjdXp0Tjk0Qk90V2ZkaEdjU0RDSXg4?=
 =?utf-8?B?MDVDancwRVZnSmJER21GMlljem1MbVYwSFlJZ3JabG9pbURpZWhFMi9OOVZF?=
 =?utf-8?B?Vmd4TEIwdmRXMjA1Q0h4VEZjM05rc1R6aGhhU1FTUkExc0JFNjQyQUFKN3FE?=
 =?utf-8?B?aWRBWXNFRHl4MmZ6Vy95RTIvbCtsc0tVR0JTN0szaVUrUjlhT3Q0K0g2Z1p2?=
 =?utf-8?B?ZGVSTDZqM3FGazdHMDArVG52Y09VWUVHY2R5d3BBd3kyanAvU2lKNThMcU9T?=
 =?utf-8?B?UFd0MmJUVlA1a01PK3MyVVlnQmhoYnYwMWtkMFVHTnZQZVVlYWovc1pwNDMv?=
 =?utf-8?B?Znd1cVlHWm81NHJNRFExNkJ0d1ovSFc3akpQWStrVEpwQU5ndFE3U1l4WU9x?=
 =?utf-8?B?elBPRDB6TTZtcFU3TlBoUXNiRzlkNkpGaDFOTzVsdCtIVE53VGl1VGE5K2xM?=
 =?utf-8?B?aVJ3bVRwR0J0QUxoQVpJcWd5K1dCdFZRRy9HbW1oL3dkUGlrK2ZiZlVrbU9B?=
 =?utf-8?B?dHRoeUdOT0g2aDNiK0R0NTVWVU91VmZGNVBqcVZ2eTlrZnB0MmVONGRNQmNH?=
 =?utf-8?B?dXNqZXNYT1dQMFdOYjdEbWkyUmhscUtvejI5SCswNXBVWGo3Nk5jdi81VXBH?=
 =?utf-8?B?SCtCTnJieHdKcXNmOERzR21keTRkUERhZXJkM2RCNi9ZTlhKTHVodGJibE8y?=
 =?utf-8?B?L0VBdjlVeFhFL0g5Z0UzKzdvaFZmeEI0UVg4VmlmNFRMbyt0Szk0UzVqZDcw?=
 =?utf-8?B?dzJVcytkbWZhYXBpUmlsc1NSaGpwM2dQMzJiNE9zNjNNejl6YzhEdVNhQ1NH?=
 =?utf-8?B?enlWM3hVazVVUHBtUnI5Sjh1aTk1eE1yU0JyR2RMUmszbldoOHUxb2E2OUVn?=
 =?utf-8?B?Y1NWUDJhZ0VYTldDQUk1TU40UXA2Q3h1emIxT2pjU1Y5djlLVjJKVkxyY2da?=
 =?utf-8?B?RFFhM1llTHFONmlXV3kwZko1N0Z2djRGSEVpVFlCaWV6ZVVmbkFJMGtvT1Zw?=
 =?utf-8?B?UlQ5akxxNll0UUNhOC80dXdnN1c5MUJvUXR1WmE1SFVGV3FTdTErVXdCUFla?=
 =?utf-8?B?QmpZMmVwMkpSektBL2RNQ1cyazdRRC85cndtMWxlUFM0WkhTQlJROVhPRWpH?=
 =?utf-8?B?RFlDU25yY1YyZ1dPVm9zb1NYTEF2MlkrS0JLdmExb1NWaTA5K3Y5MktKUkNs?=
 =?utf-8?B?Q0xuN3pEclBYQU1rWVZBWkd3bDNveWpoUDBYRTZzTzBaWlZjcHdIbTZzWGVQ?=
 =?utf-8?B?Q2EwRGFLQlVQaURGVmVianJVODVBR2ZnbllUZGxVTVZqWFNvajJ2b0xidSs2?=
 =?utf-8?B?VlJGcmV0VWo5U2ZjdHpUNjFNNks1VFV5ci9ha0xDZ0NWSkl0SC9XazR0VFRQ?=
 =?utf-8?B?MG5OYVNhMlFHeFpva0hxVGxLKy9hTzlFR3lZbVQwcW1UQmJvTVBYMFZhL1hp?=
 =?utf-8?B?aGwzcnBDL29RQTFvSG52Z29rQlpsVENDcTBIRmV2bmNOVnlSRlpIZVB5UEFo?=
 =?utf-8?B?MFBXdDNDd28wWmY3WTNCcnY3RCtOc25Kdy93cloxYnh6cC9ZWVJveUQzNFVm?=
 =?utf-8?B?K0Y5dVF4aThCaFlLZTBtNTRVcG4yTlNwckRZOGpxZnFKeVFPcjZGaXI0T3lo?=
 =?utf-8?B?ZVBqYnhJaVl6RnBQemtHM0lVVTNnNVhZOVgzYnlBQWFnTjNKMTYyenA1YURz?=
 =?utf-8?B?UW5YeVY5YUp0SmRETWhUdHVOT1ZJNVFVamxjTlQ5TUkwTTk3Q2U4UG1lK0Z2?=
 =?utf-8?B?cUJ1ZEdVaFlvdVB5b0FrTUpOVDZDcld5UEs3YUEraGJZa1hncHJHWFhVZzRC?=
 =?utf-8?B?aVJJY1doRlB4d3g5SFovZExidUNyL3VIaTh5TG0xWmNXa29pVXNCY1NaTExv?=
 =?utf-8?B?MTlvN2V4QXBwaW0vOGFtR0V6eFFUYVdjRVIwdWNYSGg3MExSVmtXY20vVmk3?=
 =?utf-8?B?SHJBZnk3azRpRGltWENhT2pRN2pIWEJmb3NzaFhDV0MxSzlXc1NFVitJQ1Nr?=
 =?utf-8?Q?Mvpairbr0zs1M3Bw40q9BynTb5YG8U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUU3b1hiSi9sbVl3d1hIN0FKMVZsL1FPSExHSWdVTG9XN3Zrd2Z2NjRqcUJR?=
 =?utf-8?B?VzhPS3NmRlp0VXJOQTVUVVlEaURzdzk0eWJ2Q2pFcm9Sd2p6YTFQQXBzb3Zi?=
 =?utf-8?B?NjMzNmtiT2E5cFd3RE8vMXpUVmxweFc0cXBpaDlINW9pcDZaUFdVWHJTcFho?=
 =?utf-8?B?VHdFRkZ2WVJMSTFldmNNU1RUa3NFZEVVdHRweTBHcllQK0NBNUZ3RUYrTDJl?=
 =?utf-8?B?eFA3WUg2dUlCNkNqM2FBN1FEdHBPYmhhcDFrQXBON3FJMTNuZXArL2NhRUFr?=
 =?utf-8?B?R3VOWlp1Uklva2Rwd0hxbUh5bU55ampyMjJvSmVVY3ZESG41bUJhVUxVTHZ5?=
 =?utf-8?B?UG85NVpDdUZ6L3NuYXRaYlhUaFBaVktBVUNzTlBEY3dyWUR4UUVkTnkrbHlz?=
 =?utf-8?B?KzdrcHlhUVNOclpTbG9yWEo5d1lHWVoyRlZrVVN0WjNwcWJlSGMzWkMxbjBD?=
 =?utf-8?B?aVQxeUFSM1hwL1YzWmtTa0c4V3hPcXZrYXpiNUJRR1k4RnZFY3NFK1VZdmJk?=
 =?utf-8?B?ZTRKajhhU0pidjh4ZUlSY2dVMU1lc0RuT1d2UWtmTXZqZG03WHRaVUZrU29x?=
 =?utf-8?B?MXBTRHd0Ry9sK3RyUkJQclpQcjkvdWw1UkdUYmpMZXlra2hXNEZJV3RtZXFi?=
 =?utf-8?B?NzRvaUh6ZnhSbHR1TnorWmJ4bjdXUE1wYWx1TmNZMENzOXRZWFo1bWJxYnpl?=
 =?utf-8?B?cS85Mys4anlXSUVHQytVdWkzYjRVeXNTYzBEcU5OVEM0WlNGQm0rTGs4bW03?=
 =?utf-8?B?ZUs2RmgxUEdjcVhnSGZxNUxkZDZUa3lqRWJJMjQvMFhyQnY3Rlo3OXlRd1Rn?=
 =?utf-8?B?V2h6Nk5BZ0tHcnA4SUNiN1dBQm1Ba3pYczVacXUxdzI2Z2ZLSnRFbjR0em1C?=
 =?utf-8?B?dDE0WnAvdzBSV3pxaXRheDRsVEdHNkMwcW1rS0N4MjRhRjdPVWdIeHllenFB?=
 =?utf-8?B?VU0rRFd1dTVxRGFTSlpTNFQyejNkdk1kVEV1bnpoNy9CSmE2eWpHOCttbE40?=
 =?utf-8?B?bFpaRlhaNEtTRjhHQURKUGU1SHg4RVVSL05EUzZxY2FBZ3JNVmliTnZFWG1C?=
 =?utf-8?B?ajZReGJQOWxUTyszbHRVNE5wRS9IVVNLVmViOEVRQnRocDhBcG4zZnNNbzhu?=
 =?utf-8?B?ZlhpdFFNTjZxS0VoWFVHQWpsVU5zcHRVUEc5L2lubVZSMGMrNDdJTDJRcTJX?=
 =?utf-8?B?Q3BIa0xOemdIOG53Q1NoTGVBOTg4OU55cTJrL0pEdWU0MGtQaXJ2cktzUC9O?=
 =?utf-8?B?L2FxSWs0Y1V5aXZQenZueFhpSXJ2SlNiWm84ZHVLK1pmZDcrT29Oem9yUTJ2?=
 =?utf-8?B?WUlOd0p6RXVpSHJFQitPcHNOa2ZEZHhrMVF3ZFJSa3VVa2FJT0EvN3ROZCs0?=
 =?utf-8?B?dHpRQ2QyMW5vdjZDYUUwRXp1ei8yQzR4U3B3Y0RidXpkVnBZbU1mdWJ1R1Vl?=
 =?utf-8?B?eXVaKzFuTTh2QjJZY1IrME5ucy9ja2xKcE5kRVlOTXNMYlkxUlJSaTlKWTda?=
 =?utf-8?B?T2lXVWFqdkNWUCs3ZkV3aE5lTFdSZVMvcU9DVEFvbDVIci9jZ0g4c092aFFK?=
 =?utf-8?B?eGJOV0dqSm00dDI0ZytkekhyazRCVzVVTUhoMTBjMEVsTnBjdXA1enN5UVcr?=
 =?utf-8?B?YlE3T0RvWm5NRFZrZTdsTzA5Y2VvS0RxWlBpTnE3d2tNMldacGhxWDVhMW1o?=
 =?utf-8?B?REZ3ZzNTVDN5c0pLdzJmbDBDQUFHMUw2NXNZQWlvUzVYdHhLL04zTHgvNC9M?=
 =?utf-8?B?U0luSzlwTUh1aGtIbEtUYjJORzNQNktwQlBmKytzQ3dvb1YzdVNRWVhZeVJX?=
 =?utf-8?B?NlRnaUZsbUFFUXJ0UEUzejZxSzVNZDN0STV2L0lHLzB1djBkeGl0NXBVTUEx?=
 =?utf-8?B?WkNEdGp4RFVPbTEwN3NXYS9LV3ZWWTg1RnA5eWpNdFg5dmlRblFKTTJPajVV?=
 =?utf-8?B?SGRkUlZTOS9jSzMyUUtDOUZHNjVGZ3lUYmMyb0F5c3RLNk81eWw0WDIveS9L?=
 =?utf-8?B?MEUrWFhOWkxnK0RPK1VhWC9CaUlaZUJHeTRkd2cyd1VRb3drUGd3T3o4bFEw?=
 =?utf-8?B?Smw1ZXdlZlVWdGVJNWJkVVVDK2NERVJldEZtY0RJVW8ydjhSZW5UanBOWHR2?=
 =?utf-8?Q?Ma4tjB0XATrcUqwZeVz85AffI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE9C5E98D7D0AA4892E42B21854E021D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gEG50GQoMcDrflsLunbOUrOQMCHrd6OPadHf3FRJ1C1xFm+Tz8lhV6RogHn8DO6CGkzzjm27866LMkvuN0kUME8Wbob0f50Z9E9cbkhscNUk6LJZ6JQxeQUqfCZhaiXePJgjAcTBXRwOt1brJa30eRfS3qYNQHedu9qcDJnRm25DzHo38hto/QlBgQIdUGE9A0xhLeayX/pGI7j2QvvrxCNoeZkymlKwveGVpGXUOd5Kkhnig7JvtD5mTUUdEtm311/DEgfdqbUyBLo2EusCiFyUiy9PAh7lpW8roOVq6NtM5G0t99P1wO9QfzWDgqjpkhvdpa+hDPmztuxiQgUfopGuZ5xUTwBhdatrjihYpFA+nrW+ehuy16Ikr8Vz4g233BypEavViIveTdqtv+2a3FS0jezQP9/Vyd8G+VEcjRZgqTDuDNlI0V6bCeNxtTAzAtopcvCB9rc/hi68fNum/73FhE+afny+YTLIBe3rHl60G2NvBTuwnK7U1AD+nJVOzCVd86KqmF5RXKwCmiBYuMmNMEoPJY/w9ffIiCCuoaufd/1w/mvemxltbjaLAynPvgELe8q7ucyFp3mkfYQxcJipy+HsshSJUg7bbR3Q0mWHOGw3nBATvcMuwqLuZnXZ2Sc9RETM90lwvn411V7kcQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f95cbc-7f39-4a78-2b5a-08ddfc8df2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 23:47:55.0589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVnMftGzDuXJKXVHg7AkrDA3KneKGRUBeYfn+MR+4DutCA7vlrJ50tZAWohKFZIgzDc/lEWyWXCEZJGWKC9DuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
X-Authority-Analysis: v=2.4 cv=Ar7jHe9P c=1 sm=1 tr=0 ts=68d5d4b4 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=m2hrBLAHIXKCCeAMYDoA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: M0TJDkT9z0MXHIn9HmHwLINDYuUaoaqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXzwaQyb5yuzAM
 BwD/psgxOoTwe/r6LwQ0XTOK1QMChq/6FrM+4NydkM53sFeMnuVqDdh5Sc09ucrSEEZHP9WLHOA
 CSlmqZG0ZhWR7o+GUWkkPLMOaHXomeBcwPrtnD7KTFXGtTF7c33dOhjCuRTSpnv4xF+lz2bM7sM
 2lyYW8f1tKDv+kTaq47Y/CzBDBVBQHnosYeYBCG8CjqGYLzhZpoeBTJZJmAGVZa57CpAzRrhPF5
 NlAhepiGclLxmCTt+1pcCif1pIGB6tLZ7eUmY0wPTmfk4l+G8PVlwOFqzjeCG2FlCnkPCpQZuMu
 cbKCFZ6GmnJYAxCkUBSR7yhPSOlR58ynH0Z98LttKrLGsgmaBRWg0L8TK+JtNQZEf8NK1PVrqxv
 OAnzs1SzPyrYIdrwSfTpoVtHUVhn/A==
X-Proofpoint-GUID: M0TJDkT9z0MXHIn9HmHwLINDYuUaoaqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509250171

T24gVGh1LCBTZXAgMjUsIDIwMjUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gIA0KPiBAQCAtMjIw
Niw3ICsyMjExLDcgQEAgaW50IGR3YzNfY29yZV9wcm9iZShjb25zdCBzdHJ1Y3QgZHdjM19wcm9i
ZV9kYXRhICpkYXRhKQ0KPiAgDQo+ICAJZHdjM19nZXRfcHJvcGVydGllcyhkd2MpOw0KPiAgDQo+
IC0JZHdjM19nZXRfc29mdHdhcmVfcHJvcGVydGllcyhkd2MpOw0KPiArCWR3YzNfZ2V0X3NvZnR3
YXJlX3Byb3BlcnRpZXMoZHdjLCAmZGF0YS0+cHJvcGVydGllcyk7DQo+ICANCj4gIAlkd2MtPnVz
Yl9wc3kgPSBkd2MzX2dldF91c2JfcG93ZXJfc3VwcGx5KGR3Yyk7DQo+ICAJaWYgKElTX0VSUihk
d2MtPnVzYl9wc3kpKQ0KPiBAQCAtMjM1Niw2ICsyMzYxLDcgQEAgc3RhdGljIGludCBkd2MzX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlwcm9iZV9kYXRhLmR3
YyA9IGR3YzsNCj4gIAlwcm9iZV9kYXRhLnJlcyA9IHJlczsNCj4gKwlwcm9iZV9kYXRhLnByb3Bl
cnRpZXMuZ3NidXNjZmcwX3JlcWluZm8gPSBEV0MzX0dTQlVTQ0ZHMF9SRVFJTkZPX1VOU1BFQ0lG
SUVEOw0KPiAgDQoNClNlbnQgYSBiaXQgZWFybHkuIFRoZSBjaGFuZ2UgYWJvdmUgc2hvdWxkJ3Zl
IGJlZW4gdGhpczoNCg0KCXByb2JlX2RhdGEucHJvcGVydGllcyA9IERXQzNfREVGQVVMVF9QUk9Q
RVJUSUVTOw0KDQpCUiwNClRoaW5oDQo=

