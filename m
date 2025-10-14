Return-Path: <linux-kernel+bounces-853480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B7BDBC38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DE1921240
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D82E1EFF;
	Tue, 14 Oct 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XPZEjUsO";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FkJ5uO/w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iUdWGiew"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233321465B4;
	Tue, 14 Oct 2025 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483843; cv=fail; b=ksmOBRKVHdzQoAn0cvwo8ZBy+l8qBY84n5Z1pS4gXbzEJeX7Sp1qkBRmmpGpxzfhW7NH2Ar5q/AmSDoNixX44NV9m09IgSXsOvcBxlSgBlQ4mdr2sUMuM4D6ItQV5awGpdHJsfV0LiGQejIt83qwQI5ZhTIWSIiXU+Eob2tptt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483843; c=relaxed/simple;
	bh=bFsUl9CP1hzD3Nb0l9UY8F2BGx1nNWjuzyKpbSA8isQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4EeljEImZ9dnMd3GhexrBUiUCEyaURfm4jYT23bWUGlCLEmkERQD4bi53rGjF3NuuN8ORDRdXY8iY73BrGJEW+atw21CpGNwWz8hI6jsewhIUs+6qShS3IJ+djaihjTvnqe84a4ncujRshSOynZluoQYC+85psvJsxDAXsRT+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XPZEjUsO; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FkJ5uO/w; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iUdWGiew reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EHi607001987;
	Tue, 14 Oct 2025 16:16:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=bFsUl9CP1hzD3Nb0l9UY8F2BGx1nNWjuzyKpbSA8isQ=; b=
	XPZEjUsOe34Qi83n7avTF61rVpEs01cfJ/5ZYplxhkIPbJH/NswIPEXyFIeBiV+8
	Vit7nSeJ+eKPEYHND4AWM/JLOjWMAHsV4P9J0ptXhl3jJZ6/FYEh0aDOwRfbSibk
	/X/bTgXLmEzlLDVfnu4VBpuADe2f1qYTEp0UI+drKk7X41nLeqvoA0TUH8EMyoYE
	xXhuuQyF7TtMXHgg6nZFBZdM1PrC0wqPj+IXI6WE80jJhjW7M0S3yqgk6ltaLd1Z
	UjV4SpcMsy9G2GtxyaAJn2zGPwVfWt8DKhLCAt2j0BjkECmPV9tbuDVpysM/4Oqh
	5+8EXx/vzTxun2lc7wkLYQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49qp8j793t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1760483809; bh=bFsUl9CP1hzD3Nb0l9UY8F2BGx1nNWjuzyKpbSA8isQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=FkJ5uO/wQzrxOS1xP7cp5Yt1K3MMnfgO3dufnMeXXAmBRbDfq2bqVYd2kqbOgx02f
	 EY7aMKnvmiosCmef+dbrbKbzzagqlNGChlpxs2Ae6CjiWnoEz3meLkhVwYCRCXbOVa
	 1OYLCrZptUESTSgnWwh9few8XBa2qsB848fwyrCakXLw0wF1dGvQWG15kTWl+zQfin
	 /gSWQnFsL97gM9AFDUSmafMz/0KKz0N2YhJqMZyO00kVzbQeyCIvjt2kX45P/iadxs
	 2m+4+lajdTEGGubZPAX22Te0cB+/KBOeCHVNXnqvRz5plMzgM8yI8qp5QxWrJ3IDsr
	 wPYTCWYZjUALw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 285424013E;
	Tue, 14 Oct 2025 23:16:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D38A5A00A6;
	Tue, 14 Oct 2025 23:16:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=iUdWGiew;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00400.outbound.protection.outlook.com [40.93.13.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1FAA8401F3;
	Tue, 14 Oct 2025 23:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2zzE9YII2NDV76/JUDRefc4nYhap5DcSS8k3/AExoZE+leNV+bWxyY4i7Ztxm8XvallFgJnXYfNY67soStLZOYropcvHzw4axzL8yhg6T1sNJ+FIFuVBFNRy0NZ7qPeryIqhW+CE2eCP49Bf0ZO6P5GudZcx//uRGPGGwTbO3j3ulfY99HwEh9Ao4M9Gc/MSGxaKmim6euV7o1j7eMZ3rcusmZZN9DsVJKj2xCbdCJmPgtz8v859uadX41uypT2aSrH5fRuzHM/9JzY1Qaiz2WLjW2KqtF+gNHsOi0vPy25VerOtLpWDtYj0D5eu7l+R6KCSttSrsedlWcUIpRdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFsUl9CP1hzD3Nb0l9UY8F2BGx1nNWjuzyKpbSA8isQ=;
 b=YXiIW+7SvB5A/DEPGvGxvGpZfkGSIlTDR1eYDyF2ci6JTzlWmYy2MwqkVRJYmbKFBciibt52S3uSEBLiQprV4sCOTqNC7SLXfU4jtoFxiKCDxPU7a6v4XqwBxiSRcHMRnRRdtg9tLNXFdLITEkRfRvVzU3M9aYmTlU//yUxmDfXkwrOsdvmihNgHwp0SaMUQbB+PPsc8ZyHEPb+hZtJegZqm+qmyD9p0OzPqcqmJibbOCfT2+Yka1bCJLkpBo32nx7wZ8AIdAy5PhaDJnd4MkizgnGXaH9UyLnGb2OdCQ69KAZxc97VGs6T6XZU9Dms2L7B/jelJ95QA7gJOOu5llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFsUl9CP1hzD3Nb0l9UY8F2BGx1nNWjuzyKpbSA8isQ=;
 b=iUdWGiewDAOi6o7DYXQK/zf7W2A0vm62X6IpbxlBcfb7L/maMKPfmNWcwK4lpPXRy1a8CJTFx/xErWpChtI9C5QCyXyZk2soXBtsdzsYxOneIA4KGZ808bmmN0OvsYei5tb80cunS49X+3Vg/FiyNa9reMxksRRANG/ovGmx4Ag=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 23:16:40 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 23:16:40 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Sven Peter <sven@kernel.org>
CC: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] usb: dwc3: glue: Allow more fine grained control over
 mode switches
Thread-Topic: [PATCH 4/5] usb: dwc3: glue: Allow more fine grained control
 over mode switches
