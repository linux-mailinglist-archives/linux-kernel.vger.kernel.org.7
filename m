Return-Path: <linux-kernel+bounces-780842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846CB309FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188C3167093
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A062E3AE4;
	Thu, 21 Aug 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qZC+7lny";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P/xBKIrn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jnbq00bx"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275C22172C;
	Thu, 21 Aug 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755819075; cv=fail; b=K5znVqbctVOo07B2nXqRldbBT7ItcRZs0yUgcSQ3HIUTpjm8mNBethKnxNISIhdd3nDcWUMOKILZuHIhPx45CvQVPM0xWPXYrh0P0n1GGqEI09wFnt4wyJr7OPjLlpvo+ChK5AtX45Qkq104oIfcku72pfLqltcMNMc4qBD5ahk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755819075; c=relaxed/simple;
	bh=obk1irVLutPbNcXT2UIwH6RPwcFp5RivZMBqRHAYq6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CpjpqUgQc1vQ+45fs4yIm4Oxj/SiaRxmophN9dhtqvppW3GbKmPP2BXfGV9pyVgdf/kuxDyDLCajrmYXgXv7M3S5gi6WpPzF5ivhw7/atP+7om6fTXL2OsF737PtV2bMuHEpfohYxTNgVlkj+bpcrFan8AMVZrOqIZa5LSGPAiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qZC+7lny; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P/xBKIrn; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jnbq00bx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LNMOmx030021;
	Thu, 21 Aug 2025 16:31:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=obk1irVLutPbNcXT2UIwH6RPwcFp5RivZMBqRHAYq6A=; b=
	qZC+7lnynUbhQCLFjoaHWGzHVNTKJalEcEB/EpYPZ+ktOWTKlyqys/ToF0Bfjd6s
	wcU9+IUQGhHlVYgE4X2mLwPTNTorsM7oBVHTx7yDskSCg0v6QvF3cIC2gjNhXZxd
	b+AXwtjE3ETvV+JDW/ws08LI1L3luaYr+mZESyBJWTJpkplrr8sjgoK4u0aYo89v
	jYvOlJUH0MT+/j6FBvlbnQRzOshpua8fCgBkCVIHnjOKdzXaBoPlrkfAz3MCPnIS
	uG3HkxY5mXSwJXanJE/Ooq+sD54Qp1um6EOtKDvgTSiV5cbB9QTKy8+BOVcCX8EC
	tGuSLdN6Vr9m4DNcjzyCGw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48p4vnjgan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 16:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1755819064; bh=obk1irVLutPbNcXT2UIwH6RPwcFp5RivZMBqRHAYq6A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=P/xBKIrn8yC44otq9f88vVR6JS+5BKksdYiCeEQUPFkqsKHJbG/7cZ5ZbyxJ2FhMd
	 VVsYA2O5mbNXqku9kY95RODUpCc9bQfGIhSQXlXsu2ixGPwJaT/JR4Rpk7oR0GsP0b
	 oJ4VlcUPRZmAVF8j6H1Ha+vDiDigKELHwv/sVd2YPzdllU4TYBZebCsViRxt6MRyGe
	 SSZaWCqw1LbY2dQOI1k+JTFxfdf02ynW5J1zQV+2oGTuxdd5110/um1Eic0PrpHEl8
	 aUi+ws6HY7igFuKHU7UdvWFAQLBrF6IXXHHTC47hcOfMx+82PE0TcitQpYZHSYFpK1
	 0wGQlElkXdfIQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 289D640347;
	Thu, 21 Aug 2025 23:31:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AA910A0073;
	Thu, 21 Aug 2025 23:31:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jnbq00bx;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E8C98401CC;
	Thu, 21 Aug 2025 23:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVo2n+fJZrUNtZYbsf00XOfs8WnMATEsjNXIXHzo7oPoqlHh/UJp+EjXmwMaEqmEdx+GGHW+7yDqnjc33JbMtesJa1ep+1QDhfGr6RfBErnfwCoTkph23i99K7iHQ8KI25Uc0t30We1BUP9o3PlIT61niwtkDA/8W0cS7hl5E9/qJNPAeZ8BSYc2Dd1Kz9P6CWSPkqUdIpn+RLYa+vCqkkvTb5ZCHy9LYTaa3nzs6uImNxUIiuIfz07MpMXCD4b6gyhsx9t7ixmonl2AkJIMMCGGfWWlzBdMuFUJ+Xg+SE8eNR/PpUkFbNt86t+AJ8h98LO489CoAHdFU6p/VD9eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obk1irVLutPbNcXT2UIwH6RPwcFp5RivZMBqRHAYq6A=;
 b=L1NP7f8ZFrExd6E9aWLskGU8PMmhZn4JUNhB9VWYmFvgvW+YTTnT8EChkR6Xi4Roykxo5dCynZP2YmD2HdMST11S0wUj7CoHK3V5MwUi1k7XY57O29t81Zs4eDc1Cd00Ho8bIGA3dBsrwFS2p+tzSHMgsimBqVnb2Vaq2geLEGqH88KYWPRXEOSXfJmGuFIyJGB9FpBC0MFnbFZYwa5H3761N53fvF+MG604pEfbR0rA88S3gDMuPvd65U9Qj+HXHmTcccmd2mYCfO7w04WiLJB6qXe6wbF51pNUgX1OWE300j3i1RjAGtEerOz9bzyLWf+BtEFe1owB7Fun+u5NnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obk1irVLutPbNcXT2UIwH6RPwcFp5RivZMBqRHAYq6A=;
 b=jnbq00bx+0kMkjGBiJh7kCFtucGUbr3peK6uGMoubTteDJz1aglpU1LYDmHoWrQwtOQj6Ii02VWcikVt6oZVhxFB9WBSpQxhlmi5MU4aVSXN3kOJOxVYRP16rBm74CpbZDQS/Px4aOq1yTjCV4DHHZL9ijX3sGYgCieVr4CxjBw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 23:30:59 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 23:30:59 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: dwc3: Refactor dwc3_mode_show
