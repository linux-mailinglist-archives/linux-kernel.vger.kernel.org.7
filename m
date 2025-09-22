Return-Path: <linux-kernel+bounces-827721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF61AB9287E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC563AE2C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CFF3164A9;
	Mon, 22 Sep 2025 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ImdoIhw7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VRxyF7k0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B51A23A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564035; cv=fail; b=BihJ2B3uNU/j2F8rLAiMq7Qe6JsIxpCm0LSaFql3NVpkL3rMDWut/xGUfVwnDqXKaZePssB46Y8sUFg7tJ1vxTbSGUJtH4DO6O6sf6njZjOGK2NEMVQAOtI9H2QNq5ee9hCpet0qQdWkQuerwF8xEnD9G5UugreNNYvZBDqBaS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564035; c=relaxed/simple;
	bh=5Osb+d6oohCD4BDkkeocVpwe8WMZj+Le8hzZz4E2Y7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EQo94mjYBohK3GmHuku9DL0oQKV6Gc3NG2w0uGMm2iulTxh/PmAzxCP3l0nt1kPnPJPj5OGIW5REmZ+LdiV5rX8V6/84rR0BZW/HQwHPSE7+RQgJcY8RNB8BF/Gp3+ZRuSk3UeQGXt58r9LMeOZM1ltpXhvEfyBX8Tto559Pp10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ImdoIhw7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VRxyF7k0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MHNFfl027602;
	Mon, 22 Sep 2025 18:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Dr86CplelbbcY4q8pN
	pOUvRlOKvo90LeQMHkVdZsz1s=; b=ImdoIhw72ZDnIL8F/kdT3Hd09i3TRxiFNa
	s+yyW8VrWIN+LCeQpdx4JhvGR8iWIaVPHmbFV+Ez/hwpT08JeLTlCzwE1hnm1G/D
	JzxjCMe/CijY9/9GiqZ81IFwFxjtgR7CCGqxNOKLCxr19W1QzqB7/Ng8aj99Tq1r
	tjlmviopMxvaBSklB18p1XrNrv5BECLW8zU0gUAyOa14zme9CLXipCwucmxRoZsL
	VHj7pWmcPmI6BiUKyoKYspWCg1cxrnX1CmPYQ/t91xCPGfsKE9Cy8Cxm0sVOc040
	Rb2LnK7WtZP4N6vj8DgFFGW/vrv6XqPazPnOEto6gWyGXVuyHvmw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6au1kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 18:00:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGHrN1028394;
	Mon, 22 Sep 2025 18:00:08 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq7dxae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 18:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRAVzYc3HF4oS+KczpvnKgrjt7nDD+tzAFXKvJ/BAwGKIxeHrh1T6I4LvPdsXkPEIohAz8A5WAuhU7KGxjpglfSCBolgGN8dRTvtlsLQNtL75L0DDE8uDDvfrRo/DbrLTnCLKt5jiLbqdejnM2EOx7gqHGiiwUtBaOZSQj+YtoaV8yFXfdIGLyxNEZe0KzZ/HgVTh7hbvi0A6zz/xLqjmv4gGLO8CLpNk71AnfStDWUs4oZuxwLSVXjluFrCZ7dWDdr/zt31pDkq7XCptEIOPaIIlB2tAE048UDwuhI1T3lDHcb3v8Z32c3TQICj2i0vAnmesOXjXgcgxtFmnCUAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr86CplelbbcY4q8pNpOUvRlOKvo90LeQMHkVdZsz1s=;
 b=HXUWA8G0eeHTspPJuCNVljsViZ+BNg+Y86vmOndC3QGwIZZOX/mzVKUjUc/QaZKWPywW7Zz7ac3VT+53Fpw4BOWn7DXFoUDaK5BYe8x3gEjclgpDQuPHpprctYnD0ofxyG2gtTwKNATaHcbWlUDxj8eFnSmSAF9g8rdRCECUePrnRPa+HpmTUeE73oXig/o5tPy4AHub9p+jtOU3QwKoBeyoxaVym8TjIVpqphMMwLikS3PxCqQmkCEFrD8zUlZ+LOX680ETspqpjleMRNMeuLCcSPpJ4lMWyca2EFRkZF0pxpeEdTzKMzwDQ/wxA8QW9+WO2F4SGqB+tlpOVckJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr86CplelbbcY4q8pNpOUvRlOKvo90LeQMHkVdZsz1s=;
 b=VRxyF7k04riWA9CLEG0Iu78sHrcGvLctnsdAlXoLyi/B2eZkChbGqe2Cew0j7VOGTymPc8zT5qu+Q/JcSXKEFDE+09R6KlA+AgMp83slmDR8l41zsPIRXKWcqSLzysnhuHq4FoHd17VlsEsxpsqFIapKPzviR4B2Z4UFLfT9sm0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 18:00:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.017; Mon, 22 Sep 2025
 18:00:03 +0000
