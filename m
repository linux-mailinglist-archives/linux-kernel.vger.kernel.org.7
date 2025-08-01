Return-Path: <linux-kernel+bounces-753774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDC6B187B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF52A7AA6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1266328DB47;
	Fri,  1 Aug 2025 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="S6zxLFtU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="DG0SzEMB"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390F4A04;
	Fri,  1 Aug 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076324; cv=fail; b=dR7qmfDroavCc6uuC620xLT2x7Nxui2YuDe7aEgvOrPUIJw+394kqAAWyv1EP3Ow6aMXJpUJuPq0H9+mSb+Pt9haJgT9Mf2Rm6Eyv8v58JnxHNiT8/aUYzuvGHg4LtP6vNZRK59qCFBU3Tng/j4n3po2aMcI3dO4wQu41eIxyWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076324; c=relaxed/simple;
	bh=pXugx6DHoKZ/0E7698XT0wr7PiTWtXyAQ81/N/VAsWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k9GyLIJroRtB8I2yeezfXD1VshbAfYZFQ34hChb+rx819Lqh30/7yLKysdcLm86Kuebz1JUoZf7A0+tpsLF2dZb3egZ3uWQZ8/t1IGuJsU+LPs026mRVjo3eopv9hS+uFWpw2DvpKicZxH/B5to+NJxfCiuh+g6zXMdR/MRAsok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=S6zxLFtU; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=DG0SzEMB reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108159.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HZZxJ012874;
	Fri, 1 Aug 2025 12:24:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=pXugx6DHoKZ/0E7698XT0wr7PiTWtXyAQ81/N/VAsWU=; b=S6zx
	LFtUGz1ZUUvwDjB7OahyHwZobFs/vUnVY1q9JdwvGMYLBFuI3bG5nBg4iqDTacqy
	rcZGyXw2CKzGGDxBnkUtHCCK9sItTMBCgCLfQK2866DuIn/T1vNlEkxbaPN7///c
	C9xodN2WEEOUgMbhOQ6fBeZ0nQMZlaLCh4hatMsNK7nrCehJBRWWNuf7lr3F5170
	yuX0xEcP0stVCoO8ELAELWjTh2IN4IiGREvDtIJTA1r13zSUw05N3mIe/V7dZOuR
	4QGb3lUFPBeniSTkqhV9gcoyYgljw+0mV7OJaYQNlLVWvM98yKKtE5tGRbrE3OEX
	KB15L8QVwR+wuXw37A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020124.outbound.protection.outlook.com [52.101.201.124])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 489246r65d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 12:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ok6T2361oDlVV4K/IooLRRY2lyHZghFkQuKPQ4WYupnnUbFSFr/i5QlSGIOA6Zense8iaXBj4+GNn9y1gEvc5Yq4nOqDOOdsKr2Ay0Jv9NSaFrmd/8jMM+0ZrD3SCbAVR8DxmsFrjqhMhX/M66viggG/wqTb2YEhEizRwTOyQWlT2zlkYAW46la1xsKQbHvjcbJXEBP6Y0KkvfCEUBOyNqyfwxbV4u5fIog5YbNURO7rg3OiFxwwWwnmDtJF9uiz51YpVMesbW8xvCFEiHhvs/SGpVzIWnf9oXFx1qTPtpi+PQ0s1A5id9YGSZZug/i7+mE0VcwVFiWCG82aq1yUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXugx6DHoKZ/0E7698XT0wr7PiTWtXyAQ81/N/VAsWU=;
 b=JG8s9G8eo1z/QPxs404U7PBPqt15Ies132iuD4YcipntZxtIL8MPFfXZ0EyJvvOMSUzMyMcpoF7I91w7cvHNQjMbW4jUA60QKuVpeovniQZ7TLCu/BTKjEILR8JK7riSs7EZFCroOdXAuBP4IWD1WmEFzeT77/cxNzWaXs40am2aGjQwa6iSM4ifKJV6Stk0dz24P2qxgfYKcWwsD2wgVV620oGRAOZfeDcPqpAyn/x7BZSnbjuPElfP7L0BhCyE0Ugh8esIdW/PlCmkVWQSBJKQmfdWdrhEJJI2P+87+6nyWd+qYhTQC30pbUrIFPYnGxOhdYBltlILEkWq0kIvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXugx6DHoKZ/0E7698XT0wr7PiTWtXyAQ81/N/VAsWU=;
 b=DG0SzEMB6YpxuRC9VpRKEC2v1PS+FhzNHMPFYb4wg3do8uXDojGhkF477zUXDC92S8Kt6zJDh61xcD2Dca7VORIXZp9Tsc/G4cnoati/Q3gppx1ugzufY8PFHNcEyvE+KL7lfVqDAvByOYyUQsmF0KlzBrYQoBDIA/OPqNyB91E=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by CO6PR05MB7777.namprd05.prod.outlook.com (2603:10b6:5:34f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Fri, 1 Aug
 2025 19:24:27 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%4]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 19:24:27 +0000
