Return-Path: <linux-kernel+bounces-765937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC61B24044
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ECD2A4182
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D462BE7D6;
	Wed, 13 Aug 2025 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nu7+Lplv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jd2rU580"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C3285047
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063400; cv=fail; b=GNTXBDVwY4XB6pceJwEDWWNMMYKuWYK6nw8R+26OhGqRyX+qG8396Pac8TVr5Pt9x3pBH0AQBH9vgNua3dSfQ28TT4cDvc7wENtTJoHHU3Br0d0WfQSR6W1DQoQzA0KFNtSzFHZ17SDz+nsuwbOE1PokjT0xLDXzWiu7lmKJHCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063400; c=relaxed/simple;
	bh=KeJyoJEyEZCRfokxEl7LrpVo2nvC3KJb+zRCU/s+8KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JBjXz9YRw9oWz9P6g9/dZ1y05PYsvD9CuzNgdWkiK2d8U+2YuqeIl4PJg/jaP9Gx77WuhsrGDRokDXuo8p6ViDAPcaFnpXVSE3KcWLT86mKQRTxXp8dd4iZRhy0fT+bRzLeL310tK6r8e5VlYdsmKiH/ozgAEhHG76/ndbsmswY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nu7+Lplv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jd2rU580; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLQrAX010614;
	Wed, 13 Aug 2025 05:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FybuTlb2d5hxFIVLpY
	qAfCAyzLouIGpSCWTjZNyfcT4=; b=Nu7+LplvQ8c7QDsFCjefZc1UYAXD84HMOo
	f4yRnLmb3NdgMN+bBJ7/jEogGZ7jOx+qjoWUxFeNkYBN0YCyzt0eGNadPp8t3KkZ
	HCRh4P8pklw3VWdlKcQD40m4QE6soM3zrl91HtkIx2dYuBH0eENTkWJNGGYCYVM+
	qLz44icPsnpVhng4m+OV/qPb589pzYfQIE2VdQPfU9LKE1tS1DAYoGINWGKN+ADs
	+T+S6XHxqV280AQXlnsB4BZOHLAJiOkj0ufwyYxRmpROjXuBlsJVofiIQGygSFeS
	uuseJ0Wzt0iwFQ75ujJvXTuJ6+C80o6A6/G+HBM0fFb/LujGF5RQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dpbfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:36:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D2qfoL006332;
	Wed, 13 Aug 2025 05:36:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsaq5x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbQcoWj+2IzL9bVdgv/dTfFrIZSxme8yEE4Rtpkt29XLFFLVS4S5Q5/ylRXg45gf09RBYSnlwc2AysuZ027ly3Tqp9idQ+kpT5TIacrmayVTQ09TzeShKxLIT70i14c+YLiEaM0wrI3jOTupnbF16R/s+pNGKQbH3CrPalah4d5J+cod6KgpdGFI19SgHRz90xfwughuOENGaWSHg9hY+XdbPzG0sHL5qp168NDppCZOyaqwI+6LBH2pAlQd17wvljW0eFaOKXJ1IgoFAW7xYlV+IFbDk05Ar0VVrf9e+EsOP9XxRGwZEP8IDINSeL7pz2Ja4bRrMU7sfoe3C1p07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FybuTlb2d5hxFIVLpYqAfCAyzLouIGpSCWTjZNyfcT4=;
 b=AzWIYbTZzbgdC3fEHbutol9YLzuMDQAPckBHaWBPBuiefF2XKp8lDzGN0qt40HtzclVbJXpLAQ4Pt0yjUOjelTPGQnSouMApo2pdH/AaTJzpIfpwFswI8+kVTYkjGrv80x/CVz/PmR7/YCR+qg7eX7DBms17XjSpXopVg1U0Bz77B05TOdS1hRjjAZCGsH8P8px+bSfUkrmkb3eZRQKewiKjVHjcgKBcafdgWofJJKEGqnGKklEGEfp7qwfIwrN+DaqEY9WzyOMOEp4cQUAyBuAsRVihhi55hDeHn2S3A/9Ewenxv36BmbOmBdnO+LFNHuO7aacGkHyX6Nhmc/XnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FybuTlb2d5hxFIVLpYqAfCAyzLouIGpSCWTjZNyfcT4=;
 b=jd2rU580l2Hp9I7ELUQLw8wzr1zxKa8itxpzZsxDQ39BBkqMDaCnRyqlkmhZxSLKu2mOPXWKY7IqmuGVroCbGeKeFr0PT4XtSqZh8hacBKWo73pA65z2BaXkDnRXOt3lKXC530JVC2R4Jv13+m4bSFHUibo10icb8Sp6pf/E8Ic=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6797.namprd10.prod.outlook.com (2603:10b6:8:13d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 05:36:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:36:24 +0000
Date: Wed, 13 Aug 2025 06:36:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 02/15] perf: Split out mlock limit handling
Message-ID: <254095d7-93f4-4994-b457-906579a066cd@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104018.541975109@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104018.541975109@infradead.org>
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b13beac-cfef-4882-a77e-08ddda2b5796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+JaErjXA/4dv3y+o2r693VpisaYqhykSlCPHi0J9KD/9L+I+BipTuEO3fnau?=
 =?us-ascii?Q?bpAyGdLZsNcS2+ahY+TkO8ZdMuI663qvY76Ud/qZMVImhtuQVtLNR6BivNEj?=
 =?us-ascii?Q?ZxVLsFW+Vcn46D8+is4pZVZYVAu3AMwmFi/+/bfXVEMmMuXW5jQQRlCZjZuw?=
 =?us-ascii?Q?eXX/co/0Iz4IP9nLAuPlVeFww/srQTkZY7k26tvwsmcxcaDpzPGixDKVEzBS?=
 =?us-ascii?Q?5aE62hFFsT6m0bSzMV8OMs1LFH4I2gTJezVvJ2vH+/1v0DbH9jqzMmDpwy2q?=
 =?us-ascii?Q?oInBnlau5WAyKi4GXWkxYa1Tha1Qtho/UvJsffbVC3GIb3DyiYqGsBHRwq/F?=
 =?us-ascii?Q?oAE2TxmekTzQoAuKi38oOT7CUUg9WAHuHO1ZcBAPB9tfxw6j0xNbsbhTka2b?=
 =?us-ascii?Q?qp/VBukdfs+4UsRPbGZjZ9e7ixqHKOzdLhbCEwPsk++Y8K0f/dGMDRb7UHql?=
 =?us-ascii?Q?FrW58J8kdZyClKpCHvK7Rayl79FB8z6zdd9xIJY4oN1DEY2DqxseHPO6Y+Mj?=
 =?us-ascii?Q?jkJMMZcUv48Le4A07xSsWN0RZCPlUdd/AKcdKBaWjHtbfz7zZ+bYXRmGgKMj?=
 =?us-ascii?Q?KJ6hNJ83DzYRToyqg8XIX6U9SEdg7/taAODl4vRoP5qgn+TkgB7Pm2MnxuPS?=
 =?us-ascii?Q?j/eDcgDVA7l0VQFxwpGWXG1/h9N/47LNNp3ZS8D2F4yptgurjYic6aFZl4Ca?=
 =?us-ascii?Q?xBQlJhQBgeVElz7IVGKr0PkIOUmib/8n1mWvHinSVpyB+wWmUkHu2oVBPqBL?=
 =?us-ascii?Q?hgCSFuAV5Vz0xxJ334inYM013VQDcqr9KLzHzifK+WyidBptlMKMajAUZDgb?=
 =?us-ascii?Q?i+HbAfusGJtU9tYIvYGaE+Cy6BgyoPm4ForD7qaEIqEk2UcoBJSaj9/DL7Vd?=
 =?us-ascii?Q?HTLG9zxegFfp7z4x2KS+W5OCSgA95kmx0CTSZ2tDekjJ4vF7882HTgJIbcOn?=
 =?us-ascii?Q?4foDpZ6vA6Y7XUWZnri3IwrerTj1HSiMOCDhA31XuoJiSBmjqYGpT0rzp96G?=
 =?us-ascii?Q?z1rf+zD5wVTyuvZM1cqkXBoXiungll1YcZVibMvHhtFi6uzx6HO1I54HjVLm?=
 =?us-ascii?Q?nL0Qo/qdjKOy79eWTZmPNc4YJcFDTeezaMiHajzlwMt7JW4fPBJWGAkEzXvf?=
 =?us-ascii?Q?6AElSz99OEZkos3kudfI3FOoTDh/i2zc4xqmXrEFVP56ooXUofMByJn17Bt9?=
 =?us-ascii?Q?Z+qFPc7KfnE1qOAQ142Q46w5OsKopNSUpzwA7tKqAo3YROFVM+ogdycuoLz2?=
 =?us-ascii?Q?HIpO8rVnnvXUGn/RBw/X6eIbsUv8HJDjBX/VfUlqELZSzI7j7o7Zq7EkFEK1?=
 =?us-ascii?Q?+aEnFUXHb7oLfgxdRCrbYEo3juzrfMQ6V07uROALJ0y8rEC0qJOI2uUPxXVN?=
 =?us-ascii?Q?sam1Y9KXvYvh0juAkifsukRAK/e+R9RNjkN23FBoAGwqJfHuRcldb0MMQEv2?=
 =?us-ascii?Q?Ihon6lbUkts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9SBDz/ZHvZDPYOX1cAj+3seJyXVXOnqQnOLb0Lu3siGEcazpYggbAk450iq8?=
 =?us-ascii?Q?AtwZNX0PZdx2GGseOapykovRiyfv1Wouhu/2DKxkhZiLyG4fSPDpQtkgCcpX?=
 =?us-ascii?Q?uRpBSPCN/z+8ZDRiKo+riFsPKQ1wdrb/QGHzj9l+ES87KQVsWZeIADfnKcEi?=
 =?us-ascii?Q?R1PirdA0bQ5schJEdHgkj919h/9yZzuLzJs2M2JJ6b+AY652+tSNPTt3GDkz?=
 =?us-ascii?Q?A2pvm946mo3WG8JMxKQU6lut4cEUnpwVi2z+L1YSQs1xqjFZzMj7OIOCNhMa?=
 =?us-ascii?Q?P8c5L6tWHn/vbIhVcPDeEROk1tiR8HX2YVKFVCIZOzJnbBpAoNFqHIijejda?=
 =?us-ascii?Q?zIzXUH8h8ISx2f6PwALGWORA2sKkp7VbFwU+SakcH2n1gcte1jnleJYlkWTw?=
 =?us-ascii?Q?rtd77FAwRg5GUU/M0fVz0Zn7haIebvKJ8UpgKGuT/F1xYP1Nr1W03hdhcBz7?=
 =?us-ascii?Q?fAl4VZwjvuD7JykTbfQq2D/ZiuNCXTkmH3JrKShiTAKRHbyAUi7Q+/d9BWu7?=
 =?us-ascii?Q?qiroyaaOhEDkCxtr01DP0vaA4eVNEa/YQYab0TvWvH8WozxSmgieMzfyK2yE?=
 =?us-ascii?Q?cLhMnbLsem7tfgLy4Ae8ScgYSmP+MWev5s9peG+N0cFx7SIIuvo32Gob43bT?=
 =?us-ascii?Q?qb5UY2fIUtN7McXpULVh6LdXQ9Zt4BmAgReqrrYD54kQN5+2PvmJIu0QJVBt?=
 =?us-ascii?Q?6hyhKibM3ak090wXMY4a2ZQVttD8Cm6+LRNXFqp3zspWAEGD6RJAnYCtCgp0?=
 =?us-ascii?Q?AZkzZGwi6BejLss2PuRazngomjJ/qShN+wPCd7Z/L/yLlRFFCORZLdqjufmV?=
 =?us-ascii?Q?aSbhi17YWc5iQKhNweA5XIwkD1w7YczsGywvJGtC7Fwagn91XCTeRalSYwug?=
 =?us-ascii?Q?K3jnWFkXWH6OeHuiZm1xyoDYZtkKHwvY3k/kLDTGcd0NHxwSGjgLliHaZ6H5?=
 =?us-ascii?Q?c5h0fra0MPOaKKMlazjdBagyLmgHo8IB+mzbyV9jpNgKKyZmHv7YHE6FRVLk?=
 =?us-ascii?Q?NKjOLjr9JqhdlPRvpauMjfjfOjnTamcNR9xzIyudhuC/5tujgW5u5EM+HhuJ?=
 =?us-ascii?Q?7blmWriEPwHYElNrxkRlY0admLUtesGPUQzvgwVfxqcFScx7F5alw8Irm0Ol?=
 =?us-ascii?Q?dh+Bc6+w49nkAM+KC14UYxpHD1ys8rqasAzyzvhq3NRbwQ7jDDqPJ69QA6tR?=
 =?us-ascii?Q?bVXNJLhq81WvCt4BShxXwO5Y3FPFabs960UmxXjIgclzW9F5E6u1LDqrvy69?=
 =?us-ascii?Q?z1wUgHY/E0eCfa6ZjdocpRA0a/tEIswOG/yCP394zgiaK++0RYiFICjEDhpR?=
 =?us-ascii?Q?HTdXdywdDP4Svt2kWSRu4O5ECHqfx942Ui8eZGvyrjZfFEVHVo4Y//Ep3wKY?=
 =?us-ascii?Q?Z6UH+PqMN0slAXtM9e/xfPQLydaFuz65Y8cgQee+AI0VoLNzfDCxqvW/l3W4?=
 =?us-ascii?Q?8QNpaIqJeyydmzj1cDMDDWdTqqnvIQN0DiONpQyd204ZGpuhOP4Hrg46rv66?=
 =?us-ascii?Q?Jyc7FhZ+nuRPrRHfRT+1vVIm2qwRmiNZhBWlv+kBPe1VGYP7fI3eX/bPcUzk?=
 =?us-ascii?Q?310JEquS3cEosE3oeR1CE4ja3c545GkUzgBHg9ld+aVku0h17gX6ZZz8gFAS?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CpRUa5wUEnJw/pYNtMdxLphkJMf4pSnKh3x8pbDWTF1gZI56strn11Vp/WCRm+re2HIMqW6vDoXf05eYbXslbKKRqFycCD9MwR28FURCT3IAhJNdn7SnGTDLm/J4qZ+00g/AcM2HQZrRTDLZ1+djd/hIjXPJF+Ce2q/inP2AUEkZKTLuvaZWnx2Xerd1B+IyPVXUjJZn5GbQbQ8pdO7yXPNPY1sD7O23P3wuasYWFSQvNLvMNDrljEAC6zSRK6U8PJBWtwAUX2wDOOthdsV6aUpZos/fBmu0An7fmyoRUFSDekwdBkd1wENt8WqJQJfAX3Ec4kNpCEB86BVWKYmv8nynOzL3RYvi8V9QDeoexUkrUNShYICykQZ9HHn3izzss4ULWu13twpQpiV66VHqOMv7hAt2Mn1VfeHMu20nvqJ9b0fYKbkpbnfrfSFVPaZ264LtyIklrSF0kz+N5yr9GQBVWEnKuUR60WXnh8wYcUmsNDfgs9KhUQ5xjNh3Rb6uSHlFHpcmYYDSN3t3jTEPHTI3jgKeFgdpEWO5wFEXcGoUi8iO6vmnqeiFdxs4IMCps4iox6LpFp4FxLZGgwkdP01mTpSHs59x1I9h/ZPh5c0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b13beac-cfef-4882-a77e-08ddda2b5796
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:36:24.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLcCD5nac3SLswA5nsWPFO1Aa/LzgoioyXvGJEnyX/SkxQEoZG7sQkyC24r3LkoobqoTfoNgyLpLAVsSGz8/bxniXvPbIZ5z3M1RQ0V2RQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130052
X-Proofpoint-ORIG-GUID: lNVc1nr7DIKtM50WXMKvetUDTswCr63x
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689c245c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=NaCgsDVjFS3P7sG25WAA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13600
X-Proofpoint-GUID: lNVc1nr7DIKtM50WXMKvetUDTswCr63x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1MiBTYWx0ZWRfXzbBarnpg0Vfr
 zLYlQ+sfGBhvpMVTlf8ZY6cc50KA9JOPKyyPCA2NDxa4zg/KDhsArmyuFgmHtXPneu9XuwUOcpK
 ci6QZZYKMt6lshFXNjiWJrKqOZBcZ2kKDOWeQ6S/MOcz14gLZCbVm8CqS2p9RlYM35gyeRyn484
 MLDOQaxcraKlEgaEDXpAgm32KToMjuY4Y5PlBlbeoRQXsbmHKMM7DiI0sWEx+zyuVkGMeZ7xih5
 DIb7aQADIFmOAeTGvle4xTT6WPiFEHc69BNq9E1l075dWzFmg3e30athBXoSmGVOAsqrYeYgk+l
 n9diUQEOXVUVQigfVZzxXJjBzvJ/dGIK9erQAI61+rr9SAdaIcOXjDDeyNJz9bJd7oMNbWbJour
 KWVd6o31fbfiJAZlAbfzdJ+Va742SVek/HEB2lOUzwnvmy5m8SNG1TLQjL4gwHcDsENlXAOB