Date: Tue, 23 Sep 2025 02:59:56 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev,
        syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] mm/slab: Add size validation in kmalloc_array_*
 functions
Message-ID: <aNGOnDb0WsIbk2zx@hyeyoo>
References: <20250922170357.148588-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922170357.148588-1-viswanathiyyappan@gmail.com>
X-ClientProxiedBy: SL2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::34) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c42254c-920a-4602-9aae-08ddfa01db03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6k9WT1wjQ6eJA+oqEKNpbrxhWDqYJx5Xa/Wl54zhxFoFk6YnWMbaxu48ww3H?=
 =?us-ascii?Q?AN0bzUMZ73LtxZXS6KvuVdzIKtOh7cZgUujnaahWbfK+djT0hYXQoWmAF0hX?=
 =?us-ascii?Q?wfJbQcz2CcYOJm2QLYYO8rap/KjDZrl26V4RyUKS+2yJTpFynMiaKV6ii35J?=
 =?us-ascii?Q?ULNG8g8Kb8/s2w0U1hEtdrUQvoncnTepXh7Gsbo1w2LPE5JLXU+Jpu30/k3m?=
 =?us-ascii?Q?XZqQVJSCMaDLs3EAA9cVADsYBAKJUKChBZC/+bm5ew9mFjzJHLWApttfYQSs?=
 =?us-ascii?Q?hF+FqKvdtbvdpDvBYVGKfLwSCjaK4S+yiM3En/i+WQGPzv6To3EZDMhMA9v/?=
 =?us-ascii?Q?3uWpsWS3P3mVVk4VUn0dfc4DO2gfOZrEp7prKrIQJxL6Wxm+tm9BwLZKlO2P?=
 =?us-ascii?Q?15QNigW7HhQR4d97X9p8lFVW6iq4NgpnFiKv3V2q2Sx5MyAPTRJA9QSh6QyY?=
 =?us-ascii?Q?fNzHF8W0MNtqQX8Lk2SY8PYZ6WvcHlC1DgsLc5sA87elAcy8KOeNHyYB3f8E?=
 =?us-ascii?Q?d6KOY5TKfvQvNTpnVZ9Ygz0jVXqv98j8e8XAz0t5yrO4PqaPTF/vLCc4qrq2?=
 =?us-ascii?Q?QjmjklTE77+5R8uFemihJY1hLrd5mr8scMZIz5iBJaZ6gphWpPLStxm8UwYg?=
 =?us-ascii?Q?vPckJbe7F2W09STmFmXMJ4AvHEnvK8fKpgGwh2Q1SHZx3iyh7O0pqiI+oD/H?=
 =?us-ascii?Q?aYFk7TCW68FQjPfr+HhfnsMxVhkMXM/XHy9ZVIQI7Puhhmdq6OEnfm/MOuFB?=
 =?us-ascii?Q?h7d27tMwcLpeikWKiMvoyuIDnP/5ksLpw5rh4ii0C06luW3bCpImhChtyzdw?=
 =?us-ascii?Q?7f+SiAku5Dok2d0rOOdmZVDXcJkNtVtFCJad1i5Cxa+4JGB+bYpolxAepkRN?=
 =?us-ascii?Q?pnG8rda4momA7bkVJq+dQQGpPtCbn+Uaw592HyVr6YHMrZOj/aWkinEh3B78?=
 =?us-ascii?Q?2ZMVFQHRlduDTIhFv19s0FeGJmYsW8BV3e69ddrXeiS1iGC9ouTtbvBHjDbP?=
 =?us-ascii?Q?W4U2DUjVTjPqDLQWIl7EGM8g3NwC2ol/CEhXXbVJCEXQA52t7S0CxHsfH5iO?=
 =?us-ascii?Q?WdB3+4kdtXRwuLSXiWmbXrJi9hSIfDcDWgEEb07fDxJWhdGjnCiwi5qIkwyB?=
 =?us-ascii?Q?ZJ/2b/4E+fvOe1LrdoPNn0lxtw37KlnQbMhQ6+OQW+W39fHRyo8Ou19ix9E4?=
 =?us-ascii?Q?yWUYJViMO49TQEQ7bzObt6dNe8/8ji/Nlr2dLpJzhDKxUbMK7DEuRD4qYcXA?=
 =?us-ascii?Q?RmDfEA+wZuIxy3QKSMWMZAezcwfwH6jLVW9ivxM1nTdZkabv6LJH2zsgPq9U?=
 =?us-ascii?Q?CoESdUvFLUFagbeM4AnXX3XJWOeXlk5CmNYvvFhcs//Q6TgxxH8T48WfinMw?=
 =?us-ascii?Q?7+Zmf9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smmxW3mVn48W+mKx9Uw12N7zTkBJc/4pvwH6higiUS3P59OpzKVmq+We1AKt?=
 =?us-ascii?Q?K0LK+9pQ5VbvTkgx5uVtBESFzKzRmr2eXGzAcBGR42uKjZxC3g2kTX+cmRLr?=
 =?us-ascii?Q?dg0pxf4BBj5n2QlqAcxzRhkpNJXTnylKMnndgetxk/ItGNP7Q/J5K5yswp9k?=
 =?us-ascii?Q?SxtEeakKmurg7rfiPzw+bauB0oDRKBfsdBUrCVi2AFAqIjX+j4y63davBkqo?=
 =?us-ascii?Q?sLQHr6H87VyZmuHtSQVbOurbL7GpYwdEq1rE2RFq0n4I3Nc1RIWXm/H/hCvO?=
 =?us-ascii?Q?OJpTuCHB6w65fZHKkDZVwl2bPO0hKRDpEIe3d+F5srcwdfRWwBO4AwE8mNb/?=
 =?us-ascii?Q?wKrRiifgscrabzSg7RWRGcC5+gmSI6zO1VbPQHQ+2dE0XF7rs/OJkB+H0DSG?=
 =?us-ascii?Q?59nbWqY6KKrU6FAXv01crKXb4wjSoDcax2fMzrttKZdDPPgeq78nuGBsLVPl?=
 =?us-ascii?Q?8UsbB2dgrQfA3ovU6mtwC2UC0o0v9HUS9WYWv5zo/XGtgrifVWCqAmdAw6rV?=
 =?us-ascii?Q?10jzhnr9vdLZbLsQi2FxbbBPaw9w5vcgsq/aep8U4mlo8zwnfbAJpe6WK/x/?=
 =?us-ascii?Q?zqlDbf0oXoYd1NvRlksZJxqzyCNExXxENn9Td28KTapLFpm9rh68ZvU10xDT?=
 =?us-ascii?Q?j3f0dyPEiZ4Y0SZV+PEg+pi+f+rFHhS8Qek3Qa751ri4hEu5sIZw8I75Dlhm?=
 =?us-ascii?Q?qImv3V1F8F+Qg+u9LHF4gNjU9GV9UjGqCbbVjVEEUyH7UHq+Hbdi2L99ERRT?=
 =?us-ascii?Q?QPQKF/UnlNDHnZ4oS6fB11D0TQgHmSTMy1jPxzjZpkNDuKKAO4EtclT/AdGw?=
 =?us-ascii?Q?edGhDhP1c7SnetBgTsfNCX7W1rLfZJ4NMp7P8gog9uXbvmQ12a8+11pzJcx5?=
 =?us-ascii?Q?70XJJBj6/ZyuFekuHk71+CPAoNzsxqQIZF9q45KvWkWC++g/BLFwLdry2elD?=
 =?us-ascii?Q?YtvLSpSOdaSA7qktWVSfJK+9WuJ7TTmyaIJNpyzwcziYF6qtMHo0yR9f/BHP?=
 =?us-ascii?Q?BEodECH4ExAO2OF/dOEXhHkQhN/SrvhpSMFPlLJBEbKsxMw+dYuM0LJ0pbb9?=
 =?us-ascii?Q?H3J/Wodiu6w9f09/dYRTIrtHn+zm2s8gZsHaY0TGcBUuc74gWWMG+tjes1vM?=
 =?us-ascii?Q?meIcgzubnVrmoNIF10HF+pBzFg5qhvN2iJ3uu1TGJMwhJiPllpx7rNj+Q59d?=
 =?us-ascii?Q?6elId0FWZtcwPFuyexa7z6fjViJXtxUrSXgQw3aj9uO50X2q69/EyBZLlU6o?=
 =?us-ascii?Q?v25EAQAQ5dmfwHmsvBoMWYheVo+5aU2k4hN9lURrX4s19NB6RtITUrUD/575?=
 =?us-ascii?Q?Qo4j5MN6iggtmk8MRiZzUWVjULBX6xNK1/QLt+Pl9l1gPJ8h0mVKc9hfa2YE?=
 =?us-ascii?Q?FjO64uW6L9Nc+zu8xY+jnQtP0ZQnlI5H7fArM+X6nsifZVYKDe2ZIXl9CLY3?=
 =?us-ascii?Q?dXMCVj3caHjcFg6vQa5i4T54XBT/YNXR+v+bKLDh9hF4ZAk24Qvzs77u/F+5?=
 =?us-ascii?Q?nq7G2RthxEDyFG+ZMeWPsoYtWuvHFxUTg/VvLO+kdpNvjrZfwc8jrMRdT8wR?=
 =?us-ascii?Q?7YhI4ZFIvdGTA8ofWu9Ktd7GDCYiUxuTzAEb/1VX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XBuxc8Prw/qgTLDis00Bsr6w3XCU8e7Svbv6SnIEmmz8DhD6iTfMzW5VfuQbl1sj7a1rHb+5YbplxC+FRBumco8ZRWBVV7IVCUEc+VAEdDTH8lbsAWQnUcCcPaXSoPUkf0Pw91KYkE8+OtB25spmypk6KxOl10ExUmRYhrbUlPqlyWSmhWqHyMjRFvtgLL9N3NOEUiGwmNWcKqSqDAN2frKhYTccN2i9wg/zFBGISIN4FAVMCKdVQtyNSVtuzQOJ/79PfFBkFlTT/Oo3wl+iVALEW5d3zmbbg82UlDyP0SdAOtrYtQfwyOpInxIlgPxhaVkoyuM14Xjd0aj2yc1siffKd4tpBi4qvIW33EGO2loKgAR4R7VOZ2BtYskZQl6ewBb15g3G+JeuDY8anaOj1CnhNtgJhrG6mVPcQf/DOqa4yLvbvql7wRNM78LvHT7wXmrZ9EjnNysaxAYcPOHHjldfVFkFBUrSIBgj0WdTyFeUqOkOGejDJ25R3XxwlLt/bzKCChoSXVma6Cr3IWLHWIl1uB85LrBoCxMaiNGnCj9hYBYZcGhL6PL+Tke1JzzcJzM38pOYNLJTfDTa9ijSC0nwGxzhd7XNgfWx4NOPZW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c42254c-920a-4602-9aae-08ddfa01db03
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 18:00:03.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaifY0J9igXPXqmK0Mz1Q+DEqoOeOMqLExZVzD6T7wTBYmVZfNOmRXLKUSkBspX+b/d6Uwb54pKYpJCM7I85Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfX+vLjq87hMYsV
 n8WHKpf8ZLez/2KAHrtj3eJG3wKMyied1NJDRILzv6/o2hq/nQhhNGmb/8B7b+hTAvz1FwBo7Dp
 KqVdGlEFHIpFPpNHN/yvEEXLvYANvO5LU0GNJXS847NBhQw0k/I522JeuU2jQCttJ7/Jhu3n9kT
 p8HipoQ14Q7WezcY4vfEBJcSq48J0KRv5EuslTXWdEWjU3Nhi0naYLyxD4fnpigbtKVWBrYRz1V
 ySf+kqs/k+X/4bXujHZ2gA8+qAXpBA0vpWI5ykSsy1mRd7jApdrv3AQVha3XGBcc/Y2t+VVHxqZ
 RNMZCYIvyVHzYnlojzLFkVKy2EoKyZTS4OJJOLP6o+H7NQ63/SWoVIoDDxICDwOblm0nuKgh+X+
 yfb5R4tg
