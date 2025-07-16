Return-Path: <linux-kernel+bounces-732744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27210B06BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5818A1AA152B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33ED136358;
	Wed, 16 Jul 2025 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S7AWsvch";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EzoIMhqf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC72566
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632287; cv=fail; b=uuiPg1YMy4IgcrUfeFUxvWTt2l5uJKDNv9LZWUx4jpbQCel+EiYt/uIAy9KIkX4lf8yO7ck/MLLHU02VSTC2aINFd63DioguUIoCMwAEvdmRcrxIYv7CsoqugaN7uH5ccMgkbnVad2oTQzN+xzdTwHoacYzRsKFvepnx1MU69Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632287; c=relaxed/simple;
	bh=7+seXTLrFyFwq+2gHRieF0LXmsTusgE9KyT+d+XnsBA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Xy9ogjWZrYQAVSq3CsRNv1XjOBCBHfn1DLQfQ2HrviSVZ9NYzXtWPTG5et5RcZU9BbDomFLr/XJRUiconXcTerXXB7rM1dV4mTSH3QscDH0PodcGK+kGz/dj4vHKkNRLelnXtsCOj93z2K84rjBrzBb6JsrpNsMXOi+jAkv2RWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S7AWsvch; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EzoIMhqf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0fnIL009579;
	Wed, 16 Jul 2025 02:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RnYN0nenxdbcXVkamL
	+MbJ9ZA5cQFP7j6vlp7UquPv4=; b=S7AWsvch7Go+iFDAW2yr3P0CtfpD0idrTK
	c3wPn/zyQSyd2oNWBR4H+kdWzTjvYRaIP5FCnqPYwGWzTJ7orT58KAjK/Zef5Twt
	wIVcOO7aZ4Z/oP6MRoHKKYhdojXxONHTbxcfixz9i07ManGxI8V77VeyNRRqsAU0
	TrujI+y6lQo8bj5MokKs76V0PKdWD76+J+H4iCAK6OcEolslx89bwk/yLYv7CkDy
	AaVcrgH8uKKOgWv70GDYtPO9X9O4qVntUadyu2UjMrPdSyP1dSYpoKpPQAaH7UZV
	erK8IJ5dTyoE6dkQYKxcNbssjfCq4B45VKSqc0fe3FrNIRGW8ETw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4qxjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 02:17:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0CA7N030328;
	Wed, 16 Jul 2025 02:17:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ar316-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 02:17:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMZ0z1gB4zY0mO/KeGoJBltOcE2wPH/CfiNaIc6KcC3Zma+RjfvxBt+uI4O9m1P/e7L/ecyoeHjdbpQ3jFgjrsAwCwV8Vp82lZrXsGcqwIzTSdczjAu1goLzUXj9e/dHMJsEoV4UDIHvCnbPn6Jjfk9lTtz0kVP6HHoh99e/kEpNQjNMnfKALaIvwND4oBnd6YnGnIbNoKmLi+Yq+zR6tHtoUvv7bCN+k1jj+TwZfep6jsXwgu7UXzPbWcPpDLGCbw0TMGli+EpJNmPL9Cql6/vzVzbC8OJder0nAqbqvyslF4TiaAUsVFvzuNVD58eOX6vihkAdqOfzlSzE2JzyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnYN0nenxdbcXVkamL+MbJ9ZA5cQFP7j6vlp7UquPv4=;
 b=l0lncPyeK3A25ux8rYEWdXbJO0l5RT+ubo7h9Z8hD9uHmtwfUInTVVjHPS0svwTso9NRZ6p3ecr6iUvxeADnrrj//RcAMT5Fb/++KeayIICe0XtlTZaGvvawekrhnVgfpoEfJO6QWuTHVT0/JpUG2IFYBNUogY/RR4EFoii0tv0dwVHl7sdiiMKWvP8U6tO28ttE8AwqjUq+2NBqnTkl0MYCtSbTBjX/9hn3ZJugFHdl6cEa1/q6MQ1bTttgG5opV5hFPkquQZ221Qx2FzTDEkk6jw6fAK+QYVUaHLKNmOyf3hst7vTfwar0qgChD0RMhPyTcXwl61cSCZRy1WR4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnYN0nenxdbcXVkamL+MbJ9ZA5cQFP7j6vlp7UquPv4=;
 b=EzoIMhqf+6NZDwYKOP+vO1EKSe3Veuy9Bic7JVOCrwRGlAWsWnYIpUuThV5Is7Tn/7X1Fm7li2VzFdLyORXk320fSpgXnN+HZhHrUgmP1aHzU8yO2Ok3Cq/vSCUw+P3KfHTg7heXgluV1QeLjvRzCj/PekxoNpjy5qK73+mFJLI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7804.namprd10.prod.outlook.com (2603:10b6:510:2fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Wed, 16 Jul
 2025 02:17:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 02:17:30 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-3-ankur.a.arora@oracle.com>
 <aHa0j7AtLgnd_53B@google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 02/14] perf bench mem: Defer type munging of size to
 float
