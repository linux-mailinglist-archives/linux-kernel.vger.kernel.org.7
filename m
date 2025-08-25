Return-Path: <linux-kernel+bounces-785440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CCAB34AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2590A5E306F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C027CCEE;
	Mon, 25 Aug 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="jP8yt5F4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="grK1ir5b"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB21F3FF8;
	Mon, 25 Aug 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148048; cv=fail; b=eUyQ1767morQ3yD6dEL4D4ExhAAIutJW9jBS0rn+gWR59EcpEoCL4u6c7g1ZKMiXVfSncYCvTVJak+b6CL/B/LAaS/OyBaYqNrVJ/aZtOOTFt1UKYN34S98aaKQdUJekknGWAQRtiecY+2k7s4De40rMRKPa9fDOMSI2aFysPks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148048; c=relaxed/simple;
	bh=CRkNS8L0a0r9RelAEc5x6XdFiIMKeYB7AEIrat9+ol4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MBhOJwt7uzqAEUO9TB3bDE1hz14jo5NF0GTOocRjim8aPn0itcnLmtGbVqscdRlgaqksNoUuej3KqeNK8tJnviHEDTQHIRCsmkU9JLNLsC0Keqm4i6PRA8FIn7xH8fmsaGj2S7STj2el8MtdQH10cdidfELEBSmyiPpsYgtSJ8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=jP8yt5F4; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=grK1ir5b reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108159.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PGg0b7009991;
	Mon, 25 Aug 2025 11:49:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=l+EDaijEmpvwCFbmHs1fX0YJM5APvfk76Si74n1gVlU=; b=jP8y
	t5F4Kyn5t7cj8p5MO/uVbk02XiLsEB+h0KKtKaY4MeF53q3gkLhdUN5NIMf+GGNF
	tIh6Mpfo/SDQswM5WeZZyy1Jcxv5JJQULjcTC33iVTko6dEL8maDZcULBbAybYDe
	J4zxZVLlv3lVJFhhY4y4xJo4QYVbzs2H8V4llQRaB9ddtjzTtPWxP2Pg4S82bt7B
	YDJTXL6RTWmfcjSm4J68jDBf+RkEnDZW56RlENPvuIHVdFLngYnhxkJdFsfJk5X5
	hE5jBv1eSzVK9XB7l9TAjVbkm48LTp9kK2RJ02/VlfH54tuXGbyiXnkukCc/qc30
	YVAenmNRvFPnpnqp6A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020110.outbound.protection.outlook.com [52.101.56.110])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 48ruk5g9t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 11:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZWQZRlJhQnVeyUkvXMH6UfL7PubGIl7znMSrpPdIyK6EKtvyASQYIf+n1OeD3wg5JSR8UK703Mc5pIzRqTR4kB/deP1txjbTHWlbIT7D/WiB6irEdtlI0w49ceIET4OxTSQGsjP2mYDpcBeyxsvIsq5Gaq98K4DwFMr4c5Z0Y6DXclHO0tEMElROO3PDW0rZR8+btifI01Ei9IywylUeFh74kBjCWMSznc7omVyS+0YI5CkIuE3NRkxczv+Sw8eqIUMEamvKp6+x/xSh0oy34cUV9S9RgTIiD7VvyCmFQkfXgfJzjTRcK3ouL6KraqCayyjQxlaBE34l3bBTJdATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+EDaijEmpvwCFbmHs1fX0YJM5APvfk76Si74n1gVlU=;
 b=jc49Y/4/PbKLflSmZh0n038VdL4Jo/Ia7fxsL6H0nJHapIm830foBzBaZBQu6PzosPWyRHLMKRbyhQZx4dPWPxVYBSq9773/sLPdeRQ1bU6yuBGwih5rnrjsat2vCUlvgUY9hEnU6LtqiRrNYdxIxIx1rDuE+cXkAb2RdAclQGeUEuKPH4EaiFOTUQCL2xMVgR2Cg6HptBR2sV1Dlcl083pgA8He4Owt22WzErjuRtOBwI1VbCCLTqEOk8IVAb6rl9WnGUhtNIWZzWRRRvlwZsvbBVXlnz7u5N712qXc+2vUCFI0dEmaATQP5vGu78ekkJW3lH+PpqUZUxuH6m7RhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+EDaijEmpvwCFbmHs1fX0YJM5APvfk76Si74n1gVlU=;
 b=grK1ir5bL/WHns9WX0c4vBW0DkUWEgiHDGFgDZd2MDaU/hy+PsrLMwngHC5/0oc1CydqrqafhGfLQ758YLWQnt+phgYo2zNx6hgglemWLAObvbb/UPt8wIqRXEoDH9ORMSG53NKH3+zZRv6QVy5R8adO+3CK9jwnXqbiz0Beyzo=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by DS0PR05MB9967.namprd05.prod.outlook.com (2603:10b6:8:f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 18:49:54 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%4]) with mapi id 15.20.9031.024; Mon, 25 Aug 2025
 18:49:54 +0000
