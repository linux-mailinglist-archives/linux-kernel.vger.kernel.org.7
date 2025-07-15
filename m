Return-Path: <linux-kernel+bounces-731941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE95B05D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11987AAB36
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F002E92C2;
	Tue, 15 Jul 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c3Uihm85";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n/1fSsPg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366722E5B39
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586690; cv=fail; b=oOdhtjFadscek6kGHom/xMn6yfgXgl5pILNsQja3kV2SzlzDOgPVUHmLkvr8wjZEKps8o6HSHZH9vnHoqK8b8Wc4BqFwhQLAOJrBDiRMrrlbrZXm6PaXGYPlhHojYoL62FJO9anv1S+oAxHhlLWohEKZTs26Rv/eirXAWbtc0wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586690; c=relaxed/simple;
	bh=u15eClY+AxcXKz0niGKsUg8tBDEo+J4d1XXAJYcjyLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AnXpK+4LRAChowOHPrN4ma14WP/6YandSjH4HQAaRpGHigkVy4dmwd4I6i63F4+s18I73zhiuL4XF+aPISzUqURXVImnxkftpkUxvFH6soow/Ls70FMns7rqnQlgyYM7LdHee2pN/yO/sUtcEPxF5MivlIejKZ2Yf41zTWYP7XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c3Uihm85; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n/1fSsPg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZD0W017571;
	Tue, 15 Jul 2025 13:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VXLN4QrVvjnYUWnzPsQVjSdLipbprY0d2rBRLecVpIQ=; b=
	c3Uihm85P41i8fhgeKCgN4Hmu9rrtOIxFsyGxi18itbJ7taAa06wsz052SlQUq3G
	7ZbZ2VV7yl+XQDhIxuZL169XwcQB4jftJnJfLBR1X8mYd79Cw9MvQLavwTMFdrtT
	t4vDYkceMTzuQZrDHKcPQM8a5w8NwJAGZsobIzLDy0Jr2Ks8lK7AC2MXuR2I94Jq
	ISEs8G5d0t72CehfVEg0OEP1K3JaU1BElQYq7Bq8fXaUml7tMdDVQ8J1vqgEM31W
	L0wH5gfYgkHg+Uc/T+GAszHW4bBpdESP3zbvCrKy+7GLeG4seMif55XQJWvV+KtC
	uC8R6MzZJWYMHb58Tm4Ojg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66xdq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FClimN011819;
	Tue, 15 Jul 2025 13:37:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59yt85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8ZpjOEyspFTkVGwGQq2SH3TRrS7HQ5EV2WudjRpjq84hRqL14Pt6XUgnhn3o+B27uJ94P5Xfj8NdRZ0ZTpEHnnPRqqazJT8QIJ3uEGmtljR4E2xualc7y/LNHIgDQWRQxycoNMn0UoFKcWaT99FtrmrWinihhG0DAuX43gL/P7lFt0I1okJ8A7E47PV42DRyyf2+FdVtuz4P6BBHlroRRpDJuQGmohn7RyDHFpRS+FglLnED2R5Ff5eb7tM9nyckqUVLGwvJNwtBSc7DFSbetkAv2eyi/0RgXL1KLOT3iQwHd/wGbOk4UV5j0H1f5fZYUx22tTkTEybuecfXiIJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXLN4QrVvjnYUWnzPsQVjSdLipbprY0d2rBRLecVpIQ=;
 b=AufpfkDvck9opc4l12t4M21sJPb+iEUGKrgVzwuy1EWuOgV+viB/ALzn3e6aPcxovbA0pVJYpb+QX7KUiVbZaGeQc0/z7eCt0QUESlHrFYCr0Pe0enY+rtCRmULrpArzobA3n6+Go4B+xCBNPjNYS5kRJHt8w/Q65Ysv6DEnRwbvu7swMfPBRKr9ko+bj5rSOCRAa1SONYs33Hn2RtCJ5pqVBdbcOaTGSbVReqM9J8U0OZyWJCHrP+u+4keB3L3Rr4gltxUCdtfi2sfbtYQPi8JRX+cxOb6kUPp/ZlbZp1Zn1qyAo/oU6Oa6Dk3UCCmSMMF/kkfblRDID8DV37B0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXLN4QrVvjnYUWnzPsQVjSdLipbprY0d2rBRLecVpIQ=;
 b=n/1fSsPgGeeRyB4U7eTWRAm3Xf8q6zTiXdRm1Fgb2/7+n6JBqjckyhUjp+suQlUJXhYvOuT3sQmMctCYMZ9vdOOgcS3pXZs6GT3Mai6bEjLDCAWqnl2cITYDnD7eE4SUEYHC+rPwh0fW0y3Dh220l1+/gVtbbtg7eUBbrEW6r8s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 13:37:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 13:37:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 1/5] mm/mseal: always define VM_SEALED
