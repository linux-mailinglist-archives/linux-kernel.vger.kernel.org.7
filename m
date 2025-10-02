Return-Path: <linux-kernel+bounces-840571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89417BB4B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C43AE7FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A88433A6;
	Thu,  2 Oct 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="i+IB8SKk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="buaqiIKn"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4FB2AEE4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426241; cv=fail; b=dCm6qkyVQLIEKOi2JwOCREkfsgqomCeSdPWJfehm9gYj96zbIoID77uI8NNe+Tl7AcMDRGX46tiYSDiYNfGhEqtx/xFagKHWYr6jVsfvCTwv8Dfplr3hDmq8ZuZV7eGzysru7d6JnTt0129LYFbeF7KV+LRmMH5nB165XhpKqHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426241; c=relaxed/simple;
	bh=F6Sb1jP2nzewBYyea4zQztsrl6Fy2g7noLfZ6wvP7M8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMby5xK8fanh6HOfBmo3Rqe9VQZmbykn8IPiKnxm4W1fq2+Uh4Yz7lSHsVOD+TdXNDQqcQJxLZ2nIs6xOVXEHD9673V4mzZVKOzIqXubLgzAU13oKFnmgdOsZVe8QcC5wwqRZBMlBca2EymRoCNvI17T0M9XFFJVsfSuJOTaQ2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=i+IB8SKk; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=buaqiIKn reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108158.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592FaPPS030315;
	Thu, 2 Oct 2025 10:30:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=F6Sb1jP2nzewBYyea4zQztsrl6Fy2g7noLfZ6wvP7M8=; b=i+IB
	8SKk2KgCrATKm+Vv1AFX9KB0BX4MQu0h/Q57Gd9h2a8xVBK/21blHGOxvJFwZOqr
	6HE8e1xeZUG1iFfTuwo1Bo9EylOKTnoqAtnVX+0/uJhRC8RaOTRsJRyrD2KK9E7T
	AeS2eeZdq2if3OBp79eC+0lukbyagi/wMW/GzXIgrBNJxDIELnhYmmqFJx9Gy7ae
	PVIqTvrGivGObUYy6yZG7d97ynutAKRfyhqQPFSmUL0hdlQcadinmssiyYyTcnv8
	cbNjqtk4sws3pTGQT2a2IKQax/AdtkPDP4474CS7rdGX1KQTAoTxzAAQiPJpo3Dp
	UmYBE1+4iQglTDb3Iw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 49hv6cr8mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 10:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMU36vK4GbkDMWeXZxQVEsQACGPXCI2icroyTzPFfTgQm1e+UC9aKgtUCHj6YdVWzFNmsl3/RRswSv4HSnsla4OS8sn61tM9nPjrjEZsA61kq8WezpXwKZd4VR+FHihcnLHWdF9CEYxJECRGL+qJL1NPKn5WoCXrfKwwZJRAVdUPOgha/UULE0cXF7cTiDr49Cq7vcOYYd+/z7ZOTkn6w27iZlnfTJbJAzuo8sCDv8o4XjU9u/I3pVlZLSXyAm0UWbK7DY751IkJ4vbmsPH3237XY2lMM8RlNYnjDSfdKpkciB16fW+kSlPbkYe84ZnQ3cBbZoRxo5cmLYcNv6fvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6Sb1jP2nzewBYyea4zQztsrl6Fy2g7noLfZ6wvP7M8=;
 b=jSJR6FL3HBHRSQRU0XmVSOILCNIF5L/7v/QSQl1/0XUDreCByH5FtMShMCaMR7T2u5tc5nBm20+c2AWHpdkikCVqY4DB2HSG4jPNiQewTrt70P2LYD0kf0Sa6x5SQuXgfHb4CWDERnT89tPpLGsv8Ug03BhhzpIHCl3nMmSwDCbkexwdEFTy092kkb98rb9mVa9uemKzJmpQCP8hr6QBK3wtvxmL14+Gleh+kJVvkPPIgCrwLp+Ti5lVMIzLmnkQydgPwl3HzY6ffgGBgAcQW2q2Ifki+lfoBrIFYUMCLxzwmCn+GDcMyoRxGLmITpqiqXgczB76EFXkin6skFrbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6Sb1jP2nzewBYyea4zQztsrl6Fy2g7noLfZ6wvP7M8=;
 b=buaqiIKnCQx0r+RcwFKyPwkRNXPJf76gRuQRA1tKKj3DA9g6H889+jkFsWIy5pQEIYhZNS7eFNzc5y2lwA7WArBZwJpj9llO41OkPpdn7deLjiX1l2U5V0/W6RplxV/NSnz7E4Mj9YCauylhWDWCgQAXbiSPgLkmayNQiVL98Gg=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by DM4PR05MB9207.namprd05.prod.outlook.com (2603:10b6:8:89::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:30:10 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 17:30:10 +0000
From: Brian Mak <makb@juniper.net>
To: Dave Hansen <dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Walker <danielwa@cisco.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] x86/boot: Add option to append to the cmdline
Thread-Topic: [PATCH RESEND] x86/boot: Add option to append to the cmdline
Thread-Index: AQHcMyfPnnncjiinvUeCR4B7Nz4EG7St/HyAgAEhkAA=
Date: Thu, 2 Oct 2025 17:30:10 +0000
Message-ID: <D435A8B5-46E2-440C-940F-A3FE5364C1CD@juniper.net>
References: <20251001230408.13137-1-makb@juniper.net>
 <f2ed7b6a-46f5-4ef2-a0d8-703595a5ffee@intel.com>
