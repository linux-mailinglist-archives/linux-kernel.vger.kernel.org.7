Return-Path: <linux-kernel+bounces-887502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D0C3863A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886033B2ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934BC2F60D6;
	Wed,  5 Nov 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PVu/UDIk";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EAxttLCe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uTzEIwtr"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EEA190664;
	Wed,  5 Nov 2025 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386125; cv=fail; b=f5vdhh8Ec/p4pI4Z5D5NHvagWpU1zx7hOUw8obbrxRE/rYRppySIdgGM35sX3VchKL2zvgB8CMhamqr8W1+7B5mUboi1+se2T667PWLEO64UcAK9nrauKP9EdT8Uzuy8uX973hzsdNGKadvgIMmwZzKQUUDPDETwoXmb8gaIh0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386125; c=relaxed/simple;
	bh=9Tz8JFMfiId3qZqTPyMDuZigc0KR/8CCuwt6gvShAZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBEf44YMN76GPhBIc3p8vcKR05wztHNBMDJWiGXMV9X+5pCIVAW5XUaN9oO8ftuZpg1YTAV1eEuTU7dF+A5Gv+o/ZP1N5iMDjyLUso5DqEtRGwJEI20fmdHjA5Ykw7cFGNJmoy3Hnv5Tsjhj2xr1DWiLmU3nuKAFv4L2vTjq7uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PVu/UDIk; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EAxttLCe; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uTzEIwtr reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5MFmVk2044919;
	Wed, 5 Nov 2025 15:41:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=9Tz8JFMfiId3qZqTPyMDuZigc0KR/8CCuwt6gvShAZ8=; b=
	PVu/UDIkKHShAUUnzWEaJkwui06/Q0dMYjvCv3w3umbWn7JB8yxRACGkIhhSCKn8
	zG5MVIuSl7sVMZxUGrMZksPJI7gFWLL7Uyqn6uqHujEz1Rp7MMVa8xcdhX5FHPm6
	eXYoJRK6Zv6DGnfL8SnJQ/l2QISUktjVmK+oPO3OLAmlJBKNFRGrPMwQZUX86ZKp
	ZKQWQ+OLbm2im9rgwRfNu+CcjaXCd3sVyRGZ+Y8Q88wA4rHH/qyFc7uI6WSNzx3r
	mWX496BjsHauedka3zpEq20l06lroFqwPli/YEuJ3jPJMOdiLkL8vP4kj74G5Kih
	HP0BAhMeLjXGInrKnpIwhA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4a8f7e8atf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1762386087; bh=9Tz8JFMfiId3qZqTPyMDuZigc0KR/8CCuwt6gvShAZ8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=EAxttLCepJlOAzKt+wwk+fg/bT0zDR/x9r+q2w6XDDrK5ablBjEtauydFp3p2COXK
	 SsJitJhbDGUcxQgM+qLLCQlSJJOrgxeTMZJDlzw8qfvBUCAAcX10OqbGgj3n4FuJ3U
	 ZKX2wdLLaJAcbOYGfzUxgQMbxfxVZiIsWa+WxTHLDEly2jC0x7TVkvOx/oivVbJurN
	 4Hjxtro0sOp6xvhRiwWOML3C4Oca2OLNU/2hQ5XqksNAxOOJ4+aEhgkvIOUFmRD8La
	 SqK0aIrsaH7IZV0xudoFQd4YaBhWnRN6SBewSgNhCnVTZvSqnjuDCPNr4XGJPotOVV
	 TkP0koX3iO1eQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CC76B40126;
	Wed,  5 Nov 2025 23:41:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E67ABA0171;
	Wed,  5 Nov 2025 23:41:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=uTzEIwtr;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00105.outbound.protection.outlook.com [40.93.13.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CFAD840522;
	Wed,  5 Nov 2025 23:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYhmzE+A4kt1oW/6omRehNX0Xv8rN+94iSKq+TORBX4hFFfq/z+XEDCVErqEQGFlL76iFIr4CRAhW4xtFpdMfSHKG28ubSN9jjtgsU6YogMIch6ymW+RxIXlOOmoFd5YaZZeKnxqzbztiAnExbEDeXj1RZcsrgo4JjaByb/loaexjmiOxhU3yuZ18g7UAwQNpClygImcGLvw7eSihLi01/FbF7x9KbvLCRke15o73/fOctbaQN+EJeZGjhiByewsmZ9QxjfmB/kfCkDYZDuhiBq2Nvs7xkEbxIAEFB2mKL40pyiE1+HK65cZnoSqcj8yE1mWBWo5IjXnHCaCWI1a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Tz8JFMfiId3qZqTPyMDuZigc0KR/8CCuwt6gvShAZ8=;
 b=IuDJVXtJstsRCLhBcVeKOl+U7yvkpBS0MqlxOvc2buZT+/nZrcGU0gfjSlOokjvkk2n9Y5NxMrk39fXULZekWuPDbQrpeJQlAFpCsbwQrv4zXuTE+5Lu/+HBf+XmE3IE6xgNdbFclh/GnalPs0cBcy/Je9NKuwVEAoeakEA7wdNLftzkvClJek2okzVQ5dnfOkRtq4k3bQhGEclFAALSsIWYUfrG+mOOQwQOBaYAfdikLIgnDdW3FpNR8aUzeq2FWtLWxLlPaR+GcrmE431AZrvaQ6cDVVoh9HgB3qRR2JPMqTsDH5sb6zbFhE1wSc/3bbJif1Dz7txCpDzGU+z5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Tz8JFMfiId3qZqTPyMDuZigc0KR/8CCuwt6gvShAZ8=;
 b=uTzEIwtrEBdByHQT2bgV/TAHgbrCCHGZB6awAREROtEyEFP3CgtqDl+4ZN4zp6X+u4vLTXMheMh3qO3jdJfcn0GbQz1QgocsRCafmewFUnCuHMh0wuZBjwQuSHGoFogAUDmx275JddmJXGT2ecULygHXQQGhn6K/IQKihzslcuo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 23:41:18 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 23:41:18 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Hang Cao <caohang@eswincomputing.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ningyu@eswincomputing.com" <ningyu@eswincomputing.com>,
        "linmin@eswincomputing.com" <linmin@eswincomputing.com>,
        "pinkesh.vaghela@einfochips.com" <pinkesh.vaghela@einfochips.com>,
        Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v5 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Topic: [PATCH v5 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Index: AQHcTq2u+hh49tH5+UGmTitBj9+fdA==
Date: Wed, 5 Nov 2025 23:41:18 +0000
Message-ID: <20251105234102.aet5y4qrennagpkg@synopsys.com>
References: <20251104065045.1464-1-caohang@eswincomputing.com>
 <20251104065226.1513-1-caohang@eswincomputing.com>
 <76ec3e26-a38c-4643-aaab-7806cc39bd89@kernel.org>
 <9e50dfa.f63.19a53fcd7ec.Coremail.caohang@eswincomputing.com>
In-Reply-To: <9e50dfa.f63.19a53fcd7ec.Coremail.caohang@eswincomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8813:EE_
x-ms-office365-filtering-correlation-id: 0cd8ea9c-a2e5-4554-b750-08de1cc4d145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlVWQU9lQ3JhMHRvcGtyN0RGUTJKeUhMOWlyeS81TWwxblliY1dCcVhaODhq?=
 =?utf-8?B?SW9ZM1dzSFR2cU0zVU9SNEg2SGYvK3ZGYWlLTXJjQW1YL1dJOWh4QnFlL1dS?=
 =?utf-8?B?TEpUZEJmVHRuczh1Z2NESGtWdkRvV2J0Sm9LeHVhc2k1c1R1YW14a21DVlgz?=
 =?utf-8?B?V3hnYWYzV0czMldUU2JlcjRPckFZUFNJNGluWjJzSlZTMnNvTiszRUV6dFRx?=
 =?utf-8?B?MHpMSTNOdE1BWFFQVWRRQVl0R3pwM2JnNEpkUEh3SGZodEQ2Z3pBRzRlNW1E?=
 =?utf-8?B?dnptNks2OVJWQVdCcmhJWEwyL0gwT05iaWpKUG05ejI1WUM4Ly9wTXpMQ3Bv?=
 =?utf-8?B?OEZUemV3aXJ1Y24zZndyY2U5ak9SL2dqZVZvc1QzbURTNkNZMXgwUnRoYTdl?=
 =?utf-8?B?SVdXdHphSjhCbTdUNE80eXkwSnAwSGZZTUVwZ0dxSGt1OVVMMHBCb0J5dS95?=
 =?utf-8?B?T2Zpa2JWUnp3aDdvWUNObE5lYVNCQUNpeGc0cXpaWnFBVUxUWWRkdnlmOUYv?=
 =?utf-8?B?WnhRTFVUR21vOGtQM2VCcHdZZFlNY2Z6MXZqV0hIdjZoc2phS2d5WGczWDBH?=
 =?utf-8?B?VGJvZ1pYZWtzT1c4K1ROWmVXSVJtWUovV1B4b2svOThONjZTN2Q0dUxJby9W?=
 =?utf-8?B?V2N1dW0rdU1wVDhrcGZPb2NZZ2NIMWRKVHk5QXZKYkJkNDgvRXBoQjM5NjBW?=
 =?utf-8?B?VFNtdm5KZFQ5SEdjalhHUGhVWkUrS0lwN0JTVERYUCtsSG1NNVU2L2lWcTY2?=
 =?utf-8?B?TExnbHVKb01JSjQxM0dJTkY4TVVMdk5OTE9RVDU1cTc5SXZlUGgyNFZwWVNa?=
 =?utf-8?B?SW01dERwazV0aWR3bFF0OVhwQ01ydm1jNnJjUlo0WHkzS3ZxTmkwTFVSeWh1?=
 =?utf-8?B?djUwckxtZ05HMW92ZzhucUpmWHYvRUtRaXpyb3llQmZuT1JvTDZwanAxNFVL?=
 =?utf-8?B?aFhNQzErUDk4TVVPTDliYThPRmlDdFlmT0lkOHFISzQzem9maEl0MzB6VHJN?=
 =?utf-8?B?MXdhbW1NV1JRU1pOSE94S2IxS1N0bVZwVldiaHc5SEdoallRblZRbG1uUW1U?=
 =?utf-8?B?cjhVVWNjY3Y0RHlNM3BlSHVXTjlkMVl1YnRoZ2M0cE9YYWhjQ3pJd09ZbzRP?=
 =?utf-8?B?U01LN1BzTFV4em8wWk9Ic2hCZXdEWnpWUWRGMHRlVFcvNnFHTGRTVFNkSk1z?=
 =?utf-8?B?YXN3ZVFybmlzdTQxbTI3M0lzQjJOMEx4aGhPdFVVTVA4d0thdmlWdXlEQzYv?=
 =?utf-8?B?TzM5MXQrVzlvTjFKaXM4NzZRTHhrZG5yclVEL1V5aStITngzSGlEb1ZJV1VY?=
 =?utf-8?B?ako5eElUUjA5blhSNUpWN0ZWdlZ4RWxVY2syOVh0K2tHUkRsZWZ4eUJ3Y0dp?=
 =?utf-8?B?UUF0cUZkOGR3a0IzUjBOUkx0WllUelptOVlNOWdGUmwyQnUxL1BnUy95V29t?=
 =?utf-8?B?MEV2M2tWNXdpU285eEV3ZDR0WFozblAxUmFQeVhrcFpVdGc2bGt4c2d3VlZS?=
 =?utf-8?B?SVBROStLdlk5d20rTFc1ZkhWbUVFRkprOCtlS1hLVGdoMTBmL25HQmdLaGJn?=
 =?utf-8?B?Szh3OWlabTNZOVlnVkxpMVpkeFJSeGFETVlZK3FvTXM0allsMGxQeWlwb0cr?=
 =?utf-8?B?YTZuSjg2WmdDUFgyek5RSTNqWmtGaFM1UnJLTmRFc2plMFJOcTV6QUgzZjFz?=
 =?utf-8?B?VzVwK2k2QjRxZFgvTU9hR1dyR09sVTZtNkU1Q1IrNlhJQlFEK3FNak5tcVpu?=
 =?utf-8?B?OG5TRE10QVBYWUY4aWw5U2gyaGR0Qkh2SVJwdFNFZHZIQkZ6a3piLy9sZlk4?=
 =?utf-8?B?dzFDZUpiTVpWWExGT1JEcmdzZ1ZFT1pyR3JESEx2ZE0xVFBQd2o4Z1RORm5C?=
 =?utf-8?B?bCtxWldpRmtWcnNiZEowcU16TzZ0M1d6VEFhTTNKSDBEUVp2N0FPOG9wUjVl?=
 =?utf-8?B?S25vb3NUM3RySzhhb3B1UnFjRE9QS3JBd0M2RjBFbWdKb0RiQ2dyQW9UbzJp?=
 =?utf-8?B?QUhwbkV6d0plR2E4RjhRVGJRaDV3TGxUTHNWd3VvRk5SMlJZUFZJUjFHcnlB?=
 =?utf-8?Q?q7vIu4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVYyeUZoa2NIVkJHVTUwOGRqdzEvZks5MytxTlRib1lhN1dOdnpsb1FaMXRj?=
 =?utf-8?B?bjlxbFBFSGxIbEhtMWtjNmNiOGNmMU5MdTkzVmFUc2QxSUJkK3FVZ0wveFQ1?=
 =?utf-8?B?V3lTckhiQnhDMFVUM1g2QlBYSytGdktyenNyVGxscHkzOUdMd0NGa2dDbTFY?=
 =?utf-8?B?eHZONUxJaWNtMGljMkM4UE1DWDBvcllEemJLampuVytxNUN4UHczS1dFQ2Qr?=
 =?utf-8?B?bXMvLzVublA3OG55Vm1HVkhETUFyRzN0VmFjYk1TMDIvSlZOUFFnUE9Qd1Yy?=
 =?utf-8?B?aGt2ZlRoMS9QM1ZEWDFkMDZEUTN1ME1pMVpLdDliZUpwcnFWSkNETmxyR1Ev?=
 =?utf-8?B?d242OWozZVVLRlZJSmgwNnJ4ZUo3TnFzV3FaaitiWFQyVVU0aDBPVlIxaVBS?=
 =?utf-8?B?REJZaVVBcUhQQW1NQmJOaDRFRDlXSkRYUXR5YnhhMVlIN1NQY0s5K3NzV3JH?=
 =?utf-8?B?MkVqMFhQYUl5ZTJWVDhwUlh2VThnbktJY1VTODdEelpjczRDQnZhL2ZtTGg0?=
 =?utf-8?B?S01pLzJvZ0c5ampycWwvQmo4YXFlb3B1dkVNc05sUHB3REVROEhNY2V2TUNp?=
 =?utf-8?B?QjlMclRlengyOFhkbStDalBTd1RnbUR5UUZjTUdXaFpiTTZrL3dGU3FWU3pN?=
 =?utf-8?B?RGl5aUErSEdTY0wyRDNLTjJONmlyRXpqYnE3TVUwVlViQlcrUC9JOThqUjhh?=
 =?utf-8?B?MXFTQklLMmxnS3JFZzM0Z3ZCclBIYVJmTzRFcTljTDJFSEhHZm5sc3ZCRmYr?=
 =?utf-8?B?aDlQNXZxOENRdG5kSzZnSmhWZFEwQm5OMlhnWnU5ckRzdEhZaUJyTVpacUJ1?=
 =?utf-8?B?M3dXTlJwQlFzUHpxZ0hkd2ozazY0Um5BU3VZTGtWbG1lbTNKVkVHOTZiY0pK?=
 =?utf-8?B?YjRVS0tRK1lxb1dkTis4aGlHRmlhcFF0dnRicTJnZ244VEZVMG5ITDlQa3B5?=
 =?utf-8?B?ZVZPSzFkOXV6ZmFmek91TVp4S1cwOWtaZVVrMm55Mm9UbDFGeHdkOSsxTCsv?=
 =?utf-8?B?Q2lIdzNzZ2xQOWZWd2RZWW55YkV1MFhRbGRlVlFtdXhIYk9JKzNPMHBjL2VW?=
 =?utf-8?B?YS85NVBmTFV6T01iUHVpNUNiN3F2U0RjQUJKeFdkRzRQOFM5TVE4NHM3Vk81?=
 =?utf-8?B?QXdsZ1JUOGJlcU9vVk12UzBxdzRac3I1YldjLzhWRHUzc05zSnlMTjVRTGlY?=
 =?utf-8?B?VXBqVUpMOS9oNTRONmVsRHVCY09DSWlnUExQYlgzZG9nNTI3QmZ4aXpYSHY3?=
 =?utf-8?B?UVZGRDMzaEdrSDZobk9wc3N4cU84Tm9pbWhPc1c1VGpkaFNXbjdRT1Zxc1ZX?=
 =?utf-8?B?TU9RQ0Q5V21PZUtGb29FK2JiU0o4OEhSbFY3YWo5OWd1K3FCdjFrcm1CVXF3?=
 =?utf-8?B?VURvZnJMVmZ6bHk0YWxjWjgyYytJOUF3Qlc3U094SmVJQUUzWXVKMkRnUy9v?=
 =?utf-8?B?Nnc3M09kNkFWd2VXREFVVnNiaDEyOEVJWEJ2RFlXNVc5UW1aUkdRVUF3Ny8y?=
 =?utf-8?B?OUE3anp1NWdwWmpsVW9MSEhXR2orUTZsN1U5dmJnV05Ic0dlZm1tU0pPSlZL?=
 =?utf-8?B?WkxTbEdVT1NyandNMng1Z0xUaVdNY285YlExeDBueDdydmlXZlZBNDRkS0dr?=
 =?utf-8?B?TG9kdVE2ZGFmcER3UXQrYU9BT0hmVjNrd1k1SDJuUGY0K0d5d0pvSEdJV0ht?=
 =?utf-8?B?dUlLV2lwUUlTUnBSRURFVEpXcmxZUFVzblM2Vmg2b2ZTcmtManAyYVZFeUdq?=
 =?utf-8?B?aHRsSSt1R1hMVUlGc2dwMURObGdTTEsvNUhLZWU5eXRCQnBxZWE5TFJlRkZt?=
 =?utf-8?B?SUhocFlUVVVMdUpZY0JSYUt2NVJDYW90NEY5MzZYR0dhMUxyQktCYjBSRVhn?=
 =?utf-8?B?T0gxVGZ1UGdsT3VYUitlKzdOVjZYQXdnOHNSTCtJcWpmaHUwVnRxNHZEbmNR?=
 =?utf-8?B?ZmZ2MmpsNDBHcVpuZjlkZUNhZDQySDhTQk9CcmpVRmJGdHF3ZkRHcnYrUTZr?=
 =?utf-8?B?YWhLWGlPckN3L1VWNjNkeGVXb3ZnMkNzbWYvQSt0TDZQbjR0cCtNeUVraFFX?=
 =?utf-8?B?YUcxY1licDdneHNuY2RZN01KeU1ZdmFyN1lwam5mYkFmK2VEeGFwLzBZVmJn?=
 =?utf-8?Q?GVBxmTlc8ZkXDPSzYWZWWRIVN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CE887A0C764824380B381D6E62A6C0D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mCZQdIkvNLnFsUs1NHYGe1UmM0EUejazA49tjGhXsjTjINiz6QjJOAMR/Eei/mixv4VEAOCDJjX0ItgvmOmBbzxtQAbeBIAm+wuAh35ZwCkAvadbNIHdqssHlC6+HsRpemwJrR/1vQbmCVliBDVe7ZYWxoXnR6sk2szQmEmSwtECvyFGP9sBH7WbWceVuc9wM5/vUhHGdGD17WF/hUIrUxCn6G+niQ6lJnGaDXQ+AGK/vECW6GEQ6OUoX0othUWmXaUSiS4bf+dyZc3H3E+7kXyjZCDPtQ1PHmwf4IgZCZddJ9NruAKBvNsWbJ3S2JoDk4dXp2KzoG5eqvqGRe2D/ZTEUEr/QokCtPnE+xc176pKdohgAQKdu1M0hzxRkNLdNSUE3L94vbwOhfTIAfUVoJF7bz5pO5CVFNq8smgcwPbuQiehaEBQ7GmSz35jLqDgDxuZWQ9qdfKz/y3ZS+DkNeR7jUxab9T8uzAKbWMgtj8WXQVxfKeS5j0VY/FncsvZKGcOkoML7IKupBkvkDmycm3qYioe2KSzQ577DQXOICQsWoZvi1Q76SDGTPi40kADtR17TWjuz4qmENbpa/6fVVxoxsHQBZwsaG1QBaADWPVOIspkSWxSCXwcrUHjPSYyeoagADqsiC0bH/BZmZcqpQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd8ea9c-a2e5-4554-b750-08de1cc4d145
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 23:41:18.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IRFz5KVrl5cMsV/AY8VDozb/gc/hLmWys4zcK2A+cexndt3DJGL8dnAaLoxnRjVQNKtz3rA12HozaOQoWjOmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813
X-Proofpoint-GUID: ljexkZHgffoXRaa-FAqlQTB5cSY1y8aI
X-Proofpoint-ORIG-GUID: ljexkZHgffoXRaa-FAqlQTB5cSY1y8aI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDE4OCBTYWx0ZWRfXwvdPoLPCnb4c
 cgQkvuVOUQ3q+D5/ker2k1EtZgcPPOQ3zMImyNfxElPLbpbONjpqpqxCgB5kd7owNeUn4NXeQAo
 P7bnf+PDAG/e0iG7sIiOWUgg1XnMLtX97U4U2fimi5kmKyntPjFvCG7+v2P41UkbA+YqfbgmVw0
 xT3K23+saGskjrZOM7hHXKY4GclIN6nbQDMNi+Y3wywfLG7FCiFgUCiTmroG9TXTL+VuZvP8z7k
 OXmaSI2iw49H9azBI7XTi0A7wVa9O0Jiwx9BrO1+mN2+kwu4Te1lgPmRU+xwK0KkjF13FIkJpNK
 mXmdW2fCNu9DH5/Qc1sa22dGBbUTJDauVtCh/cW39hjMl0ozsfFAoQesmkJYkvpvvqTHQzCYe1j
 noRWo3+qIhLffFj0wVdN+hwwKQr51w==
X-Authority-Analysis: v=2.4 cv=IfWKmGqa c=1 sm=1 tr=0 ts=690be0a7 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=g-GjH4B3zILXz1S7I4oA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511050188

SGkgSGFuZywNCg0KT24gV2VkLCBOb3YgMDUsIDIwMjUsIEhhbmcgQ2FvIHdyb3RlOg0KPiBIaSwg
S3J6eXN6dG9mIGFuZCBUaGluaDoNCj4gPiANCj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMgaW50IGR3
YzNfZ2VuZXJpY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gIHsN
Cj4gPiA+ICAJY29uc3Qgc3RydWN0IGR3YzNfcHJvcGVydGllcyAqcHJvcGVydGllczsNCj4gPiA+
IEBAIC04Myw2ICsxMTksMTIgQEAgc3RhdGljIGludCBkd2MzX2dlbmVyaWNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ICAJZWxzZQ0KPiA+ID4gIAkJcHJvYmVfZGF0
YS5wcm9wZXJ0aWVzID0gRFdDM19ERUZBVUxUX1BST1BFUlRJRVM7DQo+ID4gPiAgDQo+ID4gPiAr
CWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJlc3dpbixlaWM3NzAw
LWR3YzMiKSkgew0KPiA+IA0KPiA+IE5vLCB5b3UgaGF2ZSBkcml2ZXIgbWF0Y2ggZGF0YSBmb3Ig
dGhhdC4NCj4gPiANCj4gV2UgaW1wbGVtZW50ZWQgaXQgd2l0aCBkcml2ZXIgbWF0Y2ggZGF0YSBp
biB2NCBwYXRjaC4NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI1MTAxNjIyMjcxMy5kMnN1dGM3dHlmMmlkYmt2QHN5bm9wc3lzLmNv
bS9fXzshIUE0RjJSOUdfcGchYm5VMWJzRUhpdm85M0xHbWhWNjh5TDJJZWNLcmNOQ1pmS3ZNUkJE
RlpzdnBrc3pxNXVFYU5sYnZTbVNqamdrX3JpSUpBTGwyMVQweXE1eWhCbjlHMGdDZVdQUSQgDQo+
IA0KPiBIb3dldmVyLCBUaGluaCBzdWdnZXN0ZWQgdXNpbmcgZGlyZWN0IGZ1bmN0aW9uIGNhbGxz
IGluc3RlYWQsIG5vdGluZ8KgDQo+IHRoYXQgdGhpcyBpcyBhIGZ1bmN0aW9uIGNhbGwgcmF0aGVy
IHRoYW4gZGF0YS7CoA0KPiBXZSBhcmUgbm90IHN1cmUgaWYgd2XigJl2ZSBmdWxseSB1bmRlcnN0
b29kIGhpcyBmZWVkYmFjayBjb3JyZWN0bHkuDQo+IA0KPiBPdXIgZHJpdmVyIHJlcXVpcmVzIHNw
ZWNpYWwgaGFuZGxpbmcgZm9yIFVTQiBidXMgaW5pdGlhbGl6YXRpb24sIHdoaWNoIGRvZXMgDQo+
IGludm9sdmUgZnVuY3Rpb24gY2FsbHMuDQo+IA0KPiBTbyB3ZeKAmWQgcmVhbGx5IGFwcHJlY2lh
dGUgaXQgaWYgeW91IGFuZCBUaGluaCBjb3VsZCBzaGFyZSBmdXJ0aGVyIHRob3VnaHRzwqANCj4g
b24gd2hpY2ggYXBwcm9hY2ggd291bGQgYmUgbW9yZSBzdWl0YWJsZSBmb3Igb3VyIGRyaXZlcuKA
mXMgbmVlZHMuDQo+IA0KDQpJIHdhbnRlZCB0byBhdm9pZCBtb2RpZnlpbmcgdGhlIHN0cnVjdCBk
d2MzX3Byb2JlX2RhdGEuIEl0J3Mgb25seSBtZWFudA0KdG8gYmUgdXNlZCBmb3IgcGFzc2luZyBk
YXRhIHRvIHRoZSBjb3JlLiBJZiB3ZSB3YW50IHRvIGdldCB0aGUgY3VzdG9tDQppbml0IGZ1bmN0
aW9uIHRocm91Z2ggdGhlIGRyaXZlciBtYXRjaCBkYXRhIHdpdGhpbiB0aGUgc2FtZSBnbHVlIGRy
aXZlciwNCndlIGNhbiBqdXN0IGNyZWF0ZSBhIG5ldyBzdHJ1Y3QgdG8gcGFzcyB0aGF0LiBUaGlz
IGtlZXBzIHRoZSBjb2RlIGEgYml0DQpjbGVhbmVyLg0KDQpZb3UgY2FuIHRyeSB0aGUgZm9sbG93
aW5nIChub3QgdGVzdGVkKToNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1n
ZW5lcmljLXBsYXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYw0KaW5k
ZXggZTg2OWM3ZGU3YmM4Li5jMzU0MWZlZmU5NTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5l
cmljLXBsYXQuYw0KQEAgLTIwLDYgKzIwLDExIEBAIHN0cnVjdCBkd2MzX2dlbmVyaWMgew0KIAlz
dHJ1Y3QgcmVzZXRfY29udHJvbAkqcmVzZXRzOw0KIH07DQogDQorc3RydWN0IGR3YzNfcGxhdF9j
b25maWcgew0KKwlpbnQgKCppbml0KShzdHJ1Y3QgZHdjM19nZW5lcmljICpkd2MzZyk7DQorCXN0
cnVjdCBkd2MzX3Byb3BlcnRpZXMgcHJvcGVydGllczsNCit9Ow0KKw0KICNkZWZpbmUgdG9fZHdj
M19nZW5lcmljKGQpIGNvbnRhaW5lcl9vZigoZCksIHN0cnVjdCBkd2MzX2dlbmVyaWMsIGR3YykN
CiANCiBzdGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVzZXRfY29udHJvbF9hc3NlcnQodm9pZCAq
ZGF0YSkNCkBAIC0yNyw5ICszMiwxNSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVzZXRf
Y29udHJvbF9hc3NlcnQodm9pZCAqZGF0YSkNCiAJcmVzZXRfY29udHJvbF9hc3NlcnQoZGF0YSk7
DQogfQ0KIA0KK3N0YXRpYyBpbnQgZHdjM19laWM3NzAwX2luaXQoc3RydWN0IGR3YzNfZ2VuZXJp
YyAqZHdjM2cpDQorew0KKwkvKiBpbml0IGNvZGUgZ29lcyBoZXJlICovDQorCXJldHVybiAwOw0K
K30NCisNCiBzdGF0aWMgaW50IGR3YzNfZ2VuZXJpY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIHsNCi0JY29uc3Qgc3RydWN0IGR3YzNfcHJvcGVydGllcyAqcHJvcGVydGll
czsNCisJY29uc3Qgc3RydWN0IGR3YzNfcGxhdF9jb25maWcgKnBsYXRfY29uZmlnOw0KIAlzdHJ1
Y3QgZHdjM19wcm9iZV9kYXRhIHByb2JlX2RhdGEgPSB7fTsNCiAJc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsNCiAJc3RydWN0IGR3YzNfZ2VuZXJpYyAqZHdjM2c7DQpAQCAtNzcsMTIg
Kzg4LDIxIEBAIHN0YXRpYyBpbnQgZHdjM19nZW5lcmljX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogCXByb2JlX2RhdGEucmVzID0gcmVzOw0KIAlwcm9iZV9kYXRhLmlnbm9y
ZV9jbG9ja3NfYW5kX3Jlc2V0cyA9IHRydWU7DQogDQotCXByb3BlcnRpZXMgPSBvZl9kZXZpY2Vf
Z2V0X21hdGNoX2RhdGEoZGV2KTsNCi0JaWYgKHByb3BlcnRpZXMpDQotCQlwcm9iZV9kYXRhLnBy
b3BlcnRpZXMgPSAqcHJvcGVydGllczsNCi0JZWxzZQ0KKwlwbGF0X2NvbmZpZyA9IG9mX2Rldmlj
ZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KKwlpZiAoIXBsYXRfY29uZmlnKSB7DQogCQlwcm9iZV9k
YXRhLnByb3BlcnRpZXMgPSBEV0MzX0RFRkFVTFRfUFJPUEVSVElFUzsNCisJCWdvdG8gY29yZV9w
cm9iZTsNCisJfQ0KKw0KKwlwcm9iZV9kYXRhLnByb3BlcnRpZXMgPSBwbGF0X2NvbmZpZy0+cHJv
cGVydGllczsNCisNCisJaWYgKHBsYXRfY29uZmlnLT5pbml0KSB7DQorCQlyZXQgPSBwbGF0X2Nv
bmZpZy0+aW5pdChkd2MzZyk7DQorCQlpZiAocmV0KQ0KKwkJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgcmV0LCAicGxhdGZvcm0gaW5pdCBmYWlsZWRcbiIpOw0KKwl9DQogDQorY29yZV9wcm9i
ZToNCiAJcmV0ID0gZHdjM19jb3JlX3Byb2JlKCZwcm9iZV9kYXRhKTsNCiAJaWYgKHJldCkNCiAJ
CXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIERXQzMg
Q29yZVxuIik7DQpAQCAtMTUwLDEzICsxNzAsMTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZf
cG1fb3BzIGR3YzNfZ2VuZXJpY19kZXZfcG1fb3BzID0gew0KIAkJICAgICAgIGR3YzNfZ2VuZXJp
Y19ydW50aW1lX2lkbGUpDQogfTsNCiANCi1zdGF0aWMgY29uc3Qgc3RydWN0IGR3YzNfcHJvcGVy
dGllcyBmc2xfbHMxMDI4X2R3YzMgPSB7DQotCS5nc2J1c2NmZzBfcmVxaW5mbyA9IDB4MjIyMiwN
CitzdGF0aWMgY29uc3Qgc3RydWN0IGR3YzNfcGxhdF9jb25maWcgZnNsX2xzMTAyOF9kd2MzID0g
ew0KKwkucHJvcGVydGllcy5nc2J1c2NmZzBfcmVxaW5mbyA9IDB4MjIyMiwNCit9Ow0KKw0KK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgZHdjM19wbGF0X2NvbmZpZyBlaWM3NzAwX2R3YzMgPSB7DQorCS5p
bml0ID0gZHdjM19laWM3NzAwX2luaXQsDQorCS5wcm9wZXJ0aWVzID0gRFdDM19ERUZBVUxUX1BS
T1BFUlRJRVMsDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBkd2Mz
X2dlbmVyaWNfb2ZfbWF0Y2hbXSA9IHsNCiAJeyAuY29tcGF0aWJsZSA9ICJzcGFjZW1pdCxrMS1k
d2MzIiwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YS1kd2MzIiwgJmZzbF9sczEw
MjhfZHdjM30sDQorCXsgLmNvbXBhdGlibGUgPSAiZXN3aW4sZWljNzcwMC1kd2MzIiwgJmVpYzc3
MDBfZHdjM30sDQogCXsgLyogc2VudGluZWwgKi8gfQ0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJM
RShvZiwgZHdjM19nZW5lcmljX29mX21hdGNoKTsNCg0KLS0tDQoNClNpZGUgbm90ZSwgY2FuIHlv
dSBwcm92aWRlIG1vcmUgY29udGV4dCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugb2YgdGhpcw0KbmV3
IGRldmljZT8gKGUuZy4gRFdDX3VzYjMgSVAsIGRldmljZSBtb2RlIG9ubHksIGhpZ2hzcGVlZCBl
dGMuKS4gSXQnZA0KaGVscCB3aGVuZXZlciBJIG5lZWQgdG8gcmV2aXNpdCBvciBjb25zaWRlcmlu
ZyBuZXcgY2hhbmdlcy4NCg0KVGhhbmtzLA0KVGhpbmg=

