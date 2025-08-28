Return-Path: <linux-kernel+bounces-790850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF90B3AE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C91F189E154
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0A2D838F;
	Thu, 28 Aug 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aIGmE/xQ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KrEITuFA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T0xP7EsK"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C332397AA;
	Thu, 28 Aug 2025 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422932; cv=fail; b=IIFGuhxaMxZg9TUzdJ8s9cjxC+8uE6+uG1GZQSSVO5n6LVPJ09ekyyuiBZWpiOiRZbYNkKdheaZ2ok1Oghemac91zZn03UP5MzEokI4YxvajQ1J4sEFQgnPUZMZitnw3a+gJX3nlmg4wFg+BArS4vRdMLyAGPIQ7aGOj5IfHL3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422932; c=relaxed/simple;
	bh=k/b4dc9W+umMkNljiyfyRzfqGmQBDqAUN0plZz80qhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGMpxshtct5jBpZjB9FzFDmUibeAFJ9U9z6yuN6qIjD/2iZ6EysBlQQbh7nJd/1PBpCJi/reS/4N/adfP/X7yH+Kq+ea++m+S9WARkHbDaQcEuYEUTM9+Tv2jvMaxECfWxn0VKIVZKgCsj5Clxkhp7PRnkLGS1piRmrSqRri0NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aIGmE/xQ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KrEITuFA; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=T0xP7EsK reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SIsaAx011495;
	Thu, 28 Aug 2025 16:14:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=k/b4dc9W+umMkNljiyfyRzfqGmQBDqAUN0plZz80qhA=; b=
	aIGmE/xQu4vdvRMpF92qkK8bOuU/z00o6Js2ETEguwf1wNnkGx5Ht5AgUlFRPFhn
	Ot60dWoxUY+C/wbZ2qCZkFNIWjDayPRMflVBKqkaAEcJ3E65fOcC7KVrdxsaf5Xl
	vdIdqyk2R9GYan68BOwfkDQCyGHbeXp3IHQ0sUCqdsKeZEDum4MYbeY2Sog5dzrc
	PA84gXDntdXdgNOO/gGOUhfmotR8sItnvnpwFxMgvJ6Hl5QmswY1FnD8JrrzI92O
	rpiBOMfdTtDnf8mWT8y7Bx3ii44VQ3pIJZulz8aDtNcJUah+fR1WOuO+imaJNOUJ
	UYBUBF7fflUoDA3/o4wppA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48shagy4k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 16:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756422885; bh=k/b4dc9W+umMkNljiyfyRzfqGmQBDqAUN0plZz80qhA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=KrEITuFA6oRNqtEI5lvK+f3jni6siHp7EeyElb1LFd51tz1YRuhi23ilWuj+kEN03
	 a4fNIc/GwxIib9StWSVAEZ85i6IYnPMmixM+fxmWEaywpp25MCrIwlkpoQs0Kbm5jy
	 bUo/QGgxYuP/08X/GpuX0AF5Dml2HbYDae9qhb1GL1y5eXuKGa2R5PxtlqoiWDIyO1
	 6LW3lEvJ1K8lXQph1WBC+bVibmhBG3ZPlNXOzfBzfC/Wn0m2jPOqbgjhTja0T1QCsS
	 ENUqOmbiMncwfKzaeJpLk7CXSCXtMH3KpU0lasKenw1zlcK/GCOPFNZ+NYXN+S+5Le
	 pbR4gF6MN9JEQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E33384035C;
	Thu, 28 Aug 2025 23:14:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id BA5F4A0087;
	Thu, 28 Aug 2025 23:14:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=T0xP7EsK;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 441E440108;
	Thu, 28 Aug 2025 23:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPTM+JMgV0PFTjiUWBh3qUTe/BuDu958Qb8G/tZph0kPrZIWtcqKqguXuCNky71bTnGNYZDeUQCQLCfDR6jZg4sGCzT6zF+2OZL8NGtGOqWe82sCKPSX2VTymrcFVo5wfeuwEO7RLZm5x3UeEPC9wkyx6/NdwdB1XIWjwrZLpvqTuoXjyIByZzq6tr0TBGp9j2G2aoQplWu62bwCYNXqQqZq55dHTaruM9GcpvAmf5ngdg7uRb3wvSJtN6kemAy1rKq9MHIi0vlqvcqq0gGv4ksvjy/My3oJt8RT7rBsLAe0Fzz1F+lqqYcXga7CFnnLz6PN7ahGocapC321OVUHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/b4dc9W+umMkNljiyfyRzfqGmQBDqAUN0plZz80qhA=;
 b=rhDYhPBGquUK8EN1cQvxdJOPnRGjB9+4ErLgchgSlq2AvLETuOoSZ/qlKf0hbvofSQR21Dti6rpeoxJyysN4cuy2HuRkvntsmZ0gSPMWFiDvzNIHT2Ruh8b0lrDWWIpUTA49miXvnm2Y6mBayuApxDzkR6rtvPjJ0OPyXykwY09JrEvDmoR55YBbaWLSIM5II8LpynO/vMtHV8nRsNayvgmF0lqP/TEKXq4BLMn+WytVwC/keU8Wz6sAZytMbw36GSb72BnpWe1c/nQQk+LFf8kl+gZoohAg/OtvqlFXU2Z1pfA9aEjzqk3Z/ksE1g1LMpT0wy81vndZ1hnbnSuGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/b4dc9W+umMkNljiyfyRzfqGmQBDqAUN0plZz80qhA=;
 b=T0xP7EsKged56ERJPGP2lL/Ut9ZyRFYGXUPNGXpYscOf5us3n99S66PCSEVpesIJeGZcfCwqfg/R/+wv2cS4heJGS3KuOLMgC88yiaaByg5+yaLzJlxhHWJyW8iXtv4w0ANoq4tmv1Pa0PNpMcq2tdylQA4TO97SvlhP3hpIFy4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 23:14:35 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 23:14:35 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Sven Peter <sven@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH RFC 04/22] usb: dwc3: apple: Reset dwc3 during role
 switches
