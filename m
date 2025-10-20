Return-Path: <linux-kernel+bounces-861714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A87BF3739
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C0B3A37A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C32DFA21;
	Mon, 20 Oct 2025 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Gfn5krVI";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="tYhfVrKf"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD818DB1E;
	Mon, 20 Oct 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992215; cv=fail; b=kqFaTdEz5BC5nnKDTA6s/nIR8b7kOUXOmIaGStY8+k3e+TItRHe7Mt+snvZPWv8JURK6fPIUZzIeaJq1tEJ5CD7m+cnXtUMTlSKuQ8WjOkoWfROBlx4GVeulqSXn+r/X+QB9yHclC8cNF6IXP7i4XjCSA7SlNQZAaAHCVZ0omGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992215; c=relaxed/simple;
	bh=pP+Cx982qjyIcIaDoooap9xwa+NDlU3Qsfcx7a7jbv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F1I+yKXrrbdzlhn7LBTT9lQe5vHhujHiBedvWohl7D1scUFkwG3ugh3TQfBWbqDYMbrJ7ctKWiZPiRa7xs/Mob3md2vbdGsKAKFOZkOKIv31NlLcL/3fEbEWf9XDLhxXX5QBuhL3hfBcdHp9nXlBMoXt2JmzUmaPSyGBrKv4iQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Gfn5krVI; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=tYhfVrKf; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KJu6jU191147;
	Mon, 20 Oct 2025 13:29:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=pP+Cx982qjyIcIaDoooap9xwa+NDlU3Qsfcx7a7jb
	v4=; b=Gfn5krVIMciHH5xCtcxcbugRRBy41pTzvyQZgArYC+Xyaqd6FxLXfYNlb
	RfO/S+cAvrv7L20BMctfEVBmu4zF632qz1beCQTnnF2Nh4C7l9ir7wSu+UfEp0sn
	ZTKeLHUOT9ez7pFv+ewOwrWmGltdYYPEqqaBaL4jtV0eIgPwNBIaLzw095tdSN93
	zhcNAQJKTHC4DbrHKfMFx2403YZRD9VwG3XpW2dzrKLnLNNw0W+nal4l2hkvJIYZ
	7YYWT2XZbRlsk6obJksQl63QGw774xacA888eRzKl/054itE9o1Y1x3cykzGoiH0
	KmV9NgEf57XejmHO2+DU+6/JnRQMg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021123.outbound.protection.outlook.com [40.107.208.123])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49wup4g2b9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 13:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chokD9FePO8xI1hQQV43I/XbUAFh5T1vYRjM1G9MSNnKtbXeOFMAEVMO9MbiNIs9ZKg13vLG9b5UvyjAAuCVeJFgJPZTnnXvn2Sw/cwcE+EPm60BprVoXG0auERLRq5WyPmYOPLpk6hp1mlitQYVIs3BSapyRivV4lPb05E+ZuHqE/cM8pf9zk25Opt5UjYre0h2SrK2hGhmyldvtEKWl4RsTCRJU2MSbLcVFBOrMEcoZd0lvdlf5Sft9CCT0syscZPcvjUWcYMtvBEuwwf0kH/ttbBnbm0xw8c6tUoiVUC13A34GOOvnDcCVtyx5KhIDnWlaAXOzNFUYRr/HamPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP+Cx982qjyIcIaDoooap9xwa+NDlU3Qsfcx7a7jbv4=;
 b=CWkSnjqwyB8tBygkS9M/Sl6jlm3bGWxCkGmdLiJsgaDp7ovEesfqmdT6GCBtbNePrzH68Q5dPtn+pCHiMnUv7VLUnKsD8TUf15rlOePSKrsSS8a5vlvQPva2XLG70sS5uI6cM72+3VHwnTtxvwLy8CazDt9+UcJLZ4m5ocda1rxm0YaG6RkSQfpmWQFEElYX4aVP6qzFUxIiVAGlW8L7wtWDnFd6HmDJ3cHCT1GZHTAvHPW2Kv50dSWWc0GEGVstdNvVVd1L0GEG5pZSfAKsqCIqOwt0/OvjNZU+L6OZFIXBQv8B/V1pSP7BRRD2Jtc4VfTdnMAiAOFClxxPv1QdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP+Cx982qjyIcIaDoooap9xwa+NDlU3Qsfcx7a7jbv4=;
 b=tYhfVrKfcuPUg7oB/6kh/b2ushHVh6zkV+JoWMM3Iyz/SBwmjt6IPBOcdaOgZZTegKx03esHPAtupTJvnZY1S/eCOAXgnZxH9xtKOoVo2KLysQvnmDMkMNJRUkLSIuOIV+ojlBqSjL5UysGMGLxnfE3dZfJgGqf1DcPf5ny1UeGdDDCJf5yUx9nESq98LYgEn2kh0xX4phkeXFzj5rmIVS55Hp4HgmBBTI3CZM3QFr/hrgQH0U1GaxFiCWnfTiee7EeVUxc9A2e4RnQdMOynH6WbY3aQBysUX0+THFaf8SlVxoF0CywcMGkCnSxc8/kgjTahETDFPj3VrL2QbQIQbg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ0PR02MB8798.namprd02.prod.outlook.com
 (2603:10b6:a03:3d7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 20:29:42 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 20:29:42 +0000
From: Jon Kohler <jon@nutanix.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson
	<seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf
	<jpoimboe@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar
	<mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Brian
 Gerst <brgerst@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        "Ahmed S.
 Darwish" <darwi@linutronix.de>,
        Alexandre Chartre
	<alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index:
 AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLM+0AgAAE4QCAAARygIAAM4aAgAADeACAAAQygIAACg4A
Date: Mon, 20 Oct 2025 20:29:42 +0000
Message-ID: <128D2BA1-AFC6-4147-9BCD-7C148DFF7A33@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <aPZZwoqWV8cJG2HH@google.com>
 <413D20D7-AB18-4D46-8128-6179F2565765@nutanix.com>
 <c1b2162f-5a1e-4072-8695-6c663a1ba0c5@intel.com>
 <20251020192605.yqg5mmvah2fzyjvu@desk>
 <7985318A-3669-4A1C-9282-D940F142252F@nutanix.com>
 <20251020195331.nnnp4y4o3fyzgwvx@desk>
In-Reply-To: <20251020195331.nnnp4y4o3fyzgwvx@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SJ0PR02MB8798:EE_
x-ms-office365-filtering-correlation-id: cb074e64-5d6b-4cf9-94ec-08de10176696
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0RpOUlZWk54U0tLRWcvS2VSSEFFdnVYT0ZVTm55OXRaZlZ0cWRCSGF5bG5v?=
 =?utf-8?B?aVhobGJWRkpvWXRMTjh2TDVTdlBEUTdkdEx0eDlDU0J0MjdNaEU4NlNiQkJi?=
 =?utf-8?B?WFZCREJaYjg3dU9nYzFzaU56K0duc3NDVHp0aGRLUVBWK3dlejBhN3JhVEIw?=
 =?utf-8?B?dGxJVERnSFpBNDlDR096L0RMKy9oejNveFdqaE54ZkpuRzRxeHRTVjdaRUIz?=
 =?utf-8?B?RERjcDEvSkZiRmMxaG1GWnY1WjNYYnd0TXNETHpHUnJjZThKKzcrQitLaWFQ?=
 =?utf-8?B?ZmU2Yk1tSFdDYzRyZGdKOGh4a3BBb1dSUUVHRGZEV3JueTQzZmM5bUxLWGd2?=
 =?utf-8?B?ZGpPWnZ3UmwvMEdUZjJFcE9YdmtEWG14YnBscFhVWWFBdk8wYTZyMVI5eDg0?=
 =?utf-8?B?bk5oa0p4enlLMk0wOUV4YXJBTUIwTEM5cVFnT0pldzhOUWpBTjNlZjR4ZUVP?=
 =?utf-8?B?dmJldEViWS8xTjV6b1VxbEtydWRsdnM5V0FCV1dCUCtManlGT1NJTWQwWm9l?=
 =?utf-8?B?bjJkZGtKeS9OcGxlekcyY2c5YlFVUkgvTnpkUmQwc1IxWjFrT1Rwb2ppWnhU?=
 =?utf-8?B?S0VJWUFDU3U5aC9kOHIvWG10NTFqSkNzMlBVS0RQT0NmcjREb3QwM0UyaU05?=
 =?utf-8?B?Y1I3dThWU2duR1NjQnlKc2p1dVYzVkhUcmtWc3E4bG1ORi9ENUZLY3k4K1Rh?=
 =?utf-8?B?RUpvbEFJemhUc0hZRTIyeXZHU3Z5WW02dm5RRkZmUzZvV1FYK082UmZxeSta?=
 =?utf-8?B?NE0ycEpZanpsbDAzZis0OHZQY0JRa1ZsZUFMbVdpVDRUblo5YWc0c3FlRDFG?=
 =?utf-8?B?OHJCNld4ZDdJb05MeDBOODBVL2p1Mkw0cHhxM1ZTMjQ4UXZHOHpSSzFGUFNp?=
 =?utf-8?B?YmF3NkdrUThIMkRDZ0ZkamsvQW9SbThDU0F6R2hLNTh0WlVmK2txTWpGYjZC?=
 =?utf-8?B?TzFXVlB3VHh6TjduYjlFT2h6cm1UTW5qcUhtb2VUS29lTUdzemNaYjR6UzUw?=
 =?utf-8?B?Q216L1JIa3hKRDVTYUFNMUJweVc3S1pjemVhc2U1YlhyNlhKN3pyZHpZeVJr?=
 =?utf-8?B?R0ZoK1ZiY2FhaTBYSFhuQXUwTTRmbUsyRit4RFVqTXRUK3R3Vkk3enBkcmJj?=
 =?utf-8?B?QXRhcUdBNDNReXFOTkxRZGlqNU9YSkdUSnR2M3h6dVFEbnZ0cmlERk1oRDFz?=
 =?utf-8?B?ZjFBWjFYOHdzOSs4UE1Nd3lMdnBPUElPL3ZDTXNSL3NremhrQjN6dTRvd242?=
 =?utf-8?B?WjZkU2RqNzJWZC9qOFJIL3I3V2V2OXB3NVRQdElJWFBaK1FUTUVBeFJrZjB2?=
 =?utf-8?B?eHM5SGozRjkvaGk5cEZUYzJkdytWSWFITEhmc3dSb2pxR0pxVmEyNlBPTmpU?=
 =?utf-8?B?UlJnV0Fzbjk0WmxyaXkrQW85MjlFS0xLaWFpcU4vU05rNFVCWmN1MlNMVHJD?=
 =?utf-8?B?cXpReklrckdqNDRobEpPaDVnd25LQUpyTm1kdnRoT3NxQ1JWYWxOWGxtVzZx?=
 =?utf-8?B?b3BOUVdCN2dqY0Zha1FYQk9qeEpreFdhQ1FON1AvOWRjMTM1Vndla0Y4NzRp?=
 =?utf-8?B?U202aFN6Sm5ENks5Nm13WWhNVmQzZnVhRHRmNHhFQktpRVhNVjNXSUFZUWJS?=
 =?utf-8?B?ZGR5VURYL0duVXlWSkRBQUZwckdESjI4bmdqTmdPK1NHeUlMeTY0Z29EREpt?=
 =?utf-8?B?MTZqWEVWWmpXZzZWOUwxUnFGYWhaNFJzUnZkNEZ1a2F4a3VOa1lHanZyM3ha?=
 =?utf-8?B?dFRFV0JOSUdjd2xLaXdYVm4vZWgwdHdXTm1BMWtEWUUwaENncS9RQXRoRmJY?=
 =?utf-8?B?UXFvRkRSTzg4Mm1SVzBpaEN1ZlNlMWVOaDhyVnFvaThNMHZqQUF1U1krdnRm?=
 =?utf-8?B?bytzRjQrbWtxQVVOSUk4SUtyWFNjdXBVVGlSSDdYQks5NlpDeWQ1RitLa2x5?=
 =?utf-8?B?RHlZSWNOTVN0Rlg1Nnc2UjBjNTZuZ3pqWTh2L1BBNmxHR0NZOGViaDFMWGk2?=
 =?utf-8?B?dlhiYnhYNFFCMDh3d21POEh3NEJWMitOOCtVblVCdmUrb2pkb2R4TEVITjlE?=
 =?utf-8?Q?UkfwoE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MW5iUFZiQnk4bVpPUDJSSTQ2dmQ4SkVKeWpDUkk3YTJOcUtkeHpQWVF3ZjZz?=
 =?utf-8?B?Z3dEV1lqS3RsQkh1RElhbXFBdGdmOTJFcndMUTZyWHoxdm94MGxTbTNXMW52?=
 =?utf-8?B?NTdpYURZdGVSeW00Qy9KYVptU05NTm5XZElGaDlXNUpBN3ZId3lETXc5MkpT?=
 =?utf-8?B?V2RCOEZFQWxrMTFPdU4vQXBleVFJRVIrVDhBanF4Sllua3IwNktIcUZoN09y?=
 =?utf-8?B?ak5MSnUvZTNOV1dJWkRaVGc1MlVpdlZwQkRpTU8zYmxZQXBxWElXVklXdWRX?=
 =?utf-8?B?cHRRVmFWWVBveFNPcjBBRGY5a042QTNxTFdtbUgzUXV5bnVWR2VvUTB5L2lI?=
 =?utf-8?B?TTlXSHRvZEVzODRHK2szMjZvK1VVUnhTL1BFY3NmSmFLcG5XSG1UUDJrODFC?=
 =?utf-8?B?SEdrYTNxekpKMnBMcDExVjZSMzU3Y1FoSnVYcjlCQ0Z1VStrczljMXJuU0pD?=
 =?utf-8?B?c1FJblFXSFlDN1hKNzBKSHNVcmxWYS8wSzNPUUlPbXYyLzA2VnVwbGdDNElG?=
 =?utf-8?B?MEdCclZkZmtIVUtTUktpbzhoeHVRRmUxZ1Zta09xdlZZbnVHT25GbVB4ODBS?=
 =?utf-8?B?dGpuUkp5dzJIODdBWWhUT3RWV1lmTjh5N3IvcExJeS9GSGo3eWRDajV3WUwv?=
 =?utf-8?B?bVkrZmJIRlpGWE5MOXhMMDh1dUduSTM0ZGF5RzdlWmNhSmtQc0VnQjdtYWgz?=
 =?utf-8?B?UEFpZGlKV3VpL1FsR21qZ051Z1pEejMyMURzb0FkdERvdE9odTRZTVlTQjdS?=
 =?utf-8?B?TjJjMUpJNXdvU0hwSTVWWndYUFN6RVZibU80NVdsM0cxcE0yRVZNVitEc1M1?=
 =?utf-8?B?Z1JEYTFoWkY4Tm1kN1pkelcxMGhucXIxa2Q1ei8wd3BaZTAyZzltUE1zYkJE?=
 =?utf-8?B?dmc4TC8xNDBsQmQ4Mk9FRjZtS1ovV0dtUmxzTXk1MEFVaDJBa3l2aFhGTGlE?=
 =?utf-8?B?eGZrT3JxVFRsa00rbWNyYzVrQ0pFOFlzYkluTXhEcC9waTB5UmpnM1RnL2Ey?=
 =?utf-8?B?TDgvQks5QW5sVVc2UnRuODByYkx1UUh4TVVWa0RZR1JGaEErL2hibVg0aVdF?=
 =?utf-8?B?a0M0Y1FiYWFCSW5FOUNia09XcTNvQkhjTExic0t4bUpucVg3Wms2WWxFSzZi?=
 =?utf-8?B?MmJaMVVCa08zTjNXeE9jZldCZjgxdEdkQXc4M1dZL2F5eWNjczRSRlpZcXI5?=
 =?utf-8?B?Tk90bkJrVUpONEtIS2kzQk9WaWJQaXMxU1ExU3NJTi9rYm9oMkgxNGhOMy9P?=
 =?utf-8?B?RVBDUUN1aWRTS2VjcVBBZHVIYnBQazNScnN2bjhsZjlUbFF4UVJHUC9LL1gw?=
 =?utf-8?B?RXhiTmRHcHgyUDFnT3RZNDVkclUrL0RidGYxaGJOSzFxVG5DSGpwMENzZnZ1?=
 =?utf-8?B?RW5EcU9DY2QzYm8wdW1EOGFxZ3c4bERHVk9zeWZmL2ZzUjRjODZ6WnRiWW10?=
 =?utf-8?B?a0JDMVZ0cFpHUVdEWXVBR25xWlFIYk9kdm1PZVZGVVdQakkzbEdnQXhXVmdI?=
 =?utf-8?B?TVZuY2QwZDJYTi83dUdLc21yVWQ5V2svcDFGVC94T3paY2VPTUYrM0RTTEU5?=
 =?utf-8?B?aTNFNnAxR25WamFuY1dNM25SVlc3eGhYWWV6cU02SW1Fdzg0WFZjQ3RGc2tl?=
 =?utf-8?B?U29BSXVUSHFjU1N6OHdEUXFGamo1VlVWYUFadUVjUnllL1ZKVjJyZDdsdUJM?=
 =?utf-8?B?SjNpcUxrZFplN0xoVDRtZFR1Mnh4emxjTWl4VkJiM2tVandPUXJhellUQzN6?=
 =?utf-8?B?c29Db0hCd3JRS2ZYM1Q2ZDgyK2pNVFkvSUlsRGpqMHBXNHNFWXo5NmpGUndI?=
 =?utf-8?B?WFNGb2FiSTVVWitPNExmWVlQNS9jVzVtempvVENkSUxxQkx2ZnRPYTRiU2Fk?=
 =?utf-8?B?aTUzdjlLSXVIekk0OC8za1BUOEM3OFk0YXBQbDBwWi9yN1FYNWN0KzU3N00w?=
 =?utf-8?B?NGJnZ0JmaXZVR2ZCWXBoK3c0Y0NtWFJlNDlJVFVjbGZBRVpzVm5VY0VOeThw?=
 =?utf-8?B?a0lVSHVRcERQbDJHcTFhWEdXNzZLaXlCL0RRT0x1Qld0dVRpSDBxKzNTZ291?=
 =?utf-8?B?eFduclBndnA3UGR3RWtsSXZYdm9YeDI2RVhONXhabkpMK2pWZ2RhSnZuZUNL?=
 =?utf-8?B?MHdiTHppMDJ2dHQ1cU5rYlBOMWxxQnBpT2w2NVNOS1Q3Njg5TlBkY3gwWmF1?=
 =?utf-8?B?cDNIaW9heVhsdmwyc3lZUi9zNXJVOVVJTjRQQUNFU255WGlOUVVGMDlRbnh0?=
 =?utf-8?B?RUxxeDJuMlpNdGRKWUluZysrUDRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20BE072927B48448A3E964A36CAF373A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb074e64-5d6b-4cf9-94ec-08de10176696
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 20:29:42.4520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PC3Kko5nCPACjkKAGcpr+COCPCPBaX+GGY5zOS7h9hKF2VilhYHCTtmQpZGfSpUIHctiAxd17Q/zPtu2Kt3mwZ2Q+5wizVxVQAGRMDcwcVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8798
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE3MCBTYWx0ZWRfX33Xpqnz9uqIb
 br4EDysIq88RDQU0ZW232vSjQPUxDUhDqYe7luEVcpq2u4qBFBBM799NXQeHeWZ6EQ4tNTC1CAW
 jbBaEjjpMTJ9zOATiGCwVZh/fc5ASXnxnED7Cde1t0EM1rvUBj3sHcGPCi5rx6gy/SwwgndKvMO
 bGQanqtWk3WAd1WCFS3h7TBe9JNQZK/freCRUiRuXbENI3L0uXW8AI4EcpOHxQG0+PsEEKOVdjH
 I+cbTNjCipXQxsjy55KUmYfOJIQC6ZaQWhcn0OhHDqEdeBJM/OFNdsCGJ4dRoXpY/XsFs4aQKID
 CZjlUCjAIut6FcM/TWfO7eJ//bJaey/uVvktfRBzB9iYUODfeBlEMPNiTC7eq59bRYL96DxhSfl
 9PGPA2vo56eWNcAtFaxeUdJqZXSCDA==
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=68f69bb8 cx=c_pps
 a=CxbFE7Xfbix2UyL9/Td2hg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=KlO7aPD0e3czhC6DpMUA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: FsEiRnlQxmaPhfmBD9ke_718EnR9ChQl
X-Proofpoint-ORIG-GUID: FsEiRnlQxmaPhfmBD9ke_718EnR9ChQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIwLCAyMDI1LCBhdCAzOjUz4oCvUE0sIFBhd2FuIEd1cHRhIDxwYXdhbi5r
dW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiBN
b24sIE9jdCAyMCwgMjAyNSBhdCAwNzozODo0MFBNICswMDAwLCBKb24gS29obGVyIHdyb3RlOg0K
Pj4gDQo+PiANCj4+PiBPbiBPY3QgMjAsIDIwMjUsIGF0IDM6MjbigK9QTSwgUGF3YW4gR3VwdGEg
PHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gIS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS18DQo+Pj4gQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4+PiANCj4+PiB8LS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSENCj4+PiANCj4+PiBPbiBNb24sIE9jdCAyMCwgMjAyNSBhdCAwOToyMTo0MUFNIC0wNzAw
LCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+Pj4gT24gMTAvMjAvMjUgMDk6MDUsIEpvbiBLb2hsZXIg
d3JvdGU6DQo+Pj4+PiBXYXMgcnVubmluZyBpbnRvIHNvbWUgdGVzdGluZyBpc3N1ZXMgd2l0aCBt
eSBxZW11IGNoYW5nZSBpbnRlcm5hbGx5LA0KPj4+Pj4gYnV0IEnigJlsbCBnZXQgdGhhdCBvdXQg
dGhpcyB3ZWVrIG9uY2UgSSBjbGVhciB0aGVtLg0KPj4+PiANCj4+Pj4gQlRXLCBpZiB0aGVyZSBh
cmUgZm9sa3Mgb3V0IHRoZXJlIHRoYXQgYXJlIHdvcmtpbmcgb24gdGhpbmdzIGxpa2UgUUVNVQ0K
Pj4+PiBhbmQgd2FudCBtb3JlIGZvcm1hbCBvciByZWd1bGFyIG5vdGlmaWNhdGlvbiBmcm9tIHZl
bmRvcnMgdGhhdCBhIEZPT19OTw0KPj4+PiBiaXQgaGFzIGJlZW4gYWRkZWQsIHRoYXQgY2FuIHBy
b2JhYmx5IGJlIGFycmFuZ2VkLg0KPj4+PiANCj4+Pj4gVGhlIHJlYWwgaXNzdWUgaGVyZSBpcyB0
aGF0IG5vYm9keSBjYXJlZCBlbm91Z2ggdG8gZ2V0IFFFTVUgdG8NCj4+Pj4gY29tcHJlaGVuZCBJ
VFNfTk8gcmlnaHQgYWZ0ZXIgdGhlIGVtYmFyZ28gd2FzIGxpZnRlZCwgcmlnaHQ/DQo+Pj4gDQo+
Pj4gSVRTX05PIHN1cHBvcnQgd2FzIGFkZGVkIHRvIFFFTVUgcmlnaHQgYWZ0ZXIgdGhlIGVtYmFy
Z28gd2FzIGxpZnRlZDoNCj4+PiANCj4+PiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5j
b20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19hbGxfOGMxNzk3ZTQ4OGI0MjY1
MGY2MmQ4MTZmMjVjNTg3MjZlYjUyMmZhZC4xNzQ1OTQ2MDI5LmdpdC5wYXdhbi5rdW1hci5ndXB0
YS00MGxpbnV4LmludGVsLmNvbV8mZD1Ed0lEYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9
TkdQUkdHbzM3bVFpU1hnSEttNXJDUSZtPVZid1VveHNzUVlhLXY4NGxhNmNYb3ZXWXB4eUY4Ymtr
Y2VWLXZZQ2I0OVV1YjRTN25ybElZOVhfNzZmTktIaDQmcz00RUlxdzVVMWpFd2lmXzN6UENYcHBq
OXNzMC1PZ3YxY0ZWVXNjQkU3aHhVJmU9DQo+PiANCj4+IFBhd2FuIC0gSSBzYXcgdGhhdCwgYnV0
IEkgd2FzbuKAmXQgYWJsZSB0byBnZXQgdGhhdCB0byB3b3JrLCBhcyB0aGUgc3VwcG9ydGVkDQo+
PiBmZWF0dXJlIGNoZWNrZXIgd2lsbCBmYWlsLCBhbmQgdGhlIFZNIHdpbGwgZmFpbCB0byBzdGFy
dC4NCj4+IA0KPj4gU3BlY2lmaWNhbGx5LCBrdm1fYXJjaF9nZXRfc3VwcG9ydGVkX21zcl9mZWF0
dXJlKCkgd2lsbCBub3Qgc2hvdyBpdCBhcyBhDQo+PiDigJxzdXBwb3J0ZWTigJ0gYml0LCBhbmQg
a2ljayBpdCBiYWNrLCBhbmQgeW914oCZbGwgZ2V0IGFuIGVycm9yIGxpa2Ugc28gd2hlbiBzZXR0
aW5nDQo+PiAtY3B1IOKApiDigJwsaXRzLW5vPXllcyINCj4+IA0KPj4gcWVtdS1rdm06IHdhcm5p
bmc6IGhvc3QgZG9lc24ndCBzdXBwb3J0IHJlcXVlc3RlZCBmZWF0dXJlOiBNU1IoMTBBSCkuaXRz
LW5vIFtiaXQgNjJdDQo+PiANCj4+IFRoYXTigJlzIGJlY2F1c2UgcWVtdSBxdWVyaWVzIEtWTSBz
aWRlLCB3aGljaCBpcyBjaGVja2luZyBhZ2FpbnN0IHN1cHBvcnRlZA0KPj4gaGFyZHdhcmUgYml0
cy4gU2luY2UgdGhpcyBkb2VzbuKAmXQgY29tZSBmcm9tIGhhcmR3YXJlLCBpdCBnb2VzIGJvb20u
DQo+IA0KPiBTbyB0aGlzIGNoZWNrIGlzbid0IHdvcmtpbmc/DQo+IA0KPiBrdm1fZ2V0X2FyY2hf
Y2FwYWJpbGl0aWVzKCkNCj4gew0KPiAuLi4NCj4gICAgICAgICBpZiAoIWJvb3RfY3B1X2hhc19i
dWcoWDg2X0JVR19JVFMpKQ0KPiAgICAgICAgICAgICAgICAgZGF0YSB8PSBBUkNIX0NBUF9JVFNf
Tk87DQoNCkFoISBPaywgbGV0IG1lIHRyaXBsZSBjaGVjayB0aGUgc3lzdGVtIHVuZGVyIHRlc3Qg
YW5kIGdldCBiYWNrIHRvIHlvdQ0KDQo=

