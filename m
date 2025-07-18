Return-Path: <linux-kernel+bounces-736999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB2B0A67A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5A63B5C24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE3E2DCC04;
	Fri, 18 Jul 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZLbHd86S"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2073.outbound.protection.outlook.com [40.92.23.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A72DC333
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849589; cv=fail; b=WuLdQOkXHFiPjGu3tZJcFQGEYBoPNKvscZVkvHBHuG463SFNx65NqJ7Ru13keIERoEo2WD//pfEz/EEOWuqD/QNkU+P12yYRFq1qs+VcEDYbjwZ19kYQMweBfl3uutqaOIA2drnrn24dTmatILCCqvXaQqowwMGuEMDzLxHX3gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849589; c=relaxed/simple;
	bh=C4rWvrRFjGyNq5C7L+LBddrDZNLBQ2W7XFMhW8vsE5g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JY01fjy6R3SvknpU0nG8ltNYLQg2jpO97ao3LXSVvnY57T2Kd2Scw1Z9vL2o4ZFHKcknllDqsUjsCEVaDYv56WXxiP/GysvFjSB9XOqFVoKEHqjLLj2ncE3fjNOCjQouYDHmJGbyxOx7sUy0XXb/lZSR7xl0RXqm54l1msMJFtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZLbHd86S; arc=fail smtp.client-ip=40.92.23.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C04DRmgrRfUIOLeB/dC/tH9kU4v/GJA4gsfkMQc2NRIMYDZx0HF1EHh0wHCG0uuMLt8b5Yl9aYNz9LZ57FN6o3v5BLfUNbACd/UCHTt/+xjE2kKuN8DVtr9jikoFIQoUol3lsqW0YiUoEvNd0h1Dg8RhgLyXPxKAMRR3p0B985W6+CRXtLpVHqXDYnX4H5H6oaol9fpBjFQdSCyYKNASH3pH1acKn0MoA8Ug3jhseXXiEzLtHUdEjT4LDqYanJmLz3/qAUxEezFWrZChyZqBFiLiK+KwcsiMmMG2qrmN2K9rYvmLBoBzSuy7afQ8XrVH+Et436kOqTftyhe94oTpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4rWvrRFjGyNq5C7L+LBddrDZNLBQ2W7XFMhW8vsE5g=;
 b=NO/Yu7VK1qQFXunyO24Way35yD/VgSOEeDJmNHtaBK1wN0GsLv+RF3sW2VwgwNaJKxzWGlmZl166uc5hr0GgFsxpX6shaVFty6pch8z7/hV6257vjtAhXsRtrOQv23P48QeYmTeOsMNYU6ujLKzeO/YL0yyQWOCiRq6eXchI1NoVldwQMrfkN1Z8wp3fIS3m76j7RWGUTavaWKW5haK6YN/vXp5vjQiw5xE3cyOkELZi6Sbovt2HQQfMuJ42rz0wsZkjo2YgWS+OhLdpoJyVc3652ucbje6//j+57yS+u4bRHsZCGqAyjqpPzO+l/tWOF65IA2H5dFZyCxVCG16opQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4rWvrRFjGyNq5C7L+LBddrDZNLBQ2W7XFMhW8vsE5g=;
 b=ZLbHd86SdHN42tHgEgOdn+a9gTaqRG6DzymQMok230m+SWmZdJh1yGyZRm7SyhY9xQTtKugWs6A8Hd8uiqRrJ1gBSq4Vej4D+r31ikWEZkYwfVfL3w5z4JeIu/ODHaicnim8PyR2BcBF5G7txuklH0NEmur/KOUxiwk68ZrdO1R6hEDzJYRg1C3eWUBgJ+RS45xSxLZTUh8xZPfXQWpa0zNqIQdseo+Q8F/owZKOQokhzaYjVScQchF1/Wfv9bpaVKSsuoFgVzX6knj7QmCqt/Pu+7VE2FK+w0jUyhIBRWoGIkaT7ieduhy3dQ8KpqEtcNoRnWRhv9lVl7a3dC+YHg==
