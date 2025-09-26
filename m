Return-Path: <linux-kernel+bounces-834704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0969CBA5527
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E64B1618C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F7829E0E7;
	Fri, 26 Sep 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O/ha463H";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SJ3Jj0Rp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KVQzG/TG"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36115278E;
	Fri, 26 Sep 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925534; cv=fail; b=nGWk2hsRx/nTFk9oK1KAOcxZSJBvWPVtJainhvIE9z63SU1fAJN0uCMut6lmzzcF9+NT2y0EsSLiqJF9IQpI80wHVyZAGaWOvoJjvmEQ1TmWXSxDZ8tlGWKX7eKvKD3vUJoibLmqS6yzcS0mWAuHa0gXH+xomgP8eGBcr35LLXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925534; c=relaxed/simple;
	bh=rzqtvazj7mF+QQg7xxSLRPFESa88gIuwv8NdfKRtnQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h1jpaCIigKLeq2RWbPGlC43LJMEppeW97BcZ6ANPuNGr1rdhaUi/5KwOG9z6tDeX1SJ9euLRg0XGs1+aQuusf78fYH+1lClrQpSnj1tW6vtJ5VxNgF7UfLlCEJuB9QOTjpkYt6LDq1sc83aV/lAUyrZKJzyo4TXahLBQvKkTR38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O/ha463H; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SJ3Jj0Rp; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KVQzG/TG reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QJw9NU018964;
	Fri, 26 Sep 2025 15:25:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=rzqtvazj7mF+QQg7xxSLRPFESa88gIuwv8NdfKRtnQU=; b=
	O/ha463H5rLLSIRC1rGX08LjLujTfW+ovSaaozhFwI+h2E76hu0d+3iPWW0lUJjQ
	Eg8Sn2fQm7bfMDkhu60fgvWaocZfT457yZzH8zVPGBc2mJ0FBNv/SPok+p2Sw/xN
	VSgSd/ClwKUea8Ut5cd3YWwJH8bM2x4P9jYHIjsr+jmdW2p0yKmHtwPBOeqwK/AM
	OXAYsO4cpdX0mPV/RjkfxILoEfTwP+hyvSfO46myfstHfw4+4DKrdL5X4nm6VfDO
	BfAteAVpOB/MNZJDcJf7ZfnvsBsUaiase6qyidw7/V1g2Bn7D7fo6TROlGHYKJcC
	+WiCbX4t4wX0QoSevd2d1g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49db0neth2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758925498; bh=rzqtvazj7mF+QQg7xxSLRPFESa88gIuwv8NdfKRtnQU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=SJ3Jj0RpVL6CNQgCGSJ8/zcHR1qJqwKLfu+p2IVy4fyG/gfbQsNsEgWt4BvSrWamw
	 jea1OU8g8X1wnOFI3LFg3iCCqdb0cZzp8TphIwTFNt+ZDg9E53pdGIHSAfQ7lesro0
	 7+eVXVfrWdAcf9GprpQ3gqkaHU/Z3Ms827Nv0wtEL3TaA/hLCmN1iWIvkq3yQDQ6n/
	 TFa1LhfAibPsrjZw7g3Q8zGlm78xaQUbq3qeyTDghRBRikbqTOtyNXhi2XwWw4/0CX
	 Ja9ON7pZC18Z3i6//NQdUwyd2MNPnHk+ACqPXL0tDtG3k4cKIRryukt8qafvXLUbAn
	 +3oVI/buiAfeQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5862E4035A;
	Fri, 26 Sep 2025 22:24:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 54809A0087;
	Fri, 26 Sep 2025 22:24:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KVQzG/TG;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00102.outbound.protection.outlook.com [40.93.13.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1A84B4051A;
	Fri, 26 Sep 2025 22:24:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg7/7P4Wp0I/knA+obPQjYyG+8Tgne5y3Nbc9F9SDmk+e1TZKADhotj4m2y5HcfDOC5hXpuubfl+B9GLfycwEqbHIkG+qoy7zozVI2VmnddRnRhda5lQZD7fpv504q2u8+VyVOaQZ/aLlHCVbC9fB/SH9wyBIiMNZ9YqUMPI3MPITtgoiLM3L9EX276px3pKLJ+pByJwTQnjVPhiYltL5sWWBvgCl6tbdxhwe7UFEvdLfWMR8zNrANnqZkFSiGtntXcXVeNBfxcEznMAKiKpnBhPUGg4/G105xhuSWBXYinYz19cnAbEVyTzXpcKZjAx/O039r08PQdYBDsPFh90FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzqtvazj7mF+QQg7xxSLRPFESa88gIuwv8NdfKRtnQU=;
 b=aIUSXO2k25mvZIhwKp8VsglmQ/Skl7VzMcoofyA+6xfdwe2Zpxx6ZrA13KkjocN6cx11xTaw2nV6q6UeAnUlSSMIpt6QmzKi3QFWg9grqNb5nDpS7Za0Dzwy1wBVL8OKfqPxlityH+CzTFxWNXU50uL3PyIfE80UajEXYuWz7qCiZGKtmy6tsFbVJFtbA8bypn+38IGYgXRSlsRVJzL2Oyj0BXMLrIfSEdm/X5TouijyFVdK+ZKMQ5UPdz9sz2y4Gk5Kim6AGzEhB5ODwzneXtDt/k6hdAU15MR94g8PrOKC6UUeimugIlYKpN+fcR+0O1cxFvoY+DxiwzfHZgbbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzqtvazj7mF+QQg7xxSLRPFESa88gIuwv8NdfKRtnQU=;
 b=KVQzG/TGKjEUFj690+Wm40C9giIBBlGm93rXVYEBCt7NK73qLB3XxDmynd+aU0rLKwzEbTxdK8B2sUwGRF1YW6OAriTrqrn41r3gAEMD7t24HsXvcMmy+nJlbTPHkV+crJMVtnDvNYCSDl8kRKb2UpZE6SIjAOOeqdOgxmx/b/0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 22:24:50 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 22:24:50 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Frank.Li@nxp.com" <Frank.Li@nxp.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v4 2/4] usb: dwc3: Add software-managed properties for
 flattened model
Thread-Topic: [PATCH v4 2/4] usb: dwc3: Add software-managed properties for
 flattened model
Thread-Index: AQHcLxIqJqOGhYcexEK3p/sK1ZcyBrSmCpMA
Date: Fri, 26 Sep 2025 22:24:50 +0000
Message-ID: <20250926222444.d35d77oqv3gyxdiz@synopsys.com>
References: <20250926-ls_dma_coherence-v4-0-21e9c6bdb5cb@nxp.com>
 <20250926-ls_dma_coherence-v4-2-21e9c6bdb5cb@nxp.com>
In-Reply-To: <20250926-ls_dma_coherence-v4-2-21e9c6bdb5cb@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH1PPFF5B95D789:EE_
x-ms-office365-filtering-correlation-id: 2d461a59-5495-411c-9d5b-08ddfd4b823b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGJqWVpXSklYdHZBd0RGaGxNL3RpcDE4VnJEL1pyUkVvd0N2SDJCcnBUYUVE?=
 =?utf-8?B?QkVBVi9GSlBycGFySFhrcEpMU2hCd0lhYzJyYkdSbWdkVW9uaTdWUmdNOUtp?=
 =?utf-8?B?TmR5MmNDYWlNWFJETU9qYU1pQ2F0cUR2a1dQSTBZdUxtUjgxN1hlcWxCMGly?=
 =?utf-8?B?TEljQ1U4RUVadkdRblJJTnp4SWFWUGdrb3NTdEp2VU51eE1Ob1RQVEV4NCtj?=
 =?utf-8?B?d21obk5jK3R1L2ZMendsbVVTcEtORk1NdW5JUHJWNHV4TGNPeHdacm5JeENL?=
 =?utf-8?B?QlFRU29uakIwcFQvb1FReXFaQndIbHpIbGg3WlNwNXRIbS9iQzFhNUxCUVYy?=
 =?utf-8?B?M1JrMmpOWS92Q1R2KzVrM3N2MkxMS2JEWnJlVHBrMGtQeUxHMW5oc20raFJQ?=
 =?utf-8?B?ZnFSWUZ0K213bkloMDdmYnNhTzBHVDdLZ0V5VkFqWSsvc0gwOVBITWRQdFJY?=
 =?utf-8?B?MFNDcTBBQytwOVdhQVlNdjY3amR6b3BZd3o5VE1hZXlTMGlwOW9JSTR3V1Jn?=
 =?utf-8?B?T1kreU1Mdmk0bkJzeUl3a25aWSs5UlBLbkRNelNvbVJYeXA3R0FReDFUL2hv?=
 =?utf-8?B?aVhCMU9qUzdyQ0N2UjFsQ3VWOVk2bEptM0MrWGFPMVgyMTdqWmViMFhtbVlK?=
 =?utf-8?B?ZGR1V3BId0JlbWtJYXZTMm9PaWo5YjgvRHNjczFUTEFVZFhSTTV0a2ZlaFY4?=
 =?utf-8?B?d1pQVllQZitzRTQ4UkEwY05Ra0lqWU01WThUY2Z6bnFKY01ocTB3NGxybndF?=
 =?utf-8?B?WjVmOG9MV0c3R3FFbDJSbFl0VzAzbnMxNTdTMEVNSmV6MC9SaTlORVFRUDNL?=
 =?utf-8?B?WkVaUk4xMm9IMnJheXI5WmFzRGZaZGY4bzNlSHl4RVhOdmNjUHQwWExtSEN5?=
 =?utf-8?B?Vi9DWVRCZGZhYm1YWlN1dlp3bngwTEpDdzhna0lNYWQ2elFZNzcwMzFzclgz?=
 =?utf-8?B?RVBFWVJpamxKNUVZVnlrRGxycjNpcWJOUFFHS0w5MVdPN3hVaHFhWW1tcCt2?=
 =?utf-8?B?OXF3a2N6Z2llQ3RPR0VsUjMxM3JtMmlsc0lkMVpZb1NoK1d6bkRqSjh5VE1l?=
 =?utf-8?B?T0Q2RHlJZ2NLNnJhQWdqZ1luVmN5cG5nOEE3UzNNMllMY29XK3V3NGRWVmJr?=
 =?utf-8?B?M2hnNmhFeWJvbVZBVm5BQ0tiMkJCK0NlMFVRZ2s4ZmNlTkVrZXdEei9YdjAw?=
 =?utf-8?B?Y09vdENJdU9uUHdLdXBkakNCcGQvMUdqWVFNcVpZMEJkMEJoWkxBVDR6bmFz?=
 =?utf-8?B?NWxLZlE2VUc5M29INnV0b2dFYjg3dFpBd0VvbTB5elZMWGMzbzNPS1U4S21P?=
 =?utf-8?B?ZkJqbXMrdGxPL3dTSGtaNHc2dUVwNDBPV0p1UHRNSmhDdHJKVXgwZ3VQYVBB?=
 =?utf-8?B?NFpIcElCTWpOZGc3Mjk0dVhmQlpNeGJ2TFNhYVpWaFdkd2hlamp6UWhsdDVK?=
 =?utf-8?B?cXZZTVBqVWJLUnM1M01qcE56S2NsU1U2QVlkNTA4cHNqQ2NuS1M1S1AzcjNl?=
 =?utf-8?B?bmoxalpVRi8xMVJ5YWF5MTBNL2RzU205dGUxQmtLZW8vRDZwenRtUTZGcHM1?=
 =?utf-8?B?RmdDakJQcjNJWkNyTGFwc3FwVEMxcXk5ZmJxVmgzQ3VLM0dORFdMc3EwVE9D?=
 =?utf-8?B?MFlRS2JmWXlTVEZ3dWhTMEFza2NhdUZzL1lFZE5Ka0xOMGJicE5oSW5VazVU?=
 =?utf-8?B?S2k1VVhEclhXRlRKMHArNmowT05VUHdsNnBQcUgxaUxFV0traTF2M1dFVG1z?=
 =?utf-8?B?YXVGRjJURWdNdlVaOXhyb0Z3Ri96T1gwWUl6ZEhvOXZua3luUEpyMXd5bnh3?=
 =?utf-8?B?Q0E5bWFZbFZwYitZZ3lzL3gyUG5RaFVjTGFpSEkrS3ZoMlQ3REZjVkdpcEto?=
 =?utf-8?B?NnZmeG9CTVd5TGtjVFFlUHVEbkxtdW5rdFJiWm1DVjBDcjFBaHgzTVkrT0JK?=
 =?utf-8?B?WXc2a0pVVGpPNTNjOVU0RmxOWkhFU25KQXl0OTNwN2JnMzJhTDVsU3hPSGZQ?=
 =?utf-8?B?ZDBONytseUdXT3haNGNEQWZxeDJHWWo1T1BSNHpmQVNZZDNMTUg2NE5Vd3g2?=
 =?utf-8?Q?IF9qKX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHR0Y0xuVGNJWHZSbDFHVzhYSkUwbmJOYjZrOXVUTHR3RjZScW81NW1qMFJP?=
 =?utf-8?B?NjljRFhuV2kxaVl3MDB5RUx3SEpHVGRGNkZBdE1OV0VwMC93bTIydHg2VTA4?=
 =?utf-8?B?VDNDdzJlR2xVZEp3NkltakZqR2s3RUFpQVFQVERnd0dvcGN6am1LMG9oQWZB?=
 =?utf-8?B?WnBhcjg1N2hZTkxxYU8rTTBxTjQvQU9wSUx4ZTB4NG41NlhVSlpCa0NBakFp?=
 =?utf-8?B?RVQxRDZtYlRseHhTcHpJSTNlSXpYZFZHazZqazlSeTRYUWVIM3AyM20yK3NL?=
 =?utf-8?B?cDF2UWZRc0VOZDhueUJaeUVKK3Irc3MxcUhudk1zcGxVT3RNNFplSnB1cEg5?=
 =?utf-8?B?Ni8yV0xyWExaaUI5M2JPUUEwUHNQRGVGMHVFZTl3eDYwUlhnbTBzYWJDUHBw?=
 =?utf-8?B?NFNwU09QV1JrVzl5ZnozS09NSWxuYXV4bkc0emFvNStsNUQ4YWV6WERVQkpW?=
 =?utf-8?B?TU4zY0xqN2liaDV4YUNibFVLYlEzT3FBc0NYcko0TnU3WVFrNTRNZWdxN216?=
 =?utf-8?B?RE1xNFg3dmU5NWlIUE5laGlZL0lUVEpGVHlvMUd5YUJXdnk1RFhHSTZ4Y3Ur?=
 =?utf-8?B?VTRXcjJPZzM1Y2JHOERISXVKazdPL3BlT1ZwT0Rrc2JjKzJaWVd2UWE1Wi9a?=
 =?utf-8?B?N3NjM2lKKzdIa3NrVGRUYUx1WHBsQkt0TnJWOUFvN09nWDEwMlNwQmV0NHlR?=
 =?utf-8?B?bU5sRmdrMFNjZU5hTG02YitwSDk5WlpYazVUVS96blp5SDFYNnFpVnU0ZE9i?=
 =?utf-8?B?NDBzT21LTWNxb3dXMTR3NUlsOTluSXRqVlhPOXVTL0FTMmo0NXpRVW5TeXlM?=
 =?utf-8?B?LytaTkUrUWYyVmllbFJNNWg5N2NOL0plbVhPaHBWQytxdVZlWitFYXdHeU9L?=
 =?utf-8?B?YVVhQ1ducmd0b3hnWmp6Lzh0aXp3eXBSM3o5YmZaRW9RU3dQeEdYR1Y4Zkgx?=
 =?utf-8?B?eEZndGNuUE0yaTRjSHZsaVMrUEUrakRQWGdRZkZ1Y0tLUTZFenNCMXpuUnFt?=
 =?utf-8?B?UjZXclcyRkJTRW9KNGdyVVhNdHZCNWRaN2xRQlFnQm1IQmVlVXJkVUk0VFhX?=
 =?utf-8?B?VUQ5QmtVdGRVRWtNY0lONWNKWVo3ZDJ2UGdKNzJGanlMUjVtUHpMTHRJUGVj?=
 =?utf-8?B?NHpZTXZsZlFJeXlJckxrS3ZVNWxxVTRMMG9tUnBaam9xTmJvWXFhUml1cDRa?=
 =?utf-8?B?NGRWU25neHFPQjI3VkkvQ2VSbkQwbCtMZEVCbUlUT1paZEU3MVcxQ0ZGYUps?=
 =?utf-8?B?OTk5elpYSFh6ZUxkRlNiUzZ2anl1aGVHVlhCV3N4cWk1Z2lzZzVUVVNiNHlQ?=
 =?utf-8?B?cVEzdG5RMUZXZ3ZiRlF3M25NSUVDVFZHU1luUEsxanQ1cklvN3UyOTA3UVhu?=
 =?utf-8?B?NVBWTGk5dEFjbFlZOXVXdmFZeDVqYkNwQnFINmtJUlFNSThHNmpBa25pRjN3?=
 =?utf-8?B?NmpyVmNmUlhoQ1pTeUY4dWlvaGVkUm1hbHUvZGJqay9oeC9GR0p0SVI2QXRw?=
 =?utf-8?B?RmZCWUs1YzUxZ3M2S2hNM0ZmR3d2YnRzL1Yveis4Qk1lQldBRVlFUnA5MXRG?=
 =?utf-8?B?QVk5N2o3UWZLY2l5M2RWb1NWcExlcE5iK0RSOFY1N01uRTFHV2xnakc2WTcx?=
 =?utf-8?B?OWpuRVlvNGR0bGh0TDBXZmpENzRBRjBkZXBsZkxoRUFsS0FKU3E5aC94aDBY?=
 =?utf-8?B?TDAxQVljQUNGaXluejhrd2RDY3NVc1JDMWlyL0NwejJvYTZKRXpocmU2aytH?=
 =?utf-8?B?RnlnQVFraXJBZEVZUnFydzgvQm1YU082K3lJeU4vNER4aDd6SStMYy81WUta?=
 =?utf-8?B?MHNKTENFTHV3ZHNmZEdyeVZQaVpnTU9BV2psbWdibnV5dEg4MG9nSEpWZWFp?=
 =?utf-8?B?L1JZSnRrWUFEQ2V5SHQxS1pOZFgzcSsreEpWUWh1YVRnbVkrMitHbXdxVFNn?=
 =?utf-8?B?czlpd001RmRKem42Q3FYSE5UK2p0YmtGZmc4YjZpeExiTmRucFN4djVZVjE0?=
 =?utf-8?B?VHA5dUg1ZVc0VzFtalpHQ1NGdU9FS0VHMWh1N2Jidkc0NWxlVm5Ga3FLYWF6?=
 =?utf-8?B?TlJjVVJNL0hpak1BSnBYWFhwRlV6c1d3YjFlblR2aWl6ZGlZTXhQckFMTlNz?=
 =?utf-8?B?UjFZb1AxeWV2TGxuZWVNaC9EeEIxVW1uY3o3REpsR3NNU3c1VWhySzBGdDVH?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <932F0E7103E463429236E9285B53C6F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uDbB/pd6RpjQguxGUp8vZVOk7PwVZ7d7FjvOHfV4KsRimDStfcTikYYYV0w6WPXXFHZkgQIoS6HigpJSJhqouAFYKu4jpkC8yXiuhvcXHZTAia79svhUFHl3w0Bp3AezQA05339YIFvRAwGcNw6ms2o3UEWKix1OHl0eODDH8QdlXl6ZkfTDnC0K6BGEcEIuUUQLbudD6lk9bsqMccFBVZXZayypVo0V/hCnZLtuupzAzkVrfduz1RdpQkG++ALrr3RdArL4vc5KyE1+rR6RUUtSrf/MyJnN+29ufTlvDHMcpK7HCLCVoPPZi6ycx9ZjN2hvHc6nG8W1Tw9YJWIR1qdV/kTqZdoHmcFwsVoQb2NnwQO21tvEczglrz7FOfOv5WCzcSZZYf9wTJCSG9AJDH2aOF+TvSr/IrsV2/QYh/xOntbQE+B+pyMiWYA+T0SZWGhIu/Cbbz3CFS+1Vlxti+0EfIbnnQAGDZgLpK+AyfHiSDD3oZ5kO72MPDakmE1WMh7blWEaaEdgzucXQFkAV0KSq7REN0GvCM/ld4yHw1zQ6+FPHXpnZHsiE1BvoZNNuTaBVqJR0hPjeVeaPAwRV0iz+UvATmuOPELdBEka0NDc1NWQDg3IpjGPTY8Y1tW/deHZH04m90siFxIuDWB/4A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d461a59-5495-411c-9d5b-08ddfd4b823b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 22:24:50.5477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAB77suSoht2PUd0pmezplA0n4005QKJFd2Fmqv/dQnq+GCDirlSgV0Uu0aFw2umGoXydW6tpUT4ju+OhZPJTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789
X-Authority-Analysis: v=2.4 cv=Ar7jHe9P c=1 sm=1 tr=0 ts=68d712bc cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=8AirrxEcAAAA:8 a=jIQo8A4GAAAA:8 a=LIMhPq6n5xPZ5jDu54UA:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DcWHo-PA6fPTWRh--A8BqGjOuwG90JT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX3yz2jBWm+C1f
 /oq6Nl8e8zX1luGppTMWNnrEZqf/Ks3gOD0/oFHEc6YWhcI+4Tkb6VPBSC8Nsr1ZSpgUqDowwFV
 BA7iCIxqOjPK7O40o7AV0vut+5RGV+191pwLLz9SWm8p0jVuMOs9mCcysmjG9rkYIk3zaQjrmDq
 XEd5cT2izZrD/jRZp8B56C+nQmM3eEHFdNQ1QVokUPcU0RyzNhQV1UQRKMYMS2KabnjVKUFLh1v
 RrLycO+nHvNxNuRAk1hpVggwAXoAc/PA8DTHyZsDQjIpCyayy3G90Y7Dr7AcO4H81iPHG7FbsOG
 4NztQSJXG42uwTAXT2KpZvZOBBVLDjinhOfcdmmzrSV6LxjnVcdjfpfUg+79FVfZpFwM4JgkbN2
 5S7nbqM93MTzPR343wSbczN8MgCDFA==
X-Proofpoint-GUID: DcWHo-PA6fPTWRh--A8BqGjOuwG90JT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509250171

T24gRnJpLCBTZXAgMjYsIDIwMjUsIEZyYW5rIExpIHZpYSBCNCBSZWxheSB3cm90ZToNCj4gRnJv
bTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IA0KPiBBZGQgc29mdHdhcmUtbWFuYWdl
ZCBwcm9wZXJ0aWVzIGZvciB0aGUgZmxhdHRlbmVkIG1vZGVsLCB3aGljaCBkb2VzIG5vdA0KPiBu
ZWVkIHRvIHVzZSBkZXZpY2UgdHJlZSBwcm9wZXJ0aWVzIHRvIHBhc3MgZG93biBpbmZvcm1hdGlv
biB0byB0aGUNCj4gY29tbW9uIERXQzMgY29yZS4NCj4gDQo+IEFkZCAncHJvcGVydGllcycgaW4g
ZHdjM19wcm9iZV9kYXRhIGFuZCBzZXQgZGVmYXVsdCB2YWx1ZXMgZm9yIGV4aXN0aW5nDQo+IHVz
ZXJzIChkd2MzLXFjb20sIGR3YzMtZ2VuZXJpYy1wbGF0KS4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwg
Y2hhbmdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29t
Pg0KPiAtLS0NCj4gY2hhbmdlIGluIHY0DQo+IC0gbmV3IHBhdGNoDQo+IC0tLQ0KPiAgZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMgICAgICAgICAgICAgIHwgMTIgKysrKysrKysrKy0tDQo+ICBkcml2
ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMgfCAgMSArDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2R3YzMtcWNvbS5jICAgICAgICAgfCAgMSArDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dsdWUu
aCAgICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAy
NiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggODA1
Y2QyMmY0MmUwOTYxMjUyYjAzNzFkYTliMTZjYzgwNGU0OTM0Mi4uMzVmOWM1NjYzNTg4ODZjMTA2
ZDM2MGRlYTg0ZjJlNmYxYWMxOTY4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTE2NjgsNyArMTY2
OCw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfY29yZV9leGl0X21vZGUoc3RydWN0IGR3YzMgKmR3YykN
Cj4gIAlkd2MzX3NldF9wcnRjYXAoZHdjLCBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRSwgdHJ1ZSk7
DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIGR3YzNfZ2V0X3NvZnR3YXJlX3Byb3BlcnRpZXMo
c3RydWN0IGR3YzMgKmR3YykNCj4gK3N0YXRpYyB2b2lkIGR3YzNfZ2V0X3NvZnR3YXJlX3Byb3Bl
cnRpZXMoc3RydWN0IGR3YzMgKmR3YywNCj4gKwkJCQkJIGNvbnN0IHN0cnVjdCBkd2MzX3Byb3Bl
cnRpZXMgKnByb3BlcnRpZXMpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZSAqdG1wZGV2Ow0KPiAg
CXUxNiBnc2J1c2NmZzBfcmVxaW5mbzsNCj4gQEAgLTE2NzYsNiArMTY3NywxMiBAQCBzdGF0aWMg
dm9pZCBkd2MzX2dldF9zb2Z0d2FyZV9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAN
Cj4gIAlkd2MtPmdzYnVzY2ZnMF9yZXFpbmZvID0gRFdDM19HU0JVU0NGRzBfUkVRSU5GT19VTlNQ
RUNJRklFRDsNCj4gIA0KPiArCWlmIChwcm9wZXJ0aWVzLT5nc2J1c2NmZzBfcmVxaW5mbyAhPQ0K
PiArCSAgICBEV0MzX0dTQlVTQ0ZHMF9SRVFJTkZPX1VOU1BFQ0lGSUVEKSB7DQo+ICsJCWR3Yy0+
Z3NidXNjZmcwX3JlcWluZm8gPSBwcm9wZXJ0aWVzLT5nc2J1c2NmZzBfcmVxaW5mbzsNCj4gKwkJ
cmV0dXJuOw0KDQpTZWxmLW5vdGU6IHBlcmhhcHMgaW4gdGhlIGZ1dHVyZSB3ZSBjYW4gZmlsbCBv
dXQgYW5kIGNvbnNvbGlkYXRlIGFsbCB0aGUNCmR3YzMgcHJvcGVydHkgZmllbGRzIHVuZGVyIGR3
Yy0+cHJvcGVydGllcywgYW5kIHdlIGNhbiBkaXJlY3RseSBjb3B5IHRoZQ0KZW50aXJlIHN0cnVj
dCB0byBkd2MtPnByb3BlcnRpZXMuDQoNCj4gKwl9DQo+ICsNCj4gIAkvKg0KPiAgCSAqIEl0ZXJh
dGUgb3ZlciBhbGwgcGFyZW50IG5vZGVzIGZvciBmaW5kaW5nIHN3bm9kZSBwcm9wZXJ0aWVzDQo+
ICAJICogYW5kIG5vbi1EVCAobm9uLUFCSSkgcHJvcGVydGllcy4NCj4gQEAgLTIyMDgsNyArMjIx
NSw3IEBAIGludCBkd2MzX2NvcmVfcHJvYmUoY29uc3Qgc3RydWN0IGR3YzNfcHJvYmVfZGF0YSAq
ZGF0YSkNCj4gIA0KPiAgCWR3YzNfZ2V0X3Byb3BlcnRpZXMoZHdjKTsNCj4gIA0KPiAtCWR3YzNf
Z2V0X3NvZnR3YXJlX3Byb3BlcnRpZXMoZHdjKTsNCj4gKwlkd2MzX2dldF9zb2Z0d2FyZV9wcm9w
ZXJ0aWVzKGR3YywgJmRhdGEtPnByb3BlcnRpZXMpOw0KPiAgDQo+ICAJZHdjLT51c2JfcHN5ID0g
ZHdjM19nZXRfdXNiX3Bvd2VyX3N1cHBseShkd2MpOw0KPiAgCWlmIChJU19FUlIoZHdjLT51c2Jf
cHN5KSkNCj4gQEAgLTIzNTgsNiArMjM2NSw3IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJcHJvYmVfZGF0YS5kd2MgPSBkd2M7
DQo+ICAJcHJvYmVfZGF0YS5yZXMgPSByZXM7DQo+ICsJcHJvYmVfZGF0YS5wcm9wZXJ0aWVzID0g
RFdDM19ERUZBVUxUX1BST1BFUlRJRVM7DQo+ICANCj4gIAlyZXR1cm4gZHdjM19jb3JlX3Byb2Jl
KCZwcm9iZV9kYXRhKTsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1nZW5lcmljLXBsYXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYw0K
PiBpbmRleCBkOTZiMjA1NzAwMDJkYzYxOWVhODEzZjRkNmE4MDEzNjM2YTBmMzQ2Li5hZjk1YTUy
N2RjYzI3YTdhMTRkMzhkY2M4ODdmNzRhODg4ZWQ5MWU2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9k
d2MzLWdlbmVyaWMtcGxhdC5jDQo+IEBAIC03NSw2ICs3NSw3IEBAIHN0YXRpYyBpbnQgZHdjM19n
ZW5lcmljX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcHJvYmVfZGF0
YS5kd2MgPSAmZHdjM2ctPmR3YzsNCj4gIAlwcm9iZV9kYXRhLnJlcyA9IHJlczsNCj4gIAlwcm9i
ZV9kYXRhLmlnbm9yZV9jbG9ja3NfYW5kX3Jlc2V0cyA9IHRydWU7DQo+ICsJcHJvYmVfZGF0YS5w
cm9wZXJ0aWVzID0gRFdDM19ERUZBVUxUX1BST1BFUlRJRVM7DQo+ICAJcmV0ID0gZHdjM19jb3Jl
X3Byb2JlKCZwcm9iZV9kYXRhKTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIHJldCwgImZhaWxlZCB0byByZWdpc3RlciBEV0MzIENvcmVcbiIpOw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyBiL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1xY29tLmMNCj4gaW5kZXggZGVkMmNhODY2NzBjMGJkN2NlYWRkM2NiYTNmYTVlY2Y5ZTdl
MDJiNS4uOWFjNzU1NDc4MjBkOTc4YjRhMzJlNTcwZTVmNTlhMjgwN2JlNjhhMiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtcWNvbS5jDQo+IEBAIC03MDQsNiArNzA0LDcgQEAgc3RhdGljIGludCBkd2MzX3Fj
b21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlwcm9iZV9kYXRhLmR3
YyA9ICZxY29tLT5kd2M7DQo+ICAJcHJvYmVfZGF0YS5yZXMgPSAmcmVzOw0KPiAgCXByb2JlX2Rh
dGEuaWdub3JlX2Nsb2Nrc19hbmRfcmVzZXRzID0gdHJ1ZTsNCj4gKwlwcm9iZV9kYXRhLnByb3Bl
cnRpZXMgPSBEV0MzX0RFRkFVTFRfUFJPUEVSVElFUzsNCj4gIAlyZXQgPSBkd2MzX2NvcmVfcHJv
YmUoJnByb2JlX2RhdGEpOw0KPiAgCWlmIChyZXQpICB7DQo+ICAJCXJldCA9IGRldl9lcnJfcHJv
YmUoZGV2LCByZXQsICJmYWlsZWQgdG8gcmVnaXN0ZXIgRFdDMyBDb3JlXG4iKTsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2x1ZS5oIGIvZHJpdmVycy91c2IvZHdjMy9nbHVlLmgN
Cj4gaW5kZXggMmVmZDAwZTc2M2JlNGZjNTE5MTFmMzJkNDMwNTQwNTllNjFmYjQzYS4uMzAwMjYw
ZTExYWRlY2IwZTViNTgxYmZlMmI2MWMyYzY5MjhlODc0ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9nbHVlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nbHVlLmgNCj4gQEAg
LTksMTcgKzksMzEgQEANCj4gICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiAgI2luY2x1ZGUg
ImNvcmUuaCINCj4gIA0KPiArLyoqDQo+ICsgKiBkd2MzX3Byb3BlcnRpZXM6IERXQzMgY29yZSBw
cm9wZXJ0aWVzDQo+ICsgKiBAZ3NidXNjZmcwX3JlcWluZm86IFZhbHVlIHRvIGJlIHByb2dyYW1t
ZWQgaW4gdGhlIEdTQlVTQ0ZHMC5SRVFJTkZPIGZpZWxkDQo+ICsgKi8NCj4gK3N0cnVjdCBkd2Mz
X3Byb3BlcnRpZXMgew0KPiArCXUzMiBnc2J1c2NmZzBfcmVxaW5mbzsNCj4gK307DQo+ICsNCj4g
KyNkZWZpbmUgRFdDM19ERUZBVUxUX1BST1BFUlRJRVMgKChzdHJ1Y3QgZHdjM19wcm9wZXJ0aWVz
KXsJCVwNCj4gKwkuZ3NidXNjZmcwX3JlcWluZm8gPSBEV0MzX0dTQlVTQ0ZHMF9SRVFJTkZPX1VO
U1BFQ0lGSUVELAlcDQo+ICsJfSkNCj4gKw0KPiAgLyoqDQo+ICAgKiBkd2MzX3Byb2JlX2RhdGE6
IEluaXRpYWxpemF0aW9uIHBhcmFtZXRlcnMgcGFzc2VkIHRvIGR3YzNfY29yZV9wcm9iZSgpDQo+
ICAgKiBAZHdjOiBSZWZlcmVuY2UgdG8gZHdjMyBjb250ZXh0IHN0cnVjdHVyZQ0KPiAgICogQHJl
czogcmVzb3VyY2UgZm9yIHRoZSBEV0MzIGNvcmUgbW1pbyByZWdpb24NCj4gICAqIEBpZ25vcmVf
Y2xvY2tzX2FuZF9yZXNldHM6IGNsb2NrcyBhbmQgcmVzZXRzIGRlZmluZWQgZm9yIHRoZSBkZXZp
Y2Ugc2hvdWxkDQo+ICAgKgkJYmUgaWdub3JlZCBieSB0aGUgRFdDMyBjb3JlLCBhcyB0aGV5IGFy
ZSBtYW5hZ2VkIGJ5IHRoZSBnbHVlDQo+ICsgKiBAcHJvcGVydGllczogZHdjMyBzb2Z0d2FyZSBt
YW5hZ2UgcHJvcGVydHlpZXMNCg0KTWlub3Igbml0OiBwcm9wZXJ0eWllcyAtPiBwcm9wZXJ0aWVz
DQoNCj4gICAqLw0KPiAgc3RydWN0IGR3YzNfcHJvYmVfZGF0YSB7DQo+ICAJc3RydWN0IGR3YzMg
KmR3YzsNCj4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gIAlib29sIGlnbm9yZV9jbG9ja3Nf
YW5kX3Jlc2V0czsNCj4gKwlzdHJ1Y3QgZHdjM19wcm9wZXJ0aWVzIHByb3BlcnRpZXM7DQo+ICB9
Ow0KPiAgDQo+ICBpbnQgZHdjM19jb3JlX3Byb2JlKGNvbnN0IHN0cnVjdCBkd2MzX3Byb2JlX2Rh
dGEgKmRhdGEpOw0KPiANCj4gLS0gDQo+IDIuMzQuMQ0KPiANCj4gDQoNCkJlc2lkZSB0aGUgbWlu
b3Igbml0LA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMu
Y29tPg0KDQpUaGFua3MsDQpUaGluaA==