Thread-Index: AQHcPFsG+eeLfKvduk6tyzSxMjreibTCSHgA
Date: Tue, 14 Oct 2025 23:16:40 +0000
Message-ID: <20251014231638.3tzfzjxg3x2kpeun@synopsys.com>
References: <20251013-b4-aplpe-dwc3-v1-0-12a78000c014@kernel.org>
 <20251013-b4-aplpe-dwc3-v1-4-12a78000c014@kernel.org>
In-Reply-To: <20251013-b4-aplpe-dwc3-v1-4-12a78000c014@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW3PR12MB4475:EE_
x-ms-office365-filtering-correlation-id: 0023cd71-9f96-439e-85d0-08de0b77bb47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlphQTlXZXhranFCamZnM2paZXExSHlXSk0yN2hjNUQvcXdHcFBTOWJ5ZEJn?=
 =?utf-8?B?OSt4cTF6c1pFZ1JmR3dVRCs3N2pLUDMwUkdRaklqRnhROVJnQ1J5QmRrcUk1?=
 =?utf-8?B?eFlkMmRjUGFTUjZaelNjRFVqZUxMVGhYb1lFcld5QnlQSzBVZWtpSFhQVmVJ?=
 =?utf-8?B?MmFWY0FPd28wQ1NicXI4MmRMVE5kYk9vMlAraUt1UTVwTllCZGNlTUU3c3NO?=
 =?utf-8?B?eUlBNVlJam0walB6bSttNHdvOVdDRzBsS2g1WW91MGUyc0M1OXJwYXhHdDVj?=
 =?utf-8?B?MFZlY0pLYXlNY0tSNVArWlN2dWFtVWpHR3JsSVFDQ0x0YnZGZ2FjR2NIOXJX?=
 =?utf-8?B?RzAvWHpJWlFQWUJHdThRNU12Q1dpdXA1d21ydU9Wc1dUVkpkWUpVWGZ6K3Vs?=
 =?utf-8?B?NmJLcS92a2xYdTlRd1M3cWpEOXBqZnVNT01NOFI1RnlXczQxK25GUElMVGw4?=
 =?utf-8?B?OXRCM2lvd3JMZGNNOUNkSXcwUHN1NDlIeXd5R204bGRNSU5EVzE5a2x6V3R2?=
 =?utf-8?B?VzIxV0pYRVB3b3NXdFN6VGdRUDdab0FxOGpYQS8zTXJXKy9DV1dYYlVyRG9y?=
 =?utf-8?B?bWcyMDNac2hJTzF6dktqS1JNbmZ4bStqT3VHRHRYZnNad3hPVGo0S0p3Vmg3?=
 =?utf-8?B?U2dvU2FPcncxeFpPa1JDVndVcjlvZHNrK1RhUmx0K3VFcWlXYVphdU45ZDlI?=
 =?utf-8?B?VmNYV0lGdVJacFNocTYwem1tWkI5eCtsMVA1VHRiU1BmbVorY2d2YXMxYnpU?=
 =?utf-8?B?bTQ2ZWpzZWR4RHVJQS9scmMwS3ZkL1o5eU42NTNzaEFFaTg5ZCtqK3hjYXNz?=
 =?utf-8?B?ME9KQzZROFZwMU55REwwYzQ1eUF0TGJza3p5V3lpNE1Cd0lsT21LRENaKzh0?=
 =?utf-8?B?L21nWS9XNUtyZW4yVDNONk5lU3R6NFB6T0NWWXhwQzdKNXUyY2VaZmRBRzdj?=
 =?utf-8?B?OXFnZS9GNytXVTR6OFFoR0FUSFF0M3R6RFlYTGxlV1lzS1JTM3lDeDFhZnc3?=
 =?utf-8?B?M1luYllDT1lMM0ZMcSs5VGRiU1gyV0tvVFlOcEQ1ZFBWRGJvZGpWUWdOUlRC?=
 =?utf-8?B?YWRlZFBKakJVZEdXSFR4K1hWbTNvNXkzeDd0VXdEUGR0QnRGRFNmL1NVZjhn?=
 =?utf-8?B?QjNmTjBHRDdUenFWUTF3NFp0ZmIwZ2h2MXBSN2hITC9pS2E3Tno1TDJMSC83?=
 =?utf-8?B?WnhXcFh0eTVCMElkNWxCNFVhdlcrUWszQVBhd0MyaWE1a1Jpb3p3QzY2UEVt?=
 =?utf-8?B?L3A5UzBqeGZyVUFvVGlCN3U4RHRxc1QwSVBMMmtoRTBKSGNvRHU4NzhJZjVl?=
 =?utf-8?B?eCtXNlMrZkZCZkhWOW1sTCt4UE9VZnJkR2NaaDFJRitHMjVTcTBaVzBUUWlo?=
 =?utf-8?B?QUVOZGdIZ3Y3REdoVEFDRjNaZ2R0YVVSSjlkWTh6cm1SVEdrRU04NVlQdXR0?=
 =?utf-8?B?enFaUlBUN3EyN3NpRVVhWVZ0Y0dZb2dqbTI0MjlBUGxRWlZQRXczN0ZIVWxa?=
 =?utf-8?B?dGZuamdzcldKZXE5YjdxVWxYN3lrUUtRTnlHOUt1aXdRa280VDZhVHdrZnVR?=
 =?utf-8?B?RHhDSnozMmpUMEp1Q2tleE9pQURsd1BmbGV6QnBpM2ZySERSZjE2Smh1TmFX?=
 =?utf-8?B?YzFEU1gyb291RGV6bTlhUEJsYkZKUVJpcEtVbGFhWndadmxlZVpBeTRDQkxm?=
 =?utf-8?B?Rm5NTkordnlNSXo2ZkNobUk3WXFHRS9rQUxKOUVuRjJ2MWdPTjA3RHhka2lX?=
 =?utf-8?B?WENnU0dzbEZpVzJRcGltQ1FWUCtKaHZhN0F2cXAvYldBaWtmNUR6VGV2VjhB?=
 =?utf-8?B?NDcwclUvQ2NrTjJhMVBxL0NmRlVMeUtveG5ra0RwbmMwYjVqTXNIN1lSS0lY?=
 =?utf-8?B?SkZueFVXTlhwTStNeWRlRC9rUXlEYS9uanpZZHRxbjBuV2JuQlR4OHByMXRa?=
 =?utf-8?B?d2dqcGRYSUxZNFZReko4Y3paV0IvakRCdXRBTDNNK1FtTmticEg3bVVzZVN5?=
 =?utf-8?B?Y3ZYQXFtSm05ME1VdTRUK1NrUXZSQ2NxQUkyRWI1TlRZaHpxd0MzUTIvTGsz?=
 =?utf-8?Q?ls6pYR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UW95bG9RcEFQaGJMcUtYZHdzV1ZmUTB0OXVlQllLTjQ1M1pKNllxU3lZbHlX?=
 =?utf-8?B?V0ZNbEpDdWUyN0V4cFhCcmt0NWpuQlZXZmxIMnRDeng4UUxhNXl2YmNMU1Vp?=
 =?utf-8?B?ZDlGamI3K0hJdzhmV0xsM0E3dkNMMHJSckptcmd5a1pza1pyaWlKUEQyLzFF?=
 =?utf-8?B?akZ2b3FCZ3plSFdLRy9jUk9YMm5yYjk5dkF2RThWQ0VOcEZ6UEhON3R4Vllk?=
 =?utf-8?B?Zmk1TmRMU05HZWxSKzJOWDZiSzRPUUhKeHhnelpsdDhxVWRveXRaVUptdnhC?=
 =?utf-8?B?ZkNlRkFhT1M5bzRvOWxEbldaanR4cEhvZ1pWMFNUdEhiT1QyakxtN1l5VTZC?=
 =?utf-8?B?YjA2b2dpZUN4WU1sdXRwWVRRdVNva1VwZUk4QS8xMDVueEE3L29RdUdFU29N?=
 =?utf-8?B?K1YxZ1VwaTZwSFdleC9FV011RzJvVUdHcU5KWkZwcUo2cSt4TVhJTk9YNDI5?=
 =?utf-8?B?YzUrSWtMM3Fjb29lai9CZVVSSVB1VHRPL3hiamdXaGk1ejQxb1pVSXlJOThx?=
 =?utf-8?B?emUxcDR5K3dEWE9WT2U0aUNmVitoNGFKVTZUbGVNb3BVM1Q2bVZWRmE3NUtw?=
 =?utf-8?B?UmNFK0ZLZ2ovL0gyU0JMSHhZWWlhVEl4L1BWdkFxT2Nha0xwZHRTaGdldTRJ?=
 =?utf-8?B?N3plbHNKSzlob0dQMjV1cG5DR1Y3emUrNnF6d0hwSmVmUFEvVm8yQXFTNkZM?=
 =?utf-8?B?YVFXM29JOEpiazVOcm1QQ2lIY1RNS2dzSHlTRWtnMi80d0tQN05YZzFpSkw0?=
 =?utf-8?B?eWFsOXRodG1TaUxFVWdrc1VtYVNZb1BrblFCdVZ2U2NJeVBMZGFWMTAybGJz?=
 =?utf-8?B?NC85SUt0aGtOTktIR0RHTXRWQXVXam1tNHpaSkY4eEZlVDc4ejE0bHhSeEZS?=
 =?utf-8?B?cHJheFptOWtuNkJxSlovb1F0cDJFcURoSUdybkJROFU3ZExOMjFLQ0NpRzFi?=
 =?utf-8?B?SUF0UkY1ZktONTZncFhsM2pKYUUxTTdmWURZRG5zSjVwcmMraEVuZlVzK0dB?=
 =?utf-8?B?WW95UFVKWCtGNEF6ZnQ1OXdGa0U5dU5KR3pyd3NBbnVZaHpaY2JFUm5NUlMr?=
 =?utf-8?B?ZTB1N1BMb2VUOGVkSDRuYWZWVGlNbHpLQjIwZStjSHdwVm1HVzhuSzBmQUM2?=
 =?utf-8?B?ZnZXRThoeHNVZDZHNG5hTlBick8rSVZub21PS1NWajB2cW5nVXBOcVJuRWhx?=
 =?utf-8?B?QnVWdUJwT2V0Sys3aTVaN0xVRHY3UkRJd0NFakNMRXRDYXNRTjJPY3NpTUwv?=
 =?utf-8?B?UHFNSFQyQUtUQTIyNzBpTGZPSUduT0paTFdCbm9TbE1uaWRqekRYbm50ZlpP?=
 =?utf-8?B?VldjaHZzd1A1QWU1NFJtU0dlcnhyUk5kZi9reFBrUG9xeHVYV2NDak9tQ0xL?=
 =?utf-8?B?UVh0MkYxU2hOejJJenRvNDRuWFJJVlp4cmpIU3l3ZnZWc1FmZS9SbXg1aCsw?=
 =?utf-8?B?TFV6VitjV2ppMG1SNUF5cnN2YXZ1NTZMQ09DTXFvaHlUN210RzdHL0svZ1dj?=
 =?utf-8?B?QWd0VHU4SXR0SnE3M3BzVldjMktLTDVKZy9wRVJQOTczS2lFRndvZFdlWWd4?=
 =?utf-8?B?NHRFN2ZyZ0U0a2xKR2paZERYMlFMZTZoSGV5SVF0ZlVnYXdLcEViVmw3TFdQ?=
 =?utf-8?B?WGIxbFB6alhuL1JvVWZmdmFMWiszQ1U5NjF5TUgrVkNjV2YrTjhSSk1xdnpY?=
 =?utf-8?B?YkVFM3UzWEJ2bUwyenpsYiszOHRJRGhGaGc5NUFjOWdNN1N6TXBZUGorejcv?=
 =?utf-8?B?eTZQczVQem8xSEZFYy9Ha0xUT2tzSzQ3OEE5SllJMXdTVzdJN1pTc0JNUm5F?=
 =?utf-8?B?RzJzdnA0UEd1TU11ek9EckkyT05uQmQ3d2FySmc0TWo2TDFSckdiWWhROUZX?=
 =?utf-8?B?NFVBdS90TjhsK3lrZzhJUHdGaTJQeW1MZ2JiZkN5WUJiWVZDbjZ0TExDRjJQ?=
 =?utf-8?B?K3FmbnNYaWowNnZpek9JSkV6dUNqRUpBdVgyTnV6RXFLaHByVUtQOWN5MHJB?=
 =?utf-8?B?d0xNK1NoK005QXFMUXcvckU5emt3TkpmNkNNbzVhOFFRUUxmZDZSNFpOTXhs?=
 =?utf-8?B?eHBPeVV0SzN5aXpUNy81a3NFMTAyMGsvcXFGV0k2b0o1c2FQMkc1ZTZhYXh5?=
 =?utf-8?Q?wHdGxF22Tm9AiPHeUUC+KlRu8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F99060F48D1048458DF8C6069C3C708B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n2Lq51qlZ6n1c7e4Yf4xFzgvRrDwtyTfFhWWS5ZBo/H0OxKnMWJMBW26M+W3MzC/adCSU8G97Ul6SfB3y/DcS2YAp2EUOsAq9ucK4u5WCPAYfqtDOkvDJmfsHqcS5LRZDbwY8UwpZl9F90DQTyyPSJbCoYpOB3qkfN8OMbpJE0LGGKAdzzf628z5xqUQ1Jeg9u8gk0OYSlWJrEPmC1aJJ0xI6iQBcMP8XfYcinVK6MK0ZD4AiEJOFeZRYNFDk1fq9SNNcAWoyuP0SJUUxA6TmZMA8dY4BR4Y4yxNTzNz8CWoR1gSqHY0hLfQMk1HWEPY4Dggg31+KapffwSYzZ/xXIAnIAsZa8YuhpztjnnrQEJzfXFoxx8kQ7E60Lw8AuAH7M5R1G67mfVD8Xs4GBeWSDoa7KQPqN8Kq53k6bYyRfQTWOnKpFYGHoFCx+YkXEVmOemvDYjHKYYUwbDUARVA6QySocXfhpIIg5TbHf0lRR+BgsFddc6oVCvtyBOPD0obftGA7cn3Mf3B9HnuHHH9nhU31vbI2vOSDa4q6vwlEkO+iZ+7qdxD9OsxVIdPiCttt0OfK4+6ciY69AmP+rf/yyGdu2jMo1DJRFeuyutmLM2SsVj99A4KWWbYqEQrUV8ECBBEDK5H1qXV6yI16PjHdg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0023cd71-9f96-439e-85d0-08de0b77bb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 23:16:40.3921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/iC3xZBSmef1EqpTOpzLsvI3YKgL21vVyiNuC+tzjg5qxVGZ/1vSuYNzKPeVmdUZ+YyVIIjdnqEDpLdeyzFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