X-Proofpoint-GUID: 5oN4qcdk0rmR-KiMS2gj92P9ohUePXdg
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d18ea9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=pGLkceISAAAA:8 a=u3X9V1jny4mBdW1uAzIA:9 a=CjuIK1q_8ugA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: 5oN4qcdk0rmR-KiMS2gj92P9ohUePXdg

Hi I, thanks for looking into the syzbot report.

On Mon, Sep 22, 2025 at 10:33:57PM +0530, I Viswanath wrote:
> syzbot reported WARNING in max_vclocks_store.
> 
> This occurs when the size argument fits into a u32 but is too large 
> to allocate, i.e., when it's between KMALLOC_MAX_SIZE + 1 
> and UINT_MAX (both limits included)

This is not quite.

When bytes > KKMALLOC_MAX_SIZE (8K on my system), kmalloc redirects allocation
to the buddy allocator, which can allocate up to (PAGE_SIZE << MAX_PAGE_ORDER)
bytes (4M on my system).

Because allocating a page with order > MAX_PAGE_ORDER page is never
supposed to succeed, the caller of kmalloc should be fixed rather than
kmalloc itself.

> Add validation to kmalloc_array_noprof() and related functions to 
> return early if the requested size exceeds KMALLOC_MAX_SIZE.

This is against the point of WARNING in the buddy allocator.

