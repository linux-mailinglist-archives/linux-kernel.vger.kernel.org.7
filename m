Return-Path: <linux-kernel+bounces-831316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0ACB9C568
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B4D325DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4428DB76;
	Wed, 24 Sep 2025 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LiKGI+Hr";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wsk6lRmn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KnvkrxAp"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE55286D5C;
	Wed, 24 Sep 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752067; cv=fail; b=svZyzMGv6GOK8OeE35htw9qX9eWHrqH3AOnzg2wWuFO/8jTJuDOjr+y5QSB73XvDwuvzANp8Ns2p47/SjIGVcCAe31kS+z2g3I9UuQT8o+WeuVq7wdr62ymun9gaKwSKyRxTsyALWHM3wC1OxXchPzwHyJI3WJ34ahb4433NgYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752067; c=relaxed/simple;
	bh=HeuFjoHveLBQEJkZGskC/wZmGTC2OenCjB6cn3bSnI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+yDoXR96aBAk+KE2xppaWNrkZ67U5vPvKM2hgoG+5OmSpm709Yd6MQIqBRoFcca35OF1nseGmN6WCh/0WvvKJeVmG4OOEwFQd76TTo2Mk2h85XLbDcXeV/oTiVNvih7G5o/0Ul3Uc4kB75fCtLJ5+zmKVdrJtCYrQPCCpt8TX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LiKGI+Hr; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Wsk6lRmn; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KnvkrxAp reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OKdXTk016139;
	Wed, 24 Sep 2025 15:13:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=HeuFjoHveLBQEJkZGskC/wZmGTC2OenCjB6cn3bSnI0=; b=
	LiKGI+HryyfoYbuHC+eoToGrmBQv1Rt0kGk5346mtMkgBiw1wtrRP0qDyG3RQ4gQ
	FuoBTzSMvrDYr/ZhIcsz9EX1hgMAMLFAN5rPR7bt5eTfUEbmjqkbeLYDzs0IiK2+
	xCE9a3IWvKwrGDBMfP0rTeYJGhOZk0N4mBMKUH6NHptXlxW/SYi4Y0jV3F0VVgpl
	3UMijGlgFdizRoII0d+Rtlz6XCNI2y+/GrCeJHb9lUhcy2FlAAuxzjYgHJA9Smsk
	w/+WyiJ3KwyZoPz4dG9DxEpsq3UDSw4SClSZofR72igTK5Xt+7kUTYV60hur6LGI
	OxocXgZLIzsBR8P6eXWorQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49bsr0anpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1758752024; bh=HeuFjoHveLBQEJkZGskC/wZmGTC2OenCjB6cn3bSnI0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Wsk6lRmn78Ls/VPzyZwSnpg6AKw0BrxAElI4GelyVk/XHZHZVrdNf3L8t5BMkrUsb
	 qMBxOjs82Flp/yoFGOP10Mbhvep6wCkJfwl7FJYG5wgKvzQ69delo1S25pPStHiyKL
	 9pGYd7ZwFi8qwEhRvN1qVGhp45jMvGQCWgWXe2duVsfiEavzADLJS5IkapqxLUZvqC
	 mPi8sK60abjsB1qd95Fw+mA6r3uEQmturD9C7Rherg/EulydIf+7f0S3atfL+ruPRt
	 pkSd/3w/ND4FXBbT2dCH3ZkGxdUsu0QVnz3JVArb/XfFjCHOd3BREGUSkfoFsJBgXV
	 cCcMkYsd1rnWg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A12F6401F9;
	Wed, 24 Sep 2025 22:13:42 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5EAB6A006F;
	Wed, 24 Sep 2025 22:13:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KnvkrxAp;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00100.outbound.protection.outlook.com [40.93.13.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 019F240346;
	Wed, 24 Sep 2025 22:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzevxPXvpmW7qKg7KcrE1plI9tzDRzsDuFtBO12vAFNk1gB+PLQJbQAkjQJ6W1XCncVC1/6xsu6RPhTnP8j+NQVBenK/5y82Uymm9zM0vZMkMJqc7CEsSQTqf9XKv0PIc7H7tn/w7OWH2oNS0EIsjvPLANroEdeIsWw1vvAvSwEIYbaqBXpSLJhoO+AdMW0vxDuGZohKRBlylJTfciMYPi4F9sWZeSz6eTX+M+vsippxzByfX/yKrd9krzORPaPNuvrHXzS+JkEiewWSbcCmQQBEUWVDEur1Ssb+F0FD4Z114inGGHHB6yS2XN/+NjMziDt9g43aYzLNs/DIXu2mKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeuFjoHveLBQEJkZGskC/wZmGTC2OenCjB6cn3bSnI0=;
 b=kg5ka6zwZKaDbQNoJcUH+3/bZoRVq4H1sIfo05h//lRBPxF1xnwWz/RGJW02M1iDn+7ekyDBMg7F/CAI6KjvNAbU0IebTB3UX/WUpqKxm1OOB8CFZV/vAT8IqYiNVYZY9odYNJ8+PI/ypO7orF86y5ERBE29J+cRe9/ZSMiCmHPFNKmN7fQ7cq5tMkKInxf11a7q6Tdi8luvSP5SCtB0fiFwXsj7aNwkC/NfVphzU8TzNsRWo7gd1ICFib7o7aL104gLbnfw5b1GuGJTrcX3345QAdiZQVBntKigwo5ZZz/08hZMsC0Asg2VXe3k3NwgzHH/mNfoiALp7TuqbrYG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeuFjoHveLBQEJkZGskC/wZmGTC2OenCjB6cn3bSnI0=;
 b=KnvkrxApRskMchgsbuiaFnrKRmwCLXm5QV+pejZNTszcNjAPiUAZxPQSUYaZzFHTic48o6uEKC+ocze1C9LTOR5WOI/Xxj2pnriXP/i9ldrwNPXURE1oPEQsrfUUzVFHhlJhwk1kjpHfkDTfSbx6WOuwSuK/Y+n5y6Gyy7IHTzo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 22:13:37 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 22:13:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
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
        Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v2 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Thread-Topic: [PATCH v2 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Thread-Index: AQHcLMfm+bZ7U2qihEG+JeLp3z4omLSi51uA
Date: Wed, 24 Sep 2025 22:13:36 +0000
Message-ID: <20250924221331.migo5szpf4svxpyr@synopsys.com>
References: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
 <20250923-ls_dma_coherence-v2-2-ce3176396bdb@nxp.com>
In-Reply-To: <20250923-ls_dma_coherence-v2-2-ce3176396bdb@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB7482:EE_
x-ms-office365-filtering-correlation-id: dc3eec28-0ed5-4dc2-0b89-08ddfbb79be4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlBMTUlEb1VqMXB4ZEVJRnVnYWpvRTNzenA5alV3YTYrTXVsV2RMRndRc2hY?=
 =?utf-8?B?VEZjc2lITzc2d3FWNFZYaEErck1PaTlKdFZVendtUU0zeVJWVXV0NjRZWFhR?=
 =?utf-8?B?OFdKdXhXMDZ4d051T1RURFdpS1hjRCtjNGpxamkwS21OYndmdHNiZ0NaMGs1?=
 =?utf-8?B?VWxSSGtWNTZKUFlwN2E3ZTBXSkdRQitlZGFtaCtBM21HQ1JYUVZtUzl3U2l2?=
 =?utf-8?B?dTArWmpXd3l0VHlONnZQZ1hmUTAyLzM2M2hxcEhTOTN6RERtV0NrVWJNNXlB?=
 =?utf-8?B?L2FUWVh1a3I2Zlp1UWFUQVdtQ0FwUlVVbE5YNzBnanVRbU9Ib1VYNUpSOTNZ?=
 =?utf-8?B?d2ZOMVZqR1BDNXFrSi9lUDRZQTZKZjRBcytNRFQ5YXhXajRpdW9nQXZRNGov?=
 =?utf-8?B?YkxMSDdOdEszVDZqK3UvaC85UGV2eG1EUm05MGRYbVNJRG94VWltQ0gydDFu?=
 =?utf-8?B?aTR3TDB5MmcvcjVsM0hzQmpjd0IxOFN1ejVCd2RScWI5VzdiS1NBUm5mNUg1?=
 =?utf-8?B?U05jaGU3WGZrbUFGN2dLOWJvUUhEVDMyekZjZm1NQW5GeHF0aWxQSlRxeXVQ?=
 =?utf-8?B?TlFJc3prQXJYZW9ta0RjbkpBcm9TVDR4cXNmdDJ4cUpCb3JlRVYvc0VjZG5G?=
 =?utf-8?B?N1NIWU9MODVKM3ZwZ2pOWXdDclpIdHhTT1lnQTJKMXNJVURqQW9Rdml0eGpG?=
 =?utf-8?B?SkNrbStYYTJ2eEpxeUg4TTRFN0Nza3pWbXpUVzFvUzljall0Sk9JN25DeFlz?=
 =?utf-8?B?MzF0dE1kSUxQVXNJclN2ZE84UW53QjJVVE5kT2pLU1M0UGUxUlppUURtRktH?=
 =?utf-8?B?b1k4NXZWSHFFQWZOZi9rRlM2V1lsbG1qenI4MXBiYzFhdm0vZEsySWduaFd2?=
 =?utf-8?B?YmJlRXFGYjdRMG81STdoakhSQVRqbmtJVnRHb1V4TTJZQ3YzdVFGTGZaRTRm?=
 =?utf-8?B?RkVxOTZuZitHVGVOUTF3UzQ0SnE2VzJGb0VzZEJnbGQ1Ulo0bWJSbmcwYUFN?=
 =?utf-8?B?dGxiaEZ3NitNSzVWdnJpQWwwbm1YdkF2dW5seHRrRVQ5Uit5dTNUZFlNMTlq?=
 =?utf-8?B?cCtYNEpQVDBCeWZSelBHdTczVVVNSzZ4Ty82cUpYanUwbk51V1ZIcGxPUXk1?=
 =?utf-8?B?OFdCUEFJTzFtdjlSOUtHYlZDZFdWL29KUmIzbjY4cGJzLzVxVTVTMzVDdVFw?=
 =?utf-8?B?eHRnaWlVS1h2bkpJbTRhdCtxQlRCckRxQ09iT1hVcUNJcEEwb2lxWFg5dnl6?=
 =?utf-8?B?Y2N5UElXTjBLS2RkVGp3UjM0dXQ2d1c3eHBkTzhrYU1zczhmMVZ1WmI5ZjBP?=
 =?utf-8?B?L0tBK0dYK0l4dXdPMFl2MkljMVNEclJOK2pGT2FSaDJFbDRTWHhraHp0VXNx?=
 =?utf-8?B?S2F4blJKZkNTNmpNSHVtQzF4b1cvV0dMV2cwTlZqN1JVOTcraTliRjlvVG1P?=
 =?utf-8?B?K3dmczkzTzNQV3VJeHBKajl2MGdHY0dnQUpjSktYY25LczNkeVRGTCtGcE9B?=
 =?utf-8?B?aE0yYTBROUVna01qSTBvMWl4cjRZS1ZCZWsxZ3dhWjBHalJKNmQvdmp5Zm5S?=
 =?utf-8?B?WlZDOHZiOW5aeDhQbVRFaHV6MUdmUHhhb2JyR3YxREQyUnlXWVAraFo4ZWdH?=
 =?utf-8?B?cnRSa1EvVnJ3a1FrdHp6SjlQbHppckh2UTUwUHVyUWhQcFgrUU41NURzZTNE?=
 =?utf-8?B?cmRNdnhmWTZVdEE0aXJGNnNGaStjVXNJNzhzYWp1c0VvY2JvdGtoMTNjOFhk?=
 =?utf-8?B?UnFTakhkWUFjaG9pamRCdURDTWJMVkpERTQvUEYvVEpyaDcwREZ3TG1vRTlu?=
 =?utf-8?B?dC9MRnpjY0ZvdTdxVmVQVm9TRkdEZUFwMHdXLzRDSkM2NGRGQzAyRDljRnJz?=
 =?utf-8?B?VkV1c3N4WGdnYlNkZmhnRk11VzNRYXYwOEVrMTlqUFZsZDhkSWdITWJOdWdS?=
 =?utf-8?B?d293aFlQcXh6RjM5aUs1b1kyUGdlbEQxT0NLS1Q4VVk5aTNyOFV6L1NhdnFm?=
 =?utf-8?B?Z1FqUHdsVHZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFBrdU83bUZKNjRqc2Q4dW5yamtYNkoyWXlyMDdEdjBvWTRLYnJrMlQvNXVq?=
 =?utf-8?B?WjZURnVmSE54M0YwaGRPWnU0Ynd4ZTUzcHM0a2NIaXRkSGwyYjRRQk1QbElG?=
 =?utf-8?B?YzJodXJiRnRBS1NGWGxTRkJZa3ZZWWJRNGtiSHlVTUFLLzBGSEw0TmxmanVU?=
 =?utf-8?B?NDErNG4yL0tBRG5ZU0JDdGYxeWtJYzZXZlBJYVJ4cTRlc21mTytGMjVqWSsw?=
 =?utf-8?B?UWI3YnpDczZMbDY2bFVIWGhYWDEzczloa1hyZnRqRzlGNjQxanJJbHdSTDJB?=
 =?utf-8?B?TWhMUlVVOFdyZDJQNGFEbnZDem1lakptN1J6dTZSeXBlQ2Q2ZG4xTDdjSVR0?=
 =?utf-8?B?ZHU4cU4wcmthOVdPSDlYZTJQS3I2NUdJSG01a1BKeGFsdGVoL0ZqT2Y0ekpF?=
 =?utf-8?B?QmpEaHIzK3pNaURXTGRUVnVjWW84QkJSS3NaZURwRG5WMGNpZW9TdkpCWTkr?=
 =?utf-8?B?U1pBVWo1dkxtS3FZSDR2bnJLbEVSYWxqUWF5SlZpbDlaRVV2UUx4OEVuenJS?=
 =?utf-8?B?WnRrTkRNRm9jdkN2aGpkeWJjOXNxa3Zvb3lNMVNrbTBNMzFWb0ZMaExjK2lp?=
 =?utf-8?B?Qll6TXc2aUFnSG5jeE0xNzJuVkk1bmE3YzUwWXFScEVrbmx3VzVCMTdHMGc1?=
 =?utf-8?B?R09FUTdEYzZjekhvbzlXVGhZQ2NRM01OK1BVUXZ5MG1xdU9HU1RxaTZtemxO?=
 =?utf-8?B?SzNJSlpoeEsvREZzdE5tMXZWSEJHVUQ0dXBBeXQwVkZtcTFNYVpBODM2M1gz?=
 =?utf-8?B?TGo0Sk5QQVZqVThrUUdNeXRKZTYwMnFMMm5XdjlwRWF6OEY5S1F2SE1QWHZz?=
 =?utf-8?B?TGRvNUp2UEZ6bWJiTGFKUm4wSm5ZQVRuRDhaUjh0ejBCK1VySW5TTjQza0Yy?=
 =?utf-8?B?aVpNd01nNG9LMEgvcXNVTHkyQ0JlL3BJZnlSKzVITjJFRzN6MzN3SmUwRVJN?=
 =?utf-8?B?UEYyeXdMQy9ad1NWa20xSmtaQWNobUtRZXFkdHNKREJBNGVEb2h5emFJS095?=
 =?utf-8?B?RHRpV3ljelRxRDhMdzR4YlRHWlRZQWx4bENCUjc5dEFaMjVDNEJOTjB4dGVp?=
 =?utf-8?B?Q1l3TURnbitKUzZUUDVIODMzTEk4dmczSlNTd29zV3NOY0xrMHFXRnBQcEpH?=
 =?utf-8?B?ZXNoblZMVEFuMmQ4TS8vaWM1UWt1Rm5XdE1qa3BHOFpWdWRRdWY1anVEN1VS?=
 =?utf-8?B?M2tBMUZXc0dBc3NSY3RJa1l6dHIwblF4QjlwUFVlOHZzWTBlaDZ6dm1HV2xF?=
 =?utf-8?B?RnRqbWJRdWI2UmxiZUh0R1h5Wnh6bzE0TWxPQjl6SzJ5MHpkcVQ2Tk00MHcr?=
 =?utf-8?B?K1ZlazF5dlZQN293YVgyR2NORVVKRm9aSnpXQzhRcnNBUkNuN2I0NGNGaUlm?=
 =?utf-8?B?QUF2U2ZGVVp1ME4zeHUzREhvbVJHZ1U4czMzRGNUWDdEQmdNblVIL3hrUUZ6?=
 =?utf-8?B?eFFYY2J2ZHM2b3ZSekZHWWhocCthUnJhSnd4bkYzZ05FbDBCQmJhTU5XbjF2?=
 =?utf-8?B?aWsyc1hqTGhIa3Z4NTdvbHZvVUhmWDhtbDBScXpsWFhrZGlEbjRQR2VYeDB0?=
 =?utf-8?B?cTFhUGdtNVFNN3BqY0FQVGVabER3eHBML0tlQ3VtcVNFdzZJVlFLZnVDTGNY?=
 =?utf-8?B?VWE1ZXBKNVdYQkVhd01YVVlwaGFBNWhXN0V2ZGRmZWE0ZDNtakR0dFVWMjBq?=
 =?utf-8?B?YzBpOEpqcFBXV3k1bmlCS1VtazY2NGc0WGdkR0VRNmJHdzdUaEcvbXRnY05t?=
 =?utf-8?B?a1E5a2VOL25KYXdFSHBaREIvRDQ4MHpPUU9wM3dpSkNWUjZXVnN1MzM5TDNC?=
 =?utf-8?B?N0l6TjFJa05PZDVlQWsraWFYdU8vSXBKOTJUUTZQckVzK0VVMUtjZXFuU3A2?=
 =?utf-8?B?ald4SUZNVzZWcVViaWVpYlVDNTl5M3B6ZW5hTmJiVTdrRnJEV0hmMnZEVDRj?=
 =?utf-8?B?L1B0ZkVHSXd6R29uOElRMnFwZTRWZW1hNzhxQ0hPRVBBZ21XSnEwV2t5T2FZ?=
 =?utf-8?B?NnplZUZVR2c5eFZIVE9SWEloWWpQZFRLMS9pcHRMRmh2cnI4Tzh3bmRkdVBD?=
 =?utf-8?B?KzRJSUIyWHNQdGhXbDl1MHhJNk1iSEZrcGJyNmpyakw3WnlScjdpRmVXbENs?=
 =?utf-8?Q?HFgLkkwl7j5AGvKo40TRmXdPa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F216D865612A4429DC918C3AC814E3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2K0t/+rExZO2zhCtUZRMWdTzCSIjPmwAhEHxYc7p+GkzVcbSZyHMO4nimKkQUQfQxZxl/G/6vr6FjwejgbGW7SHnKT9oeT20WUeL3yXDdCFoJ+2nobmOXbI3XSypFwK7gnJCg157d0eaxmcH7OQXpxB9ZOkcgAfn0c5OPasp26/Ifia0gqo7+dgjvQt9DMorijALO6rzyZisb0X4aGtOAiSfV766MW6+2rbZGJl+b003aefI00PHmV7KHr9zlNo7MeAf8tvZSi5Rluc+zI26LJrX/NFbNIFBNvm/el6EfuUBwqGmLyVfx+DEFl/Vs54M90j0+Nf6dqhyRNMLKq90ZWtuaL+xbJyniUsXTFgesHeD9hcISQEXdwZfEZgt9xQKOylzxyFAudtrJ0pEvle5VnLRBTwLBZZ3XmQ9nvdOW4WWDX9tw781q1iWjKwluQFhP6plEKom67lOIoq5nq/yUXH0lprq6ROd3xqyZtwVhB33x/GI4bmXdy8gJoJZq70ZnzFy+6axbmo2JVJH9bUCAjXvtXgKUyuxkM46AfbsQq9D/AAKefuykVGRsz9bKYpml6anFER4KVQkZ/MCC1co+X5dLGm3jJeCQC8e27YrCDAAQnzNjyrtL1v5gVK6IMvIb/o3Lw3oYhkGXBzEOpWh8A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3eec28-0ed5-4dc2-0b89-08ddfbb79be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 22:13:36.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLYrJyyIaBuMdPYTJa79Dn6OzVwW3n0N4swSXQgVjSeKXTMJKzAiHJMLt+5VAmmn+i3PYZ/ds6v7tGWQqhGFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
X-Authority-Analysis: v=2.4 cv=EofSrTcA c=1 sm=1 tr=0 ts=68d46d19 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=8AirrxEcAAAA:8 a=mtIJYrd9xzXMJWcBdw4A:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: E4uYteZpVzsrvJ6EJJKO48RWNPHNhnPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA5MiBTYWx0ZWRfXyBGDbksEEvSa
 sjuxI/TnqpjoS9CR6SzzLMMWyPf/+J/H62VgDMsJiGWuEhl6lqpQA9q1Fv6n0ImPWQcG+TR6iGL
 czcmaoeua2DpHMfgCo2xlVL77kFOJIj4UiGvhZ1t9X7PQsusOkOyx6nVIcIlcwSgaTVyYlWbwwZ
 +rsllNH6hxX+mFC7lGaQ78UjpuykHouqf5PXizKpj4StwF3NRmjWHSivwSRYcRWk5jlSKAAEKsX
 Z623m/HPP64rjpPAvknYEZpOWRvsX4HpNdl+FOq0b54ft5CjkUJjmwd5lz73F4+d3A4bTDaOnzi
 y2SMIW92+dx21lQzk6LWkroe3hoRuCUPvvh487IYv5o7PlDXnnNXvJZ1AyzHuG5NDEpFvG+tdyH
 UISyQYUc
X-Proofpoint-GUID: E4uYteZpVzsrvJ6EJJKO48RWNPHNhnPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509230092

T24gVHVlLCBTZXAgMjMsIDIwMjUsIEZyYW5rIExpIHdyb3RlOg0KPiBBZGQgbGF5ZXJzY2FwZSBk
d2MzIHN1cHBvcnQgYnkgdXNpbmcgZmxhdHRlbiBkd2MzIGNvcmUgbGlicmFyeS4gTGF5ZXJzY2Fw
ZQ0KPiBkd2MzIG5lZWQgc2V0IHNvZnR3YXJlIG1hbmFnZWQgcHJvcGVydHkgc25wcyxnc2J1c2Nm
ZzAtcmVxaW5mbyBhcyAweDIyMjINCj4gd2hlbiBkbWEtY29oZXJlbmNlIHNldC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYyB8IDMwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1w
bGF0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCj4gaW5kZXggZDk2
YjIwNTcwMDAyZGM2MTllYTgxM2Y0ZDZhODAxMzYzNmEwZjM0Ni4uZDg4NmI2ZTU1N2IxMmVkZGE3
MTIwM2U0ZjY0MGE5YTBhNTNiNGYzNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9k
d2MzLWdlbmVyaWMtcGxhdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmlj
LXBsYXQuYw0KPiBAQCAtOCwxMCArOCwxNSBAQA0KPiAgICovDQo+ICANCj4gICNpbmNsdWRlIDxs
aW51eC9jbGsuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4N
Cj4gICNpbmNsdWRlICJnbHVlLmgiDQo+ICANCj4gK3N0cnVjdCBkd2MzX2dlbmVyaWNfZHJ2ZGF0
YSB7DQo+ICsJdTMyCWdzYnVzY2ZnMDsNCg0KQXJlIHdlIGdvaW5nIHRvIG92ZXJ3cml0ZSB0aGUg
ZW50aXJlIHJlZ2lzdGVyIG9yIGp1c3QgdGhlIFJFUUlORk8NCmZpZWxkcz8gVGhlICJzbnBzLGdz
YnVzY2ZnMC1yZXFpbmZvIiBwcm9wZXJ0eSBvbmx5IHVwZGF0ZXMgdGhlIHJlcWluZm8NCm9mIEdT
QlVTQ0ZHMC4gUGVyaGFwcyByZW5hbWUgdGhpcz8NCg0KPiArfTsNCj4gKw0KPiAgc3RydWN0IGR3
YzNfZ2VuZXJpYyB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldjsNCj4gIAlzdHJ1Y3QgZHdjMwkJ
ZHdjOw0KPiBAQCAtMjksNiArMzQsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVzZXRf
Y29udHJvbF9hc3NlcnQodm9pZCAqZGF0YSkNCj4gIA0KPiAgc3RhdGljIGludCBkd2MzX2dlbmVy
aWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gKwljb25zdCBz
dHJ1Y3QgZHdjM19nZW5lcmljX2RydmRhdGEgKmRydmRhdGE7DQo+ICAJc3RydWN0IGR3YzNfcHJv
YmVfZGF0YSBwcm9iZV9kYXRhID0ge307DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYt
PmRldjsNCj4gIAlzdHJ1Y3QgZHdjM19nZW5lcmljICpkd2MzZzsNCj4gQEAgLTQxLDYgKzQ3LDgg
QEAgc3RhdGljIGludCBkd2MzX2dlbmVyaWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gIA0KPiAgCWR3YzNnLT5kZXYgPSBkZXY7DQo+ICANCj4gKwlkcnZkYXRhID0gb2Zf
ZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+ICsNCj4gIAlyZXMgPSBwbGF0Zm9ybV9nZXRf
cmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAgCWlmICghcmVzKSB7DQo+ICAJ
CWRldl9lcnIoJnBkZXYtPmRldiwgIm1pc3NpbmcgbWVtb3J5IHJlc291cmNlXG4iKTsNCj4gQEAg
LTcwLDYgKzc4LDE3IEBAIHN0YXRpYyBpbnQgZHdjM19nZW5lcmljX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCXJldHVybiBkZXZfZXJy
X3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIGdldCBjbG9ja3NcbiIpOw0KPiAgDQo+ICsJaWYg
KG9mX2RtYV9pc19jb2hlcmVudChwZGV2LT5kZXYub2Zfbm9kZSkpIHsNCj4gKwkJc3RydWN0IHBy
b3BlcnR5X2VudHJ5IHByb3BzWzJdID0ge307DQo+ICsNCj4gKwkJcHJvcHNbMF0gPSBQUk9QRVJU
WV9FTlRSWV9VMTYoInNucHMsZ3NidXNjZmcwLXJlcWluZm8iLCBkcnZkYXRhLT5nc2J1c2NmZzAp
Ow0KPiArDQo+ICsJCXJldCA9IGRldmljZV9jcmVhdGVfbWFuYWdlZF9zb2Z0d2FyZV9ub2RlKGRl
diwgcHJvcHMsIE5VTEwpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCByZXQsDQo+ICsJCQkJCSAgICAgImZhaWwgY3JlYXRlIHNvZnR3YXJlIG1hbmFnZWQg
cHJvcGVydHkgbm9kZVxuIik7DQo+ICsJfQ0KPiArDQo+ICAJZHdjM2ctPm51bV9jbG9ja3MgPSBy
ZXQ7DQo+ICAJZHdjM2ctPmR3Yy5kZXYgPSBkZXY7DQo+ICAJcHJvYmVfZGF0YS5kd2MgPSAmZHdj
M2ctPmR3YzsNCj4gQEAgLTE0NSw4ICsxNjQsMTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZf
cG1fb3BzIGR3YzNfZ2VuZXJpY19kZXZfcG1fb3BzID0gew0KPiAgCQkgICAgICAgZHdjM19nZW5l
cmljX3J1bnRpbWVfaWRsZSkNCj4gIH07DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZHdj
M19nZW5lcmljX2RydmRhdGEgc3BhY2VtaXRfazFfZHdjMyA9IHsNCj4gKwkuZ3NidXNjZmcwID0g
RFdDM19HU0JVU0NGRzBfUkVRSU5GT19VTlNQRUNJRklFRCwNCg0KV2h5IGRvIHdlIG5lZWQgdG8g
ZG8gdGhpcz8NCg0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBkd2MzX2dlbmVy
aWNfZHJ2ZGF0YSBmc2xfbHMxMDI4X2R3YzMgPSB7DQo+ICsJLmdzYnVzY2ZnMCA9IDB4MjIyMiwN
Cj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGR3YzNfZ2Vu
ZXJpY19vZl9tYXRjaFtdID0gew0KPiAtCXsgLmNvbXBhdGlibGUgPSAic3BhY2VtaXQsazEtZHdj
MyIsIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJzcGFjZW1pdCxrMS1kd2MzIiwgJnNwYWNlbWl0
X2sxX2R3YzN9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGxzMTAyOGEtZHdjMyIsICZmc2xf
bHMxMDI4X2R3YzN9LA0KPiAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiAgfTsNCj4gIE1PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIGR3YzNfZ2VuZXJpY19vZl9tYXRjaCk7DQo+IA0KPiAtLSANCj4gMi4z
NC4xDQo+IA0KDQpUaGFua3MsDQpUaGluaA==