Thread-Topic: [PATCH RFC 04/22] usb: dwc3: apple: Reset dwc3 during role
 switches
Thread-Index: AQHcErHjYWp/DJLz50yFjSgGSmwaTbRtwHSAgAQwagCABszGAA==
Date: Thu, 28 Aug 2025 23:14:35 +0000
Message-ID: <20250828231434.koacer62sx6hyagx@synopsys.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-4-172beda182b8@kernel.org>
 <20250821232547.qzplkafogsacnbti@synopsys.com>
 <bc4fa511-5dc5-4844-8206-eb55783647e8@kernel.org>
In-Reply-To: <bc4fa511-5dc5-4844-8206-eb55783647e8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB5787:EE_
x-ms-office365-filtering-correlation-id: 0f12572f-dfd4-4556-a2ba-08dde688a75a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1F5VjE3aGxBejFPaDBMdzJBejRrOHlqaFU4V01xUnpwd0hCeGgrb2lTZGc5?=
 =?utf-8?B?WjZQeGFKdGVPRVIvYmtmcjhqV2dQTzIrNFV1VlBtRnBxL2dJaFhPMUc0WTFQ?=
 =?utf-8?B?WDFPOEc2Y2Ztamc5UHMrQXVKajJObUtvWUtxdzU0SUNkVUtOU0p5SlNOQmRj?=
 =?utf-8?B?KzdoRENnczV4cGsxdTVmTDVEVkJrRlRFcnNvMVE1OUszTHhLRldJOTJjWXAz?=
 =?utf-8?B?aXJKV1VJYllwQk9wZlRWSDRKcTNncDMrWkZNRVJuc0F6M3Iyc3RCQWZSSk54?=
 =?utf-8?B?KzdlRmpybGRXU1I2TElrQ00ybm5DYUpMMnN3T2FwSmFXWUk3YVJVQUQ0UDBL?=
 =?utf-8?B?eFJvaVBlUjV4K0dETjFxY1BwZWJvSzVLZjFKWE1wMlNJOElaYkdMWkNPVXVK?=
 =?utf-8?B?aDhqWGVIQ012NWk5a1NPSWpybEMzc0NORHpoUkNtR01rYlhHbVdHN0pvcjNF?=
 =?utf-8?B?d3RqazMza1F6blUyMmRNc0drSG13RW5qYS9CLzA0ekdJdkpWTTZWMFNlMWNj?=
 =?utf-8?B?V3RIRU8zUUlaeXA3a3ZVZlVVQXZUeWRRU01yekJWaVg3YmM2dGhDQUo4YkV0?=
 =?utf-8?B?TzdxakZ1Y1hsNHBEK0pBa3liYlhSZWtQUTNCRlo1UzBlNXozNm4xbnZqdVZX?=
 =?utf-8?B?TWcvVEpzc3FOdUtuaXNCdEdleVVFb3dPMzZUSStPQXFRbVBQUkxLbEg0YlY1?=
 =?utf-8?B?MFZKa0Q0S29VTzM4Uld4dmw4NlFTRlpDSTdBNG9yZVhOUUU4Mm5ING5MUU5N?=
 =?utf-8?B?SFE5VENuU3Q2TWhlemduNzJmOVlsbEwrMzU3T3RFTS9xN1doS0NkK01GU2x4?=
 =?utf-8?B?NVFHOXlLSFhFbHd0NnhqNWFZRTRUbUcwQUg0Y0tpZVdkR2VkZDBwODBkVENj?=
 =?utf-8?B?Rk9oTlIybUwyVTUrR292SEtZUmZrdXdKQVVhR1B1NEhValgxbmNmcmNPMlEx?=
 =?utf-8?B?Tk5pWHhoQUU3b1d1a2g5WnpzSHZwRndGZWhzMG1oaXpRQ0t1SElLQ0xCS2Qy?=
 =?utf-8?B?Zm9MSmUrVGxyVkg0N1FHUC9xdlRLUzdnQXpSUXc0VUJkOVUzV3pwb3h6ajZm?=
 =?utf-8?B?L0tiTkdVV1IwNGU0dlFhRnRTcmdSUE9QdEpSV3o2STF1ZUxmTlY3NFczajkr?=
 =?utf-8?B?am4yRWlubjhNdnI0a3ZwRFVtV1BvNDlpNWdET1BFclN5eGU1MHA1cHNWdEJI?=
 =?utf-8?B?LzgycVByeVliU2VXY3p2RDFtMlhsSEtDditwSEtoaVVOMXZGcEFXNnlncHps?=
 =?utf-8?B?VlRBRlh3KzBmcDBkb3Ayck82N1crcXdwMGJjUC9RM3NJVWdNdzAxZ1A5cC9s?=
 =?utf-8?B?N3BIMnE2Z04yUnFNVlFTNDMwaG1hNm8yUFpiRnlteFpRZkx2c2d2eG9FcEYw?=
 =?utf-8?B?ekdBTHAxOHFMK2EzckpIY3RIYVlnRlcwVmNYcnE3ZXl1QndtWDhXcnp5QUor?=
 =?utf-8?B?V3cwSi82SURrOUFkTGRrZkxMOUJua1pZbGp4MUxjZFo2aUtlbWpqa3djYUJk?=
 =?utf-8?B?WEZILzhVYlhNN1RBYks0SVZSSEdsY2lud2ZBYmJvbUlxTDZqODVWaXNpYjlD?=
 =?utf-8?B?d2k0bWN5bGRnNnFlT1IxRDVzSThIVnQ0QTZHSWlycERZMmxTdFRkakFDTkNT?=
 =?utf-8?B?M2kzdWJQUHc3QjRPd2NQd0FlamN6MHJrMFdRREJ2SmNDU1hnczhORk15OTZ4?=
 =?utf-8?B?WmtTaE9XY3J6ZFBPVHk5aDFlVm1vcWMyaHhyR0JEUFFsdkhvWWN6T2I2bjBl?=
 =?utf-8?B?U3RLWGU2UzczQ09UUW0yVXpvQjFLMUIwZDFJL1lmTFl2YmgxWENMMld4ZGpi?=
 =?utf-8?B?QjdPVmlkcjkvZGJ0ZHp3M0Y5SHNNKzlJb1ZZN1hzVmdoRWRCbjFYWTRIbVM4?=
 =?utf-8?B?MlJJSDZHaFMvbDg4cWczelBaekdkWHFvSThkQU51cTB5dE1kSUsyTUhXYnlX?=
 =?utf-8?B?SjFleHppSkJVMGN6dWFWeGJqaHhHN0xHUzJVUnp3OWt4VGhTbmNhVDN4R2ps?=
 =?utf-8?Q?X2QI5fCT1LxIa2/P200tPK4FaoxqcY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXQwQlRRdVFLbUdpMWhkTERFN2orODBPaUtUVnB1Yi9CeTlnc3BjM3pmeTZO?=
 =?utf-8?B?eExlMEk0bjg3UlZKSmdIRFRiM1AxL1lYdDdIZGlwT1RkcEhDOGQ3N3ZURG1H?=
 =?utf-8?B?WFU2NzlQaE5aaXdXbjBzSFpXYlNOMXdtZGtDN2c5TGZ4S25QVnRpSXB5cTBk?=
 =?utf-8?B?ZG1YTHVUSWR5MjNBRzcwMmhpZkhHVzY3MEZtRkdLUFhPOTkrVHBMdzNBK1p0?=
 =?utf-8?B?MjIyQktFZVJWNW1ZcENGdXFtanVQWmh0dmxKLzBZZVgyMDFNSjZFWU9oYnpq?=
 =?utf-8?B?MGhxd3ZMQWtlck5PWi96cndSaDlzNGp5dm9uNDlJSXRPb0x5eFVGbFdGSGxB?=
 =?utf-8?B?RlF0QVllV2d1TWRCWXdXbDRhVUhpRGFXZEhKVmxld0JmbUwxekgzNFBYNEdC?=
 =?utf-8?B?SlAxSDhTcDB5QzdydCtSZVpOam1MWEFsT29LK1hkWml1Ti95M0JTQTNZaWk5?=
 =?utf-8?B?T1hxNE9LQ1hjTWRqMjhidnNML3dMa3RJQnFjeDBuaEtkV0JicTZiQkM4VkJF?=
 =?utf-8?B?aFJPSkhmOXJVcXFRVldIOGVBYXdMb3gvT1VaSUU2Y0RlL2Flb3hTUzFBdVNi?=
 =?utf-8?B?aDA0NmZwWm9sOWtqTFU2ZjRNY1gwWW9hREx3OHA4RnVVUkNKTnZ2dkljZUtn?=
 =?utf-8?B?QnA4WWIwQTJEMGxEQjlSQTdYdXdUTmFkT1M1c2NVclIxL2pHTzRkQVVPdjMw?=
 =?utf-8?B?Z3EwQ0NCYUJqZURxNitXQUdLQzhTdDFzSGFBNElhY1BaRlh0QlBoeFYvd1gz?=
 =?utf-8?B?cXlzdkhDQm5MaVZ2Nk9mdWxqcndieXJPcUF6N01MQm1Zb1Fvc0hENExydDdi?=
 =?utf-8?B?UU1LWTViWm52cjFLK1gzWFV3cFUrUSsxN21UQ0ljZXhib29RSmJjMHgxemJJ?=
 =?utf-8?B?cHlOZE5mUFZ1K3VxN3QrcjRVVFZLRVdOZkZxMitZMVFvZENqV0M1Z1hmNTMz?=
 =?utf-8?B?YmE5TU5uNWpid2tFOTNXNWZqYVZ6OEw1bElaYW5IdkUwTmNSM2FJTWU0cERs?=
 =?utf-8?B?a0QvUkpGQ1FTUk1hN3NMWmFxdU1PMVV4ZEFZOFh6N2tQQ0doRWFVYzUxNUNi?=
 =?utf-8?B?VGQ1M2ZsZ0tDNVkvaldnWU5Xc25sbXNjYUlMbG4rRDRoZGk0aGN0bG55czZJ?=
 =?utf-8?B?c1NtREJPa24vc0ZVTllRTHJQWE1GOGM5RkcvSlZna0ZXZit4aVUvcTh2Ky9O?=
 =?utf-8?B?QldZYUxnUndJT3FzWXg4SVJwV0d3YXVnbjNRRmpJNzRTZkNTVnZ0cUhoMW1E?=
 =?utf-8?B?SWRkMkU1NTV0VVVnZmJKVWZJV01TejU4bzdlK243Y3NQMFNsTUNTVGJZaXN5?=
 =?utf-8?B?VG5MZzBjbGFMSEtPUllyM2wyL0IwSTN6OEpTYU55bXFQdnVUYkl3N214N2Ja?=
 =?utf-8?B?dHcyY3J6L1MyaWhWRmFZYzd3ckxVaU92SjRSdnlUeWw1aFIzbk1nTnBDcm9O?=
 =?utf-8?B?R09DaWR2bUpBdG4yRDQwenlabHBzT2pXem1ZNWxEc1RWQUJGeWNnSFllZzlt?=
 =?utf-8?B?a0VVdEJIdGVXTXYySFFCWEhuUzZrb3JyejZSdlBHcVk2a3dKU0krZjRVcCtJ?=
 =?utf-8?B?Wmp4Z1YwcHFHRUE3dG00enNKLzZMd095OU41dllsV2V3NVJEZXFuTUpiODJH?=
 =?utf-8?B?OGwxci91aUNObDA2ZEtTQ2tkTXlrc0ZYQ01SZFlKdnd4TjJzb3UybTRCZ2pY?=
 =?utf-8?B?NWh5ampjOEh6c3JHNmFYM1NPNVNyaHpmQy9CS2wyajgrNE9Eb2hWazE4aXFk?=
 =?utf-8?B?WVRaQmFhY1lrZ2tzdEZuVEVGM1FNa0ZSNDdIREhaU3Viai9keFJxa0s5TGlm?=
 =?utf-8?B?TjRnRHBqbFNncmFSaTJNUEFhK2JjaW9zL2ZoWlNyQTF0UnF1TWtSODgwd2tN?=
 =?utf-8?B?ajJpMXZyRzYxeGdzZzU1Z1ptOFczS0Q1M25BTkRBNGhTcDVIT3V5ZHBiUmV2?=
 =?utf-8?B?VzJ1OWZUOXRnUncxTjZMQ01NVXNJbW9qaU1QN1F5SW1DTzc2aWJnbEhlUE5E?=
 =?utf-8?B?OUhtRE5pWnhsaWRCQmRqTmdkdmFQT1pxUGZYMnFrMDFXeHZLV0FwdEkvc3hJ?=
 =?utf-8?B?QnR4b1JtRlV2RGE0TXNyQld0bkdkK1Irc1lBMHJoNTJaWTdJeTlTcWtaNkND?=
 =?utf-8?Q?lBgNBm3dUWTmbWBpVuyKrAVod?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A02D327D3C7C044096149E3BDB7EA680@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dyQ3SKOM7/IH8703BZ3GCGGM1y/ewZgO1Las3LgjxryIDM7nxYGDMR8vNFA2YRumAFVymWk7GHaJ3wQNxaj1XDQrp426VfCr/AZC9td48uFVKgiCWw8jVT0GNcqTY3rkOSqaZnFqGEklcKcwJ9OybUZL55wAA0a03GLkEFJ081MJ33fbxiHJ3ybCBZL2UOMWUspynIEmzuoIYd/IJo+EJ3bH0dGxHS30TxgG2kwDAxGoS6jXoE/hl6T2bXmzzE7FxTK7q+4gqTacnCsytxHE6bmhbpM6rytkDurzlpucu+LIoxeTw50/9bRFjnN7/a7irF9bS4gAQvSKdMGc4Yvr2r1okaOsvHEefQ+02yYPI2YaQus209OuRj3priKNJepq0+sfxk0proAHcVe5WSLG+d4/ZdNQYvMTVRCEehCjmkCuRaxRc531XsMzdBzTUxcQOlPmJ+fW8P5cNIKr8LrB/KNgb6EsObDus4lasfoa00NIQ0FC+YxLW8TxsZdA1USUHguJfpl5HTEYVCEILviArh9/e42cgaat7nfMVgggSIAX5tTLbBIv6fBJSlVMSRR264CuU9z7hvEiDNeKkkf62oLIpZmUG0Mo0u+1TG+ZPhZB+buu5IpSjHAI/eDd0tQHHV340H/FgBzMmNkeqwkGDA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f12572f-dfd4-4556-a2ba-08dde688a75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 23:14:35.3660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAFZA6AvBha2wfWn4lFWpRaWIhdEugwVPgpL3MIrUY3il9E0lUepvMlSpVySgbNdH1MHduwnNRCIMG9dG4KHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