From: Brian Mak <makb@juniper.net>
To: Baoquan He <bhe@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Thread-Topic: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Thread-Index: AQHcALW+ZQjjgT9X7kW+00L4/dZ7pbRNIAYAgAESSwA=
Date: Fri, 1 Aug 2025 19:24:26 +0000
Message-ID: <5A9FE2FF-800A-4458-9929-124EB89FE1D9@juniper.net>
References: <20250729182142.4875-1-makb@juniper.net>
 <aIwuSFKSUJDI6ULl@MiWiFi-R3L-srv>
In-Reply-To: <aIwuSFKSUJDI6ULl@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|CO6PR05MB7777:EE_
x-ms-office365-filtering-correlation-id: 66f3c718-90c9-4ffa-b9de-08ddd13107b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LDtSSpzn+DIydRI5vyr2SvRL8VHDj9tUEy63FWNFPW34qtTN3QzTK+1/yc7z?=
 =?us-ascii?Q?4qEA9DShn1CQoJ/WbDw+aRhU3r5Q3fgRRqJdhCNGCXnUiwfJoLIhruQSP4MV?=
 =?us-ascii?Q?eIa7YA8GV3BDdaqCYcTCo+bIQQC+VO4HIq5v1K0szweSrGrDdz1q+XSEodiI?=
 =?us-ascii?Q?uaaUbikvYUgFZf3a6wIpmaXnpMXliSEPRmxlG9dyMeW1MFjts919o+cQVwql?=
 =?us-ascii?Q?w7zxDJ369T9RMEkGcLNAdxn0I1D7fNVLELS+Aj9Vhd5ZnwidtTCAzW9dTff+?=
 =?us-ascii?Q?odUmEiKO0m/3at6Y7bRyMqH2BU+CL+uai/6udhDh9Ad9u9yNjJw33MUoHgHr?=
 =?us-ascii?Q?/1tYBaHvj/dkNvkxHH+t2Q4HaI4+0z+S+sf4P3cKEHF1PM+0aMfnPdtanS0S?=
 =?us-ascii?Q?5Rysq0YgB8VaTj8N20tEC8IidUIWyI1tvwwZuQQqZ67WMzOMBLc6xXfCONC4?=
 =?us-ascii?Q?ij/KAUmBTg2iOjVLYGL841BKzQy6ZyJojHvZBnu9hHl0W8DjYhPV/WztvYAZ?=
 =?us-ascii?Q?WpHnPdkZa6nzO8mk4EuXf93mUw7RZxdhQ1QnLNr+AyZ2OuzJBZsZVUgBDYDY?=
 =?us-ascii?Q?3BoLAYBwv1VggN1LdJoTzH2Oy2DHpReR/WyRMVCbzrcHjyRza7UgHNAjgNxa?=
 =?us-ascii?Q?N7JojmQUkQ/3EyANkiyQYDqCLT2XeLdINwE19/KZIL645qA/mT59dtJ65BD+?=
 =?us-ascii?Q?qriGicTZmIgjq9k3uPFT4P30df6f3bzTEYWcnAZ7GZJyaUecvtJE+mBcHH6a?=
 =?us-ascii?Q?Tkkzr14qi6OaZABwteNXgm4XUdKMkh/GgKTI3rHft9zL3ziRCyWH5qeCztLk?=
 =?us-ascii?Q?m4vN3HgmoM/ZW9YUUau2DJaDBtKd/9iD1fHdTX1zbM6vPIkx+RWqwd+sVkUE?=
 =?us-ascii?Q?be0Kiv2PwwyuErEGtyQiCAErh3+0Sqe94PX63LI9sk8BGEiPlilXLgtsUwR1?=
 =?us-ascii?Q?S4CkOVy5H7ZYWf+HQ9PTckFWh8CqboDzUmuPK9d1OKnL1XXCaNEjz7qOQcvX?=
 =?us-ascii?Q?Km/aXoCSWFQartYEkADmHd7O2gUee4KRTKzQUfFAFyd3Vd+MZTWprsLJ84qw?=
 =?us-ascii?Q?q6aneQogp3avX1t4rEtJ5MN+h+7L9tMMpMKFfoqwuhThRLy/ufcB44AgQe7H?=
 =?us-ascii?Q?WV6xK36Ze6dUw5DF0mnB3H9o0am0dAr9yAoeqdAH/4axUDpJNVmKW+mT2O62?=
 =?us-ascii?Q?vWCedzI5WEdxRMW5hG15+vHKhXjW3NNpLTHx7blVa90hL4ErtcgKowUAWZRG?=
 =?us-ascii?Q?02/wSNssbaBMgZ5RwUhjbugRnPJtJWAkHaf0Tgy2FqmrAlethNbAQ4MHKAvR?=
 =?us-ascii?Q?GSa/p9EObfSVpzBSUS9/I29uoLlNvQUe1xc58WqIVnwUQ4/YXu+qP1ETX9py?=
 =?us-ascii?Q?6MhA+uxJB2I/JgMm3aIZpGpDP2v2UyrwSeObOpoQHmste68aXdM8A7Q7f1U0?=
 =?us-ascii?Q?d4GrDJVv8SB0ysRVXGQbSVmoa7girZd4Jnt8YWFkh88f6VZDDnYK2g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GPv/HQBnrHmW9VugwBP2thG0JziHCTqpJQ9KBhOUQn4DgvfgcDaB9/bPrxbp?=
 =?us-ascii?Q?/+WNlJI/o/2rjx8HGtLEQdz67jlt9dehiiSh44yfgzZCBoZn7NDIv5+22826?=
 =?us-ascii?Q?ZwJNb+NajySenRaZDlfZWAY1C7t5WLXStWW+ZwAKEKyeB9cBL7o9vsL055Sk?=
 =?us-ascii?Q?HmN7jknVYMb5pbDbNo8XQY5gt+aQf+4a1hm5VmqDToKXOgvwUU+vDmVjCJQq?=
 =?us-ascii?Q?Ig2mSvm6zuY91NwBhI71Ew9uVC8uihkKRN7sqbZG6pwiCjLiZPVk+s7mlBS6?=
 =?us-ascii?Q?My4t+t76GaAbNBLqyNYKjWqwXKCe2uVkmhk3YTIKzX0vQ7pm8PYLSJNbgrQK?=
 =?us-ascii?Q?B+fVBjavQiK9ftaN+Cb+8e+N9EfFXYQw1V/PiDcpHjAqu4KTdIXcA11u5qZv?=
 =?us-ascii?Q?aypP49DCFsqCWRzdipu4NU2qF0ze5JBYTGDixKUoT/X4Uxv+tzfAB9UKj8Z+?=
 =?us-ascii?Q?YV1NaOUchTOaraNzdM6tuRG5ASNG6EJmS5Au29kTMdNGV/8QZ8oZyo+hCYx+?=
 =?us-ascii?Q?NPMbyDhHtwCtpVppLKRFxeEi6q/KtBHxoZTGR/ON6OPtruk4Gti2GD72A6qt?=
 =?us-ascii?Q?9SmOLitDLsUvqI5aPhz1Jkmz+M9IUx1BMHZ8v0M2G3avrZyiKSKp8HYAkz+I?=
 =?us-ascii?Q?YitCjZIZO+FT+BpH9QWChd4DcSuGFwhaj7YewdbImgXrzPOj4Pld59GsfkjO?=
 =?us-ascii?Q?NwQ7N7K8xbx32imHWodYZu8LwESYHqrk5We0ilftVBAz/7OQ6lglCGrgYOAb?=
 =?us-ascii?Q?+qj9px70R+lsRlqer+mJ3fUdLljCSPBk6zgkaH7Ktks2TpZrVu/OS5ZCLm3Z?=
 =?us-ascii?Q?7qOltsLVFrC8nyniQnJQqqMT6ynFBGLIkeTu2zLnzOo9RFl5/luZ+P/BYCpu?=
 =?us-ascii?Q?0QGNv6hCTwa8kwov6L/spL5SLRqX4tXHfApbjA8HItV8CJFW6addxgMk59Hd?=
 =?us-ascii?Q?Tq3MrhjD4GAVJWnHNRGsLEifVRc5dRWxAbpC1jVF6Zz0S/y9MgpD/vE0IOWe?=
 =?us-ascii?Q?98VK3RD3V6pB0C23LrIxrv41mo1J7tRDT478LL7A1bhFhMW2PrgVhJcFnITq?=
 =?us-ascii?Q?A1p4hXlwvV2T4Fp/+PHzbYfY7UxYfssVHqDmUsuXR6TAE4LsNEJbgWUfFsUR?=
 =?us-ascii?Q?hKAWcwTmLATw5AsThgoKujseHrmeUlbwWlZA5r4YYBdXZq5BWJLVMR8VLLua?=
 =?us-ascii?Q?5jxYI42ZrLOpGaLldWVyv+NR2ZBA+TglAxmT1p1l4SCU4qEvmITxcMB2FArp?=
 =?us-ascii?Q?nDINwNN5vqvd3l47+skbsJp3JKNvE1za0beh5/jnyOvXBpxm705zN+VOOCts?=
 =?us-ascii?Q?Hkl9l4KOmtZMVSM0pWZXP7ulg8/mc2pzb+BngHUzJRUqSfRfMjNKeSvwdmVc?=
 =?us-ascii?Q?yX9VWzXaSyxOR0CEAPqHahCxQTdRlphTn2JnV7MBm1hNGrelNjXCKnatQBAv?=
 =?us-ascii?Q?sHfW5PdGaK+3dYoG4ykuLo9y9YjF3Mzb2cSteCw3hVHWHKw9nYsIvId+TLIk?=
 =?us-ascii?Q?5O/16IVARTmhkzYcbiCAEPKTYWqZHjvjeXktTRpuHqzkxZkWB2T71XAkxI0u?=
 =?us-ascii?Q?We/lInD2icFw27eEAu4iU+nmzzLQNEh5tgSAd1q3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F2AA9250545B6478047B20AADC9A005@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR05MB7288.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f3c718-90c9-4ffa-b9de-08ddd13107b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 19:24:26.9206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YF6BAyM5T1yUHFnwWMEL+AixEWed2IuqGVV/WexRc37CICsgei1MUn56C96V8v7m54QG3/aQnXVGfRVkXp+jNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7777