X-Authority-Analysis: v=2.4 cv=BN++bVQG c=1 sm=1 tr=0 ts=68eed9e1 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=TLqKX67tqBmp35jvi-AA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA2MiBTYWx0ZWRfX5QWINenkIPdX
 yRudsxxuPhlfjSK3tMIRS5V1jIN0e/3Qa2Pt1RY5+wPaDN3e+Z/teIv5zP3mHfIwl3n9HXaNMFJ
 3kIL6l7DKHn2qHufmR/UqbwjxT0Yodo8Ff/ZhSqMTeZcKzyYQIKd3B4XsVKug8WS5bOFvoK7Uwq
 S416AqlCjM7f1UL7bhSUclULXhj5F64yTjyv6Vf0/LTvi3QqZ6BL8L8Vp4yi9wI19ZyYdiUehvg
 XOm9CQsVUFMOt4XiaMCfEGCfEkE8ys+P2ERZT9qGZ7fO0mlLXpCvyywOICRJWAghG/rMqvhxCWg
 L6zdRLNunZgsq7yomx7U2lKx6DFtnJJslDcJVSUnYuIItGV7O9Zg8bu3ctcYZEj52otX/WCmlMl
 thHHvuPtR16BH3ZoZ6WrkNKRruAhug==
X-Proofpoint-ORIG-GUID: OpBQNBGasE3SpBpnczFDvKQ3TLLxNGOR
X-Proofpoint-GUID: OpBQNBGasE3SpBpnczFDvKQ3TLLxNGOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2510020000 definitions=main-2510110062