X-Proofpoint-GUID: A2QZnyNEN3MuVjL5z1HFuuENQaaaoaz-
X-Proofpoint-ORIG-GUID: A2QZnyNEN3MuVjL5z1HFuuENQaaaoaz-
X-Authority-Analysis: v=2.4 cv=ebk9f6EH c=1 sm=1 tr=0 ts=68b0e2e5 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=E2F-XHmknRgG8YEmLAQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX5U3ytoQ5uDZc
 ihYkKKzjinaV15tw2A571eTQ/SuSH+Y/vrZ+FNWWnWKY8dm0X+hC4XSxNx3RwJhu+vd+PW1dNDk
 mZX+I4ux8WZvG4a1qDrQ8x9IfdMKBi2fNSf05iYtxn9O5Rwqlu/7fVMEVeFJcMQRRdeLxmpffuS
 u4+zzug1BtlPldAs6kNDteWBtMH5frVk6USgcDR9/fbQSZ1G0Hr/hpv3wOOnrWVmUpFJ49FkAV/
 5H6POxgL0qkGq7ScYblEASA/jUOUlphkgO1fsuXxRZCb3vI+LPBzTNFt2zhSCL4m9lR8ylXu/UA
 Gj8J1J3LyWR/N5gjtY6kkYI9E1lhmV4mpjlB9qqrw9BhfH8L4DJoXlr2I/AtWsjOfXGmkKKhlCo
 wmjYmAbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508260153