In-reply-to: <aHa0j7AtLgnd_53B@google.com>
Date: Tue, 15 Jul 2025 19:17:28 -0700
Message-ID: <87jz48khfr.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:303:dc::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffc65cf-98c8-4677-beed-08ddc40eeae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2BtxtSwOTxI/hEyN1dmoavJDOjZs0Qt1y1a3hkYEzq2SMpAA20kja7SKxskV?=
 =?us-ascii?Q?F9UV8NlqUEXtS9LcTQqo25/SviuIemm27KfV+n0O9YPfNeA+rALt4lyVqxvC?=
 =?us-ascii?Q?HO9offan73Bev75KsV5vx38fdnv5ko9/7LBKHaS4F83oV+udwTgUphS2DQ/s?=
 =?us-ascii?Q?Qr+7v1b/Lvk2NN7CQV0OFbqMAahQWusm4mpkKbgHhju5LScBnLPSoLgtR149?=
 =?us-ascii?Q?RyWXUu6KHRV6Bouxh6YDyDTMzB7P89VovVBaaOi6L4XnELJF1mfwUFBoWVOl?=
 =?us-ascii?Q?cgQrp4bRGA2zFCP2ak8Qe8bBy6vizUHQwx7XIVKhzy8rogM7hrS3ySy3DXok?=
 =?us-ascii?Q?3MFfuDk+0cnz7p2B+Nf4lguGWH+pVerv40u14hcI1n3tdbHRXjnUZ8CCV0rY?=
 =?us-ascii?Q?atKwGto9sUHXirMa6GwZ8Zb3eKlQkZZFvcHGf7GpKK4e3ejJ1v53Tbr75Hqg?=
 =?us-ascii?Q?fSsl/TmzaFxtfhl9QHa0a9NxI2VEIX+WYmz2i3m3fYUNlwH19GhqVwVt0VJ9?=
 =?us-ascii?Q?29b4on7UsY32FEz6VWQlUJ/rDiAimejeqZudQGHElNaDmJetai5ynJsewaUE?=
 =?us-ascii?Q?rbNgkQoO2Mju43mOWtjWtCcAg5YfIDRg/mwzDxzXutOJZBrEqL9/L3d9Uabu?=
 =?us-ascii?Q?hI3ootlKXsE85Soodjf8fl9yotLcrvqeD/4tMZV0vg63qX91CuDo7y2HMnmC?=
 =?us-ascii?Q?23JEz7utwhinDc5522fZICOEnDeIxsr8yn6t6XLfzREHEfV+gGuBW3wWNgkb?=
 =?us-ascii?Q?g4z9759dQTR6Fqrgi2NIEDyDQ2JByqhxK1itdKBa1O7/t8K2dT0x4EPBQ5Y7?=
 =?us-ascii?Q?hCOTnrlfn20NPcdFpXFYXQwwjqMDpGgTaIOYXdGeHo/hQ8G6JrAKIgCKGG5z?=
 =?us-ascii?Q?wfNbvEcvst/Pn09VBfAaDz19v3nBXiQBXLzfptDwVEtptZCeVJcLrMl9/3/W?=
 =?us-ascii?Q?dQQHdwKeSs4rOHe1kQ2ca9EMOCL6v4yyOLvK7eUiy3JX0bvQnbPgPBgDlH4f?=
 =?us-ascii?Q?wfUqLpsYLUjDDqIisRizOr7rh7T1xP0K/jUybNRfohdc7xnVmfEFXcO2lOBt?=
 =?us-ascii?Q?MKRIoGxF1z7/YT8OppHHmBhQnLsOzVgoEskRnsAnLPAEeDyAP7CliCN5Icm7?=
 =?us-ascii?Q?W6zb5mue/+K14Mnj7x4C7MELitYWNNS2If3kbxUyg2iNVp6p1BP811JrNLox?=
 =?us-ascii?Q?/AVunueIlwlIQNg3K5k0g6EHUGOqFMbloZDo/MW+sIevPHWWgtOS0V5qf2Lq?=
 =?us-ascii?Q?7Q8wZF1LySOIFLW31fd+760OusTh2M7VYOJC6Syece2qq33oxcHzAe4wafVH?=
 =?us-ascii?Q?bnXnLl+GI9Er/MQpm9du1T93cs2hfHflXgeA8BfuDIYxGRzvAzh98rJUz03R?=
 =?us-ascii?Q?oqQVBaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UBeQ0BgPZ0boODxiAK9dgT/w+GDvkzWcOBc+q/UfSBmf5BjpJ184F6k0mn4/?=
 =?us-ascii?Q?PbTvPBDIiYD/PB9AN9IVWRRkstrqI2AOWRtGs4NgpjgI4PKb89v/YGMvFnYB?=
 =?us-ascii?Q?1vRXdXPm4MeEOlxojBSpqIpm6IlVKzcHqupSDsfzspNaXDxi2hH8a+0zRGSv?=
 =?us-ascii?Q?+6zeqL0RTJBXyh/uB3RqovztltzKxHQ+J7H+M6n3/Y6W42BSph85LQL9kmoZ?=
 =?us-ascii?Q?XK6L/x5zPAkWrfxT8A06wJza0fL5om7ukxR3ctbxsYUMmd2BuWA5M14Whto5?=
 =?us-ascii?Q?WQwKAKJBTaB6xXYfyo/t8bWlB2FZiL0lrMXnmahWpR62Il0/CRMpczlF8t1N?=
 =?us-ascii?Q?Mimd54ci71ey0TAqqPXSSpjnBa9nOYwCPP+TAXFkhvAKMDEpNQb6Zck6dJjN?=
 =?us-ascii?Q?qHJ0W5SPjnafFHQmb8EaL8q2//ABxZ9832d2cX2XOTT6SveSEKeGQqAs+fMv?=
 =?us-ascii?Q?h0BFEAwPgb/01e0N35Iu79nv4HrfP/2BiFz+saNgWA5Y1/pn/S50xMYMG3bw?=
 =?us-ascii?Q?+LreNjiLP5iiDritIuzrf2lsgIGhdKk/0L/kOcC3utSCDZeprnr57I6BT3S5?=
 =?us-ascii?Q?K37lxfGvymWTt4tfEmRBZxAbEQNXpPswfpS0AWQClp43AaqS7Er0hhMZfi8a?=
 =?us-ascii?Q?tPL3/yYv44u1o1uwruEuy6Fvrkv6AXBxNRT493fEl4UoPzwsrtxsplLn0YHv?=
 =?us-ascii?Q?mBBApSJfCuMDt43bSi2YfgmjZgx5CFsoYNmOdmj5iW1XkDrihQv8xBquPhyu?=
 =?us-ascii?Q?OAB0LrVyBSWZdDKHpTlZRfvGobaDgUeeiztv2PPFJ2fBOKbwE6Ar5uQwEEvu?=
 =?us-ascii?Q?Rw9nC4fnK70JMoaBUYm85r3PEEFxqb22XGtt5Sm5S4tSWS24JvcabJ1WJI0j?=
 =?us-ascii?Q?im+rJ9ntfsH64ooeoD2bKzpsaUy/kOnMNLjllKjTx0JE39c3z1nJ2T00M6ml?=
 =?us-ascii?Q?jJuhrDuX955doF2bfqALg9PdQfYTHM/KBPA5ZPVYAK8EzCuGHAaz+1T2Eqei?=
 =?us-ascii?Q?t92rH00jEnacRaXwKFU+wA6ioVZbaAV7xw2MCR8h+O/L1okGd3kPSXzQYTY9?=
 =?us-ascii?Q?VaSvN987MOqlSnwqpTaHTn843fr/ZyyH3mkUNZq+mIr1x2Yb7Nn4Wx29UoHQ?=
 =?us-ascii?Q?N1SEKNAgbulygdhlCx8VLF1pRjsT8bXe2r9mrkNpnEwsfTui2Izv38gsag4I?=
 =?us-ascii?Q?pBDoyWmOh7o1BeZ3BXFhE3Gv103RZk/Kgujpkoo/j2iCcyfQt0tPAO2IONo5?=
 =?us-ascii?Q?9KUysa7hDsP+kyoCmSnDqGnT7o9bsrMaWRzybKAZi8hBFdEoFZL5eqnJxe7Q?=
 =?us-ascii?Q?dcD91arsBiUHaLE6JHBoUk6LAvtZm3efL6RNZ72lClhzUyDH5dgqmOzFxUMf?=
 =?us-ascii?Q?btGauKUyHtAtKlYabym1KtbTqMV45K284Ev2HC4jjgrZyFiEjT7e541IVCl3?=
 =?us-ascii?Q?DiuMQhOOyAyeEWr1zH4d7gZoNkFqNUPP8aXFTL10MyqciULZCRAL0mzdMHGP?=
 =?us-ascii?Q?FrHXbp/02oNGy4nROFCgm/uz3HuKu0xRESyb1EHST0hKwHEKgcUGiCACYFp1?=
 =?us-ascii?Q?WAjab3BuLcdhslm6LYZ8RYM2Gqg2r5nnDnvVmqbm53QX6yTfTu70tKls6+es?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nouxlipcycmftKvdS7sz6iypSd/YBn5sRvb+6n8E+Ag3TfFVwpj1F51uES1Jc6Zm8u/tjPMkQbZ9FG3NCIpa0pDtgoGG1bJhGEU4d3rO/4R5kOIEy8pJuXNh4+kdWCTyvU7FSeC/fjLEzfZ+FFf+EPPLBKP7MVHUJgvoDgEHDXeMrRPzGChk46bEk6IgWHIFA2xSLuZFO+SMPgWjmCHKvpq4aWhpOFr6rwiLx/u7DiMiDDB05bxdKVOY0qoUwFM3q5+dvBwFZ2d8xTT6pFkQWxx4BofO6iPmWxsz49lkwVIbFBuF23Wg/9WE4gJzFF1QEA0ILo9ljuHiNE7v4jrloEMrAQ9ptmZIg7H62VI2AZ/wpi8XjbotrZBgT8kspRTDxF5czXI6zmrMivW0VYqKSvvkldk+e+94d5gB7Ab3pIM90kMNzCw9Q7OXXv4yqeKhuSA4hDXMuwV3D8AfMwJ/TTl+AY7pcCHqYdSAJLhkwFlJKKZhDuCyW+X/hcPSyh0C3YEe1Ohx1+WwCppgb7drRq3b8kZPahZgblzZ3RXHBBYPU9X2OfHtICSCB43ol434fMPQZkQ1vyFS/0rF04ETkHRnnDvD5cuHcun/i5dIJeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffc65cf-98c8-4677-beed-08ddc40eeae7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:17:30.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVJMKrx5pR0/fq0rhJqi2Zqe+VIsKGmmPJ7HhPjmUJXJvrtgkwJdzOTpx49r/pZIyzWAt0Zl5r31hTCL5TrpUduJjsk6Y2THPSM/xYSnFH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507160019
