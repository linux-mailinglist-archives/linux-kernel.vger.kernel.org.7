Return-Path: <linux-kernel+bounces-861325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB64BF26E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8323189548F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1327A462;
	Mon, 20 Oct 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="s21H7boD";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="mbXz+dOY"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8228852B;
	Mon, 20 Oct 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977771; cv=fail; b=E1vCYtJsw0OHjVaWt1f+xOMKRHgKSLscvZLYbCC7Ux0DUMgA4A8EdNw3i8oqrcofVyVp4zoPXf0CHLfilWfZhVEKsbXtnp0uaFaqP325UX/vpMp1HibOD7e57Oh0BBgS69tdOqIBKXXl0kjPYpGsGOaCuNh6BCn34NQNL3ppBP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977771; c=relaxed/simple;
	bh=7yw77P8O6/kasTw1if9mF7hgWIfbQsDrTpsHG91lpfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qkm+3N0wzwaFMjQpb5mcPNSxy63o1yWsgKTjz4tAJ7OEuckhKsxHD4lzdDBKHz6t+qsZsKFX6DfKA3Aqw4oHY5HBZ7xCz8uSaiw8WYcr5X8Fj18d57zVpyjQgf7CkzCaCBJOJ4loManG/SVlIon46eBRXKOEq2WkODPDpr4VtLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=s21H7boD; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=mbXz+dOY; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KB09EY1217825;
	Mon, 20 Oct 2025 09:26:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=7yw77P8O6/kasTw1if9mF7hgWIfbQsDrTpsHG91lp
	fw=; b=s21H7boDpTPFNmy1zWAtEE3YTrIDZP4IkhvdTsVoCaxjvdAW2dmpS01o7
	9oxWhxdw122KzlfQpEFiFuxbgDbgNIsfU6f5WcT3boCyomcjusT9jXdbIveO21B2
	oMhweNk6zp3L7aoOvEnJI5vV9iqqCUJU6BtPp0dPyDt+ebLO/8wtEMJ2NjKV5wyi
	XRKco4RroMHUPckQq8x7PMgKtcQ+4pfJZGn1HNwlPSPLkroR3HwMCHAL6loEGqXe
	erjji3mJKjxOFIzS+29RZUSgb/syad4hnoVBmOfbB2IKhVk8i0Rl41w2Lw8qq0ky
	P9Nurmo76p9tnUydfcxZ+6Fjfwxzg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022078.outbound.protection.outlook.com [52.101.53.78])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49vaevbf8p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu9T1Hm1GWjXA4jbYUh1Of3Cq3aARXbqcNctNUxeOcoQRblMyIzmgSPl9h3OVyOc53Lt+9i1LN8R0ru5M7GdZt65Txsa547wo4PuW9/Dt965vAH4/YO+5eBR1QaDmiIoSnhK0tgggrklj/Su6LxlLo1JIOIVOHA0P76jvM+cxIvo/9X0VLhrGKyqB/K8jLr4wvmcXsU034sobVTIWMY1mdY1djqzDENQ4WXYvpFzXw8Ro4VFNXw/ZFkr1LSJrpBEtVs56OoOMqAkmltIDffpUj6V2i8TwLmP+4jKSx62E3KYmgjZNwJ20Yc0y12nRHvzy3jjmPBspbRic+djxTFfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yw77P8O6/kasTw1if9mF7hgWIfbQsDrTpsHG91lpfw=;
 b=tnLmn1l45ZTFx6zyVMlg+YdAjSAb1QkLyCkVEctghhUZaBcnpzl7KClkVd+yXgXReGmAiOtxhYxouUhVle62NLKpK5BtEUQ9ddM2m7QhdzOVcCnLwCmOGgVU5QUdVYbqSCu3RXI25HLWKA7ioay8HxCTE84Bawaovp/JrpNpfO5xKUNB7ZOXn2rWSprq6iA6Snt4UfHupWxyL8vYBQJ7I4W7qerVTqGj2G1cHGz6MHUdyQrtqBLMhqpl5DqJESXx0td0kHYpf5+QjTwZN9Wwaot2DOxR1wfhv5gqwhUNwtcNvmxTp4smirn8JGpVAHFk4LDqHCEcnP80k/tN4JN6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yw77P8O6/kasTw1if9mF7hgWIfbQsDrTpsHG91lpfw=;
 b=mbXz+dOYnJa9Q4ORcOOM+SRhXf27poS3khozBATeJ8fb/q8sLEXs1eE9vbiUK9B44m/Pd04gj2Yxvje2nlh5LHV7EsmtpwNAuyW77FZ0yg3kh5KXJNa48voB9A7V/weYH+FDZ2mxa5J3HrQKU0Ji1PsEYNg5f2hWq8N33IE8qkftp7AlP69DG5FZINNL9ict53439h7C3zrHELSm8sV9mMR2z78ZwfD6SWOhsfYi72H7+Rj3+1vnmk3w6qLxdmgYHA/0zDzZ5Ur6xwEPiHsv+MlpdKTUxMFX44P0HbFTzNrPqP+//rqkmrhTbL1WLFr8WLQeEwkXyzEjnL1PMsoYjQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 16:26:37 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 16:26:37 +0000