From: Brian Mak <makb@juniper.net>
To: Baoquan He <bhe@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf
	<graf@amazon.com>, Dave Young <dyoung@redhat.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
	<bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin"
	<hpa@zytor.com>, Rob Herring <robh@kernel.org>,
        Saravana Kannan
	<saravanak@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Thread-Topic: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Thread-Index: AQHcBk4oB5XugUC7+EiYsQsd7ryXGrRsoOkAgAA/AQCAADfZgIABBqSAgAW3BoA=
Date: Mon, 25 Aug 2025 18:49:54 +0000
Message-ID: <9F68DBD7-8A67-4FF4-AC99-5D485D9F9313@juniper.net>
References: <20250805211527.122367-1-makb@juniper.net>
 <20250805211527.122367-2-makb@juniper.net>
 <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
 <aKbZ1h5mjtfoFMh8@MiWiFi-R3L-srv>
 <20250821045319.72e81f40e021e54e2131ac44@linux-foundation.org>
 <aKflAV8XNjqeu1Dj@MiWiFi-R3L-srv>
In-Reply-To: <aKflAV8XNjqeu1Dj@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|DS0PR05MB9967:EE_
x-ms-office365-filtering-correlation-id: 9431fe89-ad58-4cf3-1e0f-08dde4082e45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZWScN/reYzjLO0kwT3ELRyTCYQHInND3S5OnVUf8GkmClCvG4u5+YyObz/PC?=
 =?us-ascii?Q?tfpaQ9l+99IeL3l9YWLjyO0/aszRe7ODGLm4Wt0ol6qAA/EPSFYI6a3Y7Ms0?=
 =?us-ascii?Q?pA+4HlNeHPWTCEzVmi8MagSznLT9yQ9zzTwd/5HnY99tinWO/GVVygcQhrP9?=
 =?us-ascii?Q?iIA8bVoks7inwkZ/RWHphhsBfM233gqB1UmWX87XAvYLdzQ5gVPp2E0o7Lra?=
 =?us-ascii?Q?h7bRY3h3afqPHROl272LbzrzulERZc7xxnpeesLaw3i+4L622X45pAF9rJAg?=
 =?us-ascii?Q?Sq1W7OP9Fy3O+CHsuDipeQnUWydR5z9kmUVetvy9gNNw9AcgFAdRGbxqfr+0?=
 =?us-ascii?Q?YA2xhVwXjI64qY+hOEXaKxEbX+sc0pdv19FUj9xoK2oW0Lvg2CMGsw771ZLJ?=
 =?us-ascii?Q?WBADwUU9RCqMiljP6MsuQ3BnLQh+UdTR/8BObTRYftT3Jrqj7XEf3vOQDZ+h?=
 =?us-ascii?Q?oUaM0DI43zuCo4jrKQ9Mrszz2I6Q8oHBZnyoZIljkWC8ilNkxmyJwbdFk8DI?=
 =?us-ascii?Q?zZoszLmB6PcsITejrYGCSMEk18uI9QgjtDMuI0Tp+WZRSHq2mCg6ADx5CMQN?=
 =?us-ascii?Q?y6LcTTFd1bIK0xueUINI/ubhXRtEYmIF8vBHU5GeD9Vh2UGZ29T72artfWdW?=
 =?us-ascii?Q?qCIMjlEcXLT8qs4KTGfJMsNpPt3vJqIG0qra8MLRAKwiV3En1DSx1xP15zXN?=
 =?us-ascii?Q?/+GdBLxyfkIHHhGKQiPu6oU1MGLfBVm0FEL21Uc4i2dRw4bhrBbn5UyibMM9?=
 =?us-ascii?Q?rR9BTAZnEMpxTcXfv3epyaDWGzwCN5yuVCdQjhCyix4tcezyLKNg+PWFFtOU?=
 =?us-ascii?Q?5dfe3zVahbM10ZOClndRNyzXodvm4SZIlTmy/RbqRonNd7EyDAWp7OYvpFMa?=
 =?us-ascii?Q?Ia0J7/gtOMdNuo5LwrwcFmQ0tVxw7MJqJoRTZd7Ii2kWdFTxS/Xbu0nFeeBy?=
 =?us-ascii?Q?aSXZyt2JEN8Yh+4yp+iarvqB6KfsiY49MXALYBKFMV/eKasz98VWn68U9e7s?=
 =?us-ascii?Q?bCObDsbn8SHhBYtT58MggbvY3dMxIRMssFQD2F4R/xkg6HsWxJBm4MFJYeUz?=
 =?us-ascii?Q?98ngcT/aSCWXHZd0TVY0RxyTDOGuS4THWKSpM1rx4AMglq0SToSZI+/hjhbL?=
 =?us-ascii?Q?4wt/4Bqm/AszF8cOCq5TZTDIRkXN7+y/vu6Plt6zLiMAuHHWlMhXEpOQf0C4?=
 =?us-ascii?Q?+HBRF05nSUNvmtiJNrEkso5YcHWZ4t1HasSV+Jpg+3QpklW/Xe9ErQX+y7t8?=
 =?us-ascii?Q?O5c5IPJVIeeWHq11DK04BjIrKhJi1IU3BIdBMSz78JOrvl77NPjsia/ullWn?=
 =?us-ascii?Q?NCLlsfsmh91AOCrYXnSqJsD6/jGvB97PICIkSwCAFYlADida4vbut9FnG0Tr?=
 =?us-ascii?Q?qnnPiBZxdECYKxZgI88c66x1G1/1IEv6sbRpo+htSl9UnnUyjBJF6coG0ffm?=
 =?us-ascii?Q?ECCf4hEdBgXZVGV6/hQiUFTMZJ7xBs/SA/BqxfE+c32DBAqJGqRCTDUmYW18?=
 =?us-ascii?Q?wKCmQh85ZAN6IcQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QIlhRwhjF+KgD/NjgCs+tUT0ll09Q6An5JmDx8IAf6R5SKuARCG8JSgjke9m?=
 =?us-ascii?Q?W8Sx6QbyOodaU505oqXnKwNfMpMy4XgBmcCYzwWq6ZseOyCUte3Xv/EkPhvo?=
 =?us-ascii?Q?+EAyh7CEzThCX7ynGLLuk9LjxKrfkfOfX0HUqnUSSEo7vZEWuAOSqnDQVYII?=
 =?us-ascii?Q?EvPM6jE7MVWbHDmUD6ysKGRKWk0vZOeYRHtqVvoqd+Yfa4kaTeHqq9j2vrXb?=
 =?us-ascii?Q?16DwsGZ4hoESCq15NULjetsLt498bRtUSe3QKfyDRcn8SLOfPKCMINEMR5DM?=
 =?us-ascii?Q?qozGVf5YrniXhdhZtXHB1wZWBPF+MebGQbmi2YJ842wxnfJorvJJJ+KYajc3?=
 =?us-ascii?Q?W8AIMf4CYtrYZR5QVjcw2LIt6At22WLZ1dpRxiMGS7itYJa/0dLq2aSgOV9s?=
 =?us-ascii?Q?0l0+P9NVSiv6Phb7/7cAL0a6bY+Pag9QeJuhf+cB+S9hIV/u1YB3F3/DSpqI?=
 =?us-ascii?Q?2s+OlPY4+v9KnwIxJXnrhq47iw+buScJqNrRo7C62S2DGHN9LCSH8EeBrIrc?=
 =?us-ascii?Q?QjejdEKFG6KWTxBriTJfq362NLn65tKWgsCKPBfK/PEQd+sh4kutD8uusfGW?=
 =?us-ascii?Q?FDiw4zxyQAKNLFprkdbNd5JfJPattXug1jUyo1H3vgGeFZpL3R5WKSJnJbtF?=
 =?us-ascii?Q?vDyAX6ZAX0Sk8SYB9Bp5nATTtaM5Bqcme0nSRcou7LyufkFD1czrqgT3kc0y?=
 =?us-ascii?Q?H2WCIBbb7U4SAJirtcg514wAGw4fAniiuAyXS/6Ng4igUoiN2ROJfLh1N8Hu?=
 =?us-ascii?Q?WkFKVV8w64sw/3lKumaWFHys7kq5uFIj9KLKF7naHZ1yaD+O9USBvR4rKREO?=
 =?us-ascii?Q?DaGN1S0E5tU4H1PKW2RuxrBaACzaTEMz6IP6J5i60OxgyYHleCuMtRTe83Yh?=
 =?us-ascii?Q?hbvH65AaGslIb8ybmeJhedradPaQQg7swjq/6+1LCvb+4GUPBmxvv/LOrJK7?=
 =?us-ascii?Q?47mPAhopWkiF4TK4VMw/3Z/wwpAxj//teY0vFhgOGI7/WIfo2SIPeIbROvrJ?=
 =?us-ascii?Q?LDKhtulqmlq9rGASBFKf3sQ7vtb9fBs6yHjW8ECA6n0Yg4svnSzpDaKX7oY4?=
 =?us-ascii?Q?I5bxAInrLFOHzY+DzrKp5/sIFyTGmFf6DR+5gCTkjMBs1JzO6LSxKVgdQWGW?=
 =?us-ascii?Q?7JFoQLsEpbx6793YW+EeK/8ryYh4sHAetiMXc+mEK45PvSbIYTBY+GBEmw6s?=
 =?us-ascii?Q?39bm21R462ED7I+CjEUuZxRN5MlHmwnCpK5hQ0canHv3Xu747E7Mnzttupr6?=
 =?us-ascii?Q?1BbBM0hVKvw1fh9CcogGXGbiNXgow2KgUSceKLpv2IdFSGdV2KPcv+5uq8LH?=
 =?us-ascii?Q?U1qC20nVDQ7HvqsFK51QbZ6o+t6HUGVHfaoGkHzm55VnUn1TT57hbuley1KC?=
 =?us-ascii?Q?9BM3y4++ZvFraV36uKuA6ZBw7wyDunggOxnx3kBS5bgTA0/gSDcOrsZpXQJv?=
 =?us-ascii?Q?/MqlpWcM6gH+58x+nEKtKjeY1HGGsHyEAMRSdEuz7Pz5MSYkDXaOY5xLZ6y5?=
 =?us-ascii?Q?gFCnGwZeAV3rl61aahmzfh/z4ucFCim3cqMN9r3J4t4BHsToSxkku0NgkO1v?=
 =?us-ascii?Q?pl0CtUm4hixoaAbpDbPDAI5TEdzKluDYL9N3P08Q?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEBB094EB67F71448E712E7A87B2490D@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9431fe89-ad58-4cf3-1e0f-08dde4082e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 18:49:54.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdFZjL9F3XkKGSnlmNdJBOeq7SSlINWdgpbS8UdE0sBmhlE8PUlQBC1EtGYB1J3fUChJfmlWJIAfyviKp94dJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9967
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0OSBTYWx0ZWRfX3A2FjdGUyZ3/
 lMo9zeuz7YivFPBQoZu1GB2l8bu4flqt6MwRgorYgZVG1AJEwecZCQj5OaNLLq6+bSKVA/jJIHy
 jPDGYqjYFiUihM5TFlppPQupdmNu726k2T7ICIQ7qzuxs1UkM2dwpWbKFeKYHK6OYt7Ny7bKTx9
 r4XJ8i2YsTViV61Ce+fCyofJX3ySSqvF3DxxkzgrQ75LgXsngyRINBwji2eXKxZd4kP5cGIj6NB
 A30/37nlfwWkXqMI5SgqzLG0d4m4dyEV7g0slcgj+WtDhsZDNOdYv74fg5a5izKAcMqAYUuYa3D
 XxkCh3LVXkqA4xd9duTK+NhpnRYudUPtuq4VkkxgpZn+liKJpdgs40wZuJs38XfLIwW2zUoDHCI
 de42WSxm