X-Proofpoint-ORIG-GUID: AXsq7CwgbZ3Qjx7z0FreBiBYcPUMFM6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAxOSBTYWx0ZWRfX5pSi+FEukNSH qX1o54F6n0kjHflwOCCHMPoBWvIeiKgs4ldGjWU0q2YT8JZF+g0sCLwTzA9bPQDtulnwb0UJYeQ yBxkzvHxyvF8XNgGmUhSFPYs+RrJCOu/J+pRPm9AmvXxxvJrkZRs5C86agkmebCvpTFeJ+uaw/8
 75a4xXXrvE4Vjmz+OsyAEZh/CIMihdlIKXO9nQmRxxSVsmSbI9Yt3QHGgPjYxDUI205qOJezvm8 QZ1x5UFixaAfzMUjcMIOJVp4EMSSGg6u9I1K5pmO5phbNehyCRJVDBsduK32RPOcSQZu8fI0AXK TkzicTJK4M88S8J1O9EhnV6WDqMVSr+Zl5rnK9iY1Bp+lUDTFuHl/0i2U+MeK40bZ435rawm3nO
 vQYRxdavkkoIvB3Mv9K4vShxxVte/IJRCVNpNbKPg2ERWpWNGXTTWyM57wcrjK9GWIs1du8j
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68770bbf cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=m6fPTnW3W1mklNZRDnwA:9
X-Proofpoint-GUID: AXsq7CwgbZ3Qjx7z0FreBiBYcPUMFM6z