From: Jon Kohler <jon@nutanix.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Ingo
 Molnar <mingo@redhat.com>,
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
Thread-Index: AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLM+0AgAAE4QCAAARygIAAAVQA
Date: Mon, 20 Oct 2025 16:26:36 +0000
Message-ID: <D0A1D388-7DF1-4C70-BA58-DF1625077852@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <aPZZwoqWV8cJG2HH@google.com>
 <413D20D7-AB18-4D46-8128-6179F2565765@nutanix.com>
 <c1b2162f-5a1e-4072-8695-6c663a1ba0c5@intel.com>
In-Reply-To: <c1b2162f-5a1e-4072-8695-6c663a1ba0c5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|PH7PR02MB9992:EE_
x-ms-office365-filtering-correlation-id: bc883935-75e9-49de-bc80-08de0ff57104
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjNlNGk2RmNSRzNuZEU3Z0l2QUgxWFp6ZUFOSm52cVFTbGw2NmhxaElXZEQ4?=
 =?utf-8?B?V0UyTTFDSUtNNUovbGZkeGl4U0NEUjlodzBlMVU0MXU4NUphSFZEQ01aS0VK?=
 =?utf-8?B?ZDJnVEhXTU5zcXRjRFZyMGJlRU14eVZ1SFpYSXNJQTJwQTdza29GUFFLMTd5?=
 =?utf-8?B?R0ZJU1A0Mm1jRDVFQ0dnQWpQM285cGdPQXNiL05HTGkzK2VidWIzclhDUTA5?=
 =?utf-8?B?TXdmdWJPNzF4aUFneVhzRjdZWG5oN09WY2V0Z0ZPWEhvNkhmY2MvMkJCVDJD?=
 =?utf-8?B?eGxXdnp3NzlqMjhOTkZKMjh2NTJLM201ZkRBVnN6RmVmSzNDOW02OFZHSWNP?=
 =?utf-8?B?RC9SMHpEc08yeWRlZE1QZ1hldUYvRDdGMkhUM29STGRYQWZFS0ZnSzJsMTd3?=
 =?utf-8?B?KzQySlRjWk9UYnJXTEtMUnFwa09FK0xISnFTV0w1SkpXVjNqVDg2bCtMWW9J?=
 =?utf-8?B?UlI3MkxHNGVTNjdwLzZyQU05SVBRazVQMEhLU2h5bHlvanBlSno1RHY0SW9L?=
 =?utf-8?B?L3g2eEkvcHg2a0NTaU9UemxraWZNcWt5MHUxb1hobXVIVlFzU0ZGZ0o4VEYz?=
 =?utf-8?B?ZTJ2bXJQeTRtWldCZnhqZTVSMzBMQU1RNHRNTUFMb3ZCYXZZWDluTW9mWjRr?=
 =?utf-8?B?bS83QWVER0JoM29kSGtpbkxnQUl0YVNxWmllRVVtYUR3ZjI5SUpGZFhzbzI0?=
 =?utf-8?B?MlltdFRMZS90aGdFU3J1Um1nOHRiN2c4SGFpQ01OZ0dhWHdQZFdxQVcveWpl?=
 =?utf-8?B?ZHV3aUdmTjVNd1dkMzBhVmlyczRiVVUremJDMkRJZVZ3STgwVVQ1RzZ6Y0Jl?=
 =?utf-8?B?dXEwOVhweW1zL1dtOVd5N3hIZnRwcVVBM1YyYlR4bnhaK1pwR29OQkFQOTZ1?=
 =?utf-8?B?cGNXN1Y3Y0RhMVAyQTRIdFpJSG1waWpiZDIxTDhpbUNKZlJ1OWtRV3FKK0g4?=
 =?utf-8?B?WnZ3Tm1SZ1VqZWxyODZsSW9DVm9QSGZXaXQ0a1M1UUZXL0wwRWlRL29iMEpz?=
 =?utf-8?B?MEtBcDZ4TFQ0aDJnRkNZMVQ5cVhUZlpyRUM1dVUzaVNKUmU0ZEZzWFBybUlE?=
 =?utf-8?B?SEJQeHFsVzJqa05RL2c5aW1PMlprZERWcWpNWVpFeVJrY01MMjNHMlcxMDhk?=
 =?utf-8?B?U0xkL3NZOHhEU2hkdG9KSEdlcGhVTzlJQS9wSVZibm5wckc5dnBISUJwNzZu?=
 =?utf-8?B?MENic1ptS3lZV0o1UzJWN0R6SnkrTzBGTFNUcGRnQTdOeE1DMnVRSU14am5E?=
 =?utf-8?B?Y3YrWi8vUUNyS1Q3YytVVUpublNiZjhEVU4yODFQcU4xb3J3aTk4bGpNdlVj?=
 =?utf-8?B?cHNXN294dkd5blBVVFFYeUc2amIxS2pnVllDVFVWa3h0VmNTcUxwSExUcENM?=
 =?utf-8?B?ZEZ5aXR3UVUyY2RZa2E5RzRyem8ySkFoQUJjRzdEYVUyOUluRkdmWXVBNkxL?=
 =?utf-8?B?VGUyTXFKbDc5ZVcxRHdqY29YREY3MnlYYmxKWlZoUjl6UG1EeEhDN2RYY0pp?=
 =?utf-8?B?WEg3VFh6SllSb1I5RXlhVTdWYkE1cFhCYTZ0bkMxU2R1VTRVZ0txTG1sdDB6?=
 =?utf-8?B?VVZuKzJlZ0lUSG40Qng4RWUybDV4dHhVdUJnWTdrVTQ5OFhlWktvWUhkdFZH?=
 =?utf-8?B?RTI4M0loZmwzbVBkRWdRYmpqU0lyc1g5TFcwRTJuakx1c1h2bi9QZEdBN3Ro?=
 =?utf-8?B?WklCaVNITTJscVNoVFh6REF4N25CR1pBK1o4amt5cFNlVlE2d0t0V09NTUdW?=
 =?utf-8?B?NDliQUI4N25ZYU9HazRaeWVXc0J1VXlkYkNUbGlKNDZNb29xTFJKVFY5clhC?=
 =?utf-8?B?TExDQVhab3hNN1A0bERINlFZV0FaNnhPRnBFS3RPYzBmL0c1RTBkY1liM0o1?=
 =?utf-8?B?M1ZIb1FXN0J2dDZya0JwbjNyU3k2YStVa01ab0I1cUV5UnMraTJXTFRvcVRI?=
 =?utf-8?B?Sk4zTUdTNk55bXJaQlkyeXp5VUMxZkw3dFBMSjQ2ZW9NTkU1ekQ3c014MkZx?=
 =?utf-8?B?RW8wVUp2T3ZLZW1ONVB2YTZEWFRnRlEwaDhIa1RESmxxUmFRTXJFM0FoQk1z?=
 =?utf-8?Q?Ts9Dtq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkZ3bndicmE1cHdqLzJZaTFNOVlxNk9YZ3dyR2VqZUo1dEpsOWZXckI5YlBW?=
 =?utf-8?B?cENoblFMSEpMTWRqZFdjdjFYMDVVZVRsNmVxT01ES0tyc2Y2T1RLY0piNzN0?=
 =?utf-8?B?cUp2Y1FDWU1zaDBhWk4wOVVkOGdmRTVVMFJwQUtRWHV6ZjBWN3dpK3JwK1JP?=
 =?utf-8?B?dCtOVG5yR1NOSiswOHczcjBzTXJRUFArSXU2aXhhaTBsZGNaZGdwVUgvRlZN?=
 =?utf-8?B?eE5TSVpyc2xsUm5kK2xLWGs3VjczVGhObm5oUlhIRXVQTFBvT09Oa1Nlc0FS?=
 =?utf-8?B?b1FkTU9BREI5SEMwRi8xczE2anIvKzhnU1hrUmZNQ3dRcmx0KzBFQlNLbVNw?=
 =?utf-8?B?amJNclIxbDZNQjJjTVNLOEIwblpUV0lXc1VFVkM2VGIxWC9OQ1dXZDViUklj?=
 =?utf-8?B?Q0I1b2Yzc2lONGZnUFlGcXhTZDVLTXkrVzcvUEJJOUZpRjZGZUVIZWd4SnhC?=
 =?utf-8?B?MHZFb2tVbEp1M1FxWUt3TkkzaUlsYzVpeFlYdFZuRGJDQ2poQjBzQUdSdHhh?=
 =?utf-8?B?bUExTytzVFFyaVN4d3hBWVhJUlJOODhXTW91Rnk4MEFNblJ3TWYwMkQ1ZlJi?=
 =?utf-8?B?eGRVeFoxRE5tMzYvVXkrVDgwVXlUWHFqcU9aNkc1d3AvOVFGTDRLMEdVcE5m?=
 =?utf-8?B?eFdJV0Z4aC9EYUY1eDI4VktxL3YxYWZCTGw3MWpCR2hBZkNlSWRrN21hR0hY?=
 =?utf-8?B?TktPSnAyYnR4WUdjaWl3Z3Z4QXl3NXhFdk9MYW53dklSRTdJYThGQUxSSlpJ?=
 =?utf-8?B?cWFvS2NHZFgrTkppNXBmZEdlZGlldVpRVkRob2RNWHgrL1ZaeHhpUmlYYm9O?=
 =?utf-8?B?MjBJN0pBK0tWTlluRVo4ZlpCb3RNQXAzRmRUSUttcDBTVHV1VnhvNGJhdTVp?=
 =?utf-8?B?WHpleGVqVDZDNkpjbU1RVzNreG5ZQlYxS0MwSThMbnFoMVNsV3NJVDdkbm9L?=
 =?utf-8?B?OWp1N0ZqMWNQNXBHcGJxT1RPeGRDc0RncFFBMmZ0YWUwMjBsWml6bTNuODhu?=
 =?utf-8?B?OUFGekI0dFh1dXVKQUp5QmRnSkYxeE5rWmlaTjJWVjQ4cFR4VUpZRTZoalpU?=
 =?utf-8?B?N1MrVHV0YUZqVWM3LzdrZ0JPRS80YjkyWnhSSFlUQWVPVGxIK09SZWZ4Vkc0?=
 =?utf-8?B?MGFDS2VXaFRIcjYvWnphRDJ1RWd5ZG93L0NQZXdQZXY1VGhTVDJFOTZGc1NQ?=
 =?utf-8?B?TkFOWitNS21kZUFqdVphQkxKQzdCbTlVa2E5QWNhM1VDQkhYTkNIVCtOckwy?=
 =?utf-8?B?V2t4cjNXRnMyWTdYT0RCNkRlYlJhaWhEdnVnSHhDMXNxRml6aUFRWkF4d2xB?=
 =?utf-8?B?NkdiMjBUS3J1RkdZN1gyS2pvdko3aW1OazlZdUN3MjYyaU5OeFZ5U08yem5X?=
 =?utf-8?B?VlF0bHlpSGxTTDZ1QVUwQ1dvNkh0dVl3a1JPVVpSaTJyVDduV2J3bUxKbTAy?=
 =?utf-8?B?OGpUT1YxdnJxamlvb1pMUXNWYVpOdVYvRnRwaDZ4WWg1ZlRhbHNRdGFFUnZ3?=
 =?utf-8?B?KzhrSml1d2d2a2F5MVpLcjBxYzM5cVN6RWJ2UEQyREdTRG1ienpiMTNOcXBn?=
 =?utf-8?B?WWVXSlN2SVdHcU1TTzVBQmlOMElOdEpMVG8rSE94anpZYTU2VE1VL1FQNElY?=
 =?utf-8?B?R3FUVGhyOHpnaWoyTEtLZ2lsaW95ZXBaZlJVaG1CbkNpdWtLS3paOFlWeGNu?=
 =?utf-8?B?N3JnVjQ3cGVFS0JaRzhETkdYbnNoTzhrMFlpTXJCK0gzRXdwaVJhNFBYM1lY?=
 =?utf-8?B?eEIrRGlXUzJFSVUyaWgzdGpHblpPc0FKTDhiVWJ4M1BxYkx5ZlgyRFlHQVBa?=
 =?utf-8?B?ZlVyWmpTelNpcHJnbmZlSzNvekdCczNwMEZFTmVVOEhvWFpHYmR5WC9hYlBP?=
 =?utf-8?B?UkU4ZWNzMDhaZFdMTWVBOUhzY3cvMEtiampKcWJkc01lT1hOTi9MSGkrbnJM?=
 =?utf-8?B?MkY5TUs3WG1QNmxsVnIvOUJlQ2w3bEVFTC9IWmtyaTcxc2VnQmNlT1p0MFZU?=
 =?utf-8?B?bHJPTEJVdHJmMmRUMU5yUVFrVWNRYkxjQkx5UEdtQ2RhRTc5N2lqOHNkSW1k?=
 =?utf-8?B?WHg3cTN3NXB3ZHk3YkUwci92aW83ZG9LSVZ3cUZvSVhQZHVKUUYwT1lJbmxk?=
 =?utf-8?B?WlpCV2FKNHN0UjBGVHgrc1Q5RGwvT1FYUytzVVBuNnpSRVZsMWdGS3puWTB5?=
 =?utf-8?B?bG84aUFRd2w1dXEyemkvcUxGZklBbXVEQTNUUG9JSXNEeUh5MkVMZWxGTnhs?=
 =?utf-8?B?Wm1pSlp6a1owaEdZTUt5d1l5aGxRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB734AA5574934799B71BDF7AE737FD@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc883935-75e9-49de-bc80-08de0ff57104
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 16:26:37.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8AsWzTS17rSfn8fWAfsoO2pQOBTvlpA/e7vQeMP8SZRKbkvtBaUlHj0PPbVf4h6VchK4rjbLkTMT+asU3mDZFZ8pXHOMzA/6PjGOLloqhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9992
X-Proofpoint-ORIG-GUID: kk2tGDy6RRgobHJwwq8kipNqO8l_LKqS
X-Proofpoint-GUID: kk2tGDy6RRgobHJwwq8kipNqO8l_LKqS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDEzNiBTYWx0ZWRfX+jRL/UVciL1V
 kG7OyMeDr9Iw12TbEKU+6NgTpiP8U1HYat25VQe/D+WmmjtAoXCcD6bIJa+O7uiQE5HNQN7pnO4
 thELTl09ebxvXRVcmyqMabQpoN6xHEfmeL+XP/i01p55zKD6Uayrud81g7AyaqeRzug2iBbaZTK
 Vsla2HEVJ/hh9H1bWLm0fnRueQ+m+LA7q18wsL7qEykHlZO8LmEUz9Fg7azvYaXcYOc9CGBqomi
 GvKhC5PUP8CovJpLkJUkSZ41jUnb5uaDO7KfT2Fv6SCeNBYiurZLTgqp65F+y9E4WzWQ+GWFJj4
 kBJrz7mkuJYx2+Ia+eFicssoUt+wxRvYQJG2O758SAgUmNWy/G2RaEHiQf9jPhf8Dvp1OMYdvWI
 f8zM4kOu9QETrohTqskq6y6wlwqVhg==