X-Proofpoint-ORIG-GUID: Bwz5nxY8RXcujScKDXRQ29DJgDK7H3oP
X-Proofpoint-GUID: Bwz5nxY8RXcujScKDXRQ29DJgDK7H3oP
X-Authority-Analysis: v=2.4 cv=d531yQjE c=1 sm=1 tr=0 ts=68acb056 cx=c_pps
 a=HmZmHFuEDL3wSU7VNlSPig==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=rhJc5-LppCAA:10 a=VwQbUJbxAAAA:8 a=OUXY8nFuAAAA:8
 a=20KFwNOVAAAA:8 a=vggBfdFIAAAA:8 a=oGMlB6cnAAAA:8 a=1XWaLZrsAAAA:8
 a=Z4Rwk6OoAAAA:8 a=6b1WC-gfU-G7oDS8jhYA:9 a=CjuIK1q_8ugA:10
 a=cAcMbU7R10T-QSRYIcO_:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_09,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508250149

On Aug 21, 2025, at 8:33 PM, Baoquan He <bhe@redhat.com> wrote:

> Yeah, this is a good catch and great fix. Without this fix,
> kexec_file_load syscall will failed and return '-EINVAL' when
> KEXEC_FILE_NO_CMA is specified just as below code shows. So, for this
> patch,
>=20
> Acked-by: Baoquan He <bhe@redhat.com>