On Tue, Aug 12, 2025 at 12:39:00PM +0200, Peter Zijlstra wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> To prepare for splitting the buffer allocation out into seperate functions

NIT: Same comment as 1/2, seperate -> separate, again doesn't hugely matter
but just FYI!

> for the ring buffer and the AUX buffer, split out mlock limit handling into
> a helper function, which can be called from both.
>
> No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Link: https://lkml.kernel.org/r/20250811070620.463634790@linutronix.de
> ---
>  kernel/events/core.c |   77 +++++++++++++++++++++++++--------------------------
>  1 file changed, 38 insertions(+), 39 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6927,17 +6927,49 @@ static int map_range(struct perf_buffer
>  	return err;
>  }
>
> +static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra, long *extra)
> +{
> +	unsigned long user_locked, user_lock_limit, locked, lock_limit;
> +	struct user_struct *user = current_user();
> +
> +	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
> +	/* Increase the limit linearly with more CPUs */
> +	user_lock_limit *= num_online_cpus();
> +
> +	user_locked = atomic_long_read(&user->locked_vm);
> +
> +	/*
> +	 * sysctl_perf_event_mlock may have changed, so that
> +	 *     user->locked_vm > user_lock_limit
> +	 */
> +	if (user_locked > user_lock_limit)
> +		user_locked = user_lock_limit;
> +	user_locked += *user_extra;
> +
> +	if (user_locked > user_lock_limit) {
> +		/*
> +		 * charge locked_vm until it hits user_lock_limit;
> +		 * charge the rest from pinned_vm
> +		 */
> +		*extra = user_locked - user_lock_limit;
> +		*user_extra -= *extra;
> +	}
> +
> +	lock_limit = rlimit(RLIMIT_MEMLOCK);
> +	lock_limit >>= PAGE_SHIFT;
> +	locked = atomic64_read(&vma->vm_mm->pinned_vm) + *extra;
> +
> +	return locked <= lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOCK);
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
> -	unsigned long user_locked, user_lock_limit;
>  	struct user_struct *user = current_user();
> +	unsigned long vma_size, nr_pages;
> +	long user_extra = 0, extra = 0;
>  	struct mutex *aux_mutex = NULL;
>  	struct perf_buffer *rb = NULL;
> -	unsigned long locked, lock_limit;
> -	unsigned long vma_size;
> -	unsigned long nr_pages;
> -	long user_extra = 0, extra = 0;
>  	int ret, flags = 0;
>  	mapped_f mapped;
>
> @@ -7063,38 +7093,7 @@ static int perf_mmap(struct file *file,
>  		}
>  	}
>
> -	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
> -
> -	/*
> -	 * Increase the limit linearly with more CPUs:
> -	 */
> -	user_lock_limit *= num_online_cpus();
> -
> -	user_locked = atomic_long_read(&user->locked_vm);
> -
> -	/*
> -	 * sysctl_perf_event_mlock may have changed, so that
> -	 *     user->locked_vm > user_lock_limit
> -	 */
> -	if (user_locked > user_lock_limit)
> -		user_locked = user_lock_limit;
> -	user_locked += user_extra;
> -
> -	if (user_locked > user_lock_limit) {
> -		/*
> -		 * charge locked_vm until it hits user_lock_limit;
> -		 * charge the rest from pinned_vm
> -		 */
> -		extra = user_locked - user_lock_limit;
> -		user_extra -= extra;
> -	}
> -
> -	lock_limit = rlimit(RLIMIT_MEMLOCK);
> -	lock_limit >>= PAGE_SHIFT;
> -	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
> -
> -	if ((locked > lock_limit) && perf_is_paranoid() &&
> -		!capable(CAP_IPC_LOCK)) {
> +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
>  		ret = -EPERM;
>  		goto unlock;
>  	}
>
>