Thread-Topic: [PATCH 2/2] usb: dwc3: Refactor dwc3_mode_show
Thread-Index: AQHcEAZ8S117hp04LkK0ibKahEjxTrRtxz4A
Date: Thu, 21 Aug 2025 23:30:59 +0000
Message-ID: <20250821233058.mmhwdxcbssyvbl6j@synopsys.com>
References: <20250818060757.2519126-1-khtsai@google.com>
 <20250818060757.2519126-2-khtsai@google.com>
In-Reply-To: <20250818060757.2519126-2-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV5PR12MB9754:EE_
x-ms-office365-filtering-correlation-id: 5f410aa5-7f6d-413b-31cb-08dde10ac909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUdjVGduVkRyTDFpeExGNXVDK0pHMFhwQjJxYnB5RG5jeGdYZG5SOUwwMzRL?=
 =?utf-8?B?MXBqUEV4UnIvVGhyYU5KME5uL3NaRHkxcmVMeUZHd3ZOak5kK2hFYVZBWUJT?=
 =?utf-8?B?UVRyVXJTRGZRMTJyQWpmd0dXWWUyS3BtbFcwSXlxZFhCQmFEelZYbnF2WnpD?=
 =?utf-8?B?THhnaklJWnZwdklGNEU2UXB3enA5NldtMmIybkhxODNZOEM2U2d5L0xmUkhm?=
 =?utf-8?B?eHVlUGdjSVVkbmVzUEFHS3RZZE11dExMMmhrNW9oelI2OXY5MmlnUXVmSDI2?=
 =?utf-8?B?TU56WHdpSDZxMXNGaVd1SjlLdkdiaXlFYVY4RTc5a0dweSszZjBkYVNEQlF0?=
 =?utf-8?B?b1lGcG01NTEyTHJrVEtwZlRiU1JSSmd0d2F0TVM4cHc0SDFaV215M1ZMM3li?=
 =?utf-8?B?U2FCVWIyeVdHSnN2NDZmQ0F4azZjeGNKRis3cFEzR3dnVnBjMmM0NUFwTkxM?=
 =?utf-8?B?WlFNWVlMMFdnb2dVaUxOOUVVQkVXOC9aakcvdHg5cVFXbWthRW44ODZpb2JI?=
 =?utf-8?B?OVc2T3ptRklhYndJYXpLNm5LWmRURisyQ29QaWxTNXYrd3EvSStpc0lyQ250?=
 =?utf-8?B?d0RkOXlnSHgzS3hMeEkzbEE3MkZzRjB1aStscWZEZlZ3bXkvTFVmOEc4Z0JP?=
 =?utf-8?B?NVVqVmpRTU1DYmxaYWgvRXFaYjFMcERzcy9hd1QrVGNDa0NVbnN1azAwWEFM?=
 =?utf-8?B?UTNLOXIvbUhQclpzUnNReTE0NWZISTRNOGhCdjltZDFWUzFhdEpPMFVKdkRP?=
 =?utf-8?B?TFQxRWVOZEphYlh4aXpuTzh1YVZaRUpnd0JqQ1JCOXpvOUxCS1haZGptUkJm?=
 =?utf-8?B?VlJDanhOY3VJVWFnZ0tONy8rekpVZkp1NTFJMFNKQXNxRzVKQUVJSHlpbGFm?=
 =?utf-8?B?R0JCbmlNZC84bTQ2dVk2SkpZZXVTcElpK1cwLytDUzg2OHVKeThSa3F6bERU?=
 =?utf-8?B?OGpYTFAvdldKV2F0MXdkZjUva0lsYnZZKzYwM085VU05cFp6dnJwN29jOUpW?=
 =?utf-8?B?U0g4T2NmZEhtL09YU2F1T1I5QzVQUFVqNW1qZHVucXJUWUZKNnNOVW05cC95?=
 =?utf-8?B?Nzkwd2QwazBPTjBvR25Td3RQYTR5L1JRajdKcThSOFc4aENFWHR6dHRUSzVR?=
 =?utf-8?B?d3pFUXNpOExLOFN1V2FJQVAySkc1S2ZvZmpkL2MzMWVpNENGUW4ydUw2T3Z3?=
 =?utf-8?B?a1lzeFFaL3JVL2NWTnQ0MUhhSFIzM2ZyN2N2NC83V3luK0hER3RMVno3ZVlY?=
 =?utf-8?B?Nkg5YmF3bUMxN2h5ZkgyNUJKNGR2dzB2RVZFU3lweFd5VWpDOThqaWlHNmI4?=
 =?utf-8?B?U0xOZVdMVWN5L2p4WWhvaHdWNURZRkN1VHF2VFJDcGw2dm8vMUxpMGlMNngz?=
 =?utf-8?B?QjA4SVVIM1o2WVZDRzF4L2V2dC9OSW1VbFBuVERONFRQMUtlU2pEaS9HZHFm?=
 =?utf-8?B?eE1vYllKWXlGdEdVZklRYWc1RXk1bGtsMmtrWU1Fd3AzajFKL1VoN2t5bWR2?=
 =?utf-8?B?V0FocVNCelVraXNWU0xZVjVabmR1N0luSHZmRmlaanZjUDRYZG52N1VWSHF4?=
 =?utf-8?B?YWRpRkdHUzRBTE9HblhLNXBqZHdGZlA0dXM3OU5RR0Zmc0QwWTJOaGJHRnox?=
 =?utf-8?B?V0FYbGdGOTVHQktZVGZzcjhMbURsd0QzSXI3cGx6TTZjczV0TXR1U3B4YklQ?=
 =?utf-8?B?UzJMTHdwTFd1Zzd3a0ZoNnZJbU5TbGc3RzNpdVdYMWc3MDcwZVo1TFM0b1F5?=
 =?utf-8?B?NmdweWN5Y1ZTVWxTdW51NWdPWUFMQklXUzQ5K2tGQ1o0Nys5ZWE3L2ZoYjJj?=
 =?utf-8?B?d3MrQytmZkw2QXZiVGlJNWxHNHczblZLVDlyN29GSFYzcC9UQmV5cDN6VDdq?=
 =?utf-8?B?RzNpQVROYTg2UThIdXBlVkNybndDTXZyK1psR3lNNWhHVGxKTnFPcENZaWFM?=
 =?utf-8?B?R3d1T2NhbHR5M1Q2Y3RHc29kT1JOTU5FSkZVWmFjbDc5MEtudHFLUENrNlAy?=
 =?utf-8?B?S2NvODY2RkhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzZ5VGFWZ2VxWXU1NG5wTHZKZGRuN0lodCtUVk9vUk1oR3BBVEcvNVNobUVT?=
 =?utf-8?B?WEMzTkxtMkNUSWllWnFYdW1jNUxjVzBpQXZYaUlJOVgzOUFDbUJLMFJIL084?=
 =?utf-8?B?R1BXYU5NUFJyTmJvSFlpNDJBZG1XbmNKOS9XYnQzMExVZmh5LzJzdUNnZ1Iw?=
 =?utf-8?B?UXJhRURKSDE0ZmFuQy9lSHFjRTk1Q1Y1L3FySStZcUxCb0l2eU9mZEtERi9V?=
 =?utf-8?B?azJXMHlxWmIyQlBsaUpNNXZMUDNjRytFSStCdm43a2tzV1pTekdNb1VuakEz?=
 =?utf-8?B?Q3lnV0RwWkIxOWtnajFrM0VnWnZ0V2hudVpwYnBnM3FDbUJrdjNja3ZtN0JE?=
 =?utf-8?B?S2g5SnhlekRXdHVoQjFLN1pmMnFKUUY1M2l5Zks3cXU2cERJaHpnRHZJbmtZ?=
 =?utf-8?B?ZTB2N2hTaWJIa2J3ZnR3YXJVVlJYblR6Q0ZFZU1pcStabWVuRlNnRmhTbFJL?=
 =?utf-8?B?SGZWWjg0dmtNWW53VHBDMGxtSHZLSU1OUjN3c01jY01mNjZRZzFKSE5uSEtV?=
 =?utf-8?B?K0RxTFZpUmJiZ1dFRkEwS1pUU2hMZmlubkdiUGZBMnhzZ2dzU0VUT3U0TTFQ?=
 =?utf-8?B?Y3R2L1BqWmVUcWw4UVlWeVBJdng4UmQ2alJZRmJNQmFGSXFYNlZUTjRXQmZm?=
 =?utf-8?B?Yi9TenpSUy80eHNKUzloaWRPbm9rUStHVDVudkNGcGxWeEtHVDhJOWlzT1hl?=
 =?utf-8?B?dmgxbHZ3NmV0eUQvM1dhdGNUeFpnYThibjZTcU5lYzFUbXFUSFp0U2RZR0xl?=
 =?utf-8?B?cWtYaFJPaEoxSXJnWTdoeFRkMmhUaEtqOUV3VnNyV0dYOEo4VXM3MXlxRm55?=
 =?utf-8?B?dzZwRDQrT2RQNzcyNUYzcVhwL2w3SE5iSEZYMUFML2Q0NUFNYUhDKzFpdHAx?=
 =?utf-8?B?enZlOXNQRVh0TVo0TTd5N3YrSUszSTVnZGxmbWwxcFZlK25XcUdWTlg4Nytw?=
 =?utf-8?B?Rzk4cHA1c0xIK2M1OW5ZU3ZFK2xycG1QWWZjV1JYU0h6WUJ5VlJhZkNVeUxn?=
 =?utf-8?B?SEN1dUZqSWhNVEZqbWhkelhEdWp4WTQyNXZZZ1Q2NlZTcnV6clpOcFFRVEUy?=
 =?utf-8?B?dDlGd2x0TVF4RU10Q1d5aDFncVhLWUJxQ1lxeXlpNU9vcGkwcE52eEsrUE44?=
 =?utf-8?B?cFo1ZVFqdGVYZHNmeTNBMU1NK1lwN0szcXREUlh0RzF2MzNBRitNZFNtb0t5?=
 =?utf-8?B?c0JCbHdha3hHVHIxaGNURzNOVVc2T21oazU2Mm1PNEJDTjI0NkdRTjV2Q1Fs?=
 =?utf-8?B?VUh4ZDk0Wis2MmZuS0k5SHN0Z0dpZ1Y2Qk54R1UwcHRzZkt3SXlHYWFhS002?=
 =?utf-8?B?ZEpEWW0waFZVQU8wMGdJcWQ3RzQ1bUxJQy9YZ1FvRm9qa2RqSGUvb25VdTc2?=
 =?utf-8?B?WTZPUXp5WnFnSFRySFhPYjFOZzY5akVKZXdYMHhCZXlzYXNFcnZQMkZPRlpY?=
 =?utf-8?B?OUwyS29YTnBjZWkzcHB6RW9nR1RVSHMzTHlVRllQUFZ6emZKSmYyRXFiOElh?=
 =?utf-8?B?K3cxVm5RMlNFQTVhQkRkWnBBak5LS0JBVTBhZjdISjlPWTdqTmRGUGFoeGkv?=
 =?utf-8?B?bjUvSG80N0YxemlyQ2pnZW4xdDhTZHhZUXFCZldJZEhGeWRPUHFMZ2dpUzN1?=
 =?utf-8?B?aVVWeHNtc2ZNOElWQmhHN1o2cDYyVGVDQy9GRmtGTDNUM2dkVFhoZG91d2Nj?=
 =?utf-8?B?QVlUY2JoeEFWT2wvY1lxN202SlNvLzQ3MDRpc2pVNVY0MEFqZzNMdy91Qnl6?=
 =?utf-8?B?eGJZS2tobVNVL3lYM3JyWkoxanpFa2U4T25LZDNpTHlQTE9vQVk4cTVQdDZm?=
 =?utf-8?B?KzRZcEZsdzR6NVhPYzBCWERDRm5HdG1NU05KOW41R1N0bk4vajFwSmUzd3dr?=
 =?utf-8?B?bjJ2YkdscUpGU2oxa3JoMVRuN2dQbWVVUnQwUUFScGJ4UXRRRzNHT0tUaWJ3?=
 =?utf-8?B?REtpNlpOeXhocnp1Ti9DTFZobjQ2ZHp0SVdGRnV1b0w4MDNaaE1nY1ZDa1N4?=
 =?utf-8?B?T0hCbmdNeGc4aTM4ejgvdFl2cldUbG8xeUpKb0ZsREc1bXhEN20zTDVqK2hW?=
 =?utf-8?B?Zk5mQnJZUE9YcjZrQ0c2MnVkOHpDRlNUUkprbUVkYm4xT0VybUh0SUhCT1VC?=
 =?utf-8?Q?3nnM7LG3UWuzcqO2ybRFiX8Oy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54006026C5E64C499907101CFA5CB762@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q2BZ78dV8EoP2wnN1uKmsNm4A++Lx/eAYfGCEoNgOUDC+E6GAgUlF+YvzsHm4c8hNmh4YhoFDDUShe5dpQTP+PS6mbzUUphh/EVhH2oqBs4eqh3y6tP2YUr6SZdd1pSx8SjGbNPeGoGtYCr7OF0p0uhEkHdU6J/uhk0iZ+B7R+vLZOgSow8+f2+3V2vwpAcUhHTsy+DJyyvRwOe8OuniajCPNk+wMxPmeTU0tisQrxI4HhItTpVfi6ItQoHE3kb42mH/l1K10oV0fIx4pcIPzA/qkPr8QhpGiyyTEAOcwYBJTEcfNueW7zBfxvtJbEDKrul8bh+1Kd9a0Zcjb+4fjJLra/8bteJCiUk80Em2R/tuOvgDcAdj58PHEHKi8sk4mX79lZEDC19xDvwo3EfByp5QFa/wED8Uzo8Yu2vyj/0UqaqBM2cHxxsDqY7zQBab4hbU/Ss6cnQK9aIlVacY9TMUGQV0Quv8jQUsLS8I5AfY5rwcVT7MG41uVcKgLSmYF9meXybcy4zn2RR0UHgSnzaHcevTyyhdgU/9F6FJDe00wBLhbCN8y99FQqMjbRNF0VM1Eicsn8uJttEReQDPTrHsCv8EuSaXZL4yPiTVxVB3eEtnlEknekb8BlwobKVcBKsZ2B2pTQmmLTEXLlb4YA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f410aa5-7f6d-413b-31cb-08dde10ac909
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 23:30:59.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 311xoxTQ0FaQotFys3F2PhaowTc6sWByYTO4stIeQtUJkS/wyf9f8i5IBngcVeE3MgssXmsA8TvfUnSCFE+HwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
X-Authority-Analysis: v=2.4 cv=Hqwv20TS c=1 sm=1 tr=0 ts=68a7ac38 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=0LYAXUVr2rgf-SiqidwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDExMyBTYWx0ZWRfX1HkylUw+Y7IO
 ysYige1BaqFxHZTT0MEuA3/Xh3zTFbUNPG3s8StSye28XFFyplwXusYZKscmvzLnXQWDsCMA4P7
 yJZnDWlLFxF1gcAFyDuRTKjei64DF+U0pnjSXuSpzH4fUWZIMZv0lXK76Bv+eaaBYIo+hrwwDbU
 KGNZqaph5NaTRNtkj79i+YH1tYQ0lcYCoMP/hnbIUHfLTWUGnRLdhFbb2zoowUfQ9pI6en9QyMv
 kPAXZhUOFcXdKj5ie/MKNL0GG5K408njKfvgtybSsGAHbwHPyi47vq9upcDkLsGr3C4WSUx0V3X
 p9ru/C5djhia5G08oyH7bY0pp1v5DM5RIiZXrhBSXjbAOO0Xk8f9H3Tog87gUYL19vyEH7JKKic
 x2WFCI472lSzHgB72jm0yZ1d8wE0qQ==