Received: from BLAPR20MB4051.namprd20.prod.outlook.com (2603:10b6:208:320::7)
 by IA1PR20MB6272.namprd20.prod.outlook.com (2603:10b6:208:3fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Fri, 18 Jul
 2025 14:39:45 +0000
Received: from BLAPR20MB4051.namprd20.prod.outlook.com
 ([fe80::a906:5176:fea3:94f0]) by BLAPR20MB4051.namprd20.prod.outlook.com
 ([fe80::a906:5176:fea3:94f0%4]) with mapi id 15.20.8943.021; Fri, 18 Jul 2025
 14:39:45 +0000
From: Ben Graham <ben.usmarketingdata@outlook.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Reach Industry Professionals from GSX 2025 Event for Growth
Thread-Topic: Reach Industry Professionals from GSX 2025 Event for Growth
Thread-Index: Adv37hEjJT5hocTuRDyALGlZJ3vPAw==
Disposition-Notification-To: Ben Graham <ben.usmarketingdata@outlook.com>
Date: Fri, 18 Jul 2025 14:39:45 +0000
Message-ID:
 <BLAPR20MB4051ABCAD1D264DF18572FD0E950A@BLAPR20MB4051.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR20MB4051:EE_|IA1PR20MB6272:EE_
x-ms-office365-filtering-correlation-id: 30095dfa-1894-4d2c-e2ac-08ddc608f078
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|41001999006|461199028|440099028|3412199025|40105399003|51005399003|39105399003|102099032|19111999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?I1TEb4jSHYvBrQX+vujuhNQlVFH/eU4De/Dg3/HK3ZDfIRBfv5IUZQhLfm?=
 =?iso-8859-1?Q?ZlbR7Rd2QeIyDodEkBB4e8YbkINYfmbsPTwQhBzqdxM9kulMq5xeune8Di?=
 =?iso-8859-1?Q?mC2Ti0KJh0/ywpL/5k6PoYksvqDHr5XPcWU3To05p4Wa/UfxFAO2AYmh+2?=
 =?iso-8859-1?Q?ofJfZrluPiHIDrUmN/Gp9/aAWfz/slpRXNzzIXtM4TiWqOesxTYL8+YZ4b?=
 =?iso-8859-1?Q?8DJ5bbqnOsbCz4fMoK9pATz4KoynkuxWwO0QxB5/IirVLUSxfPFV6ujjM8?=
 =?iso-8859-1?Q?hC0lt+80WR4rMwhKR9rJYAkZMXsxCHEYIGWvXjeQgB7gRf/wfNZgHTDdIu?=
 =?iso-8859-1?Q?GVHY1RRTp0f7tzRnjjj76PO2IlSRMnH/MHT6YzTb1nXVp6jBBQJi2SDTaR?=
 =?iso-8859-1?Q?gLhmxTkzWxZwO3RqUnOJRqiR5hWRunS1SgBoj3ckjCPHKLKfEnj1bo8R0j?=
 =?iso-8859-1?Q?FrtEzAOIgNdXffRrN1M9KmCiqGjxw8H3CfBzGzeQhEo1h0HqdAtc9Apa7d?=
 =?iso-8859-1?Q?uM7tr55IzBa5owFpEJzCX/gQ6iyN4GanvF9yU18I1umhxZRcg9oNmQlWtE?=
 =?iso-8859-1?Q?V6QkWgH14VRsmnQ270/4ZBJontE2faoz969rpKkeeXVmKxFzycy3LCUemI?=
 =?iso-8859-1?Q?E+Q8ZFnKKGZsg64Ana2uJYId6k6xni53iEJv3pdKQD0e+6n/YtT7hknsad?=
 =?iso-8859-1?Q?YsmZvJVHqbTHTb93EY02ZR8wzsFX0xad55C/j3XNoCiWfcGDHujxA1B2gM?=
 =?iso-8859-1?Q?vJZYpWy5JDI4brYKup4ASbeuEfGOKdjmvhaO+bruIfT6RNy83bb+D9h+8l?=
 =?iso-8859-1?Q?D9SE9PFW0I2Q+P+tUwiT1e3WKfGrTqTCRGP8Wz/7PDoXN3y8hEEQLb10TI?=
 =?iso-8859-1?Q?1HGnsnV4uHrIicy/NuoZK4sP3y5M/6KIOKR5WJitDkZk3iVywkUETAv6VT?=
 =?iso-8859-1?Q?RcoAsSIkiDw2Ev936M5qRYtl5qzO2bw7oxkSsaRYDVmkGmXT4lNfkKBVQi?=
 =?iso-8859-1?Q?zYdhlgeRFvYgtE+TtPBUPsE37lbgbC+F/CyYeyIbNIUuwZebKZWIKmbXGY?=
 =?iso-8859-1?Q?HaY8wljev/66i6VLPxqmmY9L8mqnNC4itnffDtcGmTZ4kE58vWJ0UDVsgC?=
 =?iso-8859-1?Q?pXqknSGXvQRHxelwnn6RRxL974L2dh55MxSscN08sVzDkMiYRMO7ME5MHv?=
 =?iso-8859-1?Q?HKIKlOA3oIv7AA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UAxJVer5By5dDO4ylYbHpmGmR/oKVdZXS3GrwNakXQwoLhM+4HBE2nZq9o?=
 =?iso-8859-1?Q?RfVg/hkWnXES/HDfgQ8EAX1vxHpFy3y6UgVRODwDUcHRs0PuwTXkW4pAZ4?=
 =?iso-8859-1?Q?ZQwVyAhaqG0/L+BCF57EqDD8bMutZsJVRc6H4pUfjFa2Gvu7cM9IvNKvlD?=
 =?iso-8859-1?Q?3FSk4jQrm1dBBWE+610BNUMAmKVwwZSiBNefU/ClPXUohNv8aZVUIiiaMe?=
 =?iso-8859-1?Q?QkOkJni2LOwSsnIQSZTY+ubtX13IrEgrv+ijZBX1vv6/T9+UQ+P60bk9Wk?=
 =?iso-8859-1?Q?IaoEAND0hfU1UkYGNTi2qKzeS+np299P3mmxapw/ZmEluGg+cSQq+0PBxi?=
 =?iso-8859-1?Q?bS6ICUYO1ctTtrDZ4qcNFSHUBRQqGKwhymduV5o7D5r5nSruS7wG2Xc1tj?=
 =?iso-8859-1?Q?95fOjXr/N46qlPPHP4dQEORtQkDYof2NexOKAgJa7LrUsu8HITB7Hq8oJH?=
 =?iso-8859-1?Q?tCMtZYPb5j6FUZp+V7QXHIYe54eDNGf47yPwgYspUkDGKcx1bGZKAIUsQh?=
 =?iso-8859-1?Q?qDcMGe3TPS7SRWNceD29Xd7kM1QegVPc4/3tAxMC1NvxYzY6onFde/O+ST?=
 =?iso-8859-1?Q?vjJs4ERMFaLD9Nt0kICs14ol9YL6na7TeFdcSHKaopedZVa6VOhX4TSEnT?=
 =?iso-8859-1?Q?maz7pZWbhYUVSU6gajnvoyLoC8qOUd2j35LgdiEWuh3n/WDc9CQwA9EMDB?=
 =?iso-8859-1?Q?bpTIWo/sWAWyClKJ7kFGRBj362ffAA82U1SD2CKePHGA8EB3KeZcbs2V8g?=
 =?iso-8859-1?Q?4b0s15djem8X3W2vZjFWuB7/0/NaJlUy+ltDnj/GACoIhqeQheDngjtf9E?=
 =?iso-8859-1?Q?L+Q/FEhoq8VEZjhhzPoKYHlAIAn1bJ83VhKy0Wj4nQjBftzXgzPWGsGB6P?=
 =?iso-8859-1?Q?7zYRM/sSnCBNOSHxVds1O+gh0iHJFuPvtMITNfZoGe+4tfKDAKibb3xYNb?=
 =?iso-8859-1?Q?l4OcAHw5A/Fh6XzesmU9sjHhbe8ATLrU0ILG1i3Xb4HNBuOtJd+O5uCWTs?=
 =?iso-8859-1?Q?IWJ3If/zXw9ZIhIYJN8yJNBFUtaCX4yEatKRCI6KPEKFnTeyjhnCQ47eGx?=
 =?iso-8859-1?Q?VfYgrVC77azdW1kCulHQaD+MoxniIp3Vq6QewRk+REmg2NvYNJi6gEaaVJ?=
 =?iso-8859-1?Q?9AH36wfrpXsmLQ6RvK3c82o6u08TcF9Rr77wydVOvYF3GPiDpocm3/yGi2?=
 =?iso-8859-1?Q?xEpp54XVBlcnx2TzO7nlajYNUiAI7uoVd7s+CGkuAiukS98lrXeVxPHNI0?=
 =?iso-8859-1?Q?8oBvm7yWIAjUu14PRyFOU3d8bD+ldpqcJVo57Rn+2Wq7og5TUQmYk0iiWc?=
 =?iso-8859-1?Q?uGiOEtlawOcUpia8op466RzDO+TYOKMy+ypuwX7ejHyPZjSCPWylTE87Il?=
 =?iso-8859-1?Q?WjOU36UEhe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR20MB4051.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 30095dfa-1894-4d2c-e2ac-08ddc608f078
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 14:39:45.1851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6272

Hi ,=20
=A0
Thinking about getting the GSX 2025 list?=20
=A0
Expo Name: =A0Global Security Exchange (GSX) 2025=20
Total Number of records: 17,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.=20
=A0
Do you want to purchase these leads? If yes, I'll send you the pricing.=20
=A0
Hope to hear from you soon=20
=A0
Regards
Ben Graham
Demand Generation Manager
US Marketing Data Inc.,
=A0
Please reply with REMOVE if you don't wish to receive further emails