I think the right fix should be to return -EINVAL in max_vclocks_store()
if max * sizeof(int) exceeds PAGE_SIZE << MAX_PAGE_ORDER?

-- 
Cheers,
Harry / Hyeonggon

> This seems like the most reasonable place for this guard.
> 
> Would it be a good idea to move the check down to 
> the lower level functions like __kmalloc_node_noprof()?
> 
> Moving it up is not a good idea because
> max_vclocks_store shouldn't reason around KMALLOC_MAX_SIZE, 
> a mm specific macro.
> 
> Should the Fixes: commit here be the one in which this file 
> was added?
> 
> Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
> Tested-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
>  include/linux/slab.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d5a8ab98035c..6db15c5b2ce7 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -943,7 +943,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
>  {
>  	size_t bytes;
>  
> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> +	if (unlikely(check_mul_overflow(n, size, &bytes) || (bytes > KMALLOC_MAX_SIZE)))
>  		return NULL;
>  	return kmalloc_noprof(bytes, flags);
>  }
> @@ -973,7 +973,7 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(voi
>  {
>  	size_t bytes;
>  
> -	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
> +	if (unlikely(check_mul_overflow(new_n, new_size, &bytes) || (bytes > KMALLOC_MAX_SIZE)))
>  		return NULL;
>  
>  	return krealloc_noprof(p, bytes, flags);
> @@ -1013,7 +1013,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
>  {
>  	size_t bytes;
>  
> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> +	if (unlikely(check_mul_overflow(n, size, &bytes) || (bytes > KMALLOC_MAX_SIZE)))
>  		return NULL;
>  	if (__builtin_constant_p(n) && __builtin_constant_p(size))
>  		return kmalloc_node_noprof(bytes, flags, node);
> @@ -1059,7 +1059,7 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
>  {
>  	size_t bytes;
>  
> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> +	if (unlikely(check_mul_overflow(n, size, &bytes) || (bytes > KMALLOC_MAX_SIZE)))
>  		return NULL;
>  
>  	return kvmalloc_node_noprof(bytes, flags, node);
> -- 
> 2.47.3
> 