T24gU3VuLCBBdWcgMjQsIDIwMjUsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IE9uIDIyLjA4LjI1IDAx
OjI1LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gDQo+ID4gPiArCQkoZHdjLT5jdXJyZW50X2Ry
X3JvbGUgJiYgKChEV0MzX0lQX0lTKERXQzMpIHx8DQo+ID4gPiAgIAkJCURXQzNfVkVSX0lTX1BS
SU9SKERXQzMxLCAxOTBBKSkgJiYNCj4gPiA+IC0JCQlkZXNpcmVkX2RyX3JvbGUgIT0gRFdDM19H
Q1RMX1BSVENBUF9PVEcpKSB7DQo+ID4gPiArCQkJZGVzaXJlZF9kcl9yb2xlICE9IERXQzNfR0NU
TF9QUlRDQVBfT1RHKSkpIHsNCj4gPiA+ICAgCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywg
RFdDM19HQ1RMKTsNCj4gPiA+ICAgCQlyZWcgfD0gRFdDM19HQ1RMX0NPUkVTT0ZUUkVTRVQ7DQo+
ID4gPiAgIAkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dDVEwsIHJlZyk7DQo+ID4gPiBA
QCAtMTM3Miw2ICsxMzk0LDkgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiA+ID4gICAJaWYgKHJldCkNCj4gPiA+ICAgCQlnb3RvIGVycl9leGl0X3BoeTsN
Cj4gPiA+ICsJaWYgKGR3Yy0+cm9sZV9zd2l0Y2hfcmVzZXRfcXVpcmspDQo+ID4gPiArCQlkd2Mz
X2VuYWJsZV9zdXNwaHkoZHdjLCB0cnVlKTsNCj4gPiA+ICsNCj4gPiANCj4gPiBXaHkgZG8geW91
IG5lZWQgdG8gZW5hYmxlIHN1c3BoeSBoZXJlPw0KPiANCj4gVGhlIG9ubHkgcGxhY2Ugd2UgYWN0
dWFsbHkgbmVlZCBpdCBpcyB3aGVuIHdlIHNodXQgZG93biB0aGUgVHlwZS1DIFBIWSBkdWUNCj4g
c29tZSB3aGF0IEkgYXNzdW1lIGlzIHNvbWUgaGFyZHdhcmUgcXVpcmssIGkuZS4ganVzdCBiZWZv
cmUgZHdjM19jb3JlX2V4aXQuDQoNCk5vdCByZWFsbHkgaGFyZHdhcmUgcXVpcmsuIFNvbWUgbG93
IGxldmVsIHBoeSBjb21tYW5kcyBjYW4gb25seSBiZQ0KZXhlY3V0ZWQgd2hpbGUgdGhlIHBoeSBp
cyBpbiBsb3cgcG93ZXIuDQoNCj4gDQo+IFRoZSBQSFkgd2lsbCBvdGhlcndpc2Ugbm90IGJlIGFi
bGUgdG8gYWNxdWlyZSBzb21lIGhhcmR3YXJlIGxvY2sgKHdoaWNoIHRoZXkNCj4gY2FsbCBQSVBF
SEFORExFUiBsb2NrIGluIGRlYnVnIHN0cmluZ3MpIHRvIHN3aXRjaCBmcm9tIGUuZy4gVVNCMyBQ
SFkgdG8gYQ0KPiBkdW1teSBQSFkgZm9yIFVTQjIgb25seS4gSXQgdGhlbiBjYW4ndCBzaHV0IGRv
d24gY2xlYW5seSBhbnltb3JlIGFuZCB3aWxsDQo+IGdldCBzdHVjayBpbiBhIHdlaXJkIHN0YXRl
IHdoZXJlIHRoZSBwb3J0IHJlZnVzZXMgdG8gd29yayB1bnRpbCBJIHJlc2V0DQo+IGV2ZXJ5dGhp
bmcuDQo+IE9yaWdpbmFsbHkgaXQgd2FzIGFkZGVkIGJlY2F1c2Ugd2UganVzdCB1bmRpZCBzb21l
IGNvbW1pdCB3aGVyZSBzdXNwaHkNCj4gaGFuZGxpbmcgd2FzIG1hZGUgdW5jb25kaXRpb25hbCBJ
SVJDLg0KPiANCj4gSSdsbCBtb3ZlIHRoaXMgdG8gdGhlIGdsdWUgZHJpdmVyIHdpdGggYSBjb21t
ZW50IGV4cGxhaW5pbmcgd2h5IGl0J3MNCj4gcmVxdWlyZWQuDQo+IA0KPiANCg0KUGVyaGFwcyB0
aGlzIHBhdGNoIGNhbiBnaXZlIHlvdSBzb21lIGNsdWVzOg0KDQpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0L2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jP2lkPWNjNWJmYzRlMTZmYzFkMWM1MjBjZDdiYjI4NjQ2ZTgy
YjZlNjkyMTcNCg0KQlIsDQpUaGluaA==