Date: Tue, 15 Jul 2025 14:37:38 +0100
Message-ID: <48376d052928a56b6e66a5add238dcfa1fe91886.1752586090.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: bb66bc41-9b0a-46ff-d37e-08ddc3a4caf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2K9joaicvdQvE5aYEZIHUQHMWt+yTDb0TeHonzoYOJrYl4oYk7VmGMD3fbsz?=
 =?us-ascii?Q?1y8o6N01r0bSa937+BLlidWZHPFVA0F2OXq724IVd9E+mWzVBhoq79EJ2SqV?=
 =?us-ascii?Q?/KtE77nbyY5MH89JSmBrW6bXKjdpJ0FqTi7Nj5p/0fYIjf6DHjzBE+mtpn9K?=
 =?us-ascii?Q?UUIdj4wGsN1VO19Qi6B/PZHbVJSNYVGNRzF3e3q6nHhEpJkkgcKRMiX0C1B9?=
 =?us-ascii?Q?Hp+JMGdesK0flm9I/vbc0WM2gKdu4gPnGlbtpHrrBf3hMnfZ25nI5WS3SN++?=
 =?us-ascii?Q?deX/j+rbaICSXYT/9P6KkVFsnmHHoM1zUnkQeaELUa0bw9166yaajD9bD2UR?=
 =?us-ascii?Q?Dh3HQn5pH0tTtU5jlw8Z9pVqZzhOHUobzRxmJ8iy2V+mpDGhrGI+Iii9iczL?=
 =?us-ascii?Q?2gUzNZZGbcWgVT1RTwmRxgK4VqOuYg40OhkWVR7wcMbnuyhjRlX2et7T+Mrl?=
 =?us-ascii?Q?wn/j2aLfbWUaCQ1Gkd9nMrKxx6uaJaWwF2/TfkB1bMkQfGqJ5EvHPTOoseRc?=
 =?us-ascii?Q?IVT8DsMd5ychCgdjsH9ogbUnK8SNBD5akkaOHwq3j80YtGq1G8lJml7wFtOX?=
 =?us-ascii?Q?nalBCGjrzv/CnG+nW8bpMZ98AogZbcAqXk3M5nfuVgYJpZ2Yslj73PHX+OIx?=
 =?us-ascii?Q?pHK3qVn2zT/gbfBVC+H9utEmagYinwwnikRGO0n3vkM6ULcwqTzU7zu4x2XX?=
 =?us-ascii?Q?jliXqXoDxt8Ibbt3fyTte4uXGTLdJoCDX/2IcAaGD6QZWUWqziAB2Y3hzh0e?=
 =?us-ascii?Q?w9b1Q02Ys17MSQ8TDV3gSvpPrxG5MRazE3W1N8o8XcPdO2m5klhRoKN3lb2x?=
 =?us-ascii?Q?IRgR8U2O2ouRfAzeHJ44hf0jMadbVP1ScpYoP9rCh9+5tEuBtm/HfwV0uutZ?=
 =?us-ascii?Q?w/gK75ltX2uXyjxlw38c+bXc85z0k7FEOgP2KK7WlUgSPjOV+eflJwehQMUE?=
 =?us-ascii?Q?WqMuXeWcFfZ9BMdYr7sioMaCDeXjtX0A0jYU87ASKK6W2Z9wdNZXLTzAkG0F?=
 =?us-ascii?Q?usoWzElj8bnq+OrOczuBiHbug52EBChj3SFvjyhKdkEfNC2NjdkCx20u1l23?=
 =?us-ascii?Q?sLdNapncOhoKcuHAKH5jiM+KeQ1zj5gshq5BCF7y5MgUXfEAtidKabMI4v+r?=
 =?us-ascii?Q?7QWjz7ZfNo7q/Pz0JTWyyJagLk7kDpxxyWjXwgztKXEE5S9iIjpkZMamRX0x?=
 =?us-ascii?Q?nkKEqc3rxxiZR8DWmnFQco56ihJXfyNBogWtEq32HDqvfZAu8wbJqTtnyX4p?=
 =?us-ascii?Q?qIIDKaIDynhplmSSNjf4TJWFLlCH+X+TrXuTA7aAwXFa2Fh/GQfUet73syZq?=
 =?us-ascii?Q?te+zvXlWRx8iD7deKzW3s7Td3mHGGGv2RkhHXQm36y0J1lGDJYWA3jN8vRAu?=
 =?us-ascii?Q?OeeSUoHr5uLrpSOx4i6XKoRlych4VLb+XneLLmKg2Ie5JDmU6Cv2C6jrWEoX?=
 =?us-ascii?Q?aVqU4QgD9Qk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ltrKZ1p50RGSyemjRgzd+c80eiSvwKp97mfP/elq5lIuEKB10p4IWN/zsBsz?=
 =?us-ascii?Q?SuthlP857P0d1Hsj8UvGDqb/loK8m1l2OTuIjqBRfxiE7qTPBhxuE4RiI1Sr?=
 =?us-ascii?Q?iOoaq//Bd/miM9VpI2DJBAfEfKcidrT+0ZGrgo4C4cLZ7zkCqzu5lmQXk4zN?=
 =?us-ascii?Q?csmBphiVLUC0lJUQvZ6WyGVhm6olk+CeCPwWcRrjY/F+e8Jc+s0tA1tp8bV7?=
 =?us-ascii?Q?Gq9V3y7NYhyIVOWpkl7uQVxnSjDQsjdstCpof4yQ1w8df+GOPQDW2LOeGspJ?=
 =?us-ascii?Q?d9Frjkzj61cQX28gYciM6mo3K1tT4W7nn84aXGI3MNXmJmT5WemWHzhYCIVI?=
 =?us-ascii?Q?ywoovQXdTvAwqLlaDHnJy4XlQg9B5SQnZLGN8ocwekBfkjyIdMQvo7hZXtxb?=
 =?us-ascii?Q?LCU6ZnRlA4yH+WxCCcFA54Jg999ubZj1EJq4xNZB9ilPuaa2kqQo+7/Qz3oJ?=
 =?us-ascii?Q?udhRcvDqK0iJbpMkfceaCpE8DcSeRsz7vMunbl2hhwa1/zj7S/VgNxYRxJb+?=
 =?us-ascii?Q?l9HM/W55XLsqfm+nA5fuZK9OcuY0b5LyjUZX9kY6Uw3+AKQ1uU0V96gqz5Ud?=
 =?us-ascii?Q?m6SfRFG7CEoUYIzMV3G7CXF7xGZ/VuTAJCNOMSXxPVSbAZsuONbioyyZPAS3?=
 =?us-ascii?Q?UOrnOChdKiKWo4m3kHdpYXt6UVNG6UhYNaBWrkrGby3cNuQt0cCjMxL+6iWX?=
 =?us-ascii?Q?nrEEKidPhcWHGgKjI1Y3AtmlCPEau409jN4u5DsLKfHsxq7nSU+wHA/4X7Bb?=
 =?us-ascii?Q?nBKp5VQ4H9oSxBfx4EQ1Se/Ej1xi1dEivu7IBT9PArtkY5HycfyQZDjgjvCi?=
 =?us-ascii?Q?UaLQdhFQ5hybk9emRt0t209nzHxsy+bZ++RxkYVDhN1fD/9da7MLaGe8ZE3y?=
 =?us-ascii?Q?ToASwIjySNBz4g3uhA5rmMn4dT/u2GBH/Cfxi98L1MLtX1YnuTcDAQEptoL3?=
 =?us-ascii?Q?Q8C3KlPO0EZFgKC8LuthbDK1mqusPDQFy/flCtxasx4VgqtGSd2pVTg+OF1g?=
 =?us-ascii?Q?b6o2WC+uADtWFAJHe/ZIWYL2mMpMWLPfDqM1SInDtbIRZuHHpgrZT5qdKNS2?=
 =?us-ascii?Q?qNUQ/+PgOdIXnYoW425HKJ/J2IKJB36Xb048obxOzlt+lgQ1rkpmr22MJuy+?=
 =?us-ascii?Q?V2UvDsdSUPbcVGc0e2rHzLcP/XPY8XV0SfxzY6nDvWD9lEEj3CHGJ75kA3DS?=
 =?us-ascii?Q?WzJF4cpfpPi7TVS/I32s3FrYsPuwwhvWPOctchZ3/hXUUPx7sDYWhTx2yojT?=
 =?us-ascii?Q?eOMSkZIiNQo9eljO3dEQr2OA6sM0pBW7d1p9y5S7F8B+uXFOf/B+6fhDAnEl?=
 =?us-ascii?Q?NKGr7M90+9Gc4UXRe5cisBg4Y7rFJ5nBRE6xv9yXSYjpdW6l712SGwEnCAOH?=
 =?us-ascii?Q?rOpc4VCKiUt/py6JX9sF94loaz2iUiuKsVEvKOvDJYr7DMc9zr7Ez7MGHtvq?=
 =?us-ascii?Q?PUFznpYgADfytQ9DRVdFXZZ+x0S/9Dre950dH3a8Mx/YFOYcjuTmwlE+zK+t?=
 =?us-ascii?Q?GrvXNBn7oKsphcklj2ilKJ5My4kB3ACACbMHTcngOiFsTkT1Y4XHVc1xQnZ9?=
 =?us-ascii?Q?jvfkMydLjHUs/qj014MMA7rhUnLFYBeaca8z8F8LOV0Jn7hE38Itc3jbpCmz?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t+bgTQmZucVWUgSHDQDiLUboPoVa60y4pyYg56kN1Ma/HqH4CO5+Osj1IP6Tu4SIIyKkrOZUi2mId1RvLapwRCRRKlzevY3m+Eb9PpDmfcXi6dPY79leT1STCON7DndWCC/gjPtOvZ6+raL+t9XFPZX0OWQhTaesMOzY2eyryOM+nIEZaa9RlUYrM/F1wQ/ANtJZcu2KvHwA+AvigJf3cLJvf0W7qtDkimwak9bA1G4dsDza4rwXPluYmBwnhkgY4S5Q6xRj7FJAhaNX5PiJ3DDBjXdyoXGLOBTELLG2Q+ZFR9HuiidXg81d6YkIxB5guNBWrhehvrZq4TG9LbWvTdA7pPNTKvUzViG60SLkld5RgMvAPQYRwxdhm9zwWm7aoUAdkC9WwRfHNru6JdK2PcibodHbv4BVzxkZh1UkVzg/2eqE/iklukzyy2U90NOvRBRC2lL4OFlV+Az5Cu11yqSGYWqJRp3O0AarHS+aJ0RwJISF02YZ0DeGvQTs7rkFdm5+gyIS1emiWyuPinLTWmgvLzLJCetZlZ80O9AG0m7W2j26wZAItD/OHTPsQHr9fZH+mACOytLSkimVyzjMDwMaNSqNcI2QahC0nSwdD5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb66bc41-9b0a-46ff-d37e-08ddc3a4caf8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:37:50.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLK9kvt1I/X+YP8W2FIdXGlstK0t/nsk+FukXn1IRXtRdU0Bnw4Q4EpwJ4eKz+xD0siVzjVyjXX8VTAzxSAvggUJe9MknxyW3zfYDpZ92OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150124