Hi Baoquan,

Thanks for the ACK!

> And, by the way, has the user space kexec-tools got the change merged
> to allow KEXEC_FILE_NO_CMA specified?

I don't see any recent commits to kexec-tools to support
KEXEC_FILE_NO_CMA.

>> From: Brian Mak <makb@juniper.net>
>> Subject: x86/kexec: carry forward the boot DTB on kexec
>> Date: Tue, 5 Aug 2025 14:15:27 -0700
>>=20
>> Currently, the kexec_file_load syscall on x86 does not support passing a
>> device tree blob to the new kernel.  Some embedded x86 systems use devic=
e
>> trees.  On these systems, failing to pass a device tree to the new kerne=
l
>> causes a boot failure.
>>=20
>> To add support for this, we copy the behavior of ARM64 and PowerPC and
>> copy the current boot's device tree blob for use in the new kernel.  We =
do
>> this on x86 by passing the device tree blob as a setup_data entry in
>> accordance with the x86 boot protocol.
>>=20
>> This behavior is gated behind the KEXEC_FILE_FORCE_DTB flag.
>>=20
>> Link: https://urldefense.com/v3/__https://lkml.kernel.org/r/202508052115=
27.122367-3-makb@juniper.net__;!!NEt6yMaO-gk!EbJyF8xO2E51MyYdN3_zqCBBMj0JKo=
iKoPuG_8vEctQMk9uCyjX0LdSEH_FGkPDV8egxzc7w$
>> Signed-off-by: Brian Mak <makb@juniper.net>
>> Cc: Alexander Graf <graf@amazon.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Borislav Betkov <bp@alien8.de>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Cc: Thomas Gleinxer <tglx@linutronix.de>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>=20
>> arch/x86/kernel/kexec-bzimage64.c |   47 ++++++++++++++++++++++++++--
>> include/linux/kexec.h             |    5 ++
>> include/uapi/linux/kexec.h        |    4 ++
>> kernel/kexec_file.c               |    1
>> 4 files changed, 53 insertions(+), 4 deletions(-)
>>=20
>> --- a/arch/x86/kernel/kexec-bzimage64.c~x86-kexec-carry-forward-the-boot=
-dtb-on-kexec
>> +++ a/arch/x86/kernel/kexec-bzimage64.c
>> @@ -16,6 +16,8 @@
>> #include <linux/kexec.h>
>> #include <linux/kernel.h>
>> #include <linux/mm.h>
>> +#include <linux/libfdt.h>
>> +#include <linux/of_fdt.h>
>> #include <linux/efi.h>
>> #include <linux/random.h>
>>=20
>> @@ -212,6 +214,28 @@ setup_efi_state(struct boot_params *para
>> }
>> #endif /* CONFIG_EFI */
>>=20
>> +#ifdef CONFIG_OF_FLATTREE
>> +static void setup_dtb(struct boot_params *params,
>> +                   unsigned long params_load_addr,
>> +                   unsigned int dtb_setup_data_offset)
>> +{
>> +     struct setup_data *sd =3D (void *)params + dtb_setup_data_offset;
>> +     unsigned long setup_data_phys, dtb_len;
>> +
>> +     dtb_len =3D fdt_totalsize(initial_boot_params);
>> +     sd->type =3D SETUP_DTB;
>> +     sd->len =3D dtb_len;
>> +
>> +     /* Carry over current boot DTB with setup_data */
>> +     memcpy(sd->data, initial_boot_params, dtb_len);
>> +
>> +     /* Add setup data */
>> +     setup_data_phys =3D params_load_addr + dtb_setup_data_offset;
>> +     sd->next =3D params->hdr.setup_data;
>> +     params->hdr.setup_data =3D setup_data_phys;
>> +}
>> +#endif /* CONFIG_OF_FLATTREE */
>> +
>> static void
>> setup_ima_state(const struct kimage *image, struct boot_params *params,
>>              unsigned long params_load_addr,
>> @@ -336,6 +360,17 @@ setup_boot_parameters(struct kimage *ima
>>                      sizeof(struct efi_setup_data);
>> #endif
>>=20
>> +#ifdef CONFIG_OF_FLATTREE
>> +     if (image->force_dtb && initial_boot_params) {
>> +             setup_dtb(params, params_load_addr, setup_data_offset);
>> +             setup_data_offset +=3D sizeof(struct setup_data) +
>> +                                  fdt_totalsize(initial_boot_params);
>> +     } else {
>> +             pr_debug("Not carrying over DTB, force_dtb =3D %d\n",
>> +                      image->force_dtb);
>> +     }
>> +#endif
>> +
>>      if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
>>              /* Setup IMA log buffer state */
>>              setup_ima_state(image, params, params_load_addr,
>> @@ -529,6 +564,12 @@ static void *bzImage64_load(struct kimag
>>                              sizeof(struct setup_data) +
>>                              RNG_SEED_LENGTH;
>>=20
>> +#ifdef CONFIG_OF_FLATTREE
>> +     if (image->force_dtb && initial_boot_params)
>> +             kbuf.bufsz +=3D sizeof(struct setup_data) +
>> +                           fdt_totalsize(initial_boot_params);
>> +#endif
>> +
>>      if (IS_ENABLED(CONFIG_IMA_KEXEC))
>>              kbuf.bufsz +=3D sizeof(struct setup_data) +
>>                            sizeof(struct ima_setup_data);
>> @@ -537,7 +578,7 @@ static void *bzImage64_load(struct kimag
>>              kbuf.bufsz +=3D sizeof(struct setup_data) +
>>                            sizeof(struct kho_data);
>>=20
>> -     params =3D kzalloc(kbuf.bufsz, GFP_KERNEL);
>> +     params =3D kvzalloc(kbuf.bufsz, GFP_KERNEL);
>=20
> Wondering how big the dtb blob is, can you explain a little bit about
> the kvzalloc usage here?
>=20
> Except of this, I have no other concern about this patch.
>=20
> And what's your plan about the user space kexec-tool change?

When I tested this earlier on x86, the DTB was allowed to be up to just
under 64 pages large before the DTB failed to load. This is because it
has to fit into an early_memremap() mapping (relevant code snippet at
the bottom). Since the allocation can be many pages, I changed the
kzalloc to a kvzalloc.

For the kexec-tools change, I have a draft change that I've already
shared on this thread for testing purposes. I believe you said you were
going to test it, but I haven't heard anything back from that yet. I'll
raise that change for review properly once this kernel commit is in
mainline.

---------

void __init x86_flattree_get_config(void)
{
#ifdef CONFIG_OF_EARLY_FLATTREE
	u32 size, map_len;
	void *dt;

	if (initial_dtb) {
		map_len =3D max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);

		dt =3D early_memremap(initial_dtb, map_len);
		size =3D fdt_totalsize(dt);
		if (map_len < size) {
			early_memunmap(dt, map_len);
			dt =3D early_memremap(initial_dtb, size);
			map_len =3D size;
		}

		early_init_dt_verify(dt, __pa(dt));
	}

	unflatten_and_copy_device_tree();

	if (initial_dtb)
		early_memunmap(dt, map_len);
#endif
	if (acpi_disabled && of_have_populated_dt())
		x86_init.mpparse.parse_smp_cfg =3D x86_dtb_parse_smp_config;
}

---------

Thanks,
Brian=