In-Reply-To: <f2ed7b6a-46f5-4ef2-a0d8-703595a5ffee@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|DM4PR05MB9207:EE_
x-ms-office365-filtering-correlation-id: 4abc0b17-15cc-4458-a5eb-08de01d95688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o6KY0d0TKlPn6pUN5yqlZaD4DQMr0k2sekZS5uf2QhdyYfieX+qNBlrcFkdj?=
 =?us-ascii?Q?vAkqWU8bSxvQcF7Dxy5T9TZvWmMnDleMgX9NFQOclH81qHkMTMoX5+yL8g3z?=
 =?us-ascii?Q?SZCscCHzPuULKK2Cfylil+lZc8iKvN8I4tj3SkG9D78PY5q0utx8A32wuzYJ?=
 =?us-ascii?Q?04mPtIRZYqxJAHMSMc5OFr9gUL3ON8yjwgwAFyBH72eU+sL0BmJ9GTJzAL/+?=
 =?us-ascii?Q?9txjDnCHf83ojIYp1Ut4GSuvW1OnLamazCH+QUqIus/XSvE7oVBfsFc1X/gL?=
 =?us-ascii?Q?z7bTXTYWqT7fPxAZRgySduR33pZIUSdyjRharJXCLBoJekgIaPod0G4WK8Ej?=
 =?us-ascii?Q?ii4YY3PaGZBBo1K0eYb3ENU8XSIi+z1OmjMMmUOMGxNOD4XnjWXOpdICf6f8?=
 =?us-ascii?Q?yASaOICJCTlt/U9YvHIR6Zrk9kIEDCbplRGlvFRrqx4eCpJ9tOCRBKdmNPqy?=
 =?us-ascii?Q?rlE3kAkT5G0N5/Ez6ZmXUvT6gzjHcuVuMq/6kghwaVreC+hKXVuF0DT/7C+8?=
 =?us-ascii?Q?1Yjc9K/iXQdJvYjWfaiOdML2itbx7FPnqQ6VfOg9HpuMH3Gxio4VaLz/Q3Om?=
 =?us-ascii?Q?JMk1zfAa/67Wxnk4FbDpubJrGqcqod7MeN/4JUY9I8EIrcRZhxbrwWavYztu?=
 =?us-ascii?Q?7VTIGT0gwZGjqo+UhlXSrHcSygUveenSk978jyXd6Bin07h4neKfQKWWxr94?=
 =?us-ascii?Q?xgOhzHMf7y7SaICXndAfrHp6vJFibStuwCHve4Tvsy5L8BxbfxLnRnsFZcNL?=
 =?us-ascii?Q?ZZ4WN6qpox6YFFFo8c19mPNInySGgk5IIbofJYXHhkTzpXjJ3xxTH9/RCXhW?=
 =?us-ascii?Q?6jIN62nnN/IwFuhBXcupuzszVncduZu+FOh3cIrCI2mX+1iziZpduSjoDe9F?=
 =?us-ascii?Q?nd0gr6J6IKmHC17DGUyXFGihs5usf2f0xHdtvyL8+pfFK7MECa6zKyMi4b47?=
 =?us-ascii?Q?mmJGLvUbj1KKmz2nK6fGTySE022J2Ecw7m7FjVdqxtAQveBhjbKjdxhgY3L2?=
 =?us-ascii?Q?mbngL+s5ifuPWyzq2hVhRmve47vKOjiBtQkqRbOBeabsSsePeAiIt6N+t7H6?=
 =?us-ascii?Q?Iqb/tDtey6xkB1EzNWrH5Hi2O7Zr9wmAaUzZQ+4ZdsqpyBbgoOOLxJbyZUGa?=
 =?us-ascii?Q?65j2j+c/Iar7dVhD/pE3ywFWSQlnBcl8qs6THJ2MOEgQZGnzjix0+jCq3iyR?=
 =?us-ascii?Q?YeOeqoBj/SJw4hj4l/zAeOkspJZO9keaRZ4mbN8vLWw5DJugckiA/ANacZNN?=
 =?us-ascii?Q?d/XU86JNfwyDWqn1DqlcSlKNgVQ067/VGjKU9ck43rY8IAgRjy4pcsYOS1f5?=
 =?us-ascii?Q?9uTLSUKZFJ063aHovKLk0dNOaaqzW3Hni96f+3xn1qm0g/n7cLIQBlz+j/3d?=
 =?us-ascii?Q?nBC0lcjUv+ul+MGFJVkmlUFJ2adVomd94vd3iTZ33V5pbgxucauQujAk8Iup?=
 =?us-ascii?Q?L5n2zgpJjm9Yf/IZvXfhK9gBvufOiCkAFqJELKVP/S+JPQnoof6+DWMwa3Wk?=
 =?us-ascii?Q?dqURdzlw6nYRHUlA34roFjSTzUb5GxXfWqgY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l3O+wWCW4qNRehvArV3xDZDJNizoeUscLr9R4el5lPcf5Y2NS38CL0Ly8ebH?=
 =?us-ascii?Q?5CNjMKgNrh2hDrqIQ5JOmEqSYWUmjnbWv6lNBAgRYceqIaxSzuyk7b9V18gE?=
 =?us-ascii?Q?zqhrJUuXCatEe1/TMP+94ZuLvAG/qFwa4L+Hs+ayYPtSLl6IV6zoYY5LwaSl?=
 =?us-ascii?Q?7IctTWVGaKaceK6k/rXSzVdRX/0y0WT2f5DzAKQQNv9Ebz2pk2E8mqb18IfV?=
 =?us-ascii?Q?itDFelZLl4GwbmJ/vqxR5j26RRPfDIVkJAy915jfd8FDZyUd4Gc48TKMU3rH?=
 =?us-ascii?Q?BkzstuEbftQEWEkAP3T1yB2LrWA89AhWaO5YlYwy/NGqZnKOanjQ9ABVncMx?=
 =?us-ascii?Q?evaJNnul1XR/reZrv/VqEAJsGFhSDM6wzQ6+7hP9G29ZE2qbEm+8nwyWASrW?=
 =?us-ascii?Q?ynUhAsNIYdlQaNoL4N4mOozpp2mKbi1TPScqVMNOmBTuqSzLcFg79L2OKWFn?=
 =?us-ascii?Q?a7GK5e0KtDXenr1XZR76b2GY459nrqXzD1ORRpeQgIy1NIJZW9O4SAYu6OCi?=
 =?us-ascii?Q?gwmwnng+D8/3iVaErhumxZou6BqrXc20t2T3h5ywqFXkv0S8tI19HuoQEy25?=
 =?us-ascii?Q?WnfVvwyGLGIH1aV2cr6xXxbL+GbFEGS4tnZSxG9BCvkqdalm7s811hVIwJE/?=
 =?us-ascii?Q?aGuJqe4/GU5m+5akvOCG/SMiIcu5O/qMmGXOOr7+UTLm6nuZ9QtfNG4Qm5s5?=
 =?us-ascii?Q?A5RXX8x9DTBh2HEi3icc0899IwVNuarUgBdOPF/W28tZB35IepjliMjXf/QD?=
 =?us-ascii?Q?LAirFZI1m1Th+GjJlLsowCJzghuhpLg2CPHxEStj5bGkMnrlFK1IDjtn4y/c?=
 =?us-ascii?Q?R8vf8IPx9T6FwdCiJdmV9Jas23NlsKdjG4iWCwc8e2cLfKQ30iX8mAU00aem?=
 =?us-ascii?Q?37/uzrWRQpOvXVeVbD0LHTKgpAHy2AhLdepHlNAsSeyozG2hzkZN2SV9siEC?=
 =?us-ascii?Q?2JgBV2z0Fr8F0KBhqEru781dgwf/dtWln9SODDAnXVx9vLKMmoJNi3xnYRf5?=
 =?us-ascii?Q?+5sCmE0pQdCWmI1KNC0jLmyJzbKpu0VGOvY3b8aqKu0NtA47mxfR8umxQSqD?=
 =?us-ascii?Q?A/KGCOUO+kPCLrFGn9bMGDE2SMUrNHPtfY2A9bu+bvTWwNIkmrFPSPkvB8Zc?=
 =?us-ascii?Q?jQHK/mW2WyYQYmW+s4Pf19OyiR9dLYrOaJZlp+s2REr5m66ac4SGmN5jjrTB?=
 =?us-ascii?Q?TRu8BLRLD34/DF9esaA6ZMDLYR6Tkipak+M/lW9K2Y3FoGlMYXN350iY2PlC?=
 =?us-ascii?Q?G0fYxEZlWq3EjqcdOryC8qHBCZJUYhPxzj1iji8nDaBnrxfz6slGsrduAqn2?=
 =?us-ascii?Q?wsYu5XKRqp5yrs7u1G2I9IpC+KC+cIMzl22dnYAIBkFuuSMxd59fvPkBvIhY?=
 =?us-ascii?Q?q8WNHvcOPr/XsFVEwbrMDdqyfteb1CLCb0OJEzSblORwxtjrzoQ75DU1p2Es?=
 =?us-ascii?Q?6/yU4eafTgylvO2j2g3jZpwtxQWnyUKhnY35t95pjw55fPtydZ7I6Ljhk552?=
 =?us-ascii?Q?jzQ+hX8O9CmuudOO2kODPWKJ9IMI+KwQ9jHVD5JNFC8VDvWmUJfjfep+Jsgz?=
 =?us-ascii?Q?8Ukq/1kngHICpy6hr9+cUn9cbodv+MqjXmd9bd5W?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE405FD73458134199F11D36DFABD3A0@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abc0b17-15cc-4458-a5eb-08de01d95688
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 17:30:10.4299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22SkfB7iWuosyLBcMlc+EZDq2EkntpMjJJbLnQh5aAJpiG9Ql3AZfV971ZN0wxCTBYbB++v08FkZI90+P1vqbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR05MB9207
X-Authority-Analysis: v=2.4 cv=U8mfzOru c=1 sm=1 tr=0 ts=68deb6a8 cx=c_pps
 a=JX9C1NjKfd8eGP+3z/QwmQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=rhJc5-LppCAA:10 a=VwQbUJbxAAAA:8 a=AUd_NHdVAAAA:8
 a=QyXUC8HyAAAA:8 a=DjgXL5KIVUP8PqHJ2c4A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDEzMiBTYWx0ZWRfX1+T5JAada9T/
 8pfQ/YGerCcBFOdluR9nQa2XFtT4Rp7qGFFPiptJ16wmv+4XmqkF3pp9z52jMCA/3SzT0OPSsL3
 i+QZNb6TN2hcAy+XtJtEazYZtH81dbITbH9x2r1c4+IyYDStp3EqypER3byxBfGUMDj7hVxHICi
 BzBU0yoBmn06+NFJQXKBnh4lo9mDwLwkIWUUu87ud85h3XYSHdZk7/h9J8wiOfLaHPqI44ktrhb
 VyXImnru4OCRuYqAwBG0Is762anoLmKpdmH3b6ZDb15qt87XX9kg6rmvPzIqPkTkMamDU2Xeh6/
 /gujs05OeLwcvWQJ5A1Th5kQjRKnulS0ECEVVutvwvbaBiK7m3xUplZtxfdxHZvPlelYGAjPcHm
 k6BnyoG9Fxdippl4p5grZUSYd/Qj/Q==