X-Proofpoint-GUID: 5uZl0z0OZCcpOzSCWy6ehLu-Rq8vUhD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE1MyBTYWx0ZWRfX4MhCklcj1+P/
 s53j4m7jqYVFHmewes7yuJaAzcg1MmGv6IHQt52zJ8pdH/nXGiyWCOCMM8RIlIMbsRFHqp9BYAz
 GPw0b0pi0MkD3V+if6K7VWcVK+KV3kXAMrms00TLK+z0H0Q36EFHIJ0zsf6O7kL5rnNSVXaI9qg
 e3P+S1CAxs5K9MJlOewxW1PT6kFNlLsLDNqJc2eBTqb4sBc2+desbLI+sCGHe0o5+Sutqt5Sie6
 r56ZxCu0Q7nMYFcqxaMqTL8OQcr2/dJe8c163dEgnQVnYNffvrFKSB/8L4GVGEQsMDHzlrTlPV0
 mIhY+QmK0WxjJviPlL6t5pGoynSbV2wdegugXMLGjMxSPpoBLBQ4RXtx5UKvRDI+OYOlwskSajT
 Qnbi6JVuy8EiUpdY4R4kcsSpC1ys4trTK4dRXqGu7QEfaB8ryawF2g9I8YvQ/RGsre3buCML