T24gTW9uLCBPY3QgMTMsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IFdlIG5lZWQgZmluZSBn
cmFpbmVkIGNvbnRyb2wgb3ZlciBtb2RlIHN3aXRjaGVkIG9uIHRoZSBEV0MzIGNvbnRyb2xsZXIN
Cj4gcHJlc2VudCBvbiBBcHBsZSBTaWxpY29uLiBFeHBvcnQgY29yZSwgaG9zdCBhbmQgZ2FkZ2V0
IGluaXQgYW5kIGV4aXQsDQo+IHB0cmNhcCBhbmQgc3VzcGh5IGNvbnRyb2wgZnVuY3Rpb25zLiBB
bHNvIGludHJvZHVjZSBhbiBhZGRpdGlvbmFsDQo+IHBhcmFtZXRlciB0byBwcm9iZV9kYXRhIHRo
YXQgYWxsb3dzIHRvIHNraXAgdGhlIGZpbmFsIGluaXRpYWxpemF0aW9uDQo+IHN0ZXAgdGhhdCB3
b3VsZCBicmluZyB1cCBob3N0IG9yIGdhZGdldCBtb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
U3ZlbiBQZXRlciA8c3ZlbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jICAgfCAgMTYgKysrKystLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8ICAg
MiArDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dsdWUuaCAgIHwgMTE2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvaG9zdC5j
ICAgfCAgIDIgKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMzEgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGFlMTQwYzM1NjI5NWMwM2RmMzk4MmZmNGZh
OTVmODYzODI5NmU1MmQuLjUyNmMwNDUzYjk5YWFkNzlkOTlhODQyNzk3ZTUyZDkyOTA0NTZkNzYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+IEBAIC0xMzIsNiArMTMyLDcgQEAgdm9pZCBkd2MzX2VuYWJsZV9z
dXNwaHkoc3RydWN0IGR3YzMgKmR3YywgYm9vbCBlbmFibGUpDQo+ICAJCWR3YzNfd3JpdGVsKGR3
Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRyhpKSwgcmVnKTsNCj4gIAl9DQo+ICB9DQo+ICtFWFBP
UlRfU1lNQk9MX0dQTChkd2MzX2VuYWJsZV9zdXNwaHkpOw0KPiAgDQo+ICB2b2lkIGR3YzNfc2V0
X3BydGNhcChzdHJ1Y3QgZHdjMyAqZHdjLCB1MzIgbW9kZSwgYm9vbCBpZ25vcmVfc3VzcGh5KQ0K
PiAgew0KPiBAQCAtMTU4LDYgKzE1OSw3IEBAIHZvaWQgZHdjM19zZXRfcHJ0Y2FwKHN0cnVjdCBk
d2MzICpkd2MsIHUzMiBtb2RlLCBib29sIGlnbm9yZV9zdXNwaHkpDQo+ICAJZHdjLT5jdXJyZW50
X2RyX3JvbGUgPSBtb2RlOw0KPiAgCXRyYWNlX2R3YzNfc2V0X3BydGNhcChtb2RlKTsNCj4gIH0N
Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfc2V0X3BydGNhcCk7DQo+ICANCj4gIHN0YXRpYyB2
b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICB7DQo+IEBA
IC05NzUsNyArOTc3LDcgQEAgc3RhdGljIHZvaWQgZHdjM19jbGtfZGlzYWJsZShzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkd2MtPmJ1c19jbGspOw0KPiAgfQ0K
PiAgDQo+IC1zdGF0aWMgdm9pZCBkd2MzX2NvcmVfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAr
dm9pZCBkd2MzX2NvcmVfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCWR3YzNfZXZl
bnRfYnVmZmVyc19jbGVhbnVwKGR3Yyk7DQo+ICAJZHdjM19waHlfcG93ZXJfb2ZmKGR3Yyk7DQo+
IEBAIC05ODMsNiArOTg1LDcgQEAgc3RhdGljIHZvaWQgZHdjM19jb3JlX2V4aXQoc3RydWN0IGR3
YzMgKmR3YykNCj4gIAlkd2MzX2Nsa19kaXNhYmxlKGR3Yyk7DQo+ICAJcmVzZXRfY29udHJvbF9h
c3NlcnQoZHdjLT5yZXNldCk7DQo+ICB9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChkd2MzX2NvcmVf
ZXhpdCk7DQo+ICANCj4gIHN0YXRpYyBib29sIGR3YzNfY29yZV9pc192YWxpZChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiAgew0KPiBAQCAtMTMyOCw3ICsxMzMxLDcgQEAgc3RhdGljIHZvaWQgZHdjM19j
b25maWdfdGhyZXNob2xkKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAgKg0KPiAgICogUmV0dXJucyAw
IG9uIHN1Y2Nlc3Mgb3RoZXJ3aXNlIG5lZ2F0aXZlIGVycm5vLg0KPiAgICovDQo+IC1zdGF0aWMg
aW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICtpbnQgZHdjM19jb3JlX2lu
aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAl1bnNpZ25lZCBpbnQJCWh3X21vZGU7DQo+
ICAJdTMyCQkJcmVnOw0KPiBAQCAtMTUyOCw2ICsxNTMxLDcgQEAgc3RhdGljIGludCBkd2MzX2Nv
cmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4g
K0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfY29yZV9pbml0KTsNCj4gIA0KPiAgc3RhdGljIGludCBk
d2MzX2NvcmVfZ2V0X3BoeShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiBAQCAtMjI5OSw5ICsy
MzAzLDExIEBAIGludCBkd2MzX2NvcmVfcHJvYmUoY29uc3Qgc3RydWN0IGR3YzNfcHJvYmVfZGF0
YSAqZGF0YSkNCj4gIAlkd2MzX2NoZWNrX3BhcmFtcyhkd2MpOw0KPiAgCWR3YzNfZGVidWdmc19p
bml0KGR3Yyk7DQo+ICANCj4gLQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9tb2RlKGR3Yyk7DQo+IC0J
aWYgKHJldCkNCj4gLQkJZ290byBlcnJfZXhpdF9kZWJ1Z2ZzOw0KPiArCWlmICghZGF0YS0+c2tp
cF9jb3JlX2luaXRfbW9kZSkgew0KPiArCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9tb2RlKGR3Yyk7
DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlnb3RvIGVycl9leGl0X2RlYnVnZnM7DQo+ICsJfQ0KPiAg
DQo+ICAJcG1fcnVudGltZV9wdXQoZGV2KTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggNmYx
OGI0ODQwYTI1ZDE3NmFiYjQxMzQ1ODFhZDBjZTY4YmExOWZmYy4uMWY2N2ZiNmFlYWQ1NzI1YzJl
N2I1NTNjNjM1ZWFiOTg1YzllMWQ0OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC00ODEwLDYg
KzQ4MTAsNyBAQCBpbnQgZHdjM19nYWRnZXRfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgZXJy
MDoNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoZHdjM19nYWRn
ZXRfaW5pdCk7DQo+ICANCj4gIC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovDQo+ICANCj4gQEAgLTQ4
MjgsNiArNDgyOSw3IEBAIHZvaWQgZHdjM19nYWRnZXRfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiAgCWRtYV9mcmVlX2NvaGVyZW50KGR3Yy0+c3lzZGV2LCBzaXplb2YoKmR3Yy0+ZXAwX3RyYikg
KiAyLA0KPiAgCQkJICBkd2MtPmVwMF90cmIsIGR3Yy0+ZXAwX3RyYl9hZGRyKTsNCj4gIH0NCj4g
K0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfZ2FkZ2V0X2V4aXQpOw0KPiAgDQo+ICBpbnQgZHdjM19n
YWRnZXRfc3VzcGVuZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9nbHVlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2dsdWUuaA0KPiBpbmRleCA3
ZjMyNmNmZjEyNDU4OTAxOTA0ZDRjMzJmNjJlZDkzNTdkMGY2ZTNiLi4zNzZlN2FhNzQyODFjMTNi
ZmIzYTg1ZGMwMzM2MjJiY2ZmOGQyYWNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L2dsdWUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dsdWUuaA0KPiBAQCAtMTUsMTEgKzE1
LDE0IEBADQo+ICAgKiBAcmVzOiByZXNvdXJjZSBmb3IgdGhlIERXQzMgY29yZSBtbWlvIHJlZ2lv
bg0KPiAgICogQGlnbm9yZV9jbG9ja3NfYW5kX3Jlc2V0czogY2xvY2tzIGFuZCByZXNldHMgZGVm
aW5lZCBmb3IgdGhlIGRldmljZSBzaG91bGQNCj4gICAqCQliZSBpZ25vcmVkIGJ5IHRoZSBEV0Mz
IGNvcmUsIGFzIHRoZXkgYXJlIG1hbmFnZWQgYnkgdGhlIGdsdWUNCj4gKyAqIEBza2lwX2NvcmVf
aW5pdF9tb2RlOiBTa2lwIHRoZSBmaW5pYWwgaW5pdGlhbGl6YXRpb24gb2YgdGhlIHRhcmdldCBt
b2RlLCBhcw0KPiArICoJCWl0IG11c3QgYmUgbWFuYWdlZCBieSB0aGUgZ2x1ZQ0KPiAgICovDQo+
ICBzdHJ1Y3QgZHdjM19wcm9iZV9kYXRhIHsNCj4gIAlzdHJ1Y3QgZHdjMyAqZHdjOw0KPiAgCXN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAgCWJvb2wgaWdub3JlX2Nsb2Nrc19hbmRfcmVzZXRzOw0K
PiArCWJvb2wgc2tpcF9jb3JlX2luaXRfbW9kZTsNCj4gIH07DQo+ICANCj4gIC8qKg0KPiBAQCAt
NjAsNCArNjMsMTE3IEBAIGludCBkd2MzX3BtX3Jlc3VtZShzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4g
IHZvaWQgZHdjM19wbV9jb21wbGV0ZShzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gIGludCBkd2MzX3Bt
X3ByZXBhcmUoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICANCj4gKw0KPiArLyogQWxsIG9mIHRoZSBm
b2xsb3dpbmcgZnVuY3Rpb25zIG11c3Qgb25seSBiZSB1c2VkIHdpdGggc2tpcF9jb3JlX2luaXRf
bW9kZSAqLw0KPiArDQo+ICsvKioNCj4gKyAqIGR3YzNfY29yZV9pbml0IC0gSW5pdGlhbGl6ZSBE
V0MzIGNvcmUgaGFyZHdhcmUNCj4gKyAqIEBkd2M6IFBvaW50ZXIgdG8gRFdDMyBjb250cm9sbGVy
IGNvbnRleHQNCj4gKyAqDQo+ICsgKiBDb25maWd1cmVzIGFuZCBpbml0aWFsaXplcyB0aGUgY29y
ZSBoYXJkd2FyZSwgdXN1YWxseSBkb25lIGJ5IGR3YzNfY29yZV9wcm9iZS4NCj4gKyAqIFRoaXMg
ZnVuY3Rpb24gaXMgcHJvdmlkZWQgZm9yIHBsYXRmb3JtcyB0aGF0IHVzZSBza2lwX2NvcmVfaW5p
dF9tb2RlIGFuZCBuZWVkDQo+ICsgKiB0byBmaW5hbGl6ZSB0aGUgY29yZSBpbml0aWFsaXphdGlv
biBhZnRlciBzb21lIHBsYXRmb3JtLXNwZWNpZmljIHNldHVwLg0KPiArICogSXQgbXVzdCBvbmx5
IGJlIGNhbGxlZCB3aGVuIHVzaW5nIHNraXBfY29yZV9pbml0X21vZGUgYW5kIGJlZm9yZQ0KPiAr
ICogZHdjM19ob3N0X2luaXQgb3IgZHdjM19nYWRnZXRfaW5pdC4NCj4gKyAqDQo+ICsgKiBSZXR1
cm46IDAgb24gc3VjY2VzcywgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlDQo+ICsgKi8N
Cj4gK2ludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gKw0KPiArLyoqDQo+
ICsgKiBkd2MzX2NvcmVfZXhpdCAtIFNodXQgZG93biBEV0MzIGNvcmUgaGFyZHdhcmUNCj4gKyAq
IEBkd2M6IFBvaW50ZXIgdG8gRFdDMyBjb250cm9sbGVyIGNvbnRleHQNCj4gKyAqDQo+ICsgKiBE
aXNhYmxlcyBhbmQgY2xlYW5zIHVwIHRoZSBjb3JlIGhhcmR3YXJlIHN0YXRlLiBUaGlzIGlzIHVz
dWFsbHkgaGFuZGxlZA0KPiArICogaW50ZXJuYWxseSBieSBkd2MzIGFuZCBtdXN0IG9ubHkgYmUg
Y2FsbGVkIHdoZW4gdXNpbmcgc2tpcF9jb3JlX2luaXRfbW9kZQ0KPiArICogYW5kIG9ubHkgYWZ0
ZXIgZHdjM19jb3JlX2luaXQuIEFmdGVyd2FyZHMsIGR3YzNfY29yZV9pbml0IG1heSBiZSBjYWxs
ZWQNCj4gKyAqIGFnYWluLg0KPiArICovDQo+ICt2b2lkIGR3YzNfY29yZV9leGl0KHN0cnVjdCBk
d2MzICpkd2MpOw0KPiArDQo+ICsvKioNCj4gKyAqIGR3YzNfaG9zdF9pbml0IC0gSW5pdGlhbGl6
ZSBob3N0IG1vZGUgb3BlcmF0aW9uDQo+ICsgKiBAZHdjOiBQb2ludGVyIHRvIERXQzMgY29udHJv
bGxlciBjb250ZXh0DQo+ICsgKg0KPiArICogSW5pdGlhbGl6ZXMgdGhlIGNvbnRyb2xsZXIgZm9y
IFVTQiBob3N0IG1vZGUgb3BlcmF0aW9uLCB1c3VhbGx5IGRvbmUgYnkNCj4gKyAqIGR3YzNfY29y
ZV9wcm9iZSBvciBmcm9tIHdpdGhpbiB0aGUgZHdjMyBVU0Igcm9sZSBzd2l0Y2ggY2FsbGJhY2su
DQo+ICsgKiBUaGlzIGZ1bmN0aW9uIGlzIHByb3ZpZGVkIGZvciBwbGF0Zm9ybXMgdGhhdCB1c2Ug
c2tpcF9jb3JlX2luaXRfbW9kZSBhbmQgbmVlZA0KPiArICogdG8gZmluYWxpemUgdGhlIGhvc3Qg
aW5pdGlhbGl6YXRpb24gYWZ0ZXIgc29tZSBwbGF0Zm9ybS1zcGVjaWZpYyBzZXR1cC4NCj4gKyAq
IEl0IG11c3Qgbm90IGJlIGNhbGxlZCBiZWZvcmUgZHdjM19jb3JlX2luaXQgb3Igd2hlbiBza2lw
X2NvcmVfaW5pdF9tb2RlIGlzDQo+ICsgKiBub3QgdXNlZC4gSXQgbXVzdCBhbHNvIG5vdCBiZSBj
YWxsZWQgd2hlbiBnYWRnZXQgb3IgaG9zdCBtb2RlIGhhcyBhbHJlYWR5DQo+ICsgKiBiZWVuIGlu
aXRpYWxpemVkLg0KPiArICoNCj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBl
cnJvciBjb2RlIG9uIGZhaWx1cmUNCj4gKyAqLw0KPiAraW50IGR3YzNfaG9zdF9pbml0KHN0cnVj
dCBkd2MzICpkd2MpOw0KPiArDQo+ICsvKioNCj4gKyAqIGR3YzNfaG9zdF9leGl0IC0gU2h1dCBk
b3duIGhvc3QgbW9kZSBvcGVyYXRpb24NCj4gKyAqIEBkd2M6IFBvaW50ZXIgdG8gRFdDMyBjb250
cm9sbGVyIGNvbnRleHQNCj4gKyAqDQo+ICsgKiBEaXNhYmxlcyBhbmQgY2xlYW5zIHVwIGhvc3Qg
bW9kZSByZXNvdXJjZXMsIHVzdWFsbHkgZG9uZSBieQ0KPiArICogdGhlIGR3YzMgVVNCIHJvbGUg
c3dpdGNoIGNhbGxiYWNrIGJlZm9yZSBzd2l0Y2hpbmcgY29udHJvbGxlciBtb2RlLg0KPiArICog
SXQgbXVzdCBvbmx5IGJlIGNhbGxlZCB3aGVuIHNraXBfY29yZV9pbml0X21vZGUgaXMgdXNlZCBh
bmQgb25seSBhZnRlcg0KPiArICogZHdjM19ob3N0X2luaXQuDQo+ICsgKi8NCj4gK3ZvaWQgZHdj
M19ob3N0X2V4aXQoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICsNCj4gKy8qKg0KPiArICogZHdjM19n
YWRnZXRfaW5pdCAtIEluaXRpYWxpemUgZ2FkZ2V0IG1vZGUgb3BlcmF0aW9uDQo+ICsgKiBAZHdj
OiBQb2ludGVyIHRvIERXQzMgY29udHJvbGxlciBjb250ZXh0DQo+ICsgKg0KPiArICogSW5pdGlh
bGl6ZXMgdGhlIGNvbnRyb2xsZXIgZm9yIFVTQiBnYWRnZXQgbW9kZSBvcGVyYXRpb24sIHVzdWFs
bHkgZG9uZSBieQ0KPiArICogZHdjM19jb3JlX3Byb2JlIG9yIGZyb20gd2l0aGluIHRoZSBkd2Mz
IFVTQiByb2xlIHN3aXRjaCBjYWxsYmFjay4gVGhpcw0KPiArICogZnVuY3Rpb24gaXMgcHJvdmlk
ZWQgZm9yIHBsYXRmb3JtcyB0aGF0IHVzZSBza2lwX2NvcmVfaW5pdF9tb2RlIGFuZCBuZWVkIHRv
DQo+ICsgKiBmaW5hbGl6ZSB0aGUgZ2FkZ2V0IGluaXRpYWxpemF0aW9uIGFmdGVyIHNvbWUgcGxh
dGZvcm0tc3BlY2lmaWMgc2V0dXAuDQo+ICsgKiBJdCBtdXN0IG5vdCBiZSBjYWxsZWQgYmVmb3Jl
IGR3YzNfY29yZV9pbml0IG9yIHdoZW4gc2tpcF9jb3JlX2luaXRfbW9kZSBpcw0KPiArICogbm90
IHVzZWQuIEl0IG11c3QgYWxzbyBub3QgYmUgY2FsbGVkIHdoZW4gZ2FkZ2V0IG9yIGhvc3QgbW9k
ZSBoYXMgYWxyZWFkeQ0KPiArICogYmVlbiBpbml0aWFsaXplZC4NCj4gKyAqDQo+ICsgKiBSZXR1
cm46IDAgb24gc3VjY2VzcywgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlDQo+ICsgKi8N
Cj4gK2ludCBkd2MzX2dhZGdldF9pbml0KHN0cnVjdCBkd2MzICpkd2MpOw0KPiArDQo+ICsvKioN
Cj4gKyAqIGR3YzNfZ2FkZ2V0X2V4aXQgLSBTaHV0IGRvd24gZ2FkZ2V0IG1vZGUgb3BlcmF0aW9u
DQo+ICsgKiBAZHdjOiBQb2ludGVyIHRvIERXQzMgY29udHJvbGxlciBjb250ZXh0DQo+ICsgKg0K
PiArICogRGlzYWJsZXMgYW5kIGNsZWFucyB1cCBnYWRnZXQgbW9kZSByZXNvdXJjZXMsIHVzdWFs
bHkgZG9uZSBieQ0KPiArICogdGhlIGR3YzMgVVNCIHJvbGUgc3dpdGNoIGNhbGxiYWNrIGJlZm9y
ZSBzd2l0Y2hpbmcgY29udHJvbGxlciBtb2RlLg0KPiArICogSXQgbXVzdCBvbmx5IGJlIGNhbGxl
ZCB3aGVuIHNraXBfY29yZV9pbml0X21vZGUgaXMgdXNlZCBhbmQgb25seSBhZnRlcg0KPiArICog
ZHdjM19nYWRnZXRfaW5pdC4NCj4gKyAqLw0KPiArdm9pZCBkd2MzX2dhZGdldF9leGl0KHN0cnVj
dCBkd2MzICpkd2MpOw0KPiArDQo+ICsvKioNCj4gKyAqIGR3YzNfZW5hYmxlX3N1c3BoeSAtIENv
bnRyb2wgU1VTUEhZIHN0YXR1cyBmb3IgYWxsIFVTQiBwb3J0cw0KPiArICogQGR3YzogUG9pbnRl
ciB0byBEV0MzIGNvbnRyb2xsZXIgY29udGV4dA0KPiArICogQGVuYWJsZTogVHJ1ZSB0byBlbmFi
bGUgU1VTUEhZLCBmYWxzZSB0byBkaXNhYmxlDQo+ICsgKg0KPiArICogRW5hYmxlcyBvciBkaXNh
YmxlcyB0aGUgVVNCMyBQSFkgU1VTUEVORCBhbmQgVVNCMiBQSFkgU1VTUEhZIGZlYXR1cmUgZm9y
DQo+ICsgKiBhbGwgYXZhaWxhYmxlIHBvcnRzLg0KPiArICogVGhpcyBpcyB1c3VhbGx5IGhhbmRs
ZWQgYnkgdGhlIGR3YzMgY29yZSBjb2RlIGFuZCBzaG91bGQgb25seSBiZSB1c2VkDQo+ICsgKiB3
aGVuIHNraXBfY29yZV9pbml0X21vZGUgaXMgdXNlZCBhbmQgdGhlIGdsdWUgbGF5ZXIgbmVlZHMg
dG8gbWFuYWdlIFNVU1BIWQ0KPiArICogc2V0dGluZ3MgaXRzZWxmLCBlLmcuLCBkdWUgdG8gcGxh
dGZvcm0tc3BlY2lmaWMgcmVxdWlyZW1lbnRzIGR1cmluZyBtb2RlDQo+ICsgKiBzd2l0Y2hlcy4N
Cj4gKyAqLw0KPiArdm9pZCBkd2MzX2VuYWJsZV9zdXNwaHkoc3RydWN0IGR3YzMgKmR3YywgYm9v
bCBlbmFibGUpOw0KPiArDQo+ICsvKioNCj4gKyAqIGR3YzNfc2V0X3BydGNhcCAtIFNldCB0aGUg
VVNCIGNvbnRyb2xsZXIgUFJUQ0FQIG1vZGUNCj4gKyAqIEBkd2M6IFBvaW50ZXIgdG8gRFdDMyBj
b250cm9sbGVyIGNvbnRleHQNCj4gKyAqIEBtb2RlOiBUYXJnZXQgbW9kZSwgbXVzdCBiZSBvbmUg
b2YgRFdDM19HQ1RMX1BSVENBUF97SE9TVCxERVZJQ0UsT1RHfQ0KPiArICogQGlnbm9yZV9zdXNw
aHk6IElmIHRydWUsIHNraXAgZGlzYWJsaW5nIHRoZSBTVVNQSFkgYW5kIGtlZXAgdGhlIGN1cnJl
bnQgc3RhdGUNCj4gKyAqDQo+ICsgKiBVcGRhdGVzIFBSVENBUCBvZiB0aGUgY29udHJvbGxlciBh
bmQgY3VycmVudF9kcl9yb2xlIGluc2lkZSB0aGUgZHdjMw0KPiArICogc3RydWN0dXJlLiBGb3Ig
RFJEIGNvbnRyb2xsZXJzLCB0aGlzIGFsc28gZGlzYWJsZXMgU1VTUEhZIHVubGVzcyBleHBsaWNp
dGx5DQo+ICsgKiB0b2xkIHRvIHNraXAgdmlhIHRoZSBpZ25vcmVfc3VzcGh5IHBhcmFtZXRlci4N
Cj4gKyAqDQo+ICsgKiBUaGlzIGlzIHVzdWFsbHkgaGFuZGxlZCBieSB0aGUgZHdjMyBjb3JlIGNv
ZGUgYW5kIHNob3VsZCBvbmx5IGJlIHVzZWQNCj4gKyAqIHdoZW4gc2tpcF9jb3JlX2luaXRfbW9k
ZSBpcyB1c2VkIGFuZCB0aGUgZ2x1ZSBsYXllciBuZWVkcyB0byBtYW5hZ2UgbW9kZQ0KPiArICog
dHJhbnNpdGlvbnMgaXRzZWxmIGR1ZSB0byBwbGF0Zm9ybS1zcGVjaWZpYyByZXF1aXJlbWVudHMu
IEl0IG11c3QgYmUgY2FsbGVkDQo+ICsgKiB3aXRoIHRoZSBjb3JyZWN0IG1vZGUgYmVmb3JlIGNh
bGxpbmcgZHdjM19ob3N0X2luaXQgb3IgZHdjM19nYWRnZXRfaW5pdC4NCj4gKyAqLw0KPiArdm9p
ZCBkd2MzX3NldF9wcnRjYXAoc3RydWN0IGR3YzMgKmR3YywgdTMyIG1vZGUsIGJvb2wgaWdub3Jl
X3N1c3BoeSk7DQo+ICsNCj4gICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9ob3N0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiBpbmRleCBlNzdmZDg2ZDA5Y2Yw
YTM2MTYxYzIwYWQzYzgzZjEwZTY3MDk5Nzc1Li5jZjY1MTJlZDE3YTY5MTM0ZTZjYTFiODg0Zjc2
YzE0Mzk2OTNmYWIxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiBAQCAtMjIwLDYgKzIyMCw3IEBAIGludCBk
d2MzX2hvc3RfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXBsYXRmb3JtX2RldmljZV9wdXQo
eGhjaSk7DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNf
aG9zdF9pbml0KTsNCj4gIA0KPiAgdm9pZCBkd2MzX2hvc3RfZXhpdChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAgew0KPiBAQCAtMjMwLDMgKzIzMSw0IEBAIHZvaWQgZHdjM19ob3N0X2V4aXQoc3RydWN0
IGR3YzMgKmR3YykNCj4gIAlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3Rlcihkd2MtPnhoY2kpOw0K
PiAgCWR3Yy0+eGhjaSA9IE5VTEw7DQo+ICB9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChkd2MzX2hv
c3RfZXhpdCk7DQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KPiANCg0KVGhhbmtzIGZvciB0aGUg
ZG9jdW1lbnRhdGlvbnMhDQoNClBsZWFzZSByZWJhc2UgYWdhaW5zdCBHcmVnJ3MgdXNiLXRlc3Rp
bmcgYnJhbmNoLiBJIHRoaW5rIHRoZXJlIGlzDQpjb25mbGljdC4NCg0KQWNrZWQtYnk6IFRoaW5o
IE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