X-Proofpoint-ORIG-GUID: PGS46NQV4W7iqn6RLSdCf74SbA_DtEWi
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687659b3 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=gxeMIzJwE0WXKCnSo1kA:9 cc=ntf awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyNSBTYWx0ZWRfX5pApVdbBEdzA mYrmy4WaXBlMIU/MTwYzxEDTHwyhbi1oahbbdbcPMnb/5DITdir7ZN3MgMTg5IxqFBmCOqmxphE oJE51L5i5ZVso7vxwPMXhVCkvrQPWay0UNm/Vg0pvLYqYJvlysNE2/chWZOxfoQ1zr0CDfOXL5S
 OVSA8IMwf9axbpOopCtR5M7x3W2Mv2kibFpGyH28Dy2Ay87F8DBGL4tjqk09jK9KJQRg0835pju aFqYs2dQmRbCbhNk2+iuD3rTq0PWI7TrzDyeCCYp1CV9H55iZoAIx5or6kzEJQxmBU5Xn/8GG0u 2h/2blwKlDf1ZY3reSFjjlrjebKZdxuVy9uude2fBNBYs567jyFX59nupMB2xYL7KbTBZhx74G3
 Jxt7RzTG3hWZHGDnx+flU65MhGDmNWmlrSFJ7ySm31LgKKO4qIlWUacunC4zrPhSnqAVS660