X-Proofpoint-ORIG-GUID: V1MCwzPchIt-cwTlnMQYKlcxBHGslxZb
X-Proofpoint-GUID: V1MCwzPchIt-cwTlnMQYKlcxBHGslxZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510020132

On Oct 1, 2025, at 5:13 PM, Dave Hansen <dave.hansen@intel.com> wrote:

> On 10/1/25 16:04, Brian Mak wrote:
>> To solve this limitation, we add CONFIG_CMDLINE_EXTEND, which is already
>> available on several other architectures, to make the built-in command
>> line append to the bootloader-provided command line.
>=20
> I'd really rather not have another copy-and-paste of another
> architecture's Kconfig bits into x86.
>=20
> At the _very_ least, we'd get a boolean ARCH_HAS_CMDLIND_EXTEND which
> would then expose an arch-independent CMDLINE_EXTEND option. Literally
> duplicating Kconfig options just isn't scalable.

Hi Dave,

Thanks for your comments!

Sure, I'll introduce an arch-independent (ARCH_HAS_)CMDLINE_EXTEND option
in v2.

> I also cringe every time I see code like this get added to arch/x86 that
> really doesn't have anything to do with x86 and really only gets dumped
> in to arch/ because there's never been a proper refactoring of all the
> copy-and-pasted code.
>=20
> In the end, refactoring Kconfig is dirt simple. Refactoring
> builtin_cmdline[] into arch-independent code would be a lot harder.

In the past, there have been efforts to add arch-independent cmdline
processing [1] (CC: Daniel Walker). These efforts have been stalled for a
long time now though.

[1] https://lore.kernel.org/lkml/20231110013817.2378507-1-danielwa@cisco.co=
m/

Thanks,
Brian