X-Authority-Analysis: v=2.4 cv=Fs0IPmrq c=1 sm=1 tr=0 ts=68f662bf cx=c_pps
 a=exbubrTJ8Zn0/ec8zVjoOQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=3aSiiyteWZwcB6efC80A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIwLCAyMDI1LCBhdCAxMjoyMeKAr1BNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5o
YW5zZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gMTAvMjAvMjUgMDk6
MDUsIEpvbiBLb2hsZXIgd3JvdGU6DQo+PiBXYXMgcnVubmluZyBpbnRvIHNvbWUgdGVzdGluZyBp
c3N1ZXMgd2l0aCBteSBxZW11IGNoYW5nZSBpbnRlcm5hbGx5LA0KPj4gYnV0IEnigJlsbCBnZXQg
dGhhdCBvdXQgdGhpcyB3ZWVrIG9uY2UgSSBjbGVhciB0aGVtLg0KPiANCj4gQlRXLCBpZiB0aGVy
ZSBhcmUgZm9sa3Mgb3V0IHRoZXJlIHRoYXQgYXJlIHdvcmtpbmcgb24gdGhpbmdzIGxpa2UgUUVN
VQ0KPiBhbmQgd2FudCBtb3JlIGZvcm1hbCBvciByZWd1bGFyIG5vdGlmaWNhdGlvbiBmcm9tIHZl
bmRvcnMgdGhhdCBhIEZPT19OTw0KPiBiaXQgaGFzIGJlZW4gYWRkZWQsIHRoYXQgY2FuIHByb2Jh
Ymx5IGJlIGFycmFuZ2VkLg0KDQpUaGF04oCZZCBiZSBuaWNlISBJ4oCZZCBiZSBnYW1lIGZvciB0
aGF0Lg0KDQo+IFRoZSByZWFsIGlzc3VlIGhlcmUgaXMgdGhhdCBub2JvZHkgY2FyZWQgZW5vdWdo
IHRvIGdldCBRRU1VIHRvDQo+IGNvbXByZWhlbmQgSVRTX05PIHJpZ2h0IGFmdGVyIHRoZSBlbWJh
cmdvIHdhcyBsaWZ0ZWQsIHJpZ2h0Pw0KDQpBcyBhIGdlbmVyYWwgc3RhdGVtZW50LCB5ZXMsIGJ1
dCBJ4oCZbSBub3QgcHJpdnkgdG8gYW55IGNvbnZlcnNhdGlvbnMgdGhhdA0KbWF5IGhhdmUgaGFw
cGVuZWQgb24gbm9uLWdvb2dsZWFibGUgbGlzdChzKSwgc28gaXQgbWF5IGhhdmUgYmVlbg0KZGlz
Y3Vzc2VkIGJ1dCBuZXZlciBtYXRlcmlhbGl6ZWQg4oCmIG9yIG1heWJlIGl0IHdhcyBuZXZlciBk
aXNjdXNzZWQNCmF0IGFsbC4NCg0KTmV0LW5ldCB0aG91Z2gsIHlvdeKAmXJlIHJpZ2h0LCB0aGUg
ZHJhbWEgaXMgdGhhdCB0aGUgZ3Vlc3RzL2Rpc3Ryb3MgaGF2ZQ0KZ290dGVuIGhpdCB3aXRoIHRo
aXMsIGFuZCBvbiB0aGUgdmlydHVhbGl6YXRpb24gcGxhdGZvcm0gc2lkZSwgd2XigJl2ZQ0KZWZm
ZWN0aXZlbHkgaGFkIHplcm8gdGltZSB0byBwcmVwYXJlIGZvciB0aGlzLiA=