X-Authority-Analysis: v=2.4 cv=J/Sq7BnS c=1 sm=1 tr=0 ts=688d146e cx=c_pps
 a=vXaAVha9trvDieRJfPSLuA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=rhJc5-LppCAA:10 a=20KFwNOVAAAA:8 a=8ufbYHZOYbuoUcblBsQA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 5uZl0z0OZCcpOzSCWy6ehLu-Rq8vUhD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010153

On Jul 31, 2025, at 8:02 PM, Baoquan He <bhe@redhat.com> wrote:

> On 07/29/25 at 11:21am, Brian Mak wrote:
>> The kexec_file_load syscall on x86 currently does not support passing
>> a device tree blob to the new kernel.
>>=20
>> To add support for this, we copy the behavior of ARM64 and PowerPC and
>> copy the current boot's device tree blob for use in the new kernel. We
>> do this on x86 by passing the device tree blob as a setup_data entry in
>> accordance with the x86 boot protocol.
>=20
> I see how, but no why. Why do we need to add DTB for x86?

Hi Baoquan,

Thanks for your comment. Some embedded x86 systems, such as ours at
Juniper, use device trees. Currently, the x86 kexec_file_load syscall
has no support for passing the device tree to the new kernel, which is a
problem for us since we use kexec for some software upgrade related
features. Not passing a device tree to the new kernel would cause a boot
failure here.

Thanks,
Brian