X-Proofpoint-GUID: m1SMXHox70jiSEGQHmJz0Ck6CJCCDtBL
X-Proofpoint-ORIG-GUID: m1SMXHox70jiSEGQHmJz0Ck6CJCCDtBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2508110000 definitions=main-2508210113

T24gTW9uLCBBdWcgMTgsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IFVzZSBkd2MzX21v
ZGVfc3RyaW5nIGFzIHRoZSBzaW5nbGUgc291cmNlIG9mIHRydXRoIGZvciBtb2RlLXRvLXN0cmlu
Zw0KPiBjb252ZXJzaW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3Vlbi1IYW4gVHNhaSA8a2h0
c2FpQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kZWJ1Z2ZzLmMgfCAx
MiArKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kZWJ1Z2ZzLmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnZnMuYw0KPiBpbmRleCBlYmYwMzQ2OGZhYzQuLmQxOGJm
NWUzMmNjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kZWJ1Z2ZzLmMNCj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9kZWJ1Z2ZzLmMNCj4gQEAgLTQwMiw2ICs0MDIsNyBAQCBzdGF0
aWMgaW50IGR3YzNfbW9kZV9zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdW51c2VkKQ0K
PiAgCXN0cnVjdCBkd2MzCQkqZHdjID0gcy0+cHJpdmF0ZTsNCj4gIAl1bnNpZ25lZCBsb25nCQlm
bGFnczsNCj4gIAl1MzIJCQlyZWc7DQo+ICsJdTMyCQkJbW9kZTsNCj4gIAlpbnQJCQlyZXQ7DQo+
ICANCj4gIAlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGR3Yy0+ZGV2KTsNCj4gQEAg
LTQxMiwxOCArNDEzLDE1IEBAIHN0YXRpYyBpbnQgZHdjM19tb2RlX3Nob3coc3RydWN0IHNlcV9m
aWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERX
QzNfR0NUTCk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7
DQo+ICANCj4gLQlzd2l0Y2ggKERXQzNfR0NUTF9QUlRDQVAocmVnKSkgew0KPiArCW1vZGUgPSBE
V0MzX0dDVExfUFJUQ0FQKHJlZyk7DQo+ICsJc3dpdGNoIChtb2RlKSB7DQo+ICAJY2FzZSBEV0Mz
X0dDVExfUFJUQ0FQX0hPU1Q6DQo+IC0JCXNlcV9wdXRzKHMsICJob3N0XG4iKTsNCj4gLQkJYnJl
YWs7DQo+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gLQkJc2VxX3B1dHMocywg
ImRldmljZVxuIik7DQo+IC0JCWJyZWFrOw0KPiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9PVEc6
DQo+IC0JCXNlcV9wdXRzKHMsICJvdGdcbiIpOw0KPiArCQlzZXFfcHJpbnRmKHMsICIlc1xuIiwg
ZHdjM19tb2RlX3N0cmluZyhtb2RlKSk7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+IC0J
CXNlcV9wcmludGYocywgIlVOS05PV04gJTA4eFxuIiwgRFdDM19HQ1RMX1BSVENBUChyZWcpKTsN
Cj4gKwkJc2VxX3ByaW50ZihzLCAiVU5LTk9XTiAlMDh4XG4iLCBtb2RlKTsNCj4gIAl9DQo+ICAN
Cj4gIAlwbV9ydW50aW1lX3B1dF9zeW5jKGR3Yy0+ZGV2KTsNCj4gLS0gDQo+IDIuNTEuMC5yYzEu
MTYzLmcyNDk0OTcwNzc4LWdvb2cNCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