X-Proofpoint-GUID: PGS46NQV4W7iqn6RLSdCf74SbA_DtEWi

There is no reason to treat VM_SEALED in a special way, in each other case
in which a VMA flag is unavailable due to configuration, we simply assign
that flag to VM_NONE, so make VM_SEALED consistent with all other VMA flags
in this respect.

Additionally, use the next available bit for VM_SEALED, 42, rather than
arbitrarily putting it at 63 and update the declaration to match all other
VMA flags.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h               | 6 ++++--
 tools/testing/vma/vma_internal.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2e5459d43267..aba67c3df42b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -414,8 +414,10 @@ extern unsigned int kobjsize(const void *objp);
 #endif

 #ifdef CONFIG_64BIT
-/* VM is sealed, in vm_flags */
-#define VM_SEALED	_BITUL(63)
+#define VM_SEALED_BIT	42
+#define VM_SEALED	BIT(VM_SEALED_BIT)
+#else
+#define VM_SEALED	VM_NONE
 #endif

 /* Bits set in the VMA until the stack is in its final location */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 991022e9e0d3..0fe52fd6782b 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -108,8 +108,10 @@ extern unsigned long dac_mmap_min_addr;
 #define CAP_IPC_LOCK         14

 #ifdef CONFIG_64BIT
-/* VM is sealed, in vm_flags */
-#define VM_SEALED	_BITUL(63)
+#define VM_SEALED_BIT	42
+#define VM_SEALED	BIT(VM_SEALED_BIT)
+#else
+#define VM_SEALED	VM_NONE
 #endif

 #define FIRST_USER_ADDRESS	0UL
--
2.50.1

