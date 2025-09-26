Return-Path: <linux-kernel+bounces-834742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F77BA566F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF691746182
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415422BEC55;
	Fri, 26 Sep 2025 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="pKGfadLb";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FEd31FJT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AJpJlHfj"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA881388;
	Fri, 26 Sep 2025 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758930825; cv=fail; b=LvNwiPFdxkqyoLqDqBa6O3cqlz3VNRIe742u9OwnhPUiTv+TwaTQd+X45IQCkbHdsGUoCeUXzv3g1P9Z5gpaBZZi11Tm6EucdHdtoWEyecWnuSfRRbObQtuEsbPoV3ztjd4ya0kQJBSHbuzdrWNcv02K6fGYa7sM64YrfMAp2eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758930825; c=relaxed/simple;
	bh=+yvtnz5NYzJXms7YzHExbbiqx6BDn5ZcaxI8/ZjylwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6IDFRQdwpuYUbtQZQ8SRopf8NlPMGf/8DpnzsqG7eNcmuVKDVSPWpPXVkCavgSwFtQVeyzf37XTBQg8o8OKSOYgBu0L+hp/r02MTEQFoJWungzFU7MjYs1hsdBQxrJtDBzFHqZ+fDQyNrTlL4BPiD+JwCgpOeQakiX6zVw55aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=pKGfadLb; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FEd31FJT; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AJpJlHfj reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QJvx8t018245;
	Fri, 26 Sep 2025 16:52:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=+yvtnz5NYzJXms7YzHExbbiqx6BDn5ZcaxI8/ZjylwU=; b=
	pKGfadLbbiS37BsFT8hidmgUFXUlLJkTi4R2sSC8RbjxlnboE9bHAlwGrsn4UAxC
	4NUbTvdm7AI4VhwLiEKFb/IM6o9rLTGE/i6DtcApye8nqsKNMe3viTeAvIXbDh0s
	G8GbchcS1M+/y6OeYMIpp9BFDw+y1rETAusS7f7m18CXi34NoTVRbTJnO9nisYzl
	tbbwYFVKiyRibbJR49NnlKhbShV58uvmq6i7Y5eLweJXXXoXhwU03OoKtsuDKFx5
	f4XY80xqWdaFx2k2ZKcpgEWzvm18l3Qr6esg5mXVZKVp5iEnAEfqvCRJEKgBc5qm
	oP2/PMilrZV5/YbiIRP9ZQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49db0nf1qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758930775; bh=+yvtnz5NYzJXms7YzHExbbiqx6BDn5ZcaxI8/ZjylwU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=FEd31FJTRLudF7DjM550qz87xHvb+1eB1ZT83jL1ndVGIQGG2iJicPhe8FqewICEV
	 M6qwn+A+oJ3EiIWJ+lV3LeN6qGqT5WW3JGKM9qcHezoLdVEe5GWMxpbQKhcqr5J1JV
	 NKkt9f1MhBu2KAWDKuqWswVJZ8V8ujLgRWgXk7jvCxpgnXnrvRDx4kA0MuDI/aQ5o8
	 eiPKFAYIDKU8MPEQgGd+Cz/JWX69s4bzEVugDDkqS8QtWWIRs2ROAYzU8rOyfYtJtj
	 dPqlctBKJPLYiWdvQxXQVu/V2owc0qx0p2pEvQ8hecujviJRs1rO2FgVtjHilX39Aw
	 F0O0QVM1LrjFw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3D3E140126;
	Fri, 26 Sep 2025 23:52:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B36D7A006E;
	Fri, 26 Sep 2025 23:52:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=AJpJlHfj;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00102.outbound.protection.outlook.com [40.93.14.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 89B4D40352;
	Fri, 26 Sep 2025 23:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVyiPBO0Dyhi0WhUlE6HUlfEAnk7BzvVzCTbIs3q6Ir+2PXIZelhrEwiYHy7zVegXc9Z93u4fK56Wb+gAdCzO1Hq4Q43f7rp5SY+lh7MzWdPPoi91fuJr1LorQaWRUoED7GAQx/7N++1j8MEeyZvZvuElKZEWOwQnSWKcTEuC1ayB1MLny0S0PQQfnjjChvR/w2N235e6h0Ocx+ZgdwlD9kh7yFOZavKtXv3l/Ceug0W/dh7mYv1AZURFqxfIB30zYKHJ5m61VfyqV0ZfJYAEWLd4WhX1cimLKnJw4mtyU6xGuOfzNB/a8xV4YWqm5VB8NM6+Zbz9XJsiQc6GtS43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yvtnz5NYzJXms7YzHExbbiqx6BDn5ZcaxI8/ZjylwU=;
 b=H6NRThatuWGUHuVQ3iL0K2oG9461CN13oMLwfqnqWUEtZ5CI6QmRWjcupc1B+v0BTG2QEfF4sl7iNVsHjo8FjUE6Z33gUEveiifpQ9KisBRgW6flCzG2sRy+Fp4Mvbkp2dgyABJmulo2Wbd7M9FEnbZBQA3RkuijfWvGmQ1itC8QypFPfoCeZZmt/D3pnhIG+RUjKF2bDJwt5kOytRcjIkkcgWnIEzU3QDxQ0oFkjVcDIYyfp+xc260/4H3uVJsQhJ4O3WtE+GEy94IUNkJ/rc2XMPzVykooMETyYnETdiYEj4xZTQWMxmuetJu63VBr+dUHx1hwq3MAs/BCTB3rIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yvtnz5NYzJXms7YzHExbbiqx6BDn5ZcaxI8/ZjylwU=;
 b=AJpJlHfjJLWX6Biw0zW79JulXRsez+fGdDWWo4/NL86itpbJ6H6PmTa6E6kI8o9VltoX5XZXvSEOINAPvd9x7aj9MdgUNa0qII4fvlYbG7v+LQ32M3PJl25Ct0Dtwa0EhfIjMnAxOO+QBwP+XojEAKKoXGLoGYEOQNidfceV8qE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 23:52:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 23:52:48 +0000
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
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v4 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Thread-Topic: [PATCH v4 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Thread-Index: AQHcLxItOL4kq5x9WkWcbDHlzaw1hLSmD6kAgAAN6ICAAAWcgA==
Date: Fri, 26 Sep 2025 23:52:48 +0000
Message-ID: <20250926235247.c6zof6meqaxe24ll@synopsys.com>
References: <20250926-ls_dma_coherence-v4-0-21e9c6bdb5cb@nxp.com>
 <20250926-ls_dma_coherence-v4-3-21e9c6bdb5cb@nxp.com>
 <20250926224256.xxf5lobht4dndixz@synopsys.com>
 <aNcim7GUT0/1rDb8@lizhi-Precision-Tower-5810>
In-Reply-To: <aNcim7GUT0/1rDb8@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH8PR12MB6841:EE_
x-ms-office365-filtering-correlation-id: 4bafd8a4-f55f-4d5e-f33a-08ddfd57cc17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?czB6RWo2aS8wWkRaZHRwcldVUXZuUE5TT29zRDZra2Z2QmIwT1NabkFCSkl2?=
 =?utf-8?B?ZGxOT29LQ1FsWUlnZlpkSHcyU3dtWHpqMlFJZWtxMG9idHJHbitDL1BhSTJB?=
 =?utf-8?B?ait2d0NCUzlrdENoOW9jbmxZUVNxZmxSd000SkFnd0toUjFpUVVkYytHRzBZ?=
 =?utf-8?B?dTlId2NZQXNFZWY0SVN3SjJjWXNVSkNCOWhLbHJ1QVIreFgrM0t2dGFuQ2cy?=
 =?utf-8?B?WlRJSHF1RXRDSFI0dGJ2MnhTTXl1bG5sMjc5bkg3MC9ub2hNT3E4T2M2aFQv?=
 =?utf-8?B?anNtQlJUZG1Ka29TT050dWFacTRqN1pncHV2R245RHAyZ0Fid0dzQ3lLSUxi?=
 =?utf-8?B?VEMxWnZTclkrdmlpaGhoQWRNRndjZ280N2U0dGxDV1liLzBsSlVLaGJvaUFm?=
 =?utf-8?B?ZHRXS256bE80WVpDMkc1YlVMVnl3QWJnT1Y4Z3RYWTNKV2lTOXQydjhtSndE?=
 =?utf-8?B?Zjg3bWw0KzFBQ1dWVW5yVjlrbkVrTSt1RkdmUHBKOXd1OWhySVNyZXdtWkdp?=
 =?utf-8?B?eEdYaEhNdlZmRVhxRXJaVlN1a2dUeXF6TDduUXpaTGdRRExuTWVnZ1RINmRB?=
 =?utf-8?B?T3BJcStnTTBZU1lTNnNWdjI0WC9aYXkwWnNRWE1EYXJ2THdVci9tUHdjMUFJ?=
 =?utf-8?B?V1FpZmZKRlpiY3RPQ1I2ZFdjTDc5aitrdm5keVg4cU5NSVZ2TjZzdm1DUTIx?=
 =?utf-8?B?Zzc3bnI0RUdiMDV5Q0hoQTQvM1YrN1Jac0U2ekZud1BNTWpCNk9hcWF2NllV?=
 =?utf-8?B?TkVhUmE4TVVQYjFMcFBCTGVoUE03UkRwMEc4SGFRQUYvR0w4c2VqeHRLV0RO?=
 =?utf-8?B?Zy9SYUk4SUw0OE44Wk9peXVBN2RiZEVQcCtVS0pSZFBwNUVwZUM5SnNVblh5?=
 =?utf-8?B?UDkxTktLQmh3K2FXd0RzaGJYcS9DT2dHZDVFejBLWHpHQkJLSndOTVk4VmVI?=
 =?utf-8?B?SW4vdmY2dmlnRnh3MjFzQ05XWkl1c0ZHRjkzMTZkWTJvY1pWTmVLUG0vM3Iy?=
 =?utf-8?B?SGgrMzZlaDR5WE1MS1RQNFZCNU93MXRCczBKOGhCQU8xSHU3YTFhZVN2Q2Ir?=
 =?utf-8?B?SXVaTzdKd3Z4ZnVaNGNONzBNMEZBT0NrTENSZEU4Yk5ibysvbDJlOFpyN1B6?=
 =?utf-8?B?enRCZGdkZzA5MmlJcFRRdjdyNkhFR0hzaG9uRWovSXgrR2dTSlh1UEFGemlR?=
 =?utf-8?B?RmJtYzdkRkUwQ0tFR3Q5OXJ6NisxMDFVdzdqaXVmWm1SVnpmNWo2Z3BQV1pO?=
 =?utf-8?B?RkhpNGVOSGZXWVo3VklpOXhEOUJVcHkvN3pBUk5SdzBkd3dLZk1QeURmdUVR?=
 =?utf-8?B?YjludFNySm9GQ0lpSExHOGp3QXBDdy8rYlRmOHRQZ1dMTHhjKzZRa2VmdWpa?=
 =?utf-8?B?M2kyL2cwUlBLWTVYSjRtMmRjTzRqREE0UGhqOENUWUhrY1AwaW5RQy9wQ3Rr?=
 =?utf-8?B?VndZb0FSN2dzeWZGQU1adHdpMUQ3MW0zVU95ZVBuSDN0WnNGblFURVRCa0RK?=
 =?utf-8?B?dnlZMHhBNUFlc3Z0WXpsM1pNTXg0dmlzaTg4QVBLby9Qb2ZYN2VkMTJaSS9F?=
 =?utf-8?B?ek5rckJ0Y2N1aGVLQWtQM2ppeE5Rd002STAreXJwTGpyNC8xaEkzVk5DNnlN?=
 =?utf-8?B?Q0REaXVrWWdXQ2tqVnBObjdVNG9RbUFlTnRsYmZvU1NQSG05alJzYW04d2Ey?=
 =?utf-8?B?M0ZEeVdyQ2tvd2s0dyt2MzJiaU5XRHFNV1pWS0hvcVk1cnQvY0MvZGhER1Jl?=
 =?utf-8?B?Q2Q1bjRjeUhOUURXVnV5RXozV0lPd0VacVhFSmhlcXRzQVgzN1ZKdHBhSXpZ?=
 =?utf-8?B?WlVLd0Y3VlZyZVhwQXZENUUwUjZnNG1Zd3VPUk45Vm1yR01DUXNWckNadFFP?=
 =?utf-8?B?V3d0anlyZnpLZmU0WHlQYTgxRTZQZ04yYXBLbkhnMnMwVWRoRUF3Y012eExH?=
 =?utf-8?B?dE1rSFZSVUxWTXVTR2JjZEZ2b2ZyS2FkSzh2cEs2azU2VGw5dUYyekFvTWRK?=
 =?utf-8?B?ejdqWTNPTzdMaktuRVp3bXJvOGdKaTZ3THVCOTliQTBRaWtzUkJKcmw5SnZv?=
 =?utf-8?Q?unzhmj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW9HaTNRZkpvTjZzZWlaNmNoRVhybC9lblBHL1R3TmswTGNuMUh5NlMrMlhE?=
 =?utf-8?B?VFdnWkVqbHBnZUhOWXBDMkZxR0RrUnZONk5FTTFrdGdFcWxZSWE2WE11WkE4?=
 =?utf-8?B?WFl5Z1oycVUxOWkzaXRObSsvZE5MMDA2L0RJbkQ1SEwvL09NdXZTTzRBaWVE?=
 =?utf-8?B?MnBSdmtVeTYwOGZqcWg0YmU0d0dCVkJYSllSaEdjNFdnQzQyWFoyS090WmM4?=
 =?utf-8?B?V2lBeUNJcmV2MTFvRXZxTGZJUWY5NE1qeHBKa3NTak15MnVLdjJQc3UxaGx4?=
 =?utf-8?B?NkJlMUdlV2RNcFk2UjlYRnlxWGdlOFBtSnpQWmd5RDVGRkFGVzlLRElCK2M3?=
 =?utf-8?B?cHF5YVJ6K2Jja2EvaXhMakJsYUxLSkhpTnB0M3ZPZ3l0MDJnRWN0UU1uQ1BC?=
 =?utf-8?B?VE9ycGk5Tm5jMGhOWEpjZkhqN2E4OUo2bVZybUpyamhsU2NNYkVsb05WWnVL?=
 =?utf-8?B?NjYrK2Y5OEo0LzBsNytCdFNkSHFDYnBvQzQxbW9GdVFDQmx5S0d1ZlFyQ3hN?=
 =?utf-8?B?eFNPQkNtTEtMd0dqT3lEWVpjOTkvWFRYVC9xcDg1bjVZUWZ2eWNuZ3ZyNVVw?=
 =?utf-8?B?Z2V5OTRka1d3Q0d2U3l4ZzFyWFE3WTYwMDZKdjBKSS9KVEVPOVNpYjVKNXRL?=
 =?utf-8?B?Z3lKNHozcVVLa2cvK2JVYnJxR1FadURnREpRRkFWZEVpRlYvZE1KTFdIbmxH?=
 =?utf-8?B?bEg2QzIrNzlTT0RJVmZzS1NkNUlXb2tUaDdHZlZ1TW53TzZZclJxWG9pbDRp?=
 =?utf-8?B?Y283aTMyRVh2UVYyQVF2Y0xLOFBTS2k2ZFJkOFpWY3BsZ3VHendubGUwS3RW?=
 =?utf-8?B?OWdoTGUxSzVVUHo0Sy9BL1NrYk0waWQwNnoybjNMc0ZxTHpQTVlmdmtraXlZ?=
 =?utf-8?B?ZjFkcTlrcGZhaWJVMzFtZG91R3NiblBBVWhnMTN3dzFkSFpJblJpQWZ6b0tU?=
 =?utf-8?B?UnJuUmZ0MVdXUmV3czY2QkJhM2JNMG1VNXYvcGNqM2UrNlh5L0U1eEowb2ZK?=
 =?utf-8?B?SVlMMS9xRktZMHlDSzEvenRtSEVzZlFZT1JDWVc2SkxqWVNPUktlZmRjb1lm?=
 =?utf-8?B?dVZ6UjhxdFdjV2FqNUZONzZuRllXY2hWNjMxOXN2NkM1S0I1eUhYbzhJUmgr?=
 =?utf-8?B?dFRDUmx2NHZoVE9Ra0FrMVBHcUE0TFg3UExoMXprMWpQbWhxYXR5WjM0YlJO?=
 =?utf-8?B?ZTlmeVNSRXcyY3JoeFpKYWdCN0hrTmliZjNFZjhhMFllSnFCZ1RkSGhSekpW?=
 =?utf-8?B?TE9GSmliZ3p3b2MzenhDWEYrWm4wNG9aaEVtMG5xbldOTC9xSmZicnYzVWF3?=
 =?utf-8?B?YmhjcVZ6Uy8zR1VyZFZmcmVtZ0I4Uk1RajZYdENiSEJEWnNXUkdJc0U3MHJH?=
 =?utf-8?B?UzUybHUzR2cxWGlSY1NnMlc1aGxDSE9sdDVGUmV4VDdSNm1ONUw0a0loM2pM?=
 =?utf-8?B?dFJ2UlVPa09ydytIU0RrWnc3Y2hrRDA3c3poalFQeThBVHhjWlpiVjJpSk5y?=
 =?utf-8?B?eTNEbXczNjE5NnBaTVJrN2V6MG84ci9QY3hiWWRveXZKNjRBeW1CRGZhYVht?=
 =?utf-8?B?TGxNMDllRXZwbEFFLzJ0bDRBYjhtVFpMb1lDWERzSi9oMEtUcWVRWjZURFJl?=
 =?utf-8?B?RDJxNmFtcDM2SmRzRGFIU0FnTzRoRFpXR2VaMG9YK1VTcDlBNEJFcUZLbkxa?=
 =?utf-8?B?dEN5cnhNRUZKRlUvNEVUQnFBSUZ1QVZwNUpJVTBJeUtld3VFSitsU3Eyc2Jt?=
 =?utf-8?B?S0EwZGlZYjJpS1pSY0x4bmJYWWJqUVJSUnpuYUZKOWFiTDVFRkExRVVyS1pE?=
 =?utf-8?B?bHFOQ3BOUDhLbDFNenJQNFpzdms5U2l0cWs5ekxTM1M1aUp5Y0Y5UTFVWUNE?=
 =?utf-8?B?UTU1Mnc3OGJqRkNDdWJjblhrbGI3L0Y3MWRrSXVlMFRvdkxZT1lTbitwOXFh?=
 =?utf-8?B?NkkvcTJ1czQrU0tmRlRtN1Y3Q3RlQ3NyOTdmTVZ1VG5vNk1KWHZSUHJBczhw?=
 =?utf-8?B?aEI5UVkwT1lnekZ3ZTNLZ2tHMDlzVUt6cGYzRFM5QzVXdStBblN3YkZQdFRJ?=
 =?utf-8?B?cTVEdmYxbnh2MHl3UTRBVk52Q1RWckgrQm5kc0dCWUdkTFlwMDJ4SDdlbEhZ?=
 =?utf-8?B?eDVVODcyY0ZaaWVna0NFS2tSOEtaNXRYR3hFcTJPazRRZHp6ZnFORmdRWnZm?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29B580258F1C6043B1016A5D05AF3396@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u2GqlDhevIaSUmDr6obx5QvryKt/4Qw3OPCEAoJsxmjO51uzNcfDUCHpNk4xWvaKmnzx+izKc9bt6sE4jMbabJOjen1p7HdbG0IByt57uHzEfbDCq5fP/UoPlb+nqNUHqD3E1zkSKjznKCHhbNNPoDORNDzxwa074xJPHh8Gg5aiFG0UuY51MQzeXPPh1UWZ6iJWP4nVU5cr2lxFHwHSGVbswfFpoCRTBZDKcFbf1cusM7YBoOVdaNib7CKyei0ZiRxwD3jbkvaaaLQsVrTJRraNKQ5Nu0iP3uumnelf7Wh8qj8kbspiv6GnugQYYh/xpogdkO6dIEszHCaDYU81YW/JGEL/MjQUoOceIfQExo7dq9nlu3Hl17rb6MRbTSztIQ7dWE0XVOvh3tthlncr8QbrG3pZZ/EAB7wtpPChTaeXFjVSgtDEdVRTIWK5ICbBW6zQaAsx4Nvh+Ka7rldNw9ov6vjV+pxSFeBey8bXuogSy3YWQKmm8xulpHcICTjQG70uiDiWobUFvcklEO0Z+Vh0bqzgNsfSifh2WPjjKJuN2yTRdRItXp0Lu1Nykbjvn3GAW4KCCujt2kSt7kKkboCKjG42Y0t9m9yMO2NxTjrsfUgLgNU0DFY6Lahax/57sM5+ZlJF4eqwydgguUbJ6A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bafd8a4-f55f-4d5e-f33a-08ddfd57cc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 23:52:48.4403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCa8zDy1e6u8b8KF+TiUzzEVt8oyF+Jm9sobuH+Id90zdbZL9TQR74LbN3lfVTcMOA0EtAfQW+l4frf3qWcXVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
X-Authority-Analysis: v=2.4 cv=Ar7jHe9P c=1 sm=1 tr=0 ts=68d72757 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=8AirrxEcAAAA:8 a=QTqX-kIfeNgTNNuTSz8A:9
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 8G5pkSNl7N5nYUdXaFnyZxamCt6qIQGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXzcVp3mCZ2+9j
 9dIVL5N5Hy4p9rvxJ14kpHMGa7yed3YuT/RSSRfNHdtASxIow8vicDBMTG1tJ3kHQLg6g0Bi5ZB
 MAc0MHcOMqH3N7hkdXtyk6R+CDu2pfch0nljUQvdvyv24NpQLJUbDmQk7eWBZOVdzDwT5FcpVxN
 yLZBKCQ/Latb97FwdGGEoaf4aPddjneReTkQpbpaAFAiehe7lLmU61+exvfR+szR7XXaSsrRvP6
 nFsQ1aDPW/nPRyZsZoglwxzR8+T8QVk1GF45s4787ldB2F6MA6HFu0sSCYwBF5pkuEbgulERstg
 w+VwVt5PlyyHkvFHAsRFJaBN8/3BqebaEIM83jQrzy41Ut6ORy4bMESHgkHKZXjTYyn0UDMXiTp
 EHNpq6AqLuW9dlraZPcxpLFenkFQ+g==
X-Proofpoint-GUID: 8G5pkSNl7N5nYUdXaFnyZxamCt6qIQGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509250171

T24gRnJpLCBTZXAgMjYsIDIwMjUsIEZyYW5rIExpIHdyb3RlOg0KPiBPbiBGcmksIFNlcCAyNiwg
MjAyNSBhdCAxMDo0MzowM1BNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gRnJp
LCBTZXAgMjYsIDIwMjUsIEZyYW5rIExpIHZpYSBCNCBSZWxheSB3cm90ZToNCj4gPiA+IEZyb206
IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4NCj4gPiA+IEFkZCBsYXllcnNjYXBl
IGR3YzMgc3VwcG9ydCBieSB1c2luZyBmbGF0dGVuIGR3YzMgY29yZSBsaWJyYXJ5LiBMYXllcnNj
YXBlDQo+ID4gPiBkd2MzIG5lZWQgc2V0IGdzYnVzY2ZnMC1yZXFpbmZvIGFzIDB4MjIyMiB3aGVu
IGRtYS1jb2hlcmVuY2Ugc2V0Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExp
IDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBjaGFnbmUgaW4gdjQNCj4gPiA+
IC0gcmVuYW1lIGdzYnVzY2ZnMCB0byBnc2J1c2NmZzBfcmVxaW5mbw0KPiA+ID4gLSB1c2UgZmxh
dHRlbiBjb3JlJ3MgcHJvcGVydGllcy4NCj4gPiA+DQo+ID4gPiBjaGFuZ2UgaW4gdjMgKHNraXBw
ZWQpDQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0
LmMgfCAxNSArKysrKysrKysrKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2Vu
ZXJpYy1wbGF0LmMNCj4gPiA+IGluZGV4IGFmOTVhNTI3ZGNjMjdhN2ExNGQzOGRjYzg4N2Y3NGE4
ODhlZDkxZTYuLmNmY2VmZWZmZDdhZDZjMGEyMWNjYzlhYWE0NDgzYjlhY2I5ZGM0ZTAgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYw0KPiA+ID4gQEAgLTgs
NiArOCw3IEBADQo+ID4gPiAgICovDQo+ID4gPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9jbGsu
aD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiA+ID4gICNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQu
aD4NCj4gPiA+ICAjaW5jbHVkZSAiZ2x1ZS5oIg0KPiA+ID4gQEAgLTI5LDYgKzMwLDcgQEAgc3Rh
dGljIHZvaWQgZHdjM19nZW5lcmljX3Jlc2V0X2NvbnRyb2xfYXNzZXJ0KHZvaWQgKmRhdGEpDQo+
ID4gPg0KPiA+ID4gIHN0YXRpYyBpbnQgZHdjM19nZW5lcmljX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgew0KPiA+ID4gKwljb25zdCBzdHJ1Y3QgZHdjM19wcm9w
ZXJ0aWVzICpwcm9wZXJ0aWVzOw0KPiA+ID4gIAlzdHJ1Y3QgZHdjM19wcm9iZV9kYXRhIHByb2Jl
X2RhdGEgPSB7fTsNCj4gPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4g
PiA+ICAJc3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjM2c7DQo+ID4gPiBAQCAtNzUsNyArNzcsMTMg
QEAgc3RhdGljIGludCBkd2MzX2dlbmVyaWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiA+ICAJcHJvYmVfZGF0YS5kd2MgPSAmZHdjM2ctPmR3YzsNCj4gPiA+ICAJcHJv
YmVfZGF0YS5yZXMgPSByZXM7DQo+ID4gPiAgCXByb2JlX2RhdGEuaWdub3JlX2Nsb2Nrc19hbmRf
cmVzZXRzID0gdHJ1ZTsNCj4gPiA+IC0JcHJvYmVfZGF0YS5wcm9wZXJ0aWVzID0gRFdDM19ERUZB
VUxUX1BST1BFUlRJRVM7DQo+ID4gPiArDQo+ID4gPiArCXByb3BlcnRpZXMgPSBvZl9kZXZpY2Vf
Z2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gPiA+ICsJaWYgKG9mX2RtYV9pc19jb2hlcmVudChwZGV2
LT5kZXYub2Zfbm9kZSkgJiYgcHJvcGVydGllcykNCj4gPg0KPiA+IFdoeSBkbyB3ZSBuZWVkIHRo
ZSBjaGVjayBvZl9kbWFfaXNfY29oZXJlbnQoKSBoZXJlPyBJcyB0aGlzIHNwZWNpZmljIHRvDQo+
ID4geW91ciBwbGF0Zm9ybSB0byBkZXRlcm1pbmUgd2hldGhlciBzZXQgZ3NidXNjZmcwX3JlcWlu
Zm8gb25seT8NCj4gDQo+IEkgcmVtZW1iZXIgc29tZW9uZSdzIHJldmlldyBmZWVkYmFjay4gQW55
d2F5LCAweDIyMjIgd29ya3MgZm9yIGJvdGguDQo+IA0KDQpZZXMuIEkgYmVsaWV2ZSBnYXZlIGEg
cmV2aWV3IGZlZWRiYWNrIG9uIHRoYXQgaGVyZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXVzYi8yMDI0MDYxMDIwMjE0OC55YW11NGFjZXpzaWp2cGs3QHN5bm9wc3lzLmNvbS8NCg0K
VGhpcyBjaGVjayBzaG91bGQgYmUgcGxhdGZvcm0gc3BlY2lmaWMgYW5kIG5vdCBhIGdlbmVyYWwg
Y2hlY2sgYXMgYmVpbmcNCmRvbmUgaGVyZS4gVGhlcmUgd2lsbCBiZSBvdGhlciBwcm9wZXJ0aWVz
IGhlcmUgd2hlcmUgdGhhdCBjaGVjayB3b24ndA0KYmUgYXBwbGljYWJsZS4NCg0KV2lsbCB0aGVy
ZSBiZSBhIGNhc2Ugd2hlcmUgdGhlIGRtYSBjb2hlcmVudCBpcyBzZXQgZGlmZmVyZW50bHkgZm9y
IHRoZQ0Kc2FtZSBjb21wYXRpYmxlIHN0cmluZz8NCg0KUmVnYXJkbGVzcywgSSB0aGluayB3ZSBz
aG91bGQgbm90IGhhdmUgdGhhdCBjaGVjayBoZXJlLg0KDQpUaGFua3MsDQpUaGluaA==