Namhyung Kim <namhyung@kernel.org> writes:

> On Wed, Jul 09, 2025 at 05:59:14PM -0700, Ankur Arora wrote:
>> Do type conversion to double at the point of use.
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> A nitpick below.
>
>> ---
>>  tools/perf/bench/mem-functions.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
>> index 8599ed96ee1f..b8f020379197 100644
>> --- a/tools/perf/bench/mem-functions.c
>> +++ b/tools/perf/bench/mem-functions.c
>> @@ -139,7 +139,7 @@ struct bench_mem_info {
>>  	bool alloc_src;
>>  };
>>
>> -static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, double size_total)
>> +static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, size_t size_total)
>>  {
>>  	const struct function *r = &info->functions[r_idx];
>>  	double result_bps = 0.0;
>> @@ -165,18 +165,18 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
>>  	switch (bench_format) {
>>  	case BENCH_FORMAT_DEFAULT:
>>  		if (use_cycles) {
>> -			printf(" %14lf cycles/byte\n", (double)rt.cycles/size_total);
>> +			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)size_total);
>>  		} else {
>> -			result_bps = size_total/timeval2double(&rt.tv);
>> +			result_bps = (double)size_total/timeval2double(&rt.tv);
>>  			print_bps(result_bps);
>>  		}
>>  		break;
>>
>>  	case BENCH_FORMAT_SIMPLE:
>>  		if (use_cycles) {
>> -			printf("%lf\n", (double)rt.cycles/size_total);
>> +			printf("%lf\n", (double)rt.cycles/(double)size_total);
>>  		} else {
>> -			result_bps = size_total/timeval2double(&rt.tv);
>> +			result_bps = (double)size_total/timeval2double(&rt.tv);
>>  			printf("%lf\n", result_bps);
>>  		}
>>  		break;
>> @@ -199,7 +199,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>>  {
>>  	int i;
>>  	size_t size;
>> -	double size_total;
>> +	size_t size_total;
>>
>>  	argc = parse_options(argc, argv, options, info->usage, 0);
>>
>> @@ -212,7 +212,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>>  	}
>>
>>  	size = (size_t)perf_atoll((char *)size_str);
>> -	size_total = (double)size * nr_loops;
>> +	size_total = (size_t)size * nr_loops;
>
> No need to cast.

Ah, yes.

--
ankur

