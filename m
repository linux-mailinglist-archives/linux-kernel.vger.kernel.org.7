Return-Path: <linux-kernel+bounces-767410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44222B253ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CC28859E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766B72F9995;
	Wed, 13 Aug 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="WzlBj199";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="fK2TWPDw"
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13785C96;
	Wed, 13 Aug 2025 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113134; cv=fail; b=cX5k1OBkr7DQvGjGkPYm9s1873eWv/0sWy0KdcYzGB102Nxvh8IEUrTsRZX7y9DzCDDkhw483fQMy6rWfVNsv510JV3yF9p/P62KivgUxvP4b/IRMbZ1oc9L2DOa5vhhOVPjga3l54hQBIULp29dHy5ujjO+9KSj15/RwzD7XrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113134; c=relaxed/simple;
	bh=XRCAQ49IoqfJFbgFjrltZHCGgbFX91GgHl4SAQhJjmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pt17hqHvdjohNdH/crzhf9dynakcDlX66ODlyMvYSS6Yb+rakUKmGTP4d9FAsol0fo/WvdG6KsZtH5nYJ1P/HH51Ee2LVrQWq4ylnkJGBlFClzV3tJTvSDfolK2GB1zXX3j4hnJ3XBIcTjXscZOERZV+alyQlibmJ2kQx4btTn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=WzlBj199; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=fK2TWPDw reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108162.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DHOcGj028429;
	Wed, 13 Aug 2025 12:24:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=51ylVmDb0ehjQrBxOHeYbr9zbh6DhLqkQ64EHrW+JiU=; b=WzlB
	j199jvQCkCY/fYb6vGW83rgMhgp0Y/HBIiJgolbUEsOouIVs55HohfvfupXT9wcl
	DkyVWiSXPoyEU1SLyXULVNkJ9vlWnvVXDG01/ojQ3XpxlVnLJNEZMc7PwqLmQRqk
	3SUSws95REuaqsewvoYnW8Vxf9tSoHZaE2dJg3aGYLwGRE1yHWeCkbRniBce5fHX
	jBjLrlWBk+6i8QkFXZG9sd8tgYARkW9ij/91z9qyV8fAP0XPxKtMOGLVf/kouS/C
	bOi7RYssZxLEKDd5ZQxFRBigZIruZ1RIAATe79ihiz9E4hRiMUwExx09WqpLcHIY
	mMzRyyzusAOhz5R2Wg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021094.outbound.protection.outlook.com [40.93.194.94])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 48gr8n9g42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brHzNnwd4obAPCAEAODoXJLWYNa/QOVQgkSTdDNXcmikY0uKD6ApeBR6fpZWYIzHSavDDRU+3GlXMtItW8niUOfBMPWO5rChuUfkBC932K2zVJvSwP/GmFLkymUKb9kf7lzGllqNcH2GU6zpVAl9WAmMfMnc9V9+HIc82RIzmF5reH5ZQmHCLt2RSqwM0PTqwhJImowuy2rXUT0noIijZKa94y8J2YAD23xAMTTUzWR5+ZZJPFhKDGIIv2mHSZYRJ0I00AiVGg+x4b7IJvXfPdAkaYGJ7T9u2cWmvQvOIyppvyP8uoVOLTHHOa2KjZPRr+IJW0DOKt8LH0pVHOZUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51ylVmDb0ehjQrBxOHeYbr9zbh6DhLqkQ64EHrW+JiU=;
 b=jKvEI/zGFcvu9JDkFUcX+qCMIGH1+VdSpWOuUaSC58ALwjPVueq3EIaZg3qR37igH12RgtiKJSG8N7pSAuFUjE8XMSTEuPF7sYq1vOW/Ivx58XIBR1og5QDVcHNrOXCzT8TPhkklSxwt4LSKo2D1Q859lhoD216VhLV+iWQiTLIhKeI/MDjVt7jP0D4F97pqgRXWZXFREhuhyKiC0RS8U2sNaeM4NicRD5uEHNvchF4ZeKy2s2cwBfoAyVW7Vcdlo8YPelHZM56Op6D5mj1zSfFwk0Zp8/SzzNbxvYC05S4PY2vC7hp/X9spIcRKdA9quxq22wX0I4/SeoRuqSJHXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51ylVmDb0ehjQrBxOHeYbr9zbh6DhLqkQ64EHrW+JiU=;
 b=fK2TWPDwqumSD+dnfoelGjpCGb0KdUROH9sVJyTizL1PFHxzBp4Uv1UurYSYNUCMyBsJbxQI9IcLfDCMJm7909aC+5x8MrIbx94ve3iluoSwX652DJ5OnmZCl+WshLA5pF5rpvhv/2YkPtKYyGnXrAJZWtWDUCghpxceIr5GfgU=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by SJ0PR05MB7279.namprd05.prod.outlook.com (2603:10b6:a03:278::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 19:24:37 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 19:24:37 +0000
From: Brian Mak <makb@juniper.net>
To: Dave Young <dyoung@redhat.com>
CC: Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Rob Herring
	<robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "x86@kernel.org"
	<x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
Thread-Topic: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
Thread-Index: AQHcBk4phVhYdt/4V0qVrvNiicYNsrRfWUCAgACmJICAAQPCAA==
Date: Wed, 13 Aug 2025 19:24:37 +0000
Message-ID: <A402BEF1-EB1A-48F0-997F-502429AAD92E@juniper.net>
References: <20250805211527.122367-1-makb@juniper.net>
 <9B71EC74-D1F4-4F7D-837A-A43E53CEBB89@juniper.net>
 <CALu+AoQnXfYtuKQxVKK32sC4D98Y+Yn30TjTr2xmXhZcHe0x=A@mail.gmail.com>
In-Reply-To:
 <CALu+AoQnXfYtuKQxVKK32sC4D98Y+Yn30TjTr2xmXhZcHe0x=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|SJ0PR05MB7279:EE_
x-ms-office365-filtering-correlation-id: 70b49b58-3a6e-4d07-a013-08ddda9f0adc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r2ZMkyP/JtCEY4xyyBUyU0wax0n0AqHXKg3bBnNBgQa3yrEdG9Sua4eFUO3r?=
 =?us-ascii?Q?OQ29JRQO8gtTP55lo7xOc0UqOXafMxCKpZErpoh7arFZ2kJddgPLp4ge9Jpw?=
 =?us-ascii?Q?l4NybxM2oUz3GKmNoGW8qSIo4KsWiyJR/XRRM8hyXHx4P/hHY7Yu8MyiZviq?=
 =?us-ascii?Q?3kPHCgVoIYz1uLdzeOKVOSXUKHqb5UToXM5x99qiIvRK+3+1Pxws2cBjZmQl?=
 =?us-ascii?Q?L0TzCwpWz/adiJdTbA95138oZEocEd37hVwMaIDutRJrLolV1ULN/ij2BjI5?=
 =?us-ascii?Q?amlC25cgU+rKkV86aEOaiocHIQM8jf+YWJrTTB6xSiNkduGDrBdD+kmj5IUl?=
 =?us-ascii?Q?JuTBc7b4xRMUjCuG6d7JwTC+51TaQajs7HiQiNSoUwFWnARAh+7wpOE65wMZ?=
 =?us-ascii?Q?hRwknrGi1EBk9KlskMlspGoOqbdDBPEOqitL4h+ubSwBwLTidgfhFMfHfRpt?=
 =?us-ascii?Q?/oqtaHl1OGqsKK6tXuDhqectUqkvjmc8ObG78lC9bBp+uLLaZ4D7iy6lNSr8?=
 =?us-ascii?Q?24e6dl6d65mMvH2pBkxC3AmBY4iwzB+i26W32BcJqyUDlT97yrIgpCP0F+Ls?=
 =?us-ascii?Q?QgEh5nTOzJrWMjUZQjKQy8BHQh3HQRHZfuqA2xDAWZv4ZDA4fF3yVOZEzaWA?=
 =?us-ascii?Q?VJLJuCEN3Vz2NdiR1wVYd/oiaw0uhgeslyjP741S2DQ6oNfY6MsIf/OiPoTF?=
 =?us-ascii?Q?bJBKs/RPeBdzfsPwjWyD33QVXHAJjVHPMGCmgW31LkVsiOCWEmUlgMCr5iWY?=
 =?us-ascii?Q?fDUKLkW6rOyjlL0g2CIRV746h6k8yaQ2zi21nmoDfNFobpTrdjNyEFP4LA+U?=
 =?us-ascii?Q?1hwBNa3wCqPvrvMB7pKMs4UaX9VcdiAll87LnYRqzzl7/vUSEJdXjeiGLHRA?=
 =?us-ascii?Q?+rncz1DwdUPA4iy2iQbhrlGKsVWOOJq4teQn3c/eC8fR2EkuxHy7ksBkBCbJ?=
 =?us-ascii?Q?B7asxzLL1j7VUgVVmcDAVasLExeoDMdun6Manya9dVgJ+d2OVtnOS52zQyRL?=
 =?us-ascii?Q?6vYbNVTu9ew4pziLOqB++cC4GFMqGfq/KoLx/jDnX0vx2PP3maoa+12yjVuM?=
 =?us-ascii?Q?Co1SFc2nLbbMwCyR2C4SJNMSjRhQ2fmHqf7YS0d4VXvjKYnXI1UiHs6mwq4f?=
 =?us-ascii?Q?oQyACY6iSh2iIhIMQVqlcRe67QqYCAJDZORpGZiXGIcxmKiDOdoWmHs/FFDP?=
 =?us-ascii?Q?GEEK8/zSjSPtwMhGekBSfBA2oOd13pUzBUMe9KVxARDXzuwvWWkV0wfpWGHe?=
 =?us-ascii?Q?Yp09nbaAvHuiqBS9HK1mMXO2jQQdXD/XW7UihDy//1beRDJl2LLBKDb4LoAx?=
 =?us-ascii?Q?+cGQf/FWXDSsu4+yMghoc6QKz8VV4V891bL+CsWskKYCQ+ts2R1lptyX158r?=
 =?us-ascii?Q?3e5h4eiEiKMpTjLSVSZJ3qYE36HsNli8Lw/4dv7DaR6WqD+XkuST6tB0TB0V?=
 =?us-ascii?Q?RBKy446ho0COIBO2xWJ6Ydqco6NQf4RhHBwJFTKlXOP5nU7IQo06m7ZZqDEf?=
 =?us-ascii?Q?BeRhQ4gXM7Mwar8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XjAdmtaydfidmyeoiCJyhR8za6xSR9J5wwGl8TsrAOtvgz+mgYmkLPQqVOFe?=
 =?us-ascii?Q?yD0ffe4NhM446o3KBDz5We5/L9tt0neLxmMbRqpR423Fi7ksGARhL4ojPcM2?=
 =?us-ascii?Q?414/tWP8mqe6J2zabkInZgDHDHrjwlNuqKpZVbhDUoN78vtn6qKKV51Fw5L5?=
 =?us-ascii?Q?tSge/7tLPzRT6oUw8nJpFTy94A8deLqqbbH+Bz3Y+xBcpb8CefJBtbvNh1x2?=
 =?us-ascii?Q?NII9jARyCKtOZ/3PRmZcVhtXvKZeSehtDgvBYNqtSQqsNy0GHK3VCQOFl6ff?=
 =?us-ascii?Q?weKFFhoPeuMZW9rTmEyXHkgQB5ehYONX5Hn5I56avibGA8nQs5zbKayYfEwm?=
 =?us-ascii?Q?f8xUNx1PB9UTfayG8D9l09oDOFx6BsCMpSIOKjMQ3eaWLkktU8AeI4z4kDh0?=
 =?us-ascii?Q?t5SpGKS7dxbdSSuWa3sbnue4AldkLbL4AYMYe8zcXCHxqvK1kw3dup3YOifC?=
 =?us-ascii?Q?wxpfBx3thHE3/5MPfAJbx7iZQuohFkV6B7wAgnL0zrYfYgbQM8p6grFzcw5q?=
 =?us-ascii?Q?X2nsbwA0dlSWjuMGVi8ET8chRvFbqON2uoYyN5mcvfkRHgfPEwQNdWCjjEhc?=
 =?us-ascii?Q?56LxBGfZWo14zm4315xCojBeNY7z8D3d6DQKZx6YE90dniOKG9CVdP+j6cmZ?=
 =?us-ascii?Q?x+Fn++JDWwdJKbN/p6OXGMxJdjNwKyrElPuOAnGF3hq+0xGTRlePhPVbQmdL?=
 =?us-ascii?Q?HLKMAWsPm3q6L3hYgXdd0NZik0jKiqT8cVeBmkLAh22oEnDRwk03rttlm+Nc?=
 =?us-ascii?Q?tE7yl+HPGbwCqxTf+mTuSW/rlF5oqVn2tV/8PhVRUlpDvAkPKWGG24SsgN3t?=
 =?us-ascii?Q?RiYJkBfB+eb3M/nifj79y5xtCNqIUj49sR6LZu2rk7LnDR1cULoIrsSWEVcq?=
 =?us-ascii?Q?oJ+qD+ikwtUVgGJDlF0EdY3IVFCsG3eMg1GIKZIcoyK1GClEB7XEfpVmVVkl?=
 =?us-ascii?Q?oOXNFZW5GD2W2Nhy9S1NdTIBqwDeBKHT5PfN8w4RglosTErVDq5vxEwXe+yX?=
 =?us-ascii?Q?qsFHeabJ3qk5TfF9P2aSPU6Qu/M3I82ikm1ePdyE16ElOZ7B/cynM2vjjyoR?=
 =?us-ascii?Q?hw23xh9Ok8LZm0b/Fa0wbzp8r4vp1UKl4vx/x3EUR3lv0xfbQvGh3pH3ZVoP?=
 =?us-ascii?Q?rLQaeDmBrQyahb/0g7N9McDmwYuQVVEgzFdTIfLOHkcCZ3OJANz4ShmmCFBy?=
 =?us-ascii?Q?vtCMCy66nFUOn4S6TYUbr6EpjzEm5iPCFrSn4lANVGr9JohmqSjAvrAsOb/u?=
 =?us-ascii?Q?LEOcgwPqK7ZqD6agkObszMSKQiBbBt2zWJ8Snc6TWW+Lwl80/P4uUi/O1vjA?=
 =?us-ascii?Q?p5u3CB1V+4h/zw4BagVwaFmdj8Og/nHMQiEVXCjdMA/88sO0uFG/+8smkRIg?=
 =?us-ascii?Q?w0yGZncrV+6rDMk9NvFj7yOFYIok8XtI4yQ9X/GYuu63Qcq53ykTwhRqQiKA?=
 =?us-ascii?Q?7pR9+1K2q9I+qj+1Na6u5k7VMq4hyEEVFQ2+SizXSahYOu7SXzraroEpKkoQ?=
 =?us-ascii?Q?HK6ST+VPox7Lpsiwuv2BiBuyFaZx0mTy/Yx3mhH1RkY1vuUGpdbB/2WEUSPI?=
 =?us-ascii?Q?vyJF74adicc7RVh0OEjR2xm/xtf+HQEyuaz1/CIu?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A186A6DFA795F48A56E4476108E7A8F@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b49b58-3a6e-4d07-a013-08ddda9f0adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 19:24:37.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1DfBKYdwsxxT8OdVLbj+uqrpra05f24JJuSzy5LX00L1DpImidlRW9SCxd5/s/Yoazv8X468fmZxMLMZAFwIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7279
X-Authority-Analysis: v=2.4 cv=KNFaDEFo c=1 sm=1 tr=0 ts=689ce678 cx=c_pps
 a=IKYxX5W+XLRgvfagleVcPw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=rhJc5-LppCAA:10 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8
 a=YE82Es98Jx3yGQJXNZUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5MyBTYWx0ZWRfX4DMpuNqpczKI
 s3GK0YJR9AnfLZDRzTpOru27mLgKLeI0Pz96OVGTQy+T2+7hyf/S6+UgsoTVIi0bmPd+Er6C8fe
 G2LjXaMr+wgqEaOjoRDti0ktUWw3D0N/uNWZfnBZlCF56tKHIbGlfCSkvXEkg2BJ6jB4Csq61Fo
 irsZsc16Thr6e9ZMY9aqbEQF0GNY4SDnOwHoMhegwzxLelP6eEHVR43CqEy9wtiYFkr6EcWYQkj
 1Ir5QwpR1Amu9CzhJw25WHYt8jfsWXytRB5UG/1SI0TS78djQ2RXvAkzd77mv7vghRftg+LpjA/
 e3cJAVNoc3hDUgeFQpf6DL9nEOEqK8scRX6o1GXho/rAHG64pr7E0PpeydBpHa/0/Lyoep3Drhb
 T3PE4eoQ
X-Proofpoint-GUID: 8W6vNvuBgjKBiF4z_P0WcySr1A0rqkuC
X-Proofpoint-ORIG-GUID: 8W6vNvuBgjKBiF4z_P0WcySr1A0rqkuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130093

On Aug 12, 2025, at 8:54 PM, Dave Young <dyoung@redhat.com> wrote:

> Hi, The #ifdef CONFIG_* which can be replaced by #if defined(), but I
> do not have a strong opinion.  other than that do you have kexec-tools
> patch ready? It would be better to provide a link so that people can
> try and test it.

Hi Dave,

Thanks for looking at this! The #ifdef CONFIG_* is used, as it matches
the style of other ifdefs in this file. I'd like to keep it as-is for
consistency.

I do have a prototype kexec-tools patch ready for testing. The changes
can be found at this repo:

https://github.com/makb-juniper/kexec-tools.git

I've also placed the diff below.

Thanks,
Brian

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 9b17578..8419b23 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -124,6 +124,8 @@ static inline long kexec_file_load(int kernel_fd, int i=
nitrd_fd,
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
 #define KEXEC_FILE_DEBUG	0x00000008
+#define KEXEC_FILE_NO_CMA	0x00000010
+#define KEXEC_FILE_FORCE_DTB	0x00000020
=20
 /* These values match the ELF architecture values.=20
  * Unless there is a good reason that should continue to be the case.
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 6bf12d7..0e13b6b 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1102,6 +1102,7 @@ void usage(void)
 	       " --hotplug            Do in-kernel update of kexec segments on CP=
U/Memory\n"
 	       "                      hot add/remove events, avoiding the need to=
 reload\n"
 	       "                      kdump kernel on online/offline events.\n"
+	       " --force-dtb          Carry over the current boot's device tree b=
lob (x86 only).\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is =
loaded,\n"
 	       "                      0 if not.\n"
@@ -1640,6 +1641,9 @@ int main(int argc, char *argv[])
 		case OPT_HOTPLUG:
 			do_hotplug =3D 1;
 			break;
+		case OPT_FORCE_DTB:
+			kexec_file_flags |=3D KEXEC_FILE_FORCE_DTB;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index a2e19c4..2235aa2 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -235,7 +235,8 @@ extern int file_types;
 #define OPT_LOAD_LIVE_UPDATE	263
 #define OPT_EXEC_LIVE_UPDATE	264
 #define OPT_HOTPLUG		        265
-#define OPT_MAX		266
+#define OPT_FORCE_DTB		266
+#define OPT_MAX		267
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -263,6 +264,7 @@ extern int file_types;
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 	{ "hotplug",		    0, 0, OPT_HOTPLUG }, \
+	{ "force-dtb",          0, 0, OPT_FORCE_DTB }, \
=20
 #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
=20

base-commit: daa29443819d3045338792b5ba950ed90e79d7a5
--=20
2.25.1=

